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

Unit devShortcutsEditorForm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, ExtCtrls, ComCtrls, StdCtrls, Menus, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QExtCtrls, QComCtrls, QStdCtrls, QMenus;
{$ENDIF}

Type
    TfrmShortcutsEditor = Class(TForm)
        lvShortcuts: TListView;
        Panel1: TPanel;
        btnOk: TButton;
        btnCancel: TButton;
        pnlTitle: TPanel;
        lblTip: TLabel;
        lblTitle: TLabel;
        Procedure lvShortcutsKeyDown(Sender: TObject; Var Key: Word;
            Shift: TShiftState);
        Procedure lvShortcutsCustomDrawItem(Sender: TCustomListView;
            Item: TListItem; State: TCustomDrawState; Var DefaultDraw: Boolean);
        Procedure lvShortcutsCustomDrawSubItem(Sender: TCustomListView;
            Item: TListItem; SubItem: Integer; State: TCustomDrawState;
            Var DefaultDraw: Boolean);
        Procedure FormCreate(Sender: TObject);
    Private
    { Private declarations }
        Function GetItem(Index: Integer): TMenuItem;
        Function GetShortCut(Index: Integer): TShortCut;
    Public
    { Public declarations }
        AltColor: TColor;
        Procedure AddShortcut(M: TMenuItem; MenuName: String);
        Procedure Clear;
        Function Count: Integer;
        Property Items[Index: Integer]: TMenuItem Read GetItem;
        Property ShortCuts[Index: Integer]: TShortCut Read GetShortCut;
    Protected
        Procedure CreateParams(Var Params: TCreateParams); Override;
    End;

Var
    frmShortcutsEditor: TfrmShortcutsEditor;

Implementation

Uses StrUtils;

{$R *.dfm}

Procedure TfrmShortcutsEditor.FormCreate(Sender: TObject);
Begin
    DesktopFont := True;
    lblTitle.Font.Style := [fsBold];
    lblTitle.Font.Color := clCream;
    lblTitle.Font.Size := 10;
    lblTip.Font.Color := clSilver;
End;

Procedure TfrmShortcutsEditor.AddShortcut(M: TMenuItem; MenuName: String);
Begin
    If (M.Action <> Nil) And (LeftStr(M.Action.Name, 6) = 'dynact') Then
        Exit;
    With lvShortcuts.Items.Add Do
    Begin
        Caption := StripHotkey(MenuName + ' | ' + (M.Caption));
        SubItems.Add(ShortCutToText(M.ShortCut));
        Data := M;
    End;
End;

Procedure TfrmShortcutsEditor.Clear;
Begin
    lvShortcuts.Clear;
End;

Function TfrmShortcutsEditor.Count: Integer;
Begin
    Result := lvShortcuts.Items.Count;
End;

Function TfrmShortcutsEditor.GetItem(Index: Integer): TMenuItem;
Begin
    Result := TMenuItem(lvShortcuts.Items[Index].Data);
End;

Function TfrmShortcutsEditor.GetShortCut(Index: Integer): TShortCut;
Begin
    Result := TextToShortCut(lvShortcuts.Items[Index].SubItems[0]);
End;

Procedure TfrmShortcutsEditor.lvShortcutsKeyDown(Sender: TObject;
    Var Key: Word; Shift: TShiftState);
Var
    I: Integer;
    sct: String;
Begin
    If lvShortcuts.Selected = Nil Then
        Exit;
    If (Key = 27) And (Shift = []) Then
    Begin // clear shortcut
        lvShortcuts.Selected.SubItems[0] := '';
        Exit;
    End;
    If (Key > 27) And (Key <= 90) And (Shift = []) Then // if "normal" key, expect a shiftstate
        Exit;
    If (Key < 27) And (Shift = []) Then // control key by itself
        Exit;

  //Make sure the user does not select same-key combinations
{$IFDEF WIN32}
    If ((Key = VK_CONTROL) And (ssCtrl In Shift)) Or
        ((Key = VK_SHIFT) And (ssShift In Shift)) Or
        ((Key In [VK_MENU, VK_LMENU, VK_RMENU]) And (ssAlt In Shift)) Then
{$ENDIF}
{$IFDEF LINUX}
  if ((Key = XK_CONTROL) and (ssCtrl in Shift)) or
     ((Key = XK_SHIFT) and (ssShift in Shift)) or
     ((Key in [XK_MENU, XK_LMENU, XK_RMENU]) and (ssAlt in Shift)) then
{$ENDIF}
        Exit;

    sct := ShortCutToText(ShortCut(Key, Shift));
    lvShortcuts.Selected.SubItems[0] := sct;

  // search for other entries using this shortcut, and clear them
    For I := 0 To lvShortcuts.Items.Count - 1 Do
        If lvShortcuts.Items[I] <> lvShortcuts.Selected Then
            If lvShortcuts.Items[I].SubItems[0] = sct Then
                lvShortcuts.Items[I].SubItems[0] := '';

  // don't let the keystroke propagate
    Key := 0;
    Shift := [];
End;

Procedure TfrmShortcutsEditor.lvShortcutsCustomDrawItem(
    Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
    Var DefaultDraw: Boolean);
Begin
    With TCustomListView(Sender).Canvas Do
    Begin
        If Not (cdsSelected In State) Then
        Begin
            If Item.Index Mod 2 = 0 Then
                Brush.Color := clWhite
            Else
                Brush.Color := AltColor;
            Pen.Color := clBlack;
        End;
    End;
    DefaultDraw := True;
End;

Procedure TfrmShortcutsEditor.lvShortcutsCustomDrawSubItem(
    Sender: TCustomListView; Item: TListItem; SubItem: Integer;
    State: TCustomDrawState; Var DefaultDraw: Boolean);
Begin
    With TCustomListView(Sender).Canvas Do
    Begin
        If Not (cdsSelected In State) Then
        Begin
            If Item.Index Mod 2 = 0 Then
                Brush.Color := clWhite
            Else
                Brush.Color := AltColor;
            Pen.Color := clBlack;
        End;
    End;
    DefaultDraw := True;
End;

Procedure TfrmShortcutsEditor.CreateParams(Var Params: TCreateParams);
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
