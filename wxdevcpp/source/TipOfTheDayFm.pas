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

Unit TipOfTheDayFm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ComCtrls, ExtCtrls, ShellAPI, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QComCtrls, QExtCtrls, XPMenu;
{$ENDIF}

Type
    TTipOfTheDayForm = Class(TForm)
        btnPrev: TButton;
        btnNext: TButton;
        btnClose: TButton;
        chkNotAgain: TCheckBox;
        XPMenu: TXPMenu;
        ScrollBox: TScrollBox;
        lblTip: TLabel;
        lblTitle: TLabel;
        Bevel1: TBevel;
        Image: TImage;
        lblUrl: TLabel;
        Procedure FormShow(Sender: TObject);
        Procedure btnCloseClick(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Procedure btnNextClick(Sender: TObject);
        Procedure btnPrevClick(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure lblUrlClick(Sender: TObject);
    Private
        { Private declarations }
        sl: TStringList;
        TipsCounter: Integer;
        HiddenUrl: String;
        Function ConvertMacros(Str: String): String;
        Procedure LoadFromFile(Filename: String);
        Function CurrentTip: String;
        Function NextTip: String;
        Function PreviousTip: String;
        Procedure SetTipsCounter(Const Value: Integer);
        Procedure LoadText;
    Public
        { Public declarations }
        Property Current: Integer Read TipsCounter Write SetTipsCounter;
    Protected
        Procedure CreateParams(Var Params: TCreateParams); Override;
    End;

Var
    TipOfTheDayForm: TTipOfTheDayForm;

Implementation

Uses
    devcfg, MultiLangSupport;

{$R *.dfm}

Procedure TTipOfTheDayForm.FormShow(Sender: TObject);
Var
    S: String;
    LangNoExt: String;
    ExtPos: Integer;
Begin
    lblUrl.Visible := False;
    LangNoExt := Lang.FileFromDescription(devData.Language);
    ExtPos := Pos(ExtractFileExt(LangNoExt), LangNoExt);
    Delete(LangNoExt, ExtPos, MaxInt);
    S := devDirs.Lang + ExtractFileName(LangNoExt) + '.tips';
    If Not FileExists(S) Then
        S := devDirs.Lang + 'English.tips';
    If Not FileExists(S) Then
    Begin
        btnNext.Enabled := False;
        btnPrev.Enabled := False;
    End
    Else
    Begin
        LoadFromFile(S);
        If (TipsCounter < 0) Or (TipsCounter >= sl.Count) Then
            TipsCounter := 0;
        If sl.Count > 0 Then
            lblTip.Caption := CurrentTip
        Else
        Begin
            btnNext.Enabled := False;
            btnPrev.Enabled := False;
        End;
    End;
End;

Procedure TTipOfTheDayForm.btnCloseClick(Sender: TObject);
Begin
    Close;
End;

Function TTipOfTheDayForm.ConvertMacros(Str: String): String;
Var
    idx: Integer;
    url: String;
    urldesc: String;
Begin
    // <CR> macro
    Result := StringReplace(Str, '<CR>', #10, [rfReplaceAll]);

    // <URL> and <UDESC> macros
    url := '';
    urldesc := '';
    idx := Pos('<URL>', Result);
    If idx > 0 Then
    Begin
        url := Copy(Result, idx + 5, MaxInt);
        Delete(Result, idx, MaxInt);
        idx := Pos('<UDESC>', url);
        lblUrl.Visible := True;
        If idx > 0 Then
        Begin
            urldesc := Copy(url, idx + 7, MaxInt);
            Delete(url, idx, MaxInt);
        End;
        If urldesc = '' Then
            urldesc := url;
        lblUrl.Caption := urldesc;
        HiddenUrl := url;
        lblUrl.Visible := True;
    End
    Else
        lblUrl.Visible := False;
End;

Procedure TTipOfTheDayForm.FormCreate(Sender: TObject);
Begin
    LoadText;
    TipsCounter := 0;
    sl := TStringList.Create;
End;

Procedure TTipOfTheDayForm.FormDestroy(Sender: TObject);
Begin
    sl.Free;
End;

Function TTipOfTheDayForm.CurrentTip: String;
Begin
    Result := ConvertMacros(sl[TipsCounter]);
End;

Function TTipOfTheDayForm.NextTip: String;
Begin
    If TipsCounter < sl.Count - 1 Then
        Inc(TipsCounter)
    Else
        TipsCounter := 0;
    Result := ConvertMacros(sl[TipsCounter]);
End;

Function TTipOfTheDayForm.PreviousTip: String;
Begin
    If TipsCounter > 0 Then
        Dec(TipsCounter)
    Else
        TipsCounter := sl.Count - 1;
    Result := ConvertMacros(sl[TipsCounter]);
End;

Procedure TTipOfTheDayForm.btnNextClick(Sender: TObject);
Begin
    lblTip.Caption := NextTip;
End;

Procedure TTipOfTheDayForm.btnPrevClick(Sender: TObject);
Begin
    lblTip.Caption := PreviousTip;
End;

Procedure TTipOfTheDayForm.LoadFromFile(Filename: String);
Var
    I: Integer;
Begin
    Try
        sl.LoadFromFile(Filename);
        I := 0;
        While I < sl.Count Do
        Begin
            If Trim(sl[I]) = '' Then
                sl.Delete(I) // delete empty lines
            Else
            If Trim(sl[I])[1] = '#' Then
                sl.Delete(I) // delete lines starting with '#' (comments)
            Else
                Inc(I);
        End;
    Finally
    End;
End;

Procedure TTipOfTheDayForm.SetTipsCounter(Const Value: Integer);
Begin
    If Value <> TipsCounter Then
        TipsCounter := Value;
End;

Procedure TTipOfTheDayForm.FormClose(Sender: TObject;
    Var Action: TCloseAction);
Begin
    Action := caFree;
End;

Procedure TTipOfTheDayForm.lblUrlClick(Sender: TObject);
Begin
    ShellExecute(0, 'open', Pchar(HiddenUrl), '', '', SW_SHOWNORMAL);
End;

Procedure TTipOfTheDayForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_TIPS_CAPTION];
    lblTitle.Caption := Lang[ID_TIPS_DIDYOUKNOW];
    lblTip.Caption := Lang[ID_TIPS_NOTIPSTODISPLAY];
    chkNotAgain.Caption := Lang[ID_TIPS_DONTSHOWTIPS];
    btnNext.Caption := Lang[ID_TIPS_NEXTTIP];
    btnPrev.Caption := Lang[ID_TIPS_PREVIOUSTIP];
    btnClose.Caption := Lang[ID_BTN_CLOSE];
End;

Procedure TTipOfTheDayForm.CreateParams(Var Params: TCreateParams);
Begin
    Inherited;
    If (Parent <> Nil) Or (ParentWindow <> 0) Then
        Exit;  // must not mess with wndparent if form is embedded

    If Assigned(Owner) And (Owner Is TWincontrol) Then
        Params.WndParent := TWinControl(Owner).handle
    Else
    If Assigned(Screen.Activeform) Then
        Params.WndParent := Screen.Activeform.Handle;
End;

End.
