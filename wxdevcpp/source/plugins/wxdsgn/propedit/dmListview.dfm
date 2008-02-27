object ListviewForm: TListviewForm
  Left = 526
  Top = 390
  BorderStyle = bsDialog
  Caption = 'Listcontrol Columns Editor'
  ClientHeight = 296
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
    Top = 105
    Width = 253
    Height = 155
    Caption = 'Columns'
    TabOrder = 0
    object btMoveDown: TButton
      Left = 168
      Top = 123
      Width = 75
      Height = 23
      Caption = 'Move Down'
      Enabled = False
      TabOrder = 0
      OnClick = btMoveDownClick
    end
    object btMoveUp: TButton
      Left = 168
      Top = 87
      Width = 75
      Height = 23
      Caption = 'Move Up'
      Enabled = False
      TabOrder = 1
      OnClick = btMoveUpClick
    end
    object btDelete: TButton
      Left = 168
      Top = 52
      Width = 75
      Height = 23
      Caption = 'Delete'
      TabOrder = 2
      OnClick = btDeleteClick
    end
    object btAdd: TButton
      Left = 168
      Top = 16
      Width = 75
      Height = 23
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
    Top = 105
    Width = 201
    Height = 155
    Caption = 'Column Properties'
    TabOrder = 1
    object Label2: TLabel
      Left = 27
      Top = 74
      Width = 31
      Height = 13
      Caption = 'Width:'
    end
    object Label3: TLabel
      Left = 9
      Top = 22
      Width = 49
      Height = 13
      Caption = 'Alignment:'
    end
    object Label4: TLabel
      Left = 19
      Top = 49
      Width = 39
      Height = 13
      Caption = 'Caption:'
    end
    object txtCaption: TEdit
      Left = 75
      Top = 46
      Width = 115
      Height = 21
      TabOrder = 0
    end
    object txtWidth: TEdit
      Left = 75
      Top = 71
      Width = 115
      Height = 21
      TabOrder = 1
      Text = '50'
    end
    object cbAlign: TComboBox
      Left = 75
      Top = 19
      Width = 115
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        'Left Justify'
        'Center'
        'Right Justify')
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 8
    Width = 465
    Height = 90
    Caption = 'Preview'
    TabOrder = 2
    object LstViewObj: TListView
      Left = 8
      Top = 19
      Width = 448
      Height = 60
      Columns = <>
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object btnOK: TBitBtn
    Left = 310
    Top = 267
    Width = 80
    Height = 23
    TabOrder = 3
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 394
    Top = 267
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
    Left = 8
    Top = 265
  end
end
