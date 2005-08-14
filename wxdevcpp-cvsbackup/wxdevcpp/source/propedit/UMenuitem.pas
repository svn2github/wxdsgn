{*
 $Id$
Add support for MenuHightLight event
*}

unit UMenuitem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, TypInfo, WxCustomMenuItem, Menus, DateUtils, ExtCtrls,
  xprocs, wxUtils, UPicEdit, Spin;

type
  TMenuItemForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    tvMenuItem: TTreeView;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    cbMenuType: TComboBox;
    txtCaption: TEdit;
    cbChecked: TComboBox;
    cbEnabled: TComboBox;
    txtHint: TEdit;
    cbVisible: TComboBox;
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
    MainMenu1: TMainMenu;
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
    bmpMenuImage: TImage;
    btEdit: TButton;
    btNewOnMenu: TButton;
    btNewUpdateUI: TButton;
    Image1: TImage;
    Button3: TButton;
    txtIDName: TComboBox;
    procedure btnInsertClick(Sender: TObject);
    procedure btnSubmenuClick(Sender: TObject);
    procedure txtCaptionKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure btnDeleteClick(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure iNSERT1Click(Sender: TObject);
    procedure CreateSubmenu1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tvMenuItemChange(Sender: TObject; Node: TTreeNode);
    procedure txtCaptionExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btApplyClick(Sender: TObject);
    procedure btEditClick(Sender: TObject);
    procedure cbMenuTypeChange(Sender: TObject);
    procedure btBrowseClick(Sender: TObject);
    procedure btNewOnMenuClick(Sender: TObject);
    procedure btNewUpdateUIClick(Sender: TObject);
    procedure tvMenuItemDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure tvMenuItemDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: boolean);
    procedure tvMenuItemKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);

  private
    { Private declarations }
    FMaxID: integer;
    FCounter: integer;
    FSubMenuItemCreationClicked: boolean;
    FShiftDown: boolean;
    procedure AddMenuClass(const S: string);
    procedure MoveNode(SourceNode, TargetNode: TTreeNode);
  public
    { Public declarations }
    FMenuItems: TWxCustomMenuItem;
    procedure SetMaxID(Value: integer);

    procedure UpdateScreenDataFromMenuItemData(cmenu: TWxCustomMenuItem);
    procedure UpdateMenuItemDataFromScreenData(cmenu: TWxCustomMenuItem);
    function GetFunctionName(strF: string): string;
    procedure SetMenuItemsAsc(ThisOwnerControl, ThisParentControl: TWinControl;
      SourceMenuItems: TWxCustomMenuItem; DestMenuItems: TWxCustomMenuItem);
    procedure SetMenuItemsDes(ThisOwnerControl, ThisParentControl: TWinControl;
      SourceMenuItems: TWxCustomMenuItem; DestMenuItems: TWxCustomMenuItem);
    procedure EnableUpdate;
    procedure DisableUpdate;
    function GetValidMenuName(str: string): string;
    function NextValue(str: string): string;
    procedure CopyMenuItem(SrcMenuItem: TWxCustomMenuItem;
      var DesMenuItem: TWxCustomMenuItem);

    //property MenuItems:TWxCustomMenuItem read FMenuItems write SetMenuItems;
  end;

var
  MenuItemForm: TMenuItemForm;

implementation

{$R *.DFM}

uses Main, CreateOrderFm;

{$IFDEF DELPHI3}
constructor TMenuItemForm.Create(AOwner: TComponent{; Designer: TFormDesigner});
begin
  //FDesigner:= Designer;

  inherited Create(AOwner);
end;

{$ENDIF}

{$IFDEF DELPHI4}
constructor TMenuItemForm.Create(AOwner: TComponent{; Designer: IFormDesigner});
begin
  //FDesigner:= Designer;
  inherited Create(AOwner);
end;

{$ENDIF}

procedure TMenuItemForm.AddMenuClass(const S: string);
begin
  tvMenuItem.Items.AddChild(nil, S);
end;

procedure TMenuItemForm.btnInsertClick(Sender: TObject);
var
  MenuItem: TWxCustomMenuItem;
  Node:     TTreeNode;
begin
  MenuItem := TWxCustomMenuItem.Create(nil);
  Inc(FMaxID);
  Inc(FCounter);

  MenuItem.Wx_IDValue := FMaxID;
  MenuItem.Wx_Caption := 'MenuItem' + IntToStr(FCounter);

  if (tvMenuItem.Items.Count = 0) then  // No other nodes exist so let's add the first
  begin
    Node := tvMenuItem.Items.AddChildObject(nil, MenuItem.Wx_Caption, MenuItem);
    FMenuItems.Add(MenuItem, FMenuItems.Count)
  end

  else
  if (tvMenuItem.Selected.GetNext <> nil) then
    // Other nodes exist, let's insert it
  begin
    // New behavior inserts the node after the currently selected node
    Node := tvMenuItem.Items.InsertObject(tvMenuItem.Selected.GetNext,
      MenuItem.Wx_Caption, MenuItem);
    FMenuItems.Wx_Items.Insert(Node.Index, MenuItem)
  end
  else begin
    Node := tvMenuItem.Items.AddChildObject(nil,
      MenuItem.Wx_Caption, MenuItem);
    FMenuItems.Add(MenuItem, FMenuItems.Count)
  end;

  tvMenuItem.Selected := Node;
  tvMenuItem.SetFocus;
  EnableUpdate;

  txtIDValue.Text := IntToStr(FMaxID);
  txtCaption.Text := 'MenuItem' + IntToStr(FCounter);
  txtCaption.SetFocus;
  //Just to refresh the checked combo status
  self.cbMenuTypeChange(self);

end;

procedure TMenuItemForm.EnableUpdate;
begin
  btApply.Enabled    := True;
  btEdit.Enabled     := False;
  tvMenuItem.Enabled := False;
  btnSubmenu.Enabled := False;
  btnInsert.Enabled  := False;
  btnDelete.Enabled  := False;
  btnOK.Enabled      := False;
  btnCancel.Enabled  := True;

  txtCaption.Enabled   := True;
  txtHint.Enabled      := True;
  txtIDName.Enabled    := True;
  txtIDValue.Enabled   := True;
  cbEnabled.Enabled    := True;
  cbVisible.Enabled    := True;
  cbChecked.Enabled    := True;
  bmpMenuImage.Enabled := True;
  btBrowse.Enabled     := True;
  cbMenuType.Enabled   := True;
  cbOnMenu.Enabled     := True;
  cbOnUpdateUI.Enabled := True;
  btNewOnMenu.Enabled  := True;
  btNewUpdateUI.Enabled := True;

end;

procedure TMenuItemForm.DisableUpdate;
begin
  btApply.Enabled    := False;
  btEdit.Enabled     := True;
  tvMenuItem.Enabled := True;
  btnSubmenu.Enabled := True;
  btnInsert.Enabled  := True;
  btnDelete.Enabled  := True;
  btnOK.Enabled      := True;
  btnCancel.Enabled  := True;

  txtCaption.Enabled   := False;
  txtHint.Enabled      := False;
  txtIDName.Enabled    := False;
  txtIDValue.Enabled   := False;
  cbEnabled.Enabled    := False;
  cbVisible.Enabled    := False;
  cbChecked.Enabled    := False;
  bmpMenuImage.Enabled := False;
  btBrowse.Enabled     := False;
  cbMenuType.Enabled   := False;
  cbOnMenu.Enabled     := False;
  cbOnUpdateUI.Enabled := False;
  btNewOnMenu.Enabled  := False;
  btNewUpdateUI.Enabled := False;

end;


procedure TMenuItemForm.btnSubmenuClick(Sender: TObject);
var
  Node:     TTreeNode;
  MenuItem: TWxCustomMenuItem;
  curMnuItem: TWxCustomMenuItem;
begin
  if tvMenuItem.Selected = nil then
    Exit;
  FSubMenuItemCreationClicked := True;
  MenuItem := TWxCustomMenuItem.Create(nil);
  //(TWxCustomMenuItem(tvMenuItem.Selected.Data));
  Inc(FCounter);
  Inc(FMaxID);

  MenuItem.Wx_Caption := 'SubMenuItem' + IntToStr(FCounter);
  MenuItem.Wx_IDValue := FMaxID;
  curMnuItem := TWxCustomMenuItem(tvMenuItem.Selected.Data);
  Node := tvMenuItem.Items.AddChildObject(tvMenuItem.Selected,
    MenuItem.Wx_Caption, MenuItem);
  if Node <> nil then
    tvMenuItem.Selected := Node;
  curMnuItem.Add(MenuItem, curMnuItem.Count);
  tvMenuItem.SetFocus;
  //btApply.SetFocus;
  EnableUpdate;
  txtIDValue.Text := IntToStr(FMaxID);
  txtCaption.Text := 'SubMenuItem' + IntToStr(FCounter);
  txtCaption.SetFocus;

end;

procedure TMenuItemForm.txtCaptionKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    txtCaptionExit(Sender);
end;

procedure TMenuItemForm.btnDeleteClick(Sender: TObject);
begin
  if tvMenuItem.Selected = nil then
    Exit;
  //TWxCustomMenuItem(tvMenuItem.Selected.Data).
  if tvMenuItem.Selected.Parent <> nil then
    TWxCustomMenuItem(tvMenuItem.Selected.Parent.Data).Remove(
      TWxCustomMenuItem(tvMenuItem.Selected.Data))
  else
    FMenuItems.Remove(TWxCustomMenuItem(tvMenuItem.Selected.Data));
  tvMenuItem.Items.Delete(tvMenuItem.Selected);
  tvMenuItem.SetFocus;
  if tvMenuItem.Selected <> nil then
    UpdateScreenDataFromMenuItemData(TWxCustomMenuItem(tvMenuItem.Selected.Data));
  DisableUpdate;
end;

procedure TMenuItemForm.Delete1Click(Sender: TObject);
begin
  btnDeleteClick(self);
end;

procedure TMenuItemForm.iNSERT1Click(Sender: TObject);
begin
  btnInsertClick(self);
end;

procedure TMenuItemForm.CreateSubmenu1Click(Sender: TObject);
begin
  btnSubmenuClick(self);
end;

procedure TMenuItemForm.UpdateScreenDataFromMenuItemData(cmenu: TWxCustomMenuItem);
begin
  txtCaption.Text := cmenu.Wx_Caption;
  txtHint.Text    := cmenu.Wx_HelpText;

  txtIDName.Text  := cmenu.Wx_IDName;
  txtIDValue.Text := IntToStr(cmenu.Wx_IDValue);

  if cmenu.Wx_Enabled then
    cbEnabled.ItemIndex := 1
  else
    cbEnabled.ItemIndex := 0;

  if cmenu.Wx_Hidden then
    cbVisible.ItemIndex := 0
  else
    cbVisible.ItemIndex := 1;

  if cmenu.Wx_Checked then
    cbChecked.ItemIndex := 1
  else
    cbChecked.ItemIndex := 0;

  bmpMenuImage.Picture.Assign(cmenu.WX_BITMAP);

  if cmenu.Wx_MenuItemStyle = wxMnuItm_Normal then
    cbMenuType.ItemIndex := 0;

  if cmenu.Wx_MenuItemStyle = wxMnuItm_Separator then
    cbMenuType.ItemIndex := 1;

  if cmenu.Wx_MenuItemStyle = wxMnuItm_Radio then
    cbMenuType.ItemIndex := 3;

  if cmenu.Wx_MenuItemStyle = wxMnuItm_Check then
    cbMenuType.ItemIndex := 2;

  cbOnMenu.Text     := cmenu.EVT_Menu;
  cbOnUpdateUI.Text := cmenu.EVT_UPDATE_UI;

end;

procedure TMenuItemForm.UpdateMenuItemDataFromScreenData(cmenu: TWxCustomMenuItem);
var
  FName: string;
begin

  cmenu.Wx_Caption  := txtCaption.Text;
  cmenu.Wx_HelpText := txtHint.Text;

  cmenu.Wx_IDName  := txtIDName.Text;
  cmenu.Wx_IDValue := StrToInt(txtIDValue.Text);

  if cbEnabled.ItemIndex = 1 then
    cmenu.Wx_Enabled := True
  else
    cmenu.Wx_Enabled := False;

  if cbVisible.ItemIndex = 1 then
    cmenu.Wx_Hidden := False
  else
    cmenu.Wx_Hidden := True;

  if cbChecked.ItemIndex = 1 then
    cmenu.Wx_Checked := True
  else
    cmenu.Wx_Checked := False;

  cmenu.WX_BITMAP.Assign(bmpMenuImage.Picture);

  cmenu.Wx_MenuItemStyle := wxMnuItm_Normal;

  if cbMenuType.ItemIndex = 0 then
    cmenu.Wx_MenuItemStyle := wxMnuItm_Normal
  else if cbMenuType.ItemIndex = 1 then
    cmenu.Wx_MenuItemStyle := wxMnuItm_Separator
  else if cbMenuType.ItemIndex = 3 then
    cmenu.Wx_MenuItemStyle := wxMnuItm_Radio
  else if cbMenuType.ItemIndex = 2 then
    cmenu.Wx_MenuItemStyle := wxMnuItm_Check;

  cmenu.EVT_Menu := cbOnMenu.Text;
  cmenu.EVT_UPDATE_UI := cbOnUpdateUI.Text;
  FName := MainForm.GetCurrentFileName;
  GenerateXPMDirectly(cmenu.WX_BITMAP.Bitmap, cmenu.wx_IDName, FName);
end;

procedure TMenuItemForm.SetMaxID(Value: integer);
begin
  FMaxID := Value;
end;

procedure TMenuItemForm.SetMenuItemsAsc(ThisOwnerControl, ThisParentControl: TWinControl;
  SourceMenuItems: TWxCustomMenuItem; DestMenuItems: TWxCustomMenuItem);
var
  I:     integer;
  Node:  TTreeNode;
  S:     string;
  Item:  TWxCustomMenuItem;
  aItem: TWxCustomMenuItem;

  procedure AddSubMenuitem(Menuitem: TWxCustomMenuItem;
    Nd: TTreeNode; anotherItemToAdd: TWxCustomMenuItem);
  var
    J:     integer;
    Cap:   string;
    MItem, aMitem: TWxCustomMenuItem;
    TNode: TTreeNode;
  begin
    for J := MenuItem.Count - 1 downto 0 do
    begin
      MItem  := MenuItem.Items[J];
      Cap    := MItem.Wx_Caption;
      aMitem := TWxCustomMenuItem.Create(ThisParentControl);
      CopyMenuItem(MItem, aMitem);
      //aMitem.Caption:=MItem.Caption;
      TNode      := tvMenuItem.Items.AddChildObject(Nd, Cap, aMitem);
      TNode.Text := Cap;
      anotherItemToAdd.Add(aMitem, 0);
      Inc(FCounter);
      if MItem.Count > 0 then
        AddSubMenuitem(MItem, TNode, aMitem);
    end;
  end;

begin
  //DestMenuItems.Clear;
  FCounter := 0;
  for I := SourceMenuItems.Count - 1 downto 0 do
  begin
    //FixMe:
    aItem := TWxCustomMenuItem.Create(ThisParentControl);
    Item  := (SourceMenuItems.Items[I]);
    S     := Item.Wx_Caption;
    aItem.Wx_Caption := Item.Wx_Caption;
    CopyMenuItem(Item, aItem);
    DestMenuItems.add(aItem, 0);
    Node := tvMenuItem.Items.AddChildObject(nil, S, aItem);
    Inc(FCounter);
    if Item.Count > 0 then
      AddSubMenuitem(Item, Node, aItem);
  end;
end;

procedure TMenuItemForm.SetMenuItemsDes(ThisOwnerControl, ThisParentControl: TWinControl;
  SourceMenuItems: TWxCustomMenuItem; DestMenuItems: TWxCustomMenuItem);
var
  I:     integer;
  Node:  TTreeNode;
  S:     string;
  Item:  TWxCustomMenuItem;
  aItem: TWxCustomMenuItem;

  procedure AddSubMenuitem(Menuitem: TWxCustomMenuItem;
    Nd: TTreeNode; anotherItemToAdd: TWxCustomMenuItem);
  var
    J:     integer;
    Cap:   string;
    MItem, aMitem: TWxCustomMenuItem;
    TNode: TTreeNode;
  begin
    for J := 0 to MenuItem.Count - 1 do
    begin
      MItem  := MenuItem.Items[J];
      Cap    := MItem.Wx_Caption;
      aMitem := TWxCustomMenuItem.Create(ThisParentControl);
      CopyMenuItem(MItem, aMitem);
      //aMitem.Caption:=MItem.Caption;
      TNode      := tvMenuItem.Items.AddChildObject(Nd, Cap, aMitem);
      TNode.Text := Cap;
      anotherItemToAdd.Add(aMitem, J);
      Inc(FCounter);
      if MItem.Count > 0 then
        AddSubMenuitem(MItem, TNode, aMitem);
    end;
  end;

begin
  //DestMenuItems.Clear;
  FCounter := 0;
  for I := 0 to SourceMenuItems.Count - 1 do
  begin
    //FixMe:
    aItem := TWxCustomMenuItem.Create(ThisParentControl);
    Item  := (SourceMenuItems.Items[I]);
    S     := Item.Wx_Caption;
    aItem.Wx_Caption := Item.Wx_Caption;
    CopyMenuItem(Item, aItem);
    DestMenuItems.add(aItem, I);
    Node := tvMenuItem.Items.AddChildObject(nil, S, aItem);
    Inc(FCounter);
    if Item.Count > 0 then
      AddSubMenuitem(Item, Node, aItem);
  end;
end;

procedure TMenuItemForm.FormCreate(Sender: TObject);
var
  strLst: TStringList;
begin
  FSubMenuItemCreationClicked := False;
  tvMenuItem.Items.Clear;
  txtIDName.Items.Assign(MainForm.strStdwxIDList);

  FMenuItems := TWxCustomMenuItem.Create(nil);
  FMaxID     := 2000;
  //if FDesigner <> nil then
  //   FDesigner.GetComponentNames(GetTypeData(TypeInfo(TMenuItem)), AddMenuClass);
  strLst     := TStringList.Create;
  MainForm.GetFunctionsFromSource(MainForm.GetCurrentClassName, strLst);

  cbOnMenu.Items.Assign(strLst);
  cbOnUpdateUI.Items.Assign(strLst);

  strLst.Destroy;
end;

procedure TMenuItemForm.tvMenuItemChange(Sender: TObject; Node: TTreeNode);
begin
  if Node = nil then
    Exit;
  with TWxCustomMenuItem(Node.Data) do
  begin

    //txtName.Text:= Name;
    txtCaption.Text := Wx_Caption;
    txtIDValue.Text := IntToStr(Wx_IDValue);
    txtIDName.Text  := Wx_IDName;
    UpdateScreenDataFromMenuItemData(TWxCustomMenuItem(tvMenuItem.Selected.Data));
  end;
end;

function TMenuItemForm.GetValidMenuName(str: string): string;
var
  i: integer;
begin
  //FixMe
  Result := UpperCase(trim(str));

  // Added by Termit
  // In polish language use code page 8859-2 or Win-1250 with character up to 127 code
  //change characters up to 127 code
  for i := 1 to Length(Result) do
    if Ord(Result[i]) > 127 then
      Result[i] :=
        '_';

  strSearchReplace(Result, ' ', '', [srAll]);
  strSearchReplace(Result, '&', '_', [srAll]);
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

end;

function TMenuItemForm.NextValue(str: string): string;
begin

end;

procedure TMenuItemForm.CopyMenuItem(SrcMenuItem: TWxCustomMenuItem;
  var DesMenuItem: TWxCustomMenuItem);
begin
  DesMenuItem.Wx_Caption  := SrcMenuItem.Wx_Caption;
  DesMenuItem.Wx_HelpText := SrcMenuItem.Wx_HelpText;

  DesMenuItem.Wx_IDName  := SrcMenuItem.Wx_IDName;
  DesMenuItem.Wx_IDValue := SrcMenuItem.Wx_IDValue;
  DesMenuItem.Wx_Enabled := SrcMenuItem.Wx_Enabled;
  DesMenuItem.Wx_Hidden  := SrcMenuItem.Wx_Hidden;
  DesMenuItem.Wx_Checked := SrcMenuItem.Wx_Checked;
  DesMenuItem.WX_BITMAP.Assign(SrcMenuItem.WX_BITMAP);
  DesMenuItem.Wx_MenuItemStyle := SrcMenuItem.Wx_MenuItemStyle;
  DesMenuItem.EVT_Menu      := SrcMenuItem.EVT_Menu;
  DesMenuItem.EVT_UPDATE_UI := SrcMenuItem.EVT_UPDATE_UI;
end;

procedure TMenuItemForm.txtCaptionExit(Sender: TObject);
var
  OldName: string;
begin
  if tvMenuItem.Selected = nil then
    Exit;
  tvMenuItem.Selected.Text := txtCaption.Text;
  OldName := TWxCustomMenuItem(tvMenuItem.Selected.Data).Wx_Caption;
  TWxCustomMenuItem(tvMenuItem.Selected.Data).Wx_Caption := txtCaption.Text;

  if UpperCase('ID_MNU_' + trim(OldName) + '_' + txtIDValue.Text) =
    UpperCase(trim(txtIDName.Text) + '_' + txtIDValue.Text) then
  begin
    txtIDName.Text := 'ID_MNU_' + GetValidMenuName(txtCaption.Text) + '_' + txtIDValue.Text;
    TWxCustomMenuItem(tvMenuItem.Selected.Data).Wx_IDName := txtIDName.Text;
    exit;
  end;

  if trim(txtIDName.Text) = '' then
  begin
    txtIDName.Text := 'ID_MNU_' + GetValidMenuName(txtCaption.Text) + '_' + txtIDValue.Text;
    TWxCustomMenuItem(tvMenuItem.Selected.Data).Wx_IDName := txtIDName.Text;
  end;
end;

procedure TMenuItemForm.FormDestroy(Sender: TObject);
begin
  FMenuItems.Destroy;
end;

procedure TMenuItemForm.btApplyClick(Sender: TObject);
begin
  if tvMenuItem.Selected <> nil then
    UpdateMenuItemDataFromScreenData(TWxCustomMenuItem(tvMenuItem.Selected.Data));
  DisableUpdate;
  if FSubMenuItemCreationClicked = True then
  begin
    if tvMenuItem.Selected <> nil then
      if tvMenuItem.Selected.Parent <> nil then
      begin
        tvMenuItem.Selected := tvMenuItem.Selected.Parent;
        //  tvMenuItem.Selected.Expand(false);
        tvMenuItem.Selected.Expand(True);
      end;
    FSubMenuItemCreationClicked := False;
  end;
end;

procedure TMenuItemForm.btEditClick(Sender: TObject);
begin
  if tvMenuItem.Selected = nil then
  begin
    MessageDlg('Please select an item before trying to edit it.',
      mtError, [mbOK], 0);
    exit;
  end;
  EnableUpdate;
  txtCaption.SetFocus;
  //UpdateMenuItemDataFromScreenData(TWxCustomMenuItem(tvMenuItem.Selected.Data));

end;

procedure TMenuItemForm.cbMenuTypeChange(Sender: TObject);
begin
  if cbMenuType.ItemIndex = -1 then
    exit;

  if cbMenuType.ItemIndex = 1 then
    txtCaption.Text := '---';

  if (cbMenuType.ItemIndex = 2) or (cbMenuType.ItemIndex = 3) then
    cbChecked.Enabled := True
  else
    cbChecked.Enabled := False;

end;

procedure TMenuItemForm.btBrowseClick(Sender: TObject);
var
  PictureEdit: TPictureEdit;
  picObj:      Tpicture;
  strClassName: string;
begin
  PictureEdit := TPictureEdit.Create(self);
  PictureEdit.Image1.Picture.Assign(bmpMenuImage.Picture);
  if PictureEdit.ShowModal <> mrOk then
    exit;
  bmpMenuImage.Picture.Assign(PictureEdit.Image1.Picture);

end;

function TMenuItemForm.GetFunctionName(strF: string): string;
begin
  Result := LowerCase(strF);
  strSearchReplace(Result, 'ID_', '', [srAll]);
  strSearchReplace(Result, '_', '', [srAll]);
  Result := strCapitalize(Result);
  strSearchReplace(Result, ' ', '', [srAll]);
end;

procedure TMenuItemForm.btNewOnMenuClick(Sender: TObject);
var
  strFnc, ErrorString: string;
begin
  if MainForm.isCurrentFormFilesNeedToBeSaved = True then
  begin
    if MessageDlg('Files need to be saved before adding one.' +
      #13 + #10 + 'Would you like to save the files before adding the function ?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      exit;
    if MainForm.saveCurrentFormFiles = False then
    begin
      MessageDlg('Unable to save Files.', mtError, [mbOK], 0);
      exit;
    end;
  end;
  strFnc := trim(InputBox('New Function', 'Create New Function ?',
    GetFunctionName(trim(txtIDName.Text)) + 'Click'));
  if strFnc = '' then
    exit;

  MainForm.CreateFunctionInEditor(strFnc, 'void', 'wxCommandEvent& event', ErrorString);

  cbOnMenu.Text := strFnc;
  btNewOnMenu.Enabled := False;

end;

procedure TMenuItemForm.btNewUpdateUIClick(Sender: TObject);
var
  strFnc, ErrorString: string;
begin
  if MainForm.isCurrentFormFilesNeedToBeSaved = True then
  begin
    if MessageDlg('Files need to be saved before adding one.' +
      #13 + #10 + 'Would you like to save the files before adding the function ?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      exit;
    if MainForm.saveCurrentFormFiles = False then
    begin
      MessageDlg('Unable to save Files.', mtError, [mbOK], 0);
      exit;
    end;
  end;

  strFnc := trim(InputBox('New Function', 'Create New Function ?',
    GetFunctionName(trim(txtIDName.Text)) + 'UpdateUI'));
  if strFnc = '' then
    exit;
  MainForm.CreateFunctionInEditor(strFnc, 'void', 'wxUpdateUIEvent& event', ErrorString);
  cbOnUpdateUI.Text     := strFnc;
  btNewUpdateUI.Enabled := False;
end;

procedure TMenuItemForm.MoveNode(SourceNode, TargetNode: TTreeNode);
var
  Node:  TTreeNode;
  indiciesarray: array of integer;
  sourceindex, targetindex: integer;
  level: integer;
  SourceItem, TargetItem: TWxCustomMenuItem;
begin

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
  for level := 1 to SourceNode.Level do
  begin
    Node := Node.Parent;  // Point the node to the parent node
    indiciesarray[level] := Node.Index;  // Record the index of the current node
  end;

  // Get source pointer
  SourceItem := FMenuItems;  // Point to the menu

  // Move the pointer down through the parents
  for level := SourceNode.Level downto 1 do
    SourceItem := SourceItem.Items[indiciesarray[level]];

  // Now do the same procedure for the target node

  // Get target pointer
  TargetItem := FMenuItems;
  Node := TargetNode;

  SetLength(indiciesarray, TargetNode.Level + 1); // .Level is 0-based count
  indiciesarray[0] := Node.Index;
  for level := 1 to TargetNode.Level do
  begin
    Node := Node.Parent; // Point the node to the parent node
    indiciesarray[level] := Node.Index;  // Record the index of the current node
  end;

  for level := TargetNode.Level downto 1 do
    TargetItem := TargetItem.Items[indiciesarray[level]];


  if (FShiftDown) then    // Shift, drag, and drop = Add as a child

  begin

    // At this point, SourceItem and TargetItem point to the correct level
    //   in the menu. Just need to insert the source at the target and delete
    //   the original source pointer.

    // Change the TList (this is what generates the code and gets saved)
    // Let's insert this as a child of the target node
    TargetItem := TargetItem.Items[targetindex];

    if (not TargetNode.HasChildren) then
      // If there are no children, then we need to Create them
      TargetItem.Create(self.Parent);

    TargetItem.Wx_Items.Add(SourceItem.Wx_Items[sourceindex]);
    SourceItem.Wx_Items.Delete(sourceindex);

    // Change the Treeview (this is what is displayed, but doesn't set the code)
    SourceNode.MoveTo(TargetNode, naAddChild)

  end

  else   // Drag and drop = Add as a sibling

  begin

    // At this point, SourceItem and TargetItem point to the correct level
    //   in the menu. Just need to insert the source at the target and delete
    //   the original source pointer.

    // Change the TList (this is what generates the code and gets saved)
    // Let's insert this AFTER the target node (targetindex + 1)
    TargetItem.Wx_Items.Insert(targetindex + 1, SourceItem.Wx_Items[sourceindex]);
    if (sourceindex > (targetindex + 1)) and (TargetNode.Level = SourceNode.Level) then
      SourceItem.Wx_Items.Delete(sourceindex + 1)
    else
      SourceItem.Wx_Items.Delete(sourceindex);

    // Change the Treeview (this is what is displayed, but doesn't set the code)
    if (TargetNode.GetNextSibling <> nil) then
      SourceNode.MoveTo(TargetNode.GetNextSibling, naInsert)
    else
      SourceNode.MoveTo(TargetNode, naAdd);

  end;

  // Remove shift down flag
  FShiftDown := False;

end;

 // http://users.iafrica.com/d/da/dart/zen/Articles/TTreeView/TTreeView_eg13.html
 // The drag-drop code was modified from Andre .v.d. Merwe's website
 // Source code was released as public domain
procedure TMenuItemForm.tvMenuItemDragDrop(Sender, Source: TObject; X, Y: integer);
var
  TargetNode, SourceNode: TTreeNode;

begin
  /////////////////////////////////////////
  // Something has just been droped
  /////////////////////////////////////////

  with tvMenuItem do
  begin
    {Get the node the item was dropped on}
    TargetNode := GetNodeAt(X, Y);
    {Just to make things a bit easier}
    SourceNode := Selected;

    {Make sure something was droped onto}
    if (TargetNode = nil) then
    begin
      EndDrag(False);
      Exit;
    end;

    {Dropping onto self?}
    if ((TargetNode = Selected)) then
    begin
      MessageBeep(MB_ICONEXCLAMATION);
      ShowMessage('Destination node is the same as the source node');
      EndDrag(False);
      Exit;
    end;

    {Dropping a parent onto a child node? No No!}
    if (TargetNode.HasAsParent(SourceNode)) then
    begin
      MessageBeep(MB_ICONEXCLAMATION);
      ShowMessage('You can''t move a parent to a child');
      EndDrag(False);
      Exit;
    end;

    {Dropping an empty child onto the root level? Mal says not on my watch!}
    if (TargetNode.Level = 0) and
      (not SourceNode.HasChildren) and (SourceNode.Level <> 0) and
      not FShiftDown then
    begin
      MessageBeep(MB_ICONEXCLAMATION);
      ShowMessage('Mal says "You can''t move an empty child to root"');
      EndDrag(False);
      Exit;
    end;

    {Drag drop was valid so move the nodes}
    MoveNode(SourceNode, TargetNode);

  end;
end;

procedure TMenuItemForm.tvMenuItemDragOver(Sender, Source: TObject;
  X, Y: integer; State: TDragState; var Accept: boolean);
begin
  /////////////////////////////////////////
  // Decide if drag-drop is to be allowed
  /////////////////////////////////////////

  Accept := False;

  {Only accept drag and drop from a TTreeView}
  if (Sender is TTreeView) then
    {Only accept from self}
    if (TTreeView(Sender) = tvMenuItem) then
      Accept := True;

end;

procedure TMenuItemForm.tvMenuItemKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin

  if (ssShift in Shift) then
    FShiftDown := True;

end;

end.
