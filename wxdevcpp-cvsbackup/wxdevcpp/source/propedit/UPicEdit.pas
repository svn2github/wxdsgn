unit UPicEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ExtDlgs;

type
  TPictureEdit = class(TForm)
    Bevel1: TBevel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnLoad: TButton;
    btnSave: TButton;
    btnClear: TButton;
    Panel1: TPanel;
    Image1: TImage;
    OpenDialog1: TOpenPictureDialog;
    procedure btnLoadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PictureEdit: TPictureEdit;

implementation

{$R *.DFM}

procedure TPictureEdit.btnLoadClick(Sender: TObject);
begin
    if OpenDialog1.Execute then
       Image1.Picture.LoadFromFile(OpenDialog1.FileName);
end;

end.
