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

Unit devMonitorThread;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, devMonitorTypes, SyncObjs;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, devMonitorTypes, SyncObjs;
{$ENDIF}

Const APPMSG_NOTIFYFILECHANGED = WM_USER + 2048;

Type
    TdevMonitorThread = Class(TThread)
    Private
        fOwner: TComponent;
        fFiles: TStrings;
        fNewFiles: TStrings;
        fDirs: TStringList;
        fFileAttrs: TList;
        fShouldQuit: THandle;
        fShouldReload: THandle;
        fReloaded: THandle;
        fNewFilesLock: TCriticalSection;
        hMonitors: Array[0..MAXIMUM_WAIT_OBJECTS] Of THandle;
        nMonitors: Integer;
        Procedure BuildDirs;
        Procedure Notify;
        Procedure CreateMonitors;
        Procedure DestroyMonitors;
    Public
        Constructor Create(AOwner: TComponent; Files: TStrings);
        Destructor Destroy; Override;
        Procedure Execute; Override;
        Procedure TellToQuit;
        Procedure ReloadList(fNewList: TStrings);
    End;

Implementation

Uses
    devFileMonitor;

Var
    ChangeType: TdevMonitorChangeType;
    Filename: String;

Procedure TdevMonitorThread.BuildDirs;
Var
    I: Integer;
    SR: TSearchRec;
    tmp: String;
Begin
    I := 0;
    fFileAttrs.Clear;
    While I <= fFiles.Count - 1 Do
    Begin
        If FindFirst(fFiles[I], faAnyFile, SR) = 0 Then
        Begin
            fFileAttrs.Add(Pointer(SR.Time));
            FindClose(SR);
            Inc(I);
        End
        Else
            fFiles.Delete(I);
    End;

    fDirs.Clear;
    For I := 0 To fFiles.Count - 1 Do
    Begin
        tmp := ExtractFilePath(fFiles[I]);
    // patch for freeze under Win95 by Frederic Marchal.
    // seems that FindFirstChangeNotification fails under win95
    // if the path ends with a slash...
        If (tmp <> '') And (tmp[Length(tmp)] = '\') Then
            Delete(tmp, Length(tmp), 1);
        fDirs.Add(tmp);
    End;
End;

Constructor TdevMonitorThread.Create(AOwner: TComponent; Files: TStrings);
Begin
    Inherited Create(True);

    FreeOnTerminate := False;
    fOwner := AOwner;
    fShouldQuit := CreateEvent(Nil, False, False, '');
    fShouldReload := CreateEvent(Nil, False, False, '');
    fReloaded := CreateEvent(Nil, False, False, '');
    fFiles := TStringList.Create;
    fNewFiles := TStringList.Create;
    fFileAttrs := TList.Create;
    fDirs := TStringList.Create;
    fDirs.Sorted := True;
    fDirs.Duplicates := dupIgnore;
    fFiles.Assign(Files);
    fNewFilesLock := TCriticalSection.Create;
    BuildDirs;
End;

Destructor TdevMonitorThread.Destroy;
Begin
    fDirs.Free;
    fFileAttrs.Free;
    fFiles.Free;
    fNewFiles.Free;
    fNewFilesLock.Free;
    CloseHandle(fReloaded);
    Inherited;
End;

Procedure TdevMonitorThread.TellToQuit;
Begin
    SetEvent(fShouldQuit);
End;

Procedure TdevMonitorThread.ReloadList(fNewList: TStrings);
Begin
    fNewFilesLock.Enter;
    fNewFiles.Assign(fNewList);
    fNewFilesLock.Leave;

    SetEvent(fShouldReload);
    WaitForSingleObject(fReloaded, INFINITE);
End;

Procedure TdevMonitorThread.CreateMonitors;
Var
    I: Integer;
Begin
    fShouldQuit := CreateEvent(Nil, False, False, '');
    fShouldReload := CreateEvent(Nil, False, False, '');
    hMonitors[0] := fShouldQuit;
    hMonitors[1] := fShouldReload;
    nMonitors := 2;

    For I := 0 To fDirs.Count - 1 Do
    Begin
        If (fDirs[I] = '') Then
            continue;
        hMonitors[nMonitors] := FindFirstChangeNotification(
            Pchar(fDirs[I]), False,
            FILE_NOTIFY_CHANGE_LAST_WRITE Or FILE_NOTIFY_CHANGE_FILE_NAME
            );
        nMonitors := nMonitors + 1;
    End;
End;

Procedure TdevMonitorThread.DestroyMonitors;
Var
    I: Integer;
Begin
    For I := 2 To fDirs.Count + 1 Do
        FindCloseChangeNotification(hMonitors[I]);

{$IFDEF RELEASE}
  CloseHandle(fShouldQuit);
  CloseHandle(fShouldReload);
{$ENDIF}
End;

Procedure TdevMonitorThread.Execute;
Var
    SR: TSearchRec;
    I: Integer;
    T: Integer;
    iState: UINT;
    state: Integer;
Begin
    Inherited;
    CreateMonitors;

    While True Do
    Begin
        iState := WaitForMultipleObjects(nMonitors, @hMonitors, False, INFINITE);
        If iState = WAIT_FAILED Then
            Continue;

        iState := iState - WAIT_OBJECT_0;
        State := Integer(iState);
        If State = 0 Then //asked to quit
            Break
        Else
        If State = 1 Then //asked to rebuild
        Begin
            DestroyMonitors;
            fNewFilesLock.Enter;
            fFiles.Assign(fNewFiles);
            fNewFilesLock.Leave;

            BuildDirs;
            CreateMonitors;
            SetEvent(fReloaded);
            continue;
        End
        Else
            For I := 0 To fFiles.Count - 1 Do
            Begin
                If FindFirst(fFiles[I], faAnyFile, SR) = 0 Then
                Begin
                    T := Integer(fFileAttrs[I]);
                    If (T <> -1) And (T < SR.Time) Then
                    Begin
                        fFileAttrs[I] := Pointer(SR.Time);
                        ChangeType := mctChanged;
                        Filename := fFiles[I];
                        Notify;
                    End;
                    FindClose(SR);
                End
                Else
                Begin
          //Process the notification
                    ChangeType := mctDeleted;
                    Filename := fFiles[I];
                    Notify;
                End;
            End;

    //Refresh all the monitors
        For I := 2 To fDirs.Count + 1 Do
            FindNextChangeNotification(hMonitors[I]);
    End;

    DestroyMonitors;
    Terminate;
End;

Procedure TdevMonitorThread.Notify;
Var
    P: Pchar;
Begin
    P := StrNew(Pchar(Filename));
    PostMessage(TdevFileMonitor(fOwner).Handle, APPMSG_NOTIFYFILECHANGED, Integer(ChangeType), LPARAM(P));
End;

End.
