{
    $Id$

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

unit AboutFrm;

interface

uses
{$IFDEF WIN32}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, XPMenu, ComCtrls;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, QExtCtrls;
{$ENDIF}

type
  TAboutForm = class(TForm)
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
    lblContributors: TLabel;
    Label3: TLabel;
    lblMingW: TLabel;
    Label5: TLabel;
    lblSplash: TLabel;
    Label6: TLabel;
    lblNewLook: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblGnome: TLabel;
    Gnome: TLabel;
    CopyrightLabel: TLabel;
    wxdevcopyright: TLabel;
    procedure LabelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnUpdateCheckClick(Sender: TObject);
  private
    procedure LoadText;
  end;

implementation
uses 
{$IFDEF WIN32}
  ShellAPI, devcfg, MultiLangSupport, CheckForUpdate, main;
{$ENDIF}
{$IFDEF LINUX}
  devcfg, MultiLangSupport, CheckForUpdate, main;
{$ENDIF}

{$R *.dfm}

procedure TAboutForm.LoadText;
begin
  if devData.XPTheme then
    XPMenu.Active := true
  else
    XPMenu.Active := false;
  Caption := Lang[ID_AB_CAPTION];
  License.Caption := Lang[ID_AB_LICENSE];
  Version.Caption := Lang[ID_AB_VERSCAP];
  btnOk.Caption := Lang[ID_BTN_OK];
  btnUpdateCheck.Caption := Lang[ID_AB_UPDATE];
  Authors.Caption := Lang[ID_BTN_AUTHOR];
end;

procedure TAboutForm.LabelClick(Sender: TObject);
var s : string;
begin
  if pos('@', (Sender as TLabel).Caption) <> 0 then
    s := 'mailto:' + (Sender as TLabel).Caption
  else
    s := (Sender as TLabel).Caption;
  ShellExecute(GetDesktopWindow(), 'open', PChar(s), nil, nil, SW_SHOWNORMAL);
end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  LoadText;
end;

procedure TAboutForm.btnUpdateCheckClick(Sender: TObject);
begin
  MainForm.actUpdateCheckExecute(sender);
end;

end.
