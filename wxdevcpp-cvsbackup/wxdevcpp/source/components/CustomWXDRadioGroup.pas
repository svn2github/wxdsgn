{ ****************************************************************** }
 {                                                                    }
 {                                                                    }
 {   VCL component TCustomWXDRadioGroup                               }
 {                                                                    }
 {                                                                    }
 {   Copyright © 2005 by Guru Kathiresan                              }
 {                                                                    }
 { ****************************************************************** }
unit CustomWXDRadioGroup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TWXDOrientation=(wxdHorizontal,wxdVertical);



  TCustomWXDRadioGroup = class(TCustomRadioGroup)
  private
    { Private declarations }
    FButtons: TList;
    FItems: TStrings;
    FItemIndex: Integer;
    FColumns: Integer;
    FRows: Integer;
    FOrientation : TWXDOrientation;
    FMajorDimension : Integer;
    FReading: Boolean;
    FUpdating: Boolean;
    procedure ArrangeButtons;
    procedure ButtonClick(Sender: TObject);
    procedure ItemsChange(Sender: TObject);
    procedure SetButtonCount(Value: Integer);
    procedure SetColumns(Value: Integer);
    procedure SetRows(Value: Integer);
    procedure SetOrientation(const Value: TWXDOrientation);
    procedure SetMajorDimension(Value: Integer);
    procedure SetItemIndex(Value: Integer);
    procedure SetItems(Value: TStrings);
    procedure UpdateButtons;
    procedure CMEnabledChanged(var Message: TMessage); message
CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure SetButtonFontColor(Value: TColor);
  protected
    { Protected declarations }
    procedure Loaded; override;
    procedure ReadState(Reader: TReader); override;
    function CanModify: Boolean; virtual;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    property Columns: Integer read FColumns write SetColumns default 1;
    property Rows: Integer read FRows write SetRows default 1;
    property MajorDimension: Integer read FMajorDimension write SetMajorDimension default 1;

    property Orientation:TWXDOrientation read FOrientation write SetOrientation;
    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
    property Items: TStrings read FItems write SetItems;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure FlipChildren(AllLevels: Boolean); override;
  published
    { Published declarations }
  end;

  TWXDRadioGroup = class(TCustomWXDRadioGroup)
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Color;
//    property Columns;
//    property Rows;
    Property MajorDimension;
    Property Orientation;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ItemIndex;
    property Items;
    property Constraints;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDock;
    property OnStartDrag;
  end;

procedure Register;

implementation

{ TWXDGroupButton }

type
  TWXDGroupButton = class(TRadioButton)
  private
    FInClick: Boolean;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
  public
    constructor InternalCreate(RadioGroup: TCustomWXDRadioGroup);
    destructor Destroy; override;
  end;

constructor TWXDGroupButton.InternalCreate(RadioGroup: TCustomWXDRadioGroup);
begin
  inherited Create(RadioGroup);
  RadioGroup.FButtons.Add(Self);
  Visible := False;
  Enabled := RadioGroup.Enabled;
  ParentShowHint := False;
  OnClick := RadioGroup.ButtonClick;
  Parent := RadioGroup;
end;

destructor TWXDGroupButton.Destroy;
begin
  TCustomWXDRadioGroup(Owner).FButtons.Remove(Self);
  inherited Destroy;
end;

procedure TWXDGroupButton.CNCommand(var Message: TWMCommand);
begin
  if not FInClick then
  begin
    FInClick := True;
    try
      if ((Message.NotifyCode = BN_CLICKED) or
        (Message.NotifyCode = BN_DOUBLECLICKED)) and
        TCustomWXDRadioGroup(Parent).CanModify then
        inherited;
    except
      Application.HandleException(Self);
    end;
    FInClick := False;
  end;
end;

procedure TWXDGroupButton.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  TCustomWXDRadioGroup(Parent).KeyPress(Key);
  if (Key = #8) or (Key = ' ') then
  begin
    if not TCustomWXDRadioGroup(Parent).CanModify then Key := #0;
  end;
end;

procedure TWXDGroupButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  TCustomWXDRadioGroup(Parent).KeyDown(Key, Shift);
end;

{ TCustomWXDRadioGroup }

constructor TCustomWXDRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csSetCaption, csDoubleClicks];
  FButtons := TList.Create;
  FItems := TStringList.Create;
  TStringList(FItems).OnChange := ItemsChange;
  FItemIndex := -1;
  FColumns := 1;
  FRows := 1;
  FMajorDimension := 1;
  FOrientation := wxdHorizontal;
end;

destructor TCustomWXDRadioGroup.Destroy;
begin
  SetButtonCount(0);
  TStringList(FItems).OnChange := nil;
  FItems.Free;
  FButtons.Free;
  inherited Destroy;
end;

procedure TCustomWXDRadioGroup.FlipChildren(AllLevels: Boolean);
begin
  { The radio buttons are flipped using BiDiMode }
end;

procedure TCustomWXDRadioGroup.ArrangeButtons;
var
  ButtonWidth, ButtonHeight, TopMargin, I: Integer;
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
  DeferHandle: THandle;
  ALeft, ATop: Integer;
  textlength: Integer;

begin
  if (FButtons.Count <> 0) and not FReading then
  begin
  // get the length in pixels of the longest radio button label
  textlength := 0;
  if self.Items.Count <> 0 then
  begin
    for I := 0 to self.Items.Count - 1 do
      if Canvas.TextWidth ( self.Items[I] ) > textlength then
        textlength := Canvas.TextWidth ( self.Items [I] );
  end;
    DC := GetDC(0);
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
    ReleaseDC(0, DC);

      case Orientation of
        wxdHorizontal:
          begin
          FRows := FMajorDimension;
          if (FButtons.Count mod FMajorDimension) = 0 then
            FColumns := FButtons.Count div FMajorDimension
          else
            FColumns := (FButtons.Count div FMajorDimension) +1;
          end;
        wxdVertical  :
          begin
          FColumns := FMajorDimension;
          if (FButtons.Count mod FMajorDimension) = 0 then
            FRows := FButtons.Count div FMajorDimension
          else
            FRows := (FButtons.Count div FMajorDimension) +1;
          end;
      end;

//    SetLength(MyRadioButtonArray, FRows, FColumns);
//    ButtonsPerCol := FRows;

    ButtonWidth := 24 + textlength;
    ButtonHeight := 19;
    TopMargin := Metrics.tmHeight + 1;
    DeferHandle := BeginDeferWindowPos(FButtons.Count);
    try
      for I := 0 to FButtons.Count - 1 do
        with TWXDGroupButton(FButtons[I]) do
        begin
          BiDiMode := Self.BiDiMode;

      case Orientation of
        wxdHorizontal:
          begin
          ALeft := (I div FRows) * ButtonWidth + 8;
          ATop :=  (I mod FRows) * ButtonHeight + TopMargin;
          end;
        wxdVertical  :
          begin
          ALeft := (I mod FColumns) * ButtonWidth + 8;
          ATop :=  (I div FColumns) * ButtonHeight + TopMargin;
          end;
      end;

          if UseRightToLeftAlignment then
            ALeft := Self.ClientWidth - ALeft - ButtonWidth;

          DeferHandle := DeferWindowPos(DeferHandle, Handle, 0,
            ALeft,
            ATop,
            ButtonWidth, ButtonHeight,
            SWP_NOZORDER or SWP_NOACTIVATE);

          Visible := True;
        end;
    finally
      EndDeferWindowPos(DeferHandle);
    end;
  end;
end;

procedure TCustomWXDRadioGroup.ButtonClick(Sender: TObject);
begin
  if not FUpdating then
  begin
    FItemIndex := FButtons.IndexOf(Sender);
    Changed;
    Click;
  end;
end;

procedure TCustomWXDRadioGroup.ItemsChange(Sender: TObject);
begin
  if not FReading then
  begin
    if FItemIndex >= FItems.Count then FItemIndex := FItems.Count - 1;
    UpdateButtons;
  end;
end;

procedure TCustomWXDRadioGroup.Loaded;
begin
  inherited Loaded;
  ArrangeButtons;
end;

procedure TCustomWXDRadioGroup.ReadState(Reader: TReader);
begin
  FReading := True;
  inherited ReadState(Reader);
  FReading := False;
  UpdateButtons;
end;

procedure TCustomWXDRadioGroup.SetButtonCount(Value: Integer);
begin
  while FButtons.Count < Value do TWXDGroupButton.InternalCreate(Self);
  while FButtons.Count > Value do TWXDGroupButton(FButtons.Last).Free;
end;

procedure TCustomWXDRadioGroup.SetColumns(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 16 then Value := 16;
  if FColumns <> Value then
  begin
    FColumns := Value;
    ArrangeButtons;
    Invalidate;
  end;
end;

procedure TCustomWXDRadioGroup.SetRows(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 16 then Value := 16;
  if FRows <> Value then
  begin
    FRows := Value;
    ArrangeButtons;
    Invalidate;
  end;
end;

procedure TCustomWXDRadioGroup.SetMajorDimension(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 16 then Value := 16;
  if FMajorDimension <> Value then
  begin
    FMajorDimension := Value;
    ArrangeButtons;
    Invalidate;
  end;
end;

procedure TCustomWXDRadioGroup.SetItemIndex(Value: Integer);
begin
  if FReading then FItemIndex := Value else
  begin
    if Value < -1 then Value := -1;
    if Value >= FButtons.Count then Value := FButtons.Count - 1;
    if FItemIndex <> Value then
    begin
      if FItemIndex >= 0 then
        TWXDGroupButton(FButtons[FItemIndex]).Checked := False;
      FItemIndex := Value;
      if FItemIndex >= 0 then
        TWXDGroupButton(FButtons[FItemIndex]).Checked := True;
    end;
  end;
end;

procedure TCustomWXDRadioGroup.SetItems(Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TCustomWXDRadioGroup.UpdateButtons;
var
  I: Integer;
begin
  SetButtonCount(Items.Count);
  for I := 0 to FButtons.Count - 1 do
  begin
    TWXDGroupButton(FButtons[I]).Caption := FItems[I];
  end;
  if FItemIndex >= 0 then
  begin
    FUpdating := True;
    TWXDGroupButton(FButtons[FItemIndex]).Checked := True;
    FUpdating := False;
  end;
  ArrangeButtons;
  Invalidate;
end;

procedure TCustomWXDRadioGroup.CMEnabledChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  for I := 0 to FButtons.Count - 1 do
    TWXDGroupButton(FButtons[I]).Enabled := Enabled;
end;

procedure TCustomWXDRadioGroup.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ArrangeButtons;
end;

procedure TCustomWXDRadioGroup.WMSize(var Message: TWMSize);
begin
  inherited;
  ArrangeButtons;
end;

function TCustomWXDRadioGroup.CanModify: Boolean;
begin
  Result := True;
end;

procedure TCustomWXDRadioGroup.GetChildren(Proc: TGetChildProc; Root:
TComponent);
begin
end;

procedure TCustomWXDRadioGroup.SetButtonFontColor(Value: TColor);
begin
end;

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWXDRadioGroup]);
end;

procedure TCustomWXDRadioGroup.SetOrientation(const Value: TWXDOrientation);
begin
  FOrientation:= Value;
    ArrangeButtons;
    Invalidate;
end;


end.