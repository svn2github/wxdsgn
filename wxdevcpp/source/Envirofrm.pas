{
    $Id: Envirofrm.pas 768 2006-12-24 05:44:42Z lowjoel $

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
Unit Envirofrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, Spin, ExtCtrls, devTabs, ExtDlgs, Buttons, DevThemes,
    CheckLst, XPMenu, Grids, ValEdit, ComCtrls;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QComCtrls, QExtCtrls, devTabs, QButtons, DevThemes,
  QCheckLst, QGrids;
{$ENDIF}

Type
    TEnviroForm = Class(TForm)
        PagesMain: TPageControl;
        tabGeneral: TTabSheet;
        tabPaths: TTabSheet;
        cbBackups: TCheckBox;
        cbMinOnRun: TCheckBox;
        cbDefCpp: TCheckBox;
        cbShowBars: TCheckBox;
        lblUserDir: TLabel;
        edUserDir: TEdit;
        lblTemplatesDir: TLabel;
        edTemplatesDir: TEdit;
        lblSplash: TLabel;
        edSplash: TEdit;
        lblIcoLib: TLabel;
        edIcoLib: TEdit;
        dlgPic: TOpenPictureDialog;
        btnOk: TBitBtn;
        btnCancel: TBitBtn;
        btnHelp: TBitBtn;
        cbShowMenu: TCheckBox;
        rgbAutoOpen: TRadioGroup;
        cbdblFiles: TCheckBox;
        lblLangPath: TLabel;
        edLang: TEdit;
        tabInterface: TTabSheet;
        lblLang: TLabel;
        cboLang: TComboBox;
        lblTheme: TLabel;
        cboTheme: TComboBox;
        lblmsgTabs: TLabel;
        cboTabsTop: TComboBox;
        lblMRU: TLabel;
        seMRUMax: TSpinEdit;
        rgbOpenStyle: TRadioGroup;
        cbNoSplashScreen: TCheckBox;
        tabAssocs: TTabSheet;
        lblAssocFileTypes: TLabel;
        lstAssocFileTypes: TCheckListBox;
        lblAssocDesc: TLabel;
        tabCVS: TTabSheet;
        lblCVSExec: TLabel;
        edCVSExec: TEdit;
        lblCVSCompression: TLabel;
        spnCVSCompression: TSpinEdit;
        chkCVSUseSSH: TCheckBox;
        XPMenu: TXPMenu;
        cbXPTheme: TCheckBox;
        gbProgress: TGroupBox;
        cbShowProgress: TCheckBox;
        cbAutoCloseProgress: TCheckBox;
        tabExternal: TTabSheet;
        lblExternal: TLabel;
        vleExternal: TValueListEditor;
        btnExtAdd: TSpeedButton;
        btnExtDel: TSpeedButton;
        gbDebugger: TGroupBox;
        cbWatchHint: TCheckBox;
        cbWatchError: TCheckBox;
        gbAltConfig: TGroupBox;
        chkAltConfig: TCheckBox;
        edAltConfig: TEdit;
        btnAltConfig: TSpeedButton;
        btnDefBrws: TSpeedButton;
        btnOutputbrws: TSpeedButton;
        btnBrwIcon: TSpeedButton;
        btnBrwLang: TSpeedButton;
        btnBrwSplash: TSpeedButton;
        btnCVSExecBrws: TSpeedButton;
        cbSingleInstance: TCheckBox;
        cbNativeDocks: TCheckBox;
        cbHiliteActiveTab: TCheckBox;
        lblOpenSaveOptions: TLabel;
        cbNoToolTip: TCheckBox;
        Procedure BrowseClick(Sender: TObject);
        Procedure btnOkClick(Sender: TObject);
        Procedure FormShow(Sender: TObject);
        Procedure btnHelpClick(Sender: TObject);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure FormCreate(Sender: TObject);
        Procedure vleExternalEditButtonClick(Sender: TObject);
        Procedure vleExternalValidate(Sender: TObject; ACol, ARow: Integer;
            Const KeyName, KeyValue: String);
        Procedure btnExtAddClick(Sender: TObject);
        Procedure btnExtDelClick(Sender: TObject);
        Procedure chkAltConfigClick(Sender: TObject);
    Private
        Procedure LoadText;
    Public
        { Public declarations }
    End;

Implementation

Uses
{$IFDEF WIN32}
    Filectrl, devcfg, MultiLangSupport, version, datamod, utils,
    FileAssocs, ImageTheme, hh, uvista,
    main;
{$ENDIF}
{$IFDEF LINUX}
  Xlib, devcfg, MultiLangSupport, version, datamod, utils, FileAssocs, ImageTheme;
{$ENDIF}

{$R *.dfm}

Const
    Help_Topics: Array[0..5] Of String =
        ('html\environ_general.html',
        'html\environ_interface.html',
        'html\environ_filesdirs.html',
        'html\environ_general.html',
        'html\environ_fileassoc.html',
        'html\environ_cvs.html');

Procedure TEnviroForm.BrowseClick(Sender: TObject);
Var
    s: String;
Begin
    Case (Sender As TComponent).Tag Of
        1: // default dir browse
        Begin
            s := edUserDir.Text;
            If SelectDirectory(Lang[ID_ENV_SELUSERDIR], '', s) Then
                edUserDir.Text := IncludeTrailingPathDelimiter(s);
        End;

        2: // output dir browse
        Begin
            s := ExpandFileto(edTemplatesDir.Text, devDirs.Exec);
            If SelectDirectory(Lang[ID_ENV_SELTEMPLATESDIR], '', s) Then
                edTemplatesDir.Text := IncludeTrailingPathDelimiter(s);
        End;

        // why was it commented-out???
        3: // icon library browse
        Begin
            s := ExpandFileto(edIcoLib.Text, devDirs.Exec);
            If SelectDirectory(Lang[ID_ENV_SELICOLIB], '', s) Then
                edIcoLib.Text := IncludeTrailingPathDelimiter(s);
        End;

        4: // splash screen browse
        Begin
            dlgPic.InitialDir := ExtractFilePath(edSplash.Text);
            If dlgPic.Execute Then
                edSplash.Text := dlgPic.FileName;
        End;

        5: // Language Dir
        Begin
            s := ExpandFileto(edLang.Text, devDirs.Exec);
            If SelectDirectory(Lang[ID_ENV_SELLANGDIR], '', s) Then
                edLang.Text := IncludeTrailingPathDelimiter(
                    ExtractRelativePath(devDirs.Exec, s));
        End;

        6: // CVS Executable Filename
        Begin
            dmMain.OpenDialog.Filter := FLT_ALLFILES;
            dmMain.OpenDialog.FileName := edCVSExec.Text;
            If dmMain.OpenDialog.Execute Then
                edCVSExec.Text := dmMain.OpenDialog.FileName;
        End;

        7: // Alternate Configuration File
        Begin
            dmMain.OpenDialog.Filter := FLT_ALLFILES;
            dmMain.OpenDialog.FileName := edAltConfig.Text;
            If dmMain.OpenDialog.Execute Then
                edAltConfig.Text := dmMain.OpenDialog.FileName;
        End;
    End;
End;

Procedure TEnviroForm.FormShow(Sender: TObject);
Var
    idx: Integer;
Begin
    With devData Do
    Begin
        rgbAutoOpen.ItemIndex := AutoOpen;
        cbSingleInstance.Checked := SingleInstance;
        cbDefCpp.Checked := defCpp;
        cbShowBars.Checked := ShowBars;
        cbBackups.Checked := BackUps;
        cbMinOnRun.Checked := MinOnRun;
        cbdblFiles.Checked := DblFiles;
        cbNoSplashScreen.Checked := NoSplashScreen;
        cbNoToolTip.Checked := NoToolTip;
        cbHiliteActiveTab.Checked := HiliteActiveTab;
        seMRUMax.Value := MRUMax;
        cboLang.Clear;
        For idx := 0 To pred(Lang.Langs.Count) Do
            cboLang.Items.append(Lang.Langs.Values[idx]);
        cboLang.ItemIndex := cboLang.Items.Indexof(Lang.CurrentLanguage);
        rgbOpenStyle.ItemIndex := OpenStyle;

        {*** Modified by Peter ***}
        cboTheme.Items.Clear;
        devImageThemes.GetThemeTitles(cboTheme.Items);
        cboTheme.ItemIndex := devImageThemes.IndexOf(
            devImageThemes.CurrentTheme.Title);
        //cboTheme.Text := devImageThemes.CurrentTheme.Title;
        //cboTheme.Items.AddStrings(devTheme.ThemeList);
        //cboTheme.ItemIndex := cboTheme.Items.IndexOf(devData.Theme);

        cbXPTheme.Checked := XPTheme;
        cbNativeDocks.Checked := NativeDocks;

        cbShowProgress.Checked := ShowProgress;
        cbAutoCloseProgress.Checked := AutoCloseProgress;

        cbWatchHint.Checked := WatchHint;
        cbWatchError.Checked := WatchError;

        cboTabsTop.ItemIndex := ord(msgTabs);

        chkAltConfig.Checked := UseAltConfigFile;
        edAltConfig.Text := AltConfigFile;
        chkAltConfigClick(Nil);

        edSplash.Text := Splash;
        edIcoLib.Text := ExtractRelativePath(devDirs.Exec, devDirs.Icons);
        edUserDir.Text := devDirs.Default;
        edTemplatesDir.Text := ExtractRelativePath(devDirs.Exec,
            devDirs.Templates);
        edLang.Text := ExtractRelativePath(devDirs.Exec, devDirs.Lang);

        vleExternal.Strings.Assign(devExternalPrograms.Programs);
        For idx := 0 To vleExternal.Strings.Count - 1 Do
            vleExternal.ItemProps[idx].EditStyle := esEllipsis;

        lstAssocFileTypes.Clear;
        For idx := 0 To AssociationsCount - 1 Do
        Begin
            lstAssocFileTypes.Items.Add(Format('%s  (*.%s)',
                [Associations[idx, 1], Associations[idx, 0]]));
            lstAssocFileTypes.Checked[lstAssocFileTypes.Items.Count - 1] :=
                IsAssociated(idx);
        End;

        edCVSExec.Text := devCVSHandler.Executable;
        spnCVSCompression.Value := devCVSHandler.Compression;
        chkCVSUseSSH.Checked := devCVSHandler.UseSSH;
    End;
End;

Procedure TEnviroForm.btnOkClick(Sender: TObject);
Var
    idx: Integer;
    s: String;
Begin

    Screen.Cursor := crHourGlass;
    btnOk.Enabled := False;

    If chkAltConfig.Enabled Then
    Begin
        If UseAltConfigFile <> chkAltConfig.Checked Then
            MessageDlg(Lang[ID_ENV_CONFIGCHANGED], mtInformation, [mbOk], 0);
        UseAltConfigFile := chkAltConfig.Checked And (edAltConfig.Text <> '');
        AltConfigFile := edAltConfig.Text;
        UpdateAltConfigFile;
    End;

    With devData Do
    Begin
        SingleInstance := cbSingleInstance.Checked;
        DefCpp := cbDefCpp.Checked;
        ShowBars := cbShowBars.Checked;
        ShowMenu := cbShowMenu.Checked;
        BackUps := cbBackups.Checked;
        MinOnRun := cbMinOnRun.Checked;
        DblFiles := cbdblFiles.Checked;
        MRUMax := seMRUMax.Value;
        MsgTabs := Boolean(cboTabsTop.ItemIndex);
        OpenStyle := rgbOpenStyle.ItemIndex;
        AutoOpen := rgbAutoOpen.ItemIndex;
        Splash := edSplash.Text;

        s := Lang.FileFromDescription(cboLang.Text);
        LangChange := s <> Language;
        Language := s;
        ThemeChange := cboTheme.Text <> devData.Theme;
        Theme := cboTheme.Text;
        NoSplashScreen := cbNoSplashScreen.Checked;
        NoToolTip := cbNoToolTip.Checked;
        HiliteActiveTab := cbHiliteActiveTab.Checked;
        If Not ThemeChange Then
            ThemeChange := XPTheme <> cbXPTheme.Checked;
        XPTheme := cbXPTheme.Checked;
        If Not ThemeChange Then
            ThemeChange := NativeDocks <> cbNativeDocks.Checked;
        NativeDocks := cbNativeDocks.Checked;
        ShowProgress := cbShowProgress.Checked;
        AutoCloseProgress := cbAutoCloseProgress.Checked;
        WatchHint := cbWatchHint.Checked;
        WatchError := cbWatchError.Checked;
    End;

    devDirs.Icons := IncludeTrailingPathDelimiter(
        ExpandFileto(edIcoLib.Text, devDirs.Exec));
    devDirs.Templates := IncludeTrailingPathDelimiter(
        ExpandFileto(edTemplatesDir.Text, devDirs.Exec));
    devDirs.Default := edUserDir.Text;

    If edLang.Text <> ExtractRelativePath(devDirs.Exec, devDirs.Lang) Then
    Begin
        devDirs.Lang := IncludeTrailingPathDelimiter(
            ExpandFileto(edLang.Text, devDirs.Exec));
        Lang.CheckLanguageFiles;
    End;

    If Not IsWindowsVista Then
    Begin
        With dmMain.OpenDialog Do
            Case devData.OpenStyle Of
                0: // win2k
                Begin
                    OptionsEx := [];
                    Options := Options - [ofOldStyleDialog, ofNoLongNames];
                End;
                1: // win9x
                Begin
                    OptionsEx := [ofExNoPlacesBar];
                    Options := Options - [ofOldStyleDialog, ofNoLongNames];
                End;
                2: // win31
                Begin
                    OptionsEx := [ofExNoPlacesBar]; // basically ignored anyway
                    Options := Options + [ofOldStyleDialog, ofNoLongNames];
                End;
            End;

        dmMain.SaveDialog.OptionsEx := dmMain.OpenDialog.OptionsEx;
        dmMain.SaveDialog.Options := dmMain.OpenDialog.Options;
    End;

    devExternalPrograms.Programs.Assign(vleExternal.Strings);

    For idx := 0 To AssociationsCount - 1 Do
        If lstAssocFileTypes.Checked[idx] Then
            Associate(idx)
        Else
            Unassociate(idx);

    devCVSHandler.Executable := edCVSExec.Text;
    devCVSHandler.Compression := spnCVSCompression.Value;
    devCVSHandler.UseSSH := chkCVSUseSSH.Checked;

    btnOk.Enabled := True;
    Cursor := crDefault;

End;

Procedure TEnviroForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_ENV];

    //Tabs
    tabGeneral.Caption := Lang[ID_ENV_GENTAB];
    tabInterface.Caption := Lang[ID_ENV_INTERFACETAB];
    tabPaths.Caption := Lang[ID_ENV_PATHTAB];
    tabAssocs.Caption := Lang[ID_ENV_FASSTAB];
    tabCVS.Caption := Lang[ID_ENV_CVSTAB];
    tabExternal.Caption := Lang[ID_ENV_EXTERNALS];

    //Buttons
    btnOk.Caption := Lang[ID_BTN_OK];
    btnCancel.Caption := Lang[ID_BTN_CANCEL];
    btnHelp.Caption := Lang[ID_BTN_HELP];

    //Controls
    cbDefCpp.Caption := Lang[ID_ENV_DEFCPP];
    cbShowBars.Caption := Lang[ID_ENV_SHOWBARS];
    cbShowMenu.Caption := Lang[ID_ENV_SHOWMENU];
    cbBackups.Caption := Lang[ID_ENV_BACKUPS];
    cbMinOnRun.Caption := Lang[ID_ENV_MINONRUN];
    cbdblFiles.Caption := Lang[ID_ENV_DBLFILES];
    cbNoSplashScreen.Caption := Lang[ID_ENV_NOSPLASH];
    cbHiliteActiveTab.Caption := Lang[ID_ENV_HILITETAB];
    cbXPTheme.Caption := Lang[ID_ENV_XPTHEME];

    gbProgress.Caption := Lang[ID_ENV_COMPPROGRESSWINDOW];
    cbShowProgress.Caption := Lang[ID_ENV_SHOWPROGRESS];
    cbAutoCloseProgress.Caption := Lang[ID_ENV_AUTOCLOSEPROGRESS];

    cbWatchHint.Caption := Lang[ID_ENV_WATCHHINT];
    cbWatchError.Caption := Lang[ID_ENV_WATCHERROR];
    gbDebugger.Caption := Lang[ID_ENV_DEBUGGER];

    rgbOpenStyle.Caption := Lang[ID_ENV_OPENSTYLE];
    rgbOpenStyle.Items[0] := Lang[ID_ENV_OPEN2k];
    rgbOpenStyle.Items[1] := Lang[ID_ENV_OPEN9x];
    rgbOpenStyle.Items[2] := Lang[ID_ENV_OPEN31];
    lblOpenSaveOptions.Caption := Lang[ID_WX_NO_OPEN_SAVE_DIALOG_OPT];


    rgbAutoOpen.Caption := Lang[ID_ENV_AUTOOPEN];
    rgbAutoOpen.Items[0] := Lang[ID_ENV_AUTOALL];
    rgbAutoOpen.Items[1] := Lang[ID_ENV_AUTOFIRST];
    rgbAutoOpen.Items[2] := Lang[ID_ENV_AUTONONE];

    gbAltConfig.Caption := Lang[ID_ENV_GBALTCONFIG];
    chkAltConfig.Caption := Lang[ID_ENV_USEALTCONFIG];
    lblLang.Caption := Lang[ID_ENV_LANGUAGE];
    lblTheme.Caption := Lang[ID_ENV_THEME];
    lblmsgTabs.Caption := Lang[ID_ENV_MSGTABS];
    lblMRU.Caption := Lang[ID_ENV_MRU];

    lblUserDir.Caption := Lang[ID_ENV_USERDIR];
    lblTemplatesDir.Caption := Lang[ID_ENV_TEMPLATESDIR];
    lblIcoLib.Caption := Lang[ID_ENV_ICOLIB];
    lblSplash.Caption := Lang[ID_ENV_SPLASH];
    lblLangPath.Caption := Lang[ID_ENV_SELLANGDIR];

    // externals tab
    lblExternal.Caption := Lang[ID_ENV_EXTERNPROGASSOCS];
    vleExternal.TitleCaptions.Clear;
    vleExternal.TitleCaptions.Add(Lang[ID_ENV_EXTERNEXT]);
    vleExternal.TitleCaptions.Add(Lang[ID_ENV_EXTERNPROG]);
    btnExtAdd.Caption := Lang[ID_BTN_ADD];
    btnExtDel.Caption := Lang[ID_BTN_DELETE];

    // associations tab
    lblAssocFileTypes.Caption := Lang[ID_ENV_FASSTYPES];
    lblAssocDesc.Caption := Lang[ID_ENV_FASSDESC];

    // CVS support tab
    lblCVSExec.Caption := Lang[ID_ENV_CVSEXE];
    lblCVSCompression.Caption := Lang[ID_ENV_CVSCOMPR];
    chkCVSUseSSH.Caption := Lang[ID_ENV_CVSUSESSH];
End;

Procedure TEnviroForm.btnHelpClick(Sender: TObject);
Begin
    HelpFile := devDirs.Help + DEV_MAINHELP_FILE;
    HtmlHelp(self.handle, Pchar(HelpFile), HH_DISPLAY_TOPIC,
        DWORD(Pchar('html\environ_general.html')));
End;

Procedure TEnviroForm.FormKeyDown(Sender: TObject; Var Key: Word;
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
            DWORD(Pchar(Help_Topics[PagesMain.ActivePageIndex])));
    End;
End;

Procedure TEnviroForm.FormCreate(Sender: TObject);
Begin
    LoadText;
    PagesMain.ActivePageIndex := 0;
    If IsWindowsVista Then
    Begin
        rgbOpenStyle.Enabled := False;
        lblOpenSaveOptions.Visible := True;
        // EAB TODO: Add multi language support  
    End;
End;

Procedure TEnviroForm.vleExternalEditButtonClick(Sender: TObject);
Begin
    If Trim(vleExternal.Cells[0, vleExternal.Row]) = '' Then
    Begin
        MessageDlg('Add an extension first!', mtError, [mbOk], 0);
        Exit;
    End;

    With dmMain.OpenDialog Do
    Begin
        Filter := FLT_ALLFILES;
        If Execute Then
            vleExternal.Cells[1, vleExternal.Row] := Filename;
    End;
End;

Procedure TEnviroForm.vleExternalValidate(Sender: TObject; ACol,
    ARow: Integer; Const KeyName, KeyValue: String);
Var
    idx: Integer;
Begin
    If vleExternal.FindRow(KeyName, idx) And (idx <> ARow) Then
    Begin
        MessageDlg('Extension exists...', mtError, [mbOk], 0);
        vleExternal.Col := 0;
        vleExternal.Row := ARow;
        Abort;
    End;
    vleExternal.ItemProps[ARow - 1].EditStyle := esEllipsis;
End;

Procedure TEnviroForm.btnExtAddClick(Sender: TObject);
Begin
    vleExternal.InsertRow('', '', True);
    vleExternal.Row := vleExternal.RowCount - 1;
    vleExternal.Col := 0;
    vleExternal.SetFocus;
End;

Procedure TEnviroForm.btnExtDelClick(Sender: TObject);
Begin
    If (vleExternal.Row = 1) And (vleExternal.RowCount = 2) And
        (vleExternal.Cells[0, 1] = '') Then
        exit;
    If (vleExternal.RowCount > 1) And (vleExternal.Row > 0) Then
        vleExternal.DeleteRow(vleExternal.Row);
End;

Procedure TEnviroForm.chkAltConfigClick(Sender: TObject);
Begin
    chkAltConfig.Enabled := ConfigMode <> CFG_PARAM;
    edAltConfig.Enabled := chkAltConfig.Enabled And chkAltConfig.Checked;
    btnAltConfig.Enabled := chkAltConfig.Enabled And chkAltConfig.Checked;
End;

End.
