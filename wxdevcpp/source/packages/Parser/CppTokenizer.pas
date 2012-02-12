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

Unit CppTokenizer;

Interface

Uses
{$IFDEF WIN32}
    Windows, Classes, SysUtils, StrUtils, ComCtrls;
{$ENDIF}
{$IFDEF LINUX}
  Classes, SysUtils, StrUtils, QComCtrls;
{$ENDIF}

Const
    LetterChars: Set Of Char = ['A'..'Z', 'a'..'z', '_', '*', '&', '~'];
    DigitChars: Set Of Char = ['0'..'9'];
    HexChars: Set Of Char = ['A'..'F', 'a'..'f', 'x', 'L'];
    SpaceChars: Set Of Char = [' ', #9];
    LineChars: Set Of Char = [#13, #10];

    MAX_TOKEN_SIZE = 32768;

Type
    TSetOfChars = Set Of Char;

    TLogTokenEvent = Procedure(Sender: TObject; Msg: String) Of Object;
    TProgressEvent = Procedure(Sender: TObject; FileName: String; Total, Current: Integer) Of Object;

    PToken = ^TToken;
    TToken = Record
        Text: String[255];
        Line: Integer;
    End;

    TCppTokenizer = Class(TComponent)
    Private
        pStart: Pchar;
        pCurrent: Pchar;
        pLineCount: Pchar;
        fEnd: Integer;
        fCurrLine: Integer;
        fTokenList: TList;
        fLogTokens: Boolean;
        fOnLogToken: TLogTokenEvent;
        fOnProgress: TProgressEvent;
        fTmpOutput: Pchar;
        Procedure AddToken(sText: String; iLine: Integer);
        Procedure CountLines;
        Procedure MatchChar(C: Char);
        Procedure SkipCStyleComment;
        Procedure SkipSplitLine;
        Procedure SkipToEOL;
        Procedure SkipToNextToken;
        Procedure SkipDoubleQuotes;
        Procedure SkipSingleQuote;
        Procedure SkipPair(cStart, cEnd: Char);
        Procedure SkipAssignment;
        Function GetNumber: String;
        Function GetWord(bSkipParenthesis: Boolean = False; bSkipArray: Boolean = False; bSkipBlock: Boolean = False): String;
        Function GetPreprocessor: String;
        Function GetArguments: String;
        Function IsWord: Boolean;
        Function IsNumber: Boolean;
        Function IsPreprocessor: Boolean;
        Function IsArguments: Boolean;
        Function GetNextToken(bSkipParenthesis: Boolean = False; bSkipArray: Boolean = False; bSkipBlock: Boolean = False): String;
        Function Simplify(Str: String): String;
        Procedure PostProcessToken(Var Str: String);
        Procedure Advance(bPerformChecks: Boolean = True);
        Function OpenFile(FileName: String): Boolean;
        Function OpenStream(Stream: TStream): Boolean;
        Procedure ReleaseFileMemory;
    Public
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Procedure Reset;
        Procedure Tokenize(StartAt: Pchar); Overload;
        Procedure Tokenize(FileName: TFilename); Overload;
        Procedure Tokenize(Stream: TStream); Overload;
    Published
        Property LogTokens: Boolean Read fLogTokens Write fLogTokens;
        Property OnLogToken: TLogTokenEvent Read fOnLogToken Write fOnLogToken;
        Property OnProgress: TProgressEvent Read fOnProgress Write fOnProgress;
        Property Tokens: TList Read fTokenList;
    End;

Implementation

Constructor TCppTokenizer.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);
    fTokenList := TList.Create;
    fLogTokens := False;
End;

Destructor TCppTokenizer.Destroy;
Begin
    Try
        Reset;
    Finally
        If Assigned(fTokenList) Then
            FreeAndNil(fTokenList)
        Else fTokenList := Nil;
    End;
    Inherited Destroy;
End;

Procedure TCppTokenizer.Reset;
Begin
    If fTokenList <> Nil Then
    Begin
        While fTokenList.Count > 0 Do
            If Assigned(PToken(fTokenList[fTokenList.Count - 1])) Then
            Begin
                Dispose(PToken(fTokenList[fTokenList.Count - 1]));
                fTokenList.Delete(fTokenList.Count - 1);
            End
            Else
                fTokenList.Delete(fTokenList.Count - 1);
        fTokenList.Clear;
    End;
End;

Function TCppTokenizer.OpenFile(FileName: String): Boolean;
Var
    hFile: Integer;
    iLength, iRead: Integer;
Begin
    Result := False;
    If FileExists(FileName) Then
    Begin
        hFile := FileOpen(FileName, fmOpenRead);
        If hFile > 0 Then
        Begin
            iLength := FileSeek(hFile, 0, 2);
            FileSeek(hFile, 0, 0);
            If iLength > 0 Then
            Begin
                GetMem(pStart, iLength + 1);
                iRead := FileRead(hFile, pStart^, iLength);
                (pStart + iLength)^ := #0;
                Result := iRead = iLength;
            End;
            FileClose(hFile);
            If Not Result Then
            Begin
                If fLogTokens Then
                    If Assigned(fOnLogToken) Then
                        fOnLogToken(Self, '[tokenizer]: Could not read file.');
            End;
        End
        Else
        Begin
            If fLogTokens Then
                If Assigned(fOnLogToken) Then
                    fOnLogToken(Self, '[tokenizer]: Could not open file.');
        End;
    End
    Else
    Begin
        If fLogTokens Then
            If Assigned(fOnLogToken) Then
                fOnLogToken(Self, '[tokenizer]: File not found.');
    End;
End;

Function TCppTokenizer.OpenStream(Stream: TStream): Boolean;
Begin
    Result := False;
    If Assigned(Stream) Then
    Begin
        Stream.Position := 0;
        GetMem(pStart, Stream.Size + 1);
        Stream.Read(pStart^, Stream.Size);
        (pStart + Stream.Size)^ := #0;
        Result := True;
    End
    Else
    Begin
        If fLogTokens Then
            If Assigned(fOnLogToken) Then
                fOnLogToken(Self, '[tokenizer]: Non-existent stream.');
    End;
End;

Procedure TCppTokenizer.AddToken(sText: String; iLine: Integer);
Var
    Token: PToken;
Begin
    Token := New(PToken);
    FillChar(Token^.Text, sizeof(Token^.Text), 0);
    Token^.Text := sText;
    Token^.Line := iLine;
    fTokenList.Add(Token);
End;

Procedure TCppTokenizer.CountLines;
Begin
    While (pLineCount^ <> #0) And (pLineCount < pCurrent) Do
    Begin
        If pLineCount^ = #10 Then
            Inc(fCurrLine, 1);
        Inc(pLineCount, 1);
    End;
End;

Procedure TCppTokenizer.MatchChar(C: Char);
Begin
    While Not (pCurrent^ In [C, #0]) Do
    Begin
        Inc(pCurrent);
    End;
    Inc(pCurrent);
End;

Procedure TCppTokenizer.SkipCStyleComment;
Begin
    Repeat
        Inc(pCurrent);
    Until (pCurrent^ = #0) Or ((pCurrent^ = '*') And ((pCurrent + 1)^ = '/'));
    If pCurrent^ <> #0 Then
        Inc(pCurrent, 2); //skip '*/'
End;

Procedure TCppTokenizer.SkipSplitLine;
Begin
    Inc(pCurrent); // skip '\'
    While pCurrent^ In LineChars Do // skip newline
        Inc(pCurrent);
End;

Procedure TCppTokenizer.SkipToEOL;
Var
    SplitLine: Boolean;
    Last: Char;
Begin
    Last := #0;
    While (Not (pCurrent^ In LineChars)) And (pCurrent^ <> #0) Do
    Begin
        If (pCurrent^ = '/') And ((pCurrent + 1)^ = '*') And (Last <> '/') Then
            SkipCStyleComment
        Else
        Begin
            Last := pCurrent^;
            Inc(pCurrent);
        End;
    End;

    SplitLine := ((pCurrent - 1)^ = '\') And (pCurrent^ In LineChars);

    While pCurrent^ In LineChars Do
        Inc(pCurrent);

    If SplitLine Then
        SkipToEOL; //recurse
End;

Procedure TCppTokenizer.SkipToNextToken;
Begin
    While pCurrent^ In SpaceChars + LineChars Do
        Advance;
End;

Procedure TCppTokenizer.SkipDoubleQuotes;
Begin
    Repeat
        Inc(pCurrent);
        If pCurrent^ = '\' Then
            Inc(pCurrent, 2); // skip escaped char
    Until pCurrent^ In ['"', #0];
End;

Procedure TCppTokenizer.SkipSingleQuote;
Begin
    Repeat
        Inc(pCurrent);
        If pCurrent^ = '\' Then
            Inc(pCurrent, 2); // skip escaped quote
    Until pCurrent^ In ['''', #0];
End;

Procedure TCppTokenizer.SkipPair(cStart, cEnd: Char); // e.g.: SkipPair('[', ']');
Begin
    Repeat
        Inc(pCurrent);
        If pCurrent^ = #0 Then
            Break;
        If pCurrent^ = cStart Then
            SkipPair(cStart, cEnd); //recurse
        If pCurrent^ = cEnd Then
            Break;
        Case pCurrent^ Of
            '"':
                If cStart <> '''' Then
                    SkipDoubleQuotes; // don't do it inside string!
            '''':
                SkipSingleQuote;
            '/':
                If (pCurrent + 1)^ = '/' Then
                    SkipToEOL
                Else
                If (pCurrent + 1)^ = '*' Then
                    SkipCStyleComment;
        End;
    Until (pCurrent^ = cEnd) Or (pCurrent^ = #0);
    Advance;
End;

Procedure TCppTokenizer.SkipAssignment;
Begin
    Repeat
        Inc(pCurrent);
        Case pCurrent^ Of
            '(':
                SkipPair('(', ')');
            '"':
                SkipDoubleQuotes;
            '''':
                SkipSingleQuote;
            '/':
                If (pCurrent + 1)^ = '/' Then
                    SkipToEOL
                Else
                If (pCurrent + 1)^ = '*' Then
                    SkipCStyleComment;
        End;
//    if pCurrent^ = '(' then
//      SkipPair('(', ')');
    Until pCurrent^ In [',', ';', ')', '{', '}', #0]; // + LineChars;
End;

Procedure TCppTokenizer.Advance(bPerformChecks: Boolean = True);
Begin
    Inc(pCurrent);
    If (pCurrent^ <> #0) And bPerformChecks Then
        Case pCurrent^ Of
            '''', '"':
            Begin
                Inc(pCurrent);
                MatchChar((pCurrent - 1)^);
            End;
//      '"': SkipDoubleQuotes;
//      '''': SkipSingleQuote;
            '/':
                Case (pCurrent + 1)^ Of
                    '*':
                        SkipCStyleComment;
                    '/':
                        SkipToEOL;
                End;
            '=':
                SkipAssignment;
            '&', '*', '!', '|', '+', '-':
                If (pCurrent + 1)^ = '=' Then
                    SkipAssignment;
            '\':
                If (pCurrent + 1)^ In LineChars Then
                    SkipSplitLine;
        End;
End;

Function TCppTokenizer.GetNumber: String;
Var
    Offset: Pchar;
Begin
    fTmpOutput^ := #0;
    Offset := pCurrent;

    If pCurrent^ In DigitChars Then
        While pCurrent^ In DigitChars + HexChars Do
            Advance;

    If Offset <> pCurrent Then
    Begin
        StrLCopy(fTmpOutput, Offset, pCurrent - Offset);
        If pCurrent^ = '.' Then // keep '.' for decimal
            StrLCat(StrEnd(fTmpOutput), pCurrent, 1);
        Result := StrPas(fTmpOutput);
    End
    Else
        Result := '';
End;

Function TCppTokenizer.GetWord(bSkipParenthesis: Boolean = False; bSkipArray: Boolean = False; bSkipBlock: Boolean = False): String;
Var
    Offset: Pchar;
    Backup: Pchar;
    tmp: Integer;
    Done: Boolean;
    AssignPos: Pchar;
    localOutput: Pchar;
Begin
    localOutput := StrAlloc(MAX_TOKEN_SIZE);
    localOutput^ := #0;
    SkipToNextToken;
    Offset := pCurrent;

    Repeat
        While pCurrent^ In LetterChars + DigitChars Do
            Advance;
    // check for operator functions (look below too)
        If (pCurrent - Offset >= 8) And (StrLComp('operator', Offset, pCurrent - Offset) = 0) Then
        Begin
            If pCurrent^ In ['+', '-', '/', '*', '['] Then
            Begin
                Inc(pCurrent);
                If pCurrent^ = '(' Then
                    SkipPair('(', ')');
            End;
            Advance;
            Done := False;
        End
        Else
            Done := True;
    Until Done;

  // check for '<<' or '>>' operator
    Backup := pCurrent;
    While Backup^ In SpaceChars Do
        Inc(Backup);
    If ((Backup^ = '<') And ((Backup + 1)^ = '<')) Or
        ((Backup^ = '>') And ((Backup + 1)^ = '>')) Then
    Begin
    //skip to ';'
        Repeat
            Inc(Backup);
        Until Backup^ In [';', #0];
        pCurrent := Backup;
    End

  // check for <xxx> values (templates, lists etc)
    Else
    If pCurrent^ = '<' Then
    Begin
        Backup := pCurrent;
        Repeat
            Inc(Backup);
        Until Backup^ In ['>', ';', '{', '}', '(', ')', '.', #0];
        If Backup^ = '>' Then // got it!
            pCurrent := Backup + 1;
    End;

    If Offset <> pCurrent Then
    Begin
        StrLCopy(localOutput, Offset, pCurrent - Offset);
    // check for operator functions (look above too)
    // we separate the args from the func name (only for operators - for other funcs it's done automatically)
        AssignPos := StrPos(localOutput, '(');
        If (AssignPos <> Nil) And (pCurrent - Offset >= 8) And (StrLComp('operator', Offset, 8) = 0) Then
        Begin
            AssignPos^ := #0;
            pCurrent := Offset + (AssignPos - localOutput);
            bSkipArray := False;
        End
    // if it contains assignment, remove it
        Else
        Begin
            AssignPos := StrPos(localOutput, '=');
            If AssignPos <> Nil Then
                AssignPos^ := #0;
        End;

    // we want it
        SkipToNextToken;
        If bSkipArray And (pCurrent^ = '[') Then
        Begin
            Repeat
                Offset := pCurrent;
                tmp := 1;
                Repeat
                    Repeat
                        Inc(pCurrent);
                        If pCurrent^ = '[' Then
                            Inc(tmp);
                    Until pCurrent^ In [#0, ']'] + LineChars;
                    Dec(tmp);
                Until tmp = 0;
                Inc(pCurrent);
//        SkipPair('[', ']');
                StrLCat(StrEnd(localOutput), Offset, pCurrent - Offset);
                SkipToNextToken;
            Until pCurrent^ <> '['; // maybe multi-dimension array
        End
        Else
        If bSkipBlock And (pCurrent^ = '{') Then
        Begin
            SkipPair('{', '}');
            SkipToNextToken;
        End;
        If pCurrent^ = '.' Then // keep '.' for class-members
            StrLCat(StrEnd(localOutput), pCurrent, 1)
        Else
        If (pCurrent^ = '-') And ((pCurrent + 1)^ = '>') Then
        Begin // keep '->' for members
            StrLCat(StrEnd(localOutput), pCurrent, 2);
            Inc(pCurrent, 2);
        End
        Else
        If (pCurrent^ = ':') And ((pCurrent + 1)^ = ':') Then
        Begin // keep '::'
            StrLCat(StrEnd(localOutput), pCurrent, 2);
            Inc(pCurrent, 2); // there are 2 ':'!
            StrCat(localOutput, Pchar(GetWord(bSkipParenthesis, bSkipArray, bSkipBlock)));
        End;
        Result := StrPas(localOutput);
    End
    Else
        Result := '';
    StrDispose(localOutput);
End;

Function TCppTokenizer.GetPreprocessor: String;
Var
    Offset: Pchar;
Begin
    Offset := pCurrent;
    SkipToEOL;
    fTmpOutput^ := #0;
    StrLCopy(fTmpOutput, Offset, pCurrent - Offset);
    Result := StrPas(fTmpOutput);
End;

Function TCppTokenizer.GetArguments: String;
Var
    Offset: Pchar;
Begin
    fTmpOutput^ := #0;
    Result := '';
    Offset := pCurrent;
    SkipPair('(', ')');
    If pCurrent - Offset > MAX_TOKEN_SIZE Then
        Exit;
    StrLCopy(fTmpOutput, Offset, pCurrent - Offset);
    If (pCurrent^ = '.') Or ((pCurrent^ = '-') And ((pCurrent + 1)^ = '>')) Then // skip '.' and '->'
        While Not (pCurrent^ In [#0, '(', ';', '{', '}', ')'] + LineChars + SpaceChars) Do
            Inc(pCurrent);
    SkipToNextToken;
    Result := StrPas(fTmpOutput);
End;

Function TCppTokenizer.IsWord: Boolean;
Begin
    Result := pCurrent^ In LetterChars;
End;

Function TCppTokenizer.IsNumber: Boolean;
Begin
    Result := pCurrent^ In DigitChars;
End;

Function TCppTokenizer.IsPreprocessor: Boolean;
Begin
    Result := pCurrent^ = '#';
End;

Function TCppTokenizer.IsArguments: Boolean;
Begin
    Result := pCurrent^ = '(';
End;

Function TCppTokenizer.GetNextToken(bSkipParenthesis: Boolean = False; bSkipArray: Boolean = False; bSkipBlock: Boolean = False): String;
Var
    Done: Boolean;
Begin
    Result := '';
    Done := False;
    Repeat
        SkipToNextToken;
        If pCurrent^ = #0 Then
            Break;
        If IsPreprocessor Then
        Begin
            CountLines;
            Result := GetPreprocessor;
            Done := Result <> '';
        End
        Else
        If IsArguments Then
        Begin
            CountLines;
            Result := GetArguments;
            Done := Result <> '';
        End
        Else
        If IsWord Then
        Begin
            CountLines;
            Result := GetWord(False, bSkipArray, bSkipBlock);
            Done := Result <> '';
        End
        Else
        If IsNumber Then
        Begin
            CountLines;
            Result := GetNumber;
            Done := Result <> '';
        End
        Else
        Begin
            Case pCurrent^ Of
                #0:
                    Done := True;
                '/':
                    Case (pCurrent + 1)^ Of
                        '*':
                            SkipCStyleComment;
                        '/':
                            SkipToEOL;
                    Else
                        Advance;
                    End;
                '{', '}', ';', ',', ':':
                Begin //just return the brace or the ';'
                    CountLines;
                    Result := pCurrent^;
                    Advance;
                    Done := True;
                End;
            Else
                Advance;
            End;
        End;
    Until Done;
End;

Function TCppTokenizer.Simplify(Str: String): String;
Var
    I: Integer;
    len: Integer;
Begin
    Result := Str;
    If Str = '' Then
        Exit;

    len := Length(Result);
    fTmpOutput^ := #0;
    I := 1;
    While I <= len Do
    Begin
    // simplify spaces
        If Result[I] In [' ', #9] Then
        Begin
      //Result's  Index is not checked before using it,
      //so it is causing problems when parsing some
      //header files
            While (I <= len) And (Result[I] In [' ', #9]) Do
                Inc(I);
            StrLCat(StrEnd(fTmpOutput), ' ', 1);
        End;
    // remove comments
        If (I < len) And (Result[I] = '/') Then
        Begin
            Case Result[I + 1] Of
                '*':
                Begin // C style
                    Repeat
                        Inc(I);
                    Until (I >= len - 1) Or ((Result[I] = '*') And (Result[I + 1] = '/'));
                    If Result[I] = '*' Then
                        Inc(I, 2);
                End;
                '/':
                Begin // C++ style
                    Repeat
                        Inc(I);
                    Until (I >= len - 1) Or ((Result[I] = '/') And (Result[I + 1] = '/'));
                    If Result[I] = '/' Then
                        Inc(I, 2);
                End;
            End;
        End;
        If I <= len Then
            If Not (Result[I] In [' ', #9]) Then
                StrLCat(StrEnd(fTmpOutput), @Result[I], 1);
        Inc(I);
    End;
    Result := StrPas(fTmpOutput);
End;

Procedure TCppTokenizer.PostProcessToken(Var Str: String);
Begin

    Str := StringReplace(Str, '\'#13, '', [rfReplaceAll]);
    Str := StringReplace(Str, '\'#10, '', [rfReplaceAll]);
    Str := StringReplace(Str, #13, '', [rfReplaceAll]);
    Str := StringReplace(Str, #10, '', [rfReplaceAll]);
    Str := Simplify(Str);
End;

Procedure TCppTokenizer.Tokenize(StartAt: Pchar);
Var
    S: String;
    LastToken: String;
    Command: String;
    bSkipBlocks: Boolean;
    I: Integer;
Begin
    If StartAt = Nil Then
        Exit;

    Reset;
    fTmpOutput := StrAlloc(MAX_TOKEN_SIZE);
    pStart := StartAt;
    fEnd := Length(StrPas(pStart));
    pCurrent := pStart;
    pLineCount := pStart;

    S := '';
    bSkipBlocks := False;
    Command := '';
    fCurrLine := 1;
    If Assigned(fOnProgress) Then
        fOnProgress(Self, '', fEnd, 0);
    Repeat
        LastToken := S;
        S := GetNextToken(True, True, bSkipBlocks);
        PostProcessToken(S);
        If S <> '' Then
            AddToken(S, fCurrLine);
        If Assigned(fOnProgress) Then
            fOnProgress(Self, '', fEnd, pCurrent - pStart);
    Until S = '';
    AddToken(#0, fCurrLine);
    If Assigned(fOnProgress) Then
        fOnProgress(Self, '', fEnd, 0);
    If fLogTokens Then
        If Assigned(fOnLogToken) Then
            For I := 0 To fTokenList.Count - 1 Do
                fOnLogToken(Self, Format('[tokenizer]: Idx: %4d Line: %4d Token: %s', [I, PToken(fTokenList[I])^.Line, PToken(fTokenList[I])^.Text]));
    StrDispose(fTmpOutput);
End;

Procedure TCppTokenizer.Tokenize(FileName: TFilename);
Begin
    If OpenFile(FileName) Then
        Tokenize(pStart);
    ReleaseFileMemory;
End;

Procedure TCppTokenizer.Tokenize(Stream: TStream);
Begin
    If OpenStream(Stream) Then
        Tokenize(pStart);
    ReleaseFileMemory;
End;

Procedure TCppTokenizer.ReleaseFileMemory;
Begin
    If pStart <> Nil Then
        FreeMem(pStart);
    pStart := Nil;
End;

End.
