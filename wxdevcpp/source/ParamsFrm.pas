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

Unit ParamsFrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, Buttons, XPMenu, devcfg, OpenSaveDialogs;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QButtons, devcfg;
{$ENDIF}

Type
    TParamsForm = Class(TForm)
        grpParameters: TGroupBox;
        ParamEdit: TEdit;
        grpHost: TGroupBox;
        HostEdit: TEdit;
        LoadBtn: TSpeedButton;
        OkBtn: TBitBtn;
        CancelBtn: TBitBtn;
        XPMenu: TXPMenu;
        Procedure LoadBtnClick(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure FormShow(Sender: TObject);
    Private
        OpenDialog: TOpenDialogEx;
        Procedure LoadText;
        { Private declarations }
    Public
        Procedure DisableHost;
        { Public declarations }
    End;

Var
    ParamsForm: TParamsForm;

Implementation

Uses
    MultiLangSupport, main;

{$R *.dfm}

Procedure TParamsForm.LoadText;
Begin
    Caption := Lang.Strings[ID_PARAM_CAPTION];
    grpParameters.Caption := Lang.Strings[ID_PARAM_PARAMS];
    grpHost.Caption := Lang.Strings[ID_PARAM_HOST];
    OkBtn.Caption := Lang.Strings[ID_BTN_OK];
    CancelBtn.Caption := Lang.Strings[ID_BTN_CANCEL];
End;

Procedure TParamsForm.LoadBtnClick(Sender: TObject);
Begin
    If OpenDialog.Execute Then
        HostEdit.Text := OpenDialog.FileName;
End;

Procedure TParamsForm.DisableHost;
Begin
    HostEdit.Enabled := False;
    LoadBtn.Enabled := False;
End;

Procedure TParamsForm.FormCreate(Sender: TObject);
Begin
    OpenDialog := TOpenDialogEx.Create(MainForm);
    OpenDialog.DefaultExt := '.exe';
    OpenDialog.Filter := 'Applications (*.exe)|*.exe';
    LoadText;
End;

Procedure TParamsForm.FormShow(Sender: TObject);
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
End;

End.
