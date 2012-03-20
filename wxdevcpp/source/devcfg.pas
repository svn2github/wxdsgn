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

unit devcfg;
interface

uses
{$IFDEF WIN32}
    Dialogs, Windows, Classes, Graphics, SynEdit, CFGData, CFGTypes,
    IniFiles, prjtypes; //, SynEditCodeFolding;  //, DbugIntf; EAB removed Gexperts debug stuff.
{$ENDIF}
{$IFDEF LINUX}
  QDialogs, Classes, QGraphics, QSynEdit, CFGData, CFGTypes, IniFiles, prjtypes;
{$ENDIF}

const
    BoolValYesNo: array[boolean] of string = ('No', 'Yes');
    BoolVal10: array[0..27] of string =
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

type
    // the comments are an example of the record
    PCompilerOption = ^TCompilerOption;
    TCompilerOption = packed record
        optName: string; // "Generate debugging info"
        optIsGroup: boolean; // False
        optIsC: boolean; // True  (C option?)
        optIsCpp: boolean; // True (C++ option?) - can be both C and C++ option...
        optIsLinker: boolean; // Is it a linker param
        optValue: integer; // True
        optSetting: string; // "-g3"
        optSection: string; // "Linker options"
        optExcludeFromTypes: TProjTypeSet;
        // [dptGUI] (don't show option if project is of type dptGUI)
        optChoices: TStringList;
        // replaces "Yes/No" standard choices (max 26 different choices)
    end;

    // compiler-set configuration
    TdevCompilerSet = class(TCFGOptions)
    private
        fSets: TStrings;
        fgccName: string;
        fgppName: string;
        fgdbName: string;
        fmakeName: string;
        fwindresName: string;
        fdllwrapName: string;
        fgprofName: string;

        fBinDir: string;
        fCDir: string;
        fCppDir: string;
        fLibDir: string;
        fRCDir: string;
        fOptions: string;
        fCompilerType: integer;

        fLinkerPaths: string;
        fDllFormat: string;
        fLibFormat: string;
        fPreprocDefines: string;
        fCmdOptions: string;
        fLinkOptions: string;
        fMakeOptions: string;

        fCheckSyntaxFormat: string;
        fOutputFormat: string;
        fResourceIncludeFormat: string;
        fResourceFormat: string;
        fLinkerFormat: string;
        fIncludeFormat: string;
        fPchCreateFormat: string;
        fPchUseFormat: string;
        fPchFileFormat: string;
        fSingleCompile: string;

        //Private ctor and dtor, since we are singletons
        constructor Create;

        procedure WriteSets;
        procedure UpdateSets;

    public
{$IFDEF PLUGIN_BUILD}
        optComKey: string;
{$ENDIF PLUGIN_BUILD}
  	     destructor Destroy; override;
        procedure SettoDefaults; override;
        procedure SaveSettings; override;
        procedure LoadSettings; override;
        procedure SaveSet(Index: integer);
        procedure SaveSetDirs(Index: integer);
        procedure SaveSetProgs(Index: integer);
        procedure LoadSet(Index: integer);
        procedure LoadSetDirs(Index: integer);
        procedure LoadSetProgs(Index: integer);
        procedure LoadDefaultCompilerDefaults;
        procedure AssignToCompiler;
        function SetName(Index: integer): string;

        property Name;
        property Sets: TStrings read fSets write fSets;

    published
        property CompilerType: integer read fCompilerType write fCompilerType;
        property CheckSyntaxFormat: string
            read fCheckSyntaxFormat write fCheckSyntaxFormat;
        property OutputFormat: string read fOutputFormat write fOutputFormat;
        property PchCreateFormat: string read fPchCreateFormat
            write fPchCreateFormat;
        property PchUseFormat: string read fPchUseFormat write fPchUseFormat;
        property PchFileFormat: string read fPchFileFormat write fPchFileFormat;
        property ResourceIncludeFormat: string
            read fResourceIncludeFormat write fResourceIncludeFormat;
        property ResourceFormat: string read fResourceFormat write fResourceFormat;
        property LinkerFormat: string read fLinkerFormat write fLinkerFormat;
        property LinkerPaths: string read fLinkerPaths write fLinkerPaths;
        property IncludeFormat: string read fIncludeFormat write fIncludeFormat;
        property DllFormat: string read fDllFormat write fDllFormat;
        property LibFormat: string read fLibFormat write fLibFormat;
        property SingleCompile: string read fSingleCompile write fSingleCompile;
        property PreprocDefines: string read fPreprocDefines write fPreprocDefines;

        property gccName: string read fgccName write fgccName;
        property gppName: string read fgppName write fgppName;
        property gdbName: string read fgdbName write fgdbName;
        property makeName: string read fmakeName write fmakeName;
        property windresName: string read fwindresName write fwindresName;
        property dllwrapName: string read fdllwrapName write fdllwrapName;
        property gprofName: string read fgprofName write fgprofName;

        property BinDir: string read fBinDir write fBinDir;
        property CDir: string read fCDir write fCDir;
        property CppDir: string read fCppDir write fCppDir;
        property LibDir: string read fLibDir write fLibDir;
        property RCDir: string read fRCDir write fRCDir;
        property OptionsStr: string read fOptions write fOptions; //0, 1, a-z list
        property CmdOpts: string read fCmdOptions write fCmdOptions;
        //Manual commands
        property LinkOpts: string read fLinkOptions write fLinkOptions;
        //Manual commands
        property MakeOpts: string read fMakeOptions write fMakeOptions;
    end;

    // compiler options
    TdevCompiler = class(TCFGOptions)
    private
        fUseParams: boolean;   // Use fparams when running prog
        fRunParams: string;    // params to send on execution

        // program filenames
        fgccName: string;
        fgppName: string;
        fgdbName: string;
        fmakeName: string;
        fwindresName: string;
        fgprofName: string;
        fdllwrapName: string;
        fCompilerSet: integer;
        fCompilerType: integer;
        fLinkerFormat: string;
        fLinkerPaths: string;
        fIncludeFormat: string;
        fSingleCompile: string;
        fPreprocDefines: string;

        fCheckSyntaxFormat: string;
        fOutputFormat: string;
        fResourceIncludeFormat: string;
        fResourceFormat: string;
        fDllFormat: string;
        fLibFormat: string;
        fPchCreateFormat: string;
        fPchUseFormat: string;
        fPchFileFormat: string;

        //Compiler options
        fOptions: TList;

        //Makefile
        fFastDep: boolean;

        fcmdOpts: string;  // command-line adds for compiler
        flinkopts: string; // command-line adds for linker
        fMakeOpts: string;
	       //fwxOpts: TdevWxOptions;    
        fSaveLog: boolean; // Save Compiler Output
        fDelay: integer;   // delay in milliseconds -- for compiling

        //Private constructors for singletons
        constructor Create;

        procedure SetCompilerSet(const Value: integer);
        function GetOptions(Index: integer): TCompilerOption;
        procedure SetOptions(Index: integer; const Value: TCompilerOption);

        function GetOptionStr: string;
        procedure SetOptionStr(const Value: string);

    published
        procedure AddDefaultOptions;

    public
        destructor Destroy; override;
        function OptionsCount: integer;
        function FindOption(Setting: string; var opt: TCompilerOption;
            var Index: integer): boolean; // returns the option with setting=<Setting>
        function ConvertCharToValue(c: char): integer;
        procedure AddOption(_Name: string;
            _IsGroup, _IsC, _IsCpp, IsLinker: boolean; _Value: integer;
            _Setting, _Section: string; ExcludeFromTypes: TProjTypeSet;
            Choices: TStringList);
        procedure SettoDefaults; override;
        procedure SaveSettings; override;
        procedure LoadSettings; override;
        procedure ClearOptions;
        procedure DeleteOption(Index: integer);

        property Name;
        property Options[Index: integer]: TCompilerOption
            read GetOptions write SetOptions;
        property OptionStr: string read GetOptionStr write SetOptionStr;

    published
        property CmdOpts: string read fcmdOpts write fcmdOpts;
        property LinkOpts: string read flinkOpts write flinkOpts;
        property MakeOpts: string read fMakeOpts write fMakeOpts;
	       //property WxOpts: TdevWxOptions read fWxOpts write fWxOpts;
        property FastDep: boolean read fFastDep write fFastDep;

        property CompilerType: integer read fCompilerType write fCompilerType;
        property CheckSyntaxFormat: string
            read fCheckSyntaxFormat write fCheckSyntaxFormat;
        property OutputFormat: string read fOutputFormat write fOutputFormat;
        property PchCreateFormat: string read fPchCreateFormat
            write fPchCreateFormat;
        property PchUseFormat: string read fPchUseFormat write fPchUseFormat;
        property PchFileFormat: string read fPchFileFormat write fPchFileFormat;
        property ResourceIncludeFormat: string
            read fResourceIncludeFormat write fResourceIncludeFormat;
        property ResourceFormat: string read fResourceFormat write fResourceFormat;
        property LinkerFormat: string read fLinkerFormat write fLinkerFormat;
        property LinkerPaths: string read fLinkerPaths write fLinkerPaths;
        property IncludeFormat: string read fIncludeFormat write fIncludeFormat;
        property DllFormat: string read fDllFormat write fDllFormat;
        property LibFormat: string read fLibFormat write fLibFormat;
        property SingleCompile: string read fSingleCompile write fSingleCompile;
        property PreprocDefines: string read fPreprocDefines write fPreprocDefines;

        property RunParams: string read fRunParams write fRunParams;
        property UseExecParams: boolean read fUseParams write fUseParams;
        property SaveLog: boolean read fSaveLog write fSaveLog;
        property Delay: integer read fDelay write fDelay;

        property gccName: string read fgccName write fgccName;
        property gppName: string read fgppName write fgppName;
        property gdbName: string read fgdbName write fgdbName;
        property makeName: string read fmakeName write fmakeName;
        property windresName: string read fwindresName write fwindresName;
        property dllwrapName: string read fdllwrapName write fdllwrapName;
        property gprofName: string read fgprofName write fgprofName;
        property CompilerSet: integer read fCompilerSet write SetCompilerSet;
    end;

    // code-completion window size and other config
    TdevCodeCompletion = class(TCFGOptions)
    private
        fWidth: integer;
        fHeight: integer;
        fDelay: integer;
        fBackColor: integer;
        fEnabled: boolean;
        fUseCacheFiles: boolean;
        fCacheFiles: TStrings;
        procedure SetDelay(Value: integer);
    public
        constructor Create;
        destructor Destroy; override;
        procedure SettoDefaults; override;
        procedure SaveSettings; override;
        procedure LoadSettings; override;
        property Name;
    published
        property Width: integer read fWidth write fWidth;
        property Height: integer read fHeight write fHeight;
        property Delay: integer read fDelay write SetDelay;
        property BackColor: integer read fBackColor write fBackColor;
        property Enabled: boolean read fEnabled write fEnabled;
        property UseCacheFiles: boolean read fUseCacheFiles write fUseCacheFiles;
        property CacheFiles: TStrings read fCacheFiles write fCacheFiles;
    end;

    // class-browsing view style
    TdevClassBrowsing = class(TCFGOptions)
    private
        fCBViewStyle: integer;
        fEnabled: boolean;
        fParseLocalHeaders: boolean;
        fParseGlobalHeaders: boolean;
        fShowFilter: integer; // 0 - show all, 1 - show project, 2 - show current
        fUseColors: boolean;
        fShowInheritedMembers: boolean;
    public
        constructor Create;
        procedure SettoDefaults; override;
        procedure SaveSettings; override;
        procedure LoadSettings; override;
        property Name;
    published
        property Enabled: boolean read fEnabled write fEnabled;
        property ViewStyle: integer read fCBViewStyle write fCBViewStyle;
        property ParseLocalHeaders: boolean
            read fParseLocalHeaders write fParseLocalHeaders;
        property ParseGlobalHeaders: boolean
            read fParseGlobalHeaders write fParseGlobalHeaders;
        property ShowFilter: integer read fShowFilter write fShowFilter;
        property UseColors: boolean read fUseColors write fUseColors;
        property ShowInheritedMembers: boolean
            read fShowInheritedMembers write fShowInheritedMembers;
    end;

    // CVS handling module
    TdevCVSHandler = class(TCFGOptions)
    private
        fRepositories: TStrings;
        fExecutable: string;
        fCompression: byte;
        fUseSSH: boolean;
    public
        constructor Create;
        destructor Destroy; override;
        procedure SettoDefaults; override;
        procedure SaveSettings; override;
        procedure LoadSettings; override;
        property Name;
    published
        property Repositories: TStrings read fRepositories write fRepositories;
        property Executable: string read fExecutable write fExecutable;
        property Compression: byte read fCompression write fCompression;
        property UseSSH: boolean read fUseSSH write fUseSSH;
    end;

    TdevExternalPrograms = class(TCFGOptions)
    private
        fDummy: boolean;
        fPrograms: TStrings;
        function GetProgramName(Index: integer): string;
    public
        constructor Create;
        destructor Destroy; override;
        procedure SaveSettings; override;
        procedure LoadSettings; override;
        procedure SetToDefaults; override;
        property Name;
        property ProgramName[Index: integer]: string read GetProgramName;
        function AssignedProgram(ext: string): integer;
        function AddProgram(ext, prog: string): integer;
    published
        property Dummy: boolean read fDummy write fDummy;
        property Programs: TStrings read fPrograms write fPrograms;
    end;
 {$IFDEF PLUGIN_BUILD}
    TdevPluginToolbarsX = class(TCFGOptions)
    private
        fDummy: boolean;
        fPluginToolbarsX: TStrings;
        function GetToolbarsXName(Index: integer): string;
    public
        constructor Create;
        destructor Destroy; override;
        procedure SaveSettings; override;
        procedure LoadSettings; override;
        procedure SetToDefaults; override;
        property Name;
        property ToolbarsXName[Index: integer]: string read GetToolbarsXName;
        function AssignedToolbarsX(plugin_name: string): integer;
        function AddToolbarsX(plugin_name: string; x: integer): integer;
    published
        property Dummy: boolean read fDummy write fDummy;
        property PluginToolbarsX: TStrings read fPluginToolbarsX
            write fPluginToolbarsX;
    end;

    TdevPluginToolbarsY = class(TCFGOptions)
    private
        fDummy: boolean;
        fPluginToolbarsY: TStrings;
        function GetToolbarsYName(Index: integer): string;
    public
        constructor Create;
        destructor Destroy; override;
        procedure SaveSettings; override;
        procedure LoadSettings; override;
        procedure SetToDefaults; override;
        property Name;
        property ToolbarsYName[Index: integer]: string read GetToolbarsYName;
        function AssignedToolbarsY(plugin_name: string): integer;
        function AddToolbarsY(plugin_name: string; y: integer): integer;
    published
        property Dummy: boolean read fDummy write fDummy;
        property PluginToolbarsY: TStrings read fPluginToolbarsY
            write fPluginToolbarsY;
    end;
{$ENDIF PLUGIN_BUILD}

    // global directories
    TdevDirs = class(TCFGOptions)
    private
        fCompilerType: integer;
        fThemes: string; // Themes Directory
        fIcons: string; // Icon Library
        fHelp: string; // Help
        fLang: string; // Language
        fTemp: string; // Templates
        fDefault: string; // user defined default
        fExec: string; // dev-c start
        fConfig: string; // config files directory
        fBinDir: string; // compiler location
        fCDir: string; // c includes
        fCppDir: string; // c++ includes
        fLibDir: string; // Libraries
        fRCDir: string; // Resource includes
        fOldPath: string; // Enviroment Path at program start
        procedure FixPaths;
    public
        constructor Create;
        procedure SettoDefaults; override;
        procedure SaveSettings; override;
        procedure LoadSettings; override;
        function CallValidatePaths(dirList: string): string;
        property Name;
        property OriginalPath: string read fOldPath write fOldPath;
    published
        property Exec: string read fExec write fExec;
        property Config: string read fConfig write fConfig;
        property Bins: string read fBinDir write fBinDir;
        property Default: string read fDefault write fDefault;
        property C: string read fCDir write fCDir;
        property Cpp: string read fCppDir write fCppDir;
        property Help: string read fHelp write fHelp;
        property Icons: string read fIcons write fIcons;
        property Lang: string read fLang write fLang;
        property Lib: string read fLibDir write fLibDir;
        property RC: string read fRCDir write fRCDir;
        property Templates: string read fTemp write fTemp;
        property Themes: string read fThemes write fThemes;
        property CompilerType: integer read fCompilerType write fCompilerType;
    end;

    // editor options -- syntax, synedit options, etc...
    TdevEditor = class(TCFGOptions)
    private
        fUseSyn: boolean; // use syntax highlighting
        fSynExt: string; // semi-colon seperated list of highlight ext's
        fFont: TFont; // Editor Font
        fGutterFont: TFont; // Gutter font
        fInsertCaret: integer; // Editor insert caret
        fOverwriteCaret: integer; // Editor overwrite caret
        fTabSize: integer; // Editor Tab Size
        fGutterSize: integer; // Width of Left margin gutter
        fMarginSize: integer; // Width of right margin

        fCustomGutter: boolean; // Use Selected Gutter font
        fGutterAuto: boolean; // Gutter Auto Sizes
        fShowGutter: boolean; // Show Left gutter in editor
        fGutterGradient: boolean; // Draw the gutter with a gradient
        fLineNumbers: boolean; // Show Line Numbers
        fLeadZero: boolean; // Show leading zero's in line nums
        fFirstisZero: boolean; // First line is zero

        fMarginVis: boolean; // Toggle right margin line

        fShowScrollHint: boolean; // Show line number when scrolling
        fShowScrollbars: boolean; // Show Scroll bars
        fHalfPage: boolean; // PgUp/PgDn move half a page

        fPastEOF: boolean; // Cursor moves past end of file
        fPastEOL: boolean; // Cursor moves past end of lines
        fTrailBlanks: boolean; // Blanks past EOL are not trimmed
        fdblLine: boolean; // Double Click selects a line
        fFindText: boolean; // Text at cursor defaults in find dialog
        fEHomeKey: boolean; // Home key like visual studio
        fGroupUndo: boolean; // treat same undo's as single undo
        fInsDropFiles: boolean; // Insert files when drag/dropped else open
        fInsertMode: boolean; // Editor defaults to insert mode
        fAutoIndent: boolean; // Auto-indent code lines
        fSmartTabs: boolean; // Tab to next no whitespace char
        fSmartUnindent: boolean; // on backspace move to prev non-whitespace char
        fSpecialChar: boolean; // special line characters visible
        fAppendNewline: boolean;    // append newline character to the end of line
        fTabtoSpaces: boolean; // convert tabs to spaces
        fAutoCloseBrace: boolean; // insert closing braces
        fMarginColor: TColor; // Color of right margin
        fActiveSyn: string; // Active syntax highlighting set
        fSyntax: TStrings; // Holds attributes settings
        fDefaultIntoPrj: boolean;
        // Insert Default Source Code into "empty" project
        fParserHints: boolean; // Show parser's hint for the word under the cursor
        fMatch: boolean; // Highlight matching parenthesis
        fHighCurrLine: boolean;     // Highlight current line
        fHighColor: TColor;         // Color of current line when highlighted

        //fCodeFolding : boolean; // Code folding enabled?
    public
        constructor Create;
        destructor Destroy; override;
        procedure SettoDefaults; override;
        procedure SaveSettings; override;
        procedure LoadSettings; override;
        procedure AssignEditor(Editor: TSynEdit);
        property Name;
    published
        //Editor props
        property AutoIndent: boolean read fAutoIndent write fAutoIndent;
        property InsertMode: boolean read fInsertMode write fInsertMode;
        property TabToSpaces: boolean read fTabToSpaces write fTabtoSpaces;
        property SmartTabs: boolean read fSmartTabs write fSmartTabs;
        property SmartUnindent: boolean read fSmartUnindent write fSmartUnindent;
        property TrailBlank: boolean read fTrailBlanks write fTrailBlanks;
        property GroupUndo: boolean read fGroupUndo write fGroupUndo;
        property EHomeKey: boolean read fEHomeKey write fEHomeKey;
        property PastEOF: boolean read fPastEOF write fPastEOF;
        property PastEOL: boolean read fPastEOL write fPastEOL;
        property DblClkLine: boolean read fdblLine write fdblLine;
        property FindText: boolean read fFindText write fFindText;
        property Scrollbars: boolean read fShowScrollbars write fShowScrollbars;
        property HalfPageScroll: boolean read fHalfPage write fHalfPage;
        property ScrollHint: boolean read fShowScrollHint write fShowScrollHint;
        property SpecialChars: boolean read fSpecialChar write fSpecialChar;
        property AppendNewline: boolean read fAppendNewline write fAppendNewline;
        property AutoCloseBrace: boolean
            read fAutoCloseBrace write fAutoCloseBrace;

        property TabSize: integer read fTabSize write fTabSize;
        property MarginVis: boolean read fMarginVis write fMarginVis;
        property MarginSize: integer read fMarginSize write fMarginSize;
        property MarginColor: TColor read fMarginColor write fMarginColor;
        property InsertCaret: integer read fInsertCaret write fInsertCaret;
        property OverwriteCaret: integer
            read fOverwriteCaret write fOverwriteCaret;
        property InsDropFiles: boolean read fInsDropFiles write fInsDropFiles;
        property Font: TFont read fFont write fFont;

        // Gutter options
        property GutterVis: boolean read fShowGutter write fShowGutter;
        property GutterAuto: boolean read fGutterAuto write fGutterAuto;
        property GutterGradient: boolean
            read fGutterGradient write fGutterGradient;
        property LineNumbers: boolean read fLineNumbers write fLineNumbers;
        property LeadZero: boolean read fLeadZero write fLeadZero;
        property FirstLineZero: boolean read fFirstisZero write fFirstisZero;
        property Gutterfnt: boolean read fCustomGutter write fCustomGutter;
        property GutterSize: integer read fGutterSize write fGutterSize;
        property Gutterfont: TFont read fGutterfont write fGutterFont;

        // syntax
        property UseSyntax: boolean read fUseSyn write fUseSyn;
        property SyntaxExt: string read fSynExt write fSynExt;
        property ActiveSyntax: string read fActiveSyn write fActiveSyn;
        property Syntax: TStrings read fSyntax write fSyntax;

        // other
        property DefaulttoPrj: boolean read fDefaultIntoPrj write fDefaultIntoPrj;

        property ParserHints: boolean read fParserHints write fParserHints;
        property Match: boolean read fMatch write fMatch;
        property HighCurrLine: boolean read fHighCurrLine write fHighCurrLine;
        property HighColor: TColor read fHighColor write fHighColor;
       // property CodeFolding: boolean read fCodeFolding write fCodeFolding;

    end;

    // master option object -- contains program globals
    TdevData = class(TConfigData)
    private
        fVersion: string; // The configuration file's version
        fLang: string; // Language file
        fTheme: string; // Theme file
        fFindCols: string; // Find Column widths (comma sep)
        fCompCols: string; // Compiler Column Widths (comma sep)
        fMsgTabs: boolean; // Message Control Tabs (Top/Bottom)
        fMinOnRun: boolean; // Minimize IDE on run
        fOpenStyle: integer; // Open Dialog Style
        fMRUMax: integer; // Max number of files in history list
        fBackup: boolean; // Create backup files
        fAutoOpen: integer; // Auto Open Project Files Style
        fClassView: boolean;
        // if true, shows the class view, else shows the file view
        fStatusbar: boolean; // Statusbar Visible
        fFullScr: boolean; // IDE is Full screen
        fShowBars: boolean; // Show toolbars in FullScreen mode
        fShowMenu: boolean; // Show Main Menu in Full Screen Mode
        fSingleInstance: boolean; // Allow the IDE to be in single instance
        fDefCpp: boolean; // Default to C++ project (compile with g++)
        fFirst: boolean; // first run of dev-c
        fSplash: string; // user selected splash screen
        fWinPlace: TWindowPlacement; // Main forms size, state and position.
        fdblFiles: boolean; // double click opens files out of project manager
        fLangChange: boolean; // flag for language change
        fthemeChange: boolean; // did the theme changed
        fNoSplashScreen: boolean; // disable splash screen
        fHiliteActiveTab: boolean; // Hilite the Active Editor Page Tab
        fAutoCompile: integer; // automatically compile when out-of-date
        fNoToolTip: boolean; // Don't use Tooltips
        fAutoAddDebugFlag: integer; //Automatically add debug flag if not present at debug start

        fDebugCommand: string;
        // Custom command to send to debugger (default is "finish")

        // toolbar layout
        fToolbarMain: boolean;
        fToolbarMainX: integer;
        fToolbarMainY: integer;
        fToolbarEdit: boolean;
        fToolbarEditX: integer;
        fToolbarEditY: integer;
        fToolbarCompile: boolean;
        fToolbarCompileX: integer;
        fToolbarCompileY: integer;
        fToolbarDebug: boolean;
        fToolbarDebugX: integer;
        fToolbarDebugY: integer;
        fToolbarProject: boolean;
        fToolbarProjectX: integer;
        fToolbarProjectY: integer;
        fToolbarOptions: boolean;
        fToolbarOptionsX: integer;
        fToolbarOptionsY: integer;
        fToolbarSpecials: boolean;
        fToolbarSpecialsX: integer;
        fToolbarSpecialsY: integer;
        fToolbarSearch: boolean;
        fToolbarSearchX: integer;
        fToolbarSearchY: integer;
        fToolbarClasses: boolean;
        fToolbarClassesX: integer;
        fToolbarClassesY: integer;

        // file associations (see FileAssocs.pas)
        fAssociateCpp: boolean;
        fAssociateC: boolean;
        fAssociateHpp: boolean;
        fAssociateH: boolean;
        fAssociateDev: boolean;
        fAssociateRc: boolean;
        fAssociateTemplate: boolean;

        // tip of the day
        fShowTipsOnStart: boolean;
        fLastTip: integer;
        fXPTheme: boolean; // Use XP theme
        fNativeDocks: boolean; // Use native docking windows under XP
        fFileDate: integer; // Dev-C++ File Date for checking old configurations
        fShowProgress: boolean; // Show progress window during compile
        fAutoCloseProgress: boolean;
        // Auto close progress bar window after compile
        // Printer
        fPrintColors: boolean; // print colors
        fPrintHighlight: boolean;
        fPrintWordWrap: boolean;
        fPrintLineNumbers: boolean;
        fPrintLineNumbersMargins: boolean;

        // Debug variable browser
        fWatchHint: boolean; // watch variable under mouse
        fWatchError: boolean; // report watch errors

    public
        constructor Create(aOwner: TComponent); override;
        destructor Destroy; override;
        procedure SettoDefaults; override;
        procedure SaveConfigData; override;
        procedure ReadConfigData; override;

        class function DevData: TDevData;
        property WindowPlacement: TWindowPlacement read fWinPlace write fWinPlace;
        property LangChange: boolean read fLangChange write fLangChange;
        property ThemeChange: boolean read fThemeChange write fThemeChange;
    published
        property Version: string read fVersion write fVersion;
        property Language: string read fLang write fLang;
        property Theme: string read fTheme write fTheme;
        property First: boolean read fFirst write fFirst;
        property Splash: string read fSplash write fSplash;
        property MRUMax: integer read fMRUMax write fMRUMax;
        property DblFiles: boolean read fDblFiles write fDblFiles;
        property NoSplashScreen: boolean
            read fNoSplashScreen write fNoSplashScreen;
        property HiliteActiveTab: boolean read fHiliteActiveTab
            write fHiliteActiveTab;
        property AutoCompile: integer read fAutoCompile write fAutoCompile;
        property NoToolTip: boolean read fNoToolTip write fNoToolTip default TRUE;
        property AutoAddDebugFlag: integer read fAutoAddDebugFlag write fAutoAddDebugFlag;

        property DebugCommand: string read fDebugCommand write fDebugCommand;
        //Execution
        property MinOnRun: boolean read fMinOnRun write fMinOnRun;
        property OpenStyle: integer read fOpenStyle write fOpenStyle;

        property BackUps: boolean read fBackup write fBackup;
        property AutoOpen: integer read fAutoOpen write fAutoOpen;

        //Windows
        property MsgTabs: boolean read fMsgTabs write fMsgTabs;

        property ShowBars: boolean read fShowbars write fShowbars;
        property ShowMenu: boolean read fShowMenu write fShowMenu;

        //Running Status Options
        property SingleInstance: boolean
            read fSingleInstance write fSingleInstance;
        property DefCpp: boolean read fDefCpp write fDefCpp;
        property ClassView: boolean read fClassView write fClassView;
        property Statusbar: boolean read fStatusbar write fStatusbar;
        property FullScreen: boolean read fFullScr write fFullScr;
        property FindCols: string read fFindCols write fFindCols;
        property CompCols: string read fCompCols write fCompCols;

        //Toolbars
        property ToolbarMain: boolean read fToolbarMain write fToolbarMain;
        property ToolbarMainX: integer read fToolbarMainX write fToolbarMainX;
        property ToolbarMainY: integer read fToolbarMainY write fToolbarMainY;
        property ToolbarEdit: boolean read fToolbarEdit write fToolbarEdit;
        property ToolbarEditX: integer read fToolbarEditX write fToolbarEditX;
        property ToolbarEditY: integer read fToolbarEditY write fToolbarEditY;
        property ToolbarCompile: boolean
            read fToolbarCompile write fToolbarCompile;
        property ToolbarCompileX: integer read fToolbarCompileX
            write fToolbarCompileX;
        property ToolbarCompileY: integer read fToolbarCompileY
            write fToolbarCompileY;
        property ToolbarDebug: boolean read fToolbarDebug write fToolbarDebug;
        property ToolbarDebugX: integer read fToolbarDebugX write fToolbarDebugX;
        property ToolbarDebugY: integer read fToolbarDebugY write fToolbarDebugY;
        property ToolbarProject: boolean
            read fToolbarProject write fToolbarProject;
        property ToolbarProjectX: integer read fToolbarProjectX
            write fToolbarProjectX;
        property ToolbarProjectY: integer read fToolbarProjectY
            write fToolbarProjectY;
        property ToolbarOptions: boolean
            read fToolbarOptions write fToolbarOptions;
        property ToolbarOptionsX: integer read fToolbarOptionsX
            write fToolbarOptionsX;
        property ToolbarOptionsY: integer read fToolbarOptionsY
            write fToolbarOptionsY;
        property ToolbarSpecials: boolean read fToolbarSpecials
            write fToolbarSpecials;
        property ToolbarSpecialsX: integer
            read fToolbarSpecialsX write fToolbarSpecialsX;
        property ToolbarSpecialsY: integer
            read fToolbarSpecialsY write fToolbarSpecialsY;
        property ToolbarSearch: boolean read fToolbarSearch write fToolbarSearch;
        property ToolbarSearchX: integer
            read fToolbarSearchX write fToolbarSearchX;
        property ToolbarSearchY: integer
            read fToolbarSearchY write fToolbarSearchY;
        property ToolbarClasses: boolean
            read fToolbarClasses write fToolbarClasses;
        property ToolbarClassesX: integer read fToolbarClassesX
            write fToolbarClassesX;
        property ToolbarClassesY: integer read fToolbarClassesY
            write fToolbarClassesY;

        // file associations
        property AssociateCpp: boolean read fAssociateCpp write fAssociateCpp;
        property AssociateC: boolean read fAssociateC write fAssociateC;
        property AssociateHpp: boolean read fAssociateHpp write fAssociateHpp;
        property AssociateH: boolean read fAssociateH write fAssociateH;
        property AssociateDev: boolean read fAssociateDev write fAssociateDev;
        property AssociateRc: boolean read fAssociateRc write fAssociateRc;
        property AssociateTemplate: boolean
            read fAssociateTemplate write fAssociateTemplate;

        // tip of the day
        property ShowTipsOnStart: boolean read fShowTipsOnStart
            write fShowTipsOnStart;
        property LastTip: integer read fLastTip write fLastTip;

        property XPTheme: boolean read fXPTheme write fXPTheme;
        property NativeDocks: boolean read fNativeDocks write fNativeDocks;
        property FileDate: integer read fFileDate write fFileDate;

        // progress window
        property ShowProgress: boolean read fShowProgress write fShowProgress;
        property AutoCloseProgress: boolean
            read fAutoCloseProgress write fAutoCloseProgress;

        //  Printer
        property PrintColors: boolean read fPrintColors write fPrintColors;
        property PrintHighlight: boolean
            read fPrintHighlight write fPrintHighlight;
        property PrintWordWrap: boolean read fPrintWordWrap write fPrintWordWrap;
        property PrintLineNumbers: boolean
            read fPrintLineNumbers write fPrintLineNumbers;
        property PrintLineNumbersMargins: boolean
            read fPrintLineNumbersMargins write fPrintLineNumbersMargins;

        // Variable debug browser
        property WatchHint: boolean read fWatchHint write fWatchHint;
        property WatchError: boolean read fWatchError write fWatchError;
    end;

function DevData: TdevData;

procedure InitializeOptions;
procedure InitializeOptionsAfterPlugins;
procedure SaveOptions;
procedure FinalizeOptions;
procedure ResettoDefaults;
procedure CheckForAltConfigFile(filename: string);
procedure UpdateAltConfigFile;

var
    devCompiler: TdevCompiler = NIL;
    devCompilerSet: TDevCompilerSet = NIL;
    devDirs: TdevDirs = NIL;
    devEditor: TdevEditor = NIL;
    devCodeCompletion: TdevCodeCompletion = NIL;
    devClassBrowsing: TdevClassBrowsing = NIL;
    devCVSHandler: TdevCVSHandler = NIL;
    devExternalPrograms: TdevExternalPrograms = NIL;
  {$IFDEF PLUGIN_BUILD}
    devPluginToolbarsX: TdevPluginToolbarsX = NIL;
    devPluginToolbarsY: TdevPluginToolbarsY = NIL;
  {$ENDIF PLUGIN_BUILD}

    // Permanent alternate config file (need to be global vars)
    ConfigMode: (CFG_NORMAL, CFG_PARAM, CFG_USER) = CFG_NORMAL;
    StandardConfigFile: string;
    UseAltConfigFile: boolean;
    AltConfigFile: string;

implementation

uses
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

function ValidatePaths(dirList: string; var badDirs: string): string;
    //checks if directories in provided ; delimited list exist
    //returns filtered out dirList with only existing paths
    //badDirs returns ; delimited list of non existing dirs
    //also remove duplicates and empty entries
var
    strs: TStrings;
    i, j: integer;
    currdir: string;
    newdir: string;

    function makeFullPath(dir: string): string;
    begin
        Result := dir;
        //check if full path
{$IFDEF WIN32}
        if Length(dir) > 1 then
            if dir[2] = ':' then
                Exit;
        if Length(dir) > 0 then
            if dir[1] = '\' then
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
    end;

begin
    Result := '';
    badDirs := '';

    //needed to confirm relative paths
    currdir := GetCurrentDir;
    SetCurrentDir(ExtractFilePath(Application.ExeName));

    strs := TStringList.Create;
    repeat
        if Pos(';', dirList) = 0 then
            strs.Add(dirList)
        else
        begin
            newdir := makeFullPath(Copy(dirList, 1, Pos(';', dirList) - 1));
            strs.Add(newdir);
            Delete(dirList, 1, Pos(';', dirList));
        end;
    until Pos(';', dirList) = 0;

    //eliminate duplicates
    for i := strs.Count - 1 downto 0 do
        for j := strs.Count - 1 downto i + 1 do
            if (Trim(strs[j]) = '') or
                (makeFullPath(Trim(strs[i])) = makeFullPath(Trim(strs[j]))) then
                strs.Delete(j);

    //check the directories
    for i := strs.Count - 1 downto 0 do
    begin
        if DirectoryExists(strs[i]) then
            Result := Result + ';' + strs[i]
        else
            badDirs := badDirs + ';' + strs[i];
    end;

    if Length(Result) > 0 then
        if Result[1] = ';' then
            Delete(Result, 1, 1);
    if Length(badDirs) > 0 then
        if badDirs[1] = ';' then
            Delete(badDirs, 1, 1);

    FreeAndNil(strs);

    SetCurrentDir(currdir);
end;

procedure InitializeOptions;
begin

    if not assigned(devDirs) then
        devDirs := TdevDirs.Create;

    if not assigned(devCompilerSet) then
        devCompilerSet := TdevCompilerSet.Create;

    if not assigned(devCompiler) then
        devCompiler := TdevCompiler.Create;

    if not assigned(devEditor) then
        devEditor := TdevEditor.Create;

    if not assigned(devCodeCompletion) then
        devCodeCompletion := TdevCodeCompletion.Create;

    if not assigned(devClassBrowsing) then
        devClassBrowsing := TdevClassBrowsing.Create;

    if not assigned(devCVSHandler) then
        devCVSHandler := TdevCVSHandler.Create;

    if not assigned(devExternalPrograms) then
        devExternalPrograms := TdevExternalPrograms.Create;

  {$IFDEF PLUGIN_BUILD}
    if not assigned(devPluginToolbarsX) then
        devPluginToolbarsX := TdevPluginToolbarsX.Create;
    if not assigned(devPluginToolbarsY) then
        devPluginToolbarsY := TdevPluginToolbarsY.Create;
  {$ENDIF PLUGIN_BUILD}

    // load the preferred compiler set
    if (devCompilerSet.Sets.Count = 0) then
    begin      // EAB Comment: Why load all the compiler sets if not all are available?
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
        if MainForm <> NIL then
            devCompilerSet.SaveSet(ID_COMPILER_MINGW);

        devCompilerSet.CompilerType := ID_COMPILER_VC2005;
        devdirs.fCompilerType := ID_COMPILER_VC2005;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_VC2005);
        devCompilerSet.LoadSetDirs(ID_COMPILER_VC2005);
        if MainForm <> NIL then
            devCompilerSet.SaveSet(ID_COMPILER_VC2005);

        devCompilerSet.CompilerType := ID_COMPILER_VC2003;
        devdirs.fCompilerType := ID_COMPILER_VC2003;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_VC2003);
        devCompilerSet.LoadSetDirs(ID_COMPILER_VC2003);
        if MainForm <> NIL then
            devCompilerSet.SaveSet(ID_COMPILER_VC2003);

        devCompilerSet.CompilerType := ID_COMPILER_VC6;
        devdirs.fCompilerType := ID_COMPILER_VC6;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_VC6);
        devCompilerSet.LoadSetDirs(ID_COMPILER_VC6);
        if MainForm <> NIL then
            devCompilerSet.SaveSet(ID_COMPILER_VC6);

        devCompilerSet.CompilerType := ID_COMPILER_DMARS;
        devdirs.fCompilerType := ID_COMPILER_DMARS;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_DMARS);
        devCompilerSet.LoadSetDirs(ID_COMPILER_DMARS);
        if MainForm <> NIL then
            devCompilerSet.SaveSet(ID_COMPILER_DMARS);

        devCompilerSet.CompilerType := ID_COMPILER_VC2008;
        // EAB TODO: Check this logic. Maybe, move above and change numbering
        devdirs.fCompilerType := ID_COMPILER_VC2008;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_VC2008);
        devCompilerSet.LoadSetDirs(ID_COMPILER_VC2008);
        if MainForm <> NIL then
            devCompilerSet.SaveSet(ID_COMPILER_VC2008);

        devCompilerSet.CompilerType := ID_COMPILER_VC2010;
        // EAB TODO: Check this logic. Maybe, move above and change numbering
        devdirs.fCompilerType := ID_COMPILER_VC2010;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_VC2010);
        devCompilerSet.LoadSetDirs(ID_COMPILER_VC2010);
        if MainForm <> NIL then
            devCompilerSet.SaveSet(ID_COMPILER_VC2010);

        devCompilerSet.CompilerType := ID_COMPILER_BORLAND;
        devdirs.fCompilerType := ID_COMPILER_BORLAND;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_BORLAND);
        devCompilerSet.LoadSetDirs(ID_COMPILER_BORLAND);
        if MainForm <> NIL then
            devCompilerSet.SaveSet(ID_COMPILER_BORLAND);

        devCompilerSet.CompilerType := ID_COMPILER_WATCOM;
        devdirs.fCompilerType := ID_COMPILER_WATCOM;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_WATCOM);
        devCompilerSet.LoadSetDirs(ID_COMPILER_WATCOM);
        if MainForm <> NIL then
            devCompilerSet.SaveSet(ID_COMPILER_WATCOM);

        devCompilerSet.CompilerType := ID_COMPILER_LINUX;
        devdirs.fCompilerType := ID_COMPILER_LINUX;
        devdirs.SettoDefaults;
        devCompilerSet.LoadSetProgs(ID_COMPILER_LINUX);
        devCompilerSet.LoadSetDirs(ID_COMPILER_LINUX);
        if MainForm <> NIL then
            devCompilerSet.SaveSet(ID_COMPILER_LINUX);

        //Reset the compiler type back to GCC
        devdirs.fCompilerType := ID_COMPILER_MINGW;
        devdirs.SettoDefaults;
        //Guru: todo: Add More Compiler default sets here

    end;

    devCompilerSet.LoadSet(devCompiler.CompilerSet);
    devCompiler.AddDefaultOptions;
    devCompilerSet.AssignToCompiler;
    if MainForm <> NIL then
    begin
        devCompilerSet.SaveSet(devCompiler.CompilerSet);
        devCompiler.SaveSettings;
    end;
end;

procedure InitializeOptionsAfterPlugins;
{$IFDEF PLUGIN_BUILD}
var
    i, j: integer;
    pluginSettings: TSettings;
    tempName: string;
{$ENDIF PLUGIN_BUILD}
begin

    pluginSettings := NIL;

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
    for i := 0 to MainForm.pluginsCount - 1 do
    begin

        MainForm.plugins[i].SetCompilerOptionstoDefaults;
        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        for j := 0 to Length(pluginSettings) - 1 do
        begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            if tempName <> '' then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        end;
        MainForm.plugins[i].LoadCompilerOptions;

    end;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_MINGW);


    devCompilerSet.CompilerType := ID_COMPILER_VC2005;
    devdirs.fCompilerType := ID_COMPILER_VC2005;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_VC2005);
    devCompilerSet.LoadSetDirs(ID_COMPILER_VC2005);

    {$IFDEF PLUGIN_BUILD}
    for i := 0 to MainForm.pluginsCount - 1 do
    begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        for j := 0 to Length(pluginSettings) - 1 do
        begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            if tempName <> '' then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        end;
        MainForm.plugins[i].LoadCompilerOptions;

    end;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_VC2005);

    devCompilerSet.CompilerType := ID_COMPILER_VC2003;
    devdirs.fCompilerType := ID_COMPILER_VC2003;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_VC2003);
    devCompilerSet.LoadSetDirs(ID_COMPILER_VC2003);

    {$IFDEF PLUGIN_BUILD}
    for i := 0 to MainForm.pluginsCount - 1 do
    begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        for j := 0 to Length(pluginSettings) - 1 do
        begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            if tempName <> '' then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        end;
        MainForm.plugins[i].LoadCompilerOptions;

    end;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_VC2003);

    devCompilerSet.CompilerType := ID_COMPILER_VC6;
    devdirs.fCompilerType := ID_COMPILER_VC6;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_VC6);
    devCompilerSet.LoadSetDirs(ID_COMPILER_VC6);

    {$IFDEF PLUGIN_BUILD}
    for i := 0 to MainForm.pluginsCount - 1 do
    begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        for j := 0 to Length(pluginSettings) - 1 do
        begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            if tempName <> '' then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        end;
        MainForm.plugins[i].LoadCompilerOptions;

    end;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_VC6);

    devCompilerSet.CompilerType := ID_COMPILER_DMARS;
    devdirs.fCompilerType := ID_COMPILER_DMARS;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_DMARS);
    devCompilerSet.LoadSetDirs(ID_COMPILER_DMARS);

    {$IFDEF PLUGIN_BUILD}
    for i := 0 to MainForm.pluginsCount - 1 do
    begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        for j := 0 to Length(pluginSettings) - 1 do
        begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            if tempName <> '' then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        end;
        MainForm.plugins[i].LoadCompilerOptions;

    end;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_DMARS);

    devCompilerSet.CompilerType := ID_COMPILER_VC2008;
    // EAB TODO: Check this logic. Maybe, move above and change numbering
    devdirs.fCompilerType := ID_COMPILER_VC2008;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_VC2008);
    devCompilerSet.LoadSetDirs(ID_COMPILER_VC2008);

    {$IFDEF PLUGIN_BUILD}
    for i := 0 to MainForm.pluginsCount - 1 do
    begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        for j := 0 to Length(pluginSettings) - 1 do
        begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            if tempName <> '' then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        end;
        MainForm.plugins[i].LoadCompilerOptions;

    end;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_VC2008);


    devCompilerSet.CompilerType := ID_COMPILER_VC2010;
    // EAB TODO: Check this logic. Maybe, move above and change numbering
    devdirs.fCompilerType := ID_COMPILER_VC2010;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_VC2010);
    devCompilerSet.LoadSetDirs(ID_COMPILER_VC2010);

    {$IFDEF PLUGIN_BUILD}
    for i := 0 to MainForm.pluginsCount - 1 do
    begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        for j := 0 to Length(pluginSettings) - 1 do
        begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            if tempName <> '' then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        end;
        MainForm.plugins[i].LoadCompilerOptions;

    end;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_VC2010);


    devCompilerSet.CompilerType := ID_COMPILER_BORLAND;
    devdirs.fCompilerType := ID_COMPILER_BORLAND;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_BORLAND);
    devCompilerSet.LoadSetDirs(ID_COMPILER_BORLAND);

    {$IFDEF PLUGIN_BUILD}
    for i := 0 to MainForm.pluginsCount - 1 do
    begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        for j := 0 to Length(pluginSettings) - 1 do
        begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            if tempName <> '' then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        end;
        MainForm.plugins[i].LoadCompilerOptions;

    end;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_BORLAND);

    devCompilerSet.CompilerType := ID_COMPILER_WATCOM;
    devdirs.fCompilerType := ID_COMPILER_WATCOM;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_WATCOM);
    devCompilerSet.LoadSetDirs(ID_COMPILER_WATCOM);

    {$IFDEF PLUGIN_BUILD}
    for i := 0 to MainForm.pluginsCount - 1 do
    begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        for j := 0 to Length(pluginSettings) - 1 do
        begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            if tempName <> '' then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        end;
        MainForm.plugins[i].LoadCompilerOptions;

    end;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(ID_COMPILER_WATCOM);

    devCompilerSet.CompilerType := ID_COMPILER_LINUX;
    devdirs.fCompilerType := ID_COMPILER_LINUX;
    devdirs.SettoDefaults;
    devCompilerSet.LoadSetProgs(ID_COMPILER_LINUX);
    devCompilerSet.LoadSetDirs(ID_COMPILER_LINUX);

    {$IFDEF PLUGIN_BUILD}
    for i := 0 to MainForm.pluginsCount - 1 do
    begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        for j := 0 to Length(pluginSettings) - 1 do
        begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            if tempName <> '' then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        end;
        MainForm.plugins[i].LoadCompilerOptions;

    end;

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
    for i := 0 to MainForm.pluginsCount - 1 do
    begin

        pluginSettings := MainForm.plugins[i].GetCompilerOptions;

        for j := 0 to Length(pluginSettings) - 1 do
        begin

            // This line loads it from the .ini file.
            tempName := devData.LoadSetting(devCompilerSet.optComKey,
                pluginSettings[j].name);
            // Value comes back as a string. Plugin converts
            //  string value to correct type using LoadCompilerSettings
            if tempName <> '' then
                MainForm.plugins[i].LoadCompilerSettings(
                    pluginSettings[j].name, tempName);
        end;
        MainForm.plugins[i].LoadCompilerOptions;

    end;

    {$ENDIF PLUGIN_BUILD}

    devCompilerSet.SaveSet(devCompiler.CompilerSet);
    devCompiler.SaveSettings;
end;

procedure SaveOptions;
begin
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
end;

procedure ResettoDefaults;
begin
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
end;

procedure FinalizeOptions;
begin
    devCompiler.SaveSettings;
    devCompiler.Free;

    if Assigned(devCompiler) then
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
end;

procedure CheckForAltConfigFile(filename: string);
var
    Ini: TIniFile;
begin
    UseAltConfigFile := FALSE;
    AltConfigFile := '';
    if not FileExists(filename) then
        Exit;
    Ini := TIniFile.Create(filename);
    try
        UseAltConfigFile := Ini.ReadBool('Options', 'UseAltConfigFile', FALSE);
        AltConfigFile := Ini.ReadString('Options', 'AltConfigFile', '');
    finally
        Ini.Free;
    end;
end;

procedure UpdateAltConfigFile;
var
    Ini: TIniFile;
begin
    Ini := TIniFile.Create(StandardConfigFile);
    try
        Ini.WriteBool('Options', 'UseAltConfigFile', UseAltConfigFile);
        Ini.WriteString('Options', 'AltConfigFile', AltConfigFile);
    finally
        Ini.Free;
    end;
end;

{ TDevData - Singleton pattern }
var
    fdevData: TdevData = NIL;
    fExternal: boolean = TRUE;

function devData: TdevData;
begin
    if not assigned(fdevData) then
    begin
        fExternal := FALSE;
        try
            fdevData := TdevData.Create(NIL);
        finally
            fExternal := TRUE;
        end;
    end;
    result := fDevData;
end;

class function TdevData.devData: TdevData;
begin
    result := devcfg.devData;
end;
(*
  raises an exception when:
   1 - try to create without call to devdata function
         i.e. opt:= TdevData.Create; -- will raise
   2 - if already created -- should never see
*)

// add strings to lang file
constructor TdevData.Create(aOwner: Tcomponent);
begin
    if assigned(fdevData) then
        raise Exception.Create('Dev Data already created');
    if fExternal then
        raise Exception.Create('Dev Data Externally Created');
    inherited Create(aOwner);
    IgnoreProperties.Add('Style');

    SettoDefaults;
end;

destructor TdevData.Destroy;
begin
    fdevData := NIL;
    inherited;
end;

procedure TdevData.ReadConfigData;
begin
    inherited;
    LoadWindowPlacement('Position', fWinPlace);
end;

procedure TdevData.SaveConfigData;
begin
    inherited;
    SaveWindowPlacement('Position', fWinPlace);
end;

procedure TdevData.SettoDefaults;

    function getAssociation(I: integer): boolean;
    begin
        Result := CheckFiletype('.' + Associations[I, 0],
            'DevCpp.' + Associations[I, 0],
            Associations[I, 1],
            'open',
            Application.Exename + ' "%1"');
    end;

begin
    fVersion := ''; // this is filled in MainForm.Create()
    fFirst := TRUE;
    fLang := DEFAULT_LANG_FILE;
    fFindCols := '75, 75, 120, 150';
    fCompCols := '75, 75, 120';
    fMsgTabs := TRUE; // Top
    fMRUMax := 10;
    fMinOnRun := FALSE;
    fBackup := FALSE;
    fAutoOpen := 2;
    fClassView := FALSE;
    fStatusbar := TRUE;
    fSingleInstance := TRUE;
    fShowBars := FALSE;
    fShowMenu := TRUE;
    fDefCpp := TRUE;
    fOpenStyle := 0;
    fdblFiles := FALSE;
    fAutoCompile := -1;
    fAutoAddDebugFlag := -1;

    fToolbarMain := TRUE;
    fToolbarMainX := 11;
    fToolbarMainY := 2;
    fToolbarEdit := TRUE;
    fToolbarEditX := 201;
    fToolbarEditY := 2;
    fToolbarCompile := TRUE;
    fToolbarCompileX := 11;
    fToolbarCompileY := 30;
    fToolbarDebug := TRUE;
    fToolbarDebugX := 154;
    fToolbarDebugY := 30;
    fToolbarProject := TRUE;
    fToolbarProjectX := 375;
    fToolbarProjectY := 2;
    fToolbarOptions := TRUE;
    fToolbarOptionsX := 143;
    fToolbarOptionsY := 30;
    fToolbarSpecials := TRUE;
    fToolbarSpecialsX := 202;
    fToolbarSpecialsY := 30;
    fToolbarSearch := TRUE;
    fToolbarSearchX := 261;
    fToolbarSearchY := 2;
    fToolbarClasses := TRUE;
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

    fShowTipsOnStart := TRUE;
    fLastTip := 0;
    fXPTheme := FALSE;
    fNativeDocks := TRUE;
    fHiliteActiveTab := FALSE;
    fFileDate := 0;
    fShowProgress := TRUE;
    fAutoCloseProgress := FALSE;
    fPrintColors := TRUE;
    fPrintHighlight := TRUE;
    fPrintWordWrap := FALSE;
    fPrintLineNumbers := FALSE;
    fPrintLineNumbersMargins := FALSE;
    fWatchHint := TRUE;
    fWatchError := TRUE;
    fNoToolTip := TRUE;

    fDebugCommand := '-exec-finish';

end;

{ TCompilerOpts }
procedure TdevCompiler.AddDefaultOptions;
var
    sl: TStringList;

begin
    // WARNING: do *not* re-arrange the options. Their values are written to the ini file
    // with the same order. If you change the order here, the next time the configuration
    // is read, it will assign the values to the *wrong* options...
    // Anyway, the tree that displays the options is sorted, so no real reason to re-arrange
    // anything here ;)
    //
    // NOTE: As you see, to indicate sub-groups use the "/" char...

    //Begin by clearing the compiler options list
    ClearOptions;

    if devCompilerSet.CompilerType in ID_COMPILER_VC then
    begin
        sl := TStringList.Create;
        sl.Add('Neither  =');
        sl.Add('Speed=Ot');
        sl.Add('Space=Os');
        AddOption('Favour', FALSE, TRUE, TRUE, FALSE, 0, '/',
            'Code Optimization', [], sl);
        sl := TStringList.Create;
        sl.Add('Neither  =');
        sl.Add('Speed=O2');
        sl.Add('Space=O1');
        AddOption('Optimize for', FALSE, TRUE, TRUE, FALSE, 0, '/',
            'Code Optimization', [], sl);
        AddOption('Enable Global Optimization', FALSE, TRUE, TRUE,
            FALSE, 0, '/Og', 'Code Optimization', [], NIL);
        AddOption('Assume aliasing', FALSE, TRUE, TRUE, FALSE, 0,
            '/Oa', 'Code Optimization', [], NIL);
        AddOption('Enable intrinsic functions', FALSE, TRUE, TRUE,
            FALSE, 0, '/Oi', 'Code Optimization', [], NIL);
        AddOption('Assume cross-function aliasing', FALSE, TRUE,
            TRUE, FALSE, 0, '/Ow', 'Code Optimization', [], NIL);
        AddOption('Optimize for Windows Program', FALSE, TRUE, TRUE,
            FALSE, 0, '/GA', 'Code Optimization', [], NIL);
        AddOption('Omit frame pointers', FALSE, TRUE, TRUE, FALSE,
            0, '/Oy', 'Code Optimization', [], NIL);

        //Code generation
        if (devCompilerSet.CompilerType = ID_COMPILER_VC6) or
            (devCompilerSet.CompilerType = ID_COMPILER_VC2003) then
        begin
            sl := TStringList.Create;
            sl.Add('Blended model=B');
            sl.Add('Pentium=5');
            sl.Add('Pentium Pro, Pentium II and Pentium III  =6');
            sl.Add('Pentium 4 or Athlon=7');
            AddOption('Optimize for', FALSE, TRUE, TRUE, FALSE, 0,
                '/G', 'Code Generation', [], sl);
        end;

        sl := TStringList.Create;
        sl.Add('__cdecl=');
        sl.Add('__fastcall  =/Gr');
        sl.Add('__stdcall=/Gz');
        AddOption('Calling Convention', FALSE, TRUE, TRUE, FALSE,
            0, '', 'Code Generation', [], sl);

        sl := TStringList.Create;
        sl.Add('Disable=');
        if (devCompilerSet.CompilerType = ID_COMPILER_VC6) or
            (devCompilerSet.CompilerType = ID_COMPILER_VC2003) then
            sl.Add('Enable=/Gf');
        sl.Add('Enable (Read-Only)  =/GF');
        AddOption('String Pooling', FALSE, TRUE, TRUE, FALSE, 0,
            '', 'Code Generation', [], sl);

        sl := TStringList.Create;
        sl.Add('Compile native code  =');
        sl.Add('Compile for CLR=/clr');
        sl.Add('No assembly=/clr:noAssembly');
        if (devCompilerSet.CompilerType in ID_COMPILER_VC_CURRENT) then
        begin
            sl.Add('IL-only output file=/clr:pure');
            sl.Add('Verifiable IL-only output=/clr:safe');
            sl.Add('Use old syntax=/clr:oldSyntax');
            sl.Add('Enable initial AppDomain behaviour  =/clr:initialAppDomain');
        end;
        AddOption('Common Language Runtime', FALSE, TRUE, TRUE,
            FALSE, 0, '', 'Code Generation', [], sl);

        if (devCompilerSet.CompilerType in ID_COMPILER_VC_CURRENT) then
        begin
            sl := TStringList.Create;
            sl.Add('Precise  =precise');
            sl.Add('Fast=fast');
            sl.Add('Strict=strict');
            AddOption('Floating-Point Model', FALSE, TRUE, TRUE, FALSE,
                0, '', 'Code Generation', [], sl);
        end;

        sl := TStringList.Create;
        sl.Add('None=');
        sl.Add('SSE=/arch:SSE');
        sl.Add('SSE2  =/arch:SSE2');
        AddOption('Extended instruction set', FALSE, TRUE, TRUE,
            FALSE, 0, '', 'Code Generation', [], sl);

        sl := TStringList.Create;
        sl.Add('No Exceptions=');
        sl.Add('C++ Exceptions (no SEH)=/EHs');
        sl.Add('C++ Exceptions (with SEH)  =/EHa');
        AddOption('Exception handling', FALSE, FALSE, TRUE, FALSE,
            0, '', 'Code Generation', [], sl);
        AddOption('Enable _penter function call', FALSE, TRUE, TRUE,
            FALSE, 0, '/Gh', 'Code Generation', [], NIL);
        AddOption('Enable _pexit function call', FALSE, TRUE, TRUE,
            FALSE, 0, '/GH', 'Code Generation', [], NIL);
        AddOption('Enable C++ RTTI', FALSE, FALSE, TRUE, FALSE, 0,
            '/GR', 'Code Generation', [], NIL);
        AddOption('Enable Minimal Rebuild', FALSE, TRUE, TRUE, FALSE,
            0, '/Gm', 'Code Generation', [], NIL);
        AddOption('Enable Link-Time Code Generation', FALSE, TRUE,
            TRUE, FALSE, 0, '/GL', 'Code Generation', [], NIL);
        if (devCompilerSet.CompilerType = ID_COMPILER_VC6) or
            (devCompilerSet.CompilerType = ID_COMPILER_VC2003) then
        begin
            AddOption('Enable Pentium FDIV fix', FALSE, TRUE, TRUE,
                FALSE, 1, '/QIfdiv', 'Code Generation', [], NIL);
            AddOption('Enable Pentium 0x0F fix', FALSE, TRUE, TRUE,
                FALSE, 1, '/QI0f', 'Code Generation', [], NIL);
            AddOption('Use FIST instead of ftol()', FALSE, TRUE, TRUE,
                FALSE, 1, '/QIfist', 'Code Generation', [], NIL);
        end;
        AddOption('extern "C" implies nothrow', FALSE, FALSE, TRUE,
            FALSE, 0, '/EHc', 'Code Generation', [], NIL);
        AddOption('Enable function-level linking', FALSE, FALSE,
            FALSE, TRUE, 0, '/Gy', 'Code Generation', [], NIL);
        AddOption('Use fibre-safe TLS accesses', FALSE, TRUE, TRUE,
            FALSE, 0, '/GT', 'Code Generation', [], NIL);

        //Checks
        sl := TStringList.Create;
        sl.Add('None=');
        if (devCompilerSet.CompilerType = ID_COMPILER_VC6) or
            (devCompilerSet.CompilerType = ID_COMPILER_VC2003) then
            sl.Add('Enable stack probes=/Ge');
        sl.Add('Control Stack Checking Calls  =/GS');
        AddOption('Stack checks', FALSE, TRUE, TRUE, FALSE, 0, '',
            'Code Checks', [], sl);
        AddOption('Type conversion Checks', FALSE, TRUE, TRUE, FALSE,
            0, '/RTCc', 'Code Checks', [], NIL);
        AddOption('Stack Frame runtime checking', FALSE, TRUE, TRUE,
            FALSE, 0, '/RTCs', 'Code Checks', [], NIL);
        AddOption('Check for Variable Usage', FALSE, TRUE, TRUE,
            FALSE, 0, '/RTCu', 'Code Checks', [], NIL);

        //Language Options
        sl := TStringList.Create;
        sl.Add('No Debugging Information=');
        sl.Add('Generate Debugging Information=/Zi');
        sl.Add('Edit and Continue Debugging Information  =/ZI');
        sl.Add('Old-Style Debugging Information=/Z7');
        sl.Add('Include line numbers only=/Zd');
        AddOption('Debugging', FALSE, TRUE, TRUE, FALSE, 0, '',
            'Language Options', [], sl);
        if (devCompilerSet.CompilerType = ID_COMPILER_VC6) or
            (devCompilerSet.CompilerType = ID_COMPILER_VC2003) then
            AddOption('Enable Extensions', FALSE, TRUE, TRUE, FALSE,
                1, '/Ze', 'Language Options', [], NIL);
        AddOption('Omit library name in object file', FALSE, TRUE,
            TRUE, FALSE, 0, '/Zl', 'Language Options', [], NIL);
        AddOption('Generate function prototypes', FALSE, TRUE, TRUE,
            FALSE, 0, '/Zg', 'Language Options', [], NIL);
        if (devCompilerSet.CompilerType in ID_COMPILER_VC_CURRENT) then
            AddOption('Enable OpenMP 2.0 Language Extensions', FALSE,
                FALSE, TRUE, FALSE, 0, '/openmp', 'Language Options', [], NIL);

        if (devCompilerSet.CompilerType = ID_COMPILER_VC6) or
            (devCompilerSet.CompilerType = ID_COMPILER_VC2003) then
        begin
            AddOption('Enforce Standard C++ scoping', FALSE, FALSE,
                TRUE, FALSE, 0, '/Zc:forScope', 'Language Options', [], NIL);
            AddOption('Make wchar_t a native type', FALSE, FALSE,
                TRUE, FALSE, 0, '/Zc:wchar_t', 'Language Options', [], NIL);
        end
        else
        begin
            AddOption('Don''t Enforce Standard C++ scoping', FALSE,
                FALSE, TRUE, FALSE, 0, '/Zc:forScope-', 'Language Options', [], NIL);
            AddOption('Don''t Make wchar_t a native type', FALSE,
                FALSE, TRUE, FALSE, 0, '/Zc:wchar_t-', 'Language Options', [], NIL);
        end;

        //Miscellaneous
        AddOption('Treat warnings as errors', FALSE, TRUE, TRUE,
            FALSE, 0, '/WX', 'Miscellaneous', [], NIL);
        sl := TStringList.Create;
        sl.Add('Default (Level 1)  =');
        sl.Add('Level 2=/W2');
        sl.Add('Level 3=/W3');
        sl.Add('Level 4=/W4');
        sl.Add('None=/w');
        AddOption('Warning Level', FALSE, TRUE, TRUE, FALSE, 0, '',
            'Miscellaneous', [], sl);
        if (devCompilerSet.CompilerType = ID_COMPILER_VC6) or
            (devCompilerSet.CompilerType = ID_COMPILER_VC2003) then
            AddOption('Enable automatic precompiled headers', FALSE,
                TRUE, TRUE, FALSE, 0, '/YX', 'Miscellaneous', [], NIL);
        AddOption('Enable 64-bit porting warnings', FALSE, TRUE,
            TRUE, FALSE, 0, '/Wp64', 'Miscellaneous', [], NIL);
        AddOption('Disable incremental linking', FALSE, FALSE, FALSE,
            TRUE, 0, '/INCREMENTAL:NO', 'Miscellaneous', [], NIL);
    end
    else
    if devCompilerSet.CompilerType = ID_COMPILER_DMARS then
    begin
        //Start of DMars
        sl := TStringList.Create;
        sl.Add('');
        // /!\ Must contain a starting empty value in order to do not have always to pass the parameter
        sl.Add('1=1');
        sl.Add('2=2');
        sl.Add('4=4');
        sl.Add('8=8');
        AddOption('alignment of struct members', FALSE, TRUE, TRUE,
            FALSE, 0, '-a', 'C++ Options', [], sl);
        AddOption('ANSI X3.159-1989 conformance', FALSE, TRUE, TRUE,
            FALSE, 0, '-A89', 'C++ Options', [], NIL);
        AddOption('ISO/IEC 9899:1990 conformance', FALSE, TRUE,
            TRUE, FALSE, 0, '-A90', 'C++ Options', [], NIL);
        AddOption('ISO/IEC 9899-1:1994 conformance', FALSE, TRUE,
            TRUE, FALSE, 0, '-A94', 'C++ Options', [], NIL);
        AddOption('ISO/IEC 9899:1999 conformance', FALSE, TRUE,
            TRUE, FALSE, 0, '-A99', 'C++ Options', [], NIL);
        AddOption('strict ANSI C/C++', FALSE, TRUE, TRUE, FALSE,
            0, '-A', 'C++ Options', [], NIL);
        AddOption('enable new[] and delete[]', FALSE, TRUE, TRUE,
            FALSE, 0, '-Aa', 'C++ Options', [], NIL);
        AddOption('enable bool', FALSE, TRUE, TRUE, FALSE, 0, '-Ab',
            'C++ Options', [], NIL);
        AddOption('enable exception handling', FALSE, TRUE, TRUE,
            FALSE, 0, '-Ae', 'C++ Options', [], NIL);
        AddOption('enable RTTI', FALSE, TRUE, TRUE, FALSE, 0, '-Ar',
            'C++ Options', [], NIL);
        sl := TStringList.Create;
        sl.Add('');
        // /!\ Must contain a starting empty value in order to do not have always to pass the parameter
        sl.Add('English=e');
        sl.Add('French=f');
        sl.Add('German=g');
        sl.Add('Japanese=j');
        AddOption('message language', FALSE, TRUE, TRUE, TRUE, 0,
            '-B', 'C++ Options', [], sl);
        AddOption('skip the link, do compile only', FALSE, TRUE,
            TRUE, FALSE, 0, '-c', 'C++ Options', [], NIL);
        AddOption('source files are C++', FALSE, TRUE, TRUE, FALSE,
            0, '-cpp', 'C++ Options', [], NIL);
        AddOption('generate .cod (assembly) file', FALSE, TRUE,
            TRUE, FALSE, 0, '-cod', 'C++ Options', [], NIL);
        AddOption('no inline function expansion', FALSE, TRUE, TRUE,
            FALSE, 0, '-C', 'C++ Options', [], NIL);
        AddOption('generate .dep (make dependency) file', FALSE,
            TRUE, TRUE, FALSE, 0, '-d', 'C++ Options', [], NIL);
        AddOption('#define DEBUG 1', FALSE, TRUE, TRUE, FALSE, 0,
            '-D', 'C++ Options', [], NIL);
        AddOption('strict ANSI C/C++', FALSE, TRUE, TRUE, FALSE,
            0, '/Zg', 'C++ Options', [], NIL);
        AddOption('show results of preprocessor', FALSE, TRUE, TRUE,
            FALSE, 0, '-e', 'C++ Options', [], NIL);
        AddOption('do not elide comments', FALSE, TRUE, TRUE, FALSE,
            0, '-EC', 'C++ Options', [], NIL);
        AddOption('#line directives not output', FALSE, TRUE, TRUE,
            FALSE, 0, '-EL', 'C++ Options', [], NIL);

        AddOption('IEEE 754 inline 8087 code', FALSE, TRUE, TRUE,
            FALSE, 0, '-f', 'C++ Options', [], NIL);
        AddOption('work around FDIV problem', FALSE, TRUE, TRUE,
            FALSE, 0, '-fd', 'C++ Options', [], NIL);

        AddOption('fast inline 8087 code', FALSE, TRUE, TRUE, FALSE,
            0, '-ff ', 'C++ Options', [], NIL);
        AddOption('generate debug info', FALSE, TRUE, TRUE, FALSE,
            0, '-g', 'C++ Options', [], NIL);

        //-gf disable debug info optimization
        AddOption('disable debug info optimization', FALSE, TRUE,
            TRUE, FALSE, 0, '-gf', 'C++ Options', [], NIL);
        //-gg make static functions global
        AddOption('make static functions global', FALSE, TRUE, TRUE,
            FALSE, 0, '-gg', 'C++ Options', [], NIL);
        //-gh symbol info for globals
        AddOption('symbol info for globals', FALSE, TRUE, TRUE,
            FALSE, 0, '-gh', 'C++ Options', [], NIL);
        //-gl debug line numbers only
        AddOption('debug line numbers only', FALSE, TRUE, TRUE,
            FALSE, 0, '-gl', 'C++ Options', [], NIL);
        //-gp generate pointer validations
        AddOption('generate pointer validations', FALSE, TRUE, TRUE,
            FALSE, 0, '-gp', 'C++ Options', [], NIL);
        //-gs debug symbol info only
        AddOption('debug symbol info only', FALSE, TRUE, TRUE, FALSE,
            0, '-gs', 'C++ Options', [], NIL);
        //-gt generate trace prolog/epilog
        AddOption('generate trace prolog/epilog', FALSE, TRUE, TRUE,
            FALSE, 0, '-gt', 'C++ Options', [], NIL);
        //-GTnnnn set data threshold to nnnn
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);
        //-H  use precompiled headers (ph)
        AddOption('use precompiled headers (ph)', FALSE, TRUE, TRUE,
            FALSE, 0, '-H', 'C++ Options', [], NIL);
        //-HDdirectory  use ph from directory
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);
        //-HF[filename]  generate ph to filename
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);
        //-HHfilename  read ph from filename
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);
        //-HIfilename   #include "filename"
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);
        //-HO include files only once
        AddOption('include files only once', FALSE, TRUE, TRUE,
            FALSE, 0, '-HO', 'C++ Options', [], NIL);
        //-HS only search -I directories
        AddOption('only search -I directories', FALSE, TRUE, TRUE,
            FALSE, 0, '-HS', 'C++ Options', [], NIL);
        //-HX automatic precompiled headers
        AddOption('automatic precompiled headers', FALSE, TRUE,
            TRUE, FALSE, 0, '-HX', 'C++ Options', [], NIL);
        //-j[0|1|2]  Asian language characters
        //0: Japanese 1: Taiwanese and Chinese 2: Korean
        sl := TStringList.Create;
        sl.Add('');
        // /!\ Must contain a starting empty value in order to do not have always to pass the parameter
        sl.Add('Japanese=0');
        sl.Add('Taiwanese & Chinese=1');
        sl.Add('Korean=2');
        AddOption('Asian language characters', FALSE, TRUE, TRUE,
            TRUE, 0, '-j', 'C++ Options', [], sl);
        //-Jm relaxed type checking
        AddOption('relaxed type checking', FALSE, TRUE, TRUE, FALSE,
            0, '-Jm', 'C++ Options', [], NIL);
        //-Ju char==unsigned char
        AddOption('char==unsigned char', FALSE, TRUE, TRUE, FALSE,
            0, '-Ju', 'C++ Options', [], NIL);
        // - Jb no empty base class optimization
        AddOption('no empty base class optimization', FALSE, TRUE,
            TRUE, FALSE, 0, '-Jb', 'C++ Options', [], NIL);
        // - J  chars are unsigned
        AddOption('chars are unsigned', FALSE, TRUE, TRUE, FALSE,
            0, '-J', 'C++ Options', [], NIL);
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
        AddOption('alignment of struct members', FALSE, TRUE, TRUE,
            FALSE, 0, '-m', 'C++ Options', [], sl);
        //-Nc function level linking
        AddOption('function level linking', FALSE, TRUE, TRUE, FALSE,
            0, '-Nc', 'C++ Options', [], NIL);
        //-NL no default library
        AddOption('no default library', FALSE, TRUE, TRUE, FALSE,
            0, '-NL', 'C++ Options', [], NIL);
        //-Ns place expr strings in code seg
        AddOption('place expr strings in code seg', FALSE, TRUE,
            TRUE, FALSE, 0, '-Ns', 'C++ Options', [], NIL);
        //-NS new code seg for each function
        AddOption('new code seg for each function', FALSE, TRUE,
            TRUE, FALSE, 0, '-NS', 'C++ Options', [], NIL);
        //-NTname  set code segment name
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);
        //-NV vtables in far data
        AddOption('vtables in far data', FALSE, TRUE, TRUE, FALSE,
            0, '-NV', 'C++ Options', [], NIL);
        //-o[-+flag]  run optimizer with flag
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);

        //-ooutput  output filename
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);

        //-p  turn off autoprototyping
        AddOption('turn off autoprototyping', FALSE, TRUE, TRUE,
            FALSE, 0, '-p', 'C++ Options', [], NIL);

        //-P  default to pascal linkage
        AddOption('default to pascal linkage', FALSE, TRUE, TRUE,
            FALSE, 0, '-P', 'C++ Options', [], NIL);

        //-Pz default to stdcall linkage
        AddOption('default to stdcall linkage', FALSE, TRUE, TRUE,
            FALSE, 0, '-Pz', 'C++ Options', [], NIL);

        //-r  strict prototyping
        AddOption('strict prototyping', FALSE, TRUE, TRUE, FALSE,
            0, '-r', 'C++ Options', [], NIL);

        //-R  put switch tables in code seg
        AddOption('put switch tables in code seg', FALSE, TRUE,
            TRUE, FALSE, 0, '-R', 'C++ Options', [], NIL);

        //-s  stack overflow checking
        AddOption('stack overflow checking', FALSE, TRUE, TRUE,
            FALSE, 0, '-s', 'C++ Options', [], NIL);

        //-S  always generate stack frame
        AddOption('always generate stack frame', FALSE, TRUE, TRUE,
            FALSE, 0, '-S', 'C++ Options', [], NIL);

        //-u  suppress predefined macros
        AddOption('suppress predefined macros', FALSE, TRUE, TRUE,
            FALSE, 0, '-u', 'C++ Options', [], NIL);

        //-v[0|1|2] verbose compile
        sl := TStringList.Create;
        sl.Add('');
        // /!\ Must contain a starting empty value in order to do not have always to pass the parameter
        sl.Add('0=0');
        sl.Add('1=1');
        sl.Add('2=2');
        AddOption('verbose compile', FALSE, TRUE, TRUE, FALSE, 0,
            '-v', 'C++ Options', [], sl);

        //-w  suppress all warnings
        AddOption('suppress all warnings', FALSE, TRUE, TRUE, FALSE,
            0, '-w', 'C++ Options', [], NIL);

        //-wc warn on C style casts
        AddOption('warn on C style casts', FALSE, TRUE, TRUE, FALSE,
            0, '-wc', 'C++ Options', [], NIL);

        //-wn suppress warning number n
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);

        //-wx treat warnings as errors
        AddOption('treat warnings as errors', FALSE, TRUE, TRUE,
            FALSE, 0, '-wx', 'C++ Options', [], NIL);

        //-W{0123ADabdefmrstuvwx-+}  Windows prolog/epilog
        //?AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);

        //-WA  Windows EXE
        //? AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);

        //-WD  Windows DLL
        //? AddOption('strict ANSI C/C++', false, true, true, false, 0, '/Zg', 'C++ Options', [], nil);

        //-x  turn off error maximum
        AddOption('turn off error maximum', FALSE, TRUE, TRUE, FALSE,
            0, '-x', 'C++ Options', [], NIL);

        //-XD instantiate templates
        AddOption('instantiate templates', FALSE, TRUE, TRUE, FALSE,
            0, '-XD', 'C++ Options', [], NIL);

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
        AddOption('Architecture', FALSE, TRUE, TRUE, FALSE, 0, '-',
            'C++ Options', [], sl);

        //Linker Options
        // /ALIGNMENT	Segment alignment size
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /BASE		Set the base address of the executable image
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /BINARY		Generates a .sys file
        AddOption('Generate a .sys file', FALSE, FALSE, FALSE, TRUE,
            0, '/BINARY', 'Linker Options', [], NIL);

        // /BYORDINAL	Export by ordinal
        AddOption('Export by ordinal', FALSE, FALSE, FALSE, TRUE, 0,
            '/BYORDINAL', 'Linker Options', [], NIL);

        // /CHECKSUM	Parsed and ignored
        AddOption('Parsed and ignored', FALSE, FALSE, FALSE, TRUE, 0,
            '/CHECKSUM', 'Linker Options', [], NIL);

        // /CODEVIEW	Outputs CodeView debugger information
        AddOption('Generate Debugger information', FALSE, FALSE, FALSE,
            TRUE, 0, '/CODEVIEW', 'Linker Options', [], NIL);

        // /COMDEFSEARCH	Specifies whether an undefined COMDEF causes a library search
        AddOption('Specifies whether an undefined COMDEF causes a library search',
            FALSE, FALSE, FALSE, TRUE, 0, 'COMDEFSEARCH', 'Linker Options', [], NIL);

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
        AddOption('Produce detailed map reports', FALSE, FALSE, FALSE,
            TRUE, 0, '/DETAILEDMAP', 'Linker Options', [], NIL);

        // /DOSSEG		Controls segment sequence
        AddOption('Controls segment sequence', FALSE, FALSE, FALSE,
            TRUE, 0, '/DOSSEG', 'Linker Options', [], NIL);

        // /ECHOINDIRECT	Controls echoing of indirect response file input
        AddOption('Controls echoing of indirect response file input',
            FALSE, FALSE, FALSE, TRUE, 0, '/ECHOINDIRECT', 'Linker Options', [], NIL);

        // /EMSMAXSIZE	Sets maximum EMS size
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /EMSPAGEFRAMEIO	Gives permission to use EMS page frame for I/O
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /EMSUSE40	Allow LIM 4.0 adherence
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /ERRORFLAG	Controls error flag in segmented executable header
        AddOption('Controls error flag in segmented executable header',
            FALSE, FALSE, FALSE, TRUE, 0, '/ERRORFLAG', 'Linker Options', [], NIL);

        // /EXEPACK	Performs run-length encoding (packs executable)
        AddOption('Performs run-length encoding (packs executable)',
            FALSE, FALSE, FALSE, TRUE, 0, '/EXEPACK', 'Linker Options', [], NIL);

        // /EXETYPE	Specifies the target operating system
        // multiple AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /FARCALLTRANSLATION Converts intra-segment far calls to near
        AddOption('Converts intra-segment far calls to near', FALSE,
            FALSE, FALSE, TRUE, 0, '/FARCALLTRANSLATION', 'Linker Options', [], NIL);

        // /FIXDS		Identical to the .def directive FIXDS
        AddOption('Identical to the .def directive FIXDS', FALSE, FALSE,
            FALSE, TRUE, 0, '/FIXDS', 'Linker Options', [], NIL);

        // /FIXED		Fixes the executable image in memory
        AddOption('Fixes the executable image in memory', FALSE, FALSE,
            FALSE, TRUE, 0, '/FIXED', 'Linker Options', [], NIL);

        // /GROUPASSOCIATION Controls GROUP information found in .obj
        AddOption('Controls GROUP information found in .obj', FALSE,
            FALSE, FALSE, TRUE, 0, '/GROUPASSOCIATION', 'Linker Options', [], NIL);

        // /GROUPSTACK	Controls stack definition in .exe file header
        AddOption('Controls stack definition in .exe file header', FALSE,
            FALSE, FALSE, TRUE, 0, '/GROUPSTACK', 'Linker Options', [], NIL);

        // /HEAP		Sets the size of the local heap
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /IGNORECASE	Preserves and ignores case of all symbols
        AddOption('Preserves and ignores case of all symbols', FALSE,
            FALSE, FALSE, TRUE, 0, '/IGNORECASE', 'Linker Options', [], NIL);

        // /IMPDEF		Generate .din file from EXPORTS section of .def file
        AddOption('Generate .din file from EXPORTS section of .def file',
            FALSE, FALSE, FALSE, TRUE, 0, '/IMPDEF', 'Linker Options', [], NIL);

        // /IMPLIB		Create .lib import library for .dll
        AddOption('Create .lib import library for .dll', FALSE, FALSE,
            FALSE, TRUE, 0, '/IMPLIB', 'Linker Options', [], NIL);

        // /INFORMATION	Display status information throughout the link process
        AddOption('Display status information throughout the link process',
            FALSE, FALSE, FALSE, TRUE, 0, '/INFORMATION', 'Linker Options', [], NIL);

        // /LINENUMBERS	Outputs line number information in .map file
        AddOption('Outputs line number information in .map file', FALSE,
            FALSE, FALSE, TRUE, 0, '/LINENUMBERS', 'Linker Options', [], NIL);

        // /LOWERCASE	Converts all symbols to lowercase
        AddOption('Converts all symbols to lowercase', FALSE, FALSE,
            FALSE, TRUE, 0, '/LOWERCASE', 'Linker Options', [], NIL);

        // /MACHINE	Specifies the type of the target machine
        AddOption('Specifies the type of the target machine', FALSE,
            FALSE, FALSE, TRUE, 0, '/MACHINE', 'Linker Options', [], NIL);

        // /MAP		Controls information content in .map file
        AddOption('Controls information content in .map file', FALSE,
            FALSE, FALSE, TRUE, 0, '/MAP', 'Linker Options', [], NIL);

        // /NOLOGO		Suppresses OPTLINK's sign-on copyright message
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /NONAMES	Eliminates name text for ordinal exports
        AddOption('Eliminates name text for ordinal exports', FALSE,
            FALSE, FALSE, TRUE, 0, '/NONAMES', 'Linker Options', [], NIL);

        // /NULLDOSSEG	Outputs null bytes in the _TEXT segment
        AddOption('Outputs null bytes in the _TEXT segment', FALSE,
            FALSE, FALSE, TRUE, 0, '/NULLDOSSEG', 'Linker Options', [], NIL);

        // /ONERROR	Same as /DELEXECUTABLE
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /PACKCODE	Combines segments of class CODE
        AddOption('Combines segments of class CODE', FALSE, FALSE, FALSE,
            TRUE, 0, '/PACKCODE', 'Linker Options', [], NIL);

        // /PACKDATA	Combines data segments where possible
        AddOption('Combines data segments where possible', FALSE, FALSE,
            FALSE, TRUE, 0, '/PACKDATA', 'Linker Options', [], NIL);

        // /PACKFUNCTIONS	Performs "smart-linking" on code and data
        AddOption('Performs "smart-linking" on code and data', FALSE,
            FALSE, FALSE, TRUE, 0, '/PACKFUNCTIONS', 'Linker Options', [], NIL);

        // /PACKIFNOSEGMENTS Forces /PACKCODE on when no SEGMENTS directive
        AddOption('Forces /PACKCODE on when no SEGMENTS directive',
            FALSE, FALSE, FALSE, TRUE, 0, '/PACKIFNOSEGMENTS', 'Linker Options', [], NIL);

        // /PACKSIZE	Packs size for /PACKCODE and /PACKDATA
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /PAGESIZE	Set /IMPLIB page size
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /PAUSE		Provides time to swap disks while creating output
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /PMTYPE		Specifies type of segmented output
        AddOption('Specifies type of segmented output', FALSE, FALSE,
            FALSE, TRUE, 0, '/PMTYPE', 'Linker Options', [], NIL);

        // /PROMPT		Specifies whether OPTLINK will prompt for more options
        // AddOption('Specifies whether OPTLINK will prompt for more options', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /RC		Like .def directive RC, automatic resource binding
        AddOption('Like .def directive RC, automatic resource binding',
            FALSE, FALSE, FALSE, TRUE, 0, '/RC', 'Linker Options', [], NIL);

        // /RELOCATIONCHECK Ensures no relocation overlaps have occurred
        AddOption('Ensures no relocation overlaps have occurred', FALSE,
            FALSE, FALSE, TRUE, 0, '/RELOCATIONCHECK', 'Linker Options', [], NIL);

        // /REORDERSEGMENTS Performs segment reordering
        AddOption('Performs segment reordering', FALSE, FALSE, FALSE,
            TRUE, 0, '/REORDERSEGMENTS', 'Linker Options', [], NIL);

        // /SCANLIB	Scans the LIB environment variable
        AddOption('Scans the LIB environment variable', FALSE, FALSE,
            FALSE, TRUE, 0, '/SCANLIB', 'Linker Options', [], NIL);

        // /SCANLINK	Scans the LINK environment variable
        AddOption('Scans the LINK environment variable', FALSE, FALSE,
            FALSE, TRUE, 0, '/SCANLINK', 'Linker Options', [], NIL);

        // /SILENT		Does not display linking status information
        AddOption('Does not display linking status information', FALSE,
            FALSE, FALSE, TRUE, 0, '/SILENT', 'Linker Options', [], NIL);

        // /STACK		Defines stack segment and/ or its size.
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /STUB		Adds a stub file to the executable
        AddOption('Adds a stub file to the executable', FALSE, FALSE,
            FALSE, TRUE, 0, '/STUB', 'Linker Options', [], NIL);

        // /SUBSYSTEM	Sets Win32 subsystem
        // multiple AddOption('Sets Win32 subsystem', False, false, false, true, 0, '/SUBSYSTEM', 'Linker Options', [], nil);

        // /TINY		Generates a .com file
        AddOption('Generates a .com file', FALSE, FALSE, FALSE, TRUE,
            0, '/TINY', 'Linker Options', [], NIL);

        // /UPPERCASE	Converts all symbols to upper case
        AddOption('Converts all symbols to upper case', FALSE, FALSE,
            FALSE, TRUE, 0, '/UPPERCASE', 'Linker Options', [], NIL);

        // /VERSION	Adds a version number to the executable
        AddOption('Adds a version number to the executable', FALSE,
            FALSE, FALSE, TRUE, 0, '/VERSION', 'Linker Options', [], NIL);

        // /WARNDUPS	Warns of duplicate public symbols in .lib
        AddOption('Warns of duplicate public symbols in .lib', FALSE,
            FALSE, FALSE, TRUE, 0, '/WARNDUPS', 'Linker Options', [], NIL);

        // /WINPACK	Build compressed output utilizing decompressing loader
        AddOption('Build compressed output utilizing decompressing loader',
            FALSE, FALSE, FALSE, TRUE, 0, '/WINPACK', 'Linker Options', [], NIL);

        // /XMSMAXSIZE	Sets maximum XMS size
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /XNOIGNORECASE	Treats EXPORT and IMPORT symbols as case significant
        AddOption('Architecture', FALSE, FALSE, FALSE, TRUE, 0, '-',
            'Linker Options', [], NIL);

        // /XREF		Controls information content in .map file
        // AddOption('Architecture', False, false, false, true, 0, '-', 'Linker Options', [], nil);

        // /XUPPERCASE	Forces EXPORT and IMPORT symbols to upper case
        AddOption('Forces EXPORT and IMPORT symbols to upper case',
            FALSE, FALSE, FALSE, TRUE, 0, '/XUPPERCASE', 'Linker Options', [], NIL);
        //End of DMars
    end
    else
    begin
        AddOption(Lang[ID_COPT_ANSIC], FALSE, TRUE, TRUE, FALSE,
            0, '-ansi', Lang[ID_COPT_GRP_C], [], NIL);
        AddOption(Lang[ID_COPT_TRADITIONAL], FALSE, TRUE, TRUE,
            FALSE, 0, '-traditional-cpp', Lang[ID_COPT_GRP_C], [], NIL);
        AddOption(Lang[ID_COPT_WARNING], FALSE, TRUE, TRUE, FALSE,
            0, '-w', Lang[ID_COPT_GRP_C], [], NIL);
        AddOption(Lang[ID_COPT_ACCESS], FALSE, TRUE, TRUE, FALSE,
            0, '-fno-access-control', Lang[ID_COPT_GRP_CPP], [], NIL);
        AddOption(Lang[ID_COPT_DOLLAR], FALSE, TRUE, TRUE, FALSE,
            0, '-fdollar-in-identifiers', Lang[ID_COPT_GRP_CPP], [], NIL);
        AddOption(Lang[ID_COPT_HEURISTICS], FALSE, TRUE, TRUE, FALSE,
            0, '-fsave-memorized', Lang[ID_COPT_GRP_CPP], [], NIL);
        AddOption(Lang[ID_COPT_EXCEPT], FALSE, TRUE, TRUE, FALSE,
            0, '-fexceptions', Lang[ID_COPT_GRP_CODEGEN], [], NIL);
        AddOption(Lang[ID_COPT_DBLFLOAT], FALSE, TRUE, TRUE, FALSE,
            0, '-fshort-double', Lang[ID_COPT_GRP_CODEGEN], [], NIL);
        AddOption(Lang[ID_COPT_MEM], FALSE, TRUE, TRUE, FALSE, 0,
            '-fverbose-asm', Lang[ID_COPT_GRP_CODEGEN], [], NIL);
        AddOption(Lang[ID_COPT_OPTMINOR], FALSE, TRUE, TRUE, FALSE,
            0, '-fexpensive-optimizations', Lang[ID_COPT_GRP_OPTIMIZE], [], NIL);
        AddOption(Lang[ID_COPT_OPT1], TRUE, TRUE, TRUE, FALSE, 0,
            '-O1', Lang[ID_COPT_GRP_OPTIMIZE] + '/' + Lang[ID_COPT_FURTHEROPTS], [], NIL);
        AddOption(Lang[ID_COPT_OPTMORE], TRUE, TRUE, TRUE, FALSE,
            0, '-O2', Lang[ID_COPT_GRP_OPTIMIZE] + '/' + Lang[ID_COPT_FURTHEROPTS], [], NIL);
        AddOption(Lang[ID_COPT_OPTBEST], TRUE, TRUE, TRUE, FALSE,
            0, '-O3', Lang[ID_COPT_GRP_OPTIMIZE] + '/' + Lang[ID_COPT_FURTHEROPTS], [], NIL);
        AddOption(Lang[ID_COPT_PROFILE], FALSE, TRUE, TRUE, FALSE,
            0, '-pg', Lang[ID_COPT_PROFILING], [], NIL);
        AddOption(Lang[ID_COPT_OBJC], FALSE, FALSE, FALSE, TRUE,
            0, '-lobjc', Lang[ID_COPT_LINKERTAB], [], NIL);
        AddOption(Lang[ID_COPT_DEBUG], FALSE, TRUE, TRUE, TRUE, 0,
            '-g3', Lang[ID_COPT_LINKERTAB], [], NIL);
        AddOption(Lang[ID_COPT_NOLIBS], FALSE, TRUE, TRUE, TRUE,
            0, '-nostdlib', Lang[ID_COPT_LINKERTAB], [], NIL);
        AddOption(Lang[ID_COPT_WIN32], FALSE, TRUE, TRUE, TRUE, 0,
            '-mwindows', Lang[ID_COPT_LINKERTAB], [dptGUI], NIL);
        AddOption(Lang[ID_COPT_ERRORLINE], FALSE, TRUE, TRUE, TRUE,
            0, '-fmessage-length=0', Lang[ID_COPT_GRP_C], [], NIL);
        AddOption(Lang[ID_COPT_STRIP], FALSE, FALSE, FALSE, TRUE,
            0, '-s', Lang[ID_COPT_LINKERTAB], [], NIL);

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

        AddOption(Lang[ID_COPT_ARCH], FALSE, TRUE, TRUE, TRUE, 0,
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

        AddOption(Lang[ID_COPT_BUILTINPROC], FALSE, TRUE, TRUE,
            TRUE, 0, '-m', Lang[ID_COPT_GRP_CODEGEN], [], sl);
    end;
end;

procedure TdevCompiler.AddOption(_Name: string;
    _IsGroup, _IsC, _IsCpp, IsLinker: boolean; _Value: integer;
    _Setting, _Section: string; ExcludeFromTypes: TProjTypeSet;
    Choices: TStringList);
var
    P: PCompilerOption;
begin
    P := New(PCompilerOption);
    with P^ do
    begin
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
    end;
    fOptions.Add(P);
end;

procedure TdevCompiler.ClearOptions;
var
    i: integer;
begin
    for i := 0 to fOptions.Count - 1 do
    begin
        if Assigned(PCompilerOption(fOptions.Items[i]).optChoices) then
        begin
            PCompilerOption(fOptions.Items[i]).optChoices.Free;
        end;
        Dispose(fOptions.Items[i]);

    end;
    fOptions.Clear;
end;

constructor TdevCompiler.Create;
begin
    inherited;
    fOptions := TList.Create;
    SettoDefaults;
    LoadSettings;
end;

procedure TdevCompiler.DeleteOption(Index: integer);
begin
    if Assigned(PCompilerOption(fOptions[Index]).optChoices) then
        PCompilerOption(fOptions[Index]).optChoices.Free;
    if Assigned(fOptions[Index]) then
    begin
        Dispose(fOptions[Index]);
        fOptions.Delete(Index);
    end;
end;

destructor TdevCompiler.Destroy;
begin
    ClearOptions;
    if Assigned(fOptions) then
        fOptions.Free;
    inherited;
end;

function TdevCompiler.FindOption(Setting: string; var opt: TCompilerOption;
    var Index: integer): boolean;
var
    I: integer;
begin
    Result := FALSE;
    for I := 0 to fOptions.Count - 1 do
        if Options[I].optSetting = Setting then
        begin
            opt := Options[I];
            Index := I;
            Result := TRUE;
            Break;
        end;
end;

function TdevCompiler.GetOptions(Index: integer): TCompilerOption;
begin
    Result := TCompilerOption(fOptions[Index]^);
end;

function TdevCompiler.GetOptionStr: string;
var
    I: integer;
begin
    Result := '';
    for I := 0 to OptionsCount - 1 do
        Result := Result + BoolVal10[Options[I].optValue];
end;

procedure TdevCompiler.LoadSettings;
var
    s,
    key: string;
    I: integer;
    opt: TCompilerOption;
begin
    with devData do
    begin
        key := 'Compiler';
        fUseParams := LoadBoolSetting(key, 'UseParams');
        fRunParams := LoadSetting(key, 'RunParams');
        fcmdOpts := LoadSetting(key, 'cmdline');
        flinkopts := LoadSetting(key, 'LinkLine');
        fSaveLog := LoadBoolSetting(key, 'Log');
        s := LoadSetting(key, 'Delay');
        if s <> '' then
            fDelay := strtointdef(s, 0);

        CompilerSet := StrToIntDef(LoadSetting(key, 'CompilerSet'), 0);

        S := LoadSetting(key, 'Options');
        for I := 0 to fOptions.Count - 1 do
        begin
            opt := Options[I];
            if (I < Length(S)) and (StrToIntDef(S[I + 1], 0) = 1) then
                opt.optValue := 1
            else
                opt.optValue := 0;
            Options[I] := opt;
        end;

        key := 'Makefile';
        fFastDep := LoadboolSetting(fFastDep, key, 'FastDep');
    end;
end;

function TdevCompiler.OptionsCount: integer;
begin
    Result := fOptions.Count;
end;

procedure TdevCompiler.SaveSettings;
var
    S, key: string;
    I: integer;
begin
    with devData do
    begin
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
        for I := 0 to fOptions.Count - 1 do
            with PCompilerOption(fOptions[I])^ do
                S := S + BoolVal10[optValue];
        SaveSetting(key, 'Options', S);

        key := 'Makefile';
        SaveBoolSetting(key, 'FastDep', fFastDep);
    end;
end;

procedure TdevCompiler.SetCompilerSet(const Value: integer);
begin
    if fCompilerSet = Value then
        Exit;
    if not Assigned(devCompilerSet) then
        devCompilerSet := TdevCompilerSet.Create;
    devCompilerSet.LoadSet(Value);
    // Programs
    fCompilerSet := Value;
    if devDirs.OriginalPath = '' then // first time only
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
end;

procedure TdevCompiler.SetOptions(Index: integer;
    const Value: TCompilerOption);
begin
    with TCompilerOption(fOptions[Index]^) do
    begin
        optName := Value.optName;
        optIsGroup := Value.optIsGroup;
        optIsC := Value.optIsC;
        optIsCpp := Value.optIsCpp;
        optValue := Value.optValue;
        optSetting := Value.optSetting;
        optSection := Value.optSection;
    end;
end;

procedure TdevCompiler.SetOptionStr(const Value: string);
var
    I: integer;
begin
    for I := 0 to fOptions.Count - 1 do
        if (I < Length(Value)) then
        begin
            PCompilerOption(fOptions[I])^.optValue :=
                ConvertCharToValue(Value[I + 1]);
        end;
end;

function TdevCompiler.ConvertCharToValue(c: char): integer;
begin
    if c in ['a'..'z'] then
        result := integer(c) - integer('a') + 2
    else
    if (StrToIntDef(c, 0) = 1) then
        result := 1
    else
        result := 0;
end;

procedure TdevCompiler.SettoDefaults;
begin
    fRunParams := '';
    fUseParams := FALSE;
    fSaveLog := FALSE;
    fcmdOpts := '';
    flinkOpts := '';
    fDelay := 0;

    // makefile
    fFastDep := FALSE;

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
end;


{ TDevDirs }

constructor TdevDirs.Create;
begin
    inherited Create;
    Name := OPT_DIRS;
    fCompilerType := 0;
    SettoDefaults;
    LoadSettings;
    fConfig := '';
end;

procedure TdevDirs.SettoDefaults;
var
    tempstr: string;
{$IFDEF PLUGIN_BUILD}
    i: integer;
    dummy: string;
{$ENDIF PLUGIN_BUILD}
begin
    fBinDir := ValidatePaths(BIN_DIR(fCompilerType), tempstr);
    fCDir := ValidatePaths(C_INCLUDE_DIR(fCompilerType), tempstr);
    fCppDir := ValidatePaths(CPP_INCLUDE_DIR(fCompilerType), tempstr);

    fLibDir := ValidatePaths(LIB_DIR(fCompilerType), tempstr);
{$IFDEF PLUGIN_BUILD}
    fRCDir := ValidatePaths(RC_INCLUDE_DIR(fCompilerType), tempstr);
    if MainForm <> NIL then
    begin
        for i := 0 to MainForm.pluginsCount - 1 do
        begin
            if (fCppDir = '') then
                fCppDir := fCppDir +
                    ValidatePaths(MainForm.plugins[i].GET_COMMON_CPP_INCLUDE_DIR, dummy)
            // EAB TODO: make it multiplugin functional.
            else
                fCppDir := fCppDir + ';' +
                    ValidatePaths(MainForm.plugins[i].GET_COMMON_CPP_INCLUDE_DIR, dummy);
            // EAB TODO: make it multiplugin functional.
        end;
    end;

{$ELSE}
  fRCDir  := '';
{$ENDIF}

    if (fCompilerType = ID_COMPILER_LINUX) then
    begin
        fCppDir := '';
        fCDir := '';
        fRCDir := '';
        fBinDir := '/usr/local/sbin;/usr/local/bin;/usr/sbin;/usr/bin;/sbin;/bin';
    end;

    fExec := ExtractFilePath(Application.ExeName);
    if (fConfig = '') then
        // EAB: workaround because of weird calls from InitializeOptionsAfterPlugins that can't be removed for now, or compiler folders get screwed.
        fConfig := fExec;
    fHelp := fExec + HELP_DIR;
    fIcons := fExec + ICON_DIR;
    fLang := fExec + LANGUAGE_DIR;
    fTemp := fExec + TEMPLATE_DIR;
    fThemes := fExec + THEME_DIR;
    fOldPath := GetEnvironmentVariable('PATH');
end;

procedure TdevDirs.LoadSettings;
begin
    devData.LoadObject(Self);
    fExec := ExtractFilePath(Application.ExeName);
    if fHelp = '' then
        fHelp := fExec + HELP_DIR;
    if fIcons = '' then
        fIcons := fExec + ICON_DIR;
    if fLang = '' then
        fLang := fExec + LANGUAGE_DIR;
    if fTemp = '' then
        fTemp := fExec + TEMPLATE_DIR;
    if fThemes = '' then
        fThemes := fExec + THEME_DIR;
    FixPaths;
end;

procedure TdevDirs.SaveSettings;
begin
    fHelp := ExtractRelativePath(fExec, fHelp);
    fIcons := ExtractRelativePath(fExec, fIcons);
    fLang := ExtractRelativePath(fExec, fLang);
    fTemp := ExtractRelativePath(fExec, fTemp);
    fThemes := ExtractRelativePath(fExec, fThemes);
    devData.SaveObject(Self);
    FixPaths;
end;

function TdevDirs.CallValidatePaths(dirList: string): string;
var
    dummy: string;
begin
    Result := ValidatePaths(dirList, dummy);
end;

procedure TdevDirs.FixPaths;
begin
    // if we are called by double-clicking a .dev file in explorer,
    // we must perform the next checks or else the dirs are
    // really screwed up...
    // Basically it checks if it is a relative path (as it should be).
    // If so, it prepends the base Dev-C++ directory...
    if ExtractFileDrive(fHelp) = '' then
        fHelp := fExec + fHelp;
    if ExtractFileDrive(fIcons) = '' then
        fIcons := fExec + fIcons;
    if ExtractFileDrive(fLang) = '' then
        fLang := fExec + fLang;
    if ExtractFileDrive(fTemp) = '' then
        fTemp := fExec + fTemp;
    if ExtractFileDrive(fThemes) = '' then
        fThemes := fExec + fThemes;
end;

{ TDevEditor }

constructor TdevEditor.Create;
begin
    inherited;
    Name := OPT_EDITOR;

    fFont := TFont.Create;
    fGutterfont := TFont.Create;
    fSyntax := TStringList.Create;
    TStringList(fSynTax).Duplicates := dupIgnore;
    SettoDefaults;
    LoadSettings;
end;

destructor TdevEditor.Destroy;
begin
    if Assigned(fFont) then
        fFont.Free;
    if Assigned(fGutterfont) then
        fGutterfont.Free;
    if Assigned(fSynTax) then
        fSynTax.Free;
    inherited;
end;

procedure TdevEditor.LoadSettings;
begin
    devData.LoadObject(Self);
end;

procedure TdevEditor.SaveSettings;
begin
    devData.SaveObject(Self);
end;

procedure TdevEditor.SettoDefaults;
begin
    fFont.name := 'Courier New';
    fFont.Size := 10;
    fTabSize := 4;
    fShowGutter := TRUE;
    fCustomGutter := TRUE;
    fGutterSize := 32;
    fGutterFont.Name := 'Terminal';
    fGutterFont.Size := 9;
    fGutterAuto := FALSE;
    GutterGradient := TRUE;

    fInsertCaret := 0;
    fOverwriteCaret := 0;

    fMarginVis := TRUE;
    fMarginSize := 80;
    fMarginColor := cl3DLight;

    fGroupUndo := TRUE;

    fLineNumbers := FALSE;
    fLeadZero := FALSE;
    fFirstisZero := FALSE;
    fEHomeKey := FALSE;

    fShowScrollHint := TRUE;
    fShowScrollbars := TRUE;
    fHalfPage := FALSE;

    fPastEOF := FALSE;
    fPastEOL := FALSE;
    fTrailBlanks := FALSE;
    fdblLine := FALSE;
    fFindText := TRUE;

    fAutoCloseBrace := FALSE; // not working well/turned off

    fInsertMode := TRUE;
    fAutoIndent := TRUE;
    fSmartTabs := FALSE;
    fSmartUnindent := TRUE;
    fTabtoSpaces := TRUE;

    fUseSyn := TRUE;
    //last ; is for files with no extension
    //which should be treated as cpp header files
    fSynExt := 'c;cpp;h;hpp;cc;cxx;cp;hp;rh;inl;';

    fParserHints := TRUE;
    fMatch := FALSE;

    fHighCurrLine := TRUE;
    fHighColor := $FFFFCC; //Light Turquoise

    //fCodeFolding := True;

    fAppendNewline := TRUE;
end;

procedure TdevEditor.AssignEditor(Editor: TSynEdit);
var
    pt: TPoint;
    x: integer;
begin
    if (not assigned(Editor)) or (not (Editor is TCustomSynEdit)) then
        exit;
    with Editor do
    begin
        BeginUpdate;
        try
            TabWidth := fTabSize;

            Font.Assign(fFont);
            with Gutter do
            begin
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
                if x <> -1 then
                begin
                    StrtoPoint(pt, fSyntax.Values[cGut]);
                    Color := pt.x;
                    Font.Color := pt.y;
                end;
            end;

            if fMarginVis then
                RightEdge := fMarginSize
            else
                RightEdge := 0;

            RightEdgeColor := fMarginColor;

            InsertCaret := TSynEditCaretType(fInsertCaret);
            OverwriteCaret := TSynEditCaretType(fOverwriteCaret);

            ScrollHintFormat := shfTopToBottom;

            if HighCurrLine then
                ActiveLineColor := HighColor
            else
                ActiveLineColor := clNone;

            Options := [
                eoAltSetsColumnMode, eoDisableScrollArrows,
                eoDragDropEditing, eoDropFiles, eoKeepCaretX,
                //eoAutoSizeMaxLeftChar was replaced by eoAutoSizeMaxScrollWidth
                eoRightMouseMovesCursor, eoScrollByOneLess, eoAutoSizeMaxScrollWidth
                {eoNoCaret, eoNoSelection, eoScrollHintFollows, }
                ];

            //Optional synedit options in devData
            if fAutoIndent then
                Options := Options + [eoAutoIndent];
            if fEHomeKey then
                Options := Options + [eoEnhanceHomeKey];
            if fGroupUndo then
                Options := Options + [eoGroupUndo];
            if fHalfPage then
                Options := Options + [eoHalfPageScroll];
            if fShowScrollbars then
                Options := Options + [eoHideShowScrollbars];
            if fPastEOF then
                Options := Options + [eoScrollPastEOF];
            if fPastEOL then
                Options := Options + [eoScrollPastEOL];
            if fShowScrollHint then
                Options := Options + [eoShowScrollHint];
            if fSmartTabs then
                Options := Options - [eoSmartTabs];
            if fSmartTabs then
                Options := Options + [eoSmartTabDelete];
            if fTabtoSpaces then
                Options := Options + [eoTabsToSpaces];
            if fTrailBlanks then
                Options := Options + [eoTrimTrailingSpaces];
            if fSpecialChar then
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
        finally
            EndUpdate;
        end;
    end;
end;


{ TdevCodeCompletion }

constructor TdevCodeCompletion.Create;
begin
    inherited Create;
    Name := 'CodeCompletion';
    fCacheFiles := TStringList.Create;
    SettoDefaults;
    LoadSettings;
end;

destructor TdevCodeCompletion.Destroy;
begin
    if Assigned(fCacheFiles) then
        fCacheFiles.Free;
end;

procedure TdevCodeCompletion.LoadSettings;
begin
    devData.LoadObject(Self);
end;

procedure TdevCodeCompletion.SaveSettings;
begin
    devData.SaveObject(Self);
end;

procedure TdevCodeCompletion.SetDelay(Value: integer);
begin
    fDelay := Max(1, Value); // minimum 1 msec
end;

procedure TdevCodeCompletion.SettoDefaults;
begin
    fWidth := 320;
    fHeight := 240;
    fDelay := 500;
    fBackColor := clWindow;
    fEnabled := TRUE;
    fUseCacheFiles := FALSE;
end;

{ TdevClassBrowsing }

constructor TdevClassBrowsing.Create;
begin
    inherited Create;
    Name := 'ClassBrowsing';
    SettoDefaults;
    LoadSettings;
end;

procedure TdevClassBrowsing.LoadSettings;
begin
    devData.LoadObject(Self);
end;

procedure TdevClassBrowsing.SaveSettings;
begin
    devData.SaveObject(Self);
end;

procedure TdevClassBrowsing.SettoDefaults;
begin
    fCBViewStyle := 0;
    fEnabled := TRUE;
    fParseLocalHeaders := FALSE;
    fParseGlobalHeaders := FALSE;
    fShowFilter := 0;
    fUseColors := TRUE;
    fShowInheritedMembers := FALSE;
end;

{ TdevCVSHandler }

constructor TdevCVSHandler.Create;
begin
    inherited Create;
    Name := 'CVSHandler';
    fRepositories := TStringList.Create;
    SettoDefaults;
    LoadSettings;
end;

destructor TdevCVSHandler.Destroy;
begin
    fRepositories.Free;
end;

procedure TdevCVSHandler.LoadSettings;
begin
    devData.LoadObject(Self);
end;

procedure TdevCVSHandler.SaveSettings;
begin
    devData.SaveObject(Self);
end;

procedure TdevCVSHandler.SettoDefaults;
begin
    fExecutable := 'cvs.exe';
    fCompression := 4;
    fUseSSH := TRUE;
end;

{ TdevCompilerSet }
procedure TdevCompilerSet.LoadDefaultCompilerDefaults;
begin
    devCompilerSet.BinDir := BIN_DIR(CompilerType);
    devCompilerSet.CDir := C_INCLUDE_DIR(CompilerType);
    devCompilerSet.CppDir := CPP_INCLUDE_DIR(CompilerType);
    devCompilerSet.LibDir := LIB_DIR(CompilerType);

    devDirs.Bins := devCompilerSet.BinDir;
    devDirs.C := devCompilerSet.CDir;
    devDirs.Cpp := devCompilerSet.CppDir;
    devDirs.Lib := devCompilerSet.LibDir;
end;

procedure TdevCompilerSet.AssignToCompiler;
var
    tempstr: string;
begin
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

    if ((devCompiler.CompilerType = ID_COMPILER_MINGW) or
        (devCompiler.CompilerType = ID_COMPILER_LINUX)) then
    begin
        OBJ_EXT := '.o';
        LIB_EXT := '.a';
        PCH_EXT := '.h.gch';
    end
    else
    begin
        OBJ_EXT := '.obj';
        LIB_EXT := '.lib';
        PCH_EXT := '.pch';
    end;

    devCompiler.AddDefaultOptions;
    devCompiler.OptionStr := OptionsStr;
end;

constructor TdevCompilerSet.Create;
begin
    inherited;
    fSets := TStringList.Create;
    UpdateSets;
    SettoDefaults;
end;

destructor TdevCompilerSet.Destroy;
begin
    if Assigned(fSets) then
        fSets.Free;
    inherited;
end;

procedure TdevCompilerSet.LoadSet(Index: integer);
begin
    Name := Sets[Index];
    LoadSetProgs(Index);
    LoadSetDirs(Index);
end;

procedure TdevCompilerSet.LoadSetDirs(Index: integer);
var
    key: string;
    goodBinDir, goodCDir, goodCppDir, goodLibDir {$IFDEF PLUGIN_BUILD},
    goodRCDir{$ENDIF}: string;
    msg: string;
    tempStr: string;
   // maindir: String;
    //makeSig, mingwmakeSig: String;
    defaultDataForPlugins: boolean;
    dummy: string;
    i: integer;
begin
    defaultDataForPlugins := FALSE;
    if Index < 0 then
        Exit;

    with devData do
    begin

        key := OPT_COMPILERSETS + '_' + IntToStr(Index);

        // EAB: Temporary hack to fix Cpp includes in wxdsgn plugin if you enable the devpack after using vanilla version:
        // A proper solution requires more descriptive information of the plugins recent installation status.
        if MainForm <> NIL then
        begin
            if MainForm.pluginsCount > 0 then
            begin
                try
                    if (LoadSetting(key, 'wxOpts.Static') = '') then
                        defaultDataForPlugins := TRUE;
                except
                    defaultDataForPlugins := TRUE;
                end;
            end;
        end;

        // dirs
        fBinDir := LoadSetting(key, 'Bins');
        if fBinDir = '' then
            fBinDir := devDirs.Bins;
        fCDir := LoadSetting(key, 'C');
        if fCDir = '' then
            fCDir := devDirs.C;
        fCppDir := LoadSetting(key, 'Cpp');
        if fCppDir = '' then
            fCppDir := devDirs.Cpp
        else
        if defaultDataForPlugins then
        begin
            for i := 0 to MainForm.pluginsCount - 1 do
                fCppDir := fCppDir + ';' +
                    ValidatePaths(MainForm.plugins[i].GET_COMMON_CPP_INCLUDE_DIR, dummy);
        end;
        begin
        end;
        fLibDir := LoadSetting(key, 'Lib');
        if fLibDir = '' then
            fLibDir := devDirs.Lib;
        fRcDir := LoadSetting(key, 'RC');
        if fRcDir = '' then
            fRcDir := devDirs.RC;

        //check for valid paths
        msg := '';
        goodBinDir := ValidatePaths(fBinDir, tempStr);
        if ((tempStr <> '')) then
        begin
            msg := msg + 'Following Bin directories don''t exist:' + #13#10;
            msg := msg + StringReplace(tempStr, ';', #13#10, [rfReplaceAll]);
            msg := msg + #13#10 + #13#10;
        end;
        goodCDir := ValidatePaths(fCDir, tempStr);
        if ((tempStr <> '')) then
        begin
            msg := msg + 'Following C Include directories don''t exist:' + #13#10;
            msg := msg + StringReplace(tempStr, ';', #13#10, [rfReplaceAll]);
            msg := msg + #13#10 + #13#10;
        end;
        goodCppDir := ValidatePaths(fCppDir, tempStr);
        if ((tempStr <> '')) then
        begin
            msg := msg + 'Following C++ Include directories don''t exist:' + #13#10;
            msg := msg + StringReplace(tempStr, ';', #13#10, [rfReplaceAll]);
            msg := msg + #13#10 + #13#10;
        end;
        goodLibDir := ValidatePaths(fLibDir, tempStr);
        if ((tempStr <> '')) then
        begin
            msg := msg + 'Following Libs directories don''t exist:' + #13#10;
            msg := msg + StringReplace(tempStr, ';', #13#10, [rfReplaceAll]);
            msg := msg + #13#10 + #13#10;
        end;
     {$IFDEF PLUGIN_BUILD}

        goodRCDir := ValidatePaths(fRCDir, tempStr);
        if tempStr <> '' then
        begin
            msg := msg + 'Following resource compiler directories don''t exist:'
                + #13#10;
            msg := msg + StringReplace(tempStr, ';', #13#10, [rfReplaceAll]);
            msg := msg + #13#10 + #13#10;
        end;
     {$ENDIF}

    end;

    //check if make is in path + bins directory
    SetPath(devDirs.Bins);

end;

procedure TdevCompilerSet.LoadSetProgs(Index: integer);
var
    key: string;
begin

    if Index < 0 then
        Exit;
    with devData do
    begin
        key := OPT_COMPILERSETS + '_' + IntToStr(Index);
        if (LoadSetting(key, 'CompilerType') <> '') then
            fCompilerType := StrToIntDef(LoadSetting(key, 'CompilerType'), 0);
        self.SetToDefaults;

        // Programs
        fgccName := LoadSetting(key, CP_PROGRAM(CompilerType));
        if fgccName = '' then
            fgccName := CP_PROGRAM(CompilerType);
        fgppName := LoadSetting(key, CPP_PROGRAM(CompilerType));
        if fgppName = '' then
            fgppName := CPP_PROGRAM(CompilerType);
        fgdbName := LoadSetting(key, DBG_PROGRAM(CompilerType));
        if fgdbName = '' then
            fgdbName := DBG_PROGRAM(CompilerType);
        fmakeName := LoadSetting(key, MAKE_PROGRAM(CompilerType));
        if fmakeName = '' then
            fmakeName := MAKE_PROGRAM(CompilerType);
        fwindresName := LoadSetting(key, RES_PROGRAM(CompilerType));
        if fwindresName = '' then
            fwindresName := RES_PROGRAM(CompilerType);
        fgprofName := LoadSetting(key, PROF_PROGRAM(CompilerType));
        if fgprofName = '' then
            fgprofName := PROF_PROGRAM(CompilerType);
        fdllwrapName := LoadSetting(key, DLL_PROGRAM(CompilerType));
        if fdllwrapName = '' then
            fdllwrapName := DLL_PROGRAM(CompilerType);

        fOptions := LoadSetting(key, 'Options');
        fCmdOptions := LoadSetting(key, 'cmdline');
        if (fCmdOptions = '') then
            fCmdOptions := COMPILER_CMD_LINE(CompilerType);

        fLinkOptions := LoadSetting(key, 'LinkLine');
        if (fLinkOptions = '') then
            fLinkOptions := LINKER_CMD_LINE(CompilerType);

        fMakeOptions := LoadSetting(key, 'MakeLine');
        if (fMakeOptions = '') then
            fMakeOptions := MAKE_CMD_LINE(CompilerType);

        if LoadSetting(key, 'CheckSyntax') <> '' then
            fCheckSyntaxFormat := LoadSetting(key, 'CheckSyntax');
        if LoadSetting(key, 'OutputFormat') <> '' then
            fOutputFormat := LoadSetting(key, 'OutputFormat');
        if LoadSetting(key, 'ResourceInclude') <> '' then
            fResourceIncludeFormat := LoadSetting(key, 'ResourceInclude');
        if LoadSetting(key, 'ResourceFormat') <> '' then
            fResourceFormat := LoadSetting(key, 'ResourceFormat');
        if LoadSetting(key, 'LinkerFormat') <> '' then
            fLinkerFormat := LoadSetting(key, 'LinkerFormat');
        if LoadSetting(key, 'LinkerPaths') <> '' then
            LinkerPaths := LoadSetting(key, 'LinkerPaths');
        if LoadSetting(key, 'IncludeFormat') <> '' then
            fIncludeFormat := LoadSetting(key, 'IncludeFormat');
        if LoadSetting(key, 'DllFormat') <> '' then
            fDllFormat := LoadSetting(key, 'DllFormat');
        if LoadSetting(key, 'LibFormat') <> '' then
            fLibFormat := LoadSetting(key, 'LibFormat');
        if LoadSetting(key, 'SingleCompile') <> '' then
            fSingleCompile := LoadSetting(key, 'SingleCompile');
        if LoadSetting(key, 'PreprocDefines') <> '' then
            fPreprocDefines := LoadSetting(key, 'PreprocDefines');
        if LoadSetting(key, 'PchCreateFormat') <> '' then
            fPchCreateFormat := LoadSetting(key, 'PchCreateFormat');
        if LoadSetting(key, 'PchUseFormat') <> '' then
            fPchUseFormat := LoadSetting(key, 'PchUseFormat');
        if LoadSetting(key, 'PchFileFormat') <> '' then
            fPchFileFormat := LoadSetting(key, 'PchFileFormat');

{$IFDEF PLUGIN_BUILD}// Loading Compiler settings:
        optComKey := key;
{$ENDIF PLUGIN_BUILD}
    end;
end;

procedure TdevCompilerSet.LoadSettings;
begin
    LoadSet(0);
end;

procedure TdevCompilerSet.SaveSet(Index: integer);
begin
    SaveSetProgs(Index);
    SaveSetDirs(Index);
end;

procedure TdevCompilerSet.SaveSetDirs(Index: integer);
var
    key: string;
begin
    if Index < 0 then
        Exit;
    with devData do
    begin
        key := OPT_COMPILERSETS + '_' + IntToStr(Index);
        // dirs

        SaveSetting(key, 'Bins', fBinDir);
        SaveSetting(key, 'C', fCDir);
        SaveSetting(key, 'Cpp', fCppDir);
        SaveSetting(key, 'Lib', fLibDir);
        SaveSetting(key, 'RC', fRcDir);
    end;
end;

procedure TdevCompilerSet.SaveSetProgs(Index: integer);
var
    key: string;
{$IFDEF PLUGIN_BUILD}
    i, j: integer;
    pluginSettings: TSettings;
{$ENDIF PLUGIN_BUILD}
begin

{$IFDEF PLUGIN_BUILD}
    pluginSettings := NIL;
{$ENDIF PLUGIN_BUILD}

    if Index < 0 then
        Exit;

    with devData do
    begin
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
        if MainForm <> NIL then
        begin
            for i := 0 to MainForm.pluginsCount - 1 do
            begin
                pluginSettings := MainForm.plugins[i].GetCompilerOptions;
                for j := 0 to Length(pluginSettings) - 1 do
                    SaveSetting(key, pluginSettings[j].name,
                        pluginSettings[j].value);
            end;
        end;
{$ENDIF PLUGIN_BUILD}
    end;
end;

procedure TdevCompilerSet.SaveSettings;
begin
    WriteSets;
end;

function TdevCompilerSet.SetName(Index: integer): string;
begin
    if (Index >= 0) and (Index < devCompilerSet.Sets.Count) then
        Result := devCompilerSet.Sets[Index]
    else
        Result := DEFCOMPILERSET(CompilerType);
end;

procedure TdevCompilerSet.SettoDefaults;
var
    tempstr: string;
begin

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

    if CompilerType in ID_COMPILER_VC then
    begin
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
    end
    else
    if CompilerType = ID_COMPILER_DMARS then
    begin
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
    end
    else
    if ((CompilerType = ID_COMPILER_MINGW) or
        (CompilerType = ID_COMPILER_LINUX)) then
    begin
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
    end;

    // dirs
    fBinDir := devDirs.Bins;
    fCDir := devDirs.C;
    fCppDir := devDirs.Cpp;
    // + ';' + ValidatePaths(CPP_INCLUDE_DIR(fCompilerType), tempstr);   // EAB TODO: Check if this is a good solution for plugins and COMMON_CPP_INCLUDE_DIR
    fLibDir := devDirs.Lib;
    fRCDir := devDirs.RC;

end;

procedure TdevCompilerSet.UpdateSets;
var
    Ini: TIniFile;
    sl: TStringList;
    I: integer;
begin
    fSets.Clear;
    Ini := TIniFile.Create(devData.INIFile);
    sl := TStringList.Create;
    try
        Ini.ReadSectionValues(OPT_COMPILERSETS, sl);

        for I := 0 to sl.Count - 1 do
            fSets.Add(sl.Values[sl.Names[I]]);

    finally
        sl.Free;
        Ini.Free;
    end;
end;

procedure TdevCompilerSet.WriteSets;
var
    Ini: TIniFile;
    I: integer;
begin
    Ini := TIniFile.Create(devData.INIFile);
    try
        Ini.EraseSection(OPT_COMPILERSETS);
        for I := 0 to fSets.Count - 1 do
            Ini.WriteString(OPT_COMPILERSETS, IntToStr(I), fSets[I]);
    finally
        Ini.Free;
    end;
end;

{ TdevExternalPrograms }

function TdevExternalPrograms.AddProgram(ext, prog: string): integer;
var
    idx: integer;
begin
    if ext = '' then
    begin
        Result := -1;
        Exit;
    end;

    idx := AssignedProgram(ext);
    if idx = -1 then
        Result := fPrograms.Add(ext + '=' + prog)
    else
    begin
        fPrograms.Values[fPrograms.Names[idx]] := prog;
        Result := idx;
    end;
end;

function TdevExternalPrograms.AssignedProgram(ext: string): integer;
var
    I: integer;
begin
    Result := -1;
    for I := 0 to fPrograms.Count - 1 do
        if UpperCase(fPrograms.Names[I]) = UpperCase(ext) then
        begin
            Result := I;
            Break;
        end;
end;

constructor TdevExternalPrograms.Create;
begin
    inherited Create;
    Name := 'ExternalPrograms';
    fPrograms := TStringList.Create;
    SettoDefaults;
    LoadSettings;
end;

destructor TdevExternalPrograms.Destroy;
begin
    if Assigned(fPrograms) then
        fPrograms.Free;
end;

function TdevExternalPrograms.GetProgramName(Index: integer): string;
begin
    Result := fPrograms.Values[fPrograms.Names[Index]];
end;

procedure TdevExternalPrograms.LoadSettings;
begin
    devData.LoadObject(Self);
end;

procedure TdevExternalPrograms.SaveSettings;
begin
    devData.SaveObject(Self);
end;

procedure TdevExternalPrograms.SetToDefaults;
begin
    inherited;

end;

{$IFDEF PLUGIN_BUILD}
{ TdevPluginToolbarsX }

function TdevPluginToolbarsX.AddToolbarsX(plugin_name: string;
    x: integer): integer;
var
    idx: integer;
begin
    if plugin_name = '' then
    begin
        Result := -1;
        Exit;
    end;

    idx := AssignedToolbarsX(plugin_name);
    if idx = -1 then
        Result := fPluginToolbarsX.Add(plugin_name + '=' + IntToStr(x))
    else
    begin
        fPluginToolbarsX.Values[fPluginToolbarsX.Names[idx]] := IntToStr(x);
        Result := idx;
    end;
end;

function TdevPluginToolbarsX.AssignedToolbarsX(plugin_name: string): integer;
var
    I: integer;
begin
    Result := -1;
    for I := 0 to fPluginToolbarsX.Count - 1 do
        if UpperCase(fPluginToolbarsX.Names[I]) = UpperCase(plugin_name) then
        begin
            Result := I;
            Break;
        end;
end;

constructor TdevPluginToolbarsX.Create;
begin
    inherited Create;
    Name := 'ToolbarsX';
    fPluginToolbarsX := TStringList.Create;
    SettoDefaults;
    LoadSettings;
end;

destructor TdevPluginToolbarsX.Destroy;
begin
    if Assigned(fPluginToolbarsX) then
        fPluginToolbarsX.Free;
end;

function TdevPluginToolbarsX.GetToolbarsXName(Index: integer): string;
begin
    Result := fPluginToolbarsX.Values[fPluginToolbarsX.Names[Index]];
end;

procedure TdevPluginToolbarsX.LoadSettings;
begin
    devData.LoadObject(Self);
end;

procedure TdevPluginToolbarsX.SaveSettings;
begin
    devData.SaveObject(Self);
end;

procedure TdevPluginToolbarsX.SetToDefaults;
begin
    inherited;

end;

{ TdevPluginToolbarsY }

function TdevPluginToolbarsY.AddToolbarsY(plugin_name: string;
    y: integer): integer;
var
    idx: integer;
begin
    if plugin_name = '' then
    begin
        Result := -1;
        Exit;
    end;

    idx := AssignedToolbarsY(plugin_name);
    if idx = -1 then
        Result := fPluginToolbarsY.Add(plugin_name + '=' + IntToStr(y))
    else
    begin
        fPluginToolbarsY.Values[fPluginToolbarsY.Names[idx]] := IntToStr(y);
        Result := idx;
    end;
end;

function TdevPluginToolbarsY.AssignedToolbarsY(plugin_name: string): integer;
var
    I: integer;
begin
    Result := -1;
    for I := 0 to fPluginToolbarsY.Count - 1 do
        if UpperCase(fPluginToolbarsY.Names[I]) = UpperCase(plugin_name) then
        begin
            Result := I;
            Break;
        end;
end;

constructor TdevPluginToolbarsY.Create;
begin
    inherited Create;
    Name := 'ToolbarsY';
    fPluginToolbarsY := TStringList.Create;
    SettoDefaults;
    LoadSettings;
end;

destructor TdevPluginToolbarsY.Destroy;
begin
    if Assigned(fPluginToolbarsY) then
        fPluginToolbarsY.Free;
end;

function TdevPluginToolbarsY.GetToolbarsYName(Index: integer): string;
begin
    Result := fPluginToolbarsY.Values[fPluginToolbarsY.Names[Index]];
end;

procedure TdevPluginToolbarsY.LoadSettings;
begin
    devData.LoadObject(Self);
end;

procedure TdevPluginToolbarsY.SaveSettings;
begin
    devData.SaveObject(Self);
end;

procedure TdevPluginToolbarsY.SetToDefaults;
begin
    inherited;

end;
{$ENDIF PLUGIN_BUILD}

initialization

finalization
    fdevData.Free;
    devCompiler.Free;
    devCompilerSet.Free;
    devDirs.Free;
    devEditor.Free;
    devCodeCompletion.Free;
    devClassBrowsing.Free;
    devCVSHandler.Free;
    devExternalPrograms.Free;

end.
