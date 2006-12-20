object MainForm: TMainForm
  Left = 356
  Top = 123
  Width = 636
  Height = 442
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnContextPopup = FormContextPopup
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MessageControl: TPageControl
    Left = 0
    Top = 239
    Width = 628
    Height = 130
    ActivePage = CompSheet
    Align = alBottom
    Constraints.MinHeight = 1
    Images = dmMain.MenuImages_Gnome
    MultiLine = True
    PopupMenu = MessagePopup
    TabOrder = 0
    object CompSheet: TTabSheet
      BorderWidth = 2
      Caption = 'Compiler'
      ImageIndex = 28
      object CompilerOutput: TListView
        Left = 0
        Top = 0
        Width = 616
        Height = 98
        Align = alClient
        BevelOuter = bvRaised
        BevelKind = bkSoft
        BorderStyle = bsNone
        Columns = <
          item
            Caption = 'Line'
          end
          item
            Caption = 'Unit'
            Width = 200
          end
          item
            Caption = 'Message'
            Width = 480
          end>
        ColumnClick = False
        GridLines = True
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        ParentShowHint = False
        PopupMenu = MessagePopup
        ShowHint = True
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = CompilerOutputDblClick
        OnKeyDown = CompilerOutputKeyDown
      end
    end
    object ResSheet: TTabSheet
      BorderWidth = 2
      Caption = 'Resource'
      ImageIndex = 2
      object ResourceOutput: TListBox
        Left = 0
        Top = 0
        Width = 616
        Height = 98
        Align = alClient
        BevelKind = bkSoft
        BorderStyle = bsNone
        ItemHeight = 13
        ParentShowHint = False
        PopupMenu = MessagePopup
        ShowHint = True
        TabOrder = 0
      end
    end
    object LogSheet: TTabSheet
      BorderWidth = 2
      Caption = 'Compile log'
      ImageIndex = 43
      object InfoGroupBox: TGroupBox
        Left = 0
        Top = 0
        Width = 225
        Height = 98
        Align = alLeft
        Caption = 'Information :'
        TabOrder = 0
        object ErrorLabel: TLabel
          Left = 8
          Top = 20
          Width = 56
          Height = 13
          Caption = 'Total errors:'
        end
        object SizeOfOutput: TLabel
          Left = 8
          Top = 44
          Width = 84
          Height = 13
          Caption = 'Size of output file:'
        end
        object btnAbortCompilation: TSpeedButton
          Left = 8
          Top = 64
          Width = 209
          Height = 20
          Action = actAbortCompilation
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object SizeFile: TEdit
          Left = 96
          Top = 40
          Width = 121
          Height = 21
          ReadOnly = True
          TabOrder = 1
          Text = '0'
        end
        object TotalErrors: TEdit
          Left = 96
          Top = 16
          Width = 121
          Height = 21
          ReadOnly = True
          TabOrder = 0
          Text = '0'
        end
      end
      object CompResGroupBox: TGroupBox
        Left = 225
        Top = 0
        Width = 391
        Height = 98
        Align = alClient
        Caption = 'Compile log :'
        TabOrder = 1
        DesignSize = (
          391
          98)
        object LogOutput: TMemo
          Left = 7
          Top = 16
          Width = 390
          Height = 80
          Anchors = [akLeft, akTop, akRight, akBottom]
          PopupMenu = MessagePopup
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
    object DebugSheet: TTabSheet
      BorderWidth = 2
      Caption = 'Debugging'
      ImageIndex = 32
      object DebugSubPages: TPageControl
        Left = 0
        Top = 0
        Width = 616
        Height = 98
        ActivePage = tabDebugOutput
        Align = alClient
        TabOrder = 0
        object tabBacktrace: TTabSheet
          Caption = 'Stack Trace'
          ImageIndex = 1
          object lvBacktrace: TListView
            Left = 0
            Top = 0
            Width = 608
            Height = 70
            Align = alClient
            Columns = <
              item
                Caption = 'Function name'
                Width = 150
              end
              item
                Caption = 'Arguments'
                Width = 250
              end
              item
                Caption = 'Filename'
                Width = 150
              end
              item
                Caption = 'Line'
              end>
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnCustomDrawItem = lvBacktraceCustomDrawItem
            OnDblClick = lvBacktraceDblClick
            OnMouseMove = lvBacktraceMouseMove
          end
        end
        object tabLocals: TTabSheet
          Caption = 'Local Variables'
          ImageIndex = 3
          object lvLocals: TListView
            Left = 0
            Top = 0
            Width = 608
            Height = 70
            Align = alClient
            Columns = <
              item
                Caption = 'Name'
                Width = 200
              end
              item
                Caption = 'Value'
                Width = 325
              end
              item
                Caption = 'Location'
                Width = 75
              end>
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object tabThreads: TTabSheet
          Caption = 'Threads'
          ImageIndex = 3
          object lvThreads: TListView
            Left = 0
            Top = 0
            Width = 608
            Height = 70
            Align = alClient
            Columns = <
              item
                Width = 25
              end
              item
                Caption = 'Index'
              end
              item
                Caption = 'Thread ID'
                Width = 575
              end>
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnDblClick = lvThreadsDblClick
          end
        end
        object tabWatches: TTabSheet
          Caption = 'Watches'
          ImageIndex = -1
          object DebugTree: TTreeView
            Left = 0
            Top = 0
            Width = 608
            Height = 70
            Align = alClient
            Images = dmMain.MenuImages_NewLook
            Indent = 19
            MultiSelectStyle = []
            PopupMenu = DebugVarsPopup
            ReadOnly = True
            RightClickSelect = True
            TabOrder = 0
            OnKeyDown = DebugTreeKeyDown
          end
        end
        object tabDebugOutput: TTabSheet
          Caption = 'Output'
          ImageIndex = 2
          object DebugOutput: TMemo
            Left = 0
            Top = 22
            Width = 606
            Height = 47
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            PopupMenu = MessagePopup
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object DebuggerCmdPanel: TPanel
            Left = 0
            Top = 0
            Width = 606
            Height = 22
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object lblSendCommandDebugger: TLabel
              Left = 0
              Top = 2
              Width = 137
              Height = 13
              Caption = 'Send command to debugger:'
            end
            object edCommand: TEdit
              Left = 160
              Top = 0
              Width = 285
              Height = 21
              TabOrder = 0
              OnKeyPress = edCommandKeyPress
            end
            object btnSendCommand: TButton
              Left = 450
              Top = 0
              Width = 62
              Height = 21
              Caption = 'Send'
              TabOrder = 1
              OnClick = btnSendCommandClick
            end
          end
        end
      end
    end
    object FindSheet: TTabSheet
      BorderWidth = 2
      Caption = 'Find results'
      ImageIndex = 21
      object FindOutput: TListView
        Left = 0
        Top = 0
        Width = 616
        Height = 98
        Align = alClient
        BevelOuter = bvRaised
        BevelKind = bkSoft
        BorderStyle = bsNone
        Columns = <
          item
            Caption = 'Line'
            Width = 40
          end
          item
            Caption = 'Col'
            MinWidth = 20
            Width = 40
          end
          item
            Caption = 'Unit'
            Width = 200
          end
          item
            Caption = 'Message'
            Width = 450
          end>
        ColumnClick = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GridLines = True
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        ParentShowHint = False
        PopupMenu = MessagePopup
        ShowHint = True
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = FindOutputDblClick
        OnKeyDown = FindOutputKeyDown
      end
    end
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 16
    Width = 628
    Height = 86
    Align = alTop
    AutoDock = False
    AutoSize = True
    BevelInner = bvSpace
    RowSize = 28
    TabOrder = 1
    OnContextPopup = ControlBar1ContextPopup
    object tbMain: TToolBar
      Left = 11
      Top = 2
      Width = 177
      Height = 22
      AutoSize = True
      Caption = 'Main'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmMain.MenuImages_Gnome
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Wrapable = False
      object NewProjectBtn: TToolButton
        Left = 0
        Top = 0
        Action = actNewProject
      end
      object OpenBtn: TToolButton
        Left = 23
        Top = 0
        Action = actOpen
      end
      object ToolButton3: TToolButton
        Left = 46
        Top = 0
        Width = 8
        Caption = 'ToolButton3'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object NewFileBtn: TToolButton
        Left = 54
        Top = 0
        Action = actNewSource
      end
      object SaveUnitBtn: TToolButton
        Left = 77
        Top = 0
        Action = actSave
      end
      object SaveAllBtn: TToolButton
        Left = 100
        Top = 0
        Action = actSaveAll
      end
      object CloseBtn: TToolButton
        Left = 123
        Top = 0
        Action = actClose
      end
      object ToolButton7: TToolButton
        Left = 146
        Top = 0
        Width = 8
        Caption = 'ToolButton7'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object PrintBtn: TToolButton
        Left = 154
        Top = 0
        Action = actPrint
      end
    end
    object tbCompile: TToolBar
      Left = 11
      Top = 30
      Width = 130
      Height = 22
      AutoSize = True
      Caption = 'Compile and Run'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmMain.MenuImages_Gnome
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Wrapable = False
      object CompileBtn: TToolButton
        Left = 0
        Top = 0
        Action = actCompile
      end
      object RebuildAllBtn: TToolButton
        Left = 23
        Top = 0
        Action = actRebuild
      end
      object ToolButton2: TToolButton
        Left = 46
        Top = 0
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 49
        Style = tbsSeparator
      end
      object CompileAndRunBtn: TToolButton
        Left = 54
        Top = 0
        Action = actCompRun
      end
      object RunBtn: TToolButton
        Left = 77
        Top = 0
        Action = actRun
      end
      object ProgramResetBtn: TToolButton
        Left = 100
        Top = 0
        Action = actProgramReset
      end
    end
    object tbOptions: TToolBar
      Left = 317
      Top = 30
      Width = 46
      Height = 22
      AutoSize = True
      Caption = 'Options and help'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmMain.MenuImages_Gnome
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Wrapable = False
      object HelpBtn: TToolButton
        Left = 0
        Top = 0
        ImageIndex = 46
        OnClick = HelpBtnClick
      end
      object AboutBtn: TToolButton
        Left = 23
        Top = 0
        Action = actAbout
      end
    end
    object tbProject: TToolBar
      Left = 375
      Top = 2
      Width = 78
      Height = 22
      AutoSize = True
      Caption = 'Project'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmMain.MenuImages_Gnome
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Wrapable = False
      object AddToProjectBtn: TToolButton
        Left = 0
        Top = 0
        Action = actProjectAdd
      end
      object RemoveFromProjectBtn: TToolButton
        Left = 23
        Top = 0
        Action = actProjectRemove
      end
      object ToolButton20: TToolButton
        Left = 46
        Top = 0
        Width = 8
        Caption = 'ToolButton20'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object ProjectOptionsBtn: TToolButton
        Left = 54
        Top = 0
        Action = actProjectOptions
      end
    end
    object tbEdit: TToolBar
      Left = 201
      Top = 2
      Width = 47
      Height = 22
      AutoSize = True
      Caption = 'Edit'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmMain.MenuImages_Gnome
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Wrapable = False
      object UndoBtn: TToolButton
        Left = 0
        Top = 0
        Action = actUndo
      end
      object RedoBtn: TToolButton
        Left = 23
        Top = 0
        Action = actRedo
      end
    end
    object tbSearch: TToolBar
      Left = 261
      Top = 2
      Width = 101
      Height = 22
      AutoSize = True
      Caption = 'Search'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmMain.MenuImages_Gnome
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Wrapable = False
      object Findbtn: TToolButton
        Left = 0
        Top = 0
        Action = actFind
      end
      object Replacebtn: TToolButton
        Left = 23
        Top = 0
        Action = actReplace
      end
      object FindNextbtn: TToolButton
        Left = 46
        Top = 0
        Action = actFindNext
      end
      object ToolButton12: TToolButton
        Left = 69
        Top = 0
        Width = 8
        Caption = 'ToolButton12'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object GotoLineBtn: TToolButton
        Left = 77
        Top = 0
        Action = actGoto
      end
    end
    object tbSpecials: TToolBar
      Left = 376
      Top = 30
      Width = 231
      Height = 22
      AutoSize = True
      ButtonWidth = 60
      Caption = 'Specials'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmMain.SpecialImages_Gnome
      List = True
      ShowCaptions = True
      TabOrder = 6
      Wrapable = False
      object NewAllBtn: TToolButton
        Left = 0
        Top = 0
        Caption = 'New'
        ImageIndex = 0
        OnClick = NewAllBtnClick
      end
      object InsertBtn: TToolButton
        Left = 60
        Top = 0
        Caption = 'Insert'
        ImageIndex = 1
        OnClick = InsertBtnClick
      end
      object ToggleBtn: TToolButton
        Left = 120
        Top = 0
        Caption = 'Toggle'
        ImageIndex = 2
        OnClick = ToggleBtnClick
      end
      object GotoBtn: TToolButton
        Left = 180
        Top = 0
        Caption = 'Goto'
        ImageIndex = 3
        OnClick = GotoBtnClick
      end
    end
    object tbClasses: TToolBar
      Left = 11
      Top = 58
      Width = 466
      Height = 22
      AutoSize = True
      Caption = 'Classes'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      object cmbClasses: TComboBox
        Left = 0
        Top = 0
        Width = 232
        Height = 22
        Style = csDropDownList
        DropDownCount = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        Sorted = True
        TabOrder = 0
        OnChange = cmbClassesChange
      end
      object cmbMembers: TComboBox
        Left = 232
        Top = 0
        Width = 232
        Height = 22
        Style = csDropDownList
        DropDownCount = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        Sorted = True
        TabOrder = 1
        OnChange = cmbMembersChange
      end
    end
    object tbDebug: TToolBar
      Left = 154
      Top = 30
      Width = 150
      Height = 22
      AutoSize = True
      Caption = 'Debug'
      DragKind = dkDock
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = dmMain.MenuImages_Gnome
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      Wrapable = False
      object DebugBtn: TToolButton
        Left = 0
        Top = 0
        Action = actDebug
      end
      object DebugPauseBtn: TToolButton
        Left = 23
        Top = 0
        Action = actPauseDebug
      end
      object DebugStopBtn: TToolButton
        Left = 46
        Top = 0
        Action = actStopExecute
      end
      object DebugRestartBtn: TToolButton
        Left = 69
        Top = 0
        Action = actRestartDebug
      end
      object ToolButton1: TToolButton
        Left = 92
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 33
        Style = tbsSeparator
      end
      object DebugStepOver: TToolButton
        Left = 100
        Top = 0
        Action = actStepOver
      end
      object DebugStepInto: TToolButton
        Left = 123
        Top = 0
        Action = actStepInto
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 369
    Width = 628
    Height = 19
    Panels = <
      item
        Width = 70
      end
      item
        Width = 50
      end
      item
        Width = 80
      end
      item
        Width = 100
      end
      item
        Style = psOwnerDraw
        Width = 135
      end>
    ParentFont = True
    UseSystemFont = False
    OnDrawPanel = StatusBarDrawPanel
  end
  object pnlFull: TPanel
    Left = 0
    Top = 0
    Width = 628
    Height = 16
    Align = alTop
    BevelOuter = bvNone
    Caption = 
      'Dev-C++ version 5.0 full screen press shift+F12 to toggle Toolba' +
      'rs or F12 to go to normal mode.'
    TabOrder = 3
    Visible = False
    DesignSize = (
      628
      16)
    object btnFullScrRevert: TSpeedButton
      Left = 607
      Top = 0
      Width = 14
      Height = 14
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDD77
        7777D00DDDD00D777777D000DD000D777777DD000000DD777777DDD0000DDD77
        7777DDD0000DDD777777DD000000DD777777D000DD000D777777D00DDDD00D77
        7777DDDDDDDDDD777777}
      ParentFont = False
      OnClick = btnFullScrRevertClick
    end
  end
  object devFileMonitor1: TdevFileMonitor
    Left = 112
    Top = 152
    Width = 0
    Height = 0
    Active = False
    OnNotifyChange = devFileMonitor1NotifyChange
  end
  object prgFormProgress: TProgressBar
    Left = 488
    Top = 214
    Width = 134
    Height = 17
    TabOrder = 5
  end
  object LeftPageControl: TPageControl
    Left = 0
    Top = 102
    Width = 192
    Height = 137
    ActivePage = ProjectSheet
    Align = alLeft
    Images = dmMain.ProjectImage_NewLook
    TabOrder = 6
    object ProjectSheet: TTabSheet
      Caption = 'Project'
      ImageIndex = -1
      object ProjectView: TTreeView
        Left = 0
        Top = 0
        Width = 184
        Height = 109
        Align = alClient
        ChangeDelay = 1
        DragMode = dmAutomatic
        HideSelection = False
        HotTrack = True
        Images = dmMain.ProjectImage_Gnome
        Indent = 19
        MultiSelect = True
        MultiSelectStyle = [msControlSelect, msShiftSelect]
        ReadOnly = True
        RightClickSelect = True
        SortType = stText
        TabOrder = 0
        OnClick = ProjectViewClick
        OnCompare = ProjectViewCompare
        OnContextPopup = ProjectViewContextPopup
        OnDblClick = ProjectViewDblClick
        OnDragDrop = ProjectViewDragDrop
        OnDragOver = ProjectViewDragOver
        OnKeyDown = ProjectViewKeyDown
        OnKeyPress = ProjectViewKeyPress
        OnMouseDown = ProjectViewMouseDown
      end
    end
    object ClassSheet: TTabSheet
      Caption = 'Classes'
      ImageIndex = -1
      object ClassBrowser1: TClassBrowser
        Left = 0
        Top = 0
        Width = 184
        Height = 109
        Align = alClient
        Images = dmMain.ClassImages
        ReadOnly = True
        Indent = 19
        TabOrder = 0
        PopupMenu = BrowserPopup
        ShowFilter = sfAll
        OnSelect = ClassBrowser1Select
        Parser = CppParser1
        ItemImages.Globals = 0
        ItemImages.Classes = 1
        ItemImages.VariablePrivate = 2
        ItemImages.VariableProtected = 3
        ItemImages.VariablePublic = 4
        ItemImages.VariablePublished = 4
        ItemImages.MethodPrivate = 5
        ItemImages.MethodProtected = 6
        ItemImages.MethodPublic = 7
        ItemImages.MethodPublished = 7
        ItemImages.InheritedMethodProtected = 8
        ItemImages.InheritedMethodPublic = 10
        ItemImages.InheritedVariableProtected = 9
        ItemImages.InheritedVariablePublic = 11
        UseColors = True
        ShowInheritedMembers = False
      end
    end
  end
  object PageControl: TPageControl
    Left = 192
    Top = 102
    Width = 436
    Height = 137
    Align = alClient
    PopupMenu = EditorPopupMenu
    TabOrder = 7
    OnChange = PageControlChange
    OnChanging = PageControlChanging
    OnDragDrop = PageControlDragDrop
    OnDragOver = PageControlDragOver
    OnMouseDown = PageControlMouseDown
  end
  object MainMenu: TMainMenu
    Images = dmMain.MenuImages_Gnome
    Left = 493
    Top = 130
    object FileMenu: TMenuItem
      Action = actFileMenu
      object mnuNew: TMenuItem
        Caption = 'New'
        object NewSourceFileItem: TMenuItem
          Tag = 2
          Action = actNewSource
        end
        object NewWxDialogItem: TMenuItem
          Action = actNewwxDialog
        end
        object NewWxFrameItem: TMenuItem
          Action = actNewWxFrame
        end
        object N73: TMenuItem
          Caption = '-'
        end
        object NewprojectItem: TMenuItem
          Action = actNewProject
        end
        object N13: TMenuItem
          Caption = '-'
        end
        object NewresourcefileItem: TMenuItem
          Action = actNewRes
        end
        object NewTemplateItem: TMenuItem
          Action = actNewTemplate
        end
      end
      object N34: TMenuItem
        Caption = '-'
      end
      object OpenprojectItem: TMenuItem
        Tag = 1
        Action = actOpen
      end
      object ReOpenItem: TMenuItem
        AutoHotkeys = maManual
        Caption = '&Reopen'
        ImageIndex = 39
        object ClearhistoryItem: TMenuItem
          Action = actHistoryClear
        end
        object N11: TMenuItem
          Caption = '-'
          Enabled = False
        end
      end
      object N12: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object SaveUnitItem: TMenuItem
        Tag = 3
        Action = actSave
      end
      object SaveUnitAsItem: TMenuItem
        Action = actSaveAs
      end
      object SaveprojectasItem: TMenuItem
        Action = actSaveProjectAs
      end
      object SaveallItem: TMenuItem
        Action = actSaveAll
      end
      object N33: TMenuItem
        Caption = '-'
      end
      object CloseItem: TMenuItem
        Tag = 4
        Action = actClose
      end
      object CloseAll2: TMenuItem
        Action = actCloseAll
      end
      object CloseprojectItem: TMenuItem
        Action = actCloseProject
      end
      object N35: TMenuItem
        Caption = '-'
      end
      object Properties1: TMenuItem
        Action = actFileProperties
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object ImportItem: TMenuItem
        Caption = '&Import'
        object ImportMSVisualCproject1: TMenuItem
          Action = actImportMSVC
        end
      end
      object ExportItem: TMenuItem
        Caption = '&Export'
        ImageIndex = 12
        object HTMLItem: TMenuItem
          Action = actXHTML
        end
        object RTFItem: TMenuItem
          Action = actXRTF
        end
        object N19: TMenuItem
          Caption = '-'
        end
        object ProjecttoHTMLItem: TMenuItem
          Action = actXProject
        end
      end
      object N43: TMenuItem
        Caption = '-'
      end
      object PrintItem: TMenuItem
        Tag = 5
        Action = actPrint
      end
      object PrinterSetupItem: TMenuItem
        Action = actPrintSU
      end
      object N3: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object ExitItem: TMenuItem
        Action = actExit
        GroupIndex = 9
      end
    end
    object EditMenu: TMenuItem
      Action = actEditMenu
      object UndoItem: TMenuItem
        Tag = 6
        Action = actUndo
      end
      object RedoItem: TMenuItem
        Action = actRedo
      end
      object N4: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object CutItem: TMenuItem
        Action = actCut
        AutoHotkeys = maAutomatic
        AutoLineReduction = maAutomatic
      end
      object CopyItem: TMenuItem
        Action = actCopy
      end
      object PasteItem: TMenuItem
        Action = actPaste
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object Swapheadersource2: TMenuItem
        Action = actSwapHeaderSource
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object InsertItem: TMenuItem
        Caption = '&Insert'
        object DateTimeMenuItem: TMenuItem
          Caption = '&Date/Time'
          OnClick = DateTimeMenuItemClick
        end
        object CommentheaderMenuItem: TMenuItem
          Caption = '&Comment header'
          OnClick = CommentheaderMenuItemClick
        end
      end
      object ToggleBookmarksItem: TMenuItem
        Caption = 'Toggle &Bookmarks'
        ImageIndex = 19
      end
      object GotoBookmarksItem: TMenuItem
        Caption = '&Goto Bookmarks'
        ImageIndex = 20
      end
      object N5: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object SelectallItem: TMenuItem
        Action = actSelectAll
      end
      object N26: TMenuItem
        Caption = '-'
      end
      object Comment1: TMenuItem
        Action = actComment
        ShortCut = 16574
      end
      object Uncomment1: TMenuItem
        Action = actUncomment
        ShortCut = 16556
      end
      object N27: TMenuItem
        Caption = '-'
      end
      object Indent1: TMenuItem
        Action = actIndent
      end
      object Unindent1: TMenuItem
        Action = actUnindent
      end
    end
    object SearchMenu: TMenuItem
      Action = actSearchMenu
      object FindItem: TMenuItem
        Tag = 7
        Action = actFind
      end
      object FindinallfilesItem: TMenuItem
        Action = actFindAll
      end
      object FindnextItem: TMenuItem
        Action = actFindNext
      end
      object ReplaceItem: TMenuItem
        Action = actReplace
      end
      object IncrementalSearch1: TMenuItem
        Action = actIncremental
      end
      object N7: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object Gotofunction1: TMenuItem
        Action = actGotoFunction
      end
      object GotolineItem: TMenuItem
        Action = actGoto
      end
    end
    object ViewMenu: TMenuItem
      Action = actViewMenu
      object StatusbarItem: TMenuItem
        Action = actStatusbar
        AutoCheck = True
      end
      object ToDolist1: TMenuItem
        Action = actViewToDoList
      end
      object ToolbarsItem: TMenuItem
        Caption = '&Toolbars'
        ImageIndex = 44
        object ToolMainItem: TMenuItem
          AutoCheck = True
          Caption = '&Main'
          Checked = True
          OnClick = ToolbarClick
        end
        object ToolEditItem: TMenuItem
          AutoCheck = True
          Caption = 'Edit'
          Checked = True
          OnClick = ToolbarClick
        end
        object ToolSearchItem: TMenuItem
          AutoCheck = True
          Caption = 'Search'
          Checked = True
          OnClick = ToolbarClick
        end
        object N2: TMenuItem
          Caption = '-'
        end
        object ToolCompileandRunItem: TMenuItem
          AutoCheck = True
          Caption = '&Compile and Run'
          Checked = True
          OnClick = ToolbarClick
        end
        object ToolDebugItem: TMenuItem
          AutoCheck = True
          Caption = '&Debug'
          Checked = True
          OnClick = ToolbarClick
        end
        object ToolProjectItem: TMenuItem
          AutoCheck = True
          Caption = '&Project'
          Checked = True
          OnClick = ToolbarClick
        end
        object N9: TMenuItem
          Caption = '-'
        end
        object ToolOptionItem: TMenuItem
          AutoCheck = True
          Caption = '&Options and help'
          Checked = True
          OnClick = ToolbarClick
        end
        object ToolSpecialsItem: TMenuItem
          AutoCheck = True
          Caption = '&Specials'
          Checked = True
          OnClick = ToolbarClick
        end
        object N17: TMenuItem
          Caption = '-'
        end
        object ToolClassesItem: TMenuItem
          AutoCheck = True
          Caption = 'Classes'
          Checked = True
          OnClick = ToolbarClick
        end
      end
      object N63: TMenuItem
        Caption = '-'
      end
      object ShowProjectInspItem: TMenuItem
        Caption = 'Show &Project Inspector'
        OnClick = ShowProjectInspItemClick
      end
      object N57: TMenuItem
        Caption = '-'
      end
      object GotoprojectmanagerItem: TMenuItem
        Caption = 'Go to Project &Inspector'
        ShortCut = 16497
        OnClick = actGotoProjectManagerExecute
      end
      object GoToClassBrowserItem: TMenuItem
        Caption = 'Go to Class &Browser'
        ShortCut = 16498
        OnClick = GoToClassBrowserItemClick
      end
    end
    object ProjectMenu: TMenuItem
      Action = actProjectMenu
      object NewunitinprojectItem: TMenuItem
        Tag = 2
        Action = actProjectNew
      end
      object AddtoprojectItem: TMenuItem
        Action = actProjectAdd
      end
      object RemovefromprojectItem: TMenuItem
        Action = actProjectRemove
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object ProjectoptionsItem: TMenuItem
        Action = actProjectOptions
      end
    end
    object ExecuteMenu: TMenuItem
      Action = actExecuteMenu
      object CompileItem: TMenuItem
        Tag = 8
        Action = actCompile
      end
      object Compilecurrentfile1: TMenuItem
        Action = actCompileCurrentFile
      end
      object RunItem: TMenuItem
        Tag = 9
        Action = actRun
      end
      object mnuExecParameters: TMenuItem
        Action = actExecParams
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object CompileandRunItem: TMenuItem
        Action = actCompRun
      end
      object RebuildallItem: TMenuItem
        Action = actRebuild
      end
      object SyntaxCheckItem: TMenuItem
        Action = actSyntaxCheck
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object CleanItem: TMenuItem
        Action = actClean
      end
      object N29: TMenuItem
        Caption = '-'
      end
      object Profileanalysis1: TMenuItem
        Action = actProfileProject
      end
      object N25: TMenuItem
        Caption = '-'
      end
      object Programreset1: TMenuItem
        Action = actProgramReset
      end
    end
    object DebugMenu: TMenuItem
      Action = actDebugMenu
      object DebugItem: TMenuItem
        Tag = 10
        Action = actDebug
      end
      object Pause1: TMenuItem
        Action = actPauseDebug
      end
      object StopExecution1: TMenuItem
        Action = actStopExecute
        ShortCut = 49265
      end
      object Restart1: TMenuItem
        Action = actRestartDebug
      end
      object AttachtoprocessItem: TMenuItem
        Action = actAttachProcess
      end
      object N18: TMenuItem
        Caption = '-'
      end
      object TogglebreakpointItem: TMenuItem
        Action = actBreakPoint
      end
      object DbgStepOver: TMenuItem
        Action = actStepOver
      end
      object DbgStepInto: TMenuItem
        Action = actStepInto
        ShortCut = 8310
      end
      object RuntocursorItem: TMenuItem
        Action = actRunToCursor
        ShortCut = 8307
      end
      object N21: TMenuItem
        Caption = '-'
      end
      object AddwatchItem: TMenuItem
        Action = actAddWatch
      end
      object WatchItem: TMenuItem
        Action = actWatchItem
        GroupIndex = 9
      end
      object ViewCPUItem: TMenuItem
        Action = actViewCPU
        GroupIndex = 9
      end
    end
    object ToolsMenu: TMenuItem
      Action = actToolsMenu
      GroupIndex = 9
      object CompileroptionsItem: TMenuItem
        Tag = 11
        Action = actCompOptions
      end
      object EnvironmentoptionsItem: TMenuItem
        Tag = 12
        Action = actEnviroOptions
      end
      object EditorOptions1: TMenuItem
        Action = actEditorOptions
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object Configureshortcuts1: TMenuItem
        Action = actConfigShortcuts
      end
      object ConfiguretoolsItem: TMenuItem
        Action = actConfigTools
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object CheckforupdatesItem: TMenuItem
        Action = actUpdateCheck
      end
      object mnuToolSep1: TMenuItem
        Caption = '-'
      end
      object PackageManagerItem: TMenuItem
        Bitmap.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000BFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000000000000
          0000000000000000000000000000000000000000000000000000BFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBF000000DFDFDFB8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8
          B8B8B8B8969696000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF000000F3F3F3DF
          DFDFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFB8B8B8000000BFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBF000000F3F3F3DFDFDF656565CFCFCF6565656565656565
          65CFCFCFB8B8B8000000000000000000000000000000000000000000F3F3F3DF
          DFDFDFDFDFDFDFDFDFDFDFCFCFCFCFCFCFCFCFCFB8B8B80000000000004CC6FF
          4CB5E64CB5E64CB5E6000000F3F3F3DFDFDF656565656565DFDFDF6565656565
          65CFCFCFB8B8B80000000000008DDBFF4CC6FF4CC6FF4CC6FF000000FFFFFFF3
          F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3DFDFDF0000000000008DDBFF
          4CC6FF4CC6FF4CC6FF6868680000000000000000000000000000000000000000
          000000000000000000000000008DDBFF4CC6FF4CC6FF4CC6FF4CC6FF4CC6FF24
          607B4CC6FF4CC6FF4CC6FF4CC6FF4CC6FF4CB5E6000000BFBFBF000000296D8C
          24607B24607B24607B24607B24607B24607B24607B24607B24607B24607B2460
          7B1F536B000000BFBFBF0000008DDBFF4CC6FF4CC6FF4CC6FF4CC6FF4CC6FF24
          607B4CC6FF4CC6FF226C8B226C8B226C8B4CB5E6000000BFBFBF0000008DDBFF
          4CC6FF4CC6FF4CC6FF4CC6FF4CC6FF24607B4CC6FF4CC6FF226C8B226C8B226C
          8B4CB5E6000000BFBFBF0000008DDBFF4CC6FF4CC6FF4CC6FF4CC6FF4CC6FF24
          607B4CC6FF4CC6FF226C8B226C8B226C8B4CB5E6000000BFBFBF000000D1F1FF
          8DDBFF8DDBFF8DDBFF8DDBFF8DDBFF296D8C8DDBFF8DDBFF8DDBFF8DDBFF8DDB
          FF4CC6FF000000BFBFBF68686800000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000BFBFBF}
        Caption = '&Package Manager'
        OnClick = PackageManagerItemClick
      end
    end
    object mnuCVS: TMenuItem
      Caption = 'CVS'
      GroupIndex = 9
      OnClick = mnuCVSClick
      object mnuCVSCurrent: TMenuItem
        Caption = 'Current File...'
        object mnuCVSUpdate: TMenuItem
          Tag = 3
          Action = actCVSUpdate
        end
        object mnuCVSDiff: TMenuItem
          Tag = 3
          Action = actCVSDiff
        end
        object N53: TMenuItem
          Caption = '-'
        end
        object mnuCVSCommit: TMenuItem
          Tag = 3
          Action = actCVSCommit
        end
        object N56: TMenuItem
          Caption = '-'
        end
        object mnuCVSLog: TMenuItem
          Tag = 3
          Action = actCVSLog
        end
        object N61: TMenuItem
          Caption = '-'
        end
        object mnuCVSAdd: TMenuItem
          Tag = 3
          Action = actCVSAdd
        end
        object mnuCVSRemove: TMenuItem
          Tag = 3
          Action = actCVSRemove
        end
      end
      object mnuCVSWhole: TMenuItem
        Caption = 'Whole Project...'
        object mnuCVSUpdateP: TMenuItem
          Tag = 4
          Action = actCVSUpdate
        end
        object mnuCVSDiffP: TMenuItem
          Tag = 4
          Action = actCVSDiff
        end
        object N58: TMenuItem
          Caption = '-'
        end
        object Commit1: TMenuItem
          Tag = 4
          Action = actCVSCommit
        end
        object N46: TMenuItem
          Caption = '-'
        end
        object mnuCVSLogP: TMenuItem
          Tag = 4
          Action = actCVSLog
        end
      end
      object N65: TMenuItem
        Caption = '-'
      end
      object Login1: TMenuItem
        Action = actCVSLogin
      end
      object Logout1: TMenuItem
        Action = actCVSLogout
      end
      object N66: TMenuItem
        Caption = '-'
      end
      object mnuCVSImportP: TMenuItem
        Tag = 4
        Action = actCVSImport
      end
      object mnuCVSCheckoutP: TMenuItem
        Tag = 4
        Action = actCVSCheckout
      end
    end
    object WindowMenu: TMenuItem
      Action = actWindowMenu
      GroupIndex = 9
      object CloseAllItem: TMenuItem
        Action = actCloseAll
      end
      object N28: TMenuItem
        Caption = '-'
      end
      object FullscreenmodeItem: TMenuItem
        Action = actFullScreen
        AutoCheck = True
        Enabled = False
      end
      object N36: TMenuItem
        Caption = '-'
      end
      object NextItem: TMenuItem
        Action = actNext
      end
      object PreviousItem: TMenuItem
        Action = actPrev
      end
      object N32: TMenuItem
        Caption = '-'
      end
      object ListItem: TMenuItem
        Caption = '&List...'
        OnClick = ListItemClick
      end
    end
    object HelpMenu: TMenuItem
      Action = actHelpMenu
      SubMenuImages = dmMain.HelpImages_Gnome
      GroupIndex = 9
      object HelpMenuItem: TMenuItem
        Caption = '&Help on Dev-C++'
        OnClick = HelpMenuItemClick
      end
      object HelpSep1: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object HelpSep2: TMenuItem
        Caption = '-'
      end
      object Customize1: TMenuItem
        Action = actHelpCustomize
      end
      object ips1: TMenuItem
        Action = actShowTips
      end
      object AboutDevCppItem: TMenuItem
        Tag = 18
        Action = actAbout
      end
    end
  end
  object EditorPopupMenu: TPopupMenu
    Images = dmMain.MenuImages_Gnome
    Left = 603
    Top = 102
    object Close1: TMenuItem
      Action = actClose
    end
    object CloseAll1: TMenuItem
      Action = actCloseAll
    end
    object Closeallexceptthis1: TMenuItem
      Action = actCloseAllButThis
    end
    object N16: TMenuItem
      Caption = '-'
    end
    object UndoPopItem: TMenuItem
      Action = actUndo
    end
    object RedoPopItem: TMenuItem
      Action = actRedo
    end
    object MenuItem1: TMenuItem
      Caption = '-'
    end
    object CutPopItem: TMenuItem
      Action = actCut
    end
    object CopyPopItem: TMenuItem
      Action = actCopy
    end
    object PastePopItem: TMenuItem
      Action = actPaste
    end
    object SelectAllPopItem: TMenuItem
      Action = actSelectAll
    end
    object DeletePopItem: TMenuItem
      Action = actDelete
    end
    object N22: TMenuItem
      Caption = '-'
    end
    object Swapheadersource1: TMenuItem
      Action = actSwapHeaderSource
      ShortCut = 16456
    end
    object MenuItem2: TMenuItem
      Caption = '-'
    end
    object InsertPopItem: TMenuItem
      Caption = '&Insert'
      object CommentheaderPopItem: TMenuItem
        Caption = 'Comment header'
      end
      object DateandtimePopItem: TMenuItem
        Caption = 'Date and time'
      end
      object MenuItem3: TMenuItem
        Caption = '-'
      end
      object MainfunctionPopItem: TMenuItem
        Caption = 'Main function'
      end
      object WinMainfunctionPopItem: TMenuItem
        Caption = 'WinMain function'
      end
      object MenuItem4: TMenuItem
        Caption = '-'
      end
      object ifdefPopItem: TMenuItem
        Caption = '#ifdef'
      end
      object ifndefPopItem: TMenuItem
        Caption = '#ifndef'
      end
      object includePopItem: TMenuItem
        Caption = '#include'
      end
      object MenuItem5: TMenuItem
        Caption = '-'
      end
      object ifPopItem: TMenuItem
        Caption = 'if ()'
      end
      object whilePopItem: TMenuItem
        Caption = 'while ()'
      end
      object dowhilePopItem: TMenuItem
        Caption = 'do..while ()'
      end
      object forPopItem: TMenuItem
        Caption = 'for ()'
      end
      object MenuItem6: TMenuItem
        Caption = '-'
      end
      object MessageBoxPopItem: TMenuItem
        Caption = 'MessageBox'
      end
    end
    object SurroundWithPopItem: TMenuItem
      Caption = 'Surround With'
      object trycatchPopItem: TMenuItem
        Caption = 'try...catch'
      end
      object tryfinallyPopItem: TMenuItem
        Caption = 'try...finally'
      end
      object trycatchfinallyPopItem: TMenuItem
        Caption = 'try...catch...finally'
      end
      object N68: TMenuItem
        Caption = '-'
      end
      object forloopPopItem: TMenuItem
        Caption = 'for'
      end
      object forintloopPopItem: TMenuItem
        Caption = 'for(int i...'
      end
      object whileLoopPopItem: TMenuItem
        Caption = 'while'
      end
      object dowhileLoopPopItem: TMenuItem
        Caption = 'do..while'
      end
      object N71: TMenuItem
        Caption = '-'
      end
      object ifLoopPopItem: TMenuItem
        Caption = 'if'
      end
      object ifelseloopPopItem: TMenuItem
        Caption = 'if...else'
      end
      object switchLoopPopItem: TMenuItem
        Caption = 'switch'
      end
      object N72: TMenuItem
        Caption = '-'
      end
      object bracesPopItem: TMenuItem
        Caption = '{..}'
      end
      object N69: TMenuItem
        Caption = '-'
      end
      object CStyleCommentPopItem: TMenuItem
        Caption = 'C Style Comment'
      end
      object CppStyleCommentPopItem: TMenuItem
        Caption = 'C++ Style Comment'
      end
    end
    object N70: TMenuItem
      Caption = '-'
    end
    object TogglebookmarksPopItem: TMenuItem
      Caption = '&Toggle bookmarks'
    end
    object GotobookmarksPopItem: TMenuItem
      Caption = '&Goto bookmarks'
    end
    object N41: TMenuItem
      Caption = '-'
    end
    object ToggleBreakpointPopupItem: TMenuItem
      Action = actBreakPoint
    end
    object AddWatchPopupItem: TMenuItem
      Action = actAddWatch
    end
    object Runtocursor1: TMenuItem
      Action = actRunToCursor
    end
    object N38: TMenuItem
      Caption = '-'
    end
    object AddToDoitem1: TMenuItem
      Action = actAddToDo
    end
    object N45: TMenuItem
      Caption = '-'
    end
    object CVS1: TMenuItem
      Caption = 'CVS'
      object mnuCVSUpdate3: TMenuItem
        Tag = 3
        Action = actCVSUpdate
      end
      object mnuCVSDiff3: TMenuItem
        Tag = 3
        Action = actCVSDiff
      end
      object N60: TMenuItem
        Caption = '-'
      end
      object mnuCVSCommit3: TMenuItem
        Tag = 3
        Action = actCVSCommit
      end
      object N47: TMenuItem
        Caption = '-'
      end
      object mnuCVSLog3: TMenuItem
        Tag = 3
        Action = actCVSLog
      end
    end
    object N50: TMenuItem
      Caption = '-'
    end
    object mnuFileProps: TMenuItem
      Action = actFileProperties
    end
  end
  object UnitPopup: TPopupMenu
    Images = dmMain.MenuImages_Gnome
    MenuAnimation = [maBottomToTop]
    Left = 548
    Top = 102
    object RemoveFilefromprojectPopItem: TMenuItem
      Action = actUnitRemove
    end
    object RenamefilePopItem: TMenuItem
      Action = actUnitRename
    end
    object N30: TMenuItem
      Caption = '-'
    end
    object OpenPopItem: TMenuItem
      Action = actUnitOpen
    end
    object mnuOpenWith: TMenuItem
      Caption = 'Open with'
      OnClick = mnuOpenWithClick
    end
    object ClosefilePopItem: TMenuItem
      Action = actUnitClose
    end
    object N40: TMenuItem
      Caption = '-'
    end
    object Addfile1: TMenuItem
      Action = actProjectAdd
    end
    object N44: TMenuItem
      Caption = '-'
    end
    object Addfolder1: TMenuItem
      Action = actProjectNewFolder
    end
    object Renamefolder1: TMenuItem
      Action = actProjectRenameFolder
    end
    object Removefolder1: TMenuItem
      Action = actProjectRemoveFolder
    end
    object N49: TMenuItem
      Caption = '-'
    end
    object CVS3: TMenuItem
      Caption = 'CVS'
      object mnuCVSUpdate2: TMenuItem
        Tag = 2
        Action = actCVSUpdate
      end
      object mnuCVSDiff2: TMenuItem
        Tag = 2
        Action = actCVSDiff
      end
      object N52: TMenuItem
        Caption = '-'
      end
      object mnuCVSCommit2: TMenuItem
        Tag = 2
        Action = actCVSCommit
      end
      object N51: TMenuItem
        Caption = '-'
      end
      object mnuCVSLog2: TMenuItem
        Tag = 2
        Action = actCVSLog
      end
      object N62: TMenuItem
        Caption = '-'
      end
      object mnuCVSAdd2: TMenuItem
        Tag = 2
        Action = actCVSAdd
      end
      object mnuCVSRemove2: TMenuItem
        Tag = 2
        Action = actCVSRemove
      end
    end
    object N54: TMenuItem
      Caption = '-'
    end
    object mnuUnitProperties: TMenuItem
      Action = actFileProperties
    end
  end
  object ProjectPopup: TPopupMenu
    Images = dmMain.MenuImages_Gnome
    MenuAnimation = [maBottomToTop]
    Left = 576
    Top = 102
    object NewunitinprojectPopItem: TMenuItem
      Tag = 2
      Action = actProjectNew
    end
    object AddtoprojectPopItem: TMenuItem
      Action = actProjectAdd
    end
    object RemovefromprojectPopItem: TMenuItem
      Action = actProjectRemove
    end
    object N39: TMenuItem
      Caption = '-'
    end
    object Newfolder1: TMenuItem
      Action = actProjectNewFolder
    end
    object MenuItem18: TMenuItem
      Caption = '-'
    end
    object ProjectoptionsPopItem: TMenuItem
      Action = actProjectOptions
    end
    object N48: TMenuItem
      Caption = '-'
    end
    object CVS2: TMenuItem
      Caption = 'CVS'
      object mnuCVSUpdate1: TMenuItem
        Tag = 1
        Action = actCVSUpdate
      end
      object mnuCVSDiff1: TMenuItem
        Tag = 1
        Action = actCVSDiff
      end
      object N59: TMenuItem
        Caption = '-'
      end
      object mnuCVSCommit1: TMenuItem
        Tag = 1
        Action = actCVSCommit
      end
      object N55: TMenuItem
        Caption = '-'
      end
      object mnuCVSLog1: TMenuItem
        Tag = 1
        Action = actCVSLog
      end
    end
  end
  object HelpPop: TPopupMenu
    Left = 465
    Top = 102
    object HelponDevPopupItem: TMenuItem
      Caption = '&Help on Dev-C++'
      OnClick = HelpMenuItemClick
    end
    object N64: TMenuItem
      Caption = '-'
    end
  end
  object alMain: TActionList
    Images = dmMain.MenuImages_Gnome
    Left = 521
    Top = 130
    object actViewCPU: TAction
      Category = 'Debug'
      Caption = '&View CPU Window'
      OnExecute = ViewCPUItemClick
      OnUpdate = actUpdateDebuggerRunning
    end
    object actNewSource: TAction
      Tag = 1
      Category = 'File'
      Caption = '&Source File'
      ImageIndex = 1
      ShortCut = 16462
      OnExecute = actNewSourceExecute
    end
    object actNewProject: TAction
      Tag = 2
      Category = 'File'
      Caption = '&Project...'
      ImageIndex = 0
      OnExecute = actNewProjectExecute
    end
    object actRunToCursor: TAction
      Category = 'Debug'
      Caption = 'Run to &cursor'
      ImageIndex = 24
      ShortCut = 16499
      OnExecute = actRunToCursorExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actNewRes: TAction
      Tag = 3
      Category = 'File'
      Caption = '&Resource File'
      ImageIndex = 2
      OnExecute = actNewResExecute
    end
    object actNewTemplate: TAction
      Tag = 4
      Category = 'File'
      Caption = '&Template...'
      ImageIndex = 3
      OnExecute = actNewTemplateExecute
      OnUpdate = actNewTemplateUpdate
    end
    object actOpen: TAction
      Tag = 1
      Category = 'File'
      Caption = '&Open project or file...'
      ImageIndex = 4
      ShortCut = 16463
      OnExecute = actOpenExecute
    end
    object actHistoryClear: TAction
      Tag = 2
      Category = 'File'
      Caption = '&Clear History'
      ImageIndex = 5
      OnExecute = actHistoryClearExecute
    end
    object actSave: TAction
      Tag = 3
      Category = 'File'
      Caption = '&Save'
      ImageIndex = 6
      ShortCut = 16467
      OnExecute = actSaveExecute
      OnUpdate = actSaveUpdate
    end
    object actSaveAs: TAction
      Tag = 4
      Category = 'File'
      Caption = 'Save &As'
      ImageIndex = 7
      ShortCut = 16507
      OnExecute = actSaveAsExecute
      OnUpdate = actSaveAsUpdate
    end
    object actSaveProjectAs: TAction
      Category = 'File'
      Caption = 'Save project as...'
      ImageIndex = 7
      OnExecute = actSaveProjectAsExecute
      OnUpdate = actUpdateProject
    end
    object actSaveAll: TAction
      Tag = 5
      Category = 'File'
      Caption = 'Save A&ll'
      ImageIndex = 8
      OnExecute = actSaveAllExecute
      OnUpdate = actUpdatePageorProject
    end
    object actClose: TAction
      Tag = 7
      Category = 'File'
      Caption = '&Close'
      ImageIndex = 9
      ShortCut = 16499
      OnExecute = actCloseExecute
      OnUpdate = actUpdatePageCount
    end
    object actCloseAll: TAction
      Tag = 11
      Category = 'File'
      Caption = 'Close All'
      OnExecute = actCloseAllExecute
      OnUpdate = actUpdatePageCount
    end
    object actCloseProject: TAction
      Tag = 6
      Category = 'File'
      Caption = 'Close Project'
      OnExecute = actCloseProjectExecute
      OnUpdate = actUpdateProject
    end
    object actXHTML: TAction
      Tag = 1
      Category = 'File'
      Caption = 'to &HTML'
      OnExecute = actXHTMLExecute
      OnUpdate = actUpdatePageCount
    end
    object actXRTF: TAction
      Tag = 2
      Category = 'File'
      Caption = 'to &RTF'
      OnExecute = actXRTFExecute
      OnUpdate = actUpdatePageCount
    end
    object actXProject: TAction
      Tag = 3
      Category = 'File'
      Caption = '&Project to HTML'
      OnExecute = actXProjectExecute
      OnUpdate = actUpdateProject
    end
    object actPrint: TAction
      Tag = 8
      Category = 'File'
      Caption = '&Print'
      ImageIndex = 10
      ShortCut = 16464
      OnExecute = actPrintExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actPrintSU: TAction
      Tag = 9
      Category = 'File'
      Caption = 'Prin&ter Setup...'
      OnExecute = actPrintSUExecute
    end
    object actExit: TAction
      Tag = 10
      Category = 'File'
      Caption = 'E&xit Dev-C++'
      ImageIndex = 11
      OnExecute = actExitExecute
    end
    object actUndo: TAction
      Tag = 1
      Category = 'Edit'
      Caption = '&Undo'
      ImageIndex = 13
      ShortCut = 16474
      OnExecute = actUndoExecute
      OnUpdate = actUndoUpdate
    end
    object actRedo: TAction
      Tag = 2
      Category = 'Edit'
      Caption = '&Redo'
      ImageIndex = 14
      ShortCut = 24666
      OnExecute = actRedoExecute
      OnUpdate = actRedoUpdate
    end
    object actCut: TAction
      Tag = 3
      Category = 'Edit'
      Caption = 'C&ut'
      ImageIndex = 15
      ShortCut = 16472
      OnExecute = actCutExecute
      OnUpdate = actCutUpdate
    end
    object actCopy: TAction
      Tag = 4
      Category = 'Edit'
      Caption = '&Copy'
      ImageIndex = 16
      ShortCut = 16451
      OnExecute = actCopyExecute
      OnUpdate = actCopyUpdate
    end
    object actPaste: TAction
      Tag = 5
      Category = 'Edit'
      Caption = '&Paste'
      ImageIndex = 17
      ShortCut = 16470
      OnExecute = actPasteExecute
      OnUpdate = actPasteUpdate
    end
    object actSelectAll: TAction
      Tag = 6
      Category = 'Edit'
      Caption = '&Select All'
      ShortCut = 16449
      OnExecute = actSelectAllExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actDelete: TAction
      Category = 'Edit'
      Caption = 'Delete'
      OnExecute = actDeleteExecute
    end
    object actFind: TAction
      Tag = 1
      Category = 'Search'
      Caption = '&Find'
      ImageIndex = 21
      ShortCut = 16454
      OnExecute = actFindExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actFindAll: TAction
      Tag = 2
      Category = 'Search'
      Caption = 'Fin&d in all Files'
      ShortCut = 41030
      OnExecute = actFindAllExecute
      OnUpdate = actUpdatePageorProject
    end
    object actReplace: TAction
      Tag = 3
      Category = 'Search'
      Caption = '&Replace'
      ImageIndex = 22
      ShortCut = 16466
      OnExecute = actReplaceExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actFindNext: TAction
      Tag = 4
      Category = 'Search'
      Caption = '&Search Again'
      ImageIndex = 23
      ShortCut = 114
      OnExecute = actFindNextExecute
      OnUpdate = actFindNextUpdate
    end
    object actIncremental: TAction
      Category = 'Search'
      Caption = 'Incremental Search'
      ShortCut = 16457
      OnExecute = actIncrementalExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actGoto: TAction
      Tag = 5
      Category = 'Search'
      Caption = '&Go to line...'
      ImageIndex = 24
      ShortCut = 16455
      OnExecute = actGotoExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actStatusbar: TAction
      Category = 'View'
      AutoCheck = True
      Caption = '&Statusbar'
      OnExecute = actStatusbarExecute
    end
    object actProjectNew: TAction
      Tag = 1
      Category = 'Project'
      Caption = '&New Unit'
      ImageIndex = 1
      OnExecute = actProjectNewExecute
      OnUpdate = actUpdateProject
    end
    object actProjectAdd: TAction
      Tag = 2
      Category = 'Project'
      Caption = '&Add file...'
      ImageIndex = 25
      OnExecute = actProjectAddExecute
      OnUpdate = actUpdateProject
    end
    object actProjectRemove: TAction
      Tag = 3
      Category = 'Project'
      Caption = '&Remove file...'
      ImageIndex = 26
      OnExecute = actProjectRemoveExecute
      OnUpdate = actUpdateProject
    end
    object actProjectOptions: TAction
      Tag = 5
      Category = 'Project'
      Caption = '&Options...'
      ImageIndex = 27
      ShortCut = 32848
      OnExecute = actProjectOptionsExecute
      OnUpdate = actUpdateProject
    end
    object actProjectMakeFile: TAction
      Category = 'Project'
      Caption = 'Edit &Makefile'
      OnExecute = actProjectMakeFileExecute
      OnUpdate = actUpdateProject
    end
    object actProjectSource: TAction
      Tag = 6
      Category = 'Project'
      Caption = 'Source'
      OnExecute = actProjectSourceExecute
      OnUpdate = actUpdateProject
    end
    object actCompile: TAction
      Tag = 1
      Category = 'Execute'
      Caption = '&Compile'
      ImageIndex = 28
      ShortCut = 16504
      OnExecute = actCompileExecute
      OnUpdate = actCompileUpdate
    end
    object actRun: TAction
      Tag = 2
      Category = 'Execute'
      Caption = '&Run'
      ImageIndex = 31
      ShortCut = 16505
      OnExecute = actRunExecute
      OnUpdate = actRunUpdate
    end
    object actCompRun: TAction
      Tag = 3
      Category = 'Execute'
      Caption = 'Compile &and Run'
      ImageIndex = 33
      ShortCut = 120
      OnExecute = actCompRunExecute
      OnUpdate = actRunUpdate
    end
    object actRebuild: TAction
      Tag = 4
      Category = 'Execute'
      Caption = 'R&ebuild All'
      ImageIndex = 30
      ShortCut = 16506
      OnExecute = actRebuildExecute
      OnUpdate = actCompileUpdate
    end
    object actClean: TAction
      Tag = 5
      Category = 'Execute'
      Caption = 'C&lean'
      OnExecute = actCleanExecute
      OnUpdate = actCompileUpdate
    end
    object actDebug: TAction
      Tag = 6
      Category = 'Debug'
      Caption = '&Run'
      ImageIndex = 54
      ShortCut = 119
      OnExecute = actDebugExecute
      OnUpdate = actDebugUpdate
    end
    object actCompOptions: TAction
      Tag = 1
      Category = 'Tools'
      Caption = '&Compiler Options...'
      ImageIndex = 34
      OnExecute = actCompOptionsExecute
    end
    object actEnviroOptions: TAction
      Tag = 2
      Category = 'Tools'
      Caption = '&Environment Options...'
      ImageIndex = 35
      OnExecute = actEnviroOptionsExecute
    end
    object actEditorOptions: TAction
      Tag = 3
      Category = 'Tools'
      Caption = 'E&ditor Options...'
      ImageIndex = 36
      OnExecute = actEditorOptionsExecute
    end
    object actConfigTools: TAction
      Tag = 4
      Category = 'Tools'
      Caption = 'Configure &Tools...'
      ImageIndex = 37
      OnExecute = actConfigToolsExecute
    end
    object actFullScreen: TAction
      Tag = 1
      Category = 'Window'
      AutoCheck = True
      Caption = '&Full screen mode'
      ImageIndex = 38
      ShortCut = 123
      OnExecute = actFullScreenExecute
    end
    object actNext: TAction
      Tag = 2
      Category = 'Window'
      Caption = '&Next'
      ImageIndex = 39
      ShortCut = 117
      OnExecute = actNextExecute
      OnUpdate = actUpdatePageCount
    end
    object actPrev: TAction
      Tag = 3
      Category = 'Window'
      Caption = '&Previous'
      ImageIndex = 40
      ShortCut = 116
      OnExecute = actPrevExecute
      OnUpdate = actUpdatePageCount
    end
    object actUpdateCheck: TAction
      Category = 'Help'
      Caption = '&Check for Updates/Packages'
      ImageIndex = 41
      OnExecute = actUpdateCheckExecute
    end
    object actAbout: TAction
      Category = 'Help'
      Caption = 'About...'
      ImageIndex = 42
      OnExecute = actAboutExecute
    end
    object actHelpCustomize: TAction
      Category = 'Help'
      Caption = 'Customize...'
      OnExecute = actHelpCustomizeExecute
    end
    object actUnitRemove: TAction
      Tag = 1
      Category = 'Project'
      Caption = '&Remove from project'
      OnExecute = actUnitRemoveExecute
      OnUpdate = actUpdateProject
    end
    object actUnitRename: TAction
      Tag = 2
      Category = 'Project'
      Caption = 'Re&name file'
      OnExecute = actUnitRenameExecute
      OnUpdate = actUpdateProject
    end
    object actUnitHeader: TAction
      Tag = 5
      Category = 'Project'
      Caption = 'Open &Header'
      OnUpdate = actUpdateProject
    end
    object actUnitOpen: TAction
      Tag = 4
      Category = 'Project'
      Caption = '&Open'
      OnExecute = actUnitOpenExecute
      OnUpdate = actUpdateProject
    end
    object actUnitClose: TAction
      Tag = 3
      Category = 'Project'
      Caption = '&Close'
      OnExecute = actUnitCloseExecute
      OnUpdate = actUpdateProject
    end
    object actMsgCopy: TAction
      Category = 'MessageControl'
      Caption = '&Copy'
      OnExecute = actMsgCopyExecute
    end
    object actMsgClear: TAction
      Category = 'MessageControl'
      Caption = 'C&lear'
      OnExecute = actMsgClearExecute
    end
    object actShowBars: TAction
      Caption = 'Show Toolbars'
      ShortCut = 8315
      OnExecute = actShowBarsExecute
    end
    object actBreakPoint: TAction
      Category = 'Debug'
      Caption = 'Toggle Breakpoint'
      ShortCut = 16500
      OnExecute = actBreakPointExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actAddWatch: TAction
      Category = 'Debug'
      Caption = '&Add watch'
      ImageIndex = 21
      ShortCut = 115
      OnExecute = actAddWatchExecute
      OnUpdate = actUpdatePageCount
    end
    object actEditWatch: TAction
      Category = 'Debug'
      Caption = '&Edit watch'
      ImageIndex = 36
    end
    object actStepOver: TAction
      Category = 'Debug'
      Caption = 'Step &Over'
      ImageIndex = 18
      ShortCut = 118
      OnExecute = actNextStepExecute
      OnUpdate = actUpdateDebuggerPaused
    end
    object actWatchItem: TAction
      Category = 'Debug'
      Caption = '&Watch variables'
      ShortCut = 16471
      OnExecute = actWatchItemExecute
      OnUpdate = actUpdatePageorProject
    end
    object actRemoveWatch: TAction
      Category = 'Debug'
      Caption = '&Remove Watch'
      ImageIndex = 5
      OnExecute = actRemoveWatchExecute
    end
    object actStopExecute: TAction
      Category = 'Debug'
      Caption = 'Stop Execution'
      ImageIndex = 55
      ShortCut = 32881
      OnExecute = actStopExecuteExecute
      OnUpdate = actUpdateDebuggerRunning
    end
    object actFileMenu: TAction
      Caption = '&File'
      OnExecute = actFileMenuExecute
    end
    object actEditMenu: TAction
      Caption = '&Edit'
      OnExecute = actFileMenuExecute
    end
    object actSearchMenu: TAction
      Caption = '&Search'
      OnExecute = actFileMenuExecute
    end
    object actViewMenu: TAction
      Caption = '&View'
      OnExecute = actFileMenuExecute
    end
    object actProjectMenu: TAction
      Caption = '&Project'
      OnExecute = actFileMenuExecute
    end
    object actExecuteMenu: TAction
      Caption = 'E&xecute'
      OnExecute = actFileMenuExecute
    end
    object actDebugMenu: TAction
      Caption = '&Debug'
      OnExecute = actFileMenuExecute
    end
    object actToolsMenu: TAction
      Caption = '&Tools'
      OnExecute = actToolsMenuExecute
    end
    object actWindowMenu: TAction
      Caption = '&Window'
      OnExecute = actWindowMenuExecute
    end
    object actHelpMenu: TAction
      Caption = '&Help'
      OnExecute = actFileMenuExecute
    end
    object actSwapHeaderSource: TAction
      Category = 'Edit'
      Caption = '&Swap header/source'
      OnExecute = actSwapHeaderSourceExecute
      OnUpdate = actSwapHeaderSourceUpdate
    end
    object actSyntaxCheck: TAction
      Category = 'Execute'
      Caption = '&Syntax Check'
      OnExecute = actSyntaxCheckExecute
      OnUpdate = actCompileUpdate
    end
    object actConfigShortcuts: TAction
      Category = 'Tools'
      Caption = 'Configure &shortcuts'
      ImageIndex = 31
      OnExecute = actConfigShortcutsExecute
    end
    object actProgramReset: TAction
      Category = 'Execute'
      Caption = 'Program reset'
      ImageIndex = 48
      ShortCut = 32881
      OnExecute = actProgramResetExecute
      OnUpdate = actProgramResetUpdate
    end
    object actComment: TAction
      Category = 'Edit'
      Caption = 'Comment'
      ShortCut = 49342
      OnExecute = actCommentExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actUncomment: TAction
      Category = 'Edit'
      Caption = 'Uncomment'
      ShortCut = 49340
      OnExecute = actUncommentExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actIndent: TAction
      Category = 'Edit'
      Caption = 'Indent'
      ShortCut = 24649
      OnExecute = actIndentExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actUnindent: TAction
      Category = 'Edit'
      Caption = 'Unindent'
      ShortCut = 24661
      OnExecute = actUnindentExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actGotoFunction: TAction
      Category = 'Search'
      Caption = 'Goto function'
      ImageIndex = 44
      ShortCut = 24647
      OnExecute = actGotoFunctionExecute
      OnUpdate = actUpdateEmptyEditor
    end
    object actBrowserGotoDecl: TAction
      Category = 'ClassBrowser'
      Caption = 'Goto declaration'
      OnExecute = actBrowserGotoDeclExecute
      OnUpdate = actBrowserGotoDeclUpdate
    end
    object actBrowserGotoImpl: TAction
      Category = 'ClassBrowser'
      Caption = 'Goto implementation'
      OnExecute = actBrowserGotoImplExecute
      OnUpdate = actBrowserGotoImplUpdate
    end
    object actBrowserNewClass: TAction
      Category = 'ClassBrowser'
      Caption = 'New class'
      OnExecute = actBrowserNewClassExecute
      OnUpdate = actBrowserNewClassUpdate
    end
    object actBrowserNewMember: TAction
      Category = 'ClassBrowser'
      Caption = 'New member function'
      OnExecute = actBrowserNewMemberExecute
      OnUpdate = actBrowserNewMemberUpdate
    end
    object actBrowserNewVar: TAction
      Category = 'ClassBrowser'
      Caption = 'New variable'
      OnExecute = actBrowserNewVarExecute
      OnUpdate = actBrowserNewVarUpdate
    end
    object actBrowserViewAll: TAction
      Category = 'ClassBrowser'
      Caption = 'All files'
      Checked = True
      OnExecute = actBrowserViewAllExecute
      OnUpdate = actBrowserViewAllUpdate
    end
    object actBrowserViewProject: TAction
      Category = 'ClassBrowser'
      Caption = 'Project files'
      OnExecute = actBrowserViewProjectExecute
      OnUpdate = actBrowserViewAllUpdate
    end
    object actBrowserViewCurrent: TAction
      Category = 'ClassBrowser'
      Caption = 'Current file'
      OnExecute = actBrowserViewCurrentExecute
      OnUpdate = actBrowserViewAllUpdate
    end
    object actProfileProject: TAction
      Category = 'Execute'
      Caption = 'Profile analysis'
      OnExecute = actProfileProjectExecute
      OnUpdate = actRunUpdate
    end
    object actBrowserAddFolder: TAction
      Category = 'ClassBrowser'
      Caption = 'Add folder'
      OnExecute = actBrowserAddFolderExecute
      OnUpdate = actBrowserAddFolderUpdate
    end
    object actBrowserRemoveFolder: TAction
      Category = 'ClassBrowser'
      Caption = 'Remove folder'
      OnExecute = actBrowserRemoveFolderExecute
      OnUpdate = actBrowserAddFolderUpdate
    end
    object actBrowserRenameFolder: TAction
      Category = 'ClassBrowser'
      Caption = 'Rename folder'
      OnExecute = actBrowserRenameFolderExecute
      OnUpdate = actBrowserAddFolderUpdate
    end
    object actCloseAllButThis: TAction
      Category = 'File'
      Caption = 'Close all except this'
      OnExecute = actCloseAllButThisExecute
      OnUpdate = actUpdatePageCount
    end
    object actStepInto: TAction
      Category = 'Debug'
      Caption = '&Step Into'
      ImageIndex = 57
      OnExecute = actStepSingleExecute
      OnUpdate = actUpdateDebuggerPaused
    end
    object actFileProperties: TAction
      Category = 'File'
      Caption = 'Properties'
      OnExecute = actFilePropertiesExecute
      OnUpdate = actUpdatePageCount
    end
    object actViewToDoList: TAction
      Category = 'View'
      Caption = 'To-Do list...'
      OnExecute = actViewToDoListExecute
      OnUpdate = actViewToDoListUpdate
    end
    object actAddToDo: TAction
      Category = 'Edit'
      Caption = 'Add To-Do item...'
      ShortCut = 24660
      OnExecute = actAddToDoExecute
      OnUpdate = actUpdatePageorProject
    end
    object actProjectNewFolder: TAction
      Category = 'Project'
      Caption = 'Add folder'
      OnExecute = actProjectNewFolderExecute
      OnUpdate = actUpdateProject
    end
    object actProjectRemoveFolder: TAction
      Category = 'Project'
      Caption = 'Remove folder'
      OnExecute = actProjectRemoveFolderExecute
      OnUpdate = actUpdateProject
    end
    object actProjectRenameFolder: TAction
      Category = 'Project'
      Caption = 'Rename folder'
      OnExecute = actProjectRenameFolderExecute
      OnUpdate = actUpdateProject
    end
    object actImportMSVC: TAction
      Category = 'File'
      Caption = 'Import MS Visual C++ project'
      OnExecute = actImportMSVCExecute
    end
    object actExecParams: TAction
      Category = 'Execute'
      Caption = 'Parameters...'
      OnExecute = actExecParamsExecute
      OnUpdate = actDebugUpdate
    end
    object actShowTips: TAction
      Category = 'Help'
      Caption = 'Tips'
      OnExecute = actShowTipsExecute
    end
    object actBrowserUseColors: TAction
      Category = 'ClassBrowser'
      Caption = 'Use colors'
      Checked = True
      OnExecute = actBrowserUseColorsExecute
    end
    object actAbortCompilation: TAction
      Category = 'Execute'
      Caption = 'Abort compilation'
      OnExecute = actAbortCompilationExecute
      OnUpdate = actAbortCompilationUpdate
    end
    object actCVSImport: TAction
      Category = 'CVS'
      Caption = 'Import'
      OnExecute = actCVSImportExecute
    end
    object actCVSCheckout: TAction
      Category = 'CVS'
      Caption = 'Checkout'
      OnExecute = actCVSCheckoutExecute
    end
    object actCVSUpdate: TAction
      Category = 'CVS'
      Caption = 'Update'
      OnExecute = actCVSUpdateExecute
      OnUpdate = actUpdatePageorProject
    end
    object actCVSCommit: TAction
      Category = 'CVS'
      Caption = 'Commit'
      OnExecute = actCVSCommitExecute
      OnUpdate = actUpdatePageorProject
    end
    object actCVSDiff: TAction
      Category = 'CVS'
      Caption = 'Diff'
      OnExecute = actCVSDiffExecute
      OnUpdate = actUpdatePageorProject
    end
    object actCVSLog: TAction
      Category = 'CVS'
      Caption = 'Log'
      OnExecute = actCVSLogExecute
      OnUpdate = actUpdatePageorProject
    end
    object actCVSAdd: TAction
      Category = 'CVS'
      Caption = 'Add'
      OnExecute = actCVSAddExecute
      OnUpdate = actUpdatePageorProject
    end
    object actCVSRemove: TAction
      Category = 'CVS'
      Caption = 'Remove'
      OnExecute = actCVSRemoveExecute
      OnUpdate = actUpdatePageorProject
    end
    object actBrowserShowInherited: TAction
      Category = 'ClassBrowser'
      Caption = 'Show inherited members'
      OnExecute = actBrowserShowInheritedExecute
    end
    object actCVSLogin: TAction
      Category = 'CVS'
      Caption = 'Login'
      OnExecute = actCVSLoginExecute
    end
    object actCVSLogout: TAction
      Category = 'CVS'
      Caption = 'Logout'
      OnExecute = actCVSLogoutExecute
    end
    object actCompileCurrentFile: TAction
      Category = 'Execute'
      Caption = 'Compile current file'
      ImageIndex = 28
      ShortCut = 24696
      OnExecute = actCompileCurrentFileExecute
      OnUpdate = actCompileCurrentFileUpdate
    end
    object actAttachProcess: TAction
      Category = 'Debug'
      Caption = 'Attach to process...'
      OnExecute = actAttachProcessExecute
      OnUpdate = actAttachProcessUpdate
    end
    object actModifyWatch: TAction
      Category = 'Debug'
      Caption = '&Modify value'
      ImageIndex = 37
      OnExecute = actModifyWatchExecute
      OnUpdate = actModifyWatchUpdate
    end
    object actNewwxDialog: TAction
      Category = 'File'
      Caption = 'New wxDialog'
      ImageIndex = 1
      OnExecute = actNewwxDialogExecute
    end
    object actDesignerCopy: TAction
      Category = 'Designer'
      Caption = 'Copy'
      ShortCut = 49219
      OnExecute = actDesignerCopyExecute
    end
    object actDesignerCut: TAction
      Category = 'Designer'
      Caption = 'Cut'
      ShortCut = 49240
      OnExecute = actDesignerCutExecute
    end
    object actDesignerPaste: TAction
      Category = 'Designer'
      Caption = 'Paste'
      ShortCut = 49238
      OnExecute = actDesignerPasteExecute
    end
    object actDesignerDelete: TAction
      Category = 'Designer'
      Caption = 'Delete'
      ShortCut = 16430
      OnExecute = actDesignerDeleteExecute
    end
    object actNewWxFrame: TAction
      Category = 'File'
      Caption = 'New wxFrame'
      ImageIndex = 1
      OnExecute = actNewWxFrameExecute
    end
    object actWxPropertyInspectorCut: TAction
      Category = 'Designer'
      Caption = 'Cut'
      ShortCut = 16472
      OnExecute = actWxPropertyInspectorCutExecute
    end
    object actWxPropertyInspectorCopy: TAction
      Category = 'Designer'
      Caption = 'Copy'
      ShortCut = 16451
      OnExecute = actWxPropertyInspectorCopyExecute
    end
    object actWxPropertyInspectorPaste: TAction
      Category = 'Designer'
      Caption = 'Paste'
      ShortCut = 16470
      OnExecute = actWxPropertyInspectorPasteExecute
    end
    object actRestartDebug: TAction
      Category = 'Debug'
      Caption = '&Restart'
      ImageIndex = 56
      ShortCut = 8311
      OnExecute = actRestartDebugExecute
      OnUpdate = actUpdateDebuggerRunning
    end
    object actPauseDebug: TAction
      Category = 'Debug'
      Caption = 'Pause Execution'
      ImageIndex = 58
      OnExecute = actPauseDebugExecute
      OnUpdate = actPauseDebugUpdate
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnActivate = ApplicationEvents1Activate
    OnDeactivate = ApplicationEvents1Deactivate
    OnIdle = ApplicationEvents1Idle
    Left = 549
    Top = 130
  end
  object MessagePopup: TPopupMenu
    Images = dmMain.MenuImages_Gnome
    Left = 465
    Top = 130
    object MsgCopyItem: TMenuItem
      Action = actMsgCopy
      ImageIndex = 16
    end
    object MsgClearitem: TMenuItem
      Action = actMsgClear
    end
  end
  object CppTokenizer1: TCppTokenizer
    LogTokens = False
    Left = 602
    Top = 130
  end
  object CppParser1: TCppParser
    Enabled = True
    OnTotalProgress = CppParser1TotalProgress
    Tokenizer = CppTokenizer1
    ParseLocalHeaders = False
    ParseGlobalHeaders = False
    LogStatements = False
    OnStartParsing = CppParser1StartParsing
    OnEndParsing = CppParser1EndParsing
    Left = 465
    Top = 158
  end
  object CodeCompletion1: TCodeCompletion
    Parser = CppParser1
    Color = clWhite
    Width = 320
    Height = 240
    Enabled = True
    HintTimeout = 4000
    MinWidth = 256
    MinHeight = 128
    MaxWidth = 640
    MaxHeight = 480
    OnResize = CodeCompletion1Resize
    OnlyGlobals = False
    CurrentClass = 0
    Left = 575
    Top = 130
  end
  object devShortcuts1: TdevShortcuts
    Filename = 'devshortcuts.cfg'
    AlternateColor = 14737632
    MultiLangStrings.Caption = 'Configure Shortcuts'
    MultiLangStrings.Title = ' Click on an item and press the shortcut you desire!'
    MultiLangStrings.Tip = 'Tip: press "Escape" to clear a shortcut...'
    MultiLangStrings.HeaderEntry = 'Menu entry'
    MultiLangStrings.HeaderShortcut = 'Shortcut assigned'
    MultiLangStrings.OK = 'OK'
    MultiLangStrings.Cancel = 'Cancel'
    Left = 520
    Top = 158
  end
  object BrowserPopup: TPopupMenu
    Left = 493
    Top = 102
    object mnuBrowserGotoDecl: TMenuItem
      Action = actBrowserGotoDecl
    end
    object mnuBrowserGotoImpl: TMenuItem
      Action = actBrowserGotoImpl
      Default = True
    end
    object mnuBrowserSep1: TMenuItem
      Caption = '-'
    end
    object mnuBrowserNewClass: TMenuItem
      Action = actBrowserNewClass
    end
    object mnuBrowserSep2: TMenuItem
      Caption = '-'
    end
    object mnuBrowserNewMember: TMenuItem
      Action = actBrowserNewMember
    end
    object mnuBrowserNewVariable: TMenuItem
      Action = actBrowserNewVar
    end
    object N31: TMenuItem
      Caption = '-'
    end
    object mnuBrowserAddFolder: TMenuItem
      Action = actBrowserAddFolder
    end
    object mnuBrowserRemoveFolder: TMenuItem
      Action = actBrowserRemoveFolder
    end
    object mnuBrowserRenameFolder: TMenuItem
      Action = actBrowserRenameFolder
    end
    object mnuBrowserSep3: TMenuItem
      Caption = '-'
    end
    object mnuBrowserViewMode: TMenuItem
      Caption = 'View mode'
      object mnuBrowserViewAll: TMenuItem
        Action = actBrowserViewAll
        RadioItem = True
      end
      object mnuBrowserViewProject: TMenuItem
        Action = actBrowserViewProject
      end
      object mnuBrowserViweCurrent: TMenuItem
        Action = actBrowserViewCurrent
        RadioItem = True
      end
      object N42: TMenuItem
        Caption = '-'
      end
      object Usecolors1: TMenuItem
        Action = actBrowserUseColors
      end
      object Showinheritedmembers1: TMenuItem
        Action = actBrowserShowInherited
      end
    end
  end
  object DebugVarsPopup: TPopupMenu
    Images = dmMain.MenuImages_Gnome
    OnPopup = DebugVarsPopupPopup
    Left = 521
    Top = 102
    object AddwatchPop: TMenuItem
      Action = actAddWatch
    end
    object ModifyWatchPop: TMenuItem
      Action = actModifyWatch
    end
    object N67: TMenuItem
      Caption = '-'
    end
    object RemoveWatchPop: TMenuItem
      Action = actRemoveWatch
    end
    object ClearallWatchPop: TMenuItem
      Caption = '&Clear all'
      OnClick = ClearallWatchPopClick
    end
  end
  object DevCppDDEServer: TDdeServerConv
    OnExecuteMacro = DevCppDDEServerExecuteMacro
    Left = 548
    Top = 158
  end
  object XPMenu: TXPMenu
    DimLevel = 30
    GrayLevel = 10
    Font.Charset = DEFAULT_CHARSET
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
    Left = 493
    Top = 158
  end
  object DockServer: TJvDockServer
    LeftSplitterStyle.Cursor = crHSplit
    LeftSplitterStyle.ParentColor = False
    RightSplitterStyle.Cursor = crHSplit
    RightSplitterStyle.ParentColor = False
    TopSplitterStyle.Cursor = crVSplit
    TopSplitterStyle.ParentColor = False
    BottomSplitterStyle.Cursor = crVSplit
    BottomSplitterStyle.ParentColor = False
    CustomDock = False
    Left = 576
    Top = 158
  end
end
