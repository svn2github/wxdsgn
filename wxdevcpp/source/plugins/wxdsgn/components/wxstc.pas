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

Unit WxStc;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, StdCtrls, Wxutils, ExtCtrls, WxSizerPanel, Dialogs, WxAuiNotebookPage, wxAuiToolBar,
    xprocs;

Type
    TWxStyledTextCtrl = Class(TMemo, IWxComponentInterface, IWxVariableAssignmentInterface)
    Private
    { Private fields of TWxStyledTextCtrl }
    { Storage for property EVT_TEXT }
        FEVT_TEXT: String;
    { Storage for property EVT_TEXT_ENTER }
        FEVT_TEXT_ENTER: String;
    { Storage for property EVT_TEXT_MAXLEN }
        FEVT_TEXT_MAXLEN: String;
    { Storage for property EVT_TEXT_URL }
        FEVT_TEXT_URL: String;
    { Storage for property EVT_UPDATE_UI }
        FEVT_UPDATE_UI: String;

        FEVT_STC_CALLTIP_CLICK: String;
        FEVT_STC_CHANGE: String;
        FEVT_STC_CHARADDED: String;
        FEVT_STC_DO_DROP: String;
        FEVT_STC_DOUBLECLICK: String;
        FEVT_STC_DRAG_OVER: String;
        FEVT_STC_DWELLEND: String;
        FEVT_STC_DWELLSTART: String;
        FEVT_STC_HOTSPOT_CLICK: String;
        FEVT_STC_HOTSPOT_DCLICK: String;
        FEVT_STC_KEY: String;
        FEVT_STC_MACRORECORD: String;
        FEVT_STC_MARGINCLICK: String;
        FEVT_STC_MODIFIED: String;
        FEVT_STC_NEEDSHOWN: String;
        FEVT_STC_PAINTED: String;
        FEVT_STC_ROMODIFYATTEMPT: String;
        FEVT_STC_SAVEPOINTLEFT: String;
        FEVT_STC_SAVEPOINTREACHED: String;
        FEVT_STC_START_DRAG: String;
        FEVT_STC_STYLENEEDED: String;
        FEVT_STC_UPDATEUI: String;
        FEVT_STC_URIDROPPED: String;
        FEVT_STC_USERLISTSELECTION: String;
        FEVT_STC_ZOOM: String;
        FEVT_STC_AUTOCOMP_SELECTION: String;

    { Storage for property Wx_BGColor }
        FWx_BGColor: TColor;
    { Storage for property Wx_Border }
        FWx_Border: Integer;
    { Storage for property Wx_Class }
        FWx_Class: String;
    { Storage for property Wx_ControlOrientation }
        FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_EditStyle }
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
    { Storage for property Wx_ProxyBGColorString }
        FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
        FWx_ProxyFGColorString: TWxColorString;
    { Storage for property Wx_StretchFactor }
        FWx_StretchFactor: Integer;
    { Storage for property Wx_ToolTip }
        FWx_ToolTip: String;
        FWx_MaxLength: Integer;
        FWx_Comments: TStrings;
        FWx_LoadFromFile: TWxFileNameString;
        FWx_FiletoLoad: String;
        FWx_EventList: TStringList;
        FWx_PropertyList: TStringList;
        FInvisibleBGColorString: String;
        FInvisibleFGColorString: String;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;
        FWx_LHSValue: String;
        FWx_RHSValue: String;

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

    { Private methods of TWxStyledTextCtrl }
    { Method to set variable and property values and create objects }
        Procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
        Procedure AutoDestroy;
    { Write method for property Wx_ToolTip }
        Procedure SetWx_ToolTip(Value: String);

    Protected
    { Protected fields of TWxStyledTextCtrl }

    { Protected methods of TWxStyledTextCtrl }
        Procedure Click; Override;
        Procedure KeyPress(Var Key: Char); Override;
        Procedure Loaded; Override;

    Public
    { Public fields and properties of TWxStyledTextCtrl }
        defaultBGColor: TColor;
        defaultFGColor: TColor;
    { Public methods of TWxStyledTextCtrl }
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
        Procedure SetWxFileName(wxFileName: String);
        Function GetFGColor: String;
        Procedure SetFGColor(strValue: String);

        Function GetBGColor: String;
        Procedure SetBGColor(strValue: String);

        Function GetGenericColor(strVariableName: String): String;
        Procedure SetGenericColor(strVariableName, strValue: String);

        Procedure SetProxyFGColorString(Value: String);
        Procedure SetProxyBGColorString(Value: String);
        Function GetLHSVariableAssignment: String;
        Function GetRHSVariableAssignment: String;

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

    Published
    { Published properties of TWxStyledTextCtrl }
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
        Property EVT_TEXT: String Read FEVT_TEXT Write FEVT_TEXT;
        Property EVT_TEXT_ENTER: String Read FEVT_TEXT_ENTER Write FEVT_TEXT_ENTER;
        Property EVT_TEXT_MAXLEN: String Read FEVT_TEXT_MAXLEN Write FEVT_TEXT_MAXLEN;
        Property EVT_TEXT_URL: String Read FEVT_TEXT_URL Write FEVT_TEXT_URL;
        Property EVT_UPDATE_UI: String Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;

        Property EVT_STC_CALLTIP_CLICK: String Read FEVT_STC_CALLTIP_CLICK Write FEVT_STC_CALLTIP_CLICK;
        Property EVT_STC_CHANGE: String Read FEVT_STC_CHANGE Write FEVT_STC_CHANGE;
        Property EVT_STC_CHARADDED: String Read FEVT_STC_CHARADDED Write FEVT_STC_CHARADDED;
        Property EVT_STC_DO_DROP: String Read FEVT_STC_DO_DROP Write FEVT_STC_DO_DROP;
        Property EVT_STC_DOUBLECLICK: String Read FEVT_STC_DOUBLECLICK Write FEVT_STC_DOUBLECLICK;
        Property EVT_STC_DRAG_OVER: String Read FEVT_STC_DRAG_OVER Write FEVT_STC_DRAG_OVER;
        Property EVT_STC_DWELLEND: String Read FEVT_STC_DWELLEND Write FEVT_STC_DWELLEND;
        Property EVT_STC_DWELLSTART: String Read FEVT_STC_DWELLSTART Write FEVT_STC_DWELLSTART;
        Property EVT_STC_HOTSPOT_CLICK: String Read FEVT_STC_HOTSPOT_CLICK Write FEVT_STC_HOTSPOT_CLICK;
        Property EVT_STC_HOTSPOT_DCLICK: String Read FEVT_STC_HOTSPOT_DCLICK Write FEVT_STC_HOTSPOT_DCLICK;
        Property EVT_STC_KEY: String Read FEVT_STC_KEY Write FEVT_STC_KEY;
        Property EVT_STC_MACRORECORD: String Read FEVT_STC_MACRORECORD Write FEVT_STC_MACRORECORD;
        Property EVT_STC_MARGINCLICK: String Read FEVT_STC_MARGINCLICK Write FEVT_STC_MARGINCLICK;
        Property EVT_STC_MODIFIED: String Read FEVT_STC_MODIFIED Write FEVT_STC_MODIFIED;
        Property EVT_STC_NEEDSHOWN: String Read FEVT_STC_NEEDSHOWN Write FEVT_STC_NEEDSHOWN;
        Property EVT_STC_PAINTED: String Read FEVT_STC_PAINTED Write FEVT_STC_PAINTED;
        Property EVT_STC_ROMODIFYATTEMPT: String Read FEVT_STC_ROMODIFYATTEMPT Write FEVT_STC_ROMODIFYATTEMPT;
        Property EVT_STC_SAVEPOINTLEFT: String Read FEVT_STC_SAVEPOINTLEFT Write FEVT_STC_SAVEPOINTLEFT;
        Property EVT_STC_SAVEPOINTREACHED: String Read FEVT_STC_SAVEPOINTREACHED Write FEVT_STC_SAVEPOINTREACHED;
        Property EVT_STC_START_DRAG: String Read FEVT_STC_START_DRAG Write FEVT_STC_START_DRAG;
        Property EVT_STC_STYLENEEDED: String Read FEVT_STC_STYLENEEDED Write FEVT_STC_STYLENEEDED;
        Property EVT_STC_UPDATEUI: String Read FEVT_STC_UPDATEUI Write FEVT_STC_UPDATEUI;
        Property EVT_STC_URIDROPPED: String Read FEVT_STC_URIDROPPED Write FEVT_STC_URIDROPPED;
        Property EVT_STC_USERLISTSELECTION: String Read FEVT_STC_USERLISTSELECTION Write FEVT_STC_USERLISTSELECTION;
        Property EVT_STC_ZOOM: String Read FEVT_STC_ZOOM Write FEVT_STC_ZOOM;
        Property EVT_STC_AUTOCOMP_SELECTION: String Read FEVT_STC_AUTOCOMP_SELECTION Write FEVT_STC_AUTOCOMP_SELECTION;

        Property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_ControlOrientation: TWxControlOrientation
            Read FWx_ControlOrientation Write FWx_ControlOrientation;
        Property Wx_Enabled: Boolean Read FWx_Enabled Write FWx_Enabled Default True;
        Property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
        Property Wx_GeneralStyle: TWxStdStyleSet
            Read FWx_GeneralStyle Write FWx_GeneralStyle;
        Property Wx_HelpText: String Read FWx_HelpText Write FWx_HelpText;
        Property Wx_Hidden: Boolean Read FWx_Hidden Write FWx_Hidden Default False;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue Default -1;
        Property Wx_ToolTip: String Read FWx_ToolTip Write SetWx_ToolTip;
        Property Wx_MaxLength: Integer Read FWx_MaxLength Write FWx_MaxLength;
        Property Wx_LoadFromFile: TWxFileNameString Read FWx_LoadFromFile Write FWx_LoadFromFile;
        Property Wx_FiletoLoad: String Read FWx_FiletoLoad Write FWx_FiletoLoad;

        Property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
        Property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
        Property InvisibleBGColorString: String Read FInvisibleBGColorString Write FInvisibleBGColorString;
        Property InvisibleFGColorString: String Read FInvisibleFGColorString Write FInvisibleFGColorString;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;

        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
        Property Wx_LHSValue: String Read FWx_LHSValue Write FWx_LHSValue;
        Property Wx_RHSValue: String Read FWx_RHSValue Write FWx_RHSValue;

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
     { Register TWxStyledTextCtrl with wxWidgets as its
       default page on the Delphi component palette }
    RegisterComponents('wxWidgets', [TWxStyledTextCtrl]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxStyledTextCtrl.AutoInitialize;
Begin
    FWx_EventList := TStringList.Create;
    FWx_PropertyList := TStringList.Create;
    FWx_Border := 5;
    FWx_Class := 'wxStyledTextCtrl';
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
    FWx_LoadFromFile := TWxFileNameString.Create;
    FWx_Comments := TStringList.Create;

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxStyledTextCtrl.AutoDestroy;
Begin
    FWx_EventList.Destroy;
    FWx_PropertyList.Destroy;
    FWx_ProxyBGColorString.Destroy;
    FWx_ProxyFGColorString.Destroy;
    FWx_LoadFromFile.Destroy;
    FWx_Comments.Destroy;

End; { of AutoDestroy }

{ Write method for property Wx_ToolTip }
Procedure TWxStyledTextCtrl.SetWx_ToolTip(Value: String);
Begin
    FWx_ToolTip := Value;
End;

{ Override OnClick handler from TMemo,IWxComponentInterface }
Procedure TWxStyledTextCtrl.Click;
Begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
    Inherited Click;

     { Code to execute after click behavior
       of parent }

End;

{ Override OnKeyPress handler from TMemo,IWxComponentInterface }
Procedure TWxStyledTextCtrl.KeyPress(Var Key: Char);
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

Constructor TWxStyledTextCtrl.Create(AOwner: TComponent);
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
End;

Destructor TWxStyledTextCtrl.Destroy;
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


Function TWxStyledTextCtrl.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxStyledTextCtrl.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
End;


Function TWxStyledTextCtrl.GenerateEventTableEntries(CurrClassName: String): String;
Begin
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
    If trim(EVT_TEXT_ENTER) <> '' Then
        Result := Format('EVT_TEXT_ENTER(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TEXT_ENTER]) + '';

    If trim(EVT_UPDATE_UI) <> '' Then
        Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

    If trim(EVT_TEXT) <> '' Then
        Result := Result + #13 + Format('EVT_TEXT(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TEXT]) + '';

    If trim(EVT_TEXT_MAXLEN) <> '' Then
        Result := Result + #13 + Format('EVT_TEXT_MAXLEN(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TEXT_MAXLEN]) + '';

    If trim(EVT_TEXT_URL) <> '' Then
        Result := Result + #13 + Format('EVT_TEXT_URL(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_TEXT_URL]) + '';

    If trim(EVT_STC_CALLTIP_CLICK) <> '' Then
        Result := Result + #13 + Format('EVT_STC_CALLTIP_CLICK(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_CALLTIP_CLICK]) + '';

    If trim(EVT_STC_CHANGE) <> '' Then
        Result := Result + #13 + Format('EVT_STC_CHANGE(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_CHANGE]) + '';

    If trim(EVT_STC_CHARADDED) <> '' Then
        Result := Result + #13 + Format('EVT_STC_CHARADDED(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_CHARADDED]) + '';

    If trim(EVT_STC_DO_DROP) <> '' Then
        Result := Result + #13 + Format('EVT_STC_DO_DROP(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_DO_DROP]) + '';

    If trim(EVT_STC_DOUBLECLICK) <> '' Then
        Result := Result + #13 + Format('EVT_STC_DOUBLECLICK(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_DOUBLECLICK]) + '';

    If trim(EVT_STC_DRAG_OVER) <> '' Then
        Result := Result + #13 + Format('EVT_STC_DRAG_OVER(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_DRAG_OVER]) + '';

    If trim(EVT_STC_DWELLEND) <> '' Then
        Result := Result + #13 + Format('EVT_STC_DWELLEND(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_DWELLEND]) + '';

    If trim(EVT_STC_DWELLSTART) <> '' Then
        Result := Result + #13 + Format('EVT_STC_DWELLSTART(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_DWELLSTART]) + '';

    If trim(EVT_STC_HOTSPOT_CLICK) <> '' Then
        Result := Result + #13 + Format('EVT_STC_HOTSPOT_CLICK(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_HOTSPOT_CLICK]) + '';

    If trim(EVT_STC_HOTSPOT_DCLICK) <> '' Then
        Result := Result + #13 + Format('EVT_STC_HOTSPOT_DCLICK(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_HOTSPOT_DCLICK]) + '';

    If trim(EVT_STC_KEY) <> '' Then
        Result := Result + #13 + Format('EVT_STC_KEY(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_KEY]) + '';

    If trim(EVT_STC_MACRORECORD) <> '' Then
        Result := Result + #13 + Format('EVT_STC_MACRORECORD(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_MACRORECORD]) + '';

    If trim(EVT_STC_MARGINCLICK) <> '' Then
        Result := Result + #13 + Format('EVT_STC_MARGINCLICK(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_MARGINCLICK]) + '';

    If trim(EVT_STC_MODIFIED) <> '' Then
        Result := Result + #13 + Format('EVT_STC_MODIFIED(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_MODIFIED]) + '';

    If trim(EVT_STC_NEEDSHOWN) <> '' Then
        Result := Result + #13 + Format('EVT_STC_NEEDSHOWN(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_NEEDSHOWN]) + '';

    If trim(EVT_STC_PAINTED) <> '' Then
        Result := Result + #13 + Format('EVT_STC_PAINTED(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_PAINTED]) + '';

    If trim(EVT_STC_ROMODIFYATTEMPT) <> '' Then
        Result := Result + #13 + Format('EVT_STC_ROMODIFYATTEMPT(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_ROMODIFYATTEMPT]) + '';

    If trim(EVT_STC_SAVEPOINTLEFT) <> '' Then
        Result := Result + #13 + Format('EVT_STC_SAVEPOINTLEFT(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_SAVEPOINTLEFT]) + '';

    If trim(EVT_STC_SAVEPOINTREACHED) <> '' Then
        Result := Result + #13 + Format('EVT_STC_SAVEPOINTREACHED(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_SAVEPOINTREACHED]) + '';

    If trim(EVT_STC_START_DRAG) <> '' Then
        Result := Result + #13 + Format('EVT_STC_START_DRAG(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_START_DRAG]) + '';

    If trim(EVT_STC_STYLENEEDED) <> '' Then
        Result := Result + #13 + Format('EVT_STC_STYLENEEDED(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_STYLENEEDED]) + '';

    If trim(EVT_STC_UPDATEUI) <> '' Then
        Result := Result + #13 + Format('EVT_STC_UPDATEUI(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_UPDATEUI]) + '';

    If trim(EVT_STC_URIDROPPED) <> '' Then
        Result := Result + #13 + Format('EVT_STC_URIDROPPED(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_URIDROPPED]) + '';

    If trim(EVT_STC_USERLISTSELECTION) <> '' Then
        Result := Result + #13 + Format('EVT_STC_USERLISTSELECTION(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_USERLISTSELECTION]) + '';

    If trim(EVT_STC_ZOOM) <> '' Then
        Result := Result + #13 + Format('EVT_STC_ZOOM(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_ZOOM]) + '';

    If trim(EVT_STC_AUTOCOMP_SELECTION) <> '' Then
        Result := Result + #13 + Format('EVT_STC_AUTOCOMP_SELECTION(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_STC_AUTOCOMP_SELECTION]) + '';
{end}

End;

Function TWxStyledTextCtrl.GenerateXRCControlCreation(IndentString: String): TStringList;
Begin

    Result := TStringList.Create;

    Try //xrc unknown used so this is a little different than normal
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
    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxStyledTextCtrl.GenerateGUIControlCreation: String;
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


  //strStyle := GetEditSpecificStyle(self.Wx_GeneralStyle, self.Wx_EditStyle);

    If trim(strStyle) <> '' Then
        strStyle := ', ' + strStyle + ',  ' + GetCppString(Name)
    Else
        strStyle := ', 0,  ' + GetCppString(Name);

    Result := GetCommentString(self.FWx_Comments.Text) +
        Format('%s = new %s(%s, %s, %s, %s%s);',
        [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
        self.Wx_IDValue)
        , GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);


    If (XRCGEN) Then
    Begin//generate xrc loading code
//xrc unknown used so we are inserting our control into the unknown container. (a panel)
        Result := Result + #13 + Format('wxXmlResource::Get()->AttachUnknownControl(%s("%s"), (wxWindow*)%s, (wxWindow*)%s);',
            [StringFormat, self.Name, self.Name, parentName]);
    End;

    SetWxFileName(self.FWx_LoadFromFile.FstrFileNameValue);
    If FWx_FiletoLoad <> '' Then
    Begin
        Result := Result + #13 + Format('%s->LoadFile("%s");',
            [self.Name, FWx_FiletoLoad]);
        self.Lines.LoadFromFile(FWx_FiletoLoad);

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

    If FWx_FiletoLoad = '' Then
    Begin
        For i := 0 To self.Lines.Count - 1 Do
            If i = self.Lines.Count - 1 Then
                Result :=
                    Result + #13 + Format('%s->AppendText(%s);',
                    [self.Name, GetCppString(self.Lines[i])])
            Else
                Result := Result + #13 + Format('%s->AppendText(%s);',
                    [self.Name, GetCppString(self.Lines[i])]);

        Result := Result + #13 + self.Name + '->SetFocus();';
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

  // Set border style
    If wxSUNKEN_BORDER In self.Wx_GeneralStyle Then
    Begin
        self.BevelInner := bvLowered;
        self.BevelOuter := bvLowered;
        self.BevelKind := bkSoft;
    End
    Else
    If wxRAISED_BORDER In self.Wx_GeneralStyle Then
    Begin
        self.BevelInner := bvRaised;
        self.BevelOuter := bvRaised;
        self.BevelKind := bkSoft;
    End
    Else
    If wxNO_BORDER In self.Wx_GeneralStyle Then
    Begin
        self.BevelInner := bvNone;
        self.BevelOuter := bvNone;
        self.BevelKind := bkNone;
    End
    Else
    If wxDOUBLE_BORDER In self.Wx_GeneralStyle Then
    Begin
        self.BevelInner := bvSpace;
        self.BevelOuter := bvSpace;
        self.BevelKind := bkTile;
    End
    Else
    Begin
        self.BevelInner := bvNone;
        self.BevelOuter := bvNone;
        self.BevelKind := bkNone;
    End;

    If wxHSCROLL In self.Wx_GeneralStyle Then
        self.ScrollBars := ssHorizontal;

    If wxVSCROLL In self.Wx_GeneralStyle Then
        self.ScrollBars := ssVertical;

    If Not (wxHSCROLL In self.Wx_GeneralStyle) And Not
        (wxVSCROLL In self.Wx_GeneralStyle) Then
        self.ScrollBars := ssNone;

    If (wxHSCROLL In self.Wx_GeneralStyle) And (wxVSCROLL In self.Wx_GeneralStyle) Then
        self.ScrollBars := ssBoth;

End;

Function TWxStyledTextCtrl.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
End;

Function TWxStyledTextCtrl.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/stc/stc.h>';
End;

Function TWxStyledTextCtrl.GenerateImageInclude: String;
Begin

End;

Function TWxStyledTextCtrl.GetEventList: TStringList;
Begin
    Result := FWx_EventList;
End;

Function TWxStyledTextCtrl.GetIDName: String;
Begin
    Result := wx_IDName;
End;

Function TWxStyledTextCtrl.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxStyledTextCtrl.GetParameterFromEventName(EventName: String): String;
Begin
    If EventName = 'EVT_TEXT' Then
    Begin
        Result := 'wxCommandEvent& event';
        exit;
    End;
    If EventName = 'EVT_TEXT_MAXLEN' Then
    Begin
        Result := 'wxCommandEvent& event';
        exit;
    End;
    If EventName = 'EVT_TEXT_URL' Then
    Begin
        Result := 'wxTextUrlEvent& event';
        exit;
    End;
    If EventName = 'EVT_TEXT_ENTER' Then
    Begin
        Result := 'wxCommandEvent& event';
        exit;
    End;
    If EventName = 'EVT_UPDATE_UI' Then
    Begin
        Result := 'wxUpdateUIEvent& event';
        exit;
    End;

    If EventName = 'EVT_STC_CALLTIP_CLICK' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_CHANGE' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_CHARADDED' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_DO_DROP' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_DOUBLECLICK' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;

    If EventName = 'EVT_STC_DRAG_OVER' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_DWELLEND' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_DWELLSTART' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_HOTSPOT_CLICK' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_HOTSPOT_DCLICK' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;

    If EventName = 'EVT_STC_KEY' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_MACRORECORD' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_MARGINCLICK' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_MODIFIED' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_NEEDSHOWN' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_PAINTED' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_ROMODIFYATTEMPT' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_SAVEPOINTLEFT' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_SAVEPOINTREACHED' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_START_DRAG' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_STYLENEEDED' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_UPDATEUI' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_URIDROPPED' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_USERLISTSELECTION' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_ZOOM' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;
    If EventName = 'EVT_STC_AUTOCOMP_SELECTION' Then
    Begin
        Result := 'wxStyledTextEvent& event';
        exit;
    End;


End;

Function TWxStyledTextCtrl.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxStyledTextCtrl.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxStyledTextCtrl.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxStyledTextCtrl.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxStyledTextCtrl.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxStyledTextCtrl.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxStyledTextCtrl.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxStyledTextCtrl.GetWxClassName: String;
Begin
    If wx_Class = '' Then
        wx_Class := 'wxStyledTextCtrl';
    Result := wx_Class;
End;

Procedure TWxStyledTextCtrl.Loaded;
Begin
    Inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }
    self.ScrollBars := ssVertical;
    self.FWx_LoadFromFile.FstrFileNameValue := FWx_FiletoLoad;

End;

Procedure TWxStyledTextCtrl.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxStyledTextCtrl.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxStyledTextCtrl.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDValue;
End;

Procedure TWxStyledTextCtrl.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxStyledTextCtrl.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxStyledTextCtrl.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxStyledTextCtrl.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxStyledTextCtrl.GetFGColor: String;
Begin
    Result := FInvisibleFGColorString;
End;

Procedure TWxStyledTextCtrl.SetFGColor(strValue: String);
Begin
    FInvisibleFGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Font.Color := defaultFGColor
    Else
        self.Font.Color := GetColorFromString(strValue);
End;

Function TWxStyledTextCtrl.GetBGColor: String;
Begin
    Result := FInvisibleBGColorString;
End;

Procedure TWxStyledTextCtrl.SetBGColor(strValue: String);
Begin
    FInvisibleBGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Color := defaultBGColor
    Else
        self.Color := GetColorFromString(strValue);
End;

Procedure TWxStyledTextCtrl.SetProxyFGColorString(Value: String);
Begin
    FInvisibleFGColorString := Value;
    self.Color := GetColorFromString(Value);
End;

Procedure TWxStyledTextCtrl.SetProxyBGColorString(Value: String);
Begin
    FInvisibleBGColorString := Value;
    self.Font.Color := GetColorFromString(Value);
End;

Procedure TWxStyledTextCtrl.SetWxFileName(wxFileName: String);
Begin
    FWx_FiletoLoad := trim(wxFileName);
    strSearchReplace(FWx_FiletoLoad, '\', '/', [srAll]);
    Wx_LoadFromFile.FstrFileNameValue := FWx_FiletoLoad;
End;

Function TWxStyledTextCtrl.GetLHSVariableAssignment: String;
Var
    nPos: Integer;
Begin
    Result := '';
    If trim(Wx_LHSValue) = '' Then
        exit;
    nPos := pos('|', Wx_LHSValue);
    If (UpperCase(copy(Wx_LHSValue, 0, 2)) = 'F:') And (nPos <> -1) Then
    Begin
        Result := Format('%s = %s(%s->GetValue());', [copy(Wx_LHSValue, 3, nPos - 3), copy(Wx_LHSValue, nPos + 1, length(Wx_LHSValue)), self.Name]);
    End
    Else
        Result := Format('%s = %s->GetValue();', [Wx_LHSValue, self.Name]);
End;

Function TWxStyledTextCtrl.GetRHSVariableAssignment: String;
Begin
    Result := '';
    If trim(Wx_RHSValue) = '' Then
        exit;
    Result := Format('%s->SetValue(%s);', [self.Name, Wx_RHSValue]);
End;


End.
