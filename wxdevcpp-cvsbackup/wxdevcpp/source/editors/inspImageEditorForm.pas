unit inspImageEditorForm;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    ExtDlgs, StdCtrls, ExtCtrls;

type
    TpropImageEditorForm = class(TForm)
        imgPicture: TImage;
        btLoad: TButton;
        btSave: TButton;
        btCancel: TButton;
        imgSaveDlg: TSavePictureDialog;
        imgOpenDlg: TOpenPictureDialog;
        btOk: TButton;
        procedure btLoadClick(Sender: TObject);
        procedure btSaveClick(Sender: TObject);
        procedure btOkClick(Sender: TObject);
        procedure btCancelClick(Sender: TObject);
    private
    { Private declarations }
    public
    { Public declarations }
    end;

var
    propImageEditorForm: TpropImageEditorForm;

implementation

{$R *.DFM}

procedure TpropImageEditorForm.btLoadClick(Sender: TObject);
begin
    imgOpenDlg.FileName := '';
    if imgOpenDlg.execute then
    begin
        try
            imgPicture.Picture.LoadFromFile(imgOpenDlg.FileName);
        except
            ShowMessage('Error loading File');
        end;
    end;
end;

procedure TpropImageEditorForm.btSaveClick(Sender: TObject);
begin
    imgSaveDlg.FileName := '';
    if imgSaveDlg.execute then
    begin
        try
            imgPicture.Picture.SaveToFile(imgsaveDlg.FileName);
        except
            ShowMessage('Error saving File');
        end;
    end;
end;

procedure TpropImageEditorForm.btOkClick(Sender: TObject);
begin
    close;
    modalresult := mrok;
end;

procedure TpropImageEditorForm.btCancelClick(Sender: TObject);
begin
    close;
end;

end.
