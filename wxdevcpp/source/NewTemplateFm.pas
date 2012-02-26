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

Unit NewTemplateFm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, CheckLst, devTabs, ExtCtrls, Buttons, ComCtrls,
    project, ImgList, ExtDlgs, IniFiles, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QCheckLst, devTabs, QExtCtrls, QButtons, QComCtrls,
  project, QImgList, IniFiles, Types;
{$ENDIF}

Type
    TNewTemplateForm = Class(TForm)
        devPages1: TPageControl;
        pgTemplate: TTabSheet;
        pgFiles: TTabSheet;
        lblName: TLabel;
        lblDescr: TLabel;
        lblCateg: TLabel;
        lblProjName: TLabel;
        txtDescr: TEdit;
        cmbCateg: TComboBox;
        txtProjName: TEdit;
        lblFiles: TLabel;
        lstFiles: TCheckListBox;
        pgExtras: TTabSheet;
        lblCompiler: TLabel;
        memCompiler: TMemo;
        lblLinker: TLabel;
        memLinker: TMemo;
        btnCreate: TButton;
        btnCancel: TButton;
        dlgPic: TOpenPictureDialog;
        lblIcons: TGroupBox;
        lstIcons: TListBox;
        btnLib: TBitBtn;
        btnBrowse: TBitBtn;
        btnRemove: TBitBtn;
        cmbName: TComboBox;
        XPMenu: TXPMenu;
        memCppCompiler: TMemo;
        lblCppCompiler: TLabel;
        cbInclude: TCheckBox;
        cbLibrary: TCheckBox;
        cbRessource: TCheckBox;
        CompilerSet: TComboBox;
        Label1: TLabel;
        Procedure FormShow(Sender: TObject);
        Procedure btnLibClick(Sender: TObject);
        Procedure btnRemoveClick(Sender: TObject);
        Procedure btnBrowseClick(Sender: TObject);
        Procedure lstIconsDrawItem(Control: TWinControl; Index: Integer;
            Rect: TRect; State: TOwnerDrawState);
        Procedure lstIconsClick(Sender: TObject);
        Procedure btnCreateClick(Sender: TObject);
        Procedure cmbNameChange(Sender: TObject);
        Procedure CompilerSetChange(Sender: TObject);
        Procedure memCompilerChange(Sender: TObject);
        Procedure memCppCompilerChange(Sender: TObject);
        Procedure memLinkerChange(Sender: TObject);
    Private
        { Private declarations }
        Icons: Array[0..1] Of TIcon;
        IconFiles: Array[0..1] Of TFileName;
        sIcon: String;
        sProjIcon: String;
        Procedure LoadText;
        Procedure ReadCategories;
        Procedure FillUnits;
        Procedure FillExtras;
        Procedure FillIconsList;
        Procedure CreateTemplate;
    Public
        { Public declarations }
        TempProject: TProject;
    End;

Var
    NewTemplateForm: TNewTemplateForm;

Implementation

Uses utils, IconFrm, devcfg, version, Templates, MultiLangSupport;

{$R *.dfm}

Procedure TNewTemplateForm.FormShow(Sender: TObject);
Begin
    LoadText;

    cmbName.Text := 'Custom project 1';
    txtDescr.Text := 'This is a custom project.';
    txtProjName.Text := 'Custom project';

    ReadCategories;
    FillUnits;
    FillExtras;
    FillIconsList;

    btnLib.Enabled := False;
    btnBrowse.Enabled := False;
    btnRemove.Enabled := False;

    devPages1.ActivePageIndex := 0;

    cmbNameChange(Nil);
End;

Procedure TNewTemplateForm.btnLibClick(Sender: TObject);
Var
    IconFile: String;
Begin
    IconFile := '';
    With TIconForm.Create(Self) Do
        Try
            If ShowModal = mrOk Then
                If Selected <> '' Then
                    IconFile := Selected;
        Finally
            Free;
        End;

    If IconFile <> '' Then
    Begin
        If Icons[lstIcons.ItemIndex] = Nil Then
            Icons[lstIcons.ItemIndex] := TIcon.Create;
        Icons[lstIcons.ItemIndex].LoadFromFile(IconFile);
        IconFiles[lstIcons.ItemIndex] := IconFile;
        lstIcons.Repaint;
    End;
End;

Procedure TNewTemplateForm.btnRemoveClick(Sender: TObject);
Begin
    FreeAndNil(Icons[lstIcons.ItemIndex]);
    IconFiles[lstIcons.ItemIndex] := '';
    lstIcons.Repaint;
End;

Procedure TNewTemplateForm.btnBrowseClick(Sender: TObject);
Var
    IconFile: String;
Begin
    If dlgPic.Execute Then
    Begin
        IconFile := dlgPic.FileName;
        If IconFile <> '' Then
        Begin
            If Icons[lstIcons.ItemIndex] = Nil Then
                Icons[lstIcons.ItemIndex] := TIcon.Create;
            Icons[lstIcons.ItemIndex].LoadFromFile(IconFile);
            IconFiles[lstIcons.ItemIndex] := IconFile;
            lstIcons.Repaint;
        End;
    End;
End;

Procedure TNewTemplateForm.lstIconsDrawItem(Control: TWinControl;
    Index: Integer; Rect: TRect; State: TOwnerDrawState);
Var
    XOffset: Integer;
    YOffset: Integer;
Begin
    With (Control As TListBox).Canvas Do
    Begin
        FillRect(Rect);
        XOffset := 2;
        YOffset := ((Control As TListBox).ItemHeight - Abs(Font.Height)) Div 2;
        If Icons[Index] <> Nil Then
        Begin
            DrawIcon(Handle, Rect.Left + XOffset, Rect.Top + XOffset,
                Icons[Index].Handle);
            XOffset := Icons[Index].Width + 6;
        End
        Else
        Begin
            Rectangle(Rect.Left + XOffset, Rect.Top + XOffset, Rect.Left +
                32 + XOffset, Rect.Top + 32 + XOffset);
            TextOut(Rect.Left + XOffset + 1, Rect.Top + YOffset, 'Empty');
            XOffset := 32 + 6;
        End;
        TextOut(Rect.Left + XOffset, Rect.Top + YOffset,
            (Control As TListBox).Items[Index]);
    End;
End;

Procedure TNewTemplateForm.lstIconsClick(Sender: TObject);
Begin
    btnLib.Enabled := lstIcons.ItemIndex <> -1;
    btnBrowse.Enabled := lstIcons.ItemIndex <> -1;
    btnRemove.Enabled := lstIcons.ItemIndex <> -1;
End;

Procedure TNewTemplateForm.ReadCategories;
    Procedure AddCategory(FileName: TFileName);
    Var
        Temp: TTemplate;
    Begin
        If Not FileExists(FileName) Then
            Exit;
        Temp := TTemplate.Create;
        Temp.ReadTemplateFile(FileName);
        If cmbCateg.Items.IndexOf(Temp.Catagory) = -1 Then
            cmbCateg.Items.Add(Temp.Catagory);
        cmbName.Items.Add(Temp.Name);
    End;
Var
    i: Integer;
    Templates: TStringList;
    sDir: String;
Begin
    sDir := devDirs.Templates;
    If Not CheckChangeDir(sDir) Then
        Exit;
    cmbCateg.Clear;
    Templates := TStringList.Create;
    Try
        FilesFromWildCard(devDirs.Templates, '*' + TEMPLATE_EXT,
            Templates, False, False, True);
        If Templates.Count > 0 Then
        Begin
            For i := 0 To Templates.Count - 1 Do
                AddCategory(Templates[i]);
        End;
    Finally
        Templates.Free;
    End;
End;

Procedure TNewTemplateForm.FillUnits;
Var
    I: Integer;
Begin

    lstFiles.Clear;
    For I := 0 To TempProject.Units.Count - 1 Do
        lstFiles.Items.Add(ExtractFileName(TempProject.Units.Items[I].FileName));
    For I := 0 To lstFiles.Items.Count - 1 Do
        lstFiles.Checked[I] := True;
    If lstFiles.Items.Count > 0 Then
        lstFiles.ItemIndex := 0;

End;

Procedure TNewTemplateForm.FillExtras;
Var
    i: Integer;
Begin

    // Add compiler profiles
    CompilerSet.Clear;
    For i := 0 To TempProject.Profiles.Count - 1 Do
        CompilerSet.Items.Add(TempProject.Profiles.Items[i].ProfileName);

    CompilerSet.ItemIndex := TempProject.CurrentProfileIndex;
    CompilerSetChange(Nil);

End;

Procedure TNewTemplateForm.FillIconsList;
Begin
    lstIcons.Items.Clear;
    If TempProject.CurrentProfile.Icon <> '' Then
    Begin
        IconFiles[0] := ExpandFileto(TempProject.CurrentProfile.Icon,
            TempProject.Directory);
        Icons[0] := TIcon.Create;
        Icons[0].LoadFromFile(ExpandFileto(TempProject.CurrentProfile.Icon,
            TempProject.Directory));
        IconFiles[1] := ExpandFileto(TempProject.CurrentProfile.Icon,
            TempProject.Directory);
        Icons[1] := TIcon.Create;
        Icons[1].LoadFromFile(ExpandFileto(TempProject.CurrentProfile.Icon,
            TempProject.Directory));
    End
    Else
    Begin
        IconFiles[0] := '';
        IconFiles[1] := '';
    End;

    lstIcons.Items.Add(sIcon);
    lstIcons.Items.Add(sProjIcon);
End;

Procedure TNewTemplateForm.cmbNameChange(Sender: TObject);
Begin
    btnCreate.Enabled := (cmbName.Text <> '') And (cmbCateg.Text <> '');
End;

Procedure TNewTemplateForm.btnCreateClick(Sender: TObject);
Begin
    CreateTemplate;
    Close;
End;

Procedure TNewTemplateForm.CreateTemplate;
Var
    tmpIni: TIniFile;
    I, C: Integer;
    S, filename, ProfileName: String;
Begin
    filename := devDirs.Templates + cmbName.Text + '.template';
    If FileExists(filename) Then
    Begin
        If MessageDlg(Lang[ID_MSG_FILEEXISTS],
            mtWarning, [mbYes, mbNo], 0) = mrYes Then
            DeleteFile(filename)
        Else
        Begin
            exit;
        End;
    End;
    tmpIni := TIniFile.Create(filename);

    C := 0;

    With tmpIni Do
        Try
            WriteInteger('Template', 'ver', 3);
            WriteString('Template', 'Name', cmbName.Text);
            If IconFiles[0] <> '' Then
            Begin
                CopyFile(Pchar(IconFiles[0]), Pchar(devDirs.Templates +
                    cmbName.Text + '.ico'), False);
                WriteString('Template', 'Icon', cmbName.Text + '.ico');
            End;
            WriteString('Template', 'Description', txtDescr.Text);
            WriteString('Template', 'Catagory', cmbCateg.Text);
            // 'catagory' is not a typo...

            If txtProjName.Text = '' Then
                WriteString('Project', 'Name', cmbName.Text)
            Else
                WriteString('Project', 'Name', txtProjName.Text);

            WriteBool('Project', 'IsCpp', TempProject.Profiles.useGPP);

            WriteInteger('Project', 'ProfilesCount', TempProject.Profiles.Count);
            WriteInteger('Project', 'ProfileIndex', 1);


            If IconFiles[1] <> '' Then
            Begin
                CopyFile(Pchar(IconFiles[1]), Pchar(devDirs.Templates +
                    cmbName.Text + '.project.ico'), False);
                WriteString('Project', 'ProjectIcon', cmbName.Text + '.project.ico');
            End;

            For i := 0 To TempProject.Profiles.Count - 1 Do
            Begin
                ProfileName := 'Profile' + IntToStr(i);
                WriteString(ProfileName, 'ProfileName',
                    TempProject.Profiles[i].ProfileName);
                WriteInteger(ProfileName, 'UnitCount', C);
                WriteInteger(ProfileName, 'Type', Integer(TempProject.Profiles[i].typ));

                // WriteString(ProfileName, 'Compiler', StringReplace(memCompiler.Text, #13#10, '_@@_', [rfReplaceAll]));
                // WriteString(ProfileName, 'CppCompiler', StringReplace(memCppCompiler.Text, #13#10, '_@@_', [rfReplaceAll]));
                // WriteString(ProfileName, 'Linker', StringReplace(memLinker.Text, #13#10, '_@@_', [rfReplaceAll]));
                WriteString(ProfileName, 'Compiler',
                    StringReplace(TempProject.Profiles[i].Compiler, #13#10, '_@@_',
                    [rfReplaceAll]));
                WriteString(ProfileName, 'CppCompiler',
                    StringReplace(TempProject.Profiles[i].CppCompiler, #13#10,
                    '_@@_', [rfReplaceAll]));
                WriteString(ProfileName, 'Linker',
                    StringReplace(TempProject.Profiles[i].Linker, #13#10, '_@@_',
                    [rfReplaceAll]));


                WriteString(ProfileName, COMPILER_INI_LABEL,
                    TempProject.Profiles[i].CompilerOptions);
                WriteInteger(ProfileName, 'CompilerSet',
                    TempProject.Profiles[i].CompilerSet);
                WriteBool(ProfileName, 'IncludeVersionInfo',
                    TempProject.Profiles[i].IncludeVersionInfo);
                WriteBool(ProfileName, 'SupportXPThemes',
                    TempProject.Profiles[i].SupportXPThemes);

                If cbInclude.Checked Then
                    WriteString(ProfileName, 'Includes',
                        TempProject.Profiles[i].Includes.DelimitedText);
                If cbLibrary.Checked Then
                    WriteString(ProfileName, 'Libs',
                        TempProject.Profiles[i].Libs.DelimitedText);
                If cbRessource.Checked Then
                    WriteString(ProfileName, 'ResourceIncludes',
                        TempProject.Profiles[i].ResourceIncludes.DelimitedText);
            End;

           // C := 0;
            For I := 0 To lstFiles.Items.Count - 1 Do
                If lstFiles.Checked[I] Then
                Begin
                    WriteString('Unit' + IntToStr(C), 'CppName', lstFiles.Items[I]);
                    S := StringReplace(cmbName.Text + '_' + lstFiles.Items[I] +
                        '.txt', ' ', '_', [rfReplaceAll]);
                    WriteString('Unit' + IntToStr(C), 'Cpp', S);
                    CopyFile(Pchar(TempProject.Units[I].FileName),
                        Pchar(devDirs.Templates + S), False);
                    Inc(C);
                End;

            WriteInteger('Project', 'UnitCount', C);

            MessageDlg('The new template has been created!'#10#10 +
                'You can find it as "' + cmbName.Text + '" under the "' +
                cmbCateg.Text + '" tab in the "New project" dialog.',
                mtInformation, [mbOk], 0);
        Finally
            tmpIni.Free;
        End;
End;

Procedure TNewTemplateForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    With Lang Do
    Begin
        lblName.Caption := Strings[ID_NEWTPL_NAME];
        lblDescr.Caption := Strings[ID_NEWTPL_DESCRIPTION];
        lblCateg.Caption := Strings[ID_NEWTPL_CATEGORY];
        lblProjName.Caption := Strings[ID_NEWTPL_PROJECTNAME];
        lblFiles.Caption := Strings[ID_NEWTPL_FILES];
        lblCompiler.Caption := Strings[ID_POPT_COMP];
        lblCppCompiler.Caption := Strings[ID_COPT_GRP_CPP];
        lblLinker.Caption := Strings[ID_COPT_LINKERTAB];
        lblIcons.Caption := Strings[ID_NEWTPL_ICONS];
        pgTemplate.Caption := Strings[ID_NEWTPL_PAGETEMPLATE];
        pgFiles.Caption := Strings[ID_NEWTPL_PAGEFILES];
        pgExtras.Caption := Strings[ID_NEWTPL_PAGEEXTRAS];
        sIcon := Strings[ID_NEWTPL_TEMPLATEICON];
        sProjIcon := Strings[ID_NEWTPL_PROJECTICON];
        btnCreate.Caption := Strings[ID_NEWTPL_CREATE];
        btnCancel.Caption := Strings[ID_BTN_CANCEL];
        btnLib.Caption := Strings[ID_POPT_ICOLIB];
        btnBrowse.Caption := Strings[ID_BTN_BROWSE];
        btnRemove.Caption := Strings[ID_BTN_REMOVEICON];
        Caption := Strings[ID_NEWTPL_CAPTION];
        cbInclude.Caption := Strings[ID_NEWTPL_INCDIR];
        cbLibrary.Caption := Strings[ID_NEWTPL_LIBDIR];
        cbRessource.Caption := Strings[ID_NEWTPL_RESDIR];
    End;
End;

Procedure TNewTemplateForm.CompilerSetChange(Sender: TObject);
Begin

    // Change the compiler and linker boxes to selected compiler set
    memCompiler.Clear;
    memCppCompiler.Clear;
    memLinker.Clear;

    If TempProject.Profiles.Items[CompilerSet.ItemIndex].Compiler <> '' Then
        memCompiler.Lines.Add(StringReplace(
            TempProject.Profiles.Items[CompilerSet.ItemIndex].Compiler,
            '_@@_', #13#10, [rfReplaceAll]));
    If TempProject.Profiles.Items[CompilerSet.ItemIndex].CppCompiler <> '' Then
        memCppCompiler.Lines.Add(
            StringReplace(TempProject.Profiles.Items[CompilerSet.ItemIndex].CppCompiler,
            '_@@_', #13#10, [rfReplaceAll]));
    If TempProject.Profiles.Items[CompilerSet.ItemIndex].Linker <> '' Then
        memLinker.Lines.Add(StringReplace(
            TempProject.Profiles.Items[CompilerSet.ItemIndex].Linker, '_@@_',
            #13#10, [rfReplaceAll]));

End;

Procedure TNewTemplateForm.memCompilerChange(Sender: TObject);
Begin
    TempProject.Profiles[CompilerSet.ItemIndex].Compiler := memCompiler.Text;
End;

Procedure TNewTemplateForm.memCppCompilerChange(Sender: TObject);
Begin
    TempProject.Profiles[CompilerSet.ItemIndex].CppCompiler :=
        memCppCompiler.Text;
End;

Procedure TNewTemplateForm.memLinkerChange(Sender: TObject);
Begin
    TempProject.Profiles[CompilerSet.ItemIndex].Linker := memLinker.Text;
End;

End.
