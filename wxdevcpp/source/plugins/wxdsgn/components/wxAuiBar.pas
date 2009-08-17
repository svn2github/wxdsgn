{ ****************************************************************** }
{                                                                    }
{ $Id$                                                               }
{                                                                    }
{   Copyright © 2009 by Malcolm Nealon                        }
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

unit wxAuiBar;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ExtCtrls, WxUtils, WxSizerPanel;

type
  TWxAuiBar = class(TControlBar, IWxComponentInterface, IWxWindowInterface,
    IWxContainerInterface, IWxContainerAndSizerInterface)
  private
    { Private fields of TWxAuiBar }
    {Property Listing}
    FWx_Class: string;
    FWx_PropertyList: TStringList;
    FWx_EventList: TStringList;
    FWx_Comments: TStrings;
    FWx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem;

    {Event Lisiting}

    { Private methods of TWxAuiBar }
    procedure AutoInitialize;
    procedure AutoDestroy;

  protected
    { Protected fields of TWxAuiBar }

    { Protected methods of TWxAuiBar }


  public
    { Public fields and properties of TWxAuiBar }

    { Public methods of TWxAuiBar }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
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
    function GetIDValue: integer;
    function GetParameterFromEventName(EventName: string): string;
    function GetPropertyList: TStringList;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: integer);
    procedure SetWxClassName(wxClassName: string);
    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);
    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);
    function GenerateLastCreationCode: string;

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);
function GetGenericColor(strVariableName:String): string;
procedure SetGenericColor(strVariableName,strValue: string);

    procedure GetAuiDockDirection(Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem);
  published
    { Published properties of TWxPanel }
    property Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem read FWx_Aui_Dock_Direction write FWx_Aui_Dock_Direction;
//    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
//    property Wx_BKColor: TColor Read FWx_BKColor Write FWx_BKColor;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
//    property Wx_ControlOrientation: TWxControlOrientation
//      Read FWx_ControlOrientation Write FWx_ControlOrientation;
//    property Wx_Default: boolean Read FWx_Default Write FWx_Default;
//    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_EventList: TStringList Read FWx_EventList Write FWx_EventList;
//    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
//    property Wx_GeneralStyle: TWxStdStyleSet
//      Read FWx_GeneralStyle Write FWx_GeneralStyle;
//    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
//    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
//    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;

//    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;

//    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
//    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
//    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
//    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;
    
//    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
//    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
//    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
//    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxAuiBar]);
end;


procedure TWxAuiBar.AutoInitialize;
begin
  Caption                := '';
  FWx_Class              := '';
  FWx_PropertyList       := TStringList.Create;
  FWx_EventList          := TStringList.Create;
  FWx_Comments           := TStringList.Create;
//  FWx_Border             := 5;
//  FWx_Enabled            := True;
// FWx_BorderAlignment    := [wxAll];
//  FWx_Alignment          := [wxALIGN_CENTER];
//  FWx_IDValue            := -1;
//  FWx_StretchFactor      := 0;
//  FWx_ProxyBGColorString := TWxColorString.Create;
//  FWx_ProxyFGColorString := TWxColorString.Create;
//  defaultBGColor         := self.color;
//  defaultFGColor         := self.font.color;

{$IFDEF COMPILER_7_UP}
  //Set the background colour for Delphi to draw
  Self.ParentColor := False;
  Self.ParentBackground := False;
{$ENDIF}
end; { of AutoInitialize }


procedure TWxAuiBar.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
//  FWx_ProxyBGColorString.Destroy;
//  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

constructor TWxAuiBar.Create(AOwner: TComponent);
begin
  { Call the Create method of the container's parent class       }
  inherited Create(AOwner);

  { AutoInitialize sets the initial values of variables          }
  { (including subcomponent variables) and properties;           }
  { also, it creates objects for properties of standard          }
  { Delphi object types (e.g., TFont, TTimer, TPicture)          }
  { and for any variables marked as objects.                     }
  { AutoInitialize method is generated by Component Create.      }
  AutoInitialize;

  { Code to perform other tasks when the container is created    }
//  PopulateGenericProperties(FWx_PropertyList);
  FWx_PropertyList.add('Wx_Aui_Dock_Direction:Dock Direction');
  FWx_PropertyList.add('wxAUI_DOCK_NONE:wxAUI_DOCK_NONE');
  FWx_PropertyList.add('wxAUI_DOCK_TOP:wxAUI_DOCK_TOP');
  FWx_PropertyList.add('wxAUI_DOCK_RIGHT:wxAUI_DOCK_RIGHT');
  FWx_PropertyList.add('wxAUI_DOCK_BOTTOM:wxAUI_DOCK_BOTTOM');
  FWx_PropertyList.add('wxAUI_DOCK_LEFT:wxAUI_DOCK_LEFT');



end;

destructor TWxAuiBar.Destroy;
begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
  AutoDestroy;

  { Last, free the component by calling the Destroy method of the    }
  { parent class.                                                    }
  inherited Destroy;
end;

procedure TWxAuiBar.Paint;
begin
  self.Caption := '';
     { Make this component look like its parent component by calling
       its parent's Paint method. }
  inherited Paint;
end;


function TWxAuiBar.GenerateControlIDs: string;
begin
  Result := '';
end;

function TWxAuiBar.GenerateEnumControlIDs: string;
begin
  Result := '';
end;

function TWxAuiBar.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
end;

function TWxAuiBar.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;
  try
    Result.Add('');
  except
    Result.Free;
    raise;
  end;


end;

function TWxAuiBar.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment: string;
  xrctlpanel, kill: boolean; //is this panel a child of another panel
  i: integer;
  wxcompInterface: IWxComponentInterface;
begin
  Result := '';
GetAuiDockDirection(Self.Wx_Aui_Dock_Direction)
{
  parentName := GetWxWidgetParent(self, false);

  strStyle := GetStdStyleString(self.Wx_GeneralStyle);
  if trim(strStyle) <> '' then
    strStyle := ', ' + strStyle;

  xrctlpanel := false;
//how do i find the panels? need the component interface of the tform.
 if (XRCGEN) then
 begin//generate xrc loading code

   if  xrctlpanel then
   begin//this is not the top panel
   Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
    [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);   
   end
   else
   begin
   Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = wxXmlResource::Get()->LoadPanel(%s,%s("%s"));',
    [self.Name, parentName, StringFormat, self.Name])
   end//this is the top level panel
   
 end
 else
 begin//generate the cpp code
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, %s, %s%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);
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

    if ((not (XRCGEN)) and (self.Parent is TWxSizerPanel)) or ((self.Parent is TWxSizerPanel) and (self.Parent.Parent is TForm) and (XRCGEN)) then
  begin
    strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
    Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);
  end;
}
end;

function TWxAuiBar.GenerateGUIControlDeclaration: string;
begin
  Result := '';
//  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxAuiBar.GenerateHeaderInclude: string;
begin
  Result := '';
//  Result := '#include <wx/panel.h>';
end;

function TWxAuiBar.GenerateImageInclude: string;
begin

end;

function TWxAuiBar.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxAuiBar.GetIDName: string;
begin
  Result := '';
//  Result := wx_IDName;
end;

function TWxAuiBar.GetIDValue: integer;
begin
  Result := 0;
end;

function TWxAuiBar.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxAuiBar.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxAuiBar.GetStretchFactor: integer;
begin
  Result := 0;//FWx_StretchFactor;
end;

function TWxAuiBar.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxAuiBar.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := [wxAll];//FWx_BorderAlignment;
end;

procedure TWxAuiBar.SetBorderAlignment(border: TWxBorderAlignment);
begin
//  FWx_BorderAlignment := border;
end;

function TWxAuiBar.GetBorderWidth: integer;
begin
  Result := 0;//FWx_Border;
end;

procedure TWxAuiBar.SetBorderWidth(width: integer);
begin
//  FWx_Border := width;
end;

function TWxAuiBar.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxPanel';
  Result := wx_Class;
end;

procedure TWxAuiBar.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
//  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxAuiBar.SetIDName(IDName: string);
begin
//  wx_IDName := IDName;
end;

procedure TWxAuiBar.SetIDValue(IDValue: integer);
begin
//  Wx_IDValue := IDVAlue;
end;

procedure TWxAuiBar.SetStretchFactor(intValue: integer);
begin
//  FWx_StretchFactor := intValue;
end;

procedure TWxAuiBar.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxAuiBar.GetGenericColor(strVariableName:String): string;
begin

end;

procedure TWxAuiBar.SetGenericColor(strVariableName,strValue: string);
begin

end;


function TWxAuiBar.GetFGColor: string;
begin
//  Result := FInvisibleFGColorString;
end;

procedure TWxAuiBar.SetFGColor(strValue: string);
begin
{  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);   }
end;

function TWxAuiBar.GetBGColor: string;
begin
//  Result := FInvisibleBGColorString;
end;

procedure TWxAuiBar.SetBGColor(strValue: string);
begin
{  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);   }
end;

procedure TWxAuiBar.SetProxyFGColorString(Value: string);
begin
 // FInvisibleFGColorString := Value;
//  self.Color := GetColorFromString(Value);
end;

procedure TWxAuiBar.SetProxyBGColorString(Value: string);
begin
//  FInvisibleBGColorString := Value;
 // self.Font.Color := GetColorFromString(Value);
end;

function TWxAuiBar.GenerateLastCreationCode: string;
begin
  Result := '';
end;

procedure TWxAuiBar.GetAuiDockDirection(Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem);
begin
  if Wx_Aui_Dock_Direction = wxAUI_DOCK_NONE then
  begin
    Self.Align := alNone;
    exit;
  end;
  if Wx_Aui_Dock_Direction = wxAUI_DOCK_TOP then
  begin
    Self.Align := alTop;
    exit;
  end;
  if Wx_Aui_Dock_Direction = wxAUI_DOCK_RIGHT then
  begin
    Self.Align := alRight;
    exit;
  end;
  if Wx_Aui_Dock_Direction = wxAUI_DOCK_BOTTOM then
  begin
    Self.Align := alBottom;
    exit;
  end;
  if Wx_Aui_Dock_Direction = wxAUI_DOCK_LEFT then
  begin
    Self.Align := alLeft;
    exit;
  end;
  if Wx_Aui_Dock_Direction = wxAUI_DOCK_CENTER then
  begin
    Self.Align := alNone;
    exit;
  end;
end;

end.
