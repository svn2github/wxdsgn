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

unit Findfrm;

interface

uses
    Search_Center, StrUtils,
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
    SynEdit, StdCtrls, devTabs, SynEditTypes, XPMenu, ExtCtrls, Menus;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms,
  QSynEdit, QStdCtrls, devTabs, QSynEditTypes;
{$ENDIF}

type
    TfrmFind = class(TForm)
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
        procedure btnFindClick(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure btnCancelClick(Sender: TObject);
        procedure FormKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure LookInChange(Sender: TObject);
        procedure OnBuildExpr(Sender: TObject);
    private
        fSearchOptions: TSynSearchOptions;
        fClose: boolean;
        fFindAll: boolean;
        fRegex: boolean;

        procedure LoadText;
        function GetFindWhat: TLookIn;

    public
        property SearchOptions: TSynSearchOptions read fSearchOptions;
        property FindAll: boolean read fFindAll write fFindAll;
        property FindWhat: TLookIn read GetFindWhat;
        property Regex: boolean read fRegex write fRegex;
    end;

var
    frmFind: TfrmFind;

implementation

uses
    typinfo,
{$IFDEF WIN32}
    Main, Dialogs, MultiLangSupport, devcfg;
{$ENDIF}
{$IFDEF LINUX}
  Xlib, Main, QDialogs, MultiLangSupport, devcfg;
{$ENDIF}

{$R *.dfm}

function TfrmFind.GetFindWhat: TLookIn;
begin
    Result := TLookIn(LookIn.Items.Objects[LookIn.ItemIndex]);
end;

procedure TfrmFind.FormShow(Sender: TObject);
begin
    LoadText;
    ActiveControl := cboFindText;
    LookIn.Items.Clear;

    //What sorta search types can we allow?
    if SearchCenter.PageControl.PageCount > 0 then
    begin
        LookIn.AddItem(Lang[ID_FIND_SELONLY], TObject(liSelected));
        LookIn.AddItem('Current File', TObject(liFile));
        if not fFindAll then
            LookIn.ItemIndex := 1;
    end;

    //Insert the Open Files category
    if SearchCenter.PageControl.PageCount > 0 then
        LookIn.AddItem(Lang[ID_FIND_OPENFILES], TObject(liOpen));

    //And the Current Project category
    if Assigned(SearchCenter.Project) then
        LookIn.AddItem(Lang[ID_FIND_PRJFILES], TObject(liProject));

    //Set the correct find type for our search
    if fFindAll then
        LookIn.ItemIndex := LookIn.Items.Count - 1;

    //Enable or disable the extended search options
    LookIn.OnChange(LookIn);
end;

procedure TfrmFind.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if fClose then
        Action := caHide
    else
    begin
        Action := caNone;
        ActiveControl := cboFindText;
    end;
end;

procedure TfrmFind.btnFindClick(Sender: TObject);
begin
    if cboFindText.Text <> '' then
    begin
        if cboFindText.Items.IndexOf(cboFindText.Text) = -1 then
            cboFindText.Items.Insert(0, cboFindText.Text);

        fSearchOptions := [];

        fRegex := cbRegex.Checked;
        if cbMatchCase.checked then
            include(fSearchOptions, ssoMatchCase);
        if cbWholeWord.Checked then
            include(fSearchOptions, ssoWholeWord);

        if TLookIn(LookIn.Items.Objects[LookIn.ItemIndex]) in
            [liSelected, liFile] then
        begin
            fFindAll := False;
            if TLookIn(LookIn.Items.Objects[LookIn.ItemIndex]) = liSelected then
                include(fSearchOptions, ssoSelectedOnly);
            if grpDirection.ItemIndex = 1 then
                include(fSearchOptions, ssoBackwards);
            if grpOrigin.ItemIndex = 1 then
                include(fSearchOptions, ssoEntireScope);
        end
        else
        begin
            fFindAll := True;
            MainForm.FindOutput.Items.Clear;
            include(fSearchOptions, ssoEntireScope);
            include(fSearchOptions, ssoReplaceAll);
            include(fSearchOptions, ssoPrompt);
        end;
        fClose := True;
    end;
end;

procedure TfrmFind.btnCancelClick(Sender: TObject);
begin
    fClose := true;
    Close;
end;

procedure TfrmFind.LoadText;
var
    x: Integer;
begin
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
    if x > btnFind.Width then
        btnFind.Width := x;

    x := Self.Canvas.TextWidth(btnCancel.Caption);
    if x > btnCancel.Width then
        btnCancel.Width := x;
end;

procedure TfrmFind.FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
{$IFDEF WIN32}
    if (Key = VK_TAB) and (Shift = [ssCtrl]) then
{$ENDIF}
{$IFDEF LINUX}
  if (Key = XK_TAB) and (Shift = [ssCtrl]) then
{$ENDIF}
    begin
        // switch tabs
        if LookIn.ItemIndex = LookIn.Items.Count - 1 then
            LookIn.ItemIndex := 0
        else
            LookIn.ItemIndex := LookIn.ItemIndex + 1;

        //Enable or disable the extended search options
        LookIn.OnChange(LookIn);
    end;
end;

procedure TfrmFind.LookInChange(Sender: TObject);
begin
    if LookIn.ItemIndex = -1 then
    begin
        grpOrigin.Enabled := False;
        grpDirection.Enabled := False;
    end
    else
    begin
        grpOrigin.Enabled := TLookIn(LookIn.Items.Objects[LookIn.ItemIndex]) in
            [liSelected, liFile];
        grpDirection.Enabled :=
            TLookIn(LookIn.Items.Objects[LookIn.ItemIndex]) in [liSelected, liFile];
    end;
end;

procedure TfrmFind.OnBuildExpr(Sender: TObject);
var
    Text: String;
    selStart: Integer;
begin
    selStart := cboFindText.SelStart;
    Text := (Sender as TMenuItem).Caption;
    Text := Copy(Text, 1, Pos(' ', Text) - 1);
    Text := AnsiReplaceStr(Text, '&', '');
    cboFindText.SelText := Text;

    //Do we go into the bracket?
    cboFindText.SetFocus;
    if (Text = '()') or (Text = '[]') or (Text = '[^]') then
        cboFindText.SelStart := selStart + Length(Text) - 1
    else
        cboFindText.SelStart := selStart + Length(Text);
    cboFindText.SelLength := 0;
end;

end.
