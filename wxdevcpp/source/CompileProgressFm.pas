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

unit CompileProgressFm;

interface

uses
{$IFDEF WIN32}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, XPMenu, devcfg;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QExtCtrls, QComCtrls;
{$ENDIF}

type
  TCompileProgressForm = class(TForm)
    btnClose: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    pb: TProgressBar;
    Label1: TLabel;
    lblCompiler: TLabel;
    Bevel1: TBevel;
    lblStatus: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    lblFile: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    lblErr: TLabel;
    Bevel5: TBevel;
    Label4: TLabel;
    Bevel6: TBevel;
    lblWarn: TLabel;
    XPMenu: TXPMenu;
    Label6: TLabel;
    Bevel4: TBevel;
    lblElapsed: TLabel;
    timeTimer: TTimer;
    chkSelfClose: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure timeTimerTimer(Sender: TObject);
    procedure chkSelfCloseClick(Sender: TObject);
  private
    { Private declarations }
    StartTime: Cardinal;
  public
    { Public declarations }
    class function FormatTime(Seconds: Integer): string;
  end;

var
  CompileProgressForm: TCompileProgressForm;

implementation

{$R *.dfm}

procedure TCompileProgressForm.FormShow(Sender: TObject);
begin
  StartTime := GetTickCount div 1000;
  DesktopFont := True;
  lblFile.Font.Style := [fsBold];
  PageControl1.ActivePageIndex := 0;
  XPMenu.Active := devData.XPTheme;
  chkSelfClose.Checked  := devData.AutoCloseProgress;
  timeTimer.OnTimer(timeTimer);
end;

procedure TCompileProgressForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCompileProgressForm.timeTimerTimer(Sender: TObject);
begin
  lblElapsed.Caption := FormatTime((GetTickCount div 1000) - StartTime);
end;

class function TCompileProgressForm.FormatTime(Seconds: Integer): string;
  function GetPlural(amount: Integer): string;
  begin
    if amount <> 1 then
      Result := 's'
    else
      Result := '';
  end;
var
  Hours, Minutes: Integer;
begin
  //Format the string
  Hours := Seconds div 3600;
  Seconds := Seconds mod 3600;
  Minutes := Seconds div 60;
  Seconds := Seconds mod 60;

  if Hours <> 0 then
    Result := Format('%d hour%s %d minute%s %d second%s', [Hours, GetPlural(Hours), Minutes,
                     GetPlural(Minutes), Seconds, GetPlural(Seconds)])
  else if Minutes <> 0 then
    Result := Format('%d minute%s %d second%s', [Minutes, GetPlural(Minutes), Seconds, GetPlural(Seconds)])
  else
    Result := Format('%d second%s', [Seconds, GetPlural(Seconds)]);
end;

procedure TCompileProgressForm.chkSelfCloseClick(Sender: TObject);
begin
    devData.AutoCloseProgress := chkSelfClose.Checked;
end;

end.
