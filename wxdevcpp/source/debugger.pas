{
    $Id$
    
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

uses
  Sysutils, Classes, debugwait, version, editor,
{$IFDEF WIN32}
  Windows, ShellAPI, Dialogs, Controls, ComCtrls;
{$ENDIF}
{$IFDEF LINUX}
  QDialogs, QControls, QComCtrls;
{$ENDIF}

type
  AssemblySyntax = (asATnT, asIntel);
  ContextData = (cdLocals, cdCallStack, cdWatches, cdThreads, cdDisassembly, cdRegisters);
  ContextDataSet = set of ContextData;
  TCallback = procedure(Output: TStringList) of object;
  
  TRegisters = class
    EAX: string;
    EBX: string;
    ECX: string;
    EDX: string;
    ESI: string;
    EDI: string;
    EBP: string;
    ESP: string;
    EIP: string;
    EFLAGS: string;
    CS: string;
    DS: string;
    SS: string;
    ES: string;
    GS: string;
    FS: string;
  end;
  TRegistersCallback = procedure(Registers: TRegisters) of object;
  TString = class
  public
    Str: string;
    constructor Create(AStr: string);
  end;

  PBreakpoint = ^TBreakpoint;
  TBreakpoint = class
  public
    Index: Integer;
    Valid: Boolean;
    Editor: TEditor;
    Filename: string;
    Line: Integer;
  end;

  PStackFrame = ^TStackFrame;
  TStackFrame = packed record
    Filename: string;
    Line: integer;
    FuncName: string;
    Args: string;
  end;

  PVariable = ^TVariable;
  TVariable = packed record
    Name: string;
    Value: string;
    Location: string;
  end;

  PWatch = ^TWatch;
  TWatchBreakOn = (wbRead, wbWrite, wbBoth);
  TWatch = packed record
    Name: string;
    Address: string;
    BreakOn: TWatchBreakOn;
    ID: Integer;
  end;

  PDebuggerThread = ^TDebuggerThread;
  TDebuggerThread = packed record
    Active: Boolean;
    Index: String;
    ID: String;
  end;

  PCommand = ^TCommand;
  TCommand = class
  public
    Data: TObject;
    Command: String;
    Callback: procedure of object;
    OnResult: procedure(Output: TStringList) of object;
  end;

  PCommandWithResult = ^TCommandWithResult;
  TCommandWithResult = class(TCommand)
  public
    constructor Create;
    destructor Destroy; override;
  public
    Event: THandle;
    Result: TStringList;
  end;

  TDebugger = class
    constructor Create; virtual;
    destructor Destroy; override;

  protected
    fBusy: Boolean;
    fPaused: Boolean;
    fExecuting: Boolean;
    fDebugTree: TTreeView;
    fNextBreakpoint: Integer;
    IncludeDirs: TStringList;
    IgnoreBreakpoint: Boolean;
    JumpToCurrentLine: Boolean;

    hInputWrite: THandle;
    hOutputRead: THandle;
    hPid: THandle;
    
    SentCommand: Boolean;
    CurrentCommand: TCommand;
    CommandQueue: TList;

    FileName: string;
    Event: THandle;
    Wait: TDebugWait;
    Reader: TDebugReader;
    CurOutput: TStringList;

    procedure DisplayError(s: string);
    function GetBreakpointFromIndex(index: integer): TBreakpoint;

    procedure OnOutput(Output: string); virtual; abstract;
    procedure Launch(commandline: string; startupdir: string = '');
    procedure SendCommand; virtual;

    //Instruction callbacks
    procedure OnGo;

    //Common events
    procedure OnNoDebuggingSymbolsFound;
    procedure OnAccessViolation;
    procedure OnBreakpoint;

  published
    property Busy: Boolean read fBusy;
    property Executing: Boolean read fExecuting;
    property Paused: Boolean read fPaused;
    property DebugTree: TTreeView read fDebugTree write fDebugTree;

  public
    //Callback functions
    OnVariableHint: procedure(Hint: string) of object;
    OnDisassemble: procedure(Disassembly: string) of object;
    OnRegisters: procedure(Registers: TRegisters) of object;
    OnCallStack: procedure(Callstack: TList) of object;
    OnThreads: procedure(Threads: TList) of object;
    OnLocals: procedure(Locals: TList) of object;

    //Debugger basics
    procedure Attach(pid: integer); virtual; abstract;
    procedure Execute(filename, arguments: string); virtual; abstract;
    procedure CloseDebugger(Sender: TObject); virtual;
    procedure SetAssemblySyntax(syntax: AssemblySyntax); virtual; abstract;
    procedure QueueCommand(command, params: String); overload; virtual;
    procedure QueueCommand(command: TCommand); overload; virtual;

    //Breakpoint handling
    procedure AddBreakpoint(breakpoint: TBreakpoint); virtual; abstract;
    procedure RemoveBreakpoint(breakpoint: TBreakpoint); virtual; abstract;
    procedure RemoveAllBreakpoints;
    procedure RefreshBreakpoints;
    procedure RefreshWatches; virtual; abstract;
    procedure RefreshBreakpoint(var breakpoint: TBreakpoint); virtual; abstract;
    function BreakpointExists(filename: string; line: integer): boolean;

    //Debugger control funtions
    procedure Go; virtual; abstract;
    procedure Pause; virtual;
    procedure Next; virtual; abstract;
    procedure Step; virtual; abstract;
    procedure SetThread(thread: Integer); virtual; abstract;
    procedure SetContext(frame: Integer); virtual; abstract;
    function GetVariableHint(name: string): string; virtual; abstract;

    //Source lookup directories
    procedure AddIncludeDir(s: string); virtual; abstract;
    procedure ClearIncludeDirs; virtual; abstract;

    //Variable watches
    procedure RefreshContext(refresh: ContextDataSet = [cdLocals, cdCallStack, cdWatches, cdThreads, cdDisassembly]); virtual; abstract;
    procedure AddWatch(varname: string; when: TWatchBreakOn); virtual; abstract;
    procedure RemoveWatch(varname: string); virtual; abstract;
    procedure ModifyVariable(varname, newvalue: string); virtual; abstract;

    //Low-level stuff
    procedure GetRegisters; virtual; abstract;
    procedure Disassemble; overload;
    procedure Disassemble(func: string); overload; virtual; abstract;
  end;

  TCDBDebugger = class(TDebugger)
    constructor Create; override;
    destructor Destroy; override;

  protected
    LocalsList: TList;
    procedure OnOutput(Output: string); override;

    //Instruction callbacks
    procedure OnTrace;

    //Parser callbacks
    procedure OnBreakpointSet(Output: TStringList);
    procedure OnRefreshContext(Output: TStringList);
    procedure OnVariableHint(Output: TStringList);
    procedure OnDisassemble(Output: TStringList);
    procedure OnCallStack(Output: TStringList);
    procedure OnRegisters(Output: TStringList);
    procedure OnThreads(Output: TStringList);
    procedure OnLocals(Output: TStringList);
    procedure OnDetailedLocals(Output: TStringList);

  public
    //Run the debugger
    procedure Attach(pid: integer); override;
    procedure Execute(filename, arguments: string); override;

    //Set the include paths
    procedure AddIncludeDir(s: string); override;
    procedure ClearIncludeDirs; override;

    //Override the breakpoint handling
    procedure AddBreakpoint(breakpoint: TBreakpoint); override;
    procedure RemoveBreakpoint(breakpoint: TBreakpoint); override;
    procedure RefreshBreakpoint(var breakpoint: TBreakpoint); override;
    procedure RefreshWatches; override;

    //Variable watches
    procedure RefreshContext(refresh: ContextDataSet = [cdLocals, cdCallStack, cdWatches,
                             cdThreads, cdDisassembly, cdRegisters]); override;
    procedure AddWatch(varname: string; when: TWatchBreakOn); override;
    procedure RemoveWatch(varname: string); override;

    //Debugger control
    procedure Go; override;
    procedure Next; override;
    procedure Step; override;
    procedure SetThread(thread: Integer); override;
    procedure SetContext(frame: Integer); override;
    function GetVariableHint(name: string): string; override;

    //Low-level stuff
    procedure GetRegisters; override;
    procedure Disassemble(func: string); overload; override;
  end;

  TGDBDebugger = class(TDebugger)
    constructor Create; override;
    destructor Destroy; override;

  protected
    OverrideHandler: TCallback;
    RegistersFilled: Integer;
    Registers: TRegisters;
    LastWasCtrl: Boolean;
    Started: Boolean;

  protected
    procedure OnOutput(Output: string); override;
    procedure OnSignal(Output: TStringList);
    procedure OnSourceMoreRecent;

    //Instruction callbacks
    procedure OnGo;
    procedure OnTrace;

    //Parser callbacks
    procedure OnRefreshContext(Output: TStringList);
    procedure OnVariableHint(Output: TStringList);
    procedure OnDisassemble(Output: TStringList);
    procedure OnCallStack(Output: TStringList);
    procedure OnRegisters(Output: TStringList);
    procedure OnThreads(Output: TStringList);
    procedure OnLocals(Output: TStringList);
    procedure OnWatchesSet(Output: TStringList);

  public
    //Debugger control
    procedure Execute(filename, arguments: string); override;
    procedure Attach(pid: integer); override;
    procedure CloseDebugger(Sender: TObject); override;

    //Set the include paths
    procedure AddIncludeDir(s: string); override;
    procedure ClearIncludeDirs; override;

    //Override the breakpoint handling
    procedure AddBreakpoint(breakpoint: TBreakpoint); override;
    procedure RemoveBreakpoint(breakpoint: TBreakpoint); override;
    procedure RefreshBreakpoint(var breakpoint: TBreakpoint); override;
    procedure RefreshWatches; override;

    //Variable watches
    procedure RefreshContext(refresh: ContextDataSet = [cdLocals, cdCallStack, cdWatches,
                             cdThreads, cdDisassembly, cdRegisters]); override;
    procedure AddWatch(varname: string; when: TWatchBreakOn); override;
    procedure RemoveWatch(varname: string); override;
    procedure ModifyVariable(varname, newvalue: string); override;

    //Debugger control
    procedure Go; override;
    procedure Next; override;
    procedure Step; override;
    procedure Pause; override;
    procedure SetThread(thread: Integer); override;
    procedure SetContext(frame: Integer); override;
    function GetVariableHint(name: string): string; override;

    //Low-level stuff
    procedure GetRegisters; override;
    procedure Disassemble(func: string); overload; override;
    procedure SetAssemblySyntax(syntax: AssemblySyntax); override;
  end;

var
  Breakpoints: TList;

implementation

uses 
  main, devcfg, MultiLangSupport, cpufrm, prjtypes, StrUtils, dbugintf, RegExpr,
  madExcept, Forms, utils;

function RegexEscape(str: string): string;
begin
  Result := AnsiReplaceStr(str, '[', '\[');
  Result := AnsiReplaceStr(Result, ']', '\]');
  Result := AnsiReplaceStr(Result, '(', '\(');
  Result := AnsiReplaceStr(Result, ')', '\)');
end;

constructor TCommandWithResult.Create;
begin
  Event := CreateEvent(nil, false, false, nil);
  Result := TStringList.Create;
end;

destructor TCommandWithResult.Destroy;
begin
  CloseHandle(Event);
  Result.Free;
end;

constructor TString.Create(AStr: String);
begin
  Str := AStr;
end;

constructor TDebugger.Create;
begin
  CurOutput := TStringList.Create;
  SentCommand := False;
  fExecuting := False;
  fBusy := False;

  JumpToCurrentLine := False;
  CommandQueue := TList.Create;
  IncludeDirs := TStringList.Create;
  FileName := '';
  Event := CreateEvent(nil, false, false, nil);
end;

destructor TDebugger.Destroy;
begin
  CloseDebugger(nil);
  CloseHandle(Event);
  RemoveAllBreakpoints; 

  CurOutput.Free;
  CommandQueue.Free;
  IncludeDirs.Free;
  inherited Destroy;
end;

procedure TDebugger.Launch(commandline: string; startupdir: string);
var
  ProcessInfo: TProcessInformation;
  StartupInfo: TStartupInfo;
  hOutputReadTmp, hOutputWrite,
  hInputWriteTmp, hInputRead,
  hErrorWrite: THandle;
  pStartupDir: PChar;
  sa: TSecurityAttributes;
begin
  fExecuting := True;
  
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

  // Create a thread that will read the child's output.
  Reader := TDebugReader.Create(true);
  Reader.Pipe := hOutputRead;
  Reader.Event := Event;
  Reader.OnTerminate := CloseDebugger;
  Reader.FreeOnTerminate := True;

  // Create a thread that will notice when an output is ready to be sent for processing
  Wait := TDebugWait.Create(true);
  Wait.OnOutput := OnOutput;
  Wait.Reader := Reader;
  Wait.Event := Event;

  // Set up the start up info structure.
  FillChar(StartupInfo, sizeof(TStartupInfo), 0);
  StartupInfo.cb := sizeof(TStartupInfo);
  StartupInfo.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
  StartupInfo.hStdOutput := hOutputWrite;
  StartupInfo.hStdInput := hInputRead;
  StartupInfo.hStdError := hErrorWrite;
  StartupInfo.wShowWindow := SW_HIDE;

  if startupdir <> '' then
    pStartupDir := PChar(startupdir)
  else
    pStartupDir := nil;

  // Launch the process
  if not CreateProcess(nil, PChar(commandline), nil, nil, True, CREATE_NEW_CONSOLE,
                       nil, pStartupDir, StartupInfo, ProcessInfo) then
  begin
    DisplayError('Could not start debugger process (' + commandline + ')');
    Exit;
  end;

  // Get the PID of the new process
  hPid := ProcessInfo.hProcess;

  //Close any unnecessary handles.
  if (not CloseHandle(ProcessInfo.hThread)) then
    DisplayError('CloseHandle');

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

  //Run both wait threads
  Wait.Resume;
  Reader.Resume;
end;

procedure TDebugger.DisplayError(s: string);
begin
  MessageDlg('Error with debugging process: ' + s, mtError, [mbOK], Mainform.Handle);
end;

procedure TDebugger.CloseDebugger(Sender: TObject);
begin
  if Executing then
  begin
    fPaused := false;
    fExecuting := false;

    // First don't let us be called twice. Set the secondary threads to not call
    // us when they terminate
    Reader.OnTerminate := nil;

    // Force the read on the input to return by closing the stdin handle.
    Wait.Stop := True;
    SetEvent(Event);
    TerminateProcess(hPid, 0);
    Wait.Terminate;
    Wait := nil;
    Reader.Terminate;
    Reader := nil;
    
    //Close the handles
    if (not CloseHandle(hPid)) then
      DisplayError('CloseHandle - process handle');
    if (not CloseHandle(hOutputRead)) then
      DisplayError('CloseHandle - output read');
    if (not CloseHandle(hInputWrite)) then
      DisplayError('CloseHandle - input write');
    MainForm.RemoveActiveBreakpoints;
    
    //Clear the command queue
    CommandQueue.Clear;
    CurrentCommand := nil;
  end;
end;

procedure TDebugger.QueueCommand(command, params: String);
var
  Combined: String;
  Cmd: TCommand;
begin
  //Combine the strings to get the final command
  Combined := command;
  if Length(params) > 0 then
    Combined := Combined + ' ' + params;

  //Create the command object
  Cmd := TCommand.Create;
  Cmd.Command := Combined;
  Cmd.Callback := nil;
  QueueCommand(Cmd);
end;

procedure TDebugger.QueueCommand(command: TCommand);
var
  Ptr: PCommand;
begin
  //Copy the object
  New(Ptr);
  Ptr^ := command;
  Command.Command := Command.Command + #10;

  //Add it into our list of commands
  CommandQueue.Add(Ptr);

  //Can we execute the command now?
  if Executing and Paused then
    SendCommand;
end;

procedure TDebugger.SendCommand;
var
  Str: array[0..512] of char;
  nBytesWrote, Copied: DWORD;
  I, CommandLength: UInt;
const
  StrSize = 511;
begin
  //Do we have anything left? Are we paused?
  if (CommandQueue.Count = 0) or (not Paused) or Busy or SentCommand then
    Exit;
  
  //Initialize stuff
  Copied := 0;
  SentCommand := True;
  CurrentCommand := PCommand(CommandQueue[0])^;
  CommandLength := Length(CurrentCommand.Command);

  //Remove the entry from the list
  if not (CurrentCommand is TCommandWithResult) then
    Dispose(CommandQueue[0]);
  CommandQueue.Delete(0);

  //Write the command to the pipe, sequentially
  repeat
    //Copy the current string to as much as our buffer allows
    I := 0;
    while (I < StrSize) and (I + Copied < CommandLength) do
    begin
      Str[I] := CurrentCommand.Command[I + 1 + Copied];
      Inc(I);
    end;

    //Set the last character to be NULL
    Str[I] := #0;

    //Then write the block to the pipe
    if WriteFile(hInputWrite, Str, StrLen(Str), nBytesWrote, nil) then
    begin
      with MainForm.DebugOutput do
        Lines[Lines.Count - 1] := Lines[Lines.Count - 1] + Str;
      Inc(Copied, nBytesWrote);
    end
    else if (GetLastError() <> ERROR_NO_DATA) then
    begin
      DisplayError('WriteFile');
      Break;
    end;
  until Copied >= CommandLength;

  //Call the callback function if we are provided one
  if Assigned(CurrentCommand.Callback) then
    CurrentCommand.Callback;
end;

procedure TDebugger.OnGo;
begin
  fPaused := False;
  fBusy := False;
end;

procedure TDebugger.OnNoDebuggingSymbolsFound;
var
  opt: TCompilerOption;
  idx: integer;
  spos: integer;
  opts: TProjProfile;
begin
  if MessageDlg(Lang[ID_MSG_NODEBUGSYMBOLS], mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    CloseDebugger(nil);
    if devCompiler.CompilerType = ID_COMPILER_MINGW then
    begin
      if devCompiler.FindOption('-g3', opt, idx) then
      begin
        opt.optValue := 1;
        if not Assigned(MainForm.fProject) then
          devCompiler.Options[idx] := opt; // set global debugging option only if not working with a project
        MainForm.SetProjCompOpt(idx, True); // set the project's correpsonding option too

        // remove "-s" from the linker''s command line
        if Assigned(MainForm.fProject) then begin
          opts := MainForm.fProject.CurrentProfile;
          // look for "-s" in all the possible ways
          // NOTE: can't just search for "-s" because we might get confused with
          //       some other option starting with "-s...."
          spos := Pos('-s ', opts.Linker); // following more opts
          if spos = 0 then
            spos := Pos('-s'#13, opts.Linker); // end of line
          if spos = 0 then
            spos := Pos('-s_@@_', opts.Linker); // end of line (dev 4.9.7.3+)
          if (spos = 0) and (Length(opts.Linker) >= 2) and // end of string
             (Copy(opts.Linker, Length(opts.Linker) - 1, 2) = '-s') then
            spos := Length(opts.Linker) - 1;
          
          // if found, delete it
          if spos > 0 then
            Delete(opts.Linker, spos, 2);
        end;

        // remove -s from the compiler options
        if devCompiler.FindOption('-s', opt, idx) then begin
          opt.optValue := 0;
          if not Assigned(MainForm.fProject) then
            devCompiler.Options[idx] := opt; // set global debugging option only if not working with a project
          MainForm.SetProjCompOpt(idx, False); // set the project's correpsonding option too
        end;
      end;
    end
    else if devCompiler.CompilerType in ID_COMPILER_VC then
    begin
      if devCompiler.FindOption('/ZI', opt, idx) then
      begin
        opt.optValue := 1;
        if not Assigned(MainForm.fProject) then
        devCompiler.Options[idx] := opt;
        MainForm.SetProjCompOpt(idx, True);
        MainForm.fProject.CurrentProfile.Linker := MainForm.fProject.CurrentProfile.Linker + '/Debug';
      end;
    end;
    MainForm.Compiler.OnCompilationEnded := MainForm.doDebugAfterCompile;
    MainForm.actRebuildExecute(nil);
  end;
end;

function TDebugger.BreakpointExists(filename: string; line: integer): Boolean;
var
  I: integer;
begin
  Result := False;
  for I := 0 to Breakpoints.Count - 1 do
    if (PBreakpoint(Breakpoints[I])^.Filename = filename) and
       (PBreakpoint(Breakpoints[I])^.Line = line) then
    begin
      Result := true;
      Break;
    end;
end;

procedure TDebugger.RemoveAllBreakpoints;
var
  I: integer;
begin
  for I := 0 to Breakpoints.Count - 1 do
    RemoveBreakpoint(Breakpoints[I]);
end;

procedure TDebugger.RefreshBreakpoints;
var
  I: Integer;
begin
  //Refresh the execution breakpoints
  for I := 0 to Breakpoints.Count - 1 do
    RefreshBreakpoint(PBreakPoint(Breakpoints.Items[I])^);
end;

function TDebugger.GetBreakpointFromIndex(index: integer): TBreakpoint;
var
  I: integer;
begin
  Result := nil;
  for I := 0 to Breakpoints.Count - 1 do
    if PBreakpoint(Breakpoints[I])^.Index = index then
    begin
      Result := PBreakpoint(Breakpoints[I])^;
      Exit;
    end;
end;

procedure TDebugger.OnAccessViolation;
begin
  Application.BringToFront;
  case MessageDlg(Lang[ID_MSG_SEGFAULT], mtError, [mbYes, mbNo, mbAbort], MainForm.Handle) of
    mrNo: Go;
    mrAbort: CloseDebugger(nil);
    mrYes: JumpToCurrentLine := True;
  end;
end;

procedure TDebugger.OnBreakpoint;
begin
  Application.BringToFront;
  case MessageDlg(Lang[ID_MSG_BREAKPOINT], mtError, [mbYes, mbNo, mbAbort], MainForm.Handle) of
    mrNo: Go;
    mrAbort: CloseDebugger(nil);
    mrYes: JumpToCurrentLine := True;
  end;
end;

procedure TDebugger.Disassemble;
begin
  Disassemble('');
end;

function GenerateCtrlCEvent(PGenerateConsoleCtrlEvent: Pointer): DWORD; stdcall;
begin
  Result := 0;
  if PGenerateConsoleCtrlEvent <> nil then
  begin
    asm
      //Call assembly code! We just want to get the console function thingo
      push 0;
      push 0;
      call PGenerateConsoleCtrlEvent;
    end;
    Result := 1;
  end;
end;

procedure TDebugger.Pause;
const
  CodeSize = 1024;
var
  Thread: THandle;
  BytesWritten, ThreadID, ExitCode: DWORD;
  WriteAddr: Pointer;
begin
  WriteAddr := VirtualAllocEx(hPid, nil, CodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
  if WriteAddr <> nil then
  begin
    WriteProcessMemory(hPid, WriteAddr, @GenerateCtrlCEvent, CodeSize, BytesWritten);
    if BytesWritten = CodeSize then
    begin
      //Create and run the thread
      Thread := CreateRemoteThread(hPid, nil, 0, WriteAddr, GetProcAddress(LoadLibrary('kernel32.dll'), 'GenerateConsoleCtrlEvent'), 0, ThreadID);
      if Thread <> 0 then
      begin
        //Wait for its termination
        WaitForSingleObject(Thread, INFINITE);

        //And see if it succeeded
        GetExitCodeThread(Thread, ExitCode);
        if ExitCode <> 0 then
          //We've triggered a breakpoint, so yes, ignore it
          IgnoreBreakpoint := True;

        //Destroy the thread
        CloseHandle(Thread);
      end;
    end;

    //Free the memory we injected
    VirtualFreeEx(hPid, WriteAddr, 0, MEM_RELEASE); // free the memory we allocated
  end;
end;

//------------------------------------------------------------------------------
// TCDBDebugger
//------------------------------------------------------------------------------
constructor TCDBDebugger.Create;
begin
  inherited;
end;

destructor TCDBDebugger.Destroy;
begin
  inherited;
end;

procedure TCDBDebugger.Execute(filename, arguments: string);
const
  InputPrompt = '^([0-9]+):([0-9]+)>';
var
  Executable: string;
  WorkingDir: string;
  Srcpath: string;
  I: Integer;
begin
  //Heck about the breakpoint thats coming.
  IgnoreBreakpoint := True;
  self.FileName := filename;

  //Get the name of the debugger
  if (devCompiler.gdbName <> '') then
    Executable := devCompiler.gdbName
  else
    Executable := DBG_PROGRAM(devCompiler.CompilerType);

  //Create the command line
  Executable := Format('%s -lines -2 -G -n -s -y "%s" "%s" %s', [Executable, ExtractFilePath(filename) +
    ';SRV*' + IncludeTrailingPathDelimiter(ExtractFilePath(devDirs.Exec)) +
    'Symbols*http://msdl.microsoft.com/download/symbols', filename, arguments]);

  //Run the thing!
  if Assigned(MainForm.fProject) then
    WorkingDir := MainForm.fProject.CurrentProfile.ExeOutput;
  Launch(Executable, WorkingDir);

  //Tell the wait function that another valid output terminator is the 0:0000 prompt
  Wait.OutputTerminators.Add(InputPrompt);

  //Send the source mode setting (enable all except ONLY source)
  QueueCommand('l+t; l+l; l+s', '');

  //Set all the paths
  Srcpath := ExtractFilePath(Filename) + ';';
  for I := 0 to IncludeDirs.Count - 1 do
    Srcpath := Srcpath + IncludeDirs[I] + ';';
  QueueCommand('.srcpath+', Srcpath);
  QueueCommand('.exepath+', ExtractFilePath(Filename));
end;

procedure TCDBDebugger.Attach(pid: integer);
const
  InputPrompt = '^([0-9]+):([0-9]+)>';
var
  Executable: string;
  Srcpath: string;
  I: Integer;
begin
  //Heck about the breakpoint thats coming.
  IgnoreBreakpoint := True;
  self.FileName := filename;

  //Get the name of the debugger
  if (devCompiler.gdbName <> '') then
    Executable := devCompiler.gdbName
  else
    Executable := DBG_PROGRAM(devCompiler.CompilerType);

  //Create the command line
  Executable := Format('%s -lines -2 -G -n -s -y "%s" -p %d', [Executable, ExtractFilePath(filename) +
    ';SRV*' + IncludeTrailingPathDelimiter(ExtractFilePath(devDirs.Exec)) +
    'Symbols*http://msdl.microsoft.com/download/symbols', pid]);

  //Run the thing!
  Launch(Executable);

  //Tell the wait function that another valid output terminator is the 0:0000 prompt
  Wait.OutputTerminators.Add(InputPrompt);

  //Send the source mode setting (enable all except ONLY source)
  QueueCommand('l+t; l+l; l+s', '');

  //Set all the paths
  Srcpath := ExtractFilePath(Filename) + ';';
  for I := 0 to IncludeDirs.Count - 1 do
    Srcpath := Srcpath + IncludeDirs[I] + ';';
  QueueCommand('.srcpath+', Srcpath);
  QueueCommand('.exepath+', ExtractFilePath(Filename));
end;

procedure TCDBDebugger.OnOutput(Output: string);
const
  InputPrompt = '^([0-9]+):([0-9]+)>';
var
  NewLines: TStringList;
  RegExp: TRegExpr;
  CurrBp: TBreakpoint;
  CurLine: String;

  procedure FlushOutputBuffer;
  begin
    if NewLines.Count <> 0 then
    begin
      MainForm.DebugOutput.Lines.BeginUpdate;
      MainForm.DebugOutput.Lines.AddStrings(NewLines);
      MainForm.DebugOutput.Lines.EndUpdate;
      SendMessage(MainForm.DebugOutput.Handle, $00B6 {EM_LINESCROLL}, 0,
                  MainForm.DebugOutput.Lines.Count);
      NewLines.Clear;
    end;
  end;

  procedure ParseError(const line: string);
  begin                  
    if RegExp.Substitute('$3') = 'c0000005' then
      OnAccessViolation
    else if RegExp.Substitute('$3') = '40010005' then
    else if RegExp.Substitute('$3') = 'c00000fd' then
    else if RegExp.Substitute('$3') = '80000003' then
      if IgnoreBreakpoint then
        IgnoreBreakpoint := False
      else
        OnBreakpoint;
  end;

  procedure ParseOutput(const line: string);
  begin
    if RegExp.Exec(line, InputPrompt) then
    begin
      //The debugger is waiting for input, we're paused!
      SentCommand := False;
      fPaused := True;
      fBusy := False;

      //Because we are here, we probably are a side-effect of a previous instruction
      //Execute the process function for the command.
      if (CurOutput.Count <> 0) and (CurrentCommand <> nil) and Assigned(CurrentCommand.OnResult) then
          CurrentCommand.OnResult(CurOutput);

      if CurrentCommand <> nil then
      begin
        if (CurrentCommand.Command = 'g'#10) or (CurrentCommand.Command = 't'#10) or (CurrentCommand.Command = 'p'#10) then
        begin
          RefreshContext;
          Application.BringToFront;
        end;
      end;
      CurOutput.Clear;

      //Send the command, and do not send any more
      FlushOutputBuffer;
      SendCommand;

      //Make sure we don't save the current line!
      Exit;
    end;

    if RegExp.Exec(line, 'DBGHELP: (.*) - no symbols loaded') then
    begin
      if LowerCase(RegExp.Substitute('$1')) = LowerCase(ChangeFileExt(ExtractFileName(Filename), '')) then
        OnNoDebuggingSymbolsFound;
    end
    else if RegExp.Exec(line, '\((.*)\): (.*) - code ([0-9a-fA-F]{1,8}) \((.*)\)') then
      ParseError(line)
    else if RegExp.Exec(line, 'Breakpoint ([0-9]+) hit') then
    begin
      CurrBp := GetBreakpointFromIndex(StrToInt(RegExp.Substitute('$1')));
      if CurrBp <> nil then
        MainForm.GotoBreakpoint(CurrBp.Filename, CurrBp.Line)
      else
        JumpToCurrentLine := True;
    end;

    CurOutput.Add(Line);
  end;
begin
  //Update the memo
  RegExp := TRegExpr.Create;
  NewLines := TStringList.Create;

  try
    while Pos(#10, Output) > 0 do
    begin
      //Extract the current line
      CurLine := Copy(Output, 0, Pos(#10, Output) - 1);

      //Process the output
      if not AnsiStartsStr('DBGHELP: ', CurLine) then
        NewLines.Add(CurLine);
      ParseOutput(CurLine);

      //Remove those that we've already processed
      Delete(Output, 1, Pos(#10, Output));
    end;

    if Length(Output) > 0 then
    begin
      NewLines.Add(Output);
      ParseOutput(Output);
    end;
  except
    on E: Exception do
      madExcept.HandleException;
  end;

  //Add the new lines to the edit control if we have any
  FlushOutputBuffer;

  //Clean up
  RegExp.Free;
  NewLines.Free;
end;

procedure TCDBDebugger.AddIncludeDir(s: string);
begin
  IncludeDirs.Add(s);
  if Executing then
    QueueCommand('.sympath+', s);
end;

procedure TCDBDebugger.ClearIncludeDirs;
begin
  IncludeDirs.Clear;
end;

procedure TCDBDebugger.AddBreakpoint(breakpoint: TBreakpoint);
var
  aBreakpoint: PBreakpoint;
begin
  if (not Paused) and Executing then
  begin
    MessageDlg('Cannot add a breakpoint while the debugger is executing.', mtError, [mbOK], MainForm.Handle);
    Exit;
  end;

  New(aBreakpoint);
  aBreakpoint^ := breakpoint;
  Breakpoints.Add(aBreakpoint);
  RefreshBreakpoint(aBreakpoint^);
end;

procedure TCDBDebugger.RemoveBreakpoint(breakpoint: TBreakpoint);
var
  I: Integer;
begin
  if (not Paused) and Executing then
  begin
    MessageDlg('Cannot remove a breakpoint while the debugger is executing.', mtError, [mbOK], MainForm.Handle);
    Exit;
  end;

  for i := 0 to Breakpoints.Count - 1 do
  begin
    if (PBreakPoint(Breakpoints.Items[i])^.line = breakpoint.Line) and (PBreakPoint(Breakpoints.Items[i])^.editor = breakpoint.Editor) then
    begin
      if Executing then
        QueueCommand('bc', IntToStr(PBreakpoint(Breakpoints.Items[i])^.Index));
      Dispose(Breakpoints.Items[i]);
      Breakpoints.Delete(i);
      Break;
    end;
  end;
end;

procedure TCDBDebugger.RefreshBreakpoint(var breakpoint: TBreakpoint);
var
  Command: TCommand;
begin
  if Executing then
  begin
    Inc(fNextBreakpoint);
    breakpoint.Valid := True;
    breakpoint.Index := fNextBreakpoint;
    Command := TCommand.Create;
    Command.Data := breakpoint;
    Command.Command := Format('bp%d `%s:%d`', [breakpoint.Index, breakpoint.Filename, breakpoint.Line]);
    Command.OnResult := OnBreakpointSet;
    QueueCommand(Command);
  end;
end;

procedure TCDBDebugger.OnBreakpointSet(Output: TStringList);
begin
  if CurrentCommand.Data = nil then
    Exit;
  
  with TBreakpoint(CurrentCommand.Data) do
  begin
    Valid := False;
    Editor.InvalidateGutter;
  end;
end;

procedure TCDBDebugger.RefreshContext(refresh: ContextDataSet);
var
  I: Integer;
  Node: TTreeNode;
  Command: TCommand;
  MemberName: string;
begin
  if not Executing then
    Exit;

  //First send commands for stack tracing, locals and the threads list
  if cdCallStack in refresh then
  begin
    Command := TCommand.Create;
    Command.Command := 'kp 512';
    Command.OnResult := OnCallStack;
    QueueCommand(Command);
  end;
  if cdLocals in refresh then
  begin
    Command := TCommand.Create;
    Command.Command := 'dv -i -v';
    Command.OnResult := OnLocals;
    QueueCommand(Command);
  end;
  if cdThreads in refresh then
  begin
    Command := TCommand.Create;
    Command.Command := '~';
    Command.OnResult := OnThreads;
    QueueCommand(Command);
  end;
  if cdDisassembly in refresh then
    Disassemble;
  if cdRegisters in refresh then
    GetRegisters;

  //Then update the watches
  if (cdWatches in refresh) and Assigned(DebugTree) then
  begin
    I := 0;
    while I < DebugTree.Items.Count do
    begin
      Node := DebugTree.Items[I];
      if Node.Data = nil then
        Continue;
      with PWatch(Node.Data)^ do
      begin
        Command := TCommand.Create;

        //Decide what command we should send - dv for locals, dt for structures
        if Pos('.', Name) > 0 then
        begin
          Command.Command := 'dt -r -b -n ' + Copy(name, 1, Pos('.', name) - 1);
          MemberName := Copy(name, Pos('.', name) + 1, Length(name));
          if MemberName <> '' then
            Command.Command := Command.Command + ' ' + MemberName + '.';
        end
        else if Pos('[', Name) > 0 then
          Command.Command := 'dt -a -r -b -n ' + Copy(name, 1, Pos('[', name) - 1)
        else
          Command.Command := 'dt -r -b -n ' + Copy(name, Pos('*', name) + 1, Length(name));

        //Fill in the other data
        Command.Data := Node;
        Command.OnResult := OnRefreshContext;
        Node.DeleteChildren;

        //Then send it
        QueueCommand(Command);
      end;

      //Increment our counter
      Inc(I);
    end;
  end;
end;

procedure TCDBDebugger.OnRefreshContext(Output: TStringList);
const
  NotFound = 'Cannot find specified field members.';
  StructExpr = '( +)[\+|=]0x([0-9a-fA-F]{1,8}) ([^ ]*)?( +): (.*)';
  ArrayExpr = '\[([0-9a-fA-F]*)\] @ ([0-9a-fA-F]*)';
  StructArrayExpr = '( *)\[([0-9a-fA-F]*)\] (.*)';
var
  NeedsRefresh: Boolean;
  Expanded: Boolean;
  RegExp: TRegExpr;
  Node: TTreeNode;

  procedure ParseStructure(Output: TStringList; ParentNode: TTreeNode); forward;
  procedure ParseStructArray(Output: TStringList; ParentNode: TTreeNode);
  var
    I: Integer;
    Indent: Integer;
    SubStructure: TStringList;
  begin
    I := 0;
    Indent := 0;
    while I < Output.Count do
    begin
      if RegExp.Exec(Output[I], StructArrayExpr) then
      begin
        with DebugTree.Items.AddChild(ParentNode, RegExp.Substitute('[$2] $3')) do
        begin
          SelectedIndex := 21;
          ImageIndex := 21;
        end;

        Inc(I);
        if I >= Output.Count then
           Continue;

        if RegExp.Exec(Output[I], StructExpr) then
        begin
          if Indent = 0 then
            Indent := Length(RegExp.Substitute('$1'));

          SubStructure := TStringList.Create;
          while I < Output.Count do
          begin
            if RegExp.Exec(Output[I], StructExpr) then
            begin
              if Length(RegExp.Substitute('$1')) < Indent then
                Break
              else
                SubStructure.Add(Output[I]);
            end
            else if RegExp.Exec(Output[I], StructArrayExpr) then
              if Length(RegExp.Substitute('$1')) <= Indent then
                Break
              else
                SubStructure.Add(Output[I]);
                
            Inc(I);
          end;
          Indent := 0;

          //Process it
          with ParentNode.Item[ParentNode.Count - 1] do
          begin
            SelectedIndex := 32;
            ImageIndex := 32;
          end;

          //Determine if it is a structure or an array
          ParseStructure(SubStructure, ParentNode.Item[ParentNode.Count - 1]);
          ParentNode.Item[ParentNode.Count - 1].Expand(false);
          SubStructure.Free;
          Dec(I);
        end;
      end;
    end;
  end;

  procedure ParseStructure(Output: TStringList; ParentNode: TTreeNode);
  var
    SubStructure: TStringList;
    Indent: Integer;
    Node: TTreeNode;
    I: Integer;
  begin
    I := 0;
    Indent := 0;
    while I < Output.Count do
    begin
      if RegExp.Exec(Output[I], StructExpr) or RegExp.Exec(Output[I], StructArrayExpr) then
      begin
        if Indent = 0 then
          Indent := Length(RegExp.Substitute('$1'));

        //Check if this is a sub-structure
        if Indent <> Length(RegExp.Substitute('$1')) then
        begin
          //Populate the substructure string list
          SubStructure := TStringList.Create;

          while I < Output.Count do
          begin
            if RegExp.Exec(Output[I], StructArrayExpr) or RegExp.Exec(Output[I], StructExpr) then
              if Length(RegExp.Substitute('$1')) <= Indent then
                Break
              else
                SubStructure.Add(Output[I]);
            Inc(I);
          end;

          //Process it
          with ParentNode.Item[ParentNode.Count - 1] do
          begin
            SelectedIndex := 32;
            ImageIndex := 32;
          end;

          //Determine if it is a structure or an array
          if SubStructure.Count <> 0 then
            if Trim(SubStructure[0])[1] = '[' then
              ParseStructArray(SubStructure, ParentNode.Item[ParentNode.Count - 1])
            else
              ParseStructure(SubStructure, ParentNode.Item[ParentNode.Count - 1]);
          ParentNode.Item[ParentNode.Count - 1].Expand(false);
          SubStructure.Free;
          Indent := 0;

          //Decrement I, since we will increment one at the end of the loop
          Dec(I);
        end
        else
        begin
          if RegExp.Substitute('$5') = '' then
            Node := DebugTree.Items.AddChild(ParentNode, RegExp.Substitute('$3'))
          else
            Node := DebugTree.Items.AddChild(ParentNode, RegExp.Substitute('$3 = $5'));

          with Node do
          begin
            SelectedIndex := 21;
            ImageIndex := 21;
          end;
        end;
      end
      //Otherwise just add the value if it is a scalar
      else if (I < Output.Count - 1) and (Length(Output[I + 1]) <> 0) and (Output[I + 1][1] <> '+') then
      begin
        with DebugTree.Items.AddChild(ParentNode, Trim(Output[I + 1])) do
        begin
          SelectedIndex := 21;
          ImageIndex := 21;
        end;
        with ParentNode do
        begin
          SelectedIndex := 32;
          ImageIndex := 32;
        end;
      end;

      //Increment I
      Inc(I);
    end;
  end;

  procedure ParseArray(Output: TStringList; ParentNode: TTreeNode);
  var
    SubStructure: TStringList;
    Increment: Integer;
    I: Integer;
  begin
    I := 0;
    while I < Output.Count do
    begin
      if RegExp.Exec(Output[I], ArrayExpr) then
      begin
        Inc(I, 2);
        Increment := 2;
        while Trim(Output[I]) = '' do
        begin
          Inc(I);
          Inc(Increment);
        end;

        //Are we an array (with a basic data type) or with a UDT?
        if RegExp.Exec(Output[I], StructExpr) then
        begin
          with TRegExpr.Create do
          begin
            Exec(Output[I - Increment], ArrayExpr);
            with DebugTree.Items.AddChild(ParentNode, Substitute('[$1]')) do
            begin
              SelectedIndex := 32;
              ImageIndex := 32;
            end;

            Free;
          end;

          //Populate the substructure string list
          SubStructure := TStringList.Create;
          while (I < Output.Count) and (Output[I] <> '') do
          begin
            SubStructure.Add(Output[I]);
            Inc(I);
          end;

          //Process it
          ParseStructure(SubStructure, ParentNode.Item[ParentNode.Count - 1]);
          ParentNode.Item[ParentNode.Count - 1].Expand(false);
          SubStructure.Free;

          //Decrement I, since we will increment one at the end of the loop
          Dec(I);
        end
        else
          with TRegExpr.Create do
          begin
            Exec(Output[I - Increment], ArrayExpr);
            with DebugTree.Items.AddChild(ParentNode, Substitute('[$1]') + ' = ' + Output[I]) do
            begin
              SelectedIndex := 21;
              ImageIndex := 21;
            end;
            Inc(I);

            if (I < Output.Count - 1) and Exec(Output[I], ' -> 0x([0-9a-fA-F]{1,8}) +(.*)') then
            begin
              with ParentNode.Item[ParentNode.Count - 1] do
              begin
                SelectedIndex := 32;
                ImageIndex := 32;
              end;
              
              with DebugTree.Items.AddChild(ParentNode.Item[ParentNode.Count - 1], Substitute('$1 = $2')) do
              begin
                SelectedIndex := 21;
                ImageIndex := 21;
              end;
              Inc(I);
            end
            else if RegExp.Exec(Output[I], StructExpr) then
            begin
              //Populate the substructure string list
              SubStructure := TStringList.Create;
              while (I < Output.Count) and (Output[I] <> '') do
              begin
                SubStructure.Add(Output[I]);
                Inc(I);
              end;

              //Change the icon of the parent node
              with ParentNode.Item[ParentNode.Count - 1] do
              begin
                SelectedIndex := 32;
                ImageIndex := 32;
              end;

              //Process it
              ParseStructure(SubStructure, ParentNode.Item[ParentNode.Count - 1]);
              SubStructure.Free;

              //Decrement I, since we will increment one at the end of the loop
              Dec(I);
            end;
            Free;
          end;
      end;

      //Increment I
      Inc(I);
    end;
  end;
begin
  NeedsRefresh := False;
  RegExp := TRegExpr.Create;
  Node := TTreeNode(CurrentCommand.Data);
  
  //Set the type of the structure/class/whatever
  with PWatch(Node.Data)^ do
    if RegExp.Exec(Output[0], '(.*) (.*) @ 0x([0-9a-fA-F]{1,8}) Type (.*?)([\[\]\*]+)') then
    begin
      Expanded := Node.Expanded;
      if Pos('[', name) <> 0 then
        Node.Text := RegExp.Substitute(Copy(name, 1, Pos('[', name) - 1) + ' = $4$5 (0x$3)')
      else
        Node.Text := RegExp.Substitute(name + ' = $4$5 (0x$3)');
      Node.SelectedIndex := 32;
      Node.ImageIndex := 32;
      ParseArray(Output, Node);

      if Expanded then
        Node.Expand(True);
    end
    else if RegExp.Exec(Output[0], '(.*) (.*) @ 0x([0-9a-fA-F]{1,8}) Type (.*)') then
    begin
      Expanded := Node.Expanded;
      if Pos('.', name) <> 0 then
        Node.Text := RegExp.Substitute(Copy(name, 1, Pos('.', name) - 1) + ' = $4 (0x$3)')
      else
        Node.Text := RegExp.Substitute(name + ' = $4 (0x$3)');
      Node.SelectedIndex := 32;
      Node.ImageIndex := 32;
      ParseStructure(Output, Node);

      if Expanded then
        Node.Expand(True);
    end;

  //Do we have to refresh the entire thing?
  if NeedsRefresh then
    RefreshContext;
  RegExp.Free;
end;

procedure TCDBDebugger.AddWatch(varname: string; when: TWatchBreakOn);
var
  Command: TCommand;
  bpType: string;
  Watch: PWatch;
begin
  with DebugTree.Items.Add(nil, varname + ' = (unknown)') do
  begin
    ImageIndex := 21;
    SelectedIndex := 21;
    New(Watch);
    Watch^.Name := AnsiReplaceStr(varname, '->', '.');

    //Give the watch a unique ID
    Inc(fNextBreakpoint);
    Watch^.ID := fNextBreakpoint;

    //Then store the associated data
    Data := Watch;
  end;

  //Determine the type
  case when of
    wbWrite:
      bpType := 'w';
    wbBoth:
      bpType := 'r';
  end;

  Command := TCommand.Create;
  Command.Data := nil;
  Command.Command := Format('ba%d %s4 %s', [fNextBreakpoint, bpType, varname]);
  Command.OnResult := OnBreakpointSet;
  QueueCommand(Command);
end;

procedure TCDBDebugger.RefreshWatches;
var
  I: Integer;
  Command: TCommand;
begin
  for I := 0 to DebugTree.Items.Count - 1 do
    with PWatch(DebugTree.Items[I].Data)^ do
    begin
      Command := TCommand.Create;
      Command.Data := nil;
      Command.Command := Format('ba%d r4 %s', [ID, Name]);
      Command.OnResult := OnBreakpointSet;
      QueueCommand(Command);
    end;
end;

procedure TCDBDebugger.RemoveWatch(varname: string);
var
  node: TTreeNode;
begin
  //Find the top-most node
  node := DebugTree.Selected;
  while Assigned(node) and (Assigned(node.Parent)) do
    node := node.Parent;

  //Then clean it up
  if Assigned(node) then
  begin
    QueueCommand('bc', IntToStr(PWatch(Node.Data)^.ID));
    Dispose(node.Data);
    DebugTree.Items.Delete(node);
  end;
end;

procedure TCDBDebugger.OnCallStack(Output: TStringList);
var
  I: Integer;
  RegExp: TRegExpr;
  CallStack: TList;
  StackFrame: PStackFrame;
begin
  CallStack := TList.Create;
  RegExp := TRegExpr.Create;
  
  for I := 0 to Output.Count - 1 do
    if RegExp.Exec(Output[I], 'ChildEBP RetAddr') then
      Continue
    else if RegExp.Exec(Output[I], '([0-9a-fA-F]{1,8}) ([0-9a-fA-F]{1,8}) (.*)!(.*)\((.*)\)(|.*) \[(.*) @ ([0-9]*)\]') then
    begin
      //Stack frame with source information
      New(StackFrame);
      CallStack.Add(StackFrame);

      //Fill the fields
      with StackFrame^ do
      begin
        Filename := RegExp.Substitute('$7');
        Line := StrToInt(RegExp.Substitute('$8'));
        FuncName := RegExp.Substitute('$4$6');
        Args := RegExp.Substitute('$5');
      end;
    end
    else if RegExp.Exec(Output[I], '([0-9a-fA-F]{1,8}) ([0-9a-fA-F]{1,8}) (.*)!(.*)(|\((.*)\))(.*)') then
    begin
      //Stack frame without source information
      New(StackFrame);
      CallStack.Add(StackFrame);

      //Fill the fields
      with StackFrame^ do
      begin
        FuncName := RegExp.Substitute('$4$6');
        Args := RegExp.Substitute('$5');
        Line := 0;
      end;
    end;

  //Now that we have the entire callstack loaded into our list, call the function
  //that wants it
  if Assigned(TDebugger(Self).OnCallStack) then
    TDebugger(Self).OnCallStack(CallStack);

  //Do we show the new execution point?
  if JumpToCurrentLine then
  begin
    JumpToCurrentLine := False;
    MainForm.GotoTopOfStackTrace;
  end;

  //Clean up
  RegExp.Free;
  CallStack.Free;
end;

procedure TCDBDebugger.OnThreads(Output: TStringList);
var
  I: Integer;
  Thread: PDebuggerThread;
  Threads: TList;
  RegExp: TRegExpr;
  Suspended, Frozen: Boolean;
begin
  Threads := TList.Create;
  RegExp := TRegExpr.Create;
  
  for I := 0 to Output.Count - 1 do
    if RegExp.Exec(Output[I], '([.#]*)( +)([0-9]*)( +)Id: ([0-9a-fA-F]*)\.([0-9a-fA-F]*) Suspend: ([0-9a-fA-F]*) Teb: ([0-9a-fA-F]{1,8}) (.*)') then
    begin
      New(Thread);
      Threads.Add(Thread);

      //Fill the fields
      with Thread^ do
      begin
        Active := RegExp.Substitute('$1') = '.';
        Index := RegExp.Substitute('$3');
        ID := RegExp.Substitute('$5.$6');
        Suspended := RegExp.Substitute('$7') <> '0';
        Frozen := RegExp.Substitute('$9') = 'frozen';
        if Suspended and Frozen then
          ID := ID + ' (Suspended, Frozen)'
        else if Suspended then
          ID := ID + ' (Suspended)'
        else if Frozen then
          ID := ID + ' (Frozen)'
      end;
    end;

  //Pass the locals list to the callback function that wants it
  if Assigned(TDebugger(Self).OnThreads) then
    TDebugger(Self).OnThreads(Threads);

  //Clean up
  Threads.Free;
  RegExp.Free;
end;

procedure TCDBDebugger.OnLocals(Output: TStringList);
var
  I: Integer;
  Local: PVariable;
  Locals: TList;
  RegExp: TRegExpr;
  Command: TCommand;
begin
  Locals := TList.Create;
  LocalsList := TList.Create;
  RegExp := TRegExpr.Create;
  
  for I := 0 to Output.Count - 1 do
    if RegExp.Exec(Output[I], '(.*)( +)(.*)( +)([0-9a-fA-F]{1,8}) +(.*) = (.*)') then
    begin
      New(Local);
      Locals.Add(Local);

      //Fill the fields
      with Local^ do
      begin
        Name := RegExp.Substitute('$6');
        Value := RegExp.Substitute('$7');
        Location := RegExp.Substitute('$5');
      end;
    end;

  //Now that the locals list has a complete list of values, we want to get the
  //full variable stuff if it is a structure.
  Command := TCommand.Create;
  Command.Command := '';
  for I := 0 to Locals.Count - 1 do
    with PVariable(Locals[I])^ do
      if (Pos('class', Value) > 0) or (Pos('struct', Value) > 0) or (Pos('union', Value) > 0) then
        Command.Command := Format('%sdt -r -b -n %s;', [Command.Command, Name])
      else if Pos('[', Value) > 0 then
        Command.Command := Format('%sdt -a -r -b -n %s;', [Command.Command, Name])
      else if Pos('0x', Value) = 1 then
        Command.Command := Format('%sdt -a -r -b -n %s;', [Command.Command, Name])
      else
        LocalsList.Add(Locals[I]);

  if Command.Command <> '' then
  begin
    Command.OnResult := OnDetailedLocals;
    QueueCommand(Command);
  end
  else
  begin
    if Assigned(TDebugger(Self).OnLocals) then
      TDebugger(Self).OnLocals(LocalsList);
    FreeAndNil(LocalsList);
  end;

  //Clean up
  Locals.Free;
  RegExp.Free;
end;

//This is a complete rip of the watch (dt) parsing code. But I have no choice...
procedure TCDBDebugger.OnDetailedLocals(Output: TStringList);
const
  NotFound = 'Cannot find specified field members.';
  PtrVarPrompt = '(.*) (.*) @ 0x([0-9a-fA-F]{1,8}) Type (.*?)([\[\]\*]+)';
  VarPrompt = '(.*) (.*) @ 0x([0-9a-fA-F]{1,8}) Type (.*)';
  StructExpr = '( +)[\+|=]0x([0-9a-fA-F]{1,8}) ([^ ]*)?( +): (.*)';
  ArrayExpr = '\[([0-9a-fA-F]*)\] @ ([0-9a-fA-F]*)';
  StructArrayExpr = '( *)\[([0-9a-fA-F]*)\] (.*)';
var
  Variables: TStringList;
  SubStructure: TStringList;
  RegExp: TRegExpr;
  Local: PVariable;
  I, J: Integer;

  function SynthesizeIndent(Indent: Integer): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to Indent - 1 do
      Result := Result + ' ';
  end;
  
  procedure ParseStructure(Output: TStringList; exIndent: Integer); forward;
  procedure ParseStructArray(Output: TStringList; Indent: Integer);
  var
    I: Integer;
    SubStructure: TStringList;
  begin
    I := 0;
    Indent := 0;
    while I < Output.Count do
    begin
      if RegExp.Exec(Output[I], StructArrayExpr) then
      begin
        Inc(I);
        if I >= Output.Count then
           Continue;

        if RegExp.Exec(Output[I], StructExpr) then
        begin
          if Indent = 0 then
            Indent := Length(RegExp.Substitute('$1'));

          SubStructure := TStringList.Create;
          while I < Output.Count do
          begin
            if RegExp.Exec(Output[I], StructExpr) then
            begin
              if Length(RegExp.Substitute('$1')) < Indent then
                Break
              else
                SubStructure.Add(Output[I]);
            end
            else if RegExp.Exec(Output[I], StructArrayExpr) then
              if Length(RegExp.Substitute('$1')) <= Indent then
                Break
              else
                SubStructure.Add(Output[I]);
                
            Inc(I);
          end;

          //Determine if it is a structure or an array
          ParseStructure(SubStructure, Indent + 4);
          SubStructure.Free;
          Dec(I);
        end;
      end;
    end;
  end;

  procedure ParseStructure(Output: TStringList; exIndent: Integer);
  var
    SubStructure: TStringList;
    Indent, I: Integer;
  begin
    I := 0;
    Indent := 0;
    while I < Output.Count do
    begin
      if RegExp.Exec(Output[I], StructExpr) or RegExp.Exec(Output[I], StructArrayExpr) then
      begin
        if Indent = 0 then
          Indent := Length(RegExp.Substitute('$1'));

        //Check if this is a sub-structure
        if Indent <> Length(RegExp.Substitute('$1')) then
        begin
          //Populate the substructure string list
          SubStructure := TStringList.Create;

          while I < Output.Count do
          begin
            if RegExp.Exec(Output[I], StructArrayExpr) or RegExp.Exec(Output[I], StructExpr) then
              if Length(RegExp.Substitute('$1')) <= Indent then
                Break
              else
                SubStructure.Add(Output[I]);
            Inc(I);
          end;

          //Determine if it is a structure or an array
          if SubStructure.Count <> 0 then
            if Trim(SubStructure[0])[1] = '[' then
              ParseStructArray(SubStructure, Indent + 4)
            else
              ParseStructure(SubStructure, Indent + 4);
          SubStructure.Free;

          //Decrement I, since we will increment one at the end of the loop
          Dec(I);
        end
        //Otherwise just add the value
        else
        begin
          New(Local);
          Local^.Name := SynthesizeIndent(Indent + exIndent) + RegExp.Substitute('$3');
          Local^.Value := RegExp.Substitute('$5');
          LocalsList.Add(Local);
        end;
      end;

      //Increment I
      Inc(I);
    end;
  end;

  procedure ParseArray(Output: TStringList; Indent: Integer);
  var
    SubStructure: TStringList;
    Increment: Integer;
    I: Integer;
  begin
    I := 0;
    while I < Output.Count do
    begin
      if RegExp.Exec(Output[I], ArrayExpr) then
      begin
        Inc(I, 2);
        Increment := 2;
        while Trim(Output[I]) = '' do
        begin
          Inc(I);
          Inc(Increment);
        end;
        
        //Are we an array (with a basic data type) or with a UDT?
        if RegExp.Exec(Output[I], StructExpr) then
        begin
          with TRegExpr.Create do
          begin
            Exec(Output[I - Increment], ArrayExpr);
            New(Local);
            Local^.Name := SynthesizeIndent(Indent) + Substitute('$1');
            LocalsList.Add(Local);
            Free;
          end;

          //Populate the substructure string list
          SubStructure := TStringList.Create;
          while (I < Output.Count) and (Output[I] <> '') do
          begin
            SubStructure.Add(Output[I]);
            Inc(I);
          end;

          //Process it
          ParseStructure(SubStructure, Indent + 4);
          SubStructure.Free;

          //Decrement I, since we will increment one at the end of the loop
          Dec(I);
        end
        else
          with TRegExpr.Create do
          begin
            Exec(Output[I - Increment], ArrayExpr);
            New(Local);
            Local^.Name := SynthesizeIndent(Indent) + Substitute('[$1]');
            Local^.Value := Output[I];
            LocalsList.Add(Local);
            Inc(I);

            if (I < Output.Count - 1) and Exec(Output[I], ' -> 0x([0-9a-fA-F]{1,8}) +(.*)') then
            begin
              New(Local);
              Local^.Name := SynthesizeIndent(Indent + 4) + Substitute('$1');
              Local^.Value := Substitute('$2');
              LocalsList.Add(Local);
              Inc(I);
            end
            else if RegExp.Exec(Output[I], StructExpr) then
            begin
              //Populate the substructure string list
              SubStructure := TStringList.Create;
              while (I < Output.Count) and (Output[I] <> '') do
              begin
                SubStructure.Add(Output[I]);
                Inc(I);
              end;

              //Process it
              ParseStructure(SubStructure, Indent + 4);
              SubStructure.Free;

              //Decrement I, since we will increment one at the end of the loop
              Dec(I);
            end;
            Free;
          end;
      end;

      //Increment I
      Inc(I);
    end;
  end;
begin
  SubStructure := TStringList.Create;
  Variables := TStringList.Create;
  RegExp := TRegExpr.Create;

  //Compute the list of commands
  I := 1;
  while I <= Length(CurrentCommand.Command) do
  begin
    if Copy(CurrentCommand.Command, I, 3) = '-n ' then
    begin
      Inc(I, 3);
      J := I;
      while I <= Length(CurrentCommand.Command) do
      begin
        if CurrentCommand.Command[I] = ';' then
        begin
          Variables.Add(Copy(CurrentCommand.Command, J, I - J));
          Break;
        end;
        Inc(I);
      end;
    end;
    Inc(I);
  end;

  //Set the type of the structure/class/whatever
  J := 0;
  I := 0;
  while I < Output.Count do
  if RegExp.Exec(Output[I], PtrVarPrompt) then
  begin
    New(Local);
    Local^.Name := Variables[J];
    Local^.Value := RegExp.Substitute('$4$5');
    Local^.Location := RegExp.Substitute('0x$3');
    LocalsList.Add(Local);
    Inc(I);

    while (I < Output.Count) and not RegExp.Exec(Output[I], VarPrompt) do
    begin
      SubStructure.Add(Output[I]);
      Inc(I);
    end;

    ParseArray(SubStructure, 4);
    SubStructure.Clear;
    Inc(J);
  end
  else if RegExp.Exec(Output[I], VarPrompt) then
  begin
    New(Local);
    Local^.Name := Variables[J];
    Local^.Location := RegExp.Substitute('0x$3');
    Local^.Value := RegExp.Substitute('$4');
    LocalsList.Add(Local);
    Inc(I);

    while (I < Output.Count) and not RegExp.Exec(Output[I], VarPrompt) do
    begin
      SubStructure.Add(Output[I]);
      Inc(I);
    end;

    ParseStructure(SubStructure, 4);
    SubStructure.Clear;
    Inc(J);
  end
  else
    Inc(I);

  //Send the list of locals
  if Assigned(TDebugger(Self).OnLocals) then
    TDebugger(Self).OnLocals(LocalsList);
  FreeAndNil(LocalsList);

  SubStructure.Free;
  Variables.Free;
  RegExp.Free;
end;

procedure TCDBDebugger.GetRegisters;
var
  Command: TCommand;
begin
  if (not Executing) or (not Paused) then
    Exit;

  Command := TCommand.Create;
  Command.Command := 'r';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);
end;

procedure TCDBDebugger.OnRegisters(Output: TStringList);
var
  I: Integer;
  RegExp: TRegExpr;
  Registers: TRegisters;
begin
  RegExp := TRegExpr.Create;
  Registers := TRegisters.Create;

  for I := 0 to Output.Count - 1 do
    if RegExp.Exec(Output[I], 'eax=([0-9a-fA-F]{1,8}) ebx=([0-9a-fA-F]{1,8}) ecx=([0-9a-fA-F]{1,8}) edx=([0-9a-fA-F]{1,8}) esi=([0-9a-fA-F]{1,8}) edi=([0-9a-fA-F]{1,8})') then
      begin
        with Registers do
        begin
          EAX := RegExp.Substitute('$1');
          EBX := RegExp.Substitute('$2');
          ECX := RegExp.Substitute('$3');
          EDX := RegExp.Substitute('$4');
          ESI := RegExp.Substitute('$5');
          EDI := RegExp.Substitute('$6');
        end;
      end
      else if RegExp.Exec(Output[I], 'eip=([0-9a-fA-F]{1,8}) esp=([0-9a-fA-F]{1,8}) ebp=([0-9a-fA-F]{1,8}) iopl=([0-9a-fA-F]{1,8})') then
      begin
        with Registers do
        begin
          EIP := RegExp.Substitute('$1');
          ESP := RegExp.Substitute('$2');
          EBP := RegExp.Substitute('$3');
        end;
      end
      else if RegExp.Exec(Output[I], 'cs=([0-9a-fA-F]{1,4})  ss=([0-9a-fA-F]{1,4})  ds=([0-9a-fA-F]{1,4})  es=([0-9a-fA-F]{1,4})  fs=([0-9a-fA-F]{1,4})  gs=([0-9a-fA-F]{1,4})             efl=([0-9a-fA-F]{1,8})') then
      begin
        with Registers do
        begin
          CS := RegExp.Substitute('$1');
          SS := RegExp.Substitute('$2');
          DS := RegExp.Substitute('$3');
          ES := RegExp.Substitute('$4');
          FS := RegExp.Substitute('$5');
          GS := RegExp.Substitute('$6');
          EFLAGS := RegExp.Substitute('$7');
        end;
      end;

  //Pass the locals list to the callback function that wants it
  if Assigned(TDebugger(Self).OnRegisters) then
    TDebugger(Self).OnRegisters(Registers);

  //Clean up
  RegExp.Free;  
end;

procedure TCDBDebugger.Disassemble(func: string);
var
  Command: TCommand;
begin
  if (not Executing) or (not Paused) then
    Exit;

  //If func is empty, assume the value of the reguister eip.
  if func = '' then
    func := 'eip';

  Command := TCommand.Create;
  Command.Command := 'uf ' + func;
  Command.OnResult := OnDisassemble;
  QueueCommand(Command);
end;

procedure TCDBDebugger.OnDisassemble(Output: TStringList);
var
  I, CurLine: Integer;
  RegExp: TRegExpr;
  CurFile: string;
  Disassembly: string;
begin
  CurLine := -1;
  RegExp := TRegExpr.Create;
  for I := 0 to Output.Count - 1 do
    if RegExp.Exec(Output[I], '^(.*)!(.*) \[(.*) @ ([0-9]+)]:') then
    begin
      CurLine := StrToInt(RegExp.Substitute('$4'));
      CurFile := RegExp.Substitute('$1!$2 [$3 @ ');
      Disassembly := Disassembly + #9 + ';' + Output[I] + #10;
    end
    else if RegExp.Exec(Output[I], '^(.*)!(.*):') then
      Disassembly := Disassembly + #9 + ';' + Output[I] + #10
    else if RegExp.Exec(Output[I], '^ +([0-9]+) +([0-9a-fA-F]{1,8})( +)([^ ]*)( +)(.*)( +)(.*)') then
    begin
      if StrToInt(RegExp.Substitute('$1')) <> CurLine then
      begin
        CurLine := StrToInt(RegExp.Substitute('$1'));
        Disassembly := Disassembly + #9 + ';' + CurFile + RegExp.Substitute('$1') + ']:' + #10;
      end;
      Disassembly := Disassembly + RegExp.Substitute('$2$3$4$5$6$7$8') + #10;
    end
    else if RegExp.Exec(Output[I], '^([0-9a-fA-F]{1,8})( +)([^ ]*)( +)(.*)( +)(.*)') then
      Disassembly := Disassembly + Output[I] + #10;

  //Pass the disassembly to the callback function that wants it
  if Assigned(TDebugger(Self).OnDisassemble) then
    TDebugger(Self).OnDisassemble(Disassembly);

  //Clean up
  RegExp.Free;
end;

function TCDBDebugger.GetVariableHint(name: string): string;
var
  Command: TCommand;
begin
  if (not Executing) or (not Paused) then
    Exit;

  Command := TCommand.Create;
  Command.Data := TString.Create(name);
  Command.OnResult := OnVariableHint;

  //Decide what command we should send - dv for locals, dt for structures
  if Pos('.', name) > 0 then
    Command.Command := 'dt ' + Copy(name, 1, Pos('.', name) - 1)
  else
    Command.Command := 'dv ' + name;

  //Send the command;
  QueueCommand(Command);
end;

procedure TCDBDebugger.OnVariableHint(Output: TStringList);
var
  Hint, Name: String;
  I, Depth: Integer;
  RegExp: TRegExpr;
begin
  Name := TString(CurrentCommand.Data).Str;
  CurrentCommand.Data.Free;
  RegExp := TRegExpr.Create;

  if Pos('.', Name) <> 0 then
  begin
    //Remove the dots and count the number of indents
    Depth := 0;
    for I := 1 to Length(name) do
      if name[I] = '.' then
        Inc(Depth);

    //Then find the member name
    for I := 0 to Output.Count - 1 do
      if RegExp.Exec(Output[I], '( {' + IntToStr(Depth * 3) + '})\+0x([0-9a-fA-F]{1,8}) ' +
                     Copy(name, GetLastPos('.', name) + 1, Length(name)) + '( +): (.*)') then
        Hint := RegExp.Substitute(name + ' = $4');
  end
  else
  begin
    for I := 0 to Output.Count - 1 do
      if RegExp.Exec(Output[I], '( +)(.*) = (.*)') then
        Hint := Trim(Output[I]);
  end;

  //Call the callback
  if Assigned(TDebugger(Self).OnVariableHint) then
    TDebugger(Self).OnVariableHint(Hint);

  //Clean up
  RegExp.Free;
end;

procedure TCDBDebugger.Go;
var
  Command: TCommand;
begin
  Command := TCommand.Create;
  Command.Command := 'g';
  Command.Callback := OnGo;
  QueueCommand(Command);
end;

procedure TCDBDebugger.Next;
var
  Command: TCommand;
begin
  Command := TCommand.Create;
  Command.Command := 'p';
  Command.Callback := OnTrace;
  QueueCommand(Command);
end;

procedure TCDBDebugger.Step;
var
  Command: TCommand;
begin
  Command := TCommand.Create;
  Command.Command := 't';
  Command.Callback := OnTrace;
  QueueCommand(Command);
end;

procedure TCDBDebugger.OnTrace;
begin
  JumpToCurrentLine := True;
  fPaused := False;
  fBusy := False;
end;

procedure TCDBDebugger.SetThread(thread: Integer);
begin
  QueueCommand('~' + IntToStr(thread), 's');
  RefreshContext;
end;

procedure TCDBDebugger.SetContext(frame: Integer);
begin
  QueueCommand('.frame', IntToStr(frame));
  RefreshContext([cdLocals, cdWatches]);
end;

//------------------------------------------------------------------------------
// TGDBDebugger
//------------------------------------------------------------------------------
constructor TGDBDebugger.Create;
begin
  inherited;
  OverrideHandler := nil;
  LastWasCtrl := True;
  Started := False;
end;

destructor TGDBDebugger.Destroy;
begin
  inherited;
end;

procedure TGDBDebugger.Execute(filename, arguments: string);
var
  Executable: string;
  WorkingDir: string;
  Includes: string;
  I: Integer;
begin
  //Reset our variables
  self.FileName := filename;
  fExecuting := True;
  fNextBreakpoint := 0;
  IgnoreBreakpoint := False;

  //Get the name of the debugger
  if (devCompiler.gdbName <> '') then
    Executable := devCompiler.gdbName
  else
    Executable := DBG_PROGRAM(devCompiler.CompilerType);
  Executable := Executable + ' --annotate=2 --silent';

  //Add in the include paths
  for I := 0 to IncludeDirs.Count - 1 do
    Includes := Includes + '--directory=' + GetShortName(IncludeDirs[I]) + ' ';
  if Includes <> '' then
    Executable := Executable + ' ' + Includes;

  //Launch the process
  if Assigned(MainForm.fProject) then
    WorkingDir := MainForm.fProject.CurrentProfile.ExeOutput;
  Launch(Executable, WorkingDir);

  //Tell GDB which file we want to debug
  QueueCommand('set', 'height 0');
  QueueCommand('file', '"' + filename + '"');
  QueueCommand('set args', arguments);
end;

procedure TGDBDebugger.Attach(pid: integer);
var
  Executable: string;
  Includes: string;
  I: Integer;
begin
  //Reset our variables
  self.FileName := filename;
  fExecuting := True;
  fNextBreakpoint := 0;
  IgnoreBreakpoint := False;

  //Get the name of the debugger
  if (devCompiler.gdbName <> '') then
    Executable := devCompiler.gdbName
  else
    Executable := DBG_PROGRAM(devCompiler.CompilerType);
  Executable := Executable + ' --annotate=3 --silent';

  //Add in the include paths
  for I := 0 to IncludeDirs.Count - 1 do
    Includes := Includes + '--directory=' + GetShortName(IncludeDirs[I]) + ' ';
  if Includes <> '' then
    Executable := Executable + ' ' + Includes;

  //Launch the process
  Launch(Executable);

  //Tell GDB which file we want to debug
  QueueCommand('set', 'height 0');
  QueueCommand('attach', inttostr(pid));
end;

procedure TGDBDebugger.CloseDebugger(Sender: TObject);
begin
  inherited;
  Started := False;
end;

procedure TGDBDebugger.OnOutput(Output: string);
var
  RegExp: TRegExpr;
  CurLine: string;
  NewLines: TStringList;

  procedure FlushOutputBuffer;
  begin
    if NewLines.Count = 0 then
      Exit;

    MainForm.DebugOutput.Lines.BeginUpdate;
    MainForm.DebugOutput.Lines.AddStrings(NewLines);
    MainForm.DebugOutput.Lines.EndUpdate;
    SendMessage(MainForm.DebugOutput.Handle, $00B6 {EM_LINESCROLL}, 0,
                MainForm.DebugOutput.Lines.Count);
    NewLines.Clear;
  end;
  
  function StripCtrlChars(var line: string): Boolean;
  var
    Idx: Integer;
  begin
    Idx := Pos(#26, line);
    Result := Idx <> 0;
    while Idx <> 0 do
    begin
      Delete(line, Idx, 1);
      Idx := Pos(#26, line);
    end;
  end;

  procedure ParseOutput(const line: string);
  begin
    //Exclude these miscellaneous messages
    if (line = 'pre-prompt') or (line = 'prompt') or (line = 'post-prompt') or
       (line = 'frames-invalid') then
      Exit
    //Empty lines
    else if Trim(line) = '' then
      Exit
    else if Pos('(gdb) ', line) = 1 then
    begin
      //The debugger is waiting for input, we're paused!
      SentCommand := False;
      fPaused := True;
      fBusy := False;

      //Because we are here, we probably are a side-effect of a previous instruction
      //Execute the process function for the command.
      if Assigned(OverrideHandler) then
      begin
        OverrideHandler(CurOutput);
        OverrideHandler := nil;
      end
      else if (CurOutput.Count <> 0) and (CurrentCommand <> nil) and Assigned(CurrentCommand.OnResult) then
        CurrentCommand.OnResult(CurOutput);

      if CurrentCommand <> nil then
      begin
        if (CurrentCommand.Command = 'run'#10) or (CurrentCommand.Command = 'next'#10) or
           (CurrentCommand.Command = 'step'#10) or (CurrentCommand.Command = 'continue'#10) or
           (CurrentCommand.Command =''#10) then
        begin
          RefreshContext;
          Application.BringToFront;
        end;
      end;
      CurOutput.Clear;

      //Send the command, and do not send any more
      FlushOutputBuffer;
      SendCommand;

      //Make sure we don't save the current line!
      Exit;
    end
    else if (Pos('no debugging symbols found', line) > 0) or (Pos('No symbol table is loaded', line) > 0) then
      OnNoDebuggingSymbolsFound
    else if Pos('file is more recent than executable', line) > 0 then
      OnSourceMoreRecent
    else if line = 'signal' then
      OverrideHandler := OnSignal 
    else if RegExp.Exec(line, 'Breakpoint ([0-9]+),') then
      with GetBreakpointFromIndex(StrToInt(RegExp.Substitute('$1'))) do
        MainForm.GotoBreakpoint(Filename, Line)
    else if RegExp.Exec(line, 'Hardware access \(.*\) watchpoint ') then
      JumpToCurrentLine := True
    else if Pos('exited ', line) = 1 then
      CloseDebugger(nil);

    CurOutput.Add(Line);
  end;
begin
  //Update the memo
  RegExp := TRegExpr.Create;
  NewLines := TStringList.Create;

  while Pos(#10, Output) > 0 do
  begin
    //Extract the current line
    CurLine := Copy(Output, 0, Pos(#13, Output) - 1);

    //Process the output
{$IFNDEF RELEASE}
    StripCtrlChars(CurLine);
{$ELSE}
    if not StripCtrlChars(CurLine) then
    begin
{$ENDIF}
      if (not LastWasCtrl) or (Length(CurLine) <> 0) then
        NewLines.Add(CurLine);
      LastWasCtrl := False;
{$IFDEF RELEASE}
    end
    else
      LastWasCtrl := True;
{$ENDIF}
    ParseOutput(CurLine);

    //Remove those that we've already processed
    Delete(Output, 1, Pos(#10, Output));
  end;

  if Length(Output) > 0 then
  begin
    NewLines.Add(Output);
    ParseOutput(Output);
  end;

  //Add the new lines to the edit control if we have any
  FlushOutputBuffer;

  //Clean up
  NewLines.Free;
  RegExp.Free;
end;

procedure TGDBDebugger.OnSignal(Output: TStringList);
var
  I: Integer;
begin
  for I := 0 to Output.Count - 1 do
  begin
    if Output[I] = 'signal-name' then
      if Output[I + 1] = 'SIGSEGV' then
        OnAccessViolation
      else;
  end;
end;

procedure TGDBDebugger.OnSourceMoreRecent;
begin
  if (MessageDlg(Lang[ID_MSG_SOURCEMORERECENT], mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
    CloseDebugger(nil);
    MainForm.actCompileExecute(nil);
  end;
end;

procedure TGDBDebugger.AddIncludeDir(s: string);
begin
  IncludeDirs.Add(s);
end;

procedure TGDBDebugger.ClearIncludeDirs;
begin
  IncludeDirs.Clear;
end;

procedure TGDBDebugger.AddBreakpoint(breakpoint: TBreakpoint);
var
  aBreakpoint: PBreakpoint;
begin
  if (not Paused) and Executing then
  begin
    MessageDlg('Cannot add a breakpoint while the debugger is executing.', mtError, [mbOK], MainForm.Handle);
    Exit;
  end;

  New(aBreakpoint);
  aBreakpoint^ := breakpoint;
  Breakpoints.Add(aBreakpoint);
  RefreshBreakpoint(aBreakpoint^);
end;

procedure TGDBDebugger.RemoveBreakpoint(breakpoint: TBreakpoint);
var
  I: Integer;
begin
  if (not Paused) and Executing then
  begin
    MessageDlg('Cannot remove a breakpoint while the debugger is executing.', mtError, [mbOK], MainForm.Handle);
    Exit;
  end;

  for i := 0 to Breakpoints.Count - 1 do
  begin
    if (PBreakPoint(Breakpoints.Items[i])^.line = breakpoint.Line) and (PBreakPoint(Breakpoints.Items[i])^.editor = breakpoint.Editor) then
    begin
      if Executing then
        QueueCommand('delete', IntToStr(PBreakpoint(Breakpoints.Items[i])^.Index));
      Dispose(Breakpoints.Items[i]);
      Breakpoints.Delete(i);
      Break;
    end;
  end;
end;

procedure TGDBDebugger.RefreshBreakpoint(var breakpoint: TBreakpoint);
begin
  if Executing then
  begin
    Inc(fNextBreakpoint);
    breakpoint.Index := fNextBreakpoint;
    breakpoint.Valid := True;
    QueueCommand('break', Format('"%s:%d"', [ExtractFileName(breakpoint.Filename), breakpoint.Line]));
  end;
end;

procedure TGDBDebugger.RefreshContext(refresh: ContextDataSet);
var
  I: Integer;
  Node: TTreeNode;
  Command: TCommand;
begin
  if not Executing then
    Exit;

  //First send commands for stack tracing, locals and threads
  if cdCallStack in refresh then
  begin
    Command := TCommand.Create;
    Command.Command := 'bt';
    Command.OnResult := OnCallStack;
    QueueCommand(Command);
  end;
  if cdLocals in refresh then
  begin
    Command := TCommand.Create;
    Command.Command := 'info locals 1';
    Command.OnResult := OnLocals;
    QueueCommand(Command);
  end;
  if cdThreads in refresh then
  begin
    Command := TCommand.Create;
    Command.Command := 'info threads';
    Command.OnResult := OnThreads;
    QueueCommand(Command);
  end;
  if cdDisassembly in refresh then
    Disassemble;
  if cdRegisters in refresh then
    GetRegisters;

  //Then update the watches
  if (cdWatches in refresh) and Assigned(DebugTree) then
  begin
    I := 0;
    while I < DebugTree.Items.Count do
    begin
      Node := DebugTree.Items[I];
      if Node.Data = nil then
        Continue;
      with PWatch(Node.Data)^ do
      begin
        Command := TCommand.Create;
        if Pos('.', Name) > 0 then
          Command.Command := 'display ' + Copy(name, 1, Pos('.', name) - 1)
        else
          Command.Command := 'display ' + name;

        //Fill in the other data
        Command.Data := Node;
        Command.OnResult := OnRefreshContext;
        Node.DeleteChildren;

        //Then send it
        QueueCommand(Command);
      end;

      //Increment our counter
      Inc(I);
    end;
  end;
end;

procedure TGDBDebugger.OnRefreshContext(Output: TStringList);
var
  I: Integer;
  Node: TTreeNode;

  procedure RecurseArray(Parent: TTreeNode; var I: Integer); forward;
  procedure RecurseStructure(Parent: TTreeNode; var I: Integer);
  var
    Child: TTreeNode;
  begin
    while I < Output.Count - 4 do
      if Output[I] = '}' then
        Exit
      else if Pos('{', Output[I + 4]) <> 1 then
      begin
        with DebugTree.Items.AddChild(Parent, Output[I] + ' = ' + Output[I + 4]) do
        begin
          SelectedIndex := 21;
          ImageIndex := 21;
        end;

        Inc(I, 6);
        if (I < Output.Count) and (Pos(',', Output[I]) <> 0) then
          Inc(I, 2);
      end
      else
      begin
        Child := DebugTree.Items.AddChild(Parent, Output[I]);
        with Child do
        begin
          SelectedIndex := 32;
          ImageIndex := 32;
        end;
        
        Inc(I, 6);
        if Pos('array-section-begin', Output[I - 1]) = 1 then
          RecurseArray(Child, I)
        else
          RecurseStructure(Child, I);

        Inc(I, 2);
        if (I < Output.Count) and (Pos(',', Output[I]) = 1) then
          Inc(I, 2);
      end;
  end;

  procedure RecurseArray(Parent: TTreeNode; var I: Integer);
  var
    Child: TTreeNode;
    Count: Integer;
  begin
    Count := 0;
    while (I < Output.Count - 2) do
    begin
      if Output[I] = '}' then
        Break
      else if Pos(',', Output[I]) = 1 then
        Output[I] := Trim(Copy(Output[I], 2, Length(Output[I])));

      if Pos('{', Output[I]) = 1 then
      begin
        Child := DebugTree.Items.AddChild(Parent, Format('[%d]', [Count]));
        with Child do
        begin
          SelectedIndex := 32;
          ImageIndex := 32;
        end;
        
        Inc(I, 2);
        RecurseStructure(Child, I);
      end
      else if (Trim(Output[I]) <> '') and (Output[I] <> 'array-section-end') then
      begin
        with DebugTree.Items.AddChild(Parent, Format('[%d]', [Count]) + ' = ' + Output[I]) do
        begin
          SelectedIndex := 21;
          ImageIndex := 21;
        end;
      end
      else
      begin
        Inc(I);
        Continue;
      end;

      Inc(Count);
      Inc(I, 2);
    end;
  end;
begin
  I := 0;
  Node := TTreeNode(CurrentCommand.Data);
  
  while I < Output.Count do
  begin
    if Output[I] = 'display-expression' then
    begin
      Node.Text := Output[I + 1];
      Node.SelectedIndex := 32;
      Node.ImageIndex := 32;
      
      if Pos('{', Output[I + 5]) = 1 then
      begin
        Inc(I, 7);

        //Determine if it is a structure of an array
        if Pos('array-section-begin', Output[I - 1]) = 1 then
          RecurseArray(Node, I)
        else
          RecurseStructure(Node, I);
      end
      else
        Node.Text := Output[I + 1] + ' = ' + Output[I + 5];
      Break;
    end;
    Inc(I);
  end
end;

procedure TGDBDebugger.AddWatch(varname: string; when: TWatchBreakOn);
var
  Watch: PWatch;
  Command: TCommand;
begin
  with DebugTree.Items.Add(nil, varname + ' = (unknown)') do
  begin
    ImageIndex := 21;
    SelectedIndex := 21;
    New(Watch);
    Watch^.Name := varname;
    Data := Watch;
  end;

  Command := TCommand.Create;
  Command.Data := Pointer(Watch);
  case when of
    wbRead:
      Command.Command := 'rwatch ' + varname;
    wbWrite:
      Command.Command := 'watch ' + varname;
    wbBoth:
      Command.Command := 'awatch ' + varname;
  end;
  Command.OnResult := OnWatchesSet;
  QueueCommand(Command);
end;

procedure TGDBDebugger.RefreshWatches;
var
  I: Integer;
  Command: TCommand;
begin
  for I := 0 to DebugTree.Items.Count - 1 do
    with PWatch(DebugTree.Items[I].Data)^ do
    begin
      Command := TCommand.Create;
      Command.Data := DebugTree.Items[I].Data;
      Command.Command := 'awatch ' + Name;
      Command.OnResult := OnWatchesSet;
      QueueCommand(Command);
    end;
end;

procedure TGDBDebugger.OnWatchesSet(Output: TStringList);
begin
  //TODO: lowjoel: Watch-setting error?
end;

procedure TGDBDebugger.RemoveWatch(varname: string);
var
  node: TTreeNode;
begin
  //Find the top-most node
  node := DebugTree.Selected;
  while Assigned(node) and (Assigned(node.Parent)) do
    node := node.Parent;

  //Then clean it up
  if Assigned(node) then
  begin
    Dispose(node.Data);
    DebugTree.Items.Delete(node);
  end;
end;

procedure TGDBDebugger.ModifyVariable(varname, newvalue: string);
begin
  QueueCommand('set variable', varname + ' = ' + newvalue);
end;

procedure TGDBDebugger.OnCallStack(Output: TStringList);
var
  I: Integer;
  CallStack: TList;
  RegExp: TRegExpr;
  StackFrame: PStackFrame;
begin
  StackFrame := nil;
  CallStack := TList.Create;
  RegExp := TRegExpr.Create;

  I := 0;
  while I < Output.Count do
  begin
    if Pos('frame-begin', Output[I]) = 1 then
    begin
      //Stack frame with source information
      New(StackFrame);
      CallStack.Add(StackFrame);
    end
    else if Output[I] = 'frame-function-name' then
    begin
      Inc(I);
      StackFrame^.FuncName := Output[I]; 
    end
    else if Output[I] = 'frame-args' then
    begin
      Inc(I);

      //Make sure it's valid
      if Output[I] <> ' (' then
      begin
        Inc(I);
        Continue;
      end
      else
        Inc(I);

      while (I < Output.Count - 6) do
      begin
        if Output[I] = 'arg-begin' then
        begin
          if StackFrame^.Args <> '' then
            StackFrame^.Args := StackFrame^.Args + ', ';
          StackFrame^.Args := StackFrame^.Args + Output[I + 1] + ' = ' + Output[I + 5];
        end;
        Inc(I, 6);

        //Do we stop?
        if Trim(Output[I + 1]) <> ',' then
          Break
        else
          Inc(I, 2);
      end;
    end
    else if Output[I] = 'frame-source-file' then
    begin
      Inc(I);
      StackFrame^.Filename := Output[I];
    end
    else if Output[I] = 'frame-source-line' then
    begin
      Inc(I);
      StackFrame^.Line := StrToInt(Output[I]);
    end;
    Inc(I);
  end;

  //Now that we have the entire callstack loaded into our list, call the function
  //that wants it
  if Assigned(TDebugger(Self).OnCallStack) then
    TDebugger(Self).OnCallStack(CallStack);

  //Do we show the new execution point?
  if JumpToCurrentLine then
  begin
    JumpToCurrentLine := False;
    MainForm.GotoTopOfStackTrace;
  end;

  //Clean up
  RegExp.Free;
  CallStack.Free;
end;

procedure TGDBDebugger.OnLocals(Output: TStringList);
var
  I: Integer;
  RegExp: TRegExpr;
  Local: PVariable;
  Locals: TList;

  function SynthesizeIndent(Indent: Integer): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to Indent - 1 do
      Result := Result + ' ';
  end;

  procedure RecurseArray(Indent: Integer; var I: Integer); forward;
  procedure RecurseStructure(Indent: Integer; var I: Integer);
  begin
    while I < Output.Count - 4 do
      if Output[I] = '}' then
        Exit
      else if Pos('{', Output[I + 4]) <> 1 then
      begin
        New(Local);
        Locals.Add(Local);
        with Local^ do
        begin
          Name := SynthesizeIndent(Indent) + Output[I];
          Value := Output[I + 4];
        end;

        Inc(I, 6);
        if (I < Output.Count) and (Pos(',', Output[I]) <> 0) then
          Inc(I, 2);
      end
      else
      begin
        New(Local);
        Locals.Add(Local);
        with Local^ do
        begin
          Name := SynthesizeIndent(Indent) + Output[I];
          Value := '';
        end;
        
        Inc(I, 6);
        if Pos('array-section-begin', Output[I - 1]) = 1 then
          RecurseArray(Indent + 4, I)
        else
          RecurseStructure(Indent + 4, I);

        Inc(I, 2);
        if (I < Output.Count) and (Pos(',', Output[I]) = 1) then
          Inc(I, 2);
      end;
  end;

  procedure RecurseArray(Indent: Integer; var I: Integer);
  var
    Count: Integer;
  begin
    Count := 0;
    while (I < Output.Count - 2) do
    begin
      if Output[I] = '}' then
        Break
      else if Pos(',', Output[I]) = 1 then
        Output[I] := Trim(Copy(Output[I], 2, Length(Output[I])));

      if Pos('{', Output[I]) = 1 then
      begin
        New(Local);
        Locals.Add(Local);
        with Local^ do
          Name := Format('%s[%d]', [SynthesizeIndent(Indent), Count]);
        
        Inc(I, 2);
        RecurseStructure(Indent + 4, I);
      end
      else if (Trim(Output[I]) <> '') and (Output[I] <> 'array-section-end') then
      begin
        New(Local);
        Locals.Add(Local);
        with Local^ do
        begin
          Name := Format('%s[%d]', [SynthesizeIndent(Indent), Count]);
          Value := Output[I];
        end;
      end
      else
      begin
        Inc(I);
        Continue;
      end;

      Inc(Count);
      Inc(I, 2);
    end;
  end;
begin
  RegExp := TRegExpr.Create;
  Locals := TList.Create;

  I := 0;
  while I < Output.Count do
  begin
    if RegExp.Exec(Output[I], '(.*) = (.*)') then
    begin
      New(Local);
      Locals.Add(Local);
      
      if RegExp.Substitute('$2') = '{' then
      begin
        with Local^ do
        begin
          Name := RegExp.Substitute('$1');
          Value := '';
        end;

        Inc(I, 2);
        //Determine if it is a structure of an array
        if Pos('array-section-begin', Output[I - 1]) = 1 then
          RecurseArray(4, I)
        else
          RecurseStructure(4, I);
      end
      else
      begin
        //Fill the fields
        with Local^ do
        begin
          Name := RegExp.Substitute('$1');
          Value := RegExp.Substitute('$2');
        end;
      end;
    end;
    Inc(I);
  end;

  //Pass the locals list to the callback function that wants it
  if Assigned(TDebugger(Self).OnLocals) then
    TDebugger(Self).OnLocals(Locals);

  //Clean up
  Locals.Free;
  RegExp.Free;
end;

procedure TGDBDebugger.OnThreads(Output: TStringList);
var
  I: Integer;
  RegExp: TRegExpr;
  Thread: PDebuggerThread;
  Threads: TList;
begin
  RegExp := TRegExpr.Create;
  Threads := TList.Create;

  for I := 0 to Output.Count - 1 do
    if RegExp.Exec(Output[I], '(\**)( +)([0-9]+)( +)thread ([0-9a-fA-F]*).0x([0-9a-fA-F]*)') then
    begin
      New(Thread);
      Threads.Insert(0, Thread);

      with Thread^ do
      begin
        Active := RegExp.Substitute('$1') = '*';
        Index := RegExp.Substitute('$3');
        ID := RegExp.Substitute('$5.$6');
      end;
    end;

  //Call the callback function to list the threads
  if Assigned(TDebugger(Self).OnThreads) then
    TDebugger(Self).OnThreads(Threads);

  Threads.Free;
  RegExp.Free;
end;

procedure TGDBDebugger.GetRegisters;
var
  Command: TCommand;
begin
  if (not Executing) or (not Paused) then
    Exit;

  RegistersFilled := 0;
  Registers := TRegisters.Create;
  Command := TCommand.Create;
  Command.Command := 'displ/x $eax';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $ebx';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $ecx';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $edx';
  Command.OnResult := OnRegisters;

  QueueCommand(Command);
  Command := TCommand.Create;
  Command.Command := 'displ/x $esi';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $edi';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $ebp';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $esp';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $eip';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $cs';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $ds';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $ss';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $es';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $fs';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $gs';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);

  Command := TCommand.Create;
  Command.Command := 'displ/x $eflags';
  Command.OnResult := OnRegisters;
  QueueCommand(Command);
end;

procedure TGDBDebugger.OnRegisters(Output: TStringList);
var
  I: Integer;
  Reg: String;
  RegExp: TRegExpr;
begin
  RegExp := TRegExpr.Create;

  I := 0;
  while I < Output.Count do
  begin
    if Output[I] = ' = ' then
    begin
      Inc(I, 2);

      //Determine the register
      if RegExp.Exec(CurrentCommand.Command, 'displ/x \$(.*)') then
      begin
        Inc(RegistersFilled);
        Reg := Trim(RegExp.Substitute('$1'));
        if Reg = 'eax' then
          Registers.EAX := Output[I]
        else if Reg = 'ebx' then
          Registers.EBX := Output[I]
        else if Reg = 'ecx' then
          Registers.ECX := Output[I]
        else if Reg = 'edx' then
          Registers.EDX := Output[I]
        else if Reg = 'esi' then
          Registers.ESI := Output[I]
        else if Reg = 'edi' then
          Registers.EDI := Output[I]
        else if Reg = 'ebp' then
          Registers.EBP := Output[I]
        else if Reg = 'eip' then
          Registers.EIP := Output[I]
        else if Reg = 'esp' then
          Registers.ESP := Output[I]
        else if Reg = 'cs' then
          Registers.CS := Output[I]
        else if Reg = 'ds' then
          Registers.DS := Output[I]
        else if Reg = 'ss' then
          Registers.SS := Output[I]
        else if Reg = 'es' then
          Registers.ES := Output[I]
        else if Reg = 'fs' then
          Registers.FS := Output[I]
        else if Reg = 'gs' then
          Registers.GS := Output[I]
        else if Reg = 'eflags' then
          Registers.EFLAGS := Output[I]
        else
          Dec(RegistersFilled);
      end;
    end;
    Inc(I);
  end;

  //Pass the locals list to the callback function that wants it
  if (RegistersFilled = 16) and Assigned(TDebugger(Self).OnRegisters) then
  begin
    TDebugger(Self).OnRegisters(Registers);
    Registers.Free;
  end;

  //Clean up
  RegExp.Free;
end;

procedure TGDBDebugger.Disassemble(func: string);
var
  Command: TCommand;
begin
  if (not Executing) or (not Paused) then
    Exit;

  Command := TCommand.Create;
  Command.Command := 'disas ' + func;
  Command.OnResult := OnDisassemble;
  QueueCommand(Command);
end;

procedure TGDBDebugger.OnDisassemble(Output: TStringList);
begin
  //Delete the first and last entries (Dump of assembler code for function X and End Dump)
  Output.Delete(Output.Count - 1);
  Output.Delete(0);

  //Pass the disassembly to the callback function that wants it
  if Assigned(TDebugger(Self).OnDisassemble) then
    TDebugger(Self).OnDisassemble(Output.Text);
end;

procedure TGDBDebugger.SetAssemblySyntax(syntax: AssemblySyntax);
begin
  case syntax of
   asIntel: QueueCommand('set disassembly-flavor', 'intel');
   asATnT:  QueueCommand('set disassembly-flavor', 'att');
  end;
end;

function TGDBDebugger.GetVariableHint(name: string): string;
var
  Command: TCommand;
begin
  if (not Executing) or (not Paused) then
    Exit;

  Command := TCommand.Create;
  Command.OnResult := OnVariableHint;
  Command.Command := 'print ' + name;

  //Send the command;
  QueueCommand(Command);
end;

procedure TGDBDebugger.OnVariableHint(Output: TStringList);
begin
  //Call the callback
  if Assigned(TDebugger(Self).OnVariableHint) then
    TDebugger(Self).OnVariableHint(Output[0]);
end;

procedure TGDBDebugger.Go;
var
  Command: TCommand;
begin
  Command := TCommand.Create;
  if not Started then
    Command.Command := 'run'
  else
    Command.Command := 'continue';
  Command.Callback := OnGo;
  QueueCommand(Command);
end;

procedure TGDBDebugger.OnGo;
begin
  inherited;
  Started := True;
end;

procedure TGDBDebugger.Next;
var
  Command: TCommand;
begin
  Command := TCommand.Create;
  Command.Command := 'next';
  Command.Callback := OnTrace;
  QueueCommand(Command);
end;

procedure TGDBDebugger.Step;
var
  Command: TCommand;
begin
  Command := TCommand.Create;
  Command.Command := 'step';
  Command.Callback := OnTrace;
  QueueCommand(Command);
end;

procedure TGDBDebugger.OnTrace;
begin
  JumpToCurrentLine := True;
  fPaused := False;
  fBusy := False;
end;

procedure TGDBDebugger.Pause;
begin
  //Do nothing. GDB does not support break-ins.
end;

procedure TGDBDebugger.SetThread(thread: Integer);
begin
  QueueCommand('thread', IntToStr(thread));
  RefreshContext;
end;

procedure TGDBDebugger.SetContext(frame: Integer);
begin
  QueueCommand('frame', IntToStr(frame));
  RefreshContext([cdLocals, cdWatches]);
end;

initialization
  Breakpoints := TList.Create;

finalization
  Breakpoints.Free;

end.
