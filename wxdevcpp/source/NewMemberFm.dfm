object NewMemberForm: TNewMemberForm
  Left = 300
  Top = 144
  BorderStyle = bsDialog
  Caption = 'New member function'
  ClientHeight = 451
  ClientWidth = 350
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 58
    Height = 13
    Caption = 'Return type:'
  end
  object Label2: TLabel
    Left = 8
    Top = 36
    Width = 70
    Height = 13
    Caption = 'Variable name:'
  end
  object Label3: TLabel
    Left = 8
    Top = 60
    Width = 53
    Height = 13
    Caption = 'Arguments:'
  end
  object Label4: TLabel
    Left = 8
    Top = 82
    Width = 62
    Height = 13
    Caption = 'Implement in:'
  end
  object rgScope: TRadioGroup
    Left = 8
    Top = 106
    Width = 149
    Height = 80
    Caption = 'Access scope'
    Items.Strings = (
      'Private'
      'Protected'
      'Public')
    TabOrder = 4
  end
  object cmbType: TComboBox
    Left = 101
    Top = 8
    Width = 240
    Height = 21
    AutoDropDown = True
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    Text = 'cmbType'
    OnChange = cmbTypeChange
    Items.Strings = (
      'bool'
      'double'
      'float'
      'int'
      'void')
  end
  object txtName: TEdit
    Left = 101
    Top = 32
    Width = 240
    Height = 21
    TabOrder = 1
    Text = 'txtName'
    OnChange = cmbTypeChange
  end
  object txtArguments: TEdit
    Left = 101
    Top = 56
    Width = 240
    Height = 21
    TabOrder = 2
    Text = 'txtArguments'
  end
  object btnCreate: TButton
    Left = 187
    Top = 422
    Width = 75
    Height = 23
    Caption = 'Create'
    Default = True
    ModalResult = 1
    TabOrder = 8
    OnClick = btnCreateClick
  end
  object btnCancel: TButton
    Left = 267
    Top = 422
    Width = 75
    Height = 23
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 9
  end
  object cmbClass: TComboBox
    Left = 101
    Top = 79
    Width = 240
    Height = 21
    AutoDropDown = True
    ItemHeight = 13
    Sorted = True
    TabOrder = 3
    Text = 'cmbClass'
    Items.Strings = (
      'bool'
      'double'
      'float'
      'int'
      'void')
  end
  object grpComment: TGroupBox
    Left = 8
    Top = 195
    Width = 333
    Height = 199
    Caption = 'Comment'
    TabOrder = 6
    object Label7: TLabel
      Left = 8
      Top = 172
      Width = 26
      Height = 13
      Caption = 'Style:'
    end
    object memDescr: TMemo
      Left = 8
      Top = 20
      Width = 320
      Height = 140
      Lines.Strings = (
        'memDescr')
      ScrollBars = ssBoth
      TabOrder = 0
      OnChange = memDescrChange
    end
    object cmbComment: TComboBox
      Left = 40
      Top = 168
      Width = 209
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
  object chkToDo: TCheckBox
    Left = 12
    Top = 400
    Width = 329
    Height = 17
    Caption = 'Add To-do item'
    TabOrder = 7
  end
  object grpAttr: TGroupBox
    Left = 168
    Top = 106
    Width = 173
    Height = 80
    Caption = 'Attributes'
    TabOrder = 5
    object chkStatic: TCheckBox
      Left = 9
      Top = 16
      Width = 53
      Height = 17
      Caption = 'Static'
      TabOrder = 0
      OnClick = chkStaticClick
    end
    object chkVirtual: TCheckBox
      Left = 9
      Top = 34
      Width = 57
      Height = 17
      Caption = 'Virtual'
      TabOrder = 1
      OnClick = chkStaticClick
    end
    object chkPure: TCheckBox
      Left = 97
      Top = 34
      Width = 57
      Height = 17
      Caption = 'Pure'
      TabOrder = 2
      OnClick = chkStaticClick
    end
    object chkInline: TCheckBox
      Left = 9
      Top = 53
      Width = 57
      Height = 17
      Caption = 'Inline'
      TabOrder = 3
      OnClick = chkStaticClick
    end
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
    Top = 420
  end
end
