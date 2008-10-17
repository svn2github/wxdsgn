object ModifyVarForm: TModifyVarForm
  Left = 389
  Top = 262
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Modify Watched Variable'
  ClientHeight = 176
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    297
    176)
  PixelsPerInch = 96
  TextHeight = 13
  object NameLabel: TLabel
    Left = 8
    Top = 8
    Width = 75
    Height = 13
    Caption = 'Watch variable:'
  end
  object ValueLabel: TLabel
    Left = 8
    Top = 56
    Width = 54
    Height = 13
    Caption = 'New value:'
  end
  object OkBtn: TBitBtn
    Left = 125
    Top = 144
    Width = 80
    Height = 23
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 0
    Kind = bkOK
  end
  object CancelBtn: TBitBtn
    Left = 210
    Top = 144
    Width = 80
    Height = 23
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
    Kind = bkCancel
  end
  object NameEdit: TEdit
    Left = 8
    Top = 24
    Width = 281
    Height = 21
    TabOrder = 2
    OnKeyPress = NameEditKeyPress
  end
  object ValueEdit: TEdit
    Left = 8
    Top = 72
    Width = 281
    Height = 21
    TabOrder = 3
  end
  object chkStopOnRead: TCheckBox
    Left = 8
    Top = 122
    Width = 100
    Height = 17
    Caption = 'Break on Read'
    TabOrder = 4
  end
  object chkStopOnWrite: TCheckBox
    Left = 8
    Top = 104
    Width = 97
    Height = 17
    Caption = 'Break on Write'
    Checked = True
    State = cbChecked
    TabOrder = 5
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
    Left = 7
    Top = 140
  end
end
