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

Unit ProcessListFrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, Buttons, ExtCtrls, MultiLangSupport, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QButtons, QExtCtrls, MultiLangSupport;
{$ENDIF}

Type
    TProcessListForm = Class(TForm)
        OKBtn: TBitBtn;
        CancelBtn: TBitBtn;
        XPMenu: TXPMenu;
        MainLabel: TLabel;
        ProcessCombo: TComboBox;
        Procedure FormCreate(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
    Private
        Procedure LoadText;
        { Private declarations }
    Public
        ProcessList: TList;
        { Public declarations }
    End;

Var
    ProcessListForm: TProcessListForm;

Implementation

Uses
    tlhelp32, devcfg;

{$R *.dfm}

Procedure TProcessListForm.FormCreate(Sender: TObject);
Var
    t: THandle;
    pe: TProcessEntry32;
    HasProcess: Boolean;
Begin
    LoadText;
    ProcessList := TList.Create;
    t := CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);
    Try
        pe.dwSize := SizeOf(pe);
        HasProcess := Process32First(t, pe);
        While HasProcess Do
        Begin
            ProcessCombo.Items.Add(pe.szExeFile);
            ProcessList.Add(pointer(pe.th32ProcessId));
            HasProcess := Process32Next(t, pe);
        End;
    Finally
        CloseHandle(t);
    End;
End;

Procedure TProcessListForm.FormDestroy(Sender: TObject);
Begin
    ProcessList.Free;
End;

Procedure TProcessListForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_ITEM_ATTACHPROCESS];
    MainLabel.Caption := Lang[ID_MSG_ATTACH];
    MainLabel.Width := 360;
    OKBtn.Caption := Lang[ID_BTN_OK];
    CancelBtn.Caption := Lang[ID_BTN_CANCEL];
End;

End.
