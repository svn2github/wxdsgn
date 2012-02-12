{
    $Id: AboutFrm.pas 763 2006-12-23 02:12:11Z lowjoel $

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

Unit AboutFrm;

Interface

Uses
    Version,
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, Buttons, ExtCtrls, XPMenu, ComCtrls;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, QExtCtrls;
{$ENDIF}

Type
    TAboutForm = Class(TForm)
        btnOk: TBitBtn;
        btnUpdateCheck: TBitBtn;
        banner: TImage;
        XPMenu: TXPMenu;
        Container: TPageControl;
        Version: TTabSheet;
        wxWebsite: TLabel;
        ForumSite: TLabel;
        wxdevcppWebsite: TLabel;
        wxdevcppWebsiteLabel: TLabel;
        ForumLabel: TLabel;
        wxWebLabel: TLabel;
        License: TTabSheet;
        Authors: TTabSheet;
        LicenseText: TMemo;
        lblAuthors_wxDevCpp: TLabel;
        Label2: TLabel;
        lblAuthors_DevCpp: TLabel;
        Label4: TLabel;
        lblMingW: TLabel;
        Label5: TLabel;
        lblSplash: TLabel;
        Label6: TLabel;
        Label8: TLabel;
        Label9: TLabel;
        lblGnome: TLabel;
        Gnome: TLabel;
        CopyrightLabel: TLabel;
        wxdevcopyright: TLabel;
        BookLabel: TLabel;
        Book: TLabel;
        Label1: TLabel;
        BuildNumber: TLabel;
        Procedure LabelClick(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure btnUpdateCheckClick(Sender: TObject);
    Private
        Procedure LoadText;
    Protected
        Procedure CreateParams(Var Params: TCreateParams); Override;
    End;

Implementation
Uses
{$IFDEF WIN32}
    ShellAPI, devcfg, MultiLangSupport, main;
{$ENDIF}
{$IFDEF LINUX}
  devcfg, MultiLangSupport, main;
{$ENDIF}

{$R *.dfm}

Function GetAppVersion: String;
Var
    Size, Size2: DWord;
    Pt, Pt2: Pointer;
Begin
    Size := GetFileVersionInfoSize(Pchar(ParamStr(0)), Size2);
    If Size > 0 Then
    Begin
        GetMem(Pt, Size);
        Try
            GetFileVersionInfo(Pchar(ParamStr(0)), 0, Size, Pt);
            VerQueryValue(Pt, '\', Pt2, Size2);
            With TVSFixedFileInfo(Pt2^) Do
            Begin
                Result := ' build ' +
                    IntToStr(HiWord(dwFileVersionMS)) + '.' +
                    IntToStr(LoWord(dwFileVersionMS)) + '.' +
                    IntToStr(HiWord(dwFileVersionLS)) + '.' +
                    IntToStr(LoWord(dwFileVersionLS));
            End;
        Finally
            FreeMem(Pt);
        End;
    End;
End;

Procedure TAboutForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := 'About wxDev-C++';
    License.Caption := Lang[ID_AB_LICENSE];
    Version.Caption := Lang[ID_AB_VERSCAP];
    btnOk.Caption := Lang[ID_BTN_OK];
    btnUpdateCheck.Caption := Lang[ID_AB_UPDATE];
    Authors.Caption := Lang[ID_BTN_AUTHOR];
    BuildNumber.Caption := GetAppVersion;
End;

Procedure TAboutForm.LabelClick(Sender: TObject);
Var s: String;
Begin
    If pos('@', (Sender As TLabel).Caption) <> 0 Then
        s := 'mailto:' + (Sender As TLabel).Caption
    Else
        s := (Sender As TLabel).Caption;
    ShellExecute(GetDesktopWindow(), 'open', Pchar(s), Nil, Nil, SW_SHOWNORMAL);
End;

Procedure TAboutForm.FormCreate(Sender: TObject);
Begin
    LoadText;
    wxDevCopyright.Font.Style := [fsBold];
    CopyrightLabel.Font.Style := [fsBold];
    ForumSite.Font.Style := [fsUnderline];
    ForumSite.Font.Color := clBlue;
    wxdevcppWebsite.Font.Style := [fsUnderline];
    wxdevcppWebsite.Font.Color := clBlue;
    wxWebsite.Font.Style := [fsUnderline];
    wxWebsite.Font.Color := clBlue;
    Book.Font.Style := [fsUnderline];
    Book.Font.Color := clBlue;
End;

Procedure TAboutForm.btnUpdateCheckClick(Sender: TObject);
Begin
    MainForm.actUpdateCheckExecute(sender);
End;

Procedure TAboutForm.CreateParams(Var Params: TCreateParams);
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
