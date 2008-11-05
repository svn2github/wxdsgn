// $Id: WxButton.pas 936 2007-05-15 03:47:39Z gururamnath $ 
{                                                                    }
{   Copyright © 2003-2007 by Guru Kathiresan                         }
{                                                                    }
{License :                                                           }
{=========                                                           }
{The wx-devC++ Components, Form Designer, Utils classes              }
{are exclusive properties of Guru Kathiresan.                        }
{The code is available in dual Licenses:                             }
{                               1)GPL Compatible  License            }
{                               2)Commercial License                 }
{                                                                    }
{1)GPL License :                                                     }
{ Code can be used in any project as long as the project's sourcecode}
{ is published under GPL license.                                    }
{                                                                    }
{2)Commercial License:                                               }
{Use of code in this file or the one that bear this license text     }
{can be used in Non-GPL projects as long as you get the permission   }
{from the Author - Guru Kathiresan.                                  }
{Use of the Code in any non-gpl projects without the permission of   }
{the author is illegal.                                              }
{Contact gururamnath@yahoo.com for details                           }
{ ****************************************************************** }

unit WxButton;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, StdCtrls, Wxutils, ExtCtrls, WxSizerPanel, WxToolBar,
  UValidator;

type
  TDrawButtonEvent = procedure(Control: TWinControl; Rect: TRect;
    State: TOwnerDrawState) of object;

  TWxButton = class(TMultiLineBtn, IWxComponentInterface,
    IWxToolBarInsertableInterface, IWxToolBarNonInsertableInterface,
    IWxValidatorInterface)
  private
    FCanvas: TCanvas;
    FOnDrawButton: TDrawButtonEvent;
    { Private fields of TWxButton }

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
    FWx_IDName: string;
    FWx_IDValue: longint;
    FWx_Validator: string;
    FWx_ProxyBGColorString: TWxColorString;
    FWx_ProxyFGColorString: TWxColorString;
    FWx_StretchFactor: integer;
    FWx_ToolTip: string;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_Comments: TStrings;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;
    FWx_ProxyValidatorString : TWxValidatorString;

    procedure AutoInitialize;
    procedure AutoDestroy;

  protected
    { Protected fields of TWxButton }

    { Protected methods of TWxButton }

  public
    { Public fields and properties of TWxButton }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    defaultHeight : integer;
    defaultWidth : integer;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
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
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: longint);
    procedure SetWxClassName(wxClassName: string);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

    function GetValidator:String;
    procedure SetValidator(value:String);
    function GetValidatorString:TWxValidatorString;
    procedure SetValidatorString(Value:TWxValidatorString);

    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);
    procedure Click; override;
  public
    property Canvas: TCanvas Read FCanvas;

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
    property Wx_ButtonStyle: TWxBtnStyleSet Read FWx_ButtonStyle Write FWx_ButtonStyle;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_Default: boolean Read FWx_Default Write FWx_Default;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_EventList: TStringList Read FWx_EventList Write FWx_EventList;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_Validator: string Read FWx_Validator Write FWx_Validator;
    property Wx_ProxyValidatorString : TWxValidatorString Read GetValidatorString Write SetValidatorString;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;

    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;
    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;

    property OnDrawButton: TDrawButtonEvent Read FOnDrawButton Write FOnDrawButton;
    property Color;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxButton]);
end;

{ Method to set variable and property values and create objects }
procedure TWxButton.AutoInitialize;
begin
  FWx_PropertyList       := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxButton';
  FWx_Enabled            := True;
  FWx_EventList          := TStringList.Create;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_IDValue            := -1;
  FWx_StretchFactor      := 0;
  FWx_Comments           := TStringList.Create;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  FWx_ProxyValidatorString := TwxValidatorString.Create(self);
  defaultBGColor         := self.color;
  defaultFGColor         := self.font.color;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxButton.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
  FWx_ProxyValidatorString.Destroy;
end; { of AutoDestroy }

{ Override OnClick handler from TButton,IWxComponentInterface }
procedure TWxButton.Click;
begin
  inherited Click;
end;

constructor TWxButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCanvas := TCanvas.Create;
  AutoInitialize;

  { Code to perform other tasks when the component is created }
  PopulateGenericProperties(FWx_PropertyList);
  FWx_PropertyList.add('Wx_ButtonStyle:Button Styles');
  FWx_PropertyList.add('wxBU_LEFT:wxBU_LEFT');
  FWx_PropertyList.add('wxBU_TOP:wxBU_TOP');
  FWx_PropertyList.add('wxBU_RIGHT:wxBU_RIGHT');
  FWx_PropertyList.add('wxBU_BOTTOM:wxBU_BOTTOM');
  FWx_PropertyList.add('wxBU_EXACTFIT:wxBU_EXACTFIT');

  FWx_PropertyList.add('Caption:Label');

  FWx_EventList.add('EVT_BUTTON:OnClick');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxButton.Destroy;
begin
  AutoDestroy;
  inherited Destroy;
  FCanvas.Free;
end;


function TWxButton.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxButton.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;


function TWxButton.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

  if (XRCGEN) then
 begin
  if trim(EVT_BUTTON) <> '' then
    Result := Format('EVT_BUTTON(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
      EVT_BUTTON]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
 end
 else
 begin
  if trim(EVT_BUTTON) <> '' then
    Result := Format('EVT_BUTTON(%s,%s::%s)', [WX_IDName, CurrClassName,
      EVT_BUTTON]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
 end;

end;

function TWxButton.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <label>%s</label>', [XML_Label(self.Caption)]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));

    if not(UseDefaultSize)then
      Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    if not(UseDefaultPos) then
      Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetButtonSpecificStyle(self.Wx_GeneralStyle, Wx_ButtonStyle)]));
    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxButton.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle:    string;
  parentName, strAlignment: string;

begin
  Result     := '';

  strStyle   := GetButtonSpecificStyle(self.Wx_GeneralStyle, Wx_ButtonStyle);
  parentName := GetWxWidgetParent(self);

  if trim(Wx_ProxyValidatorString.strValidatorValue) <> '' then
  begin
    if trim(strStyle) <> '' then
      strStyle := ', ' + strStyle + ', ' + Wx_ProxyValidatorString.strValidatorValue
    else
      strStyle := ', 0, ' + Wx_ProxyValidatorString.strValidatorValue;

    strStyle := strStyle + ', ' + GetCppString(Name);

  end
  else if trim(strStyle) <> '' then
    strStyle := ', ' + strStyle + ', wxDefaultValidator, ' + GetCppString(Name)
  else
    strStyle := ', 0, wxDefaultValidator, ' + GetCppString(Name);

if (XRCGEN) then
 begin//generate xrc loading code
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
    [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);   
 end
 else
 begin
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, %s, %s, %s%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    GetCppString(self.Text), GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);
 end;

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

  if self.Default then
    Result := Result + #13 + Format('%s->SetDefault();', [self.Name]);


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
if not (XRCGEN) then //NUKLEAR ZELPH
  if (self.Parent is TWxSizerPanel) then
  begin
      strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
      Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);

  end;
  if (self.Parent is TWxToolBar) and not (XRCGEN) then
    Result := Result + #13 + Format('%s->AddControl(%s);',
      [self.Parent.Name, self.Name]);

  // Set the button caption horizontal alignment
  if (wxBU_LEFT in Wx_ButtonStyle) then
    HorizAlign := halLeft
  else if (wxBU_RIGHT in Wx_ButtonStyle) then
    HorizAlign := halRight
  else
    HorizAlign := halCentre;

  // Set the button caption horizontal alignment
  if (wxBU_TOP in Wx_ButtonStyle) then
    VerticalAlign := valTop
  else if (wxBU_BOTTOM in Wx_ButtonStyle) then
    VerticalAlign := valBottom
  else
    VerticalAlign := valCentre;

end;

function TWxButton.GenerateGUIControlDeclaration: string;
begin
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxButton.GenerateHeaderInclude: string;
begin
  Result := '#include <wx/button.h>';
end;

function TWxButton.GenerateImageInclude: string;
begin

end;

function TWxButton.GetEventList: TStringList;
begin
  Result := Wx_EventList;
end;

function TWxButton.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxButton.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxButton.GetParameterFromEventName(EventName: string): string;
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

function TWxButton.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxButton.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxButton.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxButton.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxButton.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxButton.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxButton.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxButton.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxButton';
  Result := wx_Class;
end;

procedure TWxButton.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxButton.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxButton.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDValue;
end;

procedure TWxButton.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxButton.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxButton.GetGenericColor(strVariableName:String): string;
begin

end;

procedure TWxButton.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxButton.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxButton.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxButton.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxButton.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxButton.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxButton.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxButton.GetValidatorString:TWxValidatorString;
begin
  Result := FWx_ProxyValidatorString;
  Result.FstrValidatorValue := Wx_Validator;
end;

procedure TWxButton.SetValidatorString(Value:TWxValidatorString);
begin
  FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
  Wx_Validator := Value.FstrValidatorValue;
end;

function TWxButton.GetValidator:String;
begin
  Result := Wx_Validator;
end;

procedure TWxButton.SetValidator(value:String);
begin
  Wx_Validator := value;
end;

end.
