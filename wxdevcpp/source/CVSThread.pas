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

Unit CVSThread;

Interface

Uses
{$IFDEF WIN32}
    Classes, Windows, SysUtils, StrUtils, utils;
{$ENDIF}
{$IFDEF LINUX}
  Classes, SysUtils, StrUtils, utils;
{$ENDIF}

Type
    TLineOutputEvent = Procedure(Sender: TObject; Const Line: String) Of Object;
    TNeedPasswordEvent = Procedure(Var Passwd: String) Of Object;

    TCVSThread = Class(TThread)
    Private
        CurrentLine: String;
        fPasswd: String;
        FLineOutput: TLineOutputEvent;
        fCheckAbort: TCheckAbortFunc;
        fNeedPassword: TNeedPasswordEvent;
        // procedure TypePassword(Pass: string);
    Protected
        Procedure Execute; Override;
        Procedure CallLineOutputEvent;
        Procedure LineOutput(Line: String);
        Procedure CallNeedPassword;
        Function RunCVSCommand(WindowTitle, Cmd, WorkingDir: String): String;
    Public
        Command: String;
        Directory: String;
        Output: String;
        Property OnLineOutput: TLineOutputEvent Read FLineOutput Write FLineOutput;
        Property OnCheckAbort: TCheckAbortFunc Read FCheckAbort Write FCheckAbort;
        Property OnNeedPassword: TNeedPasswordEvent
            Read fNeedPassword Write fNeedPassword;
    End;

Implementation

Procedure TCVSThread.CallLineOutputEvent;
Begin
    FLineOutput(Self, CurrentLine);
End;

Procedure TCVSThread.CallNeedPassword;
Begin
    fPasswd := '';
    If Assigned(fNeedPassword) Then
        fNeedPassword(fPasswd);
End;

Procedure TCVSThread.LineOutput(Line: String);
Begin
    CurrentLine := Line;
    If Assigned(FLineOutput) Then
        Synchronize(CallLineOutputEvent);
End;

Procedure TCVSThread.Execute;
Begin
    Output := RunCVSCommand('Dev-C++ CVS process', Command, Directory);
End;

Function TCVSThread.RunCVSCommand(WindowTitle, Cmd, WorkingDir:
    String): String;
Var
    tsi: TStartupInfo;
    tpi: TProcessInformation;
    nRead: DWORD;
    //  hWin: HWND;
    aBuf: Array[0..4095] Of Char;
    sa: TSecurityAttributes;
    hOutputReadTmp, hOutputRead, hOutputWrite, hErrorWrite: THandle;
    //  hInputWriteTmp, hInputRead, hInputWrite: THandle;
    FOutput: String;
    CurrentLine: String;
    bAbort: Boolean;
    idx: Integer;
Begin
    FOutput := '';
    CurrentLine := '';
    sa.nLength := SizeOf(TSecurityAttributes);
    sa.lpSecurityDescriptor := Nil;
    sa.bInheritHandle := True;

    CreatePipe(hOutputReadTmp, hOutputWrite, @sa, 0);
    DuplicateHandle(GetCurrentProcess(), hOutputWrite, GetCurrentProcess(),
        @hErrorWrite, 0, False, DUPLICATE_SAME_ACCESS);

    // CL: removed all input redirection, causes too much troubles
    // CreatePipe(hInputRead, hInputWriteTmp, @sa, 0);

    // Create new output read handle and the input write handle. Set
    // the inheritance properties to FALSE. Otherwise, the child inherits
    // the these handles; resulting in non-closeable handles to the pipes
    // being created.
    DuplicateHandle(GetCurrentProcess(), hOutputReadTmp, GetCurrentProcess(),
        @hOutputRead, 0, False, DUPLICATE_SAME_ACCESS);
    //DuplicateHandle(GetCurrentProcess(), hInputWriteTmp, GetCurrentProcess(),
    //  @hInputWrite, 0, false, DUPLICATE_SAME_ACCESS);
    CloseHandle(hOutputReadTmp);
    //CloseHandle(hInputWriteTmp);

    FillChar(tsi, SizeOf(TStartupInfo), 0);
    tsi.cb := SizeOf(TStartupInfo);
    tsi.lpTitle := Pchar(WindowTitle);
    tsi.dwFlags := STARTF_USESTDHANDLES Or STARTF_USESHOWWINDOW;
    //tsi.hStdInput := hInputRead;
    tsi.hStdOutput := hOutputWrite;
    tsi.hStdError := hOutputWrite;
    tsi.wShowWindow := SW_SHOW; //SW_HIDE;

    If Not CreateProcess(Nil, Pchar(Cmd), @sa, @sa, True,
        CREATE_NEW_CONSOLE, Nil, Pchar(WorkingDir),
        tsi, tpi) Then
    Begin
        LineOutput('unable to run program file: ' + SysErrorMessage(GetLastError));
        exit;
    End;
    CloseHandle(hOutputWrite);
    // CloseHandle(hInputRead);
    CloseHandle(hErrorWrite);

    Repeat
        If Assigned(fCheckAbort) Then
            fCheckAbort(bAbort);
        If bAbort Then
            Break;

        FillChar(aBuf, sizeof(aBuf), 0);
        If (Not ReadFile(hOutputRead, aBuf, sizeof(aBuf), nRead, Nil)) Or
            (nRead = 0) Then
        Begin
            If GetLastError = ERROR_BROKEN_PIPE Then
                Break
            Else
                LineOutput('Pipe read error, could not execute command');
        End;
        aBuf[nRead] := #0;
        FOutput := FOutput + Pchar(@aBuf[0]);

        CurrentLine := CurrentLine + Pchar(@aBuf[0]);
        Repeat
            idx := Pos(#10, CurrentLine);
            If idx > 0 Then
            Begin
                LineOutput(Copy(CurrentLine, 1, idx - 1));
                Delete(CurrentLine, 1, idx);
            End;
        Until idx = 0;

    {  if AnsiEndsText('password:', Trim(FOutput)) then begin
        LineOutput(CurrentLine);
        CurrentLine := '';
        Synchronize(CallNeedPassword);
        hWin := FindWindow(nil, PChar(WindowTitle));
        if hWin > 0 then begin
          ShowWindow(hWin, SW_SHOW);
          SetForegroundWindow(hWin);
          TypePassword(fPasswd);
          ShowWindow(hWin, SW_HIDE);
        end
        else begin
          LineOutput('Failed to supply password...');
          TerminateProcess(tpi.hProcess, 65534);
          Break;
        end;
      end;}
        //    else begin
        //      CurrentLine := CurrentLine + PChar(@aBuf[0]);
        //      if CurrentLine[Length(CurrentLine)] = #10 then
        //      begin
        //        Delete(CurrentLine, Length(CurrentLine), 1);
        //        LineOutput(CurrentLine);
        //        CurrentLine := '';
        //      end;
        //    end;
    Until False;
    If bAbort Then
        TerminateProcess(tpi.hProcess, 65535);
    GetExitCodeProcess(tpi.hProcess, nRead);
    Result := FOutput + ' ' + IntToStr(nRead);
End;

//procedure TCVSThread.TypePassword(Pass: string);
//var
//  Key: Byte;
//  I: integer;
//begin
//  for I := 1 to Length(Pass) do begin
//    Key := VkKeyScan(Pass[I]);
//    keybd_event(LoByte(Key), 0, 0, 0);
//    keybd_event(LoByte(Key), 0, KEYEVENTF_KEYUP, 0);
//  end;
//{$IFDEF WIN32}
//  keybd_event(VK_RETURN, 0, 0, 0);
//  keybd_event(VK_RETURN, 0, KEYEVENTF_KEYUP, 0);
//{$ENDIF}
//{$IFDEF LINUX}
//  keybd_event(XK_RETURN, 0, 0, 0);
//  keybd_event(XK_RETURN, 0, KEYEVENTF_KEYUP, 0);
//{$ENDIF}
//end;

End.
