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

Unit AddToDoFm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, Spin, SynEditTextBuffer, SynEditTypes, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QComCtrls, QSynEditTextBuffer, QSynEditTypes;
{$ENDIF}

Type
    TAddToDoForm = Class(TForm)
        Label1: TLabel;
        memDescr: TMemo;
        Label2: TLabel;
        Label3: TLabel;
        spnPri: TSpinEdit;
        btnOK: TButton;
        btnCancel: TButton;
        txtUser: TEdit;
        XPMenu: TXPMenu;
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure btnOKClick(Sender: TObject);
        Procedure FormShow(Sender: TObject);
        Procedure txtUserKeyPress(Sender: TObject; Var Key: Char);
    Private
        { Private declarations }
        Procedure LoadText;
    Public
        { Public declarations }
    End;

Var
    AddToDoForm: TAddToDoForm;

Implementation

Uses
    main, editor, MultiLangSupport, devcfg;

{$R *.dfm}

Procedure TAddToDoForm.FormClose(Sender: TObject;
    Var Action: TCloseAction);
Begin
    Action := caFree;
End;

Procedure TAddToDoForm.btnOKClick(Sender: TObject);
Var
    e: TEditor;
    I: Integer;
    st: TBufferCoord;
    Line: Integer;
    LineText: String;
    Hdr: String;
    Prepend: String;
Begin
    e := MainForm.GetEditor;
    If Not Assigned(e) Then
    Begin
        Close;
        Exit;
    End;

    Line := e.Text.CaretY - 1;
    LineText := e.Text.Lines[Line];
    st.Line := Line + 1;
    st.Char := 1;

    I := 1;
    While (I <= Length(LineText)) And (LineText[I] In [#9, ' ']) Do
        Inc(I);
    Prepend := Copy(LineText, 1, I - 1);

    Hdr := '/* TODO (';
    If txtUser.Text <> '' Then
        Hdr := Hdr + txtUser.Text;
    Hdr := Hdr + '#' + IntToStr(spnPri.Value) + '#): ';

    If memDescr.Lines.Count = 1 Then
        e.Text.Lines.Insert(Line, Prepend + Hdr + memDescr.Text + ' */')
    Else
    Begin
        e.Text.Lines.Insert(Line, Prepend + Hdr + memDescr.Lines[0]);
        Prepend := Prepend + StringOfChar(#32, Length(Hdr));
        For I := 1 To memDescr.Lines.Count - 1 Do
        Begin
            If I = memDescr.Lines.Count - 1 Then
                e.Text.Lines.Insert(Line + I, Prepend + memDescr.Lines[I] + ' */')
            Else
                e.Text.Lines.Insert(Line + I, Prepend + memDescr.Lines[I]);
        End;
    End;
    e.Text.UndoList.AddChange(crInsert, st, BufferCoord(st.Char,
        st.Line + memDescr.Lines.Count), '', smNormal);
    e.Modified := True;
    Close;
End;

Procedure TAddToDoForm.FormShow(Sender: TObject);
Begin
    LoadText;
    memDescr.Clear;
    spnPri.Value := 0;
    txtUser.Clear;
End;

Procedure TAddToDoForm.txtUserKeyPress(Sender: TObject; Var Key: Char);
Begin
    If Not (Key In ['a'..'z', 'A'..'Z', '0'..'9', '_', ' ', #8, #13, #27]) Then
    Begin
        Key := #0;
        Exit;
    End;
End;

Procedure TAddToDoForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Label1.Caption := Lang[ID_ADDTODO_DESCRIPTION] + ':';
    Label2.Caption := Lang[ID_ADDTODO_PRIORITY] + ':';
    Label3.Caption := Lang[ID_ADDTODO_USER] + ':';
    btnOk.Caption := Lang[ID_BTN_OK];
    btnCancel.Caption := Lang[ID_BTN_CANCEL];
End;

End.
