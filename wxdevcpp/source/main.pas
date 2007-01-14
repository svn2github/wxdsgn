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
  CVSFm, ImageTheme

{$IFDEF WX_BUILD}
  , JclStrings, JvExControls, JvComponent, TypInfo, JclRTTI, JvStringHolder,
  ELDsgnr, JvInspector, xprocs, dmCreateNewProp, wxUtils, DbugIntf,
  wxSizerpanel, Designerfrm, ELPropInsp, ComponentPalette,
{$IFNDEF COMPILER_7_UP}
  ThemeMgr,
  ThemeSrv,
{$ENDIF}
{$IFNDEF OLD_MADSHI}
  ExceptionFilterUnit,
{$ENDIF}
  DesignerOptions, JvExStdCtrls, JvEdit, SynEditHighlighter, SynHighlighterMulti,
  JvComponentBase, JvDockControlForm, JvDockTree, JvDockVIDStyle, JvDockVSNetStyle
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
  TMainForm = class(TForm)
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
    ControlBar1: TControlBar;
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
    actNewwxDialog: TAction;
    NewWxDialogItem: TMenuItem;
    actDesignerCopy: TAction;
    actDesignerCut: TAction;
    actDesignerPaste: TAction;
    actDesignerDelete: TAction;
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
    N71: TMenuItem;
    N72: TMenuItem;
    N70: TMenuItem;
    NewWxFrameItem: TMenuItem;
    N73: TMenuItem;
    actNewWxFrame: TAction;
    DebugStopBtn: TToolButton;
    actWxPropertyInspectorCut: TAction;
    actWxPropertyInspectorCopy: TAction;
    actWxPropertyInspectorPaste: TAction;
    DockServer: TJvDockServer;
    LeftPageControl: TPageControl;
    ProjectSheet: TTabSheet;
    ProjectView: TTreeView;
    ClassSheet: TTabSheet;
    ClassBrowser1: TClassBrowser;
    tabWatches: TTabSheet;
    DebugTree: TTreeView;
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
    prgFormProgress: TProgressBar;
    PageControl: TPageControl;
    TodoSheet: TTabSheet;
    lvTodo: TListView;
    TodoSettings: TPanel;
    lblTodoFilter: TLabel;
    chkTodoIncomplete: TCheckBox;
    cmbTodoFilter: TComboBox;
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
    procedure actUpdatePageCount(Sender: TObject); // enable on pagecount> 0
    procedure actUpdateProject(Sender: TObject); // enable on fproject assigned
    procedure actUpdatePageProject(Sender: TObject); // enable on both above
    procedure actUpdatePageorProject(Sender: TObject); // enable on either of above
    procedure actUpdateEmptyEditor(Sender: TObject); // enable on unempty editor
    procedure actUpdateDebuggerRunning(Sender: TObject);// enable when debugger running
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
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
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
    procedure ShowPropertyInspItemClick(Sender: TObject);
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
    procedure actModifyWatchUpdate(Sender: TObject);
    procedure ClearallWatchPopClick(Sender: TObject);
    procedure PageControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure mnuCVSClick(Sender: TObject);
    procedure actDesignerCopyExecute(Sender: TObject);
    procedure actDesignerCutExecute(Sender: TObject);
    procedure actWxPropertyInspectorCutExecute(Sender: TObject);
    procedure actWxPropertyInspectorCopyExecute(Sender: TObject);
    procedure actWxPropertyInspectorPasteExecute(Sender: TObject);
    procedure actWxPropertyInspectorDeleteExecute(Sender: TObject);
    procedure actDesignerPasteExecute(Sender: TObject);
    procedure actDesignerDeleteExecute(Sender: TObject);
    function isFileOpenedinEditor(strFile: string): Boolean;
    procedure OnCompileTerminated(Sender: TObject);
    procedure doDebugAfterCompile(Sender: TObject);

{$IFDEF WX_BUILD}
    procedure WxPropertyInspectorContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure ELDesigner1ContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure ELDesigner1ChangeSelection(Sender: TObject);
    procedure ELDesigner1ControlDeleted(Sender: TObject; AControl: TControl);
    procedure ELDesigner1ControlHint(Sender: TObject; AControl: TControl;var AHint: string);
    procedure ELDesigner1ControlInserted(Sender: TObject; AControl: TControl);
    procedure ELDesigner1ControlInserting(Sender: TObject; var AParent: TWinControl; var AControlClass: TControlClass);
    procedure ELDesigner1ControlDoubleClick(Sender: TObject);
    procedure ELDesigner1KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure ELDesigner1Modified(Sender: TObject);
    procedure JvInspPropertiesAfterItemCreate(Sender: TObject;Item: TJvCustomInspectorItem);
    procedure JvInspPropertiesDataValueChanged(Sender: TObject;Data: TJvCustomInspectorData);
    procedure JvInspEventsAfterItemCreate(Sender: TObject;Item: TJvCustomInspectorItem);
    procedure JvInspEventsDataValueChanged(Sender: TObject;Data: TJvCustomInspectorData);
    procedure JvInspEventsItemValueChanged(Sender: TObject;Item: TJvCustomInspectorItem);
    procedure cbxControlsxChange(Sender: TObject);
    procedure JvInspPropertiesBeforeSelection(Sender: TObject;NewItem: TJvCustomInspectorItem; var Allow: Boolean);
    procedure JvInspPropertiesItemValueChanged(Sender: TObject;Item: TJvCustomInspectorItem);
    procedure ViewControlIDsClick(Sender: TObject);
    procedure AlignToGridClick(Sender: TObject);
    procedure AlignToLeftClick(Sender: TObject);
    procedure AlignToRightClick(Sender: TObject);
    procedure AlignToMiddleVerticalClick(Sender: TObject);
    procedure AlignToMiddleHorizontalClick(Sender: TObject);
    procedure AlignToTopClick(Sender: TObject);
    procedure AlignToBottomClick(Sender: TObject);
    procedure DesignerOptionsClick(Sender: TObject);
    procedure ChangeCreationOrder1Click(Sender: TObject);
    procedure SelectParentClick(Sender: TObject);
    procedure LockControlClick(Sender: TObject);
    procedure OnPropertyItemSelected(Sender: TObject);
    function IsFromScrollBarShowing:boolean;
    procedure actNewWxFrameExecute(Sender: TObject);
    procedure actNewwxDialogExecute(Sender: TObject);
    procedure ProjectViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tmrInspectorHelperTimer(Sender: TObject);
    procedure actRestartDebugExecute(Sender: TObject);
    procedure actUpdateDebuggerPaused(Sender: TObject);
    procedure actPauseDebugUpdate(Sender: TObject);
    procedure actPauseDebugExecute(Sender: TObject);
    procedure lvThreadsDblClick(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure actViewToDoListUpdate(Sender: TObject);
    procedure lvTodoCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
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
{$ENDIF}

  private
    fToDoList: TList;
    fToDoSortColumn: Integer;
    fHelpfiles: ToysStringList;
    ShowPropertyInspItem: TMenuItem;
    fTools: TToolController;
    fProjectCount: integer;
    fCompiler: TCompiler;
    bProjectLoading: boolean;
    fstrCppFileToOpen:string;
    tmrInspectorHelper:TTimer;
    OldLeft: integer;
    OldTop: integer;
    OldWidth: integer;
    OldHeight: integer;
    IsIconized: Boolean;
    ReloadFilenames: TList;

    function AskBeforeClose(e: TEditor; Rem: boolean;var Saved:Boolean): boolean;
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
    function SaveFile(e: TEditor): Boolean;
    function SaveFileAs(e: TEditor): Boolean;
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
{$IFDEF WX_BUILD}
    procedure OnDockableFormClosed(Sender: TObject; var Action: TCloseAction);
    procedure ParseCustomCmdLine(strLst:TStringList);
    procedure SurroundWithClick(Sender: TObject);
    procedure DoCreateWxSpecificItems;
{$ENDIF}

    //Private debugger functions
    procedure PrepareDebugger;
    procedure InitializeDebugger;

    //Private To-do list functions
    procedure RefreshTodoList;
    procedure AddTodoFiles(Current, InProject, NotInProject, OpenOnly: boolean);
    procedure BuildTodoList;
    function BreakupTodo(Filename: string; sl: TStrings; Line: integer; Token: string; HasUser, HasPriority: boolean): Integer;

  public
    procedure DoCreateEverything;
    procedure DoApplyWindowPlacement;
    procedure OpenFile(s: string; withoutActivation: Boolean = false); // Modified for wx
    procedure OpenProject(s: string);
    function FileIsOpen(const s: string; inprj: boolean = FALSE): integer;
    function GetEditor(const index: integer = -1): TEditor;
    function GetEditorFromFileName(ffile: string; donotReOpen:boolean = false): TEditor;
    procedure GotoBreakpoint(bfile: string; bline: integer);
    procedure RemoveActiveBreakpoints;
    procedure AddDebugVar(s: string);
    procedure GotoTopOfStackTrace;
    procedure SetProjCompOpt(idx: integer; Value: boolean);// set project's compiler option indexed 'idx' to value 'Value'
    function CloseEditor(index: integer; Rem: boolean): Boolean;

    //Debugger stuff
    procedure AddBreakPointToList(line_number: integer; e: TEditor);
    procedure RemoveBreakPointFromList(line_number: integer; e:TEditor);
    procedure OnCallStack(Callstack: TList);
    procedure OnThreads(Threads: TList);
    procedure OnLocals(Locals: TList);

{$IFDEF WX_BUILD}
    procedure SurroundString(e: TEditor;strStart,strEnd:String);
    procedure CppCommentString(e: TEditor);
    function GetCurrentFileName:String;
    function GetCurrentClassName:string;
    procedure GetFunctionList(strClassName:String;fncList:TStringList);

    property Compiler: TCompiler read fCompiler write fCompiler;
{$ENDIF}
  private
    procedure UMEnsureRestored(var Msg: TMessage); message UM_ENSURERESTORED;
    procedure WMCopyData(var Msg: TWMCopyData); message WM_COPYDATA;
  protected
    procedure CreateParams(var Params: TCreateParams); override;

  public
{$IFDEF WX_BUILD}
  // Wx Property Inspector Popup Menu
  WxPropertyInspectorPopup:TPopupMenu;
  WxPropertyInspectorMenuEdit : TMenuItem;
  WxPropertyInspectorMenuCopy : TMenuItem;
  WxPropertyInspectorMenuCut : TMenuItem;
  WxPropertyInspectorMenuPaste : TMenuItem;
  WxPropertyInspectorMenuDelete : TMenuItem;

  //PopUpMenu
  DesignerPopup:TPopupMenu;
  DesignerMenuEdit : TMenuItem;
  DesignerMenuCopy : TMenuItem;
  DesignerMenuCut : TMenuItem;
  DesignerMenuPaste : TMenuItem;
  DesignerMenuDelete : TMenuItem;
  DesignerMenuSep1 : TMenuItem;
  DesignerMenuCopyWidgetName : TMenuItem;
  DesignerMenuChangeCreationOrder :TMenuItem;
  DesignerMenuViewIDs:TMenuItem;
  DesignerMenuSep2:TMenuItem;
  DesignerMenuSelectParent: TMenuItem;
  DesignerMenuAlign : TMenuItem;
  DesignerMenuAlignToGrid, DesignerMenuAlignVertical, DesignerMenuAlignHorizontal,
  DesignerMenuAlignToLeft, DesignerMenuAlignToRight,
  DesignerMenuAlignToTop, DesignerMenuAlignToBottom,
  DesignerMenuAlignToMiddle : TMenuItem;
  DesignerMenuAlignToMiddleVertical, DesignerMenuAlignToMiddleHorizontal: TMenuItem;
  DesignerMenuLocked: TMenuItem;
  DesignerMenuSep3: TMenuItem;
  DesignerMenuDesignerOptions:TMenuItem;
  ToolsMenuDesignerOptions: TMenuItem;

  JvInspectorDotNETPainter1: TJvInspectorBorlandPainter;
  JvInspectorDotNETPainter2: TJvInspectorBorlandPainter;

  ELDesigner1: TELDesigner;
  
  //Property Inspector controls
  cbxControlsx: TComboBox;
  pgCtrlObjectInspector: TPageControl;
  TabProperty: TTabSheet;
  TabEvent: TTabSheet;
  pnlMainInsp:TPanel;
  JvInspProperties: TJvInspector;
  JvInspEvents: TJvInspector;
  
  //Component palette
  ComponentPalette: TComponentPalette;
  
  //Docking controls
  frmProjMgrDock:TForm;
  frmPaletteDock: TForm;
  frmInspectorDock:TForm;
  frmReportDocks: array[0..5] of TForm;
  strStdwxIDList:TStringList;
{$ENDIF}
  function SaveFileInternal(e: TEditor ; bParseFile:Boolean = true): Boolean;

{$IFDEF WX_BUILD}
  private
    procedure GetIntialFormData(frm: TfrmCreateFormProp; var strFName, strCName, strFTitle: string; var dlgStyle: TWxDlgStyleSet; dsgnType:TWxDesignerType);
    procedure CreateNewDialogOrFrameCode(dsgnType:TWxDesignerType; frm:TfrmCreateFormProp; insertProj:integer);
    procedure NewWxProjectCode(dsgnType:TWxDesignerType);
    procedure ParseAndSaveTemplate(template, destination: string; frm:TfrmCreateFormProp);
    function CreateCreateFormDlg(dsgnType:TWxDesignerType; insertProj:integer;projShow:boolean;filenamebase: string = ''): TfrmCreateFormProp;
    function CreateFormFile(strFName, strCName, strFTitle: string; dlgSStyle:TWxDlgStyleSet;dsgnType:TWxDesignerType): Boolean;
  public
    procedure DisableDesignerControls;
    procedure EnableDesignerControls;
{$ENDIF}

  public
    fProject: TProject;
    fDebugger: TDebugger;
    CacheCreated: Boolean;

{$IFDEF WX_BUILD}
    strGlobalCurrentFunction:String;
    DisablePropertyBuilding:Boolean;
    boolInspectorDataClear:Boolean;
    intControlCount: Integer;
    SelectedComponent: TComponent;
    PreviousComponent: TComponent;
    PreviousStringValue: string;
    PreviousComponentName:string;
    FirstComponentBeingDeleted:String;
    function OpenWithAssignedProgram(strFileName:String):boolean;
    procedure BuildProperties(Comp: TControl;boolForce:Boolean = false);
    procedure BuildComponentList(Designer: TfrmNewForm);
    function isFunctionAvailable(intClassID:Integer;strFunctionName:String):boolean;
    function isCurrentFormFilesNeedToBeSaved:Boolean;
    function saveCurrentFormFiles:Boolean;
    function CreateFunctionInEditor(var strFncName:string;strReturnType,strParameter :String;var ErrorString:String):boolean;overload;
    function CreateFunctionInEditor(eventProperty:TJvCustomInspectorData;strClassName: string; SelComponent:TComponent; var strFunctionName: string; strEventFullName: string;var ErrorString:String):Boolean;overload;
    function LocateFunctionInEditor(eventProperty:TJvCustomInspectorData;strClassName: string; SelComponent:TComponent; var strFunctionName: string; strEventFullName: string):Boolean;
    procedure OnEventPopup(Item: TJvCustomInspectorItem; Value: TStrings);
    procedure OnStdWxIDListPopup(Item: TJvCustomInspectorItem; Value: TStrings);
    procedure UpdateDefaultFormContent;
    function GetFunctionsFromSource(classname: string; var strLstFuncs:TStringList): Boolean;
    function GetCurrentDesignerForm: TfrmNewForm;
    function isCurrentPageDesigner: Boolean;
    function ReplaceClassNameInEditorFile(FileName, FromClassName, ToClassName:string): Boolean;
    function ReplaceClassNameInEditor(strLst:TStringList;edt:TEditor;FromClassName, ToClassName:string):boolean;
    function GetClassNameLocationsInEditorFiles(var HppStrLst,CppStrLst:TStringList;FileName, FromClassName, ToClassName:string): Boolean;

    function LocateFunction(strFunctionName:String):boolean;
{$ENDIF}
    property FormProgress: TProgressBar read prgFormProgress write prgFormProgress;
  end;
var
  MainForm: TMainForm;

implementation

uses
{$IFDEF WIN32}
  ShellAPI, IniFiles, Clipbrd, MultiLangSupport, version,
  devcfg, datamod, helpfrm, NewProjectFrm, AboutFrm, PrintFrm,
  CompOptionsFrm, EditorOptfrm, Incrementalfrm, Search_Center, Envirofrm,
  SynEdit, SynEditTypes, JvAppIniStorage, JvAppStorage,
  debugfrm, Types, Prjtypes, devExec,
  NewTemplateFm, FunctionSearchFm, NewMemberFm, NewVarFm, NewClassFm,
  ProfileAnalysisFm, debugwait, FilePropertiesFm, AddToDoFm,
  ImportMSVCFm, CPUFrm, FileAssocs, TipOfTheDayFm, Splash,
  WindowListFrm, ParamsFrm, WebUpdate, ProcessListFrm, ModifyVarFrm

{$IFDEF WX_BUILD}
  //Our dependencies
  , CompFileIo, CreateOrderFm, ViewIDForm, devDockStyle, FilesReloadFrm,

  //Components
  WxSplitterWindow, WxNotebook, WxNoteBookPage, WxToolbar, WxToolButton,
  WxSeparator, WxStatusBar, WxNonVisibleBaseComponent, WxMenuBar, WxPopupMenu,
  WxStaticBitmap, WxBitmapButton, WxStdDialogButtonSizer
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
  ProfileAnalysisFm, debugwait, FilePropertiesFm, AddToDoFm, ViewToDoFm,
  ImportMSVCFm, CPUFrm, FileAssocs, TipOfTheDayFm, Splash,
  WindowListFrm, ParamsFrm, WebUpdate, ProcessListFrm, ModifyVarFrm;
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
  INT_BRACES= 1;
  INT_TRY_CATCH= 2;
  INT_C_COMMENT= 3;
  INT_FOR= 4;
  INT_FOR_I= 5;
  INT_WHILE= 6;
  INT_DO_WHILE= 7;
  INT_IF= 8;
  INT_IF_ELSE= 9;
  INT_SWITCH= 10;
  INT_CPP_COMMENT= 11;

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

{$IFDEF WX_BUILD}
procedure TMainForm.DoCreateWxSpecificItems;
var
  I: Integer;
  ini :TiniFile;
  lbDockClient1: TJvDockClient;
  lbDockClient2: TJvDockClient;
  lbDockClient3: TJvDockClient;
begin
  tmrInspectorHelper:=TTimer.Create(self);
  tmrInspectorHelper.Enabled:=false;
  tmrInspectorHelper.Interval:=500;
  
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

  //Property Inspector
  frmInspectorDock := TForm.Create(self);
  frmInspectorDock.ParentFont := True;
  frmInspectorDock.Font.Assign(Font);
  with frmInspectorDock do
  begin
    Name := 'frmInspectorDock';
    Caption := 'Property Inspector';
    BorderStyle := bsSizeToolWin;
    Color := clBtnFace;
    Width:=300;

    DockSite := True;
    DragKind := dkDock;
    DragMode := dmAutomatic;
    FormStyle := fsStayOnTop;
    OnClose := OnDockableFormClosed;

    lbDockClient2 := TJvDockClient.Create(frmInspectorDock);
    with lbDockClient2 do
    begin
      Name := 'lbDockClient2';
      DirectDrag := True;
      DockStyle := DockServer.DockStyle;
    end;
  end;

  frmPaletteDock := TForm.Create(Self);
  frmPaletteDock.ParentFont := True;
  frmPaletteDock.Font.Assign(Font);
  ComponentPalette := TComponentPalette.Create(frmPaletteDock);
  with frmPaletteDock do
  begin
    Name := 'frmPaletteDock';
    Caption := 'Components';
    BorderStyle := bsSizeToolWin;
    Color := clBtnFace;
    Width:= 170;

    DockSite := True;
    DragKind := dkDock;
    DragMode := dmAutomatic;
    FormStyle := fsStayOnTop;
    OnClose := OnDockableFormClosed;

    lbDockClient3 := TJvDockClient.Create(frmPaletteDock);
    with lbDockClient3 do
    begin
      Name := 'lbDockClient3';
      DirectDrag := True;
      DockStyle := DockServer.DockStyle;
    end;
  end;

  frmPaletteDock.ManualDock(DockServer.RightDockPanel);
  frmProjMgrDock.ManualDock(DockServer.LeftDockPanel);
  frmInspectorDock.ManualDock(DockServer.LeftDockPanel, frmProjMgrDock, alBottom);
  ShowDockForm(frmProjMgrDock);
  ShowDockForm(frmInspectorDock);
  HideDockForm(frmPaletteDock);

  //Add the property inspector view menu item
  ShowPropertyInspItem := TMenuItem.Create(MainMenu);
  ShowPropertyInspItem.Checked := False;
  ShowPropertyInspItem.OnClick := ShowPropertyInspItemClick;
  ShowPropertyInspItem.Caption := 'Show Property Inspector';
  ViewMenu.Insert(5, ShowPropertyInspItem);

  //Check both "view" items
  ShowPropertyInspItem.Checked := True;
  ShowProjectInspItem.Checked := True;

  strStdwxIDList:=GetPredefinedwxIds;
  WxPropertyInspectorPopup := TPopupMenu.Create(Self);
  WxPropertyInspectorMenuEdit := TMenuItem.Create(Self);
  WxPropertyInspectorMenuCopy := TMenuItem.Create(Self);
  WxPropertyInspectorMenuCut := TMenuItem.Create(Self);
  WxPropertyInspectorMenuPaste := TMenuItem.Create(Self);
  WxPropertyInspectorMenuDelete := TMenuItem.Create(Self);

  DesignerPopup := TPopupMenu.Create(Self);
  DesignerMenuEdit := TMenuItem.Create(Self);
  DesignerMenuCopy := TMenuItem.Create(Self);
  DesignerMenuCut := TMenuItem.Create(Self);
  DesignerMenuPaste := TMenuItem.Create(Self);
  DesignerMenuDelete := TMenuItem.Create(Self);
  DesignerMenuSep1 := TMenuItem.Create(Self);
  DesignerMenuCopyWidgetName := TMenuItem.Create(Self);
  DesignerMenuChangeCreationOrder := TMenuItem.Create(Self);
  DesignerMenuSelectParent := TMenuItem.Create(Self);
  DesignerMenuLocked := TMenuItem.Create(Self);
  DesignerMenuViewIDs:= TMenuItem.Create(Self);
  DesignerMenuSep2:= TMenuItem.Create(Self);
  DesignerMenuAlign := TMenuItem.Create(Self);
  DesignerMenuAlignToGrid := TMenuItem.Create(DesignerMenuAlign);
  DesignerMenuAlignVertical := TMenuItem.Create(DesignerMenuAlign);
  DesignerMenuAlignHorizontal := TMenuItem.Create(DesignerMenuAlign);
  DesignerMenuAlignToTop := TMenuItem.Create(DesignerMenuAlignVertical);
  DesignerMenuAlignToMiddleVertical := TMenuItem.Create(DesignerMenuAlignVertical);
  DesignerMenuAlignToBottom := TMenuItem.Create(DesignerMenuAlignVertical);
  DesignerMenuAlignToLeft := TMenuItem.Create(DesignerMenuAlignHorizontal);
  DesignerMenuAlignToMiddleHorizontal := TMenuItem.Create(DesignerMenuAlignHorizontal);
  DesignerMenuAlignToRight := TMenuItem.Create(DesignerMenuAlignHorizontal);
  DesignerMenuSep3 := TMenuItem.Create(DesignerPopup);
  DesignerMenuDesignerOptions:= TMenuItem.Create(Self);
  ToolsMenuDesignerOptions := TMenuItem.Create(ToolsMenu);

  with WxPropertyInspectorPopup do
  begin
    Name := 'WxPropertyInspectorPopup';
  end;
  with WxPropertyInspectorMenuEdit do
  begin
    Name := 'WxPropertyInspectorMenuEdit';
    Caption := 'Wx Property Edit';
  end;
  with WxPropertyInspectorMenuCopy do
  begin
    Name := 'WxPropertyInspectorMenuCopy';
   Action := actWxPropertyInspectorCopy;
  end;
  with WxPropertyInspectorMenuCut do
  begin
    Name := 'WxPropertyInspectorMenuCut';
   Action :=  actWxPropertyInspectorCut;
  end;
  with WxPropertyInspectorMenuPaste do
  begin
    Name := 'WxPropertyInspectorMenuPaste';
    Action := actWxPropertyInspectorPaste;
   end;
  with WxPropertyInspectorMenuDelete do
  begin
    Name := 'WxPropertyInspectorMenuDelete';
    Action := actDelete;
  end;

  with DesignerPopup do
  begin
    Name := 'DesignerPopup';
  end;
  with DesignerMenuEdit do
  begin
    Name := 'DesignerMenuEdit';
    Caption := 'Edit';
  end;
  with DesignerMenuCopy do
  begin
    Name := 'DesignerMenuCopy';
    Action := actDesignerCopy;
  end;
  with DesignerMenuCut do
  begin
    Name := 'DesignerMenuCut';
    Action := actDesignerCut;
  end;
  with DesignerMenuPaste do
  begin
    Name := 'DesignerMenuPaste';
    Action := actDesignerPaste;
  end;
  with DesignerMenuDelete do
  begin
    Name := 'DesignerMenuDelete';
    Action := actDesignerDelete;
  end;
  with DesignerMenuSep1 do
  begin
    Name := 'DesignerMenuSep1';
    Caption := '-';
  end;
  with DesignerMenuCopyWidgetName do
  begin
    Name := 'DesignerMenuCopyWidgetName';
    Caption := 'Copy Widget Name';
    Visible := False;
  end;
  with DesignerMenuChangeCreationOrder do
  begin
    Name := 'DesignerMenuChangeCreationOrder';
    Caption := 'Change Creation Order';
    OnClick := ChangeCreationOrder1Click;
  end;
  with DesignerMenuSelectParent do
  begin
    Name := 'DesignerMenuSelectParent';
    Caption := 'Select Parent';
  end;
  with DesignerMenuLocked do
  begin
    Name := 'DesignerMenuLocked';
    Caption := 'Lock Control';
    OnClick := LockControlClick;
  end;

  with DesignerMenuSep2 do
  begin
    Name := 'DesignerMenuSep2';
    Caption := '-';
  end;
  with DesignerMenuViewIDs do
  begin
    Name := 'DesignerMenuViewIDs';
    Caption := 'View Control IDs';
    OnClick := ViewControlIDsClick;
  end;

  with DesignerMenuAlign do
  begin
    Name := 'DesignerMenuAlign';
    Caption := 'Align';
   end;

  with DesignerMenuAlignToGrid do
  begin
    Name := 'DesignerMenuAlignToGrid';
    Caption := 'To Grid';
    OnClick := AlignToGridClick;
  end;

  with DesignerMenuAlignVertical do
  begin
    Name := 'DesignerMenuAlignVertical';
    Caption := 'Vertical';
    end;

  with DesignerMenuAlignHorizontal do
  begin
    Name := 'DesignerMenuAlignHorizontal';
    Caption := 'Horizontal';
  end;

  with DesignerMenuAlignToLeft do
  begin
    Name := 'DesignerMenuAlignToLeft';
    Caption := 'To Left';
    OnClick := AlignToLeftClick;
  end;

  with DesignerMenuAlignToRight do
  begin
    Name := 'DesignerMenuAlignToRight';
    Caption := 'To Right';
    OnClick := AlignToRightClick;
  end;

  with DesignerMenuAlignToMiddleVertical do
  begin
    Name := 'DesignerMenuAlignToMiddleVertical';
    Caption := 'To Center';
    OnClick := AlignToMiddleVerticalClick;
  end;

  with DesignerMenuAlignToMiddleHorizontal do
  begin
    Name := 'DesignerMenuAlignToMiddleHorizontal';
    Caption := 'To Center';
    OnClick := AlignToMiddleHorizontalClick;
  end;

  with DesignerMenuAlignToTop do
  begin
    Name := 'DesignerMenuAlignToTop';
    Caption := 'To Top';
    OnClick := AlignToTopClick;
  end;

  with DesignerMenuAlignToBottom do
  begin
    Name := 'DesignerMenuAlignToBottom';
    Caption := 'To Bottom';
    OnClick := AlignToBottomClick;
  end;

  with DesignerMenuSep3 do
  begin
    Name := 'DesignerMenuSep3';
    Caption := '-';
  end;
  with DesignerMenuDesignerOptions do
  begin
    Name := 'DesignerMenuDesignerOptions';
    Caption := 'Designer Options';
    OnClick := DesignerOptionsClick;
  end;
  with ToolsMenuDesignerOptions do
  begin
    Name := 'ToolsMenuDesignerOptions';
    Caption := 'Designer Options';
    OnClick := DesignerOptionsClick;
  end;

  ToolsMenu.Insert(3, ToolsMenuDesignerOptions);
  WxPropertyInspectorPopup.Items.Add(WxPropertyInspectorMenuCut);
  WxPropertyInspectorPopup.Items.Add(WxPropertyInspectorMenuCopy);
  WxPropertyInspectorPopup.Items.Add(WxPropertyInspectorMenuPaste);
  WxPropertyInspectorPopup.Items.Add(WxPropertyInspectorMenuDelete);

  DesignerPopup.Items.Add(DesignerMenuCut);
  DesignerPopup.Items.Add(DesignerMenuCopy);
  DesignerPopup.Items.Add(DesignerMenuPaste);
  DesignerPopup.Items.Add(DesignerMenuDelete);
  DesignerPopup.Items.Add(DesignerMenuSep1);
  DesignerPopup.Items.Add(DesignerMenuCopyWidgetName);
  DesignerPopup.Items.Add(DesignerMenuChangeCreationOrder);
  DesignerPopup.Items.Add(DesignerMenuViewIDs);
  DesignerPopup.Items.Add(DesignerMenuSep2);
  DesignerPopup.Items.Add(DesignerMenuSelectParent);
  DesignerPopup.Items.Add(DesignerMenuAlign);
  DesignerPopup.Items.Add(DesignerMenuLocked);
  DesignerPopup.Items.Add(DesignerMenuSep3);
  DesignerPopup.Items.Add(DesignerMenuDesignerOptions);
  
  DesignerMenuAlign.Add(DesignerMenuAlignToGrid);
  DesignerMenuAlign.Add(DesignerMenuAlignHorizontal);
  DesignerMenuAlignHorizontal.Add(DesignerMenuAlignToLeft);
  DesignerMenuAlignHorizontal.Add(DesignerMenuAlignToMiddleHorizontal);
  DesignerMenuAlignHorizontal.Add(DesignerMenuAlignToRight);

  DesignerMenuAlign.Add(DesignerMenuAlignVertical);
  DesignerMenuAlignVertical.Add(DesignerMenuAlignToTop);
  DesignerMenuAlignVertical.Add(DesignerMenuAlignToMiddleVertical);
  DesignerMenuAlignVertical.Add(DesignerMenuAlignToBottom);

  //Object inspector Styles
  JvInspectorDotNETPainter1 := TJvInspectorBorlandPainter.Create(frmInspectorDock);
  JvInspectorDotNETPainter2 := TJvInspectorBorlandPainter.Create(frmInspectorDock);
  with JvInspectorDotNETPainter1 do
  begin
    Name := 'JvInspectorDotNETPainter1';
    DrawNameEndEllipsis := False;
  end;
  with JvInspectorDotNETPainter2 do
  begin
    Name := 'JvInspectorDotNETPainter2';
    DrawNameEndEllipsis := False;
  end;

  ELDesigner1 := TELDesigner.Create(Self);
  with ELDesigner1 do
  begin
    Name := 'ELDesigner1';
    ClipboardFormat := 'Extension Library designer components';
    PopupMenu := DesignerPopup;
    SnapToGrid:=false;
    GenerateXRC :=false;
    OnContextPopup :=ELDesigner1ContextPopup;
    OnChangeSelection := ELDesigner1ChangeSelection;
    OnControlDeleted := ELDesigner1ControlDeleted;
    OnControlHint := ELDesigner1ControlHint;
    OnControlInserted := ELDesigner1ControlInserted;
    OnControlInserting := ELDesigner1ControlInserting;
    OnModified := ELDesigner1Modified;
    OnDblClick:=ELDesigner1ControlDoubleClick;
    OnKeyDown := ELDesigner1KeyDown;
  end;

  ini := TiniFile.Create(devDirs.Config + 'devcpp.ini');
  try
    ELDesigner1.Grid.Visible:=ini.ReadBool('wxWidgets','cbGridVisible',ELDesigner1.Grid.Visible);
    ELDesigner1.Grid.XStep:=ini.ReadInteger('wxWidgets','lbGridXStepUpDown',ELDesigner1.Grid.XStep);
    ELDesigner1.Grid.YStep:=ini.ReadInteger('wxWidgets','lbGridYStepUpDown',ELDesigner1.Grid.YStep);
    ELDesigner1.SnapToGrid:=ini.ReadBool('wxWidgets','cbSnapToGrid',ELDesigner1.SnapToGrid);
    ELDesigner1.GenerateXRC:=ini.ReadBool('wxWidgets','cbGenerateXRC',ELDesigner1.GenerateXRC);

    // String format tells us what function to wrap strings with in the generated C++ code
    // Possible values are wxT(), _T(), and _()
    StringFormat := ini.ReadString('wxWidgets', 'cbStringFormat', StringFormat);
    // if there's no preference saved in the ini file, then default to wxT()
    if trim(StringFormat) = '' then
      StringFormat := 'wxT';

    if ini.ReadBool('wxWidgets', 'cbControlHints', true) then
      ELDesigner1.ShowingHints := ELDesigner1.ShowingHints + [htControl]
    else
      ELDesigner1.ShowingHints := ELDesigner1.ShowingHints - [htControl];

    if ini.ReadBool('wxWidgets', 'cbSizeHints', true) then
      ELDesigner1.ShowingHints := ELDesigner1.ShowingHints + [htSize]
    else
      ELDesigner1.ShowingHints := ELDesigner1.ShowingHints - [htSize];

    if ini.ReadBool('wxWidgets', 'cbMoveHints', true) then
      ELDesigner1.ShowingHints := ELDesigner1.ShowingHints + [htMove]
    else
      ELDesigner1.ShowingHints := ELDesigner1.ShowingHints - [htMove];

    if ini.ReadBool('wxWidgets', 'cbInsertHints', true) then
      ELDesigner1.ShowingHints := ELDesigner1.ShowingHints + [htInsert]
    else
      ELDesigner1.ShowingHints := ELDesigner1.ShowingHints - [htInsert];
  finally
    ini.destroy;
  end;

  pnlMainInsp := TPanel.Create(frmInspectorDock);
  cbxControlsx := TComboBox.Create(frmInspectorDock);
  pgCtrlObjectInspector := TPageControl.Create(frmInspectorDock);
  TabProperty := TTabSheet.Create(frmInspectorDock);
  JvInspProperties := TJvInspector.Create(frmInspectorDock);
  TabEvent := TTabSheet.Create(frmInspectorDock);
  JvInspEvents := TJvInspector.Create(frmInspectorDock);

  with pnlMainInsp do
  begin
    Name := 'pnlMainInsp';
    Caption := '';
    Parent := frmInspectorDock;
    Left := 0;
    Top := 0;
    Width := 196;
    Height := 28;
    Align := alClient;
    BevelOuter := bvNone;
    TabOrder := 0;
  end;
  with cbxControlsx do
  begin
    Name := 'cbxControlsx';
    Parent := pnlMainInsp;
    Align := alTop;
    Left := 0;
    Top := 1;
    Width := 201;
    Height := 21;
    Style := csDropDownList;
    Enabled := False;
    ItemHeight := 13;
    Sorted := True;
    TabOrder := 0;
    OnChange := cbxControlsxChange;
  end;
  with pgCtrlObjectInspector do
  begin
    Name := 'pgCtrlObjectInspector';
    Parent := pnlMainInsp;
    Left := 0;
    Top := 28;
    Width := 196;
    Height := 79;
    ActivePage := TabProperty;
    Align := alClient;
    Enabled := False;
    TabIndex := 0;
    TabOrder := 1;
  end;
  with TabProperty do
  begin
    Name := 'TabProperty';
    Parent := pgCtrlObjectInspector;
    PageControl := pgCtrlObjectInspector;
    Caption := 'Properties';
  end;
  with JvInspProperties do
  begin
    Name := 'JvInspProperties';
    Parent := TabProperty;
    Left := 0;
    Top := 0;
    Width := 188;
    Height := 51;
    Align := alClient;
    BandWidth := 150;
    BevelInner := bvNone;
    RelativeDivider := False;
    Divider := 100;
    ItemHeight := 16;
    Painter := JvInspectorDotNETPainter1;
    ReadOnly := False;
    UseBands := False;
    WantTabs := False;

    // Add popup menu for Wx property inspector
    OnEditorContextPopup := WxPropertyInspectorContextPopup;
    AfterItemCreate := JvInspPropertiesAfterItemCreate;
    BeforeSelection := JvInspPropertiesBeforeSelection;
    OnDataValueChanged := JvInspPropertiesDataValueChanged;
    OnItemValueChanged := JvInspPropertiesItemValueChanged;
  end;
  with TabEvent do
  begin
    Name := 'TabEvent';
    Parent := pgCtrlObjectInspector;
    PageControl := pgCtrlObjectInspector;
    Caption := 'Events';
  end;
  with JvInspEvents do
  begin
    Name := 'JvInspEvents';
    Parent := TabEvent;
    Left := 0;
    Top := 0;
    Width := 188;
    Height := 51;
    Align := alClient;
    BandWidth := 150;
    BevelInner := bvNone;
    RelativeDivider := False;
    Divider := 100;
    ItemHeight := 16;
    Painter := JvInspectorDotNETPainter2;
    ReadOnly := False;
    UseBands := False;
    WantTabs := False;

    // Add popup menu for Wx property inspector
    OnEditorContextPopup := WxPropertyInspectorContextPopup;
    AfterItemCreate := JvInspEventsAfterItemCreate;
    OnDataValueChanged := JvInspEventsDataValueChanged;
    OnItemValueChanged := JvInspEventsItemValueChanged;
    OnItemSelected:= OnPropertyItemSelected;
  end;

  //"Surround With" menu
  trycatchPopItem.Tag            := INT_TRY_CATCH;
  trycatchPopItem.OnClick        := SurroundWithClick;
  forloopPopItem.Tag             := INT_FOR;
  forloopPopItem.OnClick         := SurroundWithClick;
  forintloopPopItem.Tag          := INT_FOR_I;
  forintloopPopItem.OnClick      := SurroundWithClick;
  whileLoopPopItem.Tag           := INT_WHILE;
  whileLoopPopItem.OnClick       := SurroundWithClick;
  dowhileLoopPopItem.Tag         := INT_DO_WHILE;
  dowhileLoopPopItem.OnClick     := SurroundWithClick;
  ifLoopPopItem.Tag              := INT_IF;
  ifLoopPopItem.OnClick          := SurroundWithClick;
  ifelseloopPopItem.Tag          := INT_IF_ELSE;
  ifelseloopPopItem.OnClick      := SurroundWithClick;
  switchLoopPopItem.Tag          := INT_SWITCH;
  switchLoopPopItem.OnClick      := SurroundWithClick;
  bracesPopItem.Tag              := INT_BRACES;
  bracesPopItem.OnClick          := SurroundWithClick;
  CStyleCommentPopItem.Tag       := INT_C_COMMENT;
  CStyleCommentPopItem.OnClick   := SurroundWithClick;
  CPPStyleCommentPopItem.Tag     := INT_CPP_COMMENT;
  CPPStyleCommentPopItem.OnClick := SurroundWithClick;

  //Setting data for the newly created GUI
  intControlCount := 1000;
end;
{$ENDIF}

procedure TMainForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
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
  strLstParams:TStringList;
begin
  if Msg.CopyDataStruct.dwData <> cCopyDataWaterMark then
  begin
     exit;
    //raise Exception.Create('Invalid data structure passed in WM_COPYDATA');
  end;
  PData := Msg.CopyDataStruct.lpData;
  strLstParams:=TStringList.Create;
  while PData^ <> #0 do
  begin
    strLstParams.add(StrPas(PData));
    //ProcessParam(Param);
    Inc(PData, Length(Param) + 1);
  end;
  Msg.Result := 1;
  ParseCustomCmdLine(strLstParams);
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
  NewDockTabs: TJvDockTabHostForm;

  procedure SetSplashStatus(str: string);
  begin
    if assigned(SplashForm) then
      SplashForm.StatusBar.SimpleText := str + '...';
  end;

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
  DockServer.DockStyle := TdevDockStyle.Create(Self);
  DockServer.DockStyle.TabServerOption.HotTrack := True;
  with TJvDockVIDConjoinServerOption(DockServer.DockStyle.ConjoinServerOption) do
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

{$IFDEF WX_BUILD}
  SetSplashStatus('Loading wxWidgets extensions');
  DoCreateWxSpecificItems;
{$ENDIF}

  // register file associations and DDE services
  DDETopic := DevCppDDEServer.Name;
  CheckAssociations;
  DragAcceptFiles(Self.Handle, TRUE);
  dmMain := TdmMain.Create(Self);
  ReloadFilenames := TList.Create;
  fHelpfiles := ToysStringList.Create;
  fTools := TToolController.Create;
  Caption := DEVCPP + ' ' + DEVCPP_VERSION;

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
    Offset := ToolsMenu.Indexof(PackageManagerItem);
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

  Application.HelpFile := ValidateFile(DEV_MAINHELP_FILE, devDirs.Help, TRUE);

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

  Constraints.MaxHeight := Monitor.Height;
  Constraints.MaxWidth := Monitor.Width;
  fCompiler.RunParams := '';
  devCompiler.UseExecParams := True;

{$IFDEF WX_BUILD}
  //variable for clearing up inspector data.
  //Added because there is a AV when adding a function
  //from the event list
  boolInspectorDataClear:=True;
  DisablePropertyBuilding:=false;
{$ENDIF}

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
      
      //Transfer all the controls from the message control to the new dock
      while MessageControl.Pages[I].ControlCount > 0 do
        MessageControl.Pages[I].Controls[0].Parent := NewDock;
    end;

    //Add the new dock tab
    AddDockTab(NewDock);
  end;

  if NewDocks.Count >= 2 then
  begin
    NewDockTabs := ManualTabDock(DockServer.BottomDockPanel, NewDocks[0], NewDocks[1]);
    for I := 2 to NewDocks.Count - 1 do
      ManualTabDockAddPage(NewDockTabs, NewDocks[I]);
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

  SetSplashStatus('Loading code completion cache');
  if Assigned(SplashForm) then
    CppParser1.OnCacheProgress := SplashForm.OnCacheProgress;
  InitClassBrowser(true {not CacheCreated});
  CppParser1.OnCacheProgress := nil;
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

procedure TMainForm.RemoveBreakPointFromList(line_number: integer; e:TEditor);
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
      Caption := PVariable(Locals[I])^.Name;
      SubItems.Add(PVariable(Locals[I])^.Value);
      SubItems.Add(PVariable(Locals[I])^.Location);
    end;
  lvLocals.Items.EndUpdate;
end;

// This method is called from devcpp.dpr. It's called at the very last, because
// it forces the form to show and we only want to display the form when it's
// ready and fully created
procedure TMainForm.DoApplyWindowPlacement;
begin
  if devData.WindowPlacement.rcNormalPosition.Right <> 0 then
    SetWindowPlacement(Self.Handle, @devData.WindowPlacement)
  else if not CacheCreated then // this is so weird, but the following call seems to take a lot of time to execute
    Self.Position := poScreenCenter;

  //Load the window layout from the INI file
  if FileExists(ExtractFilePath(devData.INIFile) + 'layout' + INI_EXT) then
    LoadDockTreeFromFile(ExtractFilePath(devData.INIFile) + 'layout' + INI_EXT);

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
    WebUpdateForm.XPMenu.Active := devData.XPTheme;
    TdevDockStyle(DockServer.DockStyle).NativeDocks := devData.NativeDocks;
{$IFNDEF COMPILER_7_UP}
    //Initialize theme support
    with TThemeManager.Create(Self) do
      Options := [toAllowNonClientArea, toAllowControls, toAllowWebContent, toSubclassAnimate, toSubclassButtons, toSubclassCheckListbox, toSubclassDBLookup, toSubclassFrame, toSubclassGroupBox, toSubclassListView, toSubclassPanel, toSubclassTabSheet, toSubclassSpeedButtons, toSubclassStatusBar, toSubclassTrackBar, toSubclassWinControl, toResetMouseCapture, toSetTransparency, toAlternateTabSheetDraw];
{$ENDIF}
{$IFNDEF PRIVATE_BUILD}
  except
  end;
{$ENDIF}

  if devImageThemes.IndexOf(devData.Theme) < 0 then
    devData.Theme := devImageThemes.Themes[0].Title; // 0 = New look (see ImageTheme.pas)

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
        CurrentTheme.MenuImages.GetIcon(frmReportDocks[Idx].Tag, frmReportDocks[Idx].Icon);
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
    LoadTheme;
    BuildHelpMenu;
    FormProgress.Parent := StatusBar;
    SetWindowLong(FormProgress.Handle, GWL_EXSTYLE,
      GetWindowLong(FormProgress.Handle, GWL_EXSTYLE) - WS_EX_STATICEDGE);
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

    //Initialize the To-do list settings
    cmbTodoFilter.ItemIndex := 5;
    cmbTodoFilter.OnChange(cmbTodoFilter);
    fFirstShow := False;
  end;
end;

{$IFDEF WX_BUILD}
procedure TMainForm.OnDockableFormClosed(Sender: TObject; var Action: TCloseAction);
begin
  //Sanity check
  if not (Sender is TForm) then
    Exit;

  //Update the menu list
  if TForm(Sender) = frmInspectorDock then
    ShowPropertyInspItem.Checked := False
  else if TForm(Sender) = frmProjMgrDock then
    ShowProjectInspItem.Checked := False;
end;
{$ENDIF}

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  JvAppIniFileStorage: TJvAppIniFileStorage;
begin
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
  JvAppIniFileStorage.FileName := ExtractFilePath(devData.INIFile) + 'layout' + INI_EXT;
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

  //Delete Event Insp Timer
  tmrInspectorHelper.destroy;
  SaveOptions;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
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

  while fToDoList.Count > 0 do
    if Assigned(fToDoList[0]) then begin
      Dispose(PToDoRec(fToDoList[0]));
      fToDoList.Delete(0);
    end;
  fToDoList.Free;

{$IFDEF WX_BUILD}
  strStdwxIDList.Free;
{$ENDIF WX_BUILD}
end;

procedure TMainForm.ParseCmdLine;
var
  idx: integer;
  strLstParams:TStringList;
begin
  idx := 1;
  strLstParams:=TStringList.Create;
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
procedure TMainForm.ParseCustomCmdLine(strLst:TStringList);
var
  idx: integer;
  intParamCount:Integer;
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
    if FileExists(strLst[idx]) then begin
      if GetFileTyp(strLst[idx]) = utPrj then
      begin
        OpenProject(GetLongName(strLst[idx]));
        break; // only open 1 project
      end
      else begin
{$IFDEF WX_BUILD}
        if iswxForm(strLst[idx]) then
        begin
          OpenFile(GetLongName(ChangeFileExt(strLst[idx], H_EXT)), True);
          OpenFile(GetLongName(ChangeFileExt(strLst[idx], CPP_EXT)), true);
        end;
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
  aFile := ValidateFile(DEV_HELP_INI, devDirs.Help, TRUE);
  if aFile = '' then exit;

  // delete between "Dev-C++ Help" and first separator
  idx2 := HelpMenu.IndexOf(HelpSep1);
  for idx := pred(idx2) downto 1 do
    HelpMenu[idx].Free;

  // delete between first and second separator
  idx2 := HelpMenu.IndexOf(HelpSep2);
  for idx := pred(idx2) downto Succ(HelpMenu.IndexOf(HelpSep1)) do
    HelpMenu[idx].Free;

  HelpMenu.SubMenuImages := devImageThemes.CurrentTheme.HelpImages; //devTheme.Help;

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
      if (aFile = '') then continue;
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
        with Item do begin
          Caption := fHelpFiles.Names[idx];
          if ini.ReadBool(fHelpFiles.Names[idx], 'SearchWord', false) then
            OnClick := OnHelpSearchWord
          else
            OnClick := HelpItemClick;
          if ini.ReadBool(fHelpFiles.Names[idx], 'AffectF1', false) then
            ShortCut := TextToShortcut('F1');
          Tag := idx;
          ImageIndex := ini.ReadInteger(fHelpFiles.Names[idx], 'Icon', 0);
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
            ImageIndex := ini.ReadInteger(fHelpFiles.Names[idx], 'Icon', 0);
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
{$IFDEF WX_BUILD}
          if iswxForm(szFileName) then
          begin
            OpenFile(ChangeFileExt(szFileName, H_EXT), True);
            OpenFile(ChangeFileExt(szFileName, CPP_EXT), true);
          end;
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
    
    // popup menu
    actMsgCopy.Caption := Strings[ID_SHEET_POP_COPY];
    actMsgClear.Caption := Strings[ID_SHEET_POP_CLEAR];

{$IFDEF WX_BUILD}
actDesignerCopy.Caption := Strings[ID_ITEM_COPY];
actDesignerCut.Caption := Strings[ID_ITEM_CUT];
actDesignerPaste.Caption := Strings[ID_ITEM_PASTE];
actDesignerDelete.Caption := Strings[ID_ITEM_DELETE];
actWxPropertyInspectorCut.Caption := Strings[ID_ITEM_CUT];
actWxPropertyInspectorCopy.Caption := Strings[ID_ITEM_COPY];
actWxPropertyInspectorPaste.Caption := Strings[ID_ITEM_PASTE];
actNewwxDialog.Caption := Strings[ID_TB_NEW] + ' wxDialog';
actNewWxFrame.Caption := Strings[ID_TB_NEW] + ' wxFrame';
{$ENDIF}

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

    with devShortcuts1.MultiLangStrings do begin
      Caption := Strings[ID_SC_CAPTION];
      Title := Strings[ID_SC_TITLE];
      Tip := Strings[ID_SC_TIP];
      HeaderEntry := Strings[ID_SC_HDRENTRY];
      HeaderShortcut := Strings[ID_SC_HDRSHORTCUT];
      Cancel := Strings[ID_BTN_CANCEL];
      OK := Strings[ID_BTN_OK];
    end;

    pnlFull.Caption := Format(Strings[ID_FULLSCREEN_MSG], [DEVCPP,DEVCPP_VERSION]);

    // Mainform toolbar buttons
    NewAllBtn.Caption := Strings[ID_TB_NEW];
    InsertBtn.Caption := Strings[ID_TB_INSERT];
    ToggleBtn.Caption := Strings[ID_TB_TOGGLE];
    GotoBtn.Caption := Strings[ID_TB_GOTO];

    tbSpecials.Width := NewAllBtn.Width + InsertBtn.Width + ToggleBtn.Width + GotoBtn.Width;
  end;
  BuildBookMarkMenus;
  SetHints;
end;

function TMainForm.FileIsOpen(const s: string; inPrj: boolean = FALSE): integer;
var
  e: TEditor;
begin
  for result := 0 to pred(PageControl.PageCount) do
  begin
    e := GetEditor(result);
    if e.filename <> '' then
    begin
      if (AnsiCompareText(e.FileName, s) = 0) then
        if (not inprj) or (e.InProject) then exit;
    end
    else
      if AnsiCompareText(e.TabSheet.Caption, ExtractfileName(s)) = 0 then
        if (not inprj) or (e.InProject) then exit;
  end;
  result := -1;
end;

//TODO: lowjoel: The following three Save functions probably can be refactored for
//               speed. Anyone can reorganize it to optimize it for speed and efficiency,
//               as well as to cut the number of lines needed.
function TMainForm.SaveFileAs(e: TEditor): Boolean;
var
  I: Integer;
  dext,
    flt,
    s: string;
  idx: integer;
  CFilter, CppFilter, HFilter: Integer;
  boolIsForm,boolIsRC,boolISXRC:Boolean;
  ccFile,hfile:String;
begin
  Result := True;
  boolIsForm := False; boolIsRC := False; boolISXRC := False;
  idx := -1;
  if assigned(fProject) then
  begin
    if e.FileName = '' then
    begin
      idx := fProject.GetUnitFromString(e.TabSheet.Caption);
      boolIsForm:=iswxForm(e.TabSheet.Caption);
      boolIsRC:=isRCExt(e.TabSheet.Caption);
      boolIsXRC:=isXRCExt(e.TabSheet.Caption);
    end
    else
    begin
      idx := fProject.Units.Indexof(e.FileName);
      boolIsForm:=iswxForm(e.FileName);
      boolIsRC:=isRCExt(e.FileName);
      boolIsXRC:=isXRCExt(e.FileName);
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
      BuildFilter(flt, [FLT_RES{$IFDEF WX_BUILD},FLT_WXFORMS, FLT_XRC{$ENDIF}]);
      dext := RC_EXT;
      CFilter := 2;
      CppFilter := 2;
      HFilter := 2;
    end;

    {$IFDEF WX_BUILD}
    if boolIsForm then
    begin
      BuildFilter(flt, [FLT_WXFORMS]);
      dext := WXFORM_EXT;
      CFilter := 2;
      CppFilter := 2;
      HFilter := 2;
    end;

    if boolIsXRC then
    begin
      BuildFilter(flt, [FLT_XRC]);
      dext := XRC_EXT;
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
    {$ENDIF}

  end
  else
  begin
    BuildFilter(flt, ftAll);
    if e.IsRes then
      dext := RC_EXT
    else
      dext := CPP_EXT;
    if boolIsForm then
    begin
        dext := WXFORM_EXT;
    end;
    if boolIsRC then
    begin
        dext := RC_EXT;
    end;
    if boolIsXRC then
    begin
        dext := XRC_EXT;
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

    // select appropriate filter
    if (CompareText(ExtractFileExt(s), '.h') = 0) or
       (CompareText(ExtractFileExt(s), '.hpp') = 0) or
       (CompareText(ExtractFileExt(s), '.hh') = 0) then
      FilterIndex := HFilter
    else if Assigned(fProject) then
    begin
      if fProject.Profiles.useGPP then
        FilterIndex := CppFilter
      else
        FilterIndex := CFilter;
    end
    else
      FilterIndex := CppFilter;

    FileName := s;
    s := ExtractFilePath(s);
    if (s <> '') or not Assigned(fProject) then
      InitialDir := s
    else
      InitialDir := fProject.Directory;

    if Execute then
    begin
      s := FileName;
      if FileExists(s) and (MessageDlg(Lang[ID_MSG_FILEEXISTS], mtWarning, [mbYes, mbNo], 0) = mrNo) then
        Exit;

      e.FileName := s;

      try
        if devEditor.AppendNewline then
          with e.Text do
            if Lines.Count > 0 then
              if Lines[Lines.Count -1] <> '' then
                Lines.Add('');
        e.Text.Lines.SaveToFile(s);
        e.Modified := False;
        e.New := False;
      except
{$IFNDEF PRIVATE_BUILD}
        MessageDlg(Lang[ID_ERR_SAVEFILE] + ' "' + s + '"', mtError, [mbOk], 0);
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
        CppParser1.GetSourcePair(ExtractFileName(e.FileName), ccFile, hfile);
        CppParser1.AddFileToScan(e.FileName); //new cc
        CppParser1.ParseList;
        ClassBrowser1.CurrentFile := e.FileName;
        CppParser1.ReParseFile(e.FileName, true); //new cc

        //if the source is in the cache and the header file is not in the cache
        //then we need to reparse the Cpp file to make sure the intialially
        //parsed cpp file is reset
        if GetFileTyp(e.FileName) = utHead then
        begin 
          CppParser1.GetSourcePair(ExtractFileName(e.FileName), ccFile, hfile);
          if Trim(ccFile) <> '' then
          begin
            idx := -1;
            for I := CppParser1.ScannedFiles.Count - 1 downto 0 do    // Iterate
              if AnsiSameText(ExtractFileName(ccFile), ExtractFileName(CppParser1.ScannedFiles[i])) then
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

function TMainForm.SaveFileInternal(e: TEditor; bParseFile: Boolean): Boolean;
var
  idx,index,I: Integer;
  ccFile,hFile:String;
begin
  Result := False;
  if FileExists(e.FileName) and (FileGetAttr(e.FileName) and faReadOnly <> 0) then begin
    // file is read-only
    if MessageDlg(Format(Lang[ID_MSG_FILEISREADONLY], [e.FileName]),mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;
    if FileSetAttr(e.FileName, FileGetAttr(e.FileName) - faReadOnly) <> 0 then begin
      MessageDlg(Format(Lang[ID_MSG_FILEREADONLYERROR], [e.FileName]), mtError, [mbOk], 0);
      Exit;
    end;
  end;

{$IFDEF WX_BUILD}
  //Just Generate XPM's while saving the file
  if e.isForm then
    GenerateXPM(e.GetDesigner, e.FileName);
{$ENDIF}

  if (not e.new) and e.Modified then
  begin // not new but in project (relative path in e.filename)
    if Assigned(fProject) and (e.InProject) then
    begin
      try
        idx := fProject.GetUnitFromEditor(e);
        if idx = -1 then
          MessageDlg(Format(Lang[ID_ERR_SAVEFILE], [e.FileName]), mtError, [mbOk], Handle)
        else
          fProject.units[idx].Save;
      except
{$IFNDEF PRIVATE_BUILD}
         MessageDlg(Format(Lang[ID_ERR_SAVEFILE], [e.FileName]), mtError, [mbOk], Handle);
         Exit;
{$ELSE}
         on Ex: Exception do
         begin
           MessageDlg(Format(Lang[ID_ERR_SAVEFILE] + ' (%s)', [e.FileName, Ex.Message]),
                      mtError, [mbOk], Handle);
           Exit;
         end;
{$ENDIF}
      end;

      try
        if (idx <> -1) and ClassBrowser1.Enabled and bParseFile then
        begin
          CppParser1.ReParseFile(fProject.units[idx].FileName, True);
          if e.TabSheet = PageControl.ActivePage then
            ClassBrowser1.CurrentFile := fProject.units[idx].FileName;
          if GetFileTyp(e.FileName) = utHead then
          begin
            CppParser1.GetSourcePair(ExtractFileName(e.FileName), ccFile, hfile);
            if trim(ccFile) <> '' then
            begin
              index := -1;
              for I := CppParser1.ScannedFiles.Count - 1 downto 0 do    // Iterate
              begin
                if AnsiSameText(ExtractFileName(ccFile), ExtractFileName(CppParser1.ScannedFiles[i])) then
                begin
                  ccFile := CppParser1.ScannedFiles[i];
                  index := i;
                  Break;
                end;
              end;    // for

              if index <> -1 then
                CppParser1.ReParseFile(ccFile, true); //new cc
            end;
          end;
        end;
        Result := True;
      except
        MessageDlg(Format('Error reparsing file %s', [e.FileName]), mtError, [mbOk], Handle);
      end;
    end
    else // stand alone file (should have fullpath in e.filename)
    try
      //Disable the file watch for this entry
      idx := devFileMonitor.Files.IndexOf(e.FileName);
      if idx <> -1 then
      begin
        devFileMonitor.Files.Delete(idx);
        devFileMonitor.Refresh(False);
      end;

      if devEditor.AppendNewline then
        with e.Text do
          if Lines.Count > 0 then
            if Lines[Lines.Count -1] <> '' then
              Lines.Add('');
      e.Text.Lines.SaveToFile(e.FileName);
      e.Modified := false;

      //Re-enable the file watch
      devFileMonitor.Files.Add(e.FileName);
      devFileMonitor.Refresh(False);

      if ClassBrowser1.Enabled and bParseFile then
      begin
        CppParser1.ReParseFile(e.FileName, False); //new cc
        if e.TabSheet = PageControl.ActivePage then
          ClassBrowser1.CurrentFile := e.FileName;

        if GetFileTyp(e.FileName) = utHead then
        begin
          CppParser1.GetSourcePair(ExtractFileName(e.FileName), ccFile, hfile);
          if trim(ccFile) <> '' then
          begin
            index := -1;
            for I := CppParser1.ScannedFiles.Count - 1 downto 0 do    // Iterate
            begin
              if AnsiSameText(ExtractFileName(ccFile),ExtractFileName(CppParser1.ScannedFiles[i])) then
              begin
                ccFile := CppParser1.ScannedFiles[i];
                index:=i;
                break;
              end;
            end;    // for

            if index <> -1 then
              CppParser1.ReParseFile(ccFile, true); //new cc
          end;
        end;
      end;
      Result := True;
    except
      MessageDlg(Format(Lang[ID_ERR_SAVEFILE], [e.FileName]), mtError, [mbOk], Handle);
    end
  end
  else if e.New then
    Result := SaveFileAs(e);
end;

function TMainForm.SaveFile(e: TEditor): Boolean;
{$IFDEF WX_BUILD}
var
    EditorFilename, hFile,cppFile:String;
    eX:TEditor;
    bHModified,bCppModified:Boolean;
{$ENDIF}
begin
    Result:=false;
    bHModified:=false;
    bCppModified:=false;

    if not assigned(e) then
        exit;

//Bug fix for 1123460 : Save the files first and the do a re-parse.
//If you dont save all the files first then cpp functions and header functions of save class 
//will be added in the class browser and duplicates will be there.
//Some times the functions will be not associated with the class and 
//there by will not be shown in the function assignment drop down box of the events.

{$IFDEF WX_BUILD}
    EditorFilename:=e.FileName;
    if FileExists(ChangeFileExt(EditorFilename,WXFORM_EXT)) then
    begin
        if isFileOpenedinEditor(ChangeFileExt(EditorFilename, WXFORM_EXT)) then
        begin
            eX:=self.GetEditorFromFileName(ChangeFileExt(EditorFilename, WXFORM_EXT));
            if assigned(eX) then
            begin
                if eX.Modified then
                    Result := SaveFileInternal(eX,false);
                eX.GetDesigner.CreateNewXPMs(eX.FileName);
            end;
        end;

        // XRC
        if ELDesigner1.GenerateXRC and isFileOpenedinEditor(ChangeFileExt(EditorFilename, XRC_EXT)) then
        begin
            eX:=self.GetEditorFromFileName(ChangeFileExt(EditorFilename, XRC_EXT));
            if assigned(eX) then
            begin
                if eX.Modified then
                    Result := SaveFileInternal(eX,false);
            end;
        end;

        if isFileOpenedinEditor(ChangeFileExt(EditorFilename, H_EXT)) then
        begin
            eX:=self.GetEditorFromFileName(ChangeFileExt(EditorFilename, H_EXT));
            if assigned(eX) then
            begin
                if eX.Modified then
                begin
                    bHModified:=true;
                    Result := SaveFileInternal(eX,false);
                    hFile := eX.FileName;
                end;
            end;
        end;

        if isFileOpenedinEditor(ChangeFileExt(EditorFilename, CPP_EXT)) then
        begin
            eX:=self.GetEditorFromFileName(ChangeFileExt(EditorFilename, CPP_EXT));
            if assigned(eX) then
            begin
                if eX.Modified then
                begin
                    bCppModified:=true;
                    Result := SaveFileInternal(eX,false);
                    cppFile := eX.FileName;
                end;
            end;
        end;

        if (bHModified =true ) then
        begin
            if ClassBrowser1.Enabled then
                CppParser1.ReParseFile(hFile,true);
        end;

        if (bCppModified =true ) then
        begin
            if ClassBrowser1.Enabled then
                CppParser1.ReParseFile(cppFile,true);
        end;
    end
    else
   {$ENDIF}
        Result := SaveFileInternal(e);

end;


function TMainForm.AskBeforeClose(e: TEditor; Rem: boolean;var Saved:Boolean): boolean;
var
  s: string;
begin
  result := TRUE;
  if not e.Modified then exit;

  if e.FileName = '' then
    s := e.TabSheet.Caption
  else
    s := e.FileName;

  Saved:=false;
  case MessageDlg(format(Lang[ID_MSG_ASKSAVECLOSE], [s]),
    mtConfirmation, mbYesNoCancel, 0) of
    mrYes:
      begin
        Result := SaveFile(e);
        Saved:=true;
      end;
    mrNo:
      begin
        result := TRUE;
        if Rem and assigned(fProject) and e.New and (not e.IsRes) and (e.InProject) then
          fProject.Remove(fProject.GetUnitFromString(s), false);
      end;
    mrCancel: result := FALSE;
  end;
end;

function TMainForm.CloseEditor(index: integer; Rem: boolean): Boolean;
var
  e, cppEditor, hppEditor, wxEditor, wxXRCEditor: TEditor;
  EditorFilename: String;
  Saved: Boolean;

  procedure CloseEditorInternal(eX: TEditor);
  begin
    if not eX.InProject then
    begin
      dmMain.AddtoHistory(eX.FileName);
      eX.Close;
    end
    else
    begin
      if eX.IsRes or (not Assigned(fProject)) then
        eX.Close
      else if assigned(fProject) then
        fProject.CloseUnit(fProject.Units.Indexof(eX));
    end;
  end;

begin
  Result := False;
  e := GetEditor(index);
  if not assigned(e) then exit;
  if not AskBeforeClose(e, Rem, Saved) then Exit;
  Result := True;

{$IFDEF WX_BUILD}
  EditorFilename := e.FileName;
  if FileExists(ChangeFileExt(e.FileName, WXFORM_EXT)) then begin
    cppEditor := GetEditorFromFileName(ChangeFileExt(EditorFilename, CPP_EXT), true);
    if assigned(cppEditor) then
    begin
      if Saved then
      begin
        cppEditor.Modified := true;
        SaveFile(cppEditor);
      end
      else
        cppEditor.Modified := false;
      CloseEditorInternal(cppEditor);
    end;

    hppEditor := GetEditorFromFileName(ChangeFileExt(EditorFilename, H_EXT), true);
    if assigned(hppEditor) then
    begin
      if Saved then
      begin
        hppEditor.Modified := true;
        SaveFile(hppEditor);
      end
      else
        hppEditor.Modified:=false;
      CloseEditorInternal(hppEditor);
    end;

    wxEditor := GetEditorFromFileName(ChangeFileExt(EditorFilename, WXFORM_EXT), true);
    if assigned(wxEditor) then
    begin
      if Saved then
      begin
        wxEditor.Modified := true;
        SaveFile(wxEditor);
        end
      else
        wxEditor.Modified := false;
      CloseEditorInternal(wxEditor);
    end;

    wxXRCEditor := GetEditorFromFileName(ChangeFileExt(EditorFilename, XRC_EXT), true);
    if assigned(wxXRCEditor) then
    begin
      if Saved then
      begin
        wxXRCEditor.Modified := true;
        SaveFile(wxXRCEditor);
      end
      else
        wxXRCEditor.Modified:=false;
      CloseEditorInternal(wxXRCEditor);
    end;
  end
  else
{$ENDIF}
    CloseEditorInternal(e);

  PageControl.OnChange(PageControl);
  if (ClassBrowser1.ShowFilter = sfCurrent) or not Assigned(fProject) then
    ClassBrowser1.Clear;
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
    pt := tbSpecials.ClientToScreen(point(Togglebtn.Left, Togglebtn.Top + togglebtn.Height));
    TrackPopupMenu(ToggleBookmarksItem.Handle, TPM_LEFTALIGN or TPM_LEFTBUTTON,
      pt.x, pt.y, 0, Self.Handle, nil);
  end;
end;

procedure TMainForm.GotoBtnClick(Sender: TObject);
var
  pt: TPoint;
begin
  if PageControl.ActivePageIndex > -1 then
  begin
    pt := tbSpecials.ClientToScreen(point(Gotobtn.Left, Gotobtn.Top + Gotobtn.Height));
    TrackPopupMenu(GotoBookmarksItem.Handle, TPM_LEFTALIGN or TPM_LEFTBUTTON,
      pt.x, pt.y, 0, Self.Handle, nil);
  end;
end;

procedure TMainForm.NewAllBtnClick(Sender: TObject);
var
  pt: TPoint;
begin
  pt := tbSpecials.ClientToScreen(point(NewAllBtn.Left, NewAllbtn.Top + NewAllbtn.Height));
  TrackPopupMenu(mnuNew.Handle, TPM_LEFTALIGN or TPM_LEFTBUTTON,
    pt.X, pt.y, 0, Self.Handle, nil);
end;

procedure TMainForm.MRUClick(Sender: TObject);
var
  s: string;
begin
  s := dmMain.MRU[(Sender as TMenuItem).Tag];
  if GetFileTyp(s) = utPrj then
    OpenProject(s)
  else
  begin
{$IFDEF WX_BUILD}
    if iswxForm(s) then
    begin
      OpenFile(ChangeFileExt(s, H_EXT), True);
      OpenFile(ChangeFileExt(s, CPP_EXT), true);
    end;
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
    e.InsertString(dmMain.CodeInserts[(Sender as TMenuItem).Tag].Line, TRUE);
end;

procedure TMainForm.SurroundString(e: TEditor;strStart,strEnd:String);
var
  I: Integer;
    startXY,endXY:TBufferCoord;
    strLstToPaste:TStringList;
begin
    if assigned(e) = false then
        exit;

    strLstToPaste:=TStringList.Create;
    try
        strLstToPaste.Add(strStart);
        if e.Text.SelAvail then
        begin
            startXY:=e.Text.BlockBegin;
            endXY:=e.Text.BlockEnd;

            for I := startXY.Line-1 to endXY.Line-1 do    // Iterate
            begin
                strLstToPaste.Add(e.Text.Lines[i])
            end;

            for I := endXY.Line-1 downto startXY.Line-1 do    // Iterate
            begin
                //e.Text.insert
                e.Text.Lines.Delete(I);
            end;

                // for
        end
        else
        begin
            startXY.Line:=e.Text.CaretY;
        end;
        strLstToPaste.Add(strEnd);

        for I := strLstToPaste.Count-1 downto 0 do    // Iterate
        begin
            e.Text.Lines.Insert(startXY.Line -1,strLstToPaste[i]);
            e.Modified:=true;
        end;

    finally
        strLstToPaste.Destroy;
    end;

end;

procedure TMainForm.CppCommentString(e: TEditor);
var
  I: Integer;
    startXY,endXY:TBufferCoord;
   begin
    if assigned(e) = false then
        exit;
    if e.Text.SelAvail then
    begin
        startXY:=e.Text.BlockBegin;
        endXY:=e.Text.BlockEnd;
        for I := startXY.Line-1 to endXY.Line-1 do    // Iterate
        begin
            e.Text.Lines[i]:='// '+e.Text.Lines[i] ;
            e.Modified:=true;
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
      SurroundString(e,'{','}');

    INT_TRY_CATCH:
      SurroundString(e,'try{','}catch() {}');

    INT_C_COMMENT:
      SurroundString(e,'/*','*/');

    INT_FOR:
      SurroundString(e,'for(){','}');

    INT_FOR_I:
      SurroundString(e,'for(int i=;i<;i++){','}');

    INT_WHILE:
      SurroundString(e,'while(){','}');

    INT_DO_WHILE:
      SurroundString(e,'do{','}while();');

    INT_IF:
      SurroundString(e,'if(){','}');

    INT_IF_ELSE:
      SurroundString(e,'if(){','} else { }');

    INT_SWITCH:
      SurroundString(e,'switch() { case 0:','}');

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
    ExecuteFile(ParseParams(Exec), ParseParams(Params), ParseParams(WorkDir), SW_SHOW);
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
    if fProject.FileName <> '' then begin
      fCompiler.Project := fProject;
      fCompiler.RunParams := fProject.CmdLineArgs;
      fCompiler.Target := ctProject;

      dmMain.RemoveFromHistory(s);
      // if project manager isn't open then open it
      if not ShowProjectInspItem.Checked then
        ShowProjectInspItem.OnClick(nil);

      CheckForDLLProfiling;
      UpdateAppTitle;
      ScanActiveProject;
    end
    else begin
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

  if s[length(s)] = '.' then // correct filename if the user gives an alone dot to force the no extension
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

    if Assigned(e) then begin
      // <SOURCENAME>
      s := StringReplace(s, cCurSrc, e.FileName, [rfReplaceAll]);
      // <SOURCEPATH>
      if e.FileName = '' then
        s := StringReplace(s, cSrcPath, devDirs.Default, [rfReplaceAll])
      else
        s := StringReplace(s, cSrcPath, ExtractFilePath(e.FileName), [rfReplaceAll]);
    end;

    // <SOURCESPCLIST>
    s := StringReplace(s, cSrcList, fProject.ListUnitStr(' '), [rfReplaceAll]);
  end
  else
   if assigned(e) then
   begin
    // <EXENAME>
    s := StringReplace(s, cEXEName, ChangeFileExt(e.FileName, EXE_EXT),[rfReplaceAll]);

    // <PROJECTNAME>
    s := StringReplace(s, cPrjName, e.FileName, [rfReplaceAll]);

    // <PRJECTFILE>
    s := StringReplace(s, cPrjFile, e.FileName, [rfReplaceAll]);

    // <PROJECTPATH>
    s := StringReplace(s, cPrjPath, ExtractFilePath(e.FileName),[rfReplaceAll]);

    // <SOURCENAME>
    s := StringReplace(s, cCurSrc, e.FileName, [rfReplaceAll]);

    // <SOURCEPATH>
    // if fActiveEditor is "untitled"/new file return users default directory
    if e.FileName = '' then
      s := StringReplace(s, cSrcPath, devDirs.Default, [rfReplaceAll])
    else
      s := StringReplace(s, cSrcPath, ExtractFilePath(e.FileName),[rfReplaceAll]);

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
  if idx >= fHelpFiles.Count then exit;
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
    ResourceOutput.Items.Add('Line ' + _Line + ' in file ' + _Unit + ' : ' +_Message)
  else
    ResourceOutput.Items.Add(_Message);
end;

procedure TMainForm.CompSuccessProc(const messages: integer);
var
  F: TSearchRec;
  HasSize: boolean;
  I: integer;
begin
  if fCompiler.ErrorCount = 0 then begin
    TotalErrors.Text := '0';
    HasSize := False;
    if Assigned(fProject) then begin
      FindFirst(fProject.Executable, faAnyFile, F);
      HasSize := FileExists(fProject.Executable);
    end
    else if PageControl.PageCount > 0 then begin
      FindFirst(ChangeFileExt(GetEditor.FileName, EXE_EXT), faAnyFile, F);
      HasSize := FileExists(ChangeFileExt(GetEditor.FileName, EXE_EXT));
    end;
    if HasSize then begin
      SizeFile.Text := IntToStr(F.Size) + ' ' + Lang.Strings[ID_BYTES];
      if F.Size > 1024 then
        SizeFile.Text := SizeFile.Text + ' (' +
          IntToStr(F.Size div 1024) + ' KB)';
    end
    else
      SizeFile.Text := '0';
  end
  else begin
    // errors exist; goto first one...
    for I := 0 to CompilerOutput.Items.Count - 1 do
      if StrToIntDef(CompilerOutput.Items[I].Caption, -1) <> -1 then begin
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
    if S[I] < #32 then S[I] := #32;

  AddFindOutputItem(inttostr(SR.pt.X), inttostr(SR.pt.y), SR.InFile, S);
end;

procedure TMainForm.ProjectViewContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  pt: TPoint;
  Node: TTreeNode;
begin
  if not assigned(fProject) or devData.FullScreen then exit;
  pt := ProjectView.ClientToScreen(MousePos);
  Node := ProjectView.GetNodeAt(MousePos.X, MousePos.Y);
  if not assigned(Node) then exit;
  ProjectView.Selected := Node;
  if Node.Level = 0 then
    ProjectPopup.Popup(pt.x, pt.Y)
  else begin
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
  i : integer;
  pt: TPoint;
  e: TEditor;
  EditorFilename:String;
  AlreadyActivated:boolean;
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
{$IFDEF WX_BUILD}
      //This will allow DevC++ to open custom program
      //as assigned by the user like VC++
      if OpenWithAssignedProgram(fProject.Units[i].FileName) = true then
        Exit;
{$ENDIF}
      FileIsOpen(fProject.Units[i].FileName, TRUE);
{$IFDEF WX_BUILD}

      if isFileOpenedinEditor(fProject.Units[i].FileName) then
        e :=GetEditorFromFileName(fProject.Units[i].FileName)
      else
{$ENDIF}
        e := fProject.OpenUnit(i);
      if assigned(e) then
      begin
{$IFDEF WX_BUILD}
        EditorFilename := e.FileName;
        if FileExists(ChangeFileExt(EditorFilename,WXFORM_EXT)) then
        begin
          if FileExists(ChangeFileExt(EditorFilename, WXFORM_EXT)) and (not isFileOpenedinEditor(ChangeFileExt(EditorFilename, WXFORM_EXT))) then
            if fProject.Units.Indexof(ChangeFileExt(EditorFilename, WXFORM_EXT)) <> -1 then
              fProject.OpenUnit(fProject.Units.Indexof(ChangeFileExt(EditorFilename, WXFORM_EXT)))
            else
              MainForm.OpenFile(ChangeFileExt(EditorFilename, WXFORM_EXT), true);

          if (ELDesigner1.GenerateXRC) and FileExists(ChangeFileExt(EditorFilename, XRC_EXT))
          and (not isFileOpenedinEditor(ChangeFileExt(EditorFilename, XRC_EXT))) then
            if fProject.Units.Indexof(ChangeFileExt(EditorFilename, XRC_EXT)) <> -1 then
              fProject.OpenUnit(fProject.Units.Indexof(ChangeFileExt(EditorFilename, XRC_EXT)))
            else
              MainForm.OpenFile(ChangeFileExt(EditorFilename, XRC_EXT), true);

          if FileExists(ChangeFileExt(EditorFilename, H_EXT)) and (not isFileOpenedinEditor(ChangeFileExt(EditorFilename, H_EXT))) then
            if fProject.Units.Indexof(ChangeFileExt(EditorFilename, H_EXT)) <> -1 then
              fProject.OpenUnit(fProject.Units.Indexof(ChangeFileExt(EditorFilename, H_EXT)))
            else
              MainForm.OpenFile(ChangeFileExt(EditorFilename, H_EXT), true);

          if FileExists(ChangeFileExt(EditorFilename, CPP_EXT)) and (not isFileOpenedinEditor(ChangeFileExt(EditorFilename, CPP_EXT))) then
            if fProject.Units.Indexof(ChangeFileExt(EditorFilename, CPP_EXT)) <> -1 then
              fProject.OpenUnit(fProject.Units.Indexof(ChangeFileExt(EditorFilename, CPP_EXT)))
            else
              MainForm.OpenFile(ChangeFileExt(EditorFilename, CPP_EXT), true);

          //Reactivate the editor;
          if FileExists(EditorFilename) then
          begin
            if not isFileOpenedinEditor(EditorFilename) then
                MainForm.OpenFile(EditorFilename, true)
            else
            begin
                GetEditorFromFileName(EditorFilename).Activate;
                AlreadyActivated := true;
            end;
          end;
        end;
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
  if devData.DblFiles then exit;
  if not Assigned(ProjectView.Selected) then Exit;
  if ProjectView.Selected.Data <> Pointer(-1) then
    OpenUnit
  else begin
    e := GetEditor;
    if Assigned(e) then
      e.Activate;
  end;
end;

procedure TMainForm.ProjectViewDblClick(Sender: TObject);
begin
  if not devData.dblFiles then exit;
  OpenUnit;
end;

procedure TMainForm.HelpBtnClick(Sender: TObject);
var
  pt: TPoint;
begin
  pt := tbOptions.ClientToScreen(point(HelpBtn.Left, Helpbtn.Top + Helpbtn.Height));
  HelpPop.Popup(pt.X, pt.Y);
end;

procedure TMainForm.InsertBtnClick(Sender: TObject);
var
  pt: TPoint;
begin
  if PageControl.ActivePageIndex > -1 then
  begin
    pt := tbSpecials.ClientToScreen(point(Insertbtn.Left, Insertbtn.Top + Insertbtn.Height));
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
    case MessageDlg(Lang[ID_MSG_NEWFILE], mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
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
  NewEditor.init(FALSE, Lang[ID_UNTITLED] + inttostr(dmMain.GetNum), '', FALSE);
  NewEditor.InsertDefaultText;
  NewEditor.Activate;
end;

procedure TMainForm.actNewProjectExecute(Sender: TObject);
var
  s: string;
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
        if MessageDlg(format(Lang[ID_MSG_CLOSECREATEPROJECT], [s]), mtConfirmation,
          [mbYes, mbNo], 0) = mrYes then
          actCloseProject.Execute
        else begin
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
          end else
            Exit;
        end;
      end;

      fProject := TProject.Create(s, edProjectName.Text);
      if not fProject.AssignTemplate(s, GetTemplate) then
      begin
        fProject.Free;
        MessageBox(Self.Handle, PChar(Lang[ID_ERR_TEMPLATE]),PChar(Lang[ID_ERROR]), MB_OK or MB_ICONERROR);
        Exit;
      end;
      fCompiler.Project := fProject;

{$IFDEF WX_BUILD}
      if strContains('wxWidgets Frame', GetTemplate.Name) then
        NewWxProjectCode(dtWxFrame)
      else if strContains('wxWidgets Dialog', GetTemplate.Name) then
        NewWxProjectCode(dtWxDialog);
{$ENDIF}

      devCompiler.CompilerSet:=fProject.CurrentProfile.CompilerSet;
      devCompilerSet.LoadSet(fProject.CurrentProfile.CompilerSet);
      devCompilerSet.AssignToCompiler;
      devCompiler.OptionStr:=fProject.CurrentProfile.CompilerOptions;

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

  fname:=Lang[ID_UNTITLED] +inttostr(dmMain.GetNum) + '.rc';
  NewEditor := TEditor.Create;
  NewEditor.init(InProject, fname, '', FALSE, TRUE);
  NewEditor.Activate;

  if InProject and Assigned(fProject) then begin
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
  with NewTemplateForm do begin
    TempProject := fProject;
    ShowModal;
  end;
end;

procedure TMainForm.actOpenExecute(Sender: TObject);
var
  idx,
    prj: integer;
  flt: string;
begin
  prj := -1;
  if not BuildFilter(flt, ftOpen) then
    if not BuildFilter(flt, [FLT_PROJECTS, FLT_HEADS, FLT_CS, FLT_CPPS, FLT_RES{$IFDEF WX_BUILD},FLT_WXFORMS,FLT_XRC{$ENDIF}]) then
    begin
        flt := FLT_ALLFILES;
        if assigned(fProject) then
            if (fProject.Name = '') or (fProject.FileName ='') then
                flt := FLT_PROJECTS;
    end;
  
  with dmMain.OpenDialog do
  begin
    Filter := flt;
    Title := Lang[ID_NV_OPENFILE];
    if Execute then
      if Files.Count > 0 then // multi-files?
      begin
        for idx := 0 to pred(Files.Count) do // find .dev file
          if AnsiCompareText(ExtractFileExt(Files[idx]), DEV_EXT) = 0 then
          begin
            prj := idx;
            break;
          end;
        if prj = -1 then // not found
          for idx := 0 to pred(Files.Count) do
          begin
            {$IFDEF WX_BUILD}
            if iswxForm(Files[idx]) then
            begin
              OpenFile(ChangeFileExt(Files[idx], H_EXT), True);
              OpenFile(ChangeFileExt(Files[idx], CPP_EXT), true);
            end;
            {$ENDIF}
            OpenFile(Files[idx]); // open all files
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
  if Assigned(fProject) then begin
    fProject.Save;
    UpdateAppTitle;
    if CppParser1.Statements.Count = 0 then // only scan entire project if it has not already been scanned...
      ScanActiveProject;
  end;

  for idx := 0 to pred(PageControl.PageCount) do begin
    e := GetEditor(idx);
    if e.Modified then
    begin
      SaveFile(GetEditor(idx));
      if ClassBrowser1.Enabled and (GetFileTyp(e.FileName) in [utSrc, utHead]) then
        fileLstToParse.Add(e.FileName);
    end;
  end;

  if ClassBrowser1.Enabled then
    for idx := 0 to fileLstToParse.Count-1 do
      CppParser1.ReParseFile(fileLstToParse[idx], True);
  fileLstToParse.Destroy;
end;

procedure TMainForm.actCloseExecute(Sender: TObject);
begin
  CloseEditor(PageControl.ActivePageIndex, True);
end;

procedure TMainForm.actCloseAllExecute(Sender: TObject);
var
  idx: integer;
begin
  for idx := pred(PageControl.PageCount) downto 0 do
    if not CloseEditor(0, True) then
      Break;

  // if no project is open, clear the parsed info...
  if not Assigned(fProject) and (PageControl.PageCount = 0) then begin
    CppParser1.Reset;
    ClassBrowser1.Clear;
  end;
end;

procedure TMainForm.actCloseProjectExecute(Sender: TObject);
var
  s: string;
begin
  actStopExecute.Execute;

  // save project layout anyway ;)
  fProject.CmdLineArgs := fCompiler.RunParams;
  fProject.SaveLayout;

{$IFNDEF PRIVATE_BUILD}
  //Added for wx problems : Just close all the file
  //tabs before closing the project
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
      mrYes: fProject.Save;
      mrNo: fProject.Modified := FALSE;
      mrCancel: exit;
    end;
  end;

  fCompiler.Project := nil;
  dmMain.AddtoHistory(fProject.FileName);

  try
    FreeandNil(fProject);
  except
    fProject:=nil;
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
      if ShowModal = mrOk then begin
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
begin
  e := GetEditor;
  if assigned(e) then
  begin
    if e.isForm then
      if (JvInspProperties.Focused) or (JvInspEvents.Focused) then  // If property inspector is focused, then cut text
        actWxPropertyInspectorCut.Execute
      else   // Otherwise form component is selected so cut whole component (control and code)
        actDesignerCut.Execute
    else
      e.Text.CutToClipboard
  end;
end;

procedure TMainForm.actCopyExecute(Sender: TObject);
var
  e: TEditor;
begin
  e := GetEditor;
  if assigned(e) then
  begin
    if e.isForm then
      if (JvInspProperties.Focused) or (JvInspEvents.Focused) then  // If property inspector is focused, then copy text
        actWxPropertyInspectorCopy.Execute
      else   // Otherwise form component is selected so copy whole component (control and code)
        actDesignerCopy.Execute
    else
      e.Text.CopyToClipboard;
  end;
end;

procedure TMainForm.actPasteExecute(Sender: TObject);
var
  e: TEditor;
begin
  e := GetEditor;
  if assigned(e) then
  begin
    if e.isForm then
      if (JvInspProperties.Focused) or (JvInspEvents.Focused) then  // If property inspector is focused, then paste text
        actWxPropertyInspectorPaste.Execute
      else   // Otherwise form component is selected so paste whole component (control and code)
        actDesignerPaste.Execute
    else if e.Text.Focused then
      e.Text.PasteFromClipboard
    else
      SendMessage(GetFocus, WM_PASTE, 0, 0);
   end
   else
      SendMessage(GetFocus, WM_PASTE, 0, 0);
end;

procedure TMainForm.actSelectAllExecute(Sender: TObject);
var
  e: TEditor;
begin
  if LogOutput.Focused then
    LogOutput.SelectAll
  else if DebugOutput.Focused then
    DebugOutput.SelectAll
  else begin
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
    BorderStyle := bsNone;
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
  end
  else
  begin
    Left := OldLeft;
    Top := OldTop;
    Width := OldWidth;
    Height := OldHeight;
    // enable the top-level menus in MainMenu
    // before shown on screen to avoid flickering
    for I := 0 to MainMenu.Items.Count - 1 do
      MainMenu.Items[I].Visible := True;

    SetWindowPlacement(Self.Handle, @devData.WindowPlacement);
    BorderStyle := bsSizeable;
    FullScreenModeItem.Caption := Lang[ID_ITEM_FULLSCRMODE];
    Controlbar1.Visible := TRUE;

    pnlFull.Visible := FALSE;
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
begin
  with TCompForm.Create(Self) do
  try
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
      if GetEditor <> nil then begin
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
  if not assigned(fProject) then exit;

{$IFDEF WIN32}
  while ProjectView.SelectionCount > 0 do begin
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
  if not assigned(fProject) then exit;
  if not assigned(ProjectView.Selected) or (ProjectView.Selected.Level < 1) then
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
    MessageDlg(format(Lang[ID_ERR_RENAMEFILE], [OldName]), mtError, [mbok], 0);
  end;
end;

procedure TMainForm.actUnitOpenExecute(Sender: TObject);
var
  idx, idx2: integer;
begin
  if not assigned(fProject) then exit;
  if not assigned(ProjectView.Selected) or
    (ProjectView.Selected.Level < 1) then exit;
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
begin
  WebUpdateForm.Show;
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
    with fProject.OpenUnit(idx) do begin
      Activate;
      Modified := True;
    end;
end;

procedure TMainForm.actProjectAddExecute(Sender: TObject);
var
  flt: string;
  idx: integer;
  FolderNode: TTreeNode;
begin
  if not assigned(fProject) then exit;

  if not BuildFilter(flt, [FLT_CS, FLT_CPPS, FLT_RES, FLT_HEADS {$IFDEF WX_BUILD},FLT_WXFORMS,FLT_XRC{$ENDIF}]) then
    BuildFilter(flt, ftAll);

  with dmMain.OpenDialog do
  begin
    Title := Lang[ID_NV_OPENADD];
    Filter := flt;
    if Execute then
    begin
      if Assigned(ProjectView.Selected) and (ProjectView.Selected.Data = Pointer(-1)) then
        FolderNode := ProjectView.Selected
      else
        FolderNode := fProject.Node;
      try
        for idx := 0 to pred(Files.Count) do
        begin
          fProject.AddUnit(Files[idx], FolderNode, false); // add under folder
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
begin
  if assigned(fProject) then
  begin
    {$IFDEF WX_BUILD}
    if iswxForm(fProject.FileName) then
    begin
      OpenFile(ChangeFileExt(fProject.FileName, CPP_EXT), True);
      OpenFile(ChangeFileExt(fProject.FileName, H_EXT), true);
    end;
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
  if assigned(e) then e.Search(TRUE);
end;

procedure TMainForm.actFindNextExecute(Sender: TObject);
var
  e: TEditor;
begin
  e := GetEditor;
  if Assigned(e) then e.SearchAgain;
end;

procedure TMainForm.actGotoExecute(Sender: TObject);
var
  e: TEditor;
begin
  e := GetEditor;
  if Assigned(e) then e.GotoLine;
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
    if not SaveFile(e) then
      Exit;
    fCompiler.SourceFile := e.FileName;
  end
  else if fCompiler.Target = ctProject then
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
    else if not FileExists(fProject.Executable) then
      MessageDlg(Lang[ID_ERR_PROJECTNOTCOMPILED], mtWarning, [mbOK], Handle)
    else if fProject.CurrentProfile.typ = dptDyn then
    begin
      if fProject.CurrentProfile.HostApplication = '' then
        MessageDlg(Lang[ID_ERR_HOSTMISSING], mtWarning, [mbOK], Handle)
      else if not FileExists(fProject.CurrentProfile.HostApplication) then
        MessageDlg(Lang[ID_ERR_HOSTNOTEXIST], mtWarning, [mbOK], Handle)
      else
      begin
        if devData.MinOnRun then
          Application.Minimize;
        devExecutor.ExecuteAndWatch(fProject.CurrentProfile.HostApplication, fProject.CmdLineArgs,
                                    ExtractFileDir(fProject.CurrentProfile.HostApplication), True, INFINITE, OnCompileTerminated);
      end;
    end
    else
    begin
      if devData.MinOnRun then
        Application.Minimize;
      devExecutor.ExecuteAndWatch(fProject.Executable, fProject.CmdLineArgs,
                                  ExtractFileDir(fProject.Executable), True, INFINITE, OnCompileTerminated);
    end;
  end
  else if assigned(e) then
  begin
    if not FileExists(ChangeFileExt(e.FileName, EXE_EXT)) then
      MessageDlg(Lang[ID_ERR_SRCNOTCOMPILED], mtWarning, [mbOK], Handle)
    else
    begin
      if devData.MinOnRun then
        Application.Minimize;
      devExecutor.ExecuteAndWatch(ChangeFileExt(e.FileName, EXE_EXT), '',
                                  ExtractFilePath(e.FileName), True, INFINITE, OnCompileTerminated);
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
    fDebugger.DebugTree := DebugTree;
    fDebugger.OnCallStack := OnCallStack;
    fDebugger.OnThreads := OnThreads;
    fDebugger.OnLocals := OnLocals;
  end;
begin
  if devCompiler.CompilerType = ID_COMPILER_MINGW then
  begin
    if not (fDebugger is TGDBDebugger) then
    begin
      if Assigned(fDebugger) then
        fDebugger.Free;
      fDebugger := TGDBDebugger.Create;
      Initialize;
    end;
  end
  else if devCompiler.CompilerType in ID_COMPILER_VC then
  begin
    if not (fDebugger is TCDBDebugger) then
    begin
      if Assigned(fDebugger) then
        fDebugger.Free;
{$WARNINGS OFF 'Instance of TCDBDebugger containing abstract method...'}
      fDebugger := TCDBDebugger.Create;
{$WARNINGS ON}
      Initialize;
    end;
  end;
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
    if not FileExists(fProject.Executable) then begin
      MessageDlg(Lang[ID_ERR_PROJECTNOTCOMPILED], mtWarning, [mbOK], 0);
      Exit;
    end;

    // add to the debugger the project include dirs
    for idx := 0 to fProject.CurrentProfile.Includes.Count - 1 do
      fDebugger.AddIncludeDir(fProject.CurrentProfile.Includes[idx]);

    if fProject.CurrentProfile.typ <> dptDyn then
      fDebugger.Execute(StringReplace(fProject.Executable, '\', '\\', [rfReplaceAll]), fCompiler.RunParams)
    else
    begin
      if fProject.CurrentProfile.HostApplication = '' then begin
        MessageDlg(Lang[ID_ERR_HOSTMISSING], mtWarning, [mbOK], 0);
        exit;
      end
      else if not FileExists(fProject.CurrentProfile.HostApplication) then begin
        MessageDlg(Lang[ID_ERR_HOSTNOTEXIST], mtWarning, [mbOK], 0);
        exit;
      end;
      
      fDebugger.Execute(StringReplace(fProject.CurrentProfile.HostApplication, '\', '\\', [rfReplaceAll]), fCompiler.RunParams);
    end;
    
    fDebugger.RefreshBreakpoints;
  end
  else
  begin
    e := GetEditor;
    if assigned(e) then
    begin
      if not FileExists(ChangeFileExt(e.FileName, EXE_EXT)) then begin
        MessageDlg(Lang[ID_ERR_SRCNOTCOMPILED], mtWarning, [mbOK], 0);
        exit;
      end;
      if e.Modified then // if file is modified
        if not SaveFile(e) then // save it first
          Abort; // if it's not saved, abort
      chdir(ExtractFilePath(e.FileName));

      fDebugger.Execute(StringReplace(ChangeFileExt(ExtractFileName(e.FileName), EXE_EXT), '\', '\\', [rfReplaceAll]), fCompiler.RunParams);
      fDebugger.RefreshBreakpoints;
    end;
  end;

  for idx := 0 to DebugTree.Items.Count - 1 do begin
    idx2 := AnsiPos('=', DebugTree.Items[idx].Text);
    if (idx2 > 0) then
    begin
      s := DebugTree.Items[idx].Text;
      Delete(s, idx2 + 1, length(s) - idx2);
      DebugTree.Items[idx].Text := s + ' (unknown)';
    end;
  end;

  //Then run the debuggee
  fDebugger.Go;
end;

procedure TMainForm.actDebugExecute(Sender: TObject);
var
  UpToDate: Boolean;
begin
  if not fDebugger.Executing then
  begin
    if Assigned(fProject) then
    begin
      //Save all the files then set the UI status
      actSaveAllExecute(Self);
      (Sender as TAction).Tag := 0;
      (Sender as TAction).Enabled := False;
      StatusBar.Panels[3].Text := 'Checking if project needs to be rebuilt...';

      //Run make to see if the project is up to date, the cache the result and restore our state
      fCompiler.Target := ctProject;
      UpToDate := fCompiler.UpToDate;
      (Sender as TAction).Tag := 1;
      StatusBar.Panels[3].Text := '';

      //Ask the user if the project is out of date
      if not UpToDate then
        case MessageBox(Handle, 'The project you are working on is out of date. Do you ' +
                        'want to rebuild the project before debugging?', 'wxDev-C++',
                        MB_ICONQUESTION or MB_YESNOCANCEL) of
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
    doDebugAfterCompile(Sender);
  end
  else if fDebugger.Paused then
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
  (Sender as TAction).Enabled := fDebugger.Executing and not fDebugger.Paused and
    (fDebugger is TCDBDebugger);
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
        DockServer.DockStyle.TabServerOption.TabPosition := tpBottom;
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
    (Sender as TCustomAction).Enabled := not (fProject.CurrentProfile.typ = dptStat) and
      (not devExecutor.Running) and ((not fDebugger.Executing) or
      fDebugger.Paused) and (not fCompiler.Compiling) and ((Sender as TAction).Tag = 1)
  else
    (Sender as TCustomAction).Enabled := (PageControl.PageCount > 0) and
      (not devExecutor.Running) and ((not fDebugger.Executing) or fDebugger.Paused)
      and (not fCompiler.Compiling) and ((Sender as TAction).Tag = 1);
end;

procedure TMainForm.actCompileUpdate(Sender: TObject);
begin
  (Sender as TCustomAction).Enabled := (assigned(fProject) or (PageControl.PageCount > 0)) and
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
    (Sender as TAction).Enabled := Assigned(e) and Assigned(e.Text) and (e.Text.Text <> '');
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
    else if TEdit(PopupComp).Text <> '' then
      Clipboard.AsText := TEdit(PopupComp).Text;
  end
  else if PopupComp is TMemo then
  begin
    if TMemo(PopupComp).SelText <> '' then
      Clipboard.AsText := TMemo(PopupComp).SelText
    else if TMemo(PopupComp).Lines.Text <> '' then
      Clipboard.AsText := TMemo(PopupComp).Lines.Text;
  end
  else if PopupComp is TListView then
  begin
    if Assigned(TListView(PopupComp).Selected) then
      Clipboard.AsText := StringReplace(StringReplace(Trim(TListView(PopupComp).Selected.Caption +
                                                           ' ' + TListView(PopupComp).Selected.SubItems.Text),
                                                      #13#10, ' ', [rfReplaceAll]),
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
  else if PopupComp is TMemo then
    TMemo(PopupComp).Clear
  else if PopupComp is TListView then
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
begin
  SearchCenter.Editor := GetEditor;
  SearchCenter.AssignSearchEngine;

  frmIncremental.SearchAgain.Shortcut := actFindNext.Shortcut;
  pt := ClienttoScreen(point(PageControl.Left, PageControl.Top));
  frmIncremental.Left := pt.x;
  frmIncremental.Top := pt.y;
  frmIncremental.Editor := GetEditor.Text;
  frmIncremental.ShowModal;
end;

procedure TMainForm.CompilerOutputDblClick(Sender: TObject);
var
  Col, Line: integer;
  tFile: string;
  e: TEditor;
  intTmpPos  ,delimPos : integer;
  strCol:string;
begin
  // do nothing if no item selected, or no line/unit specified
  if not assigned(CompilerOutput.Selected) or
    (CompilerOutput.Selected.Caption = '') or
    (CompilerOutput.Selected.SubItems[0] = '') then exit;

  Col := 0;
  Line := StrToIntDef(CompilerOutput.Selected.Caption, -1);
  if Line = -1 then
    Exit;

  tfile := trim(CompilerOutput.Selected.SubItems[0]);
  if fileExists(tfile) = false then
  begin
    if strContains(' from ',tfile) then
    begin
        intTmpPos := pos(' from ',tfile);
        tfile := trim(copy(tfile,0,intTmpPos)) ;
    end;
        if copy(tfile,length(tfile),1) = ',' then
            tfile := trim(copy(tfile,0,length(tfile)-1));
        delimPos := LastDelimiter(':',tfile);
        if delimPos <> 2 then
        begin
            strCol:=copy(tfile,delimPos+1,length(tfile));
            if isNumeric(strCol) then
                Line:=strToInt(strCol);
            tfile := trim(copy(tfile,0,delimPos-1));
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
  if not assigned(FindOutPut.Selected) then exit;
  Col := strtoint(FindOutput.Selected.SubItems[0]);
  Line := strtoint(FindOutput.Selected.Caption);

  // replaced redundant code...
  e := GetEditorFromFileName(FindOutput.Selected.SubItems[1]);

  if assigned(e) then
  begin
    e.Text.CaretXY:= BufferCoord(col, line);
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
{$IFDEF WX_BUILD}
var
   i : Integer;
{$ENDIF}
begin
  //TODO: lowjoel: What on earth is this meant to do?!
  case key of
{$IFDEF WIN32}
    VK_F6:
{$ENDIF}
{$IFDEF LINUX}
    XK_F6:
{$ENDIF}
      if ssCtrl in Shift then
        ShowDebug;
  end;
    
{$IFDEF WX_BUILD}
  if (ssCtrl in Shift) and ELDesigner1.Active and not JvInspProperties.Focused and
     not JvInspEvents.Focused then   // If Designer Form is in focus
  begin
    case key of
      //Move the selected component
      VK_Left :
        for i := 0 to (ELDesigner1.SelectedControls.Count - 1) do
          ELDesigner1.SelectedControls.Items[i].Left := ELDesigner1.SelectedControls.Items[i].Left - 1;
      VK_Right :
        for i := 0 to (ELDesigner1.SelectedControls.Count - 1) do
          ELDesigner1.SelectedControls.Items[i].Left := ELDesigner1.SelectedControls.Items[i].Left + 1;
      VK_Up :
        for i := 0 to (ELDesigner1.SelectedControls.Count - 1) do
          ELDesigner1.SelectedControls.Items[i].Top := ELDesigner1.SelectedControls.Items[i].Top - 1;
      VK_Down :
        for i := 0 to (ELDesigner1.SelectedControls.Count - 1) do
          ELDesigner1.SelectedControls.Items[i].Top := ELDesigner1.SelectedControls.Items[i].Top + 1;
    end;
  ELDesigner1.OnModified(Sender);
 end;
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
  s: string;
  e: TEditor;
begin
  s := '';
  e := GetEditor;
  if Assigned(e) then begin
    if e.Text.SelAvail then
      s := e.Text.SelText
    else begin
      s := e.GetWordAtCursor;
      InputQuery(Lang[ID_NV_ADDWATCH], Lang[ID_NV_ENTERVAR], s);
    end;
    if s <> '' then
      AddDebugVar(s);
  end;
end;

procedure TMainForm.AddDebugVar(s: string);
begin
  if Trim(s) = '' then
    Exit;
  if fDebugger.Executing and fDebugger.Paused then
  begin
    fDebugger.AddWatch(s);
    fDebugger.RefreshContext;
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
  node := DebugTree.Selected;
  while Assigned(Node) and (Assigned(node.Parent)) do
    node := node.Parent;

  //Then remove the watch
  if Assigned(node) then
  begin
    fDebugger.RemoveWatch(IntToStr(Integer(node.Data)));
    DebugTree.Items.Delete(node);
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
  if assigned(e) then begin
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
    fDebugger.CloseDebugger(sender);
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
begin
{$IFNDEF PRIVATE_BUILD}
  //Added for wx: Try catch for Some weird On Close Error
  try
{$ENDIF}
    e := GetEditor;
    if assigned(e) then
    begin
      if e.isForm then
        actCut.Enabled := e.isForm
      else
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
begin
{$IFNDEF PRIVATE_BUILD}
  //Added for wx: Try catch for Some weird On Close Error
  try
{$ENDIF}
    e := GetEditor;

    if assigned(e) then
    begin
      if e.isForm then
        actCopy.Enabled := e.isForm
      else
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
begin
{$IFNDEF PRIVATE_BUILD}
  //Added for wx: Try catch for Some weird On Close Error
  try
{$ENDIF}
    e := GetEditor;

    if assigned(e) then
    begin
      if e.isForm then
        actPaste.Enabled := e.isForm
      else
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
    actSave.Enabled := assigned(e) and assigned(e.Text) and (e.Modified or e.Text.Modified or (e.FileName = ''));
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
    actFindNext.Enabled := assigned(e) and assigned(e.Text) and (e.Text.Text <> '');
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
      ToolsMenu.Items[idx].Enabled := FileExists(ParseParams(fTools.ToolList[i]^.Exec));
  end;
end;

function TMainForm.GetEditorFromFileName(ffile: string; donotReOpen:boolean): TEditor;
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
    else begin
          //ExpandFileName reduces all the "\..\" in the path
          if SameFileName(e.FileName, ExpandFileName(ffile)) then
      begin
        Result := e;
        Exit;
      end;
    end;
  end;

  if fCompiler.Target in [ctFile, ctNone] then begin
    if FileExists(ffile) then
      OpenFile(ffile);
    index := FileIsOpen(ffile);
    if index <> -1 then
      result := GetEditor(index);
  end
  else if (fCompiler.Target = ctProject) and Assigned(fProject) then
  begin
    index := fProject.GetUnitFromString(ffile);
    if index <> -1 then begin
      //mandrav
      index2 := FileIsOpen(ExpandFileName(fProject.Directory + ffile), TRUE);
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
    else begin
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
    StatusBar.Panels[1].Width - StatusBar.Panels[2].Width - StatusBar.Panels[4].Width;
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
  if not ClassBrowser1.Enabled or (not Assigned(e) and (ClassBrowser1.ShowFilter = sfCurrent)) then begin
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
  ClassBrowser1.ShowInheritedMembers := devClassBrowsing.ShowInheritedMembers;

  Screen.Cursor := crHourglass;
  if Full and CppParser1.Enabled then begin
    Application.ProcessMessages;
    ProgressEvents[0] := CppParser1.OnCacheProgress;
    ClassBrowser1.Parser := nil;
    CodeCompletion1.Parser := nil;
    FreeAndNil(CppParser1);
    CppParser1 := TCppParser.Create(Self);
    ClassBrowser1.Parser := CppParser1;
    CodeCompletion1.Parser := CppParser1;
    // moved here from ScanActiveProject()
    with CppParser1 do begin
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
  else begin
    e := GetEditor;
    if Assigned(e) then
      ClassBrowser1.ProjectDir := ExtractFilePath(e.FileName)
    else
      ClassBrowser1.ProjectDir := '';
  end;
  I1 := GetTickCount;
  with CppParser1 do begin
    Reset;
    if Assigned(fProject) then begin
      ProjectDir := fProject.Directory;
      for I := 0 to fProject.Units.Count - 1 do
        AddFileToScan(fProject.Units[I].FileName, True);
      for I := 0 to fProject.CurrentProfile.Includes.Count - 1 do
        AddProjectIncludePath(fProject.CurrentProfile.Includes[I]);
    end
    else begin
      e := GetEditor;
      if Assigned(e) then begin
        ProjectDir := ExtractFilePath(e.FileName);
        AddFileToScan(e.FileName);
      end
      else
        ProjectDir := '';
    end;
    ParseList;
    if PageControl.ActivePageIndex > -1 then begin
      e := GetEditor(PageControl.ActivePageIndex);
      if Assigned(e) then
        ClassBrowser1.CurrentFile := e.FileName;
    end;
  end;
  StatusBar.Panels[3].Text := 'Done parsing in ' + FormatFloat('#,###,##0.00', (GetTickCount - I1) / 1000) + ' seconds';
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
    FormProgress.Max := Total;
    FormProgress.Position := Current;
  end
  else
  begin
    FormProgress.Position := 0;
    StatusBar.Panels[3].Text := 'Done parsing.';
    StatusBar.Panels[2].Text := '';
  end;

  StatusBar.Update;
  FormProgress.Update;
end;

procedure TMainForm.CodeCompletion1Resize(Sender: TObject);
begin
  devCodeCompletion.Width := CodeCompletion1.Width;
  devCodeCompletion.Height := CodeCompletion1.Height;
end;

procedure TMainForm.actSwapHeaderSourceUpdate(Sender: TObject);
{var
 e: TEditor;}
begin
  actSwapHeaderSource.Enabled := PageControl.PageCount > 0;
  {  e:= GetEditor;
    if (Assigned(e)) and (e.New = False) then
    begin
        if GetFileTyp(e.FileName) = utSrc then
        begin
            actSwapHeaderSource.Enabled := (FileExists(ChangeFileExt(e.FileName,
              H_EXT))) or (FileExists(ChangeFileExt(e.FileName, HPP_EXT)));
        end else if GetFileTyp(e.FileName) = utHead then
        begin
            actSwapHeaderSource.Enabled := (FileExists(ChangeFileExt(e.FileName,
              C_EXT))) or (FileExists(ChangeFileExt(e.FileName, CPP_EXT)));
        end else
            actSwapHeaderSource.Enabled := False;
    end else
        actSwapHeaderSource.Enabled := False;}
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

  if Assigned(fProject) then begin
    FileName := e.FileName;
    if GetFileTyp(e.FileName) = utSrc then
      for i := 0 to fProject.Units.Count - 1 do begin
        FileName := ChangeFileExt(e.FileName, HPP_EXT);
        if AnsiCompareFileName(ExtractFileName(FileName), ExtractFileName(fProject.Units[i].FileName)) = 0 then begin
          FileName := fProject.Units[i].FileName;
          break;
        end;
        FileName := ChangeFileExt(e.FileName, H_EXT);
        if AnsiCompareFileName(ExtractFileName(FileName),ExtractFileName(fProject.Units[i].FileName)) = 0 then begin
          FileName := fProject.Units[i].FileName;
          break;
        end;
      end
    else if GetFileTyp(e.FileName) = utHead then
      for i := 0 to fProject.Units.Count - 1 do begin
        FileName := ChangeFileExt(e.FileName, CPP_EXT);
        if AnsiCompareFileName(ExtractFileName(FileName), ExtractFileName(fProject.Units[i].FileName)) = 0 then begin
          FileName := fProject.Units[i].FileName;
          break;
        end;
        FileName := ChangeFileExt(e.FileName, C_EXT);
        if AnsiCompareFileName(ExtractFileName(FileName),ExtractFileName(fProject.Units[i].FileName)) = 0 then begin
          FileName := fProject.Units[i].FileName;
          break;
        end;
        FileName := ChangeFileExt(e.FileName, CC_EXT);
        if AnsiCompareFileName(ExtractFileName(FileName),ExtractFileName(fProject.Units[i].FileName)) = 0 then begin
          FileName := fProject.Units[i].FileName;
          break;
        end;
        FileName := ChangeFileExt(e.FileName, CXX_EXT);
        if AnsiCompareFileName(ExtractFileName(FileName),ExtractFileName(fProject.Units[i].FileName)) = 0 then begin
          FileName := fProject.Units[i].FileName;
          break;
        end;
        FileName := ChangeFileExt(e.FileName, CP2_EXT);
        if AnsiCompareFileName(ExtractFileName(FileName),ExtractFileName(fProject.Units[i].FileName)) = 0 then begin
          FileName := fProject.Units[i].FileName;
          break;
        end;
        FileName := ChangeFileExt(e.FileName, CP_EXT);
        if AnsiCompareFileName(ExtractFileName(FileName),ExtractFileName(fProject.Units[i].FileName)) = 0 then begin
          FileName := fProject.Units[i].FileName;
          break;
        end;
      end
  end;
  if not FileExists(FileName) then begin
    if GetFileTyp(e.FileName) = utSrc then
    begin
      if (CompareText(Ext, CPP_EXT) = 0) or (CompareText(Ext, CC_EXT) = 0) or
        (CompareText(Ext, CXX_EXT) = 0) or (CompareText(Ext, CP2_EXT) = 0) or
        (CompareText(Ext, CP_EXT) = 0) then
      begin
        FileName := ChangeFileExt(e.FileName, HPP_EXT);
        if not FileExists(FileName) then
          FileName := ChangeFileExt(e.FileName, H_EXT);
      end else
        FileName := ChangeFileExt(e.FileName, H_EXT);
    end else if GetFileTyp(e.FileName) = utHead then
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

  if not FileExists(FileName) then begin
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
    (Sender as TCustomAction).Enabled := not (fProject.CurrentProfile.typ = dptStat)
  else
    (Sender as TCustomAction).Enabled := PageControl.PageCount > 0;
end;

procedure TMainForm.actRunUpdate(Sender: TObject);
begin
  if Assigned(fProject) then
    (Sender as TCustomAction).Enabled := not (fProject.CurrentProfile.typ = dptStat) and not devExecutor.Running and not fDebugger.Executing and not fCompiler.Compiling
  else
    (Sender as TCustomAction).Enabled := (PageControl.PageCount > 0) and not devExecutor.Running and not fDebugger.Executing and not fCompiler.Compiling;
end;

procedure TMainForm.PageControlChange(Sender: TObject);
var
  e: TEditor;
  i, x, y: integer;
  intActivePage:Integer;
begin
  intActivePage := PageControl.ActivePageIndex;

  if intActivePage > -1 then
  begin
    e := GetEditor(intActivePage);
    if Assigned(e) then
    begin
{$IFDEF WX_BUILD}
      if e.isForm then
      begin
        if not ELDesigner1.Active then
          EnableDesignerControls;
        e.ActivateDesigner
      end
      else
{$ENDIF}
      begin
{$IFDEF WX_BUILD}
        if ELDesigner1.Active then
          DisableDesignerControls;
{$ENDIF}
        e.Text.SetFocus;
        if ClassBrowser1.Enabled then
          ClassBrowser1.CurrentFile := e.FileName;
        for i := 1 to 9 do
          if e.Text.GetBookMark(i, x, y) then begin
            TogglebookmarksPopItem.Items[i - 1].Checked := true;
            TogglebookmarksItem.Items[i - 1].Checked := true;
          end
          else begin
            TogglebookmarksPopItem.Items[i - 1].Checked := false;
            TogglebookmarksItem.Items[i - 1].Checked := false;
          end;
      end;
    end;
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
    (Sender as TCustomAction).Enabled := not (fProject.CurrentProfile.typ = dptStat) and devExecutor.Running
  else
    (Sender as TCustomAction).Enabled := (PageControl.PageCount > 0) and devExecutor.Running;
end;

procedure TMainForm.CommentheaderMenuItemClick(Sender: TObject);
var  e: TEditor;
begin
  e := GetEditor;
  if assigned(e) then begin
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
  if Button = mbRight then begin // select new tab even with right mouse button
    if I > -1 then begin
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
  with TFunctionSearchForm.Create(Self) do begin
    fFileName := GetEditor.FileName;
    fParser := CppParser1;
    if ShowModal = mrOK then begin
      st := PStatement(lvEntries.Selected.Data);
      //make sure statement still exists
      if fParser.Statements.IndexOf(lvEntries.Selected.Data) = -1 then
        lvEntries.Selected.Data := nil;
      e := GetEditor;
      if Assigned(e) and Assigned(st) then begin
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
    if CppParser1.Statements.IndexOf(ClassBrowser1.Selected.Data) >=0 then
      (Sender as TAction).Enabled :=
        (PStatement(ClassBrowser1.Selected.Data)^._Kind<>skClass)
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
  (Sender as TAction).Enabled:=ClassBrowser1.Enabled
    and Assigned(fProject);
end;

procedure TMainForm.actBrowserNewMemberUpdate(Sender: TObject);
begin
  if Assigned(ClassBrowser1.Selected)
  and Assigned(ClassBrowser1.Selected.Data) then
    //check if node.data still in statements
    if CppParser1.Statements.IndexOf(ClassBrowser1.Selected.Data) >= 0 then
      (Sender as TAction).Enabled :=
        (PStatement(ClassBrowser1.Selected.Data)^._Kind=skClass)
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
        (PStatement(ClassBrowser1.Selected.Data)^._Kind=skClass)
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
  (Sender as TAction).Enabled:=ClassBrowser1.Enabled
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
  if (assigned(fProject) and (fProject.CurrentProfile.compilerType <> ID_COMPILER_MINGW)) then
  begin
    ShowMessage('Profiling is Disabled for Non-MingW compilers.') ;
    exit;
  end;
  prof := devCompiler.FindOption('-pg', optP, idxP);
  if prof then begin
    if Assigned(fProject) then begin
      if (fProject.CurrentProfile.CompilerOptions <> '') and (fProject.CurrentProfile.CompilerOptions[idxP + 1] = '1') then
        prof := true
      else
        prof := false;
    end
    else
      prof := optP.optValue > 0;
  end;
  // see if debugging is enabled
  deb := devCompiler.FindOption('-g3', optD, idxD);
  if deb then begin
    if Assigned(fProject) then begin
      if (fProject.CurrentProfile.CompilerOptions <> '') and (fProject.CurrentProfile.CompilerOptions[idxD + 1] = '1') then
        deb := true
      else
        deb := false;
    end
    else
      deb := optD.optValue > 0;
  end;

  if (not prof) or (not deb) then
    if MessageDlg(Lang[ID_MSG_NOPROFILE], mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      optP.optValue := 1;
      if Assigned(fProject) then
        SetProjCompOpt(idxP, True);
      devCompiler.Options[idxP] := optP;
      optD.optValue := 1;
      if Assigned(fProject) then
        SetProjCompOpt(idxD, True);
      devCompiler.Options[idxD] := optD;

      // Check for strip executable
      if devCompiler.FindOption('-s', optD, idxD) then begin
        optD.optValue := 0;
        if not Assigned(fProject) then
          devCompiler.Options[idxD] := optD; // set global debugging option only if not working with a project
        SetProjCompOpt(idxD, False);// set the project's correpsonding option too
      end;

      actRebuildExecute(nil);
      Exit;
    end
    else
      Exit;
  if Assigned(fProject) then
    if not FileExists(ExtractFilePath(fProject.Executable) + GPROF_CHECKFILE) then begin
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
  if ClassBrowser1.FolderCount >= MAX_CUSTOM_FOLDERS then begin
    MessageDlg(Format(Lang[ID_POP_MAXFOLDERS], [MAX_CUSTOM_FOLDERS]), mtError, [mbOk], 0);
    Exit;
  end;

  Node := ClassBrowser1.Selected;
  S := 'New folder';
  if InputQuery(Lang[ID_POP_ADDFOLDER], Lang[ID_MSG_ADDBROWSERFOLDER], S) and (S<> '') then
    ClassBrowser1.AddFolder(S, Node);
end;

procedure TMainForm.actBrowserRemoveFolderExecute(Sender: TObject);
begin
  if Assigned(ClassBrowser1.Selected) and (ClassBrowser1.Selected.ImageIndex = ClassBrowser1.ItemImages.Globals) then
    if MessageDlg(Lang[ID_MSG_REMOVEBROWSERFOLDER], mtConfirmation, [mbYes,mbNo], 0) = mrYes then
      ClassBrowser1.RemoveFolder(ClassBrowser1.Selected.Text);
end;

procedure TMainForm.actBrowserRenameFolderExecute(Sender: TObject);
var
  S: string;
begin
  if Assigned(ClassBrowser1.Selected) and (ClassBrowser1.Selected.ImageIndex = ClassBrowser1.ItemImages.Globals) then begin
    S := ClassBrowser1.Selected.Text;
    if InputQuery(Lang[ID_POP_RENAMEFOLDER], Lang[ID_MSG_RENAMEBROWSERFOLDER], S) and (S <> '') then
      ClassBrowser1.RenameFolder(ClassBrowser1.Selected.Text, S);
  end;
end;

procedure TMainForm.actCloseAllButThisExecute(Sender: TObject);
var
  idx: integer;
  current: integer;
  e: TEditor;
  curFilename: string;
begin
  idx := 0;
  current := PageControl.ActivePageIndex;
  curFilename := AnsiLowerCase(GetEditor(current).FileName);
  while idx < PageControl.PageCount do
    if (idx = current) or
       (AnsiLowerCase(ChangeFileExt(GetEditor(idx).FileName, WXFORM_EXT)) = curFilename) or
       (AnsiLowerCase(ChangeFileExt(GetEditor(idx).FileName, H_EXT)) = curFilename) or
       (AnsiLowerCase(ChangeFileExt(GetEditor(idx).FileName, CPP_EXT)) = curFilename) or
       (AnsiLowerCase(ChangeFileExt(GetEditor(idx).FileName, XRC_EXT)) = curFilename) then
      idx := idx + 1
    else if not CloseEditor(idx, True) then
      Break;

  e := GetEditor;
  if Assigned(e) then begin
    // don't know why, but at this point the editor does not show its caret.
    // if we shift the focus to another control and back to the editor,
    // everything is fine. (I smell another SynEdit bug?)
    e.TabSheet.SetFocus;
{$IFDEF WX_BUILD}
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
  if Assigned(lvBacktrace.Selected) and (lvBackTrace.Selected.SubItems.Count >= 3) then
  begin
    idx := StrToIntDef(lvBacktrace.Selected.SubItems[2], -1);
    if idx <> -1 then
    begin
      e := GetEditorFromFileName(CppParser1.GetFullFilename(lvBacktrace.Selected.SubItems[1]));
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
    if (lvBackTrace.Items[I].SubItems.Count >= 3) and (lvBackTrace.Items[I].SubItems[2] <> '') then
    begin
      idx := StrToIntDef(lvBacktrace.Items[I].SubItems[2], -1);
      if idx <> -1 then
      begin
        e := GetEditorFromFileName(CppParser1.GetFullFilename(lvBacktrace.Items[I].SubItems[1]));
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
  if not (cdsSelected in State) then begin
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
  with Sender as TListView do begin
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
  begin
    e := GetEditorFromFileName(Filename);
    if Assigned(e) then
    begin
      if e.isForm then
        e.ReloadForm
      else
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
          if MessageDlg(Filename + ' has been modified outside of wxDev-C++.'#13#10#13#10 +
                        'Do you want to reload the file from disk? This will discard all your unsaved changes.',
                        mtConfirmation, [mbYes, mbNo], Handle) = mrYes then
            ReloadEditor(Filename);
        mctDeleted:
          MessageDlg(Filename + ' has been renamed or deleted.', mtInformation, [mbOk], Handle);
      end;
    ReloadFilenames.Clear;
  end
  else if ReloadFilenames.Count <> 0 then
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
  with TFilePropertiesForm.Create(Self) do begin
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
  if InputQuery(Lang[ID_POP_ADDFOLDER], Lang[ID_MSG_ADDBROWSERFOLDER], S) and (S <> '') then begin
    fp := fProject.GetFolderPath(ProjectView.Selected);
    if fp <> '' then
      fProject.AddFolder(fp + '/' + S)
    else
      fProject.AddFolder(S);
  end;
end;

procedure TMainForm.actProjectRemoveFolderExecute(Sender: TObject);
var
  idx: integer;
  node: TTreeNode;
begin
  if not assigned(fProject) then exit;
  if Assigned(ProjectView.Selected) and (ProjectView.Selected.Data = Pointer(-1)) then
    if MessageDlg(Lang[ID_MSG_REMOVEBROWSERFOLDER], mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      ProjectView.Items.BeginUpdate;
      while ProjectView.Selected.Count > 0 do begin
        node := ProjectView.Selected.Item[0];
        if not assigned(node) then
          Continue;
        if (node.Data = Pointer(-1)) or (node.Level < 1) then
         Continue;
        idx:= integer(node.Data);
        if not fProject.Remove(idx, true) then
          exit;
      end;
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
  if Assigned(ProjectView.Selected) and (ProjectView.Selected.Data = Pointer(-1)) then begin
    S := ProjectView.Selected.Text;
    if InputQuery(Lang[ID_POP_RENAMEFOLDER], Lang[ID_MSG_RENAMEBROWSERFOLDER], S) and (S <> '') then begin
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
    (Sender = ProjectView) and Assigned(ProjectView.Selected) and Assigned(Item)  //and
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
  if not (Source is TTreeView) then exit;
  if ([htOnItem, htOnRight, htToRight] * ProjectView.GetHitTestInfoAt(X, Y)) <> [] then
    Item := ProjectView.GetNodeAt(X, Y)
  else
    Item := nil;
  for I := 0 to ProjectView.SelectionCount - 1 do begin
    srcNode := ProjectView.Selections[I];
    if not Assigned(Item) then begin
      fProject.Units[Integer(srcNode.Data)].Folder := '';
      srcNode.MoveTo(ProjectView.Items[0], naAddChild);
    end
    else begin
      if srcNode.Data <> Pointer(-1) then begin
        if Item.Data = Pointer(-1) then
          fProject.Units[Integer(srcNode.Data)].Folder := fProject.GetFolderPath(Item)
        else
          fProject.Units[Integer(srcNode.Data)].Folder := '';
      end;
      WasExpanded := Item.Expanded;
      ProjectView.Items.BeginUpdate;
      srcNode.MoveTo(Item, naAddChild);
      if not WasExpanded then begin
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
  with TImportMSVCForm.Create(Self) do  begin
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
    AddDebugVar(s);
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
 line : integer;
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
  else if fDebugger.Paused and (not fDebugger.BreakpointExists(e.Filename, line)) then
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

  opts :=TProjProfile.Create;
  
  if (fProject.CurrentProfile.typ in [dptDyn, dptStat]) and (opt.optValue > 0) then begin
    // project is a lib or a dll, and profiling is enabled
    // check for the existence of "-lgmon" in project's linker options
    if AnsiPos('-lgmon', fProject.CurrentProfile.Linker) = 0 then
      // does not have -lgmon
      // warn the user that we should update its project options and include
      // -lgmon in linker options, or else the compilation will fail
      if MessageDlg('You have profiling enabled in Compiler Options and you are ' +
        'working on a dynamic or static library. Do you want to add a special ' +
        'linker option in your project to allow compilation with profiling enabled? ' +
        'If you choose No, and you do not disable profiling from the Compiler Options ' +
        'chances are that your library''s compilation will fail...', mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then begin
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
      ParamsForm.HostEdit.Text := fProject.CurrentProfile.HostApplication;
    if (not Assigned(fProject)) or (fProject.CurrentProfile.typ <> dptDyn) then
      ParamsForm.DisableHost;
    if (ParamsForm.ShowModal = mrOk) then begin
      fCompiler.RunParams := ParamsForm.ParamEdit.Text;
      if (ParamsForm.HostEdit.Enabled) then
        fProject.SetHostApplication(ParamsForm.HostEdit.Text);
    end;
  finally
    ParamsForm.Free;
  end;
end;

procedure TMainForm.DevCppDDEServerExecuteMacro(Sender: TObject;
  Msg: TStrings);
var
  filename: string;
  i, n: Integer;
begin
  if Msg.Count > 0 then begin
    for i := 0 to Msg.Count - 1 do begin
      filename := Msg[i];
      if Pos('[Open(', filename) = 1 then begin
        n := Pos('"', filename);
        if n > 0 then begin
          Delete(filename, 1, n);
          n := Pos('"', filename);
          if n > 0 then
            Delete(filename, n, maxint);
          try
            begin
              {$IFDEF WX_BUILD}
              if iswxForm(filename) then
              begin
                OpenFile(ChangeFileExt(filename, H_EXT), True);
                OpenFile(ChangeFileExt(filename, CPP_EXT), true);
              end;
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
  with TTipOfTheDayForm.Create(Self) do begin
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
  Application.HelpFile := IncludeTrailingBackslash(devDirs.Help) + DEV_MAINHELP_FILE;
  Application.HelpCommand(HELP_FINDER, 0);
  WordToHelpKeyword;
end;

procedure TMainForm.WordToHelpKeyword;
var s: pchar;
    tmp: string;
    e: TEditor;
    OK: boolean;
begin
  OK := False;
  e := GetEditor;
  if Assigned(e) then begin
    tmp := e.GetWordAtCursor;
    if (tmp <> '') then  begin
      GetMem(s, length(tmp) + 1);
      StrCopy(s, pchar(tmp));
      Application.HelpCommand(HELP_KEY, integer(s));
      FreeMem(s);
      OK := True;
    end;
  end;
  if not OK then
    Application.HelpCommand(HELP_FINDER, 0);
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
begin
  if Assigned(fProject) then begin
    Caption := Format('%s %s  -  [ %s ] - %s', [DEVCPP, DEVCPP_VERSION, fProject.Name, ExtractFilename(fProject.Filename)]);
    Application.Title := Format('%s - [%s]', [DEVCPP, fProject.Name]);
  end
  else begin
    Caption := Format('%s %s', [DEVCPP, DEVCPP_VERSION]);
    Application.Title := Format('%s', [DEVCPP]);
  end;
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
  for I := 0 to PageControl.PageCount - 1 do begin
    e := GetEditor(I);
    if Assigned(e) and FileExists(e.FileName) then begin
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
  if not FileExists(devCVSHandler.Executable) then begin
    MessageDlg(Lang[ID_MSG_CVSNOTCONFIGED], mtWarning, [mbOk], 0);
    Exit;
  end;
  e := GetEditor;
  if TAction(Sender).ActionComponent.Tag = 1 then // project popup
    S := IncludeQuoteIfSpaces(fProject.FileName)
  else if TAction(Sender).ActionComponent.Tag = 2 then begin // unit popup
    S := '';
    if ProjectView.Selected.Data = Pointer(-1) then begin // folder
      for idx := 0 to fProject.Units.Count - 1 do
        if AnsiStartsStr(fProject.GetFolderPath(ProjectView.Selected), fProject.Units[idx].Folder) then
          S := S + IncludeQuoteIfSpaces(fProject.Units[idx].FileName) + ',';
      if S = '' then
        S := 'ERR';
    end
    else
      S := IncludeQuoteIfSpaces(fProject.Units[Integer(ProjectView.Selected.Data)].FileName);
  end
  else if TAction(Sender).ActionComponent.Tag = 3 then // editor popup or [CVS menu - current file]
    S := IncludeQuoteIfSpaces(e.FileName)
  else if TAction(Sender).ActionComponent.Tag = 4 then begin // CVS menu - whole project
    if Assigned(fProject) then
      S := ExtractFilePath(fProject.FileName)
    else begin
      if Assigned(e) then
        S := ExtractFilePath(e.FileName)
      else
        S := ExtractFilePath(devDirs.Default);
    end;
    S := IncludeQuoteIfSpaces(S);
  end;

  if not Assigned(fProject) then
    all := IncludeQuoteIfSpaces(S)
  else begin
    all := IncludeQuoteIfSpaces(fProject.FileName) + ',';
    for idx := 0 to fProject.Units.Count - 1 do
      all := all + IncludeQuoteIfSpaces(fProject.Units[idx].FileName) + ',';
    Delete(all, Length(all), 1);
  end;

  with TCVSForm.Create(Self) do begin
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
    if (w.ShowModal = mrOk) and (w.UnitList.ItemIndex > -1) then begin
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
  else if Node1.Data = pointer(-1) then
    Compare := -1
  else if Node2.Data = pointer(-1) then
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
  if (Button = mbLeft) and not (htOnItem in ProjectView.GetHitTestInfoAt(X, Y)) then
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
  if AnsiCompareFileName(ExtractFileExt(aFile), '.chm') = 0 then begin
    ExecuteFile(aFile, '', devDirs.Help, SW_SHOW);
    exit;
  end;
  if AnsiPos(HTTP, aFile) = 1 then
    ExecuteFile(aFile, '', devDirs.Help, SW_SHOW)
  else begin
    Application.HelpFile := aFile;
    // moving this to WordToHelpKeyword
    // it's annoying to display the index when the topic has been found and is already displayed...
//    Application.HelpCommand(HELP_FINDER, 0);
    WordToHelpKeyword;
  end;
end;

procedure TMainForm.AddWatchBtnClick(Sender: TObject);
var s: string;
begin
  if InputQuery(Lang[ID_NV_ADDWATCH], Lang[ID_NV_ENTERVAR], s) then
    AddDebugVar(s);
end;

procedure TMainForm.ShowProjectInspItemClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  if TMenuItem(Sender).Checked then
    ShowDockForm(frmProjMgrDock)
  else
    HideDockForm(frmProjMgrDock);
end;

procedure TMainForm.ShowPropertyInspItemClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  if TMenuItem(Sender).Checked then
    ShowDockForm(frmInspectorDock)
  else
    HideDockForm(frmInspectorDock);
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
  if devData.DblFiles then begin
    ProjectView.HotTrack := False;
    ProjectView.MultiSelect := True;
  end
  else begin
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
  (Sender as TCustomAction).Enabled := (assigned(fProject) and    (PageControl.PageCount > 0)) and
    not devExecutor.Running and not fDebugger.Executing and
    not fCompiler.Compiling;
end;

procedure TMainForm.actSaveProjectAsExecute(Sender: TObject);
begin
  if not Assigned(fProject) then
    Exit;
  with dmMain.SaveDialog do begin
    Filter := FLT_PROJECTS;
    if Execute then begin
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
  if not assigned(fProject) then exit;
  if not assigned(ProjectView.Selected) or
    (ProjectView.Selected.Level < 1) then exit;
  if ProjectView.Selected.Data = Pointer(-1) then
    Exit;
  idx := integer(ProjectView.Selected.Data);

  ext := ExtractFileExt(fProject.Units[idx].FileName);
  idx2 := devExternalPrograms.AssignedProgram(ext);
  if idx2 <> -1 then begin
    item := TMenuItem.Create(nil);
    item.Caption := ExtractFilename(devExternalPrograms.ProgramName[idx2]);
    item.Tag := idx2;
    item.OnClick := mnuOpenWithClick;
    mnuOpenWith.Add(item);
  end;
  if GetAssociatedProgram(ext, s, s1) then begin
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

function TMainForm.OpenWithAssignedProgram(strFileName:String):boolean;
var
  idx2, idx3: integer;
begin
  Result:=false;

  if not Assigned(fProject) then
    Exit;
  if not assigned(ProjectView.Selected) or
    (ProjectView.Selected.Level < 1) then exit;
  if ProjectView.Selected.Data = Pointer(-1) then
    Exit;
  idx2 := integer(ProjectView.Selected.Data);
  idx3:=devExternalPrograms.AssignedProgram(ExtractFileExt(fProject.Units[idx2].FileName));
  if idx3 = -1 then
  begin
    exit;
  end;
    ShellExecute(0, 'open',
      PChar(devExternalPrograms.ProgramName[idx3]),
      PChar(fProject.Units[idx2].FileName),
      PChar(ExtractFilePath(fProject.Units[idx2].FileName)),
      SW_SHOW);

    Result:=true;

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
    (ProjectView.Selected.Level < 1) then exit;
  if ProjectView.Selected.Data = Pointer(-1) then
    Exit;
  idx2 := integer(ProjectView.Selected.Data);

  item := Sender as TMenuItem;
  if item = mnuOpenWith then begin
    idx := -2;
    with dmMain.OpenDialog do begin
      Filter := FLT_ALLFILES;
      if Execute then
        idx := devExternalPrograms.AddProgram(ExtractFileExt(fProject.Units[idx2].FileName), Filename);
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
  else if idx <> -2 then // registry-based
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

  for I := 0 to CppParser1.Statements.Count - 1 do begin
    st := PStatement(CppParser1.Statements[I]);
    if st^._InProject and (st^._Kind in [skClass, skTypedef]) then
      cmbClasses.Items.AddObject(st^._ScopelessCmd, Pointer(I));
  end;
  if S <> '' then begin
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

  for I := 0 to CppParser1.Statements.Count - 1 do begin
    st := PStatement(CppParser1.Statements[I]);
    if (st^._ParentID = idx) and st^._InProject and (st^._Kind in [skFunction, skConstructor, skDestructor]) then
      cmbMembers.Items.AddObject(st^._ScopelessCmd + st^._Args, Pointer(I));
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

  if st^._IsDeclaration then begin
    I := st^._DeclImplLine;
    fname := st^._DeclImplFileName;
  end
  else begin
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
  RemoveWatchPop.Enabled := Assigned(DebugTree.Selected);
end;

procedure TMainForm.actAttachProcessUpdate(Sender: TObject);
begin
  if assigned(fProject) and (fProject.CurrentProfile.typ = dptDyn) then begin
    (Sender as TCustomAction).Visible := true;
    (Sender as TCustomAction).Enabled := not devExecutor.Running;
  end
  else
    (Sender as TCustomAction).Visible := false;
end;

procedure TMainForm.actAttachProcessExecute(Sender: TObject);
var
  idx : integer;
begin
  PrepareDebugger;
  if assigned(fProject) then begin
    if not FileExists(fProject.Executable) then begin
      MessageDlg(Lang[ID_ERR_PROJECTNOTCOMPILED], mtWarning, [mbOK], 0);
      exit;
    end;

    try
      ProcessListForm := TProcessListForm.Create(self);
      if (ProcessListForm.ShowModal = mrOK) and (ProcessListForm.ProcessCombo.ItemIndex > -1) then begin
        // add to the debugger the project include dirs
        for idx := 0 to fProject.CurrentProfile.Includes.Count - 1 do
          fDebugger.AddIncludeDir(fProject.CurrentProfile.Includes[idx]);

        fDebugger.Attach(Integer(ProcessListForm.ProcessList[ProcessListForm.ProcessCombo.ItemIndex]));
        fDebugger.RefreshBreakpoints;
        fDebugger.Go;
      end
    finally
      ProcessListForm.Free;
    end;
  end;
end;

procedure TMainForm.actModifyWatchExecute(Sender: TObject);
var
  s, val: string;
  i: integer;
  n: TTreeNode;
begin
  if (not Assigned(DebugTree.Selected)) or (not fDebugger.Executing) then
    exit;
  s := DebugTree.Selected.Text;
  val := '';
  i := Pos(' ', s);
  if i > 0 then begin
    Val := Copy(s, i + 3, length(s) - Pos(' ', s));
    Delete(s, Pos(' ', s), length(s) - Pos(' ', s) + 1);
  end;
  if Assigned(DebugTree.Selected.Parent) then begin
    n := DebugTree.Selected.Parent;
    while (Assigned(n)) do begin
      s := n.Text + '.' + s;
      n := n.Parent;
    end;
  end;

  //Create the variable edit dialog
  ModifyVarForm := TModifyVarForm.Create(self);
  try
    ModifyVarForm.NameEdit.Text := s;
    ModifyVarForm.ValueEdit.Text := Val;
    if ModifyVarForm.ShowModal = mrOK then
    begin
      fDebugger.ModifyVariable(ModifyVarForm.NameEdit.Text, ModifyVarForm.ValueEdit.Text);
      fDebugger.RefreshContext;
    end;
  finally
    ModifyVarForm.Free;
  end;

end;

procedure TMainForm.actModifyWatchUpdate(Sender: TObject);
begin
  (Sender as TCustomAction).Enabled := Assigned(DebugTree.Selected) and fDebugger.Executing;
end;

procedure TMainForm.ClearallWatchPopClick(Sender: TObject);
var
  node: TTreeNode;
begin
  node := DebugTree.TopItem;
  while Assigned(Node) do begin
    fDebugger.RemoveWatch(IntToStr(integer(node.Data)));
    DebugTree.Items.Delete(node);
    node := DebugTree.TopItem;
  end;
  DebugTree.Items.Clear;
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
  IsIconized := True;
end;

procedure TMainForm.ApplicationEvents1Activate(Sender: TObject);
begin
  IsIconized := False;
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


{$IFDEF WX_BUILD}
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

// Create a dialog that will be destroyed by the client code
function TMainForm.CreateCreateFormDlg(dsgnType:TWxDesignerType; insertProj:integer;
                                       projShow:boolean;filenamebase: string): TfrmCreateFormProp;
var
  SuggestedFilename: string;
  INI: Tinifile;
  i : integer;
begin
  if filenamebase = '' then
    SuggestedFilename := Lang[ID_UNTITLED] + inttostr(dmMain.GetNum)
  else
    SuggestedFilename := filenamebase;
  Result := TfrmCreateFormProp.Create(self);
  Result.JvFormStorage1.RestoreFormPlacement;
  Result.JvFormStorage1.Active := False;
  Result.txtTitle.Text := SuggestedFilename;

  if dsgnType = dtWxFrame then
    Result.Caption := 'New wxWidgets Frame'
  else
    Result.Caption := 'New wxWidgets Dialog';

  //Suggest a filename to the user
  if dsgnType = dtWxFrame then
  begin
    Result.txtFileName.Text := CreateValidFileName(SuggestedFilename + 'Frm');
    Result.txtClassName.Text := CreateValidClassName(SuggestedFilename + 'Frm');
  end
  else
  begin
    Result.txtFileName.Text := CreateValidFileName(SuggestedFilename + 'Dlg');
    Result.txtClassName.Text := CreateValidClassName(SuggestedFilename + 'Dlg');
  end;

  // Open the ini file and see if we have any default values for author, class, license
  // ReadString will return either the ini key or the default
  INI := TiniFile.Create(devDirs.Config + 'devcpp.ini');
  Result.txtAuthorName.Text := INI.ReadString('wxWidgets', 'Author', GetLoginName);
  INI.free;

  // Add compiler profile names to the dropdown box
  if (fProject <> nil) and (projShow = true) then // if nil, then this is not part of a project (so no profile)
  begin
    Result.ProfileNameSelect.Show;
    Result.ProfileLabel.Show;
    Result.ProfileNameSelect.Clear;
    for i := 0 to fProject.Profiles.Count-1 do
      Result.ProfileNameSelect.Items.Add(fProject.Profiles.Items[i].ProfileName);
    Result.ProfileNameSelect.ItemIndex := fProject.DefaultProfileIndex; // default compiler profile selection
  end
  else
  begin
    Result.ProfileNameSelect.Hide;
     Result.ProfileLabel.Hide;
  end;
  //Decide where the file will be stored
  if insertProj = 1 then
    Result.txtSaveTo.Text := IncludeTrailingBackslash(ExtractFileDir(fProject.FileName))
  else if devDirs.Default <> '' then
    Result.txtSaveTo.Text := IncludeTrailingBackslash(devDirs.Default)
  else if Trim(Result.txtSaveTo.Text) = '' then
    Result.txtSaveTo.Text := IncludeTrailingBackslash(ExtractFileDir(Application.ExeName));
end;

procedure TMainForm.CreateNewDialogOrFrameCode(dsgnType:TWxDesignerType;
                                               frm:TfrmCreateFormProp;
                                               insertProj:integer);
var
  TemplatesDir: string;
  BaseFilename: string;
  currFile: string;
  OwnsDlg: boolean;

  strFName, strCName, strFTitle: string;
  dlgSStyle: TWxDlgStyleSet;
  strCppFile,strHppFile:String;
  INI: Tinifile;

  strLstXRCCode: TStringList;

begin
  //Get the path of our templates
  TemplatesDir := IncludeTrailingBackslash(GetRealPath(devDirs.Templates, ExtractFileDir(Application.ExeName)));

  //Get the paths of the source code
  if dsgnType = dtWxFrame then
  begin
    strCppFile := TemplatesDir + 'wxWidgets\wxFrame.cpp.code';
    strHppFile := TemplatesDir + 'wxWidgets\wxFrame.h.code';
  end
  Else
  begin
    strCppFile := TemplatesDir + 'wxWidgets\wxDlg.cpp.code';
    strHppFile := TemplatesDir + 'wxWidgets\wxDlg.h.code';
  end;

  if (not fileExists(strCppFile)) then
  begin
    MessageDlg('Unable to find wxWidgets Template file: ' + strCppFile + #13+#10#13+#10 +
               'Please provide the template files in the template directory.', mtError, [mbOK], 0);
    exit;
  end
  else if (not fileExists(strHppFile)) then
  begin
    MessageDlg('Unable to find wxWidgets Template file: ' + strHppFile + #13#10#13#10 +
               'Please provide the template files in the template directory.', mtError, [mbOK], 0);
    exit;
  end;

  //Ask the user what he wants to do if the project parameter is set to 'prompt' (2)
  if Assigned(fProject) and (insertProj = 2) then
    if MessageBox(Self.Handle, PChar(Lang[ID_MSG_NEWRES]), 'wxDev-C++', MB_ICONQUESTION or MB_YESNO) = 6 then
      insertProj := 1
    else
      insertProj := 0
  else if (not Assigned(fProject)) then
    insertProj := 0;

  //Create the dialog and ask the user if we didn't specify a dialog to use
  OwnsDlg := not Assigned(frm);
  if (not Assigned(frm)) then
  begin
    //Get an instance of the dialog
    frm := CreateCreateFormDlg(dsgnType, insertProj,false);
    //Show the dialog
    if frm.showModal <> mrOK then
    begin
      frm.Destroy;
      exit;
    end;
    //Wow, the user clicked OK: save the user name
    INI := TiniFile.Create(devDirs.Config + 'devcpp.ini');
    INI.WriteString('wxWidgets', 'Author', frm.txtAuthorName.Text);
    INI.free;
  end;

  //Create the output folder if the folder does not exist
  BaseFilename := IncludeTrailingBackslash(Trim(frm.txtSaveTo.Text)) + Trim(frm.txtFileName.Text) + H_EXT;
  if not DirectoryExists(GetRealPath(ExtractFileDir(BaseFilename))) then
    ForceDirectories(GetRealPath(ExtractFileDir(BaseFilename)));

  //OK, load the template and parse and save it
  ParseAndSaveTemplate(StrHppFile, ChangeFileExt(BaseFilename, H_EXT), frm);
  ParseAndSaveTemplate(StrCppFile, ChangeFileExt(BaseFilename, CPP_EXT), frm);
  GetIntialFormData(frm, strFName, strCName, strFTitle,dlgSStyle, dsgnType);
  CreateFormFile(strFName, strCName, strFTitle, dlgSStyle,dsgnType);

  //NinjaNL: If we have Generate XRC turned on then we need to create a blank XRC
  //         file on project initialisation
  if (ELDesigner1.GenerateXRC) then
  begin
    strLstXRCCode := CreateBlankXRC;
    try
      strLstXRCCode.SaveToFile(ChangeFileExt(BaseFilename, XRC_EXT));
    finally
      strLstXRCCode.Destroy;
    end;
  end;

  //Destroy the dialog if we own it
  if OwnsDlg then
    frm.Destroy;

  currFile := ChangeFileExt(BaseFilename, H_EXT);
  if insertProj = 1 then
  begin
    assert(assigned(fProject), 'Global project should be defined!');
    fProject.AddUnit(currFile, fProject.Node, false); // add under folder
    if ClassBrowser1.Enabled then
      CppParser1.AddFileToScan(currFile, true);
    fProject.OpenUnit(fProject.Units.Indexof(currFile));
  end
  else
    OpenFile(currFile);

  currFile := ChangeFileExt(BaseFilename, CPP_EXT);
  if insertProj = 1 then
  begin
    assert(assigned(fProject), 'Global project should be defined!');
    fProject.AddUnit(currFile, fProject.Node, false); // add under folder
    if ClassBrowser1.Enabled then
      CppParser1.AddFileToScan(currFile, true);
    fProject.OpenUnit(fProject.Units.Indexof(currFile));
  end
  else
    OpenFile(currFile);

  if (ELDesigner1.GenerateXRC) then
  begin
    currFile := ChangeFileExt(BaseFilename, XRC_EXT);
    if insertProj = 1 then
    begin
      assert(assigned(fProject), 'Global project should be defined!');
      fProject.AddUnit(currFile, fProject.Node, false); // add under folder
      if ClassBrowser1.Enabled then
        CppParser1.AddFileToScan(currFile, true);
      fProject.OpenUnit(fProject.Units.Indexof(currFile));
    end
    else
      OpenFile(currFile);
  end;

  currFile := ChangeFileExt(BaseFilename, WXFORM_EXT);
  if insertProj = 1 then
  begin
    assert(assigned(fProject), 'Global project should be defined!');
    fProject.AddUnit(currFile, fProject.Node, false); // add under folder
    if ClassBrowser1.Enabled then
      CppParser1.AddFileToScan(currFile, true);
    with fProject.OpenUnit(fProject.Units.Indexof(currFile)) do
      Activate;
  end
  else
    OpenFile(currFile);

  if not ClassBrowser1.Enabled then
    MessageDlg('The Class Browser is not enabled.'+ #13#10#13#10 +
               'The addition of event handlers and other features of the Form ' +
               'Designer won''t work properly.' + #13#10#13#10 +
               'Please enable the Class Browser.', mtInformation, [mbOK], 0);
end;

procedure TMainForm.NewWxProjectCode(dsgnType:TWxDesignerType);
// This code creates a new wxWidgets project
// including c++ code, headers, and resource files
// It was scavenged from TMainForm.CreateNewDialogOrFrameCode (above).
// The template for this code should be in the \Templates directory.
//
//  For wxFrame projects, the templates are:
//       Templates\wxWidgets\wxprojFrame.cpp,
//       Templates\wxWidgets\wxprojFrame.h,
//       Templates\wxWidgets\wxprojFrameApp.cpp, and
//       Templates\wxWidgets\wxprojFrameApp.h
//
//  For wxDialog projects, the templates are:
//       Templates\wxWidgets\wxprojDlg.cpp,
//       Templates\wxWidgets\wxprojDlg.h,
//       Templates\wxWidgets\wxprojDlgApp.cpp, and
//       Templates\wxWidgets\wxprojDlgApp.h
var
  frm: TfrmCreateFormProp;
  TemplatesDir: string;
  BaseFilename: string;
  currFile: string;
  strAppCppFile, strAppHppFile, strAppRcFile:String;
  ini: Tinifile;

begin
  //Get the path of our templates
  TemplatesDir := IncludeTrailingBackslash(GetRealPath(devDirs.Templates, ExtractFileDir(Application.ExeName)));

  //Get the filepaths of the templates
  strAppRcFile := TemplatesDir + 'wxWidgets\wxprojRes.rc';
  if dsgnType = dtWxFrame then
  begin
    strAppCppFile := TemplatesDir + 'wxWidgets\wxprojFrameApp.cpp';
    strAppHppFile := TemplatesDir + 'wxWidgets\wxprojFrameApp.h';
  end
  else
  begin
    strAppCppFile := TemplatesDir + 'wxWidgets\wxprojDlgApp.cpp';
    strAppHppFile := TemplatesDir + 'wxWidgets\wxprojDlgApp.h';
  end;

  //If template files don't exist, we need to send an error message to user.
  if (not fileExists(strAppCppFile)) then
  begin
    MessageDlg('Unable to find wxWidgets Template file: ' + strAppCppFile + #13+#10#13+#10 +
               'Please provide the template files in the template directory.', mtError, [mbOK], 0);
    exit;
  end
  else if (not fileExists(strAppHppFile))  then
  begin
    MessageDlg('Unable to find wxWidgets Template file: ' + strAppHppFile + #13+#10#13+#10 +
               'Please provide the template files in the template directory.', mtError, [mbOK], 0);
    exit;
  end;

  //Create an instance of the form creation dialog and show it
  frm := CreateCreateFormDlg(dsgnType, 1, true,ChangeFileExt(ExtractFileName(fProject.FileName),''));
  if frm.showModal <> mrOK then
  begin
  frm.Destroy;
    exit;
  end;

  // Change the current profile to what the user selected in the new project dialog
  fProject.CurrentProfileIndex := frm.ProfileNameSelect.ItemIndex;
  fProject.DefaultProfileIndex := frm.ProfileNameSelect.ItemIndex;
  

  
  //Write the current strings back as the default
  INI := TiniFile.Create(devDirs.Config + 'devcpp.ini');
  INI.WriteString('wxWidgets', 'Author', frm.txtAuthorName.Text);
  INI.free;

  //Then add the application initialization code
  BaseFilename := Trim(ChangeFileExt(fProject.FileName, '')) + APP_SUFFIX;
  ParseAndSaveTemplate(StrAppHppFile, ChangeFileExt(BaseFilename, H_EXT), frm);
  ParseAndSaveTemplate(StrAppCppFile, ChangeFileExt(BaseFilename, CPP_EXT), frm);
  ParseAndSaveTemplate(strAppRcFile, ChangeFileExt(BaseFilename, RC_EXT), frm);
  assert(assigned(fProject), 'Global project should be defined!');
  
  //Add the application entry source fle
  currFile := ChangeFileExt(BaseFilename, CPP_EXT);
  fProject.AddUnit(currFile, fProject.Node, false); // add under folder
  if ClassBrowser1.Enabled then
    CppParser1.AddFileToScan(currFile, true);
  fProject.OpenUnit(fProject.Units.Indexof(currFile));

  currFile := ChangeFileExt(BaseFilename, H_EXT);
  fProject.AddUnit(currFile, fProject.Node, false); // add under folder
  if ClassBrowser1.Enabled then
    CppParser1.AddFileToScan(currFile, true);
  fProject.OpenUnit(fProject.Units.Indexof(currFile));

  currFile := ChangeFileExt(BaseFilename, RC_EXT);
  fProject.AddUnit(currFile, fProject.Node, false); // add under folder
  if ClassBrowser1.Enabled then
    CppParser1.AddFileToScan(currFile, true);
  fProject.OpenUnit(fProject.Units.Indexof(currFile));

  //Finally create the form creation code
  CreateNewDialogOrFrameCode(dsgnType, frm, 1);
end;

function TMainForm.CreateFormFile(strFName, strCName, strFTitle: string; dlgSStyle:TWxDlgStyleSet; dsgnType:TWxDesignerType): Boolean;
var
  FNewFormObj: TfrmNewForm;
begin
  Result := True;
  FNewFormObj := TfrmNewForm.Create(self);
  try
    try
      if dsgnType = dtWxFrame then
        FNewFormObj.Wx_DesignerType:= dtWxFrame
      else
        FNewFormObj.Wx_DesignerType:= dtWxDialog;

      FNewFormObj.Caption := strFTitle;
      FNewFormObj.Wx_DialogStyle := dlgSStyle; //[wxCaption,wxResize_Border,wxSystem_Menu,wxThick_Frame,wxMinimize_Box,wxMaximize_Box,wxClose_Box];
      FNewFormObj.Wx_Name := strCName;
      FNewFormObj.Wx_Center:=True;
      FNewFormObj.EVT_CLOSE:='OnClose';
      WriteComponentsToFile([FNewFormObj], ChangeFileExt(strFName, wxform_Ext));
    except
      Result := False;
    end;
  finally
    FNewFormObj.Destroy;
  end;
end;

procedure TMainForm.GetIntialFormData(frm: TfrmCreateFormProp; var
  strFName, strCName, strFTitle: string; var dlgStyle: TWxDlgStyleSet; dsgnType:TWxDesignerType);
begin
  strCName := Trim(frm.txtClassName.Text);
  strFTitle := Trim(frm.txtTitle.Text);
  strFName := IncludeTrailingBackslash(Trim(frm.txtSaveTo.Text)) + Trim(frm.txtFileName.Text);

  dlgStyle := [];
  if frm.cbUseCaption.checked then
    dlgStyle := [wxCAPTION];

  if frm.cbResizeBorder.checked then
    dlgStyle := dlgStyle + [wxRESIZE_BORDER];

  if frm.cbSystemMenu.checked then
    dlgStyle := dlgStyle + [wxSYSTEM_MENU];

  if frm.cbThickBorder.checked then
    dlgStyle := dlgStyle + [wxTHICK_FRAME];

  if frm.cbStayOnTop.checked then
    dlgStyle := dlgStyle + [wxSTAY_ON_TOP];

  if frm.cbNoParent.checked then
    dlgStyle := dlgStyle + [wxDIALOG_NO_PARENT];

  if frm.cbMinButton.checked then
    dlgStyle := dlgStyle + [wxMINIMIZE_BOX];

  if frm.cbMaxButton.checked then
    dlgStyle := dlgStyle + [wxMAXIMIZE_BOX];

  if frm.cbCloseButton.checked then
    dlgStyle := dlgStyle + [wxCLOSE_BOX];
end;

procedure TMainForm.ParseAndSaveTemplate(template, destination: string; frm:TfrmCreateFormProp);
var
  TemplateStrings: TStringList;
  OutputString: string;
  WindowStyle: string;
  ClassName: string;
  Filename: string;
  DateStr: string;
  Author: string;
  Title: string;
begin
  //Determine the window style
  if frm.cbUseCaption.checked then
    WindowStyle := 'wxCAPTION | ';

  if frm.cbResizeBorder.checked then
    WindowStyle := WindowStyle + 'wxRESIZE_BORDER | ';

  if frm.cbSystemMenu.checked then
    WindowStyle := WindowStyle + 'wxSYSTEM_MENU | ';

  if frm.cbThickBorder.checked then
    WindowStyle := WindowStyle + 'wxTHICK_FRAME | ';

  if frm.cbStayOnTop.checked then
    WindowStyle := WindowStyle + 'wxSTAY_ON_TOP | ';

  if frm.cbNoParent.checked then
    WindowStyle := WindowStyle + 'wxDIALOG_NO_PARENT | ';

  if frm.cbMinButton.checked then
    WindowStyle := WindowStyle + 'wxMINIMIZE_BOX | ';

  if frm.cbMaxButton.checked then
    WindowStyle := WindowStyle + 'wxMAXIMIZE_BOX | ';

  if frm.cbCloseButton.checked then
    WindowStyle := WindowStyle + 'wxCLOSE_BOX | ';

  //Finalize the window style string
  if Length(WindowStyle) <> 0 then
    WindowStyle := Copy(WindowStyle, 0, Length(WindowStyle) - 3)
  else
    WindowStyle := '0';

  //Get the remaining properties
  ClassName := Trim(frm.txtClassName.Text);
  Filename  := ExtractFilename(IncludeTrailingBackslash(Trim(frm.txtSaveTo.Text)) + Trim(frm.txtFileName.Text));
  DateStr   := DateTimeToStr(now);
  Author    := Trim(frm.txtAuthorName.Text);
  Title     := Trim(frm.txtTitle.Text);
  if (FileExists(template) = false) then
  begin
    ShowMessage('Unable to find Template file '+template);
    exit;
  end;
  //Load the strings from file
  TemplateStrings := TStringList.Create;
  try
    TemplateStrings.LoadFromFile(template);

    OutputString := TemplateStrings.text;
    strSearchReplace(OutputString, '%FILE_NAME%', Filename,[srAll]);
    strSearchReplace(OutputString, '%DEVCPP_DIR%', devDirs.Exec, [srAll]);
    strSearchReplace(OutputString, '%CLASS_NAME%', ClassName, [srAll]);
    strSearchReplace(OutputString, '%AUTHOR_NAME%', Author, [srAll]);
    strSearchReplace(OutputString, '%DATE_STRING%', DateStr, [srAll]);
    strSearchReplace(OutputString, '%CLASS_TITLE%', Title, [srAll]);
    strSearchReplace(OutputString, '%CAP_CLASS_NAME%', UpperCase(ClassName),[srAll]);
    strSearchReplace(OutputString, '%CLASS_STYLE_STRING%', WindowStyle,[srAll]);

    //Replace the project only options
    if Assigned(fProject) then
    begin
      strSearchReplace(OutputString, '%PROJECT_NAME%', ChangeFileExt(ExtractFileName(fProject.FileName), ''), [srAll]);
      strSearchReplace(OutputString, '%APP_NAME%', ChangeFileExt(ExtractFileName(fProject.FileName), '') + APP_SUFFIX, [srAll]);
    end
    else
    begin
      strSearchReplace(OutputString, '%PROJECT_NAME%', '', [srAll]);
      strSearchReplace(OutputString, '%APP_NAME%', '', [srAll]);
    end;

    //Finally save the entire string to file
    SaveStringToFile(OutputString, destination);
  finally
    TemplateStrings.Destroy;
  end
end;

procedure TMainForm.ELDesigner1ContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
  CurrentControl: TControl;
  NewMenuItem: TMenuItem;
  strControlName:String;
  FrmInterface:IWxDesignerFormInterface;
begin
    //Create the selected control's "inheritence" tree
    if ELDesigner1.SelectedControls.Count > 0 then
    begin
        DesignerMenuSelectParent.Clear;
        DesignerMenuSelectParent.Enabled := True;
        DesignerMenuLocked.Enabled := True;

        //First check or uncheck the locking mode of the component
        CurrentControl := ELDesigner1.SelectedControls.Items[0];
        DesignerMenuLocked.Checked := ELDesigner1.GetLockMode(CurrentControl) <> [];
        DesignerMenuCut.Enabled := not DesignerMenuLocked.Checked;
        DesignerMenuDelete.Enabled := not DesignerMenuLocked.Checked;

        while CurrentControl.Parent <> nil do
        begin
            CurrentControl := CurrentControl.Parent;
            NewMenuItem := TMenuItem.Create(Self);
            if CurrentControl.GetInterface(IID_IWxDesignerFormInterface,FrmInterface) = true then
              strControlName := FrmInterface.GetFormName
            else
              strControlName:= CurrentControl.Name;
            NewMenuItem.Caption := strControlName;
            NewMenuItem.OnClick := SelectParentClick;
            DesignerMenuSelectParent.Add(NewMenuItem);
        end;
    end
    else
    begin
        DesignerMenuSelectParent.Enabled := False;
        DesignerMenuLocked.Enabled := False;
    end;

    Handled:=true;
    DesignerPopup.Popup(MousePos.X,MousePos.Y);
end;

procedure TMainForm.WxPropertyInspectorContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
    Pos: TPoint;
begin
    //Create a temporary var variable
    Pos := MousePos;
    Handled := true;

    //Convert to screen coordinates
    Windows.ClientToScreen(GetFocus, Pos);

    //Pop the menu up
    WxPropertyInspectorPopup.Popup(Pos.X, Pos.Y);
end;

procedure TMainForm.ELDesigner1ChangeSelection(Sender: TObject);
begin
{$IFNDEF PRIVATE_BUILD}
  try
{$ENDIF}
    if (ELDesigner1 = nil) or (ELDesigner1.DesignControl = nil) then
      Exit;

    //Make sure the Designer Form has the focus
    ELDesigner1.DesignControl.SetFocus;

    //Find the index of the current control and show its properties
    if ELDesigner1.SelectedControls.Count > 0 then
    begin
      cbxControlsx.ItemIndex :=
        cbxControlsx.Items.IndexOfObject(ELDesigner1.SelectedControls[0]);
      BuildProperties(ELDesigner1.SelectedControls[0]);
    end
    else if isCurrentPageDesigner then
      BuildProperties(GetCurrentDesignerForm);
{$IFNDEF PRIVATE_BUILD}
  finally
  end;
{$ENDIF}
end;

procedure TMainForm.ELDesigner1ControlDeleted(Sender: TObject;
  AControl: TControl);
var
  intCtrlPos,i: Integer;
  e: TEditor;
  boolContrainer:boolean;
  strCompName:String;
  wxcompInterface:IWxComponentInterface;
begin
   boolContrainer := False;
  ///SaveProjectFiles(strProjectFile,True,false);
  intCtrlPos := -1;
  //boolContrainer:=(IsControlWxContainer(AControl) or IsControlWxSizer(AControl));
  for i:=cbxControlsx.Items.Count -1 downto 0 do
  begin
    if AControl.GetInterface(IID_IWxComponentInterface, wxcompInterface) then
    begin
      strCompName:= AControl.Name +':'+wxcompInterface.GetWxClassName;
      if AnsiSameText(cbxControlsx.Items[i], strCompName) then
      begin
        cbxControlsx.Items.Delete(i);
        intCtrlPos:=i;
      end;
    end;
  end;

  if intCtrlPos <> -1 then
  begin
    if isCurrentPageDesigner then
    begin
      intCtrlPos := cbxControlsx.Items.IndexOfObject(GetCurrentDesignerForm());
      if ELDesigner1.SelectedControls.Count > 0 then
      begin
        FirstComponentBeingDeleted:=ELDesigner1.SelectedControls[0].Name;
      end;

      SelectedComponent:=GetCurrentDesignerForm();
      BuildProperties(GetCurrentDesignerForm());

      if boolContrainer then
        BuildComponentList(GetCurrentDesignerForm());

      //SelectedComponent := GetCurrentDesignerForm();
      if intCtrlPos <> -1 then
      begin
        cbxControlsx.ItemIndex := intCtrlPos;
        //cbxControlsxChange(SelectedComponent);
        //ELDesigner1.SelectedControls.Clear;
        //if Assigned(SelectedComponent) then
        //    ELDesigner1.SelectedControls.Add(TControl(SelectedComponent));
      end;
    end;
    if AControl is TWinControl then
    begin
        for i:=0 to TWinControl(AControl).ControlCount -1 do
        begin
            intCtrlPos := cbxControlsx.Items.IndexOfObject(TWinControl(AControl).Controls[i]);
            if intCtrlPos <> -1 then
                cbxControlsx.Items.Delete(intCtrlPos);
        end;
    end;
  end;

  e := GetEditor(Self.PageControl.ActivePageIndex);
  if Assigned(e) then
    e.UpdateDesignerData;

end;

procedure TMainForm.ELDesigner1ControlHint(Sender: TObject;
  AControl: TControl; var AHint: string);
var
  compIntf: IWxComponentInterface;
begin
  if AControl.GetInterface(IID_IWxComponentInterface, compIntf) then
  begin
    AHint := Format('%s:%s', [AControl.name, compIntf.GetWxClassName]);
  end;
end;

procedure TMainForm.ELDesigner1ControlInserted(Sender: TObject; AControl: TControl);
var
  I: Integer;
  compObj: TComponent;
  wxcompInterface: IWxComponentInterface;
  strClass: string;
  e: TEditor;
  wxControlPanelInterface:IWxControlPanelInterface;
begin
  FirstComponentBeingDeleted := '';
  if ELDesigner1.SelectedControls.Count > 0 then
  begin
    compObj := ELDesigner1.SelectedControls[ELDesigner1.SelectedControls.Count-1];
    ELDesigner1.SelectedControls[ELDesigner1.SelectedControls.Count-1].BringToFront;
    ELDesigner1.SelectedControls[ELDesigner1.SelectedControls.Count-1].Visible:=true;

    if compObj.GetInterface(IID_IWxComponentInterface, wxcompInterface) then
    begin
      strClass := wxcompInterface.GetWxClassName;
      SelectedComponent := compObj;
    end;

    cbxControlsx.ItemIndex :=
      cbxControlsx.Items.AddObject(ELDesigner1.SelectedControls[ELDesigner1.SelectedControls.Count-1].Name + ':' +
      strClass, ELDesigner1.SelectedControls[ELDesigner1.SelectedControls.Count-1]);
  end;

  if (AControl is TWinControl) then
  begin
    //TODO: Guru: Try to create an interface to make sure whether a container has
    //a limiting control. If someone is dropping more than one control then we'll
    //make the controls's parent as the parent of SplitterWindow
    if (TWinControl(AControl).Parent <> nil) and (TWinControl(AControl).Parent is TWxSplitterWindow) then
      if TWinControl(AControl).Parent.ControlCount > 2 then
        TWinControl(AControl).Parent:= TWinControl(AControl).Parent.Parent;

    if SelectedComponent <> nil then
    begin
      if (SelectedComponent is TWxNoteBookPage) then
      begin
        TWinControl(SelectedComponent).Parent := TWinControl(PreviousComponent);
        TWxNoteBookPage(SelectedComponent).PageControl := TPageControl(PreviousComponent);
      end;

      if (SelectedComponent is TWxNonVisibleBaseComponent) then
        TWxNonVisibleBaseComponent(SelectedComponent).Parent := ELDesigner1.DesignControl;

      if TfrmNewForm(ELDesigner1.DesignControl).Wx_DesignerType = dtWxFrame then
      begin
        if (SelectedComponent is TWxToolBar) then
          TWxToolBar(SelectedComponent).Parent:=ELDesigner1.DesignControl;

        if (SelectedComponent is TWxStatusBar) then
          TWxStatusBar(SelectedComponent).Parent:=ELDesigner1.DesignControl;
      end;

      //Like wxWidgets' default behaviour, fill the whole screen if only one control
      //is on the screen
      if GetWxWindowControls(ELDesigner1.DesignControl) = 1 then
        if IsControlWxWindow(Tcontrol(SelectedComponent)) then
          if TWincontrol(SelectedComponent).Parent is TForm then
            TWincontrol(SelectedComponent).Align := alClient;
    end;
  end;

  PreviousComponent:=nil;
  for I := 0 to ELDesigner1.SelectedControls.Count - 1 do // Iterate
  begin
    compObj := ELDesigner1.SelectedControls[i];
    if compObj is TWinControl then
      //if we drop a control to image or other static controls that are derived
      //from TWxControlPanel

      if TWinControl(compObj).Parent.GetInterface(IID_IWxControlPanelInterface,wxControlPanelInterface) then
      begin
{$IFNDEF PRIVATE_BUILD}
        try
{$ENDIF}
          if assigned(TWinControl(compObj).parent.parent) then
            TWinControl(compObj).parent:=TWinControl(compObj).parent.parent;
{$IFNDEF PRIVATE_BUILD}
        except
        end;
{$ENDIF}
      end;

{$IFNDEF PRIVATE_BUILD}
    try
{$ENDIF}
      if compObj.GetInterface(IID_IWxComponentInterface, wxcompInterface) then
      begin
        Inc(intControlCount);
        wxcompInterface.SetIDName('ID_' + UpperCase(compObj.Name));
        wxcompInterface.SetIDValue(intControlCount);
      end;
{$IFNDEF PRIVATE_BUILD}
    except
    end;
{$ENDIF}
  end; // End for

  ComponentPalette.UnselectComponents;
  ActiveControl := nil;

  e := GetEditor(Self.PageControl.ActivePageIndex);
  if Assigned(e) then
    e.UpdateDesignerData;

  //This makes the Sizers get painted properly.
  if ELDesigner1.SelectedControls.Count > 0 then
  begin
    compObj:=ELDesigner1.SelectedControls[0].parent;
    if compObj is TWinControl then
      while (compObj <> nil) do
      begin
        TWinControl(compObj).refresh;
        TWinControl(compObj).repaint;
        TWinControl(compObj):=TWinControl(compObj).parent;
      end;    // for
  end;

  ELDesigner1.DesignControl.Refresh;
  ELDesigner1.DesignControl.Repaint;
end;

procedure TMainForm.DisableDesignerControls;
begin
  cbxControlsx.Enabled := False;
  pgCtrlObjectInspector.Enabled := False;
  JvInspProperties.Enabled := False;
  JvInspEvents.Enabled := False;

  ComponentPalette.Enabled := False;
  HideDockForm(frmPaletteDock);

  ELDesigner1.Active:=False;
  ELDesigner1.DesignControl:=nil;

  SelectedComponent:=nil;
  if boolInspectorDataClear then
  begin
    JvInspProperties.Clear;
    if Assigned(JvInspProperties.Root) then
      JvInspProperties.Root.Clear;

    JvInspEvents.Clear;
    if Assigned(JvInspEvents.Root) then
      JvInspEvents.Root.Clear;
  end;

  boolInspectorDataClear := true;
  cbxControlsx.Items.Clear;
end;

procedure TMainForm.EnableDesignerControls;
begin
  //TODO: Guru: I have no clue why I'm getting an error at this place.
{$IFNDEF PRIVATE_BUILD}
  try
{$ENDIF}
    if Assigned(ELDesigner1.DesignControl) then
    begin
      ELDesigner1.Active:=True;
      ELDesigner1.DesignControl.SetFocus;
    end;
{$IFNDEF PRIVATE_BUILD}
  finally
{$ENDIF}
    cbxControlsx.Enabled := true;
{$IFNDEF PRIVATE_BUILD}
  end;
{$ENDIF}

  pgCtrlObjectInspector.Enabled := true;
  JvInspProperties.Enabled := true;
  JvInspEvents.Enabled := true;
  
  ComponentPalette.Enabled := True;
  ShowDockForm(frmPaletteDock);
end;

procedure TMainForm.ELDesigner1ControlDoubleClick(Sender: TObject);
var
  i,nSlectedItem:Integer;
begin
  if JvInspEvents.Root.Count = 0 then
    exit;
  nSlectedItem:=-1;
  for i:=0 to JvInspEvents.Root.Count -1 do
  Begin
      if JvInspEvents.Root.Items[i].Hidden = false then
      begin
        nSlectedItem:=i;
        break;
      end;
  end;
  if nSlectedItem = -1 then
    exit;

  JvInspEvents.Show;
  //If we dont select it then the Selection Event wont get fired
  JvInspEvents.SelectedIndex:=JvInspEvents.Root.Items[nSlectedItem].DisplayIndex;

  if JvInspEvents.Root.Items[nSlectedItem].Data.AsString <> '' then
  begin
    strGlobalCurrentFunction:=JvInspEvents.Root.Items[nSlectedItem].Data.AsString;
    JvInspEvents.OnDataValueChanged:=nil;
    JvInspEvents.Root.Items[nSlectedItem].Data.AsString:='<Goto Function>';
    JvInspEvents.Root.Items[nSlectedItem].DoneEdit(true);
    JvInspEvents.OnDataValueChanged:=JvInspEventsDataValueChanged;
    JvInspEventsDataValueChanged(nil,JvInspEvents.Root.Items[nSlectedItem].Data);
    exit;
  end
  else
  begin
    JvInspEvents.OnDataValueChanged:=nil;
    JvInspEvents.Root.Items[nSlectedItem].Data.AsString:='<Add New Function>';
    JvInspEvents.Root.Items[nSlectedItem].DoneEdit(true);
    JvInspEvents.OnDataValueChanged:=JvInspEventsDataValueChanged;
    JvInspEventsDataValueChanged(nil,JvInspEvents.Root.Items[nSlectedItem].Data);
    exit;
  end;
end;

procedure TMainForm.ELDesigner1ControlInserting(Sender: TObject;
  var AParent: TWinControl; var AControlClass: TControlClass);
var
  dlgInterface:IWxDialogNonInsertableInterface;
  tlbrInterface:IWxToolBarInsertableInterface;
  nontlbrInterface:IWxToolBarNonInsertableInterface;
  I: Integer;

  function GetNonAllowAbleControlCountForFrame(winCtrl:TWinControl):Integer;
  var
    I: Integer;
  begin
    Result := 0;
    //TODO: Guru: Weird error remover ... Shitty solution.
    FirstComponentBeingDeleted := '';

    if winCtrl = nil then
      Exit;
    Result := 0;
    for I := 0 to winCtrl.ControlCount - 1 do
    begin
      if (winCtrl.Controls[i] is TWxToolBar) or (winCtrl.Controls[i] is TWxMenuBar)
        or (winCtrl.Controls[i] is TWxStatusBar) or (winCtrl.Controls[i] is TWxPopupMenu)
        or (winCtrl.Controls[i] is TWxNonVisibleBaseComponent) then
        Continue;
      Inc(Result);
    end;
  end;

  function isSizerAvailable(winCtrl:TWinControl):Boolean;
  var
    I: Integer;
  begin
    Result := false;
    //TODO: Guru: Weird error remover ... Shitty solution.
    FirstComponentBeingDeleted := '';

    if winCtrl = nil then
      Exit;
    for I := 0 to winCtrl.ComponentCount - 1 do
    begin
      if winCtrl.Components[i] is TWxSizerPanel then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;

  procedure ShowErrorAndReset(msgstr:String);
  begin
    MessageDlg(msgstr, mtError, [mbOK], Handle);
    ComponentPalette.UnselectComponents;
    PreviousComponent := nil;
    AControlClass := nil;

    //Select the parent
    SendMessage(AParent.Handle,WM_LBUTTONDOWN,0,MAKELONG(100,100));
    PostMessage(AParent.Handle,WM_LBUTTONDOWN,0,MAKELONG(100,100));
    SendMessage(AParent.Handle,BM_CLICK,0,MAKELONG(100,100));
    PostMessage(AParent.Handle,BM_CLICK,0,MAKELONG(100,100));
    SendMessage(AParent.Handle,WM_LBUTTONUP,0,MAKELONG(100,100));
    PostMessage(AParent.Handle,WM_LBUTTONUP,0,MAKELONG(100,100));
  end;

begin
  //Make sure we have a component we want to insert
  if Trim(ComponentPalette.SelectedComponent) = '' then
    Exit;

  //Make sure that the type of control is valid
  AControlClass := TControlClass(GetClass(ComponentPalette.SelectedComponent));
  if AControlClass = nil then
    Exit;

  //Do some sanity checks
  if TFrmNewForm(ELDesigner1.DesignControl).Wx_DesignerType = dtWxFrame then
  begin
    if strContainsU(ComponentPalette.SelectedComponent, 'TWxStatusBar') and
      (GetAvailableControlCount(ELDesigner1.DesignControl, 'TWxStatusBar') > 0) then
    begin
      ShowErrorAndReset('Each frame can only have one statusbar.');
      Exit;
    end;

    if strContainsU(ComponentPalette.SelectedComponent, 'TWxMenuBar') and
      (GetAvailableControlCount(ELDesigner1.DesignControl, 'TWxMenuBar') > 0) then
    begin
      ShowErrorAndReset('Each frame can only have one menubar.');
      Exit;
    end;

    if StrContainsU(ComponentPalette.SelectedComponent, 'TWxStdDialogButtonSizer') then
    begin
      ShowErrorAndReset('wxStdDialogButtonSizers can only be inserted onto a wxDialog.');
      Exit;
    end;

    //TODO: Guru: Is this dead code? Why are you checking for a wxDialog when your IF states that
    //            this part will be executed when it's a wxFrame?
    if TWinControl(AControlClass.NewInstance).GetInterface(IID_IWxToolBarInsertableInterface, tlbrInterface) then
    begin
      if not (StrContainsU(AParent.ClassName,'TWxToolBar')) and
        not (TWinControl(AControlClass.NewInstance).GetInterface(IID_IWxToolBarNonInsertableInterface,nontlbrInterface)) then
      begin
        ShowErrorAndReset('You cannot insert Toolbar control in Dialog. Use Toolbar only in wxFrame.');
        Exit;
      end;
    end
    else
    begin
      if (not strContainsU(AParent.ClassName, 'TFrmNewForm')) and
        (AParent.Parent <> nil) and (StrContainsU(AParent.Parent.ClassName,'TWxToolBar')) then
      begin
        ShowErrorAndReset('You cannot insert this control in a toolbar');
        Exit;
      end;

      if StrContainsU(AParent.ClassName, 'TWxToolBar') then
      begin
        ShowErrorAndReset('You cannot insert this control in a toolbar');
        Exit;
      end;
    end;

  end
  else
  begin
    if TWinControl(AControlClass.NewInstance).GetInterface(IID_IWxDialogNonInsertableInterface,dlgInterface) then
    begin
      ShowErrorAndReset('This control cannot be used in dialogs.');
      Exit;
    end;

    if StrContainsU(ComponentPalette.SelectedComponent, 'TWxStdDialogButtonSizer') then
    begin
      if not isSizerAvailable(ELDesigner1.DesignControl) then
      begin
        ShowErrorAndReset('wxStdDialogButtonSizers need a parent sizer to attach to.'#13#10#13#10 +
          'Insert a wxBoxSizer onto the wxDialog before inserting the wxStdDialogButtonSizer.');
        Exit;
      end;
      
      for I := 0 to ELDesigner1.DesignControl.ComponentCount - 1 do
        if ELDesigner1.DesignControl.Components[i] is TWxSizerPanel then
          AParent := ELDesigner1.DesignControl.Components[i] as TWinControl;
    end;
  end;

  if TWinControl(AControlClass.NewInstance) is TWxSizerPanel and not StrContainsU(AParent.ClassName, 'TWxPanel') then
  begin
    if (ELDesigner1.DesignControl.ComponentCount - GetNonVisualComponentCount(TForm(ELDesigner1.DesignControl))) > 0 then
    begin
      if isSizerAvailable(ELDesigner1.DesignControl) = false then
      begin
        if GetNonAllowAbleControlCountForFrame(ELDesigner1.DesignControl) > 0 then
        begin
          ShowErrorAndReset('You cannot add a sizer if you have other controls.'#13#10#13#10 +
            'Please remove all the controls before adding a sizer.');
          Exit;
        end;
      end;
    end;
  end;

  PreviousComponent := nil;
  if TWinControl(AControlClass.NewInstance) is TWxNoteBookPage then
  begin
    if ELDesigner1.SelectedControls.count = 0 then
    begin
      ShowErrorAndReset('Please select a Notebook and drop the page.');
      Exit;
    end;

    PreviousComponent:=ELDesigner1.SelectedControls[0];
    if (ELDesigner1.SelectedControls[0] is TWxNoteBookPage) then
    begin
      PreviousComponent:=ELDesigner1.SelectedControls[0].Parent;
      Exit;
    end;

    if not (ELDesigner1.SelectedControls[0] is TWxNoteBook) then
    begin
      ShowErrorAndReset('Please select a Notebook and drop the page.');
      Exit;
    end;
  end;

  /// Fix for Bug Report #1060562
  if TWinControl(AControlClass.NewInstance) is TWxToolButton then
  begin
    if ELDesigner1.SelectedControls.count = 0 then
    begin
      ShowErrorAndReset('Please select the Toolbar before dropping this control.');
      Exit;
    end;

    PreviousComponent:=ELDesigner1.SelectedControls[0];
    if (ELDesigner1.SelectedControls[0] is TWxToolBar) then
    begin
      PreviousComponent:=ELDesigner1.SelectedControls[0].Parent;
      Exit;
    end;

    if not (ELDesigner1.SelectedControls[0] is TWxToolBar) then
    begin
      ShowErrorAndReset('Please select the Toolbar before dropping this control.');
      Exit;
    end;
  end;

  if TControl(AControlClass.NewInstance) is TWxSeparator then
  begin
    if ELDesigner1.SelectedControls.count = 0 then
    begin
      ShowErrorAndReset('Please select the Toolbar before dropping this control.');
      Exit;
    end;

    PreviousComponent:=ELDesigner1.SelectedControls[0];
    if (ELDesigner1.SelectedControls[0] is TWxToolBar) then
    begin
      PreviousComponent:=ELDesigner1.SelectedControls[0].Parent;
      Exit;
    end;

    if not (ELDesigner1.SelectedControls[0] is TWxToolBar) then
    begin
      ShowErrorAndReset('Please select the Toolbar before dropping this control.');
      Exit;
    end;
  end;
end;

procedure TMainForm.ELDesigner1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Shift = [ssCtrl] then
  begin
    if (Key = Ord('C')) then
      ELDesigner1.Copy;
    if (Key = Ord('X')) then
      ELDesigner1.Cut;
    if (Key = Ord('V')) then
      ELDesigner1.Paste;
  end;

end;

procedure TMainForm.ELDesigner1Modified(Sender: TObject);
var
  e: TEditor;
begin
  if not DisablePropertyBuilding then
    ELDesigner1ChangeSelection(Sender);
  JvInspProperties.RefreshValues;
  e := GetEditor(Self.PageControl.ActivePageIndex);
  if Assigned(e) then
    e.UpdateDesignerData;
end;

procedure TMainForm.BuildProperties(Comp: TControl;boolForce:Boolean);
var
  strValue:String;
  strSelName,strCompName:String;
begin
  if not boolForce then
  begin
    if DisablePropertyBuilding = true then
      Exit;
    if Assigned(SelectedComponent) then
      strSelName := SelectedComponent.Name;
    if Assigned(comp) then
      strCompName := comp.Name;

    PreviousStringValue := '';
    if AnsiSameText(strSelName,strCompName) then
    begin
      SelectedComponent := Comp;
      Exit;
    end;

    if FirstComponentBeingDeleted = Comp.Name then
      Exit;
  end;

  if Comp = nil then
    Exit;

  SelectedComponent := Comp;

  if JvInspProperties.Root <> nil then
    if JvInspProperties.Root.Data <> nil then
{$IFNDEF PRIVATE_BUILD}
      try
{$ENDIF}
        strValue:=TWinControl(TJvInspectorPropData(JvInspProperties.Root.Data).Instance).Name;
{$IFNDEF PRIVATE_BUILD}
      except
        Exit;
      end;
{$ENDIF}

  //Populate the properties list
  JvInspProperties.BeginUpdate;
  JvInspProperties.Root.Clear;
  TJvInspectorPropData.New(JvInspProperties.Root, Comp);
  JvInspProperties.EndUpdate;

  //And the events list
  JvInspEvents.BeginUpdate;
  JvInspEvents.Root.Clear;
  TJvInspectorPropData.New(JvInspEvents.Root, Comp);
  JvInspEvents.EndUpdate;
end;

procedure TMainForm.BuildComponentList(Designer: TfrmNewForm);
var
  i: Integer;
  intControlMaxValue: Integer;
  wxcompInterface: IWxComponentInterface;
begin

  intControlMaxValue := -1;
  cbxControlsx.Clear;
  cbxControlsx.Items.BeginUpdate;

  cbxControlsx.AddItem(Designer.Wx_Name + ':' + Trim(Designer.Wx_Class),
    Designer);
  for I := 0 to Designer.ComponentCount - 1 do // Iterate
  begin
    if Designer.Components[i].GetInterface(IID_IWxComponentInterface,
      wxcompInterface) then
    begin
      cbxControlsx.AddItem(Designer.Components[i].Name + ':' +
        wxcompInterface.GetWxClassName, Designer.Components[i]);
      if wxcompInterface.GetIDValue > intControlMaxValue then
      begin
        intControlMaxValue := wxcompInterface.GetIDValue;
      end;
    end;
  end; // for

  cbxControlsx.Items.EndUpdate;

  if intControlMaxValue = -1 then
    intControlMaxValue := 1000;

  intControlCount := intControlMaxValue;

  if cbxControlsx.Items.Count > 0 then
    cbxControlsx.ItemIndex := 0;

end;

procedure TMainForm.JvInspPropertiesAfterItemCreate(Sender: TObject; Item: TJvCustomInspectorItem);
var
  I: Integer;
  StrCompName, StrCompCaption: string;
  boolOk: Boolean;
  strLst: TStringList;
  strTemp: string;
  wxcompInterface: IWxComponentInterface;
begin
  boolOk := False;
  if SelectedComponent  = nil then
    Exit;

  if not Assigned(Item) then
    Exit;

  if SelectedComponent <> nil then
  begin
    if IsValidClass(SelectedComponent) then
    begin
      strTemp := SelectedComponent.ClassName;
      if SelectedComponent.GetInterface(IID_IWxComponentInterface,wxcompInterface) then
        strLst := wxcompInterface.GetPropertyList
      else
        strLst := nil;

{$IFNDEF PRIVATE_BUILD}
      try
{$ENDIF}
        if strLst <> nil then
        begin
          if strLst.Count > 0 then
            strLst[0]:=strLst[0];
        end
        else
          Exit;
{$IFNDEF PRIVATE_BUILD}
      except
        Exit;
      end;
{$ENDIF}

      //Populate the std wx Ids for the ID_Name selection
      if AnsiSameText('Wx_IDName', trim(Item.DisplayName)) then
      begin
        Item.Flags := Item.Flags + [iifValueList, iifAllowNonListValues];
        Item.OnGetValueList := OnStdWxIDListPopup;
      end;

      for I := 0 to strLst.Count - 1 do // Iterate
      begin
        StrCompName := trim(ExtractComponentPropertyName(strLst[i]));
        StrCompCaption := trim(ExtractComponentPropertyCaption(strLst[i]));
        if AnsiSameText(StrCompName, trim(Item.DisplayName)) then
        begin
          if AnsiSameText(Item.Data.TypeInfo.Name, 'TCaption') then
            Item.Flags := Item.Flags  - [iifMultiLine];
          if AnsiSameText(Item.Data.TypeInfo.Name, 'TPicture') then
            Item.Flags := Item.Flags + [iifEditButton];
          if AnsiSameText(Item.Data.TypeInfo.Name, 'TListItems') then
            Item.Flags := Item.Flags + [iifEditButton];
          if AnsiSameText(Item.Data.TypeInfo.Name, 'TTreeNodes') then
            Item.Flags := Item.Flags + [iifEditButton];
          
          Item.DisplayName := StrCompCaption;
          boolOk := true;
          Break;
        end;
      end; // for
    end;
  end;
  Item.Hidden := not boolOk;
end;

function TMainForm.GetCurrentFileName:string;
var
  e: TEditor;
begin
  e := GetEditor(PageControl.ActivePageIndex);
  if assigned(e) then
    Result :=e.FileName
  else
    Result :='';
end;

function TMainForm.GetCurrentClassName:string;
var
  e: TEditor;
begin
  e := GetEditor(PageControl.ActivePageIndex);
  if assigned(e) then
    Result :=trim(e.GetDesigner().Wx_Name)
  else
    Result :='';
end;

procedure TMainForm.GetFunctionList(strClassName:String;fncList:TStringList);
begin
//
end;

procedure TMainForm.JvInspPropertiesDataValueChanged(Sender: TObject;
  Data: TJvCustomInspectorData);
var
  idxName: Integer;
  comp: TComponent;
  wxcompInterface: IWxComponentInterface;
  strValue,strDirName: string;
  e: TEditor;
  cppStrLst,hppStrLst:TStringList;
begin
  if JvInspProperties.Selected <> nil then
  begin
    if Assigned(JvInspProperties.Selected.Data) then
    begin
        strValue:=JvInspProperties.Selected.Data.TypeInfo.Name;
        if (UpperCase(strValue) = UpperCase('TPicture')) or
           (UpperCase(strvalue) = UpperCase('TComponentName')) then
        begin
            e := GetEditor(PageControl.ActivePageIndex);
            strValue:=TJvInspectorPropData(JvInspProperties.Selected.Data).Instance.ClassName;
            if Assigned(e) then
            begin
                if UpperCase(SelectedComponent.ClassName) = UpperCase('TFrmNewForm') then
                    GenerateXPMDirectly(TFrmNewForm(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Wx_ICON.Bitmap,e.GetDesigner.Wx_Name,'Self',e.FileName);

                if UpperCase(SelectedComponent.ClassName) = UpperCase('TWxStaticBitmap') then
                    GenerateXPMDirectly(TWxStaticBitmap(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Picture.Bitmap,SelectedComponent.Name,e.GetDesigner.Wx_Name,e.FileName);

                if UpperCase(SelectedComponent.ClassName) = UpperCase('TWxBitmapButton') then
                    GenerateXPMDirectly(TWxBitmapButton(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Wx_Bitmap.Bitmap,SelectedComponent.Name,e.GetDesigner.Wx_Name,e.FileName);

                if UpperCase(SelectedComponent.ClassName) = UpperCase('TWxToolButton') then
                    GenerateXPMDirectly(TWxToolButton(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Wx_Bitmap.Bitmap,SelectedComponent.Name,e.GetDesigner.Wx_Name,e.FileName);
            end;
        end;
    end;

    if UpperCase(Trim(JvInspProperties.Selected.DisplayName)) = UpperCase('NAME') then
    begin
        if not ClassBrowser1.Enabled then
        begin
            //MessageDlg('Class Browser is not enabled.'+#13+#10+''+#13+#10+'Class Names in the sources are not Changed', mtWarning, [mbOK], 0);
           // if Assigned(JvInspProperties.Selected.Data) and (Trim(PreviousStringValue) <> '') then
           //     JvInspProperties.Selected.Data.AsString:=PreviousStringValue;
            Exit;
        end;

      comp := Self.SelectedComponent;
      idxName := cbxControlsx.Items.IndexOfObject(comp);
      if idxName <> -1 then
      begin
        if comp is TfrmNewForm then
        begin
          if comp.GetInterface(IID_IWxComponentInterface, wxcompInterface) then
          begin

            if AnsiSameText('ID_'+PreviousComponentName,wxcompInterface.GetIDName()) then
            begin
                wxcompInterface.SetIDName(UpperCase('ID_'+comp.Name));
            end;

            cbxControlsx.Items[idxName] := TfrmNewForm(comp).Wx_Name + ':' + wxcompInterface.GetWxClassName;
            cbxControlsx.ItemIndex := idxName;
            //Update the ClassName using PreviousStringValue
            e := GetEditor(PageControl.ActivePageIndex);
            if Assigned(e) then
            begin
                hppStrLst:=TStringList.Create;
                cppStrLst:=TStringList.Create;
                hppStrLst.Duplicates:=dupIgnore;
                cppStrLst.Duplicates:=dupIgnore;                
                try
                    GetClassNameLocationsInEditorFiles(hppStrLst,cppStrLst,ChangeFileExt(e.FileName, CPP_EXT), PreviousStringValue, TfrmNewForm(comp).Wx_Name);
                    ReplaceClassNameInEditor(hppStrLst,e.GetDesignerHPPEditor,PreviousStringValue, TfrmNewForm(comp).Wx_Name);
                    ReplaceClassNameInEditor(cppStrLst,e.GetDesignerCPPEditor,PreviousStringValue, TfrmNewForm(comp).Wx_Name);
                    if ((hppStrLst.count = 0) and (cppStrLst.count = 0)) then
                        MessageDlg('Unable to get Class Information. Please rename the class name in H/CPP files manually. If you dont rename it them, then the Designer wont work. ', mtWarning, [mbOK], 0)
                    Else
                    begin
                        MessageDlg('Contructor Function(in Header) or Sometimes all the Functions(in Source)  might not be renamed. '+#13+#10+''+#13+#10+'Please rename them manually.'+#13+#10+''+#13+#10+'We hope to fix this bug asap.'+#13+#10+'Sorry for the trouble.', mtInformation, [mbOK], 0);
                        strDirName:=IncludeTrailingBackslash(ExtractFileDir(e.FileName));
                        RenameFile(strDirName+'\'+'Self_'+PreviousStringValue+'_XPM.xpm',strDirName+'\'+'Self_'+TfrmNewForm(comp).Wx_Name+'_XPM.xpm');
                        GenerateXPM(e.GetDesigner,e.FileName,true);
                    end;
                finally
                    hppStrLst.Destroy;
                    cppStrLst.Destroy;
                end;
            end;
          end
          else
          begin
            MessageDlg('Some problem !!!', mtWarning, [mbOK], 0);
          end;
        end
        else
        begin
          if comp.GetInterface(IID_IWxComponentInterface, wxcompInterface) then
          begin
            if AnsiSameText('ID_'+PreviousComponentName,wxcompInterface.GetIDName()) then
            begin
                wxcompInterface.SetIDName(UpperCase('ID_'+comp.Name));
            end;
            cbxControlsx.Items[idxName] := comp.Name + ':' + wxcompInterface.GetWxClassName;
            cbxControlsx.ItemIndex := idxName;
          end;
        end;
      end;
    end;
    UpdateDefaultFormContent;
  end;
end;

procedure TMainForm.JvInspEventsAfterItemCreate(Sender: TObject;
  Item: TJvCustomInspectorItem);
var
  I: Integer;
  StrCompName, StrCompCaption: string;
  boolOk: Boolean;
  strLst: TStringList;
  strTemp: string;
  wxcompInterface: IWxComponentInterface;
begin
  boolOk := false;
  Item.Hidden := true;

  if SelectedComponent <> nil then
  begin
    if IsValidClass(SelectedComponent) then
    begin
      strTemp := SelectedComponent.ClassName;
      if SelectedComponent.GetInterface(IID_IWxComponentInterface,
        wxcompInterface) then
        strLst := wxcompInterface.GetEventList
      else
        strLst := nil;

      if strLst = nil then
        exit;
      try
        if strLst.Count > 0 then
            strLst[0]:=strLst[0];
      Except
        Exit;
      end;

      for I := 0 to strLst.Count - 1 do // Iterate
      begin
        StrCompName := trim(ExtractComponentPropertyName(strLst[i]));
        StrCompCaption := trim(ExtractComponentPropertyCaption(strLst[i]));
        if AnsiSameText(StrCompName, trim(Item.DisplayName)) then
        begin
          Item.DisplayName := StrCompCaption;
          Item.Flags := Item.Flags + [iifValueList, iifAllowNonListValues];
          Item.OnGetValueList := OnEventPopup;
          boolOk := true;
          break;
        end;
      end; // for
    end;

  end;

  //  if Item is TJvInspectorBooleanItem then
  //    TJvInspectorBooleanItem(Item).ShowAsCheckbox := True;

  Item.Hidden := not boolOk;
  //Item.Hidden:= false;
end;

function TMainForm.isCurrentPageDesigner: Boolean;
var
  e: TEditor;
  wx: TfrmNewForm;
begin
  Result := False;
  e := GetEditor(PageControl.ActivePageIndex);

  if not Assigned(e) then
    Exit;

  if e.isForm then
    wx := e.GetDesigner()
  else
    Exit;

  if not Assigned(wx) then
    Result := false
  else
    Result := True;
end;

function TMainForm.LocateFunction(strFunctionName:String):boolean;
begin
   Result := False;
end;

function TMainForm.GetCurrentDesignerForm: TfrmNewForm;
var
  e: TEditor;
begin
  Result := nil;

  e := GetEditor(PageControl.ActivePageIndex);

  if not Assigned(e) then
    Exit;

  if e.isForm then
    Result := e.GetDesigner();
end;

procedure TMainForm.JvInspEventsDataValueChanged(Sender: TObject;
  Data: TJvCustomInspectorData);
var
  str,ErrorString: string;
  e: TEditor;
  boolIsFilesDirty: Boolean;
  componentInstance:TComponent;
  propertyName,wxClassName,propDisplayName:string;
  strNewValue:String;
  bOpenFile:Boolean;

  procedure SetPropertyValue(Comp: TComponent; strPropName, strPropValue: String);
  var
    PropInfo: PPropInfo;
  begin
    { Get info record for Enabled property }
    PropInfo := GetPropInfo(Comp.ClassInfo, strPropName);
    { If property exists, set value to False }
    if Assigned(PropInfo) then
      SetStrProp(Comp, PropInfo, strPropValue);
  end;
begin
  bOpenFile := False;
  fstrCppFileToOpen := '';
  try
    //Do some sanity checks
    if (JvInspEvents.Selected = nil) or (not JvInspEvents.Selected.Visible) then
      Exit;
    e := GetEditor(PageControl.ActivePage.TabIndex);
    if (not Assigned(e)) or (not e.isForm) then
      Exit;

    //Then get the value as a string
    strNewValue := Data.AsString;

    //See we have to do with our new value
    if strNewValue = '<Add New Function>' then
    begin
      if not ClassBrowser1.Enabled then
      begin
        MessageDlg('The Class Browser is not enabled; wxDev-C++ will be unable to' +
          'create an event handler for you.'#10#10'Please see Help for instructions ' +
          'on enabling the Class Browser', mtWarning, [mbOK], Handle);
        JvInspEvents.OnDataValueChanged:=nil;
        Data.AsString := '';
        JvInspEvents.OnDataValueChanged:=JvInspEventsDataValueChanged;
        Exit;
      end;

      boolIsFilesDirty := false;
      if e.IsDesignerHPPOpened then
        boolIsFilesDirty := e.GetDesignerHPPEditor.Modified;

      if not boolIsFilesDirty then
        if e.IsDesignerCPPOpened then
          boolIsFilesDirty := e.GetDesignerCPPEditor.Modified;

      if boolIsFilesDirty then
      begin
        if e.IsDesignerHPPOpened then
          //This wont open a new editor window
          SaveFile(e.GetDesignerHPPEditor);

        if e.IsDesignerCPPOpened then
          //This wont open a new editor window
          SaveFile(e.GetDesignerCPPEditor);
      end;

      //TODO: Guru: add code to make sure the files are saved properly
      if SelectedComponent <> nil then
      begin
        str := JvInspEvents.Selected.DisplayName;

        if SelectedComponent is TfrmNewForm then
          str := TfrmNewForm(SelectedComponent).Wx_Name + Copy(str, 3, Length(str))
        else
          str := SelectedComponent.Name + Copy(str, 3, Length(str));
        JvInspEvents.OnDataValueChanged:=nil;
        Data.AsString := str;
        JvInspEvents.OnDataValueChanged:=JvInspEventsDataValueChanged;
        str := Trim(str);

        componentInstance:=SelectedComponent;
        propertyName:=Data.Name;
        wxClassName:=Trim(e.getDesigner().Wx_Name);
        propDisplayName:=JvInspEvents.Selected.DisplayName;
        if CreateFunctionInEditor(Data,wxClassName,SelectedComponent, str,propDisplayName,ErrorString) then
        begin
           bOpenFile:=true;
          //This is causing AV, so I moved this operation to
          //CreateFunctionInEditor
          //Data.AsString := str;
          SetPropertyValue(componentInstance,propertyName,str);
          JvInspEvents.OnDataValueChanged:=nil;
          Data.AsString := str;
          //JvInspEvents.Root.DoneEdit(true);
          JvInspEvents.OnDataValueChanged:=JvInspEventsDataValueChanged;
          fstrCppFileToOpen:=e.GetDesignerCPPEditor.FileName;
        end
        else
        begin
          Data.AsString := '';
          if ErrorString = '' then
            MessageDlg('Unable to add function', mtError, [mbOK], 0)
          else
            MessageDlg(ErrorString, mtError, [mbOK], 0);
        end;
      end;
    end
    else if strNewValue = '<Goto Function>' then
    begin
      //Reset the value, we won't need the <Goto> value anymore
      Data.AsString := strGlobalCurrentFunction;
      strGlobalCurrentFunction := '';

      if not ClassBrowser1.Enabled then
      begin
        MessageDlg('The Class Browser has been disabled; All event handling ' +
          'automation code will not work.'#10#10'See Help for instructions on ' +
          'enabling the Class Browser.', mtError, [mbOK], 0);
        Exit;
      end;

      if e.IsDesignerHPPOpened then
        if e.GetDesignerHPPEditor.Modified then
          SaveFile(e.GetDesignerHPPEditor);

      if e.IsDesignerCPPOpened then
        if e.GetDesignerCPPEditor.Modified then
          SaveFile(e.GetDesignerCPPEditor);
      
      if SelectedComponent <> nil then
      begin
        str := trim(Data.AsString);
        LocateFunctionInEditor(Data,Trim(e.getDesigner().Wx_Name),SelectedComponent, str, JvInspEvents.Selected.DisplayName);
        fstrCppFileToOpen:=e.GetDesignerCPPEditor.FileName;
        bOpenFile:=true;
      end;
    end
    else if strNewValue = '<Remove Function>' then
      Data.AsString := '';

    JvInspEvents.Root.DoneEdit(true);
    UpdateDefaultFormContent;
  except
    on E: Exception do
      MessageBox(Handle, PChar(E.Message), PChar(Application.Title), MB_ICONERROR or MB_OK or MB_TASKMODAL);
  end;

  if bOpenFile then
  begin
    tmrInspectorHelper.OnTimer:=tmrInspectorHelperTimer;
    tmrInspectorHelper.Enabled:=true;
  end;
end;

procedure TMainForm.JvInspEventsItemValueChanged(Sender: TObject;
  Item: TJvCustomInspectorItem);
begin
  if JvInspEvents.Selected = nil then
    Exit;

  if JvInspEvents.Selected.Visible = False then
    Exit;
end;

procedure TMainForm.OnStdWxIDListPopup(Item: TJvCustomInspectorItem; Value: TStrings);
begin
    Value.Clear;
    Value.Assign(strStdwxIDList);
end;

procedure TMainForm.OnEventPopup(Item: TJvCustomInspectorItem; Value: TStrings);
var
  boolNoFunction: Boolean;
  strPrevvalue: string;
  strClassesLst: TStringList;
  idx:Integer;
begin
  strGlobalCurrentFunction:='';
  if not isCurrentPageDesigner then
    Exit;

  strPrevvalue := Item.Data.AsString;
  if Trim(strPrevvalue) = '' then
    boolNoFunction := true
  else
    boolNoFunction := false;

  Value.Clear;
  if boolNoFunction then
  begin
    Value.Add('<Add New Function>');
    strClassesLst := TStringList.Create;
    try
      strClassesLst.Sorted := True;
      GetFunctionsFromSource(GetCurrentDesignerForm().Wx_Name, strClassesLst);
      Value.AddStrings(strClassesLst);
    finally
      strClassesLst.Destroy;
    end;
  end;

  if Trim(strPrevvalue) <> '' then
  begin
    //Add other functions here...
    strClassesLst := TStringList.Create;
    try
      strClassesLst.Sorted := True;
      GetFunctionsFromSource(GetCurrentDesignerForm().Wx_Name, strClassesLst);
      Value.AddStrings(strClassesLst);
    finally
      strClassesLst.Destroy;
    end;
    //if Function list is not available in CPPParser
    idx:=Value.IndexOf(strPrevvalue);
    if idx = -1 then
    begin
        Value.Add(strPrevvalue);
        idx:=Value.IndexOf(strPrevvalue);
    end;

    if idx <> -1 then
    begin
        Value.Insert(idx+1,'<Goto Function>');
        strGlobalCurrentFunction:=strPrevvalue;
    end;

    Value.Add('<Remove Function>');

    strPrevvalue := Item.Parent.ClassName;
    strPrevvalue := Item.Parent.ClassName;
  end;

end;

function TMainForm.LocateFunctionInEditor(eventProperty:TJvCustomInspectorData;strClassName: string; SelComponent:TComponent; var strFunctionName: string; strEventFullName: string): Boolean;

  function isFunctionAvailableInEditor(intClassID: Integer; strFunctionName: String;
    var intLineNum: Integer; var strFname: String): boolean;
  var
    i:Integer;
    St2 : PStatement;
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
        strFname:=St2._DeclImplFileName;
        intLineNum:=St2._DeclImplLine;
        Result := True;
        Break;
      end;
    end; // for
  end;
var
  strOldFunctionName:string;
  strFname:String;
  intLineNum:Integer;
  I: integer;
  St: PStatement;
  boolFound: Boolean;
  e: TEditor;
begin
  Result := False;
  boolFound := False;
  intLineNum := 0;
  St := nil;
  
  e := GetEditor(Self.PageControl.ActivePageIndex);
  if (not Assigned(e)) or (not e.isForm) then
    Exit;

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
    
  if not boolFound then
    Exit;

  strOldFunctionName := strFunctionName;
  if isFunctionAvailableInEditor(St._ID, strOldFunctionName, intLineNum, strFname) then
  begin
    boolInspectorDataClear := False;
    OpenFile(strFname);
    e := GetEditorFromFileName(strFname);
    if assigned(e) then
    begin
      //TODO: check for a valid line number
      e.Text.CaretX := 0;
      e.Text.CaretY := intLineNum;
    end;
    boolInspectorDataClear := False;
  end;
end;

function TMainForm.isCurrentFormFilesNeedToBeSaved:Boolean;
var
    e,eTemp:TEditor;

begin
    Result:=false;
    e:=GetEditor(PageControl.ActivePageIndex);
    if not assigned(e) then
    begin
        Exit;
    end;

    if not e.isForm then
    begin
        Exit;
    end;

    if not assigned(e) then
    begin
        MessageDlg('Unable to Get the Designer Info.', mtError, [mbOK], 0);
        Exit;
    end;
    eTemp:=e.GetDesignerHPPEditor;
    if not assigned(eTemp) then
    begin
        MessageDlg('Unable to Get Header File Editor Info.', mtError, [mbOK], 0);
        Exit;
    end;
    
    eTemp:=e.GetDesignerCPPEditor;
    if not assigned(eTemp) then
    begin
        MessageDlg('Unable to Get Source File Editor Info.', mtError, [mbOK], 0);
        Exit;
    end;
    if ( (e.Modified = true) or (e.GetDesignerHPPEditor.Modified = true) or (e.GetDesignerCPPEditor.Modified) ) then
        Result:=true
    else
        Result:=false;


end;

function TMainForm.saveCurrentFormFiles:Boolean;
var
    e:TEditor;
begin
    Result:=false;
    e:=GetEditor(PageControl.ActivePageIndex);
    if not assigned(e) then
    begin
        Exit;
    end;

    if not e.isForm then
    begin
        Exit;
    end;
    
    Result:=true;
    if e.Modified then
        SaveFile(e);

    if e.IsDesignerHPPOpened then
    begin
        if e.GetDesignerHPPEditor.Modified then
            SaveFile(e.GetDesignerHPPEditor);
    end;

    if e.IsDesignerCPPOpened then
    begin
        if e.GetDesignerCPPEditor.Modified then
            SaveFile(e.GetDesignerCPPEditor);
    end;
end;

function TMainForm.isFunctionAvailable(intClassID:Integer;strFunctionName:String):boolean;
var
    i:Integer;
    St2 : PStatement;
begin
  Result:=False;

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

function TMainForm.CreateFunctionInEditor(var strFncName:string;strReturnType,strParameter :String;var ErrorString:String):boolean;
var
  intFunctionCounter:Integer;
  strOldFunctionName:string;
  I: integer;
  Line: integer;
  AddScopeStr: boolean;
  S: string;
  VarName: string;
  VarType: string;
  VarArguments: string;
  St: PStatement;
  ClsName : string;
  boolFound: Boolean;
  e: TEditor;
  CppEditor, Hppeditor: TSynEdit;
  strClassName:String;
begin

    Result:=false;
    boolFound := false;
    St := nil;
    
    e:=self.GetEditor(self.PageControl.ActivePageIndex);
    if not Assigned(e) then
        Exit;

    if not e.isForm then
        Exit;

  strClassName:=trim(e.GetDesigner.Wx_Name);

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

  if boolFound = False then
  begin
    Exit;
  end;

  intFunctionCounter:=0;
  strOldFunctionName:=strFncName;
  repeat
    if intFunctionCounter = 0 then
        strFncName:=strOldFunctionName
    else
        strFncName:=strOldFunctionName+IntToStr(intFunctionCounter);
    Inc(intFunctionCounter);
  until isFunctionAvailable(St._ID,strFncName) = false;

  //Temp Settings Start
  VarType := strReturnType;
  VarArguments := strParameter;

  if trim(VarType) = '' then
    VarType := 'void';

  if trim(VarArguments) = '' then
    VarArguments := 'void';

  VarName := strFncName;
  //Temp Settings End

  Line := ClassBrowser1.Parser.SuggestMemberInsertionLine(St._ID, scsPublic, AddScopeStr);
  if Line = -1 then
  begin
    Exit;
  end;

  S := #9;
  S := S + VarType + ' ' + VarName + '(' + VarArguments + ')';
  S := S + ';';

  Hppeditor := e.GetDesignerHPPText;

  CppEditor := e.GetDesignerCPPText;

  if Assigned(Hppeditor) then
  begin
      if AnsiStartsText('////GUI Control Declaration End',trim(Hppeditor.Lines[Line])) then
        Line:=Line+1;

    Hppeditor.Lines.Insert(Line, S);
    if AddScopeStr then
      Hppeditor.Lines.Insert(Line, #9'public:');
    e.GetDesignerHPPEditor.InsertString('', true);
  end;

  // set the parent class's name
  ClsName := strClassName;

  if Assigned(cppeditor) then
  begin
    // insert the implementation
    if Trim(CppEditor.Lines[CppEditor.Lines.Count - 1]) <> '' then
      CppEditor.Lines.Append('');

    // insert the comment
    CppEditor.Lines.Append('/*');
    Cppeditor.Lines.Append(' * ' + strFncName);
    Cppeditor.Lines.Append(' */');

    Cppeditor.Lines.Append(VarType + ' ' + ClsName + '::' + VarName + '(' +
      VarArguments + ')');
    Cppeditor.Lines.Append('{');
    Cppeditor.Lines.Append(#9'// insert your code here');
    if not AnsiSameText(trim(VarArguments),'void') then
    //Cppeditor.Lines.Append(#9'event.Skip();  // IMPORTANT: Remove this line when you add your own code!');
    Line := CppEditor.Lines.Count;

    Cppeditor.Lines.Append('}');
    Cppeditor.Lines.Append('');
    Result := True;
    CppEditor.CaretY := Line;
    e.GetDesignerCPPEditor.InsertString('', true);
    e.UpdateDesignerData;
  end;

end;

function TMainForm.CreateFunctionInEditor(eventProperty:TJvCustomInspectorData;strClassName: string; SelComponent:TComponent; var strFunctionName: string; strEventFullName: string;var ErrorString:String): Boolean;
var
  intFunctionCounter:Integer;
  strOldFunctionName:string;
  I: integer;
  Line: integer;
  AddScopeStr: boolean;
  S: string;
  VarName: string;
  VarType: string;
  VarArguments: string;
  St: PStatement;
  ClsName, strEName: string;
  boolFound: Boolean;
  intfObj: IWxComponentInterface;
  e: TEditor;
  CppEditor, Hppeditor: TSynEdit;
begin
  St := nil;
  Result := False;
  boolFound := False;
  e := GetEditor(Self.PageControl.ActivePageIndex);

  if not Assigned(e) then
    Exit;

  if not e.isForm then
    Exit;

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

  if boolFound = False then
  begin
    ErrorString :='Class Name not found in the Class Browser.' + #13+#10+' Try to reset the class parser option and try again';
    Exit;
  end;

  intFunctionCounter:=0;
  strOldFunctionName:=strFunctionName;
  repeat
    if intFunctionCounter = 0 then
        strFunctionName:=strOldFunctionName
    else
        strFunctionName:=strOldFunctionName+IntToStr(intFunctionCounter);
    Inc(intFunctionCounter);
  until isFunctionAvailable(St._ID,strFunctionName) = false;

  //Temp Settings Start
  VarType := 'void';
  VarArguments := VarType;

  if SelComponent.GetInterface(IID_IWxComponentInterface, intfObj) then
  begin
    strEName := Trim(GetEventNameFromDisplayName(strEventFullName,
      intfObj.GetEventList));
    VarType := intfObj.GetTypeFromEventName(strEName);
    VarArguments := intfObj.GetParameterFromEventName(strEName);
   end;

  if trim(VarType) = '' then
    VarType := 'void';

  if trim(VarArguments) = '' then
    VarArguments := 'void';

  VarName := strFunctionName;
  //Temp Settings End

  Line := ClassBrowser1.Parser.SuggestMemberInsertionLine(St._ID, scsPublic,
    AddScopeStr);
  if Line = -1 then
  begin
    Exit;
  end;

  S := #9#9;
  S := S + VarType + ' ' + VarName + '(' + VarArguments + ')';
  S := S + ';';
  boolInspectorDataClear:=False;
  Hppeditor := e.GetDesignerHPPText;

  boolInspectorDataClear:=False;
  CppEditor := e.GetDesignerCPPText;

  if Assigned(Hppeditor) then
  begin
      if AnsiStartsText('////GUI Control Declaration End',trim(Hppeditor.Lines[Line])) then
        Line:=Line+1;

    Hppeditor.Lines.Insert(Line, S);
    if AddScopeStr then
      Hppeditor.Lines.Insert(Line, #9'public:');
    e.GetDesignerHPPEditor.InsertString('', true);
  end;

  // set the parent class's name
  ClsName := strClassName;

  if Assigned(cppeditor) then
  begin
    boolInspectorDataClear:=False;
    // insert the implementation
    if Trim(CppEditor.Lines[CppEditor.Lines.Count - 1]) <> '' then
      CppEditor.Lines.Append('');

    // insert the comment
    CppEditor.Lines.Append('/*');
    Cppeditor.Lines.Append(' * ' + strFunctionName);
    Cppeditor.Lines.Append(' */');

    Cppeditor.Lines.Append(VarType + ' ' + ClsName + '::' + VarName + '(' +
      VarArguments + ')');
    Cppeditor.Lines.Append('{');
    Cppeditor.Lines.Append(#9'// insert your code here');
    if not AnsiSameText(trim(VarArguments),'void') then
    //Cppeditor.Lines.Append(#9'event.Skip();  // IMPORTANT: Remove this line when you add your own code!');
    Line := CppEditor.Lines.Count;

    Cppeditor.Lines.Append('}');
    Cppeditor.Lines.Append('');
    Result := True;
    CppEditor.CaretY := Line;
    e.GetDesignerCPPEditor.InsertString('', true);

    boolInspectorDataClear:=False;
    //OpenFile(e.GetDesignerCPPFileName);
    boolInspectorDataClear:=False;
    e.UpdateDesignerData;
    boolInspectorDataClear:=False;
  end;

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
  if not isCurrentPageDesigner then
    Exit;

  classname:=trim(classname);

  //CppParser1.GetClassesList(TStrings());
  for i := 0 to CppParser1.Statements.Count - 1 do
  begin
    if PStatement(CppParser1.Statements[i])._Kind = skFunction then
    begin
      strParserClassName := PStatement(CppParser1.Statements[i])._ScopeCmd;
      intColon := Pos('::', strParserClassName);
      if intColon <> 0 then
      begin
        strParserClassName := Copy(strParserClassName, 0, intColon - 1);
      end
      else
        Continue;

      strParserFunctionName := PStatement(CppParser1.Statements[i])._FullText;
      _ScopelessCmd := PStatement(CppParser1.Statements[i])._ScopelessCmd;

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

procedure TMainForm.UpdateDefaultFormContent;
var
  e: TEditor;
begin
  e := GetEditor(PageControl.ActivePageIndex);

  if not Assigned(e) then
    Exit;

  if not e.isForm then
    Exit;

  e.UpdateDesignerData;
end;

procedure TMainForm.cbxControlsxChange(Sender: TObject);
var
  strCompName: string;
  compControl: TComponent;
  intColPos: Integer;

  function GetComponentFromName(strCompName: string): TComponent;
  var
    I: Integer;
    frmNewFormX: TfrmNewForm;
  begin
    Result := nil;

    frmNewFormX := GetEditor(Self.PageControl.ActivePageIndex).GetDesigner();

    if Assigned(frmNewFormX) = False then
      Exit;

    for I := 0 to frmNewFormX.ComponentCount - 1 do // Iterate
    begin
      if AnsiSameText(trim(frmNewFormX.Components[i].Name), trim(strCompName))
        then
      begin
        Result := frmNewFormX.Components[i];
        exit;
      end;
    end;
  end;

begin
  if cbxControlsx.ItemIndex = -1 then
    exit;

  if not isCurrentPageDesigner then
    Exit;

  strCompName := trim(cbxControlsx.Items[cbxControlsx.ItemIndex]);
  intColPos := Pos(':', strCompName);
  if intColPos <> 0 then
  begin
    strCompName := Trim(Copy(strCompName, 0, intColPos - 1));
  end;

  compControl := GetComponentFromName(strCompName);
  if compControl <> nil then
  begin
    ELDesigner1.SelectedControls.Clear;
    ELDesigner1.SelectedControls.Add(TWinControl(compControl));
    BuildProperties(TControl(compControl));
  end
  else
  begin
    ELDesigner1.SelectedControls.Clear;
    BuildProperties(TControl(GetCurrentDesignerForm()));
  end;

end;
{$ENDIF}

procedure TMainForm.actDesignerCopyExecute(Sender: TObject);
begin
{$IFDEF WX_BUILD}
  if ELDesigner1.CanCopy then
    ELDesigner1.Copy;
{$ENDIF}
end;

procedure TMainForm.actDesignerCutExecute(Sender: TObject);
begin
{$IFDEF WX_BUILD}
    if IsFromScrollBarShowing then
    begin
        MessageDlg('The Designer Form is scrolled. '+#13+#10+''+#13+#10+'Please resize the form to hide the scrollbar before deleting controls.', mtError, [mbOK], 0);
        exit;
    end;

   BuildProperties(ELDesigner1.DesignControl, true);
   DisablePropertyBuilding := True;
{$IFNDEF PRIVATE_BUILD}
   try
{$ENDIF}
     if ELDesigner1.CanCut then
       ELDesigner1.Cut;
{$IFNDEF PRIVATE_BUILD}
   except
   end;
{$ENDIF}
   DisablePropertyBuilding := False;

   ELDesigner1.SelectedControls.Clear;
   ELDesigner1.SelectedControls.Add(ELDesigner1.DesignControl);
   BuildProperties(ELDesigner1.DesignControl);

{$ENDIF}
end;

procedure TMainForm.actDesignerPasteExecute(Sender: TObject);
begin
{$IFDEF WX_BUILD}
    if IsFromScrollBarShowing then
    begin
        MessageDlg('The Designer Form is scrolled. '+#13+#10+''+#13+#10+'Please resize the form to hide the scrollbar before deleting controls.', mtError, [mbOK], 0);
        exit;
    end;

   BuildProperties(ELDesigner1.DesignControl, true);
   DisablePropertyBuilding:=true;
{$IFNDEF PRIVATE_BUILD}
   try
{$ENDIF}
     if ELDesigner1.CanPaste then
       ELDesigner1.Paste;
{$IFNDEF PRIVATE_BUILD}
   except
   end;
{$ENDIF}
   DisablePropertyBuilding:=false;

   ELDesigner1.SelectedControls.Clear;
   ELDesigner1.SelectedControls.Add(ELDesigner1.DesignControl);
   BuildProperties(ELDesigner1.DesignControl);

{$ENDIF}
end;

function TMainForm.IsFromScrollBarShowing:boolean;
begin
    if ( (TFrmNewForm(ELDesigner1.DesignControl).HorzScrollBar.IsScrollBarVisible = true) or
        (TFrmNewForm(ELDesigner1.DesignControl).VertScrollBar.IsScrollBarVisible = true) ) then
        result:=true
    else
        result:=false;
end;

procedure TMainForm.actDesignerDeleteExecute(Sender: TObject);
begin
{$IFDEF WX_BUILD}
   BuildProperties(ELDesigner1.DesignControl,true);
   DisablePropertyBuilding:=true;
   ELDesigner1.DeleteSelectedControls;
   DisablePropertyBuilding:=false;

   ELDesigner1.SelectedControls.Clear;
   ELDesigner1.SelectedControls.Add(ELDesigner1.DesignControl);
   BuildProperties(ELDesigner1.DesignControl);

{$ENDIF}
end;

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
    if not Assigned(e) then
      Continue
    else
    begin
      if SameFileName(e.FileName, strFile) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
  //
end;

{$IFDEF WX_BUILD}
procedure TMainForm.JvInspPropertiesBeforeSelection(Sender: TObject;
  NewItem: TJvCustomInspectorItem; var Allow: Boolean);
begin
  Allow := True;
  if not Assigned(NewItem) then
    Exit;

  if not Assigned(NewItem.Data) then
    Exit;
  try
    if AnsiSameText(NewItem.DisplayName, 'name') and
       AnsiSameText(NewItem.Data.Name, 'wx_Name') then
      PreviousStringValue := NewItem.Data.AsString;
    if AnsiSameText(NewItem.DisplayName, 'name') then
      PreviousComponentName := NewItem.Data.AsString
  except
  end;

end;

function TMainForm.ReplaceClassNameInEditor(strLst:TStringList;edt:TEditor;FromClassName, ToClassName:string):boolean;
var
  I: Integer;
  lineNum :Integer;
  lineStr:String;
begin
    Result := False;
    if strLst.Count < 1 then
         exit;
        
    for I := 0 to strLst.Count - 1 do    // Iterate
    begin
        if not IsNumeric(strLst[i]) then
            continue;
        lineNum:=StrToInt(strLst[i]);
        if lineNum > edt.Text.Lines.Count then
            continue;
        try
            lineStr:=edt.Text.Lines[lineNum];

            strSearchReplace(lineStr,FromClassName,ToClassName,[srWord, srCase, srAll]);
            edt.Text.Lines[lineNum]:=lineStr;
        except

        end;
    end;    // for

    //Finally a solution to change the 
    for I := 0 to edt.Text.Lines.Count - 1 do    // Iterate
    begin
        try
            lineStr:=edt.Text.Lines[i];
            strSearchReplace(lineStr,FromClassName+'::'+FromClassName,ToClassName+'::'+ToClassName,[srWord, srCase, srAll]);
            strSearchReplace(lineStr,'~'+FromClassName,'~'+ToClassName,[srWord, srCase, srAll]);
            strSearchReplace(lineStr,' '+FromClassName+'(',' '+ToClassName+'(',[srWord, srCase, srAll]);            
            edt.Text.Lines[i]:=lineStr;

        except
        end;        
    end;    // for

    Result := True;
    
end;

function TMainForm.GetClassNameLocationsInEditorFiles(var HppStrLst,CppStrLst:TStringList;FileName, FromClassName, ToClassName:string): Boolean;
var
  e: TEditor;
  St: PStatement;
  i, intColon: Integer;
  strParserClassName: string;
  cppEditor,hppEditor:TEditor;
  cppFName,hppFName:String;
  //LineNumber:Integer;
begin
  HppStrLst.clear;
  CppStrLst.clear;

  cppFName:=ChangeFileExt(FileName,CPP_EXT);
  hppFName:=ChangeFileExt(FileName,H_EXT);

  OpenFile(ChangeFileExt(FileName,CPP_EXT),true);
  OpenFile(ChangeFileExt(FileName,H_EXT),true);

  cppEditor:=Self.GetEditorFromFileName(ChangeFileExt(FileName,CPP_EXT));
  hppEditor:=Self.GetEditorFromFileName(ChangeFileExt(FileName,H_EXT));

  Result:=assigned(cppEditor) and Assigned(hppEditor);

  if not Result then
    Exit;

  for I := 0 to ClassBrowser1.Parser.Statements.Count - 1 do // Iterate
  begin
    St := PStatement(ClassBrowser1.Parser.Statements[i]);

    if (St._Kind = skConstructor) or (St._Kind = skDestructor)then
    begin
        if (AnsiSameText(FromClassName,St._Command) = True) or (AnsiSameText('~'+FromClassName,St._Command) = True) then
        begin

            if strEqual(St._DeclImplFileName,cppFName) then
            begin
                CppStrlst.Add(IntToStr(St._DeclImplLine- 1));
            end;

            if strEqual(St._DeclImplFileName,hppFName) then
            begin
                HppStrlst.Add(IntToStr(St._DeclImplLine- 1));
            end;

            if strEqual(St._FileName,hppFName) then
            begin
                HppStrlst.Add(IntToStr(St._Line- 1));
            end;

            if strEqual(St._FileName,cppFName) then
            begin
                cppStrlst.Add(IntToStr(St._Line- 1));
            end;

//            LineString:=hppEditor.Text.Lines[St._Line - 1];
//            strSearchReplace(LineString,FromClassName,ToClassName,[srWord, srCase, srAll]);
//            hppEditor.Text.Lines[St._Line - 1]:=LineString;
//
//            LineString:=cppEditor.Text.Lines[St._DeclImplLine - 1];
//            strSearchReplace(LineString,FromClassName,ToClassName,[srWord, srCase, srAll]);
//            cppEditor.Text.Lines[St._DeclImplLine - 1]:=LineString;

        end;
        continue;
    end;

    if St._Kind = skClass then
    begin
       if AnsiSameText(St._ScopeCmd,FromClassName) then
       begin
            if strEqual(St._DeclImplFileName,cppFName) then
            begin
                CppStrlst.Add(IntToStr(St._DeclImplLine- 1));
            end;

            if strEqual(St._DeclImplFileName,hppFName) then
            begin
                HppStrlst.Add(IntToStr(St._DeclImplLine- 1));
            end;

            if strEqual(St._FileName,hppFName) then
            begin
                HppStrlst.Add(IntToStr(St._Line- 1));
            end;

            if strEqual(St._FileName,cppFName) then
            begin
                cppStrlst.Add(IntToStr(St._Line- 1));
            end;

            //LineString:=hppEditor.Text.Lines[St._Line - 1];
            //strSearchReplace(LineString,FromClassName,ToClassName,[srWord, srCase, srAll]);
            //hppEditor.Text.Lines[St._Line - 1]:=LineString;
       end;
       continue;
    end;

    if St._Kind = skFunction then
    begin
      strParserClassName := St._ScopeCmd;
      intColon := Pos('::', strParserClassName);
      if intColon <> 0 then
      begin
        strParserClassName := Copy(strParserClassName, 0, intColon - 1);
      end
      else
        Continue;

     if not AnsiSameText(strParserClassName,FromClassName) then
        Continue;

        cppStrlst.Add(IntToStr(St._Line-1));
        hppStrlst.Add(IntToStr(St._Line- 1));
        cppStrlst.Add(IntToStr(St._DeclImplLine- 1));
        hppStrlst.Add(IntToStr(St._DeclImplLine- 1));

        //LineString:=cppEditor.Text.Lines[St._DeclImplLine - 1];
        //strSearchReplace(LineString,FromClassName,ToClassName,[srWord, srCase, srAll]);
        //cppEditor.Text.Lines[St._DeclImplLine - 1]:=LineString;
    end;

    continue;

        //    if St._Kind = skVariable then
    //        continue;

        //if St._Kind = skFunction then
    //    begin
    //SendDebug(PStatement(CppParser1.Statements[i])._Command);
    //    end;

    Continue;

    ///
    if St._Kind = skClass then
    begin
      if not AnsiSameText(St._Command, FromClassName) then
      begin
        //sendDebug('Problematic value : ' + St._Command);
        continue;
      end;
    end;

    if St._Scope = ssClassLocal then
    begin
      strParserClassName := PStatement(CppParser1.Statements[i])._ScopeCmd;
      intColon := Pos('::', strParserClassName);
      if intColon <> 0 then
      begin
        strParserClassName := Copy(strParserClassName, 0, intColon - 1);
      end
      else
        Continue;

    end;
  end; // for

  Result := False;
  e := GetEditorFromFileName(FileName);
  if not Assigned(e) then
    Exit;

  //e.Text.

  //FileName,FromClassName,ToClassName

end;


function TMainForm.ReplaceClassNameInEditorFile(FileName, FromClassName, ToClassName: string): Boolean;
var
  e: TEditor;
  St: PStatement;
  i, intColon: Integer;
  strParserClassName: string;
  cppEditor,hppEditor:TEditor;
  //LineNumber:Integer;
  LineString:string;
begin
  OpenFile(ChangeFileExt(FileName,CPP_EXT),true);
  OpenFile(ChangeFileExt(FileName,H_EXT),true);

  cppEditor:=Self.GetEditorFromFileName(ChangeFileExt(FileName,CPP_EXT));
  hppEditor:=Self.GetEditorFromFileName(ChangeFileExt(FileName,H_EXT));

  Result:=assigned(cppEditor) and Assigned(hppEditor);

  if not Result then
    Exit;

  for I := 0 to ClassBrowser1.Parser.Statements.Count - 1 do // Iterate
  begin
    St := PStatement(ClassBrowser1.Parser.Statements[i]);

    if (St._Kind = skConstructor) or (St._Kind = skDestructor)then
    begin
        if (AnsiSameText(FromClassName,St._Command) = True) or (AnsiSameText('~'+FromClassName,St._Command) = True) then
        begin
            LineString:=hppEditor.Text.Lines[St._Line - 1];
            strSearchReplace(LineString,FromClassName,ToClassName,[srWord, srCase, srAll]);
            hppEditor.Text.Lines[St._Line - 1]:=LineString;

            LineString:=cppEditor.Text.Lines[St._DeclImplLine - 1];
            strSearchReplace(LineString,FromClassName,ToClassName,[srWord, srCase, srAll]);
            cppEditor.Text.Lines[St._DeclImplLine - 1]:=LineString;
        end;
        continue;
    end;

    if St._Kind = skClass then
    begin
       if AnsiSameText(St._ScopeCmd,FromClassName) then
       begin
            LineString:=hppEditor.Text.Lines[St._Line - 1];
            strSearchReplace(LineString,FromClassName,ToClassName,[srWord, srCase, srAll]);
            hppEditor.Text.Lines[St._Line - 1]:=LineString;
       end;
       continue;
    end;

    if St._Kind = skFunction then
    begin
      strParserClassName := St._ScopeCmd;
      intColon := Pos('::', strParserClassName);
      if intColon <> 0 then
      begin
        strParserClassName := Copy(strParserClassName, 0, intColon - 1);
      end
      else
        Continue;

     if not AnsiSameText(strParserClassName,FromClassName) then
        Continue;

        LineString:=cppEditor.Text.Lines[St._DeclImplLine - 1];
        strSearchReplace(LineString,FromClassName,ToClassName,[srWord, srCase, srAll]);
        cppEditor.Text.Lines[St._DeclImplLine - 1]:=LineString;
    end;

    continue;

        //    if St._Kind = skVariable then
    //        continue;

        //if St._Kind = skFunction then
    //    begin
    //SendDebug(PStatement(CppParser1.Statements[i])._Command);
    //    end;

    Continue;

    ///
    if St._Kind = skClass then
    begin
      if not AnsiSameText(St._Command, FromClassName) then
      begin
        //sendDebug('Problematic value : ' + St._Command);
        continue;
      end;
    end;

    if St._Scope = ssClassLocal then
    begin
      strParserClassName := PStatement(CppParser1.Statements[i])._ScopeCmd;
      intColon := Pos('::', strParserClassName);
      if intColon <> 0 then
      begin
        strParserClassName := Copy(strParserClassName, 0, intColon - 1);
      end
      else
        Continue;

    end;
  end; // for

  Result := False;
  e := GetEditorFromFileName(FileName);
  if not Assigned(e) then
    Exit;

  //e.Text.

  //FileName,FromClassName,ToClassName

end;

procedure TMainForm.JvInspPropertiesItemValueChanged(Sender: TObject;
  Item: TJvCustomInspectorItem);
begin
//sendDebug('Yes it is changed!!!');
end;

procedure TMainForm.DesignerOptionsClick(Sender: TObject);
begin
  with TDesignerForm.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TMainForm.AlignToGridClick(Sender: TObject);
begin
    ELDesigner1.SelectedControls.AlignToGrid;
end;

procedure TMainForm.AlignToLeftClick(Sender: TObject);
begin
    ELDesigner1.SelectedControls.Align(atLeftTop, atNoChanges);
end;

procedure TMainForm.AlignToRightClick(Sender: TObject);
begin
    ELDesigner1.SelectedControls.Align(atRightBottom, atNoChanges);
end;

procedure TMainForm.AlignToMiddleHorizontalClick(Sender: TObject);
begin
    ELDesigner1.SelectedControls.Align(atCenter, atNoChanges);
end;

procedure TMainForm.AlignToMiddleVerticalClick(Sender: TObject);
begin
    ELDesigner1.SelectedControls.Align(atNoChanges, atCenter);
end;

procedure TMainForm.AlignToTopClick(Sender: TObject);
begin
    ELDesigner1.SelectedControls.Align(atNoChanges, atLeftTop);
end;

procedure TMainForm.AlignToBottomClick(Sender: TObject);
begin
    ELDesigner1.SelectedControls.Align(atNoChanges, atRightBottom);
end;

procedure TMainForm.ViewControlIDsClick(Sender: TObject);
var
    vwCtrlIDsFormObj:TViewControlIDsForm;
begin
    vwCtrlIDsFormObj:=TViewControlIDsForm.Create(self);

    vwCtrlIDsFormObj.SetMainControl(TWinControl(ELDesigner1.DesignControl));
    vwCtrlIDsFormObj.PopulateControlList;
    vwCtrlIDsFormObj.ShowModal;
end;

procedure TMainForm.ChangeCreationOrder1Click(Sender: TObject);
var
    Control: TWinControl;
    e, hppEditor, cppEditor: TEditor;
begin
    if PageControl.ActivePageIndex = -1 then
        exit;

    if ELDesigner1.SelectedControls.Count = 0 then
        exit;

    //Attempt to get a control that has sub-controls
    Control := TWinControl(ELDesigner1.SelectedControls.Items[0]);
    while Control.Parent <> nil do
    begin
        if Control.ControlCount > 1 then
            Break;
        Control := Control.Parent;
    end;

    //We give up - there isn't one to use
    if Control.ControlCount = 0 then
    begin
        //MessageDlg('You cannot do anything with this control. '+#13+'Select its parent Dialog or Sizer.', mtError, [mbOK], 0);
        Exit;
    end;

    if MessageDlg('All Designer related Files will be saved before proceeding.'+#13+#10+''+#13+#10+'Do you want to continue ?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        exit;

    e:=GetEditor(PageControl.ActivePageIndex);

    if not assigned(e) then
        exit;

    if e.IsDesignerHPPOpened then
    begin
        hppEditor:=e.GetDesignerHPPEditor;
        if assigned(hppEditor) then
        begin
            if hppEditor.Modified then
                SaveFile(hppEditor);
        end;
    end;

    if e.IsDesignerCPPOpened then
    begin
        cppEditor:=e.GetDesignerCPPEditor;
        if assigned(cppEditor) then
        begin
            if cppEditor.Modified then
                SaveFile(cppEditor);
        end;
    end;

    if e.Modified then
    begin
        SaveFile(e);
    end;

    with TCreationOrderForm.Create(Self) do
    try
      SetMainControl(Control);
      PopulateControlList;
      ShowModal;
    finally
      Free
    end;

    ELDesigner1.Active := false;
    ELDesigner1.DesignControl := nil;

    //This should copy the Form's content to the Text Editor
    e.InsertDefaultText;

    //Save form file
    e.Modified:=true;
    SaveFile(e);
    e.ReloadForm;
    e.UpdateDesignerData;

    if e.IsDesignerHPPOpened then
    begin
        hppEditor:=e.GetDesignerHPPEditor;
        if assigned(hppEditor) then
        begin
            if hppEditor.Modified then
                SaveFile(hppEditor);
        end;
    end;

    if e.IsDesignerCPPOpened then
    begin
        cppEditor:=e.GetDesignerCPPEditor;
        if assigned(cppEditor) then
        begin
            if cppEditor.Modified then
                SaveFile(cppEditor);
        end;
    end;
    if e.Modified then
    begin
        SaveFile(e);
    end;

    ELDesigner1.DesignControl:=e.GetDesigner;
    BuildComponentList(e.GetDesigner);
    ELDesigner1.Active:=true;

end;

procedure TMainForm.SelectParentClick(Sender: TObject);
var
    ActiveControl: TControl;
    SelectedItem: TMenuItem;
    SelectedLevel: integer;
begin
    //Get all the information we need
    SelectedItem := TMenuItem(Sender);
    SelectedLevel := SelectedItem.Parent.IndexOf(SelectedItem) + 1;
    ActiveControl := ELDesigner1.SelectedControls.Items[0];

    //Select the control we want
    while SelectedLevel > 0 do
    begin
        ActiveControl := ActiveControl.Parent;
        SelectedLevel := SelectedLevel - 1;
    end;

    //Set set the active control
    ELDesigner1.SelectedControls.Clear;
    ELDesigner1.SelectedControls.Add(ActiveControl);
end;

procedure TMainForm.LockControlClick(Sender: TObject);
var
  I: Integer;
begin
  //Do we lock or unlock them?
  if not DesignerMenuLocked.Checked then
    for I := 0 to ELDesigner1.SelectedControls.Count - 1 do
      ELDesigner1.LockControl(ELDesigner1.SelectedControls[I], [lmNoMove, lmNoResize, lmNoDelete, lmNoInsertIn])
  else
    for I := 0 to ELDesigner1.SelectedControls.Count - 1 do
      ELDesigner1.LockControl(ELDesigner1.SelectedControls[I], []);
end;
{$ENDIF}

procedure TMainForm.OnPropertyItemSelected(Sender: TObject);
begin
    if assigned(SelectedComponent) then
    begin
        if SelectedComponent is TFrmNewForm then
            PreviousComponentName:=TFrmNewForm(SelectedComponent).Wx_Name
        else
            PreviousComponentName:=SelectedComponent.Name;
    end;
end;

procedure TMainForm.actNewWxFrameExecute(Sender: TObject);
begin
    CreateNewDialogOrFrameCode(dtWxFrame, nil, 2);
end;

procedure TMainForm.actNewwxDialogExecute(Sender: TObject);
begin
    CreateNewDialogOrFrameCode(dtWxDialog, nil, 2);
end;

procedure TMainForm.actWxPropertyInspectorCutExecute(Sender: TObject);
begin
{$IFDEF WX_BUILD}
    SendMessage(GetFocus, WM_CUT, 0, 0);
{$ENDIF}
end;

procedure TMainForm.actWxPropertyInspectorCopyExecute(Sender: TObject);
begin
{$IFDEF WX_BUILD}
     SendMessage(GetFocus, WM_COPY, 0, 0);
{$ENDIF}
end;

procedure TMainForm.actWxPropertyInspectorPasteExecute(Sender: TObject);
begin
{$IFDEF WX_BUILD}
    SendMessage(GetFocus, WM_PASTE, 0, 0);
{$ENDIF}
end;

procedure TMainForm.actWxPropertyInspectorDeleteExecute(Sender: TObject);

begin
{$IFDEF WX_BUILD}
    if (GetFocus <> 0) then
         SendMessage(GetFocus, WM_CLEAR, 0, 0)
    else
        MessageDlg('nothing selected', mtError, [mbOK], 0);
{$ENDIF}
end;

procedure TMainForm.ProjectViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) and Assigned(ProjectView.Selected) then
    RemoveItem(ProjectView.Selected)
  else if Key = VK_ESCAPE then
  begin
    if PageControl.Visible and PageControl.Enabled and (PageControl.ActivePage <> nil) then
      GetEditor(-1).Activate;
  end
  else if (Key = VK_RETURN) and Assigned(ProjectView.Selected) then
  begin
    if ProjectView.Selected.Data <> Pointer(-1) then { if not a directory }
      OpenUnit;
  end;
end;

function TMainForm.BreakupTodo(Filename: string; sl: TStrings; Line: integer; Token: string; HasUser,
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
  if HasUser or HasPriority then begin
    idx := AnsiPos('#', S);
    sUser := Copy(S, 1, idx - 1); // got user
    iPriority := StrToIntDef(S[idx + 1], 1); // got priority
  end;

  Indent := AnsiPos(':', sl[Line]) + 1;
  idx := AnsiPos(':', S);
  Delete(S, 1, idx + 1);
  Done := False;
  Y := Line;
  while (Y < sl.Count) and not Done do begin
    X := Indent;
    while (X <= Length(sl[Y])) and not Done do begin
      if (sl[Y][X] = '*') and (X < Length(sl[Y])) and (sl[Y][X + 1] = '/') then begin
        Done := True;
        Break;
      end;
      sDescription := sDescription + sl[Y][X];
      Inc(X);
    end;
    if not MultiLine then
      Break;
    if not Done then begin
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

procedure TMainForm.AddTodoFiles(Current, InProject, NotInProject, OpenOnly: boolean);
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

    while Matches do begin
      case MaskStr[MaskIndex] of
        '*': begin
          if MaskIndex < Length(MaskStr) then
            NextMatch := MaskStr[MaskIndex + 1]
          else
            NextMatch := #0;
          while SearchIndex <= Length(SearchStr) do begin
            if SearchStr[SearchIndex] = NextMatch then begin
              Inc(SearchIndex);
              Inc(MaskIndex, 2);
              Break;
            end;
            Inc(SearchIndex);
          end;
          if (SearchIndex = Length(SearchStr)) and (MaskIndex < Length(MaskStr)) then
            Matches := False;
        end;
        '?': begin
          Inc(SearchIndex);
          Inc(MaskIndex);
        end;
      else
        if MaskStr[MaskIndex] <> SearchStr[SearchIndex] then
          Matches := False
        else begin
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

    Result := Matches and (MaskIndex > Length(MaskStr)) and (SearchIndex > Length(SearchStr));
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
        else if FileExists(Filename) then
          sl.LoadFromFile(Filename);

      if sl.Count = 0 then
        if FileExists(Filename) then
        sl.LoadFromFile(Filename);

      I := 0;
      while I < sl.Count do begin
        if MatchesMask(sl[I], '*/? TODO (?*#?#)*:*') then
          BreakupToDo(Filename, sl, I, 'TODO', True, True) // full info TODO
        else if MatchesMask(sl[I], '*/? DONE (?*#?#)*:*') then
          BreakupToDo(Filename, sl, I, 'DONE', True, True) // full info DONE
        else if MatchesMask(sl[I], '*/? TODO (#?#)*:*') then
          BreakupToDo(Filename, sl, I, 'TODO', False, True) // only priority info TODO
        else if MatchesMask(sl[I], '*/? DONE (#?#)*:*') then
          BreakupToDo(Filename, sl, I, 'DONE', False, True) // only priority info DONE
        else if MatchesMask(sl[I], '*/?*TODO*:*') then
          BreakupToDo(Filename, sl, I, 'TODO', False, False) // custom TODO
        else if MatchesMask(sl[I], '*/?*DONE*:*') then
          BreakupToDo(Filename, sl, I, 'DONE', False, False); // custom DONE
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
  if Current then begin
    e := GetEditor;
    if Assigned(e) then
      AddToDo(e.FileName);
    Exit;
  end;

  if InProject and not OpenOnly then begin
    if Assigned(fProject) then
      for idx := 0 to pred(fProject.Units.Count) do
        AddToDo(fProject.Units[idx].filename);
  end;

  if OpenOnly then begin
    for idx := 0 to pred(PageControl.PageCount) do begin
      e := GetEditor(idx);
      if Assigned(e) then
        if InProject and e.InProject then
          AddToDo(e.FileName)
    end;
  end;

  if NotInProject then begin
    for idx := 0 to pred(PageControl.PageCount) do begin
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
      Sender.Canvas.Font.Style := Sender.Canvas.Font.Style + [fsStrikeOut]
    end
    else
    begin
      Sender.Canvas.Font.Color := clWindowText;
      Sender.Canvas.Font.Style := Sender.Canvas.Font.Style - [fsStrikeOut];
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
  if Assigned(e) then begin
    PToDoRec(Item.Data)^.IsDone := Item.Checked;
    if Item.Checked then begin
      e.Text.Lines[PToDoRec(Item.Data)^.Line] := StringReplace(e.Text.Lines[PToDoRec(Item.Data)^.Line], 'TODO', 'DONE', []);
      if chkTodoIncomplete.Checked then
        BuildTodoList;
    end
    else
      e.Text.Lines[PToDoRec(Item.Data)^.Line] := StringReplace(e.Text.Lines[PToDoRec(Item.Data)^.Line], 'DONE', 'TODO', []);
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
  if fTodoSortColumn = 0 then begin
    if PToDoRec(Item1.Data)^.IsDone and not PToDoRec(Item2.Data)^.IsDone then
      Compare := 1
    else if not PToDoRec(Item1.Data)^.IsDone and PToDoRec(Item2.Data)^.IsDone then
      Compare := -1
    else
      Compare := 0;
  end
  else begin
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
  for I := 0 to fToDoList.Count - 1 do begin
    td := PToDoRec(fToDoList[I]);
    if (chkTodoIncomplete.Checked and not td^.IsDone) or not chkTodoIncomplete.Checked then
      with lvTodo.Items.Add do begin
        Caption := '';
        SubItems.Add(IntToStr(td^.Priority));
        S := StringReplace(td^.Description, #13#10, ' ', [rfReplaceAll]);
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
    if Assigned(fToDoList[0]) then begin
      Dispose(PToDoRec(fToDoList[0]));
      fToDoList.Delete(0);
    end;
  case cmbTodoFilter.ItemIndex of
    0: AddTodoFiles(False, True, True, False);
    1: AddTodoFiles(False, True, True, True);
    2: AddTodoFiles(False, True, False, False);
    3: AddTodoFiles(False, True, False, True);
    4: AddTodoFiles(False, False, True, True);
  else
    AddTodoFiles(True, False, True, True); //The default would be for current files only.
  end;
  BuildTodoList;
end;

procedure TMainForm.RefreshTodoList;
begin
  cmbTodoFilterChange(cmbTodoFilter);
end;

{$IfDef WX_BUILD}
procedure TMainForm.tmrInspectorHelperTimer(Sender: TObject);
begin
  if fstrCppFileToOpen = '' then
    exit;
  tmrInspectorHelper.Enabled:=false;
  OpenFile(fstrCppFileToOpen);
  fstrCppFileToOpen:='';
end;

procedure TMainForm.StatusBarDrawPanel(StatusBar: TStatusBar;
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
end;

initialization
    TWxJvInspectorTStringsItem.RegisterAsDefaultItem;
    TJvInspectorMyFontItem.RegisterAsDefaultItem;
    TJvInspectorMenuItem.RegisterAsDefaultItem;
    TJvInspectorBitmapItem.RegisterAsDefaultItem;
    TJvInspectorListColumnsItem.RegisterAsDefaultItem;
    TJvInspectorColorEditItem.RegisterAsDefaultItem;
    TJvInspectorFileNameEditItem.RegisterAsDefaultItem;
    TJvInspectorStatusBarItem.RegisterAsDefaultItem;
    TJvInspectorValidatorItem.RegisterAsDefaultItem;
{$ENDIF}

finalization

end.

