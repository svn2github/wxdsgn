unit ExtractionProgressDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TExtractionProgress = class(TForm)
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Memo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExtractionProgress: TExtractionProgress;

implementation

{$R *.dfm}

end.
