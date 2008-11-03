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

unit RemoveUnitFrm;

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
  TRemoveUnitForm = class(TForm)
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
    XPMenu: TXPMenu;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

implementation

uses 
  MultiLangSupport, devcfg;

{$R *.dfm}

procedure TRemoveUnitForm.FormCreate(Sender: TObject);
begin
  DesktopFont := True;
  XPMenu.Active := devData.XPTheme;
  Caption:=           Lang[ID_RU];
  GroupBox.Caption:=  Lang[ID_RU_TEXT];
  OkBtn.Caption := Lang[ID_BTN_OK];
  CancelBtn.Caption:= Lang[ID_BTN_CANCEL];
end;

procedure TRemoveUnitForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if (Parent <> nil) or (ParentWindow <> 0) then
    Exit;  // must not mess with wndparent if form is embedded

  if Assigned(Owner) and (Owner is TWincontrol) then
    Params.WndParent := TWinControl(Owner).handle
  else if Assigned(Screen.Activeform) then
    Params.WndParent := Screen.Activeform.Handle;
end;

end.
