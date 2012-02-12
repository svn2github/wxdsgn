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

Unit WindowListFrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, Buttons, ExtCtrls, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, QExtCtrls;
{$ENDIF}

Type
    TWindowListForm = Class(TForm)
        Panel: TPanel;
        OkBtn: TBitBtn;
        CancelBtn: TBitBtn;
        Label1: TLabel;
        GroupBox: TGroupBox;
        UnitList: TListBox;
        Label2: TLabel;
        Label3: TLabel;
        XPMenu: TXPMenu;
        Procedure FormCreate(Sender: TObject);
        Procedure UnitListDblClick(Sender: TObject);
        Procedure FormShow(Sender: TObject);
        Procedure UnitListKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
    Protected
        Procedure CreateParams(Var Params: TCreateParams); Override;
    End;

Implementation

Uses
{$IFDEF WIN32}
    MultiLangSupport, devcfg;
{$ENDIF}
{$IFDEF LINUX}
  Xlib, MultiLangSupport, devcfg;
{$ENDIF}

{$R *.dfm}

Procedure TWindowListForm.FormCreate(Sender: TObject);
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_WL];
    GroupBox.Caption := Lang[ID_WL_SELECT];
    OkBtn.Caption := Lang[ID_BTN_OK];
    CancelBtn.Caption := Lang[ID_BTN_CANCEL];
End;

Procedure TWindowListForm.UnitListDblClick(Sender: TObject);
Var a: TCloseAction;
Begin
    If UnitList.ItemIndex > -1 Then
    Begin
        ModalResult := mrOk;
        DoClose(a);
    End;
End;

Procedure TWindowListForm.FormShow(Sender: TObject);
Begin
    UnitList.SetFocus;
End;

Procedure TWindowListForm.UnitListKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
{$IFDEF WIN32}
    If Key = vk_Return Then
{$ENDIF}
{$IFDEF LINUX}
  if Key = XK_RETURN then
{$ENDIF}
        UnitListDblClick(Sender);
End;

Procedure TWindowListForm.CreateParams(Var Params: TCreateParams);
Begin
    Inherited;
    If (Parent <> Nil) Or (ParentWindow <> 0) Then
        Exit;  // must not mess with wndparent if form is embedded

    If Assigned(Owner) And (Owner Is TWincontrol) Then
        Params.WndParent := TWinControl(Owner).handle
    Else
    If Assigned(Screen.Activeform) Then
        Params.WndParent := Screen.Activeform.Handle;
End;

End.
