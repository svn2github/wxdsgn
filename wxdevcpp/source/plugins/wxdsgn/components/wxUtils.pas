{ ****************************************************************** }
{ $Id: wxUtils.pas 936 2007-05-15 03:47:39Z gururamnath $            }
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

{*
  todo:
  1) StaticText needs Style
  2)Scrollbar need to have the vertical and horizontal poperties

*}
Unit WxUtils;

Interface

Uses
    WinTypes, WinProcs, Messages, SysUtils, StrUtils, Classes, Controls,
    Forms, Graphics, StdCtrls, Dialogs, ComCtrls, ExtCtrls, dmListview,
    dmTreeView,
    UPicEdit, UStrings, TypInfo, Menus, UStatusbar, UValidator,
    JvInspector, wxversion, DateUtils, xprocs, ShellAPI, SHFolder;

Const
    IID_IWxComponentInterface: TGUID = '{624949E8-E46C-4EF9-BADA-BC85325165B3}';
    IID_IWxDesignerFormInterface: TGUID =
        '{3e8e18a0-6515-11db-bd13-0800200c9a66}';
    IID_IWxDialogNonInsertableInterface: TGUID =
        '{AED02C7A-E2E5-4BFD-AF42-080D4D07027C}';
    IID_IWxToolBarInsertableInterface: TGUID =
        '{5B1BDAFE-76E9-4C84-A694-0D99C6D17BC4}';
    IID_IWxToolBarNonInsertableInterface: TGUID =
        '{6A81CF27-1269-4BD6-9C5D-16F88293B66B}';
    IID_IWxWindowInterface: TGUID = '{3164E818-E7FA-423B-B342-C89D8AF23617}';
    IID_IWxContainerAndSizerInterface: TGUID =
        '{2C8662AE-7C13-4C96-81F6-32B195ABE1C9}';
    IDD_IWxContainerInterface: TGUID = '{1149F8B7-04D7-466F-96FA-74C7383F2EFD}';
    IID_IWxToolBarInterface: TGUID = '{518BF32C-F961-4148-B506-F60A9D21AD15}';
    IDD_IWxStatusBarInterface: TGUID = '{4E9800A3-D948-4F48-A109-7F81B69ECAD3}';
    IDD_IWxMenuBarInterface: TGUID = '{b74eeaf0-7f08-11db-9fe1-0800200c9a66}';
    IDD_IWxCollectionInterface: TGUID = '{DC147ECD-47A2-4334-A113-CD9B794CBCE1}';
    IID_IWxVariableAssignmentInterface: TGUID =
        '{624949E8-E46C-4EF9-B4DA-BC8532617513}';
    IID_IWxValidatorInterface: TGUID = '{782949E8-47A2-4BA9-E4CA-CA9B832ADCA1}';
    IID_IWxSplitterInterface: TGUID = '{900F32A7-3864-4827-9039-85C053504BDB}';
    IID_IWxControlPanelInterface: TGUID =
        '{077d51a0-6628-11db-bd13-0800200c9a66}';
    IID_IWxThirdPartyComponentInterface: TGUID =
        '{ead81650-6903-11db-bd13-0800200c9a66}';
    IID_IWxImageContainerInterface: TGUID =
        '{10619130-6bd4-11db-bd13-0800200c9a66}';
    IID_IWxAuiManagerInterface: TGUID = '{AD6CF99F-7C74-4C13-BBCA-46A0F6486162}';
    IID_IWxAuiPaneInfoInterface: TGUID =
        '{7D45A54D-4C39-447E-A484-352EEC1956C5}';
    IID_IWxAuiPaneInterface: TGUID = '{885FADF9-3EF9-4B00-BC80-204A1349DC94}';
    IID_IWxAuiToolBarInterface: TGUID = '{313E569A-5F00-423C-A71E-1E3BB3F2FD2A}';
    IID_IWxAuiNonInsertableInterface: TGUID =
        '{D8527AE6-9AC3-401E-B86E-6CE96853E47D}';

Var
    StringFormat: String;
    UseDefaultPos: Boolean;
    UseDefaultSize: Boolean;
    UseIndividEnums: Boolean;

    XRCGEN: Boolean;//NUKLEAR ZELPH

//type

Function ExtractComponentPropertyName(Const S: String): String;
Function ExtractComponentPropertyCaption(Const S: String): String;
Function iswxForm(FileName: String): Boolean;
//function isRCExt(FileName: string): boolean;
Function isXRCExt(FileName: String): Boolean;
Function SaveStringToFile(strContent, strFileName: String): Boolean;

Function CreateGraphicFileName(strFileName: String): String;
Function CreateGraphicFileDir(strFileName: String): String;

Function LocalAppDataPath: String;

Function GetAppVersion: String;

Type
    TWxPoint = Class(TComponent)
    Private
        FX: Integer;
        FY: Integer;
    Published
        Property X: Integer Read FX Write FX Default 0;
        Property Y: Integer Read FY Write FY Default 0;
    End;

// Added by Tony Reina 20 June 2006
// We need a TButton class that will allow for the caption to be aligned
// I found this code at the Delphi Central website: http://www.delphi-central.com/tbut.aspx
Type
    THorizAlign = (halLeft, halRight, halCentre);
    TVerticalAlign = (valTop, valBottom, valCentre);

    TMultiLineBtn = Class(TButton)
    Private
        fMultiLine: Boolean;
        fHorizAlign: THorizAlign;
        fVerticalAlign: TVerticalAlign;
        Procedure SetMultiLine(Value: Boolean);
        Procedure SetHorizAlign(Value: THorizAlign);
        Procedure SetVerticalAlign(Value: TVerticalAlign);
    Protected
        Procedure CreateParams(Var Params: TCreateParams); Override;
    Public
        Constructor Create(AOwner: TComponent); Override;
    Published
        Property HorizAlign: THorizAlign
            Read fHorizAlign Write setHorizAlign Default halCentre;
        Property VerticalAlign: TVerticalAlign Read fVerticalAlign
            Write setVerticalAlign Default valCentre;
        Property MultiLine: Boolean
            Read fMultiLine Write SetMultiLine Default True;
    End;
    // END: TMultiLineBtn

    TWxStdDialogButtons = Set Of
        (wxID_OK, wxID_YES, wxID_SAVE, wxID_NO, wxID_CANCEL,
        wxID_APPLY, wxID_HELP, wxID_CONTEXT_HELP);
    TWxSizerAlignment = (wxALIGN_TOP, wxALIGN_LEFT, wxALIGN_RIGHT,
        wxALIGN_BOTTOM,
        wxALIGN_CENTER, wxALIGN_CENTER_VERTICAL,
        wxALIGN_CENTER_HORIZONTAL, wxEXPAND);
    TWxSizerAlignmentSet = Set Of TWxSizerAlignment;
    TWxBorderAlignment = Set Of (wxTOP, wxLEFT, wxRIGHT, wxBOTTOM, wxALL);
    TWxControlOrientation = (wxControlVertical, wxControlHorizontal,
        wxControlNone);
    TWxGridSelection = (wxGridSelectCells, wxGridSelectColumns,
        wxGridSelectRows);
    TWxDesignerType = (dtWxDialog, dtWxFrame, dtWxWizard);

    IWxComponentInterface = Interface
        ['{624949E8-E46C-4EF9-BADA-BC85325165B3}']
        Function GenerateEnumControlIDs: String;
        Function GenerateControlIDs: String;

        Function GenerateGUIControlCreation: String;
        Function GenerateXRCControlCreation(IndentString: String): TStringList;
        Function GenerateGUIControlDeclaration: String;
        Function GenerateHeaderInclude: String;
        Function GenerateImageInclude: String;
        Function GetPropertyList: TStringList;

        Function GetEventList: TStringList;
        Function GenerateEventTableEntries(CurrClassName: String): String;
        Function GetParameterFromEventName(EventName: String): String;
        Function GetTypeFromEventName(EventName: String): String;

        Function GetIDName: String;
        Procedure SetIDName(IDName: String);
        Function GetIDValue: Integer;
        Procedure SetIDValue(IDValue: Integer);

        Function GetWxClassName: String;
        Procedure SetWxClassName(wxClassName: String);

        Procedure SaveControlOrientation(ControlOrientation:
            TWxControlOrientation);
        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

        Function GetFGColor: String;
        Procedure SetFGColor(strValue: String);
        Function GetBGColor: String;
        Procedure SetBGColor(strValue: String);
        Function GetGenericColor(strVariableName: String): String;
        Procedure SetGenericColor(strVariableName, strValue: String);
    End;

    IWxDesignerFormInterface = Interface
        ['{3e8e18a0-6515-11db-bd13-0800200c9a66}']
        Function GetFormName: String;
        Procedure SetFormName(StrValue: String);
    End;

    IWxDialogNonInsertableInterface = Interface
        ['{AED02C7A-E2E5-4BFD-AF42-080D4D07027C}']
        //procedure DummySizerNonInsertableInterfaceProcedure;
    End;

    IWxToolBarInsertableInterface = Interface
        ['{5B1BDAFE-76E9-4C84-A694-0D99C6D17BC4}']
        //procedure DummyToolBarInsertableInterfaceProcedure;
    End;

    IWxToolBarNonInsertableInterface = Interface
        ['{6A81CF27-1269-4BD6-9C5D-16F88293B66B}']
        //procedure DummyToolBarNonInsertableInterfaceProcedure;
    End;

    IWxWindowInterface = Interface
        ['{3164E818-E7FA-423B-B342-C89D8AF23617}']

    End;

    IWxContainerAndSizerInterface = Interface
        ['{2C8662AE-7C13-4C96-81F6-32B195ABE1C9}']
        Function GenerateLastCreationCode: String;
    End;

    IWxContainerInterface = Interface
        ['{1149F8B7-04D7-466F-96FA-74C7383F2EFD}']
    End;

    IWxToolBarInterface = Interface
        ['{518BF32C-F961-4148-B506-F60A9D21AD15}']
        Function GetRealizeString: String;
    End;

    IWxStatusBarInterface = Interface
        ['{4E9800A3-D948-4F48-A109-7F81B69ECAD3}']
    End;

    IWxMenuBarInterface = Interface
        ['{b74eeaf0-7f08-11db-9fe1-0800200c9a66}']
        Function GenerateXPM(strFileName: String): Boolean;
    End;

    IWxCollectionInterface = Interface
        ['{DC147ECD-47A2-4334-A113-CD9B794CBCE1}']
        Function GetMaxID: Integer;
    End;

    IWxVariableAssignmentInterface = Interface
        ['{624949E8-E46C-4EF9-B4DA-BC8532617513}']
        Function GetLHSVariableAssignment: String;
        Function GetRHSVariableAssignment: String;
    End;

    IWxValidatorInterface = Interface
        ['{782949E8-47A2-4BA9-E4CA-CA9B832ADCA1}']
        Function GetValidator: String;
        Procedure SetValidator(value: String);
    End;

    IWxSplitterInterface = Interface
        ['{900F32A7-3864-4827-9039-85C053504BDB}']
    End;

    IWxControlPanelInterface = Interface
        ['{077d51a0-6628-11db-bd13-0800200c9a66}']
    End;

    IWxThirdPartyComponentInterface = Interface
        ['{ead81650-6903-11db-bd13-0800200c9a66}']
        Function GetHeaderLocation: String;
        Function GetLibName(CompilerTye: Integer): String;
        Function IsLibAddedAtEnd(CompilerTye: Integer): Boolean;
    End;

    IWxImageContainerInterface = Interface
        ['{10619130-6bd4-11db-bd13-0800200c9a66}']
        Function GetBitmapCount: Integer;
        Function GetBitmap(Idx: Integer; Var bmp: TBitmap;
            Var PropertyName: String): Boolean;
        Function GetPropertyName(Idx: Integer): String;
        Function PreserveFormat: Boolean;
        Function GetGraphicFileName: String;
        Function SetGraphicFileName(strFileName: String): Boolean;
    End;

    IWxAuiManagerInterface = Interface
        ['{AD6CF99F-7C74-4C13-BBCA-46A0F6486162}']
    End;

    IWxAuiPaneInfoInterface = Interface
        ['{7D45A54D-4C39-447E-A484-352EEC1956C5}']
    End;


    IWxAuiPaneInterface = Interface
        ['{885FADF9-3EF9-4B00-BC80-204A1349DC94}']
    End;

    IWxAuiToolBarInterface = Interface
        ['{313E569A-5F00-423C-A71E-1E3BB3F2FD2A}']
    End;

    IWxAuiNonInsertableInterface = Interface
        ['{D8527AE6-9AC3-401E-B86E-6CE96853E47D}']
    End;

    TWxStdStyleItem = (wxSIMPLE_BORDER, wxDOUBLE_BORDER, wxSUNKEN_BORDER,
        wxRAISED_BORDER, wxSTATIC_BORDER, wxTRANSPARENT_WINDOW,
        wxTAB_TRAVERSAL, wxWANTS_CHARS,
        wxNO_FULL_REPAINT_ON_RESIZE, wxVSCROLL,
        wxHSCROLL, wxCLIP_CHILDREN, wxNO_BORDER,
        wxALWAYS_SHOW_SB, wxFULL_REPAINT_ON_RESIZE);
    TWxStdStyleSet = Set Of TWxStdStyleItem;

    TWxBtnStyleItem = (wxBU_AUTODRAW, wxBU_LEFT, wxBU_TOP,
        wxBU_RIGHT, wxBU_BOTTOM,
        wxBU_EXACTFIT);
    TWxBtnStyleSet = Set Of TWxBtnStyleItem;

    TWxLbStyleItem = (wxST_ALIGN_LEFT, wxST_ALIGN_RIGHT, wxST_ALIGN_CENTRE,
        wxST_NO_AUTORESIZE);
    TWxLbStyleSet = Set Of TWxLbStyleItem;

    TWxEdtGeneralStyleItem = (wxTE_PROCESS_ENTER, wxTE_PROCESS_TAB,
        wxTE_PASSWORD,
        wxTE_READONLY, wxTE_RICH, wxTE_RICH2, wxTE_AUTO_URL, wxTE_NO_VSCROLL,
        wxTE_NOHIDESEL, wxTE_DONTWRAP, wxTE_LINEWRAP,
        wxTE_WORDWRAP, wxTE_CHARWRAP, wxTE_BESTWRAP,
        wxTE_CAPITALIZE, wxTE_MULTILINE, wxTE_LEFT,
        wxTE_CENTRE, wxTE_RIGHT);
    TWxEdtGeneralStyleSet = Set Of TWxEdtGeneralStyleItem;

    TWxRichTextStyleItem = (wxRE_READONLY, wxRE_MULTILINE);
    TWxRichTextStyleSet = Set Of TWxRichTextStyleItem;

    TwxRichTextSLCStyleItem = (wxRICHTEXTSTYLELIST_HIDE_TYPE_SELECTOR);
    TwxRichTextSLCStyleSet = Set Of TwxRichTextSLCStyleItem;


    //  TWxEdtAlignmentStyleItem = (wxTE_LEFT, wxTE_CENTRE, wxTE_RIGHT);
    // TWxEdtAlignmentStyleSet = set of TWxEdtAlignmentStyleItem;

    TWxDlgStyleItem = (wxCAPTION, wxRESIZE_BORDER, wxSYSTEM_MENU, wxTHICK_FRAME,
        wxSTAY_ON_TOP, wxDIALOG_NO_PARENT, wxDIALOG_EX_CONTEXTHELP,
        wxMINIMIZE_BOX,
        wxMAXIMIZE_BOX, wxCLOSE_BOX, wxNO_3D,
        wxDEFAULT_DIALOG_STYLE, wxDEFAULT_FRAME_STYLE,
        wxMINIMIZE, wxMAXIMIZE, wxFRAME_TOOL_WINDOW,
        wxFRAME_NO_TASKBAR, wxFRAME_FLOAT_ON_PARENT,
        wxFRAME_EX_CONTEXTHELP, wxFRAME_SHAPED);
    TWxDlgStyleSet = Set Of TWxDlgStyleItem;

    //class  	wxAnimationCtrl
    TWxAnimationCtrlStyleItem = (wxAC_DEFAULT_STYLE, wxAC_NO_AUTORESIZE);
    TWxAnimationCtrlStyleSet = Set Of TWxAnimationCtrlStyleItem;

    //class  	wxCustomButton
    TWxCBtnPosStyleSubItem = (wxCUSTBUT_LEFT, wxCUSTBUT_RIGHT,
        wxCUSTBUT_TOP, wxCUSTBUT_BOTTOM);
    TWxCBtnPosStyleSubSet = Set Of TWxCBtnPosStyleSubItem;

    TWxCBtnStyleSubItem = (wxCUSTBUT_NOTOGGLE, wxCUSTBUT_BUTTON,
        wxCUSTBUT_TOGGLE, wxCUSTBUT_BUT_DCLICK_TOG, wxCUSTBUT_TOG_DCLICK_BUT);
    TWxCBtnStyleSubSet = Set Of TWxCBtnStyleSubItem;

    TWxCBtnDwgStyleSubItem = (wxCUSTBUT_FLAT);
    TWxCBtnDwgStyleSubSet = Set Of TWxCBtnDwgStyleSubItem;

    //class  	wxColourPickerCtrl
    TWxClrPickCtrlStyleItem = (wxCLRP_DEFAULT_STYLE, wxCLRP_USE_TEXTCTRL,
        wxCLRP_SHOW_LABEL);
    TWxClrPickCtrlStyleSet = Set Of TWxClrPickCtrlStyleItem;

    //class  	wxDirPickerCtrl
    TWxDirPickCtrlStyleItem = (wxDIRP_DEFAULT_STYLE, wxDIRP_USE_TEXTCTRL,
        wxDIRP_DIR_MUST_EXIST, wxDIRP_CHANGE_DIR);
    TWxDirPickCtrlStyleSet = Set Of TWxDirPickCtrlStyleItem;

    //class  	wxFilePickerCtrl
    TWxFilePickCtrlStyleItem = (wxFLP_DEFAULT_STYLE, wxFLP_USE_TEXTCTRL,
        wxFLP_OPEN, wxFLP_SAVE, wxFLP_OVERWRITE_PROMPT, wxFLP_FILE_MUST_EXIST,
        wxFLP_CHANGE_DIR);
    TWxFilePickCtrlStyleSet = Set Of TWxFilePickCtrlStyleItem;

    //class  	wxFontPickerCtrl
    TWxFontPickCtrlStyleItem = (wxFNTP_DEFAULT_STYLE, wxFNTP_USE_TEXTCTRL,
        wxFNTP_FONTDESC_AS_LABEL, wxFNTP_USEFONT_FOR_LABEL);
    TWxFontPickCtrlStyleSet = Set Of TWxFontPickCtrlStyleItem;

    //newly Added
    TWxCmbStyleItem = (wxCB_SIMPLE, wxCB_DROPDOWN, wxCB_READONLY, wxCB_SORT);
    TWxCmbStyleSet = Set Of TWxCmbStyleItem;

    TWxOwnCmbStyleItem = (wxODCB_DCLICK_CYCLES, wxODCB_STD_CONTROL_PAINT);
    TWxOwnCmbStyleSet = Set Of TWxOwnCmbStyleItem;

    TWxPickCalStyleItem = (wxDP_SPIN, wxDP_DROPDOWN, wxDP_DEFAULT,
        wxDP_ALLOWNONE, wxDP_SHOWCENTURY);
    TWxPickCalStyleSet = Set Of TWxPickCalStyleItem;

    TWxLBxStyleSubItem = (wxLB_SINGLE, wxLB_MULTIPLE, wxLB_EXTENDED);
    TWxLBxStyleSubSet = Set Of TWxLBxStyleSubItem;

    TWxLBxStyleItem = (wxLB_HSCROLL, wxLB_ALWAYS_SB, wxLB_NEEDED_SB, wxLB_SORT);
    TWxLBxStyleSet = Set Of TWxLBxStyleItem;

    TWxCBxStyleItem = (wxCHK_2STATE, wxCHK_3STATE,
        wxCHK_ALLOW_3RD_STATE_FOR_USER,
        wxALIGN_RIGHT_CB);
    TWxCBxStyleSet = Set Of TWxCBxStyleItem;

    TWxRBStyleItem = (wxRB_GROUP, wxRB_SINGLE);
    TWxRBStyleSet = Set Of TWxRBStyleItem;

    TWxGagOrientation = (wxGA_HORIZONTAL, wxGA_VERTICAL);

    TWxgagStyleItem = (wxGA_SMOOTH, wxGA_MARQUEE);
    TWxgagStyleSet = Set Of TWxgagStyleItem;

    TWxsbtnOrientation = (wxSP_HORIZONTAL, wxSP_VERTICAL);

    TWxsbtnStyleItem = (wxSP_ARROW_KEYS, wxSP_WRAP);
    TWxsbtnStyleSet = Set Of TWxsbtnStyleItem;

    TWx_SBOrientation = (wxSB_HORIZONTAL, wxSB_VERTICAL);

    TWx_SliderOrientation = (wxSL_HORIZONTAL, wxSL_VERTICAL);
    TWx_SliderRange = (wxSL_SELRANGE, wxSL_INVERSE);

    TWxsldrStyleItem = (wxSL_AUTOTICKS, wxSL_LABELS, wxSL_LEFT,
        wxSL_RIGHT, wxSL_TOP, wxSL_BOTTOM, wxSL_BOTH);
    TWxsldrStyleSet = Set Of TWxsldrStyleItem;

    TWxHyperLnkStyleItem = (wxHL_ALIGN_LEFT, wxHL_ALIGN_RIGHT,
        wxHL_ALIGN_CENTRE, wxHL_CONTEXTMENU, wxHL_DEFAULT_STYLE);
    TWxHyperLnkStyleSet = Set Of TWxHyperLnkStyleItem;

    TWxcalctrlStyleItem = (wxCAL_SUNDAY_FIRST, wxCAL_MONDAY_FIRST,
        wxCAL_SHOW_HOLIDAYS,
        wxCAL_NO_YEAR_CHANGE, wxCAL_NO_MONTH_CHANGE,
        wxCAL_SHOW_SURROUNDING_WEEKS,
        wxCAL_SEQUENTIAL_MONTH_SELECTION);
    TWxcalctrlStyleSet = Set Of TWxcalctrlStyleItem;

    //Book controls
    //Notebook
    TWxnbxAlignStyleItem = (wxNB_DEFAULT, wxNB_TOP, wxNB_LEFT,
        wxNB_RIGHT, wxNB_BOTTOM);
    TWxnbxStyleItem = (wxNB_FIXEDWIDTH, wxNB_MULTILINE,
        wxNB_NOPAGETHEME, wxNB_FLAT);
    TWxnbxStyleSet = Set Of TWxnbxStyleItem;

    //Choicebook
    TWxchbxAlignStyleItem = (wxCHB_DEFAULT, wxCHB_TOP, wxCHB_LEFT,
        wxCHB_RIGHT, wxCHB_BOTTOM);
    { prepare for future styles }
    {    TWxchbxStyleItem = ();
    TWxchbxStyleSet  = set of TWxchbxStyleItem;
}
    //ListBook
    TWxlbbxAlignStyleItem = (wxLB_DEFAULT, wxLB_TOP, wxLB_LEFT,
        wxLB_RIGHT, wxLB_BOTTOM);
    { prepare for future styles   }
    {    TWxlbbxStyleItem = ();
    TWxlbbxStyleSet  = set of TWxlbbxStyleItem;
}
    //treebook
    TWxtrbxAlignStyleItem = (wxBK_DEFAULT, wxBK_TOP, wxBK_LEFT,
        wxBK_RIGHT, wxBK_BOTTOM);
    { prepare for future styles  }
    {   TWxtrbxStyleItem = ();
    TWxtrbxStyleSet  = set of TWxtrbxStyleItem;
}
    //Toolbook
    TWxtlbxAlignStyleItem = (wxTLB_DEFAULT);
    { prepare for future styles  }
    {  TWxtlbxAlignStyleItem = ();
  TWxtlbxStyleSet = set of TWxtlbxStyleItem;
}
    TWxrbxStyleItem = (wxRA_SPECIFY_ROWS, wxRA_SPECIFY_COLS);
    TWxrbxStyleSet = Set Of TWxrbxStyleItem;

    TWxsbrStyleItem = (wxST_SIZEGRIP);
    TWxsbrStyleSet = Set Of TWxsbrStyleItem;

    TWxtbrStyleItem = (wxTB_FLAT, wxTB_DOCKABLE, wxTB_HORIZONTAL,
        wxTB_VERTICAL, wxTB_TEXT,
        wxTB_NOICONS, wxTB_NODIVIDER, wxTB_NOALIGN, wxTB_HORZ_LAYOUT,
        wxTB_HORZ_TEXT);
    TWxtbrStyleSet = Set Of TWxtbrStyleItem;

    TWxLvView = (wxLC_ICON, wxLC_SMALL_ICON, wxLC_LIST, wxLC_REPORT,
        wxLC_VIRTUAL{$IFDEF PRIVATE_BUILD}, wxLC_TILE{$ENDIF});
    TWxLVStyleItem = (wxLC_ALIGN_TOP, wxLC_ALIGN_LEFT, wxLC_AUTOARRANGE,
        wxLC_EDIT_LABELS, wxLC_GROUPS, wxLC_NO_HEADER, wxLC_NO_SORT_HEADER,
        wxLC_SINGLE_SEL, wxLC_SORT_ASCENDING, wxLC_SORT_DESCENDING,
        wxLC_HRULES, wxLC_VRULES);
    TWxLVStyleSet = Set Of TWxLVStyleItem;

    TWxTVStyleItem = (wxTR_EDIT_LABELS, wxTR_NO_BUTTONS, wxTR_HAS_BUTTONS,
        wxTR_TWIST_BUTTONS, wxTR_NO_LINES, wxTR_FULL_ROW_HIGHLIGHT,
        wxTR_LINES_AT_ROOT, wxTR_HIDE_ROOT, wxTR_ROW_LINES, wxTR_COLUMN_LINES,
        wxTR_HAS_VARIABLE_ROW_HEIGHT, wxTR_SINGLE, wxTR_SHOW_ROOT_LABEL_ONLY,
        wxTR_MULTIPLE, wxTR_EXTENDED,
        wxTR_DEFAULT_STYLE);
    TWxTVStyleSet = Set Of TWxTVStyleItem;

    TWxScrWinStyleItem = (wxRETAINED);
    TWxScrWinStyleSet = Set Of TWxScrWinStyleItem;

    TWxHtmlWinStyleItem = (wxHW_SCROLLBAR_NEVER, wxHW_SCROLLBAR_AUTO,
        wxHW_NO_SELECTION);
    TWxHtmlWinStyleSet = Set Of TWxHtmlWinStyleItem;

    TWxSplitterWinStyleItem = (wxSP_3D, wxSP_3DSASH, wxSP_3DBORDER,
        wxSP_BORDER, wxSP_NOBORDER, wxSP_NO_XP_THEME, wxSP_PERMIT_UNSPLIT,
        wxSP_LIVE_UPDATE);
    TWxSplitterWinStyleSet = Set Of TWxSplitterWinStyleItem;

    TWxMenuItemStyleItem = (wxMnuItm_Normal, wxMnuItm_Separator,
        wxMnuItm_Radio, wxMnuItm_Check, wxMnuItm_History);

    TWxToolbottonItemStyleItem = (wxITEM_NORMAL, wxITEM_RADIO, wxITEM_CHECK);

    TWxFindReplaceFlagItem = (wxFR_DOWN, wxFR_WHOLEWORD, wxFR_MATCHCASE);
    TWxFindReplaceFlagSet = Set Of TWxFindReplaceFlagItem;

    TwxFindReplaceDialogStyleItem = (wxFR_REPLACEDIALOG, wxFR_NOUPDOWN,
        wxFR_NOMATCHCASE, wxFR_NOWHOLEWORD);
    TwxFindReplaceDialogStyleSet = Set Of TwxFindReplaceDialogStyleItem;

    TWx_LIOrientation = (wxLI_HORIZONTAL, wxLI_VERTICAL);

    //End of Control Styles

    TWxFileDialogType = (wxOPEN, wxSAVE);

    TWxFileDialogStyleItem = (wxHIDE_READONLY, wxOVERWRITE_PROMPT, wxMULTIPLE,
        wxCHANGE_DIR, wxFILE_MUST_EXIST);
    TWxFileDialogStyleSet = Set Of TWxFileDialogStyleItem;

    TWxDirDialogStyleItem = (wxDD_NEW_DIR_BUTTON);
    TWxDirDialogStyleSet = Set Of TWxDirDialogStyleItem;

    TWxProgressDialogStyleItem =
        (wxPD_APP_MODAL, wxPD_AUTO_HIDE, wxPD_CAN_ABORT, wxPD_ELAPSED_TIME,
        wxPD_ESTIMATED_TIME, wxPD_REMAINING_TIME, wxPD_SMOOTH, wxPD_CAN_SKIP);
    TWxProgressDialogStyleSet = Set Of TWxProgressDialogStyleItem;

    TWxMessageDialogStyleItem = (wxOK, wxCANCEL, wxYES_NO, wxYES_DEFAULT,
        wxNO_DEFAULT, wxICON_EXCLAMATION, wxICON_HAND, wxICON_ERROR,
        wxICON_QUESTION,
        wxICON_INFORMATION, wxCENTRE);
    TWxMessageDialogStyleSet = Set Of TWxMessageDialogStyleItem;

    TWxPaperSizeItem = (wxPAPER_NONE, wxPAPER_LETTER, wxPAPER_LEGAL,
        wxPAPER_A4, wxPAPER_CSHEET, wxPAPER_DSHEET, wxPAPER_ESHEET,
        wxPAPER_LETTERSMALL, wxPAPER_TABLOID, wxPAPER_LEDGER,
        wxPAPER_STATEMENT, wxPAPER_EXECUTIVE, wxPAPER_A3,
        wxPAPER_A4SMALL, wxPAPER_A5, wxPAPER_B4, wxPAPER_B5,
        wxPAPER_FOLIO, wxPAPER_QUARTO, wxPAPER_10X14, wxPAPER_11X17,
        wxPAPER_NOTE, wxPAPER_ENV_9, wxPAPER_ENV_10,
        wxPAPER_ENV_11, wxPAPER_ENV_12, wxPAPER_ENV_14, wxPAPER_ENV_DL,
        wxPAPER_ENV_C5,
        wxPAPER_ENV_C3, wxPAPER_ENV_C4, wxPAPER_ENV_C6,
        wxPAPER_ENV_C65, wxPAPER_ENV_B4, wxPAPER_ENV_B5, wxPAPER_ENV_B6,
        wxPAPER_ENV_ITALY,
        wxPAPER_ENV_MONARCH, wxPAPER_ENV_PERSONAL,
        wxPAPER_FANFOLD_US, wxPAPER_FANFOLD_STD_GERMAN,
        wxPAPER_FANFOLD_LGL_GERMAN);

    //Sizer orientation
    TWxSizerOrientation = (wxVertical, wxHorizontal);

    TWxMediaCtrlControl = (wxMEDIACTRLPLAYERCONTROLS_NONE,
        wxMEDIACTRLPLAYERCONTROLS_STEP, wxMEDIACTRLPLAYERCONTROLS_VOLUME);
    TWxMediaCtrlControls = Set Of TWxMediaCtrlControl;

    //wxAUI styles etc.
    TwxAuiManagerFlag = (wxAUI_MGR_ALLOW_FLOATING, wxAUI_MGR_ALLOW_ACTIVE_PANE,
        wxAUI_MGR_TRANSPARENT_DRAG,
        wxAUI_MGR_TRANSPARENT_HINT,
        wxAUI_MGR_VENETIAN_BLINDS_HINT, wxAUI_MGR_RECTANGLE_HINT,
        wxAUI_MGR_HINT_FADE,
        wxAUI_MGR_NO_VENETIAN_BLINDS_FADE);
    TwxAuiManagerFlagSet = Set Of TwxAuiManagerFlag;

    TwxAuiPaneDockDirectionItem = (wxAUI_DOCK_NONE, wxAUI_DOCK_TOP,
        wxAUI_DOCK_RIGHT, wxAUI_DOCK_BOTTOM, wxAUI_DOCK_LEFT, wxAUI_DOCK_CENTER);
    //mn later perhaps  TwxAuiPaneDockDirectionSet = set of TwxAuiPaneDockDirectionItem;

    TwxAuiPaneDockableDirectionItem = (TopDockable, RightDockable,
        BottomDockable, LeftDockable);
    TwxAuiPaneDockableDirectionSet = Set Of TwxAuiPaneDockableDirectionItem;

    TwxAuiPaneStyleItem = (CaptionVisible, DestroyOnClose, DockFixed,
        Floatable, Gripper, GripperTop, Movable, PaneBorder, Resizable,
        ToolbarPane, CenterPane);
    TwxAuiPaneStyleSet = Set Of TwxAuiPaneStyleItem;

    TwxAuiPaneButtonItem = (CloseButton, MaximizeButton,
        MinimizeButton, PinButton);
    TwxAuiPaneButtonSet = Set Of TwxAuiPaneButtonItem;

    TWxAuiTbrStyleItem = (wxAUI_TB_TEXT, wxAUI_TB_NO_TOOLTIPS,
        wxAUI_TB_NO_AUTORESIZE, wxAUI_TB_GRIPPER,
        wxAUI_TB_OVERFLOW, wxAUI_TB_VERTICAL, wxAUI_TB_HORZ_TEXT,
        wxAUI_TB_DEFAULT_STYLE);
    TWxAuiTbrStyleSet = Set Of TWxAuiTbrStyleItem;

    //Notebook
    TWxAuinbxAlignStyleItem =
        (wxAUI_NB_TOP, {wxAUI_NB_LEFT, wxAUI_NB_RIGHT, } wxAUI_NB_BOTTOM);
    TWxAuinbxStyleItem = (wxAUI_NB_TAB_SPLIT, wxAUI_NB_TAB_MOVE,
        wxAUI_NB_TAB_EXTERNAL_MOVE, wxAUI_NB_TAB_FIXED_WIDTH,
        wxAUI_NB_SCROLL_BUTTONS, wxAUI_NB_WINDOWLIST_BUTTON, wxAUI_NB_CLOSE_BUTTON,
        wxAUI_NB_CLOSE_ON_ACTIVE_TAB, wxAUI_NB_CLOSE_ON_ALL_TABS);
    TWxAuinbxStyleSet = Set Of TWxAuinbxStyleItem;

    TWxColorString = Class
    Public
        FstrColorValue: String;
    Published
        Property strColorValue: String Read FstrColorValue Write FstrColorValue;
    End;

    TWxValidatorString = Class(TComponent)
    Public
        FstrValidatorValue: String;
        FValidatorType: Integer;
        FFilterType: Integer;
        FValidatorVarName: String;
        Constructor Create(Owner: TComponent); Override;

    Published
        Property strValidatorValue: String
            Read FstrValidatorValue Write FstrValidatorValue;
    End;

    // Added 11 May 2005 - Tony
    TWxFileNameString = Class
    Public
        FstrFileNameValue: String;
    Published
        Property strFileNameValue: String Read FstrFileNameValue
            Write FstrFileNameValue;
    End;

    // Added 1 May 2008 - Mal
    TWxAnimationFileNameString = Class
    Public
        FstrFileNameValue: String;
    Published
        Property strFileNameValue: String Read FstrFileNameValue
            Write FstrFileNameValue;
    End;

    TWxJvInspectorTStringsItem = Class(TJvCustomInspectorItem)
    Protected
        Procedure ContentsChanged(Sender: TObject);
        Function GetDisplayValue: String; Override;
        Procedure Edit; Override;
        Procedure SetDisplayValue(Const Value: String); Override;
        Procedure SetFlags(Const Value: TInspectorItemFlags); Override;
    Public
        Constructor Create(Const AParent: TJvCustomInspectorItem;
            Const AData: TJvCustomInspectorData); Override;
    Public
        Class Procedure RegisterAsDefaultItem;
    End;

    TJvInspectorColorEditItem = Class(TJvCustomInspectorItem)
    Protected
        Procedure Edit; Override;

        Function GetDisplayValue: String; Override;
        Procedure SetDisplayValue(Const Value: String); Override;
        Procedure SetFlags(Const Value: TInspectorItemFlags); Override;
    Public
        Class Procedure RegisterAsDefaultItem;
    End;

    // Added 11 May 2005 by Tony
    TJvInspectorFileNameEditItem = Class(TJvCustomInspectorItem)
    Protected
        Procedure Edit; Override;
        Function GetDisplayValue: String; Override;
        Procedure SetFlags(Const Value: TInspectorItemFlags); Override;
    Public
        Class Procedure RegisterAsDefaultItem;
    End;

    // Added 1 May 2008 by Mal needed for Animation Control
    TJvInspectorAnimationFileNameEditItem = Class(TJvCustomInspectorItem)
    Protected
        Procedure Edit; Override;
        Function GetDisplayValue: String; Override;
        Procedure SetFlags(Const Value: TInspectorItemFlags); Override;
    Public
        Class Procedure RegisterAsDefaultItem;
    End;

    TJvInspectorListItemsItem = Class(TJvCustomInspectorItem)
    Protected
        Procedure Edit; Override;

        Function GetDisplayValue: String; Override;
        Procedure SetDisplayValue(Const Value: String); Override;
        Procedure SetFlags(Const Value: TInspectorItemFlags); Override;
    Public
        Class Procedure RegisterAsDefaultItem;
    End;

    TJvInspectorListColumnsItem = Class(TJvCustomInspectorItem)
    Protected
        Procedure Edit; Override;

        Function GetDisplayValue: String; Override;
        Procedure SetDisplayValue(Const Value: String); Override;
        Procedure SetFlags(Const Value: TInspectorItemFlags); Override;
    Public
        Class Procedure RegisterAsDefaultItem;
    End;

    TJvInspectorStatusBarItem = Class(TJvCustomInspectorItem)
    Protected
        Procedure Edit; Override;

        Function GetDisplayValue: String; Override;
        Procedure SetDisplayValue(Const Value: String); Override;
        Procedure SetFlags(Const Value: TInspectorItemFlags); Override;
    Public
        Class Procedure RegisterAsDefaultItem;
    End;

    TJvInspectorTreeNodesItem = Class(TJvCustomInspectorItem)
    Protected
        Procedure Edit; Override;

        Function GetDisplayValue: String; Override;
        Procedure SetDisplayValue(Const Value: String); Override;
        Procedure SetFlags(Const Value: TInspectorItemFlags); Override;
    Public
        Class Procedure RegisterAsDefaultItem;
    End;

    TJvInspectorBitmapItem = Class(TJvCustomInspectorItem)
    Protected
        Procedure Edit; Override;

        Function GetDisplayValue: String; Override;
        Procedure SetDisplayValue(Const Value: String); Override;
        Procedure SetFlags(Const Value: TInspectorItemFlags); Override;
    Public
        Class Procedure RegisterAsDefaultItem;
    End;

    TJvInspectorMyFontItem = Class(TJvCustomInspectorItem)
    Protected
        Procedure Edit; Override;

        Function GetDisplayValue: String; Override;
        Procedure SetDisplayValue(Const Value: String); Override;
        Procedure SetFlags(Const Value: TInspectorItemFlags); Override;
    Public
        Class Procedure RegisterAsDefaultItem;
    End;

    TJvInspectorMenuItem = Class(TJvCustomInspectorItem)
    Protected
        Procedure Edit; Override;

        Function GetDisplayValue: String; Override;
        Procedure SetDisplayValue(Const Value: String); Override;
        Procedure SetFlags(Const Value: TInspectorItemFlags); Override;
    Public
        Class Procedure RegisterAsDefaultItem;
    End;

    TJvInspectorValidatorItem = Class(TJvCustomInspectorItem)
    Protected
        Procedure ContentsChanged(Sender: TObject);
        Function GetDisplayValue: String; Override;
        Procedure Edit; Override;
        Procedure SetFlags(Const Value: TInspectorItemFlags); Override;
        Procedure SetDisplayValue(Const Value: String); Override;

    Public
        Constructor Create(Const AParent: TJvCustomInspectorItem;
            Const AData: TJvCustomInspectorData); Override;
        Class Procedure RegisterAsDefaultItem;
    End;

Function UnixPathToDosPath(Const Path: String): String;
Function LocalConvertLibsToCurrentVersion(strValue: String): String;
Function Convert25LibsToCurrentVersion(strValue: String): String;
Function Convert26LibsToCurrentVersion(strValue: String): String;

Function GetExtension(FileName: String): String;

Function GetGridSelectionToString(grdsel: TWxGridSelection): String;
Function GetStdStyleString(stdStyle: TWxStdStyleSet): String;
Function GetComboxBoxStyleString(stdStyle: TWxCmbStyleSet): String;
Function GetOwnComboxBoxStyleString(stdStyle: TWxOwnCmbStyleSet): String;
Function GetCheckboxStyleString(stdStyle: TWxcbxStyleSet): String;
Function GetTreeviewStyleString(stdStyle: TWxTVStyleSet): String;
Function GetRadiobuttonStyleString(stdStyle: TWxrbStyleSet): String;
Function GetListboxStyleString(stdStyle: TWxlbxStyleSet): String;
Function GetGaugeStyleString(stdStyle: TWxgagStyleSet): String;
Function GetScrollbarStyleString(stdStyle: TWxsbrStyleSet): String;
Function GetSpinButtonStyleString(stdStyle: TWxsbtnStyleSet): String;
Function GetSliderStyleString(stdStyle: TWxsldrStyleSet): String;
Function GetHyperLnkStyleString(stdStyle: TWxHyperLnkStyleSet): String;
Function GetPickCalStyleString(stdStyle: TWxPickCalStyleSet): String;
Function GetCalendarCtrlStyleString(stdStyle: TWxcalctrlStyleSet): String;
//function GetChoicebookStyleString(stdStyle: TWxchbxStyleSet): string;
//function GetListbookStyleString(stdStyle: TWxlbbxStyleSet): string;
Function GetNotebookStyleString(stdStyle: TWxnbxStyleSet): String;
Function GetAuiNotebookStyleString(stdStyle: TWxAuinbxStyleSet): String;
//function GetToolbookStyleString(stdStyle: TWxtlbxStyleSet): string;
//function GetTreebookStyleString(stdStyle: TWxtrbxStyleSet): string;
Function GetRadioBoxStyleString(stdStyle: TWxrbxStyleSet): String;
Function GetStatusBarStyleString(stdStyle: TWxsbrStyleSet): String;
Function GetToolBarStyleString(stdStyle: TWxtbrStyleSet): String;
Function GetScrolledWindowStyleString(stdStyle: TWxScrWinStyleSet): String;
Function GetHtmlWindowStyleString(stdStyle: TWxHtmlWinStyleSet): String;
Function GetSplitterWindowStyleString(stdStyle:
    TWxSplitterWinStyleSet): String;
Function GetFileDialogStyleString(stdStyle: TWxFileDialogStyleSet): String;
Function GetDirDialogStyleString(stdStyle: TWxDirDialogStyleSet): String;
Function GetProgressDialogStyleString(stdStyle:
    TWxProgressDialogStyleSet): String;
Function GetTextEntryDialogStyleString(stdStyle: TWxMessageDialogStyleSet;
    edtStyle: TWxEdtGeneralStyleSet): String;
Function GetMediaCtrlStyle(mediaStyle: TWxMediaCtrlControl): String;
Function GetMediaCtrlStyleString(mediaStyle: TWxMediaCtrlControls): String;
Function GetMessageDialogStyleString(stdStyle: TWxMessageDialogStyleSet;
    NoEndComma: Boolean): String;
Function GetFindReplaceFlagString(stdstyle: TWxFindReplaceFlagSet): String;
Function GetFindReplaceDialogStyleString(stdstyle:
    TWxFindReplaceDialogStyleSet): String;

Function GetCheckboxSpecificStyle(stdstyle: TWxStdStyleSet;
    cbxstyle: TWxcbxStyleSet): String;
Function GetTreeviewSpecificStyle(stdstyle: TWxStdStyleSet;
    tvstyle: TWxTvStyleSet): String;
Function GetRadiobuttonSpecificStyle(stdstyle: TWxStdStyleSet;
    rbstyle: TWxrbStyleSet): String;
Function GetListboxSpecificStyle(stdstyle: TWxStdStyleSet;
    lbxstyle: TWxlbxStyleSet): String;
Function GetGaugeSpecificStyle(stdstyle: TWxStdStyleSet;
    gagstyle: TWxgagStyleSet): String;
Function GetScrollbarSpecificStyle(stdstyle: TWxStdStyleSet;
    scbrstyle: TWxsbrStyleSet): String;
Function GetHyperLnkSpecificStyle(stdstyle: TWxStdStyleSet;
    edtstyle: TWxHyperLnkStyleSet): String;
Function GetSpinButtonSpecificStyle(stdstyle: TWxStdStyleSet;
    sbtnstyle: TWxsbtnStyleSet;
    edtstyle: TWxEdtGeneralStyleSet): String;
Function GetSliderSpecificStyle(stdstyle: TWxStdStyleSet;
    sldrstyle: TWxsldrStyleSet): String;
Function GetDateVariableExpansion(value: TDateTime): String;
Function GetCalendarCtrlSpecificStyle(stdstyle: TWxStdStyleSet;
    calctrlstyle: TWxcalctrlStyleSet): String;
Function GetPickCalSpecificStyle(stdstyle: TWxStdStyleSet;
    calctrlstyle: TWxPickCalStyleSet): String;

Function GetRTSListCtrlStyleString(stdStyle: TwxRichTextSLCStyleSet): String;
Function GetRTSListCtrlSpecificStyle(stdstyle: TWxStdStyleSet;
    lbxstyle: TwxRichTextSLCStyleSet): String;

Function GetChoicebookSpecificStyle(stdstyle:
    TWxStdStyleSet{; bookalign: TWxchbxAlignStyleItem; cbbxstyle: TWxchbxStyleSet}): String;
Function GetChoiceAlignmentString(Value: TWxchbxAlignStyleItem): String;

{function GetListbookSpecificStyle(stdstyle: TWxStdStyleSet; lbbxstyle: TWxlbbxStyleSet): string; }
Function GetListbookSpecificStyle(stdstyle:
    TWxStdStyleSet{; bookalign: TWxlbbxAlignStyleItem}): String;
Function GetListAlignment(Value: TWxlbbxAlignStyleItem): String;

Function GetNotebookSpecificStyle(stdstyle: TWxStdStyleSet;
    {bookalign: TWxnbxAlignStyleItem;} nbxstyle: TWxnbxStyleSet): String;
Function GetAuiNotebookSpecificStyle(stdstyle: TWxStdStyleSet;
    {bookalign: TWxnbxAlignStyleItem;} nbxstyle: TWxAuinbxStyleSet): String;
Function GetTabAlignmentString(Value: TWxnbxAlignStyleItem): String;

Function GetToolbookSpecificStyle(stdstyle:
    TWxStdStyleSet{; tlbxstyle: TWxtlbxStyleSet}): String;

{function GetTreebookSpecificStyle(stdstyle: TWxStdStyleSet;
  trbxstyle: TWxtrbxStyleSet): string;    }
Function GetTreebookSpecificStyle(stdstyle:
    TWxStdStyleSet{; bookalign: TWxtrbxAlignStyleItem}): String;
Function GetTreeAlignment(Value: TWxtrbxAlignStyleItem): String;

Function GetRadioBoxSpecificStyle(stdstyle: TWxStdStyleSet;
    rbxstyle: TWxrbxStyleSet): String;
Function GetStatusBarSpecificStyle(stdstyle: TWxStdStyleSet;
    sbrstyle: TWxsbrStyleSet): String;
Function GetToolBarSpecificStyle(stdstyle: TWxStdStyleSet;
    tbrstyle: TWxtbrStyleSet): String;
Function GetAuiToolBarSpecificStyle(stdstyle: TWxStdStyleSet;
    tbrstyle: TWxAuiTbrStyleSet): String;
Function GetScrolledWindowSpecificStyle(stdstyle: TWxStdStyleSet;
    scrWinStyle: TWxScrWinStyleSet): String;
Function GetHtmlWindowSpecificStyle(stdstyle: TWxStdStyleSet;
    htmlWinStyle: TWxHtmlWinStyleSet): String;
Function GetSplitterWindowSpecificStyle(stdstyle: TWxStdStyleSet;
    splitterWinStyle: TWxSplitterWinStyleSet): String;
Function GetRichTextSpecificStyle(stdstyle: TWxStdStyleSet;
    dlgstyle: TWxRichTextStyleSet): String;
Function GetListViewSpecificStyle(stdstyle: TWxStdStyleSet;
    lstvwstyle: TWxLVStyleSet; view: TWxLvView): String;
Function GetEditSpecificStyle(stdstyle: TWxStdStyleSet;
    dlgstyle: TWxEdtGeneralStyleSet): String;
Function GetAnimationCtrlSpecificStyle(stdstyle:
    TWxStdStyleSet{;
  dlgstyle: TWxAnimationCtrlStyleSet}): String;
Function GetButtonSpecificStyle(stdstyle: TWxStdStyleSet;
    dlgstyle: TWxBtnStyleSet): String;
Function GetLabelSpecificStyle(stdstyle: TWxStdStyleSet;
    dlgstyle: TWxLbStyleSet): String;
Function GetcomboBoxSpecificStyle(stdstyle: TWxStdStyleSet;
    cmbstyle: TWxCmbStyleSet; edtstyle: TWxEdtGeneralStyleSet): String;
Function GetOwncomboBoxSpecificStyle(stdstyle: TWxStdStyleSet;
    cmbstyle: TWxCmbStyleSet; edtstyle: TWxEdtGeneralStyleSet;
    owncmbstyle: TWxOwnCmbStyleSet): String;
Function GetStdDialogButtonsSpecificStyle(btnstyle:
    TWxStdDialogButtons): String;
Function GetDialogSpecificStyle(stdstyle: TWxStdStyleSet;
    dlgstyle: TWxDlgStyleSet; wxclassname: String): String;

Procedure PopulateGenericProperties(Var PropertyList: TStringList);
Procedure PopulateAuiGenericProperties(Var PropertyList: TStringList);
Function SizerAlignmentToStr(SizerAlignment: TWxSizerAlignmentSet): String;
    Overload;
Function BorderAlignmentToStr(BorderAlignment: TWxBorderAlignment): String;
Function RGBFormatStrToColor(strColorValue: String): TColor;
Function GetColorFromString(strColorValue: String): TColor;
Function GetGeneralColorFromString(strColorValue: String): TColor;
Function IsDefaultColorStr(strvalue: String): Boolean;
Function GetwxColorFromString(strValue: String): String;
Function PaperIDToString(sizeitem: TWxPaperSizeItem): String;

Function IsControlWxSizer(ctrl: TControl): Boolean;
Function IsControlWxContainer(ctrl: TControl): Boolean;
Function IsControlWxWindow(ctrl: TControl): Boolean;
Function IsControlWxToolBar(ctrl: TControl): Boolean;
Function IsControlWxStatusBar(ctrl: TControl): Boolean;
Function IsControlWxNonVisible(ctrl: TControl): Boolean;
Function GetNonVisualComponentCount(frmMainObj: TForm): Integer;
Function IsControlWxAuiManager(ctrl: TControl): Boolean;
Function IsControlWxAuiToolBar(ctrl: TControl): Boolean;

Function GetWxIDString(strID: String; intID: Longint): String;
Function IsValidClass(Comp: TComponent): Boolean;
Function GetEventNameFromDisplayName(strDisplayName: String;
    strlst: TStringList): String;
Function AlignmentToStr(taPos: TAlignment): String;
Procedure ChangeControlZOrder(Sender: TObject; MoveUp: Boolean = True);
Function GetXPMFromTPicture(XPMName: String; delphiBitmap: TBitmap): String;
Function GenerateXPMDirectly(bmp: TBitmap; strCompName: String;
    strParentName: String; strFileName: String): Boolean;
Function OpenXPMImage(InpImage: TBitmap; strFname: String): Boolean;
Function GetCppString(str: String): String;
Function GetWxPosition(Left: Integer; Top: Integer): String;
Function GetWxSize(Width: Integer; Height: Integer): String;
Function GetWxEnum(Wx_IDValue: Integer; Wx_IDName: String): String;
Function GetCommentString(str: String): String;
Function GetWxFontDeclaration(fnt: TFont): String;
Function GetDesignerFormName(cntrl: TControl): String;
Function GetWxWidgetParent(cntrl: TControl; AuiManaged: Boolean): String;
Function GetWxWindowControls(wnCtrl: TWinControl): Integer;
Function GetAvailableControlCount(ParentControl: TWinControl;
    ControlToCheck: TComponent): Integer; Overload;
Function GetAvailableControlCount(ParentControl: TWinControl;
    ControlToCheck: String): Integer; Overload;
Function GetMaxIDofWxForm(ParentControl: TWinControl): Integer;
Function GetMenuKindAsText(menuStyle: TWxMenuItemStyleItem): String;
Function GetToolButtonKindAsText(toolStyle:
    TWxToolbottonItemStyleItem): String;

Function GetTotalHtOfAllToolBarAndStatusBar(ParentControl:
    TWinControl): Integer;
Function GetPredefinedwxIds: TStringList;
Function IsIDPredefined(str: String; strlst: TStringList): Boolean;

Function XML_Label(str: String): String;
Function CreateBlankXRC: TStringList;
Function GetWxMonthFromIndex(MonthIndex: Integer): String;
Function GetDateToString(dt: TDateTime): String;

Function GetLongName(Const ShortPathName: String): String;
// EAB TODO: Copied from utils. Check if we can place it in a single common place.
Function ValidateClassName(ClassName: String): Integer;
// EAB TODO: Copied from utils. Check if we can place it in a single common place.
Function CreateValidClassName(ClassName: String): String;
// EAB TODO: Copied from utils. Check if we can place it in a single common place.
Function ValidateFileName(FileName: String): Integer;
// EAB TODO: Copied from utils. Check if we can place it in a single common place.
Function CreateValidFileName(FileName: String): String;
// EAB TODO: Copied from utils. Check if we can place it in a single common place.

Function GetAuiManagerName(Control: TControl): String;
Function FormHasAuiManager(Control: TControl): Boolean;
Function GetAuiDockDirection(Wx_Aui_Dock_Direction:
    TwxAuiPaneDockDirectionItem): String;
Function GetAuiDockableDirections(Wx_Aui_Dockable_Direction:
    TwxAuiPaneDockableDirectionSet): String;
Function GetAui_Pane_Style(Wx_Aui_Pane_Style: TwxAuiPaneStyleSet): String;
Function GetAui_Pane_Buttons(Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet): String;
Function GetAuiRow(row: Integer): String;
Function GetAuiPosition(position: Integer): String;
Function GetAuiLayer(layer: Integer): String;
Function GetAuiPaneBestSize(width: Integer; height: Integer): String;
Function GetAuiPaneMinSize(width: Integer; height: Integer): String;
Function GetAuiPaneMaxSize(width: Integer; height: Integer): String;
Function GetAuiPaneFloatingSize(width: Integer; height: Integer): String;
Function GetAuiPaneFloatingPos(x: Integer; y: Integer): String;
Function GetAuiPaneCaption(caption: String): String;
Function GetAuiPaneName(name: String): String;
Function HasToolbarPaneStyle(Wx_Aui_Pane_Style: TwxAuiPaneStyleSet): Boolean;
Function GetRefinedWxEdtGeneralStyleValue(
    sValue: TWxEdtGeneralStyleSet): TWxEdtGeneralStyleSet;

Implementation

Uses DesignerFrm, wxlistCtrl, WxStaticBitmap, WxBitmapButton,
    WxSizerPanel, WxToolButton,
    UColorEdit, UMenuitem, WxCustomMenuItem, WxPopupMenu, WxMenuBar,
    WxCustomButton, WxTreeCtrl,
    WxNonVisibleBaseComponent, wxdesigner, wxnotebook, wxAUInotebook,
    OpenSaveDialogs, wxAuiManager, wxAuiNoteBookPage
{$IFDEF WIN32}
    , ShlObj, ActiveX
{$ENDIF}
    ;

Function ExtractComponentPropertyName(Const S: String): String;
Var
    SepaPos: Integer;
Begin
    Result := '';
    SepaPos := Pos(':', S);
    If SepaPos > 1 Then
        Result := Copy(S, 1, SepaPos - 1);
End;

Function CreateGraphicFileDir(strFileName: String): String;
Var
    strDir: String;
    fileDir: String;
    workingDir: String;
Begin

    strDir := '';
    fileDir := IncludetrailingPathDelimiter(ExtractFileDir(strFileName));

    // Get current working directory
    workingDir := GetCurrentDir;
    // If working directory already contained within fileDir, then
    //    don't add it again.
    If AnsiContainsStr(fileDir, workingDir) Then
        workingDir := '';

    // See if file directory exists
    If DirectoryExists(fileDir) Then
        strDir := fileDir

    // Try working directory plus file directory
    Else
    If DirectoryExists(workingDir + pd + fileDir) Then
        strDir := workingDir + pd + fileDir
    Else
    Begin
        // Try to force the directory creation
        If ForceDirectories(workingDir + pd + fileDir) Then
            strDir := workingDir + pd + fileDir
        Else

            ShowMessage('ERROR: Can''t create directory ' +
                workingDir + pd + fileDir);

    End;

    strDir := IncludetrailingPathDelimiter(strDir);

    //strDir := AnsiReplaceText(strDir, '\', '/');

    Result := strDir;

End;

Function CreateGraphicFileName(strFileName: String): String;
Begin

    strFileName := CreateGraphicFileDir(strFileName)
        + ExtractFileName(strFileName);

    strFileName := AnsiReplaceText(strFileName, '\', '/');

    Result := strFileName;

End;

Function ExtractComponentPropertyCaption(Const S: String): String;
Var
    SepaPos: Integer;
Begin
    Result := '';
    If S = '' Then
        Exit;
    SepaPos := Pos(':', S);
    If SepaPos > 1 Then
        Result := Copy(S, SepaPos + 1, Length(S));
End;

Function iswxForm(FileName: String): Boolean;
Begin
    If LowerCase(ExtractFileExt(FileName)) = LowerCase(WXFORM_EXT) Then
        Result := True
    Else
        result := False;
End;

{function isRCExt(FileName: string): boolean;
begin
  if LowerCase(ExtractFileExt(FileName)) = LowerCase(RC_EXT) then
    Result := true
  else
    result := False;
end;}

Function isXRCExt(FileName: String): Boolean;
Begin
    If LowerCase(ExtractFileExt(FileName)) = LowerCase(XRC_EXT) Then
        Result := True
    Else
        result := False;
End;

Function SaveStringToFile(strContent, strFileName: String): Boolean;
Var
    strStringList: TStringList;
Begin
    Result := True;
    strStringList := TStringList.Create;
    strStringList.Text := strContent;
    Try
        strStringList.SaveToFile(strFileName);
    Except
        Result := False;
    End;
    strStringList.Destroy;
End;

Constructor TWxValidatorString.Create(Owner: TComponent);
Begin
    Inherited;
End;

Function TranslateChar(Const Str: String; FromChar, ToChar: Char): String;
Var
    I: Integer;
Begin
    Result := Str;
    For I := 1 To Length(Result) Do
        If Result[I] = FromChar Then
            Result[I] := ToChar;
End;

Function UnixPathToDosPath(Const Path: String): String;
Begin
    Result := TranslateChar(Path, '/', '\');
End;

Function LocalConvertLibsToCurrentVersion(strValue: String): String;
Begin
    Result := Convert25LibsToCurrentVersion(strValue);
    Result := Convert26LibsToCurrentVersion(Result);
    //Auto -mwindows flag addition
    If AnsiContainsText(Result, '-lwxmsw') And
        (AnsiContainsText(Result, '-mwindows') = False) Then
    Begin
        Result := '-mwindows_@@_' + Result;
    End;
End;

Function Convert25LibsToCurrentVersion(strValue: String): String;
Begin
    Result := StringReplace(strValue, 'wxmsw25', 'wxmsw27', [rfReplaceAll]);
End;

Function Convert26LibsToCurrentVersion(strValue: String): String;
Begin
    Result := StringReplace(strValue, 'wxmsw26', 'wxmsw27', [rfReplaceAll]);
End;

Function GetDateToString(dt: TDateTime): String;
Var
    AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word;
Begin
    DecodeDateTime(dt, AYear, AMonth, ADay, AHour, AMinute, ASecond,
        AMilliSecond);
    Result := Format('%d/%d/%d', [AMonth, ADay, AYear]);
End;

Function GetWxMonthFromIndex(MonthIndex: Integer): String;
Begin
    Case MonthIndex Of
        1:
            Result := 'wxDateTime::Jan';
        2:
            Result := 'wxDateTime::Feb';
        3:
            Result := 'wxDateTime::Mar';
        4:
            Result := 'wxDateTime::Apr';
        5:
            Result := 'wxDateTime::May';
        6:
            Result := 'wxDateTime::Jun';
        7:
            Result := 'wxDateTime::Jul';
        8:
            Result := 'wxDateTime::Aug';
        9:
            Result := 'wxDateTime::Sep';
        10:
            Result := 'wxDateTime::Oct';
        11:
            Result := 'wxDateTime::Nov';
        12:
            Result := 'wxDateTime::Dec';
    End;
End;

Function XML_Label(str: String): String;
Begin

    // Some string characters need to be changed for the XRC format
    // See http://cvs.wxwidgets.org/viewcvs.cgi/wxWidgets/docs/tech/tn0014.txt?rev=1.18&content-type=text/vnd.viewcvs-markup
    // Section 3. "Common attribute types", Subsection "String"
    strChange(str, '_', '__');
    strChange(str, '&', '_');
    strChange(str, '/', '//');
    Result := str;

End;

Function GetTotalHtOfAllToolBarAndStatusBar(ParentControl:
    TWinControl): Integer;
Var
    I: Integer;
Begin
    Result := 0;
    For I := 0 To ParentControl.ControlCount - 1 Do // Iterate
    Begin
        If Not (IsControlWxToolBar(ParentControl.Controls[i]) Or
            IsControlWxStatusBar(ParentControl.Controls[i])) Then
            continue;
        Result := Result + ParentControl.Controls[i].Height;
    End; // for
End;

Function IsIDPredefined(str: String; strlst: TStringList): Boolean;
Begin
    If strlst.IndexOf(str) <> -1 Then
        Result := True
    Else
        Result := False;
End;

Function GetPredefinedwxIds: TStringList;
Begin
    Result := TStringList.Create;
    Result.add('wxID_OPEN');
    Result.add('wxID_CLOSE');
    Result.add('wxID_NEW');
    Result.add('wxID_SAVE');
    Result.add('wxID_SAVEAS');
    Result.add('wxID_REVERT');
    Result.add('wxID_EXIT');
    Result.add('wxID_UNDO');
    Result.add('wxID_REDO');
    Result.add('wxID_HELP');
    Result.add('wxID_PRINT');
    Result.add('wxID_PRINT_SETUP');
    Result.add('wxID_PAGE_SETUP');
    Result.add('wxID_PREVIEW');
    Result.add('wxID_ABOUT');
    Result.add('wxID_HELP_CONTENTS');
    Result.add('wxID_HELP_INDEX');
    Result.add('wxID_HELP_SEARCH');
    Result.add('wxID_HELP_COMMANDS');
    Result.add('wxID_HELP_PROCEDURES');
    Result.add('wxID_HELP_CONTEXT');
    Result.add('wxID_CLOSE_ALL');
    Result.add('wxID_PREFERENCES');
    Result.add('wxID_EDIT');
    Result.add('wxID_CUT');
    Result.add('wxID_COPY');
    Result.add('wxID_PASTE');
    Result.add('wxID_CLEAR');
    Result.add('wxID_FIND');
    Result.add('wxID_DUPLICATE');
    Result.add('wxID_SELECTALL');
    Result.add('wxID_DELETE');
    Result.add('wxID_REPLACE');
    Result.add('wxID_REPLACE_ALL');
    Result.add('wxID_PROPERTIES');
    Result.add('wxID_VIEW_DETAILS');
    Result.add('wxID_VIEW_LARGEICONS');
    Result.add('wxID_VIEW_SMALLICONS');
    Result.add('wxID_VIEW_LIST');
    Result.add('wxID_VIEW_SORTDATE');
    Result.add('wxID_VIEW_SORTNAME');
    Result.add('wxID_VIEW_SORTSIZE');
    Result.add('wxID_VIEW_SORTTYPE');
    Result.add('wxID_FILE');
    Result.add('wxID_FILE1');
    Result.add('wxID_FILE2');
    Result.add('wxID_FILE3');
    Result.add('wxID_FILE4');
    Result.add('wxID_FILE5');
    Result.add('wxID_FILE6');
    Result.add('wxID_FILE7');
    Result.add('wxID_FILE8');
    Result.add('wxID_FILE9');
    Result.add('wxID_OK');
    Result.add('wxID_CANCEL');
    Result.add('wxID_APPLY');
    Result.add('wxID_YES');
    Result.add('wxID_NO');
    Result.add('wxID_STATIC');
    Result.add('wxID_FORWARD');
    Result.add('wxID_BACKWARD');
    Result.add('wxID_DEFAULT');
    Result.add('wxID_MORE');
    Result.add('wxID_SETUP');
    Result.add('wxID_RESET');
    Result.add('wxID_CONTEXT_HELP');
    Result.add('wxID_YESTOALL');
    Result.add('wxID_NOTOALL');
    Result.add('wxID_ABORT');
    Result.add('wxID_RETRY');
    Result.add('wxID_IGNORE');
    Result.add('wxID_ADD');
    Result.add('wxID_REMOVE');
    Result.add('wxID_UP');
    Result.add('wxID_DOWN');
    Result.add('wxID_HOME');
    Result.add('wxID_REFRESH');
    Result.add('wxID_STOP');
    Result.add('wxID_INDEX');
    Result.add('wxID_BOLD');
    Result.add('wxID_ITALIC');
    Result.add('wxID_JUSTIFY_CENTER');
    Result.add('wxID_JUSTIFY_FILL');
    Result.add('wxID_JUSTIFY_RIGHT');
    Result.add('wxID_JUSTIFY_LEFT');
    Result.add('wxID_UNDERLINE');
    Result.add('wxID_INDENT');
    Result.add('wxID_UNINDENT');
    Result.add('wxID_ZOOM_100');
    Result.add('wxID_ZOOM_FIT');
    Result.add('wxID_ZOOM_IN');
    Result.add('wxID_ZOOM_OUT');
    Result.add('wxID_UNDELETE');
    Result.add('wxID_REVERT_TO_SAVED');
    Result.add('wxID_SYSTEM_MENU');
    Result.add('wxID_CLOSE_FRAME');
    Result.add('wxID_MOVE_FRAME');
    Result.add('wxID_RESIZE_FRAME');
    Result.add('wxID_MAXIMIZE_FRAME');
    Result.add('wxID_ICONIZE_FRAME');
    Result.add('wxID_RESTORE_FRAME');
    Result.add('wxID_FILEDLGG');
End;

Function GetGridSelectionToString(grdsel: TWxGridSelection): String;
Begin
    Result := 'wxGridSelectCells';
    If grdsel = wxGridSelectCells Then
        Result := 'wxGridSelectCells';
    If grdsel = wxGridSelectColumns Then
        Result := 'wxGridSelectColumns';
    If grdsel = wxGridSelectRows Then
        Result := 'wxGridSelectRows';

End;

Function GetWxFontDeclaration(fnt: TFont): String;
Var
    strStyle, strWeight, strUnderline: String;
Begin
    If (fnt.Name = Screen.HintFont.Name) And
        (fnt.Size = Screen.HintFont.Size) And
        (fnt.Style = Screen.HintFont.Style) Then
        Result := ''
    Else
    Begin
        If fsItalic In fnt.Style Then
            strStyle := 'wxITALIC'
        Else
            strStyle := 'wxNORMAL';

        If fsBold In fnt.Style Then
            strWeight := 'wxBOLD'
        Else
            strWeight := 'wxNORMAL';

        If fsUnderline In fnt.Style Then
            strUnderline := 'true'
        Else
            strUnderline := 'false';

        If fnt.Name <> Screen.IconFont.Name Then
            Result := Format('wxFont(%d, wxSWISS, %s, %s, %s, %s)',
                [fnt.Size, strStyle, strWeight, strUnderline, GetCppString(fnt.Name)])
        Else
            Result := Format('wxFont(%d, wxSWISS, %s, %s, %s)',
                [fnt.Size, strStyle, strWeight, strUnderline]);
    End;
End;

Function GetDesignerFormName(cntrl: TControl): String;
Var
    ParentCtrl, PrevParentCtrl: TControl;

Begin
    ParentCtrl := cntrl.Parent;
    If ParentCtrl = Nil Then
    Begin
        If cntrl Is TfrmNewForm Then
        Begin
            Result := TfrmNewForm(cntrl).Wx_Name;
            exit;
        End;
    End;

    While (ParentCtrl <> Nil) Do
    Begin
        PrevParentCtrl := ParentCtrl;
        ParentCtrl := ParentCtrl.Parent;
        If ParentCtrl = Nil Then
        Begin
            If PrevParentCtrl Is TfrmNewForm Then
                Result := TfrmNewForm(PrevParentCtrl).Wx_Name
            Else
                Result := '';
            exit;
        End;
    End;

End;

Function GetWxWidgetParent(cntrl: TControl; AuiManaged: Boolean): String;
Var
    TestCtrl: TControl;
Begin
    Result := '';
    If cntrl = Nil Then
        exit;

    If cntrl.Parent = Nil Then
        exit;

    If cntrl.Parent Is TForm Then
    Begin
        Result := 'this';
        exit;
    End;

    {mn
    if not (cntrl.Parent is TwxSizerPanel) then
    begin
      Result := cntrl.Parent.Name;
      exit;
    end;
  mn}

    If (AuiManaged And Not (cntrl.Parent Is TWxSizerPanel))
    // protect ourselves from idiots
    {or (cntrl.Parent is TWxAuiNoteBookPage)} Then
    Begin
        Result := 'this';
        Exit;
    End;

    If (cntrl.Parent Is TWxAuiNoteBookPage) Then
    Begin
        Result := cntrl.Parent.Parent.Name;
        Exit;
    End;

    If (cntrl.Parent Is TWxSizerPanel) Then
    Begin
        TestCtrl := cntrl.Parent;
        Result := TestCtrl.Name;
        While ((TestCtrl Is TWxSizerPanel)) Do
        Begin
            If (TestCtrl Is TWxSizerPanel) Then
                TestCtrl := TestCtrl.Parent;

            If TestCtrl = Nil Then
            Begin
                Result := 'this';
                break;
            End;
            If (TestCtrl Is TForm) Then
                Result := 'this'
            Else
                Result := TestCtrl.Name;
        End;
        Exit;
    End;

    If (cntrl.Parent Is TWxNotebook) Or (cntrl.Parent Is TWxAuiNotebook) Then
    Begin
        Result := cntrl.Parent.Name;
        exit;

    End;

    If (cntrl.Parent Is TPageControl) Then
        //we assume compound tool/choice/list/tool/tree-books
    Begin
        Result := GetWxWidgetParent(cntrl.Parent, False);
        //this should return the grandparent
        exit;
    End
    Else
    Begin
        Result := cntrl.Parent.Name;
        exit;
    End;

End;

Function GetWxWindowControls(wnCtrl: TWinControl): Integer;
Var
    I: Integer;
    wndInterface: IWxWindowInterface;
Begin
    Result := 0;
    For I := 0 To wnCtrl.ComponentCount - 1 Do // Iterate
        If wnCtrl.Components[i].GetInterface(IID_IWxWindowInterface,
            wndInterface) Then
            Inc(Result); // for
End;

Function GetMaxIDofWxForm(ParentControl: TWinControl): Integer;
Var
    wxcompInterface: IWxComponentInterface;
    I: Integer;
Begin
    Result := 0;
    For I := 0 To ParentControl.ComponentCount - 1 Do // Iterate
        If ParentControl.Components[I].GetInterface(IID_IWxComponentInterface,
            wxcompInterface) Then
            If wxcompInterface.GetIDValue > Result Then
                Result := wxcompInterface.GetIDValue;

    // Fix for erroneously large ID values
    If (Result > 32768) Then
    Begin

        Result := 1001;
        For I := 0 To ParentControl.ComponentCount - 1 Do // Iterate
            If ParentControl.Components[I].GetInterface(IID_IWxComponentInterface,
                wxcompInterface) Then
            Begin
                wxcompInterface.SetIDValue(Result);
                Result := Result + 1;
            End;
    End;

    If Result = 0 Then
        Result := 1000;

End;

Function GetMenuKindAsText(menuStyle: TWxMenuItemStyleItem): String;
Begin
    Result := 'wxITEM_NORMAL';
    If menuStyle = wxMnuItm_Normal Then
    Begin
        Result := 'wxITEM_NORMAL';
        exit;
    End;

    If menuStyle = wxMnuItm_Separator Then
    Begin
        Result := 'wxITEM_SEPARATOR';
        exit;
    End;
    If menuStyle = wxMnuItm_Radio Then
    Begin
        Result := 'wxITEM_RADIO';
        exit;
    End;
    If menuStyle = wxMnuItm_Check Then
    Begin
        Result := 'wxITEM_CHECK';
        exit;
    End;

End;

Function GetToolButtonKindAsText(toolStyle:
    TWxToolbottonItemStyleItem): String;
Begin
    Result := 'wxITEM_NORMAL';
    If toolStyle = wxITEM_NORMAL Then
    Begin
        Result := 'wxITEM_NORMAL';
        exit;
    End;

    If toolStyle = wxITEM_RADIO Then
    Begin
        Result := 'wxITEM_RADIO';
        exit;
    End;

    If toolStyle = wxITEM_CHECK Then
    Begin
        Result := 'wxITEM_CHECK';
        exit;
    End;

End;

Function GetAvailableControlCount(ParentControl: TWinControl;
    ControlToCheck: String): Integer; Overload;
Var
    I: Integer;
Begin
    Result := 0;
    For I := 0 To ParentControl.ComponentCount - 1 Do // Iterate
        If strContainsU(ParentControl.Components[i].ClassName, ControlToCheck) Then
            Inc(Result); // for
End;

Function GetAvailableControlCount(ParentControl: TWinControl;
    ControlToCheck: TComponent): Integer; Overload;
Var
    I: Integer;
Begin
    Result := 0;
    For I := 0 To ParentControl.ComponentCount - 1 Do // Iterate
        If strContainsU(ParentControl.Components[i].ClassName,
            ControlToCheck.ClassName) Then
            Inc(Result); // for
End;

Function GetEventNameFromDisplayName(strDisplayName: String;
    strlst: TStringList): String;
Var
    I: Integer;
    strEventName, strEventCaption: String;
    intPos: Integer;
Begin
    Result := '';
    For i := 0 To strlst.Count - 1 Do // Iterate
    Begin
        intPos := Pos(':', strlst[i]);
        strEventName := Copy(strlst[i], 0, intPos - 1);
        strEventCaption := Trim(Copy(strlst[i], intPos + 1, Length(strlst[i])));
        If AnsiSameText(strEventCaption, strDisplayName) Then
            Result := strEventName;
    End; // for
End;

Function IsValidClass(Comp: TComponent): Boolean;
Var
    intfObj: IWxComponentInterface;
Begin
    Result := Comp.GetInterface(IID_IWxComponentInterface, intfObj);
End;

//Here is the start

Function GetCheckboxStyleString(stdStyle: TWxcbxStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin
    strLst := TStringList.Create;

    Try

        If wxCHK_2STATE In stdStyle Then
            strLst.add('wxCHK_2STATE ');

        If wxCHK_3STATE In stdStyle Then
            strLst.add('wxCHK_3STATE ');

        If wxCHK_ALLOW_3RD_STATE_FOR_USER In stdStyle Then
            strLst.add('wxCHK_ALLOW_3RD_STATE_FOR_USER');

        If wxALIGN_RIGHT_CB In stdStyle Then
            strLst.add('wxALIGN_RIGHT');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;
End;

Function GetTreeviewStyleString(stdStyle: TWxtvStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin
    strLst := TStringList.Create;

    Try
        If wxTR_EDIT_LABELS In stdStyle Then
            strLst.add('wxTR_EDIT_LABELS');

        If wxTR_NO_BUTTONS In stdStyle Then
            strLst.add('wxTR_NO_BUTTONS');

        If wxTR_HAS_BUTTONS In stdStyle Then
            strLst.add('wxTR_HAS_BUTTONS');

        If wxTR_TWIST_BUTTONS In stdStyle Then
            strLst.add('wxTR_TWIST_BUTTONS');

        If wxTR_NO_LINES In stdStyle Then
            strLst.add('wxTR_NO_LINES');

        If wxTR_FULL_ROW_HIGHLIGHT In stdStyle Then
            strLst.add('wxTR_FULL_ROW_HIGHLIGHT');

        If wxTR_LINES_AT_ROOT In stdStyle Then
            strLst.add('wxTR_LINES_AT_ROOT');

        If wxTR_HIDE_ROOT In stdStyle Then
            strLst.add('wxTR_HIDE_ROOT');

        If wxTR_ROW_LINES In stdStyle Then
            strLst.add('wxTR_ROW_LINES');

        If wxTR_HAS_VARIABLE_ROW_HEIGHT In stdStyle Then
            strLst.add('wxTR_HAS_VARIABLE_ROW_HEIGHT');

        If wxTR_SINGLE In stdStyle Then
            strLst.add('wxTR_SINGLE');

        If wxTR_MULTIPLE In stdStyle Then
            strLst.add('wxTR_MULTIPLE');

        If wxTR_EXTENDED In stdStyle Then
            strLst.add('wxTR_EXTENDED');

        If wxTR_DEFAULT_STYLE In stdStyle Then
            strLst.add('wxTR_DEFAULT_STYLE');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;
End;

Function GetRadiobuttonStyleString(stdStyle: TWxrbStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxRB_GROUP In stdStyle Then
            strLst.add('wxRB_GROUP');

        If wxRB_SINGLE In stdStyle Then
            strLst.add('wxRB_SINGLE');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;
End;

Function GetRTSListCtrlStyleString(stdStyle: TwxRichTextSLCStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin
    strLst := TStringList.Create;

    Try
        If wxRICHTEXTSTYLELIST_HIDE_TYPE_SELECTOR In stdStyle Then
            strLst.add('wxRICHTEXTSTYLELIST_HIDE_TYPE_SELECTOR');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
    Finally
        strLst.Destroy;
    End;
End;


Function GetListboxStyleString(stdStyle: TWxlbxStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin
    strLst := TStringList.Create;

    Try
        // if wxLB_SINGLE  in stdStyle then
        //   strLst.add('wxLB_SINGLE');

        // if wxLB_MULTIPLE  in stdStyle then
        //  strLst.add('wxLB_MULTIPLE');

        // if wxLB_EXTENDED   in stdStyle then
        //   strLst.add('wxLB_EXTENDED');

        If wxLB_HSCROLL In stdStyle Then
            strLst.add('wxLB_HSCROLL');

        If wxLB_ALWAYS_SB In stdStyle Then
            strLst.add('wxLB_ALWAYS_SB');

        If wxLB_NEEDED_SB In stdStyle Then
            strLst.add('wxLB_NEEDED_SB');

        If wxLB_SORT In stdStyle Then
            strLst.add('wxLB_SORT');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
    Finally
        strLst.Destroy;
    End;
End;

Function GetGaugeStyleString(stdStyle: TWxgagStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxGA_SMOOTH In stdStyle Then
            strLst.add('wxGA_SMOOTH');

        If wxGA_MARQUEE In stdStyle Then
            strLst.add('wxGA_MARQUEE');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);

    Finally
        strLst.Destroy;
    End;

End;

Function GetScrollbarStyleString(stdStyle: TWxsbrStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxST_SIZEGRIP In stdStyle Then
            strLst.add('wxST_SIZEGRIP');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);

    Finally
        strLst.Destroy;
    End;

End;

Function GetSpinButtonStyleString(stdStyle: TWxsbtnStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxSP_ARROW_KEYS In stdStyle Then
            strLst.add('wxSP_ARROW_KEYS');

        If wxSP_WRAP In stdStyle Then
            strLst.add('wxSP_WRAP');

        { if wxSP_HORIZONTAL in stdStyle then
       strLst.add('wxSP_HORIZONTAL');

     if wxSP_VERTICAL in stdStyle then
       strLst.add('wxSP_VERTICAL');
     }
        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;

End;

Function GetHyperLnkStyleString(stdStyle: TWxHyperLnkStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin
    strLst := TStringList.Create;
    Try
        If wxHL_ALIGN_LEFT In stdStyle Then
            strLst.add('wxHL_ALIGN_LEFT');

        If wxHL_ALIGN_RIGHT In stdStyle Then
            strLst.add('wxHL_ALIGN_RIGHT');

        If wxHL_ALIGN_CENTRE In stdStyle Then
            strLst.add('wxHL_ALIGN_CENTRE');

        If wxHL_CONTEXTMENU In stdStyle Then
            strLst.add('wxHL_CONTEXTMENU');

        If wxHL_DEFAULT_STYLE In stdStyle Then
            strLst.add('wxHL_DEFAULT_STYLE');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;
End;

Function GetSliderStyleString(stdStyle: TWxsldrStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxSL_AUTOTICKS In stdStyle Then
            strLst.add('wxSL_AUTOTICKS');

        If wxSL_LABELS In stdStyle Then
            strLst.add('wxSL_LABELS');

        If wxSL_LEFT In stdStyle Then
            strLst.add('wxSL_LEFT');

        If wxSL_RIGHT In stdStyle Then
            strLst.add('wxSL_RIGHT');

        If wxSL_TOP In stdStyle Then
            strLst.add('wxSL_TOP');

        If wxSL_BOTTOM In stdStyle Then
            strLst.add('wxSL_BOTTOM');

        If wxSL_BOTH In stdStyle Then
            strLst.add('wxSL_BOTH');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;
End;

Function GetPickCalStyleString(stdStyle: TWxPickCalStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxDP_SPIN In stdStyle Then
            strLst.add('wxDP_SPIN');

        If wxDP_DROPDOWN In stdStyle Then
            strLst.add('wxDP_DROPDOWN');

        If wxDP_DEFAULT In stdStyle Then
            strLst.add('wxDP_DEFAULT');

        If wxDP_ALLOWNONE In stdStyle Then
            strLst.add('wxDP_ALLOWNONE');

        If wxDP_SHOWCENTURY In stdStyle Then
            strLst.add('wxDP_SHOWCENTURY');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;
End;

Function GetCalendarCtrlStyleString(stdStyle: TWxcalctrlStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxCAL_SUNDAY_FIRST In stdStyle Then
            strLst.add('wxCAL_SUNDAY_FIRST');

        If wxCAL_MONDAY_FIRST In stdStyle Then
            strLst.add('wxCAL_MONDAY_FIRST');

        If wxCAL_SHOW_HOLIDAYS In stdStyle Then
            strLst.add('wxCAL_SHOW_HOLIDAYS');

        If wxCAL_NO_YEAR_CHANGE In stdStyle Then
            strLst.add('wxCAL_NO_YEAR_CHANGE');

        If wxCAL_NO_MONTH_CHANGE In stdStyle Then
            strLst.add('wxCAL_NO_MONTH_CHANGE');

        If wxCAL_SHOW_SURROUNDING_WEEKS In stdStyle Then
            strLst.add('wxCAL_SHOW_SURROUNDING_WEEKS');

        If wxCAL_SEQUENTIAL_MONTH_SELECTION In stdStyle Then
            strLst.add('wxCAL_SEQUENTIAL_MONTH_SELECTION');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;

End;

{
function GetChoicebookStyleString(stdStyle: TWxchbxStyleSet): string;
var
  I: integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try


  //check for choicebook styles here

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i] // for
          ;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;

end;
}
{
function GetListbookStyleString(stdStyle: TWxlbbxStyleSet): string;
var
  I: integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try

    if wxLB_DEFAULT in stdStyle then
      strLst.add('wxLB_DEFAULT');

    if wxLB_TOP in stdStyle then
      strLst.add('wxLB_TOP');

    if wxLB_LEFT in stdStyle then
      strLst.add('wxLB_LEFT');

    if wxLB_RIGHT in stdStyle then
      strLst.add('wxLB_RIGHT');

    if wxLB_BOTTOM in stdStyle then
      strLst.add('wxLB_BOTTOM');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i] // for
          ;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;

end;
}

Function GetNotebookStyleString(stdStyle: TWxnbxStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try

        If wxNB_FIXEDWIDTH In stdStyle Then
            strLst.add('wxNB_FIXEDWIDTH');

        If wxNB_MULTILINE In stdStyle Then
            strLst.add('wxNB_MULTILINE');

        If wxNB_NOPAGETHEME In stdStyle Then
            strLst.add('wxNB_NOPAGETHEME');

        If wxNB_FLAT In stdStyle Then
            strLst.add('wxNB_FLAT');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);

    Finally
        strLst.Destroy;
    End;

End;

Function GetAuiNotebookStyleString(stdStyle: TWxAuinbxStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try

        If wxAUI_NB_TAB_SPLIT In stdStyle Then
            strLst.add('wxAUI_NB_TAB_SPLIT');

        If wxAUI_NB_TAB_MOVE In stdStyle Then
            strLst.add('wxAUI_NB_TAB_MOVE');

        If wxAUI_NB_TAB_EXTERNAL_MOVE In stdStyle Then
            strLst.add('wxAUI_NB_TAB_EXTERNAL_MOVE');

        If wxAUI_NB_TAB_FIXED_WIDTH In stdStyle Then
            strLst.add('wxAUI_NB_TAB_FIXED_WIDTH');

        If wxAUI_NB_SCROLL_BUTTONS In stdStyle Then
            strLst.add('wxAUI_NB_SCROLL_BUTTONS');

        If wxAUI_NB_WINDOWLIST_BUTTON In stdStyle Then
            strLst.add('wxAUI_NB_WINDOWLIST_BUTTON');

        If wxAUI_NB_CLOSE_BUTTON In stdStyle Then
            strLst.add('wxAUI_NB_CLOSE_BUTTON');

        If wxAUI_NB_CLOSE_ON_ACTIVE_TAB In stdStyle Then
            strLst.add('wxAUI_NB_CLOSE_ON_ACTIVE_TAB');

        If wxAUI_NB_CLOSE_ON_ALL_TABS In stdStyle Then
            strLst.add('wxAUI_NB_CLOSE_ON_ALL_TABS');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);

    Finally
        strLst.Destroy;
    End;

End;

{
function GetToolbookStyleString(stdStyle: TWxtlbxStyleSet): string;
var
  I: integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try

    if wxTLB_DEFAULT in stdStyle then
      strLst.add('wxLB_DEFAULT');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i] // for
          ;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;

end;
}
{
function GetTreebookStyleString(stdStyle: TWxtrbxStyleSet): string;
var
  I: integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try

    if wxBK_DEFAULT in stdStyle then
      strLst.add('wxBK_DEFAULT');

    if wxBK_TOP in stdStyle then
      strLst.add('wxBK_TOP');

    if wxBK_LEFT in stdStyle then
      strLst.add('wxBK_LEFT');

    if wxBK_RIGHT in stdStyle then
      strLst.add('wxBK_RIGHT');

    if wxBK_BOTTOM in stdStyle then
      strLst.add('wxBK_BOTTOM');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i] // for
          ;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;

end;
}

Function GetRadioBoxStyleString(stdStyle: TWxrbxStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxRA_SPECIFY_ROWS In stdStyle Then
            strLst.add('wxRA_SPECIFY_ROWS');

        If wxRA_SPECIFY_COLS In stdStyle Then
            strLst.add('wxRA_SPECIFY_COLS');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;
End;

Function GetStatusBarStyleString(stdStyle: TWxsbrStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxST_SIZEGRIP In stdStyle Then
            strLst.add('wxST_SIZEGRIP');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;
End;

Function GetToolBarStyleString(stdStyle: TWxtbrStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin
    strLst := TStringList.Create;

    Try
        If wxTB_FLAT In stdStyle Then
            strLst.add('wxTB_FLAT');

        If wxTB_DOCKABLE In stdStyle Then
            strLst.add('wxTB_DOCKABLE');

        If wxTB_HORIZONTAL In stdStyle Then
            strLst.add('wxTB_HORIZONTAL');

        If wxTB_VERTICAL In stdStyle Then
            strLst.add('wxTB_VERTICAL');

        If wxTB_TEXT In stdStyle Then
            strLst.add('wxTB_TEXT');

        If wxTB_NOICONS In stdStyle Then
            strLst.add('wxTB_NOICONS');

        If wxTB_NODIVIDER In stdStyle Then
            strLst.add('wxTB_NODIVIDER');

        If wxTB_NOALIGN In stdStyle Then
            strLst.add('wxTB_NOALIGN');

        If wxTB_HORZ_LAYOUT In stdStyle Then
            strLst.add('wxTB_HORZ_LAYOUT');

        If wxTB_HORZ_TEXT In stdStyle Then
            strLst.add('wxTB_HORZ_TEXT');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;
End;

Function GetScrolledWindowStyleString(stdStyle: TWxScrWinStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin
    strLst := TStringList.Create;

    Try
        If wxRETAINED In stdStyle Then
            strLst.add('wxRETAINED');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);

    Finally
        strLst.Destroy;
    End;

End;

Function GetHtmlWindowStyleString(stdStyle: TWxHtmlWinStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try

        If wxHW_SCROLLBAR_NEVER In stdStyle Then
            strLst.add('wxHW_SCROLLBAR_NEVER');

        If wxHW_SCROLLBAR_AUTO In stdStyle Then
            strLst.add('wxHW_SCROLLBAR_AUTO');

        If wxHW_NO_SELECTION In stdStyle Then
            strLst.add('wxHW_NO_SELECTION ');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);

    Finally
        strLst.Destroy;
    End;

End;

Function GetSplitterWindowStyleString(stdStyle:
    TWxSplitterWinStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxSP_3D In stdStyle Then
            strLst.add('wxSP_3D');

        If wxSP_3DSASH In stdStyle Then
            strLst.add('wxSP_3DSASH');

        If wxSP_3DBORDER In stdStyle Then
            strLst.add('wxSP_3DBORDER ');

        If wxSP_BORDER In stdStyle Then
            strLst.add('wxSP_BORDER');

        If wxSP_NOBORDER In stdStyle Then
            strLst.add('wxSP_NOBORDER');

        If wxSP_NO_XP_THEME In stdStyle Then
            strLst.add('wxSP_NO_XP_THEME ');

        If wxSP_PERMIT_UNSPLIT In stdStyle Then
            strLst.add('wxSP_PERMIT_UNSPLIT');

        If wxSP_LIVE_UPDATE In stdStyle Then
            strLst.add('wxSP_LIVE_UPDATE');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);

    Finally
        strLst.Destroy;
    End;

End;

Function GetFileDialogStyleString(stdStyle: TWxFileDialogStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxHIDE_READONLY In stdStyle Then
            strLst.add('wxFD_HIDE_READONLY');

        If wxOVERWRITE_PROMPT In stdStyle Then
            strLst.add('wxFD_OVERWRITE_PROMPT');

        If wxFILE_MUST_EXIST In stdStyle Then
            strLst.add('wxFD_FILE_MUST_EXIST');

        If wxMULTIPLE In stdStyle Then
            strLst.add('wxFD_MULTIPLE');

        If wxCHANGE_DIR In stdStyle Then
            strLst.add('wxFD_CHANGE_DIR');

        If strLst.Count = 0 Then
            Result := ''
        Else
        Begin
            Result := ' | ';
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i]; // for
        End;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;

End;

Function GetDirDialogStyleString(stdStyle: TWxDirDialogStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxDD_NEW_DIR_BUTTON In stdStyle Then
            strLst.add('wxDD_NEW_DIR_BUTTON');

        If strLst.Count = 0 Then
            Result := ''
        Else
        Begin
            Result := ', ';
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i]; // for
        End;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;

End;

Function GetProgressDialogStyleString(stdStyle:
    TWxProgressDialogStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxPD_APP_MODAL In stdStyle Then
            strLst.add('wxPD_APP_MODAL');

        If wxPD_SMOOTH In stdStyle Then
            strLst.add('wxPD_SMOOTH');

        If wxPD_CAN_SKIP In stdStyle Then
            strLst.add('wxPD_CAN_SKIP');

        If wxPD_AUTO_HIDE In stdStyle Then
            strLst.add('wxPD_AUTO_HIDE');

        If wxPD_CAN_ABORT In stdStyle Then
            strLst.add('wxPD_CAN_ABORT ');

        If wxPD_ELAPSED_TIME In stdStyle Then
            strLst.add('wxPD_ELAPSED_TIME ');

        If wxPD_ESTIMATED_TIME In stdStyle Then
            strLst.add('wxPD_ESTIMATED_TIME');

        If wxPD_REMAINING_TIME In stdStyle Then
            strLst.add('wxPD_REMAINING_TIME ');

        If strLst.Count = 0 Then
            Result := ''
        Else
        Begin
            Result := ', ';
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i]; // for
        End;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;

End;

Function GetMediaCtrlStyle(mediaStyle: TWxMediaCtrlControl): String;
Begin
    If wxMEDIACTRLPLAYERCONTROLS_NONE = mediaStyle Then
        Result := 'wxMEDIACTRLPLAYERCONTROLS_NONE';

    If wxMEDIACTRLPLAYERCONTROLS_STEP = mediaStyle Then
        Result := 'wxMEDIACTRLPLAYERCONTROLS_STEP';

    If wxMEDIACTRLPLAYERCONTROLS_VOLUME = mediaStyle Then
        Result := 'wxMEDIACTRLPLAYERCONTROLS_VOLUME';

End;

Function GetMediaCtrlStyleString(mediaStyle: TWxMediaCtrlControls): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxMEDIACTRLPLAYERCONTROLS_NONE In mediaStyle Then
            strLst.add('wxMEDIACTRLPLAYERCONTROLS_NONE');

        If wxMEDIACTRLPLAYERCONTROLS_STEP In mediaStyle Then
            strLst.add('wxMEDIACTRLPLAYERCONTROLS_STEP');

        If wxMEDIACTRLPLAYERCONTROLS_VOLUME In mediaStyle Then
            strLst.add('wxMEDIACTRLPLAYERCONTROLS_VOLUME');

        If strLst.Count = 0 Then
            Result := ''
        Else
        Begin
            Result := ' ';
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i]; // for
        End;
        //sendDebug(Result);

    Finally
        strLst.Destroy;
    End;

End;

Function GetMessageDialogStyleString(stdStyle: TWxMessageDialogStyleSet;
    NoEndComma: Boolean): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxOK In stdStyle Then
            strLst.add('wxOK');

        If wxCANCEL In stdStyle Then
            strLst.add('wxCANCEL');

        If wxYES_NO In stdStyle Then
            strLst.add('wxYES_NO');

        If wxYES_DEFAULT In stdStyle Then
            strLst.add('wxYES_DEFAULT');

        If wxNO_DEFAULT In stdStyle Then
            strLst.add('wxNO_DEFAULT');

        If wxICON_EXCLAMATION In stdStyle Then
            strLst.add('wxICON_EXCLAMATION');

        If wxICON_HAND In stdStyle Then
            strLst.add('wxICON_HAND');

        If wxICON_ERROR In stdStyle Then
            strLst.add('wxICON_ERROR');

        If wxICON_QUESTION In stdStyle Then
            strLst.add('wxICON_QUESTION');

        If wxICON_INFORMATION In stdStyle Then
            strLst.add('wxICON_INFORMATION');

        If wxCENTRE In stdStyle Then
            strLst.add('wxCENTRE');

        If strLst.Count = 0 Then
            Result := ''
        Else
        Begin
            Result := ' ';
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i]; // for
        End;
        //sendDebug(Result);

    Finally
        strLst.Destroy;
    End;

    If (Result <> '') And (NoEndComma = False) Then
    Begin
        Result := ',' + Result;
    End;
End;

Function GetFindReplaceFlagString(stdstyle: TWxFindReplaceFlagSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try

        If wxFR_DOWN In stdStyle Then
            strLst.add('wxFR_DOWN');

        If wxFR_WHOLEWORD In stdStyle Then
            strLst.add('wxFR_WHOLEWORD');

        If wxFR_MATCHCASE In stdStyle Then
            strLst.add('wxFR_MATCHCASE ');

        If strLst.Count = 0 Then
            Result := ''
        Else
        Begin
            Result := '';
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i]; // for
        End;
        //sendDebug(Result);

    Finally
        strLst.Destroy;
    End;

End;

Function GetFindReplaceDialogStyleString(stdstyle:
    TWxFindReplaceDialogStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxFR_REPLACEDIALOG In stdStyle Then
            strLst.add('wxFR_REPLACEDIALOG');

        If wxFR_NOUPDOWN In stdStyle Then
            strLst.add('wxFR_NOUPDOWN ');

        If wxFR_NOMATCHCASE In stdStyle Then
            strLst.add('wxFR_NOMATCHCASE');

        If wxFR_NOWHOLEWORD In stdStyle Then
            strLst.add('wxFR_NOWHOLEWORD');

        If strLst.Count = 0 Then
            Result := ''
        Else
        Begin
            Result := ', ';
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i]; // for
        End;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;

End;

//Here is the end;

Function GetComboxBoxStyleString(stdStyle: TWxCmbStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxCB_SIMPLE In stdStyle Then
            strLst.add('wxCB_SIMPLE');

        If wxCB_DROPDOWN In stdStyle Then
            strLst.add('wxCB_DROPDOWN');

        If wxCB_READONLY In stdStyle Then
            strLst.add('wxCB_READONLY');

        If wxCB_SORT In stdStyle Then
            strLst.add('wxCB_SORT');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;
End;

Function GetOwnComboxBoxStyleString(stdStyle: TWxOwnCmbStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxODCB_DCLICK_CYCLES In stdStyle Then
            strLst.add('wxODCB_DCLICK_CYCLES');

        If wxODCB_STD_CONTROL_PAINT In stdStyle Then
            strLst.add('wxODCB_STD_CONTROL_PAINT');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;
End;

Function GetDlgStyleString(stdStyle: TWxDlgStyleSet;
    wxclassname: String): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try

        If wxCAPTION In stdStyle Then
            strLst.add('wxCAPTION');

        If wxRESIZE_BORDER In stdStyle Then
            strLst.add('wxRESIZE_BORDER');

        If wxSYSTEM_MENU In stdStyle Then
            strLst.add('wxSYSTEM_MENU');

        If wxTHICK_FRAME In stdStyle Then
            strLst.add('wxTHICK_FRAME');

        If wxSTAY_ON_TOP In stdStyle Then
            strLst.add('wxSTAY_ON_TOP');

        If strEqual(wxclassname, 'wxDialog') Then
            If wxDIALOG_NO_PARENT In stdStyle Then
                strLst.add('wxDIALOG_NO_PARENT');

        If wxDIALOG_EX_CONTEXTHELP In stdStyle Then
            strLst.add('wxDIALOG_EX_CONTEXTHELP');

        If wxFRAME_EX_CONTEXTHELP In stdStyle Then
            strLst.add('wxFRAME_EX_CONTEXTHELP');

        If wxMINIMIZE_BOX In stdStyle Then
            strLst.add('wxMINIMIZE_BOX');

        If wxMAXIMIZE_BOX In stdStyle Then
            strLst.add('wxMAXIMIZE_BOX');

        If wxCLOSE_BOX In stdStyle Then
            strLst.add('wxCLOSE_BOX');

        If wxNO_3D In stdStyle Then
            strLst.add('wxNO_3D');

        If wxMINIMIZE In stdStyle Then
            strLst.add('wxMINIMIZE');

        If wxMAXIMIZE In stdStyle Then
            strLst.add('wxMAXIMIZE');

        If wxFRAME_TOOL_WINDOW In stdStyle Then
            strLst.add('wxFRAME_TOOL_WINDOW');

        If wxFRAME_NO_TASKBAR In stdStyle Then
            strLst.add('wxFRAME_NO_TASKBAR');

        If wxFRAME_FLOAT_ON_PARENT In stdStyle Then
            strLst.add('wxFRAME_FLOAT_ON_PARENT');

        If wxFRAME_SHAPED In stdStyle Then
            strLst.add('wxFRAME_SHAPED');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);

    Finally
        strLst.Destroy;
    End;

End;

Function GetAnimationCtrlStyleString(stdStyle:
    TWxAnimationCtrlStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxAC_DEFAULT_STYLE In stdStyle Then
            strLst.add('wxAC_DEFAULT_STYLE');

        If wxAC_NO_AUTORESIZE In stdStyle Then
            strLst.add('wxAC_NO_AUTORESIZE');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);

    Finally
        strLst.Destroy;
    End;
End;

Function GetButtonStyleString(stdStyle: TWxBtnStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxBU_AUTODRAW In stdStyle Then
            strLst.add('wxBU_AUTODRAW');

        If wxBU_LEFT In stdStyle Then
            strLst.add('wxBU_LEFT');

        If wxBU_TOP In stdStyle Then
            strLst.add('wxBU_TOP');

        If wxBU_RIGHT In stdStyle Then
            strLst.add('wxBU_RIGHT');

        If wxBU_EXACTFIT In stdStyle Then
            strLst.add('wxBU_EXACTFIT');

        If wxBU_BOTTOM In stdStyle Then
            strLst.add('wxBU_BOTTOM');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);

    Finally
        strLst.Destroy;
    End;
End;

Function GetLbStyleString(stdStyle: TWxLbStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try

        If wxST_ALIGN_LEFT In stdStyle Then
            strLst.add('wxALIGN_LEFT');

        If wxST_ALIGN_RIGHT In stdStyle Then
            strLst.add('wxALIGN_RIGHT');

        If wxST_ALIGN_CENTRE In stdStyle Then
            strLst.add('wxALIGN_CENTRE');

        If wxST_NO_AUTORESIZE In stdStyle Then
            strLst.add('wxST_NO_AUTORESIZE');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;

End;

Function GetRichTextStyleString(edtdStyle: TWxRichTextStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try

        If wxRE_READONLY In edtdStyle Then
            strLst.add('wxRE_READONLY');

        If wxRE_MULTILINE In edtdStyle Then
            strLst.add('wxRE_MULTILINE');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;

End;

Function GetEdtStyleString(edtdStyle: TWxEdtGeneralStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try

        If wxTE_PROCESS_ENTER In edtdStyle Then
            strLst.add('wxTE_PROCESS_ENTER');

        If wxTE_PROCESS_TAB In edtdStyle Then
            strLst.add('wxTE_PROCESS_TAB');

        If wxTE_PASSWORD In edtdStyle Then
            strLst.add('wxTE_PASSWORD');

        If wxTE_READONLY In edtdStyle Then
            strLst.add('wxTE_READONLY');

        If wxTE_RICH In edtdStyle Then
            strLst.add('wxTE_RICH');

        If wxTE_RICH2 In edtdStyle Then
            strLst.add('wxTE_RICH2');

        If wxTE_AUTO_URL In edtdStyle Then
            strLst.add('wxTE_AUTO_URL');

        If wxTE_NO_VSCROLL In edtdStyle Then
            strLst.add('wxTE_NO_VSCROLL');

        If wxTE_NOHIDESEL In edtdStyle Then
            strLst.add('wxTE_NOHIDESEL');

        If wxTE_LEFT In edtdStyle Then
            strLst.add('wxTE_LEFT');

        If wxTE_CENTRE In edtdStyle Then
            strLst.add('wxTE_CENTRE');

        If wxTE_RIGHT In edtdStyle Then
            strLst.add('wxTE_RIGHT');

        If wxTE_DONTWRAP In edtdStyle Then
            strLst.add('wxTE_DONTWRAP');

        If wxTE_BESTWRAP In edtdStyle Then
            strLst.add('wxTE_BESTWRAP');

        If wxTE_CHARWRAP In edtdStyle Then
            strLst.add('wxTE_CHARWRAP');

        If wxTE_LINEWRAP In edtdStyle Then
            strLst.add('wxTE_LINEWRAP');

        If wxTE_WORDWRAP In edtdStyle Then
            strLst.add('wxTE_WORDWRAP');

        If wxTE_CAPITALIZE In edtdStyle Then
            strLst.add('wxTE_CAPITALIZE');

        If wxTE_MULTILINE In edtdStyle Then
            strLst.add('wxTE_MULTILINE');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;
End;

Function GetTextEntryDialogStyleString(stdStyle: TWxMessageDialogStyleSet;
    edtStyle: TWxEdtGeneralStyleSet): String;
Var
    strA, strB: String;
Begin
    strA := trim(GetMessageDialogStyleString(stdStyle, True));
    strB := trim(GetEdtStyleString(edtStyle));

    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

    If strB <> '' Then
        If trim(Result) = '' Then
            Result := strB
        Else
            Result := Result + ' | ' + strB;

    If Result <> '' Then
    Begin
        Result := ',' + Result;
    End;
End;

Function GetEditSpecificStyle(stdstyle: TWxStdStyleSet;
    dlgstyle: TWxEdtGeneralStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetEdtStyleString(dlgstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetRichTextSpecificStyle(stdstyle: TWxStdStyleSet;
    dlgstyle: TWxRichTextStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetRichTextStyleString(dlgstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;
End;

Function GetcomboBoxSpecificStyle(stdstyle: TWxStdStyleSet;
    cmbstyle: TWxCmbStyleSet; edtstyle: TWxEdtGeneralStyleSet): String;
Var
    strA: String;
    strB: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetComboxBoxStyleString(cmbstyle));
    strB := trim(GetEdtStyleString(edtstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;
    If strB <> '' Then
        If trim(Result) = '' Then
            Result := strB
        Else
            Result := Result + ' | ' + strB;
End;

Function GetOwncomboBoxSpecificStyle(stdstyle: TWxStdStyleSet;
    cmbstyle: TWxCmbStyleSet; edtstyle: TWxEdtGeneralStyleSet;
    owncmbstyle: TWxOwnCmbStyleSet): String;
Var
    strA: String;
    strB: String;
    strC: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetComboxBoxStyleString(cmbstyle));
    strB := trim(GetEdtStyleString(edtstyle));
    strC := trim(GetOwnComboxBoxStyleString(Owncmbstyle));

    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

    If strB <> '' Then
        If trim(Result) = '' Then
            Result := strB
        Else
            Result := Result + ' | ' + strB;

    If strC <> '' Then
        If trim(Result) = '' Then
            Result := strC
        Else
            Result := Result + ' | ' + strC;
End;

Function GetListViewStyleString(lstvwstyle: TWxLVStyleSet;
    view: TWxLvView): String;
Var
    I: Integer;
    strLst: TStringList;
Begin
    strLst := TStringList.Create;

    Case view Of
        wxLC_LIST:
            strLst.add('wxLC_LIST');
        wxLC_REPORT:
            strLst.add('wxLC_REPORT');
        wxLC_VIRTUAL:
        Begin
            strLst.add('wxLC_VIRTUAL');
            strLst.add('wxLC_REPORT');
        End;
        wxLC_ICON:
            strLst.add('wxLC_ICON');
        wxLC_SMALL_ICON:
            strLst.add('wxLC_SMALL_ICON');
{$IFDEF PRIVATE_BUILD}
wxLC_TILE:
strLst.add('wxLC_TILE');
{$ENDIF}
    End;

    Try
        If wxLC_ALIGN_TOP In lstvwstyle Then
            strLst.add('wxLC_ALIGN_TOP');

        If wxLC_ALIGN_LEFT In lstvwstyle Then
            strLst.add('wxLC_ALIGN_LEFT');

        If wxLC_AUTOARRANGE In lstvwstyle Then
            strLst.add('wxLC_AUTOARRANGE');

        If wxLC_EDIT_LABELS In lstvwstyle Then
            strLst.add('wxLC_EDIT_LABELS');

        If wxLC_NO_HEADER In lstvwstyle Then
            strLst.add('wxLC_NO_HEADER');

        If wxLC_NO_SORT_HEADER In lstvwstyle Then
            strLst.add('wxLC_NO_SORT_HEADER');

        If wxLC_SINGLE_SEL In lstvwstyle Then
            strLst.add('wxLC_SINGLE_SEL');

        If wxLC_SORT_ASCENDING In lstvwstyle Then
            strLst.add('wxLC_SORT_ASCENDING');

        If wxLC_SORT_DESCENDING In lstvwstyle Then
            strLst.add('wxLC_SORT_DESCENDING');

        If wxLC_HRULES In lstvwstyle Then
            strLst.add('wxLC_HRULES');

        If wxLC_VRULES In lstvwstyle Then
            strLst.add('wxLC_VRULES');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i];
    Finally
        strLst.Destroy;
    End;
End;

Function GetListViewSpecificStyle(stdstyle: TWxStdStyleSet;
    lstvwstyle: TWxLVStyleSet; view: TWxLvView): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetListViewStyleString(lstvwstyle, view));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
        If strA = '' Then
            Result := Result
        Else
            Result := Result + ' | ' + strA;

    //if trim(Result) <> '' then
    //Result := ', ' + Result;
End;

//Start here

Function GetCheckboxSpecificStyle(stdstyle: TWxStdStyleSet;
    cbxstyle: TWxcbxStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetCheckBoxStyleString(cbxstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetTreeviewSpecificStyle(stdstyle: TWxStdStyleSet;
    tvstyle: TWxTVStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetTreeViewStyleString(tvstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetRadiobuttonSpecificStyle(stdstyle: TWxStdStyleSet;
    rbstyle: TWxrbStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetRadioButtonStyleString(rbstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetRTSListCtrlSpecificStyle(stdstyle: TWxStdStyleSet;
    lbxstyle: TwxRichTextSLCStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetRTSListCtrlStyleString(lbxstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetListboxSpecificStyle(stdstyle: TWxStdStyleSet;
    lbxstyle: TWxlbxStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetListBoxStyleString(lbxstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetGaugeSpecificStyle(stdstyle: TWxStdStyleSet;
    gagstyle: TWxgagStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetGaugeStyleString(gagstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetScrollbarSpecificStyle(stdstyle: TWxStdStyleSet;
    scbrstyle: TWxsbrStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetScrollbarStyleString(scbrstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetHyperLnkSpecificStyle(stdstyle: TWxStdStyleSet;
    edtstyle: TWxHyperLnkStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetHyperLnkStyleString(edtstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetSpinButtonSpecificStyle(stdstyle: TWxStdStyleSet;
    sbtnstyle: TWxsbtnStyleSet; edtstyle: TWxEdtGeneralStyleSet): String;
Var
    strA: String;
    strB: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetSpinButtonStyleString(sbtnstyle));
    strB := trim(GetEdtStyleString(edtstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;
    If strB <> '' Then
        If trim(Result) = '' Then
            Result := strB
        Else
            Result := Result + ' | ' + strB;
End;

Function GetSliderSpecificStyle(stdstyle: TWxStdStyleSet;
    sldrstyle: TWxsldrStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetSliderStyleString(sldrstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

//function GetStaticBitmapSpecificStyle(stdstyle: TWxStdStyleSet;sbtmpstyle:TWxsbtmpStyleSet):String;
//var
//  strA: string;
//begin
//  Result := GetStdStyleString(stdstyle);
//  strA := trim(GetStaticBitmapStyleString(sbtmpstyle));
//  if strA <> '' then
//  begin
//    if trim(Result) = '' then
//      Result := strA
//    else
//      Result := Result + ' | ' + strA
//  end;

//  if trim(Result) <> '' then
//    Result := ', ' + Result;
//end;

Function GetDateVariableExpansion(value: TDateTime): String;
Var
    Year, Month, Day: Word;
Begin
    DecodeDate(value, Year, Month, Day);
    Result := Format('wxDateTime(%d,(wxDateTime::Month)%d,%d)',
        [Day, Month, Year]);
End;

Function GetCalendarCtrlSpecificStyle(stdstyle: TWxStdStyleSet;
    calctrlstyle: TWxcalctrlStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetCalendarCtrlStyleString(calctrlstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetPickCalSpecificStyle(stdstyle: TWxStdStyleSet;
    calctrlstyle: TWxPickCalStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetPickCalStyleString(calctrlstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

//function GetChoiceSpecificStyle(stdstyle: TWxStdStyleSet;chstyle:TWxchStyleSet):String;
//var
//  strA: string;
//begin
//  Result := GetStdStyleString(stdstyle);
//  strA := trim(GetChoiceStyleString(chstyle));
//  if strA <> '' then
//  begin
//    if trim(Result) = '' then
//      Result := strA
//    else
//      Result := Result + ' | ' + strA
//  end;

//  if trim(Result) <> '' then
//    Result := ', ' + Result;
//end;

Function GetChoicebookSpecificStyle(stdstyle:
    TWxStdStyleSet{;
  bookalign: TWxchbxAlignStyleItem;
  cbbxstyle: TWxchbxStyleSet}): String;
    //var
    //  strA: string;
Begin
    Result := GetStdStyleString(stdstyle);

    //  Result := Result + ' | ' +  GetChoiceAlignmentString(bookalign);
    {
  strA := trim(GetChoicebookStyleString(cbbxstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;
}
End;

Function GetChoiceAlignmentString(Value: TWxchbxAlignStyleItem): String;
Begin
    Result := '';
    If Value = wxCHB_BOTTOM Then
    Begin
        Result := 'wxCHB_BOTTOM';
        exit;
    End;
    If Value = wxCHB_RIGHT Then
    Begin
        Result := 'wxCHB_RIGHT';
        exit;
    End;
    If Value = wxCHB_LEFT Then
    Begin
        Result := 'wxCHB_LEFT';
        exit;
    End;
    If Value = wxCHB_TOP Then
    Begin
        Result := 'wxCHB_TOP';
        exit;
    End;
    If Value = wxCHB_DEFAULT Then
    Begin
        Result := 'wxCHB_DEFAULT';
        exit;
    End;

End;

{function GetListbookSpecificStyle(stdstyle: TWxStdStyleSet; lbbxstyle: TWxlbbxStyleSet): string;
}
Function GetListbookSpecificStyle(stdstyle:
    TWxStdStyleSet{; bookalign: TWxlbbxAlignStyleItem}): String;
    //var
    //  strA: string;
Begin
    Result := GetStdStyleString(stdstyle);

    //  Result := Result + ' | ' +  GetListAlignment(bookalign);

    {
  strA := trim(GetListbookStyleString(lbbxstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;
}
End;

Function GetListAlignment(Value: TWxlbbxAlignStyleItem): String;
Begin
    Result := '';
    If Value = wxLB_BOTTOM Then
    Begin
        Result := 'wxLB_BOTTOM';
        exit;
    End;
    If Value = wxLB_RIGHT Then
    Begin
        Result := 'wxLB_RIGHT';
        exit;
    End;
    If Value = wxLB_LEFT Then
    Begin
        Result := 'wxLB_LEFT';
        exit;
    End;
    If Value = wxLB_TOP Then
    Begin
        Result := 'wxLB_TOP';
        exit;
    End;
    If Value = wxLB_DEFAULT Then
    Begin
        Result := 'wxLB_DEFAULT';
        exit;
    End;

End;

Function GetNotebookSpecificStyle(stdstyle: TWxStdStyleSet;
    { bookalign: TWxnbxAlignStyleItem; }
    nbxstyle: TWxnbxStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);

    {  if Result <> '' then
    Result := GetTabAlignment(bookalign) + ' | ' +  Result
  else
     Result := GetTabAlignment(bookalign);      }

    strA := trim(GetNotebookStyleString(nbxstyle));

    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetAuiNotebookSpecificStyle(stdstyle: TWxStdStyleSet;
    { bookalign: TWxnbxAlignStyleItem; }
    nbxstyle: TWxAuinbxStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);

    {  if Result <> '' then
      Result := GetTabAlignment(bookalign) + ' | ' +  Result
    else
       Result := GetTabAlignment(bookalign);      }

    strA := trim(GetAuiNotebookStyleString(nbxstyle));

    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetTabAlignmentString(Value: TWxnbxAlignStyleItem): String;
Begin
    {
  //Multiline MUST be set when using left or right placed tabs
  If (wxNB_RIGHT in FWx_NotebookStyle) or (wxNB_LEFT in FWx_NotebookStyle) then
    self.MultiLine := True
  else
  self.MultiLine := wxNB_MULTILINE in FWx_NotebookStyle;

  If (wxNB_FIXEDWIDTH in FWx_NotebookStyle) then
    self.TabWidth := self.Wx_TabWidth
  else
    self.TabWidth := 0;

  //mn we need to set the tab position here, we go backwards from bottom, right, left to top
  //mn wxNB_DEFAULT and wxNB_TOP are assumed to be the same
  If (wxNB_BOTTOM in FWx_NotebookStyle) then
    Self.TabPosition :=  tpBottom;

  If (wxNB_RIGHT in FWx_NotebookStyle) then
    Self.TabPosition := tpRight;

  If (wxNB_LEFT in FWx_NotebookStyle) then
    Self.TabPosition := tpLeft;

  If (wxNB_TOP in FWx_NotebookStyle) or (wxNB_DEFAULT in FWx_NotebookStyle) then
    Self.TabPosition := tpTop;

}
    Result := '';
    If Value = wxNB_BOTTOM Then
    Begin
        Result := 'wxNB_BOTTOM';
        //    Self.TabPosition :=  tpBottom;
        exit;
    End;
    If Value = wxNB_RIGHT Then
    Begin
        Result := 'wxNB_RIGHT';
        //    self.Multiline := True;
        //    Self.TabPosition :=  tpRight;
        exit;
    End;
    If Value = wxNB_LEFT Then
    Begin
        Result := 'wxNB_LEFT';
        //    self.Multiline := True;
        //    Self.TabPosition := tpLeft;
        exit;
    End;
    If Value = wxNB_TOP Then
    Begin
        Result := 'wxNB_TOP';
        //    Self.TabPosition := tpTop;
        exit;
    End;
    If Value = wxNB_DEFAULT Then
    Begin
        Result := 'wxNB_DEFAULT';
        //    Self.TabPosition := tpTop;
        exit;
    End;

End;


Function GetToolbookSpecificStyle(stdstyle:
    TWxStdStyleSet{; tlbxstyle: TWxtlbxStyleSet}): String;
    //var
    //  strA: string;
Begin
    Result := GetStdStyleString(stdstyle);

    //  Result := GetToolAlignment(bookalign) + ' | ' +  Result;


    {
  strA := trim(GetToolbookStyleString(tlbxstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;
}

End;

Function GetTreebookSpecificStyle(stdstyle:
    TWxStdStyleSet{; bookalign: TWxtrbxAlignStyleItem}): String;
    //var
    //  strA: string;
Begin
    Result := GetStdStyleString(stdstyle);

    //  Result := GetTreeAlignment(bookalign) + ' | ' +  Result;

    {
  strA := trim(GetTreebookStyleString(trbxstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;
}
End;

Function GetTreeAlignment(Value: TWxtrbxAlignStyleItem): String;
Begin
    Result := '';
    If Value = wxBK_BOTTOM Then
    Begin
        Result := 'wxBK_BOTTOM';
        exit;
    End;
    If Value = wxBK_RIGHT Then
    Begin
        Result := 'wxBK_RIGHT';
        exit;
    End;
    If Value = wxBK_LEFT Then
    Begin
        Result := 'wxBK_LEFT';
        exit;
    End;
    If Value = wxBK_TOP Then
    Begin
        Result := 'wxBK_TOP';
        exit;
    End;
    If Value = wxBK_DEFAULT Then
    Begin
        Result := 'wxBK_DEFAULT';
        exit;
    End;

End;

Function GetRadioBoxSpecificStyle(stdstyle: TWxStdStyleSet;
    rbxstyle: TWxrbxStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetRadioBoxStyleString(rbxstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetStatusBarSpecificStyle(stdstyle: TWxStdStyleSet;
    sbrstyle: TWxsbrStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetStatusBarStyleString(sbrstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

//function GetToggleButtonSpecificStyle(stdstyle: TWxStdStyleSet;tbtnstyle:TWxtbtnStyleSet):String;
//var
//  strA: string;
//begin
//  Result := GetStdStyleString(stdstyle);
//  strA := trim(GetToggleButtonStyleString(tbtnstyle));
//  if strA <> '' then
//  begin
//    if trim(Result) = '' then
//      Result := strA
//    else
//      Result := Result + ' | ' + strA
//  end;

//  if trim(Result) <> '' then
//    Result := ', ' + Result;
//end;

Function GetScrolledWindowSpecificStyle(stdstyle: TWxStdStyleSet;
    scrWinStyle: TWxScrWinStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetScrolledWindowStyleString(scrWinStyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetHtmlWindowSpecificStyle(stdstyle: TWxStdStyleSet;
    htmlWinStyle: TWxHtmlWinStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetHtmlWindowStyleString(htmlWinStyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetSplitterWindowSpecificStyle(stdstyle: TWxStdStyleSet;
    SplitterWinStyle: TWxSplitterWinStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetSplitterWindowStyleString(SplitterWinStyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetToolBarSpecificStyle(stdstyle: TWxStdStyleSet;
    tbrstyle: TWxtbrStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetToolBarStyleString(tbrstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetAuiToolBarSpecificStyle(stdstyle: TWxStdStyleSet;
    tbrstyle: TWxAuiTbrStyleSet): String;
    //var
    //  strA: string;
Begin
    Result := GetStdStyleString(stdstyle);
    {mn
    strA := trim(GetToolBarStyleString(tbrstyle));
    if strA <> '' then
      if trim(Result) = '' then
        Result := strA
      else
        Result := Result + ' | ' + strA;
  }
End;

//End here

Function RGBFormatStrToColor(strColorValue: String): TColor;
Var
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try

        strTokenToStrings(strColorValue, ',', strLst);
        If strLst.Count > 2 Then
            Result := RGB(StrToInt(strLst[0]), StrToInt(strLst[1]),
                StrToInt(strLst[2]))
        Else
            Result := RGB(0, 0, 0);

    Finally
        strLst.Destroy;
    End;
End;

Function GetColorFromString(strColorValue: String): TColor;
Var
    strChoice, strCmd: String;
Begin
    strChoice := copy(strColorValue, 5, length(strColorValue));
    strCmd := copy(strColorValue, 0, 4);
    If AnsiSameText(strCmd, 'CUS:') Then
    Begin
        Result := RGBFormatStrToColor(strChoice);
        exit;
    End;
    Result := GetGeneralColorFromString(strChoice);
End;

Procedure PopulateGenericProperties(Var PropertyList: TStringList);
Begin
    PropertyList.Add('Wx_Enabled:' + wx_designer.GetLangString(ID_WX_ENABLED));
    PropertyList.Add('Wx_Class:' + wx_designer.GetLangString(ID_WX_BASECLASS));
    PropertyList.Add('Wx_Hidden:' + wx_designer.GetLangString(ID_WX_HIDDEN));
    PropertyList.Add('Wx_Default:' + wx_designer.GetLangString(ID_WX_DEFAULT));
    PropertyList.Add('Wx_HelpText:' + wx_designer.GetLangString(ID_WX_HELPTEXT));
    PropertyList.Add('Wx_IDName:' + wx_designer.GetLangString(ID_WX_IDNAME));
    PropertyList.Add('Wx_IDValue:' + wx_designer.GetLangString(ID_WX_IDVALUE));
    PropertyList.Add('Wx_ToolTip:' + wx_designer.GetLangString(ID_WX_TOOLTIP));
    PropertyList.Add('Wx_Comments:' + wx_designer.GetLangString(ID_WX_COMMENTS));
    PropertyList.Add('Wx_ProxyValidatorString:'
        + wx_designer.GetLangString(ID_WX_VALIDATORCODE));
    PropertyList.Add('Wx_ProxyBGColorString:'
        + wx_designer.GetLangString(ID_WX_BACKGROUNDCOLOR));
    PropertyList.Add('Wx_ProxyFGColorString:'
        + wx_designer.GetLangString(ID_WX_FOREGROUNDCOLOR));

    PropertyList.Add('Wx_StretchFactor:'
        + wx_designer.GetLangString(ID_WX_STRETCHFACTOR));
    PropertyList.Add('Wx_Alignment:' + wx_designer.GetLangString(
        ID_WX_ALIGNMENT));
    PropertyList.Add('wxALIGN_LEFT:wxALIGN_LEFT');
    PropertyList.Add('wxALIGN_RIGHT:wxALIGN_RIGHT');
    PropertyList.Add('wxALIGN_TOP:wxALIGN_TOP');
    PropertyList.Add('wxALIGN_BOTTOM:wxALIGN_BOTTOM');
    PropertyList.Add('wxALIGN_CENTER:wxALIGN_CENTER');
    PropertyList.Add('wxALIGN_CENTER_HORIZONTAL:wxALIGN_CENTER_HORIZONTAL');
    PropertyList.Add('wxALIGN_CENTER_VERTICAL:wxALIGN_CENTER_VERTICAL');
    PropertyList.Add('wxEXPAND:wxEXPAND');

    PropertyList.Add('Wx_Border:' + wx_designer.GetLangString(ID_WX_BORDER));
    PropertyList.Add('Wx_BorderAlignment:'
        + wx_designer.GetLangString(ID_WX_BORDERS));
    PropertyList.Add('wxALL:wxALL');
    PropertyList.Add('wxTOP:wxTOP');
    PropertyList.Add('wxLEFT:wxLEFT');
    PropertyList.Add('wxRIGHT:wxRIGHT');
    PropertyList.Add('wxBOTTOM:wxBOTTOM');

    PropertyList.Add('Wx_GeneralStyle:'
        + wx_designer.GetLangString(ID_WX_GENERALSTYLES));
    //PropertyList.Add('wxNO_3D:wxNO_3D'); // EAB: this ain't consistant with the set declaration above of TWxStdStyleItem or wxWidgets documentation.
    PropertyList.Add('wxALWAYS_SHOW_SB:wxALWAYS_SHOW_SB');
    PropertyList.Add('wxNO_BORDER:wxNO_BORDER');
    PropertyList.Add('wxWANTS_CHARS:wxWANTS_CHARS');
    PropertyList.Add('wxCLIP_CHILDREN:wxCLIP_CHILDREN');
    PropertyList.Add('wxSIMPLE_BORDER:wxSIMPLE_BORDER');
    PropertyList.Add('wxDOUBLE_BORDER:wxDOUBLE_BORDER');
    PropertyList.Add('wxSUNKEN_BORDER:wxSUNKEN_BORDER');
    PropertyList.Add('wxRAISED_BORDER:wxRAISED_BORDER');
    PropertyList.Add('wxSTATIC_BORDER:wxSTATIC_BORDER');
    PropertyList.Add('wxTAB_TRAVERSAL:wxTAB_TRAVERSAL');
    PropertyList.Add('wxTRANSPARENT_WINDOW:wxTRANSPARENT_WINDOW');
    PropertyList.Add('wxNO_FULL_REPAINT_ON_RESIZE:wxNO_FULL_REPAINT_ON_RESIZE');
    PropertyList.Add('wxVSCROLL:wxVSCROLL');
    PropertyList.Add('wxHSCROLL:wxHSCROLL');

    PropertyList.Add('Font:' + wx_designer.GetLangString(ID_WX_FONT));
    PropertyList.Add('Name:' + wx_designer.GetLangString(ID_WX_NAME));
    PropertyList.Add('Width:' + wx_designer.GetLangString(ID_WX_WIDTH));
    PropertyList.Add('Height:' + wx_designer.GetLangString(ID_WX_HEIGHT));
    PropertyList.Add('Left:' + wx_designer.GetLangString(ID_WX_LEFT));
    PropertyList.Add('Top:' + wx_designer.GetLangString(ID_WX_TOP));
End;

Function SizerAlignmentToStr(SizerAlignment: TWxSizerAlignmentSet): String;
Var
    Styles: TStringList;
    I: Integer;
Begin
    Styles := TStringList.Create;
    If wxALIGN_LEFT In SizerAlignment Then
        Styles.Add('wxALIGN_LEFT');

    If wxALIGN_RIGHT In SizerAlignment Then
        Styles.Add('wxALIGN_RIGHT');

    If wxALIGN_TOP In SizerAlignment Then
        Styles.Add('wxALIGN_TOP');

    If wxALIGN_BOTTOM In SizerAlignment Then
        Styles.Add('wxALIGN_BOTTOM');

    If wxALIGN_CENTER In SizerAlignment Then
        Styles.Add('wxALIGN_CENTER');

    If wxALIGN_CENTER_HORIZONTAL In SizerAlignment Then
        Styles.Add('wxALIGN_CENTER_HORIZONTAL');

    If wxALIGN_CENTER_VERTICAL In SizerAlignment Then
        Styles.Add('wxALIGN_CENTER_VERTICAL');

    If wxEXPAND In SizerAlignment Then
        Styles.Add('wxEXPAND');

    If Styles.Count = 0 Then
        Result := '0'
    Else
    Begin
        Result := Styles[0];
        For I := 1 To Styles.Count - 1 Do
            Result := Result + ' | ' + Styles[I];
    End;

    Styles.Free;
End;

Function BorderAlignmentToStr(BorderAlignment: TWxBorderAlignment): String;
Begin
    Result := '';
    If (wxALL In BorderAlignment) Then
        Result := Result + ' | wxALL';
    If (wxLEFT In BorderAlignment) Then
        Result := Result + ' | wxLEFT';
    If (wxRIGHT In BorderAlignment) Then
        Result := Result + ' | wxRIGHT';
    If (wxTOP In BorderAlignment) Then
        Result := Result + ' | wxTOP';
    If (wxBOTTOM In BorderAlignment) Then
        Result := Result + ' | wxBOTTOM';

    If (Length(Result) = 0) Then
        Result := '0'
    Else
        Result := Copy(Result, 4, Length(Result));
End;

Function GetStdStyleString(stdStyle: TWxStdStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try

        If wxSIMPLE_BORDER In stdStyle Then
            strLst.add('wxSIMPLE_BORDER');

        If wxDOUBLE_BORDER In stdStyle Then
            strLst.add('wxDOUBLE_BORDER');

        If wxSUNKEN_BORDER In stdStyle Then
            strLst.add('wxSUNKEN_BORDER');

        If wxRAISED_BORDER In stdStyle Then
            strLst.add('wxRAISED_BORDER');

        If wxSTATIC_BORDER In stdStyle Then
            strLst.add('wxSTATIC_BORDER');

        If wxTRANSPARENT_WINDOW In stdStyle Then
            strLst.add('wxTRANSPARENT_WINDOW');

        If wxTAB_TRAVERSAL In stdStyle Then
            strLst.add('wxTAB_TRAVERSAL');

        If wxWANTS_CHARS In stdStyle Then
            strLst.add('wxWANTS_CHARS');

        If wxNO_FULL_REPAINT_ON_RESIZE In stdStyle Then
            strLst.add('wxNO_FULL_REPAINT_ON_RESIZE');

        If wxVSCROLL In stdStyle Then
            strLst.add('wxVSCROLL');

        If wxHSCROLL In stdStyle Then
            strLst.add('wxHSCROLL');

        If wxCLIP_CHILDREN In stdStyle Then
            strLst.add('wxCLIP_CHILDREN');

        If wxNO_BORDER In stdStyle Then
            strLst.add('wxNO_BORDER');

        If wxALWAYS_SHOW_SB In stdStyle Then
            strLst.add('wxALWAYS_SHOW_SB');

        If wxFULL_REPAINT_ON_RESIZE In stdStyle Then
            strLst.add('wxFULL_REPAINT_ON_RESIZE');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
        //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;
End;

Function GetAnimationCtrlSpecificStyle(stdstyle:
    TWxStdStyleSet{;
  dlgstyle: TWxAnimationCtrlStyleSet}): String;
    //var
    //  strA: string;
Begin
    Result := GetStdStyleString(stdstyle);
    {  strA := trim(GetAnimationCtrlStyleString(dlgstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;  }//mn all we want at the moment is the standard style string

End;

Function GetButtonSpecificStyle(stdstyle: TWxStdStyleSet;
    dlgstyle: TWxBtnStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetButtonStyleString(dlgstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetLabelSpecificStyle(stdstyle: TWxStdStyleSet;
    dlgstyle: TWxLbStyleSet): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetLbStyleString(dlgstyle));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;

End;

Function GetStdDialogButtonsSpecificStyle(btnstyle:
    TWxStdDialogButtons): String;
Begin
    If wxID_OK In btnstyle Then
        Result := Result + ' | wxOK'
    Else
    Begin
        If wxID_YES In btnstyle Then
            Result := Result + ' | wxYES'
        Else
        If wxID_SAVE In btnstyle Then
            Result := Result + ' | wxSAVE';
    End;
    If wxID_NO In btnstyle Then
        Result := Result + ' | wxNO';
    If wxID_CANCEL In btnstyle Then
        Result := Result + ' | wxCANCEL';
    If wxID_APPLY In btnstyle Then
        Result := Result + ' | wxAPPLY';

    If wxID_HELP In btnstyle Then
        Result := Result + ' | wxHELP'
    Else
    If wxID_CONTEXT_HELP In btnstyle Then
        Result := Result + ' | wxCONTEXTHELP';

    If Result <> '' Then
        Result := Copy(Result, 4, Length(Result))
    Else
        Result := '0';
End;

Function GetDialogSpecificStyle(stdstyle: TWxStdStyleSet;
    dlgstyle: TWxDlgStyleSet; wxclassname: String): String;
Var
    strA: String;
Begin
    Result := GetStdStyleString(stdstyle);
    strA := trim(GetDlgStyleString(dlgstyle, wxclassname));
    If strA <> '' Then
        If trim(Result) = '' Then
            Result := strA
        Else
            Result := Result + ' | ' + strA;
End;

Function IsControlWxWindow(ctrl: TControl): Boolean;
Var
    cntIntf: IWxWindowInterface;
Begin
    Result := False;
    If Not assigned(ctrl) Then
        Exit;
    Result := ctrl.GetInterface(IID_IWxWindowInterface, cntIntf);
End;

Function IsControlWxSizer(ctrl: TControl): Boolean;
Var
    cntIntf: IWxContainerAndSizerInterface;
Begin
    Result := False;
    If Not assigned(ctrl) Then
        Exit;
    Result := ctrl.GetInterface(IID_IWxContainerAndSizerInterface, cntIntf);
End;

Function IsControlWxContainer(ctrl: TControl): Boolean;
Var
    cntIntf: IWxContainerInterface;
Begin
    Result := False;
    If Not assigned(ctrl) Then
        Exit;
    Result := ctrl.GetInterface(IDD_IWxContainerInterface, cntIntf);
End;

Function IsControlWxToolBar(ctrl: TControl): Boolean;
Var
    cntIntf: IWxToolBarInterface;
Begin
    Result := False;
    If Not assigned(ctrl) Then
        Exit;
    Result := ctrl.GetInterface(IID_IWxToolBarInterface, cntIntf);
End;

Function IsControlWxStatusBar(ctrl: TControl): Boolean;
Var
    cntIntf: IWxStatusBarInterface;
Begin
    Result := False;
    If Not assigned(ctrl) Then
        Exit;
    Result := ctrl.GetInterface(IDD_IWxStatusBarInterface, cntIntf);
End;

Function IsControlWxNonVisible(ctrl: TControl): Boolean;
Begin
    Result := ctrl Is TWxNonVisibleBaseComponent;
End;

Function IsControlWxAuiManager(ctrl: TControl): Boolean;
Var
    cntIntf: IWxAuiManagerInterface;
Begin
    Result := False;
    If Not assigned(ctrl) Then
        Exit;
    Result := ctrl.GetInterface(IID_IWxAuiManagerInterface, cntIntf);
End;

Function IsControlWxAuiToolBar(ctrl: TControl): Boolean;
Var
    cntIntf: IWxAuiToolBarInterface;
Begin
    Result := False;
    If Not assigned(ctrl) Then
        Exit;
    Result := ctrl.GetInterface(IID_IWxAuiToolBarInterface, cntIntf);
End;

Function GetWxIDString(strID: String; intID: Longint): String;
Begin
    If intID > 0 Then
    Begin
        If trim(strID) = '' Then
            Result := '-1'
        Else
            Result := strID;
    End
    Else
        Result := '-1';

End;

Function GetNonVisualComponentCount(frmMainObj: TForm): Integer;
Var
    I: Integer;
Begin
    Result := 0;
    For I := 0 To frmMainObj.ComponentCount - 1 Do // Iterate
        If frmMainObj.Components[i] Is TWxNonVisibleBaseComponent Then
            Inc(Result); // for
End;

Function AlignmentToStr(taPos: TAlignment): String;
Begin
    Result := '';
    Case taPos Of
        taLeftJustify:
            Result := 'wxLIST_FORMAT_LEFT';
        taRightJustify:
            Result := 'wxLIST_FORMAT_RIGHT';
        taCenter:
            Result := 'wxLIST_FORMAT_CENTER';
    End; // case
End;

Procedure ChangeControlZOrder(Sender: TObject; MoveUp: Boolean = True);
Var
    I, Curr: Integer;
    Control: TControl;
    List: TList;
    NotebookPage: TTabSheet;
    Notebook: TPageControl;
   // ToolbarParent: TToolBar;
Begin

    If Sender Is TControl Then
        If (GetTypeData(Sender.ClassInfo)^.ClassType.ClassName =
            'TWxNoteBookPage') Or (GetTypeData(Sender.ClassInfo)^.ClassType.ClassName =
            'TWxAuiNoteBookPage') Then
        Begin
            NotebookPage := Sender As TTabSheet;
            Notebook := NotebookPage.PageControl;
            Curr := -1;

            //Determine the order of the notebook page
            For I := 0 To Pred(Notebook.PageCount) Do
                If Notebook.Pages[I] = Sender Then
                Begin
                    Curr := I;
                    Break;
                End;

            //Make sure our position is valid
            If Curr < 0 Then
                Exit
            Else
            If (Curr = 0) And (MoveUp <> True) Then
                Exit
            Else
            If (Curr = Notebook.PageCount - 1) And (MoveUp = True) Then
                Exit;

            //Do the move
            If (MoveUp = True) Then
                NotebookPage.PageIndex := NotebookPage.PageIndex + 1
            Else
                NotebookPage.PageIndex := NotebookPage.PageIndex - 1;

            List := TList.Create;
            Try
                If MoveUp Then
                Begin
                    For I := Curr + 1 To Pred(Notebook.PageCount) Do
                        // load other controls in group
                        List.Add(Notebook.Pages[I]);
                    NotebookPage.BringToFront;
                    For I := 0 To Pred(List.Count) Do
                        // move other controls to front, too
                        TTabSheet(List[I]).BringToFront;
                End
                Else
                Begin
                    For I := 0 To Curr - 1 Do
                        // load other controls in group
                        List.Add(Notebook.Pages[I]);
                    NotebookPage.SendToBack;
                    For I := Pred(List.Count) Downto 0 Do
                        // move other controls to back, too
                        TTabSheet(List[I]).SendToBack;
                End;
            Finally
                List.Free;
            End;
        End
        Else
        If Sender Is TControl Then
        Begin
            // only components of type TControl and descendends
            // work
            Control := Sender As TControl;
            // has no parent, cannot move ;-)
            If Control.Parent = Nil Then
                // quit
                Exit;
            // determine position in z-order
            Curr := -1;
            For I := 0 To Pred(Control.Parent.ControlCount) Do
                If Control.Parent.Controls[I] = Sender Then
                Begin
                    Curr := I;
                    Break;
                End;
            If Curr < 0 Then
                // position not found, quit
                Exit;


            List := TList.Create;
            Try
                If MoveUp Then
                Begin
                    For I := Curr + 2 To Pred(Control.Parent.ControlCount) Do
                        // load other controls in group
                        List.Add(Control.Parent.Controls[I]);
                    Control.BringToFront;

                    For I := 0 To Pred(List.Count) Do
                        // move other controls to front, too
                        TControl(List[I]).BringToFront;
                End
                Else
                Begin
                    For I := 0 To Curr - 2 Do
                        // load other controls in group
                        List.Add(Control.Parent.Controls[I]);
                    Control.SendToBack;
                    For I := Pred(List.Count) Downto 0 Do
                        // move other controls to back, too
                        TControl(List[I]).SendToBack;
                End;
            Finally
                List.Free;
            End;

        End;
End;

Function GetXPMFromTPicture(XPMName: String; delphiBitmap: TBitmap): String;
Var
    I: Integer;
    iWidth: Integer;
    iHeight: Integer;
    xpos, ypos, palindex, cindex, cpp: Integer;
    cp: Pchar;
    pixc: Integer;
    outline: Array[0..800] Of Char;
    usechrs: Array[0..64] Of Char;
    rval: Real;
    ccol, tcol: TColor;
    lcol: ^TColor;
    image: ^Integer;
    cpos: ^Integer;
    pal: TList;
    found: Boolean;
    strlst: TStringList;
    strLine: String;
Label
    Finish1;

    Function pow(base: Integer; index: Integer): Integer;
    Var
        retval: Integer;
        ittr: Integer;
    Begin
        retval := 1;
        For ittr := 1 To index Do
            retval := retval * base;
        pow := retval;
    End;

Begin

    cindex := 0;

    Result := '';
    Begin
        //   Form1.Enabled:=False;
        //   Form2.Gauge1.Progress:=0;
        //   Form2.Show;
        StrPCopy(usechrs,
            ' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ&#');
        pal := TList.Create; { Create TList to form our palette }
        //  delphiBitmap.Transparent := True;
        iWidth := delphiBitmap.Width;
        iHeight := delphiBitmap.Height;
        //   if iWidth > 180 then
        //     iWidth := 180;
        //   if iHeight > 180 then
        //     iHeight := 180;
        GetMem(image, SizeOf(Integer) * iWidth * iHeight);
        { Allocate space for image }
        { Note: Maximum of 65,528 bytes - 2 bytes per pixel }
        cpos := @image^; { This will be a pointer to current position in image }
        For ypos := 0 To iHeight - 1 Do
            For xpos := 0 To iWidth - 1 Do
            Begin
                ccol := delphiBitmap.Canvas.Pixels[xpos, ypos];
                found := False;
                For palindex := 0 To pal.Count - 1 Do
                Begin { Search palette for color }
                    tcol := TColor(pal.Items[palindex]^);
                    If tcol = ccol Then
                    Begin { Found it! }
                        found := True;
                        cindex := palindex; { Remember it's position in palette }
                        break;
                    End;
                End;
                If Not found Then
                Begin { Add new color to our palette }
                    New(lcol);
                    lcol^ := ccol;
                    pal.Add(lcol);
                    cindex := pal.Count - 1;
                End;
                cpos^ := cindex; { Store palette index for this pixel }
                Inc(cpos); { Move on to next pixel }
            End //      Form2.Gauge1.Progress:=((ypos+1)*100) div iHeight;
        //      Application.ProcessMessages;
        //      If Form2.Cancelled then goto Finish1;     { We have been cancelled! }
        ;

        //AssignFile(F,SaveDialog1.Filename);
        //Rewrite(F);
        rval := ln(pal.Count) / ln(64);
        cpp := trunc(rval);
        If (cpp <> rval) Then
            Inc(cpp);
        //Writeln(F,'/* XPM */');
        Result := Result + '/* XPM */' + #13;
        StrFmt(outline, 'static const char *%s', [XPMName]);
        strLine := outline;
        cp := StrScan(outline, '.');
        If cp <> Nil Then
            cp[0] := #0;
        StrCat(outline, '_XPM[]={');
        strLine := outline;
        //Writeln(F,outline);
        Result := Result + outline + #13;
        Result := Result + '/* ' + XPMName + ' */' + #13;
        StrFmt(outline, '"%d %d %d %d",', [iWidth, iHeight, pal.Count, cpp]);
        strLine := outline;
        //Writeln(F,outline);
        strLine := outline;
        Result := Result + outline + #13;
        For palindex := 0 To pal.Count - 1 Do
        Begin
            ccol := TColor(pal.Items[palindex]^);
            ccol := ccol Mod (256 * 256 * 256);
            If palindex = 0 Then
                StrFmt(outline, '"      c None",', [''])
            Else
                StrFmt(outline, '"      c #%s%s%s",', [IntToHex(ccol Mod 256, 2),
                    IntToHex((ccol Div 256) Mod 256, 2),
                    IntToHex(ccol Div (256 * 256), 2)]);

            strLine := outline;
            cindex := palindex;
            For pixc := 1 To cpp Do
            Begin
                outline[pixc] := usechrs[cindex Div pow(64, cpp - pixc)];
                cindex := cindex Mod pow(64, cpp - pixc);
                strLine := outline;
            End;
            strLine := outline;
            //      if AnsiStartsText('"      c #',strLine) then
            //      begin
            //        strLine:='"      c #FFFFFF",';
            //        Result:=Result+strLine+#13;
            //      end
            //      else
            Begin
                Result := Result + outline + #13;
            End;
        End;
        cpos := @image^;
        For ypos := 0 To iHeight - 1 Do
        Begin
            StrPCopy(outline, '"');
            For xpos := 0 To iWidth - 1 Do
            Begin
                cindex := cpos^;
                For pixc := 1 To cpp Do
                Begin
                    outline[xpos * cpp + pixc] :=
                        usechrs[cindex Div pow(64, cpp - pixc)];
                    cindex := cindex Mod pow(64, cpp - pixc);
                End;
                Inc(cpos);
            End;
            outline[cpp * (iWidth) + 1] := #0; // xpos is undefined after loop
            //outline[cpp * (xpos + 1) + 1] := #0; // xpos is undefined after loop
            If ypos < iHeight - 1 Then
                StrCat(outline, '",')
            Else
                StrCat(outline, '"};');
            //Writeln(F,outline);
            Result := Result + outline + #13;
        End;
        //Finish2:
        //CloseFile(F);

        Finish1:
            FreeMem(image, SizeOf(Integer) * iWidth * iHeight);
        For palindex := (pal.Count - 1) downto 0 Do
        Begin
            Dispose(pal.Items[palindex]);
            pal.Delete(palIndex);
        End;
        pal.Clear;
        pal.Free;
        //   Form2.Hide;
        //   Form1.Enabled:=True;
        strlst := TStringList.Create;
        strlst.Text := Result;
        For I := 0 To strlst.Count - 1 Do // Iterate
        Begin
            strLine := trim(strlst[i]);
            //sendDebug(IntToStr(i)+' Old # = '+IntToStr(Length(strlst[i])));

            If AnsiEndsText('","",', strLine) Then
            Begin
                //not tested
                strLine := copy(strLine, 0, length(strLine) - 5);
                If Not AnsiEndsText('",', strLine) Then
                    strlst[i] := strLine + '",';
            End;

            strLine := trim(strlst[i]);

            If AnsiEndsText('"",', strLine) Then
            Begin
                //tested
                strLine := copy(strLine, 0, length(strLine) - 3);
                If Not AnsiEndsText('",', strLine) Then
                    strlst[i] := strLine + '",';
            End;

            strLine := trim(strlst[i]);
            If AnsiEndsText('",",', strLine) Then
            Begin
                //tested
                strLine := copy(strLine, 0, length(strLine) - 4);
                If Not AnsiEndsText('",', strLine) Then
                    strlst[i] := strLine + '",';
            End;

            strLine := trim(strlst[i]);

            If AnsiEndsText('",""};', strLine) Then
            Begin
                strLine := copy(strLine, 0, length(strLine) - 6);
                If Not AnsiEndsText('"};', strLine) Then
                    strlst[i] := strLine + '"};';
            End;

            strLine := trim(strlst[i]);
            If AnsiEndsText('""};', strLine) Then
            Begin
                //not test
                strLine := copy(strLine, 0, length(strLine) - 4);
                If Not AnsiEndsText('"};', strLine) Then
                    strlst[i] := strLine + '"};';
            End;

            strLine := trim(strlst[i]);
            If AnsiEndsText('","};', strLine) Then
            Begin
                //not test
                strLine := copy(strLine, 0, length(strLine) - 5);
                If Not AnsiEndsText('"};', strLine) Then
                    strlst[i] := strLine + '"};';
            End;

            //sendDebug(IntToStr(i)+' New # = '+IntToStr(Length(strlst[i])));

        End; // for

        Result := strlst.Text;

        strlst.Destroy;
    End;
End;

Function GetRawXPMFromTPicture(XPMName: String; delphiBitmap: TBitmap): String;
Var
    iWidth: Integer;
    iHeight: Integer;
    xpos, ypos, palindex, cindex, cpp: Integer;
    cp: Pchar;
    pixc: Integer;
    outline: Array[0..800] Of Char;
    usechrs: Array[0..64] Of Char;
    rval: Real;
    ccol, tcol: TColor;
    lcol: ^TColor;
    image: ^Integer;
    cpos: ^Integer;
    pal: TList;
    found: Boolean;
    strLine: String;
Label
    Finish1;

    Function pow(base: Integer; index: Integer): Integer;
    Var
        retval: Integer;
        ittr: Integer;
    Begin
        retval := 1;
        For ittr := 1 To index Do
            retval := retval * base;
        pow := retval;
    End;

Begin

    cindex := 0;

    Result := '';
    Begin
        //   Form1.Enabled:=False;
        //   Form2.Gauge1.Progress:=0;
        //   Form2.Show;
        StrPCopy(usechrs,
            ' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ&#');
        pal := TList.Create; { Create TList to form our palette }
        iWidth := delphiBitmap.Width;
        iHeight := delphiBitmap.Height;
        //  if iWidth > 180 then
        //    iWidth := 180;
        //  if iHeight > 180 then
        //    iHeight := 180;
        GetMem(image, SizeOf(Integer) * iWidth * iHeight);
        { Allocate space for image }
        { Note: Maximum of 65,528 bytes - 2 bytes per pixel }
        cpos := @image^; { This will be a pointer to current position in image }
        For ypos := 0 To iHeight - 1 Do
            For xpos := 0 To iWidth - 1 Do
            Begin
                ccol := delphiBitmap.Canvas.Pixels[xpos, ypos];
                found := False;
                For palindex := 0 To pal.Count - 1 Do
                Begin { Search palette for color }
                    tcol := TColor(pal.Items[palindex]^);
                    If tcol = ccol Then
                    Begin { Found it! }
                        found := True;
                        cindex := palindex; { Remember it's position in palette }
                        break;
                    End;
                End;
                If Not found Then
                Begin { Add new color to our palette }
                    New(lcol);
                    lcol^ := ccol;
                    pal.Add(lcol);
                    cindex := pal.Count - 1;
                End;
                cpos^ := cindex; { Store palette index for this pixel }
                Inc(cpos); { Move on to next pixel }
            End //      Form2.Gauge1.Progress:=((ypos+1)*100) div iHeight;
        //      Application.ProcessMessages;
        //      If Form2.Cancelled then goto Finish1;     { We have been cancelled! }
        ;

        //AssignFile(F,SaveDialog1.Filename);
        //Rewrite(F);
        rval := ln(pal.Count) / ln(64);
        cpp := trunc(rval);
        If (cpp <> rval) Then
            Inc(cpp);
        //Writeln(F,'/* XPM */');
        Result := Result + '/* XPM */' + #13;
        StrFmt(outline, 'static const char *%s', [XPMName]);
        strLine := outline;
        cp := StrScan(outline, '.');
        If cp <> Nil Then
            cp[0] := #0;
        StrCat(outline, '_XPM[]={');
        strLine := outline;
        //Writeln(F,outline);
        Result := Result + outline + #13;
        Result := Result + '/* ' + XPMName + ' */' + #13;
        StrFmt(outline, '"%d %d %d %d",', [iWidth, iHeight, pal.Count, cpp]);
        strLine := outline;
        //Writeln(F,outline);
        strLine := outline;
        Result := Result + outline + #13;
        For palindex := 0 To pal.Count - 1 Do
        Begin
            ccol := TColor(pal.Items[palindex]^);
            ccol := ccol Mod (256 * 256 * 256);
            StrFmt(outline, '"      c #%s%s%s",', [IntToHex(ccol Mod 256, 2),
                IntToHex((ccol Div 256) Mod 256, 2),
                IntToHex(ccol Div (256 * 256), 2)]);
            strLine := outline;
            cindex := palindex;
            For pixc := 1 To cpp Do
            Begin
                outline[pixc] := usechrs[cindex Div pow(64, cpp - pixc)];
                cindex := cindex Mod pow(64, cpp - pixc);
                strLine := outline;
            End;
            strLine := outline;
            Result := Result + outline + #13;
        End;
        cpos := @image^;
        For ypos := 0 To iHeight - 1 Do
        Begin
            StrPCopy(outline, '"');
            For xpos := 0 To iWidth - 1 Do
            Begin
                cindex := cpos^;
                For pixc := 1 To cpp Do
                Begin
                    outline[xpos * cpp + pixc] :=
                        usechrs[cindex Div pow(64, cpp - pixc)];
                    cindex := cindex Mod pow(64, cpp - pixc);
                End;
                Inc(cpos);
            End;

            //outline[cpp * (xpos + 1) + 1] := #0; // xpos is undefined after loop
            outline[cpp * (cpos^ + 1) + 1] := #0;
            // i think cpos is the intended variable instead
            If ypos < iHeight - 1 Then
                StrCat(outline, '",')
            Else
                StrCat(outline, '"};');
            //Writeln(F,outline);
            Result := Result + outline + #13;
        End;
        //Finish2:
        //CloseFile(F);

        Finish1:
            FreeMem(image, SizeOf(Integer) * iWidth * iHeight);
        For palindex := (pal.Count - 1) downto 0 Do
        Begin
            Dispose(pal.Items[palindex]);
            pal.Delete(palindex);
        End;
        
        pal.Clear;
        pal.Free;
    End;
End;

Function GenerateXPMDirectly(bmp: TBitmap; strCompName: String;
    strParentName: String; strFileName: String): Boolean;
Var
    xpmFileDir: String;
    fileStrlst: TStringList;
    strXPMContent: String;

Begin

    Result := False;
    If bmp = Nil Then
        Exit;

    xpmFileDir := CreateGraphicFileDir(strFileName) + 'Images' + pd;

    If bmp.handle <> 0 Then
    Begin

        fileStrlst := TStringList.Create;
        Try
            strXPMContent := GetXPMFromTPicture(strParentName + '_' +
                strCompName, bmp);

            // Create the Images directory if it doesn't exist.
            If Not DirectoryExists(xpmFileDir) Then
                If Not CreateDir(xpmFileDir) Then
                Begin
                    ShowMessage('ERROR: Can''t create directory ' +
                        xpmFileDir + ' for image.');
                    strXPMContent := '';
                End;

            If trim(strXPMContent) <> '' Then
            Begin

                fileStrlst.Add(strXPMContent);
                fileStrlst.SaveToFile(xpmFileDir + strParentName + '_' +
                    strCompName + '_XPM.xpm');
            End;

        Except
        End;
        fileStrlst.Destroy;
    End;
    Result := True;
End;

Function GetCommentString(str: String): String;
Begin
    If (trim(str) <> '') Then
        Result := '/* ' + str + ' */' + #13
    Else
        Result := ' ';

End;

Function GetCppString(str: String): String;
Begin

    // If the first character in the text is a &, then
    //    the user wants this to be a literal variable name
    // Otherwise, the user wants this to be a text value
    If (AnsiPos('&&', str) = 1) Then
    Begin
        Delete(str, 1, 2);
        Result := str;
    End
    Else
    Begin
        strSearchReplace(str, '\', '\\', [srAll]);
        strSearchReplace(str, '"', '\\"', [srAll]);
        strSearchReplace(str, #10, '\\n', [srAll]);
        strSearchReplace(str, #13, '\\r', [srAll]);

        //Replace our escape codes back
        strSearchReplace(str, '\\n', '\n', [srAll]);
        strSearchReplace(str, '\\b', '\b', [srAll]);
        strSearchReplace(str, '\\f', '\f', [srAll]);
        strSearchReplace(str, '\\n', '\n', [srAll]);
        strSearchReplace(str, '\\r', '\r', [srAll]);
        strSearchReplace(str, '\\t', '\t', [srAll]);
        strSearchReplace(str, '\\"', '\"', [srAll]);
        strSearchReplace(str, '\\''', '\''', [srAll]);
        strSearchReplace(str, '\\v', '\v', [srAll]);
        strSearchReplace(str, '\\a', '\a', [srAll]);
        strSearchReplace(str, '\\?', '\?', [srAll]);
        Result := StringFormat + '("' + str + '")';
    End;
End;

Function GetWxPosition(Left: Integer; Top: Integer): String;
Begin
    If (UseDefaultPos = True) Then
        Result := 'wxDefaultPosition'
    Else
        Result := Format('wxPoint(%d, %d)', [Left, Top]);
End;

Function GetWxSize(Width: Integer; Height: Integer): String;
Begin
    If (UseDefaultSize = True) Then
        Result := 'wxDefaultSize'
    Else
        Result := Format('wxSize(%d, %d)', [Width, Height]);
End;

Function GetWxEnum(Wx_IDValue: Integer; Wx_IDName: String): String;
Begin
    Result := '';
    If (UseIndividEnums = True) Then
    Begin
        If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
            Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
    End
    Else
    Begin
        If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
            Result := Format('%s, ', [Wx_IDName]);
    End;
End;

Function OpenXPMImage(InpImage: TBitmap; strFname: String): Boolean;
Type
    TPalRec = Record
        chrs: Pchar;
        color: TColor;
    End;

    Function HexVal(chr: Char): Integer;
    Begin
        If (chr >= 'a') And (chr <= 'f') Then
            HexVal := Ord(chr) - Ord('a') + 10
        Else
            HexVal := Ord(chr) - Ord('0');
    End;

Var
    iWidth: Integer;
    iHeight: Integer;
    cpp, colors, col, ypos, xpos, hexc, infield: Integer;
    fieldstr: Array[0..256] Of Char;
    fieldval: Integer;
    rgb1, rgb2, rgb3: Integer;
    inpline: Array[0..800] Of Char;
    capline: Array[0..256] Of Char;
    pal: TList;
    palitem: ^TPalRec;
    cp1, cp2: Pchar;
    F: TextFile;
    ColorDialog1: TColorDialog;
Label
    Finish1;
Begin
    Result := True;
    iHeight := 0;
    iWidth := 0;
    colors := 0;
    cpp := 0;
    palitem := Nil;

    Begin
        AssignFile(F, strFname);
        Reset(F);
        inpline[0] := #0;
        While inpline[0] <> '"' Do
            Readln(F, inpline);

        infield := 0;
        fieldstr[0] := #0;
        cp1 := inpline + 1;
        While cp1 <= StrScan(inpline + 1, '"') Do
        Begin
            If (cp1[0] = ' ') Or (cp1[0] = '"') Then
            Begin
                If fieldstr[0] <> #0 Then
                Begin
                    Inc(infield);
                    fieldval := StrToInt(StrPas(fieldstr));
                    fieldstr[0] := #0;
                    If infield = 1 Then
                        iWidth := fieldval;
                    If infield = 2 Then
                        iHeight := fieldval;
                    If infield = 3 Then
                        colors := fieldval;
                    If infield = 4 Then
                        cpp := fieldval;
                End;
            End
            Else
            Begin
                fieldstr[StrLen(fieldstr) + 1] := #0;
                fieldstr[StrLen(fieldstr)] := cp1[0];
            End;
            Inc(cp1);
        End;

        pal := TList.Create;
        For col := 0 To colors - 1 Do
        Begin
            inpline[0] := #0;
            While inpline[0] <> '"' Do
                Readln(F, inpline);
            inpline[cpp + 1] := #0;
            New(palitem);
            palitem^.chrs := StrAlloc(cpp + 1);
            StrCopy(palitem^.chrs, inpline + 1);
            cp1 := StrScan(inpline + cpp + 2, 'c') + 1;
            cp1 := SysUtils.StrLower(cp1);
            If StrScan(cp1, '#') = Nil Then
            Begin
                StrCopy(capline, 'What color does "');
                StrCat(capline, cp1);
                StrCat(capline, ' represent?');
                Application.MessageBox(capline, 'Select Color', mb_OK);
                ColorDialog1 := TColorDialog.Create(Nil);
                ColorDialog1.Execute;
                palitem^.color := ColorDialog1.Color;
            End
            Else
            Begin
                cp1 := StrScan(cp1, '#') + 1;
                cp2 := StrScan(cp1, '"');
                cp2[0] := #0;
                hexc := StrLen(cp1) Div 3;
                rgb1 := HexVal(cp1[0]) * 16 + HexVal(cp1[1]);
                rgb2 := HexVal(cp1[hexc]) * 16 + HexVal(cp1[hexc + 1]);
                rgb3 := HexVal(cp1[2 * hexc]) * 16 + HexVal(cp1[2 * hexc + 1]);
                palitem^.color := Longint(rgb1) + 256 * Longint(rgb2) + 256 *
                    256 * Longint(rgb3);
            End;
            pal.Add(palitem);
        End;

        InpImage.Height := iHeight;
        InpImage.Width := iWidth;
        cp1 := StrAlloc(cpp + 1);
        For ypos := 0 To iHeight - 1 Do
        Begin
            inpline[0] := #0;
            While inpline[0] <> '"' Do
                Readln(F, inpline);
            For xpos := 0 To iWidth - 1 Do
            Begin
                StrLCopy(cp1, inpline + xpos * cpp + 1, cpp);
                For col := 0 To colors - 1 Do
                Begin
                    palitem := pal.Items[col];
                    If SysUtils.StrComp(palitem^.chrs, cp1) = 0 Then
                        break;
                End;
                InpImage.Canvas.Pixels[xpos, ypos] := palitem^.color;
            End;
            //Form2.Gauge1.Progress:=((ypos+1)*100) div iHeight;
            Application.ProcessMessages;
        End;

        Finish1:
            StrDispose(cp1);

        For col := (colors - 1) downto 0 Do
        Begin
            palitem := pal.Items[col];
            StrDispose(palitem^.chrs);
            Dispose(palitem);
            pal.Delete(col);
        End;
        pal.Clear;
        pal.Free;

        CloseFile(F);
    End;

End;

Function IcoToBmp(Icon: TIcon): TBitmap;
Begin
    Result := TBitmap.Create;
    Result.Width := Icon.Width;
    Result.Height := Icon.Height;
    Result.Canvas.Draw(0, 0, Icon);
End;

Function GetwxColorFromString(strValue: String): String;
Var
    strColorValue, strChoice: String;
Begin
    Result := '';
    strColorValue := trim(strValue);
    strColorValue := copy(strColorValue, 5, length(strColorValue));
    strChoice := copy(trim(strValue), 0, 4);

    If AnsiSameText(strChoice, 'CUS:') Then
    Begin
        Result := 'wxColour(' + strColorValue + ')';
        exit;
    End;

    If AnsiSameText(strChoice, 'DEF:') Then
    Begin
        Result := '';
        exit;
    End;

    If AnsiSameText(strColorValue, 'BLACK') Then
    Begin
        Result := 'wxColour(' + GetCppString(strColorValue) + ')';
        exit;
    End;
    If AnsiSameText(strColorValue, 'BLUE') Then
    Begin
        Result := 'wxColour(' + GetCppString(strColorValue) + ')';
        exit;
    End;
    If AnsiSameText(strColorValue, 'CYAN') Then
    Begin
        Result := 'wxColour(' + GetCppString(strColorValue) + ')';
        exit;
    End;
    If AnsiSameText(strColorValue, 'DARK SLATE GREY') Then
    Begin
        Result := 'wxColour(' + GetCppString(strColorValue) + ')';
        exit;
    End;
    If AnsiSameText(strColorValue, 'LIGHT GREY') Then
    Begin
        Result := 'wxColour(' + GetCppString(strColorValue) + ')';
        exit;
    End;
    If AnsiSameText(strColorValue, 'GREEN') Then
    Begin
        Result := 'wxColour(' + GetCppString(strColorValue) + ')';
        exit;
    End;
    If AnsiSameText(strColorValue, 'GREY') Then
    Begin
        Result := 'wxColour(' + GetCppString(strColorValue) + ')';
        exit;
    End;
    If AnsiSameText(strColorValue, 'LIME GREEN') Then
    Begin
        Result := 'wxColour(' + GetCppString(strColorValue) + ')';
        exit;
    End;
    If AnsiSameText(strColorValue, 'MAROON') Then
    Begin
        Result := 'wxColour(' + GetCppString(strColorValue) + ')';
        exit;
    End;
    If AnsiSameText(strColorValue, 'NAVY') Then
    Begin
        Result := 'wxColour(' + GetCppString(strColorValue) + ')';
        exit;
    End;
    If AnsiSameText(strColorValue, 'PURPLE') Then
    Begin
        Result := 'wxColour(' + GetCppString(strColorValue) + ')';
        exit;
    End;
    If AnsiSameText(strColorValue, 'RED') Then
    Begin
        Result := 'wxColour(' + GetCppString(strColorValue) + ')';
        exit;
    End;
    If AnsiSameText(strColorValue, 'SKY BLUE') Then
    Begin
        Result := 'wxColour(' + GetCppString(strColorValue) + ')';
        exit;
    End;
    If AnsiSameText(strColorValue, 'YELLOW') Then
    Begin
        Result := 'wxColour(' + GetCppString(strColorValue) + ')';
        exit;
    End;
    If AnsiSameText(strColorValue, 'WHITE') Then
    Begin
        Result := 'wxColour(' + GetCppString(strColorValue) + ')';
        exit;
    End;

    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_SCROLLBAR') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_SCROLLBAR)';
        exit;
    End;

    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_BACKGROUND') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BACKGROUND)';
        exit;
    End;

    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_ACTIVECAPTION') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_ACTIVECAPTION)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVECAPTION') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_INACTIVECAPTION)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_MENU') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_MENU)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOW') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_WINDOW)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOWFRAME') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_WINDOWFRAME)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_MENUTEXT') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_MENUTEXT)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOWTEXT') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_WINDOWTEXT)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_CAPTIONTEXT') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_CAPTIONTEXT)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_ACTIVEBORDER') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_ACTIVEBORDER)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVEBORDER') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_INACTIVEBORDER)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_APPWORKSPACE') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_APPWORKSPACE)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_HIGHLIGHT') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_HIGHLIGHT)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_HIGHLIGHTTEXT') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_HIGHLIGHTTEXT)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNFACE') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BTNFACE)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNSHADOW') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BTNSHADOW)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_GRAYTEXT') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_GRAYTEXT)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNTEXT') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BTNTEXT)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVECAPTIONTEXT') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_INACTIVECAPTIONTEXT)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNHIGHLIGHT') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BTNHIGHLIGHT)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DDKSHADOW') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DDKSHADOW)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DLIGHT') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DLIGHT)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_INFOTEXT') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_INFOTEXT)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_INFOBK') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_INFOBK)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_DESKTOP') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_DESKTOP)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DFACE') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DFACE)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DSHADOW') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DSHADOW)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DHIGHLIGHT') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DHIGHLIGHT)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DHILIGHT') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DHILIGHT)';
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNHILIGHT') Then
    Begin
        Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BTNHILIGHT)';
        exit;
    End;

End;

Function PaperIDToString(sizeitem: TWxPaperSizeItem): String;
Begin
    Result := 'wxPAPER_NONE';

    If sizeitem = wxPAPER_NONE Then
    Begin
        Result := 'wxPAPER_NONE';
        Exit;
    End;

    If sizeitem = wxPAPER_LETTER Then
    Begin
        Result := 'wxPAPER_LETTER';
        Exit;
    End;
    If sizeitem = wxPAPER_LEGAL Then
    Begin
        Result := 'wxPAPER_LEGAL';
        Exit;
    End;
    If sizeitem = wxPAPER_A4 Then
    Begin
        Result := 'wxPAPER_A4';
        Exit;
    End;
    If sizeitem = wxPAPER_CSHEET Then
    Begin
        Result := 'wxPAPER_CSHEET';
        Exit;
    End;
    If sizeitem = wxPAPER_DSHEET Then
    Begin
        Result := 'wxPAPER_DSHEET';
        Exit;
    End;
    If sizeitem = wxPAPER_ESHEET Then
    Begin
        Result := 'wxPAPER_ESHEET';
        Exit;
    End;
    If sizeitem = wxPAPER_LETTERSMALL Then
    Begin
        Result := 'wxPAPER_LETTERSMALL';
        Exit;
    End;

    If sizeitem = wxPAPER_TABLOID Then
    Begin
        Result := 'wxPAPER_TABLOID';
        Exit;
    End;
    If sizeitem = wxPAPER_LEDGER Then
    Begin
        Result := 'wxPAPER_LEDGER';
        Exit;
    End;
    If sizeitem = wxPAPER_STATEMENT Then
    Begin
        Result := 'wxPAPER_STATEMENT';
        Exit;
    End;
    If sizeitem = wxPAPER_EXECUTIVE Then
    Begin
        Result := 'wxPAPER_EXECUTIVE';
        Exit;
    End;
    If sizeitem = wxPAPER_NOTE Then
    Begin
        Result := 'wxPAPER_NOTE';
        Exit;
    End;
    If sizeitem = wxPAPER_ENV_9 Then
    Begin
        Result := 'wxPAPER_ENV_9';
        Exit;
    End;
    If sizeitem = wxPAPER_A3 Then
    Begin
        Result := 'wxPAPER_A3';
        Exit;
    End;
    If sizeitem = wxPAPER_A4SMALL Then
    Begin
        Result := 'wxPAPER_A4SMALL';
        Exit;
    End;
    If sizeitem = wxPAPER_A5 Then
    Begin
        Result := 'wxPAPER_A5';
        Exit;
    End;
    If sizeitem = wxPAPER_B4 Then
    Begin
        Result := 'wxPAPER_B4';
        Exit;
    End;

    If sizeitem = wxPAPER_B5 Then
    Begin
        Result := 'wxPAPER_B5';
        Exit;
    End;
    If sizeitem = wxPAPER_FOLIO Then
    Begin
        Result := 'wxPAPER_FOLIO';
        Exit;
    End;
    If sizeitem = wxPAPER_QUARTO Then
    Begin
        Result := 'wxPAPER_QUARTO';
        Exit;
    End;
    If sizeitem = wxPAPER_10X14 Then
    Begin
        Result := 'wxPAPER_10X14';
        Exit;
    End;

    If sizeitem = wxPAPER_11X17 Then
    Begin
        Result := 'wxPAPER_11X17';
        Exit;
    End;
    If sizeitem = wxPAPER_ENV_10 Then
    Begin
        Result := 'wxPAPER_ENV_10';
        Exit;
    End;
    If sizeitem = wxPAPER_ENV_11 Then
    Begin
        Result := 'wxPAPER_ENV_11';
        Exit;
    End;
    If sizeitem = wxPAPER_ENV_12 Then
    Begin
        Result := 'wxPAPER_ENV_12';
        Exit;
    End;
    If sizeitem = wxPAPER_ENV_14 Then
    Begin
        Result := 'wxPAPER_ENV_14';
        Exit;
    End;
    If sizeitem = wxPAPER_ENV_DL Then
    Begin
        Result := 'wxPAPER_ENV_DL';
        Exit;
    End;
    If sizeitem = wxPAPER_ENV_C5 Then
    Begin
        Result := 'wxPAPER_ENV_C5';
        Exit;
    End;
    If sizeitem = wxPAPER_ENV_C3 Then
    Begin
        Result := 'wxPAPER_ENV_C3';
        Exit;
    End;
    If sizeitem = wxPAPER_ENV_C4 Then
    Begin
        Result := 'wxPAPER_ENV_C4';
        Exit;
    End;
    If sizeitem = wxPAPER_ENV_C6 Then
    Begin
        Result := 'wxPAPER_ENV_C6';
        Exit;
    End;
    If sizeitem = wxPAPER_ENV_C65 Then
    Begin
        Result := 'wxPAPER_ENV_C65';
        Exit;
    End;
    If sizeitem = wxPAPER_ENV_B4 Then
    Begin
        Result := 'wxPAPER_ENV_B4';
        Exit;
    End;

    If sizeitem = wxPAPER_ENV_B5 Then
    Begin
        Result := 'wxPAPER_ENV_B5';
        Exit;
    End;
    If sizeitem = wxPAPER_ENV_B6 Then
    Begin
        Result := 'wxPAPER_ENV_B6';
        Exit;
    End;
    If sizeitem = wxPAPER_ENV_ITALY Then
    Begin
        Result := 'wxPAPER_ENV_ITALY';
        Exit;
    End;
    If sizeitem = wxPAPER_ENV_MONARCH Then
    Begin
        Result := 'wxPAPER_ENV_MONARCH';
        Exit;
    End;
    If sizeitem = wxPAPER_ENV_PERSONAL Then
    Begin
        Result := 'wxPAPER_ENV_PERSONAL';
        Exit;
    End;
    If sizeitem = wxPAPER_FANFOLD_US Then
    Begin
        Result := 'wxPAPER_FANFOLD_US';
        Exit;
    End;
    If sizeitem = wxPAPER_FANFOLD_STD_GERMAN Then
    Begin
        Result := 'wxPAPER_FANFOLD_STD_GERMAN';
        Exit;
    End;
    If sizeitem = wxPAPER_FANFOLD_LGL_GERMAN Then
    Begin
        Result := 'wxPAPER_FANFOLD_LGL_GERMAN';
        Exit;
    End;

End;
//-------------------------------------------------------------------------------

Function IsDefaultColorStr(strvalue: String): Boolean;
Begin
    strvalue := trim(strvalue);
    If strvalue = '' Then
    Begin
        Result := True;
        exit;
    End;

    If UpperCase(copy(strvalue, 0, 4)) = 'DEF:' Then
        Result := True
    Else
        Result := False;
End;

Function GetGeneralColorFromString(strColorValue: String): TColor;
Begin
    strColorValue := trim(strColorValue);
    Result := 0 + clBlack;
    If AnsiSameText(strColorValue, 'BLACK') Then
    Begin
        Result := clBlack;
        exit;
    End;
    If AnsiSameText(strColorValue, 'BLUE') Then
    Begin
        Result := clBlue;
        exit;
    End;
    If AnsiSameText(strColorValue, 'CYAN') Then
    Begin
        Result := clAqua;
        exit;
    End;
    If AnsiSameText(strColorValue, 'DARK SLATE GREY') Then
    Begin
        Result := clDkGray;
        exit;
    End;
    If AnsiSameText(strColorValue, 'GREEN') Then
    Begin
        Result := clGreen;
        exit;
    End;
    If AnsiSameText(strColorValue, 'GREY') Then
    Begin
        Result := clGray;
        exit;
    End;
    If AnsiSameText(strColorValue, 'LIGHT GREY') Then
    Begin
        Result := clLtGray;
        exit;
    End;
    If AnsiSameText(strColorValue, 'LIME GREEN') Then
    Begin
        Result := clLime;
        exit;
    End;
    If AnsiSameText(strColorValue, 'MAROON') Then
    Begin
        Result := clMaroon;
        exit;
    End;
    If AnsiSameText(strColorValue, 'NAVY') Then
    Begin
        Result := clNavy;
        exit;
    End;
    If AnsiSameText(strColorValue, 'PURPLE') Then
    Begin
        Result := clPurple;
        exit;
    End;
    If AnsiSameText(strColorValue, 'RED') Then
    Begin
        Result := clRed;
        exit;
    End;
    If AnsiSameText(strColorValue, 'SKY BLUE') Then
    Begin
        Result := clSkyBlue;
        exit;
    End;
    If AnsiSameText(strColorValue, 'YELLOW') Then
    Begin
        Result := clYellow;
        exit;
    End;
    If AnsiSameText(strColorValue, 'WHITE') Then
    Begin
        Result := clWhite;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_SCROLLBAR') Then
    Begin
        Result := clScrollBar;
        exit;
    End;

    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_BACKGROUND') Then
    Begin
        Result := clBackground;
        exit;
    End;

    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_ACTIVECAPTION') Then
    Begin
        Result := clActiveCaption;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVECAPTION') Then
    Begin
        Result := clInactiveCaption;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_MENU') Then
    Begin
        Result := clMenu;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOW') Then
    Begin
        Result := clWindow;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOWFRAME') Then
    Begin
        Result := clWindowFrame;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_MENUTEXT') Then
    Begin
        Result := clMenuText;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOWTEXT') Then
    Begin
        Result := clWindowText;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_CAPTIONTEXT') Then
    Begin
        Result := clCaptionText;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_ACTIVEBORDER') Then
    Begin
        Result := clActiveBorder;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVEBORDER') Then
    Begin
        Result := clInactiveBorder;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_APPWORKSPACE') Then
    Begin
        Result := clAppWorkSpace;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_HIGHLIGHT') Then
    Begin
        Result := clHighlight;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_HIGHLIGHTTEXT') Then
    Begin
        Result := clHighlightText;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNFACE') Then
    Begin
        Result := clBtnFace;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNSHADOW') Then
    Begin
        Result := clBtnShadow;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_GRAYTEXT') Then
    Begin
        Result := clGrayText;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNTEXT') Then
    Begin
        Result := clBtnText;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVECAPTIONTEXT') Then
    Begin
        Result := clInactiveCaptionText;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNHIGHLIGHT') Then
    Begin
        Result := clBtnHighlight;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DDKSHADOW') Then
    Begin
        Result := cl3DDkShadow;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DLIGHT') Then
    Begin
        Result := cl3DLight;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_INFOTEXT') Then
    Begin
        Result := clInfoText;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_INFOBK') Then
    Begin
        Result := clInfoBk;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_DESKTOP') Then
    Begin
        Result := clBackground;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DFACE') Then
    Begin
        Result := clBtnFace;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DSHADOW') Then
    Begin
        Result := clBtnShadow;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DHIGHLIGHT') Then
    Begin
        Result := clBtnHighlight;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DHILIGHT') Then
    Begin
        Result := clBtnHighlight;
        exit;
    End;
    If AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNHILIGHT') Then
    Begin
        Result := clBtnHighlight;
        exit;
    End;
End;

//=== {TJvInspectorValidatorItem } ===========================================

Constructor TJvInspectorValidatorItem.Create(
    Const AParent: TJvCustomInspectorItem;
    Const AData: TJvCustomInspectorData);
Begin
    Inherited Create(AParent, AData);
End;

Procedure TJvInspectorValidatorItem.SetFlags(Const Value:
    TInspectorItemFlags);
Var
    NewValue: TInspectorItemFlags;
Begin
    NewValue := Value + [iifEditButton];
    Inherited SetFlags(NewValue);
End;

Procedure TJvInspectorValidatorItem.ContentsChanged(Sender: TObject);
Var
    Obj: TStrings;
Begin

    If Not Assigned(Data) Then
        exit;

    Obj := TStrings(Data.AsOrdinal);
    Obj.Text := TMemo(Sender).Lines.Text;
End;

Function TJvInspectorValidatorItem.GetDisplayValue: String;
Begin
    Result := 'Edit Validator';
End;

Procedure TJvInspectorValidatorItem.SetDisplayValue;
Begin

End;

Class Procedure TJvInspectorValidatorItem.RegisterAsDefaultItem;
Begin
    With TJvCustomInspectorData.ItemRegister Do
        If IndexOf(Self) = -1 Then
            Add(TJvInspectorTypeInfoRegItem.Create(Self,
                TypeInfo(TWxValidatorString)));
End;

Procedure TJvInspectorValidatorItem.Edit;
Var
    ValidatorForm: TwxValidator;
    wxValidatorstring: TWxValidatorString;
    compIntf: IWxValidatorInterface;
Begin

    If Not Assigned(TJvInspectorPropData(Self.GetData()).Instance) Then
        exit;
    If Not Assigned(Data) Then
        exit;

    wxValidatorString := TWxValidatorString(Data.AsOrdinal);

    ValidatorForm := TwxValidator.Create(GetParentForm(Inspector));
    Try

        ValidatorForm.SetValidatorString(wxValidatorString.strValidatorValue);

        If ValidatorForm.ShowModal = mrOk Then
        Begin

            wxValidatorString.FstrValidatorValue :=
                ValidatorForm.GetValidatorString;

            If (TJvInspectorPropData(Self.GetData()).Instance).GetInterface(
                IID_IWxValidatorInterface, compIntf) Then
            Begin
                If AnsiSameText(Data.Name, 'Wx_ProxyValidatorString') Then
                    compIntf.SetValidator(wxValidatorString.FstrValidatorValue);
            End;

            If assigned(TJvInspector(GetInspector).OnDataValueChanged) Then
                TJvInspector(GetInspector).OnDataValueChanged(Nil, Data);

        End;

    Finally
        ValidatorForm.Destroy;
    End;

End;
//=== { TJvInspectorTStringsItem } ===========================================

Constructor TWxJvInspectorTStringsItem.Create(
    Const AParent: TJvCustomInspectorItem;
    Const AData: TJvCustomInspectorData);
Begin
    Inherited Create(AParent, AData);
    RowSizing.MinHeight := irsItemHeight;
    Flags := Flags + [iifEditButton];
End;

Procedure TWxJvInspectorTStringsItem.ContentsChanged(Sender: TObject);
Var
    Obj: TStrings;
Begin
    If Not Assigned(Data) Then
        exit;
    Obj := TStrings(Data.AsOrdinal);
    Obj.Text := TMemo(Sender).Lines.Text;
End;

Function TWxJvInspectorTStringsItem.GetDisplayValue: String;
Begin
    Result := 'Edit Strings';
End;

Procedure TWxJvInspectorTStringsItem.Edit;
Var
    SL: TStrings;
    Form: TStringsForm;
Begin

    If Not Assigned(Data) Then
        exit;

    //Create the form
    Form := TStringsForm.Create(GetParentForm(Inspector));

    Try
        //Load the strings
        SL := TStrings(Data.AsOrdinal);
        Form.Memo.Lines.Assign(SL);
        If AutoUpdate Then
            Form.OnContentsChanged := ContentsChanged;

        //Show the form
        If Form.ShowModal = mrOk Then
        Begin
            SL.Assign(Form.Memo.Lines);
            If assigned(TJvInspector(GetInspector).OnDataValueChanged) Then
                TJvInspector(GetInspector).OnDataValueChanged(Nil, Data);
        End;
    Finally
        Form.Destroy;
    End;
End;

Procedure TWxJvInspectorTStringsItem.SetDisplayValue(Const Value: String);
Var
    Obj: TObject;
Begin

    If Not Assigned(Data) Then
        exit;

    If Multiline Then
    Begin
        Obj := TObject(Data.AsOrdinal);
        TStrings(Obj).Text := Value;
    End;
End;

Procedure TWxJvInspectorTStringsItem.SetFlags(
    Const Value: TInspectorItemFlags);
Var
    OldMask: TInspectorItemFlags;
    NewMask: TInspectorItemFlags;
Begin
    { The item has either an edit button or is multiline. If one of them is set,
    the other one will be removed }
    OldMask := Flags * [iifEditButton, iifMultiLine];
    NewMask := Value * [iifEditButton, iifMultiLine];
    If OldMask <> NewMask Then
    Begin
        If Multiline And Not (iifEditButton In OldMask) And
            (iifEditButton In NewMask) Then
            Inherited SetFlags(Value - [iifMultiLine]) // iifEditButton has changed
        Else
        If Not Multiline And (iifEditButton In OldMask) And
            (iifMultiLine In NewMask) Then
            Inherited SetFlags(Value - [iifEditButton]) // iifMultiLine has changed
        Else
            Inherited SetFlags(Value);
        // Neither flag has changed. Should never occur.
    End
    Else // Flags have not changed
        Inherited SetFlags(Value);
    If RowSizing <> Nil Then
    Begin
        RowSizing.Sizable := Multiline; // Update sizable state
        If Not Multiline Then
            RowSizing.SizingFactor := irsNoReSize
        Else
            RowSizing.SizingFactor := irsValueHeight;
    End;
End;

Class Procedure TWxJvInspectorTStringsItem.RegisterAsDefaultItem;
Begin
    With TJvCustomInspectorData.ItemRegister Do
        If IndexOf(Self) = -1 Then
            Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TStrings)));
End;

{-------------------------------------------------------}

Procedure TJvInspectorColorEditItem.Edit;
Var
    ColorEditForm: TColorEdit;
    strColorValue: String;
    compIntf: IWxComponentInterface;
Begin

    If Not Assigned(TJvInspectorPropData(Self.GetData()).Instance) Then
        exit;

    ColorEditForm := TColorEdit.Create(GetParentForm(Inspector));
    Try
        If (TJvInspectorPropData(Self.GetData()).Instance).GetInterface(
            IID_IWxComponentInterface, compIntf) Then
        Begin

            If AnsiSameText(Data.Name, 'Wx_ProxyBGColorString') Then
                strColorValue := compIntf.GetBGColor
            Else
            If AnsiSameText(Data.Name, 'Wx_ProxyFGColorString') Then
                strColorValue := compIntf.GetFGColor
            Else
                strColorValue := compIntf.GetGenericColor(Data.Name);
        End;

        ColorEditForm.SetColorString(strColorValue);

        If ColorEditForm.ShowModal = mrOk Then
        Begin

            strColorValue := ColorEditForm.GetColorString;

            If (TJvInspectorPropData(Self.GetData()).Instance).GetInterface(
                IID_IWxComponentInterface, compIntf) Then
            Begin
                If AnsiSameText(Data.Name, 'Wx_ProxyBGColorString') Then
                    compIntf.SetBGColor(strColorValue)
                Else
                If AnsiSameText(Data.Name, 'Wx_ProxyFGColorString') Then
                    compIntf.SetFGColor(strColorValue)
                Else
                    compIntf.SetGenericColor(Data.Name, strColorValue);
            End;

            If assigned(TJvInspector(GetInspector).OnDataValueChanged) Then
                TJvInspector(GetInspector).OnDataValueChanged(Nil, Data);

        End;

    Finally
        ColorEditForm.Destroy;
    End;

End;

Function TJvInspectorColorEditItem.GetDisplayValue: String;
Begin
    Result := 'Edit Color';
End;

Procedure TJvInspectorColorEditItem.SetDisplayValue(Const Value: String);
Begin

End;

Procedure TJvInspectorColorEditItem.SetFlags(Const Value: TInspectorItemFlags);
Var
    NewValue: TInspectorItemFlags;
Begin
    NewValue := Value + [iifEditButton];
    Inherited SetFlags(NewValue);
End;

Class Procedure TJvInspectorColorEditItem.RegisterAsDefaultItem;
Begin
    With TJvCustomInspectorData.ItemRegister Do
        If IndexOf(Self) = -1 Then
            Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TWxColorString)));
End;

Class Procedure TJvInspectorFileNameEditItem.RegisterAsDefaultItem;
Begin
    With TJvCustomInspectorData.ItemRegister Do
        If IndexOf(Self) = -1 Then
            Add(TJvInspectorTypeInfoRegItem.Create(Self,
                TypeInfo(TWxFileNameString)));
End;


Class Procedure TJvInspectorAnimationFileNameEditItem.RegisterAsDefaultItem;
Begin
    With TJvCustomInspectorData.ItemRegister Do
        If IndexOf(Self) = -1 Then
            Add(TJvInspectorTypeInfoRegItem.Create(Self,
                TypeInfo(TWxAnimationFileNameString)));
End;
//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

Procedure TJvInspectorListItemsItem.Edit;
Var
    ListviewForm: TListviewForm;
    i: Integer;
    lstColumn: TListColumn;
Begin

    If Not Assigned(TJvInspectorPropData(Self.GetData()).Instance) Then
        exit;

    ListviewForm := TListviewForm.Create(GetParentForm(Inspector));
    Try
        ListviewForm.LstViewObj.Columns.Clear;
        For i := 0 To
            TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns.Count
            - 1 Do
        Begin
            lstColumn := ListviewForm.LstViewObj.Columns.Add;
            lstColumn.Caption :=
                TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns[i].Caption;
            lstColumn.Width :=
                TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns[i].Width;
            lstColumn.Alignment :=
                TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns[i].Alignment;
        End;
        ListviewForm.fillListInfo;

        If ListviewForm.ShowModal = mrOk Then
        Begin
            TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns.Clear;
            For i := 0 To ListviewForm.LstViewObj.Columns.Count - 1 Do
            Begin
                lstColumn :=
                    TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns.Add;
                lstColumn.Caption := ListviewForm.LstViewObj.Columns[i].Caption;
                lstColumn.Width := ListviewForm.LstViewObj.Columns[i].Width;
                lstColumn.Alignment := ListviewForm.LstViewObj.Columns[i].Alignment;
            End;

            If assigned(TJvInspector(GetInspector).OnDataValueChanged) Then
                TJvInspector(GetInspector).OnDataValueChanged(Nil, Data);

        End;

    Finally
        ListviewForm.Destroy;
    End;

End;

Function TJvInspectorListItemsItem.GetDisplayValue: String;
Begin
    Result := 'Edit Items';
End;

Procedure TJvInspectorListItemsItem.SetDisplayValue(Const Value: String);
Begin

End;

Procedure TJvInspectorListItemsItem.SetFlags(Const Value: TInspectorItemFlags);
Var
    NewValue: TInspectorItemFlags;
Begin
    NewValue := Value + [iifEditButton];
    Inherited SetFlags(NewValue);
End;

Class Procedure TJvInspectorListItemsItem.RegisterAsDefaultItem;
Begin
    With TJvCustomInspectorData.ItemRegister Do
        If IndexOf(Self) = -1 Then
            Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TListItems)));
End;
//-------------------------------------------------------------------------------

Procedure TJvInspectorStatusBarItem.Edit;
Var
    sbForm: TStatusBarForm;
    i: Integer;
    stPnl: TStatusPanel;
Begin

    If Not Assigned(TJvInspectorPropData(Self.GetData()).Instance) Then
        exit;

    sbForm := TStatusBarForm.Create(GetParentForm(Inspector));
    Try
        sbForm.StatusBarObj.Panels.Clear;
        For i := 0 To
            TStatusBar(TJvInspectorPropData(Self.GetData()).Instance).Panels.Count
            - 1 Do
        Begin
            stPnl := sbForm.StatusBarObj.Panels.Add;
            stPnl.Text := TStatusBar(TJvInspectorPropData(Self.GetData()).Instance).Panels[i].Text;
            stPnl.Width := TStatusBar(TJvInspectorPropData(Self.GetData()).Instance).Panels[i].Width;
        End;
        sbForm.fillListInfo;

        If sbForm.ShowModal = mrOk Then
        Begin
            TStatusBar(TJvInspectorPropData(Self.GetData()).Instance).panels.Clear;
            For i := 0 To sbForm.StatusBarObj.Panels.Count - 1 Do
            Begin
                stPnl :=
                    TStatusBar(TJvInspectorPropData(Self.GetData()).Instance).Panels.Add;
                stPnl.Text := sbForm.StatusBarObj.Panels[i].Text;
                stPnl.Width := sbForm.StatusBarObj.Panels[i].Width;
            End;


            If assigned(TJvInspector(GetInspector).OnDataValueChanged) Then
                TJvInspector(GetInspector).OnDataValueChanged(Nil, Data);

        End;

    Finally
        sbForm.Destroy;
    End;

End;

Function TJvInspectorStatusBarItem.GetDisplayValue: String;
Begin
    Result := 'Edit Fields';
End;

Procedure TJvInspectorStatusBarItem.SetDisplayValue(Const Value: String);
Begin

End;

Procedure TJvInspectorStatusBarItem.SetFlags(Const Value: TInspectorItemFlags);
Var
    NewValue: TInspectorItemFlags;
Begin
    NewValue := Value + [iifEditButton];
    Inherited SetFlags(NewValue);
End;

Class Procedure TJvInspectorStatusBarItem.RegisterAsDefaultItem;
Begin
    With TJvCustomInspectorData.ItemRegister Do
        If IndexOf(Self) = -1 Then
            Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TStatusPanels)));
End;

//-------------------------------------------------------------------------------

Procedure TJvInspectorListColumnsItem.Edit;
Var
    ListviewForm: TListviewForm;
    i: Integer;
    lstColumn: TListColumn;
Begin

    If Not Assigned(TJvInspectorPropData(Self.GetData()).Instance) Then
        exit;

    ListviewForm := TListviewForm.Create(GetParentForm(Inspector));
    Try
        ListviewForm.LstViewObj.Columns.Clear;
        For i := 0 To
            TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns.Count
            - 1 Do
        Begin
            lstColumn := ListviewForm.LstViewObj.Columns.Add;
            lstColumn.Caption :=
                TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns[i].Caption;
            lstColumn.Width :=
                TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns[i].Width;
            lstColumn.Alignment :=
                TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns[i].Alignment;
        End;
        ListviewForm.fillListInfo;

        If ListviewForm.ShowModal = mrOk Then

        Begin
            TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns.Clear;
            For i := 0 To ListviewForm.LstViewObj.Columns.Count - 1 Do
            Begin
                lstColumn :=
                    TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns.Add;
                lstColumn.Caption := ListviewForm.LstViewObj.Columns[i].Caption;
                lstColumn.Width := ListviewForm.LstViewObj.Columns[i].Width;
                lstColumn.Alignment := ListviewForm.LstViewObj.Columns[i].Alignment;
            End;


            If assigned(TJvInspector(GetInspector).OnDataValueChanged) Then
                TJvInspector(GetInspector).OnDataValueChanged(Nil, Data);

        End;

    Finally
        ListviewForm.Destroy;
    End;

End;

Function TJvInspectorListColumnsItem.GetDisplayValue: String;
Begin
    Result := 'Edit Columns';
End;

Procedure TJvInspectorListColumnsItem.SetDisplayValue(Const Value: String);
Begin

End;

Procedure TJvInspectorListColumnsItem.SetFlags(
    Const Value: TInspectorItemFlags);
Var
    NewValue: TInspectorItemFlags;
Begin
    NewValue := Value + [iifEditButton];
    Inherited SetFlags(NewValue);
End;

Class Procedure TJvInspectorListColumnsItem.RegisterAsDefaultItem;
Begin
    With TJvCustomInspectorData.ItemRegister Do
        If IndexOf(Self) = -1 Then
            Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TListColumns)));
End;
//-------------------------------------------------------------------------------

Procedure TJvInspectorTreeNodesItem.Edit;
Var
    TreeViewForm: TTreeEditor;
    component1: TWxTreeCtrl;

Begin

    If Not Assigned(TJvInspectorPropData(Self.GetData()).Instance) Then
        exit;

    // Call tree editor form
    TreeViewForm := TTreeEditor.Create(GetParentForm(Inspector));
    Try

        // Clear tree
        TreeViewForm.TreeView1.Items.Clear;

        // Get Wx_TreeCtrl component being edited
        component1 := TWxTreeCtrl(TJvInspectorPropData(Self.GetData()).Instance);

        If (component1.Items <> Nil) Then
        Begin
                // Copy tree from component to form
            TreeViewForm.TreeView1.Items.BeginUpdate;
            TreeViewForm.TreeView1.Items.Assign(component1.Items);
            TreeViewForm.TreeView1.Items.EndUpdate;
        End;

        If TreeViewForm.ShowModal = mrOk Then
        Begin

            component1.Items.BeginUpdate;
            component1.Items.Clear;
            component1.Items.Assign(TreeViewForm.TreeView1.Items);
            component1.Items.EndUpdate;

            If assigned(TJvInspector(GetInspector).OnDataValueChanged) Then
                TJvInspector(GetInspector).OnDataValueChanged(Nil, Data);

        End;

    Finally
        TreeViewForm.Destroy;
    End;

End;

Function TJvInspectorTreeNodesItem.GetDisplayValue: String;
Begin
    Result := 'Edit Nodes';
End;

Procedure TJvInspectorTreeNodesItem.SetDisplayValue(Const Value: String);
Begin

End;

Procedure TJvInspectorTreeNodesItem.SetFlags(Const Value: TInspectorItemFlags);
Var
    NewValue: TInspectorItemFlags;
Begin
    NewValue := Value + [iifEditButton];
    Inherited SetFlags(NewValue);
End;

Class Procedure TJvInspectorTreeNodesItem.RegisterAsDefaultItem;
Begin
    With TJvCustomInspectorData.ItemRegister Do
        If IndexOf(Self) = -1 Then
            Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TTreeNodes)));
End;
//-------------------------------------------------------------------------------

Procedure TJvInspectorBitmapItem.Edit;
Var
    PictureEdit: TPictureEdit;
    picObj: Tpicture;
    strClassName: String;
    strFileName: String;
Begin

    If Not Assigned(TJvInspectorPropData(Self.GetData()).Instance) Then
        exit;

    PictureEdit := TPictureEdit.Create(GetParentForm(Inspector));

    strClassName := UpperCase(
        (TJvInspectorPropData(Self.GetData()).Instance).ClassName);

    If strClassName = UpperCase('TWxBitmapButton') Then
    Begin
        PictureEdit.Image1.Picture.Assign(TWxBitmapButton(
            TJvInspectorPropData(Self.GetData()).Instance).Wx_Bitmap);
        If (TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat) Then
            PictureEdit.KeepFormat.State := cbChecked
        Else
            PictureEdit.KeepFormat.State := cbUnchecked;

        PictureEdit.FileName.Text :=
            TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).GetGraphicFileName;
    End;

    If strClassName = UpperCase('TWxCustomButton') Then
    Begin
        PictureEdit.Image1.Picture.Assign(TWxCustomButton(
            TJvInspectorPropData(Self.GetData()).Instance).Wx_Bitmap);
        If (TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat) Then
            PictureEdit.KeepFormat.State := cbChecked
        Else
            PictureEdit.KeepFormat.State := cbUnchecked;

        PictureEdit.FileName.Text :=
            TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).GetGraphicFileName;

    End;

    If strClassName = UpperCase('TWxToolButton') Then
    Begin
        PictureEdit.Image1.Picture.Assign(
            TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_Bitmap);

        If (TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat) Then
            PictureEdit.KeepFormat.State := cbChecked
        Else
            PictureEdit.KeepFormat.State := cbUnchecked;

        PictureEdit.FileName.Text :=
            TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).GetGraphicFileName;

    End;

    If strClassName = UpperCase('TWxStaticBitmap') Then
    Begin
        PictureEdit.Image1.Picture.Assign(TWxStaticBitmap(
            TJvInspectorPropData(Self.GetData()).Instance).picture);

        If (TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat) Then
            PictureEdit.KeepFormat.State := cbChecked
        Else
            PictureEdit.KeepFormat.State := cbUnchecked;

        PictureEdit.FileName.Text :=
            TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).GetGraphicFileName;

    End;

    If strClassName = UpperCase('TFrmNewForm') Then
    Begin
        PictureEdit.Image1.Picture.Assign(
            TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).Wx_ICON);

        If (TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat) Then
            PictureEdit.KeepFormat.State := cbChecked
        Else
            PictureEdit.KeepFormat.State := cbUnchecked;

        PictureEdit.FileName.Text :=
            TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).GetGraphicFileName;

    End;

    Try
        If PictureEdit.ShowModal = mrOk Then
        Begin
            picObj := TPicture.Create;
            picObj.Bitmap.Assign(PictureEdit.Image1.Picture.Bitmap);

            If strClassName = UpperCase('TWxStaticBitmap') Then
            Begin
                TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).picture.Assign(picObj);
                TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).picture.Bitmap.Transparent := True;
                TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).Width :=
                    TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).picture.Bitmap.Width;
                TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).Height :=
                    TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).picture.Bitmap.Height;

                If (PictureEdit.KeepFormat.State = cbChecked) Then
                Begin
                    TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := True;
                    TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName(PictureEdit.FileName.Text);
                End
                Else
                Begin
                    TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := False;
                    //strFileName := 'Images' + pd + TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).GetName + '_XPM.xpm';
                    TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName('');
                End;

                strFileName := TWxStaticBitmap(TJvInspectorPropData(
                    Self.GetData()).Instance).GetGraphicFileName;

            End;

            If strClassName = UpperCase('TFrmNewForm') Then
            Begin
                TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).Wx_ICON.Assign(picObj);
                TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).Wx_ICON.Bitmap.Transparent := True;

                If (PictureEdit.KeepFormat.State = cbChecked) Then
                Begin
                    TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := True;
                    TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName(PictureEdit.FileName.Text);
                End
                Else
                Begin
                    TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := False;
                    TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName('');
                End;

                strFileName := TFrmNewForm(TJvInspectorPropData(
                    Self.GetData()).Instance).GetGraphicFileName;

            End;

            If strClassName = UpperCase('TWxBitmapButton') Then
            Begin
                TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_BITMAP.Assign(picObj);
                TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_BITMAP.Bitmap.Transparent := True;
                TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).SetButtonBitmap(picObj);

                If (PictureEdit.KeepFormat.State = cbChecked) Then
                Begin
                    TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := True;
                    TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName(PictureEdit.FileName.Text);
                End
                Else
                Begin
                    TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := False;
                    //strFileName := 'Images' + pd + TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).GetName + '_XPM.xpm';
                    TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName('');
                End;

                strFileName := TWxBitmapButton(TJvInspectorPropData(
                    Self.GetData()).Instance).GetGraphicFileName;

            End;

            If strClassName = UpperCase('TWxCustomButton') Then
            Begin
                TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_BITMAP.Assign(picObj);
                TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_BITMAP.Bitmap.Transparent := True;
                TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).SetButtonBitmap(picObj);

                If (PictureEdit.KeepFormat.State = cbChecked) Then
                Begin
                    TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := True;
                    TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName(PictureEdit.FileName.Text);
                End
                Else
                Begin
                    TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := False;
                    //strFileName := 'Images' + pd + TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).GetName + '_XPM.xpm';
                    TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName('');
                End;

                strFileName := TWxCustomButton(TJvInspectorPropData(
                    Self.GetData()).Instance).GetGraphicFileName;

            End;

            If strClassName = UpperCase('TWxToolButton') Then
            Begin
                TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_BITMAP.Assign(picObj);
                TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_BITMAP.Bitmap.Transparent := True;
                TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).SetButtonBitmap(picObj);

                If (PictureEdit.KeepFormat.State = cbChecked) Then
                Begin
                    TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := True;
                    TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName(PictureEdit.FileName.Text);
                End
                Else
                Begin
                    TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := False;
                    //strFileName := 'Images' + pd + TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).GetName + '_XPM.xpm';
                    TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName('');
                End;

                strFileName := TWxToolButton(TJvInspectorPropData(
                    Self.GetData()).Instance).GetGraphicFileName;

            End;

            If assigned(TJvInspector(GetInspector).OnDataValueChanged) Then
                TJvInspector(GetInspector).OnDataValueChanged(Nil, Data);
        End;

    Finally
        PictureEdit.Destroy;
    End;
End;

Function TJvInspectorBitmapItem.GetDisplayValue: String;
Begin
    Result := 'Edit Picture';
End;

Procedure TJvInspectorBitmapItem.SetDisplayValue(Const Value: String);
Begin

End;

Procedure TJvInspectorBitmapItem.SetFlags(Const Value: TInspectorItemFlags);
Var
    NewValue: TInspectorItemFlags;
Begin
    NewValue := Value + [iifEditButton];
    Inherited SetFlags(NewValue);
End;

Class Procedure TJvInspectorBitmapItem.RegisterAsDefaultItem;
Begin
    With TJvCustomInspectorData.ItemRegister Do
        If IndexOf(Self) = -1 Then
            Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TPicture)));
End;
//------------------------------------------------------------------------------

Procedure TJvInspectorMyFontItem.Edit;
Var
    FontDlg: TFontDialog;
    fnt: TFont;
    compIntf: IWxComponentInterface;
    prevColor: TColor;
    ColorInt: Integer;
Begin

    If Not Assigned(Data) Then
        exit;

    fnt := TFont(Data.AsOrdinal);

    prevColor := fnt.Color;

    FontDlg := TFontDialog.Create(GetParentForm(Inspector));

    Try
        FontDlg.Font.Assign(fnt);
        If Not FontDlg.Execute Then
            exit;
        fnt.Assign(FontDlg.Font);

        If prevColor <> fnt.Color Then
            If (TJvInspectorPropData(Self.GetData()).Instance).GetInterface(
                IID_IWxComponentInterface, compIntf) Then
            Begin
                ColorInt := ColorToRGB(fnt.Color);
                compIntf.SetFGColor('CUS:' + IntToStr(GetRValue(ColorInt)) +
                    ',' + IntToStr(GetGValue(ColorInt)) + ',' +
                    IntToStr(GetBValue(ColorInt)));
            End;

        If assigned(TJvInspector(GetInspector).OnDataValueChanged) Then
            TJvInspector(GetInspector).OnDataValueChanged(Nil, Data);

    Finally
        FontDlg.Destroy;
    End;
End;

Function TJvInspectorMyFontItem.GetDisplayValue: String;
Begin
    Result := 'Edit Font';
End;

Procedure TJvInspectorMyFontItem.SetDisplayValue(Const Value: String);
Begin

End;

Procedure TJvInspectorMyFontItem.SetFlags(Const Value: TInspectorItemFlags);
Var
    NewValue: TInspectorItemFlags;
Begin
    NewValue := Value + [iifEditButton];
    Inherited SetFlags(NewValue);
End;

Class Procedure TJvInspectorMyFontItem.RegisterAsDefaultItem;
Begin
    With TJvCustomInspectorData.ItemRegister Do
        If IndexOf(Self) = -1 Then
            Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TFont)));
End;

//------------------------------------------------------------------------------

Procedure TJvInspectorMenuItem.Edit;
Var
    mnuDlg: TMenuItemForm;
    pMenuItem: TWxPopupMenu;
    mbItem: TWxMenuBar;
    maxControlValue: Integer;
    MenuName: String;
Begin

    If Not Assigned(TJvInspectorPropData(Self.GetData()).Instance) Then
        exit;


    Try
        If (TJvInspectorPropData(Self.GetData()).Instance Is TControl) Then
            MenuName := TControl(TJvInspectorPropData(
                Self.GetData()).Instance).Name;
    Except
    End;

    If (TJvInspectorPropData(Self.GetData()).Instance Is TWxPopupMenu) Then
    Begin

        mnuDlg := TMenuItemForm.Create(GetParentForm(Inspector), MenuName);
        Try
            Begin
                pMenuItem :=
                    TWxPopupMenu(TJvInspectorPropData(
                    Self.GetData()).Instance);
                maxControlValue := GetMaxIDofWxForm(pMenuItem.parent);
                mnuDlg.SetMaxID(maxControlValue);
                mnuDlg.SetMenuItemsDes(pMenuItem.Parent, pMenuItem,
                    TWxCustomMenuItem(
                    pMenuItem.Wx_MenuItems), mnuDlg.FMenuItems);

                If mnuDlg.ShowModal = mrOk Then
                Begin

                    pMenuItem.Wx_MenuItems.Destroy;
                    pMenuItem.Wx_MenuItems :=
                        TWxCustomMenuItem.Create(pMenuItem);
                    mnuDlg.SetMenuItemsDes(pMenuItem.Parent,
                        pMenuItem, mnuDlg.FMenuItems,
                        TWxCustomMenuItem(pMenuItem.Wx_MenuItems));

                    If assigned(
                        TJvInspector(GetInspector).OnDataValueChanged) Then
                        TJvInspector(GetInspector).OnDataValueChanged(
                            Nil, Data);

                End;

            End;

        Finally
            mnuDlg.Destroy;
        End;

    End;

    If (TJvInspectorPropData(Self.GetData()).Instance Is TWxMenuBar) Then
    Begin

        mnuDlg := TMenuItemForm.Create(GetParentForm(Inspector), MenuName);
        Try
            Begin

                mbItem :=
                    TWxMenuBar(TJvInspectorPropData(Self.GetData()).Instance);
                maxControlValue := GetMaxIDofWxForm(mbItem.parent);
                mnuDlg.SetMaxID(maxControlValue);
                mnuDlg.SetMenuItemsDes(mbItem.Parent, mbItem,
                    TWxCustomMenuItem(
                    mbItem.Wx_MenuItems), mnuDlg.FMenuItems);

                If mnuDlg.ShowModal = mrOk Then
                Begin

                    mbItem.Wx_MenuItems.Destroy;
                    mbItem.Wx_MenuItems :=
                        TWxCustomMenuItem.Create(mbItem);
                    mnuDlg.SetMenuItemsDes(mbItem.Parent,
                        mbItem, mnuDlg.FMenuItems,
                        TWxCustomMenuItem(mbItem.Wx_MenuItems));
                    mbItem.BuildMenus(mbItem.Wx_MenuItems);

                    If assigned(
                        TJvInspector(GetInspector).OnDataValueChanged) Then
                        TJvInspector(
                            GetInspector).OnDataValueChanged(Nil, Data);

                End;
            End;
        Finally
            mnuDlg.Destroy;
        End;

    End;

End;



Function TJvInspectorMenuItem.GetDisplayValue: String;
Begin
    Result := 'Edit MenuItems';
End;

Procedure TJvInspectorMenuItem.SetDisplayValue(Const Value: String);
Begin

End;

Procedure TJvInspectorMenuItem.SetFlags(Const Value: TInspectorItemFlags);
Var
    NewValue: TInspectorItemFlags;
Begin
    NewValue := Value + [iifEditButton];
    Inherited SetFlags(NewValue);
End;

Class Procedure TJvInspectorMenuItem.RegisterAsDefaultItem;
Begin
    With TJvCustomInspectorData.ItemRegister Do
        If IndexOf(Self) = -1 Then
            Add(TJvInspectorTypeInfoRegItem.Create(Self,
                TypeInfo(TWxCustomMenuItem)));
End;

Procedure TJvInspectorFileNameEditItem.Edit;
Var
    FileOpenForm: TOpenDialogEx;
    WxFileNameString: TWxFileNameString;
Begin

    If Not Assigned(Data) Then
        exit;

    WxFileNameString := TWxFileNameString(Data.AsOrdinal);

    FileOpenForm := TOpenDialogEx.Create(wx_designer.ownerForm);
    FileOpenForm.Filter := 'All files (*.*)|*.*';

    If (FileOpenForm.Execute) Then // If a file is selected
        WxFileNameString.FstrFileNameValue := FileOpenForm.FileName
    Else // If Cancel is pushed, then remove file to load
        WxFileNameString.FstrFileNameValue := '';

    // if strEqual(UpperCase((TJvInspectorPropData(Self.GetData()).Instance).ClassName), UpperCase('TWxMemo')) then
    //       TWxMemo(TJvInspectorPropData(Self.GetData()).Instance).SetWxFileName(WxFileNameString.FstrFileNameValue);

    // Tony 15 May 2005
    // Unfortunately, I need to do the OnDataValueChanged twice to get the
    // wxform to update. Problem is that I need to invoke SetWxFileName procedure
    // in the calling function (at this point WxMemo). The 2 lines above should
    // do this (TWxMemo(...)), but I compiler complains that it can't find TWxMemo
    If assigned(TJvInspector(GetInspector).OnDataValueChanged) Then
    Begin
        TJvInspector(GetInspector).OnDataValueChanged(Nil, Data);
        TJvInspector(GetInspector).OnDataValueChanged(Nil, Data);
    End;

End;

Function TJvInspectorFileNameEditItem.GetDisplayValue: String;
Var
    WxFileNameString: TWxFileNameString;
Begin

    If Not Assigned(Data) Then
        exit;

    WxFileNameString := TWxFileNameString(Data.AsOrdinal);

    Result := 'File to load';

    If trim(WxFileNameString.FstrFileNameValue) <> '' Then
        Result := WxFileNameString.FstrFileNameValue;
End;

Procedure TJvInspectorFileNameEditItem.SetFlags(
    Const Value: TInspectorItemFlags);
Var
    NewValue: TInspectorItemFlags;
Begin
    NewValue := Value + [iifEditButton];
    Inherited SetFlags(NewValue);
End;

///////////////////////////////////
//mal
///////////////////////////////////
Procedure TJvInspectorAnimationFileNameEditItem.Edit;
Var
    FileOpenForm: TOpenDialog;
    WxAnimationFileNameString: TWxAnimationFileNameString;
Begin

    WxAnimationFileNameString := TWxAnimationFileNameString(Data.AsOrdinal);

    FileOpenForm := TOpenDialog.Create(GetParentForm(Inspector));
    FileOpenForm.Filter :=
        'Animated GIF files (*.gif)|*.GIF|Animated Cursor files (*.ani)|*.ANI';

    If (FileOpenForm.Execute) Then // If a file is selected
        WxAnimationFileNameString.FstrFileNameValue := FileOpenForm.FileName
    Else // If Cancel is pushed, then remove file to load
        WxAnimationFileNameString.FstrFileNameValue := '';

    // Tony 1 May 2008
    // Unfortunately, I need to do the OnDataValueChanged twice to get the
    // wxform to update. Problem is that I need to invoke SetWxFileName procedure
    // in the calling function (at this point WxAnimationCtrl). The 2 lines above should
    // do this (TWxMemo(...)), but I compiler complains that it can't find TWxMemo
    If assigned(TJvInspector(GetInspector).OnDataValueChanged) Then
    Begin
        TJvInspector(GetInspector).OnDataValueChanged(Nil, Data);
        TJvInspector(GetInspector).OnDataValueChanged(Nil, Data);
    End;

End;

Function TJvInspectorAnimationFileNameEditItem.GetDisplayValue: String;
Var
    WxAnimationFileNameString: TWxAnimationFileNameString;
Begin

    If Not Assigned(Data) Then
        exit;

    WxAnimationFileNameString := TWxAnimationFileNameString(Data.AsOrdinal);

    Result := 'File to load';

    If trim(WxAnimationFileNameString.FstrFileNameValue) <> '' Then
        Result := WxAnimationFileNameString.FstrFileNameValue;
End;

Procedure TJvInspectorAnimationFileNameEditItem.SetFlags(
    Const Value: TInspectorItemFlags);
Var
    NewValue: TInspectorItemFlags;
Begin
    NewValue := Value + [iifEditButton];
    Inherited SetFlags(NewValue);
End;

///////////////////////////////////

// Added by Tony Reina 20 June 2006
// We need a TButton class that will allow for the caption to be aligned
// I found this code at the Delphi Central website: http://www.delphi-central.com/tbut.aspx
//  BEGIN: TMultiLineBtn

Constructor TMultiLineBtn.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);
    fMultiLine := True;
    fHorizAlign := halCentre;
    fVerticalAlign := valCentre;
End;

Procedure TMultiLineBtn.SetVerticalAlign(Value: TVerticalAlign);
Begin
    If fVerticalAlign <> Value Then
    Begin
        fVerticalAlign := Value;
        RecreateWnd;
    End;
End;

Procedure TMultiLineBtn.SetHorizAlign(Value: THorizAlign);
Begin
    If fHorizAlign <> Value Then
    Begin
        fHorizAlign := Value;
        RecreateWnd;
    End;
End;

Procedure TMultiLineBtn.SetMultiLine(Value: Boolean);
Begin
    If fMultiLine <> Value Then
    Begin
        fMultiLine := Value;
        RecreateWnd;
    End;
End;

Procedure TMultiLineBtn.CreateParams(Var Params: TCreateParams);
Begin
    Inherited CreateParams(Params);
    Case VerticalAlign Of
        valTop:
            Params.Style := Params.Style Or BS_TOP;
        valBottom:
            Params.Style := Params.Style Or BS_BOTTOM;
        valCentre:
            Params.Style := Params.Style Or BS_VCENTER;
    End;

    Case HorizAlign Of
        halLeft:
            Params.Style := Params.Style Or BS_LEFT;
        halRight:
            Params.Style := Params.Style Or BS_RIGHT;
        halCentre:
            Params.Style := Params.Style Or BS_CENTER;
    End;

    If MultiLine Then
        Params.Style := Params.Style Or BS_MULTILINE
    Else
        Params.Style := Params.Style And Not BS_MULTILINE;
End;

// END: TMultiLineBtn

Function CreateBlankXRC: TStringList;
Begin

    Result := TStringList.Create;

    Try

        Result.Add('<?xml version="1.0" encoding="ISO-8859-1"?>');
        Result.Add('<resource version="2.3.0.1">');
        Result.Add('<!-- Created by ' + GetAppVersion + ' -->');

        // Result.Add(Format('<object class="%s" name="%s">', [frmNewForm.Wx_class, frmNewForm.Wx_Name]));

        //Result.Add('</object>');
        Result.Add('</resource>');

    Except
        Result.Destroy;
    End;
End;

Function GetExtension(FileName: String): String;
Begin
    If (UpperCase(ExtractFileExt(FileName)) = '.JPG') Then
        Result := 'JPEG'
    Else
    If (UpperCase(ExtractFileExt(FileName)) = '.JPEG') Then
        Result := 'JPEG'
    Else
    If (UpperCase(ExtractFileExt(FileName)) = '.ICO') Then
        Result := 'ICO'
    Else
    If (UpperCase(ExtractFileExt(FileName)) = '.BMP') Then
        Result := 'BMP'
    Else
    If (UpperCase(ExtractFileExt(FileName)) = '.GIF') Then
        Result := 'GIF'
    Else
    If (UpperCase(ExtractFileExt(FileName)) = '.PNG') Then
        Result := 'PNG'
    Else
        Result := 'XPM';

End;

Function GetLongName(Const ShortPathName: String): String;
Var
    hKernel32Dll: THandle;
    fncGetLongPathName: Function(lpszShortPath: LPCTSTR; lpszLongPath: LPTSTR;
        cchBuffer: DWORD): DWORD Stdcall;
    bSuccess: Boolean;
    szBuffer: Array[0..MAX_PATH] Of Char;
    pDesktop: IShellFolder;
    swShortPath: Widestring;
    iEaten: ULONG;
    pItemList: PItemIDList;
    iAttributes: ULONG;
Begin
    // try to find the function "GetLongPathNameA" (Windows 98/2000)
    hKernel32Dll := GetModuleHandle('Kernel32.dll');
    If (hKernel32Dll <> 0) Then
        @fncGetLongPathName := GetProcAddress(hKernel32Dll, 'GetLongPathNameA')
    Else
        @fncGetLongPathName := Nil;
    // use the function "GetLongPathNameA" if available
    bSuccess := False;
    If (Assigned(fncGetLongPathName)) Then
    Begin
        bSuccess := fncGetLongPathName(Pchar(ShortPathName), szBuffer,
            SizeOf(szBuffer)) > 0;
        If bSuccess Then
            Result := szBuffer;
    End;
    // use an alternative way of getting the path (Windows 95/NT)
    If (Not bSuccess) And Succeeded(SHGetDesktopFolder(pDesktop)) Then
    Begin
        swShortPath := ShortPathName;
        iAttributes := 0;
        If Succeeded(pDesktop.ParseDisplayName(0, Nil, POLESTR(swShortPath),
            iEaten, pItemList, iAttributes)) Then
        Begin
            bSuccess := SHGetPathFromIDList(pItemList, szBuffer);
            If bSuccess Then
                Result := szBuffer;
            // release ItemIdList (SHGetMalloc is superseded)
            CoTaskMemFree(pItemList);
        End;
    End;
    // give back the original path if unsuccessful
    If (Not bSuccess) Then
        Result := ShortPathName;
End;

Function strContains(Const S1, S2: String): Boolean;
Begin
    Result := Pos(S1, S2) > 0;
End;

{This unit contains 4 functions designed to validate and correct C++ class names
and windows file names. The functions are as follows

ValidateClassName       Takes a string and returns an integer containing the
                        number of errors found. It checks for empty class names,
                        names which don't contain only alphanumeric characters
                        or underscores. It also checks that the name is not a
                        reserved keyword.

CreateValidClassName    Takes a string containing the class name and returns a
                        string containing a 'fixed' class name. It runs through
                        the checks above, if an empty class name is found then
                        a default one is used. Any illegal characters are
                        replaced with an underscore. This may make strange
                        looking names but they are legal.

ValidateFileName        Takes a string containing the file name and returns an
                        integer containing the number of errors found. It checks
                        for empty filenames, names which contain "*?|:<>, since
                        these can choke the make program

CreateValidFileName     Takes a string containing the filename and returns a
                        string containing a legal filename. If the string is
                        empty a default name is filled in, otherwise any
                        illegal characters are replaced with an underscore.

Example usage of these functions.

  if(ValidateClassName(Edit1.Text) > 0 ) then
  begin
     if MessageDlg('Your class name contains errors, do you want it fixed automatically?',mtError,[mbYes, mbNo],0) = mrYes then
     begin
         Edit2.Text := CreateValidClassName(Edit1.Text);
     end
     else
     begin
        MessageDlg('Please fix the class name yourself, class names can only contain alphanumeric characters and an underscore, they cannot be reserved keywords or start with numbers',mtWarning,[mbOK],0);
     end;
  end;

This copyright to Sof.T 2006 and provided under the GPL license version 2 or
later at your preference.}

Function ValidateClassName(ClassName: String): Integer;
Var
    NumberOfErrors, LoopIndex: Integer;
    ReservedKeywordList: TStrings;
Begin

    NumberOfErrors := 0;

    //Check we have a name to work with
    If Length(ClassName) < 1 Then
    Begin
        NumberOfErrors := NumberOfErrors + 1;
    End
    //Check the first character is not a number
    Else
    If (ClassName[1] In ['0'..'9']) Then
    Begin
        NumberOfErrors := NumberOfErrors + 1;
    End;

    //Look for invalid characters in the class name
    For LoopIndex := 1 To Length(ClassName) Do
    Begin
        //if not((ClassName[LoopIndex] in ['a'..'z']) or (ClassName[LoopIndex] in ['A'..'Z']) or (ClassName[LoopIndex] in ['0'..'9']) or (ClassName[LoopIndex] = '_')) then
        If Not ((ClassName[LoopIndex] In ['a'..'z', 'A'..'Z', '0'..'9', '_'])) Then
        Begin
            NumberOfErrors := NumberOfErrors + 1;
        End;
    End;

    //Check we haven't ended up with a reserved keyword
    ReservedKeywordList := TStringList.Create;
    Try
        //Build the list of reserved keywords
        ReservedKeywordList.Add('asm');
        ReservedKeywordList.Add('do');
        ReservedKeywordList.Add('if');
        ReservedKeywordList.Add('return');
        ReservedKeywordList.Add('typedef');
        ReservedKeywordList.Add('auto');
        ReservedKeywordList.Add('double');
        ReservedKeywordList.Add('inline');
        ReservedKeywordList.Add('short');
        ReservedKeywordList.Add('typeid');
        ReservedKeywordList.Add('bool');
        ReservedKeywordList.Add('dynamic_cast');
        ReservedKeywordList.Add('int');
        ReservedKeywordList.Add('signed');
        ReservedKeywordList.Add('union');
        ReservedKeywordList.Add('break');
        ReservedKeywordList.Add('else');
        ReservedKeywordList.Add('long');
        ReservedKeywordList.Add('sizeof');
        ReservedKeywordList.Add('unsigned');
        ReservedKeywordList.Add('case');
        ReservedKeywordList.Add('enum');
        ReservedKeywordList.Add('mutable');
        ReservedKeywordList.Add('static');
        ReservedKeywordList.Add('using');
        ReservedKeywordList.Add('catch');
        ReservedKeywordList.Add('explicit');
        ReservedKeywordList.Add('namespace');
        ReservedKeywordList.Add('static_cast');
        ReservedKeywordList.Add('virtual');
        ReservedKeywordList.Add('char');
        ReservedKeywordList.Add('export');
        ReservedKeywordList.Add('new');
        ReservedKeywordList.Add('struct');
        ReservedKeywordList.Add('void');
        ReservedKeywordList.Add('class');
        ReservedKeywordList.Add('extern');
        ReservedKeywordList.Add('operator');
        ReservedKeywordList.Add('switch');
        ReservedKeywordList.Add('volatile');
        ReservedKeywordList.Add('const');
        ReservedKeywordList.Add('false');
        ReservedKeywordList.Add('private');
        ReservedKeywordList.Add('template');
        ReservedKeywordList.Add('wchar_t');
        ReservedKeywordList.Add('const_cast');
        ReservedKeywordList.Add('float');
        ReservedKeywordList.Add('protected');
        ReservedKeywordList.Add('this');
        ReservedKeywordList.Add('while');
        ReservedKeywordList.Add('continue');
        ReservedKeywordList.Add('for');
        ReservedKeywordList.Add('public');
        ReservedKeywordList.Add('throw');
        ReservedKeywordList.Add('default');
        ReservedKeywordList.Add('friend');
        ReservedKeywordList.Add('register');
        ReservedKeywordList.Add('true');
        ReservedKeywordList.Add('delete');
        ReservedKeywordList.Add('goto');
        ReservedKeywordList.Add('reinterpret_cast');
        ReservedKeywordList.Add('try');

        //Now check our ClassName against list of reserved keywords
        For LoopIndex := 0 To ReservedKeywordList.Count - 1 Do
        Begin
            If (CompareStr(ReservedKeywordList[LoopIndex], ClassName) = 0) Then
            Begin
                NumberOfErrors := NumberOfErrors + 1;
            End;
        End;

    Finally
        ReservedKeywordList.Free; { destroy the list object }
    End;

    Result := NumberOfErrors;

End;

Function CreateValidClassName(ClassName: String): String;
Var
    ValidClassName: String;
    LoopIndex: Integer;
    ReservedKeywordList: TStrings;
Begin

    ValidClassName := ClassName;

    //Check we have a name to work with, if not then assign a safe one
    If Length(ValidClassName) < 1 Then
        ValidClassName := 'DefaultClassName';

    //Look for invalid characters in the class name. Replace with '_'
    For LoopIndex := 1 To Length(ValidClassName) Do
    Begin
        If Not ((ValidClassName[LoopIndex] In ['a'..'z', 'A'..'Z',
            '0'..'9', '_'])) Then
        Begin
            ValidClassName[LoopIndex] := '_';
        End;
    End;

    //Check the first character is not a number if so add '_' in front
    If (ValidClassName[1] In ['0'..'9']) Then
    Begin
        Insert('_', ValidClassName, 0);
    End;

    //Check we haven't ended up with a reserved keyword
    ReservedKeywordList := TStringList.Create;
    Try
        //Build the list of reserved keywords
        ReservedKeywordList.Add('asm');
        ReservedKeywordList.Add('do');
        ReservedKeywordList.Add('if');
        ReservedKeywordList.Add('return');
        ReservedKeywordList.Add('typedef');
        ReservedKeywordList.Add('auto');
        ReservedKeywordList.Add('double');
        ReservedKeywordList.Add('inline');
        ReservedKeywordList.Add('short');
        ReservedKeywordList.Add('typeid');
        ReservedKeywordList.Add('bool');
        ReservedKeywordList.Add('dynamic_cast');
        ReservedKeywordList.Add('int');
        ReservedKeywordList.Add('signed');
        ReservedKeywordList.Add('union');
        ReservedKeywordList.Add('break');
        ReservedKeywordList.Add('else');
        ReservedKeywordList.Add('long');
        ReservedKeywordList.Add('sizeof');
        ReservedKeywordList.Add('unsigned');
        ReservedKeywordList.Add('case');
        ReservedKeywordList.Add('enum');
        ReservedKeywordList.Add('mutable');
        ReservedKeywordList.Add('static');
        ReservedKeywordList.Add('using');
        ReservedKeywordList.Add('catch');
        ReservedKeywordList.Add('explicit');
        ReservedKeywordList.Add('namespace');
        ReservedKeywordList.Add('static_cast');
        ReservedKeywordList.Add('virtual');
        ReservedKeywordList.Add('char');
        ReservedKeywordList.Add('export');
        ReservedKeywordList.Add('new');
        ReservedKeywordList.Add('struct');
        ReservedKeywordList.Add('void');
        ReservedKeywordList.Add('class');
        ReservedKeywordList.Add('extern');
        ReservedKeywordList.Add('operator');
        ReservedKeywordList.Add('switch');
        ReservedKeywordList.Add('volatile');
        ReservedKeywordList.Add('const');
        ReservedKeywordList.Add('false');
        ReservedKeywordList.Add('private');
        ReservedKeywordList.Add('template');
        ReservedKeywordList.Add('wchar_t');
        ReservedKeywordList.Add('const_cast');
        ReservedKeywordList.Add('float');
        ReservedKeywordList.Add('protected');
        ReservedKeywordList.Add('this');
        ReservedKeywordList.Add('while');
        ReservedKeywordList.Add('continue');
        ReservedKeywordList.Add('for');
        ReservedKeywordList.Add('public');
        ReservedKeywordList.Add('throw');
        ReservedKeywordList.Add('default');
        ReservedKeywordList.Add('friend');
        ReservedKeywordList.Add('register');
        ReservedKeywordList.Add('true');
        ReservedKeywordList.Add('delete');
        ReservedKeywordList.Add('goto');
        ReservedKeywordList.Add('reinterpret_cast');
        ReservedKeywordList.Add('try');

        //Now check our ValidClassName against list of reserved keywords
        //If we find a match flag error and add '_' to the start of the name
        For LoopIndex := 0 To ReservedKeywordList.Count - 1 Do
        Begin
            If (CompareStr(ReservedKeywordList[LoopIndex], ValidClassName) = 0) Then
            Begin
                Insert('_', ValidClassName, 0);
            End;
        End;

    Finally
        ReservedKeywordList.Free; { destroy the list object }
    End;

    Result := ValidClassName;

End;

Function ValidateFileName(FileName: String): Integer;
Var
    NumberOfErrors, LoopIndex: Integer;
Begin

    NumberOfErrors := 0;

    If Length(FileName) < 1 Then
        NumberOfErrors := NumberOfErrors + 1;

    //Look for invalid characters in the file name
    For LoopIndex := 1 To Length(FileName) Do
    Begin
        If ((FileName[LoopIndex] In ['"', '*', ':', '<', '>', '?', '|'])) Then
        Begin
            NumberOfErrors := NumberOfErrors + 1;
        End;
    End;

    Result := NumberOfErrors;

End;

Function CreateValidFileName(FileName: String): String;
Var
    ValidFileName: String;
    LoopIndex: Integer;
Begin

    ValidFileName := FileName;

    If Length(ValidFileName) < 1 Then
        ValidFileName := 'DefaultFileName';

    //Look for invalid characters in the file name. Replace with '_'
    For LoopIndex := 1 To Length(ValidFileName) Do
    Begin
        If ((ValidFileName[LoopIndex] In ['"', '*', ':', '<', '>', '?', '|'])) Then
        Begin
            ValidFileName[LoopIndex] := '_';
        End;
    End;

    Result := ValidFileName;

End;

Procedure PopulateAuiGenericProperties(Var PropertyList: TStringList);
Begin
    //Aui Properties
    PropertyList.add('Wx_AuiManaged: wxAui Managed');

    PropertyList.add('Wx_PaneName:wxAui Pane Name');
    PropertyList.add('Wx_PaneCaption:wxAui Pane Caption');

    PropertyList.add('Wx_Aui_Dock_Direction:wxAui Dock Direction');
    PropertyList.add('wxAUI_DOCK_NONE:wxAUI_DOCK_NONE');
    PropertyList.add('wxAUI_DOCK_TOP:wxAUI_DOCK_TOP');
    PropertyList.add('wxAUI_DOCK_RIGHT:wxAUI_DOCK_RIGHT');
    PropertyList.add('wxAUI_DOCK_BOTTOM:wxAUI_DOCK_BOTTOM');
    PropertyList.add('wxAUI_DOCK_LEFT:wxAUI_DOCK_LEFT');
    PropertyList.add('wxAUI_DOCK_CENTER:wxAUI_DOCK_CENTER');

    PropertyList.add('Wx_Aui_Dockable_Direction:wxAui Dockable Direction');
    PropertyList.add('TopDockable:TopDockable');
    PropertyList.add('RightDockable:RightDockable');
    PropertyList.add('BottomDockable:BottomDockable');
    PropertyList.add('LeftDockable:LeftDockable');

    PropertyList.add('Wx_Aui_Pane_Style:wxAui Pane Style');
    PropertyList.add('CaptionVisible:CaptionVisible');
    PropertyList.add('DestroyOnClose:DestroyOnClose');
    PropertyList.add('DockFixed:DockFixed');
    PropertyList.add('Floatable:Floatable');
    PropertyList.add('Gripper:Gripper');
    PropertyList.add('GripperTop:GripperTop');
    PropertyList.add('Movable:Movable');
    PropertyList.add('PaneBorder:PaneBorder');
    PropertyList.add('Resizable:Resizable');
    PropertyList.add('CenterPane:CenterPane');
    PropertyList.add('ToolbarPane:ToolbarPane');

    PropertyList.add('Wx_Aui_Pane_Buttons:wxAui Pane Buttons');
    PropertyList.add('CloseButton:CloseButton');
    PropertyList.add('MaximizeButton:MaximizeButton');
    PropertyList.add('MinimizeButton:MinimizeButton');
    PropertyList.add('PinButton:PinButton');

    PropertyList.add('Wx_BestSize_Height:wxAui Best Height');
    PropertyList.add('Wx_BestSize_Width:wxAui Best Width');
    PropertyList.add('Wx_MinSize_Height:wxAui Min Height');
    PropertyList.add('Wx_MinSize_Width:wxAui Min Width');
    PropertyList.add('Wx_MaxSize_Height:wxAui Max Height');
    PropertyList.add('Wx_MaxSize_Width:wxAui Max Width');
    PropertyList.add('Wx_Floating_Height:wxAui Floating Height');
    PropertyList.add('Wx_Floating_Width:wxAui Floating Width');
    PropertyList.add('Wx_Floating_X_Pos:wxAui Floating X Pos');
    PropertyList.add('Wx_Floating_Y_Pos:wxAui Floating Y Pos');

    PropertyList.add('Wx_Layer:wxAui Layer');
    PropertyList.add('Wx_Row:wxAui Row');
    PropertyList.add('Wx_Position:wxAui Position');
End;

Function GetAuiManagerName(Control: TControl): String;
Var
    frmMainObj: TCustomForm;
    I: Integer;
Begin
    Result := '';

    frmMainObj := GetParentForm(Control);
    For I := 0 To frmMainObj.ComponentCount - 1 Do // Iterate
        If frmMainObj.Components[i] Is TWxAuiManager Then
        Begin
            Result := frmMainObj.Components[i].Name;
            exit;
        End;

    //    Result := 'WxAuiManager1';
End;

Function FormHasAuiManager(Control: TControl): Boolean;
Var
    frmMainObj: TCustomForm;
    I: Integer;
Begin
    Result := False;

    frmMainObj := GetParentForm(Control);
    For I := 0 To frmMainObj.ComponentCount - 1 Do // Iterate
        If frmMainObj.Components[i] Is TWxAuiManager Then
        Begin
            Result := True;
            exit;
        End;
End;

Function GetAuiDockDirection(Wx_Aui_Dock_Direction:
    TwxAuiPaneDockDirectionItem): String;
Begin
    Result := '';
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_NONE Then
    Begin
        Result := '';
        exit;
    End;
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_TOP Then
    Begin
        Result := '.Top()';
        exit;
    End;
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_RIGHT Then
    Begin
        Result := '.Right()';
        exit;
    End;
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_BOTTOM Then
    Begin
        Result := '.Bottom()';
        exit;
    End;
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_LEFT Then
    Begin
        Result := '.Left()';
        exit;
    End;
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_CENTER Then
    Begin
        Result := '.Center()';
        exit;
    End;
End;

Function GetAui_Pane_Style(Wx_Aui_Pane_Style: TwxAuiPaneStyleSet): String;
Begin
    Result := '';
    If CaptionVisible In Wx_Aui_Pane_Style Then
        Result := Result + '.CaptionVisible(true)'
    Else
        Result := Result + '.CaptionVisible(false)';

    If DestroyOnClose In Wx_Aui_Pane_Style Then
        Result := Result + '.DestroyOnClose(true)'
    Else
        Result := Result + '.DestroyOnClose(false)';

    If DockFixed In Wx_Aui_Pane_Style Then
        Result := Result + '.DockFixed()';

    If Floatable In Wx_Aui_Pane_Style Then
        Result := Result + '.Floatable(true)'
    Else
        Result := Result + '.Floatable(false)';

    If Gripper In Wx_Aui_Pane_Style Then
        Result := Result + '.Gripper(true)'
    Else
        Result := Result + '.Gripper(false)';

    If GripperTop In Wx_Aui_Pane_Style Then
        Result := Result + '.GripperTop()';

    If Movable In Wx_Aui_Pane_Style Then
        Result := Result + '.Movable()';

    If PaneBorder In Wx_Aui_Pane_Style Then
        Result := Result + '.PaneBorder()';

    If ToolbarPane In Wx_Aui_Pane_Style Then
    Begin
        Result := Result + '.ToolbarPane()';
    End
    Else
    Begin
        If Resizable In Wx_Aui_Pane_Style Then
            Result := Result + '.Resizable(true)'
        Else
            Result := Result + '.Resizable(false)';
    End;

    If CenterPane In Wx_Aui_Pane_Style Then
        Result := Result + '.CenterPane()';

End;

Function GetAuiDockableDirections(Wx_Aui_Dockable_Direction:
    TwxAuiPaneDockableDirectionSet): String;
Begin
    Result := '';
    If (LeftDockable In Wx_Aui_Dockable_Direction) And
        (RightDockable In Wx_Aui_Dockable_Direction)
        And (TopDockable In Wx_Aui_Dockable_Direction) And
        (BottomDockable In Wx_Aui_Dockable_Direction) Then
    Begin
        Result := Result + '.Dockable(true)';
        Exit;
    End;

    If Not (LeftDockable In Wx_Aui_Dockable_Direction) And Not
        (RightDockable In Wx_Aui_Dockable_Direction)
        And Not (TopDockable In Wx_Aui_Dockable_Direction) And Not
        (BottomDockable In Wx_Aui_Dockable_Direction) Then
    Begin
        Result := Result + '.Dockable(false)';
        Exit;
    End;

    If LeftDockable In Wx_Aui_Dockable_Direction Then
        Result := Result + '.LeftDockable(true)'
    Else
        Result := Result + '.LeftDockable(false)';

    If RightDockable In Wx_Aui_Dockable_Direction Then
        Result := Result + '.RightDockable(true)'
    Else
        Result := Result + '.RightDockable(false)';

    If TopDockable In Wx_Aui_Dockable_Direction Then
        Result := Result + '.TopDockable(true)'
    Else
        Result := Result + '.TopDockable(false)';

    If BottomDockable In Wx_Aui_Dockable_Direction Then
        Result := Result + '.BottomDockable(true)'
    Else
        Result := Result + '.BottomDockable(false)';
End;

Function GetAui_Pane_Buttons(Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet): String;
Begin
    Result := '';

    If CloseButton In Wx_Aui_Pane_Buttons Then
        Result := Result + '.CloseButton()';

    If MaximizeButton In Wx_Aui_Pane_Buttons Then
        Result := Result + '.MaximizeButton()';

    If MinimizeButton In Wx_Aui_Pane_Buttons Then
        Result := Result + '.MinimizeButton()';

    If PinButton In Wx_Aui_Pane_Buttons Then
        Result := Result + '.PinButton()';
End;

Function GetAuiRow(row: Integer): String;
Begin
    Result := Format('.Row(%d)', [row]);
End;

Function GetAuiPosition(position: Integer): String;
Begin
    Result := Format('.Position(%d)', [position]);
End;

Function GetAuiLayer(layer: Integer): String;
Begin
    Result := Format('.Layer(%d)', [layer]);
End;

Function GetAuiPaneBestSize(width: Integer; height: Integer): String;
Begin
    Result := '';
    If (height > 0) And (width > 0) Then
        Result := Format('.BestSize(wxSize(%d, %d))', [width, height]);
End;

Function GetAuiPaneMinSize(width: Integer; height: Integer): String;
Begin
    Result := '';
    If (height > 0) And (width > 0) Then
        Result := Format('.MinSize(wxSize(%d, %d))', [width, height]);
End;

Function GetAuiPaneMaxSize(width: Integer; height: Integer): String;
Begin
    Result := '';
    If (width > 0) And (height > 0) Then
        Result := Format('.MaxSize(wxSize(%d, %d))', [width, height]);
End;

Function GetAuiPaneFloatingSize(width: Integer; height: Integer): String;
Begin
    Result := '';
    If (width > 0) And (height > 0) Then
        Result := Format('.FloatingSize(wxSize(%d, %d))', [width, height]);
End;

Function GetAuiPaneFloatingPos(x: Integer; y: Integer): String;
Begin
    Result := '';
    If (x > 0) And (y > 0) Then
        Result := Format('.FloatingPosition(wxPoint(%d, %d))', [x, y]);
End;

Function GetAuiPaneCaption(caption: String): String;
Begin
    If trim(caption) = '' Then
        Result := ''
    Else
        Result := Format('.Caption(wxT("%s"))', [caption]);
End;

Function GetAuiPaneName(name: String): String;
Begin
    Result := Format('.Name(wxT("%s"))', [name]);
End;

Function HasToolbarPaneStyle(Wx_Aui_Pane_Style: TwxAuiPaneStyleSet): Boolean;
Begin
    Result := ToolbarPane In Wx_Aui_Pane_Style;
End;

Function LocalAppDataPath: String;
Const
    CSIDL_PERSONAL = $0005;
    { My Documents.  This is equivalent to CSIDL_MYDOCUMENTS in XP and above }
Var
    path: Array [0..MaxChar] Of Char;
Begin
    SHGetFolderPath(0, CSIDL_PERSONAL, 0, CSIDL_PERSONAL, @path[0]);
    Result := path;
End;

Function GetRefinedWxEdtGeneralStyleValue(
    sValue: TWxEdtGeneralStyleSet): TWxEdtGeneralStyleSet;
Begin
    Result := [];

    Try

        If wxTE_PROCESS_ENTER In sValue Then
            Result := Result + [wxTE_PROCESS_ENTER];

        If wxTE_PROCESS_TAB In sValue Then
            Result := Result + [wxTE_PROCESS_TAB];

        If wxTE_PASSWORD In sValue Then
            Result := Result + [wxTE_PASSWORD];

        If wxTE_READONLY In sValue Then
            Result := Result + [wxTE_READONLY];

        If wxTE_RICH In sValue Then
            Result := Result + [wxTE_RICH];

        If wxTE_RICH2 In sValue Then
            Result := Result + [wxTE_RICH2];

        If wxTE_NO_VSCROLL In sValue Then
            Result := Result + [wxTE_NO_VSCROLL];

        If wxTE_AUTO_URL In sValue Then
            Result := Result + [wxTE_AUTO_URL];

        If wxTE_NOHIDESEL In sValue Then
            Result := Result + [wxTE_NOHIDESEL];

        If wxTE_LEFT In sValue Then
            Result := Result + [wxTE_LEFT];

        If wxTE_CENTRE In sValue Then
            Result := Result + [wxTE_CENTRE];

        If wxTE_RIGHT In sValue Then
            Result := Result + [wxTE_RIGHT];

        If wxTE_DONTWRAP In sValue Then
            Result := Result + [wxTE_DONTWRAP];

        If wxTE_BESTWRAP In sValue Then
            Result := Result + [wxTE_BESTWRAP];

        If wxTE_CHARWRAP In sValue Then
            Result := Result + [wxTE_CHARWRAP];

        If wxTE_LINEWRAP In sValue Then
            Result := Result + [wxTE_LINEWRAP];

        If wxTE_WORDWRAP In sValue Then
            Result := Result + [wxTE_WORDWRAP];

        If wxTE_CAPITALIZE In sValue Then
            Result := Result + [wxTE_CAPITALIZE];

        If wxTE_MULTILINE In sValue Then
            Result := Result + [wxTE_MULTILINE];

    Finally
        sValue := [];
    End;

End;

Function GetAppVersion: String;
Var
    Size, Size2: DWord;
    Pt, Pt2: Pointer;
Begin
    Size := GetFileVersionInfoSize(Pchar(ParamStr(0)), Size2);
    If Size > 0 Then
    Begin
        GetMem(Pt, Size);
        Try
            GetFileVersionInfo(Pchar(ParamStr(0)), 0, Size, Pt);
            VerQueryValue(Pt, '\', Pt2, Size2);
            With TVSFixedFileInfo(Pt2^) Do
            Begin
                Result := ' build ' +
                    IntToStr(HiWord(dwFileVersionMS)) + '.' +
                    IntToStr(LoWord(dwFileVersionMS)) + '.' +
                    IntToStr(HiWord(dwFileVersionLS)) + '.' +
                    IntToStr(LoWord(dwFileVersionLS));
            End;
        Finally
            FreeMem(Pt);
        End;
    End;
End;

End.
