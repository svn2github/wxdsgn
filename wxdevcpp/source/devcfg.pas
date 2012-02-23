{
    $Id: devcfg.pas 932 2007-04-20 10:27:52Z lowjoel $

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

(*
 unit: devCFG.pas
 programmer: Michael Berg
 date: 9.1.1 - 12.10.1
 description: Singletion pattern object for control of dev-c options.
                To initialize call initializeOptions function.
                To save call SaveOptions function.

 ToUse: just call the option you want:
           i.e. devDirs.ExecDir:= NewValue;
           or   DevCppDir:=  devDirs.ExecDir;

        do not create instance explicitly:
           i.e. opt:= TdevData.Create;
*)

Unit devcfg;
Interface

Uses
{$IFDEF WIN32}
    Dialogs, Windows, Classes, Graphics, SynEdit, CFGData, CFGTypes,
    IniFiles, prjtypes; //, SynEditCodeFolding;  //, DbugIntf; EAB removed Gexperts debug stuff.
{$ENDIF}
{$IFDEF LINUX}
  QDialogs, Classes, QGraphics, QSynEdit, CFGData, CFGTypes, IniFiles, prjtypes;
{$ENDIF}

Const
    BoolValYesNo: Array[Boolean] Of String = ('No', 'Yes');
    BoolVal10: Array[0..27] Of String =
        ('0', '1', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
        // Had to use letters for multiple choices
        'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r',
        's', 't', 'u', 'v', 'w', 'x', 'y', 'z');

    ID_COMPILER_MINGW = 0;
    ID_COMPILER_VC2005 = 1;
    ID_COMPILER_VC2003 = 2;
    ID_COMPILER_VC6 = 3;
    ID_COMPILER_DMARS = 4;
    ID_COMPILER_VC2008 = 5;
    ID_COMPILER_BORLAND = 6;
    ID_COMPILER_WATCOM = 7;
    ID_COMPILER_LINUX = 8;
    ID_COMPILER_VC2010 = 9;
    ID_COMPILER_VC = [ID_COMPILER_VC6, ID_COMPILER_VC2003,
        ID_COMPILER_VC2005, ID_COMPILER_VC2008, ID_COMPILER_VC2010];
    ID_COMPILER_VC_CURRENT = [ID_COMPILER_VC2005, ID_COMPILER_VC2008,
        ID_COMPILER_VC2010];

Type
    // the comments are an example of the record
    PCompilerOption = ^TCompilerOption;
    TCompilerOption = Packed Record
        optName: String; // "Generate debugging info"
        optIsGroup: Boolean; // False
        optIsC: Boolean; // True  (C option?)
        optIsCpp: Boolean; // True (C++ option?) - can be both C and C++ option...
        optIsLinker: Boolean; // Is it a linker param
        optValue: Integer; // True
        optSetting: String; // "-g3"
        optSection: String; // "Linker options"
        optExcludeFromTypes: TProjTypeSet;
        // [dptGUI] (don't show option if project is of type dptGUI)
        optChoices: TStringList;
        // replaces "Yes/No" standard choices (max 26 different choices)
    End;

    // compiler-set configuration
    TdevCompilerSet = Class(TCFGOptions)
    Private
        fSets: TStrings;
        fgccName: String;
        fgppName: String;
        fgdbName: String;
        fmakeName: String;
        fwindresName: String;
        fdllwrapName: String;
        fgprofName: String;

        fBinDir: String;
        fCDir: String;
        fCppDir: String;
        fLibDir: String;
        fRCDir: String;
        fOptions: String;
        fCompilerType: Integer;

        fLinkerPaths: String;
        fDllFormat: String;
        fLibFormat: String;
        fPreprocDefines: String;
        fCmdOptions: String;
        fLinkOptions: String;
        fMakeOptions: String;

        fCheckSyntaxFormat: String;
        fOutputFormat: String;
        fResourceIncludeFormat: String;
        fResourceFormat: String;
        fLinkerFormat: String;
        fIncludeFormat: String;
        fPchCreateFormat: String;
        fPchUseFormat: String;
        fPchFileFormat: String;
        fSingleCompile: String;

        //Private ctor and dtor, since we are singletons
        Constructor Create;

        Procedure WriteSets;
        Procedure UpdateSets;

    Public
{$IFDEF PLUGIN_BUILD}
        optComKey: String;
{$ENDIF PLUGIN_BUILD}
  	     Destructor Destroy; Override;
        Procedure SettoDefaults; Override;
        Procedure SaveSettings; Override;
        Procedure LoadSettings; Override;
        Procedure SaveSet(Index: Integer);
        Procedure SaveSetDirs(Index: Integer);
        Procedure SaveSetProgs(Index: Integer);
        Procedure LoadSet(Index: Integer);
        Procedure LoadSetDirs(Index: Integer);
        Procedure LoadSetProgs(Index: Integer);
        Procedure LoadDefaultCompilerDefaults;
        Procedure AssignToCompiler;
        Function SetName(Index: Integer): String;

        Property Name;
        Property Sets: TStrings Read fSets Write fSets;

    Published
        Property CompilerType: Integer Read fCompilerType Write fCompilerType;
        Property CheckSyntaxFormat: String
            Read fCheckSyntaxFormat Write fCheckSyntaxFormat;
        Property OutputFormat: String Read fOutputFormat Write fOutputFormat;
        Property PchCreateFormat: String Read fPchCreateFormat
            Write fPchCreateFormat;
        Property PchUseFormat: String Read fPchUseFormat Write fPchUseFormat;
        Property PchFileFormat: String Read fPchFileFormat Write fPchFileFormat;
        Property ResourceIncludeFormat: String
            Read fResourceIncludeFormat Write fResourceIncludeFormat;
        Property ResourceFormat: String Read fResourceFormat Write fResourceFormat;
        Property LinkerFormat: String Read fLinkerFormat Write fLinkerFormat;
        Property LinkerPaths: String Read fLinkerPaths Write fLinkerPaths;
        Property IncludeFormat: String Read fIncludeFormat Write fIncludeFormat;
        Property DllFormat: String Read fDllFormat Write fDllFormat;
        Property LibFormat: String Read fLibFormat Write fLibFormat;
        Property SingleCompile: String Read fSingleCompile Write fSingleCompile;
        Property PreprocDefines: String Read fPreprocDefines Write fPreprocDefines;

        Property gccName: String Read fgccName Write fgccName;
        Property gppName: String Read fgppName Write fgppName;
        Property gdbName: String Read fgdbName Write fgdbName;
        Property makeName: String Read fmakeName Write fmakeName;
        Property windresName: String Read fwindresName Write fwindresName;
        Property dllwrapName: String Read fdllwrapName Write fdllwrapName;
        Property gprofName: String Read fgprofName Write fgprofName;

        Property BinDir: String Read fBinDir Write fBinDir;
        Property CDir: String Read fCDir Write fCDir;
        Property CppDir: String Read fCppDir Write fCppDir;
        Property LibDir: String Read fLibDir Write fLibDir;
        Property RCDir: String Read fRCDir Write fRCDir;
        Property OptionsStr: String Read fOptions Write fOptions; //0, 1, a-z list
        Property CmdOpts: String Read fCmdOptions Write fCmdOptions;
        //Manual commands
        Property LinkOpts: String Read fLinkOptions Write fLinkOptions;
        //Manual commands
        Property MakeOpts: String Read fMakeOptions Write fMakeOptions;
    End;

    // compiler options
    TdevCompiler = Class(TCFGOptions)
    Private
        fUseParams: Boolean;   // Use fparams when running prog
        fRunParams: String;    // params to send on execution

        // program filenames
        fgccName: String;
        fgppName: String;
        fgdbName: String;
        fmakeName: String;
        fwindresName: String;
        fgprofName: String;
        fdllwrapName: String;
        fCompilerSet: Integer;
        fCompilerType: Integer;
        fLinkerFormat: String;
        fLinkerPaths: String;
        fIncludeFormat: String;
        fSingleCompile: String;
        fPreprocDefines: String;

        fCheckSyntaxFormat: String;
        fOutputFormat: String;
        fResourceIncludeFormat: String;
        fResourceFormat: String;
        fDllFormat: String;
        fLibFormat: String;
        fPchCreateFormat: String;
        fPchUseFormat: String;
        fPchFileFormat: String;

        //Compiler options
        fOptions: TList;

        //Makefile
        fFastDep: Boolean;

        fcmdOpts: String;  // command-line adds for compiler
        flinkopts: String; // command-line adds for linker
        fMakeOpts: String;
	       //fwxOpts: TdevWxOptions;    
        fSaveLog: Boolean; // Save Compiler Output
        fDelay: Integer;   // delay in milliseconds -- for compiling

        //Private constructors for singletons
        Constructor Create;

        Procedure SetCompilerSet(Const Value: Integer);
        Function GetOptions(Index: Integer): TCompilerOption;
        Procedure SetOptions(Index: Integer; Const Value: TCompilerOption);

        Function GetOptionStr: String;
        Procedure SetOptionStr(Const Value: String);

    Published
        Procedure AddDefaultOptions;

    Public
        Destructor Destroy; Override;
        Function OptionsCount: Integer;
        Function FindOption(Setting: String; Var opt: TCompilerOption;
            Var Index: Integer): Boolean; // returns the option with setting=<Setting>
        Function ConvertCharToValue(c: Char): Integer;
        Procedure AddOption(_Name: String;
            _IsGroup, _IsC, _IsCpp, IsLinker: Boolean; _Value: Integer;
            _Setting, _Section: String; ExcludeFromTypes: TProjTypeSet;
            Choices: TStringList);
        Procedure SettoDefaults; Override;
        Procedure SaveSettings; Override;
        Procedure LoadSettings; Override;
        Procedure ClearOptions;
        Procedure DeleteOption(Index: Integer);

        Property Name;
        Property Options[Index: Integer]: TCompilerOption
            Read GetOptions Write SetOptions;
        Property OptionStr: String Read GetOptionStr Write SetOptionStr;

    Published
        Property CmdOpts: String Read fcmdOpts Write fcmdOpts;
        Property LinkOpts: String Read flinkOpts Write flinkOpts;
        Property MakeOpts: String Read fMakeOpts Write fMakeOpts;
	       //property WxOpts: TdevWxOptions read fWxOpts write fWxOpts;
        Property FastDep: Boolean Read fFastDep Write fFastDep;

        Property CompilerType: Integer Read fCompilerType Write fCompilerType;
        Property CheckSyntaxFormat: String
            Read fCheckSyntaxFormat Write fCheckSyntaxFormat;
        Property OutputFormat: String Read fOutputFormat Write fOutputFormat;
        Property PchCreateFormat: String Read fPchCreateFormat
            Write fPchCreateFormat;
        Property PchUseFormat: String Read fPchUseFormat Write fPchUseFormat;
        Property PchFileFormat: String Read fPchFileFormat Write fPchFileFormat;
        Property ResourceIncludeFormat: String
            Read fResourceIncludeFormat Write fResourceIncludeFormat;
        Property ResourceFormat: String Read fResourceFormat Write fResourceFormat;
        Property LinkerFormat: String Read fLinkerFormat Write fLinkerFormat;
        Property LinkerPaths: String Read fLinkerPaths Write fLinkerPaths;
        Property IncludeFormat: String Read fIncludeFormat Write fIncludeFormat;
        Property DllFormat: String Read fDllFormat Write fDllFormat;
        Property LibFormat: String Read fLibFormat Write fLibFormat;
        Property SingleCompile: String Read fSingleCompile Write fSingleCompile;
        Property PreprocDefines: String Read fPreprocDefines Write fPreprocDefines;

        Property RunParams: String Read fRunParams Write fRunParams;
        Property UseExecParams: Boolean Read fUseParams Write fUseParams;
        Property SaveLog: Boolean Read fSaveLog Write fSaveLog;
        Property Delay: Integer Read fDelay Write fDelay;

        Property gccName: String Read fgccName Write fgccName;
        Property gppName: String Read fgppName Write fgppName;
        Property gdbName: String Read fgdbName Write fgdbName;
        Property makeName: String Read fmakeName Write fmakeName;
        Property windresName: String Read fwindresName Write fwindresName;
        Property dllwrapName: String Read fdllwrapName Write fdllwrapName;
        Property gprofName: String Read fgprofName Write fgprofName;
        Property CompilerSet: Integer Read fCompilerSet Write SetCompilerSet;
    End;

    // code-completion window size and other config
    TdevCodeCompletion = Class(TCFGOptions)
    Private
        fWidth: Integer;
        fHeight: Integer;
        fDelay: Integer;
        fBackColor: Integer;
        fEnabled: Boolean;
        fUseCacheFiles: Boolean;
        fCacheFiles: TStrings;
        Procedure SetDelay(Value: Integer);
    Public
        Constructor Create;
        Destructor Destroy; Override;
        Procedure SettoDefaults; Override;
        Procedure SaveSettings; Override;
        Procedure LoadSettings; Override;
        Property Name;
    Published
        Property Width: Integer Read fWidth Write fWidth;
        Property Height: Integer Read fHeight Write fHeight;
        Property Delay: Integer Read fDelay Write SetDelay;
        Property BackColor: Integer Read fBackColor Write fBackColor;
        Property Enabled: Boolean Read fEnabled Write fEnabled;
        Property UseCacheFiles: Boolean Read fUseCacheFiles Write fUseCacheFiles;
        Property CacheFiles: TStrings Read fCacheFiles Write fCacheFiles;
    End;

    // class-browsing view style
    TdevClassBrowsing = Class(TCFGOptions)
    Private
        fCBViewStyle: Integer;
        fEnabled: Boolean;
        fParseLocalHeaders: Boolean;
        fParseGlobalHeaders: Boolean;
        fShowFilter: Integer; // 0 - show all, 1 - show project, 2 - show current
        fUseColors: Boolean;
        fShowInheritedMembers: Boolean;
    Public
        Constructor Create;
        Procedure SettoDefaults; Override;
        Procedure SaveSettings; Override;
        Procedure LoadSettings; Override;
        Property Name;
    Published
        Property Enabled: Boolean Read fEnabled Write fEnabled;
        Property ViewStyle: Integer Read fCBViewStyle Write fCBViewStyle;
        Property ParseLocalHeaders: Boolean
            Read fParseLocalHeaders Write fParseLocalHeaders;
        Property ParseGlobalHeaders: Boolean
            Read fParseGlobalHeaders Write fParseGlobalHeaders;
        Property ShowFilter: Integer Read fShowFilter Write fShowFilter;
        Property UseColors: Boolean Read fUseColors Write fUseColors;
        Property ShowInheritedMembers: Boolean
            Read fShowInheritedMembers Write fShowInheritedMembers;
    End;

    // CVS handling module
    TdevCVSHandler = Class(TCFGOptions)
    Private
        fRepositories: TStrings;
        fExecutable: String;
        fCompression: Byte;
        fUseSSH: Boolean;
    Public
        Constructor Create;
        Destructor Destroy; Override;
        Procedure SettoDefaults; Override;
        Procedure SaveSettings; Override;
        Procedure LoadSettings; Override;
        Property Name;
    Published
        Property Repositories: TStrings Read fRepositories Write fRepositories;
        Property Executable: String Read fExecutable Write fExecutable;
        Property Compression: Byte Read fCompression Write fCompression;
        Property UseSSH: Boolean Read fUseSSH Write fUseSSH;
    End;

    TdevExternalPrograms = Class(TCFGOptions)
    Private
        fDummy: Boolean;
        fPrograms: TStrings;
        Function GetProgramName(Index: Integer): String;
    Public
        Constructor Create;
        Destructor Destroy; Override;
        Procedure SaveSettings; Override;
        Procedure LoadSettings; Override;
        Procedure SetToDefaults; Override;
        Property Name;
        Property ProgramName[Index: Integer]: String Read GetProgramName;
        Function AssignedProgram(ext: String): Integer;
        Function AddProgram(ext, prog: String): Integer;
    Published
        Property Dummy: Boolean Read fDummy Write fDummy;
        Property Programs: TStrings Read fPrograms Write fPrograms;
    End;
 {$IFDEF PLUGIN_BUILD}
    TdevPluginToolbarsX = Class(TCFGOptions)
    Private
        fDummy: Boolean;
        fPluginToolbarsX: TStrings;
        Function GetToolbarsXName(Index: Integer): String;
    Public
        Constructor Create;
        Destructor Destroy; Override;
        Procedure SaveSettings; Override;
        Procedure LoadSettings; Override;
        Procedure SetToDefaults; Override;
        Property Name;
        Property ToolbarsXName[Index: Integer]: String Read GetToolbarsXName;
        Function AssignedToolbarsX(plugin_name: String): Integer;
        Function AddToolbarsX(plugin_name: String; x: Integer): Integer;
    Published
        Property Dummy: Boolean Read fDummy Write fDummy;
        Property PluginToolbarsX: TStrings Read fPluginToolbarsX
            Write fPluginToolbarsX;
    End;

    TdevPluginToolbarsY = Class(TCFGOptions)
    Private
        fDummy: Boolean;
        fPluginToolbarsY: TStrings;
        Function GetToolbarsYName(Index: Integer): String;
    Public
        Constructor Create;
        Destructor Destroy; Override;
        Procedure SaveSettings; Override;
        Procedure LoadSettings; Override;
        Procedure SetToDefaults; Override;
        Property Name;
        Property ToolbarsYName[Index: Integer]: String Read GetToolbarsYName;
        Function AssignedToolbarsY(plugin_name: String): Integer;
        Function AddToolbarsY(plugin_name: String; y: Integer): Integer;
    Published
        Property Dummy: Boolean Read fDummy Write fDummy;
        Property PluginToolbarsY: TStrings Read fPluginToolbarsY
            Write fPluginToolbarsY;
    End;
{$ENDIF PLUGIN_BUILD}

    // global directories
    TdevDirs = Class(TCFGOptions)
    Private
        fCompilerType: Integer;
        fThemes: String; // Themes Directory
        fIcons: String; // Icon Library
        fHelp: String; // Help
        fLang: String; // Language
        fTemp: String; // Templates
        fDefault: String; // user defined default
        fExec: String; // dev-c start
        fConfig: String; // config files directory
        fBinDir: String; // compiler location
        fCDir: String; // c includes
        fCppDir: String; // c++ includes
        fLibDir: String; // Libraries
        fRCDir: String; // Resource includes
        fOldPath: String; // Enviroment Path at program start
        Procedure FixPaths;
    Public
        Constructor Create;
        Procedure SettoDefaults; Override;
        Procedure SaveSettings; Override;
        Procedure LoadSettings; Override;
        Function CallValidatePaths(dirList: String): String;
        Property Name;
        Property OriginalPath: String Read fOldPath Write fOldPath;
    Published
        Property Exec: String Read fExec Write fExec;
        Property Config: String Read fConfig Write fConfig;
        Property Bins: String Read fBinDir Write fBinDir;
        Property Default: String Read fDefault Write fDefault;
        Property C: String Read fCDir Write fCDir;
        Property Cpp: String Read fCppDir Write fCppDir;
        Property Help: String Read fHelp Write fHelp;
        Property Icons: String Read fIcons Write fIcons;
        Property Lang: String Read fLang Write fLang;
        Property Lib: String Read fLibDir Write fLibDir;
        Property RC: String Read fRCDir Write fRCDir;
        Property Templates: String Read fTemp Write fTemp;
        Property Themes: String Read fThemes Write fThemes;
        Property CompilerType: Integer Read fCompilerType Write fCompilerType;
    End;

    // editor options -- syntax, synedit options, etc...
    TdevEditor = Class(TCFGOptions)
    Private
        fUseSyn: Boolean; // use syntax highlighting
        fSynExt: String; // semi-colon seperated list of highlight ext's
        fFont: TFont; // Editor Font
        fGutterFont: TFont; // Gutter font
        fInsertCaret: Integer; // Editor insert caret
        fOverwriteCaret: Integer; // Editor overwrite caret
        fTabSize: Integer; // Editor Tab Size
        fGutterSize: Integer; // Width of Left margin gutter
        fMarginSize: Integer; // Width of right margin

        fCustomGutter: Boolean; // Use Selected Gutter font
        fGutterAuto: Boolean; // Gutter Auto Sizes
        fShowGutter: Boolean; // Show Left gutter in editor
        fGutterGradient: Boolean; // Draw the gutter with a gradient
        fLineNumbers: Boolean; // Show Line Numbers
        fLeadZero: Boolean; // Show leading zero's in line nums
        fFirstisZero: Boolean; // First line is zero

        fMarginVis: Boolean; // Toggle right margin line

        fShowScrollHint: Boolean; // Show line number when scrolling
        fShowScrollbars: Boolean; // Show Scroll bars
        fHalfPage: Boolean; // PgUp/PgDn move half a page

        fPastEOF: Boolean; // Cursor moves past end of file
        fPastEOL: Boolean; // Cursor moves past end of lines
        fTrailBlanks: Boolean; // Blanks past EOL are not trimmed
        fdblLine: Boolean; // Double Click selects a line
        fFindText: Boolean; // Text at cursor defaults in find dialog
        fEHomeKey: Boolean; // Home key like visual studio
        fGroupUndo: Boolean; // treat same undo's as single undo
        fInsDropFiles: Boolean; // Insert files when drag/dropped else open
        fInsertMode: Boolean; // Editor defaults to insert mode
        fAutoIndent: Boolean; // Auto-indent code lines
        fSmartTabs: Boolean; // Tab to next no whitespace char
        fSmartUnindent: Boolean; // on backspace move to prev non-whitespace char
        fSpecialChar: Boolean; // special line characters visible
        fAppendNewline: Boolean;    // append newline character to the end of line
        fTabtoSpaces: Boolean; // convert tabs to spaces
        fAutoCloseBrace: Boolean; // insert closing braces
        fMarginColor: TColor; // Color of right margin
        fActiveSyn: String; // Active syntax highlighting set
        fSyntax: TStrings; // Holds attributes settings
        fDefaultIntoPrj: Boolean;
        // Insert Default Source Code into "empty" project
        fParserHints: Boolean; // Show parser's hint for the word under the cursor
        fMatch: Boolean; // Highlight matching parenthesis
        fHighCurrLine: Boolean;     // Highlight current line
        fHighColor: TColor;         // Color of current line when highlighted

        //fCodeFolding : boolean; // Code folding enabled?
    Public
        Constructor Create;
        Destructor Destroy; Override;
        Procedure SettoDefaults; Override;
        Procedure SaveSettings; Override;
        Procedure LoadSettings; Override;
        Procedure AssignEditor(Editor: TSynEdit);
        Property Name;
    Published
        //Editor props
        Property AutoIndent: Boolean Read fAutoIndent Write fAutoIndent;
        Property InsertMode: Boolean Read fInsertMode Write fInsertMode;
        Property TabToSpaces: Boolean Read fTabToSpaces Write fTabtoSpaces;
        Property SmartTabs: Boolean Read fSmartTabs Write fSmartTabs;
        Property SmartUnindent: Boolean Read fSmartUnindent Write fSmartUnindent;
        Property TrailBlank: Boolean Read fTrailBlanks Write fTrailBlanks;
        Property GroupUndo: Boolean Read fGroupUndo Write fGroupUndo;
        Property EHomeKey: Boolean Read fEHomeKey Write fEHomeKey;
        Property PastEOF: Boolean Read fPastEOF Write fPastEOF;
        Property PastEOL: Boolean Read fPastEOL Write fPastEOL;
        Property DblClkLine: Boolean Read fdblLine Write fdblLine;
        Property FindText: Boolean Read fFindText Write fFindText;
        Property Scrollbars: Boolean Read fShowScrollbars Write fShowScrollbars;
        Property HalfPageScroll: Boolean Read fHalfPage Write fHalfPage;
        Property ScrollHint: Boolean Read fShowScrollHint Write fShowScrollHint;
        Property SpecialChars: Boolean Read fSpecialChar Write fSpecialChar;
        Property AppendNewline: Boolean Read fAppendNewline Write fAppendNewline;
        Property AutoCloseBrace: Boolean
            Read fAutoCloseBrace Write fAutoCloseBrace;

        Property TabSize: Integer Read fTabSize Write fTabSize;
        Property MarginVis: Boolean Read fMarginVis Write fMarginVis;
        Property MarginSize: Integer Read fMarginSize Write fMarginSize;
        Property MarginColor: TColor Read fMarginColor Write fMarginColor;
        Property InsertCaret: Integer Read fInsertCaret Write fInsertCaret;
        Property OverwriteCaret: Integer
            Read fOverwriteCaret Write fOverwriteCaret;
        Property InsDropFiles: Boolean Read fInsDropFiles Write fInsDropFiles;
        Property Font: TFont Read fFont Write fFont;

        // Gutter options
        Property GutterVis: Boolean Read fShowGutter Write fShowGutter;
        Property GutterAuto: Boolean Read fGutterAuto Write fGutterAuto;
        Property GutterGradient: Boolean
            Read fGutterGradient Write fGutterGradient;
        Property LineNumbers: Boolean Read fLineNumbers Write fLineNumbers;
        Property LeadZero: Boolean Read fLeadZero Write fLeadZero;
        Property FirstLineZero: Boolean Read fFirstisZero Write fFirstisZero;
        Property Gutterfnt: Boolean Read fCustomGutter Write fCustomGutter;
        Property GutterSize: Integer Read fGutterSize Write fGutterSize;
        Property Gutterfont: TFont Read fGutterfont Write fGutterFont;

        // syntax
        Property UseSyntax: Boolean Read fUseSyn Write fUseSyn;
        Property SyntaxExt: String Read fSynExt Write fSynExt;
        Property ActiveSyntax: String Read fActiveSyn Write fActiveSyn;
        Property Syntax: TStrings Read fSyntax Write fSyntax;

        // other
        Property DefaulttoPrj: Boolean Read fDefaultIntoPrj Write fDefaultIntoPrj;

        Property ParserHints: Boolean Read fParserHints Write fParserHints;
        Property Match: Boolean Read fMatch Write fMatch;
        Property HighCurrLine: Boolean Read fHighCurrLine Write fHighCurrLine;
        Property HighColor: TColor Read fHighColor Write fHighColor;
       // property CodeFolding: boolean read fCodeFolding write fCodeFolding;

    End;

    // master option object -- contains program globals
    TdevData = Class(TConfigData)
    Private
        fVersion: String; // The configuration file's version
        fLang: String; // Language file
        fTheme: String; // Theme file
        fFindCols: String; // Find Column widths (comma sep)
        fCompCols: String; // Compiler Column Widths (comma sep)
        fMsgTabs: Boolean; // Message Control Tabs (Top/Bottom)
        fMinOnRun: Boolean; // Minimize IDE on run
        fOpenStyle: Integer; // Open Dialog Style
        fMRUMax: Integer; // Max number of files in history list
        fBackup: Boolean; // Create backup files
        fAutoOpen: Integer; // Auto Open Project Files Style
        fClassView: Boolean;
        // if true, shows the class view, else shows the file view
        fStatusbar: Boolean; // Statusbar Visible
        fFullScr: Boolean; // IDE is Full screen
        fShowBars: Boolean; // Show toolbars in FullScreen mode
        fShowMenu: Boolean; // Show Main Menu in Full Screen Mode
        fSingleInstance: Boolean; // Allow the IDE to be in single instance
        fDefCpp: Boolean; // Default to C++ project (compile with g++)
        fFirst: Boolean; // first run of dev-c
        fSplash: String; // user selected splash screen
        fWinPlace: TWindowPlacement; // Main forms size, state and position.
        fdblFiles: Boolean; // double click opens files out of project manager
        fLangChange: Boolean; // flag for language change
        fthemeChange: Boolean; // did the theme changed
        fNoSplashScreen: Boolean; // disable splash screen
        fHiliteActiveTab: Boolean; // Hilite the Active Editor Page Tab
        fAutoCompile: Integer; // automatically compile when out-of-date
        fNoToolTip: Boolean; // Don't use Tooltips
        fAutoAddDebugFlag : Integer; //Automatically add debug flag if not present at debug start

        fDebugCommand: String;
        // Custom command to send to debugger (default is "finish")

        // toolbar layout
        fToolbarMain: Boolean;
        fToolbarMainX: Integer;
        fToolbarMainY: Integer;
        fToolbarEdit: Boolean;
        fToolbarEditX: Integer;
        fToolbarEditY: Integer;
        fToolbarCompile: Boolean;
        fToolbarCompileX: Integer;
        fToolbarCompileY: Integer;
        fToolbarDebug: Boolean;
        fToolbarDebugX: Integer;
        fToolbarDebugY: Integer;
        fToolbarProject: Boolean;
        fToolbarProjectX: Integer;
        fToolbarProjectY: Integer;
        fToolbarOptions: Boolean;
        fToolbarOptionsX: Integer;
        fToolbarOptionsY: Integer;
        fToolbarSpecials: Boolean;
        fToolbarSpecialsX: Integer;
        fToolbarSpecialsY: Integer;
        fToolbarSearch: Boolean;
        fToolbarSearchX: Integer;
        fToolbarSearchY: Integer;
        fToolbarClasses: Boolean;
        fToolbarClassesX: Integer;
        fToolbarClassesY: Integer;

        // file associations (see FileAssocs.pas)
        fAssociateCpp: Boolean;
        fAssociateC: Boolean;
        fAssociateHpp: Boolean;
        fAssociateH: Boolean;
        fAssociateDev: Boolean;
        fAssociateRc: Boolean;
        fAssociateTemplate: Boolean;

        // tip of the day
        fShowTipsOnStart: Boolean;
        fLastTip: Integer;
        fXPTheme: Boolean; // Use XP theme
        fNativeDocks: Boolean; // Use native docking windows under XP
        fFileDate: Integer; // Dev-C++ File Date for checking old configurations
        fShowProgress: Boolean; // Show progress window during compile
        fAutoCloseProgress: Boolean;
        // Auto close progress bar window after compile
        // Printer
        fPrintColors: Boolean; // print colors
        fPrintHighlight: Boolean;
        fPrintWordWrap: Boolean;
        fPrintLineNumbers: Boolean;
        fPrintLineNumbersMargins: Boolean;

        // Debug variable browser
        fWatchHint: Boolean; // watch variable under mouse
        fWatchError: Boolean; // report watch errors

    Public
        Constructor Create(aOwner: TComponent); Override;
        Destructor Destroy; Override;
        Procedure SettoDefaults; Override;
        Procedure SaveConfigData; Override;
        Procedure ReadConfigData; Override;

        Class Function DevData: TDevData;
        Property WindowPlacement: TWindowPlacement Read fWinPlace Write fWinPlace;
        Property LangChange: Boolean Read fLangChange Write fLangChange;
        Property ThemeChange: Boolean Read fThemeChange Write fThemeChange;
    Published
        Property Version: String Read fVersion Write fVersion;
        Property Language: String Read fLang Write fLang;
        Property Theme: String Read fTheme Write fTheme;
        Property First: Boolean Read fFirst Write fFirst;
        Property Splash: String Read fSplash Write fSplash;
        Property MRUMax: Integer Read fMRUMax Write fMRUMax;
        Property DblFiles: Boolean Read fDblFiles Write fDblFiles;
        Property NoSplashScreen: Boolean
            Read fNoSplashScreen Write fNoSplashScreen;
        Property HiliteActiveTab: Boolean Read fHiliteActiveTab
            Write fHiliteActiveTab;
        Property AutoCompile: Integer Read fAutoCompile Write fAutoCompile;
        Property NoToolTip: Boolean Read fNoToolTip Write fNoToolTip Default False;
        Property AutoAddDebugFlag: Integer Read fAutoAddDebugFlag Write fAutoAddDebugFlag;

        Property DebugCommand: String Read fDebugCommand Write fDebugCommand;
        //Execution
        Property MinOnRun: Boolean Read fMinOnRun Write fMinOnRun;
        Property OpenStyle: Integer Read fOpenStyle Write fOpenStyle;

        Property BackUps: Boolean Read fBackup Write fBackup;
        Property AutoOpen: Integer Read fAutoOpen Write fAutoOpen;

        //Windows
        Property MsgTabs: Boolean Read fMsgTabs Write fMsgTabs;

        Property ShowBars: Boolean Read fShowbars Write fShowbars;
        Property ShowMenu: Boolean Read fShowMenu Write fShowMenu;

        //Running Status Options
        Property SingleInstance: Boolean
            Read fSingleInstance Write fSingleInstance;
        Property DefCpp: Boolean Read fDefCpp Write fDefCpp;
        Property ClassView: Boolean Read fClassView Write fClassView;
        Property Statusbar: Boolean Read fStatusbar Write fStatusbar;
        Property FullScreen: Boolean Read fFullScr Write fFullScr;
        Property FindCols: String Read fFindCols Write fFindCols;
        Property CompCols: String Read fCompCols Write fCompCols;

        //Toolbars
        Property ToolbarMain: Boolean Read fToolbarMain Write fToolbarMain;
        Property ToolbarMainX: Integer Read fToolbarMainX Write fToolbarMainX;
        Property ToolbarMainY: Integer Read fToolbarMainY Write fToolbarMainY;
        Property ToolbarEdit: Boolean Read fToolbarEdit Write fToolbarEdit;
        Property ToolbarEditX: Integer Read fToolbarEditX Write fToolbarEditX;
        Property ToolbarEditY: Integer Read fToolbarEditY Write fToolbarEditY;
        Property ToolbarCompile: Boolean
            Read fToolbarCompile Write fToolbarCompile;
        Property ToolbarCompileX: Integer Read fToolbarCompileX
            Write fToolbarCompileX;
        Property ToolbarCompileY: Integer Read fToolbarCompileY
            Write fToolbarCompileY;
        Property ToolbarDebug: Boolean Read fToolbarDebug Write fToolbarDebug;
        Property ToolbarDebugX: Integer Read fToolbarDebugX Write fToolbarDebugX;
        Property ToolbarDebugY: Integer Read fToolbarDebugY Write fToolbarDebugY;
        Property ToolbarProject: Boolean
            Read fToolbarProject Write fToolbarProject;
        Property ToolbarProjectX: Integer Read fToolbarProjectX
            Write fToolbarProjectX;
        Property ToolbarProjectY: Integer Read fToolbarProjectY
            Write fToolbarProjectY;
        Property ToolbarOptions: Boolean
            Read fToolbarOptions Write fToolbarOptions;
        Property ToolbarOptionsX: Integer Read fToolbarOptionsX
            Write fToolbarOptionsX;
        Property ToolbarOptionsY: Integer Read fToolbarOptionsY
            Write fToolbarOptionsY;
        Property ToolbarSpecials: Boolean Read fToolbarSpecials
            Write fToolbarSpecials;
        Property ToolbarSpecialsX: Integer
            Read fToolbarSpecialsX Write fToolbarSpecialsX;
        Property ToolbarSpecialsY: Integer
            Read fToolbarSpecialsY Write fToolbarSpecialsY;
        Property ToolbarSearch: Boolean Read fToolbarSearch Write fToolbarSearch;
        Property ToolbarSearchX: Integer
            Read fToolbarSearchX Write fToolbarSearchX;
        Property ToolbarSearchY: Integer
            Read fToolbarSearchY Write fToolbarSearchY;
        Property ToolbarClasses: Boolean
            Read fToolbarClasses Write fToolbarClasses;
        Property ToolbarClassesX: Integer Read fToolbarClassesX
            Write fToolbarClassesX;
        Property ToolbarClassesY: Integer Read fToolbarClassesY
            Write fToolbarClassesY;

        // file associations
        Property AssociateCpp: Boolean Read fAssociateCpp Write fAssociateCpp;
        Property AssociateC: Boolean Read fAssociateC Write fAssociateC;
        Property AssociateHpp: Boolean Read fAssociateHpp Write fAssociateHpp;
        Property AssociateH: Boolean Read fAssociateH Write fAssociateH;
        Property AssociateDev: Boolean Read fAssociateDev Write fAssociateDev;
        Property AssociateRc: Boolean Read fAssociateRc Write fAssociateRc;
        Property AssociateTemplate: Boolean
            Read fAssociateTemplate Write fAssociateTemplate;

        // tip of the day
        Property ShowTipsOnStart: Boolean Read fShowTipsOnStart
            Write fShowTipsOnStart;
        Property LastTip: Integer Read fLastTip Write fLastTip;

        Property XPTheme: Boolean Read fXPTheme Write fXPTheme;
        Property NativeDocks: Boolean Read fNativeDocks Write fNativeDocks;
        Property FileDate: Integer Read fFileDate Write fFileDate;

        // progress window
        Property ShowProgress: Boolean Read fShowProgress Write fShowProgress;
        Property AutoCloseProgress: Boolean
            Read fAutoCloseProgress Write fAutoCloseProgress;

        //  Printer
        Property PrintColors: Boolean Read fPrintColors Write fPrintColors;
        Property PrintHighlight: Boolean
            Read fPrintHighlight Write fPrintHighlight;
        Property PrintWordWrap: Boolean Read fPrintWordWrap Write fPrintWordWrap;
        Property PrintLineNumbers: Boolean
            Read fPrintLineNumbers Write fPrintLineNumbers;
        Property PrintLineNumbersMargins: Boolean
            Read fPrintLineNumbersMargins Write fPrintLineNumbersMargins;

        // Variable debug browser
        Property WatchHint: Boolean Read fWatchHint Write fWatchHint;
        Property WatchError: Boolean Read fWatchError Write fWatchError;
    End;

Function DevData: TdevData;

Procedure InitializeOptions;
Procedure InitializeOptionsAfterPlugins;
Procedure SaveOptions;
Procedure FinalizeOptions;
Procedure ResettoDefaults;
Procedure CheckForAltConfigFile(filename: String);
Procedure UpdateAltConfigFile;

Var
    devCompiler: TdevCompiler = Nil;
    devCompilerSet: TDevCompilerSet = Nil;
    devDirs: TdevDirs = Nil;
    devEditor: TdevEditor = Nil;
    devCodeCompletion: TdevCodeCompletion = Nil;
    devClassBrowsing: TdevClassBrowsing = Nil;
    devCVSHandler: TdevCVSHandler = Nil;
    devExternalPrograms: TdevExternalPrograms = Nil;
  {$IFDEF PLUGIN_BUILD}
    devPluginToolbarsX: TdevPluginToolbarsX = Nil;
    devPluginToolbarsY: TdevPluginToolbarsY = Nil;
  {$ENDIF PLUGIN_BUILD}

    // Permanent alternate config file (need to be global vars)
    ConfigMode: (CFG_NORMAL, CFG_PARAM, CFG_USER) = CFG_NORMAL;
    StandardConfigFile: String;
    UseAltConfigFile: Boolean;
    AltConfigFile: String;

Implementation

Uses
    main,
{$IFDEF PLUGIN_BUILD}
    iplugin,
{$ENDIF PLUGIN_BUILD}
{$IFDEF WIN32}
    MultiLangSupport, SysUtils, Forms, Controls, version, utils,
    SynEditMiscClasses,
    datamod, FileAssocs, Math;
{$ENDIF}
{$IFDEF LINUX}
  MultiLangSupport, SysUtils, QForms, QControls, version, utils, QSynEditMiscClasses,
  datamod, FileAssocs, Types;
{$ENDIF}

Function ValidatePaths(dirList: String; Var badDirs: String): String;
    //checks if directories in provided ; delimited list exist
    //returns filtered out dirList with only existing paths
    //badDirs returns ; delimited list of non existing dirs
    //also remove duplicates and empty entries
Var
    strs: TStrings;
    i, j: Integer;
    currdir: String;
    newdir: String;

    Function makeFullPath(dir: String): String;
    Begin
        Result := dir;
        //check if full path
{$IFDEF WIN32}
        If Length(dir) > 1 Then
            If dir[2] = ':' Then
                Exit;
        If Length(dir) > 0 Then
            If dir[1] = '\' Then
                Exit;
{$ENDIF}
{$IFDEF LINUX}
    if Length(dir) > 0 then
      if dir[1] = '/' then
        Exit;
{$ENDIF}
        //otherwise just add path
        Result := IncludeTrailingPathDelimiter(ExtractFilePath(
            Application.ExeName))
            + Result;
    End;

Begin
    Result := '';
    badDirs := '';

    //needed to confirm relative paths
    currdir := GetCurrentDir;
    SetCurrentDir(ExtractFilePath(Application.ExeName));

    strs := TStringList.Create;
    Repeat
        If Pos(';', dirList) = 0 Then
            strs.Add(dirList)
        Else
        Begin
            newdir := makeFullPath(Copy(dirList, 1, Pos(';', dirList) - 1));
            strs.Add(newdir);
            Delete(dirList, 1, Pos(';', dirList));
        End;
    Until Pos(';', dirList) = 0;

    //eliminate duplicates
    For i := strs.Count - 1 Downto 0 Do
        For j := strs.Count - 1 Downto i + 1 Do
            If (Trim(strs[j]) = '') Or
                (makeFullPath(Trim(strs[i])) = makeFullPath(Trim(strs[j]))) Then
                strs.Delete(j);

    //check the directories
    For i := strs.Count - 1 Downto 0 Do
    Begin
        If DirectoryExists(strs[i]) Then
            Result := Result + ';' + strs[i]
        Else
            badDirs := badDirs + ';' + strs[i];
    End;

    If Length(Result) > 0 Then
        If Result[1] = ';' Then
            Delete(Result, 1, 1);
    If Length(badDirs) > 0 Then
        If badDirs[1] = ';' Then
            Delete(badDirs, 1, 1);

    FreeAndNil(strs);

    SetCurrentDir(currdir);
End;

Procedure InitializeOptions;
Begin

    If Not assigned(devDirs) Then
        devDirs := TdevDirs.Create;

    If Not assigned(devCompilerSet) Then
        devCompilerSet := TdevCompilerSet.Create;

    If Not assigned(devCompiler) Then
        devCompiler := TdevCompiler.Create;

    If Not assigned(devEditor) Then
        devEditor := TdevEditor.Create;

    If Not assigned(devCodeCompletion) Then
        devCodeCompletion := TdevCodeCompletion.Create;

    If Not assigned(devClassBrowsing) Then
        devClassBrowsing := TdevClassBrowsing.Create;

    If Not assigned(devCVSHandler) Then
        devCVSHandler := TdevCVSHandler.Create;

    If Not assigned(devExternalPrograms) Then
        devExternalPrograms := TdevExternalPrograms.Create;

  {$IFDEF PLUGIN_BUILD}
    If Not assigned(devPluginToolbarsX) Then
        devPluginToolbarsX := TdevPluginToolbarsX.Create;
    If Not assigned(devPluginToolbarsY) Then
        devPluginToolbarsY := TdevPluginToolbarsY.Create;
  {$ENDIF PLUGIN_BUILD}

    // load the preferred compiler set
    If (devCompilerSet.Sets.Count = 0) Then
    Begin      // EAB Comment: Why load all the compiler sets if not all are available?
        // init first-run

        //   ID_COMPILER_MINGW = 0;
        // ID_COMPILER_VC2005 = 1;
        //  ID_COMPILER_VC2003 = 2;
        //  ID_COMPILER_VC6 = 3;
        //  ID_COMPILER_DMARS = 4;
        //  ID_COMPILER_VC2008 = 5;
        //  ID_COMPILER_BORLAND = 6;
        //  ID_COMPILER_WATCOM = 7;
        //  ID_COMPILER_LINUX = 8;

        devCompilerSet.Sets.Add(GCC_DEFCOMPILERSET);
        devCompilerSet.Sets.Add(VC2005_DEFCOMPILERSET);
        devCompilerSet.Sets.Add(VC2003_DEFCOMPILERSET);
        devCompilerSet.Sets.Add(VC6_DEFCOMPILERSET);
        devCompilerSet.Sets.Add(DMARS_DEFCOMPILERSET);
        devCompilerSet.Sets.Add(VC2008_DEFCOMPILERSET);
        devCompilerSet.Sets.Add(BORLAND_DEFCOMPILERSET);
        devCompilerSet.Sets.Add(WATCOM_DEFCOMPILERSET);
        devCompilerSet.Sets.Add(LINUX_DEFCOMPILERSET);
        devCompilerSet.Sets.Add(VC2010_DEFCOMPILERSET);

        //devCompilerSet.WriteSets;

        devCompilerSet.CompilerType := ID_COMPILER_MINGW;
        devdirs.fCompilerType := ID_COMPILER_MINGW;
        // EAB Comment: Aren't these numbers supposed to be ID's? Like "ID_COMPILER_MINGW" instead of "0"?
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_MINGW);
        devCompilerSet.LoadSetDirs(ID_COMPILER_MINGW);
        If MainForm <> Nil Then
            devCompilerSet.SaveSet(ID_COMPILER_MINGW);

        devCompilerSet.CompilerType := ID_COMPILER_VC2005;
        devdirs.fCompilerType := ID_COMPILER_VC2005;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_VC2005);
        devCompilerSet.LoadSetDirs(ID_COMPILER_VC2005);
        If MainForm <> Nil Then
            devCompilerSet.SaveSet(ID_COMPILER_VC2005);

        devCompilerSet.CompilerType := ID_COMPILER_VC2003;
        devdirs.fCompilerType := ID_COMPILER_VC2003;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_VC2003);
        devCompilerSet.LoadSetDirs(ID_COMPILER_VC2003);
        If MainForm <> Nil Then
            devCompilerSet.SaveSet(ID_COMPILER_VC2003);

        devCompilerSet.CompilerType := ID_COMPILER_VC6;
        devdirs.fCompilerType := ID_COMPILER_VC6;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_VC6);
        devCompilerSet.LoadSetDirs(ID_COMPILER_VC6);
        If MainForm <> Nil Then
            devCompilerSet.SaveSet(ID_COMPILER_VC6);

        devCompilerSet.CompilerType := ID_COMPILER_DMARS;
        devdirs.fCompilerType := ID_COMPILER_DMARS;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_DMARS);
        devCompilerSet.LoadSetDirs(ID_COMPILER_DMARS);
        If MainForm <> Nil Then
            devCompilerSet.SaveSet(ID_COMPILER_DMARS);

        devCompilerSet.CompilerType := ID_COMPILER_VC2008;
        // EAB TODO: Check this logic. Maybe, move above and change numbering
        devdirs.fCompilerType := ID_COMPILER_VC2008;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_VC2008);
        devCompilerSet.LoadSetDirs(ID_COMPILER_VC2008);
        If MainForm <> Nil Then
            devCompilerSet.SaveSet(ID_COMPILER_VC2008);

        devCompilerSet.CompilerType := ID_COMPILER_VC2010;
        // EAB TODO: Check this logic. Maybe, move above and change numbering
        devdirs.fCompilerType := ID_COMPILER_VC2010;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_VC2010);
        devCompilerSet.LoadSetDirs(ID_COMPILER_VC2010);
        If MainForm <> Nil Then
            devCompilerSet.SaveSet(ID_COMPILER_VC2010);

        devCompilerSet.CompilerType := ID_COMPILER_BORLAND;
        devdirs.fCompilerType := ID_COMPILER_BORLAND;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_BORLAND);
        devCompilerSet.LoadSetDirs(ID_COMPILER_BORLAND);
        If MainForm <> Nil Then
            devCompilerSet.SaveSet(ID_COMPILER_BORLAND);

        devCompilerSet.CompilerType := ID_COMPILER_WATCOM;
        devdirs.fCompilerType := ID_COMPILER_WATCOM;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_WATCOM);
        devCompilerSet.LoadSetDirs(ID_COMPILER_WATCOM);
        If MainForm <> Nil Then
            devCompilerSet.SaveSet(ID_COMPILER_WATCOM);

        devCompilerSet.CompilerType := ID_COMPILER_LINUX;
        devdirs.fCompilerType := ID_COMPILER_LINUX;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_LINUX);
        devCompilerSet.LoadSetDirs(ID_COMPILER_LINUX);
        If MainForm <> Nil Then
            devCompilerSet.SaveSet(ID_COMPILER_LINUX);

        //Reset the compiler type back to GCC
        devdirs.fCompilerType := ID_COMPILER_MINGW;
        devdirs.SettoDefaults;
        //Guru: todo: Add More Compiler default sets here

    End;

    devCompilerSet.LoadSet(devCompiler.CompilerSet);
    devCompiler.AddDefaultOptions;
    devCompilerSet.AssignToCompiler;
    If MainForm <> Nil Then
    Begin
        devCompilerSet.SaveSet(devCompiler.CompilerSet);
        devCompiler.SaveSettings;
    End;
End;

Procedure InitializeOptionsAfterPlugins;
{$IFDEF PLUGIN_BUILD}
Var
    i, j: Integer;
    pluginSettings: TSettings;
    tempName: String;
{$ENDIF PLUGIN_BUILD}
Begin

    devCompilerSet.WriteSets;

    //   ID_COMPILER_MINGW = 0;
    // ID_COMPILER_VC2005 = 1;
    //  ID_COMPILER_VC2003 = 2;
    //  ID_COMPILER_VC6 = 3;
    //  ID_COMPILER_DMARS = 4;
    //  ID_COMPILER_VC2008 = 5;
    //  ID_COMPILER_BORLAND = 6;
    //  ID_COMPILER_WATCOM = 7;
    //  ID_COMPILER_LINUX = 8;


    devCompilerSet.CompilerType := ID_COMPILER_MINGW;
    devDirs.fCompilerType := ID_COMPILER_MINGW;
    // EAB: Aren't these numbers supposed to be ID's? Like "ID_COMPILER_MINGW" instead of "0"?
    devdirs.SettoDefaults;
    // EAB: this shouldn't be called this way because it messes up with the user AppData Folder settings.
    devCompilerSet.LoadSetProgs(ID_COMPILER_MINGW);
    devCompilerSet.LoadSetDirs(ID_COMPILER_MINGW);

    {$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin

        MainForm.plugins[i].SetCompilerOptionstoDefaults;
        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        For j := 0 To Length(pluginSettings) - 1 Do
        Begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            If tempName <> '' Then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        End;
        MainForm.plugins[i].LoadCompilerOptions;

    End;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_MINGW);


    devCompilerSet.CompilerType := ID_COMPILER_VC2005;
    devdirs.fCompilerType := ID_COMPILER_VC2005;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_VC2005);
    devCompilerSet.LoadSetDirs(ID_COMPILER_VC2005);

    {$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        For j := 0 To Length(pluginSettings) - 1 Do
        Begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            If tempName <> '' Then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        End;
        MainForm.plugins[i].LoadCompilerOptions;

    End;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_VC2005);

    devCompilerSet.CompilerType := ID_COMPILER_VC2003;
    devdirs.fCompilerType := ID_COMPILER_VC2003;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_VC2003);
    devCompilerSet.LoadSetDirs(ID_COMPILER_VC2003);

    {$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        For j := 0 To Length(pluginSettings) - 1 Do
        Begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            If tempName <> '' Then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        End;
        MainForm.plugins[i].LoadCompilerOptions;

    End;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_VC2003);

    devCompilerSet.CompilerType := ID_COMPILER_VC6;
    devdirs.fCompilerType := ID_COMPILER_VC6;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_VC6);
    devCompilerSet.LoadSetDirs(ID_COMPILER_VC6);

    {$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        For j := 0 To Length(pluginSettings) - 1 Do
        Begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            If tempName <> '' Then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        End;
        MainForm.plugins[i].LoadCompilerOptions;

    End;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_VC6);

    devCompilerSet.CompilerType := ID_COMPILER_DMARS;
    devdirs.fCompilerType := ID_COMPILER_DMARS;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_DMARS);
    devCompilerSet.LoadSetDirs(ID_COMPILER_DMARS);

    {$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        For j := 0 To Length(pluginSettings) - 1 Do
        Begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            If tempName <> '' Then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        End;
        MainForm.plugins[i].LoadCompilerOptions;

    End;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_DMARS);

    devCompilerSet.CompilerType := ID_COMPILER_VC2008;
    // EAB TODO: Check this logic. Maybe, move above and change numbering
    devdirs.fCompilerType := ID_COMPILER_VC2008;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_VC2008);
    devCompilerSet.LoadSetDirs(ID_COMPILER_VC2008);

    {$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        For j := 0 To Length(pluginSettings) - 1 Do
        Begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            If tempName <> '' Then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        End;
        MainForm.plugins[i].LoadCompilerOptions;

    End;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_VC2008);


    devCompilerSet.CompilerType := ID_COMPILER_VC2010;
    // EAB TODO: Check this logic. Maybe, move above and change numbering
    devdirs.fCompilerType := ID_COMPILER_VC2010;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_VC2010);
    devCompilerSet.LoadSetDirs(ID_COMPILER_VC2010);

    {$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        For j := 0 To Length(pluginSettings) - 1 Do
        Begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            If tempName <> '' Then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        End;
        MainForm.plugins[i].LoadCompilerOptions;

    End;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_VC2010);


    devCompilerSet.CompilerType := ID_COMPILER_BORLAND;
    devdirs.fCompilerType := ID_COMPILER_BORLAND;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_BORLAND);
    devCompilerSet.LoadSetDirs(ID_COMPILER_BORLAND);

    {$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        For j := 0 To Length(pluginSettings) - 1 Do
        Begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            If tempName <> '' Then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        End;
        MainForm.plugins[i].LoadCompilerOptions;

    End;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_BORLAND);

    devCompilerSet.CompilerType := ID_COMPILER_WATCOM;
    devdirs.fCompilerType := ID_COMPILER_WATCOM;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_WATCOM);
    devCompilerSet.LoadSetDirs(ID_COMPILER_WATCOM);

    {$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        For j := 0 To Length(pluginSettings) - 1 Do
        Begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            If tempName <> '' Then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        End;
        MainForm.plugins[i].LoadCompilerOptions;

    End;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_WATCOM);

    devCompilerSet.CompilerType := ID_COMPILER_LINUX;
    devdirs.fCompilerType := ID_COMPILER_LINUX;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_LINUX);
    devCompilerSet.LoadSetDirs(ID_COMPILER_LINUX);

    {$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        For j := 0 To Length(pluginSettings) - 1 Do
        Begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            If tempName <> '' Then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        End;
        MainForm.plugins[i].LoadCompilerOptions;

    End;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_LINUX);

    //Reset the compiler type back to GCC
    devdirs.fCompilerType := ID_COMPILER_MINGW;
    devdirs.SettoDefaults;
    //Guru: todo: Add More Compiler default sets here

    devCompilerSet.LoadSet(devCompiler.CompilerSet);
    devCompiler.AddDefaultOptions;
    devCompilerSet.AssignToCompiler;

    {$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        For j := 0 To Length(pluginSettings) - 1 Do
        Begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            If tempName <> '' Then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        End;
        MainForm.plugins[i].LoadCompilerOptions;

    End;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(devCompiler.CompilerSet);
    devCompiler.SaveSettings;
End;

Procedure SaveOptions;
Begin
    devData.SaveConfigData;
    devDirs.SaveSettings;
    devCompiler.SaveSettings;
    devEditor.SaveSettings;
    devCodeCompletion.SaveSettings;
    devClassBrowsing.SaveSettings;
    devCVSHandler.SaveSettings;
    devExternalPrograms.SaveSettings;
  {$IFDEF PLUGIN_BUILD}
    devPluginToolbarsX.SaveSettings;
    devPluginToolbarsY.SaveSettings;
  {$ENDIF PLUGIN_BUILD}
End;

Procedure ResettoDefaults;
Begin
    devData.SettoDefaults;
    devCompiler.SettoDefaults;
    devCompilerSet.SettoDefaults;
    devDirs.SettoDefaults;
    devEditor.SettoDefaults;
    devCodeCompletion.SettoDefaults;
    devClassBrowsing.SettoDefaults;
    devExternalPrograms.SetToDefaults;
  {$IFDEF PLUGIN_BUILD}
    devPluginToolbarsX.SetToDefaults;
    devPluginToolbarsY.SetToDefaults;
  {$ENDIF PLUGIN_BUILD}
End;

Procedure FinalizeOptions;
Begin
    devCompiler.SaveSettings;
    devCompiler.Free;

    If Assigned(devCompiler) Then
        devCompilerSet.Free;

    devDirs.SaveSettings;
    devDirs.Free;

    devEditor.SaveSettings;
    devEditor.Free;

    devCodeCompletion.SaveSettings;
    devCodeCompletion.Free;

    devClassBrowsing.SaveSettings;
    devClassBrowsing.Free;

    devCVSHandler.SaveSettings;
    devCVSHandler.Free;

    devExternalPrograms.SaveSettings;
    devExternalPrograms.Free;

  {$IFDEF PLUGIN_BUILD}
    devPluginToolbarsX.SaveSettings;
    devPluginToolbarsX.Free;

    devPluginToolbarsY.SaveSettings;
    devPluginToolbarsY.Free;
  {$ENDIF PLUGIN_BUILD}
End;

Procedure CheckForAltConfigFile(filename: String);
Var
    Ini: TIniFile;
Begin
    UseAltConfigFile := False;
    AltConfigFile := '';
    If Not FileExists(filename) Then
        Exit;
    Ini := TIniFile.Create(filename);
    Try
        UseAltConfigFile := Ini.ReadBool('Options', 'UseAltConfigFile', False);
        AltConfigFile := Ini.ReadString('Options', 'AltConfigFile', '');
    Finally
        Ini.Free;
    End;
End;

Procedure UpdateAltConfigFile;
Var
    Ini: TIniFile;
Begin
    Ini := TIniFile.Create(StandardConfigFile);
    Try
        Ini.WriteBool('Options', 'UseAltConfigFile', UseAltConfigFile);
        Ini.WriteString('Options', 'AltConfigFile', AltConfigFile);
    Finally
        Ini.Free;
    End;
End;

{ TDevData - Singleton pattern }
Var
    fdevData: TdevData = Nil;
    fExternal: Boolean = True;

Function devData: TdevData;
Begin
    If Not assigned(fdevData) Then
    Begin
        fExternal := False;
        Try
            fdevData := TdevData.Create(Nil);
        Finally
            fExternal := True;
        End;
    End;
    result := fDevData;
End;

Class Function TdevData.devData: TdevData;
Begin
    result := devcfg.devData;
End;
(*
  raises an exception when:
   1 - try to create without call to devdata function
         i.e. opt:= TdevData.Create; -- will raise
   2 - if already created -- should never see
*)

// add strings to lang file
Constructor TdevData.Create(aOwner: Tcomponent);
Begin
    If assigned(fdevData) Then
        Raise Exception.Create('Dev Data already created');
    If fExternal Then
        Raise Exception.Create('Dev Data Externally Created');
    Inherited Create(aOwner);
    IgnoreProperties.Add('Style');

    SettoDefaults;
End;

Destructor TdevData.Destroy;
Begin
    fdevData := Nil;
    Inherited;
End;

Procedure TdevData.ReadConfigData;
Begin
    Inherited;
    LoadWindowPlacement('Position', fWinPlace);
End;

Procedure TdevData.SaveConfigData;
Begin
    Inherited;
    SaveWindowPlacement('Position', fWinPlace);
End;

Procedure TdevData.SettoDefaults;

    Function getAssociation(I: Integer): Boolean;
    Begin
        Result := CheckFiletype('.' + Associations[I, 0],
            'DevCpp.' + Associations[I, 0],
            Associations[I, 1],
            'open',
            Application.Exename + ' "%1"');
    End;

Begin
    fVersion := ''; // this is filled in MainForm.Create()
    fFirst := True;
    fLang := DEFAULT_LANG_FILE;
    fFindCols := '75, 75, 120, 150';
    fCompCols := '75, 75, 120';
    fMsgTabs := True; // Top
    fMRUMax := 10;
    fMinOnRun := False;
    fBackup := False;
    fAutoOpen := 2;
    fClassView := False;
    fStatusbar := True;
    fSingleInstance := True;
    fShowBars := False;
    fShowMenu := True;
    fDefCpp := True;
    fOpenStyle := 0;
    fdblFiles := False;
    fAutoCompile := -1;
    fAutoAddDebugFlag := -1;

    fToolbarMain := True;
    fToolbarMainX := 11;
    fToolbarMainY := 2;
    fToolbarEdit := True;
    fToolbarEditX := 201;
    fToolbarEditY := 2;
    fToolbarCompile := True;
    fToolbarCompileX := 11;
    fToolbarCompileY := 30;
    fToolbarDebug := True;
    fToolbarDebugX := 154;
    fToolbarDebugY := 30;
    fToolbarProject := True;
    fToolbarProjectX := 375;
    fToolbarProjectY := 2;
    fToolbarOptions := True;
    fToolbarOptionsX := 143;
    fToolbarOptionsY := 30;
    fToolbarSpecials := True;
    fToolbarSpecialsX := 202;
    fToolbarSpecialsY := 30;
    fToolbarSearch := True;
    fToolbarSearchX := 261;
    fToolbarSearchY := 2;
    fToolbarClasses := True;
    fToolbarClassesX := 11;
    fToolbarClassesY := 58;

    //read associations set by installer as defaults
    fAssociateC := getAssociation(0);
    fAssociateCpp := getAssociation(1);
    fAssociateH := getAssociation(2);
    fAssociateHpp := getAssociation(3);
    fAssociateDev := getAssociation(4);
    fAssociateRc := getAssociation(5);
    fAssociateTemplate := getAssociation(6);

    fShowTipsOnStart := True;
    fLastTip := 0;
    fXPTheme := False;
    fNativeDocks := True;
    fHiliteActiveTab := False;
    fFileDate := 0;
    fShowProgress := True;
    fAutoCloseProgress := False;
    fPrintColors := True;
    fPrintHighlight := True;
    fPrintWordWrap := False;
    fPrintLineNumbers := False;
    fPrintLineNumbersMargins := False;
    fWatchHint := True;
    fWatchError := True;
    fNoToolTip := False;

    fDebugCommand := '-exec-finish';

End;

{ TCompilerOpts }
Procedure TdevCompiler.AddDefaultOptions;
Var
    sl: TStringList;

Begin
    // WARNING: do *not* re-arrange the options. Their values are written to the ini file
    // with the same order. If you change the order here, the next time the configuration
    // is read, it will assign the values to the *wrong* options...
    // Anyway, the tree that displays the options is sorted, so no real reason to re-arrange
    // anything here ;)
    //
    // NOTE: As you see, to indicate sub-groups use the "/" char...

    //Begin by clearing the compiler options list
    ClearOptions;

    If devCompilerSet.CompilerType In ID_COMPILER_VC Then
    Begin
        sl := TStringList.Create;
        sl.Add('Neither  =');
        sl.Add('Speed=Ot');
        sl.Add('Space=Os');
        AddOption('Favour', False, True, True, False, 0, '/',
            'Code Optimization', [], sl);
        sl := TStringList.Create;
        sl.Add('Neither  =');
        sl.Add('Speed=O2');
        sl.Add('Space=O1');
        AddOption('Optimize for', False, True, True, False, 0, '/',
            'Code Optimization', [], sl);
        AddOption('Enable Global Optimization', False, True, True,
            False, 0, '/Og', 'Code Optimization', [], Nil);
        AddOption('Assume aliasing', False, True, True, False, 0,
            '/Oa', 'Code Optimization', [], Nil);
        AddOption('Enable intrinsic functions', False, True, True,
            False, 0, '/Oi', 'Code Optimization', [], Nil);
        AddOption('Assume cross-function aliasing', False, True,
            True, False, 0, '/Ow', 'Code Optimization', [], Nil);
        AddOption('Optimize for Windows Program', False, True, True,
            False, 0, '/GA', 'Code Optimization', [], Nil);
        AddOption('Omit frame pointers', False, True, True, False,
            0, '/Oy', 'Code Optimization', [], Nil);

        //Code generation
        If (devCompilerSet.CompilerType = ID_COMPILER_VC6) Or
            (devCompilerSet.CompilerType = ID_COMPILER_VC2003) Then
        Begin
            sl := TStringList.Create;
            sl.Add('Blended model=B');
            sl.Add('Pentium=5');
            sl.Add('Pentium Pro, Pentium II and Pentium III  =6');
            sl.Add('Pentium 4 or Athlon=7');
            AddOption('Optimize for', False, True, True, False, 0,
                '/G', 'Code Generation', [], sl);
        End;

        sl := TStringList.Create;
        sl.Add('__cdecl=');
        sl.Add('__fastcall  =/Gr');
        sl.Add('__stdcall=/Gz');
        AddOption('Calling Convention', False, True, True, False,
            0, '', 'Code Generation', [], sl);

        sl := TStringList.Create;
        sl.Add('Disable=');
        If (devCompilerSet.CompilerType = ID_COMPILER_VC6) Or
            (devCompilerSet.CompilerType = ID_COMPILER_VC2003) Then
            sl.Add('Enable=/Gf');
        sl.Add('Enable (Read-Only)  =/GF');
        AddOption('String Pooling', False, True, True, False, 0,
            '', 'Code Generation', [], sl);

        sl := TStringList.Create;
        sl.Add('Compile native code  =');
        sl.Add('Compile for CLR=/clr');
        sl.Add('No assembly=/clr:noAssembly');
        If (devCompilerSet.CompilerType In ID_COMPILER_VC_CURRENT) Then
        Begin
            sl.Add('IL-only output file=/clr:pure');
            sl.Add('Verifiable IL-only output=/clr:safe');
            sl.Add('Use old syntax=/clr:oldSyntax');
            sl.Add('Enable initial AppDomain behaviour  =/clr:initialAppDomain');
        End;
        AddOption('Common Language Runtime', False, True, True,
            False, 0, '', 'Code Generation', [], sl);

        If (devCompilerSet.CompilerType In ID_COMPILER_VC_CURRENT) Then
        Begin
            sl := TStringList.Create;
            sl.Add('Precise  =precise');
            sl.Add('Fast=fast');
            sl.Add('Strict=strict');
            AddOption('Floating-Point Model', False, True, True, False,
                0, '', 'Code Generation', [], sl);
        End;

        sl := TStringList.Create;
        sl.Add('None=');
        sl.Add('SSE=/arch:SSE');
        sl.Add('SSE2  =/arch:SSE2');
        AddOption('Extended instruction set', False, True, True,
            False, 0, '', 'Code Generation', [], sl);

        sl := TStringList.Create;
        sl.Add('No Exceptions=');
        sl.Add('C++ Exceptions (no SEH)=/EHs');
        sl.Add('C++ Exceptions (with SEH)  =/EHa');
        AddOption('Exception handling', False, False, True, False,
            0, '', 'Code Generation', [], sl);
        AddOption('Enable _penter function call', False, True, True,
            False, 0, '/Gh', 'Code Generation', [], Nil);
        AddOption('Enable _pexit function call', False, True, True,
            False, 0, '/GH', 'Code Generation', [], Nil);
        AddOption('Enable C++ RTTI', False, False, True, False, 0,
            '/GR', 'Code Generation', [], Nil);
        AddOption('Enable Minimal Rebuild', False, True, True, False,
            0, '/Gm', 'Code Generation', [], Nil);
        AddOption('Enable Link-Time Code Generation', False, True,
            True, False, 0, '/GL', 'Code Generation', [], Nil);
        If (devCompilerSet.CompilerType = ID_COMPILER_VC6) Or
            (devCompilerSet.CompilerType = ID_COMPILER_VC2003) Then
        Begin
            AddOption('Enable Pentium FDIV fix', False, True, True,
                False, 1, '/QIfdiv', 'Code Generation', [], Nil);
            AddOption('Enable Pentium 0x0F fix', False, True, True,
                False, 1, '/QI0f', 'Code Generation', [], Nil);
            AddOption('Use FIST instead of ftol()', False, True, True,
                False, 1, '/QIfist', 'Code Generation', [], Nil);
        End;
        AddOption('extern "C" implies nothrow', False, False, True,
            False, 0, '/EHc', 'Code Generation', [], Nil);
        AddOption('Enable function-level linking', False, False,
            False, True, 0, '/Gy', 'Code Generation', [], Nil);
        AddOption('Use fibre-safe TLS accesses', False, True, True,
            False, 0, '/GT', 'Code Generation', [], Nil);

        //Checks
        sl := TStringList.Create;
        sl.Add('None=');
        If (devCompilerSet.CompilerType = ID_COMPILER_VC6) Or
            (devCompilerSet.CompilerType = ID_COMPILER_VC2003) Then
            sl.Add('Enable stack probes=/Ge');
        sl.Add('Control Stack Checking Calls  =/GS');
        AddOption('Stack checks', False, True, True, False, 0, '',
            'Code Checks', [], sl);
        AddOption('Type conversion Checks', False, True, True, False,
            0, '/RTCc', 'Code Checks', [], Nil);
        AddOption('Stack Frame runtime checking', False, True, True,
            False, 0, '/RTCs', 'Code Checks', [], Nil);
        AddOption('Check for Variable Usage', False, True, True,
            False, 0, '/RTCu', 'Code Checks', [], Nil);

        //Language Options
        sl := TStringList.Create;
        sl.Add('No Debugging Information=');
        sl.Add('Generate Debugging Information=/Zi');
        sl.Add('Edit and Continue Debugging Information  =/ZI');
        sl.Add('Old-Style Debugging Information=/Z7');
        sl.Add('Include line numbers only=/Zd');
        AddOption('Debugging', False, True, True, False, 0, '',
            'Language Options', [], sl);
        If (devCompilerSet.CompilerType = ID_COMPILER_VC6) Or
            (devCompilerSet.CompilerType = ID_COMPILER_VC2003) Then
            AddOption('Enable Extensions', False, True, True, False,
                1, '/Ze', 'Language Options', [], Nil);
        AddOption('Omit library name in object file', False, True,
            True, False, 0, '/Zl', 'Language Options', [], Nil);
        AddOption('Generate function prototypes', False, True, True,
            False, 0, '/Zg', 'Language Options', [], Nil);
        If (devCompilerSet.CompilerType In ID_COMPILER_VC_CURRENT) Then
            AddOption('Enable OpenMP 2.0 Language Extensions', False,
                False, True, False, 0, '/openmp', 'Language Options', [], Nil);

        If (devCompilerSet.CompilerType = ID_COMPILER_VC6) Or
            (devCompilerSet.CompilerType = ID_COMPILER_VC2003) Then
        Begin
            AddOption('Enforce Standard C++ scoping', False, False,
                True, False, 0, '/Zc:forScope', 'Language Options', [], Nil);
            AddOption('Make wchar_t a native type', False, False,
                True, False, 0, '/Zc:wchar_t', 'Language Options', [], Nil);
        End
        Else
        Begin
            AddOption('Don''t Enforce Standard C++ scoping', False,
                False, True, False, 0, '/Zc:forScope-', 'Language Options', [], Nil);
            AddOption('Don''t Make wchar_t a native type', False,
                False, True, False, 0, '/Zc:wchar_t-', 'Language Options', [], Nil);
        End;

        //Miscellaneous
        AddOption('Treat warnings as errors', False, True, True,
            False, 0, '/WX', 'Miscellaneous', [], Nil);
        sl := TStringList.Create;
        sl.Add('Default (Level 1)  =');
        sl.Add('Level 2=/W2');
        sl.Add('Level 3=/W3');
        sl.Add('Level 4=/W4');
        sl.Add('None=/w');
        AddOption('Warning Level', False, True, True, False, 0, '',
            'Miscellaneous', [], sl);
        If (devCompilerSet.CompilerType = ID_COMPILER_VC6) Or
            (devCompilerSet.CompilerType = ID_COMPILER_VC2003) Then
            AddOption('Enable automatic precompiled headers', False,
                True, True, False, 0, '/YX', 'Miscellaneous', [], Nil);
        AddOption('Enable 64-bit porting warnings', False, True,
            True, False, 0, '/Wp64', 'Miscellaneous', [], Nil);
        AddOption('Disable incremental linking', False, False, False,
            True, 0, '/INCREMENTAL:NO', 'Miscellaneous', [], Nil);
    End
    Else
    If devCompilerSet.CompilerType = ID_COMPILER_DMARS Then
    Begin
        //Start of DMars
        sl := TStringList.Create;
        sl.Add('');
        // /!\ Must contain a starting empty value in order to do not have always to pass the parameter
        sl.Add('1=1');
        sl.Add('2=2');
        sl.Add('4=4');
        sl.Add('8=8');
        AddOption('alignment of struct members', False, True, True,
            False, 0, '-a', 'C++ Options', [], sl);
        AddOption('ANSI X3.159-1989 conformance', False, True, True,
            False, 0, '-A89', 'C++ Options', [], Nil);
        AddOption('ISO/IEC 9899:1990 conformance', False, True,
            True, False, 0, '-A90', 'C++ Options', [], Nil);
        AddOption('ISO/IEC 9899-1:1994 conformance', False, True,
            True, False, 0, '-A94', 'C++ Options', [], Nil);
        AddOption('ISO/IEC 9899:1999 conformance', False, True,
            True, False, 0, '-A99', 'C++ Options', [], Nil);
        AddOption('strict ANSI C/C++', False, True, True, False,
            0, '-A', 'C++ Options', [], Nil);
        AddOption('enable new[] and delete[]', False, True, True,
            False, 0, '-Aa', 'C++ Options', [], Nil);
        AddOption('enable bool', False, True, True, False, 0, '-Ab',
            'C++ Options', [], Nil);
        AddOption('enable exception handling', False, True, True,
            False, 0, '-Ae', 'C++ Options', [], Nil);
        AddOption('enable RTTI', False, True, True, False, 0, '-Ar',
            'C++ Options', [], Nil);
        sl := TStringList.Create;
        sl.Add('');
        // /!\ Must contain a starting empty value in order to do not have always to pass the parameter
        sl.Add('English=e');
        sl.Add('French=f');
        sl.Add('German=g');
        sl.Add('Japanese=j');
        AddOption('message language', False, True, True, True, 0,
            '-B', 'C++ Options', [], sl);
        AddOption('skip the link, do compile only', False, True,
            True, False, 0, '-c', 'C++ Options', [], Nil);
        AddOption('source files are C++', False, True, True, False,
            0, '-cpp', 'C++ Options', [], Nil);
        AddOption('generate .cod (assembly) file', False, True,
            True, False, 0, '-cod', 'C++ Options', [], Nil);
        AddOption('no inline function expansion', False, True, True,
            False, 0, '-C', 'C++ Options', [], Nil);
        AddOption('generate .dep (make dependency) file', False,
            True, True, False, 0, '-d', 'C++ Options', [], Nil);
        AddOption('#define DEBUG 1', False, True, True, False, 0,
            '-D', 'C++ Options', [], Nil);
        AddOption('strict ANSI C/C++', False, True, True, False,
            0, '/Zg', 'C++ Options', [], Nil);
        AddOption('show results of preprocessor', False, True, True,
            False, 0, '-e', 'C++ Options', [], Nil);
        AddOption('do not elide comments', False, True, True, False,
            0, '-EC', 'C++ Options', [], Nil);
        AddOption('#line directives not output', False, True, True,
            False, 0, '-EL', 'C++ Options', [], Nil);

        AddOption('IEEE 754 inline 8087 code', False, True, True,
            False, 0, '-f', 'C++ Options', [], Nil);
        AddOption('work around FDIV problem', False, True, True,
            False, 0, '-fd', 'C++ Options', [], Nil);

        AddOption('fast inline 8087 code', False, True, True, False,
            0, '-ff ', 'C++ Options', [], Nil);
        AddOption('generate debug info', False, True, True, False,
            0, '-g', 'C++ Options', [], Nil);

        //-gf disable debug info optimization
        AddOption('disable debug info optimization', False, True,
            True, False, 0, '-gf', 'C++ Options', [], Nil);
        //-gg make static functions global
        AddOption('make static functions global', False, True, True,
            False, 0, '-gg', 'C++ Options', [], Nil);
        //-gh symbol info for globals
        AddOption('symbol info for globals', False, True, True,
            False, 0, '-gh', 'C++ Options', [], Nil);
        //-gl debug line numbers only
        AddOption('debug line numbers only', False, True, True,
            False, 0, '-gl', 'C++ Options', [], Nil);
        //-gp generate pointer validations
        AddOption('generate pointer validations', False, True, True,
            False, 0, '-gp', 'C++ Options', [], Nil);
        //-gs debug symbol info only
        AddOption('debug symbol info only', False, True, True, False,
            0, '-gs', 'C++ Options', [], Nil);
        //-gt generate trace prolog/epilog
        AddOption('generate trace prolog/epilog', False, True, True,
            False, 0, '-gt', 'C++ Options', [], Nil);
        //-GTnnnn set data threshold to nnnn
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);
        //-H  use precompiled headers (ph)
        AddOption('use precompiled headers (ph)', False, True, True,
            False, 0, '-H', 'C++ Options', [], Nil);
        //-HDdirectory  use ph from directory
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);
        //-HF[filename]  generate ph to filename
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);
        //-HHfilename  read ph from filename
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);
        //-HIfilename   #include "filename"
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);
        //-HO include files only once
        AddOption('include files only once', False, True, True,
            False, 0, '-HO', 'C++ Options', [], Nil);
        //-HS only search -I directories
        AddOption('only search -I directories', False, True, True,
            False, 0, '-HS', 'C++ Options', [], Nil);
        //-HX automatic precompiled headers
        AddOption('automatic precompiled headers', False, True,
            True, False, 0, '-HX', 'C++ Options', [], Nil);
        //-j[0|1|2]  Asian language characters
        //0: Japanese 1: Taiwanese and Chinese 2: Korean
        sl := TStringList.Create;
        sl.Add('');
        // /!\ Must contain a starting empty value in order to do not have always to pass the parameter
        sl.Add('Japanese=0');
        sl.Add('Taiwanese & Chinese=1');
        sl.Add('Korean=2');
        AddOption('Asian language characters', False, True, True,
            True, 0, '-j', 'C++ Options', [], sl);
        //-Jm relaxed type checking
        AddOption('relaxed type checking', False, True, True, False,
            0, '-Jm', 'C++ Options', [], Nil);
        //-Ju char==unsigned char
        AddOption('char==unsigned char', False, True, True, False,
            0, '-Ju', 'C++ Options', [], Nil);
        // - Jb no empty base class optimization
        AddOption('no empty base class optimization', False, True,
            True, False, 0, '-Jb', 'C++ Options', [], Nil);
        // - J  chars are unsigned
        AddOption('chars are unsigned', False, True, True, False,
            0, '-J', 'C++ Options', [], Nil);
        // - m[tsmclvfnrpxz][do][w][u] set memory model
    {s : small code and data              m: large code, small data
    c : small code, large data            l: large code and data
    v: VCM                                r: Rational 16 bit DOS Extender
    p: Pharlap 32 bit DOS Extender        x: DOSX 32 bit DOS Extender
    z: ZPM 16 bit DOS Extender            f: OS/2 2.0 32 bit
    t: .COM file                  n: Windows 32s/95/98/NT/2000/ME/XP
    d: DOS 16 bit                 o: OS/2 16 bit
    w: SS != DS                           u: reload DS
    }
        sl := TStringList.Create;
        sl.Add('');
        // /!\ Must contain a starting empty value in order to do not have always to pass the parameter
        sl.Add('small code and data=s');
        sl.Add('large code, small data=m');
        sl.Add('small code, large data=c');
        sl.Add('large code and data=l');
        sl.Add('VCM=v');
        sl.Add('Rational 16 bit DOS Extender=r');
        sl.Add('Pharlap 32 bit DOS Extender=p');
        sl.Add('DOSX 32 bit DOS Extender=x');
        sl.Add('ZPM 16 bit DOS Extender=z');
        sl.Add('OS/2 2.0 32 bit=f');
        sl.Add('.COM file=t');
        sl.Add('Windows 32s/95/98/NT/2000/ME/XP=n');
        //?sl.Add('DOS 16 bit=d');
        //?sl.Add('OS/2 16 bit=o');
        //?sl.Add('SS Not Equal DS=w');
        //?sl.Add('reload DS=u');
        AddOption('alignment of struct members', False, True, True,
            False, 0, '-m', 'C++ Options', [], sl);
        //-Nc function level linking
        AddOption('function level linking', False, True, True, False,
            0, '-Nc', 'C++ Options', [], Nil);
        //-NL no default library
        AddOption('no default library', False, True, True, False,
            0, '-NL', 'C++ Options', [], Nil);
        //-Ns place expr strings in code seg
        AddOption('place expr strings in code seg', False, True,
            True, False, 0, '-Ns', 'C++ Options', [], Nil);
        //-NS new code seg for each function
        AddOption('new code seg for each function', False, True,
            True, False, 0, '-NS', 'C++ Options', [], Nil);
        //-NTname  set code segment name
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);
        //-NV vtables in far data
        AddOption('vtables in far data', False, True, True, False,
            0, '-NV', 'C++ Options', [], Nil);
        //-o[-+flag]  run optimizer with flag
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);

        //-ooutput  output filename
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);

        //-p  turn off autoprototyping
        AddOption('turn off autoprototyping', False, True, True,
            False, 0, '-p', 'C++ Options', [], Nil);

        //-P  default to pascal linkage
        AddOption('default to pascal linkage', False, True, True,
            False, 0, '-P', 'C++ Options', [], Nil);

        //-Pz default to stdcall linkage
        AddOption('default to stdcall linkage', False, True, True,
            False, 0, '-Pz', 'C++ Options', [], Nil);

        //-r  strict prototyping
        AddOption('strict prototyping', False, True, True, False,
            0, '-r', 'C++ Options', [], Nil);

        //-R  put switch tables in code seg
        AddOption('put switch tables in code seg', False, True,
            True, False, 0, '-R', 'C++ Options', [], Nil);

        //-s  stack overflow checking
        AddOption('stack overflow checking', False, True, True,
            False, 0, '-s', 'C++ Options', [], Nil);

        //-S  always generate stack frame
        AddOption('always generate stack frame', False, True, True,
            False, 0, '-S', 'C++ Options', [], Nil);

        //-u  suppress predefined macros
        AddOption('suppress predefined macros', False, True, True,
            False, 0, '-u', 'C++ Options', [], Nil);

        //-v[0|1|2] verbose compile
        sl := TStringList.Create;
        sl.Add('');
        // /!\ Must contain a starting empty value in order to do not have always to pass the parameter
        sl.Add('0=0');
        sl.Add('1=1');
        sl.Add('2=2');
        AddOption('verbose compile', False, True, True, False, 0,
            '-v', 'C++ Options', [], sl);

        //-w  suppress all warnings
        AddOption('suppress all warnings', False, True, True, False,
            0, '-w', 'C++ Options', [], Nil);

        //-wc warn on C style casts
        AddOption('warn on C style casts', False, True, True, False,
            0, '-wc', 'C++ Options', [], Nil);

        //-wn suppress warning number n
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);

        //-wx treat warnings as errors
        AddOption('treat warnings as errors', False, True, True,
            False, 0, '-wx', 'C++ Options', [], Nil);

        //-W{0123ADabdefmrstuvwx-+}  Windows prolog/epilog
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);

        //-WA  Windows EXE
        //? AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);

        //-WD  Windows DLL
        //? AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);

        //-x  turn off error maximum
        AddOption('turn off error maximum', False, True, True, False,
            0, '-x', 'C++ Options', [], Nil);

        //-XD instantiate templates
        AddOption('instantiate templates', False, True, True, False,
            0, '-XD', 'C++ Options', [], Nil);

        //-XItemp<type>  instantiate template class temp<type>
        //? AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);

        //-XIfunc(type)  instantiate template function func(type)

        //-[0|2|3|4|5|6]  8088/286/386/486/Pentium/P6 code
        sl := TStringList.Create;
        sl.Add('');
        // /!\ Must contain a starting empty value in order to do not have always to pass the parameter
        sl.Add('8088=0');
        sl.Add('286=2');
        sl.Add('386=3');
        sl.Add('486=4');
        sl.Add('Pentium=5');
        sl.Add('P6=6');
        AddOption('Architecture', False, True, True, False, 0, '-',
            'C++ Options', [], sl);

        //Linker Options
        // /ALIGNMENT	Segment alignment size
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /BASE		Set the base address of the executable image
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /BINARY		Generates a .sys file
        AddOption('Generate a .sys file', False, False, False, True,
            0, '/BINARY', 'Linker Options', [], Nil);

        // /BYORDINAL	Export by ordinal
        AddOption('Export by ordinal', False, False, False, True, 0,
            '/BYORDINAL', 'Linker Options', [], Nil);

        // /CHECKSUM	Parsed and ignored
        AddOption('Parsed and ignored', False, False, False, True, 0,
            '/CHECKSUM', 'Linker Options', [], Nil);

        // /CODEVIEW	Outputs CodeView debugger information
        AddOption('Generate Debugger information', False, False, False,
            True, 0, '/CODEVIEW', 'Linker Options', [], Nil);

        // /COMDEFSEARCH	Specifies whether an undefined COMDEF causes a library search
        AddOption('Specifies whether an undefined COMDEF causes a library search',
            False, False, False, True, 0, 'COMDEFSEARCH', 'Linker Options', [], Nil);

        // /CPARMAXALLOC	Sets .exe maximum bytes to occupy in DOS RAM
        //AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /CVVERSION	Preserves OPTLINK's CodeView compatibility.
        // multiple AddOption('OPTLINK's CodeView Version', False, false, false, true, 0, '', 'Linker Options', [], nil);

        // /DEBUG		Controls all debug information for files that follow
        //AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /DEBUGFILES	Controls debug information for specific files only
        //AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /DEBUGLINES	Controls debug line number information for files that follow
        //AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /DEBUGLOCALS	Controls debug local symbols information for files that follow
        //AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /DEBUGMODULES	Controls debug information for specific modules only
        //AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /DEBUGPUBLICS	Controls debug public symbols information for files that follow
        //AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /DEBUGTYPES	Controls debug type information for files that follow
        //AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /DEFAULTLIBRARYSEARCH Searches default libraries named in .obj files
        //AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /DELEXECUTABLE	Deletes .exe upon encountering any linking errors
        // AddOption('Delete .exe upon linking errors', False, false, false, true, 0, '/DELEXECUTABLE', 'Linker Options', [], nil);

        // /DETAILEDMAP	Produces detailed map reports.
        AddOption('Produce detailed map reports', False, False, False,
            True, 0, '/DETAILEDMAP', 'Linker Options', [], Nil);

        // /DOSSEG		Controls segment sequence
        AddOption('Controls segment sequence', False, False, False,
            True, 0, '/DOSSEG', 'Linker Options', [], Nil);

        // /ECHOINDIRECT	Controls echoing of indirect response file input
        AddOption('Controls echoing of indirect response file input',
            False, False, False, True, 0, '/ECHOINDIRECT', 'Linker Options', [], Nil);

        // /EMSMAXSIZE	Sets maximum EMS size
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /EMSPAGEFRAMEIO	Gives permission to use EMS page frame for I/O
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /EMSUSE40	Allow LIM 4.0 adherence
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /ERRORFLAG	Controls error flag in segmented executable header
        AddOption('Controls error flag in segmented executable header',
            False, False, False, True, 0, '/ERRORFLAG', 'Linker Options', [], Nil);

        // /EXEPACK	Performs run-length encoding (packs executable)
        AddOption('Performs run-length encoding (packs executable)',
            False, False, False, True, 0, '/EXEPACK', 'Linker Options', [], Nil);

        // /EXETYPE	Specifies the target operating system
        // multiple AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /FARCALLTRANSLATION Converts intra-segment far calls to near
        AddOption('Converts intra-segment far calls to near', False,
            False, False, True, 0, '/FARCALLTRANSLATION', 'Linker Options', [], Nil);

        // /FIXDS		Identical to the .def directive FIXDS
        AddOption('Identical to the .def directive FIXDS', False, False,
            False, True, 0, '/FIXDS', 'Linker Options', [], Nil);

        // /FIXED		Fixes the executable image in memory
        AddOption('Fixes the executable image in memory', False, False,
            False, True, 0, '/FIXED', 'Linker Options', [], Nil);

        // /GROUPASSOCIATION Controls GROUP information found in .obj
        AddOption('Controls GROUP information found in .obj', False,
            False, False, True, 0, '/GROUPASSOCIATION', 'Linker Options', [], Nil);

        // /GROUPSTACK	Controls stack definition in .exe file header
        AddOption('Controls stack definition in .exe file header', False,
            False, False, True, 0, '/GROUPSTACK', 'Linker Options', [], Nil);

        // /HEAP		Sets the size of the local heap
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /IGNORECASE	Preserves and ignores case of all symbols
        AddOption('Preserves and ignores case of all symbols', False,
            False, False, True, 0, '/IGNORECASE', 'Linker Options', [], Nil);

        // /IMPDEF		Generate .din file from EXPORTS section of .def file
        AddOption('Generate .din file from EXPORTS section of .def file',
            False, False, False, True, 0, '/IMPDEF', 'Linker Options', [], Nil);

        // /IMPLIB		Create .lib import library for .dll
        AddOption('Create .lib import library for .dll', False, False,
            False, True, 0, '/IMPLIB', 'Linker Options', [], Nil);

        // /INFORMATION	Display status information throughout the link process
        AddOption('Display status information throughout the link process',
            False, False, False, True, 0, '/INFORMATION', 'Linker Options', [], Nil);

        // /LINENUMBERS	Outputs line number information in .map file
        AddOption('Outputs line number information in .map file', False,
            False, False, True, 0, '/LINENUMBERS', 'Linker Options', [], Nil);

        // /LOWERCASE	Converts all symbols to lowercase
        AddOption('Converts all symbols to lowercase', False, False,
            False, True, 0, '/LOWERCASE', 'Linker Options', [], Nil);

        // /MACHINE	Specifies the type of the target machine
        AddOption('Specifies the type of the target machine', False,
            False, False, True, 0, '/MACHINE', 'Linker Options', [], Nil);

        // /MAP		Controls information content in .map file
        AddOption('Controls information content in .map file', False,
            False, False, True, 0, '/MAP', 'Linker Options', [], Nil);

        // /NOLOGO		Suppresses OPTLINK's sign-on copyright message
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /NONAMES	Eliminates name text for ordinal exports
        AddOption('Eliminates name text for ordinal exports', False,
            False, False, True, 0, '/NONAMES', 'Linker Options', [], Nil);

        // /NULLDOSSEG	Outputs null bytes in the _TEXT segment
        AddOption('Outputs null bytes in the _TEXT segment', False,
            False, False, True, 0, '/NULLDOSSEG', 'Linker Options', [], Nil);

        // /ONERROR	Same as /DELEXECUTABLE
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /PACKCODE	Combines segments of class CODE
        AddOption('Combines segments of class CODE', False, False, False,
            True, 0, '/PACKCODE', 'Linker Options', [], Nil);

        // /PACKDATA	Combines data segments where possible
        AddOption('Combines data segments where possible', False, False,
            False, True, 0, '/PACKDATA', 'Linker Options', [], Nil);

        // /PACKFUNCTIONS	Performs "smart-linking" on code and data
        AddOption('Performs "smart-linking" on code and data', False,
            False, False, True, 0, '/PACKFUNCTIONS', 'Linker Options', [], Nil);

        // /PACKIFNOSEGMENTS Forces /PACKCODE on when no SEGMENTS directive
        AddOption('Forces /PACKCODE on when no SEGMENTS directive',
            False, False, False, True, 0, '/PACKIFNOSEGMENTS', 'Linker Options', [], Nil);

        // /PACKSIZE	Packs size for /PACKCODE and /PACKDATA
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /PAGESIZE	Set /IMPLIB page size
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /PAUSE		Provides time to swap disks while creating output
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /PMTYPE		Specifies type of segmented output
        AddOption('Specifies type of segmented output', False, False,
            False, True, 0, '/PMTYPE', 'Linker Options', [], Nil);

        // /PROMPT		Specifies whether OPTLINK will prompt for more options
        // AddOption('Specifies whether OPTLINK will prompt for more options', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /RC		Like .def directive RC, automatic resource binding
        AddOption('Like .def directive RC, automatic resource binding',
            False, False, False, True, 0, '/RC', 'Linker Options', [], Nil);

        // /RELOCATIONCHECK Ensures no relocation overlaps have occurred
        AddOption('Ensures no relocation overlaps have occurred', False,
            False, False, True, 0, '/RELOCATIONCHECK', 'Linker Options', [], Nil);

        // /REORDERSEGMENTS Performs segment reordering
        AddOption('Performs segment reordering', False, False, False,
            True, 0, '/REORDERSEGMENTS', 'Linker Options', [], Nil);

        // /SCANLIB	Scans the LIB environment variable
        AddOption('Scans the LIB environment variable', False, False,
            False, True, 0, '/SCANLIB', 'Linker Options', [], Nil);

        // /SCANLINK	Scans the LINK environment variable
        AddOption('Scans the LINK environment variable', False, False,
            False, True, 0, '/SCANLINK', 'Linker Options', [], Nil);

        // /SILENT		Does not display linking status information
        AddOption('Does not display linking status information', False,
            False, False, True, 0, '/SILENT', 'Linker Options', [], Nil);

        // /STACK		Defines stack segment and/ or its size.
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /STUB		Adds a stub file to the executable
        AddOption('Adds a stub file to the executable', False, False,
            False, True, 0, '/STUB', 'Linker Options', [], Nil);

        // /SUBSYSTEM	Sets Win32 subsystem
        // multiple AddOption('Sets Win32 subsystem', False, false, false, true, 0, '/SUBSYSTEM', 'Linker Options', [], nil);

        // /TINY		Generates a .com file
        AddOption('Generates a .com file', False, False, False, True,
            0, '/TINY', 'Linker Options', [], Nil);

        // /UPPERCASE	Converts all symbols to upper case
        AddOption('Converts all symbols to upper case', False, False,
            False, True, 0, '/UPPERCASE', 'Linker Options', [], Nil);

        // /VERSION	Adds a version number to the executable
        AddOption('Adds a version number to the executable', False,
            False, False, True, 0, '/VERSION', 'Linker Options', [], Nil);

        // /WARNDUPS	Warns of duplicate public symbols in .lib
        AddOption('Warns of duplicate public symbols in .lib', False,
            False, False, True, 0, '/WARNDUPS', 'Linker Options', [], Nil);

        // /WINPACK	Build compressed output utilizing decompressing loader
        AddOption('Build compressed output utilizing decompressing loader',
            False, False, False, True, 0, '/WINPACK', 'Linker Options', [], Nil);

        // /XMSMAXSIZE	Sets maximum XMS size
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /XNOIGNORECASE	Treats EXPORT and IMPORT symbols as case significant
        AddOption('Architecture', False, False, False, True, 0, '-',
            'Linker Options', [], Nil);

        // /XREF		Controls information content in .map file
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /XUPPERCASE	Forces EXPORT and IMPORT symbols to upper case
        AddOption('Forces EXPORT and IMPORT symbols to upper case',
            False, False, False, True, 0, '/XUPPERCASE', 'Linker Options', [], Nil);
        //End of DMars
    End
    Else
    Begin
        AddOption(Lang[ID_COPT_ANSIC], False, True, True, False,
            0, '-ansi', Lang[ID_COPT_GRP_C], [], Nil);
        AddOption(Lang[ID_COPT_TRADITIONAL], False, True, True,
            False, 0, '-traditional-cpp', Lang[ID_COPT_GRP_C], [], Nil);
        AddOption(Lang[ID_COPT_WARNING], False, True, True, False,
            0, '-w', Lang[ID_COPT_GRP_C], [], Nil);
        AddOption(Lang[ID_COPT_ACCESS], False, True, True, False,
            0, '-fno-access-control', Lang[ID_COPT_GRP_CPP], [], Nil);
        AddOption(Lang[ID_COPT_DOLLAR], False, True, True, False,
            0, '-fdollar-in-identifiers', Lang[ID_COPT_GRP_CPP], [], Nil);
        AddOption(Lang[ID_COPT_HEURISTICS], False, True, True, False,
            0, '-fsave-memorized', Lang[ID_COPT_GRP_CPP], [], Nil);
        AddOption(Lang[ID_COPT_EXCEPT], False, True, True, False,
            0, '-fexceptions', Lang[ID_COPT_GRP_CODEGEN], [], Nil);
        AddOption(Lang[ID_COPT_DBLFLOAT], False, True, True, False,
            0, '-fshort-double', Lang[ID_COPT_GRP_CODEGEN], [], Nil);
        AddOption(Lang[ID_COPT_MEM], False, True, True, False, 0,
            '-fverbose-asm', Lang[ID_COPT_GRP_CODEGEN], [], Nil);
        AddOption(Lang[ID_COPT_OPTMINOR], False, True, True, False,
            0, '-fexpensive-optimizations', Lang[ID_COPT_GRP_OPTIMIZE], [], Nil);
        AddOption(Lang[ID_COPT_OPT1], True, True, True, False, 0,
            '-O1', Lang[ID_COPT_GRP_OPTIMIZE] + '/' + Lang[ID_COPT_FURTHEROPTS], [], Nil);
        AddOption(Lang[ID_COPT_OPTMORE], True, True, True, False,
            0, '-O2', Lang[ID_COPT_GRP_OPTIMIZE] + '/' + Lang[ID_COPT_FURTHEROPTS], [], Nil);
        AddOption(Lang[ID_COPT_OPTBEST], True, True, True, False,
            0, '-O3', Lang[ID_COPT_GRP_OPTIMIZE] + '/' + Lang[ID_COPT_FURTHEROPTS], [], Nil);
        AddOption(Lang[ID_COPT_PROFILE], False, True, True, False,
            0, '-pg', Lang[ID_COPT_PROFILING], [], Nil);
        AddOption(Lang[ID_COPT_OBJC], False, False, False, True,
            0, '-lobjc', Lang[ID_COPT_LINKERTAB], [], Nil);
        AddOption(Lang[ID_COPT_DEBUG], False, True, True, True, 0,
            '-g3', Lang[ID_COPT_LINKERTAB], [], Nil);
        AddOption(Lang[ID_COPT_NOLIBS], False, True, True, True,
            0, '-nostdlib', Lang[ID_COPT_LINKERTAB], [], Nil);
        AddOption(Lang[ID_COPT_WIN32], False, True, True, True, 0,
            '-mwindows', Lang[ID_COPT_LINKERTAB], [dptGUI], Nil);
        AddOption(Lang[ID_COPT_ERRORLINE], False, True, True, True,
            0, '-fmessage-length=0', Lang[ID_COPT_GRP_C], [], Nil);
        AddOption(Lang[ID_COPT_STRIP], False, False, False, True,
            0, '-s', Lang[ID_COPT_LINKERTAB], [], Nil);

        // Architecture params
        sl := TStringList.Create;
        sl.Add('');
        // /!\ Must contain a starting empty value in order to do not have always to pass the parameter
        sl.Add('i386=i386');
        sl.Add('i486=i486');
        sl.Add('i586=i586');
        sl.Add('i686=i686');
        sl.Add('Pentium=pentium');
        sl.Add('Pentium MMX=pentium-mmx');
        sl.Add('Pentium Pro=pentiumpro');
        sl.Add('Pentium 2=pentium2');
        sl.Add('Pentium 3=pentium3');
        sl.Add('Pentium 4=pentium4');
        sl.Add('K6=k6');
        sl.Add('K6-2=k6-2');
        sl.Add('K6-3=k6-3');
        sl.Add('Athlon=athlon');
        sl.Add('Athlon Tbird=athlon-tbird');
        sl.Add('Athlon 4=athlon-4');
        sl.Add('Athlon XP=athlon-xp');
        sl.Add('Athlon MP=athlon-mp');
        sl.Add('Winchip C6=winchip-c6');
        sl.Add('Winchip 2=winchip2');
        sl.Add('K8=k8');
        sl.Add('C3=c3');
        sl.Add('C3-2=c3-2');

        AddOption(Lang[ID_COPT_ARCH], False, True, True, True, 0,
            '-march=', Lang[ID_COPT_GRP_CODEGEN], [], sl);

        // Built-in processor functions
        sl := TStringList.Create;
        sl.Add('');
        // /!\ Must contain a starting empty value in order to do not have always to pass the parameter
        sl.Add('MMX=mmx');
        sl.Add('SSE=sse');
        sl.Add('SSE 2=sse2');
        sl.Add('PNI=pni');
        sl.Add('3D Now=3dnow');

        AddOption(Lang[ID_COPT_BUILTINPROC], False, True, True,
            True, 0, '-m', Lang[ID_COPT_GRP_CODEGEN], [], sl);
    End;
End;

Procedure TdevCompiler.AddOption(_Name: String;
    _IsGroup, _IsC, _IsCpp, IsLinker: Boolean; _Value: Integer;
    _Setting, _Section: String; ExcludeFromTypes: TProjTypeSet;
    Choices: TStringList);
Var
    P: PCompilerOption;
Begin
    P := New(PCompilerOption);
    With P^ Do
    Begin
        optName := _Name;
        optIsGroup := _IsGroup;
        optIsC := _IsC;
        optIsCpp := _IsCpp;
        optIsLinker := IsLinker;
        optValue := _Value;
        optSetting := _Setting;
        optSection := _Section;
        optExcludeFromTypes := ExcludeFromTypes;
        optChoices := Choices;
    End;
    fOptions.Add(P);
End;

Procedure TdevCompiler.ClearOptions;
Var
    i: Integer;
Begin
    For i := 0 To fOptions.Count - 1 Do
    Begin
        If Assigned(PCompilerOption(fOptions.Items[i]).optChoices) Then
            PCompilerOption(fOptions.Items[i]).optChoices.Free;
        Dispose(fOptions.Items[i]);
    End;
    fOptions.Clear;
End;

Constructor TdevCompiler.Create;
Begin
    Inherited;
    fOptions := TList.Create;
    SettoDefaults;
    LoadSettings;
End;

Procedure TdevCompiler.DeleteOption(Index: Integer);
Begin
    If Assigned(PCompilerOption(fOptions[Index]).optChoices) Then
        PCompilerOption(fOptions[Index]).optChoices.Free;
    If Assigned(fOptions[Index]) Then
        Dispose(fOptions[Index]);
    fOptions.Delete(Index);
End;

Destructor TdevCompiler.Destroy;
Begin
    ClearOptions;
    If Assigned(fOptions) Then
        fOptions.Free;
    Inherited;
End;

Function TdevCompiler.FindOption(Setting: String; Var opt: TCompilerOption;
    Var Index: Integer): Boolean;
Var
    I: Integer;
Begin
    Result := False;
    For I := 0 To fOptions.Count - 1 Do
        If Options[I].optSetting = Setting Then
        Begin
            opt := Options[I];
            Index := I;
            Result := True;
            Break;
        End;
End;

Function TdevCompiler.GetOptions(Index: Integer): TCompilerOption;
Begin
    Result := TCompilerOption(fOptions[Index]^);
End;

Function TdevCompiler.GetOptionStr: String;
Var
    I: Integer;
Begin
    Result := '';
    For I := 0 To OptionsCount - 1 Do
        Result := Result + BoolVal10[Options[I].optValue];
End;

Procedure TdevCompiler.LoadSettings;
Var
    s,
    key: String;
    I: Integer;
    opt: TCompilerOption;
Begin
    With devData Do
    Begin
        key := 'Compiler';
        fUseParams := LoadBoolSetting(key, 'UseParams');
        fRunParams := LoadSetting(key, 'RunParams');
        fcmdOpts := LoadSetting(key, 'cmdline');
        flinkopts := LoadSetting(key, 'LinkLine');
        fSaveLog := LoadBoolSetting(key, 'Log');
        s := LoadSetting(key, 'Delay');
        If s <> '' Then
            fDelay := strtointdef(s, 0);

        CompilerSet := StrToIntDef(LoadSetting(key, 'CompilerSet'), 0);

        S := LoadSetting(key, 'Options');
        For I := 0 To fOptions.Count - 1 Do
        Begin
            opt := Options[I];
            If (I < Length(S)) And (StrToIntDef(S[I + 1], 0) = 1) Then
                opt.optValue := 1
            Else
                opt.optValue := 0;
            Options[I] := opt;
        End;

        key := 'Makefile';
        fFastDep := LoadboolSetting(fFastDep, key, 'FastDep');
    End;
End;

Function TdevCompiler.OptionsCount: Integer;
Begin
    Result := fOptions.Count;
End;

Procedure TdevCompiler.SaveSettings;
Var
    S, key: String;
    I: Integer;
Begin
    With devData Do
    Begin
        key := 'Compiler';
        SaveboolSetting(key, 'UseParams', fUseParams);
        SaveSetting(key, 'RunParams', fRunParams);
        SaveSetting(key, 'Delay', inttostr(fDelay));
        SaveBoolSetting(key, 'Log', fSaveLog);

        SaveSetting(key, CP_PROGRAM(CompilerType), fgccName);
        SaveSetting(key, CPP_PROGRAM(CompilerType), fgppName);
        SaveSetting(key, DBG_PROGRAM(CompilerType), fgdbName);
        SaveSetting(key, MAKE_PROGRAM(CompilerType), fmakeName);
        SaveSetting(key, RES_PROGRAM(CompilerType), fwindresName);
        SaveSetting(key, DLL_PROGRAM(CompilerType), fdllwrapName);
        SaveSetting(key, PROF_PROGRAM(CompilerType), fgprofName);
        SaveSetting(key, 'CompilerSet', IntToStr(fCompilerSet));

        S := '';
        For I := 0 To fOptions.Count - 1 Do
            With PCompilerOption(fOptions[I])^ Do
                S := S + BoolVal10[optValue];
        SaveSetting(key, 'Options', S);

        key := 'Makefile';
        SaveBoolSetting(key, 'FastDep', fFastDep);
    End;
End;

Procedure TdevCompiler.SetCompilerSet(Const Value: Integer);
Begin
    If fCompilerSet = Value Then
        Exit;
    If Not Assigned(devCompilerSet) Then
        devCompilerSet := TdevCompilerSet.Create;
    devCompilerSet.LoadSet(Value);
    // Programs
    fCompilerSet := Value;
    If devDirs.OriginalPath = '' Then // first time only
        devDirs.OriginalPath := GetEnvironmentVariable('PATH');
    SetPath(devDirs.Bins);
    devCompilerSet.LoadSet(Value);
    fgccName := devCompilerSet.gccName;
    fgppName := devCompilerSet.gppName;
    fgdbName := devCompilerSet.gdbName;
    fmakeName := devCompilerSet.makeName;
    fwindresName := devCompilerSet.windresName;
    fdllwrapName := devCompilerSet.dllwrapName;
    fgprofName := devCompilerSet.gprofName;
End;

Procedure TdevCompiler.SetOptions(Index: Integer;
    Const Value: TCompilerOption);
Begin
    With TCompilerOption(fOptions[Index]^) Do
    Begin
        optName := Value.optName;
        optIsGroup := Value.optIsGroup;
        optIsC := Value.optIsC;
        optIsCpp := Value.optIsCpp;
        optValue := Value.optValue;
        optSetting := Value.optSetting;
        optSection := Value.optSection;
    End;
End;

Procedure TdevCompiler.SetOptionStr(Const Value: String);
Var
    I: Integer;
Begin
    For I := 0 To fOptions.Count - 1 Do
        If (I < Length(Value)) Then
        Begin
            PCompilerOption(fOptions[I])^.optValue :=
                ConvertCharToValue(Value[I + 1]);
        End;
End;

Function TdevCompiler.ConvertCharToValue(c: Char): Integer;
Begin
    If c In ['a'..'z'] Then
        result := Integer(c) - Integer('a') + 2
    Else
    If (StrToIntDef(c, 0) = 1) Then
        result := 1
    Else
        result := 0;
End;

Procedure TdevCompiler.SettoDefaults;
Begin
    fRunParams := '';
    fUseParams := False;
    fSaveLog := False;
    fcmdOpts := '';
    flinkOpts := '';
    fDelay := 0;

    // makefile
    fFastDep := False;

    // Programs
    fgccName := CP_PROGRAM(CompilerType);
    fgppName := CPP_PROGRAM(CompilerType);
    fgdbName := DBG_PROGRAM(CompilerType);
    fmakeName := MAKE_PROGRAM(CompilerType);
    fwindresName := RES_PROGRAM(CompilerType);
    fgprofName := PROF_PROGRAM(CompilerType);
    fdllwrapName := DLL_PROGRAM(CompilerType);
    fCompilerSet := 0;

    AddDefaultOptions;
End;


{ TDevDirs }

Constructor TdevDirs.Create;
Begin
    Inherited Create;
    Name := OPT_DIRS;
    fCompilerType := 0;
    SettoDefaults;
    LoadSettings;
    fConfig := '';
End;

Procedure TdevDirs.SettoDefaults;
Var
    tempstr: String;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
    dummy: String;
{$ENDIF PLUGIN_BUILD}
Begin
    fBinDir := ValidatePaths(BIN_DIR(fCompilerType), tempstr);
    fCDir := ValidatePaths(C_INCLUDE_DIR(fCompilerType), tempstr);
    fCppDir := ValidatePaths(CPP_INCLUDE_DIR(fCompilerType), tempstr);

    fLibDir := ValidatePaths(LIB_DIR(fCompilerType), tempstr);
{$IFDEF PLUGIN_BUILD}
    fRCDir := ValidatePaths(RC_INCLUDE_DIR(fCompilerType), tempstr);
    If MainForm <> Nil Then
    Begin
        For i := 0 To MainForm.pluginsCount - 1 Do
        Begin
            If (fCppDir = '') Then
                fCppDir := fCppDir +
                    ValidatePaths(MainForm.plugins[i].GET_COMMON_CPP_INCLUDE_DIR, dummy)
            // EAB TODO: make it multiplugin functional.
            Else
                fCppDir := fCppDir + ';' +
                    ValidatePaths(MainForm.plugins[i].GET_COMMON_CPP_INCLUDE_DIR, dummy);
            // EAB TODO: make it multiplugin functional.
        End;
    End;

{$ELSE}
  fRCDir  := '';
{$ENDIF}

    If (fCompilerType = ID_COMPILER_LINUX) Then
    Begin
        fCppDir := '';
        fCDir := '';
        fRCDir := '';
        fBinDir := '/usr/local/sbin;/usr/local/bin;/usr/sbin;/usr/bin;/sbin;/bin';
    End;

    fExec := ExtractFilePath(Application.ExeName);
    If (fConfig = '') Then
        // EAB: workaround because of weird calls from InitializeOptionsAfterPlugins that can't be removed for now, or compiler folders get screwed.
        fConfig := fExec;
    fHelp := fExec + HELP_DIR;
    fIcons := fExec + ICON_DIR;
    fLang := fExec + LANGUAGE_DIR;
    fTemp := fExec + TEMPLATE_DIR;
    fThemes := fExec + THEME_DIR;
    fOldPath := GetEnvironmentVariable('PATH');
End;

Procedure TdevDirs.LoadSettings;
Begin
    devData.LoadObject(Self);
    fExec := ExtractFilePath(Application.ExeName);
    If fHelp = '' Then
        fHelp := fExec + HELP_DIR;
    If fIcons = '' Then
        fIcons := fExec + ICON_DIR;
    If fLang = '' Then
        fLang := fExec + LANGUAGE_DIR;
    If fTemp = '' Then
        fTemp := fExec + TEMPLATE_DIR;
    If fThemes = '' Then
        fThemes := fExec + THEME_DIR;
    FixPaths;
End;

Procedure TdevDirs.SaveSettings;
Begin
    fHelp := ExtractRelativePath(fExec, fHelp);
    fIcons := ExtractRelativePath(fExec, fIcons);
    fLang := ExtractRelativePath(fExec, fLang);
    fTemp := ExtractRelativePath(fExec, fTemp);
    fThemes := ExtractRelativePath(fExec, fThemes);
    devData.SaveObject(Self);
    FixPaths;
End;

Function TdevDirs.CallValidatePaths(dirList: String): String;
Var
    dummy: String;
Begin
    Result := ValidatePaths(dirList, dummy);
End;

Procedure TdevDirs.FixPaths;
Begin
    // if we are called by double-clicking a .dev file in explorer,
    // we must perform the next checks or else the dirs are
    // really screwed up...
    // Basically it checks if it is a relative path (as it should be).
    // If so, it prepends the base Dev-C++ directory...
    If ExtractFileDrive(fHelp) = '' Then
        fHelp := fExec + fHelp;
    If ExtractFileDrive(fIcons) = '' Then
        fIcons := fExec + fIcons;
    If ExtractFileDrive(fLang) = '' Then
        fLang := fExec + fLang;
    If ExtractFileDrive(fTemp) = '' Then
        fTemp := fExec + fTemp;
    If ExtractFileDrive(fThemes) = '' Then
        fThemes := fExec + fThemes;
End;

{ TDevEditor }

Constructor TdevEditor.Create;
Begin
    Inherited;
    Name := OPT_EDITOR;

    fFont := TFont.Create;
    fGutterfont := TFont.Create;
    fSyntax := TStringList.Create;
    TStringList(fSynTax).Duplicates := dupIgnore;
    SettoDefaults;
    LoadSettings;
End;

Destructor TdevEditor.Destroy;
Begin
    If Assigned(fFont) Then
        fFont.Free;
    If Assigned(fGutterfont) Then
        fGutterfont.Free;
    If Assigned(fSynTax) Then
        fSynTax.Free;
    Inherited;
End;

Procedure TdevEditor.LoadSettings;
Begin
    devData.LoadObject(Self);
End;

Procedure TdevEditor.SaveSettings;
Begin
    devData.SaveObject(Self);
End;

Procedure TdevEditor.SettoDefaults;
Begin
    fFont.name := 'Courier New';
    fFont.Size := 10;
    fTabSize := 4;
    fShowGutter := True;
    fCustomGutter := True;
    fGutterSize := 32;
    fGutterFont.Name := 'Terminal';
    fGutterFont.Size := 9;
    fGutterAuto := False;
    GutterGradient := True;

    fInsertCaret := 0;
    fOverwriteCaret := 0;

    fMarginVis := True;
    fMarginSize := 80;
    fMarginColor := cl3DLight;

    fGroupUndo := True;

    fLineNumbers := False;
    fLeadZero := False;
    fFirstisZero := False;
    fEHomeKey := False;

    fShowScrollHint := True;
    fShowScrollbars := True;
    fHalfPage := False;

    fPastEOF := False;
    fPastEOL := False;
    fTrailBlanks := False;
    fdblLine := False;
    fFindText := True;

    fAutoCloseBrace := False; // not working well/turned off

    fInsertMode := True;
    fAutoIndent := True;
    fSmartTabs := False;
    fSmartUnindent := True;
    fTabtoSpaces := True;

    fUseSyn := True;
    //last ; is for files with no extension
    //which should be treated as cpp header files
    fSynExt := 'c;cpp;h;hpp;cc;cxx;cp;hp;rh;inl;';

    fParserHints := True;
    fMatch := False;

    fHighCurrLine := True;
    fHighColor := $FFFFCC; //Light Turquoise

    //fCodeFolding := True;

    fAppendNewline := True;
End;

Procedure TdevEditor.AssignEditor(Editor: TSynEdit);
Var
    pt: TPoint;
    x: Integer;
Begin
    If (Not assigned(Editor)) Or (Not (Editor Is TCustomSynEdit)) Then
        exit;
    With Editor Do
    Begin
        BeginUpdate;
        Try
            TabWidth := fTabSize;

            Font.Assign(fFont);
            With Gutter Do
            Begin
                UseFontStyle := fCustomGutter;
                Font.Assign(fGutterFont);
                Width := fGutterSize;
                Visible := fShowGutter;
                AutoSize := fGutterAuto;
                ShowLineNumbers := fLineNumbers;
                LeadingZeros := fLeadZero;
                ZeroStart := fFirstisZero;
                //Gradient := fGutterGradient;
                x := fSyntax.IndexofName(cGut);
                If x <> -1 Then
                Begin
                    StrtoPoint(pt, fSyntax.Values[cGut]);
                    Color := pt.x;
                    Font.Color := pt.y;
                End;
            End;

            If fMarginVis Then
                RightEdge := fMarginSize
            Else
                RightEdge := 0;

            RightEdgeColor := fMarginColor;

            InsertCaret := TSynEditCaretType(fInsertCaret);
            OverwriteCaret := TSynEditCaretType(fOverwriteCaret);

            ScrollHintFormat := shfTopToBottom;

            If HighCurrLine Then
                ActiveLineColor := HighColor
            Else
                ActiveLineColor := clNone;

            Options := [
                eoAltSetsColumnMode, eoDisableScrollArrows,
                eoDragDropEditing, eoDropFiles, eoKeepCaretX,
                //eoAutoSizeMaxLeftChar was replaced by eoAutoSizeMaxScrollWidth
                eoRightMouseMovesCursor, eoScrollByOneLess, eoAutoSizeMaxScrollWidth
                {eoNoCaret, eoNoSelection, eoScrollHintFollows, }
                ];

            //Optional synedit options in devData
            If fAutoIndent Then
                Options := Options + [eoAutoIndent];
            If fEHomeKey Then
                Options := Options + [eoEnhanceHomeKey];
            If fGroupUndo Then
                Options := Options + [eoGroupUndo];
            If fHalfPage Then
                Options := Options + [eoHalfPageScroll];
            If fShowScrollbars Then
                Options := Options + [eoHideShowScrollbars];
            If fPastEOF Then
                Options := Options + [eoScrollPastEOF];
            If fPastEOL Then
                Options := Options + [eoScrollPastEOL];
            If fShowScrollHint Then
                Options := Options + [eoShowScrollHint];
            If fSmartTabs Then
                Options := Options - [eoSmartTabs];
            If fSmartTabs Then
                Options := Options + [eoSmartTabDelete];
            If fTabtoSpaces Then
                Options := Options + [eoTabsToSpaces];
            If fTrailBlanks Then
                Options := Options + [eoTrimTrailingSpaces];
            If fSpecialChar Then
                Options := Options + [eoShowSpecialChars];

               // Code Folding	 
	      { if (fCodeFolding) then
	       begin	 
	         with CodeFolding do	 
	         begin	 
	                 Enabled := True;	 
	                 IndentGuides := True;	 
	                 CaseSensitive := False;	 
	            //     HighlighterFoldRegions := True;	 
	                 HighlighterFoldRegions := False;	 
	                 FolderBarColor := clDefault;	 
	                 FolderBarLinesColor := clDefault;	 
	                 // CollapsingMarkStyle := TSynCollapsingMarkStyle(0);	 
	 	 
	                 // Code folding	 
	                 with FoldRegions do	 
	                 begin	}
	                //         Add(rtChar, False, False, False, '{', '}', nil);
	                //         Add(rtKeyword, True, True, False, '/*', '*/', nil);
	              {   end;
	 	 
	                 end;	 
	         end	 
	       else	 
	           begin	 
	                 CodeFolding.Enabled := False;	 
	           end;
                   }
        Finally
            EndUpdate;
        End;
    End;
End;


{ TdevCodeCompletion }

Constructor TdevCodeCompletion.Create;
Begin
    Inherited Create;
    Name := 'CodeCompletion';
    fCacheFiles := TStringList.Create;
    SettoDefaults;
    LoadSettings;
End;

Destructor TdevCodeCompletion.Destroy;
Begin
    If Assigned(fCacheFiles) Then
        fCacheFiles.Free;
End;

Procedure TdevCodeCompletion.LoadSettings;
Begin
    devData.LoadObject(Self);
End;

Procedure TdevCodeCompletion.SaveSettings;
Begin
    devData.SaveObject(Self);
End;

Procedure TdevCodeCompletion.SetDelay(Value: Integer);
Begin
    fDelay := Max(1, Value); // minimum 1 msec
End;

Procedure TdevCodeCompletion.SettoDefaults;
Begin
    fWidth := 320;
    fHeight := 240;
    fDelay := 500;
    fBackColor := clWindow;
    fEnabled := True;
    fUseCacheFiles := False;
End;

{ TdevClassBrowsing }

Constructor TdevClassBrowsing.Create;
Begin
    Inherited Create;
    Name := 'ClassBrowsing';
    SettoDefaults;
    LoadSettings;
End;

Procedure TdevClassBrowsing.LoadSettings;
Begin
    devData.LoadObject(Self);
End;

Procedure TdevClassBrowsing.SaveSettings;
Begin
    devData.SaveObject(Self);
End;

Procedure TdevClassBrowsing.SettoDefaults;
Begin
    fCBViewStyle := 0;
    fEnabled := True;
    fParseLocalHeaders := False;
    fParseGlobalHeaders := False;
    fShowFilter := 0;
    fUseColors := True;
    fShowInheritedMembers := False;
End;

{ TdevCVSHandler }

Constructor TdevCVSHandler.Create;
Begin
    Inherited Create;
    Name := 'CVSHandler';
    fRepositories := TStringList.Create;
    SettoDefaults;
    LoadSettings;
End;

Destructor TdevCVSHandler.Destroy;
Begin
    fRepositories.Free;
End;

Procedure TdevCVSHandler.LoadSettings;
Begin
    devData.LoadObject(Self);
End;

Procedure TdevCVSHandler.SaveSettings;
Begin
    devData.SaveObject(Self);
End;

Procedure TdevCVSHandler.SettoDefaults;
Begin
    fExecutable := 'cvs.exe';
    fCompression := 4;
    fUseSSH := True;
End;

{ TdevCompilerSet }
Procedure TdevCompilerSet.LoadDefaultCompilerDefaults;
Begin
    devCompilerSet.BinDir := BIN_DIR(CompilerType);
    devCompilerSet.CDir := C_INCLUDE_DIR(CompilerType);
    devCompilerSet.CppDir := CPP_INCLUDE_DIR(CompilerType);
    devCompilerSet.LibDir := LIB_DIR(CompilerType);

    devDirs.Bins := devCompilerSet.BinDir;
    devDirs.C := devCompilerSet.CDir;
    devDirs.Cpp := devCompilerSet.CppDir;
    devDirs.Lib := devCompilerSet.LibDir;
End;

Procedure TdevCompilerSet.AssignToCompiler;
Var
    tempstr: String;
Begin
    tempstr := '';
    devCompiler.Name := Name;
    devCompiler.gccName := gccName;
    devCompiler.gppName := gppName;
    devCompiler.gdbName := gdbName;
    devCompiler.makeName := makeName;
    devCompiler.windresName := windresName;
    devCompiler.dllwrapName := dllwrapName;
    devCompiler.gprofName := gprofName;
    devCompiler.fcmdOpts := fCmdOptions;
    devCompiler.flinkopts := fLinkOptions;
    devCompiler.fMakeOpts := fMakeOptions;
    devCompiler.compilerType := compilerType;
    devCompiler.CheckSyntaxFormat := CheckSyntaxFormat;
    devCompiler.OutputFormat := OutputFormat;
    devCompiler.ResourceIncludeFormat := ResourceIncludeFormat;
    devCompiler.ResourceFormat := ResourceFormat;
    devCompiler.LinkerFormat := LinkerFormat;
    devCompiler.LinkerPaths := LinkerPaths;
    devCompiler.IncludeFormat := IncludeFormat;
    devCompiler.DllFormat := DllFormat;
    devCompiler.LibFormat := LibFormat;
    devCompiler.PchCreateFormat := PchCreateFormat;
    devCompiler.PchUseFormat := PchUseFormat;
    devCompiler.PchFileFormat := PchFileFormat;
    devCompiler.SingleCompile := SingleCompile;
    devCompiler.PreprocDefines := PreprocDefines;

    // we have to set the devDirs too
    devDirs.Bins := BinDir;
    devDirs.C := CDir;
    devDirs.Cpp := CppDir;
    devDirs.Lib := LibDir;
    devDirs.RC := RCDir;
    devDirs.compilerType := compilerType;

    If ((devCompiler.CompilerType = ID_COMPILER_MINGW) Or
        (devCompiler.CompilerType = ID_COMPILER_LINUX)) Then
    Begin
        OBJ_EXT := '.o';
        LIB_EXT := '.a';
        PCH_EXT := '.h.gch';
    End
    Else
    Begin
        OBJ_EXT := '.obj';
        LIB_EXT := '.lib';
        PCH_EXT := '.pch';
    End;

    devCompiler.AddDefaultOptions;
    devCompiler.OptionStr := OptionsStr;
End;

Constructor TdevCompilerSet.Create;
Begin
    Inherited;
    fSets := TStringList.Create;
    UpdateSets;
    SettoDefaults;
End;

Destructor TdevCompilerSet.Destroy;
Begin
    If Assigned(fSets) Then
        fSets.Free;
    Inherited;
End;

Procedure TdevCompilerSet.LoadSet(Index: Integer);
Begin
    Name := Sets[Index];
    LoadSetProgs(Index);
    LoadSetDirs(Index);
End;

Procedure TdevCompilerSet.LoadSetDirs(Index: Integer);
Var
    key: String;
    goodBinDir, goodCDir, goodCppDir, goodLibDir {$IFDEF PLUGIN_BUILD},
    goodRCDir{$ENDIF}: String;
    msg: String;
    tempStr: String;
    maindir: String;
    makeSig, mingwmakeSig: String;
    defaultDataForPlugins: Boolean;
    dummy: String;
    i: Integer;
Begin
    defaultDataForPlugins := False;
    If Index < 0 Then
        Exit;

    With devData Do
    Begin

        key := OPT_COMPILERSETS + '_' + IntToStr(Index);

        // EAB: Temporary hack to fix Cpp includes in wxdsgn plugin if you enable the devpack after using vanilla version:
        // A proper solution requires more descriptive information of the plugins recent installation status.
        If MainForm <> Nil Then
        Begin
            If MainForm.pluginsCount > 0 Then
            Begin
                Try
                    If (LoadSetting(key, 'wxOpts.Static') = '') Then
                        defaultDataForPlugins := True;
                Except
                    defaultDataForPlugins := True;
                End;
            End;
        End;

        // dirs
        fBinDir := LoadSetting(key, 'Bins');
        If fBinDir = '' Then
            fBinDir := devDirs.Bins;
        fCDir := LoadSetting(key, 'C');
        If fCDir = '' Then
            fCDir := devDirs.C;
        fCppDir := LoadSetting(key, 'Cpp');
        If fCppDir = '' Then
            fCppDir := devDirs.Cpp
        Else
        If defaultDataForPlugins Then
        Begin
            For i := 0 To MainForm.pluginsCount - 1 Do
                fCppDir := fCppDir + ';' +
                    ValidatePaths(MainForm.plugins[i].GET_COMMON_CPP_INCLUDE_DIR, dummy);
        End;
        Begin
        End;
        fLibDir := LoadSetting(key, 'Lib');
        If fLibDir = '' Then
            fLibDir := devDirs.Lib;
        fRcDir := LoadSetting(key, 'RC');
        If fRcDir = '' Then
            fRcDir := devDirs.RC;

        //check for valid paths
        msg := '';
        goodBinDir := ValidatePaths(fBinDir, tempStr);
        If ((tempStr <> '')) Then
        Begin
            msg := msg + 'Following Bin directories don''t exist:' + #13#10;
            msg := msg + StringReplace(tempStr, ';', #13#10, [rfReplaceAll]);
            msg := msg + #13#10 + #13#10;
        End;
        goodCDir := ValidatePaths(fCDir, tempStr);
        If ((tempStr <> '')) Then
        Begin
            msg := msg + 'Following C Include directories don''t exist:' + #13#10;
            msg := msg + StringReplace(tempStr, ';', #13#10, [rfReplaceAll]);
            msg := msg + #13#10 + #13#10;
        End;
        goodCppDir := ValidatePaths(fCppDir, tempStr);
        If ((tempStr <> '')) Then
        Begin
            msg := msg + 'Following C++ Include directories don''t exist:' + #13#10;
            msg := msg + StringReplace(tempStr, ';', #13#10, [rfReplaceAll]);
            msg := msg + #13#10 + #13#10;
        End;
        goodLibDir := ValidatePaths(fLibDir, tempStr);
        If ((tempStr <> '')) Then
        Begin
            msg := msg + 'Following Libs directories don''t exist:' + #13#10;
            msg := msg + StringReplace(tempStr, ';', #13#10, [rfReplaceAll]);
            msg := msg + #13#10 + #13#10;
        End;
     {$IFDEF PLUGIN_BUILD}

        goodRCDir := ValidatePaths(fRCDir, tempStr);
        If tempStr <> '' Then
        Begin
            msg := msg + 'Following resource compiler directories don''t exist:'
                + #13#10;
            msg := msg + StringReplace(tempStr, ';', #13#10, [rfReplaceAll]);
            msg := msg + #13#10 + #13#10;
        End;
     {$ENDIF}

    End;

    //check if make is in path + bins directory
    SetPath(devDirs.Bins);

End;

Procedure TdevCompilerSet.LoadSetProgs(Index: Integer);
Var
    key: String;
Begin

    If Index < 0 Then
        Exit;
    With devData Do
    Begin
        key := OPT_COMPILERSETS + '_' + IntToStr(Index);
        If (LoadSetting(key, 'CompilerType') <> '') Then
            fCompilerType := StrToIntDef(LoadSetting(key, 'CompilerType'), 0);
        self.SetToDefaults;

        // Programs
        fgccName := LoadSetting(key, CP_PROGRAM(CompilerType));
        If fgccName = '' Then
            fgccName := CP_PROGRAM(CompilerType);
        fgppName := LoadSetting(key, CPP_PROGRAM(CompilerType));
        If fgppName = '' Then
            fgppName := CPP_PROGRAM(CompilerType);
        fgdbName := LoadSetting(key, DBG_PROGRAM(CompilerType));
        If fgdbName = '' Then
            fgdbName := DBG_PROGRAM(CompilerType);
        fmakeName := LoadSetting(key, MAKE_PROGRAM(CompilerType));
        If fmakeName = '' Then
            fmakeName := MAKE_PROGRAM(CompilerType);
        fwindresName := LoadSetting(key, RES_PROGRAM(CompilerType));
        If fwindresName = '' Then
            fwindresName := RES_PROGRAM(CompilerType);
        fgprofName := LoadSetting(key, PROF_PROGRAM(CompilerType));
        If fgprofName = '' Then
            fgprofName := PROF_PROGRAM(CompilerType);
        fdllwrapName := LoadSetting(key, DLL_PROGRAM(CompilerType));
        If fdllwrapName = '' Then
            fdllwrapName := DLL_PROGRAM(CompilerType);

        fOptions := LoadSetting(key, 'Options');
        fCmdOptions := LoadSetting(key, 'cmdline');
        If (fCmdOptions = '') Then
            fCmdOptions := COMPILER_CMD_LINE(CompilerType);

        fLinkOptions := LoadSetting(key, 'LinkLine');
        If (fLinkOptions = '') Then
            fLinkOptions := LINKER_CMD_LINE(CompilerType);

        fMakeOptions := LoadSetting(key, 'MakeLine');
        If (fMakeOptions = '') Then
            fMakeOptions := MAKE_CMD_LINE(CompilerType);

        If LoadSetting(key, 'CheckSyntax') <> '' Then
            fCheckSyntaxFormat := LoadSetting(key, 'CheckSyntax');
        If LoadSetting(key, 'OutputFormat') <> '' Then
            fOutputFormat := LoadSetting(key, 'OutputFormat');
        If LoadSetting(key, 'ResourceInclude') <> '' Then
            fResourceIncludeFormat := LoadSetting(key, 'ResourceInclude');
        If LoadSetting(key, 'ResourceFormat') <> '' Then
            fResourceFormat := LoadSetting(key, 'ResourceFormat');
        If LoadSetting(key, 'LinkerFormat') <> '' Then
            fLinkerFormat := LoadSetting(key, 'LinkerFormat');
        If LoadSetting(key, 'LinkerPaths') <> '' Then
            LinkerPaths := LoadSetting(key, 'LinkerPaths');
        If LoadSetting(key, 'IncludeFormat') <> '' Then
            fIncludeFormat := LoadSetting(key, 'IncludeFormat');
        If LoadSetting(key, 'DllFormat') <> '' Then
            fDllFormat := LoadSetting(key, 'DllFormat');
        If LoadSetting(key, 'LibFormat') <> '' Then
            fLibFormat := LoadSetting(key, 'LibFormat');
        If LoadSetting(key, 'SingleCompile') <> '' Then
            fSingleCompile := LoadSetting(key, 'SingleCompile');
        If LoadSetting(key, 'PreprocDefines') <> '' Then
            fPreprocDefines := LoadSetting(key, 'PreprocDefines');
        If LoadSetting(key, 'PchCreateFormat') <> '' Then
            fPchCreateFormat := LoadSetting(key, 'PchCreateFormat');
        If LoadSetting(key, 'PchUseFormat') <> '' Then
            fPchUseFormat := LoadSetting(key, 'PchUseFormat');
        If LoadSetting(key, 'PchFileFormat') <> '' Then
            fPchFileFormat := LoadSetting(key, 'PchFileFormat');

{$IFDEF PLUGIN_BUILD}// Loading Compiler settings:
        optComKey := key;
{$ENDIF PLUGIN_BUILD}
    End;
End;

Procedure TdevCompilerSet.LoadSettings;
Begin
    LoadSet(0);
End;

Procedure TdevCompilerSet.SaveSet(Index: Integer);
Begin
    SaveSetProgs(Index);
    SaveSetDirs(Index);
End;

Procedure TdevCompilerSet.SaveSetDirs(Index: Integer);
Var
    key: String;
Begin
    If Index < 0 Then
        Exit;
    With devData Do
    Begin
        key := OPT_COMPILERSETS + '_' + IntToStr(Index);
        // dirs

        SaveSetting(key, 'Bins', fBinDir);
        SaveSetting(key, 'C', fCDir);
        SaveSetting(key, 'Cpp', fCppDir);
        SaveSetting(key, 'Lib', fLibDir);
        SaveSetting(key, 'RC', fRcDir);
    End;
End;

Procedure TdevCompilerSet.SaveSetProgs(Index: Integer);
Var
    key: String;
{$IFDEF PLUGIN_BUILD}
    i, j: Integer;
    pluginSettings: TSettings;
{$ENDIF PLUGIN_BUILD}
Begin
    If Index < 0 Then
        Exit;
    With devData Do
    Begin
        key := OPT_COMPILERSETS + '_' + IntToStr(Index);
        // Programs
        SaveSetting(key, CP_PROGRAM(CompilerType), fgccName);
        SaveSetting(key, CPP_PROGRAM(CompilerType), fgppName);
        SaveSetting(key, DBG_PROGRAM(CompilerType), fgdbName);
        SaveSetting(key, MAKE_PROGRAM(CompilerType), fmakeName);
        SaveSetting(key, RES_PROGRAM(CompilerType), fwindresName);
        SaveSetting(key, PROF_PROGRAM(CompilerType), fgprofName);
        SaveSetting(key, DLL_PROGRAM(CompilerType), fdllwrapName);
        SaveSetting(key, 'Options', fOptions);
        SaveSetting(key, 'cmdline', fCmdOptions);
        SaveSetting(key, 'LinkLine', fLinkOptions);
        SaveSetting(key, 'MakeLine', fMakeOptions);
        SaveSetting(key, 'CompilerType', IntToStr(fCompilerType));

        SaveSetting(key, 'CheckSyntax', fCheckSyntaxFormat);
        SaveSetting(key, 'OutputFormat', fOutputFormat);
        SaveSetting(key, 'ResourceInclude', fResourceIncludeFormat);
        SaveSetting(key, 'ResourceFormat', fResourceFormat);
        SaveSetting(key, 'LinkerFormat', fLinkerFormat);
        SaveSetting(key, 'LinkerPaths', LinkerPaths);
        SaveSetting(key, 'IncludeFormat', fIncludeFormat);
        SaveSetting(key, 'DllFormat', fDllFormat);
        SaveSetting(key, 'LibFormat', fLibFormat);
        SaveSetting(key, 'PchCreateFormat', PchCreateFormat);
        SaveSetting(key, 'PchUseFormat', PchUseFormat);
        SaveSetting(key, 'PchFileFormat', PchFileFormat);
        SaveSetting(key, 'SingleCompile', fSingleCompile);
        SaveSetting(key, 'PreprocDefines', fPreprocDefines);

{$IFDEF PLUGIN_BUILD}
        If MainForm <> Nil Then
        Begin
            For i := 0 To MainForm.pluginsCount - 1 Do
            Begin
                pluginSettings := MainForm.plugins[i].GetCompilerOptions;
                For j := 0 To Length(pluginSettings) - 1 Do
                    SaveSetting(key, pluginSettings[j].name,
                        pluginSettings[j].value);
            End;
        End;
{$ENDIF PLUGIN_BUILD}
    End;
End;

Procedure TdevCompilerSet.SaveSettings;
Begin
    WriteSets;
End;

Function TdevCompilerSet.SetName(Index: Integer): String;
Begin
    If (Index >= 0) And (Index < devCompilerSet.Sets.Count) Then
        Result := devCompilerSet.Sets[Index]
    Else
        Result := DEFCOMPILERSET(CompilerType);
End;

Procedure TdevCompilerSet.SettoDefaults;
Var
    tempstr: String;
Begin

    tempstr := '';
    // Programs
    fgccName := CP_PROGRAM(CompilerType);
    fgppName := CPP_PROGRAM(CompilerType);
    fgdbName := DBG_PROGRAM(CompilerType);
    fmakeName := MAKE_PROGRAM(CompilerType);
    fwindresName := RES_PROGRAM(CompilerType);
    fgprofName := PROF_PROGRAM(CompilerType);
    fdllwrapName := DLL_PROGRAM(CompilerType);
    fCmdOptions := '';
    fLinkOptions := '';
    fMakeOptions := '';

    If CompilerType In ID_COMPILER_VC Then
    Begin
        fCheckSyntaxFormat := '/Zs %s';
        fOutputFormat := '/c %s /Fo%s';
        fResourceIncludeFormat := '/I"%s"';
        fResourceFormat := '/r /fo%s';
        fLinkerFormat := '/out:"%s"';
        fLinkerPaths := '/libpath:"%s"';
        fIncludeFormat := '/I"%s"';
        fDllFormat := '/dll /implib:%s /out:%s';
        fLibFormat := '/lib /nologo /out:"%s"';
        fPchCreateFormat := '/Yc%s';
        fPchUseFormat := '/Yu%s';
        fPchFileFormat := '/Fp%s';
        fSingleCompile := '%s /nologo "%s" %s %s /link %s';
        fPreprocDefines := '/D%s';
    End
    Else
    If CompilerType = ID_COMPILER_DMARS Then
    Begin
        fCheckSyntaxFormat := '/Zs %s';
        fOutputFormat := '-c %s -o%s';
        fResourceIncludeFormat := '-I"%s"';
        fResourceFormat := '-32 -o%s';
        //Linker CmdLine Paramater
        //link <link flags> <objects>,<exename>,<mapfile>,lib1 lib2 \my\lib\path\  lib3 lib4 lib5,<def file>,<res file>
        fLinkerFormat := ',"%s"';
        fLinkerPaths := ' "%s" ';
        fIncludeFormat := '-I"%s"';
        fDllFormat := '/dll /implib:%s /out:%s';
        fLibFormat := '/lib /out:"%s"';
        fPchCreateFormat := '/Yc%s';
        fPchUseFormat := '/Yu%s';
        fPchFileFormat := '/Fp%s';
        fSingleCompile := '%s "%s" %s %s /link %s';
        fPreprocDefines := '-D%s';
    End
    Else
    If ((CompilerType = ID_COMPILER_MINGW) Or
        (CompilerType = ID_COMPILER_LINUX)) Then
    Begin
        fCheckSyntaxFormat := '-fsyntax-only %s';
        fOutputFormat := '-c %s -o %s';
        fResourceIncludeFormat := '--include-dir "%s"';
        fResourceFormat := '--input-format=rc -o %s -O coff';
        fLinkerFormat := '-o "%s"';
        fLinkerPaths := '-L"%s"';
        fIncludeFormat := '-I"%s"';
        fDllFormat := '-Wl,--out-implib,%s -o %s';
        fLibFormat := 'rcu "%s"';
        fPchCreateFormat := '';
        fPchUseFormat := '';
        fPchFileFormat := '';
        fSingleCompile := '%s "%s" -o "%s" %s %s %s';
        fPreprocDefines := '-D%s';
    End;

    // dirs
    fBinDir := devDirs.Bins;
    fCDir := devDirs.C;
    fCppDir := devDirs.Cpp;
    // + ';' + ValidatePaths(CPP_INCLUDE_DIR(fCompilerType), tempstr);   // EAB TODO: Check if this is a good solution for plugins and COMMON_CPP_INCLUDE_DIR
    fLibDir := devDirs.Lib;
    fRCDir := devDirs.RC;

End;

Procedure TdevCompilerSet.UpdateSets;
Var
    Ini: TIniFile;
    sl: TStringList;
    I: Integer;
Begin
    fSets.Clear;
    Ini := TIniFile.Create(devData.INIFile);
    sl := TStringList.Create;
    Try
        Ini.ReadSectionValues(OPT_COMPILERSETS, sl);

        For I := 0 To sl.Count - 1 Do
            fSets.Add(sl.Values[sl.Names[I]]);

    Finally
        sl.Free;
        Ini.Free;
    End;
End;

Procedure TdevCompilerSet.WriteSets;
Var
    Ini: TIniFile;
    I: Integer;
Begin
    Ini := TIniFile.Create(devData.INIFile);
    Try
        Ini.EraseSection(OPT_COMPILERSETS);
        For I := 0 To fSets.Count - 1 Do
            Ini.WriteString(OPT_COMPILERSETS, IntToStr(I), fSets[I]);
    Finally
        Ini.Free;
    End;
End;

{ TdevExternalPrograms }

Function TdevExternalPrograms.AddProgram(ext, prog: String): Integer;
Var
    idx: Integer;
Begin
    If ext = '' Then
    Begin
        Result := -1;
        Exit;
    End;

    idx := AssignedProgram(ext);
    If idx = -1 Then
        Result := fPrograms.Add(ext + '=' + prog)
    Else
    Begin
        fPrograms.Values[fPrograms.Names[idx]] := prog;
        Result := idx;
    End;
End;

Function TdevExternalPrograms.AssignedProgram(ext: String): Integer;
Var
    I: Integer;
Begin
    Result := -1;
    For I := 0 To fPrograms.Count - 1 Do
        If UpperCase(fPrograms.Names[I]) = UpperCase(ext) Then
        Begin
            Result := I;
            Break;
        End;
End;

Constructor TdevExternalPrograms.Create;
Begin
    Inherited Create;
    Name := 'ExternalPrograms';
    fPrograms := TStringList.Create;
    SettoDefaults;
    LoadSettings;
End;

Destructor TdevExternalPrograms.Destroy;
Begin
    If Assigned(fPrograms) Then
        fPrograms.Free;
End;

Function TdevExternalPrograms.GetProgramName(Index: Integer): String;
Begin
    Result := fPrograms.Values[fPrograms.Names[Index]];
End;

Procedure TdevExternalPrograms.LoadSettings;
Begin
    devData.LoadObject(Self);
End;

Procedure TdevExternalPrograms.SaveSettings;
Begin
    devData.SaveObject(Self);
End;

Procedure TdevExternalPrograms.SetToDefaults;
Begin
    Inherited;

End;

{$IFDEF PLUGIN_BUILD}
{ TdevPluginToolbarsX }

Function TdevPluginToolbarsX.AddToolbarsX(plugin_name: String;
    x: Integer): Integer;
Var
    idx: Integer;
Begin
    If plugin_name = '' Then
    Begin
        Result := -1;
        Exit;
    End;

    idx := AssignedToolbarsX(plugin_name);
    If idx = -1 Then
        Result := fPluginToolbarsX.Add(plugin_name + '=' + IntToStr(x))
    Else
    Begin
        fPluginToolbarsX.Values[fPluginToolbarsX.Names[idx]] := IntToStr(x);
        Result := idx;
    End;
End;

Function TdevPluginToolbarsX.AssignedToolbarsX(plugin_name: String): Integer;
Var
    I: Integer;
Begin
    Result := -1;
    For I := 0 To fPluginToolbarsX.Count - 1 Do
        If UpperCase(fPluginToolbarsX.Names[I]) = UpperCase(plugin_name) Then
        Begin
            Result := I;
            Break;
        End;
End;

Constructor TdevPluginToolbarsX.Create;
Begin
    Inherited Create;
    Name := 'ToolbarsX';
    fPluginToolbarsX := TStringList.Create;
    SettoDefaults;
    LoadSettings;
End;

Destructor TdevPluginToolbarsX.Destroy;
Begin
    If Assigned(fPluginToolbarsX) Then
        fPluginToolbarsX.Free;
End;

Function TdevPluginToolbarsX.GetToolbarsXName(Index: Integer): String;
Begin
    Result := fPluginToolbarsX.Values[fPluginToolbarsX.Names[Index]];
End;

Procedure TdevPluginToolbarsX.LoadSettings;
Begin
    devData.LoadObject(Self);
End;

Procedure TdevPluginToolbarsX.SaveSettings;
Begin
    devData.SaveObject(Self);
End;

Procedure TdevPluginToolbarsX.SetToDefaults;
Begin
    Inherited;

End;

{ TdevPluginToolbarsY }

Function TdevPluginToolbarsY.AddToolbarsY(plugin_name: String;
    y: Integer): Integer;
Var
    idx: Integer;
Begin
    If plugin_name = '' Then
    Begin
        Result := -1;
        Exit;
    End;

    idx := AssignedToolbarsY(plugin_name);
    If idx = -1 Then
        Result := fPluginToolbarsY.Add(plugin_name + '=' + IntToStr(y))
    Else
    Begin
        fPluginToolbarsY.Values[fPluginToolbarsY.Names[idx]] := IntToStr(y);
        Result := idx;
    End;
End;

Function TdevPluginToolbarsY.AssignedToolbarsY(plugin_name: String): Integer;
Var
    I: Integer;
Begin
    Result := -1;
    For I := 0 To fPluginToolbarsY.Count - 1 Do
        If UpperCase(fPluginToolbarsY.Names[I]) = UpperCase(plugin_name) Then
        Begin
            Result := I;
            Break;
        End;
End;

Constructor TdevPluginToolbarsY.Create;
Begin
    Inherited Create;
    Name := 'ToolbarsY';
    fPluginToolbarsY := TStringList.Create;
    SettoDefaults;
    LoadSettings;
End;

Destructor TdevPluginToolbarsY.Destroy;
Begin
    If Assigned(fPluginToolbarsY) Then
        fPluginToolbarsY.Free;
End;

Function TdevPluginToolbarsY.GetToolbarsYName(Index: Integer): String;
Begin
    Result := fPluginToolbarsY.Values[fPluginToolbarsY.Names[Index]];
End;

Procedure TdevPluginToolbarsY.LoadSettings;
Begin
    devData.LoadObject(Self);
End;

Procedure TdevPluginToolbarsY.SaveSettings;
Begin
    devData.SaveObject(Self);
End;

Procedure TdevPluginToolbarsY.SetToDefaults;
Begin
    Inherited;

End;
{$ENDIF PLUGIN_BUILD}

Initialization

Finalization
    fdevData.Free;
    devCompiler.Free;
    devCompilerSet.Free;
    devDirs.Free;
    devEditor.Free;
    devCodeCompletion.Free;
    devClassBrowsing.Free;
    devCVSHandler.Free;
    devExternalPrograms.Free;

End.
