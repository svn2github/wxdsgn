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

Unit CodeCompletionForm;

Interface

Uses
{$IFDEF WIN32}
    Windows, SysUtils, Variants, Classes, Graphics, Forms, StdCtrls, Controls,
    CodeCompletion, CppParser, Grids, Dialogs;
{$ENDIF}
{$IFDEF LINUX}
  Xlib, SysUtils, Variants, Classes, QGraphics, QForms, QStdCtrls, QControls,
  CodeCompletion, CppParser, QGrids, QDialogs, Types;
{$ENDIF}

Type
  {** Modified by Peter **}
    TCompletionEvent = Procedure(Sender: TObject; Const AStatement: TStatement; Const AIndex: Integer) Of Object;

    TCodeComplForm = Class(TForm)
        lbCompletion: TListBox;
        Procedure FormShow(Sender: TObject);
        Procedure FormDeactivate(Sender: TObject);
        Procedure lbCompletionDblClick(Sender: TObject);
        Procedure lbCompletionDrawItem(Control: TWinControl; Index: Integer;
            Rect: TRect; State: TOwnerDrawState);
        Procedure lbCompletionKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
    Private
    { Private declarations }
        fOwner: TCodeCompletion;
        fColor: TColor;
        FOnCompletion: TCompletionEvent; {** Modified by Peter **}
    Protected
        Procedure DoCompletion; Virtual;
    Public
    { Public declarations }
        fCompletionStatementList: TList;
        fParser: TCppParser;
        Constructor Create(AOwner: TComponent); Override;
        Procedure CreateParams(Var Params: TCreateParams); Override;
        Procedure SetColor(Value: TColor);
    Published
        Property OnCompletion: TCompletionEvent Read FOnCompletion Write FOnCompletion; {** Modified by Peter **}
    End;

Var
    CodeComplForm: TCodeComplForm;

Implementation

{$R *.dfm}

Procedure TCodeComplForm.FormShow(Sender: TObject);
Begin
    Width := fOwner.Width;
    Height := fOwner.Height;
    lbCompletion.Font.Name := 'Tahoma';  {** Modified by Peter **}
    lbCompletion.Font.Size := 8; {** Modified by Peter **}
    lbCompletion.DoubleBuffered := True;
    lbCompletion.SetFocus;
    If lbCompletion.Items.Count > 0 Then
        lbCompletion.ItemIndex := 0;
End;

Procedure TCodeComplForm.FormDeactivate(Sender: TObject);
Begin
    Hide;
End;

Procedure TCodeComplForm.CreateParams(Var Params: TCreateParams);
Begin
    Inherited CreateParams(Params);

    Params.Style := Params.Style Or WS_SIZEBOX;
End;

Constructor TCodeComplForm.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);

    fOwner := TCodeCompletion(AOwner);
End;

{** Modified by Peter **}
Procedure TCodeComplForm.DoCompletion;
Begin
    Hide;
    Application.ProcessMessages;

    With lbCompletion Do
    Begin
        If (FCompletionStatementList.Count > ItemIndex) And (ItemIndex > -1) Then
        Begin
            If Assigned(FOnCompletion) Then
                FOnCompletion(FOwner, PStatement(FCompletionStatementList[ItemIndex])^, ItemIndex);
        End;
    End;
End;

Procedure TCodeComplForm.SetColor(Value: TColor);
Begin
    If Value <> fColor Then
    Begin
        fColor := Value;
        lbCompletion.Color := fColor;
        Color := fColor;
    End;
End;

Procedure TCodeComplForm.lbCompletionDblClick(Sender: TObject);
Var
    Key: Char;
Begin
    If Assigned(OnKeyPress) Then
    Begin
        Key := #13;
        OnKeyPress(Self, Key);
    End;
  {** Modified by Peter **}
    DoCompletion;
  //Hide;
End;

Procedure TCodeComplForm.lbCompletionDrawItem(Control: TWinControl;
    Index: Integer; Rect: TRect; State: TOwnerDrawState);
Var
    Offset: Integer;
    C, BC: TColor;
Begin
    If fCompletionStatementList = Nil Then
        Exit;
    If Not lbCompletion.Visible Then
        Exit;
    If fCompletionStatementList.Count <= Index {+ 1  ??? } Then
        Exit;
    If fCompletionStatementList[Index] = Nil Then
        Exit;


    With lbCompletion Do
    Begin
        If fCompletionStatementList.Count > 0 Then
        Begin
            If odSelected In State Then
            Begin
                Canvas.Brush.Color := clHighlight;
                Canvas.FillRect(Rect);
                Canvas.Font.Color := clHighlightText;
            End
            Else
            Begin
                Canvas.Brush.Color := fColor;
                Canvas.FillRect(Rect);
                Case PStatement(fCompletionStatementList[Index])^._Kind Of
                    skFunction:
                        Canvas.Font.Color := clGreen;
                    skClass:
                        Canvas.Font.Color := clMaroon;
                    skVariable:
                        Canvas.Font.Color := clBlue;
                    skTypedef:
                        Canvas.Font.Color := clOlive;
                    skPreprocessor:
                        Canvas.Font.Color := clPurple;
                    skEnum:
                        Canvas.Font.Color := clNavy;
                Else
                    Canvas.Font.Color := clGray;
                End;
            End;

            Offset := Rect.Bottom - Rect.Top;
            C := Canvas.Font.Color;
            BC := Canvas.Brush.Color;
            Canvas.Font.Color := clWhite;
            Canvas.Pen.Style := psClear;
            Canvas.Rectangle(Rect.Left, Rect.Top, Rect.Left + Offset, Rect.Bottom);
            Case PStatement(fCompletionStatementList[Index])^._ClassScope Of
                scsPrivate:
                    Canvas.Brush.Color := clRed;
                scsProtected:
                    Canvas.Brush.Color := clMaroon;
                scsPublic, scsPublished:
                    Canvas.Brush.Color := clGreen;
            End;
            Canvas.Rectangle(Rect.Left + 4, Rect.Top + 4, Rect.Left + Offset - 4, Rect.Bottom - 4);
            Inc(Offset, 8);

            Canvas.Brush.Color := BC;
            Canvas.Font.Color := C;
            Canvas.TextOut(Rect.Left + Offset, Rect.Top, fParser.StatementKindStr(PStatement(fCompletionStatementList[Index])^._Kind));
            If Not (odSelected In State) Then
                Canvas.Font.Color := clWindowText;
            Canvas.Font.Style := [];

            Canvas.TextOut(64 + Rect.Left + Offset, Rect.Top, PStatement(fCompletionStatementList[Index])^._Type);
            Offset := Offset + Canvas.TextWidth(PStatement(fCompletionStatementList[Index])^._Type + ' ');
            Canvas.Font.Style := [fsBold];
            Canvas.TextOut(64 + Rect.Left + Offset, Rect.Top, PStatement(fCompletionStatementList[Index])^._ScopelessCmd);
            Offset := Offset + Canvas.TextWidth(PStatement(fCompletionStatementList[Index])^._ScopelessCmd + ' ');
            Canvas.Font.Style := [];
            Canvas.TextOut(64 + Rect.Left + Offset, Rect.Top, PStatement(fCompletionStatementList[Index])^._Args);
        End;
    End;
End;

Procedure TCodeComplForm.lbCompletionKeyDown(Sender: TObject;
    Var Key: Word; Shift: TShiftState);
Begin
  {** Modified by Peter **}
    Case Key Of
{$IFDEF WIN32}
        VK_TAB,
        VK_RETURN:
{$ENDIF}
{$IFDEF LINUX}
    XK_TAB,
    XK_RETURN:     
{$ENDIF}
        Begin
            DoCompletion;
        End;
    End;
End;



End.
