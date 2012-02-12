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

Unit debugger;

//{$DEFINE DISPLAYOUTPUT}   // enable byte count output in ReadThread for debugging
//{$DEFINE DISPLAYOUTPUTHEX}// enable debugging display of GDB output
//  in 'HEX Editor' style

Interface

Uses
    Classes, editor, Sysutils, version, debugCPU

    {$IFDEF WIN32}
    , ComCtrls, Controls, Dialogs, ShellAPI, Windows
    {$ENDIF}
    {$IFDEF LINUX}
    , QComCtrls, QControls, QDialogs
    {$ENDIF};

Var
    //output from GDB
    TargetIsRunning: Boolean = False;       // result of status messages
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
    buf: Pchar;             // The main buffer into which data is read


{$IFDEF DISPLAYOUTPUTHEX}
// (Global because it is a useful data analysis tool).
procedure HexDisplay(buf: PChar; LastRead: DWORD);
{$ENDIF}

// These don't really belong in T(GDB)Debugger
Function AnsiBeforeFirst(Sub: String; Target: String): String;
Function AnsiAfterFirst(Sub: String; Target: String): String;
Function AnsiAfterLast(Sub: String; Target: String): String;
Function AnsiFindLast(Src: String; Target: String): Integer;
Function AnsiLeftStr(Const AText: String; ACount: Integer): String;
Function AnsiMidStr(Const AText: String;
    Const AStart, ACount: Integer): String;
Function AnsiRightStr(Const AText: String; ACount: Integer): String;
Function unescape(s: PString): String;
Function OctToHex(s: PString): String;


Const GDBPrompt: String = '(gdb)';
Const GDBerror: String = 'error,';
Const GDBdone: String = 'done,';
Const GDBaddr: String = 'addr=';
Const GDBaddress: String = 'address=';
Const GDBall: String = 'all';
Const GDBarg: String = 'arg-begin';
Const GDBasminst: String = 'asm_insns=';
Const GDBasmline: String = 'line_asm_insns=';
Const GDBassignerror: String = 'error,mi_cmd_var_assign: Variable object is not editable"';
Const GDBbegin: String = 'begin';
Const GDBbkpt: String = 'bkpt={';
Const GDBbpoint: String = 'breakpoint';
Const GDBbkpthit: String = 'breakpoint-hit';
Const GDBbkptno: String = 'bkptno';
Const GDBbkpttable: String = 'BreakpointTable={';
Const GDBbody: String = 'body=[';
Const GDBbrkins: String = '-break-insert ';
Const GDBbrkdel: String = '-break-delete ';
Const GDBbrkwatch: String = '-break-watch ';
Const GDBcontents: String = 'contents';
Const GDBcontinue: String = '-exec-continue';
Const GDBcontext: String = '--thread %d --frame %d';
Const GDBcurthread: String = 'current-thread-id';
Const GDBdataeval: String = '-data-evaluate-expression ';
Const GDBDisassem: String = '-data-disassemble ';
Const GDBend: String = 'end';
Const GDBendstep: String = 'end-stepping-range';
Const GDBexp: String = 'exp=';
Const GDBExit: String = '-gdb-exit';
Const GDBExitmsg: String = 'exit';
Const GDBExitnormal: String = 'exited-normally';
Const GDBfile: String = 'file';
Const GDBfileq: String = 'file=';
Const GDBfinish: String = '-exec-finish';
Const GDBflavour: String = '-gdb-set disassembly-flavor';
Const GDBframe: String = 'frame={';
Const GDBframebegin: String = 'frame-begin';
Const GDBframefnarg: String = 'frame-args';
Const GDBframefnname: String = 'frame-function-name';
Const GDBframesrcfile: String = 'frame-source-file';
Const GDBframesrcline: String = 'frame-source-line';
Const GDBfunc: String = 'func';
Const GDBfuncname: String = 'func-name=';
Const GDBid: String = 'id';
Const GDBidq: String = 'id=';
Const GDBinstr: String = 'inst=';
Const GDBInterp: String = '--interpreter=mi';
Const GDBlevel: String = 'level';
Const GDBlistframes: String = '-stack-list-frames';
Const GDBlistlocals: String = '-stack-list-locals';
Const GDBlistregvalues: String = '-data-list-register-values %s r';
Const GDBlocals: String = 'locals';
Const GDBlocalsq: String = 'locals=';
Const GDBline: String = 'line';
Const GDBlineq: String = 'line=';
Const GDBmemq: String = 'memory=';
Const GDBmult: String = '<MULTIPLE>';
Const GDBnr_rows: String = 'nr_rows';
Const GDBname: String = 'name';
Const GDBnameq: String = 'name=';
Const GDBnew: String = 'new';
Const GDBnext: String = '-exec-next';
Const GDBnumber: String = 'number';
Const GDBNoSymbol: String = 'No symbol';
Const GDBoffset: String = 'offset=';
Const GDBold: String = 'old';
Const GDBorig_loc: String = 'original-location=';
Const GDBregnames: String = 'register-names=';
Const GDBregvalues: String = 'register-values=';
Const GDBreason: String = 'reason=';
Const GDBrun: String = '-exec-run';
Const GDBrunning: String = 'running';
Const GDBsigmean: String = 'signal-meaning';
Const GDBsigname: String = 'signal-name';
Const GDBsigrcv: String = 'signal-received';
Const GDBsigsegv: String = 'SIGSEGV';
Const GDBSilent: String = '--silent';
Const GDBsrcline: String = 'src_and_asm_line=';
Const GDBstack: String = 'stack=[';
Const GDBstep: String = '-exec-step';
Const GDBstopped: String = 'stopped';
Const GDBtargetid: String = 'target-id';
Const GDBthreadid: String = 'thread-id';
Const GDBthreadinfo: String = '-thread-info';
Const GDBthreads: String = 'threads=';
Const GDBthreadgcr: String = 'thread-group-created';
Const GDBtype: String = 'type';
Const GDBvalue: String = 'value';
Const GDBvalueq: String = 'value=';
Const GDBvalueqb: String = 'value={';
Const GDBvarcreate: String = '%d-var-create %s VO%s @ %s';
Const GDBvarassign: String = '%d-var-assign VO%s %s';
Const GDBvardelete: String = '%d-var-delete VO%s';
Const GDBwhat: String = 'what=';
Const GDBwperrnoimp: String = 'Expression cannot be implemented';
Const GDBwperrnosup: String = 'Target does not support';
Const GDBwperrsup: String = 'Target can only support';
Const GDBwperrjunk: String = 'Junk at end of command.';
Const GDBwperrconst: String = 'Cannot watch constant value';
Const GDBwperrxen: String = 'Cannot enable watchpoint';
Const GDBwperrset: String = 'Unexpected error setting';
Const GDBwperrustd: String = 'Cannot understand watchpoint';
Const GDBwperrxs: String = 'Too many watchpoints';
Const GDBwpt: String = 'wpt=';
Const GDBwpta: String = 'hw-awpt=';
Const GDBwptr: String = 'hw-rwpt=';
Const GDBwptread: String = 'read watchpoint';
Const GDBwptacc: String = 'acc watchpoint';
Const GDBwpthw: String = 'hw watchpoint';
Const GDBwpoint: String = 'watchpoint';
Const GDBwpscope: String = 'watchpoint-scope';
Const GDBwpNum: String = 'wpnum=';
Const GDBwptrig: String = 'watchpoint-trigger';
Const GDBwptriga: String = 'access-watchpoint-trigger';
Const GDBwptrigr: String = 'read-watchpoint-trigger';
Const GDBqStrEmpty: String = '\"';
Const GDBwxString: String = 'wxString';
Const wxStringBase: String = '<wxStringBase>';
Const wpUnknown: String = '(unknown)';
Const FileStr: String = 'File';
Const FuncStr: String = 'Function';
Const LineStr: String = 'Line';
Const LinesStr: String = 'Lines';
Const NoDisasmStr: String = 'No disassembly available';
Const CPURegList: String = '0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15';
Const CPURegCount: Integer = 15;  // The number of values above - 1
//            If this is changed, alter TRegisters & ParseRegisterValues and the
//            arrays CPURegNames, CPURegValues to suit.
Const ExpandClasses: Boolean = True;
// set to false to treat contents of classes as string constants

Const HT: Char = #9;
Const LF: Char = #10;
Const CR: Char = #13;
Const NL: String = #13 + #10;
Const MAXSTACKDEPTH: Integer = 99;
// Arbitrary limit to the depth of stack that can
// be displayed, to prevent an infinite loop.
// The display gets silly and probably not useful
// long before this. A sensible limit is around 10 - 20
// This just flags a user warning and returns.
//  (N.B. For GDB, the request can limit the range returned)

Const
    PARSELIST = False;
    PARSETUPLE = True;
    INDENT = 3;                       // Amount of indentation of Locals display
    WATCHTOKENBASE = 9000;			// Token base for Watchpoint values
    MODVARTOKEN = 9998;
    TOOLTOKEN = 9999;

Type
    AssemblySyntax = (asATnT, asIntel);
    ContextData = (cdLocals, cdCallStack, cdWatches, cdThreads);
    ContextDataSet = Set Of ContextData;
    TCallback = Procedure(Output: TStringList) Of Object;

	   PList = ^TList;

    TWatchBreakOn = (wbRead, wbWrite, wbBoth);
	   PWatchPt = ^TWatchPt;
	   TWatchPt = Packed Record
		      Name: String;
		      Value: String;
		      BPNumber: Integer;
		      BPType: TWatchBreakOn;
		      Token: Longint;       // Last used Token - not necessarily unique!
		      Inactive: Boolean;    // Unused at present
		      Deleted: Boolean;     // deleted by GDB
	   End;

    ReadThread = Class(TThread)

    Public
        ReadChildStdOut: THandle;

    Protected

        Procedure Execute; Override;

        // called when the thread exits - whether it terminates normally or is
        // stopped with Delete() (but not when it is Kill()ed!)
        //  OnExit: procedure;

    End;

    TRegisters = Class
        EAX: String;
        EBX: String;
        ECX: String;
        EDX: String;
        ESI: String;
        EDI: String;
        EBP: String;
        ESP: String;
        EIP: String;
        EFLAGS: String;
        CS: String;
        DS: String;
        SS: String;
        ES: String;
        GS: String;
        FS: String;
    End;
    TRegistersCallback = Procedure(Registers: TRegisters) Of Object;
    TString = Class
    Public
        Str: String;
        Constructor Create(AStr: String);
    End;

    PBreakpoint = ^TBreakpoint;
    TBreakpoint = Class
    Public
        Index: Integer;
        Valid: Boolean;
        Editor: TEditor;
        Filename: String;
        Line: Integer;
        BPNumber: Integer;
    End;

    PStackFrame = ^TStackFrame;
    TStackFrame = Packed Record
        Filename: String;
        Line: Integer;
        FuncName: String;
        Args: String;
    End;

    PVariable = ^TVariable;
    TVariable = Packed Record
        Name: String;
        Value: String;
        Location: String;
    End;

// redundant ? 20110409
    PWatch = ^TWatch;

    TWatch = Packed Record
        Name: String;
        Address: String;
        BreakOn: TWatchBreakOn;
        ID: Integer;
    End;
// end redundant

	   PDebuggerThread = ^TDebuggerThread;
	   TDebuggerThread = Packed Record
		      Active: Boolean;
		      Index: String;
		      ID: String;
	   End;

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    TCommand = Class
    Public
        Data: TObject;
        Command: String;
        Callback: Procedure Of Object;
        OnResult: Procedure(Output: TStringList) Of Object;
    End;

    PCommand = ^TCommand;

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    PCommandWithResult = ^TCommandWithResult;
    TCommandWithResult = Class(TCommand)
    Public
        Constructor Create;
        Destructor Destroy; Override;
    Public
        Event: THandle;
        Result: TStringList;
    End;

    ////////////////////////////////////
    // TDebugger
    /////////////////////////////////
    TDebugger = Class

    Public
        handle: THandle;

        Constructor Create; Virtual;
        Destructor Destroy; Override;
        Procedure Launch(commandline, startupdir: String); Virtual;
        Procedure Execute(filename, arguments: String); Virtual; Abstract;
        Procedure DisplayError(s: String);
        Procedure CreateChildProcess(ChildCmd: String;
            StdIn: THandle; StdOut: THandle; StdErr: THandle);
        Procedure QueueCommand(command, params: String); Overload; Virtual;
        Procedure QueueCommand(command: TCommand); Overload; Virtual;
        Procedure SendCommand; Virtual;
		      Function KillProcess(PID: DWORD): Boolean;
        Procedure CloseDebugger(Sender: TObject); Virtual;

    Private
        Token: Longint;

    Protected
        fBusy: Boolean;
        fPaused: Boolean;
        fExecuting: Boolean;
        fDebugTree: TListView;
        fNextBreakpoint: Integer;
        IncludeDirs: TStringList;
        IgnoreBreakpoint: Boolean;
        JumpToCurrentLine: Boolean;

        hInputWrite: THandle;
        hOutputRead: THandle;
        hPid: THandle;

        SentCommand: Boolean;
        CurrentCommand: TCommand;
        CommandQueue: TList;

        FileName: String;
        Event: THandle;
        Reader: ReadThread;
        CurOutput: TStringList;
		      TargetPID: Integer;
		      DebuggerPID: DWORD;

        Procedure OnOutput(Output: String); Virtual; Abstract;

        Function GetBreakpointFromIndex(index: Integer): TBreakpoint;

        //Instruction callbacks
        Procedure OnGo;

        //Common events
        Procedure OnNoDebuggingSymbolsFound;
        Procedure OnAccessViolation;
        Procedure OnBreakpoint;

    Published
        Property Busy: Boolean Read fBusy;
        Property Executing: Boolean Read fExecuting;
        Property Paused: Boolean Read fPaused;
        Property DebugTree: TListView Read fDebugTree Write fDebugTree;

    Public

        //Callback functions
        OnVariableHint: Procedure(Hint: String) Of Object;
        OnDisassemble: Procedure(Disassembly: String) Of Object;
        OnRegisters: Procedure(Registers: TRegisters) Of Object;
        OnCallStack: Procedure(Callstack: TList) Of Object;
        OnThreads: Procedure(Threads: TList) Of Object;
        OnLocals: Procedure(Locals: TList) Of Object;

        //Debugger basics
        Procedure Attach(pid: Integer); Virtual; Abstract;
        Procedure SetAssemblySyntax(syntax: AssemblySyntax); Virtual; Abstract;

        //Breakpoint handling
        Procedure AddBreakpoint(breakpoint: TBreakpoint); Virtual; Abstract;
        Procedure RemoveBreakpoint(breakpoint: TBreakpoint); Virtual; Abstract;
        Procedure RemoveAllBreakpoints;
        Procedure RefreshBreakpoints;
        Procedure RefreshWatches; Virtual; Abstract;
        Procedure RefreshBreakpoint(Var breakpoint: TBreakpoint);
            Virtual; Abstract;
        Function BreakpointExists(filename: String; line: Integer): Boolean;
		      Procedure LoadAllWatches; Virtual; Abstract;
		      Procedure ReLoadWatches; Virtual; Abstract;
		      Procedure GetWatchedValues; Virtual;
		      Procedure AddWatch(VarName: String; when: TWatchBreakOn); Virtual;
		      Procedure RemoveWatch(node: TTreenode); Virtual;
		      Procedure ModifyVariable(VarName: String; Value: String); Virtual;

        Procedure ReplaceWxStr(Str: PString); Virtual;


        //Debugger control funtions
        Procedure Go; Virtual; Abstract;
        Procedure Pause; Virtual;
        Procedure Next; Virtual; Abstract;
        Procedure Step; Virtual; Abstract;
        Procedure Finish; Virtual; Abstract;
        Procedure SetThread(thread: Integer); Virtual; Abstract;
        Procedure SetFrame(frame: Integer); Virtual; Abstract;
        Function GetVariableHint(name: String): String; Virtual; Abstract;

        // Debugger virtual functions
        Procedure FirstParse; Virtual;
        Procedure ExitDebugger; Virtual;
        Procedure WriteToPipe(Buffer: String); Virtual;
        Procedure AddToDisplay(Msg: String); Virtual;

        //Source lookup directories
        Procedure AddIncludeDir(s: String); Virtual; Abstract;
        Procedure ClearIncludeDirs; Virtual; Abstract;

        //Variable watches
        Procedure RefreshContext(refresh: ContextDataSet =
            [cdLocals, cdCallStack, cdWatches, cdThreads]);
            Virtual; Abstract;
//        procedure AddWatch(varname: string; when: TWatchBreakOn);
//            virtual; abstract;
//        procedure RemoveWatch(varname: string); virtual; abstract;
//        procedure ModifyVariable(varname, newvalue: string); virtual; abstract;

        //Low-level stuff
        Procedure GetRegisters; Virtual; Abstract;
        Procedure Disassemble; Overload;
        Procedure Disassemble(func: String); Overload; Virtual; Abstract;
    End;

    ////////////////////////////////////
    // TGDBDebugger
    /////////////////////////////////
    TGDBDebugger = Class(TDebugger)

        Constructor Create; Override;
        Destructor Destroy; Override;

    Protected
        OverrideHandler: TCallback;
        RegistersFilled: Integer;
        Registers: TRegisters;
		      CPURegNames: Array[0..15] Of String;
		      CPURegValues: Array[0..15] Of String;
        LastWasCtrl: Boolean;
        Started: Boolean;
		      LastVOident: String;
		      LastVOVar: String;
		      WatchPtList: TTreeView;
		      CurrentGDBThread: Integer;			// as reported by GDB - presently unused
		      SelectedFrame: Integer;			// selected by user - defaults to 0
		      SelectedThread: Integer;			// selected by user - defaults to CurrentGDBThread
        // Pipe handles
        g_hChildStd_IN_Wr: THandle;		//we write to this
        g_hChildStd_IN_Rd: THandle;		//Child process reads from here
        g_hChildStd_OUT_Wr: THandle;		//Child process writes to this
        g_hChildStd_OUT_Rd: THandle;		//we read from here

    Protected
        Procedure OnOutput(Output: String); Override;
        Procedure OnSignal(Output: TStringList);
        Procedure OnSourceMoreRecent;

        //Instruction callbacks
        Procedure OnGo;
        Procedure OnTrace;

        //Parser callbacks
        Procedure OnRefreshContext(Output: TStringList);
        Procedure OnVariableHint(Output: TStringList);
        Procedure OnDisassemble(Output: TStringList);
        Procedure OnCallStack(Output: TStringList);
        Procedure OnRegisters(Output: TStringList);
        Procedure OnThreads(Output: TStringList);
        Procedure OnLocals(Output: TStringList);
      //  procedure OnWatchesSet(Output: TStringList);

        Procedure FillBreakpointNumber(SrcFile: PString; Line: Integer; Num: Integer);

    Public
        //Debugger control
        Procedure Attach(pid: Integer); Override;

        // Debugger virtual functions
        Procedure FirstParse; Override;
        Procedure ExitDebugger; Override;
        Procedure WriteToPipe(Buffer: String); Override;
        Procedure AddToDisplay(Msg: String); Override;

        Procedure Launch(commandline, startupdir: String); Override;
        Procedure Execute(filename, arguments: String); Override;

        Procedure Cleanup;
		      Procedure CloseDebugger(Sender: TObject); Override;
		      Function Notify(buf: Pchar; bsize: PLongInt; verbose: Boolean): Pchar;
        Procedure SendCommand; Override;
		      Function WriteGDBContext(thread: Integer; frame: Integer): String;
        Function SendToDisplay(buf: Pchar; bsize: PLongInt;
            verbose: Boolean): Pchar;

        //Set the include paths
        Procedure AddIncludeDir(s: String); Override;
        Procedure ClearIncludeDirs; Override;

        //Override the breakpoint handling
        Procedure AddBreakpoint(breakpoint: TBreakpoint); Override;
        Procedure RemoveBreakpoint(breakpoint: TBreakpoint); Override;
        Procedure RefreshBreakpoint(Var breakpoint: TBreakpoint); Override;
//        procedure RefreshWatches; override;

        //Variable watches
        Procedure RefreshContext(refresh: ContextDataSet =
            [cdLocals, cdCallStack, cdWatches,
            cdThreads]); Override;
        Procedure AddWatch(varname: String; when: TWatchBreakOn); Override;

		      Procedure LoadAllWatches; Override;
		      Procedure ReLoadWatches; Override;
		      Procedure RemoveWatch(node: TTreenode); Override;
		      Procedure GetWatchedValues; Override;
		      Procedure FillWatchValue(Msg: String);
		      Procedure FillTooltipValue(Msg: String);
		      Procedure ModifyVariable(VarName: String; Value: String); Override;

        // Parser functions
        Function GetToken(buf: Pchar; bsize: PLongInt;
            Token: PInteger): Pchar;
        Function FindFirstChar(Str: String; c: Char): Integer;
        Function Result(buf: Pchar; bsize: PLongInt): Pchar;
        Function ExecResult(buf: Pchar; bsize: PLongInt): Pchar;
        Function breakOut(Next: PPChar; bsize: PLongInt): String;
        Function ParseConst(Msg: PString; Vari: PString;
            Value: PString): Boolean; Overload;
        Function ParseConst(Msg: PString; Vari: PString;
            Value: PInteger): Boolean; Overload;
        Function ParseConst(Msg: PString; Vari: PString;
            Value: PBoolean): Boolean; Overload;
		      Function ExtractLocals(Str: PString): String;
		      Function ParseResult(Str: PString; Level: Integer; List: TList): String;
		      Function ExtractList(Str: PString; Tuple: Boolean; Level: Integer; List: TList): String;
		      Function ParseValue(Str: PString; Level: Integer; List: TList): String;
        Function SplitResult(Str: PString; Vari: PString): String;
        Function ExtractWxStr(Str: PString): String;
		      Procedure ReplaceWxStr(Str: PString); Override;
        Function ExtractBracketed(Str: PString; start: Pinteger;
            next: PInteger; c: Char; inclusive: Boolean): String;
        Function ExtractNamed(Src: PString; Target: PString;
            count: Integer): String;
		      Function ParseVObjCreate(Msg: String): Boolean;
		      Function ParseVObjAssign(Msg: String): Boolean;
        Procedure ParseWatchpoint(Msg: String);
        Procedure ParseWatchpointError(Msg: String);

		      Procedure ParseBreakpoint(Msg: String; List: PList);
		      Procedure ParseBreakpointTable(Msg: String);
		      Procedure ParseCPUDisassem(Msg: String);
		      Function ParseCPUMixedMode(List: String): String;
		      Function ParseCPUDisasmMode(List: String; CurrentFuncName: PString): String;
		      Procedure ParseRegisterNames(Msg: String);
		      Procedure ParseRegisterValues(Msg: String);
		      Procedure ParseCPUMemory(Msg: String);
        Procedure ParseStack(Msg: String);
        Function ParseFrame(Msg: String; Frame: PStackFrame): String;
        Procedure ParseThreads(Msg: String);
        Procedure WatchpointHit(Msg: PString);
        Procedure BreakpointHit(Msg: PString);
        Procedure StepHit(Msg: PString);
		      Procedure WptScope(Msg: PString);
        Procedure SigRecv(Msg: PString);

        //Debugger control
        Procedure Go; Override;
        Procedure Next; Override;
        Procedure Step; Override;
        Procedure Finish; Override;
        Procedure Pause; Override;
        Procedure SetThread(thread: Integer); Override;
        Procedure SetFrame(frame: Integer); Override;
        Function GetVariableHint(name: String): String; Override;

        //Low-level stuff
        Procedure GetRegisters; Override;
        Procedure Disassemble(func: String); Overload; Override;
        Procedure SetAssemblySyntax(syntax: AssemblySyntax); Override;
    End;

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    TCDBDebugger = Class(TDebugger)
        Constructor Create; Override;
        Destructor Destroy; Override;

    Protected
        LocalsList: TList;
        Procedure OnOutput(Output: String); Override;

        //Instruction callbacks
        Procedure OnTrace;

        //Parser callbacks
        Procedure OnBreakpointSet(Output: TStringList);
        Procedure OnRefreshContext(Output: TStringList);
        Procedure OnVariableHint(Output: TStringList);
        Procedure OnDisassemble(Output: TStringList);
        Procedure OnCallStack(Output: TStringList);
        Procedure OnRegisters(Output: TStringList);
        Procedure OnThreads(Output: TStringList);
        Procedure OnLocals(Output: TStringList);
        Procedure OnDetailedLocals(Output: TStringList);

    Public
        //Run the debugger
        Procedure Attach(pid: Integer); Override;
        Procedure Execute(filename, arguments: String); Override;

        //Set the include paths
        Procedure AddIncludeDir(s: String); Override;
        Procedure ClearIncludeDirs; Override;

        //Override the breakpoint handling
        Procedure AddBreakpoint(breakpoint: TBreakpoint); Override;
        Procedure RemoveBreakpoint(breakpoint: TBreakpoint); Override;
        Procedure RefreshBreakpoint(Var breakpoint: TBreakpoint); Override;
        Procedure RefreshWatches; Override;

        //Variable watches
        Procedure RefreshContext(refresh: ContextDataSet =
            [cdLocals, cdCallStack, cdWatches, cdThreads]); Override;
        Procedure AddWatch(varname: String; when: TWatchBreakOn); Override;
        //procedure RemoveWatch(varname: string); override;

        //Debugger control
        Procedure Go; Override;
        Procedure Next; Override;
        Procedure Step; Override;
        Procedure Finish; Override;
        Procedure SetThread(thread: Integer); Override;
        Procedure SetFrame(frame: Integer); Override;
        Function GetVariableHint(name: String): String; Override;

        // Debugger virtual functions
        Procedure FirstParse; Override;
        Procedure ExitDebugger; Override;
        Procedure WriteToPipe(Buffer: String); Override;
        Procedure AddToDisplay(Msg: String); Override;

        //Low-level stuff
        Procedure GetRegisters; Override;
        Procedure Disassemble(func: String); Overload; Override;
    End;

Var
    Breakpoints: TList;

Implementation

Uses
    devcfg, Forms, madExcept, main, MultiLangSupport,
    prjtypes, RegExpr, //dbugintf,  EAB removed Gexperts debug stuff.
    StrUtils, utils;

Procedure ReadThread.Execute;

Var
    BufMem: Pchar;           // The originally allocated memory (pointer 'buf' gets moved!)
    BytesAvailable: DWORD;
    PipeBufSize: DWORD;
    BytesToRead: DWORD;
    LastRead: DWORD;
    BufType: DWORD;
    TotalBytesRead: DWORD;
    ReadSuccess: Boolean;

    Buffer: String;


Begin

    buf := Nil;
    BytesAvailable := 0;
    BytesToRead := 0;
    LastRead := 0;
    TotalBytesRead := 0;

    While (Not Terminated) Do
    Begin
        Sleep(100);       // Give other processes some time

        PeekNamedPipe(ReadChildStdOut, Nil, 0, Nil, @BytesAvailable, @BytesToRead);

                        // Poll the pipe buffer
        If ((BytesAvailable > 0) And (buf = Nil)) Then
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
        Begin
			         If (MainForm.VerboseDebug.Checked) Then
			         Begin
				            Buffer := 'PeekPipe bytes available: ' + IntToStr(BytesAvailable);
				//gui_critSect.Enter();               // Maybe needed while debugging
				            MainForm.fDebugger.AddtoDisplay(Buffer);
				//gui_critSect.Leave();               // Maybe needed while debugging
			         End;

            Try
			             BufMem := AllocMem(BytesAvailable + 16);
                                                          // bump it up just to give some in hand
                                                          // in case we screw up the count!
                                                          // NOTE: WE do not free the memory
                                                          // but rely on it being freed externally.

			             ReadSuccess := ReadFile(ReadChildStdOut, BufMem^, BytesAvailable, LastRead, Nil);
			             If (ReadSuccess) Then
			             Begin

{$ifdef DISPLAYOUTPUT}
				Buffer := 'Readfile (Pipe) bytes read: ' + IntToStr(LastRead);
				// gui_critSect.Enter();               // Maybe needed while debugging
				MainForm.fDebugger.AddtoDisplay(Buffer);
				// gui_critSect.Leave();               // Maybe needed while debugging
{$endif}
                    Sleep(5);                              // Allow the pipe to refill
                    TotalBytesRead := LastRead;
                    PeekNamedPipe(ReadChildStdOut, Nil, 0, Nil, @BytesAvailable, @BytesToRead);
                    While (BytesAvailable > 0) Do
                    Begin
                        ReAllocMem(BufMem, TotalBytesRead + BytesAvailable + 16);
                        ReadSuccess := ReadSuccess And
                            ReadFile(ReadChildStdOut, (BufMem + TotalBytesRead)^, BytesAvailable, LastRead, Nil);

{$ifdef DISPLAYOUTPUT}
				Buffer := 'Readfile (Pipe) bytes read: ' + IntToStr(LastRead);
				// gui_critSect.Enter();               // Maybe needed while debugging
				MainForm.fDebugger.AddtoDisplay(Buffer);
				// gui_critSect.Leave();               // Maybe needed while debugging
{$endif}

                        TotalBytesRead := TotalBytesRead + LastRead;
                        Sleep(5);                              // Allow the pipe to refill
                        PeekNamedPipe(ReadChildStdOut, Nil, 0, Nil, @BytesAvailable, @BytesToRead);
                    End;
                    If ((LastRead > 0) And (ReadSuccess)) Then
                    Begin
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
                    End;
                End;  // of Readfile
            Except
                on EOutOfMemory Do
                    MainForm.fDebugger.DisplayError('Unable to allocate memory to read Debugger output');
            End;
        End;  // ... of main loop

    End;    // ... of while(Terminated)

End;

//=============================================================
Constructor TCommandWithResult.Create;
Begin
    Event := CreateEvent(Nil, False, False, Nil);
    Result := TStringList.Create;
End;

Destructor TCommandWithResult.Destroy;
Begin
    CloseHandle(Event);
    Result.Free;
End;

Constructor TString.Create(AStr: String);
Begin
    Str := AStr;
End;

Function GenerateCtrlCEvent(PGenerateConsoleCtrlEvent: Pointer): DWORD;
    Stdcall;
Begin
    Result := 0;
    If PGenerateConsoleCtrlEvent <> Nil Then
    Begin
        Asm
            //Call assembly code! We just want to get the console function thingo
            PUSH 0;
            PUSH 0;
            CALL PGenerateConsoleCtrlEvent;
        End;
        Result := 1;
    End;
End;

//////////////////////////////////////////
// TDebugger
/////////////////////////////////////////
Constructor TDebugger.Create;
Begin
    CurOutput := TStringList.Create;
    SentCommand := False;
    fExecuting := False;

    JumpToCurrentLine := False;
    CommandQueue := TList.Create;
    IncludeDirs := TStringList.Create;
    FileName := '';
    Event := CreateEvent(Nil, False, False, Nil);

    buf := Nil;
    bytesInBuffer := 0;

End;

//=============================================================

Procedure TDebugger.GetWatchedValues;
Begin
End;

Procedure TDebugger.AddWatch(VarName: String; when: TWatchBreakOn);
Begin
End;

Procedure TDebugger.RemoveWatch(node: TTreenode);
Begin
End;

Procedure TDebugger.ModifyVariable(VarName: String; Value: String);
Begin
End;

Procedure TDebugger.ReplaceWxStr(Str: PString);
Begin
End;

Procedure TDebugger.Launch(commandline, startupdir: String);
Begin
End;

//=============================================================

Destructor TDebugger.Destroy;
Begin

    If (buf <> Nil) Then
        FreeMem(buf);

    CloseDebugger(Nil);
    CloseHandle(Event);
    RemoveAllBreakpoints;

    CurOutput.Free;
    CommandQueue.Free;
    IncludeDirs.Free;

    Inherited Destroy;
End;

//=============================================================
Function TDebugger.KillProcess(PID: DWORD): Boolean;
// returns 'TRUE' on success
Var
	   hProc: THandle;

Begin
	   KillProcess := False;
	   hProc := OpenProcess(PROCESS_TERMINATE, False, PID);
	   If (Not (hProc = 0)) Then
	   Begin
		      If (TerminateProcess(hProc, 0)) Then
			     Begin
// 				process terminated
				        CloseHandle(hProc);
				        KillProcess := True;
			     End;
    End;
End;

//=============================================================

Procedure TDebugger.RemoveAllBreakpoints;
Var
    I: Integer;
Begin
    For I := 0 To Breakpoints.Count - 1 Do
        RemoveBreakpoint(Breakpoints[I]);
End;

//=============================================================

Procedure TDebugger.RefreshBreakpoints;
Var
    I: Integer;
Begin
    //Refresh the execution breakpoints
    For I := 0 To Breakpoints.Count - 1 Do
        RefreshBreakpoint(PBreakPoint(Breakpoints.Items[I])^);
End;

//=============================================================

Procedure TDebugger.CloseDebugger(Sender: TObject);

Begin

End;

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

Procedure TDebugger.QueueCommand(command, params: String);
Var
    Combined: String;
    Cmd: TCommand;
Begin
    //Combine the strings to get the final command
    Combined := command;
    If Length(params) > 0 Then
        Combined := Combined + ' ' + params;

    //Create the command object
    Cmd := TCommand.Create;
    Cmd.Command := Combined;
    Cmd.Callback := Nil;
    QueueCommand(Cmd);
End;

//=============================================================

Procedure TDebugger.QueueCommand(command: TCommand);
Var
    Ptr: PCommand;
Begin
    //Copy the object
    New(Ptr);
    Ptr^ := command;
    Command.Command := Command.Command;

    //Add it into our list of commands
    CommandQueue.Add(Ptr);

    //Can we execute the command now?
    If Executing And Paused Then
        SendCommand;
End;

//=============================================================

Procedure TDebugger.SendCommand;
Begin
End;

//=============================================================

Procedure TDebugger.OnGo;
Begin
    fPaused := False;
End;

//=============================================================

// Debugger virtual functions
Procedure TDebugger.FirstParse;
Begin
End;

Procedure TDebugger.ExitDebugger;
Begin
End;

Procedure TDebugger.WriteToPipe(Buffer: String);
Begin
End;

Procedure TDebugger.AddToDisplay(Msg: String);
Begin
End;

//=============================================================

Procedure TDebugger.CreateChildProcess(ChildCmd: String; StdIn: THandle;
    StdOut: THandle; StdErr: THandle);

// Create a child process that uses the handles to previously created pipes
//   for STDIN and STDOUT.
Var
    piProcInfo: PROCESS_INFORMATION;
    siStartInfo: STARTUPINFO;
    bSuccess: Boolean;

Begin

    // Set up members of the PROCESS_INFORMATION structure.
    ZeroMemory(@piProcInfo, SizeOf(PROCESS_INFORMATION));

    // Set up members of the STARTUPINFO structure.
    // This structure specifies the STDIN and STDOUT handles for redirection.

    ZeroMemory(@siStartInfo, sizeof(STARTUPINFO));
    siStartInfo.cb := SizeOf(STARTUPINFO);
    siStartInfo.hStdError := StdErr;
    siStartInfo.hStdOutput := StdOut;
    siStartInfo.hStdInput := StdIn;
    siStartInfo.dwFlags := siStartInfo.dwFlags Or STARTF_USESTDHANDLES;

    // Hide child window
    siStartInfo.dwFlags := siStartInfo.dwFlags Or STARTF_USESHOWWINDOW;
    //   siStartInfo.wShowWindow = siStartInfo.wShowWindow |= SW_SHOWDEFAULT; //SW_HIDE;
    siStartInfo.wShowWindow := SW_HIDE;

    // Create the child process.

    bSuccess := CreateProcess(Nil,
        Pchar(ChildCmd),          // command line
        Nil,                      // process security attributes
        Nil,                      // primary thread security attributes
        True,                     // handles are inherited
        0,                        // creation flags
        Nil,                      // use parent's environment
        Nil,                      // use parent's current directory
        siStartInfo,              // STARTUPINFO pointer
        piProcInfo);              // receives PROCESS_INFORMATION

    // If an error occurs, exit the application.
    If (Not bSuccess) Then
        DisplayError('Cannot create process: ' + ChildCmd)
    // WARNING ! ! ! Delphi gives a Thread error: The handle is invalid (6)
    //               if the child's _Command Line_ is invalid  ! ! !
    Else
    Begin
        // Close handles to the child process and its primary thread.
	       // Some applications might keep these handles to monitor the status
	       // of the child process, for example.

        CloseHandle(piProcInfo.hProcess);
        CloseHandle(piProcInfo.hThread);
		      DebuggerPID := piProcInfo.dwProcessId;
        fExecuting := True;
        fPaused := True;
    End;
End;

//=============================================================

Procedure TDebugger.DisplayError(s: String);
Begin
    MessageDlg('Error with debugging process: ' + s, mtError,
        [mbOK], Mainform.Handle);
End;

//=============================================================

Procedure TDebugger.OnNoDebuggingSymbolsFound;
Var
    opt: TCompilerOption;
    idx: Integer;
    spos: Integer;
    opts: TProjProfile;

Begin
    If MessageDlg(Lang[ID_MSG_NODEBUGSYMBOLS], mtConfirmation,
        [mbYes, mbNo], 0) = mrYes Then
    Begin
        CloseDebugger(Nil);
        If ((devCompiler.CompilerType = ID_COMPILER_MINGW) Or
            (devCompiler.CompilerType = ID_COMPILER_LINUX)) Then
        Begin
            If devCompiler.FindOption('-g3', opt, idx) Then
            Begin
                opt.optValue := 1;
                If Not Assigned(MainForm.fProject) Then
                    devCompiler.Options[idx] := opt;
                // set global debugging option only if not working with a project
                MainForm.SetProjCompOpt(idx, True);
                // set the project's correpsonding option too

                // remove "-s" from the linker''s command line
                If Assigned(MainForm.fProject) Then
                Begin
                    opts := MainForm.fProject.CurrentProfile;
                    // look for "-s" in all the possible ways
                    // NOTE: can't just search for "-s" because we might get confused with
                    //       some other option starting with "-s...."
                    spos := Pos('-s ', opts.Linker); // following more opts
                    If spos = 0 Then
                        spos := Pos('-s'#13, opts.Linker); // end of line
                    If spos = 0 Then
                        spos := Pos('-s_@@_', opts.Linker);
                    // end of line (dev 4.9.7.3+)
                    If (spos = 0) And (Length(opts.Linker) >= 2) And
                        // end of string
                        (Copy(opts.Linker, Length(opts.Linker) - 1, 2) =
                        '-s') Then
                        spos := Length(opts.Linker) - 1;

                    // if found, delete it
                    If spos > 0 Then
                        Delete(opts.Linker, spos, 2);

                End;

                // remove "--no-export-all-symbols" from the linker''s command line
                If Assigned(MainForm.fProject) Then
                Begin
                    opts := MainForm.fProject.CurrentProfile;
                    // look for "--no-export-all-symbols"
                    spos := Pos('--no-export-all-symbols', opts.Linker);
                    // following more opts
                    // if found, delete it
                    If spos > 0 Then
                        Delete(opts.Linker, spos,
                            length('--no-export-all-symbols'));

                End;

                // remove -s from the compiler options
                If devCompiler.FindOption('-s', opt, idx) Then
                Begin
                    opt.optValue := 0;
                    If Not Assigned(MainForm.fProject) Then
                        devCompiler.Options[idx] := opt;
                    // set global debugging option only if not working with a project
                    MainForm.SetProjCompOpt(idx, False);
                    // set the project's correpsonding option too
                End;
            End;
        End
        Else
        If devCompiler.CompilerType In ID_COMPILER_VC Then
            If devCompiler.FindOption('/ZI', opt, idx) Then
            Begin
                opt.optValue := 1;
                If Not Assigned(MainForm.fProject) Then
                    devCompiler.Options[idx] := opt;
                MainForm.SetProjCompOpt(idx, True);
                MainForm.fProject.CurrentProfile.Linker :=
                    MainForm.fProject.CurrentProfile.Linker + '/Debug';
            End;
        MainForm.Compiler.OnCompilationEnded := MainForm.doDebugAfterCompile;
        MainForm.actRebuildExecute(Nil);
    End;
End;

//=============================================================

Function TDebugger.BreakpointExists(filename: String; line: Integer): Boolean;
Var
    I: Integer;
Begin
    Result := False;
    For I := 0 To Breakpoints.Count - 1 Do
        If (PBreakpoint(Breakpoints[I])^.Filename = filename) And
            (PBreakpoint(Breakpoints[I])^.Line = line) Then
        Begin
            Result := True;
            Break;
        End;
End;

//=============================================================

Function TDebugger.GetBreakpointFromIndex(index: Integer): TBreakpoint;
Var
    I: Integer;
Begin
    Result := Nil;
    For I := 0 To Breakpoints.Count - 1 Do
        If PBreakpoint(Breakpoints[I])^.Index = index Then
        Begin
            Result := PBreakpoint(Breakpoints[I])^;
            Exit;
        End;
End;

//=============================================================

Procedure TDebugger.OnAccessViolation;
Begin
    Application.BringToFront;
    If (MessageDlg(Lang[ID_MSG_SEGFAULT], mtError, [mbOK],
        MainForm.Handle) = mrOK) Then
    Begin
        JumpToCurrentLine := True;
        CloseDebugger(Nil);
    End;

End;

//=============================================================

Procedure TDebugger.OnBreakpoint;
Begin
    Application.BringToFront;
    Case MessageDlg(Lang[ID_MSG_BREAKPOINT], mtError,
            [mbOK, mbIgnore, mbAbort], MainForm.Handle) Of
        mrIgnore:
            Go;
        mrAbort:
            CloseDebugger(Nil);
        mrOk:
            JumpToCurrentLine := True;
    End;
End;

//=============================================================

Procedure TDebugger.Disassemble;
Begin
    Disassemble('');
End;

Procedure TDebugger.Pause;
Const
    CodeSize = 1024;
Var
    Thread: THandle;
    BytesWritten, ThreadID, ExitCode: DWORD;
    WriteAddr: Pointer;
Begin
    WriteAddr := VirtualAllocEx(hPid, Nil, CodeSize, MEM_COMMIT,
        PAGE_EXECUTE_READWRITE);
    If WriteAddr <> Nil Then
    Begin
        WriteProcessMemory(hPid, WriteAddr, @GenerateCtrlCEvent,
            CodeSize, BytesWritten);
        If BytesWritten = CodeSize Then
        Begin
            //Create and run the thread
            Thread := CreateRemoteThread(hPid, Nil, 0, WriteAddr,
                GetProcAddress(LoadLibrary('kernel32.dll'),
                'GenerateConsoleCtrlEvent'),
                0, ThreadID);
            If Thread <> 0 Then
            Begin
                //Wait for its termination
                WaitForSingleObject(Thread, INFINITE);

                //And see if it succeeded
                GetExitCodeThread(Thread, ExitCode);
                If ExitCode <> 0 Then
                    //We've triggered a breakpoint, so yes, ignore it
                    IgnoreBreakpoint := True;

                //Destroy the thread
                CloseHandle(Thread);
            End;
        End;

        //Free the memory we injected
        VirtualFreeEx(hPid, WriteAddr, 0, MEM_RELEASE);
        // free the memory we allocated
    End;
End;

////////////////////////////////////////////

//------------------------------------------------------------------------------
// TGDBDebugger
//------------------------------------------------------------------------------
Function TGDBDebugger.ExtractNamed(Src: PString; Target: PString;
    count: Integer): String;

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

Var
    Temp: String;
    TargetLength: Integer;
    c: Char;
    s, e, l: Integer;
    m: Char;

Begin
    TargetLength := Length(Target^);
    c := AnsiLastChar(Target^)^;
    s := 1;                       // start index
    e := 1;                       // end index
    l := 0;                       // level of nesting
    m := #0;

    If (count = 0) Then
        ExtractNamed := Temp
    Else
    Begin
        Case (c) Of
            '{':
                m := '}';
            '[':
                m := ']';
            '"':
                m := '"';
        End;
        Temp := Src^;
        Repeat
            Begin

                Temp := AnsiMidStr(Temp, e - s + 1, Length(Temp) - e + s);
                s := AnsiPos(Target^, Temp);
                If (s = 0) Then
                Begin
                    Temp := '';
                    ExtractNamed := Temp;
                    break; //  return Temp;

                End;
                e := s + TargetLength - 1;
                While (e <= Length(Temp)) Do
                Begin
                    If (Temp[e] = c) Then
                        Inc(l)
                    Else
                    If (Temp[e] = m) Then
                    Begin
                        Dec(l);
                        If (l = 0) Then
                            break;
                    End;
                    Inc(e);
                End;
                Temp := AnsiRightStr(Temp, Length(Temp) - s + 1);
                Dec(count);
            End
        Until Not (count > 0);

        Temp := AnsiMidStr(Temp, TargetLength + 1, e - s - TargetLength);
        ExtractNamed := Temp;
    End;

End;

//=================================================================

Function TGDBDebugger.ParseConst(Msg: PString; Vari: PString;
    Value: PString): Boolean;
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

Var
    s: Integer;     // Start index of "Var"
    Sub: String;

Begin
    // Find our Variable
    s := AnsiPos(Vari^, Msg^);
    If (s = 0) Then
        ParseConst := False
    Else
    Begin
        Sub := AnsiRightStr(Msg^, Length(Msg^) - s);
        // Sub = OurVar="Value",....
        Sub := ExtractBracketed(@Sub, Nil, Nil, '"', False);
        // Remove quotes
        Sub := AnsiDequotedStr(Sub, '"');
        Value^ := Sub;
        ParseConst := True;
    End;
End;

//-----------------------------------------------------------------

Function TGDBDebugger.ParseConst(Msg: PString; Vari: PString;
    Value: PInteger): Boolean;
Var
    Val: String;
Begin

    If (ParseConst(Msg, Vari, PString(@Val)) = False) Then
        ParseConst := False
    Else
    Begin
        Value^ := StrToInt(Val);
        ParseConst := True;
    End;
End;

//-----------------------------------------------------------------

Function TGDBDebugger.ParseConst(Msg: PString; Vari: PString;
    Value: PBoolean): Boolean;
Var
    Val: String;
Begin
    If (ParseConst(Msg, Vari, PString(@Val)) = False) Then
        ParseConst := False
    Else
    Begin
        If ((Val = 'true') Or (Val = 'y')) Then
            Value^ := True
        Else
        If ((Val = 'false') Or (Val = 'n')) Then
            Value^ := False;
        ParseConst := True;
    End;
End;

//=================================================================

Function TGDBDebugger.ParseVObjCreate(Msg: String): Boolean;

//   Parses out simple Variable value
//   Does not work for compound variables: GDB returns {...}

Var
    Value: String;
    VarType: String;
    ValStrings: TStringList;
    Name: String;
    start: Integer;
    Ret: Boolean;
    Buffer, Output: String;

Begin

    start := 0;
    Ret := True;

    Name := ExtractBracketed(@Msg, @start, Nil, '"', False); // because 'name=' gets stripped off!

    Ret := Ret And ParseConst(@Msg, @GDBtype, PString(@VarType));


{/* If type=="wxString", do
    "-var-evaluate-expression -f natural var1.wxStringBase.protected.m_pchData"
   in stages to build the VO Tree.
   (The type when you get there is "const wxChar *"  and you get a pointer plus
   the string)
   The following works but we'd be better with the IDE to supply the name of the
   variable in question via LastVOVar.
 */}

    If (VarType = GDBwxString) Then
    Begin

        Buffer := '-var-info-path-expression ' + Name + NL;
        Buffer := Buffer + '-var-list-children 1 ' + Name + NL;
        Buffer := Buffer + '-var-list-children 1 ' + Name + '.wxStringBase' + NL;
        Buffer := Buffer + '-var-list-children 1 ' + Name + '.wxStringBase.protected' + NL;
        Buffer := Buffer + '-var-evaluate-expression -f natural ' + Name + '.wxStringBase.protected.m_pchData' + NL;
        WriteToPipe(Buffer);
        ParseVObjCreate := False;
    End
    Else
    Begin
        Ret := Ret And ParseConst(@Msg, @GDBvalue, PString(@Value));
        Ret := Ret And ParseConst(@Msg, @GDBNameq, PString(@LastVOident));

        ParseVObjCreate := False;
        If (Ret) Then            // If all 3 are found it probably was a VObj... but we can't prove it
        Begin
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
            ParseVObjCreate := True;
        End;
    End;
End;

//=================================================================

Function TGDBDebugger.ParseVObjAssign(Msg: String): Boolean;
{
/*
   Parses out Variable new value
   (also works for -data-evaluate-expression expr but will attach the name
    of the last VObj used to the output string unless LastVOVar has been set
    to 'expression' by the IDE).
*/
}
Var
    Value: String;
    ValStrings: TStringList;
    start: Integer;
    Buffer, Output: String;

Begin
    start := 0;

    Value := ExtractBracketed(@Msg, @start, Nil, '"', False); // because 'value' gets stripped off!

    ParseVObjAssign := False;
    If (start = 13) Then            // 13 = length('done,value=') - Most likely it was a VObj or expression value ... but we can't prove it
    Begin
    // Handle wxString
        start := Pos(wxStringBase, Value);
        If ((start < 6) And Not (start = 0)) Then
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
        ParseVObjAssign := True;
    End;
End;


//=================================================================

Procedure TGDBDebugger.FillTooltipValue(Msg: String);
{
/*
   Parses out the Tooltip value
*/
}
Var
    Value: String;
    ValStrings: TStringList;
    start: Integer;
    Output: String;

Begin
    start := 0;

    Value := ExtractBracketed(@Msg, @start, Nil, '"', False); // strip 'value'

    If (start = 13) Then            // 13 = length('done,value=')
    Begin
    // Handle wxString
        ReplaceWxStr(@Value);
        Value := OctToHex(@Value);
        Value := unescape(@Value);
        ValStrings := TStringList.Create;
        ValStrings.Add(Value);
        OnVariableHint(ValStrings);
        ValStrings.Clear;
        ValStrings.Free;
        If (MainForm.VerboseDebug.Checked) Then
        Begin
            Output := format('Tooltip has value %s', [Value]);
      // gui_critSect.Enter();
            AddtoDisplay(Output);
      // gui_critSect.Leave();
        End;
    End;
End;

//=================================================================

Procedure TGDBDebugger.ParseBreakpoint(Msg: String; List: PList);
{

   Part of Third Level Parse of Output.

}
Var

    Num: Integer;
    BPType: String;
    SrcFile: String;
    Line: Integer;
    Expr: String;
    Addr: String;
    Vari: PWatchVar;

    Output: String;
    {Ret: Boolean;}

Begin
    Num := 0;
    Line := 0;
    {Ret := false;}

    {Ret := }ParseConst(@Msg, @GDBnumber, PInteger(@Num));
    {Ret := }ParseConst(@Msg, @GDBtype, PString(@BPType));

    If (BPType = GDBbpoint) Then
    Begin
        ParseConst(@Msg, @GDBaddr, PString(@Addr));
        If (ParseConst(@Msg, @GDBorig_loc, PString(@SrcFile)) And (Addr = GDBmult)) Then
            Output := format('Breakpoint No %d set at multiple addresses at %s', [Num, SrcFile])
        Else
        Begin
			         ParseConst(@Msg, @GDBline, PInteger(@Line));
			         ParseConst(@Msg, @GDBfile, PString(@SrcFile));
			         Output := format('Breakpoint No %d set at line %d in %s', [Num, Line, SrcFile]);
            FillBreakpointNumber(@SrcFile, Line, Num);
        End;
        If (MainForm.VerboseDebug.Checked) Then
		      Begin
			// gui_critSect.Enter();
			         AddtoDisplay(Output);
			// gui_critSect.Leave();
		      End;
    End
    Else
    Begin
		{Ret := }ParseConst(@Msg, @GDBwhat, PString(@Expr));
		      If (BPType = GDBwptread) Then
			         Output := format('Watchpoint No %d (read) set for %s', [Num, Expr]);
		      If (BPType = GDBwptacc) Then
			         Output := format('Watchpoint No %d (acc) set for %s', [Num, Expr]);
		      If (BPType = GDBwpthw) Then
			         Output := format('Watchpoint No %d (hw)  set for %s', [Num, Expr]);
		      If (BPType = GDBwpoint) Then
			         Output := format('Watchpoint No %d set for %s', [Num, Expr]);
        If (MainForm.VerboseDebug.Checked) Then
		      Begin
			// gui_critSect.Enter();
			         AddtoDisplay(Output);
			// gui_critSect.Leave();
		      End;
		      If Not (List = Nil) Then
		      Begin
			         New(Vari);
			         Vari.Name := format('%s', [Expr]);
			         Vari.Value := '';
			         List.Add(Vari);
		      End;
    End;
End;

//=================================================================

Procedure TGDBDebugger.ParseBreakpointTable(Msg: String);
{
   Part of Third Level Parse of Output.
}
Var
    N_rows, row: Integer;
    Str: String;
    BkptStr: String;
    {Ret: Boolean;}

Begin
    N_rows := 0;
    {Ret := false;}
    {Ret := }ParseConst(@Msg, @GDBnr_rows, PInteger(@N_rows));
    Str := ExtractNamed(@Msg, @GDBbody, 1);

    If (Not (Str = '')) Then
    Begin
        For row := 1 To N_rows Do
        Begin
            BkptStr := ExtractNamed(@Str, @GDBbkpt, row);
            ParseBreakpoint(BkptStr, Nil);
        End;
    End;

End;

//=================================================================

Procedure TGDBDebugger.AddWatch(VarName: String; when: TWatchBreakOn);
{
   Adds a watch variable/expression VarName to the TTreeView list,
   and to GDB's list.
   Uses token to allow us to identify our result when it is returned.
}
Var
    Watch: PWatchPt;
    Command: TCommand;
Begin
    With MainForm.WatchTree.Items.Add(Nil, VarName) Do
    Begin
        ImageIndex := 21;
        SelectedIndex := 21;
        New(Watch);
        Watch^.Name := varname;
        Watch^.Value := wpUnknown;
        Watch^.BPNumber := 0;
        Watch^.Deleted := False;
        Watch^.Token := WATCHTOKENBASE + MainForm.WatchTree.Items.Count - 1;
        Watch^.BPType := when;
        Data := Watch;
        Text := Watch^.Name + ' = ' + Watch^.Value;
    End;

    Command := TCommand.Create;
    Command.Data := Pointer(Watch);
    Case when Of
        wbRead:
            Command.Command := Format('%d%s%s -r %s',
                [Watch^.Token, GDBbrkwatch, WriteGDBContext(SelectedThread, SelectedFrame), varname]);
        wbWrite:
            Command.Command := Format('%d%s%s %s',
                [Watch^.Token, GDBbrkwatch, WriteGDBContext(SelectedThread, SelectedFrame), varname]);
        wbBoth:
            Command.Command := Format('%d%s%s -a %s',
                [Watch^.Token, GDBbrkwatch, WriteGDBContext(SelectedThread, SelectedFrame), varname]);
    End;
    QueueCommand(Command);
End;

//=================================================================

Procedure TGDBDebugger.LoadAllWatches;
{
   MUST ONLY BE CALLED ON GDB STARTUP

   Loads GDB with all the watches in the TTreeView list.
   Uses token to allow us to identify our returning result.
}
Var
    Watch: PWatchPt;
    Command: TCommand;
    index: Integer;
Begin
    With MainForm.WatchTree Do
        For index := 0 To Items.Count - 1 Do
        Begin
            Watch := Items[index].Data;
            Watch^.Value := wpUnknown;
            Watch^.BPNumber := 0;
            Watch^.Deleted := False;
            Watch^.Token := WATCHTOKENBASE + index;
            Items[index].Text := Watch^.Name + ' = ' + Watch^.Value;

            Command := TCommand.Create;
            Case Watch^.BPType Of
                wbRead:
                    Command.Command := Format('%d%s-r %s',
                        [Watch^.Token, GDBbrkwatch, Watch^.Name]);
                wbWrite:
                    Command.Command := Format('%d%d %s',
                        [Watch^.Token, GDBbrkwatch, Watch^.Name]);
                wbBoth:
                    Command.Command := Format('%d%d -a %s',
                        [Watch^.Token, GDBbrkwatch, Watch^.Name]);
            End;
            QueueCommand(Command);
        End;
End;

//=================================================================

Procedure TGDBDebugger.ReLoadWatches;
{
   Automatically reloads GDB with deleted watches.

   Loads GDB with all the watches flagged as 'deleted' in the TTreeView list.
   Uses token to allow us to identify our result when it is returned.
}
Var
    Watch: PWatchPt;
    Command: TCommand;
    index: Integer;
Begin
    With MainForm.WatchTree Do
        For index := 0 To Items.Count - 1 Do
        Begin
            Watch := Items[index].Data;
            If (Watch^.Deleted) Then
            Begin
                Watch^.Value := wpUnknown;
                Watch^.BPNumber := 0;
                Watch^.Deleted := False;
                Watch^.Token := WATCHTOKENBASE + index;
                Items[index].Text := Watch^.Name + ' = ' + Watch^.Value;

                Command := TCommand.Create;
                Case Watch^.BPType Of
                    wbRead:
                        Command.Command := Format('%d%s%s -r %s',
                            [Watch^.Token, GDBbrkwatch, WriteGDBContext(SelectedThread, SelectedFrame), Watch^.Name]);
                    wbWrite:
                        Command.Command := Format('%d%s%s %s',
                            [Watch^.Token, GDBbrkwatch, WriteGDBContext(SelectedThread, SelectedFrame), Watch^.Name]);
                    wbBoth:
                        Command.Command := Format('%d%s%s -a %s',
                            [Watch^.Token, GDBbrkwatch, WriteGDBContext(SelectedThread, SelectedFrame), Watch^.Name]);
                End;
                QueueCommand(Command);
            End;
        End;
End;

//=================================================================

Procedure TGDBDebugger.RemoveWatch(node: TTreenode);
{
    Removes a watch from the TTreeView list and from GDB's list.
}
Var
    Watch: PWatchPt;
    Command: TCommand;
Begin
    //while Assigned(node) and (Assigned(node.Parent)) do
    //  node := node.Parent;

    //Then clean it up
    If Assigned(node) Then
    Begin
        Watch := node.Data;
        If ((Watch.BPNumber = 0) And Not (Watch.Deleted)) Then
        Begin
            DisplayError('Internal Error: unable to identify Watchpoint');
            Exit;
        End;
        Command := TCommand.Create;
        Command.Command := Format('%s %d', [GDBbrkdel, watch.BPNumber]);
        QueueCommand(Command);
        Dispose(node.Data);
        MainForm.WatchTree.Items.Delete(node);
    End;
End;

//=================================================================

Procedure TGDBDebugger.GetWatchedValues;
{
    Part of Third Level Parse of Output.
    Reads a list of Watched variables in the WatchTree list and emits a request
    for the present values for each in the list.


    Uses token to allow us to identify our result when it is returned.
}

Var
    I: Integer;

    Watch: PWatchPt;
    Command: TCommand;

Begin
    With MainForm.WatchTree Do
        For I := 0 To (Items.Count - 1) Do
        Begin
            Watch := Items[I].Data;
            Watch.Token := WATCHTOKENBASE + I;
            Command := TCommand.Create;
            Command.Command := format('%d%s%s %s', [Watch.Token, GDBdataeval,
		              WriteGDBContext(SelectedThread, SelectedFrame), Watch.Name]);
            Command.Callback := Nil;
            QueueCommand(Command);
        End;

End;

//=================================================================

Procedure TGDBDebugger.FillWatchValue(Msg: String);
{
   Part of Third Level Parse of Output.
   Receives the result of a single "-data-evaluate-expression ..."
   identified by a designated token, and adds the variable value to the
   Watched variable in WachTree list.
}

Var
    Value: String;
    start: Integer;
    I: Integer;
    Watch: PWatchPt;

Begin
    Value := ExtractBracketed(@Msg, @start, Nil, '"', False); // must strip 'value'
    Value := OctToHex(@Value);
    ReplaceWxStr(@Value);
    I := Token - WATCHTOKENBASE;
    Watch := MainForm.WatchTree.Items[I].Data;
    Watch.Value := Value;
    MainForm.WatchTree.Items[I].Text :=
        Format('%s = %s', [Watch.Name, Watch.Value]);
    Token := 0;
End;

//=================================================================

Procedure TGDBDebugger.ParseStack(Msg: String);
{

   Part of Third Level Parse of Output.

}
Var
    level: Integer;
    FrameStr: String;
    Output: String;
    CallStack: TList;
    Frame: PStackFrame;
    I: Integer;

Begin
    level := 0;

    If (Not (Msg = '')) Then
    Begin
        CallStack := TList.Create;
        Repeat
            Begin
                Inc(level);
                New(Frame);
                FrameStr := ExtractNamed(@Msg, @GDBframe, level);
                If (FrameStr = '') Then
                    break;
                Output := ParseFrame(FrameStr, Frame);
                CallStack.Add(Frame);
                If (MainForm.VerboseDebug.Checked) Then
                    AddtoDisplay(Output);

            End
        Until (level >= MAXSTACKDEPTH);               // Arbitrary limit for safety!
        If (level = MAXSTACKDEPTH) Then
            If (MainForm.VerboseDebug.Checked) Then
            Begin
            // gui_critSect.Enter();
                AddtoDisplay('Stack is too deep, Aborting...');
            // gui_critSect.Leave();
            End;

        MainForm.OnCallStack(CallStack);

        Try
        { Cleanup: must free the list items as well as the list }
            For I := 0 To (CallStack.Count - 1) Do
            Begin
                Frame := CallStack.Items[I];
                Dispose(Frame);
            End;
        Finally
            CallStack.Free;
        End;
    End;
End;

//=================================================================

Function TGDBDebugger.ParseFrame(Msg: String; Frame: PStackFrame): String;
{
   Part of Third Level Parse of Output.
}
Var
    Level: Integer;
    Func: String;
    SrcFile: String;
    Line: Integer;

    Output: String;
    {Ret: Boolean;}
    SubOutput: String;
    SubOutput1: String;

Begin

    Level := 0;
    Line := 0;
    {Ret := false;}

    If (Not (Msg = '')) Then
    Begin

        Output := format('Stack Frame: %s', [Msg]);

        {Ret := }ParseConst(@Msg, @GDBlevel, PInteger(@Level));
        {Ret := }ParseConst(@Msg, @GDBfunc, PString(@Func));
        {Ret := }ParseConst(@Msg, @GDBline, PInteger(@Line));
        {Ret := }ParseConst(@Msg, @GDBfile, PString(@SrcFile));
        If Not (Frame = Nil) Then
        Begin
            Frame.Filename := ExtractFileName(SrcFile);
            Frame.FuncName := format('%*s%s', [Level, '', Func]);
            Frame.Line := Line;
            Frame.Args := '';
        End;

        If (Level = 0) Then
            SubOutput := 'Stopped in '
        Else
            SubOutput := 'called from';
        If (Line = 0) Then
            SubOutput1 := '<no line number>'
        Else
            SubOutput1 := format('at Line %d', [Line]);

        Output := format('Level %2d: %*s %s  %s  %s', [Level, Level + 1, ' ', SubOutput, Func, SubOutput1]);
    End;
    ParseFrame := Output;
End;

//=================================================================

Procedure TGDBDebugger.ParseThreads(Msg: String);
{
   Part of Third Level Parse of Output.
}
Var

    ThreadStr: String;
    ThreadList: String;
    CurrentThread: String;
    start: Integer;
    next: Integer;
    ThreadID: String;
    TargetID: String;
    Output: String;
    Threads: TList;
    Thread: PDebuggerThread;
    I: Integer;

Begin

	   Threads := TList.Create;

	   ParseConst(@Msg, @GDBcurthread, PString(@CurrentThread));
	   ThreadList := ExtractBracketed(@Msg, @start, @next, '[', False);
	   If (ThreadList = '') Then
	   Begin
		      CurrentGDBThread := 0;
        SelectedThread := 0;
        SelectedFrame := 0;
        // gui_critSect.Enter();
		      AddtoDisplay('No active threads');
        // gui_critSect.Leave();
	   End
	   Else
	   Begin
		// gui_critSect.Enter();
		      AddtoDisplay('Current Thread ID = ' + CurrentThread);
		// gui_critSect.Leave();
		      CurrentGDBThread := StrToInt(CurrentThread);
        SelectedThread := CurrentGDBThread;
        SelectedFrame := 0;
		      Repeat
		          Begin
			             ThreadStr := ExtractBracketed(@ThreadList, @start, @next, '{', False);
			             If (MainForm.VerboseDebug.Checked) Then
			             Begin
				// gui_critSect.Enter();
				                AddtoDisplay('Thread: ');
				                AddtoDisplay(ThreadStr);
				// gui_critSect.Leave();
			             End;
			             If (Not (ThreadStr = '')) Then
			             Begin
				                New(Thread);
				                ParseConst(@ThreadList, @GDBid, PString(@ThreadID));
				                ParseConst(@ThreadList, @GDBtargetid, PString(@TargetID));
				                If (MainForm.VerboseDebug.Checked) Then
				                Begin
					// gui_critSect.Enter();
					                   AddtoDisplay('Thread ID = ' + ThreadID);
					// gui_critSect.Leave();
				                End;

				                Output := ParseFrame(ThreadStr, Nil);
				                Threads.Insert(0, Thread);
				                With Thread^ Do
				                Begin
					                   Active := (ThreadId = CurrentThread);
					                   Index := ThreadId;
					                   ID := TargetID + '  ' + Output;
				                End;

			             End;
			             ThreadList := AnsiRightStr(ThreadList, Length(ThreadList) - next);
		          End
		      Until ((ThreadList = '') Or (next = 0));
	   End;

	   MainForm.OnThreads(Threads);

	   Try
      { Cleanup: must free the list items as well as the list }
	       For I := 0 To (Threads.Count - 1) Do
	       Begin
		          Thread := Threads.Items[I];
		          Dispose(Thread);
	       End;
	   Finally
		      Threads.Free;
	   End;

End;

//=================================================================

Procedure TGDBDebugger.ParseWatchpoint(Msg: String);
{
   Part of Third Level Parse of Output.

   Acknowledgement of watchpoint loaded by GDB.
   Updates the Watchpoint data record.
}
Var
    Num: Integer;
    Expr: String;

    Watch: PWatchPt;
    Output: String;
    index: Integer;
    {Ret: Boolean;}
Begin
    Num := 0;
    {Ret := false;}

    {Ret := }ParseConst(@Msg, @GDBnumber, PInteger(@Num));
    {Ret := }ParseConst(@Msg, @GDBexp, PString(@Expr));
    If ((Token >= WATCHTOKENBASE) And (Token < MODVARTOKEN)) Then
        With MainForm.WatchTree.Items Do
        Begin
            If Not (Count = 0) Then
            Begin
                For index := 0 To Count - 1 Do
                Begin
                    Watch := Item[index].Data;
                    If ((Watch.Name = Expr) And (Watch.BPNumber = 0)) Then
                    Begin
                        Watch.BPNumber := Num;
                        Watch.Inactive := False;
                        Watch.Deleted := False;
                        Item[index].Text := Format('%s = %s', [Watch.Name, Watch.Value]);
                    End;
                End;
            End;
        End;
    Token := 0;
    If (MainForm.VerboseDebug.Checked) Then
	   Begin
		      Output := format('Watchpoint No %d set for %s', [Num, Expr]);
		// gui_critSect.Enter();
		      AddtoDisplay(Output);
		// gui_critSect.Leave();
	   End;

End;

//=================================================================

Procedure TGDBDebugger.ParseWatchpointError(Msg: String);
{
   Part of Third Level Parse of Output.
   Handles errors accompanied by a Watchpoint Token.
   Updates and may delete the Watchpoint data record.
}
Var
    varname: String;
    watch: pWatchPt;
    index: Integer;

Begin
    // These messages were gathered from GDB source. Not all might be seen.
    If ((AnsiStartsStr(GDBError + GDBwperrnoimp, Msg))
        // "Expression cannot be implemented with read/access watchpoint."
        Or (AnsiStartsStr(GDBError + GDBwperrnosup, Msg))
        // "Target does not support this type of hardware watchpoint."
        Or (AnsiStartsStr(GDBError + GDBwperrsup, Msg))
        // "Target can only support one kind of HW watchpoint at a time."
        Or (AnsiStartsStr(GDBError + GDBwperrjunk, Msg))
        // "Junk at end of command."
        Or (AnsiStartsStr(GDBError + GDBwperrconst, Msg))
        // "Cannot watch constant value ..."
        Or (AnsiStartsStr(GDBError + GDBwperrxen, Msg))
        // "Cannot enable watchpoint"
        Or (AnsiStartsStr(GDBError + GDBwperrset, Msg))
        // "Unexpected error setting breakpoint or watchpoint"
        Or (AnsiStartsStr(GDBError + GDBwperrustd, Msg))
        // "Cannot understand watchpoint access type."
        Or (AnsiStartsStr(GDBError + GDBwperrxs, Msg))) Then
        // "Too many watchpoints"
    Begin
        index := Token - WATCHTOKENBASE;
        Watch := MainForm.WatchTree.Items[index].Data;
        Dispose(Watch);
        MainForm.WatchTree.Items[index].Delete;
        DisplayError('GDB Error: ' + Msg);
    End
    Else
    If (AnsiStartsStr(GDBError + GDBNoSymbol, Msg)) Then
    // It has gone out of scope or doesn't exist in present context
    Begin
      // Flag as deleted - it can be resurrected if/when it comes into scope
        varname := ExtractBracketed(@Msg, Nil, Nil, '"', False);
      // Find ALL watchpoints with a name starting with 'varname' and flag as deleted
        With MainForm.WatchTree Do
            For index := 0 To Items.Count - 1 Do
            Begin
                Watch := Items[index].Data;
                If (AnsiStartsStr(varname, Watch^.Name)) Then
                Begin
                    Watch^.Value := wpUnknown;
                    Watch^.BPNumber := 0;
                    Watch^.Token := 0;
                    Watch^.Deleted := True;
                    Items[index].Text := Watch^.Name + ' = ' + Watch^.Value;
                End;
            End;
    End
    Else
    Begin
      // It must be something else!
        DisplayError('GDB Error: ' + Msg);
{$ifdef DISPLAYOUTPUT}
      // gui_critSect.Enter();
      AddtoDisplay(Msg);
      // gui_critSect.Leave();
{$endif}
    End;
End;

//=================================================================

Procedure TGDBDebugger.ParseCPUMemory(Msg: String);
{
   Part of Third Level Parse of Output.
   Parses memory display and writes to a RichText edit window
   in the familiar 'Hex Editor' style.
}
Var
    MemList, List: String;
    memnext, next: Integer;
    i, j, b: Integer;
    displaystart, memstart, memend, mem: Int64;
    Smemstart, Smemend: String;
    MemContent: String;
    Output, AscChars: String;
    AscChar: Byte;

Begin
    MemList := ExtractBracketed(@Msg, Nil, @memnext, '[', False);
    Repeat
        Begin
            List := ExtractBracketed(@MemList, Nil, @next, '{', False);
            If (Not (List = '')) Then
            Begin
                ParseConst(@List, @GDBbegin, PString(@Smemstart));
                ParseConst(@List, @GDBend, PString(@Smemend));
                ParseConst(@List, @GDBcontents, PString(@MemContent));
                memstart := StrToInt64(Smemstart);
                memend := StrToInt64(Smemend);
                displaystart := memstart And (Not $0f);
                mem := displaystart;
      //  (66 = length of preamble 'begin=" ..... contents="'
                If (memend > memstart + Trunc((Length(List) - 66) / 2)) Then
                    memend := memstart + Trunc((Length(List) - 66) / 2);
                i := 0;
                j := 0;
                While (mem < memend) Do
                Begin
        // Line loop
                    AscChars := '';
                    Output := Output + format('0x%8.8X ', [displaystart + i]);
                    For b := 0 To 15 Do
        // byte loop (Hex)
                    Begin
                        If ((mem < memstart) Or (mem >= memend)) Then
                        Begin
                            Output := Output + '   ';
                            AscChars := AscChars + ' ';
                        End
                        Else
                        Begin
                            Output := Output + format('%.1s%.1s ',
                                [MemContent[j * 2 + 1], MemContent[j * 2 + 2]]);
                            AscChar := StrToInt('$' + MemContent[j * 2 + 1] + MemContent[j * 2 + 2]);
                            If ((AscChar < 32) Or (AscChar > 127)) Then
                                AscChars := AscChars + ' '
                            Else
                                AscChars := AscChars + Chr(AscChar);
                            Inc(j);
                        End;
                        If ((mem And $07) = $07) Then
                            Output := Output + ' ';
                        Inc(mem);
                        Inc(i);
                    End;
                    Output := Output + AscChars + NL;
                End;
            End;
            MemList := AnsiRightStr(MemList, Length(MemList) - next);
            Output := Output + NL;
        End;
    Until (next = 0);

    debugCPUFrm.MemoryRichEdit.Lines.Add(Output);

End;

//=================================================================

Procedure TGDBDebugger.ParseCPUDisassem(Msg: String);

{
   Part of Third Level Parse of Output.
   Initial parse of Disassembly display.
}
Var
    line: String;
    List: String;
    CurrentFuncName: String;
    next: Integer;
    Output: String;

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

Begin
    CurrentFuncName := '';
    List := ExtractBracketed(@Msg, Nil, @next, '[', False);
    If (AnsiStartsStr(GDBsrcline, List)) Then
  // Mixed Mode
        Output := ParseCPUMixedMode(List);
    If (AnsiStartsStr('{' + GDBaddress, List)) Then
  // Disassemby Mode
        Output := ParseCPUDisasmMode(List, @CurrentFuncName);
    DebugCPUFrm.DisassemblyRichEdit.Lines.Add(Output);
End;

//=================================================================

Function TGDBDebugger.ParseCPUMixedMode(List: String): String;
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
Var
    Line, LineNum, FileName, AsmInstr, Output: String;
    CurrentFileName, CurrentFuncName, FirstLine, LastLine: String;
    next: Integer;
    NoAsm: Boolean;

Begin
    CurrentFileName := '';
    CurrentFuncName := '';
    NoAsm := False;

    Repeat
        Begin
            Line := ExtractBracketed(@List, Nil, @next, '{', False);
            If (Not (Line = '')) Then
            Begin
                ParseConst(@Line, @GDBlineq, PString(@LineNum));
                ParseConst(@Line, @GDBfileq, PString(@FileName));
                AsmInstr := ExtractBracketed(@Line, Nil, Nil, '[', False);
                FileName := ExtractFileName(FileName);

                If (Not (FileName = CurrentFileName)) Then
                Begin
                    Output := Output + format('%s: %s%s', [FileStr, FileName, NL]);
                    CurrentFileName := FileName;
                End;
                If (AsmInstr = '') Then
                Begin
                    If (NoAsm = False) Then
                        FirstLine := LineNum;
                    NoAsm := True;
                    LastLine := LineNum;
                End
                Else
                Begin
                    NoAsm := False;
                    If ((FirstLine = '') And (LastLine = '')) Then
           // Do nothing!
                    Else
                    If (FirstLine = LastLine) Then
                        Output := Output + 'Line: ' + FirstLine
                            + ' ' + NoDisasmStr + NL
                    Else
                    If ((FirstLine = '') Or (LastLine = '')) Then
                        Output := Output + LineStr + ': ' + LineNum + NL
                    Else
                        Output := Output + LinesStr + ': ' + FirstLine + ' - ' + LastLine
                            + ' ' + NoDisasmStr + NL;
                    Output := Output + LineStr + ': ' + LineNum + NL;
                    Output := Output + ParseCPUDisasmMode(AsmInstr, @CurrentFuncName);
                    FirstLine := '';
                    LastLine := '';
                End;
            End;
            List := AnsiRightStr(List, Length(List) - next);
        End;
    Until (next = 0);
    ParseCPUMixedMode := Output;
End;

//=================================================================

Function TGDBDebugger.ParseCPUDisasmMode(List: String; CurrentFuncName: PString): String;
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
Var
    Line, Address, FuncName, Offset, Instr, Output: String;
    next: Integer;

Begin
    Repeat
        Begin
            Line := ExtractBracketed(@List, Nil, @next, '{', False);
            If (Not (Line = '')) Then
            Begin
                ParseConst(@Line, @GDBaddress, PString(@Address));
                ParseConst(@Line, @GDBfuncname, PString(@FuncName));
                ParseConst(@Line, @GDBoffset, PString(@Offset));
                ParseConst(@Line, @GDBinstr, PString(@Instr));
                If (Not (FuncName = CurrentFuncName^)) Then
                Begin
                    Output := Output + format('%s: %s%s', [FuncStr, FuncName, NL]);
                    CurrentFuncName^ := FuncName;
                End;
                Output := Output + Address + HT + Offset + HT + Instr + NL;

            End;
            List := AnsiRightStr(List, Length(List) - next);
        End;
    Until (next = 0);
    ParseCPUDisasmMode := Output;
End;

//=================================================================

Procedure TGDBDebugger.ParseRegisterNames(Msg: String);
{
   Part of Third Level Parse of Output.
   Parses list of register names, then generates request to get their values.
}
Var
    List: String;
    start, next, i: Integer;

Begin
    List := ExtractBracketed(@Msg, @start, @next, '[', False);
    For i := 0 To CPURegCount Do
    Begin
        CPURegNames[i] := ExtractBracketed(@List, @start, @next, '"', False);
        List := MidStr(List, next, Length(List));
    End;
    WriteToPipe(format(GDBlistregvalues, [WriteGDBContext(SelectedThread, SelectedFrame)]) + CPURegList);
End;

//=================================================================

Procedure TGDBDebugger.ParseRegisterValues(Msg: String);
{
   Part of Third Level Parse of Output.
   Parses and pairs up the list of register values against the list of register names.
}
Var
    List, Reg, Value: String;
    start, next, Number, i: Integer;

Begin
    List := ExtractBracketed(@Msg, @start, @next, '[', False);

    For i := 0 To CPURegCount Do
    Begin
        Reg := ExtractBracketed(@List, @start, @next, '{', False);
        ParseConst(@Reg, @GDBvalue, PString(@Value));
        ParseConst(@Reg, @GDBnumber, PInteger(@Number));
        If ((Number >= 0) And (Number <= CPURegCount)) Then
            CPURegValues[Number] := Value;
        List := MidStr(List, next, Length(List));
        If (MainForm.VerboseDebug.Checked) Then
            AddtoDisplay(CPURegNames[i] + '  ' + CPURegValues[i]);
        DebugCPUFrm.RegisterList.InsertRow(CPURegNames[i], Value, True);
    End;

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

End;

//=================================================================

Procedure TGDBDebugger.WatchpointHit(Msg: PString);
{
   INCOMPLETE
   Does nothing with the result apart from writing to display
   Needs to build a list to pass back to the IDE
   Parses out Watchpoint details
   May be easier to split this for the 3 types of Watchpoint
}
Var
    Temp: String;
    Num, Line: Integer;
    Expr, Wpt, Val, Old, New, Value, Func, SrcFile, frame, Output: String;
    hasOld, hasNew, hasValue: Boolean;
    //Ret: Boolean;

Begin
    Temp := Msg^;
    Num := 0;
    Line := 0;

    //Ret := false;
    Val := ExtractNamed(@Temp, @GDBvalueqb, 1);
    Wpt := ExtractNamed(@Temp, @GDBwpt, 1);
    {Ret := }ParseConst(@Wpt, @GDBnumber, PInteger(@Num));

    hasOld := ParseConst(@Val, @GDBold, PString(@Old));
    If (hasOld) Then
        Old := ' was ' + Old;
    hasNew := ParseConst(@Val, @GDBnew, PString(@New));
    If (hasNew) Then
        New := ' now ' + New;
    hasValue := ParseConst(@Val, @GDBvalue, PString(@Value));
    If (hasValue) Then
        Value := ' Presently ' + Value;

    {Ret := }ParseConst(@Wpt, @GDBexp, PString(@Expr));

    Frame := ExtractNamed(@Temp, @GDBframe, 1);
    {Ret := }ParseConst(@Frame, @GDBfile, PString(@SrcFile));
    {Ret := }ParseConst(@Frame, @GDBfunc, PString(@Func));
    {Ret := }ParseConst(@Frame, @GDBline, PInteger(@Line));

    If (MainForm.VerboseDebug.Checked) Then
	   Begin
		      Output := Format('Watchpoint No %d hit. %s%s%s%s in %s at line %d in %s',
			         [Num, Expr, Old, New, Value, Func, Line, SrcFile]);
		// gui_critSect.Enter();
		      AddtoDisplay(Output);
		// gui_critSect.Leave();
	   End;

    // Line No. is not meaningful - need to find some way to relate to source line in editor,
    //  else disable GDB's ability to trace into headers/libraries.
    MainForm.GotoBreakpoint(SrcFile, Line);
End;

//=================================================================

Procedure TGDBDebugger.BreakpointHit(Msg: PString);
// Parses out Breakpoint details

Var
    Temp: String;
    Num, Line: Integer;
    Func, SrcFile, frame, Output: String;
    //Ret: Boolean;

Begin

    Temp := Msg^;
    Num := 0;

    //Ret := false;

    {Ret := }ParseConst(Msg, @GDBbkptno, PInteger(@Num));
    Frame := ExtractNamed(@Temp, @GDBframe, 1);
    {Ret := }ParseConst(@frame, @GDBfile, PString(@SrcFile));
    {Ret := }ParseConst(@frame, @GDBfunc, PString(@Func));
    {Ret := }ParseConst(@frame, @GDBline, PInteger(@Line));

    If (MainForm.VerboseDebug.Checked) Then
	   Begin
		      Output := Format('Breakpoint No %d hit in %s at line %d in %s',
			         [Num, Func, Line, SrcFile]);
		// gui_critSect.Enter();
		      AddtoDisplay(Output);
		// gui_critSect.Leave();
	   End;

    // Line No. is not always meaningful - need to find some way to relate to source line in editor,
    //  else disable GDB's ability to trace into headers/libraries.
    MainForm.GotoBreakpoint(SrcFile, Line);
End;

//=================================================================

Procedure TGDBDebugger.ModifyVariable(VarName: String; Value: String);
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
Var
    VOName: String;
    i: Integer;

Begin
    VOName := VarName;
  // create a name
    For i := 1 To length(VOName) Do
        If ((VOName[i] = '.') Or (VOName[i] = '[') Or (VOName[i] = ']')) Then
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

End;

//=================================================================

Procedure TGDBDebugger.WptScope(Msg: PString);
// Parses out Watchpoint details
// N.B. "Msg" may contain multiple pairs of values:
//    reason="watchpoint-scope",wpnum="n",

Var
    Temp: String;
    Reason, Output: String;
    Thread: Integer;
    wpnum: Integer;
    index: Integer;
//  count: Integer;
    watch: PWatchPt;
  //Ret: Boolean;
    comma1, comma2: Integer;
    BPStr: String;

Begin

    Temp := Msg^;
  // reason="watchpoint-scope",wpnum="3",  <etc> ,thread-id="1",frame={addr="0x77c2c3d9",func="msvcrt!free",args=[],from="C:\\WINDOWS\\system32\\msvcrt.dll"}'

    ParseConst(Msg, @GDBthreadid, PInteger(@Thread));
    comma1 := FindFirstChar(Temp, ',');
    Temp := AnsiMidStr(Temp, (comma1 + 1), Length(Temp) - comma1 - 1);
//  count := 1;
    Repeat
        comma1 := FindFirstChar(Temp, ',');
        If (comma1 = 0) Then
            Break;
        comma2 := FindFirstChar(AnsiMidStr(Temp, (comma1 + 1), Length(Temp) - comma1 - 1), ',');
        If (comma2 = 0) Then
            Break;
        BPStr := AnsiLeftStr(Temp, comma1 + comma2);
        Temp := AnsiMidStr(Temp, (comma1 + comma2 + 1), Length(Temp) - comma1 - comma2 - 1);

        ParseConst(@BPStr, @GDBreason, PString(@Reason));
        ParseConst(@BPStr, @GDBwpNum, PInteger(@wpnum));
        If ((Not (Reason = '')) And (Not (wpnum = 0))) Then
        Begin
            With MainForm.WatchTree.Items Do
            Begin
                If Not (Count = 0) Then
                Begin
                    For index := 0 To Count - 1 Do
                    Begin
                        Watch := Item[index].Data;
                        If (Watch.BPNumber = wpnum) Then
                        Begin
                            Watch.Deleted := True;
                            Watch.Value := wpUnknown;
                            Item[index].Text := Format('%s = %s', [Watch.Name, Watch.Value]);
                            Output := Format('Stopped - %s for %s in Thread %d', [Reason, Watch.Name, Thread]);
			                         CurrentGDBThread := Thread;
                            SelectedThread := Thread;
                            SelectedFrame := 0;

                        End;
                    End;
                End;
            End;
        End;
//    Inc(count);
    Until ((Reason = '') Or (wpnum = 0));

  // Restart the Target:
  //WriteToPipe(GDBcontinue);

  // gui_critSect.Enter();
    AddtoDisplay(Output);
  // gui_critSect.Leave();

End;

//=================================================================

Procedure TGDBDebugger.StepHit(Msg: PString);
// Parses out Breakpoint details

Var
    Temp: String;
    Line: Integer;
    Func, SrcFile, frame, Output: String;
    //Ret: Boolean;

Begin

    Temp := Msg^;

    //Ret := false;

    Frame := ExtractNamed(@Temp, @GDBframe, 1);
    {Ret := }ParseConst(@frame, @GDBfile, PString(@SrcFile));
    {Ret := }ParseConst(@frame, @GDBfunc, PString(@Func));
    {Ret := }ParseConst(@frame, @GDBline, PInteger(@Line));

    If (MainForm.VerboseDebug.Checked) Then
	   Begin
		      Output := Format('Stopped in %s at line %d in %s', [Func, Line, SrcFile]);
		// gui_critSect.Enter();
		      AddtoDisplay(Output);
		// gui_critSect.Leave();
	   End;

    // Line No. is not meaningful - need to find some way to relate to source line in editor,
    //  else disable GDB's ability to trace into headers/libraries.
    MainForm.GotoBreakpoint(SrcFile, Line);
End;

//=================================================================


Function TGDBDebugger.SplitResult(Str: PString; Vari: PString): String;
{
/*
    Expects a string of form Variable = Value, where value may be a const, tuple or list
    Returns Value:
        Variable in Var
    Str MUST be well-formed, i.e. with no unmatched braces, etc.
 */
}
Var
    Val: String;

Begin          // SplitResult
    Vari^ := AnsiBeforeFirst('=', Str^);
    Val := AnsiAfterFirst('=', Str^);
    Vari^ := Trim(Vari^);
    Val := Trim(Val);
    SplitResult := Val;
End;

//=================================================================

Function TGDBDebugger.ExtractLocals(Str: PString): String;
// expects Str to be of form "done,locals=Result"
Var
	   Output: String;
	   Level: Integer;
	   LocalsStr: String;
	   Val: String;
	   Vari: String;   // This is called Var in the GDB spec !
	   I: Integer;
	   Local: PVariable;
	   LocalsList: TList;

Begin

	   LocalsList := TList.Create;
	   Level := 0;

	   LocalsStr := AnsiMidStr(Str^, Length(GDBdone) + 1, Length(Str^) - Length(GDBdone));
	   If (AnsiStartsStr(GDBlocalsq, LocalsStr)) Then
	   Begin
		      LocalsStr := MidStr(Str^, Length(GDBdone) + 1, Length(Str^) - Length(GDBdone));
		      Val := SplitResult(@LocalsStr, @Vari);    // Must start with a List or a Tuple

		      If (AnsiStartsStr('{', Val)) Then
			         Output := ExtractList(@LocalsStr, PARSETUPLE, Level, LocalsList)
		      Else // it starts '['
			         Output := ExtractList(@LocalsStr, PARSELIST, Level, LocalsList);
		      ExtractLocals := GDBlocalsq + Output;
	   End;
	   MainForm.OnLocals(LocalsList);
	   Try
		{ Cleanup: must free the list items as well as the list }
	       For I := 0 To (LocalsList.Count - 1) Do
	       Begin
		          Local := LocalsList.Items[I];
		          Dispose(Local);
	       End;
	   Finally
		      LocalsList.Free;
	   End;

End;

//=================================================================

Function TGDBDebugger.ParseResult(Str: PString; Level: Integer; List: TList): String;
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
Var
    Output: String;
    Vari: String;   // This is called Var in the GDB spec !
    start: Integer;
    Val: String;
    Local: PWatchVar;

Begin          // ParseResult
    Val := SplitResult(Str, @Vari);
    Output := Vari;
    Output := Output + ' = ';
    start := Pos(wxStringBase, Val);
    If (Vari = GDBname) Then                        // a name of a Tuple
    Begin
        New(Local);

        Local.Number := 0;

        Output := Output + Val;
        Local.Name := format('%*s%s', [Level * INDENT, '',
            ExtractBracketed(@Val, Nil, Nil, '"', False)]);
        Local.Value := '';
        List.Add(Local);
    End
    Else
    If (Vari = GDBvalue) Then                      // a value of named a Tuple
    Begin

        ReplaceWxStr(@Val);
//    else
//    if (AnsiStartsStr('"{', Val)) then           // it's a named Tuple
//    begin
//      Output := Output + ExtractList(Str, PARSETUPLE, Level, List);
//    end

        If (AnsiStartsStr('"', Val)) Then            // it's a quoted string e.g. a value of a Tuple
        Begin
            New(Local);
            Local.Number := 0;
            Output := Output + OctToHex(@Val);
            If (List.Count > 0) Then
                Local := List.Last;                      // so add the value to the last item
            Val := OctToHex(@Val);
            Local^.Value := Val;

            List.Remove(Local);
            List.Add(Local);
        End
        Else
        Begin
            If (List.Count = 0) Then
            Begin
                New(Local);

                Local.Number := 0;

                Local^.Value := Val;
            End
            Else
            Begin
                Local := List.Last;                      // so add it to the last item
                Local^.Value := Val;
                List.Remove(Local);
            End;
            List.Add(Local);
            Output := Output + Val;




        End;

    End

    Else
    If (AnsiStartsStr('[', Val)) Then              // it's a List
    Begin

        Output := Output + ExtractList(Str, PARSELIST, Level, List);
    End

    Else
    If (AnsiStartsStr('{', Val)) Then              // it's a Tuple
    Begin
        New(Local);
        Local.Number := 0;
        Local^.Name := format('%*s%s', [Level * INDENT, '',
            ExtractBracketed(@Vari, Nil, Nil, '"', False)]);
        List.Add(Local);
        Output := Output + ExtractList(Str, PARSETUPLE, Level, List);
    End
    Else
    Begin                                          // it's a simple Const
        New(Local);
        Local.Number := 0;
        Local^.Name := format('%*s%s', [Level * INDENT, '',
            ExtractBracketed(@Vari, Nil, Nil, '"', False)]);
        Val := OctToHex(@Val);
        Local^.Value := Val;
        List.Add(Local);
        Output := Output + Val;
    End;

    ParseResult := Output;
End;

//=================================================================

Function TGDBDebugger.ExtractList(Str: PString; Tuple: Boolean; Level: Integer; List: TList): String;
{
    Extracts a comma-separated list of values or results from a List,
    of the form "[value(,value)*]"
             or "[result(,result)*]"

    N.B. This is recursive and will fully parse the Result tree.
}
Var
	   delim1, delim2: Char;
	   Remainder: String;
	   Item: String;
	   start, next: Integer;
	   Output: String;

	   len, comma, lbrace, lsqbkt, equals: Integer;

Begin          // ParseList

  // Get the first result or value.
    // Remove outermost "[ ]" or "{ }"
    If (Tuple) Then
    Begin
		      delim1 := '{';
		      delim2 := '}';
    End
    Else   // it's a List
    Begin
		      delim1 := '[';
		      delim2 := ']';
    End;
    Remainder := ExtractBracketed(Str, @start, @next, delim1, False);
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

    While (True) Do
    Begin                                                // Loop through the list
		      len := Length(Remainder);                          // find out which
		      If (Len = 0) Then
			         break;
		      comma := FindFirstChar(Remainder, ',');
		      lbrace := FindFirstChar(Remainder, '{');
		      lsqbkt := FindFirstChar(Remainder, '[');
		      equals := FindFirstChar(Remainder, '=');

		      If (Not (equals = 0)
            And ((lbrace = 0) Or (equals < lbrace))
            And ((lsqbkt = 0) Or (equals < lsqbkt))
            And ((comma = 0) Or (equals < comma))) Then    // we have a Result

        Begin
            If (comma = 0) Then                         // and the only or the last one
            Begin
				            Output := Output + ParseResult(@Remainder, Level + 1, List);
				            break;                                    // done
            End
            Else
            Begin
				            Item := AnsiLeftStr(Remainder, comma - 1);  // ... or the first of many
				            Output := Output + ParseResult(@Item, Level + 1, List);
				            next := comma + 1;
				            Output := Output + ', ';
            End;
        End
        Else                                            // we have a value
        Begin
            If (comma = 0) Then                         // and the only or the last one
            Begin
                Output := Output + ParseValue(@Remainder, Level + 1, List);
                break;                                  // done
            End
            Else
            Begin
                Item := AnsiLeftStr(Remainder, comma - 1); // ... or the first of many
                Output := Output + ParseValue(@Item, Level + 1, List);
                Output := Output + ', ';
                next := comma + 1;
            End;
        End;
		      If (next < len) Then
			         Remainder := AnsiMidStr(Remainder, next, Length(Remainder) - next + 1);
    End;
    Output := Output + delim2;
    ExtractList := Output;
End;

//=================================================================

Function TGDBDebugger.ParseValue(Str: PString; Level: Integer; List: TList): String;

//    Determines the content of a Value, i.e.
//        const | tuple | list
//    The Value must NOT be enclosed in {...} or [...]  -- although its
//    contents will be if those are a Tuple or a List.
//
//    N.B. This is recursive and will fully parse the Result tree.

Var
	   Output: String;
	   s: Integer;
	   n: Integer;
	   Str2: String;
	   Local: PWatchVar;





Begin

    Str^ := TrimLeft(Str^);

       // ParseValue
	   If (AnsiStartsStr('{', Str^)) Then                          // a Tuple
		      Output := Output + ExtractList(Str, PARSETUPLE, Level, List)
	   Else
	   If (AnsiStartsStr('[', Str^)) Then                          // a List
		      Output := Output + ExtractList(Str, PARSELIST, Level, List)
	   Else
	   If ((Str^[1] = '"')
        And ((Str^[2] = '{') Or (Str^[2] = '{')) And ExpandClasses) Then  // it might be a class
	   Begin
		      Str2 := ExtractBracketed(Str, @s, @n, '"', False);
		      Output := Output + ExtractList(@Str2, PARSELIST, Level, List);
	   End
	   Else
	   Begin
		      New(Local);                           // a const
		      Local^.Value := Trim(OctToHex(Str));
        Local^.Name := '';
		      List.Add(Local);
		      Output := Output + OctToHex(Str);         // a const
	   End;
	   ParseValue := Output;
End;

//=================================================================

Function TGDBDebugger.ExtractWxStr(Str: PString): String;

    //    Expects a Value specifically of the form:

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
    //    (and may start with a quote and end with a comma)
    //    and returns the string only.

Var
    starts: Integer;
    ends: Integer;
    QStr: String;

Begin          // ExtractwxStr
    QStr := AnsiLeftStr(Str^, Length(Str^) - 20);
    If (AnsiPos('"{', QStr) = 1) Then
        QStr := AnsiMidStr(QStr, 3, Length(QStr) - 3);    // Strip the wrapping
    If (AnsiPos('{', QStr) = 1) Then
        QStr := AnsiMidStr(QStr, 2, Length(QStr) - 1);    // Strip the wrapping
    If (AnsiLastChar(QStr) = '>') Then                // An Error Msg
        QStr := '<' + AnsiAfterLast('<', QStr)
    Else                                              // a quoted string
    Begin
        starts := AnsiPos('\"', QStr);
        ends := AnsiFindLast(GDBqStrEmpty, QStr);
        QStr := AnsiMidStr(QStr, starts + 2, ends - starts - 2);
    End;
    ExtractWxStr := unescape(@QStr);

End;

//=================================================================

Procedure TGDBDebugger.ReplaceWxStr(Str: PString);

//    Expects a string with embedded wxStrings specifically of the form expected
//     by ExtractWxStr
//    and returns with the string that has only the quoted string itself embedded.
//      e.g. {MywxStr = {<wxStringBase> = {static npos = ..., m_pchData = 0x... \"AString\"}, <No data fields>}}
//    becomes
//      {MywxStr = "AString"}


Var
    wxstarts: Integer;
    starts: Integer;
    ends: Integer;
    QStr, Remainder, Output: String;

Begin
    Remainder := Str^;
    Output := '';
    wxstarts := AnsiPos('{' + wxStringBase, Remainder);
    While (Not (wxstarts = 0)) Do
    Begin
        Output := Output + AnsiLeftStr(Remainder, wxstarts - 1);
        Remainder := AnsiRightStr(Remainder, Length(Remainder) - wxstarts + 1);
        QStr := ExtractBracketed(@Remainder, @starts, @ends, '{', True);
        Output := Output + '"' + ExtractWxStr(@QStr) + '"';
        If (ends = 0) Then
        Begin
            Remainder := '';
            break;
        End;
        Remainder := AnsiRightStr(Remainder, Length(Remainder) - ends + starts);
        wxstarts := AnsiPos('{' + wxStringBase, Remainder);
    End;
    Str^ := Output + Remainder;
End;

//=================================================================

Function unescape(s: PString): String;
// Unescapes a GDB double-escaped C-style string.
// E.g 'A \\\"quote\\\"'  becomes  'A \"quote\"'
Var
	   i: Integer;
	   temp: String;

Begin
	   If (length(s^) > 1) Then
	   Begin
		      i := 1;

		      Repeat
		          Begin
			             If ((s^[i] = '\') And
			                 ((s^[i + 1] = '\') Or (s^[i + 1] = '"'))) Then
				                inc(i);
			             temp := temp + s^[i];
			             inc(i);
		          End;
		      Until i > length(s^);
		      unescape := temp;
	   End
	   Else
		      unescape := s^;
End;

//=================================================================

Function OctToHex(s: PString): String;
// Replaces each Octal representation of an 8-bit number embedded in a string
//  with its Hex equivalent. Format must be '\nnn' or '\\0nn'
//  (i.e. escaped leading zero)
//  E.g.  '\302' => '0xC2'    '\\025' => '0x15'

//  Note: 3 digits, 1 or 2 backslashes and the surrounding single quotes
//  are all required.
// Returns the converted string.

Var
	   i, k: Integer;
	   temp: String;
	   c: Integer;

Begin
	   If (length(s^) > 5) Then
	   Begin
		      i := 1;
		      k := 0;
		      Repeat
		          Begin
		              If ((s^[i + 1] = '\') And (s^[i + 2] = '\')) Then
			                 k := 1;
		              If (s^[i] = '''') And
			                 (s^[i + 1] = '\') And
			                 (s^[i + k + 1] = '\') And
			                 (s^[i + k + 2] >= '0') And
			                 (s^[i + k + 2] < '8') And
			                 (s^[i + k + 3] >= '0') And
			                 (s^[i + k + 3] < '8') And
			                 (s^[i + k + 4] >= '0') And
			                 (s^[i + k + 4] < '8') And
			                 (s^[i + k + 5] = '''') Then
			             Begin
				                c := ((StrToInt(s^[i + k + 2]) * 8) + StrToInt(s^[i + k + 3])) * 8 + StrToInt(s^[i + k + 4]);
				                temp := temp + format('''0x%2.2x''', [c]);
				                i := i + k + 6;
			             End
			             Else
			             Begin
				                temp := temp + s^[i];
				                inc(i);
			             End;
		          End;
		      Until (i > length(s^));
		      OctToHex := temp;
	   End
	   Else
		      OctToHex := s^;
End;

//=================================================================

Function AnsiBeforeFirst(Sub: String; Target: String): String;
    // Returns the string before the first 'Sub' in 'Target'
Begin
    //AnsiBeforeFirst := AnsiLeftStr(Target, AnsiPos(Sub,Target)-1);
    AnsiBeforeFirst := LeftStr(Target, AnsiPos(Sub, Target) - 1);
End;

//=================================================================

Function AnsiAfterFirst(Sub: String; Target: String): String;
    // Returns the string after the first 'Sub' in 'Target'
Begin
    // AnsiAfterFirst := AnsiRightStr(Target, Length(Target) - AnsiPos(Sub, Target));
    AnsiAfterFirst := RightStr(Target, Length(Target) - AnsiPos(Sub, Target));
End;

//=================================================================

Function AnsiAfterLast(Sub: String; Target: String): String;
    // Returns the string after the last 'Sub' in 'Target'
Var
    RTarget, RSub, Res: String;

Begin
    RTarget := ReverseString(Target);
    RSub := ReverseString(Sub);
    Res := LeftStr(RTarget, AnsiPos(RSub, RTarget) - 1);
    AnsiAfterLast := ReverseString(Res);
End;

//=================================================================

Function AnsiFindLast(Src: String; Target: String): Integer;
    // Find the index of the last occurrence of Src in Target
Var
    RTarget, RSrc: String;

Begin
    RTarget := ReverseString(Target);
    RSrc := ReverseString(Src);
    AnsiFindLast := Length(Target) - AnsiPos(RSrc, RTarget);
End;

Function AnsiMidStr(Const AText: String;
    Const AStart, ACount: Integer): String;
Begin
    Result := MidStr(AText, AStart, ACount);
End;

Function AnsiRightStr(Const AText: String; ACount: Integer): String;
Begin
    Result := RightStr(AText, ACount);
End;

Function AnsiLeftStr(Const AText: String; ACount: Integer): String;
Begin
    Result := LeftStr(AText, ACount);
End;

//=================================================================

Function TGDBDebugger.FindFirstChar(Str: String; c: Char): Integer;

    //    Finds the first occurrence of 'c' in Str that is
    //    not enclosed in { ... }, [ ... ] or  " ... "
    //    although it WILL find the opening { or [ or " provided it is
    //    not otherwise enclosed.
    //    A well-formed input string is assumed.
    //    Returns the one-based index of 'c', or 0.


Var
    pos, p: Integer;
    isquoted: Boolean;

Begin

    isquoted := False;
    FindFirstChar := 0;
    pos := 1;

    While ((Not (Str[pos] = c) Or isquoted) And (pos <= Length(Str))) Do
    Begin
		      If ((Str[pos] = '"') And ((pos > 1) And Not (Str[pos - 1] = '\'))) Then
		// was: if (Str[pos] = '"') then
            isquoted := Not isquoted
        Else
        If (Str[pos] = '{') Then
        Begin
            p := FindFirstChar(AnsiMidStr(Str, (pos + 1),
                Length(Str) - pos - 1), '}');
            If (p = 0) Then
            Begin
                FindFirstChar := 0;
                break;
            End;
            pos := pos + p;
        End
        Else
        If (Str[pos] = '[') Then
        Begin
            p := FindFirstChar(AnsiMidStr(Str, (pos + 1),
                Length(Str) - pos - 1), ']');
            If (p = 0) Then
            Begin
                FindFirstChar := 0;
                break;
            End;
            pos := pos + p;
        End;

        Inc(pos);
        FindFirstChar := pos;
    End;

    If (pos > Length(Str)) Then
        FindFirstChar := 0;

End;

//=================================================================


Function TGDBDebugger.ExtractBracketed(Str: PString; start: Pinteger;
    next: PInteger; c: Char; inclusive: Boolean): String;


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


Var
    Output: String;
    l1, l2, l3, l4, s, e: Integer;
    nestedin: Array[0..9] Of Integer;

Begin          // ExtractBracketed
    Output := Str^;
    For e := 9 Downto 0 Do
        nestedin[e] := 0;
    // we are expecting a closing '"' at this level (arbitrary limit of 256)

    l1 := 0;             // level of nesting of ""
    l2 := 0;             // level of nesting of {}
    l3 := 0;             // level of nesting of []
    l4 := 0;             // level of nesting of <>
    s := -1;             // index of start of our region -1 = not found
    e := 0;              // index of end of our region

    Begin

        While (e <= Length(Output)) Do
        Begin
            If (Not (Output[e] = c) And (s = -1)) Then
            Begin                   // skip over all before our start char
                Inc(e);
                continue;
            End;

            Case (Output[e]) Of
                '\':
                    If (Output[e + 1] = '"') Then
                        // a literal quote - ignore
                    Begin
                        e := e + 2;                         // & skip over
                        continue;
                    End;

                '"':
                    If ((nestedin[l1] = 0) And Not (s = -1)) Then
                        Dec(l1)
                    Else
                        Inc(l1);

                '{':
                Begin
                    Inc(l2);
                    Inc(nestedin[l1]);
                End;

                '}':
                Begin
                    Dec(l2);
                    Dec(nestedin[l1]);
                End;

                '[':
                Begin
                    Inc(l3);
                    Inc(nestedin[l1]);
                End;

                ']':
                Begin
                    Dec(l3);
                    Dec(nestedin[l1]);
                End;

                '<':
                Begin
                    Inc(l4);
                    Inc(nestedin[l1]);
                End;

                '>':
                Begin
                    Dec(l4);
                    Dec(nestedin[l1]);
                End;
            End;

            If ((s = -1) And (Output[e] = c)) Then
                s := e;
            Inc(e);
            If (Not (s = -1) And ((l1 = 0) And (c = '"') Or (l2 = 0)
                And (c = '{') Or (l3 = 0)
                And (c = '[') Or (l4 = 0)
                And (c = '<'))) Then
                break;
        End;

		      If ((e > Length(Output)) And (s = -1)) Then          // was e = Length(Output)
        Begin
            If (Not (start = Nil)) Then
                start^ := 0;
            If (Not (next = Nil)) Then
                next^ := 0;
            Output := '';
            ExtractBracketed := Output;
        End;
    End;

    If (Not (next = Nil)) Then
        If (e > Length(Output)) Then
            next^ := 0
        Else
            next^ := e;

    If (Not (inclusive)) Then
    Begin
        Inc(s);
        Output := AnsiMidStr(Str^, s, e - s - 1);
    End
    Else
        Output := AnsiMidStr(Str^, s, e - s);

    If (Not (start = Nil)) Then
        start^ := s;

    ExtractBracketed := Output;
End;

//=================================================================


Constructor TGDBDebugger.Create;
Begin
    Inherited;
    OverrideHandler := Nil;
    LastWasCtrl := True;
    Started := False;
End;

//=============================================================

Procedure TGDBDebugger.CloseDebugger(Sender: TObject);
Begin

	   If Executing Then
	   Begin

        // Reset breakpoint colors in editor
        MainForm.RemoveActiveBreakpoints;
        MainForm.DebugOutput.Lines.Add('Debugger closed.');

		      fPaused := False;
		      fExecuting := False;

//		DLLs attached to the process are not notified that the process
//  	is terminating. Thus using Reset may result in an unstable system.
//  	The Windows API documentation on TerminateProcess explains all.

		      If (TargetIsRunning) Then
// 			Kill the target
			         KillProcess(TargetPID);
// 		Kill the Debugger
		      KillProcess(DebuggerPID);
		      Cleanup;

// First don't let us be called twice. Set the secondary threads to not call
// us when they terminate

		      Reader.OnTerminate := Nil;
		      Reader := Nil;

//    	MainForm.RemoveActiveBreakpoints;

//		Clear the command queue
		      CommandQueue.Clear;
		      CurrentCommand := Nil;
	   End;
End;

//=============================================================

Destructor TGDBDebugger.Destroy;
Begin
    Inherited;
End;

//=============================================================

Procedure TGDBDebugger.ExitDebugger;
Begin

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


End;

//=============================================================
Procedure TGDBDebugger.Cleanup;


Begin

	   Reader.Terminate;
    //Close the handles
	   Try
		      If (Not CloseHandle(g_hChildStd_IN_Wr)) Then
			         DisplayError('CloseHandle - ChildStd_IN_Wr');
		      If (Not CloseHandle(g_hChildStd_OUT_Rd)) Then
			         DisplayError('CloseHandle - ChildStd_OUT_Rd');
		//	See the note above about TerminateProcess
	   Except
		      on EExternalException Do
            DisplayError('Closing Pipe Handles');
	   End;

End;

//=============================================================


Procedure TGDBDebugger.Execute(filename, arguments: String);
Var
    Executable: String;
    WorkingDir: String;
    Includes: String;
    I: Integer;

Begin
    //Reset our variables
    self.FileName := filename;
    fNextBreakpoint := 0;
    IgnoreBreakpoint := False;
    Started := False;
    TargetIsRunning := False;

	   SelectedFrame := 0;
	   SelectedThread := 0;

    //Get the name of the debugger
    If (devCompiler.gdbName <> '') Then
        Executable := devCompiler.gdbName
    Else
        Executable := DBG_PROGRAM(devCompiler.CompilerType);


    Executable := Executable + ' ' + GDBInterp;

    // Verbose output requested?
    If (Not MainForm.VerboseDebug.Checked) Then
        Executable := Executable + ' ' + GDBSilent;

    //Add in the include paths

    For I := 0 To IncludeDirs.Count - 1 Do
        Includes := Includes + '--directory=' +
            GetShortName(IncludeDirs[I]) + ' ';
    If Includes <> '' Then
        Executable := Executable + ' ' + Includes;


    //Add the target executable
    Executable := Executable + ' "' + filename + '"';

    //Launch the process

    If Assigned(MainForm.fProject) Then
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

End;

//=============================================================
Procedure TGDBDebugger.AddtoDisplay(Msg: String);
// Write to the IDE debugger output window

// This is equivalent to the calls in TGDBDebugger.OnOutput:
//   MainForm.DebugOutput.Lines.AddStrings(TempLines);
// around line 2487
// GAR: Change this to suit

Begin
    If Assigned(MainForm.DebugOutput) Then
        MainForm.DebugOutput.Lines.Add(Msg);
End;

//=============================================================
Procedure TGDBDebugger.SendCommand;
// called by QueueCommand( ) initially, then by the parser once the present
//  debugger output is exhausted in order to process the next in the queue.

Begin
    //Do we have anything left? Are we paused?
    // SentCommand is reset by the parser
    If Executing And Paused Then
        While ((CommandQueue.Count > 0) And (Paused) And (Not SentCommand)) Do
        Begin

            //Initialize stuff
            // Let's assume commands have been queued up

            SentCommand := True;
            CurrentCommand := PCommand(CommandQueue[0])^;

            //Remove the entry from the list
            If Not (CurrentCommand Is TCommandWithResult) Then
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

            If (MainForm.VerboseDebug.Checked) Then
				            AddtoDisplay('Sending ' + CurrentCommand.Command);

            // For proper handling of multi-threaded targets, we need to prefix each relevant
            // command with '--thread' and ‘--frame’  (See GDB Manual: 27.1.1 Context management)
            // with parameters got from ExecResult() or ParseThreads() unless changed by user.
            // CurrentGDBThread is the thread reported by GDB, the user's default choices 
			// are SelectedThread and SelectedFrame (always defaults to 0)

            WriteToPipe(CurrentCommand.Command);

            //Call the callback function if we are provided one
            If Assigned(CurrentCommand.Callback) Then
                CurrentCommand.Callback;
        End;
End;

//=============================================================
Function TGDBDebugger.WriteGDBContext(thread: Integer; frame: Integer): String;

//    Returns a string of the form "--thread n --frame n"
//     If thread == 0 or negative, an empty string is returned

Begin
    If (thread < 1) Then
        WriteGDBContext := ''
    Else
        WriteGDBContext := Format(GDBcontext,
            [thread, frame]);
End;

//=============================================================

Procedure TGDBDebugger.Attach(pid: Integer);
Var
    Executable: String;
    Includes: String;
    I: Integer;
Begin
    //Reset our variables
    self.FileName := filename;
    fNextBreakpoint := 0;
    IgnoreBreakpoint := False;

    //Get the name of the debugger
    If (devCompiler.gdbName <> '') Then
        Executable := devCompiler.gdbName
    Else
        Executable := DBG_PROGRAM(devCompiler.CompilerType);
    Executable := Executable + ' --annotate=2 --silent';

    //Add in the include paths
    For I := 0 To IncludeDirs.Count - 1 Do
        Includes := Includes + '--directory=' +
            GetShortName(IncludeDirs[I]) + ' ';
    If Includes <> '' Then
        Executable := Executable + ' ' + Includes;

    //Launch the process
    Launch(Executable, '');

    //Tell GDB which file we want to debug
    QueueCommand('-gdb-set', 'height 0');
    QueueCommand('-target-attach', inttostr(pid));
End;

Function RegexEscape(str: String): String;
Begin
    Assert(False, 'RegexEscape: I am not redundant');
End;

// ===============================================

Procedure TGDBDebugger.OnOutput(Output: String);
Begin
    Assert(False, 'TGDBDebugger.OnOutput: I am not redundant');
End;

//=================================================================

Procedure TGDBDebugger.OnSignal(Output: TStringList);
Begin
    Assert(False, 'TGDBDebugger.OnSignal: I am not redundant');
End;

//=================================================================

Procedure TGDBDebugger.OnLocals(Output: TStringList);
Begin
    Assert(False, 'TGDBDebugger.OnLocals: I am not redundant');
End;
//=================================================================

Procedure TGDBDebugger.OnThreads(Output: TStringList);
Begin
    Assert(False, 'TGDBDebugger.OnThreads: I am not redundant');
End;

//=================================================================

Procedure TGDBDebugger.GetRegisters;
Begin
    Assert(False, 'TGDBDebugger.GetRegisters: I am not redundant');
End;

//=================================================================

Procedure TGDBDebugger.OnRegisters(Output: TStringList);
Begin
    Assert(False, 'TGDBDebugger.OnRegisters: I am not redundant');
End;

//=================================================================

Procedure TGDBDebugger.OnSourceMoreRecent;
Begin
    If (MessageDlg(Lang[ID_MSG_SOURCEMORERECENT], mtConfirmation,
        [mbYes, mbNo], 0) = mrYes) Then
    Begin
        CloseDebugger(Nil);
        MainForm.actCompileExecute(Nil);
    End;
End;

//=================================================================

Procedure TGDBDebugger.AddIncludeDir(s: String);
Begin
    IncludeDirs.Add(s);
End;

//=================================================================

Procedure TGDBDebugger.ClearIncludeDirs;
Begin
    IncludeDirs.Clear;
End;

//=================================================================

Procedure TGDBDebugger.AddBreakpoint(breakpoint: TBreakpoint);
Var
    aBreakpoint: PBreakpoint;
Begin
    If (Not Paused) And Executing Then
    Begin
        MessageDlg('Cannot add a breakpoint while the debugger is executing.',
            mtError, [mbOK], MainForm.Handle);
        Exit;
    End;

    New(aBreakpoint);
    aBreakpoint^ := breakpoint;
    Breakpoints.Add(aBreakpoint);
    RefreshBreakpoint(aBreakpoint^);
End;

//=================================================================

Procedure TGDBDebugger.RemoveBreakpoint(breakpoint: TBreakpoint);
Var
    I: Integer;
Begin
    If (Not Paused) And Executing Then
    Begin
        MessageDlg('Cannot remove a breakpoint while the debugger is executing.', mtError, [mbOK], MainForm.Handle);
        Exit;
    End;

    For i := 0 To Breakpoints.Count - 1 Do
        If (PBreakPoint(Breakpoints.Items[i])^.line = breakpoint.Line) And
            (PBreakPoint(Breakpoints.Items[i])^.editor =
            breakpoint.Editor) Then
        Begin
            If Executing Then
                QueueCommand(GDBbrkdel,
                    IntToStr(PBreakpoint(Breakpoints.Items[i])^.BPNumber));

            Dispose(Breakpoints.Items[i]);
            Breakpoints.Delete(i);
            Break;
        End;
End;

//=================================================================

Procedure TGDBDebugger.RefreshBreakpoint(Var breakpoint: TBreakpoint);
Begin
    If Executing Then
    Begin
        Inc(fNextBreakpoint);
        breakpoint.Index := fNextBreakpoint;
        breakpoint.Valid := True;
        QueueCommand(GDBbrkins, Format('"%s:%d"',
            [breakpoint.Filename, breakpoint.Line]));
    End;
End;

//=================================================================

Procedure TGDBDebugger.RefreshContext(refresh: ContextDataSet);
Var
    I: Integer;
    Node: TListItem;
    Command: TCommand;
Begin
    If Not Executing Then
        Exit;

    //First send commands for stack tracing, locals and threads
    If cdCallStack In refresh Then
    Begin
        Command := TCommand.Create;
        Command.Command := format('%s %s',
			         [GDBlistframes, WriteGDBContext(SelectedThread, SelectedFrame)]);
        Command.OnResult := OnCallStack;
        QueueCommand(Command);
    End;
    If cdLocals In refresh Then
    Begin
        Command := TCommand.Create;
        Command.Command := format('%s %s 1',
			         [GDBlistlocals, WriteGDBContext(SelectedThread, SelectedFrame)]);
        Command.OnResult := OnLocals;
        QueueCommand(Command);
    End;
    If cdThreads In refresh Then
    Begin
        Command := TCommand.Create;
        Command.Command := GDBthreadinfo;
        Command.OnResult := OnThreads;
        QueueCommand(Command);
    End;

    //Then update the watches
    If (cdWatches In refresh) And Assigned(MainForm.WatchTree) Then
    Begin
		      ReLoadWatches;
		      GetWatchedValues;
    End;


End;

//=================================================================

Procedure TGDBDebugger.OnRefreshContext(Output: TStringList);
Begin

End;

//=================================================================

Procedure TGDBDebugger.OnCallStack(Output: TStringList);
Var
    I: Integer;
    CallStack: TList;
    RegExp: TRegExpr;
    StackFrame: PStackFrame;
Begin
    StackFrame := Nil;
    CallStack := TList.Create;
    RegExp := TRegExpr.Create;

    I := 0;
    While I < Output.Count Do
    Begin
        If Pos(GDBframebegin, Output[I]) = 1 Then
        Begin
            //Stack frame with source information
            New(StackFrame);
            CallStack.Add(StackFrame);
        End
        Else
        If Output[I] = GDBframefnname Then
        Begin
            Inc(I);
            StackFrame^.FuncName := Output[I];
        End
        Else
        If Output[I] = GDBframefnarg Then
        Begin
            Inc(I);

            //Make sure it's valid
            If Output[I] <> ' (' Then
            Begin
                Inc(I);
                Continue;
            End
            Else
            Begin Inc(I); End;

            While (I < Output.Count - 6) Do
            Begin
                If Output[I] = GDBarg Then
                Begin
                    If StackFrame^.Args <> '' Then
                        StackFrame^.Args := StackFrame^.Args + ', ';
                    StackFrame^.Args :=
                        StackFrame^.Args + Output[I + 1] + ' = ' +
                        Output[I + 5];
                End;
                Inc(I, 6);

                //Do we stop?
                If Trim(Output[I + 1]) <> ',' Then
                    Break
                Else
                    Inc(I, 2);
            End;
        End
        Else
        If Output[I] = GDBframesrcfile Then
        Begin
            Inc(I);
            StackFrame^.Filename := ExtractFileName(Output[I]);
        End
        Else
        If Output[I] = GDBframesrcline Then
        Begin
            Inc(I);
            StackFrame^.Line := StrToInt(Output[I]);
        End;
        Inc(I);
    End;

    //Now that we have the entire callstack loaded into our list, call the function
    //that wants it
    If Assigned(TDebugger(Self).OnCallStack) Then
        TDebugger(Self).OnCallStack(CallStack);

    //Do we show the new execution point?
    If JumpToCurrentLine Then
    Begin
        JumpToCurrentLine := False;
        MainForm.GotoTopOfStackTrace;
    End;

    //Clean up
    RegExp.Free;
    CallStack.Free;
End;

//=================================================================

Procedure TGDBDebugger.Disassemble(func: String);
Begin
    Assert(False, 'TGDBDebugger.Disassemble: I am not redundant');
End;

//=================================================================

Procedure TGDBDebugger.OnDisassemble(Output: TStringList);
Begin
    Assert(False, 'TGDBDebugger.OnDisassemble: I am not redundant');
End;

//=================================================================


Procedure TGDBDebugger.SetAssemblySyntax(syntax: AssemblySyntax);
Begin
    Case syntax Of
        asIntel:
            QueueCommand(GDBflavour, 'intel');
        asATnT:
            QueueCommand(GDBflavour, 'att');
    End;
End;

//=================================================================

Function TGDBDebugger.GetVariableHint(name: String): String;
Var
    Command: TCommand;
Begin
    If (Not Executing) Or (Not Paused) Then
        Exit;

    Command := TCommand.Create;
    Command.OnResult := OnVariableHint;
    //Command.Command := 'print ' + name;
    Command.Command := format('%d%s%s %s', [TOOLTOKEN, GDBdataeval,
		      WriteGDBContext(SelectedThread, SelectedFrame), name]);


    //Send the command;
    QueueCommand(Command);
End;

//=================================================================

Procedure TGDBDebugger.OnVariableHint(Output: TStringList);
Begin
    //Call the callback
    If Assigned(TDebugger(Self).OnVariableHint) Then
        TDebugger(Self).OnVariableHint(Output[0]);
End;

Procedure TGDBDebugger.Go;
Var
    Command: TCommand;
Begin
    Command := TCommand.Create;
    If Not Started Then
        Command.Command := GDBrun
    Else
        Command.Command := GDBcontinue;
    Command.Callback := OnGo;
    QueueCommand(Command);
End;

//=================================================================

Procedure TGDBDebugger.OnGo;
Begin
    Inherited;
    Started := True;
End;

//=================================================================

Procedure TGDBDebugger.Launch(commandline, startupdir: String);
Var
    saAttr: TSecurityAttributes;

Begin

    saAttr.nLength := SizeOf(SECURITY_ATTRIBUTES);
    saAttr.bInheritHandle := True;
    saAttr.lpSecurityDescriptor := Nil;

    // Create a pipe for the child process's STDOUT.

    If (Not CreatePipe(g_hChildStd_OUT_Rd, g_hChildStd_OUT_Wr,
        @saAttr, 0)) Then
        DisplayError('Std_OUT CreatePipe');

    // Ensure the read handle to the pipe for STDOUT is not inherited.

    If (Not SetHandleInformation(g_hChildStd_OUT_Rd,
        HANDLE_FLAG_INHERIT, 0)) Then
        DisplayError('Std_OUT SetHandleInformation');

    // Create a pipe for the child process's STDIN.

    If (Not CreatePipe(g_hChildStd_IN_Rd, g_hChildStd_IN_Wr, @saAttr, 0)) Then
        DisplayError('Std_IN CreatePipe');

    // Ensure the write handle to the pipe for STDIN is not inherited.

    If (Not SetHandleInformation(g_hChildStd_IN_Wr,
        HANDLE_FLAG_INHERIT, 0)) Then
        DisplayError('Std_IN SetHandleInformation');

    //  Pipes created

    //-----------------------------------------------------------------

    // Start the Reader thread

    // May want to pass the TDebugger address to ReadThread

    Reader := ReadThread.Create(True);
    Reader.ReadChildStdOut := g_hChildStd_OUT_Rd;
    Reader.FreeOnTerminate := True;
    Reader.Resume;

    //---------------------------------------------------------

    // Create a child process that uses the previously created pipes for STDIN and STDOUT.

    CreateChildProcess(commandline, g_hChildStd_IN_Rd,
        g_hChildStd_OUT_Wr, g_hChildStd_OUT_Wr);

    // Reader Thread created & running

    If (Not CloseHandle(g_hChildStd_OUT_Wr)) Then
        DisplayError('CloseHandle Std_OUT');
    If (Not CloseHandle(g_hChildStd_IN_Rd)) Then
        DisplayError('CloseHandle Std_IN');

    Reader.Resume;

End;

//============================================

Procedure TGDBDebugger.WriteToPipe(Buffer: String);

Var
    BytesWritten: DWORD;

Begin
    BytesWritten := 0;

    Buffer := Buffer + NL;               // GDB requires a newline

    // Send it to the pipe
    WriteFile(g_hChildStd_IN_Wr, Pchar(Buffer)^, Length(Buffer),
        BytesWritten, Nil);

End;

//=============================================================

Function TGDBDebugger.Result(buf: Pchar; bsize: PLongInt): Pchar;
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

Var
    OutputBuffer: String;
    msg: String;
    Mainmsg, AllReason, ThreadID: String;
    thread: Integer;

Begin
	   If (MainForm.VerboseDebug.Checked) Then
	   Begin
		      AddtoDisplay('Parsing ^');
	   End;

    Result := Nil;
    msg := breakOut(@buf, bsize);
    msg := AnsiMidStr(msg, 2, Maxint - 1);

    If (MainForm.VerboseDebug.Checked) Then
    Begin
        OutputBuffer := msg;
      // gui_critSect.Enter();
        AddtoDisplay(OutputBuffer);
      // gui_critSect.Leave();
    End;

    If (Not (msg = '')) Then
    Begin
        If (AnsiStartsStr(GDBerror, msg)) Then
        Begin
            Mainmsg := StringReplace(msg, 'msg="', '', []);
            Mainmsg := StringReplace(Mainmsg, '\', '', [rfReplaceAll]);

            If ((Token >= WATCHTOKENBASE) And (Token < MODVARTOKEN)) Then
                ParseWatchpointError(Mainmsg)
            Else
            If (Mainmsg = GDBassignerror) Then
            Begin
                DisplayError('This Variable is not editable');
            End
            Else
                DisplayError('GDB Error: ' + Mainmsg);
        End

        Else
        If (AnsiStartsStr(GDBrunning, msg)) Then
        Begin
          // get rest into , &AllReason))
            AllReason := AnsiRightStr(msg, (Length(msg) - Length(GDBrunning)));
            TargetIsRunning := True;
          // gui_critSect.Enter();
          //MainForm.SetRunStatus(true);
          // gui_critSect.Leave();

            If (ParseConst(@AllReason, @GDBthreadid, PString(@threadID))) Then
            Begin
                If (threadID = GDBall) Then
                Begin
                    OutputBuffer := 'Running all threads';
                End
                Else
                Begin
                    thread := StrToInt(threadID);
			                 CurrentGDBThread := thread;
                    SelectedThread := thread;
                    SelectedFrame := 0;
                    OutputBuffer := Format('Running thread %d', [thread]);
                    AddtoDisplay(OutputBuffer);
                End;
            End;
        End

        Else
        If (AnsiStartsStr(GDBExitmsg, msg)) Then
        Begin
            AddtoDisplay('GDB is exiting');
            Cleanup;
        End

        Else
        If (AnsiStartsStr(GDBdone + GDBbkpt, msg)) Then
        Begin
            ParseBreakpoint(msg, Nil);
        End

        Else
        If (AnsiStartsStr(GDBdone + GDBbkpttable, msg)) Then
        Begin
            ParseBreakpointTable(msg);
        End

        Else
        If (AnsiStartsStr(GDBdone + GDBstack, msg)) Then
        Begin
            ParseStack(msg);
        End

        Else
        If (AnsiStartsStr(GDBdone + GDBlocalsq, msg)) Then
        Begin
            OutputBuffer := ExtractLocals(@msg);  // Parses & Reassembles Result
            If (MainForm.VerboseDebug.Checked) Then
				            AddtoDisplay(OutputBuffer);
        End

        Else
        If (AnsiStartsStr(GDBdone + GDBthreads, msg)) Then
        Begin
            ParseThreads(msg);
        End

        Else
        If (AnsiStartsStr(GDBdone + GDBwpt, msg)) Then
        Begin
            ParseWatchpoint(msg);
        End

        Else
        If (AnsiStartsStr(GDBdone + GDBwpta, msg)) Then
        Begin
            ParseWatchpoint(msg);
        End

        Else
        If (AnsiStartsStr(GDBdone + GDBwptr, msg)) Then
        Begin
            ParseWatchpoint(msg);
        End

        Else
        If (AnsiStartsStr(GDBdone + GDBregnames, msg)) Then
        Begin
            ParseRegisterNames(msg);
        End

        Else
        If (AnsiStartsStr(GDBdone + GDBmemq, msg)) Then
        Begin
            ParseCPUMemory(msg);
        End

        Else
        If (AnsiStartsStr(GDBdone + GDBasminst, msg)) Then
        Begin
            ParseCPUDisassem(msg);
        End

        Else
        If (AnsiStartsStr(GDBdone + GDBregvalues, msg)) Then
        Begin
            ParseRegisterValues(msg);
        End;

        If ((AnsiStartsStr(GDBdone + GDBnameq, msg))
            And Not (Token = MODVARTOKEN)) Then  // It's not from Modify Variable
        Begin
            ParseVObjCreate(msg);           // if it was a VObj create...
        End;

        If (AnsiStartsStr(GDBdone + GDBvalue, msg)) Then
        Begin
            If ((Token >= WATCHTOKENBASE) And (Token < MODVARTOKEN)) Then
                FillWatchValue(msg)         // it came from a request from GetWatchedValues
            Else
            If ((Token = TOOLTOKEN)) Then
                FillTooltipValue(msg)       // it came from a request from Tooltip (GetVariableHint)
            Else
                ParseVObjAssign(msg);       // else it was a VObj assign
//                                            or another -data-evaluate-expression...

        End;

        Result := buf;

    End;
End;

//=================================================================

Function TGDBDebugger.ExecResult(buf: Pchar; bsize: PLongInt): Pchar;
{
   Part of Second Level Parse of Output.

   Looks from beginning up to [0x0d][0x0a] pair.
   Returns pointer to start of unprocessed buffer, else if nothing left: NULL
   bsize is updated to reflect new size of unprocessed part.
   Note: embedded cr-lf are replaced by nulls.
}

Var
    OutputBuffer: String;
    msg: String;
    AllReason: String;
    Reason: String;
    Errmsg: String;

    threadID: String;
    thread: Longint;

Begin

	   If (MainForm.VerboseDebug.Checked) Then
	   Begin
		      AddtoDisplay('Parsing *');
	   End;

    ExecResult := Nil;
    msg := breakOut(@buf, bsize);
    msg := AnsiMidStr(msg, 2, Maxint - 1);


    If (MainForm.VerboseDebug.Checked) Then
    Begin
        OutputBuffer := msg;
        // gui_critSect.Enter();
        AddtoDisplay(OutputBuffer);
        // gui_critSect.Leave();
    End;


    If (Not (msg = '')) Then
    Begin
        If (AnsiStartsStr(GDBrunning, msg)) Then
        Begin
            // get rest into , &AllReason))
            AllReason := AnsiRightStr(msg, (Length(msg) - Length(GDBrunning)));
            TargetIsRunning := True;

            If (ParseConst(@AllReason, @GDBthreadid, PString(@threadID))) Then
                If (threadID = GDBall) Then
                    OutputBuffer :=
                        'Running all threads'
                Else
                Begin
                    thread := StrToInt(threadID);
                    OutputBuffer := Format('Running thread %d', [thread]);
					               CurrentGDBThread := thread;
					               SelectedThread := thread;
					               SelectedFrame := 0;
                    AddtoDisplay(OutputBuffer);
                End;
        End
        Else
        If (AnsiStartsStr(GDBstopped, msg)) Then
        Begin
			         If (ParseConst(@msg, @GDBthreadid, PInteger(@thread))) Then
			         Begin
				            CurrentGDBThread := thread;
				            SelectedThread := thread;
				            SelectedFrame := 0;
			         End;

            If (TargetIsRunning) Then
                RefreshContext;

            TargetIsRunning := False;

            If (ParseConst(@msg, @GDBreason, PString(@Reason))) Then
                If (Reason = GDBExitnormal) Then
                Begin
                    // gui_critSect.Enter();
                    AddtoDisplay('Stopped - Exited normally');
                    // gui_critSect.Leave();
                    Started := False;
					               ExitDebugger;

                    CloseDebugger(Nil);
                End
                Else
                If (Reason = GDBbkpthit) Then
                Begin
                    If (MainForm.VerboseDebug.Checked) Then
					               Begin
						// gui_critSect.Enter();
						                  AddtoDisplay('Stopped - breakpoint-hit');
						// gui_critSect.Leave();
                    End;
					               BreakpointHit(@msg);
                End
                Else
                If (Reason = GDBwptrig) Then
                Begin
                    If (MainForm.VerboseDebug.Checked) Then
					               Begin
						// gui_critSect.Enter();
						                  AddtoDisplay('Stopped - watchpoint-trigger');
						// gui_critSect.Leave();
					               End;
                    WatchpointHit(@msg);
                End
                Else
                If (Reason = GDBwptrigr) Then
                Begin
                    If (MainForm.VerboseDebug.Checked) Then
					               Begin
						// gui_critSect.Enter();
						                  AddtoDisplay('Stopped - read-watchpoint-trigger');
						// gui_critSect.Leave();
					               End;
                    WatchpointHit(@msg);
                End
                Else
                If (Reason = GDBwptriga) Then
                Begin
                    If (MainForm.VerboseDebug.Checked) Then
					               Begin
						// gui_critSect.Enter();
						                  AddtoDisplay('Stopped - access-watchpoint-trigger');
						// gui_critSect.Leave();
					               End;
                    WatchpointHit(@msg);
                End
                Else
                If (Reason = GDBendstep) Then
                Begin
                    If (MainForm.VerboseDebug.Checked) Then
					               Begin
						// gui_critSect.Enter();
						                  AddtoDisplay('Stopped - end-stepping-range');
						// gui_critSect.Leave();
					               End;
                    StepHit(@msg);
                End
				            Else
                If (Reason = GDBwpscope) Then
				            Begin
					// gui_critSect.Enter();
					               AddtoDisplay('Stopped - watchpoint-scope');
					// gui_critSect.Leave();
					               WptScope(@msg);
				            End
                Else
                If (Reason = GDBsigrcv) Then
                Begin
                    AddtoDisplay('Stopped - signal received');
                    SigRecv(@msg);
                End
                Else
                Begin
                    Errmsg := AnsiReplaceStr(Errmsg, 'msg="', '');
                    Errmsg := AnsiReplaceStr(Errmsg, '\"', '');
                    DisplayError('GDB Error:' + Errmsg);
                End;
        End;
        ExecResult := buf;
    End;
End;

//===============================================

Procedure TGDBDebugger.FirstParse;
Var

    BufMem: Pchar;          // Keep a copy of the originally allocated memory
    //  so that we can free the memory
Begin
    BufMem := buf;           // because pointer 'buf' gets moved!

    While ((bytesInBuffer > 0) And Not (buf = Nil)) Do
	       // && some arbitrary counter to prevent an infinite loop in case
	       // a programming error fails to clear the buffer?
        If ((buf^ >= '0') And (buf^ <= '9')) Then
		          // a token
        Begin
            buf := GetToken(buf, @bytesInBuffer, @Token);
            If (MainForm.VerboseDebug.Checked) Then
                AddtoDisplay('Token ' + IntToStr(Token));
        End
        Else
        If (buf^ = '~') Then
		          // console stream
		          // Not of interest: display it

            buf := SendToDisplay(buf, @bytesInBuffer, True)

        Else
        If (buf^ = '=') Then
		          // notify async
			         buf := Notify(buf, @bytesInBuffer, MainForm.VerboseDebug.Checked)
        Else
        If ((buf^ = '@') Or (buf^ = '&')) Then
		          // target output ||  log stream
		          // Not of interest: display it

            buf := SendToDisplay(buf, @bytesInBuffer, MainForm.VerboseDebug.Checked)

        Else
        If (buf^ = '^') Then
		          // A result or error
        Begin
			         // gui_critSect.Enter();
            If (MainForm.VerboseDebug.Checked) Then
                AddtoDisplay('Result or Error:');
			         // gui_critSect.Leave();
            buf := Result(buf, @bytesInBuffer);
        End
        Else
        If (buf^ = '*') Then
		          // executing async
        Begin
			         // gui_critSect.Enter();
            If (MainForm.VerboseDebug.Checked) Then
                AddtoDisplay('Executing Async:');
			         // gui_critSect.Leave();
            buf := ExecResult(buf, @bytesInBuffer);
        End
        Else
        If (buf^ = '+') Then
		          // status async
        Begin
            If (MainForm.VerboseDebug.Checked) Then
                AddtoDisplay('Status Output:');
            buf := SendToDisplay(buf, @bytesInBuffer, MainForm.VerboseDebug.Checked);
        End
        Else
        If (buf^ = '(') Then
		          // might be GDB prompt - cannot really be anything else!
        Begin


            If (MainForm.VerboseDebug.Checked) Then
			         Begin
			    //gui_critSect.Enter(); 
				            AddtoDisplay('GDB Ready');
			    //gui_critSect.Leave();
			         End;
            buf := SendToDisplay(buf, @bytesInBuffer, MainForm.VerboseDebug.Checked);
        End
        Else
		          // Don't know, what is left?
        Begin
			// gui_critSect.Enter();
            AddtoDisplay('Cannot decide about:');
			// gui_critSect.Leave();
            buf := SendToDisplay(buf, @bytesInBuffer, MainForm.VerboseDebug.Checked);
        End;

    FreeMem(BufMem);
    // The reader will only get the next lot from
    // the pipe buffer when it sees this:
    buf := Nil;
	   SentCommand := False;    // Requests next command to be sent from queue
    fPaused := True;
    SendCommand;             //  (these are only needed to maintain sync. between
    //  the outgoing and incoming data streams).

End;

//=============================================================

Function TGDBDebugger.Notify(buf: Pchar; bsize: PLongInt; verbose: Boolean): Pchar;
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

Var
    OutputBuffer: String;
    msg: String;

Begin

    If (verbose) Then
    Begin
	// gui_critSect.Enter();
	       AddtoDisplay('Parsing =');
	// gui_critSect.Leave();
    End;

    Result := Nil;
    msg := breakOut(@buf, bsize);
    msg := AnsiMidStr(msg, 2, Maxint - 1);

    If (verbose) Then
    Begin
		      OutputBuffer := msg;
		// gui_critSect.Enter();
		      AddtoDisplay(OutputBuffer);
		// gui_critSect.Leave();
    End;

    If (Not (msg = '')) Then
	   Begin
		      If (AnsiStartsStr(GDBthreadgcr, msg)) Then
		// Only extract Target PID for now - can add more if required
			         ParseConst(@msg, @GDBidq, PInteger(@TargetPID));

		      Result := buf;

	   End;
End;

//=============================================================

Function TGDBDebugger.breakOut(Next: PPChar; bsize: PLongInt): String;
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
Var
    s, c: Pchar;

Begin
    breakOut := '';
    s := Next^;
    c := Next^;

    While (Not (c^ = CR) And (c < (Next^ + bsize^))) Do
        Inc(c);
    c^ := #0;
    Inc(c);
    If (c^ = LF) Then
    Begin
        c^ := #0;
        Inc(c);
    End;
    bsize^ := bsize^ - (c - s);
    If (bsize^ <= 0) Then                         // nothing remains
        Next^ := Nil
    Else
        Next^ := c;
    breakOut := s;                                // copies NULL-terminated part


End;

//=============================================================

Function TGDBDebugger.GetToken(buf: Pchar; bsize: PLongInt;
    Token: PInteger): Pchar;
Var
    OutputBuffer: String;
    c, s: Pchar;
    sToken: String;

Begin
{
   Part of Second Level Parse of Output.

   Looks from beginning up to first non-digit.
   Returns pointer to start of unprocessed buffer, else if nothing left: NULL
   bsize is updated to reflect new size of unprocessed part.
}

    If (MainForm.VerboseDebug.Checked) Then
    Begin
    // gui_critSect.Enter();
	       AddtoDisplay('Parsing Token');
	// gui_critSect.Leave();
    End;

    c := buf;
    s := buf;

    While ((c^ >= '0') And (c^ <= '9') And (c < (buf + bsize^))) Do
    Begin
        sToken := sToken + c^;
        Inc(c);
    End;

    If (c = s) Then
    Begin
        Token^ := 0;                  // We should never get here
        GetToken := c;                // return c;
    End
    Else
    Begin
        Try
            Token^ := StrToInt(sToken);
        Except
            Token^ := 0;
        End;

        bsize^ := bsize^ - (c - s);
        If (bsize^ = 0) Then                          // nothing remains
            GetToken := Nil
        Else
            GetToken := c;
    End;
End;

//=================================================================

Function TGDBDebugger.SendToDisplay(buf: Pchar; bsize: PLongInt;
    verbose: Boolean): Pchar;
Var
    OutputBuffer: String;
    msg: String;

Begin
{
/*
   Part of Second Level Parse of Output.

   Sends from beginning up to [0x0d][0x0a] pair to display.
   Returns pointer to start of unprocessed buffer, else if nothing left: NULL
   bsize is updated to reflect new size of unprocessed part.
   Note: embedded cr or cr-lf are replaced by nulls.
 */
}

    If (verbose) Then
    Begin
    // gui_critSect.Enter();
	       AddtoDisplay('Output to Display...');
	// gui_critSect.Leave();
    End;

    If ((buf = Nil) Or (bsize^ = 0)) Then
        SendToDisplay := Nil
    Else
    Begin
        msg := breakOut(@buf, bsize);
        If (Not (AnsiLeftStr(msg, 5) = GDBPrompt)) Then
            // Special case exception: "(gdb)"
            msg := AnsiMidStr(msg, 2, Maxint - 1);

        If (verbose) Then
        Begin
            OutputBuffer := msg;
            // gui_critSect.Enter();
            AddtoDisplay(OutputBuffer);
            // gui_critSect.Leave();
        End;


        If (bsize^ = 0) Then  // nothing remains
            SendToDisplay := Nil
        Else
            SendToDisplay := buf;
    End;
End;

//===================================================

Procedure TGDBDebugger.Next;
Var
    Command: TCommand;
Begin
    Command := TCommand.Create;
    Command.Command := GDBnext;
    Command.Callback := OnTrace;
    QueueCommand(Command);
End;

//=================================================================

Procedure TGDBDebugger.Step;
Var
    Command: TCommand;
Begin
    Command := TCommand.Create;
    Command.Command := GDBstep;
    Command.Callback := OnTrace;
    QueueCommand(Command);
End;

//=================================================================

Procedure TGDBDebugger.Finish;
Var
    Command: TCommand;
Begin
    Command := TCommand.Create;
    Command.Command := GDBfinish;
		//was Command.Command := devData.DebugCommand;
    Command.Callback := OnTrace;
    QueueCommand(Command);

End;

//=================================================================

Procedure TGDBDebugger.OnTrace;
Begin
    JumpToCurrentLine := True;
    fPaused := False;
    fBusy := False;
End;

//=================================================================

Procedure TGDBDebugger.Pause;
Begin
    //Do nothing. GDB does not support break-ins.
End;

//=================================================================

Procedure TGDBDebugger.SetThread(thread: Integer);
Begin
    // QueueCommand('-thread-select ', IntToStr(thread));
	   SelectedThread := thread;
    RefreshContext;
End;

//=================================================================

Procedure TGDBDebugger.SetFrame(frame: Integer);
Begin
    // QueueCommand('-stack-select-frame ', IntToStr(frame));
	   SelectedFrame := frame;
    RefreshContext([cdLocals, cdWatches]);
End;


//==================================================================
Procedure TGDBDebugger.SigRecv(Msg: PString);
// Parses out Signal details

Var
    Temp: String;
    Thread, Line: Integer;
    SigName, SigMeaning, Func, SrcFile, frame, Output: String;
  // Ret: Boolean;

Begin

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

    If (SigName = GDBsigsegv) Then
        OnAccessViolation;
  // else any other signal?

End;

// ----------------------------------------

Procedure TGDBDebugger.FillBreakpointNumber(SrcFile: PString; Line: Integer; Num: Integer);
{

   Part of Third Level Parse of Output.
   Fills Breakpoint table with GDB's breakpoint number
}
Var
    I: Integer;
Begin

    For I := 0 To Breakpoints.Count - 1 Do
        If (PBreakpoint(Breakpoints[I])^.Filename = SrcFile^) And
            (PBreakpoint(Breakpoints[I])^.Line = Line) Then
        Begin
            PBreakpoint(Breakpoints[I])^.BPNumber := Num;
            Break;
        End;
End;

//------------------------------------------------------------------------------
// TCDBDebugger
//------------------------------------------------------------------------------
Constructor TCDBDebugger.Create;
Begin
    Inherited;
End;

Destructor TCDBDebugger.Destroy;
Begin
    Inherited;
End;

Procedure TCDBDebugger.Execute(filename, arguments: String);
Const
    InputPrompt = '^([0-9]+):([0-9]+)>';
Var
    Executable: String;
    WorkingDir: String;
    Srcpath: String;
    I: Integer;
Begin
    //Heck about the breakpoint thats coming.
    IgnoreBreakpoint := True;
    self.FileName := filename;

    //Get the name of the debugger
    If (devCompiler.gdbName <> '') Then
        Executable := devCompiler.gdbName
    Else
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
    If Assigned(MainForm.fProject) Then
        WorkingDir := MainForm.fProject.CurrentProfile.ExeOutput;


    Launch(Executable, WorkingDir);

    //Tell the wait function that another valid output terminator is the 0:0000 prompt
    //Wait.OutputTerminators.Add(InputPrompt);

    //Send the source mode setting (enable all except ONLY source)
    QueueCommand('l+t; l+l; l+s', '');

    //Set all the paths
    Srcpath := ExtractFilePath(Filename) + ';';
    For I := 0 To IncludeDirs.Count - 1 Do
        Srcpath := Srcpath + IncludeDirs[I] + ';';
    QueueCommand('.srcpath+', Srcpath);
    QueueCommand('.exepath+', ExtractFilePath(Filename));
End;

Procedure TCDBDebugger.Attach(pid: Integer);
Const
    InputPrompt = '^([0-9]+):([0-9]+)>';
Var
    Executable: String;
    Srcpath: String;
    I: Integer;
Begin
    //Heck about the breakpoint thats coming.
    IgnoreBreakpoint := True;
    self.FileName := filename;

    //Get the name of the debugger
    If (devCompiler.gdbName <> '') Then
        Executable := devCompiler.gdbName
    Else
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
    For I := 0 To IncludeDirs.Count - 1 Do
        Srcpath := Srcpath + IncludeDirs[I] + ';';
    QueueCommand('.srcpath+', Srcpath);
    QueueCommand('.exepath+', ExtractFilePath(Filename));
End;

Procedure TCDBDebugger.OnOutput(Output: String);
Const
    InputPrompt = '^([0-9]+):([0-9]+)>';
Var
    NewLines: TStringList;
    RegExp: TRegExpr;
    CurrBp: TBreakpoint;
    CurLine: String;

    Procedure FlushOutputBuffer;
    Begin
        If NewLines.Count <> 0 Then
        Begin
            MainForm.DebugOutput.Lines.BeginUpdate;
            MainForm.DebugOutput.Lines.AddStrings(NewLines);
            MainForm.DebugOutput.Lines.EndUpdate;
            SendMessage(MainForm.DebugOutput.Handle, $00B6 {EM_LINESCROLL}, 0,
                MainForm.DebugOutput.Lines.Count);
            NewLines.Clear;
        End;
    End;

    Procedure ParseError(Const line: String);
    Begin
        If RegExp.Substitute('$3') = 'c0000005' Then
            OnAccessViolation
        Else
        If RegExp.Substitute('$3') = '40010005' Then

        Else
        If RegExp.Substitute('$3') = 'c00000fd' Then

        Else
        If RegExp.Substitute('$3') = '80000003' Then
            If IgnoreBreakpoint Then
                IgnoreBreakpoint := False
            Else
                OnBreakpoint;
    End;

    Procedure ParseOutput(Const line: String);
    Begin
        If RegExp.Exec(line, InputPrompt) Then
        Begin
            //The debugger is waiting for input, we're paused!
            SentCommand := False;
            fPaused := True;
            fBusy := False;

            //Because we are here, we probably are a side-effect of a previous instruction
            //Execute the process function for the command.
            If (CurOutput.Count <> 0) And (CurrentCommand <> Nil) And
                Assigned(CurrentCommand.OnResult) Then
                CurrentCommand.OnResult(CurOutput);

            If CurrentCommand <> Nil Then
                If (CurrentCommand.Command = 'g'#10) Or
                    (CurrentCommand.Command = 't'#10) Or
                    (CurrentCommand.Command = 'p'#10) Then
                Begin
                    RefreshContext;
                    Application.BringToFront;
                End;
            CurOutput.Clear;

            //Send the command, and do not send any more
            FlushOutputBuffer;
            SendCommand;

            //Make sure we don't save the current line!
            Exit;
        End;

        If RegExp.Exec(line, 'DBGHELP: (.*) - no symbols loaded') Then
        Begin
            If LowerCase(RegExp.Substitute('$1')) =
                LowerCase(ChangeFileExt(ExtractFileName(Filename), '')) Then
                OnNoDebuggingSymbolsFound;
        End
        Else
        If RegExp.Exec(line,
            'ModLoad: +([0-9a-fA-F]{1,8}) +([0-9a-fA-F]{1,8}) +(.*)') Then
            MainForm.StatusBar.Panels[3].Text :=
                'Loaded ' + RegExp.Substitute('$3')
        Else
        If RegExp.Exec(line,
            '\((.*)\): (.*) - code ([0-9a-fA-F]{1,8}) \((.*)\)') Then
            ParseError(line)
        Else
        If RegExp.Exec(line, 'Breakpoint ([0-9]+) hit') Then
        Begin
            CurrBp := GetBreakpointFromIndex(
                StrToInt(RegExp.Substitute('$1')));
            If CurrBp <> Nil Then
                MainForm.GotoBreakpoint(CurrBp.Filename, CurrBp.Line)
            Else
                JumpToCurrentLine := True;
        End;

        CurOutput.Add(Line);
    End;
Begin
    //Update the memo
    Screen.Cursor := crHourglass;
    Application.ProcessMessages;
    RegExp := TRegExpr.Create;
    NewLines := TStringList.Create;

    Try
        While Pos(#10, Output) > 0 Do
        Begin
            //Extract the current line
            CurLine := Copy(Output, 0, Pos(#10, Output) - 1);

            //Process the output
            If Not AnsiStartsStr('DBGHELP: ', CurLine) Then
                NewLines.Add(CurLine);
            ParseOutput(CurLine);

            //Remove those that we've already processed
            Delete(Output, 1, Pos(#10, Output));
        End;

        If Length(Output) > 0 Then
        Begin
            NewLines.Add(Output);
            ParseOutput(Output);
        End;
    Except
        on E: Exception Do
            madExcept.HandleException;
    End;

    //Add the new lines to the edit control if we have any
    FlushOutputBuffer;

    //Clean up
    RegExp.Free;
    NewLines.Free;
    Screen.Cursor := crDefault;
End;

Procedure TCDBDebugger.AddIncludeDir(s: String);
Begin
    IncludeDirs.Add(s);
    If Executing Then
        QueueCommand('.sympath+', s);
End;

Procedure TCDBDebugger.ClearIncludeDirs;
Begin
    IncludeDirs.Clear;
End;

Procedure TCDBDebugger.AddBreakpoint(breakpoint: TBreakpoint);
Var
    aBreakpoint: PBreakpoint;
Begin
    If (Not Paused) And Executing Then
    Begin
        MessageDlg('Cannot add a breakpoint while the debugger is executing.',
            mtError, [mbOK], MainForm.Handle);
        Exit;
    End;

    New(aBreakpoint);
    aBreakpoint^ := breakpoint;
    Breakpoints.Add(aBreakpoint);
    RefreshBreakpoint(aBreakpoint^);
End;

Procedure TCDBDebugger.RemoveBreakpoint(breakpoint: TBreakpoint);
Var
    I: Integer;
Begin
    If (Not Paused) And Executing Then
    Begin
        MessageDlg('Cannot remove a breakpoint while the debugger is executing.', mtError, [mbOK], MainForm.Handle);
        Exit;
    End;

    For i := 0 To Breakpoints.Count - 1 Do
        If (PBreakPoint(Breakpoints.Items[i])^.line = breakpoint.Line) And
            (PBreakPoint(Breakpoints.Items[i])^.editor =
            breakpoint.Editor) Then
        Begin
            If Executing Then
                QueueCommand('bc',
                    IntToStr(PBreakpoint(Breakpoints.Items[i])^.Index));
            Dispose(Breakpoints.Items[i]);
            Breakpoints.Delete(i);
            Break;
        End;
End;

Procedure TCDBDebugger.RefreshBreakpoint(Var breakpoint: TBreakpoint);
Var
    Command: TCommand;
Begin
    If Executing Then
    Begin
        Inc(fNextBreakpoint);
        breakpoint.Valid := True;
        breakpoint.Index := fNextBreakpoint;
        Command := TCommand.Create;
        Command.Data := breakpoint;
        Command.Command :=
            Format('bp%d `%s:%d`', [breakpoint.Index, breakpoint.Filename,
            breakpoint.Line]);
        Command.OnResult := OnBreakpointSet;
        QueueCommand(Command);
    End;
End;

Procedure TCDBDebugger.OnBreakpointSet(Output: TStringList);
Var
    e: TEditor;
Begin
    If CurrentCommand.Data = Nil Then
        Exit;

    With TBreakpoint(CurrentCommand.Data) Do
    Begin
        Valid := False;
        e := MainForm.GetEditorFromFileName(FileName, True);
        If e <> Nil Then
            e.InvalidateGutter;
    End;
End;

Procedure TCDBDebugger.RefreshContext(refresh: ContextDataSet);
Var
    I: Integer;
    Node: TTreeNode;
    Command: TCommand;
    MemberName: String;
Begin
    If Not Executing Then
        Exit;

    //First send commands for stack tracing, locals and the threads list
    If cdCallStack In refresh Then
    Begin
        Command := TCommand.Create;
        Command.Command := 'kp 512';
        Command.OnResult := OnCallStack;
        QueueCommand(Command);
    End;
    If cdLocals In refresh Then
    Begin
        Command := TCommand.Create;
        Command.Command := 'dv -i -v';
        Command.OnResult := OnLocals;
        QueueCommand(Command);
    End;
    If cdThreads In refresh Then
    Begin
        Command := TCommand.Create;
        Command.Command := '~';
        Command.OnResult := OnThreads;
        QueueCommand(Command);
    End;

    //Then update the watches
    If (cdWatches In refresh) And Assigned(DebugTree) Then
    Begin


    End;
End;

Procedure TCDBDebugger.OnRefreshContext(Output: TStringList);
Begin
End;

Procedure TCDBDebugger.AddWatch(varname: String; when: TWatchBreakOn);
Var
    Command: TCommand;
    bpType: String;
    Watch: PWatch;
Begin

End;

Procedure TCDBDebugger.RefreshWatches;
Begin
End;

Procedure TCDBDebugger.OnCallStack(Output: TStringList);
Var
    I: Integer;
    RegExp: TRegExpr;
    CallStack: TList;
    StackFrame: PStackFrame;
Begin
    CallStack := TList.Create;
    RegExp := TRegExpr.Create;

    For I := 0 To Output.Count - 1 Do
        If RegExp.Exec(Output[I], 'ChildEBP RetAddr') Then
            Continue
        Else
        If RegExp.Exec(Output[I],
            '([0-9a-fA-F]{1,8}) ([0-9a-fA-F]{1,8}) (.*)!(.*)\((.*)\)(|.*) \[(.*) @ ([0-9]*)\]')
        Then
        Begin
            //Stack frame with source information
            New(StackFrame);
            CallStack.Add(StackFrame);

            //Fill the fields
            With StackFrame^ Do
            Begin
                Filename := RegExp.Substitute('$7');
                Line := StrToInt(RegExp.Substitute('$8'));
                FuncName := RegExp.Substitute('$4$6');
                Args := RegExp.Substitute('$5');
            End;
        End
        Else
        If RegExp.Exec(Output[I],
            '([0-9a-fA-F]{1,8}) ([0-9a-fA-F]{1,8}) (.*)!(.*)(|\((.*)\))(.*)')
        Then
        Begin
            //Stack frame without source information
            New(StackFrame);
            CallStack.Add(StackFrame);

            //Fill the fields
            With StackFrame^ Do
            Begin
                FuncName := RegExp.Substitute('$4$6');
                Args := RegExp.Substitute('$5');
                Line := 0;
            End;
        End;

    //Now that we have the entire callstack loaded into our list, call the function
    //that wants it
    If Assigned(TDebugger(Self).OnCallStack) Then
        TDebugger(Self).OnCallStack(CallStack);

    //Do we show the new execution point?
    If JumpToCurrentLine Then
    Begin
        JumpToCurrentLine := False;
        MainForm.GotoTopOfStackTrace;
    End;

    //Clean up
    RegExp.Free;
    CallStack.Free;
End;

Procedure TCDBDebugger.OnThreads(Output: TStringList);
Var
    I: Integer;
    Thread: PDebuggerThread;
    Threads: TList;
    RegExp: TRegExpr;
    Suspended, Frozen: Boolean;
Begin
    Threads := TList.Create;
    RegExp := TRegExpr.Create;

    For I := 0 To Output.Count - 1 Do
        If RegExp.Exec(Output[I],
            '([.#]*)( +)([0-9]*)( +)Id: ([0-9a-fA-F]*)\.([0-9a-fA-F]*) Suspend: ([0-9a-fA-F]*) Teb: ([0-9a-fA-F]{1,8}) (.*)') Then
        Begin
            New(Thread);
            Threads.Add(Thread);

            //Fill the fields
            With Thread^ Do
            Begin
                Active := RegExp.Substitute('$1') = '.';
                Index := RegExp.Substitute('$3');
                ID := RegExp.Substitute('$5.$6');
                Suspended := RegExp.Substitute('$7') <> '0';
                Frozen := RegExp.Substitute('$9') = 'frozen';
                If Suspended And Frozen Then
                    ID := ID + ' (Suspended, Frozen)'
                Else
                If Suspended Then
                    ID := ID + ' (Suspended)'
                Else
                If Frozen Then
                    ID := ID + ' (Frozen)';
            End;
        End;

    //Pass the locals list to the callback function that wants it
    If Assigned(TDebugger(Self).OnThreads) Then
        TDebugger(Self).OnThreads(Threads);

    //Clean up
    Threads.Free;
    RegExp.Free;
End;

Procedure TCDBDebugger.OnLocals(Output: TStringList);
Var
    I: Integer;
    Local: PVariable;
    Locals: TList;
    RegExp: TRegExpr;
    Command: TCommand;
Begin
    Locals := TList.Create;
    LocalsList := TList.Create;
    RegExp := TRegExpr.Create;

    For I := 0 To Output.Count - 1 Do
        If RegExp.Exec(Output[I],
            '(.*)( +)(.*)( +)([0-9a-fA-F]{1,8}) +(.*) = (.*)') Then
        Begin
            New(Local);
            Locals.Add(Local);

            //Fill the fields
            With Local^ Do
            Begin
                Name := RegExp.Substitute('$6');
                Value := RegExp.Substitute('$7');
                Location := RegExp.Substitute('$5');
            End;
        End;

    //Now that the locals list has a complete list of values, we want to get the
    //full variable stuff if it is a structure.
    Command := TCommand.Create;
    Command.Command := '';
    For I := 0 To Locals.Count - 1 Do
        With PVariable(Locals[I])^ Do
            If (Pos('class', Value) > 0) Or (Pos('struct', Value) > 0) Or
                (Pos('union', Value) > 0) Then
                Command.Command :=
                    Format('%sdt -r -b -n %s;', [Command.Command, Name])
            Else
            If Pos('[', Value) > 0 Then
                Command.Command :=
                    Format('%sdt -a -r -b -n %s;', [Command.Command, Name])
            Else
            If Pos('0x', Value) = 1 Then
                Command.Command :=
                    Format('%sdt -a -r -b -n %s;', [Command.Command, Name])
            Else
                LocalsList.Add(Locals[I]);

    If Command.Command <> '' Then
    Begin
        Command.OnResult := OnDetailedLocals;
        QueueCommand(Command);
    End
    Else
    Begin
        If Assigned(TDebugger(Self).OnLocals) Then
            TDebugger(Self).OnLocals(LocalsList);
        FreeAndNil(LocalsList);
    End;

    //Clean up
    Locals.Free;
    RegExp.Free;
End;

//This is a complete rip of the watch (dt) parsing code. But I have no choice...
Procedure TCDBDebugger.OnDetailedLocals(Output: TStringList);
Const
    NotFound = 'Cannot find specified field members.';
    PtrVarPrompt = '(.*) (.*) @ 0x([0-9a-fA-F]{1,8}) Type (.*?)([\[\]\*]+)';
    VarPrompt = '(.*) (.*) @ 0x([0-9a-fA-F]{1,8}) Type (.*)';
    StructExpr = '( +)[\+|=]0x([0-9a-fA-F]{1,8}) ([^ ]*)?( +): (.*)';
    ArrayExpr = '\[([0-9a-fA-F]*)\] @ ([0-9a-fA-F]*)';
    StructArrayExpr = '( *)\[([0-9a-fA-F]*)\] (.*)';
Var
    Variables: TStringList;
    SubStructure: TStringList;
    RegExp: TRegExpr;
    Local: PVariable;
    I, J: Integer;

    Function SynthesizeIndent(Indent: Integer): String;
    Var
        I: Integer;
    Begin
        Result := '';
        For I := 0 To Indent - 1 Do
            Result := Result + ' ';
    End;

    Procedure ParseStructure(Output: TStringList; exIndent: Integer); Forward;
    Procedure ParseStructArray(Output: TStringList; Indent: Integer);
    Var
        I: Integer;
        SubStructure: TStringList;
    Begin
        I := 0;
        Indent := 0;
        While I < Output.Count Do
            If RegExp.Exec(Output[I], StructArrayExpr) Then
            Begin
                Inc(I);
                If I >= Output.Count Then
                    Continue;

                If RegExp.Exec(Output[I], StructExpr) Then
                Begin
                    If Indent = 0 Then
                        Indent := Length(RegExp.Substitute('$1'));

                    SubStructure := TStringList.Create;
                    While I < Output.Count Do
                    Begin
                        If RegExp.Exec(Output[I], StructExpr) Then
                        Begin
                            If Length(RegExp.Substitute('$1')) < Indent Then
                                Break
                            Else
                            Begin SubStructure.Add(Output[I]); End;
                        End
                        Else
                        If RegExp.Exec(Output[I], StructArrayExpr) Then
                            If Length(RegExp.Substitute('$1')) <= Indent Then
                                Break
                            Else
                                SubStructure.Add(Output[I]);

                        Inc(I);
                    End;

                    //Determine if it is a structure or an array
                    ParseStructure(SubStructure, Indent + 4);
                    SubStructure.Free;
                    Dec(I);
                End;
            End;
    End;

    Procedure ParseStructure(Output: TStringList; exIndent: Integer);
    Var
        SubStructure: TStringList;
        Indent, I: Integer;
    Begin
        I := 0;
        Indent := 0;
        While I < Output.Count Do
        Begin
            If RegExp.Exec(Output[I], StructExpr) Or
                RegExp.Exec(Output[I], StructArrayExpr) Then
            Begin
                If Indent = 0 Then
                    Indent := Length(RegExp.Substitute('$1'));

                //Check if this is a sub-structure
                If Indent <> Length(RegExp.Substitute('$1')) Then
                Begin
                    //Populate the substructure string list
                    SubStructure := TStringList.Create;

                    While I < Output.Count Do
                    Begin
                        If RegExp.Exec(Output[I], StructArrayExpr) Or
                            RegExp.Exec(Output[I], StructExpr) Then
                            If Length(RegExp.Substitute('$1')) <= Indent Then
                            Begin
                                Inc(I);
                                Break;
                            End
                            Else
                                SubStructure.Add(Output[I]);
                        Inc(I);
                    End;

                    //Determine if it is a structure or an array
                    If SubStructure.Count <> 0 Then
                        If Trim(SubStructure[0])[1] = '[' Then
                            ParseStructArray(SubStructure, Indent + 4)
                        Else
                            ParseStructure(SubStructure, Indent + 4);
                    SubStructure.Free;

                    //Decrement I, since we will increment one at the end of the loop
                    Dec(I);
                End
                //Otherwise just add the value
                Else
                Begin
                    New(Local);
                    Local^.Name :=
                        SynthesizeIndent(Indent + exIndent) +
                        RegExp.Substitute('$3');
                    Local^.Value := RegExp.Substitute('$5');
                    LocalsList.Add(Local);
                End;
            End;

            //Increment I
            Inc(I);
        End;
    End;

    Procedure ParseArray(Output: TStringList; Indent: Integer);
    Var
        SubStructure: TStringList;
        Increment: Integer;
        I: Integer;
    Begin
        I := 0;
        While I < Output.Count Do
        Begin
            If RegExp.Exec(Output[I], ArrayExpr) Then
            Begin
                Inc(I, 2);
                Increment := 2;
                While Trim(Output[I]) = '' Do
                Begin
                    Inc(I);
                    Inc(Increment);
                End;

                //Are we an array (with a basic data type) or with a UDT?
                If RegExp.Exec(Output[I], StructExpr) Then
                Begin
                    With TRegExpr.Create Do
                    Begin
                        Exec(Output[I - Increment], ArrayExpr);
                        New(Local);
                        Local^.Name :=
                            SynthesizeIndent(Indent) + Substitute('$1');
                        LocalsList.Add(Local);
                        Free;
                    End;

                    //Populate the substructure string list
                    SubStructure := TStringList.Create;
                    While (I < Output.Count) And (Output[I] <> '') Do
                    Begin
                        SubStructure.Add(Output[I]);
                        Inc(I);
                    End;

                    //Process it
                    ParseStructure(SubStructure, Indent + 4);
                    SubStructure.Free;

                    //Decrement I, since we will increment one at the end of the loop
                    Dec(I);
                End
                Else
                    With TRegExpr.Create Do
                    Begin
                        Exec(Output[I - Increment], ArrayExpr);
                        New(Local);
                        Local^.Name :=
                            SynthesizeIndent(Indent) + Substitute('[$1]');
                        Local^.Value := Output[I];
                        LocalsList.Add(Local);
                        Inc(I);

                        If (I < Output.Count - 1) And
                            Exec(Output[I],
                            ' -> 0x([0-9a-fA-F]{1,8}) +(.*)') Then
                        Begin
                            New(Local);
                            Local^.Name :=
                                SynthesizeIndent(Indent + 4) +
                                Substitute('$1');
                            Local^.Value := Substitute('$2');
                            LocalsList.Add(Local);
                            Inc(I);
                        End
                        Else
                        If RegExp.Exec(Output[I], StructExpr) Then
                        Begin
                            //Populate the substructure string list
                            SubStructure := TStringList.Create;
                            While (I < Output.Count) And (Output[I] <> '') Do
                            Begin
                                SubStructure.Add(Output[I]);
                                Inc(I);
                            End;

                            //Process it
                            ParseStructure(SubStructure, Indent + 4);
                            SubStructure.Free;

                            //Decrement I, since we will increment one at the end of the loop
                            Dec(I);
                        End;
                        Free;
                    End;
            End;

            //Increment I
            Inc(I);
        End;
    End;
Begin
    SubStructure := TStringList.Create;
    Variables := TStringList.Create;
    RegExp := TRegExpr.Create;

    //Compute the list of commands
    I := 1;
    While I <= Length(CurrentCommand.Command) Do
    Begin
        If Copy(CurrentCommand.Command, I, 3) = '-n ' Then
        Begin
            Inc(I, 3);
            J := I;
            While I <= Length(CurrentCommand.Command) Do
            Begin
                If CurrentCommand.Command[I] = ';' Then
                Begin
                    Variables.Add(Copy(CurrentCommand.Command, J, I - J));
                    Break;
                End;
                Inc(I);
            End;
        End;
        Inc(I);
    End;

    //Set the type of the structure/class/whatever
    J := 0;
    I := 0;
    While I < Output.Count Do
        If RegExp.Exec(Output[I], PtrVarPrompt) Then
        Begin
            New(Local);
            Local^.Name := Variables[J];
            Local^.Value := RegExp.Substitute('$4$5');
            Local^.Location := RegExp.Substitute('0x$3');
            LocalsList.Add(Local);
            Inc(I);

            While (I < Output.Count) And Not
                RegExp.Exec(Output[I], VarPrompt) Do
            Begin
                SubStructure.Add(Output[I]);
                Inc(I);
            End;

            ParseArray(SubStructure, 4);
            SubStructure.Clear;
            Inc(J);
        End
        Else
        If RegExp.Exec(Output[I], VarPrompt) Then
        Begin
            New(Local);
            Local^.Name := Variables[J];
            Local^.Location := RegExp.Substitute('0x$3');
            Local^.Value := RegExp.Substitute('$4');
            LocalsList.Add(Local);
            Inc(I);

            While (I < Output.Count) And Not
                RegExp.Exec(Output[I], VarPrompt) Do
            Begin
                SubStructure.Add(Output[I]);
                Inc(I);
            End;

            ParseStructure(SubStructure, 4);
            SubStructure.Clear;
            Inc(J);
        End
        Else
            Inc(I);

    //Send the list of locals
    If Assigned(TDebugger(Self).OnLocals) Then
        TDebugger(Self).OnLocals(LocalsList);
    FreeAndNil(LocalsList);

    SubStructure.Free;
    Variables.Free;
    RegExp.Free;
End;

Procedure TCDBDebugger.GetRegisters;
Var
    Command: TCommand;
Begin
    If (Not Executing) Or (Not Paused) Then
        Exit;

    Command := TCommand.Create;
    Command.Command := 'r';
    Command.OnResult := OnRegisters;
    QueueCommand(Command);
End;

Procedure TCDBDebugger.OnRegisters(Output: TStringList);
Var
    I: Integer;
    RegExp: TRegExpr;
    Registers: TRegisters;
Begin
    RegExp := TRegExpr.Create;
    Registers := TRegisters.Create;

    For I := 0 To Output.Count - 1 Do
        If RegExp.Exec(Output[I],
            'eax=([0-9a-fA-F]{1,8}) ebx=([0-9a-fA-F]{1,8}) ecx=([0-9a-fA-F]{1,8}) edx=([0-9a-fA-F]{1,8}) esi=([0-9a-fA-F]{1,8}) edi=([0-9a-fA-F]{1,8})') Then
            With Registers Do
            Begin
                EAX := RegExp.Substitute('$1');
                EBX := RegExp.Substitute('$2');
                ECX := RegExp.Substitute('$3');
                EDX := RegExp.Substitute('$4');
                ESI := RegExp.Substitute('$5');
                EDI := RegExp.Substitute('$6');
            End
        Else
        If RegExp.Exec(Output[I],
            'eip=([0-9a-fA-F]{1,8}) esp=([0-9a-fA-F]{1,8}) ebp=([0-9a-fA-F]{1,8}) iopl=([0-9a-fA-F]{1,8})')
        Then
            With Registers Do
            Begin
                EIP := RegExp.Substitute('$1');
                ESP := RegExp.Substitute('$2');
                EBP := RegExp.Substitute('$3');
            End
        Else
        If RegExp.Exec(Output[I],
            'cs=([0-9a-fA-F]{1,4})  ss=([0-9a-fA-F]{1,4})  ds=([0-9a-fA-F]{1,4})  es=([0-9a-fA-F]{1,4})  fs=([0-9a-fA-F]{1,4})  gs=([0-9a-fA-F]{1,4})             efl=([0-9a-fA-F]{1,8})') Then
            With Registers Do
            Begin
                CS := RegExp.Substitute('$1');
                SS := RegExp.Substitute('$2');
                DS := RegExp.Substitute('$3');
                ES := RegExp.Substitute('$4');
                FS := RegExp.Substitute('$5');
                GS := RegExp.Substitute('$6');
                EFLAGS := RegExp.Substitute('$7');
            End;

    //Pass the locals list to the callback function that wants it
    If Assigned(TDebugger(Self).OnRegisters) Then
        TDebugger(Self).OnRegisters(Registers);

    //Clean up
    RegExp.Free;
End;

Procedure TCDBDebugger.Disassemble(func: String);
Var
    Command: TCommand;
Begin
    If (Not Executing) Or (Not Paused) Then
        Exit;

    //If func is empty, assume the value of the reguister eip.
    If func = '' Then
        func := 'eip';

    Command := TCommand.Create;
    Command.Command := 'uf ' + func;
    Command.OnResult := OnDisassemble;
    QueueCommand(Command);
End;

Procedure TCDBDebugger.OnDisassemble(Output: TStringList);
Var
    I, CurLine: Integer;
    RegExp: TRegExpr;
    CurFile: String;
    Disassembly: String;
Begin
    CurLine := -1;
    RegExp := TRegExpr.Create;
    For I := 0 To Output.Count - 1 Do
        If RegExp.Exec(Output[I], '^(.*)!(.*) \[(.*) @ ([0-9]+)]:') Then
        Begin
            CurLine := StrToInt(RegExp.Substitute('$4'));
            CurFile := RegExp.Substitute('$1!$2 [$3 @ ');
            Disassembly := Disassembly + #9 + ';' + Output[I] + #10;
        End
        Else
        If RegExp.Exec(Output[I], '^(.*)!(.*):') Then
            Disassembly := Disassembly + #9 + ';' + Output[I] + #10
        Else
        If RegExp.Exec(Output[I],
            '^ +([0-9]+) +([0-9a-fA-F]{1,8})( +)([^ ]*)( +)(.*)( +)(.*)') Then
        Begin
            If StrToInt(RegExp.Substitute('$1')) <> CurLine Then
            Begin
                CurLine := StrToInt(RegExp.Substitute('$1'));
                Disassembly :=
                    Disassembly + #9 + ';' + CurFile +
                    RegExp.Substitute('$1') + ']:' + #10;
            End;
            Disassembly := Disassembly +
                RegExp.Substitute('$2$3$4$5$6$7$8') + #10;
        End
        Else
        If RegExp.Exec(Output[I],
            '^([0-9a-fA-F]{1,8})( +)([^ ]*)( +)(.*)( +)(.*)') Then
            Disassembly := Disassembly + Output[I] + #10;

    //Pass the disassembly to the callback function that wants it
    If Assigned(TDebugger(Self).OnDisassemble) Then
        TDebugger(Self).OnDisassemble(Disassembly);

    //Clean up
    RegExp.Free;
End;

Function TCDBDebugger.GetVariableHint(name: String): String;
Var
    Command: TCommand;
Begin
    If (Not Executing) Or (Not Paused) Then
        Exit;

    Command := TCommand.Create;
    Command.Data := TString.Create(name);
    Command.OnResult := OnVariableHint;

    //Decide what command we should send - dv for locals, dt for structures
    If Pos('.', name) > 0 Then
        Command.Command := 'dt ' + Copy(name, 1, Pos('.', name) - 1)
    Else
        Command.Command := 'dv ' + name;

    //Send the command;
    QueueCommand(Command);
End;

Procedure TCDBDebugger.OnVariableHint(Output: TStringList);
Var
    Hint, Name: String;
    I, Depth: Integer;
    RegExp: TRegExpr;
Begin
    Name := TString(CurrentCommand.Data).Str;
    CurrentCommand.Data.Free;
    RegExp := TRegExpr.Create;

    If Pos('.', Name) <> 0 Then
    Begin
        //Remove the dots and count the number of indents
        Depth := 0;
        For I := 1 To Length(name) Do
            If name[I] = '.' Then
                Inc(Depth);

        //Then find the member name
        For I := 0 To Output.Count - 1 Do
            If RegExp.Exec(Output[I], '( {' + IntToStr(Depth * 3) +
                '})\+0x([0-9a-fA-F]{1,8}) ' +
                Copy(name, GetLastPos('.', name) + 1, Length(name)) +
                '( +): (.*)') Then
                Hint := RegExp.Substitute(name + ' = $4');
    End
    Else
        For I := 0 To Output.Count - 1 Do
            If RegExp.Exec(Output[I], '( +)(.*) = (.*)') Then
                Hint := Trim(Output[I]);

    //Call the callback
    If Assigned(TDebugger(Self).OnVariableHint) Then
        TDebugger(Self).OnVariableHint(Hint);

    //Clean up
    RegExp.Free;
End;

Procedure TCDBDebugger.Go;
Var
    Command: TCommand;
Begin
    Command := TCommand.Create;
    Command.Command := 'g';
    Command.Callback := OnGo;
    QueueCommand(Command);
End;

Procedure TCDBDebugger.Next;
Var
    Command: TCommand;
Begin
    Command := TCommand.Create;
    Command.Command := 'p';
    Command.Callback := OnTrace;
    QueueCommand(Command);
End;

Procedure TCDBDebugger.Step;
Var
    Command: TCommand;
Begin
    Command := TCommand.Create;
    Command.Command := 't';
    Command.Callback := OnTrace;
    QueueCommand(Command);
End;

Procedure TCDBDebugger.Finish;
Var
    Command: TCommand;
Begin
    Command := TCommand.Create;
    Command.Command := 't';
    Command.Callback := OnTrace;
    QueueCommand(Command);
End;

Procedure TCDBDebugger.OnTrace;
Begin
    JumpToCurrentLine := True;
    fPaused := False;
    fBusy := False;
End;

Procedure TCDBDebugger.SetThread(thread: Integer);
Begin
    QueueCommand('~' + IntToStr(thread), 's');
    RefreshContext;
End;

Procedure TCDBDebugger.SetFrame(frame: Integer);
Begin
    QueueCommand('.frame', IntToStr(frame));
    RefreshContext([cdLocals, cdWatches]);
End;

// Debugger virtual functions
Procedure TCDBDebugger.FirstParse;
Begin
End;

Procedure TCDBDebugger.ExitDebugger;
Begin
End;

Procedure TCDBDebugger.WriteToPipe(Buffer: String);
Begin
End;

Procedure TCDBDebugger.AddToDisplay(Msg: String);
Begin
End;


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

Initialization
    Breakpoints := TList.Create;

Finalization
    Breakpoints.Free;

End.
