 { ****************************************************************** }
 {                                                                    }
 { $Id$   }
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

unit WxTreeListctrl;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ComCtrls, WxUtils, ExtCtrls, WxSizerPanel;

type
  TWxTreeListCtrl = class(TListView, IWxComponentInterface)
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
    FWx_IDValue: longint;
    { Storage for property Wx_ListviewStyle }
    FWx_ListviewStyle: TWxLVStyleSet;
    { Storage for property Wx_ListviewView }
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
    FWx_Include: string;
    FWx_TreeListviewStyle : TWxTVStyleSet;

    { Private methods of TWxTreeListCtrl }
    { Method to set variable and property values and create objects }
    procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
    procedure AutoDestroy;
    
  protected
    { Protected fields of TWxTreeListCtrl }

    { Protected methods of TWxTreeListCtrl }
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;

  public
    { Public fields and properties of TWxTreeListCtrl }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxTreeListCtrl }
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

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

  published
    { Published properties of TWxTreeListCtrl }
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
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
    property EVT_LIST_ITEM_ACTIVATED: string
      Read FEVT_LIST_ITEM_ACTIVATED Write FEVT_LIST_ITEM_ACTIVATED;
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
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_TreeListviewStyle: TWxTVStyleSet Read FWx_TreeListviewStyle Write FWx_TreeListviewStyle;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Include: string Read FWx_Include Write FWx_Include;
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
     { Register TWxTreeListCtrl with wxWidgets as its
       default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TWxTreeListCtrl]);
end;

{ Method to set variable and property values and create objects }
procedure TWxTreeListCtrl.AutoInitialize;
begin
  ViewStyle              := vsReport;
  FWx_ListviewStyle      := [];
  FWx_EventList          := TStringList.Create;
  FWx_PropertyList       := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxTreeListCtrl';
  FWx_Enabled            := True;
  FWx_Hidden             := False;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_Include            := '#include <wx/treelistctrl.h>';
  FWx_IDValue            := -1;
  FWx_StretchFactor      := 0;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor         := self.color;
  defaultFGColor         := self.font.color;
  FWx_Comments           := TStringList.Create;
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxTreeListCtrl.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_Comments.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
end; { of AutoDestroy }

{ Override OnKeyPress handler from TListView,IWxComponentInterface }
procedure TWxTreeListCtrl.KeyPress(var Key: char);
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

constructor TWxTreeListCtrl.Create(AOwner: TComponent);
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

  FWx_PropertyList.add('Wx_TreeListViewStyle:TreeList Styles');
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

destructor TWxTreeListCtrl.Destroy;
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


function TWxTreeListCtrl.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxTreeListCtrl.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxTreeListCtrl.GenerateEventTableEntries(CurrClassName: string): string;
begin

  Result := '';

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

function TWxTreeListCtrl.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;
  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));
    Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetTreeViewSpecificStyle(Wx_GeneralStyle, Wx_TreeListviewStyle)]));
    Result.Add(IndentString + '</object>');
  except
    Result.Free;
    raise;
  end;

end;

function TWxTreeListCtrl.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment: string;
  i: integer;
begin
  Result := '';

  parentName := GetWxWidgetParent(self);

  strStyle := GetTreeViewSpecificStyle(Wx_GeneralStyle, Wx_TreeListviewStyle);
  if Trim(strStyle) <> '' then
    strStyle := ',' + strStyle;
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, wxPoint(%d,%d), wxSize(%d,%d)%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    self.Left, self.Top, self.Width, self.Height, strStyle]);

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
  for i := self.columns.Count - 1 downto 0 do
  begin
    if (i = self.columns.Count - 1) then
      Result := Result + #13 + Format('%s->AddColumn(%s,%s,%d );',[self.Name, GetCppString(self.columns[i].Caption), AlignmentToStr(columns[i].Alignment), self.columns[i].Width])
    else
        Result := Result + #13 + Format('%s->InsertColumn(0,%s,%s,%d );',[self.Name, GetCppString(self.columns[i].Caption), AlignmentToStr( columns[i].Alignment), self.columns[i].Width]);
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

  if (self.Parent is TWxSizerPanel) then
  begin
    strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
    Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);
  end;

end;

function TWxTreeListCtrl.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxTreeListCtrl.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := Wx_Include;
end;

function TWxTreeListCtrl.GenerateImageInclude: string;
begin

end;

function TWxTreeListCtrl.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxTreeListCtrl.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxTreeListCtrl.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxTreeListCtrl.GetParameterFromEventName(EventName: string): string;
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

function TWxTreeListCtrl.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxTreeListCtrl.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxTreeListCtrl.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxTreeListCtrl.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxTreeListCtrl.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxTreeListCtrl.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxTreeListCtrl.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxTreeListCtrl.GetWxClassName: string;
begin
  if wx_Class = '' then
    wx_Class := 'wxTreeListCtrl';
  Result := wx_Class;
end;

procedure TWxTreeListCtrl.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxTreeListCtrl.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxTreeListCtrl.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxTreeListCtrl.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxTreeListCtrl.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxTreeListCtrl.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxTreeListCtrl.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxTreeListCtrl.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxTreeListCtrl.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxTreeListCtrl.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxTreeListCtrl.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxTreeListCtrl.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxTreeListCtrl.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxTreeListCtrl.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

end.
