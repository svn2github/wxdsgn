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

(* derived from the free pascal editor project source *)
Unit Incrementalfrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, ActnList, SynEdit, SynEditTypes;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QActnList, QSynEdit, QSynEditTypes;
{$ENDIF}

Type
    TfrmIncremental = Class(TForm)
        Edit: TEdit;
        ActionList1: TActionList;
        SearchAgain: TAction;
        Procedure EditChange(Sender: TObject);
        Procedure FormShow(Sender: TObject);
        Procedure EditKeyPress(Sender: TObject; Var Key: Char);
        Procedure SearchAgainExecute(Sender: TObject);
        Procedure EditKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
    Private
        rOptions: TSynSearchOptions;
    Public
        SearchString: String;
        Editor: TSynEdit;
        OrgPt: TBufferCoord;
    Protected
        Procedure CreateParams(Var Params: TCreateParams); Override;
    End;

Var
    frmIncremental: TfrmIncremental;

Implementation

{$R *.dfm}

Uses
{$IFDEF WIN32}
    main;
{$ENDIF}
{$IFDEF LINUX}
  Xlib, main;
{$ENDIF}

Procedure TfrmIncremental.EditChange(Sender: TObject);
Var
    ALen: Integer;
Begin
    ALen := 0;
    If Editor.SelAvail Then
    Begin
        ALen := Length(Editor.SelText);
        Editor.CaretX := Editor.CaretX - ALen;
    End;
    If Editor.SearchReplace(Edit.Text, '', rOptions) = 0 Then
    Begin
        Include(rOptions, ssoBackwards);
        Editor.CaretX := Editor.CaretX + ALen;
        If Editor.SearchReplace(Edit.Text, '', rOptions) = 0 Then
            Edit.Font.Color := clRed
        Else
            Edit.Font.Color := clBlack;
    End
    Else
        Edit.Font.Color := clBlack;
    rOptions := [];
    If Length(Edit.Text) = 0 Then
    Begin
        Editor.BlockBegin := OrgPt;
        Editor.BlockEnd := OrgPt;
        Editor.CaretXY := OrgPt;
    End;
End;

Procedure TfrmIncremental.FormShow(Sender: TObject);
Begin
    SearchString := Edit.Text;
    Edit.Text := '';
    OrgPt := Editor.CaretXY;
    EditChange(Sender);
End;

Procedure TfrmIncremental.EditKeyPress(Sender: TObject; Var Key: Char);
Begin
    Case Key Of
        #27:
            Close;
        #13:
            SearchAgainExecute(self);
    Else
    Begin
    End;
    End;
End;

Procedure TfrmIncremental.SearchAgainExecute(Sender: TObject);
Begin
    MainForm.actFindNextExecute(Self);
    OrgPt := Editor.CaretXY;
End;

Procedure TfrmIncremental.EditKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
    Case Key Of
{$IFDEF WIN32}
        VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN:
            Close;
{$ENDIF}
{$IFDEF LINUX}
    XK_LEFT, XK_RIGHT, XK_UP, XK_DOWN : Close;
{$ENDIF}
    End;
End;

Procedure TfrmIncremental.CreateParams(Var Params: TCreateParams);
Begin
    Inherited;
    If (Parent <> Nil) Or (ParentWindow <> 0) Then
        Exit;  // must not mess with wndparent if form is embedded

    If Assigned(Owner) And (Owner Is TWincontrol) Then
        Params.WndParent := TWinControl(Owner).handle
    Else
    If Assigned(Screen.Activeform) Then
        Params.WndParent := Screen.Activeform.Handle;
End;

End.
