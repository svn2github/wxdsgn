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
Unit NewProjectFrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, ExtCtrls, ImgList, Buttons, ComCtrls, Templates, Inifiles,
    devTabs, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls, QImgList, QButtons, QComCtrls, Templates, Inifiles,
  devTabs;
{$ENDIF}

Type
    TNewProjectForm = Class(TForm)
        btnOk: TBitBtn;
        btnCancel: TBitBtn;
        ImageList: TImageList;
        TabsMain: TdevTabs;
        ProjView: TListView;
        pnlDesc: TPanel;
        lblDesc: TLabel;
        TemplateLabel: TLabel;
        btnHelp: TBitBtn;
        XPMenu: TXPMenu;
        lblPrjName: TLabel;
        Label2: TGroupBox;
        GroupBox1: TGroupBox;
        rbC: TRadioButton;
        cbDefault: TCheckBox;
        rbCpp: TRadioButton;
        edProjectName: TEdit;
        Label1: TLabel;
        Procedure ProjViewChange(Sender: TObject; Item: TListItem;
            Change: TItemChange);
        Procedure FormCreate(Sender: TObject);
        Procedure LoadText;
        Procedure FormDestroy(Sender: TObject);
        Procedure TabsMainChange(Sender: TObject);
        Procedure ProjViewDblClick(Sender: TObject);
        Procedure btnCancelClick(Sender: TObject);
        Procedure btnHelpClick(Sender: TObject);
    Private
        Procedure AddTemplate(FileName: String);
        Procedure ReadTemplateIndex;
    Private
        fTemplates: TList;
        Procedure UpdateView;
    Public
        Function GetTemplate: TTemplate;
    End;

Implementation

Uses
{$IFDEF WIN32}
    FileCtrl,
{$ENDIF}
    MultiLangSupport, utils, datamod, devcfg, version, project, prjtypes, hh;
{$R *.dfm}

Procedure TNewProjectForm.FormCreate(Sender: TObject);
Begin
    LoadText;
    TemplateLabel.Font.Color := clNavy;
    fTemplates := TList.Create;
    ReadTemplateIndex;
    edProjectName.Text := format(Lang[ID_NEWPROJECT], [dmMain.GetNumber]);
End;

Procedure TNewProjectForm.FormDestroy(Sender: TObject);
Begin
    fTemplates.Free;
End;

Procedure TNewProjectForm.AddTemplate(FileName: String);
Var
    Template: TTemplate;
Begin
    If Not FileExists(FileName) Then
        exit;
    Template := TTemplate.Create;
    Template.ReadTemplateFile(FileName);
    fTemplates.Add(Template);
End;

Procedure TNewProjectForm.ReadTemplateIndex;
Var
    i: Integer;
    LTemplates: TStringList;
    sDir: String;
Begin
    sDir := devDirs.Templates;
    If Not CheckChangeDir(sDir) Then
    Begin
        MessageDlg('Could not change to the Templates directory (' +
            devDirs.Templates + ')...', mtError, [mbOk], 0);
        Exit;
    End;
    LTemplates := TStringList.Create;
    Try
        Screen.Cursor := crHourGlass;
        Application.ProcessMessages;
        FilesFromWildCard(devDirs.Templates, '*' + TEMPLATE_EXT,
            LTemplates, False, False, True);
        If LTemplates.Count > 0 Then
        Begin
            For i := 0 To pred(LTemplates.Count) Do
                AddTemplate(LTemplates[i]);
            // EAB TODO:* All templates are loaded here.. can we load each one only when actually get's used?
            UpdateView;
        End;
    Finally
        LTemplates.Free;
        Screen.Cursor := crDefault;
    End;
End;

Function TNewProjectForm.GetTemplate: TTemplate;
Var
    Opts: TProjectProfileList;
Begin
    Opts := TProjectProfileList.Create;
    If assigned(ProjView.Selected) Then
    Begin
        result := TTemplate(fTemplates[Integer(ProjView.Selected.Data)]);
        Opts.CopyDataFrom(result.OptionsRec);
    End
    Else
    Begin
        result := TTemplate.Create;
        result.Version := -1;
    End;
    result.ProjectName := edProjectName.Text;
    Opts.useGPP := rbCpp.Checked;
    result.OptionsRec.CopyDataFrom(Opts);
End;

Procedure TNewProjectForm.ProjViewChange(Sender: TObject; Item: TListItem;
    Change: TItemChange);
Var
    LTemplate: TTemplate;
Begin
    If Not assigned(ProjView.Selected) Then
    Begin
        TemplateLabel.Caption := '';
        btnOk.Enabled := False;
    End
    Else
    Begin
        btnOk.Enabled := True;
        LTemplate := TTemplate(fTemplates[Integer(ProjView.Selected.Data)]);
        If Not assigned(LTemplate) Then
            exit;
        TemplateLabel.Caption := LTemplate.Description;

        If LTemplate.OptionsRec.useGPP Then
        Begin
            rbC.Enabled := False;
            rbCpp.Checked := True;
        End
        Else
            rbC.Enabled := True;
    End;
End;

Procedure TNewProjectForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_NP];
    lblDesc.Caption := Lang[ID_NP_DESC];
    lblPrjName.Caption := Lang[ID_NP_PRJNAME];
    rbC.Caption := Lang[ID_NP_DEFAULTC];
    rbCpp.Caption := Lang[ID_NP_DEFAULTCPP];
    cbDefault.Caption := Lang[ID_NP_MAKEDEFAULT];
    Label2.Caption := Lang[ID_NP_PRJOPTIONS];

    btnOk.Caption := Lang[ID_BTN_OK];
    btnCancel.Caption := Lang[ID_BTN_CANCEL];
    btnHelp.Caption := Lang[ID_BTN_HELP];
End;

Procedure TNewProjectForm.UpdateView;
    Function HasPage(Const value: String): Boolean;
    Var
        idx: Integer;
    Begin
        result := True;
        For idx := 0 To pred(TabsMain.Tabs.Count) Do
            If AnsiCompareText(TabsMain.Tabs[idx], Value) = 0 Then
                exit;
        result := False;
    End;
Var
    idx: Integer;
    LTemplate: TTemplate;
    Item: TListItem;
    LIcon: TIcon;
    fName: String;
Begin
    For idx := 0 To pred(fTemplates.Count) Do
    Begin
        LTemplate := TTemplate(fTemplates[idx]);
        If Not HasPage(LTemplate.Catagory) Then
            TabsMain.Tabs.Append(LTemplate.Catagory);
    End;

    ProjView.Items.Clear;
    For idx := pred(ImageList.Count) Downto 6 Do
        ImageList.Delete(idx);

    For idx := 0 To pred(fTemplates.Count) Do
    Begin
        LTemplate := TTemplate(fTemplates[idx]);
        If LTemplate.Catagory = '' Then
            LTemplate.Catagory := Lang[ID_NP_PRJSHEET];
        If AnsiCompareText(LTemplate.Catagory,
            TabsMain.Tabs[TabsMain.TabIndex]) = 0 Then
        Begin
            Item := ProjView.Items.Add;
            Item.Caption := LTemplate.Name;
            Item.Data := pointer(idx);
            fName := ValidateFile(LTemplate.OptionsRec[0].Icon,
                ExtractFilePath(LTemplate.FileName));
            If fName <> '' Then
            Begin
                LIcon := TIcon.Create;
                Try
                    LIcon.LoadFromFile(ExpandFileto(fName,
                        ExtractFilePath(LTemplate.FileName)));
                    Item.ImageIndex := ImageList.AddIcon(LIcon);
                    If Item.ImageIndex = -1 Then
                        Item.ImageIndex := 0;
                Finally
                    LIcon.Free;
                End;
            End
            Else
                Item.ImageIndex := LTemplate.IconIndex;
        End;
    End;
End;

Procedure TNewProjectForm.TabsMainChange(Sender: TObject);
Begin
    UpdateView;
End;

Procedure TNewProjectForm.ProjViewDblClick(Sender: TObject);
Begin
    If assigned(ProjView.Selected) Then
    Begin
        ModalResult := mrOk;
    End;
End;

Procedure TNewProjectForm.btnCancelClick(Sender: TObject);
Begin
    Dec(dmMain.fProjectCount);
End;

Procedure TNewProjectForm.btnHelpClick(Sender: TObject);
Begin
    HelpFile := devDirs.Help + DEV_MAINHELP_FILE;
    HtmlHelp(self.handle, Pchar(HelpFile), HH_DISPLAY_TOPIC,
        DWORD(Pchar('html\creating_project.html')));
    //Application.HelpJump('ID_CREATEPROJECT');
End;

End.
