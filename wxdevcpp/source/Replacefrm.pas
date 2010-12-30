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

unit Replacefrm;

interface

uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
    SynEdit, StdCtrls, SynEditTypes, XPMenu, ExtCtrls;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms,
  QSynEdit, QStdCtrls, QSynEditTypes;
{$ENDIF}

type
    TfrmReplace = class(TForm)
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
        procedure btnReplaceClick(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure btnCancelClick(Sender: TObject);

    private
        fSearchOptions: TSynSearchOptions;
        fClose: boolean;
        fRegex: boolean;
        procedure LoadText;

    public
        UseSelection: Boolean;
        property SearchOptions: TSynSearchOptions
            read fSearchOptions write fSearchOptions;
        property Regex: boolean read fRegex write fRegex;
    end;

var
    frmReplace: TfrmReplace;

implementation

{$R *.dfm}

uses
    Search_Center,
{$IFDEF WIN32}
    Dialogs, MultiLangSupport, devcfg;
{$ENDIF}
{$IFDEF LINUX}
  QDialogs, MultiLangSupport, devcfg;
{$ENDIF}

procedure TfrmReplace.btnReplaceClick(Sender: TObject);
begin
    if cboFindText.Text <> '' then
    begin
        fSearchOptions := [];
        Regex := cbRegex.Checked;
        if cboFindText.Items.Indexof(cboFindText.Text) = -1 then
            cboFindText.Items.Add(cboFindText.Text);

        if cboReplaceText.Items.IndexOf(cboReplaceText.Text) = -1 then
            cboReplaceText.Items.Add(cboReplaceText.Text);

        if modalResult = mrOk then
            fSearchOptions := [ssoReplace]
        else
        if ModalResult = mrAll then
            fSearchOptions := [ssoReplaceAll];

        if cbPrompt.Checked then
            include(fSearchoptions, ssoPrompt);

        if cbMatchCase.checked then
            include(fSearchOptions, ssoMatchCase);

        if cbWholeWord.Checked then
            include(fSearchOptions, ssoWholeWord);

        if grpDirection.ItemIndex = 1 then
            include(fSearchOptions, ssoBackwards);

        if TLookIn(LookIn.Items.Objects[LookIn.ItemIndex]) = liSelected then
            include(fSearchOptions, ssoSelectedOnly);

        if grpOrigin.ItemIndex = 1 then
            include(fSearchOptions, ssoEntireScope);

        UseSelection := cbUseSelection.Checked;

        fClose := True;
    end;
end;

procedure TfrmReplace.FormShow(Sender: TObject);
begin
    ActiveControl := cboFindText;
    LoadText;
end;

procedure TfrmReplace.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if fClose then
        action := caHide
    else
    begin
        Action := caNone;
        ActiveControl := cboFindText;
    end;
end;

procedure TfrmReplace.btnCancelClick(Sender: TObject);
begin
    fClose := true;
    Close;
end;

procedure TfrmReplace.LoadText;
var
    x: Integer;
begin
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
    if x > btnReplace.Width then
    begin
        btnReplace.Width := x;
        btnReplaceAll.Left := btnReplace.Left + btnReplace.Width + 6;
    end;

    x := Self.Canvas.TextWidth(btnReplaceAll.Caption) + 5;
    if x > btnReplaceAll.Width then
        btnReplaceAll.Width := x;

    x := Self.Canvas.TextWidth(btnCancel.Caption) + 5;
    if x > btnCancel.Width then
    begin
        btnCancel.Left := btnCancel.Left - ((x - btnCancel.Width) + 10);
        btnCancel.Width := x;
    end;
end;

end.
