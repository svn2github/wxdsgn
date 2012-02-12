Unit LanguagesDEPfix;

{ Patch for Data Execution Prevention (DEP) problems with SysUtils.TLanguages. }
{ In the Delphi RTL the TLanguages constructor dynamically builds and executes }
{ machine code in the stack segment without setting the PAGE_EXECUTE_READWRITE }
{ or PAGE_EXECUTE_WRITECOPY bits. It appears that that code doesn't run on     }
{ systems that have DEP enabled - e.g. WinXP SP2, Win2003 SP1. Note that       }
{ Win2003 SP1 has DEP activated by default.                                    }
{ This problem is fixed in the Delphi 2005 RTL.                                }
{                                                                              }
{ Usage:                                                                       }
{ Put this unit as the first unit in the uses clause of the source of the      }
{ project. At least make sure this unit is listed *before* the first SysUtils. }
{ Tested with D5, D6 and D7.                                                   }
{                                                                              }
{ Author: Sasan Adami - s.adami@gmx.net                                        }
{ Date  : 20 july 2005                                                         }
{ Disclaimer: use at your own risk!                                            }

{$WARN SYMBOL_PLATFORM OFF}
Interface

Uses
    Windows, Classes;

Implementation

Uses
    SysUtils, SysConst;

Type
    PJumpRec = ^TJumpRec;
    TJumpRec = Packed Record
        OpCode: Byte;
        Address: DWord;
    End;

    PLongJumpRec = ^TLongJumpRec;
    TLongJumpRec = Packed Record
        OpCode: Word;
        Address: DWord;
    End;

    // hack for access to private members of TLanguage
    THackLanguages = Class
    Private
        FSysLangs: Array Of TLangRec;
    End;

    // replacement for TLanguages.Create
    TLanguagesDEPfix = Class(TLanguages)
    Private
        Function LocalesCallback(LocaleID: Pchar): Integer; Stdcall;
    Public
        Constructor Create;
    End;

Var
    FTempLanguages: TLanguagesDEPfix;

Function EnumLocalesCallback(LocaleID: Pchar): Integer; Stdcall;
Begin
    Result := FTempLanguages.LocalesCallback(LocaleID);
End;

Function GetLocaleDataW(ID: LCID; Flag: DWORD): String;
Var
    Buffer: Array[0..1023] Of Widechar;
Begin
    Buffer[0] := #0;
    GetLocaleInfoW(ID, Flag, Buffer, SizeOf(Buffer) Div 2);
    Result := Buffer;
End;

Function GetLocaleDataA(ID: LCID; Flag: DWORD): String;
Var
    Buffer: Array[0..1023] Of Char;
Begin
    Buffer[0] := #0;
    SetString(Result, Buffer, GetLocaleInfoA(ID, Flag, Buffer,
        SizeOf(Buffer)) - 1);
End;

{ TLanguagesDEPfix }

Function TLanguagesDEPfix.LocalesCallback(LocaleID: Pchar): Integer; Stdcall;
Type
    PSysLangs = ^TSysLangs;
    TSysLangs = Array Of TLangRec;
Var
    AID: LCID;
    ShortLangName: String;
    GetLocaleDataProc: Function(ID: LCID; Flag: DWORD): String;
    PSLangs: PSysLangs;
Begin
    If Win32Platform = VER_PLATFORM_WIN32_NT Then
        GetLocaleDataProc := @GetLocaleDataW
    Else
        GetLocaleDataProc := @GetLocaleDataA;
    AID := StrToInt('$' + Copy(LocaleID, 5, 4));
    ShortLangName := GetLocaleDataProc(AID, LOCALE_SABBREVLANGNAME);
    If ShortLangName <> '' Then
    Begin
        PSLangs := @THackLanguages(Self).FSysLangs;
        SetLength(PSLangs^, Length(PSLangs^) + 1);
        With PSLangs^[High(PSLangs^)] Do
        Begin
            FName := GetLocaleDataProc(AID, LOCALE_SLANGUAGE);
            FLCID := AID;
            FExt := ShortLangName;
        End;
    End;
    Result := 1;
End;

Constructor TLanguagesDEPfix.Create;
Begin
    FTempLanguages := Self;
    EnumSystemLocales(@EnumLocalesCallback, LCID_SUPPORTED);
End;

Var
    FLanguages: TLanguagesDEPfix;

Function Languages: TLanguages;
Begin
    If FLanguages = Nil Then
        FLanguages := TLanguagesDEPfix.Create;
    Result := FLanguages;
End;

Procedure ApplyLanguagesDEPfix;
Var
    JumpRec: PJumpRec;
    LongJumpRec: PLongJumpRec;
    OldProtect: DWord;
    IsPackages: Boolean;
Begin
    JumpRec := PJumpRec(@SysUtils.Languages);
    LongJumpRec := Pointer(JumpRec);

    IsPackages := LongJumpRec.OpCode = $25FF; // runtime package?
    If IsPackages Then
        JumpRec := Pointer(PDWord(LongJumpRec.Address)^);

    If Not VirtualProtect(JumpRec, SizeOf(JumpRec^),
        PAGE_EXECUTE_WRITECOPY, @OldProtect) Then
        // If we cannot change the access right the following line will crash. Exit here anyway.
        Exit;
    JumpRec.OpCode := $E9; // 32bit jump near
    JumpRec.Address := Integer(@Languages) - Integer(JumpRec) - 5;
    VirtualProtect(JumpRec, SizeOf(JumpRec^), OldProtect, @OldProtect);
End;

Initialization
    ApplyLanguagesDEPfix;

End.
