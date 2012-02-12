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

Unit NewMemberFm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ExtCtrls, CppParser, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QExtCtrls, CppParser;
{$ENDIF}

Type
    TNewMemberForm = Class(TForm)
        Label1: TLabel;
        Label2: TLabel;
        rgScope: TRadioGroup;
        cmbType: TComboBox;
        txtName: TEdit;
        Label3: TLabel;
        txtArguments: TEdit;
        btnCreate: TButton;
        btnCancel: TButton;
        Label4: TLabel;
        cmbClass: TComboBox;
        grpComment: TGroupBox;
        Label7: TLabel;
        memDescr: TMemo;
        cmbComment: TComboBox;
        chkToDo: TCheckBox;
        XPMenu: TXPMenu;
        grpAttr: TGroupBox;
        chkStatic: TCheckBox;
        chkVirtual: TCheckBox;
        chkPure: TCheckBox;
        chkInline: TCheckBox;
        Procedure cmbTypeChange(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure FormShow(Sender: TObject);
        Procedure btnCreateClick(Sender: TObject);
        Procedure memDescrChange(Sender: TObject);
        Procedure chkStaticClick(Sender: TObject);
    Private
        { Private declarations }
        Procedure LoadText;
    Public
        { Public declarations }
    End;

Var
    NewMemberForm: TNewMemberForm;

Implementation

Uses
    editor, main, MultiLangSupport, devcfg;

{$R *.dfm}

Procedure TNewMemberForm.cmbTypeChange(Sender: TObject);
Begin
    btnCreate.Enabled := cmbType.Text <> '';
    btnCreate.Enabled := btnCreate.Enabled And (txtName.Text <> '');
End;

Procedure TNewMemberForm.FormClose(Sender: TObject;
    Var Action: TCloseAction);
Begin
    Action := caFree;
End;

Procedure TNewMemberForm.FormShow(Sender: TObject);
Var
    sl: TStrings;
Begin
    LoadText;
    cmbClass.Text := '';
    cmbType.Text := '';
    txtName.Text := '';
    txtArguments.Text := '';
    chkToDo.Checked := True;
    memDescr.Lines.Clear;
    rgScope.ItemIndex := 2;

    sl := TStringList.Create;
    Try
        MainForm.CppParser1.GetClassesList(sl);
        cmbClass.Items.Assign(sl);
    Finally
        sl.Free;
    End;
    cmbClass.ItemIndex := cmbClass.Items.IndexOf(
        PStatement(MainForm.ClassBrowser1.Selected.Data)^._Command);

    cmbType.SetFocus;
End;

Procedure TNewMemberForm.btnCreateClick(Sender: TObject);
Var
    pID: Integer;
    fName: String;
    CppFname: String;
    I: Integer;
    Line: Integer;
    e: TEditor;
    AddScopeStr: Boolean;
    S: String;
    VarName: String;
    VarType: String;
    VarArguments: String;
    VarScope: TStatementClassScope;
    St: PStatement;
    ClsName: String;
Begin
    If cmbClass.ItemIndex = -1 Then
    Begin
        MessageDlg(Lang[ID_NEWVAR_MSG_NOCLASS], mtError, [mbOk], 0);
        ModalResult := mrNone;
        Exit;
    End;

    If cmbClass.Items.IndexOf(cmbClass.Text) > -1 Then
        St := PStatement(cmbClass.Items.Objects[cmbClass.Items.IndexOf(
            cmbClass.Text)])
    Else
        St := Nil;

    If Not Assigned(St) Then
    Begin
        MessageDlg(Lang[ID_NEWVAR_MSG_NOCLASS], mtError, [mbOk], 0);
        ModalResult := mrNone;
        Exit;
    End;

    With MainForm Do
    Begin
        pID := St^._ID;

        VarName := txtName.Text;
        VarType := cmbType.Text;
        Case rgScope.ItemIndex Of
            0:
                VarScope := scsPrivate;
            1:
                VarScope := scsProtected;
            2:
                VarScope := scsPublic;
        Else
            VarScope := scsPublic;
        End;
        VarArguments := txtArguments.Text;
        If Trim(memDescr.Text) = '' Then
            memDescr.Text := 'No description';

        CppParser1.GetSourcePair(CppParser1.GetDeclarationFileName(St),
            CppFname, fName);

        If Not chkInline.Checked And Not FileExists(CppFname) Then
        Begin
            MessageDlg(Lang[ID_NEWVAR_MSG_NOIMPL], mtError, [mbOk], 0);
            Exit;
        End;

        // if the file is modified, ask to save
        e := GetEditorFromFileName(fName);

        If Not Assigned(e) Then
            Exit;

        If e.Modified Then
            Case MessageDlg(format(Lang[ID_MSG_ASKSAVECLOSE], [fName]),
                    mtConfirmation, [mbYes, mbCancel], 0) Of
                mrYes:
                    If FileExists(fName) Then
                    Begin
                        If devEditor.AppendNewline Then
                            With e.Text Do
                                If Lines.Count > 0 Then
                                    If Lines[Lines.Count - 1] <> '' Then
                                        Lines.Add('');
                        MainForm.SaveFile(e);
                    End
                    Else
                        Exit;
                mrCancel:
                    Exit;
            End;

        // Ask CppParser for insertion line suggestion ;)
        Line := CppParser1.SuggestMemberInsertionLine(pID, VarScope, AddScopeStr);

        If Line = -1 Then
        Begin
            // CppParser could not suggest a line for insertion :(
            MessageDlg(Lang[ID_NEWVAR_MSG_NOLINE], mtError, [mbOk], 0);
            Exit;
        End;

        If Not Assigned(e) Then
            Exit;

        // insert the actual function
        S := #9#9;
        If chkVirtual.Checked Then
            S := S + 'virtual '
        Else
        If chkStatic.Checked Then
            S := S + 'static ';
        S := S + VarType + ' ' + VarName + '(' + VarArguments + ')';
        If chkPure.Checked Then
            S := S + ' = 0L';
        If chkInline.Checked Then
        Begin
            e.Text.Lines.Insert(Line, #9#9'}');
            If chkToDo.Checked Then
                e.Text.Lines.Insert(Line,
                    #9#9#9'/* TODO (#1#): Implement inline function ' + cmbClass.Text +
                    '::' + VarName + '(' + VarArguments + ') */')
            Else
                e.Text.Lines.Insert(Line, #9#9#9'// insert your code here');
            e.Text.Lines.Insert(Line, #9#9'{');
        End
        Else
            S := S + ';';

        e.Text.Lines.Insert(Line, S);

        // insert the comment
        If cmbComment.ItemIndex In [0, 1] Then // /** ... */ or /* ... */
            e.Text.Lines.Insert(Line, #9#9' */');
        For I := memDescr.Lines.Count - 1 Downto 0 Do
            If cmbComment.ItemIndex In [0, 1] Then // /** ... */ or /* ... */
                e.Text.Lines.Insert(Line, #9#9' * ' + memDescr.Lines[I])
            Else
                e.Text.Lines.Insert(Line, #9#9'// ' + memDescr.Lines[I]);
        If cmbComment.ItemIndex = 0 Then // /** ... */
            e.Text.Lines.Insert(Line, #9#9'/**')
        Else
        If cmbComment.ItemIndex = 1 Then // /* ... */
            e.Text.Lines.Insert(Line, #9#9'/*');

        // insert, if needed, the scope string
        If AddScopeStr Then
            Case VarScope Of
                scsPrivate:
                    e.Text.Lines.Insert(Line, #9'private:');
                scsProtected:
                    e.Text.Lines.Insert(Line, #9'protected:');
                scsPublic:
                    e.Text.Lines.Insert(Line, #9'public:');
                scsPublished:
                    e.Text.Lines.Insert(Line, #9'published:');
            End;

        e.GotoLineNr(Line + 1);
        e.Modified := True;

        If chkInline.Checked Or chkPure.Checked Then
            Exit;

        // set the parent class's name
        ClsName := cmbClass.Text;

        e := GetEditorFromFileName(CppFname);
        If Not Assigned(e) Then
            Exit;

        // insert the implementation
        If Trim(e.Text.Lines[e.Text.Lines.Count - 1]) <> '' Then
            e.Text.Lines.Append('');

        // insert the comment
        If cmbComment.ItemIndex = 0 Then // /* ... */
            e.Text.Lines.Append('/*');
        For I := 0 To memDescr.Lines.Count - 1 Do
            If cmbComment.ItemIndex = 0 Then // /* ... */
                e.Text.Lines.Append(' * ' + memDescr.Lines[I])
            Else
                e.Text.Lines.Append('// ' + memDescr.Lines[I]);
        If cmbComment.ItemIndex = 0 Then // /* ... */
            e.Text.Lines.Append(' */');

        e.Text.Lines.Append(VarType + ' ' + ClsName + '::' + VarName +
            '(' + VarArguments + ')');
        e.Text.Lines.Append('{');
        If chkToDo.Checked Then
            e.Text.Lines.Append(#9'/* TODO (#1#): Implement ' +
                ClsName + '::' + VarName + '() */')
        Else
            e.Text.Lines.Append(#9'// insert your code here');
        e.Text.Lines.Append('}');
        e.Text.Lines.Append('');
        e.GotoLineNr(e.Text.Lines.Count - 1);
        e.Modified := True;
    End;
    Exit;
End;

Procedure TNewMemberForm.memDescrChange(Sender: TObject);
Begin
    If memDescr.Lines.Count > 1 Then
        cmbComment.ItemIndex := 0
    Else
        cmbComment.ItemIndex := 2;
End;

Procedure TNewMemberForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_POP_NEWMEMBER];
    Label1.Caption := Lang[ID_NEWVAR_VARTYPE];
    Label2.Caption := Lang[ID_NEWMEMB_MEMBNAME];
    Label3.Caption := Lang[ID_NEWMEMB_ARGS];
    Label4.Caption := Lang[ID_NEWVAR_IMPLIN];
    rgScope.Caption := Lang[ID_NEWVAR_SCOPE];
    grpComment.Caption := Lang[ID_NEWVAR_COMMENTS];
    grpAttr.Caption := Lang[ID_NEWMEMB_ATTRS];
    Label7.Caption := Lang[ID_NEWVAR_COMMENTSSTYLE];
    chkToDo.Caption := Lang[ID_ADDTODO_MENUITEM];
    btnCreate.Caption := Lang[ID_NEWVAR_BTN_CREATE];
    btnCancel.Caption := Lang[ID_NEWVAR_BTN_CANCEL];
End;

Procedure TNewMemberForm.chkStaticClick(Sender: TObject);
Begin
    // disable event
    chkStatic.OnClick := Nil;
    chkVirtual.OnClick := Nil;
    chkPure.OnClick := Nil;
    chkInline.OnClick := Nil;

    If Sender = chkStatic Then
    Begin
        chkInline.Enabled := True;
        If chkStatic.Checked Then
        Begin
            chkVirtual.Checked := False;
            chkPure.Checked := False;
        End;
    End
    Else
    If Sender = chkVirtual Then
    Begin
        chkInline.Enabled := True;
        If Not chkVirtual.Checked Then
            chkPure.Checked := False
        Else
            chkStatic.Checked := False;
    End
    Else
    If Sender = chkPure Then
    Begin
        chkInline.Enabled := Not chkPure.Checked;
        chkInline.Checked := False;
        chkStatic.Checked := False;
        chkVirtual.Checked := True;
    End;

    // re-enable event
    chkStatic.OnClick := chkStaticClick;
    chkVirtual.OnClick := chkStaticClick;
    chkPure.OnClick := chkStaticClick;
    chkInline.OnClick := chkStaticClick;
End;

End.
