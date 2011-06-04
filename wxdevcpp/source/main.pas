{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}

{$IFDEF COMPILER_7_UP}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$ENDIF COMPILER_7_UP}

{
    $Id$

    This file is part of Dev-C++
    Copyright (c) 2004 Bloodshed Software

    Dev-C++ is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Dev-C++ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Dev-C++; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

{$WARN SYMBOL_PLATFORM OFF}
unit main;

interface

uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    Menus, StdCtrls, ComCtrls, ToolWin, ExtCtrls, Buttons, utils,
    Project, editor, compiler, ActnList, oysUtils, Toolfrm, AppEvnts, Grids,
    debugger, ClassBrowser, DevThemes, CodeCompletion, CppParser, CppTokenizer,
    devShortcuts, StrUtils, devFileMonitor, devMonitorTypes, DdeMan, XPMenu,
    CVSFm, ImageTheme, JvComponentBase, JvDockControlForm,
    JvDockSupportControl,
{$IFDEF PLUGIN_BUILD}
    SynEdit, iplugin, iplugin_bpl, iplugin_dll, iplugger,
    controlbar_win32_events, hashes,
    xprocs, SynHighlighterRC, hh, hh_funcs, VistaAltFixUnit,

{$IFNDEF COMPILER_7_UP}
    ThemeMgr,
    ThemeSrv,
{$ENDIF}
{$IFNDEF OLD_MADSHI}
    ExceptionFilterUnit,
{$ENDIF}
    SynEditHighlighter, SynHighlighterMulti,
    JvDockTree, JvDockVIDStyle, JvDockVSNetStyle, JvComputerInfoEx
{$ENDIF}
    ;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QMenus, QStdCtrls, QComCtrls, QExtCtrls, QButtons, utils,
  project, editor, compiler, QActnList, oysUtils, QGrids,
  debugger, ClassBrowser, DevThemes, CodeCompletion, CppParser, CppTokenizer,
  devShortcuts, StrUtils, devFileMonitor, devMonitorTypes,
  CVSFm, ImageTheme, Types;
{$ENDIF}

type
        PTList = ^Tlist;
        
type
    TMainForm = class(TForm{$IFDEF PLUGIN_BUILD}, iplug{$ENDIF})
        MainMenu: TMainMenu;
        FileMenu: TMenuItem;
        NewprojectItem: TMenuItem;
        NewTemplateItem: TMenuItem;
        N34: TMenuItem;
        OpenprojectItem: TMenuItem;
        ReOpenItem: TMenuItem;
        ClearhistoryItem: TMenuItem;
        N11: TMenuItem;
        NewSourceFileItem: TMenuItem;
        NewresourcefileItem: TMenuItem;
        N12: TMenuItem;
        SaveUnitItem: TMenuItem;
        SaveUnitAsItem: TMenuItem;
        SaveallItem: TMenuItem;
        N33: TMenuItem;
        CloseprojectItem: TMenuItem;
        CloseItem: TMenuItem;
        ExportItem: TMenuItem;
        HTMLItem: TMenuItem;
        RTFItem: TMenuItem;
        N19: TMenuItem;
        ProjecttoHTMLItem: TMenuItem;
        PrintItem: TMenuItem;
        PrinterSetupItem: TMenuItem;
        N3: TMenuItem;
        ExitItem: TMenuItem;
        EditMenu: TMenuItem;
        UndoItem: TMenuItem;
        RedoItem: TMenuItem;
        N4: TMenuItem;
        CutItem: TMenuItem;
        CopyItem: TMenuItem;
        PasteItem: TMenuItem;
        N14: TMenuItem;
        ToggleBookmarksItem: TMenuItem;
        GotoBookmarksItem: TMenuItem;
        N5: TMenuItem;
        SelectallItem: TMenuItem;
        SearchMenu: TMenuItem;
        FindItem: TMenuItem;
        FindnextItem: TMenuItem;
        ReplaceItem: TMenuItem;
        N7: TMenuItem;
        GotolineItem: TMenuItem;
        ViewMenu: TMenuItem;
        StatusbarItem: TMenuItem;
        ToolbarsItem: TMenuItem;
        ToolMainItem: TMenuItem;
        ToolCompileandRunItem: TMenuItem;
        ToolProjectItem: TMenuItem;
        ToolOptionItem: TMenuItem;
        ToolSpecialsItem: TMenuItem;
        ProjectMenu: TMenuItem;
        NewunitinprojectItem: TMenuItem;
        AddtoprojectItem: TMenuItem;
        RemovefromprojectItem: TMenuItem;
        N6: TMenuItem;
        ProjectoptionsItem: TMenuItem;
        ExecuteMenu: TMenuItem;
        CompileItem: TMenuItem;
        RunItem: TMenuItem;
        N10: TMenuItem;
        CompileandRunItem: TMenuItem;
        RebuildallItem: TMenuItem;
        N8: TMenuItem;
        DebugItem: TMenuItem;
        CompileroptionsItem: TMenuItem;
        EnvironmentoptionsItem: TMenuItem;
        ToolsMenu: TMenuItem;
        ConfiguretoolsItem: TMenuItem;
        mnuToolSep1: TMenuItem;
        WindowMenu: TMenuItem;
        CloseAllItem: TMenuItem;
        N28: TMenuItem;
        FullscreenmodeItem: TMenuItem;
        N36: TMenuItem;
        NextItem: TMenuItem;
        PreviousItem: TMenuItem;
        N32: TMenuItem;
        HelpMenu: TMenuItem;
        HelpSep1: TMenuItem;
        HelpSep2: TMenuItem;
        AboutDevCppItem: TMenuItem;
        MessageControl: TPageControl;
        CompSheet: TTabSheet;
        CompilerOutput: TListView;
        ResSheet: TTabSheet;
        ResourceOutput: TListBox;
        LogSheet: TTabSheet;
{$IFDEF PLUGIN_BUILD}
        ControlBar1: TControlBar_WIN32_EVENTS;
{$ELSE}
    //ControlBar1: TControlBar;
{$ENDIF}
        tbMain: TToolBar;
        NewProjectBtn: TToolButton;
        OpenBtn: TToolButton;
        tbCompile: TToolBar;
        tbOptions: TToolBar;
        CleanItem: TMenuItem;
        ToolButton3: TToolButton;
        NewFileBtn: TToolButton;
        SaveUnitBtn: TToolButton;
        CloseBtn: TToolButton;
        ToolButton7: TToolButton;
        PrintBtn: TToolButton;
        CompileBtn: TToolButton;
        RunBtn: TToolButton;
        CompileAndRunBtn: TToolButton;
        DebugBtn: TToolButton;
        RebuildAllBtn: TToolButton;
        tbProject: TToolBar;
        AddToProjectBtn: TToolButton;
        RemoveFromProjectBtn: TToolButton;
        ToolButton20: TToolButton;
        ProjectOptionsBtn: TToolButton;
        HelpBtn: TToolButton;
        AboutBtn: TToolButton;
        SaveAllBtn: TToolButton;
        EditorPopupMenu: TPopupMenu;
        UndoPopItem: TMenuItem;
        RedoPopItem: TMenuItem;
        MenuItem1: TMenuItem;
        CutPopItem: TMenuItem;
        CopyPopItem: TMenuItem;
        PastePopItem: TMenuItem;
        MenuItem2: TMenuItem;
        InsertPopItem: TMenuItem;
        CommentheaderPopItem: TMenuItem;
        DateandtimePopItem: TMenuItem;
        MenuItem3: TMenuItem;
        MainfunctionPopItem: TMenuItem;
        WinMainfunctionPopItem: TMenuItem;
        MenuItem4: TMenuItem;
        ifdefPopItem: TMenuItem;
        ifndefPopItem: TMenuItem;
        includePopItem: TMenuItem;
        MenuItem5: TMenuItem;
        ifPopItem: TMenuItem;
        whilePopItem: TMenuItem;
        dowhilePopItem: TMenuItem;
        forPopItem: TMenuItem;
        MenuItem6: TMenuItem;
        MessageBoxPopItem: TMenuItem;
        TogglebookmarksPopItem: TMenuItem;
        GotobookmarksPopItem: TMenuItem;
        SelectAllPopItem: TMenuItem;
        UnitPopup: TPopupMenu;
        RemoveFilefromprojectPopItem: TMenuItem;
        RenamefilePopItem: TMenuItem;
        N30: TMenuItem;
        ClosefilePopItem: TMenuItem;
        ProjectPopup: TPopupMenu;
        NewunitinprojectPopItem: TMenuItem;
        AddtoprojectPopItem: TMenuItem;
        RemovefromprojectPopItem: TMenuItem;
        MenuItem18: TMenuItem;
        ProjectoptionsPopItem: TMenuItem;
        InfoGroupBox: TGroupBox;
        StatusBar: TStatusBar;
        ErrorLabel: TLabel;
        SizeOfOutput: TLabel;
        CompResGroupBox: TGroupBox;
        LogOutput: TMemo;
        FindSheet: TTabSheet;
        FindOutput: TListView;
        FindinallfilesItem: TMenuItem;
        HelpPop: TPopupMenu;
        N20: TMenuItem;
        mnuNew: TMenuItem;
        N13: TMenuItem;
        alMain: TActionList;
        actNewSource: TAction;
        actNewProject: TAction;
        actNewRes: TAction;
        actNewTemplate: TAction;
        actOpen: TAction;
        actHistoryClear: TAction;
        actSave: TAction;
        actSaveAs: TAction;
        actSaveAll: TAction;
        actClose: TAction;
        actCloseAll: TAction;
        actCloseProject: TAction;
        actXHTML: TAction;
        actXRTF: TAction;
        actXProject: TAction;
        actPrint: TAction;
        actPrintSU: TAction;
        actExit: TAction;
        actUndo: TAction;
        actRedo: TAction;
        actCut: TAction;
        actCopy: TAction;
        actPaste: TAction;
        actSelectAll: TAction;
        actFind: TAction;
        actFindAll: TAction;
        actReplace: TAction;
        actFindNext: TAction;
        actGoto: TAction;
        actStatusbar: TAction;
        actProjectNew: TAction;
        actProjectAdd: TAction;
        actProjectRemove: TAction;
        actProjectOptions: TAction;
        actCompile: TAction;
        actRun: TAction;
        actCompRun: TAction;
        actRebuild: TAction;
        actClean: TAction;
        actDebug: TAction;
        actCompOptions: TAction;
        actEnviroOptions: TAction;
        actEditorOptions: TAction;
        actConfigTools: TAction;
        actFullScreen: TAction;
        actNext: TAction;
        actPrev: TAction;
        actUpdateCheck: TAction;
        actAbout: TAction;
        actHelpCustomize: TAction;
        actProjectSource: TAction;
        actUnitRemove: TAction;
        actUnitRename: TAction;
        actUnitHeader: TAction;
        actUnitOpen: TAction;
        actUnitClose: TAction;
        Customize1: TMenuItem;
        EditorOptions1: TMenuItem;
        tbEdit: TToolBar;
        UndoBtn: TToolButton;
        RedoBtn: TToolButton;
        tbSearch: TToolBar;
        Findbtn: TToolButton;
        Replacebtn: TToolButton;
        FindNextbtn: TToolButton;
        GotoLineBtn: TToolButton;
        ToolButton12: TToolButton;
        OpenPopItem: TMenuItem;
        ToolEditItem: TMenuItem;
        ToolSearchItem: TMenuItem;
        N2: TMenuItem;
        N9: TMenuItem;
        tbSpecials: TToolBar;
        ApplicationEvents1: TApplicationEvents;
        actProjectMakeFile: TAction;
        MessagePopup: TPopupMenu;
        actMsgCopy: TAction;
        actMsgClear: TAction;
        MsgCopyItem: TMenuItem;
        MsgClearitem: TMenuItem;
        actBreakPoint: TAction;
        actIncremental: TAction;
        IncrementalSearch1: TMenuItem;
        actShowBars: TAction;
        Close1: TMenuItem;
        N16: TMenuItem;
        DebugMenu: TMenuItem;
        N18: TMenuItem;
        TogglebreakpointItem: TMenuItem;
        DbgStepOver: TMenuItem;
        N21: TMenuItem;
        WatchItem: TMenuItem;
        DebugSheet: TTabSheet;
        AddwatchItem: TMenuItem;
        actAddWatch: TAction;
        actEditWatch: TAction;
        pnlFull: TPanel;
        btnFullScrRevert: TSpeedButton;
        actStepOver: TAction;
        actWatchItem: TAction;
        actRemoveWatch: TAction;
        actStopExecute: TAction;
        StopExecution1: TMenuItem;
        NewAllBtn: TToolButton;
        InsertBtn: TToolButton;
        ToggleBtn: TToolButton;
        GotoBtn: TToolButton;
        actFileMenu: TAction;
        actEditMenu: TAction;
        actSearchMenu: TAction;
        actViewMenu: TAction;
        actProjectMenu: TAction;
        actExecuteMenu: TAction;
        actDebugMenu: TAction;
        actToolsMenu: TAction;
        actWindowMenu: TAction;
        actHelpMenu: TAction;
        actDelete: TAction;
        DeletePopItem: TMenuItem;
        CppTokenizer1: TCppTokenizer;
        CppParser1: TCppParser;
        CodeCompletion1: TCodeCompletion;
        N22: TMenuItem;
        Swapheadersource1: TMenuItem;
        N23: TMenuItem;
        Swapheadersource2: TMenuItem;
        actSwapHeaderSource: TAction;
        SizeFile: TEdit;
        TotalErrors: TEdit;
        InsertItem: TMenuItem;
        SyntaxCheckItem: TMenuItem;
        actSyntaxCheck: TAction;
        devShortcuts1: TdevShortcuts;
        actConfigShortcuts: TAction;
        Configureshortcuts1: TMenuItem;
        DateTimeMenuItem: TMenuItem;
        actProgramReset: TAction;
        N25: TMenuItem;
        Programreset1: TMenuItem;
        CommentheaderMenuItem: TMenuItem;
        actComment: TAction;
        actUncomment: TAction;
        actIndent: TAction;
        actUnindent: TAction;
        N26: TMenuItem;
        Comment1: TMenuItem;
        Uncomment1: TMenuItem;
        Indent1: TMenuItem;
        Unindent1: TMenuItem;
        N27: TMenuItem;
        actGotoFunction: TAction;
        Gotofunction1: TMenuItem;
        BrowserPopup: TPopupMenu;
        mnuBrowserGotoDecl: TMenuItem;
        mnuBrowserGotoImpl: TMenuItem;
        mnuBrowserSep1: TMenuItem;
        mnuBrowserNewClass: TMenuItem;
        mnuBrowserSep2: TMenuItem;
        mnuBrowserNewMember: TMenuItem;
        mnuBrowserNewVariable: TMenuItem;
        mnuBrowserSep3: TMenuItem;
        mnuBrowserViewMode: TMenuItem;
        mnuBrowserViewAll: TMenuItem;
        mnuBrowserViweCurrent: TMenuItem;
        actBrowserGotoDecl: TAction;
        actBrowserGotoImpl: TAction;
        actBrowserNewClass: TAction;
        actBrowserNewMember: TAction;
        actBrowserNewVar: TAction;
        actBrowserViewAll: TAction;
        actBrowserViewCurrent: TAction;
        actProfileProject: TAction;
        N29: TMenuItem;
        Profileanalysis1: TMenuItem;
        N24: TMenuItem;
        CheckforupdatesItem: TMenuItem;
        N31: TMenuItem;
        actBrowserAddFolder: TAction;
        actBrowserRemoveFolder: TAction;
        mnuBrowserAddFolder: TMenuItem;
        mnuBrowserRemoveFolder: TMenuItem;
        actBrowserRenameFolder: TAction;
        mnuBrowserRenameFolder: TMenuItem;
        actCloseAllButThis: TAction;
        CloseAll1: TMenuItem;
        Closeallexceptthis1: TMenuItem;
        CloseAll2: TMenuItem;
        DbgStepInto: TMenuItem;
        DebugVarsPopup: TPopupMenu;
        AddwatchPop: TMenuItem;
        RemoveWatchPop: TMenuItem;
        devFileMonitor: TdevFileMonitor;
        actFileProperties: TAction;
        N35: TMenuItem;
        N1: TMenuItem;
        Properties1: TMenuItem;
        actViewToDoList: TAction;
        actAddToDo: TAction;
        AddToDoitem1: TMenuItem;
        N38: TMenuItem;
        ToDolist1: TMenuItem;
        N39: TMenuItem;
        actProjectNewFolder: TAction;
        actProjectRemoveFolder: TAction;
        actProjectRenameFolder: TAction;
        Newfolder1: TMenuItem;
        N40: TMenuItem;
        actStepInto: TAction;
        Addfolder1: TMenuItem;
        Removefolder1: TMenuItem;
        Renamefolder1: TMenuItem;
        actImportMSVC: TAction;
        ImportItem: TMenuItem;
        ImportMSVisualCproject1: TMenuItem;
        N41: TMenuItem;
        ToggleBreakpointPopupItem: TMenuItem;
        AddWatchPopupItem: TMenuItem;
        actRunToCursor: TAction;
        RuntocursorItem: TMenuItem;
        Runtocursor1: TMenuItem;
        ViewCPUItem: TMenuItem;
        actViewCPU: TAction;
        actExecParams: TAction;
        mnuExecParameters: TMenuItem;
        DevCppDDEServer: TDdeServerConv;
        actShowTips: TAction;
        Tips1: TMenuItem;
        N42: TMenuItem;
        Usecolors1: TMenuItem;
        actBrowserUseColors: TAction;
        HelpMenuItem: TMenuItem;
        actBrowserViewProject: TAction;
        mnuBrowserViewProject: TMenuItem;
        N43: TMenuItem;
        PackageManagerItem: TMenuItem;
        btnAbortCompilation: TSpeedButton;
        actAbortCompilation: TAction;
        N44: TMenuItem;
        Addfile1: TMenuItem;
        actCVSImport: TAction;
        actCVSCheckout: TAction;
        actCVSUpdate: TAction;
        actCVSCommit: TAction;
        actCVSDiff: TAction;
        actCVSLog: TAction;
        N45: TMenuItem;
        CVS1: TMenuItem;
        N47: TMenuItem;
        mnuCVSLog3: TMenuItem;
        mnuCVSUpdate3: TMenuItem;
        mnuCVSDiff3: TMenuItem;
        mnuCVSCommit3: TMenuItem;
        N48: TMenuItem;
        CVS2: TMenuItem;
        mnuCVSCommit1: TMenuItem;
        mnuCVSUpdate1: TMenuItem;
        mnuCVSDiff1: TMenuItem;
        N55: TMenuItem;
        mnuCVSLog1: TMenuItem;
        N49: TMenuItem;
        CVS3: TMenuItem;
        mnuCVSCommit2: TMenuItem;
        mnuCVSUpdate2: TMenuItem;
        mnuCVSDiff2: TMenuItem;
        N51: TMenuItem;
        mnuCVSLog2: TMenuItem;
        mnuCVS: TMenuItem;
        mnuCVSUpdate: TMenuItem;
        mnuCVSDiff: TMenuItem;
        N53: TMenuItem;
        mnuCVSCommit: TMenuItem;
        N56: TMenuItem;
        mnuCVSLog: TMenuItem;
        mnuCVSCurrent: TMenuItem;
        mnuCVSWhole: TMenuItem;
        mnuCVSImportP: TMenuItem;
        mnuCVSCheckoutP: TMenuItem;
        mnuCVSUpdateP: TMenuItem;
        mnuCVSDiffP: TMenuItem;
        N58: TMenuItem;
        mnuCVSLogP: TMenuItem;
        N52: TMenuItem;
        N59: TMenuItem;
        N60: TMenuItem;
        N46: TMenuItem;
        Commit1: TMenuItem;
        ListItem: TMenuItem;
        GotoprojectmanagerItem: TMenuItem;
        N50: TMenuItem;
        mnuFileProps: TMenuItem;
        N54: TMenuItem;
        mnuUnitProperties: TMenuItem;
        actCVSAdd: TAction;
        actCVSRemove: TAction;
        N61: TMenuItem;
        mnuCVSAdd: TMenuItem;
        mnuCVSRemove: TMenuItem;
        N62: TMenuItem;
        mnuCVSAdd2: TMenuItem;
        mnuCVSRemove2: TMenuItem;
        N63: TMenuItem;
        GoToClassBrowserItem: TMenuItem;
        XPMenu: TXPMenu;
        actBrowserShowInherited: TAction;
        Showinheritedmembers1: TMenuItem;
        HelponDevPopupItem: TMenuItem;
        N64: TMenuItem;
        actCVSLogin: TAction;
        actCVSLogout: TAction;
        N65: TMenuItem;
        Login1: TMenuItem;
        Logout1: TMenuItem;
        N66: TMenuItem;
        DebugSubPages: TPageControl;
        tabBacktrace: TTabSheet;
        lvBacktrace: TListView;
        tabDebugOutput: TTabSheet;
        DebugOutput: TMemo;
        DebuggerCmdPanel: TPanel;
        lblSendCommandDebugger: TLabel;
        edCommand: TEdit;
        btnSendCommand: TButton;
        ShowProjectInspItem: TMenuItem;
        actCompileCurrentFile: TAction;
        Compilecurrentfile1: TMenuItem;
        actSaveProjectAs: TAction;
        SaveprojectasItem: TMenuItem;
        mnuOpenWith: TMenuItem;
        tbClasses: TToolBar;
        cmbClasses: TComboBox;
        cmbMembers: TComboBox;
        N17: TMenuItem;
        ToolClassesItem: TMenuItem;
        N67: TMenuItem;
        N57: TMenuItem;
        AttachtoprocessItem: TMenuItem;
        actAttachProcess: TAction;
        ModifyWatchPop: TMenuItem;
        actModifyWatch: TAction;
        ClearallWatchPop: TMenuItem;

        ProgramResetBtn: TToolButton;
        SurroundWithPopItem: TMenuItem;
        trycatchPopItem: TMenuItem;
        N68: TMenuItem;
        CStyleCommentPopItem: TMenuItem;
        CppStyleCommentPopItem: TMenuItem;
        N69: TMenuItem;
        forloopPopItem: TMenuItem;
        whileLoopPopItem: TMenuItem;
        dowhileLoopPopItem: TMenuItem;
        bracesPopItem: TMenuItem;
        ifLoopPopItem: TMenuItem;
        ifelseloopPopItem: TMenuItem;
        forintloopPopItem: TMenuItem;
        switchLoopPopItem: TMenuItem;
        DockServer: TJvDockServer;
        LeftPageControl: TPageControl;
        ProjectSheet: TTabSheet;
        ProjectView: TTreeView;
        ClassSheet: TTabSheet;
        ClassBrowser1: TClassBrowser;
        tabWatches: TTabSheet;
        tabLocals: TTabSheet;
        lvLocals: TListView;
        tbDebug: TToolBar;
        DebugRestartBtn: TToolButton;
        ToolButton1: TToolButton;
        DebugStepOver: TToolButton;
        DebugStepInto: TToolButton;
        ToolButton2: TToolButton;
        actRestartDebug: TAction;
        Restart1: TMenuItem;
        ToolDebugItem: TMenuItem;
        Pause1: TMenuItem;
        actPauseDebug: TAction;
        DebugPauseBtn: TToolButton;
        tabThreads: TTabSheet;
        lvThreads: TListView;
        PageControl: TPageControl;
        TodoSheet: TTabSheet;
        lvTodo: TListView;
        TodoSettings: TPanel;
        lblTodoFilter: TLabel;
        chkTodoIncomplete: TCheckBox;
        cmbTodoFilter: TComboBox;
        CompilerMessagesPanelItem: TMenuItem;
        ShowPanelsItem: TMenuItem;
        ResourcesMessagesPanelItem: TMenuItem;
        CompileLogMessagesPanelItem: TMenuItem;
        DebuggingMessagesPanelItem: TMenuItem;
        FindResultsMessagesPanelItem: TMenuItem;
        ToDoListMessagesPanelItem: TMenuItem;
        ShowPluginPanelsItem: TMenuItem;
        DeleteLine1: TMenuItem;
        actDeleteLine: TAction;
        JvComputerInfoEx1: TJvComputerInfoEx;
        DebugFinish: TToolButton;
        DbgFinish: TMenuItem;
        actDebugFinish: TAction;
        RemoveAllBreakpoints1: TMenuItem;
        actRemoveAllBreakpoints: TAction;
    VerboseDebug: TMenuItem;
    WatchTree: TTreeView;
    ViewMemory1: TMenuItem;

        procedure FormShow(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure FormDestroy(Sender: TObject);
        procedure ToggleBookmarkClick(Sender: TObject);
        procedure GotoBookmarkClick(Sender: TObject);
        procedure ToggleBtnClick(Sender: TObject);
        procedure GotoBtnClick(Sender: TObject);
        procedure NewAllBtnClick(Sender: TObject);
        procedure HelpBtnClick(Sender: TObject);
        procedure ProjectViewContextPopup(Sender: TObject; MousePos: TPoint;
            var Handled: Boolean);
        procedure ProjectViewDblClick(Sender: TObject);
        procedure InsertBtnClick(Sender: TObject);
        procedure Customize1Click(Sender: TObject);
        procedure ToolbarClick(Sender: TObject);
        procedure ControlBar1ContextPopup(Sender: TObject; MousePos: TPoint;
            var Handled: Boolean);
        procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);

        // action executes
        procedure actNewSourceExecute(Sender: TObject);
        procedure actNewProjectExecute(Sender: TObject);
        procedure actNewResExecute(Sender: TObject);
        procedure actNewTemplateExecute(Sender: TObject);
        procedure actOpenExecute(Sender: TObject);
        procedure actHistoryClearExecute(Sender: TObject);
        procedure actSaveExecute(Sender: TObject);
        procedure actSaveAsExecute(Sender: TObject);
        procedure actSaveAllExecute(Sender: TObject);
        procedure actCloseExecute(Sender: TObject);
        procedure actCloseAllExecute(Sender: TObject);
        procedure actCloseProjectExecute(Sender: TObject);
        procedure actXHTMLExecute(Sender: TObject);
        procedure actXRTFExecute(Sender: TObject);
        procedure actXProjectExecute(Sender: TObject);
        procedure actPrintExecute(Sender: TObject);
        procedure actPrintSUExecute(Sender: TObject);
        procedure actExitExecute(Sender: TObject);
        procedure actUndoExecute(Sender: TObject);
        procedure actDeleteLineExecute(Sender: TObject);
        procedure actRedoExecute(Sender: TObject);
        procedure actCutExecute(Sender: TObject);
        procedure actCopyExecute(Sender: TObject);
        procedure actPasteExecute(Sender: TObject);
        procedure actSelectAllExecute(Sender: TObject);
        procedure actStatusbarExecute(Sender: TObject);
        procedure actFullScreenExecute(Sender: TObject);
        procedure actNextExecute(Sender: TObject);
        procedure actPrevExecute(Sender: TObject);
        procedure actCompOptionsExecute(Sender: TObject);
        procedure actEditorOptionsExecute(Sender: TObject);
        procedure actConfigToolsExecute(Sender: TObject);
        procedure actUnitRemoveExecute(Sender: TObject);
        procedure actUnitRenameExecute(Sender: TObject);
        procedure actUnitOpenExecute(Sender: TObject);
        procedure actUnitCloseExecute(Sender: TObject);
        procedure actUpdateCheckExecute(Sender: TObject);
        procedure actAboutExecute(Sender: TObject);
        procedure actHelpCustomizeExecute(Sender: TObject);
        procedure actProjectNewExecute(Sender: TObject);
        procedure actProjectAddExecute(Sender: TObject);
        procedure actProjectRemoveExecute(Sender: TObject);
        procedure actProjectOptionsExecute(Sender: TObject);
        procedure actProjectSourceExecute(Sender: TObject);
        procedure actFindExecute(Sender: TObject);
        procedure actFindAllExecute(Sender: TObject);
        procedure actReplaceExecute(Sender: TObject);
        procedure actFindNextExecute(Sender: TObject);
        procedure actGotoExecute(Sender: TObject);
        procedure actCompileExecute(Sender: TObject);
        procedure actRunExecute(Sender: TObject);
        procedure actCompRunExecute(Sender: TObject);
        procedure actRebuildExecute(Sender: TObject);
        procedure actCleanExecute(Sender: TObject);
        procedure actDebugExecute(Sender: TObject);
        procedure actEnviroOptionsExecute(Sender: TObject);
        procedure actProjectMakeFileExecute(Sender: TObject);
        procedure actMsgCopyExecute(Sender: TObject);
        procedure actMsgClearExecute(Sender: TObject);
        // action updates (need to make more specific)
        procedure actUpdatePageCount(Sender: TObject);
        // enable on pagecount> 0
        procedure actUpdateProject(Sender: TObject);
        // enable on fproject assigned
        procedure actUpdatePageProject(Sender: TObject);
        // enable on both above
        procedure actUpdatePageorProject(Sender: TObject);
        // enable on either of above
        procedure actUpdateEmptyEditor(Sender: TObject);
        // enable on unempty editor
        procedure actUpdateDebuggerRunning(Sender: TObject);
        // enable when debugger running
        procedure actBreakPointExecute(Sender: TObject);
        procedure actIncrementalExecute(Sender: TObject);
        procedure CompilerOutputDblClick(Sender: TObject);
        procedure FindOutputDblClick(Sender: TObject);
        procedure actShowBarsExecute(Sender: TObject);
        procedure btnFullScrRevertClick(Sender: TObject);
        procedure FormContextPopup(Sender: TObject; MousePos: TPoint;
            var Handled: Boolean);
        procedure FormKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure actAddWatchExecute(Sender: TObject);
        procedure ProjectViewClick(Sender: TObject);
        procedure actNextStepExecute(Sender: TObject);
        procedure actWatchItemExecute(Sender: TObject);
        procedure actRemoveWatchExecute(Sender: TObject);
        procedure actStepOverExecute(Sender: TObject);
        procedure actStopExecuteExecute(Sender: TObject);
        procedure actUndoUpdate(Sender: TObject);
        procedure actRedoUpdate(Sender: TObject);
        procedure actCutUpdate(Sender: TObject);
        procedure actCopyUpdate(Sender: TObject);
        procedure actPasteUpdate(Sender: TObject);
        procedure actSaveUpdate(Sender: TObject);
        procedure actSaveAsUpdate(Sender: TObject);
        procedure actFindNextUpdate(Sender: TObject);
        procedure actFileMenuExecute(Sender: TObject);
        procedure actToolsMenuExecute(Sender: TObject);
        procedure actDeleteExecute(Sender: TObject);
        procedure FormResize(Sender: TObject);
        procedure ClassBrowser1Select(Sender: TObject; Filename: TFileName;
            Line: Integer);
        procedure CppParser1TotalProgress(Sender: TObject; FileName: String;
            Total, Current: Integer);
        procedure CodeCompletion1Resize(Sender: TObject);
        procedure actSwapHeaderSourceUpdate(Sender: TObject);
        procedure actSwapHeaderSourceExecute(Sender: TObject);
        procedure actSyntaxCheckExecute(Sender: TObject);
        procedure actUpdateExecute(Sender: TObject);
        procedure PageControlChange(Sender: TObject);
        procedure actConfigShortcutsExecute(Sender: TObject);
        procedure DateTimeMenuItemClick(Sender: TObject);
        procedure actProgramResetExecute(Sender: TObject);
        procedure actProgramResetUpdate(Sender: TObject);
        procedure CommentheaderMenuItemClick(Sender: TObject);
        procedure PageControlMouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure actNewTemplateUpdate(Sender: TObject);
        procedure actCommentExecute(Sender: TObject);
        procedure actUncommentExecute(Sender: TObject);
        procedure actIndentExecute(Sender: TObject);
        procedure actUnindentExecute(Sender: TObject);
        procedure PageControlDragOver(Sender, Source: TObject; X, Y: Integer;
            State: TDragState; var Accept: Boolean);
        procedure PageControlDragDrop(Sender, Source: TObject; X, Y: Integer);
        procedure actGotoFunctionExecute(Sender: TObject);
        procedure actBrowserGotoDeclUpdate(Sender: TObject);
        procedure actBrowserGotoImplUpdate(Sender: TObject);
        procedure actBrowserNewClassUpdate(Sender: TObject);
        procedure actBrowserNewMemberUpdate(Sender: TObject);
        procedure actBrowserNewVarUpdate(Sender: TObject);
        procedure actBrowserViewAllUpdate(Sender: TObject);
        procedure actBrowserGotoDeclExecute(Sender: TObject);
        procedure actBrowserGotoImplExecute(Sender: TObject);
        procedure actBrowserNewClassExecute(Sender: TObject);
        procedure actBrowserNewMemberExecute(Sender: TObject);
        procedure actBrowserNewVarExecute(Sender: TObject);
        procedure actBrowserViewAllExecute(Sender: TObject);
        procedure actBrowserViewCurrentExecute(Sender: TObject);
        procedure actProfileProjectExecute(Sender: TObject);
        procedure actBrowserAddFolderExecute(Sender: TObject);
        procedure actBrowserRemoveFolderExecute(Sender: TObject);
        procedure actBrowserAddFolderUpdate(Sender: TObject);
        procedure actBrowserRenameFolderExecute(Sender: TObject);
        procedure actCloseAllButThisExecute(Sender: TObject);
        procedure actStepSingleExecute(Sender: TObject);
        procedure lvBacktraceCustomDrawItem(Sender: TCustomListView;
            Item: TListItem; State: TCustomDrawState;
            var DefaultDraw: Boolean);
        procedure lvBacktraceMouseMove(Sender: TObject; Shift: TShiftState; X,
            Y: Integer);
        procedure actDebugUpdate(Sender: TObject);
        procedure actRunUpdate(Sender: TObject);
        procedure actCompileUpdate(Sender: TObject);
        procedure devFileMonitorNotifyChange(Sender: TObject;
            ChangeType: TdevMonitorChangeType; Filename: String);
        procedure HandleFileMonitorChanges;
        procedure actFilePropertiesExecute(Sender: TObject);
        procedure actViewToDoListExecute(Sender: TObject);
        procedure actAddToDoExecute(Sender: TObject);
        procedure actProjectNewFolderExecute(Sender: TObject);
        procedure actProjectRemoveFolderExecute(Sender: TObject);
        procedure actProjectRenameFolderExecute(Sender: TObject);
        procedure ProjectViewDragOver(Sender, Source: TObject; X, Y: Integer;
            State: TDragState; var Accept: Boolean);
        procedure ProjectViewDragDrop(Sender, Source: TObject; X, Y: Integer);
        procedure actImportMSVCExecute(Sender: TObject);
        procedure AddWatchPopupItemClick(Sender: TObject);
        procedure actRunToCursorExecute(Sender: TObject);
        procedure btnSendCommandClick(Sender: TObject);
        procedure ViewCPUItemClick(Sender: TObject);
        procedure edCommandKeyPress(Sender: TObject; var Key: Char);
        procedure actExecParamsExecute(Sender: TObject);
        procedure actExecParamsUpdate(Sender: TObject);
        // EAB: attempt to enable menu item using current horrible model
        procedure DevCppDDEServerExecuteMacro(Sender: TObject; Msg: TStrings);
        procedure actShowTipsExecute(Sender: TObject);
        procedure actBrowserUseColorsExecute(Sender: TObject);
        procedure HelpMenuItemClick(Sender: TObject);
        procedure CppParser1StartParsing(Sender: TObject);
        procedure CppParser1EndParsing(Sender: TObject);
        procedure actBrowserViewProjectExecute(Sender: TObject);
        procedure PackageManagerItemClick(Sender: TObject);
        procedure actAbortCompilationUpdate(Sender: TObject);
        procedure actAbortCompilationExecute(Sender: TObject);
        procedure RemoveItem(Node: TTreeNode);
        procedure ProjectViewChanging(Sender: TObject; Node: TTreeNode;
            var AllowChange: Boolean);
        procedure dynactOpenEditorByTagExecute(Sender: TObject);
        procedure actWindowMenuExecute(Sender: TObject);
        procedure actGotoProjectManagerExecute(Sender: TObject);
        procedure actCVSImportExecute(Sender: TObject);
        procedure actCVSCheckoutExecute(Sender: TObject);
        procedure actCVSUpdateExecute(Sender: TObject);
        procedure actCVSCommitExecute(Sender: TObject);
        procedure actCVSDiffExecute(Sender: TObject);
        procedure actCVSLogExecute(Sender: TObject);
        procedure ListItemClick(Sender: TObject);
        procedure ProjectViewCompare(Sender: TObject; Node1, Node2: TTreeNode;
            Data: Integer; var Compare: Integer);
        procedure ProjectViewKeyPress(Sender: TObject; var Key: Char);
        procedure ProjectViewMouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure actCVSAddExecute(Sender: TObject);
        procedure actCVSRemoveExecute(Sender: TObject);
        procedure GoToClassBrowserItemClick(Sender: TObject);
        procedure actBrowserShowInheritedExecute(Sender: TObject);
        procedure actCVSLoginExecute(Sender: TObject);
        procedure actCVSLogoutExecute(Sender: TObject);
        procedure AddWatchBtnClick(Sender: TObject);
        procedure ShowProjectInspItemClick(Sender: TObject);
        procedure lvBacktraceDblClick(Sender: TObject);
        procedure actCompileCurrentFileExecute(Sender: TObject);
        procedure actCompileCurrentFileUpdate(Sender: TObject);
        procedure actSaveProjectAsExecute(Sender: TObject);
        procedure mnuOpenWithClick(Sender: TObject);
        procedure cmbClassesChange(Sender: TObject);
        procedure cmbMembersChange(Sender: TObject);
        procedure CompilerOutputKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure FindOutputKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure DebugTreeKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure DebugVarsPopupPopup(Sender: TObject);
        procedure actAttachProcessUpdate(Sender: TObject);
        procedure actAttachProcessExecute(Sender: TObject);
        procedure actModifyWatchExecute(Sender: TObject);
        procedure ClearallWatchPopClick(Sender: TObject);
        procedure PageControlChanging(Sender: TObject;
            var AllowChange: Boolean);
        procedure mnuCVSClick(Sender: TObject);
        function isFileOpenedinEditor(strFile: string): Boolean;
        procedure OnCompileTerminated(Sender: TObject);
        procedure doDebugAfterCompile(Sender: TObject);
        procedure ControlBar1WM_COMMAND(Sender: TObject;
            var TheMessage: TWMCommand);
        procedure ProjectViewKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure actRestartDebugExecute(Sender: TObject);
        procedure actUpdateDebuggerPaused(Sender: TObject);
        procedure actPauseDebugUpdate(Sender: TObject);
        procedure actPauseDebugExecute(Sender: TObject);
        procedure lvThreadsDblClick(Sender: TObject);
    {procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);}
        procedure actViewToDoListUpdate(Sender: TObject);
        procedure lvTodoCustomDrawItem(Sender: TCustomListView;
            Item: TListItem; State: TCustomDrawState;
            var DefaultDraw: Boolean);
        procedure lvTodoMouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure lvTodoColumnClick(Sender: TObject; Column: TListColumn);
        procedure lvTodoCompare(Sender: TObject; Item1, Item2: TListItem;
            Data: Integer; var Compare: Integer);
        procedure lvTodoDblClick(Sender: TObject);
        procedure chkTodoIncompleteClick(Sender: TObject);
        procedure cmbTodoFilterChange(Sender: TObject);
        procedure ApplicationEvents1Deactivate(Sender: TObject);
        procedure ApplicationEvents1Activate(Sender: TObject);
        procedure CompilerMessagesPanelItemClick(Sender: TObject);
        procedure ResourcesMessagesPanelItemClick(Sender: TObject);
        procedure CompileLogMessagesPanelItemClick(Sender: TObject);
        procedure DebuggingMessagesPanelItemClick(Sender: TObject);
        procedure FindResultsMessagesPanelItemClick(Sender: TObject);
        procedure ToDoListMessagesPanelItemClick(Sender: TObject);
        procedure PageControlDrawTab(Control: TCustomTabControl;
            TabIndex: Integer; const Rect: TRect; Active: Boolean);
        procedure FormCreate(Sender: TObject);
        procedure DebugFinishClick(Sender: TObject);
        procedure RemoveAllBreakpoints1Click(Sender: TObject);

        procedure OnWatches(Locals: PTList);
    procedure ViewMemory1Click(Sender: TObject);

    private
        HelpWindow: HWND;
        fToDoList: TList;
        fToDoSortColumn: Integer;
        fHelpfiles: ToysStringList;
        fTools: TToolController;
        fProjectCount: integer;
        fCompiler: TCompiler;
        bProjectLoading: Boolean;
        OldLeft: integer;
        OldTop: integer;
        OldWidth: integer;
        OldHeight: integer;
        fIsIconized: Boolean;
        ReloadFilenames: TList;


        LeftDockTabs: TJvDockTabHostForm;
        RightDockTabs: TJvDockTabHostForm;
        BottomDockTabs: TJvDockTabHostForm;

        themeManager: TThemeManager;

        function AskBeforeClose(e: TEditor; Rem: boolean;
            var Saved: Boolean): boolean;
        procedure AddFindOutputItem(line, col, unit_, message: string);
        function ParseParams(s: string): string;
        procedure ParseCmdLine;
        procedure BuildBookMarkMenus;
        procedure BuildHelpMenu;
        procedure SetHints;
        procedure HelpItemClick(Sender: TObject);
        procedure MRUClick(Sender: TObject);
        procedure CodeInsClick(Sender: TObjecT);
        procedure ToolItemClick(Sender: TObject);
        procedure WMDropFiles(var msg: TMessage); message WM_DROPFILES;
        procedure LogEntryProc(const msg: string);
        procedure CompOutputProc(const _Line, _Unit, _Message: string);
        procedure CompResOutputProc(const _Line, _Unit, _Message: string);
        procedure CompSuccessProc(const messages: integer);
        procedure MainSearchProc(const SR: TdevSearchResult);
        procedure LoadText(force: boolean);
    public
        function SaveFile(e: TEditor): Boolean;
        function SaveFileAs(e: TEditor): Boolean;
    private
        procedure OpenUnit;
        function PrepareForCompile(rebuild: Boolean): Boolean;
        procedure LoadTheme;
        procedure ShowDebug;
        procedure InitClassBrowser(Full: boolean = False);
        procedure ScanActiveProject;
        procedure CheckForDLLProfiling;
        procedure UpdateAppTitle;
        procedure DoCVSAction(Sender: TObject; whichAction: TCVSAction);
        procedure WordToHelpKeyword;
        procedure OnHelpSearchWord(sender: TObject);
        procedure SetupProjectView;
        procedure BuildOpenWith;
        procedure RebuildClassesToolbar;
        procedure HideCodeToolTip;
{$IFDEF PLUGIN_BUILD}
        procedure OnDockableFormClosed(Sender: TObject;
            var Action: TCloseAction);
        procedure ParseCustomCmdLine(strLst: TStringList);
{$ENDIF}

        procedure SurroundWithClick(Sender: TObject);
        //Private debugger functions
        procedure PrepareDebugger;
        procedure InitializeDebugger;

        //Private To-do list functions
        procedure RefreshTodoList;
        procedure AddTodoFiles(Current, InProject, NotInProject,
            OpenOnly: boolean);
        procedure BuildTodoList;
        function BreakupTodo(Filename: string; sl: TStrings;
            Line: integer; Token: string;
            HasUser, HasPriority: boolean): Integer;

    public
        procedure DoCreateEverything;
        procedure DoApplyWindowPlacement;
        procedure OpenFile(s: string; withoutActivation: Boolean = false);
        // Modified for wx
        procedure OpenProject(s: string);
        function FileIsOpen(const s: string; inprj: boolean = FALSE): integer;
        function GetEditor(const index: integer = -1): TEditor;
        function GetEditorFromFileName(ffile: string;
            donotReOpen: boolean = false): TEditor;
        procedure GotoBreakpoint(bfile: string; bline: integer);
        procedure RemoveActiveBreakpoints;
        procedure AddDebugVar(s: string; when: TWatchBreakOn);
        procedure GotoTopOfStackTrace;
        procedure SetProjCompOpt(idx: integer; Value: boolean);
        // set project's compiler option indexed 'idx' to value 'Value'
        function CloseEditor(index: integer; Rem: boolean;
            all: Boolean = FALSE): Boolean;

        //Debugger stuff
        procedure AddBreakPointToList(line_number: integer; e: TEditor);
        procedure RemoveBreakPointFromList(line_number: integer; e: TEditor);
        procedure OnCallStack(Callstack: TList);
        procedure OnThreads(Threads: TList);
        procedure OnLocals(Locals: TList);

{$IFDEF PLUGIN_BUILD}
        procedure SurroundString(e: TEditor; strStart, strEnd: String);
        procedure CppCommentString(e: TEditor);

        property Compiler: TCompiler read fCompiler write fCompiler;
        property IsIconized: Boolean read fIsIconized;
{$ENDIF}
    private
        procedure UMEnsureRestored(var Msg: TMessage);
            message UM_ENSURERESTORED;
        procedure WMCopyData(var Msg: TWMCopyData); message WM_COPYDATA;
        procedure SetSplashStatus(str: string);
    protected
        procedure CreateParams(var Params: TCreateParams); override;
        procedure WMSyscommand(var Message: TWmSysCommand);
            message WM_SYSCOMMAND;
        procedure WMActivate(var Msg: TWMActivate); message WM_Activate;

    public
        frmReportDocks: array[0..5] of TForm;

        function SaveFileInternal(e: TEditor;
            bParseFile: Boolean = true): Boolean;

    public
        fProject: TProject;
        fDebugger: TDebugger;
        CacheCreated: Boolean;
        frmProjMgrDock: TForm;
        defaultHelpF1: Boolean;

{$IFDEF PLUGIN_BUILD}
        plugins: Array of IPlug_In;
        unit_plugins: TIntegerHash;
        plugin_modules: Array of Integer;
        delphi_plugins: Array of Integer;
        c_plugins: Array of Integer;
        packagesCount: Integer;
        librariesCount: Integer;
        pluginsCount: Integer;
        current_max_toolbar_left: Integer;
        current_max_toolbar_top: Integer;
        ToolsMenuOffset: Integer;
        activePluginProject: String;
        procedure InitPlugins;
        function ListDirectory(const Path: String; Attr: Integer): TStringList;
        function IsEditorAssigned(editorName: String = ''): Boolean;
        function IsProjectAssigned: Boolean;
        function IsClassBrowserEnabled: Boolean;
        procedure ReParseFile(FileName: String);
        function GetDMNum: Integer;
        function GetProjectFileName: String;
        procedure CloseEditorInternal(eX: TEditor);
        function SaveFileFromPlugin(FileName: String;
            forcing: Boolean = FALSE): Boolean;
        procedure CloseEditorFromPlugin(FileName: String);
        procedure ActivateEditor(EditorFilename: String);
        function RetrieveUserName(var buffer: array of char;
            size: dword): Boolean;
        procedure CreateEditor(strFileN: String; extension: String;
            InProject: Boolean);
        procedure PrepareFileForEditor(currFile: String;
            insertProj: Integer; creatingProject: Boolean;
            assertMessage: Boolean;
            alsoReasignEditor: Boolean; assocPlugin: String);
        procedure UnSetActiveControl;
        function GetActiveEditorName: String;
        procedure UpdateEditor(filename: String; messageToDysplay: String);
        function GetEditorText(FileName: String): TSynEdit;
        function GetEditorTabSheet(FileName: String): TTabSheet;
        function IsEditorModified(FileName: String): Boolean;
        function isFunctionAvailableInEditor(intClassID: Integer;
            strFunctionName: String; var intLineNum: Integer;
            var strFname: String): boolean;
        function isFunctionAvailable(intClassID: Integer;
            strFunctionName: String): boolean;
        function FindStatementID(strClassName: string;
            var boolFound: Boolean): Integer;
        procedure TouchEditor(editorName: String);
        function GetSuggestedInsertionLine(StID: Integer;
            AddScopeStr: Boolean): Integer;
        function GetFunctionsFromSource(classname: string;
            var strLstFuncs: TStringList): Boolean;
        procedure EditorInsertDefaultText(editorName: String);
        function GetPageControlActivePageIndex: Integer;
        procedure SetEditorModified(editorName: String; modified: Boolean);
        procedure GetClassNameLocationsInEditorFiles(
            var HppStrLst, CppStrLst: TStringList;
            FileName, FromClassName, ToClassName: string);
        function DoesFileAlreadyExists(FileName: String): Boolean;
        procedure AddProjectUnit(FileName: String; b: Boolean);
        procedure CloseUnit(FileName: String);
        function GetActiveTabSheet: TTabSheet;
        function GetLangString(index: Integer): String;
        function IsUsingXPTheme: Boolean;
        function GetConfig: String;
        function GetExec: String;
        function OpenUnitInProject(s: String): Boolean;
        procedure ChangeProjectProfile(Index: Integer);
        function GetUntitledFileName: String;
        function GetDevDirsConfig: String;
        function GetDevDirsDefault: String;
        function GetDevDirsTemplates: String;
        function GetDevDirsExec: String;
        function GetCompilerProfileNames(
            var defaultProfileIndex: Integer): TStrings;
        function GetRealPathFix(BrokenFileName: String;
            Directory: String = ''): String;
        function FileAlreadyExistsInProject(s: String): Boolean;
        function IsProjectNotNil: Boolean;
        function GetDmMainRes: TSynRCSyn;
        procedure SetPageControlActivePageEditor(editorName: String);
        procedure ToggleDockForm(form: TForm; b: Boolean);
        procedure SendToFront;
        procedure forceEditorFocus;
{$ENDIF}
        function OpenWithAssignedProgram(strFileName: String): boolean;
    end;


// added 25/2/2011
  PWatchVar = ^TWatchVar;
  TWatchVar = packed record
    Number: Integer;
    Name: string;
    Value: string;
    Location: string;
  end;
//end added

var
    MainForm: TMainForm;

implementation

uses
{$IFDEF WIN32}
    ShellAPI, IniFiles, Clipbrd, MultiLangSupport, version,
    devcfg, datamod, helpfrm, NewProjectFrm, AboutFrm, PrintFrm,
    CompOptionsFrm, EditorOptfrm, Incrementalfrm, Search_Center, Envirofrm,
    SynEditTypes, JvAppIniStorage, JvAppStorage,
    debugfrm, Types, Prjtypes, devExec,
    NewTemplateFm, FunctionSearchFm, NewMemberFm, NewVarFm, NewClassFm,
    ProfileAnalysisFm, //debugwait,
    FilePropertiesFm, AddToDoFm,
    ImportMSVCFm, CPUFrm, FileAssocs, TipOfTheDayFm, Splash,
    WindowListFrm, ParamsFrm, ProcessListFrm, ModifyVarFrm,
    devMsgBox, ComObj, uvista

{$IFDEF PLUGIN_BUILD}
    //Our dependencies
    , FilesReloadFrm, debugMem

{$ENDIF}
    ;
{$ENDIF}
{$IFDEF LINUX}
  Xlib, IniFiles, QClipbrd, MultiLangSupport, version,
  devcfg, datamod, helpfrm, NewProjectFrm, AboutFrm, PrintFrm,
  CompOptionsFrm, EditorOptfrm, Incrementalfrm, Search_Center, Envirofrm,
  QSynEdit, QSynEditTypes,
  CheckForUpdate, debugfrm, Prjtypes, devExec,
  NewTemplateFm, FunctionSearchFm, NewMemberFm, NewVarFm, NewClassFm,
  ProfileAnalysisFm, // debugwait,
  FilePropertiesFm, AddToDoFm, ViewToDoFm,
  ImportMSVCFm, CPUFrm, FileAssocs, TipOfTheDayFm, Splash,
  WindowListFrm, ParamsFrm, ProcessListFrm, ModifyVarFrm;
{$ENDIF}

{$R *.dfm}

var
    fFirstShow: boolean;

const
    cCompTab = 0;
    cResTab = 1;
    cLogTab = 2;
    cDebugTab = 3;
    cFindTab = 4;
    INT_BRACES = 1;
    INT_TRY_CATCH = 2;
    INT_C_COMMENT = 3;
    INT_FOR = 4;
    INT_FOR_I = 5;
    INT_WHILE = 6;
    INT_DO_WHILE = 7;
    INT_IF = 8;
    INT_IF_ELSE = 9;
    INT_SWITCH = 10;
    INT_CPP_COMMENT = 11;

type
    PToDoRec = ^TToDoRec;
    TToDoRec = packed record
        TokenIndex: integer;
        Filename: string;
        Line: integer;
        ToLine: integer;
        User: string;
        Priority: integer;
        Description: string;
        IsDone: boolean;
    end;


procedure TMainForm.CreateParams(var Params: TCreateParams);
begin
    inherited;
    //inherited CreateParams(Params);
    Params.ExStyle := Params.ExStyle and not WS_EX_TOOLWINDOW or
        WS_EX_APPWINDOW;
    StrCopy(Params.WinClassName, cWindowClassName);
end;

procedure TMainForm.UMEnsureRestored(var Msg: TMessage);
begin
    if IsIconic(Application.Handle) then
        Application.Restore;
    if not Visible then
        Visible := True;
    Application.BringToFront;
end;

procedure TMainForm.WMCopyData(var Msg: TWMCopyData);
var
    PData: PChar;
    Param: string;
    strLstParams: TStringList;
begin
    if Msg.CopyDataStruct.dwData <> cCopyDataWaterMark then
    begin
        exit;
        //raise Exception.Create('Invalid data structure passed in WM_COPYDATA');
    end;
    PData := Msg.CopyDataStruct.lpData;
    strLstParams := TStringList.Create;
    while PData^ <> #0 do
    begin
        strLstParams.add(StrPas(PData));
        //ProcessParam(Param);
        Inc(PData, Length(Param) + 1);
    end;
    Msg.Result := 1;
    ParseCustomCmdLine(strLstParams);
end;

procedure TMainForm.SetSplashStatus(str: string);
begin
    if assigned(SplashForm) then
        SplashForm.StatusBar.SimpleText := str + '...';
end;

// This method is called from devcpp.dpr. I removed it from OnCreate, because
// all this stuff take pretty much time and it makes the application like it
// hangs. So while 'Creating' the form is hidden and when it's done, it's
// displayed without 'lag' and it's immediately ready to use ...
procedure TMainForm.DoCreateEverything;
var
    I: Integer;
    NewDock: TForm;
    NewDocks: TList;
{$IFDEF PLUGIN_BUILD}
    lbDockClient1: TJvDockClient;
    ini: TiniFile;
{$ENDIF}

    procedure AddDockTab(Tab: TForm);
    begin
        NewDocks.Add(Tab);
        with TJvDockClient.Create(Tab) do
        begin
            Name := Tab.Name + 'Client';
            DirectDrag := True;
            DockStyle := DockServer.DockStyle;
        end;
    end;
begin

    //Initialize the docking style engine
    DesktopFont := True;
    NewDocks := TList.Create;

    DockServer.DockStyle := TJvDockVSNetStyle.Create(Self);
    DockServer.DockStyle.TabServerOption.HotTrack := True;
    with TJvDockVIDConjoinServerOption(
            DockServer.DockStyle.ConjoinServerOption) do
    begin
        ActiveFont.Name := Font.Name;
        InactiveFont.Name := Font.Name;
        ActiveFont.Size := Font.Size;
        InactiveFont.Size := Font.Size;
    end;
    with TJvDockVIDTabServerOption(DockServer.DockStyle.TabServerOption) do
    begin
        ActiveFont.Name := Font.Name;
        InactiveFont.Name := Font.Name;
        ActiveFont.Size := Font.Size;
        InactiveFont.Size := Font.Size;
    end;

    fToDoList := TList.Create;
    fToDoSortColumn := 0;
    fFirstShow := True;

{$IFDEF PLUGIN_BUILD}

    activePluginProject := '';
    //Project inspector
    frmProjMgrDock := TForm.Create(self);
    frmProjMgrDock.ParentFont := True;
    frmProjMgrDock.Font.Assign(Font);

    with frmProjMgrDock do
    begin
        Name := 'frmProjMgrDock';
        Caption := 'Project Inspector';
        BorderStyle := bsSizeToolWin;
        Color := clBtnFace;
        Width := 300;

        DockSite := True;
        DragKind := dkDock;
        DragMode := dmAutomatic;
        FormStyle := fsStayOnTop;
        OnClose := OnDockableFormClosed;

        lbDockClient1 := TJvDockClient.Create(frmProjMgrDock);
        with lbDockClient1 do
        begin
            Name := 'lbDockClient1';
            DirectDrag := True;
            DockStyle := DockServer.DockStyle;
        end;
    end;

    //Reparent the project inspector
    LeftPageControl.Align := alClient;
    LeftPageControl.Parent := frmProjMgrDock;

    tbMain.Left := devData.ToolbarMainX;
    tbMain.Top := devData.ToolbarMainY;
    tbEdit.Left := devData.ToolbarEditX;
    tbEdit.Top := devData.ToolbarEditY;
    tbCompile.Left := devData.ToolbarCompileX;
    tbCompile.Top := devData.ToolbarCompileY;
    tbDebug.Left := devData.ToolbarDebugX;
    tbDebug.Top := devData.ToolbarDebugY;
    tbProject.Left := devData.ToolbarProjectX;
    tbProject.Top := devData.ToolbarProjectY;
    tbOptions.Left := devData.ToolbarOptionsX;
    tbOptions.Top := devData.ToolbarOptionsY;
    tbSpecials.Left := devData.ToolbarSpecialsX;
    tbSpecials.Top := devData.ToolbarSpecialsY;
    tbSearch.Left := devData.ToolbarSearchX;
    tbSearch.Top := devData.ToolbarSearchY;
    tbClasses.Left := devData.ToolbarClassesX;
    tbClasses.Top := devData.ToolbarClassesY;

  {$IFDEF PLUGIN_BUILD}
    current_max_toolbar_left := 0;
    current_max_toolbar_top := 0;

    If tbMain.Left > current_max_toolbar_left then
        current_max_toolbar_left := tbMain.Left;
    If tbMain.Top > current_max_toolbar_top then
        current_max_toolbar_top := tbMain.Top;
    If tbEdit.Left > current_max_toolbar_left then
        current_max_toolbar_left := tbEdit.Left;
    If tbEdit.Top > current_max_toolbar_top then
        current_max_toolbar_top := tbEdit.Top;
    If tbCompile.Left > current_max_toolbar_left then
        current_max_toolbar_left := tbCompile.Left;
    If tbCompile.Top > current_max_toolbar_top then
        current_max_toolbar_top := tbCompile.Top;
    If tbDebug.Left > current_max_toolbar_left then
        current_max_toolbar_left := tbDebug.Left;
    If tbDebug.Top > current_max_toolbar_top then
        current_max_toolbar_top := tbDebug.Top;
    If tbProject.Left > current_max_toolbar_left then
        current_max_toolbar_left := tbProject.Left;
    If tbProject.Top > current_max_toolbar_top then
        current_max_toolbar_top := tbProject.Top;
    If tbOptions.Left > current_max_toolbar_left then
        current_max_toolbar_left := tbOptions.Left;
    If tbOptions.Top > current_max_toolbar_top then
        current_max_toolbar_top := tbOptions.Top;
    If tbSpecials.Left > current_max_toolbar_left then
        current_max_toolbar_left := tbSpecials.Left;
    If tbSpecials.Top > current_max_toolbar_top then
        current_max_toolbar_top := tbSpecials.Top;
    If tbSearch.Left > current_max_toolbar_left then
        current_max_toolbar_left := tbSearch.Left;
    If tbSearch.Top > current_max_toolbar_top then
        current_max_toolbar_top := tbSearch.Top;
    If tbClasses.Left > current_max_toolbar_left then
        current_max_toolbar_left := tbClasses.Left;
    If tbClasses.Top > current_max_toolbar_top then
        current_max_toolbar_top := tbClasses.Top;

    XPMenu.Active := true;
    // EAB Comment: Prevent XPMenu to screw plugin Controls *Hackish*
    InitPlugins;
    XPMenu.Active := devData.XPTheme;     // EAB Comment: Reload XPMenu stuff
  {$ENDIF}

    PageControl.OwnerDraw := devData.HiliteActiveTab;

    frmProjMgrDock.ManualDock(DockServer.LeftDockPanel, nil, alTop);
    ShowDockForm(frmProjMgrDock);

    //"Surround With" menu
    trycatchPopItem.Tag := INT_TRY_CATCH;
    trycatchPopItem.OnClick := SurroundWithClick;
    forloopPopItem.Tag := INT_FOR;
    forloopPopItem.OnClick := SurroundWithClick;
    forintloopPopItem.Tag := INT_FOR_I;
    forintloopPopItem.OnClick := SurroundWithClick;
    whileLoopPopItem.Tag := INT_WHILE;
    whileLoopPopItem.OnClick := SurroundWithClick;
    dowhileLoopPopItem.Tag := INT_DO_WHILE;
    dowhileLoopPopItem.OnClick := SurroundWithClick;
    ifLoopPopItem.Tag := INT_IF;
    ifLoopPopItem.OnClick := SurroundWithClick;
    ifelseloopPopItem.Tag := INT_IF_ELSE;
    ifelseloopPopItem.OnClick := SurroundWithClick;
    switchLoopPopItem.Tag := INT_SWITCH;
    switchLoopPopItem.OnClick := SurroundWithClick;
    bracesPopItem.Tag := INT_BRACES;
    bracesPopItem.OnClick := SurroundWithClick;
    CStyleCommentPopItem.Tag := INT_C_COMMENT;
    CStyleCommentPopItem.OnClick := SurroundWithClick;
    CPPStyleCommentPopItem.Tag := INT_CPP_COMMENT;
    CPPStyleCommentPopItem.OnClick := SurroundWithClick;

    //Setting data for the newly created GUI

    //Variable for clearing up inspector data. Added because there is a AV when
    //adding a function from the event list
{$ENDIF}

    // register file associations and DDE services
    DDETopic := DevCppDDEServer.Name;
    CheckAssociations;
    DragAcceptFiles(Self.Handle, TRUE);
    dmMain := TdmMain.Create(Self);
    ReloadFilenames := TList.Create;
    fHelpfiles := ToysStringList.Create;
    fTools := TToolController.Create;
    Caption := DEVCPP;
    // + ' ' + DEVCPP_VERSION; EAB: Why put the version there? No one does that

    // set visiblity to previous sessions state
    if devData.ClassView then
        LeftPageControl.ActivePage := ClassSheet
    else
        LeftPageControl.ActivePage := ProjectSheet;
    actStatusbar.Checked := devData.Statusbar;
    actStatusbarExecute(nil);

    fProjectCount := 0;
    fProject := nil;
    fCompiler := TCompiler.Create;
    fCompiler.OnLogEntry := LogEntryProc;
    fCompiler.OnOutput := CompOutputProc;
    fCompiler.OnResOutput := CompResOutputProc;
    fCompiler.OnSuccess := CompSuccessProc;

    InitializeDebugger;
    SearchCenter.SearchProc := MainSearchProc;
    SearchCenter.PageControl := PageControl;

    SetSplashStatus('Loading themes');
    devImageThemes := TDevImageThemeFactory.Create;
    devImageThemes.LoadFromDirectory(devDirs.Themes);

    SetSplashStatus('Loading languages');
    if devData.First or (devData.Language = '') then
    begin
        if devData.First then
            dmMain.InitHighlighterFirstTime;
        Lang.SelectLanguage;
        devData.FileDate := FileAge(Application.ExeName);
        devData.First := FALSE;
        SaveOptions;
    end
    else
        Lang.Open(devData.Language);

    devData.Version := DEVCPP_VERSION;
    SetSplashStatus('Loading 3rd-party tools');
    with fTools do
    begin
        Menu := ToolsMenu;
        Offset := ToolsMenu.Indexof(PackageManagerItem) + ToolsMenuOffset;
        ToolClick := ToolItemClick;
        BuildMenu;
    end;

    LoadText(FALSE);
    devShortcuts1.Filename := devDirs.Config + DEV_SHORTCUTS_FILE;

    //Some weird problem when upgrading to new version
{$IFNDEF PRIVATE_BUILD}
    try
{$ENDIF}
        devShortcuts1.Load;
{$IFNDEF PRIVATE_BUILD}
    except
    end;
{$ENDIF}

    Application.HelpFile :=
        ValidateFile(DEV_MAINHELP_FILE, devDirs.Help, TRUE);

    SetSplashStatus('Loading code completion cache');
    if Assigned(SplashForm) then
        CppParser1.OnCacheProgress := SplashForm.OnCacheProgress;
    InitClassBrowser(true {not CacheCreated});
    CppParser1.OnCacheProgress := nil;

    SetSplashStatus('Initializing workspace');
    ToolMainItem.checked := devData.ToolbarMain;
    ToolEditItem.Checked := devData.ToolbarEdit;
    ToolCompileandRunItem.Checked := devData.ToolbarCompile;
    ToolDebugItem.Checked := devData.ToolbarDebug;
    ToolProjectItem.Checked := devData.ToolbarProject;
    ToolOptionItem.Checked := devData.ToolbarOptions;
    ToolSpecialsItem.Checked := devData.ToolbarSpecials;
    ToolSearchItem.Checked := devData.ToolbarSearch;
    ToolClassesItem.Checked := devData.ToolbarClasses;
    ToolbarClick(nil);

    fCompiler.RunParams := '';
    devCompiler.UseExecParams := True;
    //if pluginsCount = 0 then
    //    XPMenu.Active := false;
    for I := 0 to MessageControl.PageCount - 1 do
    begin
        NewDock := TForm.Create(self);
        NewDock.ParentFont := True;
        NewDock.Font.Assign(Font);
        frmReportDocks[I] := NewDock;
        with NewDock do
        begin
            Tag := MessageControl.Pages[I].ImageIndex;
            Name := MessageControl.Pages[I].Name + 'Dock';
            Caption := MessageControl.Pages[I].Caption;
            BorderStyle := bsSizeToolWin;
            devImageThemes.CurrentTheme.MenuImages.GetIcon(Tag, Icon);

            DockSite := True;
            DragKind := dkDock;
            DragMode := dmAutomatic;
            FormStyle := fsStayOnTop;
            OnClose := OnDockableFormClosed;

            //BorderIcons := BorderIcons - [biSystemMenu];    // Removing close button

            //Transfer all the controls from the message control to the new dock
            while MessageControl.Pages[I].ControlCount > 0 do
                MessageControl.Pages[I].Controls[0].Parent := NewDock;
        end;

        //Add the new dock tab
        AddDockTab(NewDock);
    end;

    if NewDocks.Count >= 2 then
    begin
        BottomDockTabs := ManualTabDock(DockServer.BottomDockPanel,
            NewDocks[0], NewDocks[1]);
        for I := 2 to NewDocks.Count - 1 do
        begin
            ManualTabDockAddPage(BottomDockTabs, NewDocks[I]);
            ShowDockForm(frmReportDocks[I]);
        end;
    end
    else
    begin
        with TWinControl(NewDocks[0]) do
        begin
            ManualDock(DockServer.BottomDockPanel);
            Show;
        end;
    end;

    //Show the compiler output list-view
    ShowDockForm(frmReportDocks[0]);

    if pluginsCount = 0 then
        XPMenu.Active := devData.XPTheme;
    // EAB Hack to prevent crash in message tabs when not using the designer.

    //Settle the docking sizes
    DockServer.LeftDockPanel.Width := 200;
    DockServer.BottomDockPanel.Height := 175;
    DockServer.TopDockPanel.JvDockManager.GrabberSize := 22;
    DockServer.BottomDockPanel.JvDockManager.GrabberSize := 22;
    DockServer.LeftDockPanel.JvDockManager.GrabberSize := 22;
    DockServer.RightDockPanel.JvDockManager.GrabberSize := 22;

    DebugMemFrm.Hide;
    
    //Clean up after ourselves
    NewDocks.Free;
    RemoveControl(MessageControl);
    MessageControl.Free;

    //Make sure the status bar is BELOW the bottom dock panel
    Statusbar.Top := Self.ClientHeight;
end;

procedure TMainForm.AddBreakPointToList(line_number: integer; e: TEditor);
var
    Breakpoint: TBreakpoint;
begin
    Breakpoint := TBreakpoint.Create;
    with Breakpoint do
    begin
        Line := line_number;
        Filename := e.Filename;
        Editor := e;
    end;
    fDebugger.AddBreakpoint(Breakpoint);
end;

procedure TMainForm.RemoveBreakPointFromList(line_number: integer; e: TEditor);
var
    Breakpoint: TBreakpoint;
begin
    Breakpoint := TBreakpoint.Create;
    with Breakpoint do
    begin
        Line := line_number;
        Filename := e.Filename;
        Editor := e;
    end;
    fDebugger.RemoveBreakpoint(Breakpoint);
end;

procedure TMainForm.OnCallStack(Callstack: TList);
var
    I: Integer;
begin
    Assert(Assigned(Callstack), 'Callstack must be valid');
    lvBacktrace.Items.BeginUpdate;
    lvBacktrace.Items.Clear;

    for I := 0 to Callstack.Count - 1 do
        with lvBacktrace.Items.Add do
        begin
            Caption := PStackFrame(Callstack[I])^.FuncName;
            SubItems.Add(PStackFrame(Callstack[I])^.Args);
            SubItems.Add(PStackFrame(Callstack[I])^.Filename);
            if PStackFrame(Callstack[I])^.Line <> 0 then
                SubItems.Add(IntToStr(PStackFrame(Callstack[I])^.Line));
            Data := CppParser1.Locate(Caption, True);
        end;
    lvBacktrace.Items.EndUpdate;
end;

procedure TMainForm.OnThreads(Threads: TList);
var
    I: Integer;
begin
    lvThreads.Items.BeginUpdate;
    lvThreads.Items.Clear;

    for I := 0 to Threads.Count - 1 do
        with lvThreads.Items.Add do
        begin
            if PDebuggerThread(Threads[I])^.Active then
            begin
                Caption := '*';
                lvThreads.Selected := lvThreads.Items[Index];
                MakeVisible(false);
            end
            else
                Caption := '';
            SubItems.Add(PDebuggerThread(Threads[I])^.Index);
            SubItems.Add(PDebuggerThread(Threads[I])^.ID);
        end;
    lvThreads.Items.EndUpdate;
end;

procedure TMainForm.OnLocals(Locals: TList);
var
    I: Integer;
begin
    Assert(Assigned(Locals), 'Locals list must be valid');
    lvLocals.Items.BeginUpdate;
    lvLocals.Items.Clear;

    for I := 0 to Locals.Count - 1 do
        with lvLocals.Items.Add do
        begin
            Caption := PWatchVar(Locals[I])^.Name;
            SubItems.Add(PWatchVar(Locals[I])^.Value);
            SubItems.Add(PWatchVar(Locals[I])^.Location);
        end;
    lvLocals.Items.EndUpdate;
end;

// This method is called from devcpp.dpr. It's called at the very last, because
// it forces the form to show and we only want to display the form when it's
// ready and fully created
procedure TMainForm.DoApplyWindowPlacement;
{$IFDEF PLUGIN_BUILD}
var
    i: Integer;
{$ENDIF PLUGIN_BUILD}
begin
    if devData.WindowPlacement.rcNormalPosition.Right <> 0 then
        SetWindowPlacement(Self.Handle, @devData.WindowPlacement)
    else
    if not CacheCreated then
        // this is so weird, but the following call seems to take a lot of time to execute
        Self.Position := poScreenCenter;

    //Load the window layout from the INI file
    if FileExists(ExtractFilePath(devData.INIFile) + 'layout' + INI_EXT) then
        LoadDockTreeFromFile(ExtractFilePath(devData.INIFile) +
            'layout' + INI_EXT);

    // Check the appropiate menu if panel is enabled
    ShowProjectInspItem.Checked := frmProjMgrDock.Visible;

    CompilerMessagesPanelItem.Checked := frmReportDocks[0].Visible;
    ResourcesMessagesPanelItem.Checked := frmReportDocks[1].Visible;
    CompileLogMessagesPanelItem.Checked := frmReportDocks[2].Visible;
    DebuggingMessagesPanelItem.Checked := frmReportDocks[3].Visible;
    FindResultsMessagesPanelItem.Checked := frmReportDocks[4].Visible;
    ToDoListMessagesPanelItem.Checked := frmReportDocks[5].Visible;

{$IFDEF PLUGIN_BUILD}
    for i := 0 to pluginsCount - 1 do
	       plugins[i].AfterStartupCheck;
{$ENDIF}

    //Show the main form
    Show;
end;


procedure TMainForm.LoadTheme;
var
    Idx: Integer;
begin
{$IFNDEF PRIVATE_BUILD}
    try
{$ENDIF}
        XPMenu.Active := devData.XPTheme;

{$IFNDEF COMPILER_7_UP}
        //Initialize theme support
        themeManager := TThemeManager.Create(Self);
        with themeManager do
            Options := [toAllowNonClientArea, toAllowControls,
                toAllowWebContent, toSubclassAnimate, toSubclassButtons,
                toSubclassCheckListbox, toSubclassDBLookup, toSubclassFrame,
                toSubclassGroupBox, toSubclassListView, toSubclassPanel,
                toSubclassTabSheet, toSubclassSpeedButtons,
                toSubclassStatusBar,
                toSubclassTrackBar, toSubclassWinControl, toResetMouseCapture,
                toSetTransparency, toAlternateTabSheetDraw];
{$ENDIF}
{$IFNDEF PRIVATE_BUILD}
    except
    end;
{$ENDIF}

    if devImageThemes.IndexOf(devData.Theme) < 0 then
        devData.Theme := devImageThemes.Themes[0].Title;
    // 0 = New look (see ImageTheme.pas)

    //make sure the theme in question is in the list
    Idx := devImageThemes.IndexOf(devData.Theme);
    if Idx > -1 then
    begin
        devImageThemes.ActivateTheme(devData.Theme);

        with devImageThemes do
        begin
            alMain.Images := CurrentTheme.MenuImages;
            MainMenu.Images := CurrentTheme.MenuImages;
            ProjectView.Images := CurrentTheme.ProjectImages;
            MessagePopup.Images := CurrentTheme.MenuImages;
            EditorPopupMenu.Images := CurrentTheme.MenuImages;
            ProjectPopup.Images := CurrentTheme.MenuImages;
            UnitPopup.Images := CurrentTheme.MenuImages;
            DebugVarsPopup.Images := CurrentTheme.MenuImages;

            tbMain.Images := CurrentTheme.MenuImages;
            tbCompile.Images := CurrentTheme.MenuImages;
            tbDebug.Images := CurrentTheme.MenuImages;
            tbOptions.Images := CurrentTheme.MenuImages;
            tbProject.Images := CurrentTheme.MenuImages;
            tbClasses.Images := CurrentTheme.MenuImages;
            tbedit.Images := CurrentTheme.MenuImages;
            tbSearch.Images := CurrentTheme.MenuImages;
            tbSpecials.Images := CurrentTheme.SpecialImages;
            HelpMenu.SubMenuImages := CurrentTheme.HelpImages;
            HelpPop.Images := CurrentTheme.HelpImages;
            ClassBrowser1.Images := CurrentTheme.BrowserImages;

            //TODO: lowjoel: I can update the icon of the form, but how do you get JVCL
            //               to update the image list copy that they have too?
            //Copy the theme images for the report window
            for Idx := 0 to Length(frmReportDocks) - 1 do
                CurrentTheme.MenuImages.GetIcon(frmReportDocks[Idx].Tag,
                    frmReportDocks[Idx].Icon);
        end;
    end;

    fTools.BuildMenu; // reapply icons to tools
end;

procedure TMainForm.FormShow(Sender: TObject);
begin

    //TODO: lowjoel: Do we need to track whether this is the first show? Can someone
    //               trace into the code to see if this function is called more than once?
    if fFirstShow then
    begin
        cmbTodoFilter.ItemIndex := 5;
        cmbTodoFilter.OnChange(cmbTodoFilter);

        LoadTheme;
        BuildHelpMenu;
    {FormProgress.Parent := StatusBar;    // EAB: Check this out ***
    SetWindowLong(FormProgress.Handle, GWL_EXSTYLE,
      GetWindowLong(FormProgress.Handle, GWL_EXSTYLE) - WS_EX_STATICEDGE);}
        dmMain.MRUMenu := ReOpenItem;
        dmMain.MRUOffset := 2;
        dmMain.MRUMax := devData.MRUMax;
        dmMain.MRUClick := MRUClick;
        dmMain.CodeMenu := InsertItem;
        dmMain.CodePop := InsertPopItem;
        dmMain.CodeClick := CodeInsClick;
        dmMain.CodeOffset := 2;
        dmMain.LoadDataMod;

        if ParamCount > 0 then
            ParseCmdLine;

        if devData.MsgTabs then
            DockServer.DockStyle.TabServerOption.TabPosition := tpTop
        else
            DockServer.DockStyle.TabServerOption.TabPosition := tpBottom;

        SetupProjectView;
        fFirstShow := False;
    end;
end;

{$IFDEF PLUGIN_BUILD}
procedure TMainForm.OnDockableFormClosed(Sender: TObject;
    var Action: TCloseAction);
begin
    //Sanity check
    if not (Sender is TForm) then
        Exit;

    if TForm(Sender) = frmProjMgrDock then
        ShowProjectInspItem.Checked := False
    else
    if TForm(Sender) = frmReportDocks[0] then
        CompilerMessagesPanelItem.Checked := False
    else
    if TForm(Sender) = frmReportDocks[1] then
        ResourcesMessagesPanelItem.Checked := False
    else
    if TForm(Sender) = frmReportDocks[2] then
        CompileLogMessagesPanelItem.Checked := False
    else
    if TForm(Sender) = frmReportDocks[3] then
        DebuggingMessagesPanelItem.Checked := False
    else
    if TForm(Sender) = frmReportDocks[4] then
        FindResultsMessagesPanelItem.Checked := False
    else
    if TForm(Sender) = frmReportDocks[5] then
        ToDoListMessagesPanelItem.Checked := False;
end;
{$ENDIF}

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
    JvAppIniFileStorage: TJvAppIniFileStorage;
{$IFDEF PLUGIN_BUILD}
    items: TList;
    toolbar: TToolBar;
    i, j: Integer;
    panel1: TForm;
    panel2: TForm;
{$ENDIF PLUGIN_BUILD}
begin
    if IsWindow(HelpWindow) then
        SendMessage(HelpWindow, WM_CLOSE, 0, 0);

    if assigned(fProject) then
        actCloseProject.Execute;
    if Assigned(fProject) then
    begin
        Action := caNone;
        Exit;
    end;

    if PageControl.PageCount > 0 then
        actCloseAll.execute;
    if PageControl.PageCount > 0 then
    begin
        Action := caNone;
        Exit;
    end;

    GetWindowPlacement(Self.Handle, @devData.WindowPlacement);
    JvAppIniFileStorage := TJvAppIniFileStorage.Create(Self);
    JvAppIniFileStorage.FileName :=
        ExtractFilePath(devData.INIFile) + 'layout' + INI_EXT;
    JvAppIniFileStorage.AutoFlush := True;
    JvAppIniFileStorage.AutoReload := True;
    JvAppIniFileStorage.BeginUpdate;
    try
        SaveDockTreeToAppStorage(JvAppIniFileStorage);
    finally
        JvAppIniFileStorage.Location := flCustom;
        JvAppIniFileStorage.EndUpdate;
        JvAppIniFileStorage.Flush;
        JvAppIniFileStorage.Destroy;
    end;

    devData.ClassView := LeftPageControl.ActivePage = ClassSheet;
    devData.ToolbarMainX := tbMain.Left;
    devData.ToolbarMainY := tbMain.Top;
    devData.ToolbarEditX := tbEdit.Left;
    devData.ToolbarEditY := tbEdit.Top;
    devData.ToolbarCompileX := tbCompile.Left;
    devData.ToolbarCompileY := tbCompile.Top;
    devData.ToolbarDebugX := tbDebug.Left;
    devData.ToolbarDebugY := tbDebug.Top;
    devData.ToolbarProjectX := tbProject.Left;
    devData.ToolbarProjectY := tbProject.Top;
    devData.ToolbarOptionsX := tbOptions.Left;
    devData.ToolbarOptionsY := tbOptions.Top;
    devData.ToolbarSpecialsX := tbSpecials.Left;
    devData.ToolbarSpecialsY := tbSpecials.Top;
    devData.ToolbarSearchX := tbSearch.Left;
    devData.ToolbarSearchY := tbSearch.Top;
    devData.ToolbarClassesX := tbClasses.Left;
    devData.ToolbarClassesY := tbClasses.Top;

  {$IFDEF PLUGIN_BUILD}

    //if FileExists(devDirs.Config + ChangeFileExt(ExtractFileName(Application.EXEName), '.cfg')) then   // EAB hack first run closing problems
    //begin
    DockServer.LeftDockPanel.Visible := false;
    // More "gratious" closing of panels, due to ManualTabDock plugin removal requirement
    DockServer.RightDockPanel.Visible := false;
    DockServer.BottomDockPanel.Visible := false;
    //end;

    themeManager.Destroy;
    for i := 0 to pluginsCount - 1 do
    begin

        items := plugins[i].Retrieve_LeftDock_Panels;
        if items <> nil then
        begin
            for j := 0 to items.Count - 1 do
            begin
                panel1 := items[j];
                panel1.Visible := false;
                FindDockClient(panel1).Destroy;
            end;
        end;

        items := plugins[i].Retrieve_RightDock_Panels;
        if items <> nil then
        begin
            for j := 0 to items.Count - 1 do
            begin
                panel1 := items[j];
                panel1.Visible := false;
                FindDockClient(panel1).Destroy;
            end;
        end;

        items := plugins[i].Retrieve_BottomDock_Panels;
        if items <> nil then
        begin
            for j := 0 to items.Count - 1 do
            begin
                panel1 := items[j];
                panel1.Visible := false;
                FindDockClient(panel1).Destroy;
            end;
        end;

        toolbar := plugins[i].Retrieve_Toolbars;
        if toolbar <> nil then
        begin
            devPluginToolbarsX.AddToolbarsX(plugins[i].GetPluginName,
                toolbar.Left);
            devPluginToolbarsY.AddToolbarsY(plugins[i].GetPluginName,
                toolbar.Top);
        end;
        plugins[i].Destroy;
        plugins[i] := nil;
    end;
  {$ENDIF PLUGIN_BUILD}
    SaveOptions;

end;

procedure TMainForm.FormDestroy(Sender: TObject);
{$IFDEF PLUGIN_BUILD}
var
    i: Integer;
{$ENDIF PLUGIN_BUILD}
begin
    if fDebugger.Executing then
        fDebugger.CloseDebugger(Sender);
    fHelpFiles.free;
    fTools.Free;
    fCompiler.Free;
    fDebugger.Free;
    dmMain.Free;
    devImageThemes.Free;
    ReloadFilenames.Free;
    ClassBrowser1.Free;

    while fToDoList.Count > 0 do
        if Assigned(fToDoList[0]) then
        begin
            Dispose(PToDoRec(fToDoList[0]));
            fToDoList.Delete(0);
        end;
    fToDoList.Free;
    devPluginToolbarsX.Free;
    devPluginToolbarsY.Free;

  {$IFDEF PLUGIN_BUILD}
  {$IFNDEF PLUGIN_TESTING}
    for i := 0 to packagesCount - 1 do
        UnloadPackage(plugin_modules[delphi_plugins[i]]);
    for i := 0 to librariesCount - 1 do
        FreeLibrary(plugin_modules[c_plugins[i]]);
  {$ENDIF PLUGIN_TESTING}
    unit_plugins.Free;
  {$ENDIF PLUGIN_BUILD}

    HHCloseAll;     //Close help before shutdown or big trouble
end;

procedure TMainForm.ParseCmdLine;
var
    idx: integer;
    strLstParams: TStringList;
begin
    idx := 1;
    strLstParams := TStringList.Create;
    while idx <= ParamCount do
    begin
        strLstParams.Add(ParamStr(idx));
        inc(idx);
    end;

    ParseCustomCmdLine(strLstParams);
    strLstParams.Destroy;
end;

//This function is derived from the pre parsecmdline function.
//This is also used when activating the devcpp's previous instance
procedure TMainForm.ParseCustomCmdLine(strLst: TStringList);
var
    idx: integer;
    intParamCount: Integer;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
{$ENDIF}
begin
    idx := 0;
    intParamCount := 0;
    while idx <= intParamCount do
    begin
        if (strLst[idx] = CONFIG_PARAM) then
        begin
            idx := idx + 2;
            continue;
        end;
        if FileExists(strLst[idx]) then
        begin
            if GetFileTyp(strLst[idx]) = utPrj then
            begin
                OpenProject(GetLongName(strLst[idx]));
                break; // only open 1 project
            end
            else
            begin
                chdir(ExtractFileDir(strLst[idx]));
{$IFDEF PLUGIN_BUILD}
                for i := 0 to pluginsCount - 1 do
                    plugins[i].OpenFile(GetLongName(strLst[idx]));
{$ENDIF}
                OpenFile(GetLongName(strLst[idx]));
            end;
        end;
        inc(idx);
    end;
end;

procedure TMainForm.BuildBookMarkMenus;
var
    idx: integer;
    s, Text: string;
    GItem,
    TItem: TMenuItem;
begin
    Text := Lang[ID_MARKTEXT];
    ToggleBookMarksItem.Clear;
    GotoBookmarksItem.Clear;
    for idx := 1 to 9 do
    begin
        s := inttostr(idx);
        TItem := TMenuItem.Create(ToggleBookmarksItem);
        TItem.Caption := format('%s &%d', [Text, idx]);
        TItem.OnClick := ToggleBookmarkClick;
        TItem.Tag := idx;
        TItem.ShortCut := ShortCut(ord(s[1]), [ssCTRL]);
        ToggleBookmarksItem.Add(TItem);

        GItem := TMenuItem.Create(GotoBookmarksItem);
        GItem.Caption := TItem.Caption;
        GItem.OnClick := GotoBookmarkClick;
        GItem.Tag := idx;
        GItem.ShortCut := ShortCut(ord(s[1]), [ssAlt]);
        GotoBookmarksItem.Add(GItem);
    end;

    CloneMenu(ToggleBookmarksItem, TogglebookmarksPopItem);
    CloneMenu(GotoBookmarksItem, GotobookmarksPopItem);

end;

procedure TMainForm.BuildHelpMenu;
var
    afile: string;
    ini: Tinifile;
    idx,
    idx2: integer;
    Item,
    Item2: TMenuItem;
begin
    aFile := ValidateFile(DEV_HELP_INI, devDirs.Config, TRUE);
    if aFile = '' then
        exit;

    // delete between "Dev-C++ Help" and first separator
    idx2 := HelpMenu.IndexOf(HelpSep1);
    for idx := pred(idx2) downto 1 do
        HelpMenu[idx].Free;

    // delete between first and second separator
    idx2 := HelpMenu.IndexOf(HelpSep2);
    for idx := pred(idx2) downto Succ(HelpMenu.IndexOf(HelpSep1)) do
        HelpMenu[idx].Free;

    HelpMenu.SubMenuImages := devImageThemes.CurrentTheme.HelpImages;
    //devTheme.Help;

    // since 4.9.6.9, a standard menu entry appeared in HelpPop (Help On DevCpp)
    // so items.clear is not good anymore...
    while HelpPop.Items.Count > 1 do
        HelpPop.Items.Delete(HelpPop.Items.Count - 1);

    ini := TiniFile.Create(aFile);
    try
        if not assigned(fHelpFiles) then
            fHelpFiles := ToysStringList.Create
        else
            fHelpFiles.Clear;

        ini.ReadSections(fHelpFiles);
        if fHelpFiles.Count = 0 then
            exit;

        for idx := 0 to pred(fHelpFiles.Count) do
        begin
            afile := ini.ReadString(fHelpFiles[idx], 'Path', '');
            if (aFile = '') then
                continue;
            if AnsiPos(HTTP, aFile) = 0 then
                aFile := ExpandFileto(aFile, devDirs.Help);
            if (aFile <> '') then
            begin
                fHelpFiles[idx] := format('%s=%s', [fHelpFiles[idx], aFile]);
                if ini.ReadInteger(fHelpFiles.Names[idx], 'Menu', 1) = 1 then
                    idx2 := HelpMenu.IndexOf(HelpSep1)
                else
                    idx2 := HelpMenu.IndexOf(HelpSep2);

                Item := TMenuItem.Create(HelpMenu);
                XPMenu.InitComponent(Item);
                with Item do
                begin
                    Caption := fHelpFiles.Names[idx];
                    if ini.ReadBool(fHelpFiles.Names[idx],
                        'SearchWord', false) then
                        OnClick := OnHelpSearchWord
                    else
                        OnClick := HelpItemClick;
                    if ini.ReadBool(fHelpFiles.Names[idx],
                        'AffectF1', false) then
                    begin
                        defaultHelpF1 := false;
                        ShortCut := TextToShortcut('F1');
                    end;
                    Tag := idx;
                    ImageIndex :=
                        ini.ReadInteger(fHelpFiles.Names[idx], 'Icon', 0);
                end;
                HelpMenu.Insert(idx2, Item);
                if ini.ReadBool(fHelpFiles.Names[idx], 'Pop', false) then
                begin
                    Item2 := TMenuItem.Create(HelpPop);
                    with Item2 do
                    begin
                        Caption := fHelpFiles.Names[idx];
                        OnClick := HelpItemClick;
                        Tag := idx;
                        ImageIndex :=
                            ini.ReadInteger(fHelpFiles.Names[idx], 'Icon', 0);
                    end;
                    HelpPop.Items.Add(Item2);
                end;
            end;
        end;
    finally
        ini.free;
    end;
end;

procedure TMainForm.SetHints;
var
    idx: integer;
begin
    for idx := 0 to pred(alMain.ActionCount) do
        TCustomAction(alMain.Actions[idx]).Hint :=
            StripHotKey(TCustomAction(alMain.Actions[idx]).Caption);
end;

// allows user to drop files from explorer on to form
procedure TMainForm.WMDropFiles(var msg: TMessage);
var
    idx,
    idx2,
    count: integer;
    szFileName: array[0..260] of char;
    pt: TPoint;
    hdl: THandle;
    ProjectFN: String;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
{$ENDIF}
begin
    try
        ProjectFN := '';
        hdl := THandle(msg.wParam);
        count := DragQueryFile(hdl, $FFFFFFFF, nil, 0);
        DragQueryPoint(hdl, pt);

        for idx := 0 to pred(count) do
        begin
            DragQueryFile(hdl, idx, szFileName, sizeof(szFileName));

            // Is there a project?
            if AnsiCompareText(ExtractFileExt(szFileName), DEV_EXT) = 0 then
            begin
                ProjectFN := szFileName;
                Break;
            end;
        end;

        if Length(ProjectFN) > 0 then
            OpenProject(ProjectFN)
        else
            for idx := 0 to pred(count) do
            begin
                DragQueryFile(hdl, idx, szFileName, sizeof(szFileName));
                idx2 := FileIsOpen(szFileName);
                if idx2 <> -1 then
                    TEditor(PageControl.Pages[idx2].Tag).Activate
                else // open file
                begin
{$IFDEF PLUGIN_BUILD}
                    for i := 0 to pluginsCount - 1 do
    	   	               plugins[i].OpenFile(szFileName);
{$ENDIF}
                    OpenFile(szFileName);
                end;
            end;
    finally
        msg.Result := 0;
        DragFinish(THandle(msg.WParam));
    end;
end;

procedure TMainForm.LoadText(force: boolean);
var
    i: Integer;
begin
    with Lang do
    begin
        // Menus
        FileMenu.Caption := Strings[ID_MNU_FILE];
        EditMenu.Caption := Strings[ID_MNU_EDIT];
        SearchMenu.Caption := Strings[ID_MNU_SEARCH];
        ViewMenu.Caption := Strings[ID_MNU_VIEW];
        ProjectMenu.Caption := Strings[ID_MNU_PROJECT];
        ExecuteMenu.Caption := Strings[ID_MNU_EXECUTE];
        DebugMenu.Caption := Strings[ID_MNU_DEBUG];
        ToolsMenu.Caption := Strings[ID_MNU_TOOLS];
        WindowMenu.Caption := Strings[ID_MNU_WINDOW];
        HelpMenu.Caption := Strings[ID_MNU_HELP];

        // file menu
        mnuNew.Caption := Strings[ID_SUB_NEW];
        actNewSource.Caption := Strings[ID_ITEM_NEWSOURCE];
        actNewProject.Caption := Strings[ID_ITEM_NEWPROJECT];
        actNewTemplate.Caption := Strings[ID_ITEM_NEWTEMPLATE];
        actNewRes.Caption := Strings[ID_ITEM_NEWRESOURCE];

        actOpen.Caption := Strings[ID_ITEM_OPEN];
        ReOpenItem.Caption := Strings[ID_SUB_REOPEN];
        actHistoryClear.Caption := Strings[ID_ITEM_CLEARHISTORY];
        actSave.Caption := Strings[ID_ITEM_SAVEFILE];
        actSaveAs.Caption := Strings[ID_ITEM_SAVEAS];
        SaveProjectAsItem.Caption := Strings[ID_ITEM_SAVEASPROJECT];
        actSaveAll.Caption := Strings[ID_ITEM_SAVEALL];
        actClose.Caption := Strings[ID_ITEM_CLOSEFILE];
        actCloseAll.Caption := Strings[ID_ITEM_CLOSEALL];
        actCloseProject.Caption := Strings[ID_ITEM_CLOSEPROJECT];

        actFileProperties.Caption := Strings[ID_ITEM_PROPERTIES];

        ImportItem.Caption := Strings[ID_SUB_IMPORT];
        actImportMSVC.Caption := Strings[ID_MSVC_MENUITEM];

        ExportItem.Caption := Strings[ID_SUB_EXPORT];
        actXHTML.Caption := Strings[ID_ITEM_EXPORTHTML];
        actXRTF.Caption := Strings[ID_ITEM_EXPORTRTF];
        actXProject.Caption := Strings[ID_ITEM_EXPORTPROJECT];

        actPrint.Caption := Strings[ID_ITEM_PRINT];
        actPrintSU.Caption := Strings[ID_ITEM_PRINTSETUP];
        actExit.Caption := Strings[ID_ITEM_EXIT];

        // Edit menu
        actUndo.Caption := Strings[ID_ITEM_UNDO];
        actRedo.Caption := Strings[ID_ITEM_REDO];
        actCut.Caption := Strings[ID_ITEM_CUT];
        actCopy.Caption := Strings[ID_ITEM_COPY];
        actPaste.Caption := Strings[ID_ITEM_PASTE];
        actSelectAll.Caption := Strings[ID_ITEM_SELECTALL];
        InsertItem.Caption := Strings[ID_SUB_INSERT];
        ToggleBookmarksItem.Caption := Strings[ID_SUB_TOGGLEMARKS];
        GotoBookMarksItem.Caption := Strings[ID_SUB_GOTOMARKS];
        DeleteLine1.Caption := Strings[ID_WX_DELETE_LINE];
        DateTimeMenuItem.Caption := Strings[ID_ITEM_DATETIME];
        CommentHeaderMenuItem.Caption := Strings[ID_ITEM_COMMENTHEADER];
        actComment.Caption := Strings[ID_ITEM_COMMENTSELECTION];
        actUncomment.Caption := Strings[ID_ITEM_UNCOMMENTSELECTION];
        actIndent.Caption := Strings[ID_ITEM_INDENTSELECTION];
        actUnindent.Caption := Strings[ID_ITEM_UNINDENTSELECTION];
        actSwapHeaderSource.Caption := Strings[ID_ITEM_SWAPHEADERSOURCE];

        // Search Menu
        actFind.Caption := Strings[ID_ITEM_FIND];
        actFindAll.Caption := Strings[ID_ITEM_FINDINALL];
        actReplace.Caption := Strings[ID_ITEM_REPLACE];
        actFindNext.Caption := Strings[ID_ITEM_FINDNEXT];
        actGoto.Caption := Strings[ID_ITEM_GOTO];
        actIncremental.Caption := Strings[ID_ITEM_INCREMENTAL];
        actGotoFunction.Caption := Strings[ID_ITEM_GOTOFUNCTION];

        // View Menu
        actStatusbar.Caption := Strings[ID_ITEM_STATUSBAR];
        ToolBarsItem.Caption := Strings[ID_SUB_TOOLBARS];

        ToolMainItem.Caption := Strings[ID_TOOLMAIN];
        ToolEditItem.Caption := Strings[ID_TOOLEDIT];
        ToolSearchItem.Caption := Strings[ID_TOOLSEARCH];
        ToolCompileAndRunItem.Caption := Strings[ID_TOOLCOMPRUN];
        ToolProjectItem.Caption := Strings[ID_TOOLPROJECT];
        ToolOptionItem.Caption := Strings[ID_TOOLOPTIONS];
        ToolSpecialsItem.Caption := Strings[ID_TOOLSPECIAL];
        ToolClassesItem.Caption := Strings[ID_LP_CLASSES];

        tbMain.Caption := Strings[ID_TOOLMAIN];
        tbEdit.Caption := Strings[ID_TOOLEDIT];
        tbSearch.Caption := Strings[ID_TOOLSEARCH];
        tbCompile.Caption := Strings[ID_TOOLCOMPRUN];
        tbDebug.Caption := Strings[ID_TOOLDEBUG];
        tbProject.Caption := Strings[ID_TOOLPROJECT];
        tbOptions.Caption := Strings[ID_TOOLOPTIONS];
        tbSpecials.Caption := Strings[ID_TOOLSPECIAL];
        tbClasses.Caption := Strings[ID_LP_CLASSES];
        actViewToDoList.Caption := Strings[ID_VIEWTODO_MENUITEM];
        ShowProjectInspItem.Caption := Strings[ID_ITEM_FLOATPROJECT];
        GotoprojectmanagerItem.Caption := Strings[ID_ITEM_GOTOPROJECTVIEW];
        GoToClassBrowserItem.Caption := Strings[ID_ITEM_GOTOCLASSBROWSER];

        ShowPanelsItem.Caption := Strings[ID_ITEM_PANELS];
        ShowPluginPanelsItem.Caption := Strings[ID_ITEM_PLUGINPANELS];

        CompilerMessagesPanelItem.Caption := Strings[ID_SHEET_COMP];
        ResourcesMessagesPanelItem.Caption := Strings[ID_SHEET_RES];
        CompileLogMessagesPanelItem.Caption := Strings[ID_SHEET_COMPLOG];
        FindResultsMessagesPanelItem.Caption := Strings[ID_SHEET_FIND];
        DebuggingMessagesPanelItem.Caption := Strings[ID_SHEET_DEBUG];
        ToDoListMessagesPanelItem.Caption := Strings[ID_SHEET_TODO];

        // Project menu
        actProjectNew.Caption := Strings[ID_ITEM_NEWFILE];
        actProjectAdd.Caption := Strings[ID_ITEM_ADDFILE];
        actProjectRemove.Caption := Strings[ID_ITEM_REMOVEFILE];
        actProjectOptions.Caption := Strings[ID_ITEM_PROJECTOPTIONS];
        actProjectMakeFile.Caption := Strings[ID_ITEM_EDITMAKE];

        // Execute menu
        actCompile.Caption := Strings[ID_ITEM_COMP];
        actCompileCurrentFile.Caption := Strings[ID_ITEM_COMPCURRENT];
        actRun.Caption := Strings[ID_ITEM_RUN];
        actCompRun.Caption := Strings[ID_ITEM_COMPRUN];
        actRebuild.Caption := Strings[ID_ITEM_REBUILD];
        actClean.Caption := Strings[ID_ITEM_CLEAN];
        actSyntaxCheck.Caption := Strings[ID_ITEM_SYNTAXCHECK];
        actProgramReset.Caption := Strings[ID_ITEM_PROGRAMRESET];
        actProfileProject.Caption := Strings[ID_ITEM_PROFILE];
        actAbortCompilation.Caption := Strings[ID_ITEM_ABORTCOMP];
        actExecParams.Caption := Strings[ID_ITEM_EXECPARAMS];

        // Debug menu
        actDebug.Caption := Strings[ID_ITEM_DEBUG];
        actPauseDebug.Caption := Strings[ID_ITEM_PAUSE];
        actRestartDebug.Caption := Strings[ID_ITEM_RESTART];
        actBreakPoint.Caption := Strings[ID_ITEM_TOGGLEBREAK];
        actAddWatch.Caption := Strings[ID_ITEM_WATCHADD];
        actEditWatch.Caption := Strings[ID_ITEM_WATCHEDIT];
        actModifyWatch.Caption := Strings[ID_ITEM_MODIFYVALUE];
        actRemoveWatch.Caption := Strings[ID_ITEM_WATCHREMOVE];
        actStepInto.Caption := Strings[ID_ITEM_STEPINTO];
        actStepOver.Caption := Strings[ID_ITEM_STEPOVER];
        actWatchItem.Caption := Strings[ID_ITEM_WATCHITEMS];
        actStopExecute.Caption := Strings[ID_ITEM_STOPEXECUTION];
        actRunToCursor.Caption := Strings[ID_ITEM_RUNTOCURSOR];
        actViewCPU.Caption := Strings[ID_ITEM_CPUWINDOW];
        ClearallWatchPop.Caption := Strings[ID_ITEM_CLEARALL];

        actDebugFinish.Caption := devData.DebugCommand;
        actRemoveAllBreakpoints.Caption := 'Remove All Breakpoints';

        // Tools menu
        actCompOptions.Caption := Strings[ID_ITEM_COMPOPTIONS];
        actEnviroOptions.Caption := Strings[ID_ITEM_ENVIROOPTIONS];
        actEditorOptions.Caption := Strings[ID_ITEM_EDITOROPTIONS];
        actConfigTools.Caption := Strings[ID_ITEM_TOOLCONFIG];
        actConfigShortcuts.Caption := Strings[ID_ITEM_SHORTCUTSCONFIG];

        // CVS menu
        mnuCVSCurrent.Caption := Strings[ID_ITEM_CVSCURRENT];
        mnuCVSWhole.Caption := Strings[ID_ITEM_CVSWHOLE];
        actCVSImport.Caption := Strings[ID_CVS_IMPORT];
        actCVSCheckout.Caption := Strings[ID_CVS_CHECKOUT];
        actCVSUpdate.Caption := Strings[ID_CVS_UPDATE];
        actCVSCommit.Caption := Strings[ID_CVS_COMMIT];
        actCVSDiff.Caption := Strings[ID_CVS_DIFF];
        actCVSLog.Caption := Strings[ID_CVS_LOG];
        actCVSAdd.Caption := Strings[ID_CVS_ADD];
        actCVSRemove.Caption := Strings[ID_CVS_REMOVE];

        // Window menu
        if devData.fullScreen then
            actFullScreen.Caption := Strings[ID_ITEM_FULLSCRBACK]
        else
            actFullScreen.Caption := Strings[ID_ITEM_FULLSCRMODE];
        actNext.Caption := Strings[ID_ITEM_NEXT];
        actPrev.Caption := Strings[ID_ITEM_PREV];
        ListItem.Caption := Strings[ID_ITEM_LIST];

        // Help menu
        HelpMenuItem.Caption := Strings[ID_ITEM_HELPDEVCPP];
        actUpdateCheck.Caption := Strings[ID_ITEM_UPDATECHECK];
        actAbout.Caption := Strings[ID_ITEM_ABOUT];
        actHelpCustomize.Caption := Strings[ID_ITEM_CUSTOM];
        actShowTips.Caption := Strings[ID_TIPS_CAPTION];
        //pop menus

        HelponDevPopupItem.Caption := Strings[ID_ITEM_HELPDEVCPP];
        // units pop
        actUnitRemove.Caption := Strings[ID_POP_REMOVE];
        actUnitRename.Caption := Strings[ID_POP_RENAME];
        actUnitOpen.Caption := Strings[ID_POP_OPEN];
        actUnitClose.Caption := Strings[ID_POP_CLOSE];
        actProjectNewFolder.Caption := Strings[ID_POP_ADDFOLDER];
        actProjectRemoveFolder.Caption := Strings[ID_POP_REMOVEFOLDER];
        actProjectRenameFolder.Caption := Strings[ID_POP_RENAMEFOLDER];
        mnuOpenWith.Caption := Strings[ID_POP_OPENWITH];

        // editor pop
        UndoPopItem.Caption := Strings[ID_ITEM_UNDO];
        RedoPopItem.Caption := Strings[ID_ITEM_REDO];
        CutPopItem.Caption := Strings[ID_ITEM_CUT];
        CopyPopItem.Caption := Strings[ID_ITEM_COPY];
        PastePopItem.Caption := Strings[ID_ITEM_PASTE];
        SelectAllPopItem.Caption := Strings[ID_ITEM_SELECTALL];
        DeletePopItem.Caption := Strings[ID_ITEM_DELETE];
        InsertPopItem.Caption := Strings[ID_SUB_INSERT];
        TogglebookmarksPopItem.Caption := Strings[ID_SUB_TOGGLEMARKS];
        GotobookmarksPopItem.Caption := Strings[ID_SUB_GOTOMARKS];
        actCloseAllButThis.Caption := Strings[ID_ITEM_CLOSEALLBUTTHIS];
        actAddToDo.Caption := Strings[ID_ADDTODO_MENUITEM];

        // class browser popup
        actBrowserGotoDecl.Caption := Strings[ID_POP_GOTODECL];
        actBrowserGotoImpl.Caption := Strings[ID_POP_GOTOIMPL];
        actBrowserNewClass.Caption := Strings[ID_POP_NEWCLASS];
        actBrowserNewMember.Caption := Strings[ID_POP_NEWMEMBER];
        actBrowserNewVar.Caption := Strings[ID_POP_NEWVAR];
        mnuBrowserViewMode.Caption := Strings[ID_POP_VIEWMODE];
        actBrowserViewAll.Caption := Strings[ID_POP_VIEWALLFILES];
        actBrowserViewProject.Caption := Strings[ID_POP_VIEWPROJECT];
        actBrowserViewCurrent.Caption := Strings[ID_POP_VIEWCURRENT];
        actBrowserAddFolder.Caption := Strings[ID_POP_ADDFOLDER];
        actBrowserRemoveFolder.Caption := Strings[ID_POP_REMOVEFOLDER];
        actBrowserRenameFolder.Caption := Strings[ID_POP_RENAMEFOLDER];
        actBrowserUseColors.Caption := Strings[ID_POP_USECOLORS];
        actBrowserShowInherited.Caption := Strings[ID_POP_SHOWINHERITED];

        // Message Control
        // tabs
        CompSheet.Caption := Strings[ID_SHEET_COMP];
        ResSheet.Caption := Strings[ID_SHEET_RES];
        LogSheet.Caption := Strings[ID_SHEET_COMPLOG];
        FindSheet.Caption := Strings[ID_SHEET_FIND];
        DebugSheet.Caption := Strings[ID_SHEET_DEBUG];
        ToDoSheet.Caption := Strings[ID_SHEET_TODO];

        // popup menu
        actMsgCopy.Caption := Strings[ID_SHEET_POP_COPY];
        actMsgClear.Caption := Strings[ID_SHEET_POP_CLEAR];

        // controls
        CompilerOutput.Columns[0].Caption := Strings[ID_COL_LINE];
        CompilerOutput.Columns[1].Caption := Strings[ID_COL_FILE];
        CompilerOutput.Columns[2].Caption := Strings[ID_COL_MSG];
        FindOutput.Columns[0].Caption := Strings[ID_COL_FLINE];
        FindOutput.Columns[1].Caption := Strings[ID_COL_FCOL];
        FindOutput.Columns[2].Caption := Strings[ID_COL_FFILE];
        FindOutput.Columns[3].Caption := Strings[ID_COL_FMSG];
        ErrorLabel.Caption := Strings[ID_TOTALERRORS];
        SizeOfOutput.Caption := Strings[ID_OUTPUTSIZE];
        InfoGroupBox.Caption := Strings[ID_GRP_INFO];
        CompResGroupBox.Caption := Strings[ID_GRP_COMPRESULTS];
        ProjectSheet.Caption := Strings[ID_LP_PROJECT];
        ClassSheet.Caption := Strings[ID_LP_CLASSES];

        lvBacktrace.Column[0].Caption := Strings[ID_GF_FUNCTION];
        lvBacktrace.Column[1].Caption := Strings[ID_COL_ARGS];
        lvBacktrace.Column[2].Caption := Strings[ID_COL_FILE];
        lvBacktrace.Column[3].Caption := Strings[ID_COL_FLINE];

        lblSendCommandDebugger.Caption := Strings[ID_DEB_SENDDEBUGCOMMAND];
        btnSendCommand.Caption := Strings[ID_DEB_SEND];
        tabBacktrace.Caption := Strings[ID_DEB_BACKTRACE];
        tabDebugOutput.Caption := Strings[ID_DEB_OUTPUT];

        with devShortcuts1.MultiLangStrings do
        begin
            Caption := Strings[ID_SC_CAPTION];
            Title := Strings[ID_SC_TITLE];
            Tip := Strings[ID_SC_TIP];
            HeaderEntry := Strings[ID_SC_HDRENTRY];
            HeaderShortcut := Strings[ID_SC_HDRSHORTCUT];
            Cancel := Strings[ID_BTN_CANCEL];
            OK := Strings[ID_BTN_OK];
        end;

        pnlFull.Caption := Format(Strings[ID_FULLSCREEN_MSG],
            [DEVCPP, DEVCPP_VERSION]);

        // Mainform toolbar buttons
        NewAllBtn.Caption := Strings[ID_TB_NEW];
        InsertBtn.Caption := Strings[ID_TB_INSERT];
        ToggleBtn.Caption := Strings[ID_TB_TOGGLE];
        GotoBtn.Caption := Strings[ID_TB_GOTO];

        tbSpecials.Width := NewAllBtn.Width + InsertBtn.Width +
            ToggleBtn.Width + GotoBtn.Width;
    end;
    BuildBookMarkMenus;
    SetHints;

    for i := 0 to pluginsCount - 1 do
        plugins[i].LoadText(true);

end;

function TMainForm.FileIsOpen(const s: string;
    inPrj: boolean = FALSE): integer;
var
    e: TEditor;
begin
    for result := 0 to pred(PageControl.PageCount) do
    begin
        e := GetEditor(result);
        if e.filename <> '' then
        begin
            if (AnsiCompareText(e.FileName, s) = 0) then
                if (not inprj) or (e.InProject) then
                    exit;
        end
        else
        if AnsiCompareText(e.TabSheet.Caption, ExtractfileName(s)) = 0 then
            if (not inprj) or (e.InProject) then
                exit;
    end;
    result := -1;
end;


//TODO: lowjoel: The following three Save functions probably can be refactored for
//               speed. Anyone can reorganize it to optimize it for speed and efficiency,
//               as well as to cut the number of lines needed.\
//Combine the Save functions together. The saveAS function should be able to use
//the Save function, and the Save functionm can do
function TMainForm.SaveFileAs(e: TEditor): Boolean;
var
    I: Integer;
    dext, flt, s: string;
    idx: integer;
    CFilter, CppFilter, HFilter: Integer;
    boolIsRC: Boolean;
    ccFile, hfile: String;
{$IFDEF PLUGIN_BUILD}
   // filters: TStringList;
    editorName: String;
{$ENDIF}
begin
    Result := True;
    boolIsRC := False;
    idx := -1;
    if assigned(fProject) then
    begin
        if e.FileName = '' then
        begin
            idx := fProject.GetUnitFromString(e.TabSheet.Caption);
            boolIsRC := isRCExt(e.TabSheet.Caption);
        end
        else
        begin
            idx := fProject.Units.Indexof(e.FileName);
            boolIsRC := isRCExt(e.FileName);
        end;
        if fProject.Profiles.UseGPP then
        begin
            BuildFilter(flt, [FLT_CPPS, FLT_CS, FLT_HEADS]);
            dext := CPP_EXT;
            CFilter := 3;
            CppFilter := 2;
            HFilter := 4;
        end
        else
        begin
            BuildFilter(flt, [FLT_CS, FLT_CPPS, FLT_HEADS]);
            dext := C_EXT;
            CFilter := 2;
            CppFilter := 3;
            HFilter := 4;
        end;

        if e.IsRes then
        begin
            BuildFilter(flt, [FLT_RES]);
            dext := RC_EXT;
            CFilter := 2;
            CppFilter := 2;
            HFilter := 2;
        end;

        if boolIsRC then
        begin
            BuildFilter(flt, [FLT_RES]);
            dext := RC_EXT;
            CFilter := 2;
            CppFilter := 2;
            HFilter := 2;
        end;

{$IFDEF PLUGIN_BUILD}
        if e.FileName = '' then
            editorName := e.TabSheet.Caption
        else
            editorName := e.FileName;

        if e.AssignedPlugin <> '' then
        begin
            if plugins[unit_plugins[e.AssignedPlugin]].IsForm(editorName) then
            begin
                BuildFilter(flt,
                    [plugins[unit_plugins[e.AssignedPlugin]].GetFilter(editorName)]);
                dext := plugins[unit_plugins[e.AssignedPlugin]].Get_EXT(editorName);
                CFilter := 2;
                CppFilter := 2;
                HFilter := 2;
            end;
        end;
{$ENDIF}

    end
    else
    begin
        BuildFilter(flt, ftAll);
        if e.IsRes then
            dext := RC_EXT
        else
            dext := CPP_EXT;
{$IFDEF PLUGIN_BUILD}

        if e.FileName = '' then
            editorName := e.TabSheet.Caption
        else
            editorName := e.FileName;

        if e.AssignedPlugin <> '' then
        begin
            if plugins[unit_plugins[e.AssignedPlugin]].IsForm(editorName) then
            begin
                dext := plugins[unit_plugins[e.AssignedPlugin]].Get_EXT(editorName);
            end;
        end;
{$ENDIF}
        if boolIsRC then
        begin
            dext := RC_EXT;
        end;
        CFilter := 5;
        CppFilter := 6;
        HFilter := 3;
    end;

    if e.FileName = '' then
        s := e.TabSheet.Caption
    else
        s := e.FileName;

    with dmMain.SaveDialog do
    begin
        Title := Lang[ID_NV_SAVEFILE];
        Filter := flt;
        DefaultExt := dext;   // EAB: this was missing I guess, but not sure...

        // select appropriate filter       
        if (CompareText(ExtractFileExt(s), '.h') = 0) or
            (CompareText(ExtractFileExt(s), '.hpp') = 0) or
            (CompareText(ExtractFileExt(s), '.hh') = 0) then
            FilterIndex := HFilter
        else
        if Assigned(fProject) then
        begin
            if fProject.Profiles.useGPP then
                FilterIndex := CppFilter
            else
                FilterIndex := CFilter;
        end
        else
            FilterIndex := CppFilter;

        if e.AssignedPlugin <> '' then
        begin
            if plugins[unit_plugins[e.AssignedPlugin]].IsForm(editorName) then
            begin
                FilterIndex :=
                    plugins[unit_plugins[e.AssignedPlugin]].Get_EXT_Index(editorName);
            end;
        end;

        FileName := s;
        s := ExtractFilePath(s);
        if (s <> '') or not Assigned(fProject) then
            InitialDir := s
        else
            InitialDir := fProject.Directory;

        if Execute then
        begin
            s := FileName;
            if FileExists(s) and (MessageDlg(Lang[ID_MSG_FILEEXISTS],
                mtWarning, [mbYes, mbNo], 0) = mrNo) then
                Exit;

{$IFDEF PLUGIN_BUILD}

    {if Assigned(fProject) then
    begin
      activePluginProject := fProject.AssociatedPlugin;
      if activePluginProject <> '' then
        plugins[unit_plugins[activePluginProject]].SetEditorName(e.FileName, s);
    end
    else }if e.AssignedPlugin <> '' then
                plugins[unit_plugins[e.AssignedPlugin]].SetEditorName(
                    e.FileName, s);

{$ENDIF}
            e.FileName := s;

            try
                if devEditor.AppendNewline then
                    with e.Text do
                        if Lines.Count > 0 then
                            if Lines[Lines.Count - 1] <> '' then
                                Lines.Add('');
                e.Text.Lines.SaveToFile(s);
                e.Modified := False;
                e.New := False;
            except
{$IFNDEF PRIVATE_BUILD}
                MessageDlg(Lang[ID_ERR_SAVEFILE] + ' "' + s +
                    '"', mtError, [mbOk], 0);
                Result := False;
{$ELSE}
        on e: Exception do
        begin
          MessageDlg(Format('%s "%s" (%s)', [Lang[ID_ERR_SAVEFILE], s, e.Message]), mtError, [mbOk], Handle);
          Result := False;
        end;
{$ENDIF}
            end;

            //Bug fix for 1337392 : This fix Parse the Cpp file when we save the header
            //file provided the Cpp file is already saved. Don't change the way steps
            //by which the file is parsed.
            if assigned(fProject) then
                fProject.SaveUnitAs(idx, e.FileName)
            else
                e.TabSheet.Caption := ExtractFileName(e.FileName);

            //TODO: lowjoel: optimize this code - it seems as though GetSourcePair is called twice
            if ClassBrowser1.Enabled then
            begin
                CppParser1.GetSourcePair(ExtractFileName(e.FileName),
                    ccFile, hfile);
                CppParser1.AddFileToScan(e.FileName); //new cc
                CppParser1.ParseList;
                ClassBrowser1.CurrentFile := e.FileName;
                CppParser1.ReParseFile(e.FileName, true); //new cc

                //if the source is in the cache and the header file is not in the cache
                //then we need to reparse the Cpp file to make sure the intialially
                //parsed cpp file is reset
                if GetFileTyp(e.FileName) = utHead then
                begin
                    CppParser1.GetSourcePair(ExtractFileName(e.FileName),
                        ccFile, hfile);
                    if Trim(ccFile) <> '' then
                    begin
                        idx := -1;
                        for I := CppParser1.ScannedFiles.Count - 1 downto 0 do
                            // Iterate
                            if AnsiSameText(ExtractFileName(ccFile),
                                ExtractFileName(
                                CppParser1.ScannedFiles[i])) then
                            begin
                                ccFile := CppParser1.ScannedFiles[i];
                                idx := i;
                                Break;
                            end;

                        if idx <> -1 then
                            CppParser1.ReParseFile(ccFile, true); //new cc
                    end;
                end;
            end;
        end
        else
            Result := False;
    end;
end;

//SaveFileInternal will take the editor E and do all the checks before actually
//saving the file to disk. This is an anonymous function because we shouldn't
//be calling this anywhere else! (Call SaveFile instead)
function TMainForm.SaveFileInternal(e: TEditor;
    bParseFile: Boolean = True): Boolean;
var
    EditorUnitIndex: Integer;
begin
    Result := False;

    //First conduct a read-only check.
    //TODO: lowjoel: If the file is read-only we should disable the editing of
    //               the SynEdit?
    if FileExists(e.FileName) and (FileGetAttr(e.FileName) and
        faReadOnly <> 0) then
    begin
        //File is read-only
        if MessageDlg(Format(Lang[ID_MSG_FILEISREADONLY], [e.FileName]),
            mtConfirmation,
            [mbYes, mbNo], Handle) = mrNo then
            Exit;

        //Attempt to remove the read-only attribute
        if FileSetAttr(e.FileName, FileGetAttr(e.FileName) -
            faReadOnly) <> 0 then
        begin
            MessageDlg(Format(Lang[ID_MSG_FILEREADONLYERROR],
                [e.FileName]), mtError,
                [mbOk], Handle);
            Exit;
        end;
    end;

    // EAB Comment: Why should we assert this?
    //Assert(not e.New, 'The code can call this function only on the premise that ' + 'the editor being saved has a filename.');

    // EAB Comment: Why the file cannot be new? If the user chooses to save it it should be saved.
    //if (not e.New) and e.Modified then
    if e.New and e.Modified then
    begin
        SaveFileAs(GetEditor);
        Result := true;
    end
    else
    if e.Modified then
    begin
        //OK. The file needs to be saved. But we treat project files differently
        //from standalone files.
        if Assigned(fProject) and (e.InProject) then
        begin
            EditorUnitIndex := fProject.GetUnitFromEditor(e);
            if EditorUnitIndex = -1 then
                MessageDlg(Format(Lang[ID_ERR_SAVEFILE], [e.FileName]),
                    mtError, [mbOk], Handle)
            else
                Result := fProject.units[EditorUnitIndex].Save;

            if (EditorUnitIndex <> -1) and ClassBrowser1.Enabled then
                CppParser1.ReParseFile(
                    fProject.units[EditorUnitIndex].FileName, True);
        end
        else // stand alone file (should have fullpath in e.filename)
        begin
            //Disable the file watch for this entry
            EditorUnitIndex := devFileMonitor.Files.IndexOf(e.FileName);
            if EditorUnitIndex <> -1 then
            begin
                devFileMonitor.Files.Delete(EditorUnitIndex);
                devFileMonitor.Refresh(False);
            end;

            //Add the newline at the end of file if we were told to do so
            if devEditor.AppendNewline then
                with e.Text do
                    if Lines.Count > 0 then
                        if Lines[Lines.Count - 1] <> '' then
                            Lines.Add('');

            //And commit the file to disk
            e.Text.Lines.SaveToFile(e.FileName);
            e.Modified := false;

            //Re-enable the file watch
            devFileMonitor.Files.Add(e.FileName);
            devFileMonitor.Refresh(False);

            if ClassBrowser1.Enabled then
                CppParser1.ReParseFile(e.FileName, False);
            Result := true;
        end
    end;
end;


function TMainForm.SaveFile(e: TEditor): Boolean;
begin
    Result := True;

    if not assigned(e) then
        exit;

  {$IFDEF PLUGIN_BUILD}
    if (e.AssignedPlugin <> '') then
        plugins[unit_plugins[e.AssignedPlugin]].SaveFile(e.FileName)
    else
   {$ENDIF}
        Result := SaveFileInternal(e);

end;

function TMainForm.AskBeforeClose(e: TEditor; Rem: boolean;
    var Saved: Boolean): boolean;
var
    s: string;
begin
    result := TRUE;
    if not e.Modified then
        exit;

    if e.FileName = '' then
        s := e.TabSheet.Caption
    else
        s := e.FileName;

    Saved := false;
    case MessageDlg(format(Lang[ID_MSG_ASKSAVECLOSE], [s]),
            mtConfirmation, mbYesNoCancel, 0) of
        mrYes:
        begin
            Result := SaveFile(e);
            Saved := true;
        end;
        mrNo:
        begin
            result := TRUE;
            if Rem and assigned(fProject) and e.New and (not e.IsRes) and
                (e.InProject) then
                fProject.Remove(fProject.GetUnitFromString(s), false);
        end;
        mrCancel:
            result := FALSE;
    end;
end;

procedure TMainForm.CloseEditorInternal(eX: TEditor);
begin
    if not eX.InProject then
    begin
        dmMain.AddtoHistory(eX.FileName);
        eX.Close;
    end
    else
    begin
        if eX.IsRes or (not Assigned(fProject)) then
        begin
            eX.Close
        end
        else
        if assigned(fProject) then
            fProject.CloseUnit(fProject.Units.Indexof(eX));
    end;
end;

function TMainForm.CloseEditor(index: integer; Rem: boolean;
    all: boolean = FALSE): Boolean;
var
    e: TEditor;
    Saved: Boolean;
    intActivePage, i: Integer;
begin
    Saved := false;
    Result := False;
    e := GetEditor(index);
    if not assigned(e) then
        exit;
    if not AskBeforeClose(e, Rem, Saved) then
        Exit;
    Result := True;

{$IFDEF PLUGIN_BUILD}
    if (e.AssignedPlugin <> '') and (all = FALSE) then
    begin
        if not plugins[unit_plugins[e.AssignedPlugin]].SaveFileAndCloseEditor(e.FileName) then
            CloseEditorInternal(e);
    end
    else
{$ENDIF}
        CloseEditorInternal(e);

    PageControl.OnChange(PageControl);
    if (ClassBrowser1.ShowFilter = sfCurrent) or not Assigned(fProject) then
        ClassBrowser1.Clear;

    // EAB: fix tab names
    PageControl.Refresh;
end;

procedure TMainForm.ToggleBookmarkClick(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    with Sender as TMenuItem do
        if assigned(e) then
        begin
            Checked := not Checked;
            if (Parent = ToggleBookmarksItem) then
                TogglebookmarksPopItem.Items[Tag - 1].Checked := Checked
            else
                TogglebookmarksItem.Items[Tag - 1].Checked := Checked;
            if Checked then
                e.Text.SetBookMark(Tag, e.Text.CaretX, e.Text.CaretY)
            else
                e.Text.ClearBookMark(Tag);
        end;
end;

procedure TMainForm.GotoBookmarkClick(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if assigned(e) then
        e.Text.GotoBookMark((Sender as TMenuItem).Tag);
end;

procedure TMainForm.ToggleBtnClick(Sender: TObject);
var
    e: TEditor;
    pt: TPoint;
begin
    e := GetEditor;
    if assigned(e) then
    begin
        pt := tbSpecials.ClientToScreen(point(Togglebtn.Left,
            Togglebtn.Top + togglebtn.Height));
        TrackPopupMenu(ToggleBookmarksItem.Handle, TPM_LEFTALIGN or
            TPM_LEFTBUTTON,
            pt.x, pt.y, 0, Self.Handle, nil);
    end;
end;

procedure TMainForm.GotoBtnClick(Sender: TObject);
var
    pt: TPoint;
begin
    if PageControl.ActivePageIndex > -1 then
    begin
        pt := tbSpecials.ClientToScreen(point(Gotobtn.Left,
            Gotobtn.Top + Gotobtn.Height));
        TrackPopupMenu(GotoBookmarksItem.Handle, TPM_LEFTALIGN or
            TPM_LEFTBUTTON,
            pt.x, pt.y, 0, Self.Handle, nil);
    end;
end;

procedure TMainForm.NewAllBtnClick(Sender: TObject);
var
    pt: TPoint;
begin
    pt := tbSpecials.ClientToScreen(point(NewAllBtn.Left,
        NewAllbtn.Top + NewAllbtn.Height));
    TrackPopupMenu(mnuNew.Handle, TPM_LEFTALIGN or TPM_LEFTBUTTON,
        pt.X, pt.y, 0, Self.Handle, nil);
end;

procedure TMainForm.MRUClick(Sender: TObject);
var
    s: string;
 {$IFDEF PLUGIN_BUILD}
    i: Integer;
{$ENDIF}
begin
    s := dmMain.MRU[(Sender as TMenuItem).Tag];
    if GetFileTyp(s) = utPrj then
        OpenProject(s)
    else
    begin
{$IFDEF PLUGIN_BUILD}
        chdir(ExtractFileDir(s));
        for i := 0 to pluginsCount - 1 do
    	       plugins[i].OpenFile(s);
{$ENDIF}
        OpenFile(s);
    end;
end;

procedure TMainForm.CodeInsClick(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if assigned(e) then
        e.InsertString(dmMain.CodeInserts[
            (Sender as TMenuItem).Tag].Line, TRUE);
end;

procedure TMainForm.SurroundString(e: TEditor; strStart, strEnd: String);
var
    I: Integer;
    startXY, endXY: TBufferCoord;
    strLstToPaste: TStringList;
begin
    if assigned(e) = false then
        exit;

    strLstToPaste := TStringList.Create;
    try
        strLstToPaste.Add(strStart);
        if e.Text.SelAvail then
        begin
            startXY := e.Text.BlockBegin;
            endXY := e.Text.BlockEnd;

            for I := startXY.Line - 1 to endXY.Line - 1 do    // Iterate
            begin
                strLstToPaste.Add(e.Text.Lines[i])
            end;

            for I := endXY.Line - 1 downto startXY.Line - 1 do    // Iterate
            begin
                //e.Text.insert
                e.Text.Lines.Delete(I);
            end;

            // for
        end
        else
        begin
            startXY.Line := e.Text.CaretY;
        end;
        strLstToPaste.Add(strEnd);

        for I := strLstToPaste.Count - 1 downto 0 do    // Iterate
        begin
            e.Text.Lines.Insert(startXY.Line - 1, strLstToPaste[i]);
            e.Modified := true;
        end;

    finally
        strLstToPaste.Destroy;
    end;

end;

procedure TMainForm.CppCommentString(e: TEditor);
var
    I: Integer;
    startXY, endXY: TBufferCoord;
begin
    if assigned(e) = false then
        exit;
    if e.Text.SelAvail then
    begin
        startXY := e.Text.BlockBegin;
        endXY := e.Text.BlockEnd;
        for I := startXY.Line - 1 to endXY.Line - 1 do    // Iterate
        begin
            e.Text.Lines[i] := '// ' + e.Text.Lines[i];
            e.Modified := true;
            //            e.Text.UndoList.AddChange(crPaste, st, Point(st.X, st.Y ), '', smNormal);
            //            e.Text.Lines.Delete(i);
            //            e.Text.UndoList.AddChange(crDelete, st, Point(st.X, st.Y ), '', smNormal);
            //            e.Text.Lines.Insert(i,strLine);
            //            e.Text.UndoList.AddChange(crPaste, st, Point(st.X, st.Y +1), '', smNormal);
        end;
    end
end;

procedure TMainForm.SurroundWithClick(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if not Assigned(e) then
        Exit;

    case TMenuItem(Sender).Tag of
        INT_BRACES:
            SurroundString(e, '{', '}');

        INT_TRY_CATCH:
            SurroundString(e, 'try{', '}catch() {}');

        INT_C_COMMENT:
            SurroundString(e, '/*', '*/');

        INT_FOR:
            SurroundString(e, 'for(){', '}');

        INT_FOR_I:
            SurroundString(e, 'for(int i=;i<;i++){', '}');

        INT_WHILE:
            SurroundString(e, 'while(){', '}');

        INT_DO_WHILE:
            SurroundString(e, 'do{', '}while();');

        INT_IF:
            SurroundString(e, 'if(){', '}');

        INT_IF_ELSE:
            SurroundString(e, 'if(){', '} else { }');

        INT_SWITCH:
            SurroundString(e, 'switch() { case 0:', '}');

        INT_CPP_COMMENT:
            CppCommentString(e);

    end;    // case
end;

procedure TMainForm.ToolItemClick(Sender: TObject);
var
    idx: integer;
begin
    idx := (Sender as TMenuItem).Tag;
    with fTools.ToolList[idx]^ do
        ExecuteFile(ParseParams(Exec), ParseParams(Params),
            ParseParams(WorkDir), SW_SHOW);
end;

procedure TMainForm.OpenProject(s: string);
var
    s2: string;
begin
    if assigned(fProject) then
    begin
        if fProject.Name = '' then
            s2 := fProject.FileName
        else
            s2 := fProject.Name;
        if (MessageDlg(format(Lang[ID_MSG_CLOSEPROJECTPROMPT], [s2]),
            mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
        begin
            //Some freaking unknown error
            //I dont know where all the editors are
            //freed. So I save the layout and close the
            //project. Any help in fixing this is greatly appreciated.
            fProject.SaveLayout;
            //actCloseAll.Execute;
            actCloseProject.Execute;
        end
        else
            exit;
    end;
    bProjectLoading := True;
    alMain.State := asSuspended;
    try
        fProject := TProject.Create(s, DEV_INTERNAL_OPEN);
        if fProject.FileName <> '' then
        begin
            fCompiler.Project := fProject;
            fCompiler.RunParams := fProject.CmdLineArgs;
            fCompiler.Target := ctProject;

            dmMain.RemoveFromHistory(s);
            // if project manager isn't open then open it
            if (not ShowProjectInspItem.Checked) and (not fFirstShow) then
                ShowProjectInspItem.OnClick(Self);

            CheckForDLLProfiling;
            UpdateAppTitle;
            ScanActiveProject;
        end
        else
        begin
            fProject.Free;
            fProject := nil;
        end;
    finally
        bProjectLoading := False;
        alMain.State := asNormal;
    end;
    RefreshTodoList;
end;

procedure TMainForm.OpenFile(s: string; withoutActivation: Boolean);
var
    e: TEditor;
    idx: integer;
begin

    if s = '' then
        exit;

    if s[length(s)] = '.' then
        // correct filename if the user gives an alone dot to force the no extension
        s[length(s)] := #0;
    idx := FileIsOpen(s);
    if (idx <> -1) then
    begin
        if not withoutActivation then
            GetEditor(idx).Activate;
        exit;
    end;

    if not FileExists(s) then
    begin
        Application.MessageBox(PChar(Format(Lang[ID_ERR_FILENOTFOUND],
            [s])), 'Error', MB_ICONHAND);
        Exit;
    end;

    e := TEditor.Create;
    e.Init(FALSE, ExtractFileName(s), s, TRUE);
    if assigned(fProject) then
    begin
        if (fProject.FileName <> s) and
            (fProject.GetUnitFromString(s) = -1) then
            dmMain.RemoveFromHistory(s);
    end
    else
        dmMain.RemoveFromHistory(s);

    if not withoutActivation then
        e.activate;
    if not assigned(fProject) then
        CppParser1.ReParseFile(e.FileName, e.InProject, True);
    RefreshTodoList;
end;

procedure TMainForm.AddFindOutputItem(line, col, unit_, message: string);
var
    ListItem: TListItem;
begin
    ListItem := FindOutput.Items.Add;
    ListItem.Caption := line;
    ListItem.SubItems.Add(col);
    ListItem.SubItems.Add(unit_);
    ListItem.SubItems.Add(message);
end;

function TMainForm.ParseParams(s: string): string;
resourcestring
    cEXEName = '<EXENAME>';
    cPrjName = '<PROJECTNAME>';
    cPrjFile = '<PROJECTFILE>';
    cPrjPath = '<PROJECTPATH>';
    cCurSrc = '<SOURCENAME>';
    cSrcPath = '<SOURCEPATH>';
    cDevVer = '<DEVCPPVERSION>';

    cDefault = '<DEFAULT>';
    cExecDir = '<EXECPATH>';
    cSrcList = '<SOURCESPCLIST>';
    cWordxy = '<WORDXY>';

var
    e: TEditor;
begin
    e := GetEditor;
    // <DEFAULT>
    s := StringReplace(s, cDefault, devDirs.Default, [rfReplaceAll]);

    // <EXECPATH>
    s := Stringreplace(s, cExecDir, devDirs.Exec, [rfReplaceAll]);

    // <DEVCPPVERISON>
    s := StringReplace(s, cDevVer, DEVCPP_VERSION, [rfReplaceAll]);

    if assigned(fProject) then
    begin
        // <EXENAME>
        s := StringReplace(s, cEXEName, fProject.Executable, [rfReplaceAll]);

        // <PROJECTNAME>
        s := StringReplace(s, cPrjName, fProject.Name, [rfReplaceAll]);

        // <PROJECTFILE>
        s := StringReplace(s, cPrjFile, fProject.FileName, [rfReplaceAll]);

        // <PROJECTPATH>
        s := StringReplace(s, cPrjPath, fProject.Directory, [rfReplaceAll]);

        if Assigned(e) then
        begin
            // <SOURCENAME>
            s := StringReplace(s, cCurSrc, e.FileName, [rfReplaceAll]);
            // <SOURCEPATH>
            if e.FileName = '' then
                s := StringReplace(s, cSrcPath, devDirs.Default,
                    [rfReplaceAll])
            else
                s := StringReplace(s, cSrcPath, ExtractFilePath(e.FileName),
                    [rfReplaceAll]);
        end;

        // <SOURCESPCLIST>
        s := StringReplace(s, cSrcList, fProject.ListUnitStr(' '),
            [rfReplaceAll]);
    end
    else
    if assigned(e) then
    begin
        // <EXENAME>
        // GAR 10 Nov 2009
        // Hack for Wine/Linux
        // ProductName returns empty string for Wine/Linux
        // for Windows, it returns OS name (e.g. Windows Vista).
        if (JvComputerInfoEx1.OS.ProductName = '') then
            s := StringReplace(s, cEXEName, ChangeFileExt(e.FileName,
                ''), [rfReplaceAll])
        else
            s := StringReplace(s, cEXEName, ChangeFileExt(e.FileName,
                EXE_EXT), [rfReplaceAll]);

        // <PROJECTNAME>
        s := StringReplace(s, cPrjName, e.FileName, [rfReplaceAll]);

        // <PRJECTFILE>
        s := StringReplace(s, cPrjFile, e.FileName, [rfReplaceAll]);

        // <PROJECTPATH>
        s := StringReplace(s, cPrjPath, ExtractFilePath(e.FileName),
            [rfReplaceAll]);

        // <SOURCENAME>
        s := StringReplace(s, cCurSrc, e.FileName, [rfReplaceAll]);

        // <SOURCEPATH>
        // if fActiveEditor is "untitled"/new file return users default directory
        if e.FileName = '' then
            s := StringReplace(s, cSrcPath, devDirs.Default, [rfReplaceAll])
        else
            s := StringReplace(s, cSrcPath,
                ExtractFilePath(e.FileName), [rfReplaceAll]);

        // <WORDXY>
        s := StringReplace(s, cWordXY, e.GetWordAtCursor, [rfReplaceAll]);
    end;

    // clear unchanged macros

    if not assigned(fProject) then
        s := StringReplace(s, cSrcList, '', [rfReplaceAll]);

    if not assigned(e) then
    begin
        s := StringReplace(s, cCurSrc, '', [rfReplaceAll]);
        s := StringReplace(s, cWordXY, '', [rfReplaceAll]);
        // if no editor assigned return users default directory
        s := StringReplace(s, cSrcPath, devDirs.Default, [rfReplaceAll]);
    end;

    if not assigned(fProject) and not assigned(e) then
    begin
        s := StringReplace(s, cEXEName, '', [rfReplaceAll]);
        s := StringReplace(s, cPrjName, '', [rfReplaceAll]);
        s := StringReplace(s, cPrjFile, '', [rfReplaceAll]);
        s := StringReplace(s, cPrjPath, '', [rfReplaceAll]);
    end;

    Result := s;
end;

procedure TMainForm.HelpItemClick(Sender: TObject);
var
    idx: integer;
    aFile: string;
begin
    idx := (Sender as TMenuItem).Tag;
    if idx >= fHelpFiles.Count then
        exit;
    aFile := fHelpFiles.Values[idx];

    if AnsiPos(HTTP, aFile) = 1 then
        ExecuteFile(aFile, '', devDirs.Help, SW_SHOW)
    else
    begin
        aFile := ValidateFile(aFile, devDirs.Exec, TRUE);
        if AnsiPos(':\', aFile) = 0 then
            aFile := ExpandFileto(aFile, devDirs.Exec);
        ExecuteFile(aFile, '', ExtractFilePath(aFile), SW_SHOW);
    end;
    //Application.HelpFile := aFile;
    // moving this to WordToHelpKeyword
    // it's annoying to display the index when the topic has been found and is already displayed...
    //    Application.HelpCommand(HELP_FINDER, 0);
    //WordToHelpKeyword;
end;

procedure TMainForm.CompOutputProc(const _Line, _Unit, _Message: string);
begin
    with CompilerOutput.Items.Add do
    begin
        Caption := _Line;
        SubItems.Add(GetRealPath(_Unit));
        SubItems.Add(_Message);
    end;
    TotalErrors.Text := IntToStr(fCompiler.ErrorCount);
    ShowDockForm(frmReportDocks[cCompTab]);
end;

procedure TMainForm.CompResOutputProc(const _Line, _Unit, _Message: string);
begin
    if (_Line <> '') and (_Unit <> '') then
        ResourceOutput.Items.Add('Line ' + _Line + ' in file ' +
            _Unit + ' : ' + _Message)
    else
        ResourceOutput.Items.Add(_Message);
end;

procedure TMainForm.CompSuccessProc(const messages: integer);
var
    F: TSearchRec;
    HasSize: boolean;
    I: integer;
begin
    if fCompiler.ErrorCount = 0 then
    begin
        TotalErrors.Text := '0';
        HasSize := False;
        if Assigned(fProject) then
        begin
            FindFirst(fProject.Executable, faAnyFile, F);
            HasSize := FileExists(fProject.Executable);
        end
        else
        if PageControl.PageCount > 0 then
        begin
            // GAR 10 Nov 2009
            // Hack for Wine/Linux
            // ProductName returns empty string for Wine/Linux
            // for Windows, it returns OS name (e.g. Windows Vista).
            if (MainForm.JvComputerInfoEx1.OS.ProductName = '') then
            begin
                FindFirst(ChangeFileExt(GetEditor.FileName, ''), faAnyFile, F);
                HasSize := FileExists(ChangeFileExt(GetEditor.FileName, ''));
            end
            else
            begin
                FindFirst(ChangeFileExt(GetEditor.FileName, EXE_EXT),
                    faAnyFile, F);
                HasSize :=
                    FileExists(ChangeFileExt(GetEditor.FileName, EXE_EXT));
            end;
        end;
        if HasSize then
        begin
            SizeFile.Text := IntToStr(F.Size) + ' ' + Lang.Strings[ID_BYTES];
            if F.Size > 1024 then
                SizeFile.Text := SizeFile.Text + ' (' +
                    IntToStr(F.Size div 1024) + ' KB)';
        end
        else
            SizeFile.Text := '0';
    end
    else
    begin
        // errors exist; goto first one...
        for I := 0 to CompilerOutput.Items.Count - 1 do
            if StrToIntDef(CompilerOutput.Items[I].Caption, -1) <> -1 then
            begin
                CompilerOutput.Selected := CompilerOutput.Items[I];
                CompilerOutputDblClick(nil);
                Break;
            end;
    end;
end;

procedure TMainForm.LogEntryProc(const msg: string);
begin
    LogOutput.Lines.Add(msg);
end;

procedure TMainform.MainSearchProc(const SR: TdevSearchResult);
var
    s: string;
    I: integer;
begin
    // change all chars below #32 to #32 (non-printable to printable)
    S := SR.msg;
    for I := 1 to Length(S) do
        if S[I] < #32 then
            S[I] := #32;

    AddFindOutputItem(inttostr(SR.pt.X), inttostr(SR.pt.y), SR.InFile, S);
end;

procedure TMainForm.ProjectViewContextPopup(Sender: TObject;
    MousePos: TPoint; var Handled: Boolean);
var
    pt: TPoint;
    Node: TTreeNode;
begin
    if not assigned(fProject) or devData.FullScreen then
        exit;
    pt := ProjectView.ClientToScreen(MousePos);
    Node := ProjectView.GetNodeAt(MousePos.X, MousePos.Y);
    if not assigned(Node) then
        exit;
    ProjectView.Selected := Node;
    if Node.Level = 0 then
        ProjectPopup.Popup(pt.x, pt.Y)
    else
    begin
        BuildOpenWith;
        RemoveFilefromprojectPopItem.Visible := Node.Data <> Pointer(-1);
        RenamefilePopItem.Visible := Node.Data <> Pointer(-1);
        OpenPopItem.Visible := Node.Data <> Pointer(-1);
        ClosefilePopItem.Visible := Node.Data <> Pointer(-1);
        Removefolder1.Visible := Node.Data = Pointer(-1);
        Renamefolder1.Visible := Node.Data = Pointer(-1);
        Addfile1.Visible := Node.Data = Pointer(-1);
        mnuUnitProperties.Visible := Node.Data <> Pointer(-1);
        UnitPopup.Popup(pt.X, pt.Y);
    end;
    Handled := TRUE;
end;

procedure TMainForm.OpenUnit;
var
    Node: TTreeNode;
    i: integer;
    pt: TPoint;
    e: TEditor;
    AlreadyActivated: boolean;
begin
    AlreadyActivated := false;
    if assigned(ProjectView.Selected) then
        Node := ProjectView.Selected
    else
    begin
        pt := ProjectView.ScreenToClient(Mouse.CursorPos);
        Node := ProjectView.GetNodeAt(pt.x, pt.y);
    end;
    if assigned(Node) and (integer(Node.Data) <> -1) then
        if (Node.Level >= 1) then
        begin
            i := integer(Node.Data);
{$IFDEF PLUGIN_BUILD}
            //This will allow DevC++ to open custom program
            //as assigned by the user like VC++
            if OpenWithAssignedProgram(fProject.Units[i].FileName) = true then
                Exit;
{$ENDIF}
            FileIsOpen(fProject.Units[i].FileName, TRUE);
{$IFDEF PLUGIN_BUILD}
            if isFileOpenedinEditor(fProject.Units[i].FileName) then
                e := GetEditorFromFileName(fProject.Units[i].FileName)
            else
{$ENDIF}
                e := fProject.OpenUnit(i);
            if assigned(e) then
            begin
{$IFDEF PLUGIN_BUILD}
                if (e.AssignedPlugin <> '') then
                    plugins[unit_plugins[e.AssignedPlugin]].OpenUnit(
                        e.FileName);
{$ENDIF}
                if AlreadyActivated = false then
                    e.Activate;
            end;
        end;
end;

procedure TMainForm.ProjectViewClick(Sender: TObject);
var
    e: TEditor;
begin
    if devData.DblFiles then
        exit;
    if not Assigned(ProjectView.Selected) then
        Exit;
    if ProjectView.Selected.Data <> Pointer(-1) then
        OpenUnit
    else
    begin
        e := GetEditor;
        if Assigned(e) then
            e.Activate;
    end;
end;

procedure TMainForm.ProjectViewDblClick(Sender: TObject);
begin
    if not devData.dblFiles then
        exit;
    OpenUnit;
end;

procedure TMainForm.HelpBtnClick(Sender: TObject);
var
    pt: TPoint;
begin
    pt := tbOptions.ClientToScreen(point(HelpBtn.Left, Helpbtn.Top +
        Helpbtn.Height));
    HelpPop.Popup(pt.X, pt.Y);
end;

procedure TMainForm.InsertBtnClick(Sender: TObject);
var
    pt: TPoint;
begin
    if PageControl.ActivePageIndex > -1 then
    begin
        pt := tbSpecials.ClientToScreen(point(Insertbtn.Left,
            Insertbtn.Top + Insertbtn.Height));
        TrackPopupMenu(InsertItem.Handle, TPM_LEFTALIGN or TPM_LEFTBUTTON,
            pt.X, pt.Y, 0, Self.Handle, nil);
    end;
end;

procedure TMainForm.Customize1Click(Sender: TObject);
begin
    with TfrmHelpEdit.Create(Self) do
        try
            if Execute then
                BuildHelpMenu;
        finally
            Free;
        end;
end;

procedure TMainForm.actNewSourceExecute(Sender: TObject);
var
    NewEditor: TEditor;
begin
    if assigned(fProject) then
    begin
        case MessageDlg(Lang[ID_MSG_NEWFILE], mtConfirmation,
                [mbYes, mbNo, mbCancel], 0) of
            mrYes:
            begin
                actProjectNewExecute(Sender);
                exit;
            end;
            mrCancel:
                exit;
        end;
    end;
    NewEditor := TEditor.Create;
    NewEditor.init(FALSE, Lang[ID_UNTITLED] + inttostr(dmMain.GetNum),
        '', FALSE);
    NewEditor.InsertDefaultText;
    NewEditor.Activate;
end;

procedure TMainForm.actNewProjectExecute(Sender: TObject);
var
    s: String;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
{$ENDIF}
begin
    with TNewProjectForm.Create(Self) do
        try
            rbCpp.Checked := devData.DefCpp;
            rbC.Checked := not rbCpp.Checked;
            if ShowModal = mrOk then
            begin
                if (cbDefault.Checked) then
                    devData.DefCpp := rbCpp.Checked;
                if assigned(fProject) then
                begin
                    if fProject.Name = '' then
                        s := fProject.FileName
                    else
                        s := fProject.Name;
                    if MessageDlg(format(Lang[ID_MSG_CLOSECREATEPROJECT], [s]),
                        mtConfirmation,
                        [mbYes, mbNo], 0) = mrYes then
                        actCloseProject.Execute
                    else
                    begin
                        Dec(dmMain.fProjectCount);
                        Exit;
                    end;
                end;
                s := edProjectName.Text + DEV_EXT;
                with dmMain.SaveDialog do
                begin
                    Filter := FLT_PROJECTS;
                    InitialDir := devDirs.Default;
                    FileName := s;

                    if not Execute then
                    begin
                        Dec(dmMain.fProjectCount);
                        Exit;
                    end;
                    s := FileName;
                    if FileExists(s) then
                    begin
                        if MessageDlg(Lang[ID_MSG_FILEEXISTS],
                            mtWarning, [mbYes, mbNo], 0) = mrYes then
                        begin
                            DeleteFile(s);
                            Dec(dmMain.fProjectCount);
                        end
                        else
                            Exit;
                    end;
                end;

                fProject := TProject.Create(s, edProjectName.Text);
                if not fProject.AssignTemplate(s, GetTemplate) then
                begin
                    fProject.Free;
                    MessageBox(Self.Handle, PChar(Lang[ID_ERR_TEMPLATE]),
                        PChar(Lang[ID_ERROR]), MB_OK or MB_ICONERROR);
                    Exit;
                end;
                fCompiler.Project := fProject;


{$IFDEF PLUGIN_BUILD}
                activePluginProject := fProject.AssociatedPlugin;
                if activePluginProject <> '' then
                    plugins[unit_plugins[activePluginProject]].NewProject(
                        GetTemplate.Name);
{$ENDIF}

                devCompiler.CompilerSet := fProject.CurrentProfile.CompilerSet;
                devCompilerSet.LoadSet(fProject.CurrentProfile.CompilerSet);
                devCompilerSet.AssignToCompiler;
                devCompiler.OptionStr :=
                    fProject.CurrentProfile.CompilerOptions;

                if not ShowProjectInspItem.Checked then
                    ShowProjectInspItem.OnClick(nil);
                UpdateAppTitle;
            end;
        finally
            Free;
        end;
end;

procedure TMainForm.actNewResExecute(Sender: TObject);
var
    NewEditor: TEditor;
    InProject: Boolean;
    fname: string;
    res: TTreeNode;
    NewUnit: TProjUnit;
begin
    if Assigned(fProject) then
        InProject := Application.MessageBox(PChar(
            Lang[ID_MSG_NEWRES]), 'New Resource', MB_ICONQUESTION +
            MB_YESNO) = mrYes
    else
        InProject := False;

    fname := Lang[ID_UNTITLED] + inttostr(dmMain.GetNum) + '.rc';
    NewEditor := TEditor.Create;
    NewEditor.init(InProject, fname, '', FALSE, TRUE);
    NewEditor.Activate;

    if InProject and Assigned(fProject) then
    begin
        res := fProject.FolderNodeFromName('Resources');
        NewUnit := fProject.AddUnit(fname, res, True);
        NewUnit.Editor := NewEditor;
    end;
    // new editor with resource file
end;

procedure TMainForm.actNewTemplateExecute(Sender: TObject);
begin
    // change to save cur project as template maybe?
    NewTemplateForm := TNewTemplateForm.Create(Self);
    with NewTemplateForm do
    begin
        TempProject := fProject;
        ShowModal;
    end;
end;


procedure TMainForm.actOpenExecute(Sender: TObject);
var
    idx,
    prj: integer;
    flt: string;
{$IFDEF PLUGIN_BUILD}
    filters: TStringList;
    built: Boolean;
    j, I: Integer;
{$ENDIF}
begin


    built := false;
    prj := -1;
    flt := '';
    BuildFilter(flt, ftOpen);

    with dmMain.OpenDialog do
    begin
        Filter := flt;
        Title := Lang[ID_NV_OPENFILE];
        if Execute then
            if Files.Count > 0 then // multi-files?
            begin
                for idx := 0 to pred(Files.Count) do // find .dev file
                    if AnsiCompareText(ExtractFileExt(Files[idx]),
                        DEV_EXT) = 0 then
                    begin
                        prj := idx;
                        break;
                    end;
                if prj = -1 then // not found
                begin
                    chdir(ExtractFileDir(Files[0]));
                    for idx := 0 to pred(Files.Count) do
                    begin
{$IFDEF PLUGIN_BUILD}
                        for j := 0 to pluginsCount - 1 do
                            plugins[j].OpenFile(Files[idx]);
{$ENDIF}
                        OpenFile(Files[idx]); // open all files
                    end;
                end
                else
                    OpenProject(Files[prj]); // else open found project
            end;
    end;
end;

procedure TMainForm.actHistoryClearExecute(Sender: TObject);
begin
    dmMain.ClearHistory;
end;

procedure TMainForm.actSaveExecute(Sender: TObject);
begin
    SaveFile(GetEditor);
end;

procedure TMainForm.actSaveAsExecute(Sender: TObject);
begin
    SaveFileAs(GetEditor);
end;

procedure TMainForm.actSaveAllExecute(Sender: TObject);
var
    fileLstToParse: TStringList;
    idx: Integer;
    e: TEditor;
begin
    fileLstToParse := TStringList.Create;
    if Assigned(fProject) then
    begin
        fProject.Save;
        UpdateAppTitle;
        if CppParser1.Statements.Count = 0 then
            // only scan entire project if it has not already been scanned...
            ScanActiveProject;
    end;

    for idx := 0 to pred(PageControl.PageCount) do
    begin
        e := GetEditor(idx);
        if e.Modified then
        begin
            SaveFile(GetEditor(idx));
            if ClassBrowser1.Enabled and (GetFileTyp(e.FileName) in
                [utSrc, utHead]) then
                fileLstToParse.Add(e.FileName);
        end;
    end;

    if ClassBrowser1.Enabled then
        for idx := 0 to fileLstToParse.Count - 1 do
            CppParser1.ReParseFile(fileLstToParse[idx], True);
    fileLstToParse.Destroy;
end;

procedure TMainForm.actCloseExecute(Sender: TObject);
begin
    CloseEditor(PageControl.ActivePageIndex, True);
    UpdateAppTitle;
end;

procedure TMainForm.actCloseAllExecute(Sender: TObject);
var
    idx: integer;
begin
    for idx := pred(PageControl.PageCount) downto 0 do
        if not CloseEditor(0, TRUE, TRUE) then
            Break;

    // if no project is open, clear the parsed info...
    if not Assigned(fProject) and (PageControl.PageCount = 0) then
    begin
        CppParser1.Reset;
        ClassBrowser1.Clear;
    end;
    UpdateAppTitle;
end;

procedure TMainForm.actCloseProjectExecute(Sender: TObject);
var
    s: string;
    i: Integer;
begin
    actStopExecute.Execute;

    // save project layout anyway ;)
    fProject.CmdLineArgs := fCompiler.RunParams;
    //fProject.SaveLayout;

{$IFNDEF PRIVATE_BUILD}
    //TODO: Guru: Do we still need this? I've been running wxDev-C++ without this
    //            code and it never crashes
    actCloseAll.Execute;
{$ENDIF}

    // ** should we save watches?
    if fProject.Modified then
    begin
        if fProject.Name = '' then
            s := fProject.FileName
        else
            s := fProject.Name;

        case MessageDlg(format(Lang[ID_MSG_SAVEPROJECT], [s]),
                mtConfirmation, mbYesNoCancel, 0) of
            mrYes:
                fProject.Save;
            mrNo:
                fProject.Modified := FALSE;
            mrCancel:
                exit;
        end;
    end;

    fCompiler.Project := nil;
    dmMain.AddtoHistory(fProject.FileName);

    i := 0;
    while i < debugger.Breakpoints.Count do
    begin
        if fProject.Units.Indexof(
            PBreakpoint(Debugger.Breakpoints[i])^.FileName) <> -1 then
        begin
            Dispose(Debugger.Breakpoints.Items[i]);
            Debugger.Breakpoints.Delete(i);
        end
        else
            Inc(i);
    end;

    try
        FreeandNil(fProject);
    except
        fProject := nil;
    end;

    ProjectView.Items.Clear;
    CompilerOutput.Items.Clear;
    FindOutput.Items.Clear;
    ResourceOutput.Clear;
    LogOutput.Clear;
    DebugOutput.Clear;

    UpdateAppTitle;
    ClassBrowser1.ProjectDir := '';
    CppParser1.Reset;
    RefreshTodoList;
end;

procedure TMainForm.actXHTMLExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if assigned(e) then
        e.Exportto(TRUE);
end;

procedure TMainForm.actXRTFExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if assigned(e) then
        e.Exportto(FALSE);
end;

procedure TMainForm.actXProjectExecute(Sender: TObject);
begin
    if assigned(fProject) then
        fProject.Exportto(TRUE);
end;

procedure TMainForm.actPrintExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if assigned(e) then
        with TPrintForm.Create(Self) do
            try
                if ShowModal = mrOk then
                begin
                    with dmMain.SynEditPrint do
                    begin
                        SynEdit := e.Text;
                        Highlighter := e.Text.Highlighter;
                        Colors := cbColors.Checked;
                        Highlight := cbHighlight.Checked;
                        Wrap := cbWordWrap.Checked;
                        LineNumbers := cbLineNum.checked;
                        LineNumbersInMargin := rbLNMargin.Checked;
                        Copies := seCopies.Value;
                        SelectedOnly := cbSelection.Checked;
                        Print;
                    end;
                    devData.PrintColors := cbColors.Checked;
                    devData.PrintHighlight := cbHighlight.Checked;
                    devData.PrintWordWrap := cbWordWrap.Checked;
                    devData.PrintLineNumbers := rbLN.Checked;
                    devData.PrintLineNumbersMargins := rbLNMargin.Checked;
                end;
            finally
                Free;
            end;
end;

procedure TMainForm.actPrintSUExecute(Sender: TObject);
begin
    try
        dmMain.PrinterSetupDialog.Execute;
    except
        MessageDlg('An error occured while trying to load the printer setup dialog. You probably have no printer installed yet', mtError, [mbOK], 0);
    end;
end;

procedure TMainForm.actExitExecute(Sender: TObject);
begin
    Close;
end;

procedure TMainForm.actUndoExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if assigned(e) then
    begin
        e.Text.Undo;
    end;
end;

procedure TMainForm.actRedoExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if assigned(e) then
        e.Text.Redo;
end;

procedure TMainForm.actCutExecute(Sender: TObject);
var
    e: TEditor;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
    b: Boolean;
{$ENDIF}
begin
    e := GetEditor;
    if assigned(e) then
    begin
{$IFDEF PLUGIN_BUILD}
        b := false;
        for i := 0 to pluginsCount - 1 do
        begin
            if plugins[i].IsForm(e.FileName) then
            begin
	    	          plugins[i].CutExecute;
                b := true;
            end;
        end;
        if not b then
{$ENDIF}
            e.Text.CutToClipboard
    end;
end;

procedure TMainForm.actCopyExecute(Sender: TObject);
var
    e: TEditor;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
    b: Boolean;
{$ENDIF}
begin
    e := GetEditor;
    if assigned(e) then
    begin
{$IFDEF PLUGIN_BUILD}
        b := false;
        for i := 0 to pluginsCount - 1 do
        begin
            if plugins[i].IsForm(e.FileName) then
            begin
	    	          plugins[i].CopyExecute;
                b := true;
            end;
        end;
        if not b then
{$ENDIF}
            e.Text.CopyToClipboard;
    end;
end;

procedure TMainForm.actPasteExecute(Sender: TObject);
var
    e: TEditor;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
    b: Boolean;
{$ENDIF}
begin
    e := GetEditor;
    if assigned(e) then
    begin
   {$IFDEF PLUGIN_BUILD}
        b := false;
        for i := 0 to pluginsCount - 1 do
        begin
            if plugins[i].IsForm(e.FileName) then
            begin
	    	          plugins[i].PasteExecute;
                b := true;
            end;
        end;
        if not b then
    {$ENDIF}
            if e.Text.Focused then
                e.Text.PasteFromClipboard
            else
                SendMessage(GetFocus, WM_PASTE, 0, 0);
    end
    else
        SendMessage(GetFocus, WM_PASTE, 0, 0);

    e.Text.Refresh;
end;

procedure TMainForm.actSelectAllExecute(Sender: TObject);
var
    e: TEditor;
begin
    if LogOutput.Focused then
        LogOutput.SelectAll
    else
    if DebugOutput.Focused then
        DebugOutput.SelectAll
    else
    begin
        e := GetEditor;
        if assigned(e) then
            e.Text.SelectAll;
    end;
end;

procedure TMainForm.actDeleteExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if assigned(e) and e.Text.SelAvail then
        e.Text.ClearSelection;
end;

procedure TMainForm.actDeleteLineExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if assigned(e) then
    begin
        e.Text.ExecuteCommand(507, Char('0'), Pointer(0));
        // 507: delete line
    end;
end;

procedure TMainForm.actStatusbarExecute(Sender: TObject);
begin
    devData.Statusbar := actStatusbar.Checked;
    Statusbar.Visible := actStatusbar.Checked;
    Statusbar.Top := Self.ClientHeight;
end;

procedure TMainForm.btnFullScrRevertClick(Sender: TObject);
begin
    actFullScreen.Execute;
end;

procedure TMainForm.actFullScreenExecute(Sender: TObject);
var
    I: integer;
begin
    devData.FullScreen := FullScreenModeItem.Checked;
    if devData.FullScreen then
    begin
        OldLeft := Left;
        OldTop := Top;
        OldWidth := Width;
        OldHeight := Height;
        GetWindowPlacement(Self.Handle, @devData.WindowPlacement);
        self.Visible := false;

        SetWindowLong(Self.Handle, GWL_STYLE,
            (WS_BORDER and GetWindowLong(Self.Handle, GWL_STYLE)) and
            not WS_CAPTION);

        FullScreenModeItem.Caption := Lang[ID_ITEM_FULLSCRBACK];
        ControlBar1.Visible := devData.ShowBars;
        pnlFull.Visible := TRUE;

        Menu := nil; // get rid of that annoying flickering effect
        // disable the top-level menus in MainMenu
        for I := 0 to MainMenu.Items.Count - 1 do
            MainMenu.Items[I].Visible := False;
        Menu := MainMenu; // restore menu

        // set size to hide form menu
        //works with multi monitors now.
        SetBounds(
            (Left + Monitor.WorkAreaRect.Left) - ClientOrigin.X,
            (Top + Monitor.WorkAreaRect.Top) - ClientOrigin.Y,
            Monitor.Width + (Width - ClientWidth),
            Monitor.Height + (Height - ClientHeight));

        //  SetBounds(
        //   Monitor.WorkAreaRect.Left,
        //   Monitor.WorkAreaRect.Top,
        //   Monitor.Width,
        //   Monitor.Height);

        self.Visible := true;
    end
    else
    begin
        self.Visible := false;
        Left := OldLeft;
        Top := OldTop;
        Width := OldWidth;
        Height := OldHeight;
        // enable the top-level menus in MainMenu
        // before shown on screen to avoid flickering
        for I := 0 to MainMenu.Items.Count - 1 do
            MainMenu.Items[I].Visible := True;

        FullScreenModeItem.Caption := Lang[ID_ITEM_FULLSCRMODE];
        Controlbar1.Visible := TRUE;

        pnlFull.Visible := FALSE;

        // Return bounds to normal screen
        // Bug # 2945056
        SetBounds(
            Monitor.WorkAreaRect.Left,
            Monitor.WorkAreaRect.Top,
            Monitor.Width,
            Monitor.Height);

        SetWindowLong(self.Handle, GWL_STYLE, WS_TILEDWINDOW or
            (GetWindowLong(Self.Handle, GWL_STYLE)));
        SetWindowPlacement(Self.Handle, @devData.WindowPlacement);

        self.Visible := true;
    end;
end;

procedure TMainForm.actNextExecute(Sender: TObject);
begin
    PageControl.SelectNextPage(TRUE);
end;

procedure TMainForm.actPrevExecute(Sender: TObject);
begin
    PageControl.SelectNextPage(FALSE);
end;

procedure TMainForm.actCompOptionsExecute(Sender: TObject);
{$IFDEF PLUGIN_BUILD}
var
    i: Integer;
    tabs: TTabSheet;
{$ENDIF PLUGIN_BUILD}
begin
    with TCompForm.Create(Self) do
        try
            // EAB to fix: problem here if changed parent window
{$IFDEF PLUGIN_BUILD}
            for i := 0 to packagesCount - 1 do
            begin
                tabs := (plugins[delphi_plugins[i]] AS
                    IPlug_In_BPL).Retrieve_CompilerOptionsPane;
                if tabs <> nil then
                begin
                    tabs.PageControl := MainPages;
                    MainPages.ActivePage := tabs;
                end;
            end;
            MainPages.ActivePage := tabCompiler;
{$ENDIF PLUGIN_BUILD}
            ShowModal;
            CheckForDLLProfiling;
        finally
            Free;
        end;
end;

procedure TMainForm.actEditorOptionsExecute(Sender: TObject);
var
    idx: integer;
    pt: TPoint;
begin
    with TEditorOptForm.Create(Self) do
        try
            if ShowModal = mrOk then
            begin
                dmMain.UpdateHighlighter;
                for idx := 0 to pred(PageControl.PageCount) do
                    with TEditor(PageControl.Pages[idx].Tag) do
                    begin
                        // update the selected text color
                        StrtoPoint(pt, devEditor.Syntax.Values[cSel]);
                        Text.SelectedColor.Background := pt.X;
                        Text.SelectedColor.Foreground := pt.Y;

                        devEditor.AssignEditor(Text);
                        Text.Highlighter := dmMain.GetHighlighter(FileName);
                        ReconfigCompletion;
                    end;
                InitClassBrowser(chkCCCache.Tag = 1);
                if CppParser1.Statements.Count = 0 then
                    ScanActiveProject;
                if GetEditor <> nil then
                begin
                    GetEditor.Activate;
                end;
            end;
        finally
            Free;
        end;
end;

procedure TMainForm.actConfigToolsExecute(Sender: TObject);
begin
    fTools.Edit;
end;

procedure TMainForm.actUnitRemoveExecute(Sender: TObject);
var
    idx: integer;
    node: TTreeNode;
begin
    if not assigned(fProject) then
        exit;

{$IFDEF WIN32}
    while ProjectView.SelectionCount > 0 do
    begin
        node := ProjectView.Selections[0];
{$ENDIF}
{$IFDEF LINUX}
  while ProjectView.SelCount>0 do begin
    node:=ProjectView.Selected[0];
{$ENDIF}
        if not assigned(node) or
            (node.Level < 1) then
            Continue;
        if node.Data = Pointer(-1) then
            Continue;

        idx := integer(node.Data);

        if not fProject.Remove(idx, true) then
            exit;
    end;
end;

procedure TMainForm.actUnitRenameExecute(Sender: TObject);
var
    idx: integer;
    oldName,
    NewName: string;
begin
    if not assigned(fProject) then
        exit;
    if not assigned(ProjectView.Selected) or
        (ProjectView.Selected.Level < 1) then
        Exit;

    if ProjectView.Selected.Data = Pointer(-1) then
        Exit;

    idx := integer(ProjectView.Selected.Data);
    OldName := fProject.Units[idx].FileName;
    NewName := ExtractFileName(OldName);

    if InputQuery(Lang[ID_RENAME], Lang[ID_MSG_FILERENAME], NewName) and
        (ExtractFileName(NewName) <> '') and
        (NewName <> OldName) then
        try
            chdir(ExtractFilePath(OldName));

            // change in project first so on failure
            // file isn't already renamed
            fProject.SaveUnitAs(idx, ExpandFileto(NewName, GetCurrentDir));
            Renamefile(OldName, NewName);
        except
            MessageDlg(format(Lang[ID_ERR_RENAMEFILE], [OldName]),
                mtError, [mbok], 0);
        end;
end;

procedure TMainForm.actUnitOpenExecute(Sender: TObject);
var
    idx, idx2: integer;
begin
    if not assigned(fProject) then
        exit;
    if not assigned(ProjectView.Selected) or
        (ProjectView.Selected.Level < 1) then
        exit;
    if ProjectView.Selected.Data = Pointer(-1) then
        Exit;
    idx := integer(ProjectView.Selected.Data);
    idx2 := FileIsOpen(fProject.Units[idx].FileName, TRUE);
    if idx2 > -1 then
        GetEditor(idx2).Activate
    else
        fProject.OpenUnit(idx);
end;

procedure TMainForm.actUnitCloseExecute(Sender: TObject);
var
    idx: integer;
begin
    if assigned(fProject) and assigned(ProjectView.Selected) then
    begin
        idx := FileIsOpen(fProject.Units[integer(ProjectView.Selected.Data)].FileName, TRUE);
        if idx > -1 then
            CloseEditor(idx, True);
    end;
end;

procedure TMainForm.actUpdateCheckExecute(Sender: TObject);
var s: string;
begin
    //WebUpdateForm.Show;
    s := IncludeTrailingBackslash(devDirs.Exec) + UPDATE_PROGRAM;
    ExecuteFile(s, '', IncludeTrailingBackslash(devDirs.Exec), SW_SHOW)
end;

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
    with TAboutForm.Create(Self) do
        try
            ShowModal;
        finally
            Free;
        end;
end;

procedure TMainForm.actHelpCustomizeExecute(Sender: TObject);
begin
    with TfrmHelpEdit.Create(Self) do
        try
            if Execute then
                BuildHelpMenu;
        finally
            Free;
        end;
end;

procedure TMainForm.actProjectNewExecute(Sender: TObject);
var
    idx: integer;
begin
    idx := -1;
    if assigned(fProject) then
        idx := fProject.NewUnit(FALSE);
    if idx > -1 then
        with fProject.OpenUnit(idx) do
        begin
            Activate;
            Modified := True;
        end;
end;


procedure TMainForm.actProjectAddExecute(Sender: TObject);
var
    flt: string;
    idx: integer;
    FolderNode: TTreeNode;
    filtersBuilt: Boolean;
{$IFDEF PLUGIN_BUILD}
    i, j: Integer;
    filters: TStringList;
{$ENDIF}
begin
    if not assigned(fProject) then
        exit;

    flt := '';
    BuildFilter(flt, ftOpen);

    with dmMain.OpenDialog do
    begin
        Title := Lang[ID_NV_OPENADD];
        Filter := flt;
        if Execute then
        begin
            if Assigned(ProjectView.Selected) and
                (ProjectView.Selected.Data = Pointer(-1)) then
                FolderNode := ProjectView.Selected
            else
                FolderNode := fProject.Node;
            try
                for idx := 0 to pred(Files.Count) do
                begin
                    fProject.AddUnit(Files[idx], FolderNode, false);
                    // add under folder
                    CppParser1.AddFileToScan(Files[idx]);
                end;
                fProject.RebuildNodes;
                CppParser1.ParseList;
            except;
                fProject.RebuildNodes;
                CppParser1.ParseList;
            end;
        end;
    end;
end;

{ end XXXKF changed }

procedure TMainForm.actProjectRemoveExecute(Sender: TObject);
begin
    fProject.Remove(-1, true);
end;

procedure TMainForm.actProjectOptionsExecute(Sender: TObject);
begin
    if assigned(fProject) then
        fProject.ShowOptions;
    // set again the window's and application's captions
    // in case they have been changed...
    UpdateAppTitle;
end;

procedure TMainForm.actProjectSourceExecute(Sender: TObject);
{$IFDEF PLUGIN_BUILD}
var
    i: Integer;
{$ENDIF}
begin
    if assigned(fProject) then
    begin
{$IFDEF PLUGIN_BUILD}
        for i := 0 to pluginsCount - 1 do
            plugins[i].OpenFile(fProject.FileName);
{$ENDIF}
        OpenFile(fProject.FileName);
    end;
end;

procedure TMainForm.actFindExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    SearchCenter.Project := fProject;
    if assigned(e) then
        if e.Search(FALSE) then
            ShowDockForm(frmReportDocks[cFindTab]);
    SearchCenter.Project := nil;
end;

procedure TMainForm.actFindAllExecute(Sender: TObject);
begin
    SearchCenter.SingleFile := FALSE;
    SearchCenter.Project := fProject;
    SearchCenter.Replace := false;
    SearchCenter.Editor := GetEditor;
    if SearchCenter.ExecuteSearch then
        ShowDockForm(frmReportDocks[cFindTab]);
    SearchCenter.Project := nil;
end;

procedure TMainForm.actReplaceExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if assigned(e) then
        e.Search(TRUE);
end;

procedure TMainForm.actFindNextExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if Assigned(e) then
        e.SearchAgain;
end;

procedure TMainForm.actGotoExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if Assigned(e) then
        e.GotoLine;
end;

function TMainForm.PrepareForCompile(rebuild: Boolean): Boolean;
var
    e: TEditor;
    i: Integer;
begin
    Result := False;
    if (Assigned(fProject)) and (fProject.Units.Count = 0) then
    begin
        Application.MessageBox(
            'Why in the world are you trying to compile an empty project? ;-)',
{$IFDEF WIN32}
            'Huh?', MB_ICONINFORMATION);
{$ENDIF}
{$IFDEF LINUX}
        'Huh?', [smbOK], smsInformation);
{$ENDIF}
        Exit;
    end;

    LogOutput.Clear;
    CompilerOutput.Items.Clear;
    ResourceOutput.Items.Clear;
    SizeFile.Text := '';
    TotalErrors.Text := '0';

    if not devData.ShowProgress then
        // if no compile progress window, open the compiler output
        ShowDockForm(frmReportDocks[cLogTab]);

    e := GetEditor;
    fCompiler.Target := ctNone;

    if assigned(fProject) then
        // no matter if the editor file is not in project,
        // the target is ctProject since we have a project open...
        fCompiler.Target := ctProject
    else
    if assigned(e) and
        (GetFiletyp(e.Filename) in [utSrc, utRes]) or e.new then
        fCompiler.Target := ctFile;

    if fCompiler.Target = ctFile then
    begin
        SaveFile(e);
        if e.New then
            Exit;
        fCompiler.SourceFile := e.FileName;
    end
    else
    if fCompiler.Target = ctProject then
    begin
        actSaveAllExecute(Self);
        for i := 0 to pred(PageControl.PageCount) do
        begin
            e := GetEditor(i);
            if (e.InProject) and (e.Modified) then
                Exit;
        end;
    end;

    fCompiler.PerfectDepCheck := not devCompiler.FastDep;
    // increment the build number
    if Assigned(fProject) then
    begin
        if (
            fProject.VersionInfo.AutoIncBuildNrOnCompile or
            (fProject.VersionInfo.AutoIncBuildNrOnRebuild and rebuild)
            ) then
            fProject.IncrementBuildNumber;
        fProject.BuildPrivateResource;
    end;
    Result := True;
end;

procedure TMainForm.OnCompileTerminated(Sender: TObject);
begin
    Application.Restore;
end;

procedure TMainForm.actCompileExecute(Sender: TObject);
begin
    if fCompiler.Compiling then
    begin
        MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
        Exit;
    end;
    if PrepareForCompile(false) then
        fCompiler.Compile;
end;

procedure TMainForm.actRunExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if assigned(fProject) then
    begin
        if fProject.CurrentProfile.typ = dptStat then
            MessageDlg(Lang[ID_ERR_NOTEXECUTABLE], mtError, [mbOK], Handle)
        else
        if not FileExists(fProject.Executable) then
            MessageDlg(Lang[ID_ERR_PROJECTNOTCOMPILED], mtWarning,
                [mbOK], Handle)
        else
        if fProject.CurrentProfile.typ = dptDyn then
        begin
            if fProject.CurrentProfile.HostApplication = '' then
                MessageDlg(Lang[ID_ERR_HOSTMISSING], mtWarning, [mbOK], Handle)
            else
            if not FileExists(fProject.CurrentProfile.HostApplication) then
                MessageDlg(Lang[ID_ERR_HOSTNOTEXIST], mtWarning,
                    [mbOK], Handle)
            else
            begin
                if devData.MinOnRun then
                    Application.Minimize;
                devExecutor.ExecuteAndWatch(
                    fProject.CurrentProfile.HostApplication,
                    fProject.CmdLineArgs,
                    ExtractFileDir(
                    fProject.CurrentProfile.HostApplication),
                    True, INFINITE, OnCompileTerminated);
            end;
        end
        else
        begin
            if devData.MinOnRun then
                Application.Minimize;
            devExecutor.ExecuteAndWatch(fProject.Executable,
                fProject.CmdLineArgs,
                ExtractFileDir(fProject.Executable),
                True, INFINITE, OnCompileTerminated);
        end;
    end
    else
    if assigned(e) then
    begin
        // GAR 10 Nov 2009
        // Hack for Wine/Linux
        // ProductName returns empty string for Wine/Linux
        // for Windows, it returns OS name (e.g. Windows Vista).
        if (MainForm.JvComputerInfoEx1.OS.ProductName = '') then

            if not FileExists(ChangeFileExt(e.FileName, '')) then
                MessageDlg(Lang[ID_ERR_SRCNOTCOMPILED], mtWarning,
                    [mbOK], Handle)
            else
            begin
                if devData.MinOnRun then
                    Application.Minimize;
                devExecutor.ExecuteAndWatch(ChangeFileExt(e.FileName, ''), '',
                    ExtractFilePath(e.FileName),
                    True, INFINITE, OnCompileTerminated);
                devExecutor.Free;   // Free the executable
            end
        else
        if not FileExists(ChangeFileExt(e.FileName, EXE_EXT)) then
            MessageDlg(Lang[ID_ERR_SRCNOTCOMPILED], mtWarning, [mbOK], Handle)
        else
        begin
            if devData.MinOnRun then
                Application.Minimize;
            devExecutor.ExecuteAndWatch(ChangeFileExt(e.FileName, EXE_EXT), '',
                ExtractFilePath(e.FileName),
                True, INFINITE, OnCompileTerminated);
            devExecutor.Free;  // Free the executable
        end;
    end;
end;

procedure TMainForm.actCompRunExecute(Sender: TObject);
begin
    if fCompiler.Compiling then
    begin
        MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
        Exit;
    end;
    if PrepareForCompile(false) then
    begin
        fCompiler.Compile;
        fCompiler.OnCompilationEnded := actRunExecute;
    end;
end;

procedure TMainForm.actRebuildExecute(Sender: TObject);
begin
    if fCompiler.Compiling then
    begin
        MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
        Exit;
    end;
    if not PrepareForCompile(true) then
        Exit;
    fCompiler.RebuildAll;
    Application.ProcessMessages;
end;

procedure TMainForm.actCleanExecute(Sender: TObject);
begin
    if fCompiler.Compiling then
    begin
        MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
        Exit;
    end;
    fCompiler.Clean;
    Application.ProcessMessages;
end;

procedure TMainForm.InitializeDebugger;
    procedure Initialize;
    begin
        fDebugger.OnCallStack := OnCallStack;
        fDebugger.OnThreads := OnThreads;
        fDebugger.OnLocals := OnLocals;
    end;
begin
    if ((devCompiler.CompilerType = ID_COMPILER_MINGW) or
        (devCompiler.CompilerType = ID_COMPILER_LINUX)) then
    begin
        if not (fDebugger is TGDBDebugger) then
        begin
            if Assigned(fDebugger) then
                fDebugger.Free;
            fDebugger := TGDBDebugger.Create;
            Initialize;
        end;
    end
{  else if devCompiler.CompilerType in ID_COMPILER_VC then
  begin
    if not (fDebugger is TCDBDebugger) then
    begin
      if Assigned(fDebugger) then
        fDebugger.Free;
}
{$WARNINGS OFF 'Instance of TCDBDebugger containing abstract method...'}
    //      fDebugger := TCDBDebugger.Create;
{$WARNINGS ON}
{      Initialize;
    end;
  end
  else if devCompiler.CompilerType = ID_COMPILER_DMARS then
  begin
    if not (fDebugger is TCDBDebugger) then
    begin
      if Assigned(fDebugger) then
        fDebugger.Free;
        }
{$WARNINGS OFF 'Instance of TCDBDebugger containing abstract method...'}
    //     fDebugger := TCDBDebugger.Create;
{$WARNINGS ON}
    //      Initialize;
    //    end;
    //  end;

end;

procedure TMainForm.PrepareDebugger;
var
    idx: integer;
    sl: TStringList;
begin
    //Recreate the debugger object
    InitializeDebugger;

    //Prepare the debugger environment
    DebugOutput.Clear;
    actStopExecute.Execute;
    fDebugger.ClearIncludeDirs;
    ShowDockForm(frmReportDocks[cDebugTab]);

    // add to the debugger the global include dirs
    sl := TStringList.Create;
    try
        ExtractStrings([';'], [' '], PChar(devDirs.C), sl);
        for idx := 0 to sl.Count - 1 do
            fDebugger.AddIncludeDir(sl[idx]);
        ExtractStrings([';'], [' '], PChar(devDirs.Cpp), sl);
        for idx := 0 to sl.Count - 1 do
            fDebugger.AddIncludeDir(sl[idx]);
    finally
        sl.Free;
    end;
end;

procedure TMainForm.doDebugAfterCompile(Sender: TObject);
var
    e: TEditor;
    idx, idx2: integer;
    s: string;
begin
    PrepareDebugger;
    if assigned(fProject) then
    begin
        if not FileExists(fProject.Executable) then
        begin
            MessageDlg(Lang[ID_ERR_PROJECTNOTCOMPILED], mtWarning, [mbOK], 0);
            Exit;
        end;

        // add to the debugger the project include dirs
        for idx := 0 to fProject.CurrentProfile.Includes.Count - 1 do
            fDebugger.AddIncludeDir(fProject.CurrentProfile.Includes[idx]);

        if fProject.CurrentProfile.typ <> dptDyn then
            fDebugger.Execute(StringReplace(fProject.Executable, '\',
                '\\', [rfReplaceAll]), fCompiler.RunParams)
        // EAB TODO:  command line args are passed when debugging?
        else
        begin
            if fProject.CurrentProfile.HostApplication = '' then
            begin
                MessageDlg(Lang[ID_ERR_HOSTMISSING], mtWarning, [mbOK], 0);
                exit;
            end
            else
            if not FileExists(fProject.CurrentProfile.HostApplication) then
            begin
                MessageDlg(Lang[ID_ERR_HOSTNOTEXIST], mtWarning, [mbOK], 0);
                exit;
            end;

            fDebugger.Execute(
                StringReplace(fProject.CurrentProfile.HostApplication,
                '\', '\\', [rfReplaceAll]), fCompiler.RunParams);
        end;

        fDebugger.RefreshBreakpoints;
        
    end
    else
    begin
        e := GetEditor;
        if assigned(e) then
        begin

            // GAR 10 Nov 2009
            // Hack for Wine/Linux
            // ProductName returns empty string for Wine/Linux
            // for Windows, it returns OS name (e.g. Windows Vista).
            if (MainForm.JvComputerInfoEx1.OS.ProductName = '') then
                if not FileExists(ChangeFileExt(e.FileName, '')) then
                begin
                    MessageDlg(Lang[ID_ERR_SRCNOTCOMPILED],
                        mtWarning, [mbOK], 0);
                    exit;
                end
                else
                if not FileExists(ChangeFileExt(e.FileName, EXE_EXT)) then
                begin
                    MessageDlg(Lang[ID_ERR_SRCNOTCOMPILED],
                        mtWarning, [mbOK], 0);
                    exit;
                end;

            if e.Modified then // if file is modified
                if not SaveFile(e) then // save it first
                    Abort; // if it's not saved, abort
            chdir(ExtractFilePath(e.FileName));

            // GAR 10 Nov 2009
            // Hack for Wine/Linux
            // ProductName returns empty string for Wine/Linux
            // for Windows, it returns OS name (e.g. Windows Vista).
            if (MainForm.JvComputerInfoEx1.OS.ProductName = '') then
                fDebugger.Execute(StringReplace(
                    ChangeFileExt(ExtractFileName(e.FileName), ''),
                    '\', '\\', [rfReplaceAll]),
                    fCompiler.RunParams)
            else
                fDebugger.Execute(StringReplace(
                    ChangeFileExt(ExtractFileName(e.FileName),
                    EXE_EXT), '\', '\\',
                    [rfReplaceAll]), fCompiler.RunParams);

            fDebugger.RefreshBreakpoints;
            fDebugger.RefreshWatches;
        end;
    end;

    //Then run the debugger
    fDebugger.Go;
end;

procedure TMainForm.actDebugExecute(Sender: TObject);
var
    UpToDate: Boolean;
    MessageResult, spos: Integer;
    linker_original: string;
    opts: TProjProfile;
begin

    if not fDebugger.Executing then
    begin
        if Assigned(fProject) then
        begin

            // remove "--no-export-all-symbols" from the linker''s command line
            opts := fProject.CurrentProfile;
            linker_original := opts.Linker;

            // look for "--no-export-all-symbols"
            spos := Pos('--no-export-all-symbols', opts.Linker);
            // following more opts
            // if found, delete it
            if spos > 0 then
                Delete(opts.Linker, spos, length('--no-export-all-symbols'));

            fProject.CurrentProfile := opts;

            //Save all the files then set the UI status
            actSaveAllExecute(Self);
            (Sender as TAction).Tag := 0;
            (Sender as TAction).Enabled := False;
            StatusBar.Panels[3].Text :=
                'Checking if project needs to be rebuilt...';

            //Run make to see if the project is up to date, the cache the result and restore our state
            fCompiler.Target := ctProject;
            UpToDate := fCompiler.UpToDate;
            (Sender as TAction).Tag := 1;
            StatusBar.Panels[3].Text := '';

            //Ask the user if the project is out of date
            if not UpToDate then
            begin
                if devData.AutoCompile = -1 then
                begin
                    MessageResult :=
                        devMessageBox(Self,
                        'The project you are working on is out of date. Do you ' +
                        'want to rebuild the project before debugging?',
                        'wxDev-C++',
                        'Don''t show this again',
                        MB_ICONQUESTION or MB_YESNOCANCEL);

                    if MessageResult > 0 then
                        devData.AutoCompile := abs(MessageResult);
                    MessageResult := abs(MessageResult);
                end
                else
                    MessageResult := devData.AutoCompile;

                case MessageResult of
                    mrYes:
                    begin
                        fCompiler.OnCompilationEnded := doDebugAfterCompile;
                        actCompile.Execute;
                        Exit;
                    end;
                    mrCancel:
                        Exit;
                end;
            end;
        end;

        fProject.CurrentProfile.Linker := linker_original;

        doDebugAfterCompile(Sender);

    end
    else
    if fDebugger.Paused then
    begin
        RemoveActiveBreakpoints;
        fDebugger.Go;
    end;
end;

procedure TMainForm.actPauseDebugExecute(Sender: TObject);
begin
    if fDebugger.Executing then
        fDebugger.Pause;
end;

procedure TMainForm.actPauseDebugUpdate(Sender: TObject);
begin
    (Sender as TAction).Enabled :=
        fDebugger.Executing and not fDebugger.Paused; //and
    //(fDebugger is TCDBDebugger);
end;

procedure TMainForm.actEnviroOptionsExecute(Sender: TObject);
begin
    with TEnviroForm.Create(Self) do
        try
            if ShowModal = mrok then
            begin
                SetupProjectView;
                if devData.MsgTabs then
                    DockServer.DockStyle.TabServerOption.TabPosition := tpTop
                else
                    DockServer.DockStyle.TabServerOption.TabPosition :=
                        tpBottom;
                if devData.FullScreen then
                    ControlBar1.Visible := devData.ShowBars;

                if devData.LangChange = TRUE then
                begin
                    Lang.SetLang(devData.Language);
                    LoadText(TRUE);
                end;
                if devData.ThemeChange then
                    Loadtheme;
                devShortcuts1.Filename := devDirs.Config + DEV_SHORTCUTS_FILE;
                PageControl.OwnerDraw := DevData.HiliteActiveTab;
            end;
        finally
            Free;
        end;
end;

procedure TMainForm.actUpdatePageCount(Sender: TObject);
begin
    (Sender as TCustomAction).Enabled := PageControl.PageCount > 0;
end;

procedure TMainForm.actUpdatePageorProject(Sender: TObject);
begin
    (Sender as TCustomAction).Enabled := assigned(fProject)
        or (PageControl.PageCount > 0);
end;

procedure TMainForm.actDebugUpdate(Sender: TObject);
begin
    if Assigned(fProject) then
        (Sender as TCustomAction).Enabled :=
            not (fProject.CurrentProfile.typ = dptStat) and
            (not devExecutor.Running) and ((not fDebugger.Executing) or
            fDebugger.Paused) and (not fCompiler.Compiling) and
            ((Sender as TAction).Tag = 1)
    else
        (Sender as TCustomAction).Enabled := (PageControl.PageCount > 0) and
            (not devExecutor.Running) and ((not fDebugger.Executing) or
            fDebugger.Paused)
            and (not fCompiler.Compiling) and ((Sender as TAction).Tag = 1);
end;

procedure TMainForm.actCompileUpdate(Sender: TObject);
begin
    (Sender as TCustomAction).Enabled :=
        (assigned(fProject) or (PageControl.PageCount > 0)) and
        not devExecutor.Running and not fDebugger.Executing and
        not fCompiler.Compiling;
end;

procedure TMainForm.actUpdatePageProject(Sender: TObject);
begin
    (Sender as TCustomAction).Enabled :=
        assigned(fProject) and (PageControl.PageCount > 0);
end;

procedure TMainForm.actUpdateProject(Sender: TObject);
begin
    (Sender as TCustomAction).Enabled := (assigned(fProject));
end;

procedure TMainForm.actUpdateEmptyEditor(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
{$IFNDEF PRIVATE_BUILD}
    try
{$ENDIF}
        (Sender as TAction).Enabled :=
            Assigned(e) and Assigned(e.Text) and (e.Text.Text <> '');
{$IFNDEF PRIVATE_BUILD}
    except
    end;
{$ENDIF}
end;

procedure TMainForm.actUpdateDebuggerRunning(Sender: TObject);
begin
    (Sender as TAction).Enabled := fDebugger.Executing;
end;

procedure TMainForm.actUpdateDebuggerPaused(Sender: TObject);
begin
    (Sender as TAction).Enabled := fDebugger.Executing and fDebugger.Paused;
end;

procedure TMainForm.ToolbarClick(Sender: TObject);
begin
    tbMain.Visible := ToolMainItem.checked;
    tbEdit.Visible := ToolEditItem.Checked;
    tbCompile.Visible := ToolCompileandRunItem.Checked;
    tbDebug.Visible := ToolDebugItem.Checked;
    tbProject.Visible := ToolProjectItem.Checked;
    tbOptions.Visible := ToolOptionItem.Checked;
    tbSpecials.Visible := ToolSpecialsItem.Checked;
    tbSearch.Visible := ToolSearchItem.Checked;
    tbClasses.Visible := ToolClassesItem.Checked;

    devData.ToolbarMain := ToolMainItem.checked;
    devData.ToolbarEdit := ToolEditItem.Checked;
    devData.ToolbarCompile := ToolCompileandRunItem.Checked;
    devData.ToolbarDebug := ToolDebugItem.Checked;
    devData.ToolbarProject := ToolProjectItem.Checked;
    devData.ToolbarOptions := ToolOptionItem.Checked;
    devData.ToolbarSpecials := ToolSpecialsItem.Checked;
    devData.ToolbarSearch := ToolSearchItem.Checked;
    devData.ToolbarClasses := ToolClassesItem.Checked;
end;

procedure TMainForm.ControlBar1ContextPopup(Sender: TObject;
    MousePos: TPoint; var Handled: Boolean);
var
    pt: TPoint;
begin
    pt := ControlBar1.ClientToScreen(MousePos);
    TrackPopupMenu(ToolbarsItem.Handle, TPM_LEFTALIGN or TPM_LEFTBUTTON,
        pt.x, pt.y, 0, Self.Handle, nil);
    Handled := TRUE;
end;

procedure TMainForm.ApplicationEvents1Idle(Sender: TObject;
    var Done: Boolean);
begin
    PageControl.Visible := assigned(PageControl.FindNextPage(nil, TRUE, TRUE));
    InsertBtn.Enabled := InsertItem.Visible;
end;

procedure TMainForm.actProjectMakeFileExecute(Sender: TObject);
begin
    fCompiler.Project := fProject;
    fCompiler.BuildMakeFile;
    OpenFile(fCompiler.MakeFile);
end;

procedure TMainForm.actMsgCopyExecute(Sender: TObject);
var
    PopupComp: TComponent;
begin
    PopupComp := MessagePopup.PopupComponent;
    if PopupComp is TEdit then
    begin
        if TEdit(PopupComp).SelText <> '' then
            Clipboard.AsText := TEdit(PopupComp).SelText
        else
        if TEdit(PopupComp).Text <> '' then
            Clipboard.AsText := TEdit(PopupComp).Text;
    end
    else
    if PopupComp is TMemo then
    begin
        if TMemo(PopupComp).SelText <> '' then
            Clipboard.AsText := TMemo(PopupComp).SelText
        else
        if TMemo(PopupComp).Lines.Text <> '' then
            Clipboard.AsText := TMemo(PopupComp).Lines.Text;
    end
    else
    if PopupComp is TListView then
    begin
        if Assigned(TListView(PopupComp).Selected) then
            Clipboard.AsText :=
                StringReplace(
                StringReplace(Trim(TListView(PopupComp).Selected.Caption +
                ' ' +
                TListView(PopupComp).Selected.SubItems.Text),
                #13#10,
                ' ', [rfReplaceAll]),
                #10, ' ', [rfReplaceAll]);
    end;
end;

procedure TMainForm.actMsgClearExecute(Sender: TObject);
var
    PopupComp: TComponent;
begin
    PopupComp := MessagePopup.PopupComponent;
    if PopupComp is TEdit then
        TEdit(PopupComp).Clear
    else
    if PopupComp is TMemo then
        TMemo(PopupComp).Clear
    else
    if PopupComp is TListView then
        TListView(PopupComp).Items.Clear;
end;

procedure TMainForm.actBreakPointExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if assigned(e) then
        e.ToggleBreakPoint(e.Text.CaretY);
end;

procedure TMainForm.actIncrementalExecute(Sender: TObject);
var
    pt: TPoint;
    temp, temp2: String;
begin
    SearchCenter.Editor := GetEditor;
    SearchCenter.AssignSearchEngine;

    frmIncremental.SearchAgain.Shortcut := actFindNext.Shortcut;
    pt := ClienttoScreen(point(PageControl.Left, PageControl.Top));
    frmIncremental.Left := pt.x;
    frmIncremental.Top := pt.y;
    frmIncremental.Editor := GetEditor.Text;
    temp := Self.Caption;
    temp2 := StatusBar.Panels[3].Text;
    Self.Caption := 'Press Esc to leave the Incremental Search Mode.';
    StatusBar.Panels[3].Text :=
        'Press Esc to leave the Incremental Search Mode.';
    frmIncremental.ShowModal;
    Self.Caption := temp;
    StatusBar.Panels[3].Text := temp2;
end;

procedure TMainForm.CompilerOutputDblClick(Sender: TObject);
var
    Col, Line: integer;
    tFile: string;
    e: TEditor;
    intTmpPos, delimPos: integer;
    strCol: string;
begin
    // do nothing if no item selected, or no line/unit specified
    if not assigned(CompilerOutput.Selected) or
        (CompilerOutput.Selected.Caption = '') or
        (CompilerOutput.Selected.SubItems[0] = '') then
        exit;

    Col := 0;
    Line := StrToIntDef(CompilerOutput.Selected.Caption, -1);
    if Line = -1 then
        Exit;

    tfile := trim(CompilerOutput.Selected.SubItems[0]);
    if fileExists(tfile) = false then
    begin
        if strContains(' from ', tfile) then
        begin
            intTmpPos := pos(' from ', tfile);
            tfile := trim(copy(tfile, 0, intTmpPos));
        end;
        if copy(tfile, length(tfile), 1) = ',' then
            tfile := trim(copy(tfile, 0, length(tfile) - 1));
        delimPos := LastDelimiter(':', tfile);
        if delimPos <> 2 then
        begin
            strCol := copy(tfile, delimPos + 1, length(tfile));
            if isNumeric(strCol) then
                Line := strToInt(strCol);
            tfile := trim(copy(tfile, 0, delimPos - 1));
        end;

    end;


    e := GetEditorFromFileName(tfile);

    Application.ProcessMessages;
    if assigned(e) then
    begin
        e.SetErrorFocus(col, line);
        e.Activate;
    end;
end;

procedure TMainForm.FindOutputDblClick(Sender: TObject);
var
    col, line: integer;
    e: TEditor;
begin
    // goto find pos
    if not assigned(FindOutPut.Selected) then
        exit;
    Col := strtoint(FindOutput.Selected.SubItems[0]);
    Line := strtoint(FindOutput.Selected.Caption);

    // replaced redundant code...
    e := GetEditorFromFileName(FindOutput.Selected.SubItems[1]);

    if assigned(e) then
    begin
        e.Text.CaretXY := BufferCoord(col, line);
        e.Text.SetSelWord;
        e.Text.CaretXY := e.Text.BlockBegin;
        e.Activate;
    end;
end;

procedure TMainForm.actShowBarsExecute(Sender: TObject);
begin
    if devData.FullScreen then
    begin
        ControlBar1.Visible := not Controlbar1.Visible;
        if Controlbar1.Visible then
            pnlFull.Top := -2;
    end;
end;

procedure TMainForm.FormContextPopup(Sender: TObject; MousePos: TPoint;
    var Handled: Boolean);
var
    pt: TPoint;
begin
    pt := ClientToScreen(MousePos);
    TrackPopupMenu(ViewMenu.Handle, TPM_LEFTALIGN or TPM_LEFTBUTTON,
        pt.x, pt.y, 0, Self.Handle, nil);
    Handled := TRUE;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
{$IFDEF PLUGIN_BUILD}
var
    i: Integer;
{$ENDIF}
begin
    case key of
        // EAB Bypass SynEdit Delete Line event
        89:
            if ssCtrl in Shift then
            begin
                Key := 0;
    { e := GetEditor;
     if assigned(e) then
     begin
       if e.Text.CanRedo then
       if RedoItem.Enabled then
           e.Text.Redo
     end; }
            end;

{$IFDEF WIN32}
        VK_F6:
{$ENDIF}
{$IFDEF LINUX}
    XK_F6:
{$ENDIF}
            if ssCtrl in Shift then
                ShowDebug;
        VK_F1:
            if defaultHelpF1 then
                WordToHelpKeyword;
    end;

{$IFDEF PLUGIN_BUILD}
    for i := 0 to packagesCount - 1 do
        (plugins[delphi_plugins[i]] AS IPlug_In_BPL).FormKeyDown(
            Sender, key, Shift);
{$ENDIF}
end;

function TMainForm.GetEditor(const index: integer): TEditor;
var
    i: integer;
begin
    if index = -1 then
        i := PageControl.ActivePageIndex
    else
        i := index;

    if (i >= PageControl.PageCount) or (i < 0) then
        result := nil
    else
        result := TEditor(PageControl.Pages[i].Tag);
end;

procedure TMainForm.actAddWatchExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if Assigned(e) then
    begin
        if e.Text.SelAvail then
            AddDebugVar(e.Text.SelText, wbWrite)
        else
            AddWatchBtnClick(self);
    end;
end;

procedure TMainForm.AddDebugVar(s: string; when: TWatchBreakOn);

begin
    if Trim(s) = '' then
        Exit;
    if fDebugger.Executing and fDebugger.Paused then
    begin

        fDebugger.AddWatch(s, when);
        fDebugger.RefreshContext([cdWatches]);
    end;
end;

procedure TMainForm.actNextStepExecute(Sender: TObject);
begin
    if fDebugger.Paused and fDebugger.Executing then
        fDebugger.Next;
end;

procedure TMainForm.actStepSingleExecute(Sender: TObject);
begin
    if fDebugger.Paused and fDebugger.Executing then
        fDebugger.Step;
end;

procedure TMainForm.DebugFinishClick(Sender: TObject);
begin
    if fDebugger.Paused and fDebugger.Executing then
        fDebugger.Finish;
end;

procedure TMainForm.actWatchItemExecute(Sender: TObject);
begin
    ShowDockForm(frmReportDocks[cDebugTab]);
    DebugSubPages.ActivePage := tabWatches;
end;

procedure TMainForm.actRemoveWatchExecute(Sender: TObject);
var
    node: TTreeNode;
begin
    //Trace the selected watch node to the highest-level node
    node := WatchTree.Selected;
    while Assigned(Node) and (Assigned(node.Parent)) do
        node := node.Parent;

    //Then remove the watch
    if Assigned(node) then
    begin
        fDebugger.RemoveWatch(WatchTree.Selected);
        WatchTree.Items.Delete(node);
    end;
end;

procedure TMainForm.RemoveActiveBreakpoints;
var i: integer;
begin
    for i := 0 to PageControl.PageCount - 1 do
        GetEditor(i).RemoveBreakpointFocus;
end;

procedure TMainForm.GotoBreakpoint(bfile: string; bline: integer);
var
    e: TEditor;
begin
    // correct win32 make's path
    bfile := StringReplace(bfile, '/', '\', [rfReplaceAll]);

    e := GetEditorFromFileName(bfile);
    Application.ProcessMessages;
    if assigned(e) then
    begin
        e.SetActiveBreakpointFocus(bline);
        e.Activate;
    end;
    Application.BringToFront;
end;

procedure TMainForm.actStepOverExecute(Sender: TObject);
begin
    if fDebugger.Paused and fDebugger.Executing then
    begin
        RemoveActiveBreakpoints;
        fDebugger.Go;
    end;
end;

procedure TMainForm.actStopExecuteExecute(Sender: TObject);
begin
    if fDebugger.Executing then
    begin
       fDebugger.CloseDebugger(sender);
    end;

end;

procedure TMainForm.actRestartDebugExecute(Sender: TObject);
begin
    actStopExecute.Execute;
    actDebug.Execute;
end;

procedure TMainForm.actUndoUpdate(Sender: TObject);
var
    e: TEditor;
begin
{$IFNDEF PRIVATE_BUILD}
    try
{$ENDIF}
        //Added for wx: Try catch for Some weird On Close Error
        e := GetEditor;
        actUndo.Enabled := assigned(e) and assigned(e.Text) and e.Text.CanUndo;
{$IFNDEF PRIVATE_BUILD}
    except
    end;
{$ENDIF}
end;

procedure TMainForm.actRedoUpdate(Sender: TObject);
var
    e: TEditor;
begin
{$IFNDEF PRIVATE_BUILD}
    //Added for wx: Try catch for Some weird On Close Error
    try
{$ENDIF}
        e := GetEditor;
        actRedo.enabled := assigned(e) and assigned(e.Text) and e.Text.CanRedo;
{$IFNDEF PRIVATE_BUILD}
    except
    end;
{$ENDIF}
end;

procedure TMainForm.actCutUpdate(Sender: TObject);
var
    e: TEditor;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
    pluginCatched: Boolean;
{$ENDIF}
begin
{$IFNDEF PRIVATE_BUILD}
    //Added for wx: Try catch for Some weird On Close Error
    try
{$ENDIF}
        e := GetEditor;
        if assigned(e) then
        begin
{$IFDEF PLUGIN_BUILD}
            pluginCatched := false;
            for i := 0 to pluginsCount - 1 do
            begin
                if plugins[i].IsForm(e.FileName) then
                begin
                    actCut.Enabled := True;
                    pluginCatched := true;
                end;
            end;
            if not pluginCatched then
{$ENDIF}
                actCut.Enabled := assigned(e.Text) and e.Text.SelAvail;
        end;
{$IFNDEF PRIVATE_BUILD}
    except
    end;
{$ENDIF}
end;

procedure TMainForm.actCopyUpdate(Sender: TObject);
var
    e: TEditor;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
    pluginCatched: Boolean;
{$ENDIF}
begin
{$IFNDEF PRIVATE_BUILD}
    //Added for wx: Try catch for Some weird On Close Error
    try
{$ENDIF}
        e := GetEditor;

        if assigned(e) then
        begin
{$IFDEF PLUGIN_BUILD}
            pluginCatched := false;
            for i := 0 to pluginsCount - 1 do
            begin
                if plugins[i].IsForm(e.FileName) then
                begin
                    actCopy.Enabled := True;
                    pluginCatched := True;
                end;
            end;
            if not pluginCatched then
{$ENDIF}
                actCopy.Enabled := e.Text.SelAvail;
        end;
{$IFNDEF PRIVATE_BUILD}
    except
    end;
{$ENDIF}
end;

procedure TMainForm.actPasteUpdate(Sender: TObject);
var
    e: TEditor;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
    pluginCatched: Boolean;
{$ENDIF}
begin
{$IFNDEF PRIVATE_BUILD}
    //Added for wx: Try catch for Some weird On Close Error
    try
{$ENDIF}
        e := GetEditor;

        if assigned(e) then
        begin
{$IFDEF PLUGIN_BUILD}
            pluginCatched := false;
            for i := 0 to pluginsCount - 1 do
            begin
                if plugins[i].IsForm(e.FileName) then
                begin
                    actPaste.Enabled := True;
                    pluginCatched := True;
                end;
            end;
            if not pluginCatched then
{$ENDIF}
                actPaste.Enabled := assigned(e.Text) and e.Text.CanPaste;
        end;
{$IFNDEF PRIVATE_BUILD}
    except
    end;
{$ENDIF}
end;

procedure TMainForm.actSaveUpdate(Sender: TObject);
var
    e: TEditor;
begin
{$IFNDEF PRIVATE_BUILD}
    //Added for wx: Try catch for Some weird Error
    try
{$ENDIF}
        e := GetEditor;
        actSave.Enabled := assigned(e) and assigned(e.Text) and
            (e.Modified or e.Text.Modified or (e.FileName = ''));
{$IFNDEF PRIVATE_BUILD}
    except
        //e:=nil;
    end;
{$ENDIF}
end;

procedure TMainForm.actSaveAsUpdate(Sender: TObject);
var
    e: TEditor;
begin
{$IFNDEF PRIVATE_BUILD}
    //Added for wx: Try catch for Some weird On Close Error
    try
{$ENDIF}
        e := GetEditor;
        actSaveAs.Enabled := assigned(e);
{$IFNDEF PRIVATE_BUILD}
    except
    end;
{$ENDIF}
end;

procedure TMainForm.actFindNextUpdate(Sender: TObject);
var
    e: TEditor;
begin
{$IFNDEF PRIVATE_BUILD}
    //Added for wx: Try catch for Some weird On Close Error
    try
{$ENDIF}
        e := GetEditor;
        // ** need to also check if a search has already happened
        actFindNext.Enabled := assigned(e) and assigned(e.Text) and
            (e.Text.Text <> '');
{$IFNDEF PRIVATE_BUILD}
    except
    end;
{$ENDIF}
end;

procedure TMainForm.actFileMenuExecute(Sender: TObject);
begin
    //  dummy event to keep menu active
end;

procedure TMainForm.ShowDebug;
begin
    DebugForm := TDebugForm.Create(nil);
    DebugForm.Show;
end;

procedure TMainForm.actToolsMenuExecute(Sender: TObject);
var
    idx, i: integer;
begin
    for idx := (ToolsMenu.IndexOf(mnuToolSep1) + 1) to pred(ToolsMenu.Count) do
    begin
        i := ToolsMenu.Items[idx].tag;
        if i > 0 then
            ToolsMenu.Items[idx].Enabled :=
                FileExists(ParseParams(fTools.ToolList[i]^.Exec));
    end;
end;

function TMainForm.GetEditorFromFileName(ffile: string;
    donotReOpen: boolean): TEditor;
var
    index, index2: integer; //mandrav
    e: TEditor;
begin
    result := nil;

    { First, check wether the file is already open }
    for index := 0 to PageControl.PageCount - 1 do
    begin
        e := GetEditor(index);
        if not Assigned(e) then
            Continue
        else
        begin
            //ExpandFileName reduces all the "\..\" in the path
            if SameFileName(e.FileName, ExpandFileName(ffile)) then
            begin
                Result := e;
                Exit;
            end;
        end;
    end;

    if fCompiler.Target in [ctFile, ctNone] then
    begin
        if FileExists(ffile) then
            OpenFile(ffile);
        index := FileIsOpen(ffile);
        if index <> -1 then
            result := GetEditor(index);
    end
    else
    if (fCompiler.Target = ctProject) and Assigned(fProject) then
    begin
        index := fProject.GetUnitFromString(ffile);
        if index <> -1 then
        begin
            //mandrav
            index2 := FileIsOpen(ExpandFileName(fProject.Directory +
                ffile), TRUE);
            if index2 = -1 then
            begin
                if (donotReOpen = true) then
                begin
                    result := nil;
                    exit;
                end;
                result := fProject.OpenUnit(index)
            end
            else
                result := GetEditor(index2);
            //mandrav - end
        end
        else
        begin
            if FileExists(ffile) then
                OpenFile(ffile);
            index := FileIsOpen(ffile);
            if index <> -1 then
                result := GetEditor(index);
        end;
    end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
    if not devData.FullScreen then // only if not going full-screen
        GetWindowPlacement(Self.Handle, @devData.WindowPlacement);
    StatusBar.Panels[3].Width := StatusBar.Width - StatusBar.Panels[0].Width -
        StatusBar.Panels[1].Width - StatusBar.Panels[2].Width -
        StatusBar.Panels[4].Width;
end;

procedure TMainForm.InitClassBrowser(Full: boolean);
var
    e: TEditor;
    sl: TStringList;
    I: integer;
    ProgressEvents: array[0..1] of TProgressEvent;
begin
    CppParser1.Enabled := devClassBrowsing.Enabled;
    CppParser1.ParseLocalHeaders := devClassBrowsing.ParseLocalHeaders;
    CppParser1.ParseGlobalHeaders := devClassBrowsing.ParseGlobalHeaders;
    CodeCompletion1.Color := devCodeCompletion.BackColor;
    CodeCompletion1.Width := devCodeCompletion.Width;
    CodeCompletion1.Height := devCodeCompletion.Height;
    ClassBrowser1.Enabled := devClassBrowsing.Enabled;
    ClassBrowser1.ShowFilter := TShowFilter(devClassBrowsing.ShowFilter);
    // if class-browsing is disabled, clear the class-browser
    // if there is no active editor, clear the class-browser
    e := GetEditor;
    if not ClassBrowser1.Enabled or (not Assigned(e) and
        (ClassBrowser1.ShowFilter = sfCurrent)) then
    begin
        CppParser1.Reset;
        ClassBrowser1.Clear;
    end;
    actBrowserViewAll.Checked := ClassBrowser1.ShowFilter = sfAll;
    actBrowserViewProject.Checked := ClassBrowser1.ShowFilter = sfProject;
    actBrowserViewCurrent.Checked := ClassBrowser1.ShowFilter = sfCurrent;
    ClassBrowser1.ClassFoldersFile := DEV_CLASSFOLDERS_FILE;
    actBrowserUseColors.Checked := devClassBrowsing.UseColors;
    ClassBrowser1.UseColors := devClassBrowsing.UseColors;
    actBrowserShowInherited.Checked := devClassBrowsing.ShowInheritedMembers;
    ClassBrowser1.ShowInheritedMembers :=
        devClassBrowsing.ShowInheritedMembers;

    Screen.Cursor := crHourglass;
    if Full and CppParser1.Enabled then
    begin
        Application.ProcessMessages;
        ProgressEvents[0] := CppParser1.OnCacheProgress;
        ClassBrowser1.Parser := nil;
        CodeCompletion1.Parser := nil;
        FreeAndNil(CppParser1);
        CppParser1 := TCppParser.Create(Self);
        ClassBrowser1.Parser := CppParser1;
        CodeCompletion1.Parser := CppParser1;
        // moved here from ScanActiveProject()
        with CppParser1 do
        begin
            Tokenizer := CppTokenizer1;
            Enabled := devClassBrowsing.Enabled;
            ParseLocalHeaders := devClassBrowsing.ParseLocalHeaders;
            ParseGlobalHeaders := devClassBrowsing.ParseGlobalHeaders;
            OnStartParsing := CppParser1StartParsing;
            OnEndParsing := CppParser1EndParsing;
            OnTotalProgress := CppParser1TotalProgress;
            OnCacheProgress := ProgressEvents[0];
            sl := TStringList.Create;
            try
                ExtractStrings([';'], [' '], PChar(devDirs.C), sl);
                for I := 0 to sl.Count - 1 do
                    AddIncludePath(sl[I]);
                ExtractStrings([';'], [' '], PChar(devDirs.Cpp), sl);
                for I := 0 to sl.Count - 1 do
                    AddIncludePath(sl[I]);
            finally
                sl.Free;
            end;

            // update parser reference in editors
            for I := 0 to PageControl.PageCount - 1 do
                GetEditor(I).UpdateParser;
            if devCodeCompletion.UseCacheFiles then
                Load(devDirs.Config + DEV_COMPLETION_CACHE);
            if Assigned(fProject) then
                ScanActiveProject;
        end;
    end;
    Screen.Cursor := crDefault;
end;

procedure TMainForm.ScanActiveProject;
var
    I: integer;
    I1: Cardinal;
    e: TEditor;
begin
    Application.ProcessMessages;
    if not ClassBrowser1.Enabled then
        Exit;
    if Assigned(fProject) then
        ClassBrowser1.ProjectDir := fProject.Directory
    else
    begin
        e := GetEditor;
        if Assigned(e) then
            ClassBrowser1.ProjectDir := ExtractFilePath(e.FileName)
        else
            ClassBrowser1.ProjectDir := '';
    end;
    I1 := GetTickCount;
    with CppParser1 do
    begin
        Reset;
        if Assigned(fProject) then
        begin
            ProjectDir := fProject.Directory;
            for I := 0 to fProject.Units.Count - 1 do
                AddFileToScan(fProject.Units[I].FileName, True);
            for I := 0 to fProject.CurrentProfile.Includes.Count - 1 do
                AddProjectIncludePath(fProject.CurrentProfile.Includes[I]);
        end
        else
        begin
            e := GetEditor;
            if Assigned(e) then
            begin
                ProjectDir := ExtractFilePath(e.FileName);
                AddFileToScan(e.FileName);
            end
            else
                ProjectDir := '';
        end;
        ParseList;
        if PageControl.ActivePageIndex > -1 then
        begin
            e := GetEditor(PageControl.ActivePageIndex);
            if Assigned(e) then
                ClassBrowser1.CurrentFile := e.FileName;
        end;
    end;
    StatusBar.Panels[3].Text :=
        'Done parsing in ' + FormatFloat('#,###,##0.00',
        (GetTickCount - I1) / 1000) +
        ' seconds';
end;

procedure TMainForm.ClassBrowser1Select(Sender: TObject;
    Filename: TFileName; Line: Integer);
var
    E: TEditor;
begin
    // mandrav
    E := GetEditorFromFilename(FileName);
    if Assigned(E) then
        E.GotoLineNr(Line);
end;

procedure TMainForm.CppParser1TotalProgress(Sender: TObject;
    FileName: String; Total, Current: Integer);
begin
    if FileName <> '' then
    begin
        StatusBar.Panels[3].Text := 'Parsing ' + Filename;
        //FormProgress.Max := Total;
        //FormProgress.Position := Current;
    end
    else
    begin
        //FormProgress.Position := 0;
        StatusBar.Panels[3].Text := 'Done parsing.';
        StatusBar.Panels[2].Text := '';
    end;

    StatusBar.Update;
    //FormProgress.Update;
end;

procedure TMainForm.CodeCompletion1Resize(Sender: TObject);
begin
    devCodeCompletion.Width := CodeCompletion1.Width;
    devCodeCompletion.Height := CodeCompletion1.Height;
end;

procedure TMainForm.actSwapHeaderSourceUpdate(Sender: TObject);
begin
    actSwapHeaderSource.Enabled := PageControl.PageCount > 0;
end;

procedure TMainForm.actSwapHeaderSourceExecute(Sender: TObject);
var
    e: TEditor;
    Ext: String;
    FileName: String;
    i: integer;
begin
    e := GetEditor;
    if not Assigned(e) then
        Exit;

    Ext := ExtractFileExt(e.FileName);
    FileName := '';

    if Assigned(fProject) then
    begin
        FileName := e.FileName;
        if GetFileTyp(e.FileName) = utSrc then
            for i := 0 to fProject.Units.Count - 1 do
            begin
                FileName := ChangeFileExt(e.FileName, HPP_EXT);
                if AnsiCompareFileName(ExtractFileName(FileName),
                    ExtractFileName(fProject.Units[i].FileName)) = 0 then
                begin
                    FileName := fProject.Units[i].FileName;
                    break;
                end;
                FileName := ChangeFileExt(e.FileName, H_EXT);
                if AnsiCompareFileName(ExtractFileName(FileName),
                    ExtractFileName(fProject.Units[i].FileName)) = 0 then
                begin
                    FileName := fProject.Units[i].FileName;
                    break;
                end;
            end
        else
        if GetFileTyp(e.FileName) = utHead then
            for i := 0 to fProject.Units.Count - 1 do
            begin
                FileName := ChangeFileExt(e.FileName, CPP_EXT);
                if AnsiCompareFileName(ExtractFileName(FileName),
                    ExtractFileName(fProject.Units[i].FileName)) = 0 then
                begin
                    FileName := fProject.Units[i].FileName;
                    break;
                end;
                FileName := ChangeFileExt(e.FileName, C_EXT);
                if AnsiCompareFileName(ExtractFileName(FileName),
                    ExtractFileName(fProject.Units[i].FileName)) = 0 then
                begin
                    FileName := fProject.Units[i].FileName;
                    break;
                end;
                FileName := ChangeFileExt(e.FileName, CC_EXT);
                if AnsiCompareFileName(ExtractFileName(FileName),
                    ExtractFileName(fProject.Units[i].FileName)) = 0 then
                begin
                    FileName := fProject.Units[i].FileName;
                    break;
                end;
                FileName := ChangeFileExt(e.FileName, CXX_EXT);
                if AnsiCompareFileName(ExtractFileName(FileName),
                    ExtractFileName(fProject.Units[i].FileName)) = 0 then
                begin
                    FileName := fProject.Units[i].FileName;
                    break;
                end;
                FileName := ChangeFileExt(e.FileName, CP2_EXT);
                if AnsiCompareFileName(ExtractFileName(FileName),
                    ExtractFileName(fProject.Units[i].FileName)) = 0 then
                begin
                    FileName := fProject.Units[i].FileName;
                    break;
                end;
                FileName := ChangeFileExt(e.FileName, CP_EXT);
                if AnsiCompareFileName(ExtractFileName(FileName),
                    ExtractFileName(fProject.Units[i].FileName)) = 0 then
                begin
                    FileName := fProject.Units[i].FileName;
                    break;
                end;
            end
    end;
    if not FileExists(FileName) then
    begin
        if GetFileTyp(e.FileName) = utSrc then
        begin
            if (CompareText(Ext, CPP_EXT) = 0) or
                (CompareText(Ext, CC_EXT) = 0) or
                (CompareText(Ext, CXX_EXT) = 0) or
                (CompareText(Ext, CP2_EXT) = 0) or
                (CompareText(Ext, CP_EXT) = 0) then
            begin
                FileName := ChangeFileExt(e.FileName, HPP_EXT);
                if not FileExists(FileName) then
                    FileName := ChangeFileExt(e.FileName, H_EXT);
            end
            else
                FileName := ChangeFileExt(e.FileName, H_EXT);
        end
        else
        if GetFileTyp(e.FileName) = utHead then
        begin
            FileName := ChangeFileExt(e.FileName, CPP_EXT);
            if not FileExists(FileName) then
            begin
                FileName := ChangeFileExt(e.FileName, CC_EXT);
                if not FileExists(FileName) then
                begin
                    FileName := ChangeFileExt(e.FileName, CXX_EXT);
                    if not FileExists(FileName) then
                    begin
                        FileName := ChangeFileExt(e.FileName, CP2_EXT);
                        if not FileExists(FileName) then
                        begin
                            FileName := ChangeFileExt(e.FileName, CP_EXT);
                            if not FileExists(FileName) then
                                FileName := ChangeFileExt(e.FileName, C_EXT);
                        end;
                    end;
                end;
            end;
        end;
    end; //else

    if not FileExists(FileName) then
    begin
        Application.MessageBox('No corresponding header or source file found.',
{$IFDEF WIN32}
            'Error', MB_ICONINFORMATION);
{$ENDIF}
{$IFDEF LINUX}
        'Error', [smbOK], smsInformation);
{$ENDIF}
        exit;
    end;
    e := GetEditorFromFileName(FileName);
    if Assigned(e) then
        e.Activate
    else
        OpenFile(FileName);
end;

procedure TMainForm.actSyntaxCheckExecute(Sender: TObject);
begin
    if fCompiler.Compiling then
    begin
        MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
        Exit;
    end;
    if not PrepareForCompile(false) then
        Exit;
    fCompiler.CheckSyntax;
end;

procedure TMainForm.actUpdateExecute(Sender: TObject);
begin
    if Assigned(fProject) then
        (Sender as TCustomAction).Enabled :=
            not (fProject.CurrentProfile.typ = dptStat)
    else
        (Sender as TCustomAction).Enabled := PageControl.PageCount > 0;
end;

procedure TMainForm.actRunUpdate(Sender: TObject);
begin
    if Assigned(fProject) then
        (Sender as TCustomAction).Enabled :=
            not (fProject.CurrentProfile.typ = dptStat) and not
            devExecutor.Running and not fDebugger.Executing and
            not fCompiler.Compiling
    else
        (Sender as TCustomAction).Enabled :=
            (PageControl.PageCount > 0) and not devExecutor.Running and
            not fDebugger.Executing and not fCompiler.Compiling;
end;

procedure TMainForm.PageControlChange(Sender: TObject);
var
    e: TEditor;
    i, x, y: integer;
    intActivePage: Integer;
{$IFDEF PLUGIN_BUILD}
    pluginCatched: Boolean;
{$ENDIF}
begin
    intActivePage := PageControl.ActivePageIndex;

    if intActivePage > -1 then
    begin
        e := GetEditor(intActivePage);
        if Assigned(e) then
        begin
{$IFDEF PLUGIN_BUILD}
            pluginCatched := false;
            for i := 0 to pluginsCount - 1 do
                pluginCatched :=
                    pluginCatched or plugins[i].MainPageChanged(e.FileName);
            if not pluginCatched then
            begin
{$ENDIF}
                e.Text.SetFocus;
                if ClassBrowser1.Enabled then
                    ClassBrowser1.CurrentFile := e.FileName;
                for i := 1 to 9 do
                begin
                    if e.Text.GetBookMark(i, x, y) then
                    begin
                        TogglebookmarksPopItem.Items[i - 1].Checked := true;
                        TogglebookmarksItem.Items[i - 1].Checked := true;
                    end
                    else
                    begin
                        TogglebookmarksPopItem.Items[i - 1].Checked := false;
                        TogglebookmarksItem.Items[i - 1].Checked := false;
                    end;
                end;
{$IFDEF PLUGIN_BUILD}
            end;
{$ENDIF}
        end;
        UpdateAppTitle;
    end;
    RefreshTodoList;
end;

procedure TMainForm.actConfigShortcutsExecute(Sender: TObject);
begin
    devShortcuts1.Edit;
end;

procedure TMainForm.DateTimeMenuItemClick(Sender: TObject);
var e: TEditor;
begin
    e := GetEditor;
    if assigned(e) then
        e.InsertString(FormatDateTime('dd/mm/yy hh:nn', Now), TRUE);
end;

procedure TMainForm.actProgramResetExecute(Sender: TObject);
begin
    devExecutor.Reset;
end;

procedure TMainForm.actProgramResetUpdate(Sender: TObject);
begin
    if Assigned(fProject) then
        (Sender as TCustomAction).Enabled :=
            not (fProject.CurrentProfile.typ = dptStat) and devExecutor.Running
    else
        (Sender as TCustomAction).Enabled :=
            (PageControl.PageCount > 0) and devExecutor.Running;
end;

procedure TMainForm.CommentheaderMenuItemClick(Sender: TObject);
var  e: TEditor;
begin
    e := GetEditor;
    if assigned(e) then
    begin
        e.InsertString('/*' + #13#10 +
            '  Name: ' + #13#10 +
            '  Copyright: ' + #13#10 +
            '  Author: ' + #13#10 +
            '  Date: ' + FormatDateTime('dd/mm/yy hh:nn', Now) + #13#10 +
            '  Description: ' + #13#10 +
            '*/' + #13#10, true);
    end;
end;

procedure TMainForm.PageControlMouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    I: integer;
    Allow: Boolean;
begin
    I := PageControl.IndexOfTabAt(X, Y);
    if Button = mbRight then
    begin // select new tab even with right mouse button
        if I > -1 then
        begin
            PageControl.ActivePageIndex := I;
            PageControl.OnChanging(PageControl, Allow);
            PageControl.OnChange(PageControl);
        end;
    end
    else // see if it's a drag operation
        PageControl.Pages[PageControl.ActivePageIndex].BeginDrag(False);
end;

procedure TMainForm.actNewTemplateUpdate(Sender: TObject);
begin
    actNewTemplate.Enabled := Assigned(fProject);
end;

procedure TMainForm.actCommentExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if Assigned(e) then
        e.CommentSelection;
end;

procedure TMainForm.actUncommentExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if Assigned(e) then
        e.UncommentSelection;
end;

procedure TMainForm.actIndentExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if Assigned(e) then
        e.IndentSelection;
end;

procedure TMainForm.actUnindentExecute(Sender: TObject);
var
    e: TEditor;
begin
    e := GetEditor;
    if Assigned(e) then
        e.UnindentSelection;
end;

procedure TMainForm.PageControlDragOver(Sender, Source: TObject; X,
    Y: Integer; State: TDragState; var Accept: Boolean);
var
    I: integer;
begin
    I := PageControl.IndexOfTabAt(X, Y);
    Accept := (Source is TTabSheet) and (I <> PageControl.ActivePageIndex);
end;

procedure TMainForm.PageControlDragDrop(Sender, Source: TObject; X,
    Y: Integer);
var
    I: integer;
begin
    I := PageControl.IndexOfTabAt(X, Y);
    if (Source is TTabSheet) and (I <> PageControl.ActivePageIndex) then
        PageControl.Pages[PageControl.ActivePageIndex].PageIndex := I;
end;

procedure TMainForm.actGotoFunctionExecute(Sender: TObject);
var
    e: TEditor;
    st: PStatement;
begin
    with TFunctionSearchForm.Create(Self) do
    begin
        fFileName := GetEditor.FileName;
        fParser := CppParser1;
        if ShowModal = mrOK then
        begin
            st := PStatement(lvEntries.Selected.Data);
            //make sure statement still exists
            if fParser.Statements.IndexOf(lvEntries.Selected.Data) = -1 then
                lvEntries.Selected.Data := nil;
            e := GetEditor;
            if Assigned(e) and Assigned(st) then
            begin
                if st^._IsDeclaration then
                    e.GotoLineNr(st^._DeclImplLine)
                else
                    e.GotoLineNr(st^._Line);
            end;
        end;
    end;
end;

procedure TMainForm.actBrowserGotoDeclUpdate(Sender: TObject);
begin
    (Sender as TAction).Enabled := Assigned(ClassBrowser1.Selected);
end;

procedure TMainForm.actBrowserGotoImplUpdate(Sender: TObject);
begin
    if Assigned(ClassBrowser1)
        and ClassBrowser1.Enabled
        and Assigned(ClassBrowser1.Selected)
        and Assigned(ClassBrowser1.Selected.Data) then
        //check if node.data still in statements
        if CppParser1.Statements.IndexOf(ClassBrowser1.Selected.Data) >= 0 then
            (Sender as TAction).Enabled :=
                (PStatement(ClassBrowser1.Selected.Data)^._Kind <> skClass)
        else
        begin
            ClassBrowser1.Selected.Data := nil;
            (Sender as TAction).Enabled := False;
        end
    else
        (Sender as TAction).Enabled := False;
end;

procedure TMainForm.actBrowserNewClassUpdate(Sender: TObject);
begin
    (Sender as TAction).Enabled := ClassBrowser1.Enabled
        and Assigned(fProject);
end;

procedure TMainForm.actBrowserNewMemberUpdate(Sender: TObject);
begin
    if Assigned(ClassBrowser1.Selected)
        and Assigned(ClassBrowser1.Selected.Data) then
        //check if node.data still in statements
        if CppParser1.Statements.IndexOf(ClassBrowser1.Selected.Data) >= 0 then
            (Sender as TAction).Enabled :=
                (PStatement(ClassBrowser1.Selected.Data)^._Kind = skClass)
        else
        begin
            ClassBrowser1.Selected.Data := nil;
            (Sender as TAction).Enabled := False;
        end
    else
        (Sender as TAction).Enabled := False;
end;

procedure TMainForm.actBrowserNewVarUpdate(Sender: TObject);
begin
    if Assigned(ClassBrowser1.Selected)
        and Assigned(ClassBrowser1.Selected.Data) then
        //check if node.data still in statements
        if CppParser1.Statements.IndexOf(ClassBrowser1.Selected.Data) >= 0 then
            (Sender as TAction).Enabled :=
                (PStatement(ClassBrowser1.Selected.Data)^._Kind = skClass)
        else
        begin
            ClassBrowser1.Selected.Data := nil;
            (Sender as TAction).Enabled := False;
        end
    else
        (Sender as TAction).Enabled := False;
end;

procedure TMainForm.actBrowserAddFolderUpdate(Sender: TObject);
begin
    (Sender as TAction).Enabled := ClassBrowser1.Enabled
        and Assigned(fProject);
end;

procedure TMainForm.actBrowserViewAllUpdate(Sender: TObject);
begin
    (Sender as TAction).Enabled := True;
end;

procedure TMainForm.actBrowserGotoDeclExecute(Sender: TObject);
var
    e: TEditor;
    Node: TTreeNode;
    fname: string;
    line: integer;
begin
    Node := ClassBrowser1.Selected;
    fName := CppParser1.GetDeclarationFileName(Node.Data);
    line := CppParser1.GetDeclarationLine(Node.Data);
    e := GetEditorFromFileName(fname);
    if Assigned(e) then
        e.GotoLineNr(line);
end;

procedure TMainForm.actBrowserGotoImplExecute(Sender: TObject);
var
    e: TEditor;
    Node: TTreeNode;
    fname: string;
    line: integer;
begin
    Node := ClassBrowser1.Selected;
    fName := CppParser1.GetImplementationFileName(Node.Data);
    line := CppParser1.GetImplementationLine(Node.Data);
    e := GetEditorFromFileName(fname);
    if Assigned(e) then
        e.GotoLineNr(line);
end;

procedure TMainForm.actBrowserNewClassExecute(Sender: TObject);
begin
    TNewClassForm.Create(Self).ShowModal;
end;

procedure TMainForm.actBrowserNewMemberExecute(Sender: TObject);
begin
    TNewMemberForm.Create(Self).ShowModal;
end;

procedure TMainForm.actBrowserNewVarExecute(Sender: TObject);
begin
    TNewVarForm.Create(Self).ShowModal;
end;

procedure TMainForm.actBrowserViewAllExecute(Sender: TObject);
begin
    ClassBrowser1.ShowFilter := sfAll;
    actBrowserViewAll.Checked := True;
    actBrowserViewProject.Checked := False;
    actBrowserViewCurrent.Checked := False;
    devClassBrowsing.ShowFilter := Ord(sfAll);
end;

procedure TMainForm.actBrowserViewProjectExecute(Sender: TObject);
begin
    ClassBrowser1.ShowFilter := sfProject;
    actBrowserViewAll.Checked := False;
    actBrowserViewProject.Checked := True;
    actBrowserViewCurrent.Checked := False;
    devClassBrowsing.ShowFilter := Ord(sfProject);
end;

procedure TMainForm.actBrowserViewCurrentExecute(Sender: TObject);
var
    e: TEditor;
begin
    ClassBrowser1.ShowFilter := sfCurrent;
    actBrowserViewAll.Checked := False;
    actBrowserViewProject.Checked := False;
    actBrowserViewCurrent.Checked := True;
    e := GetEditor;
    if Assigned(e) then
        ClassBrowser1.CurrentFile := e.FileName
    else
        ClassBrowser1.CurrentFile := '';
    devClassBrowsing.ShowFilter := Ord(sfCurrent);
end;

procedure TMainForm.actProfileProjectExecute(Sender: TObject);
var
    optP, optD: TCompilerOption;
    idxP, idxD: integer;
    prof, deb: boolean;
begin
    //todo: disable profiling for non gcc compilers
    // see if profiling is enabled
    if (assigned(fProject) and
        ((fProject.CurrentProfile.compilerType <> ID_COMPILER_MINGW) or
        (fProject.CurrentProfile.compilerType <> ID_COMPILER_LINUX))) then
    begin
        ShowMessage('Profiling is Disabled for Non-MingW compilers.');
        exit;
    end;
    prof := devCompiler.FindOption('-pg', optP, idxP);
    if prof then
    begin
        if Assigned(fProject) then
        begin
            if (fProject.CurrentProfile.CompilerOptions <> '') and
                (fProject.CurrentProfile.CompilerOptions[idxP + 1] = '1') then
                prof := true
            else
                prof := false;
        end
        else
            prof := optP.optValue > 0;
    end;
    // see if debugging is enabled
    deb := devCompiler.FindOption('-g3', optD, idxD);
    if deb then
    begin
        if Assigned(fProject) then
        begin
            if (fProject.CurrentProfile.CompilerOptions <> '') and
                (fProject.CurrentProfile.CompilerOptions[idxD + 1] = '1') then
                deb := true
            else
                deb := false;
        end
        else
            deb := optD.optValue > 0;
    end;

    if (not prof) or (not deb) then
        if MessageDlg(Lang[ID_MSG_NOPROFILE], mtConfirmation,
            [mbYes, mbNo], 0) = mrYes then
        begin
            optP.optValue := 1;
            if Assigned(fProject) then
                SetProjCompOpt(idxP, True);
            devCompiler.Options[idxP] := optP;
            optD.optValue := 1;
            if Assigned(fProject) then
                SetProjCompOpt(idxD, True);
            devCompiler.Options[idxD] := optD;

            // Check for strip executable
            if devCompiler.FindOption('-s', optD, idxD) then
            begin
                optD.optValue := 0;
                if not Assigned(fProject) then
                    devCompiler.Options[idxD] := optD;
                // set global debugging option only if not working with a project
                SetProjCompOpt(idxD, False);
                // set the project's correpsonding option too
            end;

            actRebuildExecute(nil);
            Exit;
        end
        else
            Exit;
    if Assigned(fProject) then
        if not FileExists(ExtractFilePath(fProject.Executable) +
            GPROF_CHECKFILE) then
        begin
            MessageDlg(Lang[ID_MSG_NORUNPROFILE], mtError, [mbOk], 0);
            Exit;
        end;
    if not Assigned(ProfileAnalysisForm) then
        ProfileAnalysisForm := TProfileAnalysisForm.Create(Self);
    ProfileAnalysisForm.Show;
end;

procedure TMainForm.actBrowserAddFolderExecute(Sender: TObject);
var
    S: string;
    Node: TTreeNode;
begin
    if ClassBrowser1.FolderCount >= MAX_CUSTOM_FOLDERS then
    begin
        MessageDlg(Format(Lang[ID_POP_MAXFOLDERS], [MAX_CUSTOM_FOLDERS]),
            mtError, [mbOk], 0);
        Exit;
    end;

    Node := ClassBrowser1.Selected;
    S := 'New folder';
    if InputQuery(Lang[ID_POP_ADDFOLDER], Lang[ID_MSG_ADDBROWSERFOLDER], S) and
        (S <> '') then
        ClassBrowser1.AddFolder(S, Node);
end;

procedure TMainForm.actBrowserRemoveFolderExecute(Sender: TObject);
begin
    if Assigned(ClassBrowser1.Selected) and
        (ClassBrowser1.Selected.ImageIndex =
        ClassBrowser1.ItemImages.Globals) then
        if MessageDlg(Lang[ID_MSG_REMOVEBROWSERFOLDER], mtConfirmation,
            [mbYes, mbNo], 0) = mrYes then
            ClassBrowser1.RemoveFolder(ClassBrowser1.Selected.Text);
end;

procedure TMainForm.actBrowserRenameFolderExecute(Sender: TObject);
var
    S: string;
begin
    if Assigned(ClassBrowser1.Selected) and
        (ClassBrowser1.Selected.ImageIndex =
        ClassBrowser1.ItemImages.Globals) then
    begin
        S := ClassBrowser1.Selected.Text;
        if InputQuery(Lang[ID_POP_RENAMEFOLDER],
            Lang[ID_MSG_RENAMEBROWSERFOLDER],
            S) and (S <> '') then
            ClassBrowser1.RenameFolder(ClassBrowser1.Selected.Text, S);
    end;
end;

procedure TMainForm.actCloseAllButThisExecute(Sender: TObject);
var
    idx: integer;
    current: integer;
    e: TEditor;
    curFilename, tempFileName: string;
{$IFDEF PLUGIN_BUILD}
    //tempEditor: TEditor;
    //pluginCatched : Boolean;
{$ENDIF}
begin
    idx := 0;
    current := PageControl.ActivePageIndex;

    // EAB: this could be used if we want to enforce Unit behavior for open tabs, but it is not consistent right now, so I disabled this
  {curFilename := AnsiLowerCase(GetEditor(current).FileName);

  tempEditor := GetEditor(current);
  tempFileName := ChangeFileExt(tempEditor.FileName, '');
  while idx < PageControl.PageCount do
  begin
      tempEditor := nil;
      if idx <> current then
      begin
          tempEditor := GetEditor(idx);
          if (tempFileName = ChangeFileExt(tempEditor.FileName, '')) and (tempEditor.AssignedPlugin <> '') then
              break
          else
              tempEditor := nil;
      end;
      idx := idx + 1;
  end;
  idx := 0;}
    while idx < PageControl.PageCount do
    begin
{$IFDEF PLUGIN_BUILD}
    {curFilename := AnsiLowerCase(GetEditor(idx).FileName);
    pluginCatched := false;
    if tempEditor <> nil then
        pluginCatched := plugins[unit_plugins[tempEditor.AssignedPlugin]].ShouldNotCloseEditor(tempEditor.FileName, curFilename);
    }
{$ENDIF}
        if (idx = current) then //or pluginCatched then
            idx := idx + 1
        else
        begin
            if not CloseEditor(idx, true, true) then
                // EAB: use true in third parameter to prevent closing all unit files
                Break
            else
            begin
                if idx < current then
                    current := current - 1;
            end;
        end;
    end;

    e := GetEditor;
    if Assigned(e) then
    begin
        // don't know why, but at this point the editor does not show its caret.
        // if we shift the focus to another control and back to the editor,
        // everything is fine. (I smell another SynEdit bug?)
        e.TabSheet.SetFocus;
{$IFDEF PLUGIN_BUILD}
        e.Activate;
{$ELSE}
    e.Text.SetFocus;
{$ENDIF}
    end;
end;

procedure TMainForm.lvBacktraceDblClick(Sender: TObject);
var
    idx: integer;
    e: TEditor;
begin
    if Assigned(lvBacktrace.Selected) and
        (lvBackTrace.Selected.SubItems.Count >= 3) then
    begin
        idx := StrToIntDef(lvBacktrace.Selected.SubItems[2], -1);
        if idx <> -1 then
        begin
            e := GetEditorFromFileName(CppParser1.GetFullFilename(
                lvBacktrace.Selected.SubItems[1]));
            if Assigned(e) then
            begin
                if fDebugger.Paused then
                    fDebugger.SetContext(lvBacktrace.Selected.Index);
                e.GotoLineNr(idx);
                e.Activate;
            end;
        end;
    end;
end;

procedure TMainForm.GotoTopOfStackTrace;
var
    I: Integer;
    Idx: Integer;
    e: TEditor;
begin
    for I := 0 to lvBacktrace.Items.Count - 1 do
        if (lvBackTrace.Items[I].SubItems.Count >= 3) and
            (lvBackTrace.Items[I].SubItems[2] <> '') then
        begin
            idx := StrToIntDef(lvBacktrace.Items[I].SubItems[2], -1);
            if idx <> -1 then
            begin
                e := GetEditorFromFileName(CppParser1.GetFullFilename(
                    lvBacktrace.Items[I].SubItems[1]));
                if Assigned(e) then
                begin
                    e.SetActiveBreakpointFocus(idx);
                    Break;
                end;
            end;
        end;
end;

procedure TMainForm.lvBacktraceCustomDrawItem(Sender: TCustomListView;
    Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
    if not (cdsSelected in State) then
    begin
        if Assigned(Item.Data) then
            Sender.Canvas.Font.Color := clBlue
        else
            Sender.Canvas.Font.Color := clWindowText;
    end;
end;

procedure TMainForm.lvBacktraceMouseMove(Sender: TObject;
    Shift: TShiftState; X, Y: Integer);
var
    It: TListItem;
begin
    with Sender as TListView do
    begin
        It := GetItemAt(X, Y);
        if Assigned(It) and Assigned(It.Data) then
            Cursor := crHandPoint
        else
            Cursor := crDefault;
    end;
end;

procedure TMainForm.lvThreadsDblClick(Sender: TObject);
begin
    if lvThreads.Selected <> nil then
        fDebugger.SetThread(StrToInt(lvThreads.Selected.SubItems[0]));
end;

procedure TMainForm.devFileMonitorNotifyChange(Sender: TObject;
    ChangeType: TdevMonitorChangeType; Filename: String);
var
    Entry: PReloadFile;
begin
    Entry := New(PReloadFile);
    ReloadFilenames.Add(Entry);
    Entry^.FileName := FileName;
    Entry^.ChangeType := ChangeType;

    if not IsIconized then
        HandleFileMonitorChanges;
end;

procedure TMainForm.HandleFileMonitorChanges;
var
    I: Integer;
    procedure ReloadEditor(FileName: string);
    var
        e: TEditor;
        p: TBufferCoord;
{$IFDEF PLUGIN_BUILD}
        j: Integer;
        pluginForm: Boolean;
{$ENDIF}
    begin
        e := GetEditorFromFileName(Filename);
        if Assigned(e) then
        begin
{$IFDEF PLUGIN_BUILD}
            pluginForm := false;
            for j := 0 to pluginsCount - 1 do
                pluginForm := pluginForm or plugins[j].ReloadForm(Filename);
            if not pluginForm then
{$ENDIF}
            begin
                p := e.Text.CaretXY;
                e.Text.Lines.LoadFromFile(Filename);
                if (p.Line <= e.Text.Lines.Count) then
                    e.Text.CaretXY := p;
            end;
        end;
    end;
begin
    if ReloadFilenames.Count = 1 then
    begin
        with PReloadFile(ReloadFilenames[0])^ do
            case ChangeType of
                mctChanged:
                    if MessageDlg(Filename +
                        ' has been modified outside of wxDev-C++.'#13#10#13#10 +
                        'Do you want to reload the file from disk? This will discard all your unsaved changes.',
                        mtConfirmation, [mbYes, mbNo], Handle) = mrYes then
                        ReloadEditor(Filename);
                mctDeleted:
                    MessageDlg(Filename + ' has been renamed or deleted.',
                        mtInformation, [mbOk], Handle);
            end;
        ReloadFilenames.Clear;
    end
    else
    if ReloadFilenames.Count <> 0 then
    begin
        if Assigned(FilesReloadForm) then
            FilesReloadForm.Files := ReloadFilenames
        else
        begin
            FilesReloadForm := TFilesReloadFrm.Create(Self);
            FilesReloadForm.Files := ReloadFilenames;
            if FilesReloadForm.ShowModal = mrOK then
                for I := 0 to FilesReloadForm.lbModified.Count - 1 do
                    if FilesReloadForm.lbModified.Checked[I] then
                        ReloadEditor(FilesReloadForm.lbModified.Items[I]);

            //Then free the dialog and clean up
            ReloadFilenames.Clear;
            FilesReloadForm.Free;
            FilesReloadForm := nil;
        end;
    end;
end;

procedure TMainForm.actFilePropertiesExecute(Sender: TObject);
begin
    with TFilePropertiesForm.Create(Self) do
    begin
        if TAction(Sender).ActionComponent = mnuUnitProperties then
            if Assigned(fProject) and
                Assigned(ProjectView.Selected) and
                (ProjectView.Selected.Data <> Pointer(-1)) then
                SetFile(fProject.Units[integer(ProjectView.Selected.Data)].FileName);
        ShowModal;
    end;
end;

procedure TMainForm.actViewToDoListUpdate(Sender: TObject);
begin
    ToDoList1.Checked := GetFormVisible(frmReportDocks[5]);
end;

procedure TMainForm.actViewToDoListExecute(Sender: TObject);
begin
    with ToDolist1 do
        if Checked then
            HideDockForm(frmReportDocks[5])
        else
            ShowDockForm(frmReportDocks[5]);
end;

procedure TMainForm.actAddToDoExecute(Sender: TObject);
begin
    with TAddToDoForm.Create(Self) do
        try
            ShowModal;
            RefreshTodoList;
        finally
            Free;
        end;
end;

procedure TMainForm.actProjectNewFolderExecute(Sender: TObject);
var
    fp, S: string;
begin
    S := 'New folder';
    if InputQuery(Lang[ID_POP_ADDFOLDER], Lang[ID_MSG_ADDBROWSERFOLDER], S) and
        (S <> '') then
    begin
        fp := fProject.GetFolderPath(ProjectView.Selected);
        if fp <> '' then
            fProject.AddFolder(fp + '/' + S)
        else
            fProject.AddFolder(S);
    end;
end;

procedure TMainForm.actProjectRemoveFolderExecute(Sender: TObject);
var
    node: TTreeNode;
begin
    if not Assigned(fProject) then
        Exit;

    if Assigned(ProjectView.Selected) and
        (ProjectView.Selected.Data = Pointer(-1)) then
        if MessageDlg(Lang[ID_MSG_REMOVEBROWSERFOLDER], mtConfirmation,
            [mbYes, mbNo], 0) = mrYes then
        begin
            ProjectView.Items.BeginUpdate;
            node := ProjectView.Selected;
            if assigned(node) and (node.Data = Pointer(-1)) and
                (node.Level >= 1) then
                fProject.RemoveFolder(fProject.GetFolderPath(node));
            ProjectView.TopItem.AlphaSort(False);
            ProjectView.Selected.Delete;
            ProjectView.Items.EndUpdate;
            fProject.UpdateFolders;
        end;
end;

procedure TMainForm.actProjectRenameFolderExecute(Sender: TObject);
var
    S: string;
begin
    if Assigned(ProjectView.Selected) and
        (ProjectView.Selected.Data = Pointer(-1)) then
    begin
        S := ProjectView.Selected.Text;
        if InputQuery(Lang[ID_POP_RENAMEFOLDER],
            Lang[ID_MSG_RENAMEBROWSERFOLDER],
            S) and (S <> '') then
        begin
            ProjectView.Selected.Text := S;
            fProject.UpdateFolders;
        end;
    end;
end;

procedure TMainForm.ProjectViewDragOver(Sender, Source: TObject; X,
    Y: Integer; State: TDragState; var Accept: Boolean);
var
    Item: TTreeNode;
    Hits: THitTests;
begin
    Hits := ProjectView.GetHitTestInfoAt(X, Y);
    if ([htOnItem, htOnRight, htToRight] * Hits) <> [] then
        Item := ProjectView.GetNodeAt(X, Y)
    else
        Item := nil;
    Accept :=
        (
        (Sender = ProjectView) and Assigned(ProjectView.Selected) and
        Assigned(Item)  //and
        // drop node is a folder or the project
        and ((Item.Data = Pointer(-1)) or (Item.SelectedIndex = 0))
        );
end;

procedure TMainForm.ProjectViewDragDrop(Sender, Source: TObject; X,
    Y: Integer);
var
    Item: TTreeNode;
    srcNode: TTreeNode;
    WasExpanded: Boolean;
    I: integer;
begin
    if not (Source is TTreeView) then
        exit;
    if ([htOnItem, htOnRight, htToRight] *
        ProjectView.GetHitTestInfoAt(X, Y)) <> [] then
        Item := ProjectView.GetNodeAt(X, Y)
    else
        Item := nil;
    for I := 0 to ProjectView.SelectionCount - 1 do
    begin
        srcNode := ProjectView.Selections[I];
        if not Assigned(Item) then
        begin
            fProject.Units[Integer(srcNode.Data)].Folder := '';
            srcNode.MoveTo(ProjectView.Items[0], naAddChild);
        end
        else
        begin
            if srcNode.Data <> Pointer(-1) then
            begin
                if Item.Data = Pointer(-1) then
                    fProject.Units[Integer(srcNode.Data)].Folder :=
                        fProject.GetFolderPath(Item)
                else
                    fProject.Units[Integer(srcNode.Data)].Folder := '';
            end;
            WasExpanded := Item.Expanded;
            ProjectView.Items.BeginUpdate;
            srcNode.MoveTo(Item, naAddChild);
            if not WasExpanded then
            begin
                Item.Collapse(False);
            end;
            Item.AlphaSort(False);
            ProjectView.Items.EndUpdate;

            fProject.UpdateFolders;
        end;
    end;
end;

procedure TMainForm.actImportMSVCExecute(Sender: TObject);
begin
    with TImportMSVCForm.Create(Self) do
    begin
        if ShowModal = mrOK then
            OpenProject(GetFilename);
    end;
end;

procedure TMainForm.AddWatchPopupItemClick(Sender: TObject);
var  s: string;
    e: TEditor;
begin
    e := GetEditor;
    s := e.Text.GetWordAtRowCol(e.Text.CaretXY);
    if s <> '' then
        AddDebugVar(s, wbWrite);
end;

// RNC -- 07-02-2004
// I changed the way the run to cursor works to make it more compatible with
// MSVC++.
// Run to cursor no longer sets a breakpoint.  It will try to run to the wherever the
// cusor is.  If there happens to be a breakpoint before that, the debugging stops there
// and the run to cursor value is removed.  (it will not stop there if you press continue)
procedure TMainForm.actRunToCursorExecute(Sender: TObject);
var
    e: TEditor;
    line: integer;
begin
    e := GetEditor;
    line := e.Text.CaretY;
    // If the debugger is not running, set the breakpoint to the current line and
    // start the debugger
    if not fDebugger.Executing then
    begin
        e.RunToCursor(line);
        actDebug.Execute;
    end

    // Otherwise, make sure that the debugger is stopped so that breakpoints can
    // be added. Also ensure that the cursor is not on a line that is already marked
    // as a breakpoint
    else
    if fDebugger.Paused and
        (not fDebugger.BreakpointExists(e.Filename, line)) then
        if assigned(e) then
            e.RunToCursor(line);

    // If we are broken and the run to cursor location is the same as the current
    // breakpoint, just continue to try to run to the current location
    if fDebugger.Paused then
        fDebugger.Go;
end;

procedure TMainForm.btnSendCommandClick(Sender: TObject);
begin
    if fDebugger.Executing then
    begin
        fDebugger.QueueCommand(edCommand.Text, '');
        edCommand.Clear;
    end;
end;

procedure TMainForm.ViewCPUItemClick(Sender: TObject);
begin
    if (not fDebugger.Executing) or (not fDebugger.Paused) then
        Exit;

    CPUForm := TCPUForm.Create(self);
    CPUForm.Show;
    CPUForm.PopulateRegisters(fDebugger);
end;

procedure TMainForm.edCommandKeyPress(Sender: TObject; var Key: Char);
begin
    if key = #13 then
        btnSendCommand.Click;
end;

procedure TMainForm.CheckForDLLProfiling;
var
    opts: TProjProfile;
    opt: TCompilerOption;
    idx: integer;
begin
    if not Assigned(fProject) then
        Exit;

    // profiling not enabled
    if not devCompiler.FindOption('-pg', opt, idx) then
        Exit;

    opts := TProjProfile.Create;

    if (fProject.CurrentProfile.typ in [dptDyn, dptStat]) and
        (opt.optValue > 0) then
    begin
        // project is a lib or a dll, and profiling is enabled
        // check for the existence of "-lgmon" in project's linker options
        if AnsiPos('-lgmon', fProject.CurrentProfile.Linker) = 0 then
            // does not have -lgmon
            // warn the user that we should update its project options and include
            // -lgmon in linker options, or else the compilation will fail
            if MessageDlg(
                'You have profiling enabled in Compiler Options and you are '
                +
                'working on a dynamic or static library. Do you want to add a special '
                +
                'linker option in your project to allow compilation with profiling enabled? '
                +
                'If you choose No, and you do not disable profiling from the Compiler Options '
                +
                'chances are that your library''s compilation will fail...',
                mtConfirmation,
                [mbYes, mbNo], 0) = mrYes then
            begin
                opts.CopyProfileFrom(fProject.CurrentProfile);
                opts.Linker := fProject.CurrentProfile.Linker + ' -lgmon';
                fProject.CurrentProfile.CopyProfileFrom(opts);
                fProject.Modified := True;
            end;
    end;
end;

procedure TMainForm.actExecParamsExecute(Sender: TObject);
begin
    ParamsForm := TParamsForm.Create(self);
    try
        ParamsForm.ParamEdit.Text := fCompiler.RunParams;
        if Assigned(fProject) then
            ParamsForm.HostEdit.Text :=
                fProject.CurrentProfile.HostApplication;
        if (not Assigned(fProject)) or
            (fProject.CurrentProfile.typ <> dptDyn) then
            ParamsForm.DisableHost;
        if (ParamsForm.ShowModal = mrOk) then
        begin
            fCompiler.RunParams := ParamsForm.ParamEdit.Text;
            if (ParamsForm.HostEdit.Enabled) then
                fProject.SetHostApplication(ParamsForm.HostEdit.Text);
        end;
    finally
        ParamsForm.Free;
    end;
end;

procedure TMainForm.actExecParamsUpdate(Sender: TObject);
begin
    (Sender as TCustomAction).Enabled :=
        assigned(fProject) and not devExecutor.Running and not
        fDebugger.Executing and not fCompiler.Compiling;
end;

procedure TMainForm.DevCppDDEServerExecuteMacro(Sender: TObject;
    Msg: TStrings);
var
    filename: string;
    i, n: Integer;
{$IFDEF PLUGIN_BUILD}
    j: Integer;
{$ENDIF}
begin
    if Msg.Count > 0 then
    begin
        for i := 0 to Msg.Count - 1 do
        begin
            filename := Msg[i];
            if Pos('[Open(', filename) = 1 then
            begin
                n := Pos('"', filename);
                if n > 0 then
                begin
                    Delete(filename, 1, n);
                    n := Pos('"', filename);
                    if n > 0 then
                        Delete(filename, n, maxint);
                    try
                        begin
              {$IFDEF PLUGIN_BUILD}
                            for j := 0 to pluginsCount - 1 do
    			                         plugins[j].OpenFile(filename);
              {$ENDIF}
                            OpenFile(filename);
                        end;
                    except
                    end;
                end;
            end;
        end;
        Application.BringToFront;
    end;
end;

procedure TMainForm.actShowTipsExecute(Sender: TObject);
begin
    with TTipOfTheDayForm.Create(Self) do
    begin
        chkNotAgain.Checked := not devData.ShowTipsOnStart;
        Current := devData.LastTip;
        ShowModal;
        devData.LastTip := Current + 1;
        devData.ShowTipsOnStart := not chkNotAgain.Checked;
    end;
end;

procedure TMainForm.actBrowserUseColorsExecute(Sender: TObject);
begin
    actBrowserUseColors.Checked := not actBrowserUseColors.Checked;
    devClassBrowsing.UseColors := actBrowserUseColors.Checked;
    ClassBrowser1.UseColors := actBrowserUseColors.Checked;
    ClassBrowser1.Refresh;
end;

procedure TMainForm.HelpMenuItemClick(Sender: TObject);
begin
    Application.HelpFile := IncludeTrailingBackslash(devDirs.Help) +
        DEV_MAINHELP_FILE;
    WordToHelpKeyword;
end;

procedure TMainForm.WordToHelpKeyword;
var
    tmp: string;
    e: TEditor;
begin
    e := GetEditor;
    if Assigned(e) then
    begin
        tmp := e.GetWordAtCursor;

        if (tmp <> '') then
        begin
            HelpWindow := HtmlHelp(self.handle, PChar(Application.HelpFile),
                HH_DISPLAY_INDEX, DWORD(PChar(tmp)));
        end
        else
        begin
            tmp := e.Text.SelText;
            if (tmp <> '') then
                HelpWindow :=
                    HtmlHelp(self.handle, PChar(Application.HelpFile),
                    HH_DISPLAY_INDEX, DWORD(PChar(tmp)))
            else
                HelpWindow :=
                    HtmlHelp(self.handle, PChar(Application.HelpFile),
                    HH_DISPLAY_TOPIC, 0);
        end;
    end
    else
        HelpWindow := HtmlHelp(self.handle, PChar(Application.HelpFile),
            HH_DISPLAY_TOPIC, 0);
end;

procedure TMainForm.CppParser1StartParsing(Sender: TObject);
begin
    StatusBar.Panels[3].Text := 'Please wait: Parsing in progress...';
    Screen.Cursor := crHourglass;
    if not bProjectLoading then
        alMain.State := asSuspended;
end;

procedure TMainForm.CppParser1EndParsing(Sender: TObject);
begin
    if not bProjectLoading then
        alMain.State := asNormal;
    Screen.Cursor := crDefault;
    StatusBar.Panels[3].Text := 'Ready.';

    // rebuild classes toolbar only if this was the last file scanned
    if CppParser1.FilesToScan.Count = 0 then
        RebuildClassesToolbar;
end;

procedure TMainForm.UpdateAppTitle;
var
    ii: integer;
    editorName: String;
begin
    editorName := self.GetActiveEditorName;
    if Assigned(fProject) then
    begin
        if (editorName = '') then
            Caption := Format('%s  - [ %s ]', [DEVCPP, fProject.Name])
        else
            Caption := Format('%s  - [ %s ] - %s',
                [DEVCPP, fProject.Name, editorName]);
        Application.Title := Format('%s [%s]', [DEVCPP, fProject.Name]);
        //ExtractFilename(fProject.Filename)]);
    end
    else
    begin
        if (editorName = '') then
            Caption := Format('%s', [DEVCPP])
        else
            Caption := Format('%s  - [ %s ]', [DEVCPP, editorName]);
        Application.Title := Format('%s', [DEVCPP]);
    end;

    // Clear status bar text
    for ii := 0 to (StatusBar.Panels.Count - 1) do
        StatusBar.Panels[ii].Text := '';

end;

procedure TMainForm.PackageManagerItemClick(Sender: TObject);
var s: string;
begin
    s := IncludeTrailingBackslash(devDirs.Exec) + PACKMAN_PROGRAM;
    ExecuteFile(s, '', IncludeTrailingBackslash(devDirs.Exec), SW_SHOW)
end;

procedure TMainForm.actAbortCompilationUpdate(Sender: TObject);
begin
    TAction(Sender).Enabled := fCompiler.Compiling;
end;

procedure TMainForm.actAbortCompilationExecute(Sender: TObject);
begin
    fCompiler.AbortThread;
end;

procedure TMainForm.actWindowMenuExecute(Sender: TObject);
var Item: TMenuItem;
    E: TEditor;
    i: integer;
    Act: TAction;
begin
    while WindowMenu.Count > 8 do
    begin
        Item := WindowMenu.Items[7];
        WindowMenu.Remove(Item);
        Item.Destroy;
    end;
    for i := 0 to pred(PageControl.PageCount) do
    begin
        //Stop if we are doing more than 9 editors (Don't let the window menu grow too long)
        if (i >= 9) then
            Break;

        //Create a menu item and register it with XPMenu
        e := GetEditor(i);
        Item := TMenuItem.Create(self);
        XPMenu.InitComponent(Item);

        //Associate a menu action
        Act := TAction.Create(Item);
        Act.Name := 'dynactOpenEditorByTag';
        Act.Tag := i;
        Act.OnExecute := dynactOpenEditorByTagExecute;
        Item.Action := Act;

        //Set up the item caption
        if e.FileName = '' then
            Item.Caption := '&' + chr(49 + i) + ' Unnamed'
        else
            Item.Caption := '&' + chr(49 + i) + ' ' + e.FileName;
        if e.Modified then
            Item.Caption := Item.Caption + ' *';

        //And insert it into our menu
        WindowMenu.Insert(WindowMenu.Count - 1, Item);
    end;
end;

procedure TMainForm.RemoveItem(Node: TTreeNode);
begin
    if Assigned(Node) and (Node.Level >= 1) then
    begin
        if Node.Data = Pointer(-1) then
            actProjectRemoveFolderExecute(nil)
        else
            fProject.Remove(integer(Node.Data), true);
    end
end;

procedure TMainForm.ProjectViewChanging(Sender: TObject; Node: TTreeNode;
    var AllowChange: Boolean);
begin
    Node.MakeVisible;
end;

procedure TMainForm.dynactOpenEditorByTagExecute(Sender: TObject);
var E: TEditor;
begin
    E := GetEditor(TAction(Sender).Tag);
    if E <> nil then
        E.Activate;
end;

procedure TMainForm.actGotoProjectManagerExecute(Sender: TObject);
begin
    LeftPageControl.ActivePageIndex := 0;
    ShowDockForm(frmProjMgrDock);
end;

procedure TMainForm.actCVSImportExecute(Sender: TObject);
begin
    DoCVSAction(Sender, caImport);
end;

procedure TMainForm.actCVSCheckoutExecute(Sender: TObject);
begin
    DoCVSAction(Sender, caCheckout);
end;

procedure TMainForm.actCVSUpdateExecute(Sender: TObject);
var
    I: integer;
    e: TEditor;
    pt: TBufferCoord;
begin
    actSaveAll.Execute;
    DoCVSAction(Sender, caUpdate);

    // Refresh CVS Changes
    for I := 0 to PageControl.PageCount - 1 do
    begin
        e := GetEditor(I);
        if Assigned(e) and FileExists(e.FileName) then
        begin
            pt := e.Text.CaretXY;
            e.Text.Lines.LoadFromFile(e.FileName);
            e.Text.CaretXY := pt;
        end;
    end;
end;

procedure TMainForm.actCVSCommitExecute(Sender: TObject);
begin
    DoCVSAction(Sender, caCommit);
end;

procedure TMainForm.actCVSDiffExecute(Sender: TObject);
begin
    DoCVSAction(Sender, caDiff);
end;

procedure TMainForm.actCVSLogExecute(Sender: TObject);
begin
    DoCVSAction(Sender, caLog);
end;

procedure TMainForm.actCVSAddExecute(Sender: TObject);
begin
    DoCVSAction(Sender, caAdd);
end;

procedure TMainForm.actCVSRemoveExecute(Sender: TObject);
begin
    DoCVSAction(Sender, caRemove);
end;

procedure TMainForm.actCVSLoginExecute(Sender: TObject);
begin
    DoCVSAction(Sender, caLogin);
end;

procedure TMainForm.actCVSLogoutExecute(Sender: TObject);
begin
    DoCVSAction(Sender, caLogout);
end;

procedure TMainForm.DoCVSAction(Sender: TObject; whichAction: TCVSAction);
var
    e: TEditor;
    idx: integer;
    all: string;
    S: string;
begin
    S := '';
    if not FileExists(devCVSHandler.Executable) then
    begin
        MessageDlg(Lang[ID_MSG_CVSNOTCONFIGED], mtWarning, [mbOk], 0);
        Exit;
    end;
    e := GetEditor;
    if TAction(Sender).ActionComponent.Tag = 1 then // project popup
        S := IncludeQuoteIfSpaces(fProject.FileName)
    else
    if TAction(Sender).ActionComponent.Tag = 2 then
    begin // unit popup
        S := '';
        if ProjectView.Selected.Data = Pointer(-1) then
        begin // folder
            for idx := 0 to fProject.Units.Count - 1 do
                if AnsiStartsStr(fProject.GetFolderPath(ProjectView.Selected),
                    fProject.Units[idx].Folder) then
                    S := S + IncludeQuoteIfSpaces(
                        fProject.Units[idx].FileName) + ',';
            if S = '' then
                S := 'ERR';
        end
        else
            S := IncludeQuoteIfSpaces(
                fProject.Units[Integer(ProjectView.Selected.Data)].FileName);
    end
    else
    if TAction(Sender).ActionComponent.Tag = 3 then
        // editor popup or [CVS menu - current file]
        S := IncludeQuoteIfSpaces(e.FileName)
    else
    if TAction(Sender).ActionComponent.Tag = 4 then
    begin // CVS menu - whole project
        if Assigned(fProject) then
            S := ExtractFilePath(fProject.FileName)
        else
        begin
            if Assigned(e) then
                S := ExtractFilePath(e.FileName)
            else
                S := ExtractFilePath(devDirs.Default);
        end;
        S := IncludeQuoteIfSpaces(S);
    end;

    if not Assigned(fProject) then
        all := IncludeQuoteIfSpaces(S)
    else
    begin
        all := IncludeQuoteIfSpaces(fProject.FileName) + ',';
        for idx := 0 to fProject.Units.Count - 1 do
            all := all + IncludeQuoteIfSpaces(
                fProject.Units[idx].FileName) + ',';
        Delete(all, Length(all), 1);
    end;

    with TCVSForm.Create(Self) do
    begin
        CVSAction := whichAction;
        Files.CommaText := S;
        AllFiles.CommaText := all;
        ShowModal;
    end;
end;

procedure TMainForm.ListItemClick(Sender: TObject);
var w: TWindowListForm;
    i: integer;
begin
    w := TWindowListForm.Create(self);
    try
        for i := 0 to PageControl.PageCount - 1 do
            w.UnitList.Items.Add(PageControl.Pages[i].Caption);
        if (w.ShowModal = mrOk) and (w.UnitList.ItemIndex > -1) then
        begin
            PageControl.ActivePageIndex := w.UnitList.ItemIndex;
        end;
    finally
        w.Free;
    end;
end;

procedure TMainForm.ProjectViewCompare(Sender: TObject; Node1,
    Node2: TTreeNode; Data: Integer; var Compare: Integer);
begin
    if (Node1.Data = pointer(-1)) and (Node2.Data = pointer(-1)) then
        Compare := AnsiCompareStr(Node1.Text, Node2.Text)
    else
    if Node1.Data = pointer(-1) then
        Compare := -1
    else
    if Node2.Data = pointer(-1) then
        Compare := +1
    else
        Compare := AnsiCompareStr(Node1.Text, Node2.Text);
end;

procedure TMainForm.ProjectViewKeyPress(Sender: TObject; var Key: Char);
begin
    // fixs an annoying bug/behavior of the tree ctrl (a beep on enter key)
    if Key = #13 then
        Key := #0;
end;

procedure TMainForm.ProjectViewMouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    // bug-fix: when *not* clicking on an item, re-opens the last clicked file-node
    // this was introduced in the latest commit by XXXKF (?)
    if (Button = mbLeft) and not
        (htOnItem in ProjectView.GetHitTestInfoAt(X, Y)) then
        ProjectView.Selected := nil;
end;

procedure TMainForm.GoToClassBrowserItemClick(Sender: TObject);
begin
    LeftPageControl.ActivePageIndex := 1;
    ShowDockForm(frmProjMgrDock);
end;

procedure TMainForm.actBrowserShowInheritedExecute(Sender: TObject);
begin
    actBrowserShowInherited.Checked := not actBrowserShowInherited.Checked;
    devClassBrowsing.ShowInheritedMembers := actBrowserShowInherited.Checked;
    ClassBrowser1.ShowInheritedMembers := actBrowserShowInherited.Checked;
    ClassBrowser1.Refresh;
end;

procedure TMainForm.OnHelpSearchWord(sender: TObject);
var
    idx: integer;
    aFile: string;
begin
    idx := (Sender as TMenuItem).Tag;
    if idx >= fHelpFiles.Count then
        exit;
    aFile := fHelpFiles.Values[idx];
  {if AnsiCompareFileName(ExtractFileExt(aFile), '.chm') = 0 then begin
    ExecuteFile(aFile, '', devDirs.Help, SW_SHOW);
    exit;
  end;
  if AnsiPos(HTTP, aFile) = 1 then
    ExecuteFile(aFile, '', devDirs.Help, SW_SHOW)
  else begin }
    Application.HelpFile := aFile;
    // moving this to WordToHelpKeyword
    // it's annoying to display the index when the topic has been found and is already displayed...
    //    Application.HelpCommand(HELP_FINDER, 0);
    WordToHelpKeyword;
    //end;
end;

procedure TMainForm.AddWatchBtnClick(Sender: TObject);
var
    e: TEditor;
    when: TWatchBreakOn;
begin
    e := GetEditor;
    if not Assigned(e) then
        Exit;

    with TModifyVarForm.Create(Self) do
        try
            NameEdit.Text := e.GetWordAtCursor;
            ValueLabel.Enabled := False;
            ValueEdit.Enabled := False;
            if ShowModal = mrOK then
            begin
                if chkStopOnWrite.Checked then
                    if chkStopOnRead.Checked then
                        when := wbBoth
                    else
                        when := wbWrite
                else
                    when := wbRead;

                if Trim(NameEdit.Text) <> '' then
                    AddDebugVar(NameEdit.Text, when);
            end;
        finally
            Free;
        end;
end;

// TODO: Looks like setting the sender to nil (as done in some places in the code) generates an error.
procedure TMainForm.ShowProjectInspItemClick(Sender: TObject);
begin
    TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
    if TMenuItem(Sender).Checked then
        ShowDockForm(frmProjMgrDock)
    else
        HideDockForm(frmProjMgrDock);
end;

procedure TMainForm.CompilerMessagesPanelItemClick(Sender: TObject);
begin
    TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
    if TMenuItem(Sender).Checked then
        ShowDockForm(frmReportDocks[0])
    else
        HideDockForm(frmReportDocks[0]);
end;


procedure TMainForm.ResourcesMessagesPanelItemClick(Sender: TObject);
begin
    TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
    if TMenuItem(Sender).Checked then
        ShowDockForm(frmReportDocks[1])
    else
        HideDockForm(frmReportDocks[1]);
end;

procedure TMainForm.CompileLogMessagesPanelItemClick(Sender: TObject);
begin
    TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
    if TMenuItem(Sender).Checked then
        ShowDockForm(frmReportDocks[2])
    else
        HideDockForm(frmReportDocks[2]);
end;

procedure TMainForm.DebuggingMessagesPanelItemClick(Sender: TObject);
begin
    TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
    if TMenuItem(Sender).Checked then
        ShowDockForm(frmReportDocks[3])
    else
        HideDockForm(frmReportDocks[3]);
end;

procedure TMainForm.FindResultsMessagesPanelItemClick(Sender: TObject);
begin
    TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
    if TMenuItem(Sender).Checked then
        ShowDockForm(frmReportDocks[4])
    else
        HideDockForm(frmReportDocks[4]);
end;

procedure TMainForm.ToDoListMessagesPanelItemClick(Sender: TObject);
begin
    TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
    if TMenuItem(Sender).Checked then
        ShowDockForm(frmReportDocks[5])
    else
        HideDockForm(frmReportDocks[5]);
end;

procedure TMainForm.SetProjCompOpt(idx: integer; Value: boolean);
var
    projOpt: TProjProfile;
begin
    if not Assigned(fProject) then
        Exit;

    //Copy the profile and make sure the compiler options string length is long enough
    //for us to include the change
    projOpt := TProjProfile.Create;
    projOpt.CopyProfileFrom(fProject.CurrentProfile);
    while Length(projOpt.CompilerOptions) <= idx do
        projOpt.CompilerOptions := projOpt.CompilerOptions + '0';

    //Set the 'bit' of the options
    if Value then
        projOpt.CompilerOptions[idx + 1] := '1'
    else
        projOpt.CompilerOptions[idx + 1] := '0';

    //Then assign the profile back to the project
    fProject.CurrentProfile.CopyProfileFrom(projOpt);
    devCompiler.OptionStr := fProject.CurrentProfile.CompilerOptions;
    projOpt.Destroy;
end;

procedure TMainForm.SetupProjectView;
begin
    if devData.DblFiles then
    begin
        ProjectView.HotTrack := False;
        ProjectView.MultiSelect := True;
    end
    else
    begin
        ProjectView.HotTrack := True;
        ProjectView.MultiSelect := False;
    end;
end;

procedure TMainForm.actCompileCurrentFileExecute(Sender: TObject);
var
    e: TEditor;
begin
    if fCompiler.Compiling then
    begin
        MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
        Exit;
    end;

    e := GetEditor;
    if not Assigned(e) then
        Exit;
    if not PrepareForCompile(false) then
        Exit;
    fCompiler.Compile(e.FileName);
    Application.ProcessMessages;
end;

procedure TMainForm.actCompileCurrentFileUpdate(Sender: TObject);
begin
    (Sender as TCustomAction).Enabled :=
        (assigned(fProject) and (PageControl.PageCount > 0)) and
        not devExecutor.Running and not fDebugger.Executing and
        not fCompiler.Compiling;
end;

procedure TMainForm.actSaveProjectAsExecute(Sender: TObject);
begin
    if not Assigned(fProject) then
        Exit;
    with dmMain.SaveDialog do
    begin
        Filter := FLT_PROJECTS;
        if Execute then
        begin
            fProject.FileName := FileName;
            fProject.Save;
            UpdateAppTitle;
        end;
    end;
end;

procedure TMainForm.BuildOpenWith;
var
    idx, idx2: integer;
    item: TMenuItem;
    ext, s, s1: string;
begin
    mnuOpenWith.Clear;
    if not assigned(fProject) then
        exit;
    if not assigned(ProjectView.Selected) or
        (ProjectView.Selected.Level < 1) then
        exit;
    if ProjectView.Selected.Data = Pointer(-1) then
        Exit;
    idx := integer(ProjectView.Selected.Data);

    ext := ExtractFileExt(fProject.Units[idx].FileName);
    idx2 := devExternalPrograms.AssignedProgram(ext);
    if idx2 <> -1 then
    begin
        item := TMenuItem.Create(nil);
        item.Caption := ExtractFilename(devExternalPrograms.ProgramName[idx2]);
        item.Tag := idx2;
        item.OnClick := mnuOpenWithClick;
        mnuOpenWith.Add(item);
    end;
    if GetAssociatedProgram(ext, s, s1) then
    begin
        item := TMenuItem.Create(nil);
        item.Caption := '-';
        item.Tag := -1;
        item.OnClick := mnuOpenWithClick;
        mnuOpenWith.Add(item);
        item := TMenuItem.Create(nil);
        item.Caption := s1;
        item.Tag := -1;
        item.OnClick := mnuOpenWithClick;
        mnuOpenWith.Add(item);
    end;
end;

function TMainForm.OpenWithAssignedProgram(strFileName: String): boolean;
var
    idx2, idx3: integer;
begin
    Result := false;

    if not Assigned(fProject) then
        Exit;
    if not assigned(ProjectView.Selected) or
        (ProjectView.Selected.Level < 1) then
        exit;
    if ProjectView.Selected.Data = Pointer(-1) then
        Exit;
    idx2 := integer(ProjectView.Selected.Data);
    idx3 := devExternalPrograms.AssignedProgram(
        ExtractFileExt(fProject.Units[idx2].FileName));
    if idx3 = -1 then
    begin
        exit;
    end;
    ShellExecute(0, 'open',
        PChar(devExternalPrograms.ProgramName[idx3]),
        PChar(fProject.Units[idx2].FileName),
        PChar(ExtractFilePath(fProject.Units[idx2].FileName)),
        SW_SHOW);

    Result := true;

end;

procedure TMainForm.mnuOpenWithClick(Sender: TObject);
var
    idx, idx2, idx3: integer;
    item: TMenuItem;
begin
    if (Sender = mnuOpenWith) and (mnuOpenWith.Count > 0) then
        Exit;
    if not Assigned(fProject) then
        Exit;
    if not assigned(ProjectView.Selected) or
        (ProjectView.Selected.Level < 1) then
        exit;
    if ProjectView.Selected.Data = Pointer(-1) then
        Exit;
    idx2 := integer(ProjectView.Selected.Data);

    item := Sender as TMenuItem;
    if item = mnuOpenWith then
    begin
        idx := -2;
        with dmMain.OpenDialog do
        begin
            Filter := FLT_ALLFILES;
            if Execute then
                idx := devExternalPrograms.AddProgram(
                    ExtractFileExt(fProject.Units[idx2].FileName), Filename);
        end;
    end
    else
        idx := item.Tag;
    idx3 := FileIsOpen(fProject.Units[idx2].FileName, TRUE);
    if idx3 > -1 then
        CloseEditor(idx3, True);

    if idx > -1 then // devcpp-based
        ShellExecute(0, 'open',
            PChar(devExternalPrograms.ProgramName[idx]),
            PChar(fProject.Units[idx2].FileName),
            PChar(ExtractFilePath(fProject.Units[idx2].FileName)),
            SW_SHOW)
    // idx=-2 means we prompted the user for a program, but didn't select one
    else
    if idx <> -2 then // registry-based
        ShellExecute(0, 'open',
            PChar(fProject.Units[idx2].FileName),
            nil,
            PChar(ExtractFilePath(fProject.Units[idx2].FileName)),
            SW_SHOW);
end;

procedure TMainForm.RebuildClassesToolbar;
var
    I: integer;
    st: PStatement;
    S: string;
begin
    S := cmbClasses.Text;
    cmbClasses.Clear;
    cmbMembers.Clear;
    cmbClasses.Items.Add('(globals)');

    for I := 0 to CppParser1.Statements.Count - 1 do
    begin
        st := PStatement(CppParser1.Statements[I]);
        if st^._InProject and (st^._Kind in [skClass, skTypedef]) then
            cmbClasses.Items.AddObject(st^._ScopelessCmd, Pointer(I));
    end;
    if S <> '' then
    begin
        cmbClasses.ItemIndex := cmbClasses.Items.IndexOf(S);
        cmbClassesChange(cmbClasses);
    end;
end;

procedure TMainForm.cmbClassesChange(Sender: TObject);
var
    I, idx: integer;
    st: PStatement;
begin
    cmbMembers.Clear;
    if cmbClasses.ItemIndex = -1 then
        Exit;

    I := Integer(cmbClasses.Items.Objects[cmbClasses.ItemIndex]);
    if (I < 0) or (I > CppParser1.Statements.Count - 1) then
        Exit;

    if cmbClasses.ItemIndex > 0 then
        idx := PStatement(CppParser1.Statements[I])^._ID
    else
        idx := -1;

    for I := 0 to CppParser1.Statements.Count - 1 do
    begin
        st := PStatement(CppParser1.Statements[I]);
        if (st^._ParentID = idx) and st^._InProject and
            (st^._Kind in [skFunction, skConstructor, skDestructor]) then
            cmbMembers.Items.AddObject(st^._ScopelessCmd +
                st^._Args, Pointer(I));
    end;
end;

procedure TMainForm.cmbMembersChange(Sender: TObject);
var
    I: integer;
    st: PStatement;
    E: TEditor;
    fname: string;
begin
    if cmbMembers.ItemIndex = -1 then
        Exit;

    I := Integer(cmbMembers.Items.Objects[cmbMembers.ItemIndex]);
    if (I < 0) or (I > CppParser1.Statements.Count - 1) then
        Exit;

    st := PStatement(CppParser1.Statements[I]);
    if not Assigned(st) then
        Exit;

    if st^._IsDeclaration then
    begin
        I := st^._DeclImplLine;
        fname := st^._DeclImplFileName;
    end
    else
    begin
        I := st^._Line;
        fname := st^._FileName;
    end;

    E := GetEditorFromFilename(fname);
    if Assigned(E) then
        E.GotoLineNr(I);
end;

procedure TMainForm.CompilerOutputKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
{$IFDEF WIN32}
    if Key = VK_RETURN then
{$ENDIF}
{$IFDEF LINUX}
  if Key = XK_RETURN then
{$ENDIF}
        CompilerOutputDblClick(sender);
end;

procedure TMainForm.FindOutputKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
{$IFDEF WIN32}
    if Key = VK_RETURN then
{$ENDIF}
{$IFDEF LINUX}
  if Key = XK_RETURN then
{$ENDIF}
        FindOutputDblClick(sender);
end;

procedure TMainForm.DebugTreeKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
{$IFDEF WIN32}
    if Key = VK_DELETE then
{$ENDIF}
{$IFDEF LINUX}
  if Key = XK_DELETE then
{$ENDIF}
        actRemoveWatchExecute(sender);
end;

procedure TMainForm.DebugVarsPopupPopup(Sender: TObject);
begin
    RemoveWatchPop.Enabled := Assigned(WatchTree.Selected);
end;

procedure TMainForm.actAttachProcessUpdate(Sender: TObject);
begin
    if assigned(fProject) and (fProject.CurrentProfile.typ = dptDyn) then
    begin
        (Sender as TCustomAction).Visible := true;
        (Sender as TCustomAction).Enabled := not devExecutor.Running;
    end
    else
        (Sender as TCustomAction).Visible := false;
end;

procedure TMainForm.actAttachProcessExecute(Sender: TObject);
var
    idx: integer;
begin
    PrepareDebugger;
    if assigned(fProject) then
    begin
        if not FileExists(fProject.Executable) then
        begin
            MessageDlg(Lang[ID_ERR_PROJECTNOTCOMPILED], mtWarning, [mbOK], 0);
            exit;
        end;

        try
            ProcessListForm := TProcessListForm.Create(self);
            if (ProcessListForm.ShowModal = mrOK) and
                (ProcessListForm.ProcessCombo.ItemIndex > -1) then
            begin
                // add to the debugger the project include dirs
                for idx := 0 to fProject.CurrentProfile.Includes.Count - 1 do
                    fDebugger.AddIncludeDir(
                        fProject.CurrentProfile.Includes[idx]);

                fDebugger.Attach(Integer(
                    ProcessListForm.ProcessList[
                    ProcessListForm.ProcessCombo.ItemIndex]));
                fDebugger.RefreshBreakpoints;
                fDebugger.RefreshWatches;
                fDebugger.Go;
            end
        finally
            ProcessListForm.Free;
        end;
    end;
end;

procedure TMainForm.actModifyWatchExecute(Sender: TObject);
var
    val: string;
    i: integer;
    n: TTreeNode;
    Watch: PWatchPt;

begin
    if (not Assigned(WatchTree.Selected)) or (not fDebugger.Executing) then
        exit;
    Watch := MainForm.WatchTree.Selected.Data;

    //Create the variable edit dialog
    ModifyVarForm := TModifyVarForm.Create(self);
    try
        ModifyVarForm.NameEdit.Text := Watch.Name;
        ModifyVarForm.NameEdit.Enabled := False;
        ModifyVarForm.ValueEdit.Text := Watch.Value;

        ModifyVarForm.chkStopOnRead.Enabled := False;
        ModifyVarForm.chkStopOnWrite.Enabled := False;
        ModifyVarForm.chkStopOnRead.Checked := ((Watch.BPType = wbRead) or (Watch.BPType = wbBoth));
        ModifyVarForm.chkStopOnWrite.Checked := ((Watch.BPType = wbWrite) or (Watch.BPType = wbBoth));
        ModifyVarForm.ActiveWindow := ModifyVarForm.ValueEdit;
        if ModifyVarForm.ShowModal = mrOK then
        begin
            fDebugger.ModifyVariable(ModifyVarForm.NameEdit.Text,
                ModifyVarForm.ValueEdit.Text);
            fDebugger.RefreshContext;
        end;
    finally
        ModifyVarForm.Free;
    end;
end;

procedure TMainForm.ClearallWatchPopClick(Sender: TObject);
var
    node: TTreeNode;
begin
   
end;

procedure TMainForm.HideCodeToolTip;
var
    CurrentEditor: TEditor;
begin
    CurrentEditor := GetEditor(PageControl.ActivePageIndex);
    if Assigned(CurrentEditor) and Assigned(CurrentEditor.CodeToolTip) then
        CurrentEditor.CodeToolTip.ReleaseHandle;
end;

procedure TMainForm.ApplicationEvents1Deactivate(Sender: TObject);
begin
    //Hide the tooltip since we no longer have focus
    HideCodeToolTip;
    fIsIconized := True;
end;

procedure TMainForm.ApplicationEvents1Activate(Sender: TObject);
begin
    fIsIconized := False;
    HandleFileMonitorChanges;
end;

procedure TMainForm.PageControlChanging(Sender: TObject;
    var AllowChange: Boolean);
begin
    HideCodeToolTip;
end;

procedure TMainForm.mnuCVSClick(Sender: TObject);
begin
    mnuCVSCurrent.Enabled := PageControl.PageCount > 0;
end;


{$IFDEF PLUGIN_BUILD}
// Get the login name to use as a default if the author name is unknown
function GetLoginName: string;
var
    buffer: array[0..255] of char;
    size: dword;
begin
    size := 256;
    if GetUserName(buffer, size) then
        Result := buffer
    else
        Result := ''
end;

function TMainForm.isFunctionAvailable(intClassID: Integer;
    strFunctionName: String): boolean;
var
    i: Integer;
    St2: PStatement;
begin
    Result := False;

    for I := 0 to ClassBrowser1.Parser.Statements.Count - 1 do // Iterate
    begin

        St2 := PStatement(ClassBrowser1.Parser.Statements[i]);
        if St2._ParentID <> intClassID then
            Continue;

        if St2._Kind <> skFunction then
            Continue;

        if AnsiSameText(strFunctionName, St2._Command) then
        begin
            Result := True;
            Break;
        end;
    end; // for

end;

function TMainForm.GetFunctionsFromSource(classname: string; var strLstFuncs:
    TStringList): Boolean;
var
    //Statement: PStatement;
    i, intColon: Integer;
    strParserFunctionName, strParserClassName: string;

    //    _FullText: string;
    //    _Type: string;
    //    _Command: string;
    //    _Args: string;
    //    _MethodArgs: string;
    _ScopelessCmd: string;
    //    _ScopeCmd: string;
    //    _Kind: TStatementKind;
    //    _InheritsFromIDs: string; // list of inheriting IDs, in comma-separated string form
    //    _InheritsFromClasses: string; // list of inheriting class names, in comma-separated string form
    //    _Scope: TStatementScope;
    //    _ClassScope: TStatementClassScope;
    //    _IsDeclaration: boolean;
    //    _DeclImplLine: integer;
    //    _Line: integer;
    //    _DeclImplFileName: string;
    //    _FileName: string;
    //    _Visible: boolean;
    //    _NoCompletion: boolean;
    //    _Valid: boolean;
    //    _Temporary: boolean;
    //    _Loaded: boolean;
    //    _InProject: Boolean;
begin
    Result := False;
    classname := trim(classname);

    //CppParser1.GetClassesList(TStrings());
    for i := 0 to CppParser1.Statements.Count - 1 do
    begin
        if PStatement(CppParser1.Statements[i])._Kind = skFunction then
        begin
            strParserClassName :=
                PStatement(CppParser1.Statements[i])._ScopeCmd;
            intColon := Pos('::', strParserClassName);
            if intColon <> 0 then
            begin
                strParserClassName :=
                    Copy(strParserClassName, 0, intColon - 1);
            end
            else
                Continue;

            strParserFunctionName :=
                PStatement(CppParser1.Statements[i])._FullText;
            _ScopelessCmd :=
                PStatement(CppParser1.Statements[i])._ScopelessCmd;

            //                _FullText:=PStatement(CppParser1.Statements[i])._FullText;
            //                _Type:=PStatement(CppParser1.Statements[i])._Type;
            //                _Command:=PStatement(CppParser1.Statements[i])._Command;
            //                _Args:=PStatement(CppParser1.Statements[i])._Args;
            //                _MethodArgs:=PStatement(CppParser1.Statements[i])._MethodArgs;
            //                _ScopeCmd:=PStatement(CppParser1.Statements[i])._ScopeCmd;
            //                _Kind:=PStatement(CppParser1.Statements[i])._Kind;
            //                _InheritsFromIDs:=PStatement(CppParser1.Statements[i])._InheritsFromIDs;
            //                _InheritsFromClasses:=PStatement(CppParser1.Statements[i])._InheritsFromClasses;
            //                _Scope:=PStatement(CppParser1.Statements[i])._Scope;
            //                _ClassScope:=PStatement(CppParser1.Statements[i])._ClassScope;
            //                _IsDeclaration:=PStatement(CppParser1.Statements[i])._IsDeclaration;
            //                _DeclImplLine:=PStatement(CppParser1.Statements[i])._DeclImplLine;
            //                _Line:=PStatement(CppParser1.Statements[i])._Line;
            //                _DeclImplFileName:=PStatement(CppParser1.Statements[i])._DeclImplFileName;
            //                _FileName:=PStatement(CppParser1.Statements[i])._FileName;
            //                _Visible:=PStatement(CppParser1.Statements[i])._Visible;
            //                _NoCompletion:=PStatement(CppParser1.Statements[i])._NoCompletion;
            //                _Valid:=PStatement(CppParser1.Statements[i])._Valid;
            //                _Temporary:=PStatement(CppParser1.Statements[i])._Temporary;
            //                _Loaded:=PStatement(CppParser1.Statements[i])._Loaded;
            //                _InProject:=PStatement(CppParser1.Statements[i])._InProject;

            if AnsiSameText(strParserClassName, classname) then
            begin
                strLstFuncs.Add(_ScopelessCmd);
            end;
        end;
    end;
    Result := True;
end;
{$ENDIF}

function TMainForm.isFileOpenedinEditor(strFile: string): Boolean;
var
    I: Integer;
    e: TEditor;
begin
    Result := false;

    if Trim(strFile) = '' then
        Exit;

    for i := 0 to PageControl.PageCount - 1 do
    begin
        e := GetEditor(i);
        if Assigned(e) then
        begin
            if SameFileName(e.FileName, strFile) then
            begin
                Result := True;
                Exit;
            end;
        end;
    end;
end;

// EAB TODO: The following function may need to be revised in order to ensure plugin-neutral behavior 
procedure TMainForm.GetClassNameLocationsInEditorFiles(
    var HppStrLst, CppStrLst: TStringList;
    FileName, FromClassName, ToClassName: string);
var
    St: PStatement;
    i, intColon: Integer;
    strParserClassName: string;
    cppEditor, hppEditor: TEditor;
    cppFName, hppFName: string;
begin
    HppStrLst.clear;
    CppStrLst.clear;

    cppFName := ChangeFileExt(FileName, CPP_EXT);
    hppFName := ChangeFileExt(FileName, H_EXT);

    OpenFile(cppFName, true);
    OpenFile(hppFName, true);

    cppEditor := GetEditorFromFileName(cppFName);
    hppEditor := GetEditorFromFileName(hppFName);
    if not (Assigned(cppEditor) and Assigned(hppEditor)) then
        Exit;

    for I := 0 to ClassBrowser1.Parser.Statements.Count - 1 do // Iterate
    begin
        St := PStatement(ClassBrowser1.Parser.Statements[i]);

        if (St._Kind = skConstructor) or (St._Kind = skDestructor) then
        begin
            if AnsiSameText(FromClassName, St._Command) or
                AnsiSameText('~' + FromClassName, St._Command) then
            begin
                if strEqual(St._DeclImplFileName, cppFName) then
                    CppStrlst.Add(IntToStr(St._DeclImplLine - 1));

                if strEqual(St._DeclImplFileName, hppFName) then
                    HppStrlst.Add(IntToStr(St._DeclImplLine - 1));

                if strEqual(St._FileName, hppFName) then
                    HppStrlst.Add(IntToStr(St._Line - 1));

                if strEqual(St._FileName, cppFName) then
                    cppStrlst.Add(IntToStr(St._Line - 1));
            end;
        end
        else
        if St._Kind = skClass then
        begin
            if AnsiSameText(St._ScopeCmd, FromClassName) then
            begin
                if strEqual(St._DeclImplFileName, cppFName) then
                    CppStrlst.Add(IntToStr(St._DeclImplLine - 1));

                if strEqual(St._DeclImplFileName, hppFName) then
                    HppStrlst.Add(IntToStr(St._DeclImplLine - 1));

                if strEqual(St._FileName, hppFName) then
                    HppStrlst.Add(IntToStr(St._Line - 1));

                if strEqual(St._FileName, cppFName) then
                    cppStrlst.Add(IntToStr(St._Line - 1));
            end;
        end
        else
        if St._Kind = skFunction then
        begin
            strParserClassName := St._ScopeCmd;
            intColon := Pos('::', strParserClassName);
            if intColon <> 0 then
                strParserClassName := Copy(strParserClassName, 0, intColon - 1)
            else
                Continue;

            if not AnsiSameText(strParserClassName, FromClassName) then
                Continue;

            cppStrlst.Add(IntToStr(St._Line - 1));
            hppStrlst.Add(IntToStr(St._Line - 1));
            cppStrlst.Add(IntToStr(St._DeclImplLine - 1));
            hppStrlst.Add(IntToStr(St._DeclImplLine - 1));
        end;
    end; // for
end;

procedure TMainForm.ProjectViewKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    if (Key = VK_DELETE) and Assigned(ProjectView.Selected) then
        RemoveItem(ProjectView.Selected)
    else
    if Key = VK_ESCAPE then
    begin
        if PageControl.Visible and PageControl.Enabled and
            (PageControl.ActivePage <> nil) then
            GetEditor(-1).Activate;
    end
    else
    if (Key = VK_RETURN) and Assigned(ProjectView.Selected) then
    begin
        if ProjectView.Selected.Data <> Pointer(-1) then { if not a directory }
            OpenUnit;
    end;
end;

function TMainForm.BreakupTodo(Filename: string; sl: TStrings;
    Line: integer; Token: string; HasUser,
    HasPriority: boolean): integer;
var
    sUser: string;
    iPriority: integer;
    sDescription: string;
    Indent: integer;
    S: string;
    X, Y: integer;
    idx: integer;
    Done: boolean;
    MultiLine: boolean;
    td: PToDoRec;
    OrigLine: integer;
    TokenIndex: integer;
begin
    sUser := '';
    iPriority := 0;
    sDescription := '';

    OrigLine := Line;
    S := sl[Line];

    MultiLine := AnsiPos('//', S) = 0;
    idx := AnsiPos(Token, S);
    TokenIndex := idx;
    Inc(idx, 4); // skip "TODO"

    if HasUser or HasPriority then
        Inc(idx, 2); // skip " ("

    Delete(S, 1, idx - 1);
    if HasUser or HasPriority then
    begin
        idx := AnsiPos('#', S);
        sUser := Copy(S, 1, idx - 1); // got user
        iPriority := StrToIntDef(S[idx + 1], 1); // got priority
    end;

    Indent := AnsiPos(':', sl[Line]) + 1;
    idx := AnsiPos(':', S);
    Delete(S, 1, idx + 1);
    Done := False;
    Y := Line;
    while (Y < sl.Count) and not Done do
    begin
        X := Indent;
        while (X <= Length(sl[Y])) and not Done do
        begin
            if (sl[Y][X] = '*') and (X < Length(sl[Y])) and
                (sl[Y][X + 1] = '/') then
            begin
                Done := True;
                Break;
            end;
            sDescription := sDescription + sl[Y][X];
            Inc(X);
        end;
        if not MultiLine then
            Break;
        if not Done then
        begin
            sDescription := sDescription + #13#10;
            Inc(Line);
        end;
        Inc(Y);
    end;

    td := New(PToDoRec);
    td^.TokenIndex := TokenIndex;
    td^.Filename := Filename;
    td^.Line := OrigLine;
    td^.ToLine := Line;
    td^.User := sUser;
    td^.Priority := iPriority;
    td^.Description := sDescription;
    td^.IsDone := AnsiCompareText(Token, 'TODO') <> 0;
    fToDoList.Add(td);

    Result := Line;
end;

procedure TMainForm.AddTodoFiles(Current, InProject, NotInProject,
    OpenOnly: boolean);
    function MatchesMask(SearchStr, MaskStr: string): Boolean;
    var
        Matches: boolean;
        MaskIndex: integer;
        SearchIndex: integer;
        NextMatch: Char;
    begin
        Matches := True;
        MaskIndex := 1;
        SearchIndex := 1;

        if (MaskStr = '') or (SearchStr = '') then
            Matches := False;

        if AnsiPos('*?', MaskStr) > 0 then // illegal
            Matches := False;
        if AnsiPos('**', MaskStr) > 0 then // illegal
            Matches := False;

        while Matches do
        begin
            case MaskStr[MaskIndex] of
                '*':
                begin
                    if MaskIndex < Length(MaskStr) then
                        NextMatch := MaskStr[MaskIndex + 1]
                    else
                        NextMatch := #0;
                    while SearchIndex <= Length(SearchStr) do
                    begin
                        if SearchStr[SearchIndex] = NextMatch then
                        begin
                            Inc(SearchIndex);
                            Inc(MaskIndex, 2);
                            Break;
                        end;
                        Inc(SearchIndex);
                    end;
                    if (SearchIndex = Length(SearchStr)) and
                        (MaskIndex < Length(MaskStr)) then
                        Matches := False;
                end;
                '?':
                begin
                    Inc(SearchIndex);
                    Inc(MaskIndex);
                end;
            else
                if MaskStr[MaskIndex] <> SearchStr[SearchIndex] then
                    Matches := False
                else
                begin
                    Inc(MaskIndex);
                    Inc(SearchIndex);
                end;
            end;

            if MaskIndex > Length(MaskStr) then
                Break;
            if SearchIndex > Length(SearchStr) then
                Break;
        end;
        if (MaskIndex = Length(MaskStr)) and (MaskStr[MaskIndex] = '*') then
            MaskIndex := Length(MaskStr) + 1;

        Result := Matches and (MaskIndex > Length(MaskStr)) and
            (SearchIndex > Length(SearchStr));
    end;

    procedure AddToDo(Filename: string);
    var
        sl: TStrings;
        I: integer;
    begin
        sl := TStringList.Create;
        try
            for I := 0 to PageControl.PageCount - 1 do
                if TEditor(PageControl.Pages[I].Tag).FileName = Filename then
                    sl.Assign(TEditor(PageControl.Pages[I].Tag).Text.Lines)
                else
                if FileExists(Filename) then
                    sl.LoadFromFile(Filename);

            if sl.Count = 0 then
                if FileExists(Filename) then
                    sl.LoadFromFile(Filename);

            I := 0;
            while I < sl.Count do
            begin
                if MatchesMask(sl[I], '*/? TODO (?*#?#)*:*') then
                    BreakupToDo(Filename, sl, I, 'TODO', True, True)
                // full info TODO
                else
                if MatchesMask(sl[I], '*/? DONE (?*#?#)*:*') then
                    BreakupToDo(Filename, sl, I, 'DONE', True, True)
                // full info DONE
                else
                if MatchesMask(sl[I], '*/? TODO (#?#)*:*') then
                    BreakupToDo(Filename, sl, I, 'TODO', False, True)
                // only priority info TODO
                else
                if MatchesMask(sl[I], '*/? DONE (#?#)*:*') then
                    BreakupToDo(Filename, sl, I, 'DONE', False, True)
                // only priority info DONE
                else
                if MatchesMask(sl[I], '*/?*TODO*:*') then
                    BreakupToDo(Filename, sl, I, 'TODO', False, False)
                // custom TODO
                else
                if MatchesMask(sl[I], '*/?*DONE*:*') then
                    BreakupToDo(Filename, sl, I, 'DONE', False, False);
                // custom DONE
                Inc(I);
            end;
        finally
            sl.Free;
        end;
    end;
var
    e: TEditor;
    idx: integer;
begin
    if Current then
    begin
        e := GetEditor;
        if Assigned(e) then
            AddToDo(e.FileName);
        Exit;
    end;

    if InProject and not OpenOnly then
    begin
        if Assigned(fProject) then
            for idx := 0 to pred(fProject.Units.Count) do
                AddToDo(fProject.Units[idx].filename);
    end;

    if OpenOnly then
    begin
        for idx := 0 to pred(PageControl.PageCount) do
        begin
            e := GetEditor(idx);
            if Assigned(e) then
                if InProject and e.InProject then
                    AddToDo(e.FileName)
        end;
    end;

    if NotInProject then
    begin
        for idx := 0 to pred(PageControl.PageCount) do
        begin
            e := GetEditor(idx);
            if Assigned(e) then
                if not e.InProject then
                    AddToDo(e.FileName);
        end;
    end;
end;

procedure TMainForm.lvTodoCustomDrawItem(Sender: TCustomListView;
    Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
    if Assigned(Item.Data) then
    begin
        Item.Checked := PToDoRec(Item.Data)^.IsDone;
        if Item.Checked then
        begin
            Sender.Canvas.Font.Color := clGrayText;
            Sender.Canvas.Font.Style :=
                Sender.Canvas.Font.Style + [fsStrikeOut]
        end
        else
        begin
            Sender.Canvas.Font.Color := clWindowText;
            Sender.Canvas.Font.Style :=
                Sender.Canvas.Font.Style - [fsStrikeOut];
        end;
    end;
    DefaultDraw := True;
end;

procedure TMainForm.lvTodoMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
var
    e: TEditor;
    Item: TListItem;
begin
    if not (htOnStateIcon in lvTodo.GetHitTestInfoAt(X, Y)) then
        Exit;

    Item := lvTodo.GetItemAt(X, Y);
    if not Assigned(Item) then
        Exit;
    if not Assigned(Item.Data) then
        Exit;

    e := GetEditorFromFileName(PToDoRec(Item.Data)^.Filename);
    if Assigned(e) then
    begin
        PToDoRec(Item.Data)^.IsDone := Item.Checked;
        if Item.Checked then
        begin
            e.Text.Lines[PToDoRec(Item.Data)^.Line] :=
                StringReplace(e.Text.Lines[PToDoRec(Item.Data)^.Line],
                'TODO', 'DONE', []);
            if chkTodoIncomplete.Checked then
                BuildTodoList;
        end
        else
            e.Text.Lines[PToDoRec(Item.Data)^.Line] :=
                StringReplace(e.Text.Lines[PToDoRec(Item.Data)^.Line],
                'DONE', 'TODO', []);
        e.Modified := True;
        lvTodo.Refresh;
    end;
end;

procedure TMainForm.lvTodoColumnClick(Sender: TObject;
    Column: TListColumn);
begin
    fTodoSortColumn := Column.Index;
    TCustomListView(Sender).CustomSort(nil, 0);
end;

procedure TMainForm.lvTodoCompare(Sender: TObject; Item1, Item2: TListItem;
    Data: Integer; var Compare: Integer);
var
    idx: Integer;
begin
    if fTodoSortColumn = 0 then
    begin
        if PToDoRec(Item1.Data)^.IsDone and not
            PToDoRec(Item2.Data)^.IsDone then
            Compare := 1
        else
        if not PToDoRec(Item1.Data)^.IsDone and
            PToDoRec(Item2.Data)^.IsDone then
            Compare := -1
        else
            Compare := 0;
    end
    else
    begin
        idx := fTodoSortColumn - 1;
        Compare := AnsiCompareText(Item1.SubItems[idx], Item2.SubItems[idx]);
    end;
end;

procedure TMainForm.lvTodoDblClick(Sender: TObject);
var
    e: TEditor;
begin
    if not Assigned(lvTodo.Selected) then
        Exit;
    if not Assigned(lvTodo.Selected.Data) then
        Exit;

    e := GetEditorFromFilename(PToDoRec(lvTodo.Selected.Data)^.Filename);
    if Assigned(e) then
        e.GotoLineNr(PToDoRec(lvTodo.Selected.Data)^.Line + 1);
end;

procedure TMainForm.chkTodoIncompleteClick(Sender: TObject);
begin
    BuildTodoList;
end;

procedure TMainForm.BuildTodoList;
var
    I: integer;
    td: PToDoRec;
    S: string;
begin
    lvTodo.Items.BeginUpdate;
    lvTodo.Items.Clear;
    for I := 0 to fToDoList.Count - 1 do
    begin
        td := PToDoRec(fToDoList[I]);
        if (chkTodoIncomplete.Checked and not td^.IsDone) or not
            chkTodoIncomplete.Checked then
            with lvTodo.Items.Add do
            begin
                Caption := '';
                SubItems.Add(IntToStr(td^.Priority));
                S := StringReplace(td^.Description, #13#10,
                    ' ', [rfReplaceAll]);
                S := StringReplace(S, #9, ' ', [rfReplaceAll]);
                SubItems.Add(S);
                SubItems.Add(td^.Filename);
                SubItems.Add(td^.User);
                Data := td;
            end;
    end;
    lvTodo.CustomSort(nil, 0);
    lvTodo.Items.EndUpdate;
end;

procedure TMainForm.cmbTodoFilterChange(Sender: TObject);
begin
{
    0 = All files (in project and not)
    1 = Open files only (in project and not)
    2 = All project files
    3 = Open project files only
    4 = Non-project open files
    5 = Current file only
}
    while fToDoList.Count > 0 do
        if Assigned(fToDoList[0]) then
        begin
            Dispose(PToDoRec(fToDoList[0]));
            fToDoList.Delete(0);
        end;
    case cmbTodoFilter.ItemIndex of
        0:
            AddTodoFiles(False, True, True, False);
        1:
            AddTodoFiles(False, True, True, True);
        2:
            AddTodoFiles(False, True, False, False);
        3:
            AddTodoFiles(False, True, False, True);
        4:
            AddTodoFiles(False, False, True, True);
    else
        AddTodoFiles(True, False, True, True);
        //The default would be for current files only.
    end;
    BuildTodoList;
end;

procedure TMainForm.RefreshTodoList;
begin
    cmbTodoFilterChange(cmbTodoFilter);
end;

{$IfDef PLUGIN_BUILD}
{procedure TMainForm.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel.Index = 4 then
    with FormProgress do
    begin
      Top := Rect.Top;
      Left := Rect.Left;
      Width := Rect.Right - Rect.Left - 15;
      Height := Rect.Bottom - Rect.Top;
    end;
end;  }
{$ENDIF}

{EAB: Methods for wxEditor}
procedure TMainForm.UpdateEditor(filename: String; messageToDysplay: String);
var
    e: TEditor;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
{$ENDIF}
begin
    if FileExists(filename) then
    begin
        MainForm.OpenFile(filename, true);
        e := MainForm.GetEditorFromFileName(filename);
        if Assigned(e) then
        begin
            e.Text.BeginUpdate;
            try
            {$IFDEF PLUGIN_BUILD}
                for i := 0 to packagesCount - 1 do
                    (plugins[delphi_plugins[i]] AS
                        IPlug_In_BPL).GenerateSource(
                        filename, e.Text);
            {$ENDIF}
            except
            end;
            e.Text.EndUpdate;
            e.Modified := true;
            e.InsertString('', false);
            MainForm.StatusBar.Panels[3].Text := messageToDysplay;
        end;
    end;
end;

{$IFDEF PLUGIN_BUILD}
function TMainForm.GetEditorTabSheet(FileName: String): TTabSheet;
var
    e: TEditor;
begin
    Result := nil;
    if FileExists(FileName) then
    begin
        e := GetEditorFromFileName(FileName);

        if not Assigned(e) then
        begin
            OpenFile(FileName, true);
            e := GetEditorFromFileName(FileName);
        end;

        if Assigned(e) then
        begin
            Result := e.TabSheet;
        end;
    end;
end;

function TMainForm.GetEditorText(FileName: String): TSynEdit;
var
    e: TEditor;
begin
    Result := nil;
    if FileExists(FileName) then
    begin
        e := GetEditorFromFileName(FileName);

        if not Assigned(e) then
        begin
            OpenFile(FileName, true);
            e := GetEditorFromFileName(FileName);
        end;

        if Assigned(e) then
        begin
            Result := e.Text;
        end;
    end;
end;

function TMainForm.IsEditorModified(FileName: String): Boolean;
var
    e: TEditor;
begin
    Result := false;
    if FileExists(FileName) then
    begin
        e := GetEditorFromFileName(FileName);

        if not Assigned(e) then
        begin
            OpenFile(FileName, true);
            e := GetEditorFromFileName(FileName);
        end;

        if Assigned(e) then
            Result := e.Modified;
    end;
end;

function TMainForm.isFunctionAvailableInEditor(intClassID: Integer;
    strFunctionName: String;
    var intLineNum: Integer; var strFname: String): boolean;
var
    i: Integer;
    St2: PStatement;
begin
    Result := False;
    for I := 0 to ClassBrowser1.Parser.Statements.Count - 1 do // Iterate
    begin
        St2 := PStatement(ClassBrowser1.Parser.Statements[i]);
        if St2._ParentID <> intClassID then
            Continue;

        if St2._Kind <> skFunction then
            Continue;

        if AnsiSameText(strFunctionName, St2._Command) then
        begin
            strFname := St2._DeclImplFileName;
            intLineNum := St2._DeclImplLine;
            Result := True;
            Break;
        end;
    end; // for
end;

function TMainForm.FindStatementID(strClassName: string;
    var boolFound: Boolean): Integer;
var
    St: PStatement;
    I: integer;
begin
    St := nil;
    for I := 0 to ClassBrowser1.Parser.Statements.Count - 1 do // Iterate
    begin
        if PStatement(ClassBrowser1.Parser.Statements[i])._Kind = skClass then
        begin
            St := PStatement(ClassBrowser1.Parser.Statements[i]);
            if AnsiSameText(St._Command, strClassName) then
            begin
                boolFound := True;
                Break;
            end;
        end;
    end; // for
    Result := St._ID;
end;

procedure TMainForm.TouchEditor(editorName: String);
var
    e: TEditor;
begin
    e := GetEditorFromFileName(editorName);
    e.InsertString('', true);
end;

procedure TMainForm.EditorInsertDefaultText(editorName: String);
var
    e: TEditor;
begin
    e := GetEditorFromFileName(editorName);
    e.InsertDefaultText;
    e.Modified := true;
end;

function TMainForm.GetPageControlActivePageIndex: Integer;
begin
    Result := PageControl.ActivePageIndex;
end;

procedure TMainForm.SetPageControlActivePageEditor(editorName: String);
var
    e: TEditor;
begin
    e := GetEditorFromFileName(editorName);
    PageControl.ActivePageIndex := e.TabSheet.TabIndex;
    UpdateAppTitle;
end;

procedure TMainForm.SetEditorModified(editorName: String; modified: Boolean);
var
    e: TEditor;
begin
    e := GetEditorFromFileName(editorName);
    e.Modified := modified;
end;

function TMainForm.GetSuggestedInsertionLine(StID: Integer;
    AddScopeStr: Boolean): Integer;
begin
    Result := ClassBrowser1.Parser.SuggestMemberInsertionLine(StID,
        scsPublic, AddScopeStr);
end;

function TMainForm.DoesFileAlreadyExists(FileName: String): Boolean;
begin
    Result := fProject.FileAlreadyExists(FileName);
end;

procedure TMainForm.AddProjectUnit(FileName: String; b: Boolean);
var
    node: TTreeNode;
begin
    node := fProject.Node;
    fProject.AddUnit(FileName, node, b);
end;

procedure TMainForm.CloseUnit(FileName: String);
begin
    fProject.CloseUnit(fProject.GetUnitFromString(ExtractFileName(FileName)));
end;

function TMainForm.GetActiveTabSheet: TTabSheet;
var
    e: TEditor;
begin
    e := GetEditor;
    Result := e.TabSheet;
end;

function TMainForm.GetLangString(index: Integer): String;
begin
    Result := Lang.Strings[index];
end;

function TMainForm.IsUsingXPTheme: Boolean;
begin
    Result := devData.XPTheme;
end;

function TMainForm.GetConfig: String;
begin
    Result := devDirs.Config;
end;

function TMainForm.GetExec: String;
begin
    Result := devDirs.Exec;
end;

function TMainForm.ListDirectory(const Path: String;
    Attr: Integer): TStringList;
var
    Res: TSearchRec;
    EOFound: Boolean;
    entries: TStringList;
begin
    entries := TStringList.Create;
    EOFound := False;
    Result := nil;
    if FindFirst(Path, Attr, Res) < 0 then
        exit
    else
        while not EOFound do
        begin
            if ((CompareStr(Res.Name, '.') <> 0) and
                (CompareStr(Res.Name, '..') <> 0)) then
                entries.Add(Res.Name);
            EOFound := FindNext(Res) <> 0;
        end;
    FindClose(Res);
    Result := entries;
end;

procedure TMainForm.InitPlugins;
var
    items: TList;
    menuItem: TMenuItem;
    toolbar: TToolBar;
    tabs: TTabSheet;
    i, j, idx, temp_left, temp_top: Integer;
    AClass: TPersistentClass;
    loadablePlugins: TStringList;
    plugin: IPlug_In_BPL;
    pluginModule: HModule;
    pluginName: String;
    tempName: String;
    c_interface: IPlug_In_DLL;
    panel1: TForm;
    panel2: TForm;
    lbDockClient2: TJvDockClient;
    lbDockClient3: TJvDockClient;
    pluginSettings: TSettings;
begin
    unit_plugins := TIntegerHash.Create;
    packagesCount := 0;
    librariesCount := 0;
    pluginsCount := 0;
    ToolsMenuOffset := 0;
    loadablePlugins := ListDirectory(devDirs.Exec + '\plugins\*.*',
        faDirectory);
  {$IFNDEF PLUGIN_TESTING}
    for i := 0 to loadablePlugins.Count - 1 do
    begin
        pluginName := loadablePlugins[i];
        SetSplashStatus('Loading plugin "' + pluginName + '"');
        pluginModule := 0;
        if FileExists(devDirs.Exec + '\plugins\' + pluginName +
            '\' + pluginName + '.bpl') then
        begin
            pluginModule := LoadPackage(devDirs.Exec + '\plugins\' +
                pluginName + '\' + pluginName + '.bpl');
            if pluginModule <> 0 then
            begin
                SetLength(delphi_plugins, packagesCount + 1);
                delphi_plugins[packagesCount] := pluginsCount;
                SetLength(plugin_modules, pluginsCount + 1);
                plugin_modules[pluginsCount] := pluginModule;
                AClass := GetClass('T' + pluginName);
                if AClass <> nil then
                begin
                    plugin := TComponentClass(AClass).Create(Application) as
                        IPlug_In_BPL;
                {$ENDIF}
                {$IFDEF PLUGIN_TESTING}
                if loadablePlugins.Count = 0 then
                  Exit;
                pluginName := loadablePlugins[0];
                if pluginName = '' then
                  Exit;
                SetSplashStatus('Loading static plugin "' + pluginName + '"');
                AClass := GetClass('T' + pluginName);
                plugin := TComponentClass(AClass).Create(Application) AS IPlug_In_BPL;   // Used for static plugin linkage for easier debugging
                SetLength(delphi_plugins, 1);
                delphi_plugins[packagesCount] := 0;
                pluginModule := 0;
                {$ENDIF}
                    plugin.AssignPlugger(IPlug(Self));
                    SetLength(plugins, pluginsCount + 1);
                    plugins[pluginsCount] := plugin;
                    Inc(pluginsCount);
                    Inc(packagesCount);

                    // Check for saved toolbar coordinates:
                    idx := devPluginToolbarsX.AssignedToolbarsX(pluginName);
                    if idx <> -1 then
                    begin
                        temp_left :=
                            StrToInt(devPluginToolbarsX.ToolbarsXName[idx]);
                        temp_top :=
                            StrToInt(devPluginToolbarsY.ToolbarsYName[idx]);

                        If temp_left > current_max_toolbar_left then
                            current_max_toolbar_left := temp_left;
                        If temp_top > current_max_toolbar_top then
                            current_max_toolbar_top := temp_top;
                    end
                    else
                    begin
                        temp_left := current_max_toolbar_left;
                        temp_top := current_max_toolbar_top;
                    end;

                    plugin.Initialize(pluginName, pluginModule,
                        Self.Handle, ControlBar1, Self,
                        devDirs.Config, temp_left, temp_top);
                    if (plugin.ManagesUnit) then
                        unit_plugins[pluginName] := pluginsCount - 1;
                {$IFNDEF PLUGIN_TESTING}
                end;
            end;
        end
        else
        begin
            if FileExists(devDirs.Exec + '\plugins\' + pluginName +
                '\' + pluginName + '.dll') then
            begin
                tempName :=
                    devDirs.Exec + '\plugins\' + pluginName +
                    '\' + pluginName + '.dll';
                pluginModule := LoadLibrary(PChar(tempName));
            end
            else
            if FileExists(devDirs.Exec + '\plugins\' + pluginName + '\' +
                pluginName + '.ocx') then
            begin
                tempName :=
                    devDirs.Exec + '\plugins\' + pluginName +
                    '\' + pluginName + '.ocx';
                pluginModule := LoadLibrary(PChar(tempName));
            end;

            if pluginModule <> 0 then
            begin
                SetLength(c_plugins, librariesCount + 1);
                c_plugins[librariesCount] := pluginsCount;
                SetLength(plugin_modules, pluginsCount + 1);
                plugin_modules[pluginsCount] := pluginModule;

                c_interface := TPlug_In_DLL.Create(Self) AS IPlug_In_DLL;
                SetLength(plugins, pluginsCount + 1);
                plugins[pluginsCount] := c_interface;
                Inc(pluginsCount);
                Inc(librariesCount);

                // Check for saved toolbar coordinates:
                idx := devPluginToolbarsX.AssignedToolbarsX(pluginName);
                if idx <> -1 then
                begin
                    temp_left :=
                        StrToInt(devPluginToolbarsX.ToolbarsXName[idx]);
                    temp_top :=
                        StrToInt(devPluginToolbarsY.ToolbarsYName[idx]);

                    If temp_left > current_max_toolbar_left then
                        current_max_toolbar_left := temp_left;
                    If temp_top > current_max_toolbar_top then
                        current_max_toolbar_top := temp_top;
                end
                else
                begin
                    temp_left := current_max_toolbar_left;
                    temp_top := current_max_toolbar_top;
                end;

                c_interface.Initialize(pluginName, pluginModule,
                    Self.Handle, ControlBar1, Self, devDirs.Config,
                    temp_left, temp_top);
                if (c_interface.ManagesUnit) then
                    unit_plugins[pluginName] := pluginsCount - 1;
                //c_interface.TestReport;      // Temporal testing line;  should be removed, or moved to some options dialog for testing plugins.
            end;
        end;
    end;
  {$ENDIF}

    for i := 0 to pluginsCount - 1 do
        plugins[i].SetCompilerOptionstoDefaults;

    for i := 0 to pluginsCount - 1 do
    begin
        pluginSettings := plugins[i].GetCompilerOptions;
        for j := 0 to Length(pluginSettings) - 1 do
        begin
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            if tempName <> '' then
                plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        end;
    end;

    // Inserting plugin controls to the IDE
    for i := 0 to pluginsCount - 1 do
    begin

        items := plugins[i].Retrieve_LeftDock_Panels;
        if items <> nil then
        begin
            if items.Count > 1 then
            begin
                panel1 := items[0];
                panel2 := items[1];

                lbDockClient2 := TJvDockClient.Create(panel1);
                with lbDockClient2 do
                begin
                    Name := 'lbLeftDockClient_' + IntToStr(i) + '_0';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                end;
                lbDockClient3 := TJvDockClient.Create(panel2);
                with lbDockClient3 do
                begin
                    Name := 'lbLeftDockClient_' + IntToStr(i) + '_1';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                end;
                LeftDockTabs :=
                    ManualTabDock(DockServer.LeftDockPanel, panel1, panel2);
            end
            else
            begin
                panel1 := items[0];
                lbDockClient2 := TJvDockClient.Create(panel1);
                with lbDockClient2 do
                begin
                    Name := 'lbLeftDockClient_' + IntToStr(i) + '_0';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                end;
                panel1.ManualDock(DockServer.LeftDockPanel, nil, alTop);
            end;
            for j := 2 to items.Count - 1 do
            begin
                panel1 := items[j];
                ManualTabDockAddPage(LeftDockTabs, panel1);
                ShowDockForm(panel1);
            end;

        end;

        items := plugins[i].Retrieve_RightDock_Panels;
        if items <> nil then
        begin
            if items.Count > 1 then
            begin
                panel1 := items[0];
                panel2 := items[1];

                lbDockClient2 := TJvDockClient.Create(panel1);
                with lbDockClient2 do
                begin
                    Name := 'lbRightDockClient_' + IntToStr(i) + '_0';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                end;
                lbDockClient3 := TJvDockClient.Create(panel2);
                with lbDockClient3 do
                begin
                    Name := 'lbRightDockClient_' + IntToStr(i) + '_1';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                end;
                RightDockTabs :=
                    ManualTabDock(DockServer.RightDockPanel, panel1, panel2);
            end
            else
            begin
                panel1 := items[0];
                lbDockClient2 := TJvDockClient.Create(panel1);
                with lbDockClient2 do
                begin
                    Name := 'lbRightDockClient_' + IntToStr(i) + '_0';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                end;
                panel1.ManualDock(DockServer.RightDockPanel, nil, alTop);
            end;
            for j := 2 to items.Count - 1 do
            begin
                panel1 := items[j];
                ManualTabDockAddPage(RightDockTabs, panel1);
                ShowDockForm(panel1);
            end;

        end;

        items := plugins[i].Retrieve_BottomDock_Panels;
        if items <> nil then
        begin
            if items.Count > 1 then
            begin
                panel1 := items[0];
                panel2 := items[1];

                lbDockClient2 := TJvDockClient.Create(panel1);
                with lbDockClient2 do
                begin
                    Name := 'lbBottomDockClient_' + IntToStr(i) + '_0';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                end;
                lbDockClient3 := TJvDockClient.Create(panel2);
                with lbDockClient3 do
                begin
                    Name := 'lbBottomDockClient_' + IntToStr(i) + '_1';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                end;
                BottomDockTabs :=
                    ManualTabDock(DockServer.BottomDockPanel, panel1, panel2);
            end
            else
            begin
                panel1 := items[0];
                lbDockClient2 := TJvDockClient.Create(panel1);
                with lbDockClient2 do
                begin
                    Name := 'lbBottomDockClient_' + IntToStr(i) + '_0';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                end;
                panel1.ManualDock(DockServer.BottomDockPanel, nil, alTop);
            end;
            for j := 2 to items.Count - 1 do
            begin
                panel1 := items[j];
                ManualTabDockAddPage(BottomDockTabs, panel1);
                ShowDockForm(panel1);
            end;

        end;

        toolbar := plugins[i].Retrieve_Toolbars;
        if plugins[i].IsDelphiPlugin then
        begin
            if toolbar <> nil then
                Self.ControlBar1.InsertControl(toolbar)
        end
        else
            toolbar.Visible := true
    end;

    for i := 0 to packagesCount - 1 do
    begin
        items := (plugins[delphi_plugins[i]] AS
            IPlug_In_BPL).Retrieve_File_New_Menus;
        if items <> nil then
        begin
            if items.Count > 0 then
            begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.mnuNew.Add(menuItem);
            end;
            for j := 0 to items.Count - 1 do
            begin
                menuItem := items[j];
                Self.mnuNew.Add(menuItem);
            end;
        end;

        items := (plugins[delphi_plugins[i]] AS
            IPlug_In_BPL).Retrieve_File_Import_Menus;
        if items <> nil then
        begin
            if items.Count > 0 then
            begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.ImportItem.Add(menuItem);
            end;
            for j := 0 to items.Count - 1 do
            begin
                menuItem := items[j];
                Self.ImportItem.Add(menuItem);
            end;
        end;

        items := (plugins[delphi_plugins[i]] AS
            IPlug_In_BPL).Retrieve_File_Export_Menus;
        if items <> nil then
        begin
            if items.Count > 0 then
            begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.ExportItem.Add(menuItem);
            end;
            for j := 0 to items.Count - 1 do
            begin
                menuItem := items[j];
                Self.ExportItem.Add(menuItem);
            end;
        end;

        items := (plugins[delphi_plugins[i]] AS
            IPlug_In_BPL).Retrieve_Edit_Menus;
        if items <> nil then
        begin
            if items.Count > 0 then
            begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.EditMenu.Add(menuItem);
            end;
            for j := 0 to items.Count - 1 do
            begin
                menuItem := items[j];
                Self.EditMenu.Add(menuItem);
            end;
        end;

        items := (plugins[delphi_plugins[i]] AS
            IPlug_In_BPL).Retrieve_Search_Menus;
        if items <> nil then
        begin
            if items.Count > 0 then
            begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.SearchMenu.Add(menuItem);
            end;
            for j := 0 to items.Count - 1 do
            begin
                menuItem := items[j];
                Self.SearchMenu.Add(menuItem);
            end;
        end;

        items := (plugins[delphi_plugins[i]] AS
            IPlug_In_BPL).Retrieve_View_Menus;
        if items <> nil then
        begin
            if (items.Count > 0) and (Self.ShowPluginPanelsItem.Count > 0) then
            begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.ViewMenu.Add(menuItem);
            end;
            for j := 0 to items.Count - 1 do
            begin
                menuItem := items[j];
                Self.ShowPluginPanelsItem.Add(menuItem);
            end;
        end;

        items := (plugins[delphi_plugins[i]] AS
            IPlug_In_BPL).Retrieve_View_Toolbars_Menus;
        if items <> nil then
        begin
            if items.Count > 0 then
            begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.ToolbarsItem.Add(menuItem);
            end;
            for j := 0 to items.Count - 1 do
            begin
                menuItem := items[j];
                Self.ToolbarsItem.Add(menuItem);
            end;
        end;

        items := (plugins[delphi_plugins[i]] AS
            IPlug_In_BPL).Retrieve_Project_Menus;
        if items <> nil then
        begin
            if items.Count > 0 then
            begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.ProjectMenu.Add(menuItem);
            end;
            for j := 0 to items.Count - 1 do
            begin
                menuItem := items[j];
                Self.ProjectMenu.Add(menuItem);
            end;
        end;

        items := (plugins[delphi_plugins[i]] AS
            IPlug_In_BPL).Retrieve_Execute_Menus;
        if items <> nil then
        begin
            if items.Count > 0 then
            begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.ExecuteMenu.Add(menuItem);
            end;
            for j := 0 to items.Count - 1 do
            begin
                menuItem := items[j];
                Self.ExecuteMenu.Add(menuItem);
            end;
        end;

        items := (plugins[delphi_plugins[i]] AS
            IPlug_In_BPL).Retrieve_Debug_Menus;
        if items <> nil then
        begin
            if items.Count > 0 then
            begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.DebugMenu.Add(menuItem);
            end;
            for j := 0 to items.Count - 1 do
            begin
                menuItem := items[j];
                Self.DebugMenu.Add(menuItem);
            end;
        end;

        items := (plugins[delphi_plugins[i]] AS
            IPlug_In_BPL).Retrieve_Tools_Menus;
        if items <> nil then
        begin
            if items.Count > 0 then
            begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.ToolsMenu.Add(menuItem);
                Inc(ToolsMenuOffset);
            end;
            for j := 0 to items.Count - 1 do
            begin
                menuItem := items[j];
                Self.ToolsMenu.Add(menuItem);
                Inc(ToolsMenuOffset);
            end;
        end;

        items := (plugins[delphi_plugins[i]] AS
            IPlug_In_BPL).Retrieve_Help_Menus;
        if items <> nil then
        begin
            if items.Count > 0 then
            begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.HelpMenu.Add(menuItem);
            end;
            for j := 0 to items.Count - 1 do
            begin
                menuItem := items[j];
                Self.HelpMenu.Add(menuItem);
            end;
        end;

    end;
end;


procedure TMainForm.ControlBar1WM_COMMAND(Sender: TObject;
    var TheMessage: TWMCommand);
var
    i: Integer;
begin
    for i := 0 to librariesCount - 1 do
    begin
        if ((plugins[c_plugins[i]] AS IPlug_In).GetChild = TheMessage.Ctl) then
            (plugins[c_plugins[i]] AS IPlug_In_DLL).OnToolbarEvent(
                TheMessage.ItemID);
    end
end;

procedure TMainForm.ReParseFile(FileName: String);
begin
    if ClassBrowser1.Enabled then
        CppParser1.ReParseFile(FileName, true);
end;

function TMainForm.SaveFileFromPlugin(FileName: String;
    forcing: Boolean = FALSE): Boolean;
var
    e: TEditor;
begin
    Result := False;
    if FileExists(FileName) then
    begin
        e := GetEditorFromFileName(FileName);

        if not Assigned(e) and forcing = TRUE then
        begin
            OpenFile(FileName, true);
            e := GetEditorFromFileName(FileName);
        end;

        if Assigned(e) then
            Result := SaveFileInternal(e, false);
    end;
end;

procedure TMainForm.CloseEditorFromPlugin(FileName: String);
var
    tempEditor: TEditor;
begin
    tempEditor := GetEditorFromFileName(FileName, True);
    if assigned(tempEditor) then
        CloseEditorInternal(tempEditor);
end;

function TMainForm.OpenUnitInProject(s: String): Boolean;
begin
	   Result := False;
	   if fProject.Units.Indexof(s) <> -1 then
	   begin;
    	   fProject.OpenUnit(fProject.Units.Indexof(s));
    	   Result := True;
    end;
end;

procedure TMainForm.ActivateEditor(EditorFilename: String);
begin
    GetEditorFromFileName(EditorFilename).Activate;
end;

procedure TMainForm.PrepareFileForEditor(currFile: String;
    insertProj: Integer; creatingProject: Boolean; assertMessage: Boolean;
    alsoReasignEditor: Boolean; assocPlugin: String);
var
    editor: TEditor;
begin
    if (creatingProject = True) or (insertProj = 1) then
    begin
	       if assertMessage then
		          assert(assigned(fProject), 'Global project should be defined!');
        fProject.AddUnit(currFile, fProject.Node, false); // add under folder
        if ClassBrowser1.Enabled then
        begin
            CppParser1.AddFileToScan(currFile, true);
            CppParser1.ReParseFile(currFile, true, True);
            // EAB: Check this out ***
        end;
	       if alsoReasignEditor then
	       begin
            editor := fProject.OpenUnit(fProject.Units.Indexof(currFile));
            editor.Activate;
	       end
	       else
		          fProject.OpenUnit(fProject.Units.Indexof(currFile));
    end
    else
    if not creatingProject then
    begin
        OpenFile(currFile);
    end;
    editor := GetEditorFromFileName(currFile);
    if (editor <> nil) then
        editor.AssignedPlugin := assocPlugin;
end;

procedure TMainForm.ChangeProjectProfile(Index: Integer);
begin
    fProject.CurrentProfileIndex := Index;
    fProject.DefaultProfileIndex := Index;
end;

function TMainForm.GetActiveEditorName: String;
var
    e: TEditor;
begin
    e := GetEditor(Self.PageControl.ActivePageIndex);;
    if e <> nil then
        Result := e.FileName
    else
        Result := ''
end;

function TMainForm.IsEditorAssigned(editorName: String): Boolean;
var
    e: TEditor;
begin
    if (editorName = '') then
        e := GetEditor
    else
        e := GetEditorFromFileName(editorName);

    if assigned(e) then
        Result := True
    else
        Result := False
end;

function TMainForm.IsProjectAssigned: Boolean;
begin
    Result := Assigned(fProject);
end;

function TMainForm.GetDMNum: Integer;
begin
    Result := dmMain.GetNum;
end;

function TMainForm.IsClassBrowserEnabled: Boolean;
begin
    Result := ClassBrowser1.Enabled;
end;

function TMainForm.GetProjectFileName: String;
begin
    Result := fProject.FileName;
end;

function TMainForm.RetrieveUserName(var buffer: array of char;
    size: dword): Boolean;
begin
    Result := GetUserName(buffer, size);
end;

procedure TMainForm.CreateEditor(strFileN: String; extension: String;
    InProject: Boolean);
var
    NewDesigner: TEditor;
    NewUnit: TProjUnit;
    FolderNode: TTreeNode;
    strFileName, strShortFileName: String;
begin
    strFileName := ChangeFileExt(strFileN, extension);
    strShortFileName := ExtractFileName(strFileName);
    NewDesigner := TEditor.Create;

    if Assigned(fProject) and (InProject = true) then
    begin
        FolderNode := fProject.Node;
        NewUnit := fProject.AddUnit(strFileName, FolderNode, false);
        // add under folder
        NewUnit.Editor := NewDesigner;
    end;

    NewDesigner.Init(InProject, strShortFileName, strFileName, TRUE);

    if not ClassBrowser1.Enabled then
    begin
        MessageDlg('Class Browser is not enabled.' + #13 + #10 + '' + #13 +
            #10 + 'Adding Event handlers and Other features of the Form Designer '
            +
            #13 + #10 + 'wont work properly.' + #13 + #10 + '' + #13 + #10 +
            'Please enable the Class Browser.', mtWarning, [mbOK], 0);
    end;

    NewDesigner.Activate;
end;

procedure TMainForm.UnSetActiveControl;
begin
    ActiveControl := nil;
end;

function TMainForm.GetUntitledFileName: String;
begin
    Result := Lang[ID_UNTITLED] + inttostr(dmMain.GetNum);
end;

function TMainForm.GetDevDirsConfig: String;
begin
    Result := devDirs.Config;
end;

function TMainForm.GetDevDirsDefault: String;
begin
    Result := devDirs.Default;
end;

function TMainForm.GetDevDirsTemplates: String;
begin
    Result := devDirs.Templates;
end;

function TMainForm.GetDevDirsExec: String;
begin
    Result := devDirs.Exec;
end;

function TMainForm.GetCompilerProfileNames(
    var defaultProfileIndex: Integer): TStrings;
var
	   items: TStrings;
    i: Integer;
begin
	   items := TStringList.Create;
	   if (fProject <> nil) then
	   begin
        for i := 0 to fProject.Profiles.Count - 1 do
            items.Add(fProject.Profiles.Items[i].ProfileName);
	       defaultProfileIndex := fProject.DefaultProfileIndex;
	   end;
	   Result := items;
end;

function TMainForm.GetRealPathFix(BrokenFileName: String;
    Directory: String = ''): String;
begin
	   Result := GetRealPath(BrokenFileName, Directory);
end;

function TMainForm.FileAlreadyExistsInProject(s: String): Boolean;
begin
	   Result := fProject.FileAlreadyExists(s);
end;

function TMainForm.IsProjectNotNil: Boolean;
begin
	   if fProject <> nil then
		      Result := true
	   else
		      Result := false
end;

function TMainForm.GetDmMainRes: TSynRCSyn;
begin
    Result := dmMain.Res;
end;

procedure TMainForm.ToggleDockForm(form: TForm; b: Boolean);
begin
    if b = true then
        ShowDockForm(form)
    else
        HideDockForm(form);
end;

procedure TMainForm.SendToFront;
begin
    self.Show;
end;

procedure TMainForm.forceEditorFocus;
var
    e: TEditor;
begin
    e := GetEditor;
    if Assigned(e) then
    begin
        // don't know why, but at this point the editor does not show its caret.
        // if we shift the focus to another control and back to the editor,
        // everything is fine. (I smell another SynEdit bug?)
        e.TabSheet.SetFocus;
        e.Activate;
        e.Text.SetFocus;
    end;
end;

{$ENDIF PLUGIN_BUILD}

procedure TMainForm.PageControlDrawTab(Control: TCustomTabControl;
    TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
    s: string;
    r: TRect;
begin
    s := PageControl.Pages[TabIndex].Caption;
    r := Rect;
    with Control.Canvas do
    begin
        if Active then
        begin
            Brush.Color := clinfoBK;
            Font.Color := clBlue;
        end;
        Windows.FillRect(Handle, r, Brush.Handle);
        OffsetRect(r, 0, 1);
        DrawText(Handle, PChar(s), Length(s), r, DT_CENTER or
            DT_SINGLELINE or DT_VCENTER);
    end;
end;


procedure TMainForm.FormCreate(Sender: TObject);
begin
    ShowWindow(Application.Handle, SW_HIDE);
    SetWindowLong(Application.Handle, GWL_EXSTYLE,
        GetWindowLong(Application.Handle, GWL_EXSTYLE) and not
        WS_EX_APPWINDOW or WS_EX_TOOLWINDOW);
    ShowWindow(Application.Handle, SW_SHOW);
    if IsWindowsVista then
    begin
        TVistaAltFix.Create(Self);
    end;
    // accepting drag and drop files
    DragAcceptFiles(Handle, True);
    defaultHelpF1 := true;
end;

procedure TMainForm.WMSyscommand(var Message: TWmSysCommand);
begin
    //if IsWindowsVista then
    //begin
    case (Message.CmdType and $FFF0) of
        SC_MINIMIZE:
        begin
            if (HandleAllocated()) then
            begin
                ShowWindow(Handle, SW_MINIMIZE);
                Message.Result := 0;
            end;
        end;
        SC_RESTORE:
        begin
            if (HandleAllocated()) then
            begin
                ShowWindow(Handle, SW_RESTORE);
                Message.Result := 0;
            end;
        end;
    else
        inherited;
    end;
    //end
    //else inherited;
end;

procedure TMainForm.WMActivate(var Msg: TWMActivate);
begin
    //if IsWindowsVista then
    //begin
    if (Msg.Active = WA_ACTIVE) and not IsWindowEnabled(Handle) then
    begin
        if (HandleAllocated()) then
        begin
            SetActiveWindow(Application.Handle);
            Msg.Result := 0;
        end;
    end
    else
        inherited;
    //end;
end;

procedure TMainForm.RemoveAllBreakpoints1Click(Sender: TObject);
var
    e: TEditor;
    i: integer;
begin
    e := GetEditor;
    if Assigned(e) then
    begin
        for i := 1 to e.Text.Lines.Count do
        begin
            if (e.HasBreakPoint(i) <> -1) then
                e.ToggleBreakPoint(i);
        end;
    end;
end;


procedure TMainForm.OnWatches(Locals: PTList);
{
  If Locals is a null pointer, clear the on-screen list,
  otherwise, add Locals to the on-screen display
}
var
  I: Integer;
  ListItem: TListItem;

  Local: PWatchVar;

begin

  if (Locals = nil) then
  begin
    Exit;
  end;

end;

procedure TMainForm.ViewMemory1Click(Sender: TObject);
begin

 if (ViewMemory1.Checked) then
 begin
   if not Assigned(DebugMemFrm) then
    DebugMemFrm := TDebugMemFrm.Create(self);

   DebugMemFrm.Show;
 end
 else
   DebugMemFrm.Hide;

end;

end.

