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

Unit debugfrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ComCtrls, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QComCtrls;
{$ENDIF}

Type
    TDebugForm = Class(TForm)
        lvItems: TListView;
        btnClose: TButton;
        XPMenu: TXPMenu;
        Procedure FormShow(Sender: TObject);
        Procedure btnCloseClick(Sender: TObject);
        Procedure AddItem(Const Text, Value: String);
    Private

    Public
        { Public declarations }
    End;

Var
    DebugForm: TDebugForm;

Implementation

Uses
    utils, devcfg, main;

{$R *.dfm}

Procedure TDebugForm.AddItem(Const Text, Value: String);
Var
    Item: TListItem;
Begin
    Item := lvItems.Items.Add;
    Item.Caption := Text;
    Item.SubItems.Add(Value);
End;

Procedure TDebugForm.FormShow(Sender: TObject);
Begin
    AddItem('Current Path', GetCurrentDir);
    With devDirs Do
    Begin
        AddItem('devDirs.Exec', Exec);
        AddItem('devDirs.Icons', Icons);
        AddItem('devDirs.Help', ExpandFileto(Help, Exec));
        AddItem('devDirs.Lang', ExpandFileto(Lang, Exec));
        AddItem('devDirs.Templates', ExpandFileto(Templates, Exec));
        AddItem('devDirs.Default', Default);
        AddItem('devDirs.Bin', Bins);
        AddItem('devDirs.C', C);
        AddItem('devDirs.Cpp', Cpp);
        AddItem('devDirs.Lib', Lib);
        AddItem('devDirs.OriginalPath', OriginalPath);

        If devData.XPTheme Then
            XPMenu.Active := True
        Else
            XPMenu.Active := False;
    End;
End;

Procedure TDebugForm.btnCloseClick(Sender: TObject);
Begin
    close;
End;

End.
