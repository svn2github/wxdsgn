object NewClassForm: TNewClassForm
  Left = 360
  Top = 140
  BorderStyle = bsDialog
  Caption = 'New class'
  ClientHeight = 460
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 57
    Height = 13
    Caption = 'Class name:'
  end
  object Label4: TLabel
    Left = 8
    Top = 188
    Width = 116
    Height = 13
    Caption = 'Implementation filename:'
  end
  object Label5: TLabel
    Left = 8
    Top = 216
    Width = 80
    Height = 13
    Caption = 'Header filename:'
  end
  object btnBrowseCpp: TSpeedButton
    Left = 338
    Top = 184
    Width = 23
    Height = 22
    Caption = '...'
    OnClick = btnBrowseCppClick
  end
  object btnBrowseH: TSpeedButton
    Left = 338
    Top = 212
    Width = 23
    Height = 22
    Caption = '...'
    OnClick = btnBrowseCppClick
  end
  object Label9: TLabel
    Left = 8
    Top = 36
    Width = 53
    Height = 13
    Caption = 'Arguments:'
  end
  object txtName: TEdit
    Left = 88
    Top = 8
    Width = 273
    Height = 21
    TabOrder = 0
    Text = 'txtName'
    OnChange = txtNameChange
    OnKeyPress = txtNameKeyPress
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 84
    Width = 353
    Height = 93
    Caption = 'Inheritance'
    TabOrder = 3
    object Label2: TLabel
      Left = 16
      Top = 20
      Width = 70
      Height = 13
      Caption = 'Access scope:'
    end
    object Label3: TLabel
      Left = 16
      Top = 44
      Width = 82
      Height = 13
      Caption = 'Inherit from class:'
    end
    object Label6: TLabel
      Left = 16
      Top = 68
      Width = 80
      Height = 13
      Caption = 'Header filename:'
    end
    object cmbClass: TComboBox
      Left = 137
      Top = 41
      Width = 208
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = 'cmbClass'
      OnChange = cmbClassChange
    end
    object cmbScope: TComboBox
      Left = 137
      Top = 16
      Width = 208
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        'private'
        'protected'
        'public')
    end
    object txtIncFile: TEdit
      Left = 137
      Top = 66
      Width = 208
      Height = 21
      TabOrder = 2
      Text = 'txtIncFile'
    end
  end
  object txtCppFile: TEdit
    Left = 145
    Top = 184
    Width = 190
    Height = 21
    TabOrder = 4
    Text = 'txtCppFile'
    OnChange = txtCppFileChange
  end
  object txtHFile: TEdit
    Left = 145
    Top = 212
    Width = 190
    Height = 21
    TabOrder = 5
    Text = 'txtHFile'
    OnChange = txtCppFileChange
  end
  object chkAddToProject: TCheckBox
    Left = 8
    Top = 240
    Width = 353
    Height = 17
    Caption = 'Add to current project'
    TabOrder = 6
  end
  object btnCreate: TButton
    Left = 211
    Top = 431
    Width = 75
    Height = 23
    Caption = 'Create'
    Default = True
    ModalResult = 1
    TabOrder = 8
    OnClick = btnCreateClick
  end
  object btnCancel: TButton
    Left = 291
    Top = 431
    Width = 75
    Height = 23
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 9
  end
  object chkInherit: TCheckBox
    Left = 8
    Top = 60
    Width = 353
    Height = 17
    Caption = 'Inherit from another class'
    TabOrder = 2
    OnClick = chkInheritClick
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 272
    Width = 357
    Height = 153
    Caption = 'Comment'
    TabOrder = 7
    object Label8: TLabel
      Left = 8
      Top = 128
      Width = 26
      Height = 13
      Caption = 'Style:'
    end
    object memDescr: TMemo
      Left = 8
      Top = 20
      Width = 340
      Height = 95
      Lines.Strings = (
        'memDescr')
      ScrollBars = ssBoth
      TabOrder = 0
      OnChange = memDescrChange
    end
    object cmbComment: TComboBox
      Left = 45
      Top = 124
      Width = 217
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = '/** doxygen style comment */'
      Items.Strings = (
        '/** doxygen style comment */'
        '/* C style comment */'
        '// C++ style comment')
    end
  end
  object txtArgs: TEdit
    Left = 88
    Top = 32
    Width = 273
    Height = 21
    TabOrder = 1
    Text = 'txtArgs'
  end
  object SaveDialog1: TSaveDialog
    Left = 300
    Top = 184
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
    Left = 9
    Top = 427
  end
end
