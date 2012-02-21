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

Unit project;

Interface

Uses
    Utils, StrUtils, jvsimplexml, //SynEditCodeFolding,
{$IFDEF WIN32}
    IniFiles, SysUtils, Dialogs, ComCtrls, Editor, Contnrs,
    Classes, Controls, version, prjtypes, Templates, Forms,
{$IFDEF PLUGIN_BUILD}
    iplugin_bpl,
{$ENDIF}
    Windows;
{$ENDIF}
{$IFDEF LINUX}
  IniFiles, SysUtils, QDialogs, QComCtrls, Editor, Contnrs,
  Classes, QControls, version, prjtypes, Templates, QForms
  ;
{$ENDIF}

Type
    TdevINI = Class(TObject)
    Private
        fINIFile: TmemINIFile;
        fSection: String;
        fFileName: String;
        Procedure SetFileName(Const Value: String);
        Procedure SetSection(Const Value: String);
    Public
        Destructor Destroy; Override;

        Procedure Write(Name, value: String); Overload;
        Procedure Write(Name: String; value: Boolean); Overload;
        Procedure Write(Name: String; value: Integer); Overload;
        Procedure WriteUnit(index: Integer; value: String); Overload;
        Procedure WriteUnit(index: Integer; Item: String; Value: String); Overload;
        Procedure WriteUnit(index: Integer; Item: String; Value: Boolean);
            Overload;
        Procedure WriteUnit(index: Integer; Item: String; Value: Integer);
            Overload;

        Procedure WriteProfile(index: Integer; Item: String;
            Value: String); Overload;
        Procedure WriteProfile(index: Integer; Item: String;
            Value: Boolean); Overload;
        Procedure WriteProfile(index: Integer; Item: String;
            Value: Integer); Overload;

        Function Read(Name, Default: String): String; Overload;
        Function Read(Name: String; Default: Boolean): Boolean; Overload;
        Function Read(Name: String; Default: Integer): Integer; Overload;
        Function ReadUnit(index: Integer): String; Overload; // read unit entry
        Function ReadUnit(index: Integer; Item: String;
            default: String): String; Overload;
        Function ReadUnit(index: Integer; Item: String;
            default: Boolean): Boolean; Overload;
        Function ReadUnit(index: Integer; Item: String;
            default: Integer): Integer; Overload;

        Function ReadProfile(index: Integer; Item: String;
            default: String): String; Overload;
        Function ReadProfile(index: Integer; Item: String;
            default: Boolean): Boolean; Overload;
        Function ReadProfile(index: Integer; Item: String;
            default: Integer): Integer; Overload;

        Function ValueExists(Const value: String): Boolean;
        Procedure DeleteKey(Const value: String);
        Procedure ClearSection(Const Section: String = '');
        Procedure EraseUnit(Const index: Integer);
        Procedure UpdateFile;
        Property FileName: String Read fFileName Write SetFileName;
        Property Section: String Read fSection Write SetSection;
    End;

    TProjUnit = Class;
    TUnitList = Class
    Private
        fList: TObjectList;
        Function GetCount: Integer;
        Function GetItem(index: Integer): TProjUnit;
        Procedure SetItem(index: Integer; value: TProjUnit);
    Public
        Constructor Create;
        Destructor Destroy; Override;
        Function Add(aunit: TProjUnit): Integer;
        Procedure Remove(index: Integer);
        Function Indexof(FileName: String): Integer; Overload;
        Function Indexof(Node: TTreeNode): Integer; Overload;
        Function Indexof(Editor: TEditor): Integer; Overload;

        Property Items[index: Integer]: Tprojunit Read GetItem Write SetItem;
            Default;
        Property Count: Integer Read GetCount;
    End;

    TProject = Class;
    TProjUnit = Class
    Private
        fParent: TProject;
        fEditor: TEditor;
        fFileName: String;
        fNew: Boolean;
        fNode: TTreeNode;
        fFolder: String;
        fCompile: Boolean;
        fCompileCpp: Boolean;
        fOverrideBuildCmd: Boolean;
        fBuildCmd: String;
        fLink: Boolean;
        fPriority: Integer;
        Function GetDirty: Boolean;
        Procedure SetDirty(value: Boolean);
    Public
        Constructor Create(aOwner: TProject);
        Destructor Destroy; Override;
        Function Save: Boolean;
        Function SaveAs: Boolean;
        Property Editor: TEditor Read fEditor Write fEditor;
        Property FileName: String Read fFileName Write fFileName;
        Property New: Boolean Read fNew Write fNew;
        Property Dirty: Boolean Read GetDirty Write SetDirty;
        Property Node: TTreeNode Read fNode Write fNode;
        Property Parent: TProject Read fParent Write fParent;
        Property Folder: String Read fFolder Write fFolder;
        Property Compile: Boolean Read fCompile Write fCompile;
        Property CompileCpp: Boolean Read fCompileCpp Write fCompileCpp;
        Property OverrideBuildCmd: Boolean
            Read fOverrideBuildCmd Write fOverrideBuildCmd;
        Property BuildCmd: String Read fBuildCmd Write fBuildCmd;
        Property Link: Boolean Read fLink Write fLink;
        Property Priority: Integer Read fPriority Write fPriority;
        Procedure Assign(Source: TProjUnit);
    End;

    TProject = Class
    Private
        fUnits: TUnitList;
        fProfiles: TProjectProfileList;
        finiFile: Tdevini;
        fName: String;
        fFileName: String;
        fNode: TTreeNode;
        fModified: Boolean;
        fFolders: TStringList;
        fFolderNodes: TObjectList;
        fCmdLineArgs: String;
        fPchHead: Integer;
        fPchSource: Integer;
        fDefaultProfileIndex: Integer;
        fCurrentProfileIndex: Integer;
        fPrevVersion: Integer;
        fPlugin: String;

        Function GetDirectory: String;
        Function GetExecutableName: String;
        Procedure SetFileName(value: String);
        Procedure SetNode(value: TTreeNode);
        Function GetModified: Boolean;
        Function GetCurrentProfile: TProjProfile;
        Procedure SetCurrentProfile(Value: TProjProfile);
        Procedure SetModified(value: Boolean);
        Procedure SortUnitsByPriority;
        Procedure SetCmdLineArgs(Const Value: String);
    Public
        VersionInfo: TProjVersionInfo;
        Property Name: String Read fName Write fName;
        Property FileName: String Read fFileName Write SetFileName;
        Property Node: TTreeNode Read fNode Write SetNode;
        Property AssociatedPlugin: String Read fPlugin Write fPlugin;

        Property Directory: String Read GetDirectory;
        Property Executable: String Read GetExecutableName;

        Property Units: TUnitList Read fUnits Write fUnits;
        Property Profiles: TProjectProfileList Read fProfiles Write fProfiles;
        Property INIFile: TdevINI Read fINIFile Write fINIFile;
        Property Modified: Boolean Read GetModified Write SetModified;

        Property CmdLineArgs: String Read fCmdLineArgs Write SetCmdLineArgs;
        Property PchHead: Integer Read fPchHead Write fPchHead;
        Property PchSource: Integer Read fPchSource Write fPchSource;

        Property CurrentProfileIndex: Integer
            Read fCurrentProfileIndex Write fCurrentProfileIndex;
        Property CurrentProfile: TProjProfile
            Read GetCurrentProfile Write SetCurrentProfile;
        Property DefaultProfileIndex: Integer
            Read fDefaultProfileIndex Write fDefaultProfileIndex;

    Public
        Constructor Create(nFileName, nName: String);
        Destructor Destroy; Override;
        Function NewUnit(NewProject: Boolean;
            CustomFileName: String = ''): Integer;
        Function AddUnit(s: String; pFolder: TTreeNode;
            Rebuild: Boolean): TProjUnit;
        Function GetFolderPath(Node: TTreeNode): String;
        Procedure UpdateFolders;
        Procedure AddFolder(s: String);
        Procedure RemoveFolder(s: String);
        Function OpenUnit(index: Integer): TEditor;
        Procedure CloseUnit(index: Integer);
        Procedure SaveUnitAs(i: Integer; sFileName: String);
        Procedure Save;
        Procedure LoadLayout;
        Procedure LoadUnitLayout(e: TEditor; Index: Integer);
        Procedure LoadProfiles;
        Procedure SaveLayout;
        Procedure SaveUnitLayout(e: TEditor; Index: Integer);
        Function GetExecutableNameExt(projProfile: TProjProfile): String;
        Function MakeProjectNode: TTreeNode;
        Function MakeNewFileNode(s: String; IsFolder: Boolean;
            NewParent: TTreeNode): TTreeNode;
        Procedure BuildPrivateResource(ForceSave: Boolean = False);
        Procedure Update;
        Procedure UpdateFile;
        Function UpdateUnits: Boolean;
        Procedure Open;
        Function FileAlreadyExists(s: String): Boolean;
        Function Remove(index: Integer; DoClose: Boolean): Boolean;
        Function GetUnitFromEditor(ed: TEditor): Integer;
        Function GetUnitFromString(s: String): Integer;
        Function GetUnitFromNode(t: TTreeNode): Integer;
        Function GetFullUnitFileName(Const index: Integer): String;
        Function DoesEditorExists(e: TEditor): Boolean;
        Procedure AddLibrary(s: String);
        Procedure AddInclude(s: String);
        Procedure RemoveLibrary(index: Integer);
        Procedure RemoveInclude(index: Integer);
        Procedure RebuildNodes;
        Function ListUnitStr(Const sep: Char): String;
        Procedure Exportto(Const HTML: Boolean);
        Procedure ShowOptions;
        Function AssignTemplate(Const aFileName: String;
            Const aTemplate: TTemplate): Boolean;
        Procedure SetHostApplication(s: String);
        Function FolderNodeFromName(name: String): TTreeNode;
        Procedure CreateFolderNodes;
        Procedure UpdateNodeIndexes;
        Procedure SetNodeValue(value: TTreeNode);
        Procedure CheckProjectFileForUpdate;
        Procedure IncrementBuildNumber;
        Function ExportToExternalProject(Const aFileName: String): Boolean;
    End;

Implementation
Uses
    main, MultiLangSupport, devcfg, ProjectOptionsFrm, datamod,
    RemoveUnitFrm;

{ TProjUnit }

Constructor TProjUnit.Create(aOwner: TProject);
Begin
    fEditor := Nil;
    fNode := Nil;
    fParent := aOwner;
End;

Destructor TProjUnit.Destroy;
Begin

    If Assigned(fEditor) Then
        FreeAndNil(fEditor)
    else
        fEditor := Nil;

    fNode := Nil;
    
    Inherited;
End;

Function TProjUnit.Save: Boolean;
{$IFDEF PLUGIN_BUILD}
Var
    i: Integer;
    boolForm: Boolean;
{$ENDIF}
    Procedure DisableFileWatch;
    Var
        idx: Integer;
    Begin
        idx := MainForm.devFileMonitor.Files.IndexOf(fEditor.FileName);
        If idx <> -1 Then
        Begin
            MainForm.devFileMonitor.Files.Delete(idx);
            MainForm.devFileMonitor.Refresh(False);
        End;
    End;

    Procedure EnableFileWatch;
    Begin
        MainForm.devFileMonitor.Files.Add(fEditor.FileName);
        MainForm.devFileMonitor.Refresh(False);
    End;
Begin
    If (fFileName = '') Or fNew Then
        result := SaveAs
    Else
        Try
{$IFDEF PLUGIN_BUILD}
   {         if Assigned(fEditor) then
            begin
                boolForm := false;
                for i := 0 to MainForm.pluginsCount - 1 do
                    boolForm := boolForm or MainForm.plugins[i].IsForm(fEditor.FileName);
                if boolForm then
                    //Update the XPMs if we dont have them on the disk
                    for i := 0 to MainForm.pluginsCount - 1 do
                        MainForm.plugins[i].CreateNewXPMs(fEditor.FileName);
                // EAB TODO: Think better for multiple plugins here
            end;
            }
{$ENDIF}

            //If no editor is created open one; save file and close creates a blank file.
            If (Not Assigned(fEditor)) And (Not FileExists(fFileName)) Then
            Begin
                fEditor := TEditor.Create;
                fEditor.Init(True, ExtractFileName(fFileName), fFileName, False);
                If devEditor.AppendNewline Then
                    With fEditor.Text Do
                        If Lines.Count > 0 Then
                            If Lines[Lines.Count - 1] <> '' Then
                                Lines.Add('');

                DisableFileWatch;
                  // Code folding - Save the un-folded text, otherwise	 
	       //    the folded regions won't be saved.	 
	     {  if (fEditor.Text.CodeFolding.Enabled) then
	       begin	 
	          fEditor.Text.ReScanForFoldRanges;	 
	           //fEditor.Text.Update;	 
	          fEditor.Text.UncollapsedLines.SavetoFile(fFileName);
	       end
	       else    }
                fEditor.Text.Lines.SavetoFile(fFileName);

                EnableFileWatch;

                fEditor.New := False;
                fEditor.Modified := False;
                fEditor.Close;
                fEditor := Nil; //Closing the editor will destroy it
            End
            Else
            If assigned(fEditor) And fEditor.Modified Then
            Begin
                If devEditor.AppendNewline Then
                    With fEditor.Text Do
                        If Lines.Count > 0 Then
                            If Lines[Lines.Count - 1] <> '' Then
                                Lines.Add('');

                DisableFileWatch;

                fEditor.Text.Lines.SavetoFile(fFileName);
                EnableFileWatch;

                fEditor.New := False;
                fEditor.Modified := False;
                If FileExists(fEditor.FileName) Then
                    FileSetDate(fEditor.FileName, DateTimeToFileDate(Now));
                // fix the "Clock skew detected" warning ;)
            End;

            If assigned(fNode) Then
                fNode.Text := ExtractFileName(fFileName);
            result := True;
        Except
            result := False;
        End;
End;

Function TProjUnit.SaveAs: Boolean;
Var
    flt: String;
    CFilter, CppFilter, HFilter: Integer;
{$IFDEF PLUGIN_BUILD}
    boolForm: Boolean;
    pluginFilter: Integer;
    filters: TStringList;
    i, j: Integer;
{$ENDIF}
Begin
    With dmMain.SaveDialog Do
    Begin
        If fFileName = '' Then
            FileName := fEditor.TabSheet.Caption
        Else
            FileName := ExtractFileName(fFileName);
{$IFDEF PLUGIN_BUILD}
        boolForm := False;
        For i := 0 To MainForm.pluginsCount - 1 Do
            boolForm := boolForm Or MainForm.plugins[i].IsForm(FileName);
{$ENDIF}

        If fParent.Profiles.useGPP Then
        Begin
            BuildFilter(flt, [FLT_CPPS, FLT_CS, FLT_HEADS]);
{$IFDEF PLUGIN_BUILD}
            // <-- EAB TODO: Check for a potential problem with multiple plugins
            pluginFilter := 3;
            For i := 0 To MainForm.packagesCount - 1 Do
            Begin
                filters := (MainForm.plugins[MainForm.delphi_plugins[i]] As
                    IPlug_In_BPL).GetFilters;
                For j := 0 To filters.Count - 1 Do
                Begin
                    AddFilter(flt, filters.Strings[j]);
                    pluginFilter := pluginFilter + 1;
                End;
            End;
    {$ENDIF}
            DefaultExt := CPP_EXT;
            CFilter := 3;
            CppFilter := 2;
            HFilter := 4;

        End
        Else
        Begin
            BuildFilter(flt, [FLT_CS, FLT_CPPS, FLT_HEADS]);
{$IFDEF PLUGIN_BUILD}
            pluginFilter := 3;
            For i := 0 To MainForm.packagesCount - 1 Do
            Begin
                filters := (MainForm.plugins[MainForm.delphi_plugins[i]] As
                    IPlug_In_BPL).GetFilters;
                For j := 0 To filters.Count - 1 Do
                Begin
                    AddFilter(flt, filters.Strings[j]);
                    pluginFilter := pluginFilter + 1;
                End;
            End;
{$ENDIF}
            DefaultExt := C_EXT;
            CFilter := 2;
            CppFilter := 3;
            HFilter := 4;
        End;
{$IFDEF PLUGIN_BUILD}
        For i := 0 To MainForm.pluginsCount - 1 Do
            // <-- EAB TODO: Check for a potential problem with multiple plugins
        Begin
            AddFilter(flt, MainForm.plugins[i].GetFilter(FileName));
            DefaultExt := MainForm.plugins[i].Get_EXT(FileName);
            CFilter := 2;
            CppFilter := 2;
            HFilter := 2;
            If MainForm.plugins[i].IsForm(FileName) Then
                pluginFilter := 2;
        End;
{$ENDIF}

        Filter := flt;
        If (CompareText(ExtractFileExt(FileName), '.h') = 0) Or
            (CompareText(ExtractFileExt(FileName), '.hpp') = 0) Or
            (CompareText(ExtractFileExt(FileName), '.hh') = 0) Then
        Begin
            FilterIndex := HFilter;
        End
        Else
        Begin
            If fParent.Profiles.useGPP Then
                FilterIndex := CppFilter
            Else
                FilterIndex := CFilter;
        End;
{$IFDEF PLUGIN_BUILD}
        If boolForm Then
            FilterIndex := pluginFilter;
{$ENDIF}

        InitialDir := ExtractFilePath(fFileName);
        Title := Lang[ID_NV_SAVEFILE];
        If Execute Then
            Try
                If FileExists(FileName) And
                    (MessageDlg(Lang[ID_MSG_FILEEXISTS],
                    mtWarning, [mbYes, mbNo], 0) = mrNo) Then
                Begin
                    Result := False;
                    Exit;
                End;

                fNew := False;
                fFileName := FileName;
                If assigned(fEditor) Then
                    fEditor.FileName := fFileName;
                result := Save;
            Except
                result := False;
            End
        Else
            result := False;
    End;
End;

Function TProjUnit.GetDirty: Boolean;
Begin
    If assigned(fEditor) Then
        result := fEditor.Modified
    Else
        result := False;
End;

Procedure TProjUnit.SetDirty(value: Boolean);
Begin
    If assigned(fEditor) Then
        fEditor.Modified := value;
End;

Procedure TProjUnit.Assign(Source: TProjUnit);
Begin
    fEditor := Source.fEditor;
    fFileName := Source.fFileName;
    fNew := Source.fNew;
    Dirty := Source.Dirty;
    fNode := Source.fNode;
    fParent := Source.fParent;
    fFolder := Source.fFolder;
    fCompile := Source.fCompile;
    fCompileCpp := Source.fCompileCpp;
    fOverrideBuildCmd := Source.fOverrideBuildCmd;
    fBuildCmd := Source.fBuildCmd;
    fLink := Source.fLink;
    fPriority := Source.fPriority;
End;

{ TProject }

Constructor TProject.Create(nFileName, nName: String);
Begin
    //Create our members
    Inherited Create;
    fNode := Nil;
    fPchHead := -1;
    fPchSource := -1;
    fFolders := TStringList.Create;
    fFolders.Duplicates := dupIgnore;
    fFolders.Sorted := True;
    fFolderNodes := TObjectList.Create;
    fFolderNodes.OwnsObjects := False;
    fProfiles := TProjectProfileList.Create;
    fUnits := TUnitList.Create;
    fModified := True;

    //Initialize our version information record
    VersionInfo.Major := 0;
    VersionInfo.Minor := 1;
    VersionInfo.Release := 1;
    VersionInfo.Build := 1;
    VersionInfo.LanguageID := $0409; // US English
    VersionInfo.CharsetID := $04E4; // Windows multilingual
    VersionInfo.CompanyName := '';
    VersionInfo.FileVersion := '';
    VersionInfo.FileDescription := '';
    VersionInfo.InternalName := '';
    VersionInfo.LegalCopyright := '';
    VersionInfo.LegalTrademarks := '';
    VersionInfo.OriginalFilename := '';
    VersionInfo.ProductName := '';
    VersionInfo.ProductVersion := '';
    VersionInfo.AutoIncBuildNrOnCompile := False;
    VersionInfo.AutoIncBuildNrOnRebuild := False;

    //Then load the project
    fPlugin := '';
    fFileName := nFileName;
    finiFile := TdevINI.Create;
    Try
        finiFile.FileName := fFileName;
    Except
        fFileName := '';
        MessageDlg('Could not read project file, make sure you have the correct permissions to read it.', mtError, [mbOK], 0);
        exit;
    End;
    finiFile.Section := 'Project';
    If nName = DEV_INTERNAL_OPEN Then
        Open
    Else
    Begin
        fName := nName;
        fIniFile.Write('filename', nFileName);
        fIniFile.Write('name', nName);
        fNode := MakeProjectNode;
    End;

    If Assigned(CurrentProfile) Then
        BuildPrivateResource(True);
End;

Destructor TProject.Destroy;
Begin
    If fModified Then
        Save;
    fFolders.Free;
    fFolderNodes.Free;
    fIniFile.Free;
    fProfiles.Free;
    fUnits.Free;
    If (fNode <> Nil) And (Not fNode.Deleting) Then
        fNode.Free;
    Inherited;
End;

Function TProject.MakeProjectNode: TTreeNode;
Begin
    MakeProjectNode := MainForm.ProjectView.Items.Add(Nil, Name);
    MakeProjectNode.SelectedIndex := 0;
    MakeProjectNode.ImageIndex := 0;
    MainForm.ProjectView.FullExpand;
End;

Function TProject.MakeNewFileNode(s: String; IsFolder: Boolean;
    NewParent: TTreeNode): TTreeNode;
Begin
    MakeNewFileNode := MainForm.ProjectView.Items.AddChild(NewParent, s);

    If IsFolder Then
    Begin
        MakeNewFileNode.SelectedIndex := 4;
        MakeNewFileNode.ImageIndex := 4;
    End
    Else
    Begin
        MakeNewFileNode.SelectedIndex := 1;
        MakeNewFileNode.ImageIndex := 1;
    End;
End;

Procedure TProject.BuildPrivateResource(ForceSave: Boolean = False);
Var
    ResFile, Original: TStringList;
    Res, Def, Icon, RCDir: String;
    Comp, i: Integer;
Begin

    // GAR 10 Nov 2009
    // Hack for Wine/Linux
    // ProductName returns empty string for Wine/Linux
    // for Windows, it returns OS name (e.g. Windows Vista).
    If (MainForm.JvComputerInfoEx1.OS.ProductName = '') Then
        Exit;

    Comp := 0;
    For i := 0 To Units.Count - 1 Do
        If GetFileTyp(Units[i].FileName) = utRes Then
            If Units[i].Compile Then
                Inc(Comp);

    // if the project has a custom object directory, put the file in there
    If (CurrentProfile.ObjectOutput <> '') Then
        RCDir := IncludeTrailingPathDelimiter(
            GetRealPath(CurrentProfile.ObjectOutput, Directory))
    Else
        RCDir := Directory;

    // if project has no other resources included
    // and does not have an icon
    // and does not include the XP style manifest
    // and does not include version info
    // then do not create a private resource file
    If (Comp = 0) And (Not CurrentProfile.SupportXPThemes) And
        (Not CurrentProfile.IncludeVersionInfo) And
        (CurrentProfile.Icon = '') Then
    Begin
        CurrentProfile.PrivateResource := '';
        Exit;
    End;

    // change private resource from <project_filename>.res
    // to <project_filename>_private.res
    //
    // in many cases (like in importing a MSVC project)
    // the project's resource file has already the
    // <project_filename>.res filename.
    Res := ChangeFileExt(FileName, '_private' + RC_EXT);
    Res := StringReplace(ExtractRelativePath(FileName, Res), ' ',
        '_', [rfReplaceAll]);
    Res := SubstituteMakeParams(RCDir) + Res;

    // don't run the private resource file and header if not modified,
    // unless ForceSave is true
    If (Not ForceSave) And FileExists(Res) And
        FileExists(ChangeFileExt(Res, H_EXT)) And Not Modified Then
        Exit;

    ResFile := TStringList.Create;
    ResFile.Add('// This file is automatically generated by wxDev-C++.');
    ResFile.Add('// All changes to this file will be lost when the project is recompiled.');
    If CurrentProfile.IncludeVersionInfo Then
    Begin
        ResFile.Add('#include <windows.h>');
        ResFile.Add('');
    End;

    For i := 0 To Units.Count - 1 Do
        If GetFileTyp(Units[i].FileName) = utRes Then
            If Units[i].Compile Then
                ResFile.Add('#include "' +
                    GenMakePath(ExtractRelativePath(RCDir, Units[i].FileName),
                    False, False) + '"');

    If Length(CurrentProfile.Icon) > 0 Then
    Begin
        ResFile.Add('');
        Icon := GetRealPath(CurrentProfile.Icon, Directory);
        If FileExists(Icon) Then
        Begin
            Icon := ExtractRelativePath(FileName, Icon);
            Icon := StringReplace(Icon, '\', '/', [rfReplaceAll]);
            ResFile.Add('A ICON MOVEABLE PURE LOADONCALL DISCARDABLE "' + Icon + '"');
        End
        Else
            CurrentProfile.Icon := '';
    End;

    If CurrentProfile.SupportXPThemes Then
    Begin
        ResFile.Add('');
        //TODO: lowjoel: add additional manifest files - XML parsing?
        ResFile.Add('// Windows XP Manifest file: wxDev-C++ currently only supports having');
        ResFile.Add('// comctl32.dll version 6 as the only dependant assembly.');
        If (CurrentProfile.ExeOutput <> '') Then
            ResFile.Add('1 24 "' +
                GenMakePath(IncludeTrailingPathDelimiter(SubstituteMakeParams(
                CurrentProfile.ExeOutput)) +
                ExtractFileName(SubstituteMakeParams(Executable)) +
                '.Manifest"', False, False))
        Else
            ResFile.Add('1 24 "' + ExtractFileName(Executable) + '.Manifest"');
    End;

    If CurrentProfile.IncludeVersionInfo Then
    Begin
        ResFile.Add('');
        ResFile.Add('// This section contains the executable version information. Go to');
        ResFile.Add('// Project > Project Options to edit these values.');
        ResFile.Add('1 VERSIONINFO');
        ResFile.Add('FILEVERSION ' +
            Format('%d,%d,%d,%d', [VersionInfo.Major, VersionInfo.Minor,
            VersionInfo.Release, VersionInfo.Build]));
        ResFile.Add('PRODUCTVERSION ' +
            Format('%d,%d,%d,%d', [VersionInfo.Major, VersionInfo.Minor,
            VersionInfo.Release, VersionInfo.Build]));
        Case CurrentProfile.typ Of
            dptGUI,
            dptCon:
                ResFile.Add('FILETYPE VFT_APP');
            dptStat:
                ResFile.Add('FILETYPE VFT_STATIC_LIB');
            dptDyn:
                ResFile.Add('FILETYPE VFT_DLL');
        End;
        ResFile.Add('BEGIN');
        ResFile.Add('    BLOCK "StringFileInfo"');
        ResFile.Add('    BEGIN');
        ResFile.Add('        BLOCK "' +
            Format('%4.4x%4.4x', [VersionInfo.LanguageID, VersionInfo.CharsetID]) + '"');
        ResFile.Add('        BEGIN');
        ResFile.Add('            VALUE "CompanyName", "' +
            VersionInfo.CompanyName + '"');
        ResFile.Add('            VALUE "FileVersion", "' +
            VersionInfo.FileVersion + '"');
        ResFile.Add('            VALUE "FileDescription", "' +
            VersionInfo.FileDescription + '"');
        ResFile.Add('            VALUE "InternalName", "' +
            VersionInfo.InternalName + '"');
        ResFile.Add('            VALUE "LegalCopyright", "' +
            VersionInfo.LegalCopyright + '"');
        ResFile.Add('            VALUE "LegalTrademarks", "' +
            VersionInfo.LegalTrademarks + '"');
        ResFile.Add('            VALUE "OriginalFilename", "' +
            VersionInfo.OriginalFilename + '"');
        ResFile.Add('            VALUE "ProductName", "' +
            VersionInfo.ProductName + '"');
        ResFile.Add('            VALUE "ProductVersion", "' +
            VersionInfo.ProductVersion + '"');
        ResFile.Add('        END');
        ResFile.Add('    END');
        ResFile.Add('    BLOCK "VarFileInfo"');
        ResFile.Add('    BEGIN');
        ResFile.Add('        VALUE "Translation", ' +
            Format('0x%4.4x, %4.4d', [VersionInfo.LanguageID, VersionInfo.CharsetID]));
        ResFile.Add('    END');
        ResFile.Add('END');
    End;

    //Get the real path (after substituting in the make variables)
    If ResFile.Count > 2 Then
    Begin
        If FileExists(Res) And Not ForceSave Then
        Begin
            Original := TStringList.Create;
            Original.LoadFromFile(Res);
            If CompareStr(Original.Text, ResFile.Text) <> 0 Then
            Begin
                If devEditor.AppendNewline Then
                    If ResFile.Count > 0 Then
                        If ResFile[ResFile.Count - 1] <> '' Then
                            ResFile.Add('');
                ResFile.SaveToFile(Res);
            End;
            Original.Free;
        End
        Else
        Begin
            If devEditor.AppendNewline Then
                If ResFile.Count > 0 Then
                    If ResFile[ResFile.Count - 1] <> '' Then
                        ResFile.Add('');

            If Not DirectoryExists(SubstituteMakeParams(RCDir)) Then
                ForceDirectories(SubstituteMakeParams(RCDir));
            ResFile.SaveToFile(Res);
        End;
        CurrentProfile.PrivateResource := Res;
    End
    Else
    Begin
        If FileExists(Res) Then
            DeleteFile(Pchar(Res));
        Res := ChangeFileExt(Res, RES_EXT);
        CurrentProfile.PrivateResource := '';
    End;
    If FileExists(Res) Then
        FileSetDate(Res, DateTimeToFileDate(Now));
    // fix the "Clock skew detected" warning ;)

    // create XP manifest
    If CurrentProfile.SupportXPThemes Then
    Begin
        ResFile.Clear;
        ResFile.Add('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>');
        ResFile.Add('<assembly');
        ResFile.Add('  xmlns="urn:schemas-microsoft-com:asm.v1"');
        ResFile.Add('  manifestVersion="1.0">');
        ResFile.Add('<assemblyIdentity');
        ResFile.Add('    name="' + StringReplace(Name, ' ', '_',
            [rfReplaceAll]) + '"');
        ResFile.Add('    processorArchitecture="x86"');
        ResFile.Add('    version="1.0.0.0"');
        ResFile.Add('    type="win32"/>');
        ResFile.Add('<description>' + Name + '</description>');
        ResFile.Add('<dependency>');
        ResFile.Add('    <dependentAssembly>');
        ResFile.Add('        <assemblyIdentity');
        ResFile.Add('            type="win32"');
        ResFile.Add('            name="Microsoft.Windows.Common-Controls"');
        ResFile.Add('            version="6.0.0.0"');
        ResFile.Add('            processorArchitecture="x86"');
        ResFile.Add('            publicKeyToken="6595b64144ccf1df"');
        ResFile.Add('            language="*"');
        ResFile.Add('        />');
        ResFile.Add('    </dependentAssembly>');
        ResFile.Add('</dependency>');
        ResFile.Add('</assembly>');
        ResFile.SaveToFile(Executable + '.Manifest');
        FileSetDate(Executable + '.Manifest', DateTimeToFileDate(Now));
        // fix the "Clock skew detected" warning ;)
    End
    Else
    If FileExists(Executable + '.Manifest') Then
        DeleteFile(Pchar(Executable + '.Manifest'));

    // create private header file
    Res := ChangeFileExt(Res, H_EXT);
    ResFile.Clear;
    Def := StringReplace(ExtractFilename(UpperCase(Res)), '.',
        '_', [rfReplaceAll]);
    ResFile.Add('/*');
    ResFile.Add('  This file will be overwritten by wxDev-C++ at every compile.');
    ResFile.Add('  Do not edit this file as your changes will be lost.');
    ResFile.Add('  You can, however, include this file and use the defines.');
    ResFile.Add('*/');
    ResFile.Add('#ifndef ' + Def);
    ResFile.Add('#define ' + Def);
    ResFile.Add('');
    ResFile.Add('/* VERSION DEFINITIONS */');
    ResFile.Add('#define VER_STRING'#9 + Format('"%d.%d.%d.%d"',
        [VersionInfo.Major, VersionInfo.Minor, VersionInfo.Release,
        VersionInfo.Build]));
    ResFile.Add('#define VER_MAJOR'#9 + IntToStr(VersionInfo.Major));
    ResFile.Add('#define VER_MINOR'#9 + IntToStr(VersionInfo.Minor));
    ResFile.Add('#define VER_RELEASE'#9 + IntToStr(VersionInfo.Release));
    ResFile.Add('#define VER_BUILD'#9 + IntToStr(VersionInfo.Build));
    ResFile.Add('#define COMPANY_NAME'#9'"' + VersionInfo.CompanyName + '"');
    ResFile.Add('#define FILE_VERSION'#9'"' + VersionInfo.FileVersion + '"');
    ResFile.Add('#define FILE_DESCRIPTION'#9'"' + VersionInfo.FileDescription
        + '"');
    ResFile.Add('#define INTERNAL_NAME'#9'"' + VersionInfo.InternalName + '"');
    ResFile.Add('#define LEGAL_COPYRIGHT'#9'"' +
        VersionInfo.LegalCopyright + '"');
    ResFile.Add('#define LEGAL_TRADEMARKS'#9'"' + VersionInfo.LegalTrademarks
        + '"');
    ResFile.Add('#define ORIGINAL_FILENAME'#9'"' + VersionInfo.OriginalFilename
        + '"');
    ResFile.Add('#define PRODUCT_NAME'#9'"' + VersionInfo.ProductName + '"');
    ResFile.Add('#define PRODUCT_VERSION'#9'"' + VersionInfo.ProductVersion
        + '"');
    ResFile.Add('');
    ResFile.Add('#endif /*' + Def + '*/');
    ResFile.SaveToFile(Res);

    If FileExists(Res) Then
        FileSetDate(Res, DateTimeToFileDate(Now));
    // fix the "Clock skew detected" warning ;)

    ResFile.Free;
End;

Function TProject.NewUnit(NewProject: Boolean;
    CustomFileName: String): Integer;
Var
    s: String;
    newunit: TProjUnit;
    ParentNode, CurNode: TTreeNode;
{$IFDEF PLUGIN_BUILD}
    i: Integer;
    b: Boolean;
{$ENDIF}
Begin
    NewUnit := TProjUnit.Create(Self);
    ParentNode := Node;
    With NewUnit Do
        Try
            If Length(CustomFileName) = 0 Then
                s := Directory + Lang[ID_Untitled] + inttostr(dmMain.GetNum)
            Else
            Begin
                If ExtractFilePath(CustomFileName) = '' Then // just filename, no path
                    // make it full path filename, so that the save dialog, starts at the right directory ;)
                    s := Directory + CustomFileName
                Else
                    s := CustomFileName;
            End;
            If FileAlreadyExists(s) Then
                Repeat
                    s := Directory + Lang[ID_Untitled] + inttostr(dmMain.GetNum);
                Until Not FileAlreadyExists(s);
            Filename := s;
            New := True;
            Editor := Nil;
            CurNode := MakeNewFileNode(ExtractFileName(FileName), False, ParentNode);
            NewUnit.Node := CurNode;
            result := fUnits.Add(NewUnit);
            CurNode.Data := pointer(result);
            Dirty := True;
{$IFDEF PLUGIN_BUILD}
            b := False;
            For i := 0 To MainForm.pluginsCount - 1 Do
                b := b Or MainForm.plugins[i].isForm(FileName);
            If b Then
            Begin
                Compile := False;
                Link := False;
            End
            Else
{$ENDIF}
            Begin
                Compile := True;
    	           CompileCpp := Self.Profiles.useGPP;
                Link := True;
            End;
            Priority := 1000;
            OverrideBuildCmd := False;
            BuildCmd := '';
            SetModified(True);
        Except
            result := -1;
            NewUnit.Free;
        End;
End;

Function TProject.AddUnit(s: String; pFolder: TTreeNode;
    Rebuild: Boolean): TProjUnit;
Var
    NewUnit: TProjUnit;
    s2: String;
    TmpNode: TTreeNode;
Begin
    result := Nil;
    If s[length(s)] = '.' Then
        // correct filename if the user gives an alone dot to force the no extension
        s[length(s)] := #0;
    NewUnit := TProjUnit.Create(Self);
    With NewUnit Do
        Try
            If FileAlreadyExists(s) Then
            Begin
                If fname = '' Then
                    s2 := fFileName
                Else
                    s2 := fName;
                MessageDlg(format(Lang[ID_MSG_FILEINPROJECT], [s, s2])
                    + #13#10 + Lang[ID_SPECIFY], mtError, [mbok], 0);
                NewUnit.Free;
                Exit;
            End;
            FileName := s;
            New := False;
            Editor := Nil;
            Node := MakeNewFileNode(ExtractFileName(FileName), False, pFolder);
            Node.Data := pointer(fUnits.Add(NewUnit));
            Folder := pFolder.Text;
            TmpNode := pFolder.Parent;
            While Assigned(TmpNode) And (TmpNode <> self.fNode) Do
            Begin
                Folder := TmpNode.Text + '/' + Folder;
                TmpNode := TmpNode.Parent;
            End;

            Case GetFileTyp(s) Of
                utSrc, utHead:
                Begin
                    Compile := True;
                    CompileCpp := Self.Profiles.useGPP;
                    Link := True;
                End;
                utRes:
                Begin
                    Compile := True;
                    CompileCpp := Self.Profiles.useGPP;
                    Link := False;
                    // if a resource was added, force (re)creation of private resource...
                    BuildPrivateResource(True);
                End;
            Else
            Begin
                Compile := False;
                CompileCpp := False;
                Link := False;
            End;
            End;
            Priority := 1000;
            OverrideBuildCmd := False;
            BuildCmd := '';
            If Rebuild Then
                RebuildNodes;
            SetModified(True);
            Result := NewUnit;
        Except
            result := Nil;
            NewUnit.Free;
        End;
End;

Procedure TProject.Update;
{$IFDEF PLUGIN_BUILD}
Var
    i: Integer;
{$ENDIF}
Begin
    With finifile Do
    Begin
        Section := 'Project';
        fName := Read('name', '');
        PchHead := Read('PchHead', -1);
        PchSource := Read('PchSource', -1);
        Profiles.Ver := Read('Ver', -1);

        If Profiles.Ver > 0 Then //ver > 0 is at least a v5 project
        Begin
            // Load the project folders as well as other non-profile specifics
            fFolders.CommaText := Read('Folders', '');
            fCmdLineArgs := Read('CommandLine', '');

            //Load the version information stuff before others.
            Section := 'VersionInfo';
            VersionInfo.Major := Read('Major', 0);
            VersionInfo.Minor := Read('Minor', 1);
            VersionInfo.Release := Read('Release', 1);
            VersionInfo.Build := Read('Build', 1);
            VersionInfo.LanguageID := Read('LanguageID', $0409);
            VersionInfo.CharsetID := Read('CharsetID', $04E4);
            VersionInfo.CompanyName := Read('CompanyName', '');
            VersionInfo.FileVersion := Read('FileVersion', '0.1');
            VersionInfo.FileDescription := Read('FileDescription', '');
            VersionInfo.InternalName := Read('InternalName', '');
            VersionInfo.LegalCopyright := Read('LegalCopyright', '');
            VersionInfo.LegalTrademarks := Read('LegalTrademarks', '');
            VersionInfo.OriginalFilename :=
                Read('OriginalFilename', ExtractFilename(Executable));
            VersionInfo.ProductName := Read('ProductName', Name);
            VersionInfo.ProductVersion := Read('ProductVersion', '0.1');

            // Decide on the build number increment method
            If Profiles.Ver >= 2 Then
            Begin
                VersionInfo.AutoIncBuildNrOnRebuild :=
                    Read('AutoIncBuildNrOnRebuild', False);
                VersionInfo.AutoIncBuildNrOnCompile :=
                    Read('AutoIncBuildNrOnCompile', False);
            End
            Else
            If Profiles.Ver < 2 Then
                VersionInfo.AutoIncBuildNrOnCompile := Read('AutoIncBuildNr', False);

            // Migrate the old non-profiled format to our new format with profiles if necessary
            If Profiles.Ver < 3 Then
            Begin
                SetModified(True);
                Section := 'Project';
                fProfiles[0].typ := Read('type', 0);
                fProfiles.UseGpp := Read('IsCpp', True);

{$IFDEF PLUGIN_BUILD}
                // Replace any %DEVCPP_DIR% in files with actual devcpp directory path
                fProfiles[0].Compiler :=
                    StringReplace(Read(C_INI_LABEL, ''), '%DEVCPP_DIR%', devDirs.Exec,
                    [rfReplaceAll]);
                fProfiles[0].CppCompiler :=
                    StringReplace(Read(CPP_INI_LABEL, ''), '%DEVCPP_DIR%',
                    devDirs.Exec, [rfReplaceAll]);
                If self.AssociatedPlugin <> '' Then
                    fProfiles[0].Linker :=
                        MainForm.plugins[MainForm.unit_plugins[AssociatedPlugin]].ConvertLibsToCurrentVersion(StringReplace(Read(LINKER_INI_LABEL, ''),
                        '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]));
                //fProfiles[0].Linker := ConvertLibsToCurrentVersion(StringReplace(Read(LINKER_INI_LABEL, ''), '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]));
                fProfiles[0].PreprocDefines := Read(PREPROC_INI_LABEL, '');

                fProfiles[0].ObjFiles.DelimitedText :=
                    StringReplace(Read('ObjFiles', ''), '%DEVCPP_DIR%', devDirs.Exec,
                    [rfReplaceAll]);
                fProfiles[0].Libs.DelimitedText :=
                    StringReplace(Read('Libs', ''), '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);
                fProfiles[0].Includes.DelimitedText :=
                    StringReplace(Read('Includes', ''), '%DEVCPP_DIR%', devDirs.Exec,
                    [rfReplaceAll]);

                fProfiles[0].ResourceIncludes.DelimitedText :=
                    StringReplace(Read('ResourceIncludes', ''), '%DEVCPP_DIR%',
                    devDirs.Exec, [rfReplaceAll]);
                fProfiles[0].MakeIncludes.DelimitedText :=
                    StringReplace(Read('MakeIncludes', ''), '%DEVCPP_DIR%',
                    devDirs.Exec, [rfReplaceAll]);
{$ELSE}
        fProfiles[0].Compiler := Read('Compiler', '');
        fProfiles[0].CppCompiler := Read('CppCompiler', '');
        for i := 0 to MainForm.pluginsCount - 1 do
            fProfiles[0].Linker := MainForm.plugins[i].ConvertLibsToCurrentVersion((Read('Linker', ''));   // EAB TODO: This is even worst. Outside of the conditional, yet calls a function that was originally in wxUtils.pas. Should be fixed.
            // fProfiles[0].Linker := ConvertLibsToCurrentVersion((Read('Linker', ''));
        fProfiles[0].ObjFiles.DelimitedText := Read('ObjFiles', '');
        fProfiles[0].Libs.DelimitedText := Read('Libs', '');
        fProfiles[0].Includes.DelimitedText := Read('Includes', '');

        fProfiles[0].ResourceIncludes.DelimitedText := Read('ResourceIncludes', '');
        fProfiles[0].MakeIncludes.DelimitedText := Read('MakeIncludes', '');
        fProfiles[0].ImagesOutput := Read('ImagesOutput', fProfiles[0].ProfileName);

{$ENDIF}
                fProfiles[0].ExeOutput := Read('ExeOutput', fProfiles[0].ProfileName);
                fProfiles[0].ObjectOutput :=
                    Read('ObjectOutput', fProfiles[0].ProfileName);
                If (trim(fProfiles[0].ExeOutput) = '') And
                    (trim(fProfiles[0].ObjectOutput) <> '') Then
                    fProfiles[0].ExeOutput := fProfiles[0].ObjectOutput
                Else
                If (trim(fProfiles[0].ExeOutput) <> '') And
                    (trim(fProfiles[0].ObjectOutput) = '') Then
                    fProfiles[0].ObjectOutput := fProfiles[0].ExeOutput
                Else
                If ((fProfiles[0].ExeOutput = '') And (fProfiles[0].ObjectOutput = '')) Then
                Begin
                    fProfiles[0].ObjectOutput := fProfiles[0].ProfileName;
                    fProfiles[0].ExeOutput := fProfiles[0].ProfileName;
                End;

                fProfiles[0].OverrideOutput := Read('OverrideOutput', False);
                fProfiles[0].OverridenOutput := Read('OverrideOutputName', '');
                fProfiles[0].HostApplication := Read('HostApplication', '');

                fProfiles[0].UseCustomMakefile := Read('UseCustomMakefile', False);
                fProfiles[0].CustomMakefile := Read('CustomMakefile', '');

                fProfiles[0].IncludeVersionInfo := Read('IncludeVersionInfo', False);
                fProfiles[0].SupportXPThemes := Read('SupportXPThemes', False);
                fProfiles[0].CompilerSet :=
                    Read('CompilerSet', devCompiler.CompilerSet);
                fProfiles[0].CompilerOptions :=
                    Read(COMPILER_INI_LABEL, devCompiler.OptionStr);

                devCompiler.OptionStr := devCompiler.OptionStr;
                If fProfiles[0].CompilerSet > devCompilerSet.Sets.Count - 1 Then
                Begin
                    fProfiles[0].CompilerSet := devCompiler.CompilerSet;
                    MessageDlg('The compiler set you have selected for this project, no longer '
                        +
                        'exists.'#10'It will be substituted by the global compiler set...',
                        mtError, [mbOk], 0);
                End;
            End;
        End
        Else
        If (Profiles.Ver = -1) Then
        Begin // dev-c < 4
            SetModified(True);
            If Not Read('NoConsole', True) Then
                fProfiles[0].typ := dptCon
            Else
      	     If Read('IsDLL', False) Then
                fProfiles[0].Typ := dptDyn
            Else
                fProfiles[0].typ := dptGUI;

            fProfiles[0].ResourceIncludes.DelimitedText :=
                Read('ResourceIncludes', '');
            fProfiles[0].ObjFiles.Add(read('ObjFiles', ''));
            fProfiles[0].Includes.Add(Read('IncludeDirs', ''));
            fProfiles[0].Compiler := Read('CompilerOptions', '');
            fProfiles.usegpp := Read('Use_GPP', False);
            fProfiles[0].ExeOutput := Read('ExeOutput', fProfiles[0].ProfileName);
            fProfiles[0].ObjectOutput :=
                Read('ObjectOutput', fProfiles[0].ProfileName);
            fProfiles[0].ImagesOutput :=
                Read('ImagesOutput', fProfiles[0].ProfileName);

            If (trim(fProfiles[0].ExeOutput) = '') And
                (trim(fProfiles[0].ObjectOutput) <> '') Then
                fProfiles[0].ExeOutput := fProfiles[0].ObjectOutput
            Else
            If (trim(fProfiles[0].ExeOutput) <> '') And
                (trim(fProfiles[0].ObjectOutput) = '') Then
                fProfiles[0].ObjectOutput := fProfiles[0].ExeOutput;

            fProfiles[0].OverrideOutput := Read('OverrideOutput', False);
            fProfiles[0].OverridenOutput := Read('OverrideOutputName', '');
            fProfiles[0].HostApplication := Read('HostApplication', '');
        End;
    End;
End;

Procedure TProject.UpdateFile;
Var
    i: Integer;
Begin
    With finifile Do
    Begin
        Section := 'Project';
        Write('FileName', ExtractRelativePath(Directory, fFileName));
        Write('PchHead', PchHead);
        Write('PchSource', PchSource);
        Write('Name', fName);
        Write('Ver', 3);
        Write('IsCpp', fProfiles.UseGpp);
        Write('ProfilesCount', fProfiles.Count);
        Write('ProfileIndex', CurrentProfileIndex);
        Write('Folders', fFolders.CommaText);
        //Save the Version Info
        Section := 'VersionInfo';
        Write('Major', VersionInfo.Major);
        Write('Minor', VersionInfo.Minor);
        Write('Release', VersionInfo.Release);
        Write('Build', VersionInfo.Build);
        Write('LanguageID', VersionInfo.LanguageID);
        Write('CharsetID', VersionInfo.CharsetID);
        Write('CompanyName', VersionInfo.CompanyName);
        Write('FileVersion', VersionInfo.FileVersion);
        Write('FileDescription', VersionInfo.FileDescription);
        Write('InternalName', VersionInfo.InternalName);
        Write('LegalCopyright', VersionInfo.LegalCopyright);
        Write('LegalTrademarks', VersionInfo.LegalTrademarks);
        Write('OriginalFilename', VersionInfo.OriginalFilename);
        Write('ProductName', VersionInfo.ProductName);
        Write('ProductVersion', VersionInfo.ProductVersion);
        Write('AutoIncBuildNrOnRebuild', VersionInfo.AutoIncBuildNrOnRebuild);
        Write('AutoIncBuildNrOnCompile', VersionInfo.AutoIncBuildNrOnCompile);

        For i := 0 To fProfiles.Count - 1 Do
        Begin
            WriteProfile(i, 'ProfileName', fProfiles[i].ProfileName);
            WriteProfile(i, 'Type', fProfiles[i].typ);
            WriteProfile(i, 'ObjFiles', fProfiles[i].ObjFiles.DelimitedText);
            WriteProfile(i, 'Includes', fProfiles[i].Includes.DelimitedText);
            WriteProfile(i, 'Libs', fProfiles[i].Libs.DelimitedText);
            WriteProfile(i, 'ResourceIncludes',
                fProfiles[i].ResourceIncludes.DelimitedText);
            WriteProfile(i, 'MakeIncludes', fProfiles[i].MakeIncludes.DelimitedText);

            WriteProfile(i, C_INI_LABEL, fProfiles[i].Compiler);
            WriteProfile(i, CPP_INI_LABEL, fProfiles[i].CppCompiler);
            WriteProfile(i, LINKER_INI_LABEL, fProfiles[i].Linker);
            WriteProfile(i, PREPROC_INI_LABEL, fProfiles[i].PreProcDefines);
            WriteProfile(i, COMPILER_INI_LABEL, fProfiles[i].CompilerOptions);

            WriteProfile(i, 'Icon', ExtractRelativePath(Directory,
                fProfiles[i].Icon));
            WriteProfile(i, 'ExeOutput', fProfiles[i].ExeOutput);
            WriteProfile(i, 'ImagesOutput', fProfiles[i].ImagesOutput);
            WriteProfile(i, 'ObjectOutput', fProfiles[i].ObjectOutput);
            WriteProfile(i, 'OverrideOutput', fProfiles[i].OverrideOutput);
            WriteProfile(i, 'OverrideOutputName', fProfiles[i].OverridenOutput);
            WriteProfile(i, 'HostApplication', fProfiles[i].HostApplication);

            WriteProfile(i, 'CommandLine', fCmdLineArgs);

            WriteProfile(i, 'UseCustomMakefile', fProfiles[i].UseCustomMakefile);
            WriteProfile(i, 'CustomMakefile', fProfiles[i].CustomMakefile);

            WriteProfile(i, 'IncludeVersionInfo', fProfiles[i].IncludeVersionInfo);
            WriteProfile(i, 'SupportXPThemes', fProfiles[i].SupportXPThemes);
            WriteProfile(i, 'CompilerSet', fProfiles[i].CompilerSet);
            WriteProfile(i, 'CompilerType', fProfiles[i].CompilerType);
        End;
        If fPrevVersion <= 2 Then
        Begin
            Section := 'Project';
            //delete outdated dev4 project options
            DeleteKey('NoConsole');
            DeleteKey('IsDLL');
            DeleteKey('ResFiles');
            DeleteKey('IncludeDirs');
            DeleteKey('CompilerOptions');
            DeleteKey('Use_GPP');
            //delete outdated dev5 ver 1 and 2 keys project options
            DeleteKey('ObjFiles');
            DeleteKey('Includes');
            DeleteKey('Libs');
            DeleteKey('PrivateResource');
            DeleteKey('ResourceIncludes');
            DeleteKey('MakeIncludes');
            DeleteKey('Compiler');
            DeleteKey('CppCompiler');
            DeleteKey('Linker');
            DeleteKey('PreprocDefines');
            DeleteKey('Icon');
            DeleteKey('UseCustomMakefile');
            DeleteKey('CustomMakefile');
            DeleteKey('IncludeVersionInfo');
            DeleteKey('SupportXPThemes');
            DeleteKey('CompilerSet');
            DeleteKey('ExeOutput');
            DeleteKey('ObjectOutput');
            DeleteKey('OverrideOutput');
            DeleteKey('OverrideOutputName');
            DeleteKey('HostApplication');

            DeleteKey('VC2010_Compiler');
            DeleteKey('VC2010_CppCompiler');
            DeleteKey('VC2010_Linker');
            DeleteKey('VC2010_PreprocDefines');
            DeleteKey('VC2008_Compiler');
            DeleteKey('VC2008_CppCompiler');
            DeleteKey('VC2008_Linker');
            DeleteKey('VC2008_PreprocDefines');
            DeleteKey('VC2005_Compiler');
            DeleteKey('VC2005_CppCompiler');
            DeleteKey('VC2005_Linker');
            DeleteKey('VC2005_PreprocDefines');
            DeleteKey('VC2003_Compiler');
            DeleteKey('VC2003_CppCompiler');
            DeleteKey('VC2003_Linker');
            DeleteKey('VC2003_PreprocDefines');
            DeleteKey('VC6_Compiler');
            DeleteKey('VC6_CppCompiler');
            DeleteKey('VC6_Linker');
            DeleteKey('VC6_PreprocDefines');
            DeleteKey('DMARS_Compiler');
            DeleteKey('DMARS_CppCompiler');
            DeleteKey('DMARS_Linker');
            DeleteKey('DMARS_PreprocDefines');
            DeleteKey('BORLAND_Compiler');
            DeleteKey('BORLAND_CppCompiler');
            DeleteKey('BORLAND_Linker');
            DeleteKey('BORLAND_PreprocDefines');
            DeleteKey('WATCOM_Compiler');
            DeleteKey('WATCOM_CppCompiler');
            DeleteKey('WATCOM_Linker');
            DeleteKey('WATCOM_PreprocDefines');
            DeleteKey('VC2008_CompilerSettings');
            DeleteKey('VC2005_CompilerSettings');
            DeleteKey('VC2003_CompilerSettings');
            DeleteKey('VC6_CompilerSettings');
            DeleteKey('DMARS_CompilerSettings');
            DeleteKey('BORLAND_CompilerSettings');
            DeleteKey('WATCOM_CompilerSettings');

            Section := 'VersionInfo';
            DeleteKey('AutoIncBuildNr');
        End;
    End;
End;

Function TProject.UpdateUnits: Boolean;
Var
    Count: Integer;
    idx: Integer;
    rd_only: Boolean;
Begin
    Result := False;
    Count := 0;
    idx := 0;
    rd_only := False;
    While idx <= pred(fUnits.Count) Do
    Begin
{$WARN SYMBOL_PLATFORM OFF}
        If fUnits[idx].Dirty And FileExists(fUnits[idx].FileName) And
            (FileGetAttr(fUnits[idx].FileName) And faReadOnly <> 0) Then
        Begin
            // file is read-only
            If MessageDlg(Format(Lang[ID_MSG_FILEISREADONLY], [fUnits[idx].FileName]),
                mtConfirmation, [mbYes, mbNo], 0) = mrNo Then
                rd_only := False
            Else
            If FileSetAttr(fUnits[idx].FileName, FileGetAttr(fUnits[idx].FileName) -
                faReadOnly) <> 0 Then
            Begin
                MessageDlg(Format(Lang[ID_MSG_FILEREADONLYERROR],
                    [fUnits[idx].FileName]), mtError, [mbOk], 0);
                rd_only := False;
            End;
        End;
{$WARN SYMBOL_PLATFORM ON}

        If (Not rd_only) And (fUnits[idx] <> Nil) And (Not fUnits[idx].Save) And
            fUnits[idx].New Then
            Exit;

        // saved new file or an existing file add to project file
        If (fUnits[idx].New And Not fUnits[idx].Dirty) Or Not fUnits[idx].New Then
        Begin
            finifile.WriteUnit(Count, ExtractRelativePath(
                Directory, fUnits[idx].FileName));
            inc(Count);
        End;
        Case GetFileTyp(fUnits[idx].FileName) Of
            utHead,
            utSrc:
                finifile.WriteUnit(idx, 'CompileCpp', fUnits[idx].CompileCpp);
            utRes:
                If fUnits[idx].Folder = '' Then
                    fUnits[idx].Folder := 'Resources';
        End;

        finifile.WriteUnit(idx, 'Folder', fUnits[idx].Folder);
        finifile.WriteUnit(idx, 'Compile', fUnits[idx].Compile);
        finifile.WriteUnit(idx, 'Link', fUnits[idx].Link);
        finifile.WriteUnit(idx, 'Priority', fUnits[idx].Priority);
        finifile.WriteUnit(idx, 'OverrideBuildCmd', fUnits[idx].OverrideBuildCmd);
        finifile.WriteUnit(idx, 'BuildCmd', fUnits[idx].BuildCmd);
        inc(idx);
    End;
    finifile.Write('UnitCount', Count);
    Result := True;
End;

Function TProject.FolderNodeFromName(name: String): TTreeNode;
Var
    i: Integer;
Begin
    FolderNodeFromName := fNode;
    If name <> '' Then
        For i := 0 To pred(fFolders.Count) Do
        Begin
            If AnsiCompareText(AnsiDequotedStr(fFolders[i], '"'),
                AnsiDequotedStr(name, '"')) = 0 Then
            Begin
                FolderNodeFromName := TTreeNode(fFolderNodes[i]);
                break;
            End;
        End;
End;

Procedure TProject.CreateFolderNodes;
Var idx: Integer;
  	 findnode, node: TTreeNode;
  	 s: String;
  	 I, C: Integer;
Begin
    fFolderNodes.Clear;
    For idx := 0 To pred(fFolders.Count) Do
    Begin
        node := fNode;
        S := fFolders[idx];
        I := Pos('/', S);
        While I > 0 Do
        Begin
            findnode := Nil;
            For C := 0 To Node.Count - 1 Do
                If node.Item[C].Text = Copy(S, 1, I - 1) Then
                Begin
                    findnode := node.Item[C];
                    Break;
                End;
            If Not Assigned(findnode) Then
                node := MakeNewFileNode(Copy(S, 1, I - 1), True, node)
            Else
                node := findnode;
            node.Data := Pointer(-1);
            Delete(S, 1, I);
            I := Pos('/', S);
        End;
        node := MakeNewFileNode(S, True, Node);
        node.Data := Pointer(-1);
        fFolderNodes.Add(node);
    End;
End;

Procedure TProject.UpdateNodeIndexes;
Var idx: Integer;
Begin
    For idx := 0 To pred(fUnits.Count) Do
        fUnits[idx].Node.Data := pointer(idx);
End;

// open is used to determine if layout info is present in the file.
// if it is present the users AutoOpen settings are ignored,
// perhaps we should make it another option?
Procedure TProject.Open;
Var
    ucount, i: Integer;
    NewUnit: TProjUnit;
Begin
{$WARN SYMBOL_PLATFORM OFF}
    If FileExists(FileName) And (FileGetAttr(FileName) And faReadOnly <> 0) Then
    Begin
        // file is read-only
        If MessageDlg(Format(Lang[ID_MSG_FILEISREADONLY], [FileName]),
            mtConfirmation, [mbYes, mbNo], 0) = mrYes Then
            If FileSetAttr(FileName, FileGetAttr(FileName) - faReadOnly) <> 0 Then
            Begin
                MessageDlg(Format(Lang[ID_MSG_FILEREADONLYERROR], [FileName]),
                    mtError, [mbOk], 0);
            End;
    End;
{$WARN SYMBOL_PLATFORM ON}

    //First Load the Profile before doing anything
    LoadProfiles;
    Update;
    fNode := MakeProjectNode;

    CheckProjectFileForUpdate;
    finifile.Section := 'Project';
    uCount := fIniFile.Read('UnitCount', 0);
    CreateFolderNodes;
    For i := 0 To pred(uCount) Do
    Begin
        NewUnit := TProjUnit.Create(Self);
        With NewUnit Do
        Begin
            FileName := ExpandFileto(finifile.ReadUnit(i), Directory);
            If Not FileExists(FileName) Then
            Begin
                Application.MessageBox(Pchar(Format(Lang[ID_ERR_FILENOTFOUND],
                    [FileName])), 'Error', MB_ICONHAND);
                SetModified(True);
                Continue;
            End;
            Folder := finifile.ReadUnit(i, 'Folder', '');

            Compile := finifile.ReadUnit(i, 'Compile', True);
            If finifile.ReadUnit(i, 'CompileCpp', 2) = 2 Then
                // check if feature not present in this file
                CompileCpp := Self.fProfiles.useGPP
            Else
                CompileCpp := finifile.ReadUnit(i, 'CompileCpp', False);
            Link := finifile.ReadUnit(i, 'Link', True);
            Priority := finifile.ReadUnit(i, 'Priority', 1000);
            OverrideBuildCmd := finifile.ReadUnit(i, 'OverrideBuildCmd', False);
            BuildCmd := finifile.ReadUnit(i, 'BuildCmd', '');

            Editor := Nil;
            New := False;
            fParent := self;

            Node := MakeNewFileNode(ExtractFileName(FileName), False,
                FolderNodeFromName(Folder));
            Node.Data := pointer(fUnits.Add(NewUnit));

        End;
    End;

    Case devData.AutoOpen Of
        0: // Open All
            For i := 0 To pred(fUnits.Count) Do
                OpenUnit(i).Activate;
        1: // Open First
            OpenUnit(0).Activate;
    Else
        LoadLayout;
    End;
    RebuildNodes;
    If CurrentProfile.CompilerSet < devCompilerSet.Sets.Count Then
        devCompilerSet.LoadSet(CurrentProfile.CompilerSet);
    devCompilerSet.AssignToCompiler;

    //Since we just loaded everything we are 'clean'
    SetModified(False);
End;

Procedure TProject.LoadProfiles;
Var
    i, profileCount, resetCompilers, AutoSelectMissingCompiler: Integer;
    NewProfile: TProjProfile;
    CompilerType: String;
Begin
    ResetCompilers := 0;
    finifile.Section := 'Project';
    profilecount := finifile.Read('ProfilesCount', 0);
    fProfiles.useGPP := finifile.Read('useGPP', True);
    CurrentProfileIndex := finifile.Read('ProfileIndex', 0);
    fPrevVersion := finifile.Read('Ver', -1);
    AutoSelectMissingCompiler := 0;
    If (CurrentProfileIndex > profileCount - 1) Or (CurrentProfileIndex < 0) Then
        CurrentProfileIndex := 0;

    If profileCount <= 0 Then
    Begin
        CurrentProfileIndex := 0;
        Profiles.Ver := fPrevVersion;
        NewProfile := TProjProfile.Create;
        NewProfile.ProfileName := 'Default Profile';
        NewProfile.ExeOutput := NewProfile.ProfileName;
        NewProfile.ObjectOutput := NewProfile.ProfileName;
        fProfiles.Add(NewProfile);
        Exit;
    End;

    For i := 0 To pred(profileCount) Do
    Begin
        NewProfile := TProjProfile.Create;
        NewProfile.ProfileName := finifile.ReadProfile(i, 'ProfileName', '');
        NewProfile.typ := finifile.ReadProfile(i, 'Type', 0);
        NewProfile.CompilerType :=
            finifile.ReadProfile(i, 'CompilerType', ID_COMPILER_MINGW);
        NewProfile.CompilerSet :=
            finifile.ReadProfile(i, 'CompilerSet', ID_COMPILER_MINGW);
        NewProfile.Compiler := finifile.ReadProfile(i, 'Compiler', '');
        NewProfile.CppCompiler := finifile.ReadProfile(i, 'CppCompiler', '');
        NewProfile.Linker := finifile.ReadProfile(i, 'Linker', '');
        NewProfile.CompilerOptions :=
            finifile.ReadProfile(i, COMPILER_INI_LABEL, '');
        NewProfile.PreprocDefines := finifile.ReadProfile(i, 'PreprocDefines', '');
        NewProfile.ObjFiles.DelimitedText := finifile.ReadProfile(i, 'ObjFiles', '');
        NewProfile.Includes.DelimitedText := finifile.ReadProfile(i, 'Includes', '');
        NewProfile.Libs.DelimitedText := finifile.ReadProfile(i, 'Libs', '');
        NewProfile.ResourceIncludes.DelimitedText :=
            finifile.ReadProfile(i, 'ResourceIncludes', '');
        NewProfile.MakeIncludes.DelimitedText :=
            finifile.ReadProfile(i, 'MakeIncludes', '');
        NewProfile.Icon := finifile.ReadProfile(i, 'Icon', '');
        NewProfile.ExeOutput := finifile.ReadProfile(i, 'ExeOutput', '');
        NewProfile.ObjectOutput := finifile.ReadProfile(i, 'ObjectOutput', '');
        NewProfile.ImagesOutput := finifile.ReadProfile(i, 'ImagesOutput', 'Images\');
        NewProfile.OverrideOutput :=
            finifile.ReadProfile(i, 'OverrideOutput', False);
        NewProfile.OverridenOutput :=
            finifile.ReadProfile(i, 'OverrideOutputName', '');
        NewProfile.HostApplication := finifile.ReadProfile(i, 'HostApplication', '');
        NewProfile.IncludeVersionInfo :=
            finifile.ReadProfile(i, 'IncludeVersionInfo', False);
        NewProfile.SupportXPThemes :=
            finifile.ReadProfile(i, 'SupportXPThemes', False);
        NewProfile.UseCustomMakefile :=
            finifile.ReadProfile(i, 'UseCustomMakefile', False);
        // EAB: we weren't loading this setting.
        NewProfile.CustomMakefile := finifile.ReadProfile(i, 'CustomMakefile', '');
        // EAB: we weren't loading this setting.
        If (NewProfile.CompilerSet > devCompilerSet.Sets.Count - 1) Or
            (NewProfile.CompilerSet = -1) Then
        Begin
            Case NewProfile.compilerType Of
                ID_COMPILER_MINGW:
                    CompilerType := 'MingW';
                ID_COMPILER_VC2010:
                    CompilerType := 'Visual C++ 2010';
                ID_COMPILER_VC2008:
                    CompilerType := 'Visual C++ 2008';
                ID_COMPILER_VC2005:
                    CompilerType := 'Visual C++ 2005';
                ID_COMPILER_VC2003:
                    CompilerType := 'Visual C++ 2003';
                ID_COMPILER_VC6:
                    CompilerType := 'Visual C++ 6';
                ID_COMPILER_DMARS:
                    CompilerType := 'MingW';
                ID_COMPILER_BORLAND:
                    CompilerType := 'MingW';
                ID_COMPILER_WATCOM:
                    CompilerType := 'MingW';
                ID_COMPILER_LINUX:
                    CompilerType := 'Linux gcc';
            End;

            Case AutoSelectMissingCompiler Of
                mrYesToAll:
                    NewProfile.CompilerSet :=
                        GetClosestMatchingCompilerSet(NewProfile.compilerType);
                mrNoToAll: ;
            Else
            Begin
                AutoSelectMissingCompiler :=
                    MessageDlg('The compiler specified in the profile ' + NewProfile.ProfileName +
                    ' does not exist on the local computer.'#10#13#10#13 +
                    'Do you want wxDev-C++ to attempt to find a suitable compiler to ' +
                    'use for this profile?',
                    mtConfirmation, [mbYes, mbNo, mbNoToAll, mbYesToAll],
                    Application.Handle);
                Case AutoSelectMissingCompiler Of
                    mrYes, mrYesToAll:
                        NewProfile.CompilerSet :=
                            GetClosestMatchingCompilerSet(NewProfile.compilerType);
                End;
            End;
            End;

            Inc(ResetCompilers);
        End;
        fProfiles.Add(NewProfile);
    End;
End;

Procedure TProject.LoadLayout;
Var
    layIni: TIniFile;
    top: Integer;
    sl: TStringList;
    idx, currIdx: Integer;
Begin
    sl := TStringList.Create;
    Try
        layIni := TIniFile.Create(ChangeFileExt(Filename, '.layout'));
        Try
            top := layIni.ReadInteger('Editors', 'Focused', -1);
            // read order of open files and open them accordingly
            sl.CommaText := layIni.ReadString('Editors', 'Order', '');
        Finally
            layIni.Free;
        End;

        For idx := 0 To sl.Count - 1 Do
        Begin
            currIdx := StrToIntDef(sl[idx], -1);
            LoadUnitLayout(OpenUnit(currIdx), currIdx);
        End;
    Finally
        sl.Free;
    End;

    If (Top > -1) And (fUnits.Count > 0) And (top < fUnits.Count) And
        Assigned(fUnits[top].Editor) Then
        fUnits[top].Editor.Activate;
End;

Procedure TProject.LoadUnitLayout(e: TEditor; Index: Integer);
Var
    layIni: TIniFile;
Begin
    layIni := TIniFile.Create(ChangeFileExt(Filename, '.layout'));
    Try
        If Assigned(e) Then
        Begin
            e.Text.CaretY := layIni.ReadInteger('Editor_' + IntToStr(Index),
                'CursorRow', 1);
            e.Text.CaretX := layIni.ReadInteger('Editor_' + IntToStr(Index),
                'CursorCol', 1);
            e.Text.TopLine := layIni.ReadInteger('Editor_' +
                IntToStr(Index), 'TopLine', 1);
            e.Text.LeftChar := layIni.ReadInteger('Editor_' +
                IntToStr(Index), 'LeftChar', 1);
        End;
    Finally
        layIni.Free;
    End;
End;

Procedure TProject.SaveLayout;
Var
    layIni: TIniFile;
    idx: Integer;
    aset: Boolean;
    sl: TStringList;
    S, S2: String;
    e: TEditor;
Begin
    s := ChangeFileExt(Filename, '.layout');
    //  SetCurrentDir(ExtractFilePath(Filename));   // EAB: FileIsReadOnly depends on current dir.

    If FileExists(s) And (FileGetAttr(s) And faReadOnly <> 0) Then
        exit;
    layIni := TIniFile.Create(s);
    Try
        //  finifile.Section:= 'Views';
        //  finifile.Write('ProjectView', devData.ProjectView);
        finifile.Section := 'Project';

        sl := TStringList.Create;
        Try
            // write order of open files
            sl.Clear;
            For idx := 0 To MainForm.PageControl.PageCount - 1 Do
            Begin
                S := MainForm.PageControl.Pages[idx].Caption;
                e := MainForm.GetEditor(idx);
                S2 := e.FileName;
                If (Length(S) > 4) And
                    (Copy(S, 1, 4) = '[*] ') Then
                    // the file is modified and the tabsheet's caption starts with '[*] ' - delete it
                    S := Copy(S, 5, Length(S) - 4);
                If sl.IndexOf(IntToStr(fUnits.Indexof(S2))) = -1 Then
                    sl.Add(IntToStr(fUnits.Indexof(S2)));
                If MainForm.PageControl.ActivePageIndex = idx Then
                    layIni.WriteInteger('Editors', 'Focused', fUnits.Indexof(S2));
            End;
            layIni.WriteString('Editors', 'Order', sl.CommaText);
        Finally
            sl.Free;
        End;

        // save editor info
        For idx := 0 To pred(fUnits.Count) Do
        Begin
            Try
                With fUnits[idx] Do
                Begin
                    // save info on open state
                    aset := Assigned(fUnits[idx].editor);
                    layIni.WriteBool('Editor_' + IntToStr(idx), 'Open', aset);
                    layIni.WriteBool('Editor_' + IntToStr(idx), 'Top', aset And
                        (fUnits[idx].Editor.TabSheet =
                        fUnits[idx].Editor.TabSheet.PageControl.ActivePage));
                    If aset Then
                    Begin
                        layIni.WriteInteger('Editor_' + IntToStr(idx),
                            'CursorCol', fUnits[idx].Editor.Text.CaretX);
                        layIni.WriteInteger('Editor_' + IntToStr(idx),
                            'CursorRow', fUnits[idx].Editor.Text.CaretY);
                        layIni.WriteInteger('Editor_' + IntToStr(idx), 'TopLine',
                            fUnits[idx].Editor.Text.TopLine);
                        layIni.WriteInteger('Editor_' + IntToStr(idx), 'LeftChar',
                            fUnits[idx].Editor.Text.LeftChar);
                    End;

                    // remove old data from project file
                    fIniFile.Section := 'Unit' + IntToStr(idx + 1);
                    fIniFile.DeleteKey('Open');
                    fIniFile.DeleteKey('Top');
                    fIniFile.DeleteKey('CursorCol');
                    fIniFile.DeleteKey('CursorRow');
                    fIniFile.DeleteKey('TopLine');
                    fIniFile.DeleteKey('LeftChar');
                End;
            Except
            End;
        End;
    Finally
        layIni.Free;
    End;
    fIniFile.Section := 'Project';
End;

// EAB: It looks like this function is doing redundant work after SaveLayout call.. however I won't touch it to prevent unexpected problems.
Procedure TProject.SaveUnitLayout(e: TEditor; Index: Integer);
Var
    layIni: TIniFile;
    filepath: String;
Begin
{$WARN SYMBOL_PLATFORM OFF}
    //Get the path of the layout file
    filepath := ChangeFileExt(Filename, '.layout');

    //Is the file read-only?
    If FileExists(filepath) And (FileGetAttr(filepath) And faReadOnly <> 0) Then
    Begin
        // file is read-only
        If MessageDlg(Format(Lang[ID_MSG_FILEISREADONLY], [filepath]),
            mtConfirmation, [mbYes, mbNo], 0) = mrNo Then
            Exit;
        If FileSetAttr(filepath, FileGetAttr(filepath) - faReadOnly) <> 0 Then
        Begin
            MessageDlg(Format(Lang[ID_MSG_FILEREADONLYERROR], [filepath]),
                mtError, [mbOk], 0);
            //NinjaNL Exit;
        End;
    End;

    layIni := TIniFile.Create(filepath);
    Try
        If Assigned(e) Then
        Begin
            layIni.WriteInteger('Editor_' + IntToStr(Index), 'CursorCol',
                e.Text.CaretX);
            layIni.WriteInteger('Editor_' + IntToStr(Index), 'CursorRow',
                e.Text.CaretY);
            layIni.WriteInteger('Editor_' + IntToStr(Index), 'TopLine',
                e.Text.TopLine);
            layIni.WriteInteger('Editor_' + IntToStr(Index),
                'LeftChar', e.Text.LeftChar);
        End;
    Finally
        layIni.Free;
    End;
End;

Procedure TProject.Save;
Begin
    If Not UpdateUnits Then
        Exit;
    UpdateFile; // so data is current before going to disk
    SaveLayout; // save current opened files, and which is "active".
    If fModified Then
        finiFile.UpdateFile;
    SetModified(False);
End;

Function TProject.Remove(index: Integer; DoClose: Boolean): Boolean;
Var
    i: Integer;
Begin
    result := False;
    If index > -1 Then
    Begin
        // if a resource was removed, force (re)creation of private resource...
        If GetFileTyp(fUnits.GetItem(index).FileName) = utRes Then
            BuildPrivateResource(True);
        If DoClose And Assigned(fUnits.GetItem(index).fEditor) Then
        Begin
            If Not MainForm.CloseEditor(
                fUnits.GetItem(index).fEditor.TabSheet.PageIndex, False) Then
                exit;
        End;
        result := True;
        { this causes problems if the project isn't saved after this, since the erase happens phisically at this moment }
        //if not fUnits.GetItem(index).fNew then
        finifile.EraseUnit(index);

        fUnits.GetItem(index).fNode.Delete;
        fUnits.Remove(index);

        UpdateNodeIndexes();
        SetModified(True);

        //is this the PCH file?
        If index = PchHead Then
            PchHead := -1
        Else
        If index = PchSource Then
            PchSource := -1
        Else
        Begin
            //The header or source file unit may have moved
            If (PchHead <> -1) And (PchHead > index) Then
                PchHead := PchHead - 1;
            If (PchSource <> -1) And (PchSource > index) Then
                PchSource := PchSource - 1;
        End;
    End
    Else // pick from list
        With TRemoveUnitForm.Create(MainForm) Do
            Try
                For i := 0 To pred(fUnits.Count) Do
                    UnitList.Items.Append(fUnits[i].FileName);
                If (ShowModal = mrOk) And (UnitList.ItemIndex <> -1) Then
                    Remove(UnitList.ItemIndex, True);
            Finally
                Free;
            End;
End;

Function TProject.FileAlreadyExists(s: String): Boolean;
Begin
    result := True;
    If fUnits.Indexof(s) > -1 Then
        exit;
    result := False;
End;

Function TProject.OpenUnit(index: Integer): TEditor;
Begin
    result := Nil;
    If (index < 0) Or (index > pred(fUnits.Count)) Then
        exit;

    With fUnits[index] Do
    Begin
        fEditor := TEditor.Create;
        If FileName <> '' Then
            Try
                chdir(Directory);
                fEditor.Init(True, ExtractFileName(FileName),
                    ExpandFileName(FileName), Not New);
                If New Then
      	             If devEditor.DefaulttoPrj Then
                        fEditor.InsertDefaultText;
                LoadUnitLayout(fEditor, index);
                result := fEditor;
            Except
                on E: Exception Do
                Begin
                    MessageDlg(format(Lang[ID_ERR_OPENFILE] + #13 +
                        'Reason: %s', [Filename, E.Message]), mtError, [mbOK], 0);
                    fEditor.Close;
                    fEditor := Nil; //because closing the editor will destroy it
                End;
                Else
                Begin
                    MessageDlg(format(Lang[ID_ERR_OPENFILE], [Filename]),
                        mtError, [mbOK], 0);
                    fEditor.Close;
                    fEditor := Nil; //because closing the editor will destroy it
                End;
            End
        Else
        Begin
            fEditor.Close;
            fEditor := Nil; //because closing the editor will destroy it
        End;
    End;
End;

Procedure TProject.CloseUnit(index: Integer);
Begin
    If (index < 0) Or (index > pred(fUnits.Count)) Then
        exit;
    With fUnits[index] Do
    Begin
        If assigned(fEditor) Then
        Begin
            SaveUnitLayout(fEditor, index);
            fEditor.Close;
            fEditor := Nil; //because closing the editor will destroy it
        End;
    End;
End;

Procedure TProject.SaveUnitAs(i: Integer; sFileName: String);
Begin
    If (i < 0) Or (i > pred(fUnits.Count)) Then
        exit;

    With fUnits[i] Do
    Begin
        If FileExists(FileName) Then
            New := False;
        FileName := sFileName; // fix bug #559694
        If Editor <> Nil Then
        Begin
            Editor.UpdateCaption(ExtractFileName(sFileName));
            // project units are referenced with relative paths.
            Editor.FileName := GetRealPath(sFileName, Directory);
        End;
        Node.Text := ExtractFileName(sFileName);
        New := False;
        fInifile.WriteUnit(i, ExtractRelativePath(Directory, sFileName));
    End;
    Modified := True;
End;

Function TProject.GetUnitFromEditor(ed: TEditor): Integer;
Begin
    result := fUnits.Indexof(Ed);
End;

Function TProject.GetUnitFromString(s: String): Integer;
Begin
    result := fUnits.Indexof(ExpandFileto(s, Directory));
End;

Function TProject.GetUnitFromNode(t: TTreeNode): Integer;
Begin
    result := fUnits.Indexof(t);
End;

Function TProject.GetExecutableNameExt(projProfile: TProjProfile): String;
Var
    Base: String;
Begin
    If projProfile.OverrideOutput And (projProfile.OverridenOutput <> '') Then
        Base := ExtractFilePath(Filename) + projProfile.OverridenOutput
    Else
        Base := ChangeFileExt(Filename, '');

    // only mess with file extension if not supplied by the user
    // if he supplied one, then we assume he knows what he's doing...
    If ExtractFileExt(Base) = '' Then
    Begin
        If projProfile.typ = dptStat Then
            Result := ChangeFileExt(Base, LIB_EXT)
        Else
        If projProfile.typ = dptDyn Then
            Result := ChangeFileExt(Base, DLL_EXT)
        Else
        // GAR 10 Nov 2009
        // Hack for Wine/Linux
        // ProductName returns empty string for Wine/Linux
        // for Windows, it returns OS name (e.g. Windows Vista).
        If (MainForm.JvComputerInfoEx1.OS.ProductName = '') Then
            Result := ChangeFileExt(Base, '')
        Else
            Result := ChangeFileExt(Base, EXE_EXT);
    End
    Else
        Result := Base;

    // Add the output directory path if the user decided to specify a custom output directory 
    If Length(projProfile.ExeOutput) > 0 Then
        Result := GetRealPath(IncludeTrailingPathDelimiter(projProfile.ExeOutput) +
            ExtractFileName(Result));

    //Replace the MAKE command parameters
    Result := SubstituteMakeParams(Result);
End;


Function TProject.GetExecutableName: String;
Begin
    Result := GetExecutableNameExt(CurrentProfile);
End;

Function TProject.GetFullUnitFileName(Const index: Integer): String;
Begin
    result := ExpandFileto(fUnits[index].FileName, Directory);
End;

Function TProject.DoesEditorExists(e: TEditor): Boolean;
Var i: Integer;
Begin
    result := False;
    For i := 0 To pred(fUnits.Count) Do
        If fUnits[i].Editor = e Then
            result := True;
End;

Function TProject.GetDirectory: String;
Begin
    result := ExtractFilePath(FileName);
End;

Procedure TProject.AddLibrary(s: String);
Begin
    CurrentProfile.Libs.Add(s);
End;

Procedure TProject.AddInclude(s: String);
Begin
    CurrentProfile.Includes.Add(s);
End;

Procedure TProject.RemoveLibrary(index: Integer);
Begin
    CurrentProfile.Libs.Delete(index);
End;

Procedure TProject.RemoveInclude(index: Integer);
Begin
    CurrentProfile.Includes.Delete(index);
End;

Function TProject.ListUnitStr(Const sep: Char): String;
Var
    idx: Integer;
    sDir: String;
Begin
    Result := '';
    sDir := Directory;
    If Not CheckChangeDir(sDir) Then
        Exit;
    For idx := 0 To pred(fUnits.Count) Do
        result := result + sep + '"' + ExpandFileName(fUnits[idx].FileName) + '"';
End;

Procedure TProject.SetFileName(value: String);
Begin
    If fFileName <> value Then
    Begin
        fFileName := value;
        SetModified(True);
        finifile.finifile.Rename(value, False);
    End;
End;

Function TProject.GetModified: Boolean;
Var
    idx: Integer;
    ismod: Boolean;
Begin
    ismod := False;
    For idx := 0 To pred(fUnits.Count) Do
        If fUnits[idx].Dirty Then
            ismod := True;

    result := fModified Or ismod;
End;

Function TProject.GetCurrentProfile: TProjProfile;
Begin
    If (fCurrentProfileIndex < 0) Or (fCurrentProfileIndex >
        fProfiles.count - 1) Then
    Begin
        Result := Nil;
        exit;
    End;
    Result := fProfiles[fCurrentProfileIndex];
End;

Procedure TProject.SetCurrentProfile(Value: TProjProfile);
Begin
    If (fCurrentProfileIndex < 0) Or (fCurrentProfileIndex >
        fProfiles.count - 1) Then
        exit;
    fProfiles[fCurrentProfileIndex] := Value;
End;

Procedure TProject.SetModified(value: Boolean);
Begin
    // only mark modified if *not* read-only
{$WARN SYMBOL_PLATFORM OFF}
    If Not FileExists(FileName) Or (FileExists(FileName) And
        (FileGetAttr(FileName) And faReadOnly = 0)) Then
{$WARN SYMBOL_PLATFORM ON}
        fModified := value;
End;

Procedure TProject.SetNode(value: TTreeNode);
Begin
    If assigned(fNode) Then
    Begin
        fNode.DeleteChildren;
        fNode := Value;
    End;
End;

Procedure TProject.SetNodeValue(value: TTreeNode);
Begin
    fNode := Value;
End;

Procedure TProject.Exportto(Const HTML: Boolean);
    Function ConvertFilename(Filename, FinalPath, Extension: String): String;
    Begin
        Result := ExtractRelativePath(Directory, Filename);
        Result := StringReplace(Result, '.', '_', [rfReplaceAll]);
        Result := StringReplace(Result, '\', '_', [rfReplaceAll]);
        Result := StringReplace(Result, '/', '_', [rfReplaceAll]);
        Result := IncludeTrailingPathDelimiter(FinalPath) + Result + Extension;
    End;
Var
    idx: Integer;
    sl: TStringList;
    fname: String;
    Size: Integer;
    SizeStr: String;
    link: String;
    BaseDir: String;
    hFile: Integer;
Begin
    With dmMain.SaveDialog Do
    Begin
        Filter := dmMain.SynExporterHTML.DefaultFilter;
        DefaultExt := HTML_EXT;
        Title := Lang[ID_NV_EXPORT];
        If Not Execute Then
            Abort;
        fname := Filename;
    End;

    BaseDir := ExtractFilePath(fname);
    CreateDir(IncludeTrailingPathDelimiter(BaseDir) + 'files');
    sl := TStringList.Create;
    Try
        // create index file
        sl.Add('<HTML>');
        sl.Add('<HEAD>');
        sl.Add('<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">');
        sl.Add('<TITLE>Dev-C++ project: ' + Name + '</TITLE>');
        sl.Add('</HEAD>');
        // sl.Add('<BODY BGCOLOR=#FFFFFF>');
        sl.Add('<H2>Project: ' + Name + '</H2>');
        sl.Add('<B>Index of files:</B>');
        sl.Add('<HR WIDTH="80%">');
        sl.Add('<TABLE ALIGN="CENTER" CELLSPACING=20>');
        sl.Add('<TR><TD><B><U>Filename</U></B></TD><TD><B><U>Location</U></B></TD><TD><B><U>Size</U></B></TD></TR>');
        For idx := 0 To Units.Count - 1 Do
        Begin
            hFile := FileOpen(Units[idx].FileName, fmOpenRead);
            If hFile > 0 Then
            Begin
                Size := FileSeek(hFile, 0, 2);
                If Size >= 1024 Then
                    SizeStr := IntToStr(Size Div 1024) + ' Kb'
                Else
                    SizeStr := IntToStr(Size) + ' bytes';
                FileClose(hFile);
            End
            Else
                SizeStr := '0 bytes';
            link := ExtractFilename(
                ConvertFilename(ExtractRelativePath(Directory, Units[idx].FileName),
                BaseDir, HTML_EXT));
            sl.Add('<TR><TD><A HREF="files/' + link + '">' +
                ExtractFilename(Units[idx].FileName) + '</A></TD><TD>' +
                ExpandFilename(Units[idx].FileName) + '</TD><TD>' + SizeStr + '</TD></TR>');
        End;
        sl.Add('</TABLE>');
        sl.Add('<HR WIDTH="80%">');
        sl.Add('<P ALIGN="CENTER">');
        sl.Add('<FONT SIZE=1>');
        sl.Add('Exported by <A HREF="' + DEVCPP_WEBPAGE + '>' +
            DEVCPP + '</A> v' + DEVCPP_VERSION);
        sl.Add('</FONT></P>');
        sl.Add('</BODY>');
        sl.Add('</HTML>');
        sl.SaveToFile(fname);

        // export project files
        For idx := 0 To Units.Count - 1 Do
        Begin
            fname := Units[idx].FileName;
            sl.LoadFromFile(fname);
            fname := ConvertFilename(ExtractRelativePath(Directory,
                Units[idx].FileName), IncludeTrailingPathDelimiter(BaseDir) +
                'files', HTML_EXT);
            If HTML Then
                dmMain.ExportToHtml(sl, fname)
            Else
                dmMain.ExportToRtf(sl, fname);
        End;
    Finally
        sl.Free;
    End;
End;

Procedure TProject.ShowOptions;
Var
    IconFileName: String;
    dlg: TfrmProjectOptions;
Begin
    dlg := TfrmProjectOptions.Create(MainForm);

    Try
        dlg.Project := Self;
        //Internal to the TfrmProjectOptions SetProfile function the CopyDataFrom
        //function of the profile is called
        dlg.Profiles := Self.fProfiles;
        dlg.CurrentProfileIndex := self.CurrentProfileIndex;
        dlg.btnRemoveIcon.Enabled := Length(CurrentProfile.Icon) > 0;
        If dlg.ShowModal = mrOk Then
        Begin
            SetModified(True);
            SortUnitsByPriority;
            RebuildNodes;
            fProfiles.CopyDataFrom(dlg.Profiles);
            IconFileName := ChangeFileExt(ExtractFileName(FileName), '.ico');
            self.CurrentProfileIndex := dlg.CurrentProfileIndex;

            If (CompareText(IconFileName, CurrentProfile.Icon) <> 0) And
                (CurrentProfile.Icon <> '') Then
            Begin
                CopyFile(Pchar(CurrentProfile.Icon),
                    Pchar(ExpandFileto(IconFileName, Directory)), False);
                CurrentProfile.Icon := IconFileName;
            End;

            // rebuild the resource file
            BuildPrivateResource;

            // update the projects main node caption
            If dlg.edProjectName.Text <> '' Then
            Begin
                fName := dlg.edProjectName.Text;
                fNode.Text := fName;
            End;
        End;
    Finally
        dlg.Free;
    End;

    //Update the compiler set to be up-to-date with the latest settings (be it cancelled or otherwise)
    devCompiler.CompilerSet := CurrentProfile.CompilerSet;
    devCompilerSet.LoadSet(CurrentProfile.CompilerSet);
    devCompilerSet.AssignToCompiler;
    devCompiler.OptionStr := CurrentProfile.CompilerOptions;

End;

Function TProject.AssignTemplate(Const aFileName: String;
    Const aTemplate: TTemplate): Boolean;
Var
    Options: TProjectProfileList;
    idx: Integer;
    s, s2: String;
    OriginalIcon, DestIcon: String;
Begin
    result := True;
    Options := TProjectProfileList.Create;
    Try
        If aTemplate.Version = -1 Then
        Begin
            fName := format(Lang[ID_NEWPROJECT], [dmmain.GetNumber]);
            fNode.Text := fName;
            finiFile.FileName := aFileName;
            NewUnit(False);
            With fUnits[fUnits.Count - 1] Do
            Begin
                Editor := TEditor.Create;
                Editor.init(True, ExtractFileName(FileName), FileName, False);
                Editor.InsertDefaultText;
                Editor.Activate;
            End;
            exit;
        End;
        fName := aTemplate.ProjectName;
        finifile.FileName := aFileName;
        If aTemplate.AssignedPlugin <> '' Then
        Begin
            If MainForm.unit_plugins.Exists(aTemplate.AssignedPlugin) Then
                fPlugin := aTemplate.AssignedPlugin;
        End;

        Options.CopyDataFrom(aTemplate.OptionsRec);
        fProfiles.CopyDataFrom(Options);

        If Length(aTemplate.ProjectIcon) > 0 Then
        Begin
            OriginalIcon := ExtractFilePath(aTemplate.FileName) +
                aTemplate.ProjectIcon;
            DestIcon := ExpandFileTo(ExtractFileName(
                ChangeFileExt(FileName, '.ico')), Directory);
            CopyFile(Pchar(OriginalIcon), Pchar(DestIcon), False);
            //TODO: Guru: Not sure what will come here
            //TODO: lowjoel: Are we sure we want to place project icons as part of the profile? Shouldn't all profiles use the same icon?
            CurrentProfile.Icon := ExtractFileName(DestIcon);
        End;

        If aTemplate.Version > 0 Then // new multi units
            For idx := 0 To pred(aTemplate.UnitCount) Do
            Begin
                If aTemplate.OptionsRec.useGPP Then
                    s := aTemplate.Units[idx].CppText
                Else
                    s := aTemplate.Units[idx].CText;

                If aTemplate.OptionsRec.useGPP Then
                    NewUnit(False, aTemplate.Units[idx].CppName)
                Else
                    NewUnit(False, aTemplate.Units[idx].CName);

                With fUnits[fUnits.Count - 1] Do
                Begin
                    Editor := TEditor.Create;
                    Try
                        Editor.Init(True, ExtractFileName(filename), FileName, False);
                        If (Length(aTemplate.Units[idx].CppName) > 0) And
                            (aTemplate.OptionsRec.useGPP) Then
                        Begin
                            Editor.FileName := aTemplate.Units[idx].CppName;
                            fUnits[fUnits.Count - 1].FileName :=
                                aTemplate.Units[idx].CppName;
                        End
                        Else
                        If Length(aTemplate.Units[idx].CName) > 0 Then
                        Begin
                            Editor.FileName := aTemplate.Units[idx].CName;
                            fUnits[fUnits.Count - 1].FileName := aTemplate.Units[idx].CName;
                        End;
                        // ** if file isn't found blindly inserts text of unit
                        s2 := validateFile(s, devDirs.Templates);
                        If s2 <> '' Then
                        Begin
                            Editor.Text.Lines.LoadFromFile(s2);
                            Editor.Modified := True;
{$IFDEF PLUGIN_BUILD}
                            If fPlugin <> '' Then
                            Begin
                                If MainForm.plugins[MainForm.unit_plugins[
                                    Editor.AssignedPlugin]].ManagesUnit Then
                                Begin
                                    MainForm.plugins[MainForm.unit_plugins[
                                        Editor.AssignedPlugin]].ReloadFromFile(Editor.FileName, s2);
                                    // EAB TODO: A general semantic meaning for "ReloadFromFile" is not clear
                                End;
                            End;
{$ENDIF}
                        End
                        Else
                        If s <> '' Then
                        Begin
              	             s := StringReplace(s, '#13#10', #13#10, [rfReplaceAll]);
                 	          Editor.InsertString(s, False);
              	             Editor.Modified := True;
                        End;
            	           Editor.Activate;
                    Except
                        Editor.Free;
                    End;
                End;
            End
        Else
        Begin
            NewUnit(False);
            With fUnits[fUnits.Count - 1] Do
            Begin
                Editor := TEditor.Create;
                Editor.init(True, FileName, FileName, False);
                If fProfiles.useGPP Then
                    s := aTemplate.OldData.CppText
                Else
                    s := aTemplate.OldData.CText;
                s := ValidateFile(s, ExpandFileto(devDirs.Templates, devDirs.Exec));
                If s <> '' Then
                Begin
                    Editor.Text.Lines.LoadFromFile(s);
                    Editor.Modified := True;
                End;
                Editor.Activate;
            End;
        End;
    Except
        result := False;
    End;
    Options.Free;
End;

Procedure TProject.RebuildNodes;
Var
    idx: Integer;
    oldPaths: TStrings;
    tempnode: TTreeNode;

Begin

    If Not Assigned(fUnits) Then
        exit;
    If Not Assigned(fNode) Then
        exit;

    MainForm.ProjectView.Items.BeginUpdate;

    //remember if folder nodes were expanded or collapsed
    //create a list of expanded folder nodes
    oldPaths := TStringList.Create;
    With MainForm.ProjectView Do
        For idx := 0 To Items.Count - 1 Do
        Begin
            tempnode := Items[idx];
            If tempnode.Expanded And (tempnode.Data = Pointer(-1)) Then
                //data=pointer(-1) - it's folder
                oldPaths.Add(GetFolderPath(tempnode));
        End;

    fNode.DeleteChildren;

    CreateFolderNodes;
  {
    for idx:=0 to pred(fFolders.Count) do
      MakeNewFileNode(fFolders[idx], True).Data:=Pointer(-1);}

    For idx := 0 To pred(fUnits.Count) Do
    Begin
        fUnits[idx].Node := MakeNewFileNode(ExtractFileName(fUnits[idx].FileName),
            False, FolderNodeFromName(fUnits[idx].Folder));
        fUnits[idx].Node.Data := pointer(idx);
    End;
    For idx := 0 To pred(fFolders.Count) Do
        TTreeNode(fFolderNodes[idx]).AlphaSort(False);
    Node.AlphaSort(False);

    //expand nodes expanded before recreating the project tree
    fNode.Collapse(True);
    With MainForm.ProjectView Do
        For idx := 0 To Items.Count - 1 Do
        Begin
            tempnode := Items[idx];
            If (tempnode.Data = Pointer(-1)) Then //it's a folder
                If oldPaths.IndexOf(GetFolderPath(tempnode)) >= 0 Then
                    tempnode.Expand(False);
        End;
    FreeAndNil(oldPaths);

    fNode.Expand(False);
    MainForm.ProjectView.Items.EndUpdate;
End;

Procedure TProject.UpdateFolders;
    Procedure RunNode(Node: TTreeNode);
    Var
        I: Integer;
    Begin
        For I := 0 To Node.Count - 1 Do
            If Node.Item[I].Data = Pointer(-1) Then
            Begin
                fFolders.Add(GetFolderPath(Node.Item[I]));
                If Node.Item[I].HasChildren Then
                    RunNode(Node.Item[I]);
            End;
    End;
Var
    idx: Integer;
Begin
    fFolders.Clear;
    RunNode(fNode);
    For idx := 0 To Units.Count - 1 Do
        Units[idx].Folder := GetFolderPath(Units[idx].Node.Parent);
    SetModified(True);
End;

Function TProject.GetFolderPath(Node: TTreeNode): String;
Begin
    Result := '';
    If Not Assigned(Node) Then
        Exit;

    If Node.Data <> Pointer(-1) Then // not a folder
        Exit;

    While Node.Data = Pointer(-1) Do
    Begin
        Result := Format('%s/%s', [Node.Text, Result]);
        Node := Node.Parent;
    End;
    Delete(Result, Length(Result), 1); // remove last '/'
End;

Procedure TProject.AddFolder(s: String);
Begin
    If fFolders.IndexOf(s) = -1 Then
    Begin
        fFolders.Add(s);
        RebuildNodes;
        MainForm.ProjectView.Select(FolderNodeFromName(s));
        FolderNodeFromName(s).MakeVisible;
        SetModified(True);
    End;
End;

Procedure TProject.RemoveFolder(s: String);
Var
    idx, I: Integer;
Begin
    idx := fFolders.IndexOf(s);
    If idx = -1 Then
        Exit;

    For I := Units.Count - 1 Downto 0 Do
        If Copy(Units[I].Folder, 0, Length(s)) = s Then
            Units.Remove(I);
End;

Procedure TProject.SetHostApplication(s: String);
Begin
    CurrentProfile.HostApplication := s;
End;

Procedure TProject.CheckProjectFileForUpdate;
Var
    oldRes: String;
    sl: TStringList;
    i, uCount: Integer;
    cnvt: Boolean;
Begin
    cnvt := False;
    finifile.Section := 'Project';
    uCount := fIniFile.Read('UnitCount', 0);

    // check if using old way to store resources and fix it
    oldRes := finifile.Read('Resources', '');
    If oldRes <> '' Then
    Begin
        CopyFile(Pchar(Filename), Pchar(FileName + '.bak'), False);
        sl := TStringList.Create;
        Try
            sl.Delimiter := ';';
            sl.DelimitedText := oldRes;
            For i := 0 To sl.Count - 1 Do
            Begin
                finifile.WriteUnit(uCount + i, 'Filename', sl[i]);
                finifile.WriteUnit(uCount + i, 'Folder', 'Resources');
                finifile.WriteUnit(uCount + i, 'Compile', True);
            End;
            fIniFile.Write('UnitCount', uCount + sl.Count);
            oldRes := finifile.Read('Folders', '');
            If oldRes <> '' Then
                oldRes := oldRes + ',Resources'
            Else
                oldRes := 'Resources';
            fIniFile.Write('Folders', oldRes);
            fFolders.Add('Resources');
        Finally
            sl.Free;
        End;
        cnvt := True;
    End;

    finifile.DeleteKey('Resources');
    finifile.DeleteKey('Focused');
    finifile.DeleteKey('Order');
    finifile.DeleteKey('DebugInfo');
    finifile.DeleteKey('ProfileInfo');

    If cnvt Then
        MessageDlg('Your project was succesfully updated to a newer file format!'#13#10 +
            'If something has gone wrong, we kept a backup-file: "' +
            FileName + '.bak"...', mtInformation, [mbOk], 0);
End;

Procedure TProject.SortUnitsByPriority;
Var
    I: Integer;
    tmpU: TProjUnit;
    Again: Boolean;
Begin
    Repeat
        I := 0;
        Again := False;
        While I < Units.Count - 1 Do
        Begin
            If Units[I + 1].Priority < Units[I].Priority Then
            Begin
                tmpU := TProjUnit.Create(Self);
                tmpU.Assign(Units[I]);
                Units[I].Assign(Units[I + 1]);
                Units[I + 1].Assign(tmpU);
                tmpU.Free;
                Again := True;
            End;
            Inc(I);
        End;
    Until Not Again;
End;

Procedure TProject.SetCmdLineArgs(Const Value: String);
Begin
    If (Value <> fCmdLineArgs) Then
    Begin
        fCmdLineArgs := Value;
        SetModified(True);
    End;
End;

Procedure TProject.IncrementBuildNumber;
Begin
    Inc(VersionInfo.Build);
    SetModified(True);
End;

Function TProject.ExportToExternalProject(Const aFileName: String): Boolean;
Var
    xmlObj: TJvSimpleXML;
    mkelement, exeelement: TJvSimpleXMLElemClassic;
    strFileNames: String;
    i: Integer;

    Function GetAppTypeString(apptyp: Integer): String;
    Begin
        Case apptyp Of
            dptGUI:
                Result := 'GUI';
            dptCon:
                Result := 'console';
            dptStat:
                Result := 'lib';
            dptDyn:
                Result := 'dll';
        End;
    End;
    Function GetAppTag(apptyp: Integer): String;
    Begin
        Case apptyp Of
            dptGUI,
            dptCon:
                Result := 'exe';
            dptStat:
                Result := 'lib';
            dptDyn:
                Result := 'dll';
        End;
    End;
Begin
    xmlObj := TJvSimpleXML.Create(Nil);
    mkelement := xmlObj.Root.Container.Add('makefile');

    exeelement := mkelement.Container.Add(GetAppTag(CurrentProfile.typ));
    For i := 0 To fUnits.count - 1 Do
    Begin
        strFileNames := strFileNames + ' ' + fUnits[i].FileName;
    End;
    exeelement.Container.Add('sources', strFileNames);

    If (CurrentProfile.typ = dptGUI) Or (CurrentProfile.typ = dptCon) Then
        exeelement.Container.Add('app-type', GetAppTypeString(CurrentProfile.typ));
    //Add Include and Lib directories   
    Try
        xmlObj.SaveToFile(aFileName);
    Except
    End;
    xmlObj.Free;
    Result := True;
End;

{ TUnitList }

Constructor TUnitList.Create;
Begin
    Inherited Create;
    fList := TObjectList.Create;
End;

Destructor TUnitList.Destroy;
Var
    idx: Integer;
Begin
    For idx := pred(fList.Count) Downto 0 Do
        Remove(0);
    fList.Free;
    Inherited;
End;

Function TUnitList.Add(aunit: TProjUnit): Integer;
Begin
    result := fList.Add(aunit);
End;

Procedure TUnitList.Remove(index: Integer);
Begin
    fList.Delete(index);
    fList.Pack;
    fList.Capacity := fList.Count;
End;

Function TUnitList.GetCount: Integer;
Begin
    result := fList.Count;
End;

Function TUnitList.GetItem(index: Integer): TProjUnit;
Begin
    result := TProjUnit(fList[index]);
End;

Procedure TUnitList.SetItem(index: Integer; value: TProjUnit);
Begin
    fList[index] := value;
End;

Function TUnitList.Indexof(Editor: TEditor): Integer;
Begin
    result := Indexof(editor.FileName);
End;

Function TUnitList.Indexof(FileName: String): Integer;
Var
    s1, s2: String;
Begin
    For result := 0 To pred(fList.Count) Do
    Begin
        s1 := GetRealPath(TProjUnit(fList[result]).FileName,
            TProjUnit(fList[result]).fParent.Directory);
        s2 := GetRealPath(FileName, TProjUnit(fList[result]).fParent.Directory);
        If CompareText(s1, s2) = 0 Then
            exit;
    End;
    result := -1;
End;

Function TUnitList.Indexof(Node: TTreeNode): Integer;
Begin
    For result := 0 To pred(fList.Count) Do
        If TProjUnit(fList[result]).Node = Node Then
            exit;
    result := -1;
End;


{ TdevINI }

Destructor TdevINI.Destroy;
Begin
    If assigned(fIniFile) Then
        fIniFile.Free;
    Inherited;
End;

Procedure TdevINI.SetFileName(Const Value: String);
Begin
    fFileName := Value;
    If Not assigned(fINIFile) Then
        fINIFile := TmemINIFile.Create(fFileName)
    Else
        fINIFile.ReName(fFileName, False);
End;

Procedure TdevINI.SetSection(Const Value: String);
Begin
    fSection := Value;
End;

// reads a boolean value from fsection
Function TdevINI.Read(Name: String; Default: Boolean): Boolean;
Begin
    result := fINIFile.ReadBool(fSection, Name, Default);
End;

// reads a integer value from fsection
Function TdevINI.Read(Name: String; Default: Integer): Integer;
Begin
    result := fINIFile.ReadInteger(fSection, Name, Default);
End;

// reads unit filename for passed index
Function TdevINI.ReadUnit(index: Integer): String;
Begin
    result := fINIFile.ReadString('Unit' + inttostr(index + 1), 'FileName', '');
End;

// reads a string subitem from a unit entry
Function TdevINI.ReadUnit(index: Integer; Item: String;
    default: String): String;
Begin
    result := fINIFile.ReadString('Unit' + inttostr(index + 1), Item, default);
End;

// reads a boolean subitem from a unit entry
Function TdevINI.ReadUnit(index: Integer; Item: String;
    default: Boolean): Boolean;
Begin
    result := fINIFile.ReadBool('Unit' + inttostr(index + 1), Item, default);
End;

// reads an integer subitem from a unit entry
Function TdevINI.ReadUnit(index: Integer; Item: String;
    default: Integer): Integer;
Begin
    result := fINIFile.ReadInteger('Unit' + inttostr(index + 1), Item, default);
End;

// reads a string subitem from a Profile entry
Function TdevINI.ReadProfile(index: Integer; Item: String;
    default: String): String;
Begin
    result := fINIFile.ReadString('Profile' + inttostr(index + 1),
        Item, default);
End;

// reads a boolean subitem from a Profile entry
Function TdevINI.ReadProfile(index: Integer; Item: String;
    default: Boolean): Boolean;
Begin
    result := fINIFile.ReadBool('Profile' + inttostr(index + 1), Item, default);
End;

// reads an integer subitem from a Profile entry
Function TdevINI.ReadProfile(index: Integer; Item: String;
    default: Integer): Integer;
Begin
    result := fINIFile.ReadInteger('Profile' + inttostr(index + 1),
        Item, default);
End;

// reads string value from fsection
Function TdevINI.Read(Name, Default: String): String;
Begin
    result := fINIFile.ReadString(fSection, Name, Default);
End;

// write unit entry for passed index
Procedure TdevINI.WriteUnit(index: Integer; value: String);
Begin
    finifile.WriteString('Unit' + inttostr(index + 1), 'FileName', value);
End;

// write a string subitem in a unit entry
Procedure TdevINI.WriteUnit(index: Integer; Item: String; Value: String);
Begin
    finifile.WriteString('Unit' + inttostr(index + 1), Item, Value);
End;

// write a boolean subitem in a unit entry
Procedure TdevINI.WriteUnit(index: Integer; Item: String; Value: Boolean);
Begin
    finifile.WriteBool('Unit' + inttostr(index + 1), Item, Value);
End;

// write an integer subitem in a unit entry
Procedure TdevINI.WriteUnit(index: Integer; Item: String; Value: Integer);
Begin
    finifile.WriteInteger('Unit' + inttostr(index + 1), Item, Value);
End;

// write a string subitem in a Profile entry
Procedure TdevINI.WriteProfile(index: Integer; Item: String; Value: String);
Begin
    finifile.WriteString('Profile' + inttostr(index + 1), Item, Value);
End;

// write a boolean subitem in a Profile entry
Procedure TdevINI.WriteProfile(index: Integer; Item: String; Value: Boolean);
Begin
    finifile.WriteBool('Profile' + inttostr(index + 1), Item, Value);
End;

// write an integer subitem in a Profile entry
Procedure TdevINI.WriteProfile(index: Integer; Item: String; Value: Integer);
Begin
    finifile.WriteInteger('Profile' + inttostr(index + 1), Item, Value);
End;


// write string value to fsection
Procedure TdevINI.Write(Name, value: String);
Begin
    finifile.WriteString(fSection, Name, Value);
End;

// write boolean value to fsection
Procedure TdevINI.Write(Name: String; value: Boolean);
Begin
    fINIFile.WriteBool(fSection, Name, Value);
End;

// write integer value to fsection
Procedure TdevINI.Write(Name: String; value: Integer);
Begin
    fINIFile.WriteInteger(fSection, Name, Value);
End;

Procedure TdevINI.UpdateFile;
Begin
{$WARN SYMBOL_PLATFORM OFF}
    If Not FileExists(FileName) Or (FileExists(FileName) And
        (FileGetAttr(FileName) And faReadOnly = 0)) Then
{$WARN SYMBOL_PLATFORM ON}
        fINIFile.UpdateFile;
End;

Procedure TdevINI.ClearSection(Const Section: String = '');
Var
    s: String;
    tmp: TStringList;
    idx: Integer;
Begin
    If Section = '' Then
        s := fSection
    Else
        s := Section;

    If Not finifile.SectionExists(s) Then
        exit;
    tmp := TStringList.Create;
    Try
        finifile.ReadSectionValues(s, tmp);
        If tmp.Count = 0 Then
            exit;
        For idx := 0 To pred(tmp.Count) Do
            finifile.DeleteKey(s, tmp[idx]);
    Finally
        tmp.Free;
    End;
End;

Procedure TdevINI.EraseUnit(Const index: Integer);
Var
    s: String;
Begin
    s := 'Unit' + inttostr(index + 1);
    If finifile.SectionExists(s) Then
        finifile.EraseSection(s);
End;

Procedure TdevINI.DeleteKey(Const value: String);
Begin
    If ValueExists(value) Then
        finifile.DeleteKey(fSection, value);
End;

Function TdevINI.ValueExists(Const value: String): Boolean;
Begin
    result := finifile.ValueExists(fSection, value);
End;

End.
