object frmCreateFormProp: TfrmCreateFormProp
  Left = 259
  Top = 208
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Create new Dialog'
  ClientHeight = 231
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 56
    Height = 13
    Caption = 'Class Name'
    Transparent = True
  end
  object Label2: TLabel
    Left = 8
    Top = 59
    Width = 41
    Height = 13
    Caption = 'Save To'
    Transparent = True
  end
  object Label3: TLabel
    Left = 8
    Top = 35
    Width = 45
    Height = 13
    Caption = 'File name'
    Transparent = True
  end
  object Label5: TLabel
    Left = 8
    Top = 83
    Width = 20
    Height = 13
    Caption = 'Title'
    Transparent = True
  end
  object Bevel1: TBevel
    Left = 0
    Top = 185
    Width = 430
    Height = 9
    Shape = bsBottomLine
  end
  object Label7: TLabel
    Left = 329
    Top = 35
    Width = 92
    Height = 13
    Caption = '(Without Extension)'
    Transparent = True
  end
  object Label8: TLabel
    Left = 8
    Top = 107
    Width = 31
    Height = 13
    Caption = 'Author'
    Transparent = True
  end
  object Label6: TLabel
    Left = 7
    Top = 131
    Width = 60
    Height = 13
    Caption = 'Default Style'
    Transparent = True
  end
  object txtSaveTo: TEdit
    Left = 88
    Top = 56
    Width = 297
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object txtClassName: TEdit
    Left = 88
    Top = 8
    Width = 240
    Height = 21
    TabOrder = 0
  end
  object txtFileName: TEdit
    Left = 88
    Top = 32
    Width = 240
    Height = 21
    TabOrder = 1
  end
  object btBrowse: TButton
    Left = 396
    Top = 56
    Width = 25
    Height = 20
    Caption = '...'
    TabOrder = 3
    OnClick = btBrowseClick
  end
  object txtTitle: TEdit
    Left = 88
    Top = 80
    Width = 333
    Height = 21
    TabOrder = 4
  end
  object btCancel: TButton
    Left = 349
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 7
    OnClick = btCancelClick
  end
  object btCreate: TButton
    Left = 274
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Create'
    Default = True
    TabOrder = 6
    OnClick = btCreateClick
  end
  object txtAuthorName: TEdit
    Left = 88
    Top = 104
    Width = 333
    Height = 21
    TabOrder = 5
  end
  object cbUseCaption: TCheckBox
    Left = 88
    Top = 131
    Width = 89
    Height = 17
    Caption = 'Use Caption'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object cbResizeBorder: TCheckBox
    Left = 184
    Top = 131
    Width = 89
    Height = 17
    Caption = 'Resize Border'
    TabOrder = 9
  end
  object cbSystemMenu: TCheckBox
    Left = 280
    Top = 131
    Width = 89
    Height = 17
    Caption = 'System Menu'
    Checked = True
    State = cbChecked
    TabOrder = 10
  end
  object cbThickBorder: TCheckBox
    Left = 88
    Top = 147
    Width = 89
    Height = 17
    Caption = 'Thick Border'
    TabOrder = 11
  end
  object cbStayOnTop: TCheckBox
    Left = 184
    Top = 147
    Width = 89
    Height = 17
    Caption = 'Stay On Top'
    TabOrder = 12
  end
  object cbNoParent: TCheckBox
    Left = 280
    Top = 147
    Width = 89
    Height = 17
    Caption = 'No Parent'
    Checked = True
    State = cbChecked
    TabOrder = 13
  end
  object cbMinButton: TCheckBox
    Left = 88
    Top = 163
    Width = 89
    Height = 17
    Caption = 'Min Button'
    Checked = True
    State = cbChecked
    TabOrder = 14
  end
  object cbMaxButton: TCheckBox
    Left = 184
    Top = 163
    Width = 89
    Height = 17
    Caption = 'Max Button'
    TabOrder = 15
  end
  object cbCloseButton: TCheckBox
    Left = 280
    Top = 163
    Width = 89
    Height = 17
    Caption = 'Close Button'
    Checked = True
    State = cbChecked
    TabOrder = 16
  end
  object JvFormStorage1: TJvFormStorage
    AppStorage = JvAppRegistryStorage1
    AppStoragePath = '%FORM_NAME%'
    StoredProps.Strings = (
      'txtAuthorName.Text'
      'txtClassName.Text'
      'txtFileName.Text'
      'txtSaveTo.Text'
      'txtTitle.Text')
    StoredValues = <>
    Left = 39
    Top = 196
  end
  object JvAppRegistryStorage1: TJvAppRegistryStorage
    StorageOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    StorageOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    Root = 'Software\dlgHelper'
    SubStorages = <>
    Left = 4
    Top = 195
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
    Left = 72
    Top = 196
  end
end