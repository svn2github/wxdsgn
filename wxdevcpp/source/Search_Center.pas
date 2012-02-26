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

Unit Search_Center;

Interface

Uses
{$IFDEF WIN32}
    Classes, Types, Project, Editor, utils, SynEdit, ComCtrls,
    SynEditSearch, SynEditRegexSearch, SynEditMiscClasses, SynEditTypes;
{$ENDIF}
{$IFDEF LINUX}
 Classes, Types, Project, Editor, utils, QSynEdit, QComCtrls,
 QSynEditSearch, QSynEditRegexSearch, QSynEditMiscClasses, QSynEditTypes;
{$ENDIF}

Type
    TLookIn = (liSelected, liFile, liProject, liOpen);
    TdevSearchProc = Procedure(Const SR: TdevSearchResult) Of Object;

    TdevSearchCenter = Class(TObject)
    Public
        Function ExecuteSearch: Boolean;
        Procedure AssignSearchEngine(Regex: Boolean = False);
    Private
        fSingleFile: Boolean;
        fReplace: Boolean;
        fFindText: String;
        fReplaceText: String;
        fSearchProc: TdevSearchProc;
        fEditor: TEditor;
        fProject: TProject;
        fOptions: TSynSearchOptions;
        fSynEdit: TSynEdit;
        fCurFile: String;
        fPC: TPageControl;
        fUseSelection: Boolean;
        fSearchEngine: TSynEditSearchCustom;
        Function RunSingleFile: Boolean;
        Function RunAllFiles: Boolean;
        Procedure EditorReplaceText(Sender: TObject; Const aSearch,
            aReplace: String; Line, Column: Integer; Var Action: TSynReplaceAction);
        Function RunProject: Boolean;
        Function RunOpenFiles: Boolean;
    Public
        Constructor Create;
        Destructor Destroy; Override;
        Property SingleFile: Boolean Read fSingleFile Write fSingleFile;
        Property Replace: Boolean Read fReplace Write fReplace;
        Property FindText: String Read fFindText Write fFindText;
        Property ReplaceText: String Read fReplaceText Write fReplaceText;
        Property SearchProc: TdevSearchProc Read fSearchProc Write fSearchProc;
        Property Editor: TEditor Read fEditor Write fEditor;
        Property Project: TProject Read fProject Write fProject;
        Property Options: TSynSearchOptions Read fOptions Write fOptions;
        Property PageControl: TPageControl Read fPC Write fPC;
        Property UseSelection: Boolean Read fUseSelection Write fUseSelection;
    End;

Var
    SearchCenter: TdevSearchCenter;

Implementation

Uses
{$IFDEF WIN32}
    Forms, SysUtils, Controls, Dialogs, Findfrm, Replacefrm,
    version, MultiLangSupport;
{$ENDIF}
{$IFDEF LINUX}
  QForms, SysUtils, QControls, QDialogs, Findfrm, Replacefrm, version, MultiLangSupport;
{$ENDIF}

{ TdevSearchCenter }

Procedure TdevSearchCenter.AssignSearchEngine(Regex: Boolean);
Begin
    //Get the search engine right
    If Regex Then
    Begin
        If Assigned(fSearchEngine) And Not (fSearchEngine Is
            TSynEditRegexSearch) Then
            FreeAndNil(fSearchEngine);
        If Not Assigned(fSearchEngine) Then
            fSearchEngine := TSynEditRegexSearch.Create(Nil);
    End
    Else
    Begin
        If Assigned(fSearchEngine) And Not (fSearchEngine Is TSynEditSearch) Then
            FreeAndNil(fSearchEngine);
        If Not Assigned(fSearchEngine) Then
            fSearchEngine := TSynEditSearch.Create(Nil);
    End;

    If Assigned(fEditor) Then
        fEditor.Text.SearchEngine := fSearchEngine;
    fSynEdit.SearchEngine := fSearchEngine;
End;

Function TdevSearchCenter.ExecuteSearch: Boolean;
Var
    return: Integer;
Begin
    If fReplace Then
    Begin
        frmReplace.cboFindText.Text := fFindText;
        return := frmReplace.ShowModal;
        If (return = mrOk) Or (return = mrAll) Then
        Begin
            AssignSearchEngine(frmReplace.Regex);
            fFindText := frmReplace.cboFindText.Text;
            fReplaceText := frmReplace.cboReplaceText.Text;
            fOptions := frmReplace.SearchOptions;
            UseSelection := frmReplace.UseSelection;
        End;
    End
    Else
    Begin
        frmFind.FindAll := Not fSingleFile;
        frmFind.cboFindText.Text := fFindText;
        return := frmFind.ShowModal;
        fSingleFile := Not frmFind.FindAll;
        If return = mrOk Then
        Begin
            AssignSearchEngine(frmFind.Regex);
            fFindText := frmFind.cboFindText.Text;
            fReplaceText := '';
            fOptions := frmFind.SearchOptions;
        End;
    End;

    If Not (return In [mrOk, mrAll]) Then
        result := False
    Else
    If fReplace Or (frmFind.FindWhat In [liSelected, liFile]) Then
        result := RunSingleFile
    Else
        result := RunAllFiles;
End;

Function TdevSearchCenter.RunSingleFile: Boolean;
Var
    startTmp, endTmp: Integer;    // EAB Workaround for Replace All
Begin
    If Not assigned(fEditor) Then
    Begin
        Result := False;
        Exit;
    End
    Else
    Begin
        startTmp := 0; endTmp := 0;
        
        If (ssoReplaceAll In fOptions) And Not UseSelection Then
        Begin
            startTmp := fEditor.Text.SelStart;
            endTmp := fEditor.Text.SelEnd;
            fEditor.Text.SelStart := 0;
            fEditor.Text.SelEnd := fEditor.Text.GetTextLen;
        End;

        If fEditor.Text.SearchReplace(fFindText, fReplaceText, fOptions) = 0 Then
            MessageDlg(Format(Lang[ID_MSG_TEXTNOTFOUND], [SearchCenter.FindText]),
                mtInformation, [mbOk], 0);

        If (ssoReplaceAll In fOptions) And Not UseSelection Then
        Begin
            fEditor.Text.SelStart := startTmp;
            fEditor.Text.SelEnd := endTmp;
        End;
    End;
    Result := True;
End;

Function TdevSearchCenter.RunAllFiles: Boolean;
Begin
    fReplaceText := DEV_SEARCHLOOP;
    If frmFind.FindWhat = liProject Then
        Result := RunProject
    Else
        Result := RunOpenFiles;
    fSynEdit.ClearAll;
End;

Function TdevSearchCenter.RunProject: Boolean;
Var
    idx: Integer;
Begin
    For idx := 0 To pred(fProject.Units.Count) Do
    Begin
        fCurFile := fProject.Units[idx].FileName;
        If ExtractFilePath(fCurFile) = '' Then
            fCurFile := ExpandFileto(fCurFile, fProject.Directory);

        If assigned(fProject.Units[idx].Editor) Then
            fSynEdit.Lines := fProject.Units[idx].Editor.Text.Lines
        Else
            fSynEdit.Lines.LoadFromfile(fCurFile);

        fSynEdit.SearchReplace(fFindText, fReplaceText, fOptions);
        Application.ProcessMessages;
    End;
    result := True;
End;

Function TdevSearchCenter.RunOpenFiles: Boolean;
Var
    idx: Integer;
Begin
    For idx := 0 To pred(fPC.PageCount) Do
    Begin
        fCurFile := TEditor(fPC.Pages[idx].Tag).FileName;
        fSynEdit.Lines := TEditor(fPC.Pages[idx].Tag).Text.Lines;
        fSynEdit.SearchReplace(fFindText, fReplaceText, fOptions);
        Application.ProcessMessages;
    End;
    result := True;
End;

Procedure TdevSearchCenter.EditorReplaceText(Sender: TObject;
    Const aSearch, aReplace: String; Line, Column: Integer;
    Var Action: TSynReplaceAction);
Var
    SR: TdevSearchResult;
Begin
    If fReplaceText = DEV_SEARCHLOOP Then
    Begin
        SR.pt := point(Line, Column);
        SR.InFile := fCurFile;
        SR.msg := fSynEdit.Lines[Line - 1];
        fSearchProc(SR);
    End;
    Action := raSkip;
End;

Constructor TdevSearchCenter.Create;
Begin
    fSingleFile := True;
    fSynEdit := TSynEdit.Create(Nil);
    fSynEdit.OnReplaceText := EditorReplaceText;

    fSearchEngine := TSynEditSearch.Create(Nil);
End;

Destructor TdevSearchCenter.Destroy;
Begin
    fSearchEngine.Free;
    fSynEdit.Free;
    Inherited;
End;

Initialization
    SearchCenter := TdevSearchCenter.Create;
Finalization
    SearchCenter.Free;

End.
