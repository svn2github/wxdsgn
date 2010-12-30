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

unit devrun;

interface

uses
{$IFDEF WIN32}
    Classes, Windows, Dialogs, utils, SysUtils;
{$ENDIF}
{$IFDEF LINUX}
  Classes, QDialogs, utils, SysUtils;
{$ENDIF}

type
    TLineOutputEvent = procedure(Sender: TObject; const Line: String) of Object;

    TDevRun = class(TThread)
    private
        hProcess: THandle;
        TheMsg: String;
        CurrentLine: String;
        fExitCode: Cardinal;
        FLineOutput: TLineOutputEvent;
        fCheckAbort: TCheckAbortFunc;
    protected
        procedure CallLineOutputEvent;
        procedure Execute; override;
        procedure LineOutput(Line: String);
        procedure ShowError(Msg: String);
        procedure ShowMsg;
    public
        Command: string;
        Directory: string;
        Output: string;
        procedure Terminate;
        property OnLineOutput: TLineOutputEvent read FLineOutput write FLineOutput;
        property OnCheckAbort: TCheckAbortFunc read FCheckAbort write FCheckAbort;
        property ExitCode: Cardinal read fExitCode;
    end;

implementation

procedure TDevRun.ShowMsg;
begin
    utils.ShowError(TheMsg);
end;

procedure TDevRun.ShowError(Msg: String);
begin
    TheMsg := Msg;
    Synchronize(ShowMsg);
end;

procedure TDevRun.Terminate;
begin
    TerminateProcess(hProcess, 1);
    inherited;
end;

procedure TDevRun.CallLineOutputEvent;
begin
    FLineOutput(Self, CurrentLine);
end;

procedure TDevRun.LineOutput(Line: String);
begin
    CurrentLine := Line;
    if Assigned(FLineOutput) then
        Synchronize(CallLineOutputEvent);
end;

procedure TDevRun.Execute;
var
    tsi: TStartupInfo;
    tpi: TProcessInformation;
    nRead: DWORD;
    aBuf: array[0..101] of char;
    sa: TSecurityAttributes;
    hOutputReadTmp, hOutputRead, hOutputWrite, hInputWriteTmp, hInputRead,
    hInputWrite, hErrorWrite: THandle;
    FOutput: string;
    CurrentLine: String;
    bAbort: boolean;
begin
    fExitCode := 0;
    hProcess := 0;
    FOutput := '';
    CurrentLine := '';
    sa.nLength := SizeOf(TSecurityAttributes);
    sa.lpSecurityDescriptor := nil;
    sa.bInheritHandle := True;

    CreatePipe(hOutputReadTmp, hOutputWrite, @sa, 0);
    DuplicateHandle(GetCurrentProcess(), hOutputWrite, GetCurrentProcess(),
        @hErrorWrite, 0, true, DUPLICATE_SAME_ACCESS);
    CreatePipe(hInputRead, hInputWriteTmp, @sa, 0);

    // Create new output read handle and the input write handle. Set
    // the inheritance properties to FALSE. Otherwise, the child inherits
    // the these handles; resulting in non-closeable handles to the pipes
    // being created.
    DuplicateHandle(GetCurrentProcess(), hOutputReadTmp, GetCurrentProcess(),
        @hOutputRead, 0, false, DUPLICATE_SAME_ACCESS);
    DuplicateHandle(GetCurrentProcess(), hInputWriteTmp, GetCurrentProcess(),
        @hInputWrite, 0, false, DUPLICATE_SAME_ACCESS);
    CloseHandle(hOutputReadTmp);
    CloseHandle(hInputWriteTmp);

    FillChar(tsi, SizeOf(TStartupInfo), 0);
    tsi.cb := SizeOf(TStartupInfo);
    tsi.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
    tsi.hStdInput := hInputRead;
    tsi.hStdOutput := hOutputWrite;
    tsi.hStdError := hErrorWrite;

    if not CreateProcess(nil, PChar(Command), @sa, @sa, true, 0,
        nil, PChar(Directory),
        tsi, tpi) then
    begin
        Output := 'Unable to run "' + Command + '": ' +
            SysErrorMessage(GetLastError);
        Exit;
    end;

    hProcess := tpi.hProcess;

    // GAR 12/11/2009 wait for thread to initialize
    WaitForInputIdle(hProcess, 10000);

    CloseHandle(hOutputWrite);
    CloseHandle(hInputRead);
    CloseHandle(hErrorWrite);

    bAbort := False;
    repeat
        if Assigned(FCheckAbort) then
            FCheckAbort(bAbort);
        if bAbort then
        begin
            TerminateProcess(hProcess, 1);
            Break;
        end;

        if (not ReadFile(hOutputRead, aBuf, 16, nRead, nil)) or (nRead = 0) then
        begin
            if GetLastError = ERROR_BROKEN_PIPE then
            begin
                bAbort := true;
                Break;
            end
            else
                ShowError('Pipe read error, could not execute file');
        end;
        aBuf[nRead] := #0;
        Output := Output + aBuf;

        CurrentLine := CurrentLine + aBuf;
        if (CurrentLine[Length(CurrentLine)] = #10) then
        begin
            Delete(CurrentLine, Length(CurrentLine), 1);
            LineOutput(CurrentLine);
            CurrentLine := '';
        end;
    until bAbort;

    // GAR 14 Nov 2009 Testing Linux
    if not GetExitCodeProcess(tpi.hProcess, fExitCode) then
        fExitCode := $FFFFFFFF;

    CloseHandle(hOutputRead);
    CloseHandle(hInputWrite);
    CloseHandle(tpi.hProcess);
    CloseHandle(tpi.hThread);
end;

end.
