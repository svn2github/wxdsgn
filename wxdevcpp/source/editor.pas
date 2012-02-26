{        
    $Id: editor.pas 802 2007-01-14 07:34:06Z lowjoel $

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

Unit editor;

Interface

Uses
{$IFDEF WIN32}
    Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    CodeCompletion, CppParser,
    Menus, ImgList, ComCtrls, StdCtrls, ExtCtrls, SynEdit,
    SynEditKeyCmds, version, Grids,
    SynCompletionProposal, StrUtils, SynEditTypes, SynEditHighlighter,
 //   SynEditCodeFolding,
    {** Modified by Peter **}
    DevCodeToolTip, SynAutoIndent, utils, iplugin;
{$ENDIF}

Type
    TEditor = Class;
    TDebugGutter = Class(TSynEditPlugin)
    Protected
        fEditor: TEditor;
        Procedure AfterPaint(ACanvas: TCanvas; Const AClip: TRect;
            FirstLine, LastLine: Integer); Override;
        Procedure LinesInserted(FirstLine, Count: Integer); Override;
        Procedure LinesDeleted(FirstLine, Count: Integer); Override;
              //  ;AddToUndoList: boolean); override;
    Public
        Constructor Create(ed: TEditor);
    End;

    // RNC no longer uses an Editor to toggle
    TBreakpointToggleEvent = Procedure(index: Integer;
        BreakExists: Boolean) Of Object;

    TEditor = Class
    Private
        fInProject: Boolean;
        fFileName: String;
        fNew: Boolean;
        fRes: Boolean;
        fModified: Boolean;
        fText: TSynEdit;
        fPlugin: String;

        fTabSheet: TTabSheet;
        fErrorLine: Integer;
        fActiveLine: Integer;
        fErrSetting: Boolean;
        fDebugGutter: TDebugGutter;
        fDebugHintTimer: TTimer;
        fCurrentHint: String;
        //////// CODE-COMPLETION - mandrav /////////////
        flastStartParenthesis: Integer;
        fCompletionEatSpace: Boolean;
        fToolTipTimer: TTimer;
        fTimer: TTimer;
        fTimerKey: Char;
        fCompletionBox: TCodeCompletion;
        fRunToCursorLine: Integer;
        fFunctionArgs: TSynCompletionProposal;
        fLastParamFunc: TList;
        FCodeToolTip: TDevCodeToolTip;
        FAutoIndent: TSynAutoIndent;
        Procedure CompletionTimer(Sender: TObject);
        Procedure ToolTipTimer(Sender: TObject);
        Procedure CodeRushLikeEditorKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditorOnScroll(Sender: TObject; ScrollBar: TScrollBarKind);
        Procedure EditorKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditorKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure EditorKeyUp(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure EditorMouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        Procedure SetEditorText(Key: Char);
        Procedure InitCompletion;
        Procedure DestroyCompletion;
        Function CurrentPhrase: String;
        Function CheckAttributes(P: TBufferCoord; Phrase: String): Boolean;
        //////// CODE-COMPLETION - mandrav - END ///////
        Function GetModified: Boolean;
        Procedure SetModified(value: Boolean);

        Procedure TurnOffBreakpoint(line: Integer);
        Procedure TurnOnBreakpoint(line: Integer);

        Procedure EditorStatusChange(Sender: TObject;
            Changes: TSynStatusChanges);
        Procedure EditorSpecialLineColors(Sender: TObject; Line: Integer;
            Var Special: Boolean; Var FG, BG: TColor);
        Procedure EditorGutterClick(Sender: TObject; Button: TMouseButton;
            x, y, Line: Integer; mark: TSynEditMark);
        Procedure EditorReplaceText(Sender: TObject;
            Const aSearch, aReplace: String; Line, Column: Integer;
            Var Action: TSynReplaceAction);
        Procedure EditorDropFiles(Sender: TObject; x, y: Integer;
            aFiles: TStrings);
        Procedure EditorDblClick(Sender: TObject);
        Procedure EditorMouseMove(Sender: TObject; Shift: TShiftState;
            X, Y: Integer);
        Procedure DebugHintTimer(sender: TObject);
        Procedure OnVariableHint(Hint: String);

        Procedure SetFileName(value: String);
        Procedure DrawGutterImages(ACanvas: TCanvas; AClip: TRect;
            FirstLine, LastLine: Integer);
        Procedure EditorPaintTransient(Sender: TObject;
            Canvas: TCanvas; TransientType: TTransientType);
        Procedure FunctionArgsExecute(Kind: SynCompletionType; Sender: TObject;
            Var AString: String; Var x, y: Integer; Var CanExecute: Boolean);
    Protected
        Procedure DoOnCodeCompletion(Sender: TObject;
            Const AStatement: TStatement;
            Const AIndex: Integer); {** Modified by Peter **}
    Public
        Procedure Init(In_Project: Boolean; Caption_, File_name: String;
            DoOpen: Boolean; Const IsRes: Boolean = False);
        Destructor Destroy; Override;
{$IFDEF PLUGIN_BUILD}
        Procedure Close; // New fnc for wx
{$ENDIF}
        // RNC set the breakpoints for this file when it is opened
        Procedure SetBreakPointsOnOpen;

        // RNC 07-21-04
        // Add remove a breakpoint without calling OnBreakpointToggle
        Function HasBreakPoint(line_number: Integer): Integer;
        Procedure InsertBreakpoint(line: Integer);
        Procedure RemoveBreakpoint(line: Integer);
        Procedure InvalidateGutter;

        Procedure Activate;
        Function ToggleBreakPoint(Line: Integer): Boolean;
        Procedure RunToCursor(Line: Integer);
        Procedure GotoLine;
        Procedure GotoLineNr(Nr: Integer);
        Function Search(Const isReplace: Boolean): Boolean;
        Procedure SearchAgain;
        Procedure SearchKeyNavigation(MoveForward: Boolean = True);
        Procedure Exportto(Const isHTML: Boolean);
        Procedure InsertString(Const Value: String; Const move: Boolean);
    {$IFDEF PLUGIN_BUILD}
        Procedure SetString(Const Value: String); // new fnc for wx
    {$ENDIF}
        Function GetWordAtCursor: String;
        Procedure SetErrorFocus(Const Col, Line: Integer);
        Procedure SetActiveBreakpointFocus(Const Line: Integer);
        Procedure RemoveBreakpointFocus;
        Procedure UpdateCaption(NewCaption: String);
        Procedure InsertDefaultText;
        Procedure PaintMatchingBrackets(TransientType: TTransientType);

        Procedure CommentSelection;
        Procedure UncommentSelection;
        Procedure IndentSelection;
        Procedure UnindentSelection;

        Procedure UpdateParser; // Must be called after recreating the parser
        //////// CODE-COMPLETION - mandrav /////////////
        Procedure ReconfigCompletion;
        //////// CODE-COMPLETION - mandrav /////////////

        Property FileName: String Read fFileName Write SetFileName;
        Property InProject: Boolean Read fInProject Write fInProject;
        Property New: Boolean Read fNew Write fNew;
        Property Modified: Boolean Read GetModified Write SetModified;
        Property IsRes: Boolean Read fRes Write fRes;
        Property Text: TSynEdit Read fText Write fText;
        Property TabSheet: TTabSheet Read fTabSheet Write fTabSheet;
        Property AssignedPlugin: String Read fPlugin Write fPlugin;

        Property CodeToolTip: TDevCodeToolTip Read FCodeToolTip;
        // added on 23rd may 2004 by peter_

    End;

Implementation

Uses
    Main, project, MultiLangSupport, devcfg, Search_Center, datamod,
    GotoLineFrm, Macros, debugger;

{ TDebugGutter }

Constructor TDebugGutter.Create(ed: TEditor);
Begin
    Inherited Create(ed.Text);
    fEditor := ed;
End;

Procedure TDebugGutter.AfterPaint(ACanvas: TCanvas; Const AClip: TRect;
    FirstLine, LastLine: Integer);
Begin
    fEditor.DrawGutterImages(ACanvas, AClip, FirstLine, LastLine);
End;

Procedure TDebugGutter.LinesInserted(FirstLine, Count: Integer);
Begin
    // if this method is not defined -> Abstract error
End;

Procedure TDebugGutter.LinesDeleted(FirstLine, Count: Integer);
//     AddToUndoList: boolean);
Begin
    // if this method is not defined -> Abstract error
End;

{ TEditor }

Procedure TEditor.Init(In_Project: Boolean; Caption_, File_name: String;
    DoOpen: Boolean; Const IsRes: Boolean = False);
Var
    s: String;
    pt: TPoint;
    allowChange: Boolean;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
    pluginCatched: Boolean;
    pluginTextHighlighterType: String;
{$ENDIF}
Begin
    fModified := False;
    fErrorLine := -1;
    fActiveLine := -1;
    fRunToCursorLine := -1;
    fRes := IsRes;
    fInProject := In_Project;
    flastStartParenthesis := -1;
    fLastParamFunc := Nil;
    If File_name = '' Then
        fFileName := Caption_
    Else
        fFileName := File_name;

    fTabSheet := TTabSheet.Create(MainForm.PageControl);
    fTabSheet.Caption := Caption_;
    fTabSheet.PageControl := MainForm.PageControl;
    fTabSheet.TabVisible := False;
    // This is to have a pointer to the TEditor using the PageControl in MainForm
    fTabSheet.Tag := Integer(self);

    fText := TSynEdit.Create(fTabSheet);
    fText.Parent := fTabSheet;
{$IFDEF PLUGIN_BUILD}
    pluginCatched := False;
    fPlugin := '';
    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin
        If MainForm.plugins[i].isForm(File_name) Then
        Begin
            MainForm.plugins[i].InitEditor(File_name);
            AssignedPlugin := MainForm.plugins[i].GetPluginName;
            pluginCatched := True;
            break;
        End;
    End;
    If Not pluginCatched Then
        fText.Align := alClient;
{$ELSE}
  fText.Align := alClient;
{$ENDIF}

    If (DoOpen) Then
        Try
            fText.Lines.LoadFromFile(FileName);
            fNew := False;
            If devData.Backups Then // create a backup of the file
            Begin
                s := ExtractfileExt(FileName);
                insert('~', s, pos('.', s) + 1);
                delete(s, length(s) - 1, 1);
                If devEditor.AppendNewline Then
                    With fText Do
                        If Lines.Count > 0 Then
                            If Lines[Lines.Count - 1] <> '' Then
                                Lines.Add('');


                fText.Lines.SaveToFile(ChangeFileExt(FileName, s));
            End;

        Except
            Raise;
        End
    Else
        fNew := True;

    fText.Visible := True;

    fDebugHintTimer := TTimer.Create(Application);
    fDebugHintTimer.Interval := 1000;
    fDebugHintTimer.OnTimer := DebugHintTimer;
    fDebugHintTimer.Enabled := False;

    fToolTipTimer := TTimer.Create(Application);
    fToolTipTimer.Interval := 100;
    fToolTipTimer.OnTimer := ToolTipTimer;
    fToolTipTimer.Enabled := False;

    fText.PopupMenu := MainForm.EditorPopupMenu;
    fText.Font.Color := clWindowText;
    fText.Color := clWindow;
    fText.Font.Name := 'Courier';
    fText.Font.Size := 10;
    fText.WantTabs := True;
    fText.OnStatusChange := EditorStatusChange;
    fText.OnSpecialLineColors := EditorSpecialLineColors;
    fText.OnGutterClick := EditorGutterClick;
    fText.OnReplaceText := EditorReplaceText;
    fText.OnDropFiles := EditorDropFiles;
    fText.OnDblClick := EditorDblClick;
    fText.OnMouseDown := EditorMouseDown;
    fText.OnPaintTransient := EditorPaintTransient;
    fText.OnKeyPress := CodeRushLikeEditorKeyPress;
    fText.OnScroll := EditorOnScroll;

    fText.MaxScrollWidth := 4096; // bug-fix #600748
    fText.MaxUndo := 4096;

    devEditor.AssignEditor(fText);
    If Not fNew Then
        fText.Highlighter := dmMain.GetHighlighter(fFileName)
    Else
    If fRes Then
        fText.Highlighter := dmMain.Res
    Else
        fText.Highlighter := dmMain.cpp;

    // Code folding
   // fText.InitCodeFolding;

{$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin
        If MainForm.plugins[i].isForm(File_name) Then
        Begin
            If Not MainForm.plugins[i].EditorDisplaysText(File_name) Then
            Begin
                fText.ReadOnly := True;
                fText.Visible := False;
            End;

            pluginTextHighlighterType :=
                MainForm.plugins[i].GetTextHighlighterType(File_name);
            If pluginTextHighlighterType = 'NEW' Then
                fText.Highlighter := dmMain.GetHighlighter(fFileName)
            Else
            If pluginTextHighlighterType = 'RES' Then
                fText.Highlighter := dmMain.Res
            Else
            If pluginTextHighlighterType = 'XML' Then
                fText.Highlighter := dmMain.XML
            Else
                fText.Highlighter := dmMain.cpp;
        End;
    End;
{$ENDIF}

    // update the selected text color
    StrtoPoint(pt, devEditor.Syntax.Values[cSel]);
    fText.SelectedColor.Background := pt.X;
    fText.SelectedColor.Foreground := pt.Y;

    // select the new editor
    MainForm.PageControl.OnChanging(MainForm.PageControl, allowChange);
    fTabSheet.PageControl.ActivePage := fTabSheet;
    fTabSheet.TabVisible := True;

    fDebugGutter := TDebugGutter.Create(self);
    Application.ProcessMessages;
    InitCompletion;

    fFunctionArgs := TSynCompletionProposal.Create(fText);
    With fFunctionArgs Do
    Begin
        EndOfTokenChr := '';

        // we dont need triggerchars here anymore, because the tooltips
        // are handled by FCodeToolTip now
        TriggerChars := '';
        TimerInterval := devCodeCompletion.Delay;
        DefaultType := ctParams;
        OnExecute := FunctionArgsExecute;
        Editor := fText;
        Options := Options + [scoUseBuiltInTimer];
{$IFDEF WIN32}
        ShortCut := Menus.ShortCut(Word(VK_SPACE), [ssCtrl, ssShift]);
{$ENDIF}
    End;

    // create the codetooltip
    FCodeToolTip := TDevCodeToolTip.Create(Application);
    FCodeToolTip.Editor := FText;
    FCodeToolTip.Parser := MainForm.CppParser1;
    FCodeToolTip.DropShadow := True;

    // The Editor must have 'Auto Indent' activated  to use FAutoIndent.
    // It's under Tools | Editor Options and then the General tab
    FAutoIndent := TSynAutoIndent.Create(Application);
    FAutoIndent.Editor := FText;
    FAutoIndent.IndentChars := '{:';
    FAutoIndent.UnIndentChars := '}';
    fText.OnMouseMove := EditorMouseMove;

    // monitor this file for outside changes
    MainForm.devFileMonitor.Files.Add(fFileName);
    MainForm.devFileMonitor.Refresh(False);

    // set any breakpoints that should be set in this file
    SetBreakPointsOnOpen;

    MainForm.ToggleExecuteMenu(True);

End;

Destructor TEditor.Destroy;
Var
    idx: Integer;
    lastActPage: Integer;
Begin
    idx := MainForm.devFileMonitor.Files.IndexOf(fFileName);
    If idx <> -1 Then
    Begin
        // do not monitor this file for outside changes anymore
        MainForm.devFileMonitor.Files.Delete(idx);
        MainForm.devFileMonitor.Refresh(False);
    End;

    If Assigned(fDebugHintTimer) Then
    Begin
        fDebugHintTimer.Enabled := False;

        If Assigned(fDebugHintTimer) Then
            FreeAndNil(fDebugHintTimer)
        Else
            fDebugHintTimer := Nil;
    End;

    If Assigned(fToolTipTimer) Then
    Begin
        fToolTipTimer.Enabled := False;
        If Assigned(fToolTipTimer) Then
            FreeAndNil(fToolTipTimer)
        Else
            fToolTipTimer := Nil;
    End;

    DestroyCompletion;

    If Assigned(fText) Then
        FreeAndNil(fText)
    Else
        fText := Nil;

    //this activates the previous tab if the last one was
    //closed, instead of moving to the first one
    If Assigned(fTabSheet) Then
    Begin

        With fTabSheet.PageControl Do
        Begin
            lastActPage := ActivePageIndex;

            If Assigned(fTabSheet) Then
                FreeAndNil(fTabSheet)
            Else
                fTabSheet := Nil;

            If lastActPage >= PageCount Then
            Begin
                Dec(lastActPage);
                If (lastActPage > 0) And (lastActPage < PageCount) Then
                    ActivePageIndex := lastActPage;
            End;
        End;
    End;

    If Assigned(FCodeToolTip) Then
        FreeAndNil(FCodeToolTip)
    Else
        FCodeToolTip := Nil;

    If Assigned(FAutoIndent) Then
        FreeAndNil(FAutoIndent)
    Else
        FAutoIndent := Nil;

    Inherited;
End;

Procedure TEditor.Activate;
Var
    Allow: Boolean;
{$IFDEF PLUGIN_BUILD}
   // i: Integer;
    //pluginCatched: Boolean;
{$ENDIF}
Begin
    If assigned(fTabSheet) Then
    Begin
        //Broadcast the page change event
        fTabSheet.PageControl.OnChanging(fTabSheet.PageControl, Allow);

        //Then do the actual changing
        fTabSheet.PageControl.Show;
        fTabSheet.PageControl.ActivePage := fTabSheet;
        If fText.Visible Then
            fText.SetFocus;

        //Call the post-change event handler
        If MainForm.ClassBrowser1.Enabled {$IFDEF PLUGIN_BUILD} Or
            (AssignedPlugin <> '') {$ENDIF} Then
            MainForm.PageControl.OnChange(MainForm.PageControl);
        // this makes sure that the classbrowser is consistent

        MainForm.ToggleExecuteMenu(True);

    End;
End;

Function TEditor.GetModified: Boolean;
Var
    boolFTextModified: Boolean;
Begin
    boolFTextModified := False;
    If assigned(fText) Then
        boolFTextModified := fText.Modified;
    result := fModified Or boolFTextModified;
End;

Procedure TEditor.SetModified(value: Boolean);
Begin
    fModified := value;
    fText.Modified := Value;
End;

// RNC 07-21-04 These functions are used to turn off/on a breakpoint
// without calling RemoveBreakpoint or AddBreakpoint in fDebugger.
// This is helpful when trying to automitically remove a breakpoint
// when a user tries to add one while the debugger is running
Procedure TEditor.InsertBreakpoint(line: Integer);
Begin
    If (line > 0) And (line <= fText.Lines.Count) Then
    Begin
        fText.InvalidateLine(line);
        fText.InvalidateGutterLine(line);
    End;
End;

Procedure TEditor.RemoveBreakpoint(line: Integer);
Begin
    If (line > 0) And (line <= fText.Lines.Count) Then
    Begin
        fText.InvalidateLine(line);
        // RNC new synedit stuff
        fText.InvalidateGutterLine(line);
    End;
End;


// RNC -- 07-02-2004
// I added methods to turn a breakpoint on or off.  Sometimes run to cursor
// got confused and by toggling a breakpoint was turning something on that should
// have been turned off.  By using these functions to explicitly turn on or turn
// off a breakpoint, this cannot happen
Procedure TEditor.TurnOnBreakpoint(line: Integer);
Begin
    If (line > 0) And (line <= fText.Lines.Count) Then
    Begin
        fText.InvalidateLine(line);
        fText.InvalidateGutterLine(line);
        MainForm.AddBreakPointToList(line, self);
    End;
End;

Procedure TEditor.TurnOffBreakpoint(line: Integer);
Begin
    If (line > 0) And (line <= fText.Lines.Count) Then
    Begin
        fText.InvalidateLine(line);
        fText.InvalidateGutterLine(line);
        MainForm.RemoveBreakPointFromList(line, self);
    End;
End;

//RNC function to set breakpoints in a file when it is opened
Procedure TEditor.SetBreakPointsOnOpen;
Var
    i: Integer;
Begin
    For i := 0 To debugger.Breakpoints.Count - 1 Do
        If PBreakpoint(debugger.Breakpoints.Items[i])^.Filename =
            fFilename Then
        Begin
            InsertBreakpoint(PBreakpoint(debugger.Breakpoints.Items[i])^.Line);
            PBreakpoint(debugger.Breakpoints.Items[i])^.Editor := self;
        End;
End;

Procedure TEditor.Close;
Begin
    fText.OnStatusChange := Nil;
    fText.OnSpecialLineColors := Nil;
    fText.OnGutterClick := Nil;
    fText.OnReplaceText := Nil;
    fText.OnDropFiles := Nil;
    fText.OnDblClick := Nil;
    fText.OnMouseDown := Nil;
    fText.OnPaintTransient := Nil;
    fText.OnKeyPress := Nil;

{$IFDEF PLUGIN_BUILD}
    If AssignedPlugin <> '' Then
        MainForm.plugins[MainForm.unit_plugins[AssignedPlugin]].TerminateEditor(
            FileName);
{$ENDIF}
    Try
        Free;
    Except
    End;
End;

Function TEditor.ToggleBreakpoint(Line: Integer): Boolean;
Begin
    result := False;
    If (line > 0) And (line <= fText.Lines.Count) Then
    Begin
        fText.InvalidateGutterLine(line);
        fText.InvalidateLine(line);

        //RNC moved the check to see if the debugger is running to here
        If HasBreakPoint(Line) <> -1 Then
            MainForm.RemoveBreakPointFromList(line, self)
        Else
            MainForm.AddBreakPointToList(line, self);
    End
    Else
        fText.Invalidate;
End;

Function TEditor.HasBreakPoint(line_number: Integer): Integer;
Begin
    For Result := 0 To debugger.Breakpoints.Count - 1 Do
        If PBreakpoint(debugger.Breakpoints.Items[Result])^.Editor = self Then
            If PBreakpoint(debugger.Breakpoints.Items[result])^.Line =
                line_number Then
                Exit;

    //Cannot find an entry
    Result := -1;
End;

Procedure TEditor.EditorSpecialLineColors(Sender: TObject; Line: Integer;
    Var Special: Boolean; Var FG, BG: TColor);
Var
    pt: TPoint;
Begin
    If (Line = fActiveLine) Then
    Begin
        StrtoPoint(pt, devEditor.Syntax.Values[cABP]);
        BG := pt.X;
        FG := pt.Y;
        Special := True;
    End
    Else
    If (HasBreakpoint(line) <> -1) Then
    Begin
        StrtoPoint(pt, devEditor.Syntax.Values[cBP]);
        BG := pt.x;
        FG := pt.y;
        Special := True;
    End
    Else
    If Line = fErrorLine Then
    Begin
        StrtoPoint(pt, devEditor.Syntax.Values[cErr]);
        bg := pt.x;
        fg := pt.y;
        Special := True;
    End;
End;

// ** undo after insert removes all text above insert point;
// ** seems to be a synedit bug!!
Procedure TEditor.EditorDropFiles(Sender: TObject; x, y: Integer;
    aFiles: TStrings);
Var
    sl: TStringList;
    idx, idx2: Integer;
Begin
    If devEditor.InsDropFiles Then
    Begin
        fText.CaretXY := fText.DisplayToBufferPos(
            fText.PixelsToRowColumn(x, y));

        sl := TStringList.Create;
        Try
            For idx := 0 To pred(aFiles.Count) Do
            Begin
                sl.LoadFromFile(aFiles[idx]);
                fText.SelText := sl.Text;
            End;
        Finally
            sl.Free;
        End;
    End
    Else
        For idx := 0 To pred(aFiles.Count) Do
        Begin
            idx2 := MainForm.FileIsOpen(aFiles[idx]);
            If idx2 = -1 Then
                If GetFileTyp(aFiles[idx]) = utPrj Then
                Begin
                    MainForm.OpenProject(aFiles[idx]);
                    exit;
                End
                Else
                    MainForm.OpenFile(aFiles[idx])
            Else
                TEditor(MainForm.PageControl.Pages[idx2].Tag).Activate;
        End;
End;

Procedure TEditor.EditorDblClick(Sender: TObject);
Begin
    If devEditor.DblClkLine Then
    Begin
        fText.BlockBegin := BufferCoord(1, fText.CaretY);
        fText.BlockEnd := BufferCoord(1, fText.CaretY + 1);
    End;
End;

Procedure TEditor.EditorGutterClick(Sender: TObject; Button: TMouseButton;
    x, y, Line: Integer; mark: TSynEditMark);
Begin
    ToggleBreakPoint(Line);
End;

Procedure TEditor.EditorReplaceText(Sender: TObject; Const aSearch,
    aReplace: String; Line, Column: Integer; Var Action: TSynReplaceAction);
Var
    pt: TPoint;
Begin
    If SearchCenter.SingleFile Then
    Begin
        If aSearch = aReplace Then
        Begin
            fText.CaretXY := BufferCoord(Column, Line + 1);
            action := raSkip;
        End
        Else
        Begin
            pt := fText.ClienttoScreen(fText.RowColumnToPixels(
                DisplayCoord(Column, Line + 1)));

            MessageBeep(MB_ICONQUESTION);
            Case MessageDlgPos(format(Lang[ID_MSG_SEARCHREPLACEPROMPT],
                    [aSearch]),
                    mtConfirmation, [mbYes, mbNo, mbCancel, mbAll],
                    0, pt.x, pt.y) Of
                mrYes:
                    action := raReplace;
                mrNo:
                    action := raSkip;
                mrCancel:
                    action := raCancel;
                mrAll:
                    action := raReplaceAll;
            End;
        End;
    End;
End;

Procedure TEditor.EditorStatusChange(Sender: TObject;
    Changes: TSynStatusChanges);
Begin
    If scModified In Changes Then
    Begin
        If Modified Then
            UpdateCaption('[*] ' + ExtractfileName(fFileName))
        Else
            UpdateCaption(ExtractfileName(fFileName));
    End;
    With MainForm.Statusbar Do
    Begin
        If Changes * [scAll, scCaretX, scCaretY] <> [] Then
        Begin
            Panels[0].Text :=
                format('%6d: %-4d', [fText.DisplayY, fText.DisplayX]);
            If Not fErrSetting And (fErrorLine <> -1) Then
            Begin
                fText.InvalidateLine(fErrorLine);
                fText.InvalidateGutterLine(fErrorLine);
                fErrorLine := -1;
                fText.InvalidateLine(fErrorLine);
                fText.InvalidateGutterLine(fErrorLine);
                Application.ProcessMessages;
            End;
        End;
        If Changes * [scAll, scModified] <> [] Then
            If fText.Modified Then
                Panels[1].Text := Lang[ID_MODIFIED]
            Else
                Panels[1].Text := '';
        If fText.ReadOnly Then
            Panels[2].Text := Lang[ID_READONLY]
        Else
        If fText.InsertMode Then
            Panels[2].Text := Lang[ID_INSERT]
        Else
            Panels[2].Text := Lang[ID_OVERWRITE];
        Panels[3].Text := format(Lang[ID_LINECOUNT], [fText.Lines.Count]);
    End;

    If Not devData.NoToolTip Then
    Begin
        // GAR Deactivate timer
        If (scCaretX In Changes) Or (scCaretY In Changes) Then
            If assigned(FCodeToolTip) And FCodeToolTip.Enabled Then
            Begin
                fToolTipTimer.Enabled := False;
                fToolTipTimer.Enabled := True;
            End;
    End;

End;

Procedure TEditor.ToolTipTimer(Sender: TObject);
Var
    startParenthesis: Integer;

    Function Max(a, b: Integer): Integer;
    Begin
        If a > b Then
            Result := a
        Else
            Result := b;
    End;

    Function FindStart: Integer;
    Var
        FillingParameter: Boolean;
        Brackets: Integer;
        I: Integer;
    Begin
        //Give the current selection index, we need to find the start of the function
        FillingParameter := False;
        I := FText.SelStart;
        Brackets := -1;
        Result := -1;

        //Make sure the offset is valid
        If I > Length(FText.Text) Then
            Exit;

        While I > 0 Do
        Begin
            If (I < 0) Then
                break;
            Case FText.Text[I] Of
                ')':
                    Dec(Brackets);
                '(':
                Begin
                    Inc(Brackets);
                    If Brackets = 0 Then
                    Begin
                        Result := I;
                        Exit;
                    End;
                End;
                #10, #13:
                    //Make sure we are not within a function call
                    If Not FillingParameter Then
                    Begin
                        //Skip whitespace so we can see what is the last character
                        While (I > 1) And (FText.Text[I - 1] In
                                [#10, #13, #9, ' ']) Do
                            Dec(I); //Previous character is whitespace, skip it

                        //Is the character a comma or an opening parenthesis?
                        If I > 2 Then
                            If Not (FText.Text[I - 1] In [',', '(']) Then
                                Exit;
                    End;
                '{', '}':
                    Exit;
                ',':
                    FillingParameter := True;
            Else
                FillingParameter := False;
            End;

            Dec(I);
        End;
    End;
Begin
    // stop the timer so we don't recurse
    fToolTipTimer.Enabled := False;
    startParenthesis := FindStart;

    // check if the last parenthesis selected is the same one as the one we
    // have now. Otherwise, we should get rid of the tooltip
    If startParenthesis <> flastStartParenthesis Then
        FCodeToolTip.ReleaseHandle;

    // when the hint is already activated when call ShowHint again, because the
    //current argument could have been changed, so we need to make another arg in bold
    If FCodeToolTip.Activated Then
        FCodeToolTip.Show
    Else
    // it's not showing yet, so we check if the cursor
    // is in the bracket and when it is, we show the hint.
    If assigned(FText) And (Not FText.SelAvail) And (FText.SelStart > 1) And
        (startParenthesis <> -1) Then
        FCodeToolTip.Show;

    // cache the current parenthesis index so that we can check if we
    // have changed since we first displayed it
    flastStartParenthesis := startParenthesis;
End;

Procedure TEditor.EditorOnScroll(Sender: TObject; ScrollBar: TScrollBarKind);
Begin
    If assigned(FCodeToolTip) And (FCodeToolTip.Caption <> '') And
        FCodeToolTip.Activated Then
        FCodeToolTip.RethinkCoordAndActivate;
End;

Procedure TEditor.ExportTo(Const isHTML: Boolean);
Begin
    If IsHTML Then
    Begin
        With dmMain.SaveDialog Do
        Begin
            Filter := dmMain.SynExporterHTML.DefaultFilter;
            DefaultExt := HTML_EXT;
            Title := Lang[ID_NV_EXPORT];
            If Execute Then
            Begin
                dmMain.ExportToHtml(fText.Lines, dmMain.SaveDialog.FileName);
                fText.BlockEnd := fText.BlockBegin;
            End;
        End;
    End
    Else
        With dmMain.SaveDialog Do
        Begin
            Filter := dmMain.SynExporterRTF.DefaultFilter;
            Title := Lang[ID_NV_EXPORT];
            DefaultExt := RTF_EXT;
            If Execute Then
            Begin
                dmMain.ExportToRtf(fText.Lines, dmMain.SaveDialog.FileName);
                fText.BlockEnd := fText.BlockBegin;
            End;
        End;
End;

Function TEditor.GetWordAtCursor: String;
Begin
    If AssignedPlugin <> '' Then
        result := MainForm.plugins[MainForm.unit_plugins[AssignedPlugin]].GetContextForHelp
    Else
        result := fText.GetWordAtRowCol(fText.CaretXY);
End;

{** Modified by Peter **}
Procedure TEditor.GotoLine;
Var
    GotoForm: TGotoLineForm;
Begin
    GotoForm := TGotoLineForm.Create(FText);
    Try
        GotoForm.Editor := FText;

        If GotoForm.ShowModal = mrOK Then
            FText.CaretXY := BufferCoord(FText.CaretX, GotoForm.Line.Value);

        Activate;
    Finally
        GotoForm.Free;
    End;
End;

Procedure TEditor.SetString(Const Value: String);
Begin
    If Not assigned(fText) Then
        Exit;
    fText.Lines.Text := Value;
End;

Procedure TEditor.InsertString(Const Value: String; Const move: Boolean);
Var
    Line: String;
    idx,
    idx2: Integer;
    pt: TBufferCoord;
    tmp: TStringList;
Begin
    If Not assigned(fText) Then
        exit;
    pt := fText.CaretXY;
    tmp := TStringList.Create;
    Try // move cursor to pipe '|'
        tmp.Text := Value;
        If Move Then
            For idx := 0 To pred(tmp.Count) Do
            Begin
                Line := tmp[idx];
                idx2 := AnsiPos('|', Line);
                If idx2 > 0 Then
                Begin
                    delete(Line, idx2, 1);
                    tmp[idx] := Line;

                    inc(pt.Line, idx);
                    If idx = 0 Then
                        inc(pt.Char, idx2 - 1)
                    Else
                        pt.Char := idx2;

                    break;
                End;
            End;
        Line := tmp.Text;
        fText.SelText := Line;
        fText.CaretXY := pt;
        fText.EnsureCursorPosVisible;
    Finally
        tmp.Free;
    End;
End;

Function TEditor.Search(Const isReplace: Boolean): Boolean;
Var
    s: String;
Begin
    If devEditor.FindText Then
        If (fText.SelText = '') Then
            s := GetWordAtCursor
        Else
            s := fText.SelText;

    With SearchCenter Do
    Begin
        FindText := s;
        Replace := IsReplace;
        ReplaceText := '';
        SingleFile := True;
        Editor := Self;
        Result := ExecuteSearch And Not SingleFile;
        // if changed to "find in all files", open find results
    End;
    Activate;
End;

Procedure TEditor.SearchAgain;
Var
    Options: TSynSearchOptions;
    return: Integer;
Begin
    SearchCenter.Editor := Self;
    SearchCenter.AssignSearchEngine;

    If Not SearchCenter.SingleFile Then
        exit;
    If SearchCenter.FindText = '' Then
    Begin
        Search(False);
        exit;
    End;
    Options := SearchCenter.Options;
    Exclude(Options, ssoEntireScope);

    return := fText.SearchReplace(SearchCenter.FindText,
        SearchCenter.ReplaceText,
        Options);
    If return <> 0 Then
        Activate
    Else
        MessageDlg(format(Lang[ID_MSG_TEXTNOTFOUND], [SearchCenter.FindText]),
            mtInformation, [mbOk], 0);
End;

Procedure TEditor.SearchKeyNavigation(MoveForward: Boolean);
Var
    Options: TSynSearchOptions;
    return, MidCursorPos: Integer;
    s: String;
    bSelected: Boolean;
Begin
    bSelected := False;
    If (fText.SelText = '') Then
        s := GetWordAtCursor
    Else
    Begin
        s := fText.SelText;
        bSelected := True;
    End;

    SearchCenter.Editor := Self;
    SearchCenter.AssignSearchEngine;
    SearchCenter.FindText := s;

    If Not SearchCenter.SingleFile Then
        exit;
    If SearchCenter.FindText = '' Then
    Begin
        exit;
    End;
    Options := SearchCenter.Options;
    Exclude(Options, ssoEntireScope);

    If (MoveForward) Then
        Exclude(Options, ssoBackwards)
    Else
        Include(Options, ssoBackwards);

    return := fText.SearchReplace(SearchCenter.FindText,
        SearchCenter.ReplaceText, Options);
    If bSelected = False Then
    Begin
        If fText.SelEnd - fText.SelStart <> 1 Then
        Begin
            MidCursorPos :=
                fText.SelEnd - ((fText.SelEnd - fText.SelStart) Div 2);
            fText.SelStart := MidCursorPos;
            fText.SelEnd := MidCursorPos;
        End;
    End;

    If return <> 0 Then
        Activate;
End;

Procedure TEditor.SetErrorFocus(Const Col, Line: Integer);
Begin
    fErrSetting := True;
    Application.ProcessMessages;
    If fErrorLine <> Line Then
    Begin
        If fErrorLine <> -1 Then
            fText.InvalidateLine(fErrorLine);
        fText.InvalidateGutterLine(fErrorLine);
        fErrorLine := Line;
        fText.InvalidateLine(fErrorLine);
        fText.InvalidateGutterLine(fErrorLine);
    End;
    fText.CaretXY := BufferCoord(col, line);
    fText.EnsureCursorPosVisible;
    fErrSetting := False;
End;

Procedure TEditor.SetActiveBreakpointFocus(Const Line: Integer);
Begin
    If (fActiveLine <> Line) And (fActiveLine <> -1) Then
        fText.InvalidateLine(fActiveLine);
    fText.InvalidateGutterLine(fActiveLine);
    fActiveLine := Line;
    fText.InvalidateLine(fActiveLine);
    fText.InvalidateGutterLine(fActiveLine);
    fText.CaretY := Line;
    fText.EnsureCursorPosVisible;

    If fRunToCursorLine <> -1 Then
    Begin
        TurnOffBreakpoint(fRunToCursorLine);
        fRunToCursorLine := -1;
    End;
End;

Procedure TEditor.RemoveBreakpointFocus;
Begin
    If fActiveLine <> -1 Then
        fText.InvalidateLine(fActiveLine);
    fText.InvalidateGutterLine(fActiveLine);
    fActiveLine := -1;
End;

Procedure TEditor.UpdateCaption(NewCaption: String);
Begin
    If assigned(fTabSheet) Then
        fTabSheet.Caption := NewCaption;
End;

Procedure TEditor.SetFileName(value: String);
Begin
    If value <> fFileName Then
    Begin
        ffileName := value;
        UpdateCaption(ExtractfileName(fFileName));
    End;
End;

Procedure TEditor.DrawGutterImages(ACanvas: TCanvas; AClip: TRect;
    FirstLine, LastLine: Integer);
Var
    LH, X, Y: Integer;
    ImgIndex: Integer;
    BreakpointIdx: Integer;

    Function IsValidBreakpoint(Breakpoint: Integer): Boolean;
    Var
        BP: PBreakpoint;
    Begin
        BP := PBreakpoint(debugger.Breakpoints[Breakpoint]);
        Result := Bp^.Valid;
    End;
Begin
    X := 14;
    LH := fText.LineHeight;
    Y := (LH - dmMain.GutterImages.Height) Div 2
        + LH * (FirstLine - fText.TopLine);

    While FirstLine <= LastLine Do
    Begin
        BreakpointIdx := HasBreakpoint(FirstLine);
        If BreakpointIdx <> -1 Then
        Begin
            If (Not MainForm.fDebugger.Executing) Or
                IsValidBreakpoint(BreakpointIdx) Then
                ImgIndex := 0
            Else
                ImgIndex := 3;
        End
        Else
        If fActiveLine = FirstLine Then
            ImgIndex := 1
        Else
        If fErrorLine = FirstLine Then
            ImgIndex := 2
        Else
            ImgIndex := -1;
        If ImgIndex >= 0 Then
            dmMain.GutterImages.Draw(ACanvas, X, Y, ImgIndex);
        Inc(FirstLine);
        Inc(Y, LH);
    End;
End;

Procedure TEditor.InsertDefaultText;
Var
    tmp: TStrings;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
    isForm: Boolean;
    hasDesigner: Boolean;
    tempText: String;
{$ENDIF}
Begin
{$IFDEF PLUGIN_BUILD}
    isForm := False;
    For i := 0 To MainForm.pluginsCount - 1 Do
        isForm := isForm Or MainForm.plugins[i].IsForm(FileName);
    If Not isForm Then
    Begin
{$ENDIF}
        If FileExists(devDirs.Config + DEV_DEFAULTCODE_FILE) Then
        Begin
            tmp := TStringList.Create;
            Try
                tmp.LoadFromFile(devDirs.Config + DEV_DEFAULTCODE_FILE);
                InsertString(ParseMacros(tmp.Text), False);
            Finally
                tmp.Free;
            End;
        End;
  {$IFDEF PLUGIN_BUILD}
    End
    Else
    Begin
        hasDesigner := False;
        For i := 0 To MainForm.pluginsCount - 1 Do
            hasDesigner := hasDesigner Or
                MainForm.plugins[i].HasDesigner(FileName);
        If hasDesigner Then
        Begin
            //I dont know how to make the editor to modified stated;
            //so I'm using the InsertString function
            InsertString(' ', False);
            tempText := '';
            For i := 0 To MainForm.pluginsCount - 1 Do
                tempText :=
                    tempText + MainForm.plugins[i].GetDefaultText(FileName);
            SetString(tempText);
        End;
    End;
  {$ENDIF}
End;

Procedure TEditor.GotoLineNr(Nr: Integer);
Begin
    fText.CaretXY := BufferCoord(1, Nr);
    fText.TopLine := Nr;
    Activate;
End;

Procedure TEditor.CodeRushLikeEditorKeyPress(Sender: TObject; Var Key: Char);
Var
    strComment: String;
Begin

    If fCompletionBox.Enabled Then
        Exit;

    //----------------------------------------------------------------------------
    //Guru: My Own CodeRush like Commentor :o)
    If fText.SelAvail Then
    Begin
        If (String(Key) = '/') And (trim(String(fText.SelText)) <> '') Then
        Begin
            Key := #0;
            strComment := '/* ' + fText.SelText + ' */';
            fText.SelText := strComment;
            Exit;
        End;
    End;
    //----------------------------------------------------------------------------
End;

//////// CODE-COMPLETION - mandrav /////////////
Procedure TEditor.EditorKeyPress(Sender: TObject; Var Key: Char);
Var
    P: TPoint;
Begin
    If Key = Char($7F) Then
        // happens when doing ctrl+backspace with completion on
        exit;
    If fCompletionBox.Enabled Then
    Begin
        If Not (Sender Is TForm) Then
        Begin // TForm is the code-completion window
            fTimer.Enabled := False;
            fTimerKey := Key;
            Case Key Of
                '.':
                    fTimer.Enabled := True;
                '>':
                    If (fText.CaretX > 1) And (Length(fText.LineText) > 0) And
                        (fText.LineText[fText.CaretX - 1] = '-') Then
                        fTimer.Enabled := True;
                ':':
                    If (fText.CaretX > 1) And (Length(fText.LineText) > 0) And
                        (fText.LineText[fText.CaretX - 1] = ':') Then
                        fTimer.Enabled := True;
                ' ':
                    If fCompletionEatSpace Then
                        Key := #0;
                // eat space if it was ctrl+space (code-completion)
            End;
            P := fText.RowColumnToPixels(fText.DisplayXY);
            P.Y := P.Y + 16;

            P := fText.ClientToScreen(P);
            fCompletionBox.Position := P;
        End
        Else
        Begin
            Case Key Of
{$IFDEF WIN32}
                Char(vk_Back):
                    If fText.SelStart > 0 Then
{$ENDIF}

                    Begin
                        fText.SelStart := fText.SelStart - 1;
                        fText.SelEnd := fText.SelStart + 1;
                        fText.SelText := '';
                        fCompletionBox.Search(Nil, CurrentPhrase, fFileName);
                    End;
{$IFDEF WIN32}
                Char(vk_Return):
{$ENDIF}

                Begin
                    SetEditorText(Key);
                    fCompletionBox.Hide;
                End;
                ';', '(':
                Begin
                    SetEditorText(Key);
                    fCompletionBox.Hide;
                End;
                '.', '>', ':':
                Begin
                    SetEditorText(Key);
                    fCompletionBox.Search(Nil, CurrentPhrase, fFileName);
                End;
            Else
                If Key >= ' ' Then
                Begin
                    fText.SelText := Key;
                    fCompletionBox.Search(Nil, CurrentPhrase, fFileName);
                End;
            End;
        End;
        fCompletionEatSpace := False;
    End;
End;

Procedure TEditor.EditorKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Var
    M: TMemoryStream;
Begin

    {** Modified by Peter **}
{$IFDEF WIN32}
    If Key = VK_TAB Then
{$ENDIF}

    Begin
        // Indent/Unindent selected text with TAB key, like Visual C++ ...
        If FText.SelText <> '' Then
        Begin
            If Not (ssShift In Shift) Then
                FText.ExecuteCommand(ecBlockIndent, #0, Nil)
            Else FText.ExecuteCommand(ecBlockUnindent, #0, Nil);
            Abort;
        End;
    End;

{$IFDEF GURUS_BUILD}
{$IFDEF WIN32}
  if (Key = VK_UP) or (Key = VK_DOWN) then
{$ENDIF}

  begin
    if (ssCtrl in Shift) and (ssAlt in Shift) then
    begin
      if Key = VK_UP then
        SearchKeyNavigation(false)
      else
        SearchKeyNavigation(true);
    end;
  end;
{$ENDIF}//GURUS_BUILD

    If Not Assigned(fCompletionBox) Then
        exit;

    If fCompletionBox.Enabled Then
    Begin
        fCompletionBox.OnKeyPress := EditorKeyPress;
        If ssCtrl In Shift Then
{$IFDEF WIN32}
            If Key = vk_Space Then
            Begin
{$ENDIF}
                Key := 0;
                If Not (ssShift In Shift) Then
                Begin
                    M := TMemoryStream.Create;
                    Try
                        fText.Lines.SaveToStream(M);
                        fCompletionBox.CurrentClass :=
                            MainForm.CppParser1.FindAndScanBlockAt(
                            fFileName, fText.CaretY, M);
                    Finally
                        M.Free;
                    End;
                    fCompletionBox.Search(Nil, CurrentPhrase, fFileName);
                End;
                fCompletionEatSpace := True;
                // this is a hack. without this after ctrl+space, the space appears in the editor :(
            End;
    End
    Else
    Begin
        fText.OnKeyPress := CodeRushLikeEditorKeyPress;
    End;
End;

Procedure TEditor.EditorKeyUp(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    fText.Cursor := crIBeam;
End;

Procedure TEditor.CompletionTimer(Sender: TObject);
Var
    M: TMemoryStream;
    curr: String;
Begin
    fTimer.Enabled := False;
    curr := CurrentPhrase;

    If Not CheckAttributes(BufferCoord(fText.CaretX - 1, fText.CaretY),
        curr) Then
    Begin
        fTimerKey := #0;
        Exit;
    End;

    M := TMemoryStream.Create;
    Try
        fText.Lines.SaveToStream(M);
        fCompletionBox.CurrentClass :=
            MainForm.CppParser1.FindAndScanBlockAt(fFileName, fText.CaretY, M);
    Finally
        M.Free;
    End;
    Case fTimerKey Of
        '.':
            fCompletionBox.Search(Nil, curr, fFileName);
        '>':
            If fText.CaretX - 2 >= 0 Then
                If fText.LineText[fText.CaretX - 2] = '-' Then
                    // it makes a '->'
                    fCompletionBox.Search(Nil, curr, fFileName);
        ':':
            If fText.CaretX - 2 >= 0 Then
                If fText.LineText[fText.CaretX - 2] = ':' Then
                    // it makes a '::'
                    fCompletionBox.Search(Nil, curr, fFileName);
    End;
    fTimerKey := #0;
End;

Procedure TEditor.ReconfigCompletion;
Begin
    // re-read completion options
    If Assigned(fCompletionBox) And Assigned(devClassBrowsing) And
        Assigned(devCodeCompletion) Then
    Begin

        fCompletionBox.Enabled :=
            devClassBrowsing.Enabled And devCodeCompletion.Enabled;
        If fCompletionBox.Enabled Then
            InitCompletion
        Else
            DestroyCompletion;

    End;

End;

Procedure TEditor.DestroyCompletion;
Begin
    If Assigned(fTimer) Then
        FreeAndNil(fTimer)
    Else
        fTimer := Nil;

End;

Procedure TEditor.InitCompletion;
Begin
    fCompletionBox := MainForm.CodeCompletion1;
    fCompletionBox.Enabled := devCodeCompletion.Enabled;
    fCompletionBox.OnCompletion := DoOnCodeCompletion;
    {** Modified by Peter **}

    If fCompletionBox.Enabled Then
    Begin
        fText.OnKeyPress := EditorKeyPress;
        fText.OnKeyDown := EditorKeyDown;
        fText.OnKeyUp := EditorKeyUp;
        fCompletionBox.OnKeyPress := EditorKeyPress;
        fCompletionBox.Width := devCodeCompletion.Width;
        fCompletionBox.Height := devCodeCompletion.Height;

        If fTimer = Nil Then
            fTimer := TTimer.Create(Nil);
        fTimer.Enabled := False;
        fTimer.OnTimer := CompletionTimer;
        fTimer.Interval := devCodeCompletion.Delay;
    End
    Else
    Begin
        fText.OnKeyPress := CodeRushLikeEditorKeyPress;
    End;
    fCompletionEatSpace := False;
End;

Function TEditor.CurrentPhrase: String;
Var
    I: Integer;
    AllowPar: Boolean;
    NestedPar: Integer;
Begin
    I := fText.CaretX;
    Dec(I, 1);
    NestedPar := 0;
    AllowPar := ((Length(fText.LineText) > 1) And
        (Copy(fText.LineText, I - 1, 2) = ').')) Or
        (Length(fText.LineText) > 2) And
        (Copy(fText.LineText, I - 2, 3) = ')->');
    While (I <> 0) And (fText.LineText <> '') And
        (fText.LineText[I] In ['A'..'Z', 'a'..'z', '0'..'9', '_', '.',
            '-', '>', ':', '(', ')', '[', ']', '~']) Do
    Begin
        If (fText.LineText[I] = ')') Then
            If Not AllowPar Then
                Break
            Else
                Inc(NestedPar)
        Else
        If fText.LineText[I] = '(' Then
            If AllowPar Then
                If NestedPar > 0 Then
                    Dec(NestedPar)
                Else
                    AllowPar := False
            Else
                Break;
        Dec(I, 1);
    End;

    //Since the current character is _invalid_ we need to increment it by one
    Inc(I);

    //If the string starts with a delimiter we should remove it
    While (I <= Length(fText.LineText)) And (fText.LineText[I] In
            ['.', '-', '>', ':', '(', ')', '[', ']']) Do
        Inc(I);

    //Then extract the relevant string
    Result := Copy(fText.LineText, I, fText.CaretX - I);
End;

Procedure TEditor.SetEditorText(Key: Char);
Var
    Phrase: String;
    I, CurrSel: Integer;
    ST: PStatement;
    FuncAddOn: String;
Begin
    ST := fCompletionBox.SelectedStatement;
    If fCompletionBox.SelectedIsFunction Then
    Begin
        If Key = ';' Then
            FuncAddOn := '();'
        Else
        If Key = '.' Then
            FuncAddOn := '().'
        Else
        If Key = '>' Then
            FuncAddOn := '()->'
{$IFDEF WIN32}
        Else
        If Key = Char(vk_Return) Then
{$ENDIF}

            FuncAddOn := '()'
        Else
            FuncAddOn := '(';
    End
    Else
    Begin
{$IFDEF WIN32}
        If Key = Char(vk_Return) Then
{$ENDIF}
            FuncAddOn := ''
        Else
        If Key = '>' Then
            FuncAddOn := '->'
        Else
        If Key = ':' Then
            FuncAddOn := '::'
        Else
            FuncAddOn := Key;
    End;

    If ST <> Nil Then
    Begin
        Phrase := ST^._Command;

        // if already has a selection, delete it
        If fText.SelAvail Then
            fText.SelText := '';

        // find the start of the word
        CurrSel := fText.SelStart;
        I := CurrSel;
        While (I <> 0) And (fText.Text[I] In
                ['A'..'Z', 'a'..'z', '0'..'9', '_']) Do
            Dec(I);
        fText.SelStart := I;
        fText.SelEnd := CurrSel;
        // don't add () if already there
        If fText.Text[CurrSel] = '(' Then
            FuncAddOn := '';

        fText.SelText := Phrase + FuncAddOn;

        // if we added "()" move caret inside parenthesis
        // only if Key<>'.' and Key<>'>'
        // and function takes arguments...
        If (Not (Key In ['.', '>'])) And (FuncAddOn <> '') And
            (Length(ST^._Args) > 2) Then
        Begin
            fText.CaretX := fText.CaretX - Length(FuncAddOn) + 1;
            fFunctionArgs.ExecuteEx(Phrase, fText.DisplayX,
                fText.DisplayY, ctParams);
        End;
    End;
End;

Function TEditor.CheckAttributes(P: TBufferCoord; Phrase: String): Boolean;
Var
    token: String;
    attri: TSynHighlighterAttributes;
Begin
    fText.GetHighlighterAttriAtRowCol(P, token, attri);
    Result := Not ((Not Assigned(Attri)) Or
        AnsiStartsStr('.', Phrase) Or
        AnsiStartsStr('->', Phrase) Or
        AnsiStartsStr('::', Phrase) Or
        (
        Assigned(Attri) And
        (
        (Attri.Name = 'Preprocessor') Or
        (Attri.Name = 'Comment') Or
        (Attri.Name = 'String')
        )
        ));
End;

//////// CODE-COMPLETION - mandrav - END ///////

// variable info
Procedure TEditor.EditorMouseMove(Sender: TObject; Shift: TShiftState;
    X, Y: Integer);
Var s, s1: String;
    IsArray: Boolean;
    p: TBufferCoord;
  	 I, j, slen: Integer;
    attr: TSynHighlighterAttributes;
Begin

    If Assigned(fDebugHintTimer) Then
        fDebugHintTimer.Enabled := False;

    //check if not comment or string
    //if yes - exit without hint
    p := fText.DisplayToBufferPos(fText.PixelsToRowColumn(X, Y));
    If fText.GetHighlighterAttriAtRowCol(p, s, attr) Then
        If (attr = fText.Highlighter.StringAttribute)
            Or (attr = fText.Highlighter.CommentAttribute) Then
        Begin
            fText.Hint := '';
            Exit;
        End;

    If devEditor.ParserHints And (Not MainForm.fDebugger.Executing) Then
    Begin // editing - show declaration of word under cursor in a hint
        p.Char := X;
        p.Line := Y;
        p := fText.DisplayToBufferPos(fText.PixelsToRowColumn(p.Char, p.Line));
        s := fText.GetWordAtRowCol(p);
    End
    Else
    If devData.WatchHint And MainForm.fDebugger.Executing Then
    Begin // debugging - evaluate var under cursor and show value in a hint
        p := fText.DisplayToBufferPos(fText.PixelsToRowColumn(X, Y));
        I := P.Char;
        s1 := fText.Lines[p.Line - 1];
        If (I <> 0) And (s1 <> '') Then
        Begin
            j := Length(s1);
            While (I < j) And (s1[I] In ['A'..'Z', 'a'..'z', '0'..'9', '_']) Do
                Inc(I);
        End;
        P.Char := I;
        Dec(I);

        If (s1 <> '') Then
        Begin
            IsArray := False;
            slen := Length(s1);
            While (slen >= I) And (I <> 0) And
                ((s1[I] In ['A'..'Z', 'a'..'z', '0'..'9', '_',
                    '.', '-', '>', '&', ']', '*'])
                    Or (s1[I] = '[') And IsArray) Do
            Begin
                If (s1[I] = ']') Then
                    IsArray := True;
                Dec(I, 1);
            End;
        End;
        s := Copy(s1, I + 1, p.Char - I - 1);
    End;

    If Not devData.NoToolTip Then
    Begin
        // GAR Disabled timer
        If (s <> '') And (Not fDebugHintTimer.Enabled) Then
        Begin
            fDebugHintTimer.Enabled := True;
            fCurrentHint := s;
        End
        Else
        If s = '' Then
            fText.Hint := '';
    End;

    If s <> '' Then
    Begin
        If ssCtrl In Shift Then
            fText.Cursor := crHandPoint
        Else
            fText.Cursor := crIBeam;
    End
    Else
        fText.Cursor := crIBeam;
End;

Procedure TEditor.DebugHintTimer(sender: TObject);
Var
    r: TRect;
    p: TPoint;
    st: PStatement;
    M: TMemoryStream;
Begin
    fDebugHintTimer.Enabled := False;
    p := fText.ScreenToClient(Mouse.CursorPos);
    // is the mouse still inside the editor?
    If (p.X <= 0) Or (p.X >= fText.Width) Or
        (p.Y <= 0) Or (p.Y >= fText.Height) Then
        Exit;

    If fCurrentHint <> '' Then
    Begin
        If Not MainForm.fDebugger.Executing Then
        Begin // editing - show declaration of word under cursor in a hint
            r.Left := Mouse.CursorPos.X;
            r.Top := Mouse.CursorPos.Y;
            r.Bottom := Mouse.CursorPos.Y + 10;
            r.Right := Mouse.CursorPos.X + 60;
            M := TMemoryStream.Create;
            Try
                fText.Lines.SaveToStream(M);
                MainForm.CppParser1.FindAndScanBlockAt(fFileName,
                    fText.PixelsToRowColumn(
                    fText.ScreenToClient(Mouse.CursorPos).X,
                    fText.ScreenToClient(Mouse.CursorPos).Y).Row, M)
            Finally
                M.Free;
            End;
            st := PStatement(MainForm.CppParser1.Locate(fCurrentHint, False));
            If Assigned(st) And (Not FCodeToolTip.Activated) Then
            Begin
                fCurrentHint := st^._FullText;
                fCompletionBox.ShowMsgHint(r, fCurrentHint);
            End;
        End
        Else
        If devData.WatchHint And MainForm.fDebugger.Executing Then
            // debugging - evaluate var under cursor and show value in a hint
        Begin
            MainForm.fDebugger.OnVariableHint := OnVariableHint;
            MainForm.fDebugger.GetVariableHint(fCurrentHint);
        End;
    End;
End;

Procedure TEditor.OnVariableHint(Hint: String);
Begin
    fText.Hint := Hint;
    fText.ShowHint := True;
    If Not FCodeToolTip.Activated Then
        Application.ActivateHint(Mouse.CursorPos);
End;

Procedure TEditor.CommentSelection;
Var
    S: String;
    Offset: Integer;
    backup: TBufferCoord;
Begin
    If Text.SelAvail Then
    Begin // has selection

        Text.BeginUndoBlock;

        backup := Text.CaretXY;

       { if (Text.CodeFolding.Enabled) then
         begin

              Text.UncollapsedLines.BeginUpdate;
         end
            else  }
          //  begin
        Text.BeginUpdate;
       // end;

        S := '//' + Text.SelText;
        Offset := 0;
        If S[Length(S)] = #10 Then
        Begin // if the selection ends with a newline, eliminate it
            If S[Length(S) - 1] = #13 Then // do we ignore 1 or 2 chars?
                Offset := 2
            Else
                Offset := 1;
            S := Copy(S, 1, Length(S) - Offset);
        End;
        S := StringReplace(S, #10, #10'//', [rfReplaceAll]);
        If Offset = 1 Then
            S := S + #10
        Else
        If Offset = 2 Then
            S := S + #13#10;
        Text.SelText := S;
       {  if (Text.CodeFolding.Enabled) then
         begin

              Text.UncollapsedLines.EndUpdate;
         end
            else
            begin }
        Text.EndUpdate;
       // end;
        Text.CaretXY := backup;
    End
    Else // no selection; easy stuff ;)
        Text.LineText := '//' + Text.LineText;

    Text.EndUndoBlock;
    Text.UpdateCaret;
    Text.Modified := True;

End;

{** Modified by Peter **}
Procedure TEditor.IndentSelection;
Begin
    If FText.SelAvail Then
    Begin
        FText.ExecuteCommand(ecBlockIndent, #0, Nil);
    End;
End;

{** Modified by Peter **}
Procedure TEditor.UnindentSelection;
Begin
    If FText.SelAvail Then
    Begin
        FText.ExecuteCommand(ecBlockUnIndent, #0, Nil);
    End;
End;

{** Modified by Peter **}
Procedure TEditor.UncommentSelection;

    Function FirstCharIndex(Const S: String): Integer;
        //  Get the index of the first non whitespace character in
        //  the string specified by S
        //  On success it returns the index, otherwise it returns 0
    Var
        I: Integer;
    Begin
        Result := 0;

        If S <> '' Then
            For I := 1 To Length(S) Do
                If Not (S[I] In [#0..#32]) Then
                Begin
                    Result := I;
                    Break;
                End;
    End;

Var
    S: String;
    I: Integer;
    Idx: Integer;
    Strings: TStringList;
Begin
    // has selection
    If Text.SelAvail Then
    Begin
        // start an undoblock, so we can undo
        // it afterwards!
        FText.BeginUndoBlock;

        Strings := TStringList.Create;
        Try
            Strings.Text := FText.SelText;

            If Strings.Count > 0 Then
            Begin
                For I := 0 To Strings.Count - 1 Do
                Begin
                    S := Strings.Strings[I];
                    Idx := FirstCharIndex(S);

                    // check if the very first two letters in the string are '//'
                    // if they are, then delete them from the string and set the
                    // modified string to the stringlist ...
                    If (Length(S) > Idx) And (S[Idx] = '/') And
                        (S[Idx + 1] = '/') Then
                    Begin
                        Delete(S, Idx, 2);
                        Strings.Strings[I] := S;
                    End;
                End;
            End;

            FText.SelText := Strings.Text;
        Finally
            Strings.Free;
        End;
        FText.EndUndoBlock;
        FText.UpdateCaret;
        FText.Modified := True;
    End;
End;


Procedure TEditor.EditorMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    Procedure DoOpen(Fname: String; Line: Integer; wrd: String);
    Var
        e: TEditor;
        ws: Integer;
    Begin
        If fname = ExtractFileName(fname) Then
            // no path info, so prepend path of active file
            fname := ExtractFilePath(fFileName) + fname;

        // refer to the editor of the filename (will open if needed and made active)
        e := MainForm.GetEditorFromFileName(fname);

        If Assigned(e) Then
        Begin
            // go to the specific line
            e.GotoLineNr(line);

            If wrd <> '' Then
            Begin
                // find the clicked word on this line and set the cursor on it ;)
                ws := AnsiPos(wrd, e.Text.LineText);
                If ws > 0 Then
                    e.Text.CaretX := ws;
            End;

            // remove any selection made by Synedit.OnMouseDown
            fText.BlockBegin := fText.CaretXY;
            fText.BlockEnd := fText.BlockBegin;
        End;
    End;
Var
    p: TPoint;
    s, s1: String;
    I: Integer;
    umSt: PStatement;
    fname: String;
    line: Integer;
    f1, f2: Integer;
Begin
    p.X := X;
    p.Y := Y;

    p.X := fText.PixelsToRowColumn(p.X, p.Y).Column;
    p.Y := fText.PixelsToRowColumn(p.X, p.Y).Row;
    s := fText.GetWordAtRowCol(BufferCoord(p.X, p.Y));

    // if ctrl+clicked
    If (ssCtrl In Shift) And (Button = mbLeft) Then
    Begin

        // reset the cursor
        fText.Cursor := crIBeam;

        // see if it's #include
        s1 := fText.Lines[p.Y - 1];
        s1 := StringReplace(s1, ' ', '', [rfReplaceAll]);
        If AnsiStartsStr('#include', s1) Then
        Begin
            // it is #include
            // check for #include <...>
            f1 := AnsiPos('<', s1);
            If f1 > 0 Then
            Begin
                Inc(f1);
                f2 := f1;
                While (f2 < Length(s1)) And (s1[f2] <> '>') Do
                    Inc(f2);
                If s1[f2] <> '>' Then
                    // not located...
                    Abort;
                f2 := f2 - f1;
                DoOpen(MainForm.CppParser1.GetFullFileName(
                    Copy(s1, f1, f2)), 1, '');
                // the mousedown must *not* get to the SynEdit or else it repositions the caret!!!
                Abort;
            End;

            f1 := AnsiPos('"', s1);
            // since we reached here, we haven't found it yet
            // check for #include "..."
            If f1 > 0 Then
            Begin
                Inc(f1);
                f2 := f1;
                While (f2 < Length(s1)) And (s1[f2] <> '"') Do
                    Inc(f2);
                If s1[f2] <> '"' Then
                    // not located...
                    Abort;
                f2 := f2 - f1;
                DoOpen(MainForm.CppParser1.GetFullFileName(
                    Copy(s1, f1, f2)), 1, '');
                // the mousedown must *not* get to the SynEdit or else it repositions the caret!!!
                Abort;
            End;

            // if we reached here, exit; we cannot locate and extract the filename...
            Exit;
        End; // #include


        umSt := Nil;
        // if there *is* a word under the mouse cursor
        If S <> '' Then
        Begin
            // search for statement
            For I := 0 To MainForm.CppParser1.Statements.Count - 1 Do
                If AnsiCompareStr(PStatement(
                    MainForm.CppParser1.Statements[I])^._ScopelessCmd,
                    S) = 0 Then
                Begin
                    umSt := PStatement(MainForm.CppParser1.Statements[I]);
                    Break;
                End;
        End;

        // if statement found
        If Assigned(umSt) Then
        Begin
            // get the filename and the line number declared
            If umSt^._IsDeclaration Then
            Begin
                fname := umSt^._DeclImplFileName;
                line := umSt^._DeclImplLine;
            End
            Else
            Begin
                fname := umSt^._FileName;
                line := umSt^._Line;
            End;

            DoOpen(fname, line, s);

            // the mousedown must *not* get to the SynEdit or else it repositions the caret!!!
            Abort;
        End;
    End;
End;

Procedure TEditor.RunToCursor(Line: Integer);
Begin
    If fRunToCursorLine <> -1 Then
        TurnOffBreakpoint(fRunToCursorLine);
    fRunToCursorLine := Line;
    TurnOnBreakpoint(fRunToCursorLine);
End;

Procedure TEditor.PaintMatchingBrackets(TransientType: TTransientType);
Const
    OpenChars: Array[0..2] Of Char = ('{', '[', '(');
    CloseChars: Array[0..2] Of Char = ('}', ']', ')');

    Function CharToPixels(P: TBufferCoord): TPoint;
    Begin
        Result := fText.RowColumnToPixels(fText.BufferToDisplayPos(p));
    End;

    Procedure SetColors(Editor: TSynEdit; virtualCoord: TBufferCoord;
        Attri: TSynHighlighterAttributes);
        Function GetEditorBackgroundColor: TColor;
        Var
            Attri: TSynHighlighterAttributes;
            PhysicalIndex: Integer;
        Begin
            PhysicalIndex := Editor.RowColToCharIndex(virtualCoord);

            //Start by checking for selections
            If (PhysicalIndex >= Editor.SelStart) And
                (PhysicalIndex < Editor.SelEnd) Then
                Result := Editor.SelectedColor.Background
            Else
            If (Editor.ActiveLineColor <> clNone) And (Editor.CaretY =
                virtualCoord.Line) Then
                Result := Editor.ActiveLineColor
            Else
            Begin
                Result := Editor.Color;
                If Editor.Highlighter <> Nil Then
                Begin
                    Attri := Editor.Highlighter.WhitespaceAttribute;
                    If (Attri <> Nil) And (Attri.Background <> clNone) Then
                        Result := Attri.Background;
                End;
            End;
        End;

        Function GetEditorForegroundColor: TColor;
        Var
            PhysicalIndex: Integer;
        Begin
            PhysicalIndex := Editor.RowColToCharIndex(virtualCoord);

            //Start by checking for selections
            If (PhysicalIndex >= Editor.SelStart) And
                (PhysicalIndex < Editor.SelEnd) Then
                Result := Editor.SelectedColor.Foreground
            Else
                Result := Editor.Font.Color;
        End;
    Var
        Special: Boolean;
        Foreground, Background: TColor;
    Begin
        //Initialize the editor colors to defaults
        Foreground := GetEditorForegroundColor;
        Background := GetEditorBackgroundColor;

        Editor.OnSpecialLineColors(Self, virtualCoord.Line, Special,
            Foreground, Background);
        Editor.Canvas.Brush.Style := bsSolid;
        Editor.Canvas.Font.Assign(fText.Font);
        Editor.Canvas.Font.Style := Attri.Style;
        If TransientType = ttAfter Then
        Begin
            fText.Canvas.Font.Style := Editor.Canvas.Font.Style + [fsBold];
            Foreground := clRed;
            // EAB: I think matching brackets highlighting was not visible enough. 
        End;

        Editor.Canvas.Brush.Color := Background;
        Editor.Canvas.Font.Color := Foreground;
    End;

Var
    P: TBufferCoord;
    Pix: TPoint;
    S: String;
    I: Integer;
    Attri: TSynHighlighterAttributes;
Begin
    P := fText.CaretXY;
    fText.GetHighlighterAttriAtRowCol(P, S, Attri);
    If Assigned(Attri) And (fText.Highlighter.SymbolAttribute = Attri) And
        (fText.CaretX <= length(fText.LineText) + 1) Then
    Begin
        For i := 0 To 2 Do
        Begin
            If (S = OpenChars[i]) Or (S = CloseChars[i]) Then
            Begin
                //Draw the brackets
                SetColors(fText, P, Attri);
                Pix := CharToPixels(P);
                fText.Canvas.TextOut(Pix.X, Pix.Y, S);

                P := fText.GetMatchingBracketEx(P);
                If (P.Char > 0) And (P.Line > 0) Then
                Begin
                    SetColors(fText, P, Attri);
                    Pix := CharToPixels(P);
                    If S = OpenChars[i] Then
                        fText.Canvas.TextOut(Pix.X, Pix.Y, CloseChars[i])
                    Else
                        fText.Canvas.TextOut(Pix.X, Pix.Y, OpenChars[i]);
                End;
            End;
        End;
        fText.Canvas.Brush.Style := bsSolid;
    End;
End;

Procedure TEditor.EditorPaintTransient(Sender: TObject; Canvas: TCanvas;
    TransientType: TTransientType);
Begin
    If (Not Assigned(fText.Highlighter)) Or (devEditor.Match = False) Then
        Exit;
    PaintMatchingBrackets(TransientType);
End;

Procedure TEditor.FunctionArgsExecute(Kind: SynCompletionType; Sender: TObject;
    Var AString: String; Var x, y: Integer; Var CanExecute: Boolean);
Var
    TmpX, savepos, StartX, ParenCounter: Integer;
    locline, lookup: String;
    FoundMatch: Boolean;
    sl: TList;
Begin
    sl := Nil;
    Try
        With TSynCompletionProposal(Sender).Editor Do
        Begin
            locLine := LineText;

            //go back from the cursor and find the first open paren
            TmpX := CaretX;
            If TmpX > length(locLine) Then
                TmpX := length(locLine)
            Else
                dec(TmpX);
            FoundMatch := False;

            While (TmpX > 0) And Not (FoundMatch) Do
            Begin
                If LocLine[TmpX] = ',' Then
                    Dec(TmpX)
                Else
                If LocLine[TmpX] = ')' Then
                Begin
                    //We found a close, go till it's opening paren
                    ParenCounter := 1;
                    dec(TmpX);
                    While (TmpX > 0) And (ParenCounter > 0) Do
                    Begin
                        If LocLine[TmpX] = ')' Then
                            inc(ParenCounter)
                        Else
                        If LocLine[TmpX] = '(' Then
                            dec(ParenCounter);
                        dec(TmpX);
                    End;
                    If TmpX > 0 Then
                        dec(TmpX); //eat the open paren
                End
                Else
                If locLine[TmpX] = '(' Then
                Begin
                    //we have a valid open paren, lets see what the word before it is
                    StartX := TmpX;
                    While (TmpX > 0) And Not
                        (locLine[TmpX] In TSynValidStringChars) Do
                        Dec(TmpX);
                    If TmpX > 0 Then
                    Begin
                        SavePos := TmpX;
                        While (TmpX > 0) And
                            (locLine[TmpX] In TSynValidStringChars) Do
                            dec(TmpX);
                        inc(TmpX);
                        lookup := Copy(LocLine, TmpX, SavePos - TmpX + 1);
                        If Assigned(fLastParamFunc) Then
                        Begin
                            If (fLastParamFunc.Count > 0) Then
                                If
                                (PStatement(fLastParamFunc.Items[0])^._Command =
                                    lookup) Then
                                    // this avoid too much calls to CppParser.FillListOf
                                    sl := fLastParamFunc;
                        End;
                        If Not Assigned(sl) Then
                        Begin
                            sl := TList.Create;
                            If MainForm.CppParser1.FillListOf(
                                Lookup, False, sl) Then
                            Begin  // and try to use only a minimum of FillListOf
                                If Assigned(fLastParamFunc) Then
                                    FreeAndNil(fLastParamFunc)
                                Else
                                    fLastParamFunc := Nil;

                                fLastParamFunc := sl;
                            End
                            Else
                            If Assigned(sl) Then
                                FreeAndNil(sl)
                            Else
                                sl := Nil;
                        End;
                        FoundMatch := Assigned(sl);
                        If Not (FoundMatch) Then
                        Begin
                            TmpX := StartX;
                            dec(TmpX);
                        End;
                    End;
                End
                Else
                    dec(TmpX);
            End;
        End;

        CanExecute := FoundMatch;
    Finally

    End;
End;

//this event is triggered whenever the codecompletion box is going to do the actual
//code completion
Procedure TEditor.DoOnCodeCompletion(Sender: TObject;
    Const AStatement: TStatement; Const AIndex: Integer);
//
//  this event is triggered whenever the codecompletion box is going to make its work,
//  or in other words, when it did a codecompletion ...
//
{$IFNDEF PRIVATE_BUILD}
Var
    bUnIntialisedToolTip: Boolean;
Begin
    // disable the tooltip here, becasue we check against Enabled
    // in the 'EditorStatusChange' event to prevent it's redrawing there
    If assigned(FCodeToolTip) Then
    Begin
        //TODO: specu: FCodeToolTip may not be initialized under some circumstances
        //             when creating TEditor. I suspect it's in TProject.OpenUnit
        //TODO: Guru: I'm checking if the tooltip is created; if it isn't, create a
        //            new one on the fly
        bUnIntialisedToolTip := False;
        Try
            FCodeToolTip.Enabled := False;
        Except
            bUnIntialisedToolTip := True;
        End;
        If bUnIntialisedToolTip Then
        Begin
            FCodeToolTip := Nil;
            FCodeToolTip := TDevCodeToolTip.Create(Application);
            FCodeToolTip.Editor := FText;
            FCodeToolTip.Parser := MainForm.CppParser1;
        End;
        FCodeToolTip.Enabled := False;
        FCodeToolTip.ReleaseHandle;
        FCodeToolTip.Show;
        FCodeToolTip.Select(AStatement._FullText);
        FCodeToolTip.Enabled := True;
        FCodeToolTip.Show;
    End;
{$ELSE}
begin
  try
    Assert(FCodeToolTip <> nil);
    FCodeToolTip.Select(AStatement._FullText);
    FCodeToolTip.Enabled := True;
    FCodeToolTip.Show;
  except
    ShowMessage(inttostr(integer(FCodeToolTip)) + '/' + inttostr(integer(@AStatement)));
    raise;
  end;
{$ENDIF}

    //When we don't invalidate the SynEditor here, it occurs sometimes that
    //fragments of the codecompletion listbox are stuff displayed on the SynEdit
    //fText.Invalidate;

    // GAR 11/30/2009 - Trying to correct bug report submitted by mrHappyPants
    If (fText <> Nil) Then
        fText.Refresh;
End;

// Editor needs to be told when class browser has been recreated otherwise AV !
Procedure TEditor.UpdateParser;
Begin
    FCodeToolTip.Parser := MainForm.CppParser1;
End;

Procedure TEditor.InvalidateGutter;
Begin
    fText.InvalidateGutter;
End;

End.
