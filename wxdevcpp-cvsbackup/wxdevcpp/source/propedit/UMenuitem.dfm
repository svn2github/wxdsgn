object MenuItemForm: TMenuItemForm
  Left = 184
  Top = 185
  BorderStyle = bsDialog
  Caption = 'Menu Item Editor'
  ClientHeight = 363
  ClientWidth = 587
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 270
    Top = 17
    Width = 310
    Height = 233
    Caption = 'Properties'
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 22
      Width = 24
      Height = 13
      Caption = 'Type'
    end
    object Label2: TLabel
      Left = 10
      Top = 44
      Width = 36
      Height = 13
      Caption = 'Caption'
    end
    object Label3: TLabel
      Left = 10
      Top = 114
      Width = 43
      Height = 13
      Caption = 'Checked'
    end
    object Label5: TLabel
      Left = 10
      Top = 138
      Width = 39
      Height = 13
      Caption = 'Enabled'
    end
    object Label8: TLabel
      Left = 10
      Top = 180
      Width = 19
      Height = 13
      Caption = 'Hint'
    end
    object Label12: TLabel
      Left = 10
      Top = 65
      Width = 42
      Height = 13
      Caption = 'ID Name'
    end
    object Label13: TLabel
      Left = 10
      Top = 160
      Width = 30
      Height = 13
      Caption = 'Visible'
      Visible = False
    end
    object Label7: TLabel
      Left = 10
      Top = 89
      Width = 41
      Height = 13
      Caption = 'ID Value'
    end
    object Label10: TLabel
      Left = 10
      Top = 204
      Width = 37
      Height = 13
      Caption = 'Bitmaps'
    end
    object bmpMenuImage: TImage
      Left = 64
      Top = 203
      Width = 33
      Height = 25
      Center = True
      Transparent = True
    end
    object Image1: TImage
      Left = 189
      Top = 203
      Width = 33
      Height = 25
      Center = True
      Transparent = True
      Visible = False
    end
    object cbMenuType: TComboBox
      Left = 67
      Top = 18
      Width = 233
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbMenuTypeChange
      Items.Strings = (
        'Menu Item'
        'Seperator'
        'Check Item'
        'Radio Item')
    end
    object txtCaption: TEdit
      Left = 67
      Top = 40
      Width = 231
      Height = 21
      Enabled = False
      ImeName = #199#209#177#185#190#238'('#199#209#177#219')'
      TabOrder = 1
      OnExit = txtCaptionExit
      OnKeyDown = txtCaptionKeyDown
    end
    object cbChecked: TComboBox
      Left = 67
      Top = 110
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
      Top = 133
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
      Top = 177
      Width = 230
      Height = 21
      Enabled = False
      TabOrder = 7
    end
    object cbVisible: TComboBox
      Left = 67
      Top = 155
      Width = 74
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 6
      Text = 'True'
      Visible = False
      Items.Strings = (
        'False'
        'True')
    end
    object txtIDValue: TEdit
      Left = 67
      Top = 86
      Width = 231
      Height = 21
      Enabled = False
      TabOrder = 3
    end
    object btBrowse: TButton
      Left = 108
      Top = 204
      Width = 45
      Height = 21
      Caption = 'Browse'
      Enabled = False
      TabOrder = 8
      OnClick = btBrowseClick
    end
    object Button3: TButton
      Left = 234
      Top = 204
      Width = 45
      Height = 21
      Caption = 'Browse'
      Enabled = False
      TabOrder = 9
      Visible = False
      OnClick = btBrowseClick
    end
    object txtIDName: TComboBox
      Left = 67
      Top = 62
      Width = 231
      Height = 21
      Enabled = False
      ItemHeight = 13
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 15
    Top = 17
    Width = 252
    Height = 301
    Caption = 'Menu Items'
    TabOrder = 1
    object tvMenuItem: TTreeView
      Left = 5
      Top = 13
      Width = 241
      Height = 281
      Hint = 
        'TO RE-ORDER MENU'#13#10'=================='#13#10#13#10'* Left click, drag and d' +
        'rop = Item moves after the drop point'#13#10'* SHIFT + left click, dra' +
        'g and drop = Item becomes child of the drop point'
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
    Left = 430
    Top = 330
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 508
    Top = 330
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object btnInsert: TButton
    Left = 116
    Top = 331
    Width = 75
    Height = 25
    Caption = 'Add Item'
    TabOrder = 4
    OnClick = btnInsertClick
  end
  object btnDelete: TButton
    Left = 353
    Top = 331
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 5
    OnClick = btnDeleteClick
  end
  object btnSubmenu: TButton
    Left = 19
    Top = 331
    Width = 96
    Height = 25
    Caption = 'Create Submenu'
    TabOrder = 6
    OnClick = btnSubmenuClick
  end
  object GroupBox3: TGroupBox
    Left = 271
    Top = 252
    Width = 309
    Height = 65
    Caption = 'Events'
    TabOrder = 7
    object Label4: TLabel
      Left = 5
      Top = 17
      Width = 41
      Height = 13
      Caption = 'OnMenu'
    end
    object Label6: TLabel
      Left = 4
      Top = 41
      Width = 60
      Height = 13
      Caption = 'OnUpdateUI'
    end
    object cbOnMenu: TComboBox
      Left = 72
      Top = 15
      Width = 164
      Height = 21
      Enabled = False
      ItemHeight = 13
      TabOrder = 0
    end
    object cbOnUpdateUI: TComboBox
      Left = 72
      Top = 39
      Width = 164
      Height = 21
      Enabled = False
      ItemHeight = 13
      TabOrder = 1
    end
  end
  object btApply: TButton
    Left = 194
    Top = 330
    Width = 74
    Height = 25
    Caption = 'Apply'
    Enabled = False
    TabOrder = 8
    OnClick = btApplyClick
  end
  object btEdit: TButton
    Left = 274
    Top = 330
    Width = 76
    Height = 25
    Caption = 'Edit'
    TabOrder = 9
    OnClick = btEditClick
  end
  object btNewOnMenu: TButton
    Left = 509
    Top = 266
    Width = 62
    Height = 23
    Caption = 'Create'
    Enabled = False
    TabOrder = 10
    OnClick = btNewOnMenuClick
  end
  object btNewUpdateUI: TButton
    Left = 509
    Top = 292
    Width = 62
    Height = 21
    Caption = 'Create'
    Enabled = False
    TabOrder = 11
    OnClick = btNewUpdateUIClick
  end
  object PopupMenu1: TPopupMenu
    Left = 199
    Top = 104
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
  object MainMenu1: TMainMenu
    Left = 159
    Top = 64
  end
end
