unit DetailsForms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TDetailsForm = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DetailsForm: TDetailsForm;

implementation

{$R *.dfm}

procedure TDetailsForm.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.
