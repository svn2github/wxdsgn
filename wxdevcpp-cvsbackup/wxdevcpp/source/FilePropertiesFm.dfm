object FilePropertiesForm: TFilePropertiesForm
  Left = 287
  Top = 160
  BorderStyle = bsDialog
  Caption = 'File properties'
  ClientHeight = 265
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 167
    Top = 232
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object GroupBox1: TGroupBox
    Left = 9
    Top = 9
    Width = 393
    Height = 97
    TabOrder = 1
    object Label2: TLabel
      Left = 7
      Top = 10
      Width = 47
      Height = 13
      Caption = 'In project:'
    end
    object lblProject: TLabel
      Left = 75
      Top = 10
      Width = 309
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblRelative: TLabel
      Left = 75
      Top = 76
      Width = 309
      Height = 13
      AutoSize = False
    end
    object lblAbsolute: TLabel
      Left = 75
      Top = 54
      Width = 309
      Height = 13
      AutoSize = False
    end
    object Label1: TLabel
      Left = 7
      Top = 32
      Width = 45
      Height = 13
      Caption = 'Filename:'
    end
    object Label9: TLabel
      Left = 7
      Top = 54
      Width = 44
      Height = 13
      Caption = 'Absolute:'
    end
    object Label10: TLabel
      Left = 7
      Top = 76
      Width = 42
      Height = 13
      Caption = 'Relative:'
    end
    object cmbFiles: TComboBox
      Left = 75
      Top = 28
      Width = 309
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnClick = cmbFilesClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 9
    Top = 112
    Width = 393
    Height = 105
    TabOrder = 2
    object Label3: TLabel
      Left = 7
      Top = 13
      Width = 78
      Height = 13
      Caption = 'Total lines in file:'
    end
    object Label4: TLabel
      Left = 7
      Top = 35
      Width = 96
      Height = 13
      Caption = 'Actual lines of code:'
    end
    object Label5: TLabel
      Left = 7
      Top = 57
      Width = 71
      Height = 13
      Caption = 'Comment lines:'
    end
    object Label11: TLabel
      Left = 7
      Top = 79
      Width = 54
      Height = 13
      Caption = 'Timestamp:'
    end
    object Label8: TLabel
      Left = 206
      Top = 57
      Width = 65
      Height = 13
      Caption = 'Included files:'
    end
    object Label6: TLabel
      Left = 206
      Top = 35
      Width = 40
      Height = 13
      Caption = 'File size:'
    end
    object Label7: TLabel
      Left = 206
      Top = 13
      Width = 56
      Height = 13
      Caption = 'Empty lines:'
    end
    object lblTotal: TLabel
      Left = 105
      Top = 13
      Width = 90
      Height = 13
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCode: TLabel
      Left = 105
      Top = 35
      Width = 90
      Height = 13
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblComments: TLabel
      Left = 105
      Top = 57
      Width = 90
      Height = 13
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTimestamp: TLabel
      Left = 111
      Top = 79
      Width = 272
      Height = 13
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblIncludes: TLabel
      Left = 273
      Top = 57
      Width = 110
      Height = 13
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSize: TLabel
      Left = 273
      Top = 35
      Width = 110
      Height = 13
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblEmpty: TLabel
      Left = 273
      Top = 13
      Width = 110
      Height = 13
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
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
    Active = False
    Left = 10
    Top = 224
  end
end
