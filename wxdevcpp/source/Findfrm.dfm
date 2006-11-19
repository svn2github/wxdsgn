object frmFind: TfrmFind
  Left = 319
  Top = 146
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Find Text'
  ClientHeight = 341
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    303
    341)
  PixelsPerInch = 96
  TextHeight = 13
  object lblFind: TLabel
    Left = 8
    Top = 8
    Width = 56
    Height = 13
    Caption = '&Text to find:'
    FocusControl = cboFindText
  end
  object lblLookIn: TLabel
    Left = 8
    Top = 53
    Width = 39
    Height = 13
    Caption = 'Look In:'
  end
  object btnFind: TButton
    Left = 135
    Top = 311
    Width = 80
    Height = 24
    Anchors = [akLeft, akBottom]
    Caption = 'Find'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = btnFindClick
  end
  object btnCancel: TButton
    Left = 218
    Top = 311
    Width = 80
    Height = 24
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object cboFindText: TComboBox
    Left = 8
    Top = 25
    Width = 289
    Height = 21
    ItemHeight = 13
    TabOrder = 2
  end
  object grpOptions: TGroupBox
    Left = 8
    Top = 101
    Width = 290
    Height = 75
    Caption = '  Options:  '
    TabOrder = 3
    object cbMatchCase: TCheckBox
      Left = 8
      Top = 16
      Width = 270
      Height = 17
      Caption = 'C&ase sensitive'
      TabOrder = 0
    end
    object cbWholeWord: TCheckBox
      Left = 8
      Top = 35
      Width = 270
      Height = 17
      Caption = '&Whole words only'
      TabOrder = 1
    end
    object cbRegex: TCheckBox
      Left = 8
      Top = 54
      Width = 270
      Height = 17
      Caption = 'Use Regular Expressions'
      TabOrder = 2
    end
  end
  object grpOrigin: TRadioGroup
    Left = 8
    Top = 183
    Width = 290
    Height = 57
    Caption = 'Origin'
    ItemIndex = 0
    Items.Strings = (
      'From Cursor'
      'Whole File')
    TabOrder = 4
  end
  object LookIn: TComboBox
    Left = 8
    Top = 70
    Width = 289
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 5
    OnChange = LookInChange
  end
  object grpDirection: TRadioGroup
    Left = 8
    Top = 247
    Width = 289
    Height = 57
    Caption = 'Direction'
    ItemIndex = 0
    Items.Strings = (
      'Forward'
      'Backward')
    TabOrder = 6
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
    Left = 9
    Top = 309
  end
end
