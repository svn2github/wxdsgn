object EditorOptForm: TEditorOptForm
  Left = 424
  Top = 244
  HelpType = htKeyword
  BorderStyle = bsDialog
  Caption = 'Editor Options'
  ClientHeight = 383
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
  OnHelp = FormHelp
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    429
    383)
  PixelsPerInch = 96
  TextHeight = 13
  object PagesMain: TPageControl
    Left = 7
    Top = 8
    Width = 415
    Height = 340
    ActivePage = tabClassBrowsing
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabIndex = 4
    TabOrder = 0
    OnChange = PagesMainChange
    object tabGeneral: TTabSheet
      Caption = 'General'
      object bvlEditor: TBevel
        Left = 10
        Top = 9
        Width = 390
        Height = 3
        Shape = bsTopLine
      end
      object lblEditorOpts: TLabel
        Left = 20
        Top = 2
        Width = 81
        Height = 13
        Caption = '  Editor Options:  '
      end
      object lblTabSize: TLabel
        Left = 279
        Top = 180
        Width = 45
        Height = 13
        Caption = 'Tab Size:'
      end
      object Bevel1: TBevel
        Left = 7
        Top = 176
        Width = 396
        Height = 2
        Shape = bsTopLine
      end
      object cbEHomeKey: TCheckBox
        Left = 209
        Top = 18
        Width = 200
        Height = 17
        Hint = 'enhances home key positioning, similar to visual studio'
        Caption = 'Enhance home key'
        TabOrder = 9
      end
      object cbSmartScroll: TCheckBox
        Left = 209
        Top = 104
        Width = 200
        Height = 17
        Hint = 'show scrollbars only when content is available'
        Caption = 'Scollbars on need'
        TabOrder = 14
      end
      object cbAutoIndent: TCheckBox
        Left = 8
        Top = 18
        Width = 200
        Height = 17
        Hint = 'caret will position to first non-whitespace of preceeding line'
        Caption = 'Auto Indent'
        TabOrder = 0
      end
      object cbInsertMode: TCheckBox
        Left = 8
        Top = 35
        Width = 200
        Height = 17
        Hint = 'editor is in insert mode on start'
        Caption = 'Insert Mode'
        TabOrder = 1
      end
      object cbTabtoSpaces: TCheckBox
        Left = 8
        Top = 52
        Width = 200
        Height = 17
        Caption = 'Use Tab Character'
        TabOrder = 2
      end
      object cbSmartTabs: TCheckBox
        Left = 8
        Top = 69
        Width = 200
        Height = 17
        Hint = 
          'on tab cursor is moved to first nonblank space of preceeding lin' +
          'e'
        Caption = 'Smart Tabs'
        TabOrder = 3
      end
      object cbHalfPage: TCheckBox
        Left = 209
        Top = 121
        Width = 200
        Height = 17
        Hint = 'page up/down will move text by half a page instead of full page'
        Caption = 'Half Page Scrolling'
        TabOrder = 15
      end
      object cbPastEOF: TCheckBox
        Left = 209
        Top = 35
        Width = 200
        Height = 17
        Hint = 'allow cursor position past end of file'
        Caption = 'Cursor Past EOF'
        TabOrder = 10
      end
      object cbPastEOL: TCheckBox
        Left = 209
        Top = 52
        Width = 200
        Height = 17
        Hint = 'allows cursor position past end of line'
        Caption = 'Cursor Past EOL'
        TabOrder = 11
      end
      object cbFindText: TCheckBox
        Left = 209
        Top = 87
        Width = 200
        Height = 17
        Hint = 'inserts text at cursor into text to find of search dialog'
        Caption = 'Find Text at Cursor'
        TabOrder = 13
      end
      object cbTrailingBlanks: TCheckBox
        Left = 8
        Top = 87
        Width = 200
        Height = 17
        Hint = 'Blanks at end of lines will be saved with file'
        Caption = 'Keep Trailing Blanks'
        TabOrder = 4
      end
      object cbScrollHint: TCheckBox
        Left = 209
        Top = 138
        Width = 200
        Height = 17
        Hint = 'shows current line when scrolling'
        Caption = 'Scroll Hint'
        TabOrder = 16
      end
      object cbDoubleLine: TCheckBox
        Left = 209
        Top = 69
        Width = 200
        Height = 17
        Hint = 'double clicking a line selects it'
        Caption = 'Double Click Line'
        TabOrder = 12
      end
      object cbSyntaxHighlight: TCheckBox
        Left = 8
        Top = 180
        Width = 180
        Height = 17
        Caption = 'Use Syntax Highlight'
        TabOrder = 18
        OnClick = cbSyntaxHighlightClick
      end
      object edSyntaxExt: TEdit
        Left = 28
        Top = 196
        Width = 175
        Height = 21
        TabOrder = 19
      end
      object seTabSize: TSpinEdit
        Left = 289
        Top = 195
        Width = 100
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 20
        Value = 0
      end
      object cbSmartUnIndent: TCheckBox
        Left = 8
        Top = 104
        Width = 200
        Height = 17
        Hint = 'cursor is moved to nonblank space of previous line '
        Caption = 'Backspace Unindents'
        TabOrder = 5
      end
      object cbGroupUndo: TCheckBox
        Left = 8
        Top = 121
        Width = 200
        Height = 17
        Hint = 'handle all changes of same type as single action'
        Caption = 'Group Undo'
        TabOrder = 6
      end
      object grpMargin: TGroupBox
        Left = 6
        Top = 221
        Width = 154
        Height = 82
        Caption = '  Right Margin  '
        TabOrder = 21
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
        Left = 169
        Top = 221
        Width = 235
        Height = 82
        Caption = '  Caret  '
        TabOrder = 22
        object lblInsertCaret: TLabel
          Left = 8
          Top = 16
          Width = 56
          Height = 13
          Caption = 'Insert caret:'
        end
        object lblOverCaret: TLabel
          Left = 8
          Top = 39
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
          Top = 35
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
      object cbDropFiles: TCheckBox
        Left = 8
        Top = 138
        Width = 200
        Height = 17
        Caption = 'Insert Dropped Files'
        TabOrder = 7
      end
      object cbSpecialChars: TCheckBox
        Left = 8
        Top = 156
        Width = 200
        Height = 17
        Caption = 'Show Special Line Chars'
        TabOrder = 8
      end
      object cbParserHints: TCheckBox
        Left = 209
        Top = 156
        Width = 200
        Height = 17
        Caption = 'Show editor hints'
        TabOrder = 17
      end
    end
    object tabDisplay: TTabSheet
      Caption = 'Display'
      object grpGutter: TGroupBox
        Left = 6
        Top = 138
        Width = 398
        Height = 165
        Caption = '  Gutter  '
        TabOrder = 1
        DesignSize = (
          398
          165)
        object lblGutterFont: TLabel
          Left = 8
          Top = 71
          Width = 21
          Height = 13
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'Font'
        end
        object lblGutterWidth: TLabel
          Left = 321
          Top = 71
          Width = 28
          Height = 13
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'Width'
          WordWrap = True
        end
        object lblGutterFontSize: TLabel
          Left = 200
          Top = 71
          Width = 20
          Height = 13
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'Size'
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
          Top = 114
          Width = 373
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
          Top = 87
          Width = 180
          Height = 21
          Anchors = [akLeft, akRight, akBottom]
          ItemHeight = 13
          TabOrder = 6
          OnChange = FontChange
          OnDblClick = cboDblClick
        end
        object cboGutterSize: TComboBox
          Left = 208
          Top = 87
          Width = 86
          Height = 21
          Anchors = [akLeft, akRight, akBottom]
          ItemHeight = 13
          TabOrder = 7
          OnChange = FontSizeChange
          OnDblClick = cboDblClick
        end
        object edGutterWidth: TSpinEdit
          Left = 328
          Top = 87
          Width = 57
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 9
          Value = 0
        end
      end
      object grpEditorFont: TGroupBox
        Left = 6
        Top = 6
        Width = 398
        Height = 109
        Caption = '  Editor Font  '
        TabOrder = 0
        DesignSize = (
          398
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
        object cboEditorFont: TComboBox
          Left = 12
          Top = 32
          Width = 180
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          OnDblClick = cboDblClick
          OnSelect = FontChange
        end
        object cboEditorSize: TComboBox
          Left = 208
          Top = 32
          Width = 80
          Height = 21
          ItemHeight = 13
          TabOrder = 1
          OnChange = FontSizeChange
          OnDblClick = cboDblClick
        end
        object pnlEditorPreview: TPanel
          Left = 12
          Top = 60
          Width = 373
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
      end
    end
    object tabSyntax: TTabSheet
      Caption = 'Syntax'
      object cpForeground: TColorPickerButton
        Left = 161
        Top = 23
        Width = 110
        Height = 22
        CustomText = 'Custom'
        DefaultText = 'Default'
        PopupSpacing = 8
        ShowSystemColors = True
        OnChange = StyleChange
        OnDefaultSelect = DefaultSelect
        OnHint = PickerHint
      end
      object cpBackground: TColorPickerButton
        Left = 161
        Top = 76
        Width = 110
        Height = 24
        CustomText = 'Custom'
        DefaultText = 'Default'
        PopupSpacing = 8
        ShowSystemColors = True
        OnChange = StyleChange
        OnDefaultSelect = DefaultSelect
        OnHint = PickerHint
      end
      object lblForeground: TLabel
        Left = 153
        Top = 8
        Width = 57
        Height = 13
        Caption = 'Foreground:'
      end
      object lblBackground: TLabel
        Left = 153
        Top = 59
        Width = 61
        Height = 13
        Caption = 'Background:'
      end
      object lblElements: TLabel
        Left = 7
        Top = 8
        Width = 41
        Height = 13
        Caption = 'Element:'
      end
      object lblSpeed: TLabel
        Left = 281
        Top = 8
        Width = 97
        Height = 13
        Caption = 'Color Speed Setting:'
      end
      object Bevel3: TBevel
        Left = 0
        Top = 158
        Width = 407
        Height = 3
        Align = alBottom
      end
      object btnSaveSyntax: TSpeedButton
        Left = 280
        Top = 23
        Width = 21
        Height = 21
        Hint = 'Save custom syntax settings'
        Flat = True
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
      object CppEdit: TSynEdit
        Left = 0
        Top = 161
        Width = 407
        Height = 151
        Cursor = crIBeam
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 3
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
        Highlighter = cpp
        Keystrokes = <
          item
            Command = ecUp
            ShortCut = 38
          end
          item
            Command = ecSelUp
            ShortCut = 8230
          end
          item
            Command = ecScrollUp
            ShortCut = 16422
          end
          item
            Command = ecDown
            ShortCut = 40
          end
          item
            Command = ecSelDown
            ShortCut = 8232
          end
          item
            Command = ecScrollDown
            ShortCut = 16424
          end
          item
            Command = ecLeft
            ShortCut = 37
          end
          item
            Command = ecSelLeft
            ShortCut = 8229
          end
          item
            Command = ecWordLeft
            ShortCut = 16421
          end
          item
            Command = ecSelWordLeft
            ShortCut = 24613
          end
          item
            Command = ecRight
            ShortCut = 39
          end
          item
            Command = ecSelRight
            ShortCut = 8231
          end
          item
            Command = ecWordRight
            ShortCut = 16423
          end
          item
            Command = ecSelWordRight
            ShortCut = 24615
          end
          item
            Command = ecPageDown
            ShortCut = 34
          end
          item
            Command = ecSelPageDown
            ShortCut = 8226
          end
          item
            Command = ecPageBottom
            ShortCut = 16418
          end
          item
            Command = ecSelPageBottom
            ShortCut = 24610
          end
          item
            Command = ecPageUp
            ShortCut = 33
          end
          item
            Command = ecSelPageUp
            ShortCut = 8225
          end
          item
            Command = ecPageTop
            ShortCut = 16417
          end
          item
            Command = ecSelPageTop
            ShortCut = 24609
          end
          item
            Command = ecLineStart
            ShortCut = 36
          end
          item
            Command = ecSelLineStart
            ShortCut = 8228
          end
          item
            Command = ecEditorTop
            ShortCut = 16420
          end
          item
            Command = ecSelEditorTop
            ShortCut = 24612
          end
          item
            Command = ecLineEnd
            ShortCut = 35
          end
          item
            Command = ecSelLineEnd
            ShortCut = 8227
          end
          item
            Command = ecEditorBottom
            ShortCut = 16419
          end
          item
            Command = ecSelEditorBottom
            ShortCut = 24611
          end
          item
            Command = ecToggleMode
            ShortCut = 45
          end
          item
            Command = ecCopy
            ShortCut = 16429
          end
          item
            Command = ecCut
            ShortCut = 8238
          end
          item
            Command = ecPaste
            ShortCut = 8237
          end
          item
            Command = ecDeleteChar
            ShortCut = 46
          end
          item
            Command = ecDeleteLastChar
            ShortCut = 8
          end
          item
            Command = ecDeleteLastChar
            ShortCut = 8200
          end
          item
            Command = ecDeleteLastWord
            ShortCut = 16392
          end
          item
            Command = ecUndo
            ShortCut = 32776
          end
          item
            Command = ecRedo
            ShortCut = 40968
          end
          item
            Command = ecLineBreak
            ShortCut = 13
          end
          item
            Command = ecLineBreak
            ShortCut = 8205
          end
          item
            Command = ecTab
            ShortCut = 9
          end
          item
            Command = ecShiftTab
            ShortCut = 8201
          end
          item
            Command = ecContextHelp
            ShortCut = 16496
          end
          item
            Command = ecSelectAll
            ShortCut = 16449
          end
          item
            Command = ecCopy
            ShortCut = 16451
          end
          item
            Command = ecPaste
            ShortCut = 16470
          end
          item
            Command = ecCut
            ShortCut = 16472
          end
          item
            Command = ecBlockIndent
            ShortCut = 24649
          end
          item
            Command = ecBlockUnindent
            ShortCut = 24661
          end
          item
            Command = ecLineBreak
            ShortCut = 16461
          end
          item
            Command = ecInsertLine
            ShortCut = 16462
          end
          item
            Command = ecDeleteWord
            ShortCut = 16468
          end
          item
            Command = ecDeleteLine
            ShortCut = 16473
          end
          item
            Command = ecDeleteEOL
            ShortCut = 24665
          end
          item
            Command = ecUndo
            ShortCut = 16474
          end
          item
            Command = ecRedo
            ShortCut = 24666
          end
          item
            Command = ecGotoMarker0
            ShortCut = 16432
          end
          item
            Command = ecGotoMarker1
            ShortCut = 16433
          end
          item
            Command = ecGotoMarker2
            ShortCut = 16434
          end
          item
            Command = ecGotoMarker3
            ShortCut = 16435
          end
          item
            Command = ecGotoMarker4
            ShortCut = 16436
          end
          item
            Command = ecGotoMarker5
            ShortCut = 16437
          end
          item
            Command = ecGotoMarker6
            ShortCut = 16438
          end
          item
            Command = ecGotoMarker7
            ShortCut = 16439
          end
          item
            Command = ecGotoMarker8
            ShortCut = 16440
          end
          item
            Command = ecGotoMarker9
            ShortCut = 16441
          end
          item
            Command = ecSetMarker0
            ShortCut = 24624
          end
          item
            Command = ecSetMarker1
            ShortCut = 24625
          end
          item
            Command = ecSetMarker2
            ShortCut = 24626
          end
          item
            Command = ecSetMarker3
            ShortCut = 24627
          end
          item
            Command = ecSetMarker4
            ShortCut = 24628
          end
          item
            Command = ecSetMarker5
            ShortCut = 24629
          end
          item
            Command = ecSetMarker6
            ShortCut = 24630
          end
          item
            Command = ecSetMarker7
            ShortCut = 24631
          end
          item
            Command = ecSetMarker8
            ShortCut = 24632
          end
          item
            Command = ecSetMarker9
            ShortCut = 24633
          end
          item
            Command = ecNormalSelect
            ShortCut = 24654
          end
          item
            Command = ecColumnSelect
            ShortCut = 24643
          end
          item
            Command = ecLineSelect
            ShortCut = 24652
          end
          item
            Command = ecMatchBracket
            ShortCut = 24642
          end>
        Options = [eoAutoIndent, eoDragDropEditing, eoNoCaret, eoNoSelection, eoScrollPastEol, eoShowScrollHint, eoSmartTabs, eoTrimTrailingSpaces, eoHideShowScrollbars, eoDisableScrollArrows]
        ReadOnly = True
        ScrollHintFormat = shfTopToBottom
        WantTabs = True
        OnSpecialLineColors = CppEditSpecialLineColors
        OnStatusChange = cppEditStatusChange
      end
      object ElementList: TListBox
        Left = 7
        Top = 23
        Width = 138
        Height = 121
        ImeName = 'CN'#177'??i(CN'#177'U)'
        IntegralHeight = True
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
      object grpStyle: TGroupBox
        Left = 295
        Top = 53
        Width = 110
        Height = 73
        Caption = '  Style:  '
        TabOrder = 2
        object cbBold: TCheckBox
          Left = 8
          Top = 15
          Width = 100
          Height = 17
          Caption = 'Bold'
          TabOrder = 0
          OnClick = StyleChange
        end
        object cbItalic: TCheckBox
          Left = 8
          Top = 32
          Width = 100
          Height = 17
          Caption = 'Italic'
          TabOrder = 1
          OnClick = StyleChange
        end
        object cbUnderlined: TCheckBox
          Left = 8
          Top = 50
          Width = 100
          Height = 17
          Caption = 'Underlined'
          TabOrder = 2
          OnClick = StyleChange
        end
      end
      object cboQuickColor: TComboBox
        Left = 303
        Top = 23
        Width = 102
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
    end
    object tabCode: TTabSheet
      Caption = 'Code'
      object codepages: TPageControl
        Left = 5
        Top = 0
        Width = 401
        Height = 304
        ActivePage = tabCPInserts
        TabIndex = 0
        TabOrder = 0
        object tabCPInserts: TTabSheet
          Caption = 'Inserts'
          object lblCode: TLabel
            Left = 0
            Top = 114
            Width = 28
            Height = 13
            Align = alBottom
            Caption = 'Code:'
          end
          object Bevel2: TBevel
            Left = 0
            Top = 278
            Width = 401
            Height = 3
            Align = alBottom
            Shape = bsTopLine
          end
          object Bevel4: TBevel
            Left = 0
            Top = 127
            Width = 401
            Height = 3
            Align = alBottom
            Shape = bsTopLine
          end
          object btnAdd: TButton
            Left = 326
            Top = 8
            Width = 70
            Height = 23
            Caption = 'Add'
            TabOrder = 1
            OnClick = btnAddClick
          end
          object btnEdit: TButton
            Left = 326
            Top = 41
            Width = 70
            Height = 23
            Caption = 'Edit'
            TabOrder = 2
            OnClick = btnEditClick
          end
          object btnRemove: TButton
            Left = 326
            Top = 75
            Width = 70
            Height = 23
            Caption = 'Remove'
            TabOrder = 3
            OnClick = btnRemoveClick
          end
          object lvCodeins: TListView
            Left = 6
            Top = 8
            Width = 311
            Height = 91
            BevelOuter = bvRaised
            BevelKind = bkSoft
            BorderStyle = bsNone
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
            Left = 0
            Top = 125
            Width = 393
            Height = 148
            Cursor = crIBeam
            Align = alBottom
            Ctl3D = True
            ParentCtl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Courier New'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            TabOrder = 4
            BorderStyle = bsNone
            Gutter.Font.Charset = DEFAULT_CHARSET
            Gutter.Font.Color = clWindowText
            Gutter.Font.Height = -11
            Gutter.Font.Name = 'Terminal'
            Gutter.Font.Style = []
            Gutter.Width = 10
            Highlighter = cpp
            Keystrokes = <
              item
                Command = ecUp
                ShortCut = 38
              end
              item
                Command = ecSelUp
                ShortCut = 8230
              end
              item
                Command = ecScrollUp
                ShortCut = 16422
              end
              item
                Command = ecDown
                ShortCut = 40
              end
              item
                Command = ecSelDown
                ShortCut = 8232
              end
              item
                Command = ecScrollDown
                ShortCut = 16424
              end
              item
                Command = ecLeft
                ShortCut = 37
              end
              item
                Command = ecSelLeft
                ShortCut = 8229
              end
              item
                Command = ecWordLeft
                ShortCut = 16421
              end
              item
                Command = ecSelWordLeft
                ShortCut = 24613
              end
              item
                Command = ecRight
                ShortCut = 39
              end
              item
                Command = ecSelRight
                ShortCut = 8231
              end
              item
                Command = ecWordRight
                ShortCut = 16423
              end
              item
                Command = ecSelWordRight
                ShortCut = 24615
              end
              item
                Command = ecPageDown
                ShortCut = 34
              end
              item
                Command = ecSelPageDown
                ShortCut = 8226
              end
              item
                Command = ecPageBottom
                ShortCut = 16418
              end
              item
                Command = ecSelPageBottom
                ShortCut = 24610
              end
              item
                Command = ecPageUp
                ShortCut = 33
              end
              item
                Command = ecSelPageUp
                ShortCut = 8225
              end
              item
                Command = ecPageTop
                ShortCut = 16417
              end
              item
                Command = ecSelPageTop
                ShortCut = 24609
              end
              item
                Command = ecLineStart
                ShortCut = 36
              end
              item
                Command = ecSelLineStart
                ShortCut = 8228
              end
              item
                Command = ecEditorTop
                ShortCut = 16420
              end
              item
                Command = ecSelEditorTop
                ShortCut = 24612
              end
              item
                Command = ecLineEnd
                ShortCut = 35
              end
              item
                Command = ecSelLineEnd
                ShortCut = 8227
              end
              item
                Command = ecEditorBottom
                ShortCut = 16419
              end
              item
                Command = ecSelEditorBottom
                ShortCut = 24611
              end
              item
                Command = ecToggleMode
                ShortCut = 45
              end
              item
                Command = ecCopy
                ShortCut = 16429
              end
              item
                Command = ecCut
                ShortCut = 8238
              end
              item
                Command = ecPaste
                ShortCut = 8237
              end
              item
                Command = ecDeleteChar
                ShortCut = 46
              end
              item
                Command = ecDeleteLastChar
                ShortCut = 8
              end
              item
                Command = ecDeleteLastChar
                ShortCut = 8200
              end
              item
                Command = ecDeleteLastWord
                ShortCut = 16392
              end
              item
                Command = ecUndo
                ShortCut = 32776
              end
              item
                Command = ecRedo
                ShortCut = 40968
              end
              item
                Command = ecLineBreak
                ShortCut = 13
              end
              item
                Command = ecLineBreak
                ShortCut = 8205
              end
              item
                Command = ecTab
                ShortCut = 9
              end
              item
                Command = ecShiftTab
                ShortCut = 8201
              end
              item
                Command = ecContextHelp
                ShortCut = 16496
              end
              item
                Command = ecSelectAll
                ShortCut = 16449
              end
              item
                Command = ecCopy
                ShortCut = 16451
              end
              item
                Command = ecPaste
                ShortCut = 16470
              end
              item
                Command = ecCut
                ShortCut = 16472
              end
              item
                Command = ecBlockIndent
                ShortCut = 24649
              end
              item
                Command = ecBlockUnindent
                ShortCut = 24661
              end
              item
                Command = ecLineBreak
                ShortCut = 16461
              end
              item
                Command = ecInsertLine
                ShortCut = 16462
              end
              item
                Command = ecDeleteWord
                ShortCut = 16468
              end
              item
                Command = ecDeleteLine
                ShortCut = 16473
              end
              item
                Command = ecDeleteEOL
                ShortCut = 24665
              end
              item
                Command = ecUndo
                ShortCut = 16474
              end
              item
                Command = ecRedo
                ShortCut = 24666
              end
              item
                Command = ecGotoMarker0
                ShortCut = 16432
              end
              item
                Command = ecGotoMarker1
                ShortCut = 16433
              end
              item
                Command = ecGotoMarker2
                ShortCut = 16434
              end
              item
                Command = ecGotoMarker3
                ShortCut = 16435
              end
              item
                Command = ecGotoMarker4
                ShortCut = 16436
              end
              item
                Command = ecGotoMarker5
                ShortCut = 16437
              end
              item
                Command = ecGotoMarker6
                ShortCut = 16438
              end
              item
                Command = ecGotoMarker7
                ShortCut = 16439
              end
              item
                Command = ecGotoMarker8
                ShortCut = 16440
              end
              item
                Command = ecGotoMarker9
                ShortCut = 16441
              end
              item
                Command = ecSetMarker0
                ShortCut = 24624
              end
              item
                Command = ecSetMarker1
                ShortCut = 24625
              end
              item
                Command = ecSetMarker2
                ShortCut = 24626
              end
              item
                Command = ecSetMarker3
                ShortCut = 24627
              end
              item
                Command = ecSetMarker4
                ShortCut = 24628
              end
              item
                Command = ecSetMarker5
                ShortCut = 24629
              end
              item
                Command = ecSetMarker6
                ShortCut = 24630
              end
              item
                Command = ecSetMarker7
                ShortCut = 24631
              end
              item
                Command = ecSetMarker8
                ShortCut = 24632
              end
              item
                Command = ecSetMarker9
                ShortCut = 24633
              end
              item
                Command = ecNormalSelect
                ShortCut = 24654
              end
              item
                Command = ecColumnSelect
                ShortCut = 24643
              end
              item
                Command = ecLineSelect
                ShortCut = 24652
              end
              item
                Command = ecMatchBracket
                ShortCut = 24642
              end>
            Options = [eoAutoIndent, eoDragDropEditing, eoScrollPastEol, eoShowScrollHint, eoSmartTabs, eoTabsToSpaces, eoTrimTrailingSpaces, eoSmartTabDelete, eoEnhanceHomeKey, eoGroupUndo, eoHideShowScrollbars, eoDisableScrollArrows]
            WantTabs = True
            OnStatusChange = CodeInsStatusChange
          end
        end
        object tabCPDefault: TTabSheet
          Caption = 'Default Source'
          object seDefault: TSynEdit
            Left = 0
            Top = 0
            Width = 401
            Height = 261
            Cursor = crIBeam
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Courier New'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            TabOrder = 0
            BorderStyle = bsNone
            Gutter.Font.Charset = DEFAULT_CHARSET
            Gutter.Font.Color = clWindowText
            Gutter.Font.Height = -11
            Gutter.Font.Name = 'Terminal'
            Gutter.Font.Style = []
            Gutter.Width = 10
            Highlighter = cpp
            Keystrokes = <
              item
                Command = ecUp
                ShortCut = 38
              end
              item
                Command = ecSelUp
                ShortCut = 8230
              end
              item
                Command = ecScrollUp
                ShortCut = 16422
              end
              item
                Command = ecDown
                ShortCut = 40
              end
              item
                Command = ecSelDown
                ShortCut = 8232
              end
              item
                Command = ecScrollDown
                ShortCut = 16424
              end
              item
                Command = ecLeft
                ShortCut = 37
              end
              item
                Command = ecSelLeft
                ShortCut = 8229
              end
              item
                Command = ecWordLeft
                ShortCut = 16421
              end
              item
                Command = ecSelWordLeft
                ShortCut = 24613
              end
              item
                Command = ecRight
                ShortCut = 39
              end
              item
                Command = ecSelRight
                ShortCut = 8231
              end
              item
                Command = ecWordRight
                ShortCut = 16423
              end
              item
                Command = ecSelWordRight
                ShortCut = 24615
              end
              item
                Command = ecPageDown
                ShortCut = 34
              end
              item
                Command = ecSelPageDown
                ShortCut = 8226
              end
              item
                Command = ecPageBottom
                ShortCut = 16418
              end
              item
                Command = ecSelPageBottom
                ShortCut = 24610
              end
              item
                Command = ecPageUp
                ShortCut = 33
              end
              item
                Command = ecSelPageUp
                ShortCut = 8225
              end
              item
                Command = ecPageTop
                ShortCut = 16417
              end
              item
                Command = ecSelPageTop
                ShortCut = 24609
              end
              item
                Command = ecLineStart
                ShortCut = 36
              end
              item
                Command = ecSelLineStart
                ShortCut = 8228
              end
              item
                Command = ecEditorTop
                ShortCut = 16420
              end
              item
                Command = ecSelEditorTop
                ShortCut = 24612
              end
              item
                Command = ecLineEnd
                ShortCut = 35
              end
              item
                Command = ecSelLineEnd
                ShortCut = 8227
              end
              item
                Command = ecEditorBottom
                ShortCut = 16419
              end
              item
                Command = ecSelEditorBottom
                ShortCut = 24611
              end
              item
                Command = ecToggleMode
                ShortCut = 45
              end
              item
                Command = ecCopy
                ShortCut = 16429
              end
              item
                Command = ecCut
                ShortCut = 8238
              end
              item
                Command = ecPaste
                ShortCut = 8237
              end
              item
                Command = ecDeleteChar
                ShortCut = 46
              end
              item
                Command = ecDeleteLastChar
                ShortCut = 8
              end
              item
                Command = ecDeleteLastChar
                ShortCut = 8200
              end
              item
                Command = ecDeleteLastWord
                ShortCut = 16392
              end
              item
                Command = ecUndo
                ShortCut = 32776
              end
              item
                Command = ecRedo
                ShortCut = 40968
              end
              item
                Command = ecLineBreak
                ShortCut = 13
              end
              item
                Command = ecLineBreak
                ShortCut = 8205
              end
              item
                Command = ecTab
                ShortCut = 9
              end
              item
                Command = ecShiftTab
                ShortCut = 8201
              end
              item
                Command = ecContextHelp
                ShortCut = 16496
              end
              item
                Command = ecSelectAll
                ShortCut = 16449
              end
              item
                Command = ecCopy
                ShortCut = 16451
              end
              item
                Command = ecPaste
                ShortCut = 16470
              end
              item
                Command = ecCut
                ShortCut = 16472
              end
              item
                Command = ecBlockIndent
                ShortCut = 24649
              end
              item
                Command = ecBlockUnindent
                ShortCut = 24661
              end
              item
                Command = ecLineBreak
                ShortCut = 16461
              end
              item
                Command = ecInsertLine
                ShortCut = 16462
              end
              item
                Command = ecDeleteWord
                ShortCut = 16468
              end
              item
                Command = ecDeleteLine
                ShortCut = 16473
              end
              item
                Command = ecDeleteEOL
                ShortCut = 24665
              end
              item
                Command = ecUndo
                ShortCut = 16474
              end
              item
                Command = ecRedo
                ShortCut = 24666
              end
              item
                Command = ecGotoMarker0
                ShortCut = 16432
              end
              item
                Command = ecGotoMarker1
                ShortCut = 16433
              end
              item
                Command = ecGotoMarker2
                ShortCut = 16434
              end
              item
                Command = ecGotoMarker3
                ShortCut = 16435
              end
              item
                Command = ecGotoMarker4
                ShortCut = 16436
              end
              item
                Command = ecGotoMarker5
                ShortCut = 16437
              end
              item
                Command = ecGotoMarker6
                ShortCut = 16438
              end
              item
                Command = ecGotoMarker7
                ShortCut = 16439
              end
              item
                Command = ecGotoMarker8
                ShortCut = 16440
              end
              item
                Command = ecGotoMarker9
                ShortCut = 16441
              end
              item
                Command = ecSetMarker0
                ShortCut = 24624
              end
              item
                Command = ecSetMarker1
                ShortCut = 24625
              end
              item
                Command = ecSetMarker2
                ShortCut = 24626
              end
              item
                Command = ecSetMarker3
                ShortCut = 24627
              end
              item
                Command = ecSetMarker4
                ShortCut = 24628
              end
              item
                Command = ecSetMarker5
                ShortCut = 24629
              end
              item
                Command = ecSetMarker6
                ShortCut = 24630
              end
              item
                Command = ecSetMarker7
                ShortCut = 24631
              end
              item
                Command = ecSetMarker8
                ShortCut = 24632
              end
              item
                Command = ecSetMarker9
                ShortCut = 24633
              end
              item
                Command = ecNormalSelect
                ShortCut = 24654
              end
              item
                Command = ecColumnSelect
                ShortCut = 24643
              end
              item
                Command = ecLineSelect
                ShortCut = 24652
              end
              item
                Command = ecMatchBracket
                ShortCut = 24642
              end>
            Options = [eoAutoIndent, eoDragDropEditing, eoScrollPastEol, eoShowScrollHint, eoSmartTabs, eoTabsToSpaces, eoTrimTrailingSpaces, eoSmartTabDelete, eoGroupUndo, eoHideShowScrollbars, eoDisableScrollArrows]
          end
          object Panel1: TPanel
            Left = 0
            Top = 261
            Width = 401
            Height = 20
            Align = alBottom
            BevelInner = bvLowered
            BevelOuter = bvNone
            TabOrder = 1
            object cbDefaultintoprj: TCheckBox
              Left = 4
              Top = 2
              Width = 395
              Height = 17
              Caption = 'Insert Default Code into Empty Projects'
              TabOrder = 0
            end
          end
        end
      end
    end
    object tabClassBrowsing: TTabSheet
      Caption = 'Class browsing'
      object chkEnableClassBrowser: TCheckBox
        Left = 8
        Top = 12
        Width = 361
        Height = 17
        Caption = 'Enable class browser'
        TabOrder = 0
        OnClick = chkEnableClassBrowserClick
      end
      object devPages1: TPageControl
        Left = 8
        Top = 32
        Width = 393
        Height = 265
        ActivePage = tabCBBrowser
        TabIndex = 0
        TabOrder = 1
        OnChange = devPages1Change
        object tabCBBrowser: TTabSheet
          Caption = 'Class browsing'
          object lblClassBrowserSample: TLabel
            Left = 8
            Top = 156
            Width = 38
            Height = 13
            Caption = 'Sample:'
          end
          object ClassBrowser1: TClassBrowser
            Left = 52
            Top = 156
            Width = 317
            Height = 73
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
            Left = 8
            Top = 12
            Width = 361
            Height = 65
            Caption = 'Engine behaviour'
            TabOrder = 0
            object chkCBParseGlobalH: TCheckBox
              Left = 8
              Top = 40
              Width = 345
              Height = 17
              Caption = 'Scan global files referenced in #include'#39's'
              TabOrder = 1
            end
            object chkCBParseLocalH: TCheckBox
              Left = 8
              Top = 20
              Width = 345
              Height = 17
              Caption = 'Scan local files referenced in #include'#39's'
              TabOrder = 0
            end
          end
          object gbCBView: TGroupBox
            Left = 8
            Top = 84
            Width = 361
            Height = 65
            Caption = 'View options'
            TabOrder = 1
            object chkCBUseColors: TCheckBox
              Left = 8
              Top = 20
              Width = 345
              Height = 17
              Caption = 'Use colors'
              TabOrder = 0
              OnClick = chkCBUseColorsClick
            end
            object chkCBShowInherited: TCheckBox
              Left = 8
              Top = 40
              Width = 345
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
            Left = 8
            Top = 36
            Width = 52
            Height = 13
            Caption = 'Delay (ms):'
          end
          object cpCompletionBackground: TColorPickerButton
            Left = 269
            Top = 55
            Width = 112
            Height = 22
            CustomText = 'Custom'
            DefaultText = 'Default'
            PopupSpacing = 8
            ShowSystemColors = True
            OnChange = StyleChange
            OnDefaultSelect = DefaultSelect
            OnHint = PickerHint
          end
          object lblCompletionColor: TLabel
            Left = 256
            Top = 36
            Width = 87
            Height = 13
            Caption = 'Background color:'
          end
          object btnCCCnew: TSpeedButton
            Left = 292
            Top = 136
            Width = 89
            Height = 22
            Caption = 'Add files'
            OnClick = btnCCCnewClick
          end
          object btnCCCdelete: TSpeedButton
            Left = 292
            Top = 160
            Width = 89
            Height = 22
            Caption = 'Clear'
            OnClick = btnCCCdeleteClick
          end
          object lblCCCache: TLabel
            Left = 8
            Top = 120
            Width = 68
            Height = 13
            Caption = 'Files in cache:'
          end
          object tbCompletionDelay: TTrackBar
            Left = 16
            Top = 52
            Width = 217
            Height = 29
            LineSize = 50
            Max = 1500
            Orientation = trHorizontal
            PageSize = 50
            Frequency = 50
            Position = 500
            SelEnd = 0
            SelStart = 0
            TabOrder = 1
            ThumbLength = 16
            TickMarks = tmTopLeft
            TickStyle = tsAuto
            OnChange = tbCompletionDelayChange
          end
          object chkEnableCompletion: TCheckBox
            Left = 8
            Top = 12
            Width = 361
            Height = 17
            Caption = 'Enable code-completion'
            TabOrder = 0
            OnClick = chkEnableCompletionClick
          end
          object chkCCCache: TCheckBox
            Left = 8
            Top = 96
            Width = 353
            Height = 17
            Caption = 'Use code-completion cache'
            TabOrder = 2
            OnClick = chkCCCacheClick
          end
          object lbCCC: TListBox
            Left = 24
            Top = 136
            Width = 261
            Height = 96
            ItemHeight = 13
            Sorted = True
            TabOrder = 3
          end
          object pbCCCache: TProgressBar
            Left = 292
            Top = 184
            Width = 89
            Height = 16
            Min = 0
            Max = 100
            TabOrder = 4
            Visible = False
          end
        end
      end
    end
  end
  object btnOk: TBitBtn
    Left = 163
    Top = 354
    Width = 84
    Height = 24
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
    Left = 248
    Top = 354
    Width = 84
    Height = 24
    Anchors = [akRight, akBottom]
    TabOrder = 2
    OnClick = btnCancelClick
    Kind = bkCancel
  end
  object btnHelp: TBitBtn
    Left = 345
    Top = 354
    Width = 75
    Height = 24
    Anchors = [akRight, akBottom]
    TabOrder = 3
    OnClick = btnHelpClick
    Kind = bkHelp
  end
  object cpp: TSynCppSyn
    DefaultFilter = 'C++ Files (*.c,*.cpp,*.h,*.hpp)|*.c;*.cpp;*.h;*.hpp'
    Left = 5
    Top = 354
  end
  object CppTokenizer1: TCppTokenizer
    LogTokens = False
    Left = 40
    Top = 352
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
    Left = 80
    Top = 352
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
    Left = 136
    Top = 56
  end
end
