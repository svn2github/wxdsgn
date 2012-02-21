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
Unit main;

Interface

Uses
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
    controlbar_win32_events, hashes, //SynEditCodeFolding,
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

Type
    PTList = ^Tlist;

Type
    TMainForm = Class(TForm{$IFDEF PLUGIN_BUILD}, iplug{$ENDIF})
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
        actVerboseDebugOutput: TAction;
        actViewDebugMemory: TAction;

        Procedure FormShow(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure FormDestroy(Sender: TObject);
        Procedure ToggleBookmarkClick(Sender: TObject);
        Procedure GotoBookmarkClick(Sender: TObject);
        Procedure ToggleBtnClick(Sender: TObject);
        Procedure GotoBtnClick(Sender: TObject);
        Procedure NewAllBtnClick(Sender: TObject);
        Procedure HelpBtnClick(Sender: TObject);
        Procedure ProjectViewContextPopup(Sender: TObject; MousePos: TPoint;
            Var Handled: Boolean);
        Procedure ProjectViewDblClick(Sender: TObject);
        Procedure InsertBtnClick(Sender: TObject);
        Procedure Customize1Click(Sender: TObject);
        Procedure ToolbarClick(Sender: TObject);
        Procedure ControlBar1ContextPopup(Sender: TObject; MousePos: TPoint;
            Var Handled: Boolean);
        Procedure ApplicationEvents1Idle(Sender: TObject; Var Done: Boolean);

        // action executes
        Procedure actNewSourceExecute(Sender: TObject);
        Procedure actNewProjectExecute(Sender: TObject);
        Procedure actNewResExecute(Sender: TObject);
        Procedure actNewTemplateExecute(Sender: TObject);
        Procedure actOpenExecute(Sender: TObject);
        Procedure actHistoryClearExecute(Sender: TObject);
        Procedure actSaveExecute(Sender: TObject);
        Procedure actSaveAsExecute(Sender: TObject);
        Procedure actSaveAllExecute(Sender: TObject);
        Procedure actCloseExecute(Sender: TObject);
        Procedure actCloseAllExecute(Sender: TObject);
        Procedure actCloseProjectExecute(Sender: TObject);
        Procedure actXHTMLExecute(Sender: TObject);
        Procedure actXRTFExecute(Sender: TObject);
        Procedure actXProjectExecute(Sender: TObject);
        Procedure actPrintExecute(Sender: TObject);
        Procedure actPrintSUExecute(Sender: TObject);
        Procedure actExitExecute(Sender: TObject);
        Procedure actUndoExecute(Sender: TObject);
        Procedure actDeleteLineExecute(Sender: TObject);
        Procedure actRedoExecute(Sender: TObject);
        Procedure actCutExecute(Sender: TObject);
        Procedure actCopyExecute(Sender: TObject);
        Procedure actPasteExecute(Sender: TObject);
        Procedure actSelectAllExecute(Sender: TObject);
        Procedure actStatusbarExecute(Sender: TObject);
        Procedure actFullScreenExecute(Sender: TObject);
        Procedure actNextExecute(Sender: TObject);
        Procedure actPrevExecute(Sender: TObject);
        Procedure actCompOptionsExecute(Sender: TObject);
        Procedure actEditorOptionsExecute(Sender: TObject);
        Procedure actConfigToolsExecute(Sender: TObject);
        Procedure actUnitRemoveExecute(Sender: TObject);
        Procedure actUnitRenameExecute(Sender: TObject);
        Procedure actUnitOpenExecute(Sender: TObject);
        Procedure actUnitCloseExecute(Sender: TObject);
        Procedure actUpdateCheckExecute(Sender: TObject);
        Procedure actAboutExecute(Sender: TObject);
        Procedure actHelpCustomizeExecute(Sender: TObject);
        Procedure actProjectNewExecute(Sender: TObject);
        Procedure actProjectAddExecute(Sender: TObject);
        Procedure actProjectRemoveExecute(Sender: TObject);
        Procedure actProjectOptionsExecute(Sender: TObject);
        Procedure actProjectSourceExecute(Sender: TObject);
        Procedure actFindExecute(Sender: TObject);
        Procedure actFindAllExecute(Sender: TObject);
        Procedure actReplaceExecute(Sender: TObject);
        Procedure actFindNextExecute(Sender: TObject);
        Procedure actGotoExecute(Sender: TObject);
        Procedure actCompileExecute(Sender: TObject);
        Procedure actRunExecute(Sender: TObject);
        Procedure actCompRunExecute(Sender: TObject);
        Procedure actRebuildExecute(Sender: TObject);
        Procedure actCleanExecute(Sender: TObject);
        Procedure actDebugExecute(Sender: TObject);
        Procedure actEnviroOptionsExecute(Sender: TObject);
        Procedure actProjectMakeFileExecute(Sender: TObject);
        Procedure actMsgCopyExecute(Sender: TObject);
        Procedure actMsgClearExecute(Sender: TObject);
        // action updates (need to make more specific)
        Procedure actUpdatePageCount(Sender: TObject);
        // enable on pagecount> 0
        Procedure actUpdateProject(Sender: TObject);
        // enable on fproject assigned
        Procedure actUpdatePageProject(Sender: TObject);
        // enable on both above
        Procedure actUpdatePageorProject(Sender: TObject);
        // enable on either of above
        Procedure actUpdateEmptyEditor(Sender: TObject);
        // enable on unempty editor
        Procedure actUpdateDebuggerRunning(Sender: TObject);
        // enable when debugger running
        Procedure actBreakPointExecute(Sender: TObject);
        Procedure actIncrementalExecute(Sender: TObject);
        Procedure CompilerOutputDblClick(Sender: TObject);
        Procedure FindOutputDblClick(Sender: TObject);
        Procedure actShowBarsExecute(Sender: TObject);
        Procedure btnFullScrRevertClick(Sender: TObject);
        Procedure FormContextPopup(Sender: TObject; MousePos: TPoint;
            Var Handled: Boolean);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure actAddWatchExecute(Sender: TObject);
        Procedure ProjectViewClick(Sender: TObject);
        Procedure actNextStepExecute(Sender: TObject);
        Procedure actWatchItemExecute(Sender: TObject);
        Procedure actRemoveWatchExecute(Sender: TObject);
        Procedure actStepOverExecute(Sender: TObject);
        Procedure actStopExecuteExecute(Sender: TObject);
        Procedure actUndoUpdate(Sender: TObject);
        Procedure actRedoUpdate(Sender: TObject);
        Procedure actCutUpdate(Sender: TObject);
        Procedure actCopyUpdate(Sender: TObject);
        Procedure actPasteUpdate(Sender: TObject);
        Procedure actSaveUpdate(Sender: TObject);
        Procedure actSaveAsUpdate(Sender: TObject);
        Procedure actFindNextUpdate(Sender: TObject);
        Procedure actFileMenuExecute(Sender: TObject);
        Procedure actToolsMenuExecute(Sender: TObject);
        Procedure actDeleteExecute(Sender: TObject);
        Procedure FormResize(Sender: TObject);
        Procedure ClassBrowser1Select(Sender: TObject; Filename: TFileName;
            Line: Integer);
        Procedure CppParser1TotalProgress(Sender: TObject; FileName: String;
            Total, Current: Integer);
        Procedure CodeCompletion1Resize(Sender: TObject);
        Procedure actSwapHeaderSourceUpdate(Sender: TObject);
        Procedure actSwapHeaderSourceExecute(Sender: TObject);
        Procedure actSyntaxCheckExecute(Sender: TObject);
        Procedure actUpdateExecute(Sender: TObject);
        Procedure PageControlChange(Sender: TObject);
        Procedure actConfigShortcutsExecute(Sender: TObject);
        Procedure DateTimeMenuItemClick(Sender: TObject);
        Procedure actProgramResetExecute(Sender: TObject);
        Procedure actProgramResetUpdate(Sender: TObject);
        Procedure CommentheaderMenuItemClick(Sender: TObject);
        Procedure PageControlMouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        Procedure actNewTemplateUpdate(Sender: TObject);
        Procedure actCommentExecute(Sender: TObject);
        Procedure actUncommentExecute(Sender: TObject);
        Procedure actIndentExecute(Sender: TObject);
        Procedure actUnindentExecute(Sender: TObject);
        Procedure PageControlDragOver(Sender, Source: TObject; X, Y: Integer;
            State: TDragState; Var Accept: Boolean);
        Procedure PageControlDragDrop(Sender, Source: TObject; X, Y: Integer);
        Procedure actGotoFunctionExecute(Sender: TObject);
        Procedure actBrowserGotoDeclUpdate(Sender: TObject);
        Procedure actBrowserGotoImplUpdate(Sender: TObject);
        Procedure actBrowserNewClassUpdate(Sender: TObject);
        Procedure actBrowserNewMemberUpdate(Sender: TObject);
        Procedure actBrowserNewVarUpdate(Sender: TObject);
        Procedure actBrowserViewAllUpdate(Sender: TObject);
        Procedure actBrowserGotoDeclExecute(Sender: TObject);
        Procedure actBrowserGotoImplExecute(Sender: TObject);
        Procedure actBrowserNewClassExecute(Sender: TObject);
        Procedure actBrowserNewMemberExecute(Sender: TObject);
        Procedure actBrowserNewVarExecute(Sender: TObject);
        Procedure actBrowserViewAllExecute(Sender: TObject);
        Procedure actBrowserViewCurrentExecute(Sender: TObject);
        Procedure actProfileProjectExecute(Sender: TObject);
        Procedure actBrowserAddFolderExecute(Sender: TObject);
        Procedure actBrowserRemoveFolderExecute(Sender: TObject);
        Procedure actBrowserAddFolderUpdate(Sender: TObject);
        Procedure actBrowserRenameFolderExecute(Sender: TObject);
        Procedure actCloseAllButThisExecute(Sender: TObject);
        Procedure actStepSingleExecute(Sender: TObject);
        Procedure lvBacktraceCustomDrawItem(Sender: TCustomListView;
            Item: TListItem; State: TCustomDrawState;
            Var DefaultDraw: Boolean);
        Procedure lvBacktraceMouseMove(Sender: TObject; Shift: TShiftState; X,
            Y: Integer);
        Procedure actDebugUpdate(Sender: TObject);
        Procedure actRunUpdate(Sender: TObject);
        Procedure actCompileUpdate(Sender: TObject);
        Procedure devFileMonitorNotifyChange(Sender: TObject;
            ChangeType: TdevMonitorChangeType; Filename: String);
        Procedure HandleFileMonitorChanges;
        Procedure actFilePropertiesExecute(Sender: TObject);
        Procedure actViewToDoListExecute(Sender: TObject);
        Procedure actAddToDoExecute(Sender: TObject);
        Procedure actProjectNewFolderExecute(Sender: TObject);
        Procedure actProjectRemoveFolderExecute(Sender: TObject);
        Procedure actProjectRenameFolderExecute(Sender: TObject);
        Procedure ProjectViewDragOver(Sender, Source: TObject; X, Y: Integer;
            State: TDragState; Var Accept: Boolean);
        Procedure ProjectViewDragDrop(Sender, Source: TObject; X, Y: Integer);
        Procedure actImportMSVCExecute(Sender: TObject);
        Procedure AddWatchPopupItemClick(Sender: TObject);
        Procedure actRunToCursorExecute(Sender: TObject);
        Procedure btnSendCommandClick(Sender: TObject);
        Procedure ViewCPUItemClick(Sender: TObject);
        Procedure edCommandKeyPress(Sender: TObject; Var Key: Char);
        Procedure actExecParamsExecute(Sender: TObject);
        Procedure actExecParamsUpdate(Sender: TObject);
        // EAB: attempt to enable menu item using current horrible model
        Procedure DevCppDDEServerExecuteMacro(Sender: TObject; Msg: TStrings);
        Procedure actShowTipsExecute(Sender: TObject);
        Procedure actBrowserUseColorsExecute(Sender: TObject);
        Procedure HelpMenuItemClick(Sender: TObject);
        Procedure CppParser1StartParsing(Sender: TObject);
        Procedure CppParser1EndParsing(Sender: TObject);
        Procedure actBrowserViewProjectExecute(Sender: TObject);
        Procedure PackageManagerItemClick(Sender: TObject);
        Procedure actAbortCompilationUpdate(Sender: TObject);
        Procedure actAbortCompilationExecute(Sender: TObject);
        Procedure RemoveItem(Node: TTreeNode);
        Procedure ProjectViewChanging(Sender: TObject; Node: TTreeNode;
            Var AllowChange: Boolean);
        Procedure dynactOpenEditorByTagExecute(Sender: TObject);
        Procedure actWindowMenuExecute(Sender: TObject);
        Procedure actGotoProjectManagerExecute(Sender: TObject);
        Procedure actCVSImportExecute(Sender: TObject);
        Procedure actCVSCheckoutExecute(Sender: TObject);
        Procedure actCVSUpdateExecute(Sender: TObject);
        Procedure actCVSCommitExecute(Sender: TObject);
        Procedure actCVSDiffExecute(Sender: TObject);
        Procedure actCVSLogExecute(Sender: TObject);
        Procedure ListItemClick(Sender: TObject);
        Procedure ProjectViewCompare(Sender: TObject; Node1, Node2: TTreeNode;
            Data: Integer; Var Compare: Integer);
        Procedure ProjectViewKeyPress(Sender: TObject; Var Key: Char);
        Procedure ProjectViewMouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        Procedure actCVSAddExecute(Sender: TObject);
        Procedure actCVSRemoveExecute(Sender: TObject);
        Procedure GoToClassBrowserItemClick(Sender: TObject);
        Procedure actBrowserShowInheritedExecute(Sender: TObject);
        Procedure actCVSLoginExecute(Sender: TObject);
        Procedure actCVSLogoutExecute(Sender: TObject);
        Procedure AddWatchBtnClick(Sender: TObject);
        Procedure ShowProjectInspItemClick(Sender: TObject);
        Procedure lvBacktraceDblClick(Sender: TObject);
        Procedure actCompileCurrentFileExecute(Sender: TObject);
        Procedure actCompileCurrentFileUpdate(Sender: TObject);
        Procedure actSaveProjectAsExecute(Sender: TObject);
        Procedure mnuOpenWithClick(Sender: TObject);
        Procedure cmbClassesChange(Sender: TObject);
        Procedure cmbMembersChange(Sender: TObject);
        Procedure CompilerOutputKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure FindOutputKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure DebugTreeKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure DebugVarsPopupPopup(Sender: TObject);
        Procedure actAttachProcessUpdate(Sender: TObject);
        Procedure actAttachProcessExecute(Sender: TObject);
        Procedure actModifyWatchExecute(Sender: TObject);
        Procedure ClearallWatchPopClick(Sender: TObject);
        Procedure PageControlChanging(Sender: TObject;
            Var AllowChange: Boolean);
        Procedure mnuCVSClick(Sender: TObject);
        Function isFileOpenedinEditor(strFile: String): Boolean;
        Procedure OnCompileTerminated(Sender: TObject);
        Procedure doDebugAfterCompile(Sender: TObject);
        Procedure ControlBar1WM_COMMAND(Sender: TObject;
            Var TheMessage: TWMCommand);
        Procedure ProjectViewKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure actRestartDebugExecute(Sender: TObject);
        Procedure actUpdateDebuggerPaused(Sender: TObject);
        Procedure actPauseDebugUpdate(Sender: TObject);
        Procedure actPauseDebugExecute(Sender: TObject);
        Procedure lvThreadsDblClick(Sender: TObject);
    {procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);}
        Procedure actViewToDoListUpdate(Sender: TObject);
        Procedure lvTodoCustomDrawItem(Sender: TCustomListView;
            Item: TListItem; State: TCustomDrawState;
            Var DefaultDraw: Boolean);
        Procedure lvTodoMouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        Procedure lvTodoColumnClick(Sender: TObject; Column: TListColumn);
        Procedure lvTodoCompare(Sender: TObject; Item1, Item2: TListItem;
            Data: Integer; Var Compare: Integer);
        Procedure lvTodoDblClick(Sender: TObject);
        Procedure chkTodoIncompleteClick(Sender: TObject);
        Procedure cmbTodoFilterChange(Sender: TObject);
        Procedure ApplicationEvents1Deactivate(Sender: TObject);
        Procedure ApplicationEvents1Activate(Sender: TObject);
        Procedure CompilerMessagesPanelItemClick(Sender: TObject);
        Procedure ResourcesMessagesPanelItemClick(Sender: TObject);
        Procedure CompileLogMessagesPanelItemClick(Sender: TObject);
        Procedure DebuggingMessagesPanelItemClick(Sender: TObject);
        Procedure FindResultsMessagesPanelItemClick(Sender: TObject);
        Procedure ToDoListMessagesPanelItemClick(Sender: TObject);
        Procedure PageControlDrawTab(Control: TCustomTabControl;
            TabIndex: Integer; Const Rect: TRect; Active: Boolean);
        Procedure FormCreate(Sender: TObject);
        Procedure DebugFinishClick(Sender: TObject);
        Procedure RemoveAllBreakpoints1Click(Sender: TObject);

        Procedure OnWatches(Locals: PTList);

    Private
        HelpWindow: HWND;
        fToDoList: TList;
        fToDoSortColumn: Integer;
        fHelpfiles: ToysStringList;
        fTools: TToolController;
        fProjectCount: Integer;
        fCompiler: TCompiler;
        bProjectLoading: Boolean;
        OldLeft: Integer;
        OldTop: Integer;
        OldWidth: Integer;
        OldHeight: Integer;
        fIsIconized: Boolean;
        ReloadFilenames: TList;


        LeftDockTabs: TJvDockTabHostForm;
        RightDockTabs: TJvDockTabHostForm;
        BottomDockTabs: TJvDockTabHostForm;

        themeManager: TThemeManager;

        Function AskBeforeClose(e: TEditor; Rem: Boolean;
            Var Saved: Boolean): Boolean;
        Procedure AddFindOutputItem(line, col, unit_, message: String);
        Function ParseParams(s: String): String;
        Procedure ParseCmdLine;
        Procedure BuildBookMarkMenus;
        Procedure BuildHelpMenu;
        Procedure SetHints;
        Procedure HelpItemClick(Sender: TObject);
        Procedure MRUClick(Sender: TObject);
        Procedure CodeInsClick(Sender: TObjecT);
        Procedure ToolItemClick(Sender: TObject);
        Procedure WMDropFiles(Var msg: TMessage); Message WM_DROPFILES;
        Procedure LogEntryProc(Const msg: String);
        Procedure CompOutputProc(Const _Line, _Unit, _Message: String);
        Procedure CompResOutputProc(Const _Line, _Unit, _Message: String);
        Procedure CompSuccessProc(Const messages: Integer);
        Procedure MainSearchProc(Const SR: TdevSearchResult);
        Procedure LoadText(force: Boolean);
    Public
        Function SaveFile(e: TEditor): Boolean;
        Function SaveFileAs(e: TEditor): Boolean;
    Private
        Procedure OpenUnit;
        Function PrepareForCompile(rebuild: Boolean): Boolean;
        Procedure LoadTheme;
        Procedure ShowDebug;
        Procedure InitClassBrowser(Full: Boolean = False);
        Procedure ScanActiveProject;
        Procedure CheckForDLLProfiling;
        Procedure UpdateAppTitle;
        Procedure DoCVSAction(Sender: TObject; whichAction: TCVSAction);
        Procedure WordToHelpKeyword;
        Procedure OnHelpSearchWord(sender: TObject);
        Procedure SetupProjectView;
        Procedure BuildOpenWith;
        Procedure RebuildClassesToolbar;
        Procedure HideCodeToolTip;
{$IFDEF PLUGIN_BUILD}
        Procedure OnDockableFormClosed(Sender: TObject;
            Var Action: TCloseAction);
        Procedure ParseCustomCmdLine(strLst: TStringList);
{$ENDIF}

        Procedure SurroundWithClick(Sender: TObject);
        //Private debugger functions
        Procedure PrepareDebugger;
        Procedure InitializeDebugger;

        //Private To-do list functions
        Procedure RefreshTodoList;
        Procedure AddTodoFiles(Current, InProject, NotInProject,
            OpenOnly: Boolean);
        Procedure BuildTodoList;
        Function BreakupTodo(Filename: String; sl: TStrings;
            Line: Integer; Token: String;
            HasUser, HasPriority: Boolean): Integer;

    Public
        Procedure DoCreateEverything;
        Procedure DoApplyWindowPlacement;
        Procedure OpenFile(s: String; withoutActivation: Boolean = False);
        // Modified for wx
        Procedure OpenProject(s: String);
        Function FileIsOpen(Const s: String; inprj: Boolean = False): Integer;
        Function GetEditor(Const index: Integer = -1): TEditor;
        Function GetEditorFromFileName(ffile: String;
            donotReOpen: Boolean = False): TEditor;
        Procedure GotoBreakpoint(bfile: String; bline: Integer);
        Procedure RemoveActiveBreakpoints;
        Procedure AddDebugVar(s: String; when: TWatchBreakOn);
        Procedure GotoTopOfStackTrace;
        Procedure SetProjCompOpt(idx: Integer; Value: Boolean);
        // set project's compiler option indexed 'idx' to value 'Value'
        Function CloseEditor(index: Integer; Rem: Boolean;
            all: Boolean = False): Boolean;

        //Debugger stuff
        Procedure AddBreakPointToList(line_number: Integer; e: TEditor);
        Procedure RemoveBreakPointFromList(line_number: Integer; e: TEditor);
        Procedure OnCallStack(Callstack: TList);
        Procedure OnThreads(Threads: TList);
        Procedure OnLocals(Locals: TList);

{$IFDEF PLUGIN_BUILD}
        Procedure SurroundString(e: TEditor; strStart, strEnd: String);

        Property Compiler: TCompiler Read fCompiler Write fCompiler;
        Property IsIconized: Boolean Read fIsIconized;
{$ENDIF}
    Private
        Procedure UMEnsureRestored(Var Msg: TMessage);
            Message UM_ENSURERESTORED;
        Procedure WMCopyData(Var Msg: TWMCopyData); Message WM_COPYDATA;
        Procedure SetSplashStatus(str: String);
    Protected
        Procedure CreateParams(Var Params: TCreateParams); Override;
        Procedure WMSyscommand(Var Message: TWmSysCommand);
            Message WM_SYSCOMMAND;
        Procedure WMActivate(Var Msg: TWMActivate); Message WM_Activate;

    Public
        frmReportDocks: Array[0..5] Of TForm;

        Function SaveFileInternal(e: TEditor;
            bParseFile: Boolean = True): Boolean;

    Public
        fProject: TProject;
        fDebugger: TDebugger;
        CacheCreated: Boolean;
        frmProjMgrDock: TForm;
        defaultHelpF1: Boolean;

{$IFDEF PLUGIN_BUILD}
        plugins: Array Of IPlug_In;
        unit_plugins: TIntegerHash;
        plugin_modules: Array Of Integer;
        delphi_plugins: Array Of Integer;
        c_plugins: Array Of Integer;
        packagesCount: Integer;
        librariesCount: Integer;
        pluginsCount: Integer;
        current_max_toolbar_left: Integer;
        current_max_toolbar_top: Integer;
        ToolsMenuOffset: Integer;
        activePluginProject: String;
        Procedure InitPlugins;
        Function ListDirectory(Const Path: String; Attr: Integer): TStringList;
        Function IsEditorAssigned(editorName: String = ''): Boolean;
        Function IsProjectAssigned: Boolean;
        Function IsClassBrowserEnabled: Boolean;
        Procedure ReParseFile(FileName: String);
        Function GetDMNum: Integer;
        Function GetProjectFileName: String;
        Procedure CloseEditorInternal(eX: TEditor);
        Function SaveFileFromPlugin(FileName: String;
            forcing: Boolean = False): Boolean;
        Procedure CloseEditorFromPlugin(FileName: String);
        Procedure ActivateEditor(EditorFilename: String);
        Function RetrieveUserName(Var buffer: Array Of Char;
            size: dword): Boolean;
        Procedure CreateEditor(strFileN: String; extension: String;
            InProject: Boolean);
        Procedure PrepareFileForEditor(currFile: String;
            insertProj: Integer; creatingProject: Boolean;
            assertMessage: Boolean;
            alsoReasignEditor: Boolean; assocPlugin: String);
        Procedure UnSetActiveControl;
        Function GetActiveEditorName: String;
        Procedure UpdateEditor(filename: String; messageToDysplay: String);
        Function GetEditorText(FileName: String): TSynEdit;
        Function GetEditorTabSheet(FileName: String): TTabSheet;
        Function IsEditorModified(FileName: String): Boolean;
        Function isFunctionAvailableInEditor(intClassID: Integer;
            strFunctionName: String; Var intLineNum: Integer;
            Var strFname: String): Boolean;
        Function isFunctionAvailable(intClassID: Integer;
            strFunctionName: String): Boolean;
        Function FindStatementID(strClassName: String;
            Var boolFound: Boolean): Integer;
        Procedure TouchEditor(editorName: String);
        Function GetSuggestedInsertionLine(StID: Integer;
            AddScopeStr: Boolean): Integer;
        Function GetFunctionsFromSource(classname: String;
            Var strLstFuncs: TStringList): Boolean;
        Procedure EditorInsertDefaultText(editorName: String);
        Function GetPageControlActivePageIndex: Integer;
        Procedure SetEditorModified(editorName: String; modified: Boolean);
        Procedure GetClassNameLocationsInEditorFiles(
            Var HppStrLst, CppStrLst: TStringList;
            FileName, FromClassName, ToClassName: String);
        Function DoesFileAlreadyExists(FileName: String): Boolean;
        Procedure AddProjectUnit(FileName: String; b: Boolean);
        Procedure CloseUnit(FileName: String);
        Function GetActiveTabSheet: TTabSheet;
        Function GetLangString(index: Integer): String;
        Function IsUsingXPTheme: Boolean;
        Function GetConfig: String;
        Function GetExec: String;
        Function OpenUnitInProject(s: String): Boolean;
        Procedure ChangeProjectProfile(Index: Integer);
        Function GetUntitledFileName: String;
        Function GetDevDirsConfig: String;
        Function GetDevDirsDefault: String;
        Function GetDevDirsTemplates: String;
        Function GetDevDirsExec: String;
        Function GetCompilerProfileNames(
            Var defaultProfileIndex: Integer): TStrings;
        Function GetRealPathFix(BrokenFileName: String;
            Directory: String = ''): String;
        Function FileAlreadyExistsInProject(s: String): Boolean;
        Function IsProjectNotNil: Boolean;
        Function GetDmMainRes: TSynRCSyn;
        Procedure SetPageControlActivePageEditor(editorName: String);
        Procedure ToggleDockForm(form: TForm; b: Boolean);
        Procedure SendToFront;
        Procedure forceEditorFocus;
        Procedure ToggleExecuteMenu(state: Boolean);
{$ENDIF}
        Function OpenWithAssignedProgram(strFileName: String): Boolean;
    End;


// added 25/2/2011
    PWatchVar = ^TWatchVar;
    TWatchVar = Packed Record
        Number: Integer;
        Name: String;
        Value: String;
        Location: String;
    End;
//end added

Var
    MainForm: TMainForm;

Implementation

Uses
{$IFDEF WIN32}
    ShellAPI, IniFiles, Clipbrd, MultiLangSupport, version,
    devcfg, datamod, helpfrm, NewProjectFrm, AboutFrm, PrintFrm,
    CompOptionsFrm, EditorOptfrm, Incrementalfrm, Search_Center, Envirofrm,
    SynEditTypes, SynEditTextBuffer, JvAppIniStorage, JvAppStorage,
    debugfrm, Types, Prjtypes, devExec,
    NewTemplateFm, FunctionSearchFm, NewMemberFm, NewVarFm, NewClassFm,
    ProfileAnalysisFm,
    FilePropertiesFm, AddToDoFm,
    ImportMSVCFm, FileAssocs, TipOfTheDayFm, Splash,
    WindowListFrm, ParamsFrm, ProcessListFrm, ModifyVarFrm,
    devMsgBox, ComObj, uvista

{$IFDEF PLUGIN_BUILD}
    //Our dependencies
    , FilesReloadFrm, debugCPU

{$ENDIF}
    ;
{$ENDIF}

{$R *.dfm}

Var
    fFirstShow: Boolean;

Const
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

Type
    PToDoRec = ^TToDoRec;
    TToDoRec = Packed Record
        TokenIndex: Integer;
        Filename: String;
        Line: Integer;
        ToLine: Integer;
        User: String;
        Priority: Integer;
        Description: String;
        IsDone: Boolean;
    End;


// Turn the execute and debug menu items on and off
Procedure TMainForm.ToggleExecuteMenu(state: Boolean);
Begin

    CompileBtn.Enabled := state;
    RebuildAllBtn.Enabled := state;
    ExecuteMenu.Enabled := state;
    DebugMenu.Enabled := state;

End;

Procedure TMainForm.CreateParams(Var Params: TCreateParams);
Begin
    Inherited;
    //inherited CreateParams(Params);
    Params.ExStyle := Params.ExStyle And Not WS_EX_TOOLWINDOW Or
        WS_EX_APPWINDOW;
    StrCopy(Params.WinClassName, cWindowClassName);
End;

Procedure TMainForm.UMEnsureRestored(Var Msg: TMessage);
Begin
    If IsIconic(Application.Handle) Then
        Application.Restore;
    If Not Visible Then
        Visible := True;
    Application.BringToFront;
End;

Procedure TMainForm.WMCopyData(Var Msg: TWMCopyData);
Var
    PData: Pchar;
    Param: String;
    strLstParams: TStringList;
Begin
    If Msg.CopyDataStruct.dwData <> cCopyDataWaterMark Then
    Begin
        exit;
        //raise Exception.Create('Invalid data structure passed in WM_COPYDATA');
    End;
    PData := Pchar(Msg.CopyDataStruct.lpData);
    strLstParams := TStringList.Create;
    While PData^ <> #0 Do
    Begin
        Param := PData;
        strLstParams.add(Param);
        Inc(PData, Length(Param) + 1);
    End;
    Msg.Result := 1;
    ParseCustomCmdLine(strLstParams);
    strLstParams.Free;
End;

Procedure TMainForm.SetSplashStatus(str: String);
Begin
    If assigned(SplashForm) Then
        SplashForm.StatusBar.SimpleText := str + '...';
End;

// This method is called from devcpp.dpr. I removed it from OnCreate, because
// all this stuff take pretty much time and it makes the application like it
// hangs. So while 'Creating' the form is hidden and when it's done, it's
// displayed without 'lag' and it's immediately ready to use ...
Procedure TMainForm.DoCreateEverything;
Var
    I: Integer;
    NewDock: TForm;
    NewDocks: TList;
{$IFDEF PLUGIN_BUILD}
    lbDockClient1: TJvDockClient;
    ini: TiniFile;
{$ENDIF}

    Procedure AddDockTab(Tab: TForm);
    Begin
        NewDocks.Add(Tab);
        With TJvDockClient.Create(Tab) Do
        Begin
            Name := Tab.Name + 'Client';
            DirectDrag := True;
            DockStyle := DockServer.DockStyle;
        End;
    End;
Begin

    //Initialize the docking style engine
    DesktopFont := True;
    NewDocks := TList.Create;

    DockServer.DockStyle := TJvDockVSNetStyle.Create(Self);
    DockServer.DockStyle.TabServerOption.HotTrack := True;
    With TJvDockVIDConjoinServerOption(
            DockServer.DockStyle.ConjoinServerOption) Do
    Begin
        ActiveFont.Name := Font.Name;
        InactiveFont.Name := Font.Name;
        ActiveFont.Size := Font.Size;
        InactiveFont.Size := Font.Size;
    End;
    With TJvDockVIDTabServerOption(DockServer.DockStyle.TabServerOption) Do
    Begin
        ActiveFont.Name := Font.Name;
        InactiveFont.Name := Font.Name;
        ActiveFont.Size := Font.Size;
        InactiveFont.Size := Font.Size;
    End;

    fToDoList := TList.Create;
    fToDoSortColumn := 0;
    fFirstShow := True;

{$IFDEF PLUGIN_BUILD}

    activePluginProject := '';
    //Project inspector
    frmProjMgrDock := TForm.Create(self);
    frmProjMgrDock.ParentFont := True;
    frmProjMgrDock.Font.Assign(Font);

    With frmProjMgrDock Do
    Begin
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
        With lbDockClient1 Do
        Begin
            Name := 'lbDockClient1';
            DirectDrag := True;
            DockStyle := DockServer.DockStyle;
        End;
    End;

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

    If tbMain.Left > current_max_toolbar_left Then
        current_max_toolbar_left := tbMain.Left;
    If tbMain.Top > current_max_toolbar_top Then
        current_max_toolbar_top := tbMain.Top;
    If tbEdit.Left > current_max_toolbar_left Then
        current_max_toolbar_left := tbEdit.Left;
    If tbEdit.Top > current_max_toolbar_top Then
        current_max_toolbar_top := tbEdit.Top;
    If tbCompile.Left > current_max_toolbar_left Then
        current_max_toolbar_left := tbCompile.Left;
    If tbCompile.Top > current_max_toolbar_top Then
        current_max_toolbar_top := tbCompile.Top;
    If tbDebug.Left > current_max_toolbar_left Then
        current_max_toolbar_left := tbDebug.Left;
    If tbDebug.Top > current_max_toolbar_top Then
        current_max_toolbar_top := tbDebug.Top;
    If tbProject.Left > current_max_toolbar_left Then
        current_max_toolbar_left := tbProject.Left;
    If tbProject.Top > current_max_toolbar_top Then
        current_max_toolbar_top := tbProject.Top;
    If tbOptions.Left > current_max_toolbar_left Then
        current_max_toolbar_left := tbOptions.Left;
    If tbOptions.Top > current_max_toolbar_top Then
        current_max_toolbar_top := tbOptions.Top;
    If tbSpecials.Left > current_max_toolbar_left Then
        current_max_toolbar_left := tbSpecials.Left;
    If tbSpecials.Top > current_max_toolbar_top Then
        current_max_toolbar_top := tbSpecials.Top;
    If tbSearch.Left > current_max_toolbar_left Then
        current_max_toolbar_left := tbSearch.Left;
    If tbSearch.Top > current_max_toolbar_top Then
        current_max_toolbar_top := tbSearch.Top;
    If tbClasses.Left > current_max_toolbar_left Then
        current_max_toolbar_left := tbClasses.Left;
    If tbClasses.Top > current_max_toolbar_top Then
        current_max_toolbar_top := tbClasses.Top;

    XPMenu.Active := True;
    // EAB Comment: Prevent XPMenu to screw plugin Controls *Hackish*
    InitPlugins;
    XPMenu.Active := devData.XPTheme;     // EAB Comment: Reload XPMenu stuff
  {$ENDIF}

    PageControl.OwnerDraw := devData.HiliteActiveTab;

    frmProjMgrDock.ManualDock(DockServer.LeftDockPanel, Nil, alTop);
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
    DragAcceptFiles(Self.Handle, True);
    dmMain := TdmMain.Create(Self);
    ReloadFilenames := TList.Create;
    fHelpfiles := ToysStringList.Create;
    fTools := TToolController.Create;
    Caption := DEVCPP;
    // + ' ' + DEVCPP_VERSION; EAB: Why put the version there? No one does that

    // set visiblity to previous sessions state
    If devData.ClassView Then
        LeftPageControl.ActivePage := ClassSheet
    Else
        LeftPageControl.ActivePage := ProjectSheet;
    actStatusbar.Checked := devData.Statusbar;
    actStatusbarExecute(Nil);

    fProjectCount := 0;
    fProject := Nil;
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
    If devData.First Or (devData.Language = '') Then
    Begin
        If devData.First Then
            dmMain.InitHighlighterFirstTime;
        Lang.SelectLanguage;
        devData.FileDate := FileAge(Application.ExeName);
        devData.First := False;
        SaveOptions;
    End
    Else
        Lang.Open(devData.Language);

    devData.Version := DEVCPP_VERSION;
    SetSplashStatus('Loading 3rd-party tools');
    With fTools Do
    Begin
        Menu := ToolsMenu;
        Offset := ToolsMenu.Indexof(PackageManagerItem) + ToolsMenuOffset;
        ToolClick := ToolItemClick;
        BuildMenu;
    End;

    LoadText(False);
    devShortcuts1.Filename := devDirs.Config + DEV_SHORTCUTS_FILE;

    //Some weird problem when upgrading to new version
{$IFNDEF PRIVATE_BUILD}
    Try
{$ENDIF}
        devShortcuts1.Load;
{$IFNDEF PRIVATE_BUILD}
    Except
    End;
{$ENDIF}

    Application.HelpFile :=
        ValidateFile(DEV_MAINHELP_FILE, devDirs.Help, True);

    SetSplashStatus('Loading code completion cache');
    If Assigned(SplashForm) Then
        CppParser1.OnCacheProgress := SplashForm.OnCacheProgress;
    InitClassBrowser(True {not CacheCreated});
    CppParser1.OnCacheProgress := Nil;

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
    ToolbarClick(Nil);

    fCompiler.RunParams := '';
    devCompiler.UseExecParams := True;
    //if pluginsCount = 0 then
    //    XPMenu.Active := false;
    For I := 0 To MessageControl.PageCount - 1 Do
    Begin
        NewDock := TForm.Create(self);
        NewDock.ParentFont := True;
        NewDock.Font.Assign(Font);
        frmReportDocks[I] := NewDock;
        With NewDock Do
        Begin
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
            While MessageControl.Pages[I].ControlCount > 0 Do
                MessageControl.Pages[I].Controls[0].Parent := NewDock;
        End;

        //Add the new dock tab
        AddDockTab(NewDock);
    End;

    If NewDocks.Count >= 2 Then
    Begin
        BottomDockTabs := ManualTabDock(DockServer.BottomDockPanel,
            NewDocks[0], NewDocks[1]);
        For I := 2 To NewDocks.Count - 1 Do
        Begin
            ManualTabDockAddPage(BottomDockTabs, NewDocks[I]);
            ShowDockForm(frmReportDocks[I]);
        End;
    End
    Else
    Begin
        With TWinControl(NewDocks[0]) Do
        Begin
            ManualDock(DockServer.BottomDockPanel);
            Show;
        End;
    End;

    //Show the compiler output list-view
    ShowDockForm(frmReportDocks[0]);

    If pluginsCount = 0 Then
        XPMenu.Active := devData.XPTheme;
    // EAB Hack to prevent crash in message tabs when not using the designer.

    //Settle the docking sizes
    DockServer.LeftDockPanel.Width := 200;
    DockServer.BottomDockPanel.Height := 175;
    DockServer.TopDockPanel.JvDockManager.GrabberSize := 22;
    DockServer.BottomDockPanel.JvDockManager.GrabberSize := 22;
    DockServer.LeftDockPanel.JvDockManager.GrabberSize := 22;
    DockServer.RightDockPanel.JvDockManager.GrabberSize := 22;

    //Clean up after ourselves
    NewDocks.Free;
    RemoveControl(MessageControl);
    MessageControl.Free;

    //Make sure the status bar is BELOW the bottom dock panel
    Statusbar.Top := Self.ClientHeight;
End;

Procedure TMainForm.AddBreakPointToList(line_number: Integer; e: TEditor);
Var
    Breakpoint: TBreakpoint;
Begin
    Breakpoint := TBreakpoint.Create;
    With Breakpoint Do
    Begin
        Line := line_number;
        Filename := ExtractFileName(e.Filename);
        Editor := e;
    End;
    fDebugger.AddBreakpoint(Breakpoint);
End;

Procedure TMainForm.RemoveBreakPointFromList(line_number: Integer; e: TEditor);
Var
    Breakpoint: TBreakpoint;
Begin
    Breakpoint := TBreakpoint.Create;
    With Breakpoint Do
    Begin
        Line := line_number;
        Filename := ExtractFileName(e.Filename);
        Editor := e;
    End;
    fDebugger.RemoveBreakpoint(Breakpoint);
End;

Procedure TMainForm.OnCallStack(Callstack: TList);
Var
    I: Integer;
Begin
    Assert(Assigned(Callstack), 'Callstack must be valid');
    lvBacktrace.Items.BeginUpdate;
    lvBacktrace.Items.Clear;

    For I := 0 To Callstack.Count - 1 Do
        With lvBacktrace.Items.Add Do
        Begin
            Caption := PStackFrame(Callstack[I])^.FuncName;
            SubItems.Add(PStackFrame(Callstack[I])^.Args);
            SubItems.Add(PStackFrame(Callstack[I])^.Filename);
            If PStackFrame(Callstack[I])^.Line <> 0 Then
                SubItems.Add(IntToStr(PStackFrame(Callstack[I])^.Line));
            Data := CppParser1.Locate(Caption, True);
        End;
    lvBacktrace.Items.EndUpdate;
End;

Procedure TMainForm.OnThreads(Threads: TList);
Var
    I: Integer;
Begin
    lvThreads.Items.BeginUpdate;
    lvThreads.Items.Clear;

    For I := 0 To Threads.Count - 1 Do
        With lvThreads.Items.Add Do
        Begin
            If PDebuggerThread(Threads[I])^.Active Then
            Begin
                Caption := '*';
                lvThreads.Selected := lvThreads.Items[Index];
                MakeVisible(False);
            End
            Else
                Caption := '';
            SubItems.Add(PDebuggerThread(Threads[I])^.Index);
            SubItems.Add(PDebuggerThread(Threads[I])^.ID);
        End;
    lvThreads.Items.EndUpdate;
End;

Procedure TMainForm.OnLocals(Locals: TList);
Var
    I: Integer;
Begin
    Assert(Assigned(Locals), 'Locals list must be valid');
    lvLocals.Items.BeginUpdate;
    lvLocals.Items.Clear;

    For I := 0 To Locals.Count - 1 Do
        With lvLocals.Items.Add Do
        Begin
            Caption := PWatchVar(Locals[I])^.Name;
            SubItems.Add(PWatchVar(Locals[I])^.Value);
            SubItems.Add(PWatchVar(Locals[I])^.Location);
        End;
    lvLocals.Items.EndUpdate;
End;

// This method is called from devcpp.dpr. It's called at the very last, because
// it forces the form to show and we only want to display the form when it's
// ready and fully created
Procedure TMainForm.DoApplyWindowPlacement;
{$IFDEF PLUGIN_BUILD}
Var
    i: Integer;
{$ENDIF PLUGIN_BUILD}
Begin
    If devData.WindowPlacement.rcNormalPosition.Right <> 0 Then
        SetWindowPlacement(Self.Handle, @devData.WindowPlacement)
    Else
    If Not CacheCreated Then
        // this is so weird, but the following call seems to take a lot of time to execute
        Self.Position := poScreenCenter;

    //Load the window layout from the INI file
    If FileExists(ExtractFilePath(devData.INIFile) + 'layout' + INI_EXT) Then
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
    For i := 0 To pluginsCount - 1 Do
        plugins[i].AfterStartupCheck;
{$ENDIF}

    //Show the main form
    Show;
End;


Procedure TMainForm.LoadTheme;
Var
    Idx: Integer;
Begin
{$IFNDEF PRIVATE_BUILD}
    Try
{$ENDIF}
        XPMenu.Active := devData.XPTheme;

{$IFNDEF COMPILER_7_UP}
        //Initialize theme support
        themeManager := TThemeManager.Create(Self);
        With themeManager Do
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
    Except
    End;
{$ENDIF}

    If devImageThemes.IndexOf(devData.Theme) < 0 Then
        devData.Theme := devImageThemes.Themes[0].Title;
    // 0 = New look (see ImageTheme.pas)

    //make sure the theme in question is in the list
    Idx := devImageThemes.IndexOf(devData.Theme);
    If Idx > -1 Then
    Begin
        devImageThemes.ActivateTheme(devData.Theme);

        With devImageThemes Do
        Begin
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
            For Idx := 0 To Length(frmReportDocks) - 1 Do
                CurrentTheme.MenuImages.GetIcon(frmReportDocks[Idx].Tag,
                    frmReportDocks[Idx].Icon);
        End;
    End;

    fTools.BuildMenu; // reapply icons to tools
End;

Procedure TMainForm.FormShow(Sender: TObject);
Begin

    //TODO: lowjoel: Do we need to track whether this is the first show? Can someone
    //               trace into the code to see if this function is called more than once?
    If fFirstShow Then
    Begin
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

        If ParamCount > 0 Then
            ParseCmdLine;

        If devData.MsgTabs Then
            DockServer.DockStyle.TabServerOption.TabPosition := tpTop
        Else
            DockServer.DockStyle.TabServerOption.TabPosition := tpBottom;

        SetupProjectView;
        fFirstShow := False;
    End;
End;

{$IFDEF PLUGIN_BUILD}
Procedure TMainForm.OnDockableFormClosed(Sender: TObject;
    Var Action: TCloseAction);
Begin
    //Sanity check
    If Not (Sender Is TForm) Then
        Exit;

    If TForm(Sender) = frmProjMgrDock Then
        ShowProjectInspItem.Checked := False
    Else
    If TForm(Sender) = frmReportDocks[0] Then
        CompilerMessagesPanelItem.Checked := False
    Else
    If TForm(Sender) = frmReportDocks[1] Then
        ResourcesMessagesPanelItem.Checked := False
    Else
    If TForm(Sender) = frmReportDocks[2] Then
        CompileLogMessagesPanelItem.Checked := False
    Else
    If TForm(Sender) = frmReportDocks[3] Then
        DebuggingMessagesPanelItem.Checked := False
    Else
    If TForm(Sender) = frmReportDocks[4] Then
        FindResultsMessagesPanelItem.Checked := False
    Else
    If TForm(Sender) = frmReportDocks[5] Then
        ToDoListMessagesPanelItem.Checked := False;
End;
{$ENDIF}

Procedure TMainForm.FormClose(Sender: TObject; Var Action: TCloseAction);
Var
    JvAppIniFileStorage: TJvAppIniFileStorage;
{$IFDEF PLUGIN_BUILD}
    items: TList;
    toolbar: TToolBar;
    i, j: Integer;
    panel1: TForm;
    panel2: TForm;
{$ENDIF PLUGIN_BUILD}
Begin
    If IsWindow(HelpWindow) Then
        SendMessage(HelpWindow, WM_CLOSE, 0, 0);

    If assigned(fProject) Then
        actCloseProject.Execute;
    If Assigned(fProject) Then
    Begin
        Action := caNone;
        Exit;
    End;

    If PageControl.PageCount > 0 Then
        actCloseAll.execute;
    If PageControl.PageCount > 0 Then
    Begin
        Action := caNone;
        Exit;
    End;

    GetWindowPlacement(Self.Handle, @devData.WindowPlacement);
    JvAppIniFileStorage := TJvAppIniFileStorage.Create(Self);
    JvAppIniFileStorage.FileName :=
        ExtractFilePath(devData.INIFile) + 'layout' + INI_EXT;
    JvAppIniFileStorage.AutoFlush := True;
    JvAppIniFileStorage.AutoReload := True;
    JvAppIniFileStorage.BeginUpdate;
    Try
        SaveDockTreeToAppStorage(JvAppIniFileStorage);
    Finally
        JvAppIniFileStorage.Location := flCustom;
        JvAppIniFileStorage.EndUpdate;
        JvAppIniFileStorage.Flush;
        JvAppIniFileStorage.Free;
    End;

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
    DockServer.LeftDockPanel.Visible := False;
    // More "gratious" closing of panels, due to ManualTabDock plugin removal requirement
    DockServer.RightDockPanel.Visible := False;
    DockServer.BottomDockPanel.Visible := False;
    //end;

    themeManager.Free;
    For i := 0 To pluginsCount - 1 Do
    Begin

        items := plugins[i].Retrieve_LeftDock_Panels;
        If items <> Nil Then
        Begin
            For j := 0 To items.Count - 1 Do
            Begin
                panel1 := items[j];
                panel1.Visible := False;
                FindDockClient(panel1).Free;
            End;
        End;

        items := plugins[i].Retrieve_RightDock_Panels;
        If items <> Nil Then
        Begin
            For j := 0 To items.Count - 1 Do
            Begin
                panel1 := items[j];
                panel1.Visible := False;
                FindDockClient(panel1).Free;
            End;
        End;

        items := plugins[i].Retrieve_BottomDock_Panels;
        If items <> Nil Then
        Begin
            For j := 0 To items.Count - 1 Do
            Begin
                panel1 := items[j];
                panel1.Visible := False;
                FindDockClient(panel1).Free;
            End;
        End;

        toolbar := plugins[i].Retrieve_Toolbars;
        If toolbar <> Nil Then
        Begin
            devPluginToolbarsX.AddToolbarsX(plugins[i].GetPluginName,
                toolbar.Left);
            devPluginToolbarsY.AddToolbarsY(plugins[i].GetPluginName,
                toolbar.Top);
        End;
        plugins[i].Destroy;
        plugins[i] := Nil;
    End;
  {$ENDIF PLUGIN_BUILD}
    SaveOptions;

End;

Procedure TMainForm.FormDestroy(Sender: TObject);
{$IFDEF PLUGIN_BUILD}
Var
    i: Integer;
{$ENDIF PLUGIN_BUILD}
Begin
    If Assigned(fDebugger) Then
        If fDebugger.Executing Then
            fDebugger.CloseDebugger(Sender);

    fHelpFiles.free;
    fTools.Free;
    fCompiler.Free;
    fDebugger.Free;
    dmMain.Free;
    devImageThemes.Free;
    ReloadFilenames.Free;
    ClassBrowser1.Free;

    If Assigned(fToDoList) Then
        While fToDoList.Count > 0 Do
            If Assigned(fToDoList[0]) Then
            Begin
                Dispose(PToDoRec(fToDoList[0]));
                fToDoList.Delete(0);
            End;
    fToDoList.Free;

    devPluginToolbarsX.Free;
    devPluginToolbarsY.Free;

  {$IFDEF PLUGIN_BUILD}
  {$IFNDEF PLUGIN_TESTING}
    For i := 0 To packagesCount - 1 Do
        UnloadPackage(plugin_modules[delphi_plugins[i]]);
    For i := 0 To librariesCount - 1 Do
        FreeLibrary(plugin_modules[c_plugins[i]]);
  {$ENDIF PLUGIN_TESTING}
    unit_plugins.Free;
  {$ENDIF PLUGIN_BUILD}

    HHCloseAll;     //Close help before shutdown or big trouble
End;

Procedure TMainForm.ParseCmdLine;
Var
    idx: Integer;
    strLstParams: TStringList;
Begin
    idx := 1;

    strLstParams := TStringList.Create;
    While idx <= ParamCount Do
    Begin
        strLstParams.Add(ParamStr(idx));
        inc(idx);
    End;

    ParseCustomCmdLine(strLstParams);
    strLstParams.Free;
End;

//This function is derived from the pre parsecmdline function.
//This is also used when activating the devcpp's previous instance
Procedure TMainForm.ParseCustomCmdLine(strLst: TStringList);
Var
    idx: Integer;
    intParamCount: Integer;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
{$ENDIF}
Begin
    idx := 0;
    intParamCount := strLst.Count - 1;
    While idx <= intParamCount Do
    Begin
        If (strLst[idx] = CONFIG_PARAM) Then
        Begin
            idx := idx + 2;
            If (idx <= intParamCount) Then
                continue
            Else
                exit;
        End;
        If FileExists(strLst[idx]) Then
        Begin
            If GetFileTyp(strLst[idx]) = utPrj Then
            Begin
                OpenProject(GetLongName(strLst[idx]));
                break; // only open 1 project
            End
            Else
            Begin
                chdir(ExtractFileDir(strLst[idx]));
{$IFDEF PLUGIN_BUILD}
                For i := 0 To pluginsCount - 1 Do
                    plugins[i].OpenFile(GetLongName(strLst[idx]));
{$ENDIF}
                OpenFile(GetLongName(strLst[idx]));
            End;
        End
        Else
        Begin
            ShowMessage('File ' + strLst[idx] + ' doesn''t exist!');
        End;

        inc(idx);
    End;
End;

Procedure TMainForm.BuildBookMarkMenus;
Var
    idx: Integer;
    s, Text: String;
    GItem,
    TItem: TMenuItem;
Begin
    Text := Lang[ID_MARKTEXT];
    ToggleBookMarksItem.Clear;
    GotoBookmarksItem.Clear;
    For idx := 1 To 9 Do
    Begin
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
    End;

    CloneMenu(ToggleBookmarksItem, TogglebookmarksPopItem);
    CloneMenu(GotoBookmarksItem, GotobookmarksPopItem);

End;

Procedure TMainForm.BuildHelpMenu;
Var
    afile: String;
    ini: Tinifile;
    idx,
    idx2: Integer;
    Item,
    Item2: TMenuItem;
Begin
    aFile := ValidateFile(DEV_HELP_INI, devDirs.Config, True);
    If aFile = '' Then
        exit;

    // delete between "Dev-C++ Help" and first separator
    idx2 := HelpMenu.IndexOf(HelpSep1);
    For idx := pred(idx2) Downto 1 Do
        HelpMenu[idx].Free;

    // delete between first and second separator
    idx2 := HelpMenu.IndexOf(HelpSep2);
    For idx := pred(idx2) Downto Succ(HelpMenu.IndexOf(HelpSep1)) Do
        HelpMenu[idx].Free;

    HelpMenu.SubMenuImages := devImageThemes.CurrentTheme.HelpImages;
    //devTheme.Help;

    // since 4.9.6.9, a standard menu entry appeared in HelpPop (Help On DevCpp)
    // so items.clear is not good anymore...
    While HelpPop.Items.Count > 1 Do
        HelpPop.Items.Delete(HelpPop.Items.Count - 1);

    ini := TiniFile.Create(aFile);
    Try
        If Not assigned(fHelpFiles) Then
            fHelpFiles := ToysStringList.Create
        Else
            fHelpFiles.Clear;

        ini.ReadSections(fHelpFiles);
        If fHelpFiles.Count = 0 Then
            exit;

        For idx := 0 To pred(fHelpFiles.Count) Do
        Begin
            afile := ini.ReadString(fHelpFiles[idx], 'Path', '');
            If (aFile = '') Then
                continue;
            If AnsiPos(HTTP, aFile) = 0 Then
                aFile := ExpandFileto(aFile, devDirs.Help);
            If (aFile <> '') Then
            Begin
                fHelpFiles[idx] := format('%s=%s', [fHelpFiles[idx], aFile]);
                If ini.ReadInteger(fHelpFiles.Names[idx], 'Menu', 1) = 1 Then
                    idx2 := HelpMenu.IndexOf(HelpSep1)
                Else
                    idx2 := HelpMenu.IndexOf(HelpSep2);

                Item := TMenuItem.Create(HelpMenu);
                XPMenu.InitComponent(Item);
                With Item Do
                Begin
                    Caption := fHelpFiles.Names[idx];
                    If ini.ReadBool(fHelpFiles.Names[idx],
                        'SearchWord', False) Then
                        OnClick := OnHelpSearchWord
                    Else
                        OnClick := HelpItemClick;
                    If ini.ReadBool(fHelpFiles.Names[idx],
                        'AffectF1', False) Then
                    Begin
                        defaultHelpF1 := False;
                        ShortCut := TextToShortcut('F1');
                    End;
                    Tag := idx;
                    ImageIndex :=
                        ini.ReadInteger(fHelpFiles.Names[idx], 'Icon', 0);
                End;
                HelpMenu.Insert(idx2, Item);
                If ini.ReadBool(fHelpFiles.Names[idx], 'Pop', False) Then
                Begin
                    Item2 := TMenuItem.Create(HelpPop);
                    With Item2 Do
                    Begin
                        Caption := fHelpFiles.Names[idx];
                        OnClick := HelpItemClick;
                        Tag := idx;
                        ImageIndex :=
                            ini.ReadInteger(fHelpFiles.Names[idx], 'Icon', 0);
                    End;
                    HelpPop.Items.Add(Item2);
                End;
            End;
        End;
    Finally
        ini.free;
    End;
End;

Procedure TMainForm.SetHints;
Var
    idx: Integer;
Begin
    For idx := 0 To pred(alMain.ActionCount) Do
        TCustomAction(alMain.Actions[idx]).Hint :=
            StripHotKey(TCustomAction(alMain.Actions[idx]).Caption);
End;

// allows user to drop files from explorer on to form
Procedure TMainForm.WMDropFiles(Var msg: TMessage);
Var
    idx,
    idx2,
    count: Integer;
    szFileName: Array[0..260] Of Char;
    pt: TPoint;
    hdl: THandle;
    ProjectFN: String;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
{$ENDIF}
Begin
    Try
        ProjectFN := '';
        hdl := THandle(msg.wParam);
        count := DragQueryFile(hdl, $FFFFFFFF, Nil, 0);
        DragQueryPoint(hdl, pt);

        For idx := 0 To pred(count) Do
        Begin
            DragQueryFile(hdl, idx, szFileName, sizeof(szFileName));

            // Is there a project?
            If AnsiCompareText(ExtractFileExt(szFileName), DEV_EXT) = 0 Then
            Begin
                ProjectFN := szFileName;
                Break;
            End;
        End;

        If Length(ProjectFN) > 0 Then
            OpenProject(ProjectFN)
        Else
            For idx := 0 To pred(count) Do
            Begin
                DragQueryFile(hdl, idx, szFileName, sizeof(szFileName));
                idx2 := FileIsOpen(szFileName);
                If idx2 <> -1 Then
                    TEditor(PageControl.Pages[idx2].Tag).Activate
                Else // open file
                Begin
{$IFDEF PLUGIN_BUILD}
                    For i := 0 To pluginsCount - 1 Do
                        plugins[i].OpenFile(szFileName);
{$ENDIF}
                    OpenFile(szFileName);
                End;
            End;
    Finally
        msg.Result := 0;
        DragFinish(THandle(msg.WParam));
    End;
End;

Procedure TMainForm.LoadText(force: Boolean);
Var
    i: Integer;
Begin
    With Lang Do
    Begin
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
        If devData.fullScreen Then
            actFullScreen.Caption := Strings[ID_ITEM_FULLSCRBACK]
        Else
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

        With devShortcuts1.MultiLangStrings Do
        Begin
            Caption := Strings[ID_SC_CAPTION];
            Title := Strings[ID_SC_TITLE];
            Tip := Strings[ID_SC_TIP];
            HeaderEntry := Strings[ID_SC_HDRENTRY];
            HeaderShortcut := Strings[ID_SC_HDRSHORTCUT];
            Cancel := Strings[ID_BTN_CANCEL];
            OK := Strings[ID_BTN_OK];
        End;

        pnlFull.Caption := Format(Strings[ID_FULLSCREEN_MSG],
            [DEVCPP, DEVCPP_VERSION]);

        // Mainform toolbar buttons
        NewAllBtn.Caption := Strings[ID_TB_NEW];
        InsertBtn.Caption := Strings[ID_TB_INSERT];
        ToggleBtn.Caption := Strings[ID_TB_TOGGLE];
        GotoBtn.Caption := Strings[ID_TB_GOTO];

        tbSpecials.Width := NewAllBtn.Width + InsertBtn.Width +
            ToggleBtn.Width + GotoBtn.Width;
    End;
    BuildBookMarkMenus;
    SetHints;

    For i := 0 To pluginsCount - 1 Do
        plugins[i].LoadText(True);

End;

Function TMainForm.FileIsOpen(Const s: String;
    inPrj: Boolean = False): Integer;
Var
    e: TEditor;
Begin
    For result := 0 To pred(PageControl.PageCount) Do
    Begin
        e := GetEditor(result);
        If e.filename <> '' Then
        Begin
            If (AnsiCompareText(e.FileName, s) = 0) Then
                If (Not inprj) Or (e.InProject) Then
                    exit;
        End
        Else
        If AnsiCompareText(e.TabSheet.Caption, ExtractfileName(s)) = 0 Then
            If (Not inprj) Or (e.InProject) Then
                exit;
    End;
    result := -1;
End;


//TODO: lowjoel: The following three Save functions probably can be refactored for
//               speed. Anyone can reorganize it to optimize it for speed and efficiency,
//               as well as to cut the number of lines needed.\
//Combine the Save functions together. The saveAS function should be able to use
//the Save function, and the Save functionm can do
Function TMainForm.SaveFileAs(e: TEditor): Boolean;
Var
    I: Integer;
    dext, flt, s: String;
    idx: Integer;
    CFilter, CppFilter, HFilter: Integer;
    boolIsRC: Boolean;
    ccFile, hfile: String;
{$IFDEF PLUGIN_BUILD}
   // filters: TStringList;
    editorName: String;
{$ENDIF}
Begin
    Result := True;
    boolIsRC := False;
    idx := -1;
    If assigned(fProject) Then
    Begin
        If e.FileName = '' Then
        Begin
            idx := fProject.GetUnitFromString(e.TabSheet.Caption);
            boolIsRC := isRCExt(e.TabSheet.Caption);
        End
        Else
        Begin
            idx := fProject.Units.Indexof(e.FileName);
            boolIsRC := isRCExt(e.FileName);
        End;
        If fProject.Profiles.UseGPP Then
        Begin
            BuildFilter(flt, [FLT_CPPS, FLT_CS, FLT_HEADS]);
            dext := CPP_EXT;
            CFilter := 3;
            CppFilter := 2;
            HFilter := 4;
        End
        Else
        Begin
            BuildFilter(flt, [FLT_CS, FLT_CPPS, FLT_HEADS]);
            dext := C_EXT;
            CFilter := 2;
            CppFilter := 3;
            HFilter := 4;
        End;

        If e.IsRes Then
        Begin
            BuildFilter(flt, [FLT_RES]);
            dext := RC_EXT;
            CFilter := 2;
            CppFilter := 2;
            HFilter := 2;
        End;

        If boolIsRC Then
        Begin
            BuildFilter(flt, [FLT_RES]);
            dext := RC_EXT;
            CFilter := 2;
            CppFilter := 2;
            HFilter := 2;
        End;

{$IFDEF PLUGIN_BUILD}
        If e.FileName = '' Then
            editorName := e.TabSheet.Caption
        Else
            editorName := e.FileName;

        If e.AssignedPlugin <> '' Then
        Begin
            If plugins[unit_plugins[e.AssignedPlugin]].IsForm(editorName) Then
            Begin
                BuildFilter(flt,
                    [plugins[unit_plugins[e.AssignedPlugin]].GetFilter(editorName)]);
                dext := plugins[unit_plugins[e.AssignedPlugin]].Get_EXT(editorName);
                CFilter := 2;
                CppFilter := 2;
                HFilter := 2;
            End;
        End;
{$ENDIF}

    End
    Else
    Begin
        BuildFilter(flt, ftAll);
        If e.IsRes Then
            dext := RC_EXT
        Else
            dext := CPP_EXT;
{$IFDEF PLUGIN_BUILD}

        If e.FileName = '' Then
            editorName := e.TabSheet.Caption
        Else
            editorName := e.FileName;

        If e.AssignedPlugin <> '' Then
        Begin
            If plugins[unit_plugins[e.AssignedPlugin]].IsForm(editorName) Then
            Begin
                dext := plugins[unit_plugins[e.AssignedPlugin]].Get_EXT(editorName);
            End;
        End;
{$ENDIF}
        If boolIsRC Then
        Begin
            dext := RC_EXT;
        End;
        CFilter := 5;
        CppFilter := 6;
        HFilter := 3;
    End;

    If e.FileName = '' Then
        s := e.TabSheet.Caption
    Else
        s := e.FileName;

    With dmMain.SaveDialog Do
    Begin
        Title := Lang[ID_NV_SAVEFILE];
        Filter := flt;
        DefaultExt := dext;   // EAB: this was missing I guess, but not sure...

        // select appropriate filter       
        If (CompareText(ExtractFileExt(s), '.h') = 0) Or
            (CompareText(ExtractFileExt(s), '.hpp') = 0) Or
            (CompareText(ExtractFileExt(s), '.hh') = 0) Then
            FilterIndex := HFilter
        Else
        If Assigned(fProject) Then
        Begin
            If fProject.Profiles.useGPP Then
                FilterIndex := CppFilter
            Else
                FilterIndex := CFilter;
        End
        Else
            FilterIndex := CppFilter;

        If e.AssignedPlugin <> '' Then
        Begin
            If plugins[unit_plugins[e.AssignedPlugin]].IsForm(editorName) Then
            Begin
                FilterIndex :=
                    plugins[unit_plugins[e.AssignedPlugin]].Get_EXT_Index(editorName);
            End;
        End;

        FileName := s;
        s := ExtractFilePath(s);
        If (s <> '') Or Not Assigned(fProject) Then
            InitialDir := s
        Else
            InitialDir := fProject.Directory;

        If Execute Then
        Begin
            s := FileName;
            If FileExists(s) And (MessageDlg(Lang[ID_MSG_FILEEXISTS],
                mtWarning, [mbYes, mbNo], 0) = mrNo) Then
                Exit;

{$IFDEF PLUGIN_BUILD}

    {if Assigned(fProject) then
    begin
      activePluginProject := fProject.AssociatedPlugin;
      if activePluginProject <> '' then
        plugins[unit_plugins[activePluginProject]].SetEditorName(e.FileName, s);
    end
    else }If e.AssignedPlugin <> '' Then
                plugins[unit_plugins[e.AssignedPlugin]].SetEditorName(
                    e.FileName, s);

{$ENDIF}
            e.FileName := s;

            Try
                If devEditor.AppendNewline Then
                    With e.Text Do
                        If Lines.Count > 0 Then
                            If Lines[Lines.Count - 1] <> '' Then
                                Lines.Add('');

                   // Code folding - Save the un-folded text, otherwise	 
	         //    the folded regions won't be saved.	 
	       {  if (e.Text.CodeFolding.Enabled) then
	         begin	 
	           //e.Text.ReScanForFoldRanges;
	           e.Text.UncollapsedLines.SaveToFile(s);
	         end	 
	         else	 
	         begin }
                e.Text.Lines.SaveToFile(s);
                // end;
                e.Modified := False;
                e.New := False;
            Except

                MessageDlg(Lang[ID_ERR_SAVEFILE] + ' "' + s +
                    '"', mtError, [mbOk], 0);
                Result := False;

            End;

            //Bug fix for 1337392 : This fix Parse the Cpp file when we save the header
            //file provided the Cpp file is already saved. Don't change the way steps
            //by which the file is parsed.
            If assigned(fProject) Then
                fProject.SaveUnitAs(idx, e.FileName)
            Else
                e.TabSheet.Caption := ExtractFileName(e.FileName);

            //TODO: lowjoel: optimize this code - it seems as though GetSourcePair is called twice
            If ClassBrowser1.Enabled Then
            Begin
                CppParser1.GetSourcePair(ExtractFileName(e.FileName),
                    ccFile, hfile);
                CppParser1.AddFileToScan(e.FileName); //new cc
                CppParser1.ParseList;
                ClassBrowser1.CurrentFile := e.FileName;
                CppParser1.ReParseFile(e.FileName, True); //new cc

                //if the source is in the cache and the header file is not in the cache
                //then we need to reparse the Cpp file to make sure the intialially
                //parsed cpp file is reset
                If GetFileTyp(e.FileName) = utHead Then
                Begin
                    CppParser1.GetSourcePair(ExtractFileName(e.FileName),
                        ccFile, hfile);
                    If Trim(ccFile) <> '' Then
                    Begin
                        idx := -1;
                        For I := CppParser1.ScannedFiles.Count - 1 Downto 0 Do
                            // Iterate
                            If AnsiSameText(ExtractFileName(ccFile),
                                ExtractFileName(
                                CppParser1.ScannedFiles[i])) Then
                            Begin
                                ccFile := CppParser1.ScannedFiles[i];
                                idx := i;
                                Break;
                            End;

                        If idx <> -1 Then
                            CppParser1.ReParseFile(ccFile, True); //new cc
                    End;
                End;
            End;
        End
        Else
            Result := False;
    End;
End;

//SaveFileInternal will take the editor E and do all the checks before actually
//saving the file to disk. This is an anonymous function because we shouldn't
//be calling this anywhere else! (Call SaveFile instead)
Function TMainForm.SaveFileInternal(e: TEditor;
    bParseFile: Boolean = True): Boolean;
Var
    EditorUnitIndex: Integer;
Begin
    Result := False;

    //First conduct a read-only check.
    //TODO: lowjoel: If the file is read-only we should disable the editing of
    //               the SynEdit?
    If FileExists(e.FileName) And (FileGetAttr(e.FileName) And
        faReadOnly <> 0) Then
    Begin
        //File is read-only
        If MessageDlg(Format(Lang[ID_MSG_FILEISREADONLY], [e.FileName]),
            mtConfirmation,
            [mbYes, mbNo], Handle) = mrNo Then
            Exit;

        //Attempt to remove the read-only attribute
        If FileSetAttr(e.FileName, FileGetAttr(e.FileName) -
            faReadOnly) <> 0 Then
        Begin
            MessageDlg(Format(Lang[ID_MSG_FILEREADONLYERROR],
                [e.FileName]), mtError,
                [mbOk], Handle);
            Exit;
        End;
    End;

    // EAB Comment: Why should we assert this?
    //Assert(not e.New, 'The code can call this function only on the premise that ' + 'the editor being saved has a filename.');

    // EAB Comment: Why the file cannot be new? If the user chooses to save it it should be saved.
    //if (not e.New) and e.Modified then
    If e.New And e.Modified Then
    Begin
        SaveFileAs(GetEditor);
        Result := True;
    End
    Else
    If e.Modified Then
    Begin
        //OK. The file needs to be saved. But we treat project files differently
        //from standalone files.
        If Assigned(fProject) And (e.InProject) Then
        Begin
            EditorUnitIndex := fProject.GetUnitFromEditor(e);
            If EditorUnitIndex = -1 Then
                MessageDlg(Format(Lang[ID_ERR_SAVEFILE], [e.FileName]),
                    mtError, [mbOk], Handle)
            Else
                Result := fProject.units[EditorUnitIndex].Save;

            If (EditorUnitIndex <> -1) And ClassBrowser1.Enabled Then
                CppParser1.ReParseFile(
                    fProject.units[EditorUnitIndex].FileName, True);
        End
        Else // stand alone file (should have fullpath in e.filename)
        Begin
            //Disable the file watch for this entry
            EditorUnitIndex := devFileMonitor.Files.IndexOf(e.FileName);
            If EditorUnitIndex <> -1 Then
            Begin
                devFileMonitor.Files.Delete(EditorUnitIndex);
                devFileMonitor.Refresh(False);
            End;

            //Add the newline at the end of file if we were told to do so
            If devEditor.AppendNewline Then
                With e.Text Do
                    If Lines.Count > 0 Then
                        If Lines[Lines.Count - 1] <> '' Then
                            Lines.Add('');

            //And commit the file to disk
           { if (e.Text.CodeFolding.Enabled) then
	         begin	 
	           //e.Text.ReScanForFoldRanges;
	           e.Text.UncollapsedLines.SaveToFile(e.FileName);
	         end	 
	         else	 
	         begin  }
            e.Text.Lines.SaveToFile(e.FileName);
              //  end;

            e.Modified := False;

            //Re-enable the file watch
            devFileMonitor.Files.Add(e.FileName);
            devFileMonitor.Refresh(False);

            If ClassBrowser1.Enabled Then
                CppParser1.ReParseFile(e.FileName, False);
            Result := True;
        End;
    End;
End;


Function TMainForm.SaveFile(e: TEditor): Boolean;
Begin
    Result := True;

    If Not assigned(e) Then
        exit;

  {$IFDEF PLUGIN_BUILD}
    If (e.AssignedPlugin <> '') Then
        plugins[unit_plugins[e.AssignedPlugin]].SaveFile(e.FileName)
    Else
   {$ENDIF}
        Result := SaveFileInternal(e);

End;

Function TMainForm.AskBeforeClose(e: TEditor; Rem: Boolean;
    Var Saved: Boolean): Boolean;
Var
    s: String;
Begin
    result := True;
    If Not e.Modified Then
        exit;

    If e.FileName = '' Then
        s := e.TabSheet.Caption
    Else
        s := e.FileName;

    Saved := False;
    Case MessageDlg(format(Lang[ID_MSG_ASKSAVECLOSE], [s]),
            mtConfirmation, mbYesNoCancel, 0) Of
        mrYes:
        Begin
            Result := SaveFile(e);
            Saved := True;
        End;
        mrNo:
        Begin
            result := True;
            If Rem And assigned(fProject) And e.New And (Not e.IsRes) And
                (e.InProject) Then
                fProject.Remove(fProject.GetUnitFromString(s), False);
        End;
        mrCancel:
            result := False;
    End;
End;

Procedure TMainForm.CloseEditorInternal(eX: TEditor);
Begin
    If Not eX.InProject Then
    Begin
        dmMain.AddtoHistory(eX.FileName);
        eX.Close;
    End
    Else
    Begin
        If eX.IsRes Or (Not Assigned(fProject)) Then
        Begin
            eX.Close;
        End
        Else
        If assigned(fProject) Then
            fProject.CloseUnit(fProject.Units.Indexof(eX));
    End;
End;

Function TMainForm.CloseEditor(index: Integer; Rem: Boolean;
    all: Boolean = False): Boolean;
Var
    e: TEditor;
    Saved: Boolean;
    intActivePage, i: Integer;
Begin
    Saved := False;
    Result := False;
    e := GetEditor(index);
    If Not assigned(e) Then
        exit;
    If Not AskBeforeClose(e, Rem, Saved) Then
        Exit;
    Result := True;

{$IFDEF PLUGIN_BUILD}
    If (e.AssignedPlugin <> '') And (all = False) Then
    Begin
        If Not plugins[unit_plugins[e.AssignedPlugin]].SaveFileAndCloseEditor(e.FileName) Then
            CloseEditorInternal(e);
    End
    Else
{$ENDIF}
        CloseEditorInternal(e);

    PageControl.OnChange(PageControl);
    If (ClassBrowser1.ShowFilter = sfCurrent) Or Not Assigned(fProject) Then
        ClassBrowser1.Clear;

    If (PageControl.PageCount = 0) Then   // If there are no more open editors
        ToggleExecuteMenu(False);

    // EAB: fix tab names
    PageControl.Refresh;
End;

Procedure TMainForm.ToggleBookmarkClick(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    With Sender As TMenuItem Do
        If assigned(e) Then
        Begin
            Checked := Not Checked;
            If (Parent = ToggleBookmarksItem) Then
                TogglebookmarksPopItem.Items[Tag - 1].Checked := Checked
            Else
                TogglebookmarksItem.Items[Tag - 1].Checked := Checked;
            If Checked Then
                e.Text.SetBookMark(Tag, e.Text.CaretX, e.Text.CaretY)
            Else
                e.Text.ClearBookMark(Tag);
        End;
End;

Procedure TMainForm.GotoBookmarkClick(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If assigned(e) Then
        e.Text.GotoBookMark((Sender As TMenuItem).Tag);
End;

Procedure TMainForm.ToggleBtnClick(Sender: TObject);
Var
    e: TEditor;
    pt: TPoint;
Begin
    e := GetEditor;
    If assigned(e) Then
    Begin
        pt := tbSpecials.ClientToScreen(point(Togglebtn.Left,
            Togglebtn.Top + togglebtn.Height));
        TrackPopupMenu(ToggleBookmarksItem.Handle, TPM_LEFTALIGN Or
            TPM_LEFTBUTTON,
            pt.x, pt.y, 0, Self.Handle, Nil);
    End;
End;

Procedure TMainForm.GotoBtnClick(Sender: TObject);
Var
    pt: TPoint;
Begin
    If PageControl.ActivePageIndex > -1 Then
    Begin
        pt := tbSpecials.ClientToScreen(point(Gotobtn.Left,
            Gotobtn.Top + Gotobtn.Height));
        TrackPopupMenu(GotoBookmarksItem.Handle, TPM_LEFTALIGN Or
            TPM_LEFTBUTTON,
            pt.x, pt.y, 0, Self.Handle, Nil);
    End;
End;

Procedure TMainForm.NewAllBtnClick(Sender: TObject);
Var
    pt: TPoint;
Begin
    pt := tbSpecials.ClientToScreen(point(NewAllBtn.Left,
        NewAllbtn.Top + NewAllbtn.Height));
    TrackPopupMenu(mnuNew.Handle, TPM_LEFTALIGN Or TPM_LEFTBUTTON,
        pt.X, pt.y, 0, Self.Handle, Nil);
End;

Procedure TMainForm.MRUClick(Sender: TObject);
Var
    s: String;
 {$IFDEF PLUGIN_BUILD}
    i: Integer;
{$ENDIF}
Begin
    s := dmMain.MRU[(Sender As TMenuItem).Tag];
    If GetFileTyp(s) = utPrj Then
        OpenProject(s)
    Else
    Begin
{$IFDEF PLUGIN_BUILD}
        chdir(ExtractFileDir(s));
        For i := 0 To pluginsCount - 1 Do
            plugins[i].OpenFile(s);
{$ENDIF}
        OpenFile(s);
    End;
End;

Procedure TMainForm.CodeInsClick(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If assigned(e) Then
        e.InsertString(dmMain.CodeInserts[
            (Sender As TMenuItem).Tag].Line, True);
End;

Procedure TMainForm.SurroundString(e: TEditor; strStart, strEnd: String);
Var
    I: Integer;
    startXY, endXY: TBufferCoord;
    strLstToPaste: TStringList;
Begin
    If Not assigned(e) Then
        exit;

    strLstToPaste := TStringList.Create;
    Try

        strLstToPaste.Add(strStart);   // Add start string

        If e.Text.SelAvail Then
        Begin

            e.Text.BeginUndoBlock;

       {  if (e.Text.CodeFolding.Enabled) then
         begin

              e.Text.UncollapsedLines.BeginUpdate;
         end
            else
            begin }
            e.Text.BeginUpdate;
      //  end;

            startXY := e.Text.BlockBegin;
            endXY := e.Text.BlockEnd;

            // Add selected text
            For I := startXY.Line - 1 To endXY.Line - 1 Do    // Iterate
            Begin
                strLstToPaste.Add(e.Text.Lines[i]);
            End;

        End
        Else
        Begin
            startXY.Line := e.Text.CaretY;
        End;

        // Add end string
        strLstToPaste.Add(strEnd);

        // Replace selected text with our modified text
        e.Text.SelText := strLstToPaste.Text;

      {  if (e.Text.CodeFolding.Enabled) then
         begin

              e.Text.UncollapsedLines.EndUpdate;
         end
            else
            begin    }
        e.Text.EndUpdate;
      //  end;

        e.Text.EndUndoBlock;
        e.Text.UpdateCaret;
        e.Text.Modified := True;

    Finally

        strLstToPaste.Free;
    End;

End;

Procedure TMainForm.SurroundWithClick(Sender: TObject);
Var
    e: TEditor;
Begin

    e := GetEditor;
    If Not Assigned(e) Then
        Exit;

    Case TMenuItem(Sender).Tag Of
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
            e.CommentSelection;

    End;    // case
End;

Procedure TMainForm.ToolItemClick(Sender: TObject);
Var
    idx: Integer;
Begin
    idx := (Sender As TMenuItem).Tag;
    With fTools.ToolList[idx]^ Do
        ExecuteFile(ParseParams(Exec), ParseParams(Params),
            ParseParams(WorkDir), SW_SHOW);
End;

Procedure TMainForm.OpenProject(s: String);
Var
    s2: String;
Begin
    If assigned(fProject) Then
    Begin
        If fProject.Name = '' Then
            s2 := fProject.FileName
        Else
            s2 := fProject.Name;
        If (MessageDlg(format(Lang[ID_MSG_CLOSEPROJECTPROMPT], [s2]),
            mtConfirmation, [mbYes, mbNo], 0) = mrYes) Then
        Begin
            //Some freaking unknown error
            //I dont know where all the editors are
            //freed. So I save the layout and close the
            //project. Any help in fixing this is greatly appreciated.
            fProject.SaveLayout;
            //actCloseAll.Execute;
            actCloseProject.Execute;
        End
        Else
            exit;
    End;
    bProjectLoading := True;
    alMain.State := asSuspended;
    Try
        fProject := TProject.Create(s, DEV_INTERNAL_OPEN);
        If fProject.FileName <> '' Then
        Begin
            fCompiler.Project := fProject;
            fCompiler.RunParams := fProject.CmdLineArgs;
            fCompiler.Target := ctProject;

            dmMain.RemoveFromHistory(s);
            // if project manager isn't open then open it
            If (Not ShowProjectInspItem.Checked) And (Not fFirstShow) Then
                ShowProjectInspItem.OnClick(Self);

            CheckForDLLProfiling;
            UpdateAppTitle;
            ScanActiveProject;
        End
        Else
        Begin
            fProject.Free;
            fProject := Nil;
        End;
    Finally
        bProjectLoading := False;
        alMain.State := asNormal;
    End;
    RefreshTodoList;
End;

Procedure TMainForm.OpenFile(s: String; withoutActivation: Boolean);
Var
    e: TEditor;
    idx: Integer;
Begin

    If s = '' Then
        exit;

    If s[length(s)] = '.' Then
        // correct filename if the user gives an alone dot to force the no extension
        s[length(s)] := #0;
    idx := FileIsOpen(s);
    If (idx <> -1) Then
    Begin
        If Not withoutActivation Then
            GetEditor(idx).Activate;
        exit;
    End;

    If Not FileExists(s) Then
    Begin
        Application.MessageBox(Pchar(Format(Lang[ID_ERR_FILENOTFOUND],
            [s])), 'Error', MB_ICONHAND);
        Exit;
    End;

    e := TEditor.Create;
    e.Init(False, ExtractFileName(s), s, True);
    If assigned(fProject) Then
    Begin
        If (fProject.FileName <> s) And
            (fProject.GetUnitFromString(s) = -1) Then
            dmMain.RemoveFromHistory(s);
    End
    Else
        dmMain.RemoveFromHistory(s);

    If Not withoutActivation Then
        e.activate;
    If Not assigned(fProject) Then
        CppParser1.ReParseFile(e.FileName, e.InProject, True);
    RefreshTodoList;
End;

Procedure TMainForm.AddFindOutputItem(line, col, unit_, message: String);
Var
    ListItem: TListItem;
Begin
    ListItem := FindOutput.Items.Add;
    ListItem.Caption := line;
    ListItem.SubItems.Add(col);
    ListItem.SubItems.Add(unit_);
    ListItem.SubItems.Add(message);
End;

Function TMainForm.ParseParams(s: String): String;
Resourcestring
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

Var
    e: TEditor;
Begin
    e := GetEditor;
    // <DEFAULT>
    s := StringReplace(s, cDefault, devDirs.Default, [rfReplaceAll]);

    // <EXECPATH>
    s := Stringreplace(s, cExecDir, devDirs.Exec, [rfReplaceAll]);

    // <DEVCPPVERISON>
    s := StringReplace(s, cDevVer, DEVCPP_VERSION, [rfReplaceAll]);

    If assigned(fProject) Then
    Begin
        // <EXENAME>
        s := StringReplace(s, cEXEName, fProject.Executable, [rfReplaceAll]);

        // <PROJECTNAME>
        s := StringReplace(s, cPrjName, fProject.Name, [rfReplaceAll]);

        // <PROJECTFILE>
        s := StringReplace(s, cPrjFile, fProject.FileName, [rfReplaceAll]);

        // <PROJECTPATH>
        s := StringReplace(s, cPrjPath, fProject.Directory, [rfReplaceAll]);

        If Assigned(e) Then
        Begin
            // <SOURCENAME>
            s := StringReplace(s, cCurSrc, e.FileName, [rfReplaceAll]);
            // <SOURCEPATH>
            If e.FileName = '' Then
                s := StringReplace(s, cSrcPath, devDirs.Default,
                    [rfReplaceAll])
            Else
                s := StringReplace(s, cSrcPath, ExtractFilePath(e.FileName),
                    [rfReplaceAll]);
        End;

        // <SOURCESPCLIST>
        s := StringReplace(s, cSrcList, fProject.ListUnitStr(' '),
            [rfReplaceAll]);
    End
    Else
    If assigned(e) Then
    Begin
        // <EXENAME>
        // GAR 10 Nov 2009
        // Hack for Wine/Linux
        // ProductName returns empty string for Wine/Linux
        // for Windows, it returns OS name (e.g. Windows Vista).
        If (JvComputerInfoEx1.OS.ProductName = '') Then
            s := StringReplace(s, cEXEName, ChangeFileExt(e.FileName,
                ''), [rfReplaceAll])
        Else
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
        If e.FileName = '' Then
            s := StringReplace(s, cSrcPath, devDirs.Default, [rfReplaceAll])
        Else
            s := StringReplace(s, cSrcPath,
                ExtractFilePath(e.FileName), [rfReplaceAll]);

        // <WORDXY>
        s := StringReplace(s, cWordXY, e.GetWordAtCursor, [rfReplaceAll]);
    End;

    // clear unchanged macros

    If Not assigned(fProject) Then
        s := StringReplace(s, cSrcList, '', [rfReplaceAll]);

    If Not assigned(e) Then
    Begin
        s := StringReplace(s, cCurSrc, '', [rfReplaceAll]);
        s := StringReplace(s, cWordXY, '', [rfReplaceAll]);
        // if no editor assigned return users default directory
        s := StringReplace(s, cSrcPath, devDirs.Default, [rfReplaceAll]);
    End;

    If Not assigned(fProject) And Not assigned(e) Then
    Begin
        s := StringReplace(s, cEXEName, '', [rfReplaceAll]);
        s := StringReplace(s, cPrjName, '', [rfReplaceAll]);
        s := StringReplace(s, cPrjFile, '', [rfReplaceAll]);
        s := StringReplace(s, cPrjPath, '', [rfReplaceAll]);
    End;

    Result := s;
End;

Procedure TMainForm.HelpItemClick(Sender: TObject);
Var
    idx: Integer;
    aFile: String;
Begin
    idx := (Sender As TMenuItem).Tag;
    If idx >= fHelpFiles.Count Then
        exit;
    aFile := fHelpFiles.Values[idx];

    If AnsiPos(HTTP, aFile) = 1 Then
        ExecuteFile(aFile, '', devDirs.Help, SW_SHOW)
    Else
    Begin
        aFile := ValidateFile(aFile, devDirs.Exec, True);
        If AnsiPos(':\', aFile) = 0 Then
            aFile := ExpandFileto(aFile, devDirs.Exec);
        ExecuteFile(aFile, '', ExtractFilePath(aFile), SW_SHOW);
    End;
    //Application.HelpFile := aFile;
    // moving this to WordToHelpKeyword
    // it's annoying to display the index when the topic has been found and is already displayed...
    //    Application.HelpCommand(HELP_FINDER, 0);
    //WordToHelpKeyword;
End;

Procedure TMainForm.CompOutputProc(Const _Line, _Unit, _Message: String);
Begin
    With CompilerOutput.Items.Add Do
    Begin
        Caption := _Line;
        SubItems.Add(GetRealPath(_Unit));
        SubItems.Add(_Message);
    End;
    TotalErrors.Text := IntToStr(fCompiler.ErrorCount);
    ShowDockForm(frmReportDocks[cCompTab]);
End;

Procedure TMainForm.CompResOutputProc(Const _Line, _Unit, _Message: String);
Begin
    If (_Line <> '') And (_Unit <> '') Then
        ResourceOutput.Items.Add('Line ' + _Line + ' in file ' +
            _Unit + ' : ' + _Message)
    Else
        ResourceOutput.Items.Add(_Message);
End;

Procedure TMainForm.CompSuccessProc(Const messages: Integer);
Var
    F: TSearchRec;
    HasSize: Boolean;
    I: Integer;
Begin
    If fCompiler.ErrorCount = 0 Then
    Begin
        TotalErrors.Text := '0';
        HasSize := False;
        If Assigned(fProject) Then
        Begin
            FindFirst(fProject.Executable, faAnyFile, F);
            HasSize := FileExists(fProject.Executable);
        End
        Else
        If PageControl.PageCount > 0 Then
        Begin
            // GAR 10 Nov 2009
            // Hack for Wine/Linux
            // ProductName returns empty string for Wine/Linux
            // for Windows, it returns OS name (e.g. Windows Vista).
            If (MainForm.JvComputerInfoEx1.OS.ProductName = '') Then
            Begin
                FindFirst(ChangeFileExt(GetEditor.FileName, ''), faAnyFile, F);
                HasSize := FileExists(ChangeFileExt(GetEditor.FileName, ''));
            End
            Else
            Begin
                FindFirst(ChangeFileExt(GetEditor.FileName, EXE_EXT),
                    faAnyFile, F);
                HasSize :=
                    FileExists(ChangeFileExt(GetEditor.FileName, EXE_EXT));
            End;
        End;
        If HasSize Then
        Begin
            SizeFile.Text := IntToStr(F.Size) + ' ' + Lang.Strings[ID_BYTES];
            If F.Size > 1024 Then
                SizeFile.Text := SizeFile.Text + ' (' +
                    IntToStr(F.Size Div 1024) + ' KB)';
        End
        Else
            SizeFile.Text := '0';
    End
    Else
    Begin
        // errors exist; goto first one...
        For I := 0 To CompilerOutput.Items.Count - 1 Do
            If StrToIntDef(CompilerOutput.Items[I].Caption, -1) <> -1 Then
            Begin
                CompilerOutput.Selected := CompilerOutput.Items[I];
                CompilerOutputDblClick(Nil);
                Break;
            End;
    End;
End;

Procedure TMainForm.LogEntryProc(Const msg: String);
Begin
    LogOutput.Lines.Add(msg);
End;

Procedure TMainform.MainSearchProc(Const SR: TdevSearchResult);
Var
    s: String;
    I: Integer;
Begin
    // change all chars below #32 to #32 (non-printable to printable)
    S := SR.msg;
    For I := 1 To Length(S) Do
        If S[I] < #32 Then
            S[I] := #32;

    AddFindOutputItem(inttostr(SR.pt.X), inttostr(SR.pt.y), SR.InFile, S);
End;

Procedure TMainForm.ProjectViewContextPopup(Sender: TObject;
    MousePos: TPoint; Var Handled: Boolean);
Var
    pt: TPoint;
    Node: TTreeNode;
Begin
    If Not assigned(fProject) Or devData.FullScreen Then
        exit;
    pt := ProjectView.ClientToScreen(MousePos);
    Node := ProjectView.GetNodeAt(MousePos.X, MousePos.Y);
    If Not assigned(Node) Then
        exit;
    ProjectView.Selected := Node;
    If Node.Level = 0 Then
        ProjectPopup.Popup(pt.x, pt.Y)
    Else
    Begin
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
    End;
    Handled := True;
End;

Procedure TMainForm.OpenUnit;
Var
    Node: TTreeNode;
    i: Integer;
    pt: TPoint;
    e: TEditor;
    AlreadyActivated: Boolean;
Begin
    AlreadyActivated := False;
    If assigned(ProjectView.Selected) Then
        Node := ProjectView.Selected
    Else
    Begin
        pt := ProjectView.ScreenToClient(Mouse.CursorPos);
        Node := ProjectView.GetNodeAt(pt.x, pt.y);
    End;
    If assigned(Node) And (Integer(Node.Data) <> -1) Then
        If (Node.Level >= 1) Then
        Begin
            i := Integer(Node.Data);
{$IFDEF PLUGIN_BUILD}
            //This will allow DevC++ to open custom program
            //as assigned by the user like VC++
            If OpenWithAssignedProgram(fProject.Units[i].FileName) = True Then
                Exit;
{$ENDIF}
            FileIsOpen(fProject.Units[i].FileName, True);
{$IFDEF PLUGIN_BUILD}
            If isFileOpenedinEditor(fProject.Units[i].FileName) Then
                e := GetEditorFromFileName(fProject.Units[i].FileName)
            Else
{$ENDIF}
                e := fProject.OpenUnit(i);
            If assigned(e) Then
            Begin
{$IFDEF PLUGIN_BUILD}
                If (e.AssignedPlugin <> '') Then
                    plugins[unit_plugins[e.AssignedPlugin]].OpenUnit(
                        e.FileName);
{$ENDIF}
                If AlreadyActivated = False Then
                    e.Activate;

            End;
        End;

    ToggleExecuteMenu(True);

End;

Procedure TMainForm.ProjectViewClick(Sender: TObject);
Var
    e: TEditor;
Begin
    If devData.DblFiles Then
        exit;
    If Not Assigned(ProjectView.Selected) Then
        Exit;
    If ProjectView.Selected.Data <> Pointer(-1) Then
        OpenUnit
    Else
    Begin
        e := GetEditor;
        If Assigned(e) Then
            e.Activate;
    End;
End;

Procedure TMainForm.ProjectViewDblClick(Sender: TObject);
Begin
    If Not devData.dblFiles Then
        exit;
    OpenUnit;
End;

Procedure TMainForm.HelpBtnClick(Sender: TObject);
Var
    pt: TPoint;
Begin
    pt := tbOptions.ClientToScreen(point(HelpBtn.Left, Helpbtn.Top +
        Helpbtn.Height));
    HelpPop.Popup(pt.X, pt.Y);
End;

Procedure TMainForm.InsertBtnClick(Sender: TObject);
Var
    pt: TPoint;
Begin
    If PageControl.ActivePageIndex > -1 Then
    Begin
        pt := tbSpecials.ClientToScreen(point(Insertbtn.Left,
            Insertbtn.Top + Insertbtn.Height));
        TrackPopupMenu(InsertItem.Handle, TPM_LEFTALIGN Or TPM_LEFTBUTTON,
            pt.X, pt.Y, 0, Self.Handle, Nil);
    End;
End;

Procedure TMainForm.Customize1Click(Sender: TObject);
Begin
    With TfrmHelpEdit.Create(Self) Do
        Try
            If Execute Then
                BuildHelpMenu;
        Finally
            Free;
        End;
End;

Procedure TMainForm.actNewSourceExecute(Sender: TObject);
Var
    NewEditor: TEditor;
Begin
    If assigned(fProject) Then
    Begin
        Case MessageDlg(Lang[ID_MSG_NEWFILE], mtConfirmation,
                [mbYes, mbNo, mbCancel], 0) Of
            mrYes:
            Begin
                actProjectNewExecute(Sender);
                exit;
            End;
            mrCancel:
                exit;
        End;
    End;
    NewEditor := TEditor.Create;
    NewEditor.init(False, Lang[ID_UNTITLED] + inttostr(dmMain.GetNum),
        '', False);
    NewEditor.InsertDefaultText;
    NewEditor.Activate;
End;

Procedure TMainForm.actNewProjectExecute(Sender: TObject);
Var
    s: String;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
{$ENDIF}
Begin
    With TNewProjectForm.Create(Self) Do
        Try
            rbCpp.Checked := devData.DefCpp;
            rbC.Checked := Not rbCpp.Checked;
            If ShowModal = mrOk Then
            Begin
                If (cbDefault.Checked) Then
                    devData.DefCpp := rbCpp.Checked;
                If assigned(fProject) Then
                Begin
                    If fProject.Name = '' Then
                        s := fProject.FileName
                    Else
                        s := fProject.Name;
                    If MessageDlg(format(Lang[ID_MSG_CLOSECREATEPROJECT], [s]),
                        mtConfirmation,
                        [mbYes, mbNo], 0) = mrYes Then
                        actCloseProject.Execute
                    Else
                    Begin
                        Dec(dmMain.fProjectCount);
                        Exit;
                    End;
                End;
                s := edProjectName.Text + DEV_EXT;
                With dmMain.SaveDialog Do
                Begin
                    Filter := FLT_PROJECTS;
                    InitialDir := devDirs.Default;
                    FileName := s;

                    If Not Execute Then
                    Begin
                        Dec(dmMain.fProjectCount);
                        Exit;
                    End;
                    s := FileName;
                    If FileExists(s) Then
                    Begin
                        If MessageDlg(Lang[ID_MSG_FILEEXISTS],
                            mtWarning, [mbYes, mbNo], 0) = mrYes Then
                        Begin
                            DeleteFile(s);
                            Dec(dmMain.fProjectCount);
                        End
                        Else
                            Exit;
                    End;
                End;

                fProject := TProject.Create(s, edProjectName.Text);
                If Not fProject.AssignTemplate(s, GetTemplate) Then
                Begin
                    fProject.Free;
                    MessageBox(Self.Handle, Pchar(Lang[ID_ERR_TEMPLATE]),
                        Pchar(Lang[ID_ERROR]), MB_OK Or MB_ICONERROR);
                    Exit;
                End;
                fCompiler.Project := fProject;


{$IFDEF PLUGIN_BUILD}
                activePluginProject := fProject.AssociatedPlugin;
                If activePluginProject <> '' Then
                    plugins[unit_plugins[activePluginProject]].NewProject(
                        GetTemplate.Name);
{$ENDIF}

                devCompiler.CompilerSet := fProject.CurrentProfile.CompilerSet;
                devCompilerSet.LoadSet(fProject.CurrentProfile.CompilerSet);
                devCompilerSet.AssignToCompiler;
                devCompiler.OptionStr :=
                    fProject.CurrentProfile.CompilerOptions;

                If Not ShowProjectInspItem.Checked Then
                    ShowProjectInspItem.OnClick(self);
                UpdateAppTitle;
            End;
        Finally
            Free;
        End;
End;

Procedure TMainForm.actNewResExecute(Sender: TObject);
Var
    NewEditor: TEditor;
    InProject: Boolean;
    fname: String;
    res: TTreeNode;
    NewUnit: TProjUnit;
Begin
    If Assigned(fProject) Then
        InProject := Application.MessageBox(Pchar(
            Lang[ID_MSG_NEWRES]), 'New Resource', MB_ICONQUESTION +
            MB_YESNO) = mrYes
    Else
        InProject := False;

    fname := Lang[ID_UNTITLED] + inttostr(dmMain.GetNum) + '.rc';
    NewEditor := TEditor.Create;
    NewEditor.init(InProject, fname, '', False, True);
    NewEditor.Activate;

    If InProject And Assigned(fProject) Then
    Begin
        res := fProject.FolderNodeFromName('Resources');
        NewUnit := fProject.AddUnit(fname, res, True);
        NewUnit.Editor := NewEditor;
    End;
    // new editor with resource file
End;

Procedure TMainForm.actNewTemplateExecute(Sender: TObject);
Begin
    // change to save cur project as template maybe?
    NewTemplateForm := TNewTemplateForm.Create(Self);
    With NewTemplateForm Do
    Begin
        TempProject := fProject;
        ShowModal;
    End;
End;


Procedure TMainForm.actOpenExecute(Sender: TObject);
Var
    idx,
    prj: Integer;
    flt: String;
{$IFDEF PLUGIN_BUILD}
    filters: TStringList;
    built: Boolean;
    j, I: Integer;
{$ENDIF}
Begin


    built := False;
    prj := -1;
    flt := '';
    BuildFilter(flt, ftOpen);

    With dmMain.OpenDialog Do
    Begin
        Filter := flt;
        Title := Lang[ID_NV_OPENFILE];
        If Execute Then
            If Files.Count > 0 Then // multi-files?
            Begin
                For idx := 0 To pred(Files.Count) Do // find .dev file
                    If AnsiCompareText(ExtractFileExt(Files[idx]),
                        DEV_EXT) = 0 Then
                    Begin
                        prj := idx;
                        break;
                    End;
                If prj = -1 Then // not found
                Begin
                    chdir(ExtractFileDir(Files[0]));
                    For idx := 0 To pred(Files.Count) Do
                    Begin
{$IFDEF PLUGIN_BUILD}
                        For j := 0 To pluginsCount - 1 Do
                            plugins[j].OpenFile(Files[idx]);
{$ENDIF}
                        OpenFile(Files[idx]); // open all files
                    End;
                End
                Else
                    OpenProject(Files[prj]); // else open found project
            End;
    End;
End;

Procedure TMainForm.actHistoryClearExecute(Sender: TObject);
Begin
    dmMain.ClearHistory;
End;

Procedure TMainForm.actSaveExecute(Sender: TObject);
Begin
    SaveFile(GetEditor);
End;

Procedure TMainForm.actSaveAsExecute(Sender: TObject);
Begin
    SaveFileAs(GetEditor);
End;

Procedure TMainForm.actSaveAllExecute(Sender: TObject);
Var
    fileLstToParse: TStringList;
    idx: Integer;
    e: TEditor;
Begin
    fileLstToParse := TStringList.Create;
    If Assigned(fProject) Then
    Begin
        fProject.Save;
        UpdateAppTitle;
        If CppParser1.Statements.Count = 0 Then
            // only scan entire project if it has not already been scanned...
            ScanActiveProject;
    End;

    For idx := 0 To pred(PageControl.PageCount) Do
    Begin
        e := GetEditor(idx);
        If e.Modified Then
        Begin
            SaveFile(GetEditor(idx));
            If ClassBrowser1.Enabled And (GetFileTyp(e.FileName) In
                [utSrc, utHead]) Then
                fileLstToParse.Add(e.FileName);
        End;
    End;

    If ClassBrowser1.Enabled Then
        For idx := 0 To fileLstToParse.Count - 1 Do
            CppParser1.ReParseFile(fileLstToParse[idx], True);
    fileLstToParse.Free;
End;

Procedure TMainForm.actCloseExecute(Sender: TObject);
Begin
    CloseEditor(PageControl.ActivePageIndex, True);
    UpdateAppTitle;
End;

Procedure TMainForm.actCloseAllExecute(Sender: TObject);
Var
    idx: Integer;
Begin
    For idx := pred(PageControl.PageCount) Downto 0 Do
        If Not CloseEditor(0, True, True) Then
            Break;

    // if no project is open, clear the parsed info...
    If Not Assigned(fProject) And (PageControl.PageCount = 0) Then
    Begin
        CppParser1.Reset;
        ClassBrowser1.Clear;
    End;
    UpdateAppTitle;
End;

Procedure TMainForm.actCloseProjectExecute(Sender: TObject);
Var
    s: String;
    i: Integer;
Begin
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
    If fProject.Modified Then
    Begin
        If fProject.Name = '' Then
            s := fProject.FileName
        Else
            s := fProject.Name;

        Case MessageDlg(format(Lang[ID_MSG_SAVEPROJECT], [s]),
                mtConfirmation, mbYesNoCancel, 0) Of
            mrYes:
                fProject.Save;
            mrNo:
                fProject.Modified := False;
            mrCancel:
                exit;
        End;
    End;

    fCompiler.Project := Nil;
    dmMain.AddtoHistory(fProject.FileName);

    i := 0;
    While i < debugger.Breakpoints.Count Do
    Begin
        If fProject.Units.Indexof(
            PBreakpoint(Debugger.Breakpoints[i])^.FileName) <> -1 Then
        Begin
            Dispose(Debugger.Breakpoints.Items[i]);
            Debugger.Breakpoints.Delete(i);
        End
        Else
            Inc(i);
    End;

    Try
        If Assigned(fProject) Then
            FreeandNil(fProject)
        Else
            fProject := Nil;
    Except
        fProject := Nil;
    End;

    ProjectView.Items.Clear;
    CompilerOutput.Items.Clear;
    FindOutput.Items.Clear;
    ResourceOutput.Clear;
    LogOutput.Clear;
    DebugOutput.Clear;

    ToggleExecuteMenu(False);

    UpdateAppTitle;
    ClassBrowser1.ProjectDir := '';
    CppParser1.Reset;
    RefreshTodoList;
End;

Procedure TMainForm.actXHTMLExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If assigned(e) Then
        e.Exportto(True);
End;

Procedure TMainForm.actXRTFExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If assigned(e) Then
        e.Exportto(False);
End;

Procedure TMainForm.actXProjectExecute(Sender: TObject);
Begin
    If assigned(fProject) Then
        fProject.Exportto(True);
End;

Procedure TMainForm.actPrintExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If assigned(e) Then
        With TPrintForm.Create(Self) Do
            Try
                If ShowModal = mrOk Then
                Begin
                    With dmMain.SynEditPrint Do
                    Begin
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
                    End;
                    devData.PrintColors := cbColors.Checked;
                    devData.PrintHighlight := cbHighlight.Checked;
                    devData.PrintWordWrap := cbWordWrap.Checked;
                    devData.PrintLineNumbers := rbLN.Checked;
                    devData.PrintLineNumbersMargins := rbLNMargin.Checked;
                End;
            Finally
                Free;
            End;
End;

Procedure TMainForm.actPrintSUExecute(Sender: TObject);
Begin
    Try
        dmMain.PrinterSetupDialog.Execute;
    Except
        MessageDlg('An error occured while trying to load the printer setup dialog. You probably have no printer installed yet', mtError, [mbOK], 0);
    End;
End;

Procedure TMainForm.actExitExecute(Sender: TObject);
Begin
    Close;
End;

Procedure TMainForm.actUndoExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If assigned(e) Then
    Begin
        e.Text.Undo;
    End;
End;

Procedure TMainForm.actRedoExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If assigned(e) Then
        e.Text.Redo;

End;

Procedure TMainForm.actCutExecute(Sender: TObject);
Var
    e: TEditor;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
    b: Boolean;
{$ENDIF}
Begin
    e := GetEditor;
    If assigned(e) Then
    Begin
{$IFDEF PLUGIN_BUILD}
        b := False;
        For i := 0 To pluginsCount - 1 Do
        Begin
            If plugins[i].IsForm(e.FileName) Then
            Begin
                plugins[i].CutExecute;
                b := True;
            End;
        End;
        If Not b Then
{$ENDIF}
            e.Text.CutToClipboard;
    End;
End;

Procedure TMainForm.actCopyExecute(Sender: TObject);
Var
    e: TEditor;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
    b: Boolean;
{$ENDIF}
Begin
    e := GetEditor;
    If assigned(e) Then
    Begin
{$IFDEF PLUGIN_BUILD}
        b := False;
        For i := 0 To pluginsCount - 1 Do
        Begin
            If plugins[i].IsForm(e.FileName) Then
            Begin
                plugins[i].CopyExecute;
                b := True;
            End;
        End;
        If Not b Then
{$ENDIF}
            e.Text.CopyToClipboard;
    End;
End;

Procedure TMainForm.actPasteExecute(Sender: TObject);
Var
    e: TEditor;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
    b: Boolean;
{$ENDIF}
Begin
    e := GetEditor;
    If assigned(e) Then
    Begin
   {$IFDEF PLUGIN_BUILD}
        b := False;
        For i := 0 To pluginsCount - 1 Do
        Begin
            If plugins[i].IsForm(e.FileName) Then
            Begin
                plugins[i].PasteExecute;
                b := True;
            End;
        End;
        If Not b Then
    {$ENDIF}
            If e.Text.Focused Then
                e.Text.PasteFromClipboard
            Else
                SendMessage(GetFocus, WM_PASTE, 0, 0);
    End
    Else
        SendMessage(GetFocus, WM_PASTE, 0, 0);

    e.Text.Refresh;
End;

Procedure TMainForm.actSelectAllExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    If LogOutput.Focused Then
        LogOutput.SelectAll
    Else
    If DebugOutput.Focused Then
        DebugOutput.SelectAll
    Else
    Begin
        e := GetEditor;
        If assigned(e) Then
            e.Text.SelectAll;
    End;
End;

Procedure TMainForm.actDeleteExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If assigned(e) Then
        If e.Text.SelAvail Then
            e.Text.ClearSelection;
End;

Procedure TMainForm.actDeleteLineExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If assigned(e) Then
    Begin
        e.Text.ExecuteCommand(507, Char('0'), Pointer(0));
        // 507: delete line
    End;
End;

Procedure TMainForm.actStatusbarExecute(Sender: TObject);
Begin
    devData.Statusbar := actStatusbar.Checked;
    Statusbar.Visible := actStatusbar.Checked;
    Statusbar.Top := Self.ClientHeight;
End;

Procedure TMainForm.btnFullScrRevertClick(Sender: TObject);
Begin
    actFullScreen.Execute;
End;

Procedure TMainForm.actFullScreenExecute(Sender: TObject);
Var
    I: Integer;
Begin
    devData.FullScreen := FullScreenModeItem.Checked;
    If devData.FullScreen Then
    Begin
        OldLeft := Left;
        OldTop := Top;
        OldWidth := Width;
        OldHeight := Height;
        GetWindowPlacement(Self.Handle, @devData.WindowPlacement);
        self.Visible := False;

        SetWindowLong(Self.Handle, GWL_STYLE,
            (WS_BORDER And GetWindowLong(Self.Handle, GWL_STYLE)) And
            Not WS_CAPTION);

        FullScreenModeItem.Caption := Lang[ID_ITEM_FULLSCRBACK];
        ControlBar1.Visible := devData.ShowBars;
        pnlFull.Visible := True;

        Menu := Nil; // get rid of that annoying flickering effect
        // disable the top-level menus in MainMenu
        For I := 0 To MainMenu.Items.Count - 1 Do
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

        self.Visible := True;
    End
    Else
    Begin
        self.Visible := False;
        Left := OldLeft;
        Top := OldTop;
        Width := OldWidth;
        Height := OldHeight;
        // enable the top-level menus in MainMenu
        // before shown on screen to avoid flickering
        For I := 0 To MainMenu.Items.Count - 1 Do
            MainMenu.Items[I].Visible := True;

        FullScreenModeItem.Caption := Lang[ID_ITEM_FULLSCRMODE];
        Controlbar1.Visible := True;

        pnlFull.Visible := False;

        // Return bounds to normal screen
        // Bug # 2945056
        SetBounds(
            Monitor.WorkAreaRect.Left,
            Monitor.WorkAreaRect.Top,
            Monitor.Width,
            Monitor.Height);

        SetWindowLong(self.Handle, GWL_STYLE, WS_TILEDWINDOW Or
            (GetWindowLong(Self.Handle, GWL_STYLE)));
        SetWindowPlacement(Self.Handle, @devData.WindowPlacement);

        self.Visible := True;
    End;
End;

Procedure TMainForm.actNextExecute(Sender: TObject);
Begin
    PageControl.SelectNextPage(True);
End;

Procedure TMainForm.actPrevExecute(Sender: TObject);
Begin
    PageControl.SelectNextPage(False);
End;

Procedure TMainForm.actCompOptionsExecute(Sender: TObject);
{$IFDEF PLUGIN_BUILD}
Var
    i: Integer;
    tabs: TTabSheet;
{$ENDIF PLUGIN_BUILD}
Begin
    With TCompForm.Create(Self) Do
        Try
            // EAB to fix: problem here if changed parent window
{$IFDEF PLUGIN_BUILD}
            For i := 0 To packagesCount - 1 Do
            Begin
                tabs := (plugins[delphi_plugins[i]] As
                    IPlug_In_BPL).Retrieve_CompilerOptionsPane;
                If tabs <> Nil Then
                Begin
                    tabs.PageControl := MainPages;
                    MainPages.ActivePage := tabs;
                End;
            End;
            MainPages.ActivePage := tabCompiler;
{$ENDIF PLUGIN_BUILD}
            ShowModal;
            CheckForDLLProfiling;
        Finally
            Free;
        End;
End;

Procedure TMainForm.actEditorOptionsExecute(Sender: TObject);
Var
    idx: Integer;
    pt: TPoint;
Begin
    With TEditorOptForm.Create(Self) Do
        Try
            If ShowModal = mrOk Then
            Begin
                dmMain.UpdateHighlighter;
                For idx := 0 To pred(PageControl.PageCount) Do
                    With TEditor(PageControl.Pages[idx].Tag) Do
                    Begin
                        // update the selected text color
                        StrtoPoint(pt, devEditor.Syntax.Values[cSel]);
                        Text.SelectedColor.Background := pt.X;
                        Text.SelectedColor.Foreground := pt.Y;

                        devEditor.AssignEditor(Text);
                        Text.Highlighter := dmMain.GetHighlighter(FileName);
                        ReconfigCompletion;
                    End;
                InitClassBrowser(chkCCCache.Tag = 1);
                If CppParser1.Statements.Count = 0 Then
                    ScanActiveProject;
                If GetEditor <> Nil Then
                Begin
                    GetEditor.Activate;
                End;
            End;
        Finally
            Free;
        End;
End;

Procedure TMainForm.actConfigToolsExecute(Sender: TObject);
Begin
    fTools.Edit;
End;

Procedure TMainForm.actUnitRemoveExecute(Sender: TObject);
Var
    idx: Integer;
    node: TTreeNode;
Begin
    If Not assigned(fProject) Then
        exit;


    While ProjectView.SelectionCount > 0 Do
    Begin
        node := ProjectView.Selections[0];

        If Not assigned(node) Or
            (node.Level < 1) Then
            Continue;
        If node.Data = Pointer(-1) Then
            Continue;

        idx := Integer(node.Data);

        If Not fProject.Remove(idx, True) Then
            exit;
    End;
End;

Procedure TMainForm.actUnitRenameExecute(Sender: TObject);
Var
    idx: Integer;
    oldName,
    NewName: String;
Begin
    If Not assigned(fProject) Then
        exit;
    If Not assigned(ProjectView.Selected) Or
        (ProjectView.Selected.Level < 1) Then
        Exit;

    If ProjectView.Selected.Data = Pointer(-1) Then
        Exit;

    idx := Integer(ProjectView.Selected.Data);
    OldName := fProject.Units[idx].FileName;
    NewName := ExtractFileName(OldName);

    If InputQuery(Lang[ID_RENAME], Lang[ID_MSG_FILERENAME], NewName) And
        (ExtractFileName(NewName) <> '') And
        (NewName <> OldName) Then
        Try
            chdir(ExtractFilePath(OldName));

            // change in project first so on failure
            // file isn't already renamed
            fProject.SaveUnitAs(idx, ExpandFileto(NewName, GetCurrentDir));
            Renamefile(OldName, NewName);
        Except
            MessageDlg(format(Lang[ID_ERR_RENAMEFILE], [OldName]),
                mtError, [mbok], 0);
        End;
End;

Procedure TMainForm.actUnitOpenExecute(Sender: TObject);
Var
    idx, idx2: Integer;
Begin
    If Not assigned(fProject) Then
        exit;
    If Not assigned(ProjectView.Selected) Or
        (ProjectView.Selected.Level < 1) Then
        exit;
    If ProjectView.Selected.Data = Pointer(-1) Then
        Exit;
    idx := Integer(ProjectView.Selected.Data);
    idx2 := FileIsOpen(fProject.Units[idx].FileName, True);
    If idx2 > -1 Then
        GetEditor(idx2).Activate
    Else
        fProject.OpenUnit(idx);
End;

Procedure TMainForm.actUnitCloseExecute(Sender: TObject);
Var
    idx: Integer;
Begin
    If assigned(fProject) And assigned(ProjectView.Selected) Then
    Begin
        idx := FileIsOpen(fProject.Units[Integer(ProjectView.Selected.Data)].FileName, True);
        If idx > -1 Then
            CloseEditor(idx, True);
    End;
End;

Procedure TMainForm.actUpdateCheckExecute(Sender: TObject);
Var s: String;
Begin
    //WebUpdateForm.Show;
    s := IncludeTrailingPathDelimiter(devDirs.Exec) + UPDATE_PROGRAM;
    ExecuteFile(s, '', IncludeTrailingPathDelimiter(devDirs.Exec), SW_SHOW);
End;

Procedure TMainForm.actAboutExecute(Sender: TObject);
Begin
    With TAboutForm.Create(Self) Do
        Try
            ShowModal;
        Finally
            Free;
        End;
End;

Procedure TMainForm.actHelpCustomizeExecute(Sender: TObject);
Begin
    With TfrmHelpEdit.Create(Self) Do
        Try
            If Execute Then
                BuildHelpMenu;
        Finally
            Free;
        End;
End;

Procedure TMainForm.actProjectNewExecute(Sender: TObject);
Var
    idx: Integer;
Begin
    idx := -1;
    If assigned(fProject) Then
        idx := fProject.NewUnit(False);
    If idx > -1 Then
        With fProject.OpenUnit(idx) Do
        Begin
            Activate;
            Modified := True;
        End;
End;


Procedure TMainForm.actProjectAddExecute(Sender: TObject);
Var
    flt: String;
    idx: Integer;
    FolderNode: TTreeNode;
    filtersBuilt: Boolean;
{$IFDEF PLUGIN_BUILD}
    i, j: Integer;
    filters: TStringList;
{$ENDIF}
Begin
    If Not assigned(fProject) Then
        exit;

    flt := '';
    BuildFilter(flt, ftOpen);

    With dmMain.OpenDialog Do
    Begin
        Title := Lang[ID_NV_OPENADD];
        Filter := flt;
        If Execute Then
        Begin
            If Assigned(ProjectView.Selected) And
                (ProjectView.Selected.Data = Pointer(-1)) Then
                FolderNode := ProjectView.Selected
            Else
                FolderNode := fProject.Node;
            Try
                For idx := 0 To pred(Files.Count) Do
                Begin
                    fProject.AddUnit(Files[idx], FolderNode, False);
                    // add under folder
                    CppParser1.AddFileToScan(Files[idx]);
                End;
                fProject.RebuildNodes;
                CppParser1.ParseList;
            Except;
                fProject.RebuildNodes;
                CppParser1.ParseList;
            End;
        End;
    End;
End;

{ end XXXKF changed }

Procedure TMainForm.actProjectRemoveExecute(Sender: TObject);
Begin
    fProject.Remove(-1, True);
End;

Procedure TMainForm.actProjectOptionsExecute(Sender: TObject);
Begin
    If assigned(fProject) Then
        fProject.ShowOptions;
    // set again the window's and application's captions
    // in case they have been changed...
    UpdateAppTitle;
End;

Procedure TMainForm.actProjectSourceExecute(Sender: TObject);
{$IFDEF PLUGIN_BUILD}
Var
    i: Integer;
{$ENDIF}
Begin
    If assigned(fProject) Then
    Begin
{$IFDEF PLUGIN_BUILD}
        For i := 0 To pluginsCount - 1 Do
            plugins[i].OpenFile(fProject.FileName);
{$ENDIF}
        OpenFile(fProject.FileName);
    End;
End;

Procedure TMainForm.actFindExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    SearchCenter.Project := fProject;
    If assigned(e) Then
        If e.Search(False) Then
            ShowDockForm(frmReportDocks[cFindTab]);
    SearchCenter.Project := Nil;
End;

Procedure TMainForm.actFindAllExecute(Sender: TObject);
Begin
    SearchCenter.SingleFile := False;
    SearchCenter.Project := fProject;
    SearchCenter.Replace := False;
    SearchCenter.Editor := GetEditor;
    If SearchCenter.ExecuteSearch Then
        ShowDockForm(frmReportDocks[cFindTab]);
    SearchCenter.Project := Nil;
End;

Procedure TMainForm.actReplaceExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If assigned(e) Then
        e.Search(True);
End;

Procedure TMainForm.actFindNextExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If Assigned(e) Then
        e.SearchAgain;
End;

Procedure TMainForm.actGotoExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If Assigned(e) Then
        e.GotoLine;
End;

Function TMainForm.PrepareForCompile(rebuild: Boolean): Boolean;
Var
    e: TEditor;
    i: Integer;
Begin
    Result := False;

  //  if not Assigned(fProject) then
   //     exit;

    If (Assigned(fProject)) And (fProject.Units.Count = 0) Then
    Begin
        Application.MessageBox(
            'Why in the world are you trying to compile an empty project? ;-)',
{$IFDEF WIN32}
            'Huh?', MB_ICONINFORMATION);
{$ENDIF}

        Exit;
    End;

    LogOutput.Clear;
    CompilerOutput.Items.Clear;
    ResourceOutput.Items.Clear;
    SizeFile.Text := '';
    TotalErrors.Text := '0';

    If Not devData.ShowProgress Then
        // if no compile progress window, open the compiler output
        ShowDockForm(frmReportDocks[cLogTab]);

    e := GetEditor;
    fCompiler.Target := ctNone;

    If assigned(fProject) Then
        // no matter if the editor file is not in project,
        // the target is ctProject since we have a project open...
        fCompiler.Target := ctProject
    Else
    If assigned(e) And
        (GetFiletyp(e.Filename) In [utSrc, utRes]) Or e.new Then
        fCompiler.Target := ctFile;

    If fCompiler.Target = ctFile Then
    Begin
        SaveFile(e);
        If e.New Then
            Exit;
        fCompiler.SourceFile := e.FileName;
    End
    Else
    If fCompiler.Target = ctProject Then
    Begin
        actSaveAllExecute(Self);
        For i := 0 To pred(PageControl.PageCount) Do
        Begin
            e := GetEditor(i);
            If (e.InProject) And (e.Modified) Then
                Exit;
        End;
    End;

    fCompiler.PerfectDepCheck := Not devCompiler.FastDep;
    // increment the build number
    If Assigned(fProject) Then
    Begin
        If (
            fProject.VersionInfo.AutoIncBuildNrOnCompile Or
            (fProject.VersionInfo.AutoIncBuildNrOnRebuild And rebuild)) Then
            fProject.IncrementBuildNumber;
        fProject.BuildPrivateResource;
    End;
    Result := True;
End;

Procedure TMainForm.OnCompileTerminated(Sender: TObject);
Begin
    Application.Restore;
End;

Procedure TMainForm.actCompileExecute(Sender: TObject);
Begin
    If fCompiler.Compiling Then
    Begin
        MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
        Exit;
    End;
    If PrepareForCompile(False) Then
        fCompiler.Compile;
End;

Procedure TMainForm.actRunExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If assigned(fProject) Then
    Begin
        If fProject.CurrentProfile.typ = dptStat Then
            MessageDlg(Lang[ID_ERR_NOTEXECUTABLE], mtError, [mbOK], Handle)
        Else
        If Not FileExists(fProject.Executable) Then
            MessageDlg(Lang[ID_ERR_PROJECTNOTCOMPILED], mtWarning,
                [mbOK], Handle)
        Else
        If fProject.CurrentProfile.typ = dptDyn Then
        Begin
            If fProject.CurrentProfile.HostApplication = '' Then
                MessageDlg(Lang[ID_ERR_HOSTMISSING], mtWarning, [mbOK], Handle)
            Else
            If Not FileExists(fProject.CurrentProfile.HostApplication) Then
                MessageDlg(Lang[ID_ERR_HOSTNOTEXIST], mtWarning,
                    [mbOK], Handle)
            Else
            Begin
                If devData.MinOnRun Then
                    Application.Minimize;
                devExecutor.ExecuteAndWatch(
                    fProject.CurrentProfile.HostApplication,
                    fProject.CmdLineArgs,
                    ExtractFileDir(
                    fProject.CurrentProfile.HostApplication),
                    True, INFINITE, OnCompileTerminated);
            End;
        End
        Else
        Begin
            If devData.MinOnRun Then
                Application.Minimize;
            devExecutor.ExecuteAndWatch(fProject.Executable,
                fProject.CmdLineArgs,
                ExtractFileDir(fProject.Executable),
                True, INFINITE, OnCompileTerminated);
        End;
    End
    Else
    If assigned(e) Then
    Begin
        // GAR 10 Nov 2009
        // Hack for Wine/Linux
        // ProductName returns empty string for Wine/Linux
        // for Windows, it returns OS name (e.g. Windows Vista).
        If (MainForm.JvComputerInfoEx1.OS.ProductName = '') Then

            If Not FileExists(ChangeFileExt(e.FileName, '')) Then
                MessageDlg(Lang[ID_ERR_SRCNOTCOMPILED], mtWarning,
                    [mbOK], Handle)
            Else
            Begin
                If devData.MinOnRun Then
                    Application.Minimize;
                devExecutor.ExecuteAndWatch(ChangeFileExt(e.FileName, ''), '',
                    ExtractFilePath(e.FileName),
                    True, INFINITE, OnCompileTerminated);
            End
        Else
        If Not FileExists(ChangeFileExt(e.FileName, EXE_EXT)) Then
            MessageDlg(Lang[ID_ERR_SRCNOTCOMPILED], mtWarning, [mbOK], Handle)
        Else
        Begin
            If devData.MinOnRun Then
                Application.Minimize;
            devExecutor.ExecuteAndWatch(ChangeFileExt(e.FileName, EXE_EXT), '',
                ExtractFilePath(e.FileName),
                True, INFINITE, OnCompileTerminated);
        End;
    End;
End;

Procedure TMainForm.actCompRunExecute(Sender: TObject);
Begin
    If fCompiler.Compiling Then
    Begin
        MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
        Exit;
    End;
    If PrepareForCompile(False) Then
    Begin
        fCompiler.Compile;
        fCompiler.OnCompilationEnded := actRunExecute;
    End;
End;

Procedure TMainForm.actRebuildExecute(Sender: TObject);
Begin
    If fCompiler.Compiling Then
    Begin
        MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
        Exit;
    End;
    If Not PrepareForCompile(True) Then
        Exit;
    fCompiler.RebuildAll;
    Application.ProcessMessages;
End;

Procedure TMainForm.actCleanExecute(Sender: TObject);
Begin
    If fCompiler.Compiling Then
    Begin
        MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
        Exit;
    End;
    fCompiler.Clean;
    Application.ProcessMessages;
End;

Procedure TMainForm.InitializeDebugger;
    Procedure Initialize;
    Begin
        fDebugger.OnCallStack := OnCallStack;
        fDebugger.OnThreads := OnThreads;
        fDebugger.OnLocals := OnLocals;
    End;
Begin
    If ((devCompiler.CompilerType = ID_COMPILER_MINGW) Or
        (devCompiler.CompilerType = ID_COMPILER_LINUX)) Then
    Begin
        If Not (fDebugger Is TGDBDebugger) Then
        Begin
            If Assigned(fDebugger) Then
                fDebugger.Free;
            fDebugger := TGDBDebugger.Create;
            Initialize;
        End;
    End;
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

End;

Procedure TMainForm.PrepareDebugger;
Var
    idx: Integer;
    sl: TStringList;
Begin
    //Recreate the debugger object
    InitializeDebugger;

    //Prepare the debugger environment
    DebugOutput.Clear;
    actStopExecute.Execute;
    fDebugger.ClearIncludeDirs;
    ShowDockForm(frmReportDocks[cDebugTab]);

    // add to the debugger the global include dirs
    sl := TStringList.Create;
    Try
        ExtractStrings([';'], [' '], Pchar(devDirs.C), sl);
        For idx := 0 To sl.Count - 1 Do
            fDebugger.AddIncludeDir(sl[idx]);
        ExtractStrings([';'], [' '], Pchar(devDirs.Cpp), sl);
        For idx := 0 To sl.Count - 1 Do
            fDebugger.AddIncludeDir(sl[idx]);
    Finally
        sl.Free;
    End;
End;

Procedure TMainForm.doDebugAfterCompile(Sender: TObject);
Var
    e: TEditor;
    idx, idx2: Integer;
    s: String;
Begin
    PrepareDebugger;
    If assigned(fProject) Then
    Begin
        If Not FileExists(fProject.Executable) Then
        Begin
            MessageDlg(Lang[ID_ERR_PROJECTNOTCOMPILED], mtWarning, [mbOK], 0);
            Exit;
        End;

        // add to the debugger the project include dirs
        For idx := 0 To fProject.CurrentProfile.Includes.Count - 1 Do
            fDebugger.AddIncludeDir(fProject.CurrentProfile.Includes[idx]);

        If fProject.CurrentProfile.typ <> dptDyn Then
            fDebugger.Execute(StringReplace(fProject.Executable, '\',
                '\\', [rfReplaceAll]), fCompiler.RunParams)
        // EAB TODO:  command line args are passed when debugging?
        Else
        Begin
            If fProject.CurrentProfile.HostApplication = '' Then
            Begin
                MessageDlg(Lang[ID_ERR_HOSTMISSING], mtWarning, [mbOK], 0);
                exit;
            End
            Else
            If Not FileExists(fProject.CurrentProfile.HostApplication) Then
            Begin
                MessageDlg(Lang[ID_ERR_HOSTNOTEXIST], mtWarning, [mbOK], 0);
                exit;
            End;

            If Assigned(fDebugger) Then
                fDebugger.Execute(
                    StringReplace(fProject.CurrentProfile.HostApplication,
                    '\', '\\', [rfReplaceAll]), fCompiler.RunParams);
        End;

        fDebugger.RefreshBreakpoints;

    End
    Else
    Begin
        e := GetEditor;
        If assigned(e) Then
        Begin

            // GAR 10 Nov 2009
            // Hack for Wine/Linux
            // ProductName returns empty string for Wine/Linux
            // for Windows, it returns OS name (e.g. Windows Vista).
            If (MainForm.JvComputerInfoEx1.OS.ProductName = '') Then
                If Not FileExists(ChangeFileExt(e.FileName, '')) Then
                Begin
                    MessageDlg(Lang[ID_ERR_SRCNOTCOMPILED],
                        mtWarning, [mbOK], 0);
                    exit;
                End
                Else
                If Not FileExists(ChangeFileExt(e.FileName, EXE_EXT)) Then
                Begin
                    MessageDlg(Lang[ID_ERR_SRCNOTCOMPILED],
                        mtWarning, [mbOK], 0);
                    exit;
                End;

            If e.Modified Then // if file is modified
                If Not SaveFile(e) Then // save it first
                    Abort; // if it's not saved, abort
            chdir(ExtractFilePath(e.FileName));

            // GAR 10 Nov 2009
            // Hack for Wine/Linux
            // ProductName returns empty string for Wine/Linux
            // for Windows, it returns OS name (e.g. Windows Vista).
            If (MainForm.JvComputerInfoEx1.OS.ProductName = '') Then
                fDebugger.Execute(StringReplace(
                    ChangeFileExt(ExtractFileName(e.FileName), ''),
                    '\', '\\', [rfReplaceAll]),
                    fCompiler.RunParams)
            Else
                fDebugger.Execute(StringReplace(
                    ChangeFileExt(ExtractFileName(e.FileName),
                    EXE_EXT), '\', '\\',
                    [rfReplaceAll]), fCompiler.RunParams);

            fDebugger.RefreshBreakpoints;
            fDebugger.RefreshWatches;
        End;
    End;

    //Then run the debugger
    fDebugger.Go;
End;

Procedure TMainForm.actDebugExecute(Sender: TObject);
Var
    UpToDate: Boolean;
    MessageResult, spos: Integer;
    linker_original: String;
    opts: TProjProfile;
Begin

    linker_original := '';  // Trying to supress bug #3469393

    If Not fDebugger.Executing Then
    Begin
        If Assigned(fProject) Then
        Begin

            // remove "--no-export-all-symbols" from the linker''s command line
            opts := fProject.CurrentProfile;
            linker_original := opts.Linker;

            // look for "--no-export-all-symbols"
            spos := Pos('--no-export-all-symbols', opts.Linker);
            // following more opts
            // if found, delete it
            If spos > 0 Then
                Delete(opts.Linker, spos, length('--no-export-all-symbols'));

            fProject.CurrentProfile := opts;

            //Save all the files then set the UI status
            actSaveAllExecute(Self);
            (Sender As TAction).Tag := 0;
            (Sender As TAction).Enabled := False;
            StatusBar.Panels[3].Text :=
                'Checking if project needs to be rebuilt...';

            //Run make to see if the project is up to date, the cache the result and restore our state
            fCompiler.Target := ctProject;
            UpToDate := fCompiler.UpToDate;
            (Sender As TAction).Tag := 1;
            StatusBar.Panels[3].Text := '';

            //Ask the user if the project is out of date
            If Not UpToDate Then
            Begin
                If devData.AutoCompile = -1 Then
                Begin
                    MessageResult :=
                        devMessageBox(Self,
                        'The project you are working on is out of date. Do you ' +
                        'want to rebuild the project before debugging?',
                        'wxDev-C++',
                        'Don''t show this again',
                        MB_ICONQUESTION Or MB_YESNOCANCEL);

                    If MessageResult > 0 Then
                        devData.AutoCompile := abs(MessageResult);
                    MessageResult := abs(MessageResult);
                End
                Else
                    MessageResult := devData.AutoCompile;

                Case MessageResult Of
                    mrYes:
                    Begin
                        fCompiler.OnCompilationEnded := doDebugAfterCompile;
                        actCompile.Execute;
                        Exit;
                    End;
                    mrCancel:
                        Exit;
                End;
            End;

            fProject.CurrentProfile.Linker := linker_original;

            doDebugAfterCompile(Sender);

        End
        Else  // We are not in a project (single file compilation)
           MessageDlg('You cannot debug outside of a project.'
             + #13#10 + 'Please add file to project and then re-try.', mtInformation,
                [mbOk], 0);


    End
    Else
    If Assigned(fDebugger) Then
        If fDebugger.Paused Then
        Begin
            RemoveActiveBreakpoints;
            fDebugger.Go;
        End;

End;


Procedure TMainForm.actPauseDebugExecute(Sender: TObject);
Begin
    If Assigned(fDebugger) Then
        If fDebugger.Executing Then
            fDebugger.Pause;
End;

Procedure TMainForm.actPauseDebugUpdate(Sender: TObject);
Begin
    If Assigned(fDebugger) Then
        (Sender As TAction).Enabled :=
            fDebugger.Executing And Not fDebugger.Paused //and
    //(fDebugger is TCDBDebugger);
    Else
        (Sender As TAction).Enabled := False;

End;

Procedure TMainForm.actEnviroOptionsExecute(Sender: TObject);
Begin
    With TEnviroForm.Create(Self) Do
        Try
            If ShowModal = mrok Then
            Begin
                SetupProjectView;
                If devData.MsgTabs Then
                    DockServer.DockStyle.TabServerOption.TabPosition := tpTop
                Else
                    DockServer.DockStyle.TabServerOption.TabPosition :=
                        tpBottom;
                If devData.FullScreen Then
                    ControlBar1.Visible := devData.ShowBars;

                If devData.LangChange = True Then
                Begin
                    Lang.SetLang(devData.Language);
                    LoadText(True);
                End;
                If devData.ThemeChange Then
                    Loadtheme;
                devShortcuts1.Filename := devDirs.Config + DEV_SHORTCUTS_FILE;
                PageControl.OwnerDraw := DevData.HiliteActiveTab;
            End;
        Finally
            Free;
        End;
End;

Procedure TMainForm.actUpdatePageCount(Sender: TObject);
Begin
    (Sender As TCustomAction).Enabled := PageControl.PageCount > 0;
End;

Procedure TMainForm.actUpdatePageorProject(Sender: TObject);
Begin
    (Sender As TCustomAction).Enabled := assigned(fProject)
        Or (PageControl.PageCount > 0);
End;

Procedure TMainForm.actDebugUpdate(Sender: TObject);
Begin
    If Assigned(fProject) Then
        (Sender As TCustomAction).Enabled :=
            Not (fProject.CurrentProfile.typ = dptStat) And
            (Not devExecutor.Running) And ((Not fDebugger.Executing) Or
            fDebugger.Paused) And (Not fCompiler.Compiling) And
            ((Sender As TAction).Tag = 1)
    Else
        (Sender As TCustomAction).Enabled := (PageControl.PageCount > 0) And
            (Not devExecutor.Running) And ((Not fDebugger.Executing) Or
            fDebugger.Paused)
            And (Not fCompiler.Compiling) And ((Sender As TAction).Tag = 1);
End;

Procedure TMainForm.actCompileUpdate(Sender: TObject);
Begin

    If Not Assigned(fDebugger) Then
        exit;
    If Not Assigned(fProject) Then
        exit;
    If Not Assigned(fCompiler) Then
        exit;

    (Sender As TCustomAction).Enabled :=
        (assigned(fProject) Or (PageControl.PageCount > 0)) And
        Not devExecutor.Running And Not fDebugger.Executing And
        Not fCompiler.Compiling;
End;

Procedure TMainForm.actUpdatePageProject(Sender: TObject);
Begin
    (Sender As TCustomAction).Enabled :=
        assigned(fProject) And (PageControl.PageCount > 0);
End;

Procedure TMainForm.actUpdateProject(Sender: TObject);
Begin
    (Sender As TCustomAction).Enabled := (assigned(fProject));
End;

Procedure TMainForm.actUpdateEmptyEditor(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
{$IFNDEF PRIVATE_BUILD}
    Try
{$ENDIF}
        If Assigned(e) Then
            (Sender As TAction).Enabled :=
                Assigned(e) And Assigned(e.Text) And (e.Text.Text <> '')
        Else
            (Sender As TAction).Enabled := False;
{$IFNDEF PRIVATE_BUILD}
    Except
    End;
{$ENDIF}
End;

Procedure TMainForm.actUpdateDebuggerRunning(Sender: TObject);
Begin
    If Assigned(fDebugger) Then
        (Sender As TAction).Enabled := fDebugger.Executing
    Else
        (Sender As TAction).Enabled := False;
End;

Procedure TMainForm.actUpdateDebuggerPaused(Sender: TObject);
Begin
    If Assigned(fDebugger) Then
        (Sender As TAction).Enabled := fDebugger.Executing And fDebugger.Paused
    Else
        (Sender As TAction).Enabled := False;

End;

Procedure TMainForm.ToolbarClick(Sender: TObject);
Begin
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
End;

Procedure TMainForm.ControlBar1ContextPopup(Sender: TObject;
    MousePos: TPoint; Var Handled: Boolean);
Var
    pt: TPoint;
Begin
    pt := ControlBar1.ClientToScreen(MousePos);
    TrackPopupMenu(ToolbarsItem.Handle, TPM_LEFTALIGN Or TPM_LEFTBUTTON,
        pt.x, pt.y, 0, Self.Handle, Nil);
    Handled := True;
End;

Procedure TMainForm.ApplicationEvents1Idle(Sender: TObject;
    Var Done: Boolean);
Begin
    PageControl.Visible := assigned(PageControl.FindNextPage(Nil, True, True));
    InsertBtn.Enabled := InsertItem.Visible;
End;

Procedure TMainForm.actProjectMakeFileExecute(Sender: TObject);
Begin
    fCompiler.Project := fProject;
    fCompiler.BuildMakeFile;
    OpenFile(fCompiler.MakeFile);
End;

Procedure TMainForm.actMsgCopyExecute(Sender: TObject);
Var
    PopupComp: TComponent;
Begin
    PopupComp := MessagePopup.PopupComponent;
    If PopupComp Is TEdit Then
    Begin
        If TEdit(PopupComp).SelText <> '' Then
            Clipboard.AsText := TEdit(PopupComp).SelText
        Else
        If TEdit(PopupComp).Text <> '' Then
            Clipboard.AsText := TEdit(PopupComp).Text;
    End
    Else
    If PopupComp Is TMemo Then
    Begin
        If TMemo(PopupComp).SelText <> '' Then
            Clipboard.AsText := TMemo(PopupComp).SelText
        Else
        If TMemo(PopupComp).Lines.Text <> '' Then
            Clipboard.AsText := TMemo(PopupComp).Lines.Text;
    End
    Else
    If PopupComp Is TListView Then
    Begin
        If Assigned(TListView(PopupComp).Selected) Then
            Clipboard.AsText :=
                StringReplace(
                StringReplace(Trim(TListView(PopupComp).Selected.Caption +
                ' ' +
                TListView(PopupComp).Selected.SubItems.Text),
                #13#10,
                ' ', [rfReplaceAll]),
                #10, ' ', [rfReplaceAll]);
    End;
End;

Procedure TMainForm.actMsgClearExecute(Sender: TObject);
Var
    PopupComp: TComponent;
Begin
    PopupComp := MessagePopup.PopupComponent;
    If PopupComp Is TEdit Then
        TEdit(PopupComp).Clear
    Else
    If PopupComp Is TMemo Then
        TMemo(PopupComp).Clear
    Else
    If PopupComp Is TListView Then
        TListView(PopupComp).Items.Clear;
End;

Procedure TMainForm.actBreakPointExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If assigned(e) Then
        e.ToggleBreakPoint(e.Text.CaretY);
End;

Procedure TMainForm.actIncrementalExecute(Sender: TObject);
Var
    pt: TPoint;
    temp, temp2: String;
Begin
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
End;

Procedure TMainForm.CompilerOutputDblClick(Sender: TObject);
Var
    Col, Line: Integer;
    tFile: String;
    e: TEditor;
    intTmpPos, delimPos: Integer;
    strCol: String;
Begin
    // do nothing if no item selected, or no line/unit specified
    If Not assigned(CompilerOutput.Selected) Or
        (CompilerOutput.Selected.Caption = '') Or
        (CompilerOutput.Selected.SubItems[0] = '') Then
        exit;

    Col := 0;
    Line := StrToIntDef(CompilerOutput.Selected.Caption, -1);
    If Line = -1 Then
        Exit;

    tfile := trim(CompilerOutput.Selected.SubItems[0]);
    If fileExists(tfile) = False Then
    Begin
        If strContains(' from ', tfile) Then
        Begin
            intTmpPos := pos(' from ', tfile);
            tfile := trim(copy(tfile, 0, intTmpPos));
        End;
        If copy(tfile, length(tfile), 1) = ',' Then
            tfile := trim(copy(tfile, 0, length(tfile) - 1));
        delimPos := LastDelimiter(':', tfile);
        If delimPos <> 2 Then
        Begin
            strCol := copy(tfile, delimPos + 1, length(tfile));
            If isNumeric(strCol) Then
                Line := strToIntDef(strCol, 0);
            tfile := trim(copy(tfile, 0, delimPos - 1));
        End;

    End;


    e := GetEditorFromFileName(tfile);

    Application.ProcessMessages;
    If assigned(e) Then
    Begin
        e.SetErrorFocus(col, line);
        e.Activate;
    End;
End;

Procedure TMainForm.FindOutputDblClick(Sender: TObject);
Var
    col, line: Integer;
    e: TEditor;
Begin
    // goto find pos
    If Not assigned(FindOutPut.Selected) Then
        exit;
    Col := strtointdef(FindOutput.Selected.SubItems[0], 0);
    Line := strtointdef(FindOutput.Selected.Caption, 0);

    // replaced redundant code...
    e := GetEditorFromFileName(FindOutput.Selected.SubItems[1]);

    If assigned(e) Then
    Begin
        e.Text.CaretXY := BufferCoord(col, line);
        e.Text.SetSelWord;
        e.Text.CaretXY := e.Text.BlockBegin;
        e.Activate;
    End;
End;

Procedure TMainForm.actShowBarsExecute(Sender: TObject);
Begin
    If devData.FullScreen Then
    Begin
        ControlBar1.Visible := Not Controlbar1.Visible;
        If Controlbar1.Visible Then
            pnlFull.Top := -2;
    End;
End;

Procedure TMainForm.FormContextPopup(Sender: TObject; MousePos: TPoint;
    Var Handled: Boolean);
Var
    pt: TPoint;
Begin
    pt := ClientToScreen(MousePos);
    TrackPopupMenu(ViewMenu.Handle, TPM_LEFTALIGN Or TPM_LEFTBUTTON,
        pt.x, pt.y, 0, Self.Handle, Nil);
    Handled := True;
End;

Procedure TMainForm.FormKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
{$IFDEF PLUGIN_BUILD}
Var
    i: Integer;
{$ENDIF}
Begin
    Case key Of
        // EAB Bypass SynEdit Delete Line event
        89:
            If ssCtrl In Shift Then
            Begin
                Key := 0;
    { e := GetEditor;
     if assigned(e) then
     begin
       if e.Text.CanRedo then
       if RedoItem.Enabled then
           e.Text.Redo
     end; }
            End;

{$IFDEF WIN32}
        VK_F6:
{$ENDIF}
            If ssCtrl In Shift Then
                ShowDebug;
        VK_F1:
            If defaultHelpF1 Then
                WordToHelpKeyword;
    End;

{$IFDEF PLUGIN_BUILD}
    For i := 0 To packagesCount - 1 Do
        (plugins[delphi_plugins[i]] As IPlug_In_BPL).FormKeyDown(
            Sender, key, Shift);
{$ENDIF}
End;

Function TMainForm.GetEditor(Const index: Integer): TEditor;
Var
    i: Integer;
Begin
    If index = -1 Then
        i := PageControl.ActivePageIndex
    Else
        i := index;

    If (i >= PageControl.PageCount) Or (i < 0) Then
        result := Nil
    Else
        result := TEditor(PageControl.Pages[i].Tag);
End;

Procedure TMainForm.actAddWatchExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If Assigned(e) Then
    Begin
        If e.Text.SelAvail Then
            AddDebugVar(e.Text.SelText, wbWrite)
        Else
            AddWatchBtnClick(self);
    End;
End;

Procedure TMainForm.AddDebugVar(s: String; when: TWatchBreakOn);

Begin
    If Trim(s) = '' Then
        Exit;

    If Assigned(fDebugger) Then
        If fDebugger.Executing And fDebugger.Paused Then
        Begin

            fDebugger.AddWatch(s, when);
            fDebugger.RefreshContext([cdWatches]);
        End;

End;

Procedure TMainForm.actNextStepExecute(Sender: TObject);
Begin
    If Assigned(fDebugger) Then
        If fDebugger.Paused And fDebugger.Executing Then
            fDebugger.Next;

End;

Procedure TMainForm.actStepSingleExecute(Sender: TObject);
Begin
    If Assigned(fDebugger) Then
        If fDebugger.Paused And fDebugger.Executing Then
            fDebugger.Step;

End;

Procedure TMainForm.DebugFinishClick(Sender: TObject);
Begin
    If Assigned(fDebugger) Then
        If fDebugger.Paused And fDebugger.Executing Then
            fDebugger.Finish;
End;

Procedure TMainForm.actWatchItemExecute(Sender: TObject);
Begin
    ShowDockForm(frmReportDocks[cDebugTab]);
    DebugSubPages.ActivePage := tabWatches;
End;

Procedure TMainForm.actRemoveWatchExecute(Sender: TObject);
Var
    node: TTreeNode;
Begin
    //Trace the selected watch node to the highest-level node
    node := WatchTree.Selected;
    While Assigned(Node) And (Assigned(node.Parent)) Do
        node := node.Parent;

    //Then remove the watch
    If Assigned(node) Then
    Begin
        fDebugger.RemoveWatch(WatchTree.Selected);
        WatchTree.Items.Delete(node);
    End;
End;

Procedure TMainForm.RemoveActiveBreakpoints;
Var i: Integer;
Begin
    For i := 0 To PageControl.PageCount - 1 Do
        GetEditor(i).RemoveBreakpointFocus;
End;

Procedure TMainForm.GotoBreakpoint(bfile: String; bline: Integer);
Var
    e: TEditor;
Begin
    // correct win32 make's path
    bfile := StringReplace(bfile, '/', '\', [rfReplaceAll]);

    e := GetEditorFromFileName(bfile);
    Application.ProcessMessages;
    If assigned(e) Then
    Begin
        e.SetActiveBreakpointFocus(bline);
        e.Activate;
    End;
    Application.BringToFront;
End;

Procedure TMainForm.actStepOverExecute(Sender: TObject);
Begin
    If Assigned(fDebugger) Then
        If fDebugger.Paused And fDebugger.Executing Then
        Begin
            RemoveActiveBreakpoints;
            fDebugger.Go;
        End;

End;

Procedure TMainForm.actStopExecuteExecute(Sender: TObject);
Begin
    If Assigned(fDebugger) Then
        If fDebugger.Executing Then
        Begin
            fDebugger.CloseDebugger(sender);
        End;

End;

Procedure TMainForm.actRestartDebugExecute(Sender: TObject);
Begin
    actStopExecute.Execute;
    actDebug.Execute;
End;

Procedure TMainForm.actUndoUpdate(Sender: TObject);
Var
    e: TEditor;
Begin
{$IFNDEF PRIVATE_BUILD}
    Try
{$ENDIF}
        //Added for wx: Try catch for Some weird On Close Error
        e := GetEditor;
        actUndo.Enabled := assigned(e) And assigned(e.Text) And e.Text.CanUndo;
{$IFNDEF PRIVATE_BUILD}
    Except
    End;
{$ENDIF}
End;

Procedure TMainForm.actRedoUpdate(Sender: TObject);
Var
    e: TEditor;
Begin
{$IFNDEF PRIVATE_BUILD}
    //Added for wx: Try catch for Some weird On Close Error
    Try
{$ENDIF}
        e := GetEditor;
        actRedo.enabled := assigned(e) And assigned(e.Text) And e.Text.CanRedo;
{$IFNDEF PRIVATE_BUILD}
    Except
    End;
{$ENDIF}
End;

Procedure TMainForm.actCutUpdate(Sender: TObject);
Var
    e: TEditor;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
    pluginCatched: Boolean;
{$ENDIF}
Begin
{$IFNDEF PRIVATE_BUILD}
    //Added for wx: Try catch for Some weird On Close Error
    Try
{$ENDIF}
        e := GetEditor;
        If assigned(e) Then
        Begin
{$IFDEF PLUGIN_BUILD}
            pluginCatched := False;
            For i := 0 To pluginsCount - 1 Do
            Begin
                If plugins[i].IsForm(e.FileName) Then
                Begin
                    actCut.Enabled := True;
                    pluginCatched := True;
                End;
            End;
            If Not pluginCatched Then
{$ENDIF}
                actCut.Enabled := assigned(e.Text) And e.Text.SelAvail;
        End;
{$IFNDEF PRIVATE_BUILD}
    Except
    End;
{$ENDIF}
End;

Procedure TMainForm.actCopyUpdate(Sender: TObject);
Var
    e: TEditor;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
    pluginCatched: Boolean;
{$ENDIF}
Begin
{$IFNDEF PRIVATE_BUILD}
    //Added for wx: Try catch for Some weird On Close Error
    Try
{$ENDIF}
        e := GetEditor;

        If assigned(e) Then
        Begin
{$IFDEF PLUGIN_BUILD}
            pluginCatched := False;
            For i := 0 To pluginsCount - 1 Do
            Begin
                If plugins[i].IsForm(e.FileName) Then
                Begin
                    actCopy.Enabled := True;
                    pluginCatched := True;
                End;
            End;
            If Not pluginCatched Then
{$ENDIF}
                actCopy.Enabled := e.Text.SelAvail;
        End;
{$IFNDEF PRIVATE_BUILD}
    Except
    End;
{$ENDIF}
End;

Procedure TMainForm.actPasteUpdate(Sender: TObject);
Var
    e: TEditor;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
    pluginCatched: Boolean;
{$ENDIF}
Begin
{$IFNDEF PRIVATE_BUILD}
    //Added for wx: Try catch for Some weird On Close Error
    Try
{$ENDIF}
        e := GetEditor;

        If assigned(e) Then
        Begin
{$IFDEF PLUGIN_BUILD}
            pluginCatched := False;
            For i := 0 To pluginsCount - 1 Do
            Begin
                If plugins[i].IsForm(e.FileName) Then
                Begin
                    actPaste.Enabled := True;
                    pluginCatched := True;
                End;
            End;
            If Not pluginCatched Then
{$ENDIF}
                actPaste.Enabled := assigned(e.Text) And e.Text.CanPaste;
        End;
{$IFNDEF PRIVATE_BUILD}
    Except
    End;
{$ENDIF}
End;

Procedure TMainForm.actSaveUpdate(Sender: TObject);
Var
    e: TEditor;
Begin
{$IFNDEF PRIVATE_BUILD}
    //Added for wx: Try catch for Some weird Error
    Try
{$ENDIF}
        e := GetEditor;
        actSave.Enabled := assigned(e) And assigned(e.Text) And
            (e.Modified Or e.Text.Modified Or (e.FileName = ''));
{$IFNDEF PRIVATE_BUILD}
    Except
        //e:=nil;
    End;
{$ENDIF}
End;

Procedure TMainForm.actSaveAsUpdate(Sender: TObject);
Var
    e: TEditor;
Begin
{$IFNDEF PRIVATE_BUILD}
    //Added for wx: Try catch for Some weird On Close Error
    Try
{$ENDIF}
        e := GetEditor;
        actSaveAs.Enabled := assigned(e);
{$IFNDEF PRIVATE_BUILD}
    Except
    End;
{$ENDIF}
End;

Procedure TMainForm.actFindNextUpdate(Sender: TObject);
Var
    e: TEditor;
Begin
{$IFNDEF PRIVATE_BUILD}
    //Added for wx: Try catch for Some weird On Close Error
    Try
{$ENDIF}
        e := GetEditor;
        // ** need to also check if a search has already happened
        actFindNext.Enabled := assigned(e) And assigned(e.Text) And
            (e.Text.Text <> '');
{$IFNDEF PRIVATE_BUILD}
    Except
    End;
{$ENDIF}
End;

Procedure TMainForm.actFileMenuExecute(Sender: TObject);
Begin
    //  dummy event to keep menu active
End;

Procedure TMainForm.ShowDebug;
Begin
    DebugForm := TDebugForm.Create(Nil);
    DebugForm.Show;
End;

Procedure TMainForm.actToolsMenuExecute(Sender: TObject);
Var
    idx, i: Integer;
Begin
    For idx := (ToolsMenu.IndexOf(mnuToolSep1) + 1) To pred(ToolsMenu.Count) Do
    Begin
        i := ToolsMenu.Items[idx].tag;
        If i > 0 Then
            ToolsMenu.Items[idx].Enabled :=
                FileExists(ParseParams(fTools.ToolList[i]^.Exec));
    End;
End;

Function TMainForm.GetEditorFromFileName(ffile: String;
    donotReOpen: Boolean): TEditor;
Var
    index, index2: Integer; //mandrav
    e: TEditor;
Begin
    result := Nil;

    { First, check wether the file is already open }
    For index := 0 To PageControl.PageCount - 1 Do
    Begin
        e := GetEditor(index);
        If Not Assigned(e) Then
            Continue
        Else
        Begin
            //ExpandFileName reduces all the "\..\" in the path
            If SameFileName(e.FileName, ExpandFileName(ffile)) Then
            Begin
                Result := e;
                Exit;
            End;
        End;
    End;

    If fCompiler.Target In [ctFile, ctNone] Then
    Begin
        If FileExists(ffile) Then
            OpenFile(ffile);
        index := FileIsOpen(ffile);
        If index <> -1 Then
            result := GetEditor(index);
    End
    Else
    If (fCompiler.Target = ctProject) And Assigned(fProject) Then
    Begin
        index := fProject.GetUnitFromString(ffile);
        If index <> -1 Then
        Begin
            //mandrav
            index2 := FileIsOpen(ExpandFileName(fProject.Directory +
                ffile), True);
            If index2 = -1 Then
            Begin
                If (donotReOpen = True) Then
                Begin
                    result := Nil;
                    exit;
                End;
                result := fProject.OpenUnit(index);
            End
            Else
                result := GetEditor(index2);
            //mandrav - end
        End
        Else
        Begin
            If FileExists(ffile) Then
                OpenFile(ffile);
            index := FileIsOpen(ffile);
            If index <> -1 Then
                result := GetEditor(index);
        End;
    End;
End;

Procedure TMainForm.FormResize(Sender: TObject);
Begin
    If Not devData.FullScreen Then // only if not going full-screen
        GetWindowPlacement(Self.Handle, @devData.WindowPlacement);
    StatusBar.Panels[3].Width := StatusBar.Width - StatusBar.Panels[0].Width -
        StatusBar.Panels[1].Width - StatusBar.Panels[2].Width -
        StatusBar.Panels[4].Width;
End;

Procedure TMainForm.InitClassBrowser(Full: Boolean);
Var
    e: TEditor;
    sl: TStringList;
    I: Integer;
    ProgressEvents: Array[0..1] Of TProgressEvent;
Begin
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
    If Not ClassBrowser1.Enabled Or (Not Assigned(e) And
        (ClassBrowser1.ShowFilter = sfCurrent)) Then
    Begin
        CppParser1.Reset;
        ClassBrowser1.Clear;
    End;
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
    If Full And CppParser1.Enabled Then
    Begin
        Application.ProcessMessages;
        ProgressEvents[0] := CppParser1.OnCacheProgress;
        ClassBrowser1.Parser := Nil;
        CodeCompletion1.Parser := Nil;
        FreeAndNil(CppParser1);
        CppParser1 := TCppParser.Create(Self);
        ClassBrowser1.Parser := CppParser1;
        CodeCompletion1.Parser := CppParser1;
        // moved here from ScanActiveProject()
        With CppParser1 Do
        Begin
            Tokenizer := CppTokenizer1;
            Enabled := devClassBrowsing.Enabled;
            ParseLocalHeaders := devClassBrowsing.ParseLocalHeaders;
            ParseGlobalHeaders := devClassBrowsing.ParseGlobalHeaders;
            OnStartParsing := CppParser1StartParsing;
            OnEndParsing := CppParser1EndParsing;
            OnTotalProgress := CppParser1TotalProgress;
            OnCacheProgress := ProgressEvents[0];
            sl := TStringList.Create;
            Try
                ExtractStrings([';'], [' '], Pchar(devDirs.C), sl);
                For I := 0 To sl.Count - 1 Do
                    AddIncludePath(sl[I]);
                ExtractStrings([';'], [' '], Pchar(devDirs.Cpp), sl);
                For I := 0 To sl.Count - 1 Do
                    AddIncludePath(sl[I]);
            Finally
                sl.Free;
            End;

            // update parser reference in editors
            For I := 0 To PageControl.PageCount - 1 Do
                GetEditor(I).UpdateParser;
            If devCodeCompletion.UseCacheFiles Then
                Load(devDirs.Config + DEV_COMPLETION_CACHE);
            If Assigned(fProject) Then
                ScanActiveProject;
        End;
    End;
    Screen.Cursor := crDefault;
End;

Procedure TMainForm.ScanActiveProject;
Var
    I: Integer;
    I1: Cardinal;
    e: TEditor;
Begin
    Application.ProcessMessages;
    If Not ClassBrowser1.Enabled Then
        Exit;
    If Assigned(fProject) Then
        ClassBrowser1.ProjectDir := fProject.Directory
    Else
    Begin
        e := GetEditor;
        If Assigned(e) Then
            ClassBrowser1.ProjectDir := ExtractFilePath(e.FileName)
        Else
            ClassBrowser1.ProjectDir := '';
    End;
    I1 := GetTickCount;
    With CppParser1 Do
    Begin
        Reset;
        If Assigned(fProject) Then
        Begin
            ProjectDir := fProject.Directory;
            For I := 0 To fProject.Units.Count - 1 Do
                AddFileToScan(fProject.Units[I].FileName, True);
            For I := 0 To fProject.CurrentProfile.Includes.Count - 1 Do
                AddProjectIncludePath(fProject.CurrentProfile.Includes[I]);
        End
        Else
        Begin
            e := GetEditor;
            If Assigned(e) Then
            Begin
                ProjectDir := ExtractFilePath(e.FileName);
                AddFileToScan(e.FileName);
            End
            Else
                ProjectDir := '';
        End;
        ParseList;
        If PageControl.ActivePageIndex > -1 Then
        Begin
            e := GetEditor(PageControl.ActivePageIndex);
            If Assigned(e) Then
                ClassBrowser1.CurrentFile := e.FileName;
        End;
    End;
    StatusBar.Panels[3].Text :=
        'Done parsing in ' + FormatFloat('#,###,##0.00',
        (GetTickCount - I1) / 1000) +
        ' seconds';
End;

Procedure TMainForm.ClassBrowser1Select(Sender: TObject;
    Filename: TFileName; Line: Integer);
Var
    E: TEditor;
Begin
    // mandrav
    E := GetEditorFromFilename(FileName);
    If Assigned(E) Then
        E.GotoLineNr(Line);
End;

Procedure TMainForm.CppParser1TotalProgress(Sender: TObject;
    FileName: String; Total, Current: Integer);
Begin
    If FileName <> '' Then
    Begin
        StatusBar.Panels[3].Text := 'Parsing ' + Filename;
        //FormProgress.Max := Total;
        //FormProgress.Position := Current;
    End
    Else
    Begin
        //FormProgress.Position := 0;
        StatusBar.Panels[3].Text := 'Done parsing.';
        StatusBar.Panels[2].Text := '';
    End;

    StatusBar.Update;
    //FormProgress.Update;
End;

Procedure TMainForm.CodeCompletion1Resize(Sender: TObject);
Begin
    devCodeCompletion.Width := CodeCompletion1.Width;
    devCodeCompletion.Height := CodeCompletion1.Height;
End;

Procedure TMainForm.actSwapHeaderSourceUpdate(Sender: TObject);
Begin
    actSwapHeaderSource.Enabled := PageControl.PageCount > 0;
End;

Procedure TMainForm.actSwapHeaderSourceExecute(Sender: TObject);
Var
    e: TEditor;
    Ext: String;
    FileName: String;
    i: Integer;
Begin
    e := GetEditor;
    If Not Assigned(e) Then
        Exit;

    Ext := ExtractFileExt(e.FileName);
    FileName := '';

    If Assigned(fProject) Then
    Begin
        FileName := e.FileName;
        If GetFileTyp(e.FileName) = utSrc Then
            For i := 0 To fProject.Units.Count - 1 Do
            Begin
                FileName := ChangeFileExt(e.FileName, HPP_EXT);
                If AnsiCompareFileName(ExtractFileName(FileName),
                    ExtractFileName(fProject.Units[i].FileName)) = 0 Then
                Begin
                    FileName := fProject.Units[i].FileName;
                    break;
                End;
                FileName := ChangeFileExt(e.FileName, H_EXT);
                If AnsiCompareFileName(ExtractFileName(FileName),
                    ExtractFileName(fProject.Units[i].FileName)) = 0 Then
                Begin
                    FileName := fProject.Units[i].FileName;
                    break;
                End;
            End
        Else
        If GetFileTyp(e.FileName) = utHead Then
            For i := 0 To fProject.Units.Count - 1 Do
            Begin
                FileName := ChangeFileExt(e.FileName, CPP_EXT);
                If AnsiCompareFileName(ExtractFileName(FileName),
                    ExtractFileName(fProject.Units[i].FileName)) = 0 Then
                Begin
                    FileName := fProject.Units[i].FileName;
                    break;
                End;
                FileName := ChangeFileExt(e.FileName, C_EXT);
                If AnsiCompareFileName(ExtractFileName(FileName),
                    ExtractFileName(fProject.Units[i].FileName)) = 0 Then
                Begin
                    FileName := fProject.Units[i].FileName;
                    break;
                End;
                FileName := ChangeFileExt(e.FileName, CC_EXT);
                If AnsiCompareFileName(ExtractFileName(FileName),
                    ExtractFileName(fProject.Units[i].FileName)) = 0 Then
                Begin
                    FileName := fProject.Units[i].FileName;
                    break;
                End;
                FileName := ChangeFileExt(e.FileName, CXX_EXT);
                If AnsiCompareFileName(ExtractFileName(FileName),
                    ExtractFileName(fProject.Units[i].FileName)) = 0 Then
                Begin
                    FileName := fProject.Units[i].FileName;
                    break;
                End;
                FileName := ChangeFileExt(e.FileName, CP2_EXT);
                If AnsiCompareFileName(ExtractFileName(FileName),
                    ExtractFileName(fProject.Units[i].FileName)) = 0 Then
                Begin
                    FileName := fProject.Units[i].FileName;
                    break;
                End;
                FileName := ChangeFileExt(e.FileName, CP_EXT);
                If AnsiCompareFileName(ExtractFileName(FileName),
                    ExtractFileName(fProject.Units[i].FileName)) = 0 Then
                Begin
                    FileName := fProject.Units[i].FileName;
                    break;
                End;
            End;
    End;
    If Not FileExists(FileName) Then
    Begin
        If GetFileTyp(e.FileName) = utSrc Then
        Begin
            If (CompareText(Ext, CPP_EXT) = 0) Or
                (CompareText(Ext, CC_EXT) = 0) Or
                (CompareText(Ext, CXX_EXT) = 0) Or
                (CompareText(Ext, CP2_EXT) = 0) Or
                (CompareText(Ext, CP_EXT) = 0) Then
            Begin
                FileName := ChangeFileExt(e.FileName, HPP_EXT);
                If Not FileExists(FileName) Then
                    FileName := ChangeFileExt(e.FileName, H_EXT);
            End
            Else
                FileName := ChangeFileExt(e.FileName, H_EXT);
        End
        Else
        If GetFileTyp(e.FileName) = utHead Then
        Begin
            FileName := ChangeFileExt(e.FileName, CPP_EXT);
            If Not FileExists(FileName) Then
            Begin
                FileName := ChangeFileExt(e.FileName, CC_EXT);
                If Not FileExists(FileName) Then
                Begin
                    FileName := ChangeFileExt(e.FileName, CXX_EXT);
                    If Not FileExists(FileName) Then
                    Begin
                        FileName := ChangeFileExt(e.FileName, CP2_EXT);
                        If Not FileExists(FileName) Then
                        Begin
                            FileName := ChangeFileExt(e.FileName, CP_EXT);
                            If Not FileExists(FileName) Then
                                FileName := ChangeFileExt(e.FileName, C_EXT);
                        End;
                    End;
                End;
            End;
        End;
    End; //else

    If Not FileExists(FileName) Then
    Begin
        Application.MessageBox('No corresponding header or source file found.',
{$IFDEF WIN32}
            'Error', MB_ICONINFORMATION);
{$ENDIF}

        exit;
    End;
    e := GetEditorFromFileName(FileName);
    If Assigned(e) Then
        e.Activate
    Else
        OpenFile(FileName);
End;

Procedure TMainForm.actSyntaxCheckExecute(Sender: TObject);
Begin
    If fCompiler.Compiling Then
    Begin
        MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
        Exit;
    End;
    If Not PrepareForCompile(False) Then
        Exit;
    fCompiler.CheckSyntax;
End;

Procedure TMainForm.actUpdateExecute(Sender: TObject);
Begin
    If Assigned(fProject) Then
        (Sender As TCustomAction).Enabled :=
            Not (fProject.CurrentProfile.typ = dptStat)
    Else
        (Sender As TCustomAction).Enabled := PageControl.PageCount > 0;
End;

Procedure TMainForm.actRunUpdate(Sender: TObject);
Begin
    If Assigned(fProject) Then
        (Sender As TCustomAction).Enabled :=
            Not (fProject.CurrentProfile.typ = dptStat) And Not
            devExecutor.Running And Not fDebugger.Executing And
            Not fCompiler.Compiling
    Else
        (Sender As TCustomAction).Enabled :=
            (PageControl.PageCount > 0) And Not devExecutor.Running And
            Not fDebugger.Executing And Not fCompiler.Compiling;
End;

Procedure TMainForm.PageControlChange(Sender: TObject);
Var
    e: TEditor;
    i, x, y: Integer;
    intActivePage: Integer;
{$IFDEF PLUGIN_BUILD}
    pluginCatched: Boolean;
{$ENDIF}
Begin
    intActivePage := PageControl.ActivePageIndex;

    If intActivePage > -1 Then
    Begin
        e := GetEditor(intActivePage);
        If Assigned(e) Then
        Begin
{$IFDEF PLUGIN_BUILD}
            pluginCatched := False;
            For i := 0 To pluginsCount - 1 Do
                pluginCatched :=
                    pluginCatched Or plugins[i].MainPageChanged(e.FileName);
            If Not pluginCatched Then
            Begin
{$ENDIF}
                e.Text.SetFocus;
                If ClassBrowser1.Enabled Then
                    ClassBrowser1.CurrentFile := e.FileName;
                For i := 1 To 9 Do
                Begin
                    If e.Text.GetBookMark(i, x, y) Then
                    Begin
                        TogglebookmarksPopItem.Items[i - 1].Checked := True;
                        TogglebookmarksItem.Items[i - 1].Checked := True;
                    End
                    Else
                    Begin
                        TogglebookmarksPopItem.Items[i - 1].Checked := False;
                        TogglebookmarksItem.Items[i - 1].Checked := False;
                    End;
                End;
{$IFDEF PLUGIN_BUILD}
            End;
{$ENDIF}
        End;
        UpdateAppTitle;
    End;
    RefreshTodoList;
End;

Procedure TMainForm.actConfigShortcutsExecute(Sender: TObject);
Begin
    devShortcuts1.Edit;
End;

Procedure TMainForm.DateTimeMenuItemClick(Sender: TObject);
Var e: TEditor;
Begin
    e := GetEditor;
    If assigned(e) Then
        e.InsertString(FormatDateTime('dd/mm/yy hh:nn', Now), True);
End;

Procedure TMainForm.actProgramResetExecute(Sender: TObject);
Begin
    devExecutor.Reset;
End;

Procedure TMainForm.actProgramResetUpdate(Sender: TObject);
Begin
    If Assigned(fProject) Then
        (Sender As TCustomAction).Enabled :=
            Not (fProject.CurrentProfile.typ = dptStat) And devExecutor.Running
    Else
        (Sender As TCustomAction).Enabled :=
            (PageControl.PageCount > 0) And devExecutor.Running;
End;

Procedure TMainForm.CommentheaderMenuItemClick(Sender: TObject);
Var  e: TEditor;
Begin
    e := GetEditor;
    If assigned(e) Then
    Begin
        e.InsertString('/*' + #13#10 +
            '  Name: ' + #13#10 +
            '  Copyright: ' + #13#10 +
            '  Author: ' + #13#10 +
            '  Date: ' + FormatDateTime('dd/mm/yy hh:nn', Now) + #13#10 +
            '  Description: ' + #13#10 +
            '*/' + #13#10, True);
    End;
End;

Procedure TMainForm.PageControlMouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
    I: Integer;
    Allow: Boolean;
Begin
    I := PageControl.IndexOfTabAt(X, Y);
    If Button = mbRight Then
    Begin // select new tab even with right mouse button
        If I > -1 Then
        Begin
            PageControl.ActivePageIndex := I;
            PageControl.OnChanging(PageControl, Allow);
            PageControl.OnChange(PageControl);
        End;
    End
    Else // see if it's a drag operation
        PageControl.Pages[PageControl.ActivePageIndex].BeginDrag(False);
End;

Procedure TMainForm.actNewTemplateUpdate(Sender: TObject);
Begin
    actNewTemplate.Enabled := Assigned(fProject);
End;

Procedure TMainForm.actCommentExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If Assigned(e) Then
        e.CommentSelection;
End;

Procedure TMainForm.actUncommentExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If Assigned(e) Then
        e.UncommentSelection;
End;

Procedure TMainForm.actIndentExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If Assigned(e) Then
        e.IndentSelection;
End;

Procedure TMainForm.actUnindentExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    e := GetEditor;
    If Assigned(e) Then
        e.UnindentSelection;
End;

Procedure TMainForm.PageControlDragOver(Sender, Source: TObject; X,
    Y: Integer; State: TDragState; Var Accept: Boolean);
Var
    I: Integer;
Begin
    I := PageControl.IndexOfTabAt(X, Y);
    Accept := (Source Is TTabSheet) And (I <> PageControl.ActivePageIndex);
End;

Procedure TMainForm.PageControlDragDrop(Sender, Source: TObject; X,
    Y: Integer);
Var
    I: Integer;
Begin
    I := PageControl.IndexOfTabAt(X, Y);
    If (Source Is TTabSheet) And (I <> PageControl.ActivePageIndex) Then
        PageControl.Pages[PageControl.ActivePageIndex].PageIndex := I;
End;

Procedure TMainForm.actGotoFunctionExecute(Sender: TObject);
Var
    e: TEditor;
    st: PStatement;
Begin
    With TFunctionSearchForm.Create(Self) Do
    Begin
        fFileName := GetEditor.FileName;
        fParser := CppParser1;
        If ShowModal = mrOK Then
        Begin
            st := PStatement(lvEntries.Selected.Data);
            //make sure statement still exists
            If fParser.Statements.IndexOf(lvEntries.Selected.Data) = -1 Then
                lvEntries.Selected.Data := Nil;
            e := GetEditor;
            If Assigned(e) And Assigned(st) Then
            Begin
                If st^._IsDeclaration Then
                    e.GotoLineNr(st^._DeclImplLine)
                Else
                    e.GotoLineNr(st^._Line);
            End;
        End;
    End;
End;

Procedure TMainForm.actBrowserGotoDeclUpdate(Sender: TObject);
Begin
    (Sender As TAction).Enabled := Assigned(ClassBrowser1.Selected);
End;

Procedure TMainForm.actBrowserGotoImplUpdate(Sender: TObject);
Begin
    If Assigned(ClassBrowser1)
        And ClassBrowser1.Enabled
        And Assigned(ClassBrowser1.Selected)
        And Assigned(ClassBrowser1.Selected.Data) Then
        //check if node.data still in statements
        If CppParser1.Statements.IndexOf(ClassBrowser1.Selected.Data) >= 0 Then

            If Assigned(ClassBrowser1) Then
                (Sender As TAction).Enabled :=
                    (PStatement(ClassBrowser1.Selected.Data)^._Kind <> skClass)
            Else
                (Sender As TAction).Enabled := False

        Else
        Begin
            ClassBrowser1.Selected.Data := Nil;
            (Sender As TAction).Enabled := False;
        End
    Else
        (Sender As TAction).Enabled := False;
End;

Procedure TMainForm.actBrowserNewClassUpdate(Sender: TObject);
Begin
    If (Assigned(ClassBrowser1) And Assigned(fProject)) Then
        (Sender As TAction).Enabled := ClassBrowser1.Enabled
            And Assigned(fProject)
    Else
        (Sender As TAction).Enabled := False;
End;

Procedure TMainForm.actBrowserNewMemberUpdate(Sender: TObject);
Begin
    If Assigned(ClassBrowser1.Selected)
        And Assigned(ClassBrowser1.Selected.Data) Then
        //check if node.data still in statements
        If CppParser1.Statements.IndexOf(ClassBrowser1.Selected.Data) >= 0 Then
            If Assigned(ClassBrowser1) Then
                (Sender As TAction).Enabled :=
                    (PStatement(ClassBrowser1.Selected.Data)^._Kind = skClass)
            Else
                (Sender As TAction).Enabled := False
        Else
        Begin
            ClassBrowser1.Selected.Data := Nil;
            (Sender As TAction).Enabled := False;
        End
    Else
        (Sender As TAction).Enabled := False;
End;

Procedure TMainForm.actBrowserNewVarUpdate(Sender: TObject);
Begin
    If Assigned(ClassBrowser1.Selected)
        And Assigned(ClassBrowser1.Selected.Data) Then
        //check if node.data still in statements
        If CppParser1.Statements.IndexOf(ClassBrowser1.Selected.Data) >= 0 Then
            If Assigned(ClassBrowser1) Then
                (Sender As TAction).Enabled :=
                    (PStatement(ClassBrowser1.Selected.Data)^._Kind = skClass)
            Else
                (Sender As TAction).Enabled := False
        Else
        Begin
            ClassBrowser1.Selected.Data := Nil;
            (Sender As TAction).Enabled := False;
        End
    Else
        (Sender As TAction).Enabled := False;
End;

Procedure TMainForm.actBrowserAddFolderUpdate(Sender: TObject);
Begin
    If (Assigned(ClassBrowser1) And Assigned(fProject)) Then
        (Sender As TAction).Enabled := ClassBrowser1.Enabled
            And Assigned(fProject)
    Else
        (Sender As TAction).Enabled := False;
End;

Procedure TMainForm.actBrowserViewAllUpdate(Sender: TObject);
Begin
    (Sender As TAction).Enabled := True;
End;

Procedure TMainForm.actBrowserGotoDeclExecute(Sender: TObject);
Var
    e: TEditor;
    Node: TTreeNode;
    fname: String;
    line: Integer;
Begin
    Node := ClassBrowser1.Selected;
    fName := CppParser1.GetDeclarationFileName(Node.Data);
    line := CppParser1.GetDeclarationLine(Node.Data);
    e := GetEditorFromFileName(fname);
    If Assigned(e) Then
        e.GotoLineNr(line);
End;

Procedure TMainForm.actBrowserGotoImplExecute(Sender: TObject);
Var
    e: TEditor;
    Node: TTreeNode;
    fname: String;
    line: Integer;
Begin
    Node := ClassBrowser1.Selected;
    fName := CppParser1.GetImplementationFileName(Node.Data);
    line := CppParser1.GetImplementationLine(Node.Data);
    e := GetEditorFromFileName(fname);
    If Assigned(e) Then
        e.GotoLineNr(line);
End;

Procedure TMainForm.actBrowserNewClassExecute(Sender: TObject);
Begin
    TNewClassForm.Create(Self).ShowModal;
End;

Procedure TMainForm.actBrowserNewMemberExecute(Sender: TObject);
Begin
    TNewMemberForm.Create(Self).ShowModal;
End;

Procedure TMainForm.actBrowserNewVarExecute(Sender: TObject);
Begin
    TNewVarForm.Create(Self).ShowModal;
End;

Procedure TMainForm.actBrowserViewAllExecute(Sender: TObject);
Begin
    ClassBrowser1.ShowFilter := sfAll;
    actBrowserViewAll.Checked := True;
    actBrowserViewProject.Checked := False;
    actBrowserViewCurrent.Checked := False;
    devClassBrowsing.ShowFilter := Ord(sfAll);
End;

Procedure TMainForm.actBrowserViewProjectExecute(Sender: TObject);
Begin
    ClassBrowser1.ShowFilter := sfProject;
    actBrowserViewAll.Checked := False;
    actBrowserViewProject.Checked := True;
    actBrowserViewCurrent.Checked := False;
    devClassBrowsing.ShowFilter := Ord(sfProject);
End;

Procedure TMainForm.actBrowserViewCurrentExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    ClassBrowser1.ShowFilter := sfCurrent;
    actBrowserViewAll.Checked := False;
    actBrowserViewProject.Checked := False;
    actBrowserViewCurrent.Checked := True;
    e := GetEditor;
    If Assigned(e) Then
        ClassBrowser1.CurrentFile := e.FileName
    Else
        ClassBrowser1.CurrentFile := '';
    devClassBrowsing.ShowFilter := Ord(sfCurrent);
End;

Procedure TMainForm.actProfileProjectExecute(Sender: TObject);
Var
    optP, optD: TCompilerOption;
    idxP, idxD: Integer;
    prof, deb: Boolean;
Begin
    //todo: disable profiling for non gcc compilers
    // see if profiling is enabled
    If (assigned(fProject) And
        ((fProject.CurrentProfile.compilerType <> ID_COMPILER_MINGW) Or
        (fProject.CurrentProfile.compilerType <> ID_COMPILER_LINUX))) Then
    Begin
        ShowMessage('Profiling is Disabled for Non-MingW compilers.');
        exit;
    End;
    prof := devCompiler.FindOption('-pg', optP, idxP);
    If prof Then
    Begin
        If Assigned(fProject) Then
        Begin
            If (fProject.CurrentProfile.CompilerOptions <> '') And
                (fProject.CurrentProfile.CompilerOptions[idxP + 1] = '1') Then
                prof := True
            Else
                prof := False;
        End
        Else
            prof := optP.optValue > 0;
    End;
    // see if debugging is enabled
    deb := devCompiler.FindOption('-g3', optD, idxD);
    If deb Then
    Begin
        If Assigned(fProject) Then
        Begin
            If (fProject.CurrentProfile.CompilerOptions <> '') And
                (fProject.CurrentProfile.CompilerOptions[idxD + 1] = '1') Then
                deb := True
            Else
                deb := False;
        End
        Else
            deb := optD.optValue > 0;
    End;

    If (Not prof) Or (Not deb) Then
        If MessageDlg(Lang[ID_MSG_NOPROFILE], mtConfirmation,
            [mbYes, mbNo], 0) = mrYes Then
        Begin
            optP.optValue := 1;
            If Assigned(fProject) Then
                SetProjCompOpt(idxP, True);
            devCompiler.Options[idxP] := optP;
            optD.optValue := 1;
            If Assigned(fProject) Then
                SetProjCompOpt(idxD, True);
            devCompiler.Options[idxD] := optD;

            // Check for strip executable
            If devCompiler.FindOption('-s', optD, idxD) Then
            Begin
                optD.optValue := 0;
                If Not Assigned(fProject) Then
                    devCompiler.Options[idxD] := optD;
                // set global debugging option only if not working with a project
                SetProjCompOpt(idxD, False);
                // set the project's correpsonding option too
            End;

            actRebuildExecute(Nil);
            Exit;
        End
        Else
            Exit;
    If Assigned(fProject) Then
        If Not FileExists(ExtractFilePath(fProject.Executable) +
            GPROF_CHECKFILE) Then
        Begin
            MessageDlg(Lang[ID_MSG_NORUNPROFILE], mtError, [mbOk], 0);
            Exit;
        End;
    If Not Assigned(ProfileAnalysisForm) Then
        ProfileAnalysisForm := TProfileAnalysisForm.Create(Self);
    ProfileAnalysisForm.Show;
End;

Procedure TMainForm.actBrowserAddFolderExecute(Sender: TObject);
Var
    S: String;
    Node: TTreeNode;
Begin
    If ClassBrowser1.FolderCount >= MAX_CUSTOM_FOLDERS Then
    Begin
        MessageDlg(Format(Lang[ID_POP_MAXFOLDERS], [MAX_CUSTOM_FOLDERS]),
            mtError, [mbOk], 0);
        Exit;
    End;

    Node := ClassBrowser1.Selected;
    S := 'New folder';
    If InputQuery(Lang[ID_POP_ADDFOLDER], Lang[ID_MSG_ADDBROWSERFOLDER], S) And
        (S <> '') Then
        ClassBrowser1.AddFolder(S, Node);
End;

Procedure TMainForm.actBrowserRemoveFolderExecute(Sender: TObject);
Begin
    If Assigned(ClassBrowser1.Selected) And
        (ClassBrowser1.Selected.ImageIndex =
        ClassBrowser1.ItemImages.Globals) Then
        If MessageDlg(Lang[ID_MSG_REMOVEBROWSERFOLDER], mtConfirmation,
            [mbYes, mbNo], 0) = mrYes Then
            ClassBrowser1.RemoveFolder(ClassBrowser1.Selected.Text);
End;

Procedure TMainForm.actBrowserRenameFolderExecute(Sender: TObject);
Var
    S: String;
Begin
    If Assigned(ClassBrowser1.Selected) And
        (ClassBrowser1.Selected.ImageIndex =
        ClassBrowser1.ItemImages.Globals) Then
    Begin
        S := ClassBrowser1.Selected.Text;
        If InputQuery(Lang[ID_POP_RENAMEFOLDER],
            Lang[ID_MSG_RENAMEBROWSERFOLDER],
            S) And (S <> '') Then
            ClassBrowser1.RenameFolder(ClassBrowser1.Selected.Text, S);
    End;
End;

Procedure TMainForm.actCloseAllButThisExecute(Sender: TObject);
Var
    idx: Integer;
    current: Integer;
    e: TEditor;
    curFilename, tempFileName: String;
{$IFDEF PLUGIN_BUILD}
    //tempEditor: TEditor;
    //pluginCatched : Boolean;
{$ENDIF}
Begin
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
    While idx < PageControl.PageCount Do
    Begin
{$IFDEF PLUGIN_BUILD}
    {curFilename := AnsiLowerCase(GetEditor(idx).FileName);
    pluginCatched := false;
    if tempEditor <> nil then
        pluginCatched := plugins[unit_plugins[tempEditor.AssignedPlugin]].ShouldNotCloseEditor(tempEditor.FileName, curFilename);
    }
{$ENDIF}
        If (idx = current) Then //or pluginCatched then
            idx := idx + 1
        Else
        Begin
            If Not CloseEditor(idx, True, True) Then
                // EAB: use true in third parameter to prevent closing all unit files
                Break
            Else
            Begin
                If idx < current Then
                    current := current - 1;
            End;
        End;
    End;

    e := GetEditor;
    If Assigned(e) Then
    Begin
        // don't know why, but at this point the editor does not show its caret.
        // if we shift the focus to another control and back to the editor,
        // everything is fine. (I smell another SynEdit bug?)
        e.TabSheet.SetFocus;
{$IFDEF PLUGIN_BUILD}
        e.Activate;
{$ELSE}
        e.Text.SetFocus;
{$ENDIF}
    End;
End;

Procedure TMainForm.lvBacktraceDblClick(Sender: TObject);
Var
    idx: Integer;
    e: TEditor;
Begin
    If Assigned(lvBacktrace.Selected) And
        (lvBackTrace.Selected.SubItems.Count >= 3) Then
    Begin
        idx := StrToIntDef(lvBacktrace.Selected.SubItems[2], -1);
        If idx <> -1 Then
        Begin
            e := GetEditorFromFileName(CppParser1.GetFullFilename(
                lvBacktrace.Selected.SubItems[1]));
            If Assigned(e) Then
            Begin
                If fDebugger.Paused Then
                    fDebugger.SetFrame(lvBacktrace.Selected.Index);
                e.GotoLineNr(idx);
                e.Activate;
            End;
        End;
    End;
End;

Procedure TMainForm.GotoTopOfStackTrace;
Var
    I: Integer;
    Idx: Integer;
    e: TEditor;
Begin
    For I := 0 To lvBacktrace.Items.Count - 1 Do
        If (lvBackTrace.Items[I].SubItems.Count >= 3) And
            (lvBackTrace.Items[I].SubItems[2] <> '') Then
        Begin
            idx := StrToIntDef(lvBacktrace.Items[I].SubItems[2], -1);
            If idx <> -1 Then
            Begin
                e := GetEditorFromFileName(CppParser1.GetFullFilename(
                    lvBacktrace.Items[I].SubItems[1]));
                If Assigned(e) Then
                Begin
                    e.SetActiveBreakpointFocus(idx);
                    Break;
                End;
            End;
        End;
End;

Procedure TMainForm.lvBacktraceCustomDrawItem(Sender: TCustomListView;
    Item: TListItem; State: TCustomDrawState; Var DefaultDraw: Boolean);
Begin
    If Not (cdsSelected In State) Then
    Begin
        If Assigned(Item.Data) Then
            Sender.Canvas.Font.Color := clBlue
        Else
            Sender.Canvas.Font.Color := clWindowText;
    End;
End;

Procedure TMainForm.lvBacktraceMouseMove(Sender: TObject;
    Shift: TShiftState; X, Y: Integer);
Var
    It: TListItem;
Begin
    With Sender As TListView Do
    Begin
        It := GetItemAt(X, Y);
        If Assigned(It) And Assigned(It.Data) Then
            Cursor := crHandPoint
        Else
            Cursor := crDefault;
    End;
End;

Procedure TMainForm.lvThreadsDblClick(Sender: TObject);
Begin
    If lvThreads.Selected <> Nil Then
        fDebugger.SetThread(StrToInt(lvThreads.Selected.SubItems[0]));
End;

Procedure TMainForm.devFileMonitorNotifyChange(Sender: TObject;
    ChangeType: TdevMonitorChangeType; Filename: String);
Var
    Entry: PReloadFile;
Begin
    Entry := New(PReloadFile);
    ReloadFilenames.Add(Entry);
    Entry^.FileName := FileName;
    Entry^.ChangeType := ChangeType;

    If Not IsIconized Then
        HandleFileMonitorChanges;
End;

Procedure TMainForm.HandleFileMonitorChanges;
Var
    I: Integer;
    Procedure ReloadEditor(FileName: String);
    Var
        e: TEditor;
        p: TBufferCoord;
{$IFDEF PLUGIN_BUILD}
        j: Integer;
        pluginForm: Boolean;
{$ENDIF}
    Begin
        e := GetEditorFromFileName(Filename);
        If Assigned(e) Then
        Begin
{$IFDEF PLUGIN_BUILD}
            pluginForm := False;
            For j := 0 To pluginsCount - 1 Do
                pluginForm := pluginForm Or plugins[j].ReloadForm(Filename);
            If Not pluginForm Then
{$ENDIF}
            Begin
                p := e.Text.CaretXY;
                e.Text.Lines.LoadFromFile(Filename);
                If (p.Line <= e.Text.Lines.Count) Then
                    e.Text.CaretXY := p;
            End;
        End;
    End;
Begin
    If ReloadFilenames.Count = 1 Then
    Begin
        With PReloadFile(ReloadFilenames[0])^ Do
            Case ChangeType Of
                mctChanged:
                    If MessageDlg(Filename +
                        ' has been modified outside of wxDev-C++.'#13#10#13#10 +
                        'Do you want to reload the file from disk? This will discard all your unsaved changes.',
                        mtConfirmation, [mbYes, mbNo], Handle) = mrYes Then
                        ReloadEditor(Filename);
                mctDeleted:
                    MessageDlg(Filename + ' has been renamed or deleted.',
                        mtInformation, [mbOk], Handle);
            End;
        ReloadFilenames.Clear;
    End
    Else
    If ReloadFilenames.Count <> 0 Then
    Begin
        If Assigned(FilesReloadForm) Then
            FilesReloadForm.Files := ReloadFilenames
        Else
        Begin
            FilesReloadForm := TFilesReloadFrm.Create(Self);
            FilesReloadForm.Files := ReloadFilenames;
            If FilesReloadForm.ShowModal = mrOK Then
                For I := 0 To FilesReloadForm.lbModified.Count - 1 Do
                    If FilesReloadForm.lbModified.Checked[I] Then
                        ReloadEditor(FilesReloadForm.lbModified.Items[I]);

            //Then free the dialog and clean up
            ReloadFilenames.Clear;
            FilesReloadForm.Free;
            FilesReloadForm := Nil;
        End;
    End;
End;

Procedure TMainForm.actFilePropertiesExecute(Sender: TObject);
Begin
    With TFilePropertiesForm.Create(Self) Do
    Begin
        If TAction(Sender).ActionComponent = mnuUnitProperties Then
            If Assigned(fProject) And
                Assigned(ProjectView.Selected) And
                (ProjectView.Selected.Data <> Pointer(-1)) Then
                SetFile(fProject.Units[Integer(ProjectView.Selected.Data)].FileName);
        ShowModal;
    End;
End;

Procedure TMainForm.actViewToDoListUpdate(Sender: TObject);
Begin
    ToDoList1.Checked := GetFormVisible(frmReportDocks[5]);
End;

Procedure TMainForm.actViewToDoListExecute(Sender: TObject);
Begin
    With ToDolist1 Do
        If Checked Then
            HideDockForm(frmReportDocks[5])
        Else
            ShowDockForm(frmReportDocks[5]);
End;

Procedure TMainForm.actAddToDoExecute(Sender: TObject);
Begin
    With TAddToDoForm.Create(Self) Do
        Try
            ShowModal;
            RefreshTodoList;
        Finally
            Free;
        End;
End;

Procedure TMainForm.actProjectNewFolderExecute(Sender: TObject);
Var
    fp, S: String;
Begin
    S := 'New folder';
    If InputQuery(Lang[ID_POP_ADDFOLDER], Lang[ID_MSG_ADDBROWSERFOLDER], S) And
        (S <> '') Then
    Begin
        fp := fProject.GetFolderPath(ProjectView.Selected);
        If fp <> '' Then
            fProject.AddFolder(fp + '/' + S)
        Else
            fProject.AddFolder(S);
    End;
End;

Procedure TMainForm.actProjectRemoveFolderExecute(Sender: TObject);
Var
    node: TTreeNode;
Begin
    If Not Assigned(fProject) Then
        Exit;

    If Assigned(ProjectView.Selected) And
        (ProjectView.Selected.Data = Pointer(-1)) Then
        If MessageDlg(Lang[ID_MSG_REMOVEBROWSERFOLDER], mtConfirmation,
            [mbYes, mbNo], 0) = mrYes Then
        Begin
            ProjectView.Items.BeginUpdate;
            node := ProjectView.Selected;
            If assigned(node) And (node.Data = Pointer(-1)) And
                (node.Level >= 1) Then
                fProject.RemoveFolder(fProject.GetFolderPath(node));
            ProjectView.TopItem.AlphaSort(False);
            ProjectView.Selected.Delete;
            ProjectView.Items.EndUpdate;
            fProject.UpdateFolders;
        End;
End;

Procedure TMainForm.actProjectRenameFolderExecute(Sender: TObject);
Var
    S: String;
Begin
    If Assigned(ProjectView.Selected) And
        (ProjectView.Selected.Data = Pointer(-1)) Then
    Begin
        S := ProjectView.Selected.Text;
        If InputQuery(Lang[ID_POP_RENAMEFOLDER],
            Lang[ID_MSG_RENAMEBROWSERFOLDER],
            S) And (S <> '') Then
        Begin
            ProjectView.Selected.Text := S;
            fProject.UpdateFolders;
        End;
    End;
End;

Procedure TMainForm.ProjectViewDragOver(Sender, Source: TObject; X,
    Y: Integer; State: TDragState; Var Accept: Boolean);
Var
    Item: TTreeNode;
    Hits: THitTests;
Begin
    Hits := ProjectView.GetHitTestInfoAt(X, Y);
    If ([htOnItem, htOnRight, htToRight] * Hits) <> [] Then
        Item := ProjectView.GetNodeAt(X, Y)
    Else
        Item := Nil;
    Accept :=
        (
        (Sender = ProjectView) And Assigned(ProjectView.Selected) And
        Assigned(Item)  //and
        // drop node is a folder or the project
        And ((Item.Data = Pointer(-1)) Or (Item.SelectedIndex = 0)));
End;

Procedure TMainForm.ProjectViewDragDrop(Sender, Source: TObject; X,
    Y: Integer);
Var
    Item: TTreeNode;
    srcNode: TTreeNode;
    WasExpanded: Boolean;
    I: Integer;
Begin
    If Not (Source Is TTreeView) Then
        exit;
    If ([htOnItem, htOnRight, htToRight] *
        ProjectView.GetHitTestInfoAt(X, Y)) <> [] Then
        Item := ProjectView.GetNodeAt(X, Y)
    Else
        Item := Nil;
    For I := 0 To ProjectView.SelectionCount - 1 Do
    Begin
        srcNode := ProjectView.Selections[I];
        If Not Assigned(Item) Then
        Begin
            fProject.Units[Integer(srcNode.Data)].Folder := '';
            srcNode.MoveTo(ProjectView.Items[0], naAddChild);
        End
        Else
        Begin
            If srcNode.Data <> Pointer(-1) Then
            Begin
                If Item.Data = Pointer(-1) Then
                    fProject.Units[Integer(srcNode.Data)].Folder :=
                        fProject.GetFolderPath(Item)
                Else
                    fProject.Units[Integer(srcNode.Data)].Folder := '';
            End;
            WasExpanded := Item.Expanded;
            ProjectView.Items.BeginUpdate;
            srcNode.MoveTo(Item, naAddChild);
            If Not WasExpanded Then
            Begin
                Item.Collapse(False);
            End;
            Item.AlphaSort(False);
            ProjectView.Items.EndUpdate;

            fProject.UpdateFolders;
        End;
    End;
End;

Procedure TMainForm.actImportMSVCExecute(Sender: TObject);
Begin
    With TImportMSVCForm.Create(Self) Do
    Begin
        If ShowModal = mrOK Then
            OpenProject(GetFilename);
    End;
End;

Procedure TMainForm.AddWatchPopupItemClick(Sender: TObject);
Var  s: String;
    e: TEditor;
Begin
    e := GetEditor;
    s := e.Text.GetWordAtRowCol(e.Text.CaretXY);
    If s <> '' Then
        AddDebugVar(s, wbWrite);
End;

// RNC -- 07-02-2004
// I changed the way the run to cursor works to make it more compatible with
// MSVC++.
// Run to cursor no longer sets a breakpoint.  It will try to run to the wherever the
// cusor is.  If there happens to be a breakpoint before that, the debugging stops there
// and the run to cursor value is removed.  (it will not stop there if you press continue)
Procedure TMainForm.actRunToCursorExecute(Sender: TObject);
Var
    e: TEditor;
    line: Integer;
Begin
    e := GetEditor;
    line := e.Text.CaretY;
    // If the debugger is not running, set the breakpoint to the current line and
    // start the debugger
    If Not fDebugger.Executing Then
    Begin
        e.RunToCursor(line);
        actDebug.Execute;
    End

    // Otherwise, make sure that the debugger is stopped so that breakpoints can
    // be added. Also ensure that the cursor is not on a line that is already marked
    // as a breakpoint
    Else
    If Assigned(fDebugger) Then
        If fDebugger.Paused And
            (Not fDebugger.BreakpointExists(e.Filename, line)) Then
            If assigned(e) Then
                e.RunToCursor(line);

    // If we are broken and the run to cursor location is the same as the current
    // breakpoint, just continue to try to run to the current location
    If Assigned(fDebugger) Then
        If fDebugger.Paused Then
            fDebugger.Go;

End;

Procedure TMainForm.btnSendCommandClick(Sender: TObject);
Begin
    If Assigned(fDebugger) Then
        If fDebugger.Executing Then
        Begin
            fDebugger.QueueCommand(edCommand.Text, '');
            edCommand.Clear;
        End;

End;

Procedure TMainForm.ViewCPUItemClick(Sender: TObject);
Begin
    If (Not fDebugger.Executing) Or (Not fDebugger.Paused) Then
        Exit;

    If Not (ViewCPUItem.Checked) Then
    Begin

        ViewCPUItem.Checked := True;
        If Not Assigned(debugCPUFrm) Then
            Application.CreateForm(TDebugCPUFrm, debugCPUFrm);

        debugCPUFrm.Show;
    End
    Else
    Begin
        ViewCPUItem.Checked := False;
        If Assigned(debugCPUFrm) Then
            debugCPUFrm.Hide;
    End;

End;

Procedure TMainForm.edCommandKeyPress(Sender: TObject; Var Key: Char);
Begin
    If key = #13 Then
        btnSendCommand.Click;
End;

Procedure TMainForm.CheckForDLLProfiling;
Var
    opts: TProjProfile;
    opt: TCompilerOption;
    idx: Integer;
Begin
    If Not Assigned(fProject) Then
        Exit;

    // profiling not enabled
    If Not devCompiler.FindOption('-pg', opt, idx) Then
        Exit;

    opts := TProjProfile.Create;

    If (fProject.CurrentProfile.typ In [dptDyn, dptStat]) And
        (opt.optValue > 0) Then
    Begin
        // project is a lib or a dll, and profiling is enabled
        // check for the existence of "-lgmon" in project's linker options
        If AnsiPos('-lgmon', fProject.CurrentProfile.Linker) = 0 Then
            // does not have -lgmon
            // warn the user that we should update its project options and include
            // -lgmon in linker options, or else the compilation will fail
            If MessageDlg(
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
                [mbYes, mbNo], 0) = mrYes Then
            Begin
                opts.CopyProfileFrom(fProject.CurrentProfile);
                opts.Linker := fProject.CurrentProfile.Linker + ' -lgmon';
                fProject.CurrentProfile.CopyProfileFrom(opts);
                fProject.Modified := True;
            End;
    End;
End;

Procedure TMainForm.actExecParamsExecute(Sender: TObject);
Begin
    ParamsForm := TParamsForm.Create(self);
    Try
        ParamsForm.ParamEdit.Text := fCompiler.RunParams;
        If Assigned(fProject) Then
            ParamsForm.HostEdit.Text :=
                fProject.CurrentProfile.HostApplication;
        If (Not Assigned(fProject)) Or
            (fProject.CurrentProfile.typ <> dptDyn) Then
            ParamsForm.DisableHost;
        If (ParamsForm.ShowModal = mrOk) Then
        Begin
            fCompiler.RunParams := ParamsForm.ParamEdit.Text;
            If (ParamsForm.HostEdit.Enabled) Then
                fProject.SetHostApplication(ParamsForm.HostEdit.Text);
        End;
    Finally
        ParamsForm.Free;
    End;
End;

Procedure TMainForm.actExecParamsUpdate(Sender: TObject);
Begin
    (Sender As TCustomAction).Enabled :=
        assigned(fProject) And Not devExecutor.Running And Not
        fDebugger.Executing And Not fCompiler.Compiling;
End;

Procedure TMainForm.DevCppDDEServerExecuteMacro(Sender: TObject;
    Msg: TStrings);
Var
    filename: String;
    i, n: Integer;
{$IFDEF PLUGIN_BUILD}
    j: Integer;
{$ENDIF}
Begin
    If Msg.Count > 0 Then
    Begin
        For i := 0 To Msg.Count - 1 Do
        Begin
            filename := Msg[i];
            If Pos('[Open(', filename) = 1 Then
            Begin
                n := Pos('"', filename);
                If n > 0 Then
                Begin
                    Delete(filename, 1, n);
                    n := Pos('"', filename);
                    If n > 0 Then
                        Delete(filename, n, maxint);
                    Try
                        Begin
              {$IFDEF PLUGIN_BUILD}
                            For j := 0 To pluginsCount - 1 Do
                                plugins[j].OpenFile(filename);
              {$ENDIF}
                            OpenFile(filename);
                        End;
                    Except
                    End;
                End;
            End;
        End;
        Application.BringToFront;
    End;
End;

Procedure TMainForm.actShowTipsExecute(Sender: TObject);
Begin
    With TTipOfTheDayForm.Create(Self) Do
    Begin
        chkNotAgain.Checked := Not devData.ShowTipsOnStart;
        Current := devData.LastTip;
        ShowModal;
        devData.LastTip := Current + 1;
        devData.ShowTipsOnStart := Not chkNotAgain.Checked;
    End;
End;

Procedure TMainForm.actBrowserUseColorsExecute(Sender: TObject);
Begin
    actBrowserUseColors.Checked := Not actBrowserUseColors.Checked;
    devClassBrowsing.UseColors := actBrowserUseColors.Checked;
    ClassBrowser1.UseColors := actBrowserUseColors.Checked;
    ClassBrowser1.Refresh;
End;

Procedure TMainForm.HelpMenuItemClick(Sender: TObject);
Begin
    Application.HelpFile := IncludeTrailingPathDelimiter(devDirs.Help) +
        DEV_MAINHELP_FILE;
    WordToHelpKeyword;
End;

Procedure TMainForm.WordToHelpKeyword;
Var
    tmp: String;
    e: TEditor;
Begin
    e := GetEditor;
    If Assigned(e) Then
    Begin
        tmp := e.GetWordAtCursor;

        If (tmp <> '') Then
        Begin
            HelpWindow := HtmlHelp(self.handle, Pchar(Application.HelpFile),
                HH_DISPLAY_INDEX, DWORD(Pchar(tmp)));
        End
        Else
        Begin
            tmp := e.Text.SelText;
            If (tmp <> '') Then
                HelpWindow :=
                    HtmlHelp(self.handle, Pchar(Application.HelpFile),
                    HH_DISPLAY_INDEX, DWORD(Pchar(tmp)))
            Else
                HelpWindow :=
                    HtmlHelp(self.handle, Pchar(Application.HelpFile),
                    HH_DISPLAY_TOPIC, 0);
        End;
    End
    Else
        HelpWindow := HtmlHelp(self.handle, Pchar(Application.HelpFile),
            HH_DISPLAY_TOPIC, 0);
End;

Procedure TMainForm.CppParser1StartParsing(Sender: TObject);
Begin
    StatusBar.Panels[3].Text := 'Please wait: Parsing in progress...';
    Screen.Cursor := crHourglass;
    If Not bProjectLoading Then
        alMain.State := asSuspended;
End;

Procedure TMainForm.CppParser1EndParsing(Sender: TObject);
Begin
    If Not bProjectLoading Then
        alMain.State := asNormal;
    Screen.Cursor := crDefault;
    StatusBar.Panels[3].Text := 'Ready.';

    // rebuild classes toolbar only if this was the last file scanned
    If CppParser1.FilesToScan.Count = 0 Then
        RebuildClassesToolbar;
End;

Procedure TMainForm.UpdateAppTitle;
Var
    ii: Integer;
    editorName: String;
Begin
    editorName := self.GetActiveEditorName;
    If Assigned(fProject) Then
    Begin
        If (editorName = '') Then
            Caption := Format('%s  - [ %s ]', [DEVCPP, fProject.Name])
        Else
            Caption := Format('%s  - [ %s ] - %s',
                [DEVCPP, fProject.Name, editorName]);
        Application.Title := Format('%s [%s]', [DEVCPP, fProject.Name]);
        //ExtractFilename(fProject.Filename)]);
    End
    Else
    Begin
        If (editorName = '') Then
            Caption := Format('%s', [DEVCPP])
        Else
            Caption := Format('%s  - [ %s ]', [DEVCPP, editorName]);
        Application.Title := Format('%s', [DEVCPP]);
    End;

    // Clear status bar text
    For ii := 0 To (StatusBar.Panels.Count - 1) Do
        StatusBar.Panels[ii].Text := '';

End;

Procedure TMainForm.PackageManagerItemClick(Sender: TObject);
Var s: String;
Begin
    s := IncludeTrailingPathDelimiter(devDirs.Exec) + PACKMAN_PROGRAM;
    ExecuteFile(s, '', IncludeTrailingPathDelimiter(devDirs.Exec), SW_SHOW);
End;

Procedure TMainForm.actAbortCompilationUpdate(Sender: TObject);
Begin
    TAction(Sender).Enabled := fCompiler.Compiling;
End;

Procedure TMainForm.actAbortCompilationExecute(Sender: TObject);
Begin
    fCompiler.AbortThread;
End;

Procedure TMainForm.actWindowMenuExecute(Sender: TObject);
Var Item: TMenuItem;
    E: TEditor;
    i: Integer;
    Act: TAction;
Begin
    While WindowMenu.Count > 8 Do
    Begin
        Item := WindowMenu.Items[7];
        WindowMenu.Remove(Item);
        Item.Free;
    End;
    For i := 0 To pred(PageControl.PageCount) Do
    Begin
        //Stop if we are doing more than 9 editors (Don't let the window menu grow too long)
        If (i >= 9) Then
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
        If e.FileName = '' Then
            Item.Caption := '&' + chr(49 + i) + ' Unnamed'
        Else
            Item.Caption := '&' + chr(49 + i) + ' ' + e.FileName;
        If e.Modified Then
            Item.Caption := Item.Caption + ' *';

        //And insert it into our menu
        WindowMenu.Insert(WindowMenu.Count - 1, Item);
    End;
End;

Procedure TMainForm.RemoveItem(Node: TTreeNode);
Begin
    If Assigned(Node) And (Node.Level >= 1) Then
    Begin
        If Node.Data = Pointer(-1) Then
            actProjectRemoveFolderExecute(Nil)
        Else
            fProject.Remove(Integer(Node.Data), True);
    End;
End;

Procedure TMainForm.ProjectViewChanging(Sender: TObject; Node: TTreeNode;
    Var AllowChange: Boolean);
Begin
    Node.MakeVisible;
End;

Procedure TMainForm.dynactOpenEditorByTagExecute(Sender: TObject);
Var E: TEditor;
Begin
    E := GetEditor(TAction(Sender).Tag);
    If E <> Nil Then
        E.Activate;
End;

Procedure TMainForm.actGotoProjectManagerExecute(Sender: TObject);
Begin
    LeftPageControl.ActivePageIndex := 0;
    ShowDockForm(frmProjMgrDock);
End;

Procedure TMainForm.actCVSImportExecute(Sender: TObject);
Begin
    DoCVSAction(Sender, caImport);
End;

Procedure TMainForm.actCVSCheckoutExecute(Sender: TObject);
Begin
    DoCVSAction(Sender, caCheckout);
End;

Procedure TMainForm.actCVSUpdateExecute(Sender: TObject);
Var
    I: Integer;
    e: TEditor;
    pt: TBufferCoord;
Begin
    actSaveAll.Execute;
    DoCVSAction(Sender, caUpdate);

    // Refresh CVS Changes
    For I := 0 To PageControl.PageCount - 1 Do
    Begin
        e := GetEditor(I);
        If Assigned(e) And FileExists(e.FileName) Then
        Begin
            pt := e.Text.CaretXY;
            e.Text.Lines.LoadFromFile(e.FileName);
            e.Text.CaretXY := pt;
        End;
    End;
End;

Procedure TMainForm.actCVSCommitExecute(Sender: TObject);
Begin
    DoCVSAction(Sender, caCommit);
End;

Procedure TMainForm.actCVSDiffExecute(Sender: TObject);
Begin
    DoCVSAction(Sender, caDiff);
End;

Procedure TMainForm.actCVSLogExecute(Sender: TObject);
Begin
    DoCVSAction(Sender, caLog);
End;

Procedure TMainForm.actCVSAddExecute(Sender: TObject);
Begin
    DoCVSAction(Sender, caAdd);
End;

Procedure TMainForm.actCVSRemoveExecute(Sender: TObject);
Begin
    DoCVSAction(Sender, caRemove);
End;

Procedure TMainForm.actCVSLoginExecute(Sender: TObject);
Begin
    DoCVSAction(Sender, caLogin);
End;

Procedure TMainForm.actCVSLogoutExecute(Sender: TObject);
Begin
    DoCVSAction(Sender, caLogout);
End;

Procedure TMainForm.DoCVSAction(Sender: TObject; whichAction: TCVSAction);
Var
    e: TEditor;
    idx: Integer;
    all: String;
    S: String;
Begin
    S := '';
    If Not FileExists(devCVSHandler.Executable) Then
    Begin
        MessageDlg(Lang[ID_MSG_CVSNOTCONFIGED], mtWarning, [mbOk], 0);
        Exit;
    End;
    e := GetEditor;
    If TAction(Sender).ActionComponent.Tag = 1 Then // project popup
        S := IncludeQuoteIfSpaces(fProject.FileName)
    Else
    If TAction(Sender).ActionComponent.Tag = 2 Then
    Begin // unit popup
        S := '';
        If ProjectView.Selected.Data = Pointer(-1) Then
        Begin // folder
            For idx := 0 To fProject.Units.Count - 1 Do
                If AnsiStartsStr(fProject.GetFolderPath(ProjectView.Selected),
                    fProject.Units[idx].Folder) Then
                    S := S + IncludeQuoteIfSpaces(
                        fProject.Units[idx].FileName) + ',';
            If S = '' Then
                S := 'ERR';
        End
        Else
            S := IncludeQuoteIfSpaces(
                fProject.Units[Integer(ProjectView.Selected.Data)].FileName);
    End
    Else
    If TAction(Sender).ActionComponent.Tag = 3 Then
        // editor popup or [CVS menu - current file]
        S := IncludeQuoteIfSpaces(e.FileName)
    Else
    If TAction(Sender).ActionComponent.Tag = 4 Then
    Begin // CVS menu - whole project
        If Assigned(fProject) Then
            S := ExtractFilePath(fProject.FileName)
        Else
        Begin
            If Assigned(e) Then
                S := ExtractFilePath(e.FileName)
            Else
                S := ExtractFilePath(devDirs.Default);
        End;
        S := IncludeQuoteIfSpaces(S);
    End;

    If Not Assigned(fProject) Then
        all := IncludeQuoteIfSpaces(S)
    Else
    Begin
        all := IncludeQuoteIfSpaces(fProject.FileName) + ',';
        For idx := 0 To fProject.Units.Count - 1 Do
            all := all + IncludeQuoteIfSpaces(
                fProject.Units[idx].FileName) + ',';
        Delete(all, Length(all), 1);
    End;

    With TCVSForm.Create(Self) Do
    Begin
        CVSAction := whichAction;
        Files.CommaText := S;
        AllFiles.CommaText := all;
        ShowModal;
    End;
End;

Procedure TMainForm.ListItemClick(Sender: TObject);
Var w: TWindowListForm;
    i: Integer;
Begin
    w := TWindowListForm.Create(self);
    Try
        For i := 0 To PageControl.PageCount - 1 Do
            w.UnitList.Items.Add(PageControl.Pages[i].Caption);
        If (w.ShowModal = mrOk) And (w.UnitList.ItemIndex > -1) Then
        Begin
            PageControl.ActivePageIndex := w.UnitList.ItemIndex;
        End;
    Finally
        w.Free;
    End;
End;

Procedure TMainForm.ProjectViewCompare(Sender: TObject; Node1,
    Node2: TTreeNode; Data: Integer; Var Compare: Integer);
Begin
    If (Node1.Data = pointer(-1)) And (Node2.Data = pointer(-1)) Then
        Compare := AnsiCompareStr(Node1.Text, Node2.Text)
    Else
    If Node1.Data = pointer(-1) Then
        Compare := -1
    Else
    If Node2.Data = pointer(-1) Then
        Compare := +1
    Else
        Compare := AnsiCompareStr(Node1.Text, Node2.Text);
End;

Procedure TMainForm.ProjectViewKeyPress(Sender: TObject; Var Key: Char);
Begin
    // fixs an annoying bug/behavior of the tree ctrl (a beep on enter key)
    If Key = #13 Then
        Key := #0;
End;

Procedure TMainForm.ProjectViewMouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Begin
    // bug-fix: when *not* clicking on an item, re-opens the last clicked file-node
    // this was introduced in the latest commit by XXXKF (?)
    If (Button = mbLeft) And Not
        (htOnItem In ProjectView.GetHitTestInfoAt(X, Y)) Then
        ProjectView.Selected := Nil;
End;

Procedure TMainForm.GoToClassBrowserItemClick(Sender: TObject);
Begin
    LeftPageControl.ActivePageIndex := 1;
    ShowDockForm(frmProjMgrDock);
End;

Procedure TMainForm.actBrowserShowInheritedExecute(Sender: TObject);
Begin
    actBrowserShowInherited.Checked := Not actBrowserShowInherited.Checked;
    devClassBrowsing.ShowInheritedMembers := actBrowserShowInherited.Checked;
    ClassBrowser1.ShowInheritedMembers := actBrowserShowInherited.Checked;
    ClassBrowser1.Refresh;
End;

Procedure TMainForm.OnHelpSearchWord(sender: TObject);
Var
    idx: Integer;
    aFile: String;
Begin
    idx := (Sender As TMenuItem).Tag;
    If idx >= fHelpFiles.Count Then
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
End;

Procedure TMainForm.AddWatchBtnClick(Sender: TObject);
Var
    e: TEditor;
    when: TWatchBreakOn;
Begin
    e := GetEditor;
    If Not Assigned(e) Then
        Exit;

    With TModifyVarForm.Create(Self) Do
        Try
            NameEdit.Text := e.GetWordAtCursor;
            ValueLabel.Enabled := False;
            ValueEdit.Enabled := False;
            If ShowModal = mrOK Then
            Begin
                If chkStopOnWrite.Checked Then
                    If chkStopOnRead.Checked Then
                        when := wbBoth
                    Else
                        when := wbWrite
                Else
                    when := wbRead;

                If Trim(NameEdit.Text) <> '' Then
                    AddDebugVar(NameEdit.Text, when);
            End;
        Finally
            Free;
        End;
End;

// TODO: Looks like setting the sender to nil (as done in some places in the code) generates an error.
Procedure TMainForm.ShowProjectInspItemClick(Sender: TObject);
Begin
    TMenuItem(Sender).Checked := Not TMenuItem(Sender).Checked;
    If TMenuItem(Sender).Checked Then
        ShowDockForm(frmProjMgrDock)
    Else
        HideDockForm(frmProjMgrDock);
End;

Procedure TMainForm.CompilerMessagesPanelItemClick(Sender: TObject);
Begin
    TMenuItem(Sender).Checked := Not TMenuItem(Sender).Checked;
    If TMenuItem(Sender).Checked Then
        ShowDockForm(frmReportDocks[0])
    Else
        HideDockForm(frmReportDocks[0]);
End;


Procedure TMainForm.ResourcesMessagesPanelItemClick(Sender: TObject);
Begin
    TMenuItem(Sender).Checked := Not TMenuItem(Sender).Checked;
    If TMenuItem(Sender).Checked Then
        ShowDockForm(frmReportDocks[1])
    Else
        HideDockForm(frmReportDocks[1]);
End;

Procedure TMainForm.CompileLogMessagesPanelItemClick(Sender: TObject);
Begin
    TMenuItem(Sender).Checked := Not TMenuItem(Sender).Checked;
    If TMenuItem(Sender).Checked Then
        ShowDockForm(frmReportDocks[2])
    Else
        HideDockForm(frmReportDocks[2]);
End;

Procedure TMainForm.DebuggingMessagesPanelItemClick(Sender: TObject);
Begin
    TMenuItem(Sender).Checked := Not TMenuItem(Sender).Checked;
    If TMenuItem(Sender).Checked Then
        ShowDockForm(frmReportDocks[3])
    Else
        HideDockForm(frmReportDocks[3]);
End;

Procedure TMainForm.FindResultsMessagesPanelItemClick(Sender: TObject);
Begin
    TMenuItem(Sender).Checked := Not TMenuItem(Sender).Checked;
    If TMenuItem(Sender).Checked Then
        ShowDockForm(frmReportDocks[4])
    Else
        HideDockForm(frmReportDocks[4]);
End;

Procedure TMainForm.ToDoListMessagesPanelItemClick(Sender: TObject);
Begin
    TMenuItem(Sender).Checked := Not TMenuItem(Sender).Checked;
    If TMenuItem(Sender).Checked Then
        ShowDockForm(frmReportDocks[5])
    Else
        HideDockForm(frmReportDocks[5]);
End;

Procedure TMainForm.SetProjCompOpt(idx: Integer; Value: Boolean);
Var
    projOpt: TProjProfile;
Begin
    If Not Assigned(fProject) Then
        Exit;

    //Copy the profile and make sure the compiler options string length is long enough
    //for us to include the change
    projOpt := TProjProfile.Create;
    projOpt.CopyProfileFrom(fProject.CurrentProfile);
    While Length(projOpt.CompilerOptions) <= idx Do
        projOpt.CompilerOptions := projOpt.CompilerOptions + '0';

    //Set the 'bit' of the options
    If Value Then
        projOpt.CompilerOptions[idx + 1] := '1'
    Else
        projOpt.CompilerOptions[idx + 1] := '0';

    //Then assign the profile back to the project
    fProject.CurrentProfile.CopyProfileFrom(projOpt);
    devCompiler.OptionStr := fProject.CurrentProfile.CompilerOptions;
    projOpt.Free;
End;

Procedure TMainForm.SetupProjectView;
Begin
    If devData.DblFiles Then
    Begin
        ProjectView.HotTrack := False;
        ProjectView.MultiSelect := True;
    End
    Else
    Begin
        ProjectView.HotTrack := True;
        ProjectView.MultiSelect := False;
    End;
End;

Procedure TMainForm.actCompileCurrentFileExecute(Sender: TObject);
Var
    e: TEditor;
Begin
    If fCompiler.Compiling Then
    Begin
        MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
        Exit;
    End;

    e := GetEditor;
    If Not Assigned(e) Then
        Exit;
    If Not PrepareForCompile(False) Then
        Exit;
    fCompiler.Compile(e.FileName);
    Application.ProcessMessages;
End;

Procedure TMainForm.actCompileCurrentFileUpdate(Sender: TObject);
Begin
    (Sender As TCustomAction).Enabled :=
        (assigned(fProject) And (PageControl.PageCount > 0)) And
        Not devExecutor.Running And Not fDebugger.Executing And
        Not fCompiler.Compiling;
End;

Procedure TMainForm.actSaveProjectAsExecute(Sender: TObject);
Begin
    If Not Assigned(fProject) Then
        Exit;
    With dmMain.SaveDialog Do
    Begin
        Filter := FLT_PROJECTS;
        If Execute Then
        Begin
            fProject.FileName := FileName;
            fProject.Save;
            UpdateAppTitle;
        End;
    End;
End;

Procedure TMainForm.BuildOpenWith;
Var
    idx, idx2: Integer;
    item: TMenuItem;
    ext, s, s1: String;
Begin
    mnuOpenWith.Clear;
    If Not assigned(fProject) Then
        exit;
    If Not assigned(ProjectView.Selected) Or
        (ProjectView.Selected.Level < 1) Then
        exit;
    If ProjectView.Selected.Data = Pointer(-1) Then
        Exit;
    idx := Integer(ProjectView.Selected.Data);

    ext := ExtractFileExt(fProject.Units[idx].FileName);
    idx2 := devExternalPrograms.AssignedProgram(ext);
    If idx2 <> -1 Then
    Begin
        item := TMenuItem.Create(Nil);
        item.Caption := ExtractFilename(devExternalPrograms.ProgramName[idx2]);
        item.Tag := idx2;
        item.OnClick := mnuOpenWithClick;
        mnuOpenWith.Add(item);
    End;
    If GetAssociatedProgram(ext, s, s1) Then
    Begin
        item := TMenuItem.Create(Nil);
        item.Caption := '-';
        item.Tag := -1;
        item.OnClick := mnuOpenWithClick;
        mnuOpenWith.Add(item);
        item := TMenuItem.Create(Nil);
        item.Caption := s1;
        item.Tag := -1;
        item.OnClick := mnuOpenWithClick;
        mnuOpenWith.Add(item);
    End;
End;

Function TMainForm.OpenWithAssignedProgram(strFileName: String): Boolean;
Var
    idx2, idx3: Integer;
Begin
    Result := False;

    If Not Assigned(fProject) Then
        Exit;
    If Not assigned(ProjectView.Selected) Or
        (ProjectView.Selected.Level < 1) Then
        exit;
    If ProjectView.Selected.Data = Pointer(-1) Then
        Exit;
    idx2 := Integer(ProjectView.Selected.Data);
    idx3 := devExternalPrograms.AssignedProgram(
        ExtractFileExt(fProject.Units[idx2].FileName));
    If idx3 = -1 Then
    Begin
        exit;
    End;
    ShellExecute(0, 'open',
        Pchar(devExternalPrograms.ProgramName[idx3]),
        Pchar(fProject.Units[idx2].FileName),
        Pchar(ExtractFilePath(fProject.Units[idx2].FileName)),
        SW_SHOW);

    Result := True;

End;

Procedure TMainForm.mnuOpenWithClick(Sender: TObject);
Var
    idx, idx2, idx3: Integer;
    item: TMenuItem;
Begin
    If (Sender = mnuOpenWith) And (mnuOpenWith.Count > 0) Then
        Exit;
    If Not Assigned(fProject) Then
        Exit;
    If Not assigned(ProjectView.Selected) Or
        (ProjectView.Selected.Level < 1) Then
        exit;
    If ProjectView.Selected.Data = Pointer(-1) Then
        Exit;
    idx2 := Integer(ProjectView.Selected.Data);

    item := Sender As TMenuItem;
    If item = mnuOpenWith Then
    Begin
        idx := -2;
        With dmMain.OpenDialog Do
        Begin
            Filter := FLT_ALLFILES;
            If Execute Then
                idx := devExternalPrograms.AddProgram(
                    ExtractFileExt(fProject.Units[idx2].FileName), Filename);
        End;
    End
    Else
        idx := item.Tag;
    idx3 := FileIsOpen(fProject.Units[idx2].FileName, True);
    If idx3 > -1 Then
        CloseEditor(idx3, True);

    If idx > -1 Then // devcpp-based
        ShellExecute(0, 'open',
            Pchar(devExternalPrograms.ProgramName[idx]),
            Pchar(fProject.Units[idx2].FileName),
            Pchar(ExtractFilePath(fProject.Units[idx2].FileName)),
            SW_SHOW)
    // idx=-2 means we prompted the user for a program, but didn't select one
    Else
    If idx <> -2 Then // registry-based
        ShellExecute(0, 'open',
            Pchar(fProject.Units[idx2].FileName),
            Nil,
            Pchar(ExtractFilePath(fProject.Units[idx2].FileName)),
            SW_SHOW);
End;

Procedure TMainForm.RebuildClassesToolbar;
Var
    I: Integer;
    st: PStatement;
    S: String;
Begin
    S := cmbClasses.Text;
    cmbClasses.Clear;
    cmbMembers.Clear;
    cmbClasses.Items.Add('(globals)');

    For I := 0 To CppParser1.Statements.Count - 1 Do
    Begin
        st := PStatement(CppParser1.Statements[I]);
        If st^._InProject And (st^._Kind In [skClass, skTypedef]) Then
            cmbClasses.Items.AddObject(st^._ScopelessCmd, Pointer(I));
    End;
    If S <> '' Then
    Begin
        cmbClasses.ItemIndex := cmbClasses.Items.IndexOf(S);
        cmbClassesChange(cmbClasses);
    End;
End;

Procedure TMainForm.cmbClassesChange(Sender: TObject);
Var
    I, idx: Integer;
    st: PStatement;
Begin
    cmbMembers.Clear;
    If cmbClasses.ItemIndex = -1 Then
        Exit;

    I := Integer(cmbClasses.Items.Objects[cmbClasses.ItemIndex]);
    If (I < 0) Or (I > CppParser1.Statements.Count - 1) Then
        Exit;

    If cmbClasses.ItemIndex > 0 Then
        idx := PStatement(CppParser1.Statements[I])^._ID
    Else
        idx := -1;

    For I := 0 To CppParser1.Statements.Count - 1 Do
    Begin
        st := PStatement(CppParser1.Statements[I]);
        If (st^._ParentID = idx) And st^._InProject And
            (st^._Kind In [skFunction, skConstructor, skDestructor]) Then
            cmbMembers.Items.AddObject(st^._ScopelessCmd +
                st^._Args, Pointer(I));
    End;
End;

Procedure TMainForm.cmbMembersChange(Sender: TObject);
Var
    I: Integer;
    st: PStatement;
    E: TEditor;
    fname: String;
Begin
    If cmbMembers.ItemIndex = -1 Then
        Exit;

    I := Integer(cmbMembers.Items.Objects[cmbMembers.ItemIndex]);
    If (I < 0) Or (I > CppParser1.Statements.Count - 1) Then
        Exit;

    st := PStatement(CppParser1.Statements[I]);
    If Not Assigned(st) Then
        Exit;

    If st^._IsDeclaration Then
    Begin
        I := st^._DeclImplLine;
        fname := st^._DeclImplFileName;
    End
    Else
    Begin
        I := st^._Line;
        fname := st^._FileName;
    End;

    E := GetEditorFromFilename(fname);
    If Assigned(E) Then
        E.GotoLineNr(I);
End;

Procedure TMainForm.CompilerOutputKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
{$IFDEF WIN32}
    If Key = VK_RETURN Then
{$ENDIF}

        CompilerOutputDblClick(sender);
End;

Procedure TMainForm.FindOutputKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
{$IFDEF WIN32}
    If Key = VK_RETURN Then
{$ENDIF}

        FindOutputDblClick(sender);
End;

Procedure TMainForm.DebugTreeKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
{$IFDEF WIN32}
    If Key = VK_DELETE Then
{$ENDIF}

        actRemoveWatchExecute(sender);
End;

Procedure TMainForm.DebugVarsPopupPopup(Sender: TObject);
Begin
    RemoveWatchPop.Enabled := Assigned(WatchTree.Selected);
End;

Procedure TMainForm.actAttachProcessUpdate(Sender: TObject);
Begin
    If assigned(fProject) And (fProject.CurrentProfile.typ = dptDyn) Then
    Begin
        (Sender As TCustomAction).Visible := True;
        (Sender As TCustomAction).Enabled := Not devExecutor.Running;
    End
    Else
        (Sender As TCustomAction).Visible := False;
End;

Procedure TMainForm.actAttachProcessExecute(Sender: TObject);
Var
    idx: Integer;
Begin
    PrepareDebugger;
    If assigned(fProject) Then
    Begin
        If Not FileExists(fProject.Executable) Then
        Begin
            MessageDlg(Lang[ID_ERR_PROJECTNOTCOMPILED], mtWarning, [mbOK], 0);
            exit;
        End;

        Try
            ProcessListForm := TProcessListForm.Create(self);
            If (ProcessListForm.ShowModal = mrOK) And
                (ProcessListForm.ProcessCombo.ItemIndex > -1) Then
            Begin
                // add to the debugger the project include dirs
                For idx := 0 To fProject.CurrentProfile.Includes.Count - 1 Do
                    fDebugger.AddIncludeDir(
                        fProject.CurrentProfile.Includes[idx]);

                fDebugger.Attach(Integer(
                    ProcessListForm.ProcessList[
                    ProcessListForm.ProcessCombo.ItemIndex]));
                fDebugger.RefreshBreakpoints;
                fDebugger.RefreshWatches;
                fDebugger.Go;
            End
        Finally
            ProcessListForm.Free;
        End;
    End;
End;

Procedure TMainForm.actModifyWatchExecute(Sender: TObject);
Var
    val: String;
    i: Integer;
    n: TTreeNode;
    Watch: PWatchPt;

Begin
    If (Not Assigned(WatchTree.Selected)) Or (Not fDebugger.Executing) Then
        exit;
    Watch := MainForm.WatchTree.Selected.Data;

    //Create the variable edit dialog
    ModifyVarForm := TModifyVarForm.Create(self);
    Try
        ModifyVarForm.NameEdit.Text := Watch.Name;
        ModifyVarForm.NameEdit.Enabled := False;
        ModifyVarForm.ValueEdit.Text := Watch.Value;

        ModifyVarForm.chkStopOnRead.Enabled := False;
        ModifyVarForm.chkStopOnWrite.Enabled := False;
        ModifyVarForm.chkStopOnRead.Checked := ((Watch.BPType = wbRead) Or (Watch.BPType = wbBoth));
        ModifyVarForm.chkStopOnWrite.Checked := ((Watch.BPType = wbWrite) Or (Watch.BPType = wbBoth));
        ModifyVarForm.ActiveWindow := ModifyVarForm.ValueEdit;
        If ModifyVarForm.ShowModal = mrOK Then
        Begin
            fDebugger.ModifyVariable(ModifyVarForm.NameEdit.Text,
                ModifyVarForm.ValueEdit.Text);
            fDebugger.RefreshContext;
        End;
    Finally
        ModifyVarForm.Free;
    End;
End;

Procedure TMainForm.ClearallWatchPopClick(Sender: TObject);
Var
    node: TTreeNode;
Begin

End;

Procedure TMainForm.HideCodeToolTip;
Var
    CurrentEditor: TEditor;
Begin
    CurrentEditor := GetEditor(PageControl.ActivePageIndex);
    If Assigned(CurrentEditor) And Assigned(CurrentEditor.CodeToolTip) Then
        CurrentEditor.CodeToolTip.ReleaseHandle;
End;

Procedure TMainForm.ApplicationEvents1Deactivate(Sender: TObject);
Begin
    //Hide the tooltip since we no longer have focus
    HideCodeToolTip;
    fIsIconized := True;
End;

Procedure TMainForm.ApplicationEvents1Activate(Sender: TObject);
Begin
    fIsIconized := False;
    HandleFileMonitorChanges;
End;

Procedure TMainForm.PageControlChanging(Sender: TObject;
    Var AllowChange: Boolean);
Begin
    HideCodeToolTip;
End;

Procedure TMainForm.mnuCVSClick(Sender: TObject);
Begin
    mnuCVSCurrent.Enabled := PageControl.PageCount > 0;
End;


{$IFDEF PLUGIN_BUILD}
// Get the login name to use as a default if the author name is unknown
Function GetLoginName: String;
Var
    buffer: Array[0..255] Of Char;
    size: dword;
Begin
    size := 256;
    If GetUserName(buffer, size) Then
        Result := buffer
    Else
        Result := '';
End;

Function TMainForm.isFunctionAvailable(intClassID: Integer;
    strFunctionName: String): Boolean;
Var
    i: Integer;
    St2: PStatement;
Begin
    Result := False;

    For I := 0 To ClassBrowser1.Parser.Statements.Count - 1 Do // Iterate
    Begin

        St2 := PStatement(ClassBrowser1.Parser.Statements[i]);
        If St2._ParentID <> intClassID Then
            Continue;

        If St2._Kind <> skFunction Then
            Continue;

        If AnsiSameText(strFunctionName, St2._Command) Then
        Begin
            Result := True;
            Break;
        End;
    End; // for

End;

Function TMainForm.GetFunctionsFromSource(classname: String; Var strLstFuncs:
    TStringList): Boolean;
Var
    //Statement: PStatement;
    i, intColon: Integer;
    strParserFunctionName, strParserClassName: String;

    //    _FullText: string;
    //    _Type: string;
    //    _Command: string;
    //    _Args: string;
    //    _MethodArgs: string;
    _ScopelessCmd: String;
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
Begin
    Result := False;
    classname := trim(classname);

    //CppParser1.GetClassesList(TStrings());
    For i := 0 To CppParser1.Statements.Count - 1 Do
    Begin
        If PStatement(CppParser1.Statements[i])._Kind = skFunction Then
        Begin
            strParserClassName :=
                PStatement(CppParser1.Statements[i])._ScopeCmd;
            intColon := Pos('::', strParserClassName);
            If intColon <> 0 Then
            Begin
                strParserClassName :=
                    Copy(strParserClassName, 0, intColon - 1);
            End
            Else
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

            If AnsiSameText(strParserClassName, classname) Then
            Begin
                strLstFuncs.Add(_ScopelessCmd);
            End;
        End;
    End;
    Result := True;
End;
{$ENDIF}

Function TMainForm.isFileOpenedinEditor(strFile: String): Boolean;
Var
    I: Integer;
    e: TEditor;
Begin
    Result := False;

    If Trim(strFile) = '' Then
        Exit;

    For i := 0 To PageControl.PageCount - 1 Do
    Begin
        e := GetEditor(i);
        If Assigned(e) Then
        Begin
            If SameFileName(e.FileName, strFile) Then
            Begin
                Result := True;
                Exit;
            End;
        End;
    End;
End;

// EAB TODO: The following function may need to be revised in order to ensure plugin-neutral behavior 
Procedure TMainForm.GetClassNameLocationsInEditorFiles(
    Var HppStrLst, CppStrLst: TStringList;
    FileName, FromClassName, ToClassName: String);
Var
    St: PStatement;
    i, intColon: Integer;
    strParserClassName: String;
    cppEditor, hppEditor: TEditor;
    cppFName, hppFName: String;
Begin
    HppStrLst.clear;
    CppStrLst.clear;

    cppFName := ChangeFileExt(FileName, CPP_EXT);
    hppFName := ChangeFileExt(FileName, H_EXT);

    OpenFile(cppFName, True);
    OpenFile(hppFName, True);

    cppEditor := GetEditorFromFileName(cppFName);
    hppEditor := GetEditorFromFileName(hppFName);
    If Not (Assigned(cppEditor) And Assigned(hppEditor)) Then
        Exit;

    For I := 0 To ClassBrowser1.Parser.Statements.Count - 1 Do // Iterate
    Begin
        St := PStatement(ClassBrowser1.Parser.Statements[i]);

        If (St._Kind = skConstructor) Or (St._Kind = skDestructor) Then
        Begin
            If AnsiSameText(FromClassName, St._Command) Or
                AnsiSameText('~' + FromClassName, St._Command) Then
            Begin
                If strEqual(St._DeclImplFileName, cppFName) Then
                    CppStrlst.Add(IntToStr(St._DeclImplLine - 1));

                If strEqual(St._DeclImplFileName, hppFName) Then
                    HppStrlst.Add(IntToStr(St._DeclImplLine - 1));

                If strEqual(St._FileName, hppFName) Then
                    HppStrlst.Add(IntToStr(St._Line - 1));

                If strEqual(St._FileName, cppFName) Then
                    cppStrlst.Add(IntToStr(St._Line - 1));
            End;
        End
        Else
        If St._Kind = skClass Then
        Begin
            If AnsiSameText(St._ScopeCmd, FromClassName) Then
            Begin
                If strEqual(St._DeclImplFileName, cppFName) Then
                    CppStrlst.Add(IntToStr(St._DeclImplLine - 1));

                If strEqual(St._DeclImplFileName, hppFName) Then
                    HppStrlst.Add(IntToStr(St._DeclImplLine - 1));

                If strEqual(St._FileName, hppFName) Then
                    HppStrlst.Add(IntToStr(St._Line - 1));

                If strEqual(St._FileName, cppFName) Then
                    cppStrlst.Add(IntToStr(St._Line - 1));
            End;
        End
        Else
        If St._Kind = skFunction Then
        Begin
            strParserClassName := St._ScopeCmd;
            intColon := Pos('::', strParserClassName);
            If intColon <> 0 Then
                strParserClassName := Copy(strParserClassName, 0, intColon - 1)
            Else
                Continue;

            If Not AnsiSameText(strParserClassName, FromClassName) Then
                Continue;

            cppStrlst.Add(IntToStr(St._Line - 1));
            hppStrlst.Add(IntToStr(St._Line - 1));
            cppStrlst.Add(IntToStr(St._DeclImplLine - 1));
            hppStrlst.Add(IntToStr(St._DeclImplLine - 1));
        End;
    End; // for
End;

Procedure TMainForm.ProjectViewKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    If (Key = VK_DELETE) And Assigned(ProjectView.Selected) Then
        RemoveItem(ProjectView.Selected)
    Else
    If Key = VK_ESCAPE Then
    Begin
        If PageControl.Visible And PageControl.Enabled And
            (PageControl.ActivePage <> Nil) Then
            GetEditor(-1).Activate;
    End
    Else
    If (Key = VK_RETURN) And Assigned(ProjectView.Selected) Then
    Begin
        If ProjectView.Selected.Data <> Pointer(-1) Then { if not a directory }
            OpenUnit;
    End;
End;

Function TMainForm.BreakupTodo(Filename: String; sl: TStrings;
    Line: Integer; Token: String; HasUser,
    HasPriority: Boolean): Integer;
Var
    sUser: String;
    iPriority: Integer;
    sDescription: String;
    Indent: Integer;
    S: String;
    X, Y: Integer;
    idx: Integer;
    Done: Boolean;
    MultiLine: Boolean;
    td: PToDoRec;
    OrigLine: Integer;
    TokenIndex: Integer;
Begin
    sUser := '';
    iPriority := 0;
    sDescription := '';

    OrigLine := Line;
    S := sl[Line];

    MultiLine := AnsiPos('//', S) = 0;
    idx := AnsiPos(Token, S);
    TokenIndex := idx;
    Inc(idx, 4); // skip "TODO"

    If HasUser Or HasPriority Then
        Inc(idx, 2); // skip " ("

    Delete(S, 1, idx - 1);
    If HasUser Or HasPriority Then
    Begin
        idx := AnsiPos('#', S);
        sUser := Copy(S, 1, idx - 1); // got user
        iPriority := StrToIntDef(S[idx + 1], 1); // got priority
    End;

    Indent := AnsiPos(':', sl[Line]) + 1;
    idx := AnsiPos(':', S);
    Delete(S, 1, idx + 1);
    Done := False;
    Y := Line;
    While (Y < sl.Count) And Not Done Do
    Begin
        X := Indent;
        While (X <= Length(sl[Y])) And Not Done Do
        Begin
            If (sl[Y][X] = '*') And (X < Length(sl[Y])) And
                (sl[Y][X + 1] = '/') Then
            Begin
                Done := True;
                Break;
            End;
            sDescription := sDescription + sl[Y][X];
            Inc(X);
        End;
        If Not MultiLine Then
            Break;
        If Not Done Then
        Begin
            sDescription := sDescription + #13#10;
            Inc(Line);
        End;
        Inc(Y);
    End;

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
End;

Procedure TMainForm.AddTodoFiles(Current, InProject, NotInProject,
    OpenOnly: Boolean);
    Function MatchesMask(SearchStr, MaskStr: String): Boolean;
    Var
        Matches: Boolean;
        MaskIndex: Integer;
        SearchIndex: Integer;
        NextMatch: Char;
    Begin
        Matches := True;
        MaskIndex := 1;
        SearchIndex := 1;

        If (MaskStr = '') Or (SearchStr = '') Then
            Matches := False;

        If AnsiPos('*?', MaskStr) > 0 Then // illegal
            Matches := False;
        If AnsiPos('**', MaskStr) > 0 Then // illegal
            Matches := False;

        While Matches Do
        Begin
            Case MaskStr[MaskIndex] Of
                '*':
                Begin
                    If MaskIndex < Length(MaskStr) Then
                        NextMatch := MaskStr[MaskIndex + 1]
                    Else
                        NextMatch := #0;
                    While SearchIndex <= Length(SearchStr) Do
                    Begin
                        If SearchStr[SearchIndex] = NextMatch Then
                        Begin
                            Inc(SearchIndex);
                            Inc(MaskIndex, 2);
                            Break;
                        End;
                        Inc(SearchIndex);
                    End;
                    If (SearchIndex = Length(SearchStr)) And
                        (MaskIndex < Length(MaskStr)) Then
                        Matches := False;
                End;
                '?':
                Begin
                    Inc(SearchIndex);
                    Inc(MaskIndex);
                End;
            Else
                If MaskStr[MaskIndex] <> SearchStr[SearchIndex] Then
                    Matches := False
                Else
                Begin
                    Inc(MaskIndex);
                    Inc(SearchIndex);
                End;
            End;

            If MaskIndex > Length(MaskStr) Then
                Break;
            If SearchIndex > Length(SearchStr) Then
                Break;
        End;
        If (MaskIndex = Length(MaskStr)) And (MaskStr[MaskIndex] = '*') Then
            MaskIndex := Length(MaskStr) + 1;

        Result := Matches And (MaskIndex > Length(MaskStr)) And
            (SearchIndex > Length(SearchStr));
    End;

    Procedure AddToDo(Filename: String);
    Var
        sl: TStrings;
        I: Integer;
    Begin
        sl := TStringList.Create;
        Try
            For I := 0 To PageControl.PageCount - 1 Do
                If TEditor(PageControl.Pages[I].Tag).FileName = Filename Then
                    sl.Assign(TEditor(PageControl.Pages[I].Tag).Text.Lines)
                Else
                If FileExists(Filename) Then
                    sl.LoadFromFile(Filename);

            If sl.Count = 0 Then
                If FileExists(Filename) Then
                    sl.LoadFromFile(Filename);

            I := 0;
            While I < sl.Count Do
            Begin
                If MatchesMask(sl[I], '*/? TODO (?*#?#)*:*') Then
                    BreakupToDo(Filename, sl, I, 'TODO', True, True)
                // full info TODO
                Else
                If MatchesMask(sl[I], '*/? DONE (?*#?#)*:*') Then
                    BreakupToDo(Filename, sl, I, 'DONE', True, True)
                // full info DONE
                Else
                If MatchesMask(sl[I], '*/? TODO (#?#)*:*') Then
                    BreakupToDo(Filename, sl, I, 'TODO', False, True)
                // only priority info TODO
                Else
                If MatchesMask(sl[I], '*/? DONE (#?#)*:*') Then
                    BreakupToDo(Filename, sl, I, 'DONE', False, True)
                // only priority info DONE
                Else
                If MatchesMask(sl[I], '*/?*TODO*:*') Then
                    BreakupToDo(Filename, sl, I, 'TODO', False, False)
                // custom TODO
                Else
                If MatchesMask(sl[I], '*/?*DONE*:*') Then
                    BreakupToDo(Filename, sl, I, 'DONE', False, False);
                // custom DONE
                Inc(I);
            End;
        Finally
            sl.Free;
        End;
    End;
Var
    e: TEditor;
    idx: Integer;
Begin
    If Current Then
    Begin
        e := GetEditor;
        If Assigned(e) Then
            AddToDo(e.FileName);
        Exit;
    End;

    If InProject And Not OpenOnly Then
    Begin
        If Assigned(fProject) Then
            For idx := 0 To pred(fProject.Units.Count) Do
                AddToDo(fProject.Units[idx].filename);
    End;

    If OpenOnly Then
    Begin
        For idx := 0 To pred(PageControl.PageCount) Do
        Begin
            e := GetEditor(idx);
            If Assigned(e) Then
                If InProject And e.InProject Then
                    AddToDo(e.FileName);
        End;
    End;

    If NotInProject Then
    Begin
        For idx := 0 To pred(PageControl.PageCount) Do
        Begin
            e := GetEditor(idx);
            If Assigned(e) Then
                If Not e.InProject Then
                    AddToDo(e.FileName);
        End;
    End;
End;

Procedure TMainForm.lvTodoCustomDrawItem(Sender: TCustomListView;
    Item: TListItem; State: TCustomDrawState; Var DefaultDraw: Boolean);
Begin
    If Assigned(Item.Data) Then
    Begin
        Item.Checked := PToDoRec(Item.Data)^.IsDone;
        If Item.Checked Then
        Begin
            Sender.Canvas.Font.Color := clGrayText;
            Sender.Canvas.Font.Style :=
                Sender.Canvas.Font.Style + [fsStrikeOut];
        End
        Else
        Begin
            Sender.Canvas.Font.Color := clWindowText;
            Sender.Canvas.Font.Style :=
                Sender.Canvas.Font.Style - [fsStrikeOut];
        End;
    End;
    DefaultDraw := True;
End;

Procedure TMainForm.lvTodoMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
Var
    e: TEditor;
    Item: TListItem;
Begin
    If Not (htOnStateIcon In lvTodo.GetHitTestInfoAt(X, Y)) Then
        Exit;

    Item := lvTodo.GetItemAt(X, Y);
    If Not Assigned(Item) Then
        Exit;
    If Not Assigned(Item.Data) Then
        Exit;

    e := GetEditorFromFileName(PToDoRec(Item.Data)^.Filename);
    If Assigned(e) Then
    Begin
        PToDoRec(Item.Data)^.IsDone := Item.Checked;
        If Item.Checked Then
        Begin
            e.Text.Lines[PToDoRec(Item.Data)^.Line] :=
                StringReplace(e.Text.Lines[PToDoRec(Item.Data)^.Line],
                'TODO', 'DONE', []);
            If chkTodoIncomplete.Checked Then
                BuildTodoList;
        End
        Else
            e.Text.Lines[PToDoRec(Item.Data)^.Line] :=
                StringReplace(e.Text.Lines[PToDoRec(Item.Data)^.Line],
                'DONE', 'TODO', []);
        e.Modified := True;
        lvTodo.Refresh;
    End;
End;

Procedure TMainForm.lvTodoColumnClick(Sender: TObject;
    Column: TListColumn);
Begin
    fTodoSortColumn := Column.Index;
    TCustomListView(Sender).CustomSort(Nil, 0);
End;

Procedure TMainForm.lvTodoCompare(Sender: TObject; Item1, Item2: TListItem;
    Data: Integer; Var Compare: Integer);
Var
    idx: Integer;
Begin
    If fTodoSortColumn = 0 Then
    Begin
        If PToDoRec(Item1.Data)^.IsDone And Not
            PToDoRec(Item2.Data)^.IsDone Then
            Compare := 1
        Else
        If Not PToDoRec(Item1.Data)^.IsDone And
            PToDoRec(Item2.Data)^.IsDone Then
            Compare := -1
        Else
            Compare := 0;
    End
    Else
    Begin
        idx := fTodoSortColumn - 1;
        Compare := AnsiCompareText(Item1.SubItems[idx], Item2.SubItems[idx]);
    End;
End;

Procedure TMainForm.lvTodoDblClick(Sender: TObject);
Var
    e: TEditor;
Begin
    If Not Assigned(lvTodo.Selected) Then
        Exit;
    If Not Assigned(lvTodo.Selected.Data) Then
        Exit;

    e := GetEditorFromFilename(PToDoRec(lvTodo.Selected.Data)^.Filename);
    If Assigned(e) Then
        e.GotoLineNr(PToDoRec(lvTodo.Selected.Data)^.Line + 1);
End;

Procedure TMainForm.chkTodoIncompleteClick(Sender: TObject);
Begin
    BuildTodoList;
End;

Procedure TMainForm.BuildTodoList;
Var
    I: Integer;
    td: PToDoRec;
    S: String;
Begin
    lvTodo.Items.BeginUpdate;
    lvTodo.Items.Clear;
    For I := 0 To fToDoList.Count - 1 Do
    Begin
        td := PToDoRec(fToDoList[I]);
        If (chkTodoIncomplete.Checked And Not td^.IsDone) Or Not
            chkTodoIncomplete.Checked Then
            With lvTodo.Items.Add Do
            Begin
                Caption := '';
                SubItems.Add(IntToStr(td^.Priority));
                S := StringReplace(td^.Description, #13#10,
                    ' ', [rfReplaceAll]);
                S := StringReplace(S, #9, ' ', [rfReplaceAll]);
                SubItems.Add(S);
                SubItems.Add(td^.Filename);
                SubItems.Add(td^.User);
                Data := td;
            End;
    End;
    lvTodo.CustomSort(Nil, 0);
    lvTodo.Items.EndUpdate;
End;

Procedure TMainForm.cmbTodoFilterChange(Sender: TObject);
Begin
{
    0 = All files (in project and not)
    1 = Open files only (in project and not)
    2 = All project files
    3 = Open project files only
    4 = Non-project open files
    5 = Current file only
}
    While fToDoList.Count > 0 Do
        If Assigned(fToDoList[0]) Then
        Begin
            Dispose(PToDoRec(fToDoList[0]));
            fToDoList.Delete(0);
        End;
    Case cmbTodoFilter.ItemIndex Of
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
    Else
        AddTodoFiles(True, False, True, True);
        //The default would be for current files only.
    End;
    BuildTodoList;
End;

Procedure TMainForm.RefreshTodoList;
Begin
    cmbTodoFilterChange(cmbTodoFilter);
End;

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
Procedure TMainForm.UpdateEditor(filename: String; messageToDysplay: String);
Var
    e: TEditor;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
{$ENDIF}
Begin
    If FileExists(filename) Then
    Begin
        MainForm.OpenFile(filename, True);
        e := MainForm.GetEditorFromFileName(filename);
        If Assigned(e) Then
        Begin
       // if (e.Text.CodeFolding.Enabled) then
        //   e.Text.UncollapseAll;

            e.Text.BeginUpdate;

            Try
            {$IFDEF PLUGIN_BUILD}

                For i := 0 To packagesCount - 1 Do
                    (plugins[delphi_plugins[i]] As
                        IPlug_In_BPL).GenerateSource(
                        filename, e.Text);

            {$ENDIF}
            Except
            End;

            e.Text.EndUpdate;

         //     if (e.Text.CodeFolding.Enabled) then
         //  e.Text.ReScanForFoldRanges;


            e.Modified := True;
            e.InsertString('', False);
            MainForm.StatusBar.Panels[3].Text := messageToDysplay;
        End;
    End;
End;

{$IFDEF PLUGIN_BUILD}
Function TMainForm.GetEditorTabSheet(FileName: String): TTabSheet;
Var
    e: TEditor;
Begin
    Result := Nil;
    If FileExists(FileName) Then
    Begin
        e := GetEditorFromFileName(FileName);

        If Not Assigned(e) Then
        Begin
            OpenFile(FileName, True);
            e := GetEditorFromFileName(FileName);
        End;

        If Assigned(e) Then
        Begin
            Result := e.TabSheet;
        End;
    End;
End;

Function TMainForm.GetEditorText(FileName: String): TSynEdit;
Var
    e: TEditor;
Begin
    Result := Nil;
    If FileExists(FileName) Then
    Begin
        e := GetEditorFromFileName(FileName);

        If Not Assigned(e) Then
        Begin
            OpenFile(FileName, True);
            e := GetEditorFromFileName(FileName);
        End;

        If Assigned(e) Then
        Begin
            Result := e.Text;
        End;
    End;
End;

Function TMainForm.IsEditorModified(FileName: String): Boolean;
Var
    e: TEditor;
Begin
    Result := False;
    If FileExists(FileName) Then
    Begin
        e := GetEditorFromFileName(FileName);

        If Not Assigned(e) Then
        Begin
            OpenFile(FileName, True);
            e := GetEditorFromFileName(FileName);
        End;

        If Assigned(e) Then
            Result := e.Modified;
    End;
End;

Function TMainForm.isFunctionAvailableInEditor(intClassID: Integer;
    strFunctionName: String;
    Var intLineNum: Integer; Var strFname: String): Boolean;
Var
    i: Integer;
    St2: PStatement;
Begin
    Result := False;
    For I := 0 To ClassBrowser1.Parser.Statements.Count - 1 Do // Iterate
    Begin
        St2 := PStatement(ClassBrowser1.Parser.Statements[i]);
        If St2._ParentID <> intClassID Then
            Continue;

        If St2._Kind <> skFunction Then
            Continue;

        If AnsiSameText(strFunctionName, St2._Command) Then
        Begin
            strFname := St2._DeclImplFileName;
            intLineNum := St2._DeclImplLine;
            Result := True;
            Break;
        End;
    End; // for
End;

Function TMainForm.FindStatementID(strClassName: String;
    Var boolFound: Boolean): Integer;
Var
    St: PStatement;
    I: Integer;
Begin
    St := Nil;
    For I := 0 To ClassBrowser1.Parser.Statements.Count - 1 Do // Iterate
    Begin
        If PStatement(ClassBrowser1.Parser.Statements[i])._Kind = skClass Then
        Begin
            St := PStatement(ClassBrowser1.Parser.Statements[i]);
            If AnsiSameText(St._Command, strClassName) Then
            Begin
                boolFound := True;
                Break;
            End;
        End;
    End; // for
    Result := St._ID;
End;

Procedure TMainForm.TouchEditor(editorName: String);
Var
    e: TEditor;
Begin
    e := GetEditorFromFileName(editorName);
    e.InsertString('', True);
End;

Procedure TMainForm.EditorInsertDefaultText(editorName: String);
Var
    e: TEditor;
Begin
    e := GetEditorFromFileName(editorName);
    e.InsertDefaultText;
    e.Modified := True;
End;

Function TMainForm.GetPageControlActivePageIndex: Integer;
Begin
    Result := PageControl.ActivePageIndex;
End;

Procedure TMainForm.SetPageControlActivePageEditor(editorName: String);
Var
    e: TEditor;
Begin
    e := GetEditorFromFileName(editorName);
    PageControl.ActivePageIndex := e.TabSheet.TabIndex;
    UpdateAppTitle;
End;

Procedure TMainForm.SetEditorModified(editorName: String; modified: Boolean);
Var
    e: TEditor;
Begin
    e := GetEditorFromFileName(editorName);
    e.Modified := modified;
End;

Function TMainForm.GetSuggestedInsertionLine(StID: Integer;
    AddScopeStr: Boolean): Integer;
Begin
    Result := ClassBrowser1.Parser.SuggestMemberInsertionLine(StID,
        scsPublic, AddScopeStr);
End;

Function TMainForm.DoesFileAlreadyExists(FileName: String): Boolean;
Begin
    Result := fProject.FileAlreadyExists(FileName);
End;

Procedure TMainForm.AddProjectUnit(FileName: String; b: Boolean);
Var
    node: TTreeNode;
Begin
    node := fProject.Node;
    fProject.AddUnit(FileName, node, b);
End;

Procedure TMainForm.CloseUnit(FileName: String);
Begin
    fProject.CloseUnit(fProject.GetUnitFromString(ExtractFileName(FileName)));
End;

Function TMainForm.GetActiveTabSheet: TTabSheet;
Var
    e: TEditor;
Begin
    e := GetEditor;
    Result := e.TabSheet;
End;

Function TMainForm.GetLangString(index: Integer): String;
Begin
    Result := Lang.Strings[index];
End;

Function TMainForm.IsUsingXPTheme: Boolean;
Begin
    Result := devData.XPTheme;
End;

Function TMainForm.GetConfig: String;
Begin
    Result := devDirs.Config;
End;

Function TMainForm.GetExec: String;
Begin
    Result := devDirs.Exec;
End;

Function TMainForm.ListDirectory(Const Path: String;
    Attr: Integer): TStringList;
Var
    Res: TSearchRec;
    EOFound: Boolean;
    entries: TStringList;
Begin
    entries := TStringList.Create;
    EOFound := False;
    Result := Nil;
    If FindFirst(Path, Attr, Res) < 0 Then
        exit
    Else
        While Not EOFound Do
        Begin
            If ((CompareStr(Res.Name, '.') <> 0) And
                (CompareStr(Res.Name, '..') <> 0)) Then
                entries.Add(Res.Name);
            EOFound := FindNext(Res) <> 0;
        End;
    FindClose(Res);
    Result := entries;
End;

Procedure TMainForm.InitPlugins;
Var
    items: TList;
    menuItem: TMenuItem;
    toolbar: TToolBar;
    tabs: TTabSheet;
    i, j, idx, temp_left, temp_top, setIndex: Integer;
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
Begin
    unit_plugins := TIntegerHash.Create;
    packagesCount := 0;
    librariesCount := 0;
    pluginsCount := 0;
    ToolsMenuOffset := 0;
    loadablePlugins := ListDirectory(devDirs.Exec + '\plugins\*.*',
        faDirectory);
  {$IFNDEF PLUGIN_TESTING}
    For i := 0 To loadablePlugins.Count - 1 Do
    Begin
        pluginName := loadablePlugins[i];
        SetSplashStatus('Loading plugin "' + pluginName + '"');
        pluginModule := 0;
        If FileExists(devDirs.Exec + '\plugins\' + pluginName +
            '\' + pluginName + '.bpl') Then
        Begin
            pluginModule := LoadPackage(devDirs.Exec + '\plugins\' +
                pluginName + '\' + pluginName + '.bpl');
            If pluginModule <> 0 Then
            Begin
                SetLength(delphi_plugins, packagesCount + 1);
                delphi_plugins[packagesCount] := pluginsCount;
                SetLength(plugin_modules, pluginsCount + 1);
                plugin_modules[pluginsCount] := pluginModule;
                AClass := GetClass('T' + pluginName);
                If AClass <> Nil Then
                Begin
                    plugin := TComponentClass(AClass).Create(Application) As
                        IPlug_In_BPL;
                {$ENDIF}
                {$IFDEF PLUGIN_TESTING}
                    If loadablePlugins.Count = 0 Then
                        Exit;
                    pluginName := loadablePlugins[0];
                    If pluginName = '' Then
                        Exit;
                    SetSplashStatus('Loading static plugin "' + pluginName + '"');
                    AClass := GetClass('T' + pluginName);
                    plugin := TComponentClass(AClass).Create(Application) As IPlug_In_BPL;   // Used for static plugin linkage for easier debugging
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
                    If idx <> -1 Then
                    Begin
                        temp_left :=
                            StrToIntDef(devPluginToolbarsX.ToolbarsXName[idx], 0);
                        temp_top :=
                            StrToIntDef(devPluginToolbarsY.ToolbarsYName[idx], 0);

                        If temp_left > current_max_toolbar_left Then
                            current_max_toolbar_left := temp_left;
                        If temp_top > current_max_toolbar_top Then
                            current_max_toolbar_top := temp_top;
                    End
                    Else
                    Begin
                        temp_left := current_max_toolbar_left;
                        temp_top := current_max_toolbar_top;
                    End;

                    plugin.Initialize(pluginName, pluginModule,
                        Self.Handle, ControlBar1, Self,
                        devDirs.Config, temp_left, temp_top);
                    If (plugin.ManagesUnit) Then
                        unit_plugins[pluginName] := pluginsCount - 1;
                {$IFNDEF PLUGIN_TESTING}
                End;
            End;
        End
        Else
        Begin
            If FileExists(devDirs.Exec + '\plugins\' + pluginName +
                '\' + pluginName + '.dll') Then
            Begin
                tempName :=
                    devDirs.Exec + '\plugins\' + pluginName +
                    '\' + pluginName + '.dll';
                pluginModule := LoadLibrary(Pchar(tempName));
            End
            Else
            If FileExists(devDirs.Exec + '\plugins\' + pluginName + '\' +
                pluginName + '.ocx') Then
            Begin
                tempName :=
                    devDirs.Exec + '\plugins\' + pluginName +
                    '\' + pluginName + '.ocx';
                pluginModule := LoadLibrary(Pchar(tempName));
            End;

            If pluginModule <> 0 Then
            Begin
                SetLength(c_plugins, librariesCount + 1);
                c_plugins[librariesCount] := pluginsCount;
                SetLength(plugin_modules, pluginsCount + 1);
                plugin_modules[pluginsCount] := pluginModule;

                c_interface := TPlug_In_DLL.Create(Self) As IPlug_In_DLL;
                SetLength(plugins, pluginsCount + 1);
                plugins[pluginsCount] := c_interface;
                Inc(pluginsCount);
                Inc(librariesCount);

                // Check for saved toolbar coordinates:
                idx := devPluginToolbarsX.AssignedToolbarsX(pluginName);
                If idx <> -1 Then
                Begin
                    temp_left :=
                        StrToIntDef(devPluginToolbarsX.ToolbarsXName[idx], 0);
                    temp_top :=
                        StrToIntDef(devPluginToolbarsY.ToolbarsYName[idx], 0);

                    If temp_left > current_max_toolbar_left Then
                        current_max_toolbar_left := temp_left;
                    If temp_top > current_max_toolbar_top Then
                        current_max_toolbar_top := temp_top;
                End
                Else
                Begin
                    temp_left := current_max_toolbar_left;
                    temp_top := current_max_toolbar_top;
                End;

                c_interface.Initialize(pluginName, pluginModule,
                    Self.Handle, ControlBar1, Self, devDirs.Config,
                    temp_left, temp_top);
                If (c_interface.ManagesUnit) Then
                    unit_plugins[pluginName] := pluginsCount - 1;
                //c_interface.TestReport;      // Temporal testing line;  should be removed, or moved to some options dialog for testing plugins.
            End;
        End;
    End;
  {$ENDIF}


  // Plugin-specific options
    For i := 0 To pluginsCount - 1 Do
        plugins[i].SetCompilerOptionstoDefaults;


    For setIndex := 0 To devCompilerSet.Sets.Count - 1 Do
    Begin


        devCompilerSet.LoadSet(setIndex);

    // Get plugin-specific compiler options
        For i := 0 To pluginsCount - 1 Do
        Begin
            pluginSettings := plugins[i].GetCompilerOptions;
            For j := 0 To Length(pluginSettings) - 1 Do
            Begin
            // This line loads it from the .ini file.
                tempName := devData.LoadSetting(devCompilerSet.optComKey,
                    pluginSettings[j].name);

            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
                If tempName <> '' Then
                    plugins[i].LoadCompilerSettings(
                        pluginSettings[j].name, tempName);
            End;
        End;

    End;


    // Inserting plugin controls to the IDE
    For i := 0 To pluginsCount - 1 Do
    Begin

        items := plugins[i].Retrieve_LeftDock_Panels;
        If items <> Nil Then
        Begin
            If items.Count > 1 Then
            Begin
                panel1 := items[0];
                panel2 := items[1];

                lbDockClient2 := TJvDockClient.Create(panel1);
                With lbDockClient2 Do
                Begin
                    Name := 'lbLeftDockClient_' + IntToStr(i) + '_0';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                End;
                lbDockClient3 := TJvDockClient.Create(panel2);
                With lbDockClient3 Do
                Begin
                    Name := 'lbLeftDockClient_' + IntToStr(i) + '_1';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                End;
                LeftDockTabs :=
                    ManualTabDock(DockServer.LeftDockPanel, panel1, panel2);
            End
            Else
            Begin
                panel1 := items[0];
                lbDockClient2 := TJvDockClient.Create(panel1);
                With lbDockClient2 Do
                Begin
                    Name := 'lbLeftDockClient_' + IntToStr(i) + '_0';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                End;
                panel1.ManualDock(DockServer.LeftDockPanel, Nil, alTop);
            End;
            For j := 2 To items.Count - 1 Do
            Begin
                panel1 := items[j];
                ManualTabDockAddPage(LeftDockTabs, panel1);
                ShowDockForm(panel1);
            End;

        End;

        items := plugins[i].Retrieve_RightDock_Panels;
        If items <> Nil Then
        Begin
            If items.Count > 1 Then
            Begin
                panel1 := items[0];
                panel2 := items[1];

                lbDockClient2 := TJvDockClient.Create(panel1);
                With lbDockClient2 Do
                Begin
                    Name := 'lbRightDockClient_' + IntToStr(i) + '_0';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                End;
                lbDockClient3 := TJvDockClient.Create(panel2);
                With lbDockClient3 Do
                Begin
                    Name := 'lbRightDockClient_' + IntToStr(i) + '_1';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                End;
                RightDockTabs :=
                    ManualTabDock(DockServer.RightDockPanel, panel1, panel2);
            End
            Else
            Begin
                panel1 := items[0];
                lbDockClient2 := TJvDockClient.Create(panel1);
                With lbDockClient2 Do
                Begin
                    Name := 'lbRightDockClient_' + IntToStr(i) + '_0';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                End;
                panel1.ManualDock(DockServer.RightDockPanel, Nil, alTop);
            End;
            For j := 2 To items.Count - 1 Do
            Begin
                panel1 := items[j];
                ManualTabDockAddPage(RightDockTabs, panel1);
                ShowDockForm(panel1);
            End;

        End;

        items := plugins[i].Retrieve_BottomDock_Panels;
        If items <> Nil Then
        Begin
            If items.Count > 1 Then
            Begin
                panel1 := items[0];
                panel2 := items[1];

                lbDockClient2 := TJvDockClient.Create(panel1);
                With lbDockClient2 Do
                Begin
                    Name := 'lbBottomDockClient_' + IntToStr(i) + '_0';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                End;
                lbDockClient3 := TJvDockClient.Create(panel2);
                With lbDockClient3 Do
                Begin
                    Name := 'lbBottomDockClient_' + IntToStr(i) + '_1';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                End;
                BottomDockTabs :=
                    ManualTabDock(DockServer.BottomDockPanel, panel1, panel2);
            End
            Else
            Begin
                panel1 := items[0];
                lbDockClient2 := TJvDockClient.Create(panel1);
                With lbDockClient2 Do
                Begin
                    Name := 'lbBottomDockClient_' + IntToStr(i) + '_0';
                    DirectDrag := True;
                    DockStyle := DockServer.DockStyle;
                End;
                panel1.ManualDock(DockServer.BottomDockPanel, Nil, alTop);
            End;
            For j := 2 To items.Count - 1 Do
            Begin
                panel1 := items[j];
                ManualTabDockAddPage(BottomDockTabs, panel1);
                ShowDockForm(panel1);
            End;

        End;

        toolbar := plugins[i].Retrieve_Toolbars;
        If plugins[i].IsDelphiPlugin Then
        Begin
            If toolbar <> Nil Then
                Self.ControlBar1.InsertControl(toolbar);
        End
        Else
            toolbar.Visible := True;
    End;

    For i := 0 To packagesCount - 1 Do
    Begin
        items := (plugins[delphi_plugins[i]] As
            IPlug_In_BPL).Retrieve_File_New_Menus;
        If items <> Nil Then
        Begin
            If items.Count > 0 Then
            Begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.mnuNew.Add(menuItem);
            End;
            For j := 0 To items.Count - 1 Do
            Begin
                menuItem := items[j];
                Self.mnuNew.Add(menuItem);
            End;
        End;

        items := (plugins[delphi_plugins[i]] As
            IPlug_In_BPL).Retrieve_File_Import_Menus;
        If items <> Nil Then
        Begin
            If items.Count > 0 Then
            Begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.ImportItem.Add(menuItem);
            End;
            For j := 0 To items.Count - 1 Do
            Begin
                menuItem := items[j];
                Self.ImportItem.Add(menuItem);
            End;
        End;

        items := (plugins[delphi_plugins[i]] As
            IPlug_In_BPL).Retrieve_File_Export_Menus;
        If items <> Nil Then
        Begin
            If items.Count > 0 Then
            Begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.ExportItem.Add(menuItem);
            End;
            For j := 0 To items.Count - 1 Do
            Begin
                menuItem := items[j];
                Self.ExportItem.Add(menuItem);
            End;
        End;

        items := (plugins[delphi_plugins[i]] As
            IPlug_In_BPL).Retrieve_Edit_Menus;
        If items <> Nil Then
        Begin
            If items.Count > 0 Then
            Begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.EditMenu.Add(menuItem);
            End;
            For j := 0 To items.Count - 1 Do
            Begin
                menuItem := items[j];
                Self.EditMenu.Add(menuItem);
            End;
        End;

        items := (plugins[delphi_plugins[i]] As
            IPlug_In_BPL).Retrieve_Search_Menus;
        If items <> Nil Then
        Begin
            If items.Count > 0 Then
            Begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.SearchMenu.Add(menuItem);
            End;
            For j := 0 To items.Count - 1 Do
            Begin
                menuItem := items[j];
                Self.SearchMenu.Add(menuItem);
            End;
        End;

        items := (plugins[delphi_plugins[i]] As
            IPlug_In_BPL).Retrieve_View_Menus;
        If items <> Nil Then
        Begin
            If (items.Count > 0) And (Self.ShowPluginPanelsItem.Count > 0) Then
            Begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.ViewMenu.Add(menuItem);
            End;
            For j := 0 To items.Count - 1 Do
            Begin
                menuItem := items[j];
                Self.ShowPluginPanelsItem.Add(menuItem);
            End;
        End;

        items := (plugins[delphi_plugins[i]] As
            IPlug_In_BPL).Retrieve_View_Toolbars_Menus;
        If items <> Nil Then
        Begin
            If items.Count > 0 Then
            Begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.ToolbarsItem.Add(menuItem);
            End;
            For j := 0 To items.Count - 1 Do
            Begin
                menuItem := items[j];
                Self.ToolbarsItem.Add(menuItem);
            End;
        End;

        items := (plugins[delphi_plugins[i]] As
            IPlug_In_BPL).Retrieve_Project_Menus;
        If items <> Nil Then
        Begin
            If items.Count > 0 Then
            Begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.ProjectMenu.Add(menuItem);
            End;
            For j := 0 To items.Count - 1 Do
            Begin
                menuItem := items[j];
                Self.ProjectMenu.Add(menuItem);
            End;
        End;

        items := (plugins[delphi_plugins[i]] As
            IPlug_In_BPL).Retrieve_Execute_Menus;
        If items <> Nil Then
        Begin
            If items.Count > 0 Then
            Begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.ExecuteMenu.Add(menuItem);
            End;
            For j := 0 To items.Count - 1 Do
            Begin
                menuItem := items[j];
                Self.ExecuteMenu.Add(menuItem);
            End;
        End;

        items := (plugins[delphi_plugins[i]] As
            IPlug_In_BPL).Retrieve_Debug_Menus;
        If items <> Nil Then
        Begin
            If items.Count > 0 Then
            Begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.DebugMenu.Add(menuItem);
            End;
            For j := 0 To items.Count - 1 Do
            Begin
                menuItem := items[j];
                Self.DebugMenu.Add(menuItem);
            End;
        End;

        items := (plugins[delphi_plugins[i]] As
            IPlug_In_BPL).Retrieve_Tools_Menus;
        If items <> Nil Then
        Begin
            If items.Count > 0 Then
            Begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.ToolsMenu.Add(menuItem);
                Inc(ToolsMenuOffset);
            End;
            For j := 0 To items.Count - 1 Do
            Begin
                menuItem := items[j];
                Self.ToolsMenu.Add(menuItem);
                Inc(ToolsMenuOffset);
            End;
        End;

        items := (plugins[delphi_plugins[i]] As
            IPlug_In_BPL).Retrieve_Help_Menus;
        If items <> Nil Then
        Begin
            If items.Count > 0 Then
            Begin
                menuItem := TMenuItem.Create(Self);
                menuItem.Caption := '-';
                Self.HelpMenu.Add(menuItem);
            End;
            For j := 0 To items.Count - 1 Do
            Begin
                menuItem := items[j];
                Self.HelpMenu.Add(menuItem);
            End;
        End;

    End;

End;


Procedure TMainForm.ControlBar1WM_COMMAND(Sender: TObject;
    Var TheMessage: TWMCommand);
Var
    i: Integer;
Begin
    For i := 0 To librariesCount - 1 Do
    Begin
        If ((plugins[c_plugins[i]] As IPlug_In).GetChild = TheMessage.Ctl) Then
            (plugins[c_plugins[i]] As IPlug_In_DLL).OnToolbarEvent(
                TheMessage.ItemID);
    End;
End;

Procedure TMainForm.ReParseFile(FileName: String);
Begin
    If ClassBrowser1.Enabled Then
        CppParser1.ReParseFile(FileName, True);
End;

Function TMainForm.SaveFileFromPlugin(FileName: String;
    forcing: Boolean = False): Boolean;
Var
    e: TEditor;
Begin
    Result := False;
    If FileExists(FileName) Then
    Begin
        e := GetEditorFromFileName(FileName);

        If Not Assigned(e) And forcing = True Then
        Begin
            OpenFile(FileName, True);
            e := GetEditorFromFileName(FileName);
        End;

        If Assigned(e) Then
            Result := SaveFileInternal(e, False);
    End;
End;

Procedure TMainForm.CloseEditorFromPlugin(FileName: String);
Var
    tempEditor: TEditor;
Begin
    tempEditor := GetEditorFromFileName(FileName, True);
    If assigned(tempEditor) Then
        CloseEditorInternal(tempEditor);
End;

Function TMainForm.OpenUnitInProject(s: String): Boolean;
Begin
    Result := False;
    If fProject.Units.Indexof(s) <> -1 Then
    Begin;
        fProject.OpenUnit(fProject.Units.Indexof(s));
        Result := True;
    End;
End;

Procedure TMainForm.ActivateEditor(EditorFilename: String);
Begin
    GetEditorFromFileName(EditorFilename).Activate;
End;

Procedure TMainForm.PrepareFileForEditor(currFile: String;
    insertProj: Integer; creatingProject: Boolean; assertMessage: Boolean;
    alsoReasignEditor: Boolean; assocPlugin: String);
Var
    editor: TEditor;
Begin
    If (creatingProject = True) Or (insertProj = 1) Then
    Begin
        If assertMessage Then
            assert(assigned(fProject), 'Global project should be defined!');
        fProject.AddUnit(currFile, fProject.Node, False); // add under folder
        If ClassBrowser1.Enabled Then
        Begin
            CppParser1.AddFileToScan(currFile, True);
            CppParser1.ReParseFile(currFile, True, True);
            // EAB: Check this out ***
        End;
        If alsoReasignEditor Then
        Begin
            editor := fProject.OpenUnit(fProject.Units.Indexof(currFile));
            editor.Activate;
        End
        Else
            fProject.OpenUnit(fProject.Units.Indexof(currFile));
    End
    Else
    If Not creatingProject Then
    Begin
        OpenFile(currFile);
    End;
    editor := GetEditorFromFileName(currFile);
    If (editor <> Nil) Then
        editor.AssignedPlugin := assocPlugin;
End;

Procedure TMainForm.ChangeProjectProfile(Index: Integer);
Begin
    fProject.CurrentProfileIndex := Index;
    fProject.DefaultProfileIndex := Index;
End;

Function TMainForm.GetActiveEditorName: String;
Var
    e: TEditor;
Begin
    e := GetEditor(Self.PageControl.ActivePageIndex);;
    If e <> Nil Then
        Result := e.FileName
    Else
        Result := '';
End;

Function TMainForm.IsEditorAssigned(editorName: String): Boolean;
Var
    e: TEditor;
Begin
    If (editorName = '') Then
        e := GetEditor
    Else
        e := GetEditorFromFileName(editorName);

    If assigned(e) Then
        Result := True
    Else
        Result := False;
End;

Function TMainForm.IsProjectAssigned: Boolean;
Begin
    Result := Assigned(fProject);
End;

Function TMainForm.GetDMNum: Integer;
Begin
    Result := dmMain.GetNum;
End;

Function TMainForm.IsClassBrowserEnabled: Boolean;
Begin
    Result := ClassBrowser1.Enabled;
End;

Function TMainForm.GetProjectFileName: String;
Begin
    Result := fProject.FileName;
End;

Function TMainForm.RetrieveUserName(Var buffer: Array Of Char;
    size: dword): Boolean;
Begin
    Result := GetUserName(buffer, size);
End;

Procedure TMainForm.CreateEditor(strFileN: String; extension: String;
    InProject: Boolean);
Var
    NewDesigner: TEditor;
    NewUnit: TProjUnit;
    FolderNode: TTreeNode;
    strFileName, strShortFileName: String;
Begin
    strFileName := ChangeFileExt(strFileN, extension);
    strShortFileName := ExtractFileName(strFileName);
    NewDesigner := TEditor.Create;

    If Assigned(fProject) And (InProject = True) Then
    Begin
        FolderNode := fProject.Node;
        NewUnit := fProject.AddUnit(strFileName, FolderNode, False);
        // add under folder
        NewUnit.Editor := NewDesigner;
    End;

    NewDesigner.Init(InProject, strShortFileName, strFileName, True);

    If Not ClassBrowser1.Enabled Then
    Begin
        MessageDlg('Class Browser is not enabled.' + #13 + #10 + '' + #13 +
            #10 + 'Adding Event handlers and Other features of the Form Designer '
            +
            #13 + #10 + 'wont work properly.' + #13 + #10 + '' + #13 + #10 +
            'Please enable the Class Browser.', mtWarning, [mbOK], 0);
    End;

    NewDesigner.Activate;
End;

Procedure TMainForm.UnSetActiveControl;
Begin
    ActiveControl := Nil;
End;

Function TMainForm.GetUntitledFileName: String;
Begin
    Result := Lang[ID_UNTITLED] + inttostr(dmMain.GetNum);
End;

Function TMainForm.GetDevDirsConfig: String;
Begin
    Result := devDirs.Config;
End;

Function TMainForm.GetDevDirsDefault: String;
Begin
    Result := devDirs.Default;
End;

Function TMainForm.GetDevDirsTemplates: String;
Begin
    Result := devDirs.Templates;
End;

Function TMainForm.GetDevDirsExec: String;
Begin
    Result := devDirs.Exec;
End;

Function TMainForm.GetCompilerProfileNames(
    Var defaultProfileIndex: Integer): TStrings;
Var
    items: TStrings;
    i: Integer;
Begin
    items := TStringList.Create;
    If (fProject <> Nil) Then
    Begin
        For i := 0 To fProject.Profiles.Count - 1 Do
            items.Add(fProject.Profiles.Items[i].ProfileName);
        defaultProfileIndex := fProject.DefaultProfileIndex;
    End;
    Result := items;
End;

Function TMainForm.GetRealPathFix(BrokenFileName: String;
    Directory: String = ''): String;
Begin
    Result := GetRealPath(BrokenFileName, Directory);
End;

Function TMainForm.FileAlreadyExistsInProject(s: String): Boolean;
Begin
    Result := fProject.FileAlreadyExists(s);
End;

Function TMainForm.IsProjectNotNil: Boolean;
Begin
    If fProject <> Nil Then
        Result := True
    Else
        Result := False;
End;

Function TMainForm.GetDmMainRes: TSynRCSyn;
Begin
    Result := dmMain.Res;
End;

Procedure TMainForm.ToggleDockForm(form: TForm; b: Boolean);
Begin
    If b = True Then
        ShowDockForm(form)
    Else
        HideDockForm(form);
End;

Procedure TMainForm.SendToFront;
Begin
    self.Show;
End;

Procedure TMainForm.forceEditorFocus;
Var
    e: TEditor;
Begin
    e := GetEditor;
    If Assigned(e) Then
    Begin
        // don't know why, but at this point the editor does not show its caret.
        // if we shift the focus to another control and back to the editor,
        // everything is fine. (I smell another SynEdit bug?)
        e.TabSheet.SetFocus;
        e.Activate;
        e.Text.SetFocus;
    End;
End;

{$ENDIF PLUGIN_BUILD}

Procedure TMainForm.PageControlDrawTab(Control: TCustomTabControl;
    TabIndex: Integer; Const Rect: TRect; Active: Boolean);
Var
    s: String;
    r: TRect;
Begin
    s := PageControl.Pages[TabIndex].Caption;
    r := Rect;
    With Control.Canvas Do
    Begin
        If Active Then
        Begin
            Brush.Color := clinfoBK;
            Font.Color := clBlue;
        End;
        Windows.FillRect(Handle, r, Brush.Handle);
        OffsetRect(r, 0, 1);
        DrawText(Handle, Pchar(s), Length(s), r, DT_CENTER Or
            DT_SINGLELINE Or DT_VCENTER);
    End;
End;


Procedure TMainForm.FormCreate(Sender: TObject);
Begin
    ShowWindow(Application.Handle, SW_HIDE);
    SetWindowLong(Application.Handle, GWL_EXSTYLE,
        GetWindowLong(Application.Handle, GWL_EXSTYLE) And Not
        WS_EX_APPWINDOW Or WS_EX_TOOLWINDOW);
    ShowWindow(Application.Handle, SW_SHOW);
    If IsWindowsVista Then
    Begin
        TVistaAltFix.Create(Self);
    End;
    // accepting drag and drop files
    DragAcceptFiles(Handle, True);
    defaultHelpF1 := True;
End;

Procedure TMainForm.WMSyscommand(Var Message: TWmSysCommand);
Begin
    //if IsWindowsVista then
    //begin
    Case (Message.CmdType And $FFF0) Of
        SC_MINIMIZE:
        Begin
            If (HandleAllocated()) Then
            Begin
                ShowWindow(Handle, SW_MINIMIZE);
                Message.Result := 0;
            End;
        End;
        SC_RESTORE:
        Begin
            If (HandleAllocated()) Then
            Begin
                ShowWindow(Handle, SW_RESTORE);
                Message.Result := 0;
            End;
        End;
    Else
        Inherited;
    End;
    //end
    //else inherited;
End;

Procedure TMainForm.WMActivate(Var Msg: TWMActivate);
Begin
    //if IsWindowsVista then
    //begin
    If (Msg.Active = WA_ACTIVE) And Not IsWindowEnabled(Handle) Then
    Begin
        If (HandleAllocated()) Then
        Begin
            SetActiveWindow(Application.Handle);
            Msg.Result := 0;
        End;
    End
    Else
        Inherited;
    //end;
End;

Procedure TMainForm.RemoveAllBreakpoints1Click(Sender: TObject);
Var
    e: TEditor;
    i: Integer;
Begin
    e := GetEditor;
    If Assigned(e) Then
    Begin
        For i := 1 To e.Text.Lines.Count Do
        Begin
            If (e.HasBreakPoint(i) <> -1) Then
                e.ToggleBreakPoint(i);
        End;
    End;
End;


Procedure TMainForm.OnWatches(Locals: PTList);
{
  If Locals is a null pointer, clear the on-screen list,
  otherwise, add Locals to the on-screen display
}
Var
    I: Integer;
    ListItem: TListItem;

    Local: PWatchVar;

Begin

    If (Locals = Nil) Then
    Begin
        Exit;
    End;

End;

End.
