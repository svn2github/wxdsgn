 { ****************************************************************** }
 {                                                                    }
 { $Id: wxtreelistctrl.pas 936 2007-05-15 03:47:39Z gururamnath $   }
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

Unit WxTreeListctrl;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, ComCtrls, WxUtils, ExtCtrls, WxAuiToolBar, WxAuiNotebookPage,
    WxSizerPanel; //, JvExComCtrls, JvComCtrls;

Type
    TWxTreeListCtrl = Class(TListView, IWxComponentInterface)
    Private
    { Private fields of TWxListCtrl }
    { Storage for property EVT_TREE_BEGIN_DRAG }
        FEVT_TREE_BEGIN_DRAG: String;
    { Storage for property EVT_TREE_BEGIN_RDRAG }
        FEVT_TREE_BEGIN_RDRAG: String;
    { Storage for property EVT_TREE_END_DRAG }
        FEVT_TREE_END_DRAG: String;

    { Storage for property EVT_TREE_BEGIN_LABEL_EDIT }
        FEVT_TREE_BEGIN_LABEL_EDIT: String;
    { Storage for property EVT_TREE_END_LABEL_EDIT }
        FEVT_TREE_END_LABEL_EDIT: String;

    { Storage for property EVT_TREE_DELETE_ITEM }
        FEVT_TREE_DELETE_ITEM: String;
    { Storage for property EVT_TREE_ITEM_ACTIVATED }
        FEVT_TREE_ITEM_ACTIVATED: String;

    { Storage for property EVT_TREE_ITEM_COLLAPSED }
        FEVT_TREE_ITEM_COLLAPSED: String;
    { Storage for property EVT_TREE_ITEM_COLLAPSING }
        FEVT_TREE_ITEM_COLLAPSING: String;

    { Storage for property EVT_TREE_ITEM_EXPANDED }
        FEVT_TREE_ITEM_EXPANDED: String;
    { Storage for property EVT_TREE_ITEM_EXPANDING }
        FEVT_TREE_ITEM_EXPANDING: String;

    { Storage for property EVT_TREE_ITEM_RIGHT_CLICK }
        FEVT_TREE_ITEM_RIGHT_CLICK: String;
    { Storage for property EVT_TREE_ITEM_MIDDLE_CLICK }
        FEVT_TREE_ITEM_MIDDLE_CLICK: String;

    { Storage for property EVT_TREE_SEL_CHANGED }
        FEVT_TREE_SEL_CHANGED: String;
    { Storage for property EVT_TREE_SEL_CHANGING }
        FEVT_TREE_SEL_CHANGING: String;

    { Storage for property EVT_TREE_KEY_DOWN }
        FEVT_TREE_KEY_DOWN: String;

    { Storage for property EVT_TREE_ITEM_MENU }
        FEVT_TREE_ITEM_MENU: String;

    { Storage for property EVT_UPDATE_UI }
        FEVT_UPDATE_UI: String;
    { Storage for property Wx_BGColor }
        FWx_BGColor: TColor;
    { Storage for property Wx_Border }
        FWx_Border: Integer;
    { Storage for property Wx_Class }
        FWx_Class: String;
    { Storage for property Wx_ControlOrientation }
        FWx_ControlOrientation: TwxControlOrientation;
    { Storage for property Wx_Enabled }
        FWx_Enabled: Boolean;
    { Storage for property Wx_FGColor }
        FWx_FGColor: TColor;
    { Storage for property Wx_GeneralStyle }
        FWx_GeneralStyle: TWxStdStyleSet;
    { Storage for property Wx_HelpText }
        FWx_HelpText: String;
    { Storage for property Wx_Hidden }
        FWx_Hidden: Boolean;
    { Storage for property Wx_IDName }
        FWx_IDName: String;
    { Storage for property Wx_IDValue }
        FWx_IDValue: Integer;
    { Storage for property Wx_ListviewStyle }
        FWx_ListviewStyle: TWxLVStyleSet;
    { Storage for property Wx_ListviewView }
    { Storage for property Wx_ProxyBGColorString }
        FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
        FWx_ProxyFGColorString: TWxColorString;
    { Storage for property Wx_StretchFactor }
        FWx_StretchFactor: Integer;
    { Storage for property Wx_ToolTip }
        FWx_ToolTip: String;
        FWx_EventList: TStringList;
        FWx_PropertyList: TStringList;
        FInvisibleBGColorString: String;
        FInvisibleFGColorString: String;
        FWx_Comments: TStrings;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;
        FWx_Include: String;
        FWx_TreeListviewStyle: TWxTVStyleSet;

//Aui Properties
        FWx_AuiManaged: Boolean;
        FWx_PaneCaption: String;
        FWx_PaneName: String;
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

    { Private methods of TWxTreeListCtrl }
    { Method to set variable and property values and create objects }
        Procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
        Procedure AutoDestroy;

    Protected
    { Protected fields of TWxTreeListCtrl }

    { Protected methods of TWxTreeListCtrl }
        Procedure KeyPress(Var Key: Char); Override;
        Procedure Loaded; Override;

    Public
    { Public fields and properties of TWxTreeListCtrl }
        defaultBGColor: TColor;
        defaultFGColor: TColor;
    { Public methods of TWxTreeListCtrl }
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Function GenerateControlIDs: String;
        Function GenerateEnumControlIDs: String;
        Function GenerateEventTableEntries(CurrClassName: String): String;
        Function GenerateGUIControlCreation: String;
        Function GenerateXRCControlCreation(IndentString: String): TStringList;
        Function GenerateGUIControlDeclaration: String;
        Function GenerateHeaderInclude: String;
        Function GenerateImageInclude: String;
        Function GetEventList: TStringList;
        Function GetIDName: String;
        Function GetIDValue: Integer;
        Function GetParameterFromEventName(EventName: String): String;
        Function GetPropertyList: TStringList;
        Function GetTypeFromEventName(EventName: String): String;
        Function GetWxClassName: String;
        Procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
        Procedure SetIDName(IDName: String);
        Procedure SetIDValue(IDValue: Integer);
        Procedure SetWxClassName(wxClassName: String);
        Function GetFGColor: String;
        Procedure SetFGColor(strValue: String);

        Function GetBGColor: String;
        Procedure SetBGColor(strValue: String);

        Function GetGenericColor(strVariableName: String): String;
        Procedure SetGenericColor(strVariableName, strValue: String);

        Procedure SetProxyFGColorString(Value: String);
        Procedure SetProxyBGColorString(Value: String);

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

        Function TLAlignmentToStr(taPos: TAlignment): String;

    Published
    { Published properties of TWxTreeListCtrl }
        Property OnKeyDown;
        Property OnKeyPress;
        Property OnKeyUp;

        Property EVT_TREE_BEGIN_DRAG: String Read FEVT_TREE_BEGIN_DRAG
            Write FEVT_TREE_BEGIN_DRAG;
        Property EVT_TREE_BEGIN_RDRAG: String Read FEVT_TREE_BEGIN_RDRAG
            Write FEVT_TREE_BEGIN_RDRAG;
        Property EVT_TREE_END_DRAG: String
            Read FEVT_TREE_END_DRAG Write FEVT_TREE_END_DRAG;

        Property EVT_TREE_BEGIN_LABEL_EDIT: String Read FEVT_TREE_BEGIN_LABEL_EDIT
            Write FEVT_TREE_BEGIN_LABEL_EDIT;
        Property EVT_TREE_END_LABEL_EDIT: String
            Read FEVT_TREE_END_LABEL_EDIT Write FEVT_TREE_END_LABEL_EDIT;

        Property EVT_TREE_DELETE_ITEM: String Read FEVT_TREE_DELETE_ITEM
            Write FEVT_TREE_DELETE_ITEM;

        Property EVT_TREE_ITEM_ACTIVATED: String
            Read FEVT_TREE_ITEM_ACTIVATED Write FEVT_TREE_ITEM_ACTIVATED;

        Property EVT_TREE_ITEM_COLLAPSED: String Read FEVT_TREE_ITEM_COLLAPSED
            Write FEVT_TREE_ITEM_COLLAPSED;
        Property EVT_TREE_ITEM_COLLAPSING: String
            Read FEVT_TREE_ITEM_COLLAPSING Write FEVT_TREE_ITEM_COLLAPSING;

        Property EVT_TREE_ITEM_EXPANDED: String Read FEVT_TREE_ITEM_EXPANDED
            Write FEVT_TREE_ITEM_EXPANDED;
        Property EVT_TREE_ITEM_EXPANDING: String
            Read FEVT_TREE_ITEM_EXPANDING Write FEVT_TREE_ITEM_EXPANDING;

        Property EVT_TREE_ITEM_RIGHT_CLICK: String
            Read FEVT_TREE_ITEM_RIGHT_CLICK Write FEVT_TREE_ITEM_RIGHT_CLICK;
        Property EVT_TREE_ITEM_MIDDLE_CLICK: String
            Read FEVT_TREE_ITEM_MIDDLE_CLICK Write FEVT_TREE_ITEM_MIDDLE_CLICK;

        Property EVT_TREE_SEL_CHANGED: String
            Read FEVT_TREE_SEL_CHANGED Write FEVT_TREE_SEL_CHANGED;

        Property EVT_TREE_SEL_CHANGING: String
            Read FEVT_TREE_SEL_CHANGING Write FEVT_TREE_SEL_CHANGING;

        Property EVT_TREE_KEY_DOWN: String Read FEVT_TREE_KEY_DOWN Write FEVT_TREE_KEY_DOWN;

        Property EVT_TREE_ITEM_MENU: String Read FEVT_TREE_ITEM_MENU Write FEVT_TREE_ITEM_MENU;

        Property EVT_UPDATE_UI: String Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
        Property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_ControlOrientation: TwxControlOrientation
            Read FWx_ControlOrientation Write FWx_ControlOrientation;
        Property Wx_Enabled: Boolean Read FWx_Enabled Write FWx_Enabled Default True;
        Property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
        Property Wx_GeneralStyle: TWxStdStyleSet
            Read FWx_GeneralStyle Write FWx_GeneralStyle;
        Property Wx_HelpText: String Read FWx_HelpText Write FWx_HelpText;
        Property Wx_Hidden: Boolean Read FWx_Hidden Write FWx_Hidden Default False;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue Default -1;
        Property Wx_TreeListviewStyle: TWxTVStyleSet Read FWx_TreeListviewStyle Write FWx_TreeListviewStyle;
        Property Wx_ToolTip: String Read FWx_ToolTip Write FWx_ToolTip;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Include: String Read FWx_Include Write FWx_Include;
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;

        Property InvisibleBGColorString: String Read FInvisibleBGColorString Write FInvisibleBGColorString;
        Property InvisibleFGColorString: String Read FInvisibleFGColorString Write FInvisibleFGColorString;
        Property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
        Property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;

        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

//Aui Properties
        Property Wx_AuiManaged: Boolean Read FWx_AuiManaged Write FWx_AuiManaged Default False;
        Property Wx_PaneCaption: String Read FWx_PaneCaption Write FWx_PaneCaption;
        Property Wx_PaneName: String Read FWx_PaneName Write FWx_PaneName;
        Property Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem Read FWx_Aui_Dock_Direction Write FWx_Aui_Dock_Direction;
        Property Wx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet Read FWx_Aui_Dockable_Direction Write FWx_Aui_Dockable_Direction;
        Property Wx_Aui_Pane_Style: TwxAuiPaneStyleSet Read FWx_Aui_Pane_Style Write FWx_Aui_Pane_Style;
        Property Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet Read FWx_Aui_Pane_Buttons Write FWx_Aui_Pane_Buttons;
        Property Wx_BestSize_Height: Integer Read FWx_BestSize_Height Write FWx_BestSize_Height Default -1;
        Property Wx_BestSize_Width: Integer Read FWx_BestSize_Width Write FWx_BestSize_Width Default -1;
        Property Wx_MinSize_Height: Integer Read FWx_MinSize_Height Write FWx_MinSize_Height Default -1;
        Property Wx_MinSize_Width: Integer Read FWx_MinSize_Width Write FWx_MinSize_Width Default -1;
        Property Wx_MaxSize_Height: Integer Read FWx_MaxSize_Height Write FWx_MaxSize_Height Default -1;
        Property Wx_MaxSize_Width: Integer Read FWx_MaxSize_Width Write FWx_MaxSize_Width Default -1;
        Property Wx_Floating_Height: Integer Read FWx_Floating_Height Write FWx_Floating_Height Default -1;
        Property Wx_Floating_Width: Integer Read FWx_Floating_Width Write FWx_Floating_Width Default -1;
        Property Wx_Floating_X_Pos: Integer Read FWx_Floating_X_Pos Write FWx_Floating_X_Pos Default -1;
        Property Wx_Floating_Y_Pos: Integer Read FWx_Floating_Y_Pos Write FWx_Floating_Y_Pos Default -1;
        Property Wx_Layer: Integer Read FWx_Layer Write FWx_Layer Default 0;
        Property Wx_Row: Integer Read FWx_Row Write FWx_Row Default 0;
        Property Wx_Position: Integer Read FWx_Position Write FWx_Position Default 0;

    End;

Procedure Register;

Implementation

Procedure Register;
Begin
     { Register TWxTreeListCtrl with wxWidgets as its
       default page on the Delphi component palette }
    RegisterComponents('wxWidgets', [TWxTreeListCtrl]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxTreeListCtrl.AutoInitialize;
Begin
    ViewStyle := vsReport;
    FWx_ListviewStyle := [];
    FWx_EventList := TStringList.Create;
    FWx_PropertyList := TStringList.Create;
    FWx_Border := 5;
    FWx_Class := 'wxTreeListCtrl';
    FWx_Enabled := True;
    FWx_Hidden := False;
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_Include := '#include <wx/treelistctrl.h>';
    FWx_IDValue := -1;
    FWx_StretchFactor := 0;
    FWx_ProxyBGColorString := TWxColorString.Create;
    FWx_ProxyFGColorString := TWxColorString.Create;
    defaultBGColor := self.color;
    defaultFGColor := self.font.color;
    FWx_Comments := TStringList.Create;
End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxTreeListCtrl.AutoDestroy;
Begin
    FWx_EventList.Destroy;
    FWx_PropertyList.Destroy;
    FWx_Comments.Destroy;
    FWx_ProxyBGColorString.Destroy;
    FWx_ProxyFGColorString.Destroy;
End; { of AutoDestroy }

{ Override OnKeyPress handler from TListView,IWxComponentInterface }
Procedure TWxTreeListCtrl.KeyPress(Var Key: Char);
Const
    TabKey = Char(VK_TAB);
    EnterKey = Char(VK_RETURN);
Begin
     { Key contains the character produced by the keypress.
       It can be tested or assigned a new value before the
       call to the inherited KeyPress method.  Setting Key
       to #0 before call to the inherited KeyPress method
       terminates any further processing of the character. }

  { Activate KeyPress behavior of parent }
    Inherited KeyPress(Key);

  { Code to execute after KeyPress behavior of parent }

End;

Constructor TWxTreeListCtrl.Create(AOwner: TComponent);
Begin
  { Call the Create method of the parent class }
    Inherited Create(AOwner);

  { AutoInitialize sets the initial values of variables and      }
  { properties; also, it creates objects for properties of       }
  { standard Delphi object types (e.g., TFont, TTimer,           }
  { TPicture) and for any variables marked as objects.           }
  { AutoInitialize method is generated by Component Create.      }
    AutoInitialize;

  { Code to perform other tasks when the component is created }
    PopulateGenericProperties(FWx_PropertyList);
    PopulateAuiGenericProperties(FWx_PropertyList);

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
    FWx_PropertyList.Add('wxTR_VIRTUAL:wxTR_VIRTUAL');
 // FWx_PropertyList.Add('wxTR_SHOW_ROOT_LABEL_ONLY:wxTR_SHOW_ROOT_LABEL_ONLY');
    FWx_PropertyList.add('Columns:Columns');

    FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

    FWx_EventList.add('EVT_TREE_BEGIN_DRAG:OnBeginDrag');
    FWx_EventList.add('EVT_TREE_BEGIN_RDRAG:OnBeginRDrag');
    FWx_EventList.add('EVT_TREE_END_DRAG:OnEndDrag');
    FWx_EventList.add('EVT_TREE_BEGIN_LABEL_EDIT:OnBeginLabelEdit');
    FWx_EventList.add('EVT_TREE_END_LABEL_EDIT:OnEndLabelEdit');
    FWx_EventList.add('EVT_TREE_DELETE_ITEM:OnDeleteItem');
    FWx_EventList.add('EVT_TREE_ITEM_ACTIVATED:OnItemActivated');
    FWx_EventList.add('EVT_TREE_ITEM_COLLAPSED:OnItemCollapsed');
    FWx_EventList.add('EVT_TREE_ITEM_COLLAPSING:OnItemCollapsing');
    FWx_EventList.add('EVT_TREE_ITEM_EXPANDED:OnItemExpanded');
    FWx_EventList.add('EVT_TREE_ITEM_EXPANDING:OnItemExpanding');
    FWx_EventList.add('EVT_TREE_ITEM_RIGHT_CLICK:OnRightClick');
    FWx_EventList.add('EVT_TREE_ITEM_MIDDLE_CLICK:OnMiddleClick');
    FWx_EventList.add('EVT_TREE_SEL_CHANGE:OnSelectionChange');
    FWx_EventList.add('EVT_TREE_SEL_CHANGED:OnSelectionChanged');
    FWx_EventList.add('EVT_TREE_KEY_DOWN:OnTreeKeyDown');
    FWx_EventList.add('EVT_TREE_MENU:OnTreeItemMenu');

    FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');
End;

Destructor TWxTreeListCtrl.Destroy;
Begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
    AutoDestroy;

  { Here, free any other dynamic objects that the component methods  }
  { created but have not yet freed.  Also perform any other clean-up }
  { operations needed before the component is destroyed.             }

  { Last, free the component by calling the Destroy method of the    }
  { parent class.                                                    }
    Inherited Destroy;
End;


Function TWxTreeListCtrl.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxTreeListCtrl.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
End;

Function TWxTreeListCtrl.GenerateEventTableEntries(CurrClassName: String): String;
Begin

    Result := '';

    If trim(EVT_TREE_BEGIN_DRAG) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_BEGIN_DRAG(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_BEGIN_DRAG]) + '';

    If trim(EVT_TREE_BEGIN_RDRAG) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_BEGIN_RDRAG(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_BEGIN_RDRAG]) + '';

    If trim(EVT_TREE_END_DRAG) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_END_DRAG(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_END_DRAG]) + '';

    If trim(EVT_TREE_BEGIN_LABEL_EDIT) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_BEGIN_LABEL_EDIT(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_BEGIN_LABEL_EDIT]) + '';

    If trim(EVT_TREE_END_LABEL_EDIT) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_END_LABEL_EDIT(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_END_LABEL_EDIT]) + '';

    If trim(EVT_TREE_DELETE_ITEM) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_DELETE_ITEM(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_DELETE_ITEM]) + '';

    If trim(EVT_TREE_ITEM_ACTIVATED) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_ITEM_ACTIVATED(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_ITEM_ACTIVATED]) + '';


    If trim(EVT_TREE_ITEM_COLLAPSED) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_ITEM_COLLAPSED(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_ITEM_COLLAPSED]) + '';

    If trim(EVT_TREE_ITEM_COLLAPSING) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_ITEM_COLLAPSING(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_ITEM_COLLAPSING]) + '';

    If trim(EVT_TREE_ITEM_EXPANDED) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_ITEM_EXPANDED(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_ITEM_EXPANDED]) + '';

    If trim(EVT_TREE_ITEM_EXPANDING) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_ITEM_EXPANDING(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_ITEM_EXPANDING]) + '';

    If trim(EVT_TREE_ITEM_RIGHT_CLICK) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_ITEM_RIGHT_CLICK(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_ITEM_RIGHT_CLICK]) + '';

    If trim(EVT_TREE_ITEM_MIDDLE_CLICK) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_ITEM_MIDDLE_CLICK(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_ITEM_MIDDLE_CLICK]) + '';

    If trim(EVT_TREE_SEL_CHANGED) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_SEL_CHANGED(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_SEL_CHANGED]) + '';

    If trim(EVT_TREE_SEL_CHANGING) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_SEL_CHANGING(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_SEL_CHANGING]) + '';

    If trim(EVT_TREE_KEY_DOWN) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_KEY_DOWN(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_KEY_DOWN]) + '';

    If trim(EVT_TREE_ITEM_MENU) <> '' Then
        Result := Result + #13 + Format('EVT_TREE_ITEM_MENU(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TREE_ITEM_MENU]) + '';

    If trim(EVT_UPDATE_UI) <> '' Then
        Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

End;

Function TWxTreeListCtrl.GenerateXRCControlCreation(IndentString: String): TStringList;
Begin

    Result := TStringList.Create;
    Try
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

    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetTreeViewSpecificStyle(Wx_GeneralStyle, Wx_TreeListviewStyle)]));
    Result.Add(IndentString + '</object>');}
    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxTreeListCtrl.GenerateGUIControlCreation: String;
Var
    strColorStr: String;
    strStyle, parentName, strAlignment: String;
    i: Integer;
Begin
    Result := '';

    If FWx_PaneCaption = '' Then
        FWx_PaneCaption := Self.Name;
    If FWx_PaneName = '' Then
        FWx_PaneName := Self.Name + '_Pane';

    parentName := GetWxWidgetParent(self, Wx_AuiManaged);

    strStyle := GetTreeViewSpecificStyle(Wx_GeneralStyle, Wx_TreeListviewStyle);
    If Trim(strStyle) <> '' Then
        strStyle := ',' + strStyle;

    Result := GetCommentString(self.FWx_Comments.Text) +
        Format('%s = new %s(%s, %s, %s, %s%s);',
        [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
        self.Wx_IDValue),
        GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);

    If (XRCGEN) Then
    Begin//generate xrc loading code
//xrc unknown used so we are inserting our control into the unknown container. (a panel)
        Result := Result + #13 + Format('wxXmlResource::Get()->AttachUnknownControl(%s("%s"), (wxWindow*)%s, (wxWindow*)%s);',
            [StringFormat, self.Name, self.Name, parentName]);
    End;

    If trim(self.Wx_ToolTip) <> '' Then
        Result := Result + #13 + Format('%s->SetToolTip(%s);',
            [self.Name, GetCppString(self.Wx_ToolTip)]);

    If self.Wx_Hidden Then
        Result := Result + #13 + Format('%s->Show(false);', [self.Name]);

    If Not Wx_Enabled Then
        Result := Result + #13 + Format('%s->Enable(false);', [self.Name]);

    If trim(self.Wx_HelpText) <> '' Then
        Result := Result + #13 + Format('%s->SetHelpText(%s);',
            [self.Name, GetCppString(self.Wx_HelpText)]);
    For i := self.columns.Count - 1 Downto 0 Do
    Begin
        If (i = self.columns.Count - 1) Then
            Result := Result + #13 + Format('%s->AddColumn(%s, %d, %s);', [self.Name, GetCppString(self.columns[i].Caption), self.columns[i].Width, TLAlignmentToStr(columns[i].Alignment)])
        Else
            Result := Result + #13 + Format('%s->InsertColumn(0, %s, %d, %s);', [self.Name, GetCppString(self.columns[i].Caption), self.columns[i].Width, TLAlignmentToStr(columns[i].Alignment)]);
    End;

    strColorStr := trim(GetwxColorFromString(InvisibleFGColorString));
    If strColorStr <> '' Then
        Result := Result + #13 + Format('%s->SetForegroundColour(%s);',
            [self.Name, strColorStr]);

    strColorStr := trim(GetwxColorFromString(InvisibleBGColorString));
    If strColorStr <> '' Then
        Result := Result + #13 + Format('%s->SetBackgroundColour(%s);',
            [self.Name, strColorStr]);


    strColorStr := GetWxFontDeclaration(self.Font);
    If strColorStr <> '' Then
        Result := Result + #13 + Format('%s->SetFont(%s);', [self.Name, strColorStr]);
    If Not (XRCGEN) Then //NUKLEAR ZELPH
    Begin
        If (Wx_AuiManaged And FormHasAuiManager(self)) And Not (self.Parent Is TWxSizerPanel) Then
        Begin
            If HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) Then
            Begin
                Self.Wx_Aui_Pane_Style := Self.Wx_Aui_Pane_Style + [ToolbarPane]; //always make sure we are a toolbar
                Self.Wx_Layer := 10;
            End;

            If Not HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) Then
            Begin
                If (self.Parent.ClassName = 'TWxPanel') Then
                    If Not (self.Parent.Parent Is TForm) Then
                        Result := Result + #13 + Format('%s->Reparent(this);', [parentName]);
            End;

            If (self.Parent Is TWxAuiToolBar) Then
                Result := Result + #13 + Format('%s->AddControl(%s);',
                    [self.Parent.Name, self.Name])
            Else
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

        End
        Else
        Begin
            If (self.Parent Is TWxSizerPanel) Then
            Begin
                strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
                Result := Result + #13 + Format('%s->Add(%s, %d, %s, %d);',
                    [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
                    self.Wx_Border]);
            End;

            If (self.Parent Is TWxAuiNotebookPage) Then
            Begin
        //        strParentLabel := TWxAuiNoteBookPage(Self.Parent).Caption;
                Result := Result + #13 + Format('%s->AddPage(%s, %s);',
          //          [self.Parent.Parent.Name, self.Name, GetCppString(strParentLabel)]);
                    [self.Parent.Parent.Name, self.Name, GetCppString(TWxAuiNoteBookPage(Self.Parent).Caption)]);
            End;

            If (self.Parent Is TWxAuiToolBar) Then
                Result := Result + #13 + Format('%s->AddControl(%s);',
                    [self.Parent.Name, self.Name]);
        End;
    End;

End;

Function TWxTreeListCtrl.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
End;

Function TWxTreeListCtrl.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := Wx_Include;
End;

Function TWxTreeListCtrl.GenerateImageInclude: String;
Begin

End;

Function TWxTreeListCtrl.GetEventList: TStringList;
Begin
    Result := FWx_EventList;
End;

Function TWxTreeListCtrl.GetIDName: String;
Begin
    Result := wx_IDName;
End;

Function TWxTreeListCtrl.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxTreeListCtrl.GetParameterFromEventName(EventName: String): String;
Begin
    Result := 'void';

    If EventName = 'EVT_TREE_BEGIN_DRAG' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;
    If EventName = 'EVT_TREE_BEGIN_RDRAG' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;
    If EventName = 'EVT_TREE_END_DRAG' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;
    If EventName = 'EVT_TREE_BEGIN_LABEL_EDIT' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;
    If EventName = 'EVT_TREE_END_LABEL_EDIT' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;
    If EventName = 'EVT_TREE_DELETE_ITEM' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;

    If EventName = 'EVT_TREE_ITEM_ACTIVATED' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;

    If EventName = 'EVT_TREE_COLLAPSED' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;
    If EventName = 'EVT_TREE_COLLAPSING' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;

    If EventName = 'EVT_TREE_EXPANDED' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;
    If EventName = 'EVT_TREE_EXPANDING' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;

    If EventName = 'EVT_TREE_ITEM_RIGHT_CLICK' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;

    If EventName = 'EVT_TREE_ITEM_MIDDLE_CLICK' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;

    If EventName = 'EVT_TREE_SEL_CHANGED' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;
    If EventName = 'EVT_TREE_SEL_CHANGING' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;

    If EventName = 'EVT_TREE_KEY_DOWN' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;

    If EventName = 'EVT_TREE_ITEM_MENU' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;

    If EventName = 'EVT_UPDATE_UI' Then
    Begin
        Result := 'wxUpdateUIEvent& event';
        exit;
    End;
End;

Function TWxTreeListCtrl.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxTreeListCtrl.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxTreeListCtrl.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxTreeListCtrl.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxTreeListCtrl.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxTreeListCtrl.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxTreeListCtrl.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxTreeListCtrl.GetWxClassName: String;
Begin
    If wx_Class = '' Then
        wx_Class := 'wxTreeListCtrl';
    Result := wx_Class;
End;

Procedure TWxTreeListCtrl.Loaded;
Begin
    Inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

End;

Procedure TWxTreeListCtrl.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxTreeListCtrl.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxTreeListCtrl.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxTreeListCtrl.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxTreeListCtrl.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxTreeListCtrl.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxTreeListCtrl.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxTreeListCtrl.GetFGColor: String;
Begin
    Result := FInvisibleFGColorString;
End;

Procedure TWxTreeListCtrl.SetFGColor(strValue: String);
Begin
    FInvisibleFGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Font.Color := defaultFGColor
    Else
        self.Font.Color := GetColorFromString(strValue);
End;

Function TWxTreeListCtrl.GetBGColor: String;
Begin
    Result := FInvisibleBGColorString;
End;

Procedure TWxTreeListCtrl.SetBGColor(strValue: String);
Begin
    FInvisibleBGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Color := defaultBGColor
    Else
        self.Color := GetColorFromString(strValue);
End;

Procedure TWxTreeListCtrl.SetProxyFGColorString(Value: String);
Begin
    FInvisibleFGColorString := Value;
    self.Color := GetColorFromString(Value);
End;

Procedure TWxTreeListCtrl.SetProxyBGColorString(Value: String);
Begin
    FInvisibleBGColorString := Value;
    self.Font.Color := GetColorFromString(Value);
End;

Function TWxTreeListCtrl.TLAlignmentToStr(taPos: TAlignment): String;
Begin
    Result := '';
    Case taPos Of
        taLeftJustify:
            Result := 'wxALIGN_LEFT';
        taRightJustify:
            Result := 'wxALIGN_RIGHT';
        taCenter:
            Result := 'wxALIGN_CENTER';
    End; // case
End;

End.
