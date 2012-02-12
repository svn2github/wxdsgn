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

Unit CppParser;

Interface

Uses
{$IFDEF WIN32}
    Dialogs, Windows, Classes, SysUtils, StrUtils, ComCtrls, U_IntList, CppTokenizer;
{$ENDIF}
{$IFDEF LINUX}
  QDialogs, Classes, SysUtils, StrUtils, QComCtrls, U_IntList, CppTokenizer;
{$ENDIF}

Type
    TStatementKind = (
        skClass,
        skFunction,
        skConstructor,
        skDestructor,
        skVariable,
        skTypedef,
        skEnum,
        skPreprocessor,
        skUnknown
        );

    TStatementScope = (ssGlobal, ssLocal, ssClassLocal);
    TStatementClassScope = (scsPublic, scsPublished, scsPrivate, scsProtected, scsNone);

    TLogStatementEvent = Procedure(Sender: TObject; Msg: String) Of Object;

    PStatement = ^TStatement;
    TStatement = Record
        _ID: Integer;
        _ParentID: Integer;
        _FullText: String;
        _Type: String;
        _Command: String;
        _Args: String;
        _MethodArgs: String;
        _ScopelessCmd: String;
        _ScopeCmd: String;
        _Kind: TStatementKind;
        _InheritsFromIDs: String; // list of inheriting IDs, in comma-separated string form
        _InheritsFromClasses: String; // list of inheriting class names, in comma-separated string form
        _Scope: TStatementScope;
        _ClassScope: TStatementClassScope;
        _IsDeclaration: Boolean;
        _DeclImplLine: Integer;
        _Line: Integer;
        _DeclImplFileName: String;
        _FileName: String;
        _Visible: Boolean;
        _NoCompletion: Boolean;
        _Valid: Boolean;
        _Temporary: Boolean;
        _Loaded: Boolean;
        _InProject: Boolean;
    End;

    POutstandingTypedef = ^TOutstandingTypedef;
    TOutstandingTypedef = Packed Record
        _WaitForTypedef: String;
        _ExistingID: Integer;
    End;

    PIncludesRec = ^TIncludesRec;
    TIncludesRec = Packed Record
        BaseFile: String;
        IncludeFiles: String;
    End;

    TCppParser = Class(TComponent)
    Private
        fEnabled: Boolean;
        fInClass: Integer;
        fNextID: Integer;
        fBaseIndex: Integer;
        fLevel: Integer;
        fIndex: Integer;
        fIsHeader: Boolean;
        fCurrentFile: TFileName;
        fLastID: Integer;
        fLastStatementKind: TStatementKind;
        fCurrentClass: TIntList;
        fSkipList: TIntList;
        fCurrentClassLevel: TIntList;
        fClassScope: TStatementClassScope;
        fStatementList: TList;
        fOutstandingTypedefs: TList;
        fIncludesList: TList;
        fTokenizer: TCppTokenizer;
        fVisible: Boolean;
        fIncludePaths: TStringList;
        fProjectIncludePaths: TStringList;
        fProjectFiles: TStringList;
        fFilesToScan: TStrings;
        fScannedFiles: TStringList;
        fFileIncludes: TStringList;
        fCacheContents: TStringList;
        fParseLocalHeaders: Boolean;
        fParseGlobalHeaders: Boolean;
        fReparsing: Boolean;
        fProjectDir: String;
        fOnLogStatement: TLogStatementEvent;
        fOnBusy: TNotifyEvent;
        fOnUpdate: TNotifyEvent;
        fOnFileProgress: TProgressEvent;
        fOnTotalProgress: TProgressEvent;
        fOnCacheProgress: TProgressEvent;
        fLogStatements: Boolean;
        fLaterScanning: Boolean;
        fThisPointerID: Integer;
        fOnStartParsing: TNotifyEvent;
        fOnEndParsing: TNotifyEvent;
        fIsProjectFile: Boolean;
        fInvalidatedIDs: TIntList;
        Function AddStatement(ID,
            ParentID: Integer;
            Filename: TFileName;
            FullText,
            StType,
            StCommand,
            StArgs: String;
            Line: Integer;
            Kind: TStatementKind;
            Scope: TStatementScope;
            ClassScope: TStatementClassScope;
            VisibleStatement: Boolean = True;
            AllowDuplicate: Boolean = True;
            IsDeclaration: Boolean = False;
            IsValid: Boolean = True): Integer;
        Procedure InvalidateFile(FileName: TFileName);
        Function IsGlobalFile(Value: String): Boolean;
        Function GetClassID(Value: String; Kind: TStatementKind): Integer;
        Procedure ClearOutstandingTypedefs;
        Function CheckForOutstandingTypedef(Value: String): Integer;
        Procedure AddToOutstandingTypedefs(Value: String; ID: Integer);
        Function GetCurrentClass: Integer;
        Procedure SetInheritance(Index: Integer);
        Procedure SetCurrentClass(ID: Integer);
        Procedure RemoveCurrentClass;
        Procedure CheckForSkipStatement;
        Function SkipBraces(StartAt: Integer): Integer;
        Function CheckForKeyword: Boolean;
        Function CheckForMember: Boolean;
        Function CheckForTypedef: Boolean;
        Function CheckForTypedefStruct: Boolean;
        Function CheckForStructs: Boolean;
        Function CheckForTemplate: Boolean;
        Function CheckForUnion: Boolean;
        Function CheckForMethod: Boolean;
        Function CheckForScope: Boolean;
        Function CheckForPreprocessor: Boolean;
        Function CheckForVar: Boolean;
        Function CheckForEnum: Boolean;
        Function GetScope: TStatementScope;
        Procedure HandleMember;
        Procedure HandleTemplate;
        Procedure HandleUnion;
        Procedure HandleOtherTypedefs;
        Procedure HandleStructs(IsTypedef: Boolean = False);
        Procedure HandleMethod;
        Function ScanMethodArgs(ArgStr: String; AddTemps: Boolean; Filename: String; Line, ClassID: Integer): String;
        Procedure HandleScope;
        Procedure HandlePreprocessor;
        Procedure HandleKeyword;
        Procedure HandleVar;
        Procedure HandleEnum;
        Function HandleStatement: Boolean;
        Procedure Parse(FileName: TFileName; IsVisible: Boolean; ManualUpdate: Boolean = False; processInh: Boolean = True); Overload;
        Procedure DeleteTemporaries;
        Function FindIncludeRec(Filename: String; DeleteIt: Boolean = False): PIncludesRec;
    Public
        Function GetFileIncludes(Filename: String): String;
        Function IsCfile(Filename: String): Boolean;
        Function IsHfile(Filename: String): Boolean;
        Procedure GetSourcePair(FName: String; Var CFile, HFile: String);
        Function GetImplementationLine(Statement: PStatement): Integer;
        Function GetImplementationFileName(Statement: PStatement): String;
        Function GetDeclarationLine(Statement: PStatement): Integer;
        Function GetDeclarationFileName(Statement: PStatement): String;
        Procedure GetClassesList(Var List: TStrings);
        Function SuggestMemberInsertionLine(ParentID: Integer; Scope: TStatementClassScope; Var AddScopeStr: Boolean): Integer;
        Function GetFullFilename(Value: String): String;
        Procedure Load(FileName: TFileName);
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Procedure Parse(FileName: TFileName); Overload;
        Procedure ParseList;
        Procedure ReParseFile(FileName: TFileName; InProject: Boolean; OnlyIfNotParsed: Boolean = False; UpdateView: Boolean = True);
        Function StatementKindStr(Value: TStatementKind): String;
        Function StatementScopeStr(Value: TStatementScope): String;
        Function StatementClassScopeStr(Value: TStatementClassScope): String;
        Function CheckIfCommandExists(Value: String; Kind: TStatementKind; UseParent: Boolean = False; ParID: Integer = -1): Integer;
        Procedure Reset(KeepLoaded: Boolean = True);
        Procedure ClearIncludePaths;
        Procedure ClearProjectIncludePaths;
        Procedure AddIncludePath(Value: String);
        Procedure AddProjectIncludePath(Value: String);
        Procedure AddFileToScan(Value: String; InProject: Boolean = False);
        Procedure Save(FileName: TFileName);
        Procedure ScanAndSaveGlobals(FileName: TFileName);
        Procedure PostProcessInheritance;
        Procedure ReProcessInheritance;
        Function IndexOfStatement(ID: Integer): Integer;
        Function Locate(Full: String; WithScope: Boolean): PStatement;
        Function FillListOf(Full: String; WithScope: Boolean; List: TList): Boolean;
        Function FindAndScanBlockAt(Filename: String; Row: Integer; Stream: TStream = Nil): Integer;
        Function GetThisPointerID: Integer;
    Published
        Property Enabled: Boolean Read fEnabled Write fEnabled;
        Property OnUpdate: TNotifyEvent Read fOnUpdate Write fOnUpdate;
        Property OnBusy: TNotifyEvent Read fOnBusy Write fOnBusy;
        Property OnLogStatement: TLogStatementEvent Read fOnLogStatement Write fOnLogStatement;
        Property OnFileProgress: TProgressEvent Read fOnFileProgress Write fOnFileProgress;
        Property OnTotalProgress: TProgressEvent Read fOnTotalProgress Write fOnTotalProgress;
        Property OnCacheProgress: TProgressEvent Read fOnCacheProgress Write fOnCacheProgress;
        Property Tokenizer: TCppTokenizer Read fTokenizer Write fTokenizer;
        Property Statements: TList Read fStatementList Write fStatementList;
        Property ParseLocalHeaders: Boolean Read fParseLocalHeaders Write fParseLocalHeaders;
        Property ParseGlobalHeaders: Boolean Read fParseGlobalHeaders Write fParseGlobalHeaders;
        Property ScannedFiles: TStringList Read fScannedFiles;
        Property CacheContents: TStringList Read fCacheContents;
        Property LogStatements: Boolean Read fLogStatements Write fLogStatements;
        Property ProjectDir: String Read fProjectDir Write fProjectDir;
        Property OnStartParsing: TNotifyEvent Read fOnStartParsing Write fOnStartParsing;
        Property OnEndParsing: TNotifyEvent Read fOnEndParsing Write fOnEndParsing;
        Property FilesToScan: TStrings Read fFilesToScan;
    End;

Implementation

{$IFDEF LINUX}
uses Libc;
{$ENDIF}

//helper functions for cross platform compilation
{$IFDEF WIN32}
Type
    myTickCount = Cardinal;

Function myGetTickCount: myTickCount;
Begin
    result := GetTickCount;
End;

Function myGetSecsSickTick(lastTick: myTickCount): Integer;
Begin
    result := Round((GetTickCount - lastTick) / 1000);
End;
{$ENDIF}
{$IFDEF LINUX}
type
  myTickCount = integer;

function myGetTickCount: myTickCount;
var
  buf: tms;
begin
  result := Libc.times(buf);
end;

function myGetSecsSickTick(lastTick: myTickCount): integer;
var
  buf: tms;
begin
  result := Round((Libc.times(buf) - lastTick) / CLOCKS_PER_SEC);
end;
{$ENDIF}

Constructor TCppParser.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);
    fStatementList := TList.Create;

    fOutstandingTypedefs := TList.Create;
    fIncludesList := TList.Create;

    fFilesToScan := TStringList.Create;
    fScannedFiles := TStringList.Create;
    fIncludePaths := TStringList.Create;
    fProjectIncludePaths := TStringList.Create;
    fFileIncludes := TStringList.Create;
    fCacheContents := TStringList.Create;
    fProjectFiles := TStringList.Create;
    fInvalidatedIDs := TIntList.Create;

    fParseLocalHeaders := False;
    fParseGlobalHeaders := False;
    fReparsing := False;
    fLogStatements := False;

    fInClass := 0;
    fNextID := 0;
    fBaseIndex := 0;
    fThisPointerID := -1;
    fEnabled := True;
    fLaterScanning := False;
End;

Destructor TCppParser.Destroy;
Var
    i: Integer;
Begin
    If Assigned(fInvalidatedIDs) Then
        FreeAndNil(fInvalidatedIDs)
    Else fInvalidatedIDs := Nil;

    If Assigned(fProjectFiles) Then
        FreeAndNil(fProjectFiles)
    Else fProjectFiles := Nil;

    For i := 0 To fIncludesList.Count - 1 Do
        Dispose(PIncludesRec(fIncludesList.Items[i]));
    If Assigned(fIncludesList) Then
        FreeAndNil(fIncludesList)
    Else fIncludesList := Nil;

    For i := 0 To fOutstandingTypedefs.Count - 1 Do
        Dispose(POutstandingTypedef(fOutstandingTypedefs.Items[i]));

    If Assigned(fOutstandingTypedefs) Then
        FreeAndNil(fOutstandingTypedefs)
    Else fOutstandingTypedefs := Nil;

    For i := 0 To fStatementList.Count - 1 Do
        Dispose(PStatement(fStatementList.Items[i]));

    If Assigned(fStatementList) Then
        FreeAndNil(fStatementList)
    Else fStatementList := Nil;

    If Assigned(fFilesToScan) Then
        FreeAndNil(fFilesToScan)
    Else fFilesToScan := Nil;

    If Assigned(fCacheContents) Then
        FreeAndNil(fCacheContents)
    Else fCacheContents := Nil;

    If Assigned(fScannedFiles) Then
        FreeAndNil(fScannedFiles)
    Else fScannedFiles := Nil;

    If Assigned(fIncludePaths) Then
        FreeAndNil(fIncludePaths)
    Else fIncludePaths := Nil;

    If Assigned(fProjectIncludePaths) Then
        FreeAndNil(fProjectIncludePaths)
    Else fProjectIncludePaths := Nil;

    If Assigned(fFileIncludes) Then
        FreeAndNil(fFileIncludes)
    Else fFileIncludes := Nil;

    Inherited Destroy;
End;

Function TCppParser.StatementClassScopeStr(Value: TStatementClassScope): String;
Begin
    Case Value Of
        scsPublic:
            Result := 'scsPublic';
        scsPublished:
            Result := 'scsPublished';
        scsPrivate:
            Result := 'scsPrivate';
        scsProtected:
            Result := 'scsProtected';
        scsNone:
            Result := 'scsNone';
    End;
End;

Function TCppParser.StatementScopeStr(Value: TStatementScope): String;
Begin
    Case Value Of
        ssGlobal:
            Result := 'ssGlobal';
        ssClassLocal:
            Result := 'ssClassLocal';
        ssLocal:
            Result := 'ssLocal';
    End;
End;

Function TCppParser.StatementKindStr(Value: TStatementKind): String;
Begin
    Case Value Of
        skPreprocessor:
            Result := 'Preprocessor';
        skVariable:
            Result := 'Variable';
        skConstructor:
            Result := 'Constructor';
        skDestructor:
            Result := 'Destructor';
        skFunction:
            Result := 'Function';
        skClass:
            Result := 'Class';
        skTypedef:
            Result := 'Typedef';
        skEnum:
            Result := 'Enum';
        skUnknown:
            Result := 'Unknown';
    End;
End;

Function TCppParser.GetClassID(Value: String; Kind: TStatementKind): Integer;
Begin
    Result := CheckIfCommandExists(Value, Kind);
End;

Procedure TCppParser.ClearOutstandingTypedefs;
Begin
    While fOutstandingTypedefs.Count > 0 Do
        If POutstandingTypedef(fOutstandingTypedefs[fOutstandingTypedefs.Count - 1]) <> Nil Then
        Begin
            Dispose(POutstandingTypedef(fOutstandingTypedefs[fOutstandingTypedefs.Count - 1]));
            fOutstandingTypedefs.Delete(fOutstandingTypedefs.Count - 1);
        End
        Else
            fOutstandingTypedefs.Delete(fOutstandingTypedefs.Count - 1);
    fOutstandingTypedefs.Clear;
End;

Function TCppParser.CheckForOutstandingTypedef(Value: String): Integer;
Var
    I: Integer;
Begin
    I := 0;
    Result := -1;
    While I < fOutstandingTypedefs.Count Do
    Begin
        If POutstandingTypedef(fOutstandingTypedefs[I])^._WaitForTypedef = Value Then
        Begin
            Result := POutstandingTypedef(fOutstandingTypedefs[I])^._ExistingID;
      // free memory
            Dispose(POutstandingTypedef(fOutstandingTypedefs[I]));
      // delete it too!
            fOutstandingTypedefs.Delete(I);
            Break;
        End;
        Inc(I);
    End;
End;

Procedure TCppParser.AddToOutstandingTypedefs(Value: String; ID: Integer);
Var
    ot: POutstandingTypedef;
Begin
    ot := New(POutstandingTypedef);
    ot^._WaitForTypedef := Value;
    ot^._ExistingID := ID;
    fOutstandingTypedefs.Add(ot);
End;

Function TCppParser.SkipBraces(StartAt: Integer): Integer;
Var
    I1: Integer;
Begin
    If PToken(fTokenizer.Tokens[StartAt])^.Text[1] = '{' Then
    Begin
        I1 := 1;
        Repeat
            Inc(StartAt);
            If PToken(fTokenizer.Tokens[StartAt])^.Text[1] = '{' Then
                Inc(I1)
            Else
            If PToken(fTokenizer.Tokens[StartAt])^.Text[1] = '}' Then
                Dec(I1)
            Else
            If PToken(fTokenizer.Tokens[StartAt])^.Text[1] = #0 Then
                I1 := 0; // exit immediately
        Until (I1 = 0);
    End;
    Result := StartAt;
End;

Function TCppParser.CheckIfCommandExists(Value: String; Kind: TStatementKind; UseParent: Boolean; ParID: Integer): Integer;
Var
    I: Integer;
    srch: Set Of TStatementKind;
    fH, fC: String;
Begin
    Result := -1;
    srch := [];
  // if it is function, include the other types too
    If Kind In [skFunction, skConstructor, skDestructor] Then
        srch := [skFunction, skConstructor, skDestructor]
    Else
        Include(srch, Kind); // add to set
    GetSourcePair(fCurrentFile, fC, fH);
  // we do a backward search, because most possible is to be found near the end ;) - if it exists :(
    For I := fStatementList.Count - 1 Downto fBaseIndex Do
    Begin
        If (PStatement(fStatementList[I])^._Kind In srch) And
            (PStatement(fStatementList[I])^._Command = Value) And
            ((Not UseParent) Or (UseParent And (PStatement(fStatementList[I])^._ParentID = ParID))) And
            ((AnsiCompareText(PStatement(fStatementList[I])^._FileName, fC) = 0) Or // only if it belongs to the same file-pair
            (AnsiCompareText(PStatement(fStatementList[I])^._FileName, fH) = 0)) Then
        Begin
            Result := I;
            Break;
        End;
    End;
End;

Function TCppParser.AddStatement(ID,
    ParentID: Integer;
    Filename: TFileName;
    FullText,
    StType,
    StCommand,
    StArgs: String;
    Line: Integer;
    Kind: TStatementKind;
    Scope: TStatementScope;
    ClassScope: TStatementClassScope;
    VisibleStatement: Boolean = True;
    AllowDuplicate: Boolean = True;
    IsDeclaration: Boolean = False;
    IsValid: Boolean = True): Integer;
Var
    Statement: PStatement;
    StScopeLess: String;
    ExistingID: Integer;
    NewKind: TStatementKind;
Begin
  // move '*', '&' to type rather than cmd (it's in the way for code-completion)
    While (Length(StCommand) > 0) And
        (stCommand[1] In ['*', '&']) Do
    Begin
        StType := StType + StCommand[1];
        StCommand := Copy(StCommand, 2, Length(StCommand) - 1);
    End;

    NewKind := Kind;

  // strip class prefix (e.g. MyClass::SomeFunc() = SomeFunc() )
    If Kind = skFunction Then
    Begin
        If AnsiPos('::', StCommand) > 0 Then
        Begin
            StScopeless := Copy(StCommand, AnsiPos('::', StCommand) + 2, Length(StCommand) - AnsiPos('::', StCommand) + 3);
            If AnsiCompareStr(Copy(StCommand, 1, AnsiPos('::', StCommand) - 1), StScopeless) = 0 Then
                NewKind := skConstructor
            Else
            If AnsiCompareStr('~' + Copy(StCommand, 1, AnsiPos('::', StCommand) - 1), StScopeless) = 0 Then
                NewKind := skDestructor;
        End
        Else
            StScopeless := StCommand;
    End
    Else
        StScopeless := StCommand;

  //only search for certain kinds of statements
    If Not AllowDuplicate {and not fIsHeader} Then
        ExistingID := CheckIfCommandExists(StScopeless, Kind) //, True, ParentID)
    Else
        ExistingID := -1;

    If (ExistingID <> -1) And (IsDeclaration <> PStatement(fStatementList[ExistingID])^._IsDeclaration) Then
    Begin // if it existed before, set the decl_impl index
        PStatement(fStatementList[ExistingID])^._DeclImplLine := Line;
        PStatement(fStatementList[ExistingID])^._DeclImplFileName := FileName;
        If (NewKind In [skConstructor, skDestructor]) And (PStatement(fStatementList[ExistingID])^._Kind = skFunction) Then
            PStatement(fStatementList[ExistingID])^._Kind := NewKind;
        If (Kind = skFunction) And (AnsiPos('::', StCommand) > 0) Then
            PStatement(fStatementList[ExistingID])^._ScopeCmd := StCommand;
        Result := ExistingID;
    End
    Else
    Begin // or else...
        Statement := New(PStatement);
        With Statement^ Do
        Begin
            If ID = -1 Then
                _ID := fNextID //fStatementList.Count
            Else
                _ID := ID;
            Result := _ID;
            _ParentID := ParentID;
            _FileName := FileName;
            _FullText := FullText;
            _ScopelessCmd := StScopeless;
            _ScopeCmd := StCommand;
            _Type := StType;
            _Command := StCommand;
            _Args := StArgs;
//      if Kind = skFunction then
//        _MethodArgs := ScanMethodArgs(StArgs, fLaterScanning, fCurrentFile, Line, ParentID)
//      else
            _MethodArgs := StArgs;
            _Line := Line;
            _Kind := NewKind;
            _Scope := Scope;
            _ClassScope := ClassScope;
            _IsDeclaration := IsDeclaration;
            _DeclImplLine := Line;
            _DeclImplFileName := FileName;
            _Visible := fVisible And VisibleStatement;
            _Valid := IsValid;
            _Loaded := False;
            _Temporary := fLaterScanning;
            _NoCompletion := (NewKind = skFunction) And AnsiStartsStr('operator', StScopeless);
            _InProject := fIsProjectFile;
        End;
        fStatementList.Add(Statement);
        Inc(fNextID);
    End;
End;

Function TCppParser.GetCurrentClass: Integer;
Begin
    If fCurrentClass.Count > 0 Then
        Result := fCurrentClass[fCurrentClass.Count - 1]
    Else
        Result := -1;
End;

Procedure TCppParser.SetCurrentClass(ID: Integer);
Begin
    If fCurrentClass.Count > 0 Then
    Begin
        If fCurrentClass[fCurrentClass.Count - 1] <> ID Then
        Begin
            fCurrentClass.Add(ID);
            fCurrentClassLevel.Add(fLevel);
            fClassScope := scsPublic;
        End;
    End
    Else
    Begin
        fCurrentClass.Add(ID);
        fCurrentClassLevel.Add(fLevel);
        fClassScope := scsPublic;
    End;
End;

Procedure TCppParser.RemoveCurrentClass;
Begin
    If fCurrentClassLevel.Count > 0 Then
        If fCurrentClassLevel[fCurrentClassLevel.Count - 1] = fLevel Then
        Begin
            fCurrentClass.Delete(fCurrentClass.Count - 1);
            fCurrentClassLevel.Delete(fCurrentClassLevel.Count - 1);
            If fCurrentClassLevel.Count = 0 Then
                fClassScope := scsNone
            Else
                fClassScope := scsPublic;
        End;
End;

Procedure TCppParser.SetInheritance(Index: Integer);
    Function CheckForScopeDecl(Index: Integer): Boolean;
    Begin
        Result := (Index < fTokenizer.Tokens.Count - 1) And
            ((PToken(fTokenizer.Tokens[Index])^.Text = 'public') Or
            (PToken(fTokenizer.Tokens[Index])^.Text = 'published') Or
            (PToken(fTokenizer.Tokens[Index])^.Text = 'protected') Or
            (PToken(fTokenizer.Tokens[Index])^.Text = 'private') Or
            (PToken(fTokenizer.Tokens[Index])^.Text = '__public') Or
            (PToken(fTokenizer.Tokens[Index])^.Text = '__published') Or
            (PToken(fTokenizer.Tokens[Index])^.Text = '__protected') Or
            (PToken(fTokenizer.Tokens[Index])^.Text = '__private'));
    End;
Var
    sl: TStrings;
Begin
    sl := TStringList.Create;
    Try
  // at this point we are at ':' point in class declaration
  // we have to find the class referenced and return its ID...
        Repeat
            If Not CheckForScopeDecl(Index) Then
                If Not (pToken(fTokenizer.Tokens[Index])^.Text[1] In [',', ':', '(']) Then
                    sl.Add(pToken(fTokenizer.Tokens[Index])^.Text);
            Inc(Index);
        Until pToken(fTokenizer.Tokens[Index])^.Text[1] In ['{', ';', #0];
    Finally
        pStatement(fStatementList[fStatementList.Count - 1])^._InheritsFromClasses := sl.CommaText;
        sl.Free;
    End;
End;

Procedure TCppParser.CheckForSkipStatement;
Var
    iSkip: Integer;
Begin
    iSkip := fSkipList.IndexOf(fIndex);
    If iSkip >= 0 Then
    Begin // skip to next ';'
        Repeat
            Inc(fIndex);
        Until pToken(fTokenizer.Tokens[fIndex])^.Text[1] In [';', #0];
        Inc(fIndex); //skip ';'
        fSkipList.Delete(iSkip);
    End;
End;

Function TCppParser.CheckForKeyword: Boolean;
Begin
    Result := (PToken(fTokenizer.Tokens[fIndex])^.Text = 'static') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'STATIC') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'const') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'CONST') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'extern') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'virtual') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'if') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'else') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'return') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'case') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'switch') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'default') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'break') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'new') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'delete') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'while') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'for') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'do') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'throw') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'try') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'catch') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'using') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'friend');
End;

Function TCppParser.CheckForMember: Boolean;
Begin
    Result := PToken(fTokenizer.Tokens[fIndex])^.Text[Length(PToken(fTokenizer.Tokens[fIndex])^.Text)] = '.';
End;

Function TCppParser.CheckForTypedef: Boolean;
Begin
    Result := PToken(fTokenizer.Tokens[fIndex])^.Text = 'typedef';
End;

Function TCppParser.CheckForEnum: Boolean;
Begin
    Result := PToken(fTokenizer.Tokens[fIndex])^.Text = 'enum';
End;

Function TCppParser.CheckForTypedefStruct: Boolean;
Begin
  //we assume that typedef is the current index, so we check the next
  //should call CheckForTypedef first!!!
    Result := (fIndex < fTokenizer.Tokens.Count - 1) And
        (PToken(fTokenizer.Tokens[fIndex + 1])^.Text = 'struct') Or
        (PToken(fTokenizer.Tokens[fIndex + 1])^.Text = 'class');
//    (PToken(fTokenizer.Tokens[fIndex + 1])^.Text = 'union');
End;

Function TCppParser.CheckForStructs: Boolean;
Var
    I: Integer;
Begin
    Result := (PToken(fTokenizer.Tokens[fIndex])^.Text = 'struct') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'class');
//    (PToken(fTokenizer.Tokens[fIndex])^.Text = 'union');
    If Result Then
    Begin
        If PToken(fTokenizer.Tokens[fIndex + 2])^.Text[1] <> ';' Then
        Begin // not: class something;
            I := fIndex;
    // the check for ']' was added because of this example:
    // struct option long_options[] = {
    //		{"debug", 1, 0, 'D'},
    //		{"info", 0, 0, 'i'},
    //    ...
    //  };
            While Not (PToken(fTokenizer.Tokens[I])^.Text[Length(PToken(fTokenizer.Tokens[I])^.Text)] In [';', ':', '{', '}', ',', ')', ']']) Do
                Inc(I);
            If Not (PToken(fTokenizer.Tokens[I])^.Text[1] In ['{', ':']) Then
                Result := False;
        End;
    End;
End;

Function TCppParser.CheckForTemplate: Boolean;
Begin
    Result := (PToken(fTokenizer.Tokens[fIndex])^.Text = 'template') Or
        (Copy(PToken(fTokenizer.Tokens[fIndex])^.Text, 1, 9) = 'template<');
End;

Function TCppParser.CheckForUnion: Boolean;
Begin
    Result := (PToken(fTokenizer.Tokens[fIndex])^.Text = 'union');
End;

Function TCppParser.CheckForMethod: Boolean;
Var
    I, I1: Integer;
    JumpOver: Boolean;
Begin
    If PToken(fTokenizer.Tokens[fIndex])^.Text[1] = '(' Then
    Begin
        Result := False;
        Exit;
//  end
//  else if PToken(fTokenizer.Tokens[fIndex])^.Text = 'operator' then begin // skip over operator functions
//    repeat
//      Inc(fIndex);
//    until PToken(fTokenizer.Tokens[fIndex])^.Text[1] in [';', '{', '}', #0];
//    fIndex := SkipBraces(fIndex);
//    Result := False;
//    Exit;
    End;
    I := fIndex;
    Result := False;
    JumpOver := False;
    While (I < fTokenizer.Tokens.Count) And Not (PToken(fTokenizer.Tokens[I])^.Text[1] In ['{', '}', ';', ',', #0]) Do
    Begin
        If (PToken(fTokenizer.Tokens[I])^.Text[Length(PToken(fTokenizer.Tokens[I])^.Text)] = '.') Or
            ((Length(PToken(fTokenizer.Tokens[I])^.Text) > 1) And
            (PToken(fTokenizer.Tokens[I])^.Text[Length(PToken(fTokenizer.Tokens[I])^.Text)] = '>') And
            (PToken(fTokenizer.Tokens[I])^.Text[Length(PToken(fTokenizer.Tokens[I])^.Text) - 1] = '-')) Then
        Begin
            Result := False;
            JumpOver := True;
            Break;
        End
    // ignore operator functions
//    else if (AnsiCompareStr(PToken(fTokenizer.Tokens[I])^.Text, 'operator') = 0) or
//      (AnsiCompareStr(PToken(fTokenizer.Tokens[I])^.Text, 'operator*') = 0) or
//      (AnsiCompareStr(PToken(fTokenizer.Tokens[I])^.Text, 'operator[]') = 0) or
//      AnsiEndsStr('::operator', PToken(fTokenizer.Tokens[I])^.Text) or
//      AnsiEndsStr('::operator*', PToken(fTokenizer.Tokens[I])^.Text) or
//      AnsiEndsStr('::operator[]', PToken(fTokenizer.Tokens[I])^.Text) then begin
//      Result := False;
//      JumpOver := True;
//      Break;
//    end
        Else
        If PToken(fTokenizer.Tokens[I])^.Text[1] = '(' Then
        Begin
            Result := PToken(fTokenizer.Tokens[I + 1])^.Text[1] In [':', ';', '{', '}'];
            If Not Result Then
            Begin
                If PToken(fTokenizer.Tokens[I + 1])^.Text[1] = '(' Then
                    Result := False
                Else
                If (I < fTokenizer.Tokens.Count - 2) Then
                Begin // situations where e.g. 'const' might follow...
                    I1 := fIndex;
                    fIndex := I + 1;
                    If Not CheckForScope Then
                        Result := PToken(fTokenizer.Tokens[I + 2])^.Text[1] In [':', ';', '{', '}'];
                    fIndex := I1;
                End;
            End;
            Break;
        End;
        Inc(I);
    End;
    If JumpOver Then
        While Not (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In ['{', '}', ';', ',', #0]) Do
            Inc(fIndex);
End;

Function TCppParser.CheckForScope: Boolean;
Begin
    Result := (fIndex < fTokenizer.Tokens.Count - 1) And
        (PToken(fTokenizer.Tokens[fIndex + 1])^.Text = ':') And
        ((PToken(fTokenizer.Tokens[fIndex])^.Text = 'public') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'published') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'protected') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'private') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = '__public') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = '__published') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = '__protected') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = '__private'));
End;

Function TCppParser.CheckForPreprocessor: Boolean;
Begin
    Result := PToken(fTokenizer.Tokens[fIndex])^.Text[1] = '#';
End;

Function TCppParser.CheckForVar: Boolean;
Var
    I: Integer;
Begin
    If fIndex < fTokenizer.Tokens.Count - 1 Then
        For I := 0 To 1 Do // check the current and the next token
            If CheckForKeyword Or
                (PToken(fTokenizer.Tokens[fIndex + I])^.Text[1] In [',', ';', ':', '{', '}', '!', '/', '+', '-']) Or
                (PToken(fTokenizer.Tokens[fIndex + I])^.Text[Length(PToken(fTokenizer.Tokens[fIndex + I])^.Text)] = '.') Or
                ((Length(PToken(fTokenizer.Tokens[fIndex + I])^.Text) > 1) And
                (PToken(fTokenizer.Tokens[fIndex + I])^.Text[Length(PToken(fTokenizer.Tokens[fIndex + I])^.Text) - 1] = '-') And
                (PToken(fTokenizer.Tokens[fIndex + I])^.Text[Length(PToken(fTokenizer.Tokens[fIndex + I])^.Text)] = '>')) Then
            Begin
                Result := False;
                Exit;
            End;

    I := fIndex;
    Result := True;
    While I < fTokenizer.Tokens.Count - 1 Do
    Begin
        If (PToken(fTokenizer.Tokens[I])^.Text[1] In ['{', '}', '(']) Or
            CheckForKeyword Then
        Begin
            Result := False;
            Break;
        End
        Else
        If PToken(fTokenizer.Tokens[I])^.Text[1] In [',', ';'] Then
            Break;
        Inc(I);
    End;
End;

Function TCppParser.GetScope: TStatementScope;
Begin
    If fLaterScanning Then
    Begin
        Result := ssLocal;
        Exit;
    End;
    If fLevel = 0 Then
        Result := ssGlobal
    Else
    Begin
        If GetCurrentClass <> -1 Then
            Result := ssClassLocal
        Else
            Result := ssLocal;
//      Result := ssGlobal;
    End;
End;

Procedure TCppParser.HandleMember;
Begin
    Repeat
        Inc(fIndex);
    Until (fIndex >= fTokenizer.Tokens.Count) Or (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In [';', '}']);
    Inc(fIndex);
End;

Procedure TCppParser.HandleUnion;
Begin
  // goto '{' or ';'
    While (fIndex < fTokenizer.Tokens.Count) And
        Not (PToken(fTokenizer.Tokens[fIndex])^.Text[Length(PToken(fTokenizer.Tokens[fIndex])^.Text)] In ['{', '}', ';']) Do
        Inc(fIndex);
End;

Procedure TCppParser.HandleTemplate;
Begin
  // goto '{' or ';'
    While (fIndex < fTokenizer.Tokens.Count) And
        Not (PToken(fTokenizer.Tokens[fIndex])^.Text[Length(PToken(fTokenizer.Tokens[fIndex])^.Text)] In ['>', '{', ';']) Do
        Inc(fIndex);

    If PToken(fTokenizer.Tokens[fIndex])^.Text[1] = '{' Then
    Begin
        Inc(fIndex);

    // we just skip over the template ;)
        While (fIndex < fTokenizer.Tokens.Count) And
            Not (PToken(fTokenizer.Tokens[fIndex])^.Text[1] = '}') Do
        Begin
            If PToken(fTokenizer.Tokens[fIndex])^.Text[1] = '{' Then //recurse
                HandleTemplate;
            Inc(fIndex);
        End;
    End
    Else
        Inc(fIndex); // probably on "class" keyword
End;

Procedure TCppParser.HandleOtherTypedefs;
Begin
  // just skip them...
    While (fIndex < fTokenizer.Tokens.Count) And (Not (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In [';', #0])) Do
        Inc(fIndex);
End;

Procedure TCppParser.HandleStructs(IsTypedef: Boolean = False);
Var
    S, S1, S2, Prefix, StructName: String;
    I, I1, cID: Integer;
    IsStruct: Boolean;
    UseID: Integer;
    NameVisible: Boolean;
Begin
    NameVisible := True;
    S := PToken(fTokenizer.Tokens[fIndex])^.Text;
    IsStruct := (S = 'struct'); // or (S = 'union');
    S := S + ' ';
    Prefix := S;
    Inc(fIndex); //skip 'struct'
    I := fIndex;
    UseID := -1;
    While (I < fTokenizer.Tokens.Count) And Not (PToken(fTokenizer.Tokens[I])^.Text[1] In [';', '{']) Do
        Inc(I);

  // forward class/struct decl *or* typedef, e.g. typedef struct some_struct synonym1, synonym2;
    If (I < fTokenizer.Tokens.Count) And (PToken(fTokenizer.Tokens[I])^.Text[1] = ';') Then
    Begin
        StructName := PToken(fTokenizer.Tokens[fIndex])^.Text;
        If IsTypedef Then
        Begin
            Repeat
                If (fIndex + 1 < fTokenizer.Tokens.Count) And (PToken(fTokenizer.Tokens[fIndex + 1])^.Text[1] In [',', ';']) Then
                Begin
                    S := S + PToken(fTokenizer.Tokens[fIndex])^.Text + ' ';
          // TODO: there is a possibility to have a typedef struct arg1 arg2
          // where arg1 is declared later in the code (is it C-legal???).
          // So GetClassID now will return -1 and arg2
          // will appear as struct but will be empty :(
          // I should use a custom TList to add arg1 in it
          // and then, every new struct *decl* check the list before to see
          // if it is included in it. In that case, we use
          // the ID of the TList for the new struct and then remove
          // the arg1 from the TList...

          // DECISION: should the TList, be emptied at the end of file,
          // or remain? Maybe it is declared in another file...
                    cID := GetClassID(StructName, skClass);
                    fLastID := AddStatement(cID,
                        GetCurrentClass,
                        fCurrentFile,
                        Prefix + PToken(fTokenizer.Tokens[fIndex])^.Text,
                        Prefix,
                        PToken(fTokenizer.Tokens[fIndex])^.Text,
                        '',
                        PToken(fTokenizer.Tokens[fIndex])^.Line,
                        skClass,
                        GetScope,
                        fClassScope,
                        NameVisible,
                        False);
                    NameVisible := False;
                    If cID = -1 Then
                        AddToOutstandingTypedefs(StructName, fLastID);
                End;
                Inc(fIndex);
            Until (fIndex >= fTokenizer.Tokens.Count) Or (PToken(fTokenizer.Tokens[fIndex])^.Text[1] = ';');
      // removed support for forward decls in version 1.6
        End;
    End

  // normal class/struct decl
    Else
    Begin
        Inc(fInClass);
        If PToken(fTokenizer.Tokens[fIndex])^.Text[1] <> '{' Then
        Begin
            S1 := '';
            S2 := '';
            Repeat
                S := S + PToken(fTokenizer.Tokens[fIndex])^.Text + ' ';
                If Not (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In [',', ';', '{', ':']) Then
                    S1 := S1 + PToken(fTokenizer.Tokens[fIndex])^.Text + ' ';
                If (fIndex + 1 < fTokenizer.Tokens.Count) And (PToken(fTokenizer.Tokens[fIndex + 1])^.Text[1] = '(') Then
                    S2 := PToken(fTokenizer.Tokens[fIndex])^.Text;
                If (fIndex + 1 < fTokenizer.Tokens.Count) And (PToken(fTokenizer.Tokens[fIndex + 1])^.Text[1] In [',', ';', '{', ':']) Then
                Begin
                    If S2 = '' Then
                        S2 := PToken(fTokenizer.Tokens[fIndex])^.Text;
                    If Trim(S1) <> '' Then
                    Begin
                        cID := GetClassID(Trim(S1), skClass);
                        If cID = -1 Then
                            cID := CheckForOutstandingTypedef(Trim(S1));
                        fLastID := AddStatement(cID, //UseID,
                            GetCurrentClass,
                            fCurrentFile,
                            Prefix + Trim(S1),
                            Prefix,
                            S2,
                            '',
                            PToken(fTokenizer.Tokens[fIndex])^.Line,
                            skClass,
                            GetScope,
                            fClassScope,
                            NameVisible,
                            False);
                        NameVisible := False;
                    End;
                    S1 := '';
                End;
                Inc(fIndex);
            Until (fIndex >= fTokenizer.Tokens.Count) Or (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In [':', '{', ';']);
            UseID := fLastID;
        End;

        If (fIndex < fTokenizer.Tokens.Count) And (PToken(fTokenizer.Tokens[fIndex])^.Text[1] = ':') Then
        Begin
            SetInheritance(fIndex); // set the _InheritsFromClasses value
            While (fIndex < fTokenizer.Tokens.Count) And (PToken(fTokenizer.Tokens[fIndex])^.Text[1] <> '{') Do // skip decl after ':'
                Inc(fIndex);
        End;

    // check for struct names after '}'
        If IsStruct Then
        Begin
            I := SkipBraces(fIndex);

            S1 := '';
            If (I + 1 < fTokenizer.Tokens.Count) And (PToken(fTokenizer.Tokens[I + 1])^.Text[1] <> ';') Then
                fSkipList.Add(I + 1);
            If (I + 1 < fTokenizer.Tokens.Count) Then
                Repeat
                    Inc(I);

                    If Not (PToken(fTokenizer.Tokens[I])^.Text[1] In ['{', ',', ';']) Then
                    Begin
                        If PToken(fTokenizer.Tokens[I])^.Text[1] = '#' Then
                        Begin
                            I1 := fIndex;
                            fIndex := I;
                            HandlePreprocessor;
                            fIndex := I1;
                        End
                        Else
                        If (PToken(fTokenizer.Tokens[I])^.Text[1] = '_') And
                            (PToken(fTokenizer.Tokens[I])^.Text[Length(PToken(fTokenizer.Tokens[I])^.Text)] = '_') Then
            // skip possible gcc attributes
            // start and end with 2 underscores (i.e. __attribute__)
            // so, to avoid slow checks of strings, we just check the first and last letter of the token
            // if both are underscores, we split
                            Break
                        Else
                        Begin
                            If PToken(fTokenizer.Tokens[I])^.Text[Length(PToken(fTokenizer.Tokens[I])^.Text)] = ']' Then // cut-off array brackets
                                S1 := S1 + Copy(PToken(fTokenizer.Tokens[I])^.Text, 1, AnsiPos('[', PToken(fTokenizer.Tokens[I])^.Text) - 1) + ' '
                            Else
                                S1 := S1 + PToken(fTokenizer.Tokens[I])^.Text + ' ';
                        End;
                    End
                    Else
                    Begin
                        If Trim(S1) <> '' Then
                        Begin
                            If UseID <> -1 Then
                                cID := UseID
                            Else
                                cID := CheckForOutstandingTypedef(Trim(S1));
                            fLastID := AddStatement(cID,
                                GetCurrentClass,
                                fCurrentFile,
                                Prefix + Trim(S1),
                                Prefix,
                                Trim(S1),
                                '',
                                PToken(fTokenizer.Tokens[I])^.Line,
                                skClass,
                                GetScope,
                                fClassScope,
                                NameVisible,
                                True);
                            NameVisible := False;
                        End;
                        UseID := fLastID;
                        S1 := '';
                    End;

                    If Not (PToken(fTokenizer.Tokens[I])^.Text[1] In [';', ',', '#']) Then
                        S := S + ' ' + PToken(fTokenizer.Tokens[I])^.Text;
                Until (I >= fTokenizer.Tokens.Count) Or (PToken(fTokenizer.Tokens[I])^.Text[1] In ['{', ';']);
        End;
        SetCurrentClass(fLastID);
    End;
    If fLogStatements Then
        If Assigned(fOnLogStatement) Then
            fOnLogStatement(Self, '[parser   ]: -C- ' + Format('%4d ', [PToken(fTokenizer.Tokens[fIndex - 1])^.Line]) + StringOfChar(' ', fLevel) + Trim(S));
End;

Procedure TCppParser.HandleMethod;
Var
    S, S1, S2, S3: String;
    bTypeOK, bOthersOK: Boolean;
    IsValid: Boolean;
    CurrClass: Integer;
    I: Integer;
    IsDeclaration: Boolean;
Begin
    IsValid := True;
    S := '';
    S1 := '';
    S2 := '';
    S3 := '';
    bTypeOK := False;
    bOthersOK := False;
    CurrClass := GetCurrentClass;
    I := fIndex;
    While (fIndex < fTokenizer.Tokens.Count) And (Not (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In [';', ':', '{', '}', #0])) Do
    Begin
        If PToken(fTokenizer.Tokens[fIndex])^.Text[1] <> '#' Then // jump-over preprocessor directives in definition
            S := S + PToken(fTokenizer.Tokens[fIndex])^.Text + ' ';

        If Not bTypeOK And
            (PToken(fTokenizer.Tokens[fIndex + 1])^.Text[1] <> '(') And
            ((fIndex < fTokenizer.Tokens.Count - 2) And (PToken(fTokenizer.Tokens[fIndex + 2])^.Text[1] <> '(')) Then //type
            S1 := S1 + PToken(fTokenizer.Tokens[fIndex])^.Text + ' '
        Else
        If Not bTypeOK And
            (PToken(fTokenizer.Tokens[fIndex + 1])^.Text[1] <> '(') And
            ((fIndex < fTokenizer.Tokens.Count - 2) And (PToken(fTokenizer.Tokens[fIndex + 2])^.Text[1] = '(')) Then //type
            S1 := S1 + PToken(fTokenizer.Tokens[fIndex])^.Text + ' '
        Else
        If Not bOthersOK And
            (PToken(fTokenizer.Tokens[fIndex + 1])^.Text[1] = '(') And
            ((fIndex < fTokenizer.Tokens.Count - 2) And (PToken(fTokenizer.Tokens[fIndex + 2])^.Text[1] <> '(')) Then
        Begin //command
            S2 := PToken(fTokenizer.Tokens[fIndex])^.Text;
            S3 := PToken(fTokenizer.Tokens[fIndex + 1])^.Text;
            bTypeOK := True;
        End;

        Inc(fIndex);
    End;
    IsDeclaration := False;
    If PToken(fTokenizer.Tokens[fIndex])^.Text[1] In [';', '}'] Then
    Begin
        IsDeclaration := True;
        If Not fIsHeader And (CurrClass = -1) Then
            IsValid := False;
    End
    Else
    Begin
        If PToken(fTokenizer.Tokens[fIndex])^.Text[1] = ':' Then
            While (fIndex < fTokenizer.Tokens.Count) And (Not (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In [';', '{', '}', #0])) Do
                Inc(fIndex);
        If PToken(fTokenizer.Tokens[fIndex])^.Text[1] In [';', '}'] Then
        Begin
            IsDeclaration := True;
            If Not fIsHeader And (CurrClass = -1) Then
                IsValid := False;
        End;
    End;
    If Not bTypeOK Then
        S1 := '';
    If IsValid Then
        fLastID := AddStatement(-1,
            CurrClass,
            fCurrentFile,
            S,
            Trim(S1),
            Trim(S2),
            Trim(S3),
            PToken(fTokenizer.Tokens[fIndex - 1])^.Line,
            skFunction,
            GetScope,
            fClassScope,
            True,
            False,
            IsDeclaration);
  // don't parse the function's block now... It will be parsed when user presses ctrl+space inside it ;)
    If (PToken(fTokenizer.Tokens[fIndex])^.Text[1] = '{') Then
        fIndex := SkipBraces(fIndex) + 1; // add 1 so that '}' is not visible to parser
    If fLogStatements Then
        If Assigned(fOnLogStatement) And IsValid Then
            fOnLogStatement(Self, '[parser   ]: -M- ' + Format('%4d ', [PToken(fTokenizer.Tokens[fIndex - 1])^.Line]) + StringOfChar(' ', fLevel) + Trim(S));
    If I = fIndex Then // if not moved ahead, something is wrong but don't get stuck ;)
        If fIndex < fTokenizer.Tokens.Count Then
            If Not (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In ['{', '}', #0]) Then
                Inc(fIndex);
End;

Procedure TCppParser.HandleScope;
Begin
    If (PToken(fTokenizer.Tokens[fIndex])^.Text = 'public') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = '__public') Then
        fClassScope := scsPublic
    Else
    If (PToken(fTokenizer.Tokens[fIndex])^.Text = 'published') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = '__published') Then
        fClassScope := scsPublished
    Else
    If (PToken(fTokenizer.Tokens[fIndex])^.Text = 'private') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = '__private') Then
        fClassScope := scsPrivate
    Else
    If (PToken(fTokenizer.Tokens[fIndex])^.Text = 'protected') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = '__protected') Then
        fClassScope := scsProtected
    Else
        fClassScope := scsNone;
    If fLogStatements Then
        If Assigned(fOnLogStatement) Then
            fOnLogStatement(Self, '[parser   ]: -S- ' + Format('%4d ', [PToken(fTokenizer.Tokens[fIndex])^.Line]) + StringOfChar(' ', fLevel) + PToken(fTokenizer.Tokens[fIndex])^.Text);
    Inc(fIndex, 2); // the scope is followed by a ':'
End;

Procedure TCppParser.HandlePreprocessor;
Var
    sl: TStringList;
    Index: Integer;
    FName: String;
    FullFName: String;
    StrFullText: String;
    StrArgs: String;
    StrCommand: String;
    IsGlobal: Boolean;
    OpenBracketPos: Integer;
    I: Integer;
Begin
    sl := TStringList.Create;
    Try
        ExtractStrings([' '], [' '], @(PToken(fTokenizer.Tokens[fIndex])^.Text)[1], sl);
        If sl.Count > 0 Then
        Begin
      // INCLUDES
            If sl[0] = '#include' Then
                Index := 1
            Else
            If (sl.Count > 1) And (sl[0] = '#') And (sl[1] = 'include') Then
                Index := 2
            Else
                Index := -1;
            If Index <> -1 Then
            Begin
                FName := StringReplace(sl[Index], '<', '', [rfReplaceAll]);
                FName := StringReplace(FName, '>', '', [rfReplaceAll]);
                FName := StringReplace(FName, '"', '', [rfReplaceAll]);
                FullFName := LowerCase(ExpandFileName(GetFullFileName(FName)));
                With PIncludesRec(fIncludesList[fIncludesList.Count - 1])^ Do
                    IncludeFiles := IncludeFiles + AnsiQuotedStr(FullFName, '"') + ',';
                IsGlobal := IsGlobalFile(FullFName);
                If {not fReparsing and}((fParseGlobalHeaders And IsGlobal) Or (fParseLocalHeaders And Not IsGlobal)) Then
                Begin
                    AddFileToScan(FullFName);
                    If fLogStatements Then
                        If Assigned(fOnLogStatement) Then
                            fOnLogStatement(Self, '[parser   ]: -P- ' + Format('%4d ', [PToken(fTokenizer.Tokens[fIndex])^.Line]) + StringOfChar(' ', fLevel) + Format('#INCLUDE %s (scheduled to be scanned)', [FName]));
                End;
            End

      // DEFINITIONS
            Else
            Begin
                If sl[0] = '#define' Then
                Begin
                    Index := 1;
                End
                Else
                Begin
                    If (sl.Count > 1) And (sl[0] = '#') And (sl[1] = 'define') Then
                    Begin
                        Index := 2;
                    End
                    Else
                    Begin
                        Index := -1;
                    End;
                End;

        // modified by peter_
                If (Index <> -1) And (sl.Count > Index + 1) Then
                Begin
                    StrFullText := sl[Index];
                    OpenBracketPos := AnsiPos('(', StrFullText);

          // Is it a #define with arguments, like 'foo(a, b)' ?
                    If OpenBracketPos > 0 Then
                    Begin
                        I := Index + 1;

            // Because of the call to ExtractStrings, a few lines
            // above, the define could be seperated into several
            // strings. This would result into:
            // 1) foo(a,
            // 2) b)
            // Because this is kinda wrong, we have to loop through
            // the List and merge our FullText again in order to get
            // this: foo(a, b)
                        While AnsiPos(')', StrFullText) = 0 Do
                        Begin
                            StrFullText := StrFullText + sl[I];
                            Inc(I);
                        End;

            // Copy '(a, b)' out of 'foo(a, b)'
                        StrArgs := Copy(StrFullText, OpenBracketPos, Length(StrFullText) - OpenBracketPos + 1);

            // Copy 'foo' out of 'foo(a, b)'
                        StrCommand := Copy(StrFullText, 1, OpenBracketPos - 1);
                    End
                    Else
                    Begin
            // In case the #define has no arguments, the Command is just
            // the same as the define name!
                        StrCommand := StrFullText;

            // and we don't have an argument
                        StrArgs := '';
                    End;

                    AddStatement(-1 {GetClassID(StrCommand, skPreprocessor)},
                        GetCurrentClass,
                        FCurrentFile,
                        StrFullText,
                        '',
                        StrCommand,
                        StrArgs,
                        PToken(FTokenizer.Tokens[FIndex])^.Line,
                        skPreprocessor,
                        GetScope,
                        FClassScope,
                        False,
                        True);
                End

        // All OTHER
                Else
                Begin
                    If fLogStatements Then
                    Begin
                        If Assigned(fOnLogStatement) Then
                        Begin
                            fOnLogStatement(Self, '[parser   ]: -P- ' +
                                Format('%4d ', [PToken(fTokenizer.Tokens[fIndex])^.Line]) +
                                StringOfChar(' ', fLevel) + 'Unknown definition: ' +
                                PToken(fTokenizer.Tokens[fIndex])^.Text);
                        End;
                    End;
                End;
            End;

        End
        Else
        Begin
            If fLogStatements Then
            Begin
                If Assigned(fOnLogStatement) Then
                Begin
                    fOnLogStatement(Self, '[parser   ]: -P- ' +
                        Format('%4d ', [PToken(fTokenizer.Tokens[fIndex])^.Line]) +
                        StringOfChar(' ', fLevel) + 'Unknown definition: ' +
                        PToken(fTokenizer.Tokens[fIndex])^.Text);
                End;
            End;
        End;
    Finally
        sl.Free;
    End;
    Inc(fIndex);
End;

Procedure TCppParser.HandleKeyword;
Begin
    If (PToken(fTokenizer.Tokens[fIndex])^.Text = 'static') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'STATIC') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'const') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'CONST') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'extern') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'virtual') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'else') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'break') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'new') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'try') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'do') Then
        Inc(fIndex) //skip it
    Else
    If (PToken(fTokenizer.Tokens[fIndex])^.Text = 'if') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'switch') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'while') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'for') Then
    Begin //skip to ')'
        Repeat
            Inc(fIndex);
        Until (fIndex >= fTokenizer.Tokens.Count) Or (PToken(fTokenizer.Tokens[fIndex])^.Text[Length(PToken(fTokenizer.Tokens[fIndex])^.Text)] In [#0, ')']);
        Inc(fIndex);
    End
    Else
    If (PToken(fTokenizer.Tokens[fIndex])^.Text = 'case') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'default') Then
    Begin //skip to ':'
        Repeat
            Inc(fIndex);
        Until (fIndex >= fTokenizer.Tokens.Count) Or (PToken(fTokenizer.Tokens[fIndex])^.Text[Length(PToken(fTokenizer.Tokens[fIndex])^.Text)] In [#0, ':', '}']);
        If (fIndex >= fTokenizer.Tokens.Count) Then
            exit;
        If PToken(fTokenizer.Tokens[fIndex])^.Text[1] = ':' Then
            Inc(fIndex);
    End
    Else
    If (PToken(fTokenizer.Tokens[fIndex])^.Text = 'return') Or //skip to ';'
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'delete') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'throw') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'using') Or
        (PToken(fTokenizer.Tokens[fIndex])^.Text = 'friend') Then
    Begin
        Repeat
            Inc(fIndex);
        Until (fIndex >= fTokenizer.Tokens.Count) Or (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In [#0, ';', '}']);
        If (fIndex >= fTokenizer.Tokens.Count) Then
            exit;
        If PToken(fTokenizer.Tokens[fIndex])^.Text = ';' Then
            Inc(fIndex);
    End
    Else
    If (PToken(fTokenizer.Tokens[fIndex])^.Text = 'catch') Then
    Begin //skip to '{'
        Repeat
            Inc(fIndex);
        Until (fIndex >= fTokenizer.Tokens.Count) Or (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In [#0, '{', '}']);
    End;
End;

Procedure TCppParser.HandleVar;
Var
    LastType: String;
    Args: String;
    Cmd: String;
Begin
    LastType := '';
    Repeat
        If (fIndex < fTokenizer.Tokens.Count - 1) And (PToken(fTokenizer.Tokens[fIndex + 1])^.Text[1] In [',', ';', ':', '}']) Then
            Break;
        If (PToken(fTokenizer.Tokens[fIndex])^.Text <> 'struct') And
            (PToken(fTokenizer.Tokens[fIndex])^.Text <> 'class') Then
//      (PToken(fTokenizer.Tokens[fIndex])^.Text <> 'union') then
            LastType := Trim(LastType + ' ' + PToken(fTokenizer.Tokens[fIndex])^.Text);
        Inc(fIndex);
    Until fIndex = fTokenizer.Tokens.Count;
    If fIndex = fTokenizer.Tokens.Count Then
        Exit;

    Repeat
    // skip bit identifiers,
    // e.g.:
    // handle
    // unsigned short bAppReturnCode:8,reserved:6,fBusy:1,fAck:1
    // as
    // unsigned short bAppReturnCode,reserved,fBusy,fAck
        If PToken(fTokenizer.Tokens[fIndex])^.Text[1] = ':' Then
            Repeat
                Inc(fIndex);
            Until (fIndex >= fTokenizer.Tokens.Count) Or (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In [',', ';', '{', '}']);   // CL: added check for fIndex validity
        If fIndex = fTokenizer.Tokens.Count Then
            Exit;
        If Not (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In [',', ';']) Then
        Begin
            If fLogStatements Then
                If Assigned(fOnLogStatement) Then
                    fOnLogStatement(Self, '[parser   ]: -V- ' + Format('%4d ', [PToken(fTokenizer.Tokens[fIndex])^.Line]) + StringOfChar(' ', fLevel) + Trim(LastType + ' ' + PToken(fTokenizer.Tokens[fIndex])^.Text));
            If PToken(fTokenizer.Tokens[fIndex])^.Text[Length(PToken(fTokenizer.Tokens[fIndex])^.Text)] = ']' Then
            Begin //array; break args
                Cmd := Copy(PToken(fTokenizer.Tokens[fIndex])^.Text, 1, AnsiPos('[', PToken(fTokenizer.Tokens[fIndex])^.Text) - 1);
                Args := Copy(PToken(fTokenizer.Tokens[fIndex])^.Text, AnsiPos('[', PToken(fTokenizer.Tokens[fIndex])^.Text), Length(PToken(fTokenizer.Tokens[fIndex])^.Text) - AnsiPos('[', PToken(fTokenizer.Tokens[fIndex])^.Text) + 1);
            End
            Else
            Begin
                Cmd := PToken(fTokenizer.Tokens[fIndex])^.Text;
                Args := '';
            End;
            fLastID := AddStatement(-1,
                GetCurrentClass,
                fCurrentFile,
                LastType + ' ' + PToken(fTokenizer.Tokens[fIndex])^.Text,
                LastType,
                Cmd,
                Args,
                PToken(fTokenizer.Tokens[fIndex])^.Line,
                skVariable,
                GetScope,
                fClassScope,
                True, //GetCurrentClass <> -1,
                True);
        End;
        If Not (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In [';', '{', '}']) Then
            Inc(fIndex);
    Until (fIndex >= fTokenizer.Tokens.Count) Or (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In [';', '{', '}']);
    If (fIndex >= fTokenizer.Tokens.Count) Then
        exit;
    If Not (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In ['{', '}']) Then
        Inc(fIndex);
End;

Procedure TCppParser.HandleEnum;
Var
    LastType: String;
    Args: String;
    Cmd: String;
    I: Integer;
Begin
    LastType := 'enum ';
    Inc(fIndex); //skip 'enum'
    If PToken(fTokenizer.Tokens[fIndex])^.Text[1] = '{' Then
    Begin // enum {...} NAME
        I := fIndex;
        Repeat
            Inc(I);
        Until (I >= fTokenizer.Tokens.Count) Or (PToken(fTokenizer.Tokens[I])^.Text[1] In ['}', #0]);
        If (I >= fTokenizer.Tokens.Count) Then
            exit;
        If PToken(fTokenizer.Tokens[I])^.Text[1] = '}' Then
            If PToken(fTokenizer.Tokens[I + 1])^.Text[1] <> ';' Then
                LastType := LastType + PToken(fTokenizer.Tokens[I + 1])^.Text + ' ';
    End
    Else // enum NAME {...};
        While Not (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In ['{', ';', #0]) Do
        Begin
            LastType := LastType + PToken(fTokenizer.Tokens[fIndex])^.Text + ' ';
            Inc(fIndex);
            If (fIndex >= fTokenizer.Tokens.Count) Then
                exit;
        End;
    LastType := Trim(LastType);

    If PToken(fTokenizer.Tokens[fIndex])^.Text[1] = '{' Then
    Begin
        Inc(fIndex);

        Repeat
            If Not (PToken(fTokenizer.Tokens[fIndex])^.Text[1] In [',', '#', ';']) Then
            Begin
                If fLogStatements Then
                    If Assigned(fOnLogStatement) Then
                        fOnLogStatement(Self, '[parser   ]: -E- ' + Format('%4d ', [PToken(fTokenizer.Tokens[fIndex])^.Line]) + StringOfChar(' ', fLevel) + Trim(LastType + ' ' + PToken(fTokenizer.Tokens[fIndex])^.Text));
                If PToken(fTokenizer.Tokens[fIndex])^.Text[Length(PToken(fTokenizer.Tokens[fIndex])^.Text)] = ']' Then
                Begin //array; break args
                    Cmd := Copy(PToken(fTokenizer.Tokens[fIndex])^.Text, 1, AnsiPos('[', PToken(fTokenizer.Tokens[fIndex])^.Text) - 1);
                    Args := Copy(PToken(fTokenizer.Tokens[fIndex])^.Text, AnsiPos('[', PToken(fTokenizer.Tokens[fIndex])^.Text), Length(PToken(fTokenizer.Tokens[fIndex])^.Text) - AnsiPos('[', PToken(fTokenizer.Tokens[fIndex])^.Text) + 1);
                End
                Else
                Begin
                    Cmd := PToken(fTokenizer.Tokens[fIndex])^.Text;
                    Args := '';
                End;
                fLastID := AddStatement(-1,
                    GetCurrentClass,
                    fCurrentFile,
                    LastType + ' ' + PToken(fTokenizer.Tokens[fIndex])^.Text,
                    LastType,
                    Cmd,
                    Args,
                    PToken(fTokenizer.Tokens[fIndex])^.Line,
                    skEnum,
                    GetScope,
                    fClassScope,
                    False,
                    True);
            End;
            If PToken(fTokenizer.Tokens[fIndex])^.Text[1] = '#' Then
                HandlePreprocessor;
            Inc(fIndex);
            If (fIndex >= fTokenizer.Tokens.Count) Then
                exit;
        Until PToken(fTokenizer.Tokens[fIndex])^.Text[1] In [';', '{', '}'];
        If PToken(fTokenizer.Tokens[fIndex])^.Text[1] = '}' Then
            Inc(fIndex);
    End;
End;

Function TCppParser.HandleStatement: Boolean;
Begin
    If PToken(fTokenizer.Tokens[fIndex])^.Text[1] = '{' Then
    Begin
        Inc(fLevel, 2);
        Inc(fIndex);
        If fInClass > 0 Then
            Inc(fInClass);
    End
    Else
    If PToken(fTokenizer.Tokens[fIndex])^.Text = '}' Then
    Begin
        Dec(fLevel, 2);
        Inc(fIndex);
        If fInClass > 0 Then
            Dec(fInClass);
        RemoveCurrentClass;
    End
    Else
    If CheckForPreprocessor Then
    Begin
        HandlePreprocessor;
    End
    Else
    If CheckForMember Then
    Begin
        HandleMember;
    End
    Else
    If CheckForKeyword Then
    Begin
        HandleKeyword;
    End
    Else
    If CheckForScope Then
    Begin
        HandleScope;
    End
    Else
    If CheckForEnum Then
    Begin
        HandleEnum;
    End
    Else
    If CheckForTypedef Then
    Begin
        If CheckForTypedefStruct Then
        Begin
            Inc(fIndex); //skip typedef
            HandleStructs(True);
        End
        Else
            HandleOtherTypedefs;
    End
    Else
    If CheckForTemplate Then
    Begin
        HandleTemplate;
    End
    Else
    If CheckForUnion Then
    Begin
        HandleUnion;
    End
    Else
    If CheckForStructs Then
    Begin
        HandleStructs(False);
    End
    Else
    If CheckForMethod Then
    Begin
        HandleMethod;
    End
    Else
    If CheckForVar Then
    Begin
        HandleVar;
    End
    Else
        Inc(fIndex);

    CheckForSkipStatement;

    If Assigned(fOnFileProgress) Then
        fOnFileProgress(Self, fCurrentFile, fTokenizer.Tokens.Count, fIndex);

    Result := fIndex < fTokenizer.Tokens.Count;
End;

Procedure TCppParser.Parse(FileName: TFileName; IsVisible: Boolean; ManualUpdate: Boolean = False; processInh: Boolean = True);
Var
    sTime: myTickCount;
    P: PIncludesRec;
Begin
    If Not fEnabled Then
        Exit;
    If Not (IsCfile(Filename) Or IsHfile(Filename)) Then // support only known C/C++ files
        Exit;
    If fTokenizer = Nil Then
        Exit;
    If (Not ManualUpdate) And Assigned(fOnStartParsing) Then
        fOnStartParsing(Self);
    ClearOutstandingTypedefs;
    sTime := myGetTickCount;
    If Assigned(fOnLogStatement) Then
        fOnLogStatement(Self, '[parser   ]: Parsing ' + FileName);
    fTokenizer.Reset;
    Try
        fTokenizer.Tokenize(FileName);
        If fTokenizer.Tokens.Count = 0 Then
            Exit;
    Except
        If (Not ManualUpdate) And Assigned(fOnEndParsing) Then
            fOnEndParsing(Self);
        Exit;
    End;
    fCurrentFile := LowerCase(FileName);
    fIsProjectFile := fProjectFiles.IndexOf(fCurrentFile) <> -1;
    fIndex := 0;
    fLevel := 0;
    fLastID := -1;
    P := New(PIncludesRec);
    P^.BaseFile := fCurrentFile;
    P^.IncludeFiles := '';
    fIncludesList.Add(P);
    fIsHeader := IsHfile(Filename);
    fCurrentClass := TIntList.Create;
    fCurrentClassLevel := TIntList.Create;
    fSkipList := TIntList.Create;
    fLastStatementKind := skUnknown;
    If Assigned(fOnFileProgress) Then
        fOnFileProgress(Self, fCurrentFile, fTokenizer.Tokens.Count, 0);
    fVisible := IsVisible;
    Try
        Try
            Repeat
            Until Not HandleStatement;
            If processInh Then
                PostProcessInheritance;
            If Assigned(fOnFileProgress) Then
                fOnFileProgress(Self, fCurrentFile, 0, 0);
            fScannedFiles.Add(FileName);
            If Assigned(fOnLogStatement) Then
                fOnLogStatement(Self, Format('[parser   ]: Done in %2.3f seconds.', [myGetSecsSickTick(sTime)]));
        Except
            If Assigned(fOnLogStatement) Then
                fOnLogStatement(Self, Format('[parser   ]: Error scanning file %s', [FileName]));
        End;
    Finally
    // remove last comma
        With PIncludesRec(fIncludesList[fIncludesList.Count - 1])^ Do
  	         Delete(IncludeFiles, Length(IncludeFiles), 1);
        fSkipList.Clear;
        fCurrentClassLevel.Clear;
        FCurrentClass.Clear;
        FreeAndNil(fSkipList);
        FreeAndNil(fCurrentClassLevel);
        FreeAndNil(FCurrentClass);
        If (Not ManualUpdate) And Assigned(fOnEndParsing) Then
            fOnEndParsing(Self);
    End;
    fIsProjectFile := False;
    If Not ManualUpdate Then
        If Assigned(fOnUpdate) Then
            fOnUpdate(Self);
End;

Procedure TCppParser.Reset(KeepLoaded: Boolean = True);
Var
    I: Integer;
    I1: Integer;
    s: PStatement;
    p: Pointer;
Begin
    If Assigned(fOnBusy) Then
        fOnBusy(Self);
    ClearOutstandingTypedefs;
    fFilesToScan.Clear;
    If Assigned(fTokenizer) Then
        fTokenizer.Reset;

    If Assigned(fOnStartParsing) Then
        fOnStartParsing(Self);

    If KeepLoaded Then
        I := fBaseIndex
    Else
        I := 0;
    While I < fStatementList.Count Do

    Begin
        s := PStatement(fStatementList[I]);
        If Not KeepLoaded Or (KeepLoaded And Not s^._Loaded) Then
        Begin
            I1 := fScannedFiles.IndexOf(s^._Filename);
            If I1 = -1 Then
                I1 := fScannedFiles.IndexOf(s^._DeclImplFileName);
            If I1 <> -1 Then
                fScannedFiles.Delete(I1);
            I1 := fCacheContents.IndexOf(s^._Filename);
            If I1 = -1 Then
                I1 := fCacheContents.IndexOf(s^._DeclImplFileName);
            If I1 <> -1 Then
                fCacheContents.Delete(I1);
            Dispose(s);
            fStatementList.Delete(I);
        End
        Else
            Inc(I);
    End;
    fStatementList.Pack;

    If Not KeepLoaded Then
    Begin
        While fIncludesList.Count > 0 Do
        Begin
            p := fIncludesList[fIncludesList.Count - 1];
            If p <> Nil Then
                Dispose(PIncludesRec(p));
            fIncludesList.Delete(fIncludesList.Count - 1);
        End;
        fNextID := 0;
        fBaseIndex := 0;
    End;

    fProjectFiles.Clear;

    If Assigned(fOnEndParsing) Then
        fOnEndParsing(Self);

    If Assigned(fOnUpdate) Then
        fOnUpdate(Self);
End;

Procedure TCppParser.Parse(FileName: TFileName);
Var
    sTime: myTickCount;
    IsVisible: Boolean;
    bLocal: Boolean;
    bGlobal: Boolean;
Begin
    If Not fEnabled Then
        Exit;
    If Filename = '' Then
        Exit;
    If Assigned(fOnLogStatement) Then
        fOnLogStatement(Self, '[parser   ]: Starting.');
    AddFileToScan(FileName);
    bLocal := ParseLocalHeaders;
    bGlobal := ParseGlobalHeaders;
    ParseLocalHeaders := False;
    ParseGlobalHeaders := False;
    sTime := myGetTickCount;
    If Assigned(fOnStartParsing) Then
        fOnStartParsing(Self);
    Try
        While fFilesToScan.Count > 0 Do
        Begin
            If Assigned(fOnTotalProgress) Then
                fOnTotalProgress(Self, fFilesToScan[0], fFilesToScan.Count, 1);
            IsVisible := Not IsGlobalFile(fFilesToScan[0]);
            Parse(fFilesToScan[0], IsVisible, True);
            fFilesToScan.Delete(0);
        End;
    Finally
        If Assigned(fOnEndParsing) Then
            fOnEndParsing(Self);
    End;
    fStatementList.Pack;
    ParseLocalHeaders := bLocal;
    ParseGlobalHeaders := bGlobal;
    If Assigned(fOnTotalProgress) Then
        fOnTotalProgress(Self, '', 0, 0);
    If Assigned(fOnLogStatement) Then
        fOnLogStatement(Self, Format('[parser   ]: Total parsing done in %2.3f seconds.', [myGetSecsSickTick(sTime)]));
    If Assigned(fOnUpdate) Then
        fOnUpdate(Self);
End;

Procedure TCppParser.ParseList;
Var
    sTime: myTickCount;
    IsVisible: Boolean;

Begin
    If Not fEnabled Then
        Exit;
    If Assigned(fOnBusy) Then
        fOnBusy(Self);
    If Assigned(fOnLogStatement) Then
        fOnLogStatement(Self, '[parser   ]: Starting.');
    sTime := myGetTickCount;
    If Assigned(fOnStartParsing) Then
        fOnStartParsing(Self);
    Try
        While fFilesToScan.Count > 0 Do
        Begin
            If Assigned(fOnTotalProgress) Then
                fOnTotalProgress(Self, fFilesToScan[0], fFilesToScan.Count, 1);
            If fScannedFiles.IndexOf(fFilesToScan[0]) = -1 Then
            Begin
                IsVisible := Not IsGlobalFile(fFilesToScan[0]);
                Parse(fFilesToScan[0], IsVisible, True, False);
            End;
            fFilesToScan.Delete(0);
        End;
        PostProcessInheritance;
    Finally
        If Assigned(fOnEndParsing) Then
            fOnEndParsing(Self);
    End;
    fStatementList.Pack;
    If Assigned(fOnTotalProgress) Then
        fOnTotalProgress(Self, '', 0, 0);
    If Assigned(fOnLogStatement) Then
        fOnLogStatement(Self, Format('[parser   ]: Total parsing done in %2.3f seconds.', [myGetSecsSickTick(sTime)]));
    If Assigned(fOnUpdate) Then
        fOnUpdate(Self);
End;

Function TCppParser.GetFullFilename(Value: String): String;
Var
    I: Integer;
    tmp: String;
Begin
    Result := '';
    tmp := ExtractFilePath(fCurrentFile);
    If FileExists(tmp + Value) Then // same dir with file
        Result := tmp + Value
    Else
    If FileExists(fProjectDir + Value) Then //search in project dir
        Result := fProjectDir + Value
    Else
    Begin //search in included dirs
        For I := 0 To fIncludePaths.Count - 1 Do
            If FileExists(fIncludePaths[I] + '\' + Value) Then
            Begin
                Result := fIncludePaths[I] + '\' + Value;
                Break;
            End;
        For I := 0 To fProjectIncludePaths.Count - 1 Do
            If FileExists(fProjectIncludePaths[I] + '\' + Value) Then
            Begin
                Result := fProjectIncludePaths[I] + '\' + Value;
                Break;
            End;
    End;
    If Result = '' Then // not found...
        Result := Value;

    If Result = '' Then
    Begin
        If Assigned(fOnLogStatement) Then
            fOnLogStatement(Self, '[parser   ]: ' + Format('File %s not found...', [Value]));
        Result := Value;
    End;
    Result := StringReplace(Result, '/', '\', [rfReplaceAll]);
End;

Function TCppParser.IsCfile(Filename: String): Boolean;
Var
    ext: String;
Begin
    ext := LowerCase(ExtractFileExt(Filename));
    Result := (ext = '.cpp') Or (ext = '.c') Or (ext = '.cc');
End;

Function TCppParser.IsHfile(Filename: String): Boolean;
Var
    ext: String;
Begin
    ext := LowerCase(ExtractFileExt(Filename));
    Result := (ext = '.h') Or (ext = '.hpp') Or (ext = '.hh') Or (ext = '');
End;

Procedure TCppParser.GetSourcePair(FName: String; Var CFile, HFile: String);
Begin
    If IsCfile(FName) Then
    Begin
        CFile := FName;
        If FileExists(ChangeFileExt(FName, '.h')) Then
            HFile := ChangeFileExt(FName, '.h')
        Else
        If FileExists(ChangeFileExt(FName, '.hpp')) Then
            HFile := ChangeFileExt(FName, '.hpp')
        Else
        If FileExists(ChangeFileExt(FName, '.hh')) Then
            HFile := ChangeFileExt(FName, '.hh')
        Else
            HFile := '';
    End
    Else
    If IsHfile(FName) Then
    Begin
        HFile := FName;
        If FileExists(ChangeFileExt(FName, '.c')) Then
            CFile := ChangeFileExt(FName, '.c')
        Else
        If FileExists(ChangeFileExt(FName, '.cpp')) Then
            CFile := ChangeFileExt(FName, '.cpp')
        Else
        If FileExists(ChangeFileExt(FName, '.cc')) Then
            CFile := ChangeFileExt(FName, '.cc')
        Else
            CFile := '';
    End
    Else
    Begin
        CFile := FName;
        HFile := '';
    End;
End;

Procedure TCppParser.AddFileToScan(Value: String; InProject: Boolean);
Var
    FName: String;
    CFile, HFile: String;
Begin
    FName := StringReplace(Value, '/', '\', [rfReplaceAll]);
    FName := GetFullFilename(LowerCase(FName));

    If InProject Then
        fProjectFiles.Add(FName);

  // automatically add header and impl file
    CFile := '';
    HFile := '';
    If IsCfile(FName) Then
        GetSourcePair(FName, CFile, HFile)
    Else
    If IsHfile(FName) Then
        HFile := FName;

    If HFile <> '' Then
        If fFilesToScan.IndexOf(HFile) = -1 Then // check scheduled files
            If fScannedFiles.IndexOf(HFile) = -1 Then // check files already parsed
                fFilesToScan.Add(HFile);

    If CFile <> '' Then
        If fFilesToScan.IndexOf(CFile) = -1 Then // check scheduled files
            If fScannedFiles.IndexOf(CFile) = -1 Then // check files already parsed
                fFilesToScan.Add(CFile);
End;

Procedure TCppParser.AddIncludePath(Value: String);
Var
    S: String;
Begin
    S := AnsiDequotedStr(LowerCase(Value), '"');
    If fIncludePaths.IndexOf(S) = -1 Then
        fIncludePaths.Add(S);
End;

Procedure TCppParser.AddProjectIncludePath(Value: String);
Var
    S: String;
Begin
    S := AnsiDequotedStr(LowerCase(Value), '"');
    If fProjectIncludePaths.IndexOf(S) = -1 Then
        fProjectIncludePaths.Add(S);
End;

Procedure TCppParser.ClearIncludePaths;
Begin
    fIncludePaths.Clear;
End;

Procedure TCppParser.ClearProjectIncludePaths;
Begin
    fProjectIncludePaths.Clear;
End;

Function TCppParser.IsGlobalFile(Value: String): Boolean;
    Function GetShortName(Const FileName: String): String;
    Var
        pFileName: Array[0..12048] Of Char;
    Begin
        GetShortPathName(Pchar(FileName), pFileName, 12048);
        result := strpas(pFileName);
    End;
Var
    I: Integer;
Begin
    Result := False;
    For I := 0 To fIncludePaths.Count - 1 Do
    Begin
        If AnsiStartsStr(LowerCase(GetShortName(fIncludePaths[I])), LowerCase(GetShortName(ExtractFilePath(Value)))) Then
        Begin
            Result := True;
            Break;
        End;
    End;
End;

Procedure TCppParser.ReParseFile(FileName: TFileName; InProject: Boolean; OnlyIfNotParsed: Boolean; UpdateView: Boolean);
Var
    FName: String;
    CFile, HFile: String;
    IsVisible: Boolean;
    I: Integer;
Begin
    If Not fEnabled Then
        Exit;
    FName := LowerCase(FileName);
    If OnlyIfNotParsed And (fScannedFiles.IndexOf(FName) <> -1) Then
        Exit;
    If Assigned(fOnBusy) Then
        fOnBusy(Self);

    CFile := '';
    HFile := '';
    If IsCfile(FName) Then
        GetSourcePair(FName, CFile, HFile)
    Else
    If IsHfile(FName) Then
        HFile := FName;

    fInvalidatedIDs.Clear;
    InvalidateFile(CFile);
    InvalidateFile(HFile);
    If InProject Then
    Begin
        If (CFile <> '') And (fProjectFiles.IndexOf(CFile) = -1) Then
            fProjectFiles.Add(CFile);
        If (HFile <> '') And (fProjectFiles.IndexOf(HFile) = -1) Then
            fProjectFiles.Add(HFile);
    End
    Else
    Begin
        I := fProjectFiles.IndexOf(CFile);
        If I <> -1 Then
            fProjectFiles.Delete(I);
        I := fProjectFiles.IndexOf(HFile);
        If I <> -1 Then
            fProjectFiles.Delete(I);
    End;
    fFilesToScan.Clear;
    fReparsing := True;
    Parse(HFile, Not IsGlobalFile(HFile), True);
    Parse(CFile, Not IsGlobalFile(CFile), True);

    If Assigned(fOnStartParsing) Then
        fOnStartParsing(Self);
    Try
        I := 0;
        While I < fFilesToScan.Count Do
        Begin
            If Assigned(fOnTotalProgress) Then
                fOnTotalProgress(Self, fFilesToScan[I], fFilesToScan.Count, 1);
            If fScannedFiles.IndexOf(fFilesToScan[I]) = -1 Then
            Begin
                IsVisible := Not IsGlobalFile(fFilesToScan[I]);
                Parse(fFilesToScan[I], IsVisible, True);
                fFilesToScan.Delete(I);
            End
            Else
                Inc(I);
        End;
        ReProcessInheritance;
    Finally
        If Assigned(fOnEndParsing) Then
            fOnEndParsing(Self);
    End;

    fReparsing := False;
    If UpdateView Then
        If Assigned(fOnUpdate) Then
            fOnUpdate(Self);
End;

Procedure TCppParser.InvalidateFile(FileName: TFileName);
Var
    I: Integer;
    I1: Integer;
    P: PIncludesRec;
Begin
    If Filename = '' Then
        Exit;

  // POSSIBLE PROBLEM:
  // here we delete all the statements that belong to the specified file.
  // what happens with the statements that have _ParentID on one of these???
  // what happens with the statements that inherit from one of these???
  // POSSIBLE WORKAROUND 1: invalidate the other file too (don't like it much...)
    I := 0;
  // delete statements from file
    While I < fStatementList.Count Do
        If (AnsiCompareStr(PStatement(fStatementList[I])^._FileName, FileName) = 0) Or
            (AnsiCompareStr(PStatement(fStatementList[I])^._DeclImplFileName, FileName) = 0) Then
        Begin
            If PStatement(fStatementList[I])^._Kind = skClass Then // only classes have inheritance
                fInvalidatedIDs.Add(PStatement(fStatementList[I])^._ID);
            Dispose(PStatement(fStatementList[I]));
            fStatementList.Delete(I);
        End
        Else
            Inc(I);
    fStatementList.Pack;
  // delete it from scannedfiles
    I1 := fScannedFiles.IndexOf(FileName);
    If I1 <> -1 Then
        fScannedFiles.Delete(I1);
  // remove its include files list
    P := FindIncludeRec(FileName, True);
    If Assigned(P) Then
        Dispose(P);
End;

Procedure TCppParser.ScanAndSaveGlobals(FileName: TFileName);
Var
    I: Integer;
    SR: TSearchRec;
    Path: String;
Begin
    Reset;
    For I := 0 To fIncludePaths.Count - 1 Do
    Begin
        Path := StringReplace(fIncludePaths[I] + '\', '"', '', [rfReplaceAll]);
        If FindFirst(Path + '*.h', faAnyFile, SR) = 0 Then
        Begin
            Repeat
                AddFileToScan(Path + SR.Name);
            Until FindNext(SR) <> 0;
            FindClose(SR);
        End;
        If FindFirst(Path + '*.hpp', faAnyFile, SR) = 0 Then
        Begin
            Repeat
                AddFileToScan(Path + SR.Name);
            Until FindNext(SR) <> 0;
            FindClose(SR);
        End;
    End;
    ParseLocalHeaders := False;
    ParseGlobalHeaders := False;
    ParseList;
    Save(FileName);
End;

Procedure TCppParser.Save(FileName: TFileName);
Var
    hFile: Integer;
    I, I2, HowMany: Integer;
    MAGIC: Array[0..7] Of Char;
    P: Pchar;
    bufsize: Integer;
Begin
    MAGIC := 'CPPP 0.1';
    GetMem(P, 4096 + 1);
    bufsize := 4096;
    fCacheContents.Assign(fScannedFiles);
    If FileExists(FileName) Then
        DeleteFile(FileName);
    hFile := FileCreate(FileName);
    If hFile > 0 Then
    Begin
        FileWrite(hFile, MAGIC, SizeOf(MAGIC));

    // write statements
        HowMany := fStatementList.Count - 1;
        FileWrite(hFile, HowMany, SizeOf(Integer));
        For I := 0 To fStatementList.Count - 1 Do
        Begin
            With PStatement(fStatementList[I])^ Do
            Begin
{
        if Length(_FullText) > 4095 then begin
          tmp := FileSeek(hFile, 0, 1);  // retrieve currrent pos
          FileSeek(hFile, SizeOf(Magic), 0); // seek to the number of statements
          HowMany := HowMany - 1;
          FileWrite(hFile, HowMany, SizeOf(Integer)); // write new number of statements
          FileSeek(hFile, tmp, 0); // seek to original offset
          Continue;
        end;
}
                FileWrite(hFile, _ID, SizeOf(Integer));
                FileWrite(hFile, _ParentID, SizeOf(Integer));
                FileWrite(hFile, _Kind, SizeOf(Byte));
                FileWrite(hFile, _Scope, SizeOf(Integer));
                FileWrite(hFile, _ClassScope, SizeOf(Integer));
                FileWrite(hFile, _IsDeclaration, SizeOf(Boolean));
                FileWrite(hFile, _DeclImplLine, SizeOf(Integer));
                FileWrite(hFile, _Line, SizeOf(Integer));
                I2 := Length(_FullText);
                FileWrite(hFile, I2, SizeOf(Integer));
                If I2 > bufsize Then
                Begin
                    ReallocMem(P, I2 + 1);
                    bufsize := I2;
                End;
                StrPCopy(P, _FullText);
                FileWrite(hFile, P^, I2);
                I2 := Length(_Type);
                FileWrite(hFile, I2, SizeOf(Integer));
                If I2 > bufsize Then
                Begin
                    ReallocMem(P, I2 + 1);
                    bufsize := I2;
                End;
                StrPCopy(P, _Type);
                FileWrite(hFile, P^, I2);
                I2 := Length(_Command);
                FileWrite(hFile, I2, SizeOf(Integer));
                If I2 > bufsize Then
                Begin
                    ReallocMem(P, I2 + 1);
                    bufsize := I2;
                End;
                StrPCopy(P, _Command);
                FileWrite(hFile, P^, I2);
                I2 := Length(_Args);
                FileWrite(hFile, I2, SizeOf(Integer));
                If I2 > bufsize Then
                Begin
                    ReallocMem(P, I2 + 1);
                    bufsize := I2;
                End;
                StrPCopy(P, _Args);
                FileWrite(hFile, P^, I2);
                I2 := Length(_ScopelessCmd);
                FileWrite(hFile, I2, SizeOf(Integer));
                If I2 > bufsize Then
                Begin
                    ReallocMem(P, I2 + 1);
                    bufsize := I2;
                End;
                StrPCopy(P, _ScopelessCmd);
                FileWrite(hFile, P^, I2);
                I2 := Length(_DeclImplFileName);
                FileWrite(hFile, I2, SizeOf(Integer));
                If I2 > bufsize Then
                Begin
                    ReallocMem(P, I2 + 1);
                    bufsize := I2;
                End;
                StrPCopy(P, _DeclImplFileName);
                FileWrite(hFile, P^, I2);
                I2 := Length(_FileName);
                FileWrite(hFile, I2, SizeOf(Integer));
                If I2 > bufsize Then
                Begin
                    ReallocMem(P, I2 + 1);
                    bufsize := I2;
                End;
                StrPCopy(P, _FileName);
                FileWrite(hFile, P^, I2);
                I2 := Length(_InheritsFromIDs);
                FileWrite(hFile, I2, SizeOf(Integer));
                If I2 > bufsize Then
                Begin
                    ReallocMem(P, I2 + 1);
                    bufsize := I2;
                End;
                StrPCopy(P, _InheritsFromIDs);
                FileWrite(hFile, P^, I2);
                I2 := Length(_InheritsFromClasses);
                FileWrite(hFile, I2, SizeOf(Integer));
                If I2 > bufsize Then
                Begin
                    ReallocMem(P, I2 + 1);
                    bufsize := I2;
                End;
                StrPCopy(P, _InheritsFromClasses);
                FileWrite(hFile, P^, I2);
            End;
        End;

    // write scanned files (cache contents)
        I := fScannedFiles.Count - 1;
        FileWrite(hFile, I, SizeOf(Integer));
        For I := 0 To fScannedFiles.Count - 1 Do
        Begin
            I2 := Length(fScannedFiles[I]);
            FileWrite(hFile, I2, SizeOf(Integer));
            If I2 > bufsize Then
            Begin
                ReallocMem(P, I2 + 1);
                bufsize := I2;
            End;
            StrPCopy(P, fScannedFiles[I]);
            FileWrite(hFile, P^, I2);
        End;

    // write file includes list for each file scanned
        I := fIncludesList.Count - 1;
        FileWrite(hFile, I, SizeOf(Integer));
        For I := 0 To fIncludesList.Count - 1 Do
        Begin
            With PIncludesRec(fIncludesList[I])^ Do
            Begin
                I2 := Length(BaseFile);
                FileWrite(hFile, I2, SizeOf(Integer));
                If I2 > bufsize Then
                Begin
                    ReallocMem(P, I2 + 1);
                    bufsize := I2;
                End;
                StrPCopy(P, BaseFile);
                FileWrite(hFile, P^, I2);
                I2 := Length(IncludeFiles);
                FileWrite(hFile, I2, SizeOf(Integer));
                If I2 > bufsize Then
                Begin
                    ReallocMem(P, I2 + 1);
                    bufsize := I2;
                End;
                StrPCopy(P, IncludeFiles);
                FileWrite(hFile, P^, I2);
            End;
        End;
        FileClose(hFile);
    End;
    fBaseIndex := fNextID;
    FreeMem(P, bufsize + 1);
End;

Procedure TCppParser.Load(FileName: TFileName);
Var
    hFile: Integer;
    HowMany: Integer;
    I, I2: Integer;
    MAGIC: Array[0..7] Of Char;
    Statement: PStatement;
    Buf: Pchar;
    bufsize: Integer;
    ID_offset, ID_last: Integer;
    P: PIncludesRec;
Begin
    GetMem(Buf, 4096 + 1);
    bufsize := 4096;
    Reset;
    ID_Offset := fNextID;
    ID_Last := ID_Offset;
    hFile := FileOpen(FileName, fmOpenRead);
    If hFile > 0 Then
    Begin
        FileRead(hFile, MAGIC, SizeOf(MAGIC));
        If MAGIC = 'CPPP 0.1' Then
        Begin
      // read statements
            FileRead(hFile, HowMany, SizeOf(Integer));
            For I := 0 To HowMany Do
            Begin
                Statement := New(PStatement);
                With Statement^ Do
                Begin
                    FileRead(hFile, _ID, SizeOf(Integer));
                    FileRead(hFile, _ParentID, SizeOf(Integer));
                    FileRead(hFile, _Kind, SizeOf(Byte));
                    FileRead(hFile, _Scope, SizeOf(Integer));
                    FileRead(hFile, _ClassScope, SizeOf(Integer));
                    FileRead(hFile, _IsDeclaration, SizeOf(Boolean));
                    FileRead(hFile, _DeclImplLine, SizeOf(Integer));
                    FileRead(hFile, _Line, SizeOf(Integer));

                    FileRead(hFile, I2, SizeOf(Integer));
                    If I2 > bufsize Then
                    Begin
                        ReallocMem(Buf, I2 + 1);
                        bufsize := I2;
                    End;
                    FileRead(hFile, Buf^, I2);
                    FillChar((Buf + I2)^, 1, 0);
                    _FullText := Buf;
                    FileRead(hFile, I2, SizeOf(Integer));
                    If I2 > bufsize Then
                    Begin
                        ReallocMem(Buf, I2 + 1);
                        bufsize := I2;
                    End;
                    FileRead(hFile, Buf^, I2);
                    FillChar((Buf + I2)^, 1, 0);
                    _Type := Buf;
                    FileRead(hFile, I2, SizeOf(Integer));
                    If I2 > bufsize Then
                    Begin
                        ReallocMem(Buf, I2 + 1);
                        bufsize := I2;
                    End;
                    FileRead(hFile, Buf^, I2);
                    FillChar((Buf + I2)^, 1, 0);
                    _Command := Buf;
                    FileRead(hFile, I2, SizeOf(Integer));
                    If I2 > bufsize Then
                    Begin
                        ReallocMem(Buf, I2 + 1);
                        bufsize := I2;
                    End;
                    FileRead(hFile, Buf^, I2);
                    FillChar((Buf + I2)^, 1, 0);
                    _Args := Buf;
                    FileRead(hFile, I2, SizeOf(Integer));
                    If I2 > bufsize Then
                    Begin
                        ReallocMem(Buf, I2 + 1);
                        bufsize := I2;
                    End;
                    FileRead(hFile, Buf^, I2);
                    FillChar((Buf + I2)^, 1, 0);
                    _ScopelessCmd := Buf;
                    FileRead(hFile, I2, SizeOf(Integer));
                    If I2 > bufsize Then
                    Begin
                        ReallocMem(Buf, I2 + 1);
                        bufsize := I2;
                    End;
                    FileRead(hFile, Buf^, I2);
                    FillChar((Buf + I2)^, 1, 0);
                    _DeclImplFileName := Buf;
                    FileRead(hFile, I2, SizeOf(Integer));
                    If I2 > bufsize Then
                    Begin
                        ReallocMem(Buf, I2 + 1);
                        bufsize := I2;
                    End;
                    FileRead(hFile, Buf^, I2);
                    FillChar((Buf + I2)^, 1, 0);
                    _FileName := Buf;
                    FileRead(hFile, I2, SizeOf(Integer));
                    If I2 > bufsize Then
                    Begin
                        ReallocMem(Buf, I2 + 1);
                        bufsize := I2;
                    End;
                    FileRead(hFile, Buf^, I2);
                    FillChar((Buf + I2)^, 1, 0);
                    _InheritsFromIDs := Buf;
                    FileRead(hFile, I2, SizeOf(Integer));
                    If I2 > bufsize Then
                    Begin
                        ReallocMem(Buf, I2 + 1);
                        bufsize := I2;
                    End;
                    FileRead(hFile, Buf^, I2);
                    FillChar((Buf + I2)^, 1, 0);
                    _InheritsFromClasses := Buf;
                    _Loaded := True;
                    _NoCompletion := False;
                    _Temporary := False;
                    _Visible := False;
                    _Valid := True;
                    _InProject := False;

          // adjust IDs
                    If _ID <> -1 Then
                    Begin
                        _ID := _ID + ID_Offset;
                        ID_Last := _ID;
                    End;
                    If _ParentID <> -1 Then
                        _ParentID := _ParentID + ID_Offset;

                    If Assigned(fOnCacheProgress) Then
                        fOnCacheProgress(Self, _Filename, HowMany, I);
                End;
                fStatementList.Add(Statement);
            End;

      // read scanned files - cache contents
            FileRead(hFile, HowMany, SizeOf(Integer));
            For I := 0 To HowMany Do
            Begin
                FileRead(hFile, I2, SizeOf(Integer));
                If I2 > bufsize Then
                Begin
                    ReallocMem(Buf, I2 + 1);
                    bufsize := I2;
                End;
                FileRead(hFile, Buf^, I2);
                FillChar((Buf + I2)^, 1, 0);
                If fScannedFiles.IndexOf(Buf) = -1 Then
                    fScannedFiles.Add(Buf);
                If fCacheContents.IndexOf(Buf) = -1 Then
                    fCacheContents.Add(Buf);
            End;

      // read includes info for each scanned file
            FileRead(hFile, HowMany, SizeOf(Integer));
            For I := 0 To HowMany Do
            Begin
                P := New(PIncludesRec);
                FileRead(hFile, I2, SizeOf(Integer));
                If I2 > bufsize Then
                Begin
                    ReallocMem(Buf, I2 + 1);
                    bufsize := I2;
                End;
                FileRead(hFile, Buf^, I2);
                FillChar((Buf + I2)^, 1, 0);
                P^.BaseFile := Buf;
                FileRead(hFile, I2, SizeOf(Integer));
                If I2 > bufsize Then
                Begin
                    ReallocMem(Buf, I2 + 1);
                    bufsize := I2;
                End;
                FileRead(hFile, Buf^, I2);
                FillChar((Buf + I2)^, 1, 0);
                P^.IncludeFiles := Buf;
                fIncludesList.Add(P);
            End;
        End;
        FileClose(hFile);
    End;
    fNextID := ID_Last + 1;
    fBaseIndex := fStatementList.Count;
    FreeMem(Buf, bufsize + 1);
    PostProcessInheritance;
End;

Procedure TCppParser.PostProcessInheritance;
Var
    C, I, I1, I2: Integer;
    sl: TStrings;
    S: String;
Begin
    sl := TStringList.Create;
    Try
        For I := fBaseIndex To fStatementList.Count - 1 Do
        Begin
            If PStatement(fStatementList[I])^._Kind = skClass Then
                If PStatement(fStatementList[I])^._InheritsFromClasses <> '' Then
                Begin
                    sl.CommaText := PStatement(fStatementList[I])^._InheritsFromClasses;
                    S := '';
                    C := 0;
                    For I1 := 0 To fStatementList.Count - 1 Do
                        For I2 := 0 To sl.Count - 1 Do
                            If PStatement(fStatementList[I1])^._Kind = skClass Then
                                If AnsiCompareText(sl[I2], PStatement(fStatementList[I1])^._ScopelessCmd) = 0 Then
                                Begin
                                    S := S + IntToStr(PStatement(fStatementList[I1])^._ID) + ',';
                                    Inc(C, 1);
                                    If C = sl.Count Then // found all classes?
                                        Break;
                                End;
                    If C = sl.Count Then
                    Begin // found all classes?
                        PStatement(fStatementList[I])^._InheritsFromClasses := '';
                        If S <> '' Then
                            S := Copy(S, 1, Length(S) - 1); // cut-off ending ','
                        PStatement(fStatementList[I])^._InheritsFromIDs := S;
                    End;
                End;
        End;
    Finally
        sl.Free;
    End;
End;

Procedure TCppParser.ReProcessInheritance;
Var
    I, I1: Integer;
    sl: TStringList;
Begin
  // after reparsing a file, we have to reprocess inheritance,
  // because by invalidating the file, we might have deleted
  // some IDs that were inherited by other, valid, statements.
  // we need to re-adjust the IDs now...
    If fInvalidatedIDs.Count = 0 Then
        Exit;
    sl := TStringList.Create;
    Try
        sl.Sorted := True;
        sl.Duplicates := dupIgnore;
        For I := fBaseIndex To fStatementList.Count - 1 Do
            For I1 := 0 To fInvalidatedIDs.Count - 1 Do
                If Pos(IntToStr(fInvalidatedIDs[I1]), PStatement(Statements[I])^._InheritsFromIDs) > 0 Then
                    sl.Add(PStatement(Statements[I])^._FileName);
        For I := 0 To sl.Count - 1 Do
            ReParseFile(sl[I], fProjectFiles.IndexOf(sl[I]) <> -1, False, False);
    Finally
        sl.Free;
    End;
End;

Function TCppParser.SuggestMemberInsertionLine(ParentID: Integer;
    Scope: TStatementClassScope; Var AddScopeStr: Boolean): Integer;
Var
    I: Integer;
    maxInScope: Integer;
    maxInGeneral: Integer;
Begin
  // this function searches in the statements list for statements with
  // a specific _ParentID, and returns the suggested line in file for insertion
  // of a new var/method of the specified class scope. The good thing is that
  // if there is no var/method by that scope, it still returns the suggested
  // line for insertion (the last line in the class).
    maxInScope := -1;
    maxInGeneral := -1;
    For I := 0 To Statements.Count - 1 Do
        If PStatement(Statements[I])^._ParentID = ParentID Then
        Begin
            If PStatement(Statements[I])^._IsDeclaration Then
            Begin
                If PStatement(Statements[I])^._Line > maxInGeneral Then
                    maxInGeneral := PStatement(Statements[I])^._Line;
                If PStatement(Statements[I])^._ClassScope = scope Then
                    If PStatement(Statements[I])^._Line > maxInScope Then
                        maxInScope := PStatement(Statements[I])^._Line;
            End
            Else
            Begin
                If PStatement(Statements[I])^._DeclImplLine > maxInGeneral Then
                    maxInGeneral := PStatement(Statements[I])^._Line;
                If PStatement(Statements[I])^._ClassScope = scope Then
                    If PStatement(Statements[I])^._DeclImplLine > maxInScope Then
                        maxInScope := PStatement(Statements[I])^._DeclImplLine;
            End;
        End;
    If maxInScope = -1 Then
    Begin
        AddScopeStr := True;
        Result := maxInGeneral;
    End
    Else
    Begin
        AddScopeStr := False;
        Result := maxInScope;
    End;
End;

Function TCppParser.GetDeclarationFileName(Statement: PStatement): String;
Begin
    If Statement^._IsDeclaration Then
        Result := Statement^._FileName
    Else
        Result := Statement^._DeclImplFileName;
End;

Function TCppParser.GetDeclarationLine(Statement: PStatement): Integer;
Begin
    If Statement^._IsDeclaration Then
        Result := Statement^._Line
    Else
        Result := Statement^._DeclImplLine;
End;

Function TCppParser.GetImplementationFileName(
    Statement: PStatement): String;
Begin
    If Statement^._IsDeclaration Then
        Result := Statement^._DeclImplFileName
    Else
        Result := Statement^._FileName;
End;

Function TCppParser.GetImplementationLine(Statement: PStatement): Integer;
Begin
    If Statement^._IsDeclaration Then
        Result := Statement^._DeclImplLine
    Else
        Result := Statement^._Line;
End;

Procedure TCppParser.GetClassesList(Var List: TStrings);
Var
    I: Integer;
Begin
  // fills List with a list of all the known classes
    If Not Assigned(List) Then
        Exit;

    List.Clear;
    For I := 0 To Statements.Count - 1 Do
        If PStatement(Statements[I])^._Kind = skClass Then
            List.AddObject(PStatement(Statements[I])^._Command, Pointer(Statements[I]));
End;

Function TCppParser.IndexOfStatement(ID: Integer): Integer;
Var
    I: Integer;
Begin
    Result := -1;
    For I := 0 To Statements.Count - 1 Do
        If PStatement(Statements[I])^._ID = ID Then
        Begin
            Result := I;
            Break;
        End;
End;

Function TCppParser.Locate(Full: String; WithScope: Boolean): PStatement;
Var
    I: Integer;
Begin
    Result := Nil;
    For I := 0 To fStatementList.Count - 1 Do
    Begin
        If WithScope Then
        Begin
            If AnsiCompareStr(Full, PStatement(fStatementList[I])^._ScopeCmd) = 0 Then
            Begin
                Result := PStatement(fStatementList[I]);
                Break;
            End;
        End
        Else
        Begin
            If AnsiCompareStr(Full, PStatement(fStatementList[I])^._Command) = 0 Then
            Begin
                Result := PStatement(fStatementList[I]);
                Break;
            End;
        End;
    End;
End;

Function TCppParser.FillListOf(Full: String; WithScope: Boolean; List: TList): Boolean;
Var
    I: Integer;
Begin
    Result := False;
    If Not Assigned(List) Then
        Exit;
    List.Clear;
    If Full = '' Then
    Begin
        List.Assign(fStatementList);
        Result := True;
        Exit;
    End;
    For I := 0 To fStatementList.Count - 1 Do
    Begin
        If WithScope Then
        Begin
            If AnsiCompareStr(Full, PStatement(fStatementList[I])^._ScopeCmd) = 0 Then
            Begin
                Result := True;
                List.Add(PStatement(fStatementList[I]));
            End;
        End
        Else
        Begin
            If AnsiCompareStr(Full, PStatement(fStatementList[I])^._Command) = 0 Then
            Begin
                Result := True;
                List.Add(PStatement(fStatementList[I]));
            End;
        End;
    End;
End;

Function TCppParser.FindAndScanBlockAt(Filename: String; Row: Integer; Stream: TStream): Integer;
    Function GetFuncStartLine(Const Index, StartLine: Integer): Integer;
    Var
        idx: Integer;
    Begin
        idx := Index;
        Result := Index;
        While idx < fTokenizer.Tokens.Count Do
        Begin
            If PToken(fTokenizer.Tokens[idx])^.Line = StartLine Then
            Begin
                While (idx < fTokenizer.Tokens.Count) And (PToken(fTokenizer.Tokens[idx])^.Text[1] <> '{') Do
                    Inc(idx);
                If (idx < fTokenizer.Tokens.Count) And (PToken(fTokenizer.Tokens[idx])^.Text[1] = '{') Then
                Begin
                    Result := idx; // + 1;
                    Break;
                End;
            End;
            Inc(idx);
        End;
    End;
    Function GetFuncEndLine(Const Index: Integer): Integer;
    Var
        iLevel: Integer;
        idx: Integer;
    Begin
        idx := Index;
        iLevel := 0; // when this goes negative, we 're there (we have skipped the opening brace already)
        While (idx < fTokenizer.Tokens.Count) And (iLevel >= 0) Do
        Begin
            If PToken(fTokenizer.Tokens[idx])^.Text[1] = '{' Then
                Inc(iLevel)
            Else
            If PToken(fTokenizer.Tokens[idx])^.Text[1] = '}' Then
                Dec(iLevel);
            Inc(idx);
        End;
        Result := idx;
    End;
Var
    I: Integer;
    ClosestStatement: Integer;
    ClosestLine: Integer;
    Done: Boolean;
    loFilename: String;
    sExt: String;
Begin
  // finds the function in the specified filename that contains the line Row,
  // and parses it...
    DeleteTemporaries;
    Result := -1;
    ClosestLine := -1;
    ClosestStatement := -1;
    loFilename := LowerCase(Filename);
    For I := 0 {fBaseIndex} To fStatementList.Count - 1 Do
        If PStatement(fStatementList[I])^._Kind In [skFunction, skConstructor, skDestructor] Then
            If (AnsiCompareText(PStatement(fStatementList[I])^._FileName, loFilename) = 0) Then
            Begin
                If (PStatement(fStatementList[I])^._Line <= Row) And (PStatement(fStatementList[I])^._Line > ClosestLine) Then
                Begin
                    ClosestStatement := I;
                    ClosestLine := PStatement(fStatementList[I])^._Line;
                End;
            End
            Else
            If (AnsiCompareText(PStatement(fStatementList[I])^._DeclImplFileName, loFilename) = 0) Then
            Begin
                If (PStatement(fStatementList[I])^._DeclImplLine <= Row) And (PStatement(fStatementList[I])^._DeclImplLine > ClosestLine) Then
                Begin
                    ClosestStatement := I;
                    ClosestLine := PStatement(fStatementList[I])^._DeclImplLine;
                End;
            End;

    If (ClosestStatement <> -1) Then
    Begin
    // found!
        Result := IndexOfStatement(PStatement(fStatementList[ClosestStatement])^._ParentID);
        fTokenizer.Reset;
        If Assigned(Stream) Then
            fTokenizer.Tokenize(Stream)
        Else
            fTokenizer.Tokenize(Filename);
        fIndex := 0;
        fLevel := 0;
        Done := False;

    // find start of function and start from the opening brace
        fIndex := GetFuncStartLine(0, ClosestLine);
    // now find the end of the function and check that the Row is still in scope
        I := GetFuncEndLine(fIndex + 1);

    // if we 're past the end of function, we are not in the scope...
        If (Row > PToken(fTokenizer.Tokens[I - 1])^.Line) Or (Row < PToken(fTokenizer.Tokens[fIndex])^.Line) Then
        Begin
            ClosestLine := PStatement(fStatementList[ClosestStatement])^._DeclImplLine;
            fIndex := GetFuncStartLine(0, ClosestLine);
            I := GetFuncEndLine(fIndex + 1);
            If PToken(fTokenizer.Tokens[I - 1])^.Line < Row Then
            Begin
                Result := -1;
                Exit;
            End;
        End;

        fLaterScanning := True;
        fCurrentFile := loFileName;
        fLastID := -1;
        sExt := ExtractFileExt(loFileName);
        fIsHeader := (sExt = '.h') Or (sExt = '.hpp') Or (sExt = '.hh');
        fCurrentClass := TIntList.Create;
        fCurrentClassLevel := TIntList.Create;
        fSkipList := TIntList.Create;
        fLastStatementKind := skUnknown;
        Try
      // add the all-important "this" pointer as a local variable
            If Result <> -1 Then
                fThisPointerID := AddStatement(-1,
                    PStatement(fStatementList[ClosestStatement])^._ParentID, //Result,
                    Filename,
                    PStatement(fStatementList[Result])^._Command + '* this',
                    PStatement(fStatementList[Result])^._Command + '*',
                    'this',
                    '',
                    1,
                    skVariable,
                    ssClassLocal,
                    scsPrivate,
                    False,
                    True);
      // add the function's args
            ScanMethodArgs(PStatement(fStatementList[ClosestStatement])^._Args,
                True,
                Filename,
                PStatement(fStatementList[ClosestStatement])^._Line,
                PStatement(fStatementList[ClosestStatement])^._ParentID);
            Repeat
                If PToken(fTokenizer.Tokens[fIndex])^.Text[1] = '{' Then
                Begin
                    Inc(fLevel, 2);
                    Inc(fIndex);
                End
                Else
                If PToken(fTokenizer.Tokens[fIndex])^.Text = '}' Then
                Begin
                    Dec(fLevel, 2);
                    Inc(fIndex);
                    Done := fLevel < 0;
                End
                Else
                If CheckForPreprocessor Then
                Begin
                    HandlePreprocessor;
                End
                Else
                If CheckForKeyword Then
                Begin
                    HandleKeyword;
                End
                Else
                If CheckForEnum Then
                Begin
                    HandleEnum;
                End
                Else
                If CheckForVar Then
                Begin
                    HandleVar;
                End
                Else
                    Inc(fIndex);

                CheckForSkipStatement;

        // stop at cursor line - everything beyond it, is out of scope ;)
                Done := Done Or (fIndex >= fTokenizer.Tokens.Count) Or (PToken(fTokenizer.Tokens[fIndex])^.Line >= Row);
            Until Done;
        Finally
            fSkipList.Clear;
            fCurrentClassLevel.Clear;
            FCurrentClass.Clear;
            FreeAndNil(fSkipList);
            FreeAndNil(fCurrentClassLevel);
            FreeAndNil(FCurrentClass);
        End;
    End;
    fLaterScanning := False;
End;

Procedure TCppParser.DeleteTemporaries;
Var
    I: Integer;
Begin
    I := fBaseIndex;
    While I < fStatementList.Count Do
    Begin
        If PStatement(fStatementList[I])^._Temporary Then
        Begin
            Dispose(PStatement(fStatementList[I]));
            fStatementList.Delete(I);
        End
        Else
            Inc(I);
    End;
    fThisPointerID := -1;
End;

Function TCppParser.ScanMethodArgs(ArgStr: String; AddTemps: Boolean; Filename: String; Line, ClassID: Integer): String;
    Function GetWordAt(Str: String; Var Index: Integer; JustPeek: Boolean): String;
    Var
        IdxBkp: Integer;
    Begin
        Result := '';
        IdxBkp := Index;
        If Str = '' Then
            Exit;
        If Length(Str) < Index Then
            Exit;

    // first skip leading spaces
        While (Index <= Length(Str)) And (Str[Index] In [' ', #9, #10, #13]) Do
            Inc(Index);

    // now get the word at Index
        If (Index <= Length(Str)) And (Str[Index] In ['&', '*']) Then
        Begin
            While (Index <= Length(Str)) And (Str[Index] In ['&', '*']) Do
            Begin
                Result := Result + Str[Index];
                Inc(Index);
            End;
        End
        Else
        Begin
            While (Index <= Length(Str)) And Not (Str[Index] In [' ', #9, #10, #13]) Do
            Begin
                Result := Result + Str[Index];
                Inc(Index);
            End;
        End;
        If JustPeek Then
            Index := IdxBkp;
    End;

    Function IsKnown(Str: String): Boolean;
    Begin
    // standard C types
        Result := (AnsiCompareStr(Str, '*') = 0) Or
            (AnsiCompareStr(Str, '&') = 0) Or
            (AnsiCompareStr(Str, 'int') = 0) Or
            (AnsiCompareStr(Str, 'bool') = 0) Or
            (AnsiCompareStr(Str, 'char') = 0) Or
            (AnsiCompareStr(Str, 'uint') = 0) Or
            (AnsiCompareStr(Str, 'uint8') = 0) Or
            (AnsiCompareStr(Str, 'uint16') = 0) Or
            (AnsiCompareStr(Str, 'uint32') = 0) Or
            (AnsiCompareStr(Str, '...') = 0) Or
            (AnsiCompareStr(Str, 'const') = 0) Or
            (AnsiCompareStr(Str, 'static') = 0);
    End;

    Procedure AddSt(_Type, _Ident: String);
    Begin
        AddStatement(-1,
            ClassID,
            Filename,
            _Type + ' ' + _Ident,
            _Type,
            _Ident,
            '',
            Line,
            skVariable,
            ssClassLocal,
            scsPrivate,
            False,
            True);
    End;
Var
    idx: Integer;
    tmpStr: String;
    S: String;
    LastType: String;
Begin
  // ArgStr contains the method args enclosed in parenthesis.
  // What we 'll do here is remove the vars from the args.
  // e.g. (char * tmp, int x) will be (char *, int)
  // what's important and will help us here is this rule:
  // because we don't know the type of the var and it may consist
  // of one, two or more words, we 'll strip out the last word
  // before a ',' or ')'. The identifier is only one word ;)
  // The tough part is that we don't know if this is a declaration
  // or an implementation, so we might encounter a function call
  // inside the ArgStr. But this will be taken care of in GetWordAt.
    Result := ArgStr;
    If (ArgStr = '') Or (ArgStr[1] <> '(') Or (ArgStr[Length(ArgStr)] <> ')') Then
        Exit;

    Result := '';
    LastType := '';
    tmpStr := Copy(ArgStr, 2, Length(ArgStr) - 1); // remove '('
    idx := 1;
    S := '';
    Repeat
        S := GetWordAt(tmpStr, idx, False);
        If S <> '' Then
        Begin
      // check if we got a ','
            If S[Length(S)] In [',', ')'] Then
            Begin
                If Length(S) > 1 Then
                Begin
                    If IsKnown(Copy(S, 1, Length(S) - 1)) Then
                        Result := Result + S + ' '
                    Else
                    Begin
                        Result := Trim(Result) + S[Length(S)] + ' '; // identifier
                        If AddTemps Then
                            AddSt(Trim(LastType), Copy(S, 1, Length(S) - 1));
                    End;
                End
                Else
                    Result := Trim(Result) + S + ' ';
                LastType := '';
            End
            Else
            If (GetWordAt(tmpStr, idx, True) = ',') Or
                (GetWordAt(tmpStr, idx, True) = ')') Or
                (GetWordAt(tmpStr, idx, True) = '') Then
            Begin // this peeks at the following word
        // this is the last word before the comma
        // we must check that it is not a known type
        // (don't forget: the declaration might *not* have identifiers in it)
                If IsKnown(S) Then
                    Result := Result + S + ' '
                Else
                If AddTemps Then // identifier
                    AddSt(Trim(LastType), S);
                LastType := '';
            End
            Else
            Begin
                Result := Result + S + ' ';
                LastType := LastType + S + ' ';
            End;
        End;
    Until S = '';
    Result := '(' + Trim(Result);
End;

Function TCppParser.FindIncludeRec(Filename: String; DeleteIt: Boolean): PIncludesRec;
Var
    I: Integer;
Begin
    Result := Nil;
    For I := 0 To fIncludesList.Count - 1 Do
        If PIncludesRec(fIncludesList[I])^.BaseFile = Filename Then
        Begin
            Result := PIncludesRec(fIncludesList[I]);
            If DeleteIt Then
                fIncludesList.Delete(I);
            Break;
        End;
End;

Function TCppParser.GetFileIncludes(Filename: String): String;
    Procedure RecursiveFind(Fname: String);
    Var
        I: Integer;
        P: PIncludesRec;
        sl: TStrings;
    Begin
        If Fname = '' Then
            Exit;
        fFileIncludes.Add(FName);
        P := FindIncludeRec(Fname);
        If Assigned(P) Then
        Begin
      // recursively search included files
            sl := TStringList.Create;
            Try
                sl.CommaText := P^.IncludeFiles;
                For I := 0 To sl.Count - 1 Do
                    If fFileIncludes.IndexOf(sl[I]) = -1 Then
                    Begin
                        fFileIncludes.Add(sl[I]);
                        RecursiveFind(sl[I]);
                    End;
            Finally
                sl.Free;
            End;
        End;
    End;
Begin
  // returns a ';' separated list of all included files in file Filename
    Result := '';
    fFileIncludes.Clear;
    fFileIncludes.Sorted := True;
    fFileIncludes.Duplicates := dupIgnore;

    RecursiveFind(LowerCase(Filename));
    Result := fFileIncludes.CommaText;
End;

Function TCppParser.GetThisPointerID: Integer;
Begin
    Result := fThisPointerID;
End;

End.
