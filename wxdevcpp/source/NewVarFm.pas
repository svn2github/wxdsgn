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

Unit NewVarFm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ExtCtrls, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QExtCtrls;
{$ENDIF}

Type
    TNewVarForm = Class(TForm)
        Label1: TLabel;
        Label2: TLabel;
        rgScope: TRadioGroup;
        cmbType: TComboBox;
        txtName: TEdit;
        chkReadFunc: TCheckBox;
        chkWriteFunc: TCheckBox;
        Label3: TLabel;
        Label4: TLabel;
        txtReadFunc: TEdit;
        txtWriteFunc: TEdit;
        btnCreate: TButton;
        btnCancel: TButton;
        Label6: TLabel;
        cmbClass: TComboBox;
        GroupBox1: TGroupBox;
        memDescr: TMemo;
        Label7: TLabel;
        cmbComment: TComboBox;
        XPMenu: TXPMenu;
        chkInlineR: TCheckBox;
        chkInlineW: TCheckBox;
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure FormShow(Sender: TObject);
        Procedure cmbTypeChange(Sender: TObject);
        Procedure chkReadFuncClick(Sender: TObject);
        Procedure chkWriteFuncClick(Sender: TObject);
        Procedure btnCreateClick(Sender: TObject);
        Procedure memDescrChange(Sender: TObject);
    Private
        { Private declarations }
        Procedure LoadText;
    Public
        { Public declarations }
    End;

Var
    NewVarForm: TNewVarForm;

Implementation

Uses editor, main, CppParser, MultiLangSupport, devcfg;

{$R *.dfm}

Procedure TNewVarForm.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    Action := caFree;
End;

Procedure TNewVarForm.FormShow(Sender: TObject);
Var
    sl: TStrings;
Begin
    LoadText;
    cmbType.Text := '';
    txtName.Text := '';
    rgScope.ItemIndex := 0;
    chkReadFunc.Checked := False;
    chkWriteFunc.Checked := False;
    txtReadFunc.Text := '';
    txtWriteFunc.Text := '';
    memDescr.Lines.Clear;
    cmbComment.ItemIndex := 2;

    cmbTypeChange(Nil);

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

Procedure TNewVarForm.cmbTypeChange(Sender: TObject);
Begin
    btnCreate.Enabled := cmbType.Text <> '';
    btnCreate.Enabled := btnCreate.Enabled And (txtName.Text <> '');
    If chkReadFunc.Checked Then
        btnCreate.Enabled := btnCreate.Enabled And (txtReadFunc.Text <> '');
    If chkWriteFunc.Checked Then
        btnCreate.Enabled := btnCreate.Enabled And (txtWriteFunc.Text <> '');
End;

Procedure TNewVarForm.chkReadFuncClick(Sender: TObject);
Begin
    If chkReadFunc.Checked Then
    Begin
        If btnCreate.Enabled Then // type and name are ok
            txtReadFunc.Text := 'Get' + txtName.Text
        Else
            chkReadFunc.Checked := False;
    End;
    chkInlineR.Enabled := chkReadFunc.Checked;
    If Not chkInlineR.Enabled Then
        chkInlineR.Checked := False;
End;

Procedure TNewVarForm.chkWriteFuncClick(Sender: TObject);
Begin
    If chkWriteFunc.Checked Then
    Begin
        If btnCreate.Enabled Then // type and name are ok
            txtWriteFunc.Text := 'Set' + txtName.Text
        Else
            chkWriteFunc.Checked := False;
    End;
    chkInlineW.Enabled := chkWriteFunc.Checked;
    If Not chkInlineW.Enabled Then
        chkInlineW.Checked := False;
End;

Procedure TNewVarForm.btnCreateClick(Sender: TObject);
Var
    pID: Integer;
    fName: String;
    CppFname: String;
    I: Integer;
    Line: Integer;
    PublicLine: Integer;
    e: TEditor;
    AddScopeStr: Boolean;
    fAddScopeStr: Boolean;
    VarName: String;
    VarType: String;
    VarRead: Boolean;
    VarReadFunc: String;
    VarWrite: Boolean;
    VarWriteFunc: String;
    VarScope: TStatementClassScope;
    St: PStatement;
    ClsName: String;
    S: String;
Begin
    If cmbClass.ItemIndex = -1 Then
    Begin
        MessageDlg(Lang[ID_NEWVAR_MSG_NOCLASS], mtError, [mbOk], 0);
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
            3:
                VarScope := scsPublished;
        Else
            VarScope := scsPublic;
        End;
        VarRead := chkReadFunc.Checked;
        VarReadFunc := txtReadFunc.Text;
        VarWrite := chkWriteFunc.Checked;
        VarWriteFunc := txtWriteFunc.Text;
        If Trim(memDescr.Text) = '' Then
            memDescr.Text := 'No description';

        CppParser1.GetSourcePair(CppParser1.GetDeclarationFileName(St),
            CppFname, fName);

        If Not FileExists(CppFname) Then
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
        If VarScope <> scsPublic Then
            PublicLine := CppParser1.SuggestMemberInsertionLine(pID,
                scsPublic, fAddScopeStr)
        Else
        Begin
            fAddScopeStr := AddScopeStr;
            PublicLine := Line;
        End;

        If Line = -1 Then
        Begin
            // CppParser could not suggest a line for insertion :(
            MessageDlg(Lang[ID_NEWVAR_MSG_NOLINE], mtError, [mbOk], 0);
            Exit;
        End;

        If Not Assigned(e) Then
            Exit;

        // insert the actual var
        e.Text.Lines.Insert(Line, #9#9 + VarType + ' ' + VarName + ';');

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

        e.GotoLineNr(Line + memDescr.Lines.Count);
        e.Modified := True;

        // if needed, insert a new member function for READ access to the new var
        If VarRead Then
        Begin
            S := #9#9 + VarType + ' ' + VarReadFunc + '()';
            If chkInlineR.Checked Then
            Begin
                e.Text.Lines.Insert(PublicLine, #9#9'}');
                e.Text.Lines.Insert(PublicLine, #9#9#9'return ' + VarName + ';');
                e.Text.Lines.Insert(PublicLine, #9#9'{');
            End
            Else
                S := S + '; // returns the value of ' + VarName;
            e.Text.Lines.Insert(PublicLine, S);
            If fAddScopeStr Then
                e.Text.Lines.Insert(PublicLine, #9'public:');
        End;

        // if needed, insert a new member function for WRITE access to the new var
        If VarWrite Then
        Begin
            S := #9#9'void ' + VarWriteFunc + '(' + VarType + ' x)';
            If chkInlineW.Checked Then
            Begin
                e.Text.Lines.Insert(PublicLine, #9#9'}');
                e.Text.Lines.Insert(PublicLine, #9#9#9 + VarName + ' = x;');
                e.Text.Lines.Insert(PublicLine, #9#9'{');
            End
            Else
                S := S + '; // sets the value of ' + VarName;
            e.Text.Lines.Insert(PublicLine, S);
            If fAddScopeStr Then
                e.Text.Lines.Insert(PublicLine, #9'public:');
        End;

        // set the parent class's name
        ClsName := cmbClass.Text;

        If ((Not VarRead) Or (VarRead And chkInlineR.Checked)) And
            ((Not VarWrite) Or (VarWrite And chkInlineW.Checked)) Then
            Exit;

        e := GetEditorFromFileName(CppFname);
        If Not Assigned(e) Then
            Exit;

        // if needed, insert a new member function for READ access to the new var
        If VarRead And Not chkInlineR.Checked Then
        Begin
            e.Text.Lines.Append('');
            e.Text.Lines.Append('// returns the value of ' + VarName);
            e.Text.Lines.Append(VarType + ' ' + ClsName + '::' + VarReadFunc + '()');
            e.Text.Lines.Append('{');
            e.Text.Lines.Append(#9'return ' + VarName + ';');
            e.Text.Lines.Append('}');
            e.Text.Lines.Append('');
            e.GotoLineNr(e.Text.Lines.Count - 1);
            e.Modified := True;
        End;

        // if needed, insert a new member function for WRITE access to the new var
        If VarWrite And Not chkInlineW.Checked Then
        Begin
            e.Text.Lines.Append('');
            e.Text.Lines.Append('// sets the value of ' + VarName);
            e.Text.Lines.Append('void ' + ClsName + '::' + VarWriteFunc +
                '(' + VarType + ' x)');
            e.Text.Lines.Append('{');
            e.Text.Lines.Append(#9 + VarName + ' = x;');
            e.Text.Lines.Append('}');
            e.Text.Lines.Append('');
            e.GotoLineNr(e.Text.Lines.Count - 1);
            e.Modified := True;
        End;
    End;
    Exit;
End;

Procedure TNewVarForm.memDescrChange(Sender: TObject);
Begin
    If memDescr.Lines.Count > 1 Then
        cmbComment.ItemIndex := 0
    Else
        cmbComment.ItemIndex := 2;
End;

Procedure TNewVarForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_POP_NEWVAR];
    Label1.Caption := Lang[ID_NEWVAR_VARTYPE];
    Label2.Caption := Lang[ID_NEWVAR_VARNAME];
    Label6.Caption := Lang[ID_NEWVAR_IMPLIN];
    rgScope.Caption := Lang[ID_NEWVAR_SCOPE];
    chkReadFunc.Caption := Lang[ID_NEWVAR_CREATEREADFUNC];
    Label3.Caption := Lang[ID_NEWVAR_FUNCNAME];
    chkWriteFunc.Caption := Lang[ID_NEWVAR_CREATEWRITEFUNC];
    Label4.Caption := Lang[ID_NEWVAR_FUNCNAME];
    GroupBox1.Caption := Lang[ID_NEWVAR_COMMENTS];
    Label7.Caption := Lang[ID_NEWVAR_COMMENTSSTYLE];
    btnCreate.Caption := Lang[ID_NEWVAR_BTN_CREATE];
    btnCancel.Caption := Lang[ID_NEWVAR_BTN_CANCEL];
End;

End.
