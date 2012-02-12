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

Unit Macros;

Interface

Uses
    SysUtils, devCfg, Version;

Function ParseMacros(Str: String): String;

Implementation

Uses
{$IFDEF WIN32}
    Main, editor, Dialogs, Utils, Classes;
{$ENDIF}
{$IFDEF LINUX}
  Main, editor, QDialogs, Utils, Classes;
{$ENDIF}

Procedure Replace(Var Str: String; Old, New: String);
Begin
    Str := StringReplace(Str, Old, New, [rfReplaceAll]);
End;

Function ParseMacros(Str: String): String;
Var
    e: TEditor;
    Dir: String;
    StrList: TStringList;
Begin
    Result := Str;
    e := MainForm.GetEditor;

    Replace(Result, '<DEFAULT>', devDirs.Default);
    Replace(Result, '<DEVCPP>', ExtractFileDir(ParamStr(0)));
    Replace(Result, '<DEVCPPVERSION>', DEVCPP_VERSION);
    Replace(Result, '<EXECPATH>', devDirs.Exec);
    Replace(Result, '<DATE>', DateToStr(Now));
    Replace(Result, '<DATETIME>', DateTimeToStr(Now));

    Dir := ExtractFilePath(ParamStr(0)) + '\include';
    If (Not DirectoryExists(Dir)) And (devDirs.C <> '') Then
    Begin
        StrList := TStringList.Create;
        StrToList(devDirs.C, StrList);
        Dir := StrList.Strings[0];
        StrList.Free;
    End;
    Replace(Result, '<INCLUDE>', Dir);

    Dir := ExtractFilePath(ParamStr(0)) + '\lib';
    If (Not DirectoryExists(Dir)) And (devDirs.Lib <> '') Then
    Begin
        StrList := TStringList.Create;
        StrToList(devDirs.Lib, StrList);
        Dir := StrList.Strings[0];
        StrList.Free;
    End;
    Replace(Result, '<LIB>', Dir);

    { Project-dependent macros }
    If Assigned(MainForm.fProject) Then
    Begin
        Replace(Result, '<EXENAME>', MainForm.fProject.Executable);
        Replace(Result, '<PROJECTNAME>', MainForm.fProject.Name);
        Replace(Result, '<PROJECTFILE>', MainForm.fProject.FileName);
        Replace(Result, '<PROJECTPATH>', MainForm.fProject.Directory);
        Replace(Result, '<SOURCESPCLIST>', MainForm.fProject.ListUnitStr(' '));
    End
    { Non-project editor macros }
    Else
    If Assigned(e) Then
    Begin
        // GAR 10 Nov 2009
        // Hack for Wine/Linux
        // ProductName returns empty string for Wine/Linux
        // for Windows, it returns OS name (e.g. Windows Vista).
        If (MainForm.JvComputerInfoEx1.OS.ProductName = '') Then
            Replace(Result, '<EXENAME>', ChangeFileExt(e.FileName, ''))
        Else
            Replace(Result, '<EXENAME>', ChangeFileExt(e.FileName, EXE_EXT));

        Replace(Result, '<PROJECTNAME>', e.FileName);
        Replace(Result, '<PROJECTFILE>', e.FileName);
        Replace(Result, '<PROJECTPATH>', ExtractFilePath(e.FileName));

        // clear unchanged macros
        Replace(Result, '<SOURCESPCLIST>', '');
    End
    Else
    Begin
        // clear unchanged macros
        Replace(Result, '<EXENAME>', '');
        Replace(Result, '<PROJECTNAME>', '');
        Replace(Result, '<PROJECTFILE>', '');
        Replace(Result, '<PROJECTPATH>', '');
        Replace(Result, '<SOURCESPCLIST>', '');
    End;

    { Editor macros }
    If Assigned(e) Then
    Begin
        Replace(Result, '<SOURCENAME>', e.FileName);

        If Length(e.FileName) = 0 Then
            Replace(Result, '<SOURCENAME>', devDirs.Default)
        Else
            Replace(Result, '<SOURCENAME>', ExtractFilePath(e.FileName));

        Replace(Result, '<WORDXY>', e.GetWordAtCursor);
    End
    Else
    Begin
        // clear unchanged macros
        Replace(Result, '<SOURCENAME>', '');
        Replace(Result, '<SOURCENAME>', '');
        Replace(Result, '<WORDXY>', '');
    End;
End;

End.
