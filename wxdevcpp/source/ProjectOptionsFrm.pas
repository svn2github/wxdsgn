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

unit ProjectOptionsFrm;

interface

uses
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

type
    TfrmProjectOptions = class(TForm)
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
        procedure ListClick(Sender: TObject);
        procedure EditChange(SEnder: TObject);
        procedure ButtonClick(Sender: TObject);
        procedure UpDownClick(Sender: TObject);
        procedure BrowseClick(Sender: TObject);
        procedure SubTabsChange(Sender: TObject);
        procedure SubTabsChanging(Sender: TObject; NewIndex: Integer;
            var AllowChange: Boolean);
        procedure FormShow(Sender: TObject);
        procedure btnIconLibClick(Sender: TObject);
        procedure btnIconBrwseClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure btnRemoveIconClick(Sender: TObject);
        procedure BrowseExecutableOutDirClick(Sender: TObject);
        procedure BrowseObjDirClick(Sender: TObject);
        procedure BrowseImageDirClick(Sender: TObject);
        procedure btnMakeBrowseClick(Sender: TObject);
        procedure btnMakClick(Sender: TObject);
        procedure MakButtonClick(Sender: TObject);
        procedure edMakeIncludeChange(Sender: TObject);
        procedure MakeIncludesClick(Sender: TObject);
        procedure btnHelpClick(Sender: TObject);
        procedure chkOverrideOutputClick(Sender: TObject);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure chkCompileClick(Sender: TObject);
        procedure chkVersionInfoClick(Sender: TObject);
        procedure lvFilesChange(Sender: TObject; Node: TTreeNode);
        procedure cmbCompilerChange(Sender: TObject);
        procedure btnCancelClick(Sender: TObject);
        procedure lstTypeClick(Sender: TObject);
        procedure btnOkClick(Sender: TObject);
        procedure AddLibBtnClick(Sender: TObject);
        procedure txtOverrideBuildCmdChange(Sender: TObject);
        procedure spnPriorityChange(Sender: TObject);
        procedure btnCustomMakeBrowseClick(Sender: TObject);
        procedure cbUseCustomMakefileClick(Sender: TObject);
        procedure MakeIncludesDrawItem(Control: TWinControl; Index: Integer;
            Rect: TRect; State: TOwnerDrawState);
        procedure grpPchClick(Sender: TObject);
        procedure cmbProfileSetCompChange(Sender: TObject);
        procedure btnAddProfileSetClick(Sender: TObject);
        procedure btnDelProfileSetClick(Sender: TObject);
        procedure btnRenameProfileSetClick(Sender: TObject);
        procedure btnCopyProfileSetClick(Sender: TObject);
    private
        fProfiles: TProjectProfileList;
        fIcon: string;
        fProject: TProject;
        fOriginalProfileIndex: Integer;
        fCurrentProfileIndex: Integer;
        dlgCustomMake: TOpenDialogEx;
	       OpenLibDialog: TOpenDialogEx;
	       dlgMakeInclude: TOpenDialogEx;
	       dlgOpen: TOpenDialogEx;
        procedure UpdateUIWithCurrentProfile;
        procedure UpdateCurrentProfileDataFromUI;
        procedure UpdateProfileList(ProfileIndex: integer);
        procedure SetProfiles(Value: TProjectProfileList);
        function GetProfiles: TProjectProfileList;
        procedure UpdateButtons;
        procedure UpdateMakButtons;
        procedure LoadText;
        procedure InitVersionInfo;
        function DefaultBuildCommand(idx: integer): string;
        procedure SaveDirSettings;
        function GetCurrentProfile: TProjProfile;
    public
        property Project: TProject read fProject write fProject;
        property Profiles: TProjectProfileList read GetProfiles write SetProfiles;
        property CurrentProfile: TProjProfile read GetCurrentProfile;
        property CurrentProfileIndex: Integer
            read fCurrentProfileIndex write fCurrentProfileIndex;
    protected
        procedure CreateParams(var Params: TCreateParams); override;
    end;

implementation

uses
{$IFDEF WIN32}
    FileCtrl, devcfg, IconFrm, utils, MultiLangSupport, version, hh;
{$ENDIF}
{$IFDEF LINUX}
  devcfg, IconFrm, utils, MultiLangSupport, version;
{$ENDIF}

{$R *.dfm}

procedure TfrmProjectOptions.UpdateButtons;
begin
    btnAdd.Enabled := edEntry.Text <> '';
    if lstList.ItemIndex >= 0 then
    begin
        btnDelete.Enabled := TRUE;
        btnReplace.Enabled := btnAdd.Enabled;
        btnUp.Enabled := lstList.ItemIndex > 0;
        btnDown.Enabled := lstList.ItemIndex < (lstList.Items.Count - 1);
    end
    else
    begin
        btnDelete.Enabled := FALSE;
        btnReplace.Enabled := FALSE;
        btnUp.Enabled := FALSE;
        btnDown.Enabled := FALSE;
    end;
    btnDelInval.Enabled := lstList.Items.Count > 0;
end;

procedure TfrmProjectOptions.UpdateMakButtons;
begin
    btnMakAdd.Enabled := edMakeInclude.Text <> '';
    if MakeIncludes.ItemIndex >= 0 then
    begin
        btnMakDelete.Enabled := TRUE;
        btnMakReplace.Enabled := btnMakAdd.Enabled;
        btnMakUp.Enabled := MakeIncludes.ItemIndex > 0;
        btnMakDown.Enabled := MakeIncludes.ItemIndex <
            (MakeIncludes.Items.Count - 1);
    end
    else
    begin
        btnMakDelete.Enabled := FALSE;
        btnMakReplace.Enabled := FALSE;
        btnMakUp.Enabled := FALSE;
        btnMakDown.Enabled := FALSE;
    end;
    btnMakDelInval.Enabled := MakeIncludes.Items.Count > 0;
end;

procedure TfrmProjectOptions.BrowseClick(Sender: TObject);
var
{$IFDEF WIN32}
    NewItem: string;
{$ENDIF}
{$IFDEF LINUX}
  NewItem: WideString;
{$ENDIF}
begin
    if (Trim(edEntry.Text) <> '') and DirectoryExists(Trim(edEntry.Text)) then
        newitem := edEntry.Text
    else
        newitem := devDirs.Default;
    case SubTabs.TabIndex of
        0: // Lib tab
        begin
            if SelectDirectory('Library Directory', '', newitem) then
                edEntry.Text := NewItem;
        end;
        1: // Include tab
        begin
            if SelectDirectory('Include Directory', '', newitem) then
                edEntry.Text := NewItem;
        end;
        2: // Resource dir Tab
        begin
            if SelectDirectory('Resource Directory', '', newitem) then
                edEntry.Text := NewItem;
        end;
    end;
    edEntry.SetFocus;
end;

procedure TfrmProjectOptions.ButtonClick(Sender: TObject);
var
    idx: integer;
begin
    case (Sender as TComponent).Tag of
        1:
        begin
            lstList.Items[lstList.ItemIndex] := TrimRight(edEntry.Text);
            case SubTabs.TabIndex of
                0:
                    CurrentProfile.Libs[lstList.ItemIndex] := TrimRight(edEntry.Text);
                1:
                    CurrentProfile.Includes[lstList.ItemIndex] := TrimRight(edEntry.Text);
                2:
                    CurrentProfile.ResourceIncludes[lstList.ItemIndex] := TrimRight(edEntry.Text);
            end;
        end;
        2:
        begin
            lstList.Items.Add(TrimRight(edEntry.Text));
            case SubTabs.TabIndex of
                0:
                    CurrentProfile.Libs.Add(TrimRight(edEntry.Text));
                1:
                    CurrentProfile.Includes.Add(TrimRight(edEntry.Text));
                2:
                    CurrentProfile.ResourceIncludes.Add(TrimRight(edEntry.Text));
            end;
        end;
        3:
        begin
            case SubTabs.TabIndex of
                0:
                    CurrentProfile.Libs.Delete(lstList.ItemIndex);
                1:
                    CurrentProfile.Includes.Delete(lstList.ItemIndex);
                2:
                    CurrentProfile.ResourceIncludes.Delete(lstList.ItemIndex);
            end;
            lstList.DeleteSelected;
        end;
        4:
        begin
            if lstList.Items.Count > 0 then
                for idx := pred(lstList.Items.Count) downto 0 do
                    case SubTabs.TabIndex of
                        0:
                            if not DirectoryExists(lstList.Items[idx]) then
                            begin
                                CurrentProfile.Libs.Delete(idx);
                                lstList.Items.Delete(idx);
                            end;
                        1:
                            if not DirectoryExists(lstList.Items[idx]) then
                            begin
                                CurrentProfile.Includes.Delete(idx);
                                lstList.Items.Delete(idx);
                            end;
                        2:
                            if not DirectoryExists(lstList.Items[idx]) then
                            begin
                                CurrentProfile.ResourceIncludes.Delete(idx);
                                lstList.Items.Delete(idx);
                            end;
                    end;
        end;
    end;
    edEntry.Clear;
    UpdateButtons;
end;

procedure TfrmProjectOptions.EditChange(SEnder: TObject);
begin
    UpdateButtons;
end;

procedure TfrmProjectOptions.ListClick(Sender: TObject);
begin
    UpdateButtons;

    if lstList.Itemindex <> -1 then
        edEntry.Text := lstList.Items[lstList.Itemindex];
end;

procedure TfrmProjectOptions.UpDownClick(Sender: TObject);
var
    idx: integer;
begin
    idx := lstList.ItemIndex;
    if Sender = btnUp then
    begin
        lstList.Items.Exchange(lstList.ItemIndex, lstList.ItemIndex - 1);
        lstList.ItemIndex := idx - 1;
    end
    else
    if Sender = btnDown then
    begin
        lstList.Items.Exchange(lstList.ItemIndex, lstList.ItemIndex + 1);
        lstList.ItemIndex := idx + 1;
    end;
    UpdateButtons;
end;

function TfrmProjectOptions.GetCurrentProfile: TProjProfile;
begin
    if (fCurrentProfileIndex < 0) or (fCurrentProfileIndex >
        fProfiles.Count - 1) then
    begin
        Result := nil;
        exit;
    end;
    Result := fProfiles[fCurrentProfileIndex];
end;

function TfrmProjectOptions.GetProfiles: TProjectProfileList;
begin
    //UpdateCurrentProfileDataFromUI;
    result := fProfiles;
end;

procedure TfrmProjectOptions.SetProfiles(Value: TProjectProfileList);
begin
    fProfiles.CopyDataFrom(Value);
    //Load the profiles First
    cmbProfileSetComp.Clear;

    if fProfiles.Count = 0 then
        exit;

    UpdateProfileList(-1);
    if Assigned(fProject) = false then
    begin
        ShowMessage('Project Not Intialised');
        exit;
    end;

    if (fProject.DefaultProfileIndex > fProfiles.count - 1) or
        (fProject.DefaultProfileIndex < 0) then
    begin
        fProject.DefaultProfileIndex := 0;
    end;
    CurrentProfileIndex := fProject.CurrentProfileIndex;
    cmbProfileSetComp.ItemIndex := CurrentProfileIndex;
    cmbProfileSetCompChange(nil);
End;

procedure TfrmProjectOptions.UpdateProfileList(ProfileIndex: Integer);
var
    i: Integer;
begin
    cmbProfileSetComp.Clear;
    for i := 0 to fProfiles.count - 1 do
    begin
        if trim(fProfiles.Items[i].ProfileName) <> '' then
            cmbProfileSetComp.Items.Add(fProfiles.Items[i].ProfileName)
        else
            cmbProfileSetComp.Items.Add('Profile ' + IntToStr(i + 1));
    end;

    if (ProfileIndex <> -1) then
    begin
        fOriginalProfileIndex := ProfileIndex;
        cmbProfileSetComp.ItemIndex := ProfileIndex;
    end;
end;

procedure TfrmProjectOptions.UpdateCurrentProfileDataFromUI;
var
    I: integer;
    strCppOption, strCOption, strLinkerOption, strPreprocDefines: String;
{$IFDEF PLUGIN_BUILD}
   j : integer;
  pluginSettings: TSettings;
  tempName : string;
{$ENDIF PLUGIN_BUILD}
begin
    if CurrentProfile = nil then
        exit;
    with CurrentProfile do
    begin
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
        for I := 0 to edCompiler.Lines.Count - 1 do
            strCOption := strCOption + edCompiler.Lines[I] + '_@@_';
        strCppOption := '';
        for I := 0 to edCppCompiler.Lines.Count - 1 do
            strCppOption := strCppOption + edCppCompiler.Lines[I] + '_@@_';
        strLinkerOption := '';
        for I := 0 to edLinker.Lines.Count - 1 do
            strLinkerOption := strLinkerOption + edLinker.Lines[I] + '_@@_';
        strPreprocDefines := '';
        for I := 0 to edDefines.Lines.Count - 1 do
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
        if cbUseCustomMakefile.Checked and FileExists(edCustomMakefile.Text) then
            CurrentProfile.UseCustomMakefile := true
        else
            CurrentProfile.UseCustomMakefile := false;

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

        if cmbLangID.ItemIndex > -1 then
        begin
            for I := 0 to Languages.Count - 1 do
            begin
                if SameText(Languages.Name[I], cmbLangID.Text) then
                begin
                    Project.VersionInfo.LanguageID := Languages.LocaleID[I];
                    Project.VersionInfo.CharsetID := $04E4;
                    Break;
                end;
            end;
            if SameText('Language Neutral', cmbLangID.Text) then
                // EAB Attempt to add Language Neutral option. Requires feedback.
            begin
                Project.VersionInfo.LanguageID := 0;
                Project.VersionInfo.CharsetID := 1200;
            end;
        end;
    end;

    {$IFDEF PLUGIN_BUILD}
        for i := 0 to MainForm.pluginsCount - 1 do
            begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        for j := 0 to Length(pluginSettings) - 1 do
        begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            if tempName <> '' then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        end;
        MainForm.plugins[i].LoadCompilerOptions;

        end;

    {$ENDIF PLUGIN_BUILD}

end;

procedure TfrmProjectOptions.UpdateUIWithCurrentProfile;
var
    idx, cntSrc, cntHdr, cntRes: integer;
Begin
    fIcon := GetRealPath(CurrentProfile.Icon, fProject.Directory);
    if (fIcon <> '') and (FileExists(fIcon)) then
        try
            Icon.Picture.LoadFromFile(fIcon);
        except
            fIcon := '';
        end;

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
    for idx := 0 to fProject.Units.Count - 1 do
        case GetFileTyp(fProject.Units[idx].FileName) of
            utSrc:
                Inc(cntSrc);
            utHead:
                Inc(cntHdr);
            utRes:
                Inc(cntRes);
        end;
    lblPrjUnits.Caption := Format(Lang[ID_POPT_UNITSFORMAT],
        [fProject.Units.Count, cntSrc, cntHdr, cntRes]);
    chkSupportXP.Checked := CurrentProfile.SupportXPThemes;

    // Files tab
    if CurrentProfile.CompilerSet < devCompilerSet.Sets.Count then
    begin
        cmbCompiler.Items.Assign(devCompilerSet.Sets);
        cmbCompiler.ItemIndex := CurrentProfile.CompilerSet;
        cmbCompiler.OnChange(cmbCompiler);
    end
    else
    begin
        Application.MessageBox(
            'The compiler specified in the project file does not exist on the local computer.'#10#13#10#13 +
            'Please select a compiler, the default one selected may not be what you want.',
            'wxDev-C++',
            MB_OK or MB_ICONEXCLAMATION);
        PageControl.ActivePage := tabCompiler;
    end;

    // Output tab
    edExeOutput.Text := CurrentProfile.ExeOutput;
    edObjOutput.Text := CurrentProfile.ObjectOutput;
    edImagesOutput.Text := CurrentProfile.ImagesOutput;
    chkOverrideOutput.Checked := CurrentProfile.OverrideOutput;
    if CurrentProfile.OverridenOutput <> '' then
        edOverridenOutput.Text := ExtractFilename(CurrentProfile.OverridenOutput)
    else
        edOverridenOutput.Text := ExtractFilename(fProject.Executable);
    edOverridenOutput.Enabled := CurrentProfile.OverrideOutput;

    // Makefile tab
    cbUseCustomMakefile.Checked := CurrentProfile.UseCustomMakefile;
    edCustomMakefile.Text := CurrentProfile.CustomMakefile;
    cbUseCustomMakefileClick(nil);
    MakeIncludes.Clear;
    MakeIncludes.Items.AddStrings(CurrentProfile.MakeIncludes);

    // Version tab
    InitVersionInfo;

end;

procedure TfrmProjectOptions.SaveDirSettings;
var
    sl: TStrings;
begin
    sl := nil;
    case SubTabs.TabIndex of
        0:
            sl := CurrentProfile.Libs;
        1:
            sl := CurrentProfile.Includes;
        2:
            sl := CurrentProfile.ResourceIncludes;
    end;
    if assigned(sl) then
    begin
        sl.Clear;
        sl.AddStrings(lstList.Items);
    end;
end;

procedure TfrmProjectOptions.SubTabsChanging(Sender: TObject;
    NewIndex: Integer; var AllowChange: Boolean);
begin
    SaveDirSettings;
end;

procedure TfrmProjectOptions.SubTabsChange(Sender: TObject);
begin
    if fProfiles = nil then
        exit;
    case SubTabs.TabIndex of
        0:
            lstList.Items := CurrentProfile.Libs;
        1:
            lstList.Items := CurrentProfile.Includes;
        2:
            lstList.Items := CurrentProfile.ResourceIncludes;
    end;
    UpdateButtons;
end;

procedure TfrmProjectOptions.FormShow(Sender: TObject);
begin
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
    grpPch.OnClick := nil;
    if (fProject.PchHead = -1) and (fProject.PchSource = -1) then
        grpPch.ItemIndex := 0
    else
        grpPch.ItemIndex := 2;
    grpPch.OnClick := grpPchClick;
end;

procedure TfrmProjectOptions.btnIconLibClick(Sender: TObject);
begin
    with TIconForm.Create(Self) do
        try
            if ShowModal = mrOk then
                if Selected <> '' then
                    fIcon := Selected;
        finally
            Free;
        end;
    if fIcon <> '' then
    begin
        Icon.Picture.LoadFromFile(fIcon);
        btnRemoveIcon.Enabled := Length(fIcon) > 0;
    end;
end;

procedure TfrmProjectOptions.btnIconBrwseClick(Sender: TObject);
begin
    if dlgPic.Execute then
    begin
        if FileExists(dlgPic.FileName) then
        begin
            fIcon := dlgPic.FileName;
            Icon.Picture.LoadFromFile(fIcon);
            btnRemoveIcon.Enabled := Length(fIcon) > 0;
        end
        else
            MessageDlg(format(Lang[ID_MSG_COULDNOTOPENFILE], [dlgPic.FileName]),
                mtError, [mbOK], 0);
    end;
end;

procedure TfrmProjectOptions.FormCreate(Sender: TObject);
begin
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
end;

procedure TfrmProjectOptions.LoadText;
begin
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
end;

procedure TfrmProjectOptions.btnRemoveIconClick(Sender: TObject);
begin
    btnRemoveIcon.Enabled := False;
    fIcon := '';
    Icon.Picture.Graphic := nil;
end;

procedure TfrmProjectOptions.BrowseExecutableOutDirClick(Sender: TObject);
var
{$IFDEF WIN32}
    Dir: String;
{$ENDIF}
{$IFDEF LINUX}
  Dir: WideString;
{$ENDIF}
    TempDir: String;
begin
    if fProject.CurrentProfile.ExeOutput <> '' then
        Dir := ExpandFileto(fProject.CurrentProfile.ExeOutput, fProject.Directory)
    else
        Dir := fProject.Directory;
    if not SelectDirectory('Select Directory', '', Dir) then
	       Exit;

    //TODO: lowjoel: What do we actually want to achieve here?
    TempDir := ExtractRelativePath(fProject.Directory, Dir);
    if DirectoryExists(TempDir) then
        TempDir := GetShortName(TempDir)
    else
        TempDir := TempDir;
    edExeOutput.Text := TempDir;
end;

procedure TfrmProjectOptions.BrowseObjDirClick(Sender: TObject);
var
{$IFDEF WIN32}
    Dir: String;
{$ENDIF}
{$IFDEF LINUX}
  Dir: WideString;
{$ENDIF}
    TempDir: String;
begin
    if fProject.CurrentProfile.ObjectOutput <> '' then
        Dir := ExpandFileto(fProject.CurrentProfile.ObjectOutput, fProject.Directory)
    else
        Dir := fProject.Directory;
    if SelectDirectory('Select Directory', '', Dir) = false then
        exit;
    TempDir := ExtractRelativePath(fProject.Directory, Dir);
    if DirectoryExists(TempDir) then
        TempDir := GetShortName(TempDir)
    else
        TempDir := TempDir;
    edObjOutput.Text := TempDir;
end;

procedure TfrmProjectOptions.BrowseImageDirClick(Sender: TObject);
var
{$IFDEF WIN32}
    Dir: String;
{$ENDIF}
{$IFDEF LINUX}
  Dir: WideString;
{$ENDIF}
    TempDir: String;
begin
    if fProject.CurrentProfile.ImagesOutput <> '' then
        Dir := ExpandFileto(fProject.CurrentProfile.ImagesOutput, fProject.Directory)
    else
        Dir := fProject.Directory;
    if SelectDirectory('Select Directory', '', Dir) = false then
        exit;
    TempDir := ExtractRelativePath(fProject.Directory, Dir);
    if DirectoryExists(TempDir) then
        TempDir := GetShortName(TempDir)
    else
        TempDir := TempDir;
    edImagesOutput.Text := TempDir;
end;

procedure TfrmProjectOptions.btnMakeBrowseClick(Sender: TObject);
begin
    if dlgMakeInclude.Execute then
        edMakeInclude.Text := ExtractRelativePath(fProject.FileName,
            dlgMakeInclude.FileName);
    edMakeInclude.SetFocus;
end;

procedure TfrmProjectOptions.btnMakClick(Sender: TObject);
var
    i: Integer;
begin
    i := MakeIncludes.ItemIndex;
    if i < 0 then
        exit;
    if Sender = btnMakUp then
    begin
        MakeIncludes.Items.Exchange(MakeIncludes.ItemIndex,
            MakeIncludes.ItemIndex - 1);
        MakeIncludes.ItemIndex := i - 1;
    end
    else
    if Sender = btnMakDown then
    begin
        MakeIncludes.Items.Exchange(MakeIncludes.ItemIndex,
            MakeIncludes.ItemIndex + 1);
        MakeIncludes.ItemIndex := i + 1;
    end;

    UpdateMakButtons;
end;

procedure TfrmProjectOptions.MakButtonClick(Sender: TObject);
var
    i: Integer;
begin
    case (Sender as TComponent).Tag of
        1:
        begin
            MakeIncludes.Items[MakeIncludes.ItemIndex] := (edMakeInclude.Text);
        end;
        2:
        begin
            MakeIncludes.Items.Add(edMakeInclude.Text);
        end;
        3:
        begin
            MakeIncludes.DeleteSelected;
        end;
        4:
        begin
            i := 0;
            while i < MakeIncludes.Items.Count do
            begin
                if not FileExists(MakeIncludes.Items[i]) then
                begin
                    MakeIncludes.Items.Delete(i);
                    i := -1;
                end;
                i := i + 1;
            end;
        end;
    end;
    edMakeInclude.Clear;
    UpdateMakButtons;
end;

procedure TfrmProjectOptions.edMakeIncludeChange(Sender: TObject);
begin
    UpdateMakButtons;
end;

procedure TfrmProjectOptions.MakeIncludesClick(Sender: TObject);
begin
    UpdateMakButtons;

    if MakeIncludes.Itemindex <> -1 then
        edMakeInclude.Text := MakeIncludes.Items[MakeIncludes.Itemindex];
end;

procedure TfrmProjectOptions.btnHelpClick(Sender: TObject);
begin
    Application.HelpFile := IncludeTrailingPathDelimiter(devDirs.Help) +
        DEV_MAINHELP_FILE;
    HtmlHelp(self.handle, PChar(Application.HelpFile), HH_DISPLAY_TOPIC,
        DWORD(PChar('html\managing_project_options.html')));
    //Application.HelpJump('ID_MANAGEPROJECT');
end;

procedure TfrmProjectOptions.chkOverrideOutputClick(Sender: TObject);
begin
    edOverridenOutput.Enabled := chkOverrideOutput.Checked;
end;

procedure TfrmProjectOptions.FormCloseQuery(Sender: TObject;
    var CanClose: Boolean);
begin
    // check for disallowed characters in filename
    if (Pos('/', edOverridenOutput.Text) > 0) or
        (Pos('\', edOverridenOutput.Text) > 0) or
        (Pos(':', edOverridenOutput.Text) > 0) or
        (Pos('*', edOverridenOutput.Text) > 0) or
        (Pos('?', edOverridenOutput.Text) > 0) or
        (Pos('"', edOverridenOutput.Text) > 0) or
        (Pos('<', edOverridenOutput.Text) > 0) or
        (Pos('>', edOverridenOutput.Text) > 0) or
        (Pos('|', edOverridenOutput.Text) > 0) then
    begin
        MessageDlg('The output filename you have defined, contains at least one ' +
            'of the following illegal characters:'#10#10 +
            '\ / : * ? " > < |'#10#10 +
            'Please correct this...', mtError, [mbOk], 0);
        CanClose := False;
    end;
    if CanClose then
    begin
        devCompiler.CompilerSet := CurrentProfile.CompilerSet;
        devCompilerSet.LoadSet(devCompiler.CompilerSet);
        devCompilerSet.AssignToCompiler;
    end;
end;

procedure TfrmProjectOptions.lvFilesChange(Sender: TObject;
    Node: TTreeNode);
var
    idx: integer;
begin
    if not Assigned(Node) then
    begin
        chkCompile.Enabled := False;
        chkCompileCpp.Enabled := False;
        chkLink.Enabled := False;
        chkOverrideBuildCmd.Enabled := False;
        txtOverrideBuildCmd.Enabled := False;
        lblPriority.Enabled := False;
        spnPriority.Enabled := False;
        Exit;
    end;

    // disable events
    chkCompile.OnClick := nil;
    chkCompileCpp.OnClick := nil;
    chkLink.OnClick := nil;
    chkOverrideBuildCmd.OnClick := nil;
    txtOverrideBuildCmd.OnChange := nil;
    spnPriority.OnChange := nil;
    grpPch.OnClick := nil;

    idx := Integer(Node.Data);
    if (Node.Level > 0) and (idx <> -1) then
    begin // unit
        if fProject.Units[idx].OverrideBuildCmd then
            txtOverrideBuildCmd.Text :=
                StringReplace(fProject.Units[idx].BuildCmd, '<CRTAB>', #13#10, [rfReplaceAll])
        else
            txtOverrideBuildCmd.Text := DefaultBuildCommand(idx);
        chkOverrideBuildCmd.Checked := fProject.Units[idx].OverrideBuildCmd;

        chkCompile.Enabled := GetFileTyp(fProject.Units[idx].FileName) <> utHead;
        chkCompile.Checked := fProject.Units[idx].Compile;
        chkCompileCpp.Enabled := chkCompile.Checked and
            (GetFileTyp(fProject.Units[idx].FileName) in [utSrc]);
        chkCompileCpp.Checked := fProject.Units[idx].CompileCpp;
        chkLink.Enabled := chkCompile.Enabled and
            (GetFileTyp(fProject.Units[idx].FileName) <> utRes);
        chkLink.Checked := fProject.Units[idx].Link;
        lblPriority.Enabled := chkCompile.Checked and chkCompile.Enabled;
        spnPriority.Enabled := chkCompile.Checked and chkCompile.Enabled;
        spnPriority.Value := fProject.Units[idx].Priority;
        chkOverrideBuildCmd.Enabled := chkCompile.Checked and
            (lvFiles.SelectionCount = 1) and not
            (GetFileTyp(fProject.Units[idx].FileName) in [utHead, utRes]);
        txtOverrideBuildCmd.Enabled := chkOverrideBuildCmd.Enabled and
            chkOverrideBuildCmd.Checked;

        //Handle the PCH
        grpPch.Enabled := GetFileTyp(fProject.Units[idx].FileName) in
            [utSrc, utHead];
        if (fProject.PchHead = -1) and (fProject.PchSource = -1) then
            grpPch.ItemIndex := 0
        else
        if (fProject.PchHead = idx) or (fProject.PchSource = idx) then
            grpPch.ItemIndex := 1
        else
            grpPch.ItemIndex := 2;
    end
    else
    begin
        grpPch.Enabled := False;
        chkCompile.Enabled := False;
        chkCompileCpp.Enabled := False;
        chkLink.Enabled := False;
        chkOverrideBuildCmd.Enabled := False;
        txtOverrideBuildCmd.Enabled := False;
        lblPriority.Enabled := False;
        spnPriority.Enabled := False;
    end;

    // enable events
    chkCompile.OnClick := chkCompileClick;
    chkCompileCpp.OnClick := chkCompileClick;
    chkLink.OnClick := chkCompileClick;
    chkOverrideBuildCmd.OnClick := chkCompileClick;
    txtOverrideBuildCmd.OnChange := txtOverrideBuildCmdChange;
    spnPriority.OnChange := spnPriorityChange;
    grpPch.OnClick := grpPchClick;
end;

procedure TfrmProjectOptions.chkCompileClick(Sender: TObject);
    procedure DoNode(Node: TTreeNode);
    var
        I: integer;
        idx: integer;
    begin
        for I := 0 to Node.Count - 1 do
        begin
            idx := Integer(Node[I].Data);
            if idx <> -1 then
            begin // unit
                fProject.Units[idx].Compile := chkCompile.Checked;
                fProject.Units[idx].CompileCpp := chkCompileCpp.Checked;
            end
            else
            if Node[I].HasChildren then
                DoNode(Node[I]);
        end;
    end;
var
    I: integer;
    idx: integer;
begin
    for I := 0 to lvFiles.SelectionCount - 1 do
    begin
        idx := Integer(lvFiles.Selections[I].Data);
        if idx <> -1 then
        begin // unit
            fProject.Units[idx].Compile := chkCompile.Checked;
            fProject.Units[idx].CompileCpp := chkCompileCpp.Checked;
            fProject.Units[idx].Link := chkLink.Checked;
            if lvFiles.SelectionCount = 1 then
            begin
                fProject.Units[idx].OverrideBuildCmd := chkOverrideBuildCmd.Checked;

                txtOverrideBuildCmd.OnChange := nil;
                txtOverrideBuildCmd.Text :=
                    StringReplace(txtOverrideBuildCmd.Text, '<CRTAB>', #13#10, [rfReplaceAll]);

                lblPriority.Enabled := chkCompile.Checked;
                spnPriority.Enabled := chkCompile.Checked;
                chkOverrideBuildCmd.Enabled := chkCompile.Checked and
                    (GetFileTyp(fProject.Units[idx].FileName) <> utRes);
                if chkCompile.Checked and
                    (GetFileTyp(fProject.Units[idx].FileName) = utOther) then
                begin
                    // non-standard source files, *must* override the build command
                    chkCompileCpp.Enabled := False;
                    txtOverrideBuildCmd.Enabled := True;
                    chkOverrideBuildCmd.Checked := True;
                    if txtOverrideBuildCmd.Text = '' then
                        txtOverrideBuildCmd.Text := '<override this command>';
                end
                else
                begin
                    chkCompileCpp.Enabled := chkCompile.Checked and
                        (GetFileTyp(fProject.Units[idx].FileName) <> utRes);
                    if chkCompileCpp.Checked then
                    begin
                        txtOverrideBuildCmd.Text :=
                            StringReplace(txtOverrideBuildCmd.Text, '$(CC)', '$(CPP)', [rfReplaceAll]);
                        txtOverrideBuildCmd.Text :=
                            StringReplace(txtOverrideBuildCmd.Text, '$(CFLAGS)', '$(CXXFLAGS)',
                            [rfReplaceAll]);
                    end
                    else
                    begin
                        txtOverrideBuildCmd.Text :=
                            StringReplace(txtOverrideBuildCmd.Text, '$(CPP)', '$(CC)', [rfReplaceAll]);
                        txtOverrideBuildCmd.Text :=
                            StringReplace(txtOverrideBuildCmd.Text, '$(CXXFLAGS)', '$(CFLAGS)',
                            [rfReplaceAll]);
                    end;
                    txtOverrideBuildCmd.Enabled :=
                        chkOverrideBuildCmd.Enabled and chkOverrideBuildCmd.Checked;
                end;
                fProject.Units[idx].BuildCmd := txtOverrideBuildCmd.Text;
                txtOverrideBuildCmd.OnChange := txtOverrideBuildCmdChange;
            end;
        end
        else
        if lvFiles.Selections[I].HasChildren then
            DoNode(lvFiles.Selections[I]);
    end;
end;

procedure TfrmProjectOptions.InitVersionInfo;
var
    I: integer;
    S: string;
begin
    chkVersionInfo.Checked := CurrentProfile.IncludeVersionInfo;
    chkVersionInfoClick(nil);

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
    for I := 0 to Languages.Count - 1 do
        cmbLangID.Items.Add(Languages.Name[I]);

    S := Languages.NameFromLocaleID[Project.VersionInfo.LanguageID];
    if Project.VersionInfo.LanguageID = 0 then
        cmbLangID.ItemIndex := cmbLangID.Items.IndexOf('Language Neutral')
    else
    if S <> '' then
        cmbLangID.ItemIndex := cmbLangID.Items.IndexOf(S);

end;

procedure TfrmProjectOptions.chkVersionInfoClick(Sender: TObject);
begin
    spnMajor.Enabled := chkVersionInfo.Checked;
    spnMinor.Enabled := chkVersionInfo.Checked;
    spnRelease.Enabled := chkVersionInfo.Checked;
    spnBuild.Enabled := chkVersionInfo.Checked;
    cmbLangID.Enabled := chkVersionInfo.Checked;
    vleVersion.Enabled := chkVersionInfo.Checked;
    radNoAutoIncBuild.Enabled := chkVersionInfo.Checked;
    radAutoIncBuildOnCompile.Enabled := chkVersionInfo.Checked;
    radAutoIncBuildOnRebuild.Enabled := chkVersionInfo.Checked;
end;

procedure TfrmProjectOptions.cmbCompilerChange(Sender: TObject);
var currOpts: string;
begin
    currOpts := CurrentProfile.CompilerOptions;
    if (devCompilerSet.Sets.Count > cmbCompiler.ItemIndex) and
        (cmbCompiler.ItemIndex <> -1) then
    begin
        devCompiler.CompilerSet := cmbCompiler.ItemIndex;
        devCompilerSet.LoadSet(cmbCompiler.ItemIndex);
        devCompilerSet.AssignToCompiler;
    end;

    devCompiler.OptionStr := currOpts;
    CompOptionsFrame1.FillOptions(fProject);
end;

procedure TfrmProjectOptions.btnCancelClick(Sender: TObject);
begin
    cmbProfileSetComp.ItemIndex := fOriginalProfileIndex;
    cmbProfileSetComp.OnChange(Sender);
    // EAB Comment: Why call this here? AFAIK, nothing bad happens, but seems counter intuitive
end;

procedure TfrmProjectOptions.lstTypeClick(Sender: TObject);
begin
    chkSupportXP.Enabled := lstType.ItemIndex = 0;
end;

procedure TfrmProjectOptions.btnOkClick(Sender: TObject);
begin
    Screen.Cursor := crHourGlass;
    btnOk.Enabled := false;

    SaveDirSettings;
    UpdateCurrentProfileDataFromUI;

    Screen.Cursor := crDefault;
    btnOk.Enabled := true;

end;

procedure TfrmProjectOptions.AddLibBtnClick(Sender: TObject);
var
    s: string;
    i: integer;
begin
    if OpenLibDialog.Execute then
    begin
        for i := 0 to OpenLibDialog.Files.Count - 1 do
        begin
            S := ExtractRelativePath(fProject.Directory, OpenLibDialog.Files[i]);
            S := GenMakePath(S);
            edLinker.Lines.Add(S);
        end;
    end;
end;

function TfrmProjectOptions.DefaultBuildCommand(idx: integer): string;
var
    tfile, ofile: string;
begin
    Result := '';
    if GetFileTyp(fProject.Units[idx].FileName) <> utSrc then
        Exit;

    tfile := ExtractFileName(fProject.Units[idx].FileName);
    if fProject.Profiles[CurrentProfileIndex].ObjectOutput <> '' then
    begin
        ofile := IncludeTrailingPathDelimiter(
            fProject.Profiles[CurrentProfileIndex].ObjectOutput) + ExtractFileName(tfile);
        ofile := GenMakePath(ExtractRelativePath(fProject.FileName,
            ChangeFileExt(ofile, OBJ_EXT)));
    end
    else
        ofile := GenMakePath(ChangeFileExt(tfile, OBJ_EXT));

    if fProject.Units[idx].CompileCpp then
        Result := #9 + '$(CPP) ' + format(devCompiler.OutputFormat,
            [GenMakePath(tfile), ofile]) + ' $(CXXFLAGS)'
    else
        Result := #9 + '$(CC) ' + format(devCompiler.OutputFormat,
            [GenMakePath(tfile), ofile]) + ' $(CFLAGS)';
end;

procedure TfrmProjectOptions.txtOverrideBuildCmdChange(Sender: TObject);
var
    idx: integer;
begin
    if not Assigned(lvFiles.Selected) or not txtOverrideBuildCmd.Enabled then
        Exit;
    idx := Integer(lvFiles.Selected.Data);
    if (lvFiles.Selected.Level > 0) and (idx <> -1) then // unit
        fProject.Units[idx].BuildCmd :=
            StringReplace(txtOverrideBuildCmd.Text, #13#10, '<CRTAB>', [rfReplaceAll]);
end;

procedure TfrmProjectOptions.spnPriorityChange(Sender: TObject);
var
    I, idx: integer;
begin
    if not Assigned(lvFiles.Selected) or not spnPriority.Enabled then
        Exit;
    for I := 0 to lvFiles.SelectionCount - 1 do
    begin
        idx := Integer(lvFiles.Selections[I].Data);
        if (lvFiles.Selections[I].Level > 0) and (idx <> -1) then // unit
            fProject.Units[idx].Priority := spnPriority.Value;
    end;
end;

procedure TfrmProjectOptions.btnCustomMakeBrowseClick(Sender: TObject);
begin
    if dlgCustomMake.Execute then
        // EAB: this created problems with paths:
        edCustomMakefile.Text := dlgCustomMake.FileName;
    // ExtractRelativePath(fProject.FileName, dlgCustomMake.FileName);
    edCustomMakefile.SetFocus;
end;

procedure TfrmProjectOptions.cbUseCustomMakefileClick(Sender: TObject);
    procedure ColorDisabled(W: TWinControl);
    begin
        if not W.Enabled then
            W.Brush.Color := clBtnFace
        else
            W.Brush.Color := clWindow;
        W.Repaint;
    end;
begin
    edCustomMakefile.Enabled := cbUseCustomMakefile.Checked;
    btnCustomMakeBrowse.Enabled := cbUseCustomMakefile.Checked;
    lblMakefileCustomize.Enabled := not cbUseCustomMakefile.Checked;
    MakeIncludes.Enabled := not cbUseCustomMakefile.Checked;
    edMakeInclude.Enabled := not cbUseCustomMakefile.Checked;
    btnMakUp.Enabled := not cbUseCustomMakefile.Checked;
    btnMakDown.Enabled := not cbUseCustomMakefile.Checked;
    btnMakeBrowse.Enabled := not cbUseCustomMakefile.Checked;
    btnMakReplace.Enabled := not cbUseCustomMakefile.Checked;
    btnMakAdd.Enabled := not cbUseCustomMakefile.Checked;
    btnMakDelete.Enabled := not cbUseCustomMakefile.Checked;
    btnMakDelInval.Enabled := not cbUseCustomMakefile.Checked;

    // I want the disabled controls to be *shown* as disabled...
    ColorDisabled(edCustomMakefile);
    ColorDisabled(edMakeInclude);
    ColorDisabled(MakeIncludes);

    UpdateMakButtons();
end;

procedure TfrmProjectOptions.MakeIncludesDrawItem(Control: TWinControl;
    Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
    btnMakUp.Enabled := MakeIncludes.Items.Count > 0;
    btnMakDown.Enabled := MakeIncludes.Items.Count > 0;
end;

procedure TfrmProjectOptions.grpPchClick(Sender: TObject);
var
    idx, i: integer;
    SrcProcessed, HProcessed: Boolean;

    procedure ApplyToNode(Index: integer; Header: Boolean; Selection: integer);
    begin
        case Selection of
            1:
                if Header then
                    fProject.PchHead := Index
                else
                    fProject.PchSource := Index;
            2:
                if Header and (Index = fProject.PchHead) then
                    fProject.PchHead := -1
                else
                if (not Header) and (Index = fProject.PchSource) then
                    fProject.PchSource := -1;
        end;
    end;
begin
    if grpPch.ItemIndex = 0 then
    begin
        fProject.PchHead := -1;
        fProject.PchSource := -1;
    end
    else
    begin
        HProcessed := false;
        SrcProcessed := false;

        for I := 0 to lvFiles.SelectionCount - 1 do
        begin
            idx := Integer(lvFiles.Selections[I].Data);
            if idx <> -1 then
                if (GetFileTyp(fProject.Units[idx].FileName) = utHead) and
                    (not HProcessed) then
                begin
                    HProcessed := true;
                    ApplyToNode(idx, true, grpPch.ItemIndex);
                end
                else
                if (GetFileTyp(fProject.Units[idx].FileName) = utSrc) and
                    (not SrcProcessed) then
                begin
                    SrcProcessed := true;
                    ApplyToNode(idx, false, grpPch.ItemIndex);
                end;
        end;
    end;
end;

procedure TfrmProjectOptions.cmbProfileSetCompChange(Sender: TObject);
begin
    if cmbProfileSetComp.ItemIndex = -1 then
        Exit;
    //Save the values
    if Sender <> nil then
        UpdateCurrentProfileDataFromUI;
    CurrentProfileIndex := cmbProfileSetComp.ItemIndex;
    UpdateUIWithCurrentProfile;
end;

procedure TfrmProjectOptions.btnAddProfileSetClick(Sender: TObject);
var
    S: string;
    NewProfile: TProjProfile;
begin
    S := 'New Profile';
    if not InputQuery('New Profile', 'Enter a new Profile', S) or (S = '') then
        Exit;

    NewProfile := TProjProfile.Create;
    NewProfile.ProfileName := S;
    NewProfile.ObjectOutput := CreateValidFileName(S);
    NewProfile.ExeOutput := CreateValidFileName(S);
    fProfiles.Add(NewProfile);
    UpdateProfileList(cmbProfileSetComp.ItemIndex);
end;

procedure TfrmProjectOptions.btnDelProfileSetClick(Sender: TObject);
begin
    if cmbProfileSetComp.Items.Count = 1 then
    begin
        MessageDlg(Lang[ID_COPT_CANTDELETECOMPSET], mtError, [mbOk], 0);
        Exit;
    end;

    if MessageDlg(Lang[ID_COPT_DELETECOMPSET], mtConfirmation,
        [mbYes, mbNo], 0) = mrNo then
        Exit;

    fProfiles.Remove(cmbProfileSetComp.ItemIndex);
    cmbProfileSetComp.ItemIndex := 0;
    CurrentProfileIndex := 0;
    UpdateProfileList(0);
    cmbProfileSetCompChange(cmbProfileSetComp);
end;

procedure TfrmProjectOptions.btnRenameProfileSetClick(Sender: TObject);
var
    S: string;
begin
    S := cmbProfileSetComp.Text;
    if not InputQuery(Lang[ID_COPT_RENAMECOMPSET],
        Lang[ID_COPT_PROMPTRENAMECOMPSET], S) or (S = '') or
        (S = cmbProfileSetComp.Text) then
        Exit;

    CurrentProfile.ProfileName := S;
    UpdateProfileList(cmbProfileSetComp.ItemIndex);
end;

procedure TfrmProjectOptions.btnCopyProfileSetClick(Sender: TObject);
var
    S: string;
    NewProfile: TProjProfile;
begin
    S := 'New Profile';
    if not InputQuery('Copy Profile', 'Enter a new Profile', S) or (S = '') then
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

end;

procedure TfrmProjectOptions.CreateParams(var Params: TCreateParams);
begin
    inherited;
    if (Parent <> nil) or (ParentWindow <> 0) then
        Exit;  // must not mess with wndparent if form is embedded

    if Assigned(Owner) and (Owner is TWincontrol) then
        Params.WndParent := TWinControl(Owner).handle
    else
    if Assigned(Screen.Activeform) then
        Params.WndParent := Screen.Activeform.Handle;
end;


end.
