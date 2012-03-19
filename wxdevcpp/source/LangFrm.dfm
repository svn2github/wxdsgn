object LangForm: TLangForm
  Left = 343
  Top = 142
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'wxDev-C++ First-Run Configuration'
  ClientHeight = 333
  ClientWidth = 454
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object FinishPanel: TPanel
    Left = 144
    Top = 8
    Width = 305
    Height = 249
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    object Label6: TLabel
      Left = 4
      Top = 0
      Width = 285
      Height = 26
      Caption = 
        'That'#39's all we need to set up wxDev-C++ for use; Click OK to exit' +
        ' this wizard and continue wxDev-C++'#39's start up.'
      WordWrap = True
    end
    object Label4: TLabel
      Left = 5
      Top = 49
      Width = 273
      Height = 39
      Caption = 
        'If you need help using wxDev-C++, please refer to the wxDev-C++ ' +
        'help file in the Help menu. You will also find a FAQ as well as ' +
        'a C tutorial.'
      WordWrap = True
    end
    object Label7: TLabel
      Left = 4
      Top = 98
      Width = 282
      Height = 52
      Caption = 
        'You can also download DevPaks (like libraries or tools) to use w' +
        'ith wxDev-C++, as well as upgrade wxDev-C++ to the latest versio' +
        'n by using WebUpdate, which you can find in Tools | Check for Up' +
        'dates/Packages.'
      WordWrap = True
    end
  end
  object CachePanel: TPanel
    Left = 152
    Top = 8
    Width = 305
    Height = 281
    BevelOuter = bvNone
    TabOrder = 4
    Visible = False
    object Label2: TLabel
      Left = 4
      Top = 8
      Width = 284
      Height = 52
      Caption = 
        'wxDev-C++ can create a cache containing the declarations found i' +
        'n global include files. This will speed up project load times as' +
        ' it would remove the need to parse global include files every ti' +
        'me one project is loaded.'
      WordWrap = True
    end
    object Label3: TLabel
      Left = 4
      Top = 83
      Width = 282
      Height = 52
      Caption = 
        'Do you want to create the code completion cache now? This can ta' +
        'ke several minutes, depending on the resources available on the ' +
        'system. It is also possible to create this cache later in Editor' +
        ' Options | Class Browsing | Completion.'
      WordWrap = True
    end
    object ProgressPanel: TPanel
      Left = 0
      Top = 150
      Width = 265
      Height = 100
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      object ParseLabel: TLabel
        Left = 16
        Top = 20
        Width = 65
        Height = 13
        Caption = 'Parsing files...'
        WordWrap = True
      end
      object pbCCCache: TProgressBar
        Left = 14
        Top = 62
        Width = 235
        Height = 16
        Min = 0
        Max = 100
        TabOrder = 0
        Visible = False
      end
    end
    object BuildPanel: TPanel
      Left = 0
      Top = 150
      Width = 305
      Height = 123
      BevelOuter = bvNone
      TabOrder = 0
      object LoadBtn: TSpeedButton
        Left = 260
        Top = 87
        Width = 29
        Height = 30
        Enabled = False
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000BFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBF0000000000000000
          00000000000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BF
          BFBF000000BFBFBF0000005DCCFF5DCCFF5DCCFF000000BFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBF6868680000000000
          00000000000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBF0000000000000000
          00000000000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BF
          BFBF000000BFBFBF0000005DCCFF5DCCFF5DCCFF000000BFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBF000000BFBFBFBFBFBFBFBFBFBFBFBF6868680000000000
          00000000000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000000000
          000000000000000000000000000000000000000000000000000000BFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBF00000000AEFF0096DB0096DB0096DB0096DB0096DB00
          96DB0096DB0082BE000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000005DCCFF
          00AEFF00AEFF00AEFF00AEFF00AEFF00AEFF00AEFF0096DB000000BFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBF0000005DCCFF00AEFF00AEFF00AEFF00AEFF00AEFF00
          AEFF00AEFF0096DB000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000005DCCFF
          00AEFF00AEFF00AEFF00AEFF00AEFF00AEFF00AEFF0096DB000000BFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBF0000005DCCFF00AEFF00AEFF5DCCFF5DCCFF5DCCFF5D
          CCFF5DCCFF00AEFF000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF686868BDEBFF
          5DCCFF5DCCFF000000000000000000000000000000000000BFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBF000000000000000000BFBFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF}
        OnClick = LoadBtnClick
      end
      object YesCache: TRadioButton
        Left = 56
        Top = 10
        Width = 185
        Height = 17
        Caption = 'Yes, create the cache now'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object NoCache: TRadioButton
        Left = 56
        Top = 33
        Width = 209
        Height = 17
        Caption = 'No, do not create the cache'
        TabOrder = 1
      end
      object DirCheckBox: TCheckBox
        Left = 8
        Top = 60
        Width = 273
        Height = 25
        Caption = 'Parse this directory instead of the standard one:'
        TabOrder = 2
        OnClick = DirCheckBoxClick
      end
      object DirEdit: TEdit
        Left = 8
        Top = 91
        Width = 241
        Height = 21
        Enabled = False
        HideSelection = False
        TabOrder = 3
      end
    end
  end
  object SecondPanel: TPanel
    Left = 144
    Top = 8
    Width = 305
    Height = 265
    BevelOuter = bvNone
    TabOrder = 5
    Visible = False
    object SecondLabel: TLabel
      Left = 4
      Top = 0
      Width = 251
      Height = 52
      Caption = 
        'wxDev-C++ can retrieve information from header files to help you' +
        ' find function, class and variable type information easily throu' +
        'gh a class browser and a code completion list. '
      WordWrap = True
    end
    object Label5: TLabel
      Left = 4
      Top = 62
      Width = 275
      Height = 52
      Caption = 
        'Although this feature is useful, it requires more CPU power and ' +
        'memory to function, and may not be suitable for all developers. ' +
        'Do you want to use it? You can enable or disable it later in Edi' +
        'tor Options | Class Browser.'
      WordWrap = True
    end
    object Label8: TLabel
      Left = 7
      Top = 137
      Width = 280
      Height = 52
      Caption = 
        'Do note that the Class Browser is needed for the automatic gener' +
        'ation of event handlers when designing wxWidgets Forms. Of cours' +
        'e, you can still manually assign event handlers with the Class B' +
        'rowser off.'
      WordWrap = True
    end
    object YesClassBrowser: TRadioButton
      Left = 36
      Top = 212
      Width = 250
      Height = 17
      Caption = 'Yes, I want to use this feature'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object NoClassBrowser: TRadioButton
      Left = 36
      Top = 232
      Width = 250
      Height = 17
      Caption = 'No, I prefer to use wxDev-C++ without it'
      TabOrder = 1
    end
  end
  object FirstPanel: TPanel
    Left = 144
    Top = 8
    Width = 305
    Height = 281
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 273
      Height = 39
      Caption = 
        'This is the first time you have launched wxDev-C++. Here are som' +
        'e questions to help configure wxDev-C++ to your liking.'
      WordWrap = True
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 56
      Width = 297
      Height = 137
      Caption = 'Select your language :'
      TabOrder = 1
    end
    object ThemeGroupBox: TGroupBox
      Left = 0
      Top = 200
      Width = 297
      Height = 73
      Caption = 'Select your wxDev-C++ theme :'
      TabOrder = 2
      object ThemeBox: TComboBox
        Left = 16
        Top = 22
        Width = 169
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = ThemeBoxChange
      end
      object PreviewBtn: TBitBtn
        Left = 202
        Top = 22
        Width = 75
        Height = 35
        Caption = '&Preview'
        TabOrder = 1
        OnClick = PreviewBtnClick
      end
      object XPCheckBox: TCheckBox
        Left = 16
        Top = 50
        Width = 97
        Height = 17
        Caption = '&Use XP Theme'
        TabOrder = 2
        OnClick = XPCheckBoxClick
      end
    end
    object ListBox: TListBox
      Left = 8
      Top = 72
      Width = 281
      Height = 113
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object OkBtn: TBitBtn
    Left = 152
    Top = 296
    Width = 281
    Height = 25
    Caption = '&Next'
    Default = True
    TabOrder = 0
    OnClick = OkBtnClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000BFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBF000000009836000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000000A13900A13900983600
      0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      0000008FFF8F00C54600B03F00B03F009836000000BFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000008FFF8F00C54600B03F00
      B03F009836000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBF0000008FFF8F00C54600B03F00B03F009836000000BFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000008FFF8F00
      B03F00B03F00A139009836000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBF00000000B03F00B03F00B03F00A1390098360000
      00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000000B03F00
      B03F00B03F00B03F00A139000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBF00000000C54600B03F00B03F00B03F00A139000000BFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000000C54600C54600B03F00
      B03F00B03F000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      0000008FFF8F00DD0000C54600C54600C546000000BFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000008FFF8F00DD0000C54600
      0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBF0000008FFF8F000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBFBF
      BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF}
  end
  object PicPanel: TPanel
    Left = 8
    Top = 8
    Width = 128
    Height = 281
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 1
    object Image2: TImage
      Left = 1
      Top = 1
      Width = 126
      Height = 279
      Align = alClient
      AutoSize = True
    end
  end
  object PopupMenu: TPopupMenu
    Left = 96
    Top = 136
    object N1: TMenuItem
      ImageIndex = 0
    end
    object TMenuItem
      ImageIndex = 1
    end
    object TMenuItem
      ImageIndex = 2
    end
    object TMenuItem
      ImageIndex = 3
    end
    object TMenuItem
      ImageIndex = 4
    end
    object TMenuItem
      ImageIndex = 5
    end
    object TMenuItem
      ImageIndex = 6
    end
    object TMenuItem
      ImageIndex = 7
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
    Gradient = True
    FlatMenu = False
    AutoDetect = True
    XPControls = [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar, xcCombo, xcListBox, xcEdit, xcMaskEdit, xcMemo, xcRichEdit, xcMiscEdit, xcCheckBox, xcRadioButton, xcButton, xcBitBtn, xcSpeedButton, xcUpDown, xcPanel, xcTreeView, xcListView, xcProgressBar, xcHotKey]
    Active = False
    Left = 64
    Top = 136
  end
end
