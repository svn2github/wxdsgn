unit NoteBookPageEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtDlgs, ExtCtrls, Buttons;

type
  TForm1 = class(TForm)
    Bevel1: TBevel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnLoad: TButton;
    btnSave: TButton;
    btnClear: TButton;
    Panel1: TPanel;
    OpenDialog1: TOpenPictureDialog;
    lbNoteBookPages: TListBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
