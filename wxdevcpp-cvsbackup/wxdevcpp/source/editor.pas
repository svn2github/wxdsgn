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

unit editor;

interface

uses Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, CodeCompletion, CppParser,
  Menus, ImgList, ComCtrls, StdCtrls, ExtCtrls, SynEdit, SynEditKeyCmds, version, Grids,
   SynCompletionProposal, StrUtils, SynEditTypes,  SynEditHighlighter,

  {** Modified by Peter **}
  DevCodeToolTip, SynAutoIndent

  {$IFDEF WX_BUILD}
    ,Designerfrm, CompFileIo, wxutils
  {$ENDIF}
    ;

type
  TEditor = class;
  TDebugGutter = class(TSynEditPlugin)
  protected
    fEditor: TEditor;
    {$IFDEF NEW_SYNEDIT}
    procedure AfterPaint(ACanvas: TCanvas; const AClip: TRect;
      FirstLine, LastLine: integer); override;
    {$ELSE}
    procedure AfterPaint(ACanvas: TCanvas; AClip: TRect;
      FirstLine, LastLine: integer); override;
    {$ENDIF}
    procedure LinesInserted(FirstLine, Count: integer); override;
    procedure LinesDeleted(FirstLine, Count: integer); override;
  public
    constructor Create(ed: TEditor);
  end;

  TBreakpointToggleEvent = procedure (Sender: TEditor; Line: integer; BreakExists: boolean) of object;

  TEditor = class
  private
    fInProject: boolean;
    fFileName: string;
    fNew: boolean;
    fRes: boolean;
    fModified: boolean;
    fText: TSynEdit;
    {$IFDEF WX_BUILD}
    fDesigner: TfrmNewForm;
    fScrollDesign: TScrollBox;
    fEditorType: TEditorType;
   {$ENDIF}
       
    fTabSheet: TTabSheet;
    fBreakPoints: TList;
    fErrorLine: integer;
    fActiveLine: integer;
    fErrSetting: boolean;
    fDebugGutter: TDebugGutter;
    fOnBreakPointToggle: TBreakpointToggleEvent;
    fHintTimer: TTimer;
    fCurrentHint: string;
    //////// CODE-COMPLETION - mandrav /////////////
    fCompletionEatSpace: boolean;
    fTimer: TTimer;
    fTimerKey: Char;
    fCompletionBox: TCodeCompletion;
    fRunToCursorLine: integer;
    fFunctionArgs: TSynCompletionProposal;
    fLastParamFunc: TList;
    FCodeToolTip: TDevCodeToolTip; {** Modified by Peter **}
    FAutoIndent: TSynAutoIndent; {** Modified by Peter **}
    procedure CompletionTimer(Sender: TObject);
    procedure CodeRushLikeEditorKeyPress(Sender: TObject; var Key: Char);
    procedure EditorKeyPress(Sender: TObject; var Key: Char);
    procedure EditorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditorMouseDown(Sender: TObject; Button: TMouseButton; Shift:TShiftState; X, Y: Integer);
    procedure SetEditorText(Key: Char);
    procedure InitCompletion;
    procedure DestroyCompletion;
    function CurrentPhrase: string;
{$IFDEF NEW_SYNEDIT}
    function CheckAttributes(P: TBufferCoord; Phrase: string): boolean;
{$ELSE}
    function CheckAttributes(P: TPoint; Phrase: string): boolean;
{$ENDIF}
    //////// CODE-COMPLETION - mandrav - END ///////
    function GetModified: boolean;
    procedure SetModified(value: boolean);

    procedure EditorStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure EditorSpecialLineColors(Sender: TObject; Line: integer;
      var Special: boolean; var FG, BG: TColor);
{$IFDEF NEW_SYNEDIT}
    procedure EditorGutterClick(Sender: TObject; Button: TMouseButton;
      x, y, Line: integer; mark: TSynEditMark);
{$ELSE}
    procedure EditorGutterClick(Sender: TObject; x, y, Line: integer;
      mark: TSynEditMark);
{$ENDIF}
    procedure EditorReplaceText(Sender: TObject;
      const aSearch, aReplace: string; Line, Column: integer;
      var Action: TSynReplaceAction);
    procedure EditorDropFiles(Sender: TObject; x, y: integer;
      aFiles: TStrings);
    procedure EditorDblClick(Sender: TObject);
    procedure EditorMouseMove(Sender: TObject; Shift: TShiftState; X, Y:Integer);
    procedure EditorHintTimer(sender: TObject);

    function HasBreakPoint(Line: integer): integer;
    procedure SetFileName(value: string);
    procedure DrawGutterImages(ACanvas: TCanvas; AClip: TRect;
                               FirstLine, LastLine: integer);
    procedure EditorPaintTransient(Sender: TObject; Canvas: TCanvas;TransientType: TTransientType);
{$IFDEF NEW_SYNEDIT}
    procedure FunctionArgsExecute(Kind: SynCompletionType; Sender: TObject;
      var AString: String; var x, y: Integer; var CanExecute: Boolean);
{$ELSE}
    procedure FunctionArgsExecute(Kind: SynCompletionType; Sender: TObject;
      var AString: String; x, y: Integer; var CanExecute: Boolean);
{$ENDIF}
  protected
    procedure DoOnCodeCompletion(Sender: TObject; const AStatement: TStatement;const AIndex: Integer); {** Modified by Peter **}
  public
    procedure Init(In_Project: boolean; Caption_, File_name: string; DoOpen: boolean; const IsRes: boolean = FALSE);
    destructor Destroy; override;
    procedure Close;

    procedure Activate;
    function ToggleBreakPoint(Line: integer): boolean;
    procedure RunToCursor(Line: integer);
    procedure GotoLine;
    procedure GotoLineNr(Nr: integer);
    function Search(const isReplace: boolean): boolean;
    procedure SearchAgain;
    procedure Exportto(const isHTML: boolean);
    procedure InsertString(const Value: string; const move: boolean);
    procedure SetString(const Value: string);
    function GetWordAtCursor: string;
    procedure SetErrorFocus(const Col, Line: integer);
    procedure SetActiveBreakpointFocus(const Line: integer);
    procedure RemoveBreakpointFocus;
    procedure UpdateCaption(NewCaption: string);
    procedure InsertDefaultText;
    procedure PaintMatchingBrackets(TransientType: TTransientType);

    procedure CommentSelection;
    procedure UncommentSelection;
    procedure IndentSelection;
    procedure UnindentSelection;

    procedure UpdateParser; // Must be called after recreating the parser
    //////// CODE-COMPLETION - mandrav /////////////
    procedure ReconfigCompletion;
    //////// CODE-COMPLETION - mandrav /////////////

    property OnBreakpointToggle: TBreakpointToggleEvent read fOnBreakpointToggle write fOnBreakpointToggle;
    property BreakPoints: TList read fBreakPoints write fBreakPoints;
    property FileName: string read fFileName write SetFileName;
    property InProject: boolean read fInProject write fInProject;
    property New: boolean read fNew write fNew;
    property Modified: boolean read GetModified write SetModified;
    property IsRes: boolean read fRes write fRes;
    property Text: TSynEdit read fText write fText;
    property TabSheet: TTabSheet read fTabSheet write fTabSheet;

    property CodeToolTip: TDevCodeToolTip read FCodeToolTip; // added on 23rd may 2004 by peter_

    //Guru's Code
  {$IFDEF WX_BUILD}
  private
    fDesignerClassName, fDesignerTitle: string;
    fDesignerStyle: TWxDlgStyleSet;
    fDesignerDefaultData: Boolean;
  public
    procedure ActivateDesigner;
    procedure UpdateDesignerData;
    function GetDesigner: TfrmNewForm;
    procedure InitDesignerData(strFName, strCName, strFTitle: string; dlgSStyle:TWxDlgStyleSet);
    function GetDesignerHPPFileName: string;
    function GetDesignerCPPFileName: string;

    function GetDesignerHPPText: TSynEdit;
    function GetDesignerCPPText: TSynEdit;

    function IsDesignerCPPOpened: Boolean;
    function IsDesignerHPPOpened: Boolean;

    function GetDesignerHPPEditor: TEditor;
    function GetDesignerCPPEditor: TEditor;
    procedure ReloadForm;
    procedure ReloadFormFromFile(strFilename:String);
    function isForm: Boolean;    
    {$ENDIF}

    
  end;

implementation

uses main, project, MultiLangSupport, devcfg, Search_Center,utils,
  datamod, GotoLineFrm, Macros;

{ TDebugGutter }

constructor TDebugGutter.Create(ed: TEditor);
begin
  inherited Create(ed.Text);
  fEditor := ed;
end;

{$IFDEF NEW_SYNEDIT}
procedure TDebugGutter.AfterPaint(ACanvas: TCanvas; const AClip: TRect;
                                  FirstLine, LastLine: integer);
{$ELSE}
procedure TDebugGutter.AfterPaint(ACanvas: TCanvas; AClip: TRect;
  FirstLine, LastLine: integer);
{$ENDIF}
begin
  fEditor.DrawGutterImages(ACanvas, AClip, FirstLine, LastLine);
end;

procedure TDebugGutter.LinesInserted(FirstLine, Count: integer);
begin
  // if this method is not defined -> Abstract error
end;

procedure TDebugGutter.LinesDeleted(FirstLine, Count: integer);
begin
  // if this method is not defined -> Abstract error
end;

{ TEditor }

procedure TEditor.Init(In_Project: boolean; Caption_, File_name: string;
  DoOpen: boolean; const IsRes: boolean = FALSE);
var
  s: string;
  pt: TPoint;
begin
  fModified := false;
  fErrorLine := -1;
  fActiveLine := -1;
  fRunToCursorLine := -1;
  fRes := IsRes;
  fInProject := In_Project;
  fLastParamFunc := nil;
  if File_name = '' then
    fFileName := Caption_
  else
    fFileName := File_name;

  {$IFDEF WX_BUILD}
  if iswxForm(fFileName) then
    fEditorType := etForm
  else
    fEditorType := etSource;
  {$ENDIF}

  fTabSheet := TTabSheet.Create(MainForm.PageControl);
  fTabSheet.Caption := Caption_;
  fTabSheet.PageControl := MainForm.PageControl;
  fTabSheet.TabVisible := FALSE;
  { This is to have a pointer to the TEditor using
    the PageControl in MainForm }
  fTabSheet.Tag := integer(self);

  fBreakpoints := TList.Create;

  fOnBreakpointToggle := MainForm.OnBreakpointToggle;


  fText := TSynEdit.Create(fTabSheet);
  fText.Parent := fTabSheet;

 {$IFDEF WX_BUILD}
  if fEditorType = etForm then
  begin
    //Dont allow anyone to edit the text content
    fText.ReadOnly:=true;
    fScrollDesign := TScrollBox.Create(fTabSheet);
    fScrollDesign.Parent := fTabSheet;
    fScrollDesign.Align := alClient;
    fScrollDesign.Visible := True;
    fScrollDesign.Color := clWhite;
    fScrollDesign.HorzScrollBar.Visible:=true;
    fScrollDesign.VertScrollBar.Visible:=true;

    fDesigner := TfrmNewForm.Create(fScrollDesign);
    //fDesigner.Parent:=fScrollDesign;
    fDesigner.synEdit := fText;
    fDesigner.Visible := False;
    SetWindowLong(fDesigner.Handle, GWL_STYLE, WS_CHILD or
      (GetWindowLong(fDesigner.Handle, GWL_STYLE)));
    Windows.SetParent(fDesigner.Handle, fScrollDesign.Handle);
    ShowWindow(fDesigner.Handle, Sw_ShowNormal);
  end
  else
  {$ENDIF}
  begin
   {$IFDEF WX_BUILD}
    fDesigner := nil;
   {$ENDIF}
    fText.Align := alClient;
  end;

  if (DoOpen) then
  try
    fText.Lines.LoadFromFile(FileName);
    fNew := False;
    if devData.Backups then // create a backup of the file
    begin
      s := ExtractfileExt(FileName);
      insert('~', s, pos('.', s) + 1);
      delete(s, length(s) - 1, 1);
      fText.Lines.SaveToFile(ChangeFileExt(FileName, s));
    end;

{$IFDEF WX_BUILD}
    if fEditorType = etForm then
      ReadComponentFromFile(fDesigner, FileName);
{$ENDIF}

  except
    raise;
  end
  else
    fNew := True;

  {$IFDEF WX_BUILD}
  if fEditorType = etForm then
  begin
    fText.Visible := false;

    fDesigner.Visible := True;
    fDesigner.Left := 8;
    fDesigner.Top := 8;
    if fDesignerDefaultData then
    begin
      if Trim(fDesignerClassName) <> '' then
        fDesigner.Wx_Name := Trim(fDesignerClassName);

      if Trim(fDesigner.Wx_Name) <> '' then
        fDesigner.Wx_IDName := UpperCase('ID_' + fDesigner.Wx_Name);

      if fDesigner.Wx_IDValue = 0 then
        fDesigner.Wx_IDValue := 1000;

      if fDesignerStyle <> [] then
      fDesigner.Wx_DialogStyle := fDesignerStyle;

      if Trim(fDesignerTitle) <> '' then
        fDesigner.Caption := Self.fDesignerTitle;
    end;

  end
  else
  {$ENDIF}
  begin
    fText.Visible := True;
  end;

  fHintTimer := TTimer.Create(Application);
  fHintTimer.Interval := 1000;
  fHintTimer.OnTimer := EditorHintTimer;
  fHintTimer.Enabled := False;

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

{$IFDEF NEW_SYNEDIT}
  fText.MaxScrollWidth:=4096; // bug-fix #600748
{$ELSE}
  fText.MaxLeftChar := 4096; // bug-fix #600748
{$ENDIF}
  fText.MaxUndo := 4096;

  devEditor.AssignEditor(fText);
  if not fNew then
    fText.Highlighter := dmMain.GetHighlighter(fFileName)
  else 
   if fRes then
    fText.Highlighter := dmMain.Res
  else
    fText.Highlighter := dmMain.cpp;

{$IFDEF WX_BUILD}
   if self.isForm then
   begin
        fText.Highlighter := dmMain.Res;
        fDesigner.PopupMenu:=MainForm.DesignerPopup;
   end;
{$ENDIF}

  // update the selected text color
  StrtoPoint(pt, devEditor.Syntax.Values[cSel]);
  fText.SelectedColor.Background := pt.X;
  fText.SelectedColor.Foreground := pt.Y;

  fTabSheet.PageControl.ActivePage := fTabSheet;
  fTabSheet.TabVisible := TRUE;
  fDebugGutter := TDebugGutter.Create(self);
  Application.ProcessMessages;

  InitCompletion;

  {** Modified by Peter **}
  fFunctionArgs := TSynCompletionProposal.Create(fText);
  with fFunctionArgs do begin
    EndOfTokenChr := '';
    //TriggerChars:='('; {** Modified by Peter **}
    // we dont need triggerchars here anymore, because the tooltips
    // are handled by FCodeToolTip now
    TriggerChars := ''; {** Modified by Peter **}
    TimerInterval := devCodeCompletion.Delay;
    DefaultType := ctParams;
    OnExecute := FunctionArgsExecute;
    Editor := fText;
    Options := Options + [scoUseBuiltInTimer];
    ShortCut := Menus.ShortCut(Word(VK_SPACE), [ssCtrl, ssShift]);
  end;

   
  {** Modified by Peter **}
  // create the codetooltip
  FCodeToolTip := TDevCodeToolTip.Create(Application);
  FCodeToolTip.Editor := FText;
  FCodeToolTip.Parser := MainForm.CppParser1;

  
  {** Modified by Peter **}
  // The Editor must have 'Auto Indent' activated  to use FAutoIndent.
  // It's under Tools | Editor Options and then the General tab
  FAutoIndent := TSynAutoIndent.Create(Application);
  FAutoIndent.Editor := FText;
  FAutoIndent.IndentChars := '{:';
  FAutoIndent.UnIndentChars := '}';

  
  fText.OnMouseMove := EditorMouseMove;

  // monitor this file for outside changes
  MainForm.devFileMonitor1.Files.Add(fFileName);
  MainForm.devFileMonitor1.Refresh(True);
end;

destructor TEditor.Destroy;
var
  idx: integer;
begin
  {$IFDEF WX_BUILD}
  if isForm then
    MainForm.SelectedComponent:=nil;
  {$ENDIF}

  idx := MainForm.devFileMonitor1.Files.IndexOf(fFileName);
  if idx <> -1 then begin
    // do not monitor this file for outside changes anymore
    MainForm.devFileMonitor1.Files.Delete(idx);
    MainForm.devFileMonitor1.Refresh(False);
  end;

  if Assigned(fHintTimer) then begin
    fHintTimer.Enabled := False;
    FreeAndNil(fHintTimer);
  end;

  DestroyCompletion;
  FreeAndNil(fText);

  {$IFDEF WX_BUILD}
  if Assigned(fDesigner) then
  begin
    FreeAndNil(fDesigner);
    FreeAndNil(fScrollDesign);
  end;
  {$ENDIF}

  FreeAndNil(fTabSheet);
  FreeAndNil(fBreakpoints);

  {** Modified by Peter **}
  if Assigned(FCodeToolTip) then FreeAndNil(FCodeToolTip);

  {** Modified by Peter **}
  if Assigned(FAutoIndent) then FreeAndNil(FAutoIndent);

  inherited;
end;

procedure TEditor.Activate;
begin
  if assigned(fTabSheet) then
  begin
    fTabSheet.PageControl.Show;
    fTabSheet.PageControl.ActivePage := fTabSheet;
    if fText.Visible then
      fText.SetFocus;
  {$IFDEF WX_BUILD}
    if isForm then
    begin
      try
        MainForm.ELDesigner1.Active:=false;
        MainForm.ELDesigner1.DesignControl:=fDesigner;
      except
      end;
      MainForm.EnableDesignerControls;
      fDesigner.OnResize:=fDesigner.NewFormResize;
    end
    else
      MainForm.DisableDesignerControls;
  {$ENDIF}

    if MainForm.ClassBrowser1.Enabled {$IFDEF WX_BUILD} or isForm {$ENDIF} then
      MainForm.PageControlChange(MainForm.PageControl); // this makes sure that the classbrowser is consistent


  end;
end;

procedure TEditor.Close;
begin
{$IFDEF WX_BUILD}
  if isForm then
  begin
    MainForm.DisableDesignerControls;
  end;
{$ENDIF}
  try
    Free;
  except
  end;
end;

function TEditor.GetModified: boolean;
begin
  result := fModified or fText.Modified;
end;

procedure TEditor.SetModified(value: boolean);
begin
  fModified := value;
  fText.Modified := Value;
end;

function TEditor.ToggleBreakpoint(Line: integer): boolean;
var
  idx: integer;
begin
  result := FALSE;
  if (line > 0) and (line <= fText.Lines.Count) then
  begin
{$IFDEF NEW_SYNEDIT}
    fText.InvalidateGutterLine(line);
{$ENDIF}
    fText.InvalidateLine(line);
    idx := HasBreakPoint(Line);
    if idx <> -1 then
      fBreakPoints.delete(idx)
    else
    begin
      fBreakPoints.Add(pointer(Line));
      result := TRUE;
    end;
  end
  else
    fText.Invalidate;
  if Assigned(fOnBreakpointToggle) then
    fOnBreakpointToggle(Self, Line, Result);
end;

function TEditor.HasBreakPoint(line: integer): integer;
begin
  for result := 0 to pred(fBreakpoints.Count) do
    if line = integer(fBreakpoints[result]) then exit;
  result := -1;
end;

procedure TEditor.EditorSpecialLineColors(Sender: TObject; Line: Integer;
  var Special: Boolean; var FG, BG: TColor);
var
  pt: TPoint;
begin
  if (Line = fActiveLine) then begin
    StrtoPoint(pt, devEditor.Syntax.Values[cABP]);
    BG := pt.X;
    FG := pt.Y;
    Special := TRUE;
  end
  else if (fBreakpoints.Count > 0) and (HasBreakpoint(line) <> -1) then
  begin
    StrtoPoint(pt, devEditor.Syntax.Values[cBP]);
    BG := pt.x;
    FG := pt.y;
    Special := TRUE;
  end
  else 
   if Line = fErrorLine then
   begin
    StrtoPoint(pt, devEditor.Syntax.Values[cErr]);
    bg := pt.x;
    fg := pt.y;
    Special := TRUE;
  end;
end;

// ** undo after insert removes all text above insert point;
// ** seems to be a synedit bug!!
procedure TEditor.EditorDropFiles(Sender: TObject; x, y: integer;
  aFiles: TStrings);
var
  sl: TStringList;
  idx, idx2: integer;
begin
  if devEditor.InsDropFiles then
  begin
{$IFDEF NEW_SYNEDIT}
     fText.CaretXY:= fText.DisplayToBufferPos(fText.PixelsToRowColumn(x, y));
{$ELSE}
    fText.CaretXY := fText.PixelsToRowColumn(point(x, y));
{$ENDIF}
    sl := TStringList.Create;
    try
      for idx := 0 to pred(aFiles.Count) do
      begin
        sl.LoadFromFile(aFiles[idx]);
        fText.SelText := sl.Text;
      end;
    finally
      sl.Free;
    end;
  end
  else
    for idx := 0 to pred(aFiles.Count) do
    begin
      idx2 := MainForm.FileIsOpen(aFiles[idx]);
      if idx2 = -1 then
        if GetFileTyp(aFiles[idx]) = utPrj then
        begin
          MainForm.OpenProject(aFiles[idx]);
          exit;
        end
        else
          MainForm.OpenFile(aFiles[idx])
      else
        TEditor(MainForm.PageControl.Pages[idx2].Tag).Activate;
    end;
end;

procedure TEditor.EditorDblClick(Sender: TObject);
begin
  if devEditor.DblClkLine then
  begin
{$IFDEF NEW_SYNEDIT} 
     fText.BlockBegin:= BufferCoord(1, fText.CaretY);
     fText.BlockEnd:= BufferCoord(1, fText.CaretY +1);
{$ELSE}
    fText.BlockBegin := point(1, fText.CaretY);
    fText.BlockEnd := point(1, fText.CaretY + 1);
{$ENDIF}
  end;
end;

{$IFDEF NEW_SYNEDIT}
procedure TEditor.EditorGutterClick(Sender: TObject; Button: TMouseButton;
  x, y, Line: integer; mark: TSynEditMark);
{$ELSE}
procedure TEditor.EditorGutterClick(Sender: TObject; x, y, Line: integer;
  mark: TSynEditMark);
{$ENDIF}
begin
  ToggleBreakPoint(Line);
end;

procedure TEditor.EditorReplaceText(Sender: TObject; const aSearch,
  aReplace: string; Line, Column: integer; var Action: TSynReplaceAction);
var
  pt: TPoint;
begin
  if SearchCenter.SingleFile then
  begin
    if aSearch = aReplace then
    begin
{$IFDEF NEW_SYNEDIT}
        fText.CaretXY:= BufferCoord(Column, Line +1);
{$ELSE}
      fText.CaretXY := point(Column, Line + 1);
{$ENDIF}
      action := raSkip;
    end
    else
    begin
{$IFDEF NEW_SYNEDIT}
        pt:= fText.ClienttoScreen(fText.RowColumnToPixels(DisplayCoord(Column, Line +1)));
{$ELSE}
      pt := fText.ClienttoScreen(fText.RowColumnToPixels(point(Column, Line +1)));
{$ENDIF}
      MessageBeep(MB_ICONQUESTION);
      case MessageDlgPos(format(Lang[ID_MSG_SEARCHREPLACEPROMPT], [aSearch]),
        mtConfirmation, [mbYes, mbNo, mbCancel, mbAll], 0, pt.x, pt.y) of
        mrYes: action := raReplace;
        mrNo: action := raSkip;
        mrCancel: action := raCancel;
        mrAll: action := raReplaceAll;
      end;
    end;
  end;
end;


procedure TEditor.EditorStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if scModified in Changes then begin
    if Modified then
      UpdateCaption('[*] ' + ExtractfileName(fFileName))
    else
      UpdateCaption(ExtractfileName(fFileName));
  end;
  with MainForm.Statusbar do
  begin
    if Changes * [scAll, scCaretX, scCaretY] <> [] then
    begin
      Panels[0].Text := format('%6d: %-4d', [fText.DisplayY, fText.DisplayX]);
      if not fErrSetting and (fErrorLine <> -1) then
      begin
        fText.InvalidateLine(fErrorLine);
        fErrorLine := -1;
        fText.InvalidateLine(fErrorLine);
        Application.ProcessMessages;
      end;
    end;
    if Changes * [scAll, scModified] <> [] then
      if fText.Modified then
        Panels[1].Text := Lang[ID_MODIFIED]
      else
        Panels[1].Text := '';
    if fText.ReadOnly then
      Panels[2].Text := Lang[ID_READONLY]
    else 
    if fText.InsertMode then
      Panels[2].Text := Lang[ID_INSERT]
    else
      Panels[2].Text := Lang[ID_OVERWRITE];
    Panels[3].Text := format(Lang[ID_LINECOUNT], [fText.Lines.Count]);
  end;

   
  {** Modified by Peter **}
  if (scCaretX in Changes) or (scCaretY in Changes) then
  begin
    if assigned(FCodeToolTip) and FCodeToolTip.Enabled then
    begin
      // when the hint is already activated when call
      // ShowHint again, because the current arugment could have
      // been changed, so we need to make another arg in bold
      if FCodeToolTip.Activated then
        FCodeToolTip.Show
      else
        // it's not showing yet, so we check if the cursor
        // is at the bracket and when it is, we show the hint
        if assigned(FText) and (not FText.SelAvail) and (FText.SelStart > 1) and (Copy(FText.Text, FText.SelStart-1, 1) = '(') then
          FCodeToolTip.Show;
    end;
  end;
end;

procedure TEditor.ExportTo(const isHTML: boolean);
begin
  if IsHTML then
  begin
    with dmMain.SaveDialog do
    begin
      Filter := dmMain.SynExporterHTML.DefaultFilter;
      DefaultExt := HTML_EXT;
      Title := Lang[ID_NV_EXPORT];
      if Execute then
      begin
        dmMain.ExportToHtml(fText.Lines, dmMain.SaveDialog.FileName);
        fText.BlockEnd := fText.BlockBegin;
      end;
    end;
  end
  else
    with dmMain.SaveDialog do
    begin
      Filter := dmMain.SynExporterRTF.DefaultFilter;
      Title := Lang[ID_NV_EXPORT];
      DefaultExt := RTF_EXT;
      if Execute then
      begin
        dmMain.ExportToRtf(fText.Lines, dmMain.SaveDialog.FileName);
        fText.BlockEnd := fText.BlockBegin;
      end;
    end;
end;

function TEditor.GetWordAtCursor: string;
begin
  result := fText.GetWordAtRowCol(fText.CaretXY);
end;

{** Modified by Peter **}
procedure TEditor.GotoLine;
var
  GotoForm: TGotoLineForm;
begin
  GotoForm := TGotoLineForm.Create(FText);
  try
    GotoForm.Editor := FText;

    if GotoForm.ShowModal = mrOK then
{$IFDEF NEW_SYNEDIT}
     FText.CaretXY:= BufferCoord(FText.CaretX, GotoForm.Line.Value);
{$ELSE}
      FText.CaretXY := Point(FText.CaretX, GotoForm.Line.Value);
{$ENDIF}

    Activate;
  finally
    GotoForm.Free;
  end;
end;

{
procedure TEditor.GotoLine;
var
 pt: TPoint;
begin
  with TGotoLineForm.Create(fText) do
   try
    pt.x:= (fText.Width div 2) - (Width div 2);
    pt.y:= fText.Top;
    pt:= fText.ClienttoScreen(pt);
    Left:= pt.x;
    Top:= pt.y;
    Line.Value:= fText.CaretY;
    if ShowModal = mrok then
     fText.CaretXY:= point(fText.CaretX, Line.Value);
    Activate;
   finally
    Free;
   end;
end;
}

procedure TEditor.SetString(const Value: string);
begin
  if not assigned(fText) then
    Exit;
  fText.Lines.Text := Value;
end;

procedure TEditor.InsertString(const Value: string; const move: boolean);
var
  Line: string;
  idx,
    idx2: integer;
{$IFDEF NEW_SYNEDIT} 
 pt: TBufferCoord;
{$ELSE}
  pt: TPoint;
{$ENDIF}
  tmp: TStringList;
begin
  if not assigned(fText) then exit;
  pt := fText.CaretXY;
  tmp := TStringList.Create;
  try // move cursor to pipe '|'
    tmp.Text := Value;
    if Move then
      for idx := 0 to pred(tmp.Count) do
      begin
        Line := tmp[idx];
        idx2 := AnsiPos('|', Line);
        if idx2 > 0 then
        begin
          delete(Line, idx2, 1);
          tmp[idx] := Line;
{$IFDEF NEW_SYNEDIT} 
          inc(pt.Line, idx);
          if idx = 0 then
           inc(pt.Char, idx2 -1)
          else
           pt.Char:= idx2;
{$ELSE}
          inc(pt.y, idx);
          if idx = 0 then
            inc(pt.x, idx2 - 1)
          else
            pt.x := idx2;
{$ENDIF}

          break;
        end;
      end;
    Line := tmp.Text;
    fText.SelText := Line;
    fText.CaretXY := pt;
    fText.EnsureCursorPosVisible;
  finally
    tmp.Free;
  end;
end;

function TEditor.Search(const isReplace: boolean): boolean;
var
  s: string;
begin
  if devEditor.FindText then
    if (fText.SelText = '') then
      s := GetWordAtCursor
    else
      s := fText.SelText;

  with SearchCenter do
  begin
    FindText := s;
    Replace := IsReplace;
    ReplaceText := '';
    SingleFile := TRUE;
    Editor := Self;
    Result := ExecuteSearch and not SingleFile; // if changed to "find in all files", open find results
  end;
  Activate;
end;

procedure TEditor.SearchAgain;
var
  Options: TSynSearchOptions;
  return: integer;
begin
  if not SearchCenter.SingleFile then exit;
  if SearchCenter.FindText = '' then begin
    Search(false);
    exit;
  end;
  Options := SearchCenter.Options;
  Exclude(Options, ssoEntireScope);

  return := fText.SearchReplace(SearchCenter.FindText,
    SearchCenter.ReplaceText,
    Options);
  if return <> 0 then
    Activate
  else
    MessageDlg(format(Lang[ID_MSG_TEXTNOTFOUND], [SearchCenter.FindText]),
      mtInformation, [mbOk], 0);
end;

procedure TEditor.SetErrorFocus(const Col, Line: integer);
begin
  fErrSetting := TRUE;
  Application.ProcessMessages;
  if fErrorLine <> Line then
  begin
    if fErrorLine <> -1 then
      fText.InvalidateLine(fErrorLine);
    fErrorLine := Line;
    fText.InvalidateLine(fErrorLine);
  end;
{$IFDEF NEW_SYNEDIT} 
     fText.CaretXY:= BufferCoord(col, line);
{$ELSE}
  fText.CaretXY := point(col, line);
{$ENDIF}
  fText.EnsureCursorPosVisible;
  fErrSetting := FALSE;
end;

procedure TEditor.SetActiveBreakpointFocus(const Line: integer);
begin
  if (fActiveLine <> Line) and (fActiveLine <> -1) then
    fText.InvalidateLine(fActiveLine);
  fActiveLine := Line;
  fText.InvalidateLine(fActiveLine);
  fText.CaretY := Line;
  fText.EnsureCursorPosVisible;
  if Line = fRunToCursorLine then begin
    ToggleBreakpoint(Line);
    fRunToCursorLine := -1;
  end;
end;

procedure TEditor.RemoveBreakpointFocus;
begin
  if fActiveLine <> -1 then
    fText.InvalidateLine(fActiveLine);
  fActiveLine := -1;
end;

procedure TEditor.UpdateCaption(NewCaption: string);
begin
  if assigned(fTabSheet) then
    fTabSheet.Caption := NewCaption;
end;

procedure TEditor.SetFileName(value: string);
begin
  if value <> fFileName then
  begin
    ffileName := value;
    UpdateCaption(ExtractfileName(fFileName));
  end;
end;

procedure TEditor.DrawGutterImages(ACanvas: TCanvas; AClip: TRect;
  FirstLine, LastLine: integer);
var
  LH, X, Y: integer;
  ImgIndex: integer;
begin
  X := 14;
  LH := fText.LineHeight;
  Y := (LH - dmMain.GutterImages.Height) div 2
    + LH * (FirstLine - fText.TopLine);

  while FirstLine <= LastLine do begin
    if HasBreakpoint(FirstLine) <> -1 then
      ImgIndex := 0
    else if fActiveLine = FirstLine then
      ImgIndex := 1
    else if fErrorLine = FirstLine then
      ImgIndex := 2
    else
      ImgIndex := -1;
    if ImgIndex >= 0 then
      dmMain.GutterImages.Draw(ACanvas, X, Y, ImgIndex);
    Inc(FirstLine);
    Inc(Y, LH);
  end;
end;

procedure TEditor.InsertDefaultText;
var
  tmp: TStrings;
begin
{$IFDEF WX_BUILD}
  if fEditorType = etSource then
  begin
{$ENDIF}
    if FileExists(devDirs.Config + DEV_DEFAULTCODE_FILE) then
    begin
      tmp := TStringList.Create;
      try
        tmp.LoadFromFile(devDirs.Config + DEV_DEFAULTCODE_FILE);
        InsertString(ParseMacros(tmp.Text), FALSE);
      finally
        tmp.Free;
      end;
    end;
  {$IFDEF WX_BUILD}
  end
  else
  begin
    if fDesigner <> nil then
    begin
      //I dont know how to make the editor to modified stated;
      //so I'm using the InsertString function
      InsertString(' ', FALSE);
      SetString(CompFileIo.ComponentToString(fDesigner));
    end;
  end;
  {$ENDIF}
end;

procedure TEditor.GotoLineNr(Nr: integer);
begin
{$IFDEF NEW_SYNEDIT} 
  fText.CaretXY:= BufferCoord(1, Nr);
{$ELSE}
  fText.CaretXY := point(1, Nr);
{$ENDIF}
  fText.TopLine := Nr;
  Activate;
end;

procedure TEditor.CodeRushLikeEditorKeyPress(Sender: TObject; var Key: Char);
var
    strComment:string;
begin

  if fCompletionBox.Enabled then
    Exit;

  //----------------------------------------------------------------------------
  //Guru: My Own CodeRush like Commentor :o)
    if fText.SelAvail then
    begin
        if (String(Key) = '/') and (trim(String(fText.SelText)) <> '') then
        begin
            Key:=#0;
            strComment:='/* '+fText.SelText+ ' */';
            fText.SelText:=strComment;
            Exit;
        end;
    end;
  //----------------------------------------------------------------------------
end;

//////// CODE-COMPLETION - mandrav /////////////
procedure TEditor.EditorKeyPress(Sender: TObject; var Key: Char);
var
  P: TPoint;
begin
  if Key = char($7F) then // happens when doing ctrl+backspace with completion on
    exit;
  if fCompletionBox.Enabled then
  begin
    if not (Sender is TForm) then
    begin // TForm is the code-completion window
      fTimer.Enabled := False;
      fTimerKey := Key;
      case Key of
        '.': fTimer.Enabled := True;
        '>': if (fText.CaretX > 1) and (Length(fText.LineText) > 0) and (fText.LineText[fText.CaretX - 1] = '-') then fTimer.Enabled := True;
        ':': if (fText.CaretX > 1) and (Length(fText.LineText) > 0) and (fText.LineText[fText.CaretX - 1] = ':') then fTimer.Enabled := True;
        ' ': if fCompletionEatSpace then Key := #0; // eat space if it was ctrl+space (code-completion)
      end;
{$IFDEF NEW_SYNEDIT}
      P.X:=fText.DisplayX;
      P.Y:=fText.DisplayY+16;
{$ELSE}
      P.X := fText.CaretXPix;
      P.Y := fText.CaretYPix + 16;
{$ENDIF}
      P := fText.ClientToScreen(P);
      fCompletionBox.Position := P;
    end
    else
    begin
      case Key of
        Char(vk_Back): if fText.SelStart > 0 then
          begin
            fText.SelStart := fText.SelStart - 1;
            fText.SelEnd := fText.SelStart + 1;
            fText.SelText := '';
            fCompletionBox.Search(nil, CurrentPhrase, fFileName);
          end;
        Char(vk_Return):
          begin
            SetEditorText(Key);
            fCompletionBox.Hide;
          end;
        ';', '(':
          begin
            SetEditorText(Key);
            fCompletionBox.Hide;
          end;
        '.', '>', ':':
          begin
            SetEditorText(Key);
            fCompletionBox.Search(nil, CurrentPhrase, fFileName);
          end;
      else if Key >= ' ' then
      begin
        fText.SelText := Key;
        fCompletionBox.Search(nil, CurrentPhrase, fFileName);
      end;
      end;
    end;
    fCompletionEatSpace := False;
  end;
end;

procedure TEditor.EditorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  M: TMemoryStream;
begin

  {** Modified by Peter **}
  if Key = VK_TAB then
  begin
    // Indent/Unindent selected text with TAB key, like Visual C++ ...
    if FText.SelText <> '' then
    begin
      if not (ssShift in Shift) then FText.ExecuteCommand(ecBlockIndent, #0, nil)
      else FText.ExecuteCommand(ecBlockUnindent, #0, nil);
      Abort;
    end;
  end;

  if fCompletionBox.Enabled then begin
    fCompletionBox.OnKeyPress := EditorKeyPress;
    if ssCtrl in Shift then
      if Key = vk_Space then begin
        Key := 0;
        if not (ssShift in Shift) then begin
          M := TMemoryStream.Create;
          try
            fText.Lines.SaveToStream(M);
            fCompletionBox.CurrentClass := MainForm.CppParser1.FindAndScanBlockAt(fFileName, fText.CaretY, M);
          finally
            M.Free;
          end;
          fCompletionBox.Search(nil, CurrentPhrase, fFileName);
        end;
        fCompletionEatSpace := True; // this is a hack. without this after ctrl+space, the space appears in the editor :(
      end;
  end
  else
  begin
    fText.OnKeyPress := CodeRushLikeEditorKeyPress;
  end;
end;

procedure TEditor.EditorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fText.Cursor := crIBeam;
end;

procedure TEditor.CompletionTimer(Sender: TObject);
var
  M: TMemoryStream;
  curr: string;
begin
  fTimer.Enabled := False;
  curr := CurrentPhrase;

{$IFDEF NEW_SYNEDIT}
  if not CheckAttributes(BufferCoord(fText.CaretX-1, fText.CaretY), curr) then begin
{$ELSE}
  if not CheckAttributes(Point(fText.CaretX - 1, fText.CaretY), curr) then begin
{$ENDIF}  
    if curr <> '::' then
    begin
        fTimerKey := #0;
        Exit;
    end;
  end;

  M := TMemoryStream.Create;
  try
    fText.Lines.SaveToStream(M);
    fCompletionBox.CurrentClass := MainForm.CppParser1.FindAndScanBlockAt(fFileName, fText.CaretY, M);
  finally
    M.Free;
  end;
  case fTimerKey of
    '.': fCompletionBox.Search(nil, curr, fFileName);
    '>': if fText.CaretX - 2 >= 0 then
        if fText.LineText[fText.CaretX - 2] = '-' then // it makes a '->'
          fCompletionBox.Search(nil, curr, fFileName);
    ':': if fText.CaretX - 2 >= 0 then
        if fText.LineText[fText.CaretX - 2] = ':' then // it makes a '::'
          fCompletionBox.Search(nil, curr, fFileName);
  end;
  fTimerKey := #0;
end;

procedure TEditor.ReconfigCompletion;
begin
  // re-read completion options
  fCompletionBox.Enabled := devClassBrowsing.Enabled and devCodeCompletion.Enabled;
  if fCompletionBox.Enabled then
    InitCompletion
  else
    DestroyCompletion;
end;

procedure TEditor.DestroyCompletion;
begin
  if Assigned(fTimer) then
    FreeAndNil(fTimer);
end;

procedure TEditor.InitCompletion;
begin
  fCompletionBox := MainForm.CodeCompletion1;
  fCompletionBox.Enabled := devCodeCompletion.Enabled;
  fCompletionBox.OnCompletion := DoOnCodeCompletion; {** Modified by Peter **}

  if fCompletionBox.Enabled then begin
    fText.OnKeyPress := EditorKeyPress;
    fText.OnKeyDown := EditorKeyDown;
    fText.OnKeyUp := EditorKeyUp;
    fCompletionBox.OnKeyPress := EditorKeyPress;
    fCompletionBox.Width := devCodeCompletion.Width;
    fCompletionBox.Height := devCodeCompletion.Height;

    if fTimer = nil then
      fTimer := TTimer.Create(nil);
    fTimer.Enabled := False;
    fTimer.OnTimer := CompletionTimer;
    fTimer.Interval := devCodeCompletion.Delay;
  end
  Else
  begin
    fText.OnKeyPress := CodeRushLikeEditorKeyPress;
  end;
  fCompletionEatSpace := False;
end;

function TEditor.CurrentPhrase: string;
var
  I: integer;
  AllowPar: boolean;
  NestedPar: integer;
begin
  I := fText.CaretX;
  Dec(I, 1);
  NestedPar := 0;
  AllowPar := ((Length(fText.LineText) > 1) and (Copy(fText.LineText, I - 1, 2) = ').')) or
    		   (Length(fText.LineText) > 2) and (Copy(fText.LineText, I - 2, 3) = ')->');
  while (I <> 0) and (fText.LineText <> '') and (fText.LineText[I] in ['A'..'Z', 'a'..'z', '0'..'9', '_', '.', '-', '>', ':', '(', ')', '[', ']']) do begin
    if (fText.LineText[I] = ')') then begin
      if not AllowPar then
        Break
      else
        Inc(NestedPar);
    end
    else if fText.LineText[I] = '(' then begin
      if AllowPar then begin
        if NestedPar > 0 then
          Dec(NestedPar)
        else
          AllowPar := False;
      end
      else
        Break;
    end;
    Dec(I, 1);
  end;
  Result := Copy(fText.LineText, I + 1, fText.CaretX - I - 1);
end;

procedure TEditor.SetEditorText(Key: Char);
var
  Phrase: string;
  I, CurrSel: integer;
  ST: PStatement;
  FuncAddOn: string;
begin
  ST := fCompletionBox.SelectedStatement;
  if fCompletionBox.SelectedIsFunction then begin
    if Key = ';' then
      FuncAddOn := '();'
    else if Key = '.' then
      FuncAddOn := '().'
    else if Key = '>' then
      FuncAddOn := '()->'
    else
      FuncAddOn := '()';
  end
  else begin
    if Key = Char(vk_Return) then
      FuncAddOn := ''
    else if Key = '>' then
      FuncAddOn := '->'
    else if Key = ':' then
      FuncAddOn := '::'
    else
      FuncAddOn := Key;
  end;

  if ST <> nil then begin
    Phrase := ST^._Command;

    // if already has a selection, delete it
    if fText.SelAvail then
      fText.SelText := '';

    // find the end of the word and delete from caretx to end of word
    CurrSel := fText.SelEnd;
    I := CurrSel;
    while (I < Length(fText.Text)) and (fText.Text[I] in ['A'..'Z', 'a'..'z','0'..'9', '_']) do
      Inc(I);
    fText.SelEnd := I;
    fText.SelText := '';

    // find the start of the word
    CurrSel := fText.SelStart;
    I := CurrSel;
    repeat
      Dec(I);
    until (I = 0) or not (fText.Text[I] in ['A'..'Z', 'a'..'z', '0'..'9', '_']);
{$IFDEF NEW_SYNEDIT}
    fText.SelStart:=I;
{$ELSE}
    fText.SelStart := I + 1;
{$ENDIF}
    fText.SelEnd := CurrSel;
    // don't add () if already there
    if fText.Text[CurrSel] = '(' then
      FuncAddOn := '';

    fText.SelText := Phrase + FuncAddOn;

    // if we added "()" move caret inside parenthesis
    // only if Key<>'.' and Key<>'>'
    // and function takes arguments...
    if (not (Key in ['.', '>'])) and (FuncAddOn <> '') and (Length(ST^._Args) > 2) then begin
      fText.CaretX := fText.CaretX - Length(FuncAddOn) + 1;
      // popup the arguments hint now
{$IFDEF NEW_SYNEDIT}
      fFunctionArgs.ExecuteEx(Phrase, fText.DisplayX, fText.DisplayY, ctParams);
{$ELSE}
      fFunctionArgs.ExecuteEx(Phrase, fText.CaretXPix, fText.CaretYPix, ctParams);
{$ENDIF}
    end;
  end;
end;

{$IFDEF NEW_SYNEDIT} 
function TEditor.CheckAttributes(P: TBufferCoord; Phrase: string): boolean;
{$ELSE}
function TEditor.CheckAttributes(P: TPoint; Phrase: string): boolean;
{$ENDIF}
var
  token: string;
  attri: TSynHighlighterAttributes;
begin
  fText.GetHighlighterAttriAtRowCol(P, token, attri);
  Result := not ((not Assigned(Attri)) or
    AnsiStartsStr('.', Phrase) or
    AnsiStartsStr('->', Phrase) or
    AnsiStartsStr('::', Phrase) or
    (
    Assigned(Attri) and
    (
    (Attri.Name = 'Preprocessor') or
    (Attri.Name = 'Comment') or
    (Attri.Name = 'String')
    )
    ));
end;

//////// CODE-COMPLETION - mandrav - END ///////

// variable info
procedure TEditor.EditorMouseMove(Sender: TObject; Shift: TShiftState; X, Y:Integer);
var s, s1: string;
{$IFDEF NEW_SYNEDIT}
    p : TBufferCoord;
{$ELSE}
  	p: TPoint;
{$ENDIF}
  	I,j: integer;
    attr:TSynHighlighterAttributes;
begin
  fHintTimer.Enabled := false;

  //check if not comment or string
  //if yes - exit without hint
  p := fText.DisplayToBufferPos(fText.PixelsToRowColumn(X, Y));
  if fText.GetHighlighterAttriAtRowCol(p, s, attr) then
    if (attr = fText.Highlighter.StringAttribute)
    or (attr = fText.Highlighter.CommentAttribute) then
    begin
      fText.Hint:='';
      Exit;
    end;

  if devEditor.ParserHints and  (not MainForm.fDebugger.Executing) then begin // editing - show declaration of word under cursor in a hint
{$IFDEF NEW_SYNEDIT}
    p.Char := X;
    p.Line := Y;
    p := fText.DisplayToBufferPos(fText.PixelsToRowColumn(p.Char, p.Line));
{$ELSE}
    p.X := X;
    p.Y := Y;
    p := fText.PixelsToRowColumn(p);
{$ENDIF}
    s := fText.GetWordAtRowCol(p);
  end
  else if devData.WatchHint and MainForm.fDebugger.Executing then begin // debugging - evaluate var under cursor and show value in a hint
{$IFDEF NEW_SYNEDIT}
    p := fText.DisplayToBufferPos(fText.PixelsToRowColumn(X, Y));
    I:=P.Char;
    s1:=fText.Lines[p.Line-1];
{$ELSE}
    p := fText.PixelsToRowColumn(Point(X, Y));
    I := P.X;
    s1 := fText.Lines[p.Y - 1];
{$ENDIF}
    if (I <> 0) and (s1 <> '') then
    begin
      j := Length(s1);
      while (I < j) and (s1[I] in ['A'..'Z', 'a'..'z', '0'..'9', '_']) do
      Inc(I);
    end;
{$IFDEF NEW_SYNEDIT}
    P.Char:=I;
{$ELSE}
    P.X := I;
{$ENDIF}
    Dec(I);
    if (s1 <> '') then
      while (I <> 0) and (s1[I] in ['A'..'Z', 'a'..'z', '0'..'9', '_', '.', '-', '>', '&', '*']) do
      Dec(I, 1);
{$IFDEF NEW_SYNEDIT}
    s := Copy(s1, I + 1, p.Char - I - 1);
{$ELSE}
    s := Copy(s1, I + 1, p.X - I - 1);
{$ENDIF}
    {if s<>MainForm.fDebugger.WatchVar then begin
      Application.HideHint;
      fCurrentHint := s;
    end;}
  end;

  if (s <> '') and (not fHintTimer.Enabled) then begin
    fHintTimer.Enabled := true;
    fCurrentHint := s;
  end
  else if s = '' then
    fText.Hint := '';

  if s<>'' then begin
    if ssCtrl in Shift then
      fText.Cursor := crHandPoint
    else
      fText.Cursor := crIBeam;
  end
  else
    fText.Cursor := crIBeam;
end;

procedure TEditor.EditorHintTimer(sender: TObject);
var
  r: TRect;
  p: TPoint;
  st: PStatement;
  M: TMemoryStream;
begin
  fHintTimer.Enabled := false;
  p := fText.ScreenToClient(Mouse.CursorPos);
  // is the mouse still inside the editor?
  if (p.X <= 0) or (p.X >= fText.Width) or
    (p.Y <= 0) or (p.Y >= fText.Height) then
    Exit;

  if fCurrentHint <> '' then begin
    if not MainForm.fDebugger.Executing then begin // editing - show declaration of word under cursor in a hint
      r.Left := Mouse.CursorPos.X;
      r.Top := Mouse.CursorPos.Y;
      r.Bottom := Mouse.CursorPos.Y + 10;
      r.Right := Mouse.CursorPos.X + 60;
      M := TMemoryStream.Create;
      try
        fText.Lines.SaveToStream(M);
{$IFDEF NEW_SYNEDIT}
        MainForm.CppParser1.FindAndScanBlockAt(fFileName, fText.PixelsToRowColumn(fText.ScreenToClient(Mouse.CursorPos).X,
          fText.ScreenToClient(Mouse.CursorPos).Y).Row, M)
{$ELSE}
        MainForm.CppParser1.FindAndScanBlockAt(fFileName, fText.PixelsToRowColumn(fText.ScreenToClient(Mouse.CursorPos)).Y, M)
{$ENDIF}
      finally
        M.Free;
      end;
      st := PStatement(MainForm.CppParser1.Locate(fCurrentHint, False));
      if Assigned(st) then begin
        fCurrentHint := st^._FullText;
        fCompletionBox.ShowMsgHint(r, fCurrentHint);
      end;
    end
    else if devData.WatchHint and MainForm.fDebugger.Executing then begin // debugging - evaluate var under cursor and show value in a hint
      MainForm.fDebugger.SendCommand(GDB_DISPLAY, fCurrentHint);
      {Sleep(25);
      fText.Hint:=MainForm.fDebugger.WatchVar+': '+MainForm.fDebugger.WatchValue;
      fText.ShowHint:=True;
      Application.ActivateHint(Mouse.CursorPos);}
    end;
  end;
end;

procedure TEditor.CommentSelection;
var
  S: string;
  Offset: integer;
{$IFDEF NEW_SYNEDIT} 
  backup: TBufferCoord;
{$ELSE}
  backup: TPoint;
{$ENDIF}
begin
  if Text.SelAvail then begin // has selection
    backup := Text.CaretXY;
    Text.BeginUpdate;
    S := '//' + Text.SelText;
    Offset := 0;
    if S[Length(S)]=#10 then begin // if the selection ends with a newline, eliminate it
      if S[Length(S) - 1] = #13 then // do we ignore 1 or 2 chars?
        Offset := 2
      else
        Offset := 1;
      S := Copy(S, 1, Length(S) - Offset);
    end;
    S := StringReplace(S, #10, #10'//', [rfReplaceAll]);
    if Offset = 1 then
      S := S + #10
    else if Offset = 2 then
      S := S + #13#10;
    Text.SelText := S;
    Text.EndUpdate;
    Text.CaretXY := backup;
  end
  else // no selection; easy stuff ;)
    Text.LineText := '//' + Text.LineText;
  Text.UpdateCaret;
  Text.Modified := True;
end;

{** Modified by Peter **}
procedure TEditor.IndentSelection;
begin
  if FText.SelAvail then
  begin
    FText.ExecuteCommand(ecBlockIndent, #0, nil);
  end;
end;

{** Modified by Peter **}
procedure TEditor.UnindentSelection;
begin
  if FText.SelAvail then
  begin
    FText.ExecuteCommand(ecBlockUnIndent, #0, nil);
  end;
end;


(*
// SynEdit has an indent/unindent command, no need to make it the hard way
procedure TEditor.IndentSelection;
var
  TabString: string; // customize depending on devEditor values
  S: string;
  Offset: integer;
  ss: integer;
  backup: TPoint;
begin
  // init TabString
  if not devEditor.TabToSpaces then // keep tabs
    TabString:=Char(VK_TAB)
  else
    TabString:=StringOfChar(Char(VK_SPACE), devEditor.TabSize);

  if Text.SelAvail then begin // has selection
    backup:=Text.CaretXY;
    Text.BeginUpdate;
    ss:=Text.SelStart;
    S:=#10+Text.SelText;
    Offset:=0;
    if S[Length(S)]=#10 then begin // if the selection ends with a newline, eliminate it
      if S[Length(S)-1]=#13 then // do we ignore 1 or 2 chars?
        Offset:=2
      else
        Offset:=1;
      S:=Copy(S, 1, Length(S)-Offset);
    end;
    S:=StringReplace(S, #10, #10+TabString, [rfReplaceAll]);
    if Offset=1 then
      S:=S+#10
    else if Offset=2 then
      S:=S+#13#10;
    Text.SelText:=Copy(S, 2, Length(S)-1);
    Text.SelStart:=ss;
    Text.SelEnd:=ss+Length(S)-1;
    Text.EndUpdate;
    Text.CaretXY:=backup;
  end
  else // no selection; easy stuff ;)
    Text.LineText:=TabString+Text.LineText;
  Text.Modified:=True;
end;


procedure TEditor.UnindentSelection;
var
  TabString: string; // customize depending on devEditor values
  S: string;
  ss: integer;
  backup: TPoint;
begin
  // init TabString
  TabString:=StringOfChar(Char(VK_SPACE), devEditor.TabSize);

  if Text.SelAvail then begin // has selection
    backup:=Text.CaretXY;
    Text.BeginUpdate;
    ss:=Text.SelStart;
    S:=Text.SelText;
    if Length(S)>=Length(TabString) then // sanity check
    begin
      if Copy(S,1,1)=#9 then
        S:=Copy(S, 2, Length(S)-1)
      else if Copy(S, 1, Length(TabString))=TabString then // if it starts with indent
        S:=Copy(S, Length(TabString)+1, Length(S)-Length(TabString)); // remove it
    end;
    S:=StringReplace(S, #10+TabString, #10#9, [rfReplaceAll]);
    S:=StringReplace(S, #10#9, #10, [rfReplaceAll]);
    Text.SelText:=S;
    Text.SelStart:=ss;
    Text.SelEnd:=ss+Length(S);
    Text.EndUpdate;
    Text.CaretXY:=backup;
  end
  else // no selection; easy stuff ;)
    if Length(Text.LineText)>=Length(TabString) then
    begin
      if Copy(Text.LineText,1,1)=#9 then
        Text.LineText:=Copy(Text.LineText, 2, Length(Text.LineText)-1)
      else if Copy(Text.LineText, 1, Length(TabString))=TabString then
        Text.LineText:=Copy(Text.LineText, Length(TabString)+1, Length(Text.LineText)-Length(TabString));
    end;
  Text.Modified:=True;
end;
*)


{** Modified by Peter **}
procedure TEditor.UncommentSelection;

  function FirstCharIndex(const S: string): Integer;
    //  Get the index of the first non whitespace character in
    //  the string specified by S
    //  On success it returns the index, otherwise it returns 0
  var
    I: Integer;
  begin
    Result := 0;

    if S <> '' then
      for I := 1 to Length(S) do
        if not (S[I] in [#0..#32]) then
        begin
          Result := I;
          Break;
        end;
  end;

var
  S: string;
  I: Integer;
  Idx: Integer;
  Strings: TStringList;
begin
  // has selection
  if Text.SelAvail then
  begin
    // start an undoblock, so we can undo
    // it afterwards!
    FText.BeginUndoBlock;

    Strings := TStringList.Create;
    try
      Strings.Text := FText.SelText;

      if Strings.Count > 0 then
      begin
        for I := 0 to Strings.Count - 1 do
        begin
          S := Strings.Strings[I];
          Idx := FirstCharIndex(S);

          // check if the very first two letters in the string are '//'
          // if they are, then delete them from the string and set the
          // modified string to the stringlist ...
          if (Length(S) > Idx) and (S[Idx] = '/') and (S[Idx + 1] = '/') then
          begin
            Delete(S, Idx, 2);
            Strings.Strings[I] := S;
          end;
        end;
      end;

      FText.SelText := Strings.Text;
    finally
      Strings.Free;
    end;

    FText.EndUndoBlock;
    FText.UpdateCaret;
    FText.Modified := True;
  end;
end;


procedure TEditor.EditorMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  procedure DoOpen(Fname: string; Line: integer; wrd: string);
  var
    e: TEditor;
    ws: integer;
  begin
    if fname = ExtractFileName(fname) then // no path info, so prepend path of active file
      fname := ExtractFilePath(fFileName) + fname;

    // refer to the editor of the filename (will open if needed and made active)
    e := MainForm.GetEditorFromFileName(fname);

    if Assigned(e) then begin
      // go to the specific line
      e.GotoLineNr(line);

      if wrd<>'' then begin
        // find the clicked word on this line and set the cursor on it ;)
        ws := AnsiPos(wrd, e.Text.LineText);
        if ws > 0 then
          e.Text.CaretX := ws;
      end;

      // remove any selection made by Synedit.OnMouseDown
      fText.BlockBegin := fText.CaretXY;
      fText.BlockEnd := fText.BlockBegin;
    end;
  end;
var
  p: TPoint;
  s, s1: string;
  I: integer;
  umSt: PStatement;
  fname: string;
  line: integer;
  f1, f2: integer;
begin
  p.X := X;
  p.Y := Y;
{$IFDEF NEW_SYNEDIT}
  p.X := fText.PixelsToRowColumn(p.X, p.Y).Column;
  p.Y := fText.PixelsToRowColumn(p.X, p.Y).Row;
  s := fText.GetWordAtRowCol(BufferCoord(p.X, p.Y));
{$ELSE}
  p := fText.PixelsToRowColumn(p);
  s := fText.GetWordAtRowCol(p);
{$ENDIF}

  // if ctrl+clicked
  if (ssCtrl in Shift) and (Button=mbLeft) then begin

    // reset the cursor
    fText.Cursor := crIBeam;

    // see if it's #include
    s1 := fText.Lines[p.Y - 1];
    s1 := StringReplace(s1, ' ', '', [rfReplaceAll]);
    if AnsiStartsStr('#include', s1) then begin
      // it is #include
      // check for #include <...>
      f1 := AnsiPos('<', s1);
      if f1>0 then begin
        Inc(f1);
        f2 := f1;
        while (f2 < Length(s1)) and (s1[f2] <> '>') do
          Inc(f2);
        if s1[f2] <> '>' then
          // not located...
          Abort;
        f2 := f2 - f1;
        DoOpen(MainForm.CppParser1.GetFullFileName(Copy(s1, f1, f2)), 1, '');
        // the mousedown must *not* get to the SynEdit or else it repositions the caret!!!
        Abort;
      end;

      f1 := AnsiPos('"', s1);
      // since we reached here, we haven't found it yet
      // check for #include "..."
      if f1>0 then begin
        Inc(f1);
        f2 := f1;
        while (f2 < Length(s1)) and (s1[f2] <> '"') do
          Inc(f2);
        if s1[f2] <> '"' then
          // not located...
          Abort;
        f2 := f2 - f1;
        DoOpen(MainForm.CppParser1.GetFullFileName(Copy(s1, f1, f2)), 1, '');
        // the mousedown must *not* get to the SynEdit or else it repositions the caret!!!
        Abort;
      end;

      // if we reached here, exit; we cannot locate and extract the filename...
      Exit;
    end; // #include


    umSt := nil;
    // if there *is* a word under the mouse cursor
    if S<>'' then begin
      // search for statement
      for I := 0 to MainForm.CppParser1.Statements.Count - 1 do
      if AnsiCompareStr(PStatement(MainForm.CppParser1.Statements[I])^._ScopelessCmd, S)=0 then begin
          umSt := PStatement(MainForm.CppParser1.Statements[I]);
          Break;
        end;
    end;

    // if statement found
    if Assigned(umSt) then begin
      // get the filename and the line number declared
      if umSt^._IsDeclaration then begin
        fname := umSt^._DeclImplFileName;
        line := umSt^._DeclImplLine;
      end
      else begin
        fname := umSt^._FileName;
        line := umSt^._Line;
      end;

      DoOpen(fname, line, s);

      // the mousedown must *not* get to the SynEdit or else it repositions the caret!!!
      Abort;
    end;
  end;
end;

procedure TEditor.RunToCursor(Line: integer);
begin
  if fRunToCursorLine <> -1 then
    ToggleBreakpoint(fRunToCursorLine);
  fRunToCursorLine := Line;
  ToggleBreakPoint(fRunToCursorLine);
end;

procedure TEditor.PaintMatchingBrackets(TransientType: TTransientType);
const
  BracketSet = ['{', '[', '(', '}', ']', ')'];
  OpenChars: array[0..2] of Char = ('{', '[', '(');
  CloseChars: array[0..2] of Char = ('}', ']', ')');

{$IFDEF NEW_SYNEDIT} 
  function CharToPixels(P: TBufferCoord): TPoint;
{$ELSE}
  function CharToPixels(P: TPoint): TPoint;
{$ENDIF}
  begin
{$IFDEF NEW_SYNEDIT}
    Result:= fText.RowColumnToPixels(fText.BufferToDisplayPos(p));
{$ELSE}
    Result := P;
    Result := fText.RowColumnToPixels(Result);
{$ENDIF}
  end;

var
{$IFDEF NEW_SYNEDIT}
    P: TBufferCoord;
{$ELSE}
    P: TPoint;
{$ENDIF}
    Pix: TPoint;
  S: string;
  I: Integer;
  Attri: TSynHighlighterAttributes;
begin
  P := fText.CaretXY;
  fText.GetHighlighterAttriAtRowCol(P, S, Attri);
  if Assigned(Attri) and (fText.Highlighter.SymbolAttribute = Attri) and
      (fText.CaretX<=length(fText.LineText) + 1) then begin
    for i := 0 to 2 do begin
      if (S = OpenChars[i]) or (S = CloseChars[i]) then begin
        Pix := CharToPixels(P);
        fText.Canvas.Brush.Style := bsSolid;
        fText.Canvas.Font.Assign(fText.Font);
        fText.Canvas.Font.Style := Attri.Style;

        if (TransientType = ttAfter) then begin
          fText.Canvas.Font.Color:= fText.Highlighter.WhitespaceAttribute.Background;
          fText.Canvas.Brush.Color := Attri.Foreground;
        end
        else begin
          fText.Canvas.Font.Color := Attri.Foreground;
          fText.Canvas.Brush.Color:= fText.Highlighter.WhitespaceAttribute.Background;
        end;

        fText.Canvas.TextOut(Pix.X, Pix.Y, S);
{$IFDEF NEW_SYNEDIT}
        P := fText.GetMatchingBracketEx(P);
{$ELSE}
        P := fText.GetMatchingBracketEx(P, True);
{$ENDIF}

{$IFDEF NEW_SYNEDIT}
        if (P.Char > 0) and (P.Line > 0) then begin
{$ELSE}
        if (P.X > 0) and (P.Y > 0) then begin
{$ENDIF}
          Pix := CharToPixels(P);
          if S = OpenChars[i] then
            fText.Canvas.TextOut(Pix.X, Pix.Y, CloseChars[i])
          else
            fText.Canvas.TextOut(Pix.X, Pix.Y, OpenChars[i]);
        end;
      end;
    end;
    fText.Canvas.Brush.Style := bsSolid;
  end;
end;

procedure TEditor.EditorPaintTransient(Sender: TObject; Canvas: TCanvas;
  TransientType: TTransientType);
begin
  if (not Assigned(fText.Highlighter)) or (devEditor.Match = false) then
    Exit;
  PaintMatchingBrackets(TransientType);
end;

{$IFDEF NEW_SYNEDIT}
procedure TEditor.FunctionArgsExecute(Kind: SynCompletionType; Sender: TObject;
  var AString: String; var x, y: Integer; var CanExecute: Boolean);
{$ELSE}
procedure TEditor.FunctionArgsExecute(Kind: SynCompletionType; Sender: TObject;
  var AString: string; x, y: Integer; var CanExecute: Boolean);
{$ENDIF}
var
  locline, lookup: string;
  TmpX, savepos, StartX,
    ParenCounter,
    TmpLocation: Integer;
  FoundMatch: Boolean;
  P: PStatement;
  sl: TList;
begin

  sl := nil;
  P := nil;
  try
    with TSynCompletionProposal(Sender).Editor do
    begin
      locLine := LineText;

      //go back from the cursor and find the first open paren
      TmpX := CaretX;
      if TmpX > length(locLine) then
        TmpX := length(locLine)
      else
        dec(TmpX);
      FoundMatch := False;
      TmpLocation := 0;
      while (TmpX > 0) and not (FoundMatch) do
      begin
        if LocLine[TmpX] = ',' then begin
          inc(TmpLocation);
          dec(TmpX);
        end
        else if LocLine[TmpX] = ')' then begin
          //We found a close, go till it's opening paren
          ParenCounter := 1;
          dec(TmpX);
          while (TmpX > 0) and (ParenCounter > 0) do begin
            if LocLine[TmpX] = ')' then
              inc(ParenCounter)
            else if LocLine[TmpX] = '(' then
              dec(ParenCounter);
            dec(TmpX);
          end;
          if TmpX > 0 then
            dec(TmpX); //eat the open paren
        end
        else if locLine[TmpX] = '(' then begin
          //we have a valid open paren, lets see what the word before it is
          StartX := TmpX;
          while (TmpX > 0) and not (locLine[TmpX] in TSynValidStringChars) do
            Dec(TmpX);
          if TmpX > 0 then begin
            SavePos := TmpX;
            while (TmpX > 0) and (locLine[TmpX] in TSynValidStringChars) do
              dec(TmpX);
            inc(TmpX);
            lookup := Copy(LocLine, TmpX, SavePos - TmpX + 1);
            if Assigned(fLastParamFunc) then begin
              if (fLastParamFunc.Count > 0) then
                if (PStatement(fLastParamFunc.Items[0])^._Command = lookup) then // this avoid too much calls to CppParser.FillListOf
                  sl := fLastParamFunc;
            end;
            if not Assigned(sl) then begin
              //P:=MainForm.CppParser1.Locate(lookup, False);  // we should really avoid a Locate for each char typed, this call takes a long time to execute when the cache is huge
              sl := TList.Create;
              if MainForm.CppParser1.FillListOf(Lookup, False, sl) then begin  // and try to use only a minimum of FillListOf
                if Assigned(fLastParamFunc) then
                  FreeAndNil(fLastParamFunc);
                fLastParamFunc := sl;
              end
              else
                FreeAndNil(sl);
            end;
            FoundMatch := Assigned(sl);
            if not(FoundMatch) then begin
              TmpX := StartX;
              dec(TmpX);
            end;
          end;
        end
        else
          dec(TmpX);
      end;
    end;

    CanExecute := FoundMatch;

    {** Modified by Peter **}
    // no longer needed, check 'DoOnCodeCompletion' below ...
    {
    if FoundMatch then
    begin
      FCodeToolTip.Show;
      TmpX := TSynCompletionProposal(Sender).Form.InsertList.Count;
      if TmpX > 0 then
      begin
        LookUp := TSynCompletionProposal(Sender).Form.ItemList.Strings[TmpX];
        FCodeToolTip.Select(LookUp);
      end;
    end;  }

    {** Modified by Peter **}
    { removed old tooltip stuff
    TSynCompletionProposal(Sender).ItemList.Clear;
    if CanExecute then begin
      for I:=0 to sl.Count-1 do begin
        P:=PStatement(sl[I]);
        TSynCompletionProposal(Sender).Form.CurrentIndex := TmpLocation;
        if P^._ScopelessCmd <> TSynCompletionProposal(Sender).PreviousWord then begin
          if (P^._Args<>'') then begin
            if (P^._Args[1]='(') then
              TSynCompletionProposal(Sender).ItemList.Add(Copy(P^._Args, 2, Length(P^._Args)-2))
            else
              TSynCompletionProposal(Sender).ItemList.Add(P^._Args);
          end;
        end;
      end;
    end }
  finally

  end;
end;

{** Modified by Peter **}
// added on 25th march 2004
procedure TEditor.DoOnCodeCompletion(Sender: TObject; const AStatement: TStatement; const AIndex: Integer);
//
//  this event is triggered whenever the codecompletion box is going to make its work,
//  or in other words, when it did a codecompletion ...
//
begin
  // disable the tooltip here, becasue we check against Enabled
  // in the 'EditorStatusChange' event to prevent it's redrawing there
  if FCodeToolTip <> nil then
  begin
    //FCodeToolTip may not be initialized under some
    //circumstances when create TEditor
    //I suspect it's in TProject.OpenUnit --specu
  FCodeToolTip.Enabled := False;
  FCodeToolTip.ReleaseHandle;
  FCodeToolTip.Show;
  FCodeToolTip.Select(AStatement._FullText);
  FCodeToolTip.Enabled := True;
  end;

  // ???: when we don't invalidate the SynEditor here, it occurs sometimes
  //      that fragments of the codecompletion listbox are stuff displayed
  //      on the SynEdit. - strange :)
  fText.Invalidate;
end;

// Editor needs to be told when class browser has been recreated otherwise AV !

procedure TEditor.UpdateParser;
begin
  FCodeToolTip.Parser := MainForm.CppParser1;
end;
////

{$IFDEF WX_BUILD}
function TEditor.isForm: Boolean;
begin
  if fEditorType = etForm then
    Result := True
  else
    Result := false;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TEditor.ActivateDesigner;
begin
  if isForm then
  begin
    if Assigned(fDesigner) then
    begin
      MainForm.ELDesigner1.Active := False;
      try
        MainForm.ELDesigner1.DesignControl:=nil;
        MainForm.ELDesigner1.DesignControl := fDesigner;
        MainForm.ELDesigner1.Active := True;
      except
        if isForm then
        begin
        end;
      end;
      //MainForm.ELDesigner1.Active := True;
      MainForm.BuildComponentList(fDesigner);
    end;
  end;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TEditor.UpdateDesignerData;
var
  e: TEditor;
begin
  if isForm then
  begin
    Modified:=true;
    InsertDefaultText;

    if FileExists(ChangeFileExt(FileName, CPP_EXT)) then
    begin
      MainForm.OpenFile(ChangeFileExt(FileName, CPP_EXT), true);

      e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, CPP_EXT));
      if Assigned(e) then
      begin
        try
          GenerateCpp(fDesigner, fDesigner.Wx_Name, e.Text,e.FileName);
          e.Modified:=true;
        except
        end;
        e.InsertString('', false);
      end;

    end;

    if FileExists(ChangeFileExt(FileName, H_EXT)) then
    begin
      MainForm.OpenFile(ChangeFileExt(FileName, H_EXT), true);
      e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, H_EXT));
      if Assigned(e) then
      begin
        try
          GenerateHpp(fDesigner, fDesigner.Wx_Name, e.Text);
          e.Modified:=true;
        except
        end;
        e.InsertString('', false);
      end;
    end;
  end;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
function TEditor.GetDesigner: TfrmNewForm;
begin
  if isForm then
    Result := fDesigner
  else
    Result := nil;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
procedure TEditor.InitDesignerData(strFName, strCName, strFTitle: string;
  dlgSStyle: TWxDlgStyleSet);
begin
  fDesignerClassName := strCName;
  fDesignerTitle := strFTitle;
  fDesignerStyle := dlgSStyle;
  fDesignerDefaultData := True;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
function TEditor.GetDesignerHPPFileName: string;
begin
  if not isForm then
    Exit;

  if FileExists(ChangeFileExt(FileName, H_EXT)) then
    Result := ChangeFileExt(FileName, H_EXT);
end;
{$ENDIF}

  {$IFDEF WX_BUILD}
function TEditor.GetDesignerCPPFileName: string;
begin
  if not isForm then
    Exit;

  if FileExists(ChangeFileExt(FileName, CPP_EXT)) then
    Result := ChangeFileExt(FileName, CPP_EXT);
end;
{$ENDIF}

{$IFDEF WX_BUILD}
function TEditor.GetDesignerHPPText: TSynEdit;
var
  e: TEditor;
begin
  Result := nil;
  if FileExists(ChangeFileExt(FileName, H_EXT)) then
  begin
    e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, H_EXT));

    if not Assigned(e) then
    begin
      MainForm.OpenFile(ChangeFileExt(FileName, H_EXT), true);
      e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, H_EXT));
    end;

    if Assigned(e) then
    begin
      Result := e.Text;
    end;
  end;
end;

{$ENDIF}

{$IFDEF WX_BUILD}

function TEditor.GetDesignerCPPText: TSynEdit;
var
  e: TEditor;
begin
  Result := nil;
  if FileExists(ChangeFileExt(FileName, CPP_EXT)) then
  begin
    e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, CPP_EXT));

    if not Assigned(e) then
    begin
      MainForm.OpenFile(ChangeFileExt(FileName, CPP_EXT), true);
      e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, CPP_EXT));
    end;

    if Assigned(e) then
    begin
      Result := e.Text;
    end;
  end;
end;
  {$ENDIF}

  {$IFDEF WX_BUILD}
function TEditor.IsDesignerHPPOpened: Boolean;
begin
    Result := MainForm.isFileOpenedinEditor(ChangeFileExt(FileName, H_EXT));
end;
{$ENDIF}

{$IFDEF WX_BUILD}

function TEditor.IsDesignerCPPOpened: Boolean;
begin
    Result := MainForm.isFileOpenedinEditor(ChangeFileExt(FileName, CPP_EXT));
end;
{$ENDIF}

  {$IFDEF WX_BUILD}
function TEditor.GetDesignerHPPEditor: TEditor;
var
  e: TEditor;
begin
  Result := nil;
  if FileExists(ChangeFileExt(FileName, H_EXT)) then
  begin
    e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, H_EXT));

    if not Assigned(e) then
    begin
      MainForm.OpenFile(ChangeFileExt(FileName, H_EXT), true);
      e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, H_EXT));
    end;
    if Assigned(e) then
    begin
      Result := e;
    end;
  end;
end;
{$ENDIF}

{$IFDEF WX_BUILD}
function TEditor.GetDesignerCPPEditor: TEditor;
var
  e: TEditor;
begin
  Result := nil;
  if FileExists(ChangeFileExt(FileName, CPP_EXT)) then
  begin
    e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, CPP_EXT));

    if not Assigned(e) then
    begin
      MainForm.OpenFile(ChangeFileExt(FileName, CPP_EXT), true);
      e := MainForm.GetEditorFromFileName(ChangeFileExt(FileName, CPP_EXT));
    end;

    if Assigned(e) then
    begin
      Result := e;
    end;
  end;
end;
{$ENDIF}

{$IFDEF WX_BUILD}

procedure TEditor.ReloadForm;
var
    I:Integer;
begin
    if not self.isForm then
        exit;
    //Delete all the Components and
    for I := self.fDesigner.ComponentCount -1  downto 0 do    // Iterate
    begin
        self.fDesigner.Components[i].Destroy;
    end;    // for
    ReadComponentFromFile(self.fDesigner, self.FileName);
end;

procedure TEditor.ReloadFormFromFile(strFilename:String);
var
    I:Integer;
begin
    if not self.isForm then
        exit;
    //Delete all the Components and
    for I := self.fDesigner.ComponentCount -1  downto 0 do    // Iterate
    begin
        self.fDesigner.Components[i].Destroy;
    end;    // for
    ReadComponentFromFile(self.fDesigner, strFilename);
end;


{$ENDIF}

end.

