object StringsForm: TStringsForm
  Left = 268
  Top = 504
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'String list Editor'
  ClientHeight = 296
  ClientWidth = 458
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDefault
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grpMemo: TGroupBox
    Left = 8
    Top = 8
    Width = 440
    Height = 250
    Caption = '0 Lines'
    TabOrder = 3
    object Memo: TMemo
      Left = 8
      Top = 18
      Width = 420
      Height = 220
      ImeName = #199#209#177#185#190#238'('#199#209#177#219')'
      ScrollBars = ssBoth
      TabOrder = 0
      OnChange = MemoChange
    end
  end
  object btnOK: TBitBtn
    Left = 216
    Top = 264
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 292
    Top = 264
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object btnHelp: TBitBtn
    Left = 373
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Help'
    TabOrder = 2
    Kind = bkHelp
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
    Top = 260
  end
end
