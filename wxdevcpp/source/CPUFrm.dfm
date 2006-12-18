object CPUForm: TCPUForm
  Left = 255
  Top = 183
  Width = 569
  Height = 487
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'CPU Window'
  Color = clBtnFace
  Constraints.MinHeight = 476
  Constraints.MinWidth = 569
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    561
    453)
  PixelsPerInch = 96
  TextHeight = 13
  object gbAsm: TGroupBox
    Left = 8
    Top = 8
    Width = 402
    Height = 435
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Assembler Code :'
    TabOrder = 0
    DesignSize = (
      402
      435)
    object lblFunc: TLabel
      Left = 8
      Top = 19
      Width = 47
      Height = 13
      Caption = 'Function: '
    end
    object edFunc: TEdit
      Left = 88
      Top = 16
      Width = 305
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnKeyPress = edFuncKeyPress
    end
    object CodeList: TSynEdit
      Left = 8
      Top = 44
      Width = 385
      Height = 383
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Pitch = fpFixed
      Font.Style = []
      TabOrder = 1
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -11
      Gutter.Font.Name = 'Terminal'
      Gutter.Font.Style = []
      Gutter.Visible = False
      Highlighter = SynAsmSyn1
      Options = [eoAutoIndent, eoNoCaret, eoScrollPastEol, eoShowScrollHint, eoSmartTabDelete, eoSmartTabs, eoTabsToSpaces, eoTrimTrailingSpaces]
      ReadOnly = True
      RemovedKeystrokes = <
        item
          Command = ecContextHelp
          ShortCut = 112
        end>
      AddedKeystrokes = <
        item
          Command = ecContextHelp
          ShortCut = 16496
        end>
    end
  end
  object CloseBtn: TBitBtn
    Left = 417
    Top = 417
    Width = 137
    Height = 25
    Anchors = [akRight, akBottom]
    TabOrder = 1
    Kind = bkClose
  end
  object gbRegisters: TGroupBox
    Left = 417
    Top = 72
    Width = 138
    Height = 337
    Anchors = [akTop, akRight]
    Caption = 'Registers :'
    TabOrder = 2
    object lblEIP: TLabel
      Left = 8
      Top = 212
      Width = 23
      Height = 13
      Caption = 'EIP :'
    end
    object lblEAX: TLabel
      Left = 8
      Top = 20
      Width = 27
      Height = 13
      Caption = 'EAX :'
    end
    object lblEBX: TLabel
      Left = 8
      Top = 44
      Width = 27
      Height = 13
      Caption = 'EBX :'
    end
    object lblECX: TLabel
      Left = 8
      Top = 68
      Width = 27
      Height = 13
      Caption = 'ECX :'
    end
    object lblEDX: TLabel
      Left = 8
      Top = 92
      Width = 28
      Height = 13
      Caption = 'EDX :'
    end
    object lblESI: TLabel
      Left = 8
      Top = 116
      Width = 23
      Height = 13
      Caption = 'ESI :'
    end
    object lblEDI: TLabel
      Left = 8
      Top = 140
      Width = 24
      Height = 13
      Caption = 'EDI :'
    end
    object lblEBP: TLabel
      Left = 8
      Top = 164
      Width = 27
      Height = 13
      Caption = 'EBP :'
    end
    object lblESP: TLabel
      Left = 8
      Top = 188
      Width = 27
      Height = 13
      Caption = 'ESP :'
    end
    object lblCS: TLabel
      Left = 8
      Top = 236
      Width = 20
      Height = 13
      Caption = 'CS :'
    end
    object lblDS: TLabel
      Left = 8
      Top = 260
      Width = 21
      Height = 13
      Caption = 'DS :'
    end
    object lblSS: TLabel
      Left = 8
      Top = 284
      Width = 20
      Height = 13
      Caption = 'SS :'
    end
    object lblES: TLabel
      Left = 8
      Top = 308
      Width = 20
      Height = 13
      Caption = 'ES :'
    end
    object EIPText: TEdit
      Left = 40
      Top = 208
      Width = 90
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object EAXText: TEdit
      Left = 40
      Top = 16
      Width = 90
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object EBXText: TEdit
      Left = 40
      Top = 40
      Width = 90
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
    object ECXText: TEdit
      Left = 40
      Top = 64
      Width = 90
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object EDXText: TEdit
      Left = 40
      Top = 88
      Width = 90
      Height = 21
      ReadOnly = True
      TabOrder = 4
    end
    object ESIText: TEdit
      Left = 40
      Top = 112
      Width = 90
      Height = 21
      ReadOnly = True
      TabOrder = 5
    end
    object EDIText: TEdit
      Left = 40
      Top = 136
      Width = 90
      Height = 21
      ReadOnly = True
      TabOrder = 6
    end
    object EBPText: TEdit
      Left = 40
      Top = 160
      Width = 90
      Height = 21
      ReadOnly = True
      TabOrder = 7
    end
    object ESPText: TEdit
      Left = 40
      Top = 184
      Width = 90
      Height = 21
      ReadOnly = True
      TabOrder = 8
    end
    object CSText: TEdit
      Left = 40
      Top = 232
      Width = 90
      Height = 21
      ReadOnly = True
      TabOrder = 9
    end
    object DSText: TEdit
      Left = 40
      Top = 256
      Width = 90
      Height = 21
      ReadOnly = True
      TabOrder = 10
    end
    object SSText: TEdit
      Left = 40
      Top = 280
      Width = 90
      Height = 21
      ReadOnly = True
      TabOrder = 11
    end
    object ESText: TEdit
      Left = 40
      Top = 304
      Width = 90
      Height = 21
      ReadOnly = True
      TabOrder = 12
    end
  end
  object rgSyntax: TRadioGroup
    Left = 418
    Top = 8
    Width = 137
    Height = 57
    Anchors = [akTop, akRight]
    Caption = 'Assembly Syntax'
    ItemIndex = 0
    Items.Strings = (
      'Intel'
      'AT&&T')
    TabOrder = 3
    OnClick = rgSyntaxClick
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
    Left = 37
    Top = 420
  end
  object SynAsmSyn1: TSynAsmSyn
    Left = 10
    Top = 420
  end
end
