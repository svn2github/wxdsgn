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


Unit WxTreeCtrl;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, ComCtrls, WxUtils, ExtCtrls, WxAuiToolBar, WxSizerPanel, WxAuiNotebookPage, UValidator;

Type
    TWxTreeCtrl = Class(TTreeView, IWxComponentInterface, IWxValidatorInterface)
    Private
    { Private fields of TWxTreeCtrl }
        FEVT_TREE_BEGIN_DRAG: String;
        FEVT_TREE_BEGIN_RDRAG: String;
        FEVT_TREE_END_DRAG: String;
        FEVT_TREE_BEGIN_LABEL_EDIT: String;
        FEVT_TREE_END_LABEL_EDIT: String;
        FEVT_TREE_DELETE_ITEM: String;
        FEVT_TREE_GET_INFO: String;
        FEVT_TREE_SET_INFO: String;
        FEVT_TREE_ITEM_ACTIVATED: String;
        FEVT_TREE_ITEM_COLLAPSED: String;
        FEVT_TREE_ITEM_COLLAPSING: String;
        FEVT_TREE_ITEM_EXPANDED: String;
        FEVT_TREE_ITEM_EXPANDING: String;
        FEVT_TREE_ITEM_RIGHT_CLICK: String;
        FEVT_TREE_ITEM_MIDDLE_CLICK: String;
        FEVT_TREE_SEL_CHANGED: String;
        FEVT_TREE_SEL_CHANGING: String;
        FEVT_TREE_KEY_DOWN: String;
        FEVT_TREE_ITEM_GETTOOLTIP: String;
        FEVT_TREE_ITEM_MENU: String;
        FEVT_TREE_STATE_IMAGE_CLICK: String;
        FEVT_UPDATE_UI: String;
        FWx_BGColor: TColor;
        FWx_Border: Integer;
        FWx_Class: String;
        FWx_ControlOrientation: TWxControlOrientation;
        FWx_Enabled: Boolean;
        FWx_FGColor: TColor;
        FWx_GeneralStyle: TWxStdStyleSet;
        FWx_HelpText: String;
        FWx_Hidden: Boolean;
        FWx_IDName: String;
        FWx_IDValue: Integer;
        FWx_ProxyBGColorString: TWxColorString;
        FWx_ProxyFGColorString: TWxColorString;
        FWx_StretchFactor: Integer;
        FWx_ToolTip: String;
        FWx_TreeviewStyle: TWxTVStyleSet;
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

    { Private methods of TWxTreeCtrl }
        Procedure AutoInitialize;
        Procedure AutoDestroy;

    Protected
    { Protected fields of TWxTreeCtrl }

    { Protected methods of TWxTreeCtrl }
        Procedure Click; Override;
        Procedure KeyPress(Var Key: Char); Override;
        Procedure Loaded; Override;

    Public
    { Public fields and properties of TWxTreeCtrl }
        defaultBGColor: TColor;
        defaultFGColor: TColor;
    { Public methods of TWxTreeCtrl }
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

        Function GetValidator: String;
        Procedure SetValidator(value: String);
        Function GetValidatorString: TWxValidatorString;
        Procedure SetValidatorString(Value: TWxValidatorString);

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

    Published
    { Published properties of TWxTreeCtrl }
        Property OnClick;
        Property OnDblClick;
        Property OnDragDrop;
        Property OnEnter;
        Property OnExit;
        Property OnKeyDown;
        Property OnKeyPress;
        Property OnKeyUp;
        Property OnMouseDown;
        Property OnMouseMove;
        Property OnMouseUp;
    //The first Event will be the default to get created when the user double clicks it
        Property EVT_TREE_ITEM_ACTIVATED: String Read FEVT_TREE_ITEM_ACTIVATED Write FEVT_TREE_ITEM_ACTIVATED;
        Property EVT_TREE_BEGIN_DRAG: String Read FEVT_TREE_BEGIN_DRAG Write FEVT_TREE_BEGIN_DRAG;
        Property EVT_TREE_BEGIN_RDRAG: String Read FEVT_TREE_BEGIN_RDRAG Write FEVT_TREE_BEGIN_RDRAG;
        Property EVT_TREE_END_DRAG: String Read FEVT_TREE_END_DRAG Write FEVT_TREE_END_DRAG;
        Property EVT_TREE_BEGIN_LABEL_EDIT: String Read FEVT_TREE_BEGIN_LABEL_EDIT Write FEVT_TREE_BEGIN_LABEL_EDIT;
        Property EVT_TREE_END_LABEL_EDIT: String Read FEVT_TREE_END_LABEL_EDIT Write FEVT_TREE_END_LABEL_EDIT;
        Property EVT_TREE_DELETE_ITEM: String Read FEVT_TREE_DELETE_ITEM Write FEVT_TREE_DELETE_ITEM;
        Property EVT_TREE_GET_INFO: String Read FEVT_TREE_GET_INFO Write FEVT_TREE_GET_INFO;
        Property EVT_TREE_SET_INFO: String Read FEVT_TREE_SET_INFO Write FEVT_TREE_SET_INFO;
        Property EVT_TREE_ITEM_COLLAPSED: String Read FEVT_TREE_ITEM_COLLAPSED Write FEVT_TREE_ITEM_COLLAPSED;
        Property EVT_TREE_ITEM_COLLAPSING: String Read FEVT_TREE_ITEM_COLLAPSING Write FEVT_TREE_ITEM_COLLAPSING;
        Property EVT_TREE_ITEM_EXPANDED: String Read FEVT_TREE_ITEM_EXPANDED Write FEVT_TREE_ITEM_EXPANDED;
        Property EVT_TREE_ITEM_EXPANDING: String Read FEVT_TREE_ITEM_EXPANDING Write FEVT_TREE_ITEM_EXPANDING;
        Property EVT_TREE_ITEM_RIGHT_CLICK: String Read FEVT_TREE_ITEM_RIGHT_CLICK Write FEVT_TREE_ITEM_RIGHT_CLICK;
        Property EVT_TREE_ITEM_MIDDLE_CLICK: String Read FEVT_TREE_ITEM_MIDDLE_CLICK Write FEVT_TREE_ITEM_MIDDLE_CLICK;
        Property EVT_TREE_SEL_CHANGED: String Read FEVT_TREE_SEL_CHANGED Write FEVT_TREE_SEL_CHANGED;
        Property EVT_TREE_SEL_CHANGING: String Read FEVT_TREE_SEL_CHANGING Write FEVT_TREE_SEL_CHANGING;
        Property EVT_TREE_KEY_DOWN: String Read FEVT_TREE_KEY_DOWN Write FEVT_TREE_KEY_DOWN;
        Property EVT_TREE_ITEM_GETTOOLTIP: String Read FEVT_TREE_ITEM_GETTOOLTIP Write FEVT_TREE_ITEM_GETTOOLTIP;
        Property EVT_TREE_ITEM_MENU: String Read FEVT_TREE_ITEM_MENU Write FEVT_TREE_ITEM_MENU;
        Property EVT_TREE_STATE_IMAGE_CLICK: String Read FEVT_TREE_STATE_IMAGE_CLICK Write FEVT_TREE_STATE_IMAGE_CLICK;
        Property EVT_UPDATE_UI: String Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
        Property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_ControlOrientation: TWxControlOrientation
            Read FWx_ControlOrientation Write FWx_ControlOrientation;

        Property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
        Property Wx_GeneralStyle: TWxStdStyleSet
            Read FWx_GeneralStyle Write FWx_GeneralStyle;
        Property Wx_HelpText: String Read FWx_HelpText Write FWx_HelpText;
        Property Wx_Hidden: Boolean Read FWx_Hidden Write FWx_Hidden;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue Default -1;
        Property Wx_Enabled: Boolean Read FWx_Enabled Write FWx_Enabled Default True;
        Property Wx_ToolTip: String Read FWx_ToolTip Write FWx_ToolTip;
        Property Wx_TreeviewStyle: TWxTVStyleSet Read FWx_TreeviewStyle Write FWx_TreeviewStyle;

        Property Wx_Validator: String Read FWx_Validator Write FWx_Validator;
        Property Wx_ProxyValidatorString: TWxValidatorString Read GetValidatorString Write SetValidatorString;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;

        Property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
        Property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
        Property InvisibleBGColorString: String Read FInvisibleBGColorString Write FInvisibleBGColorString;
        Property InvisibleFGColorString: String Read FInvisibleFGColorString Write FInvisibleFGColorString;

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
     { Register TWxTreeCtrl with Win95 as its
       default page on the Delphi component palette }
    RegisterComponents('Win95', [TWxTreeCtrl]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxTreeCtrl.AutoInitialize;
Begin
    FWx_EventList := TStringList.Create;
    FWx_PropertyList := TStringList.Create;
    FWx_Border := 5;
    FWx_Class := 'wxTreeCtrl';
    FWx_Enabled := True;
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_IDValue := -1;
    FWx_StretchFactor := 0;
    FWx_ProxyBGColorString := TWxColorString.Create;
    FWx_ProxyFGColorString := TWxColorString.Create;
    defaultBGColor := self.color;
    defaultFGColor := self.font.color;
    FWx_TreeviewStyle := [wxTR_HAS_BUTTONS, wxTR_LINES_AT_ROOT, wxTR_HIDE_ROOT];
    FWx_Comments := TStringList.Create;
    FWx_ProxyValidatorString := TwxValidatorString.Create(self);

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxTreeCtrl.AutoDestroy;
Begin
    FWx_EventList.Destroy;
    FWx_PropertyList.Destroy;
    FWx_ProxyBGColorString.Destroy;
    FWx_ProxyFGColorString.Destroy;
    FWx_Comments.Destroy;
    FWx_ProxyValidatorString.Destroy;

End; { of AutoDestroy }

{ Override OnClick handler from TTreeView,IWxComponentInterface }
Procedure TWxTreeCtrl.Click;
Begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
    Inherited Click;

     { Code to execute after click behavior
       of parent }

End;

{ Override OnKeyPress handler from TTreeView,IWxComponentInterface }
Procedure TWxTreeCtrl.KeyPress(Var Key: Char);
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

Constructor TWxTreeCtrl.Create(AOwner: TComponent);
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

End;

Destructor TWxTreeCtrl.Destroy;
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

Function TWxTreeCtrl.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxTreeCtrl.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s  %d ', [Wx_IDName, Wx_IDValue]);
End;


Function TWxTreeCtrl.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';

    If (XRCGEN) Then
    Begin
        If trim(EVT_TREE_BEGIN_DRAG) <> '' Then
            Result := Format('EVT_TREE_BEGIN_DRAG(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_BEGIN_DRAG]) + '';

        If trim(EVT_TREE_BEGIN_RDRAG) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_BEGIN_RDRAG(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_BEGIN_RDRAG]) + '';

        If trim(EVT_TREE_END_DRAG) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_END_DRAG(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_END_DRAG]) + '';

        If trim(EVT_TREE_BEGIN_LABEL_EDIT) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_BEGIN_LABEL_EDIT(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_BEGIN_LABEL_EDIT]) + '';

        If trim(EVT_TREE_END_LABEL_EDIT) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_END_LABEL_EDIT(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_END_LABEL_EDIT]) + '';

        If trim(EVT_TREE_DELETE_ITEM) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_DELETE_ITEM(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_DELETE_ITEM]) + '';

        If trim(EVT_TREE_GET_INFO) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_GET_INFO(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_GET_INFO]) + '';

        If trim(EVT_TREE_SET_INFO) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_SET_INFO(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_SET_INFO]) + '';

        If trim(EVT_TREE_ITEM_ACTIVATED) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_ITEM_ACTIVATED(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_ACTIVATED]) + '';

        If trim(EVT_TREE_ITEM_COLLAPSED) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_ITEM_COLLAPSED(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_COLLAPSED]) + '';

        If trim(EVT_TREE_ITEM_COLLAPSING) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_ITEM_COLLAPSING(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_COLLAPSING]) + '';

        If trim(EVT_TREE_ITEM_EXPANDED) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_ITEM_EXPANDED(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_EXPANDED]) + '';

        If trim(EVT_TREE_ITEM_EXPANDING) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_ITEM_EXPANDING(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_EXPANDING]) + '';

        If trim(EVT_TREE_ITEM_RIGHT_CLICK) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_ITEM_RIGHT_CLICK(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_RIGHT_CLICK]) + '';

        If trim(EVT_TREE_ITEM_MIDDLE_CLICK) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_ITEM_MIDDLE_CLICK(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_MIDDLE_CLICK]) + '';

        If trim(EVT_TREE_SEL_CHANGED) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_SEL_CHANGED(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_SEL_CHANGED]) + '';

        If trim(EVT_TREE_SEL_CHANGING) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_SEL_CHANGING(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_SEL_CHANGING]) + '';

        If trim(EVT_TREE_KEY_DOWN) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_KEY_DOWN(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_KEY_DOWN]) + '';

        If trim(EVT_TREE_ITEM_GETTOOLTIP) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_ITEM_GETTOOLTIP(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_GETTOOLTIP]) + '';

        If trim(EVT_TREE_ITEM_MENU) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_ITEM_MENU(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_ITEM_MENU]) + '';

        If trim(EVT_TREE_STATE_IMAGE_CLICK) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_STATE_IMAGE_CLICK(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TREE_STATE_IMAGE_CLICK]) + '';

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
    End
    Else
    Begin
        If trim(EVT_TREE_BEGIN_DRAG) <> '' Then
            Result := Format('EVT_TREE_BEGIN_DRAG(%s,%s::%s)',
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

        If trim(EVT_TREE_GET_INFO) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_GET_INFO(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_TREE_GET_INFO]) + '';

        If trim(EVT_TREE_SET_INFO) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_SET_INFO(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_TREE_SET_INFO]) + '';

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

        If trim(EVT_TREE_ITEM_GETTOOLTIP) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_ITEM_GETTOOLTIP(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_TREE_ITEM_GETTOOLTIP]) + '';

        If trim(EVT_TREE_ITEM_MENU) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_ITEM_MENU(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_TREE_ITEM_MENU]) + '';

        If trim(EVT_TREE_STATE_IMAGE_CLICK) <> '' Then
            Result := Result + #13 + Format('EVT_TREE_STATE_IMAGE_CLICK(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_TREE_STATE_IMAGE_CLICK]) + '';

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
    End;

End;

Function TWxTreeCtrl.GenerateXRCControlCreation(IndentString: String): TStringList;
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
            [GetTreeViewSpecificStyle(self.Wx_GeneralStyle, Wx_TreeviewStyle)]));
        Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxTreeCtrl.GenerateGUIControlCreation: String;
Var
    strColorStr: String;
    strStyle, parentName, strAlignment: String;
    strParentNodeID, strNodeID: String;
    index, indexLevel, lastLevel: Integer;
Begin
    Result := '';

    If FWx_PaneCaption = '' Then
        FWx_PaneCaption := Self.Name;
    If FWx_PaneName = '' Then
        FWx_PaneName := Self.Name + '_Pane';

    parentName := GetWxWidgetParent(self, Wx_AuiManaged);

    strStyle := GetTreeViewSpecificStyle(self.Wx_GeneralStyle, Wx_TreeviewStyle);

    If trim(Wx_ProxyValidatorString.strValidatorValue) <> '' Then
    Begin
        If trim(strStyle) <> '' Then
            strStyle := ', ' + strStyle + ', ' + Wx_ProxyValidatorString.strValidatorValue
        Else
            strStyle := ', 0, ' + Wx_ProxyValidatorString.strValidatorValue;

        strStyle := strStyle + ', ' + GetCppString(Name);

    End
    Else
    If trim(strStyle) <> '' Then
        strStyle := ', ' + strStyle + ', wxDefaultValidator, ' + GetCppString(Name)
    Else
        strStyle := ', 0, wxDefaultValidator, ' + GetCppString(Name);


    If (XRCGEN) Then
    Begin//generate xrc loading code
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
            [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);
    End
    Else
    Begin
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = new %s(%s, %s, %s, %s%s);',
            [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
            self.Wx_IDValue),
            GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);
    End;

    If trim(self.Wx_ToolTip) <> '' Then
        Result := Result + #13 + Format('%s->SetToolTip(%s);',
            [self.Name, GetCppString(Wx_ToolTip)]);

    If self.Wx_Hidden Then
        Result := Result + #13 + Format('%s->Show(false);', [self.Name]);

    If Not Wx_Enabled Then
        Result := Result + #13 + Format('%s->Enable(false);', [self.Name]);

    If trim(self.Wx_HelpText) <> '' Then
        Result := Result + #13 + Format('%s->SetHelpText(%s);',
            [self.Name, GetCppString(Wx_HelpText)]);

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

    // Do we have items for the tree?
    If (Items.Count > 0) Then
    Begin
        strParentNodeID := self.Name + 'NodeID'; // Variable name for ID of item

        // wxTreeCtrl can only have 1 root. In order to get it to look like
        //   Delphi's TTreeView we need to hide the root and draw the root lines
        //   We'll create a blank root and top level items will go on the first
        //   level of the wxTreeCtrl.
        Result := Result + #13 + Format('wxTreeItemId %s = %s->AddRoot(%s);',
            [strParentNodeID, self.Name, GetCppString('')]);

        //  Place the first item under the strParentNodeID (the root ID)
        Result := Result + #13 + Format('%s = %s->AppendItem(%s, %s);',
            [strParentNodeID, self.Name, strParentNodeID, GetCppString(Items[index].Text)]);
        lastLevel := Items[0].Level;
    End
    Else
        strParentNodeID := '';

  // TTreeView (TTreeNodes) is always indexed going down the first child first
  //   We'll take advantage of this indexing to write the wxWidgets code.
    For index := 1 To (Items.Count - 1) Do
    Begin

        strNodeID := strParentNodeID;  // ID for the item

     // If the item is on the same level as the last one, then we need
     //  to refer to the last node ID's parent. If it is on a higher level
     //   (i.e. smaller number), then we need to wrap more GetItemParent
     //   calls to keep going up the tree branch to the correct ID.
        If (lastLevel >= Items[index].Level) Then
        Begin

            For indexLevel := Items[index].Level To lastLevel Do
                strNodeID := self.Name + '->GetItemParent(' + strNodeID + ')';
        End;

        lastLevel := Items[index].Level;

        Result := Result + #13 + Format('%s = %s->AppendItem(%s, %s);',
            [strParentNodeID, self.Name, strNodeID, GetCppString(Items[index].Text)]);

    End;

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

Function TWxTreeCtrl.GenerateGUIControlDeclaration: String;
Begin
    Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
End;

Function TWxTreeCtrl.GenerateHeaderInclude: String;
Begin
    Result := '#include <wx/treectrl.h>';
End;

Function TWxTreeCtrl.GenerateImageInclude: String;
Begin

End;

Function TWxTreeCtrl.GetEventList: TStringList;
Begin
    Result := FWx_EventList;
End;

Function TWxTreeCtrl.GetIDName: String;
Begin
    Result := wx_IDName;
End;

Function TWxTreeCtrl.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxTreeCtrl.GetParameterFromEventName(EventName: String): String;
Begin
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
    If EventName = 'EVT_TREE_GET_INFO' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;
    If EventName = 'EVT_TREE_SET_INFO' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;
    If EventName = 'EVT_TREE_ITEM_ACTIVATED' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;
    If EventName = 'EVT_TREE_ITEM_COLLAPSED' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;
    If EventName = 'EVT_TREE_ITEM_COLLAPSING' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;
    If EventName = 'EVT_TREE_ITEM_EXPANDED' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;
    If EventName = 'EVT_TREE_ITEM_EXPANDING' Then
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
    If EventName = 'EVT_TREE_ITEM_GETTOOLTIP' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;
    If EventName = 'EVT_TREE_ITEM_MENU' Then
    Begin
        Result := 'wxTreeEvent& event';
        exit;
    End;
    If EventName = 'EVT_TREE_STATE_IMAGE_CLICK' Then
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

Function TWxTreeCtrl.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxTreeCtrl.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxTreeCtrl.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxTreeCtrl.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxTreeCtrl.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxTreeCtrl.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxTreeCtrl.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxTreeCtrl.GetWxClassName: String;
Begin
    If wx_Class = '' Then
        wx_Class := 'wxTreeCtrl';
    Result := wx_Class;
End;

Procedure TWxTreeCtrl.Loaded;
Begin
    Inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

End;

Procedure TWxTreeCtrl.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxTreeCtrl.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxTreeCtrl.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxTreeCtrl.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxTreeCtrl.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxTreeCtrl.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxTreeCtrl.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxTreeCtrl.GetFGColor: String;
Begin
    Result := FInvisibleFGColorString;
End;

Procedure TWxTreeCtrl.SetFGColor(strValue: String);
Begin
    FInvisibleFGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Font.Color := defaultFGColor
    Else
        self.Font.Color := GetColorFromString(strValue);
End;

Function TWxTreeCtrl.GetBGColor: String;
Begin
    Result := FInvisibleBGColorString;
End;

Procedure TWxTreeCtrl.SetBGColor(strValue: String);
Begin
    FInvisibleBGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Color := defaultBGColor
    Else
        self.Color := GetColorFromString(strValue);
End;

Procedure TWxTreeCtrl.SetProxyFGColorString(Value: String);
Begin
    FInvisibleFGColorString := Value;
    self.Color := GetColorFromString(Value);
End;

Procedure TWxTreeCtrl.SetProxyBGColorString(Value: String);
Begin
    FInvisibleBGColorString := Value;
    self.Font.Color := GetColorFromString(Value);
End;

Function TWxTreeCtrl.GetValidatorString: TWxValidatorString;
Begin
    Result := FWx_ProxyValidatorString;
    Result.FstrValidatorValue := Wx_Validator;
End;

Procedure TWxTreeCtrl.SetValidatorString(Value: TWxValidatorString);
Begin
    FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
    Wx_Validator := Value.FstrValidatorValue;
End;

Function TWxTreeCtrl.GetValidator: String;
Begin
    Result := Wx_Validator;
End;

Procedure TWxTreeCtrl.SetValidator(value: String);
Begin
    Wx_Validator := value;
End;

End.
