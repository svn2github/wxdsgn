unit UStrings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TStringsForm = class(TForm)
    Bevel1: TBevel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnHelp: TBitBtn;
    Memo1: TMemo;
    Label1: TLabel;
    procedure Memo1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StringsForm: TStringsForm;

implementation

{$R *.DFM}

procedure TStringsForm.Memo1Change(Sender: TObject);
begin
    Label1.Caption:=IntToStr(Memo1.Lines.Count)+'Line';
end;

procedure TStringsForm.FormShow(Sender: TObject);
begin
    Memo1.SetFocus;
end;

end.
