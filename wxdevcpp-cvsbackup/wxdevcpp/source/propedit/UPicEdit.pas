unit UPicEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ExtDlgs,jpeg;

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
var
    bmpObj:TBitMap;

Procedure SetBitMapFromFile(bmp:TBitMap;strFile:String);
var
    strExt:String;
    mf:TMetafile;
    jf:TJPEGImage;
    ic:TIcon;
begin
    strExt:= ExtractFileExt(strFile);
    if trim(strExt)='' then
        exit;

    if UpperCase(trim(strExt))='.BMP' then
    begin
        bmp.LoadFromFile(strFile);
    end;

    if UpperCase(trim(strExt))='.GIF' then
    begin
        //bmp.LoadFromFile(strFile);
    end;

    if (UpperCase(trim(strExt))='.JPG') or (UpperCase(trim(strExt))='.JPEG') then
    begin
        jf:=TJPEGImage.Create;
        jf.LoadFromFile(strFile);
        //jf.Transparent:=true;

        //bmp.Transparent:=true;
        bmp.Width := jf.Width;
        bmp.Height := jf.Height;
        bmp.Canvas.Draw(0, 0, jf) ;
        jf.Destroy;
    end;

    if (UpperCase(trim(strExt))='.WMF') or (UpperCase(trim(strExt))='.WMF') then
    begin
        mf:=TMetafile.Create;
        mf.LoadFromFile(strFile);
        //mf.Transparent:=true;
        //bmp.Transparent:=true;
        bmp.Width := mf.Width;
        bmp.Height := mf.Height;
        bmp.Canvas.Draw(0, 0, mf) ;
        mf.Destroy;
    end;

    if UpperCase(trim(strExt))='.ICO' then
    begin
        ic:=TIcon.Create;
        ic.LoadFromFile(strFile);
        //ic.Transparent:=true;
        //bmp.Transparent:=true;
        bmp.Width := ic.Width;
        bmp.Height := ic.Height;
        bmp.Canvas.Draw(0, 0, ic) ;
        ic.Destroy;
    end;

    bmp.Transparent:=true;

end;

begin
    if OpenDialog1.Execute then
    begin
        bmpObj:=TBitMap.Create;
        SetBitMapFromFile(bmpObj,OpenDialog1.FileName);
        Image1.Picture.Bitmap.Assign(bmpObj);
        bmpObj.destroy;
    end;

end;

end.
