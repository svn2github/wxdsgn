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

Unit helpfrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, ComCtrls, Buttons, StdCtrls, Grids, ValEdit, IniFiles, ExtCtrls,
    XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QComCtrls, QButtons, QStdCtrls, QGrids, IniFiles, ExtCtrls
  ;
{$ENDIF}

Type
    TfrmHelpEdit = Class(TForm)
        btnOk: TBitBtn;
        btnCancel: TBitBtn;
        btnHelp: TBitBtn;
        grpOptions: TGroupBox;
        cboIcon: TComboBoxEx;
        lblIcon: TLabel;
        grpMenu: TRadioGroup;
        cbPop: TCheckBox;
        XPMenu: TXPMenu;
        cbSearchWord: TCheckBox;
        cbAffectF1: TCheckBox;
        btnNew: TSpeedButton;
        btnDelete: TSpeedButton;
        btnBrowse: TSpeedButton;
        btnRename: TSpeedButton;
        lvFiles: TListView;
        Procedure cboIconSelect(Sender: TObject);
        Procedure grpMenuClick(Sender: TObject);
        Procedure cbPopClick(Sender: TObject);
        Procedure lvFilesSelectItem(Sender: TObject; Item: TListItem;
            Selected: Boolean);
        Procedure Browse;
        Procedure lvFilesEditing(Sender: TObject; Item: TListItem;
            Var AllowEdit: Boolean);
        Procedure lvFilesEdited(Sender: TObject; Item: TListItem;
            Var S: String);
        Procedure FormCreate(Sender: TObject);
        Procedure lvFilesChange(Sender: TObject; Item: TListItem;
            Change: TItemChange);
        Procedure btnNewClick(Sender: TObject);
        Procedure btnRenameClick(Sender: TObject);
        Procedure btnBrowseClick(Sender: TObject);
        Procedure btnDeleteClick(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure cbSearchWordClick(Sender: TObject);
        Procedure cbAffectF1Click(Sender: TObject);
    Private
        fINI: TINIFile;
        fEditing: Boolean;
        Procedure ReadHelpINI;
        Procedure WriteHelpINI;
        Procedure LoadText;
    Public
        Function Execute: Boolean;
    End;

Implementation

Uses datamod, devcfg, utils, version, MultiLangSupport, DevThemes, ImageTheme;

{$R *.dfm}

Type
    TEntry = Class
        Menu: Byte;
        Icon: Smallint;
        searchword: Boolean;
        affectF1: Boolean;
        pop: Boolean;
    End;

{ TfrmHelpEdit }

Function TfrmHelpEdit.Execute: Boolean;
Begin
    ReadHelpINI;
    cboIcon.Images := devImageThemes.CurrentTheme.HelpImages; //devTheme.Help;
    If lvFiles.Items.Count > 0 Then
        lvFiles.Selected := lvFiles.Items[0];
    lvFilesChange(Self, Nil, ctState);
    result := ShowModal = mrOk;
    If result Then
        WriteHelpINI;
End;

Procedure TfrmHelpEdit.ReadHelpINI;
Var
    hfile: String;
    hfiles: TStringList;
    idx: Integer;
    Item: TListItem;
    Entry: TEntry;
Begin
    hFile := ValidateFile(DEV_HELP_INI, devDirs.Config, True);
    If hFile = '' Then
        exit;
    fini := TINIFile.Create(hFile);
    With fini Do
    Begin
        hFiles := TStringList.Create;
        Try
            ReadSections(hFiles);
            For idx := 0 To pred(hFiles.Count) Do
            Begin
                hFile := ReadString(hFiles[idx], 'Path', '');
                If hFile = '' Then
                    continue;
                If AnsiPos(HTTP, hFile) = 0 Then
                    hFile := ValidateFile(hFile, devDirs.Help);

                If (hFile <> '') Then
                Begin
                    Item := lvFiles.Items.Add;
                    Item.Caption := hFiles[idx];
                    Item.SubItems.Add(hFile);
                    Entry := TEntry.Create;
                    Entry.Menu := ReadInteger(hFiles[idx], 'Menu', 0);
                    Entry.Icon := ReadInteger(hFiles[idx], 'Icon', 0);
                    Entry.Pop := ReadBool(hFiles[idx], 'Pop', False);
                    Entry.SearchWord := ReadBool(hFiles[idx], 'SearchWord', False);
                    Entry.AffectF1 := ReadBool(hFiles[idx], 'AffectF1', False);
                    Item.Data := Entry;
                End;
            End;
        Finally
            hFiles.Free;
        End;
    End;
End;

Procedure TfrmHelpEdit.WriteHelpINI;
Var
    section,
    hFile: String;
    tmp: TStringList;
    idx: Integer;
    Entry: TEntry;
Begin
    //if not DirectoryExists(devDirs.Help) then
    //  CreateDir(devDirs.Help);
    //hFile := ValidateFile(DEV_HELP_INI, devDirs.Help, TRUE);
    hFile := ValidateFile(DEV_HELP_INI, devDirs.Config, True);
    If Not assigned(fINI) Then
        If hFile <> '' Then
            fINI := TINIFile.Create(hFile)
        Else
            fINI := TINIFile.Create(devDirs.Config + DEV_HELP_INI)
    Else
        fINI := TINIFile.Create(devDirs.Config + DEV_HELP_INI);

    If (Not assigned(fIni)) Then
    Begin
        MessageDlg('Coulnd''t create configuration file', mtError, [mbOk], 0);
        exit;
    End;

    tmp := TStringList.Create;
    Try
        fINI.ReadSections(tmp);
        For idx := 0 To tmp.Count - 1 Do
            fINI.EraseSection(tmp[idx]);
    Finally
        tmp.Free;
    End;

    With fini Do
        For idx := 0 To lvFiles.Items.Count - 1 Do
        Begin
            section := lvfiles.Items[idx].Caption;
            //WriteString(section, 'Path', ExtractRelativePath(devDirs.Help, lvFiles.Items[idx].SubItems[0]));
            WriteString(section, 'Path', ExtractRelativePath(devDirs.Config,
                lvFiles.Items[idx].SubItems[0]));
            Entry := TEntry(lvFiles.Items[idx].Data);
            WriteInteger(section, 'Menu', Entry.Menu);
            WriteInteger(section, 'Icon', Entry.Icon);
            WriteBool(section, 'SearchWord', Entry.SearchWord);
            WriteBool(section, 'AffectF1', Entry.AffectF1);
            WriteBool(section, 'Pop', Entry.Pop);
        End;
End;

Procedure TfrmHelpEdit.cboIconSelect(Sender: TObject);
Begin
    If assigned(lvFiles.Selected) Then
        TEntry(lvFiles.Selected.Data).Icon := cboIcon.ItemIndex - 1;
End;

Procedure TfrmHelpEdit.grpMenuClick(Sender: TObject);
Begin
    If assigned(lvFiles.Selected) Then
        TEntry(lvFiles.Selected.Data).Menu := grpMenu.ItemIndex + 1;
End;

Procedure TfrmHelpEdit.cbPopClick(Sender: TObject);
Begin
    If assigned(lvFiles.Selected) Then
        TEntry(lvFiles.Selected.Data).pop := cbPop.Checked;
End;

Procedure TfrmHelpEdit.lvFilesSelectItem(Sender: TObject; Item: TListItem;
    Selected: Boolean);
Begin
    If assigned(Item) Then
        With Item Do
        Begin
            cboIcon.ItemIndex := TEntry(Data).Icon + 1;
            grpMenu.ItemIndex := TEntry(Data).Menu - 1;
            cbPop.Checked := TEntry(Data).pop;
            cbSearchWord.Checked := TEntry(Data).searchword;
            cbAffectF1.Checked := TEntry(Data).affectF1;
        End;
End;

Procedure TfrmHelpEdit.Browse;
Var
    Item: TListItem;
    value: String;
    data: TEntry;
Begin
    With dmMain.OpenDialog Do
    Begin
        Title := Lang[ID_NV_HELPFILE];
        Filter := flt_HELPS;
        InitialDir := ExtractFilePath(GetRealPath(value, devDirs.Help));
        If Execute Then
        Begin
            If assigned(lvFiles.Selected) Then
                Item := lvFiles.Selected
            Else
            Begin
                Item := lvFiles.Items.Add;
                Item.SubItems.Add('');
                Data := TEntry.Create;
                Data.Menu := 0;
                Data.Icon := 0;
                Data.pop := False;
                Data.searchword := False;
                Data.affectF1 := False;
                Item.Data := Data;
                Item.Selected := True;
            End;

            If Item.SubItems.Count <> 0 Then
                Item.SubItems.Add('');

            value := FileName;
            value := ExtractRelativePath(devDirs.Help, value);
            If Item.Caption = '' Then
                Item.Caption := ExtractFilename(value);
            Item.SubItems[0] := value;
        End;
    End;
End;

Procedure TfrmHelpEdit.lvFilesEditing(Sender: TObject; Item: TListItem;
    Var AllowEdit: Boolean);
Begin
    fEditing := True;
End;

Procedure TfrmHelpEdit.lvFilesEdited(Sender: TObject; Item: TListItem;
    Var S: String);
Begin
    fEditing := False;
End;

Procedure TfrmHelpEdit.FormCreate(Sender: TObject);
Begin
    LoadText;
End;

Procedure TfrmHelpEdit.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_HE];
    lvFiles.Columns[0].Caption := Lang[ID_HE_COL1];
    lvFiles.Columns[1].Caption := Lang[ID_HE_COL2];
    lblIcon.Caption := Lang[ID_HE_ICON];
    grpMenu.Caption := Lang[ID_HE_GRP_MENU];
    grpMenu.Items[0] := Lang[ID_HE_SEC1];
    grpMenu.Items[1] := Lang[ID_HE_SEC2];
    cbPop.Caption := Lang[ID_HE_ONPOP];
    cbSearchWord.Caption := Lang[ID_HE_SEARCHWORD];
    cbAffectF1.Caption := Lang[ID_HE_AFFECTF1];
    btnNew.Caption := Lang[ID_BTN_ADD];
    btnRename.Caption := Lang[ID_BTN_RENAME];
    btnBrowse.Caption := Lang[ID_BTN_BROWSE];
    btnDelete.Caption := Lang[ID_BTN_DELETE];

    btnOk.Caption := Lang[ID_BTN_OK];
    btnCancel.Caption := Lang[ID_BTN_CANCEL];
    btnHelp.Caption := Lang[ID_BTN_HELP];
End;

Procedure TfrmHelpEdit.lvFilesChange(Sender: TObject; Item: TListItem;
    Change: TItemChange);
Begin
    btnRename.Enabled := Assigned(lvFiles.Selected);
    btnBrowse.Enabled := Assigned(lvFiles.Selected);
    btnDelete.Enabled := Assigned(lvFiles.Selected);
End;

Procedure TfrmHelpEdit.btnNewClick(Sender: TObject);
Begin
    lvFiles.Selected := Nil;
    Browse;
End;

Procedure TfrmHelpEdit.btnRenameClick(Sender: TObject);
Begin
    If assigned(lvFiles.Selected) Then
        lvFiles.Selected.EditCaption;
End;

Procedure TfrmHelpEdit.btnBrowseClick(Sender: TObject);
Begin
    Browse;
End;

Procedure TfrmHelpEdit.btnDeleteClick(Sender: TObject);
Begin
    If (assigned(lvFiles.Selected)) Then
        lvFiles.Selected.Delete;
End;

Procedure TfrmHelpEdit.FormClose(Sender: TObject;
    Var Action: TCloseAction);
Begin
    If lvFiles.IsEditing Then
    Begin
        lvFiles.Selected.CancelEdit;
        Action := caNone;
    End;
End;

Procedure TfrmHelpEdit.cbSearchWordClick(Sender: TObject);
Begin
    If assigned(lvFiles.Selected) Then
        TEntry(lvFiles.Selected.Data).SearchWord := cbSearchWord.Checked;
End;

Procedure TfrmHelpEdit.cbAffectF1Click(Sender: TObject);
Begin
    If assigned(lvFiles.Selected) Then
        TEntry(lvFiles.Selected.Data).AffectF1 := cbAffectF1.Checked;
End;

End.
