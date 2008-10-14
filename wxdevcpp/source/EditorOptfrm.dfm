object EditorOptForm: TEditorOptForm
  Left = 390
  Top = 192
  HelpType = htKeyword
  BorderStyle = bsDialog
  Caption = 'Editor Options'
  ClientHeight = 416
  ClientWidth = 429
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHelp = FormHelp
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    429
    416)
  PixelsPerInch = 96
  TextHeight = 13
  object PagesMain: TPageControl
    Left = 7
    Top = 8
    Width = 415
    Height = 373
    ActivePage = tabClassBrowsing
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabIndex = 4
    TabOrder = 0
    OnChange = PagesMainChange
    object tabGeneral: TTabSheet
      Caption = 'General'
      object grpMargin: TGroupBox
        Left = 248
        Top = 216
        Width = 155
        Height = 84
        Caption = 'Right Margin'
        TabOrder = 0
        object lblMarginWidth: TLabel
          Left = 8
          Top = 35
          Width = 28
          Height = 13
          Caption = 'Width'
        end
        object lblMarginColor: TLabel
          Left = 83
          Top = 35
          Width = 24
          Height = 13
          Caption = 'Color'
        end
        object cpMarginColor: TColorPickerButton
          Left = 83
          Top = 50
          Width = 61
          Height = 22
          DefaultText = 'default'
          PopupSpacing = 8
          ShowSystemColors = False
          OnDefaultSelect = cpMarginColorDefaultSelect
          OnHint = cpMarginColorHint
        end
        object cbMarginVis: TCheckBox
          Left = 8
          Top = 16
          Width = 75
          Height = 17
          Caption = 'Visible'
          TabOrder = 0
        end
        object edMarginWidth: TSpinEdit
          Left = 8
          Top = 51
          Width = 60
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
        end
      end
      object grpCaret: TGroupBox
        Left = 4
        Top = 216
        Width = 235
        Height = 84
        Caption = 'Caret'
        TabOrder = 1
        object lblInsertCaret: TLabel
          Left = 8
          Top = 16
          Width = 56
          Height = 13
          Caption = 'Insert caret:'
        end
        object lblOverCaret: TLabel
          Left = 8
          Top = 41
          Width = 75
          Height = 13
          Caption = 'Overwrite caret:'
        end
        object cboInsertCaret: TComboBox
          Left = 120
          Top = 12
          Width = 100
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnDblClick = cboDblClick
          Items.Strings = (
            'Vertical Line'
            'Horizontal Line'
            'Half Block'
            'Block')
        end
        object cboOverwriteCaret: TComboBox
          Left = 120
          Top = 37
          Width = 100
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          OnDblClick = cboDblClick
          Items.Strings = (
            'Vertical Line'
            'Horizontal Line'
            'Half Block'
            'Block')
        end
        object cbMatch: TCheckBox
          Left = 8
          Top = 60
          Width = 217
          Height = 17
          Caption = 'Highlight matching parenthesis/braces'
          TabOrder = 2
        end
      end
      object lblEditorOpts: TGroupBox
        Left = 4
        Top = 4
        Width = 399
        Height = 210
        Caption = 'Editor Options'
        TabOrder = 2
        object cpHighColor: TColorPickerButton
          Left = 199
          Top = 185
          Width = 61
          Height = 22
          DefaultText = 'default'
          PopupSpacing = 8
          ShowSystemColors = False
          OnDefaultSelect = cpMarginColorDefaultSelect
          OnHint = cpMarginColorHint
        end
        object cbAppendNewline: TCheckBox
          Left = 8
          Top = 168
          Width = 380
          Height = 17
          Caption = 'Ensure that file ends with newline'
          TabOrder = 0
        end
        object cbSpecialChars: TCheckBox
          Left = 8
          Top = 151
          Width = 190
          Height = 17
          Caption = 'Show Special Line Chars'
          TabOrder = 1
        end
        object cbDropFiles: TCheckBox
          Left = 8
          Top = 134
          Width = 190
          Height = 17
          Caption = 'Insert Dropped Files'
          TabOrder = 2
        end
        object cbGroupUndo: TCheckBox
          Left = 8
          Top = 117
          Width = 190
          Height = 17
          Hint = 'handle all changes of same type as single action'
          Caption = 'Group Undo'
          TabOrder = 3
        end
        object cbSmartUnIndent: TCheckBox
          Left = 8
          Top = 100
          Width = 190
          Height = 17
          Hint = 'cursor is moved to nonblank space of previous line '
          Caption = 'Backspace Unindents'
          TabOrder = 4
        end
        object cbTrailingBlanks: TCheckBox
          Left = 8
          Top = 83
          Width = 190
          Height = 17
          Hint = 'Blanks at end of lines will be saved with file'
          Caption = 'Keep Trailing Blanks'
          TabOrder = 5
        end
        object cbTabtoSpaces: TCheckBox
          Left = 8
          Top = 49
          Width = 190
          Height = 17
          Caption = 'Use Tab Character'
          TabOrder = 6
        end
        object cbSmartTabs: TCheckBox
          Left = 8
          Top = 66
          Width = 190
          Height = 17
          Hint = 
            'on tab cursor is moved to first nonblank space of preceeding lin' +
            'e'
          Caption = 'Smart Tabs'
          TabOrder = 7
        end
        object cbInsertMode: TCheckBox
          Left = 8
          Top = 32
          Width = 190
          Height = 17
          Hint = 'editor is in insert mode on start'
          Caption = 'Insert Mode'
          TabOrder = 8
        end
        object cbAutoIndent: TCheckBox
          Left = 8
          Top = 16
          Width = 190
          Height = 17
          Hint = 'caret will position to first non-whitespace of preceeding line'
          Caption = 'Auto Indent'
          TabOrder = 9
        end
        object cbPastEOL: TCheckBox
          Left = 199
          Top = 50
          Width = 190
          Height = 17
          Hint = 'allows cursor position past end of line'
          Caption = 'Cursor Past EOL'
          TabOrder = 10
        end
        object cbFindText: TCheckBox
          Left = 199
          Top = 84
          Width = 190
          Height = 17
          Hint = 'inserts text at cursor into text to find of search dialog'
          Caption = 'Find Text at Cursor'
          TabOrder = 11
        end
        object cbHalfPage: TCheckBox
          Left = 199
          Top = 117
          Width = 190
          Height = 17
          Hint = 'page up/down will move text by half a page instead of full page'
          Caption = 'Half Page Scrolling'
          TabOrder = 12
        end
        object cbScrollHint: TCheckBox
          Left = 199
          Top = 134
          Width = 190
          Height = 17
          Hint = 'shows current line when scrolling'
          Caption = 'Scroll Hint'
          TabOrder = 13
        end
        object cbParserHints: TCheckBox
          Left = 199
          Top = 151
          Width = 190
          Height = 17
          Caption = 'Show editor hints'
          TabOrder = 14
        end
        object cbSmartScroll: TCheckBox
          Left = 199
          Top = 100
          Width = 190
          Height = 17
          Hint = 'show scrollbars only when content is available'
          Caption = 'Scollbars on need'
          TabOrder = 15
        end
        object cbDoubleLine: TCheckBox
          Left = 199
          Top = 67
          Width = 190
          Height = 17
          Hint = 'double clicking a line selects it'
          Caption = 'Double Click Line'
          TabOrder = 16
        end
        object cbEHomeKey: TCheckBox
          Left = 199
          Top = 17
          Width = 190
          Height = 17
          Hint = 'enhances home key positioning, similar to visual studio'
          Caption = 'Enhanced home key'
          TabOrder = 17
        end
        object cbPastEOF: TCheckBox
          Left = 199
          Top = 33
          Width = 190
          Height = 17
          Hint = 'allow cursor position past end of file'
          Caption = 'Cursor Past EOF'
          TabOrder = 18
        end
        object cbHighCurrLine: TCheckBox
          Left = 8
          Top = 185
          Width = 190
          Height = 17
          Caption = 'Highlight current line'
          TabOrder = 19
          OnClick = cbHighCurrLineClick
        end
      end
    end
    object tabDisplay: TTabSheet
      Caption = 'Display'
      object grpGutter: TGroupBox
        Left = 4
        Top = 115
        Width = 399
        Height = 180
        Caption = 'Gutter'
        TabOrder = 1
        DesignSize = (
          399
          180)
        object lblGutterFont: TLabel
          Left = 8
          Top = 86
          Width = 24
          Height = 13
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'Font:'
        end
        object lblGutterWidth: TLabel
          Left = 321
          Top = 86
          Width = 28
          Height = 13
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'Width'
          WordWrap = True
        end
        object lblGutterFontSize: TLabel
          Left = 200
          Top = 86
          Width = 23
          Height = 13
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'Size:'
        end
        object cbLeadZero: TCheckBox
          Left = 199
          Top = 48
          Width = 190
          Height = 15
          Caption = 'Show Leading Zeros'
          TabOrder = 5
        end
        object cbFirstZero: TCheckBox
          Left = 199
          Top = 32
          Width = 190
          Height = 15
          Caption = 'Start at Zero'
          TabOrder = 4
        end
        object cbLineNum: TCheckBox
          Left = 199
          Top = 16
          Width = 190
          Height = 15
          Caption = 'Show Line Numbers'
          TabOrder = 3
          OnClick = cbLineNumClick
        end
        object cbGutterVis: TCheckBox
          Left = 8
          Top = 16
          Width = 190
          Height = 15
          Caption = 'Visible'
          TabOrder = 0
        end
        object cbGutterAuto: TCheckBox
          Left = 8
          Top = 32
          Width = 190
          Height = 15
          Caption = 'Auto Size'
          TabOrder = 1
        end
        object cbGutterFnt: TCheckBox
          Left = 8
          Top = 48
          Width = 190
          Height = 15
          Caption = 'Use Custom Font'
          TabOrder = 2
          OnClick = cbGutterFntClick
        end
        object pnlGutterPreview: TPanel
          Left = 12
          Top = 129
          Width = 374
          Height = 40
          Anchors = [akLeft, akRight, akBottom]
          BevelOuter = bvLowered
          Caption = 'Gutter Font'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object cboGutterFont: TComboBox
          Left = 12
          Top = 102
          Width = 181
          Height = 21
          Anchors = [akLeft, akRight, akBottom]
          ItemHeight = 0
          TabOrder = 6
          OnChange = FontChange
          OnDblClick = cboDblClick
        end
        object cboGutterSize: TComboBox
          Left = 208
          Top = 102
          Width = 87
          Height = 21
          Anchors = [akLeft, akRight, akBottom]
          ItemHeight = 0
          TabOrder = 7
          OnChange = FontSizeChange
          OnDblClick = cboDblClick
        end
        object edGutterWidth: TSpinEdit
          Left = 328
          Top = 102
          Width = 57
          Height = 22
          Anchors = [akLeft, akRight, akBottom]
          MaxValue = 0
          MinValue = 0
          TabOrder = 9
          Value = 0
          OnChange = FontSizeChange
        end
        object cbGutterGradient: TCheckBox
          Left = 8
          Top = 64
          Width = 190
          Height = 15
          Caption = 'Draw with Gradient'
          TabOrder = 10
        end
      end
      object grpEditorFont: TGroupBox
        Left = 4
        Top = 4
        Width = 399
        Height = 109
        Caption = 'Editor Font'
        TabOrder = 0
        DesignSize = (
          399
          109)
        object lblEditorSize: TLabel
          Left = 200
          Top = 16
          Width = 23
          Height = 13
          Caption = 'Size:'
        end
        object lblEditorFont: TLabel
          Left = 8
          Top = 16
          Width = 24
          Height = 13
          Caption = 'Font:'
        end
        object lblTabSize: TLabel
          Left = 321
          Top = 16
          Width = 45
          Height = 13
          Caption = 'Tab Size:'
        end
        object cboEditorFont: TComboBox
          Left = 12
          Top = 32
          Width = 180
          Height = 21
          ItemHeight = 0
          TabOrder = 0
          OnDblClick = cboDblClick
          OnSelect = FontChange
        end
        object cboEditorSize: TComboBox
          Left = 208
          Top = 32
          Width = 80
          Height = 21
          ItemHeight = 0
          TabOrder = 1
          OnChange = FontSizeChange
          OnDblClick = cboDblClick
        end
        object pnlEditorPreview: TPanel
          Left = 12
          Top = 60
          Width = 374
          Height = 40
          Anchors = [akLeft, akRight, akBottom]
          BevelOuter = bvLowered
          Caption = 'Editor Font'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object seTabSize: TSpinEdit
          Left = 328
          Top = 31
          Width = 57
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnChange = seTabSizeChange
        end
      end
    end
    object tabSyntax: TTabSheet
      Caption = 'Syntax Highlighting'
      object lblElements: TLabel
        Left = 5
        Top = 26
        Width = 27
        Height = 13
        Caption = 'Type:'
      end
      object lblSpeed: TLabel
        Left = 151
        Top = 54
        Width = 89
        Height = 13
        Caption = 'Highlighting Styles:'
      end
      object btnSaveSyntax: TSpeedButton
        Left = 379
        Top = 50
        Width = 21
        Height = 21
        Hint = 'Save custom syntax settings'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000CE0E0000D80E0000000000000000000000FF0000FF00
          00FF0000FF0000FF0000000000000000000000000000FF0000FF0000FF0000FF
          0000FF0000FF0000FF0000FF0000FF0000FF0000FF00000000666148A89F77DD
          DDDD9B9A8F00000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF00
          00FF0000FF00000000A89F77A89F77E9E9E9B2B0A7D5D4D29392894848480000
          0000FF0000FF0000FF0000FF0000FF0000FF00000000B9B294A89F77756E534A
          473AACA47EDADAD5E0E0E0B4B4B476736500000000FF0000FF0000FF0000FF00
          00FF00000000A89F77A89F77756E53F3F3F3F1F1F1E7E7E7E1E1E1B4B2A96661
          48635E464A463400000000FF0000FF00000000B2AA87F0EFE8EBE9E0A89F7763
          5E46ADABA4EAEAEAE4E4E4646360A89F77A89F7700000000000000FF0000FF00
          000000EBE9E0FFFFFFFFFFFFF5F4F0A89F77A89F77635E465A574B787255A89F
          77A89F7700000000FF0000FF00000000B2AA87F2F1EBFFFFFFFFFFFFFFFFFFF5
          F4F0EBE9E0A89F77A89F77756E53756E5300000000000000FF0000FF00000000
          EBE9E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F6F2EBE9E0A89F77A89F
          7700000000FF0000FF000000008D8A78F2F1EBFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFF0EFE800000000000000FF0000FF00000000B9B294
          DFDCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEECE40000
          0000FF0000FF0000FF0000FF00000000000000C9C4AED5D1BFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFF9F8F500000000000000FF0000FF0000FF0000FF0000FF00
          00FF00000000000000C9C4AED5D1BFD5D1BFFFFFFFF4F3EEA89F7700000000FF
          0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00000000000000D5
          D1BFC5C1A8EDECE400000000000000FF0000FF0000FF0000FF0000FF0000FF00
          00FF0000FF0000FF0000FF0000FF00000000000000A89F7700000000FF0000FF
          0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
          FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF00}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnSaveSyntaxClick
      end
      object lblSyntaxExt: TLabel
        Left = 151
        Top = 28
        Width = 111
        Height = 13
        Caption = 'Enabled file extensions:'
      end
      object cbSyntaxHighlight: TCheckBox
        Left = 5
        Top = 5
        Width = 395
        Height = 17
        Caption = 'Use Syntax Highlighting'
        TabOrder = 3
        OnClick = cbSyntaxHighlightClick
      end
      object CppEdit: TSynEdit
        Left = 4
        Top = 195
        Width = 399
        Height = 145
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        TabOrder = 2
        BorderStyle = bsNone
        Gutter.DigitCount = 2
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Terminal'
        Gutter.Font.Style = []
        Gutter.LeadingZeros = True
        Gutter.LeftOffset = 6
        Gutter.ShowLineNumbers = True
        HideSelection = True
        Highlighter = dmMain.CppMultiSyn
        Options = [eoAutoIndent, eoDisableScrollArrows, eoDragDropEditing, eoHideShowScrollbars, eoNoCaret, eoNoSelection, eoScrollPastEol, eoShowScrollHint, eoSmartTabs, eoTrimTrailingSpaces]
        ReadOnly = True
        ScrollHintFormat = shfTopToBottom
        WantTabs = True
        OnGutterClick = OnGutterClick
        OnSpecialLineColors = CppEditSpecialLineColors
        OnStatusChange = cppEditStatusChange
        RemovedKeystrokes = <
          item
            Command = ecDeleteLastChar
            ShortCut = 8200
          end
          item
            Command = ecLineBreak
            ShortCut = 8205
          end
          item
            Command = ecContextHelp
            ShortCut = 112
          end>
        AddedKeystrokes = <>
      end
      object ElementList: TListBox
        Left = 5
        Top = 42
        Width = 138
        Height = 145
        ItemHeight = 13
        Items.Strings = (
          'Comment'
          'Identifier'
          'Keyword'
          'Number'
          'Background'
          'String'
          'Symbol'
          'WhiteSpace'
          'Directives')
        TabOrder = 0
        OnClick = ElementListClick
      end
      object cboQuickColor: TComboBox
        Left = 281
        Top = 50
        Width = 98
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnSelect = cboQuickColorSelect
        Items.Strings = (
          'Classic'
          'Twilight'
          'Ocean'
          'Visual Studio'
          'Borland'
          'Matrix')
      end
      object grpStyle: TGroupBox
        Left = 150
        Top = 73
        Width = 250
        Height = 114
        Caption = 'Styles'
        TabOrder = 4
        object lblForeground: TLabel
          Left = 8
          Top = 71
          Width = 84
          Height = 13
          Caption = 'Foreground Color:'
        end
        object cpForeground: TColorPickerButton
          Left = 130
          Top = 69
          Width = 110
          Height = 20
          CustomText = 'Custom'
          DefaultText = 'Default'
          PopupSpacing = 8
          ShowSystemColors = True
          OnChange = StyleChange
          OnDefaultSelect = DefaultSelect
          OnHint = PickerHint
        end
        object lblBackground: TLabel
          Left = 8
          Top = 90
          Width = 88
          Height = 13
          Caption = 'Background Color:'
        end
        object cpBackground: TColorPickerButton
          Left = 130
          Top = 88
          Width = 110
          Height = 20
          CustomText = 'Custom'
          DefaultText = 'Default'
          PopupSpacing = 8
          ShowSystemColors = True
          OnChange = StyleChange
          OnDefaultSelect = DefaultSelect
          OnHint = PickerHint
        end
        object cbBold: TCheckBox
          Left = 8
          Top = 16
          Width = 230
          Height = 17
          Caption = 'Bold'
          TabOrder = 0
          OnClick = StyleChange
        end
        object cbItalic: TCheckBox
          Left = 8
          Top = 33
          Width = 230
          Height = 17
          Caption = 'Italic'
          TabOrder = 1
          OnClick = StyleChange
        end
        object cbUnderlined: TCheckBox
          Left = 8
          Top = 51
          Width = 230
          Height = 17
          Caption = 'Underlined'
          TabOrder = 2
          OnClick = StyleChange
        end
      end
      object edSyntaxExt: TEdit
        Left = 281
        Top = 26
        Width = 120
        Height = 21
        TabOrder = 5
      end
    end
    object tabCode: TTabSheet
      Caption = 'Code'
      object codepages: TPageControl
        Left = 5
        Top = 5
        Width = 396
        Height = 335
        ActivePage = tabCPInserts
        TabIndex = 0
        TabOrder = 0
        object tabCPInserts: TTabSheet
          Caption = 'Inserts'
          DesignSize = (
            388
            307)
          object lblCode: TLabel
            Left = 10
            Top = 105
            Width = 28
            Height = 13
            Anchors = [akLeft, akTop, akRight, akBottom]
            Caption = 'Code:'
          end
          object btnAdd: TButton
            Left = 309
            Top = 10
            Width = 70
            Height = 23
            Caption = 'Add'
            TabOrder = 1
            OnClick = btnAddClick
          end
          object btnEdit: TButton
            Left = 309
            Top = 35
            Width = 70
            Height = 23
            Caption = 'Edit'
            TabOrder = 2
            OnClick = btnEditClick
          end
          object btnRemove: TButton
            Left = 309
            Top = 60
            Width = 70
            Height = 23
            Caption = 'Remove'
            TabOrder = 3
            OnClick = btnRemoveClick
          end
          object lvCodeins: TListView
            Left = 10
            Top = 10
            Width = 290
            Height = 91
            Columns = <
              item
                Caption = 'Menu text'
                Width = 100
              end
              item
                Caption = 'Section'
              end
              item
                Caption = 'Description'
                Width = -2
                WidthType = (
                  -2)
              end>
            ColumnClick = False
            FlatScrollBars = True
            GridLines = True
            HideSelection = False
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnColumnClick = lvCodeinsColumnClick
            OnCompare = lvCodeinsCompare
            OnSelectItem = lvCodeinsSelectItem
          end
          object CodeIns: TSynEdit
            Left = 10
            Top = 121
            Width = 368
            Height = 175
            Anchors = [akLeft, akTop, akRight, akBottom]
            Ctl3D = True
            ParentCtl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Courier New'
            Font.Style = []
            TabOrder = 4
            BorderStyle = bsNone
            Gutter.Font.Charset = DEFAULT_CHARSET
            Gutter.Font.Color = clWindowText
            Gutter.Font.Height = -11
            Gutter.Font.Name = 'Terminal'
            Gutter.Font.Style = []
            Gutter.Width = 24
            Highlighter = cpp
            Options = [eoAutoIndent, eoDisableScrollArrows, eoDragDropEditing, eoEnhanceHomeKey, eoGroupUndo, eoHideShowScrollbars, eoShowScrollHint, eoSmartTabDelete, eoSmartTabs, eoTabsToSpaces, eoTrimTrailingSpaces]
            ScrollBars = ssNone
            WantTabs = True
            OnStatusChange = CodeInsStatusChange
            RemovedKeystrokes = <
              item
                Command = ecContextHelp
                ShortCut = 112
              end>
            AddedKeystrokes = <
              item
                Command = ecContextHelp
                ShortCut = 16496
              end>
          end
        end
        object tabCPDefault: TTabSheet
          Caption = 'Default Source'
          object seDefault: TSynEdit
            Left = 0
            Top = 0
            Width = 388
            Height = 290
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Courier New'
            Font.Style = []
            TabOrder = 0
            BorderStyle = bsNone
            Gutter.Font.Charset = DEFAULT_CHARSET
            Gutter.Font.Color = clWindowText
            Gutter.Font.Height = -11
            Gutter.Font.Name = 'Terminal'
            Gutter.Font.Style = []
            Gutter.Width = 10
            Highlighter = cpp
            Options = [eoAutoIndent, eoDisableScrollArrows, eoDragDropEditing, eoGroupUndo, eoHideShowScrollbars, eoShowScrollHint, eoSmartTabDelete, eoSmartTabs, eoTabsToSpaces, eoTrimTrailingSpaces]
            RemovedKeystrokes = <
              item
                Command = ecContextHelp
                ShortCut = 112
              end>
            AddedKeystrokes = <
              item
                Command = ecContextHelp
                ShortCut = 16496
              end>
          end
          object cbDefaultintoprj: TCheckBox
            Left = 0
            Top = 289
            Width = 388
            Height = 17
            Caption = 'Insert Default Code into Empty Projects'
            TabOrder = 1
          end
        end
      end
    end
    object tabClassBrowsing: TTabSheet
      Caption = 'Class browsing'
      object chkEnableClassBrowser: TCheckBox
        Left = 5
        Top = 5
        Width = 395
        Height = 17
        Caption = 'Enable class browser'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = chkEnableClassBrowserClick
      end
      object devPages1: TPageControl
        Left = 5
        Top = 28
        Width = 397
        Height = 310
        ActivePage = tabCBBrowser
        TabIndex = 0
        TabOrder = 1
        OnChange = devPages1Change
        object tabCBBrowser: TTabSheet
          Caption = 'Class browsing'
          object lblClassBrowserSample: TLabel
            Left = 8
            Top = 148
            Width = 38
            Height = 13
            Caption = 'Sample:'
          end
          object ClassBrowser1: TClassBrowser
            Left = 60
            Top = 148
            Width = 320
            Height = 125
            Images = dmMain.ClassImages
            ReadOnly = True
            Indent = 19
            TabOrder = 2
            ShowFilter = sfAll
            ItemImages.Globals = -1
            ItemImages.Classes = 1
            ItemImages.VariablePrivate = 2
            ItemImages.VariableProtected = 3
            ItemImages.VariablePublic = 4
            ItemImages.VariablePublished = 4
            ItemImages.MethodPrivate = 5
            ItemImages.MethodProtected = 6
            ItemImages.MethodPublic = 7
            ItemImages.MethodPublished = 7
            ItemImages.InheritedMethodProtected = 0
            ItemImages.InheritedMethodPublic = 0
            ItemImages.InheritedVariableProtected = 0
            ItemImages.InheritedVariablePublic = 0
            UseColors = True
            ShowInheritedMembers = False
          end
          object gbCBEngine: TGroupBox
            Left = 7
            Top = 6
            Width = 374
            Height = 60
            Caption = 'Engine behaviour'
            TabOrder = 0
            object chkCBParseGlobalH: TCheckBox
              Left = 8
              Top = 36
              Width = 360
              Height = 17
              Caption = 'Scan global files referenced in #include'#39's'
              TabOrder = 1
            end
            object chkCBParseLocalH: TCheckBox
              Left = 8
              Top = 16
              Width = 360
              Height = 17
              Caption = 'Scan local files referenced in #include'#39's'
              TabOrder = 0
            end
          end
          object gbCBView: TGroupBox
            Left = 6
            Top = 72
            Width = 374
            Height = 60
            Caption = 'View options'
            TabOrder = 1
            object chkCBUseColors: TCheckBox
              Left = 8
              Top = 16
              Width = 360
              Height = 17
              Caption = 'Use colors'
              TabOrder = 0
              OnClick = chkCBUseColorsClick
            end
            object chkCBShowInherited: TCheckBox
              Left = 8
              Top = 36
              Width = 360
              Height = 17
              Caption = 'Show inherited members'
              TabOrder = 1
              OnClick = chkCBShowInheritedClick
            end
          end
        end
        object tabCBCompletion: TTabSheet
          Caption = 'Code completion'
          object lblCompletionDelay: TLabel
            Left = 24
            Top = 31
            Width = 52
            Height = 13
            Caption = 'Delay (ms):'
          end
          object cpCompletionBackground: TColorPickerButton
            Left = 175
            Top = 54
            Width = 110
            Height = 22
            CustomText = 'Custom'
            DefaultText = 'Default'
            PopupSpacing = 8
            ShowSystemColors = True
            OnDefaultSelect = DefaultSelect
          end
          object lblCompletionColor: TLabel
            Left = 24
            Top = 56
            Width = 121
            Height = 13
            Caption = 'Dialog Background Color:'
          end
          object lblCCCache: TLabel
            Left = 24
            Top = 104
            Width = 68
            Height = 13
            Caption = 'Files in cache:'
          end
          object chkEnableCompletion: TCheckBox
            Left = 8
            Top = 8
            Width = 370
            Height = 17
            Caption = 'Enable code-completion'
            TabOrder = 0
            OnClick = chkEnableCompletionClick
          end
          object chkCCCache: TCheckBox
            Left = 8
            Top = 84
            Width = 370
            Height = 17
            Caption = 'Use code-completion cache'
            TabOrder = 1
            OnClick = chkCCCacheClick
          end
          object lbCCC: TListBox
            Left = 24
            Top = 120
            Width = 260
            Height = 155
            ItemHeight = 13
            Sorted = True
            TabOrder = 2
            OnClick = FontChange
          end
          object pbCCCache: TProgressBar
            Left = 292
            Top = 175
            Width = 89
            Height = 16
            Min = 0
            Max = 100
            TabOrder = 3
            Visible = False
          end
          object btnCCCnew: TButton
            Left = 292
            Top = 120
            Width = 90
            Height = 23
            Caption = 'Add'
            TabOrder = 4
            OnClick = btnCCCnewClick
          end
          object btnCCCdelete: TButton
            Left = 292
            Top = 147
            Width = 90
            Height = 23
            Caption = 'Clear'
            TabOrder = 5
            OnClick = btnCCCdeleteClick
          end
          object edCompletionDelay: TSpinEdit
            Left = 175
            Top = 27
            Width = 110
            Height = 22
            MaxValue = 1500
            MinValue = 0
            TabOrder = 6
            Value = 500
          end
        end
      end
    end
  end
  object btnOk: TBitBtn
    Left = 166
    Top = 387
    Width = 80
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
    OnClick = btnOkClick
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
    Left = 251
    Top = 387
    Width = 80
    Height = 23
    Anchors = [akRight, akBottom]
    TabOrder = 2
    OnClick = btnCancelClick
    Kind = bkCancel
  end
  object btnHelp: TBitBtn
    Left = 346
    Top = 387
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    TabOrder = 3
    OnClick = btnHelpClick
    Kind = bkHelp
  end
  object cpp: TSynCppSyn
    DefaultFilter = 'C++ Files (*.c,*.cpp,*.h,*.hpp)|*.c;*.cpp;*.h;*.hpp'
    Left = 7
    Top = 384
  end
  object CppTokenizer1: TCppTokenizer
    LogTokens = False
    Left = 35
    Top = 384
  end
  object CppParser1: TCppParser
    Enabled = True
    OnTotalProgress = CppParser1TotalProgress
    Tokenizer = CppTokenizer1
    ParseLocalHeaders = True
    ParseGlobalHeaders = True
    LogStatements = False
    OnStartParsing = CppParser1StartParsing
    OnEndParsing = CppParser1EndParsing
    Left = 63
    Top = 384
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
    Left = 91
    Top = 384
  end
end
