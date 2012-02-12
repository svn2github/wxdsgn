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

Unit xProcs;

{$D-}

Interface

{.$DEFINE German}
{.$DEFINE English}

Uses
{$IFDEF Win32}Windows, Registry, {$ELSE}WinTypes, WinProcs, {$ENDIF}
    ShellAPI, Messages, Classes, Graphics, shlObj, ActiveX;

Type
    Float = Extended; { our type for float arithmetic }

{$IFDEF Win32}{ our type for integer functions, Int_ is ever 32 bit }
    Int_ = Integer;
{$ELSE}
    Int_ = Longint;
{$ENDIF}

Const
    XCOMPANY = 'Fabula Software';

Const
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

    CRLF: Pchar = CR + LF;

    { common computer sizes }
    KBYTE = Sizeof(Byte) Shl 10;
    MBYTE = KBYTE Shl 10;
    GBYTE = MBYTE Shl 10;

    { Low floating point value }
    FLTZERO: Float = 0.00000001;

    DIGITS: Set Of Char = [ZERO..NINE];

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

Type
    TMonth = (NoneMonth, January, February, March, April, May, June, July,
        August, September, October, November, December);

    TDayOfWeek = (Sunday, Monday, Tuesday, Wednesday, Thursday,
        Friday, Saturday);

    { Online eMail Service Provider }
    TMailProvider = (mpCServe, mpInternet, mpNone);

    TLicCallback = Function(Var Code: Integer): Integer;

    TBit = 0..31;

    { Search and Replace options }
    TSROption = (srWord, srCase, srAll);
    TSROptions = Set Of TsrOption;

    { Data types }
    TDataType = (dtInteger, dtBoolean, dtString, dtDate, dtTime,
        dtFloat, dtCurrency);

Var
    IsWin95,
    IsWinNT: Boolean;
    IsFabula: TLicCallBack;

    xLanguage: Integer;
    xLangOfs: Integer;

{ bit manipulating }
Function bitSet(Const Value: Int_; Const TheBit: TBit): Boolean;
Function bitOn(Const Value: Int_; Const TheBit: TBit): Int_;
Function bitOff(Const Value: Int_; Const TheBit: TBit): Int_;
Function bitToggle(Const Value: Int_; Const TheBit: TBit): Int_;

{ String functions }
Function strHash(Const S: String; LastBucket: Integer): Integer;
Function strCut(Const S: String; Len: Integer): String;
Function strTrim(Const S: String): String;
Function strTrimA(Const S: String): String;
Function strTrimChA(Const S: String; C: Char): String;
Function strTrimChL(Const S: String; C: Char): String;
Function strTrimChR(Const S: String; C: Char): String;
Function strLeft(Const S: String; Len: Integer): String;
Function strLower(Const S: String): String;
Function strMake(C: Char; Len: Integer): String;
Function strPadChL(Const S: String; C: Char; Len: Integer): String;
Function strPadChR(Const S: String; C: Char; Len: Integer): String;
Function strPadChC(Const S: String; C: Char; Len: Integer): String;
Function strPadL(Const S: String; Len: Integer): String;
Function strPadR(Const S: String; Len: Integer): String;
Function strPadC(Const S: String; Len: Integer): String;
Function strPadZeroL(Const S: String; Len: Integer): String;
Function strPos(Const aSubstr, S: String; aOfs: Integer): Integer;
Procedure strChange(Var S: String; Const Src, Dest: String);
Function strChangeU(Const S, Source, Dest: String): String;
Function strRight(Const S: String; Len: Integer): String;
Function strAddSlash(Const S: String): String;
Function strDelSlash(Const S: String): String;
Function strSpace(Len: Integer): String;
Function strToken(Var S: String; Seperator: Char): String;
Function strTokenCount(S: String; Seperator: Char): Integer;
Function strTokenAt(Const S: String; Seperator: Char; At: Integer): String;
Procedure strTokenToStrings(S: String; Seperator: Char; List: TStrings);
Function strTokenFromStrings(Seperator: Char; List: TStrings): String;
Function strRemoveDuplicates(OrigString: String; Seperator: Char): String;

Function strUpper(Const S: String): String;
Function strOemAnsi(Const S: String): String;
Function strAnsiOem(Const S: String): String;
Function strEqual(Const S1, S2: String): Boolean;
Function strComp(Const S1, S2: String): Boolean;
Function strCompU(Const S1, S2: String): Boolean;
Function strContains(Const S1, S2: String): Boolean;
Function strContainsU(Const S1, S2: String): Boolean;
Function strNiceNum(Const S: String): String;
Function strNiceDateDefault(Const S, Default: String): String;
Function strNiceDate(Const S: String): String;
Function strNiceTime(Const S: String): String;
Function strNicePhone(Const S: String): String;
Function strReplace(Const S: String; C: Char; Const Replace: String): String;
Function strCmdLine: String;
Function strEncrypt(Const S: String; Key: Word): String;
Function strDecrypt(Const S: String; Key: Word): String;
Function strLastCh(Const S: String): Char;
Procedure strStripLast(Var S: String);
Function strByteSize(Value: Longint): String;
Function strSoundex(S: String): String;
Procedure strSearchReplace(Var S: String; Const Source, Dest: String;
    Options: TSRoptions);
Function strProfile(Const aFile, aSection, aEntry, aDefault: String): String;
Function strCapitalize(Const S: String): String; { 31.07.96 sb }

{$IFDEF Win32}
Procedure strDebug(Const S: String);
Function strFileLoad(Const aFile: String): String;
Procedure strFileSave(Const aFile, aString: String);
{$ENDIF}

{ Integer functions }
Function IsInt(s1: String): Boolean;
Function intCenter(a, b: Int_): Int_;
Function intMax(a, b: Int_): Int_;
Function intMin(a, b: Int_): Int_;
Function intPow(Base, Expo: Integer): Int_;
Function intPow10(Exponent: Integer): Int_;
Function intSign(a: Int_): Integer;
Function intZero(a: Int_; Len: Integer): String;
Function intPrime(Value: Integer): Boolean;
Function intPercent(a, b: Int_): Int_;

{ Floatingpoint functions }
Function Isflt(s1: String): Boolean;
Function fltAdd(P1, P2: Float; Decimals: Integer): Float;
Function fltDiv(P1, P2: Float; Decimals: Integer): Float;
Function fltEqual(P1, P2: Float; Decimals: Integer): Boolean;
Function fltEqualZero(P: Float): Boolean;
Function fltGreaterZero(P: Float): Boolean;
Function fltLessZero(P: Float): Boolean;
Function fltNeg(P: Float; Negate: Boolean): Float;
Function fltMul(P1, P2: Float; Decimals: Integer): Float;
Function fltRound(P: Float; Decimals: Integer): Float;
Function fltSub(P1, P2: Float; Decimals: Integer): Float;
Function fltUnEqualZero(P: Float): Boolean;
Function fltCalc(Const Expr: String): Float;
Function fltPower(a, n: Float): Float;
Function fltPositiv(Value: Float): Float;
Function fltNegativ(Value: Float): Float;

{ Rectangle functions from Golden Software }
Function rectHeight(Const R: TRect): Integer;
Function rectWidth(Const R: TRect): Integer;
Procedure rectGrow(Var R: TRect; Delta: Integer);
Procedure rectRelativeMove(Var R: TRect; DX, DY: Integer);
Procedure rectMoveTo(Var R: TRect; X, Y: Integer);
Function rectSet(Left, Top, Right, Bottom: Integer): TRect;
Function rectInclude(Const R1, R2: TRect): Boolean;
Function rectPoint(Const R: TRect; P: TPoint): Boolean;
Function rectSetPoint(Const TopLeft, BottomRight: TPoint): TRect;
Function rectIntersection(Const R1, R2: TRect): TRect;
Function rectIsIntersection(Const R1, R2: TRect): Boolean;
Function rectIsValid(Const R: TRect): Boolean;
Function rectsAreValid(Const Arr: Array Of TRect): Boolean;
Function rectNull: TRect;
Function rectIsNull(Const R: TRect): Boolean;
Function rectIsSquare(Const R: TRect): Boolean;
Function rectCentralPoint(Const R: TRect): TPoint;
Function rectBounds(aLeft, aTop, aWidth, aHeight: Integer): TRect;

{$IFDEF Win32}
{ Variant functions }
Function varIIF(aTest: Boolean; TrueValue, FalseValue: Variant): Variant;
Procedure varDebug(Const V: Variant);
Function varToStr(Const V: Variant): String;
{$ENDIF}

{ date functions }
Function dateYear(D: TDateTime): Integer;
Function dateMonth(D: TDateTime): Integer;
Function dateDay(D: TDateTime): Integer;
Function dateBeginOfYear(D: TDateTime): TDateTime;
Function dateEndOfYear(D: TDateTime): TDateTime;
Function dateBeginOfMonth(D: TDateTime): TDateTime;
Function dateEndOfMonth(D: TDateTime): TDateTime;
Function dateWeekOfYear(D: TDateTime): Integer;
Function dateDayOfYear(D: TDateTime): Integer;
Function dateDayOfWeek(D: TDateTime): TDayOfWeek;
Function dateLeapYear(D: TDateTime): Boolean;
Function dateBeginOfQuarter(D: TDateTime): TDateTime;
Function dateEndOfQuarter(D: TDateTime): TDateTime;
Function dateBeginOfWeek(D: TDateTime; Weekday: Integer): TDateTime;
Function dateDaysInMonth(D: TDateTime): Integer;
Function dateQuicken(D: TDateTime; Var Key: Char): TDateTime;
{function  dateDiff(D1,D2: TDateTime): Integer;}

{ time functions }
Function timeHour(T: TDateTime): Integer;
Function timeMin(T: TDateTime): Integer;
Function timeSec(T: TDateTime): Integer;
Function timeToInt(T: TDateTime): Integer;

{$IFDEF Win32}
Function timeZoneOffset: Integer;
{$ENDIF}

{ com Functions }
Function comIsCis(Const S: String): Boolean;
Function comIsInt(Const S: String): Boolean;
Function comCisToInt(Const S: String): String;
Function comIntToCis(Const S: String): String;
Function comFaxToCis(Const S: String): String;
Function comNormFax(Const Name, Fax: String): String;
Function comNormPhone(Const Phone: String): String;
Function comNormInt(Const Name, Int: String): String;
Function comNormCis(Const Name, Cis: String): String;

{ file functions }
Procedure fileShredder(Const Filename: String);
Function fileSize(Const Filename: String): Longint;
Function fileWildcard(Const Filename: String): Boolean;
Function fileShellOpen(Const aFile: String): Boolean;
Function fileShellPrint(Const aFile: String): Boolean;
Function fileCopy(Const SourceFile, TargetFile: String): Boolean;

{$IFDEF Win32}
Function fileTemp(Const aExt: String): String;
Function fileExec(Const aCmdLine: String; aHide, aWait: Boolean): Boolean;
Function fileRedirectExec(Const aCmdLine: String; Strings: TStrings): Boolean;
Function fileLongName(Const aFile: String): String;
Function fileShortName(Const aFile: String): String;
Function fileTypeName(Const aFile: String): String;
{$ENDIF}
Function ExtractName(Const Filename: String): String;

{ system functions }
Function sysTempPath: String;
Procedure sysDelay(aMs: Longint);
Procedure sysBeep;
Function sysColorDepth: Integer; { 06.08.96 sb }

{$IFDEF Win32}
Function GetShellFoldername(folderID: Integer): String;
Procedure sysSaverRunning(Active: Boolean);
{$ENDIF}

{ registry functions }

{$IFDEF Win32}
Function regReadString(aKey: hKey; Const Path: String): String;
Procedure regWriteString(aKey: hKey; Const Path, Value: String);
Procedure regDelValue(aKey: hKey; Const Path: String);
Function regInfoString(Const Value: String): String;
Function regCurrentUser: String;
Function regCurrentCompany: String;
Procedure regWriteShellExt(Const aExt, aCmd, aMenu, aExec: String);

{ The following five functions came from David W. Yutzy / Celeste Software Services
  Thanks for submitting us the methods !!
}
Procedure regKeyList(aKey: HKEY; Const Path: String; Var aValue: TStringList);
Function regValueExist(aKey: HKEY; Const Path: String): Boolean;
Function regWriteValue(aKey: HKEY; Const Path: String;
    Value: Variant; Typ: TDataType): Boolean;
Function regReadValue(aKey: HKEY; Const Path: String; Typ: TDataType): Variant;
Procedure regValueList(aKey: HKEY; Const Path: String;
    Var aValue: TStringList);
{$ENDIF}

{Innet functions}
Procedure OpenURL(Const URL: String);

Function UnixPathToDosPath(Const Path: String): String;
Function DosPathToUnixPath(Const Path: String): String;

Function HTTPEncode(Const AStr: String): String;
Function HTTPDecode(Const AStr: String): String;

Type
    { TRect that can be used persistent as property for components }
    TUnitConvertEvent = Function(Sender: TObject;
        Value: Integer; Get: Boolean): Integer Of Object;

    TPersistentRect = Class(TPersistent)
    Private
        FRect: TRect;
        FOnConvert: TUnitConvertEvent;
        Procedure SetLeft(Value: Integer);
        Procedure SetTop(Value: Integer);
        Procedure SetHeight(Value: Integer);
        Procedure SetWidth(Value: Integer);
        Function GetLeft: Integer;
        Function GetTop: Integer;
        Function GetHeight: Integer;
        Function GetWidth: Integer;
    Public
        Constructor Create;
        Procedure Assign(Source: TPersistent); Override;
        Property Rect: TRect Read FRect;
        Property OnConvert: TUnitConvertEvent Read FOnConvert Write FOnConvert;
    Published
        Property Left: Integer Read GetLeft Write SetLeft;
        Property Top: Integer Read GetTop Write SetTop;
        Property Height: Integer Read GetHeight Write SetHeight;
        Property Width: Integer Read GetWidth Write SetWidth;
    End;

{$IFDEF Win32}
    { Persistent access of components from the registry }
    TPersistentRegistry = Class(TRegistry)
    Public
        Function ReadComponent(Const Name: String;
            Owner, Parent: TComponent): TComponent;
        Procedure WriteComponent(Const Name: String; Component: TComponent);
    End;
    {$ENDIF

      { easy access of the system metrics }
    TSystemMetric = Class
    Private
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
    Protected
        Constructor Create;
        Procedure Update;
    Public
        Property MenuHeight: Integer Read FMenuHeight;
        Property CaptionHeight: Integer Read FCaptionHeight;
        Property Border: TPoint Read FBorder;
        Property Frame: TPoint Read FFrame;
        Property DlgFrame: TPoint Read FDlgFrame;
        Property Bitmap: TPoint Read FBitmap;
        Property HScroll: TPoint Read FHScroll;
        Property VScroll: TPoint Read FVScroll;
        Property Thumb: TPoint Read FThumb;
        Property FullScreen: TPoint Read FFullScreen;
        Property Min: TPoint Read FMin;
        Property MinTrack: TPoint Read FMinTrack;
        Property Cursor: TPoint Read FCursor;
        Property Icon: TPoint Read FIcon;
        Property DoubleClick: TPoint Read FDoubleClick;
        Property IconSpacing: TPoint Read FIconSpacing;
        Property ColorDepth: Integer Read FColorDepth;
    End;

Var
    SysMetric: TSystemMetric;

Type
    TDesktopCanvas = Class(TCanvas)
    Private
        DC: hDC;
    Public
        Constructor Create;
        Destructor Destroy; Override;
    End;

Implementation

Uses
    SysUtils, Controls, Forms, Consts, Dialogs;

{ bit manipulating }

Function bitSet(Const Value: Int_; Const TheBit: TBit): Boolean;
Begin
    Result := (Value And (1 Shl TheBit)) <> 0;
End;

Function bitOn(Const Value: Int_; Const TheBit: TBit): Int_;
Begin
    Result := Value Or (1 Shl TheBit);
End;

Function bitOff(Const Value: Int_; Const TheBit: TBit): Int_;
Begin
    Result := Value And ((1 Shl TheBit) Xor $FFFFFFFF);
End;

Function bitToggle(Const Value: Int_; Const TheBit: TBit): Int_;
Begin
    result := Value Xor (1 Shl TheBit);
End;

{ string methods }

Function strHash(Const S: String; LastBucket: Integer): Integer;
Var
    i: Integer;
Begin
    Result := 0;
    For i := 1 To Length(S) Do
        Result := ((Result Shl 3) Xor Ord(S[i])) Mod LastBucket;
End;

Function strTrim(Const S: String): String;
Begin
    Result := StrTrimChR(StrTrimChL(S, BLANK), BLANK);
End;

Function strTrimA(Const S: String): String;
Begin
    Result := StrTrimChA(S, BLANK);
End;

Function strTrimChA(Const S: String; C: Char): String;
Var
    I: Word;
Begin
    Result := S;
    For I := Length(Result) Downto 1 Do
        If Result[I] = C Then
            Delete(Result, I, 1);
End;

Function strTrimChL(Const S: String; C: Char): String;
Begin
    Result := S;
    While (Length(Result) > 0) And (Result[1] = C) Do
        Delete(Result, 1, 1);
End;

Function strTrimChR(Const S: String; C: Char): String;
Begin
    Result := S;
    While (Length(Result) > 0) And (Result[Length(Result)] = C) Do
        Delete(Result, Length(Result), 1);
End;

Function strLeft(Const S: String; Len: Integer): String;
Begin
    Result := Copy(S, 1, Len);
End;

Function strLower(Const S: String): String;
Begin
    Result := AnsiLowerCase(S);
End;

Function strMake(C: Char; Len: Integer): String;
Begin
    Result := strPadChL('', C, Len);
End;

Function strPadChL(Const S: String; C: Char; Len: Integer): String;
Begin
    Result := S;
    While Length(Result) < Len Do
        Result := C + Result;
End;

Function strPadChR(Const S: String; C: Char; Len: Integer): String;
Begin
    Result := S;
    While Length(Result) < Len Do
        Result := Result + C;
End;

Function strPadChC(Const S: String; C: Char; Len: Integer): String;
Begin
    Result := S;
    While Length(Result) < Len Do
    Begin
        Result := Result + C;
        If Length(Result) < Len Then
            Result := C + Result;
    End;
End;

Function strPadL(Const S: String; Len: Integer): String;
Begin
    Result := strPadChL(S, BLANK, Len);
End;

Function strPadC(Const S: String; Len: Integer): String;
Begin
    Result := strPadChC(S, BLANK, Len);
End;

Function strPadR(Const S: String; Len: Integer): String;
Begin
    Result := strPadChR(S, BLANK, Len);
End;

Function strPadZeroL(Const S: String; Len: Integer): String;
Begin
    Result := strPadChL(strTrim(S), ZERO, Len);
End;

Function strCut(Const S: String; Len: Integer): String;
Begin
    Result := strLeft(strPadR(S, Len), Len);
End;

Function strRight(Const S: String; Len: Integer): String;
Begin
    If Len >= Length(S) Then
        Result := S
    Else
        Result := Copy(S, Succ(Length(S)) - Len, Len);
End;

Function strAddSlash(Const S: String): String;
Begin
    Result := S;
    If strLastCh(Result) <> SLASH Then
        Result := Result + SLASH;
End;

Function strDelSlash(Const S: String): String;
Begin
    Result := S;
    If strLastCh(Result) = SLASH Then
        Delete(Result, Length(Result), 1);
End;

Function strSpace(Len: Integer): String;
Begin
    Result := StrMake(BLANK, Len);
End;

Function strToken(Var S: String; Seperator: Char): String;
Var
    I: Word;
Begin
    I := Pos(Seperator, S);
    If I <> 0 Then
    Begin
        Result := Copy(S, 1, I - 1);  //System.Copy(S, 1, I - 1);
        Delete(S, 1, I);  //System.Delete(S, 1, I);
    End
    Else
    Begin
        Result := S;
        S := '';
    End;
End;

Function strTokenCount(S: String; Seperator: Char): Integer;
Var
    Scopy: String;
    I, Count: Integer;
Begin

    Scopy := S;
    Count := 0;

    I := Pos(Seperator, Scopy);
    While I <> 0 Do
    Begin
        Count := Count + 1;
        Delete(Scopy, 1, I + Length(Seperator) - 1);
        I := Pos(Seperator, Scopy);
    End;

    Result := Count;

End;

Function strTokenAt(Const S: String; Seperator: Char; At: Integer): String;
Var
    j, i: Integer;
Begin
    Result := '';
    j := 1;
    i := 0;
    While (i <= At) And (j <= Length(S)) Do
    Begin
        If S[j] = Seperator Then
            Inc(i)
        Else
        If i = At Then
            Result := Result + S[j];
        Inc(j);
    End;
End;

Procedure strTokenToStrings(S: String; Seperator: Char; List: TStrings);
Var
    Token, Scopy: String;
Begin
    List.Clear;
    Scopy := S;

    Token := strToken(Scopy, Seperator);
    While Token <> '' Do
    Begin
        List.Add(Token);
        Token := strToken(Scopy, Seperator);
    End;
End;

Function strTokenFromStrings(Seperator: Char; List: TStrings): String;
Var
    i: Integer;
Begin
    Result := '';
    For i := 0 To List.Count - 1 Do
        If Result <> '' Then
            Result := Result + Seperator + List[i]
        Else
            Result := List[i];
End;

// Removes duplicate values in a token-delimited string
Function strRemoveDuplicates(OrigString: String; Seperator: Char): String;
Var
    List1, List2: TStringList;
    nodupString: String;
    i: Integer;
Begin

    List1 := TStringList.Create;
    List2 := TStringList.Create;
    strTokenToStrings(OrigString, Seperator, List1);

    List2.Add(List1[0]);
    For i := 1 To List1.Count - 1 Do
    Begin
        // If the string from List1 is not in List2, then add it.
        If (List2.IndexOf(List1[i]) > -1) And (strTrim(List1[i]) <> '') Then
            List2.Add(List1[i]);
    End;

    nodupString := strTokenFromStrings(Seperator, List2);
    List2.Destroy;
    List1.Destroy;
    Result := nodupString;

End;

Function strUpper(Const S: String): String;
Begin
    Result := AnsiUpperCase(S);
End;

Function strOemAnsi(Const S: String): String;
Begin
{$IFDEF Win32}
    SetLength(Result, Length(S));
{$ELSE}
    Result[0] := Chr(Length(S));
{$ENDIF}
    OemToAnsiBuff(@S[1], @Result[1], Length(S));
End;

Function strAnsiOem(Const S: String): String;
Begin
{$IFDEF Win32}
    SetLength(Result, Length(S));
{$ELSE}
    Result[0] := Chr(Length(S));
{$ENDIF}
    AnsiToOemBuff(@S[1], @Result[1], Length(S));
End;

Function strEqual(Const S1, S2: String): Boolean;
Begin
    Result := AnsiCompareText(S1, S2) = 0;
End;

Function strCompU(Const S1, S2: String): Boolean;
Begin
    Result := strEqual(strLeft(S2, Length(S1)), S1);
End;

Function strComp(Const S1, S2: String): Boolean;
Begin
    Result := strLeft(S2, Length(S1)) = S1;
End;

Function strContains(Const S1, S2: String): Boolean;
Begin
    Result := Pos(S1, S2) > 0;
End;

Function strContainsU(Const S1, S2: String): Boolean;
Begin
    Result := strContains(strUpper(S1), strUpper(S2));
End;

Function strNiceNum(Const S: String): String;
Var
    i: Integer;
    Seps: Set Of Char;
Begin
    Seps := [ThousandSeparator, DecimalSeparator];
    Result := ZERO;
    For i := 1 To Length(S) Do
        If S[i] In DIGITS + Seps Then
        Begin
            If S[i] = ThousandSeparator Then
                Result := Result + DecimalSeparator
            Else
                Result := Result + S[i];
            If S[i] In Seps Then
                Seps := [];
        End;
End;

Function strNiceDate(Const S: String): String;
Begin
    Result := strNiceDateDefault(S, DateToStr(Date));
End;

Function strNiceDateDefault(Const S, Default: String): String;
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
Var
    a: Array[0..2] Of String[4];
    heute: String;
    i, j: Integer;
Begin
    a[0] := '';
    a[1] := '';
    a[2] := '';
    heute := Default;

    j := 0;
    For i := 0 To length(S) Do
        If S[i] In DIGITS Then
            a[j] := a[j] + S[i]
        Else
        If S[i] In [DateSeparator] Then
            Inc(j);
    For i := 0 To 2 Do
        If Length(a[i]) = 0 Then
            If I = 2 Then
                a[i] := copy(heute, i * 3 + 1, 4)
            Else
                a[i] := copy(heute, i * 3 + 1, 2)
        Else
        If length(a[i]) = 1 Then
            a[i] := '0' + a[i];

    Result := a[0] + DateSeparator + a[1] + DateSeparator + a[2];
    Try
        StrToDate(Result);
    Except
        Result := DateToStr(Date);
    End;
End;

Function strNiceTime(Const S: String): String;
Var
    a: Array[0..2] Of String[2];
    i, j: Integer;
Begin
    j := 0;
    a[0] := '';
    a[1] := '';
    a[2] := '';
    For i := 1 To length(S) Do
    Begin
        If S[i] In DIGITS Then
        Begin
            a[j] := a[j] + S[i];
        End
        Else
        If S[i] In ['.', ',', ':'] Then
            inc(J);
        If j > 2 Then
            exit;
    End;
    For J := 0 To 2 Do
        If length(a[j]) = 1 Then
            a[j] := '0' + a[j]
        Else
        If length(a[j]) = 0 Then
            a[j] := '00';
    Result := a[0] + TimeSeparator + a[1] + TimeSeparator + a[2];
End;

Function strNicePhone(Const S: String): String;
Var
    L: Integer;
Begin
    If Length(S) > 3 Then
    Begin
        L := (Length(S) + 1) Div 2;
        Result := strNicePhone(strLeft(S, L)) + SPACE +
            strNicePhone(strRight(S, Length(S) - L));
    End
    Else
        Result := S;
End;

Function strReplace(Const S: String; C: Char; Const Replace: String): String;
Var
    i: Integer;
Begin
    Result := '';
    For i := Length(S) Downto 1 Do
        If S[i] = C Then
            Result := Replace + Result
        Else
            Result := S[i] + Result;
End;

Function strPos(Const aSubstr, S: String; aOfs: Integer): Integer;
Begin
    Result := Pos(aSubStr, Copy(S, aOfs, (Length(S) - aOfs) + 1));
    If (Result > 0) And (aOfs > 1) Then
        Inc(Result, aOfs - 1);
End;

Procedure strChange(Var S: String; Const Src, Dest: String);
Var
    P: Integer;
Begin
    P := Pos(Src, S);
    While P <> 0 Do
    Begin
        Delete(S, P, Length(Src));
        Insert(Dest, S, P);
        Inc(P, Length(Dest));
        P := strPos(Src, S, P);
    End;
End;

Function strChangeU(Const S, Source, Dest: String): String;
Var
    P: Integer;
    aSrc: String;
Begin
    Result := S;
    aSrc := strUpper(Source);
    P := Pos(aSrc, strUpper(Result));
    While P <> 0 Do
    Begin
        Delete(Result, P, Length(Source));
        Insert(Dest, Result, P);
        Inc(P, Length(Dest));
        P := strPos(aSrc, strUpper(Result), P);
    End;
End;

Function strCmdLine: String;
Var
    i: Integer;
Begin
    Result := '';
    For i := 1 To ParamCount Do
        Result := Result + ParamStr(i) + ' ';
    Delete(Result, Length(Result), 1);
End;

{ sends a string to debug windows inside the IDE }
{$IFDEF Win32}

Procedure strDebug(Const S: String);
Var
    P: Pchar;
    CPS: TCopyDataStruct;
    aWnd: hWnd;
Begin
    aWnd := FindWindow('TfrmDbgTerm', Nil);
    If aWnd <> 0 Then
    Begin
        CPS.cbData := Length(S) + 2;
        GetMem(P, CPS.cbData);
        Try
            StrPCopy(P, S + CR);
            CPS.lpData := P;
            SendMessage(aWnd, WM_COPYDATA, 0, LParam(@CPS));
        Finally
            FreeMem(P, Length(S) + 2);
        End;
    End;
End;
{$ENDIF}

Function strSoundex(S: String): String;
Const
    CvTable: Array['B'..'Z'] Of Char = (
        '1', '2', '3', '0', '1', {'B' .. 'F'}
        '2', '0', '0', '2', '2', {'G' .. 'K'}
        '4', '5', '5', '0', '1', {'L' .. 'P'}
        '2', '6', '2', '3', '0', {'Q' .. 'U'}
        '1', '0', '2', '0', '2'); {'V' .. 'Z'}
Var
    i, j: Integer;
    aGroup, Ch: Char;

    Function Group(Ch: Char): Char;
    Begin
        If (Ch In ['B'..'Z']) And Not
            (Ch In ['E', 'H', 'I', 'O', 'U', 'W', 'Y']) Then
            Result := CvTable[Ch]
        Else
            Result := '0';
    End;

Begin
    Result := '000';
    If S = '' Then
        exit;

    S := strUpper(S);
    i := 2;
    j := 1;
    While (i <= Length(S)) And (j <= 3) Do
    Begin
        Ch := S[i];
        aGroup := Group(Ch);
        If (aGroup <> '0') And (Ch <> S[i - 1]) And
            ((J = 1) Or (aGroup <> Result[j - 1])) And
            ((i > 2) Or (aGroup <> Group(S[1]))) Then
        Begin
            Result[j] := aGroup;
            Inc(j);
        End;
        Inc(i);
    End; {while}

    Result := S[1] + '-' + Result;
End;

Function strByteSize(Value: Longint): String;

    Function FltToStr(F: Extended): String;
    Begin
        Result := FloatToStrF(Round(F), ffNumber, 6, 0);
    End;

Begin
    If Value > GBYTE Then
        Result := FltTostr(Value / GBYTE) + ' GB'
    Else
    If Value > MBYTE Then
        Result := FltToStr(Value / MBYTE) + ' MB'
    Else
    If Value > KBYTE Then
        Result := FltTostr(Value / KBYTE) + ' KB'
    Else
        Result := FltTostr(Value) + ' Byte'; { 04.08.96 sb }
End;

Const
    C1 = 52845;
    C2 = 22719;

Function strEncrypt(Const S: String; Key: Word): String;
Var
    I: Integer;
Begin
{$IFDEF Win32}
    SetLength(Result, Length(S));
{$ELSE}
    Result[0] := Chr(Length(S));
{$ENDIF}
    For I := 1 To Length(S) Do
    Begin
        Result[I] := Char(Ord(S[I]) Xor (Key Shr 8));
        Key := (Ord(Result[I]) + Key) * C1 + C2;
    End;
End;

Function strDecrypt(Const S: String; Key: Word): String;
Var
    I: Integer;
Begin
{$IFDEF Win32}
    SetLength(Result, Length(S));
{$ELSE}
    Result[0] := Chr(Length(S));
{$ENDIF}
    For I := 1 To Length(S) Do
    Begin
        Result[I] := Char(Ord(S[I]) Xor (Key Shr 8));
        Key := (Ord(S[I]) + Key) * C1 + C2;
    End;
End;

Function strLastCh(Const S: String): Char;
Begin
    Result := S[Length(S)];
End;

Procedure strStripLast(Var S: String);
Begin
    If Length(S) > 0 Then
        Delete(S, Length(S), 1);
End;

Procedure strSearchReplace(Var S: String; Const Source, Dest: String;
    Options: TSRoptions);
Var
    hs, hs1, hs2, hs3: String;
Var
    i, j: Integer;

Begin
    If srCase In Options Then
    Begin
        hs := s;
        hs3 := source;
    End
    Else
    Begin
        hs := StrUpper(s);
        hs3 := StrUpper(Source);
    End;
    hs1 := '';
    I := pos(hs3, hs);
    j := length(hs3);
    While i > 0 Do
    Begin
        delete(hs, 1, i + j - 1); {Anfang Rest geändert 8.7.96 KM}
        hs1 := Hs1 + copy(s, 1, i - 1); {Kopieren geändert 8.7.96 KM}
        delete(s, 1, i - 1); {Löschen bis Anfang posgeändert 8.7.96 KM}
        hs2 := copy(s, 1, j); {Bis ende pos Sichern}
        delete(s, 1, j); {Löschen bis ende Pos}
        If (Not (srWord In Options))
            Or (pos(s[1], ' .,:;-#''+*?=)(/&%$§"!{[]}\~<>|') > 0) Then
        Begin
            {Quelle durch ziel erstzen}
            hs1 := hs1 + dest;
        End
        Else
        Begin
            hs1 := hs1 + hs2;
        End;
        If srall In options Then
            I := pos(hs3, hs)
        Else
            i := 0;
    End;
    s := hs1 + s;
End;

Function strProfile(Const aFile, aSection, aEntry, aDefault: String): String;
Var
    aTmp: Array[0..255] Of Char;
{$IFNDEF Win32}
    pFile: array[0..200] of char;
    pSection: array[0..100] of char;
    pEntry: array[0..100] of char;
    pDefault: array[0..100] of char;
{$ENDIF}
Begin
{$IFDEF Win32}
    GetPrivateProfileString(Pchar(aSection), Pchar(aEntry),
        Pchar(aDefault), aTmp, Sizeof(aTmp) - 1, Pchar(aFile));
    Result := StrPas(aTmp);
{$ELSE}
    GetPrivateProfileString(StrPCopy(pSection, aSection),
        StrPCopy(pEntry, aEntry), StrPCopy(pDefault, aDefault),
        aTmp, Sizeof(aTmp) - 1, StrPCopy(pFile, aFile));
    Result := StrPas(aTmp);
{$ENDIF}
End;

Function strCapitalize(Const S: String): String; { 31.07.96 sb }
Var
    i: Integer;
    Ch: Char;
    First: Boolean;
Begin
    First := True;
    Result := '';
    For i := 1 To Length(S) Do
    Begin
        Ch := S[i];
        If Ch In [SPACE, '-', '.'] Then
            First := True
        Else
        If First Then
        Begin
            Ch := strUpper(Ch)[1];
            First := False;
        End;
        Result := Result + Ch;
    End;
End;

{$IFDEF Win32}

Function strFileLoad(Const aFile: String): String;
Var
    aStr: TStrings;
Begin
    Result := '';
    aStr := TStringList.Create;
    Try
        aStr.LoadFromFile(aFile);
        Result := aStr.Text;
    Finally
        aStr.Free;
    End;
End;

Procedure strFileSave(Const aFile, aString: String);
Var
    Stream: TStream;
Begin
    Stream := TFileStream.Create(aFile, fmCreate);
    Try
        Stream.WriteBuffer(Pointer(aString)^, Length(aString));
    Finally
        Stream.Free;
    End;
End;
{$ENDIF}

{ Integer stuff }

Function IsInt(s1: String): Boolean;
Var
    i: Integer;
Begin
    Result := True;
    If Length(s1) > 0 Then
    Begin
        For i := 1 To Length(s1) Do
        Begin
            If Not (s1[i] In ['0'..'9']) Then
            Begin
                Result := False;
                Break;
            End;
        End;
    End
    Else
        Result := False;
End;

Function IntCenter(a, b: Int_): Int_;
Begin
    Result := a Div 2 - b Div 2;
End;

Function IntMax(a, b: Int_): Int_;
Begin
    If a > b Then
        Result := a
    Else
        Result := b;
End;

Function IntMin(a, b: Int_): Int_;
Begin
    If a < b Then
        Result := a
    Else
        Result := b;
End;

Function IntPow(Base, Expo: Integer): Int_;
Var
    Loop: Word;
Begin
    Result := 1;
    For Loop := 1 To Expo Do
        Result := Result * Base;
End;

Function IntPow10(Exponent: Integer): Int_;
Begin
    Result := IntPow(10, Exponent);
End;

Function IntSign(a: Int_): Integer;
Begin
    If a < 0 Then
        Result := -1
    Else
    If a > 0 Then
        Result := +1
    Else
        Result := 0;
End;

Function IntZero(a: Int_; Len: Integer): String;
Begin
    Result := strPadZeroL(IntToStr(a), Len);
End;

Function IntPrime(Value: Integer): Boolean;
Var
    i: Integer;
Begin
    Result := False;
    Value := Abs(Value); { 29.10.96 sb }
    If Value Mod 2 <> 0 Then
    Begin
        i := 1;
        Repeat
            i := i + 2;
            Result := Value Mod i = 0
        Until Result Or (i > Trunc(sqrt(Value)));
        Result := Not Result;
    End;
End;

Function IntPercent(a, b: Int_): Int_;
Begin
    Result := Trunc((a / b) * 100);
End;

{ Floating point stuff }

Function IsFlt(s1: String): Boolean;
Var
    i: Integer;
Begin
    Result := True;
    If Length(s1) > 0 Then
    Begin
        For i := 1 To Length(s1) Do
        Begin
            If Not (s1[i] In ['0'..'9', '.']) Then
            Begin
                Result := False;
                Break;
            End;
        End;
    End
    Else
        Result := False;
End;


Function FltAdd(P1, P2: Float; Decimals: Integer): Float;
Begin
    P1 := fltRound(P1, Decimals);
    P2 := fltRound(P2, Decimals);
    Result := fltRound(P1 + P2, Decimals);
End;

Function FltDiv(P1, P2: Float; Decimals: Integer): Float;
Begin
    P1 := fltRound(P1, Decimals);
    P2 := fltRound(P2, Decimals);
    If P2 = 0.0 Then
        P2 := FLTZERO; { provide division by zero }
    Result := fltRound(P1 / P2, Decimals);
End;

Function FltEqual(P1, P2: Float; Decimals: Integer): Boolean;
Var
    Diff: Float;
Begin
    Diff := fltSub(P1, P2, Decimals);
    Result := fltEqualZero(Diff);
End;

Function FltEqualZero(P: Float): Boolean;
Begin
    Result := (P >= -FLTZERO) And (P <= FLTZERO); { 29.10.96 sb }
End;

Function FltGreaterZero(P: Float): Boolean;
Begin
    Result := P > FLTZERO;
End;

Function FltLessZero(P: Float): Boolean;
Begin
    Result := P < -FLTZERO;
End;

Function FltNeg(P: Float; Negate: Boolean): Float;
Begin
    If Negate Then
        Result := -P
    Else
        Result := P;
End;

Function FltMul(P1, P2: Float; Decimals: Integer): Float;
Begin
    P1 := fltRound(P1, Decimals);
    P2 := fltRound(P2, Decimals);
    Result := fltRound(P1 * P2, Decimals);
End;

Function FltRound(P: Float; Decimals: Integer): Float;
Var
    Factor: Longint;
    Help: Float;
Begin
    Factor := IntPow10(Decimals);
    If P < 0 Then
        Help := -0.5
    Else
        Help := 0.5;
    Result := Int(P * Factor + Help) / Factor;
    If fltEqualZero(Result) Then
        Result := 0.00;
End;

Function FltSub(P1, P2: Float; Decimals: Integer): Float;
Begin
    P1 := fltRound(P1, Decimals);
    P2 := fltRound(P2, Decimals);
    Result := fltRound(P1 - P2, Decimals);
End;

Function FltUnEqualZero(P: Float): Boolean;
Begin
    Result := (P < -FLTZERO) Or (P > FLTZERO);
End;

Function FltCalc(Const Expr: String): Float;
Const
    STACKSIZE = 10;
Var
    Stack: Array[0..STACKSIZE] Of Float; { 29.10.96 sb }
    oStack: Array[0..STACKSIZE] Of Char;
    z, n: Float;
    i, j, m: Integer;
    Bracket: Boolean;
Begin
    Bracket := False;
    j := 0;
    n := 1;
    z := 0;
    m := 1;
    For i := 1 To Length(Expr) Do
    Begin
        If Not Bracket Then
            Case Expr[i] Of
                '0'..'9':
                Begin
                    z := z * 10 + ord(Expr[i]) - ord('0');
                    n := n * m;
                End;
                ',', #46:
                    m := 10;
                '(':
                    Bracket := True; {hier Klammeranfang merken, Zähler!!}
                '*', 'x',
                'X',
                '/', '+':
                Begin
                    Stack[j] := z / n;
                    oStack[j] := Expr[i];
                    Inc(j);
                    m := 1;
                    z := 0;
                    n := 1;
                End;
            End {case}
        Else
            Bracket := Expr[i] <> ')'; {hier Rekursiver Aufruf, Zähler !!}
        ;
    End;
    Stack[j] := z / n;
    For i := 1 To j Do
        Case oStack[i - 1] Of
            '*', 'x', 'X':
                Stack[i] := Stack[i - 1] * Stack[i];
            '/':
                Stack[i] := Stack[i - 1] / Stack[i];
            '+':
                Stack[i] := Stack[i - 1] + Stack[i];
        End;
    Result := Stack[j];
End;

Function fltPower(a, n: Float): Float;
Begin
    Result := Exp(n * Ln(a));
End;

Function fltPositiv(Value: Float): Float;
Begin
    Result := Value;
    If Value < 0.0 Then
        Result := 0.0;
End;

Function fltNegativ(Value: Float): Float;
Begin
    Result := Value;
    If Value > 0.0 Then
        Result := 0.0;
End;

{ Rectangle Calculations }

Function RectHeight(Const R: TRect): Integer;
Begin
    Result := R.Bottom - R.Top;
End;

Function RectWidth(Const R: TRect): Integer;
Begin
    Result := R.Right - R.Left;
End;

Procedure RectGrow(Var R: TRect; Delta: Integer);
Begin
    With R Do
    Begin
        Dec(Left, Delta);
        Dec(Top, Delta);
        Inc(Right, Delta);
        Inc(Bottom, Delta);
    End;
End;

Procedure RectRelativeMove(Var R: TRect; DX, DY: Integer);
Begin
    With R Do
    Begin
        Inc(Left, DX);
        Inc(Right, DX);
        Inc(Top, DY);
        Inc(Bottom, DY);
    End;
End;

Procedure RectMoveTo(Var R: TRect; X, Y: Integer);
Begin
    With R Do
    Begin
        Right := X + Right - Left;
        Bottom := Y + Bottom - Top;
        Left := X;
        Top := Y;
    End;
End;

Function RectSet(Left, Top, Right, Bottom: Integer): TRect;
Begin
    Result.Left := Left;
    Result.Top := Top;
    Result.Right := Right;
    Result.Bottom := Bottom;
End;

Function RectSetPoint(Const TopLeft, BottomRight: TPoint): TRect;
Begin
    Result.TopLeft := TopLeft;
    Result.BottomRight := BottomRight;
End;

Function RectInclude(Const R1, R2: TRect): Boolean;
Begin
    Result := (R1.Left >= R2.Left) And (R1.Top >= R2.Top)
        And (R1.Right <= R2.Right) And (R1.Bottom <= R2.Bottom);
End;

Function RectPoint(Const R: TRect; P: TPoint): Boolean;
Begin
    Result := (p.x > r.left) And (p.x < r.right) And (p.y > r.top) And
        (p.y < r.bottom);
End;

Function RectIntersection(Const R1, R2: TRect): TRect;
Begin
    With Result Do
    Begin
        Left := intMax(R1.Left, R2.Left);
        Top := intMax(R1.Top, R2.Top);
        Right := intMin(R1.Right, R2.Right);
        Bottom := intMin(R1.Bottom, R2.Bottom);
    End;

    If Not RectIsValid(Result) Then
        Result := RectSet(0, 0, 0, 0);
End;

Function RectIsIntersection(Const R1, R2: TRect): Boolean;
Begin
    Result := Not RectIsNull(RectIntersection(R1, R2));
End;

Function RectIsValid(Const R: TRect): Boolean;
Begin
    With R Do
        Result := (Left <= Right) And (Top <= Bottom);
End;

Function RectsAreValid(Const Arr: Array Of TRect): Boolean;
Var
    I: Integer;
Begin
    For I := Low(Arr) To High(Arr) Do
        If Not RectIsValid(Arr[I]) Then
        Begin
            Result := False;
            exit;
        End;
    Result := True;
End;

Function RectNull: TRect;
Begin
    Result := RectSet(0, 0, 0, 0);
End;

Function RectIsNull(Const R: TRect): Boolean;
Begin
    With R Do
        Result := (Left = 0) And (Right = 0) And (Top = 0) And (Bottom = 0);
End;

Function RectIsSquare(Const R: TRect): Boolean;
Begin
    Result := RectHeight(R) = RectWidth(R);
End;

Function RectCentralPoint(Const R: TRect): TPoint;
Begin
    Result.X := R.Left + (RectWidth(R) Div 2);
    Result.Y := R.Top + (RectHeight(R) Div 2);
End;

Function rectBounds(aLeft, aTop, aWidth, aHeight: Integer): TRect;
Begin
    Result := rectSet(aLeft, aTop, aLeft + aWidth, aTop + aHeight);
End;

{ variant functions }

{$IFDEF Win32}

Function varIIF(aTest: Boolean; TrueValue, FalseValue: Variant): Variant;
Begin
    If aTest Then
        Result := TrueValue
    Else
        Result := FalseValue;
End;

Procedure varDebug(Const V: Variant);
Begin
    strDebug(varToStr(v));
End;

Function varToStr(Const V: Variant): String;
Begin
    Case TVarData(v).vType Of
        varSmallInt:
            Result := IntToStr(TVarData(v).VSmallInt);
        varInteger:
            Result := IntToStr(TVarData(v).VInteger);
        varSingle:
            Result := FloatToStr(TVarData(v).VSingle);
        varDouble:
            Result := FloatToStr(TVarData(v).VDouble);
        varCurrency:
            Result := FloatToStr(TVarData(v).VCurrency);
        varDate:
            Result := DateToStr(TVarData(v).VDate);
        varBoolean:
            Result := varIIf(TVarData(v).VBoolean, 'True', 'False');
        varByte:
            Result := IntToStr(TVarData(v).VByte);
        varString:
            Result := StrPas(TVarData(v).VString);
        varEmpty,
        varNull,
        varVariant,
        varUnknown,
        varTypeMask,
        varArray,
        varByRef,
        varDispatch,
        varError:
            Result := '';
    End;
End;

{$ENDIF}

{ file functions }

Procedure fileShredder(Const Filename: String);
Var
    aFile: Integer;
    aSize: Integer;
    P: Pointer;
Begin
    aSize := fileSize(Filename);
    aFile := FileOpen(FileName, fmOpenReadWrite);
    Try
        Getmem(P, aSize);
        fillchar(P^, aSize, 'X');
        FileWrite(aFile, P^, aSize);
        Freemem(P, aSize);
    Finally
        FileClose(aFile);
        DeleteFile(Filename);
    End;
End;

Function fileSize(Const FileName: String): Longint;
Var
    SearchRec: TSearchRec;
Begin { !Win32! -> GetFileSize }
    If FindFirst(FileName, faAnyFile, SearchRec) = 0 Then
        Result := SearchRec.Size
    Else
        Result := 0;
End;

Function fileWildcard(Const Filename: String): Boolean;
Begin
    Result := (Pos('*', Filename) <> 0) Or (Pos('?', Filename) <> 0);
End;

Function fileShellOpen(Const aFile: String): Boolean;
Var
    Tmp: Array[0..100] Of Char;
Begin
    Result := ShellExecute(Application.Handle,
        'open', StrPCopy(Tmp, aFile), Nil, Nil, SW_NORMAL) > 32;
End;

Function fileShellPrint(Const aFile: String): Boolean;
Var
    Tmp: Array[0..100] Of Char;
Begin
    Result := ShellExecute(Application.Handle,
        'print', StrPCopy(Tmp, aFile), Nil, Nil, SW_HIDE) > 32;
End;

Function fileCopy(Const SourceFile, TargetFile: String): Boolean;
Const
    BlockSize = 1024 * 16;
Var
    FSource, FTarget: Integer;
    // FFileSize: Longint;
    BRead, Bwrite: Word;
    Buffer: Pointer;
Begin
    Result := False;
    FSource := FileOpen(SourceFile, fmOpenRead + fmShareDenyNone);
    { Open Source }
    If FSource >= 0 Then
        Try
            //FFileSize := FileSeek(FSource, 0, soFromEnd);
            FTarget := FileCreate(TargetFile); { Open Target }
            Try
                getmem(Buffer, BlockSize);
                Try
                    FileSeek(FSource, 0, soFromBeginning);
                    Repeat
                        BRead := FileRead(FSource, Buffer^, BlockSize);
                        BWrite := FileWrite(FTarget, Buffer^, Bread);
                    Until (Bread = 0) Or (Bread <> BWrite);
                    If Bread = Bwrite Then
                        Result := True;
                Finally
                    freemem(Buffer, BlockSize);
                End;
                FileSetDate(FTarget, FileGetDate(FSource));
            Finally
                FileClose(FTarget);
            End;
        Finally
            FileClose(FSource);
        End;
End;

{$IFDEF Win32}

Function fileTemp(Const aExt: String): String;
Var
    Buffer: Array[0..1023] Of Char;
    aFile: String;
Begin
    GetTempPath(Sizeof(Buffer) - 1, Buffer);
    GetTempFileName(Buffer, 'TMP', 0, Buffer);
    SetString(aFile, Buffer, StrLen(Buffer));
    Result := ChangeFileExt(aFile, aExt);
    RenameFile(aFile, Result);
End;

Function fileExec(Const aCmdLine: String; aHide, aWait: Boolean): Boolean;
Var
    StartupInfo: TStartupInfo;
    ProcessInfo: TProcessInformation;
Begin
    {setup the startup information for the application }
    FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
    With StartupInfo Do
    Begin
        cb := SizeOf(TStartupInfo);
        dwFlags := STARTF_USESHOWWINDOW Or STARTF_FORCEONFEEDBACK;
        If aHide Then
            wShowWindow := SW_HIDE
        Else
            wShowWindow := SW_SHOWNORMAL;
    End;

    Result := CreateProcess(Nil, Pchar(aCmdLine), Nil, Nil, False,
        NORMAL_PRIORITY_CLASS, Nil, Nil, StartupInfo, ProcessInfo);
    If aWait Then
        If Result Then
        Begin
            WaitForInputIdle(ProcessInfo.hProcess, INFINITE);
            WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
        End;
End;

Function fileRedirectExec(Const aCmdLine: String; Strings: TStrings): Boolean;
Var
    StartupInfo: TStartupInfo;
    ProcessInfo: TProcessInformation;
    aOutput: Integer;
    aFile: String;
Begin
    Strings.Clear;

    { Create temp. file for output }
    aFile := FileTemp('.tmp');
    aOutput := FileCreate(aFile);
    Try
        {setup the startup information for the application }
        FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
        With StartupInfo Do
        Begin
            cb := SizeOf(TStartupInfo);
            dwFlags := STARTF_USESHOWWINDOW Or STARTF_FORCEONFEEDBACK Or
                STARTF_USESTDHANDLES;
            wShowWindow := SW_HIDE;
            hStdInput := INVALID_HANDLE_VALUE;
            hStdOutput := aOutput;
            hStdError := INVALID_HANDLE_VALUE;
        End;

        Result := CreateProcess(Nil, Pchar(aCmdLine), Nil, Nil, False,
            NORMAL_PRIORITY_CLASS, Nil, Nil, StartupInfo, ProcessInfo);
        If Result Then
        Begin
            WaitForInputIdle(ProcessInfo.hProcess, INFINITE);
            WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
        End;
    Finally
        FileClose(aOutput);
        Strings.LoadFromFile(aFile);
        DeleteFile(aFile);
    End;
End;

Function fileLongName(Const aFile: String): String;
Var
    aInfo: TSHFileInfo;
Begin
    If SHGetFileInfo(Pchar(aFile), 0, aInfo, Sizeof(aInfo),
        SHGFI_DISPLAYNAME) <> 0 Then
        Result := StrPas(aInfo.szDisplayName)
    Else
        Result := aFile;
End;

Function fileTypeName(Const aFile: String): String;
Var
    aInfo: TSHFileInfo;
Begin
    If SHGetFileInfo(Pchar(aFile), 0, aInfo, Sizeof(aInfo),
        SHGFI_TYPENAME) <> 0 Then
        Result := StrPas(aInfo.szTypeName)
    Else
    Begin
        Result := ExtractFileExt(aFile);
        Delete(Result, 1, 1);
        Result := strUpper(Result) + ' File';
    End;
End;

Function fileShortName(Const aFile: String): String;
Var
    aTmp: Array[0..255] Of Char;
Begin
    If GetShortPathName(Pchar(aFile), aTmp, Sizeof(aTmp) - 1) = 0 Then
        Result := aFile
    Else
        Result := StrPas(aTmp);
End;

{$ENDIF}

Function ExtractName(Const Filename: String): String;
Var
    aExt: String;
    aPos: Integer;
Begin
    aExt := ExtractFileExt(Filename);
    Result := ExtractFileName(Filename);
    If aExt <> '' Then
    Begin
        aPos := Pos(aExt, Result);
        If aPos > 0 Then
            Delete(Result, aPos, Length(aExt));
    End;
End;

{ date calculations }

Function dateYear(D: TDateTime): Integer;
Var
    Year, Month, Day: Word;
Begin
    DecodeDate(D, Year, Month, Day);
    Result := Year;
End;

Function dateMonth(D: TDateTime): Integer;
Var
    Year, Month, Day: Word;
Begin
    DecodeDate(D, Year, Month, Day);
    Result := Month;
End;

Function dateBeginOfYear(D: TDateTime): TDateTime;
Var
    Year, Month, Day: Word;
Begin
    DecodeDate(D, Year, Month, Day);
    Result := EncodeDate(Year, 1, 1);
End;

Function dateEndOfYear(D: TDateTime): TDateTime;
Var
    Year, Month, Day: Word;
Begin
    DecodeDate(D, Year, Month, Day);
    Result := EncodeDate(Year, 12, 31);
End;

Function dateBeginOfMonth(D: TDateTime): TDateTime;
Var
    Year, Month, Day: Word;
Begin
    DecodeDate(D, Year, Month, Day);
    Result := EncodeDate(Year, Month, 1);
End;

Function dateEndOfMonth(D: TDateTime): TDateTime;
Var
    Year, Month, Day: Word;
Begin
    DecodeDate(D, Year, Month, Day);
    If Month = 12 Then
    Begin
        Inc(Year);
        Month := 1;
    End
    Else
        Inc(Month);
    Result := EncodeDate(Year, Month, 1) - 1;
End;

Function dateWeekOfYear(D: TDateTime): Integer; { Armin Hanisch }
Const
    t1: Array[1..7] Of Shortint = (-1, 0, 1, 2, 3, -3, -2);
    t2: Array[1..7] Of Shortint = (-4, 2, 1, 0, -1, -2, -3);
Var
    doy1,
    doy2: Integer;
    NewYear: TDateTime;
Begin
    NewYear := dateBeginOfYear(D);
    doy1 := dateDayofYear(D) + t1[DayOfWeek(NewYear)];
    doy2 := dateDayofYear(D) + t2[DayOfWeek(D)];
    If doy1 <= 0 Then
        Result := dateWeekOfYear(NewYear - 1)
    Else
    If (doy2 >= dateDayofYear(dateEndOfYear(NewYear))) Then
        Result := 1
    Else
        Result := (doy1 - 1) Div 7 + 1;
End;

Function dateDayOfYear(D: TDateTime): Integer;
Begin
    Result := Trunc(D - dateBeginOfYear(D)) + 1;
End;

Function dateDayOfWeek(D: TDateTime): TDayOfWeek;
Begin
    Result := TDayOfWeek(Pred(DayOfWeek(D)));
End;

Function dateLeapYear(D: TDateTime): Boolean;
Var
    Year, Month, Day: Word;
Begin
    DecodeDate(D, Year, Month, Day);
    Result := (Year Mod 4 = 0) And ((Year Mod 100 <> 0) Or (Year Mod 400 = 0));
End;

Function dateBeginOfQuarter(D: TDateTime): TDateTime;
Var
    Year, Month, Day: Word;
Begin
    DecodeDate(D, Year, Month, Day);
    Result := EncodeDate(Year, ((Month - 1 Div 3) * 3) + 1, 1);
End;

Function dateEndOfQuarter(D: TDateTime): TDateTime;
Begin
    Result := dateBeginOfQuarter(dateBeginOfQuarter(D) + (3 * 31)) - 1;
End;

Function dateBeginOfWeek(D: TDateTime; Weekday: Integer): TDateTime;
Begin
    Result := D;
    While DayOfWeek(Result) <> Weekday Do
        Result := Result - 1;
End;

Function dateDaysInMonth(D: TDateTime): Integer;
Const
    DaysPerMonth: Array[1..12] Of Byte =
        (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
Var
    Month: Integer;
Begin
    Month := dateMonth(D);
    Result := DaysPerMonth[Month];
    If (Month = 2) And dateLeapYear(D) Then
        Inc(Result);
End;

Function dateDay(D: TDateTime): Integer;
Var
    Year, Month, Day: Word;
Begin
    DecodeDate(D, Year, Month, Day);
    Result := Day;
End;

Function dateQuicken(D: TDateTime; Var Key: Char): TDateTime;
Const
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
Begin
    Case Upcase(Key) Of { Quicken Date Fast Keys }
        '+':
            Result := D + 1;
        '-':
            Result := D - 1;
        _ToDay:
            Result := Date;
        _PrevYear:
            If D <> dateBeginOfYear(D) Then
                Result := dateBeginOfYear(D)
            Else
                Result := dateBeginOfYear(D - 1);
        _NextYear:
            If D <> dateEndOfYear(D) Then
                Result := dateEndOfYear(D)
            Else
                Result := dateEndOfYear(Date + 1);
        _PrevMonth:
            If D <> dateBeginOfMonth(D) Then
                Result := dateBeginOfMonth(D)
            Else
                Result := dateBeginOfMonth(D - 1);
        _NextMonth:
            If D <> dateEndOfMonth(D) Then
                Result := dateEndOfMonth(D)
            Else
                Result := dateEndOfMonth(D + 1);
        _BeginQuart:
            Result := dateBeginOfQuarter(D);
        _EndQuart:
            Result := dateEndOfQuarter(D);
    Else
    Begin
        Result := D;
        exit;
    End;
    End;
    Key := #0;
End;

{ time functions }

Function timeHour(T: TDateTime): Integer;
Var
    Hour, Minute, Sec, Sec100: Word;
Begin
    DecodeTime(T, Hour, Minute, Sec, Sec100);
    Result := Hour;
End;

Function timeMin(T: TDateTime): Integer;
Var
    Hour, Minute, Sec, Sec100: Word;
Begin
    DecodeTime(T, Hour, Minute, Sec, Sec100);
    Result := Minute;
End;

Function timeSec(T: TDateTime): Integer;
Var
    Hour, Minute, Sec, Sec100: Word;
Begin
    DecodeTime(T, Hour, Minute, Sec, Sec100);
    Result := Sec;
End;

Function timeToInt(T: TDateTime): Integer;
Begin
    Result := Trunc((MSecsPerday * T) / 1000);
End;

{$IFDEF Win32}

{$WARNINGS OFF}
Function timeZoneOffset: Integer;
Var
    aTimeZoneInfo: TTimeZoneInformation;
Begin
    If GetTimeZoneInformation(aTimeZoneInfo) <> -1 Then
        Result := aTimeZoneInfo.Bias
    Else
        Result := 0;
End;
{$WARNINGS ON}
{$ENDIF}

{ Communications Functions }

Function comIsCis(Const S: String): Boolean;
Var
    aSt: String;
    PreId,
    PostId: Integer;
Begin
    Result := strContainsU('@compuserve.com', S);
    { 28.7.96 sb This is also on CIS }
    If Not Result Then
        If Pos(',', S) > 0 Then
            Try
                aSt := S;
                PreId := StrToInt(strToken(aSt, ','));
                PostId := StrToInt(aSt);
                Result := (PreId > 0) And (PostId > 0);
            Except
                Result := False;
            End;
End;

Function comIsInt(Const S: String): Boolean;
Var
    aSt: String;
    PreId,
    PostId: String;
Begin
    Try
        aSt := S;
        PreId := strToken(aSt, '@');
        PostId := aSt;
        Result := (Length(PreId) > 0) And (Length(PostId) > 0);
    Except
        Result := False;
    End;
End;

{ converts a CIS adress to a correct Internet adress }

Function comCisToInt(Const S: String): String;
Var
    P: Integer;
Begin
    p := Pos('INTERNET:', S);
    If P = 1 Then
        Result := Copy(S, P + 1, Length(S))
    Else
    Begin
        Result := S;
        P := Pos(',', Result);
        If P > 0 Then
            Result[P] := '.';
        Result := Result + '@compuserve.com'; { 22.07.96 sb  Error }
    End;
End;

{ converts a internet adress to a correct CServe adress }

Function comIntToCis(Const S: String): String;
Var
    P: Integer;
Begin
    p := Pos('@COMPUSERVE.COM', strUpper(S));
    If p > 0 Then
    Begin
        Result := strLeft(S, P - 1);
        P := Pos('.', Result);
        If P > 0 Then
            Result[P] := ',';
    End
    Else
        Result := 'INTERNET:' + S;
End;

{ converts a fax adress to a correct CServe adress }

Function comFaxToCis(Const S: String): String;
Begin
    Result := 'FAX:' + S;
End;

Function comNormFax(Const Name, Fax: String): String;
Begin
    If Name <> '' Then
        Result := Name + '[fax: ' + Name + '@' + strTrim(Fax) + ']'
    Else
        Result := '[fax: ' + strTrim(Fax) + ']';
End;

Function comNormInt(Const Name, Int: String): String;
Begin
    Result := '';
    If comIsInt(Int) Then
        If Name <> '' Then
            Result := Name + '|smtp: ' + strTrim(Int)
        Else
            Result := 'smtp: ' + strTrim(Int);
End;

Function comNormCis(Const Name, Cis: String): String;
Begin
    Result := '';
    If Name <> '' Then
        Result := Name + '[compuserve: ' + strTrim(Cis) + ']'
    Else
        Result := '[compuserve: ' + strTrim(Cis) + ']';
End;

Function comNormPhone(Const Phone: String): String;

    Function strValueAt(Const S: String; At: Integer): String;
    Const
        Seperator = ',';
        Str = '"';
    Var
        j, i: Integer;
        FSkip: Boolean;
    Begin
        Result := '';
        j := 1;
        i := 0;
        FSkip := False;
        While (i <= At) And (j <= Length(S)) Do
        Begin
            If (S[j] = Str) Then
                FSkip := Not FSkip
            Else
            If (S[j] = Seperator) And Not FSkip Then
                Inc(i)
            Else
            If i = At Then
                Result := Result + S[j];
            Inc(j);
        End;
    End;

Var
    aNumber,
    aCountry,
    aPrefix,
    aDefault,
    aLocation: String;

    i: Integer;
Begin
    aDefault := '1,"Hamburg","","","40",49,0,0,0,"",1," "';
    aLocation := strProfile('telephon.ini', 'Locations',
        'CurrentLocation', '');
    If aLocation <> '' Then
    Begin
        aLocation := strTokenAt(aLocation, ',', 0);
        If aLocation <> '' Then
        Begin
            aLocation := strProfile('telephon.ini', 'Locations',
                'Location' + aLocation, '');
            If aLocation <> '' Then
                aDefault := aLocation;
        End;
    End;

    Result := '';
    aNumber := strTrim(Phone);
    If aNumber <> '' Then
        For i := Length(aNumber) Downto 1 Do
            If Not (aNumber[i] In DIGITS) Then
            Begin
                If aNumber[i] <> '+' Then
                    aNumber[i] := '-';
                If i < Length(aNumber) Then { remove duplicate digits }
                    If aNumber[i] = aNumber[i + 1] Then
                        Delete(aNumber, i, 1);
            End;

    If aNumber <> '' Then
    Begin
        If aNumber[1] = '+' Then
            aCountry := strToken(aNumber, '-')
        Else
            aCountry := '+' + strValueAt(aDefault, 5);

        aNumber := strTrimChL(aNumber, '-');

        If aNumber <> '' Then
        Begin
            If strTokenCount(aNumber, '-') > 1 Then
                aPrefix := strTrimChL(strToken(aNumber, '-'), '0')
            Else
                aPrefix := strValueAt(aDefault, 4);

            aNumber := strNicePhone(strTrimChA(aNumber, '-'));
            Result := aCountry + ' (' + aPrefix + ') ' + aNumber;
        End;
    End;
End;

{ system functions }

{$IFDEF Win32}

Function sysTempPath: String;
Var
    Buffer: Array[0..1023] Of Char;
Begin
    SetString(Result, Buffer, GetTempPath(Sizeof(Buffer) - 1, Buffer));
End;
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

Procedure sysDelay(aMs: Longint);
Var
    TickCountNow, TickCountStart: Longint;
Begin
    TickCountStart := GetTickCount;
    TickCountNow := GetTickCount;
    While TickCountNow - TickCountStart < aMs Do
    Begin
        TickCountNow := GetTickCount;
        Application.ProcessMessages;
    End;
End;

Procedure sysBeep;
Begin
    messageBeep($FFFF);
End;

Function sysColorDepth: Integer;
Var
    aDC: hDC;
Begin
    aDC := GetDC(0);
    Try
        Result := 1 Shl (GetDeviceCaps(aDC, PLANES) *
            GetDeviceCaps(aDC, BITSPIXEL));
    Finally
        ReleaseDC(0, aDC);
    End;
End;

{$IFDEF Win32}

Function GetShellFoldername(folderID: Integer): String;
Var
    pidl: PItemIDList;
    buf: Array[0..MAX_PATH] Of Char;
Begin
    Result := '';
    If Succeeded(ShGetSpecialFolderLocation(GetActiveWindow,
        folderID, pidl)) Then
    Begin
        If ShGetPathfromIDList(pidl, buf) Then
            Result := buf;
        CoTaskMemFree(pidl);
    End; { If }

    If Result = '' Then
    Begin
        Result := ExtractFileDir(Application.ExeName);
    End;

End; { GetShellFoldername }

Procedure sysSaverRunning(Active: Boolean);
Var
    aParam: Longint;
Begin
    SystemParametersInfo(SPI_SCREENSAVERRUNNING, Word(Active), @aParam, 0);
End;
{$ENDIF}

{ registry functions }

{$IFDEF Win32 }

Procedure regParsePath(Const Path: String; Var aPath, aValue: String);
Begin
    aPath := Path;
    aValue := '';
    While (Length(aPath) > 0) And (strLastCh(aPath) <> '\') Do
    Begin
        aValue := strLastCh(aPath) + aValue;
        strStripLast(aPath);
    End;
End;

Function regReadString(aKey: HKEY; Const Path: String): String;
Var
    aRegistry: TRegistry;
    aPath: String;
    aValue: String;
Begin
    aRegistry := TRegistry.Create(KEY_READ);
    Try
        With aRegistry Do
        Begin
            RootKey := aKey;
            regParsePath(Path, aPath, aValue);
            OpenKey(aPath, True);
            Result := ReadString(aValue);
        End;
    Finally
        aRegistry.Free;
    End;
End;

Procedure regWriteString(aKey: HKEY; Const Path, Value: String);
Var
    aRegistry: TRegistry;
    aPath: String;
    aValue: String;
Begin
    aRegistry := TRegistry.Create;
    Try
        With aRegistry Do
        Begin
            RootKey := aKey;
            regParsePath(Path, aPath, aValue);
            OpenKey(aPath, True);
            WriteString(aValue, Value);
        End;
    Finally
        aRegistry.Free;
    End;
End;

Procedure regDelValue(aKey: hKey; Const Path: String);
Var
    aRegistry: TRegistry;
    aPath: String;
    aValue: String;
Begin
    aRegistry := TRegistry.Create;
    Try
        With aRegistry Do
        Begin
            RootKey := aKey;
            regParsePath(Path, aPath, aValue);
            OpenKey(aPath, True);
            DeleteValue(aValue);
        End;
    Finally
        aRegistry.Free;
    End;
End;

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

Function regInfoString(Const Value: String): String;
Var
    aKey: hKey;
Begin
    Result := '';
    If RegOpenKey(HKEY_LOCAL_MACHINE, REG_CURRENT_VERSION, aKey) =
        ERROR_SUCCESS Then
    Begin
        Result := regReadString(aKey, Value);
        RegCloseKey(aKey);
    End;
End;

Function regCurrentUser: String;
Begin
    Result := regInfoString(REG_CURRENT_USER);
End;

Function regCurrentCompany: String;
Begin
    Result := regInfoString(REG_CURRENT_COMPANY);
End;

{ Add a shell extension to the registry }

Procedure regWriteShellExt(Const aExt, aCmd, aMenu, aExec: String);
Var
    s, aPath: String;
Begin
    With TRegistry.Create Do
        Try
            RootKey := HKEY_CLASSES_ROOT;
            aPath := aExt;
            If KeyExists(aPath) Then
            Begin
                OpenKey(aPath, False);
                S := ReadString('');
                CloseKey;
                If S <> '' Then
                    If KeyExists(S) Then
                        aPath := S;
            End;

            OpenKey(aPath + '\Shell\' + aCmd, True);
            WriteString('', aMenu);
            CloseKey;

            OpenKey(aPath + '\Shell\' + aCmd + '\Command', True);
            WriteString('', aExec + ' %1');
            CloseKey;
        Finally
            Free;
        End;
End;

Procedure regValueList(aKey: HKEY; Const Path: String;
    Var aValue: TStringList);
Var
    aRegistry: TRegistry;
Begin
    aRegistry := TRegistry.Create;
    Try
        With aRegistry Do
        Begin
            RootKey := aKey;
            OpenKey(Path, True);
            GetValueNames(aValue);
        End;
    Finally
        aRegistry.Free;
    End;
End;

Procedure regKeyList(aKey: HKEY; Const Path: String; Var aValue: TStringList);
Var
    aRegistry: TRegistry;
Begin
    aRegistry := TRegistry.Create;
    Try
        With aRegistry Do
        Begin
            RootKey := aKey;
            OpenKey(Path, True);
            GetKeyNames(aValue);
        End;
    Finally
        aRegistry.Free;
    End;
End;

Function regValueExist(aKey: HKEY; Const Path: String): Boolean;
Var
    aRegistry: TRegistry;
    aPath: String;
    aValue: String;
Begin
    aRegistry := TRegistry.Create;
    Try
        With aRegistry Do
        Begin
            RootKey := aKey;
            regParsePath(Path, aPath, aValue);
            OpenKey(aPath, True);
            Result := ValueExists(aValue);
        End;
    Finally
        aRegistry.Free;
    End;
End;

Function regReadValue(aKey: HKEY; Const Path: String; Typ: TDataType): Variant;
Var
    aRegistry: TRegistry;
    aPath: String;
    aValue: String;
Begin
    aRegistry := TRegistry.Create;
    Try
        With aRegistry Do
        Begin
            RootKey := aKey;
            regParsePath(Path, aPath, aValue);
            If OpenKey(aPath, True) Then
                If ValueExists(aValue) Then
                    Case Typ Of
                        dtInteger:
                            Result := ReadInteger(aValue);
                        dtBoolean:
                            Result := ReadBool(aValue);
                        dtString:
                            Result := ReadString(aValue);
                        dtDate:
                            Result := ReadDate(aValue);
                        dtFloat:
                            Result := ReadFloat(aValue);
                        dtCurrency:
                            Result := ReadCurrency(aValue);
                        dtTime:
                            Result := REadTime(aValue);
                    End;
        End;
    Finally
        aRegistry.Free;
    End;
End;

Function regWriteValue(aKey: HKEY; Const Path: String;
    Value: Variant; Typ: TDataType): Boolean;
Var
    aRegistry: TRegistry;
    aPath: String;
    aValue: String;
Begin
    aRegistry := TRegistry.Create;
    Try
        With aRegistry Do
        Begin
            RootKey := aKey;
            regParsePath(Path, aPath, aValue);
            If OpenKey(aPath, True) Then
                Case Typ Of
                    dtInteger:
                        WriteInteger(aValue, Value);
                    dtBoolean:
                        WriteBool(aValue, Value);
                    dtString:
                        WriteString(aValue, Value);
                    dtDate:
                        WriteDate(aValue, Value);
                    dtFloat:
                        WriteFloat(aValue, Value);
                    dtCurrency:
                        WriteCurrency(aValue, Value);
                    dtTime:
                        WriteTime(aValue, Value);
                End
	           Else
		              Raise Exception.CreateFmt('', []);
	       End;
    Except
	       Begin
	           Result := False;
	           aRegistry.Free;
	           exit;
	       End
    End;
    Result := True;
    aRegistry.Free;
End;

{$ENDIF}

{ other stuff }

Function MsgBox(Const aTitle, aMsg: String; aFlag: Integer): Integer;
Var
    ActiveWindow: hWnd;
    WindowList: Pointer;
    TmpA: Array[0..200] Of Char;
    TmpB: Array[0..100] Of Char;
Begin
    ActiveWindow := GetActiveWindow;
    WindowList := DisableTaskWindows(0);
    Try
        StrPCopy(TmpB, aTitle);
        StrPCopy(TmpA, aMsg);
{$IFDEF Win32}
        Result := Windows.MessageBox(Application.Handle, TmpA, TmpB, aFlag);
{$ELSE}
        Result := WinProcs.MessageBox(Application.Handle, TmpA, TmpB, aFlag);
{$ENDIF}
    Finally
        EnableTaskWindows(WindowList);
        SetActiveWindow(ActiveWindow);
    End;
End;

{ TPersistentRect }

Constructor TPersistentRect.Create;
Begin
    FRect := rectSet(10, 10, 100, 20);
End;

Procedure TPersistentRect.Assign(Source: TPersistent);
Var
    Value: TPersistentRect;
Begin
    Value := Nil;
    If Value Is TPersistentRect Then
    Begin
        Value := Source As TPersistentRect;
        FRect := rectBounds(Value.Left, Value.Top, Value.Width, Value.Height);
        exit;
    End;
    Inherited Assign(Source);
End;

Procedure TPersistentRect.SetLeft(Value: Integer);
Begin
    If Value <> Left Then
    Begin
        If Assigned(FOnConvert) Then
            Value := FOnConvert(Self, Value, False);
        FRect := rectBounds(Value, Top, Width, Height);
    End;
End;

Procedure TPersistentRect.SetTop(Value: Integer);
Begin
    If Value <> Top Then
    Begin
        If Assigned(FOnConvert) Then
            Value := FOnConvert(Self, Value, False);
        FRect := rectBounds(Left, Value, Width, Height);
    End;
End;

Procedure TPersistentRect.SetHeight(Value: Integer);
Begin
    If Value <> Height Then
    Begin
        If Assigned(FOnConvert) Then
            Value := FOnConvert(Self, Value, False);
        FRect := rectBounds(Left, Top, Width, Value);
    End;
End;

Procedure TPersistentRect.SetWidth(Value: Integer);
Begin
    If Value <> Width Then
    Begin
        If Assigned(FOnConvert) Then
            Value := FOnConvert(Self, Value, False);
        FRect := rectBounds(Left, Top, Value, Height);
    End;
End;

Function TPersistentRect.GetLeft: Integer;
Begin
    Result := FRect.Left;
    If Assigned(FOnConvert) Then
        Result := FOnConvert(Self, Result, True);
End;

Function TPersistentRect.GetTop: Integer;
Begin
    Result := FRect.Top;
    If Assigned(FOnConvert) Then
        Result := FOnConvert(Self, Result, True);
End;

Function TPersistentRect.GetHeight: Integer;
Begin
    Result := rectHeight(FRect);
    If Assigned(FOnConvert) Then
        Result := FOnConvert(Self, Result, True);
End;

Function TPersistentRect.GetWidth: Integer;
Begin
    Result := rectWidth(FRect);
    If Assigned(FOnConvert) Then
        Result := FOnConvert(Self, Result, True);
End;

{$IFDEF Win32}

{ TPersistentRegistry }
{$IFDEF PLUGIN_BUILD}{$HINTS OFF}{$ENDIF}
Function TPersistentRegistry.ReadComponent(Const Name: String;
    Owner, Parent: TComponent): TComponent;
Var
    DataSize: Integer;
    MemStream: TMemoryStream;
    Reader: TReader;
Begin
    Result := Nil;
    DataSize := GetDataSize(Name);
    MemStream := TMemoryStream.Create;
    Try
        MemStream.SetSize(DataSize);
        ReadBinaryData(Name, MemStream.Memory^, DataSize);
        MemStream.Position := 0;

        Reader := TReader.Create(MemStream, 256);
        Try
            Reader.Parent := Parent;
            Result := Reader.ReadRootComponent(Nil);
            If Owner <> Nil Then
                Try
                    Owner.InsertComponent(Result);
                Except
                    Result.Free;
                    Raise;
                End;
        Finally
            Reader.Free;
        End;

    Finally
        MemStream.Free;
    End;
End;
{$IFDEF PLUGIN_BUILD}{$HINTS ON}{$ENDIF}

Procedure TPersistentRegistry.WriteComponent(Const Name: String;
    Component: TComponent);
Var
    MemStream: TMemoryStream;
Begin
    MemStream := TMemoryStream.Create;
    Try
        MemStream.WriteComponent(Component);
        WriteBinaryData(Name, MemStream.Memory^, MemStream.Size);
    Finally
        MemStream.Free;
    End;
End;

{$ENDIF}

{ TSystemMetric }

Constructor TSystemMetric.Create;
Begin
    Inherited Create;
    Update;
End;

Procedure TSystemMetric.Update;

    Function GetSystemPoint(ax, ay: Integer): TPoint;
    Begin
        Result := Point(GetSystemMetrics(ax), GetSystemMetrics(ay));
    End;

Begin
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
End;

{ TDesktopCanvas }

Constructor TDesktopCanvas.Create;
Begin
    Inherited Create;
    DC := GetDC(0);
    Handle := DC;
End;

Destructor TDesktopCanvas.Destroy;
Begin
    Handle := 0;
    ReleaseDC(0, DC);
    Inherited Destroy;
End;

{$IFNDEF Win32}

procedure DoneXProcs; far;
begin
    SysMetric.Free;
end;

{$ENDIF}

{$IFDEF Win32}

Function CheckNT: Boolean;
Var
    aVersion: TOSVersionInfo;
Begin
    aVersion.dwOSVersionInfoSize := SizeOf(aVersion);
    Result := GetVersionEx(aVersion) And (aVersion.dwPLatformId =
        VER_PLATFORM_WIN32_NT);
End;
{$ENDIF}

{inetFunctions}

Procedure OpenURL(Const URL: String);
{ Opens URL }

{$IFNDEF WIN32}
var
    Buffer: array[0..255] of Char;
{$ENDIF}
Begin
    If URL <> '' Then
{$IFNDEF WIN32}
        ShellExecute(Application.Handle, 'open',
            StrPCopy(Buffer, URL), nil, nil, SW_SHOW)
{$ELSE}
        ShellExecute(Application.Handle, 'open',
            Pchar(URL), Nil, Nil, SW_SHOW);
{$ENDIF}
End; { OpenURL }

Function UnixPathToDosPath(Const Path: String): String;
Begin
    Result := strReplace(Path, '/', '\');
End;

Function DosPathToUnixPath(Const Path: String): String;
Begin
    Result := strReplace(Path, '\', '/');
End;

Function HTTPDecode(Const AStr: String): String;
Var
    Sp, Rp, Cp: Pchar;
    S: String;
Begin
    SetLength(Result, Length(AStr));
    Sp := Pchar(AStr);
    Rp := Pchar(Result);
    Try
        While Sp^ <> #0 Do
        Begin
            Case Sp^ Of
                '+':
                    Rp^ := ' ';
                '%':
                Begin
                    // Look for an escaped % (%%) or %<hex> encoded character
                    Inc(Sp);
                    If Sp^ = '%' Then
                        Rp^ := '%'
                    Else
                    Begin
                        Cp := Sp;
                        Inc(Sp);
                        If (Cp^ <> #0) And (Sp^ <> #0) Then
                        Begin
                            S := '$' + Cp^ + Sp^;
                            Rp^ := Chr(StrToInt(S));
                        End;
                        //else
                        //  raise Exception.CreateFmt('Encoding Error');
                    End;
                End;
            Else
                Rp^ := Sp^;
            End;
            Inc(Rp);
            Inc(Sp);
        End;
    Except
        on E: EConvertError Do
        Begin
        End;
        //raise EConvertError.CreateFmt('httpEncodeError')
    End;
    SetLength(Result, Rp - Pchar(Result));
End;

Function HTTPEncode(Const AStr: String): String;
Const
    NoConversion = ['A'..'Z', 'a'..'z', '*', '@', '.', '_', '-',
        '0'..'9', '$', '!', '''', '(', ')'];
Var
    Sp, Rp: Pchar;
Begin
    SetLength(Result, Length(AStr) * 3);
    Sp := Pchar(AStr);
    Rp := Pchar(Result);
    While Sp^ <> #0 Do
    Begin
        If Sp^ In NoConversion Then
            Rp^ := Sp^
        Else
        If Sp^ = ' ' Then
            Rp^ := '+'
        Else
        Begin
            FormatBuf(Rp^, 3, '%%%.2x', 6, [Ord(Sp^)]);
            Inc(Rp, 2);
        End;
        Inc(Rp);
        Inc(Sp);
    End;
    SetLength(Result, Rp - Pchar(Result));
End;

Initialization
    Randomize;

    SysMetric := TSystemMetric.Create;
    IsWin95 := (GetVersion And $FF00) >= $5F00;
{$IFDEF Win32}
    IsWinNT := CheckNT;
{$ELSE}
    IsWinNT := False;
{$ENDIF}

    IsFabula := Nil;

{$IFDEF Win32}
    xLanguage := (LoWord(GetUserDefaultLangID) And $3FF);
    Case xLanguage Of
        LANG_GERMAN:
            xLangOfs := 70000;
        LANG_ENGLISH:
            xLangOfs := 71000;
        LANG_SPANISH:
            xLangOfs := 72000;
        LANG_RUSSIAN:
            xLangOfs := 73000;
        LANG_ITALIAN:
            xLangOfs := 74000;
        LANG_FRENCH:
            xLangOfs := 75000;
        LANG_PORTUGUESE:
            xLangOfs := 76000;
    Else
        xLangOfs := 71000;
    End;
{$ENDIF}

{$IFDEF Win32}
Finalization
    SysMetric.Free;
{$ELSE}
    AddExitProc(DoneXProcs);
{$ENDIF}
End.
