{ $Id$ }
{http://jansfreeware.com/janbuttonedit.zip}

{Adapted by Malcolm Nealon}




unit janButtonEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ColorBtn;

type

  TjanButtonEdit = class(TWinControl)
  private
    FButton: TColorBtn;
    FEdit: TEdit;
    FShowEdit: Boolean;
    procedure SetShowEdit(const Value: Boolean);
    function GetShowEdit: Boolean;
    procedure SetCaption(const Value: TCaption);
    function GetCaption: TCaption;
    procedure SetButtonColor(const Value: TColor);
    function GetButtonColor: TColor;
    //    procedure SetGlyph(const Value: TBitmap);
    //    function  GetGlyph:TBitmap;
    procedure autofit;
    procedure TextChanged(sender: TObject);
  protected
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CreateWnd; override;
    procedure SetText(Value: string);
    function GetText: string;
    function GetFont: TFont;
    procedure SetFont(Value: TFont);
    function GetOnButtonClick: TNotifyEvent;
    procedure SetOnButtonClick(Value: TNotifyEvent);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Text: string read GetText write SetText;
    property Font: TFont read GetFont write SetFont;
    property OnButtonClick: TNotifyEvent read GetOnButtonClick write SetOnButtonClick;
    property ButtonColor: TColor read GetButtonColor write SetButtonColor;
    property ButtonCaption: TCaption read GetCaption write SetCaption;
//    property ShowEdit: Boolean read GetShowEdit write SetShowEdit;
    property ShowEdit: Boolean read FShowEdit write FShowEdit;

    //    property Glyph:TBitmap read GetGlyph write SetGlyph;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Jans 2', [TjanButtonEdit]);
end;

procedure TjanButtonEdit.WMSize(var Message: TWMSize);
begin
  inherited;
  autofit;
end;

constructor TjanButtonEdit.Create(AOwner: TComponent);
begin
  inherited;
  width := 121;
  height := 24;
  FEdit := TEdit.Create(self);
  FEdit.parent := self;
  FEdit.onchange := TextChanged;
  FButton := TColorBtn.Create(self);
  FButton.width := 20;
  Fbutton.height := 20;
  Fbutton.top := 2;
  FButton.parent := Self;
  FButton.Caption := '';
  FShowEdit := False;
end;

destructor TjanButtonEdit.Destroy;
begin
  FButton.Free;
  FEdit.Free;
  inherited Destroy;
end;

procedure TjanButtonEdit.SetShowEdit(const Value: Boolean);
begin
  FShowEdit := Value;
  autofit;
end;

function TjanButtonEdit.GetShowEdit: Boolean;
begin
  Result := FShowEdit;
end;

procedure TjanButtonEdit.SetCaption(const Value: TCaption);
begin
  FButton.Caption := Value;
  autofit;
end;

function TjanButtonEdit.GetCaption: TCaption;
begin
  Result := FButton.Caption;
end;

procedure TjanButtonEdit.SetButtonColor(const Value: TColor);
begin
  FButton.ButtonColor := Value;
  autofit;
end;

function TjanButtonEdit.GetButtonColor: TColor;
begin
  Result := FButton.ButtonColor;
end;

function TjanButtonEdit.GetText: string;
begin
  Result := FEdit.Text;
end;

procedure TjanButtonEdit.SetText(Value: string);
begin
  FEdit.Text := Value;
  autofit;
end;

function TjanButtonEdit.GetFont: TFont;
begin
  Result := FEdit.Font;
end;

procedure TjanButtonEdit.SetFont(Value: TFont);
begin
  if Assigned(FEdit.Font) then
    FEdit.Font.Assign(Value);
end;

function TjanButtonEdit.GetOnButtonClick: TNotifyEvent;
begin
  Result := FButton.OnClick;
end;

procedure TjanButtonEdit.SetOnButtonClick(Value: TNotifyEvent);
begin
  FButton.onClick := Value;
end;

{procedure TjanButtonEdit.SetGlyph(const Value: TBitmap);
begin
  FButton.Glyph.assign(Value);
end;

function TjanButtonEdit.GetGlyph: TBitmap;
begin
  result:=FButton.Glyph;
end;

}

procedure TjanButtonEdit.CreateWnd;
begin
  inherited;
  FEdit.width := width;
  FEdit.height := height;
  autofit;
end;

procedure TjanButtonEdit.autofit;
begin
  if (Self.FShowEdit = True) then
  begin
    FEdit.Visible := True;
    if (FButton.Caption <> '') then
      FButton.Width := 75
    else
      FButton.Width := 25;

    FEdit.width := width;
    FEdit.height := height;
    Fbutton.top := 2;
    Fbutton.Height := height - 4;
    Fbutton.Left := Width - FButton.width - 3;
    FEdit.Perform(EM_SETMARGINS, EC_RIGHTMARGIN, (FButton.Width + 4) * $10000);
  end
  else
  begin
    FEdit.Visible := False;
//    FEdit.width := 0;
    FEdit.height := height;
    Fbutton.top := FEdit.Top;
    Fbutton.Height := FEdit.Height;
    FButton.Width := FEdit.Width;
    Fbutton.Left := FEdit.Left;
//    FEdit.Perform(EM_SETMARGINS, EC_RIGHTMARGIN, (FButton.Width + 4) * $10000);

  end;

end;

procedure TjanButtonEdit.TextChanged(sender: TObject);
begin
  FEdit.Perform(EM_SETMARGINS, EC_RIGHTMARGIN, (FButton.Width + 4) * $10000);
end;

initialization
  RegisterClass(TEdit);
  RegisterClass(TColorBtn);
  RegisterClass(TjanButtonEdit);

end.

