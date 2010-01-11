{                                                                    }
{   Copyright © 2003-2007 by Guru Kathiresan                         }
{                                                                    }
{License :                                                           }
{=========                                                           }
{The wx-devC++ Components, Form Designer, Utils classes              }
{are exclusive properties of Guru Kathiresan.                        }
{The code is available in dual Licenses:                             }
{                               1)GPL Compatible  License            }
{                               2)Commercial License                 }
{                                                                    }
{1)GPL License :                                                     }
{ Code can be used in any project as long as the project's sourcecode}
{ is published under GPL license.                                    }
{                                                                    }
{2)Commercial License:                                               }
{Use of code in this file or the one that bear this license text     }
{can be used in Non-GPL projects as long as you get the permission   }
{from the Author - Guru Kathiresan.                                  }
{Use of the Code in any non-gpl projects without the permission of   }
{the author is illegal.                                              }
{Contact gururamnath@yahoo.com for details                           }
{ ****************************************************************** }

unit UPicEdit;

interface

uses
  GraphicEX, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ExtDlgs,jpeg, XPMenu, StrUtils;

type
  TPictureEdit = class(TForm)
    btnCancel: TBitBtn;
    OpenDialog1: TOpenPictureDialog;
    grpImage: TGroupBox;
    btnLoad: TButton;
    btnSave: TButton;
    Panel1: TPanel;
    Image1: TImage;
    btnClear: TButton;
    btnOK: TBitBtn;
    XPMenu: TXPMenu;
    KeepFormat: TCheckBox;
    FileName: TEdit;
    Label1: TLabel;
    procedure btnLoadClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PictureEdit: TPictureEdit;

implementation

uses wxutils, wxdesigner;
{$R *.DFM}

procedure TPictureEdit.FormCreate(Sender: TObject);
begin
    DesktopFont := True;
    XPMenu.Active := wx_designer.XPTheme
end;

procedure TPictureEdit.btnLoadClick(Sender: TObject);
var
    bmpObj:TBitMap;

Procedure SetBitMapFromFile(bmp:TBitMap;strFile:String);
var
    strExt:String;
    mf:TMetafile;
    jf:TJPEGImage;
    ic:TIcon;
    pngG:TPNGGraphic;
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

    if UpperCase(trim(strExt))='.PNG' then
    begin
        pngG:=TPNGGraphic.Create;
        pngG.LoadFromFile(strFile);
        //ic.Transparent:=true;
        //bmp.Transparent:=true;
        bmp.Width := pngG.Width;
        bmp.Height := pngG.Height;
        bmp.Canvas.Draw(0, 0, pngG) ;
        pngG.Destroy;
    end;

    if UpperCase(trim(strExt))='.XPM' then
    begin
        OpenXPMImage(bmp,strFile);
    end;

    bmp.Transparent:=true;

end;

begin
    if OpenDialog1.Execute then
    begin
        bmpObj:=TBitMap.Create;
        FileName.Text := OpenDialog1.FileName;
        SetBitMapFromFile(bmpObj, OpenDialog1.FileName);

        Image1.Picture.Bitmap.Assign(bmpObj);
        bmpObj.destroy;
    end;

end;

procedure TPictureEdit.btnClearClick(Sender: TObject);
var
    bmpObj: TBitmap;
begin
    bmpObj := TBitmap.Create;
    Image1.Picture.Bitmap.Assign(bmpObj);
    bmpObj.Destroy;
end;

end.
