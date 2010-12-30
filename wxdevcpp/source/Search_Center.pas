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

unit Search_Center;

interface

uses
{$IFDEF WIN32}
    Classes, Types, Project, Editor, utils, SynEdit, ComCtrls,
    SynEditSearch, SynEditRegexSearch, SynEditMiscClasses, SynEditTypes;
{$ENDIF}
{$IFDEF LINUX}
 Classes, Types, Project, Editor, utils, QSynEdit, QComCtrls,
 QSynEditSearch, QSynEditRegexSearch, QSynEditMiscClasses, QSynEditTypes;
{$ENDIF}

type
    TLookIn = (liSelected, liFile, liProject, liOpen);
    TdevSearchProc = procedure(const SR: TdevSearchResult) of object;

    TdevSearchCenter = class(TObject)
    public
        function ExecuteSearch: boolean;
        procedure AssignSearchEngine(Regex: Boolean = false);
    private
        fSingleFile: boolean;
        fReplace: boolean;
        fFindText: string;
        fReplaceText: string;
        fSearchProc: TdevSearchProc;
        fEditor: TEditor;
        fProject: TProject;
        fOptions: TSynSearchOptions;
        fSynEdit: TSynEdit;
        fCurFile: string;
        fPC: TPageControl;
        fUseSelection: Boolean;
        fSearchEngine: TSynEditSearchCustom;
        function RunSingleFile: boolean;
        function RunAllFiles: boolean;
        procedure EditorReplaceText(Sender: TObject; const aSearch,
            aReplace: string; Line, Column: integer; var Action: TSynReplaceAction);
        function RunProject: boolean;
        function RunOpenFiles: boolean;
    public
        constructor Create;
        destructor Destroy; override;
        property SingleFile: boolean read fSingleFile write fSingleFile;
        property Replace: boolean read fReplace write fReplace;
        property FindText: string read fFindText write fFindText;
        property ReplaceText: string read fReplaceText write fReplaceText;
        property SearchProc: TdevSearchProc read fSearchProc write fSearchProc;
        property Editor: TEditor read fEditor write fEditor;
        property Project: TProject read fProject write fProject;
        property Options: TSynSearchOptions read fOptions write fOptions;
        property PageControl: TPageControl read fPC write fPC;
        property UseSelection: Boolean read fUseSelection write fUseSelection;
    end;

var
    SearchCenter: TdevSearchCenter;

implementation

uses
{$IFDEF WIN32}
    Forms, SysUtils, Controls, Dialogs, Findfrm, Replacefrm,
    version, MultiLangSupport;
{$ENDIF}
{$IFDEF LINUX}
  QForms, SysUtils, QControls, QDialogs, Findfrm, Replacefrm, version, MultiLangSupport;
{$ENDIF}

{ TdevSearchCenter }

procedure TdevSearchCenter.AssignSearchEngine(Regex: Boolean);
begin
    //Get the search engine right
    if Regex then
    begin
        if Assigned(fSearchEngine) and not (fSearchEngine is
            TSynEditRegexSearch) then
            FreeAndNil(fSearchEngine);
        if not Assigned(fSearchEngine) then
            fSearchEngine := TSynEditRegexSearch.Create(nil);
    end
    else
    begin
        if Assigned(fSearchEngine) and not (fSearchEngine is TSynEditSearch) then
            FreeAndNil(fSearchEngine);
        if not Assigned(fSearchEngine) then
            fSearchEngine := TSynEditSearch.Create(nil);
    end;

    if Assigned(fEditor) then
        fEditor.Text.SearchEngine := fSearchEngine;
    fSynEdit.SearchEngine := fSearchEngine;
end;

function TdevSearchCenter.ExecuteSearch: boolean;
var
    return: integer;
begin
    if fReplace then
    begin
        frmReplace.cboFindText.Text := fFindText;
        return := frmReplace.ShowModal;
        if (return = mrOk) or (return = mrAll) then
        begin
            AssignSearchEngine(frmReplace.Regex);
            fFindText := frmReplace.cboFindText.Text;
            fReplaceText := frmReplace.cboReplaceText.Text;
            fOptions := frmReplace.SearchOptions;
            UseSelection := frmReplace.UseSelection;
        end;
    end
    else
    begin
        frmFind.FindAll := not fSingleFile;
        frmFind.cboFindText.Text := fFindText;
        return := frmFind.ShowModal;
        fSingleFile := not frmFind.FindAll;
        if return = mrOk then
        begin
            AssignSearchEngine(frmFind.Regex);
            fFindText := frmFind.cboFindText.Text;
            fReplaceText := '';
            fOptions := frmFind.SearchOptions;
        end;
    end;

    if not (return in [mrOk, mrAll]) then
        result := FALSE
    else
    if fReplace or (frmFind.FindWhat in [liSelected, liFile]) then
        result := RunSingleFile
    else
        result := RunAllFiles;
end;

function TdevSearchCenter.RunSingleFile: boolean;
var
    startTmp, endTmp: Integer;    // EAB Workaround for Replace All
begin
    if not assigned(fEditor) then
    begin
        Result := False;
        Exit;
    end
    else
    begin
        if (ssoReplaceAll in fOptions) and not UseSelection then
        begin
            startTmp := fEditor.Text.SelStart;
            endTmp := fEditor.Text.SelEnd;
            fEditor.Text.SelStart := 0;
            fEditor.Text.SelEnd := fEditor.Text.GetTextLen;
        end;

        if fEditor.Text.SearchReplace(fFindText, fReplaceText, fOptions) = 0 then
            MessageDlg(Format(Lang[ID_MSG_TEXTNOTFOUND], [SearchCenter.FindText]),
                mtInformation, [mbOk], 0);

        if (ssoReplaceAll in fOptions) and not UseSelection then
        begin
            fEditor.Text.SelStart := startTmp;
            fEditor.Text.SelEnd := startTmp;
        end;
    end;
    Result := True;
end;

function TdevSearchCenter.RunAllFiles: boolean;
begin
    fReplaceText := DEV_SEARCHLOOP;
    if frmFind.FindWhat = liProject then
        Result := RunProject
    else
        Result := RunOpenFiles;
    fSynEdit.ClearAll;
end;

function TdevSearchCenter.RunProject: boolean;
var
    idx: integer;
begin
    for idx := 0 to pred(fProject.Units.Count) do
    begin
        fCurFile := fProject.Units[idx].FileName;
        if ExtractFilePath(fCurFile) = '' then
            fCurFile := ExpandFileto(fCurFile, fProject.Directory);

        if assigned(fProject.Units[idx].Editor) then
            fSynEdit.Lines := fProject.Units[idx].Editor.Text.Lines
        else
            fSynEdit.Lines.LoadFromfile(fCurFile);

        fSynEdit.SearchReplace(fFindText, fReplaceText, fOptions);
        Application.ProcessMessages;
    end;
    result := True;
end;

function TdevSearchCenter.RunOpenFiles: boolean;
var
    idx: integer;
begin
    for idx := 0 to pred(fPC.PageCount) do
    begin
        fCurFile := TEditor(fPC.Pages[idx].Tag).FileName;
        fSynEdit.Lines := TEditor(fPC.Pages[idx].Tag).Text.Lines;
        fSynEdit.SearchReplace(fFindText, fReplaceText, fOptions);
        Application.ProcessMessages;
    end;
    result := TRUE;
end;

procedure TdevSearchCenter.EditorReplaceText(Sender: TObject;
    const aSearch, aReplace: string; Line, Column: integer;
    var Action: TSynReplaceAction);
var
    SR: TdevSearchResult;
begin
    if fReplaceText = DEV_SEARCHLOOP then
    begin
        SR.pt := point(Line, Column);
        SR.InFile := fCurFile;
        SR.msg := fSynEdit.Lines[Line - 1];
        fSearchProc(SR);
    end;
    Action := raSkip;
end;

constructor TdevSearchCenter.Create;
begin
    fSingleFile := true;
    fSynEdit := TSynEdit.Create(nil);
    fSynEdit.OnReplaceText := EditorReplaceText;

    fSearchEngine := TSynEditSearch.Create(nil);
end;

destructor TdevSearchCenter.Destroy;
begin
    fSearchEngine.Free;
    fSynEdit.Free;
    inherited;
end;

initialization
    SearchCenter := TdevSearchCenter.Create;
finalization
    SearchCenter.Free;

end.
