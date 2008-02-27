object MigrateFrm: TMigrateFrm
  Left = 358
  Top = 354
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'wxForm Migration Tool'
  ClientHeight = 235
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Page3: TPanel
    Left = 6
    Top = 6
    Width = 585
    Height = 200
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    object finish: TLabel
      Left = 0
      Top = 0
      Width = 586
      Height = 45
      AutoSize = False
      Caption = 
        'The migration tool has successfully completed updating your form' +
        ' file for use with the latest version of wxDev-C++. Press '#39'Finis' +
        'h'#39' to exit the tool and reload the form.'
      Transparent = True
      WordWrap = True
    end
  end
  object Page2: TPanel
    Left = 6
    Top = 6
    Width = 585
    Height = 200
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    object bvlChanges: TBevel
      Left = 57
      Top = 124
      Width = 525
      Height = 21
    end
    object bvlLine: TBevel
      Left = 57
      Top = 97
      Width = 525
      Height = 21
    end
    object bvlStatus: TBevel
      Left = 57
      Top = 70
      Width = 525
      Height = 21
    end
    object progress_lbl: TLabel
      Left = 0
      Top = 0
      Width = 363
      Height = 13
      Caption = 
        'Please wait while the migration tool converts your form file to ' +
        'the latest format.'
    end
    object lblAction: TLabel
      Left = 0
      Top = 74
      Width = 50
      Height = 13
      AutoSize = False
      Caption = 'Action:'
      Transparent = True
    end
    object Line: TLabel
      Left = 61
      Top = 101
      Width = 515
      Height = 13
      AutoSize = False
      Transparent = True
    end
    object Action: TLabel
      Left = 61
      Top = 74
      Width = 515
      Height = 13
      AutoSize = False
      Caption = 'Idle'
      Transparent = True
    end
    object lblLine: TLabel
      Left = 0
      Top = 101
      Width = 23
      Height = 13
      Caption = 'Line:'
    end
    object lblChanges: TLabel
      Left = 0
      Top = 128
      Width = 45
      Height = 13
      AutoSize = False
      Caption = 'Changes:'
    end
    object Changes: TLabel
      Left = 61
      Top = 128
      Width = 515
      Height = 13
      AutoSize = False
      Transparent = True
    end
    object Progress: TProgressBar
      Left = 0
      Top = 157
      Width = 585
      Height = 28
      Min = 0
      Max = 100
      Smooth = True
      Step = 1
      TabOrder = 0
    end
  end
  object Page1: TPanel
    Left = 6
    Top = 6
    Width = 585
    Height = 200
    BevelOuter = bvNone
    TabOrder = 1
    object intro: TLabel
      Left = 0
      Top = 0
      Width = 586
      Height = 45
      AutoSize = False
      Caption = 
        'wxDev-C++ has detected that you were attemtping to load an old w' +
        'xForm file which contains data fields which has changed since th' +
        'e previous release. This wizard will walk you through the steps ' +
        'to bringing your form files up-to-date with the latest version.'
      Transparent = True
      WordWrap = True
    end
    object filename: TLabel
      Left = 0
      Top = 45
      Width = 186
      Height = 13
      Caption = 'Let'#39's begin by selecting a file to update.'
    end
    object lblSource: TLabel
      Left = 0
      Top = 69
      Width = 56
      Height = 13
      Caption = 'Source File:'
    end
    object chkBackup: TCheckBox
      Left = 0
      Top = 89
      Width = 230
      Height = 17
      Caption = 'Back up old wxForm file before updating it'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object Source: TEdit
      Left = 66
      Top = 66
      Width = 455
      Height = 21
      TabOrder = 1
      Text = 'Source'
    end
    object btnSource: TJvBitBtn
      Left = 525
      Top = 65
      Width = 60
      Height = 23
      Caption = 'Open'
      TabOrder = 2
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
  end
  object btnNext: TButton
    Left = 517
    Top = 210
    Width = 75
    Height = 23
    Caption = 'Ne&xt >'
    TabOrder = 0
    OnClick = btnNextClick
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
    Left = 568
  end
end
