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

Unit Templates;

Interface

Uses
    Classes, Types, IniFiles, prjtypes, devcfg;

Type
    TTemplateUnit = Record
        CName: String;
        CppName: String;
        ResName: String;
        CText: String;
        CppText: String;
        ResText: String;
    End;

    TTemplateRec = Record
        CCaret: TPoint;
        CppCaret: TPoint;
        IsCPP: Boolean; // TRUE = C++ / FALSE = C
        IsRes: Boolean;
        CText: String;
        CppText: String;
        ResText: String;
    End;

    TTemplate = Class
    Private
        fFileName: String;
        fOptions: TProjectProfileList;
        fName: String;
        fDesc: String;
        fCatagory: String;
        fPrjName: String;
        fProjectIcon: String;
        fIconIndex: Integer;
        fTemplate: TmeminiFile;
        fVersion: Integer;
        fPlugin: String;

        Function GetUnitCount: Integer;
        Function GetOldData: TTemplateRec;
        Function GetVersion: Integer;
        Function GetUnit(index: Integer): TTemplateUnit;
        Procedure SetUnit(index: Integer; value: TTemplateUnit);
        Procedure SetOldData(value: TTemplateRec);
    Public
        Constructor Create;
        Destructor Destroy; Override;

        Procedure ReadTemplateFile(Const FileName: String);
        Procedure LoadFromStream(Const ms: TStream);
        Function AddUnit: Integer;
        Procedure RemoveUnit(Const index: Integer);
        Function Save: Boolean;

        Property Catagory: String Read fCatagory Write fCatagory;
        Property Description: String Read fDesc Write fDesc;
        Property FileName: String Read fFileName Write fFileName;
        Property Name: String Read fName Write fName;
        Property OptionsRec: TProjectProfileList Read fOptions Write fOptions;
        Property ProjectName: String Read fPrjName Write fPrjName;
        Property ProjectIcon: String Read fProjectIcon Write fProjectIcon;
        Property UnitCount: Integer Read GetUnitCount;
        Property Units[index: Integer]: TTemplateUnit Read GetUnit Write SetUnit;
        Property OldData: TTemplateRec Read GetOldData Write SetOldData;
        Property Version: Integer Read GetVersion Write fVersion;
        Property IconIndex: Integer Read fIconIndex Write fIconIndex;
        Property AssignedPlugin: String Read fPlugin Write fPlugin;
    End;

Implementation

Uses
    main,
{$IFDEF WIN32}
    Windows, Forms, SysUtils, version, utils, Dialogs, MultiLangSupport;
{$ENDIF}
{$IFDEF LINUX}
  QForms, SysUtils, version, utils, QDialogs, MultiLangSupport;
{$ENDIF}

Resourcestring
    cTemplate = 'Template';
    cEditor = 'Editor';
    cProject = 'Project';

{ TTemplate }

Constructor TTemplate.Create;
Begin
    fOptions := TProjectProfileList.Create;
End;

Destructor TTemplate.Destroy;
Begin
    fOptions.Free;
    Inherited;
End;

Procedure TTemplate.ReadTemplateFile(Const FileName: String);
Var
    NewProfile: TProjProfile;
    CurrentProfileName: String;
    ProfileCount, i: Integer;

    Procedure VerifyProfile(Var NewProfile: TProjProfile);
    Var
        i, CurrentSet: Integer;
    Begin
        //Store the old compiler set
        CurrentSet := devCompiler.CompilerSet;

        //Do some sanity checking - if the profile states that we should be using a MingW compiler,
        //then make sure the CompilerSet actually points to one that is of CompilerType.
        If devCompilerSet.Sets.Count > NewProfile.CompilerSet Then
            devCompilerSet.LoadSet(NewProfile.CompilerSet);
        If devCompilerSet.CompilerType <> NewProfile.compilerType Then
            For i := 0 To devCompilerSet.Sets.Count - 1 Do
            Begin
                devCompilerSet.LoadSet(i);
                If devCompilerSet.CompilerType = NewProfile.compilerType Then
                Begin
                    NewProfile.CompilerSet := i;
                    Break;
                End;
            End;

        //Restore the old compiler set
        devCompilerSet.LoadSet(CurrentSet);
    End;
Begin

    If Assigned(fTemplate) Then
        fTemplate.Free;
    If FileExists(FileName) Then
    Begin
        fFileName := FileName;
        fTemplate := TmemINIFile.Create(fFileName);
    End
    Else
    Begin
        MessageBox(Application.MainForm.Handle,
            Pchar(Format(Lang[ID_ERR_TEMPFNF], [fFileName])),
            Pchar(Lang[ID_INFO]), MB_OK Or MB_ICONINFORMATION);
        Exit;
    End;

    With fTemplate Do
    Begin
        // read entries for both old and new template info
        fVersion := ReadInteger(cTemplate, 'Ver', -1);
        fName := ReadString(cTemplate, 'Name', 'NoName');
        fDesc := ReadString(cTemplate, 'Description', 'NoDesc');
        fCatagory := ReadString(cTemplate, 'Catagory', '');
        fIconIndex := ReadInteger(cTemplate, 'IconIndex', 0);
        fPlugin := ReadString(cTemplate, 'Plugin', '');

        // project info
        fPrjName := ReadString(cProject, 'Name', '');
        ProfileCount := ReadInteger(cProject, 'ProfilesCount', 0);

        //If there are no Profiles then we'll assume the template as version 1
        If (ProfileCount = 0) And (fVersion = 3) Then
            fVersion := 1;

        If fPrjName = '' Then
            fPrjName := fName;

        If fName = '' Then
            fName := fPrjName;

        If fVersion < 3 Then
        Begin
            NewProfile := TProjProfile.Create;
            NewProfile.ProfileName := 'MingW';
            fOptions.Add(NewProfile);
        End;

        // read old style
        If fVersion <= 0 Then
        Begin
            fOptions[0].icon := ReadString(cTemplate, 'Icon', '');
            If ReadBool(cProject, 'Console', False) Then
                fOptions[0].typ := dptCon
            Else
            If ReadBool(cProject, 'DLL', False) Then
                fOptions[0].typ := dptDyn
            Else
                fOptions[0].Typ := dptGUI;

            fOptions.useGPP := ReadBool(cProject, 'Cpp', False);
            fOptions[0].Compiler := ReadString(cProject, 'CompilerOptions', '');
            fOptions[0].CompilerType := ID_COMPILER_MINGW;
            fOptions[0].Libs.Append(ReadString(cProject, 'Libs', ''));
            fOptions[0].Includes.Append(ReadString(cProject, 'Includes', ''));

            //Verify the profile's integrity
            VerifyProfile(NewProfile);
        End
        Else
        If (fVersion = 1) Or (fVersion = 2) Then
        Begin
            ProjectIcon :=
                ReadString(cProject, 'ProjectIcon', '');
            fOptions.useGPP := ReadBool(cProject, 'IsCpp', False);
            fOptions[0].compilerType := ID_COMPILER_MINGW;
            fOptions[0].icon := ReadString(cTemplate, 'Icon', '');
            fOptions[0].typ := ReadInteger(cProject, 'Type', 0);
            // default = gui
            fOptions[0].Includes.DelimitedText :=
                ReadString(cProject, 'Includes', '');
            fOptions[0].Libs.DelimitedText := ReadString(cProject, 'Libs', '');

{$IFDEF PLUGIN_BUILD}
            // Tony Reina 11 June 2005
            // This is needed to grab the MakeIncludes from the template file of a new project
            fOptions[0].MakeIncludes.DelimitedText :=
                ReadString(cProject, 'MakeIncludes', '');
{$ENDIF}

            fOptions[0].ResourceIncludes.DelimitedText :=
                ReadString(cProject, 'ResourceIncludes', '');
            fOptions[0].Compiler :=
                ReadString(cProject, 'Compiler', '');
            fOptions[0].CppCompiler :=
                ReadString(cProject, 'CppCompiler', '');
            fOptions[0].Linker :=
                ReadString(cProject, 'Linker', '');
            fOptions[0].PreprocDefines :=
                ReadString(cProject, 'PreprocDefines', '');
            fOptions[0].CompilerOptions :=
                ReadString(cProject, COMPILER_INI_LABEL, '');
            fOptions[0].IncludeVersionInfo :=
                ReadBool(cProject, 'IncludeVersionInfo', False);
            fOptions[0].SupportXPThemes :=
                ReadBool(cProject, 'SupportXPThemes', False);
            fOptions[0].ExeOutput :=
                ReadString(cProject, 'ExeOutput', '');
            fOptions[0].ObjectOutput :=
                ReadString(cProject, 'ObjectOutput', '');

            fOptions[0].ImagesOutput :=
                ReadString(cProject, 'ImagesOutput', '');

            If (Trim(fOptions[0].ExeOutput) = '') And
                (Trim(fOptions[0].ObjectOutput) <> '') Then
                fOptions[0].ExeOutput := fOptions[0].ObjectOutput
            Else
            If (Trim(fOptions[0].ExeOutput) <> '') And
                (trim(fOptions[0].ObjectOutput) = '') Then
                fOptions[0].ObjectOutput := fOptions[0].ExeOutput
            Else
            If (fOptions[0].ExeOutput = '') And (fOptions[0].ObjectOutput = '') Then
            Begin
                fOptions[0].ObjectOutput := fOptions[0].ProfileName;
                fOptions[0].ExeOutput := fOptions[0].ProfileName;
            End;

            //Verify the profile's integrity
            VerifyProfile(NewProfile);
        End
        Else // read new style
        Begin
            ProfileCount := ReadInteger(cProject, 'ProfilesCount', 0);
            For i := 0 To ProfileCount - 1 Do
            Begin
                ProjectIcon :=
                    ReadString(cProject, 'ProjectIcon', '');
                fOptions.useGPP :=
                    ReadBool(cProject, 'IsCpp', False);

                //Read the current profile's values
                CurrentProfileName := 'Profile' + IntToStr(i);
                NewProfile := TProjProfile.Create;
                NewProfile.ProfileName :=
                    ReadString(CurrentProfileName, 'ProfileName', '');
                NewProfile.typ :=
                    ReadInteger(CurrentProfileName, 'Type', 0);
                NewProfile.compilerType :=
                    ReadInteger(CurrentProfileName, 'CompilerType', ID_COMPILER_MINGW);
                NewProfile.Compiler :=
                    ReadString(CurrentProfileName, 'Compiler', '');
                NewProfile.CppCompiler :=
                    ReadString(CurrentProfileName, 'CppCompiler', '');
                NewProfile.Linker :=
                    ReadString(CurrentProfileName, 'Linker', '');
                NewProfile.ObjFiles.DelimitedText :=
                    ReadString(CurrentProfileName, 'ObjFiles', '');
                NewProfile.Includes.DelimitedText :=
                    ReadString(CurrentProfileName, 'Includes', '');
                NewProfile.Libs.DelimitedText :=
                    ReadString(CurrentProfileName, 'Libs', '');
                NewProfile.ResourceIncludes.DelimitedText :=
                    ReadString(CurrentProfileName, 'ResourceIncludes', '');
                NewProfile.MakeIncludes.DelimitedText :=
                    ReadString(CurrentProfileName, 'MakeIncludes', '');
                NewProfile.Icon :=
                    ReadString(CurrentProfileName, 'Icon', '');
                NewProfile.ExeOutput :=
                    ReadString(CurrentProfileName, 'ExeOutput', '');
                NewProfile.ObjectOutput :=
                    ReadString(CurrentProfileName, 'ObjectOutput', '');
                NewProfile.ImagesOutput :=
                    ReadString(CurrentProfileName, 'ImagesOutput', 'Images\');
                NewProfile.OverrideOutput :=
                    ReadBool(CurrentProfileName, 'OverrideOutput', False);
                NewProfile.OverridenOutput :=
                    ReadString(CurrentProfileName, 'OverrideOutputName', '');
                NewProfile.HostApplication :=
                    ReadString(CurrentProfileName, 'HostApplication', '');
                NewProfile.IncludeVersionInfo :=
                    ReadBool(CurrentProfileName, 'IncludeVersionInfo', False);
                NewProfile.SupportXPThemes :=
                    ReadBool(CurrentProfileName, 'SupportXPThemes', False);
                NewProfile.CompilerSet :=
                    ReadInteger(CurrentProfileName, 'CompilerSet', 0);
                NewProfile.CompilerOptions :=
                    ReadString(CurrentProfileName, COMPILER_INI_LABEL, '');
                NewProfile.PreprocDefines :=
                    ReadString(CurrentProfileName, 'PreprocDefines', '');

                //Verify the profile's integrity
                VerifyProfile(NewProfile);

                //Save the profile to the list of profiles available
                fOptions.Add(NewProfile);
            End;
        End;
    End;
End;

// need to actually save values. (basiclly TTemplate is readonly right now)
Function TTemplate.Save: Boolean;
Var
    fName: String;
Begin
    result := False;
    Try
        If assigned(fTemplate) Then
        Begin
            If (fTemplate.FileName = '') Then
            Begin
                // ** prompt for name place in fname
                fTemplate.Rename(fName, False);
            End;
            fTemplate.UpdateFile;
            result := True;
        End;
    Except
        // swallow
    End;
End;

Function TTemplate.AddUnit: Integer;
Var
    section: String;
Begin
    If (fVersion > 0) And (assigned(fTemplate)) Then
    Begin
        result := GetUnitCount + 1;
        section := 'Unit' + inttostr(result);
        fTemplate.WriteString(section, 'C', '');
        fTemplate.WriteString(section, 'Cpp', '');
        fTemplate.WriteString(section, 'Res', '');
        fTemplate.WriteInteger(cProject, 'UnitCount', result);
    End
    Else
        result := -1;
End;

Procedure TTemplate.RemoveUnit(Const index: Integer);
Var
    section: String;
    count: Integer;
Begin
    section := 'Unit' + inttostr(index);
    If fTemplate.SectionExists(section) Then
    Begin
        fTemplate.EraseSection(section);
        Count := fTemplate.ReadInteger(cProject, 'UnitCount', 0);
        dec(Count);
        fTemplate.WriteInteger(cProject, 'UnitCount', Count);
    End;
End;

Function TTemplate.GetOldData: TTemplateRec;
Begin
    If Not assigned(fTemplate) Then
    Begin
        FillChar(result, Sizeof(TTemplateRec), #0);
        exit;
    End;

    If (fVersion <= 0) Then // read old style
    Begin
        result.CText := fTemplate.ReadString(cEditor, 'Text', '');
        result.CppText := fTemplate.ReadString(cEditor, 'Text_Cpp', '');
        result.CCaret := point(fTemplate.ReadInteger(cEditor, 'CursorX', 1),
            fTemplate.ReadInteger(cEditor, 'CursorY', 1));
        result.CppCaret := point(fTemplate.ReadInteger(cEditor, 'CursorX_Cpp', 1),
            fTemplate.ReadInteger(cEditor, 'CursorY_Cpp', 1));
        result.IsCPP := fTemplate.ReadBool(cTemplate, 'EnableC', False);
        If Not result.IsCPP Then
            result.IsCPP := fTemplate.ReadBool(cTemplate, 'EnableCpp', False);
    End
    Else // read new style
    Begin
        If fTemplate.ReadInteger(cTemplate, 'UnitCount', 0) > 0 Then
        Begin
            result.CText := fTemplate.ReadString('Unit0', 'C', '');
            result.CppText := fTemplate.ReadString('Unit0', 'Cpp', '');
            result.ResText := fTemplate.ReadString('Unit0', 'Res', '');
        End;
        result.CCaret := point(1, 1);
        result.CppCaret := point(1, 1);
        result.IsCpp := fTemplate.ReadBool(cProject, 'IsCpp', True);
        result.IsRes := fTemplate.ReadBool(cProject, 'IsRes', False);
    End;
End;

Procedure TTemplate.SetOldData(value: TTemplateRec);
Begin
    If Not assigned(fTemplate) Then
    Begin
        MessageBox(Application.MainForm.Handle,
            Pchar(Lang[ID_ERR_NOTEMPLATE]), Pchar(Lang[ID_INFO]),
            MB_OK Or MB_ICONWARNING);
        exit;
    End;

    If (fVersion <= 0) Then // set old style
        With fTemplate Do
        Begin
            WriteInteger(cEditor, 'CursorX', value.CCaret.X);
            WriteInteger(cEditor, 'CursorY', value.CCaret.Y);
            WriteInteger(cEditor, 'Cursor_CppX', value.CppCaret.X);
            WriteInteger(cEditor, 'Cursor_CppY', value.CppCaret.Y);
            WriteBool(cTemplate, 'EnableC', Not value.IsCPP);
            WriteBool(cTemplate, 'EnableCpp', value.IsCpp);
        End
    Else // seems dumb but might happen
    Begin
        fTemplate.WriteBool(cProject, 'Cpp', value.IsCpp);
        fTemplate.WriteBool(cProject, 'Res', value.IsRes);
    End;
End;

Function TTemplate.GetUnit(index: Integer): TTemplateUnit;
Var
    section: String;
Begin
    If Not assigned(fTemplate) Then
    Begin
        FillChar(result, Sizeof(TTemplateUnit), #0);
        exit;
    End;
    If fVersion <= 0 Then // return nothing no units in old style
    Begin
        result.CText := '';
        result.CppText := '';
        result.ResText := '';
    End
    Else // return unit info
    Begin
        section := 'Unit' + inttostr(index);
        result.CText := fTemplate.ReadString(section, 'C', '');
        result.CppText := fTemplate.ReadString(section, 'Cpp', '');
        result.ResText := fTemplate.ReadString(section, 'Res', '');
        If Length(result.CppText) = 0 Then
            result.CppText := result.CText;

        result.ResName := fTemplate.ReadString(section, 'ResName', '');
        result.CName := fTemplate.ReadString(section, 'CName', '');
        result.CppName := fTemplate.ReadString(section, 'CppName', '');
        If Length(result.CppName) = 0 Then
            result.CppName := result.CName;
    End;
End;

Procedure TTemplate.SetUnit(index: Integer; value: TTemplateUnit);
Var
    section: String;
Begin
    If Not assigned(fTemplate) Or (fVersion <= 0) Then
        exit;
    section := 'Unit' + inttostr(index);
    If fTemplate.SectionExists(section) Then
    Begin
        fTemplate.WriteString(section, 'C', value.CText);
        fTemplate.WriteString(section, 'Cpp', value.CppText);
        fTemplate.WriteString(section, 'Res', value.ResText);
        fTemplate.WriteString(section, 'CName', value.CName);
        fTemplate.WriteString(section, 'CppName', value.CppName);
        fTemplate.WriteString(section, 'ResName', value.ResName);
    End
    Else
        // debugging (we need to add debugging mode defines)
        showmessage('Section doesn''t exists ' + inttostr(index));
End;

Function TTemplate.GetUnitCount: Integer;
Begin
    If Not assigned(fTemplate) Then
        result := -1
    Else
    If (fVersion <= 0) Then
        result := 0
    Else
        result := fTemplate.ReadInteger(cProject, 'UnitCount', 0);
End;

Function TTemplate.GetVersion: Integer;
Begin
    result := fVersion;
End;

Procedure TTemplate.LoadFromStream(Const ms: TStream);
Begin
    //
End;

End.
