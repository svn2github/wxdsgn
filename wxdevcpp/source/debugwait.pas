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

unit debugwait;

interface

uses
  Sysutils, Classes, version, StrUtils,
{$IFDEF WIN32}
  Windows, ShellAPI, Dialogs, ComCtrls, Forms;
{$ENDIF}
{$IFDEF LINUX}
  QDialogs, QComCtrls, QForms;
{$ENDIF}

type
  TDebugReader = class(TThread)
  protected
    fEvent: THandle;
    hInputPipe: THandle;
    OutputCrit: TRTLCriticalSection;
    procedure Execute; override;

  public
    Output: string;
    property Event: THandle write fEvent;
    property Pipe: THandle write hInputPipe;
    constructor Create(start: Boolean);
    destructor Destroy; override;
  end;

  TDebugWait = class(TThread)
  public
    Stop: Boolean;
    Event: THandle;
    Reader: TDebugReader;
    OnOutput: procedure(s: string) of object;
    OutputTerminators: TStringList;

    constructor Create(start: Boolean);
    destructor Destroy; override;

  protected
    procedure Execute; override;
    procedure Update;
  end;

implementation

uses 
  main, devcfg, utils, debugger, RegExpr; // dbugintf,  EAB removed Gexperts debug stuff.

constructor TDebugReader.Create(start: Boolean);
begin
  inherited;
  InitializeCriticalSection(OutputCrit);
end;

destructor TDebugReader.Destroy;
begin
  EnterCriticalSection(OutputCrit);
  DeleteCriticalSection(OutputCrit);
  inherited;
end;

procedure TDebugReader.Execute;
var
  Buffer: array[0..1024] of char;
  LastRead: DWORD;
begin
  while True do
  begin
    FillChar(Buffer, sizeof(Buffer), 0);

   // FlushFileBuffers(hInputPipe);

    if not ReadFile(hInputPipe, Buffer, sizeof(Buffer), LastRead, nil) then
    begin
      SetEvent(fEvent);
      Break;
    end;

    //Now that we have read the data from the pipe, copy the contents
    EnterCriticalSection(OutputCrit);
    Output := Output + Buffer;
    LeaveCriticalSection(OutputCrit);

    //Then pass control to our other half.
    SetEvent(fEvent);
  end;
end;

constructor TDebugWait.Create(start: Boolean);
begin
  inherited;
  OutputTerminators := TStringList.Create;
  OutputTerminators.Add(#13);
  OutputTerminators.Add(#10);
end;

destructor TDebugWait.Destroy;
begin
  OutputTerminators.Free;
  inherited;
end;

procedure TDebugWait.Execute;
begin
  Stop := false;

  while (not Stop) and (not Reader.Suspended) do begin
    //Wait for an event
    WaitForSingleObject(Event, 10000);
    //WaitForInputIdle(Event, INFINITE);
    if Stop then
      Exit;

    //Call the callback
    Synchronize(Update);
  end;
end;

procedure TDebugWait.Update;
var
  I: Integer;
  RegExp: TRegExpr;
  CurOutput: string;
  StopIndex : Integer;
  LastNewline: Integer;
  LastCarriageReturn: Integer;
begin
  EnterCriticalSection(Reader.OutputCrit);

  //First determine where we should stop the output and wait for more
  LastNewLine := GetLastPos(#10, Reader.Output);
  LastCarriageReturn := GetLastPos(#13, Reader.Output);
  if LastNewLine > LastCarriageReturn then
    StopIndex := LastNewLine
  else
    StopIndex := LastCarriageReturn;

  //Remove non-printable characters
  CurOutput := Copy(Reader.Output, 0, StopIndex);
  I := 1;
  while I < Length(CurOutput) do
  begin
    if (CurOutput[I] = #8) and (I > 1) then
    begin
      Delete(CurOutput, I - 1, 2);
      Dec(I);
    end
    else
      Inc(I);
  end;

  Assert(Pos(#8, CurOutput) = 0);
  //Then call the handler
  OnOutput(CurOutput);
  Reader.Output := Copy(Reader.Output, StopIndex + 1, Length(Reader.Output));

  //See if what we have left should be sent over
  RegExp := TRegExpr.Create;
  try
    for I := 0 to OutputTerminators.Count - 1 do
      if RegExp.Exec(Reader.Output, OutputTerminators[I]) then
      begin
        OnOutput(Reader.Output);
        Reader.Output := '';
      end;
  finally
    RegExp.Free;
  end;
  
  LeaveCriticalSection(Reader.OutputCrit);
end;

end.
