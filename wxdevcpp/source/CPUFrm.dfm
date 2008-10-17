object CPUForm: TCPUForm
  Left = 255
  Top = 183
  Width = 585
  Height = 487
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'CPU Window'
  Color = clBtnFace
  Constraints.MinHeight = 487
  Constraints.MinWidth = 585
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
    569
    451)
  PixelsPerInch = 96
  TextHeight = 13
  object gbAsm: TGroupBox
    Left = 8
    Top = 8
    Width = 405
    Height = 435
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Assembler Code :'
    TabOrder = 0
    DesignSize = (
      405
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
      Width = 308
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnKeyPress = edFuncKeyPress
    end
    object CodeList: TSynEdit
      Left = 8
      Top = 44
      Width = 388
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
      RightEdge = -1
      OnSpecialLineColors = OnActiveLine
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
  object gbRegisters: TGroupBox
    Left = 418
    Top = 72
    Width = 150
    Height = 345
    Anchors = [akTop, akRight, akBottom]
    Caption = 'Registers :'
    TabOrder = 1
    DesignSize = (
      150
      345)
    object Registers: TListView
      Left = 9
      Top = 21
      Width = 133
      Height = 313
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <
        item
          Caption = 'Register'
          Width = 55
        end
        item
          Caption = 'Value'
          Width = 74
        end>
      ColumnClick = False
      Items.Data = {
        850100001000000000000000FFFFFFFFFFFFFFFF000000000000000003454158
        00000000FFFFFFFFFFFFFFFF00000000000000000345425800000000FFFFFFFF
        FFFFFFFF00000000000000000345435800000000FFFFFFFFFFFFFFFF00000000
        000000000345445800000000FFFFFFFFFFFFFFFF000000000000000003455349
        00000000FFFFFFFFFFFFFFFF00000000000000000345444900000000FFFFFFFF
        FFFFFFFF00000000000000000345425000000000FFFFFFFFFFFFFFFF00000000
        000000000345535000000000FFFFFFFFFFFFFFFF000000000000000003454950
        00000000FFFFFFFFFFFFFFFF000000000000000002435300000000FFFFFFFFFF
        FFFFFF000000000000000002445300000000FFFFFFFFFFFFFFFF000000000000
        000002535300000000FFFFFFFFFFFFFFFF000000000000000002455300000000
        FFFFFFFFFFFFFFFF000000000000000002465300000000FFFFFFFFFFFFFFFF00
        0000000000000002475300000000FFFFFFFFFFFFFFFF00000000000000000645
        464C414753}
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object rgSyntax: TRadioGroup
    Left = 419
    Top = 8
    Width = 150
    Height = 57
    Anchors = [akTop, akRight]
    Caption = 'Assembly Syntax'
    ItemIndex = 0
    Items.Strings = (
      'Intel'
      'AT&&T')
    TabOrder = 2
    OnClick = rgSyntaxClick
  end
  object CloseBtn: TButton
    Left = 418
    Top = 421
    Width = 150
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = '&Close'
    TabOrder = 3
    OnClick = CloseBtnClick
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
    CommentAttri.Foreground = clHighlight
    CommentAttri.Style = []
    Left = 10
    Top = 420
  end
end
