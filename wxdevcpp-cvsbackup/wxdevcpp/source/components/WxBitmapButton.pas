// $Id$

unit WxBitmapButton;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, StdCtrls, Wxutils, ExtCtrls, WxSizerPanel, Buttons;

type

  TWxBitmapButton = class(TBitBtn, IWxComponentInterface)
  private
    FEVT_BUTTON: string;
    FEVT_UPDATE_UI: string;
    FWx_BKColor: TColor;
    FWx_Border: integer;
    FWx_ButtonStyle: TWxBtnStyleSet;
    FWx_Class: string;
    FWx_ControlOrientation: TWxControlOrientation;
    FWx_Default: boolean;
    FWx_Enabled: boolean;
    FWx_EventList: TStringList;
    FWx_FGColor: TColor;
    FWx_GeneralStyle: TWxStdStyleSet;
    FWx_HelpText: string;
    FWx_Hidden: boolean;
    FWx_HorizontalAlignment: TWxSizerHorizontalAlignment;
    FWx_IDName: string;
    FWx_IDValue: longint;
    FWx_ProxyBGColorString: TWxColorString;
    FWx_ProxyFGColorString: TWxColorString;
    FWx_StretchFactor: integer;
    FWx_ToolTip: string;
    FWx_Bitmap: TPicture;
    FWx_VerticalAlignment: TWxSizerVerticalAlignment;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_Validator: string;
    FWx_Comments: TStrings;

    { Private methods of TWxButton }

    procedure AutoInitialize;
    procedure AutoDestroy;
    procedure SetWx_EventList(Value: TStringList);

  protected
    { Protected fields of TWxButton }

    { Protected methods of TWxButton }

  public
    { Public fields and properties of TWxButton }
    defaultBGColor: TColor;
    defaultFGColor: TColor;

    { Public methods of TWxButton }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    function GenerateControlIDs: string;
    function GenerateEnumControlIDs: string;
    function GenerateEventTableEntries(CurrClassName: string): string;
    function GenerateGUIControlCreation: string;
    function GenerateXRCControlCreation(IndentString: string): TStringList;
    function GenerateGUIControlDeclaration: string;
    function GenerateHeaderInclude: string;
    function GenerateImageInclude: string;
    function GetEventList: TStringList;
    function GetIDName: string;
    function GetIDValue: longint;
    function GetParameterFromEventName(EventName: string): string;
    function GetPropertyList: TStringList;
    function GetStretchFactor: integer;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: longint);
    procedure SetStretchFactor(intValue: integer);
    procedure SetWxClassName(wxClassName: string);
    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);
    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);
    procedure SetButtonBitmap(Value: TPicture);

  published
    { Published properties of TWxButton }
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property EVT_BUTTON: string Read FEVT_BUTTON Write FEVT_BUTTON;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Wx_BKColor: TColor Read FWx_BKColor Write FWx_BKColor;
    property Wx_Border: integer Read FWx_Border Write FWx_Border default 5;
    property Wx_ButtonStyle: TWxBtnStyleSet Read FWx_ButtonStyle Write FWx_ButtonStyle;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_Default: boolean Read FWx_Default Write FWx_Default;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_EventList: TStringList Read FWx_EventList Write SetWx_EventList;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
    property Wx_HorizontalAlignment: TWxSizerHorizontalAlignment
      Read FWx_HorizontalAlignment Write FWx_HorizontalAlignment default
      wxSZALIGN_CENTER_HORIZONTAL;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_ProxyBGColorString: TWxColorString
      Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString
      Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property Wx_StretchFactor: integer Read FWx_StretchFactor
      Write FWx_StretchFactor default 0;
    property Wx_StrechFactor: integer Read FWx_StretchFactor Write FWx_StretchFactor;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;
    property Wx_VerticalAlignment: TWxSizerVerticalAlignment
      Read FWx_VerticalAlignment Write FWx_VerticalAlignment default wxSZALIGN_CENTER_VERTICAL;
    property InvisibleBGColorString: string
      Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string
      Read FInvisibleFGColorString Write FInvisibleFGColorString;
    property Color;
    property Wx_BITMAP: TPicture Read FWx_BITMAP Write SetButtonBitmap;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
    property Wx_Validator: string Read FWx_Validator Write FWx_Validator;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxBitmapButton]);
end;

procedure TWxBitmapButton.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Border   := 5;
  FWx_Class    := 'wxBitmapButton';
  FWx_Enabled  := True;
  FWx_EventList := TStringList.Create;
  FWx_HorizontalAlignment := wxSZALIGN_CENTER_HORIZONTAL;
  FWx_IDValue  := -1;
  FWx_StretchFactor := 0;
  FWx_VerticalAlignment := wxSZALIGN_CENTER_VERTICAL;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor := self.color;
  defaultFGColor := self.font.color;
  Caption      := '';
  FWx_Bitmap   := TPicture.Create;
  FWx_Comments := TStringList.Create;

end; { of AutoInitialize }


procedure TWxBitmapButton.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_Bitmap.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }


procedure TWxBitmapButton.SetWx_EventList(Value: TStringList);
begin
  FWx_EventList.Assign(Value);
end;

constructor TWxBitmapButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  AutoInitialize;
  self.Caption := '';

  FWx_PropertyList.add('Wx_Comments:Comments');
  FWx_PropertyList.add('Wx_Enabled :Enabled');
  FWx_PropertyList.add('wx_Class:Base Class');
  FWx_PropertyList.add('Wx_Hidden :Hidden');
  FWx_PropertyList.add('Wx_Border : Border ');
  FWx_PropertyList.add('Wx_HelpText :HelpText ');
  FWx_PropertyList.add('Wx_IDName : IDName ');
  FWx_PropertyList.add('Wx_IDValue : IDValue ');
  FWx_PropertyList.add('Wx_ToolTip :ToolTip ');
  FWx_PropertyList.add('Name : Name');
  FWx_PropertyList.add('Left : Left');
  FWx_PropertyList.add('Top : Top');
  FWx_PropertyList.add('Width : Width');
  FWx_PropertyList.add('Height:Height');
  FWx_PropertyList.add('Wx_Bitmap:Bitmap');
  FWx_PropertyList.add('Wx_ProxyBGColorString:Background Color');
  FWx_PropertyList.add('Wx_ProxyFGColorString:Foreground Color');
  FWx_PropertyList.add('Wx_GeneralStyle: General Styles');
  FWx_PropertyList.Add('wxSIMPLE_BORDER:wxSIMPLE_BORDER');
  FWx_PropertyList.Add('wxDOUBLE_BORDER:wxDOUBLE_BORDER');
  FWx_PropertyList.Add('wxSUNKEN_BORDER:wxSUNKEN_BORDER');
  FWx_PropertyList.Add('wxRAISED_BORDER:wxRAISED_BORDER');
  FWx_PropertyList.Add('wxSTATIC_BORDER:wxSTATIC_BORDER');
  FWx_PropertyList.Add('wxTRANSPARENT_WINDOW:wxTRANSPARENT_WINDOW');
  FWx_PropertyList.Add('wxNO_3D:wxNO_3D');
  FWx_PropertyList.Add('wxTAB_TRAVERSAL:wxTAB_TRAVERSAL');
  FWx_PropertyList.Add('wxWANTS_CHARS:wxWANTS_CHARS');
  FWx_PropertyList.Add('wxNO_FULL_REPAINT_ON_RESIZE:wxNO_FULL_REPAINT_ON_RESIZE');
  FWx_PropertyList.Add('wxVSCROLL:wxVSCROLL');
  FWx_PropertyList.Add('wxHSCROLL:wxHSCROLL');
  FWx_PropertyList.Add('wxCLIP_CHILDREN:wxCLIP_CHILDREN');
  FWx_PropertyList.add('Font : Font');
  FWx_PropertyList.add('Wx_ButtonStyle:Button Style');
  FWx_PropertyList.Add('wxBU_AUTODRAW:wxBU_AUTODRAW');
  FWx_PropertyList.add('wxBU_LEFT:wxBU_LEFT');
  FWx_PropertyList.add('wxBU_TOP:wxBU_TOP');
  FWx_PropertyList.add('wxBU_RIGHT:wxBU_RIGHT');
  FWx_PropertyList.add('wxBU_BOTTOM:wxBU_BOTTOM');
  FWx_PropertyList.add('wxBU_EXACTFIT:wxBU_EXACTFIT');
  FWx_PropertyList.add('Wx_HorizontalAlignment : HorizontalAlignment');
  FWx_PropertyList.add('Wx_VerticalAlignment   : VerticalAlignment');
  FWx_PropertyList.add('Wx_StretchFactor   : StretchFactor');

  FWx_PropertyList.add('Wx_Validator : Validator code');

  FWx_EventList.add('EVT_BUTTON:OnClick');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxBitmapButton.Destroy;
begin
  AutoDestroy;
  inherited Destroy;
end;

procedure TWxBitmapButton.WMPaint(var Message: TWMPaint);
begin
  self.Caption := '';
  inherited;
end;


function TWxBitmapButton.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxBitmapButton.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d', [Wx_IDName, Wx_IDValue]);
end;

function TWxBitmapButton.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
  if trim(EVT_BUTTON) <> '' then
    Result := Format('EVT_BUTTON(%s,%s::%s)', [WX_IDName, CurrClassName,
      EVT_BUTTON]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

end;

function TWxBitmapButton.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('<IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('<ID>%d</ID>', [self.Wx_IDValue]));
    Result.Add(IndentString + Format('<size>%d,%d</size>', [self.Width, self.Height]));
    Result.Add(IndentString + Format('<pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + Format('<style>%s</style>',
      [GetButtonSpecificStyle(self.Wx_GeneralStyle, Wx_ButtonStyle)]));
    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxBitmapButton.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle:    string;
  parentName, strAlignment: string;
begin
  Result   := '';
  strStyle := GetButtonSpecificStyle(self.Wx_GeneralStyle, Wx_ButtonStyle);

  if trim(self.FWx_Validator) <> '' then
  begin
    if trim(strStyle) <> '' then
      strStyle := ', ' + strStyle + ', ' + self.Wx_Validator
    else
      strStyle := ', wxBU_AUTODRAW, ' + self.Wx_Validator;

    strStyle := strStyle + ', ' + GetCppString(Name);

  end
  else if trim(strStyle) <> '' then
    strStyle := strStyle + ', wxDefaultValidator, ' + GetCppString(Name)
  else
    strStyle := ', wxBU_AUTODRAW, wxDefaultValidator, ' + GetCppString(Name);

  //    if (self.Parent is TForm) or (self.Parent is TWxSizerPanel) then
  //       parentName:=GetWxWidgetParent(self)
  //    else
  //       parentName:=self.Parent.name;

  parentName := GetWxWidgetParent(self);

  Result := GetCommentString(self.FWx_Comments.Text) +
    'wxBitmap ' + self.Name + '_BITMAP' + ' (wxNullBitmap);';

  if assigned(Wx_Bitmap) then
    if Wx_Bitmap.Bitmap.Handle <> 0 then
      Result := 'wxBitmap ' + self.Name + '_BITMAP' + ' (' + self.Name + '_XPM' + ');';

  Result := Result + #13 + Format(
    '%s = new %s(%s, %s, %s, wxPoint(%d,%d), wxSize(%d,%d)%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    self.Name + '_BITMAP', self.Left, self.Top, self.Width, self.Height, strStyle]);

  if trim(self.Wx_ToolTip) <> '' then
    Result := Result + #13 + Format('%s->SetToolTip(%s);',
      [self.Name, GetCppString(self.Wx_ToolTip)]);

  if self.Wx_Hidden then
    Result := Result + #13 + Format('%s->Show(false);', [self.Name]);

  if not Wx_Enabled then
    Result := Result + #13 + Format('%s->Enable(false);', [self.Name]);

  if trim(self.Wx_HelpText) <> '' then
    Result := Result + #13 + Format('%s->SetHelpText(%s);',
      [self.Name, GetCppString(self.Wx_HelpText)]);

  strColorStr := trim(GetwxColorFromString(InvisibleFGColorString));
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetForegroundColour(%s);',
      [self.Name, strColorStr]);

  strColorStr := trim(GetwxColorFromString(InvisibleBGColorString));
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetBackgroundColour(%s);',
      [self.Name, strColorStr]);


  strColorStr := GetWxFontDeclaration(self.Font);
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetFont(%s);', [self.Name, strColorStr]);

  if (self.Parent is TWxSizerPanel) then
  begin

    strAlignment := SizerAlignmentToStr(Wx_HorizontalAlignment) +
      ' | ' + SizerAlignmentToStr(Wx_VerticalAlignment) + ' | wxALL';
    if wx_ControlOrientation = wxControlVertical then
      strAlignment := SizerAlignmentToStr(Wx_HorizontalAlignment) + ' | wxALL';

    if wx_ControlOrientation = wxControlHorizontal then
      strAlignment := SizerAlignmentToStr(Wx_VerticalAlignment) + ' | wxALL';

    Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);

  end;

end;

function TWxBitmapButton.GenerateGUIControlDeclaration: string;
begin
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxBitmapButton.GenerateHeaderInclude: string;
begin
  Result := '#include <wx/bmpbuttn.h>';
end;

function TWxBitmapButton.GenerateImageInclude: string;
begin
  if assigned(Wx_Bitmap) then
    if Wx_Bitmap.Bitmap.Handle <> 0 then
      Result := '#include "' + self.Name + '_XPM.xpm"';
end;

function TWxBitmapButton.GetEventList: TStringList;
begin
  Result := Wx_EventList;
end;

function TWxBitmapButton.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxBitmapButton.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxBitmapButton.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_BUTTON' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxBitmapButton.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxBitmapButton.GetStretchFactor: integer;
begin
  Result := Wx_StretchFactor;
end;

function TWxBitmapButton.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxBitmapButton.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxBitmapButton';
  Result := wx_Class;
end;

procedure TWxBitmapButton.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxBitmapButton.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxBitmapButton.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDValue;
end;

procedure TWxBitmapButton.SetStretchFactor(intValue: integer);
begin
  Wx_StretchFactor := intValue;
end;

procedure TWxBitmapButton.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxBitmapButton.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxBitmapButton.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxBitmapButton.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxBitmapButton.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxBitmapButton.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxBitmapButton.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

procedure TWxBitmapButton.SetButtonBitmap(Value: TPicture);
begin
  if not assigned(Value) then
    exit;
  self.Glyph.Assign(Value.Bitmap);
end;

end.
