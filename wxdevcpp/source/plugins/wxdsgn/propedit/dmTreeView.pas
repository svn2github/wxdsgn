unit dmTreeView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, XPMenu;

type
  TTreeEditor = class(TForm)
    GroupBox1: TGroupBox;
    teNewItem: TButton;
    teNewSubItem: TButton;
    teDelete: TButton;
    TreeView1: TTreeView;
    GroupBox2: TGroupBox;
    teItemText: TEdit;
    teImageIndex: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    teOK: TButton;
    teCancel: TButton;
    XPMenu1: TXPMenu;
    procedure teNewItemClick(Sender: TObject);
    procedure teNewSubItemClick(Sender: TObject);
    procedure teDeleteClick(Sender: TObject);
    procedure teOnClickEvent(Sender: TObject);
    procedure teOnKeyPressEvent(Sender: TObject; var Key: Char);
    procedure teOnCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TreeEditor: TTreeEditor;

implementation

uses
  wxdesigner;
  
{$R *.dfm}

procedure TTreeEditor.teNewItemClick(Sender: TObject);
begin

if (TreeView1.Selected = nil) then
   TreeView1.Items.Add(TreeView1.Items.GetFirstNode, teItemText.Text)
else
   TreeView1.Items.Add(TreeView1.Selected, teItemText.Text);

end;

procedure TTreeEditor.teNewSubItemClick(Sender: TObject);
begin
  if (TreeView1.Selected = nil) then
   TreeView1.Items.AddChild(TreeView1.Items.GetFirstNode, teItemText.Text)
else
   TreeView1.Items.AddChild(TreeView1.Selected, teItemText.Text);

end;

procedure TTreeEditor.teDeleteClick(Sender: TObject);
begin
if (TreeView1.Selected <> nil) then
   TreeView1.Items.Delete(TreeView1.Selected);
end;

procedure TTreeEditor.teOnClickEvent(Sender: TObject);
begin
    if (TreeView1.Selected <> nil) then
        teItemText.Text := TreeView1.Selected.Text;
end;

procedure TTreeEditor.teOnKeyPressEvent(Sender: TObject; var Key: Char);
begin
    if (TreeView1.Selected <> nil) then
        teItemText.Text := TreeView1.Selected.Text;
end;

procedure TTreeEditor.teOnCreate(Sender: TObject);
begin
  DesktopFont := True;
  XPMenu1.Active := wx_designer.XPTheme;
end;

end.
