unit dmListview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, ExtCtrls;

type
  TListviewForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    txtCaption: TEdit;
    txtWidth: TEdit;
    cbAlign: TComboBox;
    btMoveDown: TButton;
    btMoveUp: TButton;
    btDelete: TButton;
    btAdd: TButton;
    lbxColumnNames: TListBox;
    GroupBox3: TGroupBox;
    LstViewObj: TListView;
    procedure btAddClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbxColumnNamesClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    lstColumns: TListColumns;
    procedure fillListInfo;
  end;

var
  ListviewForm: TListviewForm;

implementation

{$R *.DFM}

procedure TListviewForm.fillListInfo;
var
  I: Integer;
begin
  lbxColumnNames.Items.BeginUpdate;
  lbxColumnNames.Items.Clear;
  for I := 0 to LstViewObj.Columns.Count - 1 do // Iterate
  begin
    lbxColumnNames.Items.Add(LstViewObj.Columns[i].Caption);
  end; // for
  lbxColumnNames.Items.EndUpdate;
end;

procedure TListviewForm.btAddClick(Sender: TObject);
var
  lstColumn: TListColumn;
begin

  lstColumn := LstViewObj.Columns.Add;
  lstColumn.Caption := txtCaption.Text;
  lstColumn.Width := StrToInt(txtWidth.Text);

  case cbAlign.ItemIndex of //
    -1, 0: lstColumn.Alignment := taLeftJustify;
    1: lstColumn.Alignment := taCenter;
    2: lstColumn.Alignment := taRightJustify;
  end; // case
  lstColumn.ImageIndex := -1;
  fillListInfo;

  cbAlign.ItemIndex := 0;
  txtCaption.Text := '';
  txtWidth.Text := '50';
end;

procedure TListviewForm.Button1Click(Sender: TObject);
begin
  Close;
  ModalResult := mrOk;
end;

procedure TListviewForm.btDeleteClick(Sender: TObject);
var
  intColPos: Integer;
begin
  if lbxColumnNames.ItemIndex = -1 then
    Exit;
  intColPos := lbxColumnNames.ItemIndex;
  lbxColumnNames.DeleteSelected;
  LstViewObj.Columns.Delete(intColPos);

  if lbxColumnNames.Items.Count > 0 then
  begin
    lbxColumnNames.ItemIndex := 0;
  end;
  lbxColumnNamesClick(lbxColumnNames);
end;

procedure TListviewForm.FormCreate(Sender: TObject);
begin
  cbAlign.ItemIndex := 0;
end;

procedure TListviewForm.lbxColumnNamesClick(Sender: TObject);
begin
  if lbxColumnNames.ItemIndex = -1 then
    Exit;

  txtCaption.Text := LstViewObj.Columns[lbxColumnNames.ItemIndex].Caption;
  txtWidth.Text := IntToStr(LstViewObj.Columns[lbxColumnNames.ItemIndex].Width);
  case LstViewObj.Columns[lbxColumnNames.ItemIndex].Alignment of //
    taLeftJustify: cbAlign.ItemIndex := 0;
    taCenter: cbAlign.ItemIndex := 1;
    taRightJustify: cbAlign.ItemIndex := 2;
  end; // case

end;

end.
