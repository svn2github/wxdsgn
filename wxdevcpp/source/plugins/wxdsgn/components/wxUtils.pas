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
UNIT WxUtils;

INTERFACE

USES
WinTypes, WinProcs, Messages, SysUtils, StrUtils, Classes, Controls,
Forms, Graphics, StdCtrls, Dialogs, ComCtrls, ExtCtrls, dmListview,
dmTreeView,
UPicEdit, UStrings, TypInfo, Menus, UStatusbar, UValidator,
JvInspector, wxversion, DateUtils, xprocs, ShellAPI, SHFolder;

CONST
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

VAR
StringFormat: STRING;
UseDefaultPos: BOOLEAN;
UseDefaultSize: BOOLEAN;
UseIndividEnums: BOOLEAN;

XRCGEN: BOOLEAN;//NUKLEAR ZELPH

//type

FUNCTION ExtractComponentPropertyName(CONST S: STRING): STRING;
FUNCTION ExtractComponentPropertyCaption(CONST S: STRING): STRING;
FUNCTION iswxForm(FileName: STRING): BOOLEAN;
//function isRCExt(FileName: string): boolean;
FUNCTION isXRCExt(FileName: STRING): BOOLEAN;
FUNCTION SaveStringToFile(strContent, strFileName: STRING): BOOLEAN;

FUNCTION CreateGraphicFileName(strFileName: STRING): STRING;
FUNCTION CreateGraphicFileDir(strFileName: STRING): STRING;

FUNCTION LocalAppDataPath: STRING;

TYPE
TWxPoint = CLASS(TComponent)
PRIVATE
FX: INTEGER;
FY: INTEGER;
PUBLISHED
PROPERTY X: INTEGER READ FX WRITE FX DEFAULT 0;
PROPERTY Y: INTEGER READ FY WRITE FY DEFAULT 0;
END;

// Added by Tony Reina 20 June 2006
// We need a TButton class that will allow for the caption to be aligned
// I found this code at the Delphi Central website: http://www.delphi-central.com/tbut.aspx
TYPE
THorizAlign = (halLeft, halRight, halCentre);
TVerticalAlign = (valTop, valBottom, valCentre);

TMultiLineBtn = CLASS(TButton)
PRIVATE
fMultiLine: BOOLEAN;
fHorizAlign: THorizAlign;
fVerticalAlign: TVerticalAlign;
PROCEDURE SetMultiLine(Value: BOOLEAN);
PROCEDURE SetHorizAlign(Value: THorizAlign);
PROCEDURE SetVerticalAlign(Value: TVerticalAlign);
PROTECTED
PROCEDURE CreateParams(VAR Params: TCreateParams); OVERRIDE;
PUBLIC
CONSTRUCTOR Create(AOwner: TComponent); OVERRIDE;
PUBLISHED
PROPERTY HorizAlign: THorizAlign
READ fHorizAlign WRITE setHorizAlign DEFAULT halCentre;
PROPERTY VerticalAlign: TVerticalAlign READ fVerticalAlign
WRITE setVerticalAlign DEFAULT valCentre;
PROPERTY MultiLine: BOOLEAN
READ fMultiLine WRITE SetMultiLine DEFAULT TRUE;
END;
    // END: TMultiLineBtn

TWxStdDialogButtons = SET OF
(wxID_OK, wxID_YES, wxID_SAVE, wxID_NO, wxID_CANCEL,
wxID_APPLY, wxID_HELP, wxID_CONTEXT_HELP);
TWxSizerAlignment = (wxALIGN_TOP, wxALIGN_LEFT, wxALIGN_RIGHT,
wxALIGN_BOTTOM,
wxALIGN_CENTER, wxALIGN_CENTER_VERTICAL,
wxALIGN_CENTER_HORIZONTAL, wxEXPAND);
TWxSizerAlignmentSet = SET OF TWxSizerAlignment;
TWxBorderAlignment = SET OF (wxTOP, wxLEFT, wxRIGHT, wxBOTTOM, wxALL);
TWxControlOrientation = (wxControlVertical, wxControlHorizontal,
wxControlNone);
TWxGridSelection = (wxGridSelectCells, wxGridSelectColumns,
wxGridSelectRows);
TWxDesignerType = (dtWxDialog, dtWxFrame, dtWxWizard);

IWxComponentInterface = INTERFACE
['{624949E8-E46C-4EF9-BADA-BC85325165B3}']
FUNCTION GenerateEnumControlIDs: STRING;
FUNCTION GenerateControlIDs: STRING;

FUNCTION GenerateGUIControlCreation: STRING;
FUNCTION GenerateXRCControlCreation(IndentString: STRING): TStringList;
FUNCTION GenerateGUIControlDeclaration: STRING;
FUNCTION GenerateHeaderInclude: STRING;
FUNCTION GenerateImageInclude: STRING;
FUNCTION GetPropertyList: TStringList;

FUNCTION GetEventList: TStringList;
FUNCTION GenerateEventTableEntries(CurrClassName: STRING): STRING;
FUNCTION GetParameterFromEventName(EventName: STRING): STRING;
FUNCTION GetTypeFromEventName(EventName: STRING): STRING;

FUNCTION GetIDName: STRING;
PROCEDURE SetIDName(IDName: STRING);
FUNCTION GetIDValue: INTEGER;
PROCEDURE SetIDValue(IDValue: INTEGER);

FUNCTION GetWxClassName: STRING;
PROCEDURE SetWxClassName(wxClassName: STRING);

PROCEDURE SaveControlOrientation(ControlOrientation:
TWxControlOrientation);
FUNCTION GetBorderAlignment: TWxBorderAlignment;
PROCEDURE SetBorderAlignment(border: TWxBorderAlignment);
FUNCTION GetBorderWidth: INTEGER;
PROCEDURE SetBorderWidth(width: INTEGER);
FUNCTION GetStretchFactor: INTEGER;
PROCEDURE SetStretchFactor(intValue: INTEGER);

FUNCTION GetFGColor: STRING;
PROCEDURE SetFGColor(strValue: STRING);
FUNCTION GetBGColor: STRING;
PROCEDURE SetBGColor(strValue: STRING);
FUNCTION GetGenericColor(strVariableName: STRING): STRING;
PROCEDURE SetGenericColor(strVariableName, strValue: STRING);
END;

IWxDesignerFormInterface = INTERFACE
['{3e8e18a0-6515-11db-bd13-0800200c9a66}']
FUNCTION GetFormName: STRING;
PROCEDURE SetFormName(StrValue: STRING);
END;

IWxDialogNonInsertableInterface = INTERFACE
['{AED02C7A-E2E5-4BFD-AF42-080D4D07027C}']
        //procedure DummySizerNonInsertableInterfaceProcedure;
END;

IWxToolBarInsertableInterface = INTERFACE
['{5B1BDAFE-76E9-4C84-A694-0D99C6D17BC4}']
        //procedure DummyToolBarInsertableInterfaceProcedure;
END;

IWxToolBarNonInsertableInterface = INTERFACE
['{6A81CF27-1269-4BD6-9C5D-16F88293B66B}']
        //procedure DummyToolBarNonInsertableInterfaceProcedure;
END;

IWxWindowInterface = INTERFACE
['{3164E818-E7FA-423B-B342-C89D8AF23617}']

END;

IWxContainerAndSizerInterface = INTERFACE
['{2C8662AE-7C13-4C96-81F6-32B195ABE1C9}']
FUNCTION GenerateLastCreationCode: STRING;
END;

IWxContainerInterface = INTERFACE
['{1149F8B7-04D7-466F-96FA-74C7383F2EFD}']
END;

IWxToolBarInterface = INTERFACE
['{518BF32C-F961-4148-B506-F60A9D21AD15}']
FUNCTION GetRealizeString: STRING;
END;

IWxStatusBarInterface = INTERFACE
['{4E9800A3-D948-4F48-A109-7F81B69ECAD3}']
END;

IWxMenuBarInterface = INTERFACE
['{b74eeaf0-7f08-11db-9fe1-0800200c9a66}']
FUNCTION GenerateXPM(strFileName: STRING): BOOLEAN;
END;

IWxCollectionInterface = INTERFACE
['{DC147ECD-47A2-4334-A113-CD9B794CBCE1}']
FUNCTION GetMaxID: INTEGER;
END;

IWxVariableAssignmentInterface = INTERFACE
['{624949E8-E46C-4EF9-B4DA-BC8532617513}']
FUNCTION GetLHSVariableAssignment: STRING;
FUNCTION GetRHSVariableAssignment: STRING;
END;

IWxValidatorInterface = INTERFACE
['{782949E8-47A2-4BA9-E4CA-CA9B832ADCA1}']
FUNCTION GetValidator: STRING;
PROCEDURE SetValidator(value: STRING);
END;

IWxSplitterInterface = INTERFACE
['{900F32A7-3864-4827-9039-85C053504BDB}']
END;

IWxControlPanelInterface = INTERFACE
['{077d51a0-6628-11db-bd13-0800200c9a66}']
END;

IWxThirdPartyComponentInterface = INTERFACE
['{ead81650-6903-11db-bd13-0800200c9a66}']
FUNCTION GetHeaderLocation: STRING;
FUNCTION GetLibName(CompilerTye: INTEGER): STRING;
FUNCTION IsLibAddedAtEnd(CompilerTye: INTEGER): BOOLEAN;
END;

IWxImageContainerInterface = INTERFACE
['{10619130-6bd4-11db-bd13-0800200c9a66}']
FUNCTION GetBitmapCount: INTEGER;
FUNCTION GetBitmap(Idx: INTEGER; VAR bmp: TBitmap;
VAR PropertyName: STRING): BOOLEAN;
FUNCTION GetPropertyName(Idx: INTEGER): STRING;
FUNCTION PreserveFormat: BOOLEAN;
FUNCTION GetGraphicFileName: STRING;
FUNCTION SetGraphicFileName(strFileName: STRING): BOOLEAN;
END;

IWxAuiManagerInterface = INTERFACE
['{AD6CF99F-7C74-4C13-BBCA-46A0F6486162}']
END;

IWxAuiPaneInfoInterface = INTERFACE
['{7D45A54D-4C39-447E-A484-352EEC1956C5}']
END;


IWxAuiPaneInterface = INTERFACE
['{885FADF9-3EF9-4B00-BC80-204A1349DC94}']
END;

IWxAuiToolBarInterface = INTERFACE
['{313E569A-5F00-423C-A71E-1E3BB3F2FD2A}']
END;

IWxAuiNonInsertableInterface = INTERFACE
['{D8527AE6-9AC3-401E-B86E-6CE96853E47D}']
END;

TWxStdStyleItem = (wxSIMPLE_BORDER, wxDOUBLE_BORDER, wxSUNKEN_BORDER,
wxRAISED_BORDER, wxSTATIC_BORDER, wxTRANSPARENT_WINDOW,
wxTAB_TRAVERSAL, wxWANTS_CHARS,
wxNO_FULL_REPAINT_ON_RESIZE, wxVSCROLL,
wxHSCROLL, wxCLIP_CHILDREN, wxNO_BORDER,
wxALWAYS_SHOW_SB, wxFULL_REPAINT_ON_RESIZE);
TWxStdStyleSet = SET OF TWxStdStyleItem;

TWxBtnStyleItem = (wxBU_AUTODRAW, wxBU_LEFT, wxBU_TOP,
wxBU_RIGHT, wxBU_BOTTOM,
wxBU_EXACTFIT);
TWxBtnStyleSet = SET OF TWxBtnStyleItem;

TWxLbStyleItem = (wxST_ALIGN_LEFT, wxST_ALIGN_RIGHT, wxST_ALIGN_CENTRE,
wxST_NO_AUTORESIZE);
TWxLbStyleSet = SET OF TWxLbStyleItem;

TWxEdtGeneralStyleItem = (wxTE_PROCESS_ENTER, wxTE_PROCESS_TAB,
wxTE_PASSWORD,
wxTE_READONLY, wxTE_RICH, wxTE_RICH2, wxTE_AUTO_URL, wxTE_NO_VSCROLL,
wxTE_NOHIDESEL, wxTE_DONTWRAP, wxTE_LINEWRAP,
wxTE_WORDWRAP, wxTE_CHARWRAP, wxTE_BESTWRAP,
wxTE_CAPITALIZE, wxTE_MULTILINE, wxTE_LEFT,
wxTE_CENTRE, wxTE_RIGHT);
TWxEdtGeneralStyleSet = SET OF TWxEdtGeneralStyleItem;

TWxRichTextStyleItem = (wxRE_READONLY, wxRE_MULTILINE);
TWxRichTextStyleSet = SET OF TWxRichTextStyleItem;

TwxRichTextSLCStyleItem = (wxRICHTEXTSTYLELIST_HIDE_TYPE_SELECTOR);
TwxRichTextSLCStyleSet = SET OF TwxRichTextSLCStyleItem;


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
TWxDlgStyleSet = SET OF TWxDlgStyleItem;

    //class  	wxAnimationCtrl
TWxAnimationCtrlStyleItem = (wxAC_DEFAULT_STYLE, wxAC_NO_AUTORESIZE);
TWxAnimationCtrlStyleSet = SET OF TWxAnimationCtrlStyleItem;

    //class  	wxCustomButton
TWxCBtnPosStyleSubItem = (wxCUSTBUT_LEFT, wxCUSTBUT_RIGHT,
wxCUSTBUT_TOP, wxCUSTBUT_BOTTOM);
TWxCBtnPosStyleSubSet = SET OF TWxCBtnPosStyleSubItem;

TWxCBtnStyleSubItem = (wxCUSTBUT_NOTOGGLE, wxCUSTBUT_BUTTON,
wxCUSTBUT_TOGGLE, wxCUSTBUT_BUT_DCLICK_TOG, wxCUSTBUT_TOG_DCLICK_BUT);
TWxCBtnStyleSubSet = SET OF TWxCBtnStyleSubItem;

TWxCBtnDwgStyleSubItem = (wxCUSTBUT_FLAT);
TWxCBtnDwgStyleSubSet = SET OF TWxCBtnDwgStyleSubItem;

    //class  	wxColourPickerCtrl
TWxClrPickCtrlStyleItem = (wxCLRP_DEFAULT_STYLE, wxCLRP_USE_TEXTCTRL,
wxCLRP_SHOW_LABEL);
TWxClrPickCtrlStyleSet = SET OF TWxClrPickCtrlStyleItem;

    //class  	wxDirPickerCtrl
TWxDirPickCtrlStyleItem = (wxDIRP_DEFAULT_STYLE, wxDIRP_USE_TEXTCTRL,
wxDIRP_DIR_MUST_EXIST, wxDIRP_CHANGE_DIR);
TWxDirPickCtrlStyleSet = SET OF TWxDirPickCtrlStyleItem;

    //class  	wxFilePickerCtrl
TWxFilePickCtrlStyleItem = (wxFLP_DEFAULT_STYLE, wxFLP_USE_TEXTCTRL,
wxFLP_OPEN, wxFLP_SAVE, wxFLP_OVERWRITE_PROMPT, wxFLP_FILE_MUST_EXIST,
wxFLP_CHANGE_DIR);
TWxFilePickCtrlStyleSet = SET OF TWxFilePickCtrlStyleItem;

    //class  	wxFontPickerCtrl
TWxFontPickCtrlStyleItem = (wxFNTP_DEFAULT_STYLE, wxFNTP_USE_TEXTCTRL,
wxFNTP_FONTDESC_AS_LABEL, wxFNTP_USEFONT_FOR_LABEL);
TWxFontPickCtrlStyleSet = SET OF TWxFontPickCtrlStyleItem;

    //newly Added
TWxCmbStyleItem = (wxCB_SIMPLE, wxCB_DROPDOWN, wxCB_READONLY, wxCB_SORT);
TWxCmbStyleSet = SET OF TWxCmbStyleItem;

TWxOwnCmbStyleItem = (wxODCB_DCLICK_CYCLES, wxODCB_STD_CONTROL_PAINT);
TWxOwnCmbStyleSet = SET OF TWxOwnCmbStyleItem;

TWxPickCalStyleItem = (wxDP_SPIN, wxDP_DROPDOWN, wxDP_DEFAULT,
wxDP_ALLOWNONE, wxDP_SHOWCENTURY);
TWxPickCalStyleSet = SET OF TWxPickCalStyleItem;

TWxLBxStyleSubItem = (wxLB_SINGLE, wxLB_MULTIPLE, wxLB_EXTENDED);
TWxLBxStyleSubSet = SET OF TWxLBxStyleSubItem;

TWxLBxStyleItem = (wxLB_HSCROLL, wxLB_ALWAYS_SB, wxLB_NEEDED_SB, wxLB_SORT);
TWxLBxStyleSet = SET OF TWxLBxStyleItem;

TWxCBxStyleItem = (wxCHK_2STATE, wxCHK_3STATE,
wxCHK_ALLOW_3RD_STATE_FOR_USER,
wxALIGN_RIGHT_CB);
TWxCBxStyleSet = SET OF TWxCBxStyleItem;

TWxRBStyleItem = (wxRB_GROUP, wxRB_SINGLE);
TWxRBStyleSet = SET OF TWxRBStyleItem;

TWxGagOrientation = (wxGA_HORIZONTAL, wxGA_VERTICAL);

TWxgagStyleItem = (wxGA_SMOOTH, wxGA_MARQUEE);
TWxgagStyleSet = SET OF TWxgagStyleItem;

TWxsbtnOrientation = (wxSP_HORIZONTAL, wxSP_VERTICAL);

TWxsbtnStyleItem = (wxSP_ARROW_KEYS, wxSP_WRAP);
TWxsbtnStyleSet = SET OF TWxsbtnStyleItem;

TWx_SBOrientation = (wxSB_HORIZONTAL, wxSB_VERTICAL);

TWx_SliderOrientation = (wxSL_HORIZONTAL, wxSL_VERTICAL);
TWx_SliderRange = (wxSL_SELRANGE, wxSL_INVERSE);

TWxsldrStyleItem = (wxSL_AUTOTICKS, wxSL_LABELS, wxSL_LEFT,
wxSL_RIGHT, wxSL_TOP, wxSL_BOTTOM, wxSL_BOTH);
TWxsldrStyleSet = SET OF TWxsldrStyleItem;

TWxHyperLnkStyleItem = (wxHL_ALIGN_LEFT, wxHL_ALIGN_RIGHT,
wxHL_ALIGN_CENTRE, wxHL_CONTEXTMENU, wxHL_DEFAULT_STYLE);
TWxHyperLnkStyleSet = SET OF TWxHyperLnkStyleItem;

TWxcalctrlStyleItem = (wxCAL_SUNDAY_FIRST, wxCAL_MONDAY_FIRST,
wxCAL_SHOW_HOLIDAYS,
wxCAL_NO_YEAR_CHANGE, wxCAL_NO_MONTH_CHANGE,
wxCAL_SHOW_SURROUNDING_WEEKS,
wxCAL_SEQUENTIAL_MONTH_SELECTION);
TWxcalctrlStyleSet = SET OF TWxcalctrlStyleItem;

    //Book controls
    //Notebook
TWxnbxAlignStyleItem = (wxNB_DEFAULT, wxNB_TOP, wxNB_LEFT,
wxNB_RIGHT, wxNB_BOTTOM);
TWxnbxStyleItem = (wxNB_FIXEDWIDTH, wxNB_MULTILINE,
wxNB_NOPAGETHEME, wxNB_FLAT);
TWxnbxStyleSet = SET OF TWxnbxStyleItem;

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
TWxrbxStyleSet = SET OF TWxrbxStyleItem;

TWxsbrStyleItem = (wxST_SIZEGRIP);
TWxsbrStyleSet = SET OF TWxsbrStyleItem;

TWxtbrStyleItem = (wxTB_FLAT, wxTB_DOCKABLE, wxTB_HORIZONTAL,
wxTB_VERTICAL, wxTB_TEXT,
wxTB_NOICONS, wxTB_NODIVIDER, wxTB_NOALIGN, wxTB_HORZ_LAYOUT,
wxTB_HORZ_TEXT);
TWxtbrStyleSet = SET OF TWxtbrStyleItem;

TWxLvView = (wxLC_ICON, wxLC_SMALL_ICON, wxLC_LIST, wxLC_REPORT,
wxLC_VIRTUAL{$IFDEF PRIVATE_BUILD}, wxLC_TILE{$ENDIF});
TWxLVStyleItem = (wxLC_ALIGN_TOP, wxLC_ALIGN_LEFT, wxLC_AUTOARRANGE,
wxLC_EDIT_LABELS, wxLC_GROUPS, wxLC_NO_HEADER, wxLC_NO_SORT_HEADER,
wxLC_SINGLE_SEL, wxLC_SORT_ASCENDING, wxLC_SORT_DESCENDING,
wxLC_HRULES, wxLC_VRULES);
TWxLVStyleSet = SET OF TWxLVStyleItem;

TWxTVStyleItem = (wxTR_EDIT_LABELS, wxTR_NO_BUTTONS, wxTR_HAS_BUTTONS,
wxTR_TWIST_BUTTONS, wxTR_NO_LINES, wxTR_FULL_ROW_HIGHLIGHT,
wxTR_LINES_AT_ROOT, wxTR_HIDE_ROOT, wxTR_ROW_LINES, wxTR_COLUMN_LINES,
wxTR_HAS_VARIABLE_ROW_HEIGHT, wxTR_SINGLE, wxTR_SHOW_ROOT_LABEL_ONLY,
wxTR_MULTIPLE, wxTR_EXTENDED,
wxTR_DEFAULT_STYLE);
TWxTVStyleSet = SET OF TWxTVStyleItem;

TWxScrWinStyleItem = (wxRETAINED);
TWxScrWinStyleSet = SET OF TWxScrWinStyleItem;

TWxHtmlWinStyleItem = (wxHW_SCROLLBAR_NEVER, wxHW_SCROLLBAR_AUTO,
wxHW_NO_SELECTION);
TWxHtmlWinStyleSet = SET OF TWxHtmlWinStyleItem;

TWxSplitterWinStyleItem = (wxSP_3D, wxSP_3DSASH, wxSP_3DBORDER,
wxSP_BORDER, wxSP_NOBORDER, wxSP_NO_XP_THEME, wxSP_PERMIT_UNSPLIT,
wxSP_LIVE_UPDATE);
TWxSplitterWinStyleSet = SET OF TWxSplitterWinStyleItem;

TWxMenuItemStyleItem = (wxMnuItm_Normal, wxMnuItm_Separator,
wxMnuItm_Radio, wxMnuItm_Check, wxMnuItm_History);

TWxToolbottonItemStyleItem = (wxITEM_NORMAL, wxITEM_RADIO, wxITEM_CHECK);

TWxFindReplaceFlagItem = (wxFR_DOWN, wxFR_WHOLEWORD, wxFR_MATCHCASE);
TWxFindReplaceFlagSet = SET OF TWxFindReplaceFlagItem;

TwxFindReplaceDialogStyleItem = (wxFR_REPLACEDIALOG, wxFR_NOUPDOWN,
wxFR_NOMATCHCASE, wxFR_NOWHOLEWORD);
TwxFindReplaceDialogStyleSet = SET OF TwxFindReplaceDialogStyleItem;

TWx_LIOrientation = (wxLI_HORIZONTAL, wxLI_VERTICAL);

    //End of Control Styles

TWxFileDialogType = (wxOPEN, wxSAVE);

TWxFileDialogStyleItem = (wxHIDE_READONLY, wxOVERWRITE_PROMPT, wxMULTIPLE,
wxCHANGE_DIR, wxFILE_MUST_EXIST);
TWxFileDialogStyleSet = SET OF TWxFileDialogStyleItem;

TWxDirDialogStyleItem = (wxDD_NEW_DIR_BUTTON);
TWxDirDialogStyleSet = SET OF TWxDirDialogStyleItem;

TWxProgressDialogStyleItem =
(wxPD_APP_MODAL, wxPD_AUTO_HIDE, wxPD_CAN_ABORT, wxPD_ELAPSED_TIME,
wxPD_ESTIMATED_TIME, wxPD_REMAINING_TIME, wxPD_SMOOTH, wxPD_CAN_SKIP);
TWxProgressDialogStyleSet = SET OF TWxProgressDialogStyleItem;

TWxMessageDialogStyleItem = (wxOK, wxCANCEL, wxYES_NO, wxYES_DEFAULT,
wxNO_DEFAULT, wxICON_EXCLAMATION, wxICON_HAND, wxICON_ERROR,
wxICON_QUESTION,
wxICON_INFORMATION, wxCENTRE);
TWxMessageDialogStyleSet = SET OF TWxMessageDialogStyleItem;

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
TWxMediaCtrlControls = SET OF TWxMediaCtrlControl;

    //wxAUI styles etc.
TwxAuiManagerFlag = (wxAUI_MGR_ALLOW_FLOATING, wxAUI_MGR_ALLOW_ACTIVE_PANE,
wxAUI_MGR_TRANSPARENT_DRAG,
wxAUI_MGR_TRANSPARENT_HINT,
wxAUI_MGR_VENETIAN_BLINDS_HINT, wxAUI_MGR_RECTANGLE_HINT,
wxAUI_MGR_HINT_FADE,
wxAUI_MGR_NO_VENETIAN_BLINDS_FADE);
TwxAuiManagerFlagSet = SET OF TwxAuiManagerFlag;

TwxAuiPaneDockDirectionItem = (wxAUI_DOCK_NONE, wxAUI_DOCK_TOP,
wxAUI_DOCK_RIGHT, wxAUI_DOCK_BOTTOM, wxAUI_DOCK_LEFT, wxAUI_DOCK_CENTER);
    //mn later perhaps  TwxAuiPaneDockDirectionSet = set of TwxAuiPaneDockDirectionItem;

TwxAuiPaneDockableDirectionItem = (TopDockable, RightDockable,
BottomDockable, LeftDockable);
TwxAuiPaneDockableDirectionSet = SET OF TwxAuiPaneDockableDirectionItem;

TwxAuiPaneStyleItem = (CaptionVisible, DestroyOnClose, DockFixed,
Floatable, Gripper, GripperTop, Movable, PaneBorder, Resizable,
ToolbarPane, CenterPane);
TwxAuiPaneStyleSet = SET OF TwxAuiPaneStyleItem;

TwxAuiPaneButtonItem = (CloseButton, MaximizeButton,
MinimizeButton, PinButton);
TwxAuiPaneButtonSet = SET OF TwxAuiPaneButtonItem;

TWxAuiTbrStyleItem = (wxAUI_TB_TEXT, wxAUI_TB_NO_TOOLTIPS,
wxAUI_TB_NO_AUTORESIZE, wxAUI_TB_GRIPPER,
wxAUI_TB_OVERFLOW, wxAUI_TB_VERTICAL, wxAUI_TB_HORZ_TEXT,
wxAUI_TB_DEFAULT_STYLE);
TWxAuiTbrStyleSet = SET OF TWxAuiTbrStyleItem;

    //Notebook
TWxAuinbxAlignStyleItem =
(wxAUI_NB_TOP, {wxAUI_NB_LEFT, wxAUI_NB_RIGHT, } wxAUI_NB_BOTTOM);
TWxAuinbxStyleItem = (wxAUI_NB_TAB_SPLIT, wxAUI_NB_TAB_MOVE,
wxAUI_NB_TAB_EXTERNAL_MOVE, wxAUI_NB_TAB_FIXED_WIDTH,
wxAUI_NB_SCROLL_BUTTONS, wxAUI_NB_WINDOWLIST_BUTTON, wxAUI_NB_CLOSE_BUTTON,
wxAUI_NB_CLOSE_ON_ACTIVE_TAB, wxAUI_NB_CLOSE_ON_ALL_TABS);
TWxAuinbxStyleSet = SET OF TWxAuinbxStyleItem;

TWxColorString = CLASS
PUBLIC
FstrColorValue: STRING;
PUBLISHED
PROPERTY strColorValue: STRING READ FstrColorValue WRITE FstrColorValue;
END;

TWxValidatorString = CLASS(TComponent)
PUBLIC
FstrValidatorValue: STRING;
FValidatorType: INTEGER;
FFilterType: INTEGER;
FValidatorVarName: STRING;
CONSTRUCTOR Create(Owner: TComponent); OVERRIDE;

PUBLISHED
PROPERTY strValidatorValue: STRING
READ FstrValidatorValue WRITE FstrValidatorValue;
END;

    // Added 11 May 2005 - Tony
TWxFileNameString = CLASS
PUBLIC
FstrFileNameValue: STRING;
PUBLISHED
PROPERTY strFileNameValue: STRING READ FstrFileNameValue
WRITE FstrFileNameValue;
END;

    // Added 1 May 2008 - Mal
TWxAnimationFileNameString = CLASS
PUBLIC
FstrFileNameValue: STRING;
PUBLISHED
PROPERTY strFileNameValue: STRING READ FstrFileNameValue
WRITE FstrFileNameValue;
END;

TWxJvInspectorTStringsItem = CLASS(TJvCustomInspectorItem)
PROTECTED
PROCEDURE ContentsChanged(Sender: TObject);
FUNCTION GetDisplayValue: STRING; OVERRIDE;
PROCEDURE Edit; OVERRIDE;
PROCEDURE SetDisplayValue(CONST Value: STRING); OVERRIDE;
PROCEDURE SetFlags(CONST Value: TInspectorItemFlags); OVERRIDE;
PUBLIC
CONSTRUCTOR Create(CONST AParent: TJvCustomInspectorItem;
CONST AData: TJvCustomInspectorData); OVERRIDE;
PUBLIC
CLASS PROCEDURE RegisterAsDefaultItem;
END;

TJvInspectorColorEditItem = CLASS(TJvCustomInspectorItem)
PROTECTED
PROCEDURE Edit; OVERRIDE;

FUNCTION GetDisplayValue: STRING; OVERRIDE;
PROCEDURE SetDisplayValue(CONST Value: STRING); OVERRIDE;
PROCEDURE SetFlags(CONST Value: TInspectorItemFlags); OVERRIDE;
PUBLIC
CLASS PROCEDURE RegisterAsDefaultItem;
END;

    // Added 11 May 2005 by Tony
TJvInspectorFileNameEditItem = CLASS(TJvCustomInspectorItem)
PROTECTED
PROCEDURE Edit; OVERRIDE;
FUNCTION GetDisplayValue: STRING; OVERRIDE;
PROCEDURE SetFlags(CONST Value: TInspectorItemFlags); OVERRIDE;
PUBLIC
CLASS PROCEDURE RegisterAsDefaultItem;
END;

    // Added 1 May 2008 by Mal needed for Animation Control
TJvInspectorAnimationFileNameEditItem = CLASS(TJvCustomInspectorItem)
PROTECTED
PROCEDURE Edit; OVERRIDE;
FUNCTION GetDisplayValue: STRING; OVERRIDE;
PROCEDURE SetFlags(CONST Value: TInspectorItemFlags); OVERRIDE;
PUBLIC
CLASS PROCEDURE RegisterAsDefaultItem;
END;

TJvInspectorListItemsItem = CLASS(TJvCustomInspectorItem)
PROTECTED
PROCEDURE Edit; OVERRIDE;

FUNCTION GetDisplayValue: STRING; OVERRIDE;
PROCEDURE SetDisplayValue(CONST Value: STRING); OVERRIDE;
PROCEDURE SetFlags(CONST Value: TInspectorItemFlags); OVERRIDE;
PUBLIC
CLASS PROCEDURE RegisterAsDefaultItem;
END;

TJvInspectorListColumnsItem = CLASS(TJvCustomInspectorItem)
PROTECTED
PROCEDURE Edit; OVERRIDE;

FUNCTION GetDisplayValue: STRING; OVERRIDE;
PROCEDURE SetDisplayValue(CONST Value: STRING); OVERRIDE;
PROCEDURE SetFlags(CONST Value: TInspectorItemFlags); OVERRIDE;
PUBLIC
CLASS PROCEDURE RegisterAsDefaultItem;
END;

TJvInspectorStatusBarItem = CLASS(TJvCustomInspectorItem)
PROTECTED
PROCEDURE Edit; OVERRIDE;

FUNCTION GetDisplayValue: STRING; OVERRIDE;
PROCEDURE SetDisplayValue(CONST Value: STRING); OVERRIDE;
PROCEDURE SetFlags(CONST Value: TInspectorItemFlags); OVERRIDE;
PUBLIC
CLASS PROCEDURE RegisterAsDefaultItem;
END;

TJvInspectorTreeNodesItem = CLASS(TJvCustomInspectorItem)
PROTECTED
PROCEDURE Edit; OVERRIDE;

FUNCTION GetDisplayValue: STRING; OVERRIDE;
PROCEDURE SetDisplayValue(CONST Value: STRING); OVERRIDE;
PROCEDURE SetFlags(CONST Value: TInspectorItemFlags); OVERRIDE;
PUBLIC
CLASS PROCEDURE RegisterAsDefaultItem;
END;

TJvInspectorBitmapItem = CLASS(TJvCustomInspectorItem)
PROTECTED
PROCEDURE Edit; OVERRIDE;

FUNCTION GetDisplayValue: STRING; OVERRIDE;
PROCEDURE SetDisplayValue(CONST Value: STRING); OVERRIDE;
PROCEDURE SetFlags(CONST Value: TInspectorItemFlags); OVERRIDE;
PUBLIC
CLASS PROCEDURE RegisterAsDefaultItem;
END;

TJvInspectorMyFontItem = CLASS(TJvCustomInspectorItem)
PROTECTED
PROCEDURE Edit; OVERRIDE;

FUNCTION GetDisplayValue: STRING; OVERRIDE;
PROCEDURE SetDisplayValue(CONST Value: STRING); OVERRIDE;
PROCEDURE SetFlags(CONST Value: TInspectorItemFlags); OVERRIDE;
PUBLIC
CLASS PROCEDURE RegisterAsDefaultItem;
END;

TJvInspectorMenuItem = CLASS(TJvCustomInspectorItem)
PROTECTED
PROCEDURE Edit; OVERRIDE;

FUNCTION GetDisplayValue: STRING; OVERRIDE;
PROCEDURE SetDisplayValue(CONST Value: STRING); OVERRIDE;
PROCEDURE SetFlags(CONST Value: TInspectorItemFlags); OVERRIDE;
PUBLIC
CLASS PROCEDURE RegisterAsDefaultItem;
END;

TJvInspectorValidatorItem = CLASS(TJvCustomInspectorItem)
PROTECTED
PROCEDURE ContentsChanged(Sender: TObject);
FUNCTION GetDisplayValue: STRING; OVERRIDE;
PROCEDURE Edit; OVERRIDE;
PROCEDURE SetFlags(CONST Value: TInspectorItemFlags); OVERRIDE;
PROCEDURE SetDisplayValue(CONST Value: STRING); OVERRIDE;

PUBLIC
CONSTRUCTOR Create(CONST AParent: TJvCustomInspectorItem;
CONST AData: TJvCustomInspectorData); OVERRIDE;
CLASS PROCEDURE RegisterAsDefaultItem;
END;

FUNCTION UnixPathToDosPath(CONST Path: STRING): STRING;
FUNCTION LocalConvertLibsToCurrentVersion(strValue: STRING): STRING;
FUNCTION Convert25LibsToCurrentVersion(strValue: STRING): STRING;
FUNCTION Convert26LibsToCurrentVersion(strValue: STRING): STRING;

FUNCTION GetExtension(FileName: STRING): STRING;

FUNCTION GetGridSelectionToString(grdsel: TWxGridSelection): STRING;
FUNCTION GetStdStyleString(stdStyle: TWxStdStyleSet): STRING;
FUNCTION GetComboxBoxStyleString(stdStyle: TWxCmbStyleSet): STRING;
FUNCTION GetOwnComboxBoxStyleString(stdStyle: TWxOwnCmbStyleSet): STRING;
FUNCTION GetCheckboxStyleString(stdStyle: TWxcbxStyleSet): STRING;
FUNCTION GetTreeviewStyleString(stdStyle: TWxTVStyleSet): STRING;
FUNCTION GetRadiobuttonStyleString(stdStyle: TWxrbStyleSet): STRING;
FUNCTION GetListboxStyleString(stdStyle: TWxlbxStyleSet): STRING;
FUNCTION GetGaugeStyleString(stdStyle: TWxgagStyleSet): STRING;
FUNCTION GetScrollbarStyleString(stdStyle: TWxsbrStyleSet): STRING;
FUNCTION GetSpinButtonStyleString(stdStyle: TWxsbtnStyleSet): STRING;
FUNCTION GetSliderStyleString(stdStyle: TWxsldrStyleSet): STRING;
FUNCTION GetHyperLnkStyleString(stdStyle: TWxHyperLnkStyleSet): STRING;
FUNCTION GetPickCalStyleString(stdStyle: TWxPickCalStyleSet): STRING;
FUNCTION GetCalendarCtrlStyleString(stdStyle: TWxcalctrlStyleSet): STRING;
//function GetChoicebookStyleString(stdStyle: TWxchbxStyleSet): string;
//function GetListbookStyleString(stdStyle: TWxlbbxStyleSet): string;
FUNCTION GetNotebookStyleString(stdStyle: TWxnbxStyleSet): STRING;
FUNCTION GetAuiNotebookStyleString(stdStyle: TWxAuinbxStyleSet): STRING;
//function GetToolbookStyleString(stdStyle: TWxtlbxStyleSet): string;
//function GetTreebookStyleString(stdStyle: TWxtrbxStyleSet): string;
FUNCTION GetRadioBoxStyleString(stdStyle: TWxrbxStyleSet): STRING;
FUNCTION GetStatusBarStyleString(stdStyle: TWxsbrStyleSet): STRING;
FUNCTION GetToolBarStyleString(stdStyle: TWxtbrStyleSet): STRING;
FUNCTION GetScrolledWindowStyleString(stdStyle: TWxScrWinStyleSet): STRING;
FUNCTION GetHtmlWindowStyleString(stdStyle: TWxHtmlWinStyleSet): STRING;
FUNCTION GetSplitterWindowStyleString(stdStyle:
TWxSplitterWinStyleSet): STRING;
FUNCTION GetFileDialogStyleString(stdStyle: TWxFileDialogStyleSet): STRING;
FUNCTION GetDirDialogStyleString(stdStyle: TWxDirDialogStyleSet): STRING;
FUNCTION GetProgressDialogStyleString(stdStyle:
TWxProgressDialogStyleSet): STRING;
FUNCTION GetTextEntryDialogStyleString(stdStyle: TWxMessageDialogStyleSet;
edtStyle: TWxEdtGeneralStyleSet): STRING;
FUNCTION GetMediaCtrlStyle(mediaStyle: TWxMediaCtrlControl): STRING;
FUNCTION GetMediaCtrlStyleString(mediaStyle: TWxMediaCtrlControls): STRING;
FUNCTION GetMessageDialogStyleString(stdStyle: TWxMessageDialogStyleSet;
NoEndComma: BOOLEAN): STRING;
FUNCTION GetFindReplaceFlagString(stdstyle: TWxFindReplaceFlagSet): STRING;
FUNCTION GetFindReplaceDialogStyleString(stdstyle:
TWxFindReplaceDialogStyleSet): STRING;

FUNCTION GetCheckboxSpecificStyle(stdstyle: TWxStdStyleSet;
cbxstyle: TWxcbxStyleSet): STRING;
FUNCTION GetTreeviewSpecificStyle(stdstyle: TWxStdStyleSet;
tvstyle: TWxTvStyleSet): STRING;
FUNCTION GetRadiobuttonSpecificStyle(stdstyle: TWxStdStyleSet;
rbstyle: TWxrbStyleSet): STRING;
FUNCTION GetListboxSpecificStyle(stdstyle: TWxStdStyleSet;
lbxstyle: TWxlbxStyleSet): STRING;
FUNCTION GetGaugeSpecificStyle(stdstyle: TWxStdStyleSet;
gagstyle: TWxgagStyleSet): STRING;
FUNCTION GetScrollbarSpecificStyle(stdstyle: TWxStdStyleSet;
scbrstyle: TWxsbrStyleSet): STRING;
FUNCTION GetHyperLnkSpecificStyle(stdstyle: TWxStdStyleSet;
edtstyle: TWxHyperLnkStyleSet): STRING;
FUNCTION GetSpinButtonSpecificStyle(stdstyle: TWxStdStyleSet;
sbtnstyle: TWxsbtnStyleSet;
edtstyle: TWxEdtGeneralStyleSet): STRING;
FUNCTION GetSliderSpecificStyle(stdstyle: TWxStdStyleSet;
sldrstyle: TWxsldrStyleSet): STRING;
FUNCTION GetDateVariableExpansion(value: TDateTime): STRING;
FUNCTION GetCalendarCtrlSpecificStyle(stdstyle: TWxStdStyleSet;
calctrlstyle: TWxcalctrlStyleSet): STRING;
FUNCTION GetPickCalSpecificStyle(stdstyle: TWxStdStyleSet;
calctrlstyle: TWxPickCalStyleSet): STRING;

FUNCTION GetRTSListCtrlStyleString(stdStyle: TwxRichTextSLCStyleSet): STRING;
FUNCTION GetRTSListCtrlSpecificStyle(stdstyle: TWxStdStyleSet;
lbxstyle: TwxRichTextSLCStyleSet): STRING;

FUNCTION GetChoicebookSpecificStyle(stdstyle:
TWxStdStyleSet{; bookalign: TWxchbxAlignStyleItem; cbbxstyle: TWxchbxStyleSet}): STRING;
FUNCTION GetChoiceAlignmentString(Value: TWxchbxAlignStyleItem): STRING;

{function GetListbookSpecificStyle(stdstyle: TWxStdStyleSet; lbbxstyle: TWxlbbxStyleSet): string; }
FUNCTION GetListbookSpecificStyle(stdstyle:
TWxStdStyleSet{; bookalign: TWxlbbxAlignStyleItem}): STRING;
FUNCTION GetListAlignment(Value: TWxlbbxAlignStyleItem): STRING;

FUNCTION GetNotebookSpecificStyle(stdstyle: TWxStdStyleSet;
    {bookalign: TWxnbxAlignStyleItem;} nbxstyle: TWxnbxStyleSet): STRING;
FUNCTION GetAuiNotebookSpecificStyle(stdstyle: TWxStdStyleSet;
    {bookalign: TWxnbxAlignStyleItem;} nbxstyle: TWxAuinbxStyleSet): STRING;
FUNCTION GetTabAlignmentString(Value: TWxnbxAlignStyleItem): STRING;

FUNCTION GetToolbookSpecificStyle(stdstyle:
TWxStdStyleSet{; tlbxstyle: TWxtlbxStyleSet}): STRING;

{function GetTreebookSpecificStyle(stdstyle: TWxStdStyleSet;
  trbxstyle: TWxtrbxStyleSet): string;    }
FUNCTION GetTreebookSpecificStyle(stdstyle:
TWxStdStyleSet{; bookalign: TWxtrbxAlignStyleItem}): STRING;
FUNCTION GetTreeAlignment(Value: TWxtrbxAlignStyleItem): STRING;

FUNCTION GetRadioBoxSpecificStyle(stdstyle: TWxStdStyleSet;
rbxstyle: TWxrbxStyleSet): STRING;
FUNCTION GetStatusBarSpecificStyle(stdstyle: TWxStdStyleSet;
sbrstyle: TWxsbrStyleSet): STRING;
FUNCTION GetToolBarSpecificStyle(stdstyle: TWxStdStyleSet;
tbrstyle: TWxtbrStyleSet): STRING;
FUNCTION GetAuiToolBarSpecificStyle(stdstyle: TWxStdStyleSet;
tbrstyle: TWxAuiTbrStyleSet): STRING;
FUNCTION GetScrolledWindowSpecificStyle(stdstyle: TWxStdStyleSet;
scrWinStyle: TWxScrWinStyleSet): STRING;
FUNCTION GetHtmlWindowSpecificStyle(stdstyle: TWxStdStyleSet;
htmlWinStyle: TWxHtmlWinStyleSet): STRING;
FUNCTION GetSplitterWindowSpecificStyle(stdstyle: TWxStdStyleSet;
splitterWinStyle: TWxSplitterWinStyleSet): STRING;
FUNCTION GetRichTextSpecificStyle(stdstyle: TWxStdStyleSet;
dlgstyle: TWxRichTextStyleSet): STRING;
FUNCTION GetListViewSpecificStyle(stdstyle: TWxStdStyleSet;
lstvwstyle: TWxLVStyleSet; view: TWxLvView): STRING;
FUNCTION GetEditSpecificStyle(stdstyle: TWxStdStyleSet;
dlgstyle: TWxEdtGeneralStyleSet): STRING;
FUNCTION GetAnimationCtrlSpecificStyle(stdstyle:
TWxStdStyleSet{;
  dlgstyle: TWxAnimationCtrlStyleSet}): STRING;
FUNCTION GetButtonSpecificStyle(stdstyle: TWxStdStyleSet;
dlgstyle: TWxBtnStyleSet): STRING;
FUNCTION GetLabelSpecificStyle(stdstyle: TWxStdStyleSet;
dlgstyle: TWxLbStyleSet): STRING;
FUNCTION GetcomboBoxSpecificStyle(stdstyle: TWxStdStyleSet;
cmbstyle: TWxCmbStyleSet; edtstyle: TWxEdtGeneralStyleSet): STRING;
FUNCTION GetOwncomboBoxSpecificStyle(stdstyle: TWxStdStyleSet;
cmbstyle: TWxCmbStyleSet; edtstyle: TWxEdtGeneralStyleSet;
owncmbstyle: TWxOwnCmbStyleSet): STRING;
FUNCTION GetStdDialogButtonsSpecificStyle(btnstyle:
TWxStdDialogButtons): STRING;
FUNCTION GetDialogSpecificStyle(stdstyle: TWxStdStyleSet;
dlgstyle: TWxDlgStyleSet; wxclassname: STRING): STRING;

PROCEDURE PopulateGenericProperties(VAR PropertyList: TStringList);
PROCEDURE PopulateAuiGenericProperties(VAR PropertyList: TStringList);
FUNCTION SizerAlignmentToStr(SizerAlignment: TWxSizerAlignmentSet): STRING;
OVERLOAD;
FUNCTION BorderAlignmentToStr(BorderAlignment: TWxBorderAlignment): STRING;
FUNCTION RGBFormatStrToColor(strColorValue: STRING): TColor;
FUNCTION GetColorFromString(strColorValue: STRING): TColor;
FUNCTION GetGeneralColorFromString(strColorValue: STRING): TColor;
FUNCTION IsDefaultColorStr(strvalue: STRING): BOOLEAN;
FUNCTION GetwxColorFromString(strValue: STRING): STRING;
FUNCTION PaperIDToString(sizeitem: TWxPaperSizeItem): STRING;

FUNCTION IsControlWxSizer(ctrl: TControl): BOOLEAN;
FUNCTION IsControlWxContainer(ctrl: TControl): BOOLEAN;
FUNCTION IsControlWxWindow(ctrl: TControl): BOOLEAN;
FUNCTION IsControlWxToolBar(ctrl: TControl): BOOLEAN;
FUNCTION IsControlWxStatusBar(ctrl: TControl): BOOLEAN;
FUNCTION IsControlWxNonVisible(ctrl: TControl): BOOLEAN;
FUNCTION GetNonVisualComponentCount(frmMainObj: TForm): INTEGER;
FUNCTION IsControlWxAuiManager(ctrl: TControl): BOOLEAN;
FUNCTION IsControlWxAuiToolBar(ctrl: TControl): BOOLEAN;

FUNCTION GetWxIDString(strID: STRING; intID: LONGINT): STRING;
FUNCTION IsValidClass(COMP: TComponent): BOOLEAN;
FUNCTION GetEventNameFromDisplayName(strDisplayName: STRING;
strlst: TStringList): STRING;
FUNCTION AlignmentToStr(taPos: TAlignment): STRING;
PROCEDURE ChangeControlZOrder(Sender: TObject; MoveUp: BOOLEAN = TRUE);
FUNCTION GetXPMFromTPicture(XPMName: STRING; delphiBitmap: TBitmap): STRING;
FUNCTION GetXPMFromTPictureXXX(XPMName: STRING; delphiBitmap: TBitmap): STRING;
FUNCTION GenerateXPMDirectly(bmp: TBitmap; strCompName: STRING;
strParentName: STRING; strFileName: STRING): BOOLEAN;
FUNCTION OpenXPMImage(InpImage: TBitmap; strFname: STRING): BOOLEAN;
FUNCTION GetCppString(str: STRING): STRING;
FUNCTION GetWxPosition(Left: INTEGER; Top: INTEGER): STRING;
FUNCTION GetWxSize(Width: INTEGER; Height: INTEGER): STRING;
FUNCTION GetWxEnum(Wx_IDValue: INTEGER; Wx_IDName: STRING): STRING;
FUNCTION GetCommentString(str: STRING): STRING;
FUNCTION GetWxFontDeclaration(fnt: TFont): STRING;
FUNCTION GetDesignerFormName(cntrl: TControl): STRING;
FUNCTION GetWxWidgetParent(cntrl: TControl; AuiManaged: BOOLEAN): STRING;
FUNCTION GetWxWindowControls(wnCtrl: TWinControl): INTEGER;
FUNCTION GetAvailableControlCount(ParentControl: TWinControl;
ControlToCheck: TComponent): INTEGER; OVERLOAD;
FUNCTION GetAvailableControlCount(ParentControl: TWinControl;
ControlToCheck: STRING): INTEGER; OVERLOAD;
FUNCTION GetMaxIDofWxForm(ParentControl: TWinControl): INTEGER;
FUNCTION GetMenuKindAsText(menuStyle: TWxMenuItemStyleItem): STRING;
FUNCTION GetToolButtonKindAsText(toolStyle:
TWxToolbottonItemStyleItem): STRING;

FUNCTION GetTotalHtOfAllToolBarAndStatusBar(ParentControl:
TWinControl): INTEGER;
FUNCTION GetPredefinedwxIds: TStringList;
FUNCTION IsIDPredefined(str: STRING; strlst: TStringList): BOOLEAN;

FUNCTION XML_Label(str: STRING): STRING;
FUNCTION CreateBlankXRC: TStringList;
FUNCTION GetWxMonthFromIndex(MonthIndex: INTEGER): STRING;
FUNCTION GetDateToString(dt: TDateTime): STRING;

FUNCTION GetLongName(CONST ShortPathName: STRING): STRING;
// EAB TODO: Copied from utils. Check if we can place it in a single common place.
FUNCTION ValidateClassName(ClassName: STRING): INTEGER;
// EAB TODO: Copied from utils. Check if we can place it in a single common place.
FUNCTION CreateValidClassName(ClassName: STRING): STRING;
// EAB TODO: Copied from utils. Check if we can place it in a single common place.
FUNCTION ValidateFileName(FileName: STRING): INTEGER;
// EAB TODO: Copied from utils. Check if we can place it in a single common place.
FUNCTION CreateValidFileName(FileName: STRING): STRING;
// EAB TODO: Copied from utils. Check if we can place it in a single common place.

FUNCTION GetAuiManagerName(Control: TControl): STRING;
FUNCTION FormHasAuiManager(Control: TControl): BOOLEAN;
FUNCTION GetAuiDockDirection(Wx_Aui_Dock_Direction:
TwxAuiPaneDockDirectionItem): STRING;
FUNCTION GetAuiDockableDirections(Wx_Aui_Dockable_Direction:
TwxAuiPaneDockableDirectionSet): STRING;
FUNCTION GetAui_Pane_Style(Wx_Aui_Pane_Style: TwxAuiPaneStyleSet): STRING;
FUNCTION GetAui_Pane_Buttons(Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet): STRING;
FUNCTION GetAuiRow(row: INTEGER): STRING;
FUNCTION GetAuiPosition(position: INTEGER): STRING;
FUNCTION GetAuiLayer(layer: INTEGER): STRING;
FUNCTION GetAuiPaneBestSize(width: INTEGER; height: INTEGER): STRING;
FUNCTION GetAuiPaneMinSize(width: INTEGER; height: INTEGER): STRING;
FUNCTION GetAuiPaneMaxSize(width: INTEGER; height: INTEGER): STRING;
FUNCTION GetAuiPaneFloatingSize(width: INTEGER; height: INTEGER): STRING;
FUNCTION GetAuiPaneFloatingPos(x: INTEGER; y: INTEGER): STRING;
FUNCTION GetAuiPaneCaption(caption: STRING): STRING;
FUNCTION GetAuiPaneName(name: STRING): STRING;
FUNCTION HasToolbarPaneStyle(Wx_Aui_Pane_Style: TwxAuiPaneStyleSet): BOOLEAN;
FUNCTION GetRefinedWxEdtGeneralStyleValue(
sValue: TWxEdtGeneralStyleSet): TWxEdtGeneralStyleSet;

IMPLEMENTATION

USES DesignerFrm, wxlistCtrl, WxStaticBitmap, WxBitmapButton,
WxSizerPanel, WxToolButton,
UColorEdit, UMenuitem, WxCustomMenuItem, WxPopupMenu, WxMenuBar,
WxCustomButton, WxTreeCtrl,
WxNonVisibleBaseComponent, wxdesigner, wxnotebook, wxAUInotebook,
OpenSaveDialogs, wxAuiManager, wxAuiNoteBookPage
{$IFDEF WIN32}
, ShlObj, ActiveX
{$ENDIF}
;

FUNCTION ExtractComponentPropertyName(CONST S: STRING): STRING;
VAR
SepaPos: INTEGER;
BEGIN
Result := '';
SepaPos := Pos(':', S);
IF SepaPos > 1 THEN
Result := Copy(S, 1, SepaPos - 1);
END;

FUNCTION CreateGraphicFileDir(strFileName: STRING): STRING;
VAR
strDir: STRING;
fileDir: STRING;
workingDir: STRING;
BEGIN

strDir := '';
fileDir := IncludetrailingPathDelimiter(ExtractFileDir(strFileName));

    // Get current working directory
workingDir := GetCurrentDir;
    // If working directory already contained within fileDir, then
    //    don't add it again.
IF AnsiContainsStr(fileDir, workingDir) THEN
workingDir := '';

    // See if file directory exists
IF DirectoryExists(fileDir) THEN
strDir := fileDir

    // Try working directory plus file directory
ELSE
IF DirectoryExists(workingDir + pd + fileDir) THEN
strDir := workingDir + pd + fileDir
ELSE
BEGIN
        // Try to force the directory creation
IF ForceDirectories(workingDir + pd + fileDir) THEN
strDir := workingDir + pd + fileDir
ELSE

ShowMessage('ERROR: Can''t create directory ' +
workingDir + pd + fileDir);

END;

strDir := IncludetrailingPathDelimiter(strDir);

    //strDir := AnsiReplaceText(strDir, '\', '/');

Result := strDir;

END;

FUNCTION CreateGraphicFileName(strFileName: STRING): STRING;
BEGIN

strFileName := CreateGraphicFileDir(strFileName)
+ ExtractFileName(strFileName);

strFileName := AnsiReplaceText(strFileName, '\', '/');

Result := strFileName;

END;

FUNCTION ExtractComponentPropertyCaption(CONST S: STRING): STRING;
VAR
SepaPos: INTEGER;
BEGIN
Result := '';
IF S = '' THEN
Exit;
SepaPos := Pos(':', S);
IF SepaPos > 1 THEN
Result := Copy(S, SepaPos + 1, Length(S));
END;

FUNCTION iswxForm(FileName: STRING): BOOLEAN;
BEGIN
IF LowerCase(ExtractFileExt(FileName)) = LowerCase(WXFORM_EXT) THEN
Result := TRUE
ELSE
result := FALSE;
END;

{function isRCExt(FileName: string): boolean;
begin
  if LowerCase(ExtractFileExt(FileName)) = LowerCase(RC_EXT) then
    Result := true
  else
    result := False;
end;}

FUNCTION isXRCExt(FileName: STRING): BOOLEAN;
BEGIN
IF LowerCase(ExtractFileExt(FileName)) = LowerCase(XRC_EXT) THEN
Result := TRUE
ELSE
result := FALSE;
END;

FUNCTION SaveStringToFile(strContent, strFileName: STRING): BOOLEAN;
VAR
strStringList: TStringList;
BEGIN
Result := TRUE;
strStringList := TStringList.Create;
strStringList.Text := strContent;
TRY
strStringList.SaveToFile(strFileName);
EXCEPT
Result := FALSE;
END;
strStringList.Destroy;
END;

CONSTRUCTOR TWxValidatorString.Create(Owner: TComponent);
BEGIN
INHERITED;
END;

FUNCTION TranslateChar(CONST Str: STRING; FromChar, ToChar: CHAR): STRING;
VAR
I: INTEGER;
BEGIN
Result := Str;
FOR I := 1 TO Length(Result) DO
IF Result[I] = FromChar THEN
Result[I] := ToChar;
END;

FUNCTION UnixPathToDosPath(CONST Path: STRING): STRING;
BEGIN
Result := TranslateChar(Path, '/', '\');
END;

FUNCTION LocalConvertLibsToCurrentVersion(strValue: STRING): STRING;
BEGIN
Result := Convert25LibsToCurrentVersion(strValue);
Result := Convert26LibsToCurrentVersion(Result);
    //Auto -mwindows flag addition
IF AnsiContainsText(Result, '-lwxmsw') AND
(AnsiContainsText(Result, '-mwindows') = FALSE) THEN
BEGIN
Result := '-mwindows_@@_' + Result;
END;
END;

FUNCTION Convert25LibsToCurrentVersion(strValue: STRING): STRING;
BEGIN
Result := StringReplace(strValue, 'wxmsw25', 'wxmsw27', [rfReplaceAll]);
END;

FUNCTION Convert26LibsToCurrentVersion(strValue: STRING): STRING;
BEGIN
Result := StringReplace(strValue, 'wxmsw26', 'wxmsw27', [rfReplaceAll]);
END;

FUNCTION GetDateToString(dt: TDateTime): STRING;
VAR
AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: WORD;
BEGIN
DecodeDateTime(dt, AYear, AMonth, ADay, AHour, AMinute, ASecond,
AMilliSecond);
Result := Format('%d/%d/%d', [AMonth, ADay, AYear]);
END;

FUNCTION GetWxMonthFromIndex(MonthIndex: INTEGER): STRING;
BEGIN
CASE MonthIndex OF
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
END;
END;

FUNCTION XML_Label(str: STRING): STRING;
BEGIN

    // Some string characters need to be changed for the XRC format
    // See http://cvs.wxwidgets.org/viewcvs.cgi/wxWidgets/docs/tech/tn0014.txt?rev=1.18&content-type=text/vnd.viewcvs-markup
    // Section 3. "Common attribute types", Subsection "String"
strChange(str, '_', '__');
strChange(str, '&', '_');
strChange(str, '/', '//');
Result := str;

END;

FUNCTION GetTotalHtOfAllToolBarAndStatusBar(ParentControl:
TWinControl): INTEGER;
VAR
I: INTEGER;
BEGIN
Result := 0;
FOR I := 0 TO ParentControl.ControlCount - 1 DO // Iterate
BEGIN
IF NOT (IsControlWxToolBar(ParentControl.Controls[i]) OR
IsControlWxStatusBar(ParentControl.Controls[i])) THEN
continue;
Result := Result + ParentControl.Controls[i].Height;
END; // for
END;

FUNCTION IsIDPredefined(str: STRING; strlst: TStringList): BOOLEAN;
BEGIN
IF strlst.IndexOf(str) <> -1 THEN
Result := TRUE
ELSE
Result := FALSE;
END;

FUNCTION GetPredefinedwxIds: TStringList;
BEGIN
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
END;

FUNCTION GetGridSelectionToString(grdsel: TWxGridSelection): STRING;
BEGIN
Result := 'wxGridSelectCells';
IF grdsel = wxGridSelectCells THEN
Result := 'wxGridSelectCells';
IF grdsel = wxGridSelectColumns THEN
Result := 'wxGridSelectColumns';
IF grdsel = wxGridSelectRows THEN
Result := 'wxGridSelectRows';

END;

FUNCTION GetWxFontDeclaration(fnt: TFont): STRING;
VAR
strStyle, strWeight, strUnderline: STRING;
BEGIN
IF (fnt.Name = Screen.HintFont.Name) AND
(fnt.Size = Screen.HintFont.Size) AND
(fnt.Style = Screen.HintFont.Style) THEN
Result := ''
ELSE
BEGIN
IF fsItalic IN fnt.Style THEN
strStyle := 'wxITALIC'
ELSE
strStyle := 'wxNORMAL';

IF fsBold IN fnt.Style THEN
strWeight := 'wxBOLD'
ELSE
strWeight := 'wxNORMAL';

IF fsUnderline IN fnt.Style THEN
strUnderline := 'true'
ELSE
strUnderline := 'false';

IF fnt.Name <> Screen.IconFont.Name THEN
Result := Format('wxFont(%d, wxSWISS, %s, %s, %s, %s)',
[fnt.Size, strStyle, strWeight, strUnderline, GetCppString(fnt.Name)])
ELSE
Result := Format('wxFont(%d, wxSWISS, %s, %s, %s)',
[fnt.Size, strStyle, strWeight, strUnderline]);
END;
END;

FUNCTION GetDesignerFormName(cntrl: TControl): STRING;
VAR
ParentCtrl, PrevParentCtrl: TControl;

BEGIN
ParentCtrl := cntrl.Parent;
IF ParentCtrl = NIL THEN
BEGIN
IF cntrl IS TfrmNewForm THEN
BEGIN
Result := TfrmNewForm(cntrl).Wx_Name;
exit;
END;
END;

WHILE (ParentCtrl <> NIL) DO
BEGIN
PrevParentCtrl := ParentCtrl;
ParentCtrl := ParentCtrl.Parent;
IF ParentCtrl = NIL THEN
BEGIN
IF PrevParentCtrl IS TfrmNewForm THEN
Result := TfrmNewForm(PrevParentCtrl).Wx_Name
ELSE
Result := '';
exit;
END;
END;

END;

FUNCTION GetWxWidgetParent(cntrl: TControl; AuiManaged: BOOLEAN): STRING;
VAR
TestCtrl: TControl;
BEGIN
Result := '';
IF cntrl = NIL THEN
exit;

IF cntrl.Parent = NIL THEN
exit;

IF cntrl.Parent IS TForm THEN
BEGIN
Result := 'this';
exit;
END;

    {mn
    if not (cntrl.Parent is TwxSizerPanel) then
    begin
      Result := cntrl.Parent.Name;
      exit;
    end;
  mn}

IF (AuiManaged AND NOT (cntrl.Parent IS TWxSizerPanel))
    // protect ourselves from idiots
    {or (cntrl.Parent is TWxAuiNoteBookPage)} THEN
BEGIN
Result := 'this';
Exit;
END;

IF (cntrl.Parent IS TWxAuiNoteBookPage) THEN
BEGIN
Result := cntrl.Parent.Parent.Name;
Exit;
END;

IF (cntrl.Parent IS TWxSizerPanel) THEN
BEGIN
TestCtrl := cntrl.Parent;
Result := TestCtrl.Name;
WHILE ((TestCtrl IS TWxSizerPanel)) DO
BEGIN
IF (TestCtrl IS TWxSizerPanel) THEN
TestCtrl := TestCtrl.Parent;

IF TestCtrl = NIL THEN
BEGIN
Result := 'this';
break;
END;
IF (TestCtrl IS TForm) THEN
Result := 'this'
ELSE
Result := TestCtrl.Name;
END;
Exit;
END;

IF (cntrl.Parent IS TWxNotebook) OR (cntrl.Parent IS TWxAuiNotebook) THEN
BEGIN
Result := cntrl.Parent.Name;
exit;

END;

IF (cntrl.Parent IS TPageControl) THEN
        //we assume compound tool/choice/list/tool/tree-books
BEGIN
Result := GetWxWidgetParent(cntrl.Parent, FALSE);
        //this should return the grandparent
exit;
END
ELSE
BEGIN
Result := cntrl.Parent.Name;
exit;
END;

END;

FUNCTION GetWxWindowControls(wnCtrl: TWinControl): INTEGER;
VAR
I: INTEGER;
wndInterface: IWxWindowInterface;
BEGIN
Result := 0;
FOR I := 0 TO wnCtrl.ComponentCount - 1 DO // Iterate
IF wnCtrl.Components[i].GetInterface(IID_IWxWindowInterface,
wndInterface) THEN
Inc(Result); // for
END;

FUNCTION GetMaxIDofWxForm(ParentControl: TWinControl): INTEGER;
VAR
wxcompInterface: IWxComponentInterface;
I: INTEGER;
BEGIN
Result := 0;
FOR I := 0 TO ParentControl.ComponentCount - 1 DO // Iterate
IF ParentControl.Components[I].GetInterface(IID_IWxComponentInterface,
wxcompInterface) THEN
IF wxcompInterface.GetIDValue > Result THEN
Result := wxcompInterface.GetIDValue;

    // Fix for erroneously large ID values
IF (Result > 32768) THEN
BEGIN

Result := 1001;
FOR I := 0 TO ParentControl.ComponentCount - 1 DO // Iterate
IF ParentControl.Components[I].GetInterface(IID_IWxComponentInterface,
wxcompInterface) THEN
BEGIN
wxcompInterface.SetIDValue(Result);
Result := Result + 1;
END;
END;

IF Result = 0 THEN
Result := 1000;

END;

FUNCTION GetMenuKindAsText(menuStyle: TWxMenuItemStyleItem): STRING;
BEGIN
Result := 'wxITEM_NORMAL';
IF menuStyle = wxMnuItm_Normal THEN
BEGIN
Result := 'wxITEM_NORMAL';
exit;
END;

IF menuStyle = wxMnuItm_Separator THEN
BEGIN
Result := 'wxITEM_SEPARATOR';
exit;
END;
IF menuStyle = wxMnuItm_Radio THEN
BEGIN
Result := 'wxITEM_RADIO';
exit;
END;
IF menuStyle = wxMnuItm_Check THEN
BEGIN
Result := 'wxITEM_CHECK';
exit;
END;

END;

FUNCTION GetToolButtonKindAsText(toolStyle:
TWxToolbottonItemStyleItem): STRING;
BEGIN
Result := 'wxITEM_NORMAL';
IF toolStyle = wxITEM_NORMAL THEN
BEGIN
Result := 'wxITEM_NORMAL';
exit;
END;

IF toolStyle = wxITEM_RADIO THEN
BEGIN
Result := 'wxITEM_RADIO';
exit;
END;

IF toolStyle = wxITEM_CHECK THEN
BEGIN
Result := 'wxITEM_CHECK';
exit;
END;

END;

FUNCTION GetAvailableControlCount(ParentControl: TWinControl;
ControlToCheck: STRING): INTEGER; OVERLOAD;
VAR
I: INTEGER;
BEGIN
Result := 0;
FOR I := 0 TO ParentControl.ComponentCount - 1 DO // Iterate
IF strContainsU(ParentControl.Components[i].ClassName, ControlToCheck) THEN
Inc(Result); // for
END;

FUNCTION GetAvailableControlCount(ParentControl: TWinControl;
ControlToCheck: TComponent): INTEGER; OVERLOAD;
VAR
I: INTEGER;
BEGIN
Result := 0;
FOR I := 0 TO ParentControl.ComponentCount - 1 DO // Iterate
IF strContainsU(ParentControl.Components[i].ClassName,
ControlToCheck.ClassName) THEN
Inc(Result); // for
END;

FUNCTION GetEventNameFromDisplayName(strDisplayName: STRING;
strlst: TStringList): STRING;
VAR
I: INTEGER;
strEventName, strEventCaption: STRING;
intPos: INTEGER;
BEGIN
Result := '';
FOR i := 0 TO strlst.Count - 1 DO // Iterate
BEGIN
intPos := Pos(':', strlst[i]);
strEventName := Copy(strlst[i], 0, intPos - 1);
strEventCaption := Trim(Copy(strlst[i], intPos + 1, Length(strlst[i])));
IF AnsiSameText(strEventCaption, strDisplayName) THEN
Result := strEventName;
END; // for
END;

FUNCTION IsValidClass(COMP: TComponent): BOOLEAN;
VAR
intfObj: IWxComponentInterface;
BEGIN
Result := COMP.GetInterface(IID_IWxComponentInterface, intfObj);
END;

//Here is the start

FUNCTION GetCheckboxStyleString(stdStyle: TWxcbxStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN
strLst := TStringList.Create;

TRY

IF wxCHK_2STATE IN stdStyle THEN
strLst.add('wxCHK_2STATE ');

IF wxCHK_3STATE IN stdStyle THEN
strLst.add('wxCHK_3STATE ');

IF wxCHK_ALLOW_3RD_STATE_FOR_USER IN stdStyle THEN
strLst.add('wxCHK_ALLOW_3RD_STATE_FOR_USER');

IF wxALIGN_RIGHT_CB IN stdStyle THEN
strLst.add('wxALIGN_RIGHT');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetTreeviewStyleString(stdStyle: TWxtvStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN
strLst := TStringList.Create;

TRY
IF wxTR_EDIT_LABELS IN stdStyle THEN
strLst.add('wxTR_EDIT_LABELS');

IF wxTR_NO_BUTTONS IN stdStyle THEN
strLst.add('wxTR_NO_BUTTONS');

IF wxTR_HAS_BUTTONS IN stdStyle THEN
strLst.add('wxTR_HAS_BUTTONS');

IF wxTR_TWIST_BUTTONS IN stdStyle THEN
strLst.add('wxTR_TWIST_BUTTONS');

IF wxTR_NO_LINES IN stdStyle THEN
strLst.add('wxTR_NO_LINES');

IF wxTR_FULL_ROW_HIGHLIGHT IN stdStyle THEN
strLst.add('wxTR_FULL_ROW_HIGHLIGHT');

IF wxTR_LINES_AT_ROOT IN stdStyle THEN
strLst.add('wxTR_LINES_AT_ROOT');

IF wxTR_HIDE_ROOT IN stdStyle THEN
strLst.add('wxTR_HIDE_ROOT');

IF wxTR_ROW_LINES IN stdStyle THEN
strLst.add('wxTR_ROW_LINES');

IF wxTR_HAS_VARIABLE_ROW_HEIGHT IN stdStyle THEN
strLst.add('wxTR_HAS_VARIABLE_ROW_HEIGHT');

IF wxTR_SINGLE IN stdStyle THEN
strLst.add('wxTR_SINGLE');

IF wxTR_MULTIPLE IN stdStyle THEN
strLst.add('wxTR_MULTIPLE');

IF wxTR_EXTENDED IN stdStyle THEN
strLst.add('wxTR_EXTENDED');

IF wxTR_DEFAULT_STYLE IN stdStyle THEN
strLst.add('wxTR_DEFAULT_STYLE');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetRadiobuttonStyleString(stdStyle: TWxrbStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxRB_GROUP IN stdStyle THEN
strLst.add('wxRB_GROUP');

IF wxRB_SINGLE IN stdStyle THEN
strLst.add('wxRB_SINGLE');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetRTSListCtrlStyleString(stdStyle: TwxRichTextSLCStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN
strLst := TStringList.Create;

TRY
IF wxRICHTEXTSTYLELIST_HIDE_TYPE_SELECTOR IN stdStyle THEN
strLst.add('wxRICHTEXTSTYLELIST_HIDE_TYPE_SELECTOR');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
FINALLY
strLst.Destroy;
END;
END;


FUNCTION GetListboxStyleString(stdStyle: TWxlbxStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN
strLst := TStringList.Create;

TRY
        // if wxLB_SINGLE  in stdStyle then
        //   strLst.add('wxLB_SINGLE');

        // if wxLB_MULTIPLE  in stdStyle then
        //  strLst.add('wxLB_MULTIPLE');

        // if wxLB_EXTENDED   in stdStyle then
        //   strLst.add('wxLB_EXTENDED');

IF wxLB_HSCROLL IN stdStyle THEN
strLst.add('wxLB_HSCROLL');

IF wxLB_ALWAYS_SB IN stdStyle THEN
strLst.add('wxLB_ALWAYS_SB');

IF wxLB_NEEDED_SB IN stdStyle THEN
strLst.add('wxLB_NEEDED_SB');

IF wxLB_SORT IN stdStyle THEN
strLst.add('wxLB_SORT');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetGaugeStyleString(stdStyle: TWxgagStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxGA_SMOOTH IN stdStyle THEN
strLst.add('wxGA_SMOOTH');

IF wxGA_MARQUEE IN stdStyle THEN
strLst.add('wxGA_MARQUEE');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);

FINALLY
strLst.Destroy;
END;

END;

FUNCTION GetScrollbarStyleString(stdStyle: TWxsbrStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxST_SIZEGRIP IN stdStyle THEN
strLst.add('wxST_SIZEGRIP');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);

FINALLY
strLst.Destroy;
END;

END;

FUNCTION GetSpinButtonStyleString(stdStyle: TWxsbtnStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxSP_ARROW_KEYS IN stdStyle THEN
strLst.add('wxSP_ARROW_KEYS');

IF wxSP_WRAP IN stdStyle THEN
strLst.add('wxSP_WRAP');

        { if wxSP_HORIZONTAL in stdStyle then
       strLst.add('wxSP_HORIZONTAL');

     if wxSP_VERTICAL in stdStyle then
       strLst.add('wxSP_VERTICAL');
     }
IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;

END;

FUNCTION GetHyperLnkStyleString(stdStyle: TWxHyperLnkStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN
strLst := TStringList.Create;
TRY
IF wxHL_ALIGN_LEFT IN stdStyle THEN
strLst.add('wxHL_ALIGN_LEFT');

IF wxHL_ALIGN_RIGHT IN stdStyle THEN
strLst.add('wxHL_ALIGN_RIGHT');

IF wxHL_ALIGN_CENTRE IN stdStyle THEN
strLst.add('wxHL_ALIGN_CENTRE');

IF wxHL_CONTEXTMENU IN stdStyle THEN
strLst.add('wxHL_CONTEXTMENU');

IF wxHL_DEFAULT_STYLE IN stdStyle THEN
strLst.add('wxHL_DEFAULT_STYLE');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetSliderStyleString(stdStyle: TWxsldrStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxSL_AUTOTICKS IN stdStyle THEN
strLst.add('wxSL_AUTOTICKS');

IF wxSL_LABELS IN stdStyle THEN
strLst.add('wxSL_LABELS');

IF wxSL_LEFT IN stdStyle THEN
strLst.add('wxSL_LEFT');

IF wxSL_RIGHT IN stdStyle THEN
strLst.add('wxSL_RIGHT');

IF wxSL_TOP IN stdStyle THEN
strLst.add('wxSL_TOP');

IF wxSL_BOTTOM IN stdStyle THEN
strLst.add('wxSL_BOTTOM');

IF wxSL_BOTH IN stdStyle THEN
strLst.add('wxSL_BOTH');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetPickCalStyleString(stdStyle: TWxPickCalStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxDP_SPIN IN stdStyle THEN
strLst.add('wxDP_SPIN');

IF wxDP_DROPDOWN IN stdStyle THEN
strLst.add('wxDP_DROPDOWN');

IF wxDP_DEFAULT IN stdStyle THEN
strLst.add('wxDP_DEFAULT');

IF wxDP_ALLOWNONE IN stdStyle THEN
strLst.add('wxDP_ALLOWNONE');

IF wxDP_SHOWCENTURY IN stdStyle THEN
strLst.add('wxDP_SHOWCENTURY');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetCalendarCtrlStyleString(stdStyle: TWxcalctrlStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxCAL_SUNDAY_FIRST IN stdStyle THEN
strLst.add('wxCAL_SUNDAY_FIRST');

IF wxCAL_MONDAY_FIRST IN stdStyle THEN
strLst.add('wxCAL_MONDAY_FIRST');

IF wxCAL_SHOW_HOLIDAYS IN stdStyle THEN
strLst.add('wxCAL_SHOW_HOLIDAYS');

IF wxCAL_NO_YEAR_CHANGE IN stdStyle THEN
strLst.add('wxCAL_NO_YEAR_CHANGE');

IF wxCAL_NO_MONTH_CHANGE IN stdStyle THEN
strLst.add('wxCAL_NO_MONTH_CHANGE');

IF wxCAL_SHOW_SURROUNDING_WEEKS IN stdStyle THEN
strLst.add('wxCAL_SHOW_SURROUNDING_WEEKS');

IF wxCAL_SEQUENTIAL_MONTH_SELECTION IN stdStyle THEN
strLst.add('wxCAL_SEQUENTIAL_MONTH_SELECTION');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;

END;

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

FUNCTION GetNotebookStyleString(stdStyle: TWxnbxStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY

IF wxNB_FIXEDWIDTH IN stdStyle THEN
strLst.add('wxNB_FIXEDWIDTH');

IF wxNB_MULTILINE IN stdStyle THEN
strLst.add('wxNB_MULTILINE');

IF wxNB_NOPAGETHEME IN stdStyle THEN
strLst.add('wxNB_NOPAGETHEME');

IF wxNB_FLAT IN stdStyle THEN
strLst.add('wxNB_FLAT');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);

FINALLY
strLst.Destroy;
END;

END;

FUNCTION GetAuiNotebookStyleString(stdStyle: TWxAuinbxStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY

IF wxAUI_NB_TAB_SPLIT IN stdStyle THEN
strLst.add('wxAUI_NB_TAB_SPLIT');

IF wxAUI_NB_TAB_MOVE IN stdStyle THEN
strLst.add('wxAUI_NB_TAB_MOVE');

IF wxAUI_NB_TAB_EXTERNAL_MOVE IN stdStyle THEN
strLst.add('wxAUI_NB_TAB_EXTERNAL_MOVE');

IF wxAUI_NB_TAB_FIXED_WIDTH IN stdStyle THEN
strLst.add('wxAUI_NB_TAB_FIXED_WIDTH');

IF wxAUI_NB_SCROLL_BUTTONS IN stdStyle THEN
strLst.add('wxAUI_NB_SCROLL_BUTTONS');

IF wxAUI_NB_WINDOWLIST_BUTTON IN stdStyle THEN
strLst.add('wxAUI_NB_WINDOWLIST_BUTTON');

IF wxAUI_NB_CLOSE_BUTTON IN stdStyle THEN
strLst.add('wxAUI_NB_CLOSE_BUTTON');

IF wxAUI_NB_CLOSE_ON_ACTIVE_TAB IN stdStyle THEN
strLst.add('wxAUI_NB_CLOSE_ON_ACTIVE_TAB');

IF wxAUI_NB_CLOSE_ON_ALL_TABS IN stdStyle THEN
strLst.add('wxAUI_NB_CLOSE_ON_ALL_TABS');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);

FINALLY
strLst.Destroy;
END;

END;

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

FUNCTION GetRadioBoxStyleString(stdStyle: TWxrbxStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxRA_SPECIFY_ROWS IN stdStyle THEN
strLst.add('wxRA_SPECIFY_ROWS');

IF wxRA_SPECIFY_COLS IN stdStyle THEN
strLst.add('wxRA_SPECIFY_COLS');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetStatusBarStyleString(stdStyle: TWxsbrStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxST_SIZEGRIP IN stdStyle THEN
strLst.add('wxST_SIZEGRIP');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetToolBarStyleString(stdStyle: TWxtbrStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN
strLst := TStringList.Create;

TRY
IF wxTB_FLAT IN stdStyle THEN
strLst.add('wxTB_FLAT');

IF wxTB_DOCKABLE IN stdStyle THEN
strLst.add('wxTB_DOCKABLE');

IF wxTB_HORIZONTAL IN stdStyle THEN
strLst.add('wxTB_HORIZONTAL');

IF wxTB_VERTICAL IN stdStyle THEN
strLst.add('wxTB_VERTICAL');

IF wxTB_TEXT IN stdStyle THEN
strLst.add('wxTB_TEXT');

IF wxTB_NOICONS IN stdStyle THEN
strLst.add('wxTB_NOICONS');

IF wxTB_NODIVIDER IN stdStyle THEN
strLst.add('wxTB_NODIVIDER');

IF wxTB_NOALIGN IN stdStyle THEN
strLst.add('wxTB_NOALIGN');

IF wxTB_HORZ_LAYOUT IN stdStyle THEN
strLst.add('wxTB_HORZ_LAYOUT');

IF wxTB_HORZ_TEXT IN stdStyle THEN
strLst.add('wxTB_HORZ_TEXT');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetScrolledWindowStyleString(stdStyle: TWxScrWinStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN
strLst := TStringList.Create;

TRY
IF wxRETAINED IN stdStyle THEN
strLst.add('wxRETAINED');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);

FINALLY
strLst.Destroy;
END;

END;

FUNCTION GetHtmlWindowStyleString(stdStyle: TWxHtmlWinStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY

IF wxHW_SCROLLBAR_NEVER IN stdStyle THEN
strLst.add('wxHW_SCROLLBAR_NEVER');

IF wxHW_SCROLLBAR_AUTO IN stdStyle THEN
strLst.add('wxHW_SCROLLBAR_AUTO');

IF wxHW_NO_SELECTION IN stdStyle THEN
strLst.add('wxHW_NO_SELECTION ');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);

FINALLY
strLst.Destroy;
END;

END;

FUNCTION GetSplitterWindowStyleString(stdStyle:
TWxSplitterWinStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxSP_3D IN stdStyle THEN
strLst.add('wxSP_3D');

IF wxSP_3DSASH IN stdStyle THEN
strLst.add('wxSP_3DSASH');

IF wxSP_3DBORDER IN stdStyle THEN
strLst.add('wxSP_3DBORDER ');

IF wxSP_BORDER IN stdStyle THEN
strLst.add('wxSP_BORDER');

IF wxSP_NOBORDER IN stdStyle THEN
strLst.add('wxSP_NOBORDER');

IF wxSP_NO_XP_THEME IN stdStyle THEN
strLst.add('wxSP_NO_XP_THEME ');

IF wxSP_PERMIT_UNSPLIT IN stdStyle THEN
strLst.add('wxSP_PERMIT_UNSPLIT');

IF wxSP_LIVE_UPDATE IN stdStyle THEN
strLst.add('wxSP_LIVE_UPDATE');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);

FINALLY
strLst.Destroy;
END;

END;

FUNCTION GetFileDialogStyleString(stdStyle: TWxFileDialogStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxHIDE_READONLY IN stdStyle THEN
strLst.add('wxFD_HIDE_READONLY');

IF wxOVERWRITE_PROMPT IN stdStyle THEN
strLst.add('wxFD_OVERWRITE_PROMPT');

IF wxFILE_MUST_EXIST IN stdStyle THEN
strLst.add('wxFD_FILE_MUST_EXIST');

IF wxMULTIPLE IN stdStyle THEN
strLst.add('wxFD_MULTIPLE');

IF wxCHANGE_DIR IN stdStyle THEN
strLst.add('wxFD_CHANGE_DIR');

IF strLst.Count = 0 THEN
Result := ''
ELSE
BEGIN
Result := ' | ';
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i]; // for
END;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;

END;

FUNCTION GetDirDialogStyleString(stdStyle: TWxDirDialogStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxDD_NEW_DIR_BUTTON IN stdStyle THEN
strLst.add('wxDD_NEW_DIR_BUTTON');

IF strLst.Count = 0 THEN
Result := ''
ELSE
BEGIN
Result := ', ';
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i]; // for
END;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;

END;

FUNCTION GetProgressDialogStyleString(stdStyle:
TWxProgressDialogStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxPD_APP_MODAL IN stdStyle THEN
strLst.add('wxPD_APP_MODAL');

IF wxPD_SMOOTH IN stdStyle THEN
strLst.add('wxPD_SMOOTH');

IF wxPD_CAN_SKIP IN stdStyle THEN
strLst.add('wxPD_CAN_SKIP');

IF wxPD_AUTO_HIDE IN stdStyle THEN
strLst.add('wxPD_AUTO_HIDE');

IF wxPD_CAN_ABORT IN stdStyle THEN
strLst.add('wxPD_CAN_ABORT ');

IF wxPD_ELAPSED_TIME IN stdStyle THEN
strLst.add('wxPD_ELAPSED_TIME ');

IF wxPD_ESTIMATED_TIME IN stdStyle THEN
strLst.add('wxPD_ESTIMATED_TIME');

IF wxPD_REMAINING_TIME IN stdStyle THEN
strLst.add('wxPD_REMAINING_TIME ');

IF strLst.Count = 0 THEN
Result := ''
ELSE
BEGIN
Result := ', ';
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i]; // for
END;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;

END;

FUNCTION GetMediaCtrlStyle(mediaStyle: TWxMediaCtrlControl): STRING;
BEGIN
IF wxMEDIACTRLPLAYERCONTROLS_NONE = mediaStyle THEN
Result := 'wxMEDIACTRLPLAYERCONTROLS_NONE';

IF wxMEDIACTRLPLAYERCONTROLS_STEP = mediaStyle THEN
Result := 'wxMEDIACTRLPLAYERCONTROLS_STEP';

IF wxMEDIACTRLPLAYERCONTROLS_VOLUME = mediaStyle THEN
Result := 'wxMEDIACTRLPLAYERCONTROLS_VOLUME';

END;

FUNCTION GetMediaCtrlStyleString(mediaStyle: TWxMediaCtrlControls): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxMEDIACTRLPLAYERCONTROLS_NONE IN mediaStyle THEN
strLst.add('wxMEDIACTRLPLAYERCONTROLS_NONE');

IF wxMEDIACTRLPLAYERCONTROLS_STEP IN mediaStyle THEN
strLst.add('wxMEDIACTRLPLAYERCONTROLS_STEP');

IF wxMEDIACTRLPLAYERCONTROLS_VOLUME IN mediaStyle THEN
strLst.add('wxMEDIACTRLPLAYERCONTROLS_VOLUME');

IF strLst.Count = 0 THEN
Result := ''
ELSE
BEGIN
Result := ' ';
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i]; // for
END;
        //sendDebug(Result);

FINALLY
strLst.Destroy;
END;

END;

FUNCTION GetMessageDialogStyleString(stdStyle: TWxMessageDialogStyleSet;
NoEndComma: BOOLEAN): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxOK IN stdStyle THEN
strLst.add('wxOK');

IF wxCANCEL IN stdStyle THEN
strLst.add('wxCANCEL');

IF wxYES_NO IN stdStyle THEN
strLst.add('wxYES_NO');

IF wxYES_DEFAULT IN stdStyle THEN
strLst.add('wxYES_DEFAULT');

IF wxNO_DEFAULT IN stdStyle THEN
strLst.add('wxNO_DEFAULT');

IF wxICON_EXCLAMATION IN stdStyle THEN
strLst.add('wxICON_EXCLAMATION');

IF wxICON_HAND IN stdStyle THEN
strLst.add('wxICON_HAND');

IF wxICON_ERROR IN stdStyle THEN
strLst.add('wxICON_ERROR');

IF wxICON_QUESTION IN stdStyle THEN
strLst.add('wxICON_QUESTION');

IF wxICON_INFORMATION IN stdStyle THEN
strLst.add('wxICON_INFORMATION');

IF wxCENTRE IN stdStyle THEN
strLst.add('wxCENTRE');

IF strLst.Count = 0 THEN
Result := ''
ELSE
BEGIN
Result := ' ';
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i]; // for
END;
        //sendDebug(Result);

FINALLY
strLst.Destroy;
END;

IF (Result <> '') AND (NoEndComma = FALSE) THEN
BEGIN
Result := ',' + Result;
END;
END;

FUNCTION GetFindReplaceFlagString(stdstyle: TWxFindReplaceFlagSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY

IF wxFR_DOWN IN stdStyle THEN
strLst.add('wxFR_DOWN');

IF wxFR_WHOLEWORD IN stdStyle THEN
strLst.add('wxFR_WHOLEWORD');

IF wxFR_MATCHCASE IN stdStyle THEN
strLst.add('wxFR_MATCHCASE ');

IF strLst.Count = 0 THEN
Result := ''
ELSE
BEGIN
Result := '';
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i]; // for
END;
        //sendDebug(Result);

FINALLY
strLst.Destroy;
END;

END;

FUNCTION GetFindReplaceDialogStyleString(stdstyle:
TWxFindReplaceDialogStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxFR_REPLACEDIALOG IN stdStyle THEN
strLst.add('wxFR_REPLACEDIALOG');

IF wxFR_NOUPDOWN IN stdStyle THEN
strLst.add('wxFR_NOUPDOWN ');

IF wxFR_NOMATCHCASE IN stdStyle THEN
strLst.add('wxFR_NOMATCHCASE');

IF wxFR_NOWHOLEWORD IN stdStyle THEN
strLst.add('wxFR_NOWHOLEWORD');

IF strLst.Count = 0 THEN
Result := ''
ELSE
BEGIN
Result := ', ';
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i]; // for
END;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;

END;

//Here is the end;

FUNCTION GetComboxBoxStyleString(stdStyle: TWxCmbStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxCB_SIMPLE IN stdStyle THEN
strLst.add('wxCB_SIMPLE');

IF wxCB_DROPDOWN IN stdStyle THEN
strLst.add('wxCB_DROPDOWN');

IF wxCB_READONLY IN stdStyle THEN
strLst.add('wxCB_READONLY');

IF wxCB_SORT IN stdStyle THEN
strLst.add('wxCB_SORT');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetOwnComboxBoxStyleString(stdStyle: TWxOwnCmbStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxODCB_DCLICK_CYCLES IN stdStyle THEN
strLst.add('wxODCB_DCLICK_CYCLES');

IF wxODCB_STD_CONTROL_PAINT IN stdStyle THEN
strLst.add('wxODCB_STD_CONTROL_PAINT');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetDlgStyleString(stdStyle: TWxDlgStyleSet;
wxclassname: STRING): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY

IF wxCAPTION IN stdStyle THEN
strLst.add('wxCAPTION');

IF wxRESIZE_BORDER IN stdStyle THEN
strLst.add('wxRESIZE_BORDER');

IF wxSYSTEM_MENU IN stdStyle THEN
strLst.add('wxSYSTEM_MENU');

IF wxTHICK_FRAME IN stdStyle THEN
strLst.add('wxTHICK_FRAME');

IF wxSTAY_ON_TOP IN stdStyle THEN
strLst.add('wxSTAY_ON_TOP');

IF strEqual(wxclassname, 'wxDialog') THEN
IF wxDIALOG_NO_PARENT IN stdStyle THEN
strLst.add('wxDIALOG_NO_PARENT');

IF wxDIALOG_EX_CONTEXTHELP IN stdStyle THEN
strLst.add('wxDIALOG_EX_CONTEXTHELP');

IF wxFRAME_EX_CONTEXTHELP IN stdStyle THEN
strLst.add('wxFRAME_EX_CONTEXTHELP');

IF wxMINIMIZE_BOX IN stdStyle THEN
strLst.add('wxMINIMIZE_BOX');

IF wxMAXIMIZE_BOX IN stdStyle THEN
strLst.add('wxMAXIMIZE_BOX');

IF wxCLOSE_BOX IN stdStyle THEN
strLst.add('wxCLOSE_BOX');

IF wxNO_3D IN stdStyle THEN
strLst.add('wxNO_3D');

IF wxMINIMIZE IN stdStyle THEN
strLst.add('wxMINIMIZE');

IF wxMAXIMIZE IN stdStyle THEN
strLst.add('wxMAXIMIZE');

IF wxFRAME_TOOL_WINDOW IN stdStyle THEN
strLst.add('wxFRAME_TOOL_WINDOW');

IF wxFRAME_NO_TASKBAR IN stdStyle THEN
strLst.add('wxFRAME_NO_TASKBAR');

IF wxFRAME_FLOAT_ON_PARENT IN stdStyle THEN
strLst.add('wxFRAME_FLOAT_ON_PARENT');

IF wxFRAME_SHAPED IN stdStyle THEN
strLst.add('wxFRAME_SHAPED');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);

FINALLY
strLst.Destroy;
END;

END;

FUNCTION GetAnimationCtrlStyleString(stdStyle:
TWxAnimationCtrlStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxAC_DEFAULT_STYLE IN stdStyle THEN
strLst.add('wxAC_DEFAULT_STYLE');

IF wxAC_NO_AUTORESIZE IN stdStyle THEN
strLst.add('wxAC_NO_AUTORESIZE');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);

FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetButtonStyleString(stdStyle: TWxBtnStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY
IF wxBU_AUTODRAW IN stdStyle THEN
strLst.add('wxBU_AUTODRAW');

IF wxBU_LEFT IN stdStyle THEN
strLst.add('wxBU_LEFT');

IF wxBU_TOP IN stdStyle THEN
strLst.add('wxBU_TOP');

IF wxBU_RIGHT IN stdStyle THEN
strLst.add('wxBU_RIGHT');

IF wxBU_EXACTFIT IN stdStyle THEN
strLst.add('wxBU_EXACTFIT');

IF wxBU_BOTTOM IN stdStyle THEN
strLst.add('wxBU_BOTTOM');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);

FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetLbStyleString(stdStyle: TWxLbStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY

IF wxST_ALIGN_LEFT IN stdStyle THEN
strLst.add('wxALIGN_LEFT');

IF wxST_ALIGN_RIGHT IN stdStyle THEN
strLst.add('wxALIGN_RIGHT');

IF wxST_ALIGN_CENTRE IN stdStyle THEN
strLst.add('wxALIGN_CENTRE');

IF wxST_NO_AUTORESIZE IN stdStyle THEN
strLst.add('wxST_NO_AUTORESIZE');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;

END;

FUNCTION GetRichTextStyleString(edtdStyle: TWxRichTextStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY

IF wxRE_READONLY IN edtdStyle THEN
strLst.add('wxRE_READONLY');

IF wxRE_MULTILINE IN edtdStyle THEN
strLst.add('wxRE_MULTILINE');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;

END;

FUNCTION GetEdtStyleString(edtdStyle: TWxEdtGeneralStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY

IF wxTE_PROCESS_ENTER IN edtdStyle THEN
strLst.add('wxTE_PROCESS_ENTER');

IF wxTE_PROCESS_TAB IN edtdStyle THEN
strLst.add('wxTE_PROCESS_TAB');

IF wxTE_PASSWORD IN edtdStyle THEN
strLst.add('wxTE_PASSWORD');

IF wxTE_READONLY IN edtdStyle THEN
strLst.add('wxTE_READONLY');

IF wxTE_RICH IN edtdStyle THEN
strLst.add('wxTE_RICH');

IF wxTE_RICH2 IN edtdStyle THEN
strLst.add('wxTE_RICH2');

IF wxTE_AUTO_URL IN edtdStyle THEN
strLst.add('wxTE_AUTO_URL');

IF wxTE_NO_VSCROLL IN edtdStyle THEN
strLst.add('wxTE_NO_VSCROLL');

IF wxTE_NOHIDESEL IN edtdStyle THEN
strLst.add('wxTE_NOHIDESEL');

IF wxTE_LEFT IN edtdStyle THEN
strLst.add('wxTE_LEFT');

IF wxTE_CENTRE IN edtdStyle THEN
strLst.add('wxTE_CENTRE');

IF wxTE_RIGHT IN edtdStyle THEN
strLst.add('wxTE_RIGHT');

IF wxTE_DONTWRAP IN edtdStyle THEN
strLst.add('wxTE_DONTWRAP');

IF wxTE_BESTWRAP IN edtdStyle THEN
strLst.add('wxTE_BESTWRAP');

IF wxTE_CHARWRAP IN edtdStyle THEN
strLst.add('wxTE_CHARWRAP');

IF wxTE_LINEWRAP IN edtdStyle THEN
strLst.add('wxTE_LINEWRAP');

IF wxTE_WORDWRAP IN edtdStyle THEN
strLst.add('wxTE_WORDWRAP');

IF wxTE_CAPITALIZE IN edtdStyle THEN
strLst.add('wxTE_CAPITALIZE');

IF wxTE_MULTILINE IN edtdStyle THEN
strLst.add('wxTE_MULTILINE');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetTextEntryDialogStyleString(stdStyle: TWxMessageDialogStyleSet;
edtStyle: TWxEdtGeneralStyleSet): STRING;
VAR
strA, strB: STRING;
BEGIN
strA := trim(GetMessageDialogStyleString(stdStyle, TRUE));
strB := trim(GetEdtStyleString(edtStyle));

IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

IF strB <> '' THEN
IF trim(Result) = '' THEN
Result := strB
ELSE
Result := Result + ' | ' + strB;

IF Result <> '' THEN
BEGIN
Result := ',' + Result;
END;
END;

FUNCTION GetEditSpecificStyle(stdstyle: TWxStdStyleSet;
dlgstyle: TWxEdtGeneralStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetEdtStyleString(dlgstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetRichTextSpecificStyle(stdstyle: TWxStdStyleSet;
dlgstyle: TWxRichTextStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetRichTextStyleString(dlgstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;
END;

FUNCTION GetcomboBoxSpecificStyle(stdstyle: TWxStdStyleSet;
cmbstyle: TWxCmbStyleSet; edtstyle: TWxEdtGeneralStyleSet): STRING;
VAR
strA: STRING;
strB: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetComboxBoxStyleString(cmbstyle));
strB := trim(GetEdtStyleString(edtstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;
IF strB <> '' THEN
IF trim(Result) = '' THEN
Result := strB
ELSE
Result := Result + ' | ' + strB;
END;

FUNCTION GetOwncomboBoxSpecificStyle(stdstyle: TWxStdStyleSet;
cmbstyle: TWxCmbStyleSet; edtstyle: TWxEdtGeneralStyleSet;
owncmbstyle: TWxOwnCmbStyleSet): STRING;
VAR
strA: STRING;
strB: STRING;
strC: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetComboxBoxStyleString(cmbstyle));
strB := trim(GetEdtStyleString(edtstyle));
strC := trim(GetOwnComboxBoxStyleString(Owncmbstyle));

IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

IF strB <> '' THEN
IF trim(Result) = '' THEN
Result := strB
ELSE
Result := Result + ' | ' + strB;

IF strC <> '' THEN
IF trim(Result) = '' THEN
Result := strC
ELSE
Result := Result + ' | ' + strC;
END;

FUNCTION GetListViewStyleString(lstvwstyle: TWxLVStyleSet;
view: TWxLvView): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN
strLst := TStringList.Create;

CASE view OF
wxLC_LIST:
strLst.add('wxLC_LIST');
wxLC_REPORT:
strLst.add('wxLC_REPORT');
wxLC_VIRTUAL:
BEGIN
strLst.add('wxLC_VIRTUAL');
strLst.add('wxLC_REPORT');
END;
wxLC_ICON:
strLst.add('wxLC_ICON');
wxLC_SMALL_ICON:
strLst.add('wxLC_SMALL_ICON');
{$IFDEF PRIVATE_BUILD}
wxLC_TILE:
strLst.add('wxLC_TILE');
{$ENDIF}
END;

TRY
IF wxLC_ALIGN_TOP IN lstvwstyle THEN
strLst.add('wxLC_ALIGN_TOP');

IF wxLC_ALIGN_LEFT IN lstvwstyle THEN
strLst.add('wxLC_ALIGN_LEFT');

IF wxLC_AUTOARRANGE IN lstvwstyle THEN
strLst.add('wxLC_AUTOARRANGE');

IF wxLC_EDIT_LABELS IN lstvwstyle THEN
strLst.add('wxLC_EDIT_LABELS');

IF wxLC_NO_HEADER IN lstvwstyle THEN
strLst.add('wxLC_NO_HEADER');

IF wxLC_NO_SORT_HEADER IN lstvwstyle THEN
strLst.add('wxLC_NO_SORT_HEADER');

IF wxLC_SINGLE_SEL IN lstvwstyle THEN
strLst.add('wxLC_SINGLE_SEL');

IF wxLC_SORT_ASCENDING IN lstvwstyle THEN
strLst.add('wxLC_SORT_ASCENDING');

IF wxLC_SORT_DESCENDING IN lstvwstyle THEN
strLst.add('wxLC_SORT_DESCENDING');

IF wxLC_HRULES IN lstvwstyle THEN
strLst.add('wxLC_HRULES');

IF wxLC_VRULES IN lstvwstyle THEN
strLst.add('wxLC_VRULES');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i];
FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetListViewSpecificStyle(stdstyle: TWxStdStyleSet;
lstvwstyle: TWxLVStyleSet; view: TWxLvView): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetListViewStyleString(lstvwstyle, view));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
IF strA = '' THEN
Result := Result
ELSE
Result := Result + ' | ' + strA;

    //if trim(Result) <> '' then
    //Result := ', ' + Result;
END;

//Start here

FUNCTION GetCheckboxSpecificStyle(stdstyle: TWxStdStyleSet;
cbxstyle: TWxcbxStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetCheckBoxStyleString(cbxstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetTreeviewSpecificStyle(stdstyle: TWxStdStyleSet;
tvstyle: TWxTVStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetTreeViewStyleString(tvstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetRadiobuttonSpecificStyle(stdstyle: TWxStdStyleSet;
rbstyle: TWxrbStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetRadioButtonStyleString(rbstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetRTSListCtrlSpecificStyle(stdstyle: TWxStdStyleSet;
lbxstyle: TwxRichTextSLCStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetRTSListCtrlStyleString(lbxstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetListboxSpecificStyle(stdstyle: TWxStdStyleSet;
lbxstyle: TWxlbxStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetListBoxStyleString(lbxstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetGaugeSpecificStyle(stdstyle: TWxStdStyleSet;
gagstyle: TWxgagStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetGaugeStyleString(gagstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetScrollbarSpecificStyle(stdstyle: TWxStdStyleSet;
scbrstyle: TWxsbrStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetScrollbarStyleString(scbrstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetHyperLnkSpecificStyle(stdstyle: TWxStdStyleSet;
edtstyle: TWxHyperLnkStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetHyperLnkStyleString(edtstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetSpinButtonSpecificStyle(stdstyle: TWxStdStyleSet;
sbtnstyle: TWxsbtnStyleSet; edtstyle: TWxEdtGeneralStyleSet): STRING;
VAR
strA: STRING;
strB: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetSpinButtonStyleString(sbtnstyle));
strB := trim(GetEdtStyleString(edtstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;
IF strB <> '' THEN
IF trim(Result) = '' THEN
Result := strB
ELSE
Result := Result + ' | ' + strB;
END;

FUNCTION GetSliderSpecificStyle(stdstyle: TWxStdStyleSet;
sldrstyle: TWxsldrStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetSliderStyleString(sldrstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

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

FUNCTION GetDateVariableExpansion(value: TDateTime): STRING;
VAR
Year, Month, Day: WORD;
BEGIN
DecodeDate(value, Year, Month, Day);
Result := Format('wxDateTime(%d,(wxDateTime::Month)%d,%d)',
[Day, Month, Year]);
END;

FUNCTION GetCalendarCtrlSpecificStyle(stdstyle: TWxStdStyleSet;
calctrlstyle: TWxcalctrlStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetCalendarCtrlStyleString(calctrlstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetPickCalSpecificStyle(stdstyle: TWxStdStyleSet;
calctrlstyle: TWxPickCalStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetPickCalStyleString(calctrlstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

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

FUNCTION GetChoicebookSpecificStyle(stdstyle:
TWxStdStyleSet{;
  bookalign: TWxchbxAlignStyleItem;
  cbbxstyle: TWxchbxStyleSet}): STRING;
    //var
    //  strA: string;
BEGIN
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
END;

FUNCTION GetChoiceAlignmentString(Value: TWxchbxAlignStyleItem): STRING;
BEGIN
Result := '';
IF Value = wxCHB_BOTTOM THEN
BEGIN
Result := 'wxCHB_BOTTOM';
exit;
END;
IF Value = wxCHB_RIGHT THEN
BEGIN
Result := 'wxCHB_RIGHT';
exit;
END;
IF Value = wxCHB_LEFT THEN
BEGIN
Result := 'wxCHB_LEFT';
exit;
END;
IF Value = wxCHB_TOP THEN
BEGIN
Result := 'wxCHB_TOP';
exit;
END;
IF Value = wxCHB_DEFAULT THEN
BEGIN
Result := 'wxCHB_DEFAULT';
exit;
END;

END;

{function GetListbookSpecificStyle(stdstyle: TWxStdStyleSet; lbbxstyle: TWxlbbxStyleSet): string;
}
FUNCTION GetListbookSpecificStyle(stdstyle:
TWxStdStyleSet{; bookalign: TWxlbbxAlignStyleItem}): STRING;
    //var
    //  strA: string;
BEGIN
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
END;

FUNCTION GetListAlignment(Value: TWxlbbxAlignStyleItem): STRING;
BEGIN
Result := '';
IF Value = wxLB_BOTTOM THEN
BEGIN
Result := 'wxLB_BOTTOM';
exit;
END;
IF Value = wxLB_RIGHT THEN
BEGIN
Result := 'wxLB_RIGHT';
exit;
END;
IF Value = wxLB_LEFT THEN
BEGIN
Result := 'wxLB_LEFT';
exit;
END;
IF Value = wxLB_TOP THEN
BEGIN
Result := 'wxLB_TOP';
exit;
END;
IF Value = wxLB_DEFAULT THEN
BEGIN
Result := 'wxLB_DEFAULT';
exit;
END;

END;

FUNCTION GetNotebookSpecificStyle(stdstyle: TWxStdStyleSet;
    { bookalign: TWxnbxAlignStyleItem; }
nbxstyle: TWxnbxStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);

    {  if Result <> '' then
    Result := GetTabAlignment(bookalign) + ' | ' +  Result
  else
     Result := GetTabAlignment(bookalign);      }

strA := trim(GetNotebookStyleString(nbxstyle));

IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetAuiNotebookSpecificStyle(stdstyle: TWxStdStyleSet;
    { bookalign: TWxnbxAlignStyleItem; }
nbxstyle: TWxAuinbxStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);

    {  if Result <> '' then
      Result := GetTabAlignment(bookalign) + ' | ' +  Result
    else
       Result := GetTabAlignment(bookalign);      }

strA := trim(GetAuiNotebookStyleString(nbxstyle));

IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetTabAlignmentString(Value: TWxnbxAlignStyleItem): STRING;
BEGIN
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
IF Value = wxNB_BOTTOM THEN
BEGIN
Result := 'wxNB_BOTTOM';
        //    Self.TabPosition :=  tpBottom;
exit;
END;
IF Value = wxNB_RIGHT THEN
BEGIN
Result := 'wxNB_RIGHT';
        //    self.Multiline := True;
        //    Self.TabPosition :=  tpRight;
exit;
END;
IF Value = wxNB_LEFT THEN
BEGIN
Result := 'wxNB_LEFT';
        //    self.Multiline := True;
        //    Self.TabPosition := tpLeft;
exit;
END;
IF Value = wxNB_TOP THEN
BEGIN
Result := 'wxNB_TOP';
        //    Self.TabPosition := tpTop;
exit;
END;
IF Value = wxNB_DEFAULT THEN
BEGIN
Result := 'wxNB_DEFAULT';
        //    Self.TabPosition := tpTop;
exit;
END;

END;


FUNCTION GetToolbookSpecificStyle(stdstyle:
TWxStdStyleSet{; tlbxstyle: TWxtlbxStyleSet}): STRING;
    //var
    //  strA: string;
BEGIN
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

END;

FUNCTION GetTreebookSpecificStyle(stdstyle:
TWxStdStyleSet{; bookalign: TWxtrbxAlignStyleItem}): STRING;
    //var
    //  strA: string;
BEGIN
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
END;

FUNCTION GetTreeAlignment(Value: TWxtrbxAlignStyleItem): STRING;
BEGIN
Result := '';
IF Value = wxBK_BOTTOM THEN
BEGIN
Result := 'wxBK_BOTTOM';
exit;
END;
IF Value = wxBK_RIGHT THEN
BEGIN
Result := 'wxBK_RIGHT';
exit;
END;
IF Value = wxBK_LEFT THEN
BEGIN
Result := 'wxBK_LEFT';
exit;
END;
IF Value = wxBK_TOP THEN
BEGIN
Result := 'wxBK_TOP';
exit;
END;
IF Value = wxBK_DEFAULT THEN
BEGIN
Result := 'wxBK_DEFAULT';
exit;
END;

END;

FUNCTION GetRadioBoxSpecificStyle(stdstyle: TWxStdStyleSet;
rbxstyle: TWxrbxStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetRadioBoxStyleString(rbxstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetStatusBarSpecificStyle(stdstyle: TWxStdStyleSet;
sbrstyle: TWxsbrStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetStatusBarStyleString(sbrstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

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

FUNCTION GetScrolledWindowSpecificStyle(stdstyle: TWxStdStyleSet;
scrWinStyle: TWxScrWinStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetScrolledWindowStyleString(scrWinStyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetHtmlWindowSpecificStyle(stdstyle: TWxStdStyleSet;
htmlWinStyle: TWxHtmlWinStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetHtmlWindowStyleString(htmlWinStyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetSplitterWindowSpecificStyle(stdstyle: TWxStdStyleSet;
SplitterWinStyle: TWxSplitterWinStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetSplitterWindowStyleString(SplitterWinStyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetToolBarSpecificStyle(stdstyle: TWxStdStyleSet;
tbrstyle: TWxtbrStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetToolBarStyleString(tbrstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetAuiToolBarSpecificStyle(stdstyle: TWxStdStyleSet;
tbrstyle: TWxAuiTbrStyleSet): STRING;
    //var
    //  strA: string;
BEGIN
Result := GetStdStyleString(stdstyle);
    {mn
    strA := trim(GetToolBarStyleString(tbrstyle));
    if strA <> '' then
      if trim(Result) = '' then
        Result := strA
      else
        Result := Result + ' | ' + strA;
  }
END;

//End here

FUNCTION RGBFormatStrToColor(strColorValue: STRING): TColor;
VAR
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY

strTokenToStrings(strColorValue, ',', strLst);
IF strLst.Count > 2 THEN
Result := RGB(StrToInt(strLst[0]), StrToInt(strLst[1]),
StrToInt(strLst[2]))
ELSE
Result := RGB(0, 0, 0);

FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetColorFromString(strColorValue: STRING): TColor;
VAR
strChoice, strCmd: STRING;
BEGIN
strChoice := copy(strColorValue, 5, length(strColorValue));
strCmd := copy(strColorValue, 0, 4);
IF AnsiSameText(strCmd, 'CUS:') THEN
BEGIN
Result := RGBFormatStrToColor(strChoice);
exit;
END;
Result := GetGeneralColorFromString(strChoice);
END;

PROCEDURE PopulateGenericProperties(VAR PropertyList: TStringList);
BEGIN
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
END;

FUNCTION SizerAlignmentToStr(SizerAlignment: TWxSizerAlignmentSet): STRING;
VAR
Styles: TStringList;
I: INTEGER;
BEGIN
Styles := TStringList.Create;
IF wxALIGN_LEFT IN SizerAlignment THEN
Styles.Add('wxALIGN_LEFT');

IF wxALIGN_RIGHT IN SizerAlignment THEN
Styles.Add('wxALIGN_RIGHT');

IF wxALIGN_TOP IN SizerAlignment THEN
Styles.Add('wxALIGN_TOP');

IF wxALIGN_BOTTOM IN SizerAlignment THEN
Styles.Add('wxALIGN_BOTTOM');

IF wxALIGN_CENTER IN SizerAlignment THEN
Styles.Add('wxALIGN_CENTER');

IF wxALIGN_CENTER_HORIZONTAL IN SizerAlignment THEN
Styles.Add('wxALIGN_CENTER_HORIZONTAL');

IF wxALIGN_CENTER_VERTICAL IN SizerAlignment THEN
Styles.Add('wxALIGN_CENTER_VERTICAL');

IF wxEXPAND IN SizerAlignment THEN
Styles.Add('wxEXPAND');

IF Styles.Count = 0 THEN
Result := '0'
ELSE
BEGIN
Result := Styles[0];
FOR I := 1 TO Styles.Count - 1 DO
Result := Result + ' | ' + Styles[I];
END;

Styles.Free;
END;

FUNCTION BorderAlignmentToStr(BorderAlignment: TWxBorderAlignment): STRING;
BEGIN
Result := '';
IF (wxALL IN BorderAlignment) THEN
Result := Result + ' | wxALL';
IF (wxLEFT IN BorderAlignment) THEN
Result := Result + ' | wxLEFT';
IF (wxRIGHT IN BorderAlignment) THEN
Result := Result + ' | wxRIGHT';
IF (wxTOP IN BorderAlignment) THEN
Result := Result + ' | wxTOP';
IF (wxBOTTOM IN BorderAlignment) THEN
Result := Result + ' | wxBOTTOM';

IF (Length(Result) = 0) THEN
Result := '0'
ELSE
Result := Copy(Result, 4, Length(Result));
END;

FUNCTION GetStdStyleString(stdStyle: TWxStdStyleSet): STRING;
VAR
I: INTEGER;
strLst: TStringList;
BEGIN

strLst := TStringList.Create;

TRY

IF wxSIMPLE_BORDER IN stdStyle THEN
strLst.add('wxSIMPLE_BORDER');

IF wxDOUBLE_BORDER IN stdStyle THEN
strLst.add('wxDOUBLE_BORDER');

IF wxSUNKEN_BORDER IN stdStyle THEN
strLst.add('wxSUNKEN_BORDER');

IF wxRAISED_BORDER IN stdStyle THEN
strLst.add('wxRAISED_BORDER');

IF wxSTATIC_BORDER IN stdStyle THEN
strLst.add('wxSTATIC_BORDER');

IF wxTRANSPARENT_WINDOW IN stdStyle THEN
strLst.add('wxTRANSPARENT_WINDOW');

IF wxTAB_TRAVERSAL IN stdStyle THEN
strLst.add('wxTAB_TRAVERSAL');

IF wxWANTS_CHARS IN stdStyle THEN
strLst.add('wxWANTS_CHARS');

IF wxNO_FULL_REPAINT_ON_RESIZE IN stdStyle THEN
strLst.add('wxNO_FULL_REPAINT_ON_RESIZE');

IF wxVSCROLL IN stdStyle THEN
strLst.add('wxVSCROLL');

IF wxHSCROLL IN stdStyle THEN
strLst.add('wxHSCROLL');

IF wxCLIP_CHILDREN IN stdStyle THEN
strLst.add('wxCLIP_CHILDREN');

IF wxNO_BORDER IN stdStyle THEN
strLst.add('wxNO_BORDER');

IF wxALWAYS_SHOW_SB IN stdStyle THEN
strLst.add('wxALWAYS_SHOW_SB');

IF wxFULL_REPAINT_ON_RESIZE IN stdStyle THEN
strLst.add('wxFULL_REPAINT_ON_RESIZE');

IF strLst.Count = 0 THEN
Result := ''
ELSE
FOR I := 0 TO strLst.Count - 1 DO // Iterate
IF i <> strLst.Count - 1 THEN
Result := Result + strLst[i] + ' | '
ELSE
Result := Result + strLst[i] // for
;
        //sendDebug(Result);
FINALLY
strLst.Destroy;
END;
END;

FUNCTION GetAnimationCtrlSpecificStyle(stdstyle:
TWxStdStyleSet{;
  dlgstyle: TWxAnimationCtrlStyleSet}): STRING;
    //var
    //  strA: string;
BEGIN
Result := GetStdStyleString(stdstyle);
    {  strA := trim(GetAnimationCtrlStyleString(dlgstyle));
  if strA <> '' then
    if trim(Result) = '' then
      Result := strA
    else
      Result := Result + ' | ' + strA;  }//mn all we want at the moment is the standard style string

END;

FUNCTION GetButtonSpecificStyle(stdstyle: TWxStdStyleSet;
dlgstyle: TWxBtnStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetButtonStyleString(dlgstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetLabelSpecificStyle(stdstyle: TWxStdStyleSet;
dlgstyle: TWxLbStyleSet): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetLbStyleString(dlgstyle));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;

END;

FUNCTION GetStdDialogButtonsSpecificStyle(btnstyle:
TWxStdDialogButtons): STRING;
BEGIN
IF wxID_OK IN btnstyle THEN
Result := Result + ' | wxOK'
ELSE
BEGIN
IF wxID_YES IN btnstyle THEN
Result := Result + ' | wxYES'
ELSE
IF wxID_SAVE IN btnstyle THEN
Result := Result + ' | wxSAVE';
END;
IF wxID_NO IN btnstyle THEN
Result := Result + ' | wxNO';
IF wxID_CANCEL IN btnstyle THEN
Result := Result + ' | wxCANCEL';
IF wxID_APPLY IN btnstyle THEN
Result := Result + ' | wxAPPLY';

IF wxID_HELP IN btnstyle THEN
Result := Result + ' | wxHELP'
ELSE
IF wxID_CONTEXT_HELP IN btnstyle THEN
Result := Result + ' | wxCONTEXTHELP';

IF Result <> '' THEN
Result := Copy(Result, 4, Length(Result))
ELSE
Result := '0';
END;

FUNCTION GetDialogSpecificStyle(stdstyle: TWxStdStyleSet;
dlgstyle: TWxDlgStyleSet; wxclassname: STRING): STRING;
VAR
strA: STRING;
BEGIN
Result := GetStdStyleString(stdstyle);
strA := trim(GetDlgStyleString(dlgstyle, wxclassname));
IF strA <> '' THEN
IF trim(Result) = '' THEN
Result := strA
ELSE
Result := Result + ' | ' + strA;
END;

FUNCTION IsControlWxWindow(ctrl: TControl): BOOLEAN;
VAR
cntIntf: IWxWindowInterface;
BEGIN
Result := FALSE;
IF NOT assigned(ctrl) THEN
Exit;
Result := ctrl.GetInterface(IID_IWxWindowInterface, cntIntf);
END;

FUNCTION IsControlWxSizer(ctrl: TControl): BOOLEAN;
VAR
cntIntf: IWxContainerAndSizerInterface;
BEGIN
Result := FALSE;
IF NOT assigned(ctrl) THEN
Exit;
Result := ctrl.GetInterface(IID_IWxContainerAndSizerInterface, cntIntf);
END;

FUNCTION IsControlWxContainer(ctrl: TControl): BOOLEAN;
VAR
cntIntf: IWxContainerInterface;
BEGIN
Result := FALSE;
IF NOT assigned(ctrl) THEN
Exit;
Result := ctrl.GetInterface(IDD_IWxContainerInterface, cntIntf);
END;

FUNCTION IsControlWxToolBar(ctrl: TControl): BOOLEAN;
VAR
cntIntf: IWxToolBarInterface;
BEGIN
Result := FALSE;
IF NOT assigned(ctrl) THEN
Exit;
Result := ctrl.GetInterface(IID_IWxToolBarInterface, cntIntf);
END;

FUNCTION IsControlWxStatusBar(ctrl: TControl): BOOLEAN;
VAR
cntIntf: IWxStatusBarInterface;
BEGIN
Result := FALSE;
IF NOT assigned(ctrl) THEN
Exit;
Result := ctrl.GetInterface(IDD_IWxStatusBarInterface, cntIntf);
END;

FUNCTION IsControlWxNonVisible(ctrl: TControl): BOOLEAN;
BEGIN
Result := ctrl IS TWxNonVisibleBaseComponent;
END;

FUNCTION IsControlWxAuiManager(ctrl: TControl): BOOLEAN;
VAR
cntIntf: IWxAuiManagerInterface;
BEGIN
Result := FALSE;
IF NOT assigned(ctrl) THEN
Exit;
Result := ctrl.GetInterface(IID_IWxAuiManagerInterface, cntIntf);
END;

FUNCTION IsControlWxAuiToolBar(ctrl: TControl): BOOLEAN;
VAR
cntIntf: IWxAuiToolBarInterface;
BEGIN
Result := FALSE;
IF NOT assigned(ctrl) THEN
Exit;
Result := ctrl.GetInterface(IID_IWxAuiToolBarInterface, cntIntf);
END;

FUNCTION GetWxIDString(strID: STRING; intID: LONGINT): STRING;
BEGIN
IF intID > 0 THEN
BEGIN
IF trim(strID) = '' THEN
Result := '-1'
ELSE
Result := strID;
END
ELSE
Result := '-1';

END;

FUNCTION GetNonVisualComponentCount(frmMainObj: TForm): INTEGER;
VAR
I: INTEGER;
BEGIN
Result := 0;
FOR I := 0 TO frmMainObj.ComponentCount - 1 DO // Iterate
IF frmMainObj.Components[i] IS TWxNonVisibleBaseComponent THEN
Inc(Result); // for
END;

FUNCTION AlignmentToStr(taPos: TAlignment): STRING;
BEGIN
Result := '';
CASE taPos OF
taLeftJustify:
Result := 'wxLIST_FORMAT_LEFT';
taRightJustify:
Result := 'wxLIST_FORMAT_RIGHT';
taCenter:
Result := 'wxLIST_FORMAT_CENTER';
END; // case
END;

PROCEDURE ChangeControlZOrder(Sender: TObject; MoveUp: BOOLEAN = TRUE);
VAR
I, Curr: INTEGER;
Control: TControl;
List: TList;
NotebookPage: TTabSheet;
Notebook: TPageControl;
ToolbarParent: TToolBar;
BEGIN

IF Sender IS TControl THEN
IF (GetTypeData(Sender.ClassInfo)^.ClassType.ClassName =
'TWxNoteBookPage') OR (GetTypeData(Sender.ClassInfo)^.ClassType.ClassName =
'TWxAuiNoteBookPage') THEN
BEGIN
NotebookPage := Sender AS TTabSheet;
Notebook := NotebookPage.PageControl;
Curr := -1;

            //Determine the order of the notebook page
FOR I := 0 TO Pred(Notebook.PageCount) DO
IF Notebook.Pages[I] = Sender THEN
BEGIN
Curr := I;
Break;
END;

            //Make sure our position is valid
IF Curr < 0 THEN
Exit
ELSE
IF (Curr = 0) AND (MoveUp <> TRUE) THEN
Exit
ELSE
IF (Curr = Notebook.PageCount - 1) AND (MoveUp = TRUE) THEN
Exit;

            //Do the move
IF (MoveUp = TRUE) THEN
NotebookPage.PageIndex := NotebookPage.PageIndex + 1
ELSE
NotebookPage.PageIndex := NotebookPage.PageIndex - 1;

List := TList.Create;
TRY
IF MoveUp THEN
BEGIN
FOR I := Curr + 1 TO Pred(Notebook.PageCount) DO
                        // load other controls in group
List.Add(Notebook.Pages[I]);
NotebookPage.BringToFront;
FOR I := 0 TO Pred(List.Count) DO
                        // move other controls to front, too
TTabSheet(List[I]).BringToFront;
END
ELSE
BEGIN
FOR I := 0 TO Curr - 1 DO
                        // load other controls in group
List.Add(Notebook.Pages[I]);
NotebookPage.SendToBack;
FOR I := Pred(List.Count) DOWNTO 0 DO
                        // move other controls to back, too
TTabSheet(List[I]).SendToBack;
END;
FINALLY
List.Free;
END;
END
ELSE
IF Sender IS TControl THEN
BEGIN
            // only components of type TControl and descendends
            // work
Control := Sender AS TControl;
            // has no parent, cannot move ;-)
IF Control.Parent = NIL THEN
                // quit
Exit;
            // determine position in z-order
Curr := -1;
FOR I := 0 TO Pred(Control.Parent.ControlCount) DO
IF Control.Parent.Controls[I] = Sender THEN
BEGIN
Curr := I;
Break;
END;
IF Curr < 0 THEN
                // position not found, quit
Exit;


List := TList.Create;
TRY
IF MoveUp THEN
BEGIN
FOR I := Curr + 2 TO Pred(Control.Parent.ControlCount) DO
                        // load other controls in group
List.Add(Control.Parent.Controls[I]);
Control.BringToFront;

FOR I := 0 TO Pred(List.Count) DO
                        // move other controls to front, too
TControl(List[I]).BringToFront;
END
ELSE
BEGIN
FOR I := 0 TO Curr - 2 DO
                        // load other controls in group
List.Add(Control.Parent.Controls[I]);
Control.SendToBack;
FOR I := Pred(List.Count) DOWNTO 0 DO
                        // move other controls to back, too
TControl(List[I]).SendToBack;
END;
FINALLY
List.Free;
END;

END;
END;

FUNCTION GetXPMFromTPicture(XPMName: STRING; delphiBitmap: TBitmap): STRING;
VAR
I: INTEGER;
iWidth: INTEGER;
iHeight: INTEGER;
xpos, ypos, palindex, cindex, cpp: INTEGER;
cp: PCHAR;
pixc: INTEGER;
outline: ARRAY[0..800] OF CHAR;
usechrs: ARRAY[0..64] OF CHAR;
rval: REAL;
ccol, tcol: TColor;
lcol: ^TColor;
image: ^INTEGER;
cpos: ^INTEGER;
pal: TList;
found: BOOLEAN;
strlst: TStringList;
strLine: STRING;
LABEL
Finish1;

FUNCTION pow(base: INTEGER; index: INTEGER): INTEGER;
VAR
retval: INTEGER;
ittr: INTEGER;
BEGIN
retval := 1;
FOR ittr := 1 TO index DO
retval := retval * base;
pow := retval;
END;

BEGIN
cindex := 0;
Result := '';
Result := GetXPMFromTPictureXXX(XPMName, delphiBitmap);
exit;
Result := '';
BEGIN
        //   Form1.Enabled:=False;
        //   Form2.Gauge1.Progress:=0;
        //   Form2.Show;
StrPCopy(usechrs,
' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ&#');
pal := TList.Create; { Create TList to form our palette }
        //  delphiBitmap.Transparent := True;
iWidth := delphiBitmap.Width;
iHeight := delphiBitmap.Height;
        //  if iWidth > 180 then
        //    iWidth := 180;
        //  if iHeight > 180 then
        //    iHeight := 180;
GetMem(image, SizeOf(INTEGER) * iWidth * iHeight);
        { Allocate space for image }
        { Note: Maximum of 65,528 bytes - 2 bytes per pixel }
cpos := @image^; { This will be a pointer to current position in image }
FOR ypos := 0 TO iHeight - 1 DO
FOR xpos := 0 TO iWidth - 1 DO
BEGIN
ccol := delphiBitmap.Canvas.Pixels[xpos, ypos];
found := FALSE;
FOR palindex := 0 TO pal.Count - 1 DO
BEGIN { Search palette for color }
tcol := TColor(pal.Items[palindex]^);
IF tcol = ccol THEN
BEGIN { Found it! }
found := TRUE;
cindex := palindex; { Remember it's position in palette }
break;
END;
END;
IF NOT found THEN
BEGIN { Add new color to our palette }
New(lcol);
lcol^ := ccol;
pal.Add(lcol);
cindex := pal.Count - 1;
END;
cpos^ := cindex; { Store palette index for this pixel }
Inc(cpos); { Move on to next pixel }
END //      Form2.Gauge1.Progress:=((ypos+1)*100) div iHeight;
        //      Application.ProcessMessages;
        //      If Form2.Cancelled then goto Finish1;     { We have been cancelled! }
;

        //AssignFile(F,SaveDialog1.Filename);
        //Rewrite(F);
rval := ln(pal.Count) / ln(64);
cpp := trunc(rval);
IF (cpp <> rval) THEN
Inc(cpp);
        //Writeln(F,'/* XPM */');
Result := Result + '/* XPM */' + #13;
StrFmt(outline, 'static const char *%s', [XPMName]);
strLine := outline;
cp := StrScan(outline, '.');
IF cp <> NIL THEN
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
FOR palindex := 0 TO pal.Count - 1 DO
BEGIN
ccol := TColor(pal.Items[palindex]^);
ccol := ccol MOD (256 * 256 * 256);
StrFmt(outline, '"      c #%s%s%s",', [IntToHex(ccol MOD 256, 2),
IntToHex((ccol DIV 256) MOD 256, 2),
IntToHex(ccol DIV (256 * 256), 2)]);
strLine := outline;
cindex := palindex;
FOR pixc := 1 TO cpp DO
BEGIN
outline[pixc] := usechrs[cindex DIV pow(64, cpp - pixc)];
cindex := cindex MOD pow(64, cpp - pixc);
strLine := outline;
END;
strLine := outline;
            //      if AnsiStartsText('"      c #',strLine) then
            //      begin
            //        strLine:='"      c #FFFFFF",';
            //        Result:=Result+strLine+#13;
            //      end
            //      else
BEGIN
Result := Result + outline + #13;
END;
END;
cpos := @image^;
FOR ypos := 0 TO iHeight - 1 DO
BEGIN
StrPCopy(outline, '"');
FOR xpos := 0 TO iWidth - 1 DO
BEGIN
cindex := cpos^;
FOR pixc := 1 TO cpp DO
BEGIN
outline[xpos * cpp + pixc] :=
usechrs[cindex DIV pow(64, cpp - pixc)];
cindex := cindex MOD pow(64, cpp - pixc);
END;
Inc(cpos);
END;
            //outline[cpp * (xpos + 1) + 1] := #0;  // xpos is undefined after loop
outline[cpp * (cpos^ + 1) + 1] := #0;
            // i think cpos is the intended variable instead

IF ypos < iHeight - 1 THEN
StrCat(outline, '",')
ELSE
StrCat(outline, '"};');
            //Writeln(F,outline);
Result := Result + outline + #13;
END;
        //Finish2:
        //CloseFile(F);

Finish1:
FreeMem(image, SizeOf(INTEGER) * iWidth * iHeight);
FOR palindex := 0 TO pal.Count - 1 DO
Dispose(pal.Items[palindex]);
pal.Free;
        //   Form2.Hide;
        //   Form1.Enabled:=True;
strlst := TStringList.Create;
strlst.Text := Result;
FOR I := 0 TO strlst.Count - 1 DO // Iterate
BEGIN
strLine := trim(strlst[i]);
            //sendDebug(IntToStr(i)+' Old # = '+IntToStr(Length(strlst[i])));

IF AnsiEndsText('","",', strLine) THEN
BEGIN
                //not tested
strLine := copy(strLine, 0, length(strLine) - 5);
IF NOT AnsiEndsText('",', strLine) THEN
strlst[i] := strLine + '",';
END;

strLine := trim(strlst[i]);

IF AnsiEndsText('"",', strLine) THEN
BEGIN
                //tested
strLine := copy(strLine, 0, length(strLine) - 3);
IF NOT AnsiEndsText('",', strLine) THEN
strlst[i] := strLine + '",';
END;

strLine := trim(strlst[i]);
IF AnsiEndsText('",",', strLine) THEN
BEGIN
                //tested
strLine := copy(strLine, 0, length(strLine) - 4);
IF NOT AnsiEndsText('",', strLine) THEN
strlst[i] := strLine + '",';
END;

strLine := trim(strlst[i]);

IF AnsiEndsText('",""};', strLine) THEN
BEGIN
strLine := copy(strLine, 0, length(strLine) - 6);
IF NOT AnsiEndsText('"};', strLine) THEN
strlst[i] := strLine + '"};';
END;

strLine := trim(strlst[i]);
IF AnsiEndsText('""};', strLine) THEN
BEGIN
                //not test
strLine := copy(strLine, 0, length(strLine) - 4);
IF NOT AnsiEndsText('"};', strLine) THEN
strlst[i] := strLine + '"};';
END;

strLine := trim(strlst[i]);
IF AnsiEndsText('","};', strLine) THEN
BEGIN
                //not test
strLine := copy(strLine, 0, length(strLine) - 5);
IF NOT AnsiEndsText('"};', strLine) THEN
strlst[i] := strLine + '"};';
END;

            //sendDebug(IntToStr(i)+' New # = '+IntToStr(Length(strlst[i])));

END; // for

Result := strlst.Text;

strlst.Destroy;
END;
END;

FUNCTION GetXPMFromTPictureXXX(XPMName: STRING; delphiBitmap: TBitmap): STRING;
VAR
I: INTEGER;
iWidth: INTEGER;
iHeight: INTEGER;
xpos, ypos, palindex, cindex, cpp: INTEGER;
cp: PCHAR;
pixc: INTEGER;
outline: ARRAY[0..800] OF CHAR;
usechrs: ARRAY[0..64] OF CHAR;
rval: REAL;
ccol, tcol: TColor;
lcol: ^TColor;
image: ^INTEGER;
cpos: ^INTEGER;
pal: TList;
found: BOOLEAN;
strlst: TStringList;
strLine: STRING;
LABEL
Finish1;

FUNCTION pow(base: INTEGER; index: INTEGER): INTEGER;
VAR
retval: INTEGER;
ittr: INTEGER;
BEGIN
retval := 1;
FOR ittr := 1 TO index DO
retval := retval * base;
pow := retval;
END;

BEGIN

cindex := 0;

Result := '';
BEGIN
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
GetMem(image, SizeOf(INTEGER) * iWidth * iHeight);
        { Allocate space for image }
        { Note: Maximum of 65,528 bytes - 2 bytes per pixel }
cpos := @image^; { This will be a pointer to current position in image }
FOR ypos := 0 TO iHeight - 1 DO
FOR xpos := 0 TO iWidth - 1 DO
BEGIN
ccol := delphiBitmap.Canvas.Pixels[xpos, ypos];
found := FALSE;
FOR palindex := 0 TO pal.Count - 1 DO
BEGIN { Search palette for color }
tcol := TColor(pal.Items[palindex]^);
IF tcol = ccol THEN
BEGIN { Found it! }
found := TRUE;
cindex := palindex; { Remember it's position in palette }
break;
END;
END;
IF NOT found THEN
BEGIN { Add new color to our palette }
New(lcol);
lcol^ := ccol;
pal.Add(lcol);
cindex := pal.Count - 1;
END;
cpos^ := cindex; { Store palette index for this pixel }
Inc(cpos); { Move on to next pixel }
END //      Form2.Gauge1.Progress:=((ypos+1)*100) div iHeight;
        //      Application.ProcessMessages;
        //      If Form2.Cancelled then goto Finish1;     { We have been cancelled! }
;

        //AssignFile(F,SaveDialog1.Filename);
        //Rewrite(F);
rval := ln(pal.Count) / ln(64);
cpp := trunc(rval);
IF (cpp <> rval) THEN
Inc(cpp);
        //Writeln(F,'/* XPM */');
Result := Result + '/* XPM */' + #13;
StrFmt(outline, 'static const char *%s', [XPMName]);
strLine := outline;
cp := StrScan(outline, '.');
IF cp <> NIL THEN
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
FOR palindex := 0 TO pal.Count - 1 DO
BEGIN
ccol := TColor(pal.Items[palindex]^);
ccol := ccol MOD (256 * 256 * 256);
IF palindex = 0 THEN
StrFmt(outline, '"      c None",', [''])
ELSE
StrFmt(outline, '"      c #%s%s%s",', [IntToHex(ccol MOD 256, 2),
IntToHex((ccol DIV 256) MOD 256, 2),
IntToHex(ccol DIV (256 * 256), 2)]);

strLine := outline;
cindex := palindex;
FOR pixc := 1 TO cpp DO
BEGIN
outline[pixc] := usechrs[cindex DIV pow(64, cpp - pixc)];
cindex := cindex MOD pow(64, cpp - pixc);
strLine := outline;
END;
strLine := outline;
            //      if AnsiStartsText('"      c #',strLine) then
            //      begin
            //        strLine:='"      c #FFFFFF",';
            //        Result:=Result+strLine+#13;
            //      end
            //      else
BEGIN
Result := Result + outline + #13;
END;
END;
cpos := @image^;
FOR ypos := 0 TO iHeight - 1 DO
BEGIN
StrPCopy(outline, '"');
FOR xpos := 0 TO iWidth - 1 DO
BEGIN
cindex := cpos^;
FOR pixc := 1 TO cpp DO
BEGIN
outline[xpos * cpp + pixc] :=
usechrs[cindex DIV pow(64, cpp - pixc)];
cindex := cindex MOD pow(64, cpp - pixc);
END;
Inc(cpos);
END;
outline[cpp * (iWidth) + 1] := #0; // xpos is undefined after loop
            //outline[cpp * (xpos + 1) + 1] := #0; // xpos is undefined after loop
IF ypos < iHeight - 1 THEN
StrCat(outline, '",')
ELSE
StrCat(outline, '"};');
            //Writeln(F,outline);
Result := Result + outline + #13;
END;
        //Finish2:
        //CloseFile(F);

Finish1:
FreeMem(image, SizeOf(INTEGER) * iWidth * iHeight);
FOR palindex := 0 TO pal.Count - 1 DO
Dispose(pal.Items[palindex]);
pal.Free;
        //   Form2.Hide;
        //   Form1.Enabled:=True;
strlst := TStringList.Create;
strlst.Text := Result;
FOR I := 0 TO strlst.Count - 1 DO // Iterate
BEGIN
strLine := trim(strlst[i]);
            //sendDebug(IntToStr(i)+' Old # = '+IntToStr(Length(strlst[i])));

IF AnsiEndsText('","",', strLine) THEN
BEGIN
                //not tested
strLine := copy(strLine, 0, length(strLine) - 5);
IF NOT AnsiEndsText('",', strLine) THEN
strlst[i] := strLine + '",';
END;

strLine := trim(strlst[i]);

IF AnsiEndsText('"",', strLine) THEN
BEGIN
                //tested
strLine := copy(strLine, 0, length(strLine) - 3);
IF NOT AnsiEndsText('",', strLine) THEN
strlst[i] := strLine + '",';
END;

strLine := trim(strlst[i]);
IF AnsiEndsText('",",', strLine) THEN
BEGIN
                //tested
strLine := copy(strLine, 0, length(strLine) - 4);
IF NOT AnsiEndsText('",', strLine) THEN
strlst[i] := strLine + '",';
END;

strLine := trim(strlst[i]);

IF AnsiEndsText('",""};', strLine) THEN
BEGIN
strLine := copy(strLine, 0, length(strLine) - 6);
IF NOT AnsiEndsText('"};', strLine) THEN
strlst[i] := strLine + '"};';
END;

strLine := trim(strlst[i]);
IF AnsiEndsText('""};', strLine) THEN
BEGIN
                //not test
strLine := copy(strLine, 0, length(strLine) - 4);
IF NOT AnsiEndsText('"};', strLine) THEN
strlst[i] := strLine + '"};';
END;

strLine := trim(strlst[i]);
IF AnsiEndsText('","};', strLine) THEN
BEGIN
                //not test
strLine := copy(strLine, 0, length(strLine) - 5);
IF NOT AnsiEndsText('"};', strLine) THEN
strlst[i] := strLine + '"};';
END;

            //sendDebug(IntToStr(i)+' New # = '+IntToStr(Length(strlst[i])));

END; // for

Result := strlst.Text;

strlst.Destroy;
END;
END;

FUNCTION GetRawXPMFromTPicture(XPMName: STRING; delphiBitmap: TBitmap): STRING;
VAR
iWidth: INTEGER;
iHeight: INTEGER;
xpos, ypos, palindex, cindex, cpp: INTEGER;
cp: PCHAR;
pixc: INTEGER;
outline: ARRAY[0..800] OF CHAR;
usechrs: ARRAY[0..64] OF CHAR;
rval: REAL;
ccol, tcol: TColor;
lcol: ^TColor;
image: ^INTEGER;
cpos: ^INTEGER;
pal: TList;
found: BOOLEAN;
strLine: STRING;
LABEL
Finish1;

FUNCTION pow(base: INTEGER; index: INTEGER): INTEGER;
VAR
retval: INTEGER;
ittr: INTEGER;
BEGIN
retval := 1;
FOR ittr := 1 TO index DO
retval := retval * base;
pow := retval;
END;

BEGIN

cindex := 0;

Result := '';
BEGIN
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
GetMem(image, SizeOf(INTEGER) * iWidth * iHeight);
        { Allocate space for image }
        { Note: Maximum of 65,528 bytes - 2 bytes per pixel }
cpos := @image^; { This will be a pointer to current position in image }
FOR ypos := 0 TO iHeight - 1 DO
FOR xpos := 0 TO iWidth - 1 DO
BEGIN
ccol := delphiBitmap.Canvas.Pixels[xpos, ypos];
found := FALSE;
FOR palindex := 0 TO pal.Count - 1 DO
BEGIN { Search palette for color }
tcol := TColor(pal.Items[palindex]^);
IF tcol = ccol THEN
BEGIN { Found it! }
found := TRUE;
cindex := palindex; { Remember it's position in palette }
break;
END;
END;
IF NOT found THEN
BEGIN { Add new color to our palette }
New(lcol);
lcol^ := ccol;
pal.Add(lcol);
cindex := pal.Count - 1;
END;
cpos^ := cindex; { Store palette index for this pixel }
Inc(cpos); { Move on to next pixel }
END //      Form2.Gauge1.Progress:=((ypos+1)*100) div iHeight;
        //      Application.ProcessMessages;
        //      If Form2.Cancelled then goto Finish1;     { We have been cancelled! }
;

        //AssignFile(F,SaveDialog1.Filename);
        //Rewrite(F);
rval := ln(pal.Count) / ln(64);
cpp := trunc(rval);
IF (cpp <> rval) THEN
Inc(cpp);
        //Writeln(F,'/* XPM */');
Result := Result + '/* XPM */' + #13;
StrFmt(outline, 'static const char *%s', [XPMName]);
strLine := outline;
cp := StrScan(outline, '.');
IF cp <> NIL THEN
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
FOR palindex := 0 TO pal.Count - 1 DO
BEGIN
ccol := TColor(pal.Items[palindex]^);
ccol := ccol MOD (256 * 256 * 256);
StrFmt(outline, '"      c #%s%s%s",', [IntToHex(ccol MOD 256, 2),
IntToHex((ccol DIV 256) MOD 256, 2),
IntToHex(ccol DIV (256 * 256), 2)]);
strLine := outline;
cindex := palindex;
FOR pixc := 1 TO cpp DO
BEGIN
outline[pixc] := usechrs[cindex DIV pow(64, cpp - pixc)];
cindex := cindex MOD pow(64, cpp - pixc);
strLine := outline;
END;
strLine := outline;
Result := Result + outline + #13;
END;
cpos := @image^;
FOR ypos := 0 TO iHeight - 1 DO
BEGIN
StrPCopy(outline, '"');
FOR xpos := 0 TO iWidth - 1 DO
BEGIN
cindex := cpos^;
FOR pixc := 1 TO cpp DO
BEGIN
outline[xpos * cpp + pixc] :=
usechrs[cindex DIV pow(64, cpp - pixc)];
cindex := cindex MOD pow(64, cpp - pixc);
END;
Inc(cpos);
END;

            //outline[cpp * (xpos + 1) + 1] := #0; // xpos is undefined after loop
outline[cpp * (cpos^ + 1) + 1] := #0;
            // i think cpos is the intended variable instead
IF ypos < iHeight - 1 THEN
StrCat(outline, '",')
ELSE
StrCat(outline, '"};');
            //Writeln(F,outline);
Result := Result + outline + #13;
END;
        //Finish2:
        //CloseFile(F);

Finish1:
FreeMem(image, SizeOf(INTEGER) * iWidth * iHeight);
FOR palindex := 0 TO pal.Count - 1 DO
Dispose(pal.Items[palindex]);
pal.Free;
END;
END;

FUNCTION GenerateXPMDirectly(bmp: TBitmap; strCompName: STRING;
strParentName: STRING; strFileName: STRING): BOOLEAN;
VAR
xpmFileDir, xpmNewFileDir: STRING;
fileStrlst: TStringList;
strXPMContent: STRING;

BEGIN
Result := FALSE;
IF bmp = NIL THEN
Exit;

xpmFileDir := CreateGraphicFileDir(strFileName) + 'Images' + pd;

IF bmp.handle <> 0 THEN
BEGIN

fileStrlst := TStringList.Create;
TRY
strXPMContent := GetXPMFromTPicture(strParentName + '_' +
strCompName, bmp);

IF trim(strXPMContent) <> '' THEN
BEGIN
            //ShowMessage('Tony: Saving XPM file');
fileStrlst.Add(strXPMContent);
fileStrlst.SaveToFile(xpmFileDir + strParentName + '_' +
strCompName + '_XPM.xpm');
END;
EXCEPT
END;
fileStrlst.Destroy;
END;
Result := TRUE;
END;

FUNCTION GetCommentString(str: STRING): STRING;
BEGIN
IF (trim(str) <> '') THEN
Result := '/* ' + str + ' */' + #13
ELSE
Result := ' ';

END;

FUNCTION GetCppString(str: STRING): STRING;
BEGIN

    // If the first character in the text is a &, then
    //    the user wants this to be a literal variable name
    // Otherwise, the user wants this to be a text value
IF (AnsiPos('&&', str) = 1) THEN
BEGIN
Delete(str, 1, 2);
Result := str;
END
ELSE
BEGIN
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
END;
END;

FUNCTION GetWxPosition(Left: INTEGER; Top: INTEGER): STRING;
BEGIN
IF (UseDefaultPos = TRUE) THEN
Result := 'wxDefaultPosition'
ELSE
Result := Format('wxPoint(%d, %d)', [Left, Top]);
END;

FUNCTION GetWxSize(Width: INTEGER; Height: INTEGER): STRING;
BEGIN
IF (UseDefaultSize = TRUE) THEN
Result := 'wxDefaultSize'
ELSE
Result := Format('wxSize(%d, %d)', [Width, Height]);
END;

FUNCTION GetWxEnum(Wx_IDValue: INTEGER; Wx_IDName: STRING): STRING;
BEGIN
Result := '';
IF (UseIndividEnums = TRUE) THEN
BEGIN
IF (Wx_IDValue > 0) AND (trim(Wx_IDName) <> '') THEN
Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
END
ELSE
BEGIN
IF (Wx_IDValue > 0) AND (trim(Wx_IDName) <> '') THEN
Result := Format('%s, ', [Wx_IDName]);
END;
END;

FUNCTION OpenXPMImage(InpImage: TBitmap; strFname: STRING): BOOLEAN;
TYPE
TPalRec = RECORD
chrs: PCHAR;
color: TColor;
END;

FUNCTION HexVal(chr: CHAR): INTEGER;
BEGIN
IF (chr >= 'a') AND (chr <= 'f') THEN
HexVal := Ord(chr) - Ord('a') + 10
ELSE
HexVal := Ord(chr) - Ord('0');
END;

VAR
iWidth: INTEGER;
iHeight: INTEGER;
cpp, colors, col, ypos, xpos, hexc, infield: INTEGER;
fieldstr: ARRAY[0..256] OF CHAR;
fieldval: INTEGER;
rgb1, rgb2, rgb3: INTEGER;
inpline: ARRAY[0..800] OF CHAR;
capline: ARRAY[0..256] OF CHAR;
pal: TList;
palitem: ^TPalRec;
cp1, cp2: PCHAR;
F: TextFile;
ColorDialog1: TColorDialog;
LABEL
Finish1;
BEGIN
Result := TRUE;
iHeight := 0;
iWidth := 0;
colors := 0;
cpp := 0;
palitem := NIL;

BEGIN
AssignFile(F, strFname);
Reset(F);
inpline[0] := #0;
WHILE inpline[0] <> '"' DO
Readln(F, inpline);

infield := 0;
fieldstr[0] := #0;
cp1 := inpline + 1;
WHILE cp1 <= StrScan(inpline + 1, '"') DO
BEGIN
IF (cp1[0] = ' ') OR (cp1[0] = '"') THEN
BEGIN
IF fieldstr[0] <> #0 THEN
BEGIN
Inc(infield);
fieldval := StrToInt(StrPas(fieldstr));
fieldstr[0] := #0;
IF infield = 1 THEN
iWidth := fieldval;
IF infield = 2 THEN
iHeight := fieldval;
IF infield = 3 THEN
colors := fieldval;
IF infield = 4 THEN
cpp := fieldval;
END;
END
ELSE
BEGIN
fieldstr[StrLen(fieldstr) + 1] := #0;
fieldstr[StrLen(fieldstr)] := cp1[0];
END;
Inc(cp1);
END;

pal := TList.Create;
FOR col := 0 TO colors - 1 DO
BEGIN
inpline[0] := #0;
WHILE inpline[0] <> '"' DO
Readln(F, inpline);
inpline[cpp + 1] := #0;
New(palitem);
palitem^.chrs := StrAlloc(cpp + 1);
StrCopy(palitem^.chrs, inpline + 1);
cp1 := StrScan(inpline + cpp + 2, 'c') + 1;
cp1 := SysUtils.StrLower(cp1);
IF StrScan(cp1, '#') = NIL THEN
BEGIN
StrCopy(capline, 'What color does "');
StrCat(capline, cp1);
StrCat(capline, ' represent?');
Application.MessageBox(capline, 'Select Color', mb_OK);
ColorDialog1 := TColorDialog.Create(NIL);
ColorDialog1.Execute;
palitem^.color := ColorDialog1.Color;
END
ELSE
BEGIN
cp1 := StrScan(cp1, '#') + 1;
cp2 := StrScan(cp1, '"');
cp2[0] := #0;
hexc := StrLen(cp1) DIV 3;
rgb1 := HexVal(cp1[0]) * 16 + HexVal(cp1[1]);
rgb2 := HexVal(cp1[hexc]) * 16 + HexVal(cp1[hexc + 1]);
rgb3 := HexVal(cp1[2 * hexc]) * 16 + HexVal(cp1[2 * hexc + 1]);
palitem^.color := LONGINT(rgb1) + 256 * LONGINT(rgb2) + 256 *
256 * LONGINT(rgb3);
END;
pal.Add(palitem);
END;

InpImage.Height := iHeight;
InpImage.Width := iWidth;
cp1 := StrAlloc(cpp + 1);
FOR ypos := 0 TO iHeight - 1 DO
BEGIN
inpline[0] := #0;
WHILE inpline[0] <> '"' DO
Readln(F, inpline);
FOR xpos := 0 TO iWidth - 1 DO
BEGIN
StrLCopy(cp1, inpline + xpos * cpp + 1, cpp);
FOR col := 0 TO colors - 1 DO
BEGIN
palitem := pal.Items[col];
IF SysUtils.StrComp(palitem^.chrs, cp1) = 0 THEN
break;
END;
InpImage.Canvas.Pixels[xpos, ypos] := palitem^.color;
END;
            //Form2.Gauge1.Progress:=((ypos+1)*100) div iHeight;
Application.ProcessMessages;
END;

Finish1:
StrDispose(cp1);

FOR col := 0 TO colors - 1 DO
BEGIN
palitem := pal.Items[col];
StrDispose(palitem^.chrs);
Dispose(palitem);
END;
pal.Free;

CloseFile(F);
END;

END;

FUNCTION IcoToBmp(Icon: TIcon): TBitmap;
BEGIN
Result := TBitmap.Create;
Result.Width := Icon.Width;
Result.Height := Icon.Height;
Result.Canvas.Draw(0, 0, Icon);
END;

FUNCTION GetwxColorFromString(strValue: STRING): STRING;
VAR
strColorValue, strChoice: STRING;
BEGIN
Result := '';
strColorValue := trim(strValue);
strColorValue := copy(strColorValue, 5, length(strColorValue));
strChoice := copy(trim(strValue), 0, 4);

IF AnsiSameText(strChoice, 'CUS:') THEN
BEGIN
Result := 'wxColour(' + strColorValue + ')';
exit;
END;

IF AnsiSameText(strChoice, 'DEF:') THEN
BEGIN
Result := '';
exit;
END;

IF AnsiSameText(strColorValue, 'BLACK') THEN
BEGIN
Result := 'wxColour(' + GetCppString(strColorValue) + ')';
exit;
END;
IF AnsiSameText(strColorValue, 'BLUE') THEN
BEGIN
Result := 'wxColour(' + GetCppString(strColorValue) + ')';
exit;
END;
IF AnsiSameText(strColorValue, 'CYAN') THEN
BEGIN
Result := 'wxColour(' + GetCppString(strColorValue) + ')';
exit;
END;
IF AnsiSameText(strColorValue, 'DARK SLATE GREY') THEN
BEGIN
Result := 'wxColour(' + GetCppString(strColorValue) + ')';
exit;
END;
IF AnsiSameText(strColorValue, 'LIGHT GREY') THEN
BEGIN
Result := 'wxColour(' + GetCppString(strColorValue) + ')';
exit;
END;
IF AnsiSameText(strColorValue, 'GREEN') THEN
BEGIN
Result := 'wxColour(' + GetCppString(strColorValue) + ')';
exit;
END;
IF AnsiSameText(strColorValue, 'GREY') THEN
BEGIN
Result := 'wxColour(' + GetCppString(strColorValue) + ')';
exit;
END;
IF AnsiSameText(strColorValue, 'LIME GREEN') THEN
BEGIN
Result := 'wxColour(' + GetCppString(strColorValue) + ')';
exit;
END;
IF AnsiSameText(strColorValue, 'MAROON') THEN
BEGIN
Result := 'wxColour(' + GetCppString(strColorValue) + ')';
exit;
END;
IF AnsiSameText(strColorValue, 'NAVY') THEN
BEGIN
Result := 'wxColour(' + GetCppString(strColorValue) + ')';
exit;
END;
IF AnsiSameText(strColorValue, 'PURPLE') THEN
BEGIN
Result := 'wxColour(' + GetCppString(strColorValue) + ')';
exit;
END;
IF AnsiSameText(strColorValue, 'RED') THEN
BEGIN
Result := 'wxColour(' + GetCppString(strColorValue) + ')';
exit;
END;
IF AnsiSameText(strColorValue, 'SKY BLUE') THEN
BEGIN
Result := 'wxColour(' + GetCppString(strColorValue) + ')';
exit;
END;
IF AnsiSameText(strColorValue, 'YELLOW') THEN
BEGIN
Result := 'wxColour(' + GetCppString(strColorValue) + ')';
exit;
END;
IF AnsiSameText(strColorValue, 'WHITE') THEN
BEGIN
Result := 'wxColour(' + GetCppString(strColorValue) + ')';
exit;
END;

IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_SCROLLBAR') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_SCROLLBAR)';
exit;
END;

IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_BACKGROUND') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BACKGROUND)';
exit;
END;

IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_ACTIVECAPTION') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_ACTIVECAPTION)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVECAPTION') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_INACTIVECAPTION)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_MENU') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_MENU)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOW') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_WINDOW)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOWFRAME') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_WINDOWFRAME)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_MENUTEXT') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_MENUTEXT)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOWTEXT') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_WINDOWTEXT)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_CAPTIONTEXT') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_CAPTIONTEXT)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_ACTIVEBORDER') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_ACTIVEBORDER)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVEBORDER') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_INACTIVEBORDER)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_APPWORKSPACE') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_APPWORKSPACE)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_HIGHLIGHT') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_HIGHLIGHT)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_HIGHLIGHTTEXT') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_HIGHLIGHTTEXT)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNFACE') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BTNFACE)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNSHADOW') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BTNSHADOW)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_GRAYTEXT') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_GRAYTEXT)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNTEXT') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BTNTEXT)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVECAPTIONTEXT') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_INACTIVECAPTIONTEXT)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNHIGHLIGHT') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BTNHIGHLIGHT)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DDKSHADOW') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DDKSHADOW)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DLIGHT') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DLIGHT)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_INFOTEXT') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_INFOTEXT)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_INFOBK') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_INFOBK)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_DESKTOP') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_DESKTOP)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DFACE') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DFACE)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DSHADOW') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DSHADOW)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DHIGHLIGHT') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DHIGHLIGHT)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DHILIGHT') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_3DHILIGHT)';
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNHILIGHT') THEN
BEGIN
Result := 'wxSystemSettings::GetColour(wxSYS_COLOUR_BTNHILIGHT)';
exit;
END;

END;

FUNCTION PaperIDToString(sizeitem: TWxPaperSizeItem): STRING;
BEGIN
Result := 'wxPAPER_NONE';

IF sizeitem = wxPAPER_NONE THEN
BEGIN
Result := 'wxPAPER_NONE';
Exit;
END;

IF sizeitem = wxPAPER_LETTER THEN
BEGIN
Result := 'wxPAPER_LETTER';
Exit;
END;
IF sizeitem = wxPAPER_LEGAL THEN
BEGIN
Result := 'wxPAPER_LEGAL';
Exit;
END;
IF sizeitem = wxPAPER_A4 THEN
BEGIN
Result := 'wxPAPER_A4';
Exit;
END;
IF sizeitem = wxPAPER_CSHEET THEN
BEGIN
Result := 'wxPAPER_CSHEET';
Exit;
END;
IF sizeitem = wxPAPER_DSHEET THEN
BEGIN
Result := 'wxPAPER_DSHEET';
Exit;
END;
IF sizeitem = wxPAPER_ESHEET THEN
BEGIN
Result := 'wxPAPER_ESHEET';
Exit;
END;
IF sizeitem = wxPAPER_LETTERSMALL THEN
BEGIN
Result := 'wxPAPER_LETTERSMALL';
Exit;
END;

IF sizeitem = wxPAPER_TABLOID THEN
BEGIN
Result := 'wxPAPER_TABLOID';
Exit;
END;
IF sizeitem = wxPAPER_LEDGER THEN
BEGIN
Result := 'wxPAPER_LEDGER';
Exit;
END;
IF sizeitem = wxPAPER_STATEMENT THEN
BEGIN
Result := 'wxPAPER_STATEMENT';
Exit;
END;
IF sizeitem = wxPAPER_EXECUTIVE THEN
BEGIN
Result := 'wxPAPER_EXECUTIVE';
Exit;
END;
IF sizeitem = wxPAPER_NOTE THEN
BEGIN
Result := 'wxPAPER_NOTE';
Exit;
END;
IF sizeitem = wxPAPER_ENV_9 THEN
BEGIN
Result := 'wxPAPER_ENV_9';
Exit;
END;
IF sizeitem = wxPAPER_A3 THEN
BEGIN
Result := 'wxPAPER_A3';
Exit;
END;
IF sizeitem = wxPAPER_A4SMALL THEN
BEGIN
Result := 'wxPAPER_A4SMALL';
Exit;
END;
IF sizeitem = wxPAPER_A5 THEN
BEGIN
Result := 'wxPAPER_A5';
Exit;
END;
IF sizeitem = wxPAPER_B4 THEN
BEGIN
Result := 'wxPAPER_B4';
Exit;
END;

IF sizeitem = wxPAPER_B5 THEN
BEGIN
Result := 'wxPAPER_B5';
Exit;
END;
IF sizeitem = wxPAPER_FOLIO THEN
BEGIN
Result := 'wxPAPER_FOLIO';
Exit;
END;
IF sizeitem = wxPAPER_QUARTO THEN
BEGIN
Result := 'wxPAPER_QUARTO';
Exit;
END;
IF sizeitem = wxPAPER_10X14 THEN
BEGIN
Result := 'wxPAPER_10X14';
Exit;
END;

IF sizeitem = wxPAPER_11X17 THEN
BEGIN
Result := 'wxPAPER_11X17';
Exit;
END;
IF sizeitem = wxPAPER_ENV_10 THEN
BEGIN
Result := 'wxPAPER_ENV_10';
Exit;
END;
IF sizeitem = wxPAPER_ENV_11 THEN
BEGIN
Result := 'wxPAPER_ENV_11';
Exit;
END;
IF sizeitem = wxPAPER_ENV_12 THEN
BEGIN
Result := 'wxPAPER_ENV_12';
Exit;
END;
IF sizeitem = wxPAPER_ENV_14 THEN
BEGIN
Result := 'wxPAPER_ENV_14';
Exit;
END;
IF sizeitem = wxPAPER_ENV_DL THEN
BEGIN
Result := 'wxPAPER_ENV_DL';
Exit;
END;
IF sizeitem = wxPAPER_ENV_C5 THEN
BEGIN
Result := 'wxPAPER_ENV_C5';
Exit;
END;
IF sizeitem = wxPAPER_ENV_C3 THEN
BEGIN
Result := 'wxPAPER_ENV_C3';
Exit;
END;
IF sizeitem = wxPAPER_ENV_C4 THEN
BEGIN
Result := 'wxPAPER_ENV_C4';
Exit;
END;
IF sizeitem = wxPAPER_ENV_C6 THEN
BEGIN
Result := 'wxPAPER_ENV_C6';
Exit;
END;
IF sizeitem = wxPAPER_ENV_C65 THEN
BEGIN
Result := 'wxPAPER_ENV_C65';
Exit;
END;
IF sizeitem = wxPAPER_ENV_B4 THEN
BEGIN
Result := 'wxPAPER_ENV_B4';
Exit;
END;

IF sizeitem = wxPAPER_ENV_B5 THEN
BEGIN
Result := 'wxPAPER_ENV_B5';
Exit;
END;
IF sizeitem = wxPAPER_ENV_B6 THEN
BEGIN
Result := 'wxPAPER_ENV_B6';
Exit;
END;
IF sizeitem = wxPAPER_ENV_ITALY THEN
BEGIN
Result := 'wxPAPER_ENV_ITALY';
Exit;
END;
IF sizeitem = wxPAPER_ENV_MONARCH THEN
BEGIN
Result := 'wxPAPER_ENV_MONARCH';
Exit;
END;
IF sizeitem = wxPAPER_ENV_PERSONAL THEN
BEGIN
Result := 'wxPAPER_ENV_PERSONAL';
Exit;
END;
IF sizeitem = wxPAPER_FANFOLD_US THEN
BEGIN
Result := 'wxPAPER_FANFOLD_US';
Exit;
END;
IF sizeitem = wxPAPER_FANFOLD_STD_GERMAN THEN
BEGIN
Result := 'wxPAPER_FANFOLD_STD_GERMAN';
Exit;
END;
IF sizeitem = wxPAPER_FANFOLD_LGL_GERMAN THEN
BEGIN
Result := 'wxPAPER_FANFOLD_LGL_GERMAN';
Exit;
END;

END;
//-------------------------------------------------------------------------------

FUNCTION IsDefaultColorStr(strvalue: STRING): BOOLEAN;
BEGIN
strvalue := trim(strvalue);
IF strvalue = '' THEN
BEGIN
Result := TRUE;
exit;
END;

IF UpperCase(copy(strvalue, 0, 4)) = 'DEF:' THEN
Result := TRUE
ELSE
Result := FALSE;
END;

FUNCTION GetGeneralColorFromString(strColorValue: STRING): TColor;
BEGIN
strColorValue := trim(strColorValue);
Result := 0 + clBlack;
IF AnsiSameText(strColorValue, 'BLACK') THEN
BEGIN
Result := clBlack;
exit;
END;
IF AnsiSameText(strColorValue, 'BLUE') THEN
BEGIN
Result := clBlue;
exit;
END;
IF AnsiSameText(strColorValue, 'CYAN') THEN
BEGIN
Result := clAqua;
exit;
END;
IF AnsiSameText(strColorValue, 'DARK SLATE GREY') THEN
BEGIN
Result := clDkGray;
exit;
END;
IF AnsiSameText(strColorValue, 'GREEN') THEN
BEGIN
Result := clGreen;
exit;
END;
IF AnsiSameText(strColorValue, 'GREY') THEN
BEGIN
Result := clGray;
exit;
END;
IF AnsiSameText(strColorValue, 'LIGHT GREY') THEN
BEGIN
Result := clLtGray;
exit;
END;
IF AnsiSameText(strColorValue, 'LIME GREEN') THEN
BEGIN
Result := clLime;
exit;
END;
IF AnsiSameText(strColorValue, 'MAROON') THEN
BEGIN
Result := clMaroon;
exit;
END;
IF AnsiSameText(strColorValue, 'NAVY') THEN
BEGIN
Result := clNavy;
exit;
END;
IF AnsiSameText(strColorValue, 'PURPLE') THEN
BEGIN
Result := clPurple;
exit;
END;
IF AnsiSameText(strColorValue, 'RED') THEN
BEGIN
Result := clRed;
exit;
END;
IF AnsiSameText(strColorValue, 'SKY BLUE') THEN
BEGIN
Result := clSkyBlue;
exit;
END;
IF AnsiSameText(strColorValue, 'YELLOW') THEN
BEGIN
Result := clYellow;
exit;
END;
IF AnsiSameText(strColorValue, 'WHITE') THEN
BEGIN
Result := clWhite;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_SCROLLBAR') THEN
BEGIN
Result := clScrollBar;
exit;
END;

IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_BACKGROUND') THEN
BEGIN
Result := clBackground;
exit;
END;

IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_ACTIVECAPTION') THEN
BEGIN
Result := clActiveCaption;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVECAPTION') THEN
BEGIN
Result := clInactiveCaption;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_MENU') THEN
BEGIN
Result := clMenu;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOW') THEN
BEGIN
Result := clWindow;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOWFRAME') THEN
BEGIN
Result := clWindowFrame;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_MENUTEXT') THEN
BEGIN
Result := clMenuText;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_WINDOWTEXT') THEN
BEGIN
Result := clWindowText;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_CAPTIONTEXT') THEN
BEGIN
Result := clCaptionText;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_ACTIVEBORDER') THEN
BEGIN
Result := clActiveBorder;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVEBORDER') THEN
BEGIN
Result := clInactiveBorder;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_APPWORKSPACE') THEN
BEGIN
Result := clAppWorkSpace;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_HIGHLIGHT') THEN
BEGIN
Result := clHighlight;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_HIGHLIGHTTEXT') THEN
BEGIN
Result := clHighlightText;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNFACE') THEN
BEGIN
Result := clBtnFace;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNSHADOW') THEN
BEGIN
Result := clBtnShadow;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_GRAYTEXT') THEN
BEGIN
Result := clGrayText;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNTEXT') THEN
BEGIN
Result := clBtnText;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_INACTIVECAPTIONTEXT') THEN
BEGIN
Result := clInactiveCaptionText;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNHIGHLIGHT') THEN
BEGIN
Result := clBtnHighlight;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DDKSHADOW') THEN
BEGIN
Result := cl3DDkShadow;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DLIGHT') THEN
BEGIN
Result := cl3DLight;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_INFOTEXT') THEN
BEGIN
Result := clInfoText;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_INFOBK') THEN
BEGIN
Result := clInfoBk;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_DESKTOP') THEN
BEGIN
Result := clBackground;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DFACE') THEN
BEGIN
Result := clBtnFace;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DSHADOW') THEN
BEGIN
Result := clBtnShadow;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DHIGHLIGHT') THEN
BEGIN
Result := clBtnHighlight;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_3DHILIGHT') THEN
BEGIN
Result := clBtnHighlight;
exit;
END;
IF AnsiSameText(strColorValue, 'wxSYS_COLOUR_BTNHILIGHT') THEN
BEGIN
Result := clBtnHighlight;
exit;
END;
END;

//=== {TJvInspectorValidatorItem } ===========================================

CONSTRUCTOR TJvInspectorValidatorItem.Create(
CONST AParent: TJvCustomInspectorItem;
CONST AData: TJvCustomInspectorData);
BEGIN
INHERITED Create(AParent, AData);
END;

PROCEDURE TJvInspectorValidatorItem.SetFlags(CONST Value:
TInspectorItemFlags);
VAR
NewValue: TInspectorItemFlags;
BEGIN
NewValue := Value + [iifEditButton];
INHERITED SetFlags(NewValue);
END;

PROCEDURE TJvInspectorValidatorItem.ContentsChanged(Sender: TObject);
VAR
Obj: TStrings;
BEGIN

IF NOT Assigned(Data) THEN
exit;

Obj := TStrings(Data.AsOrdinal);
Obj.Text := TMemo(Sender).Lines.Text;
END;

FUNCTION TJvInspectorValidatorItem.GetDisplayValue: STRING;
BEGIN
Result := 'Edit Validator';
END;

PROCEDURE TJvInspectorValidatorItem.SetDisplayValue;
BEGIN

END;

CLASS PROCEDURE TJvInspectorValidatorItem.RegisterAsDefaultItem;
BEGIN
WITH TJvCustomInspectorData.ItemRegister DO
IF IndexOf(Self) = -1 THEN
Add(TJvInspectorTypeInfoRegItem.Create(Self,
TypeInfo(TWxValidatorString)));
END;

PROCEDURE TJvInspectorValidatorItem.Edit;
VAR
ValidatorForm: TwxValidator;
wxValidatorstring: TWxValidatorString;
compIntf: IWxValidatorInterface;
BEGIN

IF NOT Assigned(TJvInspectorPropData(Self.GetData()).Instance) THEN
exit;
IF NOT Assigned(Data) THEN
exit;

wxValidatorString := TWxValidatorString(Data.AsOrdinal);

ValidatorForm := TwxValidator.Create(GetParentForm(Inspector));
TRY

ValidatorForm.SetValidatorString(wxValidatorString.strValidatorValue);

IF ValidatorForm.ShowModal = mrOk THEN
BEGIN

wxValidatorString.FstrValidatorValue :=
ValidatorForm.GetValidatorString;

IF (TJvInspectorPropData(Self.GetData()).Instance).GetInterface(
IID_IWxValidatorInterface, compIntf) THEN
BEGIN
IF AnsiSameText(Data.Name, 'Wx_ProxyValidatorString') THEN
compIntf.SetValidator(wxValidatorString.FstrValidatorValue);
END;

IF assigned(TJvInspector(GetInspector).OnDataValueChanged) THEN
TJvInspector(GetInspector).OnDataValueChanged(NIL, Data);

END;

FINALLY
ValidatorForm.Destroy;
END;

END;
//=== { TJvInspectorTStringsItem } ===========================================

CONSTRUCTOR TWxJvInspectorTStringsItem.Create(
CONST AParent: TJvCustomInspectorItem;
CONST AData: TJvCustomInspectorData);
BEGIN
INHERITED Create(AParent, AData);
RowSizing.MinHeight := irsItemHeight;
Flags := Flags + [iifEditButton];
END;

PROCEDURE TWxJvInspectorTStringsItem.ContentsChanged(Sender: TObject);
VAR
Obj: TStrings;
BEGIN
IF NOT Assigned(Data) THEN
exit;
Obj := TStrings(Data.AsOrdinal);
Obj.Text := TMemo(Sender).Lines.Text;
END;

FUNCTION TWxJvInspectorTStringsItem.GetDisplayValue: STRING;
BEGIN
Result := 'Edit Strings';
END;

PROCEDURE TWxJvInspectorTStringsItem.Edit;
VAR
SL: TStrings;
Form: TStringsForm;
BEGIN

IF NOT Assigned(Data) THEN
exit;

    //Create the form
Form := TStringsForm.Create(GetParentForm(Inspector));

TRY
        //Load the strings
SL := TStrings(Data.AsOrdinal);
Form.Memo.Lines.Assign(SL);
IF AutoUpdate THEN
Form.OnContentsChanged := ContentsChanged;

        //Show the form
IF Form.ShowModal = mrOk THEN
BEGIN
SL.Assign(Form.Memo.Lines);
IF assigned(TJvInspector(GetInspector).OnDataValueChanged) THEN
TJvInspector(GetInspector).OnDataValueChanged(NIL, Data);
END;
FINALLY
Form.Destroy;
END;
END;

PROCEDURE TWxJvInspectorTStringsItem.SetDisplayValue(CONST Value: STRING);
VAR
Obj: TObject;
BEGIN

IF NOT Assigned(Data) THEN
exit;

IF Multiline THEN
BEGIN
Obj := TObject(Data.AsOrdinal);
TStrings(Obj).Text := Value;
END;
END;

PROCEDURE TWxJvInspectorTStringsItem.SetFlags(
CONST Value: TInspectorItemFlags);
VAR
OldMask: TInspectorItemFlags;
NewMask: TInspectorItemFlags;
BEGIN
    { The item has either an edit button or is multiline. If one of them is set,
    the other one will be removed }
OldMask := Flags * [iifEditButton, iifMultiLine];
NewMask := Value * [iifEditButton, iifMultiLine];
IF OldMask <> NewMask THEN
BEGIN
IF Multiline AND NOT (iifEditButton IN OldMask) AND
(iifEditButton IN NewMask) THEN
INHERITED SetFlags(Value - [iifMultiLine]) // iifEditButton has changed
ELSE
IF NOT Multiline AND (iifEditButton IN OldMask) AND
(iifMultiLine IN NewMask) THEN
INHERITED SetFlags(Value - [iifEditButton]) // iifMultiLine has changed
ELSE
INHERITED SetFlags(Value);
        // Neither flag has changed. Should never occur.
END
ELSE // Flags have not changed
INHERITED SetFlags(Value);
IF RowSizing <> NIL THEN
BEGIN
RowSizing.Sizable := Multiline; // Update sizable state
IF NOT Multiline THEN
RowSizing.SizingFactor := irsNoReSize
ELSE
RowSizing.SizingFactor := irsValueHeight;
END;
END;

CLASS PROCEDURE TWxJvInspectorTStringsItem.RegisterAsDefaultItem;
BEGIN
WITH TJvCustomInspectorData.ItemRegister DO
IF IndexOf(Self) = -1 THEN
Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TStrings)));
END;

{-------------------------------------------------------}

PROCEDURE TJvInspectorColorEditItem.Edit;
VAR
ColorEditForm: TColorEdit;
strColorValue: STRING;
compIntf: IWxComponentInterface;
BEGIN

IF NOT Assigned(TJvInspectorPropData(Self.GetData()).Instance) THEN
exit;

ColorEditForm := TColorEdit.Create(GetParentForm(Inspector));
TRY
IF (TJvInspectorPropData(Self.GetData()).Instance).GetInterface(
IID_IWxComponentInterface, compIntf) THEN
BEGIN

IF AnsiSameText(Data.Name, 'Wx_ProxyBGColorString') THEN
strColorValue := compIntf.GetBGColor
ELSE
IF AnsiSameText(Data.Name, 'Wx_ProxyFGColorString') THEN
strColorValue := compIntf.GetFGColor
ELSE
strColorValue := compIntf.GetGenericColor(Data.Name);
END;

ColorEditForm.SetColorString(strColorValue);

IF ColorEditForm.ShowModal = mrOk THEN
BEGIN

strColorValue := ColorEditForm.GetColorString;

IF (TJvInspectorPropData(Self.GetData()).Instance).GetInterface(
IID_IWxComponentInterface, compIntf) THEN
BEGIN
IF AnsiSameText(Data.Name, 'Wx_ProxyBGColorString') THEN
compIntf.SetBGColor(strColorValue)
ELSE
IF AnsiSameText(Data.Name, 'Wx_ProxyFGColorString') THEN
compIntf.SetFGColor(strColorValue)
ELSE
compIntf.SetGenericColor(Data.Name, strColorValue);
END;

IF assigned(TJvInspector(GetInspector).OnDataValueChanged) THEN
TJvInspector(GetInspector).OnDataValueChanged(NIL, Data);

END;

FINALLY
ColorEditForm.Destroy;
END;

END;

FUNCTION TJvInspectorColorEditItem.GetDisplayValue: STRING;
BEGIN
Result := 'Edit Color';
END;

PROCEDURE TJvInspectorColorEditItem.SetDisplayValue(CONST Value: STRING);
BEGIN

END;

PROCEDURE TJvInspectorColorEditItem.SetFlags(CONST Value: TInspectorItemFlags);
VAR
NewValue: TInspectorItemFlags;
BEGIN
NewValue := Value + [iifEditButton];
INHERITED SetFlags(NewValue);
END;

CLASS PROCEDURE TJvInspectorColorEditItem.RegisterAsDefaultItem;
BEGIN
WITH TJvCustomInspectorData.ItemRegister DO
IF IndexOf(Self) = -1 THEN
Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TWxColorString)));
END;

CLASS PROCEDURE TJvInspectorFileNameEditItem.RegisterAsDefaultItem;
BEGIN
WITH TJvCustomInspectorData.ItemRegister DO
IF IndexOf(Self) = -1 THEN
Add(TJvInspectorTypeInfoRegItem.Create(Self,
TypeInfo(TWxFileNameString)));
END;


CLASS PROCEDURE TJvInspectorAnimationFileNameEditItem.RegisterAsDefaultItem;
BEGIN
WITH TJvCustomInspectorData.ItemRegister DO
IF IndexOf(Self) = -1 THEN
Add(TJvInspectorTypeInfoRegItem.Create(Self,
TypeInfo(TWxAnimationFileNameString)));
END;
//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

PROCEDURE TJvInspectorListItemsItem.Edit;
VAR
ListviewForm: TListviewForm;
i: INTEGER;
lstColumn: TListColumn;
BEGIN

IF NOT Assigned(TJvInspectorPropData(Self.GetData()).Instance) THEN
exit;

ListviewForm := TListviewForm.Create(GetParentForm(Inspector));
TRY
ListviewForm.LstViewObj.Columns.Clear;
FOR i := 0 TO
TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns.Count
- 1 DO
BEGIN
lstColumn := ListviewForm.LstViewObj.Columns.Add;
lstColumn.Caption :=
TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns[i].Caption;
lstColumn.Width :=
TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns[i].Width;
lstColumn.Alignment :=
TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns[i].Alignment;
END;
ListviewForm.fillListInfo;

IF ListviewForm.ShowModal = mrOk THEN
BEGIN
TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns.Clear;
FOR i := 0 TO ListviewForm.LstViewObj.Columns.Count - 1 DO
BEGIN
lstColumn :=
TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns.Add;
lstColumn.Caption := ListviewForm.LstViewObj.Columns[i].Caption;
lstColumn.Width := ListviewForm.LstViewObj.Columns[i].Width;
lstColumn.Alignment := ListviewForm.LstViewObj.Columns[i].Alignment;
END;

IF assigned(TJvInspector(GetInspector).OnDataValueChanged) THEN
TJvInspector(GetInspector).OnDataValueChanged(NIL, Data);

END;

FINALLY
ListviewForm.Destroy;
END;

END;

FUNCTION TJvInspectorListItemsItem.GetDisplayValue: STRING;
BEGIN
Result := 'Edit Items';
END;

PROCEDURE TJvInspectorListItemsItem.SetDisplayValue(CONST Value: STRING);
BEGIN

END;

PROCEDURE TJvInspectorListItemsItem.SetFlags(CONST Value: TInspectorItemFlags);
VAR
NewValue: TInspectorItemFlags;
BEGIN
NewValue := Value + [iifEditButton];
INHERITED SetFlags(NewValue);
END;

CLASS PROCEDURE TJvInspectorListItemsItem.RegisterAsDefaultItem;
BEGIN
WITH TJvCustomInspectorData.ItemRegister DO
IF IndexOf(Self) = -1 THEN
Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TListItems)));
END;
//-------------------------------------------------------------------------------

PROCEDURE TJvInspectorStatusBarItem.Edit;
VAR
sbForm: TStatusBarForm;
i: INTEGER;
stPnl: TStatusPanel;
BEGIN

IF NOT Assigned(TJvInspectorPropData(Self.GetData()).Instance) THEN
exit;

sbForm := TStatusBarForm.Create(GetParentForm(Inspector));
TRY
sbForm.StatusBarObj.Panels.Clear;
FOR i := 0 TO
TStatusBar(TJvInspectorPropData(Self.GetData()).Instance).Panels.Count
- 1 DO
BEGIN
stPnl := sbForm.StatusBarObj.Panels.Add;
stPnl.Text := TStatusBar(TJvInspectorPropData(Self.GetData()).Instance).Panels[i].Text;
stPnl.Width := TStatusBar(TJvInspectorPropData(Self.GetData()).Instance).Panels[i].Width;
END;
sbForm.fillListInfo;

IF sbForm.ShowModal = mrOk THEN
BEGIN
TStatusBar(TJvInspectorPropData(Self.GetData()).Instance).panels.Clear;
FOR i := 0 TO sbForm.StatusBarObj.Panels.Count - 1 DO
BEGIN
stPnl :=
TStatusBar(TJvInspectorPropData(Self.GetData()).Instance).Panels.Add;
stPnl.Text := sbForm.StatusBarObj.Panels[i].Text;
stPnl.Width := sbForm.StatusBarObj.Panels[i].Width;
END;


IF assigned(TJvInspector(GetInspector).OnDataValueChanged) THEN
TJvInspector(GetInspector).OnDataValueChanged(NIL, Data);

END;

FINALLY
sbForm.Destroy;
END;

END;

FUNCTION TJvInspectorStatusBarItem.GetDisplayValue: STRING;
BEGIN
Result := 'Edit Fields';
END;

PROCEDURE TJvInspectorStatusBarItem.SetDisplayValue(CONST Value: STRING);
BEGIN

END;

PROCEDURE TJvInspectorStatusBarItem.SetFlags(CONST Value: TInspectorItemFlags);
VAR
NewValue: TInspectorItemFlags;
BEGIN
NewValue := Value + [iifEditButton];
INHERITED SetFlags(NewValue);
END;

CLASS PROCEDURE TJvInspectorStatusBarItem.RegisterAsDefaultItem;
BEGIN
WITH TJvCustomInspectorData.ItemRegister DO
IF IndexOf(Self) = -1 THEN
Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TStatusPanels)));
END;

//-------------------------------------------------------------------------------

PROCEDURE TJvInspectorListColumnsItem.Edit;
VAR
ListviewForm: TListviewForm;
i: INTEGER;
lstColumn: TListColumn;
BEGIN

IF NOT Assigned(TJvInspectorPropData(Self.GetData()).Instance) THEN
exit;

ListviewForm := TListviewForm.Create(GetParentForm(Inspector));
TRY
ListviewForm.LstViewObj.Columns.Clear;
FOR i := 0 TO
TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns.Count
- 1 DO
BEGIN
lstColumn := ListviewForm.LstViewObj.Columns.Add;
lstColumn.Caption :=
TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns[i].Caption;
lstColumn.Width :=
TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns[i].Width;
lstColumn.Alignment :=
TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns[i].Alignment;
END;
ListviewForm.fillListInfo;

IF ListviewForm.ShowModal = mrOk THEN

BEGIN
TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns.Clear;
FOR i := 0 TO ListviewForm.LstViewObj.Columns.Count - 1 DO
BEGIN
lstColumn :=
TListView(TJvInspectorPropData(Self.GetData()).Instance).Columns.Add;
lstColumn.Caption := ListviewForm.LstViewObj.Columns[i].Caption;
lstColumn.Width := ListviewForm.LstViewObj.Columns[i].Width;
lstColumn.Alignment := ListviewForm.LstViewObj.Columns[i].Alignment;
END;


IF assigned(TJvInspector(GetInspector).OnDataValueChanged) THEN
TJvInspector(GetInspector).OnDataValueChanged(NIL, Data);

END;

FINALLY
ListviewForm.Destroy;
END;

END;

FUNCTION TJvInspectorListColumnsItem.GetDisplayValue: STRING;
BEGIN
Result := 'Edit Columns';
END;

PROCEDURE TJvInspectorListColumnsItem.SetDisplayValue(CONST Value: STRING);
BEGIN

END;

PROCEDURE TJvInspectorListColumnsItem.SetFlags(
CONST Value: TInspectorItemFlags);
VAR
NewValue: TInspectorItemFlags;
BEGIN
NewValue := Value + [iifEditButton];
INHERITED SetFlags(NewValue);
END;

CLASS PROCEDURE TJvInspectorListColumnsItem.RegisterAsDefaultItem;
BEGIN
WITH TJvCustomInspectorData.ItemRegister DO
IF IndexOf(Self) = -1 THEN
Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TListColumns)));
END;
//-------------------------------------------------------------------------------

PROCEDURE TJvInspectorTreeNodesItem.Edit;
VAR
TreeViewForm: TTreeEditor;
component1: TWxTreeCtrl;

BEGIN

IF NOT Assigned(TJvInspectorPropData(Self.GetData()).Instance) THEN
exit;

    // Call tree editor form
TreeViewForm := TTreeEditor.Create(GetParentForm(Inspector));
TRY

        // Clear tree
TreeViewForm.TreeView1.Items.Clear;

        // Get Wx_TreeCtrl component being edited
component1 := TWxTreeCtrl(TJvInspectorPropData(Self.GetData()).Instance);

IF (component1.Items <> NIL) THEN
BEGIN
                // Copy tree from component to form
TreeViewForm.TreeView1.Items.BeginUpdate;
TreeViewForm.TreeView1.Items.Assign(component1.Items);
TreeViewForm.TreeView1.Items.EndUpdate;
END;

IF TreeViewForm.ShowModal = mrOk THEN
BEGIN

component1.Items.BeginUpdate;
component1.Items.Clear;
component1.Items.Assign(TreeViewForm.TreeView1.Items);
component1.Items.EndUpdate;

IF assigned(TJvInspector(GetInspector).OnDataValueChanged) THEN
TJvInspector(GetInspector).OnDataValueChanged(NIL, Data);

END;

FINALLY
TreeViewForm.Destroy;
END;

END;

FUNCTION TJvInspectorTreeNodesItem.GetDisplayValue: STRING;
BEGIN
Result := 'Edit Nodes';
END;

PROCEDURE TJvInspectorTreeNodesItem.SetDisplayValue(CONST Value: STRING);
BEGIN

END;

PROCEDURE TJvInspectorTreeNodesItem.SetFlags(CONST Value: TInspectorItemFlags);
VAR
NewValue: TInspectorItemFlags;
BEGIN
NewValue := Value + [iifEditButton];
INHERITED SetFlags(NewValue);
END;

CLASS PROCEDURE TJvInspectorTreeNodesItem.RegisterAsDefaultItem;
BEGIN
WITH TJvCustomInspectorData.ItemRegister DO
IF IndexOf(Self) = -1 THEN
Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TTreeNodes)));
END;
//-------------------------------------------------------------------------------

PROCEDURE TJvInspectorBitmapItem.Edit;
VAR
PictureEdit: TPictureEdit;
picObj: Tpicture;
strClassName: STRING;
strFileName: STRING;
BEGIN

IF NOT Assigned(TJvInspectorPropData(Self.GetData()).Instance) THEN
exit;

PictureEdit := TPictureEdit.Create(GetParentForm(Inspector));

strClassName := UpperCase(
(TJvInspectorPropData(Self.GetData()).Instance).ClassName);

IF strClassName = UpperCase('TWxBitmapButton') THEN
BEGIN
PictureEdit.Image1.Picture.Assign(TWxBitmapButton(
TJvInspectorPropData(Self.GetData()).Instance).Wx_Bitmap);
IF (TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat) THEN
PictureEdit.KeepFormat.State := cbChecked
ELSE
PictureEdit.KeepFormat.State := cbUnchecked;

PictureEdit.FileName.Text :=
TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).GetGraphicFileName;
END;

IF strClassName = UpperCase('TWxCustomButton') THEN
BEGIN
PictureEdit.Image1.Picture.Assign(TWxCustomButton(
TJvInspectorPropData(Self.GetData()).Instance).Wx_Bitmap);
IF (TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat) THEN
PictureEdit.KeepFormat.State := cbChecked
ELSE
PictureEdit.KeepFormat.State := cbUnchecked;

PictureEdit.FileName.Text :=
TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).GetGraphicFileName;

END;

IF strClassName = UpperCase('TWxToolButton') THEN
BEGIN
PictureEdit.Image1.Picture.Assign(
TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_Bitmap);

IF (TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat) THEN
PictureEdit.KeepFormat.State := cbChecked
ELSE
PictureEdit.KeepFormat.State := cbUnchecked;

PictureEdit.FileName.Text :=
TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).GetGraphicFileName;

END;

IF strClassName = UpperCase('TWxStaticBitmap') THEN
BEGIN
PictureEdit.Image1.Picture.Assign(TWxStaticBitmap(
TJvInspectorPropData(Self.GetData()).Instance).picture);

IF (TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat) THEN
PictureEdit.KeepFormat.State := cbChecked
ELSE
PictureEdit.KeepFormat.State := cbUnchecked;

PictureEdit.FileName.Text :=
TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).GetGraphicFileName;

END;

IF strClassName = UpperCase('TFrmNewForm') THEN
BEGIN
PictureEdit.Image1.Picture.Assign(
TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).Wx_ICON);

IF (TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat) THEN
PictureEdit.KeepFormat.State := cbChecked
ELSE
PictureEdit.KeepFormat.State := cbUnchecked;

PictureEdit.FileName.Text :=
TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).GetGraphicFileName;

END;

TRY
IF PictureEdit.ShowModal = mrOk THEN
BEGIN
picObj := TPicture.Create;
picObj.Bitmap.Assign(PictureEdit.Image1.Picture.Bitmap);

IF strClassName = UpperCase('TWxStaticBitmap') THEN
BEGIN
TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).picture.Assign(picObj);
TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).picture.Bitmap.Transparent := TRUE;
TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).Width :=
TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).picture.Bitmap.Width;
TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).Height :=
TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).picture.Bitmap.Height;

IF (PictureEdit.KeepFormat.State = cbChecked) THEN
BEGIN
TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := TRUE;
TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName(PictureEdit.FileName.Text);
END
ELSE
BEGIN
TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := FALSE;
                    //strFileName := 'Images' + pd + TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).GetName + '_XPM.xpm';
TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName('');
END;

strFileName := TWxStaticBitmap(TJvInspectorPropData(
Self.GetData()).Instance).GetGraphicFileName;

END;

IF strClassName = UpperCase('TFrmNewForm') THEN
BEGIN
TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).Wx_ICON.Assign(picObj);
TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).Wx_ICON.Bitmap.Transparent := TRUE;

IF (PictureEdit.KeepFormat.State = cbChecked) THEN
BEGIN
TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := TRUE;
TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName(PictureEdit.FileName.Text);
END
ELSE
BEGIN
TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := FALSE;
TFrmNewForm(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName('');
END;

strFileName := TFrmNewForm(TJvInspectorPropData(
Self.GetData()).Instance).GetGraphicFileName;

END;

IF strClassName = UpperCase('TWxBitmapButton') THEN
BEGIN
TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_BITMAP.Assign(picObj);
TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_BITMAP.Bitmap.Transparent := TRUE;
TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).SetButtonBitmap(picObj);

IF (PictureEdit.KeepFormat.State = cbChecked) THEN
BEGIN
TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := TRUE;
TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName(PictureEdit.FileName.Text);
END
ELSE
BEGIN
TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := FALSE;
                    //strFileName := 'Images' + pd + TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).GetName + '_XPM.xpm';
TWxBitmapButton(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName('');
END;

strFileName := TWxBitmapButton(TJvInspectorPropData(
Self.GetData()).Instance).GetGraphicFileName;

END;

IF strClassName = UpperCase('TWxCustomButton') THEN
BEGIN
TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_BITMAP.Assign(picObj);
TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_BITMAP.Bitmap.Transparent := TRUE;
TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).SetButtonBitmap(picObj);

IF (PictureEdit.KeepFormat.State = cbChecked) THEN
BEGIN
TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := TRUE;
TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName(PictureEdit.FileName.Text);
END
ELSE
BEGIN
TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := FALSE;
                    //strFileName := 'Images' + pd + TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).GetName + '_XPM.xpm';
TWxCustomButton(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName('');
END;

strFileName := TWxCustomButton(TJvInspectorPropData(
Self.GetData()).Instance).GetGraphicFileName;

END;

IF strClassName = UpperCase('TWxToolButton') THEN
BEGIN
TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_BITMAP.Assign(picObj);
TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).Wx_BITMAP.Bitmap.Transparent := TRUE;
TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).SetButtonBitmap(picObj);

IF (PictureEdit.KeepFormat.State = cbChecked) THEN
BEGIN
TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := TRUE;
TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName(PictureEdit.FileName.Text);
END
ELSE
BEGIN
TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).KeepFormat := FALSE;
                    //strFileName := 'Images' + pd + TWxStaticBitmap(TJvInspectorPropData(Self.GetData()).Instance).GetName + '_XPM.xpm';
TWxToolButton(TJvInspectorPropData(Self.GetData()).Instance).SetGraphicFileName('');
END;

strFileName := TWxToolButton(TJvInspectorPropData(
Self.GetData()).Instance).GetGraphicFileName;

END;

IF assigned(TJvInspector(GetInspector).OnDataValueChanged) THEN
TJvInspector(GetInspector).OnDataValueChanged(NIL, Data);
END;

FINALLY
PictureEdit.Destroy;
END;
END;

FUNCTION TJvInspectorBitmapItem.GetDisplayValue: STRING;
BEGIN
Result := 'Edit Picture';
END;

PROCEDURE TJvInspectorBitmapItem.SetDisplayValue(CONST Value: STRING);
BEGIN

END;

PROCEDURE TJvInspectorBitmapItem.SetFlags(CONST Value: TInspectorItemFlags);
VAR
NewValue: TInspectorItemFlags;
BEGIN
NewValue := Value + [iifEditButton];
INHERITED SetFlags(NewValue);
END;

CLASS PROCEDURE TJvInspectorBitmapItem.RegisterAsDefaultItem;
BEGIN
WITH TJvCustomInspectorData.ItemRegister DO
IF IndexOf(Self) = -1 THEN
Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TPicture)));
END;
//------------------------------------------------------------------------------

PROCEDURE TJvInspectorMyFontItem.Edit;
VAR
FontDlg: TFontDialog;
fnt: TFont;
compIntf: IWxComponentInterface;
prevColor: TColor;
ColorInt: INTEGER;
BEGIN

IF NOT Assigned(Data) THEN
exit;

fnt := TFont(Data.AsOrdinal);

prevColor := fnt.Color;

FontDlg := TFontDialog.Create(GetParentForm(Inspector));

TRY
FontDlg.Font.Assign(fnt);
IF NOT FontDlg.Execute THEN
exit;
fnt.Assign(FontDlg.Font);

IF prevColor <> fnt.Color THEN
IF (TJvInspectorPropData(Self.GetData()).Instance).GetInterface(
IID_IWxComponentInterface, compIntf) THEN
BEGIN
ColorInt := ColorToRGB(fnt.Color);
compIntf.SetFGColor('CUS:' + IntToStr(GetRValue(ColorInt)) +
',' + IntToStr(GetGValue(ColorInt)) + ',' +
IntToStr(GetBValue(ColorInt)));
END;

IF assigned(TJvInspector(GetInspector).OnDataValueChanged) THEN
TJvInspector(GetInspector).OnDataValueChanged(NIL, Data);

FINALLY
FontDlg.Destroy;
END;
END;

FUNCTION TJvInspectorMyFontItem.GetDisplayValue: STRING;
BEGIN
Result := 'Edit Font';
END;

PROCEDURE TJvInspectorMyFontItem.SetDisplayValue(CONST Value: STRING);
BEGIN

END;

PROCEDURE TJvInspectorMyFontItem.SetFlags(CONST Value: TInspectorItemFlags);
VAR
NewValue: TInspectorItemFlags;
BEGIN
NewValue := Value + [iifEditButton];
INHERITED SetFlags(NewValue);
END;

CLASS PROCEDURE TJvInspectorMyFontItem.RegisterAsDefaultItem;
BEGIN
WITH TJvCustomInspectorData.ItemRegister DO
IF IndexOf(Self) = -1 THEN
Add(TJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TFont)));
END;

//------------------------------------------------------------------------------

PROCEDURE TJvInspectorMenuItem.Edit;
VAR
mnuDlg: TMenuItemForm;
pMenuItem: TWxPopupMenu;
mbItem: TWxMenuBar;
maxControlValue: INTEGER;
MenuName: STRING;
BEGIN

IF NOT Assigned(TJvInspectorPropData(Self.GetData()).Instance) THEN
exit;


TRY
IF (TJvInspectorPropData(Self.GetData()).Instance IS TControl) THEN
MenuName := TControl(TJvInspectorPropData(
Self.GetData()).Instance).Name;
EXCEPT
END;

IF (TJvInspectorPropData(Self.GetData()).Instance IS TWxPopupMenu) THEN
BEGIN

mnuDlg := TMenuItemForm.Create(GetParentForm(Inspector), MenuName);
TRY
BEGIN
pMenuItem :=
TWxPopupMenu(TJvInspectorPropData(
Self.GetData()).Instance);
maxControlValue := GetMaxIDofWxForm(pMenuItem.parent);
mnuDlg.SetMaxID(maxControlValue);
mnuDlg.SetMenuItemsDes(pMenuItem.Parent, pMenuItem,
TWxCustomMenuItem(
pMenuItem.Wx_MenuItems), mnuDlg.FMenuItems);

IF mnuDlg.ShowModal = mrOk THEN
BEGIN

pMenuItem.Wx_MenuItems.Destroy;
pMenuItem.Wx_MenuItems :=
TWxCustomMenuItem.Create(pMenuItem);
mnuDlg.SetMenuItemsDes(pMenuItem.Parent,
pMenuItem, mnuDlg.FMenuItems,
TWxCustomMenuItem(pMenuItem.Wx_MenuItems));

IF assigned(
TJvInspector(GetInspector).OnDataValueChanged) THEN
TJvInspector(GetInspector).OnDataValueChanged(
NIL, Data);

END;

END;

FINALLY
mnuDlg.Destroy;
END;

END;

IF (TJvInspectorPropData(Self.GetData()).Instance IS TWxMenuBar) THEN
BEGIN

mnuDlg := TMenuItemForm.Create(GetParentForm(Inspector), MenuName);
TRY
BEGIN

mbItem :=
TWxMenuBar(TJvInspectorPropData(Self.GetData()).Instance);
maxControlValue := GetMaxIDofWxForm(mbItem.parent);
mnuDlg.SetMaxID(maxControlValue);
mnuDlg.SetMenuItemsDes(mbItem.Parent, mbItem,
TWxCustomMenuItem(
mbItem.Wx_MenuItems), mnuDlg.FMenuItems);

IF mnuDlg.ShowModal = mrOk THEN
BEGIN

mbItem.Wx_MenuItems.Destroy;
mbItem.Wx_MenuItems :=
TWxCustomMenuItem.Create(mbItem);
mnuDlg.SetMenuItemsDes(mbItem.Parent,
mbItem, mnuDlg.FMenuItems,
TWxCustomMenuItem(mbItem.Wx_MenuItems));
mbItem.BuildMenus(mbItem.Wx_MenuItems);

IF assigned(
TJvInspector(GetInspector).OnDataValueChanged) THEN
TJvInspector(
GetInspector).OnDataValueChanged(NIL, Data);

END;
END;
FINALLY
mnuDlg.Destroy;
END;

END;

END;



FUNCTION TJvInspectorMenuItem.GetDisplayValue: STRING;
BEGIN
Result := 'Edit MenuItems';
END;

PROCEDURE TJvInspectorMenuItem.SetDisplayValue(CONST Value: STRING);
BEGIN

END;

PROCEDURE TJvInspectorMenuItem.SetFlags(CONST Value: TInspectorItemFlags);
VAR
NewValue: TInspectorItemFlags;
BEGIN
NewValue := Value + [iifEditButton];
INHERITED SetFlags(NewValue);
END;

CLASS PROCEDURE TJvInspectorMenuItem.RegisterAsDefaultItem;
BEGIN
WITH TJvCustomInspectorData.ItemRegister DO
IF IndexOf(Self) = -1 THEN
Add(TJvInspectorTypeInfoRegItem.Create(Self,
TypeInfo(TWxCustomMenuItem)));
END;

PROCEDURE TJvInspectorFileNameEditItem.Edit;
VAR
FileOpenForm: TOpenDialogEx;
WxFileNameString: TWxFileNameString;
BEGIN

IF NOT Assigned(Data) THEN
exit;

WxFileNameString := TWxFileNameString(Data.AsOrdinal);

FileOpenForm := TOpenDialogEx.Create(wx_designer.ownerForm);
FileOpenForm.Filter := 'All files (*.*)|*.*';

IF (FileOpenForm.Execute) THEN // If a file is selected
WxFileNameString.FstrFileNameValue := FileOpenForm.FileName
ELSE // If Cancel is pushed, then remove file to load
WxFileNameString.FstrFileNameValue := '';

    // if strEqual(UpperCase((TJvInspectorPropData(Self.GetData()).Instance).ClassName), UpperCase('TWxMemo')) then
    //       TWxMemo(TJvInspectorPropData(Self.GetData()).Instance).SetWxFileName(WxFileNameString.FstrFileNameValue);

    // Tony 15 May 2005
    // Unfortunately, I need to do the OnDataValueChanged twice to get the
    // wxform to update. Problem is that I need to invoke SetWxFileName procedure
    // in the calling function (at this point WxMemo). The 2 lines above should
    // do this (TWxMemo(...)), but I compiler complains that it can't find TWxMemo
IF assigned(TJvInspector(GetInspector).OnDataValueChanged) THEN
BEGIN
TJvInspector(GetInspector).OnDataValueChanged(NIL, Data);
TJvInspector(GetInspector).OnDataValueChanged(NIL, Data);
END;

END;

FUNCTION TJvInspectorFileNameEditItem.GetDisplayValue: STRING;
VAR
WxFileNameString: TWxFileNameString;
BEGIN

IF NOT Assigned(Data) THEN
exit;

WxFileNameString := TWxFileNameString(Data.AsOrdinal);

Result := 'File to load';

IF trim(WxFileNameString.FstrFileNameValue) <> '' THEN
Result := WxFileNameString.FstrFileNameValue;
END;

PROCEDURE TJvInspectorFileNameEditItem.SetFlags(
CONST Value: TInspectorItemFlags);
VAR
NewValue: TInspectorItemFlags;
BEGIN
NewValue := Value + [iifEditButton];
INHERITED SetFlags(NewValue);
END;

///////////////////////////////////
//mal
///////////////////////////////////
PROCEDURE TJvInspectorAnimationFileNameEditItem.Edit;
VAR
FileOpenForm: TOpenDialog;
WxAnimationFileNameString: TWxAnimationFileNameString;
BEGIN

WxAnimationFileNameString := TWxAnimationFileNameString(Data.AsOrdinal);

FileOpenForm := TOpenDialog.Create(GetParentForm(Inspector));
FileOpenForm.Filter :=
'Animated GIF files (*.gif)|*.GIF|Animated Cursor files (*.ani)|*.ANI';

IF (FileOpenForm.Execute) THEN // If a file is selected
WxAnimationFileNameString.FstrFileNameValue := FileOpenForm.FileName
ELSE // If Cancel is pushed, then remove file to load
WxAnimationFileNameString.FstrFileNameValue := '';

    // Tony 1 May 2008
    // Unfortunately, I need to do the OnDataValueChanged twice to get the
    // wxform to update. Problem is that I need to invoke SetWxFileName procedure
    // in the calling function (at this point WxAnimationCtrl). The 2 lines above should
    // do this (TWxMemo(...)), but I compiler complains that it can't find TWxMemo
IF assigned(TJvInspector(GetInspector).OnDataValueChanged) THEN
BEGIN
TJvInspector(GetInspector).OnDataValueChanged(NIL, Data);
TJvInspector(GetInspector).OnDataValueChanged(NIL, Data);
END;

END;

FUNCTION TJvInspectorAnimationFileNameEditItem.GetDisplayValue: STRING;
VAR
WxAnimationFileNameString: TWxAnimationFileNameString;
BEGIN

IF NOT Assigned(Data) THEN
exit;

WxAnimationFileNameString := TWxAnimationFileNameString(Data.AsOrdinal);

Result := 'File to load';

IF trim(WxAnimationFileNameString.FstrFileNameValue) <> '' THEN
Result := WxAnimationFileNameString.FstrFileNameValue;
END;

PROCEDURE TJvInspectorAnimationFileNameEditItem.SetFlags(
CONST Value: TInspectorItemFlags);
VAR
NewValue: TInspectorItemFlags;
BEGIN
NewValue := Value + [iifEditButton];
INHERITED SetFlags(NewValue);
END;

///////////////////////////////////

// Added by Tony Reina 20 June 2006
// We need a TButton class that will allow for the caption to be aligned
// I found this code at the Delphi Central website: http://www.delphi-central.com/tbut.aspx
//  BEGIN: TMultiLineBtn

CONSTRUCTOR TMultiLineBtn.Create(AOwner: TComponent);
BEGIN
INHERITED Create(AOwner);
fMultiLine := TRUE;
fHorizAlign := halCentre;
fVerticalAlign := valCentre;
END;

PROCEDURE TMultiLineBtn.SetVerticalAlign(Value: TVerticalAlign);
BEGIN
IF fVerticalAlign <> Value THEN
BEGIN
fVerticalAlign := Value;
RecreateWnd;
END;
END;

PROCEDURE TMultiLineBtn.SetHorizAlign(Value: THorizAlign);
BEGIN
IF fHorizAlign <> Value THEN
BEGIN
fHorizAlign := Value;
RecreateWnd;
END;
END;

PROCEDURE TMultiLineBtn.SetMultiLine(Value: BOOLEAN);
BEGIN
IF fMultiLine <> Value THEN
BEGIN
fMultiLine := Value;
RecreateWnd;
END;
END;

PROCEDURE TMultiLineBtn.CreateParams(VAR Params: TCreateParams);
BEGIN
INHERITED CreateParams(Params);
CASE VerticalAlign OF
valTop:
Params.Style := Params.Style OR BS_TOP;
valBottom:
Params.Style := Params.Style OR BS_BOTTOM;
valCentre:
Params.Style := Params.Style OR BS_VCENTER;
END;

CASE HorizAlign OF
halLeft:
Params.Style := Params.Style OR BS_LEFT;
halRight:
Params.Style := Params.Style OR BS_RIGHT;
halCentre:
Params.Style := Params.Style OR BS_CENTER;
END;

IF MultiLine THEN
Params.Style := Params.Style OR BS_MULTILINE
ELSE
Params.Style := Params.Style AND NOT BS_MULTILINE;
END;

// END: TMultiLineBtn

FUNCTION CreateBlankXRC: TStringList;
BEGIN

Result := TStringList.Create;

TRY

Result.Add('<?xml version="1.0" encoding="ISO-8859-1"?>');
Result.Add('<resource version="2.3.0.1">');
Result.Add('<!-- Created by ' + DEVCPP + ' ' + WXDEVCPP_VERSION + ' -->');

        // Result.Add(Format('<object class="%s" name="%s">', [frmNewForm.Wx_class, frmNewForm.Wx_Name]));

        //Result.Add('</object>');
Result.Add('</resource>');

EXCEPT
Result.Destroy;
END;
END;

FUNCTION GetExtension(FileName: STRING): STRING;
BEGIN
IF (UpperCase(ExtractFileExt(FileName)) = '.JPG') THEN
Result := 'JPEG'
ELSE
IF (UpperCase(ExtractFileExt(FileName)) = '.JPEG') THEN
Result := 'JPEG'
ELSE
IF (UpperCase(ExtractFileExt(FileName)) = '.ICO') THEN
Result := 'ICO'
ELSE
IF (UpperCase(ExtractFileExt(FileName)) = '.BMP') THEN
Result := 'BMP'
ELSE
IF (UpperCase(ExtractFileExt(FileName)) = '.GIF') THEN
Result := 'GIF'
ELSE
IF (UpperCase(ExtractFileExt(FileName)) = '.PNG') THEN
Result := 'PNG'
ELSE
Result := 'XPM';

END;

FUNCTION GetLongName(CONST ShortPathName: STRING): STRING;
VAR
hKernel32Dll: THandle;
fncGetLongPathName: FUNCTION(lpszShortPath: LPCTSTR; lpszLongPath: LPTSTR;
cchBuffer: DWORD): DWORD STDCALL;
bSuccess: BOOLEAN;
szBuffer: ARRAY[0..MAX_PATH] OF CHAR;
pDesktop: IShellFolder;
swShortPath: WIDESTRING;
iEaten: ULONG;
pItemList: PItemIDList;
iAttributes: ULONG;
BEGIN
    // try to find the function "GetLongPathNameA" (Windows 98/2000)
hKernel32Dll := GetModuleHandle('Kernel32.dll');
IF (hKernel32Dll <> 0) THEN
@fncGetLongPathName := GetProcAddress(hKernel32Dll, 'GetLongPathNameA')
ELSE
@fncGetLongPathName := NIL;
    // use the function "GetLongPathNameA" if available
bSuccess := FALSE;
IF (Assigned(fncGetLongPathName)) THEN
BEGIN
bSuccess := fncGetLongPathName(PCHAR(ShortPathName), szBuffer,
SizeOf(szBuffer)) > 0;
IF bSuccess THEN
Result := szBuffer;
END;
    // use an alternative way of getting the path (Windows 95/NT)
IF (NOT bSuccess) AND Succeeded(SHGetDesktopFolder(pDesktop)) THEN
BEGIN
swShortPath := ShortPathName;
iAttributes := 0;
IF Succeeded(pDesktop.ParseDisplayName(0, NIL, POLESTR(swShortPath),
iEaten, pItemList, iAttributes)) THEN
BEGIN
bSuccess := SHGetPathFromIDList(pItemList, szBuffer);
IF bSuccess THEN
Result := szBuffer;
            // release ItemIdList (SHGetMalloc is superseded)
CoTaskMemFree(pItemList);
END;
END;
    // give back the original path if unsuccessful
IF (NOT bSuccess) THEN
Result := ShortPathName;
END;

FUNCTION strContains(CONST S1, S2: STRING): BOOLEAN;
BEGIN
Result := Pos(S1, S2) > 0;
END;

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

FUNCTION ValidateClassName(ClassName: STRING): INTEGER;
VAR
NumberOfErrors, LoopIndex: INTEGER;
ReservedKeywordList: TStrings;
BEGIN

NumberOfErrors := 0;

    //Check we have a name to work with
IF Length(ClassName) < 1 THEN
BEGIN
NumberOfErrors := NumberOfErrors + 1;
END
    //Check the first character is not a number
ELSE
IF (ClassName[1] IN ['0'..'9']) THEN
BEGIN
NumberOfErrors := NumberOfErrors + 1;
END;

    //Look for invalid characters in the class name
FOR LoopIndex := 1 TO Length(ClassName) DO
BEGIN
        //if not((ClassName[LoopIndex] in ['a'..'z']) or (ClassName[LoopIndex] in ['A'..'Z']) or (ClassName[LoopIndex] in ['0'..'9']) or (ClassName[LoopIndex] = '_')) then
IF NOT ((ClassName[LoopIndex] IN ['a'..'z', 'A'..'Z', '0'..'9', '_'])) THEN
BEGIN
NumberOfErrors := NumberOfErrors + 1;
END;
END;

    //Check we haven't ended up with a reserved keyword
ReservedKeywordList := TStringList.Create;
TRY
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
FOR LoopIndex := 0 TO ReservedKeywordList.Count - 1 DO
BEGIN
IF (CompareStr(ReservedKeywordList[LoopIndex], ClassName) = 0) THEN
BEGIN
NumberOfErrors := NumberOfErrors + 1;
END;
END;

FINALLY
ReservedKeywordList.Free; { destroy the list object }
END;

Result := NumberOfErrors;

END;

FUNCTION CreateValidClassName(ClassName: STRING): STRING;
VAR
ValidClassName: STRING;
LoopIndex: INTEGER;
ReservedKeywordList: TStrings;
BEGIN

ValidClassName := ClassName;

    //Check we have a name to work with, if not then assign a safe one
IF Length(ValidClassName) < 1 THEN
ValidClassName := 'DefaultClassName';

    //Look for invalid characters in the class name. Replace with '_'
FOR LoopIndex := 1 TO Length(ValidClassName) DO
BEGIN
IF NOT ((ValidClassName[LoopIndex] IN ['a'..'z', 'A'..'Z',
'0'..'9', '_'])) THEN
BEGIN
ValidClassName[LoopIndex] := '_';
END;
END;

    //Check the first character is not a number if so add '_' in front
IF (ValidClassName[1] IN ['0'..'9']) THEN
BEGIN
Insert('_', ValidClassName, 0);
END;

    //Check we haven't ended up with a reserved keyword
ReservedKeywordList := TStringList.Create;
TRY
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
FOR LoopIndex := 0 TO ReservedKeywordList.Count - 1 DO
BEGIN
IF (CompareStr(ReservedKeywordList[LoopIndex], ValidClassName) = 0) THEN
BEGIN
Insert('_', ValidClassName, 0);
END;
END;

FINALLY
ReservedKeywordList.Free; { destroy the list object }
END;

Result := ValidClassName;

END;

FUNCTION ValidateFileName(FileName: STRING): INTEGER;
VAR
NumberOfErrors, LoopIndex: INTEGER;
BEGIN

NumberOfErrors := 0;

IF Length(FileName) < 1 THEN
NumberOfErrors := NumberOfErrors + 1;

    //Look for invalid characters in the file name
FOR LoopIndex := 1 TO Length(FileName) DO
BEGIN
IF ((FileName[LoopIndex] IN ['"', '*', ':', '<', '>', '?', '|'])) THEN
BEGIN
NumberOfErrors := NumberOfErrors + 1;
END;
END;

Result := NumberOfErrors;

END;

FUNCTION CreateValidFileName(FileName: STRING): STRING;
VAR
ValidFileName: STRING;
LoopIndex: INTEGER;
BEGIN

ValidFileName := FileName;

IF Length(ValidFileName) < 1 THEN
ValidFileName := 'DefaultFileName';

    //Look for invalid characters in the file name. Replace with '_'
FOR LoopIndex := 1 TO Length(ValidFileName) DO
BEGIN
IF ((ValidFileName[LoopIndex] IN ['"', '*', ':', '<', '>', '?', '|'])) THEN
BEGIN
ValidFileName[LoopIndex] := '_';
END;
END;

Result := ValidFileName;

END;

PROCEDURE PopulateAuiGenericProperties(VAR PropertyList: TStringList);
BEGIN
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
END;

FUNCTION GetAuiManagerName(Control: TControl): STRING;
VAR
frmMainObj: TCustomForm;
I: INTEGER;
BEGIN
Result := '';

frmMainObj := GetParentForm(Control);
FOR I := 0 TO frmMainObj.ComponentCount - 1 DO // Iterate
IF frmMainObj.Components[i] IS TWxAuiManager THEN
BEGIN
Result := frmMainObj.Components[i].Name;
exit;
END;

    //    Result := 'WxAuiManager1';
END;

FUNCTION FormHasAuiManager(Control: TControl): BOOLEAN;
VAR
frmMainObj: TCustomForm;
I: INTEGER;
BEGIN
Result := FALSE;

frmMainObj := GetParentForm(Control);
FOR I := 0 TO frmMainObj.ComponentCount - 1 DO // Iterate
IF frmMainObj.Components[i] IS TWxAuiManager THEN
BEGIN
Result := TRUE;
exit;
END;
END;

FUNCTION GetAuiDockDirection(Wx_Aui_Dock_Direction:
TwxAuiPaneDockDirectionItem): STRING;
BEGIN
Result := '';
IF Wx_Aui_Dock_Direction = wxAUI_DOCK_NONE THEN
BEGIN
Result := '';
exit;
END;
IF Wx_Aui_Dock_Direction = wxAUI_DOCK_TOP THEN
BEGIN
Result := '.Top()';
exit;
END;
IF Wx_Aui_Dock_Direction = wxAUI_DOCK_RIGHT THEN
BEGIN
Result := '.Right()';
exit;
END;
IF Wx_Aui_Dock_Direction = wxAUI_DOCK_BOTTOM THEN
BEGIN
Result := '.Bottom()';
exit;
END;
IF Wx_Aui_Dock_Direction = wxAUI_DOCK_LEFT THEN
BEGIN
Result := '.Left()';
exit;
END;
IF Wx_Aui_Dock_Direction = wxAUI_DOCK_CENTER THEN
BEGIN
Result := '.Center()';
exit;
END;
END;

FUNCTION GetAui_Pane_Style(Wx_Aui_Pane_Style: TwxAuiPaneStyleSet): STRING;
BEGIN
Result := '';
IF CaptionVisible IN Wx_Aui_Pane_Style THEN
Result := Result + '.CaptionVisible(true)'
ELSE
Result := Result + '.CaptionVisible(false)';

IF DestroyOnClose IN Wx_Aui_Pane_Style THEN
Result := Result + '.DestroyOnClose(true)'
ELSE
Result := Result + '.DestroyOnClose(false)';

IF DockFixed IN Wx_Aui_Pane_Style THEN
Result := Result + '.DockFixed()';

IF Floatable IN Wx_Aui_Pane_Style THEN
Result := Result + '.Floatable(true)'
ELSE
Result := Result + '.Floatable(false)';

IF Gripper IN Wx_Aui_Pane_Style THEN
Result := Result + '.Gripper(true)'
ELSE
Result := Result + '.Gripper(false)';

IF GripperTop IN Wx_Aui_Pane_Style THEN
Result := Result + '.GripperTop()';

IF Movable IN Wx_Aui_Pane_Style THEN
Result := Result + '.Movable()';

IF PaneBorder IN Wx_Aui_Pane_Style THEN
Result := Result + '.PaneBorder()';

IF ToolbarPane IN Wx_Aui_Pane_Style THEN
BEGIN
Result := Result + '.ToolbarPane()';
END
ELSE
BEGIN
IF Resizable IN Wx_Aui_Pane_Style THEN
Result := Result + '.Resizable(true)'
ELSE
Result := Result + '.Resizable(false)';
END;

IF CenterPane IN Wx_Aui_Pane_Style THEN
Result := Result + '.CenterPane()';

END;

FUNCTION GetAuiDockableDirections(Wx_Aui_Dockable_Direction:
TwxAuiPaneDockableDirectionSet): STRING;
BEGIN
Result := '';
IF (LeftDockable IN Wx_Aui_Dockable_Direction) AND
(RightDockable IN Wx_Aui_Dockable_Direction)
AND (TopDockable IN Wx_Aui_Dockable_Direction) AND
(BottomDockable IN Wx_Aui_Dockable_Direction) THEN
BEGIN
Result := Result + '.Dockable(true)';
Exit;
END;

IF NOT (LeftDockable IN Wx_Aui_Dockable_Direction) AND NOT
(RightDockable IN Wx_Aui_Dockable_Direction)
AND NOT (TopDockable IN Wx_Aui_Dockable_Direction) AND NOT
(BottomDockable IN Wx_Aui_Dockable_Direction) THEN
BEGIN
Result := Result + '.Dockable(false)';
Exit;
END;

IF LeftDockable IN Wx_Aui_Dockable_Direction THEN
Result := Result + '.LeftDockable(true)'
ELSE
Result := Result + '.LeftDockable(false)';

IF RightDockable IN Wx_Aui_Dockable_Direction THEN
Result := Result + '.RightDockable(true)'
ELSE
Result := Result + '.RightDockable(false)';

IF TopDockable IN Wx_Aui_Dockable_Direction THEN
Result := Result + '.TopDockable(true)'
ELSE
Result := Result + '.TopDockable(false)';

IF BottomDockable IN Wx_Aui_Dockable_Direction THEN
Result := Result + '.BottomDockable(true)'
ELSE
Result := Result + '.BottomDockable(false)';
END;

FUNCTION GetAui_Pane_Buttons(Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet): STRING;
BEGIN
Result := '';

IF CloseButton IN Wx_Aui_Pane_Buttons THEN
Result := Result + '.CloseButton()';

IF MaximizeButton IN Wx_Aui_Pane_Buttons THEN
Result := Result + '.MaximizeButton()';

IF MinimizeButton IN Wx_Aui_Pane_Buttons THEN
Result := Result + '.MinimizeButton()';

IF PinButton IN Wx_Aui_Pane_Buttons THEN
Result := Result + '.PinButton()';
END;

FUNCTION GetAuiRow(row: INTEGER): STRING;
BEGIN
Result := Format('.Row(%d)', [row]);
END;

FUNCTION GetAuiPosition(position: INTEGER): STRING;
BEGIN
Result := Format('.Position(%d)', [position]);
END;

FUNCTION GetAuiLayer(layer: INTEGER): STRING;
BEGIN
Result := Format('.Layer(%d)', [layer]);
END;

FUNCTION GetAuiPaneBestSize(width: INTEGER; height: INTEGER): STRING;
BEGIN
Result := '';
IF (height > 0) AND (width > 0) THEN
Result := Format('.BestSize(wxSize(%d, %d))', [width, height]);
END;

FUNCTION GetAuiPaneMinSize(width: INTEGER; height: INTEGER): STRING;
BEGIN
Result := '';
IF (height > 0) AND (width > 0) THEN
Result := Format('.MinSize(wxSize(%d, %d))', [width, height]);
END;

FUNCTION GetAuiPaneMaxSize(width: INTEGER; height: INTEGER): STRING;
BEGIN
Result := '';
IF (width > 0) AND (height > 0) THEN
Result := Format('.MaxSize(wxSize(%d, %d))', [width, height]);
END;

FUNCTION GetAuiPaneFloatingSize(width: INTEGER; height: INTEGER): STRING;
BEGIN
Result := '';
IF (width > 0) AND (height > 0) THEN
Result := Format('.FloatingSize(wxSize(%d, %d))', [width, height]);
END;

FUNCTION GetAuiPaneFloatingPos(x: INTEGER; y: INTEGER): STRING;
BEGIN
Result := '';
IF (x > 0) AND (y > 0) THEN
Result := Format('.FloatingPosition(wxPoint(%d, %d))', [x, y]);
END;

FUNCTION GetAuiPaneCaption(caption: STRING): STRING;
BEGIN
IF trim(caption) = '' THEN
Result := ''
ELSE
Result := Format('.Caption(wxT("%s"))', [caption]);
END;

FUNCTION GetAuiPaneName(name: STRING): STRING;
BEGIN
Result := Format('.Name(wxT("%s"))', [name]);
END;

FUNCTION HasToolbarPaneStyle(Wx_Aui_Pane_Style: TwxAuiPaneStyleSet): BOOLEAN;
BEGIN
Result := ToolbarPane IN Wx_Aui_Pane_Style;
END;

FUNCTION LocalAppDataPath: STRING;
CONST
CSIDL_PERSONAL = $0005;
    { My Documents.  This is equivalent to CSIDL_MYDOCUMENTS in XP and above }
VAR
path: ARRAY [0..MaxChar] OF CHAR;
BEGIN
SHGetFolderPath(0, CSIDL_PERSONAL, 0, CSIDL_PERSONAL, @path[0]);
Result := path;
END;

FUNCTION GetRefinedWxEdtGeneralStyleValue(
sValue: TWxEdtGeneralStyleSet): TWxEdtGeneralStyleSet;
BEGIN
Result := [];

TRY

IF wxTE_PROCESS_ENTER IN sValue THEN
Result := Result + [wxTE_PROCESS_ENTER];

IF wxTE_PROCESS_TAB IN sValue THEN
Result := Result + [wxTE_PROCESS_TAB];

IF wxTE_PASSWORD IN sValue THEN
Result := Result + [wxTE_PASSWORD];

IF wxTE_READONLY IN sValue THEN
Result := Result + [wxTE_READONLY];

IF wxTE_RICH IN sValue THEN
Result := Result + [wxTE_RICH];

IF wxTE_RICH2 IN sValue THEN
Result := Result + [wxTE_RICH2];

IF wxTE_NO_VSCROLL IN sValue THEN
Result := Result + [wxTE_NO_VSCROLL];

IF wxTE_AUTO_URL IN sValue THEN
Result := Result + [wxTE_AUTO_URL];

IF wxTE_NOHIDESEL IN sValue THEN
Result := Result + [wxTE_NOHIDESEL];

IF wxTE_LEFT IN sValue THEN
Result := Result + [wxTE_LEFT];

IF wxTE_CENTRE IN sValue THEN
Result := Result + [wxTE_CENTRE];

IF wxTE_RIGHT IN sValue THEN
Result := Result + [wxTE_RIGHT];

IF wxTE_DONTWRAP IN sValue THEN
Result := Result + [wxTE_DONTWRAP];

IF wxTE_BESTWRAP IN sValue THEN
Result := Result + [wxTE_BESTWRAP];

IF wxTE_CHARWRAP IN sValue THEN
Result := Result + [wxTE_CHARWRAP];

IF wxTE_LINEWRAP IN sValue THEN
Result := Result + [wxTE_LINEWRAP];

IF wxTE_WORDWRAP IN sValue THEN
Result := Result + [wxTE_WORDWRAP];

IF wxTE_CAPITALIZE IN sValue THEN
Result := Result + [wxTE_CAPITALIZE];

IF wxTE_MULTILINE IN sValue THEN
Result := Result + [wxTE_MULTILINE];

FINALLY
sValue := [];
END;

END;

END.
