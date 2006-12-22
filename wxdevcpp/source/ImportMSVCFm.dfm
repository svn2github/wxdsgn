object ImportMSVCForm: TImportMSVCForm
  Left = 277
  Top = 211
  BorderStyle = bsDialog
  Caption = 'Import Visual C++ Project'
  ClientHeight = 216
  ClientWidth = 365
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbSelect: TLabel
    Left = 8
    Top = 8
    Width = 137
    Height = 13
    Caption = 'Select Visual C++ project file:'
  end
  object btnBrowse: TSpeedButton
    Left = 335
    Top = 24
    Width = 23
    Height = 21
    Caption = '...'
    OnClick = btnBrowseClick
  end
  object txtVC: TEdit
    Left = 8
    Top = 24
    Width = 325
    Height = 21
    TabOrder = 0
    Text = 'txtVC'
    OnChange = txtDevChange
  end
  object gbOptions: TGroupBox
    Left = 8
    Top = 56
    Width = 349
    Height = 121
    Caption = '  Import options  '
    TabOrder = 1
    object lbConf: TLabel
      Left = 16
      Top = 20
      Width = 108
      Height = 13
      Caption = 'Configuration to import:'
    end
    object lbDev: TLabel
      Left = 16
      Top = 68
      Width = 135
      Height = 13
      Caption = 'wxDev-C++ project filename:'
    end
    object cmbConf: TComboBox
      Left = 16
      Top = 36
      Width = 321
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object txtDev: TEdit
      Left = 16
      Top = 84
      Width = 297
      Height = 21
      TabOrder = 1
      Text = 'txtDev'
      OnChange = txtDevChange
    end
    object btnBrowseDev: TButton
      Left = 317
      Top = 84
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 2
      OnClick = btnBrowseDevClick
    end
  end
  object btnImport: TButton
    Left = 205
    Top = 185
    Width = 75
    Height = 23
    Caption = 'Import'
    Default = True
    TabOrder = 2
    OnClick = btnImportClick
  end
  object btnCancel: TButton
    Left = 283
    Top = 185
    Width = 75
    Height = 23
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object OpenDialog1: TOpenDialog
    Filter = 'MSVC++ files|*.dsp'
    Left = 36
    Top = 182
  end
  object SaveDialog1: TSaveDialog
    Left = 64
    Top = 182
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
    Left = 8
    Top = 182
  end
end
