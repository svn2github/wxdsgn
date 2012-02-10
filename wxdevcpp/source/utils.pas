{
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

Unit utils;

Interface
Uses
{$IFDEF WIN32}
    Windows, Classes, Sysutils, Forms, ShellAPI, Dialogs, SynEditHighlighter,
{$IFDEF PLUGIN_BUILD}
    iplugin_bpl,
{$ENDIF}
    Menus, Registry, Messages {for WM_USER};
{$ENDIF}
{$IFDEF LINUX}
 Classes, Sysutils, QForms, QDialogs, QSynEditHighlighter,
 QMenus, Types;
{$ENDIF}

Const
    // Name of main window class (could use GUID to ensure uniqueness)
    cWindowClassName = 'wxDevCpp.SingleApp.Program';
    // Any 32 bit number here to perform check on copied data
    cCopyDataWaterMark = $DE1F1DAB;
    // User window message handled by main form to ensure that app is not
    // minimized or hidden and that window is foreground window
    UM_ENSURERESTORED = WM_USER + 1;

Type
    PdevSearchResult = ^TdevSearchResult;
    TdevSearchResult = Record
        pt: TPoint;
        InFile: String;
        msg: String;
    End;

    TEditorType = (etNone, etSource, etForm);

    { File ID types }
    TUnitType = (utSrc, utHead, utRes, utPrj, utOther);
    TExUnitType = (utcSrc, // c source file (.c)
        utcppSrc, // c++ source file (.cpp)
        utcHead, // c header (.h)
        utcppHead, // c++ header (.hpp)
        utresHead, // resouce header (.rh)
        utresComp, // resource compiled (.res)
        utresSrc, // resource source (.rc)
        utxPrj,
        utxOther); // any others

    TFilterSet = (ftOpen, ftHelp, ftPrj, ftSrc, ftAll);

    TErrFunc = Procedure(Msg: String) Of Object;
    TLineOutputFunc = Procedure(Line: String) Of Object;
    TCheckAbortFunc = Procedure(Var AbortThread: Boolean) Of Object;

{$IFDEF PLUGIN_BUILD}
Function GetClosestMatchingCompilerSet(CompilerType: Integer): Integer;
Function isRCExt(FileName: String): Boolean;

Function DuplicateAppInstWdw: HWND;
Function SwitchToPrevInst(Wnd: HWND): Boolean;
Function ParseCommandLineArguments(cmdLine: String): TStringList;
Function SubstituteMakeParams(str: String): String;
Function StrToArrays(str, r: String; Var temp: TStringList): Boolean;
// SofT's class name/filename validator
Function ValidateClassName(ClassName: String): Integer;
Function CreateValidClassName(ClassName: String): String;
Function ValidateFileName(FileName: String): Integer;
Function CreateValidFileName(FileName: String): String;
{$ENDIF}

Function IsWinNT: Boolean;

Procedure FilesFromWildcard(Directory, Mask: String;
    Var Files: TStringList; Subdirs, ShowDirs, Multitasking: Boolean);
Function ExecuteFile(Const FileName, Params, DefaultDir: String;
    ShowCmd: Integer): THandle;
Function RunAndGetOutput(Cmd, WorkDir: String;
    ErrFunc: TErrFunc; LineOutputFunc: TLineOutputFunc;
    CheckAbortFunc: TCheckAbortFunc;
    ShowReturnValue: Boolean = True): String;
Function GetShortName(Const FileName: String): String;
Function GetLongName(Const ShortPathName: String): String;
Procedure ShowError(Msg: String);

Function CommaStrToStr(s: String; formatstr: String): String;
Function IncludeQuoteIfSpaces(s: String): String;
Function IncludeQuoteIfNeeded(s: String): String;


// Added by MikeB
Procedure LoadFilefromResource(Const FileName: String; ms: TMemoryStream);

Function ValidateFile(Const FileName: String; Const WorkPath: String;
    Const CheckDirs: Boolean = False): String;

Function BuildFilter(Var value: String; Const FLTStyle: TFILTERSET): Boolean;
    Overload;
Function BuildFilter(Var value: String;
    Const _filters: Array Of String): Boolean; Overload;
Function AddFilter(Var value: String; Const _Filter: String): Boolean;

Function CodeInstoStr(s: String): String;
Function StrtoCodeIns(s: String): String;

Procedure StrtoAttr(Var Attr: TSynHighlighterAttributes; Value: String);
Function AttrtoStr(Const Attr: TSynHighlighterAttributes): String;

Procedure StrtoPoint(Var pt: TPoint; value: String);
Function PointtoStr(Const pt: TPoint): String;

Function ListtoStr(Const List: TStrings): String;
Procedure StrtoList(s: String; Const List: TStrings;
    Const delimiter: Char = ';');

Function GetFileTyp(Const FileName: String): TUnitType;
Function GetExTyp(Const FileName: String): TExUnitType;

Procedure SetPath(Add: String; Const UseOriginal: Boolean = True);
Function ExpandFileto(Const FileName: String; Const BasePath: String): String;
Function FileSamePath(Const FileName: String; Const TestPath: String): Boolean;
Procedure CloneMenu(Const FromMenu: TMenuItem; ToMenu: TMenuItem);

Function GetLastPos(Const SubStr: String; Const S: String): Integer;

Function GenMakePath(FileName: String): String; Overload;
Function GenMakePath2(FileName: String): String;
Function GenMakePath3(FileName: String): String;
Function GenMakePath(FileName: String; EscapeSpaces,
    EncloseInQuotes: Boolean;
    ConverSlashes: Boolean = True): String; Overload;

Function GetRealPath(BrokenFileName: String; Directory: String = ''): String;

Function CalcMod(Count: Integer): Integer;

Function GetVersionString(FileName: String): String;

Function CheckChangeDir(Var Dir: String): Boolean;

Function GetAssociatedProgram(Const Extension: String;
    Var Filename, Description: String): Boolean;

Function IsNumeric(s: String): Boolean;

Implementation

Uses
{$IFDEF WIN32}
    ShlObj, ActiveX, devcfg, version, Graphics, StrUtils,
    MultiLangSupport, main, editor;
{$ENDIF}
{$IFDEF LINUX}
  devcfg, version, QGraphics, StrUtils, MultiLangSupport, main, editor;
{$ENDIF}

Const
    ReservedKeywordList: Array[0..61] Of String = (
        'asm',
        'do',
        'if',
        'return',
        'typedef',
        'auto',
        'double',
        'inline',
        'short',
        'typeid',
        'bool',
        'dynamic_cast',
        'int',
        'signed',
        'union',
        'break',
        'else',
        'long',
        'sizeof',
        'unsigned',
        'case',
        'enum',
        'mutable',
        'static',
        'using',
        'catch',
        'explicit',
        'namespace',
        'static_cast',
        'virtual',
        'char',
        'export',
        'new',
        'struct',
        'void',
        'class',
        'extern',
        'operator',
        'switch',
        'volatile',
        'const',
        'false',
        'private',
        'template',
        'wchar_t',
        'const_cast',
        'float',
        'protected',
        'this',
        'while',
        'continue',
        'for',
        'public',
        'throw',
        'default',
        'friend',
        'register',
        'true',
        'delete',
        'goto',
        'reinterpret_cast',
        'try');

Function GetClosestMatchingCompilerSet(CompilerType: Integer): Integer;
Var
    originalSet: Integer;
Begin
    originalSet := devCompiler.CompilerSet;
    For Result := 0 To devCompilerSet.Sets.Count - 1 Do
    Begin
        devCompilerSet.LoadSet(Result);
        If devCompilerSet.CompilerType = CompilerType Then
        Begin
            devCompilerSet.LoadSet(originalSet);
            Exit;
        End;
    End;

    devCompilerSet.LoadSet(originalSet);
    Result := 0;
End;

Function isRCExt(FileName: String): Boolean;
Begin
    If LowerCase(ExtractFileExt(FileName)) = LowerCase(RC_EXT) Then
        Result := True
    Else
        result := False;
End;

Procedure FilesFromWildcard(Directory, Mask: String;
    Var Files: TStringList; Subdirs, ShowDirs, Multitasking: Boolean);
Var
    SearchRec: TSearchRec;
    Attr, Error: Integer;
Begin
    Directory := IncludeTrailingPathDelimiter(Directory);

    { First, find the required file... }
    Attr := faAnyFile;
    If ShowDirs = False Then
        Attr := Attr - faDirectory;
    Error := FindFirst(Directory + Mask, Attr, SearchRec);
    If (Error = 0) Then
    Begin
        While (Error = 0) Do
        Begin
            { Found one! }
            Files.Add(Directory + SearchRec.Name);
            Error := FindNext(SearchRec);
            If Multitasking Then
                Application.ProcessMessages;
        End;
        FindClose(SearchRec);
    End;

    { Then walk through all subdirectories. }
    If Subdirs Then
    Begin
        Error := FindFirst(Directory + '*.*', faAnyFile, SearchRec);
        If (Error = 0) Then
        Begin
            While (Error = 0) Do
            Begin
                { Found one! }
                If (SearchRec.Name[1] <> '.') And (SearchRec.Attr And
                    faDirectory <> 0) Then
                    { We do this recursively! }
                    FilesFromWildcard(Directory + SearchRec.Name, Mask, Files,
                        Subdirs, ShowDirs, Multitasking);
                Error := FindNext(SearchRec);
            End;
            FindClose(SearchRec);
        End;
    End;
End;

Function ExecuteFile(Const FileName, Params, DefaultDir: String;
    ShowCmd: Integer): THandle;
Begin
    Result := ShellExecute(Application.MainForm.Handle, Nil,
        Pchar(FileName), Pchar(Params),
        Pchar(DefaultDir), ShowCmd);
End;

Function RunAndGetOutput(Cmd, WorkDir: String;
    ErrFunc: TErrFunc; LineOutputFunc: TLineOutputFunc;
    CheckAbortFunc: TCheckAbortFunc;
    ShowReturnValue: Boolean): String;
Var
    tsi: TStartupInfo;
    tpi: TProcessInformation;
    nRead: DWORD;
    aBuf: Array[0..101] Of Char;
    sa: TSecurityAttributes;
    hOutputReadTmp, hOutputRead, hOutputWrite, hInputWriteTmp, hInputRead,
    hInputWrite, hErrorWrite: THandle;
    FOutput: String;
    CurrentLine: String;
    bAbort: Boolean;
Begin
    FOutput := '';
    CurrentLine := '';
    sa.nLength := SizeOf(TSecurityAttributes);
    sa.lpSecurityDescriptor := Nil;
    sa.bInheritHandle := True;

    CreatePipe(hOutputRead, hOutputWrite, @sa, 0);

    If (Not SetHandleInformation(hOutputRead, HANDLE_FLAG_INHERIT, 0)) Then
        ShowMessage('SetHandle hOutputRead');

    CreatePipe(hInputRead, hInputWriteTmp, @sa, 0);

    FillChar(tsi, SizeOf(TStartupInfo), 0);
    tsi.cb := SizeOf(TStartupInfo);
    tsi.dwFlags := STARTF_USESTDHANDLES Or STARTF_USESHOWWINDOW;
    tsi.hStdInput := hInputRead;
    tsi.hStdOutput := hOutputWrite;
    tsi.hStdError := hErrorWrite;

    If Not CreateProcess(Nil, Pchar(Cmd), @sa, @sa, True, 0, Nil, Pchar(WorkDir),
        tsi, tpi) Then
    Begin
        result := 'Unable to run "' + Cmd + '": ' + SysErrorMessage(GetLastError);
        exit;
    End;
    CloseHandle(hOutputWrite);
    CloseHandle(hInputRead);
    CloseHandle(hErrorWrite);

    bAbort := False;
    Repeat
        If Assigned(CheckAbortFunc) Then
            CheckAbortFunc(bAbort);
        If bAbort Then
        Begin
            TerminateProcess(tpi.hProcess, 1);
            Break;
        End;
        If (Not ReadFile(hOutputRead, aBuf, 16, nRead, Nil)) Or (nRead = 0) Then
        Begin
            If GetLastError = ERROR_BROKEN_PIPE Then
                Break
            Else
                //MessageDlg('Pipe read error, could not execute file', mtError, [mbOK], 0);
                ErrFunc('Pipe read error, could not execute file');
        End;
        aBuf[nRead] := #0;
        FOutput := FOutput + Pchar(@aBuf[0]);

        If Assigned(LineOutputFunc) Then
        Begin
            CurrentLine := CurrentLine + Pchar(@aBuf[0]);
            If CurrentLine[Length(CurrentLine)] = #10 Then
            Begin
                Delete(CurrentLine, Length(CurrentLine), 1);
                LineOutputFunc(CurrentLine);
                CurrentLine := '';
            End;
        End;
    Until False;
    GetExitCodeProcess(tpi.hProcess, nRead);
    If ShowReturnValue Then
        Result := FOutput + ' ' + inttostr(nread)
    Else
        Result := FOutput;

    CloseHandle(hOutputRead);
    CloseHandle(hInputWrite);
    CloseHandle(tpi.hProcess);
    CloseHandle(tpi.hThread);

End;

Procedure SetPath(Add: String; Const UseOriginal: Boolean = True);
Var
    OldPath: Array[0..PATH_LEN] Of Char;
    NewPath: String;
Begin
    If (add <> '') And (Add[length(Add)] <> ';') Then
        Add := Add + ';';

    // PATH environment variable does *not* like quotes in paths...
    // Even if there are spaces in pathnames, it doesn't matter.
    // It splits them up by the ';'
    Add := StringReplace(Add, '"', '', [rfReplaceAll]);

    If UseOriginal Then
        NewPath := Add + devDirs.OriginalPath
    Else
    Begin
        GetEnvironmentVariable(Pchar('PATH'), @OldPath, PATH_LEN);
        NewPath := Add + String(OldPath);
    End;

    SetEnvironmentVariable(Pchar('PATH'), Pchar(NewPath));
End;

Function ValidateFile(Const FileName: String; Const WorkPath: String;
    Const CheckDirs: Boolean = False): String;
Var
    fName: String;
    tmp: TStrings;
    idx: Integer;
Begin
    fName := ExtractFileName(FileName);
    If FileExists(FileName) Then
        result := FileName
    Else
    If FileExists(WorkPath + fName) Then
        result := WorkPath + fName
    Else
    If FileExists(WorkPath + FileName) Then
        result := FileName
    Else
    If CheckDirs Then
    Begin
        If (devDirs.Default <> '') And (FileExists(devDirs.Default + fName)) Then
            result := devDirs.Default + fName
        Else
        If (devDirs.Exec <> '') And (FileExists(devDirs.Exec + fName)) Then
            result := devDirs.Exec + fName
        Else
        If (devDirs.Help <> '') And (FileExists(devDirs.Help + fName)) Then
            result := devDirs.Help + fName
        Else
        If (devDirs.Lang <> '') And (FileExists(devDirs.Lang + fName)) Then
            result := devDirs.Lang + fName
        Else
        If (devDirs.Icons <> '') Then
        Begin
            tmp := TStringList.Create;
            Try
                StrtoList(devDirs.Icons, tmp);
                If tmp.Count > 0 Then
                    For idx := 0 To pred(tmp.Count) Do
                        If FileExists(IncludeTrailingPathDelimiter(tmp[idx]) + fName) Then
                        Begin
                            result := IncludeTrailingPathDelimiter(tmp[idx]) + fName;
                            break;
                        End;
            Finally
                tmp.Free;
            End;
        End;
    End
    Else
        result := '';
End;

Procedure LoadFilefromResource(Const FileName: String; ms: TMemoryStream);
Var
    HResInfo: HRSRC;
    hRes: THandle;
    Buffer: Pchar;
    aName, Ext: String;
Begin
    Ext := ExtractFileExt(FileName);
    Ext := copy(ext, 2, length(ext));
    aName := ChangeFileExt(ExtractFileName(FileName), '');
    HResInfo := FindResource(HInstance, Pchar(aName), Pchar(Ext));
    hres := LoadResource(HInstance, HResInfo);
    If HRes = 0 Then
    Begin
        MessageBox(Application.MainForm.Handle,
            Pchar(Format(Lang[ID_ERR_RESOURCE], [FileName, aName, Ext])),
            Pchar(Lang[ID_ERROR]), MB_OK Or MB_ICONERROR);
        exit;
    End;

    Buffer := LockResource(HRes);
    ms.clear;
    ms.WriteBuffer(Buffer[0], SizeofResource(HInstance, HResInfo));
    ms.Seek(0, 0);
    UnlockResource(HRes);
    FreeResource(HRes);
End;

Function GetShortName(Const FileName: String): String;
Var
    pFileName: Array[0..12048] Of Char;
Begin
    GetShortPathName(Pchar(FileName), pFileName, 12048);
    result := strpas(pFileName);
End;

//Takes a 8.3 filename and makes it into a Long filename.
//Courtesy of http://www.martinstoeckli.ch/delphi/delphi.html
Function GetLongName(Const ShortPathName: String): String;
Var
    hKernel32Dll: THandle;
    fncGetLongPathName: Function(lpszShortPath: LPCTSTR; lpszLongPath: LPTSTR;
        cchBuffer: DWORD): DWORD Stdcall;
    bSuccess: Boolean;
    szBuffer: Array[0..MAX_PATH] Of Char;
    pDesktop: IShellFolder;
    swShortPath: Widestring;
    iEaten: ULONG;
    pItemList: PItemIDList;
    iAttributes: ULONG;
Begin
    // try to find the function "GetLongPathNameA" (Windows 98/2000)
    hKernel32Dll := GetModuleHandle('Kernel32.dll');
    If (hKernel32Dll <> 0) Then
        @fncGetLongPathName := GetProcAddress(hKernel32Dll, 'GetLongPathNameA')
    Else
        @fncGetLongPathName := Nil;
    // use the function "GetLongPathNameA" if available
    bSuccess := False;
    If (Assigned(fncGetLongPathName)) Then
    Begin
        bSuccess := fncGetLongPathName(Pchar(ShortPathName), szBuffer,
            SizeOf(szBuffer)) > 0;
        If bSuccess Then
            Result := szBuffer;
    End;
    // use an alternative way of getting the path (Windows 95/NT)
    If (Not bSuccess) And Succeeded(SHGetDesktopFolder(pDesktop)) Then
    Begin
        swShortPath := ShortPathName;
        iAttributes := 0;
        If Succeeded(pDesktop.ParseDisplayName(0, Nil, POLESTR(swShortPath),
            iEaten, pItemList, iAttributes)) Then
        Begin
            bSuccess := SHGetPathFromIDList(pItemList, szBuffer);
            If bSuccess Then
                Result := szBuffer;
            // release ItemIdList (SHGetMalloc is superseded)
            CoTaskMemFree(pItemList);
        End;
    End;
    // give back the original path if unsuccessful
    If (Not bSuccess) Then
        Result := ShortPathName;
End;

Procedure ShowError(Msg: String);
Begin
    Application.MessageBox(Pchar(Msg), 'Error', MB_ICONHAND);
End;

Function AddFilter(Var value: String; Const _Filter: String): Boolean;
Var
    idx: Integer;
    s,
    LFilter: String;
Begin
    result := True;
    Try
        If _Filter = '' Then
            exit;

        LFilter := value;
        idx := pos('|', LFilter);
        If idx > 0 Then
        Begin
            Insert(_Filter + '|', LFilter, AnsiPos(FLT_ALLFILES, LFIlter));
            s := Copy(_Filter, AnsiPos('|', _Filter) + 1, length(_Filter)) + ';';
            Insert(s, LFilter, AnsiPos('|', LFilter) + 1);
            If LFilter[Length(LFilter)] <> '|' Then
                LFilter := LFilter + '|';
        End;
        value := LFilter;
    Except
        result := False;
    End;
End;

Function BuildFilter(Var value: String; Const FLTStyle: TFILTERSET): Boolean;
    Overload;
{$IFDEF PLUGIN_BUILD}
Var
    b, c: Boolean;
    filters: TStringList;
    i, j: Integer;
{$ENDIF}
Begin
    value := FLT_BASE + FLT_ALLFILES;
    Case FLTStyle Of
        ftOpen:
        Begin
            b := BuildFilter(value, [FLT_PROJECTS, FLT_HEADS, FLT_CS,
                FLT_CPPS, FLT_RES]);
        {$IFDEF PLUGIN_BUILD}
            For i := 0 To MainForm.packagesCount - 1 Do
            Begin
                filters := (MainForm.plugins[MainForm.delphi_plugins[i]] As
                    IPlug_In_BPL).GetFilters;
                For j := 0 To filters.Count - 1 Do
                Begin
                    c := AddFilter(value, filters.Strings[j]);
                    b := b Or c;
                End;
            End;
        {$ENDIF}
            result := b;
        End;
        ftHelp:
        Begin
            result := BuildFilter(value, [FLT_HELPS]);
        End;
        ftPrj:
        Begin
            result := BuildFilter(value, [FLT_PROJECTS]);
        End;
        ftSrc:
        Begin
            b := BuildFilter(value, [FLT_HEADS, FLT_RES, FLT_CS, FLT_CPPS]);
        {$IFDEF PLUGIN_BUILD}
            For i := 0 To MainForm.packagesCount - 1 Do
            Begin
                filters := (MainForm.plugins[MainForm.delphi_plugins[i]] As
                    IPlug_In_BPL).GetSrcFilters;
                For j := 0 To filters.Count - 1 Do
                Begin
                    c := AddFilter(value, filters.Strings[j]);
                    b := b Or c;
                End;
            End;
        {$ENDIF}
            result := b;
        End;
        ftAll:
        Begin
            b := BuildFilter(value, [FLT_PROJECTS, FLT_HEADS, FLT_RES,
                FLT_CS, FLT_CPPS]);
        {$IFDEF PLUGIN_BUILD}
            For i := 0 To MainForm.packagesCount - 1 Do
            Begin
                filters := (MainForm.plugins[MainForm.delphi_plugins[i]] As
                    IPlug_In_BPL).GetFilters;
                For j := 0 To filters.Count - 1 Do
                Begin
                    c := AddFilter(value, filters.Strings[j]);
                    b := b Or c;
                End;
            End;
        {$ENDIF}
            result := b;
        End;
    Else
        result := True;
    End;
End;

Function BuildFilter(Var value: String;
    Const _filters: Array Of String): Boolean; Overload;
Var
    idx: Integer;
Begin
    result := False;
    value := FLT_BASE + FLT_ALLFILES;
    For idx := 0 To high(_Filters) Do
        If Not AddFilter(value, _Filters[idx]) Then
            exit;
    result := True;
End;

Function CodeInstoStr(s: String): String;
Begin
    result := StringReplace(s, #13#10, '$_', [rfReplaceAll]);
End;

Function StrtoCodeIns(s: String): String;
Begin
    result := StringReplace(s, '$_', #13#10, [rfReplaceAll]);
End;

Procedure StrtoPoint(Var pt: TPoint; value: String);
Var
    tmp: TStringList;
Begin
    tmp := TStringList.Create;
    Try
        tmp.CommaText := value;
        If tmp.Count >= 2 Then
            With pt Do
            Begin
                // x=foreground y=background
                x := StringToColor(tmp[1]);
                y := StringtoColor(tmp[0]);
            End;
    Finally
        tmp.Free;
    End;
End;

Function PointtoStr(Const pt: TPoint): String;
Begin
    result := format('%d, %d', [pt.y, pt.x]);
End;

Function AttrtoStr(Const Attr: TSynHighlighterAttributes): String;
Begin
    result := format('%s, %s, %d, %d, %d',
        [ColortoString(Attr.Foreground),
        ColortoString(Attr.Background),
        ord(fsBold In Attr.Style),
        ord(fsItalic In Attr.Style),
        ord(fsUnderline In Attr.Style)]);
End;

Procedure StrtoAttr(Var Attr: TSynHighlighterAttributes; Value: String);
Var
    tmp: TStringList;
Begin
    tmp := TStringList.Create;
    Try
        tmp.commaText := Value;
        If tmp.count = 5 Then
            With attr Do
            Begin
                Foreground := StringtoColor(tmp[0]);
                Background := StringtoColor(tmp[1]);
                style := [];
                If tmp[2] = '1' Then
                    style := style + [fsbold]
                Else
                    style := style - [fsbold];
                If tmp[3] = '1' Then
                    style := style + [fsItalic]
                Else
                    style := style - [fsItalic];
                If tmp[4] = '1' Then
                    style := style + [fsUnderline]
                Else
                    style := style - [fsUnderline];
            End;
    Finally
        tmp.Free;
    End;
End;

(*procedure StrtoList(s: string; const List: TStrings; const delimiter: char=';');
begin
  List.BeginUpdate;
  try
   List.Clear;
   List.CommaText:= stringreplace(s, delimiter, ',', [rfReplaceAll, rfIgnoreCase]);
  finally
   List.EndUpdate;
  end;
end;*)

Function CommaStrToStr(s: String; formatstr: String): String;
Var i: Integer;
    tmp: String;
Begin
    result := '';
    While pos(';', s) > 0 Do
    Begin
        i := pos(';', s);
        tmp := Copy(s, 1, i - 1);
        Delete(s, 1, i);
        result := format(formatstr, [result, tmp]);
    End;
    If s <> '' Then
        result := format(formatstr, [result, s]);
End;

Procedure StrtoList(s: String; Const List: TStrings;
    Const delimiter: Char = ';');
Var tmp: String;
    i: Integer;
Begin
    List.BeginUpdate;
    Try
        List.Clear;
        While pos(delimiter, s) > 0 Do
        Begin
            i := pos(delimiter, s);
            tmp := Copy(s, 1, i - 1);
            Delete(s, 1, i);
            List.Add(tmp);
        End;
        If s <> '' Then
            List.Add(s);
    Finally
        List.EndUpdate;
    End;
End;

(*function ListtoStr(const List: TStrings): string;
begin
  if List.Count = 0 then
   result:= ''
  else
   result:= StringReplace(List.CommaText, ',', ';', [rfReplaceAll, rfIgnoreCase]);
end;*)

Function ListtoStr(Const List: TStrings): String;
Var i: Integer;
Begin
    result := '';
    For i := 0 To List.Count - 1 Do
    Begin
        If i = 0 Then
            result := List.Strings[0]
        Else
            result := result + ';' + List.Strings[i];
    End;
End;

Function GetFileTyp(Const FileName: String): TUnitType;
Var
    ext: String;
Begin
    Ext := ExtractfileExt(FileName);
    If AnsiCompareText(Ext, DEV_EXT) = 0 Then
        result := utPrj
    Else
    If AnsiMatchText(ext, ['.c', '.cpp', '.cc', '.cxx', '.c++', '.cp']) Then
        result := utsrc
    Else
    If AnsiMatchText(ext, ['.h', '.hpp', '.rh', '.hh', '.hxx']) Then
        result := utHead
    Else
    If AnsiMatchText(ext, ['.res', '.rc']) Then
        result := utRes
    Else
        result := utOther;
End;

// this function sucks -- need to replace

Function GetExTyp(Const FileName: String): TExUnitType;
Var
    idx: Integer;
    s: String;
Begin
    s := ExtractFileExt(FileName);
    result := utxother;
    For idx := 0 To high(ctypes) Do
        If AnsiCompareText(s, ctypes[idx]) = 0 Then
        Begin
            result := utcsrc;
            exit;
        End;
    For idx := 0 To high(cpptypes) Do
        If AnsiCompareText(s, cpptypes[idx]) = 0 Then
        Begin
            result := utcppsrc;
            exit;
        End;
    For idx := 0 To high(headtypes) Do
        If AnsiCompareText(s, headTypes[idx]) = 0 Then
        Begin
            Case idx Of
                0:
                    result := utchead;
                1:
                    result := utcppHead;
                2:
                    result := utresHead;
            End;
            exit;
        End;
    For idx := 0 To high(restypes) Do
        If AnsiCompareText(s, restypes[idx]) = 0 Then
        Begin
            Case idx Of
                0:
                    result := utresComp;
                1:
                    result := utresSrc;
            End;
            exit;
        End;
End;

// seems stupid now but I want to expand to account for .. chars
//in basepath and or filename

Function ExpandFileto(Const FileName: String; Const BasePath: String): String;
Var
    oldPath: String;
Begin
    oldPath := GetCurrentDir;
    Try
        If DirectoryExists(BasePath) Then
        Begin
            chdir(BasePath);
            result := ExpandFileName(FileName);
        End
        Else
            Result := Filename; // no luck...
    Finally
        chdir(oldPath);
    End;
End;

Function FileSamePath(Const FileName: String; Const TestPath: String): Boolean;
Var
    s1, s2: String;
Begin
    result := False;
    s1 := ExtractFilePath(FileName);
    s2 := ExtractFilePath(TestPath);
    If (s1 = s2) Then
        result := True
    Else
    If (s1 = '') Then
        result := FileExists(s2 + FileName);
End;

Procedure CloneMenu(Const FromMenu: TMenuItem; ToMenu: TMenuItem);
Var
    idx: Integer;
    Item: TMenuItem;
Begin
    ToMenu.Clear;
    If FromMenu.Count <= 0 Then
        exit;
    For idx := 0 To pred(FromMenu.Count) Do
    Begin
        Item := TMenuItem.Create(ToMenu);
        With FromMenu.Items[idx] Do
        Begin
            Item.Caption := Caption;
            Item.OnClick := OnClick;
            Item.Tag := Tag;
            Item.AutoCheck := AutoCheck;
            Item.ShortCut := ShortCut;
        End;
        ToMenu.Add(Item);
    End;
    ToMenu.Visible := FromMenu.Visible;
End;

Function GetLastPos(Const SubStr: String; Const s: String): Integer;
Var
    Last,
    Current: PAnsiChar;
Begin
    result := 0;
    Last := Nil;
    Current := PAnsiChar(s);
    While (Current <> Nil) And (Current^ <> #0) Do
    Begin
        Current := AnsiStrPos(PAnsiChar(Current), PAnsiChar(SubStr));
        If Current <> Nil Then
        Begin
            Last := Current;
            inc(Current, length(SubStr));
        End;
    End;
    If Last <> Nil Then
        result := abs((Longint(PAnsiChar(s)) - Longint(Last)) Div
            sizeof(AnsiChar)) + 1;
End;

{ GenMakePath: convert a filename to a format that can be used by make }
Function GenMakePath(FileName: String): String;
Begin
    Result := GenMakePath(FileName, False, True, True);
End;

Function GenMakePath2(FileName: String): String;
Begin
    Result := GenMakePath(FileName, True, False, True);
End;

//This function is for the Dmars like compilers which
//doesnt allow unix slash for dir seperation
Function GenMakePath3(FileName: String): String;
Begin
    Result := GenMakePath(FileName, False, True, False);
End;

Function GenMakePath(FileName: String; EscapeSpaces,
    EncloseInQuotes: Boolean; ConverSlashes: Boolean): String;
Begin
    Result := FileName;
    { Convert backslashes to slashes}
    If (ConverSlashes) Then
        Result := StringReplace(Result, '\', '/', [rfReplaceAll]);

    If EscapeSpaces Then
        Result := StringReplace(Result, ' ', '\ ', [rfReplaceAll]);

    If EncloseInQuotes Then
        If (Pos(' ', Result) > 0) Then
            Result := '"' + Result + '"';
End;

Function GetRealPath(BrokenFileName: String; Directory: String): String;
Var
    e: TEditor;
Begin
    Result := BrokenFileName;

  { There are 3 kinds of bad filenames:
    1: C:/Foo/Bar.txt              (must be backslashes)
    2: /C/WINDOWS/Desktop/foo.c    (WinUnix paths?)
    3: foo.c                       (not an absolute filename) }

    { First, check if this is a WinUnix path }
    If CompareText(Copy(Result, 1, 1), '/') = 0 Then
    Begin
        Delete(Result, 1, 2);
        If (Length(Result) > 2) Then
            Result[2] := ':';

        Insert('\', Result, 3);
    End;

    { Second, check if this is an absolute filename }
    If (Length(Result) < 4) Or Not
        ((LowerCase(Result)[1] In ['A'..'Z']) And (Result[2] = ':')) Then
    Begin
        { It's not. }
        If Length(Directory) = 0 Then
        Begin
            If Assigned(MainForm.fProject) Then
                Result := ExpandFileTo(Result, MainForm.fProject.Directory)
            Else
            Begin
                e := MainForm.GetEditor;
                If (Assigned(e)) And (Length(ExtractFileDir(e.FileName)) > 0) Then
                    Result := ExpandFileTo(Result, ExtractFileDir(e.FileName))
                Else
                    Result := ExpandFileName(Result);
            End;
        End
        Else
        Begin
            Result := ExpandFileTo(Result, Directory);
        End;
    End;

    { Last, replace all slashes with backslahes }
{$IFDEF WIN32}
    StringReplace(Result, '/', '\', [rfReplaceAll]);
{$ENDIF}
End;

Function CalcMod(Count: Integer): Integer;
Begin
    If Count <= 15 Then
        Result := 0
    Else
    If Count <= 30 Then
        Result := 2
    Else
    If Count <= 65 Then
        Result := 4
    Else
    If Count <= 150 Then
        Result := 8
    Else
    If Count <= 300 Then
        Result := 16
    Else
    If Count <= 500 Then
        Result := 32
    Else
    If Count <= 750 Then
        Result := 64
    Else
    If Count <= 1500 Then
        Result := 96
    Else
        Result := 128;
End;

Function IncludeQuoteIfSpaces(s: String): String;
Begin
    If pos(' ', s) > 0 Then
        result := '"' + s + '"'
    Else
        result := s;
End;

Function IncludeQuoteIfNeeded(s: String): String;
Begin
    If pos('"', s) = 0 Then
        result := '"' + s + '"'
    Else
        result := s;
End;

// added by mandrav 13 Sep 2002
// returns the file version of the .exe specified by filename
// in the form x.x.x.x

Function GetVersionString(FileName: String): String;
Var
    Buf: Pointer;
    i: Cardinal;
    P: pointer;
    pSize: Cardinal;
    ffi: TVSFixedFileInfo;
Begin
    Result := '';
    i := GetFileVersionInfoSize(Pchar(FileName), i);
    If i = 0 Then
        Exit;

    Buf := AllocMem(i);
    Try
        If Not GetFileVersionInfo(Pchar(FileName), 0, i, Buf) Then
            Exit;

        pSize := SizeOf(P);
        VerQueryValue(Buf, '\', p, pSize);

        ffi := TVSFixedFileInfo(p^);
        Result := Format('%d.%d.%d.%d', [
            HiWord(ffi.dwFileVersionMS),
            LoWord(ffi.dwFileVersionMS),
            HiWord(ffi.dwFileVersionLS),
            LoWord(ffi.dwFileVersionLS)]);
    Finally
        FreeMem(Buf);
    End;
End;

Function SendParamsToPrevInstance(WndH: HWND): Boolean;
Var
    CopyData: TCopyDataStruct;
    I: Integer;
    DataSize: Integer;
    Data: Pchar;
    PData: Pchar;
Begin
    DataSize := 0;
    For I := 1 To ParamCount Do
        Inc(DataSize, Length(ParamStr(I)) + 1);
    Inc(DataSize);
    Data := StrAlloc(DataSize);
    Try
        PData := Data;
        For I := 1 To ParamCount Do
        Begin
            StrPCopy(PData, ParamStr(I));
            Inc(PData, Length(ParamStr(I)) + 1);
        End;
        PData^ := #0;
        CopyData.lpData := Data;
        CopyData.cbData := DataSize;
        CopyData.dwData := cCopyDataWaterMark;
        Result := SendMessage(WndH, WM_COPYDATA, 0, LPARAM(@CopyData)) = 1;
    Finally
        StrDispose(Data);
    End;
End;

Function DuplicateAppInstWdw: HWND;
Begin
    Result := FindWindow(cWindowClassName, Nil);
End;

Function SwitchToPrevInst(Wnd: HWND): Boolean;
Begin
    Assert(Wnd <> 0);
    If ParamCount > 0 Then
        Result := SendParamsToPrevInstance(Wnd)
    Else
        Result := True;
    If Result Then
        SendMessage(Wnd, UM_ENSURERESTORED, 0, 0);
End;

Function IsWinNT: Boolean;
Var ver: TOSVersionInfo;
Begin
    ver.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
    result := False;
    If GetVersionEx(ver) Then
    Begin
        If (ver.dwPlatformId = VER_PLATFORM_WIN32_NT)
        {and (ver.dwMajorVersion > 4) } Then
            result := True;
    End;
End;

// tries to change the current directory to Dir.
// Returns True if succesfull, False otherwise.
// If it succeeds, the Dir variable, holds the old dir.
Function CheckChangeDir(Var Dir: String): Boolean;
Var
    Old: String;
Begin
    Old := GetCurrentDir;
    Result := SetCurrentDir(Dir);
    If Result Then
        Dir := Old;
End;

Function GetAssociatedProgram(Const Extension: String;
    Var Filename, Description: String): Boolean;
Const
    NOVALUE = '$__NONE__$';
Var
    R: TRegIniFile;
    Base, S: String;
Begin
    Result := False;
    R := TRegIniFile.Create;
    Try
        R.RootKey := HKEY_CLASSES_ROOT;
        Base := R.ReadString(Extension, '', NOVALUE);
        If Base = NOVALUE Then
            Exit;
        S := R.ReadString(Base + '\shell\open\command', '', NOVALUE);
        If S = NOVALUE Then
            Exit;
        Filename := S;
        // filename probably contains args, e.g. Filename='"some where\my.exe" "%1"'

        Description := ExtractFilename(S);
        Result := True;
        S := R.ReadString(Base + '\shell\open\ddeexec\application', '', NOVALUE);
        If S = NOVALUE Then
            Description := 'Default application'
        Else
            Description := S;
        If S = 'DEVCPP' Then // avoid extensions registered to DevCpp ;)
            Result := False;
    Finally
        R.Free;
    End;
End;

Function IsNumeric(s: String): Boolean;
Var i: Integer;
Begin
    result := True;
    For i := 1 To length(s) Do
        If Not (s[i] In ['0'..'9']) Then
        Begin
            result := False;
            exit;
        End;
End;

{$IfDef PLUGIN_BUILD}
Function ParseCommandLineArguments(cmdLine: String): TStringList;
Var
    i: Integer;
    tmp: String;
    inquote: Boolean;
Begin
    Result := TStringList.Create;
    inquote := False;

    For i := 1 To Length(cmdLine) Do
    Begin
        If cmdLine[i] = '"' Then
            inquote := Not inquote
        Else
        If cmdLine[i] = ' ' Then
            If Not inquote Then
            Begin
                Result.Add(tmp);
                tmp := '';
            End
            Else
                tmp := tmp + cmdLine[i]
        Else
            tmp := tmp + cmdLine[i];
    End;

    If tmp <> '' Then
        Result.Add(tmp);
End;

Function SubstituteMakeParams(str: String): String;
Var
    MakeVar: String;
    MakeArgs: TStringList;
    Matched: Boolean;
    Idx: Integer;
    i: Integer;
Begin
    Result := str;
    MakeArgs := ParseCommandLineArguments(devCompiler.MakeOpts);

    While Pos('$(', Result) <> 0 Do
    Begin
        MakeVar := Copy(Result, Pos('$(', Result) + 2, Pos(')', Result) -
            Pos('$(', Result) - 2);
        Matched := False;

        For i := 0 To MakeArgs.Count - 1 Do
        Begin
            //Get the name/value pair
            Idx := Pos('=', MakeArgs[i]);
            If Copy(MakeArgs[i], 0, Idx - 1) = MakeVar Then
            Begin
                Matched := True;
                Result := AnsiReplaceStr(Result, '$(' + MakeVar + ')',
                    Copy(MakeArgs[i], Idx + 1, Length(MakeArgs[i])));
                Continue;
            End;
        End;

        //Replace with an empty string if we havn't found the parameter
        If Not Matched Then
        Begin
            Result := AnsiReplaceStr(Result, '$(' + MakeVar + ')', '');
        End;
    End;

    //Free the memory
    MakeArgs.Free;
End;
{$EndIf}

Function StrToArrays(str, r: String; Var temp: TStringList): Boolean;
Var
    j: Integer;
Begin
    If temp <> Nil Then
    Begin
        temp.Clear;
        While str <> '' Do
        Begin
            j := Pos(r, str);
            If j = 0 Then
                j := Length(str) + 1;
            temp.Add(Copy(Str, 1, j - 1));
            Delete(Str, 1, j + Length(r) - 1);
        End;
    End;
    Result := True;
End;

{$IfDef PLUGIN_BUILD}
{This unit contains 4 functions designed to validate and correct C++ class names
and windows file names. The functions are as follows

ValidateClassName       Takes a string and returns an integer containing the
                        number of errors found. It checks for empty class names,
                        names which don't contain only alphanumeric characters
                        or underscores. It also checks that the name is not a
                        reserved keyword.

CreateValidClassName    Takes a string containing the class name and returns a
                        string containing a 'fixed' class name. It runs through
                        the checks above, if an empty class name is found then
                        a default one is used. Any illegal characters are
                        replaced with an underscore. This may make strange
                        looking names but they are legal.

ValidateFileName        Takes a string containing the file name and returns an
                        integer containing the number of errors found. It checks
                        for empty filenames, names which contain "*?|:<>, since
                        these can choke the make program

CreateValidFileName     Takes a string containing the filename and returns a
                        string containing a legal filename. If the string is
                        empty a default name is filled in, otherwise any
                        illegal characters are replaced with an underscore.

Example usage of these functions.

  if(ValidateClassName(Edit1.Text) > 0 ) then
  begin
     if MessageDlg('Your class name contains errors, do you want it fixed automatically?',mtError,[mbYes, mbNo],0) = mrYes then
     begin
         Edit2.Text := CreateValidClassName(Edit1.Text);
     end
     else
     begin
        MessageDlg('Please fix the class name yourself, class names can only contain alphanumeric characters and an underscore, they cannot be reserved keywords or start with numbers',mtWarning,[mbOK],0);
     end;
  end;

This copyright to Sof.T 2006 and provided under the GPL license version 2 or
later at your preference.}
Function ValidateClassName(ClassName: String): Integer;
Var
    I: Integer;
Begin
    Result := 0;
    If Length(ClassName) < 1 Then
        Inc(Result)

    //Check the first character is not a number
    Else
    If Not (Char(ClassName[1]) In ['a'..'z', 'A'..'Z', '_']) Then
        Inc(Result);

    //Look for invalid characters in the class name
    For I := 2 To Length(ClassName) Do
        If Not (ClassName[I] In ['a'..'z', 'A'..'Z', '0'..'9', '_']) Then
            Inc(Result);

    //Check we haven't ended up with a reserved keyword
    For I := 0 To Length(ReservedKeywordList) - 1 Do
        If ReservedKeywordList[I] = ClassName Then
            Inc(Result);
End;

Function CreateValidClassName(ClassName: String): String;
Var
    I: Integer;
Begin
    Result := ClassName;
    //Check we have a name to work with, if not then assign a safe one
    If Length(Result) < 1 Then
        Result := 'DefaultClassName';

    //Look for invalid characters in the class name. Replace with '_'
    For I := 2 To Length(Result) Do
        If Not (Result[I] In ['a'..'z', 'A'..'Z', '0'..'9', '_']) Then
            Result[I] := '_';

    //Check the first character is not a number if so add '_' in front
    If Result[1] In ['0'..'9'] Then
        Insert('_', Result, 0);

    //Now check our ValidClassName against list of reserved keywords. If we find a match flag
    //error and add '_' to the start of the name
    For I := 0 To Length(ReservedKeywordList) - 1 Do
        If ReservedKeywordList[I] = Result Then
            Insert('_', Result, 0);
End;

Function ValidateFileName(FileName: String): Integer;
Var
    I: Integer;
Begin
    Result := 0;
    If Length(FileName) < 1 Then
        Inc(Result);

    //Look for invalid characters in the file name
    For I := 1 To Length(FileName) Do
        If FileName[I] In ['"', '*', ':', '<', '>', '?', '|'] Then
            Inc(Result);
End;

Function CreateValidFileName(FileName: String): String;
Var
    I: Integer;
Begin
    Result := FileName;
    For I := 1 To Length(Result) Do
        If Result[I] In ['"', '*', ':', '<', '>', '?', '|'] Then
            Result[I] := '_';
End;

{$ENDIF}

End.
