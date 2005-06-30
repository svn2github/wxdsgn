{*

Add support for MenuHightLight event
*}

unit UMenuitem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, TypInfo,WxCustomMenuItem, Menus,DateUtils, ExtCtrls,
  xprocs,wxUtils,UPicEdit, Spin;

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
    procedure txtCaptionKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
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
     procedure MoveMenuDown(Sender: TObject);
    procedure tvMenuItemDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure tvMenuItemDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
     
  private
    { Private declarations }
    FMaxID:Integer;
    FCounter:Integer;
    FSubMenuItemCreationClicked:Boolean;
    procedure AddMenuClass(const S:string);
    Procedure MoveNode(SourceNode, TargetNode : TTreeNode);
  public
    { Public declarations }
    FMenuItems:TWxCustomMenuItem;
    procedure SetMaxID(value:Integer);

    procedure UpdateScreenDataFromMenuItemData(cmenu:TWxCustomMenuItem);
    procedure UpdateMenuItemDataFromScreenData(cmenu:TWxCustomMenuItem);
    function GetFunctionName(strF:String):String;
    procedure SetMenuItemsAsc(ThisOwnerControl,ThisParentControl:TWinControl;SourceMenuItems:TWxCustomMenuItem;DestMenuItems:TWxCustomMenuItem);
    procedure SetMenuItemsDes(ThisOwnerControl,ThisParentControl:TWinControl;SourceMenuItems:TWxCustomMenuItem;DestMenuItems:TWxCustomMenuItem);
    procedure EnableUpdate;
    procedure DisableUpdate;
    procedure ForceOK;
     function GetValidMenuName(str:String):string;
    function NextValue(str:String):string;
    procedure CopyMenuItem(SrcMenuItem :TWxCustomMenuItem; var DesMenuItem:TWxCustomMenuItem);

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

procedure TMenuItemForm.AddMenuClass(const S:string);
begin
   tvMenuItem.Items.AddChild(nil, S);
end;

procedure TMenuItemForm.btnInsertClick(Sender: TObject);
var
  MenuItem: TWxCustomMenuItem;
  Node:TTreeNode;
begin
    MenuItem:= TWxCustomMenuItem.Create(nil);
    Inc(FMaxID);
    inc(FCounter);

    MenuItem.Wx_IDValue:= FMaxID;
    MenuItem.Wx_Caption:= 'MenuItem'+IntToStr(FCounter);
    Node:= tvMenuItem.Items.AddChildObject(nil, MenuItem.Wx_Caption, MenuItem);
    FMenuItems.Add(MenuItem,FMenuItems.count);
    tvMenuItem.Selected:=Node;
    tvMenuItem.SetFocus;
    EnableUpdate;

    txtIDValue.text:=IntToStr(FMaxID) ;
    txtCaption.text:='MenuItem'+IntToStr(FCounter);
    txtCaption.SetFocus;
    //Just to refresh the checked combo status
    self.cbMenuTypeChange(self);

end;

procedure TMenuItemForm.EnableUpdate;
begin
    btApply.Enabled:=true;
    btEdit.Enabled:=false;
    tvMenuItem.Enabled:=false;
    btnSubmenu.Enabled:=false;
    btnInsert.Enabled:=false;
    btnDelete.Enabled:=false;
    btnOK.Enabled:=false;
    btnCancel.Enabled:=true;

    txtCaption.Enabled:=true;
    txtHint.Enabled:=true;
    txtIDName.Enabled:=true;
    txtIDValue.Enabled:=true;
    cbEnabled.Enabled:=true;
    cbVisible.Enabled:=true;
    cbChecked.Enabled:=true;
    bmpMenuImage.Enabled:=true;
    btBrowse.Enabled:=true;
    cbMenuType.Enabled:=true;
    cbOnMenu.Enabled:=true;
    cbOnUpdateUI.Enabled:=true;
    btNewOnMenu.Enabled:=true;
    btNewUpdateUI.Enabled:=true;

end;

procedure TMenuItemForm.ForceOK;
begin
    btApply.Enabled:=false;
    btEdit.Enabled:=false;
    tvMenuItem.Enabled:=false;
    btnSubmenu.Enabled:=false;
    btnInsert.Enabled:=false;
    btnDelete.Enabled:=false;
    btnOK.Enabled:=true;
    btnCancel.Enabled:=true;

    txtCaption.Enabled:=false;
    txtHint.Enabled:=false;
    txtIDName.Enabled:=false;
    txtIDValue.Enabled:=false;
    cbEnabled.Enabled:=false;
    cbVisible.Enabled:=false;
    cbChecked.Enabled:=false;
    bmpMenuImage.Enabled:=false;
    btBrowse.Enabled:=false;
    cbMenuType.Enabled:=false;
    cbOnMenu.Enabled:=false;
    cbOnUpdateUI.Enabled:=false;
    btNewOnMenu.Enabled:=false;
    btNewUpdateUI.Enabled:=false;

end;

procedure TMenuItemForm.DisableUpdate;
begin
    btApply.Enabled:=false;
    btEdit.Enabled:=true;
    tvMenuItem.Enabled:=true;
    btnSubmenu.Enabled:=true;
    btnInsert.Enabled:=true;
    btnDelete.Enabled:=true;
    btnOK.Enabled:=true;
    btnCancel.Enabled:=true;

    txtCaption.Enabled:=false;
    txtHint.Enabled:=false;
    txtIDName.Enabled:=false;
    txtIDValue.Enabled:=false;
    cbEnabled.Enabled:=false;
    cbVisible.Enabled:=false;
    cbChecked.Enabled:=false;
    bmpMenuImage.Enabled:=false;
    btBrowse.Enabled:=false;
    cbMenuType.Enabled:=false;
    cbOnMenu.Enabled:=false;
    cbOnUpdateUI.Enabled:=false;
    btNewOnMenu.Enabled:=false;
    btNewUpdateUI.Enabled:=false;
  
end;


procedure TMenuItemForm.btnSubmenuClick(Sender: TObject);
var
   Node:TTreeNode;
   MenuItem: TWxCustomMenuItem;
   curMnuItem:TWxCustomMenuItem;
begin
    if tvMenuItem.Selected = nil then Exit;
    FSubMenuItemCreationClicked:=true;
    MenuItem:= TWxCustomMenuItem.Create(nil);//(TWxCustomMenuItem(tvMenuItem.Selected.Data));
    inc(FCounter);
    Inc(FMaxID);

    MenuItem.Wx_Caption:= 'SubMenuItem'+IntToStr(FCounter);
    MenuItem.Wx_IDValue:= FMaxID;
    curMnuItem:=TWxCustomMenuItem(tvMenuItem.Selected.Data);
    Node:= tvMenuItem.Items.AddChildObject(tvMenuItem.Selected, MenuItem.Wx_Caption, MenuItem);
    if Node <> nil then tvMenuItem.Selected:= Node;
    curMnuItem.Add(MenuItem,curMnuItem.Count);
    tvMenuItem.SetFocus;
    //btApply.SetFocus;
    EnableUpdate;
    txtIDValue.text:=IntToStr(FMaxID);
    txtCaption.text:='SubMenuItem'+IntToStr(FCounter) ;
    txtCaption.SetFocus;

end;

procedure TMenuItemForm.txtCaptionKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
   begin
        txtCaptionExit(sender);
   end;
end;

procedure TMenuItemForm.btnDeleteClick(Sender: TObject);
begin
    if tvMenuItem.Selected = nil then Exit;
    //TWxCustomMenuItem(tvMenuItem.Selected.Data).
    if tvMenuItem.Selected.Parent <> nil then
    begin
        TWxCustomMenuItem(tvMenuItem.Selected.Parent.Data).Remove(TWxCustomMenuItem(tvMenuItem.Selected.Data));
    end
    else
        FMenuItems.Remove(TWxCustomMenuItem(tvMenuItem.Selected.Data));
    tvMenuItem.Items.Delete(tvMenuItem.Selected);
    tvMenuItem.SetFocus;
    if tvMenuItem.Selected <> nil  then
        UpdateScreenDataFromMenuItemData(TWxCustomMenuItem(tvMenuItem.Selected.data));
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

procedure TMenuItemForm.UpdateScreenDataFromMenuItemData(cmenu:TWxCustomMenuItem);
begin
    txtCaption.Text:=cmenu.Wx_Caption;
    txtHint.Text:=cmenu.Wx_HelpText;

    txtIDName.Text:=cmenu.Wx_IDName;
    txtIDValue.Text:=IntToStr(cmenu.Wx_IDValue);

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

    bmpMenuImage.Picture.assign(cmenu.WX_BITMAP);

   if cmenu.Wx_MenuItemStyle =wxMnuItm_Normal then
        cbMenuType.ItemIndex := 0;

   if cmenu.Wx_MenuItemStyle =wxMnuItm_Separator then
        cbMenuType.ItemIndex := 1;

   if cmenu.Wx_MenuItemStyle =wxMnuItm_Radio then
        cbMenuType.ItemIndex := 3;

   if cmenu.Wx_MenuItemStyle =wxMnuItm_Check then
        cbMenuType.ItemIndex := 2;

    cbOnMenu.Text:=cmenu.EVT_Menu;
    cbOnUpdateUI.Text:=cmenu.EVT_UPDATE_UI;

end;

procedure TMenuItemForm.UpdateMenuItemDataFromScreenData(cmenu:TWxCustomMenuItem);
var
    FName:String;
begin

    cmenu.Wx_Caption:=txtCaption.Text;
    cmenu.Wx_HelpText:=txtHint.Text;

    cmenu.Wx_IDName:=txtIDName.Text;
    cmenu.Wx_IDValue:=StrToInt(txtIDValue.Text);

    if cbEnabled.ItemIndex = 1 then
        cmenu.Wx_Enabled:=true
    else
        cmenu.Wx_Enabled:=false;

    if cbVisible.ItemIndex = 1 then
        cmenu.Wx_Hidden:=false
    else
        cmenu.Wx_Hidden:=true;

    if cbChecked.ItemIndex = 1 then
        cmenu.Wx_Checked:=true
    else
        cmenu.Wx_Checked:=false;

    cmenu.WX_BITMAP.Assign(bmpMenuImage.Picture);

   cmenu.Wx_MenuItemStyle:=wxMnuItm_Normal;

   if cbMenuType.ItemIndex = 0 then
    cmenu.Wx_MenuItemStyle:=wxMnuItm_Normal
    else
        if cbMenuType.ItemIndex = 1 then
            cmenu.Wx_MenuItemStyle:=wxMnuItm_Separator
        else
            if cbMenuType.ItemIndex = 3 then
                cmenu.Wx_MenuItemStyle:=wxMnuItm_Radio
            else
                if cbMenuType.ItemIndex = 2 then
                    cmenu.Wx_MenuItemStyle:=wxMnuItm_Check;

    cmenu.EVT_Menu:= cbOnMenu.Text;
    cmenu.EVT_UPDATE_UI:= cbOnUpdateUI.Text;
    FName:=MainForm.GetCurrentFileName;
    GenerateXPMDirectly(cmenu.WX_BITMAP.Bitmap,cmenu.wx_IDName,FName);
end;

procedure TMenuItemForm.SetMaxID(value:Integer);
begin
    FMaxID:=value;
end;

procedure TMenuItemForm.SetMenuItemsAsc(ThisOwnerControl,ThisParentControl:TWinControl;SourceMenuItems:TWxCustomMenuItem;DestMenuItems:TWxCustomMenuItem);
var
   I: Integer;
   Node: TTreeNode;
   S: string;
   Item: TWxCustomMenuItem;
   aItem: TWxCustomMenuItem;

   procedure AddSubMenuitem(Menuitem: TWxCustomMenuItem; Nd: TTreeNode;anotherItemToAdd: TWxCustomMenuItem);
   var
      J: Integer;
      Cap: string;
      MItem,aMitem: TWxCustomMenuItem;
      TNode: TTreeNode;
   begin
      for J:= MenuItem.Count - 1  downto 0 do
      begin
         MItem:= MenuItem.Items[J];
         Cap:= MItem.Wx_Caption;
         aMitem:=TWxCustomMenuItem.Create(ThisParentControl);
         CopyMenuItem(MItem,aMitem);
         //aMitem.Caption:=MItem.Caption;
         TNode:= tvMenuItem.Items.AddChildObject(Nd, Cap, aMitem);
         TNode.Text:=Cap;
         anotherItemToAdd.Add(aMitem,0);
         inc(FCounter);
         if MItem.Count > 0 then  AddSubMenuitem(MItem, TNode,aMitem);
      end;
   end;

begin
   //DestMenuItems.Clear;
   FCounter:=0;
   for I:= SourceMenuItems.Count - 1  downto 0 do
   begin
       //FixMe:
       aItem:=TWxCustomMenuItem.Create(ThisParentControl);
      Item:= (SourceMenuItems.Items[I]);
      S:= Item.Wx_Caption;
      aItem.Wx_Caption:=Item.Wx_Caption;
      CopyMenuItem(Item,aItem);
      DestMenuItems.add(aItem,0);
      Node:= tvMenuItem.Items.AddChildObject(nil, S, aItem);
      inc(FCounter);
      if Item.Count > 0 then  AddSubMenuitem(Item, Node,aItem);
   end;
end;

procedure TMenuItemForm.SetMenuItemsDes(ThisOwnerControl,ThisParentControl:TWinControl;SourceMenuItems:TWxCustomMenuItem;DestMenuItems:TWxCustomMenuItem);
var
   I: Integer;
   Node: TTreeNode;
   S: string;
   Item: TWxCustomMenuItem;
   aItem: TWxCustomMenuItem;

   procedure AddSubMenuitem(Menuitem: TWxCustomMenuItem; Nd: TTreeNode;anotherItemToAdd: TWxCustomMenuItem);
   var
      J: Integer;
      Cap: string;
      MItem,aMitem: TWxCustomMenuItem;
      TNode: TTreeNode;
   begin
      for J:=  0 to MenuItem.Count - 1 do
      begin
         MItem:= MenuItem.Items[J];
         Cap:= MItem.Wx_Caption;
         aMitem:=TWxCustomMenuItem.Create(ThisParentControl);
         CopyMenuItem(MItem,aMitem);
         //aMitem.Caption:=MItem.Caption;
         TNode:= tvMenuItem.Items.AddChildObject(Nd, Cap, aMitem);
         TNode.Text:=Cap;
         anotherItemToAdd.Add(aMitem,J);
         inc(FCounter);
         if MItem.Count > 0 then  AddSubMenuitem(MItem, TNode,aMitem);
      end;
   end;

begin
   //DestMenuItems.Clear;
   FCounter:=0;
   for I:= 0 to SourceMenuItems.Count - 1 do
   begin
       //FixMe:
       aItem:=TWxCustomMenuItem.Create(ThisParentControl);
      Item:= (SourceMenuItems.Items[I]);
      S:= Item.Wx_Caption;
      aItem.Wx_Caption:=Item.Wx_Caption;
      CopyMenuItem(Item,aItem);
      DestMenuItems.add(aItem,I);
      Node:= tvMenuItem.Items.AddChildObject(nil, S, aItem);
      inc(FCounter);
      if Item.Count > 0 then  AddSubMenuitem(Item, Node,aItem);
   end;
end;

procedure TMenuItemForm.FormCreate(Sender: TObject);
var
    strLst:TStringList;
begin
   FSubMenuItemCreationClicked:=false;
   tvMenuItem.Items.Clear;
   txtIDName.Items.Assign(MainForm.strStdwxIDList);

   FMenuItems:=TWxCustomMenuItem.Create(nil);
   FMaxID:=2000;
   //if FDesigner <> nil then
   //   FDesigner.GetComponentNames(GetTypeData(TypeInfo(TMenuItem)), AddMenuClass);
   strLst:=TStringList.Create;
   MainForm.GetFunctionsFromSource(MainForm.GetCurrentClassName,strLst);

   cbOnMenu.Items.Assign(strLst);
   cbOnUpdateUI.Items.Assign(strLst);

   strLst.Destroy;
end;

procedure TMenuItemForm.tvMenuItemChange(Sender: TObject; Node: TTreeNode);
begin
   if Node = nil then Exit;
   with TWxCustomMenuItem(Node.Data) do
   begin

   //txtName.Text:= Name;
   txtCaption.Text:= Wx_Caption;
   txtIDValue.Text:= IntToStr(Wx_IDValue);
   txtIDName.Text:=Wx_IDName;
   UpdateScreenDataFromMenuItemData(TWxCustomMenuItem(tvMenuItem.Selected.Data));
   end;
end;
function TMenuItemForm.GetValidMenuName(str:String):string;
var
   i : Integer;
begin
    //FixMe
    Result:=UpperCase(trim(str));

    // Added by Termit
    // In polish language use code page 8859-2 or Win-1250 with character up to 127 code
    //change characters up to 127 code
    For i:=1 to Length(Result) do If Ord(Result[i]) > 127 Then Result[i] :=
'_';

    strSearchReplace(Result,' ','',[srAll]);
    strSearchReplace(Result,'&','_',[srAll]);
    strSearchReplace(Result,'\t','_',[srAll]);    
    strSearchReplace(Result,'-','_',[srAll]);
    strSearchReplace(Result,'~','_',[srAll]);
    strSearchReplace(Result,'*','_',[srAll]);
    strSearchReplace(Result,'!','_',[srAll]);
    strSearchReplace(Result,'@','_',[srAll]);
    strSearchReplace(Result,'#','_',[srAll]);
    strSearchReplace(Result,'$','_',[srAll]);
    strSearchReplace(Result,'%','_',[srAll]);
    strSearchReplace(Result,'^','_',[srAll]);
    strSearchReplace(Result,'&','_',[srAll]);
    strSearchReplace(Result,'*','_',[srAll]);
    strSearchReplace(Result,'(','_',[srAll]);
    strSearchReplace(Result,')','_',[srAll]);
    strSearchReplace(Result,';','_',[srAll]);
    strSearchReplace(Result,':','_',[srAll]);
    strSearchReplace(Result,'+','_',[srAll]);
    strSearchReplace(Result,'=','_',[srAll]);
    strSearchReplace(Result,'{','_',[srAll]);
    strSearchReplace(Result,'}','_',[srAll]);
    strSearchReplace(Result,'[','_',[srAll]);
    strSearchReplace(Result,']','_',[srAll]);
    strSearchReplace(Result,'|','_',[srAll]);
    strSearchReplace(Result,'\','_',[srAll]);
    strSearchReplace(Result,'/','_',[srAll]);
    strSearchReplace(Result,'?','_',[srAll]);
    strSearchReplace(Result,'>','_',[srAll]);
    strSearchReplace(Result,'<','_',[srAll]);
    strSearchReplace(Result,',','_',[srAll]);
    strSearchReplace(Result,'.','_',[srAll]);
    strSearchReplace(Result,'`','_',[srAll]);
                                                
end;
function TMenuItemForm.NextValue(str:String):string;
begin

end;

procedure TMenuItemForm.CopyMenuItem(SrcMenuItem:TWxCustomMenuItem;var DesMenuItem:TWxCustomMenuItem);
begin
    DesMenuItem.Wx_Caption:=SrcMenuItem.Wx_Caption;
    DesMenuItem.Wx_HelpText:=SrcMenuItem.Wx_HelpText;

    DesMenuItem.Wx_IDName:=SrcMenuItem.Wx_IDName;
    DesMenuItem.Wx_IDValue:=SrcMenuItem.Wx_IDValue;
    DesMenuItem.Wx_Enabled:=SrcMenuItem.Wx_Enabled;
    DesMenuItem.Wx_Hidden:=SrcMenuItem.Wx_Hidden;
    DesMenuItem.Wx_Checked:=SrcMenuItem.Wx_Checked;
    DesMenuItem.WX_BITMAP.Assign(SrcMenuItem.WX_BITMAP);
    DesMenuItem.Wx_MenuItemStyle:=SrcMenuItem.Wx_MenuItemStyle;
    DesMenuItem.EVT_Menu:=SrcMenuItem.EVT_Menu;
    DesMenuItem.EVT_UPDATE_UI:=SrcMenuItem.EVT_UPDATE_UI;
end;

procedure TMenuItemForm.txtCaptionExit(Sender: TObject);
var
    OldName:String;
begin
      if tvMenuItem.Selected = nil then Exit;
      tvMenuItem.Selected.Text:= txtCaption.Text;
      OldName:=TWxCustomMenuItem(tvMenuItem.Selected.Data).Wx_Caption;
      TWxCustomMenuItem(tvMenuItem.Selected.Data).Wx_Caption:=txtCaption.Text;

      if UpperCase('ID_MNU_'+trim(OldName)+'_'+txtIDValue.Text) = UpperCase(trim(txtIDName.Text)+'_'+txtIDValue.Text) then
      begin
        txtIDName.Text:= 'ID_MNU_'+GetValidMenuName(txtCaption.Text)+'_'+txtIDValue.Text;
        TWxCustomMenuItem(tvMenuItem.Selected.Data).Wx_IDName:=txtIDName.Text;
        exit;
      end;

      if trim(txtIDName.text) = '' then
      begin
        txtIDName.Text:= 'ID_MNU_'+GetValidMenuName(txtCaption.Text)+'_'+txtIDValue.Text;
        TWxCustomMenuItem(tvMenuItem.Selected.Data).Wx_IDName:=txtIDName.Text;
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
    if FSubMenuItemCreationClicked = true then
    begin
        if tvMenuItem.Selected <> nil then
        begin

            if  tvMenuItem.Selected.Parent <> nil then
            begin
                tvMenuItem.Selected:=tvMenuItem.Selected.Parent;
                tvMenuItem.Selected.Expand(false);
            end;
        end;
        FSubMenuItemCreationClicked:=false;
    end;
end;

procedure TMenuItemForm.btEditClick(Sender: TObject);
begin
    if tvMenuItem.Selected = nil then
    begin
        MessageDlg('Please select an item before trying to edit it.', mtError, [mbOK], 0);
        exit;
    end;
    EnableUpdate;
    txtCaption.SetFocus;
    //UpdateMenuItemDataFromScreenData(TWxCustomMenuItem(tvMenuItem.Selected.Data));

end;

procedure TMenuItemForm.cbMenuTypeChange(Sender: TObject);
begin
    if cbMenuType.itemIndex = -1 then
        exit;

    if cbMenuType.itemIndex = 1 then
    begin
        txtCaption.Text:='---';
    end;

    if (cbMenuType.itemIndex = 2) or (cbMenuType.itemIndex = 3) then
        cbChecked.Enabled:=true
    else
        cbChecked.Enabled:=false;
      

end;

procedure TMenuItemForm.btBrowseClick(Sender: TObject);
var
  PictureEdit: TPictureEdit;
  picObj:Tpicture;
  strClassName:String;
begin
  PictureEdit := TPictureEdit.Create(self);
  PictureEdit.Image1.Picture.Assign(bmpMenuImage.Picture);
  if PictureEdit.ShowModal <> mrOk then
    exit;
  bmpMenuImage.Picture.assign(PictureEdit.Image1.Picture);  

end;

function TMenuItemForm.GetFunctionName(strF:String):String;
begin
    Result:=LowerCase(strF);
    strSearchReplace(Result,'ID_','',[srAll]);
    strSearchReplace(Result,'_','',[srAll]);
    Result:=strCapitalize(Result);
    strSearchReplace(Result,' ','',[srAll]);
end;

procedure TMenuItemForm.btNewOnMenuClick(Sender: TObject);
var
    strFnc,ErrorString:String;
begin
    if MainForm.isCurrentFormFilesNeedToBeSaved = true then
    begin
        if MessageDlg('Files need to be saved before adding one.'+#13+#10+'Would you like to save the files before adding the function ?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
            exit;
        if MainForm.saveCurrentFormFiles = false then
        begin
            MessageDlg('Unable to save Files.', mtError, [mbOK], 0);
            exit;
        end;
    end;
    strFnc:=trim(InputBox('New Function','Create New Function ?', GetFunctionName(trim(txtIDName.Text))+'Click'));
    if strFnc = '' then
        exit;

    MainForm.CreateFunctionInEditor(strFnc,'void','wxCommandEvent& event',ErrorString);

    cbOnMenu.Text:=strFnc;
    btNewOnMenu.Enabled:=false;

end;

procedure TMenuItemForm.btNewUpdateUIClick(Sender: TObject);
var
    strFnc,ErrorString:String;
begin
    if MainForm.isCurrentFormFilesNeedToBeSaved = true then
    begin
        if MessageDlg('Files need to be saved before adding one.'+#13+#10+'Would you like to save the files before adding the function ?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
            exit;
        if MainForm.saveCurrentFormFiles = false then
        begin
            MessageDlg('Unable to save Files.', mtError, [mbOK], 0);
            exit;
        end;
    end;

    strFnc:=trim(InputBox('New Function','Create New Function ?', GetFunctionName(trim(txtIDName.Text))+'UpdateUI'));
    if strFnc = '' then
        exit;
    MainForm.CreateFunctionInEditor(strFnc,'void','wxUpdateUIEvent& event',ErrorString);
    cbOnUpdateUI.Text:=strFnc;
    btNewUpdateUI.Enabled:=false;
end;

procedure TMenuItemForm.MoveMenuDown(Sender: TObject);
var
   NodeSelect, NodeAfter : TTreeNode;
   MenuItemAfter, MenuItemSelect : TWxCustomMenuItem;
   index_select, index_next : Integer;

begin

// Tony Reina 16 June 2005
// There are 2 objects for the menu:
//   tvMenuItem is a TTreeNode that just displays the order on the menu editor form
//   FMenuItems is a TWxCustomMenuItem that actually holds the menu order and is used to update the C++ code that's created
//   so we need to modify both to have any effect

  NodeSelect := tvMenuItem.Selected; // Get the current node
  NodeAfter := tvMenuItem.Selected.GetNext; // Get the next node

  if (NodeAfter <> nil) then
  begin

 { MoveNode(NodeAfter, NodeSelect);
   MenuItemSelect := TWxCustomMenuItem.Create(nil);
   MenuItemAfter := TWxCustomMenuItem.Create(nil);

   if (NodeSelect.Parent <> nil) xor (NodeAfter.Parent <> nil) then
   begin

        if (NodeSelect.Parent <> nil) then
                NodeSelect := NodeSelect.Parent;

        if (NodeAfter.Parent <> nil) then
                NodeAfter := NodeAfter.Parent;

   end;

    index_select := NodeSelect.Index;  // Get the current index
  index_next := NodeAfter.Index;  // Get the next index

   CopyMenuItem(TWxCustomMenuItem(NodeSelect.Data), MenuItemSelect);
   CopyMenuItem(TWxCustomMenuItem(NodeAfter.Data), MenuItemAfter);

   FMenuItems.Items[index_next] := MenuItemSelect;
   FMenuItems.Items[index_select] := MenuItemAfter;

   NodeAfter.MoveTo(NodeSelect, naInsert); // Move the selected node before the previous one

   //   ForceOK; // Only allow OK and CANCEL buttons

 //  MenuItemSelect.Destroy;
 //  MenuItemAfter.Destroy;
 }
   
   end;

end;

procedure TMenuItemForm.MoveNode(SourceNode, TargetNode : TTreeNode);
begin

 //  TargetNode.MoveTo(SourceNode, naInsert);

     FMenuItems.Wx_Items.Move(SourceNode.Index, TargetNode.Index);


 // MessageDlg(Format('Source = %d, Target = %d', [SourceNode.Index, TargetNode.Index]), mtError, [mbOK], 0);


end;

// http://users.iafrica.com/d/da/dart/zen/Articles/TTreeView/TTreeView_eg13.html
// The drag-drop code was modified from Andre .v.d. Merwe's website
// Source code was released as public domain
procedure TMenuItemForm.tvMenuItemDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
      TargetNode : TTreeNode;
      SourceNode : TTreeNode;
begin
 /////////////////////////////////////////
   // Something has just been droped
   /////////////////////////////////////////

      with tvMenuItem do
      begin
            {Get the node the item was dropped on}
         TargetNode := GetNodeAt(  X,  Y  );
            {Just to make things a bit easier}
         SourceNode := Selected;

         {Make sure something was droped onto}
         if(  TargetNode = nil  ) then
         begin
            EndDrag(  false  );
            Exit;
         end;

            {Dropping onto self or onto parent?}
         if(  (TargetNode = Selected) or
              (TargetNode = Selected.Parent)
           ) then
         begin
            MessageBeep(  MB_ICONEXCLAMATION  );
            ShowMessage(  'Destination node is the same as the source node'  );
            EndDrag(  false  );
            Exit;
         end;

       {Drag drop was valid so move the nodes}
       MoveNode(SourceNode, TargetNode);

       {Show the nodes that were just moved}
       TargetNode.Expand(  true  );
end;
end;

procedure TMenuItemForm.tvMenuItemDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
    /////////////////////////////////////////
   // Decide if drag-drop is to be allowed
   /////////////////////////////////////////

      Accept := false;

         {Only accept drag and drop from a TTreeView}
      if(  Sender is TTreeView  ) then
            {Only accept from self}
         if(  TTreeView(Sender) = tvMenuItem  ) then
            Accept := true;
end;

end.
