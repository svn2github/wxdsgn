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

Unit Splash;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    ExtCtrls, ComCtrls, Version;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QExtCtrls, QComCtrls, Version;
{$ENDIF}

Type
    TSplashForm = Class(TForm)
        Panel: TPanel;
        Image: TImage;
        StatusBar: TStatusBar;
        ProgressBar: TProgressBar;
        Procedure FormCreate(Sender: TObject);


    Public
        Procedure OnCacheProgress(Sender: TObject; FileName: String;
            Total, Current: Integer);

        Procedure CreateParams(Var Params: TCreateParams); Override;

    End;

Var
    SplashForm: TSplashForm;

Implementation

Uses
    devcfg;

{$R *.dfm}

Procedure TSplashForm.CreateParams(Var Params: TCreateParams);
Begin
    Inherited CreateParams(Params);
    Params.ExStyle := Params.ExStyle Or WS_EX_APPWINDOW;
End;

Procedure TSplashForm.FormCreate(Sender: TObject);
Begin
    DesktopFont := True;
    If (devData.Splash <> '') And FileExists(devData.Splash) Then
    Begin
        Image.Picture.LoadFromFile(devData.Splash);
        ClientWidth := Image.Width;
        ClientHeight := Image.Height + StatusBar.Height;
    End;

    ProgressBar.Visible := False;
    ProgressBar.Left := StatusBar.Width - ProgressBar.Width - 1;
    ProgressBar.Top := StatusBar.Top + 2;
    StatusBar.SimpleText := 'wxDev-C++ ' + DEVCPP_VERSION + '. Loading...';
End;

Procedure TSplashForm.OnCacheProgress(Sender: TObject; FileName: String; Total,
    Current: Integer);
Begin
    ProgressBar.Visible := True;
    ProgressBar.Max := Total;
    ProgressBar.Position := Current;
    Application.ProcessMessages;
End;

End.
