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

(*
 Changes: 12.5.1
 Programmer: Mike Berg
 Desc:  Modified to be a singleton pattern.  Any time the object is called
        through the Lang function the object is auto-created if need be
        and returned. works like devcfg.
 ToUse: The Strings prop is default so just call like Lang[ID_value];
          - it works like a string list.
*)

Unit MultiLangSupport;

Interface

Uses
{$IFDEF WIN32}
    Windows, Dialogs, SysUtils, Classes, oysUtils;
{$ENDIF}
{$IFDEF LINUX}
  QDialogs, SysUtils, Classes, oysUtils;
{$ENDIF}

{$I LangIDs.inc}

Type
    TdevMultiLangSupport = Class(TObject)
    Private
        fLangList: ToysStringList;
        fLangFile: String;
        fCurLang: String;
        fStrings: TStringList;
        fDefaultLang: TStringList;
        fSelect: Boolean;
        Function GetString(ID: Integer): String;
        Function GetLangName: String;
        Constructor Create;
    Public
        Destructor Destroy; Override;
        Class Function Lang: TdevMultiLangSupport;

        Procedure CheckLanguageFiles;
        Procedure SelectLanguage;

        Function Open(Const FileName: String): Boolean;
        Procedure SetLang(Const Lang: String);

        Function FileFromDescription(Desc: String): String;

        Property Strings[index: Integer]: String Read GetString;
            Default;//write SetString;
        Property CurrentLanguage: String Read GetLangName;
        Property Langs: ToysStringList Read fLangList Write fLangList;
    End;

Function Lang: TdevMultiLangSupport;

Implementation

Uses
{$IFDEF WIN32}
    LangFrm, Forms, utils, version, Controls, devcfg;
{$ENDIF}
{$IFDEF LINUX}
  LangFrm, QForms, utils, version, QControls, devcfg;
{$ENDIF}

Var
    fLang: TdevMultiLangSupport = Nil;
    fExternal: Boolean = True;

Function Lang: TdevMultiLangSupport;
Begin
    If Not assigned(fLang) Then
    Begin
        fExternal := False;
        Try
            fLang := TdevMultiLangSupport.Create;
        Finally
            fExternal := True;
        End;
    End;
    result := fLang;
End;

Class Function TdevMultiLangSupport.Lang: TdevMultiLangSupport;
Begin
    result := MultiLangSupport.Lang;
End;

Constructor TdevMultiLangSupport.Create;
Var
    ms: TMemoryStream;
Begin
    If assigned(fLang) Then
        Raise Exception.Create('Language Support loaded');
    If fExternal Then
        Raise Exception.Create('Language Support Externally Created');

    fLangList := ToysStringList.Create;
    fStrings := TStringList.Create;
    fDefaultLang := TStringList.Create;
    ms := TMemoryStream.Create;
    Try
        LoadFilefromResource(DEFAULT_LANG_FILE, ms);
        fStrings.LoadFromStream(ms);
        ms.Seek(0, soFromBeginning);
        fDefaultLang.LoadFromStream(ms);
    Finally
        ms.free;
    End;

    CheckLanguageFiles;
End;

Destructor TdevMultiLangSupport.Destroy;
Begin
    fLangList.Free;
    fStrings.Free;
    fDefaultLang.Free;
    fLang := Nil;
    Inherited;
End;

Function TdevMultiLangSupport.Open(Const Filename: String): Boolean;
Var
    s,
    aFile: String;
    ver: Integer;
    NewStrs: TStringList;
Begin
    result := False;
    aFile := ValidateFile(FileName, devDirs.Lang);
    If aFile = '' Then
    Begin
        If fSelect Then
            MessageDlg('Could not open language file ' + filename,
                mtError, [mbOK], 0);
        exit;
    End;

    Try // handle overall errors
        NewStrs := TStringList.Create;

        Try // handle newstr freeing
            NewStrs.LoadFromFile(aFile);
            s := NewStrs.Values['Ver'];

            Try // handle invalid ver entry
                ver := strtointdef(s, -1);
            Except
                If MessageDlg('The selected language file has an invalid, or is missing a version entry.'#13#10
                    + 'You may not have all the required strings for your current Dev-C++ interface.'#13#10
                    + 'Please check the Dev-C++ Update or Bloadshed.net for new language files, Continue Opening?',
                    mtWarning, [mbYes, mbNo], 0) = mrNo Then
                    Exit Else ver := 1;
            End; // end invalid ver test

            fLangFile := aFile;
            fStrings.Clear;
            fStrings.AddStrings(NewStrs);
        Finally
            NewStrs.Free;
        End; // need for NewStrs object

        If ver >= 1 Then
            result := True;

        fCurLang := fStrings.Values['Lang'];
        If fCurLang = '' Then
            fCurLang := ChangeFileExt(ExtractFileName(aFile), '');
        devData.Language := ExtractFileName(aFile);
    Except
        result := False;
    End;
End;

Procedure TdevMultiLangSupport.CheckLanguageFiles;
Var
    idx: Integer;
    s: String;
    tmp: TStringList;
Begin
    fLangList.Clear;
    If devDirs.Lang = '' Then
        exit;

    FilesFromWildcard(devDirs.Lang, '*.lng',
        TStringList(fLangList), False, False, True);
    fLangList.Sort;
    If fLangList.Count > 0 Then
    Begin
        tmp := TStringList.Create;
        Try
            For idx := 0 To pred(fLangList.Count) Do
            Begin
                tmp.Clear;
                tmp.LoadFromFile(fLangList[idx]);
                s := tmp.Values['Lang'];
                If (Lowercase(ExtractFileName(fLangList[idx])) = LowerCase(
                    DEFAULT_LANG_FILE)) And
                    (devData.Language = '') Then
                    fCurLang := s;
                If s = '' Then
                    fLangList[idx] :=
                        format('%s=%s', [fLangList[idx],
                        ChangeFileExt(ExtractFileName(fLangList[idx]), '')])
                Else
                    fLangList[idx] := format('%s=%s', [fLangList[idx], s]);
            End;
        Finally
            tmp.Free;
        End;
    End;
    If fCurLang = '' Then
        fCurLang := devData.Language;
End;

Function TdevMultiLangSupport.GetString(ID: Integer): String;
Begin
    result := fStrings.Values[inttostr(ID)];
    If Result = '' Then
        Result := fDefaultLang.Values[inttostr(ID)];
    If result = '' Then
        result := format('<ERR: %d>', [ID]);
    //else result := StringReplace(result, '<CR>', #13#10, [rfReplaceAll]);
    result := StringReplace(result, '<CR>', #13#10, [rfReplaceAll]);
End;

Function TdevMultiLangSupport.GetLangName: String;
Begin
    result := fCurLang;
End;

Procedure TdevMultiLangSupport.SelectLanguage;
Begin
    fSelect := True;
    If fLangList.Count > 0 Then
        With TLangForm.Create(Application.Mainform) Do
            Try
                UpdateList(fLangList);
                If ShowModal = mrOK Then
                    If Selected > -1 Then
                    Begin
                        Open(fLangList.Names[Selected]);
                        devData.Language := FileFromDescription(fLangList.Names[Selected]);
                    End
                    Else
                        Open(DEFAULT_LANG_FILE);
            Finally
                Free;
                fSelect := False;
            End
    Else
    Begin
        Open(DEFAULT_LANG_FILE);
        fSelect := False;
    End;
End;

Procedure TdevMultiLangSupport.SetLang(Const Lang: String);
Var
    idx: Integer;
Begin
    If Lang = fCurLang Then
        exit;
    For idx := 0 To fLangList.Count - 1 Do
        If AnsiSameText(ExtractFileName(fLangList.Names[idx]), Lang) Then
        Begin
            Open(fLangList.Names[idx]);
            break;
        End;
End;

Function TdevMultiLangSupport.FileFromDescription(Desc: String): String;
Var
    idx: Integer;
Begin
    // returns the filename of the lang file described as Desc
    // for example with Desc="English (Original)", returns "English.lng"
    Result := Desc;
    For idx := 0 To fLangList.Count - 1 Do
        If CompareText(fLangList.Values[idx], Desc) = 0 Then
        Begin
            Result := ExtractFilename(fLangList.Names[idx]);
            Break;
        End;
End;

Initialization

Finalization
    fLang.Free;

End.
