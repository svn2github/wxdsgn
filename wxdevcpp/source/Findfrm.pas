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

Unit Findfrm;

Interface

Uses
    Search_Center, StrUtils,
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
    SynEdit, StdCtrls, devTabs, SynEditTypes, XPMenu, ExtCtrls, Menus;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms,
  QSynEdit, QStdCtrls, devTabs, QSynEditTypes;
{$ENDIF}

Type
    TfrmFind = Class(TForm)
        btnFind: TButton;
        btnCancel: TButton;
        lblFind: TLabel;
        cboFindText: TComboBox;
        grpOptions: TGroupBox;
        cbMatchCase: TCheckBox;
        cbWholeWord: TCheckBox;
        cbRegex: TCheckBox;
        grpOrigin: TRadioGroup;
        lblLookIn: TLabel;
        LookIn: TComboBox;
        grpDirection: TRadioGroup;
        mnuBuild: TPopupMenu;
        OneChar: TMenuItem;
        ZeroChars: TMenuItem;
        MoreOneChars: TMenuItem;
        N1: TMenuItem;
        BegLine: TMenuItem;
        EndLine: TMenuItem;
        CharRange: TMenuItem;
        CharNotRange: TMenuItem;
        N2: TMenuItem;
        Tagged: TMenuItem;
        orExp: TMenuItem;
        N3: TMenuItem;
        Newline: TMenuItem;
        WNonalphanumericcharacters1: TMenuItem;
        dDigit1: TMenuItem;
        DNonnumericcharacters1: TMenuItem;
        sWhitespacetnrf1: TMenuItem;
        SNonwhitespacetnrf1: TMenuItem;
        ZeroorOneCharacter1: TMenuItem;
        XPMenu: TXPMenu;
        Procedure btnFindClick(Sender: TObject);
        Procedure FormShow(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure btnCancelClick(Sender: TObject);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure LookInChange(Sender: TObject);
        Procedure OnBuildExpr(Sender: TObject);
    Private
        fSearchOptions: TSynSearchOptions;
        fClose: Boolean;
        fFindAll: Boolean;
        fRegex: Boolean;

        Procedure LoadText;
        Function GetFindWhat: TLookIn;

    Public
        Property SearchOptions: TSynSearchOptions Read fSearchOptions;
        Property FindAll: Boolean Read fFindAll Write fFindAll;
        Property FindWhat: TLookIn Read GetFindWhat;
        Property Regex: Boolean Read fRegex Write fRegex;
    End;

Var
    frmFind: TfrmFind;

Implementation

Uses
    typinfo,
{$IFDEF WIN32}
    Main, Dialogs, MultiLangSupport, devcfg;
{$ENDIF}
{$IFDEF LINUX}
  Xlib, Main, QDialogs, MultiLangSupport, devcfg;
{$ENDIF}

{$R *.dfm}

Function TfrmFind.GetFindWhat: TLookIn;
Begin
    Result := TLookIn(LookIn.Items.Objects[LookIn.ItemIndex]);
End;

Procedure TfrmFind.FormShow(Sender: TObject);
Begin
    LoadText;
    ActiveControl := cboFindText;
    LookIn.Items.Clear;

    //What sorta search types can we allow?
    If SearchCenter.PageControl.PageCount > 0 Then
    Begin
        LookIn.AddItem(Lang[ID_FIND_SELONLY], TObject(liSelected));
        LookIn.AddItem('Current File', TObject(liFile));
        If Not fFindAll Then
            LookIn.ItemIndex := 1;
    End;

    //Insert the Open Files category
    If SearchCenter.PageControl.PageCount > 0 Then
        LookIn.AddItem(Lang[ID_FIND_OPENFILES], TObject(liOpen));

    //And the Current Project category
    If Assigned(SearchCenter.Project) Then
        LookIn.AddItem(Lang[ID_FIND_PRJFILES], TObject(liProject));

    //Set the correct find type for our search
    If fFindAll Then
        LookIn.ItemIndex := LookIn.Items.Count - 1;

    //Enable or disable the extended search options
    LookIn.OnChange(LookIn);
End;

Procedure TfrmFind.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    If fClose Then
        Action := caHide
    Else
    Begin
        Action := caNone;
        ActiveControl := cboFindText;
    End;
End;

Procedure TfrmFind.btnFindClick(Sender: TObject);
Begin
    If cboFindText.Text <> '' Then
    Begin
        If cboFindText.Items.IndexOf(cboFindText.Text) = -1 Then
            cboFindText.Items.Insert(0, cboFindText.Text);

        fSearchOptions := [];

        fRegex := cbRegex.Checked;
        If cbMatchCase.checked Then
            include(fSearchOptions, ssoMatchCase);
        If cbWholeWord.Checked Then
            include(fSearchOptions, ssoWholeWord);

        If TLookIn(LookIn.Items.Objects[LookIn.ItemIndex]) In
            [liSelected, liFile] Then
        Begin
            fFindAll := False;
            If TLookIn(LookIn.Items.Objects[LookIn.ItemIndex]) = liSelected Then
                include(fSearchOptions, ssoSelectedOnly);
            If grpDirection.ItemIndex = 1 Then
                include(fSearchOptions, ssoBackwards);
            If grpOrigin.ItemIndex = 1 Then
                include(fSearchOptions, ssoEntireScope);
        End
        Else
        Begin
            fFindAll := True;
            MainForm.FindOutput.Items.Clear;
            include(fSearchOptions, ssoEntireScope);
            include(fSearchOptions, ssoReplaceAll);
            include(fSearchOptions, ssoPrompt);
        End;
        fClose := True;
    End;
End;

Procedure TfrmFind.btnCancelClick(Sender: TObject);
Begin
    fClose := True;
    Close;
End;

Procedure TfrmFind.LoadText;
Var
    x: Integer;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_FIND];

    //controls
    lblFind.Caption := Lang[ID_FIND_TEXT];
    grpOptions.Caption := Lang[ID_FIND_GRP_OPTIONS];
    cbMatchCase.Caption := Lang[ID_FIND_CASE];
    cbWholeWord.Caption := Lang[ID_FIND_WWORD];

    grpOrigin.Caption := Lang[ID_FIND_GRP_ORIGIN];
    grpOrigin.Items[0] := Lang[ID_FIND_CURSOR];
    grpOrigin.Items[1] := Lang[ID_FIND_ENTIRE];

    grpDirection.Caption := Lang[ID_FIND_GRP_DIRECTION];
    grpDirection.Items[0] := Lang[ID_FIND_FORE];
    grpDirection.Items[1] := Lang[ID_FIND_BACK];

    //buttons
    btnFind.Caption := Lang[ID_BTN_FIND];
    btnCancel.Caption := Lang[ID_BTN_CANCEL];

    x := Self.Canvas.TextWidth(btnFind.Caption) + 5;
    If x > btnFind.Width Then
        btnFind.Width := x;

    x := Self.Canvas.TextWidth(btnCancel.Caption);
    If x > btnCancel.Width Then
        btnCancel.Width := x;
End;

Procedure TfrmFind.FormKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
{$IFDEF WIN32}
    If (Key = VK_TAB) And (Shift = [ssCtrl]) Then
{$ENDIF}
{$IFDEF LINUX}
  if (Key = XK_TAB) and (Shift = [ssCtrl]) then
{$ENDIF}
    Begin
        // switch tabs
        If LookIn.ItemIndex = LookIn.Items.Count - 1 Then
            LookIn.ItemIndex := 0
        Else
            LookIn.ItemIndex := LookIn.ItemIndex + 1;

        //Enable or disable the extended search options
        LookIn.OnChange(LookIn);
    End;
End;

Procedure TfrmFind.LookInChange(Sender: TObject);
Begin
    If LookIn.ItemIndex = -1 Then
    Begin
        grpOrigin.Enabled := False;
        grpDirection.Enabled := False;
    End
    Else
    Begin
        grpOrigin.Enabled := TLookIn(LookIn.Items.Objects[LookIn.ItemIndex]) In
            [liSelected, liFile];
        grpDirection.Enabled :=
            TLookIn(LookIn.Items.Objects[LookIn.ItemIndex]) In [liSelected, liFile];
    End;
End;

Procedure TfrmFind.OnBuildExpr(Sender: TObject);
Var
    Text: String;
    selStart: Integer;
Begin
    selStart := cboFindText.SelStart;
    Text := (Sender As TMenuItem).Caption;
    Text := Copy(Text, 1, Pos(' ', Text) - 1);
    Text := AnsiReplaceStr(Text, '&', '');
    cboFindText.SelText := Text;

    //Do we go into the bracket?
    cboFindText.SetFocus;
    If (Text = '()') Or (Text = '[]') Or (Text = '[^]') Then
        cboFindText.SelStart := selStart + Length(Text) - 1
    Else
        cboFindText.SelStart := selStart + Length(Text);
    cboFindText.SelLength := 0;
End;

End.
