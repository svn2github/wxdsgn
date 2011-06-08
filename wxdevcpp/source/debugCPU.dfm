object DebugCPUFrm: TDebugCPUFrm
  Left = 117
  Top = 12
  Width = 768
  Height = 564
  Caption = 'CPU'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 569
    Top = 0
    Width = 20
    Height = 530
    Cursor = crHSplit
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 569
    Height = 530
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 0
    object Splitter2: TSplitter
      Left = 1
      Top = 265
      Width = 567
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 567
      Height = 264
      Align = alTop
      TabOrder = 0
      DesignSize = (
        567
        264)
      object Label1: TLabel
        Left = 8
        Top = 4
        Width = 70
        Height = 13
        Caption = 'Disassembly'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 40
        Top = 19
        Width = 56
        Height = 13
        Caption = 'Source File:'
      end
      object DisassemblyRefreshButton: TButton
        Left = 491
        Top = 18
        Width = 67
        Height = 20
        Anchors = [akTop, akRight]
        Caption = 'Refresh'
        TabOrder = 0
        OnClick = DisassemblyRefreshButtonClick
      end
      object SrcFileName: TEdit
        Left = 104
        Top = 15
        Width = 297
        Height = 21
        TabOrder = 1
      end
      object DisassemblyRichEdit: TRichEdit
        Left = 0
        Top = 40
        Width = 564
        Height = 225
        Anchors = [akLeft, akTop, akRight, akBottom]
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 2
        WordWrap = False
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 268
      Width = 567
      Height = 261
      Align = alClient
      TabOrder = 1
      DesignSize = (
        567
        261)
      object Label2: TLabel
        Left = 8
        Top = 4
        Width = 44
        Height = 13
        Caption = 'Memory'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 56
        Top = 12
        Width = 41
        Height = 13
        Caption = 'Address:'
      end
      object Label4: TLabel
        Left = 298
        Top = 12
        Width = 31
        Height = 13
        Caption = 'Count:'
      end
      object MemoryRefreshButton: TButton
        Left = 491
        Top = 10
        Width = 67
        Height = 20
        Anchors = [akTop, akRight]
        Caption = 'Refresh'
        TabOrder = 0
        OnClick = MemoryRefreshButtonClick
      end
      object MemoryAddressEdit: TEdit
        Left = 104
        Top = 8
        Width = 177
        Height = 21
        TabOrder = 1
      end
      object MemoryCountEdit: TEdit
        Left = 336
        Top = 8
        Width = 65
        Height = 21
        TabOrder = 2
        Text = '1'
      end
      object MemoryRichEdit: TRichEdit
        Left = 0
        Top = 32
        Width = 565
        Height = 225
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 3
        WordWrap = False
      end
    end
  end
  object Panel4: TPanel
    Left = 589
    Top = 0
    Width = 171
    Height = 530
    Align = alClient
    TabOrder = 1
    DesignSize = (
      171
      530)
    object RegisterList: TValueListEditor
      Left = 1
      Top = 24
      Width = 169
      Height = 502
      Anchors = [akLeft, akTop, akRight, akBottom]
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goThumbTracking]
      Strings.Strings = (
        '=')
      TabOrder = 0
      TitleCaptions.Strings = (
        'Register'
        'Value')
      ColWidths = (
        76
        87)
    end
    object StaticText1: TStaticText
      Left = 8
      Top = 4
      Width = 57
      Height = 17
      Caption = 'Registers'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object RegistersRefreshButton: TButton
      Left = 96
      Top = 2
      Width = 67
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'Refresh'
      TabOrder = 2
      OnClick = RegistersRefreshButtonClick
    end
  end
end
