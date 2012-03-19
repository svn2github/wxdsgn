{
    This file is part of Dev-C++
    Copyright (c) 2004 Bloodshed Software

    Dev-C++ is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Dev-C++ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Dev-C++; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

{$WARN UNIT_PLATFORM OFF}

Unit EditorOptfrm;

Interface

Uses
 //dbugintf,  EAB removed Gexperts debug stuff.
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms, 
    Dialogs, ComCtrls, devTabs, StdCtrls, ExtCtrls, Spin, ColorPickerButton,
    SynEdit, SynEditHighlighter, SynHighlighterCpp, CheckLst, SynMemo, FileCtrl,
    Buttons, ClassBrowser, CppParser, CppTokenizer, StrUtils, XPMenu, Classes;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, QGraphics, QControls, QForms,
  QDialogs, QComCtrls, devTabs, QStdCtrls, QExtCtrls, ColorPickerButton,
  QSynEdit, QSynEditHighlighter, QSynHighlighterCpp, QCheckLst, QSynMemo,
  QButtons, ClassBrowser, CppParser, CppTokenizer, StrUtils, Types;
{$ENDIF}

Type
    TEditorOptForm = Class(TForm)
        PagesMain: TPageControl;
        tabDisplay: TTabSheet;
        grpGutter: TGroupBox;
        cbGutterVis: TCheckBox;
        cbGutterAuto: TCheckBox;
        cbLineNum: TCheckBox;
        cbFirstZero: TCheckBox;
        cbLeadZero: TCheckBox;
        cbGutterFnt: TCheckBox;
        pnlGutterPreview: TPanel;
        lblGutterFont: TLabel;
        cboGutterFont: TComboBox;
        lblGutterWidth: TLabel;
        lblGutterFontSize: TLabel;
        cboGutterSize: TComboBox;
        tabGeneral: TTabSheet;
        tabSyntax: TTabSheet;
        CppEdit: TSynEdit;
        ElementList: TListBox;
        cpp: TSynCppSyn;
        grpEditorFont: TGroupBox;
        lblEditorSize: TLabel;
        lblEditorFont: TLabel;
        cboEditorFont: TComboBox;
        cboEditorSize: TComboBox;
        pnlEditorPreview: TPanel;
        grpMargin: TGroupBox;
        lblMarginWidth: TLabel;
        lblMarginColor: TLabel;
        cpMarginColor: TColorPickerButton;
        cbMarginVis: TCheckBox;
        grpCaret: TGroupBox;
        lblInsertCaret: TLabel;
        lblOverCaret: TLabel;
        cboInsertCaret: TComboBox;
        cboOverwriteCaret: TComboBox;
        tabCode: TTabSheet;
        codepages: TPageControl;
        tabCPInserts: TTabSheet;
        tabCPDefault: TTabSheet;
        seDefault: TSynEdit;
        btnAdd: TButton;
        btnEdit: TButton;
        btnRemove: TButton;
        lvCodeins: TListView;
        lblCode: TLabel;
        btnOk: TBitBtn;
        btnCancel: TBitBtn;
        btnHelp: TBitBtn;
        cboQuickColor: TComboBox;
        lblElements: TLabel;
        lblSpeed: TLabel;
        CodeIns: TSynEdit;
        tabClassBrowsing: TTabSheet;
        chkEnableClassBrowser: TCheckBox;
        devPages1: TPageControl;
        tabCBBrowser: TTabSheet;
        tabCBCompletion: TTabSheet;
        lblClassBrowserSample: TLabel;
        ClassBrowser1: TClassBrowser;
        gbCBEngine: TGroupBox;
        chkCBParseGlobalH: TCheckBox;
        chkCBParseLocalH: TCheckBox;
        gbCBView: TGroupBox;
        lblCompletionDelay: TLabel;
        cpCompletionBackground: TColorPickerButton;
        lblCompletionColor: TLabel;
        chkEnableCompletion: TCheckBox;
        chkCBUseColors: TCheckBox;
        chkCCCache: TCheckBox;
        CppTokenizer1: TCppTokenizer;
        CppParser1: TCppParser;
        lbCCC: TListBox;
        lblCCCache: TLabel;
        pbCCCache: TProgressBar;
        XPMenu: TXPMenu;
        chkCBShowInherited: TCheckBox;
        cbMatch: TCheckBox;
        edMarginWidth: TSpinEdit;
        edGutterWidth: TSpinEdit;
        lblEditorOpts: TGroupBox;
        cbAppendNewline: TCheckBox;
        cbSpecialChars: TCheckBox;
        cbDropFiles: TCheckBox;
        cbGroupUndo: TCheckBox;
        cbSmartUnIndent: TCheckBox;
        cbTrailingBlanks: TCheckBox;
        cbTabtoSpaces: TCheckBox;
        cbSmartTabs: TCheckBox;
        cbInsertMode: TCheckBox;
        cbAutoIndent: TCheckBox;
        cbPastEOL: TCheckBox;
        cbFindText: TCheckBox;
        cbHalfPage: TCheckBox;
        cbScrollHint: TCheckBox;
        cbParserHints: TCheckBox;
        cbSmartScroll: TCheckBox;
        cbDoubleLine: TCheckBox;
        cbEHomeKey: TCheckBox;
        cbPastEOF: TCheckBox;
        btnCCCnew: TButton;
        btnCCCdelete: TButton;
        lblTabSize: TLabel;
        seTabSize: TSpinEdit;
        cbSyntaxHighlight: TCheckBox;
        cbHighCurrLine: TCheckBox;
        cpHighColor: TColorPickerButton;
        grpStyle: TGroupBox;
        lblForeground: TLabel;
        cpForeground: TColorPickerButton;
        lblBackground: TLabel;
        cpBackground: TColorPickerButton;
        cbBold: TCheckBox;
        cbItalic: TCheckBox;
        cbUnderlined: TCheckBox;
        edSyntaxExt: TEdit;
        btnSaveSyntax: TSpeedButton;
        lblSyntaxExt: TLabel;
        cbDefaultintoprj: TCheckBox;
        edCompletionDelay: TSpinEdit;
        cbGutterGradient: TCheckBox;
    btnAddNewFolder: TButton;
    txtLoadingCache: TLabel;
        Procedure FormCreate(Sender: TObject);
        Procedure FormShow(Sender: TObject);
        Procedure FormActivate(Sender: TObject);
        Procedure ElementListClick(Sender: TObject);
        Procedure actSelectFileClick(Sender: TObject);
        Procedure FontChange(Sender: TObject);
        Procedure FontSizeChange(Sender: TObject);
        Procedure cpMarginColorHint(Sender: TObject; Cell: Integer;
            Var Hint: String);
        Procedure cpMarginColorDefaultSelect(Sender: TObject);
        Procedure cppEditStatusChange(Sender: TObject; Changes: TSynStatusChanges);
        Procedure DefaultSelect(Sender: TObject);
        Procedure PickerHint(Sender: TObject; Cell: Integer; Var Hint: String);
        Procedure StyleChange(Sender: TObject);
        Procedure cbLineNumClick(Sender: TObject);
        Procedure cbSyntaxHighlightClick(Sender: TObject);
        Procedure cbGutterFntClick(Sender: TObject);
        Procedure btnAddClick(Sender: TObject);
        Procedure btnEditClick(Sender: TObject);
        Procedure btnRemoveClick(Sender: TObject);
        Procedure btnHelpClick(Sender: TObject);
        Procedure btnOkClick(Sender: TObject);
        Procedure btnCancelClick(Sender: TObject);
        Procedure lvCodeinsColumnClick(Sender: TObject; Column: TListColumn);
        Procedure lvCodeinsCompare(Sender: TObject; Item1, Item2: TListItem;
            Data: Integer; Var Compare: Integer);
        Procedure lvCodeinsSelectItem(Sender: TObject; Item: TListItem;
            Selected: Boolean);
        Procedure CodeInsStatusChange(Sender: TObject;
            Changes: TSynStatusChanges);
        Function FormHelp(Command: Word; Data: Integer;
            Var CallHelp: Boolean): Boolean;
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure cboDblClick(Sender: TObject);
        Procedure cboQuickColorSelect(Sender: TObject);
        Procedure CppEditSpecialLineColors(Sender: TObject; Line: Integer;
            Var Special: Boolean; Var FG, BG: TColor);
        Procedure chkEnableCompletionClick(Sender: TObject);
        Procedure chkEnableClassBrowserClick(Sender: TObject);
        Procedure btnSaveSyntaxClick(Sender: TObject);
        Procedure chkCBUseColorsClick(Sender: TObject);
        Procedure btnCCCnewClick(Sender: TObject);
        Procedure btnCCCdeleteClick(Sender: TObject);
        Procedure chkCCCacheClick(Sender: TObject);
        Procedure CppParser1StartParsing(Sender: TObject);
        Procedure CppParser1EndParsing(Sender: TObject);
        Procedure CppParser1StartSave(Sender: TObject);
        Procedure CppParser1EndSave(Sender: TObject);
        Procedure CppParser1TotalProgress(Sender: TObject; FileName: String;
            Total, Current: Integer);
        Procedure CppParser1CacheProgress(Sender: TObject; FileName: String;
            Total, Current: Integer);
        Procedure CppParser1SaveProgress(Sender: TObject; FileName: String;
            Total, Current: Integer);
        Procedure PagesMainChange(Sender: TObject);
        Procedure chkCBShowInheritedClick(Sender: TObject);
        Procedure OnGutterClick(Sender: TObject; Button: TMouseButton; X, Y,
            Line: Integer; Mark: TSynEditMark);
        Procedure cbHighCurrLineClick(Sender: TObject);
        Procedure seTabSizeChange(Sender: TObject);
    procedure btnAddNewFolderClick(Sender: TObject);
    Private
        ffgColor: TColor;
        fbgColor: TColor;
        fUpdate: Boolean;

        fGutColor: TPoint;
        fBPColor: TPoint;
        fErrColor: TPoint;
        fABPColor: TPoint;
        fSelColor: TPoint;
        HasProgressStarted: Boolean;
        //fBMColor : TPoint;
        Procedure LoadFontNames;
        Procedure LoadFontSize;
        Procedure LoadText;
        Procedure LoadCodeIns;
        Procedure LoadSampleText;
        Procedure GetOptions;
        Procedure SaveCodeIns;
        Procedure UpdateCIButtons;
        Procedure SetGutter;
        Procedure LoadSyntax(Value: String);
        Procedure FillSyntaxSets;
        Procedure FillCCC;
        Function CompactFilename(filename: String): String;
    End;

Var
    EditorOptForm: TEditorOptForm;
Function PathCompactPath(hDC: HDC; lpszPath: Pchar; dx: UINT): Boolean;
    Stdcall;
    External 'shlwapi.dll' Name 'PathCompactPathA';

Implementation

Uses
{$IFDEF WIN32}
    shlobj, MultiLangSupport, devcfg, version, utils, CodeIns, datamod,
    IniFiles, editor, main, hh;
{$ENDIF}
{$IFDEF LINUX}
  Xlib, MultiLangSupport, devcfg, version, utils, CodeIns, datamod, IniFiles, editor,
  main;
{$ENDIF}

{$R *.dfm}
Const
    Help_Topic: Array[0..5] Of String =
        ('html\editor_general.html',
        'html\editor_display.html',
        'html\editor_syntax.html',
        'html\editor_code.html',
        'html\editor_codecompletion.html',
        'html\editor_classbrowsing.html');

    cBreakLine = 9;
    cABreakLine = 11;
    cErrorLine = 13;
    cSelection = 19;
Var
    fUseDefaults: Boolean; // use default array of font sizes
    fGutter: Boolean; // user is editing gutter font

{ ---------- Form Events ---------- }

Procedure TEditorOptForm.FormCreate(Sender: TObject);
Begin
    LoadText;
    LoadCodeIns;
    LoadFontNames;
    LoadSampleText;
    cbLineNumClick(Self);
End;

Procedure TEditorOptForm.FormShow(Sender: TObject);
Begin
    PagesMain.ActivePageIndex := 0;
    CodePages.ActivePageIndex := 0;
End;

Procedure TEditorOptForm.FormActivate(Sender: TObject);
Begin
    GetOptions;
    UpdateCIButtons;
End;

Function TEditorOptForm.FormHelp(Command: Word; Data: Integer;
    Var CallHelp: Boolean): Boolean;
Begin
    result := False;
    // another debug message
    showmessage('Hello from FormHelp');
End;

Procedure TEditorOptForm.FormKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
{$IFDEF WIN32}
    If key = vk_F1 Then
{$ENDIF}
{$IFDEF LINUX}
  if key = XK_F1 then
{$ENDIF}
    Begin
        HelpFile := devDirs.Help + DEV_MAINHELP_FILE;
        HtmlHelp(MainForm.handle, Pchar(HelpFile), HH_DISPLAY_TOPIC,
            DWORD(Pchar(Help_Topic[PagesMain.ActivePageIndex])));
    End;
End;

{ ---------- Font Methods ---------- }

(*
  enum font families callback function
   adds a font to the list if it is of the Modern font family
   i.e. any font that is monospaced (same as delphi)
*)
Function EnumFontFamilyProc(LogFont: PEnumLogFont;
    Var TextMetric: PNewTextMetric;
    FontType: Integer; LParam: Integer): Integer; Stdcall;
Begin
    If LogFont.elfLogFont.lfPitchAndFamily And FF_MODERN = FF_MODERN Then
        TStrings(LParam).Add(LogFont.elfLogFont.lfFaceName);
    result := -1;
End;

// Fills combobox with font names.
// editor and gutter both use same fonts

Procedure TEditorOptForm.LoadFontNames;
Var
    DC: HDC;
Begin
    DC := GetDC(0);
    EnumFontFamilies(DC, Nil, @EnumFontFamilyProc, Integer(cboEditorFont.Items));
    ReleaseDC(0, DC);
    cboEditorFont.Sorted := True;
    cboGutterFont.Items := cboEditorFont.Items;
    cboGutterFont.Sorted := True;
End;

(*
  enum font families callback function for font sizes
  adds font sizes to list.  if font is not a RASTER then
  uses default font sizes (7..30)
*)

Function EnumFontSizeProc(LogFont: PEnumLogFont;
    Var TextMetric: PNewTextMetric;
    FontType: Integer; LParam: Integer): Integer; Stdcall;
Var
    size: String;
Begin
    result := 1;
    If FontType And RASTER_FONTTYPE = RASTER_FONTTYPE Then
    Begin
        Size := inttostr(LogFont.elfLogFont.lfHeight * 72 Div LOGPIXELSY);
        If TStrings(LParam).IndexOf(Size) = -1 Then
            TStrings(LParam).Add(Size);
    End
    Else
    Begin
        fUseDefaults := True;
        result := 0;
    End;
End;

Procedure TEditorOptForm.LoadFontSize;
Var
    idx, idx2: Integer;
    DC: HDC;
    Items: TStrings;
    FontName: String;
Begin
    fUseDefaults := False;
    DC := GetDC(0);
    Items := TStringList.Create;
    Try
        If fGutter Then
            FontName := cboGutterFont.Text
        Else
            FontName := cboEditorFont.Text;

        EnumFontFamilies(DC, Pchar(FontName), @EnumFontSizeProc, Integer(Items));
        If fUseDefaults Then
        Begin
            Items.Clear;
            For idx := 7 To 30 Do
                Items.Append(inttostr(idx));
        End
        Else // sort the returned sizes
            For idx := 1 To 3 Do
                For idx2 := pred(Items.Count) Downto 1 Do
                    If strtointdef(Items[idx2], 0) < strtointdef(Items[idx2 - 1], 0) Then
                        Items.Exchange(idx2, idx2 - 1);
        If fGutter Then
        Begin
            cboGutterSize.Clear;
            cboGutterSize.Items.AddStrings(Items);
        End
        Else
        Begin
            cboEditorSize.Clear;
            cboEditorSize.Items.AddStrings(Items);
        End;
    Finally
        Items.Free;
        ReleaseDC(0, DC);
    End;
End;

Procedure TEditorOptForm.FontSizeChange(Sender: TObject);
    Procedure UpdateSynEdits(ASynEdit: TSynEdit);
    Begin
        If Sender = cboEditorSize Then
        Begin
            pnlEditorPreview.Font.Size := strtointdef(cboEditorsize.Text, 12);
            ASynEdit.Font.Size := strtointdef(cboEditorSize.Text, 12);
            ASynEdit.Refresh;
        End
        Else
        Begin
            pnlGutterPreview.Font.Size := strtointdef(cboGutterSize.Text, 12);
            CppEdit.Gutter.Font.Name := cboGutterFont.Text;
            ASynEdit.Gutter.Font.Size := strtointdef(cboGutterSize.Text, 12);
            ASynEdit.Gutter.Width := strtointdef(edGutterWidth.Text, 12);
            ASynEdit.Refresh;
        End;
    End;
Begin
    Try
        UpdateSynEdits(CppEdit);
        UpdateSynEdits(Self.seDefault);
        UpdateSynEdits(Self.CodeIns);
    Except
        If Sender = cboEditorSize Then
        Begin
            cboEditorSize.Text := '10';
            pnlEditorPreview.Font.Size := 10;
            CppEdit.Font.Size := 10;
            CppEdit.Refresh;
        End
        Else
        Begin
            pnlGutterPreview.Font.Size := 10;
            cboGutterSize.Text := '10';
        End;
    End;
End;

Procedure TEditorOptForm.actSelectFileClick(Sender: TObject);
Begin

     If (lbCCC.ItemIndex >= 0) And
          (lbCCC.ItemIndex < MainForm.CppParser1.ScannedFiles.Count) then
       lbCCC.Hint := MainForm.CppParser1.ScannedFiles.Strings[lbCCC.ItemIndex];

End;

Procedure TEditorOptForm.cbGutterFntClick(Sender: TObject);
Begin
    cboGutterFont.Enabled := cbGutterFnt.Checked;
    cboGutterSize.Enabled := cbGutterfnt.Checked;
End;

{ ---------- Form Init/Done Methods ----------}

Procedure TEditorOptForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    btnOk.Caption := Lang[ID_BTN_OK];
    btnCancel.Caption := Lang[ID_BTN_CANCEL];
    btnHelp.Caption := Lang[ID_BTN_HELP];

    Caption := Lang[ID_EOPT];
    tabGeneral.Caption := Lang[ID_EOPT_GENTAB];
    tabDisplay.Caption := Lang[ID_EOPT_DISPLAYTAB];
    tabSyntax.Caption := Lang[ID_EOPT_SYNTAXTAB];
    tabCode.Caption := Lang[ID_EOPT_CODETAB];
    tabClassBrowsing.Caption := Lang[ID_EOPT_BROWSERTAB];
    tabCBBrowser.Caption := Lang[ID_EOPT_BROWSERTAB];
    tabCBCompletion.Caption := Lang[ID_EOPT_COMPLETIONTAB];

    // sub tabs
    tabCPInserts.Caption := Lang[ID_EOPT_CPINSERTS];
    tabCPDefault.Caption := Lang[ID_EOPT_CPDEFAULT];

    // General Tab
    lblEditorOpts.Caption := Lang[ID_EOPT_EDOPTIONS];
    cbAutoIndent.Caption := Lang[ID_EOPT_AUTOINDENT];
    cbInsertMode.Caption := Lang[ID_EOPT_INSERTMODE];
    cbTabtoSpaces.Caption := Lang[ID_EOPT_TAB2SPC];
    cbSmartTabs.Caption := Lang[ID_EOPT_SMARTTABS];
    cbTrailingBlanks.Caption := Lang[ID_EOPT_TRAILBLANKS];
    cbSmartUnIndent.Caption := Lang[ID_EOPT_SMARTUN];
    cbGroupUndo.Caption := Lang[ID_EOPT_GROUPUNDO];
    cbDropFiles.Caption := Lang[ID_EOPT_DROPFILES];
    cbSpecialChars.Caption := Lang[ID_EOPT_SPECIALCHARS];
    cbAppendNewline.Caption := Lang[ID_EOPT_APPENDNEWLINE];
    cbEHomeKey.Caption := Lang[ID_EOPT_EHOMEKEY];
    cbPastEOF.Caption := Lang[ID_EOPT_PASTEOF];
    cbPastEOL.Caption := Lang[ID_EOPT_PASTEOL];
    cbDoubleLine.Caption := Lang[ID_EOPT_DBLCLKLINE];
    cbFindText.Caption := Lang[ID_EOPT_FINDTEXT];
    cbSmartScroll.Caption := Lang[ID_EOPT_SMARTSCROLL];
    cbHalfPage.Caption := Lang[ID_EOPT_HALFPAGE];
    cbScrollHint.Caption := Lang[ID_EOPT_SCROLLHINT];
    cbParserHints.Caption := Lang[ID_EOPT_PARSERHINTS];

    cbSyntaxHighlight.Caption := Lang[ID_EOPT_USESYNTAX];
    lblTabSize.Caption := Lang[ID_EOPT_TABSIZE];

    grpMargin.Caption := Lang[ID_EOPT_MARGIN];
    cbMarginVis.Caption := Lang[ID_EOPT_VISIBLE];
    lblMarginWidth.Caption := Lang[ID_EOPT_WIDTH];
    lblMarginColor.Caption := Lang[ID_EOPT_COLOR];

    grpCaret.Caption := Lang[ID_EOPT_CARET];
    lblInsertCaret.Caption := Lang[ID_EOPT_INSCARET];
    lblOverCaret.Caption := Lang[ID_EOPT_OVERCARET];
    cbMatch.Caption := Lang[ID_EOPT_MATCH];
    cbHighCurrLine.Caption := Lang[ID_EOPT_HIGHLIGHTCURRLINE];

    cboInsertCaret.Clear;
    cboInsertCaret.Items.Append(Lang[ID_EOPT_CARET1]);
    cboInsertCaret.Items.Append(Lang[ID_EOPT_CARET2]);
    cboInsertCaret.Items.Append(Lang[ID_EOPT_CARET3]);
    cboInsertCaret.Items.Append(Lang[ID_EOPT_CARET4]);

    cboOverwriteCaret.Clear;
    cboOverwriteCaret.Items.Append(Lang[ID_EOPT_CARET1]);
    cboOverwriteCaret.Items.Append(Lang[ID_EOPT_CARET2]);
    cboOverwriteCaret.Items.Append(Lang[ID_EOPT_CARET3]);
    cboOverwriteCaret.Items.Append(Lang[ID_EOPT_CARET4]);

    // Display Tab
    grpEditorFont.Caption := Lang[ID_EOPT_EDFONT];
    lblEditorFont.Caption := Lang[ID_EOPT_FONT];
    lblEditorSize.Caption := Lang[ID_EOPT_SIZE];
    pnlEditorPreview.Caption := Lang[ID_EOPT_EDITORPRE];

    grpGutter.Caption := Lang[ID_EOPT_GUTTER];
    cbGutterVis.Caption := Lang[ID_EOPT_VISIBLE];
    cbGutterAuto.Caption := Lang[ID_EOPT_GUTTERAUTO];
    cbLineNum.Caption := Lang[ID_EOPT_LINENUM];
    cbLeadZero.Caption := Lang[ID_EOPT_LEADZERO];
    cbFirstZero.Caption := Lang[ID_EOPT_FIRSTZERO];
    cbGutterFnt.Caption := Lang[ID_EOPT_GUTTERFNT];
    lblGutterWidth.Caption := Lang[ID_EOPT_WIDTH];
    lblGutterFont.Caption := Lang[ID_EOPT_FONT];
    lblGutterFontSize.Caption := Lang[ID_EOPT_SIZE];
    pnlGutterPreview.Caption := Lang[ID_EOPT_GUTTERPRE];

    // Syntax tab
    lblElements.Caption := Lang[ID_EOPT_ELEMENTS];
    lblForeground.Caption := Lang[ID_EOPT_FORE];
    lblBackground.Caption := Lang[ID_EOPT_BACK];
    grpStyle.Caption := Lang[ID_EOPT_STYLE];
    cbBold.Caption := Lang[ID_EOPT_BOLD];
    cbItalic.Caption := Lang[ID_EOPT_ITALIC];
    cbUnderlined.Caption := Lang[ID_EOPT_UNDERLINE];
    lblSpeed.Caption := Lang[ID_EOPT_SPEED];
    btnSaveSyntax.Hint := Lang[ID_EOPT_SAVESYNTAX];

    // Code Tab
    lblCode.Caption := Lang[ID_EOPT_CICODE];
    lvCodeIns.Columns[0].Caption := Lang[ID_EOPT_CIMENU];
    lvCodeIns.Columns[1].Caption := Lang[ID_EOPT_CISECTION];
    lvCodeIns.Columns[2].Caption := Lang[ID_EOPT_CIDESC];
    cbDefaultintoprj.Caption := Lang[ID_EOPT_DEFCODEPRJ];

    // Completion Tab
    chkEnableCompletion.Caption := Lang[ID_EOPT_COMPLETIONENABLE];
    lblCompletionDelay.Caption := Lang[ID_EOPT_COMPLETIONDELAY];
    lblCompletionColor.Caption := Lang[ID_EOPT_COMPLETIONCOLOR];

    // Class browsing Tab
    gbCBEngine.Caption := Lang[ID_EOPT_BROWSERENGINE];
    gbCBView.Caption := Lang[ID_EOPT_BROWSERVIEW];
    chkEnableClassBrowser.Caption := Lang[ID_EOPT_BROWSERENABLE];
    lblClassBrowserSample.Caption := Lang[ID_EOPT_BROWSERSAMPLE];
    chkCBParseLocalH.Caption := Lang[ID_EOPT_BROWSERLOCAL];
    chkCBParseGlobalH.Caption := Lang[ID_EOPT_BROWSERGLOBAL];
    chkCBUseColors.Caption := Lang[ID_POP_USECOLORS];
    chkCCCache.Caption := Lang[ID_EOPT_CCCACHECHECK];
    lblCCCache.Caption := Lang[ID_EOPT_CCCACHELABEL];
    btnCCCnew.Caption := Lang[ID_BTN_ADD];
    btnCCCdelete.Caption := Lang[ID_BTN_CLEAR];

    btnAdd.Caption := Lang[ID_BTN_ADD];
    btnEdit.Caption := Lang[ID_BTN_EDIT];
    btnRemove.Caption := Lang[ID_BTN_REMOVE];
End;

Procedure TEditorOptForm.LoadSampleText;
Begin
    With cppEdit.Lines Do
    Begin
        append('// Syntax Preview');
        append('#include <iostream>');
        append('#include <cstdio>');
        append('#include <conio.h>');
        append('');
        append('int main(int argc, char **argv)');
        append('{');
        append(#9'int numbers[20];');
        append(#9'float average, total; //breakpoint');
        append(#9'for (int i = 0; i <= 19; i++)');
        append(#9'{ // active breakpoint');
        append(#9#9'numbers[i] = i;');
        append(#9#9'Total += i; // error line');
        append(#9'}');
        append(#9'_asm {');
        append(#9#9'mov dword ptr [numbers], 3 ;This is a comment in Assembly');
        append(#9#9'push eax');
        append(#9#9'push ebx');
        append(#9#9'mov eax, 0');
        append(#9#9'mov ebx, 0');
        append(#9#9'call _main');
        append(#9'}');
        append(#9'average = total / 20;');
        append(#9'cout << numbers[0] << "\n" << numbers[19] << "\n";');
        append(#9'cout << "total: " << total << "\nAverage: " << average;');
        append(#9'printf("\n\nPress any key...");');
        append(#9'getch();');
        append('}');
    End;
End;

Procedure TEditorOptForm.GetOptions;
Var
    aName: String;
    attr: TSynHighlighterAttributes;
    a,
    idx: Integer;
Begin
    With devEditor Do
    Begin
        cboEditorFont.ItemIndex := cboEditorFont.Items.IndexOf(Font.Name);
        cboEditorSize.Text := inttostr(Font.Size);
        FontSizeChange(cboEditorSize);
        FontChange(cboEditorFont);

        cbGutterFnt.Checked := Gutterfnt;
        cboGutterFont.ItemIndex := cboGutterFont.Items.IndexOf(Gutterfont.Name);
        cboGutterSize.Text := inttostr(GutterFont.Size);
        FontSizeChange(cboGutterSize);
        FontChange(cboGutterFont);

        cbGutterAuto.Checked := GutterAuto;
        cbGutterVis.Checked := GutterVis;
        edGutterWidth.Value := GutterSize;
        cbGutterGradient.Checked := GutterGradient;
        cbLineNum.Checked := LineNumbers;
        cbLeadZero.Checked := LeadZero;
        cbFirstZero.Checked := FirstLineZero;

        cbAutoIndent.Checked := AutoIndent;
        cbInsertMode.Checked := InsertMode;
        cbTabtoSpaces.Checked := Not TabToSpaces;
        cbSmartTabs.Checked := SmartTabs;
        cbSmartUnindent.Checked := SmartUnindent;
        cbTrailingBlanks.Checked := Not TrailBlank;
        cbGroupUndo.Checked := GroupUndo;
        cbEHomeKey.Checked := EHomeKey;
        cbPastEOF.Checked := PastEOF;
        cbPastEOL.Checked := PastEOL;
        cbDoubleLine.Checked := DblClkLine;
        cbFindText.Checked := FindText;
        cbSmartScroll.Checked := Scrollbars;
        cbHalfPage.Checked := HalfPageScroll;
        cbScrollHint.Checked := ScrollHint;
        cbSpecialChars.Checked := SpecialChars;
        cbAppendNewline.Checked := AppendNewline;

        cbMarginVis.Checked := MarginVis;
        edMarginWidth.Value := MarginSize;
        cpMarginColor.SelectionColor := MarginColor;

        seTabSize.Value := TabSize;
        cbSyntaxHighlight.Checked := UseSyntax;
        edSyntaxExt.Text := SyntaxExt;
        FillSyntaxSets;
        cboQuickColor.ItemIndex := cboQuickColor.Items.IndexOf(ActiveSyntax);

        cboInsertCaret.ItemIndex := InsertCaret;
        cboOverwriteCaret.ItemIndex := OverwriteCaret;
        cbDropFiles.Checked := InsDropFiles;

        cbParserHints.Checked := ParserHints;
        cbMatch.Checked := Match;
        cbDefaultintoprj.Checked := DefaulttoPrj;

        cbHighCurrLine.Checked := HighCurrLine;
        cpHighColor.SelectionColor := HighColor;
        cpHighColor.Enabled := cbHighCurrLine.Checked;

      //  cbCodeFolding.Checked := CodeFolding;

        StrtoPoint(fGutColor, Syntax.Values[cGut]);
        StrtoPoint(fbpColor, Syntax.Values[cBP]);
        StrtoPoint(fErrColor, Syntax.Values[cErr]);
        StrtoPoint(fABPColor, Syntax.Values[cABP]);
        StrtoPoint(fSelColor, Syntax.Values[cSel]);
    End;

    For idx := 0 To pred(cpp.AttrCount) Do
    Begin
        aName := cpp.Attribute[idx].Name;
        a := devEditor.Syntax.IndexOfName(aName);
        If a <> -1 Then
        Begin
            Attr := TSynHighlighterAttributes.Create(aName);
            Try
                StrtoAttr(Attr, devEditor.Syntax.Values[aName]);
                cpp.Attribute[idx].Assign(attr);
            Finally
                Attr.Free;
            End;
        End
        Else
            devEditor.Syntax.Append(aName);
    End;
    ElementList.Clear;
    For idx := 0 To pred(cpp.AttrCount) Do
        ElementList.Items.Append(cpp.Attribute[idx].Name);

    // selection color
    If devEditor.Syntax.IndexofName(cSel) = -1 Then
        devEditor.Syntax.Append(cSel);
    ElementList.Items.Append(cSel);

    // right margin

    // gutter colors
    If devEditor.Syntax.IndexofName(cGut) = -1 Then
        devEditor.Syntax.Append(cGut);
    ElementList.Items.Append(cGut);

    // breakpoint
    If devEditor.Syntax.IndexOfName(cBP) = -1 Then
        devEditor.Syntax.Append(cBP);
    ElementList.Items.Append(cBP);

    // error line
    If devEditor.Syntax.IndexOfName(cErr) = -1 Then
        devEditor.Syntax.Append(cErr);
    ElementList.Items.Append(cErr);

    // active breakpoint
    If devEditor.Syntax.IndexOfName(cABP) = -1 Then
        devEditor.Syntax.Append(cABP);
    ElementList.Items.Append(cABP);

    ffgColor := cpp.WhitespaceAttribute.Foreground;
    fbgColor := cpp.WhitespaceAttribute.Background;

    If ElementList.Items.Count > 0 Then
    Begin
        ElementList.ItemIndex := 0;
        ElementListClick(Nil);
    End;

    // init gutter colors
    SetGutter;
    If FileExists(devDirs.Config + DEV_DEFAULTCODE_FILE) Then
        seDefault.Lines.LoadFromFile(devDirs.Config + DEV_DEFAULTCODE_FILE);

    // CODE_COMPLETION //
    chkEnableCompletion.OnClick := Nil;
    chkEnableCompletion.Checked := devCodeCompletion.Enabled;
    chkEnableCompletion.OnClick := chkEnableCompletionClick;
    edCompletionDelay.Value := devCodeCompletion.Delay;
    cpCompletionBackground.SelectionColor := devCodeCompletion.BackColor;
    edCompletionDelay.Enabled := chkEnableCompletion.Checked;
    cpCompletionBackground.Enabled := chkEnableCompletion.Checked;
    chkCCCache.Checked := devCodeCompletion.UseCacheFiles;
    chkCCCache.Tag := 0; // mark un-modified
    chkCCCache.Enabled := chkEnableCompletion.Checked;
    lbCCC.Enabled := chkCCCache.Checked And chkEnableCompletion.Checked;
    btnCCCnew.Enabled := chkCCCache.Checked And chkEnableCompletion.Checked;
    btnAddNewFolder.Enabled := chkCCCache.Checked And chkEnableCompletion.Checked;
    btnCCCdelete.Enabled := chkCCCache.Checked And chkEnableCompletion.Checked;

    // CLASS_BROWSING //
    chkEnableClassBrowser.Checked := devClassBrowsing.Enabled;
    ClassBrowser1.Enabled := chkEnableClassBrowser.Checked;
    ClassBrowser1.UseColors := devClassBrowsing.UseColors;
    ClassBrowser1.ShowInheritedMembers := devClassBrowsing.ShowInheritedMembers;
    ClassBrowser1.ShowSampleData;
    chkCBParseLocalH.Checked := devClassBrowsing.ParseLocalHeaders;
    chkCBParseGlobalH.Checked := devClassBrowsing.ParseGlobalHeaders;
    chkCBParseLocalH.Enabled := chkEnableClassBrowser.Checked;
    chkCBParseGlobalH.Enabled := chkEnableClassBrowser.Checked;
    chkCBUseColors.Checked := devClassBrowsing.UseColors;
    chkCBShowInherited.Checked := devClassBrowsing.ShowInheritedMembers;
    chkCBUseColors.Enabled := chkEnableClassBrowser.Checked;
    chkEnableCompletion.Enabled := chkEnableClassBrowser.Checked;
    edCompletionDelay.Enabled := chkEnableClassBrowser.Checked;
    cpCompletionBackground.Enabled := chkEnableClassBrowser.Checked;
End;

Procedure TEditorOptForm.btnOkClick(Sender: TObject);
Var
    s, aName: String;
    a, idx: Integer;
    e: TEditor;
Begin

    Screen.Cursor := crHourGlass;
    btnOk.Enabled := False;

    With devEditor Do
    Begin
        AutoIndent := cbAutoIndent.Checked;
        InsertMode := cbInsertMode.Checked;
        TabToSpaces := Not cbTabtoSpaces.Checked;
        SmartTabs := cbSmartTabs.Checked;
        SmartUnindent := cbSmartUnindent.Checked;
        TrailBlank := Not cbTrailingBlanks.Checked;
        GroupUndo := cbGroupUndo.Checked;
        EHomeKey := cbEHomeKey.Checked;
        PastEOF := cbPastEOF.Checked;
        PastEOL := cbPastEOL.Checked;
        DblClkLine := cbDoubleLine.Checked;
        FindText := cbFindText.Checked;
        Scrollbars := cbSmartScroll.Checked;
        HalfPageScroll := cbHalfPage.Checked;
        ScrollHint := cbScrollHint.Checked;
        SpecialChars := cbSpecialChars.Checked;
        AppendNewline := cbAppendNewline.Checked;

        MarginVis := cbMarginVis.Checked;
        MarginSize := edMarginWidth.Value;
        MarginColor := cpMarginColor.SelectionColor;
        InsertCaret := cboInsertCaret.ItemIndex;
        OverwriteCaret := cboOverwriteCaret.ItemIndex;
        Match := cbMatch.Checked;

        HighCurrLine := cbHighCurrLine.Checked;
        HighColor := cpHighColor.SelectionColor;

        UseSyntax := cbSyntaxHighlight.Checked;
        SyntaxExt := edSyntaxExt.Text;
        TabSize := seTabSize.Value;

        Font.Name := cboEditorFont.Text;
        Font.Size := strtointdef(cboEditorSize.Text, 12);

        Gutterfont.Name := cboGutterFont.Text;
        GutterFont.Size := strtointdef(cboGutterSize.Text, 12);

        Gutterfnt := cbGutterFnt.Checked;
        GutterAuto := cbGutterAuto.Checked;
        GutterGradient := cbGutterGradient.Checked;
        GutterVis := cbGutterVis.Checked;
        GutterSize := edGutterWidth.Value;
        LineNumbers := cbLineNum.Checked;
        LeadZero := cbLeadZero.Checked;
        FirstLineZero := cbFirstZero.Checked;
        InsDropFiles := cbDropFiles.Checked;
        ParserHints := cbParserHints.Checked;

       // CodeFolding := cbCodeFolding.Checked;

        // load in attributes
        For idx := 0 To pred(cpp.AttrCount) Do
        Begin
            aName := cpp.Attribute[idx].Name;
            a := Syntax.IndexOfName(aName);
            If a = -1 Then
                Syntax.Append(format('%s=%s',
                    [aName, AttrtoStr(cpp.Attribute[idx])]))
            Else
                Syntax.Values[aName] := AttrtoStr(cpp.Attribute[idx]);
        End;
        ActiveSyntax := cboQuickColor.Text;
        // additional attributes

        //gutter
        If fgutColor.x = clNone Then
            fgutColor.x := clBlack;
        If fgutColor.y = clNone Then
            fgutColor.Y := clBtnFace;

        s := PointtoStr(fgutColor);
        a := Syntax.IndexofName(cGut);
        If a = -1 Then
            Syntax.Append(format('%s=%s', [cGut, s]))
        Else
            Syntax.Values[cGut] := s;

        // selected text
        s := PointtoStr(fSelColor);
        a := Syntax.IndexofName(cSel);
        If a = -1 Then
            Syntax.Append(format('%s=%s', [cSel, s]))
        Else
            Syntax.Values[cSel] := s;

        // breakpoints
        s := PointtoStr(fbpColor);
        a := Syntax.IndexofName(cBP);
        If a = -1 Then
            Syntax.Append(format('%s=%s', [cBP, s]))
        Else
            Syntax.Values[cBP] := s;

        // active breakpoint
        s := PointtoStr(fAbpColor);
        a := Syntax.IndexofName(cABP);
        If a = -1 Then
            Syntax.Append(format('%s=%s', [cABP, s]))
        Else
            Syntax.Values[cABP] := s;

        // error line
        s := PointtoStr(fErrColor);
        a := Syntax.IndexofName(cErr);
        If a = -1 Then
            Syntax.Append(format('%s=%s', [cErr, s]))
        Else
            Syntax.Values[cErr] := s;

        // Insert default code in Empty project files
        DefaulttoPrj := cbDefaultintoprj.Checked;
    End;

    seDefault.Lines.SavetoFile(devDirs.Config + DEV_DEFAULTCODE_FILE);

    SaveCodeIns;

    // CODE_COMPLETION //
    devCodeCompletion.Enabled := chkEnableCompletion.Checked;
    devCodeCompletion.Delay := edCompletionDelay.Value;
    devCodeCompletion.BackColor := cpCompletionBackground.SelectionColor;
    devCodeCompletion.UseCacheFiles := chkCCCache.Checked;
    If chkCCCache.Tag = 1 Then
    Begin
        Screen.Cursor := crHourGlass;
        Application.ProcessMessages;
        CppParser1.OnStartParsing := CppParser1StartParsing;
        CppParser1.OnEndParsing := CppParser1EndParsing;
        CppParser1.OnTotalProgress := CppParser1TotalProgress;
        CppParser1.Save(devDirs.Config + DEV_COMPLETION_CACHE);
        Screen.Cursor := crDefault;
    End;

    // CLASS_BROWSING //
    devClassBrowsing.Enabled := chkEnableClassBrowser.Checked;
    devClassBrowsing.ParseLocalHeaders := chkCBParseLocalH.Checked;
    devClassBrowsing.ParseGlobalHeaders := chkCBParseGlobalH.Checked;
    devClassBrowsing.UseColors := chkCBUseColors.Checked;
    devClassBrowsing.ShowInheritedMembers := chkCBShowInherited.Checked;

    SaveOptions;
    dmMain.LoadDataMod;
    If Not devEditor.Match Then
    Begin
        e := MainForm.GetEditor;
        If assigned(e) Then
            e.PaintMatchingBrackets(ttBefore);
    End;

    e := MainForm.GetEditor;
    If Assigned(e) Then
        If cbHighCurrLine.Checked Then
            e.Text.ActiveLineColor := cpHighColor.SelectionColor
        Else
            e.Text.ActiveLineColor := clNone;

    Screen.Cursor := crDefault;
    btnOk.Enabled := True;

End;

Procedure TEditorOptForm.btnHelpClick(Sender: TObject);
Begin
    HelpFile := devDirs.Help + DEV_MAINHELP_FILE;
    HtmlHelp(self.handle, Pchar(HelpFile), HH_DISPLAY_TOPIC,
        DWORD(Pchar('html\editor_options.html')));;
    //Application.HelpJump('ID_EDITORSETTINGS');
End;

Procedure TEditorOptForm.btnCancelClick(Sender: TObject);
Begin
    Close;
End;

Procedure TEditorOptForm.cboDblClick(Sender: TObject);
Var
    idx: Integer;
Begin
    With Sender As TComboBox Do
    Begin
        idx := ItemIndex + 1;
        If idx >= Items.Count Then
            idx := 0;
        ItemIndex := idx;
    End;
    If (Sender = cboGutterFont) Or (Sender = cboEditorFont) Then
        FontChange(Sender)
    Else
    If (Sender = cboEditorSize) Or (Sender = cboGutterSize) Then
        FontSizeChange(Sender);
End;

{ ---------- Syntax Style Methods ---------- }

Procedure TEditorOptForm.SetGutter;
Begin
    // if gutter background = clnone set to button face
    If fgutcolor.x = clnone Then
        fgutcolor.x := clBtnFace;

    // if gutter foreground = clnone set to black
    If fgutcolor.y = clnone Then
        fgutcolor.y := clBlack;

    // update preview
    cppedit.Gutter.Color := fgutColor.x;
    cppedit.Gutter.Font.Color := fgutColor.y;
End;

Procedure TEditorOptForm.ElementListClick(Sender: TObject);
Var
    pt: TPoint;
Begin
    If ElementList.ItemIndex > pred(cpp.AttrCount) Then
    Begin
        fUpdate := False;
        If AnsiCompareText(ElementList.Items[ElementList.ItemIndex], cSel) = 0 Then
            pt := fSelColor
        Else
        If AnsiCompareText(ElementList.Items[ElementList.ItemIndex], cBP) = 0 Then
            pt := fBPColor
        Else
        If AnsiCompareText(ElementList.Items[ElementList.ItemIndex],
            cErr) = 0 Then
            pt := fErrColor
        Else
        If AnsiCompareText(ElementList.Items[ElementList.ItemIndex],
            cABP) = 0 Then
            pt := fABPColor
        Else
        If AnsiCompareText(ElementList.Items[ElementList.ItemIndex],
            cGut) = 0 Then
            pt := fGutColor;

        cpBackground.SelectionColor := pt.x;
        cpForeground.SelectionColor := pt.y;

        cbBold.Checked := False;
        cbItalic.Checked := False;
        cbUnderlined.Checked := False;

        cbBold.Enabled := False;
        cbItalic.Enabled := False;
        cbUnderlined.Enabled := False;

        fUpdate := True;
    End
    Else
    If ElementList.ItemIndex > -1 Then
        With Cpp.Attribute[ElementList.ItemIndex] Do
        Begin
            fUpdate := False;
            If Foreground = clNone Then
                cpForeground.SelectionColor := clWindowText //clNone
            Else
                cpForeground.SelectionColor := Foreground;
            If Background = clNone Then
                cpBackground.SelectionColor := clWindow //clNone
            Else
                cpBackground.SelectionColor := Background;

            cbBold.Enabled := True;
            cbItalic.Enabled := True;
            cbUnderlined.Enabled := True;

            cbBold.Checked := fsBold In Style;
            cbItalic.Checked := fsItalic In Style;
            cbUnderlined.Checked := fsUnderline In Style;
            fUpdate := True;
        End;
End;

Procedure TEditorOptForm.DefaultSelect(Sender: TObject);
Begin
    With (Sender As TColorPickerButton) Do
        SelectionColor := clNone;
End;

Procedure TEditorOptForm.PickerHint(Sender: TObject; Cell: Integer;
    Var Hint: String);
Begin
    If Cell = DEFAULTCELL Then
        Hint := Lang[ID_EOPT_HINTWHITESPACE];
End;

Procedure TEditorOptForm.StyleChange(Sender: TObject);
Var
    attr: TSynHighlighterAttributes;
    pt: TPoint;
    s: String;
Begin
    If (Not fUpdate) Or (ElementList.ItemIndex < 0) Then
        Exit;

    If ElementList.ItemIndex > pred(cpp.AttrCount) Then
    Begin
        pt.x := cpBackground.SelectionColor;
        pt.y := cpForeground.SelectionColor;
        // check for gutter before changing default colors
        If AnsiCompareText(ElementList.Items[ElementList.ItemIndex], cGut) = 0 Then
        Begin
            fGutColor := pt;
            SetGutter;
        End
        Else
        Begin
            // use local string just to ease readability
            s := ElementList.Items[ElementList.ItemIndex];

            // if either value is clnone set to Whitespace color values
            If pt.x = clNone Then
                pt.x := fbgColor;
            If pt.y = clNone Then
                pt.y := ffgColor;

            If AnsiCompareText(s, cSel) = 0 Then
                fSelColor := pt
            Else
            If AnsiCompareText(s, cBP) = 0 Then
                fBPColor := pt
            Else
            If AnsiCompareText(s, cABP) = 0 Then
                fABPColor := pt
            Else
            If AnsiCompareText(s, cerr) = 0 Then
                fErrColor := pt;
        End;
    End
    Else
    Begin
        Attr := TSynHighlighterAttributes.Create(
            ElementList.Items[ElementList.ItemIndex]);
        Attr.Assign(cpp.Attribute[ElementList.ItemIndex]);
        With Attr Do
            Try
                Foreground := cpForeground.SelectionColor;
                If Sender = cpBackground Then
                    Background := cpBackground.SelectionColor;
                If AnsiCompareText(Name, 'WhiteSpace') = 0 Then
                Begin
                    ffgColor := Foreground;
                    fbgColor := Background;
                End;

                Style := [];
                If cbBold.checked Then
                    Style := Style + [fsBold];
                If cbItalic.Checked Then
                    Style := Style + [fsItalic];
                If cbUnderlined.Checked Then
                    Style := Style + [fsUnderline];
                cpp.Attribute[ElementList.ItemIndex].Assign(Attr);
            Finally
                Free;
            End;
    End;

    // invalidate special lines
    cppEdit.InvalidateLine(cSelection);
    cppEdit.InvalidateLine(cBreakLine);
    cppEdit.InvalidateLine(cABreakLine);
    cppEdit.InvalidateLine(cErrorLine);
    cppEdit.Highlighter := cpp;
    cboQuickColor.ItemIndex := -1;
End;

Procedure TEditorOptForm.cppEditStatusChange(Sender: TObject;
    Changes: TSynStatusChanges);
Var
    Token: String;
    attr: TSynHighlighterAttributes;
Begin
    If assigned(cppEdit.Highlighter) And
        (Changes * [scAll, scCaretX, scCaretY] <> []) Then
        Case cppEdit.CaretY Of
            cSelection:
            Begin
                ElementList.ItemIndex := ElementList.Items.Indexof(cSel);
                ElementListClick(Self);
            End;
            cBreakLine:
            Begin
                ElementList.ItemIndex := ElementList.Items.Indexof(cBP);
                ElementListClick(Self);
            End;
            cABreakLine:
            Begin
                ElementList.ItemIndex := ElementList.Items.Indexof(cABP);
                ElementListClick(Self);
            End;
            cErrorLine:
            Begin
                ElementList.ItemIndex := ElementList.Items.Indexof(cErr);
                ElementListClick(Self);
            End;
        Else
        Begin
            If Not cppEdit.GetHighlighterAttriAtRowCol(cppEdit.CaretXY,
                Token, Attr) Then
                Attr := cppEdit.Highlighter.WhiteSpaceAttribute;
            If assigned(Attr) Then
            Begin
                ElementList.ItemIndex := ElementList.Items.Indexof(Attr.Name);
                ElementListClick(Self);
            End;
        End;
        End;
End;

Procedure TEditorOptForm.CppEditSpecialLineColors(Sender: TObject;
    Line: Integer; Var Special: Boolean; Var FG, BG: TColor);
Begin
    Case Line Of
        cSelection:
        Begin
            If fSelColor.x <> clNone Then
                BG := fSelColor.x;
            If fSelColor.y <> clNone Then
                FG := fSelColor.y;
            Special := True;
        End;
        cBreakLine:
        Begin
            If fBPColor.x <> clNone Then
                BG := fBPColor.x;
            If fBPColor.y <> clNone Then
                FG := fBPColor.y;
            Special := True;
        End;
        cABreakLine:
        Begin
            If fABPColor.x <> clNone Then
                BG := fABPColor.X;
            If fABPColor.y <> clNone Then
                FG := fABPColor.y;
            Special := True;
        End;
        cErrorLine:
        Begin
            If fErrColor.x <> clNone Then
                BG := fErrColor.x;
            If fErrColor.y <> clNone Then
                FG := fErrColor.y;
            Special := True;
        End;
    End;
End;

Procedure TEditorOptForm.cpMarginColorHint(Sender: TObject; Cell: Integer;
    Var Hint: String);
Begin
    If Cell = DEFAULTCELL Then
        Hint := Lang[ID_EOPT_HINTHIGHLIGHT];
End;

Procedure TEditorOptForm.cpMarginColorDefaultSelect(Sender: TObject);
Begin
    cpMarginColor.SelectionColor := clHighlightText;
End;

Procedure TEditorOptForm.cbLineNumClick(Sender: TObject);
Begin
    cbLeadZero.Enabled := cbLineNum.Checked;
    cbFirstZero.Enabled := cbLineNum.Checked;
End;

Procedure TEditorOptForm.cbSyntaxHighlightClick(Sender: TObject);
Begin
    edSyntaxExt.Enabled := cbSyntaxHighlight.Checked;
End;

Procedure TEditorOptForm.cboQuickColorSelect(Sender: TObject);
Var
    offset: Integer;
    i: Integer;
    attr: TSynHighlighterAttributes;
Begin
    If cboQuickColor.ItemIndex > 5 Then
    Begin
        // custom style; load from disk
        LoadSyntax(cboQuickColor.Items[cboQuickColor.ItemIndex]);
        Exit;
    End;

    offset := cboQuickColor.ItemIndex * 1000;
    For i := 0 To pred(cpp.AttrCount) Do
    Begin
        attr := TSynHighlighterAttributes.Create(cpp.Attribute[i].Name);
        Try
            StrtoAttr(Attr, LoadStr(i + offset + 1));
            cpp.Attribute[i].Assign(Attr);
        Finally
            Attr.Free;
        End;
    End;

    StrtoPoint(fBPColor, LoadStr(offset + 17)); // breakpoints
    StrtoPoint(fErrColor, LoadStr(offset + 18)); // error line
    StrtoPoint(fABPColor, LoadStr(offset + 19)); // active breakpoint
    StrtoPoint(fgutColor, LoadStr(offset + 20)); // gutter
    StrtoPoint(fSelColor, LoadStr(offset + 21)); // selected text

    cppEdit.InvalidateLine(cSelection);
    cppEdit.InvalidateLine(cBreakLine);
    cppEdit.InvalidateLine(cABreakLine);
    cppEdit.InvalidateLine(cErrorLine);
    cppEdit.Highlighter := cpp;

    //update gutter
    setgutter;
End;

{ ---------- Code insert's methods ---------- }

Procedure TEditorOptForm.btnAddClick(Sender: TObject);
Var
    NewItem: PCodeIns;
    Item: TListItem;
Begin
    With TfrmCodeEdit.Create(Self) Do
        Try
            CodeIns.ClearAll;
            Edit := False;
            New(NewItem);
            NewItem^.Sep := 0;
            Entry := NewItem;
            If ShowModal = mrOk Then
            Begin
                Item := lvCodeIns.Items.Add;
                Item.Caption := edMenuText.Text;
                Item.SubItems.Add(inttostr(seSection.Value));
                Item.SubItems.Add(edDesc.Text);
                Item.SubItems.Add('');
                lvCodeIns.Selected := Item;
            End
            Else
                dispose(NewItem);
        Finally
            Free;
            UpdateCIButtons;
        End;
End;

Procedure TEditorOptForm.btnEditClick(Sender: TObject);
Begin
    With TfrmCodeEdit.Create(Self) Do
        Try
            Edit := True;
            edMenuText.Text := lvCodeIns.Selected.Caption;
            seSection.Value := strtointdef(lvCodeIns.Selected.SubItems[0], 12);
            edDesc.Text := lvCodeIns.Selected.SubItems[1];
            If ShowModal = mrOk Then
            Begin
                lvCodeIns.Selected.Caption := edMenuText.Text;
                lvCodeIns.Selected.SubItems[0] := inttostr(seSection.Value);
                lvCodeIns.Selected.SubItems[1] := edDesc.Text;
            End;
        Finally
            Free;
            UpdateCIButtons;
        End;
End;

Procedure TEditorOptForm.btnRemoveClick(Sender: TObject);
Begin
    dmMain.CodeInserts.Delete(lvCodeIns.Selected.Index);
    lvCodeIns.Selected.Delete;
    CodeIns.ClearAll;
    UpdateCIButtons;
End;

Procedure TEditorOptForm.UpdateCIButtons;
Begin
    btnAdd.Enabled := True;
    btnEdit.Enabled := assigned(lvCodeIns.Selected);
    btnRemove.Enabled := assigned(lvCodeIns.Selected);
End;

Procedure TEditorOptForm.lvCodeinsColumnClick(Sender: TObject;
    Column: TListColumn);
Begin
    lvCodeIns.AlphaSort;
End;

Procedure TEditorOptForm.lvCodeinsCompare(Sender: TObject; Item1,
    Item2: TListItem; Data: Integer; Var Compare: Integer);
Var
    i1, i2: Integer;
Begin
    i1 := strtointdef(Item1.SubItems[0], 0);
    i2 := strtointdef(Item2.SubItems[0], 0);
    If i1 > i2 Then
        Compare := 1
    Else
    If i1 = i2 Then
        Compare := 0
    Else
        Compare := -1;
End;

Procedure TEditorOptForm.lvCodeinsSelectItem(Sender: TObject;
    Item: TListItem; Selected: Boolean);
Begin
    Codeins.ClearAll;
    CodeIns.Text := StrtoCodeIns(Item.SubItems[2]);
    UpdateCIButtons;
End;

Procedure TEditorOptForm.CodeInsStatusChange(Sender: TObject;
    Changes: TSynStatusChanges);
Begin
    If assigned(lvCodeIns.Selected) Then
        If (Changes * [scModified] <> []) Then
        Begin
            lvCodeIns.Selected.SubItems[2] := CodeInstoStr(CodeIns.Text);
            CodeIns.Modified := False;
        End;
End;

Procedure TEditorOptForm.LoadCodeIns;
Var
    idx: Integer;
    Item: TListItem;
    Ins: PCodeIns;
Begin
    For idx := 0 To pred(dmMain.CodeInserts.Count) Do
    Begin
        Item := lvCodeIns.Items.Add;
        ins := dmMain.CodeInserts[idx];
        Item.Caption := ins.Caption;
        Item.SubItems.Add(inttostr(ins.Sep));
        Item.SubItems.Add(ins.Desc);
        Item.SubItems.Add(ins.Line);
    End;
    If lvCodeIns.Items.Count > 0 Then
        lvCodeIns.ItemIndex := 0;
End;

Procedure TEditorOptForm.SaveCodeIns;
Var
    idx: Integer;
    Item: PCodeIns;
Begin
    lvCodeIns.AlphaSort;
    For idx := 0 To dmMain.CodeInserts.Count - 1 Do
    Begin
        Dispose(dmMain.CodeInserts.Items[idx]);
        dmMain.CodeInserts.Delete(idx);
    End;
    dmMain.CodeInserts.Clear;
    For idx := 0 To pred(lvCodeIns.Items.Count) Do
    Begin
        new(Item);
        Item.Caption := lvCodeIns.Items[idx].Caption;
        Item.Sep := strtointdef(lvCodeIns.Items[idx].SubItems[0], 0);
        Item.Desc := lvcodeIns.Items[idx].SubItems[1];
        Item.Line := lvCodeIns.Items[idx].SubItems[2];
        dmMain.CodeInserts.AddItem(Item);
    End;
    dmMain.Codeinserts.SaveCode;
End;

Procedure TEditorOptForm.chkEnableCompletionClick(Sender: TObject);
Begin
    With chkEnableCompletion Do
    Begin
        edCompletionDelay.Enabled := Checked;
        cpCompletionBackground.Enabled := Checked;
        chkCCCache.Checked := chkCCCache.Checked And Checked;
        chkCCCache.Enabled := Checked;
        chkCCCacheClick(Self);
    End;
End;

Procedure TEditorOptForm.chkEnableClassBrowserClick(Sender: TObject);
Begin
    // browser
    ClassBrowser1.Enabled := chkEnableClassBrowser.Checked;
    chkCBParseLocalH.Enabled := chkEnableClassBrowser.Checked;
    chkCBParseGlobalH.Enabled := chkEnableClassBrowser.Checked;
    chkCBUseColors.Enabled := chkEnableClassBrowser.Checked;
    // completion
    chkEnableCompletion.Enabled := chkEnableClassBrowser.Checked;
    edCompletionDelay.Enabled := chkEnableClassBrowser.Checked;
    cpCompletionBackground.Enabled := chkEnableClassBrowser.Checked;
End;

Procedure TEditorOptForm.btnSaveSyntaxClick(Sender: TObject);
Var
    idx: Integer;
    fINI: TIniFile;
    S: String;
    pt: TPoint;
Begin
    s := 'New syntax';
    If Not InputQuery(Lang[ID_EOPT_SAVESYNTAX], Lang[ID_EOPT_SAVESYNTAXQUESTION],
        s) Or (s = '') Then
        Exit;

    fINI := TIniFile.Create(devDirs.Config + s + SYNTAX_EXT);
    Try
        For idx := 0 To pred(Cpp.AttrCount) Do
            fINI.WriteString('Editor.Custom', Cpp.Attribute[idx].Name,
                AttrtoStr(Cpp.Attribute[idx]));

        For idx := Cpp.AttrCount To pred(ElementList.Items.Count) Do
        Begin
            If AnsiCompareText(ElementList.Items[idx], cSel) = 0 Then
                pt := fSelColor
            Else
            If AnsiCompareText(ElementList.Items[idx], cBP) = 0 Then
                pt := fBPColor
            Else
            If AnsiCompareText(ElementList.Items[idx], cErr) = 0 Then
                pt := fErrColor
            Else
            If AnsiCompareText(ElementList.Items[idx], cABP) = 0 Then
                pt := fABPColor
            Else
            If AnsiCompareText(ElementList.Items[idx], cGut) = 0 Then
                pt := fGutColor;
            fINI.WriteString('Editor.Custom', ElementList.Items[idx],
                PointtoStr(pt));
        End;
    Finally
        fINI.Free;
    End;
    If cboQuickColor.Items.IndexOf(S) = -1 Then
        cboQuickColor.Items.Add(S);
    cboQuickColor.ItemIndex := cboQuickColor.Items.IndexOf(S);
End;

Procedure TEditorOptForm.LoadSyntax(Value: String);
Var
    idx: Integer;
    fINI: TIniFile;
    Attr: TSynHighlighterAttributes;
    pt: TPoint;
Begin
    fINI := TIniFile.Create(devDirs.Config + Value + SYNTAX_EXT);
    Try
        For idx := 0 To pred(Cpp.AttrCount) Do
        Begin
            Attr := TSynHighlighterAttributes.Create(Cpp.Attribute[idx].Name);
            Try
                StrToAttr(Attr, fINI.ReadString('Editor.Custom',
                    Cpp.Attribute[idx].Name, devEditor.Syntax.Values[Cpp.Attribute[idx].Name]));
                Cpp.Attribute[idx].Assign(Attr);
            Finally
                Attr.Free;
            End;
        End;

        For idx := Cpp.AttrCount To pred(ElementList.Items.Count) Do
        Begin
            StrToPoint(pt, fINI.ReadString('Editor.Custom',
                ElementList.Items[idx], PointToStr(Point(clNone, clNone))));
            If AnsiCompareText(ElementList.Items[idx], cSel) = 0 Then
                fSelColor := pt
            Else
            If AnsiCompareText(ElementList.Items[idx], cBP) = 0 Then
                fBPColor := pt
            Else
            If AnsiCompareText(ElementList.Items[idx], cErr) = 0 Then
                fErrColor := pt
            Else
            If AnsiCompareText(ElementList.Items[idx], cABP) = 0 Then
                fABPColor := pt
            Else
            If AnsiCompareText(ElementList.Items[idx], cGut) = 0 Then
            Begin
                fGutColor := pt;
                SetGutter;
            End;
        End;
    Finally
        fINI.Free;
    End;
    ElementListClick(Nil);
End;

Procedure TEditorOptForm.FillSyntaxSets;
Var
    SR: TSearchRec;
Begin
    If FindFirst(devDirs.Config + '*' + SYNTAX_EXT, faAnyFile, SR) = 0 Then
        Repeat
            cboQuickColor.Items.Add(ChangeFileExt(ExtractFileName(SR.Name), ''));
        Until FindNext(SR) <> 0;
End;

Procedure TEditorOptForm.chkCBUseColorsClick(Sender: TObject);
Begin
    ClassBrowser1.UseColors := chkCBUseColors.Checked;
    ClassBrowser1.Refresh;
End;

Procedure TEditorOptForm.btnCCCnewClick(Sender: TObject);
Var
    I, I1: Integer;
    Hits: Integer;
    MaxHits, MaxIndex: Integer;
    sl: TStrings;
    filesSelected : TStringList;
    flt: String;
Begin
    // the following piece of code is a quick'n'dirty way to find the base
    // compiler's include dir (if we 're lucky).
    // we search through devDirs.Cpp and try to locate the base dir that is
    // most common between the others(!).
    // if no most-common dir is found, we select the first in list.
    // for a default installation, it should work.
    //
    // will be replaced by a dialog ( when it's ready ;) to let the user
    // select, so that he gets the blame if the thing does not work ;)))
    //
    // PS: is there a better way to do it???
    sl := TStringList.Create;
    Try
        sl.Delimiter := ';';
        sl.DelimitedText := devDirs.Cpp;
        If sl.Count > 1 Then
        Begin
            MaxHits := 0;
            MaxIndex := 0;
            For I1 := 0 To sl.Count - 1 Do
            Begin
                Hits := 0;
                For I := 0 To sl.Count - 1 Do
                    If AnsiStartsText(sl[I1], sl[I]) Then
                        Inc(Hits);
                If Hits > MaxHits Then
                Begin
                    MaxHits := Hits;
                    MaxIndex := I1;
                End;
            End;
            CppParser1.ProjectDir := IncludeTrailingPathDelimiter(sl[MaxIndex]);
        End
        Else
            CppParser1.ProjectDir := IncludeTrailingPathDelimiter(devDirs.Cpp);
    Finally
        sl.Free;
    End;

    With dmMain Do
    Begin
        BuildFilter(flt, [FLT_HEADS]);
        OpenDialog.Filter := flt;

        If OpenDialog.Execute Then
        Begin
            Application.ProcessMessages;
            Screen.Cursor := crHourglass;

            //Track the cache parse progress
            HasProgressStarted := False;
            CppParser1.OnStartParsing := CppParser1StartParsing;
            CppParser1.OnEndParsing := CppParser1EndParsing;
            CppParser1.OnTotalProgress := CppParser1TotalProgress;

           filesSelected := TStringList.Create;
           filesSelected.Clear;

            //Add the files to scan and then parse the list
            For I := 0 To OpenDialog.Files.Count - 1 Do
              Begin
                // See if file is already in the cache
                If (CppParser1.CacheContents.IndexOf(OpenDialog.Files[I]) = -1) Then
                Begin
                        filesSelected.Add(OpenDialog.Files.Strings[I]);
                        CppParser1.AddFileToScan(OpenDialog.Files[I]);
                End;

              End;

            CppParser1.ParseList;
            Screen.Cursor := crDefault;

            //Finally append the new items unto the listbox
            For I := 0 To filesSelected.Count - 1 Do
                lbCCC.Items.Add(CompactFilename(filesSelected[I]));

            filesSelected.Clear;
            filesSelected.Free;
            
            chkCCCache.Tag := 1; // mark modified

        End;
    End;
End;

Procedure TEditorOptForm.btnCCCdeleteClick(Sender: TObject);
Begin
  //  If lbCCC.Items.Count = 0 Then
  //      Exit;
    If MessageDlg('Are you sure you want to clear the cache?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes Then
    Begin
        DeleteFile(devDirs.Config + DEV_COMPLETION_CACHE);
        CppParser1.Reset(False); // Reset parser and don't keep loaded
        FreeAndNil(CppParser1);
        CppParser1 := TCppParser.Create(Self);
        CppParser1.Tokenizer := CppTokenizer1;
        CppParser1.ParseLocalHeaders := True;
        CppParser1.ParseGlobalHeaders := True;
        CppParser1.OnStartParsing := CppParser1StartParsing;
        CppParser1.OnEndParsing := CppParser1EndParsing;
        CppParser1.OnTotalProgress := CppParser1TotalProgress;
        CppParser1.OnCacheProgress := NIL;
        lbCCC.Items.Clear;
        chkCCCache.Tag := 1; // mark modified
    End;
End;

Procedure TEditorOptForm.FillCCC;
Var
    I: Integer;
Begin

    Screen.Cursor := crHourglass;

    For I := 0 To MainForm.CppParser1.CacheContents.Count - 1 Do
       lbCCC.Items.Add(CompactFilename(MainForm.CppParser1.CacheContents[I]));

    Screen.Cursor := crDefault;
End;

Procedure TEditorOptForm.chkCCCacheClick(Sender: TObject);
Begin
    lbCCC.Enabled := chkCCCache.Checked;
    btnCCCnew.Enabled := chkCCCache.Checked;
    btnAddNewFolder.Enabled := chkCCCache.Checked;
    btnCCCdelete.Enabled := chkCCCache.Checked;
End;

Function TEditorOptForm.CompactFilename(filename: String): String;
Var
    DC: HDC;
Begin
    //Get a handle to the DC
    DC := lbCCC.Canvas.Handle;
    PathCompactPath(DC, Pchar(filename), lbCCC.ClientWidth);
    Result := filename;
End;

Procedure TEditorOptForm.CppParser1StartParsing(Sender: TObject);
Begin
    chkCCCache.Enabled := False;
    btnCCCnew.Enabled := False;
    btnAddNewFolder.Enabled := False;
    btnCCCdelete.Enabled := False;
    btnOk.Enabled := False;
    btnCancel.Enabled := False;
    pbCCCache.Visible := True;
    txtLoadingCache.Visible := True;
    Application.ProcessMessages;
End;

Procedure TEditorOptForm.CppParser1EndParsing(Sender: TObject);
Begin
    chkCCCache.Enabled := True;
    btnCCCnew.Enabled := True;
    btnCCCdelete.Enabled := True;
    btnAddNewFolder.Enabled := True;
    btnOk.Enabled := True;
    btnCancel.Enabled := True;
    pbCCCache.Visible := False;
    txtLoadingCache.Visible := False;
    Application.ProcessMessages;
End;

Procedure TEditorOptForm.CppParser1TotalProgress(Sender: TObject;
    FileName: String; Total, Current: Integer);
Begin
    If Not HasProgressStarted Then
    Begin
        pbCCCache.Max := Total;
        HasProgressStarted := True;
    End;

    pbCCCache.Position := pbCCCache.Position + Current;
    Application.ProcessMessages;
End;

Procedure TEditorOptForm.CppParser1StartSave(Sender: TObject);
Begin
    SendMessage(Handle, WM_SETREDRAW, 0, 0);
End;

Procedure TEditorOptForm.CppParser1EndSave(Sender: TObject);
Begin
    SendMessage(Handle, WM_SETREDRAW, 1, 0);
End;

Procedure TEditorOptForm.CppParser1SaveProgress(Sender: TObject;
    FileName: String; Total, Current: Integer);
Begin
    Application.ProcessMessages;
End;

Procedure TEditorOptForm.CppParser1CacheProgress(Sender: TObject;
    FileName: String;
    Total, Current: Integer);
Begin
    pbCCCache.Max := Total;
    pbCCCache.Position := Current;
    pbCCCache.Update;
End;

Procedure TEditorOptForm.PagesMainChange(Sender: TObject);
Begin
   If (PagesMain.ActivePage = tabClassBrowsing) And
        (CppParser1.Statements.Count = 0) Then
        FillCCC;
End;

Procedure TEditorOptForm.chkCBShowInheritedClick(Sender: TObject);
Begin
    ClassBrowser1.ShowInheritedMembers := chkCBShowInherited.Checked;
    ClassBrowser1.Refresh;
End;

Procedure TEditorOptForm.OnGutterClick(Sender: TObject;
    Button: TMouseButton; X, Y, Line: Integer; Mark: TSynEditMark);
Var
    idx: Integer;
Begin
    idx := ElementList.Items.IndexOf(cGut);
    If idx <> -1 Then
    Begin
        ElementList.ItemIndex := idx;
        ElementListClick(Self);
    End;
End;

Procedure TEditorOptForm.cbHighCurrLineClick(Sender: TObject);
Begin
    cpHighColor.Enabled := cbHighCurrLine.Checked;
End;

Procedure TEditorOptForm.seTabSizeChange(Sender: TObject);
Begin
    CppEdit.TabWidth := seTabSize.Value;
End;

Procedure TEditorOptForm.FontChange(Sender: TObject);
Var
    Size: String;
Begin

    fGutter := Sender = cboGutterFont;
    If fGutter Then
    Begin
        pnlGutterPreview.Font.Name := cboGutterFont.Text;
        CppEdit.Gutter.Font.Name := cboGutterFont.Text;
        Size := cboGutterSize.Text;
        LoadFontSize;
        cboGutterSize.Text := Size;

        CppEdit.Gutter.Font.Name := cboGutterFont.Text;
        CppEdit.Gutter.Font.Size := strtointdef(cboGutterSize.Text, 12);
        CppEdit.Gutter.Width := strtointdef(edGutterWidth.Text, 12);
        CppEdit.Refresh;
    End
    Else
    Begin
        pnlEditorPreview.Font.Name := cboEditorFont.Text;
        Size := cboEditorSize.Text;
        LoadFontSize;
        cboEditorSize.Text := Size;

        CppEdit.Font.Name := cboEditorFont.Text;
        CppEdit.Font.Size := strtointdef(cboEditorSize.Text, 12);
        CppEdit.Refresh;
    End;

End;

procedure TEditorOptForm.btnAddNewFolderClick(Sender: TObject);
Var
  chosenDirectory : string;
  filesSelected, FileList : TStringList;
  I : Integer;

begin

     if SelectDirectory('Select directory to add to cache', '', chosenDirectory) then //(SelectDirectory(chosenDirectory, [], 0)) then
     begin

            Application.ProcessMessages;
            Screen.Cursor := crHourglass;

             //Track the cache parse progress
            HasProgressStarted := False;
            CppParser1.OnStartParsing := CppParser1StartParsing;
            CppParser1.OnEndParsing := CppParser1EndParsing;
            CppParser1.OnTotalProgress := CppParser1TotalProgress;

           filesSelected := TStringList.Create;
           filesSelected.Clear;

           FileList := TStringList.Create;

           // This is kludge to get all header files
           FilesFromWildCard(chosenDirectory, '*.h', FileList, True, False, True);
           For I := 0 To FileList.Count - 1 Do
               filesSelected.Add(FileList[I]);
           FileList.Clear;
           FilesFromWildCard(chosenDirectory, '*.hpp', FileList, True, False, True);
           For I := 0 To FileList.Count - 1 Do
               filesSelected.Add(FileList[I]);
           FileList.Clear;
           FilesFromWildCard(chosenDirectory, '*.hh', FileList, True, False, True);
           For I := 0 To FileList.Count - 1 Do
               filesSelected.Add(FileList[I]);
           FileList.Clear;
           FilesFromWildCard(chosenDirectory, '*.rh', FileList, True, False, True);
           For I := 0 To FileList.Count - 1 Do
               filesSelected.Add(FileList[I]);
           FileList.Clear;
           FileList.Assign(filesSelected);
           filesSelected.Clear;
           // End kludge

            //Add the files to scan and then parse the list
            For I := 0 To FileList.Count - 1 Do
              Begin
                // See if file is already in the cache
                If (CppParser1.CacheContents.IndexOf(FileList[I]) = -1) Then
                Begin
                        filesSelected.Add(FileList.Strings[I]);
                        CppParser1.AddFileToScan(FileList[I]);
                End;

              End;

            FileList.Clear;
            FileList.Free;

            CppParser1.ParseList;

           pbCCCache.Max := filesSelected.Count;
           pbCCCache.StepBy(1);

            //Finally append the new items unto the listbox
            For I := 0 To filesSelected.Count - 1 Do
            Begin
                lbCCC.Items.Add(CompactFilename(filesSelected[I]));
                pbCCCache.StepIt;
            End;

            filesSelected.Clear;
            filesSelected.Free;

            pbCCCache.Position := pbCCCache.Max;

            CppParser1EndParsing(Self);
            Screen.Cursor := crDefault;

            chkCCCache.Tag := 1; // mark modified

     end;

end;

End.
