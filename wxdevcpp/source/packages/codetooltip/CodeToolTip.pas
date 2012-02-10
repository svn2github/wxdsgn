{----------------------------------------------------------------------------------

  The contents of this file are subject to the GNU General Public License
  Version 1.1 or later (the "License"); you may not use this file except in
  compliance with the License. You may obtain a copy of the License at
  http://www.gnu.org/copyleft/gpl.html

  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
  the specific language governing rights and limitations under the License.

  The Initial Developer of the Original Code is Peter Schraut.
  http://www.console-dev.de

  
  Portions created by Peter Schraut are Copyright 
  (C) 2002, 2003, 2004 by Peter Schraut (http://www.console-dev.de) 
  All Rights Reserved.

  
----------------------------------------------------------------------------------}

//
//
//  History:
//
//    xx/xx/2002
//      Initial release
//
//    31/10/2003
//      Complete rewrote of first version
//
//    01/11/2003
//      Beautified code
//
//    02/11/2003
//      Improved active parameter highlighting
//      Added "SkipString" function
//
//    21/03/2004
//      Added compatibility for latest synedit with wordwrap
//
//    22/03/2004
//      Added 'overloaded' feature. when more than 1 prototype
//      with the same name is in the list, the hintwindow displays
//      two buttons (up/down) where the user can walk through
//      all the same named functions. (like in VC++ .NET)
//      
//      added highlighting for hints. the hints use the same
//      highlighter-attributes as the editor does :)
//
//      the codehint is now displayed below the currentline and at the
//      same x position where the token starts. (like in VC++ .NET)
//
//      now looks the file very rubbish and needs some serious cleanup :P
//
//
//    2004-12-05
//      NEW_SYNEDIT is no longer need as we use "new' synedit
//      and never going back to "old". removing all defines and ifdefs
//
//    24/03/2004
//      Made more changes for downwards compatibility with old SynEdit.
//      Check the 'NEW_SYNEDIT' define.
//      Outsourced XPToolTip code to its own unit
//      Sorted functions in alphabetical order
//
//    25/03/2004
//      Some minor fixes regarding overloaded tooltips
//      Turned of DropShadow by default, since it's a bit annoying for code tooltips
//      Fixed 'Select' function. It now sets FCustomSelection to True
//
//    26/03/2204
//      Fixed a bug where no hint appeared when the cursor was directly before a '('
//
//

Unit CodeToolTip;

// the xptooltip looks nicer than the original THintWindow
// from delphi and yeah, it supports alphablending under win2k
// and shadowing under win xp. it is is downwards compatible.
// ttould run on win98 etc too!
{$DEFINE USE_XPTOOLTIP}


Interface
Uses
{$IFDEF WIN32}
    SysUtils, Dialogs, Classes, Windows, Messages, Graphics, Controls, Menus, Forms, StdCtrls,
    SynEditKbdHandler, SynEdit, SynEditHighlighter, XPToolTip;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, QDialogs, Classes, Xlib, QGraphics, QControls, QMenus, QForms, QStdCtrls,
  QSynEditKbdHandler, QSynEdit, QSynEditHighlighter, Types, XPToolTip;
{$ENDIF}


Type
    TCustomCodeToolTipButton = Class(TPersistent)
    Private
        FLeft,
        FTop,
        FWidth,
        FHeight: Integer;
    Protected
        Procedure Paint(Const TargetCanvas: TCanvas); Virtual; Abstract;
        Property Left: Integer Read FLeft Write FLeft;
        Property Top: Integer Read FTop Write FTop;
        Property Width: Integer Read FWidth Write FWidth;
        Property Height: Integer Read FHeight Write FHeight;
    Public
        Constructor Create; Virtual;
        Function ClientRect: TRect;
    End;


    TCodeToolTipUpButton = Class(TCustomCodeToolTipButton)
    Private
        FBitmap: TBitmap;
    Protected
        Procedure Paint(Const TargetCanvas: TCanvas); Override;
    Public
        Constructor Create; Override;
        Destructor Destroy; Override;
    End;


    TCodeToolTipDownButton = Class(TCustomCodeToolTipButton)
    Private
        FBitmap: TBitmap;
    Protected
        Procedure Paint(Const TargetCanvas: TCanvas); Override;
    Public
        Constructor Create; Override;
        Destructor Destroy; Override;
    End;


  { Options to customize the CodeToolTip behavior }
    TToolTipOptions = Set Of
        (
        ttoHideOnEnter,               // hides the tooltip when Return has been pressed
        ttoHideOnEsc,                 // hides the tooltip when ESC has been pressed
        ttoPaintStipples,             // paints stippled under the current highlighted argument 
        ttoCurrentArgumentBlackOnly,  // force the current argument to be black only
        shoFindBestMatchingToolTip    // automatically find the best matching tooltip (for overloaded functions)
        );


{$IFDEF USE_XPTOOLTIP}
    TBaseCodeToolTip = Class(TXPToolTip)
{$ELSE}
  TBaseCodeToolTip = class(TToolTip)
{$ENDIF}
    Private
        FTokenPos: Integer;
        FUpButton: TCustomCodeToolTipButton;
        FDownButton: TCustomCodeToolTipButton;
        FSelIndex: Integer;
        FBmp: TBitmap;
        FOptions: TToolTipOptions;
        FEditor: TCustomSynEdit;
        FKeyDownProc: TKeyEvent;
        FEndWhenChr: String;
        FStartWhenChr: String;
        FToolTips: TStringList;
        FCurCharW: Word;
        FCurShift: TShiftState;
        FActivateKey: TShortCut;
        FCurParamIndex: Integer;
        FLookupEditor: TCustomSynEdit;
        FDelimiters: String;
        FMaxScanLength: Integer;
        FCustomSelIndex: Boolean; // user clicked up/down
        Procedure SetSelIndex(Value: Integer);
        Procedure SetToolTips(Const Strings: TStringList);
        Procedure WMEraseBkgnd(Var Message: TWMEraseBkgnd); Message WM_ERASEBKGND;
        Procedure WMNCHitTest(Var Message: TWMNCHitTest); Message WM_NCHITTEST;
    Protected
        Procedure DoBeforeShow(Const AToolTips: TStringList; Const APrototypeName: String); Virtual;
        Function GetCommaIndex(P: Pchar; BraceStart, CurPos: Integer): Integer; Virtual;
        Procedure EditorKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Function FindClosestToolTip(ToolTip: String; CommaIndex: Integer): String; Virtual;
        Procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); Override;
        Procedure Paint; Override;
        Function PaintToolTip: Integer; Virtual;
        Function RemoveEditor(AEditor: TCustomSynEdit): Boolean; Virtual;
        Procedure SetEditor(Const Value: TCustomSynEdit); Virtual;
        Property ActivateKey: TShortCut Read FActivateKey Write FActivateKey;
        Property Editor: TCustomSynEdit Read FEditor Write SetEditor;
        Property EndWhenChr: String Read FEndWhenChr Write FEndWhenChr;
        Property Hints: TStringList Read FToolTips Write SetToolTips;
        Property MaxScanLength: Integer Read FMaxScanLength Write FMaxScanLength Default 1024;
        Property Options: TToolTipOptions Read FOptions Write FOptions;
        Property SelIndex: Integer Read FSelIndex Write SetSelIndex;
        Property StartWhenChr: String Read FStartWhenChr Write FStartWhenChr;
    Public
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Function Select(ToolTip: String): Integer; Virtual;
        Procedure RethinkCoordAndActivate; Virtual;
        Procedure Show; Virtual;
    End;


    TCodeToolTip = Class(TBaseCodeToolTip)
    Public
        Property Activated;
        Property SelIndex;
    Published
        Property ActivateKey;
        Property Color;
        Property Editor;
        Property EndWhenChr;
        Property Hints;
        Property MaxScanLength;
        Property Options;
        Property StartWhenChr;
    End;


Implementation
//uses
//  dbugintf;  EAB removed Gexperts debug stuff.
// contains the up/down buttons
// i tried to draw them using DrawFrameControl first,
// but it looked very bad, so I use a bitmap instead.
{$R CodeToolTip.res}

Resourcestring
    SCodeToolTipIndexXOfX = '%d / %d';


Var
    Identifiers: Array[#0..#255] Of Bytebool;


//----------------------------------------------------------------------------------------------------------------------

Procedure MakeIdentTable;
Var
    c: Char;
Begin
    FillChar(Identifiers, SizeOf(Identifiers), 0);

    For c := 'a' To 'z' Do
        Identifiers[c] := True;

    For c := 'A' To 'Z' Do
        Identifiers[c] := True;

    For c := '0' To '9' Do
        Identifiers[c] := True;

    Identifiers['_'] := True;
    Identifiers['~'] := True;
End;

  //--------------------------------------------------------------------------------------------------------------------

Function PreviousWordString(S: String; Index: Integer): String;
Var
    I: Integer;
    TplArgs: Integer;

    Procedure SkipSpaces;
    Begin
        Repeat
            Dec(Index);
        Until (Index = 0) Or (Not (S[Index] In [#32, #9]));
    End;
Begin
    Result := '';
    If (Index <= 1) Or (S = '') Then
        Exit;

    // Skip blanks and tabs
    SkipSpaces;

    // Skip template parameters
    If S[Index] = '>' Then //template parameter
    Begin
        TplArgs := 1;
        While (TplArgs <> 0) And (Index > 1) Do
        Begin
            Dec(Index);
            Case S[Index] Of
                '>':
                    Inc(TplArgs);
                '<':
                    Dec(TplArgs);
            End;
        End;
    End;

    Inc(Index);
    I := Index;
    Repeat
        Dec(Index);
        If Index < 2 Then
            Break;
    Until Not Identifiers[S[Index]];

    If Not Identifiers[S[Index]] Then
        Inc(Index);

    Result := Copy(S, Index, I - Index);
End;

Function GetPrototypeName(Const S: String): String;
Begin
    Result := PreviousWordString(S, AnsiPos('(', S));
End;

Function CountCommas(Const S: String): Integer;
Var
    J: Integer;
Begin
    Result := 0;
    For J := 1 To Length(S) Do
        If S[J] = ',' Then
            Inc(Result);
End;

//----------------- TCustomCodeToolTipButton ---------------------------------------------------------------------------

Constructor TCustomCodeToolTipButton.Create;
Begin
    FLeft := 0;
    FTop := 0;
    FWidth := 9;
    FHeight := 11;
End;

//----------------------------------------------------------------------------------------------------------------------

Function TCustomCodeToolTipButton.ClientRect: TRect;
Begin
    Result := Rect(FLeft, FTop, FLeft + FWidth, FTop + FHeight);
End;

//----------------- TCodeToolTipUpButton -------------------------------------------------------------------------------

Constructor TCodeToolTipUpButton.Create;
Begin
    Inherited;

    FBitmap := TBitmap.Create;
    FBitmap.LoadFromResourceName(HInstance, 'UPBUTTON');
End;

//----------------------------------------------------------------------------------------------------------------------

Destructor TCodeToolTipUpButton.Destroy;
Begin
    If Assigned(FBitmap) Then
        FBitmap.Free;
    Inherited;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCodeToolTipUpButton.Paint(Const TargetCanvas: TCanvas);
Begin
    StretchBlt(TargetCanvas.Handle, FLeft, FTop, FWidth, FHeight,
        FBitmap.Canvas.Handle, 0, 0, FBitmap.Width, FBitmap.Height, SRCCOPY);
End;

//----------------- TCodeToolTipDownButton -----------------------------------------------------------------------------

Constructor TCodeToolTipDownButton.Create;
Begin
    Inherited;

    FBitmap := TBitmap.Create;
    FBitmap.LoadFromResourceName(HInstance, 'DOWNBUTTON');
End;

//----------------------------------------------------------------------------------------------------------------------

Destructor TCodeToolTipDownButton.Destroy;
Begin
    If Assigned(FBitmap) Then
        FBitmap.Free;
    Inherited;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCodeToolTipDownButton.Paint(Const TargetCanvas: TCanvas);
Begin
    StretchBlt(TargetCanvas.Handle, FLeft, FTop, FWidth, FHeight,
        FBitmap.Canvas.Handle, 0, 0, FBitmap.Width, FBitmap.Height, SRCCOPY);
End;

//----------------- TBaseCodeToolTip ---------------------------------------------------------------------------------------

Constructor TBaseCodeToolTip.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);

    FLookupEditor := TSynEdit.Create(Self);
    FOptions := [ttoHideOnEsc, ttoCurrentArgumentBlackOnly, shoFindBestMatchingToolTip];

    FBmp := TBitmap.Create;
    With FBmp Do
    Begin
        PixelFormat := pf24Bit;
        Width := Screen.Width; // worst case hintwidth
        Height := 32;
        Canvas.Font := Screen.HintFont;
    End;

    FToolTips := TStringList.Create;
    With FToolTips Do
    Begin
    //Sorted := True;
        CaseSensitive := True;
    //Duplicates := dupIgnore;
    End;

  // FDelimiters is used for the prototype-scanning.
  // for example when your prototypes look like this:
  //  procedure foo(a: Integer; b: Byte);
  // then use FDelimiters := ';'
  // If they are C stylish like
  // void foo(int a, unsigned char b);
  // then use FDelimiters := ',' 
    FDelimiters := ',';

    FStartWhenChr := '(';          // Start to check, when one of this char is pressed
    EndWhenChr := ';\';
    FActivateKey := ShortCut(Ord(#32), [ssCtrl, ssShift]);
    FCurCharW := 0;
    FCurShift := [];

  // since we supports scanning over multiple lines,
  // we have a limit of how many chars we scan maximal...
    FMaxScanLength := 1024;

    FKeyDownProc := EditorKeyDown;

    FUpButton := TCodeToolTipUpButton.Create;
    FUpButton.Left := 4;
    FUpButton.Top := 3;

    FDownButton := TCodeToolTipDownButton.Create;
    FDownButton.Left := 20; // unknown, it's calculated at runtime
    FDownButton.Top := 3;
End;

//----------------------------------------------------------------------------------------------------------------------

Destructor TBaseCodeToolTip.Destroy;
Begin
    If Activated Then
        ReleaseHandle;

    FKeyDownProc := Nil;
    FEditor := Nil;

    If Assigned(FUpButton) Then
        FreeAndNil(FUpButton)
    Else
        FUpButton := Nil;

    If Assigned(FDownButton) Then
        FreeAndNil(FDownButton)
    Else
        FDownButton := Nil;

    If Assigned(FBmp) Then
        FBmp.Free;
    If Assigned(FToolTips) Then
        FToolTips.Free;
    If Assigned(FLookupEditor) Then
        FLookupEditor.Free;

    Inherited;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TBaseCodeToolTip.DoBeforeShow(Const AToolTips: TStringList; Const APrototypeName: String);
Begin
  // descents override this function to be able to fill the FToolTips list with
  // more tooltips ...
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TBaseCodeToolTip.EditorKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    FCurCharW := Key;
    FCurShift := Shift;

    If FActivateKey = Shortcut(Key, Shift) Then
        Show;

    If Activated Then
    Begin
        Case Key Of
{$IFDEF WIN32}
            VK_ESCAPE:
            Begin
                If (ttoHideOnESC In FOptions) Then
                    ReleaseHandle;
            End;

            VK_RETURN:
            Begin
                If (ttoHideOnEnter In FOptions) Then
                    ReleaseHandle
                Else Show;
            End;
{$ENDIF}
{$IFDEF LINUX}
      XK_ESCAPE:
        begin
          if (ttoHideOnESC in FOptions) then ReleaseHandle;
        end;
        
      XK_RETURN:
        begin
          if (ttoHideOnEnter in FOptions) then ReleaseHandle
          else Show;
        end; 
{$ENDIF}
        End;
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Function TBaseCodeToolTip.FindClosestToolTip(ToolTip: String; CommaIndex: Integer): String;
Var
    I, K: Integer;
    NewIndex: Integer;
    Str: String;
    LastCommaCnt: Integer;
Begin
    LastCommaCnt := 4096;
    NewIndex := 0;
    Result := GetPrototypeName(FToolTips.Strings[FSelIndex]);

  // current commacount fits still in the selected tooltip and just do nothing
    If (FSelIndex < FToolTips.Count) And (ToolTip = FToolTips.Strings[FSelIndex]) Then
        If CountCommas(FToolTips.Strings[FSelIndex]) <= CommaIndex Then
            Exit;

  // loop through the list and find the closest matching tooltip
  // we compare the comma counts
    For I := 0 To FToolTips.Count - 1 Do
    Begin
        Str := GetPrototypeName(FToolTips.Strings[I]);
        If Str = ToolTip Then
        Begin
            K := CountCommas(FToolTips.Strings[I]);
            If K >= CommaIndex Then
            Begin
                If K < LastCommaCnt Then
                Begin
                    NewIndex := I;
                    LastCommaCnt := K;
                End;
            End;
        End;
    End;

    Result := FToolTips.Strings[NewIndex];
    SelIndex := NewIndex;
End;

//----------------------------------------------------------------------------------------------------------------------

Function TBaseCodeToolTip.GetCommaIndex(P: Pchar; BraceStart, CurPos: Integer): Integer;
//  to highlight the current prototype argument, we need
//  to know where the cursor in the prototype is.
//  this functions returns the count of commas from the beginning
//  prototype.
//  for example: 
//  definition is -> void foo(int a, int b, int c);
//  we write this -> foo(1, 2|
//  The '|' represents the cursor. In this example this function returns 1, since
//  it progressed one comma.
Var
    I: Integer;
    Parentheses: Integer;
    TplArgs: Integer;

  // skip to EOL
    Procedure SkipLine;
    Begin
        Repeat
            Inc(i);
            If i > CurPos Then
                Break;
        Until P[i] In [#0, #10, #13];
    End;

  // skip c/c++ commentblocks
    Procedure SkipCommentBlock;
    Begin
        Repeat
            Case P[i] Of
                '*':
                    If P[i + 1] = '/' Then
                    Begin
                        Break;
                    End;
            End;
            Inc(i);
            If i > CurPos Then
                Break;
        Until P[i] In [#0];
    End;

  // skip strings! since it not unusual to
  // have commas in string we MUST ignore them!
    Procedure SkipStrings;
    Begin
        Inc(i);
        Repeat
            Case P[i] Of
        // Don't skip escaped strings. For example: "Hello \"Bond, James\"..."
        // This is one string only and we do not want to count commas in it
                '\':
                    If P[i + 1] = '"' Then
                        Inc(i);

                '"':
                    Break;
            End;
            Inc(i);
            If i > CurPos Then
                Break;
        Until P[i] In [#0];
    End;

Begin
    Result := 0;
    TplArgs := 0;
    Parentheses := 0;
    I := BraceStart;

    While I <= CurPos Do
    Begin
        Case P[i] Of
      // strings
            '"':
                SkipStrings;

      // comments
            '/':
                If P[i + 1] = '/' Then
                    SkipLine
                Else
                If P[i + 1] = '*' Then
                    SkipCommentBlock;

      // commas
            ',':
                If (Parentheses = 0) And (TplArgs = 0) Then
                    Inc(Result);

      // parentheses
            '(':
                Inc(Parentheses);
            ')':
                Dec(Parentheses);

      // template arguments
            '<':
                Inc(TplArgs);
            '>':
                Dec(TplArgs);
        End;
        Inc(i);
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TBaseCodeToolTip.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
    Pt: TPoint;
    NeedRefresh: Boolean;
Begin
    Inherited;

    If mbLeft = Button Then
    Begin
        NeedRefresh := False;

        Try
            Pt := ScreenToClient(Mouse.CursorPos);

      // check if we clicked in the UpButton
            If PtInRect(FUpButton.ClientRect, Pt) Then
            Begin
                If FSelIndex < FToolTips.Count - 1 Then
                    Inc(FSelIndex, 1)
                Else FSelIndex := 0;
                NeedRefresh := True;
                FCustomSelIndex := True;
            End;

      // check if we clicked in the DownButton
            If PtInRect(FDownButton.ClientRect, Pt) Then
            Begin
                If FSelIndex > 0 Then
                    Dec(FSelIndex, 1)
                Else FSelIndex := FToolTips.Count - 1;
                NeedRefresh := True;
                FCustomSelIndex := True;
            End;

        Finally
            FEditor.SetFocus;
            If NeedRefresh Then
                Show;
        End;
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TBaseCodeToolTip.Paint;
Begin
    PaintToolTip;
    Canvas.CopyRect(ClientRect, FBmp.Canvas, ClientRect);
End;

//----------------------------------------------------------------------------------------------------------------------

Function TBaseCodeToolTip.PaintToolTip: Integer;
Const
    cStipple: Array [0..3] Of Integer = (0, 1, 2, 1);
Var
    BracePos: Integer;
    WidthParam: Integer;
    I: Integer;
    CurParam: Integer;
    StrToken, S: String;
{$IFDEF WIN32}
    CurChar: Char;
{$ENDIF}
{$IFDEF LINUX}
 CurChar: WideChar;
{$ENDIF}

    Procedure DrawParamLetterEx(Index: Integer; CurrentParam: Boolean = False);
    Var
        J: Integer;
        CharW: Integer;
        CharH: Integer;
        HLAttr: TSynHighlighterAttributes;
    Begin
    // we use a lookup editor to get the syntax coloring
    // for out tooltips :)
        FLookupEditor.CaretX := Index;
        FLookupEditor.GetHighlighterAttriAtRowCol(FLookupEditor.CaretXY, StrToken, HLAttr);

        With FBmp.Canvas Do
        Begin
            Brush.Style := bsClear;
            If HLAttr <> Nil Then
                Font.Color := HLAttr.Foreground;

      // if it is the word where the cursor currently is
      // we draw it in bold and also check for further drawing options
            If CurrentParam Then
            Begin
                Font.Style := [fsBold];
                If (ttoCurrentArgumentBlackOnly In FOptions) Then
                    Font.Color := clBlack;
            End
            Else
            If HLAttr <> Nil Then
                Font.Style := HLAttr.Style;

            CharH := TextHeight('Wg');
            CharW := TextWidth(FLookupEditor.Text[Index]);

      // draw the stipple line under the current param-char
            If CurrentParam And (ttoPaintStipples In FOptions) Then
            Begin
                For J := 0 To CharW Do
                    Pixels[WidthParam + J, CharH - cStipple[J And 3]] := clRed;
            End;

      // draw the char and then increase the current width by the
      // width of the just drawn char ...
            TextOut(WidthParam, 1, FLookupEditor.Text[Index]);
            Inc(WidthParam, CharW);
        End;
    End;
Begin

    BracePos := AnsiPos('(', Caption);
    If BracePos > 0 Then
    Begin
        CurParam := 0;
        WidthParam := 4; // left start position in pixels

    // clear the backbuffer
        With FBmp.Canvas Do
        Begin
            Brush.Color := Self.Color;
            FillRect(ClientRect);
        End;

    // when more than one tooltip is in the list
    // we must draw the buttons as well ...
        If FToolTips.Count > 1 Then
        Begin
      // paint the UP button
            FUpButton.Paint(FBmp.Canvas);
            Inc(WidthParam, FUpButton.Left + FUpButton.Width);

      // output text between the buttons
            FBmp.Canvas.Font.Style := [];
            S := Format(SCodeToolTipIndexXOfX, [FSelIndex + 1, FToolTips.Count]);
            FBmp.Canvas.TextOut(WidthParam, 1, S);
            Inc(WidthParam, FBmp.Canvas.TextWidth(S) + 3);

      // paint the DOWN button
            FDownButton.Left := WidthParam;
            FDownButton.Paint(FBmp.Canvas);
            Inc(WidthParam, 3 + FDownButton.Width + FUpButton.Left);
        End;


    // now loop through the hint and draw each letter
        For i := 1 To Length(Caption) Do
        Begin
            CurChar := Caption[I];

      // if the current char is one of our delimiters
      // we must increase the CurParam variable which indicates
      // at which comma index our cursor is.
            If AnsiPos(CurChar, FDelimiters) > 0 Then
                Inc(CurParam);

            If (CurParam = FCurParamIndex) And (AnsiPos(CurChar, FDelimiters) = 0) And (I > BracePos) And (CurChar <> ')') And (CurChar <> ' ') Then
                DrawParamLetterEx(I, True) // at current comma index
            Else
                DrawParamLetterEx(I); // normal
        End;
    End;

    Result := WidthParam + 6;
End;

//----------------------------------------------------------------------------------------------------------------------

Function TBaseCodeToolTip.RemoveEditor(aEditor: TCustomSynEdit): Boolean;
Begin
    Result := Assigned(aEditor);

    If Result Then
    Begin
        aEditor.RemoveKeyDownHandler(fKeyDownProc);
        If aEditor = fEditor Then
            fEditor := Nil;
  {$IFDEF SYN_COMPILER_5_UP}
    RemoveFreeNotification(aEditor);
  {$ENDIF}
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TBaseCodeToolTip.RethinkCoordAndActivate;
Const
    cHorzFix = 30;
Var
    Pt: TPoint;
    NewWidth: Integer;
    CaretXYPix: TPoint;
    RelativeRect: TRect;
    YPos: Integer;
Begin
    CaretXYPix := FEditor.RowColumnToPixels(FEditor.DisplayXY);
    Pt := FEditor.ClientToScreen(Point(CaretXYPix.X, CaretXYPix.Y));

    Dec(Pt.X, cHorzFix);
    Dec(Pt.Y, FEditor.LineHeight);

    YPos := Pt.Y;
    Inc(YPos, FEditor.LineHeight);

  // draw the tooltop on the offscreen bitmap
  // and return the length of the drawn text  
    NewWidth := PaintToolTip;

  // this displays the rect below the current line and at the
  // same position where the token begins
    Pt := FEditor.RowColumnToPixels(FEditor.BufferToDisplayPos(FEditor.CharIndexToRowCol(FTokenPos)));

  // because we do not want to overflow the screen, we need to calculate the relative
  // positions to see if the hint should be hidden
    RelativeRect.Left := {CaretXYPix.X} Pt.x - cHorzFix - FEditor.Gutter.Width;
    RelativeRect.Right := RelativeRect.Left + NewWidth;
    RelativeRect.Top := CaretXYPix.Y + 2 + FEditor.LineHeight;
    RelativeRect.Bottom := RelativeRect.Top + 2 + Canvas.TextHeight('Wg');
    If ((NewWidth < FEditor.Width - cHorzFix - FEditor.Gutter.Width) And ((RelativeRect.Left < 0) Or (RelativeRect.Right > FEditor.Width))) Or
        (RelativeRect.Top < 0) Or (RelativeRect.Bottom > FEditor.Height) Then
    Begin
        DestroyHandle; //Destroy the handle but don't mark ourselves as inactive
        Exit;
    End;

    Pt := FEditor.ClientToScreen(Pt);
    ActivateHint(Rect(Pt.X,
        YPos + 2 + FEditor.LineHeight,
        Pt.X + NewWidth,
        YPos + 4 + Canvas.TextHeight('Wg') + FEditor.LineHeight),
        Caption);
End;

//----------------------------------------------------------------------------------------------------------------------

Function TBaseCodeToolTip.Select(ToolTip: String): Integer;

//  selects the tooltip specified by ToolTip and returns
//  the index from it, in the list. 
//  the tooltip must be already added to the tooltiplist,
//  otherwise it cannot find it and returns -1
//
//  on success it returns the index of the tooltip in the list
//  otherwise it returns -1

Var
    I: Integer;
Begin
    Result := -1;

    If FToolTips.Count <> -1 Then
    Begin
        For I := 0 To FToolTips.Count - 1 Do
        Begin
            If FToolTips.Strings[I] = ToolTip Then
            Begin
                SelIndex := I;  // set the current index
                Result := I;  // return the index
                Break;
            End;
        End;
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TBaseCodeToolTip.SetEditor(Const Value: TCustomSynEdit);
Begin
    If (FEditor <> Nil) Then
        RemoveEditor(fEditor);

    FEditor := Value;

    If (FEditor <> Nil) Then
    Begin
        FEditor.AddKeyDownHandler(FKeyDownProc);
        FEditor.FreeNotification(FEditor);
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TBaseCodeToolTip.SetSelIndex(Value: Integer);
// sets the selection index and repaints the hint when it is activated
Begin
    If (Value < 0) Or (Value > FToolTips.Count) Then
        Raise Exception.Create('ToolTip selection index is out of list range!');

    If Value <> FSelIndex Then
    Begin
        FSelIndex := Value;
        If Activated Then
        Begin
            FCustomSelIndex := True;
            Show;
        End;
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TBaseCodeToolTip.SetToolTips(Const Strings: TStringList);
Begin
    FToolTips.Clear;
    FToolTips.Assign(Strings);
End;


//----------------------------------------------------------------------------------------------------------------------

Procedure TBaseCodeToolTip.Show;
Var
    CurPos: Integer;
    P: Pchar;
    I: Integer;
    nBraces, nTplArgs: Integer;
    S: String;
    Idx: Integer;
    S1: String;
    nCommas: Integer;
    ProtoFound: Boolean;
    attr: TSynHighlighterAttributes;
    attrstr: String;

  // skip c/c++ commentblocks 
    Procedure SkipCommentBlock;
    Begin
        Repeat
            Case P[CurPos] Of
                '*':
                    If P[CurPos - 1] = '/' Then
                    Begin
                        Dec(CurPos);
                        Break;
                    End
                    Else
                        Dec(CurPos);
            Else
                Dec(CurPos);
            End;

            Inc(I);
            If i > FMaxScanLength Then
                Break;
        Until P[CurPos] In [#0];
    End;
Begin

    ASSERT(Nil <> FToolTips, 'FToolTips must not be nil');
    ASSERT(Nil <> FEditor, 'FEditor must not be nil');
    If (FEditor.Highlighter = Nil) Then
        exit;

  // get the current position in the text
    Idx := FEditor.SelStart - 1;
    CurPos := FEditor.SelStart - 1;

  //get highlighter attribute and check if the cursor is not within
  //string or comment etc.
    FEditor.GetHighlighterAttriAtRowCol(FEditor.CaretXY, attrstr, attr);
    With FEditor.Highlighter Do
        If (attr <> Nil) Then
            If (attr = StringAttribute) Or (attr = CommentAttribute) Then
                Exit;

  // get a pointer to the text
    P := Pchar(FEditor.Text);

  // set the braced count to its initial value
  // when a closing brace is right behind the cursor
  // we increase it by 1
    nTplArgs := 0;
    nBraces := 1;
    nCommas := 0;
    I := 1;

  // this loop is used to find an open function like
  // foo(i, ...
    While I < FMaxScanLength Do
    Begin
        Case P[CurPos] Of
            '/':
                If P[CurPos - 1] = '*' Then
                    SkipCommentBlock;

            ')':
                Inc(nBraces);

            '(':
            Begin
                Dec(nBraces);
                If nBraces = 0 Then
                Begin
                    Inc(CurPos);
                    Break;
                End;
            End;

            '<':
                Dec(nTplArgs);
            '>':
                Inc(nTplArgs);

            ',':
                If (nBraces = 1) And (nTplArgs = 0) Then
          //Only when we are in the function we are trying to fill
                    Inc(nCommas);

            #0:
                Exit;
        End;

        Dec(CurPos);
        If CurPos <= 1 Then
        Begin
            CurPos := FEditor.SelStart;
            Inc(CurPos);
            Break;
        End;

        Inc(I);
    End;

  // when the tooltip is not activated yet we don't have an index of a function
  // prototype to display, so we set it to zero
    If Not Activated Then
    Begin
        FSelIndex := 0;
        FCustomSelIndex := False;
    End;

  // get the previous word, this is the word infront of the brace. for example from
  // foo(int a, int b) the previous word would be 'foo'  
    S := PreviousWordString(P, CurPos);

  // populate the tooltips list (the entire list of possible tooltips)
    DoBeforeShow(FToolTips, S);

  // get the current token position in the text
  // this is where the prototypename usually starts
    FTokenPos := CurPos - Length(S) - 1;

  // if the function name is empty just skip over it
    ProtoFound := False;
    If Trim(S) <> '' Then
    Begin
    // iterate over all the tooltips, eliminating "wrong" tooltips from the list
        I := 0;
        While I < FToolTips.Count Do
        Begin
            S1 := GetPrototypeName(FToolTips.Strings[I]);
            If (S1 = S) And (AnsiPos('(', FToolTips.Strings[I]) > 0) Then
            Begin
                If (Not Activated) And (Not ProtoFound) Then
                    FSelIndex := I;
                ProtoFound := True;
                Inc(I);
            End
            Else
                FToolTips.Delete(I);
        End;
    End;

    If (Trim(S) <> '') And ProtoFound Then
    Begin
    // when the user has choosen his own index, when he clicked
    // either the UP or DOWN button, don't try to find the closest
    // tooltip, use the selected index as the string
        If (shoFindBestMatchingToolTip In FOptions) Then
            If Not FCustomSelIndex Then
                S := FindClosestToolTip(S, nCommas);

        If (FToolTips.Count > 0) And (FSelIndex < FToolTips.Count) Then
            S := FToolTips.Strings[FSelIndex];

    // set the hint caption
        Caption := S;

    // we use the LookupEditor to get the highlighter-attributes
    // from. check the DrawAdvanced method!
        FLookupEditor.Text := S;
        FLookupEditor.Highlighter := FEditor.Highlighter;

    // get the index of the current bracket where the cursor is
        FCurParamIndex := GetCommaIndex(P, CurPos, Idx);
        RethinkCoordAndActivate;
    End
    Else
    If (AnsiPos(Chr(FCurCharW), FEndWhenChr) > 0) Then
        ReleaseHandle
    Else
  // Make sure when we are before a brace, to release the hint.
  // hel_function(
  //            ^-- If we are here, we must hide it!
        Case FCurCharW Of
{$IFDEF WIN32}
            VK_LEFT,
            VK_RIGHT,
            VK_UP,
            VK_DOWN,
            VK_BACK:
                ReleaseHandle;
{$ENDIF}
{$IFDEF LINUX}
      XK_LEFT,
      XK_RIGHT,
      XK_UP,
      XK_DOWN,
      XK_BackSpace: ReleaseHandle;
{$ENDIF}
        Else
      // Braces dont match? Then hide ..
            If nBraces <> 0 Then
                ReleaseHandle;
        End;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TBaseCodeToolTip.WMNCHitTest(Var Message: TWMNCHitTest);
Var
    Pt: TPoint;
Begin
    Message.Result := HTTRANSPARENT;
    Pt := ScreenToClient(Point(Message.XPos, Message.YPos));

  // hitcheck against the position of our both buttons
    If PtInRect(FUpButton.ClientRect, Pt) Or PtInRect(FDownButton.ClientRect, Pt) Then
    Begin
        Message.Result := HTCLIENT;
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TBaseCodeToolTip.WMEraseBkgnd(Var Message: TWMEraseBkgnd);
// override WMEraseBkgnd to avoid flickering
Begin
    Message.Result := 1;
End;

//----------------------------------------------------------------------------------------------------------------------

Initialization
    MakeIdentTable;

Finalization


End.
