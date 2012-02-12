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

Unit FunctionSearchFm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ExtCtrls, CppParser, ComCtrls, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QExtCtrls, CppParser, QComCtrls;
{$ENDIF}

Type
    TFunctionSearchForm = Class(TForm)
        Panel1: TPanel;
        Label1: TLabel;
        txtSearch: TEdit;
        lvEntries: TListView;
        XPMenu: TXPMenu;
        Procedure FormShow(Sender: TObject);
        Procedure txtSearchChange(Sender: TObject);
        Procedure txtSearchExit(Sender: TObject);
        Procedure txtSearchKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure lvEntriesDblClick(Sender: TObject);
        Procedure lvEntriesCompare(Sender: TObject; Item1, Item2: TListItem;
            Data: Integer; Var Compare: Integer);
        Procedure FormCreate(Sender: TObject);
    Private
        { Private declarations }
        Procedure LoadText;
    Public
        { Public declarations }
        fParser: TCppParser;
        fFileName: TFileName;
    End;

Var
    FunctionSearchForm: TFunctionSearchForm;

Implementation

Uses
{$IFDEF WIN32}
    datamod, MultiLangSupport, devcfg;
{$ENDIF}
{$IFDEF LINUX}
  Xlib, datamod, MultiLangSupport, devcfg;
{$ENDIF}

{$R *.dfm}

Procedure TFunctionSearchForm.FormShow(Sender: TObject);
Begin
    txtSearch.Text := '';
    txtSearchChange(Nil);
End;

Procedure TFunctionSearchForm.txtSearchChange(Sender: TObject);
Var
    I: Integer;
Begin
    If Not Assigned(fParser) Then
        Exit;

    lvEntries.Items.BeginUpdate;
    lvEntries.Items.Clear;

    For I := 0 To fParser.Statements.Count - 1 Do
        If PStatement(fParser.Statements[I])^._Kind = skFunction Then
            If (PStatement(fParser.Statements[I])^._IsDeclaration And
                (AnsiCompareText(PStatement(fParser.Statements[I])^._DeclImplFileName,
                fFilename) = 0)) Or
                (Not PStatement(fParser.Statements[I])^._IsDeclaration And
                (AnsiCompareText(PStatement(fParser.Statements[I])^._FileName,
                fFilename) = 0)) Then
                If (txtSearch.Text = '') Or
                    (AnsiPos(LowerCase(txtSearch.Text),
                    LowerCase(PStatement(fParser.Statements[I])^._ScopelessCmd)) > 0) Then
                Begin
                    With lvEntries.Items.Add Do
                    Begin
                        ImageIndex := -1;
                        Case PStatement(fParser.Statements[I])^._ClassScope Of
                            scsPrivate:
                                StateIndex := 5;
                            scsProtected:
                                StateIndex := 6;
                            scsPublic:
                                StateIndex := 7;
                            scsPublished:
                                StateIndex := 7;
                        End;
                        SubItems.Add(PStatement(fParser.Statements[I])^._Type);
                        SubItems.Add(PStatement(fParser.Statements[I])^._Command);
                        If PStatement(fParser.Statements[I])^._IsDeclaration Then
                            SubItems.Add(
                                IntToStr(PStatement(fParser.Statements[I])^._DeclImplLine))
                        Else
                            SubItems.Add(IntToStr(PStatement(fParser.Statements[I])^._Line));
                        Data := fParser.Statements[I];
                    End;
                End;
    lvEntries.AlphaSort;
    If lvEntries.ItemIndex = -1 Then
        If lvEntries.Items.Count > 0 Then
            lvEntries.ItemIndex := 0;
    lvEntries.Items.EndUpdate;

    // without this, the user has to press the down arrow twice to
    // move down the listview entries (only the first time!)...
{$IFDEF WIN32}
    lvEntries.Perform(WM_KEYDOWN, VK_DOWN, 0);
{$ENDIF}
{$IFDEF LINUX}
  lvEntries.Perform(WM_KEYDOWN, XK_DOWN, 0);
{$ENDIF}
End;

Procedure TFunctionSearchForm.txtSearchExit(Sender: TObject);
Begin
    txtSearch.SetFocus;
    txtSearch.SelStart := Length(txtSearch.Text);
End;

Procedure TFunctionSearchForm.txtSearchKeyDown(Sender: TObject;
    Var Key: Word; Shift: TShiftState);
Begin
    If lvEntries = Nil Then
        Exit;

    Case Key Of
{$IFDEF WIN32}
        VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT:
        Begin
{$ENDIF}
{$IFDEF LINUX}
    XK_UP, XK_DOWN, XK_PRIOR, XK_NEXT: begin
{$ENDIF}
            lvEntries.Perform(WM_KEYDOWN, Key, 0);
            Key := 0;
        End;
{$IFDEF WIN32}
        VK_ESCAPE:
            ModalResult := mrCancel;
        VK_RETURN:
            If lvEntries.Selected <> Nil Then
                ModalResult := mrOK;
{$ENDIF}
{$IFDEF LINUX}
    XK_ESCAPE: ModalResult := mrCancel;
    XK_RETURN: if lvEntries.Selected <> nil then ModalResult := mrOK;
{$ENDIF}
    End;
End;

Procedure TFunctionSearchForm.lvEntriesDblClick(Sender: TObject);
Begin
    If lvEntries.Selected <> Nil Then
        ModalResult := mrOK;
End;

Procedure TFunctionSearchForm.lvEntriesCompare(Sender: TObject; Item1,
    Item2: TListItem; Data: Integer; Var Compare: Integer);
Begin
    Compare := AnsiCompareText(Item1.SubItems[1], Item2.SubItems[1]);
End;

Procedure TFunctionSearchForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := StringReplace(Lang[ID_ITEM_GOTOFUNCTION], '&', '', []);
    Label1.Caption := Lang[ID_GF_TEXT];
    lvEntries.Column[1].Caption := Lang[ID_GF_TYPE];
    lvEntries.Column[2].Caption := Lang[ID_GF_FUNCTION];
    lvEntries.Column[3].Caption := Lang[ID_GF_LINE];
End;

Procedure TFunctionSearchForm.FormCreate(Sender: TObject);
Begin
    LoadText;
End;

End.
