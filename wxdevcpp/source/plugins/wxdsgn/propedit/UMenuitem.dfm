object MenuItemForm: TMenuItemForm
  Left = 184
  Top = 185
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Menu Item Editor'
  ClientHeight = 330
  ClientWidth = 587
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 264
    Top = 8
    Width = 316
    Height = 218
    Caption = 'Properties'
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 22
      Width = 27
      Height = 13
      Caption = 'Type:'
    end
    object Label2: TLabel
      Left = 10
      Top = 46
      Width = 39
      Height = 13
      Caption = 'Caption:'
    end
    object Label3: TLabel
      Left = 10
      Top = 118
      Width = 46
      Height = 13
      Caption = 'Checked:'
    end
    object Label5: TLabel
      Left = 10
      Top = 142
      Width = 42
      Height = 13
      Caption = 'Enabled:'
    end
    object Label8: TLabel
      Left = 10
      Top = 166
      Width = 22
      Height = 13
      Caption = 'Hint:'
    end
    object Label12: TLabel
      Left = 10
      Top = 70
      Width = 45
      Height = 13
      Caption = 'ID Name:'
    end
    object Label7: TLabel
      Left = 10
      Top = 94
      Width = 44
      Height = 13
      Caption = 'ID Value:'
    end
    object Label10: TLabel
      Left = 10
      Top = 190
      Width = 40
      Height = 13
      Caption = 'Bitmaps:'
    end
    object cbMenuType: TComboBox
      Left = 67
      Top = 18
      Width = 240
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbMenuTypeChange
      Items.Strings = (
        'Menu Item'
        'Separator'
        'Check Item'
        'Radio Item'
        'File History')
    end
    object txtCaption: TEdit
      Left = 67
      Top = 42
      Width = 240
      Height = 21
      Enabled = False
      ImeName = #199#209#177#185#190#238'('#199#209#177#219')'
      TabOrder = 1
      OnExit = txtCaptionExit
      OnKeyDown = txtCaptionKeyDown
    end
    object cbChecked: TComboBox
      Left = 67
      Top = 114
      Width = 74
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 4
      Text = 'False'
      Items.Strings = (
        'False'
        'True')
    end
    object cbEnabled: TComboBox
      Left = 67
      Top = 138
      Width = 74
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 5
      Text = 'True'
      Items.Strings = (
        'False'
        'True')
    end
    object txtHint: TEdit
      Left = 67
      Top = 162
      Width = 240
      Height = 21
      Enabled = False
      TabOrder = 6
    end
    object txtIDValue: TEdit
      Left = 67
      Top = 90
      Width = 240
      Height = 21
      Enabled = False
      TabOrder = 3
    end
    object btBrowse: TButton
      Left = 111
      Top = 187
      Width = 45
      Height = 21
      Caption = 'Browse'
      Enabled = False
      TabOrder = 7
      OnClick = btBrowseClick
    end
    object txtIDName: TComboBox
      Left = 67
      Top = 66
      Width = 240
      Height = 21
      Enabled = False
      ItemHeight = 13
      TabOrder = 2
      OnChange = txtIDNameChange
    end
    object pnlMenuImage: TPanel
      Left = 67
      Top = 186
      Width = 33
      Height = 23
      BevelOuter = bvLowered
      TabOrder = 8
      object bmpMenuImage: TImage
        Left = 0
        Top = 0
        Width = 33
        Height = 23
        Center = True
        Transparent = True
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 252
    Height = 286
    Caption = 'Menu Items'
    TabOrder = 1
    object tvMenuItem: TTreeView
      Left = 8
      Top = 18
      Width = 235
      Height = 255
      Hint = 
        'Left click, drag and drop to move item after drop point.'#13#10'Shift ' +
        '+ left click, then drag and drop to make item child of drop poin' +
        't'
      DragMode = dmAutomatic
      HideSelection = False
      Indent = 19
      ParentShowHint = False
      PopupMenu = PopupMenu1
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
      OnChange = tvMenuItemChange
      OnDragDrop = tvMenuItemDragDrop
      OnDragOver = tvMenuItemDragOver
      OnKeyDown = tvMenuItemKeyDown
    end
  end
  object btnOK: TButton
    Left = 425
    Top = 300
    Width = 75
    Height = 23
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 505
    Top = 300
    Width = 75
    Height = 23
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object btnInsert: TButton
    Left = 108
    Top = 300
    Width = 75
    Height = 23
    Caption = 'Add Item'
    TabOrder = 4
    OnClick = btnInsertClick
  end
  object btnDelete: TButton
    Left = 345
    Top = 300
    Width = 75
    Height = 23
    Caption = 'Delete'
    Enabled = False
    TabOrder = 5
    OnClick = btnDeleteClick
  end
  object btnSubmenu: TButton
    Left = 8
    Top = 300
    Width = 96
    Height = 23
    Caption = 'Create Submenu'
    TabOrder = 6
    OnClick = btnSubmenuClick
  end
  object GroupBox3: TGroupBox
    Left = 265
    Top = 227
    Width = 316
    Height = 67
    Caption = 'Events'
    TabOrder = 7
    object Label4: TLabel
      Left = 8
      Top = 19
      Width = 41
      Height = 13
      Caption = 'OnMenu'
    end
    object Label6: TLabel
      Left = 8
      Top = 42
      Width = 60
      Height = 13
      Caption = 'OnUpdateUI'
    end
    object cbOnMenu: TComboBox
      Left = 77
      Top = 15
      Width = 160
      Height = 21
      Enabled = False
      ItemHeight = 13
      TabOrder = 0
    end
    object cbOnUpdateUI: TComboBox
      Left = 77
      Top = 39
      Width = 160
      Height = 21
      Enabled = False
      ItemHeight = 13
      TabOrder = 1
    end
    object btNewOnMenu: TButton
      Left = 245
      Top = 15
      Width = 62
      Height = 21
      Caption = 'Create'
      Enabled = False
      TabOrder = 2
      OnClick = btNewOnMenuClick
    end
    object btNewUpdateUI: TButton
      Left = 245
      Top = 39
      Width = 62
      Height = 21
      Caption = 'Create'
      Enabled = False
      TabOrder = 3
      OnClick = btNewUpdateUIClick
    end
  end
  object btApply: TButton
    Left = 186
    Top = 299
    Width = 75
    Height = 23
    Caption = 'Apply'
    Enabled = False
    TabOrder = 8
    OnClick = btApplyClick
  end
  object btEdit: TButton
    Left = 265
    Top = 300
    Width = 75
    Height = 23
    Caption = 'Edit'
    Enabled = False
    TabOrder = 9
    OnClick = btEditClick
  end
  object PopupMenu1: TPopupMenu
    Left = 559
    object iNSERT1: TMenuItem
      Caption = 'Insert'
      OnClick = iNSERT1Click
    end
    object Delete1: TMenuItem
      Caption = 'Delete'
      OnClick = Delete1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object CreateSubmenu1: TMenuItem
      Caption = 'Create Submenu'
      OnClick = CreateSubmenu1Click
    end
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
    Gradient = True
    FlatMenu = False
    AutoDetect = False
    XPControls = [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar, xcCombo, xcListBox, xcEdit, xcMaskEdit, xcMemo, xcRichEdit, xcMiscEdit, xcCheckBox, xcRadioButton, xcButton, xcBitBtn, xcSpeedButton, xcUpDown, xcPanel, xcTreeView, xcListView, xcProgressBar, xcHotKey]
    Active = False
    Left = 531
    Top = 65535
  end
end
