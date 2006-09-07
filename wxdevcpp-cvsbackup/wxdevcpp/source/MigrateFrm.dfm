object MigrateFrm: TMigrateFrm
  Left = 517
  Top = 405
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'wxForm Migration Tool'
  ClientHeight = 261
  ClientWidth = 595
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
  PixelsPerInch = 96
  TextHeight = 13
  object grpFiles: TGroupBox
    Left = 8
    Top = 8
    Width = 580
    Height = 92
    Caption = 'Files'
    TabOrder = 0
    object lblSource: TLabel
      Left = 8
      Top = 17
      Width = 56
      Height = 13
      Caption = 'Source File:'
    end
    object Source: TEdit
      Left = 70
      Top = 15
      Width = 435
      Height = 21
      TabOrder = 0
      Text = 'Source'
    end
    object btnSource: TJvBitBtn
      Left = 510
      Top = 14
      Width = 60
      Height = 23
      Caption = 'Open'
      TabOrder = 1
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBF0000000000000000000000000000000000002F2F2F2F2F
        2F000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000000000008EC8008EC800
        8EC8008EC8008EC8000000B8B8B89696962F2F2FBFBFBFBFBFBFBFBFBFBFBFBF
        000000009EFF009EFF009EFF009EFF009EFFC8EBFF000000CFCFCFCFCFCFB8B8
        B82F2F2FBFBFBFBFBFBFBFBFBF0000007DCEFF4CBBFF4CBBFF4CBBFF4CBBFFC8
        EBFF000000CFCFCF656565CFCFCFB8B8B82F2F2FBFBFBFBFBFBFBFBFBF000000
        7DCEFF4CBBFF4CBBFF4CBBFFC8EBFF000000D0D0D0D0D0D0CFCFCFCFCFCFB8B8
        B82F2F2FBFBFBFBFBFBF00000096D7FF7DCEFF4CBBFF4CBBFFC8EBFF00000065
        6565D0D0D0656565D0D0D0CFCFCFB8B8B82F2F2FBFBFBFBFBFBF00000096D7FF
        7DCEFF4CBBFFC8EBFF000000D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0B8B8
        B82F2F2FBFBFBFBFBFBF00000096D7FF7DCEFFC8EBFF000000656565DFDFDF65
        6565656565D0D0D0656565D0D0D0B8B8B82F2F2FBFBFBFBFBFBF00000096D7FF
        C8EBFF000000DFDFDFDFDFDFDFDFDFDFDFDFD0D0D0D0D0D0D0D0D0D0D0D0B8B8
        B82F2F2FBFBFBFBFBFBF000000C8EBFF000000F3F3F3DFDFDF656565656565DF
        DFDF656565656565D0D0D0D0D0D0B8B8B82F2F2FBFBFBFBFBFBF000000000000
        000000F3F3F3DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD0D0D0D0D0D0D0D0D0B8B8
        B82F2F2FBFBFBFBFBFBFBFBFBFBFBFBF000000F3F3F3DFDFDF656565DFDFDF65
        6565656565DFDFDF656565D0D0D0B8B8B82F2F2FBFBFBFBFBFBFBFBFBFBFBFBF
        000000F3F3F3DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD0D0D0B8B8
        B82F2F2FBFBFBFBFBFBFBFBFBFBFBFBF000000F3F3F3DFDFDFDFDFDFDFDFDFDF
        DFDFDFDFDFDFDFDFDFDFDFDFDFDFB8B8B82F2F2FBFBFBFBFBFBFBFBFBFBFBFBF
        000000FFFFFFF3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3DFDF
        DF2F2F2FBFBFBFBFBFBFBFBFBFBFBFBF6868682F2F2F2F2F2F2F2F2F2F2F2F2F
        2F2F2F2F2F2F2F2F000000000000000000000000BFBFBFBFBFBF}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object chkBackup: TCheckBox
      Left = 8
      Top = 42
      Width = 560
      Height = 17
      Caption = 'Back up old wxForm file before updating it'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object btnGo: TButton
      Left = 495
      Top = 60
      Width = 75
      Height = 23
      Caption = 'Go'
      TabOrder = 3
      OnClick = btnGoClick
    end
  end
  object grpStatus: TGroupBox
    Left = 8
    Top = 110
    Width = 580
    Height = 140
    Caption = 'Status'
    TabOrder = 1
    object bvlChanges: TBevel
      Left = 65
      Top = 67
      Width = 505
      Height = 21
    end
    object bvlLine: TBevel
      Left = 65
      Top = 40
      Width = 505
      Height = 21
    end
    object lblAction: TLabel
      Left = 8
      Top = 17
      Width = 50
      Height = 13
      AutoSize = False
      Caption = 'Action:'
      Transparent = True
    end
    object bvlStatus: TBevel
      Left = 65
      Top = 13
      Width = 505
      Height = 21
    end
    object Action: TLabel
      Left = 69
      Top = 17
      Width = 495
      Height = 13
      AutoSize = False
      Caption = 'Idle'
      Transparent = True
    end
    object lblLine: TLabel
      Left = 8
      Top = 44
      Width = 23
      Height = 13
      Caption = 'Line:'
    end
    object Line: TLabel
      Left = 69
      Top = 44
      Width = 495
      Height = 13
      AutoSize = False
      Transparent = True
    end
    object lblChanges: TLabel
      Left = 8
      Top = 71
      Width = 45
      Height = 13
      AutoSize = False
      Caption = 'Changes:'
    end
    object Changes: TLabel
      Left = 69
      Top = 71
      Width = 495
      Height = 13
      AutoSize = False
      Transparent = True
    end
    object Progress: TProgressBar
      Left = 8
      Top = 100
      Width = 560
      Height = 28
      Min = 0
      Max = 100
      Smooth = True
      Step = 1
      TabOrder = 0
    end
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
    Left = 568
  end
end
