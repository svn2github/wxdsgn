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
{

    History:
    
      23 May 2004 - Peter Schraut (peter_)
        * Fixed this issue in TCodeCompletion.Search: 
          https://sourceforge.net/tracker/index.php?func=detail&aid=935068&group_id=10639&atid=110639
    
}
Unit CodeCompletion;

Interface

Uses
{$IFDEF WIN32}
    Windows, Classes, Forms, SysUtils, Controls, Graphics, StrUtils, CppParser,
    ExtCtrls, U_IntList, Dialogs;
{$ENDIF}
{$IFDEF LINUX}
  Xlib, Classes, QForms, SysUtils, QControls, QGraphics, StrUtils, CppParser,
  QExtCtrls, U_IntList, QDialogs, Types;
{$ENDIF}

Type
  {** Modified by Peter **}
    TCompletionEvent = Procedure(Sender: TObject; Const AStatement: TStatement; Const AIndex: Integer) Of Object;

    TCodeCompletion = Class(TComponent)
    Private
        fParser: TCppParser;
        fFullCompletionStatementList: TList;
        fCompletionStatementList: TList;
        fMinWidth: Integer;
        fMinHeight: Integer;
        fMaxWidth: Integer;
        fMaxHeight: Integer;
        fPos: TPoint;
        fColor: TColor;
        fWidth: Integer;
        fHeight: Integer;
        fEnabled: Boolean;
        fHintWindow: THintWindow;
        fHintTimer: TTimer;
        fHintTimeout: Cardinal;
        fOnKeyPress: TKeyPressEvent;
        fOnResize: TNotifyEvent;
        fOnlyGlobals: Boolean;
        fCurrClassID: Integer;
        fIncludedFiles: TStringList;
        Function GetOnCompletion: TCompletionEvent; {** Modified by Peter **}
        Procedure SetOnCompletion(Value: TCompletionEvent); {** Modified by Peter **}
//    procedure GetTypeOfVar(_Value: string; var List, InhList: TIntList);
        Function GetTypeID(_Value: String; il: TIntList): Integer;
        Function ApplyStandardFilter(Index: Integer): Boolean;
        Function ApplyClassFilter(Index, ParentID: Integer; InheritanceIDs: TIntList): Boolean;
        Function ApplyMemberFilter(_Class: String; Index, CurrentID: Integer; ClassIDs, InheritanceIDs: TIntList): Boolean;
        Procedure GetCompletionFor(_Class, _Value: String; HasDot: Boolean = False);
//    procedure GetCompletionFor1(_Class, _Value: string; HasDot: boolean = False);
        Procedure FilterList(_Class, _Value: String; HasDot: Boolean = False);
        Function GetClass(Phrase: String): String;
        Function GetMember(Phrase: String): String;
        Function GetHasDot(Phrase: String): Boolean;
        Procedure SetParser(Value: TCppParser);
        Procedure SetPosition(Value: TPoint);
        Procedure SetHintTimeout(Value: Cardinal);
        Procedure HintTimer(Sender: TObject);
        Procedure ComplKeyPress(Sender: TObject; Var Key: Char);
        Procedure OnFormResize(Sender: TObject);
        Procedure SetColor(Value: TColor);
        Function IsIncluded(FileName: String): Boolean;
    Public
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Procedure Search(Sender: TWinControl; Phrase, Filename: String);
        Procedure Hide;
        Function SelectedStatement: PStatement;
        Function SelectedIsFunction: Boolean;
        Procedure ShowArgsHint(FuncName: String; Rect: TRect);
        Procedure ShowMsgHint(Rect: TRect; HintText: String);
    Published
        Property Parser: TCppParser Read fParser Write SetParser;
        Property Position: TPoint Read fPos Write SetPosition;
        Property Color: TColor Read fColor Write SetColor;
        Property Width: Integer Read fWidth Write fWidth;
        Property Height: Integer Read fHeight Write fHeight;
        Property Enabled: Boolean Read fEnabled Write fEnabled;
        Property HintTimeout: Cardinal Read fHintTimeout Write SetHintTimeout;
        Property MinWidth: Integer Read fMinWidth Write fMinWidth;
        Property MinHeight: Integer Read fMinHeight Write fMinHeight;
        Property MaxWidth: Integer Read fMaxWidth Write fMaxWidth;
        Property MaxHeight: Integer Read fMaxHeight Write fMaxHeight;
        Property OnCompletion: TCompletionEvent Read GetOnCompletion Write SetOnCompletion; {** Modified by Peter **}
        Property OnKeyPress: TKeyPressEvent Read fOnKeyPress Write fOnKeyPress;
        Property OnResize: TNotifyEvent Read fOnResize Write fOnResize;
        Property OnlyGlobals: Boolean Read fOnlyGlobals Write fOnlyGlobals;
        Property CurrentClass: Integer Read fCurrClassID Write fCurrClassID;
    End;

Implementation

Uses CodeCompletionForm;

{ TCodeCompletion }

Constructor TCodeCompletion.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);

    fHintWindow := THintWindow.Create(Self);
    fHintWindow.Color := clInfoBk;
    fHintTimer := TTimer.Create(Self);
    fHintTimeout := 4000;
    fHintTimer.Interval := fHintTimeout;
    fHintTimer.OnTimer := HintTimer;
    fHintTimer.Enabled := False;

    fIncludedFiles := TStringList.Create;
    fIncludedFiles.Sorted := True;
    fIncludedFiles.Duplicates := dupIgnore;
    fCompletionStatementList := TList.Create;
    fFullCompletionStatementList := TList.Create;
    CodeComplForm := TCodeComplForm.Create(Self);
    CodeComplForm.fParser := fParser;
    CodeComplForm.fCompletionStatementList := fCompletionStatementList;
    CodeComplForm.OnResize := OnFormResize;
    fWidth := 320;
    fHeight := 240;
    fMinWidth := 256;
    fMinHeight := 128;
    fMaxWidth := 0;//480;
    fMaxHeight := 0;//320;
    fColor := clWindow;
    fEnabled := True;
    fOnlyGlobals := False;
End;

Destructor TCodeCompletion.Destroy;
Begin
    If Assigned(CodeComplForm) Then
    Begin
     If CodeComplForm.HasParent Then
        CodeComplForm.Close
     Else
        FreeAndNil(CodeComplForm);
    End
    Else
        CodeComplForm := Nil;

    If Assigned(fCompletionStatementList) Then
        FreeAndNil(fCompletionStatementList)
    Else
        fCompletionStatementList := Nil;

    If Assigned(fFullCompletionStatementList) Then
        FreeAndNil(fFullCompletionStatementList)
    Else
        fFullCompletionStatementList := Nil;

    If Assigned(fHintWindow) Then
        FreeAndNil(fHintWindow)
    Else
        fHintWindow := Nil;

    If Assigned(fHintTimer) Then
        FreeAndNil(fHintTimer)
    Else
        fHintTimer := Nil;

    If Assigned(fIncludedFiles) Then
        FreeAndNil(fIncludedFiles)
    Else
        fIncludedFiles := Nil;

    Inherited Destroy;
End;

Function TCodeCompletion.GetClass(Phrase: String): String;
Var
    I: Integer;
Begin
    I := LastDelimiter('.', Phrase) - 1;
    If I = -1 Then
    Begin
        I := LastDelimiter('>', Phrase);
        If I > 1 Then
        Begin
            If Phrase[I - 1] <> '-' Then
                I := -1
            Else
                Dec(I, 2);
        End
        Else
        Begin
            I := LastDelimiter(':', Phrase);
            If I > 1 Then
            Begin
                If Phrase[I - 1] <> ':' Then
                    I := -1
                Else
                    Dec(I, 2);
            End
            Else
                I := -1;
        End;
    End;
    If I = -1 Then
    Begin
        Result := '';
        I := Length(Phrase);
        While (I > 0) And (Phrase[I] In ['A'..'Z', 'a'..'z', '_', '0'..'9']) Do
        Begin
            Result := Phrase[I] + Result;
            Dec(I);
        End;
    End
    Else
    Begin
        Result := '';
        While (I > 0) And (Phrase[I] In ['A'..'Z', 'a'..'z', '_', '0'..'9', '(', ')', '[', ']']) Do
        Begin
            If (Phrase[I] = '.') Or
                ((I > 1) And (Phrase[I] = '>') And (Phrase[I - 1] = '-')) Or
                ((I > 1) And (Phrase[I] = ':') And (Phrase[I - 1] = ':')) Then
                Break;
            Result := Phrase[I] + Result;
            Dec(I);
        End;
    // check if it is function; if yes, cut-off the arguments ;)
        If AnsiPos('(', Result) > 0 Then
            Result := Copy(Result, 1, AnsiPos('(', Result) - 1);
    // check if it is an array; if yes, cut-off the dimensions ;)
        If AnsiPos('[', Result) > 0 Then
            Result := Copy(Result, 1, AnsiPos('[', Result) - 1);
    End;
End;

Function TCodeCompletion.ApplyStandardFilter(Index: Integer): Boolean;
Begin
    Result := Not PStatement(fParser.Statements[Index])^._NoCompletion;
End;

Function TCodeCompletion.ApplyClassFilter(Index, ParentID: Integer; InheritanceIDs: TIntList): Boolean;
Begin
    Result :=
        (
        (PStatement(fParser.Statements[Index])^._Scope In [ssLocal, ssGlobal]) Or // local or global var or
        (
        (PStatement(fParser.Statements[Index])^._Scope = ssClassLocal) And // class var
        (
        (PStatement(fParser.Statements[Index])^._ParentID = ParentID) Or // from current class
        (
        (InheritanceIDs.IndexOf(PStatement(fParser.Statements[Index])^._ParentID) <> -1) And
        (PStatement(fParser.Statements[Index])^._ClassScope <> scsPrivate)
        ) // or an inheriting class
        )
        )
        ) And
        (IsIncluded(PStatement(fParser.Statements[Index])^._FileName) Or
        IsIncluded(PStatement(fParser.Statements[Index])^._DeclImplFileName));
End;

Function TCodeCompletion.ApplyMemberFilter(_Class: String; Index, CurrentID: Integer; ClassIDs, InheritanceIDs: TIntList): Boolean;
Var
    cs: Set Of TStatementClassScope;
Begin
    Result := PStatement(fParser.Statements[Index])^._ParentID <> -1; // only members
    If Not Result Then
        Exit;

  // all members of current class
    Result := Result And ((ClassIDs.IndexOf(CurrentID) <> -1) And (PStatement(fParser.Statements[Index])^._ParentID = CurrentID));

  // all public and published members of var's class
    Result := Result Or
        (
        (ClassIDs.IndexOf(PStatement(fParser.Statements[Index])^._ParentID) <> -1) And
        (Not (PStatement(fParser.Statements[Index])^._ClassScope In [scsProtected, scsPrivate])) // or member of an inherited class
        );

    If (CurrentID = -1) Or (PStatement(fParser.Statements[Index])^._ParentID = fCurrClassID) Then
        cs := [scsPrivate, scsProtected]
    Else
        cs := [scsPrivate];

  // all inherited class's non-private members
    Result := Result Or
        (
        (InheritanceIDs.IndexOf(PStatement(fParser.Statements[Index])^._ParentID) <> -1) And
        (Not (PStatement(fParser.Statements[Index])^._ClassScope In cs)) // or member of an inherited class
        );
End;

Procedure TCodeCompletion.GetCompletionFor(_Class, _Value: String; HasDot: Boolean = False);
Var
    I, I1: Integer;
    InheritanceIDs: TIntList;
    ClassIDs: TIntList;
    sl: TStringList;
    ParID: Integer;
    iID: Integer;
    pST: PStatement;
    CurrentID: Integer;
    bOnlyLocal: Boolean;
    Procedure GetInheritance(ClassIndex: Integer);
    Var
        I: Integer;
        isID: Integer;
        iST: Integer;
    Begin
        If ClassIndex <> -1 Then
        Begin
            ParID := ClassIndex;
            isID := ClassIndex;
            Repeat
                sl.CommaText := PStatement(fParser.Statements[isID])^._InheritsFromIDs;
                iST := -1;
                For I := 0 To sl.Count - 1 Do
                Begin
                    iST := -1;
                    iID := StrToIntDef(sl[I], -1);
                    If iID = -1 Then
                        Continue;
                    InheritanceIDs.Add(iID);
                    iST := iID;
                    If iST = -1 Then
                        Continue;
                    pST := PStatement(fParser.Statements[iST]);
                    fIncludedFiles.Add(pST^._Filename);
                    fIncludedFiles.Add(pST^._DeclImplFilename);
                End;
                isID := iST;
            Until isID = -1;
        End;
    End;
Begin
    bOnlyLocal := False;
    ClassIDs := TIntList.Create;
    InheritanceIDs := TIntList.Create;
    sl := TStringList.Create;
    Try
        ParID := -1;
        If Not HasDot Then
        Begin
            GetInheritance(fCurrClassID);
            For I := 0 To fParser.Statements.Count - 1 Do
            Begin
                If ApplyStandardFilter(I) And
                    ApplyClassFilter(I, ParID, InheritanceIDs) Then
                    fCompletionStatementList.Add(PStatement(fParser.Statements[I]));
            End;
        End
        Else
        Begin // looking for class members only
            For I1 := 0 To fParser.Statements.Count - 1 Do
                If PStatement(fParser.Statements[I1])^._ScopelessCmd = _Class Then
                Begin
                    If PStatement(fParser.Statements[I1])^._Kind = skClass Then
                    Begin
            // added for the case "Class::Member", where "Class" is the actual class
                        ClassIDs.Clear;
                        ClassIDs.Add(I1);
                        bOnlyLocal := True;
                    End
                    Else
                        GetTypeID(PStatement(fParser.Statements[I1])^._Type, ClassIDs);
                End;

            If Not bOnlyLocal Then
                For I1 := 0 To ClassIDs.Count - 1 Do
                    GetInheritance(fParser.IndexOfStatement(ClassIDs[I1]));

            If fCurrClassID <> -1 Then
                CurrentID := fCurrClassID
            Else
                CurrentID := -1;
            For I := 0 To fParser.Statements.Count - 1 Do
            Begin
                If ApplyStandardFilter(I) And
                    ApplyMemberFilter(_Class, I, CurrentID, ClassIDs, InheritanceIDs) Then
                    fCompletionStatementList.Add(PStatement(fParser.Statements[I]));
            End;
        End;
    Finally
        sl.Free;
        InheritanceIDs.Free;
        ClassIDs.Free;
    End;
End;

Procedure TCodeCompletion.FilterList(_Class, _Value: String;
    HasDot: Boolean);
Var
    I: Integer;
Begin
    CodeComplForm.lbCompletion.Items.BeginUpdate;
    CodeComplForm.lbCompletion.Items.Clear;
    Try
        If _Class <> '' Then
        Begin //empty
            fCompletionStatementList.Clear;
            For I := 0 To fFullCompletionStatementList.Count - 1 Do
                If Not HasDot Then
                Begin //class only
                    If Assigned(fFullCompletionStatementList[I]) And AnsiStartsText(_Class, PStatement(fFullCompletionStatementList[I])^._ScopelessCmd) Then
                    Begin
                        fCompletionStatementList.Add(fFullCompletionStatementList[I]);
                        CodeComplForm.lbCompletion.Items.Add('');
                    End;
                End
                Else
                Begin //class and method
        // ignore "this" pointer as a member
                    If Assigned(fFullCompletionStatementList[I]) And (I <> fParser.GetThisPointerID) Then
                        If AnsiStartsText(_Value, PStatement(fFullCompletionStatementList[I])^._ScopelessCmd) Then
                        Begin
                            fCompletionStatementList.Add(fFullCompletionStatementList[I]);
                            CodeComplForm.lbCompletion.Items.Add('');
                        End;
                End;
        End
        Else
        Begin
            For I := 0 To fFullCompletionStatementList.Count - 1 Do
                CodeComplForm.lbCompletion.Items.Add('');
            fCompletionStatementList.Clear;
            fCompletionStatementList.Assign(fFullCompletionStatementList);
        End;
    Except
    End;
    CodeComplForm.lbCompletion.Items.EndUpdate;
End;

Function TCodeCompletion.GetHasDot(Phrase: String): Boolean;
Var
    I: Integer;
Begin
    Result := LastDelimiter('.', Phrase) > 0;
    If Not Result Then
    Begin
        I := LastDelimiter('>', Phrase);
        If I > 1 Then
            Result := Phrase[I - 1] = '-';
    End;
    If Not Result Then
    Begin
        I := LastDelimiter(':', Phrase);
        If I > 1 Then
            Result := Phrase[I - 1] = ':';
    End;
End;

Function TCodeCompletion.GetMember(Phrase: String): String;
Var
    I: Integer;
Begin
    I := LastDelimiter('.', Phrase);
    If I = 0 Then
    Begin
        I := LastDelimiter('>', Phrase);
        If I <> 0 Then
        Begin
            If (I > 1) And (Phrase[I - 1] <> '-') Then
                I := 0;
        End
        Else
        Begin
            I := LastDelimiter(':', Phrase);
            If I <> 0 Then
                If (I > 1) And (Phrase[I - 1] <> ':') Then
                    I := 0;
        End;
    End;
    If I = 0 Then
        Result := ''
    Else
        Result := Copy(Phrase, I + 1, Length(Phrase) - I + 2);
End;

Function TCodeCompletion.GetTypeID(_Value: String; il: TIntList): Integer;
Var
    I: Integer;
Begin
    Result := -1;
    If (_Value <> '') And (_Value[Length(_Value)] = '>') Then // template
        Delete(_Value, Pos('<', _Value), MaxInt);
    For I := 0 To fParser.Statements.Count - 1 Do
        If (AnsiCompareText(_Value, PStatement(fParser.Statements[I])^._ScopelessCmd) = 0) Or
            (AnsiCompareText(_Value, PStatement(fParser.Statements[I])^._ScopelessCmd + '*') = 0) Or
            (AnsiCompareText(_Value, PStatement(fParser.Statements[I])^._ScopelessCmd + '&') = 0) Or
            (AnsiCompareText(_Value, PStatement(fParser.Statements[I])^._ScopelessCmd + '**') = 0) Then
        Begin
            If (Result = -1) Or ((Result <> -1) And (PStatement(fParser.Statements[I])^._ParentID <> Result) {and (PStatement(fParser.Statements[I])^._ParentID <> -1)}) Then
            Begin
                Result := I;
                If Assigned(il) Then
                    il.Add(Result)
                Else
                    Break;
            End;
        End;
End;

Procedure TCodeCompletion.Hide;
Begin
    CodeComplForm.Hide;
End;

Procedure TCodeCompletion.ComplKeyPress(Sender: TObject; Var Key: Char);
Begin
    If fEnabled Then
    Begin
        Case Key Of
{$IFDEF WIN32}
            Char(vk_Escape), '.', '>':
                CodeComplForm.Hide;
{$ENDIF}
{$IFDEF LINUX}
      Char(xk_Escape), '.', '>': CodeComplForm.Hide;
{$ENDIF}
        End;

        If Assigned(fOnKeyPress) Then
            fOnKeyPress(Sender, Key);
    End;
End;

Function ListSort(Item1, Item2: Pointer): Integer;
Begin
  // first take into account that parsed statements need to be higher
  // in the list than loaded ones
    Result := 0;
    If PStatement(Item1)^._Loaded And Not PStatement(Item2)^._Loaded Then
        Result := 1
    Else
    If Not PStatement(Item1)^._Loaded And PStatement(Item2)^._Loaded Then
        Result := -1;

  // after that, consider string comparison
    If (Result = 0) And (Item1 <> Nil) And (Item2 <> Nil) Then
        Result := AnsiCompareText(PStatement(Item1)^._ScopelessCmd, PStatement(Item2)^._ScopelessCmd);
End;

Procedure TCodeCompletion.Search(Sender: TWinControl; Phrase, Filename: String);
Var
    P: TPoint;
    C: String;
    M: String;
    D: Boolean;
Begin
    If fEnabled Then
    Begin
        CodeComplForm.OnKeyPress := ComplKeyPress;
        CodeComplForm.SetColor(fColor);

        If (Sender <> Nil) And (Sender Is TWinControl) Then
        Begin
            P.X := TWinControl(Sender).Left;
            P.Y := TWinControl(Sender).Top + 16;
            If (Sender.Parent <> Nil) And (Sender.Parent Is TWinControl) Then
                P := TWinControl(Sender.Parent).ClientToScreen(P)
            Else
                P := TWinControl(Sender).ClientToScreen(P);
            fPos := P;
            SetPosition(fPos);
        End;

        CodeComplForm.Constraints.MinWidth := fMinWidth;
        CodeComplForm.Constraints.MinHeight := fMinHeight;

    // 23 may 2004 - peter schraut (peter_)
    // we set MaxWidth and MaxHeight to 0, to solve this bug:
    // https://sourceforge.net/tracker/index.php?func=detail&aid=935068&group_id=10639&atid=110639
        CodeComplForm.Constraints.MaxWidth := 0;
        CodeComplForm.Constraints.MaxHeight := 0;

        CodeComplForm.lbCompletion.Visible := False;

        If Trim(Phrase) <> '' Then
        Begin
            C := GetClass(Phrase);
            M := GetMember(Phrase);
            D := GetHasDot(Phrase); // and (M<>'');
            If Not D Or (D And (C <> '')) Then
                Try
                    Screen.Cursor := crHourglass;
        // only perform new search if just invoked
                    If Not CodeComplForm.Showing Then
                    Begin
                        fCompletionStatementList.Clear;
                        fFullCompletionStatementList.Clear;
                        fIncludedFiles.CommaText := fParser.GetFileIncludes(Filename);
                        GetCompletionFor(C, M, D);
                        fFullCompletionStatementList.Assign(fCompletionStatementList);
                    End;
        // perform filtering in list
                    FilterList(C, M, D);
                Finally
                    Screen.Cursor := crDefault;
                End;

            CodeComplForm.lbCompletion.Visible := True;
            If fCompletionStatementList.Count > 0 Then
            Begin
                fCompletionStatementList.Sort(@ListSort);
                SetWindowPos(CodeComplForm.Handle, 0, CodeComplForm.Left, CodeComplForm.Top, fWidth, fHeight, SWP_NOZORDER);
                CodeComplForm.lbCompletion.Repaint;
                CodeComplForm.Show;
                CodeComplForm.lbCompletion.SetFocus;
                If CodeComplForm.lbCompletion.Items.Count > 0 Then
                    CodeComplForm.lbCompletion.ItemIndex := 0;
            End
            Else
                CodeComplForm.Hide;
        End
        Else
      //Empty phrase string
            CodeComplForm.Hide;
    End;
End;

Function TCodeCompletion.SelectedIsFunction: Boolean;
Var
    st: PStatement;
Begin
    If fEnabled Then
    Begin
        st := SelectedStatement;
        If st <> Nil Then
            Result := st^._Kind In [skFunction, skConstructor, skDestructor]
        Else
            Result := False;
    End
    Else
        Result := False;
End;

Function TCodeCompletion.SelectedStatement: PStatement;
Begin
    If fEnabled Then
    Begin
        If (fCompletionStatementList.Count > CodeComplForm.lbCompletion.ItemIndex) And (CodeComplForm.lbCompletion.ItemIndex <> -1) Then
            Result := PStatement(fCompletionStatementList[CodeComplForm.lbCompletion.ItemIndex])
        Else
        Begin
            If fCompletionStatementList.Count > 0 Then
                Result := PStatement(fCompletionStatementList[0])
            Else
                Result := Nil;
        End;
    End
    Else
        Result := Nil;
End;

Procedure TCodeCompletion.SetParser(Value: TCppParser);
Begin
    If fParser <> Value Then
    Begin
        fParser := Value;
        CodeComplForm.fParser := Value;
    End;
End;

Procedure TCodeCompletion.SetPosition(Value: TPoint);
Begin
    fPos := Value;
    If fPos.X + fWidth > Screen.Width Then
        CodeComplForm.Left := fPos.X - fWidth
    Else
        CodeComplForm.Left := fPos.X;
    If fPos.Y + fHeight > Screen.Height Then
        CodeComplForm.Top := fPos.Y - fHeight - 16
    Else
        CodeComplForm.Top := fPos.Y;
End;

Procedure TCodeCompletion.OnFormResize(Sender: TObject);
Begin
    If Enabled Then
    Begin
        fWidth := CodeComplForm.Width;
        fHeight := CodeComplForm.Height;
        If Assigned(fOnResize) Then
            fOnResize(Self);
    End;
End;

Procedure TCodeCompletion.ShowArgsHint(FuncName: String; Rect: TRect);
Var
    HintText: String;
    I: Integer;
    S: String;
Begin
    HintText := '';
    fCompletionStatementList.Clear;

    For I := 0 To fParser.Statements.Count - 1 Do
        If AnsiCompareStr(PStatement(fParser.Statements[I])^._ScopelessCmd, FuncName) = 0 Then
        Begin
            S := Trim(PStatement(fParser.Statements[I])^._Args);
            If S <> '' Then
            Begin
                If HintText <> '' Then
                    HintText := HintText + #10;
                HintText := HintText + S;
            End;
        End;
    If HintText = '' Then
        HintText := '* No parameters known *';
    ShowMsgHint(Rect, HintText);
End;

Procedure TCodeCompletion.ShowMsgHint(Rect: TRect; HintText: String);
Var
    P, MaxX, Lines: Integer;
    s, s1: String;
Begin
    MaxX := 0;
    Lines := 1;
    S := HintText;

    Repeat
        P := Pos(#10, S);
        If P > 0 Then
        Begin
            S1 := Copy(S, 1, P - 1);
            S := Copy(S, P + 1, MaxInt);
            If fHintWindow.Canvas.TextWidth(S1) > MaxX Then
                MaxX := fHintWindow.Canvas.TextWidth(S1) + 8;
            Inc(Lines);
        End
        Else
        Begin
            If fHintWindow.Canvas.TextWidth(S) > MaxX Then
                MaxX := fHintWindow.Canvas.TextWidth(S) + 8;
        End;
    Until P = 0;

    Rect.Right := Rect.Left + MaxX;
    Rect.Bottom := Rect.Top + fHintWindow.Canvas.TextHeight(HintText) * Lines;
    fHintWindow.ActivateHint(Rect, HintText);
    fHintTimer.Enabled := True;
End;

Procedure TCodeCompletion.HintTimer(Sender: TObject);
Begin
    fHintWindow.ReleaseHandle;
End;

Procedure TCodeCompletion.SetHintTimeout(Value: Cardinal);
Begin
    If Value <> fHintTimer.Interval Then
        fHintTimer.Interval := fHintTimeout;
End;

Procedure TCodeCompletion.SetColor(Value: TColor);
Begin
    fColor := Value;
End;

Function TCodeCompletion.IsIncluded(FileName: String): Boolean;
Begin
    Result := fIncludedFiles.IndexOf(Filename) <> -1;
End;

{** Modified by Peter **}
Function TCodeCompletion.GetOnCompletion: TCompletionEvent;
Begin
    Result := CodeComplForm.OnCompletion;
End;

{** Modified by Peter **}
Procedure TCodeCompletion.SetOnCompletion(Value: TCompletionEvent);
Begin
    CodeComplForm.OnCompletion := Value;
End;

End.
