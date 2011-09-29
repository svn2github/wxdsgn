 { ****************************************************************** }
 {                                                                    }
{ $Id: wxtreectrl.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
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


unit WxTreeCtrl;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ComCtrls, WxUtils, ExtCtrls, WxAuiToolBar, WxSizerPanel, WxAuiNotebookPage, UValidator;

type
  TWxTreeCtrl = class(TTreeView, IWxComponentInterface, IWxValidatorInterface)
  private
    { Private fields of TWxTreeCtrl }
    FEVT_TREE_BEGIN_DRAG: string;
    FEVT_TREE_BEGIN_RDRAG: string;
    FEVT_TREE_END_DRAG: string;
    FEVT_TREE_BEGIN_LABEL_EDIT: string;
    FEVT_TREE_END_LABEL_EDIT: string;
    FEVT_TREE_DELETE_ITEM: string;
    FEVT_TREE_GET_INFO: string;
    FEVT_TREE_SET_INFO: string;
    FEVT_TREE_ITEM_ACTIVATED: string;
    FEVT_TREE_ITEM_COLLAPSED: string;
    FEVT_TREE_ITEM_COLLAPSING: string;
    FEVT_TREE_ITEM_EXPANDED: string;
    FEVT_TREE_ITEM_EXPANDING: string;
    FEVT_TREE_ITEM_RIGHT_CLICK: string;
    FEVT_TREE_ITEM_MIDDLE_CLICK: string;
    FEVT_TREE_SEL_CHANGED: string;
    FEVT_TREE_SEL_CHANGING: string;
    FEVT_TREE_KEY_DOWN: string;
    FEVT_TREE_ITEM_GETTOOLTIP: string;
    FEVT_TREE_ITEM_MENU: string;
    FEVT_TREE_STATE_IMAGE_CLICK: string;
    FEVT_UPDATE_UI: string;
    FWx_BGColor: TColor;
    FWx_Border: integer;
    FWx_Class: string;
    FWx_ControlOrientation: TWxControlOrientation;
    FWx_Enabled: boolean;
    FWx_FGColor: TColor;
    FWx_GeneralStyle: TWxStdStyleSet;
    FWx_HelpText: string;
    FWx_Hidden: boolean;
    FWx_IDName: string;
    FWx_IDValue: integer;
    FWx_ProxyBGColorString: TWxColorString;
    FWx_ProxyFGColorString: TWxColorString;
    FWx_StretchFactor: integer;
    FWx_ToolTip: string;
    FWx_TreeviewStyle: TWxTVStyleSet;
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

    { Private methods of TWxTreeCtrl }
    procedure AutoInitialize;
    procedure AutoDestroy;

  protected
    { Protected fields of TWxTreeCtrl }

    { Protected methods of TWxTreeCtrl }
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;

  public
    { Public fields and properties of TWxTreeCtrl }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxTreeCtrl }
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

    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);
    
    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);

    function GetValidator:String;
    procedure SetValidator(value:String);
    function GetValidatorString:TWxValidatorString;
    procedure SetValidatorString(Value:TWxValidatorString);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

  published
    { Published properties of TWxTreeCtrl }
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
    //The first Event will be the default to get created when the user double clicks it
    property EVT_TREE_ITEM_ACTIVATED: string Read FEVT_TREE_ITEM_ACTIVATED Write FEVT_TREE_ITEM_ACTIVATED;
    property EVT_TREE_BEGIN_DRAG: string Read FEVT_TREE_BEGIN_DRAG Write FEVT_TREE_BEGIN_DRAG;
    property EVT_TREE_BEGIN_RDRAG: string Read FEVT_TREE_BEGIN_RDRAG Write FEVT_TREE_BEGIN_RDRAG;
    property EVT_TREE_END_DRAG: string Read FEVT_TREE_END_DRAG Write FEVT_TREE_END_DRAG;
    property EVT_TREE_BEGIN_LABEL_EDIT: string Read FEVT_TREE_BEGIN_LABEL_EDIT Write FEVT_TREE_BEGIN_LABEL_EDIT;
    property EVT_TREE_END_LABEL_EDIT: string Read FEVT_TREE_END_LABEL_EDIT Write FEVT_TREE_END_LABEL_EDIT;
    property EVT_TREE_DELETE_ITEM: string Read FEVT_TREE_DELETE_ITEM Write FEVT_TREE_DELETE_ITEM;
    property EVT_TREE_GET_INFO: string Read FEVT_TREE_GET_INFO Write FEVT_TREE_GET_INFO;
    property EVT_TREE_SET_INFO: string Read FEVT_TREE_SET_INFO Write FEVT_TREE_SET_INFO;
    property EVT_TREE_ITEM_COLLAPSED: string Read FEVT_TREE_ITEM_COLLAPSED Write FEVT_TREE_ITEM_COLLAPSED;
    property EVT_TREE_ITEM_COLLAPSING: string Read FEVT_TREE_ITEM_COLLAPSING Write FEVT_TREE_ITEM_COLLAPSING;
    property EVT_TREE_ITEM_EXPANDED: string Read FEVT_TREE_ITEM_EXPANDED Write FEVT_TREE_ITEM_EXPANDED;
    property EVT_TREE_ITEM_EXPANDING: string Read FEVT_TREE_ITEM_EXPANDING Write FEVT_TREE_ITEM_EXPANDING;
    property EVT_TREE_ITEM_RIGHT_CLICK: string Read FEVT_TREE_ITEM_RIGHT_CLICK Write FEVT_TREE_ITEM_RIGHT_CLICK;
    property EVT_TREE_ITEM_MIDDLE_CLICK: string Read FEVT_TREE_ITEM_MIDDLE_CLICK Write FEVT_TREE_ITEM_MIDDLE_CLICK;
    property EVT_TREE_SEL_CHANGED: string Read FEVT_TREE_SEL_CHANGED Write FEVT_TREE_SEL_CHANGED;
    property EVT_TREE_SEL_CHANGING: string Read FEVT_TREE_SEL_CHANGING Write FEVT_TREE_SEL_CHANGING;
    property EVT_TREE_KEY_DOWN: string Read FEVT_TREE_KEY_DOWN Write FEVT_TREE_KEY_DOWN;
    property EVT_TREE_ITEM_GETTOOLTIP: string Read FEVT_TREE_ITEM_GETTOOLTIP Write FEVT_TREE_ITEM_GETTOOLTIP;
    property EVT_TREE_ITEM_MENU: string Read FEVT_TREE_ITEM_MENU Write FEVT_TREE_ITEM_MENU;
    property EVT_TREE_STATE_IMAGE_CLICK: string Read FEVT_TREE_STATE_IMAGE_CLICK Write FEVT_TREE_STATE_IMAGE_CLICK;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;

    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: integer Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;
    property Wx_TreeviewStyle: TWxTVStyleSet Read FWx_TreeviewStyle Write FWx_TreeviewStyle;

    property Wx_Validator: string Read FWx_Validator Write FWx_Validator;
    property Wx_ProxyValidatorString : TWxValidatorString Read GetValidatorString Write SetValidatorString;
    
    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;
    
    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

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
     { Register TWxTreeCtrl with Win95 as its
       default page on the Delphi component palette }
  RegisterComponents('Win95', [TWxTreeCtrl]);
end;

{ Method to set variable and property values and create objects }
procedure TWxTreeCtrl.AutoInitialize;
begin
  FWx_EventList          := TStringList.Create;
  FWx_PropertyList       := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxTreeCtrl';
  FWx_Enabled            := True;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_IDValue            := -1;
  FWx_StretchFactor      := 0;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor         := self.color;
  defaultFGColor         := self.font.color;
  FWx_TreeviewStyle      := [wxTR_HAS_BUTTONS];
  FWx_Comments           := TStringList.Create;
  FWx_ProxyValidatorString := TwxValidatorString.Create(self);

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxTreeCtrl.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
  FWx_ProxyValidatorString.Destroy;
end; { of AutoDestroy }

{ Override OnClick handler from TTreeView,IWxComponentInterface }
procedure TWxTreeCtrl.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
  inherited Click;

     { Code to execute after click behavior
       of parent }

end;

{ Override OnKeyPress handler from TTreeView,IWxComponentInterface }
procedure TWxTreeCtrl.KeyPress(var Key: char);
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

constructor TWxTreeCtrl.Create(AOwner: TComponent);
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

  FWx_PropertyList.add('Wx_TreeViewStyle:Tree Control Styles');
  FWx_PropertyList.Add('wxTR_EDIT_LABELS:wxTR_EDIT_LABELS');
  FWx_PropertyList.Add('wxTR_NO_BUTTONS:wxTR_NO_BUTTONS');
  FWx_PropertyList.Add('wxTR_HAS_BUTTONS:wxTR_HAS_BUTTONS');
  FWx_PropertyList.Add('wxTR_TWIST_BUTTONS:wxTR_TWIST_BUTTONS');
  FWx_PropertyList.Add('wxTR_NO_LINES:wxTR_NO_LINES');
  FWx_PropertyList.Add('wxTR_FULL_ROW_HIGHLIGHT:wxTR_FULL_ROW_HIGHLIGHT');
  FWx_PropertyList.Add('wxTR_LINES_AT_ROOT:wxTR_LINES_AT_ROOT');
  FWx_PropertyList.Add('wxTR_HIDE_ROOT:wxTR_HIDE_ROOT');
  FWx_PropertyList.Add('wxTR_ROW_LINES:wxTR_ROW_LINES');
  FWx_PropertyList.Add('wxTR_HAS_VARIABLE_ROW_HEIGHT:wxTR_HAS_VARIABLE_ROW_HEIGHT');
  FWx_PropertyList.Add('wxTR_SINGLE:wxTR_SINGLE');
  FWx_PropertyList.Add('wxTR_MULTIPLE:wxTR_MULTIPLE');
  FWx_PropertyList.Add('wxTR_EXTENDED:wxTR_EXTENDED');
  FWx_PropertyList.Add('wxTR_DEFAULT_STYLE:wxTR_DEFAULT_STYLE');
  FWx_PropertyList.Add('wxTR_COLUMN_LINES:wxTR_COLUMN_LINES');
  FWx_PropertyList.Add('wxTR_SHOW_ROOT_LABEL_ONLY:wxTR_SHOW_ROOT_LABEL_ONLY');
  FWx_PropertyList.add('Items:Items');

  FWx_EventList.add('EVT_TREE_BEGIN_DRAG   :  OnBeginDrag ');
  FWx_EventList.add('EVT_TREE_BEGIN_RDRAG   :  OnBeginRDrag ');
  FWx_EventList.add('EVT_TREE_END_DRAG   :  OnEndDrag ');
  FWx_EventList.add('EVT_TREE_BEGIN_LABEL_EDIT   :  OnBeginLabelEdit ');
  FWx_EventList.add('EVT_TREE_END_LABEL_EDIT   :  OnEndLabelEdit');
  FWx_EventList.add('EVT_TREE_DELETE_ITEM   :  OnDeleteItem ');
  FWx_EventList.add('EVT_TREE_GET_INFO   :  OnGetInfo');
  FWx_EventList.add('EVT_TREE_SET_INFO   :  OnSetInfo ');
  FWx_EventList.add('EVT_TREE_ITEM_ACTIVATED   :  OnItemActivated');
  FWx_EventList.add('EVT_TREE_ITEM_COLLAPSED   :  OnItemCollapsed');
  FWx_EventList.add('EVT_TREE_ITEM_COLLAPSING   :  OnItemCollapsing');
  FWx_EventList.add('EVT_TREE_ITEM_EXPANDED   :  OnItemExpanded');
  FWx_EventList.add('EVT_TREE_ITEM_EXPANDING   :  OnItemExpanding');
  FWx_EventList.add('EVT_TREE_ITEM_RIGHT_CLICK   :  OnItemRClick');
  FWx_EventList.add('EVT_TREE_ITEM_MIDDLE_CLICK   :  OnItemMClick');
  FWx_EventList.add('EVT_TREE_SEL_CHANGED   :  OnSelChanged ');
  FWx_EventList.add('EVT_TREE_SEL_CHANGING   :  OnSelChanging ');
  FWx_EventList.add('EVT_TREE_KEY_DOWN   :  OnKeyDown');
  FWx_EventList.add('EVT_TREE_ITEM_GETTOOLTIP   :  OnItemGetTooltip');
  FWx_EventList.add('EVT_TREE_ITEM_MENU   :  OnItemMenu');
  FWx_EventList.add('EVT_TREE_STATE_IMAGE_CLICK   :  On3StateImageClick');
  FWx_EventList.add('EVT_UPDATE_UI   :  OnUpdateUI');

end;

destructor TWxTreeCtrl.Destroy;
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

function TWxTreeCtrl.GenerateEnumControlIDs: string;
begin
  Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
end;

function TWxTreeCtrl.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s  %d ', [Wx_IDName, Wx_IDValue]);
end;


function TWxTreeCtrl.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

  if (XRCGEN) then
 begin
 if trim(EVT_TREE_BEGIN_DRAG) <> '' then
    Result := Format('EVT_TREE_BEGIN_DRAG(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_BEGIN_DRAG]) + '';

  if trim(EVT_TREE_BEGIN_RDRAG) <> '' then
    Result := Result + #13 + Format('EVT_TREE_BEGIN_RDRAG(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_BEGIN_RDRAG]) + '';

  if trim(EVT_TREE_END_DRAG) <> '' then
    Result := Result + #13 + Format('EVT_TREE_END_DRAG(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_END_DRAG]) + '';

  if trim(EVT_TREE_BEGIN_LABEL_EDIT) <> '' then
    Result := Result + #13 + Format('EVT_TREE_BEGIN_LABEL_EDIT(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_BEGIN_LABEL_EDIT]) + '';

  if trim(EVT_TREE_END_LABEL_EDIT) <> '' then
    Result := Result + #13 + Format('EVT_TREE_END_LABEL_EDIT(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_END_LABEL_EDIT]) + '';

  if trim(EVT_TREE_DELETE_ITEM) <> '' then
    Result := Result + #13 + Format('EVT_TREE_DELETE_ITEM(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_DELETE_ITEM]) + '';

  if trim(EVT_TREE_GET_INFO) <> '' then
    Result := Result + #13 + Format('EVT_TREE_GET_INFO(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_GET_INFO]) + '';

  if trim(EVT_TREE_SET_INFO) <> '' then
    Result := Result + #13 + Format('EVT_TREE_SET_INFO(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_SET_INFO]) + '';

  if trim(EVT_TREE_ITEM_ACTIVATED) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_ACTIVATED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_ACTIVATED]) + '';

  if trim(EVT_TREE_ITEM_COLLAPSED) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_COLLAPSED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_COLLAPSED]) + '';

  if trim(EVT_TREE_ITEM_COLLAPSING) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_COLLAPSING(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_COLLAPSING]) + '';

  if trim(EVT_TREE_ITEM_EXPANDED) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_EXPANDED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_EXPANDED]) + '';

  if trim(EVT_TREE_ITEM_EXPANDING) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_EXPANDING(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_EXPANDING]) + '';

  if trim(EVT_TREE_ITEM_RIGHT_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_RIGHT_CLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_RIGHT_CLICK]) + '';

  if trim(EVT_TREE_ITEM_MIDDLE_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_MIDDLE_CLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_MIDDLE_CLICK]) + '';

  if trim(EVT_TREE_SEL_CHANGED) <> '' then
    Result := Result + #13 + Format('EVT_TREE_SEL_CHANGED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_SEL_CHANGED]) + '';

  if trim(EVT_TREE_SEL_CHANGING) <> '' then
    Result := Result + #13 + Format('EVT_TREE_SEL_CHANGING(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_SEL_CHANGING]) + '';

  if trim(EVT_TREE_KEY_DOWN) <> '' then
    Result := Result + #13 + Format('EVT_TREE_KEY_DOWN(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_KEY_DOWN]) + '';

  if trim(EVT_TREE_ITEM_GETTOOLTIP) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_GETTOOLTIP(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_GETTOOLTIP]) + '';

  if trim(EVT_TREE_ITEM_MENU) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_MENU(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_MENU]) + '';

  if trim(EVT_TREE_STATE_IMAGE_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_TREE_STATE_IMAGE_CLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREE_STATE_IMAGE_CLICK]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
 end
 else
 begin
  if trim(EVT_TREE_BEGIN_DRAG) <> '' then
    Result := Format('EVT_TREE_BEGIN_DRAG(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_BEGIN_DRAG]) + '';

  if trim(EVT_TREE_BEGIN_RDRAG) <> '' then
    Result := Result + #13 + Format('EVT_TREE_BEGIN_RDRAG(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_BEGIN_RDRAG]) + '';

  if trim(EVT_TREE_END_DRAG) <> '' then
    Result := Result + #13 + Format('EVT_TREE_END_DRAG(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_END_DRAG]) + '';

  if trim(EVT_TREE_BEGIN_LABEL_EDIT) <> '' then
    Result := Result + #13 + Format('EVT_TREE_BEGIN_LABEL_EDIT(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_BEGIN_LABEL_EDIT]) + '';

  if trim(EVT_TREE_END_LABEL_EDIT) <> '' then
    Result := Result + #13 + Format('EVT_TREE_END_LABEL_EDIT(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_END_LABEL_EDIT]) + '';

  if trim(EVT_TREE_DELETE_ITEM) <> '' then
    Result := Result + #13 + Format('EVT_TREE_DELETE_ITEM(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_DELETE_ITEM]) + '';

  if trim(EVT_TREE_GET_INFO) <> '' then
    Result := Result + #13 + Format('EVT_TREE_GET_INFO(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_GET_INFO]) + '';

  if trim(EVT_TREE_SET_INFO) <> '' then
    Result := Result + #13 + Format('EVT_TREE_SET_INFO(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_SET_INFO]) + '';

  if trim(EVT_TREE_ITEM_ACTIVATED) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_ACTIVATED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_ITEM_ACTIVATED]) + '';

  if trim(EVT_TREE_ITEM_COLLAPSED) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_COLLAPSED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_ITEM_COLLAPSED]) + '';

  if trim(EVT_TREE_ITEM_COLLAPSING) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_COLLAPSING(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_ITEM_COLLAPSING]) + '';

  if trim(EVT_TREE_ITEM_EXPANDED) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_EXPANDED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_ITEM_EXPANDED]) + '';

  if trim(EVT_TREE_ITEM_EXPANDING) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_EXPANDING(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_ITEM_EXPANDING]) + '';

  if trim(EVT_TREE_ITEM_RIGHT_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_RIGHT_CLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_ITEM_RIGHT_CLICK]) + '';

  if trim(EVT_TREE_ITEM_MIDDLE_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_MIDDLE_CLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_ITEM_MIDDLE_CLICK]) + '';

  if trim(EVT_TREE_SEL_CHANGED) <> '' then
    Result := Result + #13 + Format('EVT_TREE_SEL_CHANGED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_SEL_CHANGED]) + '';

  if trim(EVT_TREE_SEL_CHANGING) <> '' then
    Result := Result + #13 + Format('EVT_TREE_SEL_CHANGING(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_SEL_CHANGING]) + '';

  if trim(EVT_TREE_KEY_DOWN) <> '' then
    Result := Result + #13 + Format('EVT_TREE_KEY_DOWN(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_KEY_DOWN]) + '';

  if trim(EVT_TREE_ITEM_GETTOOLTIP) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_GETTOOLTIP(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_ITEM_GETTOOLTIP]) + '';

  if trim(EVT_TREE_ITEM_MENU) <> '' then
    Result := Result + #13 + Format('EVT_TREE_ITEM_MENU(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_ITEM_MENU]) + '';

  if trim(EVT_TREE_STATE_IMAGE_CLICK) <> '' then
    Result := Result + #13 + Format('EVT_TREE_STATE_IMAGE_CLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREE_STATE_IMAGE_CLICK]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
 end;

end;

function TWxTreeCtrl.GenerateXRCControlCreation(IndentString: string): TStringList;
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
      [GetTreeViewSpecificStyle(self.Wx_GeneralStyle, Wx_TreeviewStyle)]));
    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxTreeCtrl.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment: string;
begin
  Result := '';

    if FWx_PaneCaption = '' then
    FWx_PaneCaption := Self.Name;
  if FWx_PaneName = '' then
    FWx_PaneName := Self.Name + '_Pane';

  parentName := GetWxWidgetParent(self, Wx_AuiManaged);

  strStyle := GetTreeViewSpecificStyle(self.Wx_GeneralStyle, Wx_TreeviewStyle);

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
    Format('%s = new %s(%s, %s, %s, %s%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);
 end;

  if trim(self.Wx_ToolTip) <> '' then
    Result := Result + #13 + Format('%s->SetToolTip(%s);',
      [self.Name, GetCppString(Wx_ToolTip)]);

  if self.Wx_Hidden then
    Result := Result + #13 + Format('%s->Show(false);', [self.Name]);

  if not Wx_Enabled then
    Result := Result + #13 + Format('%s->Enable(false);', [self.Name]);

  if trim(self.Wx_HelpText) <> '' then
    Result := Result + #13 + Format('%s->SetHelpText(%s);',
      [self.Name, GetCppString(Wx_HelpText)]);

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

function TWxTreeCtrl.GenerateGUIControlDeclaration: string;
begin
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxTreeCtrl.GenerateHeaderInclude: string;
begin
  Result := '#include <wx/treectrl.h>';
end;

function TWxTreeCtrl.GenerateImageInclude: string;
begin

end;

function TWxTreeCtrl.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxTreeCtrl.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxTreeCtrl.GetIDValue: integer;
begin
  Result := wx_IDValue;
end;

function TWxTreeCtrl.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_TREE_BEGIN_DRAG' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_BEGIN_RDRAG' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_END_DRAG' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_BEGIN_LABEL_EDIT' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_END_LABEL_EDIT' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_DELETE_ITEM' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_GET_INFO' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_SET_INFO' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_ITEM_ACTIVATED' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_ITEM_COLLAPSED' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_ITEM_COLLAPSING' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_ITEM_EXPANDED' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_ITEM_EXPANDING' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_ITEM_RIGHT_CLICK' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_ITEM_MIDDLE_CLICK' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_SEL_CHANGED' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_SEL_CHANGING' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_KEY_DOWN' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_ITEM_GETTOOLTIP' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_ITEM_MENU' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREE_STATE_IMAGE_CLICK' then
  begin
    Result := 'wxTreeEvent& event';
    exit;
  end;
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxTreeCtrl.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxTreeCtrl.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxTreeCtrl.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxTreeCtrl.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxTreeCtrl.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxTreeCtrl.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxTreeCtrl.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxTreeCtrl.GetWxClassName: string;
begin
  if wx_Class = '' then
    wx_Class := 'wxTreeCtrl';
  Result := wx_Class;
end;

procedure TWxTreeCtrl.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxTreeCtrl.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxTreeCtrl.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxTreeCtrl.SetIDValue(IDValue: integer);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxTreeCtrl.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxTreeCtrl.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxTreeCtrl.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxTreeCtrl.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxTreeCtrl.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxTreeCtrl.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxTreeCtrl.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxTreeCtrl.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxTreeCtrl.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxTreeCtrl.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxTreeCtrl.GetValidatorString:TWxValidatorString;
begin
  Result := FWx_ProxyValidatorString;
  Result.FstrValidatorValue := Wx_Validator;
end;

procedure TWxTreeCtrl.SetValidatorString(Value:TWxValidatorString);
begin
  FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
  Wx_Validator := Value.FstrValidatorValue;
end;

function TWxTreeCtrl.GetValidator:String;
begin
  Result := Wx_Validator;
end;

procedure TWxTreeCtrl.SetValidator(value:String);
begin
  Wx_Validator := value;
end;

end.
