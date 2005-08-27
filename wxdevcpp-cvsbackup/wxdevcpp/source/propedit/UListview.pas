unit UListview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, ExtCtrls, XPMenu;

type
  TListviewForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button6: TButton;
    Button5: TButton;
    Button4: TButton;
    Button3: TButton;
    ListBox1: TListBox;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    cbAlign: TComboBox;
    Edit2: TEdit;
    Edit3: TEdit;
    XPMenu: TXPMenu;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ListviewForm: TListviewForm;

implementation

{$R *.DFM}






procedure TListviewForm.FormShow(Sender: TObject);
begin
  if devData.XPTheme then
    XPMenu.Active := true
  else
    XPMenu.Active := false;
end;

end.
