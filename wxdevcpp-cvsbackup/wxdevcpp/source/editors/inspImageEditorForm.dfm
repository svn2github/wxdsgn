object propImageEditorForm: TpropImageEditorForm
  Left = 381
  Top = 143
  Width = 363
  Height = 315
  Caption = 'Select Image..'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object imgPicture: TImage
    Left = 8
    Top = 16
    Width = 337
    Height = 225
  end
  object btLoad: TButton
    Left = 8
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Load From'
    TabOrder = 0
    OnClick = btLoadClick
  end
  object btSave: TButton
    Left = 96
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Save To'
    TabOrder = 1
    OnClick = btSaveClick
  end
  object btCancel: TButton
    Left = 272
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btCancelClick
  end
  object btOk: TButton
    Left = 184
    Top = 248
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = btOkClick
  end
  object imgSaveDlg: TSavePictureDialog
    Left = 168
    Top = 24
  end
  object imgOpenDlg: TOpenPictureDialog
    Left = 40
    Top = 32
  end
end
