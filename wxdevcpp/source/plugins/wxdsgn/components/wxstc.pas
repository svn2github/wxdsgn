 { ****************************************************************** }
 {                                                                    }
 { $Id: wxstc.pas 936 2007-05-15 03:47:39Z gururamnath $         }
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

unit WxStc;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, StdCtrls, Wxutils, ExtCtrls, WxSizerPanel, Dialogs, WxAuiNotebookPage, wxAuiToolBar,
  xprocs;

type
  TWxStyledTextCtrl = class(TMemo, IWxComponentInterface,IWxVariableAssignmentInterface)
  private
    { Private fields of TWxStyledTextCtrl }
    { Storage for property EVT_TEXT }
    FEVT_TEXT: string;
    { Storage for property EVT_TEXT_ENTER }
    FEVT_TEXT_ENTER: string;
    { Storage for property EVT_TEXT_MAXLEN }
    FEVT_TEXT_MAXLEN: string;
    { Storage for property EVT_TEXT_URL }
    FEVT_TEXT_URL: string;
    { Storage for property EVT_UPDATE_UI }
    FEVT_UPDATE_UI: string;

    FEVT_STC_CALLTIP_CLICK: string;
    FEVT_STC_CHANGE: string;
    FEVT_STC_CHARADDED: string;
    FEVT_STC_DO_DROP: string;
    FEVT_STC_DOUBLECLICK: string;
    FEVT_STC_DRAG_OVER: string;
    FEVT_STC_DWELLEND: string;
    FEVT_STC_DWELLSTART: string;
    FEVT_STC_HOTSPOT_CLICK: string;
    FEVT_STC_HOTSPOT_DCLICK: string;
    FEVT_STC_KEY: string;
    FEVT_STC_MACRORECORD: string;
    FEVT_STC_MARGINCLICK: string;
    FEVT_STC_MODIFIED: string;
    FEVT_STC_NEEDSHOWN: string;
    FEVT_STC_PAINTED: string;
    FEVT_STC_ROMODIFYATTEMPT: string;
    FEVT_STC_SAVEPOINTLEFT: string;
    FEVT_STC_SAVEPOINTREACHED: string;
    FEVT_STC_START_DRAG: string;
    FEVT_STC_STYLENEEDED: string;
    FEVT_STC_UPDATEUI: string;
    FEVT_STC_URIDROPPED: string;
    FEVT_STC_USERLISTSELECTION: string;
    FEVT_STC_ZOOM: string;
    FEVT_STC_AUTOCOMP_SELECTION :string;

    { Storage for property Wx_BGColor }
    FWx_BGColor: TColor;
    { Storage for property Wx_Border }
    FWx_Border: integer;
    { Storage for property Wx_Class }
    FWx_Class: string;
    { Storage for property Wx_ControlOrientation }
    FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_EditStyle }
    { Storage for property Wx_Enabled }
    FWx_Enabled: boolean;
    { Storage for property Wx_FGColor }
    FWx_FGColor: TColor;
    { Storage for property Wx_GeneralStyle }
    FWx_GeneralStyle: TWxStdStyleSet;
    { Storage for property Wx_HelpText }
    FWx_HelpText: string;
    { Storage for property Wx_Hidden }
    FWx_Hidden: boolean;
    { Storage for property Wx_IDName }
    FWx_IDName: string;
    { Storage for property Wx_IDValue }
    FWx_IDValue: integer;
    { Storage for property Wx_ProxyBGColorString }
    FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
    FWx_ProxyFGColorString: TWxColorString;
    { Storage for property Wx_StretchFactor }
    FWx_StretchFactor: integer;
    { Storage for property Wx_ToolTip }
    FWx_ToolTip: string;
    FWx_MaxLength: integer;
    FWx_Comments: TStrings;
    FWx_LoadFromFile: TWxFileNameString;
    FWx_FiletoLoad: string;
    FWx_EventList: TStringList;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;
    FWx_LHSValue : String;
    FWx_RHSValue : String;

//Aui Properties
    FWx_AuiManaged: Boolean;
    FWx_PaneCaption: string;
    FWx_PaneName: string;
    FWx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem;
    FWx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet;
    FWx_Aui_Pane_Style: TwxAuiPaneStyleSet;
    FWx_Aui_Pane_Buttons: TwxAuiPaneButtonSet;
    FWx_BestSize_Height: Integer;
    FWx_BestSize_Width: Integer;
    FWx_MinSize_Height: Integer;
    FWx_MinSize_Width: Integer;
    FWx_MaxSize_Height: Integer;
    FWx_MaxSize_Width: Integer;
    FWx_Floating_Height: Integer;
    FWx_Floating_Width: Integer;
    FWx_Floating_X_Pos: Integer;
    FWx_Floating_Y_Pos: Integer;
    FWx_Layer: Integer;
    FWx_Row: Integer;
    FWx_Position: Integer;

    { Private methods of TWxStyledTextCtrl }
    { Method to set variable and property values and create objects }
    procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
    procedure AutoDestroy;
    { Write method for property Wx_ToolTip }
    procedure SetWx_ToolTip(Value: string);

  protected
    { Protected fields of TWxStyledTextCtrl }

    { Protected methods of TWxStyledTextCtrl }
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;

  public
    { Public fields and properties of TWxStyledTextCtrl }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxStyledTextCtrl }
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
    function GetIDValue: integer;
    function GetParameterFromEventName(EventName: string): string;
    function GetPropertyList: TStringList;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: integer);
    procedure SetWxClassName(wxClassName: string);
    procedure SetWxFileName(wxFileName: string);
    function GetFGColor: string;
    procedure SetFGColor(strValue: string);

    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);
    function GetLHSVariableAssignment:String;
    function GetRHSVariableAssignment:String;

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);
    
  published
    { Published properties of TWxStyledTextCtrl }
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property EVT_TEXT: string Read FEVT_TEXT Write FEVT_TEXT;
    property EVT_TEXT_ENTER: string Read FEVT_TEXT_ENTER Write FEVT_TEXT_ENTER;
    property EVT_TEXT_MAXLEN: string Read FEVT_TEXT_MAXLEN Write FEVT_TEXT_MAXLEN;
    property EVT_TEXT_URL: string Read FEVT_TEXT_URL Write FEVT_TEXT_URL;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;

    property EVT_STC_CALLTIP_CLICK: string Read FEVT_STC_CALLTIP_CLICK Write FEVT_STC_CALLTIP_CLICK;
    property EVT_STC_CHANGE: string Read FEVT_STC_CHANGE Write FEVT_STC_CHANGE;
    property EVT_STC_CHARADDED: string Read FEVT_STC_CHARADDED Write FEVT_STC_CHARADDED;
    property EVT_STC_DO_DROP: string Read FEVT_STC_DO_DROP Write FEVT_STC_DO_DROP;
    property EVT_STC_DOUBLECLICK: string Read FEVT_STC_DOUBLECLICK Write FEVT_STC_DOUBLECLICK;
    property EVT_STC_DRAG_OVER: string Read FEVT_STC_DRAG_OVER Write FEVT_STC_DRAG_OVER;
    property EVT_STC_DWELLEND: string Read FEVT_STC_DWELLEND Write FEVT_STC_DWELLEND;
    property EVT_STC_DWELLSTART: string Read FEVT_STC_DWELLSTART Write FEVT_STC_DWELLSTART;
    property EVT_STC_HOTSPOT_CLICK: string Read FEVT_STC_HOTSPOT_CLICK Write FEVT_STC_HOTSPOT_CLICK;
    property EVT_STC_HOTSPOT_DCLICK: string Read FEVT_STC_HOTSPOT_DCLICK Write FEVT_STC_HOTSPOT_DCLICK;
    property EVT_STC_KEY: string Read FEVT_STC_KEY Write FEVT_STC_KEY;
    property EVT_STC_MACRORECORD: string Read FEVT_STC_MACRORECORD Write FEVT_STC_MACRORECORD;
    property EVT_STC_MARGINCLICK: string Read FEVT_STC_MARGINCLICK Write FEVT_STC_MARGINCLICK;
    property EVT_STC_MODIFIED: string Read FEVT_STC_MODIFIED Write FEVT_STC_MODIFIED;
    property EVT_STC_NEEDSHOWN: string Read FEVT_STC_NEEDSHOWN Write FEVT_STC_NEEDSHOWN;
    property EVT_STC_PAINTED: string Read  FEVT_STC_PAINTED Write FEVT_STC_PAINTED;
    property EVT_STC_ROMODIFYATTEMPT: string Read  FEVT_STC_ROMODIFYATTEMPT Write FEVT_STC_ROMODIFYATTEMPT;
    property EVT_STC_SAVEPOINTLEFT: string Read FEVT_STC_SAVEPOINTLEFT Write FEVT_STC_SAVEPOINTLEFT;
    property EVT_STC_SAVEPOINTREACHED: string Read FEVT_STC_SAVEPOINTREACHED Write FEVT_STC_SAVEPOINTREACHED;
    property EVT_STC_START_DRAG: string Read FEVT_STC_START_DRAG Write FEVT_STC_START_DRAG;
    property EVT_STC_STYLENEEDED: string Read FEVT_STC_STYLENEEDED Write FEVT_STC_STYLENEEDED;
    property EVT_STC_UPDATEUI: string Read FEVT_STC_UPDATEUI Write FEVT_STC_UPDATEUI;
    property EVT_STC_URIDROPPED: string Read  FEVT_STC_URIDROPPED Write FEVT_STC_URIDROPPED;
    property EVT_STC_USERLISTSELECTION: string Read  FEVT_STC_USERLISTSELECTION Write FEVT_STC_USERLISTSELECTION;
    property EVT_STC_ZOOM: string Read  FEVT_STC_ZOOM Write FEVT_STC_ZOOM;
    property EVT_STC_AUTOCOMP_SELECTION: string Read  FEVT_STC_AUTOCOMP_SELECTION Write FEVT_STC_AUTOCOMP_SELECTION;

    property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden default False;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: integer Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_ToolTip: string Read FWx_ToolTip Write SetWx_ToolTip;
    property Wx_MaxLength: integer Read FWx_MaxLength Write FWx_MaxLength;
    property Wx_LoadFromFile: TWxFileNameString Read FWx_LoadFromFile Write FWx_LoadFromFile;
    property Wx_FiletoLoad: string Read FWx_FiletoLoad Write FWx_FiletoLoad;

    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
    property Wx_LHSValue: string Read FWx_LHSValue Write FWx_LHSValue;
    property Wx_RHSValue: string Read FWx_RHSValue Write FWx_RHSValue;

//Aui Properties
    property Wx_AuiManaged: boolean read FWx_AuiManaged write FWx_AuiManaged default False;
    property Wx_PaneCaption: string read FWx_PaneCaption write FWx_PaneCaption;
    property Wx_PaneName: string read FWx_PaneName write FWx_PaneName;
    property Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem read FWx_Aui_Dock_Direction write FWx_Aui_Dock_Direction;
    property Wx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet read FWx_Aui_Dockable_Direction write FWx_Aui_Dockable_Direction;
    property Wx_Aui_Pane_Style: TwxAuiPaneStyleSet read FWx_Aui_Pane_Style write FWx_Aui_Pane_Style;
    property Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet read FWx_Aui_Pane_Buttons write FWx_Aui_Pane_Buttons;
    property Wx_BestSize_Height: integer read FWx_BestSize_Height write FWx_BestSize_Height default -1;
    property Wx_BestSize_Width: integer read FWx_BestSize_Width write FWx_BestSize_Width default -1;
    property Wx_MinSize_Height: integer read FWx_MinSize_Height write FWx_MinSize_Height default -1;
    property Wx_MinSize_Width: integer read FWx_MinSize_Width write FWx_MinSize_Width default -1;
    property Wx_MaxSize_Height: integer read FWx_MaxSize_Height write FWx_MaxSize_Height default -1;
    property Wx_MaxSize_Width: integer read FWx_MaxSize_Width write FWx_MaxSize_Width default -1;
    property Wx_Floating_Height: integer read FWx_Floating_Height write FWx_Floating_Height default -1;
    property Wx_Floating_Width: integer read FWx_Floating_Width write FWx_Floating_Width default -1;
    property Wx_Floating_X_Pos: integer read FWx_Floating_X_Pos write FWx_Floating_X_Pos default -1;
    property Wx_Floating_Y_Pos: integer read FWx_Floating_Y_Pos write FWx_Floating_Y_Pos default -1;
    property Wx_Layer: integer read FWx_Layer write FWx_Layer default 0;
    property Wx_Row: integer read FWx_Row write FWx_Row default 0;
    property Wx_Position: integer read FWx_Position write FWx_Position default 0;

  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxStyledTextCtrl with wxWidgets as its
       default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TWxStyledTextCtrl]);
end;

{ Method to set variable and property values and create objects }
procedure TWxStyledTextCtrl.AutoInitialize;
begin
  FWx_EventList          := TStringList.Create;
  FWx_PropertyList       := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxStyledTextCtrl';
  FWx_Enabled            := True;
  FWx_Hidden             := False;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_IDValue            := -1;
  FWx_StretchFactor      := 0;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor         := self.color;
  defaultFGColor         := self.font.color;
  FWx_LoadFromFile       := TWxFileNameString.Create;
  FWx_Comments           := TStringList.Create;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxStyledTextCtrl.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_LoadFromFile.Destroy;
  FWx_Comments.Destroy;

end; { of AutoDestroy }

{ Write method for property Wx_ToolTip }
procedure TWxStyledTextCtrl.SetWx_ToolTip(Value: string);
begin
  FWx_ToolTip := Value;
end;

{ Override OnClick handler from TMemo,IWxComponentInterface }
procedure TWxStyledTextCtrl.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
  inherited Click;

     { Code to execute after click behavior
       of parent }

end;

{ Override OnKeyPress handler from TMemo,IWxComponentInterface }
procedure TWxStyledTextCtrl.KeyPress(var Key: char);
const
  TabKey   = char(VK_TAB);
  EnterKey = char(VK_RETURN);
begin
     { Key contains the character produced by the keypress.
       It can be tested or assigned a new value before the
       call to the inherited KeyPress method.  Setting Key
       to #0 before call to the inherited KeyPress method
       terminates any further processing of the character. }

  { Activate KeyPress behavior of parent }
  inherited KeyPress(Key);

  { Code to execute after KeyPress behavior of parent }

end;

constructor TWxStyledTextCtrl.Create(AOwner: TComponent);
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
  PopulateAuiGenericProperties(FWx_PropertyList);

  FWx_PropertyList.Add('Wx_EditStyle:Edit Style');
  FWx_PropertyList.Add('wxHSCROLL2:wxHSCROLL');
  FWx_PropertyList.Add('wxTE_PROCESS_ENTER:wxTE_PROCESS_ENTER');
  FWx_PropertyList.Add('wxTE_PROCESS_TAB:wxTE_PROCESS_TAB');
  FWx_PropertyList.Add('wxTE_PASSWORD:wxTE_PASSWORD');
  FWx_PropertyList.Add('wxTE_READONLY:wxTE_READONLY');
  FWx_PropertyList.Add('wxTE_RICH:wxTE_RICH');
  FWx_PropertyList.Add('wxTE_RICH2:wxTE_RICH2');
  FWx_PropertyList.Add('wxTE_AUTO_URL:wxTE_AUTO_URL');
  FWx_PropertyList.Add('wxTE_DONTWRAP:wxTE_DONTWRAP');
  FWx_PropertyList.Add('wxTE_LINEWRAP:wxTE_LINEWRAP');
  FWx_PropertyList.Add('wxTE_WORDWRAP:wxTE_WORDWRAP');
  FWx_PropertyList.Add('wxTE_CHARWRAP:wxTE_CHARWRAP');
  FWx_PropertyList.Add('wxTE_CAPITALIZE:wxTE_CAPITALIZE');
  FWx_PropertyList.Add('wxTE_NOHIDESEL:wxTE_NOHIDESEL');
  FWx_PropertyList.Add('wxTE_LEFT:wxTE_LEFT');
  FWx_PropertyList.Add('wxTE_CENTRE:wxTE_CENTRE');
  FWx_PropertyList.Add('wxTE_RIGHT:wxTE_RIGHT');

  FWx_PropertyList.add('Lines:Strings');
  FWx_PropertyList.add('Text:Text');
  FWx_PropertyList.Add('Wx_LoadFromFile:Load From File');
  FWx_PropertyList.add('Wx_LHSValue   : LHS Variable');
  FWx_PropertyList.add('Wx_RHSValue   : RHS Variable');

  FWx_EventList.add('EVT_TEXT_ENTER:OnEnter');
  FWx_EventList.add('EVT_TEXT:OnUpdated');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');
  FWx_EventList.add('EVT_TEXT_MAXLEN:OnMaxLen');
  FWx_EventList.add('EVT_TEXT_URL:OnClickUrl');

  FWx_EventList.add('EVT_STC_CALLTIP_CLICK:OnCallTipClick');
  FWx_EventList.add('EVT_STC_CHANGE:OnChange');
  FWx_EventList.add('EVT_STC_CHARADDED:OnCharAdded ');
  FWx_EventList.add('EVT_STC_DO_DROP:OnDoDrop');
  FWx_EventList.add('EVT_STC_DOUBLECLICK:OnDoubleClick');
  FWx_EventList.add('EVT_STC_DRAG_OVER:OnDragOver');
  FWx_EventList.add('EVT_STC_DWELLEND:OnDwellEnd');
  FWx_EventList.add('EVT_STC_DWELLSTART:OnDwellStart');
  FWx_EventList.add('EVT_STC_HOTSPOT_CLICK:OnHotspotClick ');
  FWx_EventList.add('EVT_STC_HOTSPOT_DCLICK:OnHotspotDClick ');
  FWx_EventList.add('EVT_STC_KEY:OnKey ');
  FWx_EventList.add('EVT_STC_MACRORECORD:OnMacroRecord ');
  FWx_EventList.add('EVT_STC_MARGINCLICK:OnMarginClick ');
  FWx_EventList.add('EVT_STC_MODIFIED:OnModified ');
  FWx_EventList.add('EVT_STC_NEEDSHOWN:OnNeedShown ');
  FWx_EventList.add('EVT_STC_PAINTED:OnPainted ');
  FWx_EventList.add('EVT_STC_ROMODIFYATTEMPT:OnROModifyAttempt ');
  FWx_EventList.add('EVT_STC_SAVEPOINTLEFT:OnSavePointLeft ');
  FWx_EventList.add('EVT_STC_SAVEPOINTREACHED:OnSavePointReached ');
  FWx_EventList.add('EVT_STC_START_DRAG:OnStartDrag ');
  FWx_EventList.add('EVT_STC_STYLENEEDED:OnStyleNeeded ');
  FWx_EventList.add('EVT_STC_UPDATEUI:OnSTCUpdateUI ');
  FWx_EventList.add('EVT_STC_URIDROPPED:OnURIDropped ');
  FWx_EventList.add('EVT_STC_USERLISTSELECTION:OnUserListSelection ');
  FWx_EventList.add('EVT_STC_ZOOM:OnZoom ');
  FWx_EventList.add('EVT_STC_AUTOCOMP_SELECTION:OnAutoCompSelection ');
end;

destructor TWxStyledTextCtrl.Destroy;
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


function TWxStyledTextCtrl.GenerateEnumControlIDs: string;
begin
  Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
end;

function TWxStyledTextCtrl.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;


function TWxStyledTextCtrl.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

    {if (XRCGEN) then
 begin
   if trim(EVT_TEXT_ENTER) <> '' then
    Result := Format('EVT_TEXT_ENTER(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TEXT_ENTER]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_TEXT) <> '' then
    Result := Result + #13 + Format('EVT_TEXT(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TEXT]) + '';

  if trim(EVT_TEXT_MAXLEN) <> '' then
    Result := Result + #13 + Format('EVT_TEXT_MAXLEN(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TEXT_MAXLEN]) + '';

  if trim(EVT_TEXT_URL) <> '' then
    Result := Result + #13 + Format('EVT_TEXT_URL(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TEXT_URL]) + '';

  if trim(EVT_STC_CALLTIP_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_STC_CALLTIP_CLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_CALLTIP_CLICK]) + '';

  if trim(EVT_STC_CHANGE) <> '' then
    Result := Result + #13 + Format('EVT_STC_CHANGE(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_CHANGE]) + '';

  if trim(EVT_STC_CHARADDED) <> '' then
    Result := Result + #13 + Format('EVT_STC_CHARADDED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_CHARADDED]) + '';

  if trim(EVT_STC_DO_DROP) <> '' then
    Result := Result + #13 + Format('EVT_STC_DO_DROP(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_DO_DROP]) + '';

  if trim(EVT_STC_DOUBLECLICK) <> '' then
    Result := Result + #13 + Format('EVT_STC_DOUBLECLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_DOUBLECLICK]) + '';

  if trim(EVT_STC_DRAG_OVER) <> '' then
    Result := Result + #13 + Format('EVT_STC_DRAG_OVER(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_DRAG_OVER]) + '';

  if trim(EVT_STC_DWELLEND) <> '' then
    Result := Result + #13 + Format('EVT_STC_DWELLEND(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_DWELLEND]) + '';

  if trim(EVT_STC_DWELLSTART) <> '' then
    Result := Result + #13 + Format('EVT_STC_DWELLSTART(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_DWELLSTART]) + '';

  if trim(EVT_STC_HOTSPOT_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_STC_HOTSPOT_CLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_HOTSPOT_CLICK]) + '';

  if trim(EVT_STC_HOTSPOT_DCLICK) <> '' then
    Result := Result + #13 + Format('EVT_STC_HOTSPOT_DCLICK(XRCID(%s("%s")), %s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_HOTSPOT_DCLICK]) + '';

  if trim(EVT_STC_KEY) <> '' then
    Result := Result + #13 + Format('EVT_STC_KEY(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_KEY]) + '';

  if trim(EVT_STC_MACRORECORD) <> '' then
    Result := Result + #13 + Format('EVT_STC_MACRORECORD(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_MACRORECORD]) + '';

  if trim(EVT_STC_MARGINCLICK) <> '' then
    Result := Result + #13 + Format('EVT_STC_MARGINCLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_MARGINCLICK]) + '';

  if trim(EVT_STC_MODIFIED) <> '' then
    Result := Result + #13 + Format('EVT_STC_MODIFIED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_MODIFIED]) + '';

  if trim(EVT_STC_NEEDSHOWN) <> '' then
    Result := Result + #13 + Format('EVT_STC_NEEDSHOWN(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_NEEDSHOWN]) + '';

  if trim(EVT_STC_PAINTED) <> '' then
    Result := Result + #13 + Format('EVT_STC_PAINTED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_PAINTED]) + '';

  if trim(EVT_STC_ROMODIFYATTEMPT) <> '' then
    Result := Result + #13 + Format('EVT_STC_ROMODIFYATTEMPT(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_ROMODIFYATTEMPT]) + '';

  if trim(EVT_STC_SAVEPOINTLEFT) <> '' then
    Result := Result + #13 + Format('EVT_STC_SAVEPOINTLEFT(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_SAVEPOINTLEFT]) + '';

  if trim(EVT_STC_SAVEPOINTREACHED) <> '' then
    Result := Result + #13 + Format('EVT_STC_SAVEPOINTREACHED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_SAVEPOINTREACHED]) + '';

  if trim(EVT_STC_START_DRAG) <> '' then
    Result := Result + #13 + Format('EVT_STC_START_DRAG(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_START_DRAG]) + '';

  if trim(EVT_STC_STYLENEEDED) <> '' then
    Result := Result + #13 + Format('EVT_STC_STYLENEEDED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_STYLENEEDED]) + '';

  if trim(EVT_STC_UPDATEUI) <> '' then
    Result := Result + #13 + Format('EVT_STC_UPDATEUI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_UPDATEUI]) + '';

  if trim(EVT_STC_URIDROPPED) <> '' then
    Result := Result + #13 + Format('EVT_STC_URIDROPPED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_URIDROPPED]) + '';

  if trim(EVT_STC_USERLISTSELECTION) <> '' then
    Result := Result + #13 + Format('EVT_STC_USERLISTSELECTION(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_USERLISTSELECTION]) + '';

  if trim(EVT_STC_ZOOM) <> '' then
    Result := Result + #13 + Format('EVT_STC_ZOOM(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_ZOOM]) + '';

  if trim(EVT_STC_AUTOCOMP_SELECTION) <> '' then
    Result := Result + #13 + Format('EVT_STC_AUTOCOMP_SELECTION(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_STC_AUTOCOMP_SELECTION]) + '';
   end
 else
 begin}
  if trim(EVT_TEXT_ENTER) <> '' then
    Result := Format('EVT_TEXT_ENTER(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TEXT_ENTER]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_TEXT) <> '' then
    Result := Result + #13 + Format('EVT_TEXT(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TEXT]) + '';

  if trim(EVT_TEXT_MAXLEN) <> '' then
    Result := Result + #13 + Format('EVT_TEXT_MAXLEN(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TEXT_MAXLEN]) + '';

  if trim(EVT_TEXT_URL) <> '' then
    Result := Result + #13 + Format('EVT_TEXT_URL(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TEXT_URL]) + '';

  if trim(EVT_STC_CALLTIP_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_STC_CALLTIP_CLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_CALLTIP_CLICK]) + '';

  if trim(EVT_STC_CHANGE) <> '' then
    Result := Result + #13 + Format('EVT_STC_CHANGE(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_CHANGE]) + '';

  if trim(EVT_STC_CHARADDED) <> '' then
    Result := Result + #13 + Format('EVT_STC_CHARADDED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_CHARADDED]) + '';

  if trim(EVT_STC_DO_DROP) <> '' then
    Result := Result + #13 + Format('EVT_STC_DO_DROP(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_DO_DROP]) + '';

  if trim(EVT_STC_DOUBLECLICK) <> '' then
    Result := Result + #13 + Format('EVT_STC_DOUBLECLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_DOUBLECLICK]) + '';

  if trim(EVT_STC_DRAG_OVER) <> '' then
    Result := Result + #13 + Format('EVT_STC_DRAG_OVER(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_DRAG_OVER]) + '';

  if trim(EVT_STC_DWELLEND) <> '' then
    Result := Result + #13 + Format('EVT_STC_DWELLEND(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_DWELLEND]) + '';

  if trim(EVT_STC_DWELLSTART) <> '' then
    Result := Result + #13 + Format('EVT_STC_DWELLSTART(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_DWELLSTART]) + '';

  if trim(EVT_STC_HOTSPOT_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_STC_HOTSPOT_CLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_HOTSPOT_CLICK]) + '';

  if trim(EVT_STC_HOTSPOT_DCLICK) <> '' then
    Result := Result + #13 + Format('EVT_STC_HOTSPOT_DCLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_HOTSPOT_DCLICK]) + '';

  if trim(EVT_STC_KEY) <> '' then
    Result := Result + #13 + Format('EVT_STC_KEY(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_KEY]) + '';

  if trim(EVT_STC_MACRORECORD) <> '' then
    Result := Result + #13 + Format('EVT_STC_MACRORECORD(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_MACRORECORD]) + '';

  if trim(EVT_STC_MARGINCLICK) <> '' then
    Result := Result + #13 + Format('EVT_STC_MARGINCLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_MARGINCLICK]) + '';

  if trim(EVT_STC_MODIFIED) <> '' then
    Result := Result + #13 + Format('EVT_STC_MODIFIED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_MODIFIED]) + '';

  if trim(EVT_STC_NEEDSHOWN) <> '' then
    Result := Result + #13 + Format('EVT_STC_NEEDSHOWN(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_NEEDSHOWN]) + '';

  if trim(EVT_STC_PAINTED) <> '' then
    Result := Result + #13 + Format('EVT_STC_PAINTED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_PAINTED]) + '';

  if trim(EVT_STC_ROMODIFYATTEMPT) <> '' then
    Result := Result + #13 + Format('EVT_STC_ROMODIFYATTEMPT(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_ROMODIFYATTEMPT]) + '';

  if trim(EVT_STC_SAVEPOINTLEFT) <> '' then
    Result := Result + #13 + Format('EVT_STC_SAVEPOINTLEFT(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_SAVEPOINTLEFT]) + '';

  if trim(EVT_STC_SAVEPOINTREACHED) <> '' then
    Result := Result + #13 + Format('EVT_STC_SAVEPOINTREACHED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_SAVEPOINTREACHED]) + '';

  if trim(EVT_STC_START_DRAG) <> '' then
    Result := Result + #13 + Format('EVT_STC_START_DRAG(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_START_DRAG]) + '';

  if trim(EVT_STC_STYLENEEDED) <> '' then
    Result := Result + #13 + Format('EVT_STC_STYLENEEDED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_STYLENEEDED]) + '';

  if trim(EVT_STC_UPDATEUI) <> '' then
    Result := Result + #13 + Format('EVT_STC_UPDATEUI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_UPDATEUI]) + '';

  if trim(EVT_STC_URIDROPPED) <> '' then
    Result := Result + #13 + Format('EVT_STC_URIDROPPED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_URIDROPPED]) + '';

  if trim(EVT_STC_USERLISTSELECTION) <> '' then
    Result := Result + #13 + Format('EVT_STC_USERLISTSELECTION(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_USERLISTSELECTION]) + '';

  if trim(EVT_STC_ZOOM) <> '' then
    Result := Result + #13 + Format('EVT_STC_ZOOM(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_ZOOM]) + '';

  if trim(EVT_STC_AUTOCOMP_SELECTION) <> '' then
    Result := Result + #13 + Format('EVT_STC_AUTOCOMP_SELECTION(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_STC_AUTOCOMP_SELECTION]) + '';
{end}

end;

function TWxStyledTextCtrl.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try //xrc unknown used so this is a little different than normal
	 Result.Add(IndentString + Format('<object class="unknown" name="%s"/>', [self.Name])); 
  {
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));
 
    if not(UseDefaultSize)then
      Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    if not(UseDefaultPos) then
      Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + Format('  <value>%s</value>', [XML_Label(self.Caption)]));
    Result.Add(IndentString + '</object>');
  }
  except
    Result.Free;
    raise;
  end;

end;

function TWxStyledTextCtrl.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment: string;
  i: integer;
begin
  Result := '';

    if FWx_PaneCaption = '' then
    FWx_PaneCaption := Self.Name;
  if FWx_PaneName = '' then
    FWx_PaneName := Self.Name + '_Pane';

  parentName := GetWxWidgetParent(self, Wx_AuiManaged);


  //strStyle := GetEditSpecificStyle(self.Wx_GeneralStyle, self.Wx_EditStyle);

  if trim(strStyle) <> '' then
    strStyle := ', ' + strStyle + ',  ' + GetCppString(Name)
  else
    strStyle := ', 0,  ' + GetCppString(Name);

  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, %s, %s%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue)
    , GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);

  
if (XRCGEN) then
 begin//generate xrc loading code
//xrc unknown used so we are inserting our control into the unknown container. (a panel)
Result := Result + #13 + Format('wxXmlResource::Get()->AttachUnknownControl(%s("%s"), (wxWindow*)%s, (wxWindow*)%s);', 
[StringFormat, self.Name, self.Name, parentName]);
end;
  
  SetWxFileName(self.FWx_LoadFromFile.FstrFileNameValue);
  if FWx_FiletoLoad <> '' then
  begin
    Result := Result + #13 + Format('%s->LoadFile("%s");',
      [self.Name, FWx_FiletoLoad]);
    self.Lines.LoadFromFile(FWx_FiletoLoad);

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

  if FWx_FiletoLoad = '' then
    begin
    for i := 0 to self.Lines.Count - 1 do
      if i = self.Lines.Count - 1 then
        Result :=
          Result + #13 + Format('%s->AppendText(%s);',
          [self.Name, GetCppString(self.Lines[i])])
      else
        Result := Result + #13 + Format('%s->AppendText(%s);',
          [self.Name, GetCppString(self.Lines[i])]);

        Result := Result + #13 + self.Name + '->SetFocus();';
    end;

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
  begin
    if (Wx_AuiManaged and FormHasAuiManager(self)) and not (self.Parent is TWxSizerPanel) then
    begin
      if HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) then
      begin
        Self.Wx_Aui_Pane_Style := Self.Wx_Aui_Pane_Style + [ToolbarPane]; //always make sure we are a toolbar
        Self.Wx_Layer := 10;
      end;

      if not HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) then
      begin
        if (self.Parent.ClassName = 'TWxPanel') then
          if not (self.Parent.Parent is TForm) then
            Result := Result + #13 + Format('%s->Reparent(this);', [parentName]);
      end;

      if (self.Parent is TWxAuiToolBar) then
        Result := Result + #13 + Format('%s->AddControl(%s);',
          [self.Parent.Name, self.Name])
      else
        Result := Result + #13 + Format('%s->AddPane(%s, wxAuiPaneInfo()%s%s%s%s%s%s%s%s%s%s%s%s);',
          [GetAuiManagerName(self), self.Name,
          GetAuiPaneName(Self.Wx_PaneName),
            GetAuiPaneCaption(Self.Wx_PaneCaption),
            GetAuiDockDirection(Self.Wx_Aui_Dock_Direction),
            GetAuiDockableDirections(self.Wx_Aui_Dockable_Direction),
            GetAui_Pane_Style(Self.Wx_Aui_Pane_Style),
            GetAui_Pane_Buttons(Self.Wx_Aui_Pane_Buttons),
            GetAuiRow(Self.Wx_Row),
            GetAuiPosition(Self.Wx_Position),
            GetAuiLayer(Self.Wx_Layer),
            GetAuiPaneBestSize(Self.Wx_BestSize_Width, Self.Wx_BestSize_Height),
            GetAuiPaneMinSize(Self.Wx_MinSize_Width, Self.Wx_MinSize_Height),
            GetAuiPaneMaxSize(Self.Wx_MaxSize_Width, Self.Wx_MaxSize_Height)]);

    end
    else
    begin
  if (self.Parent is TWxSizerPanel) then
  begin
    strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
    Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);
  end;

      if (self.Parent is TWxAuiNotebookPage) then
      begin
        //        strParentLabel := TWxAuiNoteBookPage(Self.Parent).Caption;
        Result := Result + #13 + Format('%s->AddPage(%s, %s);',
          //          [self.Parent.Parent.Name, self.Name, GetCppString(strParentLabel)]);
          [self.Parent.Parent.Name, self.Name, GetCppString(TWxAuiNoteBookPage(Self.Parent).Caption)]);
      end;

      if (self.Parent is TWxAuiToolBar) then
        Result := Result + #13 + Format('%s->AddControl(%s);',
          [self.Parent.Name, self.Name]);
    end;
  end;

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

  if wxHSCROLL in self.Wx_GeneralStyle then
    self.ScrollBars := ssHorizontal;

  if wxVSCROLL in self.Wx_GeneralStyle then
    self.ScrollBars := ssVertical;

  if not (wxHSCROLL in self.Wx_GeneralStyle) and not
    (wxVSCROLL in self.Wx_GeneralStyle) then
    self.ScrollBars := ssNone;

  if (wxHSCROLL in self.Wx_GeneralStyle) and (wxVSCROLL in self.Wx_GeneralStyle) then
    self.ScrollBars := ssBoth;

end;

function TWxStyledTextCtrl.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxStyledTextCtrl.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/stc/stc.h>';
end;

function TWxStyledTextCtrl.GenerateImageInclude: string;
begin

end;

function TWxStyledTextCtrl.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxStyledTextCtrl.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxStyledTextCtrl.GetIDValue: integer;
begin
  Result := wx_IDValue;
end;

function TWxStyledTextCtrl.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_TEXT' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;
  if EventName = 'EVT_TEXT_MAXLEN' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;
  if EventName = 'EVT_TEXT_URL' then
  begin
    Result := 'wxTextUrlEvent& event';
    exit;
  end;
  if EventName = 'EVT_TEXT_ENTER' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;

  if EventName = 'EVT_STC_CALLTIP_CLICK' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_CHANGE' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_CHARADDED' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_DO_DROP' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_DOUBLECLICK' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;

  if EventName = 'EVT_STC_DRAG_OVER' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_DWELLEND' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_DWELLSTART' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_HOTSPOT_CLICK' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_HOTSPOT_DCLICK' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;

  if EventName = 'EVT_STC_KEY' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_MACRORECORD' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_MARGINCLICK' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_MODIFIED' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_NEEDSHOWN' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_PAINTED' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_ROMODIFYATTEMPT' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_SAVEPOINTLEFT' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_SAVEPOINTREACHED' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_START_DRAG' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_STYLENEEDED' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_UPDATEUI' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_URIDROPPED' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_USERLISTSELECTION' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_ZOOM' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;
  if EventName = 'EVT_STC_AUTOCOMP_SELECTION' then
  begin
    Result := 'wxStyledTextEvent& event';
    exit;
  end;


end;

function TWxStyledTextCtrl.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxStyledTextCtrl.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxStyledTextCtrl.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxStyledTextCtrl.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxStyledTextCtrl.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxStyledTextCtrl.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxStyledTextCtrl.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxStyledTextCtrl.GetWxClassName: string;
begin
  if wx_Class = '' then
    wx_Class := 'wxStyledTextCtrl';
  Result := wx_Class;
end;

procedure TWxStyledTextCtrl.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }
  self.ScrollBars := ssVertical;
  self.FWx_LoadFromFile.FstrFileNameValue := FWx_FiletoLoad;

end;

procedure TWxStyledTextCtrl.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxStyledTextCtrl.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxStyledTextCtrl.SetIDValue(IDValue: integer);
begin
  Wx_IDValue := IDValue;
end;

procedure TWxStyledTextCtrl.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxStyledTextCtrl.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxStyledTextCtrl.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxStyledTextCtrl.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxStyledTextCtrl.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxStyledTextCtrl.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxStyledTextCtrl.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxStyledTextCtrl.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxStyledTextCtrl.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxStyledTextCtrl.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

procedure TWxStyledTextCtrl.SetWxFileName(wxFileName: string);
begin
  FWx_FiletoLoad := trim(wxFileName);
  strSearchReplace(FWx_FiletoLoad, '\', '/', [srAll]);
  Wx_LoadFromFile.FstrFileNameValue := FWx_FiletoLoad;
end;

function TWxStyledTextCtrl.GetLHSVariableAssignment:String;
var
    nPos:Integer;
begin
    Result:='';
    if trim(Wx_LHSValue) = '' then
        exit;
        nPos := pos('|',Wx_LHSValue);
    if (UpperCase(copy(Wx_LHSValue,0,2)) = 'F:')  and (nPos <> -1) then
    begin
        Result:= Format('%s = %s(%s->GetValue());',[copy(Wx_LHSValue,3,nPos-3),copy(Wx_LHSValue,nPos+1,length(Wx_LHSValue)),self.Name])
    end
    else
        Result:= Format('%s = %s->GetValue();',[Wx_LHSValue,self.Name]);
end;

function TWxStyledTextCtrl.GetRHSVariableAssignment:String;
begin
    Result:='';
    if trim(Wx_RHSValue) = '' then
        exit;
    Result:= Format('%s->SetValue(%s);',[self.Name,Wx_RHSValue]);
end;


end.
