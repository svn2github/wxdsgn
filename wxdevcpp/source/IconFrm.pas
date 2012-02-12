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

Unit IconFrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Forms,
    ImgList, ComCtrls, Buttons, StdCtrls, Controls, Dialogs, ExtDlgs, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QForms, 
  QImgList, QComCtrls, QButtons, QStdCtrls, QControls, QDialogs;
{$ENDIF}

Type
    TIconForm = Class(TForm)
        btnOk: TBitBtn;
        btnCancel: TBitBtn;
        ImageList: TImageList;
        dlgPic: TOpenPictureDialog;
        IconView: TListView;
        XPMenu: TXPMenu;
        Procedure btnOkClick(Sender: TObject);
        Procedure FormActivate(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Procedure IconViewInfoTip(Sender: TObject; Item: TListItem;
            Var InfoTip: String);
        Procedure IconViewDblClick(Sender: TObject);
    Private
        Procedure LoadText;
        Function AddItem(Const FileName: String): TListItem;
        Function GetSelected: String;
    Public
        Property Selected: String Read GetSelected;
    End;

{ ** modify with browse ablity - include options to copy ico to directory}

Implementation

Uses Version, MultiLangSupport, devcfg, utils;

{$R *.dfm}

Procedure TIconForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_IF];
    btnOk.Caption := Lang[ID_IF_USEICO];
    btnCancel.Caption := Lang[ID_BTN_CANCEL];
End;

Procedure TIconForm.btnOkClick(Sender: TObject);
Begin
    If IconView.Selected = Nil Then
    Begin
        ModalResult := mrNone;
        exit;
    End;
End;

Procedure TIconForm.FormActivate(Sender: TObject);
Begin
End;

// modifed to work with multiple directories.

Procedure TIconForm.FormCreate(Sender: TObject);
Var
    SRec: TSearchRec;
    SFile: String;
    tmp: TStrings;
    idx: Integer;
Begin
    LoadText;
    With IconView Do
        Try
            ImageList.Clear;
            Items.BeginUpdate;
            Items.Clear;
            tmp := TStringList.Create;
            Try
                StrtoList(devDirs.Icons, tmp);
                If tmp.Count > 0 Then
                    For idx := 0 To pred(tmp.Count) Do
                    Begin
                        sFile := ExpandFileto(tmp[idx], devDirs.Exec) + '*.ico';
                        If FindFirst(sFile, faAnyFile, SRec) = 0 Then
                            Repeat
                                // pase filename with full path
                                Self.AddItem(IncludeTrailingPathDelimiter(tmp[idx]) + srec.Name);
                            Until FindNext(SRec) <> 0;
                    End;
            Finally
                tmp.Free;
            End;
        Finally
            Items.EndUpdate;
        End;
End;

Procedure TIconForm.FormDestroy(Sender: TObject);
Begin
    ImageList.Clear;
End;

Function TIconForm.GetSelected: String;
Begin
    If assigned(IconView.Selected) Then
        result := IconView.Selected.SubItems[0]
    Else
        result := '';
End;

Function TIconForm.AddItem(Const FileName: String): TListItem;
Var
    icon: TIcon;
    Item: TListItem;
    fFile: String;
Begin
    Item := IconView.Items.Add;
    //full path is passed from FormCreate
    fFile := FileName;
    Item.SubItems.Add(fFile);
    Icon := TIcon.Create;
    Icon.LoadFromFile(fFile);
    Item.ImageIndex := ImageList.AddIcon(Icon);
    result := Item;

    fFile := ExtractFileName(fFile);
    Item.Caption := copy(fFile, 1, length(FFile) -
        length(ExtractFileExt(FFile)));
    // need to add for including more directories
End;

Procedure TIconForm.IconViewInfoTip(Sender: TObject; Item: TListItem;
    Var InfoTip: String);
Begin
    InfoTip := Item.SubItems[0];
End;

Procedure TIconForm.IconViewDblClick(Sender: TObject);
Begin
    ModalResult := mrOk;
End;

End.
