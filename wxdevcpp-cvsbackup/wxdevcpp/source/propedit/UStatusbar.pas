unit UStatusbar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, ExtCtrls;

type
  TStatusBarForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    txtCaption: TEdit;
    txtWidth: TEdit;
    btMoveDown: TButton;
    btMoveUp: TButton;
    btDelete: TButton;
    btAdd: TButton;
    lbxColumnNames: TListBox;
    StatusBarObj: TStatusBar;
    procedure btAddClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure lbxColumnNamesClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    lstColumns: TListColumns;
    procedure fillListInfo;
  end;

var
  StatusBarForm: TStatusBarForm;

implementation

{$R *.DFM}

procedure TStatusBarForm.fillListInfo;
var
  I: Integer;
begin
  lbxColumnNames.Items.BeginUpdate;
  lbxColumnNames.Items.Clear;
  for I := 0 to StatusBarObj.Panels.Count - 1 do // Iterate
  begin
    lbxColumnNames.Items.Add(StatusBarObj.Panels[i].Text);
  end; // for
  lbxColumnNames.Items.EndUpdate;
end;

procedure TStatusBarForm.btAddClick(Sender: TObject);
var
  lstColumn: TStatusPanel;
begin

  lstColumn := StatusBarObj.Panels.Add;
  lstColumn.Text := txtCaption.Text;
  lstColumn.Width := StrToInt(txtWidth.Text);

  fillListInfo;

  txtCaption.Text := '';
  txtWidth.Text := '50';
end;

procedure TStatusBarForm.Button1Click(Sender: TObject);
begin
  Close;
  ModalResult := mrOk;
end;

procedure TStatusBarForm.btDeleteClick(Sender: TObject);
var
  intColPos: Integer;
begin
  if lbxColumnNames.ItemIndex = -1 then
    Exit;
  intColPos := lbxColumnNames.ItemIndex;
  lbxColumnNames.DeleteSelected;
  StatusBarObj.Panels.Delete(intColPos);

  if lbxColumnNames.Items.Count > 0 then
  begin
    lbxColumnNames.ItemIndex := 0;
  end;
  lbxColumnNamesClick(lbxColumnNames);
end;

procedure TStatusBarForm.lbxColumnNamesClick(Sender: TObject);
begin
  if lbxColumnNames.ItemIndex = -1 then
    Exit;

  txtCaption.Text := StatusBarObj.Panels[lbxColumnNames.ItemIndex].Text;
  txtWidth.Text := IntToStr(StatusBarObj.Panels[lbxColumnNames.ItemIndex].Width);

end;

end.
