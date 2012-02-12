Unit RegExpr;

{
     TRegExpr class library
     Delphi Regular Expressions

 Copyright (c) 1999-2004 Andrey V. Sorokin, St.Petersburg, Russia

 You may use this software in any kind of development,
 including comercial, redistribute, and modify it freely,
 under the following restrictions :
 1. This software is provided as it is, without any kind of
    warranty given. Use it at Your own risk.The author is not
    responsible for any consequences of use of this software.
 2. The origin of this software may not be mispresented, You
    must not claim that You wrote the original software. If
    You use this software in any kind of product, it would be
    appreciated that there in a information box, or in the
    documentation would be an acknowledgement like

     Partial Copyright (c) 2004 Andrey V. Sorokin
                                http://RegExpStudio.com
                                mailto:anso@mail.ru

 3. You may not have any income from distributing this source
    (or altered version of it) to other developers. When You
    use this product in a comercial package, the source may
    not be charged seperatly.
 4. Altered versions must be plainly marked as such, and must
    not be misrepresented as being the original software.
 5. RegExp Studio application and all the visual components as 
    well as documentation is not part of the TRegExpr library 
    and is not free for usage.

                                    mailto:anso@mail.ru
                                    http://RegExpStudio.com
                                    http://anso.da.ru/
}

Interface

// ======== Determine compiler
{$IFDEF VER80} Sorry, TRegExpr is for 32-bits Delphi only. Delphi 1 is not supported (and whos really care today?!). {$ENDIF}
{$IFDEF VER90} {$DEFINE D2} {$ENDIF} // D2
{$IFDEF VER93} {$DEFINE D2} {$ENDIF} // CPPB 1
{$IFDEF VER100} {$DEFINE D3} {$DEFINE D2} {$ENDIF} // D3
{$IFDEF VER110} {$DEFINE D4} {$DEFINE D3} {$DEFINE D2} {$ENDIF} // CPPB 3
{$IFDEF VER120} {$DEFINE D4} {$DEFINE D3} {$DEFINE D2} {$ENDIF} // D4
{$IFDEF VER130} {$DEFINE D5} {$DEFINE D4} {$DEFINE D3} {$DEFINE D2} {$ENDIF} // D5
{$IFDEF VER140} {$DEFINE D6} {$DEFINE D5} {$DEFINE D4} {$DEFINE D3} {$DEFINE D2} {$ENDIF} // D6
{$IFDEF VER150} {$DEFINE D7} {$DEFINE D6} {$DEFINE D5} {$DEFINE D4} {$DEFINE D3} {$DEFINE D2} {$ENDIF} // D7

// ======== Define base compiler options
{$BOOLEVAL OFF}
{$EXTENDEDSYNTAX ON}
{$LONGSTRINGS ON}
{$OPTIMIZATION ON}
{$IFDEF D6}
  {$WARN SYMBOL_PLATFORM OFF} // Suppress .Net warnings
{$ENDIF}
{$IFDEF D7}
  {$WARN UNSAFE_CAST OFF} // Suppress .Net warnings
  {$WARN UNSAFE_TYPE OFF} // Suppress .Net warnings
  {$WARN UNSAFE_CODE OFF} // Suppress .Net warnings
{$ENDIF}
{$IFDEF FPC}
 {$MODE DELPHI} // Delphi-compatible mode in FreePascal
{$ENDIF}

// ======== Define options for TRegExpr engine
{.$DEFINE UniCode} // Unicode support
{$DEFINE RegExpPCodeDump} // p-code dumping (see Dump method)
{$IFNDEF FPC} // the option is not supported in FreePascal
 {$DEFINE reRealExceptionAddr} // exceptions will point to appropriate source line, not to Error procedure
{$ENDIF}
{$DEFINE ComplexBraces} // support braces in complex cases
{$IFNDEF UniCode} // the option applicable only for non-UniCode mode
 {$DEFINE UseSetOfChar} // Significant optimization by using set of char
{$ENDIF}
{$IFDEF UseSetOfChar}
 {$DEFINE UseFirstCharSet} // Fast skip between matches for r.e. that starts with determined set of chars
{$ENDIF}

// ======== Define Pascal-language options
// Define 'UseAsserts' option (do not edit this definitions).
// Asserts used to catch 'strange bugs' in TRegExpr implementation (when something goes
// completely wrong). You can swith asserts on/off with help of {$C+}/{$C-} compiler options.
{$IFDEF D3} {$DEFINE UseAsserts} {$ENDIF}
{$IFDEF FPC} {$DEFINE UseAsserts} {$ENDIF}

// Define 'use subroutine parameters default values' option (do not edit this definition).
{$IFDEF D4} {$DEFINE DefParam} {$ENDIF}

// Define 'OverMeth' options, to use method overloading (do not edit this definitions).
{$IFDEF D5} {$DEFINE OverMeth} {$ENDIF}
{$IFDEF FPC} {$DEFINE OverMeth} {$ENDIF}

Uses
    Classes,  // TStrings in Split method
    SysUtils; // Exception

Type
 {$IFDEF UniCode}
 PRegExprChar = PWideChar;
 RegExprString = WideString;
 REChar = WideChar;
 {$ELSE}
    PRegExprChar = Pchar;
    RegExprString = Ansistring; //###0.952 was string
    REChar = Char;
 {$ENDIF}
    TREOp = REChar; // internal p-code type //###0.933
    PREOp = ^TREOp;
    TRENextOff = Integer; // internal Next "pointer" (offset to current p-code) //###0.933
    PRENextOff = ^TRENextOff; // used for extracting Next "pointers" from compiled r.e. //###0.933
    TREBracesArg = Integer; // type of {m,n} arguments
    PREBracesArg = ^TREBracesArg;

Const
    REOpSz = SizeOf(TREOp) Div SizeOf(REChar); // size of p-code in RegExprString units
    RENextOffSz = SizeOf(TRENextOff) Div SizeOf(REChar); // size of Next 'pointer' -"-
    REBracesArgSz = SizeOf(TREBracesArg) Div SizeOf(REChar); // size of BRACES arguments -"-

Type
    TRegExprInvertCaseFunction = Function(Const Ch: REChar): REChar
        Of Object;

Const
    EscChar = '\'; // 'Escape'-char ('\' in common r.e.) used for escaping metachars (\w, \d etc).
    RegExprModifierI: Boolean = False;    // default value for ModifierI
    RegExprModifierR: Boolean = True;     // default value for ModifierR
    RegExprModifierS: Boolean = True;     // default value for ModifierS
    RegExprModifierG: Boolean = True;     // default value for ModifierG
    RegExprModifierM: Boolean = False;    // default value for ModifierM
    RegExprModifierX: Boolean = False;    // default value for ModifierX
    RegExprSpaceChars: RegExprString =    // default value for SpaceChars
        ' '#$9#$A#$D#$C;
    RegExprWordChars: RegExprString =     // default value for WordChars
        '0123456789' //###0.940
        + 'abcdefghijklmnopqrstuvwxyz'
        + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ_';
    RegExprLineSeparators: RegExprString =// default value for LineSeparators
        #$d#$a{$IFDEF UniCode}+#$b#$c#$2028#$2029#$85{$ENDIF}; //###0.947
    RegExprLinePairedSeparator: RegExprString =// default value for LinePairedSeparator
        #$d#$a;
  { if You need Unix-styled line separators (only \n), then use:
  RegExprLineSeparators = #$a;
  RegExprLinePairedSeparator = '';
  }


Const
    NSUBEXP = 15; // max number of subexpression //###0.929
 // Cannot be more than NSUBEXPMAX
 // Be carefull - don't use values which overflow CLOSE opcode
 // (in this case you'll get compiler erorr).
 // Big NSUBEXP will cause more slow work and more stack required
    NSUBEXPMAX = 255; // Max possible value for NSUBEXP. //###0.945
 // Don't change it! It's defined by internal TRegExpr design.

    MaxBracesArg = $7FFFFFFF - 1; // max value for {n,m} arguments //###0.933

 {$IFDEF ComplexBraces}
    LoopStackMax = 10; // max depth of loops stack //###0.925
 {$ENDIF}

    TinySetLen = 3;
 // if range includes more then TinySetLen chars, //###0.934
 // then use full (32 bytes) ANYOFFULL instead of ANYOF[BUT]TINYSET
 // !!! Attension ! If you change TinySetLen, you must
 // change code marked as "//!!!TinySet"


Type

{$IFDEF UseSetOfChar}
    PSetOfREChar = ^TSetOfREChar;
    TSetOfREChar = Set Of REChar;
{$ENDIF}

    TRegExpr = Class;

    TRegExprReplaceFunction = Function(ARegExpr: TRegExpr): String
        Of Object;

    TRegExpr = Class
    Private
        startp: Array [0 .. NSUBEXP - 1] Of PRegExprChar; // founded expr starting points
        endp: Array [0 .. NSUBEXP - 1] Of PRegExprChar; // founded expr end points

    {$IFDEF ComplexBraces}
        LoopStack: Array [1 .. LoopStackMax] Of Integer; // state before entering loop
        LoopStackIdx: Integer; // 0 - out of all loops
    {$ENDIF}

    // The "internal use only" fields to pass info from compile
    // to execute that permits the execute phase to run lots faster on
    // simple cases.
        regstart: REChar; // char that must begin a match; '\0' if none obvious
        reganch: REChar; // is the match anchored (at beginning-of-line only)?
        regmust: PRegExprChar; // string (pointer into program) that match must include, or nil
        regmlen: Integer; // length of regmust string
    // Regstart and reganch permit very fast decisions on suitable starting points
    // for a match, cutting down the work a lot.  Regmust permits fast rejection
    // of lines that cannot possibly match.  The regmust tests are costly enough
    // that regcomp() supplies a regmust only if the r.e. contains something
    // potentially expensive (at present, the only such thing detected is * or +
    // at the start of the r.e., which can involve a lot of backup).  Regmlen is
    // supplied because the test in regexec() needs it and regcomp() is computing
    // it anyway.
    {$IFDEF UseFirstCharSet} //###0.929
        FirstCharSet: TSetOfREChar;
    {$ENDIF}

    // work variables for Exec's routins - save stack in recursion}
        reginput: PRegExprChar; // String-input pointer.
        fInputStart: PRegExprChar; // Pointer to first char of input string.
        fInputEnd: PRegExprChar; // Pointer to char AFTER last char of input string

    // work variables for compiler's routines
        regparse: PRegExprChar;  // Input-scan pointer.
        regnpar: Integer; // count.
        regdummy: Char;
        regcode: PRegExprChar;   // Code-emit pointer; @regdummy = don't.
        regsize: Integer; // Code size.

        regexpbeg: PRegExprChar; // only for error handling. Contains
    // pointer to beginning of r.e. while compiling
        fExprIsCompiled: Boolean; // true if r.e. successfully compiled

    // programm is essentially a linear encoding
    // of a nondeterministic finite-state machine (aka syntax charts or
    // "railroad normal form" in parsing technology).  Each node is an opcode
    // plus a "next" pointer, possibly plus an operand.  "Next" pointers of
    // all nodes except BRANCH implement concatenation; a "next" pointer with
    // a BRANCH on both ends of it is connecting two alternatives.  (Here we
    // have one of the subtle syntax dependencies:  an individual BRANCH (as
    // opposed to a collection of them) is never concatenated with anything
    // because of operator precedence.)  The operand of some types of node is
    // a literal string; for others, it is a node leading into a sub-FSM.  In
    // particular, the operand of a BRANCH node is the first node of the branch.
    // (NB this is *not* a tree structure:  the tail of the branch connects
    // to the thing following the set of BRANCHes.)  The opcodes are:
        programm: PRegExprChar; // Unwarranted chumminess with compiler.

        fExpression: PRegExprChar; // source of compiled r.e.
        fInputString: PRegExprChar; // input string

        fLastError: Integer; // see Error, LastError

        fModifiers: Integer; // modifiers
        fCompModifiers: Integer; // compiler's copy of modifiers
        fProgModifiers: Integer; // modifiers values from last programm compilation

        fSpaceChars: RegExprString; //###0.927
        fWordChars: RegExprString; //###0.929
        fInvertCase: TRegExprInvertCaseFunction; //###0.927

        fLineSeparators: RegExprString; //###0.941
        fLinePairedSeparatorAssigned: Boolean;
        fLinePairedSeparatorHead,
        fLinePairedSeparatorTail: REChar;
    {$IFNDEF UniCode}
        fLineSeparatorsSet: Set Of REChar;
    {$ENDIF}

        Procedure InvalidateProgramm;
    // Mark programm as have to be [re]compiled

        Function IsProgrammOk: Boolean; //###0.941
    // Check if we can use precompiled r.e. or
    // [re]compile it if something changed

        Function GetExpression: RegExprString;
        Procedure SetExpression(Const s: RegExprString);

        Function GetModifierStr: RegExprString;
        Class Function ParseModifiersStr(Const AModifiers: RegExprString;
            Var AModifiersInt: Integer): Boolean; //###0.941 class function now
    // Parse AModifiers string and return true and set AModifiersInt
    // if it's in format 'ismxrg-ismxrg'.
        Procedure SetModifierStr(Const AModifiers: RegExprString);

        Function GetModifier(AIndex: Integer): Boolean;
        Procedure SetModifier(AIndex: Integer; ASet: Boolean);

        Procedure Error(AErrorID: Integer); Virtual; // error handler.
    // Default handler raise exception ERegExpr with
    // Message = ErrorMsg (AErrorID), ErrorCode = AErrorID
    // and CompilerErrorPos = value of property CompilerErrorPos.


    {==================== Compiler section ===================}
        Function CompileRegExpr(exp: PRegExprChar): Boolean;
    // compile a regular expression into internal code

        Procedure Tail(p: PRegExprChar; val: PRegExprChar);
    // set the next-pointer at the end of a node chain

        Procedure OpTail(p: PRegExprChar; val: PRegExprChar);
    // regoptail - regtail on operand of first argument; nop if operandless

        Function EmitNode(op: TREOp): PRegExprChar;
    // regnode - emit a node, return location

        Procedure EmitC(b: REChar);
    // emit (if appropriate) a byte of code

        Procedure InsertOperator(op: TREOp; opnd: PRegExprChar; sz: Integer); //###0.90
    // insert an operator in front of already-emitted operand
    // Means relocating the operand.

        Function ParseReg(paren: Integer; Var flagp: Integer): PRegExprChar;
    // regular expression, i.e. main body or parenthesized thing

        Function ParseBranch(Var flagp: Integer): PRegExprChar;
    // one alternative of an | operator

        Function ParsePiece(Var flagp: Integer): PRegExprChar;
    // something followed by possible [*+?]

        Function ParseAtom(Var flagp: Integer): PRegExprChar;
    // the lowest level

        Function GetCompilerErrorPos: Integer;
    // current pos in r.e. - for error hanling

    {$IFDEF UseFirstCharSet} //###0.929
        Procedure FillFirstCharSet(prog: PRegExprChar);
    {$ENDIF}

    {===================== Mathing section ===================}
        Function regrepeat(p: PRegExprChar; AMax: Integer): Integer;
    // repeatedly match something simple, report how many

        Function regnext(p: PRegExprChar): PRegExprChar;
    // dig the "next" pointer out of a node

        Function MatchPrim(prog: PRegExprChar): Boolean;
    // recursively matching routine

        Function ExecPrim(AOffset: Integer): Boolean;
    // Exec for stored InputString

    {$IFDEF RegExpPCodeDump}
        Function DumpOp(op: REChar): RegExprString;
    {$ENDIF}

        Function GetSubExprMatchCount: Integer;
        Function GetMatchPos(Idx: Integer): Integer;
        Function GetMatchLen(Idx: Integer): Integer;
        Function GetMatch(Idx: Integer): RegExprString;

        Function GetInputString: RegExprString;
        Procedure SetInputString(Const AInputString: RegExprString);

    {$IFNDEF UseSetOfChar}
    function StrScanCI (s : PRegExprChar; ch : REChar) : PRegExprChar; //###0.928
    {$ENDIF}

        Procedure SetLineSeparators(Const AStr: RegExprString);
        Procedure SetLinePairedSeparator(Const AStr: RegExprString);
        Function GetLinePairedSeparator: RegExprString;

    Public
        Constructor Create;
        Destructor Destroy; Override;

        Class Function VersionMajor: Integer; //###0.944
        Class Function VersionMinor: Integer; //###0.944

        Property Expression: RegExprString Read GetExpression Write SetExpression;
    // Regular expression.
    // For optimization, TRegExpr will automatically compiles it into 'P-code'
    // (You can see it with help of Dump method) and stores in internal
    // structures. Real [re]compilation occures only when it really needed -
    // while calling Exec[Next], Substitute, Dump, etc
    // and only if Expression or other P-code affected properties was changed
    // after last [re]compilation.
    // If any errors while [re]compilation occures, Error method is called
    // (by default Error raises exception - see below)

        Property ModifierStr: RegExprString Read GetModifierStr Write SetModifierStr;
    // Set/get default values of r.e.syntax modifiers. Modifiers in
    // r.e. (?ismx-ismx) will replace this default values.
    // If you try to set unsupported modifier, Error will be called
    // (by defaul Error raises exception ERegExpr).

        Property ModifierI: Boolean index 1 Read GetModifier Write SetModifier;
    // Modifier /i - caseinsensitive, initialized from RegExprModifierI

        Property ModifierR: Boolean index 2 Read GetModifier Write SetModifier;
    // Modifier /r - use r.e.syntax extended for russian,
    // (was property ExtSyntaxEnabled in previous versions)
    // If true, then à-ÿ  additional include russian letter '¸',
    // À-ß  additional include '¨', and à-ß include all russian symbols.
    // You have to turn it off if it may interfere with you national alphabet.
    // , initialized from RegExprModifierR

        Property ModifierS: Boolean index 3 Read GetModifier Write SetModifier;
    // Modifier /s - '.' works as any char (else as [^\n]),
    // , initialized from RegExprModifierS

        Property ModifierG: Boolean index 4 Read GetModifier Write SetModifier;
    // Switching off modifier /g switchs all operators in
    // non-greedy style, so if ModifierG = False, then
    // all '*' works as '*?', all '+' as '+?' and so on.
    // , initialized from RegExprModifierG

        Property ModifierM: Boolean index 5 Read GetModifier Write SetModifier;
    // Treat string as multiple lines. That is, change `^' and `$' from
    // matching at only the very start or end of the string to the start
    // or end of any line anywhere within the string.
    // , initialized from RegExprModifierM

        Property ModifierX: Boolean index 6 Read GetModifier Write SetModifier;
    // Modifier /x - eXtended syntax, allow r.e. text formatting,
    // see description in the help. Initialized from RegExprModifierX

        Function Exec(Const AInputString, Expression: RegExprString): Boolean; Overload;
        Function Exec(Const AInputString: RegExprString): Boolean; {$IFDEF OverMeth} Overload;
    {$IFNDEF FPC} // I do not know why FreePascal cannot overload methods with empty param list
        Function Exec: Boolean; Overload; //###0.949
    {$ENDIF}
        Function Exec(AOffset: Integer): Boolean; Overload; //###0.949
    {$ENDIF}
    // match a programm against a string AInputString
    // !!! Exec store AInputString into InputString property
    // For Delphi 5 and higher available overloaded versions - first without
    // parameter (uses already assigned to InputString property value)
    // and second that has integer parameter and is same as ExecPos

        Function ExecNext: Boolean;
    // find next match:
    //    ExecNext;
    // works same as
    //    if MatchLen [0] = 0 then ExecPos (MatchPos [0] + 1)
    //     else ExecPos (MatchPos [0] + MatchLen [0]);
    // but it's more simpler !
    // Raises exception if used without preceeding SUCCESSFUL call to
    // Exec* (Exec, ExecPos, ExecNext). So You always must use something like
    // if Exec (InputString) then repeat { proceed results} until not ExecNext;

        Function ExecPos(AOffset: Integer {$IFDEF DefParam} = 1{$ENDIF}): Boolean;
    // find match for InputString starting from AOffset position
    // (AOffset=1 - first char of InputString)

        Property InputString: RegExprString Read GetInputString Write SetInputString;
    // returns current input string (from last Exec call or last assign
    // to this property).
    // Any assignment to this property clear Match* properties !

        Function Substitute(Const ATemplate: RegExprString): RegExprString;
    // Returns ATemplate with '$&' or '$0' replaced by whole r.e.
    // occurence and '$n' replaced by occurence of subexpression #n.
    // Since v.0.929 '$' used instead of '\' (for future extensions
    // and for more Perl-compatibility) and accept more then one digit.
    // If you want place into template raw '$' or '\', use prefix '\'
    // Example: '1\$ is $2\\rub\\' -> '1$ is <Match[2]>\rub\'
    // If you want to place raw digit after '$n' you must delimit
    // n with curly braces '{}'.
    // Example: 'a$12bc' -> 'a<Match[12]>bc'
    // 'a${1}2bc' -> 'a<Match[1]>2bc'.

        Procedure Split(AInputStr: RegExprString; APieces: TStrings);
    // Split AInputStr into APieces by r.e. occurencies
    // Internally calls Exec[Next]

        Function Replace(AInputStr: RegExprString;
            Const AReplaceStr: RegExprString;
            AUseSubstitution: Boolean{$IFDEF DefParam} = False{$ENDIF}) //###0.946
            : RegExprString; {$IFDEF OverMeth} Overload;
        Function Replace(AInputStr: RegExprString;
            AReplaceFunc: TRegExprReplaceFunction)
            : RegExprString; Overload;
    {$ENDIF}
        Function ReplaceEx(AInputStr: RegExprString;
            AReplaceFunc: TRegExprReplaceFunction)
            : RegExprString;
    // Returns AInputStr with r.e. occurencies replaced by AReplaceStr
    // If AUseSubstitution is true, then AReplaceStr will be used
    // as template for Substitution methods.
    // For example:
    //  Expression := '({-i}block|var)\s*\(\s*([^ ]*)\s*\)\s*';
    //  Replace ('BLOCK( test1)', 'def "$1" value "$2"', True);
    //   will return:  def 'BLOCK' value 'test1'
    //  Replace ('BLOCK( test1)', 'def "$1" value "$2"')
    //   will return:  def "$1" value "$2"
    // Internally calls Exec[Next]
    // Overloaded version and ReplaceEx operate with call-back function,
    // so You can implement really complex functionality.

        Property SubExprMatchCount: Integer Read GetSubExprMatchCount;
    // Number of subexpressions has been found in last Exec* call.
    // If there are no subexpr. but whole expr was found (Exec* returned True),
    // then SubExprMatchCount=0, if no subexpressions nor whole
    // r.e. found (Exec* returned false) then SubExprMatchCount=-1.
    // Note, that some subexpr. may be not found and for such
    // subexpr. MathPos=MatchLen=-1 and Match=''.
    // For example: Expression := '(1)?2(3)?';
    //  Exec ('123'): SubExprMatchCount=2, Match[0]='123', [1]='1', [2]='3'
    //  Exec ('12'): SubExprMatchCount=1, Match[0]='12', [1]='1'
    //  Exec ('23'): SubExprMatchCount=2, Match[0]='23', [1]='', [2]='3'
    //  Exec ('2'): SubExprMatchCount=0, Match[0]='2'
    //  Exec ('7') - return False: SubExprMatchCount=-1

        Property MatchPos[Idx: Integer]: Integer Read GetMatchPos;
    // pos of entrance subexpr. #Idx into tested in last Exec*
    // string. First subexpr. have Idx=1, last - MatchCount,
    // whole r.e. have Idx=0.
    // Returns -1 if in r.e. no such subexpr. or this subexpr.
    // not found in input string.

        Property MatchLen[Idx: Integer]: Integer Read GetMatchLen;
    // len of entrance subexpr. #Idx r.e. into tested in last Exec*
    // string. First subexpr. have Idx=1, last - MatchCount,
    // whole r.e. have Idx=0.
    // Returns -1 if in r.e. no such subexpr. or this subexpr.
    // not found in input string.
    // Remember - MatchLen may be 0 (if r.e. match empty string) !

        Property Match[Idx: Integer]: RegExprString Read GetMatch;
    // == copy (InputString, MatchPos [Idx], MatchLen [Idx])
    // Returns '' if in r.e. no such subexpr. or this subexpr.
    // not found in input string.

        Function LastError: Integer;
    // Returns ID of last error, 0 if no errors (unusable if
    // Error method raises exception) and clear internal status
    // into 0 (no errors).

        Function ErrorMsg(AErrorID: Integer): RegExprString; Virtual;
    // Returns Error message for error with ID = AErrorID.

        Property CompilerErrorPos: Integer Read GetCompilerErrorPos;
    // Returns pos in r.e. there compiler stopped.
    // Usefull for error diagnostics

        Property SpaceChars: RegExprString Read fSpaceChars Write fSpaceChars; //###0.927
    // Contains chars, treated as /s (initially filled with RegExprSpaceChars
    // global constant)

        Property WordChars: RegExprString Read fWordChars Write fWordChars; //###0.929
    // Contains chars, treated as /w (initially filled with RegExprWordChars
    // global constant)

        Property LineSeparators: RegExprString Read fLineSeparators Write SetLineSeparators; //###0.941
    // line separators (like \n in Unix)

        Property LinePairedSeparator: RegExprString Read GetLinePairedSeparator Write SetLinePairedSeparator; //###0.941
    // paired line separator (like \r\n in DOS and Windows).
    // must contain exactly two chars or no chars at all

        Class Function InvertCaseFunction(Const Ch: REChar): REChar;
    // Converts Ch into upper case if it in lower case or in lower
    // if it in upper (uses current system local setings)

        Property InvertCase: TRegExprInvertCaseFunction Read fInvertCase Write fInvertCase; //##0.935
    // Set this property if you want to override case-insensitive functionality.
    // Create set it to RegExprInvertCaseFunction (InvertCaseFunction by default)

        Procedure Compile; //###0.941
    // [Re]compile r.e. Usefull for example for GUI r.e. editors (to check
    // all properties validity).

    {$IFDEF RegExpPCodeDump}
        Function Dump: RegExprString;
    // dump a compiled regexp in vaguely comprehensible form
    {$ENDIF}
    End;

    ERegExpr = Class(Exception)
    Public
        ErrorCode: Integer;
        CompilerErrorPos: Integer;
    End;

Const
    RegExprInvertCaseFunction: TRegExprInvertCaseFunction = {$IFDEF FPC} nil {$ELSE} TRegExpr.InvertCaseFunction{$ENDIF};
  // defaul for InvertCase property

Function ExecRegExpr(Const ARegExpr, AInputStr: RegExprString): Boolean;
// true if string AInputString match regular expression ARegExpr
// ! will raise exeption if syntax errors in ARegExpr

Procedure SplitRegExpr(Const ARegExpr, AInputStr: RegExprString; APieces: TStrings);
// Split AInputStr into APieces by r.e. ARegExpr occurencies

Function ReplaceRegExpr(Const ARegExpr, AInputStr, AReplaceStr: RegExprString;
    AUseSubstitution: Boolean{$IFDEF DefParam} = False{$ENDIF}): RegExprString; //###0.947
// Returns AInputStr with r.e. occurencies replaced by AReplaceStr
// If AUseSubstitution is true, then AReplaceStr will be used
// as template for Substitution methods.
// For example:
//  ReplaceRegExpr ('({-i}block|var)\s*\(\s*([^ ]*)\s*\)\s*',
//   'BLOCK( test1)', 'def "$1" value "$2"', True)
//  will return:  def 'BLOCK' value 'test1'
//  ReplaceRegExpr ('({-i}block|var)\s*\(\s*([^ ]*)\s*\)\s*',
//   'BLOCK( test1)', 'def "$1" value "$2"')
//   will return:  def "$1" value "$2"

Function QuoteRegExprMetaChars(Const AStr: RegExprString): RegExprString;
// Replace all metachars with its safe representation,
// for example 'abc$cd.(' converts into 'abc\$cd\.\('
// This function usefull for r.e. autogeneration from
// user input

Function RegExprSubExpressions(Const ARegExpr: String;
    ASubExprs: TStrings; AExtendedSyntax: Boolean{$IFDEF DefParam} = False{$ENDIF}): Integer;
// Makes list of subexpressions found in ARegExpr r.e.
// In ASubExps every item represent subexpression,
// from first to last, in format:
//  String - subexpression text (without '()')
//  low word of Object - starting position in ARegExpr, including '('
//   if exists! (first position is 1)
//  high word of Object - length, including starting '(' and ending ')'
//   if exist!
// AExtendedSyntax - must be True if modifier /m will be On while
// using the r.e.
// Usefull for GUI editors of r.e. etc (You can find example of using
// in TestRExp.dpr project)
// Returns
//  0      Success. No unbalanced brackets was found;
//  -1     There are not enough closing brackets ')';
//  -(n+1) At position n was found opening '[' without  //###0.942
//         corresponding closing ']';
//  n      At position n was found closing bracket ')' without
//         corresponding opening '('.
// If Result <> 0, then ASubExpr can contain empty items or illegal ones


Implementation

Uses
    Windows; // CharUpper/Lower

Const
    TRegExprVersionMajor: Integer = 0;
    TRegExprVersionMinor: Integer = 952;
 // TRegExpr.VersionMajor/Minor return values of this constants

    MaskModI = 1;  // modifier /i bit in fModifiers
    MaskModR = 2;  // -"- /r
    MaskModS = 4;  // -"- /s
    MaskModG = 8;  // -"- /g
    MaskModM = 16; // -"- /m
    MaskModX = 32; // -"- /x

 {$IFDEF UniCode}
 XIgnoredChars = ' '#9#$d#$a;
 {$ELSE}
    XIgnoredChars = [' ', #9, #$d, #$a];
 {$ENDIF}

{=============================================================}
{=================== WideString functions ====================}
{=============================================================}

{$IFDEF UniCode}

function StrPCopy (Dest: PRegExprChar; const Source: RegExprString): PRegExprChar;
 var
  i, Len : Integer;
 begin
  Len := length (Source); //###0.932
  for i := 1 to Len do
   Dest [i - 1] := Source [i];
  Dest [Len] := #0;
  Result := Dest;
 end; { of function StrPCopy
--------------------------------------------------------------}

function StrLCopy (Dest, Source: PRegExprChar; MaxLen: Cardinal): PRegExprChar;
 var i: Integer;
 begin
  for i := 0 to MaxLen - 1 do
   Dest [i] := Source [i];
  Result := Dest;
 end; { of function StrLCopy
--------------------------------------------------------------}

function StrLen (Str: PRegExprChar): Cardinal;
 begin
  Result:=0;
  while Str [result] <> #0
   do Inc (Result);
 end; { of function StrLen
--------------------------------------------------------------}

function StrPos (Str1, Str2: PRegExprChar): PRegExprChar;
 var n: Integer;
 begin
  Result := nil;
  n := Pos (RegExprString (Str2), RegExprString (Str1));
  if n = 0
   then EXIT;
  Result := Str1 + n - 1;
 end; { of function StrPos
--------------------------------------------------------------}

function StrLComp (Str1, Str2: PRegExprChar; MaxLen: Cardinal): Integer;
 var S1, S2: RegExprString;
 begin
  S1 := Str1;
  S2 := Str2;
  if Copy (S1, 1, MaxLen) > Copy (S2, 1, MaxLen)
   then Result := 1
   else
    if Copy (S1, 1, MaxLen) < Copy (S2, 1, MaxLen)
     then Result := -1
     else Result := 0;
 end; { function StrLComp
--------------------------------------------------------------}

function StrScan (Str: PRegExprChar; Chr: WideChar): PRegExprChar;
 begin
  Result := nil;
  while (Str^ <> #0) and (Str^ <> Chr)
   do Inc (Str);
  if (Str^ <> #0)
   then Result := Str;
 end; { of function StrScan
--------------------------------------------------------------}

{$ENDIF}


{=============================================================}
{===================== Global functions ======================}
{=============================================================}

Function ExecRegExpr(Const ARegExpr, AInputStr: RegExprString): Boolean;
Var r: TRegExpr;
Begin
    r := TRegExpr.Create;
    Try
        r.Expression := ARegExpr;
        Result := r.Exec(AInputStr);
    Finally r.Free;
    End;
End; { of function ExecRegExpr
--------------------------------------------------------------}

Procedure SplitRegExpr(Const ARegExpr, AInputStr: RegExprString; APieces: TStrings);
Var r: TRegExpr;
Begin
    APieces.Clear;
    r := TRegExpr.Create;
    Try
        r.Expression := ARegExpr;
        r.Split(AInputStr, APieces);
    Finally r.Free;
    End;
End; { of procedure SplitRegExpr
--------------------------------------------------------------}

Function ReplaceRegExpr(Const ARegExpr, AInputStr, AReplaceStr: RegExprString;
    AUseSubstitution: Boolean{$IFDEF DefParam} = False{$ENDIF}): RegExprString;
Begin
    With TRegExpr.Create Do
        Try
            Expression := ARegExpr;
            Result := Replace(AInputStr, AReplaceStr, AUseSubstitution);
        Finally Free;
        End;
End; { of function ReplaceRegExpr
--------------------------------------------------------------}

Function QuoteRegExprMetaChars(Const AStr: RegExprString): RegExprString;
Const
    RegExprMetaSet: RegExprString = '^$.[()|?+*' + EscChar + '{'
        + ']}'; // - this last are additional to META.
  // Very similar to META array, but slighly changed.
  // !Any changes in META array must be synchronized with this set.
Var
    i, i0, Len: Integer;
Begin
    Result := '';
    Len := length(AStr);
    i := 1;
    i0 := i;
    While i <= Len Do
    Begin
        If Pos(AStr[i], RegExprMetaSet) > 0 Then
        Begin
            Result := Result + System.Copy(AStr, i0, i - i0)
                + EscChar + AStr[i];
            i0 := i + 1;
        End;
        inc(i);
    End;
    Result := Result + System.Copy(AStr, i0, MaxInt); // Tail
End; { of function QuoteRegExprMetaChars
--------------------------------------------------------------}

Function RegExprSubExpressions(Const ARegExpr: String;
    ASubExprs: TStrings; AExtendedSyntax: Boolean{$IFDEF DefParam} = False{$ENDIF}): Integer;
Type
    TStackItemRec = Record //###0.945
        SubExprIdx: Integer;
        StartPos: Integer;
    End;
    TStackArray = Packed Array [0 .. NSUBEXPMAX - 1] Of TStackItemRec;
Var
    Len, SubExprLen: Integer;
    i, i0: Integer;
    Modif: Integer;
    Stack: ^TStackArray; //###0.945
    StackIdx, StackSz: Integer;
Begin
    Result := 0; // no unbalanced brackets found at this very moment

    ASubExprs.Clear; // I don't think that adding to non empty list
  // can be usefull, so I simplified algorithm to work only with empty list

    Len := length(ARegExpr); // some optimization tricks

  // first we have to calculate number of subexpression to reserve
  // space in Stack array (may be we'll reserve more then need, but
  // it's faster then memory reallocation during parsing)
    StackSz := 1; // add 1 for entire r.e.
    For i := 1 To Len Do
        If ARegExpr[i] = '('
        Then
            inc(StackSz);
//  SetLength (Stack, StackSz); //###0.945
    GetMem(Stack, SizeOf(TStackItemRec) * StackSz);
    Try

        StackIdx := 0;
        i := 1;
        While (i <= Len) Do
        Begin
            Case ARegExpr[i] Of
                '(':
                Begin
                    If (i < Len) And (ARegExpr[i + 1] = '?') Then
                    Begin
           // this is not subexpression, but comment or other
           // Perl extension. We must check is it (?ismxrg-ismxrg)
           // and change AExtendedSyntax if /x is changed.
                        inc(i, 2); // skip '(?'
                        i0 := i;
                        While (i <= Len) And (ARegExpr[i] <> ')')
                            Do
                            inc(i);
                        If i > Len
                        Then
                            Result := -1 // unbalansed '('
                        Else
                        If TRegExpr.ParseModifiersStr(System.Copy(ARegExpr, i, i - i0), Modif)
                        Then
                            AExtendedSyntax := (Modif And MaskModX) <> 0;
                    End
                    Else
                    Begin // subexpression starts
                        ASubExprs.Add(''); // just reserve space
                        With Stack[StackIdx] Do
                        Begin
                            SubExprIdx := ASubExprs.Count - 1;
                            StartPos := i;
                        End;
                        inc(StackIdx);
                    End;
                End;
                ')':
                Begin
                    If StackIdx = 0
                    Then
                        Result := i // unbalanced ')'
                    Else
                    Begin
                        dec(StackIdx);
                        With Stack[StackIdx] Do
                        Begin
                            SubExprLen := i - StartPos + 1;
                            ASubExprs.Objects[SubExprIdx] :=
                                TObject(StartPos Or (SubExprLen Shl 16));
                            ASubExprs[SubExprIdx] := System.Copy(
                                ARegExpr, StartPos + 1, SubExprLen - 2); // add without brackets
                        End;
                    End;
                End;
                EscChar:
                    inc(i); // skip quoted symbol
                '[':
                Begin
        // we have to skip character ranges at once, because they can
        // contain '#', and '#' in it must NOT be recognized as eXtended
        // comment beginning!
                    i0 := i;
                    inc(i);
                    If ARegExpr[i] = ']' // cannot be 'emty' ranges - this interpretes
                    Then
                        inc(i);        // as ']' by itself
                    While (i <= Len) And (ARegExpr[i] <> ']') Do
                        If ARegExpr[i] = EscChar //###0.942
                        Then
                            inc(i, 2) // skip 'escaped' char to prevent stopping at '\]'
                        Else inc(i);
                    If (i > Len) Or (ARegExpr[i] <> ']') //###0.942
                    Then
                        Result := -(i0 + 1); // unbalansed '[' //###0.942
                End;
                '#':
                    If AExtendedSyntax Then
                    Begin
        // skip eXtended comments
                        While (i <= Len) And (ARegExpr[i] <> #$d) And (ARegExpr[i] <> #$a)
         // do not use [#$d, #$a] due to UniCode compatibility
                            Do
                            inc(i);
                        While (i + 1 <= Len) And ((ARegExpr[i + 1] = #$d) Or (ARegExpr[i + 1] = #$a))
                            Do
                            inc(i); // attempt to work with different kinds of line separators
        // now we are at the line separator that must be skipped.
                    End;
      // here is no 'else' clause - we simply skip ordinary chars
            End; // of case
            inc(i); // skip scanned char
    // ! can move after Len due to skipping quoted symbol
        End;

  // check brackets balance
        If StackIdx <> 0
        Then
            Result := -1; // unbalansed '('

  // check if entire r.e. added
        If (ASubExprs.Count = 0)
            Or ((Integer(ASubExprs.Objects[0]) And $FFFF) <> 1)
            Or (((Integer(ASubExprs.Objects[0]) Shr 16) And $FFFF) <> Len)
    // whole r.e. wasn't added because it isn't bracketed
    // well, we add it now:
        Then
            ASubExprs.InsertObject(0, ARegExpr, TObject((Len Shl 16) Or 1));

    Finally FreeMem(Stack);
    End;
End; { of function RegExprSubExpressions
--------------------------------------------------------------}



Const
    MAGIC = TREOp(216);// programm signature

// name            opcode    opnd? meaning
    EEND = TREOp(0);  // -    End of program
    BOL = TREOp(1);  // -    Match "" at beginning of line
    EOL = TREOp(2);  // -    Match "" at end of line
    ANY = TREOp(3);  // -    Match any one character
    ANYOF = TREOp(4);  // Str  Match any character in string Str
    ANYBUT = TREOp(5);  // Str  Match any char. not in string Str
    BRANCH = TREOp(6);  // Node Match this alternative, or the next
    BACK = TREOp(7);  // -    Jump backward (Next < 0)
    EXACTLY = TREOp(8);  // Str  Match string Str
    NOTHING = TREOp(9);  // -    Match empty string
    STAR = TREOp(10); // Node Match this (simple) thing 0 or more times
    PLUS = TREOp(11); // Node Match this (simple) thing 1 or more times
    ANYDIGIT = TREOp(12); // -    Match any digit (equiv [0-9])
    NOTDIGIT = TREOp(13); // -    Match not digit (equiv [0-9])
    ANYLETTER = TREOp(14); // -    Match any letter from property WordChars
    NOTLETTER = TREOp(15); // -    Match not letter from property WordChars
    ANYSPACE = TREOp(16); // -    Match any space char (see property SpaceChars)
    NOTSPACE = TREOp(17); // -    Match not space char (see property SpaceChars)
    BRACES = TREOp(18); // Node,Min,Max Match this (simple) thing from Min to Max times.
                           //      Min and Max are TREBracesArg
    COMMENT = TREOp(19); // -    Comment ;)
    EXACTLYCI = TREOp(20); // Str  Match string Str case insensitive
    ANYOFCI = TREOp(21); // Str  Match any character in string Str, case insensitive
    ANYBUTCI = TREOp(22); // Str  Match any char. not in string Str, case insensitive
    LOOPENTRY = TREOp(23); // Node Start of loop (Node - LOOP for this loop)
    LOOP = TREOp(24); // Node,Min,Max,LoopEntryJmp - back jump for LOOPENTRY.
                           //      Min and Max are TREBracesArg
                           //      Node - next node in sequence,
                           //      LoopEntryJmp - associated LOOPENTRY node addr
    ANYOFTINYSET = TREOp(25); // Chrs Match any one char from Chrs (exactly TinySetLen chars)
    ANYBUTTINYSET = TREOp(26); // Chrs Match any one char not in Chrs (exactly TinySetLen chars)
    ANYOFFULLSET = TREOp(27); // Set  Match any one char from set of char
                           // - very fast (one CPU instruction !) but takes 32 bytes of p-code
    BSUBEXP = TREOp(28); // Idx  Match previously matched subexpression #Idx (stored as REChar) //###0.936
    BSUBEXPCI = TREOp(29); // Idx  -"- in case-insensitive mode

 // Non-Greedy Style Ops //###0.940
    STARNG = TREOp(30); // Same as START but in non-greedy mode
    PLUSNG = TREOp(31); // Same as PLUS but in non-greedy mode
    BRACESNG = TREOp(32); // Same as BRACES but in non-greedy mode
    LOOPNG = TREOp(33); // Same as LOOP but in non-greedy mode

 // Multiline mode \m
    BOLML = TREOp(34);  // -    Match "" at beginning of line
    EOLML = TREOp(35);  // -    Match "" at end of line
    ANYML = TREOp(36);  // -    Match any one character

 // Word boundary
    BOUND = TREOp(37);  // Match "" between words //###0.943
    NOTBOUND = TREOp(38);  // Match "" not between words //###0.943

 // !!! Change OPEN value if you add new opcodes !!!

    OPEN = TREOp(39); // -    Mark this point in input as start of \n
                           //      OPEN + 1 is \1, etc.
    CLOSE = TREOp(ord(OPEN) + NSUBEXP);
                           // -    Analogous to OPEN.

 // !!! Don't add new OpCodes after CLOSE !!!

// We work with p-code thru pointers, compatible with PRegExprChar.
// Note: all code components (TRENextOff, TREOp, TREBracesArg, etc)
// must have lengths that can be divided by SizeOf (REChar) !
// A node is TREOp of opcode followed Next "pointer" of TRENextOff type.
// The Next is a offset from the opcode of the node containing it.
// An operand, if any, simply follows the node. (Note that much of
// the code generation knows about this implicit relationship!)
// Using TRENextOff=integer speed up p-code processing.

// Opcodes description:
//
// BRANCH The set of branches constituting a single choice are hooked
//      together with their "next" pointers, since precedence prevents
//      anything being concatenated to any individual branch.  The
//      "next" pointer of the last BRANCH in a choice points to the
//      thing following the whole choice.  This is also where the
//      final "next" pointer of each individual branch points; each
//      branch starts with the operand node of a BRANCH node.
// BACK Normal "next" pointers all implicitly point forward; BACK
//      exists to make loop structures possible.
// STAR,PLUS,BRACES '?', and complex '*' and '+', are implemented as
//      circular BRANCH structures using BACK. Complex '{min,max}'
//      - as pair LOOPENTRY-LOOP (see below). Simple cases (one
//      character per match) are implemented with STAR, PLUS and
//      BRACES for speed and to minimize recursive plunges.
// LOOPENTRY,LOOP {min,max} are implemented as special pair
//      LOOPENTRY-LOOP. Each LOOPENTRY initialize loopstack for
//      current level.
// OPEN,CLOSE are numbered at compile time.


{=============================================================}
{================== Error handling section ===================}
{=============================================================}

Const
    reeOk = 0;
    reeCompNullArgument = 100;
    reeCompRegexpTooBig = 101;
    reeCompParseRegTooManyBrackets = 102;
    reeCompParseRegUnmatchedBrackets = 103;
    reeCompParseRegUnmatchedBrackets2 = 104;
    reeCompParseRegJunkOnEnd = 105;
    reePlusStarOperandCouldBeEmpty = 106;
    reeNestedSQP = 107;
    reeBadHexDigit = 108;
    reeInvalidRange = 109;
    reeParseAtomTrailingBackSlash = 110;
    reeNoHexCodeAfterBSlashX = 111;
    reeHexCodeAfterBSlashXTooBig = 112;
    reeUnmatchedSqBrackets = 113;
    reeInternalUrp = 114;
    reeQPSBFollowsNothing = 115;
    reeTrailingBackSlash = 116;
    reeRarseAtomInternalDisaster = 119;
    reeBRACESArgTooBig = 122;
    reeBracesMinParamGreaterMax = 124;
    reeUnclosedComment = 125;
    reeComplexBracesNotImplemented = 126;
    reeUrecognizedModifier = 127;
    reeBadLinePairedSeparator = 128;
    reeRegRepeatCalledInappropriately = 1000;
    reeMatchPrimMemoryCorruption = 1001;
    reeMatchPrimCorruptedPointers = 1002;
    reeNoExpression = 1003;
    reeCorruptedProgram = 1004;
    reeNoInpitStringSpecified = 1005;
    reeOffsetMustBeGreaterThen0 = 1006;
    reeExecNextWithoutExec = 1007;
    reeGetInputStringWithoutInputString = 1008;
    reeDumpCorruptedOpcode = 1011;
    reeModifierUnsupported = 1013;
    reeLoopStackExceeded = 1014;
    reeLoopWithoutEntry = 1015;
    reeBadPCodeImported = 2000;

Function TRegExpr.ErrorMsg(AErrorID: Integer): RegExprString;
Begin
    Case AErrorID Of
        reeOk:
            Result := 'No errors';
        reeCompNullArgument:
            Result := 'TRegExpr(comp): Null Argument';
        reeCompRegexpTooBig:
            Result := 'TRegExpr(comp): Regexp Too Big';
        reeCompParseRegTooManyBrackets:
            Result := 'TRegExpr(comp): ParseReg Too Many ()';
        reeCompParseRegUnmatchedBrackets:
            Result := 'TRegExpr(comp): ParseReg Unmatched ()';
        reeCompParseRegUnmatchedBrackets2:
            Result := 'TRegExpr(comp): ParseReg Unmatched ()';
        reeCompParseRegJunkOnEnd:
            Result := 'TRegExpr(comp): ParseReg Junk On End';
        reePlusStarOperandCouldBeEmpty:
            Result := 'TRegExpr(comp): *+ Operand Could Be Empty';
        reeNestedSQP:
            Result := 'TRegExpr(comp): Nested *?+';
        reeBadHexDigit:
            Result := 'TRegExpr(comp): Bad Hex Digit';
        reeInvalidRange:
            Result := 'TRegExpr(comp): Invalid [] Range';
        reeParseAtomTrailingBackSlash:
            Result := 'TRegExpr(comp): Parse Atom Trailing \';
        reeNoHexCodeAfterBSlashX:
            Result := 'TRegExpr(comp): No Hex Code After \x';
        reeHexCodeAfterBSlashXTooBig:
            Result := 'TRegExpr(comp): Hex Code After \x Is Too Big';
        reeUnmatchedSqBrackets:
            Result := 'TRegExpr(comp): Unmatched []';
        reeInternalUrp:
            Result := 'TRegExpr(comp): Internal Urp';
        reeQPSBFollowsNothing:
            Result := 'TRegExpr(comp): ?+*{ Follows Nothing';
        reeTrailingBackSlash:
            Result := 'TRegExpr(comp): Trailing \';
        reeRarseAtomInternalDisaster:
            Result := 'TRegExpr(comp): RarseAtom Internal Disaster';
        reeBRACESArgTooBig:
            Result := 'TRegExpr(comp): BRACES Argument Too Big';
        reeBracesMinParamGreaterMax:
            Result := 'TRegExpr(comp): BRACE Min Param Greater then Max';
        reeUnclosedComment:
            Result := 'TRegExpr(comp): Unclosed (?#Comment)';
        reeComplexBracesNotImplemented:
            Result := 'TRegExpr(comp): If you want take part in beta-testing BRACES ''{min,max}'' and non-greedy ops ''*?'', ''+?'', ''??'' for complex cases - remove ''.'' from {.$DEFINE ComplexBraces}';
        reeUrecognizedModifier:
            Result := 'TRegExpr(comp): Urecognized Modifier';
        reeBadLinePairedSeparator:
            Result := 'TRegExpr(comp): LinePairedSeparator must countain two different chars or no chars at all';

        reeRegRepeatCalledInappropriately:
            Result := 'TRegExpr(exec): RegRepeat Called Inappropriately';
        reeMatchPrimMemoryCorruption:
            Result := 'TRegExpr(exec): MatchPrim Memory Corruption';
        reeMatchPrimCorruptedPointers:
            Result := 'TRegExpr(exec): MatchPrim Corrupted Pointers';
        reeNoExpression:
            Result := 'TRegExpr(exec): Not Assigned Expression Property';
        reeCorruptedProgram:
            Result := 'TRegExpr(exec): Corrupted Program';
        reeNoInpitStringSpecified:
            Result := 'TRegExpr(exec): No Input String Specified';
        reeOffsetMustBeGreaterThen0:
            Result := 'TRegExpr(exec): Offset Must Be Greater Then 0';
        reeExecNextWithoutExec:
            Result := 'TRegExpr(exec): ExecNext Without Exec[Pos]';
        reeGetInputStringWithoutInputString:
            Result := 'TRegExpr(exec): GetInputString Without InputString';
        reeDumpCorruptedOpcode:
            Result := 'TRegExpr(dump): Corrupted Opcode';
        reeLoopStackExceeded:
            Result := 'TRegExpr(exec): Loop Stack Exceeded';
        reeLoopWithoutEntry:
            Result := 'TRegExpr(exec): Loop Without LoopEntry !';

        reeBadPCodeImported:
            Result := 'TRegExpr(misc): Bad p-code imported';
    Else
        Result := 'Unknown error';
    End;
End; { of procedure TRegExpr.Error
--------------------------------------------------------------}

Function TRegExpr.LastError: Integer;
Begin
    Result := fLastError;
    fLastError := reeOk;
End; { of function TRegExpr.LastError
--------------------------------------------------------------}


{=============================================================}
{===================== Common section ========================}
{=============================================================}

Class Function TRegExpr.VersionMajor: Integer; //###0.944
Begin
    Result := TRegExprVersionMajor;
End; { of class function TRegExpr.VersionMajor
--------------------------------------------------------------}

Class Function TRegExpr.VersionMinor: Integer; //###0.944
Begin
    Result := TRegExprVersionMinor;
End; { of class function TRegExpr.VersionMinor
--------------------------------------------------------------}

Constructor TRegExpr.Create;
Begin
    Inherited;
    programm := Nil;
    fExpression := Nil;
    fInputString := Nil;

    regexpbeg := Nil;
    fExprIsCompiled := False;

    ModifierI := RegExprModifierI;
    ModifierR := RegExprModifierR;
    ModifierS := RegExprModifierS;
    ModifierG := RegExprModifierG;
    ModifierM := RegExprModifierM; //###0.940

    SpaceChars := RegExprSpaceChars; //###0.927
    WordChars := RegExprWordChars; //###0.929
    fInvertCase := RegExprInvertCaseFunction; //###0.927

    fLineSeparators := RegExprLineSeparators; //###0.941
    LinePairedSeparator := RegExprLinePairedSeparator; //###0.941
End; { of constructor TRegExpr.Create
--------------------------------------------------------------}

Destructor TRegExpr.Destroy;
Begin
    If programm <> Nil
    Then
        FreeMem(programm);
    If fExpression <> Nil
    Then
        FreeMem(fExpression);
    If fInputString <> Nil
    Then
        FreeMem(fInputString);
End; { of destructor TRegExpr.Destroy
--------------------------------------------------------------}

Class Function TRegExpr.InvertCaseFunction(Const Ch: REChar): REChar;
Begin
  {$IFDEF UniCode}
  if Ch >= #128
   then Result := Ch
  else
  {$ENDIF}
    Begin
        Result := {$IFDEF FPC}AnsiUpperCase (Ch) [1]{$ELSE} REChar(CharUpper(Pchar(Ch))){$ENDIF};
        If Result = Ch
        Then
            Result := {$IFDEF FPC}AnsiLowerCase (Ch) [1]{$ELSE} REChar(CharLower(Pchar(Ch))){$ENDIF};
    End;
End; { of function TRegExpr.InvertCaseFunction
--------------------------------------------------------------}

Function TRegExpr.GetExpression: RegExprString;
Begin
    If fExpression <> Nil
    Then
        Result := fExpression
    Else Result := '';
End; { of function TRegExpr.GetExpression
--------------------------------------------------------------}

Procedure TRegExpr.SetExpression(Const s: RegExprString);
Var
    Len: Integer; //###0.950
Begin
    If (s <> fExpression) Or Not fExprIsCompiled Then
    Begin
        fExprIsCompiled := False;
        If fExpression <> Nil Then
        Begin
            FreeMem(fExpression);
            fExpression := Nil;
        End;
        If s <> '' Then
        Begin
            Len := length(s); //###0.950
            GetMem(fExpression, (Len + 1) * SizeOf(REChar));
//      StrPCopy (fExpression, s); //###0.950 replaced due to StrPCopy limitation of 255 chars
      {$IFDEF UniCode}
      StrPCopy (fExpression, Copy (s, 1, Len)); //###0.950
      {$ELSE}
            StrLCopy(fExpression, PRegExprChar(s), Len); //###0.950
      {$ENDIF UniCode}

            InvalidateProgramm; //###0.941
        End;
    End;
End; { of procedure TRegExpr.SetExpression
--------------------------------------------------------------}

Function TRegExpr.GetSubExprMatchCount: Integer;
Begin
    If Assigned(fInputString) Then
    Begin
        Result := NSUBEXP - 1;
        While (Result > 0) And ((startp[Result] = Nil)
                Or (endp[Result] = Nil))
            Do
            dec(Result);
    End
    Else Result := -1;
End; { of function TRegExpr.GetSubExprMatchCount
--------------------------------------------------------------}

Function TRegExpr.GetMatchPos(Idx: Integer): Integer;
Begin
    If (Idx >= 0) And (Idx < NSUBEXP) And Assigned(fInputString)
        And Assigned(startp[Idx]) And Assigned(endp[Idx]) Then
    Begin
        Result := (startp[Idx] - fInputString) + 1;
    End
    Else Result := -1;
End; { of function TRegExpr.GetMatchPos
--------------------------------------------------------------}

Function TRegExpr.GetMatchLen(Idx: Integer): Integer;
Begin
    If (Idx >= 0) And (Idx < NSUBEXP) And Assigned(fInputString)
        And Assigned(startp[Idx]) And Assigned(endp[Idx]) Then
    Begin
        Result := endp[Idx] - startp[Idx];
    End
    Else Result := -1;
End; { of function TRegExpr.GetMatchLen
--------------------------------------------------------------}

Function TRegExpr.GetMatch(Idx: Integer): RegExprString;
Begin
    If (Idx >= 0) And (Idx < NSUBEXP) And Assigned(fInputString)
        And Assigned(startp[Idx]) And Assigned(endp[Idx])
   //then Result := copy (fInputString, MatchPos [Idx], MatchLen [Idx]) //###0.929
    Then
        SetString(Result, startp[idx], endp[idx] - startp[idx])
    Else Result := '';
End; { of function TRegExpr.GetMatch
--------------------------------------------------------------}

Function TRegExpr.GetModifierStr: RegExprString;
Begin
    Result := '-';

    If ModifierI
    Then
        Result := 'i' + Result
    Else Result := Result + 'i';
    If ModifierR
    Then
        Result := 'r' + Result
    Else Result := Result + 'r';
    If ModifierS
    Then
        Result := 's' + Result
    Else Result := Result + 's';
    If ModifierG
    Then
        Result := 'g' + Result
    Else Result := Result + 'g';
    If ModifierM
    Then
        Result := 'm' + Result
    Else Result := Result + 'm';
    If ModifierX
    Then
        Result := 'x' + Result
    Else Result := Result + 'x';

    If Result[length(Result)] = '-' // remove '-' if all modifiers are 'On'
    Then
        System.Delete(Result, length(Result), 1);
End; { of function TRegExpr.GetModifierStr
--------------------------------------------------------------}

Class Function TRegExpr.ParseModifiersStr(Const AModifiers: RegExprString;
    Var AModifiersInt: Integer): Boolean;
// !!! Be carefull - this is class function and must not use object instance fields
Var
    i: Integer;
    IsOn: Boolean;
    Mask: Integer;
Begin
    Result := True;
    IsOn := True;
    Mask := 0; // prevent compiler warning
    For i := 1 To length(AModifiers) Do
        If AModifiers[i] = '-'
        Then
            IsOn := False
        Else
        Begin
            If Pos(AModifiers[i], 'iI') > 0
            Then
                Mask := MaskModI
            Else
            If Pos(AModifiers[i], 'rR') > 0
            Then
                Mask := MaskModR
            Else
            If Pos(AModifiers[i], 'sS') > 0
            Then
                Mask := MaskModS
            Else
            If Pos(AModifiers[i], 'gG') > 0
            Then
                Mask := MaskModG
            Else
            If Pos(AModifiers[i], 'mM') > 0
            Then
                Mask := MaskModM
            Else
            If Pos(AModifiers[i], 'xX') > 0
            Then
                Mask := MaskModX
            Else
            Begin
                Result := False;
                EXIT;
            End;
            If IsOn
            Then
                AModifiersInt := AModifiersInt Or Mask
            Else AModifiersInt := AModifiersInt And Not Mask;
        End;
End; { of function TRegExpr.ParseModifiersStr
--------------------------------------------------------------}

Procedure TRegExpr.SetModifierStr(Const AModifiers: RegExprString);
Begin
    If Not ParseModifiersStr(AModifiers, fModifiers)
    Then
        Error(reeModifierUnsupported);
End; { of procedure TRegExpr.SetModifierStr
--------------------------------------------------------------}

Function TRegExpr.GetModifier(AIndex: Integer): Boolean;
Var
    Mask: Integer;
Begin
    Result := False;
    Case AIndex Of
        1:
            Mask := MaskModI;
        2:
            Mask := MaskModR;
        3:
            Mask := MaskModS;
        4:
            Mask := MaskModG;
        5:
            Mask := MaskModM;
        6:
            Mask := MaskModX;
    Else
    Begin
        Error(reeModifierUnsupported);
        EXIT;
    End;
    End;
    Result := (fModifiers And Mask) <> 0;
End; { of function TRegExpr.GetModifier
--------------------------------------------------------------}

Procedure TRegExpr.SetModifier(AIndex: Integer; ASet: Boolean);
Var
    Mask: Integer;
Begin
    Case AIndex Of
        1:
            Mask := MaskModI;
        2:
            Mask := MaskModR;
        3:
            Mask := MaskModS;
        4:
            Mask := MaskModG;
        5:
            Mask := MaskModM;
        6:
            Mask := MaskModX;
    Else
    Begin
        Error(reeModifierUnsupported);
        EXIT;
    End;
    End;
    If ASet
    Then
        fModifiers := fModifiers Or Mask
    Else fModifiers := fModifiers And Not Mask;
End; { of procedure TRegExpr.SetModifier
--------------------------------------------------------------}


{=============================================================}
{==================== Compiler section =======================}
{=============================================================}

Procedure TRegExpr.InvalidateProgramm;
Begin
    If programm <> Nil Then
    Begin
        FreeMem(programm);
        programm := Nil;
    End;
End; { of procedure TRegExpr.InvalidateProgramm
--------------------------------------------------------------}

Procedure TRegExpr.Compile; //###0.941
Begin
    If fExpression = Nil Then
    Begin // No Expression assigned
        Error(reeNoExpression);
        EXIT;
    End;
    CompileRegExpr(fExpression);
End; { of procedure TRegExpr.Compile
--------------------------------------------------------------}

Function TRegExpr.IsProgrammOk: Boolean;
 {$IFNDEF UniCode}
Var
    i: Integer;
 {$ENDIF}
Begin
    Result := False;

  // check modifiers
    If fModifiers <> fProgModifiers //###0.941
    Then
        InvalidateProgramm;

  // can we optimize line separators by using sets?
  {$IFNDEF UniCode}
    fLineSeparatorsSet := [];
    For i := 1 To length(fLineSeparators)
        Do
        System.Include(fLineSeparatorsSet, fLineSeparators[i]);
  {$ENDIF}

  // [Re]compile if needed
    If programm = Nil
    Then
        Compile; //###0.941

  // check [re]compiled programm
    If programm = Nil
    Then
        EXIT // error was set/raised by Compile (was reeExecAfterCompErr)
    Else
    If programm[0] <> MAGIC // Program corrupted.
    Then
        Error(reeCorruptedProgram)
    Else Result := True;
End; { of function TRegExpr.IsProgrammOk
--------------------------------------------------------------}

Procedure TRegExpr.Tail(p: PRegExprChar; val: PRegExprChar);
// set the next-pointer at the end of a node chain
Var
    scan: PRegExprChar;
    temp: PRegExprChar;
//  i : int64;
Begin
    If p = @regdummy
    Then
        EXIT;
  // Find last node.
    scan := p;
    Repeat
        temp := regnext(scan);
        If temp = Nil
        Then
            BREAK;
        scan := temp;
    Until False;
  // Set Next 'pointer'
    If val < scan
    Then
        PRENextOff(scan + REOpSz)^ := -(scan - val) //###0.948
   // work around PWideChar subtraction bug (Delphi uses
   // shr after subtraction to calculate widechar distance %-( )
   // so, if difference is negative we have .. the "feature" :(
   // I could wrap it in $IFDEF UniCode, but I didn't because
   // "P – Q computes the difference between the address given
   // by P (the higher address) and the address given by Q (the
   // lower address)" - Delphi help quotation.
    Else PRENextOff(scan + REOpSz)^ := val - scan; //###0.933
End; { of procedure TRegExpr.Tail
--------------------------------------------------------------}

Procedure TRegExpr.OpTail(p: PRegExprChar; val: PRegExprChar);
// regtail on operand of first argument; nop if operandless
Begin
  // "Operandless" and "op != BRANCH" are synonymous in practice.
    If (p = Nil) Or (p = @regdummy) Or (PREOp(p)^ <> BRANCH)
    Then
        EXIT;
    Tail(p + REOpSz + RENextOffSz, val); //###0.933
End; { of procedure TRegExpr.OpTail
--------------------------------------------------------------}

Function TRegExpr.EmitNode(op: TREOp): PRegExprChar; //###0.933
// emit a node, return location
Begin
    Result := regcode;
    If Result <> @regdummy Then
    Begin
        PREOp(regcode)^ := op;
        inc(regcode, REOpSz);
        PRENextOff(regcode)^ := 0; // Next "pointer" := nil
        inc(regcode, RENextOffSz);
    End
    Else inc(regsize, REOpSz + RENextOffSz); // compute code size without code generation
End; { of function TRegExpr.EmitNode
--------------------------------------------------------------}

Procedure TRegExpr.EmitC(b: REChar);
// emit a byte to code
Begin
    If regcode <> @regdummy Then
    Begin
        regcode^ := b;
        inc(regcode);
    End
    Else inc(regsize); // Type of p-code pointer always is ^REChar
End; { of procedure TRegExpr.EmitC
--------------------------------------------------------------}

Procedure TRegExpr.InsertOperator(op: TREOp; opnd: PRegExprChar; sz: Integer);
// insert an operator in front of already-emitted operand
// Means relocating the operand.
Var
    src, dst, place: PRegExprChar;
    i: Integer;
Begin
    If regcode = @regdummy Then
    Begin
        inc(regsize, sz);
        EXIT;
    End;
    src := regcode;
    inc(regcode, sz);
    dst := regcode;
    While src > opnd Do
    Begin
        dec(dst);
        dec(src);
        dst^ := src^;
    End;
    place := opnd; // Op node, where operand used to be.
    PREOp(place)^ := op;
    inc(place, REOpSz);
    For i := 1 + REOpSz To sz Do
    Begin
        place^ := #0;
        inc(place);
    End;
End; { of procedure TRegExpr.InsertOperator
--------------------------------------------------------------}

Function strcspn(s1: PRegExprChar; s2: PRegExprChar): Integer;
// find length of initial segment of s1 consisting
// entirely of characters not from s2
Var scan1, scan2: PRegExprChar;
Begin
    Result := 0;
    scan1 := s1;
    While scan1^ <> #0 Do
    Begin
        scan2 := s2;
        While scan2^ <> #0 Do
            If scan1^ = scan2^
            Then
                EXIT
            Else inc(scan2);
        inc(Result);
        inc(scan1);
    End;
End; { of function strcspn
--------------------------------------------------------------}

Const
// Flags to be passed up and down.
    HASWIDTH = 01; // Known never to match nil string.
    SIMPLE = 02; // Simple enough to be STAR/PLUS/BRACES operand.
    SPSTART = 04; // Starts with * or +.
    WORST = 0;  // Worst case.
    META: Array [0 .. 12] Of REChar = (
        '^', '$', '.', '[', '(', ')', '|', '?', '+', '*', EscChar, '{', #0);
 // Any modification must be synchronized with QuoteRegExprMetaChars !!!

{$IFDEF UniCode}
 RusRangeLo : array [0 .. 33] of REChar =
  (#$430,#$431,#$432,#$433,#$434,#$435,#$451,#$436,#$437,
   #$438,#$439,#$43A,#$43B,#$43C,#$43D,#$43E,#$43F,
   #$440,#$441,#$442,#$443,#$444,#$445,#$446,#$447,
   #$448,#$449,#$44A,#$44B,#$44C,#$44D,#$44E,#$44F,#0);
 RusRangeHi : array [0 .. 33] of REChar =
  (#$410,#$411,#$412,#$413,#$414,#$415,#$401,#$416,#$417,
   #$418,#$419,#$41A,#$41B,#$41C,#$41D,#$41E,#$41F,
   #$420,#$421,#$422,#$423,#$424,#$425,#$426,#$427,
   #$428,#$429,#$42A,#$42B,#$42C,#$42D,#$42E,#$42F,#0);
 RusRangeLoLow = #$430{'à'};
 RusRangeLoHigh = #$44F{'ÿ'};
 RusRangeHiLow = #$410{'À'};
 RusRangeHiHigh = #$42F{'ß'};
{$ELSE}
    RusRangeLo = 'àáâãäå¸æçèéêëìíîïðñòóôõö÷øùúûüýþÿ';
    RusRangeHi = 'ÀÁÂÃÄÅ¨ÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞß';
    RusRangeLoLow = 'à';
    RusRangeLoHigh = 'ÿ';
    RusRangeHiLow = 'À';
    RusRangeHiHigh = 'ß';
{$ENDIF}

Function TRegExpr.CompileRegExpr(exp: PRegExprChar): Boolean;
// compile a regular expression into internal code
// We can't allocate space until we know how big the compiled form will be,
// but we can't compile it (and thus know how big it is) until we've got a
// place to put the code.  So we cheat:  we compile it twice, once with code
// generation turned off and size counting turned on, and once "for real".
// This also means that we don't allocate space until we are sure that the
// thing really will compile successfully, and we never have to move the
// code and thus invalidate pointers into it.  (Note that it has to be in
// one piece because free() must be able to free it all.)
// Beware that the optimization-preparation code in here knows about some
// of the structure of the compiled regexp.
Var
    scan, longest: PRegExprChar;
    len: Cardinal;
    flags: Integer;
Begin
    Result := False; // life too dark

    regparse := Nil; // for correct error handling
    regexpbeg := exp;
    Try

        If programm <> Nil Then
        Begin
            FreeMem(programm);
            programm := Nil;
        End;

        If exp = Nil Then
        Begin
            Error(reeCompNullArgument);
            EXIT;
        End;

        fProgModifiers := fModifiers;
  // well, may it's paranoia. I'll check it later... !!!!!!!!

  // First pass: determine size, legality.
        fCompModifiers := fModifiers;
        regparse := exp;
        regnpar := 1;
        regsize := 0;
        regcode := @regdummy;
        EmitC(MAGIC);
        If ParseReg(0, flags) = Nil
        Then
            EXIT;

  // Small enough for 2-bytes programm pointers ?
  // ###0.933 no real p-code length limits now :)))
//  if regsize >= 64 * 1024 then begin
//    Error (reeCompRegexpTooBig);
//    EXIT;
//   end;

  // Allocate space.
        GetMem(programm, regsize * SizeOf(REChar));

  // Second pass: emit code.
        fCompModifiers := fModifiers;
        regparse := exp;
        regnpar := 1;
        regcode := programm;
        EmitC(MAGIC);
        If ParseReg(0, flags) = Nil
        Then
            EXIT;

  // Dig out information for optimizations.
  {$IFDEF UseFirstCharSet} //###0.929
        FirstCharSet := [];
        FillFirstCharSet(programm + REOpSz);
  {$ENDIF}
        regstart := #0; // Worst-case defaults.
        reganch := #0;
        regmust := Nil;
        regmlen := 0;
        scan := programm + REOpSz; // First BRANCH.
        If PREOp(regnext(scan))^ = EEND Then
        Begin // Only one top-level choice.
            scan := scan + REOpSz + RENextOffSz;

    // Starting-point info.
            If PREOp(scan)^ = EXACTLY
            Then
                regstart := (scan + REOpSz + RENextOffSz)^
            Else
            If PREOp(scan)^ = BOL
            Then
                inc(reganch);

    // If there's something expensive in the r.e., find the longest
    // literal string that must appear and make it the regmust.  Resolve
    // ties in favor of later strings, since the regstart check works
    // with the beginning of the r.e. and avoiding duplication
    // strengthens checking.  Not a strong reason, but sufficient in the
    // absence of others.
            If (flags And SPSTART) <> 0 Then
            Begin
                longest := Nil;
                len := 0;
                While scan <> Nil Do
                Begin
                    If (PREOp(scan)^ = EXACTLY)
                        And (strlen(scan + REOpSz + RENextOffSz) >= len) Then
                    Begin
                        longest := scan + REOpSz + RENextOffSz;
                        len := strlen(longest);
                    End;
                    scan := regnext(scan);
                End;
                regmust := longest;
                regmlen := len;
            End;
        End;

        Result := True;

    Finally Begin
            If Not Result
            Then
                InvalidateProgramm;
            regexpbeg := Nil;
            fExprIsCompiled := Result; //###0.944
        End;
    End;

End; { of function TRegExpr.CompileRegExpr
--------------------------------------------------------------}

Function TRegExpr.ParseReg(paren: Integer; Var flagp: Integer): PRegExprChar;
// regular expression, i.e. main body or parenthesized thing
// Caller must absorb opening parenthesis.
// Combining parenthesis handling with the base level of regular expression
// is a trifle forced, but the need to tie the tails of the branches to what
// follows makes it hard to avoid.
Var
    ret, br, ender: PRegExprChar;
    parno: Integer;
    flags: Integer;
    SavedModifiers: Integer;
Begin
    Result := Nil;
    flagp := HASWIDTH; // Tentatively.
    parno := 0; // eliminate compiler stupid warning
    SavedModifiers := fCompModifiers;

  // Make an OPEN node, if parenthesized.
    If paren <> 0 Then
    Begin
        If regnpar >= NSUBEXP Then
        Begin
            Error(reeCompParseRegTooManyBrackets);
            EXIT;
        End;
        parno := regnpar;
        inc(regnpar);
        ret := EmitNode(TREOp(ord(OPEN) + parno));
    End
    Else ret := Nil;

  // Pick up the branches, linking them together.
    br := ParseBranch(flags);
    If br = Nil Then
    Begin
        Result := Nil;
        EXIT;
    End;
    If ret <> Nil
    Then
        Tail(ret, br) // OPEN -> first.
    Else ret := br;
    If (flags And HASWIDTH) = 0
    Then
        flagp := flagp And Not HASWIDTH;
    flagp := flagp Or flags And SPSTART;
    While (regparse^ = '|') Do
    Begin
        inc(regparse);
        br := ParseBranch(flags);
        If br = Nil Then
        Begin
            Result := Nil;
            EXIT;
        End;
        Tail(ret, br); // BRANCH -> BRANCH.
        If (flags And HASWIDTH) = 0
        Then
            flagp := flagp And Not HASWIDTH;
        flagp := flagp Or flags And SPSTART;
    End;

  // Make a closing node, and hook it on the end.
    If paren <> 0
    Then
        ender := EmitNode(TREOp(ord(CLOSE) + parno))
    Else ender := EmitNode(EEND);
    Tail(ret, ender);

  // Hook the tails of the branches to the closing node.
    br := ret;
    While br <> Nil Do
    Begin
        OpTail(br, ender);
        br := regnext(br);
    End;

  // Check for proper termination.
    If paren <> 0 Then
        If regparse^ <> ')' Then
        Begin
            Error(reeCompParseRegUnmatchedBrackets);
            EXIT;
        End
        Else inc(regparse); // skip trailing ')'
    If (paren = 0) And (regparse^ <> #0) Then
    Begin
        If regparse^ = ')'
        Then
            Error(reeCompParseRegUnmatchedBrackets2)
        Else Error(reeCompParseRegJunkOnEnd);
        EXIT;
    End;
    fCompModifiers := SavedModifiers; // restore modifiers of parent
    Result := ret;
End; { of function TRegExpr.ParseReg
--------------------------------------------------------------}

Function TRegExpr.ParseBranch(Var flagp: Integer): PRegExprChar;
// one alternative of an | operator
// Implements the concatenation operator.
Var
    ret, chain, latest: PRegExprChar;
    flags: Integer;
Begin
    flagp := WORST; // Tentatively.

    ret := EmitNode(BRANCH);
    chain := Nil;
    While (regparse^ <> #0) And (regparse^ <> '|')
        And (regparse^ <> ')') Do
    Begin
        latest := ParsePiece(flags);
        If latest = Nil Then
        Begin
            Result := Nil;
            EXIT;
        End;
        flagp := flagp Or flags And HASWIDTH;
        If chain = Nil // First piece.
        Then
            flagp := flagp Or flags And SPSTART
        Else Tail(chain, latest);
        chain := latest;
    End;
    If chain = Nil // Loop ran zero times.
    Then
        EmitNode(NOTHING);
    Result := ret;
End; { of function TRegExpr.ParseBranch
--------------------------------------------------------------}

Function TRegExpr.ParsePiece(Var flagp: Integer): PRegExprChar;
// something followed by possible [*+?{]
// Note that the branching code sequences used for ? and the general cases
// of * and + and { are somewhat optimized:  they use the same NOTHING node as
// both the endmarker for their branch list and the body of the last branch.
// It might seem that this node could be dispensed with entirely, but the
// endmarker role is not redundant.
    Function parsenum(AStart, AEnd: PRegExprChar): TREBracesArg;
    Begin
        Result := 0;
        If AEnd - AStart + 1 > 8 Then
        Begin // prevent stupid scanning
            Error(reeBRACESArgTooBig);
            EXIT;
        End;
        While AStart <= AEnd Do
        Begin
            Result := Result * 10 + (ord(AStart^) - ord('0'));
            inc(AStart);
        End;
        If (Result > MaxBracesArg) Or (Result < 0) Then
        Begin
            Error(reeBRACESArgTooBig);
            EXIT;
        End;
    End;

Var
    op: REChar;
    NonGreedyOp, NonGreedyCh: Boolean; //###0.940
    TheOp: TREOp; //###0.940
    NextNode: PRegExprChar;
    flags: Integer;
    BracesMin, Bracesmax: TREBracesArg;
    p, savedparse: PRegExprChar;

    Procedure EmitComplexBraces(ABracesMin, ABracesMax: TREBracesArg;
        ANonGreedyOp: Boolean); //###0.940
  {$IFDEF ComplexBraces}
    Var
        off: Integer;
  {$ENDIF}
    Begin
   {$IFNDEF ComplexBraces}
   Error (reeComplexBracesNotImplemented);
   {$ELSE}
        If ANonGreedyOp
        Then
            TheOp := LOOPNG
        Else TheOp := LOOP;
        InsertOperator(LOOPENTRY, Result, REOpSz + RENextOffSz);
        NextNode := EmitNode(TheOp);
        If regcode <> @regdummy Then
        Begin
            off := (Result + REOpSz + RENextOffSz)
                - (regcode - REOpSz - RENextOffSz); // back to Atom after LOOPENTRY
            PREBracesArg(regcode)^ := ABracesMin;
            inc(regcode, REBracesArgSz);
            PREBracesArg(regcode)^ := ABracesMax;
            inc(regcode, REBracesArgSz);
            PRENextOff(regcode)^ := off;
            inc(regcode, RENextOffSz);
        End
        Else inc(regsize, REBracesArgSz * 2 + RENextOffSz);
        Tail(Result, NextNode); // LOOPENTRY -> LOOP
        If regcode <> @regdummy Then
            Tail(Result + REOpSz + RENextOffSz, NextNode); // Atom -> LOOP
   {$ENDIF}
    End;

    Procedure EmitSimpleBraces(ABracesMin, ABracesMax: TREBracesArg;
        ANonGreedyOp: Boolean); //###0.940
    Begin
        If ANonGreedyOp //###0.940
        Then
            TheOp := BRACESNG
        Else TheOp := BRACES;
        InsertOperator(TheOp, Result, REOpSz + RENextOffSz + REBracesArgSz * 2);
        If regcode <> @regdummy Then
        Begin
            PREBracesArg(Result + REOpSz + RENextOffSz)^ := ABracesMin;
            PREBracesArg(Result + REOpSz + RENextOffSz + REBracesArgSz)^ := ABracesMax;
        End;
    End;

Begin
    Result := ParseAtom(flags);
    If Result = Nil
    Then
        EXIT;

    op := regparse^;
    If Not ((op = '*') Or (op = '+') Or (op = '?') Or (op = '{')) Then
    Begin
        flagp := flags;
        EXIT;
    End;
    If ((flags And HASWIDTH) = 0) And (op <> '?') Then
    Begin
        Error(reePlusStarOperandCouldBeEmpty);
        EXIT;
    End;

    Case op Of
        '*':
        Begin
            flagp := WORST Or SPSTART;
            NonGreedyCh := (regparse + 1)^ = '?'; //###0.940
            NonGreedyOp := NonGreedyCh Or ((fCompModifiers And MaskModG) = 0); //###0.940
            If (flags And SIMPLE) = 0 Then
            Begin
                If NonGreedyOp //###0.940
                Then
                    EmitComplexBraces(0, MaxBracesArg, NonGreedyOp)
                Else
                Begin // Emit x* as (x&|), where & means "self".
                    InsertOperator(BRANCH, Result, REOpSz + RENextOffSz); // Either x
                    OpTail(Result, EmitNode(BACK)); // and loop
                    OpTail(Result, Result); // back
                    Tail(Result, EmitNode(BRANCH)); // or
                    Tail(Result, EmitNode(NOTHING)); // nil.
                End;
            End
            Else
            Begin // Simple
                If NonGreedyOp //###0.940
                Then
                    TheOp := STARNG
                Else TheOp := STAR;
                InsertOperator(TheOp, Result, REOpSz + RENextOffSz);
            End;
            If NonGreedyCh //###0.940
            Then
                inc(regparse); // Skip extra char ('?')
        End; { of case '*'}
        '+':
        Begin
            flagp := WORST Or SPSTART Or HASWIDTH;
            NonGreedyCh := (regparse + 1)^ = '?'; //###0.940
            NonGreedyOp := NonGreedyCh Or ((fCompModifiers And MaskModG) = 0); //###0.940
            If (flags And SIMPLE) = 0 Then
            Begin
                If NonGreedyOp //###0.940
                Then
                    EmitComplexBraces(1, MaxBracesArg, NonGreedyOp)
                Else
                Begin // Emit x+ as x(&|), where & means "self".
                    NextNode := EmitNode(BRANCH); // Either
                    Tail(Result, NextNode);
                    Tail(EmitNode(BACK), Result);    // loop back
                    Tail(NextNode, EmitNode(BRANCH)); // or
                    Tail(Result, EmitNode(NOTHING)); // nil.
                End;
            End
            Else
            Begin // Simple
                If NonGreedyOp //###0.940
                Then
                    TheOp := PLUSNG
                Else TheOp := PLUS;
                InsertOperator(TheOp, Result, REOpSz + RENextOffSz);
            End;
            If NonGreedyCh //###0.940
            Then
                inc(regparse); // Skip extra char ('?')
        End; { of case '+'}
        '?':
        Begin
            flagp := WORST;
            NonGreedyCh := (regparse + 1)^ = '?'; //###0.940
            NonGreedyOp := NonGreedyCh Or ((fCompModifiers And MaskModG) = 0); //###0.940
            If NonGreedyOp Then
            Begin //###0.940  // We emit x?? as x{0,1}?
                If (flags And SIMPLE) = 0
                Then
                    EmitComplexBraces(0, 1, NonGreedyOp)
                Else EmitSimpleBraces(0, 1, NonGreedyOp);
            End
            Else
            Begin // greedy '?'
                InsertOperator(BRANCH, Result, REOpSz + RENextOffSz); // Either x
                Tail(Result, EmitNode(BRANCH));  // or
                NextNode := EmitNode(NOTHING); // nil.
                Tail(Result, NextNode);
                OpTail(Result, NextNode);
            End;
            If NonGreedyCh //###0.940
            Then
                inc(regparse); // Skip extra char ('?')
        End; { of case '?'}
        '{':
        Begin
            savedparse := regparse;
      // !!!!!!!!!!!!
      // Filip Jirsak's note - what will happen, when we are at the end of regparse?
            inc(regparse);
            p := regparse;
            While Pos(regparse^, '0123456789') > 0  // <min> MUST appear
                Do
                inc(regparse);
            If (regparse^ <> '}') And (regparse^ <> ',') Or (p = regparse) Then
            Begin
                regparse := savedparse;
                flagp := flags;
                EXIT;
            End;
            BracesMin := parsenum(p, regparse - 1);
            If regparse^ = ',' Then
            Begin
                inc(regparse);
                p := regparse;
                While Pos(regparse^, '0123456789') > 0
                    Do
                    inc(regparse);
                If regparse^ <> '}' Then
                Begin
                    regparse := savedparse;
                    EXIT;
                End;
                If p = regparse
                Then
                    BracesMax := MaxBracesArg
                Else BracesMax := parsenum(p, regparse - 1);
            End
            Else BracesMax := BracesMin; // {n} == {n,n}
            If BracesMin > BracesMax Then
            Begin
                Error(reeBracesMinParamGreaterMax);
                EXIT;
            End;
            If BracesMin > 0
            Then
                flagp := WORST;
            If BracesMax > 0
            Then
                flagp := flagp Or HASWIDTH Or SPSTART;

            NonGreedyCh := (regparse + 1)^ = '?'; //###0.940
            NonGreedyOp := NonGreedyCh Or ((fCompModifiers And MaskModG) = 0); //###0.940
            If (flags And SIMPLE) <> 0
            Then
                EmitSimpleBraces(BracesMin, BracesMax, NonGreedyOp)
            Else EmitComplexBraces(BracesMin, BracesMax, NonGreedyOp);
            If NonGreedyCh //###0.940
            Then
                inc(regparse); // Skip extra char '?'
        End; { of case '{'}
//    else // here we can't be
    End; { of case op}

    inc(regparse);
    If (regparse^ = '*') Or (regparse^ = '+') Or (regparse^ = '?') Or (regparse^ = '{') Then
    Begin
        Error(reeNestedSQP);
        EXIT;
    End;
End; { of function TRegExpr.ParsePiece
--------------------------------------------------------------}

Function TRegExpr.ParseAtom(Var flagp: Integer): PRegExprChar;
// the lowest level
// Optimization:  gobbles an entire sequence of ordinary characters so that
// it can turn them into a single node, which is smaller to store and
// faster to run.  Backslashed characters are exceptions, each becoming a
// separate node; the code is simpler that way and it's not worth fixing.
Var
    ret: PRegExprChar;
    flags: Integer;
    RangeBeg, RangeEnd: REChar;
    CanBeRange: Boolean;
    len: Integer;
    ender: REChar;
    begmodfs: PRegExprChar;

  {$IFDEF UseSetOfChar} //###0.930
    RangePCodeBeg: PRegExprChar;
    RangePCodeIdx: Integer;
    RangeIsCI: Boolean;
    RangeSet: TSetOfREChar;
    RangeLen: Integer;
    RangeChMin, RangeChMax: REChar;
  {$ENDIF}

    Procedure EmitExactly(ch: REChar);
    Begin
        If (fCompModifiers And MaskModI) <> 0
        Then
            ret := EmitNode(EXACTLYCI)
        Else ret := EmitNode(EXACTLY);
        EmitC(ch);
        EmitC(#0);
        flagp := flagp Or HASWIDTH Or SIMPLE;
    End;

    Procedure EmitStr(Const s: RegExprString);
    Var i: Integer;
    Begin
        For i := 1 To length(s)
            Do
            EmitC(s[i]);
    End;

    Function HexDig(ch: REChar): Integer;
    Begin
        Result := 0;
        If (ch >= 'a') And (ch <= 'f')
        Then
            ch := REChar(ord(ch) - (ord('a') - ord('A')));
        If (ch < '0') Or (ch > 'F') Or ((ch > '9') And (ch < 'A')) Then
        Begin
            Error(reeBadHexDigit);
            EXIT;
        End;
        Result := ord(ch) - ord('0');
        If ch >= 'A'
        Then
            Result := Result - (ord('A') - ord('9') - 1);
    End;

    Function EmitRange(AOpCode: REChar): PRegExprChar;
    Begin
   {$IFDEF UseSetOfChar}
        Case AOpCode Of
            ANYBUTCI, ANYBUT:
                Result := EmitNode(ANYBUTTINYSET);
        Else // ANYOFCI, ANYOF
            Result := EmitNode(ANYOFTINYSET);
        End;
        Case AOpCode Of
            ANYBUTCI, ANYOFCI:
                RangeIsCI := True;
        Else // ANYBUT, ANYOF
            RangeIsCI := False;
        End;
        RangePCodeBeg := regcode;
        RangePCodeIdx := regsize;
        RangeLen := 0;
        RangeSet := [];
        RangeChMin := #255;
        RangeChMax := #0;
   {$ELSE}
   Result := EmitNode (AOpCode);
   // ToDo:
   // !!!!!!!!!!!!! Implement ANYOF[BUT]TINYSET generation for UniCode !!!!!!!!!!
   {$ENDIF}
    End;

{$IFDEF UseSetOfChar}
    Procedure EmitRangeCPrim(b: REChar); //###0.930
    Begin
        If b In RangeSet
        Then
            EXIT;
        inc(RangeLen);
        If b < RangeChMin
        Then
            RangeChMin := b;
        If b > RangeChMax
        Then
            RangeChMax := b;
        Include(RangeSet, b);
    End;
 {$ENDIF}

    Procedure EmitRangeC(b: REChar);
  {$IFDEF UseSetOfChar}
    Var
        Ch: REChar;
  {$ENDIF}
    Begin
        CanBeRange := False;
   {$IFDEF UseSetOfChar}
        If b <> #0 Then
        Begin
            EmitRangeCPrim(b); //###0.930
            If RangeIsCI
            Then
                EmitRangeCPrim(InvertCase(b)); //###0.930
        End
        Else
        Begin
       {$IFDEF UseAsserts}
            Assert(RangeLen > 0, 'TRegExpr.ParseAtom(subroutine EmitRangeC): empty range'); // impossible, but who knows..
            Assert(RangeChMin <= RangeChMax, 'TRegExpr.ParseAtom(subroutine EmitRangeC): RangeChMin > RangeChMax'); // impossible, but who knows..
       {$ENDIF}
            If RangeLen <= TinySetLen Then
            Begin // emit "tiny set"
                If regcode = @regdummy Then
                Begin
                    regsize := RangePCodeIdx + TinySetLen; // RangeChMin/Max !!!
                    EXIT;
                End;
                regcode := RangePCodeBeg;
                For Ch := RangeChMin To RangeChMax Do //###0.930
                    If Ch In RangeSet Then
                    Begin
                        regcode^ := Ch;
                        inc(regcode);
                    End;
          // fill rest:
                While regcode < RangePCodeBeg + TinySetLen Do
                Begin
                    regcode^ := RangeChMax;
                    inc(regcode);
                End;
            End
            Else
            Begin
                If regcode = @regdummy Then
                Begin
                    regsize := RangePCodeIdx + SizeOf(TSetOfREChar);
                    EXIT;
                End;
                If (RangePCodeBeg - REOpSz - RENextOffSz)^ = ANYBUTTINYSET
                Then
                    RangeSet := [#0 .. #255] - RangeSet;
                PREOp(RangePCodeBeg - REOpSz - RENextOffSz)^ := ANYOFFULLSET;
                regcode := RangePCodeBeg;
                Move(RangeSet, regcode^, SizeOf(TSetOfREChar));
                inc(regcode, SizeOf(TSetOfREChar));
            End;
        End;
   {$ELSE}
   EmitC (b);
   {$ENDIF}
    End;

    Procedure EmitSimpleRangeC(b: REChar);
    Begin
        RangeBeg := b;
        EmitRangeC(b);
        CanBeRange := True;
    End;

    Procedure EmitRangeStr(Const s: RegExprString);
    Var i: Integer;
    Begin
        For i := 1 To length(s)
            Do
            EmitRangeC(s[i]);
    End;

    Function UnQuoteChar(Var APtr: PRegExprChar): REChar; //###0.934
    Begin
        Case APtr^ Of
            't':
                Result := #$9;  // tab (HT/TAB)
            'n':
                Result := #$a;  // newline (NL)
            'r':
                Result := #$d;  // car.return (CR)
            'f':
                Result := #$c;  // form feed (FF)
            'a':
                Result := #$7;  // alarm (bell) (BEL)
            'e':
                Result := #$1b; // escape (ESC)
            'x':
            Begin // hex char
                Result := #0;
                inc(APtr);
                If APtr^ = #0 Then
                Begin
                    Error(reeNoHexCodeAfterBSlashX);
                    EXIT;
                End;
                If APtr^ = '{' Then
                Begin // \x{nnnn} //###0.936
                    Repeat
                        inc(APtr);
                        If APtr^ = #0 Then
                        Begin
                            Error(reeNoHexCodeAfterBSlashX);
                            EXIT;
                        End;
                        If APtr^ <> '}' Then
                        Begin
                            If (Ord(Result)
                                Shr (SizeOf(REChar) * 8 - 4)) And $F <> 0 Then
                            Begin
                                Error(reeHexCodeAfterBSlashXTooBig);
                                EXIT;
                            End;
                            Result := REChar((Ord(Result) Shl 4) Or HexDig(APtr^));
              // HexDig will cause Error if bad hex digit found
                        End
                        Else BREAK;
                    Until False;
                End
                Else
                Begin
                    Result := REChar(HexDig(APtr^));
          // HexDig will cause Error if bad hex digit found
                    inc(APtr);
                    If APtr^ = #0 Then
                    Begin
                        Error(reeNoHexCodeAfterBSlashX);
                        EXIT;
                    End;
                    Result := REChar((Ord(Result) Shl 4) Or HexDig(APtr^));
          // HexDig will cause Error if bad hex digit found
                End;
            End;
        Else
            Result := APtr^;
        End;
    End;

Begin
    Result := Nil;
    flagp := WORST; // Tentatively.

    inc(regparse);
    Case (regparse - 1)^ Of
        '^':
            If ((fCompModifiers And MaskModM) = 0)
                Or ((fLineSeparators = '') And Not fLinePairedSeparatorAssigned)
            Then
                ret := EmitNode(BOL)
            Else ret := EmitNode(BOLML);
        '$':
            If ((fCompModifiers And MaskModM) = 0)
                Or ((fLineSeparators = '') And Not fLinePairedSeparatorAssigned)
            Then
                ret := EmitNode(EOL)
            Else ret := EmitNode(EOLML);
        '.':
            If (fCompModifiers And MaskModS) <> 0 Then
            Begin
                ret := EmitNode(ANY);
                flagp := flagp Or HASWIDTH Or SIMPLE;
            End
            Else
            Begin // not /s, so emit [^:LineSeparators:]
                ret := EmitNode(ANYML);
                flagp := flagp Or HASWIDTH; // not so simple ;)
//          ret := EmitRange (ANYBUT);
//          EmitRangeStr (LineSeparators); //###0.941
//          EmitRangeStr (LinePairedSeparator); // !!! isn't correct if have to accept only paired
//          EmitRangeC (#0);
//          flagp := flagp or HASWIDTH or SIMPLE;
            End;
        '[':
        Begin
            If regparse^ = '^' Then
            Begin // Complement of range.
                If (fCompModifiers And MaskModI) <> 0
                Then
                    ret := EmitRange(ANYBUTCI)
                Else ret := EmitRange(ANYBUT);
                inc(regparse);
            End
            Else
            If (fCompModifiers And MaskModI) <> 0
            Then
                ret := EmitRange(ANYOFCI)
            Else ret := EmitRange(ANYOF);

            CanBeRange := False;

            If (regparse^ = ']') Then
            Begin
                EmitSimpleRangeC(regparse^); // []-a] -> ']' .. 'a'
                inc(regparse);
            End;

            While (regparse^ <> #0) And (regparse^ <> ']') Do
            Begin
                If (regparse^ = '-')
                    And ((regparse + 1)^ <> #0) And ((regparse + 1)^ <> ']')
                    And CanBeRange Then
                Begin
                    inc(regparse);
                    RangeEnd := regparse^;
                    If RangeEnd = EscChar Then
                    Begin
               {$IFDEF UniCode} //###0.935
               if (ord ((regparse + 1)^) < 256)
                  and (char ((regparse + 1)^)
                        in ['d', 'D', 's', 'S', 'w', 'W']) then begin
               {$ELSE}
                        If (regparse + 1)^ In ['d', 'D', 's', 'S', 'w', 'W'] Then
                        Begin
               {$ENDIF}
                            EmitRangeC('-'); // or treat as error ?!!
                            CONTINUE;
                        End;
                        inc(regparse);
                        RangeEnd := UnQuoteChar(regparse);
                    End;

             // r.e.ranges extension for russian
                    If ((fCompModifiers And MaskModR) <> 0)
                        And (RangeBeg = RusRangeLoLow) And (RangeEnd = RusRangeLoHigh) Then
                    Begin
                        EmitRangeStr(RusRangeLo);
                    End
                    Else
                    If ((fCompModifiers And MaskModR) <> 0)
                        And (RangeBeg = RusRangeHiLow) And (RangeEnd = RusRangeHiHigh) Then
                    Begin
                        EmitRangeStr(RusRangeHi);
                    End
                    Else
                    If ((fCompModifiers And MaskModR) <> 0)
                        And (RangeBeg = RusRangeLoLow) And (RangeEnd = RusRangeHiHigh) Then
                    Begin
                        EmitRangeStr(RusRangeLo);
                        EmitRangeStr(RusRangeHi);
                    End
                    Else
                    Begin // standard r.e. handling
                        If RangeBeg > RangeEnd Then
                        Begin
                            Error(reeInvalidRange);
                            EXIT;
                        End;
                        inc(RangeBeg);
                        EmitRangeC(RangeEnd); // prevent infinite loop if RangeEnd=$ff
                        While RangeBeg < RangeEnd Do
                        Begin //###0.929
                            EmitRangeC(RangeBeg);
                            inc(RangeBeg);
                        End;
                    End;
                    inc(regparse);
                End
                Else
                Begin
                    If regparse^ = EscChar Then
                    Begin
                        inc(regparse);
                        If regparse^ = #0 Then
                        Begin
                            Error(reeParseAtomTrailingBackSlash);
                            EXIT;
                        End;
                        Case regparse^ Of // r.e.extensions
                            'd':
                                EmitRangeStr('0123456789');
                            'w':
                                EmitRangeStr(WordChars);
                            's':
                                EmitRangeStr(SpaceChars);
                        Else
                            EmitSimpleRangeC(UnQuoteChar(regparse));
                        End; { of case}
                    End
                    Else EmitSimpleRangeC(regparse^);
                    inc(regparse);
                End;
            End; { of while}
            EmitRangeC(#0);
            If regparse^ <> ']' Then
            Begin
                Error(reeUnmatchedSqBrackets);
                EXIT;
            End;
            inc(regparse);
            flagp := flagp Or HASWIDTH Or SIMPLE;
        End;
        '(':
        Begin
            If regparse^ = '?' Then
            Begin
           // check for extended Perl syntax : (?..)
                If (regparse + 1)^ = '#' Then
                Begin // (?#comment)
                    inc(regparse, 2); // find closing ')'
                    While (regparse^ <> #0) And (regparse^ <> ')')
                        Do
                        inc(regparse);
                    If regparse^ <> ')' Then
                    Begin
                        Error(reeUnclosedComment);
                        EXIT;
                    End;
                    inc(regparse); // skip ')'
                    ret := EmitNode(COMMENT); // comment
                End
                Else
                Begin // modifiers ?
                    inc(regparse); // skip '?'
                    begmodfs := regparse;
                    While (regparse^ <> #0) And (regparse^ <> ')')
                        Do
                        inc(regparse);
                    If (regparse^ <> ')')
                        Or Not ParseModifiersStr(copy(begmodfs, 1, (regparse - begmodfs)), fCompModifiers) Then
                    Begin
                        Error(reeUrecognizedModifier);
                        EXIT;
                    End;
                    inc(regparse); // skip ')'
                    ret := EmitNode(COMMENT); // comment
//             Error (reeQPSBFollowsNothing);
//             EXIT;
                End;
            End
            Else
            Begin
                ret := ParseReg(1, flags);
                If ret = Nil Then
                Begin
                    Result := Nil;
                    EXIT;
                End;
                flagp := flagp Or flags And (HASWIDTH Or SPSTART);
            End;
        End;
        #0, '|', ')':
        Begin // Supposed to be caught earlier.
            Error(reeInternalUrp);
            EXIT;
        End;
        '?', '+', '*':
        Begin
            Error(reeQPSBFollowsNothing);
            EXIT;
        End;
        EscChar:
        Begin
            If regparse^ = #0 Then
            Begin
                Error(reeTrailingBackSlash);
                EXIT;
            End;
            Case regparse^ Of // r.e.extensions
                'b':
                    ret := EmitNode(BOUND); //###0.943
                'B':
                    ret := EmitNode(NOTBOUND); //###0.943
                'A':
                    ret := EmitNode(BOL); //###0.941
                'Z':
                    ret := EmitNode(EOL); //###0.941
                'd':
                Begin // r.e.extension - any digit ('0' .. '9')
                    ret := EmitNode(ANYDIGIT);
                    flagp := flagp Or HASWIDTH Or SIMPLE;
                End;
                'D':
                Begin // r.e.extension - not digit ('0' .. '9')
                    ret := EmitNode(NOTDIGIT);
                    flagp := flagp Or HASWIDTH Or SIMPLE;
                End;
                's':
                Begin // r.e.extension - any space char
             {$IFDEF UseSetOfChar}
                    ret := EmitRange(ANYOF);
                    EmitRangeStr(SpaceChars);
                    EmitRangeC(#0);
             {$ELSE}
             ret := EmitNode (ANYSPACE);
             {$ENDIF}
                    flagp := flagp Or HASWIDTH Or SIMPLE;
                End;
                'S':
                Begin // r.e.extension - not space char
             {$IFDEF UseSetOfChar}
                    ret := EmitRange(ANYBUT);
                    EmitRangeStr(SpaceChars);
                    EmitRangeC(#0);
             {$ELSE}
             ret := EmitNode (NOTSPACE);
             {$ENDIF}
                    flagp := flagp Or HASWIDTH Or SIMPLE;
                End;
                'w':
                Begin // r.e.extension - any english char / digit / '_'
             {$IFDEF UseSetOfChar}
                    ret := EmitRange(ANYOF);
                    EmitRangeStr(WordChars);
                    EmitRangeC(#0);
             {$ELSE}
             ret := EmitNode (ANYLETTER);
             {$ENDIF}
                    flagp := flagp Or HASWIDTH Or SIMPLE;
                End;
                'W':
                Begin // r.e.extension - not english char / digit / '_'
             {$IFDEF UseSetOfChar}
                    ret := EmitRange(ANYBUT);
                    EmitRangeStr(WordChars);
                    EmitRangeC(#0);
             {$ELSE}
             ret := EmitNode (NOTLETTER);
             {$ENDIF}
                    flagp := flagp Or HASWIDTH Or SIMPLE;
                End;
                '1' .. '9':
                Begin //###0.936
                    If (fCompModifiers And MaskModI) <> 0
                    Then
                        ret := EmitNode(BSUBEXPCI)
                    Else ret := EmitNode(BSUBEXP);
                    EmitC(REChar(ord(regparse^) - ord('0')));
                    flagp := flagp Or HASWIDTH Or SIMPLE;
                End;
            Else
                EmitExactly(UnQuoteChar(regparse));
            End; { of case}
            inc(regparse);
        End;
    Else
    Begin
        dec(regparse);
        If ((fCompModifiers And MaskModX) <> 0) And // check for eXtended syntax
            ((regparse^ = '#')
            Or ({$IFDEF UniCode}StrScan (XIgnoredChars, regparse^) <> nil //###0.947
               {$ELSE}regparse^ In XIgnoredChars{$ENDIF})) Then
        Begin //###0.941 \x
            If regparse^ = '#' Then
            Begin // Skip eXtended comment
            // find comment terminator (group of \n and/or \r)
                While (regparse^ <> #0) And (regparse^ <> #$d) And (regparse^ <> #$a)
                    Do
                    inc(regparse);
                While (regparse^ = #$d) Or (regparse^ = #$a) // skip comment terminator
                    Do
                    inc(regparse); // attempt to support different type of line separators
            End
            Else
            Begin // Skip the blanks!
                While {$IFDEF UniCode}StrScan (XIgnoredChars, regparse^) <> nil //###0.947
                  {$ELSE}regparse^ In XIgnoredChars{$ENDIF}
                    Do
                    inc(regparse);
            End;
            ret := EmitNode(COMMENT); // comment
        End
        Else
        Begin
            len := strcspn(regparse, META);
            If len <= 0 Then
                If regparse^ <> '{' Then
                Begin
                    Error(reeRarseAtomInternalDisaster);
                    EXIT;
                End
                Else len := strcspn(regparse + 1, META) + 1; // bad {n,m} - compile as EXATLY
            ender := (regparse + len)^;
            If (len > 1)
                And ((ender = '*') Or (ender = '+') Or (ender = '?') Or (ender = '{'))
            Then
                dec(len); // Back off clear of ?+*{ operand.
            flagp := flagp Or HASWIDTH;
            If len = 1
            Then
                flagp := flagp Or SIMPLE;
            If (fCompModifiers And MaskModI) <> 0
            Then
                ret := EmitNode(EXACTLYCI)
            Else ret := EmitNode(EXACTLY);
            While (len > 0)
                And (((fCompModifiers And MaskModX) = 0) Or (regparse^ <> '#')) Do
            Begin
                If ((fCompModifiers And MaskModX) = 0) Or Not ( //###0.941
              {$IFDEF UniCode}StrScan (XIgnoredChars, regparse^) <> nil //###0.947
              {$ELSE}regparse^ In XIgnoredChars{$ENDIF} )
                Then
                    EmitC(regparse^);
                inc(regparse);
                dec(len);
            End;
            EmitC(#0);
        End; { of if not comment}
    End; { of case else}
    End; { of case}

    Result := ret;
End; { of function TRegExpr.ParseAtom
--------------------------------------------------------------}

Function TRegExpr.GetCompilerErrorPos: Integer;
Begin
    Result := 0;
    If (regexpbeg = Nil) Or (regparse = Nil)
    Then
        EXIT; // not in compiling mode ?
    Result := regparse - regexpbeg;
End; { of function TRegExpr.GetCompilerErrorPos
--------------------------------------------------------------}


{=============================================================}
{===================== Matching section ======================}
{=============================================================}

{$IFNDEF UseSetOfChar}
function TRegExpr.StrScanCI (s : PRegExprChar; ch : REChar) : PRegExprChar; //###0.928 - now method of TRegExpr
 begin
  while (s^ <> #0) and (s^ <> ch) and (s^ <> InvertCase (ch))
   do inc (s);
  if s^ <> #0
   then Result := s
   else Result := nil;
 end; { of function TRegExpr.StrScanCI
--------------------------------------------------------------}
{$ENDIF}

Function TRegExpr.regrepeat(p: PRegExprChar; AMax: Integer): Integer;
// repeatedly match something simple, report how many
Var
    scan: PRegExprChar;
    opnd: PRegExprChar;
    TheMax: Integer;
  {Ch,} InvCh: REChar; //###0.931
    sestart, seend: PRegExprChar; //###0.936
Begin
    Result := 0;
    scan := reginput;
    opnd := p + REOpSz + RENextOffSz; //OPERAND
    TheMax := fInputEnd - scan;
    If TheMax > AMax
    Then
        TheMax := AMax;
    Case PREOp(p)^ Of
        ANY:
        Begin
    // note - ANYML cannot be proceeded in regrepeat because can skip
    // more than one char at once
            Result := TheMax;
            inc(scan, Result);
        End;
        EXACTLY:
        Begin // in opnd can be only ONE char !!!
//      Ch := opnd^; // store in register //###0.931
            While (Result < TheMax) And (opnd^ = scan^) Do
            Begin
                inc(Result);
                inc(scan);
            End;
        End;
        EXACTLYCI:
        Begin // in opnd can be only ONE char !!!
//      Ch := opnd^; // store in register //###0.931
            While (Result < TheMax) And (opnd^ = scan^) Do
            Begin // prevent unneeded InvertCase //###0.931
                inc(Result);
                inc(scan);
            End;
            If Result < TheMax Then
            Begin //###0.931
                InvCh := InvertCase(opnd^); // store in register
                While (Result < TheMax) And
                    ((opnd^ = scan^) Or (InvCh = scan^)) Do
                Begin
                    inc(Result);
                    inc(scan);
                End;
            End;
        End;
        BSUBEXP:
        Begin //###0.936
            sestart := startp[ord(opnd^)];
            If sestart = Nil
            Then
                EXIT;
            seend := endp[ord(opnd^)];
            If seend = Nil
            Then
                EXIT;
            Repeat
                opnd := sestart;
                While opnd < seend Do
                Begin
                    If (scan >= fInputEnd) Or (scan^ <> opnd^)
                    Then
                        EXIT;
                    inc(scan);
                    inc(opnd);
                End;
                inc(Result);
                reginput := scan;
            Until Result >= AMax;
        End;
        BSUBEXPCI:
        Begin //###0.936
            sestart := startp[ord(opnd^)];
            If sestart = Nil
            Then
                EXIT;
            seend := endp[ord(opnd^)];
            If seend = Nil
            Then
                EXIT;
            Repeat
                opnd := sestart;
                While opnd < seend Do
                Begin
                    If (scan >= fInputEnd) Or
                        ((scan^ <> opnd^) And (scan^ <> InvertCase(opnd^)))
                    Then
                        EXIT;
                    inc(scan);
                    inc(opnd);
                End;
                inc(Result);
                reginput := scan;
            Until Result >= AMax;
        End;
        ANYDIGIT:
            While (Result < TheMax) And
                (scan^ >= '0') And (scan^ <= '9') Do
            Begin
                inc(Result);
                inc(scan);
            End;
        NOTDIGIT:
            While (Result < TheMax) And
                ((scan^ < '0') Or (scan^ > '9')) Do
            Begin
                inc(Result);
                inc(scan);
            End;
    {$IFNDEF UseSetOfChar} //###0.929
    ANYLETTER:
      while (Result < TheMax) and
       (Pos (scan^, fWordChars) > 0) //###0.940
     {  ((scan^ >= 'a') and (scan^ <= 'z') !! I've forgotten (>='0') and (<='9')
       or (scan^ >= 'A') and (scan^ <= 'Z') or (scan^ = '_'))} do begin
        inc (Result);
        inc (scan);
       end;
    NOTLETTER:
      while (Result < TheMax) and
       (Pos (scan^, fWordChars) <= 0)  //###0.940
     {   not ((scan^ >= 'a') and (scan^ <= 'z') !! I've forgotten (>='0') and (<='9')
         or (scan^ >= 'A') and (scan^ <= 'Z')
         or (scan^ = '_'))} do begin
        inc (Result);
        inc (scan);
       end;
    ANYSPACE:
      while (Result < TheMax) and
         (Pos (scan^, fSpaceChars) > 0) do begin
        inc (Result);
        inc (scan);
       end;
    NOTSPACE:
      while (Result < TheMax) and
         (Pos (scan^, fSpaceChars) <= 0) do begin
        inc (Result);
        inc (scan);
       end;
    {$ENDIF}
        ANYOFTINYSET:
        Begin
            While (Result < TheMax) And //!!!TinySet
                ((scan^ = opnd^) Or (scan^ = (opnd + 1)^)
                    Or (scan^ = (opnd + 2)^)) Do
            Begin
                inc(Result);
                inc(scan);
            End;
        End;
        ANYBUTTINYSET:
        Begin
            While (Result < TheMax) And //!!!TinySet
                (scan^ <> opnd^) And (scan^ <> (opnd + 1)^)
                And (scan^ <> (opnd + 2)^) Do
            Begin
                inc(Result);
                inc(scan);
            End;
        End;
    {$IFDEF UseSetOfChar} //###0.929
        ANYOFFULLSET:
        Begin
            While (Result < TheMax) And
                (scan^ In PSetOfREChar(opnd)^) Do
            Begin
                inc(Result);
                inc(scan);
            End;
        End;
    {$ELSE}
    ANYOF:
      while (Result < TheMax) and
         (StrScan (opnd, scan^) <> nil) do begin
        inc (Result);
        inc (scan);
       end;
    ANYBUT:
      while (Result < TheMax) and
         (StrScan (opnd, scan^) = nil) do begin
        inc (Result);
        inc (scan);
       end;
    ANYOFCI:
      while (Result < TheMax) and (StrScanCI (opnd, scan^) <> nil) do begin
        inc (Result);
        inc (scan);
       end;
    ANYBUTCI:
      while (Result < TheMax) and (StrScanCI (opnd, scan^) = nil) do begin
        inc (Result);
        inc (scan);
       end;
    {$ENDIF}
    Else
    Begin // Oh dear. Called inappropriately.
        Result := 0; // Best compromise.
        Error(reeRegRepeatCalledInappropriately);
        EXIT;
    End;
    End; { of case}
    reginput := scan;
End; { of function TRegExpr.regrepeat
--------------------------------------------------------------}

Function TRegExpr.regnext(p: PRegExprChar): PRegExprChar;
// dig the "next" pointer out of a node
Var offset: TRENextOff;
Begin
    If p = @regdummy Then
    Begin
        Result := Nil;
        EXIT;
    End;
    offset := PRENextOff(p + REOpSz)^; //###0.933 inlined NEXT
    If offset = 0
    Then
        Result := Nil
    Else Result := p + offset;
End; { of function TRegExpr.regnext
--------------------------------------------------------------}

Function TRegExpr.MatchPrim(prog: PRegExprChar): Boolean;
// recursively matching routine
// Conceptually the strategy is simple:  check to see whether the current
// node matches, call self recursively to see whether the rest matches,
// and then act accordingly.  In practice we make some effort to avoid
// recursion, in particular by going through "ordinary" nodes (that don't
// need to know whether the rest of the match failed) by a loop instead of
// by recursion.
Var
    scan: PRegExprChar; // Current node.
    next: PRegExprChar; // Next node.
    len: Integer;
    opnd: PRegExprChar;
    no: Integer;
    save: PRegExprChar;
    nextch: REChar;
    BracesMin, BracesMax: Integer; // we use integer instead of TREBracesArg for better support */+
  {$IFDEF ComplexBraces}
    SavedLoopStack: Array [1 .. LoopStackMax] Of Integer; // :(( very bad for recursion
    SavedLoopStackIdx: Integer; //###0.925
  {$ENDIF}
Begin
    Result := False;
    scan := prog;

    While scan <> Nil Do
    Begin
        len := PRENextOff(scan + 1)^; //###0.932 inlined regnext
        If len = 0
        Then
            next := Nil
        Else next := scan + len;

        Case scan^ Of
            NOTBOUND, //###0.943 //!!! think about UseSetOfChar !!!
            BOUND:
                If (scan^ = BOUND)
                    Xor (
                    ((reginput = fInputStart) Or (Pos((reginput - 1)^, fWordChars) <= 0))
                    And (reginput^ <> #0) And (Pos(reginput^, fWordChars) > 0)
                    Or
                    (reginput <> fInputStart) And (Pos((reginput - 1)^, fWordChars) > 0)
                    And ((reginput^ = #0) Or (Pos(reginput^, fWordChars) <= 0)))
                Then
                    EXIT;

            BOL:
                If reginput <> fInputStart
                Then
                    EXIT;
            EOL:
                If reginput^ <> #0
                Then
                    EXIT;
            BOLML:
                If reginput > fInputStart Then
                Begin
                    nextch := (reginput - 1)^;
                    If (nextch <> fLinePairedSeparatorTail)
                        Or ((reginput - 1) <= fInputStart)
                        Or ((reginput - 2)^ <> fLinePairedSeparatorHead)
                    Then
                    Begin
                        If (nextch = fLinePairedSeparatorHead)
                            And (reginput^ = fLinePairedSeparatorTail)
                        Then
                            EXIT; // don't stop between paired separator
                        If
                 {$IFNDEF UniCode}
                        Not (nextch In fLineSeparatorsSet)
                 {$ELSE}
                 (pos (nextch, fLineSeparators) <= 0)
                 {$ENDIF}
                        Then
                            EXIT;
                    End;
                End;
            EOLML:
                If reginput^ <> #0 Then
                Begin
                    nextch := reginput^;
                    If (nextch <> fLinePairedSeparatorHead)
                        Or ((reginput + 1)^ <> fLinePairedSeparatorTail)
                    Then
                    Begin
                        If (nextch = fLinePairedSeparatorTail)
                            And (reginput > fInputStart)
                            And ((reginput - 1)^ = fLinePairedSeparatorHead)
                        Then
                            EXIT; // don't stop between paired separator
                        If
                 {$IFNDEF UniCode}
                        Not (nextch In fLineSeparatorsSet)
                 {$ELSE}
                 (pos (nextch, fLineSeparators) <= 0)
                 {$ENDIF}
                        Then
                            EXIT;
                    End;
                End;
            ANY:
            Begin
                If reginput^ = #0
                Then
                    EXIT;
                inc(reginput);
            End;
            ANYML:
            Begin //###0.941
                If (reginput^ = #0)
                    Or ((reginput^ = fLinePairedSeparatorHead)
                    And ((reginput + 1)^ = fLinePairedSeparatorTail))
                    Or {$IFNDEF UniCode} (reginput^ In fLineSeparatorsSet)
                {$ELSE} (pos (reginput^, fLineSeparators) > 0) {$ENDIF}
                Then
                    EXIT;
                inc(reginput);
            End;
            ANYDIGIT:
            Begin
                If (reginput^ = #0) Or (reginput^ < '0') Or (reginput^ > '9')
                Then
                    EXIT;
                inc(reginput);
            End;
            NOTDIGIT:
            Begin
                If (reginput^ = #0) Or ((reginput^ >= '0') And (reginput^ <= '9'))
                Then
                    EXIT;
                inc(reginput);
            End;
         {$IFNDEF UseSetOfChar} //###0.929
         ANYLETTER: begin
            if (reginput^ = #0) or (Pos (reginput^, fWordChars) <= 0) //###0.943
             then EXIT;
            inc (reginput);
           end;
         NOTLETTER: begin
            if (reginput^ = #0) or (Pos (reginput^, fWordChars) > 0) //###0.943
             then EXIT;
            inc (reginput);
           end;
         ANYSPACE: begin
            if (reginput^ = #0) or not (Pos (reginput^, fSpaceChars) > 0) //###0.943
             then EXIT;
            inc (reginput);
           end;
         NOTSPACE: begin
            if (reginput^ = #0) or (Pos (reginput^, fSpaceChars) > 0) //###0.943
             then EXIT;
            inc (reginput);
           end;
         {$ENDIF}
            EXACTLYCI:
            Begin
                opnd := scan + REOpSz + RENextOffSz; // OPERAND
            // Inline the first character, for speed.
                If (opnd^ <> reginput^)
                    And (InvertCase(opnd^) <> reginput^)
                Then
                    EXIT;
                len := strlen(opnd);
            //###0.929 begin
                no := len;
                save := reginput;
                While no > 1 Do
                Begin
                    inc(save);
                    inc(opnd);
                    If (opnd^ <> save^)
                        And (InvertCase(opnd^) <> save^)
                    Then
                        EXIT;
                    dec(no);
                End;
            //###0.929 end
                inc(reginput, len);
            End;
            EXACTLY:
            Begin
                opnd := scan + REOpSz + RENextOffSz; // OPERAND
            // Inline the first character, for speed.
                If opnd^ <> reginput^
                Then
                    EXIT;
                len := strlen(opnd);
            //###0.929 begin
                no := len;
                save := reginput;
                While no > 1 Do
                Begin
                    inc(save);
                    inc(opnd);
                    If opnd^ <> save^
                    Then
                        EXIT;
                    dec(no);
                End;
            //###0.929 end
                inc(reginput, len);
            End;
            BSUBEXP:
            Begin //###0.936
                no := ord((scan + REOpSz + RENextOffSz)^);
                If startp[no] = Nil
                Then
                    EXIT;
                If endp[no] = Nil
                Then
                    EXIT;
                save := reginput;
                opnd := startp[no];
                While opnd < endp[no] Do
                Begin
                    If (save >= fInputEnd) Or (save^ <> opnd^)
                    Then
                        EXIT;
                    inc(save);
                    inc(opnd);
                End;
                reginput := save;
            End;
            BSUBEXPCI:
            Begin //###0.936
                no := ord((scan + REOpSz + RENextOffSz)^);
                If startp[no] = Nil
                Then
                    EXIT;
                If endp[no] = Nil
                Then
                    EXIT;
                save := reginput;
                opnd := startp[no];
                While opnd < endp[no] Do
                Begin
                    If (save >= fInputEnd) Or
                        ((save^ <> opnd^) And (save^ <> InvertCase(opnd^)))
                    Then
                        EXIT;
                    inc(save);
                    inc(opnd);
                End;
                reginput := save;
            End;
            ANYOFTINYSET:
            Begin
                If (reginput^ = #0) Or //!!!TinySet
                    ((reginput^ <> (scan + REOpSz + RENextOffSz)^)
                    And (reginput^ <> (scan + REOpSz + RENextOffSz + 1)^)
                    And (reginput^ <> (scan + REOpSz + RENextOffSz + 2)^))
                Then
                    EXIT;
                inc(reginput);
            End;
            ANYBUTTINYSET:
            Begin
                If (reginput^ = #0) Or //!!!TinySet
                    (reginput^ = (scan + REOpSz + RENextOffSz)^)
                    Or (reginput^ = (scan + REOpSz + RENextOffSz + 1)^)
                    Or (reginput^ = (scan + REOpSz + RENextOffSz + 2)^)
                Then
                    EXIT;
                inc(reginput);
            End;
         {$IFDEF UseSetOfChar} //###0.929
            ANYOFFULLSET:
            Begin
                If (reginput^ = #0)
                    Or Not (reginput^ In PSetOfREChar(scan + REOpSz + RENextOffSz)^)
                Then
                    EXIT;
                inc(reginput);
            End;
         {$ELSE}
         ANYOF: begin
            if (reginput^ = #0) or (StrScan (scan + REOpSz + RENextOffSz, reginput^) = nil)
             then EXIT;
            inc (reginput);
           end;
         ANYBUT: begin
            if (reginput^ = #0) or (StrScan (scan + REOpSz + RENextOffSz, reginput^) <> nil)
             then EXIT;
            inc (reginput);
           end;
         ANYOFCI: begin
            if (reginput^ = #0) or (StrScanCI (scan + REOpSz + RENextOffSz, reginput^) = nil)
             then EXIT;
            inc (reginput);
           end;
         ANYBUTCI: begin
            if (reginput^ = #0) or (StrScanCI (scan + REOpSz + RENextOffSz, reginput^) <> nil)
             then EXIT;
            inc (reginput);
           end;
         {$ENDIF}
            NOTHING: ;
            COMMENT: ;
            BACK: ;
            Succ(OPEN) .. TREOp(Ord(OPEN) + NSUBEXP - 1):
            Begin //###0.929
                no := ord(scan^) - ord(OPEN);
//            save := reginput;
                save := startp[no]; //###0.936
                startp[no] := reginput; //###0.936
                Result := MatchPrim(next);
                If Not Result //###0.936
                Then
                    startp[no] := save;
//            if Result and (startp [no] = nil)
//             then startp [no] := save;
             // Don't set startp if some later invocation of the same
             // parentheses already has.
                EXIT;
            End;
            Succ(CLOSE) .. TREOp(Ord(CLOSE) + NSUBEXP - 1):
            Begin //###0.929
                no := ord(scan^) - ord(CLOSE);
//            save := reginput;
                save := endp[no]; //###0.936
                endp[no] := reginput; //###0.936
                Result := MatchPrim(next);
                If Not Result //###0.936
                Then
                    endp[no] := save;
//            if Result and (endp [no] = nil)
//             then endp [no] := save;
             // Don't set endp if some later invocation of the same
             // parentheses already has.
                EXIT;
            End;
            BRANCH:
            Begin
                If (next^ <> BRANCH) // No choice.
                Then
                    next := scan + REOpSz + RENextOffSz // Avoid recursion
                Else
                Begin
                    Repeat
                        save := reginput;
                        Result := MatchPrim(scan + REOpSz + RENextOffSz);
                        If Result
                        Then
                            EXIT;
                        reginput := save;
                        scan := regnext(scan);
                    Until (scan = Nil) Or (scan^ <> BRANCH);
                    EXIT;
                End;
            End;
         {$IFDEF ComplexBraces}
            LOOPENTRY:
            Begin //###0.925
                no := LoopStackIdx;
                inc(LoopStackIdx);
                If LoopStackIdx > LoopStackMax Then
                Begin
                    Error(reeLoopStackExceeded);
                    EXIT;
                End;
                save := reginput;
                LoopStack[LoopStackIdx] := 0; // init loop counter
                Result := MatchPrim(next); // execute LOOP
                LoopStackIdx := no; // cleanup
                If Result
                Then
                    EXIT;
                reginput := save;
                EXIT;
            End;
            LOOP, LOOPNG:
            Begin //###0.940
                If LoopStackIdx <= 0 Then
                Begin
                    Error(reeLoopWithoutEntry);
                    EXIT;
                End;
                opnd := scan + PRENextOff(scan + REOpSz + RENextOffSz + 2 * REBracesArgSz)^;
                BracesMin := PREBracesArg(scan + REOpSz + RENextOffSz)^;
                BracesMax := PREBracesArg(scan + REOpSz + RENextOffSz + REBracesArgSz)^;
                save := reginput;
                If LoopStack[LoopStackIdx] >= BracesMin Then
                Begin // Min alredy matched - we can work
                    If scan^ = LOOP Then
                    Begin
                 // greedy way - first try to max deep of greed ;)
                        If LoopStack[LoopStackIdx] < BracesMax Then
                        Begin
                            inc(LoopStack[LoopStackIdx]);
                            no := LoopStackIdx;
                            Result := MatchPrim(opnd);
                            LoopStackIdx := no;
                            If Result
                            Then
                                EXIT;
                            reginput := save;
                        End;
                        dec(LoopStackIdx); // Fail. May be we are too greedy? ;)
                        Result := MatchPrim(next);
                        If Not Result
                        Then
                            reginput := save;
                        EXIT;
                    End
                    Else
                    Begin
                 // non-greedy - try just now
                        Result := MatchPrim(next);
                        If Result
                        Then
                            EXIT
                        Else reginput := save; // failed - move next and try again
                        If LoopStack[LoopStackIdx] < BracesMax Then
                        Begin
                            inc(LoopStack[LoopStackIdx]);
                            no := LoopStackIdx;
                            Result := MatchPrim(opnd);
                            LoopStackIdx := no;
                            If Result
                            Then
                                EXIT;
                            reginput := save;
                        End;
                        dec(LoopStackIdx); // Failed - back up
                        EXIT;
                    End;
                End
                Else
                Begin // first match a min_cnt times
                    inc(LoopStack[LoopStackIdx]);
                    no := LoopStackIdx;
                    Result := MatchPrim(opnd);
                    LoopStackIdx := no;
                    If Result
                    Then
                        EXIT;
                    dec(LoopStack[LoopStackIdx]);
                    reginput := save;
                    EXIT;
                End;
            End;
         {$ENDIF}
            STAR, PLUS, BRACES, STARNG, PLUSNG, BRACESNG:
            Begin
           // Lookahead to avoid useless match attempts when we know
           // what character comes next.
                nextch := #0;
                If next^ = EXACTLY
                Then
                    nextch := (next + REOpSz + RENextOffSz)^;
                BracesMax := MaxInt; // infinite loop for * and + //###0.92
                If (scan^ = STAR) Or (scan^ = STARNG)
                Then
                    BracesMin := 0  // STAR
                Else
                If (scan^ = PLUS) Or (scan^ = PLUSNG)
                Then
                    BracesMin := 1 // PLUS
                Else
                Begin // BRACES
                    BracesMin := PREBracesArg(scan + REOpSz + RENextOffSz)^;
                    BracesMax := PREBracesArg(scan + REOpSz + RENextOffSz + REBracesArgSz)^;
                End;
                save := reginput;
                opnd := scan + REOpSz + RENextOffSz;
                If (scan^ = BRACES) Or (scan^ = BRACESNG)
                Then
                    inc(opnd, 2 * REBracesArgSz);

                If (scan^ = PLUSNG) Or (scan^ = STARNG) Or (scan^ = BRACESNG) Then
                Begin
             // non-greedy mode
                    BracesMax := regrepeat(opnd, BracesMax); // don't repeat more than BracesMax
              // Now we know real Max limit to move forward (for recursion 'back up')
              // In some cases it can be faster to check only Min positions first,
              // but after that we have to check every position separtely instead
              // of fast scannig in loop.
                    no := BracesMin;
                    While no <= BracesMax Do
                    Begin
                        reginput := save + no;
                // If it could work, try it.
                        If (nextch = #0) Or (reginput^ = nextch) Then
                        Begin
                  {$IFDEF ComplexBraces}
                            System.Move(LoopStack, SavedLoopStack, SizeOf(LoopStack)); //###0.925
                            SavedLoopStackIdx := LoopStackIdx;
                  {$ENDIF}
                            If MatchPrim(next) Then
                            Begin
                                Result := True;
                                EXIT;
                            End;
                  {$IFDEF ComplexBraces}
                            System.Move(SavedLoopStack, LoopStack, SizeOf(LoopStack));
                            LoopStackIdx := SavedLoopStackIdx;
                  {$ENDIF}
                        End;
                        inc(no); // Couldn't or didn't - move forward.
                    End; { of while}
                    EXIT;
                End
                Else
                Begin // greedy mode
                    no := regrepeat(opnd, BracesMax); // don't repeat more than max_cnt
                    While no >= BracesMin Do
                    Begin
                // If it could work, try it.
                        If (nextch = #0) Or (reginput^ = nextch) Then
                        Begin
                  {$IFDEF ComplexBraces}
                            System.Move(LoopStack, SavedLoopStack, SizeOf(LoopStack)); //###0.925
                            SavedLoopStackIdx := LoopStackIdx;
                  {$ENDIF}
                            If MatchPrim(next) Then
                            Begin
                                Result := True;
                                EXIT;
                            End;
                  {$IFDEF ComplexBraces}
                            System.Move(SavedLoopStack, LoopStack, SizeOf(LoopStack));
                            LoopStackIdx := SavedLoopStackIdx;
                  {$ENDIF}
                        End;
                        dec(no); // Couldn't or didn't - back up.
                        reginput := save + no;
                    End; { of while}
                    EXIT;
                End;
            End;
            EEND:
            Begin
                Result := True;  // Success!
                EXIT;
            End;
        Else
        Begin
            Error(reeMatchPrimMemoryCorruption);
            EXIT;
        End;
        End; { of case scan^}
        scan := next;
    End; { of while scan <> nil}

  // We get here only if there's trouble -- normally "case EEND" is the
  // terminating point.
    Error(reeMatchPrimCorruptedPointers);
End; { of function TRegExpr.MatchPrim
--------------------------------------------------------------}

{$IFDEF UseFirstCharSet} //###0.929
Procedure TRegExpr.FillFirstCharSet(prog: PRegExprChar);
Var
    scan: PRegExprChar; // Current node.
    next: PRegExprChar; // Next node.
    opnd: PRegExprChar;
    min_cnt: Integer;
Begin
    scan := prog;
    While scan <> Nil Do
    Begin
        next := regnext(scan);
        Case PREOp(scan)^ Of
            BSUBEXP, BSUBEXPCI:
            Begin //###0.938
                FirstCharSet := [#0 .. #255]; // :((( we cannot
           // optimize r.e. if it starts with back reference
                EXIT;
            End;
            BOL, BOLML: ; // EXIT; //###0.937
            EOL, EOLML:
            Begin //###0.948 was empty in 0.947, was EXIT in 0.937
                Include(FirstCharSet, #0);
                If ModifierM
                Then
                Begin
                    opnd := PRegExprChar(LineSeparators);
                    While opnd^ <> #0 Do
                    Begin
                        Include(FirstCharSet, opnd^);
                        inc(opnd);
                    End;
                End;
                EXIT;
            End;
            BOUND, NOTBOUND: ; //###0.943 ?!!
            ANY, ANYML:
            Begin // we can better define ANYML !!!
                FirstCharSet := [#0 .. #255]; //###0.930
                EXIT;
            End;
            ANYDIGIT:
            Begin
                FirstCharSet := FirstCharSet + ['0' .. '9'];
                EXIT;
            End;
            NOTDIGIT:
            Begin
                FirstCharSet := FirstCharSet + ([#0 .. #255] - ['0' .. '9']); //###0.948 FirstCharSet was forgotten
                EXIT;
            End;
            EXACTLYCI:
            Begin
                Include(FirstCharSet, (scan + REOpSz + RENextOffSz)^);
                Include(FirstCharSet, InvertCase((scan + REOpSz + RENextOffSz)^));
                EXIT;
            End;
            EXACTLY:
            Begin
                Include(FirstCharSet, (scan + REOpSz + RENextOffSz)^);
                EXIT;
            End;
            ANYOFFULLSET:
            Begin
                FirstCharSet := FirstCharSet + PSetOfREChar(scan + REOpSz + RENextOffSz)^;
                EXIT;
            End;
            ANYOFTINYSET:
            Begin
           //!!!TinySet
                Include(FirstCharSet, (scan + REOpSz + RENextOffSz)^);
                Include(FirstCharSet, (scan + REOpSz + RENextOffSz + 1)^);
                Include(FirstCharSet, (scan + REOpSz + RENextOffSz + 2)^);
           // ...                                                      // up to TinySetLen
                EXIT;
            End;
            ANYBUTTINYSET:
            Begin
           //!!!TinySet
                FirstCharSet := FirstCharSet + ([#0 .. #255] - [ //###0.948 FirstCharSet was forgotten
                    (scan + REOpSz + RENextOffSz)^,
                    (scan + REOpSz + RENextOffSz + 1)^,
                    (scan + REOpSz + RENextOffSz + 2)^]);
           // ...                                                      // up to TinySetLen
                EXIT;
            End;
            NOTHING: ;
            COMMENT: ;
            BACK: ;
            Succ(OPEN) .. TREOp(Ord(OPEN) + NSUBEXP - 1):
            Begin //###0.929
                FillFirstCharSet(next);
                EXIT;
            End;
            Succ(CLOSE) .. TREOp(Ord(CLOSE) + NSUBEXP - 1):
            Begin //###0.929
                FillFirstCharSet(next);
                EXIT;
            End;
            BRANCH:
            Begin
                If (PREOp(next)^ <> BRANCH) // No choice.
                Then
                    next := scan + REOpSz + RENextOffSz // Avoid recursion.
                Else
                Begin
                    Repeat
                        FillFirstCharSet(scan + REOpSz + RENextOffSz);
                        scan := regnext(scan);
                    Until (scan = Nil) Or (PREOp(scan)^ <> BRANCH);
                    EXIT;
                End;
            End;
         {$IFDEF ComplexBraces}
            LOOPENTRY:
            Begin //###0.925
//           LoopStack [LoopStackIdx] := 0; //###0.940 line removed
                FillFirstCharSet(next); // execute LOOP
                EXIT;
            End;
            LOOP, LOOPNG:
            Begin //###0.940
                opnd := scan + PRENextOff(scan + REOpSz + RENextOffSz + REBracesArgSz * 2)^;
                min_cnt := PREBracesArg(scan + REOpSz + RENextOffSz)^;
                FillFirstCharSet(opnd);
                If min_cnt = 0
                Then
                    FillFirstCharSet(next);
                EXIT;
            End;
         {$ENDIF}
            STAR, STARNG: //###0.940
                FillFirstCharSet(scan + REOpSz + RENextOffSz);
            PLUS, PLUSNG:
            Begin //###0.940
                FillFirstCharSet(scan + REOpSz + RENextOffSz);
                EXIT;
            End;
            BRACES, BRACESNG:
            Begin //###0.940
                opnd := scan + REOpSz + RENextOffSz + REBracesArgSz * 2;
                min_cnt := PREBracesArg(scan + REOpSz + RENextOffSz)^; // BRACES
                FillFirstCharSet(opnd);
                If min_cnt > 0
                Then
                    EXIT;
            End;
            EEND:
            Begin
                FirstCharSet := [#0 .. #255]; //###0.948
                EXIT;
            End;
        Else
        Begin
            Error(reeMatchPrimMemoryCorruption);
            EXIT;
        End;
        End; { of case scan^}
        scan := next;
    End; { of while scan <> nil}
End; { of procedure FillFirstCharSet
--------------------------------------------------------------}
{$ENDIF}

Function TRegExpr.Exec(Const AInputString: RegExprString): Boolean;
Begin
    InputString := AInputString;
    Result := ExecPrim(1);
End; { of function TRegExpr.Exec
--------------------------------------------------------------}

Function TRegExpr.Exec(Const AInputString, Expression: RegExprString): Boolean;
Begin
    Self.Expression := Expression;
    Result := Exec(AInputString);
End;

{$IFDEF OverMeth}
{$IFNDEF FPC}
Function TRegExpr.Exec: Boolean;
Begin
    Result := ExecPrim(1);
End; { of function TRegExpr.Exec
--------------------------------------------------------------}
{$ENDIF}
Function TRegExpr.Exec(AOffset: Integer): Boolean;
Begin
    Result := ExecPrim(AOffset);
End; { of function TRegExpr.Exec
--------------------------------------------------------------}
{$ENDIF}

Function TRegExpr.ExecPos(AOffset: Integer {$IFDEF DefParam} = 1{$ENDIF}): Boolean;
Begin
    Result := ExecPrim(AOffset);
End; { of function TRegExpr.ExecPos
--------------------------------------------------------------}

Function TRegExpr.ExecPrim(AOffset: Integer): Boolean;
    Procedure ClearMatchs;
  // Clears matchs array
    Var i: Integer;
    Begin
        For i := 0 To NSUBEXP - 1 Do
        Begin
            startp[i] := Nil;
            endp[i] := Nil;
        End;
    End; { of procedure ClearMatchs;
..............................................................}
    Function RegMatch(str: PRegExprChar): Boolean;
  // try match at specific point
    Begin
   //###0.949 removed clearing of start\endp
        reginput := str;
        Result := MatchPrim(programm + REOpSz);
        If Result Then
        Begin
            startp[0] := str;
            endp[0] := reginput;
        End;
    End; { of function RegMatch
..............................................................}
Var
    s: PRegExprChar;
    StartPtr: PRegExprChar;
    InputLen: Integer;
Begin
    Result := False; // Be paranoid...

    ClearMatchs; //###0.949
  // ensure that Match cleared either if optimization tricks or some error
  // will lead to leaving ExecPrim without actual search. That is
  // importent for ExecNext logic and so on.

    If Not IsProgrammOk //###0.929
    Then
        EXIT;

  // Check InputString presence
    If Not Assigned(fInputString) Then
    Begin
        Error(reeNoInpitStringSpecified);
        EXIT;
    End;

    InputLen := length(fInputString);

  //Check that the start position is not negative
    If AOffset < 1 Then
    Begin
        Error(reeOffsetMustBeGreaterThen0);
        EXIT;
    End;
  // Check that the start position is not longer than the line
  // If so then exit with nothing found
    If AOffset > (InputLen + 1) // for matching empty string after last char.
    Then
        EXIT;

    StartPtr := fInputString + AOffset - 1;

  // If there is a "must appear" string, look for it.
    If regmust <> Nil Then
    Begin
        s := StartPtr;
        Repeat
            s := StrScan(s, regmust[0]);
            If s <> Nil Then
            Begin
                If StrLComp(s, regmust, regmlen) = 0
                Then
                    BREAK; // Found it.
                inc(s);
            End;
        Until s = Nil;
        If s = Nil // Not present.
        Then
            EXIT;
    End;

  // Mark beginning of line for ^ .
    fInputStart := fInputString;

  // Pointer to end of input stream - for
  // pascal-style string processing (may include #0)
    fInputEnd := fInputString + InputLen;

  {$IFDEF ComplexBraces}
  // no loops started
    LoopStackIdx := 0; //###0.925
  {$ENDIF}

  // Simplest case:  anchored match need be tried only once.
    If reganch <> #0 Then
    Begin
        Result := RegMatch(StartPtr);
        EXIT;
    End;

  // Messy cases:  unanchored match.
    s := StartPtr;
    If regstart <> #0 Then // We know what char it must start with.
        Repeat
            s := StrScan(s, regstart);
            If s <> Nil Then
            Begin
                Result := RegMatch(s);
                If Result
                Then
                    EXIT
                Else ClearMatchs; //###0.949
                inc(s);
            End;
        Until s = Nil
    Else
    Begin // We don't - general case.
        Repeat //###0.948
       {$IFDEF UseFirstCharSet}
            If s^ In FirstCharSet
            Then
                Result := RegMatch(s);
       {$ELSE}
       Result := RegMatch (s);
       {$ENDIF}
            If Result Or (s^ = #0) // Exit on a match or after testing the end-of-string.
            Then
                EXIT
            Else ClearMatchs; //###0.949
            inc(s);
        Until False;
(*  optimized and fixed by Martin Fuller - empty strings
    were not allowed to pass thru in UseFirstCharSet mode
     {$IFDEF UseFirstCharSet} //###0.929
     while s^ <> #0 do begin
       if s^ in FirstCharSet
        then Result := RegMatch (s);
       if Result
        then EXIT;
       inc (s);
      end;
     {$ELSE}
     REPEAT
      Result := RegMatch (s);
      if Result
       then EXIT;
      inc (s);
     UNTIL s^ = #0;
     {$ENDIF}
*)
    End;
  // Failure
End; { of function TRegExpr.ExecPrim
--------------------------------------------------------------}

Function TRegExpr.ExecNext: Boolean;
Var offset: Integer;
Begin
    Result := False;
    If Not Assigned(startp[0]) Or Not Assigned(endp[0]) Then
    Begin
        Error(reeExecNextWithoutExec);
        EXIT;
    End;
//  Offset := MatchPos [0] + MatchLen [0];
//  if MatchLen [0] = 0
    Offset := endp[0] - fInputString + 1; //###0.929
    If endp[0] = startp[0] //###0.929
    Then
        inc(Offset); // prevent infinite looping if empty string match r.e.
    Result := ExecPrim(Offset);
End; { of function TRegExpr.ExecNext
--------------------------------------------------------------}

Function TRegExpr.GetInputString: RegExprString;
Begin
    If Not Assigned(fInputString) Then
    Begin
        Error(reeGetInputStringWithoutInputString);
        EXIT;
    End;
    Result := fInputString;
End; { of function TRegExpr.GetInputString
--------------------------------------------------------------}

Procedure TRegExpr.SetInputString(Const AInputString: RegExprString);
Var
    Len: Integer;
    i: Integer;
Begin
  // clear Match* - before next Exec* call it's undefined
    For i := 0 To NSUBEXP - 1 Do
    Begin
        startp[i] := Nil;
        endp[i] := Nil;
    End;

  // need reallocation of input string buffer ?
    Len := length(AInputString);
    If Assigned(fInputString) And (Length(fInputString) <> Len) Then
    Begin
        FreeMem(fInputString);
        fInputString := Nil;
    End;
  // buffer [re]allocation
    If Not Assigned(fInputString)
    Then
        GetMem(fInputString, (Len + 1) * SizeOf(REChar));

  // copy input string into buffer
  {$IFDEF UniCode}
  StrPCopy (fInputString, Copy (AInputString, 1, Len)); //###0.927
  {$ELSE}
    StrLCopy(fInputString, PRegExprChar(AInputString), Len);
  {$ENDIF}

  {
  fInputString : string;
  fInputStart, fInputEnd : PRegExprChar;

  SetInputString:
  fInputString := AInputString;
  UniqueString (fInputString);
  fInputStart := PChar (fInputString);
  Len := length (fInputString);
  fInputEnd := PRegExprChar (integer (fInputStart) + Len); ??
  !! startp/endp âñå ðàâíî áóäåò îïàñíî èñïîëüçîâàòü ?
  }
End; { of procedure TRegExpr.SetInputString
--------------------------------------------------------------}

Procedure TRegExpr.SetLineSeparators(Const AStr: RegExprString);
Begin
    If AStr <> fLineSeparators Then
    Begin
        fLineSeparators := AStr;
        InvalidateProgramm;
    End;
End; { of procedure TRegExpr.SetLineSeparators
--------------------------------------------------------------}

Procedure TRegExpr.SetLinePairedSeparator(Const AStr: RegExprString);
Begin
    If length(AStr) = 2 Then
    Begin
        If AStr[1] = AStr[2] Then
        Begin
      // it's impossible for our 'one-point' checking to support
      // two chars separator for identical chars
            Error(reeBadLinePairedSeparator);
            EXIT;
        End;
        If Not fLinePairedSeparatorAssigned
            Or (AStr[1] <> fLinePairedSeparatorHead)
            Or (AStr[2] <> fLinePairedSeparatorTail) Then
        Begin
            fLinePairedSeparatorAssigned := True;
            fLinePairedSeparatorHead := AStr[1];
            fLinePairedSeparatorTail := AStr[2];
            InvalidateProgramm;
        End;
    End
    Else
    If length(AStr) = 0 Then
    Begin
        If fLinePairedSeparatorAssigned Then
        Begin
            fLinePairedSeparatorAssigned := False;
            InvalidateProgramm;
        End;
    End
    Else Error(reeBadLinePairedSeparator);
End; { of procedure TRegExpr.SetLinePairedSeparator
--------------------------------------------------------------}

Function TRegExpr.GetLinePairedSeparator: RegExprString;
Begin
    If fLinePairedSeparatorAssigned Then
    Begin
     {$IFDEF UniCode}
     // Here is some UniCode 'magic'
     // If You do know better decision to concatenate
     // two WideChars, please, let me know!
     Result := fLinePairedSeparatorHead; //###0.947
     Result := Result + fLinePairedSeparatorTail;
     {$ELSE}
        Result := fLinePairedSeparatorHead + fLinePairedSeparatorTail;
     {$ENDIF}
    End
    Else Result := '';
End; { of function TRegExpr.GetLinePairedSeparator
--------------------------------------------------------------}

Function TRegExpr.Substitute(Const ATemplate: RegExprString): RegExprString;
// perform substitutions after a regexp match
// completely rewritten in 0.929
Var
    TemplateLen: Integer;
    TemplateBeg, TemplateEnd: PRegExprChar;
    p, p0, ResultPtr: PRegExprChar;
    ResultLen: Integer;
    n: Integer;
    Ch: REChar;
    Function ParseVarName(Var APtr: PRegExprChar): Integer;
  // extract name of variable (digits, may be enclosed with
  // curly braces) from APtr^, uses TemplateEnd !!!
    Const
        Digits = ['0' .. '9'];
    Var
        p: PRegExprChar;
        Delimited: Boolean;
    Begin
        Result := 0;
        p := APtr;
        Delimited := (p < TemplateEnd) And (p^ = '{');
        If Delimited
        Then
            inc(p); // skip left curly brace
        If (p < TemplateEnd) And (p^ = '&')
        Then
            inc(p) // this is '$&' or '${&}'
        Else
            While (p < TemplateEnd) And
      {$IFDEF UniCode} //###0.935
      (ord (p^) < 256) and (char (p^) in Digits)
      {$ELSE}
                (p^ In Digits)
      {$ENDIF}
                Do
            Begin
                Result := Result * 10 + (ord(p^) - ord('0')); //###0.939
                inc(p);
            End;
        If Delimited Then
            If (p < TemplateEnd) And (p^ = '}')
            Then
                inc(p) // skip right curly brace
            Else p := APtr; // isn't properly terminated
        If p = APtr
        Then
            Result := -1; // no valid digits found or no right curly brace
        APtr := p;
    End;
Begin
  // Check programm and input string
    If Not IsProgrammOk
    Then
        EXIT;
    If Not Assigned(fInputString) Then
    Begin
        Error(reeNoInpitStringSpecified);
        EXIT;
    End;
  // Prepare for working
    TemplateLen := length(ATemplate);
    If TemplateLen = 0 Then
    Begin // prevent nil pointers
        Result := '';
        EXIT;
    End;
    TemplateBeg := pointer(ATemplate);
    TemplateEnd := TemplateBeg + TemplateLen;
  // Count result length for speed optimization.
    ResultLen := 0;
    p := TemplateBeg;
    While p < TemplateEnd Do
    Begin
        Ch := p^;
        inc(p);
        If Ch = '$'
        Then
            n := ParseVarName(p)
        Else n := -1;
        If n >= 0 Then
        Begin
            If (n < NSUBEXP) And Assigned(startp[n]) And Assigned(endp[n])
            Then
                inc(ResultLen, endp[n] - startp[n]);
        End
        Else
        Begin
            If (Ch = EscChar) And (p < TemplateEnd)
            Then
                inc(p); // quoted or special char followed
            inc(ResultLen);
        End;
    End;
  // Get memory. We do it once and it significant speed up work !
    If ResultLen = 0 Then
    Begin
        Result := '';
        EXIT;
    End;
    SetString(Result, Nil, ResultLen);
  // Fill Result
    ResultPtr := pointer(Result);
    p := TemplateBeg;
    While p < TemplateEnd Do
    Begin
        Ch := p^;
        inc(p);
        If Ch = '$'
        Then
            n := ParseVarName(p)
        Else n := -1;
        If n >= 0 Then
        Begin
            p0 := startp[n];
            If (n < NSUBEXP) And Assigned(p0) And Assigned(endp[n]) Then
                While p0 < endp[n] Do
                Begin
                    ResultPtr^ := p0^;
                    inc(ResultPtr);
                    inc(p0);
                End;
        End
        Else
        Begin
            If (Ch = EscChar) And (p < TemplateEnd) Then
            Begin // quoted or special char followed
                Ch := p^;
                inc(p);
            End;
            ResultPtr^ := Ch;
            inc(ResultPtr);
        End;
    End;
End; { of function TRegExpr.Substitute
--------------------------------------------------------------}

Procedure TRegExpr.Split(AInputStr: RegExprString; APieces: TStrings);
Var PrevPos: Integer;
Begin
    PrevPos := 1;
    If Exec(AInputStr) Then
        Repeat
            APieces.Add(System.Copy(AInputStr, PrevPos, MatchPos[0] - PrevPos));
            PrevPos := MatchPos[0] + MatchLen[0];
        Until Not ExecNext;
    APieces.Add(System.Copy(AInputStr, PrevPos, MaxInt)); // Tail
End; { of procedure TRegExpr.Split
--------------------------------------------------------------}

Function TRegExpr.Replace(AInputStr: RegExprString; Const AReplaceStr: RegExprString;
    AUseSubstitution: Boolean{$IFDEF DefParam} = False{$ENDIF}): RegExprString;
Var
    PrevPos: Integer;
Begin
    Result := '';
    PrevPos := 1;
    If Exec(AInputStr) Then
        Repeat
            Result := Result + System.Copy(AInputStr, PrevPos,
                MatchPos[0] - PrevPos);
            If AUseSubstitution //###0.946
            Then
                Result := Result + Substitute(AReplaceStr)
            Else Result := Result + AReplaceStr;
            PrevPos := MatchPos[0] + MatchLen[0];
        Until Not ExecNext;
    Result := Result + System.Copy(AInputStr, PrevPos, MaxInt); // Tail
End; { of function TRegExpr.Replace
--------------------------------------------------------------}

Function TRegExpr.ReplaceEx(AInputStr: RegExprString;
    AReplaceFunc: TRegExprReplaceFunction)
: RegExprString;
Var
    PrevPos: Integer;
Begin
    Result := '';
    PrevPos := 1;
    If Exec(AInputStr) Then
        Repeat
            Result := Result + System.Copy(AInputStr, PrevPos,
                MatchPos[0] - PrevPos)
                + AReplaceFunc(Self);
            PrevPos := MatchPos[0] + MatchLen[0];
        Until Not ExecNext;
    Result := Result + System.Copy(AInputStr, PrevPos, MaxInt); // Tail
End; { of function TRegExpr.ReplaceEx
--------------------------------------------------------------}


{$IFDEF OverMeth}
Function TRegExpr.Replace(AInputStr: RegExprString;
    AReplaceFunc: TRegExprReplaceFunction)
: RegExprString;
Begin
    ReplaceEx(AInputStr, AReplaceFunc);
End; { of function TRegExpr.Replace
--------------------------------------------------------------}
{$ENDIF}

{=============================================================}
{====================== Debug section ========================}
{=============================================================}

{$IFDEF RegExpPCodeDump}
Function TRegExpr.DumpOp(op: TREOp): RegExprString;
// printable representation of opcode
Begin
    Case op Of
        BOL:
            Result := 'BOL';
        EOL:
            Result := 'EOL';
        BOLML:
            Result := 'BOLML';
        EOLML:
            Result := 'EOLML';
        BOUND:
            Result := 'BOUND'; //###0.943
        NOTBOUND:
            Result := 'NOTBOUND'; //###0.943
        ANY:
            Result := 'ANY';
        ANYML:
            Result := 'ANYML'; //###0.941
        ANYLETTER:
            Result := 'ANYLETTER';
        NOTLETTER:
            Result := 'NOTLETTER';
        ANYDIGIT:
            Result := 'ANYDIGIT';
        NOTDIGIT:
            Result := 'NOTDIGIT';
        ANYSPACE:
            Result := 'ANYSPACE';
        NOTSPACE:
            Result := 'NOTSPACE';
        ANYOF:
            Result := 'ANYOF';
        ANYBUT:
            Result := 'ANYBUT';
        ANYOFCI:
            Result := 'ANYOF/CI';
        ANYBUTCI:
            Result := 'ANYBUT/CI';
        BRANCH:
            Result := 'BRANCH';
        EXACTLY:
            Result := 'EXACTLY';
        EXACTLYCI:
            Result := 'EXACTLY/CI';
        NOTHING:
            Result := 'NOTHING';
        COMMENT:
            Result := 'COMMENT';
        BACK:
            Result := 'BACK';
        EEND:
            Result := 'END';
        BSUBEXP:
            Result := 'BSUBEXP';
        BSUBEXPCI:
            Result := 'BSUBEXP/CI';
        Succ(OPEN) .. TREOp(Ord(OPEN) + NSUBEXP - 1): //###0.929
            Result := Format('OPEN[%d]', [ord(op) - ord(OPEN)]);
        Succ(CLOSE) .. TREOp(Ord(CLOSE) + NSUBEXP - 1): //###0.929
            Result := Format('CLOSE[%d]', [ord(op) - ord(CLOSE)]);
        STAR:
            Result := 'STAR';
        PLUS:
            Result := 'PLUS';
        BRACES:
            Result := 'BRACES';
    {$IFDEF ComplexBraces}
        LOOPENTRY:
            Result := 'LOOPENTRY'; //###0.925
        LOOP:
            Result := 'LOOP'; //###0.925
        LOOPNG:
            Result := 'LOOPNG'; //###0.940
    {$ENDIF}
        ANYOFTINYSET:
            Result := 'ANYOFTINYSET';
        ANYBUTTINYSET:
            Result := 'ANYBUTTINYSET';
    {$IFDEF UseSetOfChar} //###0.929
        ANYOFFULLSET:
            Result := 'ANYOFFULLSET';
    {$ENDIF}
        STARNG:
            Result := 'STARNG'; //###0.940
        PLUSNG:
            Result := 'PLUSNG'; //###0.940
        BRACESNG:
            Result := 'BRACESNG'; //###0.940
    Else
        Error(reeDumpCorruptedOpcode);
    End; {of case op}
    Result := ':' + Result;
End; { of function TRegExpr.DumpOp
--------------------------------------------------------------}

Function TRegExpr.Dump: RegExprString;
// dump a regexp in vaguely comprehensible form
Var
    s: PRegExprChar;
    op: TREOp; // Arbitrary non-END op.
    next: PRegExprChar;
    i: Integer;
    Diff: Integer;
{$IFDEF UseSetOfChar} //###0.929
    Ch: REChar;
{$ENDIF}
Begin
    If Not IsProgrammOk //###0.929
    Then
        EXIT;

    op := EXACTLY;
    Result := '';
    s := programm + REOpSz;
    While op <> EEND Do
    Begin // While that wasn't END last time...
        op := s^;
        Result := Result + Format('%2d%s', [s - programm, DumpOp(s^)]); // Where, what.
        next := regnext(s);
        If next = Nil // Next ptr.
        Then
            Result := Result + ' (0)'
        Else
        Begin
            If next > s //###0.948 PWideChar subtraction workaround (see comments in Tail method for details)
            Then
                Diff := next - s
            Else Diff := -(s - next);
            Result := Result + Format(' (%d) ', [(s - programm) + Diff]);
        End;
        inc(s, REOpSz + RENextOffSz);
        If (op = ANYOF) Or (op = ANYOFCI) Or (op = ANYBUT) Or (op = ANYBUTCI)
            Or (op = EXACTLY) Or (op = EXACTLYCI) Then
        Begin
         // Literal string, where present.
            While s^ <> #0 Do
            Begin
                Result := Result + s^;
                inc(s);
            End;
            inc(s);
        End;
        If (op = ANYOFTINYSET) Or (op = ANYBUTTINYSET) Then
        Begin
            For i := 1 To TinySetLen Do
            Begin
                Result := Result + s^;
                inc(s);
            End;
        End;
        If (op = BSUBEXP) Or (op = BSUBEXPCI) Then
        Begin
            Result := Result + ' \' + IntToStr(Ord(s^));
            inc(s);
        End;
     {$IFDEF UseSetOfChar} //###0.929
        If op = ANYOFFULLSET Then
        Begin
            For Ch := #0 To #255 Do
                If Ch In PSetOfREChar(s)^ Then
                    If Ch < ' '
                    Then
                        Result := Result + '#' + IntToStr(Ord(Ch)) //###0.936
                    Else Result := Result + Ch;
            inc(s, SizeOf(TSetOfREChar));
        End;
     {$ENDIF}
        If (op = BRACES) Or (op = BRACESNG) Then
        Begin //###0.941
       // show min/max argument of BRACES operator
            Result := Result + Format('{%d,%d}', [PREBracesArg(s)^, PREBracesArg(s + REBracesArgSz)^]);
            inc(s, REBracesArgSz * 2);
        End;
     {$IFDEF ComplexBraces}
        If (op = LOOP) Or (op = LOOPNG) Then
        Begin //###0.940
            Result := Result + Format(' -> (%d) {%d,%d}', [
                (s - programm - (REOpSz + RENextOffSz)) + PRENextOff(s + 2 * REBracesArgSz)^,
                PREBracesArg(s)^, PREBracesArg(s + REBracesArgSz)^]);
            inc(s, 2 * REBracesArgSz + RENextOffSz);
        End;
     {$ENDIF}
        Result := Result + #$d#$a;
    End; { of while}

  // Header fields of interest.

    If regstart <> #0
    Then
        Result := Result + 'start ' + regstart;
    If reganch <> #0
    Then
        Result := Result + 'anchored ';
    If regmust <> Nil
    Then
        Result := Result + 'must have ' + regmust;
  {$IFDEF UseFirstCharSet} //###0.929
    Result := Result + #$d#$a'FirstCharSet:';
    For Ch := #0 To #255 Do
        If Ch In FirstCharSet
        Then
        Begin
            If Ch < ' '
            Then
                Result := Result + '#' + IntToStr(Ord(Ch)) //###0.948
            Else Result := Result + Ch;
        End;
  {$ENDIF}
    Result := Result + #$d#$a;
End; { of function TRegExpr.Dump
--------------------------------------------------------------}
{$ENDIF}

{$IFDEF reRealExceptionAddr}
{$OPTIMIZATION ON}
// ReturnAddr works correctly only if compiler optimization is ON
// I placed this method at very end of unit because there are no
// way to restore compiler optimization flag ...
{$ENDIF}
Procedure TRegExpr.Error(AErrorID: Integer);
{$IFDEF reRealExceptionAddr}
    Function ReturnAddr: pointer; //###0.938
    Asm
        MOV  EAX,[EBP+4]
    End;
{$ENDIF}
Var
    e: ERegExpr;
Begin
    fLastError := AErrorID; // dummy stub - useless because will raise exception
    If AErrorID < 1000 // compilation error ?
    Then
        e := ERegExpr.Create(ErrorMsg(AErrorID) // yes - show error pos
            + ' (pos ' + IntToStr(CompilerErrorPos) + ')')
    Else e := ERegExpr.Create(ErrorMsg(AErrorID));
    e.ErrorCode := AErrorID;
    e.CompilerErrorPos := CompilerErrorPos;
    Raise e
   {$IFDEF reRealExceptionAddr}
    At ReturnAddr; //###0.938
   {$ENDIF}
End; { of procedure TRegExpr.Error
--------------------------------------------------------------}

(*
  PCode persistence:
   FirstCharSet
   programm, regsize
   regstart // -> programm
   reganch // -> programm
   regmust, regmlen // -> programm
   fExprIsCompiled
*)

// be carefull - placed here code will be always compiled with
// compiler optimization flag

{$IFDEF FPC}
initialization
 RegExprInvertCaseFunction := TRegExpr.InvertCaseFunction;

{$ENDIF}
End.
