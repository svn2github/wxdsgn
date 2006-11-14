{
  syn
  Copyright (C) 2000-2003, Ascher Stefan. All rights reserved.
  stievie@utanet.at, http://web.utanet.at/ascherst/

  The contents of this file are subject to the Mozilla Public License
  Version 1.1 (the "License"); you may not use this file except in compliance
  with the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/

  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
  the specific language governing rights and limitations under the License.

  The Original Code is uFileWatch.pas, released Fri, 23 Aug 2002 17:30:24 UTC.

  The Initial Developer of the Original Code is Ascher Stefan.
  Portions created by Ascher Stefan are Copyright (C) 2000-2003 Ascher Stefan.
  All Rights Reserved.

  Contributor(s): .

  Alternatively, the contents of this file may be used under the terms of the
  GNU General Public License Version 2 or later (the "GPL"), in which case
  the provisions of the GPL are applicable instead of those above.
  If you wish to allow use of your version of this file only under the terms
  of the GPL and not to allow others to use your version of this file
  under the MPL, indicate your decision by deleting the provisions above and
  replace them with the notice and other provisions required by the GPL.
  If you do not delete the provisions above, a recipient may use your version
  of this file under either the MPL or the GPL.

  You may retrieve the latest version of this file at the syn home page,
  located at http://syn.sourceforge.net/

 $Id$
}

unit uFileWatch;


interface

uses
  Windows, SysUtils, Classes;

type
  TChangeType = (ctTime, ctDeleted);
  TChangeEvent = procedure(Sender: TObject; ChangeType: TChangeType) of object;
  TFileWatch = class(TThread)
  private
    FFileName     : string;
    FOnFileChanged: TChangeEvent;
    FHandle       : THandle;
    FLastTime     : TFileTime;
    FActive,
    FMonitoring   : boolean;
{$ifdef SYN_DEBUG}
    FThreadID: integer;
{$endif}
    procedure ReleaseHandle;
    procedure AllocateHandle;
    procedure SetFileName(const Value: String);
  protected
    procedure Execute; override;
    procedure Notify;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Suspend;
    procedure Resume;
    procedure Reset;
  published
    property FileName: String read FFileName write SetFileName;
    property LastTime: TFileTime read FLastTime write FLastTime;
    property Active: boolean read FActive write FActive;
    property Monitoring: boolean read FMonitoring;
    property OnNotify: TChangeEvent read FOnFileChanged write FOnFileChanged;
  end;

implementation

//uses
//  uGlobals;

{$ifdef SYN_DEBUG}
threadvar
  dbgThreadCount: integer;
{$endif}

function GetFileLastWrite(const FileName: string): TFileTime;
var
  r: TSearchRec;
begin
  if FindFirst(FileName, faAnyFile, r) = 0 then begin
    SysUtils.FindClose(r);
    {$WARNINGS OFF}
    Result := r.FindData.ftLastWriteTime;
    {$WARNINGS ON}
  end else begin
    Result.dwLowDateTime := 0;
    Result.dwHighDateTime := 0;
  end;
end;

function SameFileTime(t1, t2: TFileTime): boolean;
begin
  Result := (t1.dwHighDateTime = t2.dwHighDateTime) and
    (t1.dwLowDateTime = t2.dwLowDateTime);
end;

{ TFileWatch }

constructor TFileWatch.Create;
begin
  inherited Create(false);
{$ifdef SYN_DEBUG}
  FThreadID := dbgThreadCount;
  Inc(dbgThreadCount);
  OutputDebugString(PChar('Create FileWatch Thread, count ' + IntToStr(dbgThreadCount)));
{$endif}
  FreeOnTerminate := false;
  FActive := true;
  FMonitoring := false;
  Priority := tpLowest;
end;

destructor TFileWatch.Destroy;
begin
  ReleaseHandle;
{$ifdef SYN_DEBUG}
  Dec(dbgThreadCount);
  OutputDebugString(PChar('Destroy FileWatch Thread, count ' + IntToStr(dbgThreadCount)));
{$endif}
  inherited Destroy;
end;

procedure TFileWatch.Suspend;
begin
  ReleaseHandle;
  FActive := false;
  inherited Suspend;
end;

procedure TFileWatch.Resume;
begin
  AllocateHandle;
  FActive := true;
  FLastTime := GetFileLastWrite(FFileName);   // Get the latest filetime
  inherited Resume;
end;

procedure TFileWatch.Notify;
var
  t: TChangeType;
begin
  if not SameFileTime(FLastTime, GetFileLastWrite(FFileName)) then begin
    if FActive then begin
      ReleaseHandle;
      if FileExists(FFileName) then
        t := ctTime
      else
        t := ctDeleted;
      if Assigned(FOnFileChanged) then FOnFileChanged(Self, t);
    end;
    FLastTime := GetFileLastWrite(FFileName);   // Get the latest filetime
    if FActive then AllocateHandle;
  end;
end;

procedure TFileWatch.SetFileName(const Value :String);
begin
  if not SameText(Value, FFileName) then begin
    FFileName := Value;
    FLastTime := GetFileLastWrite(Value);
    Reset;
  end;
end;

procedure TFileWatch.Execute;
begin
  while not Terminated do begin
    if FHandle <> 0 then begin
      if WaitForSingleObject(FHandle, 500) = WAIT_OBJECT_0 then begin
        Synchronize(Notify);
        FindNextChangeNotification(FHandle);
      end;
    end else
      Sleep(10);   // ~99% CPU usage
  end;
end;

procedure TFileWatch.ReleaseHandle;
begin
{$ifdef SYN_DEBUG}
  OutputDebugString(PChar('Thread ' + IntToStr(FThreadID) + ' released Handle'));
{$endif}
  FindCloseChangeNotification(FHandle);
  FHandle := 0;
  FMonitoring := false;
end;

procedure TFileWatch.AllocateHandle;
  function DoAllocate: THandle;
  begin
{$ifdef SYN_DEBUG}
    OutputDebugString(PChar('Thread ' + IntToStr(FThreadID) + ' allocates Handle'));
{$endif}
    Result := FindFirstChangeNotification(PChar(ExtractFilePath(FFileName)), Bool(0),
      FILE_NOTIFY_CHANGE_LAST_WRITE or FILE_NOTIFY_CHANGE_FILE_NAME);
    if Result = INVALID_HANDLE_VALUE then begin
      FMonitoring := false;
      Result := 0;
    end else
      FMonitoring := true;
  end;
begin
  try
    if FileExists(FFileName) then
      FHandle := DoAllocate
    else
      FHandle := 0;        // File doesn't exist anymore
  except
    ReleaseHandle;
    raise;
  end;
end;

procedure TFileWatch.Reset;
begin
  ReleaseHandle;
  if FileExists(FFileName) then begin
    FLastTime := GetFileLastWrite(FFileName);   // Get the latest filetime
    AllocateHandle;
  end;
end;

end.
