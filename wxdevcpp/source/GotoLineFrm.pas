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

//
//  History:
//
//  26 March 2004, Peter Schraut
//    Pretty much a complete rewrite of this unit :P
//

Unit GotoLineFrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
    Buttons, ExtCtrls, Spin, XPMenu, SynEdit;
{$ENDIF}
{$IFDEF LINUX}
  Classes, QGraphics, QForms, QControls, QStdCtrls, 
  QButtons, QExtCtrls, QComCtrls, QSynEdit;
{$ENDIF}

Type
    TGotoLineForm = Class(TForm)
        GotoLabel: TLabel;
        Line: TSpinEdit;
        XPMenu: TXPMenu;
        BtnOK: TButton;
        BtnCancel: TButton;
        Procedure FormCreate(Sender: TObject);
        Procedure FormKeyUp(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure FormShow(Sender: TObject);
        Procedure LineKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
    Private
        FEditor: TCustomSynEdit;
        Procedure SetEditor(AEditor: TCustomSynEdit);
    Public
        Procedure LoadText;
        Property Editor: TCustomSynEdit Read FEditor Write SetEditor;
    End;

Implementation

Uses
{$IFDEF WIN32}
    MultiLangSupport, devcfg;
{$ENDIF}
{$IFDEF LINUX}
  Xlib, MultiLangSupport, devcfg;
{$ENDIF}

{$R *.dfm}

Procedure TGotoLineForm.FormCreate(Sender: TObject);
Begin
    LoadText;
End;

Procedure TGotoLineForm.FormShow(Sender: TObject);
Begin
    Line.Value := 1;
End;

Procedure TGotoLineForm.LineKeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
{$IFDEF WIN32}
    If Key = VK_RETURN Then
        BtnOK.Click;
{$ENDIF}
{$IFDEF LINUX}
  if Key = XK_RETURN then BtnOK.Click;
{$ENDIF}
End;

Procedure TGotoLineForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_GOTO_CAPTION];
    GotoLabel.Caption := Lang[ID_GOTO_TEXT];
    BtnOk.Caption := Lang[ID_BTN_OK];
    BtnCancel.Caption := Lang[ID_BTN_CANCEL];
End;

Procedure TGotoLineForm.FormKeyUp(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin
{$IFDEF WIN32}
    If Key = VK_ESCAPE Then
        Close;
{$ENDIF}
{$IFDEF LINUX}
  if Key = XK_ESCAPE then Close;
{$ENDIF}
End;

Procedure TGotoLineForm.SetEditor(AEditor: TCustomSynEdit);
Begin
    FEditor := AEditor;
    If Assigned(FEditor) Then
    Begin
        Line.MaxValue := FEditor.Lines.Count;
        Line.Value := FEditor.CaretY;
    End;
End;

End.
