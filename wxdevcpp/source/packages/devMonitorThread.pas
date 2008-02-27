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

unit devMonitorThread;

interface

uses
{$IFDEF WIN32}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, devMonitorTypes, SyncObjs;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, devMonitorTypes, SyncObjs;
{$ENDIF}

const APPMSG_NOTIFYFILECHANGED = WM_USER + 2048;

type
  TdevMonitorThread = class(TThread)
  private
    fOwner: TComponent;
    fFiles: TStrings;
    fNewFiles: TStrings;
    fDirs: TStringList;
    fFileAttrs: TList;
    fShouldQuit: THandle;
    fShouldReload: THandle;
    fReloaded: THandle;
    fNewFilesLock: TCriticalSection;
    hMonitors: array[0..MAXIMUM_WAIT_OBJECTS] of THandle;
    nMonitors: integer;
    procedure BuildDirs;
    procedure Notify;
    procedure CreateMonitors;
    procedure DestroyMonitors;
  public
    constructor Create(AOwner: TComponent; Files: TStrings);
    destructor Destroy; override;
    procedure Execute; override;
    procedure TellToQuit;
    procedure ReloadList(fNewList: TStrings);
  end;

implementation

uses
  devFileMonitor;

var
  ChangeType: TdevMonitorChangeType;
  Filename: string;

procedure TdevMonitorThread.BuildDirs;
var
  I: integer;
  SR: TSearchRec;
  tmp: string;
begin
  I := 0;
  fFileAttrs.Clear;
  while I <= fFiles.Count - 1 do begin
    if FindFirst(fFiles[I], faAnyFile, SR) = 0 then begin
      fFileAttrs.Add(Pointer(SR.Time));
      FindClose(SR);
      Inc(I);
    end
    else
      fFiles.Delete(I);
  end;

  fDirs.Clear;
  for I := 0 to fFiles.Count - 1 do begin
    tmp := ExtractFilePath(fFiles[I]);
    // patch for freeze under Win95 by Frederic Marchal.
    // seems that FindFirstChangeNotification fails under win95
    // if the path ends with a slash...
    if (tmp <> '') and (tmp[Length(tmp)] = '\') then
      Delete(tmp, Length(tmp), 1);
    fDirs.Add(tmp);
  end;
end;

constructor TdevMonitorThread.Create(AOwner: TComponent; Files: TStrings);
begin
  inherited Create(True);

  FreeOnTerminate := False;
  fOwner := AOwner;
  fShouldQuit := CreateEvent(nil, false, false, '');
  fShouldReload := CreateEvent(nil, false, false, '');
  fReloaded := CreateEvent(nil, false, false, '');
  fFiles := TStringList.Create;
  fNewFiles := TStringList.Create;
  fFileAttrs := TList.Create;
  fDirs := TStringList.Create;
  fDirs.Sorted := True;
  fDirs.Duplicates := dupIgnore;
  fFiles.Assign(Files);
  fNewFilesLock := TCriticalSection.Create;
  BuildDirs;
end;

destructor TdevMonitorThread.Destroy;
begin
  fDirs.Free;
  fFileAttrs.Free;
  fFiles.Free;
  fNewFiles.Free;
  fNewFilesLock.Free;
  CloseHandle(fReloaded);
  inherited;
end;

procedure TdevMonitorThread.TellToQuit;
begin
  SetEvent(fShouldQuit);
end;

procedure TdevMonitorThread.ReloadList(fNewList: TStrings);
begin
  fNewFilesLock.Enter;
  fNewFiles.Assign(fNewList);
  fNewFilesLock.Leave;

  SetEvent(fShouldReload);
  WaitForSingleObject(fReloaded, INFINITE);
end;

procedure TdevMonitorThread.CreateMonitors;
var
  I: integer;
begin
  fShouldQuit := CreateEvent(nil, false, false, '');
  fShouldReload := CreateEvent(nil, false, false, '');
  hMonitors[0] := fShouldQuit;
  hMonitors[1] := fShouldReload;
  nMonitors := 2;

  for I := 0 to fDirs.Count - 1 do
  begin
    if (fDirs[I] = '') then continue; 
    hMonitors[nMonitors] := FindFirstChangeNotification(
      PChar(fDirs[I]), False,
      FILE_NOTIFY_CHANGE_LAST_WRITE or FILE_NOTIFY_CHANGE_FILE_NAME
      );
    nMonitors := nMonitors + 1;
  end;
end;

procedure TdevMonitorThread.DestroyMonitors;
var
  I: integer;
begin
  for I := 2 to fDirs.Count + 1 do
    FindCloseChangeNotification(hMonitors[I]);

{$IFDEF RELEASE}
  CloseHandle(fShouldQuit);
  CloseHandle(fShouldReload);
{$ENDIF}
end;

procedure TdevMonitorThread.Execute;
var
  SR: TSearchRec;
  I: integer;
  T: integer;
  iState: UINT;
  state: integer;
begin
  inherited;
  CreateMonitors;

  while True do
  begin
    iState := WaitForMultipleObjects(nMonitors, @hMonitors, False, INFINITE);
    if iState = WAIT_FAILED then
      Continue;

    iState := iState - WAIT_OBJECT_0;
    State := Integer(iState);
    if State = 0 then //asked to quit
      Break
    else if State = 1 then //asked to rebuild
    begin
      DestroyMonitors;
      fNewFilesLock.Enter;
      fFiles.Assign(fNewFiles);
      fNewFilesLock.Leave;

      BuildDirs;
      CreateMonitors;
      SetEvent(fReloaded);
      continue;
    end
    else
      for I := 0 to fFiles.Count - 1 do
      begin
        if FindFirst(fFiles[I], faAnyFile, SR) = 0 then
        begin
          T := Integer(fFileAttrs[I]);
          if (T <> -1) and (T < SR.Time) then begin
            fFileAttrs[I] := Pointer(SR.Time);
            ChangeType := mctChanged;
            Filename := fFiles[I];
            Notify;
          end;
          FindClose(SR);
        end
        else
        begin
          //Process the notification
          ChangeType := mctDeleted;
          Filename := fFiles[I];
          Notify;
        end;
      end;

    //Refresh all the monitors
    for I := 2 to fDirs.Count + 1 do
      FindNextChangeNotification(hMonitors[I]);
  end;
  
  DestroyMonitors;
  Terminate;
end;

procedure TdevMonitorThread.Notify;
var
  P: PChar;
begin
  P := StrNew(PChar(Filename));
  PostMessage(TdevFileMonitor(fOwner).Handle, APPMSG_NOTIFYFILECHANGED, integer(ChangeType), LPARAM(P));
end;

end.

