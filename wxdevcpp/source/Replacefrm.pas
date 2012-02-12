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

Unit Replacefrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
    SynEdit, StdCtrls, SynEditTypes, XPMenu, ExtCtrls;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms,
  QSynEdit, QStdCtrls, QSynEditTypes;
{$ENDIF}

Type
    TfrmReplace = Class(TForm)
        cboFindText: TComboBox;
        grpOptions: TGroupBox;
        lblFind: TLabel;
        btnReplace: TButton;
        btnCancel: TButton;
        cbMatchCase: TCheckBox;
        cbWholeWord: TCheckBox;
        lblReplace: TLabel;
        cboReplaceText: TComboBox;
        cbPrompt: TCheckBox;
        btnReplaceAll: TButton;
        XPMenu: TXPMenu;
        lblLookIn: TLabel;
        LookIn: TComboBox;
        cbRegex: TCheckBox;
        grpOrigin: TRadioGroup;
        grpDirection: TRadioGroup;
        cbUseSelection: TCheckBox;
        Procedure btnReplaceClick(Sender: TObject);
        Procedure FormShow(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure btnCancelClick(Sender: TObject);

    Private
        fSearchOptions: TSynSearchOptions;
        fClose: Boolean;
        fRegex: Boolean;
        Procedure LoadText;

    Public
        UseSelection: Boolean;
        Property SearchOptions: TSynSearchOptions
            Read fSearchOptions Write fSearchOptions;
        Property Regex: Boolean Read fRegex Write fRegex;
    End;

Var
    frmReplace: TfrmReplace;

Implementation

{$R *.dfm}

Uses
    Search_Center,
{$IFDEF WIN32}
    Dialogs, MultiLangSupport, devcfg;
{$ENDIF}
{$IFDEF LINUX}
  QDialogs, MultiLangSupport, devcfg;
{$ENDIF}

Procedure TfrmReplace.btnReplaceClick(Sender: TObject);
Begin
    If cboFindText.Text <> '' Then
    Begin
        fSearchOptions := [];
        Regex := cbRegex.Checked;
        If cboFindText.Items.Indexof(cboFindText.Text) = -1 Then
            cboFindText.Items.Add(cboFindText.Text);

        If cboReplaceText.Items.IndexOf(cboReplaceText.Text) = -1 Then
            cboReplaceText.Items.Add(cboReplaceText.Text);

        If modalResult = mrOk Then
            fSearchOptions := [ssoReplace]
        Else
        If ModalResult = mrAll Then
            fSearchOptions := [ssoReplaceAll];

        If cbPrompt.Checked Then
            include(fSearchoptions, ssoPrompt);

        If cbMatchCase.checked Then
            include(fSearchOptions, ssoMatchCase);

        If cbWholeWord.Checked Then
            include(fSearchOptions, ssoWholeWord);

        If grpDirection.ItemIndex = 1 Then
            include(fSearchOptions, ssoBackwards);

        If TLookIn(LookIn.Items.Objects[LookIn.ItemIndex]) = liSelected Then
            include(fSearchOptions, ssoSelectedOnly);

        If grpOrigin.ItemIndex = 1 Then
            include(fSearchOptions, ssoEntireScope);

        UseSelection := cbUseSelection.Checked;

        fClose := True;
    End;
End;

Procedure TfrmReplace.FormShow(Sender: TObject);
Begin
    ActiveControl := cboFindText;
    LoadText;
End;

Procedure TfrmReplace.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    If fClose Then
        action := caHide
    Else
    Begin
        Action := caNone;
        ActiveControl := cboFindText;
    End;
End;

Procedure TfrmReplace.btnCancelClick(Sender: TObject);
Begin
    fClose := True;
    Close;
End;

Procedure TfrmReplace.LoadText;
Var
    x: Integer;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_RPLC];
    LookIn.Items[0] := Lang[ID_RPLC_SELONLY];

    lblFind.Caption := Lang[ID_RPLC_FINDTEXT];
    lblReplace.Caption := Lang[ID_RPLC_REPLACETEXT];

    grpOptions.Caption := Lang[ID_RPLC_GRP_OPTIONS];
    cbMatchCase.Caption := Lang[ID_RPLC_CASE];
    cbWholeWord.Caption := Lang[ID_RPLC_WHOLEWORD];
    cbPrompt.Caption := Lang[ID_RPLC_PROMPT];

    grpDirection.Caption := Lang[ID_RPLC_GRP_DIRECTION];
    grpDirection.Items[0] := Lang[ID_RPLC_FORWARD];
    grpDirection.Items[1] := Lang[ID_RPLC_BACKWARD];

    grpOrigin.Caption := Lang[ID_RPLC_GRP_ORIGIN];
    grpOrigin.Items[0] := Lang[ID_RPLC_CURSOR];
    grpOrigin.Items[1] := Lang[ID_RPLC_ENTIRE];

    btnReplace.Caption := Lang[ID_BTN_REPLACE];
    btnCancel.Caption := Lang[ID_BTN_CANCEL];
    btnReplaceAll.Caption := Lang[ID_BTN_REPLACEALL];

    x := Self.Canvas.TextWidth(btnReplace.Caption) + 5;
    If x > btnReplace.Width Then
    Begin
        btnReplace.Width := x;
        btnReplaceAll.Left := btnReplace.Left + btnReplace.Width + 6;
    End;

    x := Self.Canvas.TextWidth(btnReplaceAll.Caption) + 5;
    If x > btnReplaceAll.Width Then
        btnReplaceAll.Width := x;

    x := Self.Canvas.TextWidth(btnCancel.Caption) + 5;
    If x > btnCancel.Width Then
    Begin
        btnCancel.Left := btnCancel.Left - ((x - btnCancel.Width) + 10);
        btnCancel.Width := x;
    End;
End;

End.
