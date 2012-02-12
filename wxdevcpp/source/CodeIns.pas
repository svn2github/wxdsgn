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

Unit CodeIns;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, Variants, Classes, Graphics, Controls, Forms,
    ExtCtrls, Buttons, StdCtrls, XPMenu, Spin;
{$ENDIF}
{$IFDEF LINUX}
  Variants, Classes, QGraphics, QControls, QForms,
  QComCtrls, QExtCtrls, QButtons, QStdCtrls;
{$ENDIF}

Type
    PCodeIns = ^TCodeIns;
    TCodeIns = Record
        Caption: String;
        Line: String;
        Desc: String;
        Sep: Integer;
    End;

    TCodeInsList = Class(TObject)
    Private
        fFile: String;
        fList: TList;
        Procedure SetItem(index: Integer; Value: PCodeIns);
        Function GetItem(index: Integer): PCodeIns;
        Function GetCount: Integer;
    Public
        Constructor Create;
        Destructor Destroy; Override;

        Procedure LoadCode;
        Procedure SaveCode;
        Function Indexof(Const Value: String): Integer;
        Function AddItem(Value: PCodeIns): Integer;
        Procedure Delete(index: Integer);
        Procedure Clear;
        Property Items[index: Integer]: PCodeins Read GetItem Write SetItem;
            Default;
        Property Count: Integer Read GetCount;
    End;

    TfrmCodeEdit = Class(TForm)
        lblMenu: TLabel;
        lblSec: TLabel;
        edMenuText: TEdit;
        seSection: TSpinEdit;
        btnOk: TBitBtn;
        btnCancel: TBitBtn;
        lblDesc: TLabel;
        edDesc: TEdit;
        XPMenu: TXPMenu;
        Procedure FormCreate(Sender: TObject);
        Procedure btnOkClick(Sender: TObject);
        Procedure edMenuTextChange(Sender: TObject);
    Private
        fEdit: Boolean;
        fEntry: PCodeIns;
        Procedure SetEntry(Value: PCodeIns);
        Procedure LoadText;
    Public
        Property Edit: Boolean Read fEdit Write fEdit;
        Property Entry: PCodeIns Read fEntry Write SetEntry;
    Protected
        Procedure CreateParams(Var Params: TCreateParams); Override;
    End;

Implementation

Uses
    SysUtils, IniFiles, devCFG, Utils, version, MultiLangSupport;

{$R *.dfm}
{ TCodeInsList }

Constructor TCodeInsList.Create;
Begin
    Inherited Create;
    fList := TList.Create;
End;

Destructor TCodeInsList.Destroy;
Var
    idx: Integer;
Begin
    For idx := 0 To pred(fList.Count) Do
        dispose(fList[idx]);
    fList.Free;
    Inherited Destroy;
End;

Function TCodeInsList.Indexof(Const Value: String): Integer;
Begin
    For result := 0 To pred(fList.Count) Do
        If AnsiCompareText(PCodeIns(fList[result])^.Caption, Value) = 0 Then
            exit;
    result := -1;
End;

Function TCodeInsList.AddItem(Value: PCodeIns): Integer;
Begin
    result := fList.Add(Value);
End;

Procedure TCodeInsList.Clear;
Begin
    fList.Clear;
    fList.Pack;
    fList.Capacity := fList.Count;
End;

Procedure TCodeInsList.Delete(index: Integer);
Begin
    If (index < 0) Or (index > fList.Count - 1) Then
        exit;

    fList.Delete(index);
    fList.Pack;
    fList.Capacity := fList.Count;
End;

Function TCodeInsList.GetCount: Integer;
Begin
    result := fList.Count;
End;

Function TCodeInsList.GetItem(index: Integer): PCodeIns;
Begin
    If (index < 0) Or (index > fList.Count - 1) Then
        result := Nil
    Else
        result := PCodeIns(fList[index]);
End;

Procedure TCodeInsList.SetItem(index: Integer; Value: PCodeIns);
Begin
    fList[index] := Value;
End;

Procedure TCodeInsList.LoadCode;
Var
    Item: PCodeIns;
    tmp: TStringList;
    idx: Integer;
Begin
    If Not FileExists(fFile) Then
        fFile := devDirs.Config + DEV_CODEINS_FILE;

    If FileExists(fFile) Then
        With TINIFile.Create(fFile) Do
            Try
                tmp := TStringList.Create;
                Clear;
                Try
                    ReadSections(tmp);
                    If tmp.Count = 0 Then
                        exit;
                    For idx := 0 To pred(tmp.Count) Do
                    Begin
                        new(Item);
                        Item^.Caption := StringReplace(tmp[idx], '_', ' ', [rfReplaceAll]);
                        Item^.Desc := ReadString(tmp[idx], 'Desc', '');
                        Item^.Line := StrtoCodeIns(ReadString(tmp[idx], 'Line', ''));
                        Item^.Sep := ReadInteger(tmp[idx], 'Sep', 0);
                        AddItem(Item);
                    End;
                Finally
                    tmp.free;
                End;
            Finally
                free;
            End;
End;

Procedure TCodeInsList.SaveCode;
Var
    idx: Integer;
    section: String;
    CI: TCodeIns;
Begin
    fList.Pack;
    fList.Capacity := fList.Count;
    DeleteFile(fFile);
    If fList.Count = 0 Then
        exit;
    With TINIFile.Create(fFile) Do
        Try
            For idx := 0 To pred(fList.Count) Do
            Begin
                CI := PCodeIns(fList[idx])^;
                section := StringReplace(CI.Caption, ' ', '_', [rfReplaceAll]);
                EraseSection(section); // may be redundent
                WriteString(section, 'Desc', CI.Desc);
                WriteString(section, 'Line', CodeInstoStr(CI.Line));
                WriteInteger(section, 'Sep', CI.Sep);
            End;
        Finally
            free;
        End;
End;

{ TfrmCodeEdit }

Procedure TfrmCodeEdit.SetEntry(Value: PCodeIns);
Begin
    edMenuText.Text := Value^.Caption;
    edDesc.Text := Value^.Desc;
    seSection.Value := Value^.Sep;
End;

Procedure TfrmCodeEdit.FormCreate(Sender: TObject);
Begin
    LoadText;
End;

Procedure TfrmCodeEdit.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    If Edit Then
        Caption := Lang[ID_CIE_EDCAPTION]
    Else
        Caption := Lang[ID_CIE_ADDCAPTION];

    lblMenu.Caption := Lang[ID_CIE_MENU];
    lblDesc.Caption := Lang[ID_CIE_DESC];
    lblSec.Caption := Lang[ID_CIE_SEC];
    btnOk.Caption := Lang[ID_BTN_OK];
    btnCancel.Caption := Lang[ID_BTN_CANCEL];
End;

Procedure TfrmCodeEdit.btnOkClick(Sender: TObject);
Begin
    If edMenuText.Text = '' Then
    Begin
        ModalResult := mrNone;
    End;
End;

Procedure TfrmCodeEdit.edMenuTextChange(Sender: TObject);
Begin
    btnOK.Enabled := edMenuText.Text <> '';
End;

Procedure TfrmCodeEdit.CreateParams(Var Params: TCreateParams);
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
