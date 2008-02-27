object StatusBarForm: TStatusBarForm
  Left = 207
  Top = 167
  BorderStyle = bsDialog
  Caption = 'Statusbar Field Editor'
  ClientHeight = 220
  ClientWidth = 479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 11
    Width = 253
    Height = 155
    Caption = 'Fields'
    TabOrder = 0
    object btMoveDown: TButton
      Left = 168
      Top = 112
      Width = 75
      Height = 25
      Caption = 'Move Down'
      Enabled = False
      TabOrder = 0
      OnClick = btMoveDownClick
    end
    object btMoveUp: TButton
      Left = 168
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Move Up'
      Enabled = False
      TabOrder = 1
      OnClick = btMoveUpClick
    end
    object btDelete: TButton
      Left = 168
      Top = 48
      Width = 75
      Height = 25
      Caption = 'Delete'
      Enabled = False
      TabOrder = 2
      OnClick = btDeleteClick
    end
    object btAdd: TButton
      Left = 168
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Add'
      TabOrder = 3
      OnClick = btAddClick
    end
    object lbxColumnNames: TListBox
      Left = 8
      Top = 16
      Width = 153
      Height = 129
      ItemHeight = 13
      TabOrder = 4
      OnClick = lbxColumnNamesClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 272
    Top = 11
    Width = 201
    Height = 155
    Caption = 'Field Properties'
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 46
      Width = 31
      Height = 13
      Caption = 'Width:'
    end
    object Label4: TLabel
      Left = 8
      Top = 19
      Width = 39
      Height = 13
      Caption = 'Caption:'
    end
    object txtCaption: TEdit
      Left = 55
      Top = 16
      Width = 137
      Height = 21
      TabOrder = 0
    end
    object txtWidth: TEdit
      Left = 55
      Top = 42
      Width = 67
      Height = 21
      TabOrder = 1
      Text = '50'
    end
  end
  object StatusBarObj: TStatusBar
    Left = 0
    Top = 201
    Width = 479
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object btnOK: TBitBtn
    Left = 309
    Top = 172
    Width = 80
    Height = 23
    TabOrder = 3
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 394
    Top = 172
    Width = 80
    Height = 23
    TabOrder = 4
    Kind = bkCancel
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
    XPControls = [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar, xcCombo, xcListBox, xcEdit, xcMaskEdit, xcMemo, xcRichEdit, xcMiscEdit, xcCheckBox, xcRadioButton, xcButton, xcBitBtn, xcSpeedButton, xcUpDown, xcPanel, xcTreeView, xcListView, xcProgressBar, xcHotKey]
    Active = False
    Left = 12
    Top = 169
  end
end
