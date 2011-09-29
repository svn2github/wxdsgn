 { ****************************************************************** }
 {                                                                    }
 { $Id: wxlistctrl.pas 936 2007-05-15 03:47:39Z gururamnath $   }
 {                                                                    }
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

unit Wxlistctrl;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ComCtrls, WxUtils, ExtCtrls, WxAuiToolBar, WxSizerPanel, WxAuiNotebookPage, UValidator;

type
  TWxListCtrl = class(TListView, IWxComponentInterface, IWxValidatorInterface)
  private
    { Private fields of TWxListCtrl }
    { Storage for property EVT_LIST_BEGIN_DRAG }
    FEVT_LIST_BEGIN_DRAG: string;
    { Storage for property EVT_LIST_BEGIN_LABEL_EDIT }
    FEVT_LIST_BEGIN_LABEL_EDIT: string;
    { Storage for property EVT_LIST_BEGIN_RDRAG }
    FEVT_LIST_BEGIN_RDRAG: string;
    { Storage for property EVT_LIST_CACHE_HINT }
    FEVT_LIST_CACHE_HINT: string;
    { Storage for property EVT_LIST_COL_BEGIN_DRAG }
    FEVT_LIST_COL_BEGIN_DRAG: string;
    { Storage for property EVT_LIST_COL_CLICK }
    FEVT_LIST_COL_CLICK: string;
    { Storage for property EVT_LIST_COL_DRAGGING }
    FEVT_LIST_COL_DRAGGING: string;
    { Storage for property EVT_LIST_COL_END_DRAG }
    FEVT_LIST_COL_END_DRAG: string;
    { Storage for property EVT_LIST_COL_RIGHT_CLICK }
    FEVT_LIST_COL_RIGHT_CLICK: string;
    { Storage for property EVT_LIST_DELETE_ALL_ITEMS }
    FEVT_LIST_DELETE_ALL_ITEMS: string;
    { Storage for property EVT_LIST_DELETE_ITEM }
    FEVT_LIST_DELETE_ITEM: string;
    { Storage for property EVT_LIST_END_LABEL_EDIT }
    FEVT_LIST_END_LABEL_EDIT: string;
    { Storage for property EVT_LIST_INSERT_ITEM }
    FEVT_LIST_INSERT_ITEM: string;
    { Storage for property EVT_LIST_ITEM_ACTIVATED }
    FEVT_LIST_ITEM_ACTIVATED: string;
    { Storage for property EVT_LIST_ITEM_DESELECTED }
    FEVT_LIST_ITEM_DESELECTED: string;
    { Storage for property EVT_LIST_ITEM_FOCUSED }
    FEVT_LIST_ITEM_FOCUSED: string;
    { Storage for property EVT_LIST_ITEM_MIDDLE_CLICK }
    FEVT_LIST_ITEM_MIDDLE_CLICK: string;
    { Storage for property EVT_LIST_ITEM_RIGHT_CLICK }
    FEVT_LIST_ITEM_RIGHT_CLICK: string;
    { Storage for property EVT_LIST_ITEM_SELECTED }
    FEVT_LIST_ITEM_SELECTED: string;
    { Storage for property EVT_LIST_KEY_DOWN }
    FEVT_LIST_KEY_DOWN: string;
    { Storage for property EVT_UPDATE_UI }
    FEVT_UPDATE_UI: string;
    { Storage for property Wx_BGColor }
    FWx_BGColor: TColor;
    { Storage for property Wx_Border }
    FWx_Border: integer;
    { Storage for property Wx_Class }
    FWx_Class: string;
    { Storage for property Wx_ControlOrientation }
    FWx_ControlOrientation: TwxControlOrientation;
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
    { Storage for property Wx_ListviewStyle }
    FWx_ListviewStyle: TWxLVStyleSet;
    { Storage for property Wx_ListviewView }
    FWx_ListviewView: TWxLvView;
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
    FWx_Comments: TStrings;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

    FWx_Validator: string;
    FWx_ProxyValidatorString : TWxValidatorString;

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

    { Private methods of TWxListCtrl }
    { Method to set variable and property values and create objects }
    procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
    procedure AutoDestroy;
    { Write method for property Wx_ListviewStyle }
    procedure SetWx_ListviewStyle(Value: TWxLVStyleSet);
    { Write method for property Wx_ListviewView }
    procedure SetWx_ListviewView(Value: TWxLvView);

  protected
    { Protected fields of TWxListCtrl }

    { Protected methods of TWxListCtrl }
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;

  public
    { Public fields and properties of TWxListCtrl }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxListCtrl }
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
    function GetFGColor: string;
    procedure SetFGColor(strValue: string);

    function GetValidator:String;
    procedure SetValidator(value:String);
    function GetValidatorString:TWxValidatorString;
    procedure SetValidatorString(Value:TWxValidatorString);

    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

  published
    { Published properties of TWxListCtrl }
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property EVT_LIST_ITEM_ACTIVATED: string
      Read FEVT_LIST_ITEM_ACTIVATED Write FEVT_LIST_ITEM_ACTIVATED;
    property EVT_LIST_BEGIN_DRAG: string Read FEVT_LIST_BEGIN_DRAG
      Write FEVT_LIST_BEGIN_DRAG;
    property EVT_LIST_BEGIN_LABEL_EDIT: string
      Read FEVT_LIST_BEGIN_LABEL_EDIT Write FEVT_LIST_BEGIN_LABEL_EDIT;
    property EVT_LIST_BEGIN_RDRAG: string Read FEVT_LIST_BEGIN_RDRAG
      Write FEVT_LIST_BEGIN_RDRAG;
    property EVT_LIST_CACHE_HINT: string Read FEVT_LIST_CACHE_HINT
      Write FEVT_LIST_CACHE_HINT;
    property EVT_LIST_COL_BEGIN_DRAG: string
      Read FEVT_LIST_COL_BEGIN_DRAG Write FEVT_LIST_COL_BEGIN_DRAG;
    property EVT_LIST_COL_CLICK: string Read FEVT_LIST_COL_CLICK
      Write FEVT_LIST_COL_CLICK;
    property EVT_LIST_COL_DRAGGING: string
      Read FEVT_LIST_COL_DRAGGING Write FEVT_LIST_COL_DRAGGING;
    property EVT_LIST_COL_END_DRAG: string
      Read FEVT_LIST_COL_END_DRAG Write FEVT_LIST_COL_END_DRAG;
    property EVT_LIST_COL_RIGHT_CLICK: string
      Read FEVT_LIST_COL_RIGHT_CLICK Write FEVT_LIST_COL_RIGHT_CLICK;
    property EVT_LIST_DELETE_ALL_ITEMS: string
      Read FEVT_LIST_DELETE_ALL_ITEMS Write FEVT_LIST_DELETE_ALL_ITEMS;
    property EVT_LIST_DELETE_ITEM: string Read FEVT_LIST_DELETE_ITEM
      Write FEVT_LIST_DELETE_ITEM;
    property EVT_LIST_END_LABEL_EDIT: string
      Read FEVT_LIST_END_LABEL_EDIT Write FEVT_LIST_END_LABEL_EDIT;
    property EVT_LIST_INSERT_ITEM: string Read FEVT_LIST_INSERT_ITEM
      Write FEVT_LIST_INSERT_ITEM;
    property EVT_LIST_ITEM_DESELECTED: string
      Read FEVT_LIST_ITEM_DESELECTED Write FEVT_LIST_ITEM_DESELECTED;
    property EVT_LIST_ITEM_FOCUSED: string
      Read FEVT_LIST_ITEM_FOCUSED Write FEVT_LIST_ITEM_FOCUSED;
    property EVT_LIST_ITEM_MIDDLE_CLICK: string
      Read FEVT_LIST_ITEM_MIDDLE_CLICK Write FEVT_LIST_ITEM_MIDDLE_CLICK;
    property EVT_LIST_ITEM_RIGHT_CLICK: string
      Read FEVT_LIST_ITEM_RIGHT_CLICK Write FEVT_LIST_ITEM_RIGHT_CLICK;
    property EVT_LIST_ITEM_SELECTED: string
      Read FEVT_LIST_ITEM_SELECTED Write FEVT_LIST_ITEM_SELECTED;
    property EVT_LIST_KEY_DOWN: string Read FEVT_LIST_KEY_DOWN Write FEVT_LIST_KEY_DOWN;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TwxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden default False;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: integer Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_ListviewStyle: TWxLVStyleSet Read FWx_ListviewStyle Write SetWx_ListviewStyle;
    property Wx_ListviewView: TWxLvView Read FWx_ListviewView Write SetWx_ListviewView;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;
    
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;
    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;

    property Wx_Validator: string Read FWx_Validator Write FWx_Validator;
    property Wx_ProxyValidatorString : TWxValidatorString Read GetValidatorString Write SetValidatorString;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
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
     { Register TWxListCtrl with wxWidgets as its
       default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TWxListCtrl]);
end;

{ Method to set variable and property values and create objects }
procedure TWxListCtrl.AutoInitialize;
begin
  ViewStyle              := vsReport;
  FWx_ListviewView       := wxLC_REPORT;
  FWx_ListviewStyle      := [];
  FWx_EventList          := TStringList.Create;
  FWx_PropertyList       := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxListCtrl';
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
  FWx_Comments           := TStringList.Create;
  FWx_ProxyValidatorString := TwxValidatorString.Create(self);

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxListCtrl.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_Comments.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_ProxyValidatorString.Destroy;

end; { of AutoDestroy }

{ Write method for property Wx_ListviewStyle }
procedure TWxListCtrl.SetWx_ListviewStyle(Value: TWxLVStyleSet);
begin
  //Save the value
  FWx_ListviewStyle := Value;

  //Apply some styles that we said we would include
  if wxLC_NO_HEADER in FWx_ListviewStyle then
    self.ShowColumnHeaders := false
  else
    self.ShowColumnHeaders := true;
end;

{ Write method for property Wx_ListviewView }
procedure TWxListCtrl.SetWx_ListviewView(Value: TWxLvView);
begin
  FWx_ListviewView := Value;

  //Apply the view to our control
  case FWx_ListviewView of
    wxLC_LIST:                 ViewStyle := vsList;
    wxLC_REPORT, wxLC_VIRTUAL: ViewStyle := vsReport;
    wxLC_ICON:                 ViewStyle := vsIcon;
    wxLC_SMALL_ICON:           ViewStyle := vsSmallIcon;
  end;
end;

{ Override OnKeyPress handler from TListView,IWxComponentInterface }
procedure TWxListCtrl.KeyPress(var Key: char);
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

constructor TWxListCtrl.Create(AOwner: TComponent);
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

  FWx_PropertyList.add('Wx_ListviewView:Listview View');
  FWx_PropertyList.add('Wx_ListviewStyle:Listview Style');
  FWx_PropertyList.add('wxLC_ALIGN_TOP:wxLC_ALIGN_TOP');
  FWx_PropertyList.add('wxLC_ALIGN_LEFT:wxLC_ALIGN_LEFT');
  FWx_PropertyList.add('wxLC_AUTOARRANGE:wxLC_AUTOARRANGE');
  FWx_PropertyList.add('wxLC_EDIT_LABELS:wxLC_EDIT_LABELS');
  FWx_PropertyList.add('wxLC_NO_HEADER:wxLC_NO_HEADER');
  FWx_PropertyList.add('wxLC_NO_SORT_HEADER:wxLC_NO_SORT_HEADER');
  FWx_PropertyList.add('wxLC_SINGLE_SEL:wxLC_SINGLE_SEL');
  FWx_PropertyList.add('wxLC_SORT_ASCENDING:wxLC_SORT_ASCENDING');
  FWx_PropertyList.add('wxLC_SORT_DESCENDING:wxLC_SORT_DESCENDING');
  FWx_PropertyList.add('wxLC_HRULES:wxLC_HRULES');
  FWx_PropertyList.add('wxLC_VRULES:wxLC_VRULES');

  FWx_PropertyList.add('Items:Items');
  FWx_PropertyList.add('Text:Text');
  FWx_PropertyList.add('Columns:Columns');

  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');
  FWx_EventList.add('EVT_LIST_ITEM_SELECTED:OnSelected');
  FWx_EventList.add('EVT_LIST_ITEM_DESELECTED:OnDeselected');
  FWx_EventList.add('EVT_LIST_BEGIN_DRAG:OnBeginDrag');
  FWx_EventList.add('EVT_LIST_BEGIN_RDRAG:OnBeginRDrag');
  FWx_EventList.add('EVT_LIST_BEGIN_LABEL_EDIT:OnBeginLabelEdit');
  FWx_EventList.add('EVT_LIST_END_LABEL_EDIT:OnEndLabelEdit');
  FWx_EventList.add('EVT_LIST_DELETE_ITEM:OnDeleteItem');
  FWx_EventList.add('EVT_LIST_DELETE_ALL_ITEMS:OnDeleteAllItems');
  FWx_EventList.add('EVT_LIST_ITEM_ACTIVATED:OnItemActivated');
  FWx_EventList.add('EVT_LIST_ITEM_FOCUSED:OnItemFocused');
  FWx_EventList.add('EVT_LIST_ITEM_MIDDLE_CLICK:OnMiddleClick');
  FWx_EventList.add('EVT_LIST_ITEM_RIGHT_CLICK:OnRightClick');
  FWx_EventList.add('EVT_LIST_KEY_DOWN:OnKeyDown');
  FWx_EventList.add('EVT_LIST_INSERT_ITEM:OnInsertItem');
  FWx_EventList.add('EVT_LIST_COL_CLICK:OnColLeftClick');
  FWx_EventList.add('EVT_LIST_COL_RIGHT_CLICK:OnColRightClick');
  FWx_EventList.add('EVT_LIST_COL_BEGIN_DRAG:OnColBeginDrag');
  FWx_EventList.add('EVT_LIST_COL_DRAGGING:OnColDragging');
  FWx_EventList.add('EVT_LIST_COL_END_DRAG:OnColEndDrag');
  FWx_EventList.add('EVT_LIST_CACHE_HINT:OnCacheHint');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');
end;

destructor TWxListCtrl.Destroy;
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


function TWxListCtrl.GenerateEnumControlIDs: string;
begin
  Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
end;

function TWxListCtrl.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxListCtrl.GenerateEventTableEntries(CurrClassName: string): string;
begin

  Result := '';

if (XRCGEN) then
 begin
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_LIST_ITEM_SELECTED) <> '' then
    Result := Result + #13 + Format('EVT_LIST_ITEM_SELECTED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_ITEM_SELECTED]) + '';


  if trim(EVT_LIST_ITEM_DESELECTED) <> '' then
    Result := Result + #13 + Format('EVT_LIST_ITEM_DESELECTED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_ITEM_DESELECTED]) + '';

  if trim(EVT_LIST_BEGIN_DRAG) <> '' then
    Result := Result + #13 + Format('EVT_LIST_BEGIN_DRAG(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_BEGIN_DRAG]) + '';

  if trim(EVT_LIST_BEGIN_RDRAG) <> '' then
    Result := Result + #13 + Format('EVT_LIST_BEGIN_RDRAG(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_BEGIN_RDRAG]) + '';

  if trim(EVT_LIST_BEGIN_LABEL_EDIT) <> '' then
    Result := Result + #13 + Format('EVT_LIST_BEGIN_LABEL_EDIT(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_BEGIN_LABEL_EDIT]) + '';

  if trim(EVT_LIST_END_LABEL_EDIT) <> '' then
    Result := Result + #13 + Format('EVT_LIST_END_LABEL_EDIT(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_END_LABEL_EDIT]) + '';

  if trim(EVT_LIST_DELETE_ITEM) <> '' then
    Result := Result + #13 + Format('EVT_LIST_DELETE_ITEM(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_DELETE_ITEM]) + '';

  if trim(EVT_LIST_DELETE_ALL_ITEMS) <> '' then
    Result := Result + #13 + Format('EVT_LIST_DELETE_ALL_ITEMS(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_DELETE_ALL_ITEMS]) + '';

  if trim(EVT_LIST_ITEM_ACTIVATED) <> '' then
    Result := Result + #13 + Format('EVT_LIST_ITEM_ACTIVATED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_ITEM_ACTIVATED]) + '';


  if trim(EVT_LIST_ITEM_FOCUSED) <> '' then
    Result := Result + #13 + Format('EVT_LIST_ITEM_FOCUSED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_ITEM_FOCUSED]) + '';

  if trim(EVT_LIST_ITEM_MIDDLE_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_LIST_ITEM_MIDDLE_CLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_ITEM_MIDDLE_CLICK]) + '';


  if trim(EVT_LIST_ITEM_RIGHT_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_LIST_ITEM_RIGHT_CLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_ITEM_RIGHT_CLICK]) + '';

  if trim(EVT_LIST_KEY_DOWN) <> '' then
    Result := Result + #13 + Format('EVT_LIST_KEY_DOWN(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_KEY_DOWN]) + '';


  if trim(EVT_LIST_INSERT_ITEM) <> '' then
    Result := Result + #13 + Format('EVT_LIST_INSERT_ITEM(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_INSERT_ITEM]) + '';

  if trim(EVT_LIST_COL_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_LIST_COL_CLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_COL_CLICK]) + '';

  if trim(EVT_LIST_COL_RIGHT_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_LIST_COL_RIGHT_CLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_COL_RIGHT_CLICK]) + '';

  if trim(EVT_LIST_COL_BEGIN_DRAG) <> '' then
    Result := Result + #13 + Format('EVT_LIST_COL_BEGIN_DRAG(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_COL_BEGIN_DRAG]) + '';

  if trim(EVT_LIST_COL_DRAGGING) <> '' then
    Result := Result + #13 + Format('EVT_LIST_COL_DRAGGING(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_COL_DRAGGING]) + '';

  if trim(EVT_LIST_COL_END_DRAG) <> '' then
    Result := Result + #13 + Format('EVT_LIST_COL_END_DRAG(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_COL_END_DRAG]) + '';

  if trim(EVT_LIST_CACHE_HINT) <> '' then
    Result := Result + #13 + Format('EVT_LIST_CACHE_HINT(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LIST_CACHE_HINT]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
 end
 else
 begin
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_LIST_ITEM_SELECTED) <> '' then
    Result := Result + #13 + Format('EVT_LIST_ITEM_SELECTED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_ITEM_SELECTED]) + '';


  if trim(EVT_LIST_ITEM_DESELECTED) <> '' then
    Result := Result + #13 + Format('EVT_LIST_ITEM_DESELECTED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_ITEM_DESELECTED]) + '';

  if trim(EVT_LIST_BEGIN_DRAG) <> '' then
    Result := Result + #13 + Format('EVT_LIST_BEGIN_DRAG(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_BEGIN_DRAG]) + '';

  if trim(EVT_LIST_BEGIN_RDRAG) <> '' then
    Result := Result + #13 + Format('EVT_LIST_BEGIN_RDRAG(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_BEGIN_RDRAG]) + '';

  if trim(EVT_LIST_BEGIN_LABEL_EDIT) <> '' then
    Result := Result + #13 + Format('EVT_LIST_BEGIN_LABEL_EDIT(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_BEGIN_LABEL_EDIT]) + '';

  if trim(EVT_LIST_END_LABEL_EDIT) <> '' then
    Result := Result + #13 + Format('EVT_LIST_END_LABEL_EDIT(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_END_LABEL_EDIT]) + '';

  if trim(EVT_LIST_DELETE_ITEM) <> '' then
    Result := Result + #13 + Format('EVT_LIST_DELETE_ITEM(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_DELETE_ITEM]) + '';

  if trim(EVT_LIST_DELETE_ALL_ITEMS) <> '' then
    Result := Result + #13 + Format('EVT_LIST_DELETE_ALL_ITEMS(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_DELETE_ALL_ITEMS]) + '';

  if trim(EVT_LIST_ITEM_ACTIVATED) <> '' then
    Result := Result + #13 + Format('EVT_LIST_ITEM_ACTIVATED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_ITEM_ACTIVATED]) + '';


  if trim(EVT_LIST_ITEM_FOCUSED) <> '' then
    Result := Result + #13 + Format('EVT_LIST_ITEM_FOCUSED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_ITEM_FOCUSED]) + '';

  if trim(EVT_LIST_ITEM_MIDDLE_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_LIST_ITEM_MIDDLE_CLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_ITEM_MIDDLE_CLICK]) + '';


  if trim(EVT_LIST_ITEM_RIGHT_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_LIST_ITEM_RIGHT_CLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_ITEM_RIGHT_CLICK]) + '';

  if trim(EVT_LIST_KEY_DOWN) <> '' then
    Result := Result + #13 + Format('EVT_LIST_KEY_DOWN(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_KEY_DOWN]) + '';


  if trim(EVT_LIST_INSERT_ITEM) <> '' then
    Result := Result + #13 + Format('EVT_LIST_INSERT_ITEM(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_INSERT_ITEM]) + '';

  if trim(EVT_LIST_COL_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_LIST_COL_CLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_COL_CLICK]) + '';

  if trim(EVT_LIST_COL_RIGHT_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_LIST_COL_RIGHT_CLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_COL_RIGHT_CLICK]) + '';

  if trim(EVT_LIST_COL_BEGIN_DRAG) <> '' then
    Result := Result + #13 + Format('EVT_LIST_COL_BEGIN_DRAG(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_COL_BEGIN_DRAG]) + '';

  if trim(EVT_LIST_COL_DRAGGING) <> '' then
    Result := Result + #13 + Format('EVT_LIST_COL_DRAGGING(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_COL_DRAGGING]) + '';

  if trim(EVT_LIST_COL_END_DRAG) <> '' then
    Result := Result + #13 + Format('EVT_LIST_COL_END_DRAG(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_COL_END_DRAG]) + '';

  if trim(EVT_LIST_CACHE_HINT) <> '' then
    Result := Result + #13 + Format('EVT_LIST_CACHE_HINT(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LIST_CACHE_HINT]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
 end;

end;

function TWxListCtrl.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;
  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));

    if not(UseDefaultSize)then
      Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    if not(UseDefaultPos) then
      Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

	  Result.Add(IndentString + Format('  <style>%s</style>', 
      [GetListViewSpecificStyle(Wx_GeneralStyle, Wx_ListviewStyle, FWx_ListviewView)]));
    Result.Add(IndentString + '</object>');
  except
    Result.Free;
    raise;
  end;

end;

function TWxListCtrl.GenerateGUIControlCreation: string;
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

  strStyle := GetListViewSpecificStyle(Wx_GeneralStyle, Wx_ListviewStyle, FWx_ListviewView);

  if trim(Wx_ProxyValidatorString.strValidatorValue) <> '' then
  begin
    if trim(strStyle) <> '' then
      strStyle := strStyle + ', ' + Wx_ProxyValidatorString.strValidatorValue
    else
      strStyle := ', 0, ' + Wx_ProxyValidatorString.strValidatorValue;

    strStyle := strStyle + ', ' + GetCppString(Name);

  end
  else if trim(strStyle) <> '' then
    strStyle := strStyle + ', wxDefaultValidator, ' + GetCppString(Name)
  else
    strStyle := ', 0, wxDefaultValidator, ' + GetCppString(Name);
if (XRCGEN) then
 begin
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
    [self.Name, parentName, StringFormat, self.Name, self.wx_Class]); 
 end
 else
 begin
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, %s, %s, %s);',
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
  for i := 0 to self.columns.Count - 1 do
    Result := Result + #13 + Format('%s->InsertColumn(%d, %s, %s, %d);',
      [self.Name, i, GetCppString(self.columns[i].Caption), AlignmentToStr(
      columns[i].Alignment), self.columns[i].Width]);

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
    Result := Result + #13 + Format('%s->Add(%s, %d, %s, %d);',
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


end;

function TWxListCtrl.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxListCtrl.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/listctrl.h>';
end;

function TWxListCtrl.GenerateImageInclude: string;
begin

end;

function TWxListCtrl.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxListCtrl.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxListCtrl.GetIDValue: integer;
begin
  Result := wx_IDValue;
end;

function TWxListCtrl.GetParameterFromEventName(EventName: string): string;
begin
  Result := 'void';
  if EventName = 'EVT_LIST_ITEM_SELECTED' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_ITEM_DESELECTED' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_BEGIN_DRAG' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_BEGIN_RDRAG' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_BEGIN_LABEL_EDIT' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_END_LABEL_EDIT' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_DELETE_ITEM' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_DELETE_ALL_ITEMS' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_ITEM_ACTIVATED' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_ITEM_FOCUSED' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_ITEM_MIDDLE_CLICK' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_ITEM_RIGHT_CLICK' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_KEY_DOWN' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_INSERT_ITEM' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_COL_CLICK' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_COL_RIGHT_CLICK' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_COL_BEGIN_DRAG' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_COL_DRAGGING' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_COL_END_DRAG' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
  if EventName = 'EVT_LIST_CACHE_HINT' then
  begin
    Result := 'wxListEvent& event';
    exit;
  end;
 if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxListCtrl.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxListCtrl.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxListCtrl.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxListCtrl.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxListCtrl.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxListCtrl.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxListCtrl.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxListCtrl.GetWxClassName: string;
begin
  if wx_Class = '' then
    wx_Class := 'wxListCtrl';
  Result := wx_Class;
end;

procedure TWxListCtrl.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxListCtrl.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxListCtrl.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxListCtrl.SetIDValue(IDValue: integer);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxListCtrl.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxListCtrl.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxListCtrl.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxListCtrl.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxListCtrl.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxListCtrl.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxListCtrl.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxListCtrl.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxListCtrl.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxListCtrl.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxListCtrl.GetValidatorString:TWxValidatorString;
begin
  Result := FWx_ProxyValidatorString;
  Result.FstrValidatorValue := Wx_Validator;
end;

procedure TWxListCtrl.SetValidatorString(Value:TWxValidatorString);
begin
  FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
  Wx_Validator := Value.FstrValidatorValue;
end;

function TWxListCtrl.GetValidator:String;
begin
  Result := Wx_Validator;
end;

procedure TWxListCtrl.SetValidator(value:String);
begin
  Wx_Validator := value;
end;

end.
