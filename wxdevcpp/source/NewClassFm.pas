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

Unit NewClassFm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, Buttons, XPMenu, OpenSaveDialogs;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QButtons;
{$ENDIF}

Type
    TNewClassForm = Class(TForm)
        Label1: TLabel;
        txtName: TEdit;
        GroupBox1: TGroupBox;
        Label2: TLabel;
        Label3: TLabel;
        cmbClass: TComboBox;
        Label4: TLabel;
        txtCppFile: TEdit;
        Label5: TLabel;
        txtHFile: TEdit;
        btnBrowseCpp: TSpeedButton;
        btnBrowseH: TSpeedButton;
        chkAddToProject: TCheckBox;
        btnCreate: TButton;
        btnCancel: TButton;
        cmbScope: TComboBox;
        chkInherit: TCheckBox;
        Label6: TLabel;
        txtIncFile: TEdit;
        GroupBox2: TGroupBox;
        Label8: TLabel;
        memDescr: TMemo;
        cmbComment: TComboBox;
        Label9: TLabel;
        txtArgs: TEdit;
        XPMenu: TXPMenu;
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure FormShow(Sender: TObject);
        Procedure chkInheritClick(Sender: TObject);
        Procedure txtNameChange(Sender: TObject);
        Procedure txtCppFileChange(Sender: TObject);
        Procedure btnBrowseCppClick(Sender: TObject);
        Procedure btnCreateClick(Sender: TObject);
        Procedure cmbClassChange(Sender: TObject);
        Procedure memDescrChange(Sender: TObject);
        Procedure txtNameKeyPress(Sender: TObject; Var Key: Char);
        Procedure FormCreate(Sender: TObject);
    Private
        { Private declarations }
        SaveDialog1: TSaveDialogEx;
        Procedure LoadText;
    Public
        { Public declarations }
    End;

Var
    NewClassForm: TNewClassForm;

Implementation

Uses
    main, CppParser, MultiLangSupport, version, editor, devcfg;

{$R *.dfm}

Procedure TNewClassForm.FormClose(Sender: TObject;
    Var Action: TCloseAction);
Begin
    Action := caFree;
End;

Procedure TNewClassForm.FormShow(Sender: TObject);
Var
    sl: TStrings;
Begin
    LoadText;
    txtName.Text := '';
    txtArgs.Text := '';

    cmbScope.ItemIndex := 2;
    sl := TStringList.Create;
    Try
        MainForm.CppParser1.GetClassesList(sl);
        cmbClass.Items.Assign(sl);
    Finally
        sl.Free;
    End;
    If Assigned(MainForm.ClassBrowser1.Selected) And
        (MainForm.ClassBrowser1.IsNodeAFolder(MainForm.ClassBrowser1.Selected) =
        False) And (PStatement(MainForm.ClassBrowser1.Selected.Data)^._Kind =
        skClass) Then
    Begin
        cmbClass.ItemIndex := cmbClass.Items.IndexOf(
            PStatement(MainForm.ClassBrowser1.Selected.Data)^._Command);
        chkInherit.Checked := True;
    End
    Else
    Begin
        cmbClass.Text := '';
        chkInherit.Checked := False;
    End;

    txtIncFile.Text := '';
    txtCppFile.Text := '';
    txtHFile.Text := '';
    chkAddToProject.Checked := True;

    memDescr.Lines.Clear;
    cmbComment.ItemIndex := 1;

    chkInheritClick(Nil);
    txtNameChange(Nil);
    cmbClassChange(Nil);
    txtName.SetFocus;
End;

Procedure TNewClassForm.chkInheritClick(Sender: TObject);
Begin
    cmbScope.Enabled := chkInherit.Checked;
    cmbClass.Enabled := chkInherit.Checked;
End;

Procedure TNewClassForm.txtNameChange(Sender: TObject);
Begin
    If txtName.Text <> '' Then
    Begin
        txtCppFile.Text := MainForm.fProject.Directory +
            LowerCase(txtName.Text) + '.cpp';
        txtHFile.Text := MainForm.fProject.Directory +
            LowerCase(txtName.Text) + '.h';
    End
    Else
    Begin
        txtCppFile.Text := '';
        txtHFile.Text := '';
    End;
    btnCreate.Enabled := (txtName.Text <> '') And
        (txtCppFile.Text <> '') And
        (txtHFile.Text <> '');
End;

Procedure TNewClassForm.txtCppFileChange(Sender: TObject);
Begin
    btnCreate.Enabled := (txtName.Text <> '') And
        (txtCppFile.Text <> '') And
        (txtHFile.Text <> '');
End;

Procedure TNewClassForm.btnBrowseCppClick(Sender: TObject);
Begin
    SaveDialog1.Create(MainForm);
    If Sender = btnBrowseCpp Then
    Begin
        SaveDialog1.FileName := ExtractFileName(txtCppFile.Text);
        SaveDialog1.InitialDir := ExtractFilePath(txtCppFile.Text);
        SaveDialog1.Filter := FLT_CPPS;
        SaveDialog1.DefaultExt := 'cpp';
    End
    Else
    Begin
        SaveDialog1.FileName := ExtractFileName(txtHFile.Text);
        SaveDialog1.InitialDir := ExtractFilePath(txtHFile.Text);
        SaveDialog1.Filter := FLT_HEADS;
        SaveDialog1.DefaultExt := 'h';
    End;
    If SaveDialog1.Execute Then
    Begin
        If Sender = btnBrowseCpp Then
            txtCppFile.Text := SaveDialog1.FileName
        Else
            txtHFile.Text := SaveDialog1.FileName;
    End;
End;

Procedure TNewClassForm.btnCreateClick(Sender: TObject);
Var
    idx: Integer;
    I: Integer;
    e: TEditor;
    S: String;
    hfName: String;
    hFile: Integer;
    st: PStatement;
Begin
    // HEADER FILE IMPLEMENTATION
    If chkAddToProject.Checked Then
    Begin
        idx := MainForm.fProject.NewUnit(False, txtHFile.Text);
        e := MainForm.fProject.OpenUnit(idx);
        If idx = -1 Then
        Begin
            MessageDlg('Cannot add header file to project...', mtError, [mbOk], 0);
            Exit;
        End;
    End
    Else
    Begin
        hFile := FileCreate(txtHFile.Text);
        If hFile > 0 Then
        Begin
            FileClose(hFile);
            e := MainForm.GetEditorFromFileName(txtHFile.Text);
        End
        Else
        Begin
            MessageDlg('Cannot create header file...', mtError, [mbOk], 0);
            Exit;
        End;
    End;

    If Not Assigned(e) Then
    Begin
        MessageDlg('Cannot open header file in editor...', mtError, [mbOk], 0);
        Exit;
    End;

    hfName := UpperCase(ExtractFileName(txtHFile.Text));
    hfName := StringReplace(hfName, '.', '_', [rfReplaceAll]);
    hfName := StringReplace(hfName, ' ', '_', [rfReplaceAll]);

    e.Text.Lines.Append(
        '// Class automatically generated by Dev-C++ New Class wizard');
    e.Text.Lines.Append('');
    e.Text.Lines.Append('#ifndef ' + hfName);
    e.Text.Lines.Append('#define ' + hfName);
    e.Text.Lines.Append('');
    If chkInherit.Checked And (txtIncFile.Text <> '') Then
    Begin
        st := Nil;
        For idx := 0 To MainForm.CppParser1.Statements.Count - 1 Do
        Begin
            st := MainForm.CppParser1.Statements[idx];
            If (st^._Kind = skClass) And (st^._ScopelessCmd = cmbClass.Text) And
                (MainForm.fProject.Units.Indexof(
                MainForm.CppParser1.GetDeclarationFileName(st)) <> -1) Then
                Break;
            st := Nil;
        End;
        If Assigned(st) Then
            e.Text.Lines.Append('#include "' +
                txtIncFile.Text + '" // inheriting class''s header file')
        Else
            e.Text.Lines.Append('#include <' +
                txtIncFile.Text + '> // inheriting class''s header file');
        e.Text.Lines.Append('');
    End;
    S := 'class ' + txtName.Text;
    If chkInherit.Checked And (cmbClass.Text <> '') Then
        S := S + ' : ' + cmbScope.Text + ' ' + cmbClass.Text;

    // insert the comment
    If Trim(memDescr.Text) = '' Then
        memDescr.Text := 'No description';
    If cmbComment.ItemIndex = 0 Then // /** ... */
        e.Text.Lines.Append('/**')
    Else
    If cmbComment.ItemIndex = 1 Then // /* ... */
        e.Text.Lines.Append('/*');
    For I := 0 To memDescr.Lines.Count - 1 Do
        If cmbComment.ItemIndex In [0, 1] Then // /** ... */ or /* ... */
            e.Text.Lines.Append(' * ' + memDescr.Lines[I])
        Else
            e.Text.Lines.Append('// ' + memDescr.Lines[I]);
    If cmbComment.ItemIndex In [0, 1] Then // /** ... */ or /* ... */
        e.Text.Lines.Append(' */');

    e.Text.Lines.Append(S);
    e.Text.Lines.Append('{');
    e.Text.Lines.Append(#9'public:');
    e.Text.Lines.Append(#9#9'// class constructor');
    e.Text.Lines.Append(#9#9 + txtName.Text + '(' + txtArgs.Text + ');');
    e.Text.Lines.Append(#9#9'// class destructor');
    e.Text.Lines.Append(#9#9'~' + txtName.Text + '();');
    e.Text.Lines.Append('};');
    e.Text.Lines.Append('');
    e.Text.Lines.Append('#endif // ' + hfName);
    e.Text.Lines.Append('');

    e.Modified := True;

    // CPP FILE IMPLEMENTATION
    If chkAddToProject.Checked Then
    Begin
        idx := MainForm.fProject.NewUnit(False, txtCppFile.Text);
        e := MainForm.fProject.OpenUnit(idx);
        If idx = -1 Then
        Begin
            MessageDlg('Cannot add implementation file to project...',
                mtError, [mbOk], 0);
            Exit;
        End;
    End
    Else
    Begin
        hFile := FileCreate(txtCppFile.Text);
        If hFile > 0 Then
        Begin
            FileClose(hFile);
            e := MainForm.GetEditorFromFileName(txtCppFile.Text);
        End
        Else
        Begin
            MessageDlg('Cannot create implementation file...', mtError, [mbOk], 0);
            Exit;
        End;
    End;

    If Not Assigned(e) Then
    Begin
        MessageDlg('Cannot open implementation file in editor...',
            mtError, [mbOk], 0);
        Exit;
    End;

    e.Text.Lines.Append(
        '// Class automatically generated by Dev-C++ New Class wizard');
    e.Text.Lines.Append('');
    e.Text.Lines.Append('#include "' +
        ExtractFileName(txtHFile.Text) + '" // class''s header file');
    e.Text.Lines.Append('');
    e.Text.Lines.Append('// class constructor');
    e.Text.Lines.Append(txtName.Text + '::' + txtName.Text + '(' +
        txtArgs.Text + ')');
    e.Text.Lines.Append('{');
    e.Text.Lines.Append(#9'// insert your code here');
    e.Text.Lines.Append('}');
    e.Text.Lines.Append('');
    e.Text.Lines.Append('// class destructor');
    e.Text.Lines.Append(txtName.Text + '::~' + txtName.Text + '()');
    e.Text.Lines.Append('{');
    e.Text.Lines.Append(#9'// insert your code here');
    e.Text.Lines.Append('}');
    e.Text.Lines.Append('');

    e.Modified := True;
End;

Procedure TNewClassForm.cmbClassChange(Sender: TObject);
Var
    st: PStatement;
Begin
    If cmbClass.Items.IndexOf(cmbClass.Text) <> -1 Then
    Begin
        st := PStatement(cmbClass.Items.Objects[cmbClass.Items.IndexOf(
            cmbClass.Text)]);
        If Assigned(st) Then
            txtIncFile.Text := ExtractFileName(
                MainForm.CppParser1.GetDeclarationFileName(st))
        Else
            txtIncFile.Text := LowerCase(cmbClass.Text) + '.h';
    End
    Else
    Begin
        If cmbClass.Text <> '' Then
            txtIncFile.Text := LowerCase(cmbClass.Text) + '.h'
        Else
            txtIncFile.Text := '';
    End;
End;

Procedure TNewClassForm.memDescrChange(Sender: TObject);
Begin
  { ???
    if memDescr.Lines.Count > 1 then
      cmbComment.ItemIndex := 0
    else
      cmbComment.ItemIndex := 1; }
End;

Procedure TNewClassForm.txtNameKeyPress(Sender: TObject; Var Key: Char);
Begin
    If Not (Key In ['_', 'a'..'z', 'A'..'Z', '0'..'9', #1..#31]) Then
    Begin
        Key := #0;
        Abort;
    End;
End;

Procedure TNewClassForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_POP_NEWCLASS];
    Label1.Caption := Lang[ID_NEWCLASS_NAME];
    Label9.Caption := Lang[ID_NEWMEMB_ARGS];
    chkInherit.Caption := Lang[ID_NEWCLASS_INHERIT];
    GroupBox1.Caption := Lang[ID_NEWCLASS_INHERITANCE];
    Label2.Caption := Lang[ID_NEWVAR_SCOPE] + ':';
    Label3.Caption := Lang[ID_NEWCLASS_INHERIT_FROM];
    Label6.Caption := Lang[ID_NEWCLASS_INHERIT_HDR];
    Label4.Caption := Lang[ID_NEWCLASS_CPPFILE];
    Label5.Caption := Lang[ID_NEWCLASS_HFILE];
    chkAddToProject.Caption := Lang[ID_NEWCLASS_ADDTOPROJ];
    GroupBox2.Caption := Lang[ID_NEWVAR_COMMENTS];
    Label8.Caption := Lang[ID_NEWVAR_COMMENTSSTYLE];
    btnCreate.Caption := Lang[ID_NEWVAR_BTN_CREATE];
    btnCancel.Caption := Lang[ID_NEWVAR_BTN_CANCEL];
End;

Procedure TNewClassForm.FormCreate(Sender: TObject);
Begin
    SaveDialog1 := TSaveDialogEx.Create(MainForm);
End;

End.
