object frmReplace: TfrmReplace
  Left = 264
  Top = 180
  ActiveControl = cboFindText
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Replace Text'
  ClientHeight = 422
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblFind: TLabel
    Left = 8
    Top = 8
    Width = 56
    Height = 13
    Caption = 'Text to find:'
    FocusControl = cboFindText
  end
  object lblReplace: TLabel
    Left = 8
    Top = 53
    Width = 65
    Height = 13
    Caption = 'Replace with:'
  end
  object lblLookIn: TLabel
    Left = 8
    Top = 98
    Width = 38
    Height = 13
    Caption = 'Look in:'
  end
  object cboFindText: TComboBox
    Left = 8
    Top = 25
    Width = 289
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
  object grpOptions: TGroupBox
    Left = 8
    Top = 143
    Width = 289
    Height = 122
    Caption = ' Options '
    TabOrder = 2
    object cbMatchCase: TCheckBox
      Left = 8
      Top = 16
      Width = 270
      Height = 16
      Caption = 'C&ase sensitive'
      TabOrder = 0
    end
    object cbWholeWord: TCheckBox
      Left = 8
      Top = 36
      Width = 270
      Height = 16
      Caption = '&Whole words only'
      TabOrder = 1
    end
    object cbPrompt: TCheckBox
      Left = 8
      Top = 56
      Width = 270
      Height = 17
      Caption = '&Prompt on Replace'
      TabOrder = 2
    end
    object cbRegex: TCheckBox
      Left = 8
      Top = 76
      Width = 270
      Height = 17
      Caption = 'Use Regular Expressions'
      TabOrder = 3
    end
    object cbUseSelection: TCheckBox
      Left = 8
      Top = 96
      Width = 273
      Height = 17
      Caption = 'Use Selection When Replace All'
      TabOrder = 4
    end
  end
  object btnReplace: TButton
    Left = 143
    Top = 392
    Width = 75
    Height = 24
    Caption = 'Replace'
    Default = True
    ModalResult = 1
    TabOrder = 3
    OnClick = btnReplaceClick
  end
  object btnCancel: TButton
    Left = 7
    Top = 392
    Width = 75
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
    OnClick = btnCancelClick
  end
  object cboReplaceText: TComboBox
    Left = 8
    Top = 70
    Width = 289
    Height = 21
    ItemHeight = 13
    TabOrder = 1
  end
  object btnReplaceAll: TButton
    Left = 223
    Top = 392
    Width = 75
    Height = 24
    Caption = 'Replace &All'
    ModalResult = 8
    TabOrder = 4
    OnClick = btnReplaceClick
  end
  object LookIn: TComboBox
    Left = 8
    Top = 115
    Width = 289
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 6
    Text = 'Current File'
    Items.Strings = (
      'Selected Text'
      'Current File')
  end
  object grpOrigin: TRadioGroup
    Left = 8
    Top = 268
    Width = 290
    Height = 57
    Caption = 'Origin'
    ItemIndex = 0
    Items.Strings = (
      'From Cursor'
      'Whole File')
    TabOrder = 7
  end
  object grpDirection: TRadioGroup
    Left = 8
    Top = 328
    Width = 289
    Height = 57
    Caption = 'Direction'
    ItemIndex = 0
    Items.Strings = (
      'Forward'
      'Backward')
    TabOrder = 8
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
    XPControls = [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar, xcCombo, xcListBox, xcEdit, xcMaskEdit, xcMemo, xcRichEdit, xcMiscEdit, xcCheckBox, xcRadioButton, xcButton, xcBitBtn, xcSpeedButton, xcUpDown, xcPanel, xcTreeView, xcListView, xcProgressBar, xcHotKey]
    Active = False
    Left = 93
    Top = 391
  end
end
