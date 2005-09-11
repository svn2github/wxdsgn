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

{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
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
  wxSizerpanel, Designerfrm, ELPropInsp, uFileWatch, ThemeMgr, ExceptionFilterUnit,
  DesignerOptions, JvExStdCtrls, JvEdit
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
    { *** RNC make the breakpoints global ***}
    TBreakPointEntry = record
        file_name    : String;
        line    : integer;
        editor : TEditor;
        breakPointIndex:integer;
    end;
PBreakPointEntry = ^TBreakPointEntry;
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
    ProjectManagerItem: TMenuItem;
    StatusbarItem: TMenuItem;
    CompileroutputItem: TMenuItem;
    AlwaysShowItem: TMenuItem;
    N37: TMenuItem;
    ShowonlywhenneededItem: TMenuItem;
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
    CloseSheet: TTabSheet;
    SaveAllBtn: TToolButton;
    SplitterLeft: TSplitter;
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
    actProjectManager: TAction;
    actStatusbar: TAction;
    actCompOutput: TAction;
    actCompOnNeed: TAction;
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
    N15: TMenuItem;
    actBreakPoint: TAction;
    actIncremental: TAction;
    IncrementalSearch1: TMenuItem;
    actShowBars: TAction;
    PageControl: TPageControl;
    Close1: TMenuItem;
    N16: TMenuItem;
    DebugMenu: TMenuItem;
    N18: TMenuItem;
    TogglebreakpointItem: TMenuItem;
    DbgNextItem: TMenuItem;
    StepoverItem: TMenuItem;
    N21: TMenuItem;
    WatchItem: TMenuItem;
    DebugSheet: TTabSheet;
    AddwatchItem: TMenuItem;
    actAddWatch: TAction;
    actEditWatch: TAction;
    pnlFull: TPanel;
    btnFullScrRevert: TSpeedButton;
    actNextStep: TAction;
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
    SplitterBottom: TSplitter;
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
    actStepSingle: TAction;
    DbgSingleStep: TMenuItem;
    DebugVarsPopup: TPopupMenu;
    AddwatchPop: TMenuItem;
    RemoveWatchPop: TMenuItem;
    devFileMonitor1: TdevFileMonitor;
    actFileProperties: TAction;
    N35: TMenuItem;
    N1: TMenuItem;
    Properties1: TMenuItem;
    actViewToDoList: TAction;
    actAddToDo: TAction;
    AddToDoitem1: TMenuItem;
    N38: TMenuItem;
    oDolist1: TMenuItem;
    N39: TMenuItem;
    actProjectNewFolder: TAction;
    actProjectRemoveFolder: TAction;
    actProjectRenameFolder: TAction;
    Newfolder1: TMenuItem;
    N40: TMenuItem;
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
    mnuDebugParameters: TMenuItem;
    DevCppDDEServer: TDdeServerConv;
    actShowTips: TAction;
    ips1: TMenuItem;
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
    LeftPageControl: TPageControl;
    ProjectSheet: TTabSheet;
    ProjectView: TTreeView;
    ClassSheet: TTabSheet;
    ClassBrowser1: TClassBrowser;
    DebugSubPages: TPageControl;
    tabVars: TTabSheet;
    PanelDebug: TPanel;
    AddWatchBtn: TSpeedButton;
    RemoveWatchBtn: TSpeedButton;
    tabBacktrace: TTabSheet;
    lvBacktrace: TListView;
    tabDebugOutput: TTabSheet;
    DebugOutput: TMemo;
    GdbOutputPanel: TPanel;
    lblSendCommandGdb: TLabel;
    edGdbCommand: TEdit;
    GdbCommandBtn: TButton;
    FloatingPojectManagerItem: TMenuItem;
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
    DebugLeftSheet: TTabSheet;
    DebugTree: TTreeView;
    DebugPanel: TPanel;
    NextStepBtn: TSpeedButton;
    StepIntoBtn: TSpeedButton;
    DebugPanel2: TPanel;
    StepOverBtn: TSpeedButton;
    DebugPanel3: TPanel;
    DDebugBtn: TSpeedButton;
    RunToCursorBtn: TSpeedButton;
    StopExecBtn: TSpeedButton;
    N67: TMenuItem;
    FloatingReportwindowItem: TMenuItem;
    N57: TMenuItem;
    AttachtoprocessItem: TMenuItem;
    actAttachProcess: TAction;
    ModifyWatchPop: TMenuItem;
    actModifyWatch: TAction;
    ClearallWatchPop: TMenuItem;
    actNewwxDialog: TAction;
    NewWxDialogItem: TMenuItem;
    ThemeManager1: TThemeManager;
    actDesignerCopy: TAction;
    actDesignerCut: TAction;
    actDesignerPaste: TAction;
    actDesignerDelete: TAction;
    pnlControlHolder: TPanel;
    SplitterRight: TSplitter;
    ProgramResetBtn: TToolButton;
    SurroundWithPopItem: TMenuItem;
    trycatchPopItem: TMenuItem;
    tryfinallyPopItem: TMenuItem;
    trycatchfinallyPopItem: TMenuItem;
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
    pnlBrowsers: TPanel;
    NewWxFrameItem: TMenuItem;
    N73: TMenuItem;
    actNewWxFrame: TAction;
    JvInspectorBorlandPainter1: TJvInspectorBorlandPainter;
    DebugStopBtn: TToolButton;
    actWxPropertyInspectorCut: TAction;
    actWxPropertyInspectorCopy: TAction;
    actWxPropertyInspectorPaste: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure ProjectViewChange(Sender: TObject; Node: TTreeNode);
    procedure ToggleBookmarkClick(Sender: TObject);
    procedure GotoBookmarkClick(Sender: TObject);
    procedure ToggleBtnClick(Sender: TObject);
    procedure GotoBtnClick(Sender: TObject);
    procedure NewAllBtnClick(Sender: TObject);
    procedure MessageControlChange(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure MessageControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure ProjectViewContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ProjectViewDblClick(Sender: TObject);
    procedure InsertBtnClick(Sender: TObject);
    procedure Customize1Click(Sender: TObject);
    procedure ToolbarClick(Sender: TObject);
    procedure ControlBar1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure SplitterBottomCanResize(Sender: TObject;
      var NewSize: Integer; var Accept: Boolean);
    procedure SplitterBottomMoved(Sender: TObject);
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
    procedure actProjectManagerExecute(Sender: TObject);
    procedure actStatusbarExecute(Sender: TObject);
    procedure actCompOutputExecute(Sender: TObject);
    procedure actCompOnNeedExecute(Sender: TObject);
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
    procedure actMsgHideExecute(Sender: TObject);
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
    procedure MessagePopupPopup(Sender: TObject);
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
    procedure MessageControlContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
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
    procedure DebugSubPagesChange(Sender: TObject);
    procedure lvBacktraceCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvBacktraceMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure actDebugUpdate(Sender: TObject);
    procedure actRunUpdate(Sender: TObject);
    procedure actCompileUpdate(Sender: TObject);
    procedure devFileMonitor1NotifyChange(Sender: TObject;
      ChangeType: TdevMonitorChangeType; Filename: String);
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
    procedure GdbCommandBtnClick(Sender: TObject);
    procedure ViewCPUItemClick(Sender: TObject);
    procedure edGdbCommandKeyPress(Sender: TObject; var Key: Char);
    procedure actExecParamsExecute(Sender: TObject);
    procedure DevCppDDEServerExecuteMacro(Sender: TObject; Msg: TStrings);
    procedure FormPaint(Sender: TObject);
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
    { end XXXKF }
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
    procedure ReportWindowClose(Sender: TObject; var Action: TCloseAction);
    procedure FloatingPojectManagerItemClick(Sender: TObject);
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
    procedure FloatingReportwindowItemClick(Sender: TObject);
    procedure actAttachProcessUpdate(Sender: TObject);
    procedure actAttachProcessExecute(Sender: TObject);
    procedure actModifyWatchExecute(Sender: TObject);
    procedure actModifyWatchUpdate(Sender: TObject);
    procedure ClearallWatchPopClick(Sender: TObject);
    procedure ApplicationEvents1Deactivate(Sender: TObject);
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

  {$IFDEF WX_BUILD}
    procedure CreateNewDialogOrFrameCode(dsgnType:TWxDesignerType);
    procedure NewWxProjectCode(dsgnType:TWxDesignerType);
    procedure Panel2Resize(Sender: TObject);
    procedure PalleteListPanelResize(Sender: TObject);
    procedure lbxControlsDrawItem(Control: TWinControl; Index: Integer;Rect: TRect; State: TOwnerDrawState);
    procedure PalettesChange(Sender: TObject);
    procedure WxPropertyInspectorContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure ELDesigner1ContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure ELDesigner1ChangeSelection(Sender: TObject);
    procedure ELDesigner1ControlDeleted(Sender: TObject; AControl: TControl);
    procedure ELDesigner1ControlHint(Sender: TObject; AControl: TControl;var AHint: string);
    procedure ELDesigner1ControlInserted(Sender: TObject; AControl: TControl);
    procedure ELDesigner1ControlInserting(Sender: TObject;var AControlClass: TControlClass);
    procedure ELDesigner1KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure ELDesigner1Modified(Sender: TObject);
    procedure JvInspPropertiesAfterItemCreate(Sender: TObject;Item: TJvCustomInspectorItem);
    procedure JvInspPropertiesDataValueChanged(Sender: TObject;Data: TJvCustomInspectorData);
    procedure JvInspEventsAfterItemCreate(Sender: TObject;Item: TJvCustomInspectorItem);
    procedure JvInspEventsDataValueChanged(Sender: TObject;Data: TJvCustomInspectorData);
    procedure JvInspEventsItemValueChanged(Sender: TObject;Item: TJvCustomInspectorItem);
    procedure lbxControlsClick(Sender: TObject);
    procedure cbxControlsxChange(Sender: TObject);
    procedure JvInspPropertiesBeforeSelection(Sender: TObject;NewItem: TJvCustomInspectorItem; var Allow: Boolean);
    procedure est1Click(Sender: TObject);
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
    procedure ELDesigner1Notification(Sender: TObject;AnObject: TPersistent; Operation: TOperation);
    procedure OnPropertyItemSelected(Sender: TObject);
    function IsFromScrollBarShowing:boolean;
    procedure actNewWxFrameExecute(Sender: TObject);
    procedure actNewwxDialogExecute(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure ProjectViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
   {$ENDIF}

  private
    fTab: integer;
    fmsgHeight: integer;
    fHelpfiles: ToysStringList;
    fTools: TToolController;
    fProjectCount: integer;
    fCompiler: TCompiler;
    ProjectToolWindow: TForm;
    ReportToolWindow: TForm;
    bProjectLoading: boolean;
    OldLeft: integer;
    OldTop: integer;
    OldWidth: integer;
    OldHeight: integer;
    ReloadFilename: string;

    function AskBeforeClose(e: TEditor; Rem: boolean;var Saved:Boolean): boolean; // Modified for wx-devcpp
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
    procedure OpenCloseMessageSheet(const _Show: boolean);
    procedure OpenUnit;
    procedure ClearMessageControl;
    function PrepareForCompile: Boolean;
    procedure LoadTheme;
    procedure ShowDebug;
    procedure InitClassBrowser(Full: boolean = False);
    procedure ScanActiveProject;
    procedure CheckForDLLProfiling;
    procedure UpdateAppTitle;
    procedure DoCVSAction(Sender: TObject; whichAction: TCVSAction);
    procedure WordToHelpKeyword;
    procedure OnHelpSearchWord(sender: TObject);
    procedure ProjectWindowClose(Sender: TObject; var Action: TCloseAction);
    procedure SetupProjectView;
    procedure BuildOpenWith;
    procedure RebuildClassesToolbar;
    procedure PrepareDebugger;
    procedure HideCodeToolTip; // added on 23rd may 2004 by peter_
    procedure ParseCustomCmdLine(strLst:TStringList); //Added By Guru
    procedure SurroundWithClick(Sender: TObject);     //Added By Guru
  protected
    {$IFDEF WX_BUILD}
    procedure DoCreateWxSpecificItems;
   {$ENDIF}
    procedure DoCreateEverything; // added by peter
    procedure DoApplyWindowPlacement; // added by peter
  public
    procedure OpenFile(s: string; withoutActivation: Boolean = false); // Modified for wx
    procedure OpenProject(s: string);
    function FileIsOpen(const s: string; inprj: boolean = FALSE): integer;
    function GetEditor(const index: integer = -1): TEditor;
    function GetEditorFromFileName(ffile: string): TEditor;
    procedure GotoBreakpoint(bfile: string; bline: integer);
    procedure RemoveActiveBreakpoints;
    procedure AddDebugVar(s: string);
    procedure OnBreakpointToggle(index: integer; BreakExists: boolean);
    procedure SetProjCompOpt(idx: integer; Value: boolean);// set project's compiler option indexed 'idx' to value 'Value'
    function CloseEditor(index: integer; Rem: boolean): Boolean;
    procedure RefreshContext;

    { *** RNC Global Breakpoint Declarations *** }
    procedure AddBreakPointToList(line_number: integer; e : TEditor; filename:string);
    function RemoveBreakPointFromList(line_number: integer; e:TEditor): integer;
    procedure RemoveAllBreakPointFromList();
    function GetBreakPointIndex(line_number: integer; e:TEditor) : integer;
    procedure RemoveBreakPointAtIndex(index:integer);
    //function BreakPointForFile(filename : string) : integer;

    //Functions for wx-devcpp
    procedure SurroundString(e: TEditor;strStart,strEnd:String);
    procedure CppCommentString(e: TEditor);
    function GetCurrentFileName:String;
    function GetCurrentClassName:string;
    procedure GetFunctionList(strClassName:String;fncList:TStringList);
    {Guru's Function}
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
  DesignerMenuAlign : TMenuItem;
  DesignerMenuAlignToGrid, DesignerMenuAlignVertical, DesignerMenuAlignHorizontal,
  DesignerMenuAlignToLeft, DesignerMenuAlignToRight,
  DesignerMenuAlignToTop, DesignerMenuAlignToBottom,
  DesignerMenuAlignToMiddle : TMenuItem;
  DesignerMenuAlignToMiddleVertical, DesignerMenuAlignToMiddleHorizontal: TMenuItem;
  DesignerMenuSep3:TMenuItem;
  DesignerMenuDesignerOptions:TMenuItem;
  DesignerMenuSep4:TMenuItem;

  JvInspectorDotNETPainter1: TJvInspectorBorlandPainter;
  JvInspectorDotNETPainter2: TJvInspectorBorlandPainter;

  ELDesigner1: TELDesigner;
  //Specific to Object inspector
  Panel2: TPanel;
  cbxControlsx: TComboBox;
  pgCtrlObjectInspector: TPageControl;
  pnlMainInsp:TPanel;
  TabProperty: TTabSheet;
  JvInspProperties: TJvInspector;
  TabEvent: TTabSheet;
  JvInspEvents: TJvInspector;
  //Specifics for Controls
  lbxControls: TListBox;
  PalleteListPanel: TPanel;
  Palettes: TComboBox;
  frmInspectorDock:TForm;
  //frmClassBrwsDock:TForm;
  frmControlsDock:TForm;
  strChangedFileList:TStringList;
  strStdwxIDList:TStringList;
  FWatchList:TList;
  FileWatching:Boolean;
{$ENDIF}

	function SaveFileInternal(e: TEditor): Boolean;

{$IFDEF WX_BUILD}
    function CreateFormFile(strFName, strCName, strFTitle: string; dlgSStyle:TWxDlgStyleSet;dsgnType:TWxDesignerType): Boolean;
    procedure GetIntialFormData(FCreateFormProp: TfrmCreateFormProp; var strFName, strCName, strFTitle: string; var dlgStyle: TWxDlgStyleSet; dsgnType:TWxDesignerType);
    function CreateSourceCodes(strCppFile,strHppFile:String;FCreateFormProp: TfrmCreateFormProp; var cppCode, hppCode: string; dsgnType:TWxDesignerType): Boolean;
    function CreateAppSourceCodes(strCppFile,strHppFile,strAppCppFile,strAppHppFile:String;FCreateFormProp: TfrmCreateFormProp; var cppCode, hppCode, appcppCode, apphppCode: string; dsgnType:TWxDesignerType): Boolean;
    procedure ReadClass;
    procedure CreatePalettePage(PaletteLst:TStringList;PalettePage: string);
    procedure LoadDefaultPalette;
    procedure LoadComponents;
    procedure resetPallete;
    procedure DisableDesignerControls;
    procedure EnableDesignerControls;
    procedure OnFileChangeNotify(Sender: TObject; ChangeType: TChangeType);
{$ENDIF}

  public
    fProject: TProject;
    fDebugger: TDebugger;
    CacheCreated: boolean;
    {Guru's Code}

    {$IFDEF WX_BUILD}
    strGlobalCurrentFunction:String;
    DisablePropertyBuilding:Boolean;
    boolInspectorDataClear:Boolean;
    intControlCount: Integer;
    SelectedComponentName: string;
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

  end;

var
  MainForm: TMainForm;
      { *** RNC Declare global breakpoint list *** }
    BreakPointList : TList;

implementation

uses
{$IFDEF WIN32}
  ShellAPI, IniFiles, Clipbrd, MultiLangSupport, version,
  devcfg, datamod, helpfrm, NewProjectFrm, AboutFrm, PrintFrm,
  CompOptionsFrm, EditorOptfrm, Incrementalfrm, Search_Center, Envirofrm,
  SynEdit, SynEditTypes,
  CheckForUpdate, debugfrm, Types, Prjtypes, devExec,
  NewTemplateFm, FunctionSearchFm, NewMemberFm, NewVarFm, NewClassFm,
  ProfileAnalysisFm, debugwait, FilePropertiesFm, AddToDoFm, ViewToDoFm,
  ImportMSVCFm, CPUFrm, FileAssocs, TipOfTheDayFm, Splash,
  WindowListFrm, ParamsFrm, WebUpdate, ProcessListFrm, ModifyVarFrm

  {$IFDEF WX_BUILD}
  ,WxBoxSizer, WxStaticBoxSizer,WxGridSizer,
  WxButton, WxBitmapButton,WXCheckBox, WxChoice, WxComboBox, WxEdit, WxGauge, WxListBox, Wxlistctrl,
  WxMemo, WXRadioButton, WxScrollBar,wxGrid,
  WxSlider, WxSpinButton, WxStaticBitmap, WxStaticBox, WxStaticLine,
  WxStaticText, WxTreeCtrl, WxControlPanel,CompFileIo, WXFlexGridSizer,
  wxPanel,wxlistbook,wxnotebook,wxstatusbar,wxtoolbar,
  wxNoteBookPage,wxchecklistbox,wxspinctrl,WxScrolledWindow,
  WxHtmlWindow,WxToolButton,WxSeparator,WxPopupMenu,WxMenuBar,
  WxOpenFileDialog,WxSaveFileDialog,WxFontDialog,
  wxMessageDialog,WxProgressDialog,WxPrintDialog,WxFindReplaceDialog,WxDirDialog,
  WxColourDialog ,WxPageSetupDialog, wxTimer,WxNonVisibleBaseComponent,
  WxSplitterWindow,
  CreateOrderFm,
  ViewIDForm,
  WxToggleButton
  {$ENDIF} // END OF IFEDEF WX_BUILD
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
  IniVersion = 1;
  INT_BRACES= 1;
  INT_TRY_CATCH= 2;
  INT_TRY_FINALLY= 3;
  INT_TRY_CATCH_FINALLY= 4;
  INT_C_COMMENT= 5;
  INT_FOR= 6;
  INT_FOR_I= 7;
  INT_WHILE= 8;
  INT_DO_WHILE= 9;
  INT_IF= 10;
  INT_IF_ELSE= 11;
  INT_SWITCH= 12;
  INT_CPP_COMMENT= 13;



procedure TMainForm.FormCreate(Sender: TObject);
begin
  // copied all to DoCreate
end;
{$IFDEF WX_BUILD}
procedure TMainForm.DoCreateWxSpecificItems;
var
  I: Integer;
  ini :TiniFile;
begin
  //PopuP menu
  frmInspectorDock:=TForm.Create(self);
  //frmClassBrwsDock:=TForm.Create(self);

  frmControlsDock:=TForm.Create(self);
  strChangedFileList:=TStringList.Create;
  strStdwxIDList:=GetPredefinedwxIds;
  FWatchList:=TList.Create;
  FileWatching:=false;
  //LeftPageControl.Owner:=frmClassBrwsDock;
  //LeftPageControl.Parent:=frmClassBrwsDock;

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
  DesignerMenuSep3 := TMenuItem.Create(Self);
  DesignerMenuDesignerOptions:= TMenuItem.Create(Self);
  DesignerMenuSep4:= TMenuItem.Create(Self);

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

  with DesignerMenuSep3 do
  begin
    Name := 'DesignerMenuSep3';
    Caption := '-';
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

  with DesignerMenuSep4 do
  begin
    Name := 'DesignerMenuSep4';
    Caption := '-';
  end;

  with DesignerMenuDesignerOptions do
  begin
    Name := 'DesignerMenuDesignerOptions';
    Caption := 'View Designer Options';
    OnClick := DesignerOptionsClick;
  end;

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
  DesignerPopup.Items.Add(DesignerMenuAlign);
  
  DesignerPopup.Items[DesignerPopup.Items.Find('Align').MenuIndex].Add(DesignerMenuAlignToGrid);

  DesignerPopup.Items[DesignerPopup.Items.Find('Align').MenuIndex].Add(DesignerMenuAlignHorizontal);
  DesignerPopup.Items[DesignerPopup.Items.Find('Align').MenuIndex].Items[DesignerPopup.Items.Find('Align').Find('Horizontal').MenuIndex].Add(DesignerMenuAlignToLeft);
  DesignerPopup.Items[DesignerPopup.Items.Find('Align').MenuIndex].Items[DesignerPopup.Items.Find('Align').Find('Horizontal').MenuIndex].Add(DesignerMenuAlignToMiddleHorizontal);
  DesignerPopup.Items[DesignerPopup.Items.Find('Align').MenuIndex].Items[DesignerPopup.Items.Find('Align').Find('Horizontal').MenuIndex].Add(DesignerMenuAlignToRight);

  DesignerPopup.Items[DesignerPopup.Items.Find('Align').MenuIndex].Add(DesignerMenuAlignVertical);
  DesignerPopup.Items[DesignerPopup.Items.Find('Align').MenuIndex].Items[DesignerPopup.Items.Find('Align').Find('Vertical').MenuIndex].Add(DesignerMenuAlignToTop);
  DesignerPopup.Items[DesignerPopup.Items.Find('Align').MenuIndex].Items[DesignerPopup.Items.Find('Align').Find('Vertical').MenuIndex].Add(DesignerMenuAlignToMiddleVertical);
  DesignerPopup.Items[DesignerPopup.Items.Find('Align').MenuIndex].Items[DesignerPopup.Items.Find('Align').Find('Vertical').MenuIndex].Add(DesignerMenuAlignToBottom);

  DesignerPopup.Items.Add(DesignerMenuSep3);
  DesignerPopup.Items.Add(DesignerMenuDesignerOptions);

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
    //Grid.XStep:=4;
    //Grid.YStep:=4;
    OnContextPopup :=ELDesigner1ContextPopup;
    OnChangeSelection := ELDesigner1ChangeSelection;
    OnControlDeleted := ELDesigner1ControlDeleted;
    OnControlHint := ELDesigner1ControlHint;
    OnControlInserted := ELDesigner1ControlInserted;
    OnControlInserting := ELDesigner1ControlInserting;
    OnKeyDown := ELDesigner1KeyDown;
    OnModified := ELDesigner1Modified;
  end;

      ini := TiniFile.Create(devDirs.Config + 'devcpp.ini');
    try
        ELDesigner1.Grid.Visible:=ini.ReadBool('wxWidgets','cbGridVisible',ELDesigner1.Grid.Visible);
        ELDesigner1.Grid.XStep:=ini.ReadInteger('wxWidgets','lbGridXStepUpDown',ELDesigner1.Grid.XStep);
        ELDesigner1.Grid.YStep:=ini.ReadInteger('wxWidgets','lbGridYStepUpDown',ELDesigner1.Grid.YStep);
        ELDesigner1.SnapToGrid:=ini.ReadBool('wxWidgets','cbSnapToGrid',ELDesigner1.SnapToGrid);
        ELDesigner1.GenerateXRC:=ini.ReadBool('wxWidgets','cbGenerateXRC',ELDesigner1.GenerateXRC);

        if ini.ReadBool('wxWidgets','cbControlHints',true) then
            ELDesigner1.ShowingHints:=ELDesigner1.ShowingHints + [htControl]
        else
            ELDesigner1.ShowingHints:=ELDesigner1.ShowingHints - [htControl];

        if ini.ReadBool('wxWidgets','cbSizeHints',true) then
            ELDesigner1.ShowingHints:=ELDesigner1.ShowingHints + [htSize]
        else
            ELDesigner1.ShowingHints:=ELDesigner1.ShowingHints - [htSize];

        if ini.ReadBool('wxWidgets','cbMoveHints',true) then
            ELDesigner1.ShowingHints:=ELDesigner1.ShowingHints + [htMove]
        else
            ELDesigner1.ShowingHints:=ELDesigner1.ShowingHints - [htMove];
                    
        if ini.ReadBool('wxWidgets','cbInsertHints',true) then
            ELDesigner1.ShowingHints:=ELDesigner1.ShowingHints + [htInsert]
        else
            ELDesigner1.ShowingHints:=ELDesigner1.ShowingHints - [htInsert];
    except
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
    Parent := frmInspectorDock;
    Left := 0;
    Top := 0;
    Width := 196;
    Height := 28;
    Align := alClient;
    BevelOuter := bvNone;
    TabOrder := 0;
    //OnResize := Panel21Resize;
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
    Divider := 125;
    ItemHeight := 16;
    Painter := JvInspectorDotNETPainter1;
    ReadOnly := False;
    UseBands := false;
    WantTabs := true;

    // Add popup menu for Wx property inspector
     OnContextPopup :=WxPropertyInspectorContextPopup;
  
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
    Divider := 125;
    ItemHeight := 16;
    Painter := JvInspectorDotNETPainter2;
    ReadOnly := False;
    UseBands := False;
    WantTabs := False;
    AfterItemCreate := JvInspEventsAfterItemCreate;
    OnDataValueChanged := JvInspEventsDataValueChanged;
    OnItemValueChanged := JvInspEventsItemValueChanged;
    OnItemSelected:= OnPropertyItemSelected;
  end;

  intControlCount := 1000;
  //frmInspectorDock.Width:=100;
  frmInspectorDock.Height:=500;
  //frmInspectorDock.Visible:=true;
  LeftPageControl.Height:=400;
  frmInspectorDock.ManualDock(pnlBrowsers,pnlBrowsers,alTop);
  frmInspectorDock.Visible:=true;
  LeftPageControl.ManualDock(pnlBrowsers,pnlBrowsers,alTop);
  //frmInspectorDock.Height:=400;
  //pnlBrowsers.Height:=500;
  LeftPageControl.Height:=600;

//  for I := 0 to pnlBrowsers.DockClientCount - 1 do    // Iterate
//  begin
//        pnlBrowsers.DockClients[];
//  end;    // for


  //Design Control specifics
  lbxControls := TListBox.Create(Self);
  PalleteListPanel := TPanel.Create(Self);
  Palettes := TComboBox.Create(Self);
  with lbxControls do
  begin
    Name := 'lbxControls';
    Parent := pnlControlHolder;
    Left := 0;
    Top := 25;
    Width := 166;
    Height := 211;
    Style := lbOwnerDrawVariable;
    Align := alClient;
    Color := clBtnFace;
    Enabled := False;
    ItemHeight := 26;
    TabOrder := 0;
    OnClick := lbxControlsClick;
    OnDrawItem := lbxControlsDrawItem;
  end;
  with PalleteListPanel do
  begin
    Name := 'PalleteListPanel';
    Parent := pnlControlHolder;
    Left := 0;
    Top := 0;
    Width := 166;
    Height := 25;
    Align := alTop;
    BevelOuter := bvNone;
    TabOrder := 1;
    OnResize := PalleteListPanelResize;
  end;
  with Palettes do
  begin
    Name := 'Palettes';
    Parent := PalleteListPanel;
    Left := 0;
    Top := 0;
    Width := 135;
    Height := 19;
    Style := csOwnerDrawFixed;
    Anchors := [akLeft, akTop, akRight];
    Enabled := False;
    ItemHeight := 13;
    TabOrder := 0;
    OnChange := PalettesChange;
  end;

    trycatchPopItem.Tag:=INT_TRY_CATCH;
    trycatchPopItem.OnClick:=SurroundWithClick;

    tryfinallyPopItem.Tag:=INT_TRY_FINALLY;
    tryfinallyPopItem.OnClick:=SurroundWithClick;

    trycatchfinallyPopItem.Tag:=INT_TRY_CATCH_FINALLY;
    trycatchfinallyPopItem.OnClick:=SurroundWithClick;

    forloopPopItem.Tag:=INT_FOR;
    forloopPopItem.OnClick:=SurroundWithClick;

    forintloopPopItem.Tag:=INT_FOR_I;
    forintloopPopItem.OnClick:=SurroundWithClick;

    whileLoopPopItem.Tag:=INT_WHILE;
    whileLoopPopItem.OnClick:=SurroundWithClick;

    dowhileLoopPopItem.Tag:=INT_DO_WHILE;
    dowhileLoopPopItem.OnClick:=SurroundWithClick;

    ifLoopPopItem.Tag:=INT_IF;
    ifLoopPopItem.OnClick:=SurroundWithClick;

    ifelseloopPopItem.Tag:=INT_IF_ELSE;
    ifelseloopPopItem.OnClick:=SurroundWithClick;

    switchLoopPopItem.Tag:=INT_SWITCH;
    switchLoopPopItem.OnClick:=SurroundWithClick;

    bracesPopItem.Tag:=INT_BRACES;
    bracesPopItem.OnClick:=SurroundWithClick;

    CStyleCommentPopItem.Tag:=INT_C_COMMENT;
    CStyleCommentPopItem.OnClick:=SurroundWithClick;

    CPPStyleCommentPopItem.Tag:=INT_CPP_COMMENT;
    CPPStyleCommentPopItem.OnClick:=SurroundWithClick;

  //Setting data for the newly created GUI
  LoadComponents;
  intControlCount := 1000;

  //ELPropertyInspector1.Designer:=self.ELDesigner1;

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


procedure TMainForm.DoCreateEverything;
//
// This method is called from devcpp.dpr !
// I removed it from OnCreate, because all this stuff
// take pretty much time and it makes the application like it hangs.
// So while 'Creating' the form is hidden and when it's done, it's displayed
// without 'lag' and it's immediately ready to use ...
//
begin
{$IFDEF WX_BUILD}
  DoCreateWxSpecificItems;
{$ENDIF}

  fFirstShow := TRUE;
  DDETopic := DevCppDDEServer.Name;
  CheckAssociations; // register file associations and DDE services <-- !!!
  DragAcceptFiles(Self.Handle, TRUE);
  dmMain := TdmMain.Create(Self);
  // Set Path
  devDirs.OriginalPath := GetEnvironmentVariable('PATH');
  SetPath(devDirs.Bins);

  fHelpfiles := ToysStringList.Create;
  fTools := TToolController.Create;
  Caption := DEVCPP + ' ' + DEVCPP_VERSION;

  // set visiblity to previous sessions state
  actProjectManager.Checked := devData.ProjectView;
  { begin XXXKF changed}
  if devData.ClassView then
    LeftPageControl.ActivePage := ClassSheet
  else
    LeftPageControl.ActivePage := ProjectSheet;
  actProjectManagerExecute(nil);
  { end XXXKF changed}
  LeftPageControl.Width := devData.ProjectWidth;
  actStatusbar.Checked := devData.Statusbar;
  actStatusbarExecute(nil);

  fProjectCount := 0;
  fProject := nil;
  fCompiler := TCompiler.Create;
  fCompiler.OnLogEntry := LogEntryProc;
  fCompiler.OnOutput := CompOutputProc;
  fCompiler.OnResOutput := CompResOutputProc;
  fCompiler.OnSuccess := CompSuccessProc;

  fDebugger := TDebugger.Create;

  fDebugger.DebugTree := DebugTree;

  SearchCenter.SearchProc := MainSearchProc;
  SearchCenter.PageControl := PageControl;

  MessageControl.Height := devData.OutputHeight;
  fmsgHeight := MessageControl.Height;

  {*** Modified by Peter ***}
  devImageThemes := TDevImageThemeFactory.Create;
  devImageThemes.LoadFromDirectory(devDirs.Themes);

  if devData.First or (devData.Language = '') then
  begin
    if devData.First then
      dmMain.InitHighlighterFirstTime;
    Lang.SelectLanguage;
    if devData.ThemeChange then
      LoadTheme;
    devData.FileDate := FileAge(Application.ExeName);
    devData.First := FALSE;
    //     SaveOptions;
  end
  else begin
    Lang.Open(devData.Language);
    {.$IFNDEF DEBUG}
    {   if devData.Version <> DEVCPP_VERSION then begin
         if MessageDlg('Old configuration files of Dev-C++ have been found on your system.' +#10#13+
                       'This could cause your new Dev-C++ version to not work properly. ' + #10#13 +
                       'Do you want to delete those files  ?' + #10#13 +
                       'If you answer "No" you may need to setup the compiler directories in Compiler Options',
                       mtWarning, [mbYes, mbNo], 0) = mrYes then begin
           if not DeleteFile(devData.INIFile) then
             MessageDlg('Could not delete ' + devData.Inifile, mtError, [mbOK], 0);
           if not DeleteFile(ChangeFileExt(devData.INIFile, '.cfg')) then
             MessageDlg('Could not delete ' + ChangeFileExt(devData.Inifile, '.cfg'), mtError, [mbOK], 0);
           devData.FileDate := FileAge(Application.ExeName);
           MessageDlg('Dev-C++ will now close, please restart it', mtInformation, [mbOK], 0);
           Application.Terminate;
         end
         else
           devData.FileDate := FileAge(Application.ExeName);
        end;
    {$ENDIF}
  end;

  devData.Version := DEVCPP_VERSION;

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
  try
  devShortcuts1.Load;
  except
  end;

  Application.HelpFile := ValidateFile(DEV_MAINHELP_FILE, devDirs.Help, TRUE);
  { copied this part of code to 'DoApplyWindowPlacement' because it forces the form to show

  if devData.WindowPlacement.rcNormalPosition.Right <> 0 then
   SetWindowPlacement(Self.Handle, @devData.WindowPlacement)
  else if not CacheCreated then // this is so weird, but the following call seems to take a lot of time to execute
   Self.Position:= poScreenCenter;      }

  if not DevData.ShowOutput then
    OpenCloseMessageSheet(FALSE);
  actCompOnNeed.Checked := devData.OutputOnNeed;
  actCompOutput.Checked := devData.ShowOutput;

  ToolMainItem.checked := devData.ToolbarMain;
  ToolEditItem.Checked := devData.ToolbarEdit;
  ToolCompileandRunItem.Checked := devData.ToolbarCompile;
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

  MainForm.Constraints.MaxHeight := Monitor.Height;
  MainForm.Constraints.MaxWidth := Monitor.Width;

  //  Application.HintHidePause:=20000;

  fCompiler.RunParams := '';
  devCompiler.UseExecParams := True;

  { *** RNC Create breakpoint list *** }
  BreakPointList := TList.create;
  InitClassBrowser(true {not CacheCreated});
  //variable for clearing up inspector data.
  //Added because there is a AV when adding a function
  //from the event list
  {$IFDEF WX_BUILD}
  boolInspectorDataClear:=True;
  DisablePropertyBuilding:=false;
  {$ENDIF}
end;
{ *** RNC add global breakpoint *** }
procedure TMainForm.AddBreakPointToList(line_number: integer; e: TEditor; filename:string);
var
  APBreakPoint : PBreakPointEntry;
begin
  new(APBreakPoint);
  with APBreakPoint^ do
  begin
        line := line_number;
        file_name := e.TabSheet.Caption;
        editor := e;
  end;
  BreakPointList.Add(APBreakPoint);
end;

function TMainForm.RemoveBreakPointFromList(line_number: integer; e:TEditor) : integer;
var
  i : integer;
begin
Result := -1;
  for i:=0 to BreakPointList.Count -1 do
  begin
      if ((PBreakPointEntry(BreakPointList.Items[i])^.line = line_number) and (PBreakPointEntry(BreakPointList.Items[i])^.editor = e)) then begin
          //Result:= i;
          Result:= PBreakPointEntry(BreakPointList.Items[i])^.breakPointIndex;
          RemoveBreakPointAtIndex(i);
          break;
      end;
  end;
end;

procedure TMainForm.RemoveBreakPointAtIndex(index:integer);
begin
   dispose(BreakPointList.Items[index]);
   BreakPointList.Delete(index);
end;

function TMainForm.GetBreakPointIndex(line_number: integer; e:TEditor) : integer;
var
  i : integer;
begin
Result := -1;
  for i:=0 to BreakPointList.Count -1 do
  begin
      if ((PBreakPointEntry(BreakPointList.Items[i])^.line = line_number) and (PBreakPointEntry(BreakPointList.Items[i])^.editor = e)) then begin
          Result:= i;
          break;
      end;
  end;
end;

procedure TMainForm.RemoveAllBreakPointFromList();
var
  i : integer;
begin
  for i:=0 to BreakPointList.Count -1 do begin
     dispose(BreakPointList.Items[i]);
     BreakPointList.Delete(i);
  end;
end;

{function TMainForm.BreakPointForFile(filename : string) : integer;
var
  i : integer;
begin
  Result := -1;
  for i:=0 to BreakPointList.Count -1 do
  begin
      if PBreakPointEntry(BreakPointList.Items[i])^.file_name = filename then begin
          Result := PBreakPointEntry(BreakPointList.Items[i])^.line;
      end;
  end;
end;   }

{*** modified by peter ***}
procedure TMainForm.DoApplyWindowPlacement;
//
// This method is called from devcpp.dpr !
// It's called at the very last, because it forces the form to show and
// we only want to display the form when it's ready and fully inited/created
//
begin
  if devData.WindowPlacement.rcNormalPosition.Right <> 0 then
    SetWindowPlacement(Self.Handle, @devData.WindowPlacement)
  else
  if not CacheCreated then // this is so weird, but the following call seems to take a lot of time to execute
    Self.Position := poScreenCenter;

  Show;
end;


procedure TMainForm.LoadTheme;
var
  Idx: Integer;
begin
  //Some weird problems I have seen
  try
    XPMenu.Active := devData.XPTheme;
  except
  end;

  try
    if assigned(WebUpdateForm) then
        WebUpdateForm.XPMenu.Active := devData.XPTheme;
  except
  end;

  //if devData.Theme = '' then
  if devImageThemes.IndexOf(devData.Theme) < 0 then
    devData.Theme := devImageThemes.Themes[0].Title; // 0 = New look (see ImageTheme.pas)

// make sure the theme in question is in the list
  Idx := devImageThemes.IndexOf(devData.Theme);
  if Idx > -1 then
  begin
    devImageThemes.ActivateTheme(devData.Theme);

    with devImageThemes do
    begin
      alMain.Images := CurrentTheme.MenuImages;
      MainMenu.Images := CurrentTheme.MenuImages;
      ProjectView.Images := CurrentTheme.ProjectImages;
      MessageControl.Images := CurrentTheme.MenuImages;
      tbMain.Images := CurrentTheme.MenuImages;
      tbCompile.Images := CurrentTheme.MenuImages;
      tbOptions.Images := CurrentTheme.MenuImages;
      tbProject.Images := CurrentTheme.MenuImages;
      tbClasses.Images := CurrentTheme.MenuImages;
      tbedit.Images := CurrentTheme.MenuImages;
      tbSearch.Images := CurrentTheme.MenuImages;
      tbSpecials.Images := CurrentTheme.SpecialImages;
      HelpMenu.SubMenuImages := CurrentTheme.HelpImages;
      HelpPop.Images := CurrentTheme.HelpImages;
      DebugVarsPopup.Images := CurrentTheme.MenuImages;
      ClassBrowser1.Images := CurrentTheme.BrowserImages;


      //this prevent a bug in the VCL
      DDebugBtn.Glyph := nil;
      NextStepBtn.Glyph := nil;
      StepOverBtn.Glyph := nil;
      StepIntoBtn.Glyph := nil;
      AddWatchBtn.Glyph := nil;
      RemoveWatchBtn.Glyph := nil;
      RuntocursorBtn.Glyph := nil;
      StopExecBtn.Glyph := nil;

      CurrentTheme.MenuImages.GetBitmap(32, DDebugBtn.Glyph);
      CurrentTheme.MenuImages.GetBitmap(18, NextStepBtn.Glyph);
      CurrentTheme.MenuImages.GetBitmap(14, StepOverBtn.Glyph);
      CurrentTheme.MenuImages.GetBitmap(14, StepIntoBtn.Glyph);
      CurrentTheme.MenuImages.GetBitmap(21, AddWatchBtn.Glyph);
      CurrentTheme.MenuImages.GetBitmap(5, RemoveWatchBtn.Glyph);
      CurrentTheme.MenuImages.GetBitmap(24, RuntocursorBtn.Glyph);
      CurrentTheme.MenuImages.GetBitmap(11, StopExecBtn.Glyph);

      AddWatchBtn.Glyph.TransparentColor := clWhite;
    end;
  end;

  fTools.BuildMenu; // reapply icons to tools
end;

(*procedure TMainForm.LoadTheme;
begin
  if devData.XPTheme then
    XPMenu.Active := true
  else
    XPMenu.Active := false;
  if devData.Theme = '' then
    devData.Theme := DEV_INTERNAL_THEME;
  with devtheme do
   begin
     if not SetTheme(devData.Theme) then Exit;
     alMain.Images:= Menus;
     MainMenu.Images:= Menus;
     ProjectView.Images:= Projects;
     MessageControl.Images:= Menus;
     tbMain.Images:= Menus;
     tbCompile.Images:= Menus;
     tbOptions.Images:= Menus;
     tbProject.Images:= Menus;
     tbClasses.Images:= Menus;
     tbedit.Images:= Menus;
     tbSearch.Images:= Menus;
     tbSpecials.Images:= Specials;

     HelpMenu.SubMenuImages:= Help;
     HelpPop.Images:= Help;

     DebugVarsPopup.Images:=Menus;

     //this prevent a bug in the VCL
     DDebugBtn.Glyph := nil;
     NextStepBtn.Glyph := nil;
     StepOverBtn.Glyph := nil;
     StepIntoBtn.Glyph := nil;
     AddWatchBtn.Glyph := nil;
     RemoveWatchBtn.Glyph := nil;
     RuntocursorBtn.Glyph := nil;
     StopExecBtn.Glyph := nil;

     Menus.GetBitmap(32, DDebugBtn.Glyph);
     Menus.GetBitmap(18, NextStepBtn.Glyph);
     Menus.GetBitmap(14, StepOverBtn.Glyph);
     Menus.GetBitmap(14, StepIntoBtn.Glyph);
     Menus.GetBitmap(21, AddWatchBtn.Glyph);
     Menus.GetBitmap(5, RemoveWatchBtn.Glyph);
     Menus.GetBitmap(24, RuntocursorBtn.Glyph);
     Menus.GetBitmap(11, StopExecBtn.Glyph);

     AddWatchBtn.Glyph.TransparentColor := clWhite;
   end;
   fTools.BuildMenu; // reapply icons to tools
end; *)

procedure TMainForm.FormShow(Sender: TObject);
begin
  if fFirstShow then
  begin
    LoadTheme;
    BuildHelpMenu;
    dmMain.MRUMenu := ReOpenItem;
    dmMain.MRUOffset := 2;
    dmMain.MRUMax := devData.MRUMax;
    dmMain.MRUClick := MRUClick;
    dmMain.CodeMenu := InsertItem;
    dmMain.CodePop := InsertPopItem;
    dmMain.CodeClick := CodeInsClick;
    dmMain.CodeOffset := 2;
    dmMain.LoadDataMod;

    if ParamCount > 0 then ParseCmdLine;

    MessageControl.ActivePageIndex := 0;
    OpenCloseMessageSheet(devData.ShowOutput);

    if devData.MsgTabs then
      MessageControl.TabPosition := tpTop
    else
      MessageControl.TabPosition := tpBottom;

    SetupProjectView;

    fFirstShow := FALSE;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
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

  //Guru : If we dont disable the designer, AV will popup
  {$IFDEF WX_BUILD}
  DisableDesignerControls;
  {$ENDIF}

  GetWindowPlacement(Self.Handle, @devData.WindowPlacement);

  devData.ClassView := LeftPageControl.ActivePage = ClassSheet;
  devData.ToolbarMainX := tbMain.Left;
  devData.ToolbarMainY := tbMain.Top;
  devData.ToolbarEditX := tbEdit.Left;
  devData.ToolbarEditY := tbEdit.Top;
  devData.ToolbarCompileX := tbCompile.Left;
  devData.ToolbarCompileY := tbCompile.Top;
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

  devData.ProjectWidth := LeftPageControl.Width;
  devData.OutputHeight := fmsgHeight;

  SaveOptions;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  i: integer;
  tmpcount: integer;
begin
  if fDebugger.Executing then
    fDebugger.CloseDebugger(Sender);
  fHelpFiles.free;
  fTools.Free;
  fCompiler.Free;
  fDebugger.Free;
  dmMain.Free;
  devImageThemes.Free;
  {$IFDEF WX_BUILD}
  strChangedFileList.Free; //Used for wx's Own File watch functions
  strStdwxIDList.Free;//Used for
  FWatchList.Free; //Used for wx's Own File watch functions
  {$ENDIF WX_BUILD}
  tmpcount := BreakPointList.Count - 1;
{** RNC Clean up the global breakpoint list *** }
  for i := tmpcount downto 0 do
  begin
    dispose(BreakPointList.Items[i]);
    BreakPointList.Delete(i);
  end;
  BreakPointList.Free;
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
      idx := idx + 2;
    if FileExists(strLst[idx]) then begin
      if GetFileTyp(strLst[idx]) = utPrj then
      begin
        OpenProject(strLst[idx]);
        break; // only open 1 project
      end
      else begin
        {$IFDEF WX_BUILD}
        if iswxForm(strLst[idx]) then
        begin
          OpenFile(ChangeFileExt(strLst[idx], H_EXT), True);
          OpenFile(ChangeFileExt(strLst[idx], CPP_EXT), true);
        end;
        {$ENDIF}
        OpenFile(strLst[idx]);
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
    if fHelpFiles.Count = 0 then exit;

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
    actProjectManager.Caption := Strings[ID_ITEM_PROJECTVIEW];
    actStatusbar.Caption := Strings[ID_ITEM_STATUSBAR];
    CompilerOutputItem.Caption := Strings[ID_SUB_COMPOUTPUT];
    ToolBarsItem.Caption := Strings[ID_SUB_TOOLBARS];
    actCompOutput.Caption := Strings[ID_ITEM_COMPOUTALWAYS];
    actCompOnNeed.Caption := Strings[ID_ITEM_COMPOUTONNEED];

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
    tbProject.Caption := Strings[ID_TOOLPROJECT];
    tbOptions.Caption := Strings[ID_TOOLOPTIONS];
    tbSpecials.Caption := Strings[ID_TOOLSPECIAL];
    actViewToDoList.Caption := Strings[ID_VIEWTODO_MENUITEM];
    FloatingPojectManagerItem.Caption := Strings[ID_ITEM_FLOATWINDOW];
    FloatingReportWindowItem.Caption := Strings[ID_ITEM_FLOATREPORT];
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
    actBreakPoint.Caption := Strings[ID_ITEM_TOGGLEBREAK];
    actAddWatch.Caption := Strings[ID_ITEM_WATCHADD];
    actEditWatch.Caption := Strings[ID_ITEM_WATCHEDIT];
    actModifyWatch.Caption := Strings[ID_ITEM_MODIFYVALUE];
    actRemoveWatch.Caption := Strings[ID_ITEM_WATCHREMOVE];
    actNextStep.Caption := Strings[ID_ITEM_STEPNEXT];
    actStepSingle.Caption := Strings[ID_ITEM_STEPINTO];
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
    CloseSheet.Caption := Strings[ID_SHEET_CLOSE];
    ResSheet.Caption := Strings[ID_SHEET_RES];
    LogSheet.Caption := Strings[ID_SHEET_COMPLOG];
    FindSheet.Caption := Strings[ID_SHEET_FIND];
    DebugSheet.Caption := Strings[ID_SHEET_DEBUG];
    DebugLeftSheet.Caption := Strings[ID_SHEET_DEBUG];
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

    lblSendCommandGdb.Caption := Strings[ID_DEB_SENDGDBCOMMAND];
    GdbCommandBtn.Caption := Strings[ID_DEB_SEND];

    tabVars.Caption := Strings[ID_SHEET_DEBUG];
    tabBacktrace.Caption := Strings[ID_DEB_BACKTRACE];
    tabDebugOutput.Caption := Strings[ID_DEB_OUTPUT];

    with devShortcuts1.MultiLangStrings do begin
      Caption := Strings[ID_SC_CAPTION];
      Title := Strings[ID_SC_TITLE];
      Tip := Strings[ID_SC_TIP];
      HeaderEntry := Strings[ID_SC_HDRENTRY];
      HeaderShortcut := Strings[ID_SC_HDRSHORTCUT];
      Cancel := Strings[ID_SC_CANCEL];
      OK := Strings[ID_SC_OK];
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
  devCompiler.ChangeOptionsLang;
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

function TMainForm.SaveFileAs(e: TEditor): Boolean;
var
  dext,
    flt,
    s: string;
  idx: integer;
  CFilter, CppFilter, HFilter: Integer;
  boolIsForm,boolIsRC,boolISXRC:Boolean;
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
    if fProject.Options.UseGPP then
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
    begin
      FilterIndex := HFilter;
    end else
    begin
      if Assigned(fProject) then
        if fProject.Options.useGPP then
          FilterIndex := CppFilter
        else
          FilterIndex := CFilter
      else
        FilterIndex := CppFilter;
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
        exit;

      e.FileName := s;

      try
           if devEditor.AppendNewline then
             with e.Text do
               if Lines.Count > 0 then
                 if Lines[Lines.Count -1] <> '' then
                   Lines.Add('');
        e.Text.Lines.SaveToFile(s);
        e.Modified := FALSE;
        e.New := FALSE;
      except
        MessageDlg(Lang[ID_ERR_SAVEFILE] + ' "' + s + '"', mtError, [mbOk], 0);
        Result := False;
      end;

      if assigned(fProject) then
        fProject.SaveUnitAs(idx, e.FileName)
      else
        e.TabSheet.Caption := ExtractFileName(e.FileName);

      if ClassBrowser1.Enabled then begin
        CppParser1.AddFileToScan(e.FileName); //new cc
        CppParser1.ParseList;
        ClassBrowser1.CurrentFile := e.FileName;
      end;
    end else
      Result := False;
  end;
end;

function TMainForm.SaveFileInternal(e: TEditor): Boolean;
var
  idx: Integer;
  wa: boolean;
begin
  Result := True;
  if FileExists(e.FileName) and (FileGetAttr(e.FileName) and faReadOnly <> 0) then begin
    // file is read-only
    if MessageDlg(Format(Lang[ID_MSG_FILEISREADONLY], [e.FileName]),mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;
    if FileSetAttr(e.FileName, FileGetAttr(e.FileName) - faReadOnly) <> 0 then begin
      MessageDlg(Format(Lang[ID_MSG_FILEREADONLYERROR], [e.FileName]), mtError, [mbOk], 0);
      Exit;
    end;
  end;

  wa := devFileMonitor1.Active;
  devFileMonitor1.Deactivate;

  {$IFDEF WX_BUILD}
  //Just Generate XPM's while saving the file
  if e.isForm then
        GenerateXPM(e.GetDesigner,e.FileName);
  {$ENDIF}

  if (not e.new) and e.Modified then
  begin // not new but in project (relative path in e.filename)
    if Assigned(fProject) and (e.InProject) then
     begin
       try
      idx := fProject.GetUnitFromEditor(e);
      if idx = -1 then
        MessageDlg(Format(Lang[ID_ERR_SAVEFILE], [e.FileName]), mtError, [mbOk], 0)
         else
        fProject.units[idx].Save;
       except
         MessageDlg(Format(Lang[ID_ERR_SAVEFILE], [e.FileName]),
           mtError, [mbOk], 0);
         Result := False;
         Exit;
       end;
       try
		if idx <> -1 then
        if ClassBrowser1.Enabled then begin
          CppParser1.ReParseFile(fProject.units[idx].FileName, True); //new cc
          if e.TabSheet = PageControl.ActivePage then
            ClassBrowser1.CurrentFile := fProject.units[idx].FileName;
        end;
    except
         MessageDlg(Format('Error reparsing file %s', [e.FileName]),
        mtError, [mbOk], 0);
      Result := False;
       end;
    end
    else // stand alone file (should have fullpath in e.filename)
    try
        if devEditor.AppendNewline then
          with e.Text do
            if Lines.Count > 0 then
              if Lines[Lines.Count -1] <> '' then
                Lines.Add('');
      e.Text.Lines.SaveToFile(e.FileName);
      e.Modified := false;
      if ClassBrowser1.Enabled then begin
        CppParser1.ReParseFile(e.FileName, False); //new cc
        if e.TabSheet = PageControl.ActivePage then
          ClassBrowser1.CurrentFile := e.FileName;
      end;
      //        CppParser1.AddFileToScan(e.FileName);
      //        CppParser1.ParseList;
    except
      MessageDlg(Format(Lang[ID_ERR_SAVEFILE], [e.FileName]), mtError,
        [mbOk], 0);
      Result := False;
    end
  end
  else if e.New then
    Result := SaveFileAs(e);
  if wa then
    devFileMonitor1.Activate;
end;

function TMainForm.SaveFile(e: TEditor): Boolean;
{$IFDEF WX_BUILD}
var
    EditorFilename:String;
    eX:TEditor;
{$ENDIF}
begin
    Result:=false;
    if not assigned(e) then
        exit;

    result:=SaveFileInternal(e);


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
                    SaveFileInternal(eX);
            end;
        end;
        // XRC
        if isFileOpenedinEditor(ChangeFileExt(EditorFilename, XRC_EXT)) then
        begin
            eX:=self.GetEditorFromFileName(ChangeFileExt(EditorFilename, XRC_EXT));
            if assigned(eX) then
            begin
                if eX.Modified then
                    SaveFileInternal(eX);
            end;
        end;
        // XRC
        if isFileOpenedinEditor(ChangeFileExt(EditorFilename, CPP_EXT)) then
        begin
            eX:=self.GetEditorFromFileName(ChangeFileExt(EditorFilename, CPP_EXT));
            if assigned(eX) then
            begin
                if eX.Modified then
                    SaveFileInternal(eX);
            end;
        end;

        if isFileOpenedinEditor(ChangeFileExt(EditorFilename, H_EXT)) then
        begin
            eX:=self.GetEditorFromFileName(ChangeFileExt(EditorFilename, H_EXT));
            if assigned(eX) then
            begin
                if eX.Modified then
                    SaveFileInternal(eX);
            end;
        end;
    end;
   {$ENDIF}

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
  e: TEditor;
  cppEditor,hppEditor,wxEditor,wxXRCEditor:TEditor;
  EditorFilename:String;
  Saved:Boolean;

  procedure CloseEditorInternal(eX: TEditor);
  begin
    if not eX.InProject then
    begin
        dmMain.AddtoHistory(eX.FileName);
        eX.Close;
        //eX:=nil; // because closing the editor will destroy it
    end
    else
    begin
        if eX.IsRes or (not Assigned(fProject)) then
        begin
            eX.Close;
            //eX:=nil; // because closing the editor will destroy it
        end
        else if assigned(fProject) then
            fProject.CloseUnit(fProject.Units.Indexof(eX));
    end;
  end;

begin
  Result := False;
  e := GetEditor(index);
  if not assigned(e) then exit;
  if not AskBeforeClose(e, Rem,Saved) then Exit;

  Result := True;
{$IFDEF WX_BUILD}
  //Guru: My Code starts here
  EditorFilename:=e.FileName;
  if FileExists(ChangeFileExt(e.FileName,WXFORM_EXT)) then begin
    cppEditor:=MainForm.GetEditorFromFileName(ChangeFileExt(EditorFilename, CPP_EXT));
    if assigned(cppEditor) then begin
        if Saved then begin
            cppEditor.Modified:=true;
            SaveFile(cppEditor);
        end
        Else
            cppEditor.Modified:=false;
        CloseEditorInternal(cppEditor);
    end;


    hppEditor:=MainForm.GetEditorFromFileName(ChangeFileExt(EditorFilename, H_EXT));
    if assigned(hppEditor) then begin
        if Saved then begin
            hppEditor.Modified:=true;
            SaveFile(hppEditor);
        end
        Else
            hppEditor.Modified:=false;
        CloseEditorInternal(hppEditor);
    end;

    wxEditor:=MainForm.GetEditorFromFileName(ChangeFileExt(EditorFilename, WXFORM_EXT));
    if assigned(wxEditor) then begin
        if Saved then begin
            wxEditor.Modified:=true;
            SaveFile(wxEditor);
        end
        Else
            wxEditor.Modified:=false;
        CloseEditorInternal(wxEditor);
    end;

    wxXRCEditor:=MainForm.GetEditorFromFileName(ChangeFileExt(EditorFilename, XRC_EXT));
    if assigned(wxXRCEditor) then begin
        if Saved then begin
            wxXRCEditor.Modified:=true;
            SaveFile(wxXRCEditor);
        end
        Else
            wxXRCEditor.Modified:=false;
        CloseEditorInternal(wxXRCEditor);
    end;
  end
  else
{$ENDIF}
    CloseEditorInternal(e);

  //Guru : My Code End;

  e := GetEditor;
  if Assigned(e) then begin
    ClassBrowser1.CurrentFile := e.FileName;
    {$IFDEF WX_BUILD}
    if not e.isForm then
    {$ENDIF}
        e.Text.SetFocus;
  end
  else
  	if (ClassBrowser1.ShowFilter = sfCurrent) or not Assigned(fProject) then
      ClassBrowser1.Clear;
end;

procedure TMainForm.ProjectViewChange(Sender: TObject; Node: TTreeNode);
begin
  { begin XXXKF -- I'm not sure if it should be done SO often }
//  ProjectView.AlphaSort;
//  ProjectVIew.Update;
  { end XXXKF -- I'm not sure if it should be done SO often }
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

procedure TMainForm.OpenCloseMessageSheet;
begin
  //  devData.ShowOutput:= _Show;
  if Assigned(ReportToolWindow) then
    exit;
  with MessageControl do
    if _Show then
      Height := fmsgHeight
    else
    begin
      Height := Height - CompSheet.Height;
      ActivePageIndex := -1;
    end;
  CloseSheet.TabVisible := _Show;
  Statusbar.Top := Self.ClientHeight;
end;

procedure TMainForm.MessageControlChange(Sender: TObject);
begin
  if MessageControl.ActivePage = ResSheet then
    ResSheet.Highlighted := false;
  if MessageControl.ActivePage = CloseSheet then begin
    if Assigned(ReportToolWindow) then begin
      ReportToolWindow.Close;
      MessageControl.ActivePageIndex := 0;
    end
    else
      OpenCloseMessageSheet(false); //MessageControl.Height <> fmsgHeight)
  end
  else
    OpenCloseMessageSheet(TRUE);
end;

procedure TMainForm.MessageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if MessageControl.ActivePage <> CloseSheet then
    fTab := MessageControl.ActivePageIndex;
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
  if assigned(e) = false then
    exit;

        case TMenuItem(Sender).Tag of    //
          INT_BRACES:
                SurroundString(e,'{','}');

          INT_TRY_CATCH:
                SurroundString(e,'try{','}catch() {}');

          INT_TRY_FINALLY:
                SurroundString(e,'try{','}finally { }');

          INT_TRY_CATCH_FINALLY:
                SurroundString(e,'try{','}catch() { } finally{ }');

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
      if not devData.ProjectView then
        actProjectManager.Execute;

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
  if (idx <> -1) then begin
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
  begin
    dmMain.RemoveFromHistory(s);
    // mandrav: why hide the class browser? (even if no project open - just a source file)
//     if devData.ProjectView then
//      actProjectManager.Execute;
  end;

  if not withoutActivation then
    e.activate;
  if not assigned(fProject) then
    CppParser1.ReParseFile(e.FileName, e.InProject, True);
  //  ClassBrowser1.CurrentFile:=e.FileName;
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

  if MessageControl.ActivePage <> CompSheet then
    MessageControl.ActivePage := CompSheet;

  if actCompOnNeed.Checked then
  begin
    OpenCloseMessageSheet(TRUE);
  end;
end;

procedure TMainForm.CompResOutputProc(const _Line, _Unit, _Message: string);
begin
  if (_Line <> '') and (_Unit <> '') then
    ResourceOutput.Items.Add('Line ' + _Line + ' in file ' + _Unit + ' : ' +_Message)
  else
    ResourceOutput.Items.Add(_Message);
  ResSheet.Highlighted := true;
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

  if (messages = 0) and actCompOnNeed.Checked then
    OpenCloseMessageSheet(FALSE);
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
begin
  if assigned(ProjectView.Selected) then
    Node := ProjectView.Selected
  else
  begin
    pt := ProjectView.ScreenToClient(Mouse.CursorPos);
    Node := ProjectView.GetNodeAt(pt.x, pt.y);
  end;
  if assigned(Node) { begin XXXKF } and (integer(Node.Data) <> -1) { end XXXKF } then
    if (Node.Level >= 1) then
    begin
      i := integer(Node.Data);
      //Added for wx.
      //This will allow DevC++ to open custom program
      //as assigned by the user like VC++
      if OpenWithAssignedProgram(fProject.Units[i].FileName) = true then
        Exit;
      FileIsOpen(fProject.Units[i].FileName, TRUE);
      //Added By wx
      if isFileOpenedinEditor(fProject.Units[i].FileName) then
        e :=GetEditorFromFileName(fProject.Units[i].FileName)
      else
        e := fProject.OpenUnit(i);
      if assigned(e) then
      begin
        //Guru : My Code Starts Here
        {$IFDEF WX_BUILD}
        EditorFilename:=e.FileName;
        if FileExists(ChangeFileExt(EditorFilename,WXFORM_EXT)) then
        begin
          if FileExists(ChangeFileExt(EditorFilename, WXFORM_EXT)) then
          begin
            if not isFileOpenedinEditor(ChangeFileExt(EditorFilename, WXFORM_EXT)) then
                MainForm.OpenFile(ChangeFileExt(EditorFilename, WXFORM_EXT), true);
          end;

           if FileExists(ChangeFileExt(EditorFilename, XRC_EXT)) then
          begin
            if not isFileOpenedinEditor(ChangeFileExt(EditorFilename, XRC_EXT)) then
                MainForm.OpenFile(ChangeFileExt(EditorFilename, XRC_EXT), true);
          end;

          if FileExists(ChangeFileExt(EditorFilename, H_EXT)) then
          begin
            if not isFileOpenedinEditor(ChangeFileExt(EditorFilename, H_EXT)) then
                MainForm.OpenFile(ChangeFileExt(EditorFilename, H_EXT), true);
          end;

          if FileExists(ChangeFileExt(EditorFilename, CPP_EXT)) then
          begin
            if not isFileOpenedinEditor(ChangeFileExt(EditorFilename, CPP_EXT)) then
                MainForm.OpenFile(ChangeFileExt(EditorFilename, CPP_EXT), true);
          end;

          //Reactivate the editor;
          if FileExists(EditorFilename) then
          begin
            if not isFileOpenedinEditor(EditorFilename) then
                MainForm.OpenFile(EditorFilename, true)
            else
            begin
                GetEditorFromFileName(EditorFilename).Activate;
            end;
          end;

        end;
    // Guru : My Code Ends here
    {$ENDIF}
        e.Activate;
        //        ClassBrowser1.CurrentFile:=e.FileName;
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
    if MessageDlg(Lang[ID_MSG_NEWFILE], mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      actProjectNewExecute(Sender);
      exit;
    end;
  end;
  //  else
  //   // no open project, but open source file close project manager
  //   if actProjectManager.Checked then
  //    actProjectManager.Execute;
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

      if not devData.ProjectView then
        actProjectManager.Execute;
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
  NewEditor.init(InProject, fname, '',
  	FALSE, TRUE);
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
  idx: integer;
  wa: boolean;
  e: TEditor;
begin
  wa := devFileMonitor1.Active;
  devFileMonitor1.Deactivate;
  if assigned(fProject) then begin
    fProject.Save;
    UpdateAppTitle;
    if CppParser1.Statements.Count = 0 then // only scan entire project if it has not already been scanned...
      ScanActiveProject;
  end;

  for idx := 0 to pred(PageControl.PageCount) do begin
    e := GetEditor(idx);
    if (e.Modified) and ((not e.InProject) or (e.IsRes) {$IFDEF WX_BUILD} or (e.isForm){$ENDIF} ) then
      if not SaveFile(GetEditor(idx)) then
        Break;
  end;

  if wa then
    devFileMonitor1.Activate;
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
  wa: boolean;
{ I: integer;}
begin
  actStopExecute.Execute;
  wa := devFileMonitor1.Active;
  devFileMonitor1.Deactivate;

  // save project layout anyway ;)
  fProject.CmdLineArgs := fCompiler.RunParams;
  fProject.SaveLayout;

  //Added for wx problems : Just close all the file
  //tabs before closing the project
  actCloseAll.Execute;

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

  // not true anymore, this resulted in an AV
  {
  // mandrav: close all open project resources (the project does *not* closes them itself...)
  I := 0;
  while I < PageControl.PageCount do begin
    if TEditor(PageControl.Pages[i].Tag).IsRes and TEditor(PageControl.Pages[i].Tag).InProject then
      TEditor(PageControl.Pages[i].Tag).Close
    else
    begin
      if TEditor(PageControl.Pages[i].Tag).isForm() then begin
      	TEditor(PageControl.Pages[i].Tag).Close;
      end;
      Inc(I);
    end;
  end;}

  try
    FreeandNil(fProject);
  except
  	fProject:=nil;
  end;

  ProjectView.Items.Clear;
  ClearMessageControl;
  UpdateAppTitle;
  ClassBrowser1.ProjectDir := '';
  CppParser1.Reset;

  if wa then
    devFileMonitor1.Activate;
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
      if JvInspProperties.Focused then  // If property inspector is focused, then cut text
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
      if JvInspProperties.Focused then  // If property inspector is focused, then copy text
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
      if JvInspProperties.Focused then  // If property inspector is focused, then paste text
        actWxPropertyInspectorPaste.Execute
      else   // Otherwise form component is selected so paste whole component (control and code)
        actDesignerPaste.Execute
      else
        e.Text.PasteFromClipboard;
   end;
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

procedure TMainForm.actProjectManagerExecute(Sender: TObject);
begin
  if (DebugSubPages.Parent <> self) and assigned(ProjectToolWindow) then
    ProjectToolWindow.Close;
    if actProjectManager.Checked then
    begin
    	//if the panel which holds the Browser Tab is
    	//visible, v'll make it visible
    	if LeftPageControl.Visible = false then
			LeftPageControl.Visible:=true;
    end;
  pnlBrowsers.Visible := actProjectManager.Checked;
  devData.ProjectView := actProjectManager.Checked;
end;

procedure TMainForm.actStatusbarExecute(Sender: TObject);
begin
  devData.Statusbar := actStatusbar.Checked;
  Statusbar.Visible := actStatusbar.Checked;
  Statusbar.Top := Self.ClientHeight;
end;

procedure TMainForm.actCompOutputExecute(Sender: TObject);
begin
  // sudo radio with actCompOnNeed
  MessageControl.TabIndex := fTab;
  if AlwaysShowItem.Checked then
    OpenCloseMessageSheet(TRUE)
  else if not actCompOnNeed.Checked then
    OpenCloseMessageSheet(FALSE);

  if actCompOutput.Checked then
    actCompOnNeed.Checked := False
  else if (not actCompOutput.Checked) and
    (not actCompOnNeed.Checked) then
    OpenCloseMessageSheet(False);
  devData.ShowOutput := actCompOutput.Checked;
  devData.OutputOnNeed := actCompOnNeed.Checked;
end;

procedure TMainForm.actCompOnNeedExecute(Sender: TObject);
begin
  if actCompOnNeed.Checked then
    OpenCloseMessageSheet(FALSE)
  else if (not actCompOutput.Checked) and
    (not actCompOnNeed.Checked) then
    OpenCloseMessageSheet(False);
  devData.ShowOutput := actCompOutput.Checked;
  devData.OutputOnNeed := actCompOnNeed.Checked;
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
  if not assigned(ProjectView.Selected) or
  	(ProjectView.Selected.Level < 1) then exit;

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
    devFileMonitor1.Deactivate;// deactivate for renaming or a message will raise
    Renamefile(OldName, NewName);
    devFileMonitor1.Activate;
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
    VersionLabel.Caption := VersionLabel.Caption + DEVCPP_VERSION;
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

{ begin XXXKF changed }

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
    begin
      OpenCloseMessageSheet(TRUE);
      MessageControl.ActivePage := FindSheet;
    end;
  SearchCenter.Project := nil;
end;

procedure TMainForm.actFindAllExecute(Sender: TObject);
begin
  SearchCenter.SingleFile := FALSE;
  SearchCenter.Project := fProject;
  SearchCenter.Replace := false;
  SearchCenter.Editor := GetEditor;
  if SearchCenter.ExecuteSearch then
  begin
    OpenCloseMessageSheet(TRUE);
    MessageControl.ActivePage := FindSheet;
  end;
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

function TMainForm.PrepareForCompile: Boolean;
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
  ResSheet.Highlighted := false;
  SizeFile.Text := '';
  TotalErrors.Text := '0';
  //if actCompOutput.Checked or actCompOnNeed.Checked then
  // begin

  if not devData.ShowProgress then begin
    // if no compile progress window, open the compiler output
    OpenCloseMessageSheet(True);
    MessageControl.ActivePage := LogSheet;
  end;

  // end;

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

  if Assigned(fProject) then begin
    if fProject.Options.VersionInfo.AutoIncBuildNr then
      fProject.IncrementBuildNumber;
    fProject.BuildPrivateResource;
  end;

  Result := True;
end;

procedure TMainForm.actCompileExecute(Sender: TObject);
begin
  if fCompiler.Compiling then
  begin
    MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
    Exit;
  end;
  if not PrepareForCompile then
    Exit;
  if fCompiler.Target = ctProject then
    DeleteFile(fProject.Executable);
  fCompiler.Compile;
  Application.ProcessMessages;
end;

procedure TMainForm.actRunExecute(Sender: TObject);
var
  e: TEditor;
begin
  e := GetEditor;
  fCompiler.Target := ctNone;

  if assigned(fProject) then
  begin
    if assigned(e) and (not e.InProject) then
      fCompiler.Target := ctFile
    else
      fCompiler.Target := ctProject;
  end
  else
  if assigned(e) then
    fCompiler.Target := ctFile;

  if fCompiler.Target = ctFile then
    fCompiler.SourceFile := e.FileName;

  fCompiler.Run;
end;

procedure TMainForm.actCompRunExecute(Sender: TObject);
begin
  if fCompiler.Compiling then
  begin
    MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
    Exit;
  end;
  if not PrepareForCompile then
    Exit;
  fCompiler.CompileAndRun;
end;

procedure TMainForm.actRebuildExecute(Sender: TObject);
begin
  if fCompiler.Compiling then
  begin
    MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
    Exit;
  end;
  if not PrepareForCompile then
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

procedure TMainForm.PrepareDebugger;
var
  idx: integer;
  sl: TStringList;
begin
  actStopExecute.Execute;
  DebugOutput.Clear;
  LeftPageControl.ActivePage := DebugLeftSheet;
  MessageControl.ActivePage := DebugSheet;
  OpenCloseMessageSheet(True);

  fDebugger.ClearIncludeDirs;

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

procedure TMainForm.actDebugExecute(Sender: TObject);
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
      exit;
    end;
    if fProject.Options.typ = dptDyn then begin
      if fProject.Options.HostApplication = '' then begin
        MessageDlg(Lang[ID_ERR_HOSTMISSING], mtWarning, [mbOK], 0);
        exit;
      end
      else if not FileExists(fProject.Options.HostApplication) then begin
        MessageDlg(Lang[ID_ERR_HOSTNOTEXIST], mtWarning, [mbOK], 0);
        exit;
      end;
    end;

    fDebugger.FileName := '"' + StringReplace(fProject.Executable, '\', '\\', [rfReplaceAll]) + '"';

    // add to the debugger the project include dirs
    for idx := 0 to fProject.Options.Includes.Count - 1 do
      fDebugger.AddIncludeDir(fProject.Options.Includes[idx]);

    fDebugger.Execute;
    fDebugger.SendCommand(GDB_FILE, fDebugger.FileName);
    fDebugger.SendCommand(GDB_SETARGS, fCompiler.RunParams);
     {for idx:= 0 to pred(PageControl.PageCount) do begin
      e := GetEditor(idx);
      // why used to enter breakpoints only in project files?
      // did it have something to do with the debugger's include dirs? ;)
      if e.Breakpoints.Count > 0 then
        for idx2 := 0 to pred(e.Breakpoints.Count) do
          fDebugger.AddBreakPoint(e, integer(e.Breakpoints[idx2]));
     end;}
     for idx:=0 to BreakPointList.Count -1 do begin
        PBreakPointEntry(BreakPointList.Items[idx])^.breakPointIndex := fDebugger.AddBreakpoint(idx);
    end;
    if fProject.Options.typ = dptDyn then begin
      fDebugger.SendCommand(GDB_EXECFILE, '"' + StringReplace(fProject.Options.HostApplication, '\', '\\', [rfReplaceAll])+ '"');
    end
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
      fDebugger.FileName := '"' +
        StringReplace(ChangeFileExt(ExtractFileName(e.FileName), EXE_EXT), '\', '\\', [rfReplaceAll]) + '"';
      fDebugger.Execute;
      fDebugger.SendCommand(GDB_FILE, fDebugger.FileName);
      fDebugger.SendCommand(GDB_SETARGS, fCompiler.RunParams);
        for idx2:=0 to BreakPointList.Count -1 do begin
           PBreakPointEntry(BreakPointList.Items[idx2])^.breakPointIndex := fDebugger.AddBreakpoint(idx2);
        end;
        {if (e.Breakpoints.Count > 0) then
        for idx2 := 0 to pred(e.Breakpoints.Count) do
            fDebugger.AddBreakPoint(e, integer(e.Breakpoints[idx2]));}
    end;
  end;

  //DebugTree.Items.Clear;

  for idx := 0 to DebugTree.Items.Count - 1 do begin
    idx2 := AnsiPos('=', DebugTree.Items[idx].Text);
    if (idx2 > 0) then begin
      s := DebugTree.Items[idx].Text;
      Delete(s, idx2 + 1, length(s) - idx2);
      DebugTree.Items[idx].Text := s + ' ?';
    end;
  end;

  // Run the debugger
  fDebugger.SendCommand(GDB_RUN, '');

  // RNC 07.02.2004 -- Now that the debugger has started, set broken to false (see debugwait.pas for explaination of broken)
  fDebugger.SetBroken(false);
end;

procedure TMainForm.actEnviroOptionsExecute(Sender: TObject);
begin
  with TEnviroForm.Create(Self) do
  try
    if ShowModal = mrok then
    begin
      SetupProjectView;
      if devData.MsgTabs then
        MessageControl.TabPosition := tpTop
      else
        MessageControl.TabPosition := tpBottom;
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
  (Sender as TCustomAction).Enabled := (assigned(fProject) or (PageControl.PageCount > 0)) and
    not devExecutor.Running;
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
  if (assigned(e)) then
  begin
  //Added for wx problems.
  //Some weird error pops when doing an Update
    try
        (Sender as TAction).Enabled := (e.Text.Text <> '');
    except
    end;
  end
  else
    (Sender as TAction).Enabled := false;
end;

procedure TMainForm.actUpdateDebuggerRunning(Sender: TObject);
begin
  (Sender as TAction).Enabled := fDebugger.Executing;
end;

procedure TMainForm.ToolbarClick(Sender: TObject);
begin
  tbMain.Visible := ToolMainItem.checked;
  tbEdit.Visible := ToolEditItem.Checked;
  tbCompile.Visible := ToolCompileandRunItem.Checked;
  tbProject.Visible := ToolProjectItem.Checked;
  tbOptions.Visible := ToolOptionItem.Checked;
  tbSpecials.Visible := ToolSpecialsItem.Checked;
  tbSearch.Visible := ToolSearchItem.Checked;
  tbClasses.Visible := ToolClassesItem.Checked;
  //  ProjectView.Visible:= actProjectManager.Checked;

  devData.ToolbarMain := ToolMainItem.checked;
  devData.ToolbarEdit := ToolEditItem.Checked;
  devData.ToolbarCompile := ToolCompileandRunItem.Checked;
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

procedure TMainForm.SplitterBottomCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  accept := MessageControl.Height = fmsgHeight;
end;

procedure TMainForm.SplitterBottomMoved(Sender: TObject);
begin
  if MessageControl.ActivePageIndex <> -1 then begin
    if MessageControl.Height > 0 then
      fmsgHeight := MessageControl.Height;
    OpenCloseMessageSheet(true);
  end;
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
begin
  case MessageControl.ActivePageIndex of
    cCompTab:
      if assigned(CompilerOutput.Selected) then begin
     	Clipboard.AsText:= StringReplace(
                        StringReplace(
                        CompilerOutput.Selected.Caption +' ' +
                        CompilerOutput.Selected.SubItems.Text
                        , #13#10, ' ', [rfReplaceAll])
                        , #10, ' ', [rfReplaceAll])
      end;

    cResTab:
      if Resourceoutput.ItemIndex <> -1 then
        Clipboard.AsText := ResourceOutput.Items[ResourceOutput.ItemIndex];

    cLogTab:
      if LogOutput.Lines.Text <> '' then
        if Length(LogOutput.SelText) > 0 then
          Clipboard.AsText := LogOutput.SelText
        else
          Clipboard.AsText := LogOutput.Lines.Text;
    cFindTab:
      if assigned(FindOutput.Selected) then
        Clipboard.AsText := FindOutput.Selected.Caption + ' ' +
          FindOutput.Selected.SubItems.Text;
  end;
end;

procedure TMainForm.actMsgClearExecute(Sender: TObject);
begin
  case MessageControl.ActivePageIndex of
   cCompTab: CompilerOutput.Items.Clear;
   cResTab:  ResourceOutput.Items.Clear;
    cLogTab: LogOutput.Clear;
   cFindTab: FindOutput.Items.Clear;
  end;
end;

procedure TMainForm.actMsgHideExecute(Sender: TObject);
begin
  OpenCloseMessageSheet(MessageControl.Height <> fmsgHeight);
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

//Added for wx : Modifications to this function is for
//Original DevC++ was not parsing certain error lines properly
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
  case key of
{$IFDEF WIN32}
    vk_F6:
{$ENDIF}
{$IFDEF LINUX}
   XK_F6:
{$ENDIF}
      if ssCtrl in Shift then ShowDebug;
end;
    
{$IFDEF WX_BUILD}
if (ssCtrl in Shift) and MainForm.ELDesigner1.Active and not JvInspProperties.Focused and not JvInspEvents.Focused then   // If Designer Form is in focus
begin
  case key of
// Move the wx components around
  vk_Left :
    for i := 0 to (ELDesigner1.SelectedControls.Count - 1) do
        ELDesigner1.SelectedControls.Items[i].Left := ELDesigner1.SelectedControls.Items[i].Left - 1;
   vk_Right :
    for i := 0 to (ELDesigner1.SelectedControls.Count - 1) do
        ELDesigner1.SelectedControls.Items[i].Left := ELDesigner1.SelectedControls.Items[i].Left + 1;

   vk_Up :
    for i := 0 to (ELDesigner1.SelectedControls.Count - 1) do
        ELDesigner1.SelectedControls.Items[i].Top := ELDesigner1.SelectedControls.Items[i].Top - 1;

   vk_Down :
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

  if PageControl.PageCount <= 0 then
    result := nil
  else
    result := TEditor(PageControl.Pages[i].Tag);
end;

procedure TMainForm.MessagePopupPopup(Sender: TObject);
begin
  if MessageControl.ActivePage = DebugSheet then begin
    MsgCopyItem.Enabled := false;
    MsgClearItem.Enabled := false;
  end
  else begin
    MsgCopyItem.Enabled := true;
    MsgClearItem.Enabled := true;
  end;
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
  if fDebugger.Executing then begin
//  if fDebugger.isBroken and fDebugger.Executing then begin
    fDebugger.RefreshContext();
    fDebugger.SendCommand(GDB_DISPLAY, s);
  end;
end;

procedure TMainForm.actNextStepExecute(Sender: TObject);
begin
  //if fDebugger.Executing then begin
  if fDebugger.isBroken and fDebugger.Executing then begin
    fDebugger.RefreshContext();
    fDebugger.SendCommand(GDB_NEXT, '');
  end;
end;

procedure TMainForm.actStepSingleExecute(Sender: TObject);
begin
  //if fDebugger.Executing then begin
  if fDebugger.isBroken and fDebugger.Executing then begin
    fDebugger.RefreshContext();
    fDebugger.SendCommand(GDB_STEP, '');
  end;
end;

procedure TMainForm.actWatchItemExecute(Sender: TObject);
begin
  LeftPageControl.ActivePage := DebugLeftSheet;
end;

procedure TMainForm.actRemoveWatchExecute(Sender: TObject);
var node: TTreeNode;
begin
  node := DebugTree.Selected;
  while Assigned(Node) and (Assigned(node.Parent)) do begin
    node := node.Parent;
  end;
  if (Assigned(node)) then begin
    try
      fDebugger.SendCommand(GDB_UNDISPLAY, IntToStr(integer(node.Data)));
    except
    end;
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
  if fDebugger.isBroken and fDebugger.Executing then begin
//  if fDebugger.Executing then begin
    RemoveActiveBreakpoints;
    fDebugger.RefreshContext();
    fDebugger.SendCommand(GDB_CONTINUE, '');
    // RNC 07.02.2004 -- Set broken to false when the user presses continue
    fDebugger.SetBroken(false);
  end;
end;

procedure TMainForm.actStopExecuteExecute(Sender: TObject);
begin
  if fDebugger.Executing then begin
    fDebugger.CloseDebugger(sender);
  end;
end;

procedure TMainForm.actUndoUpdate(Sender: TObject);
var
  e: TEditor;
begin
  e := GetEditor;
  actUndo.Enabled := assigned(e) and e.Text.CanUndo;
end;

procedure TMainForm.actRedoUpdate(Sender: TObject);
var
  e: TEditor;
begin
  e := GetEditor;
  actRedo.enabled := assigned(e) and e.Text.CanRedo;
end;

procedure TMainForm.actCutUpdate(Sender: TObject);
var
  e: TEditor;
begin
  e := GetEditor;
  if assigned(e) then
  begin
    if e.isForm then
        actCut.Enabled := e.isForm
    else
      actCut.Enabled := assigned(e) and e.Text.SelAvail;
  end;
end;

procedure TMainForm.actCopyUpdate(Sender: TObject);
var
  e: TEditor;
begin
  e := GetEditor;

  if assigned(e) then
  begin
    if e.isForm then
        actCopy.Enabled := e.isForm
    else
        actCopy.Enabled := assigned(e) and e.Text.SelAvail;
  end;
end;

procedure TMainForm.actPasteUpdate(Sender: TObject);
var
  e: TEditor;
begin
  e := GetEditor;

  if assigned(e) then
  begin
    if e.isForm then
        actPaste.Enabled := e.isForm
    else
      actPaste.Enabled := assigned(e) and e.Text.CanPaste;
  end;
end;

procedure TMainForm.actSaveUpdate(Sender: TObject);
var
  e: TEditor;
begin
 //Added for wx: Try catch for Some weird Error
  try
    e := GetEditor;
    actSave.Enabled := assigned(e) and (e.Modified or e.Text.Modified or (e.FileName = ''));
  except
     //e:=nil;
  end;
end;

procedure TMainForm.actSaveAsUpdate(Sender: TObject);
var
  e: TEditor;
begin
  e := GetEditor;
  actSaveAs.Enabled := assigned(e);
end;

procedure TMainForm.actFindNextUpdate(Sender: TObject);
var
  e: TEditor;
begin
  e := GetEditor;
  // ** need to also check if a search has already happened
  actFindNext.Enabled := assigned(e) and (e.Text.Text <> '');
end;

procedure TMainForm.MessageControlContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  if MessageControl.Height <> fmsgHeight then
    Handled := TRUE;
end;

procedure TMainForm.ClearMessageControl;
begin
  CompilerOutput.Items.Clear;
  FindOutput.Items.Clear;
  ResourceOutput.Clear;
  LogOutput.Clear;
  DebugOutput.Clear;
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

function TMainForm.GetEditorFromFileName(ffile: string): TEditor;
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
        result := fProject.OpenUnit(index)
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
  LogOutput.Width := CompResGroupBox.Width - 15;
end;

procedure TMainForm.InitClassBrowser(Full: boolean);
var
  e: TEditor;
  sl: TStringList;
  I: integer;
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
      for I := 0 to fProject.Options.Includes.Count - 1 do
        AddProjectIncludePath(fProject.Options.Includes[I]);
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
    StatusBar.Panels[3].Text := 'Parsing ' + Filename
  else
    StatusBar.Panels[3].Text := 'Done parsing.';
  StatusBar.Refresh;
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
  if not PrepareForCompile then
    Exit;
  fCompiler.CheckSyntax;
end;

procedure TMainForm.actUpdateExecute(Sender: TObject);
begin
  if Assigned(fProject) then
    (Sender as TCustomAction).Enabled := not (fProject.Options.typ = dptStat)
  else
    (Sender as TCustomAction).Enabled := PageControl.PageCount > 0;
end;

procedure TMainForm.actRunUpdate(Sender: TObject);
begin
  if Assigned(fProject) then
    (Sender as TCustomAction).Enabled := not (fProject.Options.typ = dptStat) and not devExecutor.Running and not fDebugger.Executing and not fCompiler.Compiling
  else
    (Sender as TCustomAction).Enabled := (PageControl.PageCount > 0) and not devExecutor.Running and not fDebugger.Executing and not fCompiler.Compiling;
end;

procedure TMainForm.PageControlChange(Sender: TObject);
var
  e: TEditor;
  i, x, y: integer;
  intActivePage:Integer;
begin
  intActivePage:=PageControl.ActivePageIndex;
  if ClassBrowser1.Enabled then begin
    if intActivePage > -1 then begin
      e := GetEditor(intActivePage);
      if Assigned(e) then
      begin
        {$IFDEF WX_BUILD}
        if e.isForm() then
        begin
          try
            MainForm.ELDesigner1.Active:=false;
            MainForm.ELDesigner1.DesignControl:=e.GetDesigner;
          except
          end;
          EnableDesignerControls;
          e.ActivateDesigner
        end
        else
        {$ENDIF}
        begin
          {$IFDEF WX_BUILD}
           MainForm.ELDesigner1.Active:=false;
          //MainForm.ELDesigner1.DesignControl:=nil;
          {$ENDIF}
          e.Text.SetFocus;
          ClassBrowser1.CurrentFile := e.FileName;
        end;

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
  end

  Else
  begin
    //ToDO: I have to make sure I dont repeat the same code
    //I have in the if clause
    {$IFDEF WX_BUILD}
    if intActivePage > -1 then
    begin
        e := GetEditor(intActivePage);
        if Assigned(e) then
        begin
            if e.isForm() then
            begin
                EnableDesignerControls;
                e.ActivateDesigner
            end

        end;
    end;
    {$ENDIF}
  end;
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
    (Sender as TCustomAction).Enabled := not (fProject.Options.typ = dptStat) and devExecutor.Running
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
begin
  I := PageControl.IndexOfTabAt(X, Y);
  if Button = mbRight then begin // select new tab even with right mouse button
    if I > -1 then begin
      PageControl.ActivePageIndex := I;
      PageControlChange(nil);
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
  // see if profiling is enabled
  prof := devCompiler.FindOption('-pg', optP, idxP);
  if prof then begin
    if Assigned(fProject) then begin
      if (fProject.Options.CompilerOptions <> '') and (fProject.Options.CompilerOptions[idxP + 1] = '1') then
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
      if (fProject.Options.CompilerOptions <> '') and (fProject.Options.CompilerOptions[idxD + 1] = '1') then
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
        if not Assigned(MainForm.fProject) then
          devCompiler.Options[idxD] := optD; // set global debugging option only if not working with a project
        MainForm.SetProjCompOpt(idxD, False);// set the project's correpsonding option too
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
begin
  current := PageControl.ActivePageIndex;
  for idx := 0 to current - 1 do
    if not CloseEditor(0, True) then
      Break;

  // our editor is now first
  for idx := 1 to PageControl.PageCount - 1 do
    if not CloseEditor(PageControl.PageCount - 1, True) then
      Break;

  e := GetEditor;
  if Assigned(e) then begin
    // don't know why, but at this point the editor does not show its caret.
    // if we shift the focus to another control and back to the editor,
    // everything is fine. (I smell another SynEdit bug?)
    e.TabSheet.SetFocus;
   {$IFDEF WX_BUILD}
    if not e.isForm then
        e.Text.SetFocus;
   {$ENDIF}
   {$IFNDEF WX_BUILD}
    e.Text.SetFocus;
   {$ENDIF}

  end;
end;

procedure TMainForm.DebugSubPagesChange(Sender: TObject);
var
  I: integer;
  csl: TList;
begin
  if DebugSubPages.ActivePage = tabBacktrace then begin
    lvBacktrace.Items.BeginUpdate;
    lvBacktrace.Items.Clear;
    if fDebugger.Executing then begin

      // create the debugger's call stack beforehand
      csl := fDebugger.CallStack;
      if Assigned(csl) then begin
        csl.Clear;
        fDebugger.SendCommand(GDB_BACKTRACE, '');
        Sleep(200); // delay for the command to execute
      end;

      csl := fDebugger.CallStack;
      if Assigned(csl) then begin
        for I := 0 to csl.Count - 1 do
          with lvBacktrace.Items.Add do begin
            Caption := PCallStack(csl[I])^.FuncName;
            SubItems.Add(PCallStack(csl[I])^.Args);
            SubItems.Add(PCallStack(csl[I])^.Filename);
            SubItems.Add(IntToStr(PCallStack(csl[I])^.Line));
            Data := CppParser1.Locate(Caption, True);
          end;
      end;
    end;
    lvBacktrace.Items.EndUpdate;
  end
    {  else if DebugSubPages.ActivePage = tabWindowMode then begin
         try
           f := TForm.Create(self);
           with f do begin
             Caption := Lang.Strings[ID_TB_DEBUG];
             Top := self.Top + MessageControl.Top + DebugSubPages.Top;
             Left := self.Left + DebugSubPages.Left;
             Height := DebugSubPages.Height + 40;
             Width := DebugSubPages.Width;
             FormStyle := fsStayOnTop;
             OnClose := DebugWindowClose;
             BorderStyle := bsSizeable;
             BorderIcons := [biSystemMenu];
           end;
           DebugSubPages.ActivePageIndex := 0;
           tabWindowMode.TabVisible := false;
           DebugSubPages.Visible := false;
           MessageControl.RemoveControl(DebugSubPages);
           RemoveControl(DebugSubPages);

           f.InsertControl(DebugSubPages);
           DebugSubPages.Left := 0;
           DebugSubPages.Top := 0;
           DebugSubPages.Align := alClient;
           DebugSubPages.Visible := true;
           f.Show;
         except

         end;
      end; }
end;

procedure TMainForm.lvBacktraceDblClick(Sender: TObject);
var
  idx: integer;
  e: TEditor;
begin
  if Assigned(lvBacktrace.Selected) then begin
    idx := StrToIntDef(lvBacktrace.Selected.SubItems[2], -1);
    if idx <> -1 then begin
      e := GetEditorFromFileName(CppParser1.GetFullFilename(lvBacktrace.Selected.SubItems[1]));
      if Assigned(e) then begin
        e.GotoLineNr(idx);
        e.Activate;
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

procedure TMainForm.devFileMonitor1NotifyChange(Sender: TObject;
  ChangeType: TdevMonitorChangeType; Filename: String);
var
  e: TEditor;
  p : TBufferCoord;
begin
  if ReloadFileName = FileName then
    exit;
  ReloadFilename := FileName;
  case ChangeType of
  		mctChanged: if MessageDlg(Filename + ' has changed. Reload from disk?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
        e := GetEditorFromFileName(Filename);
        if Assigned(e) then begin
          p := e.Text.CaretXY;
          e.Text.Lines.LoadFromFile(Filename);
        if (p.Line <= e.Text.Lines.Count) then
            e.Text.CaretXY := p;
        end;
      end;
    mctDeleted: MessageDlg(Filename + ' has been renamed or deleted...',mtInformation, [mbOk], 0);
  end;
  ReloadFilename := '';
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


procedure TMainForm.OnBreakpointToggle(index:integer; BreakExists:boolean);
begin
  if fDebugger.Executing and fDebugger.isBroken then begin
    if BreakExists then begin
      PBreakPointEntry(BreakPointList.Items[index])^.breakPointIndex := fDebugger.AddBreakpoint(index);
    end
    else begin
      fDebugger.RemoveBreakpoint(index);
    end;
  end;
end;

procedure TMainForm.actViewToDoListExecute(Sender: TObject);
begin
  TViewToDoForm.Create(Self).ShowModal;
end;

procedure TMainForm.actAddToDoExecute(Sender: TObject);
begin
  TAddToDoForm.Create(Self).ShowModal;
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

{ begin XXXKF changed }

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
//  Run to cursor no longer sets a breakpoint.  It will try to run to the wherever the
// cusor is.  If there happens to be a breakpoint before that, the debugging stops there
// and the run to cursor value is removed.  (it will not stop there if you press continue)
procedure TMainForm.actRunToCursorExecute(Sender: TObject);
var
  e: TEditor;
 line : integer;
begin
  e := GetEditor;
  line := e.Text.CaretY;
  // If the debugger is not running, set the breakpoint to the current line and start the debugger
  if not fDebugger.Executing then begin
    e.RunToCursor(line);
    actDebugExecute(sender);
  end

  // Otherwise, make sure that the debugger is stopped so that breakpoints can be added
  // Also ensure that the cursor is not on a line that is already marked as a breakpoint
  else if (fDebugger.isBroken = true) and (not fDebugger.BreakpointExists(e.TabSheet.Caption, line)) then begin
  if assigned(e) then
      e.RunToCursor(line);
  end;

  // If we are broken and the run to cursor location is the same as the current breakpoint, just
  // continue to try to run to the current location
  if (fDebugger.isBroken = true) then
    fDebugger.SendCommand(GDB_CONTINUE, '');
end;

procedure TMainForm.GdbCommandBtnClick(Sender: TObject);
begin
  if fDebugger.Executing then
    fDebugger.SendCommand(edGdbCommand.Text, '');
end;

procedure TMainForm.ViewCPUItemClick(Sender: TObject);
begin
  CPUForm := TCPUForm.Create(self);
  CPUForm.Show;
  if (fDebugger.Executing) then begin
    if not fDebugger.Idle then begin
      fDebugger.SendCommand(GDB_REG, GDB_EAX);
      fDebugger.Idle;
      fDebugger.SendCommand(GDB_REG, GDB_EBX);
      fDebugger.Idle;
      fDebugger.SendCommand(GDB_REG, GDB_ECX);
      fDebugger.Idle;
      fDebugger.SendCommand(GDB_REG, GDB_EDX);
      fDebugger.Idle;
      fDebugger.SendCommand(GDB_REG, GDB_ESI);
      fDebugger.Idle;
      fDebugger.SendCommand(GDB_REG, GDB_EDI);
      fDebugger.Idle;
      fDebugger.SendCommand(GDB_REG, GDB_EBP);
      fDebugger.Idle;
      fDebugger.SendCommand(GDB_REG, GDB_ESP);
      fDebugger.Idle;
      fDebugger.SendCommand(GDB_REG, GDB_EIP);
      fDebugger.Idle;
      fDebugger.SendCommand(GDB_REG, GDB_CS);
      fDebugger.Idle;
      fDebugger.SendCommand(GDB_REG, GDB_DS);
      fDebugger.Idle;
      fDebugger.SendCommand(GDB_REG, GDB_SS);
      fDebugger.Idle;
      fDebugger.SendCommand(GDB_REG, GDB_ES);
      fDebugger.Idle;
      fDebugger.SendCommand(GDB_DISASSEMBLE, '');
    end;
  end;
end;

procedure TMainForm.edGdbCommandKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    GdbCommandBtnClick(sender);
end;

procedure TMainForm.CheckForDLLProfiling;
var
  opts: TProjOptions;
  opt: TCompilerOption;
  idx: integer;
begin
  if not Assigned(fProject) then
    Exit;

  // profiling not enabled
  if not devCompiler.FindOption('-pg', opt, idx) then
    Exit;

  if (fProject.Options.typ in [dptDyn, dptStat]) and (opt.optValue > 0) then begin
    // project is a lib or a dll, and profiling is enabled
    // check for the existence of "-lgmon" in project's linker options
    if AnsiPos('-lgmon', fProject.Options.cmdLines.Linker) = 0 then
      // does not have -lgmon
      // warn the user that we should update its project options and include
      // -lgmon in linker options, or else the compilation will fail
      if MessageDlg('You have profiling enabled in Compiler Options and you are ' +
        'working on a dynamic or static library. Do you want to add a special ' +
        'linker option in your project to allow compilation with profiling enabled? ' +
        'If you choose No, and you do not disable profiling from the Compiler Options ' +
        'chances are that your library''s compilation will fail...', mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then begin
        opts := fProject.Options;
        opts.cmdLines.Linker := fProject.Options.cmdLines.Linker + ' -lgmon';
        fProject.Options := opts;
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
      ParamsForm.HostEdit.Text := fProject.Options.HostApplication;
    if (not Assigned(fProject)) or (fProject.Options.typ <> dptDyn) then
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

procedure TMainForm.FormPaint(Sender: TObject);
begin
  OnPaint := nil; // don't re-enter here ;)
  inherited;

  if devData.ShowTipsOnStart and (ParamCount = 0) then  // do not show tips if dev-c++ is launched with a file
    actShowTips.Execute;
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

{ begin XXXKF }

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
    if (i >= 9) then break;
    e := GetEditor(i);
    Item := TMenuItem.Create(self);
    Act := TAction.Create(Item);
    //     Act.ActionList:=alMain;
    Act.Name := 'dynactOpenEditorByTag';
    Act.Tag := i;
    Act.OnExecute := dynactOpenEditorByTagExecute;
    Item.Action := Act;
    if e.FileName = '' then
      Item.Caption := '&' + chr(49 + i) + ' Unnamed'
    else
      Item.Caption := '&' + chr(49 + i) + ' ' + e.FileName;
    if e.Modified then
      Item.Caption := Item.Caption + ' *';
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

{ end XXXKF }

procedure TMainForm.actGotoProjectManagerExecute(Sender: TObject);
begin
  if not actProjectManager.Checked then
  begin
    actProjectManager.Checked := True;
    actProjectManagerExecute(nil);
  end;
  LeftPageControl.ActivePageIndex := 0;
  ProjectView.SetFocus;
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
  wa: boolean;
  I: integer;
  e: TEditor;
  pt: TBufferCoord;
begin
  actSaveAll.Execute;
  wa := devFileMonitor1.Active;
  devFileMonitor1.Deactivate;

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

  if wa then
    devFileMonitor1.Activate;
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
{ begin XXXKF }
procedure TMainForm.ProjectViewCompare(Sender: TObject; Node1,
  Node2: TTreeNode; Data: Integer; var Compare: Integer);
begin
  if (Node1.Data = pointer(-1)) and (Node2.Data = pointer(-1)) then
    Compare := AnsiCompareStr(Node1.Text, Node2.Text)
  else
  	if Node1.Data = pointer(-1) then Compare := -1
   else
   	if Node2.Data = pointer(-1) then Compare := +1
  else
    Compare := AnsiCompareStr(Node1.Text, Node2.Text);
end;
{ end XXXKF }

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
  if not actProjectManager.Checked then
  begin
    actProjectManager.Checked := True;
    actProjectManagerExecute(nil);
  end;
  LeftPageControl.ActivePageIndex := 1;
  if ClassBrowser1.Visible And ClassBrowser1.Enabled then
    ClassBrowser1.SetFocus;
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

procedure TMainForm.ProjectWindowClose(Sender: TObject; var Action: TCloseAction);
begin
  FloatingPojectManagerItem.Checked := False;
  //LeftPageControl.Visible := false;
  pnlBrowsers.Visible := False;

  (Sender as TForm).RemoveControl(LeftPageControl);
  if LeftPageControl.visible = false then
  	LeftPageControl.visible :=true;
  LeftPageControl.Left := 0;
  LeftPageControl.Top := ControlBar1.Height;
  LeftPageControl.Align := alLeft;
  pnlBrowsers.Visible := True;
  //LeftPageControl.Visible := true;
  InsertControl(LeftPageControl);
  ProjectToolWindow.Free;
  ProjectToolWindow := nil;

  if assigned(fProject) then
    fProject.SetNodeValue(ProjectView.TopItem); // nodes needs to be recreated
end;

procedure TMainForm.ReportWindowClose(Sender: TObject; var Action: TCloseAction);
begin
  FloatingReportWindowItem.Checked := False;
  MessageControl.Visible := false;
  (Sender as TForm).RemoveControl(MessageControl);

  MessageControl.Left := 0;
  MessageControl.Top := SplitterBottom.Top;
  MessageControl.Align := alBottom;
  MessageControl.Visible := true;
  InsertControl(MessageControl);
  StatusBar.Top := MessageControl.Top + MessageControl.Height;
  ReportToolWindow.Free;
  ReportToolWindow := nil;
end;

procedure TMainForm.AddWatchBtnClick(Sender: TObject);
var s: string;
begin
  if InputQuery(Lang[ID_NV_ADDWATCH], Lang[ID_NV_ENTERVAR], s) then
    AddDebugVar(s);
end;

procedure TMainForm.FloatingPojectManagerItemClick(Sender: TObject);
begin
  FloatingPojectManagerItem.Checked := not FloatingPojectManagerItem.Checked;
  if assigned(ProjectToolWindow) then
    ProjectToolWindow.Close
  else begin
    ProjectToolWindow := TForm.Create(self);
    with ProjectToolWindow do begin
      Caption := Lang.Strings[ID_TB_PROJECT];
      Top := self.Top + LeftPageControl.Top;
      Left := self.Left + LeftPageControl.Left;
      Height := LeftPageControl.Height;
      Width := LeftPageControl.Width;
      FormStyle := fsStayOnTop;
      OnClose := ProjectWindowClose;
      BorderStyle := bsSizeable;
      BorderIcons := [biSystemMenu];
      pnlBrowsers.Visible := False;
      //LeftPageControl.Visible := false;
      self.RemoveControl(LeftPageControl);

      LeftPageControl.Left := 0;
      LeftPageControl.Top := 0;
      LeftPageControl.Align := alClient;
      pnlBrowsers.Visible := True;
      //LeftPageControl.Visible := true;
      ProjectToolWindow.InsertControl(LeftPageControl);

      ProjectToolWindow.Show;
      if assigned(fProject) then
        fProject.SetNodeValue(ProjectView.TopItem); // nodes needs to be recreated
    end;
  end;
end;

procedure TMainForm.SetProjCompOpt(idx: integer; Value: boolean);
var
  projOpt: TProjOptions;
begin
  if Assigned(fProject) then begin
    projOpt := fProject.Options;
    if idx <= Length(projOpt.CompilerOptions) then begin
      if Value then
        projOpt.CompilerOptions[idx + 1] := '1'
      else
        projOpt.CompilerOptions[idx + 1] := '0';
      fProject.Options := projOpt;
    end;
  end;
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
  if not PrepareForCompile then
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

procedure TMainForm.FloatingReportwindowItemClick(Sender: TObject);
begin
  FloatingReportWindowItem.Checked := not FloatingReportWindowItem.Checked;
  if assigned(ReportToolWindow) then
    ReportToolWindow.Close
  else begin
    OpenCloseMessageSheet(true);
    if MessageControl.ActivePage = CloseSheet then
      MessageControl.ActivePageIndex := 0;
    ReportToolWindow := TForm.Create(self);
    with ReportToolWindow do begin
      Caption := Lang.Strings[ID_TB_REPORT];
      Top := self.Top + MessageControl.Top;
      Left := self.Left + MessageControl.Left;
      Height := MessageControl.Height;
      Width := MessageControl.Width;
      FormStyle := fsStayOnTop;
      OnClose := ReportWindowClose;
      BorderStyle := bsSizeable;
      BorderIcons := [biSystemMenu];
      MessageControl.Visible := false;
      self.RemoveControl(MessageControl);

      MessageControl.Left := 0;
      MessageControl.Top := 0;
      MessageControl.Align := alClient;
      MessageControl.Visible := true;
      ReportToolWindow.InsertControl(MessageControl);

      ReportToolWindow.Show;
    end;
  end;
end;

procedure TMainForm.actAttachProcessUpdate(Sender: TObject);
begin
  if assigned(fProject) and (fProject.Options.typ = dptDyn) then begin
    (Sender as TCustomAction).Visible := true;
    (Sender as TCustomAction).Enabled := not devExecutor.Running;
  end
  else
    (Sender as TCustomAction).Visible := false;
end;

procedure TMainForm.actAttachProcessExecute(Sender: TObject);
var idx : integer;
  	s: string;
begin
  PrepareDebugger;
  if assigned(fProject) then begin
    if not FileExists(fProject.Executable) then begin
      MessageDlg(Lang[ID_ERR_PROJECTNOTCOMPILED], mtWarning, [mbOK], 0);
      exit;
    end;

    {if InputQuery(Lang[ID_ITEM_ATTACHPROCESS], Lang[ID_MSG_ATTACH], s) then begin
      try
        pid := StrToInt(s);
      except
        MessageDlg('Invalid PID !', mtWarning, [mbOK], 0);
        exit;
      end;}
    try
      ProcessListForm := TProcessListForm.Create(self);
      if (ProcessListForm.ShowModal = mrOK) and (ProcessListForm.ProcessCombo.ItemIndex > -1) then begin
        s := IntToStr(integer(ProcessListForm.ProcessList[ProcessListForm.ProcessCombo.ItemIndex]));
        fDebugger.FileName := '"' + StringReplace(fProject.Executable, '\', '\\', [rfReplaceAll]) + '"';

        // add to the debugger the project include dirs
        for idx := 0 to fProject.Options.Includes.Count - 1 do
          fDebugger.AddIncludeDir(fProject.Options.Includes[idx]);

        fDebugger.Execute;
        fDebugger.SendCommand(GDB_FILE, fDebugger.FileName);

        fDebugger.SendCommand(GDB_ATTACH, s);

       for idx:=0 to BreakPointList.Count -1 do begin
           PBreakPointEntry(BreakPointList.Items[idx])^.breakPointIndex := fDebugger.AddBreakpoint(idx);
        end;

        DebugTree.Items.Clear;
      end
    finally
      ProcessListForm.Free;
    end;
  end;
end;

procedure TMainForm.actModifyWatchExecute(Sender: TObject);
var s, val: string;
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
  ModifyVarForm := TModifyVarForm.Create(self);
  try
    ModifyVarForm.NameEdit.Text := s;
    ModifyVarForm.ValueEdit.Text := Val;
    if ModifyVarForm.ShowModal = mrOK then
      fDebugger.SendCommand(GDB_SET, ModifyVarForm.NameEdit.Text + ' = ' + ModifyVarForm.ValueEdit.Text);
  finally
    ModifyVarForm.Free;
  end;

end;

procedure TMainForm.actModifyWatchUpdate(Sender: TObject);
begin
  (Sender as TCustomAction).Enabled := Assigned(DebugTree.Selected) and fDebugger.Executing;
end;

procedure TMainForm.RefreshContext;
var idx, idx2: integer;
  	s: string;
begin
  // I'm not sure we should send again debug variables, GDB sends weird results for uninitialized objects (which is quite always the case)
  for idx := 0 to DebugTree.Items.Count - 1 do begin
    s := DebugTree.Items[idx].Text;
    idx2 := AnsiPos(' = ', s);
    if idx2 > 0 then begin
      Delete(s, idx2, length(s) - idx2 + 1);
      if fDebugger.Executing then
        fDebugger.SendCommand(GDB_DISPLAY, s);
    end;
  end;
end;

procedure TMainForm.ClearallWatchPopClick(Sender: TObject);
var	node: TTreeNode;
begin
  node := DebugTree.TopItem;
  while Assigned(Node) do begin
    try
      fDebugger.SendCommand(GDB_UNDISPLAY, IntToStr(integer(node.Data)));
    except
    end;
    DebugTree.Items.Delete(node);
    node := DebugTree.TopItem;
  end;
  DebugTree.Items.Clear;
end;


procedure TMainForm.HideCodeToolTip;
//
// added on 23rd may 2004 by peter_
// belongs to this problem:
// https://sourceforge.net/tracker/?func=detail&atid=110639&aid=957025&group_id=10639
//
var
  CurrentEditor: TEditor;
begin
  CurrentEditor := GetEditor(PageControl.ActivePageIndex);

  if Assigned(CurrentEditor)  AND Assigned(CurrentEditor.CodeToolTip) then
  begin
  	//Added for wx Problems
    try
      CurrentEditor.CodeToolTip.ReleaseHandle;
    except
    end;
  end;
end;


procedure TMainForm.ApplicationEvents1Deactivate(Sender: TObject);
//
// added on 23rd may 2004 by peter_
//
  {$IFDEF WX_BUILD}
  //This is a custom File Watcher used specifically for
  //wx-devcpp because the current implementation
  //is somewhat erratic in my machine
var
    fwatchThread:TFileWatch;
    i:Integer;
  {$ENDIF}
begin
  try
  	HideCodeToolTip;
  except
  end;

  {$IFDEF WX_BUILD}
  devFileMonitor1.Deactivate;
  FWatchList.Clear;
  FileWatching:=true;
  for I := 0 to devFileMonitor1.Files.Count - 1 do    // Iterate
  begin
    fwatchThread:=TFileWatch.Create ;
    fwatchThread.OnNotify:=OnFileChangeNotify;
    fwatchThread.FileName:=devFileMonitor1.Files[i];
    fwatchThread.FreeOnTerminate:=true;
    fwatchThread.Active:=true;
    FWatchList.Add(fwatchThread)
  end;    // for
  {$ENDIF}
end;

procedure TMainForm.PageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
//
// added on 23rd may 2004 by peter_
//
begin
  HideCodeToolTip;
  {$IFDEF WX_BUILD}
  DisableDesignerControls;
  {$ENDIF}
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

{Functions Added By Guru for wx Implementation}
procedure TMainForm.CreateNewDialogOrFrameCode(dsgnType:TWxDesignerType);

var
  NewDesigner: TEditor;
  strFileName, strShortFileName: string;
  FCreateFormPropObj: TfrmCreateFormProp;
  strFName, strCName, strFTitle: string;
  dlgSStyle: TWxDlgStyleSet;
  InProject, CreateStatus: Boolean;
  strCppCode, strHCode: string;
  emptyFileName: string;
  FolderNode: TTreeNode;
  NewUnit: TProjUnit;
  strCppFile,strHppFile:String;
  ini: Tinifile;

begin
  if dsgnType = dtWxFrame then
  begin
    strCppFile:= includetrailingbackslash(ExtractFileDir(Application.ExeName))+'Templates\wxWidgets\wxFrame.cpp.code';
    strHppFile:=includetrailingbackslash(ExtractFileDir(Application.ExeName))+'Templates\wxWidgets\wxFrame.h.code';
  end
  Else
  begin
    strCppFile:= includetrailingbackslash(ExtractFileDir(Application.ExeName))+'Templates\wxWidgets\wxDlg.cpp.code';
    strHppFile:=includetrailingbackslash(ExtractFileDir(Application.ExeName))+'Templates\wxWidgets\wxDlg.h.code';
  end;

  if (not fileExists(strCppFile)) then
  begin
    MessageDlg('Unable to find wxWidgets Template file: '+strCppFile+#13+#10+''+#13+#10+'Please provide the template files in the template directory. ', mtError, [mbOK], 0);
    exit;
  end;

   if (not fileExists(strHppFile)) then
  begin
    MessageDlg('Unable to find wxWidgets Template file: '+strHppFile+#13+#10+''+#13+#10+'Please provide the template files in the template directory. ', mtError, [mbOK], 0);
    exit;
  end;

  InProject := false;
  if Assigned(fProject) then
  begin
    InProject := Application.MessageBox(PChar(
      Lang[ID_MSG_NEWRES]), 'New wxWidgets Form', MB_ICONQUESTION +
      MB_YESNO) = 6
  end;

  FCreateFormPropObj := TfrmCreateFormProp.Create(self);
  FCreateFormPropObj.JvFormStorage1.RestoreFormPlacement;
  FCreateFormPropObj.JvFormStorage1.Active := False;
  emptyFileName := Lang[ID_UNTITLED] + inttostr(dmMain.GetNum);

  if dsgnType = dtWxFrame then
     FCreateFormPropObj.Caption := 'Create New wxWidgets Frame'
      else
      FCreateFormPropObj.Caption := 'Create New wxWidgets Dialog';

  // Open the ini file and see if we have any default values for author, class, license
  // ReadString will return either the ini key or the default
  ini := TiniFile.Create(devDirs.Config + 'devcpp.ini');

  //Reverted the changes for using the custom names.
  //Custome Names are Ok for ProjectCreation, but it is not good for
  //Individual Forms.
  if dsgnType = dtWxFrame then
  begin
    FCreateFormPropObj.txtFileName.Text := emptyFileName+'Frm';
    FCreateFormPropObj.txtClassName.Text := emptyFileName+'Frm';
  end
  else
  begin
    FCreateFormPropObj.txtFileName.Text := emptyFileName+'Dlg';
    FCreateFormPropObj.txtClassName.Text := emptyFileName+'Dlg';
  end;

  FCreateFormPropObj.txtTitle.Text := emptyFileName;
  FCreateFormPropObj.txtAuthorName.Text := ini.ReadString('wxWidgets', 'Author', GetLoginName);

  if InProject then
    FCreateFormPropObj.txtSaveTo.Text := IncludeTrailingBackslash(ExtractFileDir(fProject.FileName))
  else
  begin
    if Trim(FCreateFormPropObj.txtSaveTo.Text) = '' then
      FCreateFormPropObj.txtSaveTo.Text :=IncludeTrailingBackslash(ExtractFileDir(Application.ExeName));
  end;

  if FCreateFormPropObj.showModal <> mrOK then
  begin
    FCreateFormPropObj.Destroy;
    exit;
  end;

  try
   // Write the current strings back as the default
  ini.WriteString('wxWidgets', 'Author', FCreateFormPropObj.txtAuthorName.Text);
  except

  end;

  ini.free;

  CreateStatus := CreateSourceCodes(strCppFile,strHppFile,FCreateFormPropObj, strCppCode, strHCode, dsgnType);
  if CreateStatus then
  begin
    GetIntialFormData(FCreateFormPropObj, strFName, strCName, strFTitle,dlgSStyle, dsgnType);
    CreateStatus := CreateFormFile(strFName, strCName, strFTitle, dlgSStyle,dsgnType);
  end;

  FCreateFormPropObj.Destroy;

  if not CreateStatus then
  begin
    //Add localization here
    Application.MessageBox(PChar('Unable to Create wxForm'),'New wxWidgets Form', MB_ICONQUESTION + MB_OK);
    Exit;
  end;

  strFileName := strFName;

    strFileName := ChangeFileExt(strFileName, H_EXT);
    OpenFile(strFileName);
    if Assigned(fProject) and (InProject = true)then
    begin
        FolderNode:=fProject.Node;
        fProject.AddUnit(strFileName, FolderNode, false); // add under folder
        if ClassBrowser1.Enabled then
        begin
            CppParser1.AddFileToScan(strFileName,true);
        end;
        //CppParser1.ReParseFile(strFileName, True); //new cc
    end;

    strFileName := ChangeFileExt(strFileName, CPP_EXT);
    OpenFile(strFileName);
    if Assigned(fProject) and (InProject = true)then
    begin
        FolderNode:=fProject.Node;
        fProject.AddUnit(strFileName, FolderNode, false); // add under folder

        if ClassBrowser1.Enabled then
        begin
          CppParser1.AddFileToScan(strFileName, True);
          CppParser1.ReParseFile(strFileName, True); //new cc
          ClassBrowser1.UpdateView;
        end;
      end;


    strFileName := ChangeFileExt(strFileName, XRC_EXT);
    OpenFile(strFileName);
    if Assigned(fProject) and (InProject = true)then
    begin
        FolderNode:=fProject.Node;
        fProject.AddUnit(strFileName, FolderNode, false); // add under folder
    end;

    strFileName := ChangeFileExt(strFileName, WXFORM_EXT);
    strShortFileName := ExtractFileName(strFileName);
    NewDesigner := TEditor.Create;

    if Assigned(fProject) and (InProject = true)then
    begin
        FolderNode:=fProject.Node;
        NewUnit:=fProject.AddUnit(strFileName, FolderNode, false); // add under folder
        NewUnit.Editor:=NewDesigner;
    end;

  NewDesigner.Init(InProject, strShortFileName, strFileName, TRUE);

  if not ClassBrowser1.Enabled then
  begin
    MessageDlg('Class Browser is not enabled.'+#13+#10+''+#13+#10+'Adding Event handlers and Other features of the Form Designer '+#13+#10+'wont work properly.'+#13+#10+''+#13+#10+'Please enable the Class Browser.', mtWarning, [mbOK], 0);
  end;

  NewDesigner.Activate;

end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.NewWxProjectCode(dsgnType:TWxDesignerType);
// This code creates a new wxWidgets project
//    including c++ code, headers, and resource files
// It was scavenged from TMainForm.CreateNewDialogOrFrameCode (above).
//  The template for this code should be in the \Templates directory.
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
//
//  This function calls CreateAppSourceCodes which takes those
//  template files, replaces keywords (e.g. %FILE_NAME%, %CLASS_NAME%,
//  %AUTHOR_NAME%) within the templates with the user-supplied values,
//  saves the newly-created project files, and adds them to the new
//  project.
var
  NewDesigner: TEditor;
  strFileName, strShortFileName, strAppFileName: string;
  FCreateFormPropObj: TfrmCreateFormProp;
  strFName, strCName, strFTitle: string;
  dlgSStyle: TWxDlgStyleSet;
  InProject, CreateStatus: Boolean;
  strCppCode, strHCode, strAppHeaderCode, strAppSourceCode: string;
  emptyFileName: string;
  FolderNode: TTreeNode;
  NewUnit: TProjUnit;
  strCppFile,strHppFile,strAppCppFile,strAppHppFile:String;
  ini: Tinifile;

begin

  if dsgnType = dtWxFrame then        //  For wxFrames
  begin
    strCppFile:= includetrailingbackslash(ExtractFileDir(Application.ExeName))+'Templates\wxWidgets\wxprojFrame.cpp';
    strHppFile:=includetrailingbackslash(ExtractFileDir(Application.ExeName))+'Templates\wxWidgets\wxprojFrame.h';
    strAppCppFile:=includetrailingbackslash(ExtractFileDir(Application.ExeName))+'Templates\wxWidgets\wxprojFrameApp.cpp';
    strAppHppFile:=includetrailingbackslash(ExtractFileDir(Application.ExeName))+'Templates\wxWidgets\wxprojFrameApp.h';
  end
  Else

  begin                     // For wxDialogs
    strCppFile:= includetrailingbackslash(ExtractFileDir(Application.ExeName))+'Templates\wxWidgets\wxprojDlg.cpp';
    strHppFile:=includetrailingbackslash(ExtractFileDir(Application.ExeName))+'Templates\wxWidgets\wxprojDlg.h';
    strAppCppFile:=includetrailingbackslash(ExtractFileDir(Application.ExeName))+'Templates\wxWidgets\wxprojDlgApp.cpp';
    strAppHppFile:=includetrailingbackslash(ExtractFileDir(Application.ExeName))+'Templates\wxWidgets\wxprojDlgApp.h';
  end;

  // If template files don't exist, we need to send an error message to user.
  if (not fileExists(strCppFile)) then
  begin
    MessageDlg('Unable to find wxWidgets Template file: '+strCppFile+#13+#10+''+#13+#10+'Please provide the template files in the template directory. ', mtError, [mbOK], 0);
    exit;
  end;
   if (not fileExists(strHppFile)) then
  begin
    MessageDlg('Unable to find wxWidgets Template file: '+strHppFile+#13+#10+''+#13+#10+'Please provide the template files in the template directory. ', mtError, [mbOK], 0);
    exit;
  end;
   if (not fileExists(strAppCppFile)) then
  begin
    MessageDlg('Unable to find wxWidgets Template file: '+strAppCppFile+#13+#10+''+#13+#10+'Please provide the template files in the template directory. ', mtError, [mbOK], 0);
    exit;
  end;
   if (not fileExists(strAppHppFile))  then
  begin
    MessageDlg('Unable to find wxWidgets Template file: '+strAppHppFile+#13+#10+''+#13+#10+'Please provide the template files in the template directory. ', mtError, [mbOK], 0);
    exit;
  end;

  InProject := true;  // We are creating files that will be part of a project

  FCreateFormPropObj := TfrmCreateFormProp.Create(self);
  FCreateFormPropObj.JvFormStorage1.RestoreFormPlacement;
  FCreateFormPropObj.JvFormStorage1.Active := False;

  if dsgnType = dtWxFrame then
     FCreateFormPropObj.Caption := 'Create New Project - wxWidgets Frame'
     else
      FCreateFormPropObj.Caption := 'Create New Project - wxWidgets Dialog';

  emptyFileName := Lang[ID_UNTITLED] + inttostr(dmMain.GetNum);

  // Open the ini file and see if we have any default values for author, class, license
  // ReadString will return either the ini key or the default
  ini := TiniFile.Create(devDirs.Config + 'devcpp.ini');

  //Normally the user wont save the Form file with the same filename as that of the
  //Project.
  // Default class name
  //For Dialog we'll Add Dlg at the end of the Projectname.
  //Who is going to use the same class Name for all the projects ?
  if dsgnType = dtWxFrame then
  begin
    FCreateFormPropObj.txtFileName.Text := ChangeFileExt(ExtractFileName(fProject.FileName),'') +'Frm';
    FCreateFormPropObj.txtClassName.Text := ChangeFileExt(ExtractFileName(fProject.FileName),'') + 'Frm';
  end
  else
  begin
    FCreateFormPropObj.txtFileName.Text := ChangeFileExt(ExtractFileName(fProject.FileName),'') +'Dlg';
    FCreateFormPropObj.txtClassName.Text := ChangeFileExt(ExtractFileName(fProject.FileName),'') + 'Dlg';
  end;

  FCreateFormPropObj.txtTitle.Text := ChangeFileExt(ExtractFileName(fProject.FileName),'');   // Default title name

  FCreateFormPropObj.txtAuthorName.Text := ini.ReadString('wxWidgets', 'Author', GetLoginName);
  //We we are creating a new project without having a project open
  //then we'll see the InProject as false
  FCreateFormPropObj.txtSaveTo.Text := IncludeTrailingBackslash(ExtractFileDir(fProject.FileName));

  if FCreateFormPropObj.showModal <> mrOK then
  begin
    FCreateFormPropObj.Destroy;
    exit;
  end;

  try
    // Write the current strings back as the default
    ini.WriteString('wxWidgets', 'Author', FCreateFormPropObj.txtAuthorName.Text);
  except
  end;

  ini.free;

  // Call CreateAppSourceCodes to replace the keywords in our template files
  //  and create the new project files
  CreateStatus := CreateAppSourceCodes(strCppFile,strHppFile,strAppCppFile,strAppHppFile,FCreateFormPropObj,
            strCppCode, strHCode, strAppSourceCode, strAppHeaderCode, dsgnType);

  if CreateStatus then  // If true, then CreateAppSourceCodes was able to create our project files
  begin
    GetIntialFormData(FCreateFormPropObj, strFName, strCName, strFTitle,dlgSStyle,dsgnType);
    CreateStatus := CreateFormFile(strFName, strCName, strFTitle, dlgSStyle,dsgnType);
  end;

  FCreateFormPropObj.Destroy;

  if not CreateStatus then  // if false, then CreateAppSourceCodes had some problem creating the project files
  begin
    //Add localization here
    Application.MessageBox(PChar('Unable to Create wxForm'),
      'New wxWidgets Form', MB_ICONQUESTION + MB_OK);
    Exit;
  end;

  strFileName := strFName;

  // Open the .h file generated by CreateAppSourceCodes and add it to the project
    strFileName := ChangeFileExt(strFileName, H_EXT);
    OpenFile(strFileName);
    if Assigned(fProject) and (InProject = true)then
    begin
        FolderNode:=fProject.Node;
        fProject.AddUnit(strFileName, FolderNode, false); // add under folder
        if ClassBrowser1.Enabled then
        begin
            CppParser1.AddFileToScan(strFileName,true);
        end;
        //CppParser1.ReParseFile(strFileName, True); //new cc
    end;

    // Open the .cpp file generated by CreateAppSourceCodes and add it to the project
    strFileName := ChangeFileExt(strFileName, CPP_EXT);
    OpenFile(strFileName);
    if Assigned(fProject) and (InProject = true)then
    begin
        FolderNode:=fProject.Node;
        fProject.AddUnit(strFileName, FolderNode, false); // add under folder

        if ClassBrowser1.Enabled then
        begin
          CppParser1.AddFileToScan(strFileName, True);
          CppParser1.ReParseFile(strFileName, True); //new cc
          ClassBrowser1.UpdateView;
        end;
      end;

   // Open the .h application file generated by CreateAppSourceCodes and add it to the project
   strAppFileName := ChangeFileExt(fProject.FileName, '') + APP_SUFFIX + H_EXT;
    OpenFile(strAppFileName);
    if Assigned(fProject) and (InProject = true)then
    begin
        FolderNode:=fProject.Node;

        fProject.AddUnit(strAppFileName, FolderNode, false); // add under folder
           if ClassBrowser1.Enabled then
        begin
            CppParser1.AddFileToScan(strAppFileName,true);
        end;
        //CppParser1.ReParseFile(strAppFileName, True); //new cc
    end;


    // Open the .cpp application file generated by CreateAppSourceCodes and add it to the project
   strAppFileName := ChangeFileExt(fProject.FileName, '') + APP_SUFFIX + CPP_EXT;
   OpenFile(strAppFileName);
    if Assigned(fProject) and (InProject = true) then
    begin
        FolderNode:=fProject.Node;
        fProject.AddUnit(strAppFileName, FolderNode, false); // add under folder
        if ClassBrowser1.Enabled then
        begin
            CppParser1.AddFileToScan(strAppFileName,true);
        end;
        //CppParser1.ReParseFile(strAppFileName, True); //new cc
    end;

    // Add resource file to the project
   strAppFileName := ChangeFileExt(fProject.FileName, '') + APP_SUFFIX + '.rc';
   OpenFile(strAppFileName);
    if Assigned(fProject) and (InProject = true) then
    begin
        FolderNode:=fProject.Node;
        fProject.AddUnit(strAppFileName, FolderNode, false); // add under folder
        if ClassBrowser1.Enabled then
        begin
            CppParser1.AddFileToScan(strAppFileName,true);
        end;
        //CppParser1.ReParseFile(strAppFileName, True); //new cc
    end;

    // Add XRC file to the project
    strFileName := ChangeFileExt(strFileName, XRC_EXT);
    OpenFile(strFileName);
    if Assigned(fProject) and (InProject = true) then
    begin
        FolderNode:=fProject.Node;
        fProject.AddUnit(strFileName, FolderNode, false); // add under folder
    end;

    // Add wxForm to the project
    strFileName := ChangeFileExt(strFileName, WXFORM_EXT);
    strShortFileName := ExtractFileName(strFileName);
    NewDesigner := TEditor.Create;

    if Assigned(fProject) and (InProject = true) then
    begin
        FolderNode:=fProject.Node;
        NewUnit:=fProject.AddUnit(strFileName, FolderNode, false); // add under folder
        NewUnit.Editor:=NewDesigner;
    end;

  NewDesigner.Init(InProject, strShortFileName, strFileName, TRUE);

  if not ClassBrowser1.Enabled then
  begin
    MessageDlg('Class Browser is not enabled.'+#13+#10+''+#13+#10+'Adding Event handlers and Other features of the Form Designer '+#13+#10+'wont work properly.'+#13+#10+''+#13+#10+'Please enable the Class Browser.', mtWarning, [mbOK], 0);
  end;

  NewDesigner.Activate;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
function TMainForm.CreateFormFile(strFName, strCName, strFTitle: string; dlgSStyle:TWxDlgStyleSet; dsgnType:TWxDesignerType): Boolean;
var
  FNewFormObj: TfrmNewForm;
begin
  Result := True;
  FNewFormObj := TfrmNewForm.Create(self);
  try
    try
      //FNewFormObj.Name := strCName;
      if dsgnType = dtWxFrame then
        FNewFormObj.Wx_DesignerType:= dtWxFrame
      else
        FNewFormObj.Wx_DesignerType:= dtWxDialog;

      FNewFormObj.Caption := strFTitle;
      FNewFormObj.Wx_DialogStyle := dlgSStyle; //[wxCaption,wxResize_Border,wxSystem_Menu,wxThick_Frame,wxMinimize_Box,wxMaximize_Box,wxClose_Box];
      FNewFormObj.Wx_Name := strCName;
      FNewFormObj.EVT_CLOSE:=strCName+'Close';
      FNewFormObj.Wx_Center:=True;
      WriteComponentsToFile([FNewFormObj], ChangeFileExt(strFName, wxform_Ext));
    except
      Result := False;
    end;
  finally
    FNewFormObj.Destroy;
  end;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.GetIntialFormData(FCreateFormProp: TfrmCreateFormProp; var
  strFName, strCName, strFTitle: string; var dlgStyle: TWxDlgStyleSet; dsgnType:TWxDesignerType);
begin
  strCName := Trim(FCreateFormProp.txtClassName.Text);
  strFTitle := Trim(FCreateFormProp.txtTitle.Text);
  strFName := IncludeTrailingBackslash(Trim(FCreateFormProp.txtSaveTo.Text)) +
    Trim(FCreateFormProp.txtFileName.Text);

  dlgStyle := [];

  if FCreateFormProp.cbUseCaption.Checked then
    dlgStyle := dlgStyle + [wxCAPTION];

  if FCreateFormProp.cbResizeBorder.Checked then
    dlgStyle := dlgStyle + [wxRESIZE_BORDER];

  if FCreateFormProp.cbSystemMenu.Checked then
    dlgStyle := dlgStyle + [wxSYSTEM_MENU];

  if FCreateFormProp.cbThickBorder.Checked then
    dlgStyle := dlgStyle + [wxTHICK_FRAME];

  if FCreateFormProp.cbStayOnTop.Checked then
    dlgStyle := dlgStyle + [wxSTAY_ON_TOP];

  if (dsgnType = dtWxDialog) then
          if FCreateFormProp.cbNoParent.Checked then
                dlgStyle := dlgStyle + [wxDIALOG_NO_PARENT];

  if FCreateFormProp.cbMaxButton.Checked then
    dlgStyle := dlgStyle + [wxMAXIMIZE_BOX];

  if FCreateFormProp.cbMinButton.Checked then
    dlgStyle := dlgStyle + [wxMINIMIZE_BOX];

  if FCreateFormProp.cbCloseButton.Checked then
    dlgStyle := dlgStyle + [wxCLOSE_BOX];

end;
{$ENDIF}

{$IFDEF WX_BUILD}
function TMainForm.CreateSourceCodes(strCppFile,strHppFile:String;FCreateFormProp: TfrmCreateFormProp; var cppCode, hppCode: string; dsgnType:TWxDesignerType): Boolean;
var
  strClassName, strClassTitle, strClassStyleString, strFileName, strDate, strAuthor: string;
  strLstHeaderCode,strLstSourceCode, strLstXRCCode:TStringList;

  function GetStyleString: string;
  var
    I: Integer;
    strLst: TStringList;
  begin
    strLst := TStringList.Create;

    if FCreateFormProp.cbUseCaption.checked then
      strLst.add('wxCAPTION');

    if FCreateFormProp.cbResizeBorder.checked then
      strLst.add('wxRESIZE_BORDER');

    if FCreateFormProp.cbSystemMenu.checked then
      strLst.add('wxSYSTEM_MENU');

    if FCreateFormProp.cbThickBorder.checked then
      strLst.add('wxTHICK_FRAME');

    if FCreateFormProp.cbStayOnTop.checked then
      strLst.add('wxSTAY_ON_TOP');

    if (dsgnType = dtWxDialog) then
        if FCreateFormProp.cbNoParent.checked then
                strLst.add('wxDIALOG_NO_PARENT');

    if FCreateFormProp.cbMinButton.checked then
      strLst.add('wxMINIMIZE_BOX');

    if FCreateFormProp.cbMaxButton.checked then
      strLst.add('wxMAXIMIZE_BOX');

    if FCreateFormProp.cbCloseButton.checked then
      strLst.add('wxCLOSE_BOX');

    if strLst.Count = 0 then
    begin
      if (dsgnType = dtWxDialog) then
      begin
        Result := 'wxDEFAULT_DIALOG_STYLE';
      end;
      if (dsgnType = dtWxFrame) then
      begin
        Result := 'wxDEFAULT_FRAME_STYLE';
      end;
    end
    else
    begin
      for I := 0 to strLst.count - 1 do // Iterate
      begin
        if i <> strLst.count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + ' ' + strLst[i] + ' ';
      end; // for
    end;
    strLst.destroy;
  end;

  function replaceAllSymbolsInStrLst(strLst: TStrings; var strFileSrc: string):
      Boolean;
  begin
    Result := True;
    try
       strFileSrc := strLst.text;
      strSearchReplace(strFileSrc, '%FILE_NAME%', ExtractFileName(strFileName),[srAll]);
      strSearchReplace(strFileSrc, '%DEVCPP_DIR%', devDirs.Exec,[srAll]);
      strSearchReplace(strFileSrc, '%AUTHOR_NAME%', strAuthor, [srAll]);
      strSearchReplace(strFileSrc, '%DATE_STRING%', strDate, [srAll]);
      strSearchReplace(strFileSrc, '%CLASS_NAME%', strClassName, [srAll]);
      strSearchReplace(strFileSrc, '%CAP_CLASS_NAME%', UpperCase(strClassName),[srAll]);

      strSearchReplace(strFileSrc, '%CLASS_TITLE%', strClassTitle, [srAll]);
      strSearchReplace(strFileSrc, '%CLASS_STYLE_STRING%', strClassStyleString,[srAll]);

    finally

    end;
  end;
begin
  Result := False;
  if not assigned(FCreateFormProp) then
    exit;

  strClassName := Trim(FCreateFormProp.txtClassName.Text);
  strDate := DateTimeToStr(now);
  strAuthor := Trim(FCreateFormProp.txtAuthorName.Text);
  strClassTitle := Trim(FCreateFormProp.txtTitle.Text);
  strClassStyleString := GetStyleString();

  strFileName := IncludeTrailingBackslash(Trim(FCreateFormProp.txtSaveTo.Text))
    + Trim(FCreateFormProp.txtFileName.Text);


  strLstHeaderCode:=TStringList.Create;
  strLstSourceCode:=TStringList.Create;

  strLstHeaderCode.LoadFromFile(strHppFile);
  strLstSourceCode.LoadFromFile(strCppFile);

  //Create Dlg Cpp Code
  replaceAllSymbolsInStrLst(strLstSourceCode, cppCode);

  //Create Dlg Hpp Code
  replaceAllSymbolsInStrLst(strLstHeaderCode, hppCode);

  strLstHeaderCode.Destroy;
  strLstSourceCode.Destroy;

  Result := SaveStringToFile(cppCode, ChangeFileExt(strFileName, CPP_EXT));
  //Create Source Code for the Cpp, H, and Form Files
  if Result then
  begin
    SaveStringToFile(hppCode, ChangeFileExt(strFileName, H_EXT));

    if (MainForm.ELDesigner1.GenerateXRC) then
    begin
    strLstXRCCode := TStringList.Create;
    strLstXRCCode.Add('<?xml version="1.0" encoding="ISO-8859-1"?>');
    strLstXRCCode.Add('<resource version="2.3.0.1">');
    strLstXRCCode.Add('<!-- Created by wx-devcpp ' + DEVCPP_VERSION + ' -->');

    // strLstXRCCode.Add(Format('<object class="%s" name="%s">', [frmNewForm.Wx_class, frmNewForm.Wx_Name]));

    //strLstXRCCode.Add('</object>');
    strLstXRCCode.Add('</resource>');
    Result := SaveStringToFile(strLstXRCCode.Text, ChangeFileExt(strFileName, XRC_EXT));
    strLstXRCCode.Destroy
    end;

end;

end;
{$ENDIF}

{$IFDEF WX_BUILD}
function TMainForm.CreateAppSourceCodes(strCppFile,strHppFile, strAppCppFile, strAppHppFile:String;FCreateFormProp: TfrmCreateFormProp; var cppCode, hppCode, appcppCode, apphppCode: string; dsgnType:TWxDesignerType): Boolean;
// This is scavenged from TMainForm.CreateSourceCodes (above)
// It uses the template files passed to it through the file names contained in
// strCppFile,strHppFile, strAppCppFile, and strAppHppFile to create new
// .cpp and .h files based on those templates. It replaces the keywords
// in the templates (%FILE_NAME%, %CLASS_NAME%, %AUTHOR_NAME%, etc.) with
// those supplied by the user. Finally, it creates a resource file and a
// wxform file for the new project.
var
  strClassName, strClassTitle, strClassStyleString, strFileName, strDate, strAuthor: string;
  strLstHeaderCode,strLstSourceCode,strLstAppHeaderCode,strLstAppSourceCode, strLstXRCCode:TStringList;

  function GetStyleString: string;
  var
    I: Integer;
    strLst: TStringList;
  begin
    strLst := TStringList.Create;

    if FCreateFormProp.cbUseCaption.checked then
      strLst.add('wxCAPTION');

    if FCreateFormProp.cbResizeBorder.checked then
      strLst.add('wxRESIZE_BORDER');

    if FCreateFormProp.cbSystemMenu.checked then
      strLst.add('wxSYSTEM_MENU');

    if FCreateFormProp.cbThickBorder.checked then
      strLst.add('wxTHICK_FRAME');

    if FCreateFormProp.cbStayOnTop.checked then
      strLst.add('wxSTAY_ON_TOP');

    if (dsgnType = dtWxDialog) then
        if FCreateFormProp.cbNoParent.checked then
                strLst.add('wxDIALOG_NO_PARENT');

    if FCreateFormProp.cbMinButton.checked then
      strLst.add('wxMINIMIZE_BOX');

    if FCreateFormProp.cbMaxButton.checked then
      strLst.add('wxMAXIMIZE_BOX');

    if FCreateFormProp.cbCloseButton.checked then
      strLst.add('wxCLOSE_BOX');

    if strLst.Count = 0 then
    begin
        if (dsgnType = dtWxDialog) then
          Result := 'wxDEFAULT_DIALOG_STYLE';

        if (dsgnType = dtWxFrame) then
          Result := 'wxDEFAULT_FRAME_STYLE';
    end
    else
    begin
      for I := 0 to strLst.count - 1 do // Iterate
      begin
        if i <> strLst.count - 1 then
          Result := Result + strLst[i] + '  |  '
        else
          Result := Result + ' ' + strLst[i] + ' ';
      end; // for
    end;
    strLst.destroy;
  end;

  // A function within a function
  // This replaces all occurrences of several keywords in a text string
  function replaceAllSymbolsInStrLst(strLst: TStrings; var strFileSrc: string):
      Boolean;
  begin
    Result := True;
    try
      strFileSrc := strLst.text;
      strSearchReplace(strFileSrc, '%FILE_NAME%', ExtractFileName(strFileName),[srAll]);
      strSearchReplace(strFileSrc, '%DEVCPP_DIR%', devDirs.Exec,[srAll]);
      strSearchReplace(strFileSrc, '%AUTHOR_NAME%', strAuthor, [srAll]);
      strSearchReplace(strFileSrc, '%DATE_STRING%', strDate, [srAll]);
      strSearchReplace(strFileSrc, '%CLASS_NAME%', strClassName, [srAll]);
      strSearchReplace(strFileSrc, '%CAP_CLASS_NAME%', UpperCase(strClassName),[srAll]);

      strSearchReplace(strFileSrc, '%CLASS_TITLE%', strClassTitle, [srAll]);
      strSearchReplace(strFileSrc, '%CLASS_STYLE_STRING%', strClassStyleString,[srAll]);
      strSearchReplace(strFileSrc, '%PROJECT_NAME%', ChangeFileExt(ExtractFileName(fProject.FileName), ''),[srAll]);
      strSearchReplace(strFileSrc, '%APP_NAME%', ChangeFileExt(ExtractFileName(fProject.FileName), '') + APP_SUFFIX,[srAll]);

    finally

    end;
  end;
begin
  Result := False;
  if not assigned(FCreateFormProp) then
    exit;

  strClassName := Trim(FCreateFormProp.txtClassName.Text);
  strDate := DateTimeToStr(now);
  strAuthor := Trim(FCreateFormProp.txtAuthorName.Text);
  strClassTitle := Trim(FCreateFormProp.txtTitle.Text);
  strClassStyleString := GetStyleString;

  strFileName := IncludeTrailingBackslash(Trim(FCreateFormProp.txtSaveTo.Text))
    + Trim(FCreateFormProp.txtFileName.Text);


    // Create a bunch of string buffers to hold the text of the template files
  strLstHeaderCode:=TStringList.Create;
  strLstSourceCode:=TStringList.Create;
  strLstAppHeaderCode:=TStringList.Create;
  strLstAppSourceCode:=TStringList.Create;

  // Load the template files into the string buffers we just created
  strLstHeaderCode.LoadFromFile(strHppFile);
  strLstSourceCode.LoadFromFile(strCppFile);
  strLstAppHeaderCode.LoadFromFile(strAppHppFile);
  strLstAppSourceCode.LoadFromFile(strAppCppFile);

  //Create Dlg Cpp Code
  replaceAllSymbolsInStrLst(strLstSourceCode, cppCode);

  //Create Dlg Hpp Code
  replaceAllSymbolsInStrLst(strLstHeaderCode, hppCode);

  //Create App Hpp Code
  replaceAllSymbolsInStrLst(strLstAppHeaderCode, apphppCode);

  //Create App Cpp Code
  replaceAllSymbolsInStrLst(strLstAppSourceCode, appcppCode);

  strLstHeaderCode.Destroy;
  strLstSourceCode.Destroy;
  strLstAppSourceCode.Destroy;
  strLstAppHeaderCode.Destroy;

  //Create Source Code for the Cpp, H, RC, and Form Files
  Result := SaveStringToFile(cppCode, ChangeFileExt(strFileName, CPP_EXT));
   if Result then
    Result := SaveStringToFile(hppCode, ChangeFileExt(strFileName, H_EXT));
  if Result then
    Result := SaveStringToFile(apphppCode, ChangeFileExt(fProject.FileName, '') + APP_SUFFIX + H_EXT);
   if Result then
    Result := SaveStringToFile(appcppCode, ChangeFileExt(fProject.FileName, '') +  APP_SUFFIX + CPP_EXT);

    if Result and MainForm.ELDesigner1.GenerateXRC then
      begin
        strLstXRCCode := TStringList.Create;
        strLstXRCCode.Add('<?xml version="1.0" encoding="ISO-8859-1"?>');
        strLstXRCCode.Add('<resource version="2.3.0.1">');
        strLstXRCCode.Add('<!-- Created by wx-devcpp ' + DEVCPP_VERSION + ' -->');

       // strLstXRCCode.Add(Format('<object class="%s" name="%s">', [frmNewForm.Wx_class, frmNewForm.Wx_Name]));

        //strLstXRCCode.Add('</object>');
        strLstXRCCode.Add('</resource>');
        Result := SaveStringToFile(strLstXRCCode.Text, ChangeFileExt(strFileName, XRC_EXT));
        strLstXRCCode.Destroy
      end;

    if Result then
       Result := SaveStringToFile('#include <wx/msw/wx.rc>', ChangeFileExt(fProject.FileName, '') +  APP_SUFFIX + '.rc');

end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.ReadClass;
begin
  RegisterClasses([TWxBoxSizer, TWxStaticBoxSizer,TWxGridSizer,TWxFlexGridSizer,TWxStaticText, TWxEdit, TWxButton, TWxBitmapButton, TWxToggleButton,TWxCheckBox,TWxRadioButton, TWxChoice, TWxComboBox, TWxGauge, TWxGrid,TWxListBox, TWXListCtrl, TWxMemo, TWxScrollBar, TWxSpinButton, TWxTreeCtrl]);
  RegisterClasses([TWXStaticBitmap, TWxstaticbox, TWxslider, TWxStaticLine]);
  RegisterClasses([TWxPanel,TWXListBook, TWxNoteBook, TWxStatusBar, TWxToolBar]);
  RegisterClasses([TWxNoteBookPage,TWxchecklistbox,TWxSplitterWindow]);
  RegisterClasses([TWxSpinCtrl,TWxScrolledWindow,TWxHtmlWindow,TWxToolButton,TWxSeparator]);
  RegisterClasses([TWxPopupMenu,TWxMenuBar]);
  RegisterClasses([TWxOpenFileDialog,TWxSaveFileDialog,TWxFontDialog, TwxMessageDialog,TWxProgressDialog,TWxPrintDialog,TWxFindReplaceDialog,TWxDirDialog,TWxColourDialog]);
  RegisterClasses([TWxPageSetupDialog]);
  RegisterClasses([TwxTimer]);

end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.Panel2Resize(Sender: TObject);
begin
  cbxControlsx.Width := Panel2.Width;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.PalleteListPanelResize(Sender: TObject);
begin
  Palettes.Width := PalleteListPanel.Width;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.LoadDefaultPalette;
// Load default palette when palette not exists
var
  IniFile: TIniFile;
  strTemp:String;
begin

  IniFile := TIniFile.Create(IncludeTrailingBackSlash(ExtractFileDir(Application.ExeName))+'devcpp.pallete');
  with IniFile do
  begin
    //Dont forget to add semicolon at the end of the string
    WriteString('Palette', 'Sizers','TWxBoxSizer;TWxStaticBoxSizer;TWxGridSizer;TWxFlexGridSizer;');
    strTemp:='TWxStaticText;TWxButton;TWxBitmapButton;TWxToggleButton;TWxEdit;TWxMemo;TWxCheckBox;TWxChoice;TWxRadioButton;TWxComboBox;TWxListBox;TWXListCtrl;TWxTreeCtrl;TWxGauge;TWxScrollBar;TWxSpinButton;TWxstaticbox;';
    strTemp:=strTemp+'TWxSlider;TWxStaticLine;TWxStaticBitmap;TWxStatusBar;TWxChecklistbox;TWxSpinCtrl;';
    WriteString('Palette', 'Controls',strTemp);
    WriteString('Palette', 'Window','TWxPanel;TWxNoteBook;TWxNoteBookPage;TWxGrid;TWxScrolledWindow;TWxHtmlWindow;TWxSplitterWindow;');
    WriteString('Palette', 'Toolbar','TWxToolBar;TWxToolButton;TWxSeparator;TWxEdit;TWxCheckBox;TWxRadioButton;TWxComboBox;TWxSpinCtrl;');
    WriteString('Palette', 'Menu','TWxMenuBar;TWxPopupMenu;');
    WriteString('Palette', 'Dialogs','TWxOpenFileDialog;TWxSaveFileDialog;TWxProgressDialog;TWxColourDialog;TWxDirDialog;TWxFindReplaceDialog;TWxFontDialog;TWxPageSetupDialog;TWxPrintDialog;TWxMessageDialog;');
    WriteString('Palette', 'System','TWxTimer;');
    //Deffered: TWxSingleChoiceDialog;TWxTextEntryDialog;
    WriteInteger('Version','IniVersion',IniVersion);
  end;
  IniFile.Destroy;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.LoadComponents;
// Dynamic loading components
var
  PaletteList: TStringList;
  intPos, I: Integer;
  PalettePage: string;
  strPalette: string;
  IniFile: TIniFile;
  intIniVersion:Integer;
begin
  IniFile := TIniFile.Create(IncludeTrailingBackSlash(ExtractFileDir(Application.ExeName))+'devcpp.pallete');
  PaletteList := TStringList.Create;
  try
    intIniVersion:=IniFile.ReadInteger('Version','IniVersion',0);

    if intIniVersion <> IniVersion then
        IniFile.EraseSection('Palette');

    ReadClass;
    IniFile.ReadSectionValues('Palette', PaletteList);

    if PaletteList.Count <= 0 then
    begin
      LoadDefaultPalette;
      IniFile.ReadSectionValues('Palette', PaletteList);
    end;

    for I := 0 to PaletteList.Count - 1 do
    begin
      strPalette := PaletteList[i];
      intPos := Pos('=', strPalette);
      if intPos <> 0 then
      begin
        strPalette := Copy(strPalette, 0, intPos - 1);
      end;
      Palettes.Items.Add(strPalette);
    end;
    //Show all controls
    Palettes.Items.Add('All');

    for I := 0 to PaletteList.Count - 1 do
    begin
      PalettePage := PaletteList.Names[I];
      if PalettePage <> '' then
      begin
        CreatePalettePage(PaletteList,PalettePage);
        Break;
      end;
    end;

    if Palettes.Items.Count > 0 then
    begin
      Palettes.ItemIndex := Palettes.Items.Count-1;
      self.PalettesChange(Palettes);
    end;

    lbxControls.ItemIndex := 0;

  finally
    PaletteList.destroy;
    IniFile.Destroy;
  end;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.CreatePalettePage(PaletteLst:TStringList;PalettePage: string);
// Create component of palette page (page name is PalettePage)
var
  ComponentNames, ComponentName: string;
  Temp, Pos1,J: Integer;
  IniFile: TIniFile;
  function NPos(const C: string; S: string; StartPos, Length: Integer): Integer;
  var
    I: Integer;
    S1: string;
  begin
    Result := 0;
    if (S = '') then
      Exit;
    S1 := Copy(S, StartPos, Length);
    I := Pos(UpperCase(C), UpperCase(S1));
    if I > 0 then
      Result := I + StartPos;
  end;
  procedure RawCreatePalletePage(strPallete:String);
  begin
  IniFile := TIniFile.Create(IncludeTrailingBackSlash(ExtractFileDir(Application.ExeName))+'devcpp.pallete');
  ComponentNames := IniFile.ReadString('Palette', strPallete, '');
  if ComponentNames = '' then
  begin
    IniFile.Destroy;
    Exit;
  end;
  Temp := 1;

  while True do
  begin
    Pos1 := NPos(';', ComponentNames, Temp, Length(ComponentNames));
    if Pos1 = 0 then
      Break;
    ComponentName := Copy(ComponentNames, Temp, Pos1 - Temp - 1);
    Temp := Pos1;

    //CreateButton(ComponentName);
    if trim(ComponentName) = '' then
        continue;

    if lbxControls.Items.IndexOf(ComponentName) = -1 then
        lbxControls.Items.Add(ComponentName);

  end;

  IniFile.Destroy;
  end;
begin
  lbxControls.Items.BeginUpdate;
  lbxControls.Items.Clear;
  lbxControls.Items.Add('CURSOR');

  if AnsiSameText(PalettePage,'All')  then
  begin
        for J := 0 to PaletteLst.Count - 1 do    // Iterate
            RawCreatePalletePage(PaletteLst[J]);
  end
  else
    RawCreatePalletePage(PalettePage);

  lbxControls.Items.EndUpdate;
  if lbxControls.Items.Count > 0 then
    lbxControls.ItemIndex := 0;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.lbxControlsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  ComponentName, DisplayName: string;
  ResName: array[0..64] of Char;
  Bitmap: TBitmap;
begin
  { access canvas }
  with TListBox(Control), Canvas do
  begin
    ComponentName := lbxControls.Items[Index];
    DisplayName := Copy(ComponentName, 4, Length(ComponentName));
    { get linked control-dependant from index }
    //InnoControl := CoreServices.ControlManager.Controls[Index];

    { draw background }
    if not (odSelected in State) then
      if Index = 0 then
        Brush.Color := clWhite
      else
        Brush.Color := clBtnFace;

    FillRect(Rect);
    Dec(Rect.Right, 3);

    { draw control bitmap }
    Bitmap := TBitmap.Create;
    try
      StrPLCopy(ResName, ComponentName, SizeOf(ResName));
      AnsiUpper(ResName);

      Bitmap.Handle := LoadBitmap(hInstance, ResName);

      Bitmap.Transparent := True;
      Draw(Rect.Left + 1, Rect.Top + 1, Bitmap);
      Inc(Rect.Left, Bitmap.Width + 5);
    finally // wrap up
      Bitmap.Free;
    end; // try/finally

    { draw control type name }
    SetBkMode(Handle, Transparent);
    if Index <> 0 then
      DrawText(Handle, PChar(DisplayName), -1, Rect,
        DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS)
    else
      DrawText(Handle, 'Selector', -1, Rect,
        DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS);

    { draw seperator }
    Pen.Color := clSilver;
    MoveTo(0, Rect.Bottom - 1);
    LineTo(ClientWidth, Rect.Bottom - 1);
  end;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.PalettesChange(Sender: TObject);
var
    allPalletes:TStringList;
begin
  if Palettes.ItemIndex = -1 then
    Exit;
  allPalletes:=TStringList.Create;
  allPalletes.Assign(Palettes.Items);
  try
    CreatePalettePage(allPalletes,Palettes.Items[Palettes.ItemIndex]);
  finally
    allPalletes.Destroy;
  end;

  try

  if ((lbxControls.enabled = true ) and (lbxControls.visible)) then
    lbxControls.SetFocus;
  except
  end;

end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.lbxControlsClick(Sender: TObject);
begin
  if lbxControls.ItemIndex <> -1 then
  begin
    SelectedComponentName := lbxControls.Items[lbxControls.ItemIndex];
  end;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.ELDesigner1ContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
    Handled:=true;
    DesignerPopup.Popup(MousePos.X,MousePos.Y);
end;

procedure TMainForm.WxPropertyInspectorContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
    Handled:=true;
    WxPropertyInspectorPopup.Popup(MousePos.X,MousePos.Y);
end;

procedure TMainForm.ELDesigner1ChangeSelection(Sender: TObject);
begin
  try

     { Make sure Designer Form has the focus }
     ELDesigner1.DesignControl.SetFocus;
    { clear inspector }

    { delete design control from selection }
    if (ELDesigner1.SelectedControls.Count > 0) then
    begin
      cbxControlsx.ItemIndex :=
        cbxControlsx.Items.IndexOfObject(ELDesigner1.SelectedControls[0]);
      BuildProperties(ELDesigner1.SelectedControls[0]);
    //ELPropertyInspector1.Clear;
    //ELPropertyInspector1.Add(ELDesigner1.SelectedControls[0]);

    end
    else
    begin
      if isCurrentPageDesigner then
      begin
        BuildProperties(GetCurrentDesignerForm());
        //ELPropertyInspector1.Clear;
        //ELPropertyInspector1.Add(GetCurrentDesignerForm());
      end;
    end;

    { sync controllist }
  finally

  end;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.ELDesigner1ControlDeleted(Sender: TObject;
  AControl: TControl);
var
  intCtrlPos,i: Integer;
  e: TEditor;
  boolContrainer:boolean;
begin
   boolContrainer := False;
  ///SaveProjectFiles(strProjectFile,True,false);
  intCtrlPos := cbxControlsx.Items.IndexOfObject(AControl);
  //boolContrainer:=(IsControlWxContainer(AControl) or IsControlWxSizer(AControl));
  if intCtrlPos <> -1 then
  begin
    cbxControlsx.Items.Delete(intCtrlPos);
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
{$ENDIF}

{$IFDEF WX_BUILD}
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
{$ENDIF}


{$IFDEF WX_BUILD}
procedure TMainForm.ELDesigner1ControlInserted(Sender: TObject; AControl: TControl);
var
  I: Integer;
  compObj: Tcomponent;
  wxcompInterface: IWxComponentInterface;
  strClass: string;
  e: TEditor;
begin

 FirstComponentBeingDeleted:='';
  if ELDesigner1.SelectedControls.Count > 0 then
  begin
    compObj := ELDesigner1.SelectedControls[0];
    ELDesigner1.SelectedControls[0].BringToFront;
    ELDesigner1.SelectedControls[0].Visible:=true;
    //sendDebug('Parent= ' + ELDesigner1.SelectedControls[0].Parent.Name);
    if compObj.GetInterface(IID_IWxComponentInterface, wxcompInterface) then
    begin
      strClass := wxcompInterface.GetWxClassName;
      SelectedComponent := compObj;
    end;
    cbxControlsx.ItemIndex :=
      cbxControlsx.Items.AddObject(ELDesigner1.SelectedControls[0].Name + ':' +
      strClass, ELDesigner1.SelectedControls[0]);
  end;

  if (AControl is TWinControl) then
  begin
    //todo: Try to create an interface to make sure whether a container has a limiting controls.
    //If someone is dropping more than one control then we'll make the
    //controls's parent as the parent of SplitterWindow
    if (TWinControl(AControl).Parent <> nil) and  (TWinControl(AControl).Parent is TWxSplitterWindow) then
    begin
        if TWinControl(AControl).Parent.ControlCount > 2 then
            TWinControl(AControl).Parent:= TWinControl(AControl).Parent.Parent;
    end;
  end;


  if SelectedComponent <> nil then
  begin
    if (SelectedComponent is TWxNoteBookPage) then
    begin
        //SelectedComponent.Owner:=PreviousComponent;
        TWinControl(SelectedComponent).Parent:=TWinControl(PreviousComponent);
        TWxNoteBookPage(SelectedComponent).PageControl:=TPageControl(PreviousComponent);
    end;

    if(SelectedComponent is TWxNonVisibleBaseComponent) then
    begin
        TWxNonVisibleBaseComponent(SelectedComponent).Parent:=ELDesigner1.DesignControl;
    end;

    if TfrmNewForm(ELDesigner1.DesignControl).Wx_DesignerType = dtWxFrame then
    begin
          //////////////////////////////////////////////////////////////////////
          if(SelectedComponent is TWxToolBar) then
          begin              
              TWxToolBar(SelectedComponent).Parent:=ELDesigner1.DesignControl;
          end;

         if(SelectedComponent is TWxStatusBar) then
          begin
            TWxStatusBar(SelectedComponent).Parent:=ELDesigner1.DesignControl;
          end;   
          //////////////////////////////////////////////////////////////////////

      if GetWxWindowControls(ELDesigner1.DesignControl) = 1 then
      begin
          if IsControlWxWindow(Tcontrol(SelectedComponent)) then
          begin
            if TWincontrol(SelectedComponent).Parent is TForm then
                TWincontrol(SelectedComponent).Align:=alClient;
          end;
      end;
    end;
  end;

  PreviousComponent:=nil;
  for I := 0 to ELDesigner1.SelectedControls.Count - 1 do // Iterate
  begin
    compObj := ELDesigner1.SelectedControls[i];
    if compObj is TWinControl then
    begin
        //if we drop a control to image oor other static
        //controls that are derived from TWxControlPanel
        if TWinControl(compObj).Parent is TWxControlPanel then
        begin
            try
                if assigned(TWinControl(compObj).parent.parent) then
                    TWinControl(compObj).parent:=TWinControl(compObj).parent.parent;
            except
            end;
        end;
    end;

    try
      if compObj.GetInterface(IID_IWxComponentInterface, wxcompInterface) then
      begin
        Inc(intControlCount);
        wxcompInterface.SetIDName('ID_' + UpperCase(compObj.Name));
        wxcompInterface.SetIDValue(intControlCount);
      end;
    except

    end;
  end; // End for

  SelectedComponentName := '';
  resetPallete;
  ActiveControl := nil;

  e := GetEditor(Self.PageControl.ActivePageIndex);
  if Assigned(e) then
    e.UpdateDesignerData;

  //This makes the Sizers get painted properly.
  if ELDesigner1.SelectedControls.Count > 0 then
  begin
        compObj:=ELDesigner1.SelectedControls[0].parent;

        if compObj is TWinControl then
        begin
            while(compObj <> nil) do
            begin
                TWinControl(compObj).refresh;
                TWinControl(compObj).repaint;
                TWinControl(compObj):=TWinControl(compObj).parent;
            end;    // for
        end;
  end;

  ELDesigner1.DesignControl.Refresh;
  ELDesigner1.DesignControl.Repaint;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.resetPallete;
begin
  if lbxControls.count > 0 then
    lbxControls.ItemIndex := 0;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.DisableDesignerControls;
begin

  //PageControl.PopupMenu:=EditorPopupMenu;
  SplitterRight.Enabled:=false;
  SplitterRight.Visible:=false;

  cbxControlsx.Enabled := False;
  pgCtrlObjectInspector.Enabled := False;

  JvInspProperties.Enabled := False;
  JvInspEvents.Enabled := False;
  Palettes.Enabled := False;
  lbxControls.Enabled := False;
  pnlControlHolder.Visible := false;

  ELDesigner1.Active:=False;
  ELDesigner1.DesignControl:=nil;

  SelectedComponent:=nil;
  if boolInspectorDataClear = true then
  begin
  try

  JvInspProperties.Clear;
  if Assigned(JvInspProperties.Root) then
    JvInspProperties.Root.Clear;
  except
  end;

  try
  JvInspEvents.Clear;
  if Assigned(JvInspEvents.Root) then
    JvInspEvents.Root.Clear;
  except
  end;
  end;
    boolInspectorDataClear := true;
  cbxControlsx.Items.Clear;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.EnableDesignerControls;
begin
//I have no clue why I'm getting an error at this place.
  try
    if Assigned(ELDesigner1.DesignControl) then
    begin
        ELDesigner1.Active:=True;
        ELDesigner1.DesignControl.SetFocus;
    end;
  except
    cbxControlsx.Enabled := true;
  end;
  cbxControlsx.Enabled := true;
  pgCtrlObjectInspector.Enabled := true;
  JvInspProperties.Enabled := true;
  JvInspEvents.Enabled := true;
  Palettes.Enabled := true;
  lbxControls.Enabled := true;
  pnlControlHolder.Visible := True;
  SplitterRight.Enabled:=true;
  SplitterRight.Visible:=true;
  //PageControl.PopupMenu:=nil;

end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.ELDesigner1ControlInserting(Sender: TObject;
  var AControlClass: TControlClass);
  
var
      dlgInterface:IWxDialogNonInsertableInterface;
      tlbrInterface:IWxToolBarInsertableInterface;
      nontlbrInterface:IWxToolBarNonInsertableInterface;
      CurrentParent:TWinControl;

function GetNonAllowAbleControlCountForFrame(winCtrl:TWinControl):Integer;
var
  I: Integer;
begin
    Result:=0;
    //Weird error remover ... Shitty solution.
    FirstComponentBeingDeleted:='';

    if winCtrl = nil then
        exit;
    Result := 0;
    for I := 0 to winCtrl.ControlCount - 1 do    // Iterate
    begin
        if (winCtrl.Controls[i] is TWxToolBar) or (winCtrl.Controls[i] is TWxMenuBar)
        or (winCtrl.Controls[i] is TWxStatusBar) or (winCtrl.Controls[i] is TWxPopupMenu)
        or (winCtrl.Controls[i] is TWxNonVisibleBaseComponent) then
        begin
            continue;
        end;
        inc(Result);
    end;    // for
end;

function isSizerAvailable(winCtrl:TWinControl):Boolean;
var
  I: Integer;
begin
    Result:=false;
    //Weird error remover ... Shitty solution.
    FirstComponentBeingDeleted:='';

    if winCtrl = nil then
        exit;
    for I := 0 to winCtrl.ComponentCount - 1 do    // Iterate
    begin
        if winCtrl.Components[i] is TWxSizerPanel then
        begin
            Result:=true;
            exit;
        end;
    end;    // for
end;

procedure ShowErrorAndReset(msgstr:String);
begin
    SelectedComponentName := '';
    resetPallete;
    PreviousComponent:=nil;
    MessageDlg(msgstr, mtError, [mbOK], 0);
    AControlClass:=nil;
    sendMessage(CurrentParent.Handle,WM_LBUTTONDOWN,0,MAKELONG(100,100));
    PostMessage(CurrentParent.Handle,WM_LBUTTONDOWN,0,MAKELONG(100,100));

    sendMessage(CurrentParent.Handle,BM_CLICK,0,MAKELONG(100,100));
    PostMessage(CurrentParent.Handle,BM_CLICK,0,MAKELONG(100,100));

    sendMessage(CurrentParent.Handle,WM_LBUTTONUP,0,MAKELONG(100,100));
    PostMessage(CurrentParent.Handle,WM_LBUTTONUP,0,MAKELONG(100,100));
    
    sendMessage(CurrentParent.Handle,WM_LBUTTONDOWN,0,MAKELONG(100,100));
    PostMessage(CurrentParent.Handle,WM_LBUTTONDOWN,0,MAKELONG(100,100));

    sendMessage(CurrentParent.Handle,BM_CLICK,0,MAKELONG(100,100));
    PostMessage(CurrentParent.Handle,BM_CLICK,0,MAKELONG(100,100));

    sendMessage(CurrentParent.Handle,WM_LBUTTONUP,0,MAKELONG(100,100));
    PostMessage(CurrentParent.Handle,WM_LBUTTONUP,0,MAKELONG(100,100));

end;

begin

  if trim(SelectedComponentName) = '' then
  begin
    exit;
  end;

  AControlClass := TControlClass(GetClass(SelectedComponentName));
    if AControlClass = nil then
    begin
        exit;
    end;


    if ELDesigner1.SelectedControls.count > 0 then
    begin
        CurrentParent:=TWinControl(ELDesigner1.SelectedControls[0]);
    end
    else
    begin
        CurrentParent:=nil;
        CurrentParent:=ELDesigner1.DesignControl;
    end;

    if TFrmNewForm(ELDesigner1.DesignControl).Wx_DesignerType = dtWxFrame then
    begin
        if strContainsU(SelectedComponentName,'TWxStatusBar') then
        begin
            if GetAvailableControlCount(ELDesigner1.DesignControl,'TWxStatusBar') > 0 then
            begin
              ShowErrorAndReset('You cannot have more than one Statusbar');
              exit;
            end;
        end;
         {BugFix for #1064084} 
//        if strContainsU(SelectedComponentName,'TWxToolBar') then
//        begin
//            if GetAvailableControlCount(ELDesigner1.DesignControl,'TWxToolBar') > 0 then
//            begin
//              ShowErrorAndReset('You cannot have more than one ToolBar');
//              exit;
//            end;
//        end;

        if strContainsU(SelectedComponentName,'TWxMenuBar') then
        begin
            if GetAvailableControlCount(ELDesigner1.DesignControl,'TWxMenuBar') > 0 then
            begin
              ShowErrorAndReset('You cannot have more than one MenuBar');
              exit;
            end;
        end;

      if TWinControl(AControlClass.NewInstance).GetInterface(IID_IWxToolBarInsertableInterface,tlbrInterface) then
      begin
          if not (StrContainsU(CurrentParent.ClassName,'TWxToolBar')) then
          begin
              if not (TWinControl(AControlClass.NewInstance).GetInterface(IID_IWxToolBarNonInsertableInterface,nontlbrInterface)) then
              begin
                ShowErrorAndReset('You cannot insert Toolbar control in Dialog. Use Toolbar only in wxFrame.');
                exit;
              end;
          end;
      end
      else
      begin
        if not (strContainsU(CurrentParent.ClassName,'TFrmNewForm')=true) then
        begin
            if CurrentParent.Parent <> nil then
            begin
                if (StrContainsU(CurrentParent.Parent.ClassName,'TWxToolBar')) then
                begin
                    ShowErrorAndReset('You cannot insert this control in ToolBar');
                    exit;
                end;
            end;
        end;
        if (StrContainsU(CurrentParent.ClassName,'TWxToolBar')) then
        begin
            ShowErrorAndReset('You cannot insert this control in ToolBar');
            exit;
        end;
      end;
    end
    Else
    begin
        if TWinControl(AControlClass.NewInstance).GetInterface(IID_IWxDialogNonInsertableInterface,dlgInterface) then
	begin
	    ShowErrorAndReset('You cannot insert this control in Dialog. Use this control only in wxFrame.');
            exit;
        end;
    end;


        if TWinControl(AControlClass.NewInstance) is TWxSizerPanel AND not StrContainsU(CurrentParent.ClassName, 'TWxPanel') then
	begin
            if (ELDesigner1.DesignControl.ComponentCount - GetNonVisualComponentCount(TForm(ELDesigner1.DesignControl))) > 0 then
            begin
                if isSizerAvailable(ELDesigner1.DesignControl) = false then
                begin
                    if GetNonAllowAbleControlCountForFrame(ELDesigner1.DesignControl) > 0 then
                    begin
                        ShowErrorAndReset('You cannot add a sizer if you have other standard components.'+#13+#10+''+#13+#10+'Please remove all the controls before adding a sizer.');
                        exit;
                    end;
                end;
            end;
        end;

        PreviousComponent:=nil;       

        if TWinControl(AControlClass.NewInstance) is TWxNoteBookPage then
        begin
            if ELDesigner1.SelectedControls.count = 0 then
            begin
                   ShowErrorAndReset('Please select a NoteBook and drop the page.');
                   exit;
            end;
            //AControlClass.
            PreviousComponent:=ELDesigner1.SelectedControls[0];
            if (ELDesigner1.SelectedControls[0] is TWxNoteBookPage) then
            begin
                PreviousComponent:=ELDesigner1.SelectedControls[0].Parent;
                exit;
            end;

            if not (ELDesigner1.SelectedControls[0] is TWxNoteBook) then
            begin
                ShowErrorAndReset('Please select a NoteBook and drop the page.');
                exit;
            end;
        end;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
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
{$ENDIF}

{$IFDEF WX_BUILD}
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
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.BuildProperties(Comp: TControl;boolForce:Boolean);
var
    strValue:String;
    strSelName,strCompName:String;
begin

if not boolForce then
begin
 if  DisablePropertyBuilding = true then
    exit;
  if assigned(SelectedComponent) then
    strSelName:=SelectedComponent.Name;

  if assigned(comp) then
    strCompName:=comp.Name;

  PreviousStringValue := '';

  if AnsiSameText(strSelName,strCompName) then
  begin
        SelectedComponent:=Comp;
        Exit;
  end;

  if FirstComponentBeingDeleted = Comp.Name then
    exit;

  if Comp = nil then
    Exit;

//  if SelectedComponent = Comp then
//    exit;
end
else
begin
  if Comp = nil then
    Exit;
end;

  SelectedComponent := Comp;

    if JvInspProperties.Root <> nil then
    begin
        if JvInspProperties.Root.Data <> nil then
        begin
            try
                strValue:=TWinControl(TJvInspectorPropData(JvInspProperties.Root.Data).Instance).Name;
            except
                strValue:='1*NoData';
            end;
        end;
    end;

  if strValue = '1*NoData' then
    exit;
  try
    JvInspProperties.Root.Clear;
    TJvInspectorPropData.New(JvInspProperties.Root, Comp);
  except
  end;

  try
    JvInspEvents.Root.Clear;
    TJvInspectorPropData.New(JvInspEvents.Root, Comp);
  except
  end;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
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
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.JvInspPropertiesAfterItemCreate(Sender: TObject; Item: TJvCustomInspectorItem);
var
  I: Integer;
  StrCompName, StrCompCaption: string;
  boolOk: Boolean;
  strLst: TStringList;
  strTemp: string;
  wxcompInterface: IWxComponentInterface;
begin
  
  boolOk := false;
  if SelectedComponent  = nil then
  begin
    //boolOk := False;
    Exit;
  end;

  if not Assigned(Item) then
  begin
    //boolOk := False;
    Exit;
  end;

  if SelectedComponent <> nil then
  begin
    if IsValidClass(SelectedComponent) then
    begin
      strTemp := SelectedComponent.ClassName;
      if SelectedComponent.GetInterface(IID_IWxComponentInterface,wxcompInterface) then
        strLst := wxcompInterface.GetPropertyList
      else
        strLst := nil;

      try
        if strLst <> nil then
        begin
            if strLst.Count > 0 then
                strLst[0]:=strLst[0];
        end
        else
            exit;
      Except
        Exit;
      end;

      if strLst = nil then
      begin
        //sendDebug('I''m here');
      end;
      
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
          begin
            Item.Flags := Item.Flags  - [iifMultiLine];
          end;

          if AnsiSameText(Item.Data.TypeInfo.Name, 'TPicture') then
          begin
            Item.Flags := Item.Flags + [iifEditButton];
          end;

          if AnsiSameText(Item.Data.TypeInfo.Name, 'TListItems') then
          begin
            Item.Flags := Item.Flags + [iifEditButton];
          end;

          if AnsiSameText(Item.Data.TypeInfo.Name, 'TTreeNodes') then
          begin
            Item.Flags := Item.Flags + [iifEditButton];
          end;
          Item.DisplayName := StrCompCaption;
          boolOk := true;
          break;
        end;

      end; // for

    end;

  end;

  //  if Item is TJvInspectorBooleanItem then
   //  TJvInspectorBooleanItem(Item).ShowAsCheckbox := True;

  Item.Hidden := not boolOk;
  //Item.Hidden:= false;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
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

    if assigned(JvInspProperties.Selected.Data) then
    begin
        strValue:=JvInspProperties.Selected.Data.TypeInfo.Name ;
        if UpperCase(strValue) = UpperCase('TPicture') then
        begin
                e := GetEditor(PageControl.ActivePageIndex);
                strValue:=TJvInspectorPropData(JvInspProperties.Selected.Data).Instance.ClassName;
                if Assigned(e) then
                begin
                    if UpperCase(SelectedComponent.ClassName) = UpperCase('TFrmNewForm') then
                        GenerateXPMDirectly(TFrmNewForm(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Wx_ICON.Bitmap,e.GetDesigner.Wx_Name,e.FileName);

                    if UpperCase(SelectedComponent.ClassName) = UpperCase('TStaticBitmap') then
                        GenerateXPMDirectly(TWxStaticBitmap(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Picture.Bitmap,SelectedComponent.Name,e.FileName);

                    if UpperCase(SelectedComponent.ClassName) = UpperCase('TWxBitmapButton') then
                        GenerateXPMDirectly(TWxBitmapButton(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Wx_Bitmap.Bitmap,SelectedComponent.Name,e.FileName);

                    if UpperCase(SelectedComponent.ClassName) = UpperCase('TWxToolButton') then
                        GenerateXPMDirectly(TWxToolButton(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Wx_Bitmap.Bitmap,SelectedComponent.Name,e.FileName);

                end;
        end;
    end;

    if UpperCase(Trim(JvInspProperties.Selected.DisplayName)) = UpperCase('NAME') then
    begin
        if not ClassBrowser1.Enabled then
        begin
            MessageDlg('Class Browser is not enabled.'+#13+#10+''+#13+#10+'Class Names in the sources are not Changed', mtWarning, [mbOK], 0);
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
                        RenameFile(strDirName+'\'+PreviousStringValue+'_XPM.xpm',strDirName+'\'+TfrmNewForm(comp).Wx_Name+'_XPM.xpm');
                        GenerateXPM(e.GetDesigner,e.FileName,true);
                    end;
                finally
                    hppStrLst.Destroy;
                    cppStrLst.Destroy;
                end;
              //ReplaceClassNameInEditorFile(ChangeFileExt(e.FileName, CPP_EXT), PreviousStringValue, TfrmNewForm(comp).Wx_Name);
              //ReplaceClassNameInEditorFile(ChangeFileExt(e.FileName, H_EXT),PreviousStringValue, TfrmNewForm(comp).Wx_Name);
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
{$ENDIF}

{$IFDEF WX_BUILD}
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
{$ENDIF}

{$IFDEF WX_BUILD}
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
{$ENDIF}

{$IFDEF WX_BUILD}
function TMainForm.LocateFunction(strFunctionName:String):boolean;
begin
   Result := False;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
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
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.JvInspEventsDataValueChanged(Sender: TObject;
  Data: TJvCustomInspectorData);
var
  str,ErrorString: string;
  e: TEditor;
  boolIsFilesDirty: Boolean;
  componentInstance:TComponent;
  propertyName,wxClassName,propDisplayName:string;

procedure SetPropertyValue(Comp:TComponent;strPropName,strPropValue:String);
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
  try

    if JvInspEvents.Selected = nil then
      Exit;

    if JvInspEvents.Selected.Visible = False then
      Exit;


    e := GetEditor(PageControl.ActivePage.TabIndex);
    if not Assigned(e) then
      Exit;

    if not e.isForm then
      Exit;

    if Data.AsString = '<Add New Function>' then
    begin
        if not ClassBrowser1.Enabled then
        begin
            MessageDlg('Class Browser is not enabled.'+#13+#10+''+#13+#10+'Event handlers wont work', mtWarning, [mbOK], 0);
            Data.AsString := '';
            Exit;
        end;

      boolIsFilesDirty := false;

      if e.IsDesignerHPPOpened then
      begin
        boolIsFilesDirty := e.GetDesignerHPPEditor.Modified;
      end;

      if not boolIsFilesDirty then
      begin
        if e.IsDesignerCPPOpened then
          boolIsFilesDirty := e.GetDesignerCPPEditor.Modified;
      end;

      if boolIsFilesDirty then
      begin
        if MessageDlg('Unable to Add Function.' + #13 + #10 +
          'Corresponding Source Files are not saved.' + #13 + #10 + '' + #13 +
          #10
          + 'Do you want to save the source to add new function ?',
          mtConfirmation,
          [mbYes, mbNo], 0) <> mrYes then
        begin
          Data.AsString := '';
          Exit;
        end;
        if e.IsDesignerHPPOpened then
        begin
          //This wont open a new editor window
          SaveFile(e.GetDesignerHPPEditor);
        end;

        if e.IsDesignerCPPOpened then
        begin
          //This wont open a new editor window
          SaveFile(e.GetDesignerCPPEditor);
        end;
      end;

      //Guru: ToDo: add functions to make sure the files are saved properly
      if SelectedComponent <> nil then
      begin
        str := JvInspEvents.Selected.DisplayName;

        if SelectedComponent is TfrmNewForm then
        begin
          str := TfrmNewForm(SelectedComponent).Wx_Name + Copy(str, 3,
            Length(str));
        end
        else
          str := SelectedComponent.Name + Copy(str, 3, Length(str));

        Data.AsString := str;
        str := Trim(str);

        //SendDebug(JvInspEvents.Selected.Data.Name);
        componentInstance:=SelectedComponent;
        propertyName:=Data.Name;
        wxClassName:=Trim(e.getDesigner().Wx_Name);
        propDisplayName:=JvInspEvents.Selected.DisplayName;
        if CreateFunctionInEditor(Data,wxClassName,SelectedComponent, str,propDisplayName,ErrorString) then
        begin

          //This is causing AV, so I moved this operation to
          //CreateFunctionInEditor
          //Data.AsString := str;
          SetPropertyValue(componentInstance,propertyName,str);

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
    Else
    begin
        //LocateFunction(Data,Trim(e.getDesigner().Wx_Name),SelectedComponent, str, JvInspEvents.Selected.DisplayName);
    end;


    if Data.AsString = '<Goto Function>' then
    begin
        if not ClassBrowser1.Enabled then
        begin
            MessageDlg('Class Browser is not enabled.'+#13+#10+''+#13+#10+'Event handlers locate functions wont work', mtWarning, [mbOK], 0);
            Data.AsString := strGlobalCurrentFunction;
            Exit;
        end;
        
      boolIsFilesDirty := false;

      if e.IsDesignerHPPOpened then
      begin
        boolIsFilesDirty := e.GetDesignerHPPEditor.Modified;
      end;

      if not boolIsFilesDirty then
      begin
        if e.IsDesignerCPPOpened then
          boolIsFilesDirty := e.GetDesignerCPPEditor.Modified;
      end;

      if boolIsFilesDirty then
      begin
        if MessageDlg('Unable to Locate Function.' + #13 + #10 +
          'Corresponding Source Files are not saved.' + #13 + #10 + '' + #13 +
          #10
          + 'Do you want to save the source to add new function ?',
          mtConfirmation,
          [mbYes, mbNo], 0) <> mrYes then
        begin
          Data.AsString := '';
          Exit;
        end;
        if e.IsDesignerHPPOpened then
        begin
          //This wont open a new editor window
          SaveFile(e.GetDesignerHPPEditor);
        end;

        if e.IsDesignerCPPOpened then
        begin
          //This wont open a new editor window
          SaveFile(e.GetDesignerCPPEditor);
        end;
      end;

      Data.AsString := strGlobalCurrentFunction;
      strGlobalCurrentFunction:='';
      if SelectedComponent <> nil then
      begin
        str := trim(Data.AsString);
//
//        if SelectedComponent is TfrmNewForm then
//        begin
//          str := TfrmNewForm(SelectedComponent).Wx_Name + Copy(str, 3,
//            Length(str));
//        end
//        else
//          str := SelectedComponent.Name + Copy(str, 3, Length(str));
//
//        Data.AsString := str;
//        str := Trim(str);

        LocateFunctionInEditor(Data,Trim(e.getDesigner().Wx_Name),SelectedComponent, str, JvInspEvents.Selected.DisplayName);
        exit;
      end;

    end;


    if Data.AsString = '<Remove Function>' then
    begin
      Data.AsString := '';
    end;

    UpdateDefaultFormContent;

  except
  end;

end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.JvInspEventsItemValueChanged(Sender: TObject;
  Item: TJvCustomInspectorItem);
begin
  if JvInspEvents.Selected = nil then
    Exit;

  if JvInspEvents.Selected.Visible = False then
    Exit;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
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
{$ENDIF}
{$IFDEF WX_BUILD}
function TMainForm.LocateFunctionInEditor(eventProperty:TJvCustomInspectorData;strClassName: string; SelComponent:TComponent; var strFunctionName: string; strEventFullName: string): Boolean;

function isFunctionAvailableInEditor(intClassID:Integer;strFunctionName:String;intLineNum:Integer;strFname:String):boolean;
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
      strFname:=St2._DeclImplFileName;
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
begin
  Result := False;
  boolFound := False;
  AddScopeStr := False;
  intLineNum := 0;
  Line := 0;
  St := nil;
  
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
    Exit;
  end;

  strOldFunctionName:=strFunctionName;

  if isFunctionAvailableInEditor(St._ID,strOldFunctionName,intLineNum,strFname) then
  begin
    boolInspectorDataClear:=False;
    OpenFile(strFname);
    e:=GetEditorFromFileName(strFname);
    if assigned(e) then
    begin
        //Fixme: check for valiud line num here
        e.Text.CaretX:=0;
        e.Text.CaretX:=intLineNum;
        OpenFile(e.GetDesignerCPPFileName);
    end;
    boolInspectorDataClear:=False;
  end;
  exit;

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
    Line := CppEditor.Lines.Count;

    Cppeditor.Lines.Append('}');
    Cppeditor.Lines.Append('');
    Result := True;
    CppEditor.CaretY := Line;
    e.GetDesignerCPPEditor.InsertString('', true);

    boolInspectorDataClear:=False;
    OpenFile(e.GetDesignerCPPFileName);
    boolInspectorDataClear:=False;
    e.UpdateDesignerData;
    boolInspectorDataClear:=False;
  end;

end;
{$ENDIF}

{$IFDEF WX_BUILD}

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

  S := #9;
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
    OpenFile(e.GetDesignerCPPFileName);
    boolInspectorDataClear:=False;
    e.UpdateDesignerData;
    boolInspectorDataClear:=False;
  end;

end;
{$ENDIF}

{$IFDEF WX_BUILD}
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
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.UpdateDefaultFormContent;
var
  e: TEditor;
begin
  e := GetEditor(MainForm.PageControl.ActivePageIndex);

  if not Assigned(e) then
    Exit;

  if not e.isForm then
    Exit;

  e.UpdateDesignerData;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
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

   //SelectedComponent:=ELDesigner1.DesignControl;
   BuildProperties(ELDesigner1.DesignControl,true);
   DisablePropertyBuilding:=true;
   try
    if ELDesigner1.CanCut then
            ELDesigner1.Cut;
   except
   end;
   DisablePropertyBuilding:=false;

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

   //SelectedComponent:=ELDesigner1.DesignControl;
   BuildProperties(ELDesigner1.DesignControl,true);
   DisablePropertyBuilding:=true;
   try
        if ELDesigner1.CanPaste then
            ELDesigner1.Paste;
   except
   end;
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
    if IsFromScrollBarShowing then
    begin
        MessageDlg('The Designer Form is scrolled. '+#13+#10+''+#13+#10+'Please resize the form to hide the scrollbar before deleting controls.', mtError, [mbOK], 0);
        exit;
    end;

   //SelectedComponent:=ELDesigner1.DesignControl;
   BuildProperties(ELDesigner1.DesignControl,true);
   DisablePropertyBuilding:=true;
   try
    ELDesigner1.DeleteSelectedControls;
   except
   end;
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
    begin
      PreviousStringValue := NewItem.Data.AsString;
    end;
      if AnsiSameText(NewItem.DisplayName, 'name') then
            PreviousComponentName:=NewItem.Data.AsString
  except
  end;

end;
{$ENDIF}

{$IFDEF WX_BUILD}
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
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.est1Click(Sender: TObject);
var
  I: Integer;
  strParserFunctionName, strParserClassName: string;
  _FullText: string;
  _Type: string;
  _Command: string;
  _Args: string;
  _MethodArgs: string;
  _ScopelessCmd: string;
  _ScopeCmd: string;
  _Kind: TStatementKind;
  _InheritsFromIDs: string;
    // list of inheriting IDs, in comma-separated string form
  _InheritsFromClasses: string;
    // list of inheriting class names, in comma-separated string form
  _Scope: TStatementScope;
  _ClassScope: TStatementClassScope;
  _IsDeclaration: boolean;
  _DeclImplLine: integer;
  _Line: integer;
  _DeclImplFileName: string;
  _FileName: string;
  _Visible: boolean;
  _NoCompletion: boolean;
  _Valid: boolean;
  _Temporary: boolean;
  _Loaded: boolean;
  _InProject: Boolean;
  e:TEditor;
  strLst:TStringList;
begin

  e:=Self.GetEditorFromFileName('C:\Test.file');
  if e=nil then
    Exit;

    strLst:=TStringList.Create;
  for I := 0 to CppParser1.Statements.Count - 1 do // Iterate
  begin
    strLst.Add('');
    strLst.Add('');
    strLst.Add('---------------------------------------------------------------- ');
    strLst.Add('StateMent # '+IntToStr(I));
    strLst.Add(' ');

    strParserClassName := PStatement(CppParser1.Statements[i])._ScopeCmd;
    strLst.Add('_ScopeCmd : ' + strParserClassName);

//    intColon := Pos('::', strParserClassName);
//    if intColon <> 0 then
//    begin
//      strParserClassName := Copy(strParserClassName, 0, intColon - 1);
//    end
//    else
//      Continue;

    strParserFunctionName := PStatement(CppParser1.Statements[i])._FullText;
        strLst.Add('strParserFunctionName : ' +strParserFunctionName );

    _ScopelessCmd := PStatement(CppParser1.Statements[i])._ScopelessCmd;
        strLst.Add('_ScopelessCmd : ' +_ScopelessCmd);

    _FullText := PStatement(CppParser1.Statements[i])._FullText;
        strLst.Add('_FullText : ' +_FullText);

    _Type := PStatement(CppParser1.Statements[i])._Type;
        strLst.Add('_Type : ' + _Type);

    _Command := PStatement(CppParser1.Statements[i])._Command;
        strLst.Add('_Command : ' +_Command);

    _Args := PStatement(CppParser1.Statements[i])._Args;
        strLst.Add('_Args : ' +_Args);

    _MethodArgs := PStatement(CppParser1.Statements[i])._MethodArgs;
        strLst.Add('_MethodArgs : ' +_MethodArgs);

    _ScopeCmd := PStatement(CppParser1.Statements[i])._ScopeCmd;
        strLst.Add('_ScopeCmd : ' +_ScopeCmd);

    _Kind := PStatement(CppParser1.Statements[i])._Kind;
        strLst.Add('_Kind : ' +CppParser1.StatementKindStr(_Kind));

    _InheritsFromIDs := PStatement(CppParser1.Statements[i])._InheritsFromIDs;
        strLst.Add('_InheritsFromIDs : ' +_InheritsFromIDs);

    _InheritsFromClasses := PStatement(CppParser1.Statements[i])._InheritsFromClasses;
        strLst.Add('_InheritsFromClasses : ' +_InheritsFromClasses);

    _Scope := PStatement(CppParser1.Statements[i])._Scope;
        strLst.Add('_Scope : ' +CppParser1.StatementScopeStr(_Scope));

    _ClassScope := PStatement(CppParser1.Statements[i])._ClassScope;
        strLst.Add('_ClassScope : ' +CppParser1.StatementClassScopeStr(_ClassScope));

    _IsDeclaration := PStatement(CppParser1.Statements[i])._IsDeclaration;
        strLst.Add('_IsDeclaration : ' +BoolToStr(_IsDeclaration));

    _DeclImplLine := PStatement(CppParser1.Statements[i])._DeclImplLine;
        strLst.Add('_DeclImplLine : ' +IntToStr(_DeclImplLine));

    _Line := PStatement(CppParser1.Statements[i])._Line;
        strLst.Add('_Line : ' +IntToStr(_Line));

    _DeclImplFileName := PStatement(CppParser1.Statements[i])._DeclImplFileName;
        strLst.Add('_DeclImplFileName : ' +_DeclImplFileName);

    _FileName := PStatement(CppParser1.Statements[i])._FileName;
        strLst.Add('_FileName : ' +_FileName);

    _Visible := PStatement(CppParser1.Statements[i])._Visible;
        strLst.Add('_Visible : ' +BoolToStr(_Visible));

    _NoCompletion := PStatement(CppParser1.Statements[i])._NoCompletion;
        strLst.Add('_NoCompletion : ' +BoolToStr(_NoCompletion));

    _Valid := PStatement(CppParser1.Statements[i])._Valid;
        strLst.Add('_Valid : ' +BoolToStr(_Valid));

    _Temporary := PStatement(CppParser1.Statements[i])._Temporary;
        strLst.Add('_Temporary : ' +BoolToStr(_Temporary));

    _Loaded := PStatement(CppParser1.Statements[i])._Loaded;
        strLst.Add('_Loaded : ' +BoolToStr(_Loaded));

    _InProject := PStatement(CppParser1.Statements[i])._InProject;
        strLst.Add('_InProject : ' +BoolToStr(_InProject));
  end; // for
  e.Text.Lines.Assign(strLst);
  e.InsertString('',false);
  strLst.Destroy;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.JvInspPropertiesItemValueChanged(Sender: TObject;
  Item: TJvCustomInspectorItem);
begin
//sendDebug('Yes it is changed!!!');
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.DesignerOptionsClick(Sender: TObject);
var
    DesignerForm: TDesignerForm;
begin
    DesignerForm:=TDesignerForm.Create(self);
    try
        DesignerForm.showModal;
        DesignerForm.destroy;
    except
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
    CreationOrderForm:TCreationOrderForm;
    e,hppEditor,cppEditor:TEditor;
begin
    if ELDesigner1.SelectedControls.Count = 0 then
        exit;
    if TWinControl(ELDesigner1.SelectedControls.Items[0]).ControlCount = 0 then
    begin
        MessageDlg('You cannot do anything with this control. '+#13+'Select its parent Dialog or Sizer.', mtError, [mbOK], 0);
        exit;
    end;

    if PageControl.ActivePageIndex = -1 then
        exit;

    if  MessageDlg('All Designer related Files will be saved before proceeding.'+#13+#10+''+#13+#10+'Do you want to continue ?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
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

    CreationOrderForm:=TCreationOrderForm.Create(self);
    CreationOrderForm.SetMainControl(TWinControl(ELDesigner1.SelectedControls.Items[0]));
    CreationOrderForm.PopulateControlList;
    CreationOrderForm.showModal;
    CreationOrderForm.destroy;

    ELDesigner1.Active:=false;
    ELDesigner1.DesignControl:=nil;

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
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TMainForm.ELDesigner1Notification(Sender: TObject;
  AnObject: TPersistent; Operation: TOperation);
var
    strOp:String;
begin
    if Operation = opInsert then
        strOp:='opInsert';
    if Operation = opRemove then
        strOp:='opRemove';

    //sendDebug('In ELDesigner Notification - ' + strOp);
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
    CreateNewDialogOrFrameCode(dtWxFrame);
end;

procedure TMainForm.actNewwxDialogExecute(Sender: TObject);
begin
    CreateNewDialogOrFrameCode(dtWxDialog);
end;

procedure TMainForm.OnFileChangeNotify(Sender: TObject; ChangeType: TChangeType);
begin
  if FileWatching = false then
    exit;
    if strChangedFileList.IndexOf(TFileWatch(Sender).FileName)  = -1 then
        strChangedFileList.Add(TFileWatch(Sender).FileName);
end;

procedure TMainForm.ApplicationEvents1Activate(Sender: TObject);
  {$IFDEF WX_BUILD}
var
   I:Integer;
  {$ENDIF}
begin
  {$IFDEF WX_BUILD}
  FileWatching := false;
  devFileMonitor1.Deactivate;
  for I := 0 to FWatchList.Count - 1 do    // Iterate
  begin
    try
        if assigned(FWatchList[i]) then
            TFileWatch(FWatchList[i]).Terminate;
    except
    end;
  end;    // for

  FWatchList.Clear;
  for I := 0 to strChangedFileList.Count - 1 do    // Iterate
  begin
    if FileExists(strChangedFileList[i]) then
        devFileMonitor1NotifyChange(self,mctChanged,strChangedFileList[i])
    else
        devFileMonitor1NotifyChange(self,mctDeleted,strChangedFileList[i]);
  end;
  strChangedFileList.Clear;

  {$ENDIF}
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
    else if (Key = VK_ESCAPE) and (Shift = []) then
  begin
    if PageControl.Visible And PageControl.Enabled And (PageControl.ActivePage<>nil) then
      GetEditor(-1).Activate;
  end
  else if (Key = VK_ESCAPE) and (Shift = [ssShift]) then
  begin
    actProjectManager.Checked := False;
    actProjectManagerExecute(nil);
    if PageControl.Visible And PageControl.Enabled And (PageControl.ActivePage<>nil) then
      GetEditor(-1).Activate;
  end
  else if (Key = VK_RETURN) and Assigned(ProjectView.Selected) then
  begin
    if ProjectView.Selected.Data <> Pointer(-1) then { if not a directory }
    begin
      OpenUnit;
      if Shift = [ssShift] then
      begin
        {
          crap hack, SHIFT+ENTER=open file and close projman
          I *really* don't think it's the acceptable interface idea.
          Can't find a better one though.
        }
        actProjectManager.Checked := False;
        actProjectManagerExecute(nil);
      end;
    end;
  end;
end;

initialization
{$IFDEF WX_BUILD}
//    TJvInspectorAlignItem.RegisterAsDefaultItem;
//    TJvInspectorAnchorsItem.RegisterAsDefaultItem;
//    TJvInspectorColorItem.RegisterAsDefaultItem;
//    TJvInspectorTImageIndexItem.RegisterAsDefaultItem;
//    TJvInspectorListItemsItem.RegisterAsDefaultItem;
//    TJvInspectorTreeNodesItem.RegisterAsDefaultItem;
    TWxJvInspectorTStringsItem.RegisterAsDefaultItem;
    TJvInspectorMyFontItem.RegisterAsDefaultItem;
    TJvInspectorMenuItem.RegisterAsDefaultItem;
    TJvInspectorBitmapItem.RegisterAsDefaultItem;
    TJvInspectorListColumnsItem.RegisterAsDefaultItem;
    TJvInspectorColorEditItem.RegisterAsDefaultItem;
    TJvInspectorFileNameEditItem.RegisterAsDefaultItem;
    TJvInspectorStatusBarItem.RegisterAsDefaultItem;
{$ENDIF}

finalization

end.

