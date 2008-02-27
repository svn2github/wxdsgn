object ProcessListForm: TProcessListForm
  Left = 413
  Top = 338
  Width = 405
  Height = 130
  BorderIcons = []
  Caption = 'Attach to process'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object MainLabel: TLabel
    Left = 13
    Top = 13
    Width = 239
    Height = 13
    Caption = 'Please select the application you wish to attach to:'
    WordWrap = True
  end
  object OKBtn: TBitBtn
    Left = 224
    Top = 60
    Width = 80
    Height = 23
    TabOrder = 0
    Kind = bkOK
  end
  object CancelBtn: TBitBtn
    Left = 309
    Top = 60
    Width = 80
    Height = 23
    TabOrder = 1
    Kind = bkCancel
  end
  object ProcessCombo: TComboBox
    Left = 13
    Top = 29
    Width = 375
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
  end
  object XPMenu: TXPMenu
    DimLevel = 30
    GrayLevel = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Tahoma'
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
    AutoDetect = False
    Active = False
    Left = 14
    Top = 55
  end
end
