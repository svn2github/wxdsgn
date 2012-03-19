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

Unit devShortcuts;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Menus, Controls, IniFiles, Graphics, ActnList;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QMenus, QControls, IniFiles, QGraphics, QActnList;
{$ENDIF}

Type
    TmlStrings = Class(TPersistent)
    Private
        fCaption: String;
        fTitle: String;
        fTip: String;
        fHeaderEntry: String;
        fHeaderShortcut: String;
        fOK: String;
        fCancel: String;
    Protected
    Public
    Published
        Property Caption: String Read fCaption Write fCaption;
        Property Title: String Read fTitle Write fTitle;
        Property Tip: String Read fTip Write fTip;
        Property HeaderEntry: String Read fHeaderEntry Write fHeaderEntry;
        Property HeaderShortcut: String Read fHeaderShortcut Write fHeaderShortcut;
        Property OK: String Read fOK Write fOK;
        Property Cancel: String Read fCancel Write fCancel;
    End;

    TdevShortcuts = Class(TComponent)
    Private
    { Private declarations }
        fOwner: TComponent;
        fAltColor: TColor;
        fFilename: TFileName;
        fMLStrings: TmlStrings;
        Procedure ReadShortcuts;
        Procedure Save;
    Protected
    { Protected declarations }
    Public
    { Public declarations }
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Procedure Load;
        Procedure Edit;
    Published
    { Published declarations }
        Property Filename: TFilename Read fFilename Write fFilename;
        Property AlternateColor: TColor Read fAltColor Write fAltColor;
        Property MultiLangStrings: TmlStrings Read fMLStrings Write fMLStrings;
    End;

Procedure Register;

Implementation

{$IFDEF WIN32}
Uses
    devShortcutsEditorForm, Forms;
{$ENDIF}
{$IFDEF LINUX}
uses
  devShortcutsEditorForm, QForms;
{$ENDIF}

Procedure Register;
Begin
    RegisterComponents('dev-c++', [TdevShortcuts]);
End;

{ TdevShortcuts }

Constructor TdevShortcuts.Create(AOwner: TComponent);
Begin
    Inherited;
    fOwner := AOwner;
    fFileName := 'shortcuts.cfg';
    fAltColor := $E0E0E0;
    fMLStrings := TMLStrings.Create;
    With fMLStrings Do
    Begin
        Caption := 'Configure Shortcuts';
        Title := ' Click on an item and press the shortcut you desire!';
        Tip := 'Tip: press "Escape" to clear a shortcut...';
        HeaderEntry := 'Menu entry';
        HeaderShortcut := 'Shortcut assigned';
        OK := 'OK';
        Cancel := 'Cancel';
    End;
End;

Destructor TdevShortcuts.Destroy;
Begin
    fMLStrings.Free;
    Inherited;
End;

Procedure TdevShortcuts.Edit;
Begin
    frmShortcutsEditor := TfrmShortcutsEditor.Create(Self);
    With frmShortcutsEditor Do
        Try
            AltColor := fAltColor;
            Caption := fMLStrings.Caption;
            lblTitle.Caption := fMLStrings.Title;
            lblTip.Caption := fMLStrings.Tip;
            lvShortcuts.Column[0].Caption := fMLStrings.HeaderEntry;
            lvShortcuts.Column[1].Caption := fMLStrings.HeaderShortcut;
            btnOk.Caption := fMLStrings.OK;
            btnCancel.Caption := fMLStrings.Cancel;
            Clear;
            ReadShortcuts;
            If ShowModal = mrOK Then
                Save;
        Finally
            frmShortcutsEditor.Free;
        End;
End;

Function GetTopmostItemAncestor(Item: TMenuItem): String;
Var
    CurMenu: TMenu;
Begin
    Result := '';

  //Check to make sure we have a valid reference
    If Item.GetParentMenu <> Nil Then
    Begin
        Result := Item.GetParentMenu.Name;
        CurMenu := Item.GetParentMenu;
        If CurMenu Is TMainMenu Then
            While Item <> Nil Do
            Begin
                If Item.Caption <> '' Then
                    Result := Item.Caption;
                Item := Item.Parent;
            End;
    End;
End;

Procedure TdevShortcuts.Load;
Type TMenuAndShortcut = Record
        Caption: String;
        Shortcut: TShortCut;
    End;
    PMenuAndShortcut = ^TMenuAndShortcut;
Var
    I, x: Integer;
    Fini: TIniFile;
    Entries: TList;
    ms: PMenuAndShortcut;
    sct: TShortCut;
    SmenuOld, SmenuNew, Entry: String;
    Found: Boolean;
Begin
    If fOwner = Nil Then
        Exit;
    If (fFileName = '') Or Not FileExists(fFileName) Then
        Exit;
    Entries := TList.Create;
    Fini := TIniFile.Create(fFileName);
    Try
        For I := 0 To fOwner.ComponentCount - 1 Do
            If (fOwner.Components[I] Is TMenuItem) Then
                If Not TMenuItem(fOwner.Components[I]).IsLine Then
                    If (TMenuItem(fOwner.Components[I]).Count = 0) Then
                    Begin
                        SmenuOld := StripHotkey(TMenuItem(fOwner.Components[I]).Caption);
                        SmenuNew := StripHotkey(GetTopmostItemAncestor(TMenuItem(fOwner.Components[I]))) + ':' + SmenuOld;
                        Entry := Fini.ReadString('Shortcuts', SmenuNew, '');

                        Found := False;
                        For x := 0 To Entries.Count - 1 Do
                        Begin
                            ms := Entries[x];
                            If ms^.Caption = SmenuOld Then
                            Begin
                                TMenuItem(fOwner.Components[I]).ShortCut := ms^.Shortcut;
                                If Assigned(TMenuItem(fOwner.Components[I]).Action) Then
                                    TAction(TMenuItem(fOwner.Components[I]).Action).ShortCut := ms^.Shortcut;
                                found := True;
                                Break;
                            End;
                        End;
                        If Found Then
                            Continue;

                        If Entry = '' Then
                            Entry := Fini.ReadString('Shortcuts', SmenuOld, ShortCutToText(
                                TMenuItem(fOwner.Components[I]).ShortCut));
                        If Entry <> 'none' Then
                            sct := TextToShortCut(Entry)
                        Else
                            sct := 0;
                        TMenuItem(fOwner.Components[I]).ShortCut := sct;
                        If Assigned(TMenuItem(fOwner.Components[I]).Action) Then
                            TAction(TMenuItem(fOwner.Components[I]).Action).ShortCut := sct;

                        ms := New(PMenuAndShortcut);
                        ms^.Caption := SmenuOld;
                        ms^.Shortcut := sct;
                        Entries.Add(ms);
                    End;
    Finally
        Fini.Free;
        While Entries.Count > 0 Do
        Begin
            Dispose(Entries[0]);
            Entries.Delete(0);
        End;
        Entries.Clear;
        Entries.Free;
    End;
End;

Procedure TdevShortcuts.ReadShortcuts;
Var
    I: Integer;
    Actions: THashedStringList;
    MenuItem: TMenuItem;
Begin
    If fOwner = Nil Then
        Exit;
    Actions := THashedStringList.Create;
    For I := 0 To fOwner.ComponentCount - 1 Do
        If fOwner.Components[I] Is TMenuItem And
            (TMenuItem(fOwner.Components[I]).GetParentMenu Is TMainMenu) Then
        Begin
            MenuItem := TMenuItem(fOwner.Components[I]);
            If Not MenuItem.IsLine Then
                If MenuItem.Count = 0 Then
                Begin
                    If Assigned(MenuItem.Action) And (MenuItem.Action.Name <> '') And
                        (Actions.IndexOf(MenuItem.Action.Name) = -1) Then
                        Actions.Add(MenuItem.Action.Name);
                    frmShortcutsEditor.AddShortcut(TMenuItem(fOwner.Components[I]),
                        GetTopmostItemAncestor(TMenuItem(fOwner.Components[I])));
                End;
        End;
    For I := 0 To fOwner.ComponentCount - 1 Do
        If fOwner.Components[I] Is TMenuItem And
            (TMenuItem(fOwner.Components[I]).GetParentMenu Is TPopupMenu)
        Then
        Begin
            MenuItem := TMenuItem(fOwner.Components[I]);
            If Not MenuItem.IsLine And (MenuItem.Count = 0) And
                ((Not Assigned(MenuItem.Action)) Or (MenuItem.Action.Name = '') Or
                (Actions.IndexOf(MenuItem.Action.Name) = -1))
            Then
            Begin
                frmShortcutsEditor.AddShortcut(TMenuItem(fOwner.Components[I]),
                    GetTopmostItemAncestor(TMenuItem(fOwner.Components[I])));
            End;
        End;
End;

Procedure TdevShortcuts.Save;
Var
    I: Integer;
    Fini: TIniFile;
    Smenu: String;
    Scut: String;
Begin
    If fFileName = '' Then
        Exit;
    Fini := TIniFile.Create(fFileName);
    Try
        For I := 0 To frmShortcutsEditor.Count - 1 Do
        Begin
            frmShortcutsEditor.Items[I].ShortCut := frmShortcutsEditor.ShortCuts[I];
            If Assigned(frmShortcutsEditor.Items[I].Action) Then
                TAction(frmShortcutsEditor.Items[I].Action).ShortCut := frmShortcutsEditor.ShortCuts[I];
            Smenu := StripHotkey(GetTopmostItemAncestor(frmShortcutsEditor.Items[I])) + ':' +
                StripHotkey(frmShortcutsEditor.Items[I].Caption);
            Scut := ShortCutToText(frmShortcutsEditor.ShortCuts[I]);
            If Scut = '' Then
                Scut := 'none';
            Fini.WriteString('Shortcuts', Smenu, Scut);
        End;
    Finally
        Fini.Free;
    End;
End;

End.
