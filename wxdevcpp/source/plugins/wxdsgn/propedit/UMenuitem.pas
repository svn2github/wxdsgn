{*
 $Id: UMenuitem.pas 937 2007-05-15 03:50:34Z gururamnath $
Add support for MenuHightLight event
*}
{                                                                    }
{   Copyright © 2003-2007 by Guru Kathiresan                         }
{                                                                    }
{License :                                                           }
{=========                                                           }
{The wx-devC++ Components, Form Designer, Utils classes              }
{are exclusive properties of Guru Kathiresan.                        }
{The code is available in dual Licenses:                             }
{                               1)GPL Compatible  License            }
{                               2)Commercial License                 }
{                                                                    }
{1)GPL License :                                                     }
{ Code can be used in any project as long as the project's sourcecode}
{ is published under GPL license.                                    }
{                                                                    }
{2)Commercial License:                                               }
{Use of code in this file or the one that bear this license text     }
{can be used in Non-GPL projects as long as you get the permission   }
{from the Author - Guru Kathiresan.                                  }
{Use of the Code in any non-gpl projects without the permission of   }
{the author is illegal.                                              }
{Contact gururamnath@yahoo.com for details                           }
{ ****************************************************************** }

Unit UMenuitem;

Interface

Uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, Menus, ExtCtrls, WxCustomMenuItem, DateUtils, xprocs, wxUtils,
    UPicEdit, Spin, strUtils, ComCtrls, XPMenu;

{$WARNINGS OFF}
Type
    TMenuItemForm = Class(TForm)
        GroupBox1: TGroupBox;
        GroupBox2: TGroupBox;
        tvMenuItem: TTreeView;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label5: TLabel;
        Label8: TLabel;
        Label12: TLabel;
        cbMenuType: TComboBox;
        txtCaption: TEdit;
        cbChecked: TComboBox;
        cbEnabled: TComboBox;
        txtHint: TEdit;
        btnOK: TButton;
        btnCancel: TButton;
        btnInsert: TButton;
        btnDelete: TButton;
        btnSubmenu: TButton;
        PopupMenu1: TPopupMenu;
        iNSERT1: TMenuItem;
        Delete1: TMenuItem;
        N1: TMenuItem;
        CreateSubmenu1: TMenuItem;
        GroupBox3: TGroupBox;
        Label4: TLabel;
        cbOnMenu: TComboBox;
        Label6: TLabel;
        cbOnUpdateUI: TComboBox;
        Label7: TLabel;
        txtIDValue: TEdit;
        Label10: TLabel;
        btBrowse: TButton;
        btApply: TButton;
        btEdit: TButton;
        txtIDName: TComboBox;
        btNewOnMenu: TButton;
        btNewUpdateUI: TButton;
        pnlMenuImage: TPanel;
        bmpMenuImage: TImage;
        XPMenu: TXPMenu;
        Procedure btnInsertClick(Sender: TObject);
        Procedure btnSubmenuClick(Sender: TObject);
        Procedure txtCaptionKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure btnDeleteClick(Sender: TObject);
        Procedure Delete1Click(Sender: TObject);
        Procedure iNSERT1Click(Sender: TObject);
        Procedure CreateSubmenu1Click(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure tvMenuItemChange(Sender: TObject; Node: TTreeNode);
        Procedure txtCaptionExit(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Procedure btApplyClick(Sender: TObject);
        Procedure btEditClick(Sender: TObject);
        Procedure cbMenuTypeChange(Sender: TObject);
        Procedure btBrowseClick(Sender: TObject);
        Procedure btNewOnMenuClick(Sender: TObject);
        Procedure btNewUpdateUIClick(Sender: TObject);
        Procedure tvMenuItemDragDrop(Sender, Source: TObject; X, Y: Integer);
        Procedure tvMenuItemDragOver(Sender, Source: TObject; X, Y: Integer;
            State: TDragState; Var Accept: Boolean);
        Procedure tvMenuItemKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure txtIDNameChange(Sender: TObject);

    Private
    { Private declarations }
        FMaxID: Integer;
        FCounter: Integer;
        FSubMenuItemCreationClicked: Boolean;
        FShiftDown: Boolean;
        FMenuName: String;

        Procedure MoveNode(SourceNode, TargetNode: TTreeNode);

    Public
    { Public declarations }
        FMenuItems: TWxCustomMenuItem;
        Constructor Create(AOwner: TComponent; ParentMenuName: String);
        Procedure SetMaxID(Value: Integer);

        Procedure UpdateScreenDataFromMenuItemData(cmenu: TWxCustomMenuItem);
        Procedure UpdateMenuItemDataFromScreenData(cmenu: TWxCustomMenuItem);
        Function GetFunctionName(strF: String): String;
        Procedure SetMenuItemsAsc(ThisOwnerControl, ThisParentControl: TWinControl;
            SourceMenuItems: TWxCustomMenuItem; DestMenuItems: TWxCustomMenuItem);
        Procedure SetMenuItemsDes(ThisOwnerControl, ThisParentControl: TWinControl;
            SourceMenuItems: TWxCustomMenuItem; DestMenuItems: TWxCustomMenuItem);
        Procedure EnableUpdate;
        Procedure DisableUpdate;
        Function GetValidMenuName(str: String): String;
        Function NextValue(str: String): String;
        Procedure CopyMenuItem(SrcMenuItem: TWxCustomMenuItem; Var DesMenuItem: TWxCustomMenuItem);
    End;
{$WARNINGS ON}

Var
    MenuItemForm: TMenuItemForm;

Implementation
{$R *.DFM}

Uses wxdesigner, CreateOrderFm;

Constructor TMenuItemForm.Create(AOwner: TComponent; ParentMenuName: String);
Begin
    FMenuName := ParentMenuName;
    Inherited Create(AOwner);
End;

{$IFDEF DELPHI4}
constructor TMenuItemForm.Create(AOwner: TComponent{; Designer: IFormDesigner});
begin
  //FDesigner:= Designer;
  inherited Create(AOwner);
end;
{$ENDIF}

Procedure TMenuItemForm.btnInsertClick(Sender: TObject);
Var
    MenuItem: TWxCustomMenuItem;
    Node: TTreeNode;
Begin
    MenuItem := TWxCustomMenuItem.Create(Nil);
    Inc(FMaxID);
    Inc(FCounter);

    MenuItem.Wx_IDValue := FMaxID;
    MenuItem.Wx_Caption := 'MenuItem' + IntToStr(FCounter);

    If (tvMenuItem.Items.Count = 0) Then  // No other nodes exist so let's add the first
    Begin
        Node := tvMenuItem.Items.AddChildObject(Nil, MenuItem.Wx_Caption, MenuItem);
        FMenuItems.Add(MenuItem, FMenuItems.Count);
    End

    Else
    If (tvMenuItem.Selected.GetNextSibling <> Nil) Then
    // Other siblings exist, let's insert it
    Begin
     // New behavior inserts the node after the currently selected node
        Node := tvMenuItem.Items.InsertObject(tvMenuItem.Selected.GetNextSibling,
            MenuItem.Wx_Caption, MenuItem);
        FMenuItems.Wx_Items.Insert(Node.Index, MenuItem);
    End
    Else
    Begin
        Node := tvMenuItem.Items.AddChildObject(Nil,
            MenuItem.Wx_Caption, MenuItem);
        FMenuItems.Add(MenuItem, FMenuItems.Count);
    End;

    tvMenuItem.Selected := Node;
    tvMenuItem.SetFocus;
    EnableUpdate;

    txtIDValue.Text := IntToStr(FMaxID);
    txtCaption.Text := 'MenuItem' + IntToStr(FCounter);
    txtCaption.SetFocus;
  //Just to refresh the checked combo status
    self.cbMenuTypeChange(self);

End;

Procedure TMenuItemForm.EnableUpdate;
Begin
    btApply.Enabled := True;
    btEdit.Enabled := False;
    tvMenuItem.Enabled := False;
    btnSubmenu.Enabled := False;
    btnInsert.Enabled := False;
    btnDelete.Enabled := False;
    btnOK.Enabled := False;
    btnCancel.Enabled := True;

    txtCaption.Enabled := True;
    txtHint.Enabled := True;
    txtIDName.Enabled := True;
    txtIDValue.Enabled := Not AnsiStartsStr('wxID', txtIDName.Text);
    cbEnabled.Enabled := True;
    cbChecked.Enabled := True;
    bmpMenuImage.Enabled := True;
    btBrowse.Enabled := True;
    cbMenuType.Enabled := True;
    cbOnMenu.Enabled := True;
    cbOnUpdateUI.Enabled := True;
    btNewOnMenu.Enabled := True;
    btNewUpdateUI.Enabled := True;
End;

Procedure TMenuItemForm.DisableUpdate;
Begin
    btApply.Enabled := False;
    tvMenuItem.Enabled := True;
    btnSubmenu.Enabled := True;
    btnInsert.Enabled := True;
    btnOK.Enabled := True;
    btnCancel.Enabled := True;
    btEdit.Enabled := tvMenuItem.Selected <> Nil;
    btnDelete.Enabled := tvMenuItem.Selected <> Nil;

    txtCaption.Enabled := False;
    txtHint.Enabled := False;
    txtIDName.Enabled := False;
    txtIDValue.Enabled := False;
    cbEnabled.Enabled := False;
    cbChecked.Enabled := False;
    bmpMenuImage.Enabled := False;
    btBrowse.Enabled := False;
    cbMenuType.Enabled := False;
    cbOnMenu.Enabled := False;
    cbOnUpdateUI.Enabled := False;
    btNewOnMenu.Enabled := False;
    btNewUpdateUI.Enabled := False;

End;

Procedure TMenuItemForm.btnSubmenuClick(Sender: TObject);
Var
    Node: TTreeNode;
    MenuItem: TWxCustomMenuItem;
    curMnuItem: TWxCustomMenuItem;
Begin
    If tvMenuItem.Selected = Nil Then
        Exit;
    If TWxCustomMenuItem(tvMenuItem.Selected.Data).Wx_MenuItemStyle = wxMnuItm_History Then
    Begin
        MessageDlg('Children cannot be added to the Recent File History', mtError, [mbOK], Handle);
        Exit;
    End;

    FSubMenuItemCreationClicked := True;
    MenuItem := TWxCustomMenuItem.Create(Nil);
    Inc(FCounter);
    Inc(FMaxID);

    MenuItem.Wx_Caption := 'SubMenuItem' + IntToStr(FCounter);
    MenuItem.Wx_IDValue := FMaxID;
    curMnuItem := TWxCustomMenuItem(tvMenuItem.Selected.Data);
    Node := tvMenuItem.Items.AddChildObject(tvMenuItem.Selected,
        MenuItem.Wx_Caption, MenuItem);
    If Node <> Nil Then
        tvMenuItem.Selected := Node;
    curMnuItem.Add(MenuItem, curMnuItem.Count);
    tvMenuItem.SetFocus;
    EnableUpdate;
    txtIDValue.Text := IntToStr(FMaxID);
    txtCaption.Text := 'SubMenuItem' + IntToStr(FCounter);
    txtCaption.SetFocus;
End;

Procedure TMenuItemForm.txtCaptionKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If Key = VK_RETURN Then
        txtCaptionExit(Sender);
End;

Procedure TMenuItemForm.btnDeleteClick(Sender: TObject);
Begin
    If tvMenuItem.Selected = Nil Then
        Exit;

    If tvMenuItem.Selected.Parent <> Nil Then
        TWxCustomMenuItem(tvMenuItem.Selected.Parent.Data).Remove(
            TWxCustomMenuItem(tvMenuItem.Selected.Data))
    Else
        FMenuItems.Remove(TWxCustomMenuItem(tvMenuItem.Selected.Data));

    tvMenuItem.Items.Delete(tvMenuItem.Selected);
    tvMenuItem.SetFocus;
    If tvMenuItem.Selected <> Nil Then
        UpdateScreenDataFromMenuItemData(TWxCustomMenuItem(tvMenuItem.Selected.Data));
    DisableUpdate;
End;

Procedure TMenuItemForm.Delete1Click(Sender: TObject);
Begin
    btnDeleteClick(self);
End;

Procedure TMenuItemForm.iNSERT1Click(Sender: TObject);
Begin
    btnInsertClick(self);
End;

Procedure TMenuItemForm.CreateSubmenu1Click(Sender: TObject);
Begin
    btnSubmenuClick(self);
End;

Procedure TMenuItemForm.UpdateScreenDataFromMenuItemData(cmenu: TWxCustomMenuItem);
Begin
    txtCaption.Text := cmenu.Wx_Caption;
    txtHint.Text := cmenu.Wx_HelpText;

    txtIDName.Text := cmenu.Wx_IDName;
    txtIDValue.Text := IntToStr(cmenu.Wx_IDValue);

    If cmenu.Wx_Enabled Then
        cbEnabled.ItemIndex := 1
    Else
        cbEnabled.ItemIndex := 0;

    If cmenu.Wx_Checked Then
        cbChecked.ItemIndex := 1
    Else
        cbChecked.ItemIndex := 0;

    bmpMenuImage.Picture.Assign(cmenu.WX_BITMAP);

    If cmenu.Wx_MenuItemStyle = wxMnuItm_Normal Then
        cbMenuType.ItemIndex := 0;

    If cmenu.Wx_MenuItemStyle = wxMnuItm_Separator Then
        cbMenuType.ItemIndex := 1;

    If cmenu.Wx_MenuItemStyle = wxMnuItm_Radio Then
        cbMenuType.ItemIndex := 3;

    If cmenu.Wx_MenuItemStyle = wxMnuItm_Check Then
        cbMenuType.ItemIndex := 2;

    If cmenu.Wx_MenuItemStyle = wxMnuItm_History Then
        cbMenuType.ItemIndex := 4;

    cbOnMenu.Text := cmenu.EVT_Menu;
    cbOnUpdateUI.Text := cmenu.EVT_UPDATE_UI;
End;

Procedure TMenuItemForm.UpdateMenuItemDataFromScreenData(cmenu: TWxCustomMenuItem);
Var
    FName: String;
Begin

    cmenu.Wx_Caption := txtCaption.Text;
    cmenu.Wx_HelpText := txtHint.Text;

    cmenu.Wx_IDName := txtIDName.Text;
    If txtIDValue.Enabled Then
        cmenu.Wx_IDValue := StrToInt(txtIDValue.Text);

    If cbEnabled.ItemIndex = 1 Then
        cmenu.Wx_Enabled := True
    Else
        cmenu.Wx_Enabled := False;

    If cbChecked.ItemIndex = 1 Then
        cmenu.Wx_Checked := True
    Else
        cmenu.Wx_Checked := False;

    cmenu.WX_BITMAP.Assign(bmpMenuImage.Picture);

    cmenu.Wx_MenuItemStyle := wxMnuItm_Normal;

    If cbMenuType.ItemIndex = 0 Then
        cmenu.Wx_MenuItemStyle := wxMnuItm_Normal
    Else
    If cbMenuType.ItemIndex = 1 Then
        cmenu.Wx_MenuItemStyle := wxMnuItm_Separator
    Else
    If cbMenuType.ItemIndex = 3 Then
        cmenu.Wx_MenuItemStyle := wxMnuItm_Radio
    Else
    If cbMenuType.ItemIndex = 2 Then
        cmenu.Wx_MenuItemStyle := wxMnuItm_Check
    Else
    If cbMenuType.ItemIndex = 4 Then
    Begin
        cmenu.Wx_MenuItemStyle := wxMnuItm_History;
    End;

    cmenu.EVT_Menu := cbOnMenu.Text;
    cmenu.EVT_UPDATE_UI := cbOnUpdateUI.Text;
    FName := wx_designer.main.GetActiveEditorName;
    GenerateXPMDirectly(cmenu.WX_BITMAP.Bitmap, cmenu.wx_IDName, ChangeFileExt(ExtractFileName(FName), ''), FName);
End;

Procedure TMenuItemForm.SetMaxID(Value: Integer);
Begin
    FMaxID := Value;
End;

Procedure TMenuItemForm.SetMenuItemsAsc(ThisOwnerControl, ThisParentControl: TWinControl;
    SourceMenuItems: TWxCustomMenuItem; DestMenuItems: TWxCustomMenuItem);
Var
    I: Integer;
    Node: TTreeNode;
    S: String;
    Item: TWxCustomMenuItem;
    aItem: TWxCustomMenuItem;

    Procedure AddSubMenuitem(Menuitem: TWxCustomMenuItem;
        Nd: TTreeNode; anotherItemToAdd: TWxCustomMenuItem);
    Var
        J: Integer;
        Cap: String;
        MItem, aMitem: TWxCustomMenuItem;
        TNode: TTreeNode;
    Begin
        For J := MenuItem.Count - 1 Downto 0 Do
        Begin
            MItem := MenuItem.Items[J];
            Cap := MItem.Wx_Caption;
            aMitem := TWxCustomMenuItem.Create(ThisParentControl);
            CopyMenuItem(MItem, aMitem);
      //aMitem.Caption:=MItem.Caption;
            TNode := tvMenuItem.Items.AddChildObject(Nd, Cap, aMitem);
            TNode.Text := Cap;
            anotherItemToAdd.Add(aMitem, 0);
            Inc(FCounter);
            If MItem.Count > 0 Then
                AddSubMenuitem(MItem, TNode, aMitem);
        End;
    End;

Begin
  //DestMenuItems.Clear;
    FCounter := 0;
    For I := SourceMenuItems.Count - 1 Downto 0 Do
    Begin
    //TODO: Guru: <Blank Todo string>
        aItem := TWxCustomMenuItem.Create(ThisParentControl);
        Item := (SourceMenuItems.Items[I]);
        S := Item.Wx_Caption;
        aItem.Wx_Caption := Item.Wx_Caption;
        CopyMenuItem(Item, aItem);
        DestMenuItems.add(aItem, 0);
        Node := tvMenuItem.Items.AddChildObject(Nil, S, aItem);
        Inc(FCounter);
        If Item.Count > 0 Then
            AddSubMenuitem(Item, Node, aItem);
    End;
End;

Procedure TMenuItemForm.SetMenuItemsDes(ThisOwnerControl, ThisParentControl: TWinControl;
    SourceMenuItems: TWxCustomMenuItem; DestMenuItems: TWxCustomMenuItem);
Var
    I: Integer;
    Node: TTreeNode;
    S: String;
    Item: TWxCustomMenuItem;
    aItem: TWxCustomMenuItem;

    Procedure AddSubMenuitem(Menuitem: TWxCustomMenuItem;
        Nd: TTreeNode; anotherItemToAdd: TWxCustomMenuItem);
    Var
        J: Integer;
        Cap: String;
        MItem, aMitem: TWxCustomMenuItem;
        TNode: TTreeNode;
    Begin
        For J := 0 To MenuItem.Count - 1 Do
        Begin
            MItem := MenuItem.Items[J];
            Cap := MItem.Wx_Caption;
            aMitem := TWxCustomMenuItem.Create(ThisParentControl);
            CopyMenuItem(MItem, aMitem);
      //aMitem.Caption:=MItem.Caption;
            TNode := tvMenuItem.Items.AddChildObject(Nd, Cap, aMitem);
            TNode.Text := Cap;
            anotherItemToAdd.Add(aMitem, J);
            Inc(FCounter);
            If MItem.Count > 0 Then
                AddSubMenuitem(MItem, TNode, aMitem);
        End;
    End;

Begin
  //DestMenuItems.Clear;
    FCounter := 0;
    For I := 0 To SourceMenuItems.Count - 1 Do
    Begin
    //TODO: Guru: <Blank Todo string>
        aItem := TWxCustomMenuItem.Create(ThisParentControl);
        Item := (SourceMenuItems.Items[I]);
        S := Item.Wx_Caption;
        aItem.Wx_Caption := Item.Wx_Caption;
        CopyMenuItem(Item, aItem);
        DestMenuItems.add(aItem, I);
        Node := tvMenuItem.Items.AddChildObject(Nil, S, aItem);
        Inc(FCounter);
        If Item.Count > 0 Then
            AddSubMenuitem(Item, Node, aItem);
    End;
End;

Procedure TMenuItemForm.FormCreate(Sender: TObject);
Var
    strLst: TStringList;
Begin
    DesktopFont := True;
    XPMenu.Active := wx_designer.XPTheme;
    tvMenuItem.Items.Clear;
    FSubMenuItemCreationClicked := False;
    txtIDName.Items.Assign(wx_designer.strStdwxIDList);

    FMenuItems := TWxCustomMenuItem.Create(Nil);
    FMaxID := 2000;
    strLst := TStringList.Create;
    wx_designer.main.GetFunctionsFromSource(wx_designer.GetCurrentClassName, strLst);

    cbOnMenu.Items.Assign(strLst);
    cbOnUpdateUI.Items.Assign(strLst);
    strLst.Destroy;
End;

Procedure TMenuItemForm.tvMenuItemChange(Sender: TObject; Node: TTreeNode);
Begin
  //Update the button states
    btEdit.Enabled := Node <> Nil;
    btnDelete.Enabled := Node <> Nil;

  //Exit if we don't have a selected node
    If Node = Nil Then
        Exit;

  //Otherwise update the editor data
    With TWxCustomMenuItem(Node.Data) Do
    Begin
        txtCaption.Text := Wx_Caption;
        txtIDValue.Text := IntToStr(Wx_IDValue);
        txtIDName.Text := Wx_IDName;
        UpdateScreenDataFromMenuItemData(TWxCustomMenuItem(tvMenuItem.Selected.Data));
    End;
End;

Function TMenuItemForm.GetValidMenuName(str: String): String;
Var
    i: Integer;
    lastTabIndex: Integer;

    Function AnsiPosR(Const needle, haystack: String): Integer;
    Var
        Temp: String;
    Begin
        For Result := Length(haystack) Downto 0 Do
        Begin
            Temp := Copy(haystack, Result, Length(needle));
      //Do we have a match?
            If Temp = needle Then
                break;
        End;
    End;
Begin
  //Strip the string starting from the last \t
    lastTabIndex := AnsiPosR('\t', str);
    If lastTabIndex > 0 Then
        str := Copy(str, 0, lastTabIndex - 1);

  //TODO: Guru: <Blank Todo string>
    Result := UpperCase(trim(str));

  // Added by Termit
  // In polish language use code page 8859-2 or Win-1250 with character up to 127 code
  //change characters up to 127 code
    For i := 1 To Length(Result) Do
        If Ord(Result[i]) > 127 Then
            Result[i] :=
                '_';

    strSearchReplace(Result, ' ', '', [srAll]);
    strSearchReplace(Result, '&', '', [srAll]);
    strSearchReplace(Result, '\t', '_', [srAll]);
    strSearchReplace(Result, '-', '_', [srAll]);
    strSearchReplace(Result, '~', '_', [srAll]);
    strSearchReplace(Result, '*', '_', [srAll]);
    strSearchReplace(Result, '!', '_', [srAll]);
    strSearchReplace(Result, '@', '_', [srAll]);
    strSearchReplace(Result, '#', '_', [srAll]);
    strSearchReplace(Result, '$', '_', [srAll]);
    strSearchReplace(Result, '%', '_', [srAll]);
    strSearchReplace(Result, '^', '_', [srAll]);
    strSearchReplace(Result, '&', '_', [srAll]);
    strSearchReplace(Result, '*', '_', [srAll]);
    strSearchReplace(Result, '(', '_', [srAll]);
    strSearchReplace(Result, ')', '_', [srAll]);
    strSearchReplace(Result, ';', '_', [srAll]);
    strSearchReplace(Result, ':', '_', [srAll]);
    strSearchReplace(Result, '+', '_', [srAll]);
    strSearchReplace(Result, '=', '_', [srAll]);
    strSearchReplace(Result, '{', '_', [srAll]);
    strSearchReplace(Result, '}', '_', [srAll]);
    strSearchReplace(Result, '[', '_', [srAll]);
    strSearchReplace(Result, ']', '_', [srAll]);
    strSearchReplace(Result, '|', '_', [srAll]);
    strSearchReplace(Result, '\', '_', [srAll]);
    strSearchReplace(Result, '/', '_', [srAll]);
    strSearchReplace(Result, '?', '_', [srAll]);
    strSearchReplace(Result, '>', '_', [srAll]);
    strSearchReplace(Result, '<', '_', [srAll]);
    strSearchReplace(Result, ',', '_', [srAll]);
    strSearchReplace(Result, '.', '_', [srAll]);
    strSearchReplace(Result, '`', '_', [srAll]);

End;

Function TMenuItemForm.NextValue(str: String): String;
Begin

End;

Procedure TMenuItemForm.CopyMenuItem(SrcMenuItem: TWxCustomMenuItem;
    Var DesMenuItem: TWxCustomMenuItem);
Begin
    DesMenuItem.Wx_Caption := SrcMenuItem.Wx_Caption;
    DesMenuItem.Wx_HelpText := SrcMenuItem.Wx_HelpText;

    DesMenuItem.Wx_IDName := SrcMenuItem.Wx_IDName;
    DesMenuItem.Wx_IDValue := SrcMenuItem.Wx_IDValue;
    DesMenuItem.Wx_Enabled := SrcMenuItem.Wx_Enabled;
    DesMenuItem.Wx_Hidden := SrcMenuItem.Wx_Hidden;
    DesMenuItem.Wx_Checked := SrcMenuItem.Wx_Checked;
    DesMenuItem.WX_BITMAP.Assign(SrcMenuItem.WX_BITMAP);
    DesMenuItem.Wx_MenuItemStyle := SrcMenuItem.Wx_MenuItemStyle;
    DesMenuItem.EVT_Menu := SrcMenuItem.EVT_Menu;
    DesMenuItem.EVT_UPDATE_UI := SrcMenuItem.EVT_UPDATE_UI;
    DesMenuItem.Wx_FileHistory := SrcMenuItem.Wx_FileHistory;

End;

Procedure TMenuItemForm.txtCaptionExit(Sender: TObject);
Var
    OldName: String;
Begin
    If tvMenuItem.Selected = Nil Then
        Exit;
    tvMenuItem.Selected.Text := txtCaption.Text;
    OldName := TWxCustomMenuItem(tvMenuItem.Selected.Data).Wx_Caption;
    TWxCustomMenuItem(tvMenuItem.Selected.Data).Wx_Caption := txtCaption.Text;

    If (UpperCase('ID_MNU_' + trim(OldName) + '_' + txtIDValue.Text) =
        UpperCase(trim(txtIDName.Text) + '_' + txtIDValue.Text)) Or
        (trim(txtIDName.Text) = '') Then
    Begin
        txtIDName.Text := 'ID_MNU_' + GetValidMenuName(txtCaption.Text);
    //Conditionally append the menu ID, since -1 is now a valid value
    //(to let the enum decide on the ID)
        If trim(txtIDValue.Text) <> '-1' Then
            txtIDName.Text := txtIDName.Text + '_' + txtIDValue.Text;
        TWxCustomMenuItem(tvMenuItem.Selected.Data).Wx_IDName := txtIDName.Text;
        exit;
    End;
End;

Procedure TMenuItemForm.FormDestroy(Sender: TObject);
Begin
    FMenuItems.Destroy;
End;

Procedure TMenuItemForm.btApplyClick(Sender: TObject);
Begin
    If tvMenuItem.Selected <> Nil Then
        UpdateMenuItemDataFromScreenData(TWxCustomMenuItem(tvMenuItem.Selected.Data));
    DisableUpdate;
    If FSubMenuItemCreationClicked = True Then
    Begin
        If tvMenuItem.Selected <> Nil Then
            If tvMenuItem.Selected.Parent <> Nil Then
            Begin
                tvMenuItem.Selected := tvMenuItem.Selected.Parent;
                tvMenuItem.Selected.Expand(True);
            End;
        FSubMenuItemCreationClicked := False;
    End;
End;

Procedure TMenuItemForm.btEditClick(Sender: TObject);
Begin
    If tvMenuItem.Selected = Nil Then
    Begin
        MessageDlg('Please select an item before trying to edit it.',
            mtError, [mbOK], 0);
        exit;
    End;
    EnableUpdate;
    txtCaption.SetFocus;
End;

Procedure TMenuItemForm.cbMenuTypeChange(Sender: TObject);
Begin
    If cbMenuType.ItemIndex = -1 Then
        exit;

    If cbMenuType.ItemIndex = 1 Then
    Begin
        txtCaption.Text := '---';
        txtIDName.Text := 'wxID_STATIC';
        If tvMenuItem.Selected <> Nil Then
            tvMenuItem.Selected.Text := txtCaption.Text;
    End;

    If cbMenuType.ItemIndex = 4 Then
    Begin
        txtCaption.Text := 'Recent Files';
        cbEnabled.Enabled := False;
    End;

    If (cbMenuType.ItemIndex = 2) Or (cbMenuType.ItemIndex = 3) Then
        cbChecked.Enabled := True
    Else
        cbChecked.Enabled := False;

End;

Procedure TMenuItemForm.btBrowseClick(Sender: TObject);
Var
    PictureEdit: TPictureEdit;
Begin
    PictureEdit := TPictureEdit.Create(self);
    PictureEdit.Image1.Picture.Assign(bmpMenuImage.Picture);
    If PictureEdit.ShowModal <> mrOk Then
        exit;
    bmpMenuImage.Picture.Assign(PictureEdit.Image1.Picture);

End;

Function TMenuItemForm.GetFunctionName(strF: String): String;
Begin
    Result := LowerCase(strF);
    strSearchReplace(Result, 'ID_', '', [srAll]);
    strSearchReplace(Result, '_', '', [srAll]);
    Result := strCapitalize(Result);
    strSearchReplace(Result, ' ', '', [srAll]);
End;

Procedure TMenuItemForm.btNewOnMenuClick(Sender: TObject);
Var
    strFnc, ErrorString: String;
Begin
    If wx_designer.isCurrentFormFilesNeedToBeSaved = True Then
    Begin
        If MessageDlg('Files need to be saved before adding one.' +
            #13 + #10 + 'Would you like to save the files before adding the function?',
            mtConfirmation, [mbYes, mbNo], 0) <> mrYes Then
            exit;
        If wx_designer.saveCurrentFormFiles = False Then
        Begin
            MessageDlg('Unable to save Files.', mtError, [mbOK], 0);
            exit;
        End;
    End;
    strFnc := trim(InputBox('New Function', 'Create New Function ?',
        GetFunctionName(trim(txtIDName.Text)) + 'Click'));
    If strFnc = '' Then
        exit;

    wx_designer.CreateFunctionInEditor(strFnc, 'void', 'wxCommandEvent& event', ErrorString);

    cbOnMenu.Text := strFnc;
    btNewOnMenu.Enabled := False;

End;

Procedure TMenuItemForm.btNewUpdateUIClick(Sender: TObject);
Var
    strFnc, ErrorString: String;
Begin
    If wx_designer.isCurrentFormFilesNeedToBeSaved = True Then
    Begin
        If MessageDlg('Files need to be saved before adding one.' +
            #13 + #10 + 'Would you like to save the files before adding the function ?',
            mtConfirmation, [mbYes, mbNo], 0) <> mrYes Then
            exit;
        If wx_designer.saveCurrentFormFiles = False Then
        Begin
            MessageDlg('Unable to save Files.', mtError, [mbOK], 0);
            exit;
        End;
    End;

    strFnc := trim(InputBox('New Function', 'Create New Function ?',
        GetFunctionName(trim(txtIDName.Text)) + 'UpdateUI'));
    If strFnc = '' Then
        exit;
    wx_designer.CreateFunctionInEditor(strFnc, 'void', 'wxUpdateUIEvent& event', ErrorString);
    cbOnUpdateUI.Text := strFnc;
    btNewUpdateUI.Enabled := False;
End;

Procedure TMenuItemForm.MoveNode(SourceNode, TargetNode: TTreeNode);
Var
    Node: TTreeNode;
    indiciesarray: Array Of Integer;
    sourceindex, targetindex: Integer;
    level: Integer;
    SourceItem, TargetItem: TWxCustomMenuItem;
Begin
    sourceindex := SourceNode.Index;
    targetindex := TargetNode.Index;

  // Tony Reina 1 July 2005
  // Basic idea:
  // We want to insert the source item into the target item and then delete the old source pointer.
  // So in reality this is just moving around memory pointers on the heap.

  // Problem: The insert and delete commands for a TList only affect the tree level being pointed to.
  // For example, let's say we have P1, P2, P3, and P4 on the root level.
  // P3 has children C1, C2, C3. C4 has children D1, D2, D3, D4. D2 has children E1, E2, and E3.
  // If we ask for the index of D4, Delphi gives us 3 (since Delphi starts counting at 0).
  // If we ask for the index of P4, Delphi also gives us 3. So the index is only with respect to the level.
  // If we just do a FMenuItems.Wx_Items.Delete(3) it will always delete P4.
  // To affect D4, we need to essentially do a FMenuItems.Items[2].Items[3].Wx_Items.Delete(3);
  // To affect E1, we need to do a FMenuItems.Items[2].Items[3].Items[1].Delete(0);

  // Approach:
  //   1. We need to work backward on the node to determine the indicies
  //      of all of the parents for that node. For example, E1->D2->C4->P3.
  //   2. We point SourceItem at the top level of FMenuItems
  //   3. We cycle down through the levels using the array of indicies
  //      we've found in step 1 (except for the very last index (which will
  //      be at the level we want to work on).
  //      --> This cycling is essentially just moving the variable's pointer down the levels

    Node := SourceNode;
    SetLength(indiciesarray, SourceNode.Level + 1);
  // Dynamically size the array (.Level is 0-based count)
    indiciesarray[0] := Node.Index;
    For level := 1 To SourceNode.Level Do
    Begin
        Node := Node.Parent;  // Point the node to the parent node
        indiciesarray[level] := Node.Index;  // Record the index of the current node
    End;

  // Get source pointer
    SourceItem := FMenuItems;  // Point to the menu

  // Move the pointer down through the parents
    For level := SourceNode.Level Downto 1 Do
        SourceItem := SourceItem.Items[indiciesarray[level]];

  // Now do the same procedure for the target node

  // Get target pointer
    TargetItem := FMenuItems;
    Node := TargetNode;

    SetLength(indiciesarray, TargetNode.Level + 1); // .Level is 0-based count
    indiciesarray[0] := Node.Index;
    For level := 1 To TargetNode.Level Do
    Begin
        Node := Node.Parent; // Point the node to the parent node
        indiciesarray[level] := Node.Index;  // Record the index of the current node
    End;

    For level := TargetNode.Level Downto 1 Do
        TargetItem := TargetItem.Items[indiciesarray[level]];


    If (FShiftDown) Then    // Shift, drag, and drop = Add as a child

    Begin

    // At this point, SourceItem and TargetItem point to the correct level
    // in the menu. Just need to insert the source at the target and delete
    // the original source pointer.

    // Change the TList (this is what generates the code and gets saved)
    // Let's insert this as a child of the target node
        TargetItem := TargetItem.Items[targetindex];

        If (Not TargetNode.HasChildren) Then
      // If there are no children, then we need to Create them
            TargetItem.Create(self.Parent);

        TargetItem.Wx_Items.Add(SourceItem.Wx_Items[sourceindex]);
        SourceItem.Wx_Items.Delete(sourceindex);

    // Change the Treeview (this is what is displayed, but doesn't set the code)
        SourceNode.MoveTo(TargetNode, naAddChild);

    End
    Else   // Drag and drop = Add as a sibling
    Begin

    // At this point, SourceItem and TargetItem point to the correct level
    // in the menu. Just need to insert the source at the target and delete
    // the original source pointer.

    // Change the TList (this is what generates the code and gets saved)
    // Let's insert this AFTER the target node (targetindex + 1)
        TargetItem.Wx_Items.Insert(targetindex + 1, SourceItem.Wx_Items[sourceindex]);
        If (sourceindex > (targetindex + 1)) And (TargetNode.Level = SourceNode.Level) Then
            SourceItem.Wx_Items.Delete(sourceindex + 1)
        Else
            SourceItem.Wx_Items.Delete(sourceindex);

    // Change the Treeview (this is what is displayed, but doesn't set the code)
        If (TargetNode.GetNextSibling <> Nil) Then
            SourceNode.MoveTo(TargetNode.GetNextSibling, naInsert)
        Else
            SourceNode.MoveTo(TargetNode, naAdd);

    End;

  // Remove shift down flag
    FShiftDown := False;
End;

//http://users.iafrica.com/d/da/dart/zen/Articles/TTreeView/TTreeView_eg13.html
//The drag-drop code was modified from Andre .v.d. Merwe's website
//Source code was released as public domain
Procedure TMenuItemForm.tvMenuItemDragDrop(Sender, Source: TObject; X, Y: Integer);
Var
    TargetNode, SourceNode: TTreeNode;
Begin
    With tvMenuItem Do
    Begin
    {Get the node the item was dropped on}
        TargetNode := GetNodeAt(X, Y);
    {Just to make things a bit easier}
        SourceNode := Selected;

    {Make sure something was droped onto}
        If (TargetNode = Nil) Then
        Begin
            EndDrag(False);
            Exit;
        End;

    {Dropping onto self?}
        If (TargetNode = Selected) Then
        Begin
            EndDrag(False);
            Exit;
        End;

    {Dropping a parent onto a child node? No No!}
        If (TargetNode.HasAsParent(SourceNode)) Then
        Begin
            MessageDlg('A parent node cannot be added as a child of itself', mtError, [mbOK], Handle);
            EndDrag(False);
            Exit;
        End;

    {Dropping an empty child onto the root level? Mal says not on my watch!}
        If (TargetNode.Level = 0) And
            (Not SourceNode.HasChildren) And (SourceNode.Level <> 0) And
            Not FShiftDown Then
        Begin
            MessageDlg('Children without submenus cannot be moved to root.', mtError, [mbOK], Handle);
            EndDrag(False);
            Exit;
        End;

    {Drag drop was valid so move the nodes}
        MoveNode(SourceNode, TargetNode);
    End;
End;

Procedure TMenuItemForm.tvMenuItemDragOver(Sender, Source: TObject;
    X, Y: Integer; State: TDragState; Var Accept: Boolean);
Begin
    Accept := False;

  //Only accept drag and drop from a TTreeView
    If (Sender Is TTreeView) Then
    //Only accept from self
        If (TTreeView(Sender) = tvMenuItem) Then
            Accept := True;
End;

Procedure TMenuItemForm.tvMenuItemKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If (ssShift In Shift) Then
        FShiftDown := True;
End;

Procedure TMenuItemForm.txtIDNameChange(Sender: TObject);
Begin
    txtIDValue.Enabled := Not AnsiStartsStr('wxID', txtIDName.Text);
End;

End.
