{
    $Id: CompOptionsFrm.pas 932 2007-04-20 10:27:52Z lowjoel $

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
Unit CompOptionsFrm;

Interface

Uses
{$IFDEF PLUGIN_BUILD}
    iplugin_bpl, iplugin,
{$ENDIF}
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    Buttons, StdCtrls, Inifiles, ExtCtrls, ComCtrls, devTabs, Spin, XPMenu,
    CompilerOptionsFrame;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QButtons, QStdCtrls, Inifiles, QExtCtrls, QComCtrls, devTabs,
  CompilerOptionsFrame;
{$ENDIF}

Type
    TCompForm = Class(TForm)
        btnOk: TBitBtn;
        btnCancel: TBitBtn;
        btnDefault: TBitBtn;
        btnHelp: TBitBtn;
        MainPages: TPageControl;
        tabDirectories: TTabSheet;
        tabCompiler: TTabSheet;
        tabCodeGen: TTabSheet;
        DirTabs: TdevTabs;
        btnUp: TSpeedButton;
        btnDown: TSpeedButton;
        lstDirs: TListBox;
        edEntry: TEdit;
        btnDelInval: TButton;
        btnDelete: TButton;
        btnAdd: TButton;
        btnReplace: TButton;
        tabPrograms: TTabSheet;
        lblProgramsText: TLabel;
        lblgcc: TLabel;
        GccEdit: TEdit;
        GppEdit: TEdit;
        lblgpp: TLabel;
        lblmake: TLabel;
        MakeEdit: TEdit;
        lblgdb: TLabel;
        GdbEdit: TEdit;
        lblwindres: TLabel;
        WindresEdit: TEdit;
        lbldllwrap: TLabel;
        DllwrapEdit: TEdit;
        lblgprof: TLabel;
        GprofEdit: TEdit;
        XPMenu: TXPMenu;
        CompOptionsFrame1: TCompOptionsFrame;
        grpCompSet: TGroupBox;
        btnBrws2: TSpeedButton;
        btnBrowse3: TSpeedButton;
        btnBrowse4: TSpeedButton;
        btnBrowse5: TSpeedButton;
        btnBrowse6: TSpeedButton;
        btnBrowse7: TSpeedButton;
        btnBrowse8: TSpeedButton;
        cmdline: TGroupBox;
        Commands: TMemo;
        Linker: TMemo;
        lblDelay: TLabel;
        seCompDelay: TSpinEdit;
        cbCompAdd: TLabel;
        cbLinkerAdd: TLabel;
        CompilerTypes: TComboBox;
        CompilerTypeLbl: TLabel;
        cbFastDep: TCheckBox;
        cbMakeAdd: TLabel;
        Make: TMemo;
        btnBrowse: TSpeedButton;
        cmbCompilerSetComp: TComboBox;
        btnAddCompilerSet: TSpeedButton;
        btnDelCompilerSet: TSpeedButton;
        btnRenameCompilerSet: TSpeedButton;
        Label1: TLabel;
        btnRefreshCompilerSettings: TSpeedButton;

        Procedure btnCancelClick(Sender: TObject);
        Procedure btnOkClick(Sender: TObject);
        Procedure FormActivate(Sender: TObject);
        Procedure btnDefaultClick(Sender: TObject);
        Procedure btnHelpClick(Sender: TObject);
        Procedure DirTabsChange(Sender: TObject);
        Procedure DirTabsChanging(Sender: TObject; NewIndex: Integer;
            Var AllowChange: Boolean);
        Procedure lstDirsClick(Sender: TObject);
        Procedure lstDirsDblClick(Sender: TObject);
        Procedure edEntryChange(Sender: TObject);
        Procedure btnBrowseClick(Sender: TObject);
        Procedure ButtonClick(Sender: TObject);
        Procedure UpDownClick(Sender: TObject);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure edEntryKeyUp(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure FormCreate(Sender: TObject);
        Procedure btnBrws1Click(Sender: TObject);
        Procedure cmbCompilerSetCompChange(Sender: TObject);
        Procedure btnAddCompilerSetClick(Sender: TObject);
        Procedure btnDelCompilerSetClick(Sender: TObject);
        Procedure btnRenameCompilerSetClick(Sender: TObject);
        Procedure CompilerTypesClick(Sender: TObject);
        Procedure LoadOptions;
        Procedure SaveSettings;
        Procedure btnRefreshCompilerSettingsClick(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);

    Private
        fBins: String;
        fLibs: String;
        fC: String;
        fCpp: String;
        fRC: String;
        Procedure SetOptions;
        Procedure UpdateButtons;
        Procedure LoadText;
    End;

Var
    NumOpt: Integer;
    currentSet: Integer;
    previousSet: Integer;

Implementation

Uses
{$IFDEF WIN32}
    Main, FileCtrl, version, devcfg, utils, MultiLangSupport, datamod, hh;
{$ENDIF}
{$IFDEF LINUX}
  Xlib, Main, version, devcfg, utils, MultiLangSupport, datamod;
{$ENDIF}

{$R *.dfm}

Const
    Help_Topics: Array[0..4] Of String = (
        'html\compiler_compiler.html',
        'html\compiler_settings.html',
        'html\compiler_dirs.html',
        'html\compiler_programs.html',
        'html\compiler_wxwidgets.html');

Procedure TCompForm.btnCancelClick(Sender: TObject);
Begin
    devCompiler.CompilerSet := previousSet;  // Return to initial compiler set
    Close;
End;

Procedure TCompForm.btnOkClick(Sender: TObject);
Begin
    If (fBins = '') Then
    Begin
        MessageDlg('You have not indicated the location of your binaries (compiler).'#13#10 +
            'Please do so now.', mtError, [mbOK], Handle);
        ModalResult := mrNone;
        Exit;
    End;

    Screen.Cursor := crHourGlass;
    btnOk.Enabled := False;

    self.SaveSettings;
    devCompilerSet.AssignToCompiler;
    With devCompiler Do
    Begin
        Delay := seCompDelay.Value;
        FastDep := cbFastDep.Checked;
        CompilerSet := cmbCompilerSetComp.ItemIndex;
        devCompilerSet.Sets.Assign(cmbCompilerSetComp.Items);
    End;

    With devDirs Do
    Begin
        C := fC;
        Cpp := fCpp;
        Lib := fLibs;
        RC := fRC;
        Bins := fBins;
        SetPath(Bins);
    End;

    devDirs.SaveSettings;
    devCompiler.SaveSettings;

    // The Tools->Compiler Options window shouldn't change the compiler for the
    // current project. That should only be possible from Project->Project Settings.
    // So at the very end, let's just go back to the original compiler index
    // (which is what the project was set to)
    If Assigned(MainForm.fProject) Then
        devCompiler.CompilerSet := previousSet;

    btnOk.Enabled := True;
    Cursor := crDefault;

End;

Procedure TCompForm.FormActivate(Sender: TObject);
Begin
    SetOptions;
    DirTabsChange(Self);
    currentSet := devCompiler.CompilerSet;
    previousSet := currentSet;  // Remember the initial compiler index
End;

Procedure TCompForm.SetOptions;
Begin
    With devCompiler Do
    Begin
        seCompDelay.Value := Delay;
        cbFastDep.Checked := FastDep;
        Commands.Lines.Text := CmdOpts;
        Linker.Lines.Text := LinkOpts;
        Make.Lines.Text := MakeOpts;

        cmbCompilerSetComp.Items.Clear;
        cmbCompilerSetComp.Items.Assign(devCompilerSet.Sets);

        If CompilerSet < cmbCompilerSetComp.Items.Count Then
            cmbCompilerSetComp.ItemIndex := CompilerSet
        Else
        If cmbCompilerSetComp.Items.Count > 0 Then
            cmbCompilerSetComp.ItemIndex := 0;

        currentSet := cmbCompilerSetComp.ItemIndex;
        devCompilerSet.LoadSet(CompilerSet);
        LoadOptions;
    End;
End;

Procedure TCompForm.btnDefaultClick(Sender: TObject);
Var
    i: Integer;
Begin
    devCompiler.SettoDefaults;
    SetOptions;

{$IFDEF PLUGIN_BUILD}//EAB TODO: Make this more general (not easy to do :P )

    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin
        MainForm.plugins[i].SetCompilerOptionstoDefaults;
    End;
{$ENDIF}

End;

Procedure TCompForm.btnHelpClick(Sender: TObject);
Begin
    HelpFile := devDirs.Help + DEV_MAINHELP_FILE;
    HtmlHelp(MainForm.handle, Pchar(HelpFile), HH_DISPLAY_TOPIC,
        DWORD(Pchar('html\compiler_options.html')));
End;

Procedure TCompForm.DirTabsChange(Sender: TObject);
Begin
    Case DirTabs.TabIndex Of
        0:
            StrtoList(fBins, TStrings(lstDirs.Items));
        1:
            StrtoList(fLibs, TStrings(lstDirs.Items));
        2:
            StrtoList(fC, TStrings(lstDirs.Items));
        3:
            StrtoList(fCpp, TStrings(lstDirs.Items));
        4:
            StrtoList(fRC, TStrings(lstDirs.Items));
    End;
    edEntry.Clear;
    UpdateButtons;
End;

Procedure TCompForm.DirTabsChanging(Sender: TObject; NewIndex: Integer;
    Var AllowChange: Boolean);
Begin
    UpdateButtons;
End;

Procedure TCompForm.lstDirsClick(Sender: TObject);
Begin
    UpdateButtons;
End;

Procedure TCompForm.lstDirsDblClick(Sender: TObject);
Begin
    If lstDirs.ItemIndex <> -1 Then
        edEntry.Text := lstDirs.Items[lstDirs.ItemIndex];
End;

Procedure TCompForm.edEntryChange(Sender: TObject);
Begin
    UpdateButtons;
End;

Procedure TCompForm.btnBrowseClick(Sender: TObject);
Var
{$IFDEF WIN32}
    NewItem: String;
{$ENDIF}
{$IFDEF LINUX}
  NewItem: WideString;
{$ENDIF}
Begin
    If (Trim(edEntry.Text) <> '') And DirectoryExists(Trim(edEntry.Text)) Then
        newitem := edEntry.Text
    Else
        newitem := devDirs.Default;
    If SelectDirectory('', '', NewItem) Then
        edEntry.Text := NewItem;
End;

Procedure TCompForm.ButtonClick(Sender: TObject);
Var
    idx: Integer;

    Function VerifyPath: Boolean;
    Begin
        If CompilerTypes.ItemIndex = ID_COMPILER_DMARS Then
        Begin
            Result := Pos('+', edEntry.Text) = 0;
            If Not Result Then
                MessageDlg('The Digital Mars Compiler does not support having ''+'' in its path.'#13#10#13#10 +
                    'Please place your binaries in a directory that does not contain plus-signs in its path.',
                    mtError, [mbOK], Handle);
        End
        Else
            Result := True;
    End;
Begin
    Case (Sender As TComponent).Tag Of
        1:
            If VerifyPath Then
            Begin
                lstDirs.Items[lstDirs.ItemIndex] :=
                    ExcludeTrailingPathDelimiter(TrimRight(edEntry.Text));
                edEntry.Clear;
            End;
        2:
            If VerifyPath Then
            Begin
                lstDirs.Items.Add(ExcludeTrailingPathDelimiter(TrimRight(edEntry.Text)));
                edEntry.Clear;
            End;
        3:
            lstDirs.DeleteSelected;
        4:
            For idx := pred(lstDirs.Items.Count) Downto 0 Do
                If Not DirectoryExists(lstDirs.Items[idx]) Then
                    lstDirs.Items.Delete(idx);
    End; { case }

    Case DirTabs.TabIndex Of
        0:
            fBins := ListtoStr(lstDirs.Items);
        1:
            fLibs := ListtoStr(lstDirs.Items);
        2:
            fC := ListtoStr(lstDIrs.Items);
        3:
            fCpp := ListtoStr(lstDirs.Items);
        4:
            fRC := ListtoStr(lstDirs.Items);
    End;
    edEntry.SetFocus;
End;

Procedure TCompForm.UpDownClick(Sender: TObject);
Var
    idx: Integer;
Begin
    idx := lstDirs.ItemIndex;
    If Sender = btnUp Then
    Begin
        lstDirs.Items.Exchange(lstDirs.ItemIndex, lstDirs.ItemIndex - 1);
        lstDirs.ItemIndex := idx - 1;
    End
    Else
    Begin
        If Sender = btnDown Then
        Begin
            lstDirs.Items.Exchange(lstDirs.ItemIndex, lstDirs.ItemIndex + 1);
            lstDirs.ItemIndex := idx + 1;
        End;
    End;

    Case DirTabs.TabIndex Of
        0:
            fBins := ListtoStr(lstDirs.Items);
        1:
            fLibs := ListtoStr(lstDirs.Items);
        2:
            fC := ListtoStr(lstDIrs.Items);
        3:
            fCpp := ListtoStr(lstDirs.Items);
        4:
            fRC := ListtoStr(lstDirs.Items);
    End;
    UpdateButtons;
End;

Procedure TCompForm.UpdateButtons;
Begin
    btnAdd.Enabled := edEntry.Text <> '';
    If lstDirs.ItemIndex >= 0 Then
    Begin
        btnDelete.Enabled := True;
        btnReplace.Enabled := btnAdd.Enabled;
        btnUp.Enabled := lstDirs.ItemIndex > 0;
        btnDown.Enabled := lstDirs.ItemIndex < (lstDirs.Items.Count - 1);
    End
    Else
    Begin
        btnDelete.Enabled := False;
        btnReplace.Enabled := False;
        btnUp.Enabled := False;
        btnDown.Enabled := False;
    End;
    btnDelInval.Enabled := lstDirs.Items.Count > 0;
End;

Procedure TCompForm.FormKeyDown(Sender: TObject; Var Key: Word;
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
        //HelpKeyword := Help_Topics[MainPages.ActivePageIndex];
        HtmlHelp(MainForm.handle, Pchar(HelpFile), HH_DISPLAY_TOPIC,
            DWORD(Pchar(Help_Topics[MainPages.ActivePageIndex])));
    End;
End;

Procedure TCompForm.edEntryKeyUp(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
{$IFDEF WIN32}
    If key = vk_return Then
        ButtonClick(btnAdd);
{$ENDIF}
{$IFDEF LINUX}
  if key = XK_RETURN then ButtonClick(btnAdd);
{$ENDIF}
End;

Procedure TCompForm.FormCreate(Sender: TObject);
Begin
    LoadText;
    CompOptionsFrame1.FillOptions(Nil);
    MainPages.ActivePageIndex := 0;
    DirTabs.TabIndex := 0;
End;

Procedure TCompForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_COPT];
    //tabs
    tabCompiler.Caption := Lang[ID_COPT_COMPTAB];
    tabDirectories.Caption := Lang[ID_COPT_DIRTAB];
    tabCodeGen.Caption := Lang[ID_COPT_CODEGENTAB];
    tabPrograms.Caption := Lang[ID_COPT_PROGRAMSTAB];

    // subtabs
    DirTabs.Tabs.Clear;
    DirTabs.Tabs.Append(Lang[ID_COPT_BIN]);
    DirTabs.Tabs.Append(Lang[ID_COPT_LIB]);
    DirTabs.Tabs.Append(Lang[ID_COPT_INCC]);
    DirTabs.Tabs.Append(Lang[ID_COPT_INCCPP]);
    DirTabs.Tabs.Append('Resource Includes');

    //buttons
    btnReplace.Caption := Lang[ID_BTN_REPLACE];
    btnAdd.Caption := Lang[ID_BTN_ADD];
    btnDelete.Caption := Lang[ID_BTN_DELETE];
    btnDelInval.Caption := Lang[ID_BTN_DELINVAL];
    btnOk.Caption := Lang[ID_BTN_OK];
    btnCancel.Caption := Lang[ID_BTN_CANCEL];
    btnHelp.Caption := Lang[ID_BTN_HELP];
    btnDefault.Caption := Lang[ID_BTN_DEFAULT];

    //controls (compiler tab)
    cbCompAdd.Caption := Lang[ID_COPT_ADDCOMP];
    lblDelay.Caption := Lang[ID_COPT_DELAY];
    lblDelay.Hint := Lang[ID_COPT_DELAYMSG];
    cbLinkerAdd.Caption := Lang[ID_COPT_LINKADD];
    cbFastDep.Caption := Lang[ID_COPT_FASTDEP];

    // conrols (Programs tab)
    lblProgramsText.Caption := Lang[ID_COPT_PROGRAMS];

    grpCompSet.Caption := Lang[ID_COPT_COMPSETS];
End;

Procedure TCompForm.cmbCompilerSetCompChange(Sender: TObject);
{$IFDEF PLUGIN_BUILD}
Var
    i, j: Integer;
    pluginSettings: TSettings;
    tempName: String;
{$ENDIF}
Begin

    pluginSettings := nil;

    //SaveSettings;    EAB
    devCompilerSet.LoadSet(cmbCompilerSetComp.ItemIndex);

    {$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin

      // Get plugin-specific compiler options
        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        For j := 0 To Length(pluginSettings) - 1 Do
        Begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);

            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            If tempName <> '' Then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        End;
        MainForm.plugins[i].LoadCompilerOptions;

    End;
{$ENDIF}

    currentSet := cmbCompilerSetComp.ItemIndex;
    LoadOptions;

End;

Procedure TCompForm.LoadOptions;
{$IFDEF PLUGIN_BUILD}
Var
    i, j: Integer;
    pluginSettings: TSettings;
    tempName: String;
{$ENDIF PLUGIN_BUILD}
Begin

    pluginSettings := nil;

    With devCompilerSet Do
    Begin
        fBins := BinDir;
        fC := CDir;
        fCpp := CppDir;
        fLibs := LibDir;
        fRC := RCDir;

        Commands.Lines.Text := CmdOpts;
        Linker.Lines.Text := LinkOpts;
        Make.Lines.Text := MakeOpts;
        CompilerTypes.ItemIndex := CompilerType;
        DirTabsChange(DirTabs);

        GccEdit.Text := gccName;
        GppEdit.Text := gppName;
        GdbEdit.Text := gdbName;
        MakeEdit.Text := makeName;
        WindresEdit.Text := windresName;
        DllwrapEdit.Text := dllwrapName;
        GprofEdit.Text := gprofName;

        devCompiler.AddDefaultOptions;
        devCompiler.OptionStr := OptionsStr;

    {$IFDEF PLUGIN_BUILD}
        For i := 0 To MainForm.pluginsCount - 1 Do
        Begin

            pluginSettings := MainForm.plugins[i].GetCompilerOptions;

            For j := 0 To Length(pluginSettings) - 1 Do
            Begin

            // This line loads it from the .ini file.
                tempName := devData.LoadSetting(optComKey,
                    pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
                If tempName <> '' Then
                    MainForm.plugins[i].LoadCompilerSettings(
                        pluginSettings[j].name, tempName);
            End;
            MainForm.plugins[i].LoadCompilerOptions;

        End;

    {$ENDIF PLUGIN_BUILD}

        CompOptionsFrame1.FillOptions(Nil);
        CompilerTypesClick(Nil);
    End;
End;

Procedure TCompForm.SaveSettings;
{$IFDEF PLUGIN_BUILD}
Var
    i: Integer;
{$ENDIF PLUGIN_BUILD}
Begin
    devCompilerSet.CompilerType := CompilerTypes.ItemIndex;
    devCompilerSet.gccName := GccEdit.Text;
    devCompilerSet.gppName := GppEdit.Text;
    devCompilerSet.makeName := MakeEdit.Text;
    devCompilerSet.gdbName := GdbEdit.Text;
    devCompilerSet.windresName := WindresEdit.Text;
    devCompilerSet.dllwrapName := DllwrapEdit.Text;
    devCompilerSet.gprofName := GprofEdit.Text;

    devCompilerSet.BinDir := fBins;
    devCompilerSet.CDir := fC;
    devCompilerSet.CppDir := fCpp;
    devCompilerSet.LibDir := fLibs;
    devCompilerSet.RCDir := fRC;

    devCompilerSet.CmdOpts := Commands.Lines.Text;
    devCompilerSet.LinkOpts := Linker.Lines.Text;
    devCompilerSet.MakeOpts := Make.Lines.Text;
    devCompilerSet.OptionsStr := devCompiler.OptionStr;

  {$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.pluginsCount - 1 Do
        MainForm.plugins[i].SaveCompilerOptions;
  {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(currentSet);
    devCompilerSet.SaveSettings;

End;

Procedure TCompForm.btnBrws1Click(Sender: TObject);
Var
    sl: TStringList;
    Obj: TEdit;
Begin
    Obj := Nil;
    Case TSpeedButton(Sender).Tag Of
        2:
            Obj := GccEdit; //gcc
        3:
            Obj := GppEdit; //gpp
        4:
            Obj := MakeEdit; //make
        5:
            Obj := GdbEdit; //gdb
        6:
            Obj := WindresEdit; //windres
        7:
            Obj := DllwrapEdit; //dllwrap
        8:
            Obj := GprofEdit; //gprof
    End;

    If Not Assigned(Obj) Then
        Exit;

    dmMain.OpenDialog.Filter := FLT_ALLFILES;
    sl := TStringList.Create;
    Try
        sl.Delimiter := ';';
        sl.DelimitedText := devCompilerSet.BinDir;
        If sl.Count > 0 Then
            dmMain.OpenDialog.InitialDir := sl[0];
    Finally
        sl.Free;
    End;

    dmMain.OpenDialog.FileName :=
        IncludeTrailingPathDelimiter(dmMain.OpenDialog.InitialDir) + Obj.Text;
    If dmMain.OpenDialog.Execute Then
    Begin
        Obj.Text := ExtractFileName(dmMain.OpenDialog.FileName);
    End;
End;

Procedure TCompForm.btnAddCompilerSetClick(Sender: TObject);
Var
    S: String;
Begin
    S := 'New compiler';
    If Not InputQuery(Lang[ID_COPT_NEWCOMPSET], Lang[ID_COPT_PROMPTNEWCOMPSET],
        S) Or (S = '') Then
        Exit;

    devCompilerSet.Sets.Add(S);
    cmbCompilerSetComp.ItemIndex := cmbCompilerSetComp.Items.Add(S);
    cmbCompilerSetCompChange(Nil);
End;

Procedure TCompForm.btnDelCompilerSetClick(Sender: TObject);
Begin
    If cmbCompilerSetComp.Items.Count = 1 Then
    Begin
        MessageDlg(Lang[ID_COPT_CANTDELETECOMPSET], mtError, [mbOk], 0);
        Exit;
    End;

    If MessageDlg(Lang[ID_COPT_DELETECOMPSET], mtConfirmation,
        [mbYes, mbNo], 0) = mrNo Then
        Exit;

    devCompilerSet.Sets.Delete(cmbCompilerSetComp.ItemIndex);
    cmbCompilerSetComp.Items.Delete(cmbCompilerSetComp.ItemIndex);
    cmbCompilerSetComp.ItemIndex := 0;
    cmbCompilerSetCompChange(Nil);
End;

Procedure TCompForm.btnRenameCompilerSetClick(Sender: TObject);
Var
    S: String;
Begin
    S := cmbCompilerSetComp.Text;
    If Not InputQuery(Lang[ID_COPT_RENAMECOMPSET],
        Lang[ID_COPT_PROMPTRENAMECOMPSET], S) Or (S = '') Or
        (S = cmbCompilerSetComp.Text) Then
        Exit;

    cmbCompilerSetComp.Items[cmbCompilerSetComp.ItemIndex] := S;
    cmbCompilerSetComp.ItemIndex := cmbCompilerSetComp.Items.IndexOf(S);
End;

Procedure TCompForm.CompilerTypesClick(Sender: TObject);
Begin
    devCompilerSet.CompilerType := CompilerTypes.ItemIndex;
    If (Sender <> Nil) Then
    Begin
        devDirs.CompilerType := CompilerTypes.ItemIndex;
        devDirs.SettoDefaults;
    End;
    devCompilerSet.SettoDefaults;
    devCompiler.AddDefaultOptions;
    devCompiler.OptionStr := devCompilerSet.OptionsStr;
    CompOptionsFrame1.FillOptions(Nil);

    //In order to remove the recursive call from loadOptions
    //we just check if the paramter sent by the calling function is
    //nil.
    If (Sender <> Nil) Then
        LoadOptions;

    //Set the labels
    Case CompilerTypes.ItemIndex Of
        ID_COMPILER_MINGW:
        Begin
            lblgprof.Caption := 'Code Profiler:';
            lblgprof.Enabled := True;
            gprofEdit.Enabled := True;
            btnbrowse8.Enabled := True;

            lbldllwrap.Enabled := False;
            DllwrapEdit.Enabled := False;
            btnbrowse7.Enabled := False;
        End;
        ID_COMPILER_LINUX:
        Begin
            lblgprof.Caption := 'Code Profiler:';
            lblgprof.Enabled := True;
            gprofEdit.Enabled := True;
            btnbrowse8.Enabled := True;

            lbldllwrap.Enabled := False;
            DllwrapEdit.Enabled := False;
            btnbrowse7.Enabled := False;
        End;
        ID_COMPILER_VC6,
        ID_COMPILER_VC2003:
        Begin
            lblgprof.Caption := 'Manifest Tool:';
            lblgprof.Enabled := False;
            gprofEdit.Enabled := False;
            btnbrowse8.Enabled := False;

            lbldllwrap.Enabled := True;
            DllwrapEdit.Enabled := True;
            btnbrowse7.Enabled := True;
        End;
        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005:
        Begin
            lblgprof.Caption := 'Manifest Tool:';
            lblgprof.Enabled := True;
            gprofEdit.Enabled := True;
            btnbrowse8.Enabled := True;

            lbldllwrap.Enabled := True;
            DllwrapEdit.Enabled := True;
            btnbrowse7.Enabled := True;
        End;
    End;
End;

Procedure TCompForm.btnRefreshCompilerSettingsClick(Sender: TObject);
Begin
    If MessageDlg('Are you sure you wish to reset all the compiler settings to their defaults?'#10#13#10#13 +
        'To redetect the necessary compiler, include and library paths, or if you have '#10#13 +
        'installed the selected compiler after installing wxDev-C++, select Yes.',
        mtConfirmation,
        [mbYes, mbNo], Self.Handle) = mrYes Then
        CompilerTypesClick(CompilerTypes);
End;

Procedure TCompForm.FormClose(Sender: TObject; Var Action: TCloseAction);
{$IFDEF PLUGIN_BUILD}
Var
    i: Integer;
    tabs: TTabSheet;
{$ENDIF PLUGIN_BUILD}
Begin
{$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.packagesCount - 1 Do
    Begin
        tabs := (MainForm.plugins[MainForm.delphi_plugins[i]] As
            IPlug_In_BPL).Retrieve_CompilerOptionsPane;
        If tabs <> Nil Then
            tabs.PageControl := Nil;
    End;
    MainPages.ActivePageIndex := 0;
{$ENDIF PLUGIN_BUILD}
End;

End.
