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

Unit ToolFrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Menus, Graphics, Controls, Forms,
    StdCtrls, Buttons, ShellAPI, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QMenus, QGraphics, QControls, QForms,
  QStdCtrls, QButtons;
{$ENDIF}

Type
    { Tool List }

    PToolItem = ^TToolItem;
    TToolItem = Record
        Title: String;
        Exec: String;
        WorkDir: String;
        Params: String;
        IcoNumGnome: Integer;
        IcoNumBlue: Integer;
        IcoNumClassic: Integer;
        IcoNumNewLook: Integer;
        HasIcon: Boolean;
    End;

    TToolList = Class(TObject)
    Private
        fList: TList;
        Function GetItem(index: Integer): PToolItem;
        Procedure SetItem(index: Integer; Value: PToolItem);
        Function GetCount: Integer;
        Procedure Packit;
    Public
        Constructor Create;
        Destructor Destroy; Override;
        Function AddItem(Value: PToolItem): Integer;
        Procedure MoveItem(CurIndex, NewIndex: Integer);
        Procedure RemoveItem(index: Integer);
        Procedure LoadTools;
        Procedure SaveTools;
        Function ParseString(Const S: String): String;

        Property Items[index: Integer]: PToolItem Read GetItem Write SetItem;
            Default;
        Property Count: Integer Read GetCount;
    End;

    { Tool Edit Form }
    TToolController = Class;

    TToolForm = Class(TForm)
        grpCurrent: TGroupBox;
        btnClose: TBitBtn;
        ListBox: TListBox;
        btnUp: TSpeedButton;
        btnDown: TSpeedButton;
        XPMenu: TXPMenu;
        btnDelete: TSpeedButton;
        btnAdd: TSpeedButton;
        btnEdit: TSpeedButton;
        Procedure btnEditClick(Sender: TObject);
        Procedure btnAddClick(Sender: TObject);
        Procedure btnDeleteClick(Sender: TObject);
        Procedure ListBoxClick(Sender: TObject);
        Procedure PosbtnClick(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure FormShow(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
    Private
        fController: TToolController;
        Procedure UpdateList;
        Procedure UpdateButtons;
        Procedure LoadText;
    Public
        Property Controller: TToolController Read fController Write fController;
    End;

    TToolController = Class(TObject)
    Private
        fToolList: TToolList;
        fMenu: TMenuItem;
        fOnClick: TNotifyEvent;
        fOffset: Integer;
    Public
        Constructor Create;
        Destructor Destroy; Override;
        Procedure BuildMenu;
        Procedure Edit;
        Property Menu: TMenuItem Read fMenu Write fMenu;
        Property Offset: Integer Read fOffset Write fOffset;
        Property ToolClick: TNotifyEvent Read fOnClick Write fOnClick;
        Property ToolList: TToolList Read fToolList Write fToolList;
    End;

Implementation

Uses ToolEditFrm, inifiles, devcfg, utils, MultiLangSupport, datamod,
    version, main;

{$R *.dfm}


{ TToolList }

Constructor TToolList.Create;
Begin
    Inherited Create;
    fList := TList.Create;
End;

Destructor TToolList.Destroy;
Begin
    fList.Free;
    Inherited Destroy;
End;

Procedure TToolList.Packit;
Begin
    fList.Pack;
    fList.Capacity := fList.Count;
End;

Function TToolList.GetItem(index: Integer): PToolItem;
Begin
    result := fList[index];
End;

Procedure TToolList.SetItem(index: Integer; Value: PToolItem);
Begin
    fList[index] := Value;
End;

Function TToolList.GetCount: Integer;
Begin
    Packit;
    result := fList.Count;
End;

Function TToolList.AddItem(Value: PToolItem): Integer;
Begin
    result := fList.Add(Value);
End;

Procedure TToolList.MoveItem(CurIndex, NewIndex: Integer);
Begin
    fList.Move(CurIndex, NewIndex);
End;

Procedure TToolList.RemoveItem(index: Integer);
Begin
    fList.Delete(index);
    Packit;
End;

Procedure TToolList.LoadTools;
Var
    Count,
    idx: Integer;
    Item: PToolItem;
    Value,
    section: String;
Begin
    If Not FileExists(devDirs.Config + 'devcpp.cfg') Then
        exit;
    With TINIFile.Create(devDirs.Config + 'devcpp.cfg') Do
        Try
            Count := Readinteger('Tools', 'Count', 0);
            If Count <= 0 Then
                exit;
            For idx := 0 To pred(Count) Do
            Begin
                new(Item);
                Value := '';
                section := 'Tool' + inttostr(idx);
                Item^.Title := ReadString(section, 'Title', '');
                Value := ReadString(section, 'Program', '');
                value := ParseString(value);
                Item^.Exec := Value;
                Value := ReadString(section, 'WorkDir', '');
                value := ParseString(value);
                Item^.WorkDir := Value;
                Item^.Params := ReadString(section, 'Params', '');
                Item^.IcoNumGnome := -1;
                Item^.IcoNumBlue := -1;
                Item^.IcoNumClassic := -1;
                Item^.IcoNumNewLook := -1;
                Item^.HasIcon := False;
                AddItem(Item);
            End;
        Finally
            Free;
        End;
End;

Procedure TToolList.SaveTools;
Var
    tmp: TStringList;
    Count,
    idx: Integer;
    Value,
    section: String;
    item: PToolItem;
Begin
    With TINIFile.Create(devDirs.Config + 'devcpp.cfg') Do
        Try
            // remove extra sections if items removed
            Count := ReadInteger('Tools', 'Count', 0);
            If Count > fList.Count Then
            Begin
                tmp := TStringList.Create;
                Try
                    ReadSections(tmp);
                    For idx := fList.Count To Count Do
                        EraseSection('Tool' + inttostr(idx));
                Finally
                    tmp.Free;
                End;
            End;

            For idx := 0 To pred(fList.Count) Do
            Begin
                section := 'Tool' + inttostr(idx);
                Item := fList[idx];
                WriteString(section, 'Title', Item.Title);
                Value := Item.Exec;
                Value := ParseString(value);
                WriteString(section, 'Program', Value);

                Value := Item.WorkDir;
                Value := ParseString(Value);
                WriteString(section, 'WorkDir', Value);
                If (Item.Params <> '') And (Item.Params[1] = '"') And
                    (Item.Params[length(Item.Params)] = '"') Then
                    // fix the case of param surrounded by quotes
                    WriteString(section, 'Params', '"' + Item.Params + '"')
                Else
                    WriteString(section, 'Params', Item.Params);
            End;
            Writeinteger('Tools', 'Count', fList.Count);
        Finally
            free;
        End;
End;

Function TToolList.ParseString(Const s: String): String;
Begin
    result := StringReplace(s, devDirs.Exec, '<EXECPATH>', [rfReplaceAll]);
    result := StringReplace(Result, devDirs.Default, '<DEFAULT>', [rfReplaceAll]);
End;


{ TToolController }

Constructor TToolController.Create;
Begin
    Inherited;
    fMenu := Nil;
    fOffset := -1;
    fOnClick := Nil;
    fToolList := TToolList.Create;
    fToolList.LoadTools;
End;

Destructor TToolController.Destroy;
Begin
    If assigned(fMenu) Then
        fMenu.Clear;
    fToolList.SaveTools;
    fToolList.Free;
    Inherited;
End;

{ ** enable/disable if not executable }
Procedure TToolController.BuildMenu;
Var
    idx: Integer;
    Item: TMenuItem;
    Icon: TIcon;
    P: Pchar;
    w: Word;
    s: String;
Begin
    If Assigned(fMenu) Then
        idx := fMenu.Count - 1  //Clear Tools
    Else
        idx := -1;

    If idx > fOffset Then
        Repeat
            fMenu.Delete(idx);
            dec(idx);
        Until idx = fOffset;

    If Not Assigned(fMenu) Then
        Exit;

    If fToolList.Count > 0 Then
        //Rebuild menu
        For idx := 0 To pred(fToolList.Count) Do
        Begin
            Item := TMenuItem.Create(fMenu);
            TMainForm(Application.MainForm).XPMenu.InitComponent(Item);
            Item.Caption := fToolList.Items[idx].Title;
            Item.OnClick := fOnClick;
            Item.Tag := idx;
            If Not fToolList.Items[idx].HasIcon Then
            Begin
                Icon := TIcon.Create;
                Try
                    S := StringReplace(fToolList.Items[idx].Exec, '<DEFAULT>',
                        devDirs.Default, [rfReplaceAll]);
                    S := StringReplace(S, '<EXECPATH>', devDirs.Exec, [rfReplaceAll]);
                    If FileExists(S) Then
                    Begin
                        P := Pchar(S);
                        w := 0;
                        Icon.Handle := ExtractAssociatedIcon(hInstance, P, w);
                        If Icon.Handle > 0 Then
                        Begin
                            fToolList.Items[idx].IcoNumNewLook :=
                                dmMain.MenuImages_NewLook.AddIcon(Icon);
                            fToolList.Items[idx].IcoNumBlue :=
                                dmMain.MenuImages_Blue.AddIcon(Icon);
                            fToolList.Items[idx].IcoNumGnome :=
                                dmMain.MenuImages_Gnome.AddIcon(Icon);
                            fToolList.Items[idx].IcoNumClassic :=
                                dmMain.MenuImages_Classic.AddIcon(Icon);
                            fToolList.Items[idx].HasIcon := True;
                        End;
                    End;
                Finally
                    Icon.Free;
                End;
            End;
            If devData.Theme = DEV_GNOME_THEME Then
                Item.ImageIndex := fToolList.Items[idx].IcoNumGnome
            Else
            If devData.Theme = DEV_BLUE_THEME Then
                Item.ImageIndex := fToolList.Items[idx].IcoNumBlue
            Else
            If devData.Theme = DEV_CLASSIC_THEME Then
                Item.ImageIndex := fToolList.Items[idx].IcoNumClassic
            Else
                Item.ImageIndex := fToolList.Items[idx].IcoNumNewLook;
            fMenu.Add(Item);
        End;
    fMenu.Visible := fMenu.Count > 0;
End;

Procedure TToolController.Edit;
Begin
    With TToolForm.Create(Nil) Do
        Try
            Controller := Self;
            ShowModal;
            fToolList.SaveTools;
            BuildMenu;
        Finally
            Free;
        End;
End;

{ TToolForm }

Procedure TToolForm.btnEditClick(Sender: TObject);
Var
    Item: PToolItem;
Begin
    With TToolEditForm.Create(Nil) Do
        Try
            Item := fController.ToolList[ListBox.ItemIndex];
            edTitle.Text := Item.Title;
            edProgram.Text := fController.ToolList.ParseString(Item.Exec);
            edWorkDir.Text := fController.ToolList.ParseString(Item.WorkDir);
            edParams.Text := Item.Params;

            If ShowModal = mrOK Then
            Begin
                Item.Title := edTitle.Text;
                Item.Exec := fController.ToolList.ParseString(edProgram.Text);
                Item.WorkDir := fController.ToolList.ParseString(edWorkDir.text);
                Item.Params := edParams.Text;
                fController.ToolList[ListBox.ItemIndex] := Item;
                UpdateList;
            End;
        Finally
            Free;
            UpdateButtons;
        End;
End;

Procedure TToolForm.btnAddClick(Sender: TObject);
Var
    NewItem: PToolItem;
Begin
    With TToolEditForm.Create(Self) Do
        Try
            new(NewItem);
            edTitle.Text := '';
            edProgram.Text := '';
            edWorkDir.Text := '';
            edParams.Text := '';
            If ShowModal = mrOK Then
            Begin
                NewItem.Title := edTitle.Text;
                NewItem.Exec := edProgram.Text;
                NewItem.WorkDir := edWorkDir.Text;
                NewItem.Params := edParams.Text;

                fController.ToolList.AddItem(NewItem);
                UpdateList;
            End;
        Finally
            Free;
            UpdateButtons;
        End;
End;

Procedure TToolForm.btnDeleteClick(Sender: TObject);
Begin
    fController.ToolList.RemoveItem(Listbox.ItemIndex);
    ListBox.Items.Delete(ListBox.ItemIndex);
    UpdateButtons;
End;

Procedure TToolForm.ListBoxClick(Sender: TObject);
Begin
    UpdateButtons;
End;

Procedure TToolForm.PosbtnClick(Sender: TObject);
Begin
    Case (Sender As TSpeedButton).Tag Of
        1: //move up
        Begin
            fController.ToolList.MoveItem(ListBox.ItemIndex, ListBox.ItemIndex - 1);
            ListBox.Items.Exchange(ListBox.ItemIndex, Listbox.ItemIndex - 1);
        End;
        2: //move down
        Begin
            fController.ToolList.MoveItem(ListBox.ItemIndex, ListBox.ItemIndex + 1);
            ListBox.Items.Exchange(ListBox.ItemIndex, Listbox.ItemIndex + 1);
        End;
    End;
    ListBox.SetFocus;
    UpdateButtons;
End;

Procedure TToolForm.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    action := caFree;
End;

Procedure TToolForm.FormShow(Sender: TObject);
Begin
    UpdateList;
End;

Procedure TToolForm.UpdateList;
Var
    idx: Integer;
Begin
    ListBox.Clear;
    For idx := 0 To pred(fController.ToolList.Count) Do
        ListBox.Items.Append(fController.ToolList[idx].Title);
    UpdateButtons;
End;

Procedure TToolForm.UpdateButtons;
Begin
    btnDown.Enabled := (ListBox.ItemIndex < pred(Listbox.Count)) And
        (ListBox.ItemIndex > -1);
    btnUp.Enabled := ListBox.ItemIndex > 0;
    btnEdit.Enabled := Listbox.ItemIndex > -1;
    btnDelete.Enabled := ListBox.ItemIndex > -1;
End;

Procedure TToolForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_TF];
    grpCurrent.Caption := Lang[ID_TF_LABEL];

    btnAdd.Caption := Lang[ID_BTN_ADD];
    btnDelete.Caption := Lang[ID_BTN_DELETE];
    btnEdit.Caption := Lang[ID_BTN_EDIT];
    btnClose.Caption := Lang[ID_BTN_CLOSE];
End;

Procedure TToolForm.FormCreate(Sender: TObject);
Begin
    LoadText;
End;

End.
