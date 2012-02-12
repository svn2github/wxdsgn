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

Unit ModifyVarFrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, Buttons, XPMenu, devcfg;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QButtons;
{$ENDIF}

Type
    TModifyVarForm = Class(TForm)
        OkBtn: TBitBtn;
        CancelBtn: TBitBtn;
        NameLabel: TLabel;
        NameEdit: TEdit;
        ValueEdit: TEdit;
        ValueLabel: TLabel;
        XPMenu: TXPMenu;
        chkStopOnRead: TCheckBox;
        chkStopOnWrite: TCheckBox;
        Procedure FormCreate(Sender: TObject);
        Procedure NameEditKeyPress(Sender: TObject; Var Key: Char);
        Procedure FormShow(Sender: TObject);
    Private
        { Private declarations }
        fActiveWindow: TWinControl;
        Procedure LoadText;
    Public
        { Public declarations }
        Property ActiveWindow: TWinControl Write fActiveWindow;
    End;

Var
    ModifyVarForm: TModifyVarForm;

Implementation

Uses
    MultiLangSupport;

{$R *.dfm}

Procedure TModifyVarForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;

    Caption := Lang.Strings[ID_NV_MODIFYVALUE];
    NameLabel.Caption := Lang.Strings[ID_NV_VARNAME];
    ValueLabel.Caption := Lang.Strings[ID_NV_VARVALUE];
    OkBtn.Caption := Lang.Strings[ID_BTN_OK];
    CancelBtn.Caption := Lang.Strings[ID_BTN_CANCEL];
End;

Procedure TModifyVarForm.FormCreate(Sender: TObject);
Begin
    ActiveWindow := NameEdit;
    LoadText;
End;

Procedure TModifyVarForm.NameEditKeyPress(Sender: TObject; Var Key: Char);
Begin
    If Key = #13 Then
    Begin
        ModalResult := mrOK;
        Close;
    End;
End;

Procedure TModifyVarForm.FormShow(Sender: TObject);
Begin
    SetFocus;
    fActiveWindow.SetFocus;
End;

End.
