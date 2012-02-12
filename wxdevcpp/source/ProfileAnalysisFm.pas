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

Unit ProfileAnalysisFm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ComCtrls, ExtCtrls, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QComCtrls, QExtCtrls;
{$ENDIF}

Type
    TProfileAnalysisForm = Class(TForm)
        Panel1: TPanel;
        btnClose: TButton;
        Panel2: TPanel;
        PageControl1: TPageControl;
        tabFlat: TTabSheet;
        Splitter2: TSplitter;
        memFlat: TMemo;
        lvFlat: TListView;
        tabGraph: TTabSheet;
        Splitter1: TSplitter;
        memGraph: TMemo;
        lvGraph: TListView;
        XPMenu: TXPMenu;
        Procedure FormShow(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure btnCloseClick(Sender: TObject);
        Procedure FormPaint(Sender: TObject);
        Procedure lvGraphCustomDrawItem(Sender: TCustomListView;
            Item: TListItem; State: TCustomDrawState; Var DefaultDraw: Boolean);
        Procedure lvFlatCustomDrawItem(Sender: TCustomListView;
            Item: TListItem; State: TCustomDrawState; Var DefaultDraw: Boolean);
        Procedure lvFlatMouseMove(Sender: TObject; Shift: TShiftState; X,
            Y: Integer);
        Procedure lvFlatClick(Sender: TObject);
        Procedure PageControl1Change(Sender: TObject);
    Private
        { Private declarations }
        Procedure LoadText;
        Procedure DoFlat;
        Procedure DoGraph;
    Public
        { Public declarations }
    End;

Var
    ProfileAnalysisForm: TProfileAnalysisForm;

Implementation

Uses
{$IFDEF WIN32}
    devcfg, version, utils, main, ShellAPI, StrUtils,
    MultiLangSupport, CppParser,
    editor;
{$ENDIF}
{$IFDEF LINUX}
  devcfg, version, utils, main, StrUtils, MultiLangSupport, CppParser,
  editor, Types;
{$ENDIF}

{$R *.dfm}

Procedure TProfileAnalysisForm.FormShow(Sender: TObject);
Begin
    LoadText;
    PageControl1.Visible := False;
End;

Procedure TProfileAnalysisForm.FormClose(Sender: TObject;
    Var Action: TCloseAction);
Begin
    Action := caFree;
    ProfileAnalysisForm := Nil;
End;

Procedure TProfileAnalysisForm.btnCloseClick(Sender: TObject);
Begin
    Close;
End;

Procedure TProfileAnalysisForm.DoFlat;
Var
    Cmd: String;
    Params: String;
    Dir: String;
    I: Integer;
    Line: String;
    Parsing: Boolean;
    Done: Boolean;
    BreakLine: Integer;
Begin
    If (devCompiler.gprofName <> '') Then
        Cmd := devCompiler.gprofName
    Else
        Cmd := PROF_PROGRAM(0);
    If Assigned(MainForm.fProject) Then
    Begin
        Dir := ExtractFilePath(MainForm.fProject.Executable);
        Params := GPROF_CMD_GENFLAT + ' "' +
            ExtractFileName(MainForm.fProject.Executable) + '"';
    End
    Else
    Begin
        Dir := ExtractFilePath(MainForm.GetEditor.FileName);
        // GAR 10 Nov 2009
        // Hack for Wine/Linux
        // ProductName returns empty string for Wine/Linux
        // for Windows, it returns OS name (e.g. Windows Vista).
        If (MainForm.JvComputerInfoEx1.OS.ProductName = '') Then
            Params := GPROF_CMD_GENFLAT + ' "' +
                ExtractFileName(ChangeFileExt(MainForm.GetEditor.FileName, '')) + '"'
        Else
            Params := GPROF_CMD_GENFLAT + ' "' +
                ExtractFileName(ChangeFileExt(MainForm.GetEditor.FileName, EXE_EXT)) + '"';
    End;

    memFlat.Lines.Text := RunAndGetOutput(Cmd + ' ' + Params,
        Dir, Nil, Nil, Nil, False);
    memFlat.SelStart := 0;

    BreakLine := -1;
    I := 0;
    Parsing := False;
    Done := False;
    While (I < memFlat.Lines.Count) And Not Done Do
    Begin
        Line := memFlat.Lines[I];

        // parse
        If Parsing Then
        Begin
            If Trim(Line) = '' Then
            Begin
                BreakLine := I;
                Break;
            End;

            With lvFlat.Items.Add Do
            Begin
                Caption := Trim(Copy(Line, 55, Length(Line) - 54));

                // remove arguments - if exists
                If AnsiPos('(', Caption) > 0 Then
                    Data := MainForm.CppParser1.Locate(Copy(Caption, 1,
                        AnsiPos('(', Caption) - 1), True)
                Else
                    Data := MainForm.CppParser1.Locate(Caption, True);

                SubItems.Add(Trim(Copy(Line, 1, 6)));
                SubItems.Add(Trim(Copy(Line, 7, 12)));
                SubItems.Add(Trim(Copy(Line, 19, 11)));
                SubItems.Add(Trim(Copy(Line, 30, 7)));
                SubItems.Add(Trim(Copy(Line, 37, 9)));
                SubItems.Add(Trim(Copy(Line, 46, 9)));
            End;
        End
        Else
        Begin
            Parsing := AnsiStartsText('%', Trim(Line));
            If Parsing Then
                Inc(I); // skip over next line too
        End;
        Inc(I);
    End;
    For I := 0 To BreakLine Do
        TStringList(memFlat.Lines).Delete(0);
End;

Procedure TProfileAnalysisForm.DoGraph;
Var
    Cmd: String;
    Params: String;
    Dir: String;
    I: Integer;
    Line: String;
    Parsing: Boolean;
    Done: Boolean;
    BreakLine: Integer;
Begin
    If (devCompiler.gprofName <> '') Then
        Cmd := devCompiler.gprofName
    Else
        Cmd := PROF_PROGRAM(0);

    If Assigned(MainForm.fProject) Then
    Begin
        Dir := ExtractFilePath(MainForm.fProject.Executable);
        Params := GPROF_CMD_GENMAP + ' "' +
            ExtractFileName(MainForm.fProject.Executable) + '"';
    End
    Else
    Begin
        Dir := ExtractFilePath(MainForm.GetEditor.FileName);

        // GAR 10 Nov 2009
        // Hack for Wine/Linux
        // ProductName returns empty string for Wine/Linux
        // for Windows, it returns OS name (e.g. Windows Vista).
        If (MainForm.JvComputerInfoEx1.OS.ProductName = '') Then
            Params := GPROF_CMD_GENMAP + ' "' +
                ExtractFileName(ChangeFileExt(MainForm.GetEditor.FileName, '')) + '"'
        Else
            Params := GPROF_CMD_GENMAP + ' "' +
                ExtractFileName(ChangeFileExt(MainForm.GetEditor.FileName, EXE_EXT)) + '"';
    End;

    memGraph.Lines.Text := RunAndGetOutput(Cmd + ' ' + Params,
        Dir, Nil, Nil, Nil, False);
    memGraph.SelStart := 0;

    BreakLine := -1;
    I := 0;
    Parsing := False;
    Done := False;
    While (I < memGraph.Lines.Count) And Not Done Do
    Begin
        Line := memGraph.Lines[I];

        // parse
        If Parsing Then
        Begin
            If Trim(Line) = '' Then
            Begin
                BreakLine := I;
                Break;
            End;

            If Not AnsiStartsText('---', Line) Then
            Begin
                With lvGraph.Items.Add Do
                Begin
                    Caption := Trim(Copy(Line, 46, Length(Line) - 45));

                    // remove arguments - if exists
                    If AnsiPos('(', Caption) > 0 Then
                        Data := MainForm.CppParser1.Locate(Copy(Caption,
                            1, AnsiPos('(', Caption) - 1), True)
                    Else
                        Data := MainForm.CppParser1.Locate(Caption, True);

                    SubItems.Add(Trim(Copy(Line, 1, 5)));
                    SubItems.Add(Trim(Copy(Line, 6, 11)));
                    SubItems.Add(Trim(Copy(Line, 17, 6)));
                    SubItems.Add(Trim(Copy(Line, 23, 11)));
                    SubItems.Add(Trim(Copy(Line, 34, 12)));
                End;
            End
            Else
                lvGraph.Items.Add;
        End
        Else
            Parsing := AnsiStartsText('index %', Trim(Line));
        Inc(I);
    End;
    For I := 0 To BreakLine Do
        TStringList(memGraph.Lines).Delete(0);
End;

Procedure TProfileAnalysisForm.FormPaint(Sender: TObject);
Begin
    Inherited;
    OnPaint := Nil;

    Screen.Cursor := crHourglass;
    Application.ProcessMessages;
    Try
        DoFlat;
    Except
        lvFlat.Items.Add.Caption := '<Error parsing output>';
    End;

    Application.ProcessMessages;
    Try
        DoGraph;
    Except
        lvGraph.Items.Add.Caption := '<Error parsing output>';
    End;

    Screen.Cursor := crDefault;
    PageControl1.ActivePage := tabFlat;
    PageControl1.Visible := True;
    lvFlat.SetFocus;
End;

Procedure TProfileAnalysisForm.lvFlatCustomDrawItem(
    Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
    Var DefaultDraw: Boolean);
Begin
    If Not (cdsSelected In State) Then
    Begin
        If Assigned(Item.Data) Then
            Sender.Canvas.Font.Color := clBlue
        Else
            Sender.Canvas.Font.Color := clWindowText;
    End;
End;

Procedure TProfileAnalysisForm.lvGraphCustomDrawItem(
    Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
    Var DefaultDraw: Boolean);
Begin
    If Not (cdsSelected In State) Then
    Begin
        If (Item.SubItems.Count > 0) And (Item.SubItems[0] <> '') Then
        Begin
            If Assigned(Item.Data) Then
                Sender.Canvas.Font.Color := clBlue
            Else
                Sender.Canvas.Font.Color := clWindowText;
        End
        Else
            Sender.Canvas.Font.Color := clGray;
    End;

    DefaultDraw := True;
End;

Procedure TProfileAnalysisForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_PROF_CAPTION];
    tabFlat.Caption := Lang[ID_PROF_TABFLAT];
    tabGraph.Caption := Lang[ID_PROF_TABGRAPH];
    btnClose.Caption := Lang[ID_BTN_CLOSE];
End;

Procedure TProfileAnalysisForm.lvFlatMouseMove(Sender: TObject;
    Shift: TShiftState; X, Y: Integer);
Var
    It: TListItem;
Begin
    With Sender As TListView Do
    Begin
        It := GetItemAt(X, Y);
        If Assigned(It) And Assigned(It.Data) Then
            Cursor := crHandPoint
        Else
            Cursor := crDefault;
    End;
End;

Procedure TProfileAnalysisForm.lvFlatClick(Sender: TObject);
Var
    It: TListItem;
    P: TPoint;
    e: TEditor;
Begin
    P := TListView(Sender).ScreenToClient(Mouse.CursorPos);
    It := TListView(Sender).GetItemAt(P.X, P.Y);
    If Assigned(It) And Assigned(It.Data) Then
    Begin
        e := MainForm.GetEditorFromFileName(
            MainForm.CppParser1.GetImplementationFileName(PStatement(It.Data)));
        If Assigned(e) Then
        Begin
            e.GotoLineNr(MainForm.CppParser1.GetImplementationLine(
                PStatement(It.Data)));
            e.Activate;
        End;
    End;
End;

Procedure TProfileAnalysisForm.PageControl1Change(Sender: TObject);
Begin
    If PageControl1.ActivePage = tabFlat Then
        lvFlat.SetFocus
    Else
        lvGraph.SetFocus;
End;

End.
