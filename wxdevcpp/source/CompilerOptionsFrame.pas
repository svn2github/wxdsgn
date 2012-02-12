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

Unit CompilerOptionsFrame;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    Grids, ValEdit, ComCtrls, ExtCtrls, project, prjtypes;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QGrids, QComCtrls, QExtCtrls, project, prjtypes;
{$ENDIF}

Type
    TCompOptionsFrame = Class(TFrame)
        tv: TTreeView;
        vle: TValueListEditor;
        Splitter1: TSplitter;
        Procedure tvChange(Sender: TObject; Node: TTreeNode);
        Procedure vleSetEditText(Sender: TObject; ACol, ARow: Integer;
            Const Value: String);
        Procedure FrameResize(Sender: TObject);
    Private
        { Private declarations }
        fProject: TProject;
    Public
        { Public declarations }
        Procedure FillOptions(Proj: TProject);
    End;

Implementation

Uses
    devcfg;

{$R *.dfm}

{ TCompOptionsFrame }

Procedure TCompOptionsFrame.FillOptions(Proj: TProject);
    Function FindNode(ParentNode: TTreeNode; Text: String): TTreeNode;
    Var
        I: Integer;
    Begin
        Result := Nil;
        If Not Assigned(ParentNode) Then
        Begin
            For I := 0 To tv.Items.Count - 1 Do
                If AnsiCompareText(tv.Items.Item[I].Text, Text) = 0 Then
                Begin
                    Result := tv.Items.Item[I];
                    Break;
                End;
        End
        Else
            For I := 0 To ParentNode.Count - 1 Do
                If AnsiCompareText(ParentNode.Item[I].Text, Text) = 0 Then
                Begin
                    Result := ParentNode.Item[I];
                    Break;
                End;
    End;
    Procedure CreateSectionNode(CompilersNode: TTreeNode; NodePath: String);
    Var
        s, s1: String;
        idx: Integer;
        tmpNode, Node: TTreeNode;
    Begin
        If NodePath = '' Then
            Exit;
        Node := CompilersNode;
        s := NodePath;
        Repeat
            s1 := s;
            idx := Pos('/', s);
            If idx > 0 Then
            Begin
                s1 := Copy(s, 1, idx - 1);
                Delete(s, 1, idx);
            End;
            tmpNode := FindNode(Node, s1);
            If Assigned(tmpNode) Then
                Node := tmpNode
            Else
                Node := tv.Items.AddChild(Node, s1);
        Until idx = 0;
    End;
Var
    I: Integer;
Begin
    fProject := Proj;
    tv.Items.Clear;
    tv.Items.BeginUpdate;
    For I := 0 To devCompiler.OptionsCount - 1 Do
        CreateSectionNode(Nil, devCompiler.Options[I].optSection);
{$IFDEF WIN32}
    tv.AlphaSort(True);
{$ENDIF}
{$IFDEF LINUX}
  tv.AlphaSort();
  {$MESSAGE 'check if AlphaSort(True) is already available'}
{$ENDIF}
    If tv.Items.Count > 0 Then
        tv.Selected := tv.Items.Item[0];
    tv.Items.EndUpdate;
End;

Procedure TCompOptionsFrame.tvChange(Sender: TObject; Node: TTreeNode);
    Function SectionPath(childNode: TTreeNode): String;
    Begin
        Result := '';
        While Assigned(childNode) Do
        Begin
            Result := childNode.Text + '/' + Result;
            childNode := childNode.Parent;
        End;
        If Length(Result) > 0 Then
            Delete(Result, Length(Result), 1);
    End;
Var
    I, J, idx: Integer;
    NodePath: String;
    ShowOption: Boolean;
Begin
    If Not Assigned(Node) Then
        Exit;

    vle.OnSetEditText := Nil;
    vle.Strings.Clear;
    vle.Strings.BeginUpdate;
    NodePath := SectionPath(Node);
    For I := 0 To devCompiler.OptionsCount - 1 Do
    Begin
        ShowOption := (Not Assigned(fProject)) Or
            (Assigned(fProject) And Not (fProject.CurrentProfile.typ In
            devCompiler.Options[I].optExcludeFromTypes));
        If ShowOption And (AnsiCompareText(devCompiler.Options[I].optSection,
            NodePath) = 0) Then
        Begin
            If Assigned(devCompiler.Options[I].optChoices) And
                (devCompiler.Options[I].optValue <
                devCompiler.Options[I].optChoices.Count) Then
                idx := vle.InsertRow(devCompiler.Options[I].optName,
                    devCompiler.Options[I].optChoices.Names[devCompiler.Options[
                    I].optValue], True)
            Else
                idx := vle.InsertRow(devCompiler.Options[I].optName,
                    BoolValYesNo[devCompiler.Options[I].optValue > 0], True);
            vle.Strings.Objects[idx] := Pointer(I);
            vle.ItemProps[idx].EditStyle := esPickList;
            vle.ItemProps[idx].ReadOnly := True;
            If Assigned(devCompiler.Options[I].optChoices) Then
            Begin
                For j := 0 To devCompiler.Options[I].optChoices.Count - 1 Do
                    vle.ItemProps[idx].PickList.Add(
                        devCompiler.Options[I].optChoices.Names[J]);
            End
            Else
            Begin
                vle.ItemProps[idx].PickList.Add(BoolValYesNo[False]);
                vle.ItemProps[idx].PickList.Add(BoolValYesNo[True]);
            End;
        End;
    End;
    vle.ColWidths[0] := vle.ClientWidth - 64;
    vle.OnSetEditText := vleSetEditText;
    vle.Strings.EndUpdate;
End;

Procedure TCompOptionsFrame.vleSetEditText(Sender: TObject; ACol,
    ARow: Integer; Const Value: String);
Var
    opt, opt1: TCompilerOption;
    I: Integer;
Begin
    If ((vle.Strings.Count <= ARow) Or (vle.Strings.Count = 0)) Then
        Exit;
    opt := devCompiler.Options[Integer(vle.Strings.Objects[ARow])];

    If Value = 'Yes' Then
        opt.optValue := 1 // True
    Else
    If Value = 'No' Then
        opt.optValue := 0 //False
    Else
    If opt.optChoices = Nil Then
        Exit
    Else
    Begin
        For i := 0 To opt.optChoices.Count - 1 Do
            If Value = opt.optChoices.Names[i] Then
            Begin
                opt.optValue := i;
                break;
            End;
        If i = opt.optChoices.Count Then
            exit;
    End;

    devCompiler.Options[Integer(vle.Strings.Objects[ARow])] := opt;

    If opt.optValue > 0 Then
        If opt.optIsGroup Then
        Begin
            For I := 0 To devCompiler.OptionsCount - 1 Do
                If (I <> Integer(vle.Strings.Objects[ARow])) And
                    (devCompiler.Options[I].optSection = opt.optSection) Then
                Begin
                    opt1 := devCompiler.Options[I];
                    opt1.optValue := 0;
                    devCompiler.Options[I] := opt1;
                End;
            tvChange(tv, tv.Selected);
            vle.Row := ARow;
        End;
End;

Procedure TCompOptionsFrame.FrameResize(Sender: TObject);
Begin
    vle.ColWidths[0] := vle.ClientWidth - 64;
End;

End.
