{
    This file is part of Dev-C++
    Copyright (c) 2004 Bloodshed Software

    Dev-C++ is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Dev-C++ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Dev-C++; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

unit debugger;

interface
uses Sysutils, Windows, Classes, ShellAPI, Dialogs, Controls,
  debugreader, debugwait, version, editor, ComCtrls;

type
  TGdbBreakpoint = class
  public
    Index: integer;
    Editor: TEditor;
    Line: integer;
  end;

  TDebugger = class
    constructor Create;
    destructor Destroy; override;
  private
    fIncDirs: string;
    function GetCallStack: TList;
    function GetWatchValue: string;
    function GetWatchVar: string;
  published
    property CallStack: TList read GetCallStack;
    property WatchVar: string read GetWatchVar;
    property WatchValue: string read GetWatchValue;

  public
    FileName: string;
    Executing: boolean;
    DebugTree: TTreeView;
    BreakList: TList;
    InAssembler: boolean;
    Registers: TRegisters;
    OnRegistersReady: procedure of object;

    procedure Execute;
    procedure SendCommand(command, params: string);
    procedure AddBreakpoint(editor: TEditor; line: integer);
    procedure RemoveBreakpoint(editor: TEditor; line: integer);
    procedure ClearBreakpoints;
    procedure RemoveAllBreakpoints;
    procedure RefreshContext(); // tries to display variable considered not in current context
    procedure CloseDebugger(Sender: TObject);
    procedure AddIncludeDir(s: string);
    procedure ClearIncludeDirs;
    function Idle: boolean;
    function IsIdling: boolean;

  protected
    hInputWrite: THandle;
    hOutputRead: THandle;
    //    hStdIn      : THandle; // Handle to parents std input.
    hPid: THandle; // GDB process id
    Reader: TDebugReader;
    Wait: TDebugWait;
    EventReady: THandle;
    Breakpoints: TList;
    GdbBreakCount: integer;

    procedure DisplayError(s: string);
    procedure Launch(hChildStdOut, hChildStdIn,
      hChildStdErr: THandle);
    procedure OnDebugFinish(Sender: TObject);
    procedure OnNoDebuggingSymbolsFound;
    procedure OnSourceMoreRecent;
    procedure OnAsmCode(s: string);
    procedure OnAsmFunc(s: string);
    procedure OnAsmCodeEnd;
    procedure OnSegmentationFault;

  end;

implementation
uses main, devcfg, MultiLangSupport, cpufrm, prjtypes, StrUtils;

constructor TDebugger.Create;
begin
  EventReady := CreateEvent(nil, false, false, nil);
  Executing := false;
  FileName := '';
  GdbBreakCount := 1;
  BreakList := TList.Create;
  fIncDirs := '';
  InAssembler := false;
end;

destructor TDebugger.Destroy;
var i : integer;
begin
  for i := 0 to BreakList.Count - 1 do
    TGdbBreakpoint(BreakList[I]).Free;
  BreakList.Free;
  if (Executing) then
    CloseDebugger(nil);
  CloseHandle(EventReady);
  inherited Destroy;
end;

function TDebugger.Idle: boolean;
var i : integer;
begin
  i := 0;
  result := false;
  while not Reader.Idling do begin
    Sleep(20);
    //    Application.ProcessMessages;
    i := i + 1;
    if (i = 200) then begin
      MessageDlg('Wait timeout for debug command', mtError, [mbOK], 0);
      Reader.Idling := True;
      result := true;
    end;
  end;
end;

function TDebugger.IsIdling: boolean;
begin
  result := Reader.Idling;
end;

procedure TDebugger.Execute;
var
  hOutputReadTmp, hOutputWrite,
    hInputWriteTmp, hInputRead,
    hErrorWrite: THandle;
  sa: TSecurityAttributes;
begin
  Executing := true;
  // Set up the security attributes struct.
  sa.nLength := sizeof(TSecurityAttributes);
  sa.lpSecurityDescriptor := nil;
  sa.bInheritHandle := true;
  // Create the child output pipe.
  if (not CreatePipe(hOutputReadTmp, hOutputWrite, @sa, 0)) then
    DisplayError('CreatePipe');
  // Create a duplicate of the output write handle for the std error
  // write handle. This is necessary in case the child application
  // closes one of its std output handles.
  if (not DuplicateHandle(GetCurrentProcess(), hOutputWrite,
    GetCurrentProcess(), @hErrorWrite, 0,
    true, DUPLICATE_SAME_ACCESS)) then
    DisplayError('DuplicateHandle');

  // Create the child input pipe.
  if (not CreatePipe(hInputRead, hInputWriteTmp, @sa, 0)) then
    DisplayError('CreatePipe');

  // Create new output read handle and the input write handles.
  // The Properties are set to FALSE, otherwise the child inherits the
  // properties and as a result non-closeable handles to the pipes
  // are created.
  if (not DuplicateHandle(GetCurrentProcess(), hOutputReadTmp,
    GetCurrentProcess(), @hOutputRead, // Address of new handle.
    0, false, // Make it uninheritable.
    DUPLICATE_SAME_ACCESS)) then
    DisplayError('DuplicateHandle');

  if (not DuplicateHandle(GetCurrentProcess(), hInputWriteTmp,
    GetCurrentProcess(), @hInputWrite, // Address of new handle.
    0, false, // Make it uninheritable.
    DUPLICATE_SAME_ACCESS)) then
    DisplayError('DupliateHandle');
  // Close inheritable copies of the handles you we not want to be
  // inherited.
  if (not CloseHandle(hOutputReadTmp)) then
    DisplayError('CloseHandle');
  if (not CloseHandle(hInputWriteTmp)) then
    DisplayError('CloseHandle');

  // Get std input handle so we can close it and force the ReadFile to
  // fail when you want the input thread to exit.
//  hStdIn := GetStdHandle(STD_INPUT_HANDLE);
//  if (hStdIn = INVALID_HANDLE_VALUE) then
//    DisplayError('GetStdHandle');

  Launch(hOutputWrite, hInputRead, hErrorWrite);

  // Close pipe handles (do not continue to modify the parent).
  // Make sure that no handles of the
  // output pipe are maintained in this process or else the pipe will
  // not close when the child process exits and the ReadFile will hang.
  if (not CloseHandle(hOutputWrite)) then
    DisplayError('CloseHandle');
  if (not CloseHandle(hInputRead)) then
    DisplayError('CloseHandle');
  if (not CloseHandle(hErrorWrite)) then
    DisplayError('CloseHandle');

  Reader := TDebugReader.Create(true);
  // Create a thread that will notice when an output is ready to be analyzed
  Wait := TDebugWait.Create(true);
  Wait.OnNoDebuggingSymbols := OnNoDebuggingSymbolsFound;
  Wait.OnSourceMoreRecent := OnSourceMoreRecent;
  Wait.OnAsmCode := OnAsmCode;
  Wait.OnAsmFunc := OnAsmFunc;
  Wait.OnAsmCodeEnd := OnAsmCodeEnd;
  Wait.OnSegmentationFault := OnSegmentationFault;
  Wait.Event := EventReady;
  Wait.DebugTree := DebugTree;
  Wait.Registers := @Registers;
  Wait.OnTerminate := OnDebugFinish;
  Wait.FreeOnTerminate := true;
  Wait.Reader := Reader;
  Wait.Resume;

  // Create a thread that will read the child's output.
  Reader.hPipeRead := hOutputRead;
  Reader.EventReady := EventReady;
  Reader.OnTerminate := CloseDebugger;
  Reader.FreeOnTerminate := true;
  Reader.Idling := true;
  Reader.Resume;
end;

procedure TDebugger.DisplayError(s: string);
begin
  MessageDlg('Error with debugging process : ' + s, mtError, [mbOK], 0);
end;

procedure TDebugger.Launch(hChildStdOut, hChildStdIn,
  hChildStdErr: THandle);
var
  pi: TProcessInformation;
  si: TStartupInfo;
  gdb: string;
begin
  // Set up the start up info struct.
  FillChar(si, sizeof(TStartupInfo), 0);
  si.cb := sizeof(TStartupInfo);
  si.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
  si.hStdOutput := hChildStdOut;
  si.hStdInput := hChildStdIn;
  si.hStdError := hChildStdErr;
  si.wShowWindow := SW_HIDE;

  if (devCompiler.gdbName <> '') then
    gdb := devCompiler.gdbName
  else
    gdb := GDB_PROGRAM;
  // Launch process
  if (not CreateProcess(nil,
    pchar(gdb + ' --annotate=2 --silent ' + fIncDirs), nil, nil, true,
                        CREATE_NEW_CONSOLE, nil, nil, si, pi)) then begin
    DisplayError('Could not find program file ' + gdb);
    exit;
  end;
  hPid := pi.hProcess;
  // Close any unnecessary handles.
  if (not CloseHandle(pi.hThread)) then
    DisplayError('CloseHandle');
end;

procedure TDebugger.CloseDebugger(Sender: TObject);
begin
  if Executing then begin
    Executing := false;
    // Force the read on the input to return by closing the stdin handle.
    //  if (not CloseHandle(hStdIn)) then
    //    DisplayError('CloseHandle - stdin');
    Wait.Stop := True;
    SetEvent(EventReady);
    TerminateProcess(hPid, 0);
    Wait.Terminate;
    Reader.Terminate;
    Reader := nil;
    Wait := nil;
    if (not CloseHandle(hPid)) then
      DisplayError('CloseHandle - gdb process');
    if (not CloseHandle(hOutputRead)) then
      DisplayError('CloseHandle - output read');
    if (not CloseHandle(hInputWrite)) then
      DisplayError('CloseHandle - input write');
    MainForm.RemoveActiveBreakpoints;
  end;
end;

procedure TDebugger.SendCommand(command, params: string);
var
  s: array[0..512] of char;
  nBytesWrote: DWORD;
  i, j: integer;
begin
  //  CurrentCommand := command;
  Reader.Idling := False;
  i := 0;
  while i < length(command) do begin
    s[i] := command[i + 1];
    i := i + 1;
  end;
  s[i] := ' ';
  i := i + 1;
  j := 0;
  while (j < length(params)) do begin
    s[i] := params[j + 1];
    i := i + 1;
    j := j + 1;
  end;
  s[i] := #10;
  s[i + 1] := #0;
  if (not WriteFile(hInputWrite, s, strlen(s), nBytesWrote, nil)) then begin
    if (GetLastError() = ERROR_NO_DATA) then
      //showmessage('Debug finished') //Pipe was closed (normal exit path).
    else
      DisplayError('WriteFile');
  end;
  if Assigned(OnRegistersReady) then
    OnRegistersReady;
  //  Idle;
end;

procedure TDebugger.OnDebugFinish(Sender: TObject);
begin
  if Executing then
    CloseDebugger(sender);
end;

procedure TDebugger.OnNoDebuggingSymbolsFound;
var
  opt: TCompilerOption;
  idx: integer;
  spos: integer;
  opts: TProjOptions;
begin
  CloseDebugger(nil);
  if (MessageDlg(Lang[ID_MSG_NODEBUGSYMBOLS], mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
    if devCompiler.FindOption('-g3', opt, idx) then begin
      opt.optValue := 1;
      if not Assigned(MainForm.fProject) then
        devCompiler.Options[idx]:=opt; // set global debugging option only if not working with a project

      MainForm.SetProjCompOpt(idx, True); // set the project's correpsonding option too

      // remove "-s" from the linker''s command line
      if Assigned(MainForm.fProject) then begin
        opts := MainForm.fProject.Options;
        // look for "-s" in all the possible ways
        // NOTE: can't just search for "-s" because we might get confused with
        //       some other option starting with "-s...."
        spos := Pos('-s ', opts.cmdLines.Linker); // following more opts
        if spos = 0 then
          spos := Pos('-s'#13, opts.cmdLines.Linker); // end of line
        if spos = 0 then
          spos:=Pos('-s_@@_', opts.cmdLines.Linker); // end of line (dev 4.9.7.3+)
        if (spos = 0) and
          (Length(opts.cmdLines.Linker) >= 2) and // end of string
           (Copy(opts.cmdLines.Linker, Length(opts.cmdLines.Linker)-1, 2) = '-s') then
          spos := Length(opts.cmdLines.Linker) - 1;
        // if found, delete it
        if spos>0 then begin
          Delete(opts.cmdLines.Linker, spos, 2);
          MainForm.fProject.Options := opts;
        end;
      end;
      if devCompiler.FindOption('-s', opt, idx) then begin
        opt.optValue := 0;
        if not Assigned(MainForm.fProject) then
          devCompiler.Options[idx]:=opt; // set global debugging option only if not working with a project
        MainForm.SetProjCompOpt(idx, False); // set the project's correpsonding option too
      end;
      MainForm.actRebuildExecute(nil);
    end;
  end;
end;

procedure TDebugger.OnSourceMoreRecent;
begin
  if (MessageDlg(Lang[ID_MSG_SOURCEMORERECENT], mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
    CloseDebugger(nil);
    MainForm.actCompileExecute(nil);
  end;
end;

procedure TDebugger.OnSegmentationFault;
begin
  MessageDlg(Lang[ID_MSG_SEGFAULT], mtWarning, [mbOk], 0);
end;

procedure TDebugger.AddBreakpoint(editor: TEditor; line: integer);
var b : TGdbBreakpoint;
begin
  SendCommand(GDB_BREAK, '"' + editor.TabSheet.Caption + ':' + inttostr(line) + '"');
  //SendCommand(GDB_BREAK, '"' + editor.FileName + ':' + inttostr(line) + '"');
  b := TGdbBreakpoint.Create;
  b.Index := GdbBreakCount;
  b.Editor := editor;
  b.Line := Line;
  BreakList.Add(b);
  inc(GdbBreakCount);
end;

procedure TDebugger.RemoveBreakpoint(editor: TEditor;
  line: integer);
var
  I: integer;
begin
  for I := 0 to BreakList.Count - 1 do
    if (TGdbBreakpoint(BreakList[I]).Editor = editor) and
       (TGdbBreakpoint(BreakList[I]).line = line) then begin
      if Executing then
        SendCommand(GDB_DELETE, inttostr(I + 1));
      TGdbBreakpoint(BreakList[I]).Free;
      BreakList.Delete(I);
      dec(GdbBreakCount);
      Break;
    end;
end;

procedure TDebugger.RemoveAllBreakpoints;
var
  I: integer;
begin
  for I := 0 to BreakList.Count - 1 do begin
    if Executing then
      SendCommand(GDB_DELETE, inttostr(I + 1));
    BreakList.Delete(I);
    dec(GdbBreakCount);
  end;
  ClearBreakpoints;
end;

procedure TDebugger.ClearBreakpoints;
begin
  BreakList.Clear;
end;

function TDebugger.GetCallStack: TList;
begin
  if Assigned(Wait) then
    Result := Wait.CallStackList
  else
    Result := nil;
end;

procedure TDebugger.AddIncludeDir(s: string);
begin
  if DirectoryExists(s) then
    fIncDirs := fIncDirs + ' --directory=' + s + ' ';
end;

procedure TDebugger.ClearIncludeDirs;
begin
  fIncDirs := '';
end;

procedure TDebugger.OnAsmCode(s: string);
begin
  if Assigned(CPUForm) then begin
    CPUForm.CodeList.Lines.Add(s);
  end;
end;

procedure TDebugger.OnAsmFunc(s: string);
begin
  if Assigned(CPUForm) then begin
    CPUForm.CodeList.ClearAll;
    CPUForm.edFunc.Text := s;
  end;
  InAssembler := true;
end;

procedure TDebugger.OnAsmCodeEnd;
begin
  InAssembler := false;
end;

function TDebugger.GetWatchValue: string;
begin
  if Assigned(Wait) then
    Result := Wait.tmpWatchValue
  else
    Result := '';
end;

function TDebugger.GetWatchVar: string;
begin
  if Assigned(Wait) then
    Result := Wait.tmpWatchVar
  else
    Result := '';
end;

procedure TDebugger.RefreshContext;
var i, k : integer;
  s: string;
begin
  if not Executing then
    exit;
  if Assigned(MainForm.DebugTree) then
    for i := 0 to DebugTree.Items.Count - 1 do begin
      k := AnsiPos(' = Not found in current context', DebugTree.Items[i].Text);
       if k > 0 then begin
        s := DebugTree.Items[i].Text;
        Delete(s, k, length(s) - k + 1);
        SendCommand(GDB_DISPLAY, s);
      end;
    end;
end;

end.
