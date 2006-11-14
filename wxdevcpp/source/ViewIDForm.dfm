object ViewControlIDsForm: TViewControlIDsForm
  Left = 315
  Top = 210
  HelpContext = 1638
  BorderStyle = bsDialog
  Caption = 'Control IDs'
  ClientHeight = 262
  ClientWidth = 439
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btClose: TBitBtn
    Left = 357
    Top = 229
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 0
    OnClick = btCloseClick
  end
  object cbHideZeroValueID: TCheckBox
    Left = 8
    Top = 232
    Width = 145
    Height = 17
    Caption = 'Hide IDs with a value of 0'
    TabOrder = 1
    OnClick = cbHideZeroValueIDClick
  end
  object ControlListBox: TListView
    Left = 8
    Top = 11
    Width = 423
    Height = 210
    Columns = <
      item
        Caption = 'ID'
        Width = 60
      end
      item
        Caption = 'ID Name'
        Width = 130
      end
      item
        Caption = 'Control Name'
        Width = 210
      end>
    GridLines = True
    RowSelect = True
    SortType = stText
    TabOrder = 2
    ViewStyle = vsReport
    OnAdvancedCustomDrawItem = ControlListBoxAdvancedCustomDrawItem
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
    Left = 48
    Top = 164
  end
end
