// $Id$


unit WxToolButton;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, StdCtrls, Wxutils, ExtCtrls, WxSizerPanel, ComCtrls, Buttons;

type

  TWxToolButton = class(TBitBtn, IWxComponentInterface, IWxToolBarInsertableInterface,
    IWxToolBarNonInsertableInterface)
  private
    FEVT_MENU: string;
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
    FWx_DISABLE_BITMAP: TPicture;
    FWx_VerticalAlignment: TWxSizerVerticalAlignment;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FToolKind: TWxToolbottonItemStyleItem;
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
    procedure SetDisableBitmap(Value: TPicture);
  published
    { Published properties of TWxButton }
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property EVT_MENU: string Read FEVT_MENU Write FEVT_MENU;
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
    property ToolKind: TWxToolbottonItemStyleItem
      Read FToolKind Write FToolKind default wxITEM_NORMAL;
    property Color;
    property Wx_BITMAP: TPicture Read FWx_BITMAP Write SetButtonBitmap;
    property Wx_DISABLE_BITMAP: TPicture Read FWx_DISABLE_BITMAP Write SetDisableBitmap;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxToolButton]);
end;

procedure TWxToolButton.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Border   := 5;
  FWx_Class    := 'wxToolBarTool';
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
  FWx_DISABLE_BITMAP := TPicture.Create;
  self.Width   := 24;
  self.Height  := 24;
  self.Layout  := blGlyphTop;
  FWx_Comments := TStringList.Create;

end; { of AutoInitialize }


procedure TWxToolButton.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_Bitmap.Destroy;
  FWx_DISABLE_BITMAP.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }


procedure TWxToolButton.SetWx_EventList(Value: TStringList);
begin
  FWx_EventList.Assign(Value);
end;

constructor TWxToolButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  AutoInitialize;
  self.Caption := '';

  //FWx_PropertyList.add('wx_Class:Base Class');
  //FWx_PropertyList.add('Wx_Hidden :Hidden');
  //FWx_PropertyList.add('Wx_Border : Border ');
  FWx_PropertyList.add('Wx_HelpText :HelpText ');
  FWx_PropertyList.add('Wx_IDName : IDName ');
  FWx_PropertyList.add('Wx_IDValue : IDValue ');
  FWx_PropertyList.add('Wx_ToolTip :ToolTip ');
  FWx_PropertyList.add('Name : Name');
  FWx_PropertyList.add('ToolKind : ToolKind');
  FWx_PropertyList.add('Caption : Label');
  //FWx_PropertyList.add('Width : Width');
  //FWx_PropertyList.add('Height:Height');

  FWx_PropertyList.add('Wx_Bitmap:Active Bitmap');
  //FWx_PropertyList.add('Wx_DISABLE_BITMAP:Disable Bitmap');

  FWx_PropertyList.add('Wx_Comments:Comments');

  FWx_EventList.add('EVT_MENU:OnClick');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxToolButton.Destroy;
begin
  AutoDestroy;
  inherited Destroy;
end;

procedure TWxToolButton.WMPaint(var Message: TWMPaint);
begin
  inherited;
end;

function TWxToolButton.GenerateEnumControlIDs: string;
begin
  Result := '';
  if not IsControlWxToolBar(self.parent) then
    exit;

  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxToolButton.GenerateControlIDs: string;
begin
  Result := '';
  if not IsControlWxToolBar(self.parent) then
    exit;

  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxToolButton.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

  if not IsControlWxToolBar(self.parent) then
    exit;

  if trim(EVT_MENU) <> '' then
    Result := Format('EVT_MENU(%s,%s::%s)', [WX_IDName, CurrClassName, EVT_MENU]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
end;

function TWxToolButton.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="tool" name="%s">', [self.Name]));
    Result.Add(IndentString + Format('<IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('<ID>%d</ID>', [self.Wx_IDValue]));

    if assigned(Wx_Bitmap) then
      Result.Add(IndentString + Format('<bitmap>%s</bitmap>', [self.Name + '_BITMAP']));

    if assigned(Wx_DISABLE_BITMAP) then
      Result.Add(IndentString + Format('<bitmap2>%s</bitmap2>', [self.Name + '_DISABLE_BITMAP']));

    Result.Add(IndentString + Format('<tooltip>%s</tooltip>', [self.Wx_Tooltip]));
    Result.Add(IndentString + Format('<longhelp>%s</longhelp>', [self.Wx_HelpText]));

    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxToolButton.GenerateGUIControlCreation: string;
var
  parentName: string;
  strFirstBitmap, strSecondBitmap: string;
begin
  Result     := '';
  parentName := GetWxWidgetParent(self);

  if not IsControlWxToolBar(self.parent) then
    exit;


  strFirstBitmap  := 'wxBitmap ' + self.Name + '_BITMAP' + ' (wxNullBitmap);';
  strSecondBitmap := 'wxBitmap ' + self.Name + '_DISABLE_BITMAP' + ' (wxNullBitmap);';

  //Result:='wxBitmap '+self.Name+'_BITMAP'+' (wxNullBitmap);';

  if assigned(Wx_Bitmap) then
    if Wx_Bitmap.Bitmap.Handle <> 0 then
      strFirstBitmap := 'wxBitmap ' + self.Name + '_BITMAP' + ' (' +
        self.Name + '_XPM' + ');';

  if assigned(Wx_DISABLE_BITMAP) then
    if Wx_DISABLE_BITMAP.Bitmap.Handle <> 0 then
      strSecondBitmap := 'wxBitmap ' + self.Name + '_DISABLE_BITMAP' +
        ' (' + self.Name + '_DISABLE_BITMAP_XPM' + ');';

  Result := GetCommentString(self.FWx_Comments.Text) +
    strFirstBitmap + #13 + strSecondBitmap;
  Result := Result + #13 + Format('%s->AddTool(%s, %s, %s, %s, %s, %s, %s);',
    [parentName, GetWxIDString(self.Wx_IDName, self.Wx_IDValue), GetCppString(
    self.Caption), self.Name + '_BITMAP', self.Name + '_DISABLE_BITMAP',
    GetToolButtonKindAsText(ToolKind), GetCppString(self.Wx_ToolTip),
    GetCppString(self.Wx_HelpText)]);

end;

function TWxToolButton.GenerateGUIControlDeclaration: string;
begin
  Result := '';
end;

function TWxToolButton.GenerateHeaderInclude: string;
begin
  Result := '';
end;

function TWxToolButton.GenerateImageInclude: string;
begin
  if assigned(Wx_Bitmap) then
    if Wx_Bitmap.Bitmap.Handle <> 0 then
      Result := '#include "' + self.Name + '_XPM.xpm"';
end;

function TWxToolButton.GetEventList: TStringList;
begin
  Result := Wx_EventList;
end;

function TWxToolButton.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxToolButton.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxToolButton.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_MENU' then
  begin
    Result := 'wxMenuEvent& event';
    exit;
  end;
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxToolButton.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxToolButton.GetStretchFactor: integer;
begin
  Result := Wx_StretchFactor;
end;

function TWxToolButton.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxToolButton.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := '';
  Result := wx_Class;
end;

procedure TWxToolButton.SaveControlOrientation(ControlOrientation:
  TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxToolButton.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxToolButton.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxToolButton.SetStretchFactor(intValue: integer);
begin
  Wx_StretchFactor := intValue;
end;

procedure TWxToolButton.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxToolButton.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxToolButton.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxToolButton.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxToolButton.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxToolButton.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxToolButton.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

procedure TWxToolButton.SetButtonBitmap(Value: TPicture);
begin
  if not assigned(Value) then
    exit;
  self.Glyph.Assign(Value.Bitmap);
end;

procedure TWxToolButton.SetDisableBitmap(Value: TPicture);
begin
  if not assigned(Value) then
    exit;
  FWx_DISABLE_BITMAP.Assign(Value);
end;


end.
