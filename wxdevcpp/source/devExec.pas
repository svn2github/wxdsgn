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

Unit devExec;

Interface

Uses
{$IFDEF WIN32}
    Windows, Classes;
{$ENDIF}
{$IFDEF LINUX}
  Classes;
{$ENDIF}

Type
    TExecThread = Class(TThread)
    Private
        fFile: String;
        fPath: String;
        fParams: String;
        fTimeOut: Cardinal;
        fProcess: Cardinal;
        fVisible: Boolean;
        Procedure ExecAndWait;
    Public
        Procedure Execute; Override;
    Published
        Property FileName: String Read fFile Write fFile;
        Property Path: String Read fPath Write fPath;
        Property Params: String Read fParams Write fParams;
        Property TimeOut: Cardinal Read fTimeOut Write fTimeOut;
        Property Visible: Boolean Read fVisible Write fVisible;
        Property Process: Cardinal Read fProcess;
    End;

    TdevExecutor = Class(TPersistent)
    Private
        fExec: TExecThread;
        fIsRunning: Boolean;
        fOnTermEvent: TNotifyEvent;
        Procedure TerminateEvent(Sender: TObject);
    Public
        Class Function devExecutor: TdevExecutor;
        Procedure Reset;
        Procedure ExecuteAndWatch(sFileName, sParams, sPath: String;
            bVisible: Boolean; iTimeOut: Cardinal; OnTermEvent: TNotifyEvent);
    Published
        Property Running: Boolean Read fIsRunning;
    End;

Function devExecutor: TdevExecutor;

Implementation

{ TExecThread }

Procedure TExecThread.Execute;
Begin
    Inherited;
    ExecAndWait;
End;

Procedure TExecThread.ExecAndWait;
// Author    : Francis Parlant.
// Update    : Bill Rinko-Gay
// Adaptation: Yiannis Mandravellos
Var
    StartupInfo: TStartupInfo;
    ProcessInfo: TProcessInformation;
Begin
    FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
    With StartupInfo Do
    Begin
        cb := SizeOf(TStartupInfo);
        dwFlags := STARTF_USESHOWWINDOW Or STARTF_FORCEONFEEDBACK;
        If fVisible Then
            wShowWindow := SW_SHOW
        Else
            wShowWindow := SW_HIDE;
    End;
    If CreateProcess(Nil, Pchar(fFile + ' ' + fParams), Nil, Nil, False,
        NORMAL_PRIORITY_CLASS, Nil, Pchar(fPath),
        StartupInfo, ProcessInfo) Then
    Begin
        fProcess := ProcessInfo.hProcess;
        WaitForSingleObject(ProcessInfo.hProcess, fTimeOut);
    End;
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
End;

Var
    fDevExecutor: TdevExecutor = Nil;

Function devExecutor: TdevExecutor;
Begin
    If Not Assigned(fDevExecutor) Then
    Begin
        Try
            fDevExecutor := TdevExecutor.Create;
        Finally
        End;
    End;
    Result := fDevExecutor;
End;

{ TdevExecutor }

Class Function TdevExecutor.devExecutor: TdevExecutor;
Begin
    Result := devExec.devExecutor;
End;

Procedure TdevExecutor.ExecuteAndWatch(sFileName, sParams, sPath: String;
    bVisible: Boolean; iTimeOut: Cardinal; OnTermEvent: TNotifyEvent);
Begin

    fIsRunning := True;
    fOnTermEvent := OnTermEvent;
    fExec := TExecThread.Create(True);
    With fExec Do
    Begin
        FileName := sFileName;
        Params := sParams;
        Path := sPath;
        TimeOut := iTimeOut;
        Visible := bVisible;
        OnTerminate := TerminateEvent;
        FreeOnTerminate := True;
        Resume;
    End;
End;

Procedure TdevExecutor.Reset;
Begin
    If Assigned(fExec) Then
    Begin
        TerminateProcess(fExec.Process, 0);
    End;
    fIsRunning := False;

End;

Procedure TdevExecutor.TerminateEvent(Sender: TObject);
Begin

    fIsRunning := False;
    If Assigned(fOnTermEvent) Then
        fOnTermEvent(Self);
End;

Initialization

Finalization
    If Assigned(fDevExecutor) Then
        fDevExecutor.Free;

End.
