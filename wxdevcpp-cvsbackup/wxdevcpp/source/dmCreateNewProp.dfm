object frmCreateFormProp: TfrmCreateFormProp
  Left = 259
  Top = 208
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Create new Dialog'
  ClientHeight = 247
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 19
    Width = 56
    Height = 13
    Caption = 'Class Name'
  end
  object Label2: TLabel
    Left = 16
    Top = 67
    Width = 44
    Height = 13
    Caption = 'Save  To'
  end
  object Label3: TLabel
    Left = 16
    Top = 43
    Width = 45
    Height = 13
    Caption = 'File name'
  end
  object Label5: TLabel
    Left = 16
    Top = 91
    Width = 20
    Height = 13
    Caption = 'Title'
  end
  object Label6: TLabel
    Left = 16
    Top = 115
    Width = 60
    Height = 13
    Caption = 'Default Style'
  end
  object Bevel1: TBevel
    Left = 16
    Top = 192
    Width = 401
    Height = 9
    Shape = bsBottomLine
  end
  object Label7: TLabel
    Left = 304
    Top = 43
    Width = 92
    Height = 13
    Caption = '(Without Extension)'
  end
  object Label8: TLabel
    Left = 16
    Top = 171
    Width = 31
    Height = 13
    Caption = 'Author'
  end
  object txtSaveTo: TEdit
    Left = 96
    Top = 64
    Width = 289
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object txtClassName: TEdit
    Left = 96
    Top = 16
    Width = 201
    Height = 21
    TabOrder = 0
  end
  object txtFileName: TEdit
    Left = 96
    Top = 40
    Width = 201
    Height = 21
    TabOrder = 1
  end
  object btBrowse: TButton
    Left = 388
    Top = 64
    Width = 25
    Height = 20
    Caption = '...'
    TabOrder = 3
    OnClick = btBrowseClick
  end
  object txtTitle: TEdit
    Left = 96
    Top = 88
    Width = 289
    Height = 21
    TabOrder = 4
  end
  object cbUseCaption: TCheckBox
    Left = 96
    Top = 112
    Width = 89
    Height = 17
    Caption = 'Use Caption'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object cbResizeBorder: TCheckBox
    Left = 192
    Top = 112
    Width = 89
    Height = 17
    Caption = 'Resize Border'
    TabOrder = 6
  end
  object cbSystemMenu: TCheckBox
    Left = 288
    Top = 112
    Width = 89
    Height = 17
    Caption = 'System Menu'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object cbThickBorder: TCheckBox
    Left = 96
    Top = 128
    Width = 89
    Height = 17
    Caption = 'Thick Border'
    TabOrder = 8
  end
  object cbStayOnTop: TCheckBox
    Left = 192
    Top = 128
    Width = 89
    Height = 17
    Caption = 'Stay On Top'
    TabOrder = 9
  end
  object cbNoParent: TCheckBox
    Left = 288
    Top = 128
    Width = 89
    Height = 17
    Caption = 'No Parent'
    Checked = True
    State = cbChecked
    TabOrder = 10
  end
  object btCancel: TButton
    Left = 344
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 15
    OnClick = btCancelClick
  end
  object btCreate: TButton
    Left = 16
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Create'
    Default = True
    TabOrder = 14
    OnClick = btCreateClick
  end
  object txtAuthorName: TEdit
    Left = 96
    Top = 168
    Width = 321
    Height = 21
    TabOrder = 13
  end
  object cbMinButton: TCheckBox
    Left = 96
    Top = 144
    Width = 89
    Height = 17
    Caption = 'Min Button'
    Checked = True
    State = cbChecked
    TabOrder = 11
  end
  object cbMaxButton: TCheckBox
    Left = 192
    Top = 144
    Width = 89
    Height = 17
    Caption = 'Max Button'
    TabOrder = 12
  end
  object cbCloseButton: TCheckBox
    Left = 288
    Top = 144
    Width = 89
    Height = 17
    Caption = 'Close Button'
    Checked = True
    State = cbChecked
    TabOrder = 16
  end
  object JvFormStorage1: TJvFormStorage
    AppStorage = JvAppRegistryStorage1
    StoredProps.Strings = (
      'txtAuthorName.Text'
      'txtClassName.Text'
      'txtFileName.Text'
      'txtSaveTo.Text'
      'txtTitle.Text')
    StoredValues = <>
    Left = 232
    Top = 200
  end
  object JvAppRegistryStorage1: TJvAppRegistryStorage
    StorageOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    StorageOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    Root = 'Software\dlgHelper'
    SubStorages = <>
    Left = 136
    Top = 192
  end
  object JvBrwrFldrDlg: TJvSelectDirectory
    Left = 280
    Top = 160
  end
end
