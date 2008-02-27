object NewTemplateForm: TNewTemplateForm
  Left = 398
  Top = 182
  BorderStyle = bsDialog
  Caption = 'New Template'
  ClientHeight = 321
  ClientWidth = 380
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
  object devPages1: TPageControl
    Left = 8
    Top = 8
    Width = 364
    Height = 281
    ActivePage = pgTemplate
    TabOrder = 0
    object pgTemplate: TTabSheet
      Caption = 'Template info'
      object lblName: TLabel
        Left = 8
        Top = 12
        Width = 31
        Height = 13
        Caption = 'Name:'
      end
      object lblDescr: TLabel
        Left = 8
        Top = 40
        Width = 56
        Height = 13
        Caption = 'Description:'
      end
      object lblCateg: TLabel
        Left = 8
        Top = 68
        Width = 45
        Height = 13
        Caption = 'Category:'
      end
      object lblProjName: TLabel
        Left = 8
        Top = 96
        Width = 89
        Height = 13
        Caption = 'New project name:'
      end
      object txtDescr: TEdit
        Left = 112
        Top = 36
        Width = 235
        Height = 21
        TabOrder = 1
        Text = 'txtDescr'
      end
      object cmbCateg: TComboBox
        Left = 112
        Top = 64
        Width = 235
        Height = 21
        AutoDropDown = True
        ItemHeight = 13
        Sorted = True
        TabOrder = 2
        Text = 'cmbCateg'
        OnChange = cmbNameChange
      end
      object txtProjName: TEdit
        Left = 112
        Top = 92
        Width = 235
        Height = 21
        TabOrder = 3
        Text = 'txtProjName'
      end
      object lblIcons: TGroupBox
        Left = 8
        Top = 128
        Width = 340
        Height = 118
        Caption = 'Icons'
        TabOrder = 4
        object lstIcons: TListBox
          Left = 12
          Top = 20
          Width = 181
          Height = 85
          Style = lbOwnerDrawFixed
          ExtendedSelect = False
          ItemHeight = 36
          TabOrder = 0
          OnClick = lstIconsClick
          OnDrawItem = lstIconsDrawItem
        end
        object btnLib: TBitBtn
          Left = 205
          Top = 20
          Width = 113
          Height = 24
          Hint = 'Select a icon from Dev-C++'#39's icon collection'
          Caption = 'Library'
          TabOrder = 1
          OnClick = btnLibClick
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000CFD0D1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1
            B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1000000000000F0F1F1
            D9D9D9CECECED0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0CFCFCFCFCF
            CFCFCFCFB1B1B1000000000000F0F1F1E0E0E0D9D9D9D1D1D1D0D0D0D0D0D0D0
            D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0B1B1B1000000000000F0F1F1
            E1E1E16565654B4B4BCECECECECECE6565654B4B4BD0D0D0D0D0D06565654B4B
            4BD0D0D0B1B1B1000000000000F0F1F1E1E1E1888888656565D9D9D9CECECE88
            8888656565D0D0D0D0D0D0888888656565D0D0D0B1B1B1000000000000F0F1F1
            DFDFDFDFDFDFDEDEDEE0E0E0D9D9D9D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0
            D0D0D0D0B1B1B1000000000000F0F1F1DFDFDFDFDFDFDEDEDEDFDFDFE0E0E0D9
            D9D9D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0B1B1B1000000000000F0F1F1
            DFDFDFDFDFDFDFDFDFE0E0E0E0E0E0E0E0E0D9D9D9CECECECECECED0D0D0D0D0
            D0D0D0D0B1B1B1000000000000F0F1F1DFDFDF6565654B4B4BE0E0E0E0E0E065
            65654B4B4BD9D9D9D0D0D06565654B4B4BD0D0D0B1B1B1000000000000F0F1F1
            DFDFDF888888656565DFDFDFDFDFDF888888656565DFE0E0D9D9D98888886565
            65CFCFCFB1B1B1000000000000F0F1F1DFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDF
            DFDFDFDFDFE0E0E0E0E0E0D9D9D9D0D0D0D0D0D0B1B1B1000000000000F0F1F1
            DFE0E0DFE0E0DFE0E0DFE0E0DFE0E0DFE0E0DFE0E0DFE0E0DFE0E0DFE0E0D9D9
            D9D0D0D0B1B1B100000000000068686800000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000E8BC9D
            E3AD87E3AD87E3AD87DB9565DB9565DB9565DB9565DB9565DB9565DB9565DB95
            65DB9565D0753600000068686800000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
        end
        object btnBrowse: TBitBtn
          Left = 205
          Top = 52
          Width = 113
          Height = 22
          Hint = 'Select a custom icon'
          Caption = 'Browse...'
          TabOrder = 2
          OnClick = btnBrowseClick
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
        end
        object btnRemove: TBitBtn
          Left = 205
          Top = 83
          Width = 113
          Height = 22
          Hint = 'Do not use an icon for this project'
          Caption = 'Remove'
          Enabled = False
          TabOrder = 3
          OnClick = btnRemoveClick
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000BFBFBFBFBFBF
            BFBFBF000000000000000000000000000000000000000000000000000000BFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000073C88A72C48870BC846FB5826C
            AE7D6AA57A689E75679975679975000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            00000073C88A72C38871BC846FB4816CAC7D6AA579689E756799756799750000
            00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000073C88A72C3876FBD846EB5806D
            AD7C6AA579689E76679975679975000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            00000073C88A72C48871BD856EB4826DAC7C6AA57A689E756799756799750000
            00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000073C88A72C4886FBD846FB4816D
            AC7C6AA57A689E75679975679975000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            00000073C88A72C48871BD856FB4826CAC7D6AA57A689E756799756799750000
            00BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000073C88A72C38871BD836FB4816C
            AC7D6AA579689E76679975679975000000BFBFBFBFBFBFBFBFBFBFBFBF000000
            10381B10381B10381B10381B10381B10381B10381B10381B10381B10381B1038
            1B000000BFBFBFBFBFBFBFBFBF0000007CD79479CA8F73BE8773BE8773BE8773
            BE876AA57A6AA57A679975679975679975000000BFBFBFBFBFBFBFBFBF000000
            7CD7947CD79479CA8F73BE8773BE8773BE8773BE876AA57A6AA57A6799756799
            75000000BFBFBFBFBFBFBFBFBFBFBFBF0000007CD7947CD7947CD79479CA8F73
            BE8773BE8773BE876AA57A6AA57A000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBF6868680000007CD7947CD79479CA8F79CA8F79CA8F000000000000BFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000000000000
            0000000000000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBF000000BFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF68686800
            0000686868BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF}
        end
      end
      object cmbName: TComboBox
        Left = 112
        Top = 8
        Width = 235
        Height = 21
        AutoDropDown = True
        ItemHeight = 13
        Sorted = True
        TabOrder = 0
        Text = 'cmbName'
        OnChange = cmbNameChange
      end
    end
    object pgFiles: TTabSheet
      Caption = 'Files'
      object lblFiles: TLabel
        Left = 8
        Top = 8
        Width = 78
        Height = 13
        Caption = 'Files in template:'
      end
      object lstFiles: TCheckListBox
        Left = 16
        Top = 24
        Width = 321
        Height = 213
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object pgExtras: TTabSheet
      Caption = 'Extras'
      object lblCompiler: TLabel
        Left = 8
        Top = 8
        Width = 106
        Height = 13
        Caption = 'Compiler extra options:'
      end
      object lblLinker: TLabel
        Left = 244
        Top = 8
        Width = 95
        Height = 13
        Caption = 'Linker extra options:'
      end
      object lblCppCompiler: TLabel
        Left = 128
        Top = 8
        Width = 101
        Height = 13
        Caption = 'C++ compiler options:'
      end
      object memCompiler: TMemo
        Left = 12
        Top = 24
        Width = 101
        Height = 149
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object memLinker: TMemo
        Left = 244
        Top = 25
        Width = 101
        Height = 148
        ScrollBars = ssVertical
        TabOrder = 2
      end
      object memCppCompiler: TMemo
        Left = 128
        Top = 24
        Width = 101
        Height = 149
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object cbInclude: TCheckBox
        Left = 16
        Top = 192
        Width = 329
        Height = 17
        Caption = 'Use project'#39's Include directories'
        TabOrder = 3
      end
      object cbLibrary: TCheckBox
        Left = 16
        Top = 208
        Width = 329
        Height = 17
        Caption = 'Use project'#39's Library directories'
        TabOrder = 4
      end
      object cbRessource: TCheckBox
        Left = 16
        Top = 224
        Width = 329
        Height = 17
        Caption = 'Use project'#39's Ressource directories'
        TabOrder = 5
      end
    end
  end
  object btnCreate: TButton
    Left = 217
    Top = 293
    Width = 75
    Height = 23
    Caption = 'Create'
    Default = True
    TabOrder = 1
    OnClick = btnCreateClick
  end
  object btnCancel: TButton
    Left = 297
    Top = 293
    Width = 75
    Height = 23
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object dlgPic: TOpenPictureDialog
    DefaultExt = 'ico'
    Filter = 'Icons (*.ico)|*.ico'
    Title = 'Open icon'
    Left = 48
    Top = 296
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
    Left = 8
    Top = 296
  end
end
