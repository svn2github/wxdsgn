{*******************************************************}
{                                                       }
{       xTool - Component Collection                    }
{                                                       }
{       Copyright (c) 1995 Stefan Böther                }
{                            stefc@fabula.com           }
{*******************************************************}
{
  Please look also for our xTools-Nails function toolkit.
  You'll find more information at
     http://ourworld.compuserve.com/homepages/stefc/xprocs.htm

  Any comments and suggestions are welcome; please send to:
     stefc@fabula.com.

   21.02.96  added TMonth & TDay type                                Stefc
   22.02.96  added strFileLoad & strFileSave                         Stefc
   09.03.96  correct sysTempPath                                     Stefc
   09.03.96  added regXXXXX functions for access the registry        Stefc
   24.03.96  added IsWinNT constant                                  Stefc
   24.03.96  added SysMetric object                                  Stefc
   26.03.96  added dateQuicken for controling date input with keys   Stefc
   27.03.96  added TDesktopCanvas here                               Stefc
   28.03.96  added LoadDIBitmap                                      Stefc
   01.04.96  added Question function here                            Stefc
   09.04.96  added sysSaverRunning added                             Stefc
   12.04.96  added timeZoneOffset                                    Stefc
   12.04.96  added timeToInt                                         Stefc
   17.04.96  added strCmdLine                                        Stefc
   17.04.96  added rectBounds                                        Stefc
   17.04.96  added TPersistentRect class                             Stefc
   19.04.96  added strDebug method                                   Stefc
   21.04.96  changed TMonth added noneMonth                          km
   21.04.96  added licence callback                                  Stefc
   21.04.96  added strNiceDateDefault                                km
   21.04.96  added simple strEncrpyt & strDecrypt                    Stefc
   24.04.96  backport to 16 bit                                      Stefc
   24.04.96  added Information method                                Stefc
   24.04.96  use win messageBox with Win95 in Question & Information Stefc
   09.05.96  new function ExtractName                                Stefc
   10.05.96  Added TPersistentRegistry                               Stefc
   12.05.96  fileExec                                                Stefc
   14.05.96  New function Confirmation                               Stefc
   16.05.96  New function strChange                                  Stefc
   29.05.96  New functions comXXXXX                                  Stefc
   09.06.96  New function strSearchReplace                           km
   09.06.96  ported assembler strHash to plain pascal                Stefc
   15.06.96  new variables xLanguage & xLangOfs                      Stefc
   28.06.96  new method sysBeep                                      Stefc
   28.06.96  new method intPercent                                   Stefc
   10.07.96  make compatible with 16 Bit Delphi 1.0                  Stefc
   14.07.96  fileLongName & fileShortName defined                    Stefc
   15.07.96  Correct sysTempPath method                              Stefc
   21.07.96  New functions strContains & strContainsU                Stefc
   28.07.96  comIsCServe also check for xxx@compuServe.com           Stefc
   31.07.96  added strCapitalize after idea from Fred N. Read        Stefc
   04.08.96  strByteSize() now can also display Bytes                Stefc
   05.08.96  added regWriteShellExt()                                Stefc
   06.08.96  added sysColorDepth()                                   Stefc
   07.08.96  added strSoundex()                                      Stefc
   09.08.96  fixe some bugs in fileShellXXXX                         Stefc
   26.08.96  Added registry functions from David W. Yutzy            Stefc
   29.08.96  fileShellXXX now also aviable under 16 Bit              Stefc
   05.09.96  Added regDelValue                                       Stefc
   13.09.96  Added fltNegativ and fltPositiv                         Stefc
   29.09.96  Added strTokenToStrings & strTokenFromStrings           Stefc
   09.10.96  Added variant function                                  Stefc
   29.10.96  intPrime now can be used for negative numbers           Stefc
   29.10.96  fltEqualZero now returns true with FLTZERO              Stefc
   29.10.96  fltCalc now use Float for greater precision             Stefc
   29.10.96  correct strTokenCount                                   Stefc
   19.11.96  better Windows NT detecting                             Stefc
   28.11.96  correct above text (thanks to Clay Kollenborn-Shannon)  Stefc
   12.01.96  added fileCopy function                                 Stefc
   13.01.96  correct strProfile now it works also for 16-Bit         Stefc
   13.01.96  get English Quicken keys from George Boomer             Stefc
   14.01.96  make key in dateQuicken var to reset if on date change  Stefc
   17.01.96  New functions strPos and strChangeU                     Stefc
   19.01.96  new function fileTypeName after idea of P.Aschenbacher  Stefc
   19.01.96  new function fileRedirectExec                           Stefc

}

unit xProcs;

{$D-}

interface

{.$DEFINE German}
{.$DEFINE English}

uses
{$IFDEF Win32}Windows, Registry, {$ELSE}WinTypes, WinProcs, {$ENDIF}
    ShellAPI, Messages, Classes, Graphics, shlObj, ActiveX;

type
    Float = Extended; { our type for float arithmetic }

{$IFDEF Win32} { our type for integer functions, Int_ is ever 32 bit }
    Int_ = Integer;
{$ELSE}
    Int_ = Longint;
{$ENDIF}

const
    XCOMPANY = 'Fabula Software';

const
    { several important ASCII codes }
    NULL = #0;
    BACKSPACE = #8;
    TAB = #9;
    LF = #10;
    CR = #13;
    EOF_ = #26; { 30.07.96 sb }
    ESC = #27;
    BLANK = #32;
    SPACE = BLANK;

    { digits as chars }
    ZERO = '0';
    ONE = '1';
    TWO = '2';
    THREE = '3';
    FOUR = '4';
    FIVE = '5';
    SIX = '6';
    SEVEN = '7';
    EIGHT = '8';
    NINE = '9';

    { special codes }
    SLASH = '\'; { used in filenames }
    HEX_PREFIX = '$'; { prefix for hexnumbers }

    CRLF: PChar = CR + LF;

    { common computer sizes }
    KBYTE = Sizeof(Byte) shl 10;
    MBYTE = KBYTE shl 10;
    GBYTE = MBYTE shl 10;

    { Low floating point value }
    FLTZERO: Float = 0.00000001;

    DIGITS: set of Char = [ZERO..NINE];

    { important registry keys / items }
    REG_CURRENT_VERSION = 'Software\Microsoft\Windows\CurrentVersion';
    REG_CURRENT_USER = 'RegisteredOwner';
    REG_CURRENT_COMPANY = 'RegisteredOrganization';

    PRIME_16 = 65521;
    PRIME_32 = 2147483647;

    MINSHORTINT = -128; { 1.8.96 sb }
    MAXSHORTINT = 127;
    MINBYTE = 0;
    MAXBYTE = 255;
    MINWORD = 0;
    MAXWORD = 65535;

type
    TMonth = (NoneMonth, January, February, March, April, May, June, July,
        August, September, October, November, December);

    TDayOfWeek = (Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday);

    { Online eMail Service Provider }
    TMailProvider = (mpCServe, mpInternet, mpNone);

    TLicCallback = function(var Code: Integer): Integer;

    TBit = 0..31;

    { Search and Replace options }
    TSROption = (srWord, srCase, srAll);
    TSROptions = set of TsrOption;	

    { Data types }
    TDataType = (dtInteger, dtBoolean, dtString, dtDate, dtTime,
        dtFloat, dtCurrency);

var
    IsWin95,
        IsWinNT: Boolean;
    IsFabula: TLicCallBack;

    xLanguage: Integer;
    xLangOfs: Integer;

    { bit manipulating }
function bitSet(const Value: Int_; const TheBit: TBit): Boolean;
function bitOn(const Value: Int_; const TheBit: TBit): Int_;
function bitOff(const Value: Int_; const TheBit: TBit): Int_;
function bitToggle(const Value: Int_; const TheBit: TBit): Int_;

{ String functions }
function strHash(const S: string; LastBucket: Integer): Integer;
function strCut(const S: string; Len: Integer): string;
function strTrim(const S: string): string;
function strTrimA(const S: string): string;
function strTrimChA(const S: string; C: Char): string;
function strTrimChL(const S: string; C: Char): string;
function strTrimChR(const S: string; C: Char): string;
function strLeft(const S: string; Len: Integer): string;
function strLower(const S: string): string;
function strMake(C: Char; Len: Integer): string;
function strPadChL(const S: string; C: Char; Len: Integer): string;
function strPadChR(const S: string; C: Char; Len: Integer): string;
function strPadChC(const S: string; C: Char; Len: Integer): string;
function strPadL(const S: string; Len: Integer): string;
function strPadR(const S: string; Len: Integer): string;
function strPadC(const S: string; Len: Integer): string;
function strPadZeroL(const S: string; Len: Integer): string;
function strPos(const aSubstr, S: string; aOfs: Integer): Integer;
procedure strChange(var S: string; const Src, Dest: string);
function strChangeU(const S, Source, Dest: string): string;
function strRight(const S: string; Len: Integer): string;
function strAddSlash(const S: string): string;
function strDelSlash(const S: string): string;
function strSpace(Len: Integer): string;
function strToken(var S: string; Seperator: Char): string;
function strTokenCount(S: string; Seperator: Char): Integer;
function strTokenAt(const S: string; Seperator: Char; At: Integer): string;
procedure strTokenToStrings(S: string; Seperator: Char; List: TStrings);
function strTokenFromStrings(Seperator: Char; List: TStrings): string;
function strRemoveDuplicates(OrigString : string; Seperator: Char): string;

function strUpper(const S: string): string;
function strOemAnsi(const S: string): string;
function strAnsiOem(const S: string): string;
function strEqual(const S1, S2: string): Boolean;
function strComp(const S1, S2: string): Boolean;
function strCompU(const S1, S2: string): Boolean;
function strContains(const S1, S2: string): Boolean;
function strContainsU(const S1, S2: string): Boolean;
function strNiceNum(const S: string): string;
function strNiceDateDefault(const S, Default: string): string;
function strNiceDate(const S: string): string;
function strNiceTime(const S: string): string;
function strNicePhone(const S: string): string;
function strReplace(const S: string; C: Char; const Replace: string): string;
function strCmdLine: string;
function strEncrypt(const S: string; Key: Word): string;
function strDecrypt(const S: string; Key: Word): string;
function strLastCh(const S: string): Char;
procedure strStripLast(var S: string);
function strByteSize(Value: Longint): string;
function strSoundex(S: string): string;
procedure strSearchReplace(var S: string; const Source, Dest: string; Options: TSRoptions);
function strProfile(const aFile, aSection, aEntry, aDefault: string): string;
function strCapitalize(const S: string): string; { 31.07.96 sb }

{$IFDEF Win32}
procedure strDebug(const S: string);
function strFileLoad(const aFile: string): string;
procedure strFileSave(const aFile, aString: string);
{$ENDIF}

{ Integer functions }
function IsInt(s1: string): Boolean;
function intCenter(a, b: Int_): Int_;
function intMax(a, b: Int_): Int_;
function intMin(a, b: Int_): Int_;
function intPow(Base, Expo: Integer): Int_;
function intPow10(Exponent: Integer): Int_;
function intSign(a: Int_): Integer;
function intZero(a: Int_; Len: Integer): string;
function intPrime(Value: Integer): Boolean;
function intPercent(a, b: Int_): Int_;

{ Floatingpoint functions }
function Isflt(s1: string): Boolean;
function fltAdd(P1, P2: Float; Decimals: Integer): Float;
function fltDiv(P1, P2: Float; Decimals: Integer): Float;
function fltEqual(P1, P2: Float; Decimals: Integer): Boolean;
function fltEqualZero(P: Float): Boolean;
function fltGreaterZero(P: Float): Boolean;
function fltLessZero(P: Float): Boolean;
function fltNeg(P: Float; Negate: Boolean): Float;
function fltMul(P1, P2: Float; Decimals: Integer): Float;
function fltRound(P: Float; Decimals: Integer): Float;
function fltSub(P1, P2: Float; Decimals: Integer): Float;
function fltUnEqualZero(P: Float): Boolean;
function fltCalc(const Expr: string): Float;
function fltPower(a, n: Float): Float;
function fltPositiv(Value: Float): Float;
function fltNegativ(Value: Float): Float;

{ Rectangle functions from Golden Software }
function rectHeight(const R: TRect): Integer;
function rectWidth(const R: TRect): Integer;
procedure rectGrow(var R: TRect; Delta: Integer);
procedure rectRelativeMove(var R: TRect; DX, DY: Integer);
procedure rectMoveTo(var R: TRect; X, Y: Integer);
function rectSet(Left, Top, Right, Bottom: Integer): TRect;
function rectInclude(const R1, R2: TRect): Boolean;
function rectPoint(const R: TRect; P: TPoint): Boolean;
function rectSetPoint(const TopLeft, BottomRight: TPoint): TRect;
function rectIntersection(const R1, R2: TRect): TRect;
function rectIsIntersection(const R1, R2: TRect): Boolean;
function rectIsValid(const R: TRect): Boolean;
function rectsAreValid(const Arr: array of TRect): Boolean;
function rectNull: TRect;
function rectIsNull(const R: TRect): Boolean;
function rectIsSquare(const R: TRect): Boolean;
function rectCentralPoint(const R: TRect): TPoint;
function rectBounds(aLeft, aTop, aWidth, aHeight: Integer): TRect;

{$IFDEF Win32}
{ Variant functions }
function varIIF(aTest: Boolean; TrueValue, FalseValue: Variant): Variant;
procedure varDebug(const V: Variant);
function varToStr(const V: Variant): string;
{$ENDIF}

{ date functions }
function dateYear(D: TDateTime): Integer;
function dateMonth(D: TDateTime): Integer;
function dateDay(D: TDateTime): Integer;
function dateBeginOfYear(D: TDateTime): TDateTime;
function dateEndOfYear(D: TDateTime): TDateTime;
function dateBeginOfMonth(D: TDateTime): TDateTime;
function dateEndOfMonth(D: TDateTime): TDateTime;
function dateWeekOfYear(D: TDateTime): Integer;
function dateDayOfYear(D: TDateTime): Integer;
function dateDayOfWeek(D: TDateTime): TDayOfWeek;
function dateLeapYear(D: TDateTime): Boolean;
function dateBeginOfQuarter(D: TDateTime): TDateTime;
function dateEndOfQuarter(D: TDateTime): TDateTime;
function dateBeginOfWeek(D: TDateTime; Weekday: Integer): TDateTime;
function dateDaysInMonth(D: TDateTime): Integer;
function dateQuicken(D: TDateTime; var Key: Char): TDateTime;
{function  dateDiff(D1,D2: TDateTime): Integer;}

{ time functions }
function timeHour(T: TDateTime): Integer;
function timeMin(T: TDateTime): Integer;
function timeSec(T: TDateTime): Integer;
function timeToInt(T: TDateTime): Integer;

{$IFDEF Win32}
function timeZoneOffset: Integer;
{$ENDIF}

{ com Functions }
function comIsCis(const S: string): Boolean;
function comIsInt(const S: string): Boolean;
function comCisToInt(const S: string): string;
function comIntToCis(const S: string): string;
function comFaxToCis(const S: string): string;
function comNormFax(const Name, Fax: string): string;
function comNormPhone(const Phone: string): string;
function comNormInt(const Name, Int: string): string;
function comNormCis(const Name, Cis: string): string;

{ file functions }
procedure fileShredder(const Filename: string);
function fileSize(const Filename: string): Longint;
function fileWildcard(const Filename: string): Boolean;
function fileShellOpen(const aFile: string): Boolean;
function fileShellPrint(const aFile: string): Boolean;
function fileCopy(const SourceFile, TargetFile: string): Boolean;

{$IFDEF Win32}
function fileTemp(const aExt: string): string;
function fileExec(const aCmdLine: string; aHide, aWait: Boolean): Boolean;
function fileRedirectExec(const aCmdLine: string; Strings: TStrings): Boolean;
function fileLongName(const aFile: string): string;
function fileShortName(const aFile: string): string;
function fileTypeName(const aFile: string): string;
{$ENDIF}
function ExtractName(const Filename: string): string;

{ system functions }
function sysTempPath: string;
procedure sysDelay(aMs: Longint);
procedure sysBeep;
function sysColorDepth: Integer; { 06.08.96 sb }

{$IFDEF Win32}
function GetShellFoldername(folderID: Integer): string;
procedure sysSaverRunning(Active: Boolean);
{$ENDIF}

{ registry functions }

{$IFDEF Win32}
function regReadString(aKey: hKey; const Path: string): string;
procedure regWriteString(aKey: hKey; const Path, Value: string);
procedure regDelValue(aKey: hKey; const Path: string);
function regInfoString(const Value: string): string;
function regCurrentUser: string;
function regCurrentCompany: string;
procedure regWriteShellExt(const aExt, aCmd, aMenu, aExec: string);

{ The following five functions came from David W. Yutzy / Celeste Software Services
  Thanks for submitting us the methods !!
}
procedure regKeyList(aKey: HKEY; const Path: string; var aValue: TStringList);
function regValueExist(aKey: HKEY; const Path: string): Boolean;
function regWriteValue(aKey: HKEY; const Path: string; Value: Variant; Typ: TDataType): Boolean;
function regReadValue(aKey: HKEY; const Path: string; Typ: TDataType): Variant;
procedure regValueList(aKey: HKEY; const Path: string; var aValue: TStringList);
{$ENDIF}

{Innet functions}
procedure OpenURL(const URL: string);

function UnixPathToDosPath(const Path: string): string;
function DosPathToUnixPath(const Path: string): string;

function HTTPEncode(const AStr: string): string;
function HTTPDecode(const AStr: string): string;

type
    { TRect that can be used persistent as property for components }
    TUnitConvertEvent = function(Sender: TObject;
        Value: Integer; Get: Boolean): Integer of object;

    TPersistentRect = class(TPersistent)
    private
        FRect: TRect;
        FOnConvert: TUnitConvertEvent;
        procedure SetLeft(Value: Integer);
        procedure SetTop(Value: Integer);
        procedure SetHeight(Value: Integer);
        procedure SetWidth(Value: Integer);
        function GetLeft: Integer;
        function GetTop: Integer;
        function GetHeight: Integer;
        function GetWidth: Integer;
    public
        constructor Create;
        procedure Assign(Source: TPersistent); override;
        property Rect: TRect read FRect;
        property OnConvert: TUnitConvertEvent read FOnConvert write FOnConvert;
    published
        property Left: Integer read GetLeft write SetLeft;
        property Top: Integer read GetTop write SetTop;
        property Height: Integer read GetHeight write SetHeight;
        property Width: Integer read GetWidth write SetWidth;
    end;

{$IFDEF Win32}
    { Persistent access of components from the registry }
    TPersistentRegistry = class(TRegistry)
    public
        function ReadComponent(const Name: string; Owner, Parent: TComponent): TComponent;
        procedure WriteComponent(const Name: string; Component: TComponent);
    end;
    {$ENDIF

      { easy access of the system metrics }
    TSystemMetric = class
    private
        FColorDepth,
            FMenuHeight,
            FCaptionHeight: Integer;
        FBorder,
            FFrame,
            FDlgFrame,
            FBitmap,
            FHScroll,
            FVScroll,
            FThumb,
            FFullScreen,
            FMin,
            FMinTrack,
            FCursor,
            FIcon,
            FDoubleClick,
            FIconSpacing: TPoint;
    protected
        constructor Create;
        procedure Update;
    public
        property MenuHeight: Integer read FMenuHeight;
        property CaptionHeight: Integer read FCaptionHeight;
        property Border: TPoint read FBorder;
        property Frame: TPoint read FFrame;
        property DlgFrame: TPoint read FDlgFrame;
        property Bitmap: TPoint read FBitmap;
        property HScroll: TPoint read FHScroll;
        property VScroll: TPoint read FVScroll;
        property Thumb: TPoint read FThumb;
        property FullScreen: TPoint read FFullScreen;
        property Min: TPoint read FMin;
        property MinTrack: TPoint read FMinTrack;
        property Cursor: TPoint read FCursor;
        property Icon: TPoint read FIcon;
        property DoubleClick: TPoint read FDoubleClick;
        property IconSpacing: TPoint read FIconSpacing;
        property ColorDepth: Integer read FColorDepth;
    end;

var
    SysMetric: TSystemMetric;

type
    TDesktopCanvas = class(TCanvas)
    private
        DC: hDC;
    public
        constructor Create;
        destructor Destroy; override;
    end;

implementation

uses
    SysUtils, Controls, Forms, Consts, Dialogs;

{ bit manipulating }

function bitSet(const Value: Int_; const TheBit: TBit): Boolean;
begin
    Result := (Value and (1 shl TheBit)) <> 0;
end;

function bitOn(const Value: Int_; const TheBit: TBit): Int_;
begin
    Result := Value or (1 shl TheBit);
end;

function bitOff(const Value: Int_; const TheBit: TBit): Int_;
begin
    Result := Value and ((1 shl TheBit) xor $FFFFFFFF);
end;

function bitToggle(const Value: Int_; const TheBit: TBit): Int_;
begin
    result := Value xor (1 shl TheBit);
end;

{ string methods }

function strHash(const S: string; LastBucket: Integer): Integer;
var
    i: Integer;
begin
    Result := 0;
    for i := 1 to Length(S) do
        Result := ((Result shl 3) xor Ord(S[i])) mod LastBucket;
end;

function strTrim(const S: string): string;
begin
    Result := StrTrimChR(StrTrimChL(S, BLANK), BLANK);
end;

function strTrimA(const S: string): string;
begin
    Result := StrTrimChA(S, BLANK);
end;

function strTrimChA(const S: string; C: Char): string;
var
    I: Word;
begin
    Result := S;
    for I := Length(Result) downto 1 do
        if Result[I] = C then
            Delete(Result, I, 1);
end;

function strTrimChL(const S: string; C: Char): string;
begin
    Result := S;
    while (Length(Result) > 0) and (Result[1] = C) do
        Delete(Result, 1, 1);
end;

function strTrimChR(const S: string; C: Char): string;
begin
    Result := S;
    while (Length(Result) > 0) and (Result[Length(Result)] = C) do
        Delete(Result, Length(Result), 1);
end;

function strLeft(const S: string; Len: Integer): string;
begin
    Result := Copy(S, 1, Len);
end;

function strLower(const S: string): string;
begin
    Result := AnsiLowerCase(S);
end;

function strMake(C: Char; Len: Integer): string;
begin
    Result := strPadChL('', C, Len);
end;

function strPadChL(const S: string; C: Char; Len: Integer): string;
begin
    Result := S;
    while Length(Result) < Len do
        Result := C + Result;
end;

function strPadChR(const S: string; C: Char; Len: Integer): string;
begin
    Result := S;
    while Length(Result) < Len do
        Result := Result + C;
end;

function strPadChC(const S: string; C: Char; Len: Integer): string;
begin
    Result := S;
    while Length(Result) < Len do
    begin
        Result := Result + C;
        if Length(Result) < Len then
            Result := C + Result;
    end;
end;

function strPadL(const S: string; Len: Integer): string;
begin
    Result := strPadChL(S, BLANK, Len);
end;

function strPadC(const S: string; Len: Integer): string;
begin
    Result := strPadChC(S, BLANK, Len);
end;

function strPadR(const S: string; Len: Integer): string;
begin
    Result := strPadChR(S, BLANK, Len);
end;

function strPadZeroL(const S: string; Len: Integer): string;
begin
    Result := strPadChL(strTrim(S), ZERO, Len);
end;

function strCut(const S: string; Len: Integer): string;
begin
    Result := strLeft(strPadR(S, Len), Len);
end;

function strRight(const S: string; Len: Integer): string;
begin
    if Len >= Length(S) then
        Result := S
    else
        Result := Copy(S, Succ(Length(S)) - Len, Len);
end;

function strAddSlash(const S: string): string;
begin
    Result := S;
    if strLastCh(Result) <> SLASH then
        Result := Result + SLASH;
end;

function strDelSlash(const S: string): string;
begin
    Result := S;
    if strLastCh(Result) = SLASH then
        Delete(Result, Length(Result), 1);
end;

function strSpace(Len: Integer): string;
begin
    Result := StrMake(BLANK, Len);
end;

function strToken(var S: string; Seperator: Char): string;
var
    I: Word;
begin
    I := Pos(Seperator, S);
    if I <> 0 then
    begin
        Result := Copy(S, 1, I - 1);  //System.Copy(S, 1, I - 1);
        Delete(S, 1, I);  //System.Delete(S, 1, I);
    end
    else
    begin
        Result := S;
        S := '';
    end;
end;

function strTokenCount(S: string; Seperator: Char): Integer;
var
    Scopy : string;
    I, Count : Integer;
begin

   Scopy := S;
   Count := 0;

   I := Pos(Seperator, Scopy);
   while I <> 0 do
   begin
      Count := Count + 1;
      Delete(Scopy, 1, I + Length(Seperator) - 1);
      I := Pos(Seperator, Scopy);
   end;

   Result := Count;

end;

function strTokenAt(const S: string; Seperator: Char; At: Integer): string;
var
    j, i: Integer;
begin
    Result := '';
    j := 1;
    i := 0;
    while (i <= At) and (j <= Length(S)) do
    begin
        if S[j] = Seperator then
            Inc(i)
        else if i = At then
            Result := Result + S[j];
        Inc(j);
    end;
end;

procedure strTokenToStrings(S: string; Seperator: Char; List: TStrings);
var
    Token, Scopy: string;
begin
   List.Clear;
   Scopy := S;

    Token := strToken(Scopy, Seperator);
    while Token <> '' do
    begin
        List.Add(Token);
        Token := strToken(Scopy, Seperator);
    end;
end;

function strTokenFromStrings(Seperator: Char; List: TStrings): string;
var
    i: Integer;
begin
    Result := '';
    for i := 0 to List.Count - 1 do
        if Result <> '' then
            Result := Result + Seperator + List[i]
        else
            Result := List[i];
end;

// Removes duplicate values in a token-delimited string
function strRemoveDuplicates(OrigString : string; Seperator: Char): string;
var
  List1, List2 : TStringList;
  nodupString : string;
  i : Integer;
begin

    List1 := TStringList.Create;
    List2 := TStringList.Create;
    strTokenToStrings(OrigString, Seperator, List1);

    List2.Add(List1[0]);
    for i := 1 to List1.Count - 1 do
    begin
       // If the string from List1 is not in List2, then add it.
       if (List2.IndexOf(List1[i]) > -1) and (strTrim(List1[i]) <> '') then
          List2.Add(List1[i]);
    end;

    nodupString := strTokenFromStrings(Seperator, List2);
    List2.Destroy;
    List1.Destroy;
    Result := nodupString;

end;

function strUpper(const S: string): string;
begin
    Result := AnsiUpperCase(S);
end;

function strOemAnsi(const S: string): string;
begin
{$IFDEF Win32}
    SetLength(Result, Length(S));
{$ELSE}
    Result[0] := Chr(Length(S));
{$ENDIF}
    OemToAnsiBuff(@S[1], @Result[1], Length(S));
end;

function strAnsiOem(const S: string): string;
begin
{$IFDEF Win32}
    SetLength(Result, Length(S));
{$ELSE}
    Result[0] := Chr(Length(S));
{$ENDIF}
    AnsiToOemBuff(@S[1], @Result[1], Length(S));
end;

function strEqual(const S1, S2: string): Boolean;
begin
    Result := AnsiCompareText(S1, S2) = 0;
end;

function strCompU(const S1, S2: string): Boolean;
begin
    Result := strEqual(strLeft(S2, Length(S1)), S1);
end;

function strComp(const S1, S2: string): Boolean;
begin
    Result := strLeft(S2, Length(S1)) = S1;
end;

function strContains(const S1, S2: string): Boolean;
begin
    Result := Pos(S1, S2) > 0;
end;

function strContainsU(const S1, S2: string): Boolean;
begin
    Result := strContains(strUpper(S1), strUpper(S2));
end;

function strNiceNum(const S: string): string;
var
    i: Integer;
    Seps: set of Char;
begin
    Seps := [ThousandSeparator, DecimalSeparator];
    Result := ZERO;
    for i := 1 to Length(S) do
        if S[i] in DIGITS + Seps then
        begin
            if S[i] = ThousandSeparator then
                Result := Result + DecimalSeparator
            else
                Result := Result + S[i];
            if S[i] in Seps then
                Seps := [];
        end
end;

function strNiceDate(const S: string): string;
begin
    Result := strNiceDateDefault(S, DateToStr(Date));
end;

function strNiceDateDefault(const S, Default: string): string;
(* sinn der Procedure:
   Irgendeinen String übergeben und in ein leidlich brauchbares Datum verwandeln.
   Im Wesentlichen zum Abfangen des Kommazeichens auf dem Zehnerfeld.
   eingabe 10 = Rückgabe 10 des Laufenden Monats
   eingabe 10.12 = Rückgabe des 10.12. des laufenden Jahres.
   eingabe 10.12.96 = Rückgabe des Strings
   eingabe 10,12,96 = Rückgabe 10.12.95 (wird dann won STRtoDATE() gefressen)
   Eine Plausbilitätskontrolle des Datums findet nicht Statt.
   Geplante Erweiterung:
   eingabe: +14  = Rückgabe 14 Tage Weiter
   eingabe: +3m  = Rückgabe 3 Monate ab Heute
   eingabe: +3w  = Rückgabe 3 Wochen (3*7 Tage) ab Heute
   Das gleiche auch Rückwärts mit  Minuszeichen
   eingabe: e oder E oder f  = Nächster Erster
   eingabe: e+1m Erster des übernächsten Monats
   Da läßt sich aber noch trefflich weiterspinnen

   EV. mit Quelle rausgeben, damit sich die Engländer und Franzosen an
   Ihren Datumsformaten selbst erfreuen können und wir die passenden umsetzungen
   bekommen. *)
var
    a: array[0..2] of string[4];
    heute: string;
    i, j: integer;
begin
    a[0] := '';
    a[1] := '';
    a[2] := '';
    heute := Default;

    j := 0;
    for i := 0 to length(S) do
        if S[i] in DIGITS then
            a[j] := a[j] + S[i]
        else if S[i] in [DateSeparator] then
            Inc(j);
    for i := 0 to 2 do
        if Length(a[i]) = 0 then
            if I = 2 then
                a[i] := copy(heute, i * 3 + 1, 4)
            else
                a[i] := copy(heute, i * 3 + 1, 2)
        else if length(a[i]) = 1 then
            a[i] := '0' + a[i];

    Result := a[0] + DateSeparator + a[1] + DateSeparator + a[2];
    try
        StrToDate(Result);
    except
        Result := DateToStr(Date);
    end;
end;

function strNiceTime(const S: string): string;
var
    a: array[0..2] of string[2];
    i, j: integer;
begin
    j := 0;
    a[0] := '';
    a[1] := '';
    a[2] := '';
    for i := 1 to length(S) do
    begin
        if S[i] in DIGITS then
        begin
            a[j] := a[j] + S[i];
        end
        else if S[i] in ['.', ',', ':'] then
            inc(J);
        if j > 2 then
            exit;
    end;
    for J := 0 to 2 do
        if length(a[j]) = 1 then
            a[j] := '0' + a[j]
        else if length(a[j]) = 0 then
            a[j] := '00';
    Result := a[0] + TimeSeparator + a[1] + TimeSeparator + a[2];
end;

function strNicePhone(const S: string): string;
var
    L: Integer;
begin
    if Length(S) > 3 then
    begin
        L := (Length(S) + 1) div 2;
        Result := strNicePhone(strLeft(S, L)) + SPACE + strNicePhone(strRight(S, Length(S) - L));
    end
    else
        Result := S;
end;

function strReplace(const S: string; C: Char; const Replace: string): string;
var
    i: Integer;
begin
    Result := '';
    for i := Length(S) downto 1 do
        if S[i] = C then
            Result := Replace + Result
        else
            Result := S[i] + Result;
end;

function strPos(const aSubstr, S: string; aOfs: Integer): Integer;
begin
    Result := Pos(aSubStr, Copy(S, aOfs, (Length(S) - aOfs) + 1));
    if (Result > 0) and (aOfs > 1) then
        Inc(Result, aOfs - 1);
end;

procedure strChange(var S: string; const Src, Dest: string);
var
    P: Integer;
begin
    P := Pos(Src, S);
    while P <> 0 do
    begin
        Delete(S, P, Length(Src));
        Insert(Dest, S, P);
        Inc(P, Length(Dest));
        P := strPos(Src, S, P);
    end;
end;

function strChangeU(const S, Source, Dest: string): string;
var
    P: Integer;
    aSrc: string;
begin
    Result := S;
    aSrc := strUpper(Source);
    P := Pos(aSrc, strUpper(Result));
    while P <> 0 do
    begin
        Delete(Result, P, Length(Source));
        Insert(Dest, Result, P);
        Inc(P, Length(Dest));
        P := strPos(aSrc, strUpper(Result), P);
    end;
end;

function strCmdLine: string;
var
    i: Integer;
begin
    Result := '';
    for i := 1 to ParamCount do
        Result := Result + ParamStr(i) + ' ';
    Delete(Result, Length(Result), 1);
end;

{ sends a string to debug windows inside the IDE }
{$IFDEF Win32}

procedure strDebug(const S: string);
var
    P: PChar;
    CPS: TCopyDataStruct;
    aWnd: hWnd;
begin
    aWnd := FindWindow('TfrmDbgTerm', nil);
    if aWnd <> 0 then
    begin
        CPS.cbData := Length(S) + 2;
        GetMem(P, CPS.cbData);
        try
            StrPCopy(P, S + CR);
            CPS.lpData := P;
            SendMessage(aWnd, WM_COPYDATA, 0, LParam(@CPS));
        finally
            FreeMem(P, Length(S) + 2);
        end;
    end;
end;
{$ENDIF}

function strSoundex(S: string): string;
const
    CvTable: array['B'..'Z'] of char = (
        '1', '2', '3', '0', '1', {'B' .. 'F'}
        '2', '0', '0', '2', '2', {'G' .. 'K'}
        '4', '5', '5', '0', '1', {'L' .. 'P'}
        '2', '6', '2', '3', '0', {'Q' .. 'U'}
        '1', '0', '2', '0', '2'); {'V' .. 'Z'}
var
    i, j: Integer;
    aGroup, Ch: Char;

    function Group(Ch: Char): Char;
    begin
        if (Ch in ['B'..'Z']) and not (Ch in ['E', 'H', 'I', 'O', 'U', 'W', 'Y']) then
            Result := CvTable[Ch]
        else
            Result := '0';
    end;

begin
    Result := '000';
    if S = '' then
        exit;

    S := strUpper(S);
    i := 2;
    j := 1;
    while (i <= Length(S)) and (j <= 3) do
    begin
        Ch := S[i];
        aGroup := Group(Ch);
        if (aGroup <> '0') and (Ch <> S[i - 1]) and
            ((J = 1) or (aGroup <> Result[j - 1])) and
            ((i > 2) or (aGroup <> Group(S[1]))) then
        begin
            Result[j] := aGroup;
            Inc(j);
        end;
        Inc(i);
    end; {while}

    Result := S[1] + '-' + Result;
end;

function strByteSize(Value: Longint): string;

    function FltToStr(F: Extended): string;
    begin
        Result := FloatToStrF(Round(F), ffNumber, 6, 0);
    end;

begin
    if Value > GBYTE then
        Result := FltTostr(Value / GBYTE) + ' GB'
    else if Value > MBYTE then
        Result := FltToStr(Value / MBYTE) + ' MB'
    else if Value > KBYTE then
        Result := FltTostr(Value / KBYTE) + ' KB'
    else
        Result := FltTostr(Value) + ' Byte'; { 04.08.96 sb }
end;

const
    C1 = 52845;
    C2 = 22719;

function strEncrypt(const S: string; Key: Word): string;
var
    I: Integer;
begin
{$IFDEF Win32}
    SetLength(Result, Length(S));
{$ELSE}
    Result[0] := Chr(Length(S));
{$ENDIF}
    for I := 1 to Length(S) do
    begin
        Result[I] := Char(Ord(S[I]) xor (Key shr 8));
        Key := (Ord(Result[I]) + Key) * C1 + C2;
    end;
end;

function strDecrypt(const S: string; Key: Word): string;
var
    I: Integer;
begin
{$IFDEF Win32}
    SetLength(Result, Length(S));
{$ELSE}
    Result[0] := Chr(Length(S));
{$ENDIF}
    for I := 1 to Length(S) do
    begin
        Result[I] := char(Ord(S[I]) xor (Key shr 8));
        Key := (Ord(S[I]) + Key) * C1 + C2;
    end;
end;

function strLastCh(const S: string): Char;
begin
    Result := S[Length(S)];
end;

procedure strStripLast(var S: string);
begin
    if Length(S) > 0 then
        Delete(S, Length(S), 1);
end;

procedure strSearchReplace(var S: string; const Source, Dest: string; Options: TSRoptions);
var
    hs, hs1, hs2, hs3: string;
var
    i, j: integer;

begin
    if srCase in Options then
    begin
        hs := s;
        hs3 := source;
    end
    else
    begin
        hs := StrUpper(s);
        hs3 := StrUpper(Source);
    end;
    hs1 := '';
    I := pos(hs3, hs);
    j := length(hs3);
    while i > 0 do
    begin
        delete(hs, 1, i + j - 1); {Anfang Rest geändert 8.7.96 KM}
        hs1 := Hs1 + copy(s, 1, i - 1); {Kopieren geändert 8.7.96 KM}
        delete(s, 1, i - 1); {Löschen bis Anfang posgeändert 8.7.96 KM}
        hs2 := copy(s, 1, j); {Bis ende pos Sichern}
        delete(s, 1, j); {Löschen bis ende Pos}
        if (not (srWord in Options))
            or (pos(s[1], ' .,:;-#''+*?=)(/&%$§"!{[]}\~<>|') > 0) then
        begin
            {Quelle durch ziel erstzen}
            hs1 := hs1 + dest;
        end
        else
        begin
            hs1 := hs1 + hs2;
        end;
        if srall in options then
            I := pos(hs3, hs)
        else
            i := 0;
    end;
    s := hs1 + s;
end;

function strProfile(const aFile, aSection, aEntry, aDefault: string): string;
var
    aTmp: array[0..255] of Char;
{$IFNDEF Win32}
    pFile: array[0..200] of char;
    pSection: array[0..100] of char;
    pEntry: array[0..100] of char;
    pDefault: array[0..100] of char;
{$ENDIF}
begin
{$IFDEF Win32}
    GetPrivateProfileString(PChar(aSection), PChar(aEntry),
        PChar(aDefault), aTmp, Sizeof(aTmp) - 1, PChar(aFile));
    Result := StrPas(aTmp);
{$ELSE}
    GetPrivateProfileString(StrPCopy(pSection, aSection),
        StrPCopy(pEntry, aEntry), StrPCopy(pDefault, aDefault),
        aTmp, Sizeof(aTmp) - 1, StrPCopy(pFile, aFile));
    Result := StrPas(aTmp);
{$ENDIF}
end;

function strCapitalize(const S: string): string; { 31.07.96 sb }
var
    i: Integer;
    Ch: Char;
    First: Boolean;
begin
    First := True;
    Result := '';
    for i := 1 to Length(S) do
    begin
        Ch := S[i];
        if Ch in [SPACE, '-', '.'] then
            First := True
        else if First then
        begin
            Ch := strUpper(Ch)[1];
            First := False;
        end;
        Result := Result + Ch;
    end;
end;

{$IFDEF Win32}

function strFileLoad(const aFile: string): string;
var
    aStr: TStrings;
begin
    Result := '';
    aStr := TStringList.Create;
    try
        aStr.LoadFromFile(aFile);
        Result := aStr.Text;
    finally
        aStr.Free;
    end;
end;

procedure strFileSave(const aFile, aString: string);
var
    Stream: TStream;
begin
    Stream := TFileStream.Create(aFile, fmCreate);
    try
        Stream.WriteBuffer(Pointer(aString)^, Length(aString));
    finally
        Stream.Free;
    end;
end;
{$ENDIF}

{ Integer stuff }

function IsInt(s1: string): Boolean;
var
    i: Integer;
begin
    Result := true;
    if Length(s1) > 0 then
    begin
        for i := 1 to Length(s1) do
        begin
            if not (s1[i] in ['0'..'9']) then
            begin
                Result := false;
                Break;
            end;
        end;
    end
    else
        Result := false;
end;

function IntCenter(a, b: Int_): Int_;
begin
    Result := a div 2 - b div 2;
end;

function IntMax(a, b: Int_): Int_;
begin
    if a > b then
        Result := a
    else
        Result := b;
end;

function IntMin(a, b: Int_): Int_;
begin
    if a < b then
        Result := a
    else
        Result := b;
end;

function IntPow(Base, Expo: Integer): Int_;
var
    Loop: Word;
begin
    Result := 1;
    for Loop := 1 to Expo do
        Result := Result * Base;
end;

function IntPow10(Exponent: Integer): Int_;
begin
    Result := IntPow(10, Exponent);
end;

function IntSign(a: Int_): Integer;
begin
    if a < 0 then
        Result := -1
    else if a > 0 then
        Result := +1
    else
        Result := 0;
end;

function IntZero(a: Int_; Len: Integer): string;
begin
    Result := strPadZeroL(IntToStr(a), Len);
end;

function IntPrime(Value: Integer): Boolean;
var
    i: integer;
begin
    Result := False;
    Value := Abs(Value); { 29.10.96 sb }
    if Value mod 2 <> 0 then
    begin
        i := 1;
        repeat
            i := i + 2;
            Result := Value mod i = 0
        until Result or (i > Trunc(sqrt(Value)));
        Result := not Result;
    end;
end;

function IntPercent(a, b: Int_): Int_;
begin
    Result := Trunc((a / b) * 100);
end;

{ Floating point stuff }

function IsFlt(s1: string): Boolean;
var
    i: Integer;
begin
    Result := true;
    if Length(s1) > 0 then
    begin
        for i := 1 to Length(s1) do
        begin
            if not (s1[i] in ['0'..'9', '.']) then
            begin
                Result := false;
                Break;
            end;
        end;
    end
    else
        Result := false;
end;


function FltAdd(P1, P2: Float; Decimals: Integer): Float;
begin
    P1 := fltRound(P1, Decimals);
    P2 := fltRound(P2, Decimals);
    Result := fltRound(P1 + P2, Decimals);
end;

function FltDiv(P1, P2: Float; Decimals: Integer): Float;
begin
    P1 := fltRound(P1, Decimals);
    P2 := fltRound(P2, Decimals);
    if P2 = 0.0 then
        P2 := FLTZERO; { provide division by zero }
    Result := fltRound(P1 / P2, Decimals);
end;

function FltEqual(P1, P2: Float; Decimals: Integer): Boolean;
var
    Diff: Float;
begin
    Diff := fltSub(P1, P2, Decimals);
    Result := fltEqualZero(Diff);
end;

function FltEqualZero(P: Float): Boolean;
begin
    Result := (P >= -FLTZERO) and (P <= FLTZERO); { 29.10.96 sb }
end;

function FltGreaterZero(P: Float): Boolean;
begin
    Result := P > FLTZERO;
end;

function FltLessZero(P: Float): Boolean;
begin
    Result := P < -FLTZERO;
end;

function FltNeg(P: Float; Negate: Boolean): Float;
begin
    if Negate then
        Result := -P
    else
        Result := P;
end;

function FltMul(P1, P2: Float; Decimals: Integer): Float;
begin
    P1 := fltRound(P1, Decimals);
    P2 := fltRound(P2, Decimals);
    Result := fltRound(P1 * P2, Decimals);
end;

function FltRound(P: Float; Decimals: Integer): Float;
var
    Factor: LongInt;
    Help: Float;
begin
    Factor := IntPow10(Decimals);
    if P < 0 then
        Help := -0.5
    else
        Help := 0.5;
    Result := Int(P * Factor + Help) / Factor;
    if fltEqualZero(Result) then
        Result := 0.00;
end;

function FltSub(P1, P2: Float; Decimals: Integer): Float;
begin
    P1 := fltRound(P1, Decimals);
    P2 := fltRound(P2, Decimals);
    Result := fltRound(P1 - P2, Decimals);
end;

function FltUnEqualZero(P: Float): Boolean;
begin
    Result := (P < -FLTZERO) or (P > FLTZERO)
end;

function FltCalc(const Expr: string): Float;
const
    STACKSIZE = 10;
var
    Stack: array[0..STACKSIZE] of Float; { 29.10.96 sb }
    oStack: array[0..STACKSIZE] of char;
    z, n: Float;
    i, j, m: integer;
    Bracket: boolean;
begin
    Bracket := False;
    j := 0;
    n := 1;
    z := 0;
    m := 1;
    for i := 1 to Length(Expr) do
    begin
        if not Bracket then
            case Expr[i] of
                '0'..'9':
                    begin
                        z := z * 10 + ord(Expr[i]) - ord('0');
                        n := n * m;
                    end;
                ',', #46: m := 10;
                '(': Bracket := True; {hier Klammeranfang merken, Zähler!!}
                '*', 'x',
                    'X',
                    '/', '+':
                    begin
                        Stack[j] := z / n;
                        oStack[j] := Expr[i];
                        Inc(j);
                        m := 1;
                        z := 0;
                        n := 1;
                    end;
            end {case}
        else
            Bracket := Expr[i] <> ')'; {hier Rekursiver Aufruf, Zähler !!}
        ;
    end;
    Stack[j] := z / n;
    for i := 1 to j do
        case oStack[i - 1] of
            '*', 'x', 'X': Stack[i] := Stack[i - 1] * Stack[i];
            '/': Stack[i] := Stack[i - 1] / Stack[i];
            '+': Stack[i] := Stack[i - 1] + Stack[i];
        end;
    Result := Stack[j];
end;

function fltPower(a, n: Float): Float;
begin
    Result := Exp(n * Ln(a));
end;

function fltPositiv(Value: Float): Float;
begin
    Result := Value;
    if Value < 0.0 then
        Result := 0.0;
end;

function fltNegativ(Value: Float): Float;
begin
    Result := Value;
    if Value > 0.0 then
        Result := 0.0;
end;

{ Rectangle Calculations }

function RectHeight(const R: TRect): Integer;
begin
    Result := R.Bottom - R.Top;
end;

function RectWidth(const R: TRect): Integer;
begin
    Result := R.Right - R.Left;
end;

procedure RectGrow(var R: TRect; Delta: Integer);
begin
    with R do
    begin
        Dec(Left, Delta);
        Dec(Top, Delta);
        Inc(Right, Delta);
        Inc(Bottom, Delta);
    end;
end;

procedure RectRelativeMove(var R: TRect; DX, DY: Integer);
begin
    with R do
    begin
        Inc(Left, DX);
        Inc(Right, DX);
        Inc(Top, DY);
        Inc(Bottom, DY);
    end;
end;

procedure RectMoveTo(var R: TRect; X, Y: Integer);
begin
    with R do
    begin
        Right := X + Right - Left;
        Bottom := Y + Bottom - Top;
        Left := X;
        Top := Y;
    end;
end;

function RectSet(Left, Top, Right, Bottom: Integer): TRect;
begin
    Result.Left := Left;
    Result.Top := Top;
    Result.Right := Right;
    Result.Bottom := Bottom;
end;

function RectSetPoint(const TopLeft, BottomRight: TPoint): TRect;
begin
    Result.TopLeft := TopLeft;
    Result.BottomRight := BottomRight;
end;

function RectInclude(const R1, R2: TRect): Boolean;
begin
    Result := (R1.Left >= R2.Left) and (R1.Top >= R2.Top)
        and (R1.Right <= R2.Right) and (R1.Bottom <= R2.Bottom);
end;

function RectPoint(const R: TRect; P: TPoint): Boolean;
begin
    Result := (p.x > r.left) and (p.x < r.right) and (p.y > r.top) and (p.y < r.bottom);
end;

function RectIntersection(const R1, R2: TRect): TRect;
begin
    with Result do
    begin
        Left := intMax(R1.Left, R2.Left);
        Top := intMax(R1.Top, R2.Top);
        Right := intMin(R1.Right, R2.Right);
        Bottom := intMin(R1.Bottom, R2.Bottom);
    end;

    if not RectIsValid(Result) then
        Result := RectSet(0, 0, 0, 0);
end;

function RectIsIntersection(const R1, R2: TRect): Boolean;
begin
    Result := not RectIsNull(RectIntersection(R1, R2));
end;

function RectIsValid(const R: TRect): Boolean;
begin
    with R do
        Result := (Left <= Right) and (Top <= Bottom);
end;

function RectsAreValid(const Arr: array of TRect): Boolean;
var
    I: Integer;
begin
    for I := Low(Arr) to High(Arr) do
        if not RectIsValid(Arr[I]) then
        begin
            Result := False;
            exit;
        end;
    Result := True;
end;

function RectNull: TRect;
begin
    Result := RectSet(0, 0, 0, 0);
end;

function RectIsNull(const R: TRect): Boolean;
begin
    with R do
        Result := (Left = 0) and (Right = 0) and (Top = 0) and (Bottom = 0);
end;

function RectIsSquare(const R: TRect): Boolean;
begin
    Result := RectHeight(R) = RectWidth(R);
end;

function RectCentralPoint(const R: TRect): TPoint;
begin
    Result.X := R.Left + (RectWidth(R) div 2);
    Result.Y := R.Top + (RectHeight(R) div 2);
end;

function rectBounds(aLeft, aTop, aWidth, aHeight: Integer): TRect;
begin
    Result := rectSet(aLeft, aTop, aLeft + aWidth, aTop + aHeight);
end;

{ variant functions }

{$IFDEF Win32}

function varIIF(aTest: Boolean; TrueValue, FalseValue: Variant): Variant;
begin
    if aTest then
        Result := TrueValue
    else
        Result := FalseValue;
end;

procedure varDebug(const V: Variant);
begin
    strDebug(varToStr(v));
end;

function varToStr(const V: Variant): string;
begin
    case TVarData(v).vType of
        varSmallInt: Result := IntToStr(TVarData(v).VSmallInt);
        varInteger: Result := IntToStr(TVarData(v).VInteger);
        varSingle: Result := FloatToStr(TVarData(v).VSingle);
        varDouble: Result := FloatToStr(TVarData(v).VDouble);
        varCurrency: Result := FloatToStr(TVarData(v).VCurrency);
        varDate: Result := DateToStr(TVarData(v).VDate);
        varBoolean: Result := varIIf(TVarData(v).VBoolean, 'True', 'False');
        varByte: Result := IntToStr(TVarData(v).VByte);
        varString: Result := StrPas(TVarData(v).VString);
        varEmpty,
            varNull,
            varVariant,
            varUnknown,
            varTypeMask,
            varArray,
            varByRef,
            varDispatch,
            varError: Result := '';
    end;
end;

{$ENDIF}

{ file functions }

procedure fileShredder(const Filename: string);
var
    aFile: Integer;
    aSize: Integer;
    P: Pointer;
begin
    aSize := fileSize(Filename);
    aFile := FileOpen(FileName, fmOpenReadWrite);
    try
        Getmem(P, aSize);
        fillchar(P^, aSize, 'X');
        FileWrite(aFile, P^, aSize);
        Freemem(P, aSize);
    finally
        FileClose(aFile);
        DeleteFile(Filename);
    end;
end;

function fileSize(const FileName: string): LongInt;
var
    SearchRec: TSearchRec;
begin { !Win32! -> GetFileSize }
    if FindFirst(FileName, faAnyFile, SearchRec) = 0 then
        Result := SearchRec.Size
    else
        Result := 0;
end;

function fileWildcard(const Filename: string): Boolean;
begin
    Result := (Pos('*', Filename) <> 0) or (Pos('?', Filename) <> 0);
end;

function fileShellOpen(const aFile: string): Boolean;
var
    Tmp: array[0..100] of char;
begin
    Result := ShellExecute(Application.Handle,
        'open', StrPCopy(Tmp, aFile), nil, nil, SW_NORMAL) > 32;
end;

function fileShellPrint(const aFile: string): Boolean;
var
    Tmp: array[0..100] of char;
begin
    Result := ShellExecute(Application.Handle,
        'print', StrPCopy(Tmp, aFile), nil, nil, SW_HIDE) > 32;
end;

function fileCopy(const SourceFile, TargetFile: string): Boolean;
const
    BlockSize = 1024 * 16;
var
    FSource, FTarget: Integer;
   // FFileSize: Longint;
    BRead, Bwrite: Word;
    Buffer: Pointer;
begin
    Result := False;
    FSource := FileOpen(SourceFile, fmOpenRead + fmShareDenyNone); { Open Source }
    if FSource >= 0 then
    try
        //FFileSize := FileSeek(FSource, 0, soFromEnd);
        FTarget := FileCreate(TargetFile); { Open Target }
        try
            getmem(Buffer, BlockSize);
            try
                FileSeek(FSource, 0, soFromBeginning);
                repeat
                    BRead := FileRead(FSource, Buffer^, BlockSize);
                    BWrite := FileWrite(FTarget, Buffer^, Bread);
                until (Bread = 0) or (Bread <> BWrite);
                if Bread = Bwrite then
                    Result := True;
            finally
                freemem(Buffer, BlockSize);
            end;
            FileSetDate(FTarget, FileGetDate(FSource));
        finally
            FileClose(FTarget);
        end;
    finally
        FileClose(FSource);
    end;
end;

{$IFDEF Win32}

function fileTemp(const aExt: string): string;
var
    Buffer: array[0..1023] of Char;
    aFile: string;
begin
    GetTempPath(Sizeof(Buffer) - 1, Buffer);
    GetTempFileName(Buffer, 'TMP', 0, Buffer);
    SetString(aFile, Buffer, StrLen(Buffer));
    Result := ChangeFileExt(aFile, aExt);
    RenameFile(aFile, Result);
end;

function fileExec(const aCmdLine: string; aHide, aWait: Boolean): Boolean;
var
    StartupInfo: TStartupInfo;
    ProcessInfo: TProcessInformation;
begin
    {setup the startup information for the application }
    FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
    with StartupInfo do
    begin
        cb := SizeOf(TStartupInfo);
        dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
        if aHide then
            wShowWindow := SW_HIDE
        else
            wShowWindow := SW_SHOWNORMAL;
    end;

    Result := CreateProcess(nil, PChar(aCmdLine), nil, nil, False,
        NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo);
    if aWait then
        if Result then
        begin
            WaitForInputIdle(ProcessInfo.hProcess, INFINITE);
            WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
        end;
end;

function fileRedirectExec(const aCmdLine: string; Strings: TStrings): Boolean;
var
    StartupInfo: TStartupInfo;
    ProcessInfo: TProcessInformation;
    aOutput: Integer;
    aFile: string;
begin
    Strings.Clear;

    { Create temp. file for output }
    aFile := FileTemp('.tmp');
    aOutput := FileCreate(aFile);
    try
        {setup the startup information for the application }
        FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
        with StartupInfo do
        begin
            cb := SizeOf(TStartupInfo);
            dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK or
                STARTF_USESTDHANDLES;
            wShowWindow := SW_HIDE;
            hStdInput := INVALID_HANDLE_VALUE;
            hStdOutput := aOutput;
            hStdError := INVALID_HANDLE_VALUE;
        end;

        Result := CreateProcess(nil, PChar(aCmdLine), nil, nil, False,
            NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo);
        if Result then
        begin
            WaitForInputIdle(ProcessInfo.hProcess, INFINITE);
            WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
        end;
    finally
        FileClose(aOutput);
        Strings.LoadFromFile(aFile);
        DeleteFile(aFile);
    end;
end;

function fileLongName(const aFile: string): string;
var
    aInfo: TSHFileInfo;
begin
    if SHGetFileInfo(PChar(aFile), 0, aInfo, Sizeof(aInfo), SHGFI_DISPLAYNAME) <> 0 then
        Result := StrPas(aInfo.szDisplayName)
    else
        Result := aFile;
end;

function fileTypeName(const aFile: string): string;
var
    aInfo: TSHFileInfo;
begin
    if SHGetFileInfo(PChar(aFile), 0, aInfo, Sizeof(aInfo), SHGFI_TYPENAME) <> 0 then
        Result := StrPas(aInfo.szTypeName)
    else
    begin
        Result := ExtractFileExt(aFile);
        Delete(Result, 1, 1);
        Result := strUpper(Result) + ' File';
    end;
end;

function fileShortName(const aFile: string): string;
var
    aTmp: array[0..255] of char;
begin
    if GetShortPathName(PChar(aFile), aTmp, Sizeof(aTmp) - 1) = 0 then
        Result := aFile
    else
        Result := StrPas(aTmp);
end;

{$ENDIF}

function ExtractName(const Filename: string): string;
var
    aExt: string;
    aPos: Integer;
begin
    aExt := ExtractFileExt(Filename);
    Result := ExtractFileName(Filename);
    if aExt <> '' then
    begin
        aPos := Pos(aExt, Result);
        if aPos > 0 then
            Delete(Result, aPos, Length(aExt));
    end;
end;

{ date calculations }

function dateYear(D: TDateTime): Integer;
var
    Year, Month, Day: Word;
begin
    DecodeDate(D, Year, Month, Day);
    Result := Year;
end;

function dateMonth(D: TDateTime): Integer;
var
    Year, Month, Day: Word;
begin
    DecodeDate(D, Year, Month, Day);
    Result := Month;
end;

function dateBeginOfYear(D: TDateTime): TDateTime;
var
    Year, Month, Day: Word;
begin
    DecodeDate(D, Year, Month, Day);
    Result := EncodeDate(Year, 1, 1);
end;

function dateEndOfYear(D: TDateTime): TDateTime;
var
    Year, Month, Day: Word;
begin
    DecodeDate(D, Year, Month, Day);
    Result := EncodeDate(Year, 12, 31);
end;

function dateBeginOfMonth(D: TDateTime): TDateTime;
var
    Year, Month, Day: Word;
begin
    DecodeDate(D, Year, Month, Day);
    Result := EncodeDate(Year, Month, 1);
end;

function dateEndOfMonth(D: TDateTime): TDateTime;
var
    Year, Month, Day: Word;
begin
    DecodeDate(D, Year, Month, Day);
    if Month = 12 then
    begin
        Inc(Year);
        Month := 1;
    end
    else
        Inc(Month);
    Result := EncodeDate(Year, Month, 1) - 1;
end;

function dateWeekOfYear(D: TDateTime): Integer; { Armin Hanisch }
const
    t1: array[1..7] of ShortInt = (-1, 0, 1, 2, 3, -3, -2);
    t2: array[1..7] of ShortInt = (-4, 2, 1, 0, -1, -2, -3);
var
    doy1,
        doy2: Integer;
    NewYear: TDateTime;
begin
    NewYear := dateBeginOfYear(D);
    doy1 := dateDayofYear(D) + t1[DayOfWeek(NewYear)];
    doy2 := dateDayofYear(D) + t2[DayOfWeek(D)];
    if doy1 <= 0 then
        Result := dateWeekOfYear(NewYear - 1)
    else if (doy2 >= dateDayofYear(dateEndOfYear(NewYear))) then
        Result := 1
    else
        Result := (doy1 - 1) div 7 + 1;
end;

function dateDayOfYear(D: TDateTime): Integer;
begin
    Result := Trunc(D - dateBeginOfYear(D)) + 1;
end;

function dateDayOfWeek(D: TDateTime): TDayOfWeek;
begin
    Result := TDayOfWeek(Pred(DayOfWeek(D)));
end;

function dateLeapYear(D: TDateTime): Boolean;
var
    Year, Month, Day: Word;
begin
    DecodeDate(D, Year, Month, Day);
    Result := (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0));
end;

function dateBeginOfQuarter(D: TDateTime): TDateTime;
var
    Year, Month, Day: Word;
begin
    DecodeDate(D, Year, Month, Day);
    Result := EncodeDate(Year, ((Month - 1 div 3) * 3) + 1, 1);
end;

function dateEndOfQuarter(D: TDateTime): TDateTime;
begin
    Result := dateBeginOfQuarter(dateBeginOfQuarter(D) + (3 * 31)) - 1;
end;

function dateBeginOfWeek(D: TDateTime; Weekday: Integer): TDateTime;
begin
    Result := D;
    while DayOfWeek(Result) <> Weekday do
        Result := Result - 1;
end;

function dateDaysInMonth(D: TDateTime): Integer;
const
    DaysPerMonth: array[1..12] of Byte = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var
    Month: Integer;
begin
    Month := dateMonth(D);
    Result := DaysPerMonth[Month];
    if (Month = 2) and dateLeapYear(D) then
        Inc(Result);
end;

function dateDay(D: TDateTime): Integer;
var
    Year, Month, Day: Word;
begin
    DecodeDate(D, Year, Month, Day);
    Result := Day;
end;

function dateQuicken(D: TDateTime; var Key: Char): TDateTime;
const
{$IFDEF German}
    _ToDay = 'H';
    _PrevYear = 'J';
    _NextYear = 'R';
    _PrevMonth = 'M';
    _NextMonth = 'T';
    _BeginQuart = 'Q';
    _EndQuart = 'U';
{$ELSE}
    _ToDay = 'T';
    _PrevYear = 'Y';
    _NextYear = 'R';
    _PrevMonth = 'M';
    _NextMonth = 'H';
    _BeginQuart = 'Q';
    _EndQuart = 'U';
{$ENDIF}
begin
    case Upcase(Key) of { Quicken Date Fast Keys }
        '+': Result := D + 1;
        '-': Result := D - 1;
        _ToDay: Result := Date;
        _PrevYear: if D <> dateBeginOfYear(D) then
                Result := dateBeginOfYear(D)
            else
                Result := dateBeginOfYear(D - 1);
        _NextYear: if D <> dateEndOfYear(D) then
                Result := dateEndOfYear(D)
            else
                Result := dateEndOfYear(Date + 1);
        _PrevMonth: if D <> dateBeginOfMonth(D) then
                Result := dateBeginOfMonth(D)
            else
                Result := dateBeginOfMonth(D - 1);
        _NextMonth: if D <> dateEndOfMonth(D) then
                Result := dateEndOfMonth(D)
            else
                Result := dateEndOfMonth(D + 1);
        _BeginQuart: Result := dateBeginOfQuarter(D);
        _EndQuart: Result := dateEndOfQuarter(D);
    else
        begin
            Result := D;
            exit;
        end;
    end;
    Key := #0;
end;

{ time functions }

function timeHour(T: TDateTime): Integer;
var
    Hour, Minute, Sec, Sec100: Word;
begin
    DecodeTime(T, Hour, Minute, Sec, Sec100);
    Result := Hour;
end;

function timeMin(T: TDateTime): Integer;
var
    Hour, Minute, Sec, Sec100: Word;
begin
    DecodeTime(T, Hour, Minute, Sec, Sec100);
    Result := Minute;
end;

function timeSec(T: TDateTime): Integer;
var
    Hour, Minute, Sec, Sec100: Word;
begin
    DecodeTime(T, Hour, Minute, Sec, Sec100);
    Result := Sec;
end;

function timeToInt(T: TDateTime): Integer;
begin
    Result := Trunc((MSecsPerday * T) / 1000);
end;

{$IFDEF Win32}

{$WARNINGS OFF}
function timeZoneOffset: Integer;
var
    aTimeZoneInfo: TTimeZoneInformation;
begin
    if GetTimeZoneInformation(aTimeZoneInfo) <> -1 then
        Result := aTimeZoneInfo.Bias
    else
        Result := 0;
end;
{$WARNINGS ON}
{$ENDIF}

{ Communications Functions }

function comIsCis(const S: string): Boolean;
var
    aSt: string;
    PreId,
        PostId: Integer;
begin
    Result := strContainsU('@compuserve.com', S); { 28.7.96 sb This is also on CIS }
    if not Result then
        if Pos(',', S) > 0 then
        try
            aSt := S;
            PreId := StrToInt(strToken(aSt, ','));
            PostId := StrToInt(aSt);
            Result := (PreId > 0) and (PostId > 0);
        except
            Result := False;
        end;
end;

function comIsInt(const S: string): Boolean;
var
    aSt: string;
    PreId,
        PostId: string;
begin
    try
        aSt := S;
        PreId := strToken(aSt, '@');
        PostId := aSt;
        Result := (Length(PreId) > 0) and (Length(PostId) > 0);
    except
        Result := False;
    end;
end;

{ converts a CIS adress to a correct Internet adress }

function comCisToInt(const S: string): string;
var
    P: Integer;
begin
    p := Pos('INTERNET:', S);
    if P = 1 then
        Result := Copy(S, P + 1, Length(S))
    else
    begin
        Result := S;
        P := Pos(',', Result);
        if P > 0 then
            Result[P] := '.';
        Result := Result + '@compuserve.com'; { 22.07.96 sb  Error }
    end;
end;

{ converts a internet adress to a correct CServe adress }

function comIntToCis(const S: string): string;
var
    P: Integer;
begin
    p := Pos('@COMPUSERVE.COM', strUpper(S));
    if p > 0 then
    begin
        Result := strLeft(S, P - 1);
        P := Pos('.', Result);
        if P > 0 then
            Result[P] := ',';
    end
    else
        Result := 'INTERNET:' + S;
end;

{ converts a fax adress to a correct CServe adress }

function comFaxToCis(const S: string): string;
begin
    Result := 'FAX:' + S;
end;

function comNormFax(const Name, Fax: string): string;
begin
    if Name <> '' then
        Result := Name + '[fax: ' + Name + '@' + strTrim(Fax) + ']'
    else
        Result := '[fax: ' + strTrim(Fax) + ']';
end;

function comNormInt(const Name, Int: string): string;
begin
    Result := '';
    if comIsInt(Int) then
        if Name <> '' then
            Result := Name + '|smtp: ' + strTrim(Int)
        else
            Result := 'smtp: ' + strTrim(Int);
end;

function comNormCis(const Name, Cis: string): string;
begin
    Result := '';
    if Name <> '' then
        Result := Name + '[compuserve: ' + strTrim(Cis) + ']'
    else
        Result := '[compuserve: ' + strTrim(Cis) + ']';
end;

function comNormPhone(const Phone: string): string;

    function strValueAt(const S: string; At: Integer): string;
    const
        Seperator = ',';
        Str = '"';
    var
        j, i: Integer;
        FSkip: Boolean;
    begin
        Result := '';
        j := 1;
        i := 0;
        FSkip := False;
        while (i <= At) and (j <= Length(S)) do
        begin
            if (S[j] = Str) then
                FSkip := not FSkip
            else if (S[j] = Seperator) and not FSkip then
                Inc(i)
            else if i = At then
                Result := Result + S[j];
            Inc(j);
        end;
    end;

var
    aNumber,
        aCountry,
        aPrefix,
        aDefault,
        aLocation: string;

    i: Integer;
begin
    aDefault := '1,"Hamburg","","","40",49,0,0,0,"",1," "';
    aLocation := strProfile('telephon.ini', 'Locations', 'CurrentLocation', '');
    if aLocation <> '' then
    begin
        aLocation := strTokenAt(aLocation, ',', 0);
        if aLocation <> '' then
        begin
            aLocation := strProfile('telephon.ini', 'Locations', 'Location' + aLocation, '');
            if aLocation <> '' then
                aDefault := aLocation;
        end;
    end;

    Result := '';
    aNumber := strTrim(Phone);
    if aNumber <> '' then
        for i := Length(aNumber) downto 1 do
            if not (aNumber[i] in DIGITS) then
            begin
                if aNumber[i] <> '+' then
                    aNumber[i] := '-';
                if i < Length(aNumber) then { remove duplicate digits }
                    if aNumber[i] = aNumber[i + 1] then
                        Delete(aNumber, i, 1);
            end;

    if aNumber <> '' then
    begin
        if aNumber[1] = '+' then
            aCountry := strToken(aNumber, '-')
        else
            aCountry := '+' + strValueAt(aDefault, 5);

        aNumber := strTrimChL(aNumber, '-');

        if aNumber <> '' then
        begin
            if strTokenCount(aNumber, '-') > 1 then
                aPrefix := strTrimChL(strToken(aNumber, '-'), '0')
            else
                aPrefix := strValueAt(aDefault, 4);

            aNumber := strNicePhone(strTrimChA(aNumber, '-'));
            Result := aCountry + ' (' + aPrefix + ') ' + aNumber;
        end;
    end;
end;

{ system functions }

{$IFDEF Win32}

function sysTempPath: string;
var
    Buffer: array[0..1023] of Char;
begin
    SetString(Result, Buffer, GetTempPath(Sizeof(Buffer) - 1, Buffer));
end;
{$ELSE}

function sysTempPath: string;
var
    Buffer: array[0..255] of char;
begin
    GetTempFileName(#0, 'TMP', 0, Buffer); { 15.07.96 sb }
    Result := StrPas(Buffer);
    DeleteFile(Result);
    Result := ExtractFilePath(Result);
end;
{$ENDIF}

procedure sysDelay(aMs: Longint);
var
    TickCountNow, TickCountStart: LongInt;
begin
    TickCountStart := GetTickCount;
    TickCountNow := GetTickCount;
    while TickCountNow - TickCountStart < aMs do
    begin
        TickCountNow := GetTickCount;
        Application.ProcessMessages
    end;
end;

procedure sysBeep;
begin
    messageBeep($FFFF);
end;

function sysColorDepth: Integer;
var
    aDC: hDC;
begin
    aDC := GetDC(0);
    try
        Result := 1 shl (GetDeviceCaps(aDC, PLANES) * GetDeviceCaps(aDC, BITSPIXEL));
    finally
        ReleaseDC(0, aDC);
    end;
end;

{$IFDEF Win32}

function GetShellFoldername(folderID: Integer): string;
var
    pidl: PItemIDList;
    buf: array[0..MAX_PATH] of Char;
begin
    Result := '';
    if Succeeded(ShGetSpecialFolderLocation(GetActiveWindow, folderID, pidl)) then
    begin
        if ShGetPathfromIDList(pidl, buf) then
            Result := buf;
        CoTaskMemFree(pidl);
    end; { If }

    if Result = '' then
    begin
        Result := ExtractFileDir(Application.ExeName);
    end;

end; { GetShellFoldername }

procedure sysSaverRunning(Active: Boolean);
var
    aParam: Longint;
begin
    SystemParametersInfo(SPI_SCREENSAVERRUNNING, Word(Active), @aParam, 0);
end;
{$ENDIF}

{ registry functions }

{$IFDEF Win32 }

procedure regParsePath(const Path: string; var aPath, aValue: string);
begin
    aPath := Path;
    aValue := '';
    while (Length(aPath) > 0) and (strLastCh(aPath) <> '\') do
    begin
        aValue := strLastCh(aPath) + aValue;
        strStripLast(aPath);
    end;
end;

function regReadString(aKey: HKEY; const Path: string): string;
var
    aRegistry: TRegistry;
    aPath: string;
    aValue: string;
begin
    aRegistry := TRegistry.Create;
    try
        with aRegistry do
        begin
            RootKey := aKey;
            regParsePath(Path, aPath, aValue);
            OpenKey(aPath, True);
            Result := ReadString(aValue);
        end;
    finally
        aRegistry.Free;
    end;
end;

procedure regWriteString(aKey: HKEY; const Path, Value: string);
var
    aRegistry: TRegistry;
    aPath: string;
    aValue: string;
begin
    aRegistry := TRegistry.Create;
    try
        with aRegistry do
        begin
            RootKey := aKey;
            regParsePath(Path, aPath, aValue);
            OpenKey(aPath, True);
            WriteString(aValue, Value);
        end;
    finally
        aRegistry.Free;
    end;
end;

procedure regDelValue(aKey: hKey; const Path: string);
var
    aRegistry: TRegistry;
    aPath: string;
    aValue: string;
begin
    aRegistry := TRegistry.Create;
    try
        with aRegistry do
        begin
            RootKey := aKey;
            regParsePath(Path, aPath, aValue);
            OpenKey(aPath, True);
            DeleteValue(aValue);
        end;
    finally
        aRegistry.Free;
    end;
end;

(*!!!
function regReadString(aKey: hKey; const Value: String): String;
var
  aTmp  : array[0..255] of char;
  aCb,
  aType : Integer;
begin
  Result:='';
  if aKey<> 0 then
  begin
    aCb:=Sizeof(aTmp)-1;
   { aData:=@aTmp; }
    if RegQueryValueEx(aKey,PChar(Value),nil,@aType,@aTmp,@aCb)=ERROR_SUCCESS then
       if aType=REG_SZ then Result:=String(aTmp);
  end;
end; *)

function regInfoString(const Value: string): string;
var
    aKey: hKey;
begin
    Result := '';
    if RegOpenKey(HKEY_LOCAL_MACHINE, REG_CURRENT_VERSION, aKey) = ERROR_SUCCESS then
    begin
        Result := regReadString(aKey, Value);
        RegCloseKey(aKey);
    end;
end;

function regCurrentUser: string;
begin
    Result := regInfoString(REG_CURRENT_USER);
end;

function regCurrentCompany: string;
begin
    Result := regInfoString(REG_CURRENT_COMPANY);
end;

{ Add a shell extension to the registry }

procedure regWriteShellExt(const aExt, aCmd, aMenu, aExec: string);
var
    s, aPath: string;
begin
    with TRegistry.Create do
    try
        RootKey := HKEY_CLASSES_ROOT;
        aPath := aExt;
        if KeyExists(aPath) then
        begin
            OpenKey(aPath, False);
            S := ReadString('');
            CloseKey;
            if S <> '' then
                if KeyExists(S) then
                    aPath := S;
        end;

        OpenKey(aPath + '\Shell\' + aCmd, True);
        WriteString('', aMenu);
        CloseKey;

        OpenKey(aPath + '\Shell\' + aCmd + '\Command', True);
        WriteString('', aExec + ' %1');
        CloseKey;
    finally
        Free;
    end;
end;

procedure regValueList(aKey: HKEY; const Path: string; var aValue: TStringList);
var
    aRegistry: TRegistry;
begin
    aRegistry := TRegistry.Create;
    try
        with aRegistry do
        begin
            RootKey := aKey;
            OpenKey(Path, True);
            GetValueNames(aValue);
        end;
    finally
        aRegistry.Free;
    end;
end;

procedure regKeyList(aKey: HKEY; const Path: string; var aValue: TStringList);
var
    aRegistry: TRegistry;
begin
    aRegistry := TRegistry.Create;
    try
        with aRegistry do
        begin
            RootKey := aKey;
            OpenKey(Path, True);
            GetKeyNames(aValue);
        end;
    finally
        aRegistry.Free;
    end;
end;

function regValueExist(aKey: HKEY; const Path: string): Boolean;
var
    aRegistry: TRegistry;
    aPath: string;
    aValue: string;
begin
    aRegistry := TRegistry.Create;
    try
        with aRegistry do
        begin
            RootKey := aKey;
            regParsePath(Path, aPath, aValue);
            OpenKey(aPath, True);
            Result := ValueExists(aValue)
        end;
    finally
        aRegistry.Free;
    end;
end;

function regReadValue(aKey: HKEY; const Path: string; Typ: TDataType): Variant;
var
    aRegistry: TRegistry;
    aPath: string;
    aValue: string;
begin
    aRegistry := TRegistry.Create;
    try
        with aRegistry do
        begin
            RootKey := aKey;
            regParsePath(Path, aPath, aValue);
            if OpenKey(aPath, True) then
                if ValueExists(aValue) then
                    case Typ of
                        dtInteger: Result := ReadInteger(aValue);
                        dtBoolean: Result := ReadBool(aValue);
                        dtString: Result := ReadString(aValue);
                        dtDate: Result := ReadDate(aValue);
                        dtFloat: Result := ReadFloat(aValue);
                        dtCurrency: Result := ReadCurrency(aValue);
                        dtTime: Result := REadTime(aValue);
                    end;
        end;
    finally
        aRegistry.Free;
    end;
end;

function regWriteValue(aKey: HKEY; const Path: string; Value: Variant; Typ: TDataType): Boolean;
var
    aRegistry: TRegistry;
    aPath: string;
    aValue: string;
begin
    aRegistry := TRegistry.Create;
    try
        with aRegistry do
        begin
            RootKey := aKey;
            regParsePath(Path, aPath, aValue);
            if OpenKey(aPath, True) then
                case Typ of
                    dtInteger: WriteInteger(aValue, Value);
                    dtBoolean: WriteBool(aValue, Value);
                    dtString: WriteString(aValue, Value);
                    dtDate: WriteDate(aValue, Value);
                    dtFloat: WriteFloat(aValue, Value);
                    dtCurrency: WriteCurrency(aValue, Value);
                    dtTime: WriteTime(aValue, Value);
                end
	    else
		raise Exception.CreateFmt('', []);
	end;
    except
	begin
	    Result := false;
	    aRegistry.Free;
	    exit;
	end
    end;
    Result := True;
    aRegistry.Free;
end;

{$ENDIF}

{ other stuff }

function MsgBox(const aTitle, aMsg: string; aFlag: Integer): Integer;
var
    ActiveWindow: hWnd;
    WindowList: Pointer;
    TmpA: array[0..200] of char;
    TmpB: array[0..100] of char;
begin
    ActiveWindow := GetActiveWindow;
    WindowList := DisableTaskWindows(0);
    try
        StrPCopy(TmpB, aTitle);
        StrPCopy(TmpA, aMsg);
{$IFDEF Win32}
        Result := Windows.MessageBox(Application.Handle, TmpA, TmpB, aFlag);
{$ELSE}
        Result := WinProcs.MessageBox(Application.Handle, TmpA, TmpB, aFlag);
{$ENDIF}
    finally
        EnableTaskWindows(WindowList);
        SetActiveWindow(ActiveWindow);
    end;
end;

{ TPersistentRect }

constructor TPersistentRect.Create;
begin
    FRect := rectSet(10, 10, 100, 20);
end;

procedure TPersistentRect.Assign(Source: TPersistent);
var
    Value: TPersistentRect;
begin
    Value := nil;
    if Value is TPersistentRect then
    begin
        Value := Source as TPersistentRect;
        FRect := rectBounds(Value.Left, Value.Top, Value.Width, Value.Height);
        exit;
    end;
    inherited Assign(Source);
end;

procedure TPersistentRect.SetLeft(Value: Integer);
begin
    if Value <> Left then
    begin
        if Assigned(FOnConvert) then
            Value := FOnConvert(Self, Value, False);
        FRect := rectBounds(Value, Top, Width, Height);
    end;
end;

procedure TPersistentRect.SetTop(Value: Integer);
begin
    if Value <> Top then
    begin
        if Assigned(FOnConvert) then
            Value := FOnConvert(Self, Value, False);
        FRect := rectBounds(Left, Value, Width, Height);
    end;
end;

procedure TPersistentRect.SetHeight(Value: Integer);
begin
    if Value <> Height then
    begin
        if Assigned(FOnConvert) then
            Value := FOnConvert(Self, Value, False);
        FRect := rectBounds(Left, Top, Width, Value);
    end;
end;

procedure TPersistentRect.SetWidth(Value: Integer);
begin
    if Value <> Width then
    begin
        if Assigned(FOnConvert) then
            Value := FOnConvert(Self, Value, False);
        FRect := rectBounds(Left, Top, Value, Height);
    end;
end;

function TPersistentRect.GetLeft: Integer;
begin
    Result := FRect.Left;
    if Assigned(FOnConvert) then
        Result := FOnConvert(Self, Result, True);
end;

function TPersistentRect.GetTop: Integer;
begin
    Result := FRect.Top;
    if Assigned(FOnConvert) then
        Result := FOnConvert(Self, Result, True);
end;

function TPersistentRect.GetHeight: Integer;
begin
    Result := rectHeight(FRect);
    if Assigned(FOnConvert) then
        Result := FOnConvert(Self, Result, True);
end;

function TPersistentRect.GetWidth: Integer;
begin
    Result := rectWidth(FRect);
    if Assigned(FOnConvert) then
        Result := FOnConvert(Self, Result, True);
end;

{$IFDEF Win32}

{ TPersistentRegistry }
{$IFDEF PLUGIN_BUILD}{$HINTS OFF}{$ENDIF}
function TPersistentRegistry.ReadComponent(const Name: string;
    Owner, Parent: TComponent): TComponent;
var
    DataSize: Integer;
    MemStream: TMemoryStream;
    Reader: TReader;
begin
    Result := nil;
    DataSize := GetDataSize(Name);
    MemStream := TMemoryStream.Create;
    try
        MemStream.SetSize(DataSize);
        ReadBinaryData(Name, MemStream.Memory^, DataSize);
        MemStream.Position := 0;

        Reader := TReader.Create(MemStream, 256);
        try
            Reader.Parent := Parent;
            Result := Reader.ReadRootComponent(nil);
            if Owner <> nil then
            try
                Owner.InsertComponent(Result);
            except
                Result.Free;
                raise;
            end;
        finally
            Reader.Free;
        end;

    finally
        MemStream.Free;
    end;
end;
{$IFDEF PLUGIN_BUILD}{$HINTS ON}{$ENDIF}

procedure TPersistentRegistry.WriteComponent(const Name: string; Component: TComponent);
var
    MemStream: TMemoryStream;
begin
    MemStream := TMemoryStream.Create;
    try
        MemStream.WriteComponent(Component);
        WriteBinaryData(Name, MemStream.Memory^, MemStream.Size);
    finally
        MemStream.Free;
    end;
end;

{$ENDIF}

{ TSystemMetric }

constructor TSystemMetric.Create;
begin
    inherited Create;
    Update;
end;

procedure TSystemMetric.Update;

    function GetSystemPoint(ax, ay: Integer): TPoint;
    begin
        Result := Point(GetSystemMetrics(ax), GetSystemMetrics(ay));
    end;

begin
    FMenuHeight := GetSystemMetrics(SM_CYMENU);
    FCaptionHeight := GetSystemMetrics(SM_CYCAPTION);
    FBorder := GetSystemPoint(SM_CXBORDER, SM_CYBORDER);
    FFrame := GetSystemPoint(SM_CXFRAME, SM_CYFRAME);
    FDlgFrame := GetSystemPoint(SM_CXDLGFRAME, SM_CYDLGFRAME);
    FBitmap := GetSystemPoint(SM_CXSIZE, SM_CYSIZE);
    FHScroll := GetSystemPoint(SM_CXHSCROLL, SM_CYHSCROLL);
    FVScroll := GetSystemPoint(SM_CXVSCROLL, SM_CYVSCROLL);
    FThumb := GetSystemPoint(SM_CXHTHUMB, SM_CYVTHUMB);
    FFullScreen := GetSystemPoint(SM_CXFULLSCREEN, SM_CYFULLSCREEN);
    FMin := GetSystemPoint(SM_CXMIN, SM_CYMIN);
    FMinTrack := GetSystemPoint(SM_CXMINTRACK, SM_CYMINTRACK);
    FCursor := GetSystemPoint(SM_CXCURSOR, SM_CYCURSOR);
    FIcon := GetSystemPoint(SM_CXICON, SM_CYICON);
    FDoubleClick := GetSystemPoint(SM_CXDOUBLECLK, SM_CYDOUBLECLK);
    FIconSpacing := GetSystemPoint(SM_CXICONSPACING, SM_CYICONSPACING);
    FColorDepth := sysColorDepth;
end;

{ TDesktopCanvas }

constructor TDesktopCanvas.Create;
begin
    inherited Create;
    DC := GetDC(0);
    Handle := DC;
end;

destructor TDesktopCanvas.Destroy;
begin
    Handle := 0;
    ReleaseDC(0, DC);
    inherited Destroy;
end;

{$IFNDEF Win32}

procedure DoneXProcs; far;
begin
    SysMetric.Free;
end;

{$ENDIF}

{$IFDEF Win32}

function CheckNT: Boolean;
var
    aVersion: TOSVersionInfo;
begin
    aVersion.dwOSVersionInfoSize := SizeOf(aVersion);
    Result := GetVersionEx(aVersion) and (aVersion.dwPLatformId = VER_PLATFORM_WIN32_NT);
end;
{$ENDIF}

{inetFunctions}

procedure OpenURL(const URL: string);
{ Opens URL }

{$IFNDEF WIN32}
var
    Buffer: array[0..255] of Char;
{$ENDIF}
begin
    if URL <> '' then
{$IFNDEF WIN32}
        ShellExecute(Application.Handle, 'open',
            StrPCopy(Buffer, URL), nil, nil, SW_SHOW)
{$ELSE}
        ShellExecute(Application.Handle, 'open',
            PChar(URL), nil, nil, SW_SHOW)
{$ENDIF}
end; { OpenURL }

function UnixPathToDosPath(const Path: string): string;
begin
    Result := strReplace(Path, '/', '\');
end;

function DosPathToUnixPath(const Path: string): string;
begin
    Result := strReplace(Path, '\', '/');
end;

function HTTPDecode(const AStr: string): string;
var
    Sp, Rp, Cp: PChar;
    S: string;
begin
    SetLength(Result, Length(AStr));
    Sp := PChar(AStr);
    Rp := PChar(Result);
    try
        while Sp^ <> #0 do
        begin
            case Sp^ of
                '+': Rp^ := ' ';
                '%':
                    begin
                        // Look for an escaped % (%%) or %<hex> encoded character
                        Inc(Sp);
                        if Sp^ = '%' then
                            Rp^ := '%'
                        else
                        begin
                            Cp := Sp;
                            Inc(Sp);
                            if (Cp^ <> #0) and (Sp^ <> #0) then
                            begin
                                S := '$' + Cp^ + Sp^;
                                Rp^ := Chr(StrToInt(S));
                            end
                                //else
                                //  raise Exception.CreateFmt('Encoding Error');
                        end;
                    end;
            else
                Rp^ := Sp^;
            end;
            Inc(Rp);
            Inc(Sp);
        end;
    except
        on E: EConvertError do
        begin
        end;
        //raise EConvertError.CreateFmt('httpEncodeError')
    end;
    SetLength(Result, Rp - PChar(Result));
end;

function HTTPEncode(const AStr: string): string;
const
    NoConversion = ['A'..'Z', 'a'..'z', '*', '@', '.', '_', '-',
        '0'..'9', '$', '!', '''', '(', ')'];
var
    Sp, Rp: PChar;
begin
    SetLength(Result, Length(AStr) * 3);
    Sp := PChar(AStr);
    Rp := PChar(Result);
    while Sp^ <> #0 do
    begin
        if Sp^ in NoConversion then
            Rp^ := Sp^
        else if Sp^ = ' ' then
            Rp^ := '+'
        else
        begin
            FormatBuf(Rp^, 3, '%%%.2x', 6, [Ord(Sp^)]);
            Inc(Rp, 2);
        end;
        Inc(Rp);
        Inc(Sp);
    end;
    SetLength(Result, Rp - PChar(Result));
end;

initialization
    Randomize;

    SysMetric := TSystemMetric.Create;
    IsWin95 := (GetVersion and $FF00) >= $5F00;
{$IFDEF Win32}
    IsWinNT := CheckNT;
{$ELSE}
    IsWinNT := False;
{$ENDIF}

    IsFabula := nil;

{$IFDEF Win32}
    xLanguage := (LoWord(GetUserDefaultLangID) and $3FF);
    case xLanguage of
        LANG_GERMAN: xLangOfs := 70000;
        LANG_ENGLISH: xLangOfs := 71000;
        LANG_SPANISH: xLangOfs := 72000;
        LANG_RUSSIAN: xLangOfs := 73000;
        LANG_ITALIAN: xLangOfs := 74000;
        LANG_FRENCH: xLangOfs := 75000;
        LANG_PORTUGUESE: xLangOfs := 76000;
    else
        xLangOfs := 71000;
    end;
{$ENDIF}

{$IFDEF Win32}
finalization
    SysMetric.Free;
{$ELSE}
    AddExitProc(DoneXProcs);
{$ENDIF}
end.

