unit UTreeView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, ExtCtrls, XPMenu;

type
  TTreeviewForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Bevel2: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    UpDown1: TUpDown;
    Edit3: TEdit;
    UpDown2: TUpDown;
    Edit4: TEdit;
    UpDown3: TUpDown;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    TreeView1: TTreeView;
    XPMenu: TXPMenu;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TreeviewForm: TTreeviewForm;

implementation

{$R *.DFM}




procedure TTreeviewForm.FormShow(Sender: TObject);
begin
  if devData.XPTheme then
    XPMenu.Active := true
  else
    XPMenu.Active := false;
end;

end.
