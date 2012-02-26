{
     $Id$

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

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

Unit ProjectOptionsFrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    ExtDlgs, StdCtrls, ExtCtrls, Buttons, ComCtrls, main, project,
    devTabs, prjtypes, XPMenu, Spin, Grids, ValEdit, CompilerOptionsFrame,
    OpenSaveDialogs, iplugin;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls, QButtons, QComCtrls, main, project,
  devTabs, prjtypes, QGrids, CompilerOptionsFrame, Types;
{$ENDIF}

Type
    TfrmProjectOptions = Class(TForm)
        btnOk: TBitBtn;
        btnCancel: TBitBtn;
        btnHelp: TBitBtn;
        dlgPic: TOpenPictureDialog;
        PageControl: TPageControl;
        tabGeneral: TTabSheet;
        tabFilesDir: TTabSheet;
        lblPrjName: TLabel;
        grpIcon: TGroupBox;
        btnIconBrwse: TBitBtn;
        btnIconLib: TBitBtn;
        grpType: TGroupBox;
        lstType: TListBox;
        edProjectName: TEdit;
        btnUp: TSpeedButton;
        btnDown: TSpeedButton;
        SubTabs: TdevTabs;
        lstList: TListBox;
        btnAdd: TButton;
        btnDelete: TButton;
        btnReplace: TButton;
        edEntry: TEdit;
        btnDelInval: TButton;
        btnRemoveIcon: TBitBtn;
        Panel1: TPanel;
        Icon: TImage;
        tabOutputDir: TTabSheet;
        grpOutDirectories: TGroupBox;
        lblExeOutput: TLabel;
        lblObjOutput: TLabel;
        edExeOutput: TEdit;
        edObjOutput: TEdit;
        tabMakefile: TTabSheet;
        edOverridenOutput: TEdit;
        chkOverrideOutput: TCheckBox;
        XPMenu: TXPMenu;
        tabFiles: TTabSheet;
        grpUnitOptions: TGroupBox;
        chkCompile: TCheckBox;
        chkCompileCpp: TCheckBox;
        tabVersion: TTabSheet;
        chkVersionInfo: TCheckBox;
        grpVersion: TGroupBox;
        lblVerMajor: TLabel;
        lblVerMinor: TLabel;
        lblVerRel: TLabel;
        lblVerBuild: TLabel;
        spnMajor: TSpinEdit;
        spnMinor: TSpinEdit;
        spnRelease: TSpinEdit;
        spnBuild: TSpinEdit;
        tabCompiler: TTabSheet;
        chkSupportXP: TCheckBox;
        chkOverrideBuildCmd: TCheckBox;
        txtOverrideBuildCmd: TMemo;
        lblFname: TLabel;
        lblPrjFname: TLabel;
        lblUnits: TLabel;
        lblPrjUnits: TLabel;
        lblPrjOutputFname: TLabel;
        lblPrjOutput: TLabel;
        chkLink: TCheckBox;
        lblPriority: TLabel;
        spnPriority: TSpinEdit;
        tabCompOpts: TTabSheet;
        CompOptionsFrame1: TCompOptionsFrame;
        cmbCompiler: TComboBox;
        lblCompilerSet: TLabel;
        lblCompileInfo: TLabel;
        lblCompiler: TLabel;
        edCompiler: TMemo;
        lblCppCompiler: TLabel;
        edCppCompiler: TMemo;
        lblLinker: TLabel;
        edLinker: TMemo;
        AddLibBtn: TBitBtn;
        btnBrowse: TSpeedButton;
        btnExeOutDir: TSpeedButton;
        btnObjOutDir: TSpeedButton;
        cbUseCustomMakefile: TCheckBox;
        edCustomMakefile: TEdit;
        btnCustomMakeBrowse: TSpeedButton;
        lbldefines: TLabel;
        edDefines: TMemo;
        grpAdditional: TGroupBox;
        vleVersion: TValueListEditor;
        grpAutoInc: TGroupBox;
        radAutoIncBuildOnCompile: TRadioButton;
        radAutoIncBuildOnRebuild: TRadioButton;
        radNoAutoIncBuild: TRadioButton;
        lblLanguage: TLabel;
        cmbLangID: TComboBox;
        grpMakefileCustomize: TGroupBox;
        lblMakefileCustomize: TLabel;
        grpIncMake: TGroupBox;
        MakeIncludes: TListBox;
        edMakeInclude: TEdit;
        btnMakDown: TSpeedButton;
        btnMakUp: TSpeedButton;
        btnMakeBrowse: TSpeedButton;
        btnMakDelInval: TButton;
        btnMakDelete: TButton;
        btnMakAdd: TButton;
        btnMakReplace: TButton;
        grpPch: TRadioGroup;
        lvFiles: TTreeView;
        btnAddProfileSet: TSpeedButton;
        btnDelProfileSet: TSpeedButton;
        btnRenameProfileSet: TSpeedButton;
        Label2: TLabel;
        cmbProfileSetComp: TComboBox;
        btnCopyProfileSet: TSpeedButton;
        lblImagesoutputdir: TLabel;
        edImagesOutput: TEdit;
        btnImagesOutputDir: TSpeedButton;
        Procedure ListClick(Sender: TObject);
        Procedure EditChange(SEnder: TObject);
        Procedure ButtonClick(Sender: TObject);
        Procedure UpDownClick(Sender: TObject);
        Procedure BrowseClick(Sender: TObject);
        Procedure SubTabsChange(Sender: TObject);
        Procedure SubTabsChanging(Sender: TObject; NewIndex: Integer;
            Var AllowChange: Boolean);
        Procedure FormShow(Sender: TObject);
        Procedure btnIconLibClick(Sender: TObject);
        Procedure btnIconBrwseClick(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure btnRemoveIconClick(Sender: TObject);
        Procedure BrowseExecutableOutDirClick(Sender: TObject);
        Procedure BrowseObjDirClick(Sender: TObject);
        Procedure BrowseImageDirClick(Sender: TObject);
        Procedure btnMakeBrowseClick(Sender: TObject);
        Procedure btnMakClick(Sender: TObject);
        Procedure MakButtonClick(Sender: TObject);
        Procedure edMakeIncludeChange(Sender: TObject);
        Procedure MakeIncludesClick(Sender: TObject);
        Procedure btnHelpClick(Sender: TObject);
        Procedure chkOverrideOutputClick(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure chkCompileClick(Sender: TObject);
        Procedure chkVersionInfoClick(Sender: TObject);
        Procedure lvFilesChange(Sender: TObject; Node: TTreeNode);
        Procedure cmbCompilerChange(Sender: TObject);
        Procedure btnCancelClick(Sender: TObject);
        Procedure lstTypeClick(Sender: TObject);
        Procedure btnOkClick(Sender: TObject);
        Procedure AddLibBtnClick(Sender: TObject);
        Procedure txtOverrideBuildCmdChange(Sender: TObject);
        Procedure spnPriorityChange(Sender: TObject);
        Procedure btnCustomMakeBrowseClick(Sender: TObject);
        Procedure cbUseCustomMakefileClick(Sender: TObject);
        Procedure MakeIncludesDrawItem(Control: TWinControl; Index: Integer;
            Rect: TRect; State: TOwnerDrawState);
        Procedure grpPchClick(Sender: TObject);
        Procedure cmbProfileSetCompChange(Sender: TObject);
        Procedure btnAddProfileSetClick(Sender: TObject);
        Procedure btnDelProfileSetClick(Sender: TObject);
        Procedure btnRenameProfileSetClick(Sender: TObject);
        Procedure btnCopyProfileSetClick(Sender: TObject);
    Private
        fProfiles: TProjectProfileList;
        fIcon: String;
        fProject: TProject;
        fOriginalProfileIndex: Integer;
        fCurrentProfileIndex: Integer;
        dlgCustomMake: TOpenDialogEx;
	       OpenLibDialog: TOpenDialogEx;
	       dlgMakeInclude: TOpenDialogEx;
	       dlgOpen: TOpenDialogEx;
        Procedure UpdateUIWithCurrentProfile;
        Procedure UpdateCurrentProfileDataFromUI;
        Procedure UpdateProfileList(ProfileIndex: Integer);
        Procedure SetProfiles(Value: TProjectProfileList);
        Function GetProfiles: TProjectProfileList;
        Procedure UpdateButtons;
        Procedure UpdateMakButtons;
        Procedure LoadText;
        Procedure InitVersionInfo;
        Function DefaultBuildCommand(idx: Integer): String;
        Procedure SaveDirSettings;
        Function GetCurrentProfile: TProjProfile;
    Public
        Property Project: TProject Read fProject Write fProject;
        Property Profiles: TProjectProfileList Read GetProfiles Write SetProfiles;
        Property CurrentProfile: TProjProfile Read GetCurrentProfile;
        Property CurrentProfileIndex: Integer
            Read fCurrentProfileIndex Write fCurrentProfileIndex;
    Protected
        Procedure CreateParams(Var Params: TCreateParams); Override;
    End;

Implementation

Uses
{$IFDEF WIN32}
    FileCtrl, devcfg, IconFrm, utils, MultiLangSupport, version, hh;
{$ENDIF}
{$IFDEF LINUX}
  devcfg, IconFrm, utils, MultiLangSupport, version;
{$ENDIF}

{$R *.dfm}

Procedure TfrmProjectOptions.UpdateButtons;
Begin
    btnAdd.Enabled := edEntry.Text <> '';
    If lstList.ItemIndex >= 0 Then
    Begin
        btnDelete.Enabled := True;
        btnReplace.Enabled := btnAdd.Enabled;
        btnUp.Enabled := lstList.ItemIndex > 0;
        btnDown.Enabled := lstList.ItemIndex < (lstList.Items.Count - 1);
    End
    Else
    Begin
        btnDelete.Enabled := False;
        btnReplace.Enabled := False;
        btnUp.Enabled := False;
        btnDown.Enabled := False;
    End;
    btnDelInval.Enabled := lstList.Items.Count > 0;
End;

Procedure TfrmProjectOptions.UpdateMakButtons;
Begin
    btnMakAdd.Enabled := edMakeInclude.Text <> '';
    If MakeIncludes.ItemIndex >= 0 Then
    Begin
        btnMakDelete.Enabled := True;
        btnMakReplace.Enabled := btnMakAdd.Enabled;
        btnMakUp.Enabled := MakeIncludes.ItemIndex > 0;
        btnMakDown.Enabled := MakeIncludes.ItemIndex <
            (MakeIncludes.Items.Count - 1);
    End
    Else
    Begin
        btnMakDelete.Enabled := False;
        btnMakReplace.Enabled := False;
        btnMakUp.Enabled := False;
        btnMakDown.Enabled := False;
    End;
    btnMakDelInval.Enabled := MakeIncludes.Items.Count > 0;
End;

Procedure TfrmProjectOptions.BrowseClick(Sender: TObject);
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
    Case SubTabs.TabIndex Of
        0: // Lib tab
        Begin
            If SelectDirectory('Library Directory', '', newitem) Then
                edEntry.Text := NewItem;
        End;
        1: // Include tab
        Begin
            If SelectDirectory('Include Directory', '', newitem) Then
                edEntry.Text := NewItem;
        End;
        2: // Resource dir Tab
        Begin
            If SelectDirectory('Resource Directory', '', newitem) Then
                edEntry.Text := NewItem;
        End;
    End;
    edEntry.SetFocus;
End;

Procedure TfrmProjectOptions.ButtonClick(Sender: TObject);
Var
    idx: Integer;
Begin
    Case (Sender As TComponent).Tag Of
        1:
        Begin
            lstList.Items[lstList.ItemIndex] := TrimRight(edEntry.Text);
            Case SubTabs.TabIndex Of
                0:
                    CurrentProfile.Libs[lstList.ItemIndex] := TrimRight(edEntry.Text);
                1:
                    CurrentProfile.Includes[lstList.ItemIndex] := TrimRight(edEntry.Text);
                2:
                    CurrentProfile.ResourceIncludes[lstList.ItemIndex] := TrimRight(edEntry.Text);
            End;
        End;
        2:
        Begin
            lstList.Items.Add(TrimRight(edEntry.Text));
            Case SubTabs.TabIndex Of
                0:
                    CurrentProfile.Libs.Add(TrimRight(edEntry.Text));
                1:
                    CurrentProfile.Includes.Add(TrimRight(edEntry.Text));
                2:
                    CurrentProfile.ResourceIncludes.Add(TrimRight(edEntry.Text));
            End;
        End;
        3:
        Begin
            Case SubTabs.TabIndex Of
                0:
                    CurrentProfile.Libs.Delete(lstList.ItemIndex);
                1:
                    CurrentProfile.Includes.Delete(lstList.ItemIndex);
                2:
                    CurrentProfile.ResourceIncludes.Delete(lstList.ItemIndex);
            End;
            lstList.DeleteSelected;
        End;
        4:
        Begin
            If lstList.Items.Count > 0 Then
                For idx := pred(lstList.Items.Count) Downto 0 Do
                    Case SubTabs.TabIndex Of
                        0:
                            If Not DirectoryExists(lstList.Items[idx]) Then
                            Begin
                                CurrentProfile.Libs.Delete(idx);
                                lstList.Items.Delete(idx);
                            End;
                        1:
                            If Not DirectoryExists(lstList.Items[idx]) Then
                            Begin
                                CurrentProfile.Includes.Delete(idx);
                                lstList.Items.Delete(idx);
                            End;
                        2:
                            If Not DirectoryExists(lstList.Items[idx]) Then
                            Begin
                                CurrentProfile.ResourceIncludes.Delete(idx);
                                lstList.Items.Delete(idx);
                            End;
                    End;
        End;
    End;
    edEntry.Clear;
    UpdateButtons;
End;

Procedure TfrmProjectOptions.EditChange(SEnder: TObject);
Begin
    UpdateButtons;
End;

Procedure TfrmProjectOptions.ListClick(Sender: TObject);
Begin
    UpdateButtons;

    If lstList.Itemindex <> -1 Then
        edEntry.Text := lstList.Items[lstList.Itemindex];
End;

Procedure TfrmProjectOptions.UpDownClick(Sender: TObject);
Var
    idx: Integer;
Begin
    idx := lstList.ItemIndex;
    If Sender = btnUp Then
    Begin
        lstList.Items.Exchange(lstList.ItemIndex, lstList.ItemIndex - 1);
        lstList.ItemIndex := idx - 1;
    End
    Else
    If Sender = btnDown Then
    Begin
        lstList.Items.Exchange(lstList.ItemIndex, lstList.ItemIndex + 1);
        lstList.ItemIndex := idx + 1;
    End;
    UpdateButtons;
End;

Function TfrmProjectOptions.GetCurrentProfile: TProjProfile;
Begin
    If (fCurrentProfileIndex < 0) Or (fCurrentProfileIndex >
        fProfiles.Count - 1) Then
    Begin
        Result := Nil;
        exit;
    End;
    Result := fProfiles[fCurrentProfileIndex];
End;

Function TfrmProjectOptions.GetProfiles: TProjectProfileList;
Begin
    //UpdateCurrentProfileDataFromUI;
    result := fProfiles;
End;

Procedure TfrmProjectOptions.SetProfiles(Value: TProjectProfileList);
Begin
    fProfiles.CopyDataFrom(Value);
    //Load the profiles First
    cmbProfileSetComp.Clear;

    If fProfiles.Count = 0 Then
        exit;

    UpdateProfileList(-1);
    If Assigned(fProject) = False Then
    Begin
        ShowMessage('Project Not Intialised');
        exit;
    End;

    If (fProject.DefaultProfileIndex > fProfiles.count - 1) Or
        (fProject.DefaultProfileIndex < 0) Then
    Begin
        fProject.DefaultProfileIndex := 0;
    End;
    CurrentProfileIndex := fProject.CurrentProfileIndex;
    cmbProfileSetComp.ItemIndex := CurrentProfileIndex;
    cmbProfileSetCompChange(Nil);
End;

Procedure TfrmProjectOptions.UpdateProfileList(ProfileIndex: Integer);
Var
    i: Integer;
Begin
    cmbProfileSetComp.Clear;
    For i := 0 To fProfiles.count - 1 Do
    Begin
        If trim(fProfiles.Items[i].ProfileName) <> '' Then
            cmbProfileSetComp.Items.Add(fProfiles.Items[i].ProfileName)
        Else
            cmbProfileSetComp.Items.Add('Profile ' + IntToStr(i + 1));
    End;

    If (ProfileIndex <> -1) Then
    Begin
        fOriginalProfileIndex := ProfileIndex;
        cmbProfileSetComp.ItemIndex := ProfileIndex;
    End;
End;

Procedure TfrmProjectOptions.UpdateCurrentProfileDataFromUI;
Var
    I: Integer;
    strCppOption, strCOption, strLinkerOption, strPreprocDefines: String;
{$IFDEF PLUGIN_BUILD}
    j: Integer;
    pluginSettings: TSettings;
    tempName: String;
{$ENDIF PLUGIN_BUILD}
Begin

        pluginSettings := nil;
        
    If CurrentProfile = Nil Then
        exit;
    With CurrentProfile Do
    Begin
        Icon := fIcon;
    { I had to remove the delimiter text thing, since it causes the edit box to add
      unwanted quotes around the string. We could remove them but that could conflict with user's own quotes,
      for example when using filenames containing spaces }
    {
    *mandrav*:

     Colin, when I did it this way, I wanted to have one option per-line so that
     it is easy to see and spot errors etc.
     Of course, you 've found a bug but I don't think that this is a good solution...

     I will try something different now: I will create my own delimited string (delimited by "_@@_").
     Now it has nothing to do with quotes or spaces. If the user enters quotes, that's
     fine. If he doesn't but he should (like a filename with spaces), then it's
     his/her problem. Even if he did it at command line he still would have compile
     errors after all...
     All I have to do when I want the actual string back, is call StringReplace() et voila :)
    }

        strLinkerOption := edLinker.Lines.Text;
        strCOption := '';
        For I := 0 To edCompiler.Lines.Count - 1 Do
            strCOption := strCOption + edCompiler.Lines[I] + '_@@_';
        strCppOption := '';
        For I := 0 To edCppCompiler.Lines.Count - 1 Do
            strCppOption := strCppOption + edCppCompiler.Lines[I] + '_@@_';
        strLinkerOption := '';
        For I := 0 To edLinker.Lines.Count - 1 Do
            strLinkerOption := strLinkerOption + edLinker.Lines[I] + '_@@_';
        strPreprocDefines := '';
        For I := 0 To edDefines.Lines.Count - 1 Do
            strPreprocDefines := strPreprocDefines + edDefines.Lines[I] + '_@@_';

        CurrentProfile.CppCompiler := strCppOption;
        CurrentProfile.Compiler := strCOption;
        CurrentProfile.Linker := strLinkerOption;
        CurrentProfile.PreProcDefines := strPreprocDefines;
        CurrentProfile.CompilerOptions := devCompiler.OptionStr;
        CurrentProfile.CompilerType := devCompiler.CompilerType;

        typ := lstType.ItemIndex;

        ExeOutput := edExeOutput.Text;
        ObjectOutput := edObjOutput.Text;
        ImagesOutput := edImagesOutput.Text;
        OverrideOutput := chkOverrideOutput.Checked;
        OverridenOutput := edOverridenOutput.Text;
        If cbUseCustomMakefile.Checked And FileExists(edCustomMakefile.Text) Then
            CurrentProfile.UseCustomMakefile := True
        Else
            CurrentProfile.UseCustomMakefile := False;

        CurrentProfile.CustomMakefile := edCustomMakefile.Text;
        MakeIncludes.Clear;
        MakeIncludes.AddStrings(Self.MakeIncludes.Items);

        CurrentProfile.SupportXPThemes := chkSupportXP.Checked;
        CurrentProfile.CompilerSet := cmbCompiler.ItemIndex;

        CurrentProfile.IncludeVersionInfo := chkVersionInfo.Checked;

        Project.VersionInfo.Major := spnMajor.Value;
        Project.VersionInfo.Minor := spnMinor.Value;
        Project.VersionInfo.Release := spnRelease.Value;
        Project.VersionInfo.Build := spnBuild.Value;
        Project.VersionInfo.AutoIncBuildNrOnCompile :=
            radAutoIncBuildOnCompile.Checked;
        Project.VersionInfo.AutoIncBuildNrOnRebuild :=
            radAutoIncBuildOnRebuild.Checked;

        Project.VersionInfo.FileDescription := vleVersion.Cells[1, 0];
        Project.VersionInfo.FileVersion := vleVersion.Cells[1, 1];
        Project.VersionInfo.ProductName := vleVersion.Cells[1, 2];
        Project.VersionInfo.ProductVersion := vleVersion.Cells[1, 3];
        Project.VersionInfo.OriginalFilename := vleVersion.Cells[1, 4];
        Project.VersionInfo.InternalName := vleVersion.Cells[1, 5];
        Project.VersionInfo.CompanyName := vleVersion.Cells[1, 6];
        Project.VersionInfo.LegalCopyright := vleVersion.Cells[1, 7];
        Project.VersionInfo.LegalTrademarks := vleVersion.Cells[1, 8];

        If cmbLangID.ItemIndex > -1 Then
        Begin
            For I := 0 To Languages.Count - 1 Do
            Begin
                If SameText(Languages.Name[I], cmbLangID.Text) Then
                Begin
                    Project.VersionInfo.LanguageID := Languages.LocaleID[I];
                    Project.VersionInfo.CharsetID := $04E4;
                    Break;
                End;
            End;
            If SameText('Language Neutral', cmbLangID.Text) Then
                // EAB Attempt to add Language Neutral option. Requires feedback.
            Begin
                Project.VersionInfo.LanguageID := 0;
                Project.VersionInfo.CharsetID := 1200;
            End;
        End;
    End;

    {$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin

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

    {$ENDIF PLUGIN_BUILD}

End;

Procedure TfrmProjectOptions.UpdateUIWithCurrentProfile;
Var
    idx, cntSrc, cntHdr, cntRes: Integer;
Begin
    fIcon := GetRealPath(CurrentProfile.Icon, fProject.Directory);
    If (fIcon <> '') And (FileExists(fIcon)) Then
        Try
            Icon.Picture.LoadFromFile(fIcon);
        Except
            fIcon := '';
        End;

    // General Tab
    lstType.ItemIndex := CurrentProfile.typ;

    edCompiler.Lines.Text := StringReplace(CurrentProfile.Compiler,
        '_@@_', #13#10, [rfReplaceAll]);
    edCppCompiler.Lines.Text :=
        StringReplace(CurrentProfile.CPPCompiler, '_@@_', #13#10, [rfReplaceAll]);
    edLinker.Lines.Text := StringReplace(CurrentProfile.Linker,
        '_@@_', #13#10, [rfReplaceAll]);
    edDefines.Lines.Text := StringReplace(CurrentProfile.PreprocDefines,
        '_@@_', #13#10, [rfReplaceAll]);

    edProjectName.Text := fProject.Name;
    lblPrjFname.Caption := fProject.FileName;
    lblPrjOutputFname.Caption := fProject.Executable;
    cntSrc := 0;
    cntHdr := 0;
    cntRes := 0;
    For idx := 0 To fProject.Units.Count - 1 Do
        Case GetFileTyp(fProject.Units[idx].FileName) Of
            utSrc:
                Inc(cntSrc);
            utHead:
                Inc(cntHdr);
            utRes:
                Inc(cntRes);
        End;
    lblPrjUnits.Caption := Format(Lang[ID_POPT_UNITSFORMAT],
        [fProject.Units.Count, cntSrc, cntHdr, cntRes]);
    chkSupportXP.Checked := CurrentProfile.SupportXPThemes;

    // Files tab
    If CurrentProfile.CompilerSet < devCompilerSet.Sets.Count Then
    Begin
        cmbCompiler.Items.Assign(devCompilerSet.Sets);
        cmbCompiler.ItemIndex := CurrentProfile.CompilerSet;
        cmbCompiler.OnChange(cmbCompiler);
    End
    Else
    Begin
        Application.MessageBox(
            'The compiler specified in the project file does not exist on the local computer.'#10#13#10#13 +
            'Please select a compiler, the default one selected may not be what you want.',
            'wxDev-C++',
            MB_OK Or MB_ICONEXCLAMATION);
        PageControl.ActivePage := tabCompiler;
    End;

    // Output tab
    edExeOutput.Text := CurrentProfile.ExeOutput;
    edObjOutput.Text := CurrentProfile.ObjectOutput;
    edImagesOutput.Text := CurrentProfile.ImagesOutput;
    chkOverrideOutput.Checked := CurrentProfile.OverrideOutput;
    If CurrentProfile.OverridenOutput <> '' Then
        edOverridenOutput.Text := ExtractFilename(CurrentProfile.OverridenOutput)
    Else
        edOverridenOutput.Text := ExtractFilename(fProject.Executable);
    edOverridenOutput.Enabled := CurrentProfile.OverrideOutput;

    // Makefile tab
    cbUseCustomMakefile.Checked := CurrentProfile.UseCustomMakefile;
    edCustomMakefile.Text := CurrentProfile.CustomMakefile;
    cbUseCustomMakefileClick(Nil);
    MakeIncludes.Clear;
    MakeIncludes.Items.AddStrings(CurrentProfile.MakeIncludes);

    // Version tab
    InitVersionInfo;

End;

Procedure TfrmProjectOptions.SaveDirSettings;
Var
    sl: TStrings;
Begin
    sl := Nil;
    Case SubTabs.TabIndex Of
        0:
            sl := CurrentProfile.Libs;
        1:
            sl := CurrentProfile.Includes;
        2:
            sl := CurrentProfile.ResourceIncludes;
    End;
    If assigned(sl) Then
    Begin
        sl.Clear;
        sl.AddStrings(lstList.Items);
    End;
End;

Procedure TfrmProjectOptions.SubTabsChanging(Sender: TObject;
    NewIndex: Integer; Var AllowChange: Boolean);
Begin
    SaveDirSettings;
End;

Procedure TfrmProjectOptions.SubTabsChange(Sender: TObject);
Begin
    If fProfiles = Nil Then
        exit;
    Case SubTabs.TabIndex Of
        0:
            lstList.Items := CurrentProfile.Libs;
        1:
            lstList.Items := CurrentProfile.Includes;
        2:
            lstList.Items := CurrentProfile.ResourceIncludes;
    End;
    UpdateButtons;
End;

Procedure TfrmProjectOptions.FormShow(Sender: TObject);
Begin
    PageControl.ActivePageIndex := 0;
    SubTabs.TabIndex := 0;
    lvFiles.Images := MainForm.ProjectView.Images;
    lvFiles.Items.Assign(MainForm.ProjectView.Items);
    lvFiles.Items[0].Expand(False);
    chkCompile.Enabled := False;
    chkLink.Enabled := False;
    lblPriority.Enabled := False;
    spnPriority.Enabled := False;
    chkCompileCpp.Enabled := False;
    chkOverrideBuildCmd.Enabled := False;
    txtOverrideBuildCmd.Enabled := False;
    txtOverrideBuildCmd.Text := '';
    chkSupportXP.Enabled := CurrentProfile.typ = dptGUI;
    devCompilerSet.LoadSet(cmbCompiler.ItemIndex);
    CompOptionsFrame1.FillOptions(fProject);
    devCompiler.OptionStr := CurrentProfile.CompilerOptions;
    SubTabsChange(Self);
    UpdateMakButtons();
    CompOptionsFrame1.FillOptions(fProject);

    //PCH radiobox
    grpPch.Enabled := False;
    grpPch.OnClick := Nil;
    If (fProject.PchHead = -1) And (fProject.PchSource = -1) Then
        grpPch.ItemIndex := 0
    Else
        grpPch.ItemIndex := 2;
    grpPch.OnClick := grpPchClick;
End;

Procedure TfrmProjectOptions.btnIconLibClick(Sender: TObject);
Begin
    With TIconForm.Create(Self) Do
        Try
            If ShowModal = mrOk Then
                If Selected <> '' Then
                    fIcon := Selected;
        Finally
            Free;
        End;
    If fIcon <> '' Then
    Begin
        Icon.Picture.LoadFromFile(fIcon);
        btnRemoveIcon.Enabled := Length(fIcon) > 0;
    End;
End;

Procedure TfrmProjectOptions.btnIconBrwseClick(Sender: TObject);
Begin
    If dlgPic.Execute Then
    Begin
        If FileExists(dlgPic.FileName) Then
        Begin
            fIcon := dlgPic.FileName;
            Icon.Picture.LoadFromFile(fIcon);
            btnRemoveIcon.Enabled := Length(fIcon) > 0;
        End
        Else
            MessageDlg(format(Lang[ID_MSG_COULDNOTOPENFILE], [dlgPic.FileName]),
                mtError, [mbOK], 0);
    End;
End;

Procedure TfrmProjectOptions.FormCreate(Sender: TObject);
Begin
    dlgCustomMake := TOpenDialogEx.Create(MainForm);
    OpenLibDialog := TOpenDialogEx.Create(MainForm);
    dlgMakeInclude := TOpenDialogEx.Create(MainForm);
    dlgOpen := TOpenDialogEx.Create(MainForm);

    dlgCustomMake.Filter := 'All Files (*.*)|*.*';
    dlgCustomMake.FilterIndex := 0;

    OpenLibDialog.Filter :=
        'Library (*.a;*.lib)|*.a;*.lib|Object (*.o;*.obj)|*.o;*.obj|All f' +
        'iles (*.*)|*.*';
    OpenLibDialog.Options := [ofHideReadOnly, ofAllowMultiSelect,
        ofEnableSizing];

    dlgMakeInclude.Filter := 'Makefile Addons (*.mak)|*.mak|All Files (*.*)|*.*';

    dlgOpen.Filter :=
        'Object files (*.o;*.obj)|*.o;*.obj|Lib files (*.a;*.lib)|*.a;*.l' +
        'ib|Resource file (.rc)|*.rc|All files (*.*)|*.*';
    dlgOpen.Options := [ofHideReadOnly, ofAllowMultiSelect];
    dlgOpen.Title := 'Open object file';


    LoadText;
    lblCompileInfo.Font.Color := clMaroon;
    cmbLangID.Sorted := True;
    fProfiles := TProjectProfileList.Create;
    fCurrentProfileIndex := 0;
End;

Procedure TfrmProjectOptions.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_POPT];

    //tabs
    tabGeneral.Caption := Lang[ID_POPT_GENTAB];
    tabFilesDir.Caption := Lang[ID_POPT_DIRTAB];
    tabCompiler.Caption := Lang[ID_SHEET_COMP];
    tabOutputDir.Caption := Lang[ID_POPT_OUTTAB];
    tabMakefile.Caption := Lang[ID_POPT_MAKTAB];

    //controls (general tab)
    lblPrjName.Caption := Lang[ID_POPT_PRJNAME];
    lblFname.Caption := Lang[ID_PROPS_FILENAME] + ':';
    lblPrjOutput.Caption := Lang[ID_POPT_OUTPUTFILENAME] + ':';
    lblUnits.Caption := Lang[ID_POPT_FILESTAB] + ':';
    grpIcon.Caption := Lang[ID_POPT_GRP_ICON];
    btnIconLib.Caption := Lang[ID_POPT_ICOLIB];
    grpType.Caption := Lang[ID_POPT_GRP_TYPE];
    lstType.Clear;
    lstType.Items.Append(Lang[ID_POPT_TYPE1]);
    lstType.Items.Append(Lang[ID_POPT_TYPE2]);
    lstType.Items.Append(Lang[ID_POPT_TYPE3]);
    lstType.Items.Append(Lang[ID_POPT_TYPE4]);
    chkSupportXP.Caption := Lang[ID_POPT_SUPPORTXP];

    // compiler tab
    tabCompOpts.Caption := Lang[ID_PARAM_CAPTION];
    PageControl.Pages[3].Caption := Lang[ID_POPT_ADDITIONAL];
    lblCompiler.Caption := Lang[ID_POPT_COMP];
    lblDefines.Caption := Lang[ID_POPT_DEFINES];
    lblCppCompiler.Caption := Lang[ID_COPT_GRP_CPP];
    lblLinker.Caption := Lang[ID_COPT_LINKERTAB];
    AddLibBtn.Caption := Lang[ID_POPT_ADDLIBRARY];

    //dir tab
    SubTabs.Tabs.Clear;
    SubTabs.Tabs.Append(Lang[ID_POPT_LIBDIRS]);
    SubTabs.Tabs.Append(Lang[ID_POPT_INCDIRS]);
    SubTabs.Tabs.Append(Lang[ID_POPT_RESDIRS]);

    //output tab
    grpOutDirectories.Caption := Lang[ID_POPT_OUTDIRGRP];
    lblExeOutput.Caption := Lang[ID_POPT_EXEOUT];
    lblObjOutput.Caption := Lang[ID_POPT_OBJOUT];
    chkOverrideOutput.Caption := Lang[ID_POPT_OVERRIDEOUT];

    //dialogs
    dlgPic.Title := Lang[ID_POPT_OPENICO];
    dlgOpen.Title := Lang[ID_POPT_OPENOBJ];

    //buttons
    btnReplace.Caption := Lang[ID_BTN_REPLACE];
    btnAdd.Caption := Lang[ID_BTN_ADD];
    btnDelete.Caption := Lang[ID_BTN_DELETE];
    btnDelInval.Caption := Lang[ID_BTN_DELINVAL];
    btnOk.Caption := Lang[ID_BTN_OK];
    btnCancel.Caption := Lang[ID_BTN_CANCEL];
    btnHelp.Caption := Lang[ID_BTN_HELP];
    btnIconBrwse.Caption := Lang[ID_BTN_BROWSE];
    btnRemoveIcon.Caption := Lang[ID_BTN_REMOVEICON];

    cbUseCustomMakefile.Caption := Lang[ID_POPT_USECUSTOMMAKEFILE];
    grpIncMake.Caption := Lang[ID_POPT_INCFILEMAKEFILE];

    btnMakReplace.Caption := Lang[ID_BTN_REPLACE];
    btnMakAdd.Caption := Lang[ID_BTN_ADD];
    btnMakDelete.Caption := Lang[ID_BTN_DELETE];
    btnMakDelInval.Caption := Lang[ID_BTN_DELINVAL];
    lblMakefileCustomize.Caption :=
        'The makefile has two main targets, ''all''' +
        ' and ''clean''.'#13#10#13#10 +
        '''all'' depends on all-before and all-after. '
        +
        'all-before and all-after gets called ' +
        'before and after the compilation ' +
        'process respectively.'#13#10#13#10 +
        '''clean'' depends on the target clean-custom'
        +
        ', which gets called before the ' +
        'cleaning process.'#13#10#13#10 +
        'Alter the Makefile''s behavior by defining '
        +
        'the targets mentioned.';

    // files tab
    tabFiles.Caption := Lang[ID_POPT_FILESTAB];
    lblCompilerSet.Caption := Lang[ID_POPT_COMP];
    lblCompileInfo.Caption := Lang[ID_POPT_COMPINFO];
    grpUnitOptions.Caption := Lang[ID_POPT_UNITOPTS];
    lblPriority.Caption := Lang[ID_POPT_BUILDPRIORITY];
    chkCompile.Caption := Lang[ID_POPT_COMPUNIT];
    chkCompileCpp.Caption := Lang[ID_POPT_UNITUSEGPP];
    chkOverrideBuildCmd.Caption := Lang[ID_POPT_OVERRIDEBUILDCMD];
    chkLink.Caption := Lang[ID_POPT_LINKUNIT];
    grpPch.Caption := Lang[ID_POPT_PCH];
    grpPch.Items[0] := Lang[ID_POPT_NOPCH];
    grpPch.Items[1] := Lang[ID_POPT_CREATEPCH];
    grpPch.Items[2] := Lang[ID_POPT_USEPCH];

    // version info tab
    tabVersion.Caption := Lang[ID_POPT_VERTAB];
    chkVersionInfo.Caption := Lang[ID_POPT_INCLUDEVERSION];
    grpVersion.Caption := Lang[ID_POPT_VDETAILS];
    lblVerMajor.Caption := Lang[ID_POPT_VMAJOR];
    lblVerMinor.Caption := Lang[ID_POPT_VMINOR];
    lblVerRel.Caption := Lang[ID_POPT_VRELEASE];
    lblVerBuild.Caption := Lang[ID_POPT_VBUILD];
    lblLanguage.Caption := Lang[ID_POPT_VLANG];
    grpAdditional.Caption := Lang[ID_POPT_VADDITIONAL];
    grpAutoInc.Caption := Lang[ID_POPT_AUTOINCGRP];
    radAutoIncBuildOnCompile.Caption := Lang[ID_POPT_VAUTOINCBUILDNR_COMPILE];
    radAutoIncBuildOnRebuild.Caption := Lang[ID_POPT_VAUTOINCBUILDNR_REBUILD];
    radNoAutoIncBuild.Caption := Lang[ID_POPT_VAUTOINCBUILDNR_NONE];
End;

Procedure TfrmProjectOptions.btnRemoveIconClick(Sender: TObject);
Begin
    btnRemoveIcon.Enabled := False;
    fIcon := '';
    Icon.Picture.Graphic := Nil;
End;

Procedure TfrmProjectOptions.BrowseExecutableOutDirClick(Sender: TObject);
Var
{$IFDEF WIN32}
    Dir: String;
{$ENDIF}
{$IFDEF LINUX}
  Dir: WideString;
{$ENDIF}
    TempDir: String;
Begin
    If fProject.CurrentProfile.ExeOutput <> '' Then
        Dir := ExpandFileto(fProject.CurrentProfile.ExeOutput, fProject.Directory)
    Else
        Dir := fProject.Directory;
    If Not SelectDirectory('Select Directory', '', Dir) Then
	       Exit;

    //TODO: lowjoel: What do we actually want to achieve here?
    TempDir := ExtractRelativePath(fProject.Directory, Dir);
    If DirectoryExists(TempDir) Then
        TempDir := GetShortName(TempDir)
    Else
        TempDir := TempDir;
    edExeOutput.Text := TempDir;
End;

Procedure TfrmProjectOptions.BrowseObjDirClick(Sender: TObject);
Var
{$IFDEF WIN32}
    Dir: String;
{$ENDIF}
{$IFDEF LINUX}
  Dir: WideString;
{$ENDIF}
    TempDir: String;
Begin
    If fProject.CurrentProfile.ObjectOutput <> '' Then
        Dir := ExpandFileto(fProject.CurrentProfile.ObjectOutput, fProject.Directory)
    Else
        Dir := fProject.Directory;
    If SelectDirectory('Select Directory', '', Dir) = False Then
        exit;
    TempDir := ExtractRelativePath(fProject.Directory, Dir);
    If DirectoryExists(TempDir) Then
        TempDir := GetShortName(TempDir)
    Else
        TempDir := TempDir;
    edObjOutput.Text := TempDir;
End;

Procedure TfrmProjectOptions.BrowseImageDirClick(Sender: TObject);
Var
{$IFDEF WIN32}
    Dir: String;
{$ENDIF}
{$IFDEF LINUX}
  Dir: WideString;
{$ENDIF}
    TempDir: String;
Begin
    If fProject.CurrentProfile.ImagesOutput <> '' Then
        Dir := ExpandFileto(fProject.CurrentProfile.ImagesOutput, fProject.Directory)
    Else
        Dir := fProject.Directory;
    If SelectDirectory('Select Directory', '', Dir) = False Then
        exit;
    TempDir := ExtractRelativePath(fProject.Directory, Dir);
    If DirectoryExists(TempDir) Then
        TempDir := GetShortName(TempDir)
    Else
        TempDir := TempDir;
    edImagesOutput.Text := TempDir;
End;

Procedure TfrmProjectOptions.btnMakeBrowseClick(Sender: TObject);
Begin
    If dlgMakeInclude.Execute Then
        edMakeInclude.Text := ExtractRelativePath(fProject.FileName,
            dlgMakeInclude.FileName);
    edMakeInclude.SetFocus;
End;

Procedure TfrmProjectOptions.btnMakClick(Sender: TObject);
Var
    i: Integer;
Begin
    i := MakeIncludes.ItemIndex;
    If i < 0 Then
        exit;
    If Sender = btnMakUp Then
    Begin
        MakeIncludes.Items.Exchange(MakeIncludes.ItemIndex,
            MakeIncludes.ItemIndex - 1);
        MakeIncludes.ItemIndex := i - 1;
    End
    Else
    If Sender = btnMakDown Then
    Begin
        MakeIncludes.Items.Exchange(MakeIncludes.ItemIndex,
            MakeIncludes.ItemIndex + 1);
        MakeIncludes.ItemIndex := i + 1;
    End;

    UpdateMakButtons;
End;

Procedure TfrmProjectOptions.MakButtonClick(Sender: TObject);
Var
    i: Integer;
Begin
    Case (Sender As TComponent).Tag Of
        1:
        Begin
            MakeIncludes.Items[MakeIncludes.ItemIndex] := (edMakeInclude.Text);
        End;
        2:
        Begin
            MakeIncludes.Items.Add(edMakeInclude.Text);
        End;
        3:
        Begin
            MakeIncludes.DeleteSelected;
        End;
        4:
        Begin
            i := 0;
            While i < MakeIncludes.Items.Count Do
            Begin
                If Not FileExists(MakeIncludes.Items[i]) Then
                Begin
                    MakeIncludes.Items.Delete(i);
                    i := -1;
                End;
                i := i + 1;
            End;
        End;
    End;
    edMakeInclude.Clear;
    UpdateMakButtons;
End;

Procedure TfrmProjectOptions.edMakeIncludeChange(Sender: TObject);
Begin
    UpdateMakButtons;
End;

Procedure TfrmProjectOptions.MakeIncludesClick(Sender: TObject);
Begin
    UpdateMakButtons;

    If MakeIncludes.Itemindex <> -1 Then
        edMakeInclude.Text := MakeIncludes.Items[MakeIncludes.Itemindex];
End;

Procedure TfrmProjectOptions.btnHelpClick(Sender: TObject);
Begin
    Application.HelpFile := IncludeTrailingPathDelimiter(devDirs.Help) +
        DEV_MAINHELP_FILE;
    HtmlHelp(self.handle, Pchar(Application.HelpFile), HH_DISPLAY_TOPIC,
        DWORD(Pchar('html\managing_project_options.html')));
    //Application.HelpJump('ID_MANAGEPROJECT');
End;

Procedure TfrmProjectOptions.chkOverrideOutputClick(Sender: TObject);
Begin
    edOverridenOutput.Enabled := chkOverrideOutput.Checked;
End;

Procedure TfrmProjectOptions.FormCloseQuery(Sender: TObject;
    Var CanClose: Boolean);
Begin
    // check for disallowed characters in filename
    If (Pos('/', edOverridenOutput.Text) > 0) Or
        (Pos('\', edOverridenOutput.Text) > 0) Or
        (Pos(':', edOverridenOutput.Text) > 0) Or
        (Pos('*', edOverridenOutput.Text) > 0) Or
        (Pos('?', edOverridenOutput.Text) > 0) Or
        (Pos('"', edOverridenOutput.Text) > 0) Or
        (Pos('<', edOverridenOutput.Text) > 0) Or
        (Pos('>', edOverridenOutput.Text) > 0) Or
        (Pos('|', edOverridenOutput.Text) > 0) Then
    Begin
        MessageDlg('The output filename you have defined, contains at least one ' +
            'of the following illegal characters:'#10#10 +
            '\ / : * ? " > < |'#10#10 +
            'Please correct this...', mtError, [mbOk], 0);
        CanClose := False;
    End;
    If CanClose Then
    Begin
        devCompiler.CompilerSet := CurrentProfile.CompilerSet;
        devCompilerSet.LoadSet(devCompiler.CompilerSet);
        devCompilerSet.AssignToCompiler;
    End;
End;

Procedure TfrmProjectOptions.lvFilesChange(Sender: TObject;
    Node: TTreeNode);
Var
    idx: Integer;
Begin
    If Not Assigned(Node) Then
    Begin
        chkCompile.Enabled := False;
        chkCompileCpp.Enabled := False;
        chkLink.Enabled := False;
        chkOverrideBuildCmd.Enabled := False;
        txtOverrideBuildCmd.Enabled := False;
        lblPriority.Enabled := False;
        spnPriority.Enabled := False;
        Exit;
    End;

    // disable events
    chkCompile.OnClick := Nil;
    chkCompileCpp.OnClick := Nil;
    chkLink.OnClick := Nil;
    chkOverrideBuildCmd.OnClick := Nil;
    txtOverrideBuildCmd.OnChange := Nil;
    spnPriority.OnChange := Nil;
    grpPch.OnClick := Nil;

    idx := Integer(Node.Data);
    If (Node.Level > 0) And (idx <> -1) Then
    Begin // unit
        If fProject.Units[idx].OverrideBuildCmd Then
            txtOverrideBuildCmd.Text :=
                StringReplace(fProject.Units[idx].BuildCmd, '<CRTAB>', #13#10, [rfReplaceAll])
        Else
            txtOverrideBuildCmd.Text := DefaultBuildCommand(idx);
        chkOverrideBuildCmd.Checked := fProject.Units[idx].OverrideBuildCmd;

        chkCompile.Enabled := GetFileTyp(fProject.Units[idx].FileName) <> utHead;
        chkCompile.Checked := fProject.Units[idx].Compile;
        chkCompileCpp.Enabled := chkCompile.Checked And
            (GetFileTyp(fProject.Units[idx].FileName) In [utSrc]);
        chkCompileCpp.Checked := fProject.Units[idx].CompileCpp;
        chkLink.Enabled := chkCompile.Enabled And
            (GetFileTyp(fProject.Units[idx].FileName) <> utRes);
        chkLink.Checked := fProject.Units[idx].Link;
        lblPriority.Enabled := chkCompile.Checked And chkCompile.Enabled;
        spnPriority.Enabled := chkCompile.Checked And chkCompile.Enabled;
        spnPriority.Value := fProject.Units[idx].Priority;
        chkOverrideBuildCmd.Enabled := chkCompile.Checked And
            (lvFiles.SelectionCount = 1) And Not
            (GetFileTyp(fProject.Units[idx].FileName) In [utHead, utRes]);
        txtOverrideBuildCmd.Enabled := chkOverrideBuildCmd.Enabled And
            chkOverrideBuildCmd.Checked;

        //Handle the PCH
        grpPch.Enabled := GetFileTyp(fProject.Units[idx].FileName) In
            [utSrc, utHead];
        If (fProject.PchHead = -1) And (fProject.PchSource = -1) Then
            grpPch.ItemIndex := 0
        Else
        If (fProject.PchHead = idx) Or (fProject.PchSource = idx) Then
            grpPch.ItemIndex := 1
        Else
            grpPch.ItemIndex := 2;
    End
    Else
    Begin
        grpPch.Enabled := False;
        chkCompile.Enabled := False;
        chkCompileCpp.Enabled := False;
        chkLink.Enabled := False;
        chkOverrideBuildCmd.Enabled := False;
        txtOverrideBuildCmd.Enabled := False;
        lblPriority.Enabled := False;
        spnPriority.Enabled := False;
    End;

    // enable events
    chkCompile.OnClick := chkCompileClick;
    chkCompileCpp.OnClick := chkCompileClick;
    chkLink.OnClick := chkCompileClick;
    chkOverrideBuildCmd.OnClick := chkCompileClick;
    txtOverrideBuildCmd.OnChange := txtOverrideBuildCmdChange;
    spnPriority.OnChange := spnPriorityChange;
    grpPch.OnClick := grpPchClick;
End;

Procedure TfrmProjectOptions.chkCompileClick(Sender: TObject);
    Procedure DoNode(Node: TTreeNode);
    Var
        I: Integer;
        idx: Integer;
    Begin
        For I := 0 To Node.Count - 1 Do
        Begin
            idx := Integer(Node[I].Data);
            If idx <> -1 Then
            Begin // unit
                fProject.Units[idx].Compile := chkCompile.Checked;
                fProject.Units[idx].CompileCpp := chkCompileCpp.Checked;
            End
            Else
            If Node[I].HasChildren Then
                DoNode(Node[I]);
        End;
    End;
Var
    I: Integer;
    idx: Integer;
Begin
    For I := 0 To lvFiles.SelectionCount - 1 Do
    Begin
        idx := Integer(lvFiles.Selections[I].Data);
        If idx <> -1 Then
        Begin // unit
            fProject.Units[idx].Compile := chkCompile.Checked;
            fProject.Units[idx].CompileCpp := chkCompileCpp.Checked;
            fProject.Units[idx].Link := chkLink.Checked;
            If lvFiles.SelectionCount = 1 Then
            Begin
                fProject.Units[idx].OverrideBuildCmd := chkOverrideBuildCmd.Checked;

                txtOverrideBuildCmd.OnChange := Nil;
                txtOverrideBuildCmd.Text :=
                    StringReplace(txtOverrideBuildCmd.Text, '<CRTAB>', #13#10, [rfReplaceAll]);

                lblPriority.Enabled := chkCompile.Checked;
                spnPriority.Enabled := chkCompile.Checked;
                chkOverrideBuildCmd.Enabled := chkCompile.Checked And
                    (GetFileTyp(fProject.Units[idx].FileName) <> utRes);
                If chkCompile.Checked And
                    (GetFileTyp(fProject.Units[idx].FileName) = utOther) Then
                Begin
                    // non-standard source files, *must* override the build command
                    chkCompileCpp.Enabled := False;
                    txtOverrideBuildCmd.Enabled := True;
                    chkOverrideBuildCmd.Checked := True;
                    If txtOverrideBuildCmd.Text = '' Then
                        txtOverrideBuildCmd.Text := '<override this command>';
                End
                Else
                Begin
                    chkCompileCpp.Enabled := chkCompile.Checked And
                        (GetFileTyp(fProject.Units[idx].FileName) <> utRes);
                    If chkCompileCpp.Checked Then
                    Begin
                        txtOverrideBuildCmd.Text :=
                            StringReplace(txtOverrideBuildCmd.Text, '$(CC)', '$(CPP)', [rfReplaceAll]);
                        txtOverrideBuildCmd.Text :=
                            StringReplace(txtOverrideBuildCmd.Text, '$(CFLAGS)', '$(CXXFLAGS)',
                            [rfReplaceAll]);
                    End
                    Else
                    Begin
                        txtOverrideBuildCmd.Text :=
                            StringReplace(txtOverrideBuildCmd.Text, '$(CPP)', '$(CC)', [rfReplaceAll]);
                        txtOverrideBuildCmd.Text :=
                            StringReplace(txtOverrideBuildCmd.Text, '$(CXXFLAGS)', '$(CFLAGS)',
                            [rfReplaceAll]);
                    End;
                    txtOverrideBuildCmd.Enabled :=
                        chkOverrideBuildCmd.Enabled And chkOverrideBuildCmd.Checked;
                End;
                fProject.Units[idx].BuildCmd := txtOverrideBuildCmd.Text;
                txtOverrideBuildCmd.OnChange := txtOverrideBuildCmdChange;
            End;
        End
        Else
        If lvFiles.Selections[I].HasChildren Then
            DoNode(lvFiles.Selections[I]);
    End;
End;

Procedure TfrmProjectOptions.InitVersionInfo;
Var
    I: Integer;
    S: String;
Begin
    chkVersionInfo.Checked := CurrentProfile.IncludeVersionInfo;
    chkVersionInfoClick(Nil);

    spnMajor.Value := Project.VersionInfo.Major;
    spnMinor.Value := Project.VersionInfo.Minor;
    spnRelease.Value := Project.VersionInfo.Release;
    spnBuild.Value := Project.VersionInfo.Build;
    radAutoIncBuildOnCompile.Checked :=
        Project.VersionInfo.AutoIncBuildNrOnCompile;
    radAutoIncBuildOnRebuild.Checked :=
        Project.VersionInfo.AutoIncBuildNrOnRebuild;

    vleVersion.Strings.Clear;
    vleVersion.InsertRow('File Description',
        Project.VersionInfo.FileDescription, True);
    vleVersion.InsertRow('File Version', Project.VersionInfo.FileVersion,
        True);
    vleVersion.InsertRow('Product Name', Project.VersionInfo.ProductName,
        True);
    vleVersion.InsertRow('Product Version',
        Project.VersionInfo.ProductVersion, True);
    vleVersion.InsertRow('Original Filename',
        Project.VersionInfo.OriginalFilename, True);
    vleVersion.InsertRow('Internal Name', Project.VersionInfo.InternalName,
        True);
    vleVersion.InsertRow('Company Name', Project.VersionInfo.CompanyName,
        True);
    vleVersion.InsertRow('Legal Copyright',
        Project.VersionInfo.LegalCopyright, True);
    vleVersion.InsertRow('Legal Trademarks',
        Project.VersionInfo.LegalTrademarks, True);

    cmbLangID.Items.Clear;
    cmbLangID.Items.Add('Language Neutral');
    For I := 0 To Languages.Count - 1 Do
        cmbLangID.Items.Add(Languages.Name[I]);

    S := Languages.NameFromLocaleID[Project.VersionInfo.LanguageID];
    If Project.VersionInfo.LanguageID = 0 Then
        cmbLangID.ItemIndex := cmbLangID.Items.IndexOf('Language Neutral')
    Else
    If S <> '' Then
        cmbLangID.ItemIndex := cmbLangID.Items.IndexOf(S);

End;

Procedure TfrmProjectOptions.chkVersionInfoClick(Sender: TObject);
Begin
    spnMajor.Enabled := chkVersionInfo.Checked;
    spnMinor.Enabled := chkVersionInfo.Checked;
    spnRelease.Enabled := chkVersionInfo.Checked;
    spnBuild.Enabled := chkVersionInfo.Checked;
    cmbLangID.Enabled := chkVersionInfo.Checked;
    vleVersion.Enabled := chkVersionInfo.Checked;
    radNoAutoIncBuild.Enabled := chkVersionInfo.Checked;
    radAutoIncBuildOnCompile.Enabled := chkVersionInfo.Checked;
    radAutoIncBuildOnRebuild.Enabled := chkVersionInfo.Checked;
End;

Procedure TfrmProjectOptions.cmbCompilerChange(Sender: TObject);
Var currOpts: String;
Begin
    currOpts := CurrentProfile.CompilerOptions;
    If (devCompilerSet.Sets.Count > cmbCompiler.ItemIndex) And
        (cmbCompiler.ItemIndex <> -1) Then
    Begin
        devCompiler.CompilerSet := cmbCompiler.ItemIndex;
        devCompilerSet.LoadSet(cmbCompiler.ItemIndex);
        devCompilerSet.AssignToCompiler;
    End;

    devCompiler.OptionStr := currOpts;
    CompOptionsFrame1.FillOptions(fProject);
End;

Procedure TfrmProjectOptions.btnCancelClick(Sender: TObject);
Begin
    cmbProfileSetComp.ItemIndex := fOriginalProfileIndex;
    cmbProfileSetComp.OnChange(Sender);
    // EAB Comment: Why call this here? AFAIK, nothing bad happens, but seems counter intuitive
End;

Procedure TfrmProjectOptions.lstTypeClick(Sender: TObject);
Begin
    chkSupportXP.Enabled := lstType.ItemIndex = 0;
End;

Procedure TfrmProjectOptions.btnOkClick(Sender: TObject);
Begin
    Screen.Cursor := crHourGlass;
    btnOk.Enabled := False;

    SaveDirSettings;
    UpdateCurrentProfileDataFromUI;

    Screen.Cursor := crDefault;
    btnOk.Enabled := True;

End;

Procedure TfrmProjectOptions.AddLibBtnClick(Sender: TObject);
Var
    s: String;
    i: Integer;
Begin
    If OpenLibDialog.Execute Then
    Begin
        For i := 0 To OpenLibDialog.Files.Count - 1 Do
        Begin
            S := ExtractRelativePath(fProject.Directory, OpenLibDialog.Files[i]);
            S := GenMakePath(S);
            edLinker.Lines.Add(S);
        End;
    End;
End;

Function TfrmProjectOptions.DefaultBuildCommand(idx: Integer): String;
Var
    tfile, ofile: String;
Begin
    Result := '';
    If GetFileTyp(fProject.Units[idx].FileName) <> utSrc Then
        Exit;

    tfile := ExtractFileName(fProject.Units[idx].FileName);
    If fProject.Profiles[CurrentProfileIndex].ObjectOutput <> '' Then
    Begin
        ofile := IncludeTrailingPathDelimiter(
            fProject.Profiles[CurrentProfileIndex].ObjectOutput) + ExtractFileName(tfile);
        ofile := GenMakePath(ExtractRelativePath(fProject.FileName,
            ChangeFileExt(ofile, OBJ_EXT)));
    End
    Else
        ofile := GenMakePath(ChangeFileExt(tfile, OBJ_EXT));

    If fProject.Units[idx].CompileCpp Then
        Result := #9 + '$(CPP) ' + format(devCompiler.OutputFormat,
            [GenMakePath(tfile), ofile]) + ' $(CXXFLAGS)'
    Else
        Result := #9 + '$(CC) ' + format(devCompiler.OutputFormat,
            [GenMakePath(tfile), ofile]) + ' $(CFLAGS)';
End;

Procedure TfrmProjectOptions.txtOverrideBuildCmdChange(Sender: TObject);
Var
    idx: Integer;
Begin
    If Not Assigned(lvFiles.Selected) Or Not txtOverrideBuildCmd.Enabled Then
        Exit;
    idx := Integer(lvFiles.Selected.Data);
    If (lvFiles.Selected.Level > 0) And (idx <> -1) Then // unit
        fProject.Units[idx].BuildCmd :=
            StringReplace(txtOverrideBuildCmd.Text, #13#10, '<CRTAB>', [rfReplaceAll]);
End;

Procedure TfrmProjectOptions.spnPriorityChange(Sender: TObject);
Var
    I, idx: Integer;
Begin
    If Not Assigned(lvFiles.Selected) Or Not spnPriority.Enabled Then
        Exit;
    For I := 0 To lvFiles.SelectionCount - 1 Do
    Begin
        idx := Integer(lvFiles.Selections[I].Data);
        If (lvFiles.Selections[I].Level > 0) And (idx <> -1) Then // unit
            fProject.Units[idx].Priority := spnPriority.Value;
    End;
End;

Procedure TfrmProjectOptions.btnCustomMakeBrowseClick(Sender: TObject);
Begin
    If dlgCustomMake.Execute Then
        // EAB: this created problems with paths:
        edCustomMakefile.Text := dlgCustomMake.FileName;
    // ExtractRelativePath(fProject.FileName, dlgCustomMake.FileName);
    edCustomMakefile.SetFocus;
End;

Procedure TfrmProjectOptions.cbUseCustomMakefileClick(Sender: TObject);
    Procedure ColorDisabled(W: TWinControl);
    Begin
        If Not W.Enabled Then
            W.Brush.Color := clBtnFace
        Else
            W.Brush.Color := clWindow;
        W.Repaint;
    End;
Begin
    edCustomMakefile.Enabled := cbUseCustomMakefile.Checked;
    btnCustomMakeBrowse.Enabled := cbUseCustomMakefile.Checked;
    lblMakefileCustomize.Enabled := Not cbUseCustomMakefile.Checked;
    MakeIncludes.Enabled := Not cbUseCustomMakefile.Checked;
    edMakeInclude.Enabled := Not cbUseCustomMakefile.Checked;
    btnMakUp.Enabled := Not cbUseCustomMakefile.Checked;
    btnMakDown.Enabled := Not cbUseCustomMakefile.Checked;
    btnMakeBrowse.Enabled := Not cbUseCustomMakefile.Checked;
    btnMakReplace.Enabled := Not cbUseCustomMakefile.Checked;
    btnMakAdd.Enabled := Not cbUseCustomMakefile.Checked;
    btnMakDelete.Enabled := Not cbUseCustomMakefile.Checked;
    btnMakDelInval.Enabled := Not cbUseCustomMakefile.Checked;

    // I want the disabled controls to be *shown* as disabled...
    ColorDisabled(edCustomMakefile);
    ColorDisabled(edMakeInclude);
    ColorDisabled(MakeIncludes);

    UpdateMakButtons();
End;

Procedure TfrmProjectOptions.MakeIncludesDrawItem(Control: TWinControl;
    Index: Integer; Rect: TRect; State: TOwnerDrawState);
Begin
    btnMakUp.Enabled := MakeIncludes.Items.Count > 0;
    btnMakDown.Enabled := MakeIncludes.Items.Count > 0;
End;

Procedure TfrmProjectOptions.grpPchClick(Sender: TObject);
Var
    idx, i: Integer;
    SrcProcessed, HProcessed: Boolean;

    Procedure ApplyToNode(Index: Integer; Header: Boolean; Selection: Integer);
    Begin
        Case Selection Of
            1:
                If Header Then
                    fProject.PchHead := Index
                Else
                    fProject.PchSource := Index;
            2:
                If Header And (Index = fProject.PchHead) Then
                    fProject.PchHead := -1
                Else
                If (Not Header) And (Index = fProject.PchSource) Then
                    fProject.PchSource := -1;
        End;
    End;
Begin
    If grpPch.ItemIndex = 0 Then
    Begin
        fProject.PchHead := -1;
        fProject.PchSource := -1;
    End
    Else
    Begin
        HProcessed := False;
        SrcProcessed := False;

        For I := 0 To lvFiles.SelectionCount - 1 Do
        Begin
            idx := Integer(lvFiles.Selections[I].Data);
            If idx <> -1 Then
                If (GetFileTyp(fProject.Units[idx].FileName) = utHead) And
                    (Not HProcessed) Then
                Begin
                    HProcessed := True;
                    ApplyToNode(idx, True, grpPch.ItemIndex);
                End
                Else
                If (GetFileTyp(fProject.Units[idx].FileName) = utSrc) And
                    (Not SrcProcessed) Then
                Begin
                    SrcProcessed := True;
                    ApplyToNode(idx, False, grpPch.ItemIndex);
                End;
        End;
    End;
End;

Procedure TfrmProjectOptions.cmbProfileSetCompChange(Sender: TObject);
Begin
    If cmbProfileSetComp.ItemIndex = -1 Then
        Exit;
    //Save the values
    If Sender <> Nil Then
        UpdateCurrentProfileDataFromUI;
    CurrentProfileIndex := cmbProfileSetComp.ItemIndex;
    UpdateUIWithCurrentProfile;
End;

Procedure TfrmProjectOptions.btnAddProfileSetClick(Sender: TObject);
Var
    S: String;
    NewProfile: TProjProfile;
Begin
    S := 'New Profile';
    If Not InputQuery('New Profile', 'Enter a new Profile', S) Or (S = '') Then
        Exit;

    NewProfile := TProjProfile.Create;
    NewProfile.ProfileName := S;
    NewProfile.ObjectOutput := CreateValidFileName(S);
    NewProfile.ExeOutput := CreateValidFileName(S);
    fProfiles.Add(NewProfile);
    UpdateProfileList(cmbProfileSetComp.ItemIndex);
End;

Procedure TfrmProjectOptions.btnDelProfileSetClick(Sender: TObject);
Begin
    If cmbProfileSetComp.Items.Count = 1 Then
    Begin
        MessageDlg(Lang[ID_COPT_CANTDELETECOMPSET], mtError, [mbOk], 0);
        Exit;
    End;

    If MessageDlg(Lang[ID_COPT_DELETECOMPSET], mtConfirmation,
        [mbYes, mbNo], 0) = mrNo Then
        Exit;

    // Remove the current profile
    fProfiles.Remove(cmbProfileSetComp.ItemIndex);

    // Change profile to first one
    cmbProfileSetComp.ItemIndex := 0;
    CurrentProfileIndex := 0;
    UpdateProfileList(0);

    cmbProfileSetCompChange(nil);
End;

Procedure TfrmProjectOptions.btnRenameProfileSetClick(Sender: TObject);
Var
    S: String;
Begin
    S := cmbProfileSetComp.Text;
    If Not InputQuery(Lang[ID_COPT_RENAMECOMPSET],
        Lang[ID_COPT_PROMPTRENAMECOMPSET], S) Or (S = '') Or
        (S = cmbProfileSetComp.Text) Then
        Exit;

    CurrentProfile.ProfileName := S;
    UpdateProfileList(cmbProfileSetComp.ItemIndex);
End;

Procedure TfrmProjectOptions.btnCopyProfileSetClick(Sender: TObject);
Var
    S: String;
    NewProfile: TProjProfile;
Begin
    S := 'New Profile';
    If Not InputQuery('Copy Profile', 'Enter a new Profile', S) Or (S = '') Then
        Exit;

    //TODO: Guru: Fix the Output Directory to have only valid characters
    NewProfile := TProjProfile.Create;
    NewProfile.CopyProfileFrom(CurrentProfile);
    NewProfile.ProfileName := S;
    NewProfile.ObjectOutput := CreateValidFileName(S);
    NewProfile.ExeOutput := CreateValidFileName(S);
    fProfiles.Add(NewProfile);
    UpdateProfileList(cmbProfileSetComp.ItemIndex);
    cmbProfileSetComp.ItemIndex := cmbProfileSetComp.Items.Count - 1;
    cmbProfileSetComp.OnChange(cmbProfileSetComp);

End;

Procedure TfrmProjectOptions.CreateParams(Var Params: TCreateParams);
Begin
    Inherited;
    If (Parent <> Nil) Or (ParentWindow <> 0) Then
        Exit;  // must not mess with wndparent if form is embedded

    If Assigned(Owner) And (Owner Is TWincontrol) Then
        Params.WndParent := TWinControl(Owner).handle
    Else
    If Assigned(Screen.Activeform) Then
        Params.WndParent := Screen.Activeform.Handle;
End;


End.
