object Form1: TForm1
  Left = 628
  Top = 167
  Width = 333
  Height = 303
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 289
    Height = 225
    Shape = bsFrame
  end
  object btnOK: TBitBtn
    Left = 9
    Top = 239
    Width = 78
    Height = 23
    TabOrder = 0
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 216
    Top = 239
    Width = 78
    Height = 23
    TabOrder = 1
    Kind = bkCancel
  end
  object btnLoad: TButton
    Left = 216
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 2
  end
  object btnSave: TButton
    Left = 216
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 3
    Visible = False
  end
  object btnClear: TButton
    Left = 216
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 4
    Visible = False
  end
  object Panel1: TPanel
    Left = 16
    Top = 16
    Width = 193
    Height = 209
    TabOrder = 5
    object lbNoteBookPages: TListBox
      Left = 8
      Top = 8
      Width = 177
      Height = 193
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object OpenDialog1: TOpenPictureDialog
    Filter = 
      'All (*.jpg;*.jpeg;*.gif;*.bmp;*.ico;*.emf;*.wmf)|*.jpg;*.jpeg;*.' +
      'gif;*.bmp;*.ico;*.emf;*.wmf|JPEG Image File (*.jpg)|*.jpg|JPEG I' +
      'mage File (*.jpeg)|*.jpeg|Graphics Interchange Format (*.gif)|*.' +
      'gif|Bitmaps (*.bmp)|*.bmp|Icons (*.ico)|*.ico|Enhanced Metafiles' +
      ' (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf'
    Left = 232
    Top = 144
  end
end
