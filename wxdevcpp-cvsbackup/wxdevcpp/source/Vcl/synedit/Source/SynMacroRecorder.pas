{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: SynMacroRecorder.pas, released 2001-10-17.

Author of this file is Flávio Etrusco.
Portions created by Flávio Etrusco are Copyright 2001 Flávio Etrusco.
All Rights Reserved.

Contributors to the SynEdit project are listed in the Contributors.txt file.

Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 or later (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the GPL and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting the provisions above and
replace them with the notice and other provisions required by the GPL.
If you do not delete the provisions above, a recipient may use your version
of this file under either the MPL or the GPL.

$Id$

You may retrieve the latest version of this file at the SynEdit home page,
located at http://SynEdit.SourceForge.net

Known Issues:
-------------------------------------------------------------------------------}

unit SynMacroRecorder;

{$I SynEdit.inc}

interface

uses
  Classes,
  SynEdit,
  SynEditKeyCmds,
{$IFDEF SYN_CLX}
  QStdCtrls,
  QControls,
  Qt,
  Types,
  QGraphics,
  QMenus,
{$ELSE}
  StdCtrls,
  Controls,
  Windows,
  Messages,
  Graphics,
  Menus,
{$ENDIF}
  SynEditPlugins;

{$IFDEF SYN_COMPILER_3_UP}
resourcestring
{$ELSE}
const
{$ENDIF}
  sCannotPause = 'Cannot pause recording when not recording';
  sCannotPlayback = 'Cannot playback macro during recording session';
  sCannotAddEvent = 'Cannot add events to macro when not recording';

type
  TSynMacroState = (msStopped, msRecording, msPlaying, msPaused);
  TSynMacroCommand = (mcRecord, mcPlayback);

  TSynMacroEvent = class(TObject)
  public
    procedure Initialize(aCmd: TSynEditorCommand; aChar: Char; aData: Pointer);
      virtual; abstract;
    { the CommandID must not be read in SaveToStream. It's read by the
    MacroRecorder to decide which class to instanciate }
    procedure LoadFromStream(aStream: TStream); virtual; abstract;
    procedure SaveToStream(aStream: TStream); virtual; abstract;
    procedure Playback(aEditor: TCustomSynEdit); virtual; abstract;
  end;

  TSynBasicEvent = class(TSynMacroEvent)
  protected
    fCommand: TSynEditorCommand;
  public
    procedure Initialize(aCmd: TSynEditorCommand; aChar: Char; aData: Pointer);
      override;
    procedure LoadFromStream(aStream: TStream); override;
    procedure SaveToStream(aStream: TStream); override;
    procedure Playback(aEditor: TCustomSynEdit); override;
  public
    property Command: TSynEditorCommand read fCommand write fCommand;
  end;

  TSynCharEvent = class(TSynMacroEvent)
  protected
    fKey: char;
  public
    procedure Initialize(aCmd: TSynEditorCommand; aChar: Char; aData: Pointer);
      override;
    procedure LoadFromStream(aStream: TStream); override;
    procedure SaveToStream(aStream: TStream); override;
    procedure Playback(aEditor: TCustomSynEdit); override;
  public
    property Key: char read fKey write fKey;
  end;

  TSynPositionEvent = class(TSynBasicEvent)
  protected
    fPosition: TPoint;
  public
    procedure Initialize(aCmd: TSynEditorCommand; aChar: Char; aData: Pointer);
      override;
    procedure LoadFromStream(aStream: TStream); override;
    procedure SaveToStream(aStream: TStream); override;
    procedure Playback(aEditor: TCustomSynEdit); override;
  public
    property Position: TPoint read fPosition write fPosition;
  end;

  TCustomSynMacroRecorder = class;

  TLoadUserCommandEvent = procedure (aSender: TCustomSynMacroRecorder;
    var aEvent: TSynMacroEvent) of object;

  TCustomSynMacroRecorder = class(TAbstractSynHookerPlugin)
  private
    fShortCuts: array [TSynMacroCommand] of TShortCut;
    fOnStateChange: TNotifyEvent;
    fOnLoadUserCommand: TLoadUserCommandEvent;
    function GetEvent(aIndex: integer): TSynMacroEvent;
    function GetEventCount: integer;
  protected
    fCurrentEditor: TCustomSynEdit;
    fState: TSynMacroState;
    fEvents: TList;
    fCommandIDs: array [TSynMacroCommand] of TSynEditorCommand;
    procedure SetShortCut(const Index: Integer; const Value: TShortCut);
    function GetIsEmpty: boolean;
    procedure StateChanged;
    procedure Error(const aMsg: String);
    procedure DoAddEditor(aEditor: TCustomSynEdit); override;
    procedure DoRemoveEditor(aEditor: TCustomSynEdit); override;
    procedure OnCommand(Sender: TObject; AfterProcessing: boolean;
      var Handled: boolean; var Command: TSynEditorCommand; var aChar: char;
      Data: pointer; HandlerData: pointer); override;
    function CreateMacroEvent(aCmd: TSynEditorCommand): TSynMacroEvent;
  protected
    property RecordCommandID: TSynEditorCommand read fCommandIDs[mcRecord];
    property PlaybackCommandID: TSynEditorCommand read fCommandIDs[mcPlayback];
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddEditor(aEditor: TCustomSynEdit);
    procedure RecordMacro(aEditor: TCustomSynEdit);
    procedure PlaybackMacro(aEditor: TCustomSynEdit);
    procedure Stop;
    procedure Pause;
    procedure Resume;
    property IsEmpty: boolean read GetIsEmpty;
    property State: TSynMacroState read fState;
    procedure Clear;
    procedure AddEvent(aCmd: TSynEditorCommand; aChar: char; aData: pointer);
    procedure AddCustomEvent(aEvent: TSynMacroEvent);
    procedure LoadFromStream(aSrc: TStream);
    procedure SaveToStream(aDest: TStream);
  public
    property EventCount: integer read GetEventCount;
    property Events[aIndex: integer]: TSynMacroEvent read GetEvent;
    property RecordShortCut: TShortCut index Ord(mcRecord)
      read fShortCuts[mcRecord] write SetShortCut;
    property PlaybackShortCut: TShortCut index Ord(mcPlayback)
      read fShortCuts[mcPlayback] write SetShortCut;
    { occurs when changing recorder state }
    property OnStateChange: TNotifyEvent read fOnStateChange write fOnStateChange;
    property OnLoadUserCommand: TLoadUserCommandEvent read fOnLoadUserCommand
      write fOnLoadUserCommand;
  end;

  TSynMacroRecorder = class(TCustomSynMacroRecorder)
  published
    property RecordShortCut;
    property PlaybackShortCut;
    property OnStateChange;
    property OnLoadUserCommand;
  end;

implementation

uses
  SynEditMiscProcs,
  SynEditTypes,
{$IFDEF SYN_CLX}
  QForms,
{$ELSE}
  Forms,
{$ENDIF}
  SysUtils;

{ TCustomSynMacroRecorder }

procedure TCustomSynMacroRecorder.AddCustomEvent(aEvent: TSynMacroEvent);
{ you can customize the handling of the playback of your custom commands in
TCustomSyneditor.OnProcess-User?-Command event }
begin
  if State = msStopped then
  begin
    aEvent.Free;
    Error( sCannotAddEvent );
  end;
  fEvents.Add( aEvent );
end;

procedure TCustomSynMacroRecorder.AddEditor(aEditor: TCustomSynEdit);
begin
  inherited AddEditor(aEditor);
end;

procedure TCustomSynMacroRecorder.AddEvent(aCmd: TSynEditorCommand;
  aChar: char; aData: pointer);
var
  iEvent: TSynMacroEvent;
begin
  if State = msStopped then
    Error( sCannotAddEvent );
  iEvent := CreateMacroEvent( aCmd );
  iEvent.Initialize( aCmd, aChar, aData );
  fEvents.Add( iEvent );
end;

procedure TCustomSynMacroRecorder.StateChanged;
begin
  if Assigned( OnStateChange ) then
    OnStateChange( Self );
end;

procedure TCustomSynMacroRecorder.Clear;
var
  I: Integer;
  Obj: TObject;
begin
  if Assigned(fEvents) then
  begin
    for I := fEvents.Count-1 downto 0 do
    begin
      Obj := fEvents[I];
      fEvents.Delete(I);
      Obj.Free;
    end;
    FreeAndNil( fEvents );
  end;
end;

constructor TCustomSynMacroRecorder.Create(aOwner: TComponent);
begin
  inherited;
  fCommandIDs[mcRecord] := NewPluginCommand;
  fCommandIDs[mcPlayback] := NewPluginCommand;
  fShortCuts[mcRecord] := Menus.ShortCut( Ord('R'), [ssCtrl, ssShift] );
  fShortCuts[mcPlayback] := Menus.ShortCut( Ord('P'), [ssCtrl, ssShift] );
end;

function TCustomSynMacroRecorder.CreateMacroEvent(aCmd: TSynEditorCommand): TSynMacroEvent;

  function WantDefaultEvent(var aEvent: TSynMacroEvent): boolean;
  begin
    aEvent := nil;
    OnLoadUserCommand( Self, aEvent );
    Result := aEvent = nil;
  end;

begin
  case aCmd of
    ecGotoXY, ecSelGotoXY:
      Result := TSynPositionEvent.Create;
    ecChar:
      Result := TSynCharEvent.Create;
    else
      if (aCmd < ecUserFirst) or not Assigned( OnLoadUserCommand ) or
        WantDefaultEvent( Result )
      then
        Result := TSynBasicEvent.Create;
  end;
end;

destructor TCustomSynMacroRecorder.Destroy;
begin
  Clear;
  inherited;
  ReleasePluginCommand( PlaybackCommandID );
  ReleasePluginCommand( RecordCommandID );
end;

procedure TCustomSynMacroRecorder.DoAddEditor(aEditor: TCustomSynEdit);
begin
  HookEditor( aEditor, RecordCommandID, 0, RecordShortCut );
  HookEditor( aEditor, PlaybackCommandID, 0, PlaybackShortCut );
end;

procedure TCustomSynMacroRecorder.DoRemoveEditor(aEditor: TCustomSynEdit);
begin
  UnHookEditor( aEditor, RecordCommandID, RecordShortCut );
  UnHookEditor( aEditor, PlaybackCommandID, PlaybackShortCut );
end;

procedure TCustomSynMacroRecorder.Error(const aMsg: String);
begin
  raise Exception.Create(aMsg);
end;

function TCustomSynMacroRecorder.GetEvent(aIndex: integer): TSynMacroEvent;
begin
  Result := TSynMacroEvent( fEvents[aIndex] );
end;

function TCustomSynMacroRecorder.GetEventCount: integer;
begin
  if fEvents = nil then
    Result := 0
  else
    Result := fEvents.Count;
end;

function TCustomSynMacroRecorder.GetIsEmpty: boolean;
begin
  Result := (fEvents = nil) or (fEvents.Count = 0);
end;

procedure TCustomSynMacroRecorder.LoadFromStream(aSrc: TStream);
var
  iCommand: integer;
  iEvent: TSynMacroEvent;
begin
  Stop;
  Clear;
  fEvents := TList.Create;
  while aSrc.Position < aSrc.Size do
  begin
    aSrc.Read( iCommand, SizeOf(iCommand) );
    iEvent := CreateMacroEvent( iCommand );
    iEvent.LoadFromStream( aSrc );
    fEvents.Add( iEvent );
  end;
end;

procedure TCustomSynMacroRecorder.OnCommand(Sender: TObject;
  AfterProcessing: boolean; var Handled: boolean;
  var Command: TSynEditorCommand; var aChar: char; Data,
  HandlerData: pointer);
begin
  if AfterProcessing then
  begin
    if fCurrentEditor <> Sender then
      Exit;
    if State = msRecording then
      AddEvent( Command, aChar, Data );
  end
  else begin
    {not AfterProcessing}
    case State of
      msStopped:
        if Command = RecordCommandID then
        begin
          RecordMacro( TCustomSynEdit( Sender ) );
          Handled := True;
        end
        else
          if Command = PlaybackCommandID then
          begin
            PlaybackMacro( TCustomSynEdit( Sender ) );
            Handled := True;
          end;
      msPlaying:
        ;
      msPaused:
        if Command = PlaybackCommandID then
        begin
          Resume;
          Handled := True;
        end;
      msRecording:
        if Command = PlaybackCommandID then
        begin
          Pause;
          Handled := True;
        end
        else
          if Command = RecordCommandID then
          begin
            Stop;
            Handled := True;
          end;
    end;
  end;
end;

procedure TCustomSynMacroRecorder.Pause;
begin
  if State <> msRecording then
    Error( sCannotPause );
  fState := msPaused;
  StateChanged;
end;

procedure TCustomSynMacroRecorder.PlaybackMacro(aEditor: TCustomSynEdit);
var
  cEvent: integer;
begin
  if State <> msStopped then
    Error( sCannotPlayback );
  if (State <> msStopped) or (fEvents = nil) or (fEvents.Count < 1) then
    Exit;
  fState := msPlaying;
  try
    for cEvent := 0 to fEvents.Count -1 do
      Events[ cEvent ].Playback( aEditor );
  finally
    fState := msStopped;
  end;
end;

procedure TCustomSynMacroRecorder.RecordMacro(aEditor: TCustomSynEdit);
begin
  Assert( fState = msStopped );
  if fState <> msStopped then
    Exit;
  Clear;
  fEvents := TList.Create;
  fState := msRecording;
  fCurrentEditor := aEditor;
  StateChanged;
end;

procedure TCustomSynMacroRecorder.Resume;
begin
  Assert( State = msPaused );
  if fState = msPaused then
    fState := msRecording;
  StateChanged;
end;

procedure TCustomSynMacroRecorder.SaveToStream(aDest: TStream);
var
  cEvent: integer;
begin
  for cEvent := 0 to EventCount -1 do
    Events[ cEvent ].SaveToStream( aDest );
end;

procedure TCustomSynMacroRecorder.SetShortCut(const Index: Integer;
  const Value: TShortCut);
var
  cEditor: integer;
begin
  if fShortCuts[TSynMacroCommand(Index)] <> Value then
  begin
    if Assigned(fEditors) then
      if Value <> 0 then
      begin
        for cEditor := 0 to fEditors.Count -1 do
          HookEditor( Editors[cEditor], fCommandIDs[TSynMacroCommand(Index)],
            fShortCuts[TSynMacroCommand(Index)], Value );
      end else
      begin
        for cEditor := 0 to fEditors.Count -1 do
          UnHookEditor( Editors[cEditor], fCommandIDs[TSynMacroCommand(Index)],
            fShortCuts[TSynMacroCommand(Index)] );
      end;
    fShortCuts[TSynMacroCommand(Index)] := Value;
  end;
end;

procedure TCustomSynMacroRecorder.Stop;
begin
  if fState = msStopped then
    Exit;
  fState := msStopped;
  fCurrentEditor := nil;
  if fEvents.Count = 0 then
    FreeAndNil( fEvents );
  StateChanged;
end;

{ TSynBasicEvent }

procedure TSynBasicEvent.Initialize(aCmd: TSynEditorCommand; aChar: Char;
  aData: Pointer);
begin
  Command := aCmd;
{$IFDEF SYN_DEVELOPMENT_CHECKS}
  if (aChar <> #0) or (aData <> nil) then
    raise Exception.Create('TSynBasicEvent cannot handle Char <> #0 or Data <> nil');
{$ENDIF}
end;

procedure TSynBasicEvent.LoadFromStream(aStream: TStream);
begin
  { nothing }
end;

procedure TSynBasicEvent.Playback(aEditor: TCustomSynEdit);
begin
  aEditor.CommandProcessor( Command, #0, nil );
end;

procedure TSynBasicEvent.SaveToStream(aStream: TStream);
begin
  aStream.Write( Command, SizeOf(Command) );
end;

{ TSynCharEvent }

procedure TSynCharEvent.Initialize(aCmd: TSynEditorCommand; aChar: Char;
  aData: Pointer);
begin
  Key := aChar;
end;

procedure TSynCharEvent.LoadFromStream(aStream: TStream);
begin
  aStream.Read( fKey, SizeOf(Key) );
end;

procedure TSynCharEvent.Playback(aEditor: TCustomSynEdit);
begin
  aEditor.CommandProcessor( ecChar, Key, nil );
end;

procedure TSynCharEvent.SaveToStream(aStream: TStream);
const
  CharCommand: TSynEditorCommand = ecChar;
begin
  aStream.Write( CharCommand, SizeOf(CharCommand) );
  aStream.Write( Key, SizeOf(Key) );
end;

{ TSynPositionEvent }

procedure TSynPositionEvent.Initialize(aCmd: TSynEditorCommand;
  aChar: Char; aData: Pointer);
begin
  inherited;
  Position := TPoint( aData^ );
end;

procedure TSynPositionEvent.LoadFromStream(aStream: TStream);
begin
  aStream.Read( fPosition, SizeOf(Position) );
end;

procedure TSynPositionEvent.Playback(aEditor: TCustomSynEdit);
begin
  aEditor.CommandProcessor( Command, #0, @Position );
end;

procedure TSynPositionEvent.SaveToStream(aStream: TStream);
begin
  inherited;
  aStream.Write( Position, SizeOf(Position) );
end;

end.
