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
  StdCtrls, Buttons, ExtCtrls, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, QExtCtrls;
{$ENDIF}

type
  TAboutForm = class(TForm)
    btnOk: TBitBtn;
    CopyrightLabel: TLabel;
    GroupBox1: TGroupBox;
    LicenseText: TMemo;
    GroupBox2: TGroupBox;
    LBForumLabel: TLabel;
    LbForumSite: TLabel;
    eMailLabel: TLabel;
    eMailSite: TLabel;
    btnAuthors: TBitBtn;
    btnUpdateCheck: TBitBtn;
    banner: TImage;
    XPMenu: TXPMenu;
    wxdevcopyright: TLabel;
    wxdevcpp_websitelbl: TLabel;
    wxdevcpp_website: TLabel;
    procedure LabelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAuthorsClick(Sender: TObject);
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
  GroupBox1.Caption := Lang[ID_AB_LICENSE];
  GroupBox2.Caption := Lang[ID_AB_WEBCAP];
  //EMailLabel.Caption:=     Lang[ID_AB_LBLEMAIL];
  //eMailSite.Caption:=      Lang[ID_AB_AUTHOR];
  btnOk.Caption := Lang[ID_BTN_OK];
  btnUpdateCheck.Caption := Lang[ID_AB_UPDATE];
  btnAuthors.Caption := Lang[ID_BTN_AUTHOR];
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

procedure TAboutForm.btnAuthorsClick(Sender: TObject);
const MessageText =
    'Authors:'#13#10#13#10 +
{$IFDEF WX_BUILD}
    '- wxDev-C++ Development: Guru Kathiresan, Tony Reina, Malcolm Nealon, Joel Low'#13#10 +
{$ENDIF}
    '- Dev-Cpp Development: Colin Laplace, Mike Berg, Hongli Lai, Yiannis Mandravellos'#13#10 +
    '- Dev-Cpp Contributors: Peter Schraut, Marek Januszewski'#13#10 +
    '- MingW compiler system: Mumit Khan, J.J. Var Der Heidjen, Colin Hendrix and GNU developers'#13#10 +
    '- Splash screen and association icons: Matthijs Crielaard'#13#10 +
    '- New Look theme: Gerard Caulfield'#13#10 +
    '- Gnome icons: Gnome designers'#13#10 +
    '- Blue theme: Thomas Thron';
begin
  MessageBeep($F);
  MessageDlg(MessageText, MtInformation, [MbOK], 0);
end;

procedure TAboutForm.btnUpdateCheckClick(Sender: TObject);
begin
  //CheckUpdate(Self); old check for update
  MainForm.actUpdateCheckExecute(sender);
end;

end.
