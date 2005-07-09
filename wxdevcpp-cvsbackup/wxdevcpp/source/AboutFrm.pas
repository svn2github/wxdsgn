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
    VersionLabel: TLabel;
    btnOk: TBitBtn;
    CopyrightLabel: TLabel;
    GroupBox1: TGroupBox;
    LicenseText: TMemo;
    GroupBox2: TGroupBox;
    BloodLabel: TLabel;
    BloodSite: TLabel;
    MingwLabel: TLabel;
    MingwSite: TLabel;
    ForumLabel: TLabel;
    ForumSite: TLabel;
    MailLabel: TLabel;
    MailSite: TLabel;
    eMailLabel: TLabel;
    eMailSite: TLabel;
    btnAuthors: TBitBtn;
    btnUpdateCheck: TBitBtn;
    Timer1: TTimer;
    Fish: TPanel;
    FishImage: TImage;
    Image1: TImage;
    XPMenu: TXPMenu;
    Image2: TImage;
    procedure LabelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAuthorsClick(Sender: TObject);
    procedure btnUpdateCheckClick(Sender: TObject);
    procedure btnAuthorsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure btnAuthorsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure FishImageClick(Sender: TObject);
  private
    procedure LoadText;
  {$IFDEF WX_BUILD}
  public
    Label3 : TLabel;
    lbwxdecppLabel: TLabel;
    lbwxdecppSite: TLabel;

    procedure CreateWxSpecifics;
  {$ENDIF}
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
  BloodLabel.Caption := Lang[ID_AB_LBLBLOODSITE];
  MingwLabel.Caption := Lang[ID_AB_LBLMINGWSITE];
  ForumLabel.Caption := Lang[ID_AB_LBLFORUM];
  MailLabel.Caption := Lang[ID_AB_LBLMAIL];
  //EMailLabel.Caption:=     Lang[ID_AB_LBLEMAIL];
  BloodSite.Caption := Lang[ID_AB_BLOODSITE];
  MingwSite.Caption := Lang[ID_AB_MINGWSITE];
  ForumSite.Caption := Lang[ID_AB_FORUMS];
  MailSite.Caption := Lang[ID_AB_MAILLIST];
  //eMailSite.Caption:=      Lang[ID_AB_AUTHOR];
  btnOk.Caption := Lang[ID_BTN_OK];
  btnUpdateCheck.Caption := Lang[ID_AB_UPDATE];
  btnAuthors.Caption := Lang[ID_BTN_AUTHOR];
end;
{$IFDEF WX_BUILD}
procedure TAboutForm.CreateWxSpecifics;
begin
  Label3 := TLabel.Create(Self);
  with Label3 do
  begin
    Name := 'Label3';
    Parent := Self;
    Left := 8;
    Top := 90;
    Width := 372;
    Height := 13;
    Caption := 'wxWidgets Designer and portions - Copyright (c) Guru Kathiresan';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [fsBold];
    ParentFont := False;
  end;

  lbwxdecppLabel := TLabel.Create(Self);
  lbwxdecppSite := TLabel.Create(Self);
  with lbwxdecppLabel do
  begin
    Name := 'lbwxdecppLabel';
    Parent := GroupBox2;
    Left := 16;
    Top := 16;
    Width := 103;
    Height := 13;
    Caption := 'wx-devcpp web site : ';
  end;

  with lbwxdecppSite do
  begin
    Name := 'lbwxdecppSite';
    Parent := GroupBox2;
    Left := 168;
    Top := 16;
    Width := 144;
    Height := 13;
    Cursor := crHandPoint;
    Caption := 'http://wxdsgn.sourceforge.net';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBlue;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [fsUnderline];
    ParentFont := False;
    OnClick := LabelClick;
  end;

end;
{$ENDIF}

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
{$IFDEF WX_BUILD}
  CreateWxSpecifics;
{$ENDIF}
  LoadText;
  if FileExists(devData.Splash) then
    Image1.Picture.LoadFromFile(devData.Splash);
end;

procedure TAboutForm.btnAuthorsClick(Sender: TObject);
const MessageText =
    'Authors:'#13#10#13#10 +
    '- Development: Colin Laplace, Mike Berg, Hongli Lai, Yiannis Mandravellos'#13#10 +
    '- Contributors: Peter Schraut, Marek Januszewski'#13#10 +
    '- Mingw compiler system: Mumit Khan, J.J. Var Der Heidjen, Colin Hendrix and GNU developers'#13#10 +
    '- Splash screen and association icons: Matthijs Crielaard: '#13#10 +
    '- New Look theme: Gerard Caulfield'#13#10 +
    '- Gnome icons: Gnome designers'#13#10 +
    '- Blue theme: Thomas Thron'#13#10
    {$IFDEF WX_BUILD}
    +
    ''#13#10+
    '- wxWidgets Designer Extension: Guru Kathiresan, Tony Reina, Malcolm Nealon.'#13#10
    {$ENDIF}
    ;
begin
  MessageBeep($F);
  MessageDlg(MessageText, MtInformation, [MbOK], 0);
end;

procedure TAboutForm.btnUpdateCheckClick(Sender: TObject);
begin
  //CheckUpdate(Self); old check for update
  MainForm.actUpdateCheckExecute(sender);
end;

procedure TAboutForm.btnAuthorsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TAboutForm.btnAuthorsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  Fish.Left := 0 - Fish.Width;
  Fish.Top := Random(Height - Fish.Height - (Fish.Height div 3));
  Fish.Tag := 0;
  Timer1.Enabled := True;
end;

procedure TAboutForm.Timer1Timer(Sender: TObject);
begin
  if ((Fish.Tag = 0) and (Fish.Left > Width + 10)) or
    ((Fish.Tag <> 1) and (Fish.Left < 0 - Fish.Width - 10)) then
    Timer1.Enabled := False;

  if Fish.Tag = 0 then
    Fish.Left := Fish.Left + 5
  else
    Fish.Left := Fish.Left - 5;
  Fish.Top := Fish.Top + 1;
end;

procedure TAboutForm.FishImageClick(Sender: TObject);
begin
  Fish.Tag := not Fish.Tag;
end;

end.
