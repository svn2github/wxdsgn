object frmShortcutsEditor: TfrmShortcutsEditor
  Left = 419
  Top = 270
  BorderStyle = bsDialog
  Caption = 'Configure Shortcuts'
  ClientHeight = 377
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lvShortcuts: TListView
    Left = 0
    Top = 57
    Width = 395
    Height = 285
    Align = alClient
    Columns = <
      item
        Caption = 'Menu entry'
        Width = 250
      end
      item
        Caption = 'Shortcut assigned'
        Width = 104
      end>
    ColumnClick = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnCustomDrawItem = lvShortcutsCustomDrawItem
    OnCustomDrawSubItem = lvShortcutsCustomDrawSubItem
    OnKeyDown = lvShortcutsKeyDown
  end
  object Panel1: TPanel
    Left = 0
    Top = 342
    Width = 395
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnOk: TButton
      Left = 213
      Top = 6
      Width = 75
      Height = 23
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 293
      Top = 6
      Width = 75
      Height = 23
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pnlTitle: TPanel
    Left = 0
    Top = 0
    Width = 395
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    Color = clGray
    TabOrder = 2
    object lblTip: TLabel
      Left = 0
      Top = 44
      Width = 395
      Height = 13
      Align = alBottom
      Caption = 'Tip: press "Escape" to clear a shortcut...'
      Transparent = True
    end
    object lblTitle: TLabel
      Left = 0
      Top = 0
      Width = 395
      Height = 44
      Align = alClient
      Caption = 'Click on an item and press the shortcut you desire!'
      Transparent = True
      WordWrap = True
    end
  end
end
