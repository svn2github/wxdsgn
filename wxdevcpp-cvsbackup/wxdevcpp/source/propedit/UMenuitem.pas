unit UMenuitem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ComCtrls, DsgnIntf, TypInfo;

  {$Include handel.inc}

type
  TMenuItemForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    tvMenuItem: TTreeView;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    cbBreak: TComboBox;
    edCaption: TEdit;
    cbChecked: TComboBox;
    cbDefault: TComboBox;
    cbEnabled: TComboBox;
    edGroupIndex: TEdit;
    edHelpContext: TEdit;
    edHint: TEdit;
    edName: TEdit;
    cbRadioItem: TComboBox;
    cbShortcut: TComboBox;
    edTag: TEdit;
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
    procedure btnInsertClick(Sender: TObject);
    procedure btnSubmenuClick(Sender: TObject);
    procedure edCaptionKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDeleteClick(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure iNSERT1Click(Sender: TObject);
    procedure CreateSubmenu1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tvMenuItemChange(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
    FMenuItems:TMenuItem;
    {$IFDEF DELPHI3}   // Delphi 3
    FDesigner: TFormDesigner;
    {$ENDIF}
    {$IFDEF DELPHI4}   // Delphi 4
    FDesigner: IFormDesigner;
    {$ENDIF}
    procedure SetMenuItems(Value:TMenuItem);
    procedure AddMenuClass(const S:string);
  public
    { Public declarations }
    {$IFDEF VER100}   // Delphi 3
    constructor Create(AOwner: TComponent; Designer: TFormDesigner);
    {$ENDIF}
    {$IFDEF DELPHI4}   // Delphi 4
    constructor Create(AOwner: TComponent; Designer: IFormDesigner);
    {$ENDIF}
    property MenuItems:TMenuItem read FMenuItems write SetMenuItems;
  end;

var
  MenuItemForm: TMenuItemForm;

implementation

{$R *.DFM}

{$IFDEF DELPHI3}
constructor TMenuItemForm.Create(AOwner: TComponent; Designer: TFormDesigner);
begin
   FDesigner:= Designer;
   inherited Create(AOwner);
end;
{$ENDIF}

{$IFDEF DELPHI4}
constructor TMenuItemForm.Create(AOwner: TComponent; Designer: IFormDesigner);
begin
   FDesigner:= Designer;
   inherited Create(AOwner);
end;
{$ENDIF}

procedure TMenuItemForm.AddMenuClass(const S:string);
begin
   tvMenuItem.Items.AddChild(nil, S);
end;

procedure TMenuItemForm.btnInsertClick(Sender: TObject);
var
  MenuItem: TMenuItem;
begin
    MenuItem:= TMenuItem.Create(self);
    MenuItem.Caption:= 'MenuItem';
    tvMenuItem.Items.AddChildObject(nil, 'MenuItem', MenuItem);
   // MenuItem.Free;
end;

procedure TMenuItemForm.btnSubmenuClick(Sender: TObject);
var
   Node:TTreeNode;
   MenuItem: TMenuItem;
begin
    if tvMenuItem.Selected = nil then Exit;
    MenuItem:= TMenuItem.Create(self);
    MenuItem.Caption:= 'SubMenuItem';
    Node:= tvMenuItem.Items.AddChildObject(tvMenuItem.Selected, 'SubMenuItem', MenuItem);
    if Node <> nil then tvMenuItem.Selected:= Node;
    tvMenuItem.SetFocus;
end;

procedure TMenuItemForm.edCaptionKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
   begin
      if tvMenuItem.Selected = nil then Exit;
      tvMenuItem.Selected.Text:= edCaption.Text;
   end;
end;

procedure TMenuItemForm.btnDeleteClick(Sender: TObject);
begin
    if tvMenuItem.Selected = nil then Exit;
    tvMenuItem.Items.Delete(tvMenuItem.Selected);
    tvMenuItem.SetFocus;
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

procedure TMenuItemForm.SetMenuItems(Value:TMenuItem);
var
   I: Integer;
   Node: TTreeNode;
   S: string;
   Item: TMenuItem;

   procedure AddSubMenuitem(Menuitem: TMenuItem; Nd: TTreeNode);
   var
      J: Integer;
      Cap: string;
      MItem: TMenuItem;
      TNode: TTreeNode;
   begin
      for J:= 0 to MenuItem.Count - 1 do
      begin
         MItem:= MenuItem.Items[J];
         Cap:= MItem.Caption;
         TNode:= tvMenuItem.Items.AddChildObject(Nd, Cap, MItem);
         if MItem.Count > 0 then  AddSubMenuitem(MItem, TNode);
      end;
   end;

begin
   for I:= 0 to TMenu(Value).Items.Count - 1 do
   begin
      Item:= (TMainMenu(Value).Items[I] as TMenuItem);
      S:= Item.Caption;
      Node:= tvMenuItem.Items.AddChildObject(nil, S, Item);
      if Item.Count > 0 then  AddSubMenuitem(Item, Node);
   end;
end;

procedure TMenuItemForm.FormCreate(Sender: TObject);
begin
   tvMenuItem.Items.Clear;
   if FDesigner <> nil then
      FDesigner.GetComponentNames(GetTypeData(TypeInfo(TMenuItem)), AddMenuClass);
end;

procedure TMenuItemForm.tvMenuItemChange(Sender: TObject; Node: TTreeNode);
begin
   if Node = nil then Exit;
   with TMenuitem(Node.Data) do
   begin
      edCaption.Text:= Caption;
      if Checked then cbChecked.ItemIndex:= 1
      else cbChecked.ItemIndex:= 0;
      if Default then cbDefault.ItemIndex:= 1
      else cbDefault.ItemIndex:= 0;
      if Enabled then cbEnabled.ItemIndex:= 1
      else cbEnabled.ItemIndex:= 0;
      edName.Text:= Name;
      edGroupIndex.Text:= IntToStr(GroupIndex);
      edHelpContext.Text:= IntToStr(HelpContext);
      edHint.Text:= Hint;
      if RadioItem then cbRadioItem.ItemIndex:= 1
      else cbRadioItem.ItemIndex:= 0;
      edTag.Text:= IntToStr(Tag);
      if Visible then cbVisible.ItemIndex:= 1
      else cbVisible.ItemIndex:= 0;
   end;
end;

end.
