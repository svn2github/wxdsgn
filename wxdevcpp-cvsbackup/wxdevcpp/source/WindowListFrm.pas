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

unit WindowListFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, XPMenu;

type
  TWindowListForm = class(TForm)
    Panel: TPanel;
    OkBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Label1: TLabel;
    GroupBox: TGroupBox;
    UnitList: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    XPMenu: TXPMenu;
    procedure FormCreate(Sender: TObject);
    procedure UnitListDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UnitListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  end;

implementation

uses MultiLangSupport, devcfg;

{$R *.DFM}

procedure TWindowListForm.FormCreate(Sender: TObject);
begin
  if devData.XPTheme then
    XPMenu.Active := true
  else
    XPMenu.Active := false;
  Caption := Lang[ID_WL];
  GroupBox.Caption := Lang[ID_WL_SELECT];
  OkBtn.Caption := Lang[ID_BTN_OK];
  CancelBtn.Caption := Lang[ID_BTN_CANCEL];
end;

procedure TWindowListForm.UnitListDblClick(Sender: TObject);
var
  a: TCloseAction;
begin
  if UnitList.ItemIndex > -1 then
  begin
    ModalResult := mrOk;
    DoClose(a);
  end;
end;

procedure TWindowListForm.FormShow(Sender: TObject);
begin
  UnitList.SetFocus;
end;

procedure TWindowListForm.UnitListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Return then
    UnitListDblClick(Sender);
end;

end.
