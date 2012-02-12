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

Unit devrun;

Interface

Uses
{$IFDEF WIN32}
    Classes, Windows, Dialogs, utils, SysUtils;
{$ENDIF}
{$IFDEF LINUX}
  Classes, QDialogs, utils, SysUtils;
{$ENDIF}

Type
    TLineOutputEvent = Procedure(Sender: TObject; Const Line: String) Of Object;

    TDevRun = Class(TThread)
    Private
        hProcess: THandle;
        TheMsg: String;
        CurrentLine: String;
        fExitCode: Cardinal;
        FLineOutput: TLineOutputEvent;
        fCheckAbort: TCheckAbortFunc;
    Protected
        Procedure CallLineOutputEvent;
        Procedure Execute; Override;
        Procedure LineOutput(Line: String);
        Procedure ShowError(Msg: String);
        Procedure ShowMsg;
    Public
        Command: String;
        Directory: String;
        Output: String;
        Procedure Terminate;
        Property OnLineOutput: TLineOutputEvent Read FLineOutput Write FLineOutput;
        Property OnCheckAbort: TCheckAbortFunc Read FCheckAbort Write FCheckAbort;
        Property ExitCode: Cardinal Read fExitCode;
    End;

Implementation

Procedure TDevRun.ShowMsg;
Begin
    utils.ShowError(TheMsg);
End;

Procedure TDevRun.ShowError(Msg: String);
Begin
    TheMsg := Msg;
    Synchronize(ShowMsg);
End;

Procedure TDevRun.Terminate;
Begin
    TerminateProcess(hProcess, 1);
    Inherited;
End;

Procedure TDevRun.CallLineOutputEvent;
Begin
    FLineOutput(Self, CurrentLine);
End;

Procedure TDevRun.LineOutput(Line: String);
Begin
    CurrentLine := Line;
    If Assigned(FLineOutput) Then
        Synchronize(CallLineOutputEvent);
End;

Procedure TDevRun.Execute;
Var
    tsi: TStartupInfo;
    tpi: TProcessInformation;
    nRead: DWORD;
    aBuf: Array[0..101] Of Char;
    sa: TSecurityAttributes;
    hOutputReadTmp, hOutputRead, hOutputWrite, hInputWriteTmp, hInputRead,
    hInputWrite, hErrorWrite: THandle;
    FOutput: String;
    CurrentLine: String;
    bAbort: Boolean;
Begin
    fExitCode := 0;
    hProcess := 0;
    FOutput := '';
    CurrentLine := '';
    sa.nLength := SizeOf(TSecurityAttributes);
    sa.lpSecurityDescriptor := Nil;
    sa.bInheritHandle := True;

    CreatePipe(hOutputReadTmp, hOutputWrite, @sa, 0);
    DuplicateHandle(GetCurrentProcess(), hOutputWrite, GetCurrentProcess(),
        @hErrorWrite, 0, True, DUPLICATE_SAME_ACCESS);
    CreatePipe(hInputRead, hInputWriteTmp, @sa, 0);

    // Create new output read handle and the input write handle. Set
    // the inheritance properties to FALSE. Otherwise, the child inherits
    // the these handles; resulting in non-closeable handles to the pipes
    // being created.
    DuplicateHandle(GetCurrentProcess(), hOutputReadTmp, GetCurrentProcess(),
        @hOutputRead, 0, False, DUPLICATE_SAME_ACCESS);
    DuplicateHandle(GetCurrentProcess(), hInputWriteTmp, GetCurrentProcess(),
        @hInputWrite, 0, False, DUPLICATE_SAME_ACCESS);
    CloseHandle(hOutputReadTmp);
    CloseHandle(hInputWriteTmp);

    FillChar(tsi, SizeOf(TStartupInfo), 0);
    tsi.cb := SizeOf(TStartupInfo);
    tsi.dwFlags := STARTF_USESTDHANDLES Or STARTF_USESHOWWINDOW;
    tsi.hStdInput := hInputRead;
    tsi.hStdOutput := hOutputWrite;
    tsi.hStdError := hErrorWrite;

    If Not CreateProcess(Nil, Pchar(Command), @sa, @sa, True, 0,
        Nil, Pchar(Directory),
        tsi, tpi) Then
    Begin
        Output := 'Unable to run "' + Command + '": ' +
            SysErrorMessage(GetLastError);
        Exit;
    End;

    hProcess := tpi.hProcess;

    // GAR 12/11/2009 wait for thread to initialize
    WaitForInputIdle(hProcess, 10000);

    CloseHandle(hOutputWrite);
    CloseHandle(hInputRead);
    CloseHandle(hErrorWrite);

    bAbort := False;
    Repeat
        If Assigned(FCheckAbort) Then
            FCheckAbort(bAbort);
        If bAbort Then
        Begin
            TerminateProcess(hProcess, 1);
            Break;
        End;

        If (Not ReadFile(hOutputRead, aBuf, 16, nRead, Nil)) Or (nRead = 0) Then
        Begin
            If GetLastError = ERROR_BROKEN_PIPE Then
            Begin
                bAbort := True;
                Break;
            End
            Else
                ShowError('Pipe read error, could not execute file');
        End;
        aBuf[nRead] := #0;
        Output := Output + aBuf;

        CurrentLine := CurrentLine + aBuf;
        If (CurrentLine[Length(CurrentLine)] = #10) Then
        Begin
            Delete(CurrentLine, Length(CurrentLine), 1);
            LineOutput(CurrentLine);
            CurrentLine := '';
        End;
    Until bAbort;

    // GAR 14 Nov 2009 Testing Linux
    If Not GetExitCodeProcess(tpi.hProcess, fExitCode) Then
        fExitCode := $FFFFFFFF;

    CloseHandle(hOutputRead);
    CloseHandle(hInputWrite);
    CloseHandle(tpi.hProcess);
    CloseHandle(tpi.hThread);
End;

End.
