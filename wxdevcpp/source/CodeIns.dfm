object frmCodeEdit: TfrmCodeEdit
  Left = 315
  Top = 126
  BorderStyle = bsToolWindow
  Caption = 'Code Insert Editor'
  ClientHeight = 125
  ClientWidth = 302
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblMenu: TLabel
    Left = 8
    Top = 8
    Width = 54
    Height = 13
    Caption = 'Menu Text:'
  end
  object lblSec: TLabel
    Left = 8
    Top = 48
    Width = 39
    Height = 13
    Caption = 'Section:'
  end
  object lblDesc: TLabel
    Left = 103
    Top = 48
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object edMenuText: TEdit
    Left = 8
    Top = 22
    Width = 285
    Height = 21
    TabOrder = 0
    OnChange = edMenuTextChange
  end
  object seSection: TSpinEdit
    Left = 8
    Top = 62
    Width = 67
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object btnOk: TBitBtn
    Left = 139
    Top = 94
    Width = 75
    Height = 23
    Enabled = False
    TabOrder = 3
    OnClick = btnOkClick
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 219
    Top = 94
    Width = 75
    Height = 23
    TabOrder = 4
    Kind = bkCancel
  end
  object edDesc: TEdit
    Left = 103
    Top = 64
    Width = 190
    Height = 21
    TabOrder = 2
  end
  object XPMenu: TXPMenu
    DimLevel = 30
    GrayLevel = 10
    Font.Charset = ANSI_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    Color = clBtnFace
    DrawMenuBar = False
    IconBackColor = clBtnFace
    MenuBarColor = clBtnFace
    SelectColor = clHighlight
    SelectBorderColor = clHighlight
    SelectFontColor = clMenuText
    DisabledColor = clInactiveCaption
    SeparatorColor = clBtnFace
    CheckedColor = clHighlight
    IconWidth = 24
    DrawSelect = True
    UseSystemColors = True
    UseDimColor = False
    OverrideOwnerDraw = False
    Gradient = False
    FlatMenu = False
    AutoDetect = True
    Active = False
    Left = 8
    Top = 93
  end
end
