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

unit debugger;

//{$DEFINE DISPLAYOUTPUT}   // enable byte count output in ReadThread for debugging
//{$DEFINE DISPLAYOUTPUTHEX}// enable debugging display of GDB output
//  in 'HEX Editor' style

interface

uses
    Classes, editor, Sysutils, version, debugCPU

    {$IFDEF WIN32}
    , ComCtrls, Controls, Dialogs, ShellAPI, Windows
    {$ENDIF}
    {$IFDEF LINUX}
    , QComCtrls, QControls, QDialogs
    {$ENDIF};

var
    //output from GDB
    TargetIsRunning: boolean = FALSE;       // result of status messages
    gui_critSect: TRTLCriticalSection;
    // Why do we need this? Once the pipe
    // has been read, all processing is in
    // the Main Thread anyway!!!
    // Answer: Only when using debugging display
    // - and then there's little chance of conflict!

    Send_critSect: TRTLCriticalSection;
    // Not sure this is necessary either...
    //  we WRITE from only one place,
    //  we have our own handshake?

    // Globals for the Reader buffer data
    bytesInBuffer: DWORD;   // Number of unprocessed bytes
    buf: pchar;             // The main buffer into which data is read


{$IFDEF DISPLAYOUTPUTHEX}
// (Global because it is a useful data analysis tool).
procedure HexDisplay(buf: PChar; LastRead: DWORD);
{$ENDIF}

// These don't really belong in T(GDB)Debugger
function AnsiBeforeFirst(Sub: string; Target: string): string;
function AnsiAfterFirst(Sub: string; Target: string): string;
function AnsiAfterLast(Sub: string; Target: string): string;
function AnsiFindLast(Src: string; Target: string): integer;
function AnsiLeftStr(const AText: string; ACount: integer): string;
function AnsiMidStr(const AText: string;
    const AStart, ACount: integer): string;
function AnsiRightStr(const AText: string; ACount: integer): string;
function unescape(s: PString): string;
function OctToHex(s: PString): string;


const GDBPrompt: string = '(gdb)';
const GDBerror: string = 'error,';
const GDBdone: string = 'done,';
const GDBaddr: string = 'addr=';
const GDBaddress: string = 'address=';
const GDBall: string = 'all';
const GDBarg: string = 'arg-begin';
const GDBasminst: string = 'asm_insns=';
const GDBasmline: string = 'line_asm_insns=';
const GDBassignerror: string = 'error,mi_cmd_var_assign: Variable object is not editable"';
const GDBbegin: string = 'begin';
const GDBbkpt: string = 'bkpt={';
const GDBbpoint: string = 'breakpoint';
const GDBbkpthit: string = 'breakpoint-hit';
const GDBbkptno: string = 'bkptno';
const GDBbkpttable: string = 'BreakpointTable={';
const GDBbody: string = 'body=[';
const GDBbrkins: string = '-break-insert ';
const GDBbrkdel: string = '-break-delete ';
const GDBbrkwatch: string = '-break-watch ';
const GDBcontents: string = 'contents';
const GDBcontinue: string = '-exec-continue';
const GDBcontext: string = '--thread %d --frame %d';
const GDBcurthread: string = 'current-thread-id';
const GDBdataeval: string = '-data-evaluate-expression ';
const GDBDisassem: string = '-data-disassemble ';
const GDBend: string = 'end';
const GDBendstep: string = 'end-stepping-range';
const GDBexp: string = 'exp=';
const GDBExit: string = '-gdb-exit';
const GDBExitmsg: string = 'exit';
const GDBExitnormal: string = 'exited-normally';
const GDBfile: string = 'file';
const GDBfileq: string = 'file=';
const GDBfinish: string = '-exec-finish';
const GDBflavour: string = '-gdb-set disassembly-flavor';
const GDBframe: string = 'frame={';
const GDBframebegin: string = 'frame-begin';
const GDBframefnarg: string = 'frame-args';
const GDBframefnname: string = 'frame-function-name';
const GDBframesrcfile: string = 'frame-source-file';
const GDBframesrcline: string = 'frame-source-line';
const GDBfunc: string = 'func';
const GDBfuncname: string = 'func-name=';
const GDBid: string = 'id';
const GDBidq: string = 'id=';
const GDBinstr: string = 'inst=';
const GDBInterp: string = '--interpreter=mi';
const GDBlevel: string = 'level';
const GDBlistframes: string = '-stack-list-frames';
const GDBlistlocals: string = '-stack-list-locals';
const GDBlistregvalues: string = '-data-list-register-values %s r';
const GDBlocals: string = 'locals';
const GDBlocalsq: string = 'locals=';
const GDBline: string = 'line';
const GDBlineq: string = 'line=';
const GDBmemq: string = 'memory=';
const GDBmult: string = '<MULTIPLE>';
const GDBnr_rows: string = 'nr_rows';
const GDBname: string = 'name';
const GDBnameq: string = 'name=';
const GDBnew: string = 'new';
const GDBnext: string = '-exec-next';
const GDBnumber: string = 'number';
const GDBNoSymbol: string = 'No symbol';
const GDBoffset: string = 'offset=';
const GDBold: string = 'old';
const GDBorig_loc: string = 'original-location=';
const GDBregnames: string = 'register-names=';
const GDBregvalues: string = 'register-values=';
const GDBreason: string = 'reason=';
const GDBrun: string = '-exec-run';
const GDBrunning: string = 'running';
const GDBsigmean: string = 'signal-meaning';
const GDBsigname: string = 'signal-name';
const GDBsigrcv: string = 'signal-received';
const GDBsigsegv: string = 'SIGSEGV';
const GDBSilent: string = '--silent';
const GDBsrcline: string = 'src_and_asm_line=';
const GDBstack: string = 'stack=[';
const GDBstep: string = '-exec-step';
const GDBstopped: string = 'stopped';
const GDBtargetid: string = 'target-id';
const GDBthreadid: string = 'thread-id';
const GDBthreadinfo: string = '-thread-info';
const GDBthreads: string = 'threads=';
const GDBthreadgcr: string = 'thread-group-created';
const GDBtype: string = 'type';
const GDBvalue: string = 'value';
const GDBvalueq: string = 'value=';
const GDBvalueqb: string = 'value={';
const GDBvarcreate: string = '%d-var-create %s VO%s @ %s';
const GDBvarassign: string = '%d-var-assign VO%s %s';
const GDBvardelete: string = '%d-var-delete VO%s';
const GDBwhat: string = 'what=';
const GDBwperrnoimp: string = 'Expression cannot be implemented';
const GDBwperrnosup: string = 'Target does not support';
const GDBwperrsup: string = 'Target can only support';
const GDBwperrjunk: string = 'Junk at end of command.';
const GDBwperrconst: string = 'Cannot watch constant value';
const GDBwperrxen: string = 'Cannot enable watchpoint';
const GDBwperrset: string = 'Unexpected error setting';
const GDBwperrustd: string = 'Cannot understand watchpoint';
const GDBwperrxs: string = 'Too many watchpoints';
const GDBwpt: string = 'wpt=';
const GDBwpta: string = 'hw-awpt=';
const GDBwptr: string = 'hw-rwpt=';
const GDBwptread: string = 'read watchpoint';
const GDBwptacc: string = 'acc watchpoint';
const GDBwpthw: string = 'hw watchpoint';
const GDBwpoint: string = 'watchpoint';
const GDBwpscope: string = 'watchpoint-scope';
const GDBwpNum: string = 'wpnum=';
const GDBwptrig: string = 'watchpoint-trigger';
const GDBwptriga: string = 'access-watchpoint-trigger';
const GDBwptrigr: string = 'read-watchpoint-trigger';
const GDBqStrEmpty: string = '\"';
const GDBwxString: string = 'wxString';
const wxStringBase: string = '<wxStringBase>';
const wxUnicodeStr: string = 'static npos =';
const wpUnknown: string = '(unknown)';
const FileStr: string = 'File';
const FuncStr: string = 'Function';
const LineStr: string = 'Line';
const LinesStr: string = 'Lines';
const NoDisasmStr: string = 'No disassembly available';
const CPURegList: string = '0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15';
const CPURegCount: integer = 15;  // The number of values above - 1
//            If this is changed, alter TRegisters & ParseRegisterValues and the
//            arrays CPURegNames, CPURegValues to suit.
const ExpandClasses: boolean = TRUE;
// set to false to treat contents of classes as string constants

const HT: char = #9;
const LF: char = #10;
const CR: char = #13;
const NL: string = #13 + #10;
const MAXSTACKDEPTH: integer = 99;
// Arbitrary limit to the depth of stack that can
// be displayed, to prevent an infinite loop.
// The display gets silly and probably not useful
// long before this. A sensible limit is around 10 - 20
// This just flags a user warning and returns.
//  (N.B. For GDB, the request can limit the range returned)

const
    PARSELIST = FALSE;
    PARSETUPLE = TRUE;
    INDENT = 3;                       // Amount of indentation of Locals display
    WATCHTOKENBASE = 9000;			// Token base for Watchpoint values
    MODVARTOKEN = 9998;
    TOOLTOKEN = 9999;

type
    AssemblySyntax = (asATnT, asIntel);
    ContextData = (cdLocals, cdCallStack, cdWatches, cdThreads);
    ContextDataSet = set of ContextData;
    TCallback = procedure(Output: TStringList) of object;

	   PList = ^TList;

    TWatchBreakOn = (wbRead, wbWrite, wbBoth);
	   PWatchPt = ^TWatchPt;
	   TWatchPt = packed record
		      Name: string;
		      Value: string;
		      BPNumber: integer;
		      BPType: TWatchBreakOn;
		      Token: longint;       // Last used Token - not necessarily unique!
		      Inactive: boolean;    // Unused at present
		      Deleted: boolean;     // deleted by GDB
	   end;

    ReadThread = class(TThread)

    public
        ReadChildStdOut: THandle;

    protected

        procedure Execute; override;

        // called when the thread exits - whether it terminates normally or is
        // stopped with Delete() (but not when it is Kill()ed!)
        //  OnExit: procedure;

    end;

    TRegisters = class
        EAX: string;
        EBX: string;
        ECX: string;
        EDX: string;
        ESI: string;
        EDI: string;
        EBP: string;
        ESP: string;
        EIP: string;
        EFLAGS: string;
        CS: string;
        DS: string;
        SS: string;
        ES: string;
        GS: string;
        FS: string;
    end;
    TRegistersCallback = procedure(Registers: TRegisters) of object;
    TString = class
    public
        Str: string;
        constructor Create(AStr: string);
    end;

    PBreakpoint = ^TBreakpoint;
    TBreakpoint = class
    public
        Index: integer;
        Valid: boolean;
        Editor: TEditor;
        Filename: string;
        Line: integer;
        BPNumber: integer;
    end;

    PStackFrame = ^TStackFrame;
    TStackFrame = packed record
        Filename: string;
        Line: integer;
        FuncName: string;
        Args: string;
    end;

    PVariable = ^TVariable;
    TVariable = packed record
        Name: string;
        Value: string;
        Location: string;
    end;

// redundant ? 20110409
    PWatch = ^TWatch;

    TWatch = packed record
        Name: string;
        Address: string;
        BreakOn: TWatchBreakOn;
        ID: integer;
    end;
// end redundant

	   PDebuggerThread = ^TDebuggerThread;
	   TDebuggerThread = packed record
		      Active: boolean;
		      Index: string;
		      ID: string;
	   end;

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    TCommand = class
    public
        Data: TObject;
        Command: string;
        Callback: procedure of object;
        OnResult: procedure(Output: TStringList) of object;
    end;

    PCommand = ^TCommand;

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    PCommandWithResult = ^TCommandWithResult;
    TCommandWithResult = class(TCommand)
    public
        constructor Create;
        destructor Destroy; override;
    public
        Event: THandle;
        Result: TStringList;
    end;

    ////////////////////////////////////
    // TDebugger
    /////////////////////////////////
    TDebugger = class

    public
        handle: THandle;

        constructor Create; virtual;
        destructor Destroy; override;
        procedure Launch(commandline, startupdir: string); virtual;
        procedure Execute(filename, arguments: string); virtual; abstract;
        procedure DisplayError(s: string);
        procedure CreateChildProcess(ChildCmd: string;
            StdIn: THandle; StdOut: THandle; StdErr: THandle);
        procedure QueueCommand(command, params: string); overload; virtual;
        procedure QueueCommand(command: TCommand); overload; virtual;
        procedure SendCommand; virtual;
		      function KillProcess(PID: DWORD): boolean;
        procedure CloseDebugger(Sender: TObject); virtual;

    private
        Token: longint;

    protected
        fBusy: boolean;
        fPaused: boolean;
        fExecuting: boolean;
        fDebugTree: TListView;
        fNextBreakpoint: integer;
        IncludeDirs: TStringList;
        IgnoreBreakpoint: boolean;
        JumpToCurrentLine: boolean;

        hInputWrite: THandle;
        hOutputRead: THandle;
        hPid: THandle;

        SentCommand: boolean;
        CurrentCommand: TCommand;
        CommandQueue: TList;

        FileName: string;
        Event: THandle;
        Reader: ReadThread;
        CurOutput: TStringList;
		      TargetPID: integer;
		      DebuggerPID: DWORD;

        procedure OnOutput(Output: string); virtual; abstract;

        function GetBreakpointFromIndex(index: integer): TBreakpoint;

        //Instruction callbacks
        procedure OnGo;

        //Common events
        procedure OnNoDebuggingSymbolsFound;
        procedure AddDebuggerSwitches;
        procedure OnAccessViolation;
        procedure OnBreakpoint;

    published
        property Busy: boolean read fBusy;
        property Executing: boolean read fExecuting;
        property Paused: boolean read fPaused;
        property DebugTree: TListView read fDebugTree write fDebugTree;

    public

        //Callback functions
        OnVariableHint: procedure(Hint: string) of object;
        OnDisassemble: procedure(Disassembly: string) of object;
        OnRegisters: procedure(Registers: TRegisters) of object;
        OnCallStack: procedure(Callstack: TList) of object;
        OnThreads: procedure(Threads: TList) of object;
        OnLocals: procedure(Locals: TList) of object;

        //Debugger basics
        procedure Attach(pid: integer); virtual; abstract;
        procedure SetAssemblySyntax(syntax: AssemblySyntax); virtual; abstract;

        //Breakpoint handling
        procedure AddBreakpoint(breakpoint: TBreakpoint); virtual; abstract;
        procedure RemoveBreakpoint(breakpoint: TBreakpoint); virtual; abstract;
        procedure RemoveAllBreakpoints;
        procedure RefreshBreakpoints;
        //Procedure RefreshWatches; Virtual; Abstract;
        procedure RefreshBreakpoint(var breakpoint: TBreakpoint);
            virtual; abstract;
        function BreakpointExists(filename: string; line: integer): boolean;
		      procedure LoadAllWatches; virtual; abstract;
		      procedure ReLoadWatches; virtual; abstract;
		      procedure GetWatchedValues; virtual;
		      procedure AddWatch(VarName: string; when: TWatchBreakOn); virtual;
		      procedure RemoveWatch(node: TTreenode); virtual;
		      procedure ModifyVariable(VarName: string; Value: string); virtual;

        procedure ReplaceWxStr(Str: PString); virtual;


        //Debugger control funtions
        procedure Go; virtual; abstract;
        procedure Pause; virtual;
        procedure Next; virtual; abstract;
        procedure Step; virtual; abstract;
        procedure Finish; virtual; abstract;
        procedure SetThread(thread: integer); virtual; abstract;
        procedure SetFrame(frame: integer); virtual; abstract;
        function GetVariableHint(name: string): string; virtual; abstract;

        // Debugger virtual functions
        procedure FirstParse; virtual;
        procedure ExitDebugger; virtual;
        procedure WriteToPipe(Buffer: string); virtual;
        procedure AddToDisplay(Msg: string); virtual;

        //Source lookup directories
        procedure AddIncludeDir(s: string); virtual; abstract;
        procedure ClearIncludeDirs; virtual; abstract;

        //Variable watches
        procedure RefreshContext(refresh: ContextDataSet =
            [cdLocals, cdCallStack, cdWatches, cdThreads]);
            virtual; abstract;
//        procedure AddWatch(varname: string; when: TWatchBreakOn);
//            virtual; abstract;
//        procedure RemoveWatch(varname: string); virtual; abstract;
//        procedure ModifyVariable(varname, newvalue: string); virtual; abstract;

        //Low-level stuff
        procedure GetRegisters; virtual; abstract;
        procedure Disassemble; overload;
        procedure Disassemble(func: string); overload; virtual; abstract;
    end;

    ////////////////////////////////////
    // TGDBDebugger
    /////////////////////////////////
    TGDBDebugger = class(TDebugger)

        constructor Create; override;
        destructor Destroy; override;

    protected
        OverrideHandler: TCallback;
        RegistersFilled: integer;
        Registers: TRegisters;
		      CPURegNames: array[0..15] of string;
		      CPURegValues: array[0..15] of string;
        LastWasCtrl: boolean;
        Started: boolean;
		      LastVOident: string;
		      LastVOVar: string;
		      WatchPtList: TTreeView;
		      CurrentGDBThread: integer;			// as reported by GDB - presently unused
		      SelectedFrame: integer;			// selected by user - defaults to 0
		      SelectedThread: integer;			// selected by user - defaults to CurrentGDBThread
        // Pipe handles
        g_hChildStd_IN_Wr: THandle;		//we write to this
        g_hChildStd_IN_Rd: THandle;		//Child process reads from here
        g_hChildStd_OUT_Wr: THandle;		//Child process writes to this
        g_hChildStd_OUT_Rd: THandle;		//we read from here

    protected
        procedure OnOutput(Output: string); override;
        procedure OnSignal(Output: TStringList);
        procedure OnSourceMoreRecent;

        //Instruction callbacks
        procedure OnGo;
        procedure OnTrace;

        //Parser callbacks
        procedure OnRefreshContext(Output: TStringList);
        procedure OnVariableHint(Output: TStringList);
        procedure OnDisassemble(Output: TStringList);
        procedure OnCallStack(Output: TStringList);
        procedure OnRegisters(Output: TStringList);
        procedure OnThreads(Output: TStringList);
        procedure OnLocals(Output: TStringList);
      //  procedure OnWatchesSet(Output: TStringList);

        procedure FillBreakpointNumber(SrcFile: PString; Line: integer; Num: integer);

    public
        //Debugger control
        procedure Attach(pid: integer); override;

        // Debugger virtual functions
        procedure FirstParse; override;
        procedure ExitDebugger; override;
        procedure WriteToPipe(Buffer: string); override;
        procedure AddToDisplay(Msg: string); override;

        procedure Launch(commandline, startupdir: string); override;
        procedure Execute(filename, arguments: string); override;

        procedure Cleanup;
		      procedure CloseDebugger(Sender: TObject); override;
		      function Notify(buf: pchar; bsize: PLongInt; verbose: boolean): pchar;
        procedure SendCommand; override;
		      function WriteGDBContext(thread: integer; frame: integer): string;
        function SendToDisplay(buf: pchar; bsize: PLongInt;
            verbose: boolean): pchar;

        //Set the include paths
        procedure AddIncludeDir(s: string); override;
        procedure ClearIncludeDirs; override;

        //Override the breakpoint handling
        procedure AddBreakpoint(breakpoint: TBreakpoint); override;
        procedure RemoveBreakpoint(breakpoint: TBreakpoint); override;
        procedure RefreshBreakpoint(var breakpoint: TBreakpoint); override;
        //procedure RefreshWatches; override;

        //Variable watches
        procedure RefreshContext(refresh: ContextDataSet =
            [cdLocals, cdCallStack, cdWatches,
            cdThreads]); override;
        procedure AddWatch(varname: string; when: TWatchBreakOn); override;

		      procedure LoadAllWatches; override;
		      procedure ReLoadWatches; override;
		      procedure RemoveWatch(node: TTreenode); override;
		      procedure GetWatchedValues; override;
		      procedure FillWatchValue(Msg: string);
		      procedure FillTooltipValue(Msg: string);
		      procedure ModifyVariable(VarName: string; Value: string); override;

        // Parser functions
        function GetToken(buf: pchar; bsize: PLongInt;
            Token: PInteger): pchar;
        function FindFirstChar(Str: string; c: char): integer;
        function Result(buf: pchar; bsize: PLongInt): pchar;
        function ExecResult(buf: pchar; bsize: PLongInt): pchar;
        function breakOut(Next: PPChar; bsize: PLongInt): string;
        function ParseConst(Msg: PString; Vari: PString;
            Value: PString): boolean; overload;
        function ParseConst(Msg: PString; Vari: PString;
            Value: PInteger): boolean; overload;
        function ParseConst(Msg: PString; Vari: PString;
            Value: PBoolean): boolean; overload;
		      function ExtractLocals(Str: PString): string;
		      function ParseResult(Str: PString; Level: integer; List: TList): string;
		      function ExtractList(Str: PString; Tuple: boolean; Level: integer; List: TList): string;
		      function ParseValue(Str: PString; Level: integer; List: TList): string;
        function SplitResult(Str: PString; Vari: PString): string;
        function ExtractWxStr(Str: PString): string;
		      procedure ReplaceWxStr(Str: PString); override;
        function ExtractBracketed(Str: PString; start: Pinteger;
            next: PInteger; c: char; inclusive: boolean): string;
        function ExtractNamed(Src: PString; Target: PString;
            count: integer): string;
		      function ParseVObjCreate(Msg: string): boolean;
		      function ParseVObjAssign(Msg: string): boolean;
        procedure ParseWatchpoint(Msg: string);
        procedure ParseWatchpointError(Msg: string);

		      procedure ParseBreakpoint(Msg: string; List: PList);
		      procedure ParseBreakpointTable(Msg: string);
		      procedure ParseCPUDisassem(Msg: string);
		      function ParseCPUMixedMode(List: string): string;
		      function ParseCPUDisasmMode(List: string; CurrentFuncName: PString): string;
		      procedure ParseRegisterNames(Msg: string);
		      procedure ParseRegisterValues(Msg: string);
		      procedure ParseCPUMemory(Msg: string);
        procedure ParseStack(Msg: string);
        function ParseFrame(Msg: string; Frame: PStackFrame): string;
        procedure ParseThreads(Msg: string);
        procedure WatchpointHit(Msg: PString);
        procedure BreakpointHit(Msg: PString);
        procedure StepHit(Msg: PString);
		      procedure WptScope(Msg: PString);
        procedure SigRecv(Msg: PString);

        //Debugger control
        procedure Go; override;
        procedure Next; override;
        procedure Step; override;
        procedure Finish; override;
        procedure Pause; override;
        procedure SetThread(thread: integer); override;
        procedure SetFrame(frame: integer); override;
        function GetVariableHint(name: string): string; override;

        //Low-level stuff
        procedure GetRegisters; override;
        procedure Disassemble(func: string); overload; override;
        procedure SetAssemblySyntax(syntax: AssemblySyntax); override;
    end;

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    TCDBDebugger = class(TDebugger)
        constructor Create; override;
        destructor Destroy; override;

    protected
        LocalsList: TList;
        procedure OnOutput(Output: string); override;

        //Instruction callbacks
        procedure OnTrace;

        //Parser callbacks
        procedure OnBreakpointSet(Output: TStringList);
        procedure OnRefreshContext(Output: TStringList);
        procedure OnVariableHint(Output: TStringList);
        procedure OnDisassemble(Output: TStringList);
        procedure OnCallStack(Output: TStringList);
        procedure OnRegisters(Output: TStringList);
        procedure OnThreads(Output: TStringList);
        procedure OnLocals(Output: TStringList);
        procedure OnDetailedLocals(Output: TStringList);

    public
        //Run the debugger
        procedure Attach(pid: integer); override;
        procedure Execute(filename, arguments: string); override;

        //Set the include paths
        procedure AddIncludeDir(s: string); override;
        procedure ClearIncludeDirs; override;

        //Override the breakpoint handling
        procedure AddBreakpoint(breakpoint: TBreakpoint); override;
        procedure RemoveBreakpoint(breakpoint: TBreakpoint); override;
        procedure RefreshBreakpoint(var breakpoint: TBreakpoint); override;
        //Procedure RefreshWatches; Override;

        //Variable watches
        procedure RefreshContext(refresh: ContextDataSet =
            [cdLocals, cdCallStack, cdWatches, cdThreads]); override;
        procedure AddWatch(varname: string; when: TWatchBreakOn); override;
        //procedure RemoveWatch(varname: string); override;

        //Debugger control
        procedure Go; override;
        procedure Next; override;
        procedure Step; override;
        procedure Finish; override;
        procedure SetThread(thread: integer); override;
        procedure SetFrame(frame: integer); override;
        function GetVariableHint(name: string): string; override;

        // Debugger virtual functions
        procedure FirstParse; override;
        procedure ExitDebugger; override;
        procedure WriteToPipe(Buffer: string); override;
        procedure AddToDisplay(Msg: string); override;

        //Low-level stuff
        procedure GetRegisters; override;
        procedure Disassemble(func: string); overload; override;
    end;

var
    Breakpoints: TList;

implementation

uses
    devcfg, Forms, madExcept, main, MultiLangSupport,
    prjtypes, RegExpr, //dbugintf,  EAB removed Gexperts debug stuff.
    StrUtils, utils;

procedure ReadThread.Execute;

var
    BufMem: pchar;           // The originally allocated memory (pointer 'buf' gets moved!)
    BytesAvailable: DWORD;

    {$ifdef DISPLAYOUTPUT}
    PipeBufSize: DWORD;
    BufType: DWORD;
    {$ENDIF}

    BytesToRead: DWORD;
    LastRead: DWORD;

    TotalBytesRead: DWORD;
    ReadSuccess: boolean;

    Buffer: string;


begin

    buf := NIL;
    BytesAvailable := 0;
    BytesToRead := 0;
    LastRead := 0;

    {$ifdef DISPLAYOUTPUT}
    TotalBytesRead := 0;
    {$ENDIF}

    while (not Terminated) do
    begin
        Sleep(100);       // Give other processes some time

        PeekNamedPipe(ReadChildStdOut, NIL, 0, NIL, @BytesAvailable, @BytesToRead);

                        // Poll the pipe buffer
        if ((BytesAvailable > 0) and (buf = NIL)) then
                        // Indicates data is available and
                        // the buffer is unused or empty and can accept data.
                        // When done, the handler must free the memory and
                        // set bytesInBuffer to zero in order for this to accept
                        // more data.
                        // BytesAvailable and bytesInBuffer > zero (for any length
                        // of time) could indicate a possible deadlock.
                        // (Resolve this by counting iterations round the loop
                        // while bytesInBuffer > zero and set an arbitrary limit? )
                        //(This possible deadlock has never been observed!)
        begin
			         if (MainForm.VerboseDebug.Checked) then
			         begin
				            Buffer := 'PeekPipe bytes available: ' + IntToStr(BytesAvailable);
				//gui_critSect.Enter();               // Maybe needed while debugging
				            MainForm.fDebugger.AddtoDisplay(Buffer);
				//gui_critSect.Leave();               // Maybe needed while debugging
			         end;

            try
			             BufMem := AllocMem(BytesAvailable + 16);
                                                          // bump it up just to give some in hand
                                                          // in case we screw up the count!
                                                          // NOTE: WE do not free the memory
                                                          // but rely on it being freed externally.

			             ReadSuccess := ReadFile(ReadChildStdOut, BufMem^, BytesAvailable, LastRead, NIL);
			             if (ReadSuccess) then
			             begin

{$ifdef DISPLAYOUTPUT}
				Buffer := 'Readfile (Pipe) bytes read: ' + IntToStr(LastRead);
				// gui_critSect.Enter();               // Maybe needed while debugging
				MainForm.fDebugger.AddtoDisplay(Buffer);
				// gui_critSect.Leave();               // Maybe needed while debugging
{$endif}
                    Sleep(5);                              // Allow the pipe to refill
                    TotalBytesRead := LastRead;
                    PeekNamedPipe(ReadChildStdOut, NIL, 0, NIL, @BytesAvailable, @BytesToRead);
                    while (BytesAvailable > 0) do
                    begin
                        ReAllocMem(BufMem, TotalBytesRead + BytesAvailable + 16);
                        ReadSuccess := ReadSuccess and
                            ReadFile(ReadChildStdOut, (BufMem + TotalBytesRead)^, BytesAvailable, LastRead, NIL);

{$ifdef DISPLAYOUTPUT}
				Buffer := 'Readfile (Pipe) bytes read: ' + IntToStr(LastRead);
				// gui_critSect.Enter();               // Maybe needed while debugging
				MainForm.fDebugger.AddtoDisplay(Buffer);
				// gui_critSect.Leave();               // Maybe needed while debugging
{$endif}

                        TotalBytesRead := TotalBytesRead + LastRead;
                        Sleep(5);                              // Allow the pipe to refill
                        PeekNamedPipe(ReadChildStdOut, NIL, 0, NIL, @BytesAvailable, @BytesToRead);
                    end;
                    if ((LastRead > 0) and (ReadSuccess)) then
                    begin
                        buf := BufMem;
                        buf[TotalBytesRead] := (#0);  // Terminate it, thus can handle as Cstring

{$ifdef DISPLAYOUTPUT}
                Buffer := 'Readfile (Pipe) total bytes read: ' + IntToStr(TotalBytesRead);
                // gui_critSect.Enter();               // Maybe needed while debugging
                MainForm.fDebugger.AddtoDisplay(Buffer);
                // gui_critSect.Leave();               // Maybe needed while debugging
{$endif}
{$ifdef DISPLAYOUTPUTHEX}
                // gui_critSect.Enter();               // Maybe needed while debugging
                HexDisplay(buf, TotalBytesRead);
                // gui_critSect.Leave();               // Maybe needed while debugging

{$endif}

//            Pass details (Pointer, length) of the buffer to the Parser
//             in Global vars (buf: PChar and bytesInBuffer: DWORD) and
//             run the Parser and all that follows in the main thread.

                        bytesInBuffer := TotalBytesRead;
                        Synchronize(MainForm.fDebugger.FirstParse);
                    end;
                end;  // of Readfile
            except
                on EOutOfMemory do
                    MainForm.fDebugger.DisplayError('Unable to allocate memory to read Debugger output');
            end;
        end;  // ... of main loop

    end;    // ... of while(Terminated)

end;

//=============================================================
constructor TCommandWithResult.Create;
begin
    Event := CreateEvent(NIL, FALSE, FALSE, NIL);
    Result := TStringList.Create;
end;

destructor TCommandWithResult.Destroy;
begin
    CloseHandle(Event);
    Result.Free;
end;

constructor TString.Create(AStr: string);
begin
    Str := AStr;
end;

function GenerateCtrlCEvent(PGenerateConsoleCtrlEvent: Pointer): DWORD;
    stdcall;
begin
    Result := 0;
    if PGenerateConsoleCtrlEvent <> NIL then
    begin
        asm
            //Call assembly code! We just want to get the console function thingo
            PUSH 0;
            PUSH 0;
            CALL PGenerateConsoleCtrlEvent;
        end;
        Result := 1;
    end;
end;

//////////////////////////////////////////
// TDebugger
/////////////////////////////////////////
constructor TDebugger.Create;
begin
    CurOutput := TStringList.Create;
    SentCommand := FALSE;
    fExecuting := FALSE;

    JumpToCurrentLine := FALSE;
    CommandQueue := TList.Create;
    IncludeDirs := TStringList.Create;
    FileName := '';
    Event := CreateEvent(NIL, FALSE, FALSE, NIL);

    buf := NIL;
    bytesInBuffer := 0;

end;

//=============================================================

procedure TDebugger.GetWatchedValues;
begin
end;

procedure TDebugger.AddWatch(VarName: string; when: TWatchBreakOn);
begin
end;

procedure TDebugger.RemoveWatch(node: TTreenode);
begin
end;

procedure TDebugger.ModifyVariable(VarName: string; Value: string);
begin
end;

procedure TDebugger.ReplaceWxStr(Str: PString);
begin
end;

procedure TDebugger.Launch(commandline, startupdir: string);
begin
end;

//=============================================================

destructor TDebugger.Destroy;
begin

    if (buf <> NIL) then
        FreeMem(buf);

    CloseDebugger(NIL);
    CloseHandle(Event);
    RemoveAllBreakpoints;

    CurOutput.Free;
    CommandQueue.Free;
    IncludeDirs.Free;

    inherited Destroy;
end;

//=============================================================
function TDebugger.KillProcess(PID: DWORD): boolean;
// returns 'TRUE' on success
var
	   hProc: THandle;

begin
	   KillProcess := FALSE;
	   hProc := OpenProcess(PROCESS_TERMINATE, FALSE, PID);
	   if (not (hProc = 0)) then
	   begin
		      if (TerminateProcess(hProc, 0)) then
			     begin
// 				process terminated
				        CloseHandle(hProc);
				        KillProcess := TRUE;
			     end;
    end;
end;

//=============================================================

procedure TDebugger.RemoveAllBreakpoints;
var
    I: integer;
begin
    for I := 0 to Breakpoints.Count - 1 do
        RemoveBreakpoint(Breakpoints[I]);
end;

//=============================================================

procedure TDebugger.RefreshBreakpoints;
var
    I: integer;
begin
    //Refresh the execution breakpoints
    for I := 0 to Breakpoints.Count - 1 do
        RefreshBreakpoint(PBreakPoint(Breakpoints.Items[I])^);
end;

//=============================================================

procedure TDebugger.CloseDebugger(Sender: TObject);

begin

end;

//  All moved in to TGDBDebugger. was:
{
var
i :integer;
begin
    if Executing then
    begin

        fPaused := false;
        fExecuting := false;

        //      Note we SHOULD NOT pull the plug on GDB debugger unless it fails
        //      to stop when commanded to exit (manual page 306: Quitting GDB)
        //      Would similar considerations apply to other debuggers?

        // First don't let us be called twice. Set the secondary threads to not call
        // us when they terminate

  //GAR     Reader.OnTerminate := nil;

        // Force the read on the input to return by closing the stdin handle.
        // Wait.Stop := True;
 //GAR       SetEvent(Event);
  //GAR      TerminateProcess(hPid, 0);
        //  Wait.Terminate;
        //  Wait := nil;
  //GAR      Reader.Terminate;

  //GAR      Reader := nil;

        //Close the handles
        //   if (not CloseHandle(hPid)) then
        //      DisplayError('CloseHandle - process handle');
        //  if (not CloseHandle(hOutputRead)) then
        //     DisplayError('CloseHandle - output read');
        //    if (not CloseHandle(hInputWrite)) then
        //     DisplayError('CloseHandle - input write');

        MainForm.RemoveActiveBreakpoints;

        //Clear the command queue
        CommandQueue.Clear;
        CurrentCommand := nil;
    end;
end;
}

//=============================================================

procedure TDebugger.QueueCommand(command, params: string);
var
    Combined: string;
    Cmd: TCommand;
begin
    //Combine the strings to get the final command
    Combined := command;
    if Length(params) > 0 then
        Combined := Combined + ' ' + params;

    //Create the command object
    Cmd := TCommand.Create;
    Cmd.Command := Combined;
    Cmd.Callback := NIL;
    QueueCommand(Cmd);
end;

//=============================================================

procedure TDebugger.QueueCommand(command: TCommand);
var
    Ptr: PCommand;
begin
    //Copy the object
    New(Ptr);
    Ptr^ := command;
    Command.Command := Command.Command;

    //Add it into our list of commands
    CommandQueue.Add(Ptr);

    //Can we execute the command now?
    if Executing and Paused then
        SendCommand;
end;

//=============================================================

procedure TDebugger.SendCommand;
begin
end;

//=============================================================

procedure TDebugger.OnGo;
begin
    fPaused := FALSE;
end;

//=============================================================

// Debugger virtual functions
procedure TDebugger.FirstParse;
begin
end;

procedure TDebugger.ExitDebugger;
begin
end;

procedure TDebugger.WriteToPipe(Buffer: string);
begin
end;

procedure TDebugger.AddToDisplay(Msg: string);
begin
end;

//=============================================================

procedure TDebugger.CreateChildProcess(ChildCmd: string; StdIn: THandle;
    StdOut: THandle; StdErr: THandle);

// Create a child process that uses the handles to previously created pipes
//   for STDIN and STDOUT.
var
    piProcInfo: PROCESS_INFORMATION;
    siStartInfo: STARTUPINFO;
    bSuccess: boolean;

begin

    // Set up members of the PROCESS_INFORMATION structure.
    ZeroMemory(@piProcInfo, SizeOf(PROCESS_INFORMATION));

    // Set up members of the STARTUPINFO structure.
    // This structure specifies the STDIN and STDOUT handles for redirection.

    ZeroMemory(@siStartInfo, sizeof(STARTUPINFO));
    siStartInfo.cb := SizeOf(STARTUPINFO);
    siStartInfo.hStdError := StdErr;
    siStartInfo.hStdOutput := StdOut;
    siStartInfo.hStdInput := StdIn;
    siStartInfo.dwFlags := siStartInfo.dwFlags or STARTF_USESTDHANDLES;

    // Hide child window
    siStartInfo.dwFlags := siStartInfo.dwFlags or STARTF_USESHOWWINDOW;
    //   siStartInfo.wShowWindow = siStartInfo.wShowWindow |= SW_SHOWDEFAULT; //SW_HIDE;
    siStartInfo.wShowWindow := SW_HIDE;

    // Create the child process.

    bSuccess := CreateProcess(NIL,
        pchar(ChildCmd),          // command line
        NIL,                      // process security attributes
        NIL,                      // primary thread security attributes
        TRUE,                     // handles are inherited
        0,                        // creation flags
        NIL,                      // use parent's environment
        NIL,                      // use parent's current directory
        siStartInfo,              // STARTUPINFO pointer
        piProcInfo);              // receives PROCESS_INFORMATION

    // If an error occurs, exit the application.
    if (not bSuccess) then
        DisplayError('Cannot create process: ' + ChildCmd)
    // WARNING ! ! ! Delphi gives a Thread error: The handle is invalid (6)
    //               if the child's _Command Line_ is invalid  ! ! !
    else
    begin
        // Close handles to the child process and its primary thread.
	       // Some applications might keep these handles to monitor the status
	       // of the child process, for example.

        CloseHandle(piProcInfo.hProcess);
        CloseHandle(piProcInfo.hThread);
		      DebuggerPID := piProcInfo.dwProcessId;
        fExecuting := TRUE;
        fPaused := TRUE;
    end;
end;

//=============================================================

procedure TDebugger.DisplayError(s: string);
begin
    MessageDlg('Error with debugging process: ' + s, mtError,
        [mbOK], Mainform.Handle);
end;

//=============================================================

procedure TDebugger.AddDebuggerSwitches;
var
    opt: TCompilerOption;
    idx: integer;
    spos: integer;
    opts: TProjProfile;

begin

    if ((devCompiler.CompilerType = ID_COMPILER_MINGW) or
        (devCompiler.CompilerType = ID_COMPILER_LINUX)) then
    begin
        if devCompiler.FindOption('-g3', opt, idx) then
        begin
            opt.optValue := 1;
            if not Assigned(MainForm.fProject) then
                devCompiler.Options[idx] := opt;
                // set global debugging option only if not working with a project
            MainForm.SetProjCompOpt(idx, TRUE);
                // set the project's correpsonding option too

                // remove "-s" from the linker''s command line
            if Assigned(MainForm.fProject) then
            begin
                opts := MainForm.fProject.CurrentProfile;
                    // look for "-s" in all the possible ways
                    // NOTE: can't just search for "-s" because we might get confused with
                    //       some other option starting with "-s...."
                spos := Pos('-s ', opts.Linker); // following more opts
                if spos = 0 then
                    spos := Pos('-s'#13, opts.Linker); // end of line
                if spos = 0 then
                    spos := Pos('-s_@@_', opts.Linker);
                    // end of line (dev 4.9.7.3+)
                if (spos = 0) and (Length(opts.Linker) >= 2) and
                        // end of string
                    (Copy(opts.Linker, Length(opts.Linker) - 1, 2) =
                    '-s') then
                    spos := Length(opts.Linker) - 1;

                    // if found, delete it
                if spos > 0 then
                    Delete(opts.Linker, spos, 2);

            end;

                // remove "--no-export-all-symbols" from the linker''s command line
            if Assigned(MainForm.fProject) then
            begin
                opts := MainForm.fProject.CurrentProfile;
                    // look for "--no-export-all-symbols"
                spos := Pos('--no-export-all-symbols', opts.Linker);
                    // following more opts
                    // if found, delete it
                if spos > 0 then
                    Delete(opts.Linker, spos,
                        length('--no-export-all-symbols'));

            end;

                // remove -s from the compiler options
            if devCompiler.FindOption('-s', opt, idx) then
            begin
                opt.optValue := 0;
                if not Assigned(MainForm.fProject) then
                    devCompiler.Options[idx] := opt;
                    // set global debugging option only if not working with a project
                MainForm.SetProjCompOpt(idx, FALSE);
                    // set the project's correpsonding option too
            end;
        end;
    end
    else
    if devCompiler.CompilerType in ID_COMPILER_VC then
        if devCompiler.FindOption('/ZI', opt, idx) then
        begin
            opt.optValue := 1;
            if not Assigned(MainForm.fProject) then
                devCompiler.Options[idx] := opt;
            MainForm.SetProjCompOpt(idx, TRUE);
            MainForm.fProject.CurrentProfile.Linker :=
                MainForm.fProject.CurrentProfile.Linker + '/Debug';
        end;

end;


//=============================================================

procedure TDebugger.OnNoDebuggingSymbolsFound;
begin
    if MessageDlg(Lang[ID_MSG_NODEBUGSYMBOLS], mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then
    begin
        CloseDebugger(NIL);

        AddDebuggerSwitches;

        MainForm.Compiler.OnCompilationEnded := MainForm.doDebugAfterCompile;
        MainForm.actRebuildExecute(NIL);
    end;
end;

//=============================================================

function TDebugger.BreakpointExists(filename: string; line: integer): boolean;
var
    I: integer;
begin
    Result := FALSE;
    for I := 0 to Breakpoints.Count - 1 do
        if (PBreakpoint(Breakpoints[I])^.Filename = filename) and
            (PBreakpoint(Breakpoints[I])^.Line = line) then
        begin
            Result := TRUE;
            Break;
        end;
end;

//=============================================================

function TDebugger.GetBreakpointFromIndex(index: integer): TBreakpoint;
var
    I: integer;
begin
    Result := NIL;
    for I := 0 to Breakpoints.Count - 1 do
        if PBreakpoint(Breakpoints[I])^.Index = index then
        begin
            Result := PBreakpoint(Breakpoints[I])^;
            Exit;
        end;
end;

//=============================================================

procedure TDebugger.OnAccessViolation;
begin
    Application.BringToFront;
    if (MessageDlg(Lang[ID_MSG_SEGFAULT], mtError, [mbOK],
        MainForm.Handle) = mrOK) then
    begin
        JumpToCurrentLine := TRUE;
        CloseDebugger(NIL);
    end;

end;

//=============================================================

procedure TDebugger.OnBreakpoint;
begin
    Application.BringToFront;
    case MessageDlg(Lang[ID_MSG_BREAKPOINT], mtError,
            [mbOK, mbIgnore, mbAbort], MainForm.Handle) of
        mrIgnore:
            Go;
        mrAbort:
            CloseDebugger(NIL);
        mrOk:
            JumpToCurrentLine := TRUE;
    end;
end;

//=============================================================

procedure TDebugger.Disassemble;
begin
    Disassemble('');
end;

procedure TDebugger.Pause;
const
    CodeSize = 1024;
var
    Thread: THandle;
    BytesWritten, ThreadID, ExitCode: DWORD;
    WriteAddr: Pointer;
begin
    WriteAddr := VirtualAllocEx(hPid, NIL, CodeSize, MEM_COMMIT,
        PAGE_EXECUTE_READWRITE);
    if WriteAddr <> NIL then
    begin
        WriteProcessMemory(hPid, WriteAddr, @GenerateCtrlCEvent,
            CodeSize, BytesWritten);
        if BytesWritten = CodeSize then
        begin
            //Create and run the thread
            Thread := CreateRemoteThread(hPid, NIL, 0, WriteAddr,
                GetProcAddress(LoadLibrary('kernel32.dll'),
                'GenerateConsoleCtrlEvent'),
                0, ThreadID);
            if Thread <> 0 then
            begin
                //Wait for its termination
                WaitForSingleObject(Thread, INFINITE);

                //And see if it succeeded
                GetExitCodeThread(Thread, ExitCode);
                if ExitCode <> 0 then
                    //We've triggered a breakpoint, so yes, ignore it
                    IgnoreBreakpoint := TRUE;

                //Destroy the thread
                CloseHandle(Thread);
            end;
        end;

        //Free the memory we injected
        VirtualFreeEx(hPid, WriteAddr, 0, MEM_RELEASE);
        // free the memory we allocated
    end;
end;

////////////////////////////////////////////

//------------------------------------------------------------------------------
// TGDBDebugger
//------------------------------------------------------------------------------
function TGDBDebugger.ExtractNamed(Src: PString; Target: PString;
    count: integer): string;

    // Find count-th (ONE-based) occurrence of Target in Src
    //    e.g. it returns item={ListItem2} when called with
    //     Param1 = "value=[item={ListItem1},item={ListItem2},item={ListItem3}]"
    //     Param2 = "item={"
    //     Param3 = 2
    //
    //    the last character of Target must be either '{' or '[' or '"'
    //    The target is deemed to end with the matching closing character
    //
    //    Returns a string EXCLUSIVE of the enclosing brackets/quotes
    //    Returns an empty string on failure

var
    Temp: string;
    TargetLength: integer;
    c: char;
    s, e, l: integer;
    m: char;

begin
    TargetLength := Length(Target^);
    c := AnsiLastChar(Target^)^;
    s := 1;                       // start index
    e := 1;                       // end index
    l := 0;                       // level of nesting
    m := #0;

    if (count = 0) then
        ExtractNamed := Temp
    else
    begin
        case (c) of
            '{':
                m := '}';
            '[':
                m := ']';
            '"':
                m := '"';
        end;
        Temp := Src^;
        repeat
            begin

                Temp := AnsiMidStr(Temp, e - s + 1, Length(Temp) - e + s);
                s := AnsiPos(Target^, Temp);
                if (s = 0) then
                begin
                    Temp := '';
                    ExtractNamed := Temp;
                    break; //  return Temp;

                end;
                e := s + TargetLength - 1;
                while (e <= Length(Temp)) do
                begin
                    if (Temp[e] = c) then
                        Inc(l)
                    else
                    if (Temp[e] = m) then
                    begin
                        Dec(l);
                        if (l = 0) then
                            break;
                    end;
                    Inc(e);
                end;
                Temp := AnsiRightStr(Temp, Length(Temp) - s + 1);
                Dec(count);
            end
        until not (count > 0);

        Temp := AnsiMidStr(Temp, TargetLength + 1, e - s - TargetLength);
        ExtractNamed := Temp;
    end;

end;

//=================================================================

function TGDBDebugger.ParseConst(Msg: PString; Vari: PString;
    Value: PString): boolean;
{
   Parses out and obtains the value of one variable in a results string
   (Note: our variable must be unique within Msg)

   *Msg = ptr to Message string from GDB, containing one or many results
    of the form Var="Value",Var2="Value2" etc.
   *Vari = NAME of variable as a string -- Var in GDB documentation
   *Value = ptr to variable to receive value
       overloaded for String, long and bool only
   Returns FALSE if Vari is not found, else TRUE
}

var
    s: integer;     // Start index of "Var"
    Sub: string;

begin
    // Find our Variable
    s := AnsiPos(Vari^, Msg^);
    if (s = 0) then
        ParseConst := FALSE
    else
    begin
        Sub := AnsiRightStr(Msg^, Length(Msg^) - s);
        // Sub = OurVar="Value",....
        Sub := ExtractBracketed(@Sub, NIL, NIL, '"', FALSE);
        // Remove quotes
        Sub := AnsiDequotedStr(Sub, '"');
        Value^ := Sub;
        ParseConst := TRUE;
    end;
end;

//-----------------------------------------------------------------

function TGDBDebugger.ParseConst(Msg: PString; Vari: PString;
    Value: PInteger): boolean;
var
    Val: string;
begin

    if (ParseConst(Msg, Vari, PString(@Val)) = FALSE) then
        ParseConst := FALSE
    else
    begin
        Value^ := StrToIntDef(Val, 0);
        ParseConst := TRUE;
    end;
end;

//-----------------------------------------------------------------

function TGDBDebugger.ParseConst(Msg: PString; Vari: PString;
    Value: PBoolean): boolean;
var
    Val: string;
begin
    if (ParseConst(Msg, Vari, PString(@Val)) = FALSE) then
        ParseConst := FALSE
    else
    begin
        if ((Val = 'true') or (Val = 'y')) then
            Value^ := TRUE
        else
        if ((Val = 'false') or (Val = 'n')) then
            Value^ := FALSE;
        ParseConst := TRUE;
    end;
end;

//=================================================================

function TGDBDebugger.ParseVObjCreate(Msg: string): boolean;

//   Parses out simple Variable value
//   Does not work for compound variables: GDB returns {...}

var
    Value: string;
    VarType: string;
    ValStrings: TStringList;
    Name: string;
    start: integer;
    Ret: boolean;
    Buffer, Output: string;

begin

    start := 0;
    Ret := TRUE;

    Name := ExtractBracketed(@Msg, @start, NIL, '"', FALSE); // because 'name=' gets stripped off!

    Ret := Ret and ParseConst(@Msg, @GDBtype, PString(@VarType));


{/* If type=="wxString", do
    "-var-evaluate-expression -f natural var1.wxStringBase.protected.m_pchData"
   in stages to build the VO Tree.
   (The type when you get there is "const wxChar *"  and you get a pointer plus
   the string)
   The following works but we'd be better with the IDE to supply the name of the
   variable in question via LastVOVar.
 */}

    if (VarType = GDBwxString) then
    begin

        Buffer := '-var-info-path-expression ' + Name + NL;
        Buffer := Buffer + '-var-list-children 1 ' + Name + NL;
        Buffer := Buffer + '-var-list-children 1 ' + Name + '.wxStringBase' + NL;
        Buffer := Buffer + '-var-list-children 1 ' + Name + '.wxStringBase.protected' + NL;
        Buffer := Buffer + '-var-evaluate-expression -f natural ' + Name + '.wxStringBase.protected.m_pchData' + NL;
        WriteToPipe(Buffer);
        ParseVObjCreate := FALSE;
    end
    else
    begin
        Ret := Ret and ParseConst(@Msg, @GDBvalue, PString(@Value));
        Ret := Ret and ParseConst(@Msg, @GDBNameq, PString(@LastVOident));

        ParseVObjCreate := FALSE;
        if (Ret) then            // If all 3 are found it probably was a VObj... but we can't prove it
        begin
            LastVOVar := '<fix me>'; //MidStr(MainForm.Edit1.Text, 17, 99);    // ! ! !  We need the real name from the IDE
            Value := OctToHex(@Value);
            Value := unescape(@Value);

            ValStrings := TStringList.Create;
            ValStrings.Add(Value);
            OnVariableHint(ValStrings);
            ValStrings.Clear; ValStrings.Free;

            Output := format('%s has value %s', [LastVOVar, Value]);
        // gui_critSect.Enter();
            AddToDisplay(Output);
        // gui_critSect.Leave();
            ParseVObjCreate := TRUE;
        end;
    end;
end;

//=================================================================

function TGDBDebugger.ParseVObjAssign(Msg: string): boolean;
{
/*
   Parses out Variable new value
   (also works for -data-evaluate-expression expr but will attach the name
    of the last VObj used to the output string unless LastVOVar has been set
    to 'expression' by the IDE).
*/
}
var
    Value: string;
    ValStrings: TStringList;
    start: integer;
    Output: string;

begin
    start := 0;

    Value := ExtractBracketed(@Msg, @start, NIL, '"', FALSE); // because 'value' gets stripped off!

    ParseVObjAssign := FALSE;
    if (start = 13) then            // 13 = length('done,value=') - Most likely it was a VObj or expression value ... but we can't prove it
    begin
    // Handle wxString
        start := Pos(wxStringBase, Value);
        if ((start < 6) and not (start = 0)) then
            Value := ExtractWxStr(@Value);
        Value := OctToHex(@Value);
        Value := unescape(@Value);
        ValStrings := TStringList.Create;
        ValStrings.Add(Value);
        OnVariableHint(ValStrings);
        ValStrings.Clear;
        ValStrings.Free;

        Output := format('%s has value %s', [LastVOVar, Value]);
    // gui_critSect.Enter();
        AddtoDisplay(Output);
    // gui_critSect.Leave();
        ParseVObjAssign := TRUE;
    end;
end;


//=================================================================

procedure TGDBDebugger.FillTooltipValue(Msg: string);
{
/*
   Parses out the Tooltip value
*/
}
var
    Value: string;
    ValStrings: TStringList;
    start: integer;
    Output: string;

begin
    start := 0;

    Value := ExtractBracketed(@Msg, @start, NIL, '"', FALSE); // strip 'value'

    if (start = 13) then            // 13 = length('done,value=')
    begin
    // Handle wxString
        ReplaceWxStr(@Value);
        Value := OctToHex(@Value);
        Value := unescape(@Value);
        ValStrings := TStringList.Create;
        ValStrings.Add(Value);
        OnVariableHint(ValStrings);
        ValStrings.Clear;
        ValStrings.Free;
        if (MainForm.VerboseDebug.Checked) then
        begin
            Output := format('Tooltip has value %s', [Value]);
      // gui_critSect.Enter();
            AddtoDisplay(Output);
      // gui_critSect.Leave();
        end;
    end;
end;

//=================================================================

procedure TGDBDebugger.ParseBreakpoint(Msg: string; List: PList);
{

   Part of Third Level Parse of Output.

}
var

    Num: integer;
    BPType: string;
    SrcFile: string;
    Line: integer;
    Expr: string;
    Addr: string;
    Vari : PWatchVar;

    Output: string;
    {Ret: Boolean;}

begin
    Num := 0;
    Line := 0;
    {Ret := false;}

    {Ret := }ParseConst(@Msg, @GDBnumber, PInteger(@Num));
    {Ret := }ParseConst(@Msg, @GDBtype, PString(@BPType));

    if (BPType = GDBbpoint) then
    begin
        ParseConst(@Msg, @GDBaddr, PString(@Addr));
        if (ParseConst(@Msg, @GDBorig_loc, PString(@SrcFile)) and (Addr = GDBmult)) then
            Output := format('Breakpoint No %d set at multiple addresses at %s', [Num, SrcFile])
        else
        begin
			         ParseConst(@Msg, @GDBline, PInteger(@Line));
			         ParseConst(@Msg, @GDBfile, PString(@SrcFile));
			         Output := format('Breakpoint No %d set at line %d in %s', [Num, Line, SrcFile]);
            FillBreakpointNumber(@SrcFile, Line, Num);
        end;
        if (MainForm.VerboseDebug.Checked) then
		      begin
			// gui_critSect.Enter();
			         AddtoDisplay(Output);
			// gui_critSect.Leave();
		      end;
    end
    else
    begin
		{Ret := }ParseConst(@Msg, @GDBwhat, PString(@Expr));
		      if (BPType = GDBwptread) then
			         Output := format('Watchpoint No %d (read) set for %s', [Num, Expr]);
		      if (BPType = GDBwptacc) then
			         Output := format('Watchpoint No %d (acc) set for %s', [Num, Expr]);
		      if (BPType = GDBwpthw) then
			         Output := format('Watchpoint No %d (hw)  set for %s', [Num, Expr]);
		      if (BPType = GDBwpoint) then
			         Output := format('Watchpoint No %d set for %s', [Num, Expr]);
        if (MainForm.VerboseDebug.Checked) then
		      begin
			// gui_critSect.Enter();
			         AddtoDisplay(Output);
			// gui_critSect.Leave();
		      end;
		      if not (List = NIL) then
		      begin
			         New(Vari);
			         Vari.Name := format('%s', [Expr]);
			         Vari.Value := '';
			         List.Add(Vari);
		      end;
    end;
end;

//=================================================================

procedure TGDBDebugger.ParseBreakpointTable(Msg: string);
{
   Part of Third Level Parse of Output.
}
var
    N_rows, row: integer;
    Str: string;
    BkptStr: string;
    {Ret: Boolean;}

begin
    N_rows := 0;
    {Ret := false;}
    {Ret := }ParseConst(@Msg, @GDBnr_rows, PInteger(@N_rows));
    Str := ExtractNamed(@Msg, @GDBbody, 1);

    if (not (Str = '')) then
    begin
        for row := 1 to N_rows do
        begin
            BkptStr := ExtractNamed(@Str, @GDBbkpt, row);
            ParseBreakpoint(BkptStr, NIL);
        end;
    end;

end;

//=================================================================

procedure TGDBDebugger.AddWatch(VarName: string; when: TWatchBreakOn);
{
   Adds a watch variable/expression VarName to the TTreeView list,
   and to GDB's list.
   Uses token to allow us to identify our result when it is returned.
}
var
    Watch: PWatchPt;
    Command: TCommand;
begin
    with MainForm.WatchTree.Items.Add(NIL, VarName) do
    begin
        ImageIndex := 21;
        SelectedIndex := 21;
        New(Watch);
        Watch^.Name := varname;
        Watch^.Value := wpUnknown;
        Watch^.BPNumber := 0;
        Watch^.Deleted := FALSE;
        Watch^.Token := WATCHTOKENBASE + MainForm.WatchTree.Items.Count - 1;
        Watch^.BPType := when;
        Data := Watch;
        Text := Watch^.Name + ' = ' + Watch^.Value;
    end;

    Command := TCommand.Create;
    Command.Data := Pointer(Watch);
    case when of
        wbRead:
            Command.Command := Format('%d%s%s -r %s',
                [Watch^.Token, GDBbrkwatch, WriteGDBContext(SelectedThread, SelectedFrame), varname]);
        wbWrite:
            Command.Command := Format('%d%s%s -a %s',
                [Watch^.Token, GDBbrkwatch, WriteGDBContext(SelectedThread, SelectedFrame), varname]);
        wbBoth:
            Command.Command := Format('%d%s%s -a %s',
                [Watch^.Token, GDBbrkwatch, WriteGDBContext(SelectedThread, SelectedFrame), varname]);
    end;
    QueueCommand(Command);
end;

//=================================================================

procedure TGDBDebugger.LoadAllWatches;
{
   MUST ONLY BE CALLED ON GDB STARTUP

   Loads GDB with all the watches in the TTreeView list.
   Uses token to allow us to identify our returning result.
}
var
    Watch: PWatchPt;
    Command: TCommand;
    index: integer;
begin
    with MainForm.WatchTree do
        for index := 0 to Items.Count - 1 do
        begin
            Watch := Items[index].Data;
            Watch^.Value := wpUnknown;
            Watch^.BPNumber := 0;
            Watch^.Deleted := FALSE;
            Watch^.Token := WATCHTOKENBASE + index;
            Items[index].Text := Watch^.Name + ' = ' + Watch^.Value;


            Command := TCommand.Create;
            case Watch^.BPType of
                wbRead:
                    Command.Command := Format('%d%s -r %s',
                        [Watch^.Token, GDBbrkwatch, Watch^.Name]);
                wbWrite:
                    Command.Command := Format('%d%s -a %s',
                        [Watch^.Token, GDBbrkwatch, Watch^.Name]);
                wbBoth:
                    Command.Command := Format('%d%s -a %s',
                        [Watch^.Token, GDBbrkwatch, Watch^.Name]);
            end;

            QueueCommand(Command);
        end;
end;

//=================================================================

procedure TGDBDebugger.ReLoadWatches;
{
   Automatically reloads GDB with deleted watches.

   Loads GDB with all the watches flagged as 'deleted' in the TTreeView list.
   Uses token to allow us to identify our result when it is returned.
}
var
    Watch: PWatchPt;
    Command: TCommand;
    index: integer;
begin
    with MainForm.WatchTree do
        for index := 0 to Items.Count - 1 do
        begin
            Watch := Items[index].Data;
            if (Watch^.Deleted) then
            begin
                Watch^.Value := wpUnknown;
                Watch^.BPNumber := 0;
                Watch^.Deleted := FALSE;
                Watch^.Token := WATCHTOKENBASE + index;
                Items[index].Text := Watch^.Name + ' = ' + Watch^.Value;

                Command := TCommand.Create;
                case Watch^.BPType of
                    wbRead:
                        Command.Command := Format('%d%s%s -r %s',
                            [Watch^.Token, GDBbrkwatch, WriteGDBContext(SelectedThread, SelectedFrame), Watch^.Name]);
                    wbWrite:
                        Command.Command := Format('%d%s%s -a %s',
                            [Watch^.Token, GDBbrkwatch, WriteGDBContext(SelectedThread, SelectedFrame), Watch^.Name]);
                    wbBoth:
                        Command.Command := Format('%d%s%s -a %s',
                            [Watch^.Token, GDBbrkwatch, WriteGDBContext(SelectedThread, SelectedFrame), Watch^.Name]);
                end;
                QueueCommand(Command);
            end;
        end;
end;

//=================================================================

procedure TGDBDebugger.RemoveWatch(node: TTreenode);
{
    Removes a watch from the TTreeView list and from GDB's list.
}
var
    Watch: PWatchPt;
    Command: TCommand;
begin
    //while Assigned(node) and (Assigned(node.Parent)) do
    //  node := node.Parent;

    //Then clean it up
    if Assigned(node) then
    begin
        Watch := node.Data;
        if ((Watch.BPNumber = 0) and not (Watch.Deleted)) then
        begin
            DisplayError('Internal Error: unable to identify Watchpoint');
            Exit;
        end;
        Command := TCommand.Create;
        Command.Command := Format('%s %d', [GDBbrkdel, watch.BPNumber]);
        QueueCommand(Command);
        Dispose(node.Data);
        MainForm.WatchTree.Items.Delete(node);
    end;
end;

//=================================================================

procedure TGDBDebugger.GetWatchedValues;
{
    Part of Third Level Parse of Output.
    Reads a list of Watched variables in the WatchTree list and emits a request
    for the present values for each in the list.


    Uses token to allow us to identify our result when it is returned.
}

var
    I: integer;

    Watch: PWatchPt;
    Command: TCommand;

begin
    with MainForm.WatchTree do
        for I := 0 to (Items.Count - 1) do
        begin
            Watch := Items[I].Data;
            Watch.Token := WATCHTOKENBASE + I;
            Command := TCommand.Create;
            Command.Command := format('%d%s%s %s', [Watch.Token, GDBdataeval,
		              WriteGDBContext(SelectedThread, SelectedFrame), Watch.Name]);
            Command.Callback := NIL;
            QueueCommand(Command);
        end;

end;

//=================================================================

procedure TGDBDebugger.FillWatchValue(Msg: string);
{
   Part of Third Level Parse of Output.
   Receives the result of a single "-data-evaluate-expression ..."
   identified by a designated token, and adds the variable value to the
   Watched variable in WachTree list.
}

var
    Value: string;
    start: integer;
    I: integer;
    Watch: PWatchPt;

begin
    Value := ExtractBracketed(@Msg, @start, NIL, '"', FALSE); // must strip 'value'
    Value := OctToHex(@Value);
    ReplaceWxStr(@Value);
    I := Token - WATCHTOKENBASE;
    Watch := MainForm.WatchTree.Items[I].Data;
    Watch.Value := Value;
    MainForm.WatchTree.Items[I].Text :=
        Format('%s = %s', [Watch.Name, Watch.Value]);
    Token := 0;
end;

//=================================================================

procedure TGDBDebugger.ParseStack(Msg: string);
{

   Part of Third Level Parse of Output.

}
var
    level: integer;
    FrameStr: string;
    Output: string;
    CallStack: TList;
    Frame: PStackFrame;
    I: integer;

begin
    level := 0;

    if (not (Msg = '')) then
    begin
        CallStack := TList.Create;
        repeat
            begin
                Inc(level);
                New(Frame);
                FrameStr := ExtractNamed(@Msg, @GDBframe, level);
                if (FrameStr = '') then
                    break;
                Output := ParseFrame(FrameStr, Frame);
                CallStack.Add(Frame);
                if (MainForm.VerboseDebug.Checked) then
                    AddtoDisplay(Output);

            end
        until (level >= MAXSTACKDEPTH);               // Arbitrary limit for safety!
        if (level = MAXSTACKDEPTH) then
            if (MainForm.VerboseDebug.Checked) then
            begin
            // gui_critSect.Enter();
                AddtoDisplay('Stack is too deep, Aborting...');
            // gui_critSect.Leave();
            end;

        MainForm.OnCallStack(CallStack);

        try
        { Cleanup: must free the list items as well as the list }
            for I := 0 to (CallStack.Count - 1) do
            begin
                Frame := CallStack.Items[I];
                Dispose(Frame);
            end;
        finally
            CallStack.Free;
        end;
    end;
end;

//=================================================================

function TGDBDebugger.ParseFrame(Msg: string; Frame: PStackFrame): string;
{
   Part of Third Level Parse of Output.
}
var
    Level: integer;
    Func: string;
    SrcFile: string;
    Line: integer;

    Output: string;
    {Ret: Boolean;}
    SubOutput: string;
    SubOutput1: string;

begin

    Level := 0;
    Line := 0;
    {Ret := false;}

    if (not (Msg = '')) then
    begin

        Output := format('Stack Frame: %s', [Msg]);

        {Ret := }ParseConst(@Msg, @GDBlevel, PInteger(@Level));
        {Ret := }ParseConst(@Msg, @GDBfunc, PString(@Func));
        {Ret := }ParseConst(@Msg, @GDBline, PInteger(@Line));
        {Ret := }ParseConst(@Msg, @GDBfile, PString(@SrcFile));
        if not (Frame = NIL) then
        begin
            Frame.Filename := ExtractFileName(SrcFile);
            Frame.FuncName := format('%*s%s', [Level, '', Func]);
            Frame.Line := Line;
            Frame.Args := '';
        end;

        if (Level = 0) then
            SubOutput := 'Stopped in '
        else
            SubOutput := 'called from';
        if (Line = 0) then
            SubOutput1 := '<no line number>'
        else
            SubOutput1 := format('at Line %d', [Line]);

        Output := format('Level %2d: %*s %s  %s  %s', [Level, Level + 1, ' ', SubOutput, Func, SubOutput1]);
    end;
    ParseFrame := Output;
end;

//=================================================================

procedure TGDBDebugger.ParseThreads(Msg: string);
{
   Part of Third Level Parse of Output.
}
var

    ThreadStr: string;
    ThreadList: string;
    CurrentThread: string;
    start: integer;
    next: integer;
    ThreadID: string;
    TargetID: string;
    Output: string;
    Threads: TList;
    Thread: PDebuggerThread;
    I: integer;

begin

	   Threads := TList.Create;

	   ParseConst(@Msg, @GDBcurthread, PString(@CurrentThread));
	   ThreadList := ExtractBracketed(@Msg, @start, @next, '[', FALSE);
	   if (ThreadList = '') then
	   begin
		      CurrentGDBThread := 0;
        SelectedThread := 0;
        SelectedFrame := 0;
        // gui_critSect.Enter();
		      AddtoDisplay('No active threads');
        // gui_critSect.Leave();
	   end
	   else
	   begin
		// gui_critSect.Enter();
		      AddtoDisplay('Current Thread ID = ' + CurrentThread);
		// gui_critSect.Leave();
		      CurrentGDBThread := StrToIntDef(CurrentThread, 0);
        SelectedThread := CurrentGDBThread;
        SelectedFrame := 0;
		      repeat
		          begin
			             ThreadStr := ExtractBracketed(@ThreadList, @start, @next, '{', FALSE);
			             if (MainForm.VerboseDebug.Checked) then
			             begin
				// gui_critSect.Enter();
				                AddtoDisplay('Thread: ');
				                AddtoDisplay(ThreadStr);
				// gui_critSect.Leave();
			             end;
			             if (not (ThreadStr = '')) then
			             begin
				                New(Thread);
				                ParseConst(@ThreadList, @GDBid, PString(@ThreadID));
				                ParseConst(@ThreadList, @GDBtargetid, PString(@TargetID));
				                if (MainForm.VerboseDebug.Checked) then
				                begin
					// gui_critSect.Enter();
					                   AddtoDisplay('Thread ID = ' + ThreadID);
					// gui_critSect.Leave();
				                end;

				                Output := ParseFrame(ThreadStr, NIL);
				                Threads.Insert(0, Thread);
				                with Thread^ do
				                begin
					                   Active := (ThreadId = CurrentThread);
					                   Index := ThreadId;
					                   ID := TargetID + '  ' + Output;
				                end;

			             end;
			             ThreadList := AnsiRightStr(ThreadList, Length(ThreadList) - next);
		          end
		      until ((ThreadList = '') or (next = 0));
	   end;

	   MainForm.OnThreads(Threads);

	   try
      { Cleanup: must free the list items as well as the list }
	       for I := 0 to (Threads.Count - 1) do
	       begin
		          Thread := Threads.Items[I];
		          Dispose(Thread);
	       end;
	   finally
		      Threads.Free;
	   end;

end;

//=================================================================

procedure TGDBDebugger.ParseWatchpoint(Msg: string);
{
   Part of Third Level Parse of Output.

   Acknowledgement of watchpoint loaded by GDB.
   Updates the Watchpoint data record.
}
var
    Num: integer;
    Expr: string;

    Watch: PWatchPt;
    Output: string;
    index: integer;
    {Ret: Boolean;}
begin
    Num := 0;
    {Ret := false;}

    {Ret := }ParseConst(@Msg, @GDBnumber, PInteger(@Num));
    {Ret := }ParseConst(@Msg, @GDBexp, PString(@Expr));
    if ((Token >= WATCHTOKENBASE) and (Token < MODVARTOKEN)) then
        with MainForm.WatchTree.Items do
        begin
            if not (Count = 0) then
            begin
                for index := 0 to Count - 1 do
                begin
                    Watch := Item[index].Data;
                    if ((Watch.Name = Expr) and (Watch.BPNumber = 0)) then
                    begin
                        Watch.BPNumber := Num;
                        Watch.Inactive := FALSE;
                        Watch.Deleted := FALSE;
                        Item[index].Text := Format('%s = %s', [Watch.Name, Watch.Value]);
                    end;
                end;
            end;
        end;
    Token := 0;
    if (MainForm.VerboseDebug.Checked) then
	   begin
		      Output := format('Watchpoint No %d set for %s', [Num, Expr]);
		// gui_critSect.Enter();
		      AddtoDisplay(Output);
		// gui_critSect.Leave();
	   end;

end;

//=================================================================

procedure TGDBDebugger.ParseWatchpointError(Msg: string);
{
   Part of Third Level Parse of Output.
   Handles errors accompanied by a Watchpoint Token.
   Updates and may delete the Watchpoint data record.
}
var
    varname: string;
    watch: pWatchPt;
    index: integer;

begin
    // These messages were gathered from GDB source. Not all might be seen.
    if ((AnsiStartsStr(GDBError + GDBwperrnoimp, Msg))
        // "Expression cannot be implemented with read/access watchpoint."
        or (AnsiStartsStr(GDBError + GDBwperrnosup, Msg))
        // "Target does not support this type of hardware watchpoint."
        or (AnsiStartsStr(GDBError + GDBwperrsup, Msg))
        // "Target can only support one kind of HW watchpoint at a time."
        or (AnsiStartsStr(GDBError + GDBwperrjunk, Msg))
        // "Junk at end of command."
        or (AnsiStartsStr(GDBError + GDBwperrconst, Msg))
        // "Cannot watch constant value ..."
        or (AnsiStartsStr(GDBError + GDBwperrxen, Msg))
        // "Cannot enable watchpoint"
        or (AnsiStartsStr(GDBError + GDBwperrset, Msg))
        // "Unexpected error setting breakpoint or watchpoint"
        or (AnsiStartsStr(GDBError + GDBwperrustd, Msg))
        // "Cannot understand watchpoint access type."
        or (AnsiStartsStr(GDBError + GDBwperrxs, Msg))) then
        // "Too many watchpoints"
    begin
        index := Token - WATCHTOKENBASE;
        Watch := MainForm.WatchTree.Items[index].Data;
        Dispose(Watch);
        MainForm.WatchTree.Items[index].Delete;
        DisplayError('GDB Error: ' + Msg);
    end
    else
    if (AnsiStartsStr(GDBError + GDBNoSymbol, Msg)) then
    // It has gone out of scope or doesn't exist in present context
    begin
      // Flag as deleted - it can be resurrected if/when it comes into scope
        varname := ExtractBracketed(@Msg, NIL, NIL, '"', FALSE);
      // Find ALL watchpoints with a name starting with 'varname' and flag as deleted
        with MainForm.WatchTree do
            for index := 0 to Items.Count - 1 do
            begin
                Watch := Items[index].Data;
                if (AnsiStartsStr(varname, Watch^.Name)) then
                begin
                    Watch^.Value := wpUnknown;
                    Watch^.BPNumber := 0;
                    Watch^.Token := 0;
                    Watch^.Deleted := TRUE;
                    Items[index].Text := Watch^.Name + ' = ' + Watch^.Value;
                end;
            end;
    end
    else
    begin
      // It must be something else!
        DisplayError('GDB Error: ' + Msg);
{$ifdef DISPLAYOUTPUT}
      // gui_critSect.Enter();
      AddtoDisplay(Msg);
      // gui_critSect.Leave();
{$endif}
    end;
end;

//=================================================================

procedure TGDBDebugger.ParseCPUMemory(Msg: string);
{
   Part of Third Level Parse of Output.
   Parses memory display and writes to a RichText edit window
   in the familiar 'Hex Editor' style.
}
var
    MemList, List: string;
    memnext, next: integer;
    i, j, b: integer;
    displaystart, memstart, memend, mem: int64;
    Smemstart, Smemend: string;
    MemContent: string;
    Output, AscChars: string;
    AscChar: byte;

begin
    MemList := ExtractBracketed(@Msg, NIL, @memnext, '[', FALSE);
    repeat
        begin
            List := ExtractBracketed(@MemList, NIL, @next, '{', FALSE);
            if (not (List = '')) then
            begin
                ParseConst(@List, @GDBbegin, PString(@Smemstart));
                ParseConst(@List, @GDBend, PString(@Smemend));
                ParseConst(@List, @GDBcontents, PString(@MemContent));
                memstart := StrToInt64Def(Smemstart, 0);
                memend := StrToInt64Def(Smemend, 0);
                displaystart := memstart and (not $0f);
                mem := displaystart;
      //  (66 = length of preamble 'begin=" ..... contents="'
                if (memend > memstart + Trunc((Length(List) - 66) / 2)) then
                    memend := memstart + Trunc((Length(List) - 66) / 2);
                i := 0;
                j := 0;
                while (mem < memend) do
                begin
        // Line loop
                    AscChars := '';
                    Output := Output + format('0x%8.8X ', [displaystart + i]);
                    for b := 0 to 15 do
        // byte loop (Hex)
                    begin
                        if ((mem < memstart) or (mem >= memend)) then
                        begin
                            Output := Output + '   ';
                            AscChars := AscChars + ' ';
                        end
                        else
                        begin
                            Output := Output + format('%.1s%.1s ',
                                [MemContent[j * 2 + 1], MemContent[j * 2 + 2]]);
                            AscChar := StrToIntDef('$' + MemContent[j * 2 + 1] + MemContent[j * 2 + 2], 0);
                            if ((AscChar < 32) or (AscChar > 127)) then
                                AscChars := AscChars + ' '
                            else
                                AscChars := AscChars + Chr(AscChar);
                            Inc(j);
                        end;
                        if ((mem and $07) = $07) then
                            Output := Output + ' ';
                        Inc(mem);
                        Inc(i);
                    end;
                    Output := Output + AscChars + NL;
                end;
            end;
            MemList := AnsiRightStr(MemList, Length(MemList) - next);
            Output := Output + NL;
        end;
    until (next = 0);

    debugCPUFrm.MemoryRichEdit.Lines.Add(Output);

end;

//=================================================================

procedure TGDBDebugger.ParseCPUDisassem(Msg: string);

{
   Part of Third Level Parse of Output.
   Initial parse of Disassembly display.
}
var
  //  line: String;
    List: string;
    CurrentFuncName: string;
    next: integer;
    Output: string;

//  We expect:
//  Disassembly
//    Preamble:
//    ^done,asm_insns=[ <list 1> ]
//    <list 1> is 1 or more of
//      {address="<hex string>",func-name="<string>",offset="<int>",inst="<string>"},
//
//  Mixed Mode
//    Preamble:
//    ^done,asm_insns=[ <list 2> ]
//    <list 2> is 1 or more of
//      src_and_asm_line={ <tuple 1> },
//
//  <tuple 1> is
//  line="64",file="DebugeeFrm.cpp",line_asm_insn=[ <list 1> | empty ]
//

begin
    CurrentFuncName := '';
    List := ExtractBracketed(@Msg, NIL, @next, '[', FALSE);
    if (AnsiStartsStr(GDBsrcline, List)) then
  // Mixed Mode
        Output := ParseCPUMixedMode(List);
    if (AnsiStartsStr('{' + GDBaddress, List)) then
  // Disassemby Mode
        Output := ParseCPUDisasmMode(List, @CurrentFuncName);
    DebugCPUFrm.DisassemblyRichEdit.Lines.Add(Output);
end;

//=================================================================

function TGDBDebugger.ParseCPUMixedMode(List: string): string;
{
   Part of Third Level Parse of Output.
   Parses Mixed Mode (disassembly related to line numbers) and writes
   to a RichText edit window.
   Redundant lines, etc, are removed.
   (Takes data preprocessed by ParseCPUDisassem)

   Display algorithm for <tuple>:
 	 Extract vars but pass line_asm_insn to ParseCPUDisasmMode;
     if 'file' = same as stored, skip it
      else write it and store it;
     write vars to Output.
   Skip but report empty lines to reduce output bloat. 
}
var
    Line, LineNum, FileName, AsmInstr, Output: string;
    CurrentFileName, CurrentFuncName, FirstLine, LastLine: string;
    next: integer;
    NoAsm: boolean;

begin
    CurrentFileName := '';
    CurrentFuncName := '';
    NoAsm := FALSE;

    repeat
        begin
            Line := ExtractBracketed(@List, NIL, @next, '{', FALSE);
            if (not (Line = '')) then
            begin
                ParseConst(@Line, @GDBlineq, PString(@LineNum));
                ParseConst(@Line, @GDBfileq, PString(@FileName));
                AsmInstr := ExtractBracketed(@Line, NIL, NIL, '[', FALSE);
                FileName := ExtractFileName(FileName);

                if (not (FileName = CurrentFileName)) then
                begin
                    Output := Output + format('%s: %s%s', [FileStr, FileName, NL]);
                    CurrentFileName := FileName;
                end;
                if (AsmInstr = '') then
                begin
                    if (NoAsm = FALSE) then
                        FirstLine := LineNum;
                    NoAsm := TRUE;
                    LastLine := LineNum;
                end
                else
                begin
                    NoAsm := FALSE;
                    if ((FirstLine = '') and (LastLine = '')) then
           // Do nothing!
                    else
                    if (FirstLine = LastLine) then
                        Output := Output + 'Line: ' + FirstLine
                            + ' ' + NoDisasmStr + NL
                    else
                    if ((FirstLine = '') or (LastLine = '')) then
                        Output := Output + LineStr + ': ' + LineNum + NL
                    else
                        Output := Output + LinesStr + ': ' + FirstLine + ' - ' + LastLine
                            + ' ' + NoDisasmStr + NL;
                    Output := Output + LineStr + ': ' + LineNum + NL;
                    Output := Output + ParseCPUDisasmMode(AsmInstr, @CurrentFuncName);
                    FirstLine := '';
                    LastLine := '';
                end;
            end;
            List := AnsiRightStr(List, Length(List) - next);
        end;
    until (next = 0);
    ParseCPUMixedMode := Output;
end;

//=================================================================

function TGDBDebugger.ParseCPUDisasmMode(List: string; CurrentFuncName: PString): string;
{
   Part of Third Level Parse of Output.
   Parses disassembly display and writes to a RichText edit window.
   (Takes data preprocessed by ParseCPUDisassem and ParseCPUMixedMode)
}
//   Disassembly Mode
//   We expect a list of
//     {address="<hex string>",func-name="<string>",offset="<int>",inst="<string>"},
{
    Display algorithm:
    	Extract vars;
      if 'func-name' = same as stored, skip it
       else write it and store it;
      write vars to Output.
}
var
    Line, Address, FuncName, Offset, Instr, Output: string;
    next: integer;

begin
    repeat
        begin
            Line := ExtractBracketed(@List, NIL, @next, '{', FALSE);
            if (not (Line = '')) then
            begin
                ParseConst(@Line, @GDBaddress, PString(@Address));
                ParseConst(@Line, @GDBfuncname, PString(@FuncName));
                ParseConst(@Line, @GDBoffset, PString(@Offset));
                ParseConst(@Line, @GDBinstr, PString(@Instr));
                if (not (FuncName = CurrentFuncName^)) then
                begin
                    Output := Output + format('%s: %s%s', [FuncStr, FuncName, NL]);
                    CurrentFuncName^ := FuncName;
                end;
                Output := Output + Address + HT + Offset + HT + Instr + NL;

            end;
            List := AnsiRightStr(List, Length(List) - next);
        end;
    until (next = 0);
    ParseCPUDisasmMode := Output;
end;

//=================================================================

procedure TGDBDebugger.ParseRegisterNames(Msg: string);
{
   Part of Third Level Parse of Output.
   Parses list of register names, then generates request to get their values.
}
var
    List: string;
    start, next, i: integer;

begin
    List := ExtractBracketed(@Msg, @start, @next, '[', FALSE);
    for i := 0 to CPURegCount do
    begin
        CPURegNames[i] := ExtractBracketed(@List, @start, @next, '"', FALSE);
        List := MidStr(List, next, Length(List));
    end;
    WriteToPipe(format(GDBlistregvalues, [WriteGDBContext(SelectedThread, SelectedFrame)]) + CPURegList);
end;

//=================================================================

procedure TGDBDebugger.ParseRegisterValues(Msg: string);
{
   Part of Third Level Parse of Output.
   Parses and pairs up the list of register values against the list of register names.
}
var
    List, Reg, Value: string;
    start, next, Number, i: integer;

begin
    List := ExtractBracketed(@Msg, @start, @next, '[', FALSE);

    for i := 0 to CPURegCount do
    begin
        Reg := ExtractBracketed(@List, @start, @next, '{', FALSE);
        ParseConst(@Reg, @GDBvalue, PString(@Value));
        ParseConst(@Reg, @GDBnumber, PInteger(@Number));
        if ((Number >= 0) and (Number <= CPURegCount)) then
            CPURegValues[Number] := Value;
        List := MidStr(List, next, Length(List));
        if (MainForm.VerboseDebug.Checked) then
            AddtoDisplay(CPURegNames[i] + '  ' + CPURegValues[i]);
        DebugCPUFrm.RegisterList.InsertRow(CPURegNames[i], Value, TRUE);
    end;

{      If the 'natural' order of registers as GDB sends them is good enough,
       then retain the last 2 lines above, then the Registers class and the rest
       below can be removed.

  Registers := TRegisters.Create;
  for i:= 0 to CPURegCount do
  begin
    if      (CPURegNames[i] = 'eax') then Registers.EAX := CPURegValues[i]
    else if (CPURegNames[i] = 'ebx') then Registers.EBX := CPURegValues[i]
    else if (CPURegNames[i] = 'ecx') then Registers.ECX := CPURegValues[i]
    else if (CPURegNames[i] = 'edx') then Registers.EDX := CPURegValues[i]
    else if (CPURegNames[i] = 'esi') then Registers.ESI := CPURegValues[i]
    else if (CPURegNames[i] = 'edi') then Registers.EDI := CPURegValues[i]
    else if (CPURegNames[i] = 'ebp') then Registers.EBP := CPURegValues[i]
    else if (CPURegNames[i] = 'esi') then Registers.ESI := CPURegValues[i]
    else if (CPURegNames[i] = 'esp') then Registers.ESP := CPURegValues[i]
    else if (CPURegNames[i] = 'eip') then Registers.EIP := CPURegValues[i]
    else if (CPURegNames[i] = 'eflags') then Registers.EFLAGS := CPURegValues[i]
    else if (CPURegNames[i] = 'cs') then Registers.CS := CPURegValues[i]
    else if (CPURegNames[i] = 'ds') then Registers.DS := CPURegValues[i]
    else if (CPURegNames[i] = 'ss') then Registers.SS := CPURegValues[i]
    else if (CPURegNames[i] = 'es') then Registers.ES := CPURegValues[i]
    else if (CPURegNames[i] = 'gs') then Registers.GS := CPURegValues[i]
    else if (CPURegNames[i] = 'fs') then Registers.FS := CPURegValues[i];
  end;
  if (MainForm.VerboseDebug.Checked)
    AddtoDisplay(CPURegNames[i] + '  '+CPURegValues[i]);
  DebugCPUFrm.RegisterList.InsertRow(CPURegNames[i], Value, true);
}

end;

//=================================================================

procedure TGDBDebugger.WatchpointHit(Msg: PString);
{
   INCOMPLETE
   Does nothing with the result apart from writing to display
   Needs to build a list to pass back to the IDE
   Parses out Watchpoint details
   May be easier to split this for the 3 types of Watchpoint
}
var
    Temp: string;
    Num, Line: integer;
    Expr, Wpt, Val, Old, New, Value, Func, SrcFile, frame, Output: string;
    hasOld, hasNew, hasValue: boolean;
    //Ret: Boolean;

begin
    Temp := Msg^;
    Num := 0;
    Line := 0;

    //Ret := false;
    Val := ExtractNamed(@Temp, @GDBvalueqb, 1);
    Wpt := ExtractNamed(@Temp, @GDBwpt, 1);
    {Ret := }ParseConst(@Wpt, @GDBnumber, PInteger(@Num));

    hasOld := ParseConst(@Val, @GDBold, PString(@Old));
    if (hasOld) then
        Old := ' was ' + Old;
    hasNew := ParseConst(@Val, @GDBnew, PString(@New));
    if (hasNew) then
        New := ' now ' + New;
    hasValue := ParseConst(@Val, @GDBvalue, PString(@Value));
    if (hasValue) then
        Value := ' Presently ' + Value;

    {Ret := }ParseConst(@Wpt, @GDBexp, PString(@Expr));

    Frame := ExtractNamed(@Temp, @GDBframe, 1);
    {Ret := }ParseConst(@Frame, @GDBfile, PString(@SrcFile));
    {Ret := }ParseConst(@Frame, @GDBfunc, PString(@Func));
    {Ret := }ParseConst(@Frame, @GDBline, PInteger(@Line));

    if (MainForm.VerboseDebug.Checked) then
	   begin
		      Output := Format('Watchpoint No %d hit. %s%s%s%s in %s at line %d in %s',
			         [Num, Expr, Old, New, Value, Func, Line, SrcFile]);
		// gui_critSect.Enter();
		      AddtoDisplay(Output);
		// gui_critSect.Leave();
	   end;

    // Line No. is not meaningful - need to find some way to relate to source line in editor,
    //  else disable GDB's ability to trace into headers/libraries.
    MainForm.GotoBreakpoint(SrcFile, Line);
end;

//=================================================================

procedure TGDBDebugger.BreakpointHit(Msg: PString);
// Parses out Breakpoint details

var
    Temp: string;
    Num, Line: integer;
    Func, SrcFile, frame, Output: string;
    //Ret: Boolean;

begin

    Temp := Msg^;
    Num := 0;

    //Ret := false;

    {Ret := }ParseConst(Msg, @GDBbkptno, PInteger(@Num));
    Frame := ExtractNamed(@Temp, @GDBframe, 1);
    {Ret := }ParseConst(@frame, @GDBfile, PString(@SrcFile));
    {Ret := }ParseConst(@frame, @GDBfunc, PString(@Func));
    {Ret := }ParseConst(@frame, @GDBline, PInteger(@Line));

    if (MainForm.VerboseDebug.Checked) then
	   begin
		      Output := Format('Breakpoint No %d hit in %s at line %d in %s',
			         [Num, Func, Line, SrcFile]);
		// gui_critSect.Enter();
		      AddtoDisplay(Output);
		// gui_critSect.Leave();
	   end;

    // Line No. is not always meaningful - need to find some way to relate to source line in editor,
    //  else disable GDB's ability to trace into headers/libraries.
    MainForm.GotoBreakpoint(SrcFile, Line);
end;

//=================================================================

procedure TGDBDebugger.ModifyVariable(VarName: string; Value: string);
{
/*
   Writes 3 commands in succession to create a Variable Object, change its
   value and then delete the Variable Object.
   The name for the VO is made from the Variable Name with certain characters
   replaced and prefixed with 'VO'. I.E. MyClass.Prop[3] is named
     MyClass_Prop_3_
   Uses token to allow us to identify our result when it is returned.
*/
}
var
    VOName: string;
    i: integer;

begin
    VOName := VarName;
  // create a name
    for i := 1 to length(VOName) do
        if ((VOName[i] = '.') or (VOName[i] = '[') or (VOName[i] = ']')) then
            VOName[i] := '_';

{$ifdef DISPLAYOUTPUT}
  AddtoDisplay(format('Writing %d-var-create %s VO%s @ %s',
	[MODVARTOKEN, WriteGDBContext(SelectedThread, SelectedFrame), VOName, VarName]));
  AddtoDisplay(format('Writing %d-var-assign VO%s %s',[MODVARTOKEN, VOName, Value]));
  AddtoDisplay(format('Writing %d-var-delete VO%s',[MODVARTOKEN, VOName]));
{$endif}
    WriteToPipe(format(GDBvarcreate, [MODVARTOKEN,
	       WriteGDBContext(SelectedThread, SelectedFrame), VOName, VarName]));
    WriteToPipe(format(GDBvarassign, [MODVARTOKEN, VOName, Value]));
    WriteToPipe(format(GDBvardelete, [MODVARTOKEN, VOName]));

end;

//=================================================================

procedure TGDBDebugger.WptScope(Msg: PString);
// Parses out Watchpoint details
// N.B. "Msg" may contain multiple pairs of values:
//    reason="watchpoint-scope",wpnum="n",

var
    Temp: string;
    Reason, Output: string;
    Thread: integer;
    wpnum: integer;
    index: integer;
//  count: Integer;
    watch: PWatchPt;
  //Ret: Boolean;
    comma1, comma2: integer;
    BPStr: string;

begin

    Temp := Msg^;
  // reason="watchpoint-scope",wpnum="3",  <etc> ,thread-id="1",frame={addr="0x77c2c3d9",func="msvcrt!free",args=[],from="C:\\WINDOWS\\system32\\msvcrt.dll"}'

    ParseConst(Msg, @GDBthreadid, PInteger(@Thread));
    comma1 := FindFirstChar(Temp, ',');
    Temp := AnsiMidStr(Temp, (comma1 + 1), Length(Temp) - comma1 - 1);
//  count := 1;
    repeat
        comma1 := FindFirstChar(Temp, ',');
        if (comma1 = 0) then
            Break;
        comma2 := FindFirstChar(AnsiMidStr(Temp, (comma1 + 1), Length(Temp) - comma1 - 1), ',');
        if (comma2 = 0) then
            Break;
        BPStr := AnsiLeftStr(Temp, comma1 + comma2);
        Temp := AnsiMidStr(Temp, (comma1 + comma2 + 1), Length(Temp) - comma1 - comma2 - 1);

        ParseConst(@BPStr, @GDBreason, PString(@Reason));
        ParseConst(@BPStr, @GDBwpNum, PInteger(@wpnum));
        if ((not (Reason = '')) and (not (wpnum = 0))) then
        begin
            with MainForm.WatchTree.Items do
            begin
                if not (Count = 0) then
                begin
                    for index := 0 to Count - 1 do
                    begin
                        Watch := Item[index].Data;
                        if (Watch.BPNumber = wpnum) then
                        begin
                            Watch.Deleted := TRUE;
                            Watch.Value := wpUnknown;
                            Item[index].Text := Format('%s = %s', [Watch.Name, Watch.Value]);
                            Output := Format('Stopped - %s for %s in Thread %d', [Reason, Watch.Name, Thread]);
			                         CurrentGDBThread := Thread;
                            SelectedThread := Thread;
                            SelectedFrame := 0;

                        end;
                    end;
                end;
            end;
        end;
//    Inc(count);
    until ((Reason = '') or (wpnum = 0));

  // Restart the Target:
  //WriteToPipe(GDBcontinue);

  // gui_critSect.Enter();
    AddtoDisplay(Output);
  // gui_critSect.Leave();

end;

//=================================================================

procedure TGDBDebugger.StepHit(Msg: PString);
// Parses out Breakpoint details

var
    Temp: string;
    Line: integer;
    Func, SrcFile, frame, Output: string;
    //Ret: Boolean;

begin

    Temp := Msg^;

    //Ret := false;

    Frame := ExtractNamed(@Temp, @GDBframe, 1);
    {Ret := }ParseConst(@frame, @GDBfile, PString(@SrcFile));
    {Ret := }ParseConst(@frame, @GDBfunc, PString(@Func));
    {Ret := }ParseConst(@frame, @GDBline, PInteger(@Line));

    if (MainForm.VerboseDebug.Checked) then
	   begin
		      Output := Format('Stopped in %s at line %d in %s', [Func, Line, SrcFile]);
		// gui_critSect.Enter();
		      AddtoDisplay(Output);
		// gui_critSect.Leave();
	   end;

    // Line No. is not meaningful - need to find some way to relate to source line in editor,
    //  else disable GDB's ability to trace into headers/libraries.
    MainForm.GotoBreakpoint(SrcFile, Line);
end;

//=================================================================


function TGDBDebugger.SplitResult(Str: PString; Vari: PString): string;
{
/*
    Expects a string of form Variable = Value, where value may be a const, tuple or list
    Returns Value:
        Variable in Var
    Str MUST be well-formed, i.e. with no unmatched braces, etc.
 */
}
var
    Val: string;

begin          // SplitResult
    Vari^ := AnsiBeforeFirst('=', Str^);
    Val := AnsiAfterFirst('=', Str^);
    Vari^ := Trim(Vari^);
    Val := Trim(Val);
    SplitResult := Val;
end;

//=================================================================

function TGDBDebugger.ExtractLocals(Str: PString): string;
// expects Str to be of form "done,locals=Result"
var
	   Output: string;
	   Level: integer;
	   LocalsStr: string;
	   Val: string;
	   Vari: string;   // This is called Var in the GDB spec !
	   I: integer;
	   Local: PVariable;
	   LocalsList: TList;

begin

	   LocalsList := TList.Create;
	   Level := 0;

	   LocalsStr := AnsiMidStr(Str^, Length(GDBdone) + 1, Length(Str^) - Length(GDBdone));
	   if (AnsiStartsStr(GDBlocalsq, LocalsStr)) then
	   begin
		      LocalsStr := MidStr(Str^, Length(GDBdone) + 1, Length(Str^) - Length(GDBdone));
		      Val := SplitResult(@LocalsStr, @Vari);    // Must start with a List or a Tuple

		      if (AnsiStartsStr('{', Val)) then
			         Output := ExtractList(@LocalsStr, PARSETUPLE, Level, LocalsList)
		      else // it starts '['
			         Output := ExtractList(@LocalsStr, PARSELIST, Level, LocalsList);
		      ExtractLocals := GDBlocalsq + Output;
	   end;
	   MainForm.OnLocals(LocalsList);
	   try
		{ Cleanup: must free the list items as well as the list }
	       for I := 0 to (LocalsList.Count - 1) do
	       begin
		          Local := LocalsList.Items[I];
		          Dispose(Local);
	       end;
	   finally
		      LocalsList.Free;
	   end;

end;

//=================================================================

function TGDBDebugger.ParseResult(Str: PString; Level: integer; List: TList): string;
{
/*
    Parses a Result extracted from a Result-record of the form var = value.
    The Result must NOT be enclosed in quotes, brackets or braces,
    and must be well-formed.
    A special case - wxString - is handled specially.

    [In the comments of this and the functions that follow, words like
     "Result", "Tuple", "List" with initial capitals have the meanings
     defined in the GDB formal output syntax specification.
     N.B "list" - with lower-case l - has the ordinary meaning].

    Returns the sub-string reassembled from parsing the original Str.
    wxStrings are condensed into the form var = "string"
    This is suitable for display on one line.

    Str is expected to be of the form variable = value (as defined in the formal
    specification, where value can be a Const or Tuple or List, etc
    Level is the recursion level or degree of indentation in the list
    Plist is a pointer to the TList of TVariables that accepts the list of
    local variables.
}
var
    Output: string;
    Vari: string;   // This is called Var in the GDB spec !
   // start: Integer;
    Local : PWatchVar;
    Val: string;
    
begin          // ParseResult
    Val := SplitResult(Str, @Vari);
    Output := Vari;
    Output := Output + ' = ';
    if (Vari = GDBname) then                        // a name of a Tuple
    begin
        New(Local);

        Local.Number := 0;

        Output := Output + Val;
        Local.Name := format('%*s%s', [Level * INDENT, '',
            ExtractBracketed(@Val, NIL, NIL, '"', FALSE)]);
        Local.Value := '';
        List.Add(Local);
    end
    else
    if (Vari = GDBvalue) then                      // a value of named a Tuple
    begin
        ReplaceWxStr(@Val);
        if (AnsiStartsStr('"', Val)) then            // it's a quoted string e.g. a value of a Tuple
        begin
            New(Local);
            Local.Number := 0;
            Output := Output + OctToHex(@Val);
            if (List.Count > 0) then
                Local := List.Last;                      // so add the value to the last item
            Val := OctToHex(@Val);
            Local^.Value := Val;

            List.Remove(Local);
            List.Add(Local);
        end
        else
        begin
            if (List.Count = 0) then
            begin
                New(Local);

                Local.Number := 0;

                Local^.Value := Val;
            end
            else
            begin
                Local := List.Last;                      // so add it to the last item
                Local^.Value := Val;
                List.Remove(Local);
            end;
            List.Add(Local);
            Output := Output + Val;

        end;

    end

    else
    if (AnsiStartsStr('[', Val)) then              // it's a List
    begin

        Output := Output + ExtractList(Str, PARSELIST, Level, List);
    end

    else
    if (AnsiStartsStr('{', Val)) then              // it's a Tuple
    begin
        New(Local);
        Local.Number := 0;
        Local^.Name := format('%*s%s', [Level * INDENT, '',
            ExtractBracketed(@Vari, NIL, NIL, '"', FALSE)]);
        List.Add(Local);
        Output := Output + ExtractList(Str, PARSETUPLE, Level, List);
    end
    else
    begin                                          // it's a simple Const
        New(Local);
        Local.Number := 0;
        Local^.Name := format('%*s%s', [Level * INDENT, '',
            ExtractBracketed(@Vari, NIL, NIL, '"', FALSE)]);
        Val := OctToHex(@Val);
        Local^.Value := Val;
        List.Add(Local);
        Output := Output + Val;
    end;

    ParseResult := Output;
end;

//=================================================================

function TGDBDebugger.ExtractList(Str: PString; Tuple: boolean; Level: integer; List: TList): string;
{
    Extracts a comma-separated list of values or results from a List,
    of the form "[value(,value)*]"
             or "[result(,result)*]"

    N.B. This is recursive and will fully parse the Result tree.
}
var
	   delim1, delim2: char;
	   Remainder: string;
	   Item: string;
	   start, next: integer;
	   Output: string;

	   len, comma, lbrace, lsqbkt, equals: integer;

begin          // ParseList

  // Get the first result or value.
    // Remove outermost "[ ]" or "{ }"
    if (Tuple) then
    begin
		      delim1 := '{';
		      delim2 := '}';
    end
    else   // it's a List
    begin
		      delim1 := '[';
		      delim2 := ']';
    end;
    Remainder := ExtractBracketed(Str, @start, @next, delim1, FALSE);
    Output := Output + delim1;
    //
    //    At this point, we're inside  '[' ... ']' and expecting either
    //      result ("," result )*
    //    or
    //      value ("," value )*
    //
    //    A result starts with "variable = "  i.e. '=' must come before
    //       any of ',' '{' or '['
    //       -- anything else is a value,
    //
    //    A value must be a Tuple (start with '{'), a List (start with '[')
    //     otherwise it's a const.
    //

    while (TRUE) do
    begin                                                // Loop through the list
		      len := Length(Remainder);                          // find out which
		      if (Len = 0) then
			         break;
		      comma := FindFirstChar(Remainder, ',');
		      lbrace := FindFirstChar(Remainder, '{');
		      lsqbkt := FindFirstChar(Remainder, '[');
		      equals := FindFirstChar(Remainder, '=');

		      if (not (equals = 0)
            and ((lbrace = 0) or (equals < lbrace))
            and ((lsqbkt = 0) or (equals < lsqbkt))
            and ((comma = 0) or (equals < comma))) then    // we have a Result

        begin
            if (comma = 0) then                         // and the only or the last one
            begin
				            Output := Output + ParseResult(@Remainder, Level + 1, List);
				            break;                                    // done
            end
            else
            begin
				            Item := AnsiLeftStr(Remainder, comma - 1);  // ... or the first of many
				            Output := Output + ParseResult(@Item, Level + 1, List);
				            next := comma + 1;
				            Output := Output + ', ';
            end;
        end
        else                                            // we have a value
        begin
            if (comma = 0) then                         // and the only or the last one
            begin
                Output := Output + ParseValue(@Remainder, Level + 1, List);
                break;                                  // done
            end
            else
            begin
                Item := AnsiLeftStr(Remainder, comma - 1); // ... or the first of many
                Output := Output + ParseValue(@Item, Level + 1, List);
                Output := Output + ', ';
                next := comma + 1;
            end;
        end;
		      if (next < len) then
			         Remainder := AnsiMidStr(Remainder, next, Length(Remainder) - next + 1);
    end;
    Output := Output + delim2;
    ExtractList := Output;
end;

//=================================================================

function TGDBDebugger.ParseValue(Str: PString; Level: integer; List: TList): string;

//    Determines the content of a Value, i.e.
//        const | tuple | list
//    The Value must NOT be enclosed in {...} or [...]  -- although its
//    contents will be if those are a Tuple or a List.
//
//    N.B. This is recursive and will fully parse the Result tree.

var
	   Output: string;
	   s: integer;
	   n: integer;
	   Str2: string;
           Local : PWatchVar;
begin

    Str^ := TrimLeft(Str^);

       // ParseValue
	   if (AnsiStartsStr('{', Str^)) then                          // a Tuple
		      Output := Output + ExtractList(Str, PARSETUPLE, Level, List)
	   else
	   if (AnsiStartsStr('[', Str^)) then                          // a List
		      Output := Output + ExtractList(Str, PARSELIST, Level, List)
	   else
	   if ((Str^[1] = '"')
        and ((Str^[2] = '{') or (Str^[2] = '{')) and ExpandClasses) then  // it might be a class
	   begin
		      Str2 := ExtractBracketed(Str, @s, @n, '"', FALSE);
		      Output := Output + ExtractList(@Str2, PARSELIST, Level, List);
	   end
	   else
	   begin
		      New(Local);                           // a const
		      Local^.Value := Trim(OctToHex(Str));
        Local^.Name := '';
		      List.Add(Local);
		      Output := Output + OctToHex(Str);         // a const
	   end;
	   ParseValue := Output;
end;

//=================================================================

function TGDBDebugger.ExtractWxStr(Str: PString): string;

var
    starts: integer;
    ends: integer;
    QStr: string;

begin          // ExtractwxStr
    QStr := AnsiLeftStr(Str^, Length(Str^) - 20);
    if (AnsiPos('"{', QStr) = 1) then
        QStr := AnsiMidStr(QStr, 3, Length(QStr) - 3);    // Strip the wrapping
    if (AnsiPos('{', QStr) = 1) then
        QStr := AnsiMidStr(QStr, 2, Length(QStr) - 1);    // Strip the wrapping
    if (AnsiLastChar(QStr) = '>') then                // An Error Msg
        QStr := '<' + AnsiAfterLast('<', QStr)
    else                                              // a quoted string
    begin
        starts := AnsiPos('\"', QStr);
        ends := AnsiFindLast(GDBqStrEmpty, QStr);
        QStr := AnsiMidStr(QStr, starts + 2, ends - starts - 2);
    end;
    ExtractWxStr := unescape(@QStr);

end;

//=================================================================

procedure TGDBDebugger.ReplaceWxStr(Str: PString);

//    Expects a string with embedded wxStrings specifically of the form 

//    {<wxStringBase> = {static npos = 1234567890,
//    m_pchData = 0x12abcd \"A String with or without \\\"quotes\\\" embedded\"},
//     <No data fields>}
//
//    or
//
//    {<wxStringBase> = {static npos = 4294967295,
//    m_pchData = 0x13 <Address 0x13 out of bounds>},
//     <No data fields>}
//
//    or
//
//    {static npos = 4294967295, m_impl = {static npos = 4294967295,
//    _M_dataplus = {<std::allocator<wchar_t>> = {
//    <__gnu_cxx::new_allocator<wchar_t>> = {<No data fields>},
//    <No data fields>},_M_p = 0x1279d0c L\"a string\"}},
//    m_convertedToChar = {m_str = 0x0, m_len = 4294967295}}"}
//
//    (and may start with a quote and end with a comma)
//    and returns the string only.

//    and returns with the string that has only the quoted string itself embedded.
//      e.g. {MywxStr = {<wxStringBase> = {static npos = ..., m_pchData = 0x... \"AString\"}, <No data fields>}}
//    becomes
//      {MywxStr = "AString"}


var
    wxstarts: integer;
    starts: integer;
    ends: integer;
    QStr, Remainder, Output: string;

begin
    Remainder := Str^;
    Output := '';
    wxstarts := AnsiPos('{' + wxStringBase, Remainder);     // search for both variants
    if (wxstarts = 0) then
		wxstarts := AnsiPos( '{'+wxUnicodeStr, Remainder);
    while (not (wxstarts = 0)) do
    begin
        Output := Output + AnsiLeftStr(Remainder, wxstarts - 1);
        Remainder := AnsiRightStr(Remainder, Length(Remainder) - wxstarts + 1);
        QStr := ExtractBracketed(@Remainder, @starts, @ends, '{', TRUE);
        Output := Output + '"' + ExtractWxStr(@QStr) + '"';
        if (ends = 0) then
        begin
            Remainder := '';
            break;
        end;
        Remainder := AnsiRightStr(Remainder, Length(Remainder) - ends + starts);
        wxstarts := AnsiPos( '{'+wxStringBase, Remainder);     // search for both variants
		if (wxstarts = 0) then
			wxstarts := AnsiPos( '{'+wxUnicodeStr, Remainder);
    end;
    Str^ := Output + Remainder;
end;

//=================================================================

function unescape(s: PString): string;
// Unescapes a GDB double-escaped C-style string.
// E.g 'A \\\"quote\\\"'  becomes  'A \"quote\"'
var
	   i: integer;
	   temp: string;

begin
	   if (length(s^) > 1) then
	   begin
		      i := 1;

		      repeat
		          begin
			             if ((s^[i] = '\') and
			                 ((s^[i + 1] = '\') or (s^[i + 1] = '"'))) then
				                inc(i);
			             temp := temp + s^[i];
			             inc(i);
		          end;
		      until i > length(s^);
		      unescape := temp;
	   end
	   else
		      unescape := s^;
end;

//=================================================================

function OctToHex(s: PString): string;
// Replaces each Octal representation of an 8-bit number embedded in a string
//  with its Hex equivalent. Format must be '\nnn' or '\\0nn'
//  (i.e. escaped leading zero)
//  E.g.  '\302' => '0xC2'    '\\025' => '0x15'

//  Note: 3 digits, 1 or 2 backslashes and the surrounding single quotes
//  are all required.
// Returns the converted string.

var
	   i, k: integer;
	   temp: string;
	   c: integer;

begin
	   if (length(s^) > 5) then
	   begin
		      i := 1;
		      k := 0;
		      repeat
		          begin
		              if ((s^[i + 1] = '\') and (s^[i + 2] = '\')) then
			                 k := 1;
		              if (s^[i] = '''') and
			                 (s^[i + 1] = '\') and
			                 (s^[i + k + 1] = '\') and
			                 (s^[i + k + 2] >= '0') and
			                 (s^[i + k + 2] < '8') and
			                 (s^[i + k + 3] >= '0') and
			                 (s^[i + k + 3] < '8') and
			                 (s^[i + k + 4] >= '0') and
			                 (s^[i + k + 4] < '8') and
			                 (s^[i + k + 5] = '''') then
			             begin
				                c := ((StrToIntDef(s^[i + k + 2], 0) * 8) + StrToIntDef(s^[i + k + 3], 0)) * 8 + StrToIntDef(s^[i + k + 4], 0);
				                temp := temp + format('''0x%2.2x''', [c]);
				                i := i + k + 6;
			             end
			             else
			             begin
				                temp := temp + s^[i];
				                inc(i);
			             end;
		          end;
		      until (i > length(s^));
		      OctToHex := temp;
	   end
	   else
		      OctToHex := s^;
end;

//=================================================================

function AnsiBeforeFirst(Sub: string; Target: string): string;
    // Returns the string before the first 'Sub' in 'Target'
begin
    //AnsiBeforeFirst := AnsiLeftStr(Target, AnsiPos(Sub,Target)-1);
    AnsiBeforeFirst := LeftStr(Target, AnsiPos(Sub, Target) - 1);
end;

//=================================================================

function AnsiAfterFirst(Sub: string; Target: string): string;
    // Returns the string after the first 'Sub' in 'Target'
begin
    // AnsiAfterFirst := AnsiRightStr(Target, Length(Target) - AnsiPos(Sub, Target));
    AnsiAfterFirst := RightStr(Target, Length(Target) - AnsiPos(Sub, Target));
end;

//=================================================================

function AnsiAfterLast(Sub: string; Target: string): string;
    // Returns the string after the last 'Sub' in 'Target'
var
    RTarget, RSub, Res: string;

begin
    RTarget := ReverseString(Target);
    RSub := ReverseString(Sub);
    Res := LeftStr(RTarget, AnsiPos(RSub, RTarget) - 1);
    AnsiAfterLast := ReverseString(Res);
end;

//=================================================================

function AnsiFindLast(Src: string; Target: string): integer;
    // Find the index of the last occurrence of Src in Target
var
    RTarget, RSrc: string;

begin
    RTarget := ReverseString(Target);
    RSrc := ReverseString(Src);
    AnsiFindLast := Length(Target) - AnsiPos(RSrc, RTarget);
end;

function AnsiMidStr(const AText: string;
    const AStart, ACount: integer): string;
begin
    Result := MidStr(AText, AStart, ACount);
end;

function AnsiRightStr(const AText: string; ACount: integer): string;
begin
    Result := RightStr(AText, ACount);
end;

function AnsiLeftStr(const AText: string; ACount: integer): string;
begin
    Result := LeftStr(AText, ACount);
end;

//=================================================================

function TGDBDebugger.FindFirstChar(Str: string; c: char): integer;

    //    Finds the first occurrence of 'c' in Str that is
    //    not enclosed in { ... }, [ ... ] or  " ... "
    //    although it WILL find the opening { or [ or " provided it is
    //    not otherwise enclosed.
    //    A well-formed input string is assumed.
    //    Returns the one-based index of 'c', or 0.


var
    pos, p: integer;
    isquoted: boolean;

begin

    isquoted := FALSE;
    FindFirstChar := 0;
    pos := 1;

    while ((not (Str[pos] = c) or isquoted) and (pos <= Length(Str))) do
    begin
		      if ((Str[pos] = '"') and ((pos > 1) and not (Str[pos - 1] = '\'))) then
		// was: if (Str[pos] = '"') then
            isquoted := not isquoted
        else
        if (Str[pos] = '{') then
        begin
            p := FindFirstChar(AnsiMidStr(Str, (pos + 1),
                Length(Str) - pos - 1), '}');
            if (p = 0) then
            begin
                FindFirstChar := 0;
                break;
            end;
            pos := pos + p;
        end
        else
        if (Str[pos] = '[') then
        begin
            p := FindFirstChar(AnsiMidStr(Str, (pos + 1),
                Length(Str) - pos - 1), ']');
            if (p = 0) then
            begin
                FindFirstChar := 0;
                break;
            end;
            pos := pos + p;
        end;

        Inc(pos);
        FindFirstChar := pos;
    end;

    if (pos > Length(Str)) then
        FindFirstChar := 0;

end;

//=================================================================


function TGDBDebugger.ExtractBracketed(Str: PString; start: Pinteger;
    next: PInteger; c: char; inclusive: boolean): string;


    //    Returns the sub-string from the first occurrence of 'c'
    //    (which must be one of '{' '[' '<' '"')
    //    to the matching  '}' ']' '>' '"' character. If inclusive, 'c' and its match
    //    are returned, otherwise they are stripped.
    //    Nesting is allowed.
    //    RETURN VALUES:
    //    start is the index in the original string where the sub-string was found,
    //    and next the index of the character immediately after sub-string.
    //    If not required, these can be NULL pointers.
    //    If the sub-string is not found, an empty string is returned and start & next
    //    both are zero.
    //    If the sub-string is the whole of the input string, a non-empty string is
    //    returned and start & next both are zero.
    //    If the sub-string starts at the beginning of the input string, a non-empty string is
    //    returned and start is zero.
    //    If the sub-string ends at the end of the input string, a non-empty string is
    //    returned and next is zero.


var
    Output: string;
    l1, l2, l3, l4, s, e: integer;
    nestedin: array[0..9] of integer;

begin          // ExtractBracketed
    Output := Str^;
    for e := 9 downto 0 do
        nestedin[e] := 0;
    // we are expecting a closing '"' at this level (arbitrary limit of 256)

    l1 := 0;             // level of nesting of ""
    l2 := 0;             // level of nesting of {}
    l3 := 0;             // level of nesting of []
    l4 := 0;             // level of nesting of <>
    s := -1;             // index of start of our region -1 = not found
    e := 0;              // index of end of our region

    begin

        while (e <= Length(Output)) do
        begin
            if (not (Output[e] = c) and (s = -1)) then
            begin                   // skip over all before our start char
                Inc(e);
                continue;
            end;

            case (Output[e]) of
                '\':
                    if (Output[e + 1] = '"') then
                        // a literal quote - ignore
                    begin
                        e := e + 2;                         // & skip over
                        continue;
                    end;

                '"':
                    if ((nestedin[l1] = 0) and not (s = -1)) then
                        Dec(l1)
                    else
                        Inc(l1);

                '{':
                begin
                    Inc(l2);
                    Inc(nestedin[l1]);
                end;

                '}':
                begin
                    Dec(l2);
                    Dec(nestedin[l1]);
                end;

                '[':
                begin
                    Inc(l3);
                    Inc(nestedin[l1]);
                end;

                ']':
                begin
                    Dec(l3);
                    Dec(nestedin[l1]);
                end;

                '<':
                begin
                    Inc(l4);
                    Inc(nestedin[l1]);
                end;

                '>':
                begin
                    Dec(l4);
                    Dec(nestedin[l1]);
                end;
            end;

            if ((s = -1) and (Output[e] = c)) then
                s := e;
            Inc(e);
            if (not (s = -1) and ((l1 = 0) and (c = '"') or (l2 = 0)
                and (c = '{') or (l3 = 0)
                and (c = '[') or (l4 = 0)
                and (c = '<'))) then
                break;
        end;

		      if ((e > Length(Output)) and (s = -1)) then          // was e = Length(Output)
        begin
            if (not (start = NIL)) then
                start^ := 0;
            if (not (next = NIL)) then
                next^ := 0;
            Output := '';
            ExtractBracketed := Output;
        end;
    end;

    if (not (next = NIL)) then
        if (e > Length(Output)) then
            next^ := 0
        else
            next^ := e;

    if (not (inclusive)) then
    begin
        Inc(s);
        Output := AnsiMidStr(Str^, s, e - s - 1);
    end
    else
        Output := AnsiMidStr(Str^, s, e - s);

    if (not (start = NIL)) then
        start^ := s;

    ExtractBracketed := Output;
end;

//=================================================================


constructor TGDBDebugger.Create;
begin
    inherited;
    OverrideHandler := NIL;
    LastWasCtrl := TRUE;
    Started := FALSE;
end;

//=============================================================

procedure TGDBDebugger.CloseDebugger(Sender: TObject);
begin

	   if Executing then
	   begin

        // Reset breakpoint colors in editor
        MainForm.RemoveActiveBreakpoints;
        MainForm.DebugOutput.Lines.Add('Debugger closed.');

		      fPaused := FALSE;
		      fExecuting := FALSE;

//		DLLs attached to the process are not notified that the process
//  	is terminating. Thus using Reset may result in an unstable system.
//  	The Windows API documentation on TerminateProcess explains all.

		      if (TargetIsRunning) then
// 			Kill the target
			         KillProcess(TargetPID);
// 		Kill the Debugger
		      KillProcess(DebuggerPID);
		      Cleanup;

// First don't let us be called twice. Set the secondary threads to not call
// us when they terminate

		      Reader.OnTerminate := NIL;
		      Reader := NIL;

//    	MainForm.RemoveActiveBreakpoints;

//		Clear the command queue
		      CommandQueue.Clear;
		      CurrentCommand := NIL;
	   end;
end;

//=============================================================

destructor TGDBDebugger.Destroy;
begin
    inherited;
end;

//=============================================================

procedure TGDBDebugger.ExitDebugger;
begin

    QueueCommand(GDBExit, '');

    //		Note we SHOULD NOT pull the plug on the debugger unless it fails
    //      to stop when commanded to exit (manual page 306: Quitting GDB)
    //      It should be safe to stop the reader and close the pipes after
    //      telling GDB to exit, even though it might not have finished.
    //      GDB won't stop if the target is running.
    //      We will never know when GDB has actually stopped, even though it
    //      has reported 'exit', because it still must clean up.
    //      Killing GDB will still not terminate the target. (Neither will
    //      stopping the IDE).
    //      The Windows API documentation on TerminateProcess explains all.


end;

//=============================================================
procedure TGDBDebugger.Cleanup;


begin

	   Reader.Terminate;
    //Close the handles
	   try
		      if (not CloseHandle(g_hChildStd_IN_Wr)) then
			         DisplayError('CloseHandle - ChildStd_IN_Wr');
		      if (not CloseHandle(g_hChildStd_OUT_Rd)) then
			         DisplayError('CloseHandle - ChildStd_OUT_Rd');
		//	See the note above about TerminateProcess
	   except
		      on EExternalException do
            DisplayError('Closing Pipe Handles');
	   end;

end;

//=============================================================


procedure TGDBDebugger.Execute(filename, arguments: string);
var
    Executable: string;
    WorkingDir: string;
    Includes: string;
    I: integer;

begin
    //Reset our variables
    self.FileName := filename;
    fNextBreakpoint := 0;
    IgnoreBreakpoint := FALSE;
    Started := FALSE;
    TargetIsRunning := FALSE;

	   SelectedFrame := 0;
	   SelectedThread := 0;

    //Get the name of the debugger
    if (devCompiler.gdbName <> '') then
        Executable := devCompiler.gdbName
    else
        Executable := DBG_PROGRAM(devCompiler.CompilerType);


    Executable := Executable + ' ' + GDBInterp;

    // Verbose output requested?
    if (not MainForm.VerboseDebug.Checked) then
        Executable := Executable + ' ' + GDBSilent;

    //Add in the include paths

    for I := 0 to IncludeDirs.Count - 1 do
        Includes := Includes + '--directory=' +
            GetShortName(IncludeDirs[I]) + ' ';
    if Includes <> '' then
        Executable := Executable + ' ' + Includes;


    //Add the target executable
    Executable := Executable + ' "' + filename + '"';

    //Launch the process

    if Assigned(MainForm.fProject) then
        WorkingDir := MainForm.fProject.CurrentProfile.ExeOutput;

    Launch(Executable, WorkingDir);

    QueueCommand('-gdb-set', 'new-console on'); // For console applications
    // ??? Will this have any effect - see GDB Documentation: "the debuggee will be started in a new console on next start"
    //     I read this as implying it WILL go into effect because the target is only loaded, not yet started.
    QueueCommand('-gdb-set', 'height 0');
    QueueCommand('-gdb-set', 'breakpoint pending on');
    // Fix for DLL breakpoints
    QueueCommand('-gdb-set args', arguments);

    LoadAllWatches;

end;

//=============================================================
procedure TGDBDebugger.AddtoDisplay(Msg: string);
// Write to the IDE debugger output window

// This is equivalent to the calls in TGDBDebugger.OnOutput:
//   MainForm.DebugOutput.Lines.AddStrings(TempLines);
// around line 2487
// GAR: Change this to suit

begin
    if Assigned(MainForm.DebugOutput) then
        MainForm.DebugOutput.Lines.Add(Msg);
end;

//=============================================================
procedure TGDBDebugger.SendCommand;
// called by QueueCommand( ) initially, then by the parser once the present
//  debugger output is exhausted in order to process the next in the queue.

begin
    //Do we have anything left? Are we paused?
    // SentCommand is reset by the parser
    if Executing and Paused then
        while ((CommandQueue.Count > 0) and (Paused) and (not SentCommand)) do
        begin

            //Initialize stuff
            // Let's assume commands have been queued up

            SentCommand := TRUE;
            CurrentCommand := PCommand(CommandQueue[0])^;

            //Remove the entry from the list
            if not (CurrentCommand is TCommandWithResult) then
                Dispose(CommandQueue[0]);
            CommandQueue.Delete(0);

{
  There should be no problem with writing directly to the Pipe from here:
  All commands should be well within the capabilities of the native OS Pipe
  Buffers (4K Windows, 32K Linux?) so the main thread should not hang while
  the debugger runs.
  If for any reason the debugger fails to read off the end of the pipe, the
  only thing that will happen is the list will build with unpiped commands.

  The pipe buffer and GDB are capable of processing commands sequentially.
  Thus there is no need to wait until the result of the command has been read.
}

            if (MainForm.VerboseDebug.Checked) then
				            AddtoDisplay('Sending ' + CurrentCommand.Command);

            // For proper handling of multi-threaded targets, we need to prefix each relevant
            // command with '--thread' and ‘--frame’  (See GDB Manual: 27.1.1 Context management)
            // with parameters got from ExecResult() or ParseThreads() unless changed by user.
            // CurrentGDBThread is the thread reported by GDB, the user's default choices 
			// are SelectedThread and SelectedFrame (always defaults to 0)

            WriteToPipe(CurrentCommand.Command);

            //Call the callback function if we are provided one
            if Assigned(CurrentCommand.Callback) then
                CurrentCommand.Callback;
        end;
end;

//=============================================================
function TGDBDebugger.WriteGDBContext(thread: integer; frame: integer): string;

//    Returns a string of the form "--thread n --frame n"
//     If thread == 0 or negative, an empty string is returned

begin
    if (thread < 1) then
        WriteGDBContext := ''
    else
        WriteGDBContext := Format(GDBcontext,
            [thread, frame]);
end;

//=============================================================

procedure TGDBDebugger.Attach(pid: integer);
var
    Executable: string;
    Includes: string;
    I: integer;
begin
    //Reset our variables
    self.FileName := filename;
    fNextBreakpoint := 0;
    IgnoreBreakpoint := FALSE;

    //Get the name of the debugger
    if (devCompiler.gdbName <> '') then
        Executable := devCompiler.gdbName
    else
        Executable := DBG_PROGRAM(devCompiler.CompilerType);
    Executable := Executable + ' --annotate=2 --silent';

    //Add in the include paths
    for I := 0 to IncludeDirs.Count - 1 do
        Includes := Includes + '--directory=' +
            GetShortName(IncludeDirs[I]) + ' ';
    if Includes <> '' then
        Executable := Executable + ' ' + Includes;

    //Launch the process
    Launch(Executable, '');

    //Tell GDB which file we want to debug
    QueueCommand('-gdb-set', 'height 0');
    QueueCommand('-target-attach', inttostr(pid));
end;

function RegexEscape(str: string): string;
begin
    Assert(FALSE, 'RegexEscape: I am not redundant');
end;

// ===============================================

procedure TGDBDebugger.OnOutput(Output: string);
begin
    Assert(FALSE, 'TGDBDebugger.OnOutput: I am not redundant');
end;

//=================================================================

procedure TGDBDebugger.OnSignal(Output: TStringList);
begin
    Assert(FALSE, 'TGDBDebugger.OnSignal: I am not redundant');
end;

//=================================================================

procedure TGDBDebugger.OnLocals(Output: TStringList);
begin
    Assert(FALSE, 'TGDBDebugger.OnLocals: I am not redundant');
end;
//=================================================================

procedure TGDBDebugger.OnThreads(Output: TStringList);
begin
    Assert(FALSE, 'TGDBDebugger.OnThreads: I am not redundant');
end;

//=================================================================

procedure TGDBDebugger.GetRegisters;
begin
    Assert(FALSE, 'TGDBDebugger.GetRegisters: I am not redundant');
end;

//=================================================================

procedure TGDBDebugger.OnRegisters(Output: TStringList);
begin
    Assert(FALSE, 'TGDBDebugger.OnRegisters: I am not redundant');
end;

//=================================================================

procedure TGDBDebugger.OnSourceMoreRecent;
begin
    if (MessageDlg(Lang[ID_MSG_SOURCEMORERECENT], mtConfirmation,
        [mbYes, mbNo], 0) = mrYes) then
    begin
        CloseDebugger(NIL);
        MainForm.actCompileExecute(NIL);
    end;
end;

//=================================================================

procedure TGDBDebugger.AddIncludeDir(s: string);
begin
    IncludeDirs.Add(s);
end;

//=================================================================

procedure TGDBDebugger.ClearIncludeDirs;
begin
    IncludeDirs.Clear;
end;

//=================================================================

procedure TGDBDebugger.AddBreakpoint(breakpoint: TBreakpoint);
var
    aBreakpoint: PBreakpoint;
begin
    if (not Paused) and Executing then
    begin
        MessageDlg('Cannot add a breakpoint while the debugger is executing.',
            mtError, [mbOK], MainForm.Handle);
        Exit;
    end;

    New(aBreakpoint);
    aBreakpoint^ := breakpoint;
    Breakpoints.Add(aBreakpoint);
    RefreshBreakpoint(aBreakpoint^);
end;

//=================================================================

procedure TGDBDebugger.RemoveBreakpoint(breakpoint: TBreakpoint);
var
    I: integer;
begin
    if (not Paused) and Executing then
    begin
        MessageDlg('Cannot remove a breakpoint while the debugger is executing.', mtError, [mbOK], MainForm.Handle);
        Exit;
    end;

    for i := 0 to Breakpoints.Count - 1 do
        if (PBreakPoint(Breakpoints.Items[i])^.line = breakpoint.Line) and
            (PBreakPoint(Breakpoints.Items[i])^.editor =
            breakpoint.Editor) then
        begin
            if Executing then
                QueueCommand(GDBbrkdel,
                    IntToStr(PBreakpoint(Breakpoints.Items[i])^.BPNumber));

            Dispose(Breakpoints.Items[i]);
            Breakpoints.Delete(i);
            Break;
        end;
end;

//=================================================================

procedure TGDBDebugger.RefreshBreakpoint(var breakpoint: TBreakpoint);
begin
    if Executing then
    begin
        Inc(fNextBreakpoint);
        breakpoint.Index := fNextBreakpoint;
        breakpoint.Valid := TRUE;
        QueueCommand(GDBbrkins, Format('"%s:%d"',
            [breakpoint.Filename, breakpoint.Line]));
    end;
end;

//=================================================================

procedure TGDBDebugger.RefreshContext(refresh: ContextDataSet);
var
  //  I: Integer;
  //  Node: TListItem;
    Command: TCommand;
begin
    if not Executing then
        Exit;

    //First send commands for stack tracing, locals and threads
    if cdCallStack in refresh then
    begin
        Command := TCommand.Create;
        Command.Command := format('%s %s',
			         [GDBlistframes, WriteGDBContext(SelectedThread, SelectedFrame)]);
        Command.OnResult := OnCallStack;
        QueueCommand(Command);
    end;
    if cdLocals in refresh then
    begin
        Command := TCommand.Create;
        Command.Command := format('%s %s 1',
			         [GDBlistlocals, WriteGDBContext(SelectedThread, SelectedFrame)]);
        Command.OnResult := OnLocals;
        QueueCommand(Command);
    end;
    if cdThreads in refresh then
    begin
        Command := TCommand.Create;
        Command.Command := GDBthreadinfo;
        Command.OnResult := OnThreads;
        QueueCommand(Command);
    end;

    //Then update the watches
    if (cdWatches in refresh) and Assigned(MainForm.WatchTree) then
    begin
		      ReLoadWatches;
		      GetWatchedValues;
    end;


end;

//=================================================================

procedure TGDBDebugger.OnRefreshContext(Output: TStringList);
begin

end;

//=================================================================

procedure TGDBDebugger.OnCallStack(Output: TStringList);
var
    I: integer;
    CallStack: TList;
    RegExp: TRegExpr;
    StackFrame: PStackFrame;
begin
    StackFrame := NIL;
    CallStack := TList.Create;
    RegExp := TRegExpr.Create;

    I := 0;
    while I < Output.Count do
    begin
        if Pos(GDBframebegin, Output[I]) = 1 then
        begin
            //Stack frame with source information
            New(StackFrame);
            CallStack.Add(StackFrame);
        end
        else
        if Output[I] = GDBframefnname then
        begin
            Inc(I);
            StackFrame^.FuncName := Output[I];
        end
        else
        if Output[I] = GDBframefnarg then
        begin
            Inc(I);

            //Make sure it's valid
            if Output[I] <> ' (' then
            begin
                Inc(I);
                Continue;
            end
            else
            begin Inc(I); end;

            while (I < Output.Count - 6) do
            begin
                if Output[I] = GDBarg then
                begin
                    if StackFrame^.Args <> '' then
                        StackFrame^.Args := StackFrame^.Args + ', ';
                    StackFrame^.Args :=
                        StackFrame^.Args + Output[I + 1] + ' = ' +
                        Output[I + 5];
                end;
                Inc(I, 6);

                //Do we stop?
                if Trim(Output[I + 1]) <> ',' then
                    Break
                else
                    Inc(I, 2);
            end;
        end
        else
        if Output[I] = GDBframesrcfile then
        begin
            Inc(I);
            StackFrame^.Filename := ExtractFileName(Output[I]);
        end
        else
        if Output[I] = GDBframesrcline then
        begin
            Inc(I);
            StackFrame^.Line := StrToIntDef(Output[I], 0);
        end;
        Inc(I);
    end;

    //Now that we have the entire callstack loaded into our list, call the function
    //that wants it
    if Assigned(TDebugger(Self).OnCallStack) then
        TDebugger(Self).OnCallStack(CallStack);

    //Do we show the new execution point?
    if JumpToCurrentLine then
    begin
        JumpToCurrentLine := FALSE;
        MainForm.GotoTopOfStackTrace;
    end;

    //Clean up
    RegExp.Free;
    CallStack.Free;
end;

//=================================================================

procedure TGDBDebugger.Disassemble(func: string);
begin
    Assert(FALSE, 'TGDBDebugger.Disassemble: I am not redundant');
end;

//=================================================================

procedure TGDBDebugger.OnDisassemble(Output: TStringList);
begin
    Assert(FALSE, 'TGDBDebugger.OnDisassemble: I am not redundant');
end;

//=================================================================


procedure TGDBDebugger.SetAssemblySyntax(syntax: AssemblySyntax);
begin
    case syntax of
        asIntel:
            QueueCommand(GDBflavour, 'intel');
        asATnT:
            QueueCommand(GDBflavour, 'att');
    end;
end;

//=================================================================

function TGDBDebugger.GetVariableHint(name: string): string;
var
    Command: TCommand;
begin
    if (not Executing) or (not Paused) then
        Exit;

    Command := TCommand.Create;
    Command.OnResult := OnVariableHint;
    //Command.Command := 'print ' + name;
    Command.Command := format('%d%s%s %s', [TOOLTOKEN, GDBdataeval,
		      WriteGDBContext(SelectedThread, SelectedFrame), name]);


    //Send the command;
    QueueCommand(Command);
end;

//=================================================================

procedure TGDBDebugger.OnVariableHint(Output: TStringList);
begin
    //Call the callback
    if Assigned(TDebugger(Self).OnVariableHint) then
        TDebugger(Self).OnVariableHint(Output[0]);
end;

procedure TGDBDebugger.Go;
var
    Command: TCommand;
begin
    Command := TCommand.Create;
    if not Started then
        Command.Command := GDBrun
    else
        Command.Command := GDBcontinue;
    Command.Callback := OnGo;
    QueueCommand(Command);
end;

//=================================================================

procedure TGDBDebugger.OnGo;
begin
    inherited;
    Started := TRUE;
end;

//=================================================================

procedure TGDBDebugger.Launch(commandline, startupdir: string);
var
    saAttr: TSecurityAttributes;

begin

    saAttr.nLength := SizeOf(SECURITY_ATTRIBUTES);
    saAttr.bInheritHandle := TRUE;
    saAttr.lpSecurityDescriptor := NIL;

    // Create a pipe for the child process's STDOUT.

    if (not CreatePipe(g_hChildStd_OUT_Rd, g_hChildStd_OUT_Wr,
        @saAttr, 0)) then
        DisplayError('Std_OUT CreatePipe');

    // Ensure the read handle to the pipe for STDOUT is not inherited.

    if (not SetHandleInformation(g_hChildStd_OUT_Rd,
        HANDLE_FLAG_INHERIT, 0)) then
        DisplayError('Std_OUT SetHandleInformation');

    // Create a pipe for the child process's STDIN.

    if (not CreatePipe(g_hChildStd_IN_Rd, g_hChildStd_IN_Wr, @saAttr, 0)) then
        DisplayError('Std_IN CreatePipe');

    // Ensure the write handle to the pipe for STDIN is not inherited.

    if (not SetHandleInformation(g_hChildStd_IN_Wr,
        HANDLE_FLAG_INHERIT, 0)) then
        DisplayError('Std_IN SetHandleInformation');

    //  Pipes created

    //-----------------------------------------------------------------

    // Start the Reader thread

    // May want to pass the TDebugger address to ReadThread

    Reader := ReadThread.Create(TRUE);
    Reader.ReadChildStdOut := g_hChildStd_OUT_Rd;
    Reader.FreeOnTerminate := TRUE;
    Reader.Resume;

    //---------------------------------------------------------

    // Create a child process that uses the previously created pipes for STDIN and STDOUT.

    CreateChildProcess(commandline, g_hChildStd_IN_Rd,
        g_hChildStd_OUT_Wr, g_hChildStd_OUT_Wr);

    // Reader Thread created & running

    if (not CloseHandle(g_hChildStd_OUT_Wr)) then
        DisplayError('CloseHandle Std_OUT');
    if (not CloseHandle(g_hChildStd_IN_Rd)) then
        DisplayError('CloseHandle Std_IN');

    Reader.Resume;

end;

//============================================

procedure TGDBDebugger.WriteToPipe(Buffer: string);

var
    BytesWritten: DWORD;

begin
    BytesWritten := 0;

    Buffer := Buffer + NL;               // GDB requires a newline

    // Send it to the pipe
    WriteFile(g_hChildStd_IN_Wr, pchar(Buffer)^, Length(Buffer),
        BytesWritten, NIL);

end;

//=============================================================

function TGDBDebugger.Result(buf: pchar; bsize: PLongInt): pchar;
{
/*
   Part of Second Level Parse of Output.

   Parse Result Record.

   Looks from beginning up to [0x0d][0x0a] pair.
   MODIFIES the input buffer.
   Returns pointer to start of unprocessed buffer, else if nothing left: NULL
   bsize is updated to reflect new size of unprocessed part.
   Note: embedded cr or cr-lf are replaced by nulls.
 */
}

var
    OutputBuffer: string;
    msg: string;
    Mainmsg, AllReason, ThreadID: string;
    thread: integer;

begin
	   if (MainForm.VerboseDebug.Checked) then
	   begin
		      AddtoDisplay('Parsing ^');
	   end;

    Result := NIL;
    msg := breakOut(@buf, bsize);
    msg := AnsiMidStr(msg, 2, Maxint - 1);

    if (MainForm.VerboseDebug.Checked) then
    begin
        OutputBuffer := msg;
      // gui_critSect.Enter();
        AddtoDisplay(OutputBuffer);
      // gui_critSect.Leave();
    end;

    if (not (msg = '')) then
    begin
        if (AnsiStartsStr(GDBerror, msg)) then
        begin
            Mainmsg := StringReplace(msg, 'msg="', '', []);
            Mainmsg := StringReplace(Mainmsg, '\', '', [rfReplaceAll]);

            if ((Token >= WATCHTOKENBASE) and (Token < MODVARTOKEN)) then
                ParseWatchpointError(Mainmsg)
            else
            if (Mainmsg = GDBassignerror) then
            begin
                DisplayError('This Variable is not editable');
            end
            else
                DisplayError('GDB Error: ' + Mainmsg);
        end

        else
        if (AnsiStartsStr(GDBrunning, msg)) then
        begin
          // get rest into , &AllReason))
            AllReason := AnsiRightStr(msg, (Length(msg) - Length(GDBrunning)));
            TargetIsRunning := TRUE;
          // gui_critSect.Enter();
          //MainForm.SetRunStatus(true);
          // gui_critSect.Leave();

            if (ParseConst(@AllReason, @GDBthreadid, PString(@threadID))) then
            begin
                if (threadID = GDBall) then
                begin
                    OutputBuffer := 'Running all threads';
                end
                else
                begin
                    thread := StrToIntDef(threadID, 0);
			                 CurrentGDBThread := thread;
                    SelectedThread := thread;
                    SelectedFrame := 0;
                    OutputBuffer := Format('Running thread %d', [thread]);
                    AddtoDisplay(OutputBuffer);
                end;
            end;
        end

        else
        if (AnsiStartsStr(GDBExitmsg, msg)) then
        begin
            AddtoDisplay('GDB is exiting');
            Cleanup;
        end

        else
        if (AnsiStartsStr(GDBdone + GDBbkpt, msg)) then
        begin
            ParseBreakpoint(msg, NIL);
        end

        else
        if (AnsiStartsStr(GDBdone + GDBbkpttable, msg)) then
        begin
            ParseBreakpointTable(msg);
        end

        else
        if (AnsiStartsStr(GDBdone + GDBstack, msg)) then
        begin
            ParseStack(msg);
        end

        else
        if (AnsiStartsStr(GDBdone + GDBlocalsq, msg)) then
        begin
            OutputBuffer := ExtractLocals(@msg);  // Parses & Reassembles Result
            if (MainForm.VerboseDebug.Checked) then
				            AddtoDisplay(OutputBuffer);
        end

        else
        if (AnsiStartsStr(GDBdone + GDBthreads, msg)) then
        begin
            ParseThreads(msg);
        end

        else
        if (AnsiStartsStr(GDBdone + GDBwpt, msg)) then
        begin
            ParseWatchpoint(msg);
        end

        else
        if (AnsiStartsStr(GDBdone + GDBwpta, msg)) then
        begin
            ParseWatchpoint(msg);
        end

        else
        if (AnsiStartsStr(GDBdone + GDBwptr, msg)) then
        begin
            ParseWatchpoint(msg);
        end

        else
        if (AnsiStartsStr(GDBdone + GDBregnames, msg)) then
        begin
            ParseRegisterNames(msg);
        end

        else
        if (AnsiStartsStr(GDBdone + GDBmemq, msg)) then
        begin
            ParseCPUMemory(msg);
        end

        else
        if (AnsiStartsStr(GDBdone + GDBasminst, msg)) then
        begin
            ParseCPUDisassem(msg);
        end

        else
        if (AnsiStartsStr(GDBdone + GDBregvalues, msg)) then
        begin
            ParseRegisterValues(msg);
        end;

        if ((AnsiStartsStr(GDBdone + GDBnameq, msg))
            and not (Token = MODVARTOKEN)) then  // It's not from Modify Variable
        begin
            ParseVObjCreate(msg);           // if it was a VObj create...
        end;

        if (AnsiStartsStr(GDBdone + GDBvalue, msg)) then
        begin
            if ((Token >= WATCHTOKENBASE) and (Token < MODVARTOKEN)) then
                FillWatchValue(msg)         // it came from a request from GetWatchedValues
            else
            if ((Token = TOOLTOKEN)) then
                FillTooltipValue(msg)       // it came from a request from Tooltip (GetVariableHint)
            else
                ParseVObjAssign(msg);       // else it was a VObj assign
//                                            or another -data-evaluate-expression...

        end;

        Result := buf;

    end;
end;

//=================================================================

function TGDBDebugger.ExecResult(buf: pchar; bsize: PLongInt): pchar;
{
   Part of Second Level Parse of Output.

   Looks from beginning up to [0x0d][0x0a] pair.
   Returns pointer to start of unprocessed buffer, else if nothing left: NULL
   bsize is updated to reflect new size of unprocessed part.
   Note: embedded cr-lf are replaced by nulls.
}

var
    OutputBuffer: string;
    msg: string;
    AllReason: string;
    Reason: string;
    Errmsg: string;

    threadID: string;
    thread: longint;

begin

	   if (MainForm.VerboseDebug.Checked) then
	   begin
		      AddtoDisplay('Parsing *');
	   end;

    ExecResult := NIL;
    msg := breakOut(@buf, bsize);
    msg := AnsiMidStr(msg, 2, Maxint - 1);


    if (MainForm.VerboseDebug.Checked) then
    begin
        OutputBuffer := msg;
        // gui_critSect.Enter();
        AddtoDisplay(OutputBuffer);
        // gui_critSect.Leave();
    end;


    if (not (msg = '')) then
    begin
        if (AnsiStartsStr(GDBrunning, msg)) then
        begin
            // get rest into , &AllReason))
            AllReason := AnsiRightStr(msg, (Length(msg) - Length(GDBrunning)));
            TargetIsRunning := TRUE;

            if (ParseConst(@AllReason, @GDBthreadid, PString(@threadID))) then
                if (threadID = GDBall) then
                    OutputBuffer :=
                        'Running all threads'
                else
                begin
                    thread := StrToIntDef(threadID, 0);
                    OutputBuffer := Format('Running thread %d', [thread]);
					               CurrentGDBThread := thread;
					               SelectedThread := thread;
					               SelectedFrame := 0;
                    AddtoDisplay(OutputBuffer);
                end;
        end
        else
        if (AnsiStartsStr(GDBstopped, msg)) then
        begin
			         if (ParseConst(@msg, @GDBthreadid, PInteger(@thread))) then
			         begin
				            CurrentGDBThread := thread;
				            SelectedThread := thread;
				            SelectedFrame := 0;
			         end;

            if (TargetIsRunning) then
                RefreshContext;

            TargetIsRunning := FALSE;

            if (ParseConst(@msg, @GDBreason, PString(@Reason))) then
                if (Reason = GDBExitnormal) then
                begin
                    // gui_critSect.Enter();
                    AddtoDisplay('Stopped - Exited normally');
                    // gui_critSect.Leave();
                    Started := FALSE;
					               ExitDebugger;

                    CloseDebugger(NIL);
                end
                else
                if (Reason = GDBbkpthit) then
                begin
                    if (MainForm.VerboseDebug.Checked) then
					               begin
						// gui_critSect.Enter();
						                  AddtoDisplay('Stopped - breakpoint-hit');
						// gui_critSect.Leave();
                    end;
					               BreakpointHit(@msg);
                end
                else
                if (Reason = GDBwptrig) then
                begin
                    if (MainForm.VerboseDebug.Checked) then
					               begin
						// gui_critSect.Enter();
						                  AddtoDisplay('Stopped - watchpoint-trigger');
						// gui_critSect.Leave();
					               end;
                    WatchpointHit(@msg);
                end
                else
                if (Reason = GDBwptrigr) then
                begin
                    if (MainForm.VerboseDebug.Checked) then
					               begin
						// gui_critSect.Enter();
						                  AddtoDisplay('Stopped - read-watchpoint-trigger');
						// gui_critSect.Leave();
					               end;
                    WatchpointHit(@msg);
                end
                else
                if (Reason = GDBwptriga) then
                begin
                    if (MainForm.VerboseDebug.Checked) then
					               begin
						// gui_critSect.Enter();
						                  AddtoDisplay('Stopped - access-watchpoint-trigger');
						// gui_critSect.Leave();
					               end;
                    WatchpointHit(@msg);
                end
                else
                if (Reason = GDBendstep) then
                begin
                    if (MainForm.VerboseDebug.Checked) then
					               begin
						// gui_critSect.Enter();
						                  AddtoDisplay('Stopped - end-stepping-range');
						// gui_critSect.Leave();
					               end;
                    StepHit(@msg);
                end
				            else
                if (Reason = GDBwpscope) then
				            begin
					// gui_critSect.Enter();
					               AddtoDisplay('Stopped - watchpoint-scope');
					// gui_critSect.Leave();
					               WptScope(@msg);
				            end
                else
                if (Reason = GDBsigrcv) then
                begin
                    AddtoDisplay('Stopped - signal received');
                    SigRecv(@msg);
                end
                else
                begin
                    Errmsg := AnsiReplaceStr(Errmsg, 'msg="', '');
                    Errmsg := AnsiReplaceStr(Errmsg, '\"', '');
                    DisplayError('GDB Error:' + Errmsg);
                end;
        end;
        ExecResult := buf;
    end;
end;

//===============================================

procedure TGDBDebugger.FirstParse;
var

    BufMem: pchar;          // Keep a copy of the originally allocated memory
    //  so that we can free the memory
begin
    BufMem := buf;           // because pointer 'buf' gets moved!

    while ((bytesInBuffer > 0) and not (buf = NIL)) do
	       // && some arbitrary counter to prevent an infinite loop in case
	       // a programming error fails to clear the buffer?
        if ((buf^ >= '0') and (buf^ <= '9')) then
		          // a token
        begin
            buf := GetToken(buf, @bytesInBuffer, @Token);
            if (MainForm.VerboseDebug.Checked) then
                AddtoDisplay('Token ' + IntToStr(Token));
        end
        else
        if (buf^ = '~') then
		          // console stream
		          // Not of interest: display it

            buf := SendToDisplay(buf, @bytesInBuffer, TRUE)

        else
        if (buf^ = '=') then
		          // notify async
			         buf := Notify(buf, @bytesInBuffer, MainForm.VerboseDebug.Checked)
        else
        if ((buf^ = '@') or (buf^ = '&')) then
		          // target output ||  log stream
		          // Not of interest: display it

            buf := SendToDisplay(buf, @bytesInBuffer, MainForm.VerboseDebug.Checked)

        else
        if (buf^ = '^') then
		          // A result or error
        begin
			         // gui_critSect.Enter();
            if (MainForm.VerboseDebug.Checked) then
                AddtoDisplay('Result or Error:');
			         // gui_critSect.Leave();
            buf := Result(buf, @bytesInBuffer);
        end
        else
        if (buf^ = '*') then
		          // executing async
        begin
			         // gui_critSect.Enter();
            if (MainForm.VerboseDebug.Checked) then
                AddtoDisplay('Executing Async:');
			         // gui_critSect.Leave();
            buf := ExecResult(buf, @bytesInBuffer);
        end
        else
        if (buf^ = '+') then
		          // status async
        begin
            if (MainForm.VerboseDebug.Checked) then
                AddtoDisplay('Status Output:');
            buf := SendToDisplay(buf, @bytesInBuffer, MainForm.VerboseDebug.Checked);
        end
        else
        if (buf^ = '(') then
		          // might be GDB prompt - cannot really be anything else!
        begin


            if (MainForm.VerboseDebug.Checked) then
			         begin
			    //gui_critSect.Enter(); 
				            AddtoDisplay('GDB Ready');
			    //gui_critSect.Leave();
			         end;
            buf := SendToDisplay(buf, @bytesInBuffer, MainForm.VerboseDebug.Checked);
        end
        else
		          // Don't know, what is left?
        begin
			// gui_critSect.Enter();
            AddtoDisplay('Cannot decide about:');
			// gui_critSect.Leave();
            buf := SendToDisplay(buf, @bytesInBuffer, MainForm.VerboseDebug.Checked);
        end;

    FreeMem(BufMem);
    // The reader will only get the next lot from
    // the pipe buffer when it sees this:
    buf := NIL;
	   SentCommand := FALSE;    // Requests next command to be sent from queue
    fPaused := TRUE;
    SendCommand;             //  (these are only needed to maintain sync. between
    //  the outgoing and incoming data streams).

end;

//=============================================================

function TGDBDebugger.Notify(buf: pchar; bsize: PLongInt; verbose: boolean): pchar;
{
/*
   Part of Second Level Parse of Output.

   Parse Notify Record.

   Looks from beginning up to [0x0d][0x0a] pair.
   MODIFIES the input buffer.
   Returns pointer to start of unprocessed buffer, else if nothing left: NULL
   bsize is updated to reflect new size of unprocessed part.
   Note: embedded cr or cr-lf are replaced by nulls.
 */
}

var
    OutputBuffer: string;
    msg: string;

begin

    if (verbose) then
    begin
	// gui_critSect.Enter();
	       AddtoDisplay('Parsing =');
	// gui_critSect.Leave();
    end;

    Result := NIL;
    msg := breakOut(@buf, bsize);
    msg := AnsiMidStr(msg, 2, Maxint - 1);

    if (verbose) then
    begin
		      OutputBuffer := msg;
		// gui_critSect.Enter();
		      AddtoDisplay(OutputBuffer);
		// gui_critSect.Leave();
    end;

    if (not (msg = '')) then
	   begin
		      if (AnsiStartsStr(GDBthreadgcr, msg)) then
		// Only extract Target PID for now - can add more if required
			         ParseConst(@msg, @GDBidq, PInteger(@TargetPID));

		      Result := buf;

	   end;
end;

//=============================================================

function TGDBDebugger.breakOut(Next: PPChar; bsize: PLongInt): string;
{
/*
  Supports the Second Level Parse.
  Takes the buffer and returns a String up to but excluding the first
  CR or CR-LF pair.
  N.B. an embedded newline appears as the string '\n', NOT as #13#10
  MODIFIES the input buffer (replaces CR and LF with Null(s)).
  Parameters:
    Next: Pointer to pointer to the buffer. On return this points to
      the first char following the first CR or CR-LF pair, else NULL
    bsize: a pointer to the buffer size. On return this size has been
      modified to reflect the size of the unprocessed buffer remaining.
*/
}
var
    s, c: pchar;

begin
    breakOut := '';
    s := Next^;
    c := Next^;

    while (not (c^ = CR) and (c < (Next^ + bsize^))) do
        Inc(c);
    c^ := #0;
    Inc(c);
    if (c^ = LF) then
    begin
        c^ := #0;
        Inc(c);
    end;
    bsize^ := bsize^ - (c - s);
    if (bsize^ <= 0) then                         // nothing remains
        Next^ := NIL
    else
        Next^ := c;
    breakOut := s;                                // copies NULL-terminated part


end;

//=============================================================

function TGDBDebugger.GetToken(buf: pchar; bsize: PLongInt;
    Token: PInteger): pchar;
var
   // OutputBuffer: String;
    c, s: pchar;
    sToken: string;

begin
{
   Part of Second Level Parse of Output.

   Looks from beginning up to first non-digit.
   Returns pointer to start of unprocessed buffer, else if nothing left: NULL
   bsize is updated to reflect new size of unprocessed part.
}

    if (MainForm.VerboseDebug.Checked) then
    begin
    // gui_critSect.Enter();
	       AddtoDisplay('Parsing Token');
	// gui_critSect.Leave();
    end;

    c := buf;
    s := buf;

    while ((c^ >= '0') and (c^ <= '9') and (c < (buf + bsize^))) do
    begin
        sToken := sToken + c^;
        Inc(c);
    end;

    if (c = s) then
    begin
        Token^ := 0;                  // We should never get here
        GetToken := c;                // return c;
    end
    else
    begin
        try
            Token^ := StrToIntDef(sToken, 0);
        except
            Token^ := 0;
        end;

        bsize^ := bsize^ - (c - s);
        if (bsize^ = 0) then                          // nothing remains
            GetToken := NIL
        else
            GetToken := c;
    end;
end;

//=================================================================

function TGDBDebugger.SendToDisplay(buf: pchar; bsize: PLongInt;
    verbose: boolean): pchar;
var
    OutputBuffer: string;
    msg: string;

begin
{
/*
   Part of Second Level Parse of Output.

   Sends from beginning up to [0x0d][0x0a] pair to display.
   Returns pointer to start of unprocessed buffer, else if nothing left: NULL
   bsize is updated to reflect new size of unprocessed part.
   Note: embedded cr or cr-lf are replaced by nulls.
 */
}

    if (verbose) then
    begin
    // gui_critSect.Enter();
	       AddtoDisplay('Output to Display...');
	// gui_critSect.Leave();
    end;

    if ((buf = NIL) or (bsize^ = 0)) then
        SendToDisplay := NIL
    else
    begin
        msg := breakOut(@buf, bsize);
        if (not (AnsiLeftStr(msg, 5) = GDBPrompt)) then
            // Special case exception: "(gdb)"
            msg := AnsiMidStr(msg, 2, Maxint - 1);

        if (verbose) then
        begin
            OutputBuffer := msg;
            // gui_critSect.Enter();
            AddtoDisplay(OutputBuffer);
            // gui_critSect.Leave();
        end;


        if (bsize^ = 0) then  // nothing remains
            SendToDisplay := NIL
        else
            SendToDisplay := buf;
    end;
end;

//===================================================

procedure TGDBDebugger.Next;
var
    Command: TCommand;
begin
    Command := TCommand.Create;
    Command.Command := GDBnext;
    Command.Callback := OnTrace;
    QueueCommand(Command);
end;

//=================================================================

procedure TGDBDebugger.Step;
var
    Command: TCommand;
begin
    Command := TCommand.Create;
    Command.Command := GDBstep;
    Command.Callback := OnTrace;
    QueueCommand(Command);
end;

//=================================================================

procedure TGDBDebugger.Finish;
var
    Command: TCommand;
begin
    Command := TCommand.Create;
    Command.Command := GDBfinish;
		//was Command.Command := devData.DebugCommand;
    Command.Callback := OnTrace;
    QueueCommand(Command);

end;

//=================================================================

procedure TGDBDebugger.OnTrace;
begin
    JumpToCurrentLine := TRUE;
    fPaused := FALSE;
    fBusy := FALSE;
end;

//=================================================================

procedure TGDBDebugger.Pause;
begin
    //Do nothing. GDB does not support break-ins.
end;

//=================================================================

procedure TGDBDebugger.SetThread(thread: integer);
begin
    // QueueCommand('-thread-select ', IntToStr(thread));
	   SelectedThread := thread;
    RefreshContext;
end;

//=================================================================

procedure TGDBDebugger.SetFrame(frame: integer);
begin
    // QueueCommand('-stack-select-frame ', IntToStr(frame));
	   SelectedFrame := frame;
    RefreshContext([cdLocals, cdWatches]);
end;


//==================================================================
procedure TGDBDebugger.SigRecv(Msg: PString);
// Parses out Signal details

var
    Temp: string;
    Thread, Line: integer;
    SigName, SigMeaning, Func, SrcFile, frame, Output: string;
  // Ret: Boolean;

begin

    Temp := Msg^;

  //Ret := false;
    frame := ExtractNamed(@Temp, @GDBframe, 1);
  {Ret := }ParseConst(Msg, @GDBsigname, PString(@SigName));
  {Ret := }ParseConst(Msg, @GDBsigmean, PString(@SigMeaning));
  {Ret := }ParseConst(Msg, @GDBthreadid, PInteger(@Thread));
  {Ret := }ParseConst(@frame, @GDBfile, PString(@SrcFile));
  {Ret := }ParseConst(@frame, @GDBfunc, PString(@Func));
  {Ret := }ParseConst(@frame, @GDBline, PInteger(@Line));

    CurrentGDBThread := Thread;
    SelectedThread := Thread;
    SelectedFrame := 0;
    Output := Format('Thread %d stopped in %s at line %d in %s with %s',
        [Thread, Func, Line, SrcFile, SigMeaning]);

  // gui_critSect.Enter();
    AddtoDisplay(Output);
  // gui_critSect.Leave();

    if (SigName = GDBsigsegv) then
        OnAccessViolation;
  // else any other signal?

end;

// ----------------------------------------

procedure TGDBDebugger.FillBreakpointNumber(SrcFile: PString; Line: integer; Num: integer);
{

   Part of Third Level Parse of Output.
   Fills Breakpoint table with GDB's breakpoint number
}
var
    I: integer;
begin

    for I := 0 to Breakpoints.Count - 1 do
        if (PBreakpoint(Breakpoints[I])^.Filename = SrcFile^) and
            (PBreakpoint(Breakpoints[I])^.Line = Line) then
        begin
            PBreakpoint(Breakpoints[I])^.BPNumber := Num;
            Break;
        end;
end;

//------------------------------------------------------------------------------
// TCDBDebugger
//------------------------------------------------------------------------------
constructor TCDBDebugger.Create;
begin
    inherited;
end;

destructor TCDBDebugger.Destroy;
begin
    inherited;
end;

procedure TCDBDebugger.Execute(filename, arguments: string);
const
    InputPrompt = '^([0-9]+):([0-9]+)>';
var
    Executable: string;
    WorkingDir: string;
    Srcpath: string;
    I: integer;
begin
    //Heck about the breakpoint thats coming.
    IgnoreBreakpoint := TRUE;
    self.FileName := filename;

    //Get the name of the debugger
    if (devCompiler.gdbName <> '') then
        Executable := devCompiler.gdbName
    else
        Executable := DBG_PROGRAM(devCompiler.CompilerType);

    //Create the command line
    {if MainForm.fProject.CurrentProfile.compilerType = ID_COMPILER_VC2008 then
        Executable := Format('%s -lines -2 -G -n -s -y "%s" "%s" %s', [Executable, ExtractFilePath(filename) +
    ';SRV*' + IncludeTrailingPathDelimiter(ExtractFilePath(devDirs.Exec)) +
    'Symbols*http://msdl.microsoft.com/download/symbols', filename, arguments]);
    else}
    Executable := Format('%s -lines -2 -G -n -s -y "%s" "%s" %s',
        [Executable, ExtractFilePath(filename) +
        ';SRV*' + IncludeTrailingPathDelimiter(ExtractFilePath(devDirs.Exec)) +
        'Symbols*http://msdl.microsoft.com/download/symbols',
        filename, arguments]);

    //Executable := Format('%s -lines -2 -G -n -s -y "%s" "%s" %s', [Executable, IncludeTrailingPathDelimiter(ExtractFilePath(filename)) +
    //  ';SRV*' + devDirs.Exec +
    //  'Symbols*http://msdl.microsoft.com/download/symbols', filename, arguments]);

    //Run the thing!
    if Assigned(MainForm.fProject) then
        WorkingDir := MainForm.fProject.CurrentProfile.ExeOutput;


    Launch(Executable, WorkingDir);

    //Tell the wait function that another valid output terminator is the 0:0000 prompt
    //Wait.OutputTerminators.Add(InputPrompt);

    //Send the source mode setting (enable all except ONLY source)
    QueueCommand('l+t; l+l; l+s', '');

    //Set all the paths
    Srcpath := ExtractFilePath(Filename) + ';';
    for I := 0 to IncludeDirs.Count - 1 do
        Srcpath := Srcpath + IncludeDirs[I] + ';';
    QueueCommand('.srcpath+', Srcpath);
    QueueCommand('.exepath+', ExtractFilePath(Filename));
end;

procedure TCDBDebugger.Attach(pid: integer);
const
    InputPrompt = '^([0-9]+):([0-9]+)>';
var
    Executable: string;
    Srcpath: string;
    I: integer;
begin
    //Heck about the breakpoint thats coming.
    IgnoreBreakpoint := TRUE;
    self.FileName := filename;

    //Get the name of the debugger
    if (devCompiler.gdbName <> '') then
        Executable := devCompiler.gdbName
    else
        Executable := DBG_PROGRAM(devCompiler.CompilerType);

    //Create the command line
    Executable := Format('%s -lines -2 -G -n -s -y "%s" -p %d',
        [Executable, ExtractFilePath(filename) +
        ';SRV*' + IncludeTrailingPathDelimiter(ExtractFilePath(devDirs.Exec)) +
        'Symbols*http://msdl.microsoft.com/download/symbols', pid]);

    //Run the thing!
    Launch(Executable, '');

    //Tell the wait function that another valid output terminator is the 0:0000 prompt
    // Wait.OutputTerminators.Add(InputPrompt);

    //Send the source mode setting (enable all except ONLY source)
    QueueCommand('l+t; l+l; l+s', '');

    //Set all the paths
    Srcpath := ExtractFilePath(Filename) + ';';
    for I := 0 to IncludeDirs.Count - 1 do
        Srcpath := Srcpath + IncludeDirs[I] + ';';
    QueueCommand('.srcpath+', Srcpath);
    QueueCommand('.exepath+', ExtractFilePath(Filename));
end;

procedure TCDBDebugger.OnOutput(Output: string);
const
    InputPrompt = '^([0-9]+):([0-9]+)>';
var
    NewLines: TStringList;
    RegExp: TRegExpr;
    CurrBp: TBreakpoint;
    CurLine: string;

    procedure FlushOutputBuffer;
    begin
        if NewLines.Count <> 0 then
        begin
            MainForm.DebugOutput.Lines.BeginUpdate;
            MainForm.DebugOutput.Lines.AddStrings(NewLines);
            MainForm.DebugOutput.Lines.EndUpdate;
            SendMessage(MainForm.DebugOutput.Handle, $00B6 {EM_LINESCROLL}, 0,
                MainForm.DebugOutput.Lines.Count);
            NewLines.Clear;
        end;
    end;

    procedure ParseError(const line: string);
    begin
        if RegExp.Substitute('$3') = 'c0000005' then
            OnAccessViolation
        else
        if RegExp.Substitute('$3') = '40010005' then

        else
        if RegExp.Substitute('$3') = 'c00000fd' then

        else
        if RegExp.Substitute('$3') = '80000003' then
            if IgnoreBreakpoint then
                IgnoreBreakpoint := FALSE
            else
                OnBreakpoint;
    end;

    procedure ParseOutput(const line: string);
    begin
        if RegExp.Exec(line, InputPrompt) then
        begin
            //The debugger is waiting for input, we're paused!
            SentCommand := FALSE;
            fPaused := TRUE;
            fBusy := FALSE;

            //Because we are here, we probably are a side-effect of a previous instruction
            //Execute the process function for the command.
            if (CurOutput.Count <> 0) and (CurrentCommand <> NIL) and
                Assigned(CurrentCommand.OnResult) then
                CurrentCommand.OnResult(CurOutput);

            if CurrentCommand <> NIL then
                if (CurrentCommand.Command = 'g'#10) or
                    (CurrentCommand.Command = 't'#10) or
                    (CurrentCommand.Command = 'p'#10) then
                begin
                    RefreshContext;
                    Application.BringToFront;
                end;
            CurOutput.Clear;

            //Send the command, and do not send any more
            FlushOutputBuffer;
            SendCommand;

            //Make sure we don't save the current line!
            Exit;
        end;

        if RegExp.Exec(line, 'DBGHELP: (.*) - no symbols loaded') then
        begin
            if LowerCase(RegExp.Substitute('$1')) =
                LowerCase(ChangeFileExt(ExtractFileName(Filename), '')) then
                OnNoDebuggingSymbolsFound;
        end
        else
        if RegExp.Exec(line,
            'ModLoad: +([0-9a-fA-F]{1,8}) +([0-9a-fA-F]{1,8}) +(.*)') then
            MainForm.StatusBar.Panels[3].Text :=
                'Loaded ' + RegExp.Substitute('$3')
        else
        if RegExp.Exec(line,
            '\((.*)\): (.*) - code ([0-9a-fA-F]{1,8}) \((.*)\)') then
            ParseError(line)
        else
        if RegExp.Exec(line, 'Breakpoint ([0-9]+) hit') then
        begin
            CurrBp := GetBreakpointFromIndex(
                StrToIntDef(RegExp.Substitute('$1'), 0));
            if CurrBp <> NIL then
                MainForm.GotoBreakpoint(CurrBp.Filename, CurrBp.Line)
            else
                JumpToCurrentLine := TRUE;
        end;

        CurOutput.Add(Line);
    end;
begin
    //Update the memo
    Screen.Cursor := crHourglass;
    Application.ProcessMessages;
    RegExp := TRegExpr.Create;
    NewLines := TStringList.Create;

    try
        while Pos(#10, Output) > 0 do
        begin
            //Extract the current line
            CurLine := Copy(Output, 0, Pos(#10, Output) - 1);

            //Process the output
            if not AnsiStartsStr('DBGHELP: ', CurLine) then
                NewLines.Add(CurLine);
            ParseOutput(CurLine);

            //Remove those that we've already processed
            Delete(Output, 1, Pos(#10, Output));
        end;

        if Length(Output) > 0 then
        begin
            NewLines.Add(Output);
            ParseOutput(Output);
        end;
    except
        on E: Exception do
            madExcept.HandleException;
    end;

    //Add the new lines to the edit control if we have any
    FlushOutputBuffer;

    //Clean up
    RegExp.Free;
    NewLines.Free;
    Screen.Cursor := crDefault;
end;

procedure TCDBDebugger.AddIncludeDir(s: string);
begin
    IncludeDirs.Add(s);
    if Executing then
        QueueCommand('.sympath+', s);
end;

procedure TCDBDebugger.ClearIncludeDirs;
begin
    IncludeDirs.Clear;
end;

procedure TCDBDebugger.AddBreakpoint(breakpoint: TBreakpoint);
var
    aBreakpoint: PBreakpoint;
begin
    if (not Paused) and Executing then
    begin
        MessageDlg('Cannot add a breakpoint while the debugger is executing.',
            mtError, [mbOK], MainForm.Handle);
        Exit;
    end;

    New(aBreakpoint);
    aBreakpoint^ := breakpoint;
    Breakpoints.Add(aBreakpoint);
    RefreshBreakpoint(aBreakpoint^);
end;

procedure TCDBDebugger.RemoveBreakpoint(breakpoint: TBreakpoint);
var
    I: integer;
begin
    if (not Paused) and Executing then
    begin
        MessageDlg('Cannot remove a breakpoint while the debugger is executing.', mtError, [mbOK], MainForm.Handle);
        Exit;
    end;

    for i := 0 to Breakpoints.Count - 1 do
        if (PBreakPoint(Breakpoints.Items[i])^.line = breakpoint.Line) and
            (PBreakPoint(Breakpoints.Items[i])^.editor =
            breakpoint.Editor) then
        begin
            if Executing then
                QueueCommand('bc',
                    IntToStr(PBreakpoint(Breakpoints.Items[i])^.Index));
            Dispose(Breakpoints.Items[i]);
            Breakpoints.Delete(i);
            Break;
        end;
end;

procedure TCDBDebugger.RefreshBreakpoint(var breakpoint: TBreakpoint);
var
    Command: TCommand;
begin
    if Executing then
    begin
        Inc(fNextBreakpoint);
        breakpoint.Valid := TRUE;
        breakpoint.Index := fNextBreakpoint;
        Command := TCommand.Create;
        Command.Data := breakpoint;
        Command.Command :=
            Format('bp%d `%s:%d`', [breakpoint.Index, breakpoint.Filename,
            breakpoint.Line]);
        Command.OnResult := OnBreakpointSet;
        QueueCommand(Command);
    end;
end;

procedure TCDBDebugger.OnBreakpointSet(Output: TStringList);
var
    e: TEditor;
begin
    if CurrentCommand.Data = NIL then
        Exit;

    with TBreakpoint(CurrentCommand.Data) do
    begin
        Valid := FALSE;
        e := MainForm.GetEditorFromFileName(FileName, TRUE);
        if e <> NIL then
            e.InvalidateGutter;
    end;
end;

procedure TCDBDebugger.RefreshContext(refresh: ContextDataSet);
var
   // I: Integer;
   // Node: TTreeNode;
    Command: TCommand;
   // MemberName: String;
begin
    if not Executing then
        Exit;

    //First send commands for stack tracing, locals and the threads list
    if cdCallStack in refresh then
    begin
        Command := TCommand.Create;
        Command.Command := 'kp 512';
        Command.OnResult := OnCallStack;
        QueueCommand(Command);
    end;
    if cdLocals in refresh then
    begin
        Command := TCommand.Create;
        Command.Command := 'dv -i -v';
        Command.OnResult := OnLocals;
        QueueCommand(Command);
    end;
    if cdThreads in refresh then
    begin
        Command := TCommand.Create;
        Command.Command := '~';
        Command.OnResult := OnThreads;
        QueueCommand(Command);
    end;

    //Then update the watches
    if (cdWatches in refresh) and Assigned(DebugTree) then
    begin


    end;
end;

procedure TCDBDebugger.OnRefreshContext(Output: TStringList);
begin
end;

procedure TCDBDebugger.AddWatch(varname: string; when: TWatchBreakOn);
begin
end;

//Procedure TCDBDebugger.RefreshWatches;
//Begin
//End;

procedure TCDBDebugger.OnCallStack(Output: TStringList);
var
    I: integer;
    RegExp: TRegExpr;
    CallStack: TList;
    StackFrame: PStackFrame;
begin
    CallStack := TList.Create;
    RegExp := TRegExpr.Create;

    for I := 0 to Output.Count - 1 do
        if RegExp.Exec(Output[I], 'ChildEBP RetAddr') then
            Continue
        else
        if RegExp.Exec(Output[I],
            '([0-9a-fA-F]{1,8}) ([0-9a-fA-F]{1,8}) (.*)!(.*)\((.*)\)(|.*) \[(.*) @ ([0-9]*)\]')
        then
        begin
            //Stack frame with source information
            New(StackFrame);
            CallStack.Add(StackFrame);

            //Fill the fields
            with StackFrame^ do
            begin
                Filename := RegExp.Substitute('$7');
                Line := StrToIntDef(RegExp.Substitute('$8'), 0);
                FuncName := RegExp.Substitute('$4$6');
                Args := RegExp.Substitute('$5');
            end;
        end
        else
        if RegExp.Exec(Output[I],
            '([0-9a-fA-F]{1,8}) ([0-9a-fA-F]{1,8}) (.*)!(.*)(|\((.*)\))(.*)')
        then
        begin
            //Stack frame without source information
            New(StackFrame);
            CallStack.Add(StackFrame);

            //Fill the fields
            with StackFrame^ do
            begin
                FuncName := RegExp.Substitute('$4$6');
                Args := RegExp.Substitute('$5');
                Line := 0;
            end;
        end;

    //Now that we have the entire callstack loaded into our list, call the function
    //that wants it
    if Assigned(TDebugger(Self).OnCallStack) then
        TDebugger(Self).OnCallStack(CallStack);

    //Do we show the new execution point?
    if JumpToCurrentLine then
    begin
        JumpToCurrentLine := FALSE;
        MainForm.GotoTopOfStackTrace;
    end;

    //Clean up
    RegExp.Free;
    CallStack.Free;
end;

procedure TCDBDebugger.OnThreads(Output: TStringList);
var
    I: integer;
    Thread: PDebuggerThread;
    Threads: TList;
    RegExp: TRegExpr;
    Suspended, Frozen: boolean;
begin
    Threads := TList.Create;
    RegExp := TRegExpr.Create;

    for I := 0 to Output.Count - 1 do
        if RegExp.Exec(Output[I],
            '([.#]*)( +)([0-9]*)( +)Id: ([0-9a-fA-F]*)\.([0-9a-fA-F]*) Suspend: ([0-9a-fA-F]*) Teb: ([0-9a-fA-F]{1,8}) (.*)') then
        begin
            New(Thread);
            Threads.Add(Thread);

            //Fill the fields
            with Thread^ do
            begin
                Active := RegExp.Substitute('$1') = '.';
                Index := RegExp.Substitute('$3');
                ID := RegExp.Substitute('$5.$6');
                Suspended := RegExp.Substitute('$7') <> '0';
                Frozen := RegExp.Substitute('$9') = 'frozen';
                if Suspended and Frozen then
                    ID := ID + ' (Suspended, Frozen)'
                else
                if Suspended then
                    ID := ID + ' (Suspended)'
                else
                if Frozen then
                    ID := ID + ' (Frozen)';
            end;
        end;

    //Pass the locals list to the callback function that wants it
    if Assigned(TDebugger(Self).OnThreads) then
        TDebugger(Self).OnThreads(Threads);

    //Clean up
    Threads.Free;
    RegExp.Free;
end;

procedure TCDBDebugger.OnLocals(Output: TStringList);
var
    I: integer;
    Local: PVariable;
    Locals: TList;
    RegExp: TRegExpr;
    Command: TCommand;
begin
    Locals := TList.Create;
    LocalsList := TList.Create;
    RegExp := TRegExpr.Create;

    for I := 0 to Output.Count - 1 do
        if RegExp.Exec(Output[I],
            '(.*)( +)(.*)( +)([0-9a-fA-F]{1,8}) +(.*) = (.*)') then
        begin
            New(Local);
            Locals.Add(Local);

            //Fill the fields
            with Local^ do
            begin
                Name := RegExp.Substitute('$6');
                Value := RegExp.Substitute('$7');
                Location := RegExp.Substitute('$5');
            end;
        end;

    //Now that the locals list has a complete list of values, we want to get the
    //full variable stuff if it is a structure.
    Command := TCommand.Create;
    Command.Command := '';
    for I := 0 to Locals.Count - 1 do
        with PVariable(Locals[I])^ do
            if (Pos('class', Value) > 0) or (Pos('struct', Value) > 0) or
                (Pos('union', Value) > 0) then
                Command.Command :=
                    Format('%sdt -r -b -n %s;', [Command.Command, Name])
            else
            if Pos('[', Value) > 0 then
                Command.Command :=
                    Format('%sdt -a -r -b -n %s;', [Command.Command, Name])
            else
            if Pos('0x', Value) = 1 then
                Command.Command :=
                    Format('%sdt -a -r -b -n %s;', [Command.Command, Name])
            else
                LocalsList.Add(Locals[I]);

    if Command.Command <> '' then
    begin
        Command.OnResult := OnDetailedLocals;
        QueueCommand(Command);
    end
    else
    begin
        if Assigned(TDebugger(Self).OnLocals) then
            TDebugger(Self).OnLocals(LocalsList);
        FreeAndNil(LocalsList);
    end;

    //Clean up
    Locals.Free;
    RegExp.Free;
end;

//This is a complete rip of the watch (dt) parsing code. But I have no choice...
procedure TCDBDebugger.OnDetailedLocals(Output: TStringList);
const
    NotFound = 'Cannot find specified field members.';
    PtrVarPrompt = '(.*) (.*) @ 0x([0-9a-fA-F]{1,8}) Type (.*?)([\[\]\*]+)';
    VarPrompt = '(.*) (.*) @ 0x([0-9a-fA-F]{1,8}) Type (.*)';
    StructExpr = '( +)[\+|=]0x([0-9a-fA-F]{1,8}) ([^ ]*)?( +): (.*)';
    ArrayExpr = '\[([0-9a-fA-F]*)\] @ ([0-9a-fA-F]*)';
    StructArrayExpr = '( *)\[([0-9a-fA-F]*)\] (.*)';
var
    Variables: TStringList;
    SubStructure: TStringList;
    RegExp: TRegExpr;
    Local: PVariable;
    I, J: integer;

    function SynthesizeIndent(Indent: integer): string;
    var
        I: integer;
    begin
        Result := '';
        for I := 0 to Indent - 1 do
            Result := Result + ' ';
    end;

    procedure ParseStructure(Output: TStringList; exIndent: integer); forward;
    procedure ParseStructArray(Output: TStringList; Indent: integer);
    var
        I: integer;
        SubStructure: TStringList;
    begin
        I := 0;
        Indent := 0;
        while I < Output.Count do
            if RegExp.Exec(Output[I], StructArrayExpr) then
            begin
                Inc(I);
                if I >= Output.Count then
                    Continue;

                if RegExp.Exec(Output[I], StructExpr) then
                begin
                    if Indent = 0 then
                        Indent := Length(RegExp.Substitute('$1'));

                    SubStructure := TStringList.Create;
                    while I < Output.Count do
                    begin
                        if RegExp.Exec(Output[I], StructExpr) then
                        begin
                            if Length(RegExp.Substitute('$1')) < Indent then
                                Break
                            else
                            begin SubStructure.Add(Output[I]); end;
                        end
                        else
                        if RegExp.Exec(Output[I], StructArrayExpr) then
                            if Length(RegExp.Substitute('$1')) <= Indent then
                                Break
                            else
                                SubStructure.Add(Output[I]);

                        Inc(I);
                    end;

                    //Determine if it is a structure or an array
                    ParseStructure(SubStructure, Indent + 4);
                    SubStructure.Free;
                    Dec(I);
                end;
            end;
    end;

    procedure ParseStructure(Output: TStringList; exIndent: integer);
    var
        SubStructure: TStringList;
        Indent, I: integer;
    begin
        I := 0;
        Indent := 0;
        while I < Output.Count do
        begin
            if RegExp.Exec(Output[I], StructExpr) or
                RegExp.Exec(Output[I], StructArrayExpr) then
            begin
                if Indent = 0 then
                    Indent := Length(RegExp.Substitute('$1'));

                //Check if this is a sub-structure
                if Indent <> Length(RegExp.Substitute('$1')) then
                begin
                    //Populate the substructure string list
                    SubStructure := TStringList.Create;

                    while I < Output.Count do
                    begin
                        if RegExp.Exec(Output[I], StructArrayExpr) or
                            RegExp.Exec(Output[I], StructExpr) then
                            if Length(RegExp.Substitute('$1')) <= Indent then
                            begin
                                Inc(I);
                                Break;
                            end
                            else
                                SubStructure.Add(Output[I]);
                        Inc(I);
                    end;

                    //Determine if it is a structure or an array
                    if SubStructure.Count <> 0 then
                        if Trim(SubStructure[0])[1] = '[' then
                            ParseStructArray(SubStructure, Indent + 4)
                        else
                            ParseStructure(SubStructure, Indent + 4);
                    SubStructure.Free;

                    //Decrement I, since we will increment one at the end of the loop
                    Dec(I);
                end
                //Otherwise just add the value
                else
                begin
                    New(Local);
                    Local^.Name :=
                        SynthesizeIndent(Indent + exIndent) +
                        RegExp.Substitute('$3');
                    Local^.Value := RegExp.Substitute('$5');
                    LocalsList.Add(Local);
                end;
            end;

            //Increment I
            Inc(I);
        end;
    end;

    procedure ParseArray(Output: TStringList; Indent: integer);
    var
        SubStructure: TStringList;
        Increment: integer;
        I: integer;
    begin
        I := 0;
        while I < Output.Count do
        begin
            if RegExp.Exec(Output[I], ArrayExpr) then
            begin
                Inc(I, 2);
                Increment := 2;
                while Trim(Output[I]) = '' do
                begin
                    Inc(I);
                    Inc(Increment);
                end;

                //Are we an array (with a basic data type) or with a UDT?
                if RegExp.Exec(Output[I], StructExpr) then
                begin
                    with TRegExpr.Create do
                    begin
                        Exec(Output[I - Increment], ArrayExpr);
                        New(Local);
                        Local^.Name :=
                            SynthesizeIndent(Indent) + Substitute('$1');
                        LocalsList.Add(Local);
                        Free;
                    end;

                    //Populate the substructure string list
                    SubStructure := TStringList.Create;
                    while (I < Output.Count) and (Output[I] <> '') do
                    begin
                        SubStructure.Add(Output[I]);
                        Inc(I);
                    end;

                    //Process it
                    ParseStructure(SubStructure, Indent + 4);
                    SubStructure.Free;

                    //Decrement I, since we will increment one at the end of the loop
                    Dec(I);
                end
                else
                    with TRegExpr.Create do
                    begin
                        Exec(Output[I - Increment], ArrayExpr);
                        New(Local);
                        Local^.Name :=
                            SynthesizeIndent(Indent) + Substitute('[$1]');
                        Local^.Value := Output[I];
                        LocalsList.Add(Local);
                        Inc(I);

                        if (I < Output.Count - 1) and
                            Exec(Output[I],
                            ' -> 0x([0-9a-fA-F]{1,8}) +(.*)') then
                        begin
                            New(Local);
                            Local^.Name :=
                                SynthesizeIndent(Indent + 4) +
                                Substitute('$1');
                            Local^.Value := Substitute('$2');
                            LocalsList.Add(Local);
                            Inc(I);
                        end
                        else
                        if RegExp.Exec(Output[I], StructExpr) then
                        begin
                            //Populate the substructure string list
                            SubStructure := TStringList.Create;
                            while (I < Output.Count) and (Output[I] <> '') do
                            begin
                                SubStructure.Add(Output[I]);
                                Inc(I);
                            end;

                            //Process it
                            ParseStructure(SubStructure, Indent + 4);
                            SubStructure.Free;

                            //Decrement I, since we will increment one at the end of the loop
                            Dec(I);
                        end;
                        Free;
                    end;
            end;

            //Increment I
            Inc(I);
        end;
    end;
begin
    SubStructure := TStringList.Create;
    Variables := TStringList.Create;
    RegExp := TRegExpr.Create;

    //Compute the list of commands
    I := 1;
    while I <= Length(CurrentCommand.Command) do
    begin
        if Copy(CurrentCommand.Command, I, 3) = '-n ' then
        begin
            Inc(I, 3);
            J := I;
            while I <= Length(CurrentCommand.Command) do
            begin
                if CurrentCommand.Command[I] = ';' then
                begin
                    Variables.Add(Copy(CurrentCommand.Command, J, I - J));
                    Break;
                end;
                Inc(I);
            end;
        end;
        Inc(I);
    end;

    //Set the type of the structure/class/whatever
    J := 0;
    I := 0;
    while I < Output.Count do
        if RegExp.Exec(Output[I], PtrVarPrompt) then
        begin
            New(Local);
            Local^.Name := Variables[J];
            Local^.Value := RegExp.Substitute('$4$5');
            Local^.Location := RegExp.Substitute('0x$3');
            LocalsList.Add(Local);
            Inc(I);

            while (I < Output.Count) and not
                RegExp.Exec(Output[I], VarPrompt) do
            begin
                SubStructure.Add(Output[I]);
                Inc(I);
            end;

            ParseArray(SubStructure, 4);
            SubStructure.Clear;
            Inc(J);
        end
        else
        if RegExp.Exec(Output[I], VarPrompt) then
        begin
            New(Local);
            Local^.Name := Variables[J];
            Local^.Location := RegExp.Substitute('0x$3');
            Local^.Value := RegExp.Substitute('$4');
            LocalsList.Add(Local);
            Inc(I);

            while (I < Output.Count) and not
                RegExp.Exec(Output[I], VarPrompt) do
            begin
                SubStructure.Add(Output[I]);
                Inc(I);
            end;

            ParseStructure(SubStructure, 4);
            SubStructure.Clear;
            Inc(J);
        end
        else
            Inc(I);

    //Send the list of locals
    if Assigned(TDebugger(Self).OnLocals) then
        TDebugger(Self).OnLocals(LocalsList);
    FreeAndNil(LocalsList);

    SubStructure.Free;
    Variables.Free;
    RegExp.Free;
end;

procedure TCDBDebugger.GetRegisters;
var
    Command: TCommand;
begin
    if (not Executing) or (not Paused) then
        Exit;

    Command := TCommand.Create;
    Command.Command := 'r';
    Command.OnResult := OnRegisters;
    QueueCommand(Command);
end;

procedure TCDBDebugger.OnRegisters(Output: TStringList);
var
    I: integer;
    RegExp: TRegExpr;
    Registers: TRegisters;
begin
    RegExp := TRegExpr.Create;
    Registers := TRegisters.Create;

    for I := 0 to Output.Count - 1 do
        if RegExp.Exec(Output[I],
            'eax=([0-9a-fA-F]{1,8}) ebx=([0-9a-fA-F]{1,8}) ecx=([0-9a-fA-F]{1,8}) edx=([0-9a-fA-F]{1,8}) esi=([0-9a-fA-F]{1,8}) edi=([0-9a-fA-F]{1,8})') then
            with Registers do
            begin
                EAX := RegExp.Substitute('$1');
                EBX := RegExp.Substitute('$2');
                ECX := RegExp.Substitute('$3');
                EDX := RegExp.Substitute('$4');
                ESI := RegExp.Substitute('$5');
                EDI := RegExp.Substitute('$6');
            end
        else
        if RegExp.Exec(Output[I],
            'eip=([0-9a-fA-F]{1,8}) esp=([0-9a-fA-F]{1,8}) ebp=([0-9a-fA-F]{1,8}) iopl=([0-9a-fA-F]{1,8})')
        then
            with Registers do
            begin
                EIP := RegExp.Substitute('$1');
                ESP := RegExp.Substitute('$2');
                EBP := RegExp.Substitute('$3');
            end
        else
        if RegExp.Exec(Output[I],
            'cs=([0-9a-fA-F]{1,4})  ss=([0-9a-fA-F]{1,4})  ds=([0-9a-fA-F]{1,4})  es=([0-9a-fA-F]{1,4})  fs=([0-9a-fA-F]{1,4})  gs=([0-9a-fA-F]{1,4})             efl=([0-9a-fA-F]{1,8})') then
            with Registers do
            begin
                CS := RegExp.Substitute('$1');
                SS := RegExp.Substitute('$2');
                DS := RegExp.Substitute('$3');
                ES := RegExp.Substitute('$4');
                FS := RegExp.Substitute('$5');
                GS := RegExp.Substitute('$6');
                EFLAGS := RegExp.Substitute('$7');
            end;

    //Pass the locals list to the callback function that wants it
    if Assigned(TDebugger(Self).OnRegisters) then
        TDebugger(Self).OnRegisters(Registers);

    //Clean up
    RegExp.Free;
end;

procedure TCDBDebugger.Disassemble(func: string);
var
    Command: TCommand;
begin
    if (not Executing) or (not Paused) then
        Exit;

    //If func is empty, assume the value of the reguister eip.
    if func = '' then
        func := 'eip';

    Command := TCommand.Create;
    Command.Command := 'uf ' + func;
    Command.OnResult := OnDisassemble;
    QueueCommand(Command);
end;

procedure TCDBDebugger.OnDisassemble(Output: TStringList);
var
    I, CurLine: integer;
    RegExp: TRegExpr;
    CurFile: string;
    Disassembly: string;
begin
    CurLine := -1;
    RegExp := TRegExpr.Create;
    for I := 0 to Output.Count - 1 do
        if RegExp.Exec(Output[I], '^(.*)!(.*) \[(.*) @ ([0-9]+)]:') then
        begin
            CurLine := StrToIntDef(RegExp.Substitute('$4'), 0);
            CurFile := RegExp.Substitute('$1!$2 [$3 @ ');
            Disassembly := Disassembly + #9 + ';' + Output[I] + #10;
        end
        else
        if RegExp.Exec(Output[I], '^(.*)!(.*):') then
            Disassembly := Disassembly + #9 + ';' + Output[I] + #10
        else
        if RegExp.Exec(Output[I],
            '^ +([0-9]+) +([0-9a-fA-F]{1,8})( +)([^ ]*)( +)(.*)( +)(.*)') then
        begin
            if StrToIntDef(RegExp.Substitute('$1'), 0) <> CurLine then
            begin
                CurLine := StrToIntDef(RegExp.Substitute('$1'), 0);
                Disassembly :=
                    Disassembly + #9 + ';' + CurFile +
                    RegExp.Substitute('$1') + ']:' + #10;
            end;
            Disassembly := Disassembly +
                RegExp.Substitute('$2$3$4$5$6$7$8') + #10;
        end
        else
        if RegExp.Exec(Output[I],
            '^([0-9a-fA-F]{1,8})( +)([^ ]*)( +)(.*)( +)(.*)') then
            Disassembly := Disassembly + Output[I] + #10;

    //Pass the disassembly to the callback function that wants it
    if Assigned(TDebugger(Self).OnDisassemble) then
        TDebugger(Self).OnDisassemble(Disassembly);

    //Clean up
    RegExp.Free;
end;

function TCDBDebugger.GetVariableHint(name: string): string;
var
    Command: TCommand;
begin
    if (not Executing) or (not Paused) then
        Exit;

    Command := TCommand.Create;
    Command.Data := TString.Create(name);
    Command.OnResult := OnVariableHint;

    //Decide what command we should send - dv for locals, dt for structures
    if Pos('.', name) > 0 then
        Command.Command := 'dt ' + Copy(name, 1, Pos('.', name) - 1)
    else
        Command.Command := 'dv ' + name;

    //Send the command;
    QueueCommand(Command);
end;

procedure TCDBDebugger.OnVariableHint(Output: TStringList);
var
    Hint, Name: string;
    I, Depth: integer;
    RegExp: TRegExpr;
begin
    Name := TString(CurrentCommand.Data).Str;
    CurrentCommand.Data.Free;
    RegExp := TRegExpr.Create;

    if Pos('.', Name) <> 0 then
    begin
        //Remove the dots and count the number of indents
        Depth := 0;
        for I := 1 to Length(name) do
            if name[I] = '.' then
                Inc(Depth);

        //Then find the member name
        for I := 0 to Output.Count - 1 do
            if RegExp.Exec(Output[I], '( {' + IntToStr(Depth * 3) +
                '})\+0x([0-9a-fA-F]{1,8}) ' +
                Copy(name, GetLastPos('.', name) + 1, Length(name)) +
                '( +): (.*)') then
                Hint := RegExp.Substitute(name + ' = $4');
    end
    else
        for I := 0 to Output.Count - 1 do
            if RegExp.Exec(Output[I], '( +)(.*) = (.*)') then
                Hint := Trim(Output[I]);

    //Call the callback
    if Assigned(TDebugger(Self).OnVariableHint) then
        TDebugger(Self).OnVariableHint(Hint);

    //Clean up
    RegExp.Free;
end;

procedure TCDBDebugger.Go;
var
    Command: TCommand;
begin
    Command := TCommand.Create;
    Command.Command := 'g';
    Command.Callback := OnGo;
    QueueCommand(Command);
end;

procedure TCDBDebugger.Next;
var
    Command: TCommand;
begin
    Command := TCommand.Create;
    Command.Command := 'p';
    Command.Callback := OnTrace;
    QueueCommand(Command);
end;

procedure TCDBDebugger.Step;
var
    Command: TCommand;
begin
    Command := TCommand.Create;
    Command.Command := 't';
    Command.Callback := OnTrace;
    QueueCommand(Command);
end;

procedure TCDBDebugger.Finish;
var
    Command: TCommand;
begin
    Command := TCommand.Create;
    Command.Command := 't';
    Command.Callback := OnTrace;
    QueueCommand(Command);
end;

procedure TCDBDebugger.OnTrace;
begin
    JumpToCurrentLine := TRUE;
    fPaused := FALSE;
    fBusy := FALSE;
end;

procedure TCDBDebugger.SetThread(thread: integer);
begin
    QueueCommand('~' + IntToStr(thread), 's');
    RefreshContext;
end;

procedure TCDBDebugger.SetFrame(frame: integer);
begin
    QueueCommand('.frame', IntToStr(frame));
    RefreshContext([cdLocals, cdWatches]);
end;

// Debugger virtual functions
procedure TCDBDebugger.FirstParse;
begin
end;

procedure TCDBDebugger.ExitDebugger;
begin
end;

procedure TCDBDebugger.WriteToPipe(Buffer: string);
begin
end;

procedure TCDBDebugger.AddToDisplay(Msg: string);
begin
end;


/////////////////////////////////////////////

{$IFDEF DISPLAYOUTPUTHEX}
{*
 * This is a debugging display
 * Turn on only for development or fault-finding.
 *
}
procedure HexDisplay(buf: PChar; LastRead: DWORD);
var
    Buffer: String;
    CBuffer: String;
    i, j: DWORD;

begin
    Buffer := 'Bytes actually read: ' + IntToStr(LastRead);
    TGDBDebugger(MainForm.fDebugger).AddtoDisplay(Buffer);
    Buffer := '';
    TGDBDebugger(MainForm.fDebugger).AddtoDisplay(buf);
    i := 0;
    repeat
        for j := 0 to 15 do
        begin
            if ((buf[i + j] = CR) or (buf[i + j] = LF)) then
                CBuffer := '   '
            else
                CBuffer := ' ' + buf[i + j] + ' ';
            Buffer := Buffer + CBuffer;
            if (i + j >= LastRead) then
                break;
        end;
        Buffer := Buffer;
        TGDBDebugger(MainForm.fDebugger).AddtoDisplay(Buffer);
        Buffer := '';
        for j := 0 to 15 do
        begin
            CBuffer := ' ' + IntToHex(Ord(buf[i + j]), 2);
            Buffer := Buffer + CBuffer;
            if (i + j >= LastRead) then
                break;
        end;
        Buffer := Buffer;
        TGDBDebugger(MainForm.fDebugger).AddtoDisplay(Buffer);
        Buffer := '';
        i := i + 16;
    until (i >= LastRead);
end;

{$endif}

initialization
    Breakpoints := TList.Create;

finalization
    Breakpoints.Free;

end.
