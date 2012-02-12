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

Unit CVSPasswdFm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls;
{$ENDIF}

Type
    TCVSPasswdForm = Class(TForm)
        Label1: TLabel;
        txtPass: TEdit;
        btnOK: TButton;
        Label2: TLabel;
        XPMenu: TXPMenu;
        Procedure FormShow(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    CVSPasswdForm: TCVSPasswdForm;

Implementation

Uses
    devcfg;

{$R *.dfm}

Procedure TCVSPasswdForm.FormShow(Sender: TObject);
Begin
    If devData.XPTheme Then
        XPMenu.Active := True
    Else
        XPMenu.Active := False;
    txtPass.Text := '';
    txtPass.SetFocus;
End;

End.
