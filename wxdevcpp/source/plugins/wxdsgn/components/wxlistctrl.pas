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

Unit Wxlistctrl;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, ComCtrls, WxUtils, ExtCtrls, WxAuiToolBar, WxSizerPanel, WxAuiNotebookPage, UValidator;

Type
    TWxListCtrl = Class(TListView, IWxComponentInterface, IWxValidatorInterface)
    Private
    { Private fields of TWxListCtrl }
    { Storage for property EVT_LIST_BEGIN_DRAG }
        FEVT_LIST_BEGIN_DRAG: String;
    { Storage for property EVT_LIST_BEGIN_LABEL_EDIT }
        FEVT_LIST_BEGIN_LABEL_EDIT: String;
    { Storage for property EVT_LIST_BEGIN_RDRAG }
        FEVT_LIST_BEGIN_RDRAG: String;
    { Storage for property EVT_LIST_CACHE_HINT }
        FEVT_LIST_CACHE_HINT: String;
    { Storage for property EVT_LIST_COL_BEGIN_DRAG }
        FEVT_LIST_COL_BEGIN_DRAG: String;
    { Storage for property EVT_LIST_COL_CLICK }
        FEVT_LIST_COL_CLICK: String;
    { Storage for property EVT_LIST_COL_DRAGGING }
        FEVT_LIST_COL_DRAGGING: String;
    { Storage for property EVT_LIST_COL_END_DRAG }
        FEVT_LIST_COL_END_DRAG: String;
    { Storage for property EVT_LIST_COL_RIGHT_CLICK }
        FEVT_LIST_COL_RIGHT_CLICK: String;
    { Storage for property EVT_LIST_DELETE_ALL_ITEMS }
        FEVT_LIST_DELETE_ALL_ITEMS: String;
    { Storage for property EVT_LIST_DELETE_ITEM }
        FEVT_LIST_DELETE_ITEM: String;
    { Storage for property EVT_LIST_END_LABEL_EDIT }
        FEVT_LIST_END_LABEL_EDIT: String;
    { Storage for property EVT_LIST_INSERT_ITEM }
        FEVT_LIST_INSERT_ITEM: String;
    { Storage for property EVT_LIST_ITEM_ACTIVATED }
        FEVT_LIST_ITEM_ACTIVATED: String;
    { Storage for property EVT_LIST_ITEM_DESELECTED }
        FEVT_LIST_ITEM_DESELECTED: String;
    { Storage for property EVT_LIST_ITEM_FOCUSED }
        FEVT_LIST_ITEM_FOCUSED: String;
    { Storage for property EVT_LIST_ITEM_MIDDLE_CLICK }
        FEVT_LIST_ITEM_MIDDLE_CLICK: String;
    { Storage for property EVT_LIST_ITEM_RIGHT_CLICK }
        FEVT_LIST_ITEM_RIGHT_CLICK: String;
    { Storage for property EVT_LIST_ITEM_SELECTED }
        FEVT_LIST_ITEM_SELECTED: String;
    { Storage for property EVT_LIST_KEY_DOWN }
        FEVT_LIST_KEY_DOWN: String;
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
        FWx_ListviewView: TWxLvView;
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

        FWx_Validator: String;
        FWx_ProxyValidatorString: TWxValidatorString;

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

    { Private methods of TWxListCtrl }
    { Method to set variable and property values and create objects }
        Procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
        Procedure AutoDestroy;
    { Write method for property Wx_ListviewStyle }
        Procedure SetWx_ListviewStyle(Value: TWxLVStyleSet);
    { Write method for property Wx_ListviewView }
        Procedure SetWx_ListviewView(Value: TWxLvView);

    Protected
    { Protected fields of TWxListCtrl }

    { Protected methods of TWxListCtrl }
        Procedure KeyPress(Var Key: Char); Override;
        Procedure Loaded; Override;

    Public
    { Public fields and properties of TWxListCtrl }
        defaultBGColor: TColor;
        defaultFGColor: TColor;
    { Public methods of TWxListCtrl }
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

        Function GetValidator: String;
        Procedure SetValidator(value: String);
        Function GetValidatorString: TWxValidatorString;
        Procedure SetValidatorString(Value: TWxValidatorString);

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

    Published
    { Published properties of TWxListCtrl }
        Property OnKeyDown;
        Property OnKeyPress;
        Property OnKeyUp;
        Property EVT_LIST_ITEM_ACTIVATED: String
            Read FEVT_LIST_ITEM_ACTIVATED Write FEVT_LIST_ITEM_ACTIVATED;
        Property EVT_LIST_BEGIN_DRAG: String Read FEVT_LIST_BEGIN_DRAG
            Write FEVT_LIST_BEGIN_DRAG;
        Property EVT_LIST_BEGIN_LABEL_EDIT: String
            Read FEVT_LIST_BEGIN_LABEL_EDIT Write FEVT_LIST_BEGIN_LABEL_EDIT;
        Property EVT_LIST_BEGIN_RDRAG: String Read FEVT_LIST_BEGIN_RDRAG
            Write FEVT_LIST_BEGIN_RDRAG;
        Property EVT_LIST_CACHE_HINT: String Read FEVT_LIST_CACHE_HINT
            Write FEVT_LIST_CACHE_HINT;
        Property EVT_LIST_COL_BEGIN_DRAG: String
            Read FEVT_LIST_COL_BEGIN_DRAG Write FEVT_LIST_COL_BEGIN_DRAG;
        Property EVT_LIST_COL_CLICK: String Read FEVT_LIST_COL_CLICK
            Write FEVT_LIST_COL_CLICK;
        Property EVT_LIST_COL_DRAGGING: String
            Read FEVT_LIST_COL_DRAGGING Write FEVT_LIST_COL_DRAGGING;
        Property EVT_LIST_COL_END_DRAG: String
            Read FEVT_LIST_COL_END_DRAG Write FEVT_LIST_COL_END_DRAG;
        Property EVT_LIST_COL_RIGHT_CLICK: String
            Read FEVT_LIST_COL_RIGHT_CLICK Write FEVT_LIST_COL_RIGHT_CLICK;
        Property EVT_LIST_DELETE_ALL_ITEMS: String
            Read FEVT_LIST_DELETE_ALL_ITEMS Write FEVT_LIST_DELETE_ALL_ITEMS;
        Property EVT_LIST_DELETE_ITEM: String Read FEVT_LIST_DELETE_ITEM
            Write FEVT_LIST_DELETE_ITEM;
        Property EVT_LIST_END_LABEL_EDIT: String
            Read FEVT_LIST_END_LABEL_EDIT Write FEVT_LIST_END_LABEL_EDIT;
        Property EVT_LIST_INSERT_ITEM: String Read FEVT_LIST_INSERT_ITEM
            Write FEVT_LIST_INSERT_ITEM;
        Property EVT_LIST_ITEM_DESELECTED: String
            Read FEVT_LIST_ITEM_DESELECTED Write FEVT_LIST_ITEM_DESELECTED;
        Property EVT_LIST_ITEM_FOCUSED: String
            Read FEVT_LIST_ITEM_FOCUSED Write FEVT_LIST_ITEM_FOCUSED;
        Property EVT_LIST_ITEM_MIDDLE_CLICK: String
            Read FEVT_LIST_ITEM_MIDDLE_CLICK Write FEVT_LIST_ITEM_MIDDLE_CLICK;
        Property EVT_LIST_ITEM_RIGHT_CLICK: String
            Read FEVT_LIST_ITEM_RIGHT_CLICK Write FEVT_LIST_ITEM_RIGHT_CLICK;
        Property EVT_LIST_ITEM_SELECTED: String
            Read FEVT_LIST_ITEM_SELECTED Write FEVT_LIST_ITEM_SELECTED;
        Property EVT_LIST_KEY_DOWN: String Read FEVT_LIST_KEY_DOWN Write FEVT_LIST_KEY_DOWN;
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
        Property Wx_ListviewStyle: TWxLVStyleSet Read FWx_ListviewStyle Write SetWx_ListviewStyle;
        Property Wx_ListviewView: TWxLvView Read FWx_ListviewView Write SetWx_ListviewView;
        Property Wx_ToolTip: String Read FWx_ToolTip Write FWx_ToolTip;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;

        Property InvisibleBGColorString: String Read FInvisibleBGColorString Write FInvisibleBGColorString;
        Property InvisibleFGColorString: String Read FInvisibleFGColorString Write FInvisibleFGColorString;
        Property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
        Property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;

        Property Wx_Validator: String Read FWx_Validator Write FWx_Validator;
        Property Wx_ProxyValidatorString: TWxValidatorString Read GetValidatorString Write SetValidatorString;

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
     { Register TWxListCtrl with wxWidgets as its
       default page on the Delphi component palette }
    RegisterComponents('wxWidgets', [TWxListCtrl]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxListCtrl.AutoInitialize;
Begin
    ViewStyle := vsReport;
    FWx_ListviewView := wxLC_REPORT;
    FWx_ListviewStyle := [];
    FWx_EventList := TStringList.Create;
    FWx_PropertyList := TStringList.Create;
    FWx_Border := 5;
    FWx_Class := 'wxListCtrl';
    FWx_Enabled := True;
    FWx_Hidden := False;
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_IDValue := -1;
    FWx_StretchFactor := 0;
    FWx_ProxyBGColorString := TWxColorString.Create;
    FWx_ProxyFGColorString := TWxColorString.Create;
    defaultBGColor := self.color;
    defaultFGColor := self.font.color;
    FWx_Comments := TStringList.Create;
    FWx_ProxyValidatorString := TwxValidatorString.Create(self);

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxListCtrl.AutoDestroy;
Begin
    FWx_EventList.Destroy;
    FWx_PropertyList.Destroy;
    FWx_Comments.Destroy;
    FWx_ProxyBGColorString.Destroy;
    FWx_ProxyFGColorString.Destroy;
    FWx_ProxyValidatorString.Destroy;

End; { of AutoDestroy }

{ Write method for property Wx_ListviewStyle }
Procedure TWxListCtrl.SetWx_ListviewStyle(Value: TWxLVStyleSet);
Begin
  //Save the value
    FWx_ListviewStyle := Value;

  //Apply some styles that we said we would include
    If wxLC_NO_HEADER In FWx_ListviewStyle Then
        self.ShowColumnHeaders := False
    Else
        self.ShowColumnHeaders := True;
End;

{ Write method for property Wx_ListviewView }
Procedure TWxListCtrl.SetWx_ListviewView(Value: TWxLvView);
Begin
    FWx_ListviewView := Value;

  //Apply the view to our control
    Case FWx_ListviewView Of
        wxLC_LIST:
            ViewStyle := vsList;
        wxLC_REPORT, wxLC_VIRTUAL:
            ViewStyle := vsReport;
        wxLC_ICON:
            ViewStyle := vsIcon;
        wxLC_SMALL_ICON:
            ViewStyle := vsSmallIcon;
    End;
End;

{ Override OnKeyPress handler from TListView,IWxComponentInterface }
Procedure TWxListCtrl.KeyPress(Var Key: Char);
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

Constructor TWxListCtrl.Create(AOwner: TComponent);
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
End;

Destructor TWxListCtrl.Destroy;
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


Function TWxListCtrl.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxListCtrl.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
End;

Function TWxListCtrl.GenerateEventTableEntries(CurrClassName: String): String;
Begin

    Result := '';

    If (XRCGEN) Then
    Begin
        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';

        If trim(EVT_LIST_ITEM_SELECTED) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_ITEM_SELECTED(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_ITEM_SELECTED]) + '';


        If trim(EVT_LIST_ITEM_DESELECTED) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_ITEM_DESELECTED(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_ITEM_DESELECTED]) + '';

        If trim(EVT_LIST_BEGIN_DRAG) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_BEGIN_DRAG(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_BEGIN_DRAG]) + '';

        If trim(EVT_LIST_BEGIN_RDRAG) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_BEGIN_RDRAG(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_BEGIN_RDRAG]) + '';

        If trim(EVT_LIST_BEGIN_LABEL_EDIT) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_BEGIN_LABEL_EDIT(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_BEGIN_LABEL_EDIT]) + '';

        If trim(EVT_LIST_END_LABEL_EDIT) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_END_LABEL_EDIT(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_END_LABEL_EDIT]) + '';

        If trim(EVT_LIST_DELETE_ITEM) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_DELETE_ITEM(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_DELETE_ITEM]) + '';

        If trim(EVT_LIST_DELETE_ALL_ITEMS) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_DELETE_ALL_ITEMS(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_DELETE_ALL_ITEMS]) + '';

        If trim(EVT_LIST_ITEM_ACTIVATED) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_ITEM_ACTIVATED(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_ITEM_ACTIVATED]) + '';


        If trim(EVT_LIST_ITEM_FOCUSED) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_ITEM_FOCUSED(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_ITEM_FOCUSED]) + '';

        If trim(EVT_LIST_ITEM_MIDDLE_CLICK) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_ITEM_MIDDLE_CLICK(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_ITEM_MIDDLE_CLICK]) + '';


        If trim(EVT_LIST_ITEM_RIGHT_CLICK) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_ITEM_RIGHT_CLICK(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_ITEM_RIGHT_CLICK]) + '';

        If trim(EVT_LIST_KEY_DOWN) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_KEY_DOWN(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_KEY_DOWN]) + '';


        If trim(EVT_LIST_INSERT_ITEM) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_INSERT_ITEM(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_INSERT_ITEM]) + '';

        If trim(EVT_LIST_COL_CLICK) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_COL_CLICK(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_COL_CLICK]) + '';

        If trim(EVT_LIST_COL_RIGHT_CLICK) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_COL_RIGHT_CLICK(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_COL_RIGHT_CLICK]) + '';

        If trim(EVT_LIST_COL_BEGIN_DRAG) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_COL_BEGIN_DRAG(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_COL_BEGIN_DRAG]) + '';

        If trim(EVT_LIST_COL_DRAGGING) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_COL_DRAGGING(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_COL_DRAGGING]) + '';

        If trim(EVT_LIST_COL_END_DRAG) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_COL_END_DRAG(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_COL_END_DRAG]) + '';

        If trim(EVT_LIST_CACHE_HINT) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_CACHE_HINT(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_LIST_CACHE_HINT]) + '';

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
    End
    Else
    Begin
        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Format('EVT_UPDATE_UI(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

        If trim(EVT_LIST_ITEM_SELECTED) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_ITEM_SELECTED(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_ITEM_SELECTED]) + '';


        If trim(EVT_LIST_ITEM_DESELECTED) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_ITEM_DESELECTED(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_ITEM_DESELECTED]) + '';

        If trim(EVT_LIST_BEGIN_DRAG) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_BEGIN_DRAG(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_BEGIN_DRAG]) + '';

        If trim(EVT_LIST_BEGIN_RDRAG) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_BEGIN_RDRAG(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_BEGIN_RDRAG]) + '';

        If trim(EVT_LIST_BEGIN_LABEL_EDIT) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_BEGIN_LABEL_EDIT(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_BEGIN_LABEL_EDIT]) + '';

        If trim(EVT_LIST_END_LABEL_EDIT) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_END_LABEL_EDIT(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_END_LABEL_EDIT]) + '';

        If trim(EVT_LIST_DELETE_ITEM) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_DELETE_ITEM(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_DELETE_ITEM]) + '';

        If trim(EVT_LIST_DELETE_ALL_ITEMS) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_DELETE_ALL_ITEMS(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_DELETE_ALL_ITEMS]) + '';

        If trim(EVT_LIST_ITEM_ACTIVATED) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_ITEM_ACTIVATED(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_ITEM_ACTIVATED]) + '';


        If trim(EVT_LIST_ITEM_FOCUSED) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_ITEM_FOCUSED(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_ITEM_FOCUSED]) + '';

        If trim(EVT_LIST_ITEM_MIDDLE_CLICK) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_ITEM_MIDDLE_CLICK(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_ITEM_MIDDLE_CLICK]) + '';


        If trim(EVT_LIST_ITEM_RIGHT_CLICK) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_ITEM_RIGHT_CLICK(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_ITEM_RIGHT_CLICK]) + '';

        If trim(EVT_LIST_KEY_DOWN) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_KEY_DOWN(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_KEY_DOWN]) + '';


        If trim(EVT_LIST_INSERT_ITEM) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_INSERT_ITEM(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_INSERT_ITEM]) + '';

        If trim(EVT_LIST_COL_CLICK) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_COL_CLICK(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_COL_CLICK]) + '';

        If trim(EVT_LIST_COL_RIGHT_CLICK) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_COL_RIGHT_CLICK(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_COL_RIGHT_CLICK]) + '';

        If trim(EVT_LIST_COL_BEGIN_DRAG) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_COL_BEGIN_DRAG(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_COL_BEGIN_DRAG]) + '';

        If trim(EVT_LIST_COL_DRAGGING) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_COL_DRAGGING(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_COL_DRAGGING]) + '';

        If trim(EVT_LIST_COL_END_DRAG) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_COL_END_DRAG(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_COL_END_DRAG]) + '';

        If trim(EVT_LIST_CACHE_HINT) <> '' Then
            Result := Result + #13 + Format('EVT_LIST_CACHE_HINT(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_LIST_CACHE_HINT]) + '';

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
    End;

End;

Function TWxListCtrl.GenerateXRCControlCreation(IndentString: String): TStringList;
Begin

    Result := TStringList.Create;
    Try
        Result.Add(IndentString + Format('<object class="%s" name="%s">',
            [self.Wx_Class, self.Name]));
        Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
        Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));

        If Not (UseDefaultSize) Then
            Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
        If Not (UseDefaultPos) Then
            Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

	       Result.Add(IndentString + Format('  <style>%s</style>',
            [GetListViewSpecificStyle(Wx_GeneralStyle, Wx_ListviewStyle, FWx_ListviewView)]));
        Result.Add(IndentString + '</object>');
    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxListCtrl.GenerateGUIControlCreation: String;
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

    strStyle := GetListViewSpecificStyle(Wx_GeneralStyle, Wx_ListviewStyle, FWx_ListviewView);

    If trim(Wx_ProxyValidatorString.strValidatorValue) <> '' Then
    Begin
        If trim(strStyle) <> '' Then
            strStyle := strStyle + ', ' + Wx_ProxyValidatorString.strValidatorValue
        Else
            strStyle := ', 0, ' + Wx_ProxyValidatorString.strValidatorValue;

        strStyle := strStyle + ', ' + GetCppString(Name);

    End
    Else
    If trim(strStyle) <> '' Then
        strStyle := strStyle + ', wxDefaultValidator, ' + GetCppString(Name)
    Else
        strStyle := ', 0, wxDefaultValidator, ' + GetCppString(Name);
    If (XRCGEN) Then
    Begin
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
            [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);
    End
    Else
    Begin
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = new %s(%s, %s, %s, %s, %s);',
            [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
            self.Wx_IDValue),
            GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);
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
    For i := 0 To self.columns.Count - 1 Do
        Result := Result + #13 + Format('%s->InsertColumn(%d, %s, %s, %d);',
            [self.Name, i, GetCppString(self.columns[i].Caption), AlignmentToStr(
            columns[i].Alignment), self.columns[i].Width]);

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

Function TWxListCtrl.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
End;

Function TWxListCtrl.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/listctrl.h>';
End;

Function TWxListCtrl.GenerateImageInclude: String;
Begin

End;

Function TWxListCtrl.GetEventList: TStringList;
Begin
    Result := FWx_EventList;
End;

Function TWxListCtrl.GetIDName: String;
Begin
    Result := wx_IDName;
End;

Function TWxListCtrl.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxListCtrl.GetParameterFromEventName(EventName: String): String;
Begin
    Result := 'void';
    If EventName = 'EVT_LIST_ITEM_SELECTED' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_ITEM_DESELECTED' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_BEGIN_DRAG' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_BEGIN_RDRAG' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_BEGIN_LABEL_EDIT' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_END_LABEL_EDIT' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_DELETE_ITEM' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_DELETE_ALL_ITEMS' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_ITEM_ACTIVATED' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_ITEM_FOCUSED' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_ITEM_MIDDLE_CLICK' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_ITEM_RIGHT_CLICK' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_KEY_DOWN' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_INSERT_ITEM' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_COL_CLICK' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_COL_RIGHT_CLICK' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_COL_BEGIN_DRAG' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_COL_DRAGGING' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_COL_END_DRAG' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_LIST_CACHE_HINT' Then
    Begin
        Result := 'wxListEvent& event';
        exit;
    End;
    If EventName = 'EVT_UPDATE_UI' Then
    Begin
        Result := 'wxUpdateUIEvent& event';
        exit;
    End;
End;

Function TWxListCtrl.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxListCtrl.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxListCtrl.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxListCtrl.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxListCtrl.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxListCtrl.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxListCtrl.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxListCtrl.GetWxClassName: String;
Begin
    If wx_Class = '' Then
        wx_Class := 'wxListCtrl';
    Result := wx_Class;
End;

Procedure TWxListCtrl.Loaded;
Begin
    Inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

End;

Procedure TWxListCtrl.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxListCtrl.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxListCtrl.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxListCtrl.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxListCtrl.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxListCtrl.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxListCtrl.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxListCtrl.GetFGColor: String;
Begin
    Result := FInvisibleFGColorString;
End;

Procedure TWxListCtrl.SetFGColor(strValue: String);
Begin
    FInvisibleFGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Font.Color := defaultFGColor
    Else
        self.Font.Color := GetColorFromString(strValue);
End;

Function TWxListCtrl.GetBGColor: String;
Begin
    Result := FInvisibleBGColorString;
End;

Procedure TWxListCtrl.SetBGColor(strValue: String);
Begin
    FInvisibleBGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Color := defaultBGColor
    Else
        self.Color := GetColorFromString(strValue);
End;

Procedure TWxListCtrl.SetProxyFGColorString(Value: String);
Begin
    FInvisibleFGColorString := Value;
    self.Color := GetColorFromString(Value);
End;

Procedure TWxListCtrl.SetProxyBGColorString(Value: String);
Begin
    FInvisibleBGColorString := Value;
    self.Font.Color := GetColorFromString(Value);
End;

Function TWxListCtrl.GetValidatorString: TWxValidatorString;
Begin
    Result := FWx_ProxyValidatorString;
    Result.FstrValidatorValue := Wx_Validator;
End;

Procedure TWxListCtrl.SetValidatorString(Value: TWxValidatorString);
Begin
    FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
    Wx_Validator := Value.FstrValidatorValue;
End;

Function TWxListCtrl.GetValidator: String;
Begin
    Result := Wx_Validator;
End;

Procedure TWxListCtrl.SetValidator(value: String);
Begin
    Wx_Validator := value;
End;

End.
