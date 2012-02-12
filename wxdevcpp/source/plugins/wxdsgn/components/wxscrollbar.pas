 { ****************************************************************** }
 {                                                                    }
{ $Id: wxscrollbar.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
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

Unit WxScrollBar;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, StdCtrls, WxUtils, ExtCtrls, WxAuiToolBar, WxAuiNotebookPage, WxSizerPanel, UValidator;

Type
//  TWxScrollBar = class(TScrollBar, IWxComponentInterface, IWxStatusBarInterface)
    TWxScrollBar = Class(TScrollBar, IWxComponentInterface, IWxValidatorInterface)
    Private
    { Private fields of TWxScrollBar }

    { Storage for property EVT_COMMAND_SCROLL }
        FEVT_COMMAND_SCROLL: String;
    { Storage for property EVT_COMMAND_SCROLL_TOP }
        FEVT_COMMAND_SCROLL_TOP: String;
    { Storage for property EVT_COMMAND_SCROLL_BOTTOM }
        FEVT_COMMAND_SCROLL_BOTTOM: String;
    { Storage for property EVT_COMMAND_SCROLL_LINEUP }
        FEVT_COMMAND_SCROLL_LINEUP: String;
    { Storage for property EVT_COMMAND_SCROLL_LINEDOWN }
        FEVT_COMMAND_SCROLL_LINEDOWN: String;
    { Storage for property EVT_COMMAND_SCROLL_PAGEUP }
        FEVT_COMMAND_SCROLL_PAGEUP: String;
    { Storage for property EVT_COMMAND_SCROLL_PAGEDOWN }
        FEVT_COMMAND_SCROLL_PAGEDOWN: String;
    { Storage for property EVT_COMMAND_SCROLL_THUMBTRACK }
        FEVT_COMMAND_SCROLL_THUMBTRACK: String;
    { Storage for property EVT_COMMAND_SCROLL_THUMBRELEASE }
        FEVT_COMMAND_SCROLL_THUMBRELEASE: String;
    { Storage for property EVT_COMMAND_SCROLL_ENDSCROLL }
        FEVT_COMMAND_SCROLL_ENDSCROLL: String;
    { Storage for property EVT_SCROLLBAR }
        FEVT_SCROLLBAR: String;
    { Storage for property EVT_UPDATE_UI }
        FEVT_UPDATE_UI: String;
    { Storage for property Wx_Border }
        FWx_Border: Integer;
    { Storage for property Wx_Class }
        FWx_Class: String;
    { Storage for property Wx_ControlOrientation }
        FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_Enabled }
        FWx_Enabled: Boolean;
    { Storage for property Wx_GeneralStyle }
        FWx_GeneralStyle: TWxStdStyleSet;
    { Storage for property Wx_HelpText }
        FWx_HelpText: String;
    { Storage for property Wx_Hidden }
        FWx_Hidden: Boolean;
        FWx_Validator: String;
        FWx_ProxyValidatorString: TWxValidatorString;
        FWx_Comments: TStrings;
    { Storage for property Wx_IDName }
        FWx_IDName: String;
    { Storage for property Wx_IDValue }
        FWx_IDValue: Integer;
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
        FWx_SBOrientation: TWx_SBOrientation;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;

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

    { Private methods of TWxScrollBar }
    { Method to set variable and property values and create objects }
        Procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
        Procedure AutoDestroy;

    Protected
    { Protected fields of TWxScrollBar }

    { Protected methods of TWxScrollBar }
        Procedure Click; Override;
        Procedure KeyPress(Var Key: Char); Override;
        Procedure Loaded; Override;

    Public
    { Public fields and properties of TWxScrollBar }
        defaultBGColor: TColor;
        defaultFGColor: TColor;
    { Public methods of TWxScrollBar }
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
        Function GetSBOrientation(Wx_SBOrientation: TWx_SBOrientation): String;

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
    { Published properties of TWxScrollBar }
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
        Property EVT_COMMAND_SCROLL: String Read FEVT_COMMAND_SCROLL Write FEVT_COMMAND_SCROLL;
        Property EVT_COMMAND_SCROLL_TOP: String Read FEVT_COMMAND_SCROLL_TOP Write FEVT_COMMAND_SCROLL_TOP;
        Property EVT_COMMAND_SCROLL_BOTTOM: String Read FEVT_COMMAND_SCROLL_BOTTOM Write FEVT_COMMAND_SCROLL_BOTTOM;
        Property EVT_COMMAND_SCROLL_LINEUP: String Read FEVT_COMMAND_SCROLL_LINEUP Write FEVT_COMMAND_SCROLL_LINEUP;
        Property EVT_COMMAND_SCROLL_LINEDOWN: String Read FEVT_COMMAND_SCROLL_LINEDOWN Write FEVT_COMMAND_SCROLL_LINEDOWN;
        Property EVT_COMMAND_SCROLL_PAGEUP: String Read FEVT_COMMAND_SCROLL_PAGEUP Write FEVT_COMMAND_SCROLL_PAGEUP;
        Property EVT_COMMAND_SCROLL_PAGEDOWN: String Read FEVT_COMMAND_SCROLL_PAGEDOWN Write FEVT_COMMAND_SCROLL_PAGEDOWN;
        Property EVT_COMMAND_SCROLL_THUMBTRACK: String Read FEVT_COMMAND_SCROLL_THUMBTRACK Write FEVT_COMMAND_SCROLL_THUMBTRACK;
        Property EVT_COMMAND_SCROLL_THUMBRELEASE: String Read FEVT_COMMAND_SCROLL_THUMBRELEASE Write FEVT_COMMAND_SCROLL_THUMBRELEASE;
        Property EVT_COMMAND_SCROLL_ENDSCROLL: String Read FEVT_COMMAND_SCROLL_ENDSCROLL Write FEVT_COMMAND_SCROLL_ENDSCROLL;
        Property EVT_SCROLLBAR: String Read FEVT_SCROLLBAR Write FEVT_SCROLLBAR;
        Property EVT_UPDATE_UI: String Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_Validator: String Read FWx_Validator Write FWx_Validator;
        Property Wx_ProxyValidatorString: TWxValidatorString Read GetValidatorString Write SetValidatorString;

        Property Wx_ControlOrientation: TWxControlOrientation
            Read FWx_ControlOrientation Write FWx_ControlOrientation;
        Property Wx_Enabled: Boolean Read FWx_Enabled Write FWx_Enabled Default True;
        Property Wx_GeneralStyle: TWxStdStyleSet
            Read FWx_GeneralStyle Write FWx_GeneralStyle;
        Property Wx_HelpText: String Read FWx_HelpText Write FWx_HelpText;
        Property Wx_Hidden: Boolean Read FWx_Hidden Write FWx_Hidden;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue Default -1;
        Property Wx_ToolTip: String Read FWx_ToolTip Write FWx_ToolTip;
        Property Wx_SBOrientation: TWx_SBOrientation
            Read FWx_SBOrientation Write FWx_SBOrientation;

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
     { Register TWxScrollBar with wxWidgets as its
       default page on the Delphi component palette }
    RegisterComponents('wxWidgets', [TWxScrollBar]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxScrollBar.AutoInitialize;
Begin
    FWx_Comments := TStringList.Create;
    FWx_EventList := TStringList.Create;
    FWx_PropertyList := TStringList.Create;
    FWx_Border := 5;
    FWx_Class := 'wxScrollBar';
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_IDValue := -1;
    FWx_StretchFactor := 0;
    FWx_ProxyBGColorString := TWxColorString.Create;
    FWx_ProxyFGColorString := TWxColorString.Create;
    defaultBGColor := self.color;
    defaultFGColor := self.font.color;
    FWx_ProxyValidatorString := TwxValidatorString.Create(self);

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxScrollBar.AutoDestroy;
Begin
    FWx_EventList.Destroy;
    FWx_PropertyList.Destroy;
    FWx_ProxyBGColorString.Destroy;
    FWx_ProxyFGColorString.Destroy;
    FWx_Comments.Destroy;
    FWx_ProxyValidatorString.Destroy;

End; { of AutoDestroy }

{ Override OnClick handler from TScrollBar,IWxComponentInterface }
Procedure TWxScrollBar.Click;
Begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
    Inherited Click;

     { Code to execute after click behavior
       of parent }

End;

{ Override OnKeyPress handler from TScrollBar,IWxComponentInterface }
Procedure TWxScrollBar.KeyPress(Var Key: Char);
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

Constructor TWxScrollBar.Create(AOwner: TComponent);
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
    FWx_PropertyList.add('Wx_SBOrientation:Orientation');
    PopulateAuiGenericProperties(FWx_PropertyList);

    FWx_EventList.add('EVT_SCROLLBAR : OnScrollbar');
    FWx_EventList.add('EVT_COMMAND_SCROLL   :  OnScroll');
    FWx_EventList.add('EVT_COMMAND_SCROLL_TOP   :  OnScrollTop');
    FWx_EventList.add('EVT_COMMAND_SCROLL_BOTTOM   :  OnScrollBottom');
    FWx_EventList.add('EVT_COMMAND_SCROLL_LINEUP   :  OnScrollLineUp');
    FWx_EventList.add('EVT_COMMAND_SCROLL_LINEDOWN   :  OnScrollLineDown');
    FWx_EventList.add('EVT_COMMAND_SCROLL_PAGEUP   :  OnScrollPageUp');
    FWx_EventList.add('EVT_COMMAND_SCROLL_PAGEDOWN   :  OnScrollPageDown');
    FWx_EventList.add('EVT_COMMAND_SCROLL_THUMBTRACK   :  OnScrollThumbtrack');
    FWx_EventList.add('EVT_COMMAND_SCROLL_THUMBRELEASE   :  OnScrollThumbRelease');
    FWx_EventList.add('EVT_COMMAND_SCROLL_ENDSCROLL   :  OnScrollEnd');
    FWx_EventList.add('EVT_UPDATE_UI   :  OnUpdateUI');

End;

Destructor TWxScrollBar.Destroy;
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


Function TWxScrollBar.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxScrollBar.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
End;

Function TWxScrollBar.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';

    If (XRCGEN) Then
    Begin
        If trim(EVT_SCROLLBAR) <> '' Then
            Result := Format('EVT_SCROLLBAR(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_SCROLLBAR]) + '';

        If trim(EVT_COMMAND_SCROLL) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_COMMAND_SCROLL]) + '';

        If trim(EVT_COMMAND_SCROLL_TOP) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_TOP(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_COMMAND_SCROLL_TOP]) + '';

        If trim(EVT_COMMAND_SCROLL_BOTTOM) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_BOTTOM(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_COMMAND_SCROLL_BOTTOM]) + '';

        If trim(EVT_COMMAND_SCROLL_LINEUP) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_LINEUP(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_COMMAND_SCROLL_LINEUP]) + '';

        If trim(EVT_COMMAND_SCROLL_LINEDOWN) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_LINEDOWN(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_COMMAND_SCROLL_LINEDOWN]) + '';

        If trim(EVT_COMMAND_SCROLL_PAGEUP) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_PAGEUP(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_COMMAND_SCROLL_PAGEUP]) + '';

        If trim(EVT_COMMAND_SCROLL_PAGEDOWN) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_PAGEDOWN(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_COMMAND_SCROLL_PAGEDOWN]) + '';

        If trim(EVT_COMMAND_SCROLL_THUMBTRACK) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_THUMBTRACK(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_COMMAND_SCROLL_THUMBTRACK]) + '';

        If trim(EVT_COMMAND_SCROLL_THUMBRELEASE) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_THUMBRELEASE(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_COMMAND_SCROLL_THUMBRELEASE]) + '';

        If trim(EVT_COMMAND_SCROLL_ENDSCROLL) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_ENDSCROLL(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_COMMAND_SCROLL_ENDSCROLL]) + '';

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
    End
    Else
    Begin
        If trim(EVT_SCROLLBAR) <> '' Then
            Result := Format('EVT_SCROLLBAR(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_SCROLLBAR]) + '';

        If trim(EVT_COMMAND_SCROLL) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL]) + '';

        If trim(EVT_COMMAND_SCROLL_TOP) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_TOP(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_TOP]) + '';

        If trim(EVT_COMMAND_SCROLL_BOTTOM) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_BOTTOM(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_BOTTOM]) + '';

        If trim(EVT_COMMAND_SCROLL_LINEUP) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_LINEUP(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_LINEUP]) + '';

        If trim(EVT_COMMAND_SCROLL_LINEDOWN) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_LINEDOWN(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_LINEDOWN]) + '';

        If trim(EVT_COMMAND_SCROLL_PAGEUP) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_PAGEUP(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_PAGEUP]) + '';

        If trim(EVT_COMMAND_SCROLL_PAGEDOWN) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_PAGEDOWN(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_PAGEDOWN]) + '';

        If trim(EVT_COMMAND_SCROLL_THUMBTRACK) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_THUMBTRACK(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_THUMBTRACK]) + '';

        If trim(EVT_COMMAND_SCROLL_THUMBRELEASE) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_THUMBRELEASE(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_THUMBRELEASE]) + '';

        If trim(EVT_COMMAND_SCROLL_ENDSCROLL) <> '' Then
            Result := Result + #13 + Format('EVT_COMMAND_SCROLL_ENDSCROLL(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_ENDSCROLL]) + '';

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
    End;

End;

Function TWxScrollBar.GenerateXRCControlCreation(IndentString: String): TStringList;
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

    //Result.Add(IndentString + Format('  <value>%d</value>', [self.Position]));
    //Result.Add(IndentString + Format('  <range>%d</range>', [self.Max]));

        Result.Add(IndentString + Format('  <style>%s</style>',
            [GetStdStyleString(self.Wx_GeneralStyle)]));
        Result.Add(IndentString + Format('  <orient>%s</orient>',
            [GetSBOrientation(self.Wx_SBOrientation)]));

    // Result.Add(IndentString + Format('  <value>%d</value>', [);

        Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxScrollBar.GenerateGUIControlCreation: String;
Var
    strColorStr: String;
    strStyle, parentName, strAlignment: String;
Begin
    Result := '';

    If FWx_PaneCaption = '' Then
        FWx_PaneCaption := Self.Name;
    If FWx_PaneName = '' Then
        FWx_PaneName := Self.Name + '_Pane';

    parentName := GetWxWidgetParent(self, Wx_AuiManaged);

    strStyle := GetStdStyleString(self.Wx_GeneralStyle);
    If (trim(strStyle) <> '') Then
        strStyle := ' | ' + strStyle;

    strStyle := ', ' + GetSBOrientation(self.Wx_SBOrientation) + strStyle;

    If trim(Wx_ProxyValidatorString.strValidatorValue) <> '' Then
    Begin
        If trim(strStyle) <> '' Then
            strStyle := strStyle + ', ' + Wx_ProxyValidatorString.strValidatorValue
        Else
            strStyle := ', wxSB_HORIZONTAL, ' + Wx_ProxyValidatorString.strValidatorValue;

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
            Format('%s = new %s(%s, %s, %s, %s%s);',
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

Function TWxScrollBar.GenerateGUIControlDeclaration: String;
Begin
    Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
End;

Function TWxScrollBar.GenerateHeaderInclude: String;
Begin
    Result := '#include <wx/scrolbar.h>';
End;

Function TWxScrollBar.GenerateImageInclude: String;
Begin

End;

Function TWxScrollBar.GetEventList: TStringList;
Begin
    Result := FWx_EventList;
End;

Function TWxScrollBar.GetIDName: String;
Begin
    Result := wx_IDName;
End;

Function TWxScrollBar.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxScrollBar.GetParameterFromEventName(EventName: String): String;
Begin
    If EventName = 'EVT_SCROLLBAR' Then
    Begin
        Result := 'wxCommandEvent& event';
        exit;
    End;
    If EventName = 'EVT_COMMAND_SCROLL' Then
    Begin
        Result := 'wxScrollEvent& event';
        exit;
    End;
    If EventName = 'EVT_COMMAND_SCROLL_TOP' Then
    Begin
        Result := 'wxScrollEvent& event';
        exit;
    End;
    If EventName = 'EVT_COMMAND_SCROLL_BOTTOM' Then
    Begin
        Result := 'wxScrollEvent& event';
        exit;
    End;
    If EventName = 'EVT_COMMAND_SCROLL_LINEUP' Then
    Begin
        Result := 'wxScrollEvent& event';
        exit;
    End;
    If EventName = 'EVT_COMMAND_SCROLL_LINEDOWN' Then
    Begin
        Result := 'wxScrollEvent& event';
        exit;
    End;
    If EventName = 'EVT_COMMAND_SCROLL_PAGEUP' Then
    Begin
        Result := 'wxScrollEvent& event';
        exit;
    End;
    If EventName = 'EVT_COMMAND_SCROLL_PAGEDOWN' Then
    Begin
        Result := 'wxScrollEvent& event';
        exit;
    End;
    If EventName = 'EVT_COMMAND_SCROLL_THUMBTRACK' Then
    Begin
        Result := 'wxScrollEvent& event';
        exit;
    End;
    If EventName = 'EVT_COMMAND_SCROLL_THUMBRELEASE' Then
    Begin
        Result := 'wxScrollEvent& event';
        exit;
    End;
    If EventName = 'EVT_COMMAND_SCROLL_ENDSCROLL' Then
    Begin
        Result := 'wxScrollEvent& event';
        exit;
    End;
    If EventName = 'EVT_UPDATE_UI' Then
    Begin
        Result := 'wxUpdateUIEvent& event';
        exit;
    End;
End;

Function TWxScrollBar.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxScrollBar.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxScrollBar.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxScrollBar.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxScrollBar.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxScrollBar.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxScrollBar.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxScrollBar.GetWxClassName: String;
Begin
    If wx_Class = '' Then
        wx_Class := 'wxScrollBar';
    Result := wx_Class;
End;

Procedure TWxScrollBar.Loaded;
Begin
    Inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

End;

Procedure TWxScrollBar.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxScrollBar.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxScrollBar.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxScrollBar.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxScrollBar.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxScrollBar.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxScrollBar.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxScrollBar.GetFGColor: String;
Begin
    Result := FInvisibleFGColorString;
End;

Procedure TWxScrollBar.SetFGColor(strValue: String);
Begin
    FInvisibleFGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Font.Color := defaultFGColor
    Else
        self.Font.Color := GetColorFromString(strValue);
End;

Function TWxScrollBar.GetBGColor: String;
Begin
    Result := FInvisibleBGColorString;
End;

Procedure TWxScrollBar.SetBGColor(strValue: String);
Begin
    FInvisibleBGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Color := defaultBGColor
    Else
        self.Color := GetColorFromString(strValue);
End;

Procedure TWxScrollBar.SetProxyFGColorString(Value: String);
Begin
    FInvisibleFGColorString := Value;
    self.Color := GetColorFromString(Value);
End;

Procedure TWxScrollBar.SetProxyBGColorString(Value: String);
Begin
    FInvisibleBGColorString := Value;
    self.Font.Color := GetColorFromString(Value);
End;

Function TWxScrollBar.GetSBOrientation(Wx_SBOrientation: TWx_SBOrientation): String;
Begin
    Result := '';
    If Wx_SBOrientation = wxSB_VERTICAL Then
    Begin
        Result := 'wxSB_VERTICAL';
        self.Kind := sbVertical;
    End;
    If Wx_SBOrientation = wxSB_HORIZONTAL Then
    Begin
        Result := 'wxSB_HORIZONTAL';
        self.Kind := sbHorizontal;
    End;

End;

Function TWxScrollBar.GetValidatorString: TWxValidatorString;
Begin
    Result := FWx_ProxyValidatorString;
    Result.FstrValidatorValue := Wx_Validator;
End;

Procedure TWxScrollBar.SetValidatorString(Value: TWxValidatorString);
Begin
    FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
    Wx_Validator := Value.FstrValidatorValue;
End;

Function TWxScrollBar.GetValidator: String;
Begin
    Result := Wx_Validator;
End;

Procedure TWxScrollBar.SetValidator(value: String);
Begin
    Wx_Validator := value;
End;
End.
