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

Unit UPicEdit;

Interface

Uses
    GraphicEX, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
    Dialogs, ExtCtrls, StdCtrls, Buttons, ExtDlgs, jpeg, XPMenu, StrUtils;

Type
    TPictureEdit = Class(TForm)
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
        Procedure btnLoadClick(Sender: TObject);
        Procedure btnClearClick(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
    Private
    { Private declarations }
    Public
    { Public declarations }
    End;

Var
    PictureEdit: TPictureEdit;

Implementation

Uses wxutils, wxdesigner;
{$R *.DFM}

Procedure TPictureEdit.FormCreate(Sender: TObject);
Begin
    DesktopFont := True;
    XPMenu.Active := wx_designer.XPTheme;
End;

Procedure TPictureEdit.btnLoadClick(Sender: TObject);
Var
    bmpObj: TBitMap;

    Procedure SetBitMapFromFile(bmp: TBitMap; strFile: String);
    Var
        strExt: String;
        mf: TMetafile;
        jf: TJPEGImage;
        ic: TIcon;
        pngG: TPNGGraphic;
    Begin
        strExt := ExtractFileExt(strFile);
        If trim(strExt) = '' Then
            exit;

        If UpperCase(trim(strExt)) = '.BMP' Then
        Begin
            bmp.LoadFromFile(strFile);
        End;

        If UpperCase(trim(strExt)) = '.GIF' Then
        Begin
        //bmp.LoadFromFile(strFile);
        End;

        If (UpperCase(trim(strExt)) = '.JPG') Or (UpperCase(trim(strExt)) = '.JPEG') Then
        Begin
            jf := TJPEGImage.Create;
            jf.LoadFromFile(strFile);
        //jf.Transparent:=true;

        //bmp.Transparent:=true;
            bmp.Width := jf.Width;
            bmp.Height := jf.Height;
            bmp.Canvas.Draw(0, 0, jf);
            jf.Destroy;
        End;

        If (UpperCase(trim(strExt)) = '.WMF') Or (UpperCase(trim(strExt)) = '.WMF') Then
        Begin
            mf := TMetafile.Create;
            mf.LoadFromFile(strFile);
        //mf.Transparent:=true;
        //bmp.Transparent:=true;
            bmp.Width := mf.Width;
            bmp.Height := mf.Height;
            bmp.Canvas.Draw(0, 0, mf);
            mf.Destroy;
        End;

        If UpperCase(trim(strExt)) = '.ICO' Then
        Begin
            ic := TIcon.Create;
            ic.LoadFromFile(strFile);
        //ic.Transparent:=true;
        //bmp.Transparent:=true;
            bmp.Width := ic.Width;
            bmp.Height := ic.Height;
            bmp.Canvas.Draw(0, 0, ic);
            ic.Destroy;
        End;

        If UpperCase(trim(strExt)) = '.PNG' Then
        Begin
            pngG := TPNGGraphic.Create;
            pngG.LoadFromFile(strFile);
        //ic.Transparent:=true;
        //bmp.Transparent:=true;
            bmp.Width := pngG.Width;
            bmp.Height := pngG.Height;
            bmp.Canvas.Draw(0, 0, pngG);
            pngG.Destroy;
        End;

        If UpperCase(trim(strExt)) = '.XPM' Then
        Begin
            OpenXPMImage(bmp, strFile);
        End;

        bmp.Transparent := True;

    End;

Begin
    If OpenDialog1.Execute Then
    Begin
        bmpObj := TBitMap.Create;
        FileName.Text := OpenDialog1.FileName;
        SetBitMapFromFile(bmpObj, OpenDialog1.FileName);

        Image1.Picture.Bitmap.Assign(bmpObj);
        bmpObj.destroy;
    End;

End;

Procedure TPictureEdit.btnClearClick(Sender: TObject);
Var
    bmpObj: TBitmap;
Begin
    bmpObj := TBitmap.Create;
    Image1.Picture.Bitmap.Assign(bmpObj);
    bmpObj.Destroy;
    FileName.Clear;
End;

End.
