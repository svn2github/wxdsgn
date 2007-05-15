 { ****************************************************************** }
 {                                                                    }
 { $Id$          }
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

unit WxGauge;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ComCtrls, WxUtils, ExtCtrls, WxSizerPanel;

type
  TWxGauge = class(TProgressBar, IWxComponentInterface)
  private
    { Private fields of TWxGauge }
    { Storage for property EVT_UPDATE_UI }
    FEVT_UPDATE_UI: string;
    { Storage for property Wx_BGColor }
    FWx_BGColor: TColor;
    { Storage for property Wx_ControlOrientation }
    FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_Border }
    FWx_Border: integer;
    { Storage for property Wx_Class }
    FWx_Class: string;
    { Storage for property Wx_Enabled }
    FWx_Enabled: boolean;
    { Storage for property Wx_FGColor }
    FWx_FGColor: TColor;
    { Storage for property Wx_GaugeOrientation }
    FWx_GaugeOrientation: TWxGagOrientation;
    { Storage for property Wx_GaugeStyle }
    FWx_GaugeStyle: TWxGagStyleSet;
    { Storage for property Wx_GeneralStyle }
    FWx_GeneralStyle: TWxStdStyleSet;
    { Storage for property Wx_HelpText }
    FWx_HelpText: string;
    { Storage for property Wx_Hidden }
    FWx_Hidden: boolean;
    { Storage for property Wx_IDName }
    FWx_IDName: string;
    { Storage for property Wx_IDValue }
    FWx_IDValue: longint;
    { Storage for property Wx_ProxyBGColorString }
    FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
    FWx_ProxyFGColorString: TWxColorString;
    { Storage for property Wx_StretchFactor }
    FWx_StretchFactor: integer;
    { Storage for property Wx_ToolTip }
    FWx_ToolTip: string;
    FWx_EventList: TStringList;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_Validator: string;
    FWx_Comments: TStrings;
    FLastOrientation: TWxGagOrientation;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

    { Private methods of TWxGauge }
    { Method to set variable and property values and create objects }
    procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
    procedure AutoDestroy;

  protected
    { Protected fields of TWxGauge }

    { Protected methods of TWxGauge }
    procedure Loaded; override;

  public
    { Public fields and properties of TWxGauge }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxGauge }
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
    function GetFGColor: string;
    procedure SetFGColor(strValue: string);

    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);
    function GetGaugeOrientation(Wx_GaugeOrientation: TWxGAgOrientation): string;

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

  published
    { Published properties of TWxGauge }
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GaugeOrientation: TWxGagOrientation
      Read FWx_GaugeOrientation Write FWx_GaugeOrientation;
    property Wx_GaugeStyle: TWxGAgStyleSet Read FWx_GaugeStyle Write FWx_GaugeStyle;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property LastOrientation: TWxGagOrientation Read FLastOrientation Write FLastOrientation;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden default False;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;
    property Wx_Validator: string Read FWx_Validator Write FWx_Validator;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;

    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;
    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxGauge with wxWidgets as its
       default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TWxGauge]);
end;

{ Method to set variable and property values and create objects }
procedure TWxGauge.AutoInitialize;
begin
  FWx_EventList           := TStringList.Create;
  FWx_PropertyList        := TStringList.Create;
  FWx_Border              := 5;
  FWx_Class               := 'wxGauge';
  FWx_Enabled             := True;
  FWx_Hidden              := False;
  FWx_BorderAlignment     := [wxAll];
  FWx_Alignment           := [wxALIGN_CENTER];
  FWx_IDValue             := -1;
  FWx_StretchFactor       := 0;
  FWx_ProxyBGColorString  := TWxColorString.Create;
  FWx_ProxyFGColorString  := TWxColorString.Create;
  defaultBGColor          := self.color;
  defaultFGColor          := self.font.color;
  FWx_Comments            := TStringList.Create;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxGauge.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

constructor TWxGauge.Create(AOwner: TComponent);
begin
  { Call the Create method of the parent class }
  inherited Create(AOwner);

  { AutoInitialize sets the initial values of variables and      }
  { properties; also, it creates objects for properties of       }
  { standard Delphi object types (e.g., TFont, TTimer,           }
  { TPicture) and for any variables marked as objects.           }
  { AutoInitialize method is generated by Component Create.      }
  AutoInitialize;

  { Code to perform other tasks when the component is created }
  PopulateGenericProperties(FWx_PropertyList);

  FWx_PropertyList.add('Wx_GaugeStyle:Gauge Styles');
  FWx_PropertyList.Add('wxGA_SMOOTH:wxGA_SMOOTH');
  FWx_PropertyList.Add('wxGA_MARQUEE:wxGA_MARQUEE');

  FWx_PropertyList.add('Wx_GaugeOrientation:Orientation');
  FWx_PropertyList.add('Max:Range');
  FWx_PropertyList.add('Position:Value');

  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxGauge.Destroy;
begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
  AutoDestroy;

  { Here, free any other dynamic objects that the component methods  }
  { created but have not yet freed.  Also perform any other clean-up }
  { operations needed before the component is destroyed.             }

  { Last, free the component by calling the Destroy method of the    }
  { parent class.                                                    }
  inherited Destroy;
end;


function TWxGauge.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxGauge.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

procedure TWxGauge.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

function TWxGauge.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
end;

function TWxGauge.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('<IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('<ID>%d</ID>', [self.Wx_IDValue]));
    Result.Add(IndentString + Format('<size>%d,%d</size>', [self.Width, self.Height]));
    Result.Add(IndentString + Format('<pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + Format('<range>%d</range>', [self.Max]));
    Result.Add(IndentString + Format('<value>%d</value>', [self.Position]));

    Result.Add(IndentString + Format('<orient>%s</orient>',
      [GetGaugeOrientation(Wx_GaugeOrientation)]));

    Result.Add(IndentString + Format('<style>%s</style>',
      [GetGaugeSpecificStyle(self.Wx_GeneralStyle, Wx_GaugeStyle)]));
    Result.Add(IndentString + '</object>');
  except
    Result.Free;
    raise;
  end;

end;

function TWxGauge.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment: string;
begin
  Result := '';
  parentName := GetWxWidgetParent(self);
  strStyle := GetGaugeSpecificStyle(self.Wx_GeneralStyle, Wx_GaugeStyle);

  if (trim(strStyle) <> '') then
    strStyle := ', ' + GetGaugeOrientation(Wx_GaugeOrientation) + '|' + strStyle
  else
    strStyle := ', ' + GetGaugeOrientation(Wx_GaugeOrientation);

  if trim(self.FWx_Validator) <> '' then
  begin
    if trim(strStyle) <> '' then
      strStyle := strStyle + ', ' + self.Wx_Validator
    else
      strStyle := ', wxGA_HORIZONTAL, ' + self.Wx_Validator;
    strStyle := strStyle + ', ' + GetCppString(Name);

  end;
  strStyle := strStyle + ', wxDefaultValidator, ' + GetCppString(Name);

  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, %d, wxPoint(%d,%d), wxSize(%d,%d)%s);',
    [self.Name, self.Wx_Class, ParentName,
    GetWxIDString(self.Wx_IDName, self.Wx_IDValue), self.Max, self.Left,
    self.Top, self.Width, self.Height, strStyle]);

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

  Result := Result + #13 + Format('%s->SetRange(%d);', [self.Name, self.Max]);
  Result := Result + #13 + Format('%s->SetValue(%d);', [self.Name, self.Position]);

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
    strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
    Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);
  end;

  if wxGA_SMOOTH in Wx_GaugeStyle then
    Smooth := True
  else
    Smooth := False;

  // Set border style
  if wxSUNKEN_BORDER in self.Wx_GeneralStyle then
  begin
    self.BevelInner := bvLowered;
    self.BevelOuter := bvLowered;
    self.BevelKind  := bkSoft;
  end
  else if wxRAISED_BORDER in self.Wx_GeneralStyle then
  begin
    self.BevelInner := bvRaised;
    self.BevelOuter := bvRaised;
    self.BevelKind  := bkSoft;
  end
  else if wxNO_BORDER in self.Wx_GeneralStyle then
  begin
    self.BevelInner := bvNone;
    self.BevelOuter := bvNone;
    self.BevelKind  := bkNone;
  end
  else if wxDOUBLE_BORDER in self.Wx_GeneralStyle then
  begin
    self.BevelInner := bvSpace;
    self.BevelOuter := bvSpace;
    self.BevelKind  := bkTile;
  end
  else begin
    self.BevelInner := bvNone;
    self.BevelOuter := bvNone;
    self.BevelKind  := bkNone;
  end;
end;

function TWxGauge.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxGauge.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/gauge.h>';
end;

function TWxGauge.GenerateImageInclude: string;
begin

end;

function TWxGauge.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxGauge.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxGauge.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxGauge.GetParameterFromEventName(EventName: string): string;
begin

if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;

end;

function TWxGauge.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxGauge.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxGauge.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxGauge.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxGauge.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxGauge.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxGauge.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxGauge.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxGauge';
  Result := wx_Class;
end;

procedure TWxGauge.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxGauge.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxGauge.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxGauge.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxGauge.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxGauge.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxGauge.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxGauge.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxGauge.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxGauge.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxGauge.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxGauge.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxGauge.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxGauge.GetGaugeOrientation(Wx_GaugeOrientation: TWxGAgOrientation): string;
var
  temp: integer;
begin
  Result := '';
  if Wx_GaugeOrientation = wxGA_VERTICAL then
  begin
    Result := 'wxGA_VERTICAL';
    self.Orientation := pbVertical;
    FWx_ControlOrientation := wxControlVertical;

  end;

  if Wx_GaugeOrientation = wxGA_HORIZONTAL then
  begin
    Result := 'wxGA_HORIZONTAL';
    self.Orientation := pbHorizontal;
    FWx_ControlOrientation := wxControlHorizontal;

  end;

  if (FLastOrientation <> Wx_GaugeOrientation) then
  begin
    FLastOrientation := Wx_GaugeOrientation;
    temp   := Width;
    Width  := Height;
    Height := temp;
    inherited SetBounds(Left, Top, Width, Height);
  end;

end;

end.
