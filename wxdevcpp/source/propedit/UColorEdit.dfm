object ColorEdit: TColorEdit
  Left = 456
  Top = 184
  BorderStyle = bsDialog
  Caption = 'Color Editor'
  ClientHeight = 169
  ClientWidth = 474
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 128
    Top = 116
    Width = 10
    Height = 13
    Caption = 'R'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 183
    Top = 116
    Width = 10
    Height = 13
    Caption = 'G'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 232
    Top = 116
    Width = 9
    Height = 13
    Caption = 'B'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 381
    Top = 8
    Width = 65
    Height = 13
    Caption = 'Color Preview'
  end
  object btnOK: TBitBtn
    Left = 306
    Top = 142
    Width = 78
    Height = 23
    Caption = 'OK'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnOKClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object btnCancel: TBitBtn
    Left = 388
    Top = 142
    Width = 78
    Height = 23
    TabOrder = 1
    Kind = bkCancel
  end
  object rbDefaultColor: TRadioButton
    Left = 8
    Top = 16
    Width = 111
    Height = 17
    Caption = 'Use Default Color'
    Checked = True
    TabOrder = 2
    TabStop = True
    OnClick = rbDefaultColorClick
  end
  object rbStandardColor: TRadioButton
    Left = 8
    Top = 48
    Width = 111
    Height = 17
    Caption = 'Use Standard Color'
    TabOrder = 3
    OnClick = rbStandardColorClick
  end
  object rbSystemColor: TRadioButton
    Left = 8
    Top = 80
    Width = 111
    Height = 17
    Caption = 'Use System Color'
    TabOrder = 4
    OnClick = rbSystemColorClick
  end
  object rbCustomColor: TRadioButton
    Left = 8
    Top = 112
    Width = 111
    Height = 17
    Caption = 'Use Custom Color'
    TabOrder = 5
    OnClick = rbCustomColorClick
  end
  object txtRed: TEdit
    Left = 141
    Top = 112
    Width = 32
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
    Text = '000'
    OnChange = txtRedChange
  end
  object txtGreen: TEdit
    Left = 195
    Top = 112
    Width = 32
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
    Text = '000'
    OnChange = txtRedChange
  end
  object txtBlue: TEdit
    Left = 245
    Top = 112
    Width = 32
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
    Text = '000'
    OnChange = txtRedChange
  end
  object btChoose: TButton
    Left = 288
    Top = 112
    Width = 68
    Height = 21
    Caption = 'Choose'
    Enabled = False
    TabOrder = 9
    OnClick = btChooseClick
  end
  object cbSystemColor: TComboBox
    Left = 128
    Top = 80
    Width = 230
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 10
    Text = 'wxSYS_COLOUR_SCROLLBAR  '
    OnChange = cbSystemColorChange
    Items.Strings = (
      'wxSYS_COLOUR_SCROLLBAR  '
      'wxSYS_COLOUR_BACKGROUND '
      'wxSYS_COLOUR_ACTIVECAPTION  '
      'wxSYS_COLOUR_INACTIVECAPTION'
      'wxSYS_COLOUR_MENU'
      'wxSYS_COLOUR_WINDOW'
      'wxSYS_COLOUR_WINDOWFRAME'
      'wxSYS_COLOUR_MENUTEXT'
      'wxSYS_COLOUR_WINDOWTEXT'
      'wxSYS_COLOUR_CAPTIONTEXT'
      'wxSYS_COLOUR_ACTIVEBORDER'
      'wxSYS_COLOUR_INACTIVEBORDER'
      'wxSYS_COLOUR_APPWORKSPACE'
      'wxSYS_COLOUR_HIGHLIGHT'
      'wxSYS_COLOUR_HIGHLIGHTTEXT'
      'wxSYS_COLOUR_BTNFACE'
      'wxSYS_COLOUR_BTNSHADOW'
      'wxSYS_COLOUR_GRAYTEXT'
      'wxSYS_COLOUR_BTNTEXT'
      'wxSYS_COLOUR_INACTIVECAPTIONTEXT'
      'wxSYS_COLOUR_BTNHIGHLIGHT'
      'wxSYS_COLOUR_3DDKSHADOW'
      'wxSYS_COLOUR_3DLIGHT'
      'wxSYS_COLOUR_INFOTEXT'
      'wxSYS_COLOUR_INFOBK'
      'wxSYS_COLOUR_DESKTOP'
      'wxSYS_COLOUR_3DFACE'
      'wxSYS_COLOUR_3DSHADOW'
      'wxSYS_COLOUR_3DHIGHLIGHT'
      'wxSYS_COLOUR_3DHILIGHT'
      'wxSYS_COLOUR_BTNHILIGHT')
  end
  object cbStandardColor: TComboBox
    Left = 128
    Top = 48
    Width = 230
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 11
    Text = 'wxBLACK'
    OnChange = cbStandardColorChange
    Items.Strings = (
      'wxBLACK'
      'wxWHITE'
      'wxRED'
      'wxBLUE'
      'wxGREEN'
      'wxCYAN'
      'wxLIGHT_GREY')
  end
  object pnlPreview: TPanel
    Left = 368
    Top = 24
    Width = 97
    Height = 113
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 12
  end
  object colorDlg: TColorDialog
    Ctl3D = True
    Color = clFuchsia
    CustomColors.Strings = (
      'ColorA=FF00FF'
      'ColorB=FFFFFFFF'
      'ColorC=FFFFFFFF'
      'ColorD=FFFFFFFF'
      'ColorE=FFFFFFFF'
      'ColorF=FFFFFFFF'
      'ColorG=FFFFFFFF'
      'ColorH=FFFFFFFF'
      'ColorI=FFFFFFFF'
      'ColorJ=FFFFFFFF'
      'ColorK=FFFFFFFF'
      'ColorL=FFFFFFFF'
      'ColorM=FFFFFFFF'
      'ColorN=FFFFFFFF'
      'ColorO=FFFFFFFF'
      'ColorP=FFFFFFFF')
    Left = 8
    Top = 140
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
    Left = 45
    Top = 140
  end
end
