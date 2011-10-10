object TreeEditor: TTreeEditor
  Left = 248
  Top = 108
  Width = 558
  Height = 352
  Caption = 'Tree Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = teOnCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 16
    Top = 24
    Width = 257
    Height = 257
    Caption = 'Items'
    TabOrder = 0
    object teNewItem: TButton
      Left = 168
      Top = 64
      Width = 81
      Height = 25
      Caption = 'New Item'
      TabOrder = 0
      OnClick = teNewItemClick
    end
    object teNewSubItem: TButton
      Left = 168
      Top = 104
      Width = 81
      Height = 25
      Caption = 'New SubItem'
      TabOrder = 1
      OnClick = teNewSubItemClick
    end
    object teDelete: TButton
      Left = 168
      Top = 144
      Width = 81
      Height = 25
      Caption = 'Delete'
      TabOrder = 2
      OnClick = teDeleteClick
    end
    object TreeView1: TTreeView
      Left = 8
      Top = 32
      Width = 153
      Height = 193
      Indent = 19
      TabOrder = 3
      OnClick = teOnClickEvent
      OnKeyPress = teOnKeyPressEvent
    end
  end
  object GroupBox2: TGroupBox
    Left = 280
    Top = 24
    Width = 225
    Height = 257
    Caption = 'Item Properties'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 40
      Width = 24
      Height = 13
      Caption = 'Text:'
    end
    object Label2: TLabel
      Left = 8
      Top = 80
      Width = 61
      Height = 13
      Caption = 'Image Index:'
      Visible = False
    end
    object teItemText: TEdit
      Left = 80
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object teImageIndex: TEdit
      Left = 88
      Top = 80
      Width = 49
      Height = 21
      TabOrder = 1
      Visible = False
    end
  end
  object teOK: TButton
    Left = 184
    Top = 288
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object teCancel: TButton
    Left = 280
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object XPMenu1: TXPMenu
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
    Left = 16
    Top = 288
  end
end
