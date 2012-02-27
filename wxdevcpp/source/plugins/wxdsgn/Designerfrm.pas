{

$Id: Designerfrm.pas 938 2007-05-15 03:57:34Z gururamnath $
}
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


Unit Designerfrm;

Interface

Uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    ExtCtrls, Buttons, StdCtrls, wxversion, 
    WxEdit, WxStaticText, WxButton, wxUtils, WXRadioButton, WXCheckBox,
    Wxcombobox, WxToolButton, WxSeparator, wxChoice,
    WxListbox, WxGauge, wxListCtrl, wxTreeCtrl, WxMemo, wxScrollbar, wxSpinButton,
    WxSizerPanel, WxSplitterWindow, wxAuiManager,
    ComCtrls, SynEdit, Menus, xprocs, StrUtils;

Type

    TfrmNewForm = Class(TForm, IWxComponentInterface, IWxDesignerFormInterface, IWxImageContainerInterface)
        Procedure CreateInitVars;
        Procedure FormCreate(Sender: TObject);
        Procedure FormResize(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Procedure SetFrameProperties();
        Procedure SetDialogProperties();

        Function GetBitmapCount: Integer;
        Function GetBitmap(Idx: Integer; Var bmp: TBitmap; Var PropertyName: String): Boolean;
        Function GetPropertyName(Idx: Integer): String;
        Function PreserveFormat: Boolean;
        Function GetGraphicFileName: String;
        Function SetGraphicFileName(strFileName: String): Boolean;

        Procedure FormClick(Sender: TObject);
        Procedure WMNCLButtonDown(Var Msg: TWMNCLButtonDown); Message WM_NCLBUTTONDOWN;
        Procedure WMNCRButtonDown(Var Msg: TWMNCRButtonDown); Message WM_NCRBUTTONDOWN;

    Private
    { Private declarations }
        FWxFrm_IDName: String;
        FWxFrm_IDValue: Integer;
        FWxFrm_Class: String;
        FWxFrm_Center: Boolean;
        FWxFrm_ToolTips: String;
        FWxFrm_Hidden: Boolean;
        FWxFrm_GeneralStyle: TWxStdStyleSet;
        FWxFrm_DialogStyle: TWxDlgStyleSet;
        FWxFrm_SizeToContents: Boolean;
        FisAuimanagerAvailable: Boolean;
        fsynEdit: TSynEdit;

        FEVT_CHAR, FEVT_KEY_UP, FEVT_KEY_DOWN, FEVT_ERASE_BACKGROUND,
        FEVT_SIZE, FEVT_SET_FOCUS, FEVT_KILL_FOCUS, FEVT_ENTER_WINDOW,
        FEVT_LEAVE_WINDOW, FEVT_MOTION, FEVT_LEFT_DOWN, FEVT_LEFT_UP,
        FEVT_RIGHT_DOWN, FEVT_RIGHT_UP, FEVT_MIDDLE_DOWN, FEVT_MIDDLE_UP,
        FEVT_LEFT_DCLICK, FEVT_RIGHT_DCLICK, FEVT_MIDDLE_DCLICK, FEVT_PAINT,
        FEVT_INIT_DIALOG, FEVT_SCROLLWIN, FEVT_SCROLLWIN_TOP, FEVT_SCROLLWIN_BOTTOM,
        FEVT_SCROLLWIN_LINEUP, FEVT_SCROLLWIN_LINEDOWN, FEVT_SCROLLWIN_PAGEUP,
        FEVT_SCROLLWIN_PAGEDOWN, FEVT_SCROLLWIN_THUMBTRACK, FEVT_SCROLLWIN_THUMBRELEASE,
        FEVT_SYS_COLOUR_CHANGED, FEVT_UPDATE_UI, FEVT_CLOSE: String;
        FEVT_IDLE, FEVT_ACTIVATE, FEVT_ACTIVATE_APP, FEVT_QUERY_END_SESSION,
        FEVT_END_SESSION, FEVT_DROP_FILES, FEVT_SPLITTER_SASH_POS_CHANGED,
        FEVT_SPLITTER_UNSPLIT, FEVT_SPLITTER_DCLICK, FEVT_JOY_BUTTON_DOWN,
        FEVT_JOY_BUTTON_UP, FEVT_JOY_MOVE, FEVT_JOY_ZMOVE, FEVT_MENU_OPEN,
        FEVT_MENU_CLOSE, FEVT_MENU_HIGHLIGHT_ALL, FEVT_MOUSEWHEEL, FEVT_MOUSE_EVENTS: String;

        FWx_Name: String;
        FWx_ICON: TPicture;
        FWx_ProxyBGColorString: TWxColorString;
        FWx_ProxyFGColorString: TWxColorString;
        FWxDesignerType: TWxDesignerType;
        wx_PropertyList: TStringList;
        FWx_EventList: TStringList;

        FKeepFormat: Boolean;
        FWx_Filename: String;

    { Read method for property Wx_EditStyle }
        Function GetWx_DialogStyle: TWxDlgStyleSet;
    { Write method for property Wx_EditStyle }
        Procedure SetWx_DialogStyle(Value: TWxDlgStyleSet);

    Public
        fileName: String;
        Function GenerateControlIDs: String;
        Function GenerateEnumControlIDs: String;
        Function GenerateEventTableEntries(CurrClassName: String): String;
        Function GenerateGUIControlCreation: String;
        Function GenerateXRCControlCreation(IndentString: String): TStringList;
        Function GenerateGUIControlDeclaration: String;
        Function GenerateHeaderInclude: String;
        Function GenerateImageInclude: String;
        Function GetIDName: String;
        Function GetIDValue: Integer;
        Function GetPropertyList: TStringList;
        Function GetWxClassName: String;
        Procedure SetIDName(IDName: String);
        Procedure SetIDValue(IDValue: Integer);
        Procedure SetWxClassName(wxClassName: String);
        Procedure FormMove(Var Msg: TWMMove); Message WM_MOVE;
        Function GetDialogStyleString: String;
        Function GetEventList: TStringList;
        Function GetParameterFromEventName(EventName: String): String;
        Function GetTypeFromEventName(EventName: String): String;
        Procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
        Function GetFGColor: String;
        Procedure SetFGColor(strValue: String);
        Function GetBGColor: String;
        Procedure SetBGColor(strValue: String);
        Function GetGenericColor(strVariableName: String): String;
        Procedure SetGenericColor(strVariableName, strValue: String);

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);
        Procedure SetDesignerType(Value: TWxDesignerType);
    //Form Interface functions
        Function GetFormName: String;
        Procedure SetFormName(StrValue: String);

        Procedure CreateNewXPMs(strFileName: String);
        Function HasAuiManager: Boolean;

    Published
        Property EVT_INIT_DIALOG: String Read FEVT_INIT_DIALOG Write FEVT_INIT_DIALOG;
        Property EVT_CHAR: String Read FEVT_CHAR Write FEVT_CHAR;
        Property EVT_KEY_UP: String Read FEVT_KEY_UP Write FEVT_KEY_UP;
        Property EVT_KEY_DOWN: String Read FEVT_KEY_DOWN Write FEVT_KEY_DOWN;
        Property EVT_ERASE_BACKGROUND: String Read FEVT_ERASE_BACKGROUND Write FEVT_ERASE_BACKGROUND;
        Property EVT_SIZE: String Read FEVT_SIZE Write FEVT_SIZE;
        Property EVT_SET_FOCUS: String Read FEVT_SET_FOCUS Write FEVT_SET_FOCUS;
        Property EVT_KILL_FOCUS: String Read FEVT_KILL_FOCUS Write FEVT_KILL_FOCUS;
        Property EVT_ENTER_WINDOW: String Read FEVT_ENTER_WINDOW Write FEVT_ENTER_WINDOW;
        Property EVT_LEAVE_WINDOW: String Read FEVT_LEAVE_WINDOW Write FEVT_LEAVE_WINDOW;
        Property EVT_MOTION: String Read FEVT_MOTION Write FEVT_MOTION;
        Property EVT_LEFT_DOWN: String Read FEVT_LEFT_DOWN Write FEVT_LEFT_DOWN;
        Property EVT_LEFT_UP: String Read FEVT_LEFT_UP Write FEVT_LEFT_UP;
        Property EVT_RIGHT_DOWN: String Read FEVT_RIGHT_DOWN Write FEVT_RIGHT_DOWN;
        Property EVT_RIGHT_UP: String Read FEVT_RIGHT_UP Write FEVT_RIGHT_UP;
        Property EVT_MIDDLE_DOWN: String Read FEVT_MIDDLE_DOWN Write FEVT_MIDDLE_DOWN;
        Property EVT_MIDDLE_UP: String Read FEVT_MIDDLE_UP Write FEVT_MIDDLE_UP;
        Property EVT_LEFT_DCLICK: String Read FEVT_LEFT_DCLICK Write FEVT_LEFT_DCLICK;
        Property EVT_RIGHT_DCLICK: String Read FEVT_RIGHT_DCLICK Write FEVT_RIGHT_DCLICK;
        Property EVT_MIDDLE_DCLICK: String Read FEVT_MIDDLE_DCLICK Write FEVT_MIDDLE_DCLICK;
        Property EVT_PAINT: String Read FEVT_PAINT Write FEVT_PAINT;
        Property EVT_SCROLLWIN: String Read FEVT_SCROLLWIN Write FEVT_SCROLLWIN;
        Property EVT_SCROLLWIN_TOP: String Read FEVT_SCROLLWIN_TOP Write FEVT_SCROLLWIN_TOP;
        Property EVT_SCROLLWIN_BOTTOM: String Read FEVT_SCROLLWIN_BOTTOM Write FEVT_SCROLLWIN_BOTTOM;
        Property EVT_SCROLLWIN_LINEUP: String Read FEVT_SCROLLWIN_LINEUP Write FEVT_SCROLLWIN_LINEUP;
        Property EVT_SCROLLWIN_LINEDOWN: String Read FEVT_SCROLLWIN_LINEDOWN Write FEVT_SCROLLWIN_LINEDOWN;
        Property EVT_SCROLLWIN_PAGEUP: String Read FEVT_SCROLLWIN_PAGEUP Write FEVT_SCROLLWIN_PAGEUP;
        Property EVT_SCROLLWIN_PAGEDOWN: String Read FEVT_SCROLLWIN_PAGEDOWN Write FEVT_SCROLLWIN_PAGEDOWN;
        Property EVT_SCROLLWIN_THUMBTRACK: String Read FEVT_SCROLLWIN_THUMBTRACK Write FEVT_SCROLLWIN_THUMBTRACK;
        Property EVT_SCROLLWIN_THUMBRELEASE: String Read FEVT_SCROLLWIN_THUMBRELEASE Write FEVT_SCROLLWIN_THUMBRELEASE;
        Property EVT_SYS_COLOUR_CHANGED: String Read FEVT_SYS_COLOUR_CHANGED Write FEVT_SYS_COLOUR_CHANGED;
        Property EVT_UPDATE_UI: String Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
        Property EVT_CLOSE: String Read FEVT_CLOSE Write FEVT_CLOSE;
        Property EVT_IDLE: String Read FEVT_IDLE Write FEVT_IDLE;
        Property EVT_ACTIVATE: String Read FEVT_ACTIVATE Write FEVT_ACTIVATE;
        Property EVT_ACTIVATE_APP: String Read FEVT_ACTIVATE_APP Write FEVT_ACTIVATE_APP;
        Property EVT_QUERY_END_SESSION: String Read FEVT_QUERY_END_SESSION Write FEVT_QUERY_END_SESSION;
        Property EVT_END_SESSION: String Read FEVT_END_SESSION Write FEVT_END_SESSION;
        Property EVT_DROP_FILES: String Read FEVT_DROP_FILES Write FEVT_DROP_FILES;
        Property EVT_SPLITTER_SASH_POS_CHANGED: String Read FEVT_SPLITTER_SASH_POS_CHANGED Write FEVT_SPLITTER_SASH_POS_CHANGED;
        Property EVT_SPLITTER_UNSPLIT: String Read FEVT_SPLITTER_UNSPLIT Write FEVT_SPLITTER_UNSPLIT;
        Property EVT_SPLITTER_DCLICK: String Read FEVT_SPLITTER_DCLICK Write FEVT_SPLITTER_DCLICK;
        Property EVT_JOY_BUTTON_DOWN: String Read FEVT_JOY_BUTTON_DOWN Write FEVT_JOY_BUTTON_DOWN;
        Property EVT_JOY_BUTTON_UP: String Read FEVT_JOY_BUTTON_UP Write FEVT_JOY_BUTTON_UP;
        Property EVT_JOY_MOVE: String Read FEVT_JOY_MOVE Write FEVT_JOY_MOVE;
        Property EVT_JOY_ZMOVE: String Read FEVT_JOY_ZMOVE Write FEVT_JOY_ZMOVE;
        Property EVT_MENU_OPEN: String Read FEVT_MENU_OPEN Write FEVT_MENU_OPEN;
        Property EVT_MENU_CLOSE: String Read FEVT_MENU_CLOSE Write FEVT_MENU_CLOSE;
        Property EVT_MENU_HIGHLIGHT_ALL: String Read FEVT_MENU_HIGHLIGHT_ALL Write FEVT_MENU_HIGHLIGHT_ALL;
        Property EVT_MOUSEWHEEL: String Read FEVT_MOUSEWHEEL Write FEVT_MOUSEWHEEL;
        Property EVT_MOUSE_EVENTS: String Read FEVT_MOUSE_EVENTS Write FEVT_MOUSE_EVENTS;

        Property synEdit: TSynEdit Read fsynEdit Write fsynEdit;
        Property Wx_ICON: TPicture Read FWx_ICON Write FWx_ICON;
        Property Wx_Name: String Read FWx_Name Write FWx_Name;
        Property Wx_IDName: String Read FWxFrm_IDName Write FWxFrm_IDName;
        Property Wx_IDValue: Integer Read FWxFrm_IDValue Write FWxFrm_IDValue;
        Property Wx_Class: String Read FWxFrm_Class Write FWxFrm_Class;
        Property Wx_Center: Boolean Read FWxFrm_Center Write FWxFrm_Center;
        Property Wx_Hidden: Boolean Read FWxFrm_Hidden Write FWxFrm_Hidden;
        Property Wx_ToolTips: String Read FWxFrm_ToolTips Write FWxFrm_ToolTips;
        Property Wx_SizeToContents: Boolean Read FWxFrm_SizeToContents Write FWxFrm_SizeToContents;

        Property KeepFormat: Boolean Read FKeepFormat Write FKeepFormat Default False;
        Property Wx_Filename: String Read FWx_Filename Write FWx_Filename;

        Property Wx_GeneralStyle: TWxStdStyleSet Read FWxFrm_GeneralStyle Write FWxFrm_GeneralStyle;
        Property Wx_DialogStyle: TWxDlgStyleSet
            Read GetWx_DialogStyle Write SetWx_DialogStyle;
    //Read FWxFrm_DialogStyle Write FWxFrm_DialogStyle;
        Property Wx_DesignerType: TWxDesignerType Read FWxDesignerType Write SetDesignerType Default dtWxDialog;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;

        Property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
        Property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;

        Property isAuimanagerAvailable: Boolean Read FisAuimanagerAvailable Write FisAuimanagerAvailable;

    End;

Var
    frmNewFormX: TfrmNewForm;

Procedure GenerateCpp(frmNewForm: TfrmNewForm; strClassName: String; synEdit: TSynEdit);
Procedure GenerateHpp(frmNewForm: TfrmNewForm; strClassName: String; synEdit: TSynEdit);
Procedure GenerateXPM(frmNewForm: TfrmNewForm; strFileName: String;
    onlyForForm: Boolean = False);
Procedure GenerateXRC(frmNewForm: TfrmNewForm; strClassName: String;
    synEdit: TSynEdit; strFileName: String);

Implementation

Uses dmCodeGen, WxStaticBitmap, wxdesigner;

{$R *.DFM}

Procedure GenerateCpp(frmNewForm: TfrmNewForm; strClassName: String;
    synEdit: TSynEdit);
Var
    i: Integer;
    intBlockStart, intBlockEnd: Integer;
    intManualBlockStart, intManualBlockEnd: Integer;
    wxcompInterface: IWxComponentInterface;
    varIntf: IWxVariableAssignmentInterface;
    wxAuimanagerInterface: IWxAuiManagerInterface;
  //  wxAuiPaneInfoInterface: IWxAuiPaneInfoInterface;
//  wxAuiPaneInterface: IWxAuiPaneInterface;
    strEntry, strEventTableStart, strEventTableEnd: String;
    isSizerAvailable: Boolean;
    hasImage: Boolean;
  //  isAuimanagerAvailable: boolean;
    strHdrValue: String;
    strStartStr, strEndStr: String;
    strLst, strlstManualCode: TStringList;
    CntIntf: IWxContainerAndSizerInterface;
    strTemp: String;
Begin

    hasImage := false;

    If GetBlockStartAndEndPos(synEdit, strClassName, btClassNameGUIItemsCreation, intBlockStart, intBlockEnd) Then
    Begin
    //Clear Declaration and Creation Field
        DeleteAllClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd);

        isSizerAvailable := False;
        For I := 0 To frmNewForm.ComponentCount - 1 Do // Iterate
        Begin
            If frmNewForm.Components[i].GetInterface(IID_IWxContainerAndSizerInterface, CntIntf) Then
            Begin
                isSizerAvailable := True;
                break;
            End;
        End;

        hasImage := False;
        For I := 0 To frmNewForm.ComponentCount - 1 Do // Iterate
        Begin
            If frmNewForm.Components[i].GetInterface(IWxImageContainerInterface, CntIntf) Then
            Begin
                hasImage := True;
                break;
            End;
        End;

        frmNewForm.isAuimanagerAvailable := False;
    //MN detect whether there is a wxAuiManager component
        For I := frmNewForm.ComponentCount - 1 Downto 0 Do // Iterate
        Begin
      //  if frmNewForm.Components[i].Name = UpperCase('TWxAuiManager') then
            If frmNewForm.Components[i].GetInterface(IID_IWxAuiManagerInterface, wxAuimanagerInterface) Then
            Begin
                frmNewForm.isAuimanagerAvailable := True;
                break;
            End;
        End; // for

      //  ALWAYS do this first, it should then be last in the list
        strTemp := frmNewForm.GenerateGUIControlCreation;
        AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, strTemp);


        If isSizerAvailable Then
        Begin
{
      strTemp := frmNewForm.GenerateGUIControlCreation;
          AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, strTemp);
}
      //Add the Code Generation Items that need to be added after the creation with new
            For I := frmNewForm.ComponentCount - 1 Downto 0 Do // Iterate
            Begin
                If Not frmNewForm.Components[i].GetInterface(IID_IWxContainerAndSizerInterface, CntIntf) Then
                    continue;
                strTemp := CntIntf.GenerateLastCreationCode;
                If trim(strTemp) = '' Then
                    continue;
                AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, strTemp);
                AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, '');
            End; // for
        End;

        If Not isSizerAvailable Then
        Begin
            For I := 0 To frmNewForm.ComponentCount - 1 Do // Iterate
            Begin
                If frmNewForm.Components[i].GetInterface(IID_IWxContainerAndSizerInterface, CntIntf) Then
                    continue;
                If Not frmNewForm.Components[i].GetInterface(IID_IWxAuiManagerInterface, wxAuimanagerInterface)
          {and not frmNewForm.Components[i].GetInterface(IID_IWxAuiPaneInfoInterface, wxAuiPaneInfoInterface)} Then
                Begin

                    If frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) Then
                    Begin
                        strTemp := wxcompInterface.GenerateGUIControlCreation;
                        AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, strTemp);
                    End;
                    AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, '');
                End;
            End; // for

      //MN detect whether there is a wxAuiManager component and do the code for that last
      //it is then first in the generated code
            For I := frmNewForm.ComponentCount - 1 Downto 0 Do // Iterate
            Begin
                If frmNewForm.Components[i].GetInterface(IID_IWxContainerAndSizerInterface, CntIntf) Then
                    continue;
        //  if frmNewForm.Components[i].Name = UpperCase('TWxAuiManager') then
                If frmNewForm.Components[i].GetInterface(IID_IWxAuiManagerInterface, wxAuimanagerInterface) Then
                Begin
                    If frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) Then
                    Begin
                        strTemp := wxcompInterface.GenerateGUIControlCreation;
                        AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, strTemp);
                    End;
                    AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, '');
                End;
            End; // for
        End
        Else
        Begin

            For I := frmNewForm.ComponentCount - 1 Downto 0 Do // Iterate
            Begin

                If Not frmNewForm.Components[i].GetInterface(IID_IWxAuiManagerInterface, wxAuimanagerInterface)
          {and not frmNewForm.Components[i].GetInterface(IID_IWxAuiPaneInfoInterface, wxAuiPaneInfoInterface)} Then
                Begin

                    If frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) Then
                    Begin
                        strTemp := wxcompInterface.GenerateGUIControlCreation;
                        AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, strTemp);
                    End;
                    AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, '');
                End;
            End; // for

      //MN detect whether there is a wxAuiManager component and do the code for that last
      //it is then first in the generated code

            For I := frmNewForm.ComponentCount - 1 Downto 0 Do // Iterate
            Begin
        //  if frmNewForm.Components[i].Name = UpperCase('TWxAuiManager') then
                If frmNewForm.Components[i].GetInterface(IID_IWxAuiManagerInterface, wxAuimanagerInterface) Then
                Begin
                    If frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) Then
                    Begin
                        strTemp := wxcompInterface.GenerateGUIControlCreation;
                        AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, strTemp);
                    End;
                    AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, '');
                End;
            End; // for

        End;

    //Form data should come first, if not the child will be resized to
        If Not isSizerAvailable Then
//Already done above
//      AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd, frmNewForm.GenerateGUIControlCreation);
            If (XRCGEN) Then //NUKLEAR ZELPH
            Begin
                AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd,
                    'wxInitAllImageHandlers();' + #13 + 'wxXmlResource::Get()->InitAllHandlers();' + #13 + 'wxXmlResource::Get()->Load(' + StringFormat + '("' + strClassName + '.xml"));' + #13 + 'wxXmlResource::Get()->AddHandler(new wxRichTextCtrlXmlHandler);');
            End;
    End;

    If (hasImage) Then
        AddClassNameGUIItemsCreation(synEdit, strClassName, intBlockStart, intBlockEnd,
            'wxInitAllImageHandlers();   //Initialize graphic format handlers' + #13);

  // RHS Variable
    If GetBlockStartAndEndPos(synEdit, strClassName, btRHSVariables, intBlockStart, intBlockEnd) Then
    Begin
        DeleteAllRHSVariableList(synEdit, strClassName, intBlockStart, intBlockEnd);

        For I := frmNewForm.ComponentCount - 1 Downto 0 Do // Iterate
        Begin
        //            if frmNewForm.Components[i] is TPanel then
        //                continue;
            If frmNewForm.Components[i].GetInterface(IID_IWxVariableAssignmentInterface, varIntf) Then
            Begin
                strTemp := varIntf.GetRHSVariableAssignment;
                If (strTemp) = '' Then
                    continue;
                AddRHSVariableList(synEdit, strClassName, intBlockStart, intBlockEnd, varIntf.GetRHSVariableAssignment);
            End;
            AddRHSVariableList(synEdit, strClassName, intBlockStart, intBlockEnd, '');
        End;// for;

    End;

  // LHS Variable
    If GetBlockStartAndEndPos(synEdit, strClassName, btLHSVariables, intBlockStart, intBlockEnd) Then
    Begin
        DeleteAllLHSVariableList(synEdit, strClassName, intBlockStart, intBlockEnd);
        For I := frmNewForm.ComponentCount - 1 Downto 0 Do // Iterate
        Begin
        //            if frmNewForm.Components[i] is TPanel then
        //                continue;
            If frmNewForm.Components[i].GetInterface(IID_IWxVariableAssignmentInterface, varIntf) Then
            Begin
                strTemp := varIntf.GetLHSVariableAssignment;
                If (strTemp) = '' Then
                    continue;
                AddLHSVariableList(synEdit, strClassName, intBlockStart, intBlockEnd, varIntf.GetLHSVariableAssignment);
            End;
            AddLHSVariableList(synEdit, strClassName, intBlockStart, intBlockEnd, '');
        End;// for;
    End;

  // Event table
    If GetBlockStartAndEndPos(synEdit, strClassName, btClassNameEventTableEntries, intBlockStart, intBlockEnd) Then
    Begin
        GetStartAndEndBlockStrings('', btManualCode, strStartStr, strEndStr);

        If GetBlockStartAndEndPos(synEdit, strClassName, btManualCode, intManualBlockStart, intManualBlockEnd) Then
            strlstManualCode := GetBlockCode(synEdit, strClassName, btManualCode, intManualBlockStart, intManualBlockEnd)
        Else
            strlstManualCode := TStringList.Create;

        Try

            DeleteAllClassNameEventTableEntries(synEdit, strClassName, intBlockStart, intBlockEnd);

            strEventTableEnd := 'END_EVENT_TABLE()';
            AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart, intBlockEnd, strEventTableEnd, False);


    //EVT_CLOSE(%CLASS_NAME%:: OnQuit )
            For I := 0 To frmNewForm.ComponentCount - 1 Do // Iterate
            Begin
                wxcompInterface := Nil;
                If frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) Then
                Begin
                    strEntry := wxcompInterface.GenerateEventTableEntries(strClassName);
        //SendDebug(strEntry);
                    AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart, intBlockEnd, strEntry);
                End;
      //AddClassNameEventTableEntries(strCppSrc, strClassName, intBlockStart, intBlockEnd, '');
            End; // for
         //Form data should come first, if not the child will be resized to
            strEntry := frmNewForm.GenerateEventTableEntries(strClassName);
    //SendDebug(strEntry);
            AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart, intBlockEnd, strEntry);

     //Manual Code Clear Declaration and Creation Field

            AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart, intBlockEnd, strEndStr);
            For I := strlstManualCode.Count - 1 Downto 0 Do    // Iterate
                AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart, intBlockEnd,
                    strlstManualCode[i]);    // for

        Finally
            strlstManualCode.Destroy;
        End;

        AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart, intBlockEnd, strStartStr);

        strEventTableStart := Format('BEGIN_EVENT_TABLE(%s,%s)', [frmNewForm.Wx_Name, frmNewForm.Wx_Class]);
        AddClassNameEventTableEntries(synEdit, strClassName, intBlockStart, intBlockEnd, strEventTableStart, False);
    End;

  //Adding XPM Header files
  //A stupid way to find
    If GetBlockStartAndEndPos(synEdit, strClassName, btHeaderIncludes, intBlockStart, intBlockEnd) Then
    Begin
    //Clear Declaration and Creation Field
        DeleteAllClassNameIncludeHeader(synEdit, strClassName, intBlockStart, intBlockEnd);
        strHdrValue := '';
        strLst := TStringList.Create;
        For I := 0 To frmNewForm.ComponentCount - 1 Do // Iterate
            If frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) Then
            Begin
                strHdrValue := wxcompInterface.GenerateImageInclude;
                If strLst.indexOf(strHdrValue) = -1 Then
                Begin
                    strLst.add(strHdrValue);
                    AddClassNameIncludeHeader(synEdit, strClassName,
                        intBlockStart, intBlockEnd, strHdrValue);
                End;
            End;

        strHdrValue := trim(frmNewForm.GenerateImageInclude);
        If strHdrValue <> '' Then
            If strLst.indexOf(strHdrValue) = -1 Then
            Begin
                strLst.add(strHdrValue);
                AddClassNameIncludeHeader(synEdit, strClassName, intBlockStart, intBlockEnd, strHdrValue);
            End;

        strLst.Destroy;
    End;
End;

Procedure GenerateXRC(frmNewForm: TfrmNewForm; strClassName: String;
    synEdit: TSynEdit; strFileName: String);
Var
    i: Integer;
    wxcompInterface: IWxComponentInterface;
    tempstring: TStringList;
Begin

    synEdit.Clear;
    synEdit.Lines.Add('<?xml version="1.0" encoding="ISO-8859-1"?>');
    synEdit.Lines.Add('<resource version="2.3.0.1">');
    synEdit.Lines.Add('<!-- Created by ' + GetAppVersion + ' -->');

    synEdit.Lines.Add(Format('<!--object class="%s" name="%s"-->',
        [frmNewForm.Wx_class, frmNewForm.Wx_Name]));
    synEdit.Lines.Add(Format('<!--title>%s</title-->', [frmNewForm.Caption]));
    synEdit.Lines.Add(Format('<!--IDident>%s</IDident-->', [frmNewForm.Wx_IDName]));
    synEdit.Lines.Add(Format('<!--ID>%d</ID-->', [frmNewForm.Wx_IDValue]));
    synEdit.Lines.Add(Format('<!--pos>%d,%d</pos-->', [frmNewForm.Left, frmNewForm.Top]));
    synEdit.Lines.Add(Format('<!--size>%d,%d</size-->',
        [frmNewForm.Width, frmNewForm.Height]));

    If GetStdStyleString(frmNewForm.Wx_GeneralStyle) = '' Then
        If strEqual(frmNewForm.Wx_class, 'WxFrame') Then
            synEdit.Lines.Add('<!--style>wxDEFAULT_FRAME_STYLE</style-->')
        Else
            synEdit.Lines.Add('<!--style>wxDEFAULT_DIALOG_STYLE</style-->')
    Else
        synEdit.Lines.Add(Format('<!--style>%s</style-->',
            [GetStdStyleString(frmNewForm.Wx_GeneralStyle)]));

    For i := 0 To frmNewForm.ComponentCount - 1 Do // Iterate
        If frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface,
            wxcompInterface) Then
      // Only add the XRC control if it is a child of the top-most parent (the form)
      //  If it is a child of a sizer, panel, or other object, then it's XRC code
      //  is created in GenerateXRCControlCreation of that control.
            If (frmNewForm.Components[i].GetParentComponent.Name = 'frmNewForm') Then
            Begin
                tempstring := wxcompInterface.GenerateXRCControlCreation('  ');
                Try
                    synEdit.Lines.AddStrings(tempstring);
                Finally
                    tempstring.Free;
                End;
            End; // for

    synEdit.Lines.Add('<!--/object-->');

    synEdit.Lines.Add('</resource>');

End;

Procedure GenerateHpp(frmNewForm: TfrmNewForm; strClassName: String; synEdit: TSynEdit);
Var
    i: Integer;
    intBlockStart, intBlockEnd: Integer;
    wxcompInterface: IWxComponentInterface;
    strLst: TStringList;
    strHdrValue, strIDValue, strLine: String;
Begin
    If GetBlockStartAndEndPos(synEdit, strClassName, btClassNameGUIItemsDeclaration,
        intBlockStart, intBlockEnd) Then
    Begin
    //Clear Declaration and Creation Field
        DeleteAllClassNameGUIItemsDeclaration(synEdit, strClassName, intBlockStart,
            intBlockEnd);
        For I := 0 To frmNewForm.ComponentCount - 1 Do // Iterate
            If frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface,
                wxcompInterface) Then
                AddClassNameGUIItemsDeclaration(synEdit, strClassName, intBlockStart,
                    intBlockEnd, wxcompInterface.GenerateGUIControlDeclaration());
    End;

  //For Old #define styled Control Ids
    If GetBlockStartAndEndPos(synEdit, strClassName, btClassNameControlIdentifiers,
        intBlockStart, intBlockEnd) Then
    Begin
    //Clear Declaration and Creation Field
        DeleteAllClassNameControlIndentifiers(synEdit, strClassName, intBlockStart,
            intBlockEnd);
        strLst := TStringList.Create;
        For I := 0 To frmNewForm.ComponentCount - 1 Do // Iterate
            If frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface,
                wxcompInterface) Then
            Begin
        //If the user is using a predefined ID then we dont generate ids for them
                If IsIDPredefined(trim(wxcompInterface.GetIDName), wx_designer.strStdwxIDList) Then
                    continue;
                strIDValue := wxcompInterface.GenerateControlIDs;
                If trim(strIDValue) <> '' Then
                    If strLst.indexOf(strIDValue) = -1 Then
                    Begin
                        strLst.Add(strIDValue);
                        AddClassNameControlIndentifiers(synEdit, strClassName, intBlockStart,
                            intBlockEnd, strIDValue);
                    End;
            End;
        strLst.Destroy;
    End;
  //New Enum Based Control Ids
    If GetBlockStartAndEndPos(synEdit, strClassName, btClassNameEnumControlIdentifiers,
        intBlockStart, intBlockEnd) Then
    Begin
    //Clear Declaration and Creation Field
        DeleteAllClassNameEnumControlIndentifiers(synEdit, strClassName,
            intBlockStart, intBlockEnd);
        strLst := TStringList.Create;
        For I := 0 To frmNewForm.ComponentCount - 1 Do // Iterate
            If frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface,
                wxcompInterface) Then
            Begin
        //If the user is using a predefined ID then we dont generate ids for them
                If IsIDPredefined(trim(wxcompInterface.GetIDName), wx_designer.strStdwxIDList) Then
                    continue;
                strIDValue := wxcompInterface.GenerateEnumControlIDs;
                If trim(strIDValue) <> '' Then
                    If strLst.indexOf(strIDValue) = -1 Then
                    Begin
                        strLst.Add(strIDValue);
                        AddClassNameEnumControlIndentifiers(synEdit,
                            strClassName, intBlockStart, intBlockEnd, strIDValue);
                    End;
            End;
        If Not (UseIndividEnums) Then
        Begin
            strIDValue := 'ID_DUMMY_START = 1000,';
            strLst.Add(strIDValue);
            AddClassNameEnumControlIndentifiers(synEdit,
                strClassName, intBlockStart, intBlockEnd, strIDValue);

        End;
        strLst.Destroy;
    End;

    If GetBlockStartAndEndPos(synEdit, strClassName, btDialogStyle, intBlockStart,
        intBlockEnd) Then
    Begin
    //Clear Declaration and Creation Field

    // We want to parse the #define line and just extract the name of
    //    the constant. The name used to be hardcoded as THIS_DIALOG_STYLE
    //    Now we'll use a name based on the CLASSNAME, but for backwards
    //    compatibility we need to just change the options, not the name
    //    itself.
    // Get the #define line  (it should be just after the start of the block)
        For I := intBlockStart To intBlockEnd Do // Iterate
            If (strContainsU('#define', synEdit.Lines[I])) Then
                strLine := Trim(synEdit.Lines[I]);

    // Tokenize the line by spaces
        strLst := TStringList.Create;   // Create a string list
        strTokenToStrings(strLine, ' ', strLst);
    // Break up the line wherever there is a space
        strLine := '#undef ' + strLst.Strings[1] + #13#10;
        strLine := strLine + strLst.Strings[0] + ' ' + strLst.Strings[1] +
            ' ' + frmNewForm.GetDialogStyleString;   // Get the first and second strings

        strLst.Destroy; // Destroy the string list

        DeleteAllDialogStyleDeclaration(synEdit, strClassName, intBlockStart,
            intBlockEnd);
        AddDialogStyleDeclaration(synEdit, strClassName, intBlockStart, intBlockEnd,
            strLine);

    End;

    If GetBlockStartAndEndPos(synEdit, strClassName, btHeaderIncludes,
        intBlockStart, intBlockEnd) Then
    Begin
    //Clear Declaration and Creation Field
        DeleteAllClassNameIncludeHeader(synEdit, strClassName, intBlockStart,
            intBlockEnd);
        strLst := TStringList.Create;
        For I := 0 To frmNewForm.ComponentCount - 1 Do // Iterate
            If frmNewForm.Components[i].GetInterface(IID_IWxComponentInterface,
                wxcompInterface) Then
            Begin
                strHdrValue := wxcompInterface.GenerateHeaderInclude;
                If strLst.indexOf(strHdrValue) = -1 Then
                Begin
                    strLst.add(strHdrValue);
                    AddClassNameIncludeHeader(synEdit, strClassName,
                        intBlockStart, intBlockEnd, strHdrValue);
                End;
            End;
        If (XRCGEN) Then //NUKLEAR ZELPH
        Begin
            AddClassNameIncludeHeader(synEdit, strClassName, intBlockStart, intBlockEnd,
                '#include <wx/xrc/xmlres.h>' + #13 + '#include <wx/xrc/xh_all.h>');
        End;
        strLst.Destroy;
    End;

End;


Procedure GenerateXPM(frmNewForm: TfrmNewForm; strFileName: String; onlyForForm: Boolean);
Var
    I: Integer;
    xpmFileDir: String;
    fileStrlst: TStringList;
    strXPMContent, frmName: String;

Begin

    If (frmNewForm.KeepFormat) Then
        Exit;

    xpmFileDir := CreateGraphicFileDir(strFileName) + 'Images' + pd;

    If frmNewForm.Wx_ICON.Bitmap.handle <> 0 Then
    Begin
        If onlyForForm Then
            DeleteFile(xpmFileDir + 'Self_' + frmNewForm.Wx_Name + '_XPM.xpm');

        If Not fileexists(xpmFileDir + 'Self_' + frmNewForm.Wx_Name + '_XPM.xpm') Then
        Begin
            fileStrlst := TStringList.Create;
            Try
                strXPMContent := GetXPMFromTPicture('Self_' + frmNewForm.Wx_Name, frmNewForm.Wx_ICON.Bitmap);
                If trim(strXPMContent) <> '' Then
                Begin
                    fileStrlst.Add(strXPMContent);
                    fileStrlst.SaveToFile(xpmFileDir + 'Self_' + frmNewForm.Wx_Name + '_XPM.xpm');
                End;
            Except
            End;
            fileStrlst.Destroy;
        End;
    End;

    If onlyForForm = True Then
        exit;

    frmName := frmNewForm.Wx_Name + '_';
    For I := 0 To frmNewForm.ComponentCount - 1 Do    // Iterate
    Begin
        If frmNewForm.Components[I] Is TWxStaticBitmap Then
        Begin
            If TWxStaticBitmap(frmNewForm.Components[I]).Picture.Bitmap.handle = 0 Then
                continue;
            If Not fileexists(xpmFileDir + frmName + frmNewForm.Components[I].Name + '_XPM.xpm') Then
            Begin
                fileStrlst := TStringList.Create;
                Try
                    strXPMContent := GetXPMFromTPicture(frmName + frmNewForm.Components[I].Name, TWxStaticBitmap(frmNewForm.Components[I]).Picture.Bitmap);
                    If trim(strXPMContent) = '' Then
                        continue;
                    fileStrlst.Add(strXPMContent);
                    fileStrlst.SaveToFile(xpmFileDir + frmName + frmNewForm.Components[I].Name + '_XPM.xpm');
                Except
                End;
                fileStrlst.Destroy;
            End;
        End;    // for

        If frmNewForm.Components[I] Is TWxToolButton Then
        Begin
            If TWxToolButton(frmNewForm.Components[I]).Wx_Bitmap.Bitmap.handle = 0 Then
                continue;
            If Not fileexists(xpmFileDir + frmName + frmNewForm.Components[I].Name + '_XPM.xpm') Then
            Begin
                fileStrlst := TStringList.Create;
                Try
                    strXPMContent :=
                        GetXPMFromTPicture(frmName + frmNewForm.Components[I].Name, TWxToolButton(frmNewForm.Components[I]).Wx_Bitmap.Bitmap);
                    If trim(strXPMContent) = '' Then
                        continue;
                    fileStrlst.Add(strXPMContent);
                    fileStrlst.SaveToFile(xpmFileDir + frmName + frmNewForm.Components[I].Name + '_XPM.xpm');
                Except
                End;
                fileStrlst.Destroy;
            End;
        End;    // for

    End;
End;

Procedure TfrmNewForm.SetDialogProperties;
Begin
  //Free the old property list
    If Assigned(wx_PropertyList) Then
        wx_PropertyList.Free;

  //Create the new one
    wx_PropertyList := TStringList.Create;

    Try
        wx_PropertyList.Add('Wx_IDName:ID Name');
        wx_PropertyList.Add('Wx_IDValue:ID Value');
        wx_PropertyList.Add('Wx_Class:Class');
        wx_PropertyList.Add('Wx_Center:Center');
        wx_PropertyList.Add('Wx_HelpText:Help Text');
        wx_PropertyList.Add('Wx_ToolTips:Tooltip');
        wx_PropertyList.Add('Wx_Hidden:Hidden');
        wx_PropertyList.Add('Caption:Title');
        wx_PropertyList.Add('Height:Height');
        wx_PropertyList.Add('Width:Width');
        wx_PropertyList.Add('Left:Left');
        wx_PropertyList.Add('Top:Top');
        wx_PropertyList.Add('Font:Font');
        wx_PropertyList.Add('Wx_SizeToContents:Size to Contents');

        wx_PropertyList.Add('Wx_GeneralStyle:General Style');
        wx_PropertyList.Add('wxSIMPLE_BORDER:wxSIMPLE_BORDER');
        wx_PropertyList.Add('wxDOUBLE_BORDER:wxDOUBLE_BORDER');
        wx_PropertyList.Add('wxSUNKEN_BORDER:wxSUNKEN_BORDER');
        wx_PropertyList.Add('wxRAISED_BORDER:wxRAISED_BORDER');
        wx_PropertyList.Add('wxSTATIC_BORDER:wxSTATIC_BORDER');
        wx_PropertyList.Add('wxTRANSPARENT_WINDOW:wxTRANSPARENT_WINDOW');
        wx_PropertyList.Add('wxTAB_TRAVERSAL:wxTAB_TRAVERSAL');
        wx_PropertyList.Add('wxWANTS_CHARS:wxWANTS_CHARS');
        wx_PropertyList.Add('wxNO_FULL_REPAINT_ON_RESIZE:wxNO_FULL_REPAINT_ON_RESIZE');
        wx_PropertyList.Add('wxVSCROLL:wxVSCROLL');
        wx_PropertyList.Add('wxHSCROLL:wxHSCROLL');
        wx_PropertyList.Add('wxCLIP_CHILDREN:wxCLIP_CHILDREN');
        wx_PropertyList.Add('wxNO_BORDER:wxNO_BORDER');
        wx_PropertyList.Add('wxALWAYS_SHOW_SB:wxALWAYS_SHOW_SB');
        wx_PropertyList.Add('wxFULL_REPAINT_ON_RESIZE:wxFULL_REPAINT_ON_RESIZE');

        wx_PropertyList.Add('Wx_DialogStyle:Dialog Style');
        wx_PropertyList.Add('wxCAPTION:wxCAPTION');
        wx_PropertyList.Add('wxNO_3D:wxNO_3D');
        wx_PropertyList.Add('wxRESIZE_BORDER:wxRESIZE_BORDER');
        wx_PropertyList.Add('wxSYSTEM_MENU:wxSYSTEM_MENU');
        wx_PropertyList.Add('wxTHICK_FRAME:wxTHICK_FRAME');
        wx_PropertyList.Add('wxSTAY_ON_TOP:wxSTAY_ON_TOP');
        wx_PropertyList.Add('wxDIALOG_NO_PARENT:wxDIALOG_NO_PARENT');
        wx_PropertyList.Add('wxDIALOG_EX_CONTEXTHELP:wxDIALOG_EX_CONTEXTHELP');
        wx_PropertyList.Add('wxMINIMIZE_BOX:wxMINIMIZE_BOX');
        wx_PropertyList.Add('wxMAXIMIZE_BOX:wxMAXIMIZE_BOX');
        wx_PropertyList.Add('wxCLOSE_BOX:wxCLOSE_BOX');
        wx_PropertyList.Add('Wx_Name:Name');
        wx_PropertyList.Add('Wx_ICON:Icon');
    Except
        wx_PropertyList.Free;
        Raise;
    End;

End;

Procedure TfrmNewForm.SetFrameProperties();
Begin
  //Free the old property list
    If Assigned(wx_PropertyList) Then
        wx_PropertyList.Free;

  //Create the new one
    wx_PropertyList := TStringList.Create;

    wx_PropertyList.Add('Wx_SizeToContents:Size to Contents');
    wx_PropertyList.Add('Wx_IDName:ID Name');
    wx_PropertyList.Add('Wx_IDValue:ID Value');
    wx_PropertyList.Add('Wx_Class:Class');
    wx_PropertyList.Add('Wx_Center:Center');
    wx_PropertyList.Add('Wx_HelpText:Help Text');
    wx_PropertyList.Add('Wx_ToolTips:Tooltip');
    wx_PropertyList.Add('Wx_Hidden:Hidden');
    wx_PropertyList.Add('Caption:Title');
    wx_PropertyList.Add('Height:Height');
    wx_PropertyList.Add('Width:Width');
    wx_PropertyList.Add('Left:Left');
    wx_PropertyList.Add('Top:Top');
    wx_PropertyList.Add('Font:Font');

    wx_PropertyList.Add('Wx_GeneralStyle:General Style');
    wx_PropertyList.Add('wxSIMPLE_BORDER:wxSIMPLE_BORDER');
    wx_PropertyList.Add('wxDOUBLE_BORDER:wxDOUBLE_BORDER');
    wx_PropertyList.Add('wxSUNKEN_BORDER:wxSUNKEN_BORDER');
    wx_PropertyList.Add('wxRAISED_BORDER:wxRAISED_BORDER');
    wx_PropertyList.Add('wxSTATIC_BORDER:wxSTATIC_BORDER');
    wx_PropertyList.Add('wxTRANSPARENT_WINDOW:wxTRANSPARENT_WINDOW');
    wx_PropertyList.Add('wxTAB_TRAVERSAL:wxTAB_TRAVERSAL');
    wx_PropertyList.Add('wxWANTS_CHARS:wxWANTS_CHARS');
    wx_PropertyList.Add('wxNO_FULL_REPAINT_ON_RESIZE:wxNO_FULL_REPAINT_ON_RESIZE');
    wx_PropertyList.Add('wxVSCROLL:wxVSCROLL');
    wx_PropertyList.Add('wxHSCROLL:wxHSCROLL');
    wx_PropertyList.Add('wxCLIP_CHILDREN:wxCLIP_CHILDREN');
    wx_PropertyList.Add('wxNO_BORDER:wxNO_BORDER');
    wx_PropertyList.Add('wxALWAYS_SHOW_SB:wxALWAYS_SHOW_SB');
    wx_PropertyList.Add('wxFULL_REPAINT_ON_RESIZE:wxFULL_REPAINT_ON_RESIZE');

    wx_PropertyList.Add('Wx_DialogStyle:Frame Style');
    wx_PropertyList.Add('wxCAPTION:wxCAPTION');
    wx_PropertyList.Add('wxNO_3D:wxNO_3D');
    wx_PropertyList.Add('wxRESIZE_BORDER:wxRESIZE_BORDER');
    wx_PropertyList.Add('wxSYSTEM_MENU:wxSYSTEM_MENU');
    wx_PropertyList.Add('wxTHICK_FRAME:wxTHICK_FRAME');
    wx_PropertyList.Add('wxSTAY_ON_TOP:wxSTAY_ON_TOP');
    wx_PropertyList.Add('wxFRAME_NO_PARENT:wxFRAME_NO_PARENT');
    wx_PropertyList.Add('wxFRAME_EX_CONTEXTHELP:wxFRAME_EX_CONTEXTHELP');
    wx_PropertyList.Add('wxMINIMIZE_BOX:wxMINIMIZE_BOX');
    wx_PropertyList.Add('wxMAXIMIZE_BOX:wxMAXIMIZE_BOX');
    wx_PropertyList.Add('wxCLOSE_BOX:wxCLOSE_BOX');
    wx_PropertyList.Add('wxICONIZE:wxICONIZE');
    wx_PropertyList.Add('wxMINIMIZE:wxMINIMIZE');
    wx_PropertyList.Add('wxMAXIMIZE:wxMAXIMIZE');
    wx_PropertyList.Add('wxFRAME_TOOL_WINDOW:wxFRAME_TOOL_WINDOW');
    wx_PropertyList.Add('wxFRAME_NO_TASKBAR:wxFRAME_NO_TASKBAR');
    wx_PropertyList.Add('wxFRAME_FLOAT_ON_PARENT:wxFRAME_FLOAT_ON_PARENT');
    wx_PropertyList.Add('wxFRAME_SHAPED:wxFRAME_SHAPED');
    wx_PropertyList.Add('Wx_Name:Name');
    wx_PropertyList.Add('Wx_ICON:Icon');

End;

Function TfrmNewForm.GetParameterFromEventName(EventName: String): String;
Begin
    EventName := UpperCase(trim(EventName));

    If EventName = 'EVT_CHAR' Then
    Begin
        Result := 'wxKeyEvent& event';
        exit;
    End;

    If EventName = 'EVT_KEY_UP' Then
    Begin
        Result := 'wxKeyEvent& event';
        exit;
    End;

    If EventName = 'EVT_KEY_DOWN' Then
    Begin
        Result := 'wxKeyEvent& event';
        exit;
    End;

    If EventName = 'EVT_ERASE_BACKGROUND' Then
    Begin
        Result := 'wxEraseEvent& event';
        exit;
    End;

    If EventName = 'EVT_SIZE' Then
    Begin
        Result := 'wxSizeEvent& event';
        exit;
    End;

    If EventName = 'EVT_SET_FOCUS' Then
    Begin
        Result := 'wxFocusEvent& event';
        exit;
    End;

    If EventName = 'EVT_KILL_FOCUS' Then
    Begin
        Result := 'wxFocusEvent& event';
        exit;
    End;

    If EventName = 'EVT_ENTER_WINDOW' Then
    Begin
        Result := 'wxMouseEvent& event';
        exit;
    End;

    If EventName = 'EVT_LEAVE_WINDOW' Then
    Begin
        Result := 'wxMouseEvent& event';
        exit;
    End;

    If EventName = 'EVT_MOTION' Then
    Begin
        Result := 'wxMouseEvent& event';
        exit;
    End;

    If EventName = 'EVT_LEFT_DOWN' Then
    Begin
        Result := 'wxMouseEvent& event';
        exit;
    End;

    If EventName = 'EVT_LEFT_UP' Then
    Begin
        Result := 'wxMouseEvent& event';
        exit;
    End;

    If EventName = 'EVT_RIGHT_DOWN' Then
    Begin
        Result := 'wxMouseEvent& event';
        exit;
    End;

    If EventName = 'EVT_RIGHT_UP' Then
    Begin
        Result := 'wxMouseEvent& event';
        exit;
    End;

    If EventName = 'EVT_MIDDLE_DOWN' Then
    Begin
        Result := 'wxMouseEvent& event';
        exit;
    End;

    If EventName = 'EVT_MIDDLE_UP' Then
    Begin
        Result := 'wxMouseEvent& event';
        exit;
    End;

    If EventName = 'EVT_LEFT_DCLICK' Then
    Begin
        Result := 'wxMouseEvent& event';
        exit;
    End;

    If EventName = 'EVT_RIGHT_DCLICK' Then
    Begin
        Result := 'wxMouseEvent& event';
        exit;
    End;

    If EventName = 'EVT_MIDDLE_DCLICK' Then
    Begin
        Result := 'wxMouseEvent& event';
        exit;
    End;

    If EventName = 'EVT_PAINT' Then
    Begin
        Result := 'wxPaintEvent& event';
        exit;
    End;

    If EventName = 'EVT_INIT_DIALOG' Then
    Begin
        Result := 'wxInitDialogEvent& event';
        exit;
    End;

    If EventName = 'EVT_SCROLLWIN' Then
    Begin
        Result := 'wxScrollWinEvent& event';
        exit;
    End;

    If EventName = 'EVT_SCROLLWIN_TOP' Then
    Begin
        Result := 'wxScrollWinEvent& event';
        exit;
    End;

    If EventName = 'EVT_SCROLLWIN_BOTTOM' Then
    Begin
        Result := 'wxScrollWinEvent& event';
        exit;
    End;

    If EventName = 'EVT_SCROLLWIN_LINEUP' Then
    Begin
        Result := 'wxScrollWinEvent& event';
        exit;
    End;

    If EventName = 'EVT_SCROLLWIN_LINEDOWN' Then
    Begin
        Result := 'wxScrollWinEvent& event';
        exit;
    End;

    If EventName = 'EVT_SCROLLWIN_PAGEUP' Then
    Begin
        Result := 'wxScrollWinEvent& event';
        exit;
    End;

    If EventName = 'EVT_SCROLLWIN_PAGEDOWN' Then
    Begin
        Result := 'wxScrollWinEvent& event';
        exit;
    End;

    If EventName = 'EVT_SCROLLWIN_THUMBTRACK' Then
    Begin
        Result := 'wxScrollWinEvent& event';
        exit;
    End;

    If EventName = 'EVT_SCROLLWIN_THUMBRELEASE' Then
    Begin
        Result := 'wxScrollWinEvent& event';
        exit;
    End;

    If EventName = 'EVT_SYS_COLOUR_CHANGED' Then
    Begin
        Result := 'wxSysColourChangedEvent& event';
        exit;
    End;

    If EventName = 'EVT_UPDATE_UI' Then
    Begin
        Result := 'wxUpdateUIEvent& event';
        exit;
    End;

    If EventName = 'EVT_CLOSE' Then
    Begin
        Result := 'wxCloseEvent& event';
        exit;
    End;

    If EventName = 'EVT_IDLE' Then
    Begin
        Result := 'wxIdleEvent& event';
        exit;
    End;
    If EventName = 'EVT_ACTIVATE' Then
    Begin
        Result := 'wxActivateEvent& event';
        exit;
    End;
    If EventName = 'EVT_ACTIVATE_APP' Then
    Begin
        Result := 'wxActivateEvent& event';
        exit;
    End;
    If EventName = 'EVT_QUERY_END_SESSION' Then
    Begin
        Result := 'wxCloseEvent& event';
        exit;
    End;
    If EventName = 'EVT_END_SESSION' Then
    Begin
        Result := 'wxCloseEvent& event';
        exit;
    End;
    If EventName = 'EVT_DROP_FILES' Then
    Begin
        Result := 'wxDropFilesEvent& event';
        exit;
    End;
    If EventName = 'EVT_SPLITTER_SASH_POS_CHANGED' Then
    Begin
        Result := 'wxSplitterEvent& event';
        exit;
    End;
    If EventName = 'EVT_SPLITTER_UNSPLIT' Then
    Begin
        Result := 'wxSplitterEvent& event';
        exit;
    End;
    If EventName = 'EVT_SPLITTER_DCLICK' Then
    Begin
        Result := 'wxSplitterEvent& event';
        exit;
    End;
    If EventName = 'EVT_JOY_BUTTON_DOWN' Then
    Begin
        Result := 'wxJoystickEvent& event';
        exit;
    End;
    If EventName = 'EVT_JOY_BUTTON_UP' Then
    Begin
        Result := 'wxJoystickEvent& event';
        exit;
    End;
    If EventName = 'EVT_JOY_MOVE' Then
    Begin
        Result := 'wxJoystickEvent& event';
        exit;
    End;
    If EventName = 'EVT_JOY_ZMOVE' Then
    Begin
        Result := 'wxJoystickEvent& event';
        exit;
    End;
    If EventName = 'EVT_MENU_OPEN' Then
    Begin
        Result := 'wxMenuEvent& event';
        exit;
    End;
    If EventName = 'EVT_MENU_CLOSE' Then
    Begin
        Result := 'wxMenuEvent& event';
        exit;
    End;
    If EventName = 'EVT_MENU_HIGHLIGHT_ALL' Then
    Begin
        Result := 'wxMenuEvent& event';
        exit;
    End;
    If EventName = 'EVT_MOUSEWHEEL' Then
    Begin
        Result := 'wxMouseEvent& event';
        exit;
    End;
    If EventName = 'EVT_MOUSE_EVENTS' Then
    Begin
        Result := 'wxMouseEvent& event';
        exit;
    End;

    Result := 'void';
End;

Function TfrmNewForm.GetTypeFromEventName(EventName: String): String;
Begin
    Result := 'void';
End;

Procedure TfrmNewForm.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin
  //Result:=WxControlNone;
End;

Function TfrmNewForm.GetStretchFactor: Integer;
Begin
    Result := 0;
End;

Procedure TfrmNewForm.SetStretchFactor(intValue: Integer);
Begin
End;

Function TfrmNewForm.GetEventList: TStringList;
Begin
    Result := FWx_EventList;
End;

Function TfrmNewForm.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TfrmNewForm.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TfrmNewForm.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TfrmNewForm.SetBorderWidth(width: Integer);
Begin
End;

Procedure TfrmNewForm.FormMove(Var Msg: TWMMove);
Begin
    wx_designer.ELDesigner1Modified(wx_designer.ELDesigner1);
    Inherited;
End;

Function TfrmNewForm.GenerateControlIDs: String;
Begin
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d', [Wx_IDName, Wx_IDValue]);
End;

Function TfrmNewForm.GenerateEnumControlIDs: String;
Begin
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('%s = %d,', [Wx_IDName, Wx_IDValue]);
End;


Function TfrmNewForm.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
    If trim(EVT_UPDATE_UI) <> '' Then
        Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
            [trim(Self.wx_IDName), CurrClassName, EVT_UPDATE_UI]) + '';


    If trim(EVT_CLOSE) <> '' Then
        Result := Result + #13 + Format('EVT_CLOSE(%s::%s)',
            [CurrClassName, EVT_CLOSE]) + '';


    If trim(EVT_CHAR) <> '' Then
        Result := Result + #13 + Format('EVT_CHAR(%s::%s)', [CurrClassName,
            EVT_CHAR]) + '';

    If trim(EVT_KEY_UP) <> '' Then
        Result := Result + #13 + Format('EVT_KEY_UP(%s::%s)', [CurrClassName,
            EVT_KEY_UP]) + '';

    If trim(EVT_KEY_DOWN) <> '' Then
        Result := Result + #13 + Format('EVT_KEY_DOWN(%s::%s)', [CurrClassName,
            EVT_KEY_DOWN]) + '';

    If trim(EVT_ERASE_BACKGROUND) <> '' Then
        Result := Result + #13 + Format('EVT_ERASE_BACKGROUND(%s::%s)',
            [CurrClassName, EVT_ERASE_BACKGROUND]) + '';

    If trim(EVT_SIZE) <> '' Then
        Result := Result + #13 + Format('EVT_SIZE(%s::%s)', [CurrClassName,
            EVT_SIZE]) + '';

    If trim(EVT_SET_FOCUS) <> '' Then
        Result := Result + #13 + Format('EVT_SET_FOCUS(%s::%s)', [CurrClassName,
            EVT_SET_FOCUS]) + '';

    If trim(EVT_KILL_FOCUS) <> '' Then
        Result := Result + #13 + Format('EVT_KILL_FOCUS(%s::%s)', [CurrClassName,
            EVT_KILL_FOCUS]) + '';

    If trim(EVT_ENTER_WINDOW) <> '' Then
        Result := Result + #13 + Format('EVT_ENTER_WINDOW(%s::%s)', [CurrClassName,
            EVT_ENTER_WINDOW]) + '';

    If trim(EVT_LEAVE_WINDOW) <> '' Then
        Result := Result + #13 + Format('EVT_LEAVE_WINDOW(%s::%s)', [CurrClassName,
            EVT_LEAVE_WINDOW]) + '';

    If trim(EVT_MOTION) <> '' Then
        Result := Result + #13 + Format('EVT_MOTION(%s::%s)', [CurrClassName,
            EVT_MOTION]) + '';

    If trim(EVT_LEFT_DOWN) <> '' Then
        Result := Result + #13 + Format('EVT_LEFT_DOWN(%s::%s)', [CurrClassName,
            EVT_LEFT_DOWN]) + '';

    If trim(EVT_LEFT_UP) <> '' Then
        Result := Result + #13 + Format('EVT_LEFT_UP(%s::%s)', [CurrClassName,
            EVT_LEFT_UP]) + '';

    If trim(EVT_RIGHT_DOWN) <> '' Then
        Result := Result + #13 + Format('EVT_RIGHT_DOWN(%s::%s)', [CurrClassName,
            EVT_RIGHT_DOWN]) + '';

    If trim(EVT_RIGHT_UP) <> '' Then
        Result := Result + #13 + Format('EVT_RIGHT_UP(%s::%s)', [CurrClassName,
            EVT_RIGHT_UP]) + '';

    If trim(EVT_MIDDLE_UP) <> '' Then
        Result := Result + #13 + Format('EVT_MIDDLE_UP(%s::%s)', [CurrClassName,
            EVT_MIDDLE_UP]) + '';

    If trim(EVT_LEFT_DCLICK) <> '' Then
        Result := Result + #13 + Format('EVT_LEFT_DCLICK(%s::%s)', [CurrClassName,
            EVT_LEFT_DCLICK]) + '';

    If trim(EVT_RIGHT_DCLICK) <> '' Then
        Result := Result + #13 + Format('EVT_RIGHT_DCLICK(%s::%s)', [CurrClassName,
            EVT_RIGHT_DCLICK]) + '';

    If trim(EVT_MIDDLE_DCLICK) <> '' Then
        Result := Result + #13 + Format('EVT_MIDDLE_DCLICK(%s::%s)', [CurrClassName,
            EVT_MIDDLE_DCLICK]) + '';

    If trim(EVT_PAINT) <> '' Then
        Result := Result + #13 + Format('EVT_PAINT(%s::%s)', [CurrClassName,
            EVT_PAINT]) + '';

    If trim(EVT_INIT_DIALOG) <> '' Then
        Result := Result + #13 + Format('EVT_INIT_DIALOG(%s::%s)', [CurrClassName,
            EVT_INIT_DIALOG]) + '';

    If trim(EVT_SCROLLWIN) <> '' Then
        Result := Result + #13 + Format('EVT_SCROLLWIN(%s::%s)', [CurrClassName,
            EVT_SCROLLWIN]) + '';

    If trim(EVT_SCROLLWIN_TOP) <> '' Then
        Result := Result + #13 + Format('EVT_SCROLLWIN_TOP(%s::%s)', [CurrClassName,
            EVT_SCROLLWIN_TOP]) + '';

    If trim(EVT_SCROLLWIN_BOTTOM) <> '' Then
        Result := Result + #13 + Format('EVT_SCROLLWIN_BOTTOM(%s::%s)',
            [CurrClassName, EVT_SCROLLWIN_BOTTOM]) + '';

    If trim(EVT_SCROLLWIN_LINEUP) <> '' Then
        Result := Result + #13 + Format('EVT_SCROLLWIN_LINEUP(%s::%s)',
            [CurrClassName, EVT_SCROLLWIN_LINEUP]) + '';

    If trim(EVT_SCROLLWIN_LINEDOWN) <> '' Then
        Result := Result + #13 + Format('EVT_SCROLLWIN_LINEDOWN(%s::%s)',
            [CurrClassName, EVT_SCROLLWIN_LINEDOWN]) + '';

    If trim(EVT_SCROLLWIN_PAGEUP) <> '' Then
        Result := Result + #13 + Format('EVT_SCROLLWIN_PAGEUP(%s::%s)',
            [CurrClassName, EVT_SCROLLWIN_PAGEUP]) + '';

    If trim(EVT_SCROLLWIN_PAGEDOWN) <> '' Then
        Result := Result + #13 + Format('EVT_SCROLLWIN_PAGEDOWN(%s::%s)',
            [CurrClassName, EVT_SCROLLWIN_PAGEDOWN]) + '';

    If trim(EVT_SCROLLWIN_THUMBTRACK) <> '' Then
        Result := Result + #13 + Format('EVT_SCROLLWIN_THUMBTRACK(%s::%s)',
            [CurrClassName, EVT_SCROLLWIN_THUMBTRACK]) + '';

    If trim(EVT_SCROLLWIN_THUMBRELEASE) <> '' Then
        Result := Result + #13 + Format('EVT_SCROLLWIN_THUMBRELEASE(%s::%s)',
            [CurrClassName, EVT_SCROLLWIN_THUMBRELEASE]) + '';

    If trim(EVT_SYS_COLOUR_CHANGED) <> '' Then
        Result := Result + #13 + Format('EVT_SYS_COLOUR_CHANGED(%s::%s)',
            [CurrClassName, EVT_SYS_COLOUR_CHANGED]) + '';
    If trim(EVT_IDLE) <> '' Then
        Result := Result + #13 + Format('EVT_IDLE(%s::%s)',
            [CurrClassName, EVT_IDLE]) + '';
    If trim(EVT_ACTIVATE) <> '' Then
        Result := Result + #13 + Format('EVT_ACTIVATE(%s::%s)',
            [CurrClassName, EVT_ACTIVATE]) + '';
    If trim(EVT_ACTIVATE_APP) <> '' Then
        Result := Result + #13 + Format('EVT_ACTIVATE_APP(%s::%s)',
            [CurrClassName, EVT_ACTIVATE_APP]) + '';
    If trim(EVT_QUERY_END_SESSION) <> '' Then
        Result := Result + #13 + Format('EVT_QUERY_END_SESSION(%s::%s)',
            [CurrClassName, EVT_QUERY_END_SESSION]) + '';
    If trim(EVT_END_SESSION) <> '' Then
        Result := Result + #13 + Format('EVT_END_SESSION(%s::%s)',
            [CurrClassName, EVT_END_SESSION]) + '';
    If trim(EVT_DROP_FILES) <> '' Then
        Result := Result + #13 + Format('EVT_DROP_FILES(%s::%s)',
            [CurrClassName, EVT_DROP_FILES]) + '';
    If trim(EVT_SPLITTER_SASH_POS_CHANGED) <> '' Then
        Result := Result + #13 + Format('EVT_SPLITTER_SASH_POS_CHANGED(%s::%s)',
            [CurrClassName, EVT_SPLITTER_SASH_POS_CHANGED]) + '';
    If trim(EVT_SPLITTER_UNSPLIT) <> '' Then
        Result := Result + #13 + Format('EVT_SPLITTER_UNSPLIT(%s::%s)',
            [CurrClassName, EVT_SPLITTER_UNSPLIT]) + '';
    If trim(EVT_SPLITTER_DCLICK) <> '' Then
        Result := Result + #13 + Format('EVT_SPLITTER_DCLICK(%s::%s)',
            [CurrClassName, EVT_SPLITTER_DCLICK]) + '';
    If trim(EVT_JOY_BUTTON_DOWN) <> '' Then
        Result := Result + #13 + Format('EVT_JOY_BUTTON_DOWN(%s::%s)',
            [CurrClassName, EVT_JOY_BUTTON_DOWN]) + '';
    If trim(EVT_JOY_BUTTON_UP) <> '' Then
        Result := Result + #13 + Format('EVT_JOY_BUTTON_UP(%s::%s)',
            [CurrClassName, EVT_JOY_BUTTON_UP]) + '';
    If trim(EVT_JOY_MOVE) <> '' Then
        Result := Result + #13 + Format('EVT_JOY_MOVE(%s::%s)',
            [CurrClassName, EVT_JOY_MOVE]) + '';
    If trim(EVT_JOY_ZMOVE) <> '' Then
        Result := Result + #13 + Format('EVT_JOY_ZMOVE(%s::%s)',
            [CurrClassName, EVT_JOY_ZMOVE]) + '';
    If trim(EVT_MENU_OPEN) <> '' Then
        Result := Result + #13 + Format('EVT_MENU_OPEN(%s::%s)',
            [CurrClassName, EVT_MENU_OPEN]) + '';
    If trim(EVT_MENU_CLOSE) <> '' Then
        Result := Result + #13 + Format('EVT_MENU_CLOSE(%s::%s)',
            [CurrClassName, EVT_MENU_CLOSE]) + '';
    If trim(EVT_MENU_HIGHLIGHT_ALL) <> '' Then
        Result := Result + #13 + Format('EVT_MENU_HIGHLIGHT_ALL(%s::%s)',
            [CurrClassName, EVT_MENU_HIGHLIGHT_ALL]) + '';
    If trim(EVT_MOUSEWHEEL) <> '' Then
        Result := Result + #13 + Format('EVT_MOUSEWHEEL(%s::%s)',
            [CurrClassName, EVT_MOUSEWHEEL]) + '';
    If trim(EVT_MOUSE_EVENTS) <> '' Then
        Result := Result + #13 + Format('EVT_MOUSE_EVENTS(%s::%s)',
            [CurrClassName, EVT_MOUSE_EVENTS]) + '';

End;

Function TfrmNewForm.GetDialogStyleString: String;
Begin
  // This used to be hardcoded as THIS_DIALOG_STYLE
    If (self.Wx_DialogStyle <> []) Or (self.Wx_GeneralStyle <> []) Then
        Result := GetDialogSpecificStyle(self.Wx_GeneralStyle, self.Wx_DialogStyle,
            self.Wx_Class)
    Else
    If (strEqual(self.Wx_Class, 'wxDialog')) Then
        Result := 'wxDEFAULT_DIALOG_STYLE'
    Else
    If (strEqual(self.Wx_Class, 'wxFrame')) Then
        Result := 'wxDEFAULT_FRAME_STYLE';

End;

Function TfrmNewForm.GenerateXRCControlCreation(IndentString: String): TStringList;
Begin
    Result := TStringList.Create;
End;

Function TfrmNewForm.GenerateGUIControlCreation: String;
Var
    I, J, MaxToolWidth, MaxToolHt, MaxSepValue: Integer;
    strLst: TStringList;
    isSizerAvailable: Boolean;
  //  isAuimanagerAvailable: boolean;
    //WinRect: TRect;
    wxtoolbarintf: IWxToolBarInterface;
    strTemp: String;
    sizerParentName: String;
Begin
    strLst := TStringList.Create;

    If self.Wx_DesignerType = dtWxFrame Then
   // for I := self.ComponentCount - 1 downto 0 do    // Iterate
        For I := 0 To self.ComponentCount - 1 Do    // Iterate
        Begin
            If IsControlWxToolBar(TControl(Components[i])) Then
            Begin
                MaxToolWidth := 16;
                MaxToolHt := 15;
                MaxSepValue := 5;
                For J := 0 To TWinControl(Components[i]).ControlCount - 1 Do
          // Iterate
                Begin
                    If (TWinControl(Components[i]).Controls[J] Is TWxSeparator) Then
                        If TWinControl(Components[i]).Controls[J].Width > MaxSepValue Then
                            MaxSepValue := TWinControl(Components[i]).Controls[J].Width;

                    If (TWinControl(Components[i]).Controls[J] Is TWxToolButton) Then
                        If TWxToolButton(TWinControl(Components[i]).Controls[J]).Wx_BITMAP.Bitmap <> Nil Then
                        Begin
                            If TWxToolButton(TWinControl(Components[i]).Controls[J]).Wx_BITMAP.Bitmap.Height > MaxToolHt Then
                                MaxToolHt :=
                                    TWxToolButton(TWinControl(Components[i]).Controls[J]).Wx_BITMAP.Bitmap.Height;

                            If TWxToolButton(TWinControl(Components[i]).Controls[J]).Wx_BITMAP.Bitmap.Width > MaxToolWidth Then
                                MaxToolWidth :=
                                    TWxToolButton(TWinControl(Components[i]).Controls[J]).Wx_BITMAP.Bitmap.Width;
                        End;
                End;    // for

                If Not (XRCGEN) Then //NUKLEAR ZELPH
	               Begin
                    If Not ((MaxToolWidth = 16) And (MaxToolHt = 15)) Then
                        strLst.add(Format('%s->SetToolBitmapSize(wxSize(%d,%d));',
                            [self.Components[i].Name, MaxToolWidth, MaxToolHt]));

                    If (MaxSepValue <> 5) Then
                        strLst.add(Format('%s->SetToolSeparation(%d);',
                            [self.Components[i].Name, MaxSepValue]));

                    If Self.Components[i].GetInterface(IID_IWxToolBarInterface, wxtoolbarintf) Then
                    Begin
                        strTemp := wxtoolbarintf.GetRealizeString;
                        strLst.add(strTemp);
                    End;

          {          if not IsControlWxAuiToolBar(TControl(Components[i])) then
          begin
        strLst.add(Format('%s->Realize();', [self.Components[i].Name]));
        strLst.add(Format('SetToolBar(%s);', [self.Components[i].Name]));
          end;
          if IsControlWxAuiToolBar(TControl(Components[i])) then
          begin
            strLst.add(Format('%s->Realize();', [self.Components[i].Name]));
          end;
 }
                End; //not xrcgen
            End;

            If IsControlWxStatusBar(TControl(Components[i])) Then
                strLst.add(Format('SetStatusBar(%s);', [self.Components[i].Name]));
        End;

    isSizerAvailable := False;
    sizerParentName := '';
    isAuimanagerAvailable := False;
    For I := 0 To self.ComponentCount - 1 Do
    Begin // Iterate
        If self.Components[i] Is TWxSizerPanel Then
        Begin
            If Not (isSizerAvailable) Then
            Begin
                isSizerAvailable := True;

        // Bug fix for #2695519
        // Need to refer to parent name rather than always referring to 'this->'
                If (TControl(Components[i]).Parent Is TForm) Then
                    sizerParentName := '' //'this' + '->'
                Else
                    sizerParentName := TControl(Components[i]).Parent.Name + '->';
            End;
      //      break;
        End;
        If self.Components[i] Is TWxAuiManager Then
        Begin
            isAuimanagerAvailable := True;
      //      break;
        End;
    End;
    strLst.add(Format('SetTitle(%s);', [GetCppString(self.Caption)]));

    If assigned(Wx_ICON) Then
    Begin
        If Wx_ICON.Bitmap.Handle = 0 Then
            strLst.add('SetIcon(wxNullIcon);')
        Else
        If (KeepFormat) Then
        Begin
            Wx_FileName := AnsiReplaceText(Wx_FileName, '\', '/');
            strLst.add('SetIcon(' + 'wxIcon("' + Wx_FileName + '", wxBITMAP_TYPE_' +
                GetExtension(Wx_FileName) + '));');
        End
        Else
        Begin
      //strLst.add('wxIcon ' + self.Wx_Name + '_ICON' + ' (' +Self_'+self.Wx_Name + '_XPM' + ');');
            strLst.add('SetIcon(' + 'Self_' + self.Wx_Name + '_XPM' + ');');
        End;
    End;

    If trim(self.Wx_ToolTips) <> '' Then
        strLst.add(Format('SetToolTip(%s);', [GetCppString(self.Wx_ToolTips)]));

    If isSizerAvailable And Not isAuiManagerAvailable Then
    Begin
        If strLst.Count <> 0 Then
            strLst.add('');

        If (sizerParentName = '') Then
        Begin
            strLst.Add('Layout();');
            strLst.add('GetSizer()->Fit(this);');
            If Wx_SizeToContents Then
                strLst.add('GetSizer()->SetSizeHints(this);');
        End;
    End
    Else
    Begin
        strLst.add(Format('SetSize(%d,%d,%d,%d);', [self.left, self.top, self.Width, self.Height]));
    End;

    If self.Wx_Center Then
        strLst.add('Center();');

    If isAuiManagerAvailable Then
    Begin
        If self.Wx_DesignerType = dtWxFrame Then
            For I := self.ComponentCount - 1 Downto 0 Do // Iterate
                If IsControlWxToolBar(TControl(Components[i])) And Not IsControlWxAuiToolBar(TControl(Components[i])) Then
                Begin
                    strLst.add('SetToolBar(NULL);');
                    break;
                End;

        For I := self.ComponentCount - 1 Downto 0 Do // Iterate
        Begin
            If self.Components[i] Is TWxAuiManager Then
            Begin
                strLst.add(Format('%s->Update();', [self.Components[i].Name]));
            End;
        End;
    End;

    Result := strLst.Text;
    strLst.Destroy;

End;

Function TfrmNewForm.GenerateGUIControlDeclaration: String;
Begin
  //Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
End;

Function TfrmNewForm.GenerateHeaderInclude: String;
Begin
    Result := '';
End;

Function TfrmNewForm.GenerateImageInclude: String;
Begin
    If assigned(Wx_ICON) Then
        If Wx_ICON.Bitmap.Handle <> 0 Then
            If (Not KeepFormat) Then
                Result := '#include "' + GetGraphicFileName + '"';

End;


Function TfrmNewForm.GetIDName: String;
Begin
    Result := wx_IDName;
End;

Function TfrmNewForm.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TfrmNewForm.GetPropertyList: TStringList;
Begin
    Result := Wx_PropertyList;
End;

Function TfrmNewForm.GetWxClassName: String;
Begin
    If trim(Wx_Class) = '' Then
    Begin
        If Wx_DesignerType = dtWxDialog Then
            Wx_Class := 'wxDialog';

        If Wx_DesignerType = dtWxFrame Then
            Wx_Class := 'wxFrame';

        If Wx_DesignerType = dtWxWizard Then
            Wx_Class := 'wxWizard';

    End;
    Result := wx_Class;
End;

Procedure TfrmNewForm.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TfrmNewForm.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDValue;
End;

Procedure TfrmNewForm.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Procedure TfrmNewForm.CreateInitVars;
Begin
    OldCreateOrder := True;
    AutoScroll := False;
    Caption := 'New Dialog';
    Wx_IDName := 'ID_DIALOG1';
    Wx_IDValue := 1000;
    Wx_Class := 'wxDialog';
    Wx_Center := False;
    Wx_ToolTips := '';
    Wx_Hidden := False;
    Wx_SizeToContents := True;
    Wx_Icon := TPicture.Create;

    SetDialogProperties;
    FWx_EventList := TStringList.Create;
    FWx_EventList.add('  EVT_CLOSE: OnClose');
    FWx_EventList.add('  EVT_CHAR: OnChar');
    FWx_EventList.add('  EVT_KEY_UP: OnKeyUp');
    FWx_EventList.add('  EVT_KEY_DOWN: OnKeyDown');
    FWx_EventList.add('  EVT_ERASE_BACKGROUND: OnEraseBackground');
    FWx_EventList.add('  EVT_SIZE: OnSize');
    FWx_EventList.add('  EVT_SET_FOCUS: OnSetFocus');
    FWx_EventList.add('  EVT_KILL_FOCUS: OnKillFocus');
    FWx_EventList.add('  EVT_ENTER_WINDOW: OnEnterWindow');
    FWx_EventList.add('  EVT_LEAVE_WINDOW: OnLeaveWindow');
    FWx_EventList.add('  EVT_MOTION: OnMouseMotion');
    FWx_EventList.add('  EVT_LEFT_DOWN: OnLeftDown');
    FWx_EventList.add('  EVT_LEFT_UP: OnLeftUP');
    FWx_EventList.add('  EVT_RIGHT_DOWN: OnRightDown');
    FWx_EventList.add('  EVT_RIGHT_UP: OnRightUP');
    FWx_EventList.add('  EVT_MIDDLE_DOWN: OnMiddleDown');
    FWx_EventList.add('  EVT_MIDDLE_UP: OnMiddleUP');
    FWx_EventList.add('  EVT_LEFT_DCLICK: OnLeftDclick');
    FWx_EventList.add('  EVT_RIGHT_DCLICK: OnRightDclick');
    FWx_EventList.add('  EVT_MIDDLE_DCLICK: OnMiddleDclick');
    FWx_EventList.add('  EVT_PAINT: OnPaint');
    FWx_EventList.add('  EVT_INIT_DIALOG: OnInitDialog');
    FWx_EventList.add('  EVT_SCROLLWIN: OnScrollWin');
    FWx_EventList.add('  EVT_SCROLLWIN_TOP: OnScrollWinTop');
    FWx_EventList.add('  EVT_SCROLLWIN_BOTTOM: OnScrollWinBottom');
    FWx_EventList.add('  EVT_SCROLLWIN_LINEUP: OnScrollWinLineUp');
    FWx_EventList.add('  EVT_SCROLLWIN_LINEDOWN: OnScrollWinLineDown');
    FWx_EventList.add('  EVT_SCROLLWIN_PAGEUP: OnScrollWinPageUp');
    FWx_EventList.add('  EVT_SCROLLWIN_PAGEDOWN: OnScrollWinPageDown');
    FWx_EventList.add('  EVT_SCROLLWIN_THUMBTRACK: OnScrollWinThumbTrack');
    FWx_EventList.add('  EVT_SCROLLWIN_THUMBRELEASE: OnScrollWinThumbRelease');
    FWx_EventList.add('  EVT_SYS_COLOUR_CHANGED: OnColourChanged');
    FWx_EventList.add('  EVT_IDLE :OnIdle');
    FWx_EventList.add('  EVT_ACTIVATE :OnActivate');
    FWx_EventList.add('  EVT_ACTIVATE_APP :OnActivateApp');
    FWx_EventList.add('  EVT_QUERY_END_SESSION :OnQueryEndSession');
    FWx_EventList.add('  EVT_END_SESSION :OnEndSession');
    FWx_EventList.add('  EVT_DROP_FILES :OnDropFiles');
    FWx_EventList.add('  EVT_SPLITTER_SASH_POS_CHANGED  :OnSplitterSashPosChanged');
    FWx_EventList.add('  EVT_SPLITTER_UNSPLIT :OnSplitterUnSplit');
    FWx_EventList.add('  EVT_SPLITTER_DCLICK :OnSplitterDoubleClick');
    FWx_EventList.add('  EVT_JOY_BUTTON_DOWN :OnJoyButtonDown');
    FWx_EventList.add('  EVT_JOY_BUTTON_UP :OnJoyButtonUp');
    FWx_EventList.add('  EVT_JOY_MOVE :OnJoyMove');
    FWx_EventList.add('  EVT_JOY_ZMOVE :OnJoyZMove');
    FWx_EventList.add('  EVT_MENU_OPEN :OnMenuOpen');
    FWx_EventList.add('  EVT_MENU_CLOSE :OnMenuClose');
    FWx_EventList.add('  EVT_MENU_HIGHLIGHT_ALL :OnMenuHightLightAll');
    FWx_EventList.add('  EVT_MOUSEWHEEL :OnMouseWheel');
    FWx_EventList.add('  EVT_MOUSE_EVENTS :OnMouseEvents');
End;

Procedure TfrmNewForm.FormCreate(Sender: TObject);
Var
    hMenuHandle: HMENU;

Begin
    DesktopFont := True;
    CreateInitVars;
    If (Self.Handle <> 0) Then
    Begin
        hMenuHandle := GetSystemMenu(Self.Handle, False);
        If (hMenuHandle <> 0) Then
        Begin
            DeleteMenu(hMenuHandle, SC_CLOSE, MF_BYCOMMAND);
            DeleteMenu(hMenuHandle, SC_MAXIMIZE, MF_BYCOMMAND);
        End;
    End;

End;

Procedure TfrmNewForm.FormResize(Sender: TObject);
Begin
    wx_designer.ELDesigner1Modified(wx_designer.ELDesigner1);
End;

Procedure TfrmNewForm.FormDestroy(Sender: TObject);
Begin
    Wx_PropertyList.Destroy;
    FWx_EventList.Destroy;
    FWx_Icon.Destroy;
End;

Function TfrmNewForm.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TfrmNewForm.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TfrmNewForm.GetFGColor: String;
Begin
    Result := Wx_ProxyFGColorString.strColorValue;
End;

Procedure TfrmNewForm.SetFGColor(strValue: String);
Begin
    Wx_ProxyFGColorString.strColorValue := strValue;
    self.Color := GetColorFromString(strValue);
End;

Function TfrmNewForm.GetBGColor: String;
Begin
    Result := Wx_ProxyBGColorString.strColorValue;
End;

Procedure TfrmNewForm.SetBGColor(strValue: String);
Begin
    Wx_ProxyBGColorString.strColorValue := strValue;
    self.Font.Color := GetColorFromString(strValue);
End;

Procedure TfrmNewForm.SetDesignerType(Value: TWxDesignerType);
Begin

    Wx_Class := 'wxDialog';

    If Value = dtWxFrame Then
    Begin
        Wx_Class := 'wxFrame';
        self.Color := clAppWorkSpace;
    //self.BorderStyle:=bsSingle;
        SetFrameProperties();
    End;

    If Value = dtWxWizard Then
        Wx_Class := 'wxWizard';
    FWxDesignerType := Value;

End;

Function TfrmNewForm.GetFormName: String;
Begin
    Result := FWx_Name;
End;

Procedure TfrmNewForm.SetFormName(StrValue: String);
Begin
    FWx_Name := strValue;
End;

Procedure TfrmNewForm.CreateNewXPMs(strFileName: String);
Var
    i, j: Integer;
    imgCtrl: IWxImageContainerInterface;
    mnuCtrl: IWxMenuBarInterface;
    bmp: TBitmap;
    strPropertyName, strXPMFileName: String;
Begin
    For i := 0 To self.ComponentCount - 1 Do
    Begin
        If self.Components[i].GetInterface(IID_IWxImageContainerInterface, imgCtrl) = False Then
        Begin
            If self.Components[i].GetInterface(IDD_IWxMenuBarInterface, mnuCtrl) = True Then
                mnuCtrl.GenerateXPM(strFileName);
            continue;
        End;

        For j := 0 To imgCtrl.GetBitmapCount - 1 Do
        Begin
            If Not imgCtrl.PreserveFormat Then
            Begin
                strXPMFileName := IncludeTrailingPathDelimiter(ExtractFilePath(strFileName)) + 'Images\' + Wx_Name + '_' + imgCtrl.GetPropertyName(j) + '.xpm';
                If FileExists(strXPMFileName) Then
                    continue;
                bmp := Nil;
                imgCtrl.GetBitmap(j, bmp, strPropertyName);
                If bmp <> Nil Then
                    GenerateXPMDirectly(bmp, strPropertyName, wx_Name, strFileName);
            End;
        End;
    End;
    strXPMFileName := 'Images\Self_' + wx_Name + '.xpm';
    If FileExists(strXPMFileName) And (Wx_ICON.Bitmap <> Nil) Then
    Begin
        GenerateXPMDirectly(Wx_ICON.Bitmap, 'Self', wx_Name, strFileName);
    End;
End;

Function TfrmNewForm.GetBitmapCount: Integer;
Begin
    Result := 1;
End;

Function TfrmNewForm.GetBitmap(Idx: Integer; Var bmp: TBitmap; Var PropertyName: String): Boolean;
Begin
    bmp.Assign(Wx_ICON.Bitmap);
    Result := True;
End;


Function TfrmNewForm.GetPropertyName(Idx: Integer): String;
Begin
    Result := wx_Name;
End;

Function TfrmNewForm.GetGraphicFileName: String;
Begin
    Result := Wx_FileName;
End;

Function TfrmNewForm.SetGraphicFileName(strFileName: String): Boolean;
Begin

  // If no filename passed, then auto-generate XPM filename
    If (strFileName = '') Then
        strFileName := GetDesignerFormName(self) + '_' + self.Name + '_XPM.xpm';

    If Not KeepFormat Then
        strFileName := 'Images\' + strFileName;

    Wx_Filename := CreateGraphicFileName(strFileName);
    Result := True;

End;

Procedure TfrmNewForm.FormClick(Sender: TObject);
Begin
    If (wx_designer.ELDesigner1.Floating) Then
    Begin
        wx_designer.main.SetPageControlActivePageEditor(ChangeFileExt(self.fileName, WXFORM_EXT));
        wx_designer.MainPageChanged(ChangeFileExt(self.fileName, WXFORM_EXT));
        self.Show;
    End;
End;

Procedure TfrmNewForm.WMNCLButtonDown(Var Msg: TWMNCLButtonDown);
Begin
    If (Msg.HitTest = htCaption) And (wx_designer.ELDesigner1.Floating) Then
    Begin
        wx_designer.main.SetPageControlActivePageEditor(ChangeFileExt(self.fileName, WXFORM_EXT));
        wx_designer.MainPageChanged(ChangeFileExt(self.fileName, WXFORM_EXT));
        self.Show;
    End;
    Inherited;
End;

Procedure TfrmNewForm.WMNCRButtonDown(Var Msg: TWMNCRButtonDown);
Begin
    If (Msg.HitTest = htCaption) And (wx_designer.ELDesigner1.Floating) Then
    Begin
        wx_designer.main.SetPageControlActivePageEditor(ChangeFileExt(self.fileName, WXFORM_EXT));
        wx_designer.MainPageChanged(ChangeFileExt(self.fileName, WXFORM_EXT));
        self.Show;
    End;
    Inherited;
End;

Function TfrmNewForm.HasAuiManager: Boolean;
Begin
    Result := Self.isAuimanagerAvailable;
End;

{ Read method for property Wx_DialogStyle }
Function TfrmNewForm.GetWx_DialogStyle: TWxDlgStyleSet;
Begin
    Result := FWxFrm_DialogStyle;
End;

Function GetRefinedWxDialogStyleValue(sValue: TWxDlgStyleSet): TWxDlgStyleSet;
Begin
    Result := [];

    Try

        If wxCAPTION In sValue Then
            Result := Result + [wxCAPTION];

        If wxRESIZE_BORDER In sValue Then
            Result := Result + [wxRESIZE_BORDER];

        If wxSYSTEM_MENU In sValue Then
            Result := Result + [wxSYSTEM_MENU];

        If wxTHICK_FRAME In sValue Then
            Result := Result + [wxTHICK_FRAME];

        If wxSTAY_ON_TOP In sValue Then
            Result := Result + [wxSTAY_ON_TOP];

        If wxDIALOG_NO_PARENT In sValue Then
            Result := Result + [wxDIALOG_NO_PARENT];

        If wxDIALOG_EX_CONTEXTHELP In sValue Then
            Result := Result + [wxDIALOG_EX_CONTEXTHELP];

        If wxMINIMIZE_BOX In sValue Then
            Result := Result + [wxMINIMIZE_BOX];

        If wxMAXIMIZE_BOX In sValue Then
            Result := Result + [wxMAXIMIZE_BOX];

        If wxCLOSE_BOX In sValue Then
            Result := Result + [wxCLOSE_BOX];

        If wxNO_3D In sValue Then
            Result := Result + [wxNO_3D];

        If wxDEFAULT_DIALOG_STYLE In sValue Then
            Result := Result + [wxDEFAULT_DIALOG_STYLE];

        If wxDEFAULT_FRAME_STYLE In sValue Then
            Result := Result + [wxDEFAULT_FRAME_STYLE];

        If wxMINIMIZE In sValue Then
            Result := Result + [wxMINIMIZE];

        If wxMAXIMIZE In sValue Then
            Result := Result + [wxMAXIMIZE];

        If wxFRAME_TOOL_WINDOW In sValue Then
            Result := Result + [wxFRAME_TOOL_WINDOW];

        If wxFRAME_NO_TASKBAR In sValue Then
            Result := Result + [wxFRAME_NO_TASKBAR];

        If wxFRAME_FLOAT_ON_PARENT In sValue Then
            Result := Result + [wxFRAME_FLOAT_ON_PARENT];

        If wxFRAME_EX_CONTEXTHELP In sValue Then
            Result := Result + [wxFRAME_EX_CONTEXTHELP];

        If wxFRAME_SHAPED In sValue Then
            Result := Result + [wxFRAME_SHAPED];

    Finally
        sValue := [];
    End;

End;

{ Write method for property Wx_DialogStyle }
Procedure TfrmNewForm.SetWx_DialogStyle(Value: TWxDlgStyleSet);
Begin
    FWxFrm_DialogStyle := GetRefinedWxDialogStyleValue(Value);
End;

Function TfrmNewForm.PreserveFormat: Boolean;
Begin
    Result := KeepFormat;
End;

End.
