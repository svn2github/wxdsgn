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

unit Splash;

interface

uses
{$IFDEF WIN32}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, Version;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QExtCtrls, QComCtrls, Version;
{$ENDIF}

type
  TSplashForm = class(TForm)
    Panel: TPanel;
    Image: TImage;
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    procedure FormCreate(Sender: TObject);

  public
    procedure OnCacheProgress(Sender: TObject; FileName: String; Total, Current: Integer);
  end;

var
  SplashForm: TSplashForm;

implementation

uses 
  devcfg;

{$R *.dfm}

procedure TSplashForm.FormCreate(Sender: TObject);
begin
  DesktopFont := True;
  if (devData.Splash <> '') and FileExists(devData.Splash) then
  begin
    Image.Picture.LoadFromFile(devData.Splash);
     ClientWidth:= Image.Width;
     ClientHeight:= Image.Height + StatusBar.Height;
  end;

  ProgressBar.Visible := False;
  ProgressBar.Left := StatusBar.Width - ProgressBar.Width - 1;
  ProgressBar.Top := StatusBar.Top + 2;
  StatusBar.SimpleText := 'wxDev-C++ '+ DEVCPP_VERSION +'. Loading...';
end;

procedure TSplashForm.OnCacheProgress(Sender: TObject; FileName: String; Total,
  Current: Integer);
begin
  ProgressBar.Visible := True;
  ProgressBar.Max := Total;
  ProgressBar.Position := Current;
  Application.ProcessMessages;
end;

end.
