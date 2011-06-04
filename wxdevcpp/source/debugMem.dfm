object DebugMemFrm: TDebugMemFrm
  Left = 233
  Top = 197
  Width = 556
  Height = 385
  Caption = 'Memory'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 548
    Height = 351
    Align = alClient
    TabOrder = 0
    DesignSize = (
      548
      351)
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
      Left = 472
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
      Width = 549
      Height = 315
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 3
      WordWrap = False
    end
  end
end
