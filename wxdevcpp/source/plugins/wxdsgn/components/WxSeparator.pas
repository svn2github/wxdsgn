// $Id: WxSeparator.pas 936 2007-05-15 03:47:39Z gururamnath $
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


unit WxSeparator;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, StdCtrls, Wxutils, ExtCtrls, WxSizerPanel, ComCtrls;

type

  TWxSeparator = class(TToolButton, IWxComponentInterface,
    IWxToolBarInsertableInterface, IWxToolBarNonInsertableInterface)
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
    FWx_IDName: string;
    FWx_IDValue: longint;
    FWx_ProxyBGColorString: TWxColorString;
    FWx_ProxyFGColorString: TWxColorString;
    FWx_StretchFactor: integer;
    FWx_ToolTip: string;
    FWx_Bitmap: TPicture;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_Comments: TStrings;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

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
    procedure SetButtonBitmap(Value: TPicture);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

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
    property Wx_EventList: TStringList Read FWx_EventList Write SetWx_EventList;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;
    property Color;
    property Wx_BITMAP: TPicture Read FWx_BITMAP Write SetButtonBitmap;

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
  RegisterComponents('wxWidgets', [TWxSeparator]);
end;

procedure TWxSeparator.AutoInitialize;
begin
  FWx_PropertyList       := TStringList.Create;
  FWx_Comments           := TStringList.Create;
  FWx_EventList          := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxToolBarTool';
  FWx_Enabled            := True;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_IDValue            := -1;
  FWx_StretchFactor      := 0;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor         := self.color;
  defaultFGColor         := self.font.color;
  Caption                := '';
  FWx_Bitmap             := TPicture.Create;
  self.Style             := tbsDivider;
  self.Width             := 5;
end; { of AutoInitialize }


procedure TWxSeparator.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_Bitmap.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }


procedure TWxSeparator.SetWx_EventList(Value: TStringList);
begin
  FWx_EventList.Assign(Value);
end;

constructor TWxSeparator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  AutoInitialize;
  self.Caption := '';
  FWx_PropertyList.add('Width:Width');
  FWx_PropertyList.add('Wx_Comments:Comments');

  FWx_EventList.add('EVT_BUTTON:OnClick');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxSeparator.Destroy;
begin
  AutoDestroy;
  inherited Destroy;
end;

procedure TWxSeparator.WMPaint(var Message: TWMPaint);
begin
  self.Caption := '';
  inherited;
end;


function TWxSeparator.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxSeparator.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxSeparator.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
  if not IsControlWxToolBar(self.parent) then
    exit;

 if (XRCGEN) then
 begin//generate xrc loading code
  if trim(EVT_BUTTON) <> '' then
    Result := Format('EVT_BUTTON(XRCID(%s("%s")),%s::%s)', 
    [StringFormat, self.Name, CurrClassName, EVT_BUTTON]) + '';

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

function TWxSeparator.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;
  try
    Result.Add(IndentString + '<object class="separator"/>');
    //Result.Add(IndentString + '</object>');
  except
    Result.Free;
    raise;
  end;

end;

function TWxSeparator.GenerateGUIControlCreation: string;
var
  parentName: string;
begin
  Result := '';
 if not (XRCGEN) then
 begin
  if not IsControlWxToolBar(self.parent) then
    exit;
  parentName := GetWxWidgetParent(self, False);
  Result     := GetCommentString(self.FWx_Comments.Text) + parentName +
    '->AddSeparator();';
 end;
end;

function TWxSeparator.GenerateGUIControlDeclaration: string;
begin
  Result := '';
end;

function TWxSeparator.GenerateHeaderInclude: string;
begin
  Result := '';
end;

function TWxSeparator.GenerateImageInclude: string;
begin
  if assigned(Wx_Bitmap) then
    if Wx_Bitmap.Bitmap.Handle <> 0 then
      Result := '#include "' + self.Name + '_XPM.xpm"';
end;

function TWxSeparator.GetEventList: TStringList;
begin
  Result := Wx_EventList;
end;

function TWxSeparator.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxSeparator.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxSeparator.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxSeparator.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxSeparator.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxSeparator.GetTypeFromEventName(EventName: string): string;
begin

end;             

function TWxSeparator.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxSeparator.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxSeparator.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxSeparator.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxSeparator.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := '';
  Result := wx_Class;
end;

procedure TWxSeparator.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxSeparator.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxSeparator.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxSeparator.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxSeparator.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxSeparator.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxSeparator.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxSeparator.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxSeparator.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxSeparator.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxSeparator.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxSeparator.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxSeparator.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

procedure TWxSeparator.SetButtonBitmap(Value: TPicture);
begin
  if not assigned(Value) then
    exit;
  //self.Glyph.Assign(value.Bitmap);
end;

end.
