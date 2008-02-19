object CompileProgressForm: TCompileProgressForm
  Left = 318
  Top = 275
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Compile Progress'
  ClientHeight = 240
  ClientWidth = 350
  Color = clBtnFace
  Constraints.MinHeight = 229
  Constraints.MinWidth = 284
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    350
    240)
  PixelsPerInch = 96
  TextHeight = 13
  object btnClose: TButton
    Left = 137
    Top = 210
    Width = 75
    Height = 23
    Anchors = [akBottom]
    Cancel = True
    Caption = 'Cancel'
    Default = True
    TabOrder = 0
  end
  object PageControl1: TPageControl
    Left = 4
    Top = 4
    Width = 341
    Height = 179
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Progress'
      DesignSize = (
        333
        151)
      object Bevel5: TBevel
        Left = 87
        Top = 92
        Width = 86
        Height = 21
      end
      object Bevel1: TBevel
        Left = 87
        Top = 8
        Width = 241
        Height = 21
        Anchors = [akLeft, akTop, akRight]
      end
      object Bevel2: TBevel
        Left = 87
        Top = 36
        Width = 241
        Height = 21
        Anchors = [akLeft, akTop, akRight]
      end
      object Label1: TLabel
        Left = 8
        Top = 12
        Width = 43
        Height = 13
        Caption = 'Compiler:'
        Transparent = True
      end
      object lblCompiler: TLabel
        Left = 92
        Top = 12
        Width = 50
        Height = 13
        Caption = 'lblCompiler'
        Transparent = True
      end
      object lblStatus: TLabel
        Left = 92
        Top = 40
        Width = 40
        Height = 13
        Caption = 'lblStatus'
        Transparent = True
      end
      object Bevel3: TBevel
        Left = 87
        Top = 64
        Width = 241
        Height = 21
        Anchors = [akLeft, akTop, akRight]
      end
      object lblFile: TLabel
        Left = 92
        Top = 68
        Width = 26
        Height = 13
        Caption = 'lblFile'
        Transparent = True
      end
      object Label5: TLabel
        Left = 8
        Top = 68
        Width = 19
        Height = 13
        Caption = 'File:'
        Transparent = True
      end
      object Label3: TLabel
        Left = 8
        Top = 40
        Width = 33
        Height = 13
        Caption = 'Status:'
        Transparent = True
      end
      object Label2: TLabel
        Left = 8
        Top = 96
        Width = 30
        Height = 13
        Caption = 'Errors:'
        Transparent = True
      end
      object lblErr: TLabel
        Left = 92
        Top = 96
        Width = 76
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'lblErr'
        Transparent = True
      end
      object Label4: TLabel
        Left = 187
        Top = 96
        Width = 48
        Height = 13
        Caption = 'Warnings:'
        Transparent = True
      end
      object Bevel6: TBevel
        Left = 242
        Top = 92
        Width = 86
        Height = 21
      end
      object lblWarn: TLabel
        Left = 247
        Top = 96
        Width = 76
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'lblWarn'
        Transparent = True
      end
      object Label6: TLabel
        Left = 8
        Top = 124
        Width = 67
        Height = 13
        Caption = 'Time Elapsed:'
      end
      object Bevel4: TBevel
        Left = 87
        Top = 120
        Width = 241
        Height = 21
        Anchors = [akLeft, akTop, akRight, akBottom]
      end
      object lblElapsed: TLabel
        Left = 92
        Top = 124
        Width = 48
        Height = 13
        Caption = 'lblElapsed'
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Log'
      ImageIndex = 1
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 333
        Height = 151
        Align = alClient
        Color = clBtnFace
        Font.Charset = GREEK_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'Memo1')
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
        WantReturns = False
        WordWrap = False
      end
    end
  end
  object pb: TProgressBar
    Left = 4
    Top = 188
    Width = 339
    Height = 17
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 2
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
    Left = 4
    Top = 208
  end
  object timeTimer: TTimer
    OnTimer = timeTimerTimer
    Left = 32
    Top = 208
  end
end
