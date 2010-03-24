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

unit project;

interface

uses
  Utils, StrUtils,jvsimplexml,
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

type
  TdevINI = class(TObject)
  private
    fINIFile: TmemINIFile;
    fSection: string;
    fFileName: string;
    procedure SetFileName(const Value: string);
    procedure SetSection(const Value: string);
  public
    destructor Destroy; override;

    procedure Write(Name, value: string); overload;
    procedure Write(Name: string; value: boolean); overload;
    procedure Write(Name: string; value: integer); overload;
    procedure WriteUnit(index: integer; value: string); overload;
    procedure WriteUnit(index: integer; Item: string; Value: string); overload;
    procedure WriteUnit(index: integer; Item: string; Value: boolean); overload;
    procedure WriteUnit(index: integer; Item: string; Value: integer); overload;

    procedure WriteProfile(index: integer; Item: string; Value: string); overload;
    procedure WriteProfile(index: integer; Item: string; Value: boolean); overload;
    procedure WriteProfile(index: integer; Item: string; Value: integer); overload;

    function Read(Name, Default: string): string; overload;
    function Read(Name: string; Default: boolean): boolean; overload;
    function Read(Name: string; Default: integer): integer; overload;
    function ReadUnit(index: integer): string; overload; // read unit entry
    function ReadUnit(index: integer; Item: string; default: string): string;overload;
    function ReadUnit(index: integer; Item: string; default: boolean): boolean;overload;
    function ReadUnit(index: integer; Item: string; default: integer): integer;overload;

    function ReadProfile(index: integer; Item: string; default: string): string;overload;
    function ReadProfile(index: integer; Item: string; default: boolean): boolean;overload;
    function ReadProfile(index: integer; Item: string; default: integer): integer;overload;

    function ValueExists(const value: string): boolean;
    procedure DeleteKey(const value: string);
    procedure ClearSection(const Section: string = '');
    procedure EraseUnit(const index: integer);
    procedure UpdateFile;
    property FileName: string read fFileName write SetFileName;
    property Section: string read fSection write SetSection;
  end;

  TProjUnit = class;
  TUnitList = class
  private
    fList: TObjectList;
    function GetCount: integer;
    function GetItem(index: integer): TProjUnit;
    procedure SetItem(index: integer; value: TProjUnit);
  public
    constructor Create;
    destructor Destroy; override;
    function Add(aunit: TProjUnit): integer;
    procedure Remove(index: integer);
    function Indexof(FileName: string): integer; overload;
    function Indexof(Node: TTreeNode): integer; overload;
    function Indexof(Editor: TEditor): integer; overload;

    property Items[index: integer]: Tprojunit read GetItem write SetItem; default;
    property Count: integer read GetCount;
  end;

  TProject = class;
  TProjUnit = class
  private
    fParent: TProject;
    fEditor: TEditor;
    fFileName: string;
    fNew: boolean;
    fNode: TTreeNode;
    fFolder: string;
    fCompile: boolean;
    fCompileCpp: boolean;
    fOverrideBuildCmd: boolean;
    fBuildCmd: string;
    fLink: boolean;
    fPriority: integer;
    fCollapsedList : string;
    function GetDirty: boolean;
    procedure SetDirty(value: boolean);
  public
    constructor Create(aOwner: TProject);
    destructor Destroy; override;
    function Save: boolean;
    function SaveAs: boolean;
    property Editor: TEditor read fEditor write fEditor;
    property FileName: string read fFileName write fFileName;
    property New: boolean read fNew write fNew;
    property Dirty: boolean read GetDirty write SetDirty;
    property Node: TTreeNode read fNode write fNode;
    property Parent: TProject read fParent write fParent;
    property Folder: string read fFolder write fFolder;
    property Compile: boolean read fCompile write fCompile;
    property CompileCpp: boolean read fCompileCpp write fCompileCpp;
    property CollapsedList: string read fCollapsedList write fCollapsedList;
    property OverrideBuildCmd: boolean read fOverrideBuildCmd write fOverrideBuildCmd;
    property BuildCmd: string read fBuildCmd write fBuildCmd;
    property Link: boolean read fLink write fLink;
    property Priority: integer read fPriority write fPriority;
    procedure Assign(Source: TProjUnit);
  end;

  TProject = class
  private
    fUnits: TUnitList;
    fProfiles:TProjectProfileList;
    finiFile: Tdevini;
    fName: string;
    fFileName: string;
    fNode: TTreeNode;
    fModified: boolean;
    fFolders: TStringList;
    fFolderNodes: TObjectList;
    fCmdLineArgs: string;
    fPchHead: integer;
    fPchSource: integer;
    fDefaultProfileIndex:Integer;
    fCurrentProfileIndex:Integer;
    fPrevVersion:Integer;
    fPlugin: string;
    
    function GetDirectory: string;
    function GetExecutableName: string;
    procedure SetFileName(value: string);
    procedure SetNode(value: TTreeNode);
    function GetModified: boolean;
    function GetCurrentProfile:TProjProfile;
    procedure SetCurrentProfile(Value:TProjProfile);
    procedure SetModified(value: boolean);
    procedure SortUnitsByPriority;
    procedure SetCmdLineArgs(const Value: string);
  public
    VersionInfo: TProjVersionInfo;
    property Name: string read fName write fName;
    property FileName: string read fFileName write SetFileName;
    property Node: TTreeNode read fNode write SetNode;
    property AssociatedPlugin: string read fPlugin write fPlugin;

    property Directory: string read GetDirectory;
    property Executable: string read GetExecutableName;

    property Units: TUnitList read fUnits write fUnits;
    property Profiles: TProjectProfileList read fProfiles write fProfiles;
    property INIFile: TdevINI read fINIFile write fINIFile;
    property Modified: boolean read GetModified write SetModified;

    property CmdLineArgs: string read fCmdLineArgs write SetCmdLineArgs;
    property PchHead: integer read fPchHead write fPchHead;
    property PchSource: integer read fPchSource write fPchSource;

    property CurrentProfileIndex: integer read fCurrentProfileIndex write fCurrentProfileIndex;
    property CurrentProfile : TProjProfile read GetCurrentProfile write SetCurrentProfile;
    property DefaultProfileIndex : Integer read fDefaultProfileIndex write fDefaultProfileIndex;

  public
    constructor Create(nFileName, nName: string);
    destructor Destroy; override;
    function NewUnit(NewProject: boolean; CustomFileName: string = ''): integer;
    function AddUnit(s: string; pFolder: TTreeNode; Rebuild: Boolean): TProjUnit;
    function GetFolderPath(Node: TTreeNode): string;
    procedure UpdateFolders;
    procedure AddFolder(s: string);
    procedure RemoveFolder(s: string);
    function OpenUnit(index: integer): TEditor;
    procedure CloseUnit(index: integer);
    procedure SaveUnitAs(i: integer; sFileName: string);
    procedure Save;
    procedure LoadLayout;
    procedure LoadUnitLayout(e: TEditor; Index: integer);
    procedure LoadProfiles;
    procedure SaveLayout;
    procedure SaveUnitLayout(e: TEditor; Index: integer);
    function GetExecutableNameExt(projProfile:TProjProfile): string;
    function MakeProjectNode: TTreeNode;
    function MakeNewFileNode(s: string; IsFolder: boolean; NewParent: TTreeNode): TTreeNode;
    procedure BuildPrivateResource(ForceSave: boolean = False);
    procedure Update;
    procedure UpdateFile;
    function UpdateUnits: Boolean;
    procedure Open;
    function FileAlreadyExists(s: string): boolean;
    function Remove(index: integer; DoClose: boolean): boolean;
    function GetUnitFromEditor(ed: TEditor): integer;
    function GetUnitFromString(s: string): integer;
    function GetUnitFromNode(t: TTreeNode): integer;
    function GetFullUnitFileName(const index: integer): string;
    function DoesEditorExists(e: TEditor): boolean;
    procedure AddLibrary(s: string);
    procedure AddInclude(s: string);
    procedure RemoveLibrary(index: integer);
    procedure RemoveInclude(index: integer);
    procedure RebuildNodes;
    function ListUnitStr(const sep: char): string;
    procedure Exportto(const HTML: boolean);
    procedure ShowOptions;
    function AssignTemplate(const aFileName: string; const aTemplate: TTemplate): boolean;
    procedure SetHostApplication(s: string);
    function FolderNodeFromName(name: string): TTreeNode;
    procedure CreateFolderNodes;
    procedure UpdateNodeIndexes;
    procedure SetNodeValue(value: TTreeNode);
    procedure CheckProjectFileForUpdate;
    procedure IncrementBuildNumber;
    function ExportToExternalProject(const aFileName:string):boolean;
  end;

implementation
uses
  main, MultiLangSupport, devcfg, ProjectOptionsFrm, datamod,
  RemoveUnitFrm;

{ TProjUnit }

constructor TProjUnit.Create(aOwner: TProject);
begin
  fEditor := nil;
  fNode := nil;
  fParent := aOwner;
end;

destructor TProjUnit.Destroy;
begin
  if Assigned(fEditor) then
    FreeAndNil(fEditor);
  fEditor := nil;
  fNode := nil;
  inherited;
end;

function TProjUnit.Save: boolean;
{$IFDEF PLUGIN_BUILD}
var
  i: Integer;
  boolForm: Boolean;
{$ENDIF}  
  procedure DisableFileWatch;
  var
    idx: Integer;
  begin
    idx := MainForm.devFileMonitor.Files.IndexOf(fEditor.FileName);
    if idx <> -1 then
    begin
      MainForm.devFileMonitor.Files.Delete(idx);
      MainForm.devFileMonitor.Refresh(False);
    end;
  end;

  procedure EnableFileWatch;
  begin
    MainForm.devFileMonitor.Files.Add(fEditor.FileName);
    MainForm.devFileMonitor.Refresh(False);
  end;
begin
  if (fFileName = '') or fNew then
    result := SaveAs
  else
  try
{$IFDEF PLUGIN_BUILD}
    if Assigned(fEditor) then
    begin
      boolForm := false;
      for i := 0 to MainForm.pluginsCount - 1 do
        boolForm := boolForm or MainForm.plugins[i].IsForm(fEditor.FileName);
      if boolForm then
       //Update the XPMs if we dont have them on the disk
        for i := 0 to MainForm.pluginsCount - 1 do
          MainForm.plugins[i].CreateNewXPMs(fEditor.FileName);   // EAB TODO: Think better for multiple plugins here
    end;
{$ENDIF}

    //If no editor is created open one; save file and close creates a blank file.
    if (not Assigned(fEditor)) and (not FileExists(fFileName)) then
    begin
      fEditor := TEditor.Create;
      fEditor.Init(True, ExtractFileName(fFileName), fFileName, False);
      if devEditor.AppendNewline then
        with fEditor.Text do
          if Lines.Count > 0 then
            if Lines[Lines.Count -1] <> '' then
              Lines.Add('');

      DisableFileWatch;


      // Code folding - Save the un-folded text, otherwise
      //    the folded regions won't be saved.
      if (fEditor.Text.CodeFolding.Enabled) then
      begin
         fEditor.Text.GetUncollapsedStrings.SavetoFile(fFileName);
      end
      else
         fEditor.Text.Lines.SavetoFile(fFileName);

      EnableFileWatch;

      fEditor.New := False;
      fEditor.Modified := False;
      fEditor.Close;
      fEditor := nil; //Closing the editor will destroy it
    end
    else if assigned(fEditor) and fEditor.Modified then
    begin
      if devEditor.AppendNewline then
        with fEditor.Text do
          if Lines.Count > 0 then
            if Lines[Lines.Count -1] <> '' then
              Lines.Add('');

      DisableFileWatch;

      // Code folding - Save the un-folded text, otherwise
      //    the folded regions won't be saved.
      if (fEditor.Text.CodeFolding.Enabled) then
      begin
         fEditor.Text.GetUncollapsedStrings.SavetoFile(fFileName);
      end
      else
         fEditor.Text.Lines.SavetoFile(fFileName);

      EnableFileWatch;

      fEditor.New := False;
      fEditor.Modified := False;
      if FileExists(fEditor.FileName) then
        FileSetDate(fEditor.FileName, DateTimeToFileDate(Now)); // fix the "Clock skew detected" warning ;)
    end;

    if assigned(fNode) then
      fNode.Text := ExtractFileName(fFileName);
    result := True;
  except
    result := False;
  end;
end;

function TProjUnit.SaveAs: boolean;
var
  flt: string;
  CFilter, CppFilter, HFilter: Integer;
{$IFDEF PLUGIN_BUILD}
  boolForm: Boolean;
  pluginFilter: Integer;
  filters: TStringList;
  i, j: Integer;  
{$ENDIF}
begin
  with dmMain.SaveDialog do
  begin
    if fFileName = '' then
      FileName := fEditor.TabSheet.Caption
    else
      FileName := ExtractFileName(fFileName);
{$IFDEF PLUGIN_BUILD}
    boolForm := false;
    for i := 0 to MainForm.pluginsCount - 1 do
        boolForm := boolForm or MainForm.plugins[i].IsForm(FileName);
{$ENDIF}

    if fParent.Profiles.useGPP then
    begin
      BuildFilter(flt, [FLT_CPPS, FLT_CS, FLT_HEADS]);
{$IFDEF PLUGIN_BUILD}        // <-- EAB TODO: Check for a potential problem with multiple plugins
        pluginFilter := 3;
        for i := 0 to MainForm.packagesCount - 1 do
        begin
            filters := (MainForm.plugins[MainForm.delphi_plugins[i]] AS IPlug_In_BPL).GetFilters;
            for j := 0 to filters.Count - 1 do
            begin
                AddFilter(flt, filters.Strings[j]);
                pluginFilter := pluginFilter + 1;
            end;
        end;
    {$ENDIF}
          DefaultExt := CPP_EXT;
          CFilter := 3;
          CppFilter := 2;
          HFilter := 4;

    end
    else
    begin
      BuildFilter(flt, [FLT_CS, FLT_CPPS, FLT_HEADS]);
{$IFDEF PLUGIN_BUILD}
        pluginFilter := 3;
        for i := 0 to MainForm.packagesCount - 1 do
        begin
            filters := (MainForm.plugins[MainForm.delphi_plugins[i]] AS IPlug_In_BPL).GetFilters;
            for j := 0 to filters.Count - 1 do
            begin
                AddFilter(flt, filters.Strings[j]);
                pluginFilter := pluginFilter + 1;
            end;
        end;
{$ENDIF}
      DefaultExt := C_EXT;
      CFilter := 2;
      CppFilter := 3;
      HFilter := 4;
    end;
{$IFDEF PLUGIN_BUILD}
    for i := 0 to MainForm.pluginsCount - 1 do     // <-- EAB TODO: Check for a potential problem with multiple plugins
    begin
        AddFilter(flt, MainForm.plugins[i].GetFilter(FileName));
        DefaultExt := MainForm.plugins[i].Get_EXT(FileName);
        CFilter := 2;
        CppFilter := 2;
        HFilter := 2;
        if MainForm.plugins[i].IsForm(FileName) then
            pluginFilter:= 2;
    end;
{$ENDIF}
      
    Filter := flt;
    if (CompareText(ExtractFileExt(FileName), '.h') = 0) or
      (CompareText(ExtractFileExt(FileName), '.hpp') = 0) or
      (CompareText(ExtractFileExt(FileName), '.hh') = 0) then
    begin
      FilterIndex := HFilter;
    end else
    begin
      if fParent.Profiles.useGPP then
        FilterIndex := CppFilter
      else
        FilterIndex := CFilter;
    end;
{$IFDEF PLUGIN_BUILD}
    if boolForm then
        FilterIndex := pluginFilter;
{$ENDIF}

    InitialDir := ExtractFilePath(fFileName);
    Title := Lang[ID_NV_SAVEFILE];
    if Execute then
    try
      if FileExists(FileName) and
        (MessageDlg(Lang[ID_MSG_FILEEXISTS],
        mtWarning, [mbYes, mbNo], 0) = mrNo) then
      begin
        Result := False;
        Exit;
      end;

      fNew := FALSE;
      fFileName := FileName;
      if assigned(fEditor) then
        fEditor.FileName := fFileName;
      result := Save;
    except
      result := FALSE;
    end
    else
      result := FALSE;
  end;
end;

function TProjUnit.GetDirty: boolean;
begin
  if assigned(fEditor) then
    result := fEditor.Modified
  else
    result := FALSE;
end;

procedure TProjUnit.SetDirty(value: boolean);
begin
  if assigned(fEditor) then
    fEditor.Modified := value;
end;

procedure TProjUnit.Assign(Source: TProjUnit);
begin
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
  fCollapsedList := Source.fCollapsedList;
end;

{ TProject }

constructor TProject.Create(nFileName, nName: string);
begin
  //Create our members
  inherited Create;
  fNode := nil;
  fPchHead := -1;
  fPchSource := -1;
  fFolders := TStringList.Create;
  fFolders.Duplicates := dupIgnore;
  fFolders.Sorted := True;
  fFolderNodes := TObjectList.Create;
  fFolderNodes.OwnsObjects := false;
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
  try
    finiFile.FileName := fFileName;
  except
    fFileName := '';
    MessageDlg('Could not read project file, make sure you have the correct permissions to read it.', mtError, [mbOK], 0);
    exit;
  end;
  finiFile.Section := 'Project';
  if nName = DEV_INTERNAL_OPEN then
    Open
  else
  begin
    fName := nName;
    fIniFile.Write('filename', nFileName);
    fIniFile.Write('name', nName);
    fNode := MakeProjectNode;
  end;

  if Assigned(CurrentProfile) then
    BuildPrivateResource(true);
end;

destructor TProject.Destroy;
begin
  if fModified then Save;
  fFolders.Free;
  fFolderNodes.Free;
  fIniFile.Free;
  fProfiles.Free;
  fUnits.Free;
  if (fNode <> nil) and (not fNode.Deleting) then
    fNode.Free;
  inherited;
end;

function TProject.MakeProjectNode: TTreeNode;
begin
  MakeProjectNode := MainForm.ProjectView.Items.Add(nil, Name);
  MakeProjectNode.SelectedIndex := 0;
  MakeProjectNode.ImageIndex := 0;
  MainForm.ProjectView.FullExpand;
end;

function TProject.MakeNewFileNode(s: string; IsFolder: boolean; NewParent: TTreeNode): TTreeNode;
begin
  MakeNewFileNode := MainForm.ProjectView.Items.AddChild(NewParent, s);

  if IsFolder then begin
    MakeNewFileNode.SelectedIndex := 4;
    MakeNewFileNode.ImageIndex := 4;
  end
  else begin
    MakeNewFileNode.SelectedIndex := 1;
    MakeNewFileNode.ImageIndex := 1;
  end;
end;

procedure TProject.BuildPrivateResource(ForceSave: boolean = False);
var
  ResFile, Original: TStringList;
  Res, Def, Icon, RCDir: String;
  comp, i: Integer;
begin

// GAR 10 Nov 2009
// Hack for Wine/Linux
// ProductName returns empty string for Wine/Linux
// for Windows, it returns OS name (e.g. Windows Vista).
if (MainForm.JvComputerInfoEx1.OS.ProductName = '') then
   Exit;

  comp := 0;
  for i := 0 to Units.Count - 1 do
    if GetFileTyp(Units[i].FileName) = utRes then
      if Units[i].Compile then
        Inc(comp);

  // if the project has a custom object directory, put the file in there
  if (CurrentProfile.ObjectOutput <> '') then
    RCDir := IncludeTrailingPathDelimiter(GetRealPath(CurrentProfile.ObjectOutput, Directory))
  else
    RCDir := Directory;

  // if project has no other resources included
  // and does not have an icon
  // and does not include the XP style manifest
  // and does not include version info
  // then do not create a private resource file
  if (comp = 0) and (not CurrentProfile.SupportXPThemes) and
     (not CurrentProfile.IncludeVersionInfo) and (CurrentProfile.Icon = '') then
  begin
    CurrentProfile.PrivateResource := '';
    Exit;
  end;

  // change private resource from <project_filename>.res
  // to <project_filename>_private.res
  //
  // in many cases (like in importing a MSVC project)
  // the project's resource file has already the
  // <project_filename>.res filename.
  Res := ChangeFileExt(FileName, '_private' + RC_EXT);
  Res := StringReplace(ExtractRelativePath(FileName, Res), ' ', '_', [rfReplaceAll]);
  Res := SubstituteMakeParams(RCDir) + Res;

  // don't run the private resource file and header if not modified,
  // unless ForceSave is true
  if (not ForceSave) and FileExists(Res) and FileExists(ChangeFileExt(Res, H_EXT)) and not Modified then
    Exit;

  ResFile := TStringList.Create;
  ResFile.Add('// This file is automatically generated by wxDev-C++.');
  ResFile.Add('// All changes to this file will be lost when the project is recompiled.');
  if CurrentProfile.IncludeVersionInfo then begin
    ResFile.Add('#include <windows.h>');
    ResFile.Add('');
  end;

  for i := 0 to Units.Count - 1 do
    if GetFileTyp(Units[i].FileName) = utRes then
      if Units[i].Compile then
        ResFile.Add('#include "'+ GenMakePath(ExtractRelativePath(RCDir, Units[i].FileName), False, False) + '"');

  if Length(CurrentProfile.Icon) > 0 then
  begin
    ResFile.Add('');
    Icon := GetRealPath(CurrentProfile.Icon, Directory);
    if FileExists(Icon) then
    begin
      Icon := ExtractRelativePath(FileName, Icon);
      Icon := StringReplace(Icon, '\', '/', [rfReplaceAll]);
      ResFile.Add('A ICON MOVEABLE PURE LOADONCALL DISCARDABLE "' + Icon + '"')
    end
    else
      CurrentProfile.Icon := '';
  end;

  if CurrentProfile.SupportXPThemes then begin
    ResFile.Add('');
    //TODO: lowjoel: add additional manifest files - XML parsing?
    ResFile.Add('// Windows XP Manifest file: wxDev-C++ currently only supports having');
    ResFile.Add('// comctl32.dll version 6 as the only dependant assembly.');
    if (CurrentProfile.ExeOutput <> '') then
      ResFile.Add('1 24 "' + GenMakePath(IncludeTrailingPathDelimiter(SubstituteMakeParams(CurrentProfile.ExeOutput)) + ExtractFileName(SubstituteMakeParams(Executable)) + '.Manifest"', false, false))
    else
      ResFile.Add('1 24 "' + ExtractFileName(Executable) + '.Manifest"');
  end;

  if CurrentProfile.IncludeVersionInfo then begin
    ResFile.Add('');
    ResFile.Add('// This section contains the executable version information. Go to');
    ResFile.Add('// Project > Project Options to edit these values.');
    ResFile.Add('1 VERSIONINFO');
    ResFile.Add('FILEVERSION ' + Format('%d,%d,%d,%d',[VersionInfo.Major, VersionInfo.Minor, VersionInfo.Release, VersionInfo.Build]));
    ResFile.Add('PRODUCTVERSION ' + Format('%d,%d,%d,%d',[VersionInfo.Major, VersionInfo.Minor, VersionInfo.Release, VersionInfo.Build]));
    case CurrentProfile.typ of
      dptGUI,
      dptCon:  ResFile.Add('FILETYPE VFT_APP');
      dptStat: ResFile.Add('FILETYPE VFT_STATIC_LIB');
      dptDyn:  ResFile.Add('FILETYPE VFT_DLL');
    end;
    ResFile.Add('BEGIN');
    ResFile.Add('    BLOCK "StringFileInfo"');
    ResFile.Add('    BEGIN');
    ResFile.Add('        BLOCK "' + Format('%4.4x%4.4x',[VersionInfo.LanguageID, VersionInfo.CharsetID]) + '"');
    ResFile.Add('        BEGIN');
    ResFile.Add('            VALUE "CompanyName", "' + VersionInfo.CompanyName +'"');
    ResFile.Add('            VALUE "FileVersion", "' + VersionInfo.FileVersion +'"');
    ResFile.Add('            VALUE "FileDescription", "' +VersionInfo.FileDescription + '"');
    ResFile.Add('            VALUE "InternalName", "' + VersionInfo.InternalName+ '"');
    ResFile.Add('            VALUE "LegalCopyright", "' + VersionInfo.LegalCopyright + '"');
    ResFile.Add('            VALUE "LegalTrademarks", "' + VersionInfo.LegalTrademarks + '"');
    ResFile.Add('            VALUE "OriginalFilename", "' + VersionInfo.OriginalFilename + '"');
    ResFile.Add('            VALUE "ProductName", "' + VersionInfo.ProductName +'"');
    ResFile.Add('            VALUE "ProductVersion", "' +VersionInfo.ProductVersion + '"');
    ResFile.Add('        END');
    ResFile.Add('    END');
    ResFile.Add('    BLOCK "VarFileInfo"');
    ResFile.Add('    BEGIN');
    ResFile.Add('        VALUE "Translation", ' + Format('0x%4.4x, %4.4d',[VersionInfo.LanguageID, VersionInfo.CharsetID]));
    ResFile.Add('    END');
    ResFile.Add('END');
  end;

  //Get the real path (after substituting in the make variables)
  if ResFile.Count > 2 then
  begin
    if FileExists(Res) and not ForceSave then
    begin
      Original := TStringList.Create;
      Original.LoadFromFile(Res);
      if CompareStr(Original.Text, ResFile.Text) <> 0 then
      begin
        if devEditor.AppendNewline then
          if ResFile.Count > 0 then
            if ResFile[ResFile.Count -1] <> '' then
              ResFile.Add('');

        ResFile.SaveToFile(Res);
      end;
      Original.Free;
    end
    else
    begin
      if devEditor.AppendNewline then
        if ResFile.Count > 0 then
          if ResFile[ResFile.Count - 1] <> '' then
            ResFile.Add('');

      if not DirectoryExists(SubstituteMakeParams(RCDir)) then
        ForceDirectories(SubstituteMakeParams(RCDir));
      ResFile.SaveToFile(Res);
    end;
    CurrentProfile.PrivateResource := Res;
  end
  else
  begin
    if FileExists(Res) then
      DeleteFile(PChar(Res));
    Res := ChangeFileExt(Res, RES_EXT);
    CurrentProfile.PrivateResource := '';
  end;
  if FileExists(Res) then
    FileSetDate(Res, DateTimeToFileDate(Now));// fix the "Clock skew detected" warning ;)

  // create XP manifest
  if CurrentProfile.SupportXPThemes then begin
    ResFile.Clear;
    ResFile.Add('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>');
    ResFile.Add('<assembly');
    ResFile.Add('  xmlns="urn:schemas-microsoft-com:asm.v1"');
    ResFile.Add('  manifestVersion="1.0">');
    ResFile.Add('<assemblyIdentity');
    ResFile.Add('    name="' + StringReplace(Name, ' ', '_', [rfReplaceAll]) + '"');
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
    FileSetDate(Executable + '.Manifest', DateTimeToFileDate(Now));// fix the "Clock skew detected" warning ;)
  end
  else if FileExists(Executable + '.Manifest') then
    DeleteFile(PChar(Executable + '.Manifest'));

  // create private header file
  Res := ChangeFileExt(Res, H_EXT);
  ResFile.Clear;
  Def := StringReplace(ExtractFilename(UpperCase(Res)), '.', '_', [rfReplaceAll]);
  ResFile.Add('/*');
  ResFile.Add('  This file will be overwritten by wxDev-C++ at every compile.');
  ResFile.Add('  Do not edit this file as your changes will be lost.');
  ResFile.Add('  You can, however, include this file and use the defines.');
  ResFile.Add('*/');
  ResFile.Add('#ifndef ' + Def);
  ResFile.Add('#define ' + Def);
  ResFile.Add('');
  ResFile.Add('/* VERSION DEFINITIONS */');
  ResFile.Add('#define VER_STRING'#9 + Format('"%d.%d.%d.%d"', [VersionInfo.Major, VersionInfo.Minor, VersionInfo.Release, VersionInfo.Build]));
  ResFile.Add('#define VER_MAJOR'#9 + IntToStr(VersionInfo.Major));
  ResFile.Add('#define VER_MINOR'#9 + IntToStr(VersionInfo.Minor));
  ResFile.Add('#define VER_RELEASE'#9 + IntToStr(VersionInfo.Release));
  ResFile.Add('#define VER_BUILD'#9 + IntToStr(VersionInfo.Build));
  ResFile.Add('#define COMPANY_NAME'#9'"' + VersionInfo.CompanyName +'"');
  ResFile.Add('#define FILE_VERSION'#9'"' + VersionInfo.FileVersion +'"');
  ResFile.Add('#define FILE_DESCRIPTION'#9'"' +VersionInfo.FileDescription + '"');
  ResFile.Add('#define INTERNAL_NAME'#9'"' + VersionInfo.InternalName +'"');
  ResFile.Add('#define LEGAL_COPYRIGHT'#9'"' + VersionInfo.LegalCopyright + '"');
  ResFile.Add('#define LEGAL_TRADEMARKS'#9'"' +VersionInfo.LegalTrademarks + '"');
  ResFile.Add('#define ORIGINAL_FILENAME'#9'"' +VersionInfo.OriginalFilename + '"');
  ResFile.Add('#define PRODUCT_NAME'#9'"' + VersionInfo.ProductName +'"');
  ResFile.Add('#define PRODUCT_VERSION'#9'"' +VersionInfo.ProductVersion + '"');
  ResFile.Add('');
  ResFile.Add('#endif /*'+Def +'*/');
  ResFile.SaveToFile(Res);

  if FileExists(Res) then
    FileSetDate(Res, DateTimeToFileDate(Now));// fix the "Clock skew detected" warning ;)

  ResFile.Free;
end;

function TProject.NewUnit(NewProject : boolean; CustomFileName: String): integer;
var
  s: string;
  newunit: TProjUnit;
  ParentNode, CurNode: TTreeNode;
{$IFDEF PLUGIN_BUILD}
 i: Integer;
 b: Boolean;
{$ENDIF}
begin
  NewUnit := TProjUnit.Create(Self);
  ParentNode := Node;
  with NewUnit do
  try
    if Length(CustomFileName) = 0 then
      s := Directory + Lang[ID_Untitled] + inttostr(dmMain.GetNum)
    else begin
      if ExtractFilePath(CustomFileName) = '' then // just filename, no path
        // make it full path filename, so that the save dialog, starts at the right directory ;)
        s := Directory + CustomFileName
      else
        s := CustomFileName;
    end;
    if FileAlreadyExists(s) then
      repeat
        s := Directory + Lang[ID_Untitled] + inttostr(dmMain.GetNum);
      until not FileAlreadyExists(s);
    Filename := s;
    New := True;
    Editor := nil;
    CurNode := MakeNewFileNode(ExtractFileName(FileName), false, ParentNode);
    NewUnit.Node := CurNode;
    result := fUnits.Add(NewUnit);
    CurNode.Data := pointer(result);
    Dirty := TRUE;
{$IFDEF PLUGIN_BUILD}
    b := false;
    for i := 0 to MainForm.pluginsCount - 1 do
        b := b or MainForm.plugins[i].isForm(FileName);
    if b then
    begin
        Compile := false;
        Link := false;
    end
    else
{$ENDIF}
    begin
        Compile := True;
    	CompileCpp:=Self.Profiles.useGPP;
        Link := True;
    end;
    Priority := 1000;
    OverrideBuildCmd := False;
    BuildCmd := '';
    SetModified(TRUE);
  except
    result := -1;
    NewUnit.Free;
  end;
end;

function TProject.AddUnit(s: string; pFolder: TTreeNode; Rebuild: Boolean): TProjUnit;
var
  NewUnit: TProjUnit;
  s2: string;
  TmpNode: TTreeNode;
begin
  result := nil;
  if s[length(s)] = '.' then // correct filename if the user gives an alone dot to force the no extension
    s[length(s)] := #0;
  NewUnit := TProjUnit.Create(Self);
  with NewUnit do
  try
    if FileAlreadyExists(s) then
    begin
      if fname = '' then
        s2 := fFileName
      else
        s2 := fName;
      MessageDlg(format(Lang[ID_MSG_FILEINPROJECT], [s, s2])
        + #13#10 + Lang[ID_SPECIFY], mtError, [mbok], 0);
      NewUnit.Free;
      Exit;
    end;
    FileName := s;
    New := False;
    Editor := nil;
    Node := MakeNewFileNode(ExtractFileName(FileName), false, pFolder);
    Node.Data := pointer(fUnits.Add(NewUnit));
    Folder := pFolder.Text;
    TmpNode := pFolder.Parent;
    while Assigned(TmpNode) and (TmpNode <> self.fNode) do begin
      Folder := TmpNode.Text + '/' + Folder;
      TmpNode := TmpNode.Parent;
    end;

    case GetFileTyp(s) of
      utSrc, utHead: begin
          Compile := True;
          CompileCpp := Self.Profiles.useGPP;
          Link := True;
        end;
      utRes: begin
          Compile := True;
          CompileCpp := Self.Profiles.useGPP;
          Link := False;
          // if a resource was added, force (re)creation of private resource...
          BuildPrivateResource(True);
        end;
    else begin
        Compile := False;
        CompileCpp := False;
        Link := False;
      end;
    end;
    Priority := 1000;
    OverrideBuildCmd := False;
    BuildCmd := '';
    if Rebuild then
      RebuildNodes;
    SetModified(TRUE);
    Result := NewUnit;
  except
    result := nil;
    NewUnit.Free;
  end;
end;

procedure TProject.Update;
{$IFDEF PLUGIN_BUILD}
var
    i: Integer;
{$ENDIF}
begin
  with finifile do
  begin
    Section := 'Project';
    fName := Read('name', '');
    PchHead := Read('PchHead', -1);
    PchSource := Read('PchSource', -1);
    Profiles.Ver := Read('Ver', -1);

    if Profiles.Ver > 0 then //ver > 0 is at least a v5 project
    begin
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
      VersionInfo.FileDescription := Read('FileDescription','');
      VersionInfo.InternalName := Read('InternalName', '');
      VersionInfo.LegalCopyright := Read('LegalCopyright', '');
      VersionInfo.LegalTrademarks := Read('LegalTrademarks', '');
      VersionInfo.OriginalFilename := Read('OriginalFilename',ExtractFilename(Executable));
      VersionInfo.ProductName := Read('ProductName', Name);
      VersionInfo.ProductVersion := Read('ProductVersion', '0.1');

      // Decide on the build number increment method
      if Profiles.Ver >= 2 then
      begin
        VersionInfo.AutoIncBuildNrOnRebuild := Read('AutoIncBuildNrOnRebuild', False);
        VersionInfo.AutoIncBuildNrOnCompile := Read('AutoIncBuildNrOnCompile', False);
      end
      else
      if Profiles.Ver < 2 then
        VersionInfo.AutoIncBuildNrOnCompile := Read('AutoIncBuildNr', False);

      // Migrate the old non-profiled format to our new format with profiles if necessary
      if Profiles.Ver < 3 then
      begin
        SetModified(TRUE);
        Section := 'Project';
        fProfiles[0].typ := Read('type', 0);
        fProfiles.UseGpp := Read('IsCpp', true);

{$IFDEF PLUGIN_BUILD}
        // Replace any %DEVCPP_DIR% in files with actual devcpp directory path
        fProfiles[0].Compiler := StringReplace(Read(C_INI_LABEL, ''), '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);
        fProfiles[0].CppCompiler := StringReplace(Read(CPP_INI_LABEL, ''), '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);
        if self.AssociatedPlugin <> '' then
            fProfiles[0].Linker := MainForm.plugins[MainForm.unit_plugins[AssociatedPlugin]].ConvertLibsToCurrentVersion(StringReplace(Read(LINKER_INI_LABEL, ''), '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]));   
            //fProfiles[0].Linker := ConvertLibsToCurrentVersion(StringReplace(Read(LINKER_INI_LABEL, ''), '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]));
        fProfiles[0].PreprocDefines := Read(PREPROC_INI_LABEL, '');

        fProfiles[0].ObjFiles.DelimitedText := StringReplace(Read('ObjFiles', ''), '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);
        fProfiles[0].Libs.DelimitedText := StringReplace(Read('Libs', ''), '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);
        fProfiles[0].Includes.DelimitedText := StringReplace(Read('Includes', ''), '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);

        fProfiles[0].ResourceIncludes.DelimitedText :=StringReplace(Read('ResourceIncludes', ''), '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);
        fProfiles[0].MakeIncludes.DelimitedText :=StringReplace(Read('MakeIncludes', ''), '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);
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
{$ENDIF}
        fProfiles[0].ExeOutput := Read('ExeOutput', fProfiles[0].ProfileName);
        fProfiles[0].ObjectOutput := Read('ObjectOutput', fProfiles[0].ProfileName);
        if (trim(fProfiles[0].ExeOutput) = '') and (trim(fProfiles[0].ObjectOutput) <> '') then
          fProfiles[0].ExeOutput:=fProfiles[0].ObjectOutput
        else if (trim(fProfiles[0].ExeOutput) <> '') and (trim(fProfiles[0].ObjectOutput) = '') then
          fProfiles[0].ObjectOutput:=fProfiles[0].ExeOutput
        else if ((fProfiles[0].ExeOutput = '') and (fProfiles[0].ObjectOutput = '') ) then
        begin
          fProfiles[0].ObjectOutput:=fProfiles[0].ProfileName;
          fProfiles[0].ExeOutput:=fProfiles[0].ProfileName;
        end;

        fProfiles[0].OverrideOutput := Read('OverrideOutput', FALSE);
        fProfiles[0].OverridenOutput := Read('OverrideOutputName', '');
        fProfiles[0].HostApplication := Read('HostApplication', '');

        fProfiles[0].UseCustomMakefile := Read('UseCustomMakefile', FALSE);
        fProfiles[0].CustomMakefile := Read('CustomMakefile', '');

        fProfiles[0].IncludeVersionInfo := Read('IncludeVersionInfo', False);
        fProfiles[0].SupportXPThemes := Read('SupportXPThemes', False);
        fProfiles[0].CompilerSet := Read('CompilerSet', devCompiler.CompilerSet);
        fProfiles[0].CompilerOptions := Read(COMPILER_INI_LABEL, devCompiler.OptionStr);
        
        devCompiler.OptionStr := devCompiler.OptionStr;
        if fProfiles[0].CompilerSet > devCompilerSet.Sets.Count - 1 then begin
          fProfiles[0].CompilerSet := devCompiler.CompilerSet;
          MessageDlg('The compiler set you have selected for this project, no longer '+
                     'exists.'#10'It will be substituted by the global compiler set...',
                     mtError, [mbOk], 0);
        end;
      end;
    end
    else if (Profiles.Ver = -1) then
    begin // dev-c < 4
      SetModified(TRUE);
      if not Read('NoConsole', TRUE) then
        fProfiles[0].typ := dptCon
      else
      	if Read('IsDLL', FALSE) then
        fProfiles[0].Typ := dptDyn
      else
        fProfiles[0].typ := dptGUI;

      fProfiles[0].ResourceIncludes.DelimitedText := Read('ResourceIncludes', '');
      fProfiles[0].ObjFiles.Add(read('ObjFiles', ''));
      fProfiles[0].Includes.Add(Read('IncludeDirs', ''));
      fProfiles[0].Compiler := Read('CompilerOptions', '');
      fProfiles.usegpp := Read('Use_GPP', FALSE);
      fProfiles[0].ExeOutput := Read('ExeOutput', fProfiles[0].ProfileName);
      fProfiles[0].ObjectOutput := Read('ObjectOutput', fProfiles[0].ProfileName);

      if (trim(fProfiles[0].ExeOutput) = '') and (trim(fProfiles[0].ObjectOutput) <> '') then
        fProfiles[0].ExeOutput:=fProfiles[0].ObjectOutput
      else
        if (trim(fProfiles[0].ExeOutput) <> '') and (trim(fProfiles[0].ObjectOutput) = '') then
          fProfiles[0].ObjectOutput:=fProfiles[0].ExeOutput;

      fProfiles[0].OverrideOutput := Read('OverrideOutput', FALSE);
      fProfiles[0].OverridenOutput := Read('OverrideOutputName', '');
      fProfiles[0].HostApplication := Read('HostApplication', '');
    end;
  end;
end;

procedure TProject.UpdateFile;
var
  i: Integer;
begin
  with finifile do
  begin
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
    Write('FileDescription',VersionInfo.FileDescription);
    Write('InternalName', VersionInfo.InternalName);
    Write('LegalCopyright', VersionInfo.LegalCopyright);
    Write('LegalTrademarks', VersionInfo.LegalTrademarks);
    Write('OriginalFilename',VersionInfo.OriginalFilename);
    Write('ProductName', VersionInfo.ProductName);
    Write('ProductVersion', VersionInfo.ProductVersion);
    Write('AutoIncBuildNrOnRebuild', VersionInfo.AutoIncBuildNrOnRebuild);
    Write('AutoIncBuildNrOnCompile', VersionInfo.AutoIncBuildNrOnCompile);

    for i := 0 to fProfiles.Count - 1 do
    begin    
      WriteProfile(i,'ProfileName', fProfiles[i].ProfileName);
      WriteProfile(i,'Type', fProfiles[i].typ);
      WriteProfile(i,'ObjFiles', fProfiles[i].ObjFiles.DelimitedText);
      WriteProfile(i,'Includes', fProfiles[i].Includes.DelimitedText);
      WriteProfile(i,'Libs', fProfiles[i].Libs.DelimitedText);
      WriteProfile(i,'ResourceIncludes', fProfiles[i].ResourceIncludes.DelimitedText);
      WriteProfile(i,'MakeIncludes', fProfiles[i].MakeIncludes.DelimitedText);

      WriteProfile(i,C_INI_LABEL,fProfiles[i].Compiler);
      WriteProfile(i,CPP_INI_LABEL, fProfiles[i].CppCompiler);
      WriteProfile(i,LINKER_INI_LABEL,fProfiles[i].Linker);
      WriteProfile(i,PREPROC_INI_LABEL,fProfiles[i].PreProcDefines);
      WriteProfile(i,COMPILER_INI_LABEL, fProfiles[i].CompilerOptions);

      WriteProfile(i,'Icon', ExtractRelativePath(Directory, fProfiles[i].Icon));
      WriteProfile(i,'ExeOutput', fProfiles[i].ExeOutput);
      WriteProfile(i,'ObjectOutput', fProfiles[i].ObjectOutput);
      WriteProfile(i,'OverrideOutput', fProfiles[i].OverrideOutput);
      WriteProfile(i,'OverrideOutputName', fProfiles[i].OverridenOutput);
      WriteProfile(i,'HostApplication', fProfiles[i].HostApplication);

      WriteProfile(i,'CommandLine', fCmdLineArgs);

      WriteProfile(i,'UseCustomMakefile', fProfiles[i].UseCustomMakefile);
      WriteProfile(i,'CustomMakefile', fProfiles[i].CustomMakefile);

      WriteProfile(i,'IncludeVersionInfo', fProfiles[i].IncludeVersionInfo);
      WriteProfile(i,'SupportXPThemes', fProfiles[i].SupportXPThemes);
      WriteProfile(i,'CompilerSet', fProfiles[i].CompilerSet);
      WriteProfile(i,'CompilerType', fProfiles[i].CompilerType);
    end;
    if fPrevVersion <= 2 then
    begin
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
      DeleteKey('AutoIncBuildNr')
    end;
  end;
end;

function TProject.UpdateUnits: Boolean;
var
  Count: integer;
  idx: integer;
  rd_only: boolean;
begin
  Result := False;
  Count := 0;
  idx := 0;
  rd_only := false;
  while idx <= pred(fUnits.Count) do
  begin
{$WARN SYMBOL_PLATFORM OFF}
    if fUnits[idx].Dirty and FileExists(fUnits[idx].FileName) and (FileGetAttr(fUnits[idx].FileName) and faReadOnly <> 0) then
    begin
      // file is read-only
      if MessageDlg(Format(Lang[ID_MSG_FILEISREADONLY],[fUnits[idx].FileName]), mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        rd_only := false
      else if FileSetAttr(fUnits[idx].FileName, FileGetAttr(fUnits[idx].FileName) - faReadOnly) <> 0 then
      begin
        MessageDlg(Format(Lang[ID_MSG_FILEREADONLYERROR],[fUnits[idx].FileName]), mtError, [mbOk], 0);
        rd_only := false;
      end;
    end;
{$WARN SYMBOL_PLATFORM ON}

    if (not rd_only) and (fUnits[idx] <> nil) and (not fUnits[idx].Save) and fUnits[idx].New then
      Exit;

    // saved new file or an existing file add to project file
    if (fUnits[idx].New and not fUnits[idx].Dirty) or not fUnits[idx].New then
    begin
      finifile.WriteUnit(Count, ExtractRelativePath(Directory,fUnits[idx].FileName));
      inc(Count);
    end;
    case GetFileTyp(fUnits[idx].FileName) of
      utHead,
        utSrc: finifile.WriteUnit(idx, 'CompileCpp', fUnits[idx].CompileCpp);
      utRes: if fUnits[idx].Folder = '' then fUnits[idx].Folder := 'Resources';
    end;

    finifile.WriteUnit(idx, 'Folder', fUnits[idx].Folder);
    finifile.WriteUnit(idx, 'Compile', fUnits[idx].Compile);
    finifile.WriteUnit(idx, 'Link', fUnits[idx].Link);
    finifile.WriteUnit(idx, 'Priority', fUnits[idx].Priority);
    finifile.WriteUnit(idx, 'OverrideBuildCmd', fUnits[idx].OverrideBuildCmd);
    finifile.WriteUnit(idx, 'BuildCmd', fUnits[idx].BuildCmd);
    finifile.WriteUnit(idx, 'CollapsedList', fUnits[idx].CollapsedList);
    inc(idx);
  end;
  finifile.Write('UnitCount', Count);
  Result := True;
end;

function TProject.FolderNodeFromName(name: string): TTreeNode;
var
  i: integer;
begin
  FolderNodeFromName := fNode;
  If name<>'' then
    for i := 0 to pred(fFolders.Count) do
    begin
      if AnsiCompareText(AnsiDequotedStr(fFolders[i], '"'), AnsiDequotedStr(name,'"')) = 0 then
      begin
        FolderNodeFromName := TTreeNode(fFolderNodes[i]);
        break;
      end;
    end;
end;

procedure TProject.CreateFolderNodes;
var idx: integer;
  	findnode, node: TTreeNode;
  	s: string;
  	I, C: integer;
begin
  fFolderNodes.Clear;
  for idx := 0 to pred(fFolders.Count) do
  begin
    node := fNode;
    S := fFolders[idx];
    I := Pos('/', S);
    while I > 0 do begin
      findnode := nil;
      for C := 0 to Node.Count - 1 do
        if node.Item[C].Text = Copy(S, 1, I - 1) then begin
          findnode := node.Item[C];
          Break;
        end;
      if not Assigned(findnode) then
        node := MakeNewFileNode(Copy(S, 1, I - 1), True, node)
      else
        node := findnode;
      node.Data := Pointer(-1);
      Delete(S, 1, I);
      I := Pos('/', S);
    end;
    node := MakeNewFileNode(S, True, Node);
    node.Data := Pointer(-1);
    fFolderNodes.Add(node);
  end;
end;

procedure TProject.UpdateNodeIndexes;
var idx: integer;
begin
  for idx := 0 to pred(fUnits.Count) do
    fUnits[idx].Node.Data := pointer(idx);
end;

// open is used to determine if layout info is present in the file.
// if it is present the users AutoOpen settings are ignored,
// perhaps we should make it another option?
procedure TProject.Open;
var
  ucount, i: integer;
  NewUnit: TProjUnit;
begin
{$WARN SYMBOL_PLATFORM OFF}
  if FileExists(FileName) and (FileGetAttr(FileName) and faReadOnly <> 0) then begin
    // file is read-only
    if MessageDlg(Format(Lang[ID_MSG_FILEISREADONLY], [FileName]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      if FileSetAttr(FileName, FileGetAttr(FileName) - faReadOnly) <> 0 then begin
        MessageDlg(Format(Lang[ID_MSG_FILEREADONLYERROR], [FileName]), mtError, [mbOk], 0);
      end;
  end;
{$WARN SYMBOL_PLATFORM ON}

  //First Load the Profile before doing anything
  LoadProfiles;
  Update;
  fNode := MakeProjectNode;

  CheckProjectFileForUpdate;
  finifile.Section := 'Project';
  uCount := fIniFile.Read('UnitCount', 0);
  CreateFolderNodes;
  for i := 0 to pred(uCount) do
  begin
    NewUnit := TProjUnit.Create(Self);
    with NewUnit do
    begin
      FileName := ExpandFileto(finifile.ReadUnit(i), Directory);
      if not FileExists(FileName) then
      begin
        Application.MessageBox(PChar(Format(Lang[ID_ERR_FILENOTFOUND],
          [FileName])), 'Error', MB_ICONHAND);
        SetModified(TRUE);
        Continue;
      end;
      Folder := finifile.ReadUnit(i, 'Folder', '');

      Compile := finifile.ReadUnit(i, 'Compile', True);
        if finifile.ReadUnit(i, 'CompileCpp', 2)=2 then // check if feature not present in this file
        CompileCpp := Self.fProfiles.useGPP
      else
        CompileCpp := finifile.ReadUnit(i, 'CompileCpp', False);
      Link := finifile.ReadUnit(i, 'Link', True);
      Priority := finifile.ReadUnit(i, 'Priority', 1000);
      OverrideBuildCmd := finifile.ReadUnit(i, 'OverrideBuildCmd', False);
      BuildCmd := finifile.ReadUnit(i, 'BuildCmd', '');
      CollapsedList := finifile.ReadUnit(i, 'CollapsedList', '');
      
      Editor := nil;
      New := FALSE;
      fParent := self;

      Node := MakeNewFileNode(ExtractFileName(FileName), False, FolderNodeFromName(Folder));
      Node.Data := pointer(fUnits.Add(NewUnit));

    end;
  end;

  case devData.AutoOpen of
    0: // Open All
      for i := 0 to pred(fUnits.Count) do
        OpenUnit(i).Activate;
    1: // Open First
      OpenUnit(0).Activate;
  else
    LoadLayout;
  end;
  RebuildNodes;
  if CurrentProfile.CompilerSet < devCompilerSet.Sets.Count then
    devCompilerSet.LoadSet(CurrentProfile.CompilerSet);
  devCompilerSet.AssignToCompiler;

  //Since we just loaded everything we are 'clean'
  SetModified(False);
end;

procedure TProject.LoadProfiles;
var
    i, profileCount, resetCompilers, AutoSelectMissingCompiler: Integer;
    NewProfile:TProjProfile;
    CompilerType: string;
begin
  ResetCompilers            := 0;
  finifile.Section := 'Project';
  profilecount:=finifile.Read('ProfilesCount',0);
  fProfiles.useGPP:=finifile.Read('useGPP',true);
  CurrentProfileIndex:=finifile.Read('ProfileIndex',0);
  fPrevVersion:=finifile.Read('Ver',-1);
  AutoSelectMissingCompiler := 0;
  if (CurrentProfileIndex > profileCount - 1) or (CurrentProfileIndex < 0 )then
    CurrentProfileIndex := 0;

  if profileCount <= 0 then
  begin
    CurrentProfileIndex:=0;
    Profiles.Ver:=fPrevVersion;
    NewProfile:=TProjProfile.Create;
    NewProfile.ProfileName := 'Default Profile';
    NewProfile.ExeOutput := NewProfile.ProfileName;
    NewProfile.ObjectOutput := NewProfile.ProfileName;
    fProfiles.Add(NewProfile);
    Exit;
  end;

  for i := 0 to pred(profileCount) do
  begin
    NewProfile:=TProjProfile.Create;
    NewProfile.ProfileName:= finifile.ReadProfile(i,'ProfileName','');
    NewProfile.typ:= finifile.ReadProfile(i,'Type',0);
    NewProfile.CompilerType := finifile.ReadProfile(i, 'CompilerType', ID_COMPILER_MINGW);
    NewProfile.CompilerSet := finifile.ReadProfile(i, 'CompilerSet', ID_COMPILER_MINGW);
    NewProfile.Compiler:= finifile.ReadProfile(i,'Compiler','');
    NewProfile.CppCompiler:= finifile.ReadProfile(i,'CppCompiler','');
    NewProfile.Linker:= finifile.ReadProfile(i,'Linker','');
    NewProfile.CompilerOptions := finifile.ReadProfile(i, COMPILER_INI_LABEL, '');
    NewProfile.PreprocDefines := finifile.ReadProfile(i, 'PreprocDefines', '');
    NewProfile.ObjFiles.DelimitedText:=finifile.ReadProfile(i,'ObjFiles','');
    NewProfile.Includes.DelimitedText:=finifile.ReadProfile(i,'Includes','');
    NewProfile.Libs.DelimitedText:=finifile.ReadProfile(i,'Libs','');
    NewProfile.ResourceIncludes.DelimitedText:=finifile.ReadProfile(i,'ResourceIncludes','');
    NewProfile.MakeIncludes.DelimitedText:=finifile.ReadProfile(i,'MakeIncludes','');
    NewProfile.Icon:= finifile.ReadProfile(i,'Icon','');
    NewProfile.ExeOutput := finifile.ReadProfile(i,'ExeOutput','');
    NewProfile.ObjectOutput := finifile.ReadProfile(i,'ObjectOutput','');
    NewProfile.OverrideOutput := finifile.ReadProfile(i,'OverrideOutput',false);
    NewProfile.OverridenOutput := finifile.ReadProfile(i,'OverrideOutputName','');
    NewProfile.HostApplication := finifile.ReadProfile(i,'HostApplication','');
    NewProfile.IncludeVersionInfo := finifile.ReadProfile(i,'IncludeVersionInfo',false);
    NewProfile.SupportXPThemes := finifile.ReadProfile(i,'SupportXPThemes',false);
    NewProfile.UseCustomMakefile := finifile.ReadProfile(i,'UseCustomMakefile',false);   // EAB: we weren't loading this setting.
    NewProfile.CustomMakefile := finifile.ReadProfile(i,'CustomMakefile','');   // EAB: we weren't loading this setting.
    if (NewProfile.CompilerSet > devCompilerSet.Sets.Count - 1) or (NewProfile.CompilerSet = -1) then
    begin
       case NewProfile.compilerType of
         ID_COMPILER_MINGW:   CompilerType := 'MingW';
         ID_COMPILER_VC2008:  CompilerType := 'Visual C++ 2008';
         ID_COMPILER_VC2005:  CompilerType := 'Visual C++ 2005';
         ID_COMPILER_VC2003:  CompilerType := 'Visual C++ 2003';
         ID_COMPILER_VC6:     CompilerType := 'Visual C++ 6';
         ID_COMPILER_DMARS:   CompilerType := 'MingW';
         ID_COMPILER_BORLAND: CompilerType := 'MingW';
         ID_COMPILER_WATCOM:  CompilerType := 'MingW';
         ID_COMPILER_LINUX :  CompilerType := 'Linux gcc';
       end;
 
       case AutoSelectMissingCompiler of
         mrYesToAll:
           NewProfile.CompilerSet := GetClosestMatchingCompilerSet(NewProfile.compilerType);
         mrNoToAll:;
         else
         begin
           AutoSelectMissingCompiler := MessageDlg('The compiler specified in the profile ' + NewProfile.ProfileName +
                                                   ' does not exist on the local computer.'#10#13#10#13 +
                                                   'Do you want wxDev-C++ to attempt to find a suitable compiler to ' +
                                                   'use for this profile?', mtConfirmation, [mbYes, mbNo, mbNoToAll, mbYesToAll],
                                                   Application.Handle);
           case AutoSelectMissingCompiler of
             mrYes, mrYesToAll:
               NewProfile.CompilerSet := GetClosestMatchingCompilerSet(NewProfile.compilerType);
           end;
         end;
       end;

       Inc(ResetCompilers);
    end;
    fProfiles.Add(NewProfile);
  end;
end;

procedure TProject.LoadLayout;
var
  layIni: TIniFile;
  top: integer;
  sl: TStringList;
  idx, currIdx: integer;
begin
  sl := TStringList.Create;
  try
    layIni := TIniFile.Create(ChangeFileExt(Filename, '.layout'));
    try
      top := layIni.ReadInteger('Editors', 'Focused', -1);
      // read order of open files and open them accordingly
      sl.CommaText := layIni.ReadString('Editors', 'Order', '');
    finally
      layIni.Free;
    end;

    for idx := 0 to sl.Count - 1 do begin
      currIdx := StrToIntDef(sl[idx], -1);
      LoadUnitLayout(OpenUnit(currIdx), currIdx);
    end;
  finally
    sl.Free;
  end;

  if (Top > -1) and (fUnits.Count > 0) and (top < fUnits.Count) and Assigned(fUnits[top].Editor) then
    fUnits[top].Editor.Activate;
end;

procedure TProject.LoadUnitLayout(e: TEditor; Index: integer);
var
  layIni: TIniFile;
begin
  layIni := TIniFile.Create(ChangeFileExt(Filename, '.layout'));
  try
    if Assigned(e) then begin
      e.Text.CaretY := layIni.ReadInteger('Editor_' + IntToStr(Index), 'CursorRow', 1);
      e.Text.CaretX := layIni.ReadInteger('Editor_' + IntToStr(Index), 'CursorCol', 1);
      e.Text.TopLine := layIni.ReadInteger('Editor_' + IntToStr(Index),'TopLine', 1);
      e.Text.LeftChar := layIni.ReadInteger('Editor_' + IntToStr(Index),'LeftChar', 1);
    end;
  finally
    layIni.Free;
  end;
end;

procedure TProject.SaveLayout;
var
  layIni: TIniFile;
  idx: Integer;
  aset: boolean;
  sl: TStringList;
  S, S2: string;
  e: TEditor;
begin
  s := ChangeFileExt(Filename, '.layout');
//  SetCurrentDir(ExtractFilePath(Filename));   // EAB: FileIsReadOnly depends on current dir.

  if FileExists(s) and (FileGetAttr(s) and faReadOnly <> 0) then
    exit;
  layIni := TIniFile.Create(s);
  try
    //  finifile.Section:= 'Views';
    //  finifile.Write('ProjectView', devData.ProjectView);
    finifile.Section := 'Project';

    sl := TStringList.Create;
    try
      // write order of open files
      sl.Clear;
      for idx := 0 to MainForm.PageControl.PageCount - 1 do begin
        S := MainForm.PageControl.Pages[idx].Caption;
        e := MainForm.GetEditor(idx);
        S2 := e.FileName;
        if (Length(S) > 4) and
          (Copy(S, 1, 4) = '[*] ') then
          // the file is modified and the tabsheet's caption starts with '[*] ' - delete it
          S := Copy(S, 5, Length(S) - 4);
        if sl.IndexOf(IntToStr(fUnits.Indexof(S2))) = -1 then
          sl.Add(IntToStr(fUnits.Indexof(S2)));
        if MainForm.PageControl.ActivePageIndex = idx then
          layIni.WriteInteger('Editors', 'Focused', fUnits.Indexof(S2));
      end;
      layIni.WriteString('Editors', 'Order', sl.CommaText);
    finally
      sl.Free;
    end;

    // save editor info
    for idx := 0 to pred(fUnits.Count) do
    begin
      try
      with fUnits[idx] do
      begin
        // save info on open state
        aset := Assigned(fUnits[idx].editor);
        layIni.WriteBool('Editor_' + IntToStr(idx), 'Open', aset);
        layIni.WriteBool('Editor_' + IntToStr(idx), 'Top', aset and
          (fUnits[idx].Editor.TabSheet = fUnits[idx].Editor.TabSheet.PageControl.ActivePage));
        if aset then begin
          layIni.WriteInteger('Editor_' + IntToStr(idx), 'CursorCol', fUnits[idx].Editor.Text.CaretX);
          layIni.WriteInteger('Editor_' + IntToStr(idx), 'CursorRow', fUnits[idx].Editor.Text.CaretY);
          layIni.WriteInteger('Editor_' + IntToStr(idx), 'TopLine',   fUnits[idx].Editor.Text.TopLine);
          layIni.WriteInteger('Editor_' + IntToStr(idx), 'LeftChar',  fUnits[idx].Editor.Text.LeftChar);
        end;

        // remove old data from project file
        fIniFile.Section := 'Unit' + IntToStr(idx + 1);
        fIniFile.DeleteKey('Open');
        fIniFile.DeleteKey('Top');
        fIniFile.DeleteKey('CursorCol');
        fIniFile.DeleteKey('CursorRow');
        fIniFile.DeleteKey('TopLine');
        fIniFile.DeleteKey('LeftChar');
      end;
      except
      end;
    end;
  finally
    layIni.Free;
  end;
  fIniFile.Section := 'Project';
end;

// EAB: It looks like this function is doing redundant work after SaveLayout call.. however I won't touch it to prevent unexpected problems.
procedure TProject.SaveUnitLayout(e: TEditor; Index: integer);
var
  layIni: TIniFile;
  filepath: string;
begin
{$WARN SYMBOL_PLATFORM OFF}
  //Get the path of the layout file
  filepath := ChangeFileExt(Filename, '.layout');

  //Is the file read-only?
  if FileExists(filepath) and (FileGetAttr(filepath) and faReadOnly <> 0) then
  begin
    // file is read-only
    if MessageDlg(Format(Lang[ID_MSG_FILEISREADONLY], [filepath]),mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;
    if FileSetAttr(filepath, FileGetAttr(filepath) - faReadOnly) <> 0 then begin
      MessageDlg(Format(Lang[ID_MSG_FILEREADONLYERROR], [filepath]), mtError, [mbOk], 0);
      //NinjaNL Exit;
    end;
  end;

  layIni := TIniFile.Create(filepath);
  try
    if Assigned(e) then begin
      layIni.WriteInteger('Editor_' + IntToStr(Index), 'CursorCol', e.Text.CaretX);
      layIni.WriteInteger('Editor_' + IntToStr(Index), 'CursorRow', e.Text.CaretY);
      layIni.WriteInteger('Editor_' + IntToStr(Index), 'TopLine', e.Text.TopLine);
      layIni.WriteInteger('Editor_' + IntToStr(Index), 'LeftChar',e.Text.LeftChar);
    end;
  finally
    layIni.Free;
  end;
end;

procedure TProject.Save;
begin
  if not UpdateUnits then
    Exit;
  UpdateFile; // so data is current before going to disk
  SaveLayout; // save current opened files, and which is "active".
  if fModified then
    finiFile.UpdateFile;
  SetModified(FALSE);
end;

function TProject.Remove(index: integer; DoClose: boolean): boolean;
var
  i: integer;
begin
  result := false;
  if index > -1 then
  begin
    // if a resource was removed, force (re)creation of private resource...
    if GetFileTyp(fUnits.GetItem(index).FileName) = utRes then
      BuildPrivateResource(True);
    if DoClose and Assigned(fUnits.GetItem(index).fEditor) then begin
      if not MainForm.CloseEditor(fUnits.GetItem(index).fEditor.TabSheet.PageIndex, False) then
        exit;
    end;
    result := true;
    { this causes problems if the project isn't saved after this, since the erase happens phisically at this moment }
    //if not fUnits.GetItem(index).fNew then
    finifile.EraseUnit(index);

    fUnits.GetItem(index).fNode.Delete;
    fUnits.Remove(index);

    UpdateNodeIndexes();
    SetModified(TRUE);

    //is this the PCH file?
    if index = PchHead then
      PchHead := -1
    else if index = PchSource then
      PchSource := -1
    else
    begin
      //The header or source file unit may have moved
      if (PchHead <> -1) and (PchHead > index) then
        PchHead := PchHead - 1;
      if (PchSource <> -1) and (PchSource > index) then
        PchSource := PchSource - 1;
    end;
  end
  else // pick from list
    with TRemoveUnitForm.Create(MainForm) do
    try
      for i := 0 to pred(fUnits.Count) do
        UnitList.Items.Append(fUnits[i].FileName);
      if (ShowModal = mrOk) and (UnitList.ItemIndex <> -1) then
        Remove(UnitList.ItemIndex, true);
    finally
      Free;
    end;
end;

function TProject.FileAlreadyExists(s: string): boolean;
begin
  result := TRUE;
  if fUnits.Indexof(s) > -1 then exit;
  result := FALSE;
end;

function TProject.OpenUnit(index: integer): TEditor;
begin
  result := nil;
  if (index < 0) or (index > pred(fUnits.Count)) then exit;

  with fUnits[index] do
  begin
    fEditor := TEditor.Create;
    if FileName <> '' then
      try
        chdir(Directory);
         fEditor.Init(TRUE, ExtractFileName(FileName), ExpandFileName(FileName), not New);
           if New then
      	     if devEditor.DefaulttoPrj then
               fEditor.InsertDefaultText;
         LoadUnitLayout(fEditor, index);
         result:= fEditor;
      except
        on E: Exception do
        begin
          MessageDlg(format(Lang[ID_ERR_OPENFILE] + #13 + 'Reason: %s', [Filename, E.Message]), mtError, [mbOK], 0);
          fEditor.Close;
          fEditor := nil; //because closing the editor will destroy it
        end;
        else
        begin
          MessageDlg(format(Lang[ID_ERR_OPENFILE], [Filename]), mtError, [mbOK], 0);
          fEditor.Close;
          fEditor := nil; //because closing the editor will destroy it
        end;
      end
    else
    begin
      fEditor.Close;
      fEditor:=nil; //because closing the editor will destroy it
    end;
  end;
end;

procedure TProject.CloseUnit(index: integer);
begin
  if (index < 0) or (index > pred(fUnits.Count)) then exit;
  with fUnits[index] do
  begin
    if assigned(fEditor) then
    begin
      SaveUnitLayout(fEditor, index);
      fEditor.Close;
      fEditor:=nil; //because closing the editor will destroy it
    end;
  end;
end;

procedure TProject.SaveUnitAs(i: integer; sFileName: string);
begin
  if (i < 0) or (i > pred(fUnits.Count)) then exit;

  with fUnits[i] do
  begin
    if FileExists(FileName) then
      New := FALSE;
    FileName := sFileName; // fix bug #559694
    if Editor <> nil then
    begin
      Editor.UpdateCaption(ExtractFileName(sFileName));
      // project units are referenced with relative paths.
      Editor.FileName := GetRealPath(sFileName, Directory);
    end;
    Node.Text := ExtractFileName(sFileName);
    New := False;
    fInifile.WriteUnit(i, ExtractRelativePath(Directory, sFileName));
  end;
  Modified := true;
end;

function TProject.GetUnitFromEditor(ed: TEditor): integer;
begin
  result := fUnits.Indexof(Ed);
end;

function TProject.GetUnitFromString(s: string): integer;
begin
  result := fUnits.Indexof(ExpandFileto(s, Directory));
end;

function TProject.GetUnitFromNode(t: TTreeNode): integer;
begin
  result := fUnits.Indexof(t);
end;

function TProject.GetExecutableNameExt(projProfile: TProjProfile): string;
var
  Base: string;
begin
  if projProfile.OverrideOutput and (projProfile.OverridenOutput <> '') then
    Base := ExtractFilePath(Filename) + projProfile.OverridenOutput
  else
    Base := ChangeFileExt(Filename, '');

  // only mess with file extension if not supplied by the user
  // if he supplied one, then we assume he knows what he's doing...
  if ExtractFileExt(Base) = '' then begin
    if projProfile.typ = dptStat then
      Result := ChangeFileExt(Base, LIB_EXT)
    else if projProfile.typ = dptDyn then
      Result := ChangeFileExt(Base, DLL_EXT)
    else
        // GAR 10 Nov 2009
// Hack for Wine/Linux
// ProductName returns empty string for Wine/Linux
// for Windows, it returns OS name (e.g. Windows Vista).
if (MainForm.JvComputerInfoEx1.OS.ProductName = '') then
   Result := ChangeFileExt(Base, '')
else
      Result := ChangeFileExt(Base, EXE_EXT);
  end
  else
    Result := Base;

  // Add the output directory path if the user decided to specify a custom output directory 
  if Length(projProfile.ExeOutput) > 0 then
    Result := GetRealPath(IncludeTrailingPathDelimiter(projProfile.ExeOutput) + ExtractFileName(Result));

  //Replace the MAKE command parameters
  Result := SubstituteMakeParams(Result);
end;


function TProject.GetExecutableName: string;
begin
  Result:=GetExecutableNameExt(CurrentProfile);
end;

function TProject.GetFullUnitFileName(const index: integer): string;
begin
  result := ExpandFileto(fUnits[index].FileName, Directory);
end;

function TProject.DoesEditorExists(e: TEditor): boolean;
var i: integer;
begin
  result := FALSE;
  for i := 0 to pred(fUnits.Count) do
    if fUnits[i].Editor = e then
      result := TRUE;
end;

function TProject.GetDirectory: string;
begin
  result := ExtractFilePath(FileName);
end;

procedure TProject.AddLibrary(s: string);
begin
  CurrentProfile.Libs.Add(s);
end;

procedure TProject.AddInclude(s: string);
begin
  CurrentProfile.Includes.Add(s);
end;

procedure TProject.RemoveLibrary(index: integer);
begin
  CurrentProfile.Libs.Delete(index);
end;

procedure TProject.RemoveInclude(index: integer);
begin
  CurrentProfile.Includes.Delete(index);
end;

function TProject.ListUnitStr(const sep: char): string;
var
  idx: integer;
  sDir: string;
begin
  Result := '';
  sDir := Directory;
  if not CheckChangeDir(sDir) then
    Exit;
  for idx := 0 to pred(fUnits.Count) do
    result := result + sep + '"' + ExpandFileName(fUnits[idx].FileName) + '"';
end;

procedure TProject.SetFileName(value: string);
begin
  if fFileName <> value then begin
    fFileName := value;
    SetModified(True);
    finifile.finifile.Rename(value, FALSE);
  end;
end;

function TProject.GetModified: boolean;
var
  idx: integer;
  ismod: boolean;
begin
  ismod := FALSE;
  for idx := 0 to pred(fUnits.Count) do
    if fUnits[idx].Dirty then ismod := TRUE;

  result := fModified or ismod;
end;

function TProject.GetCurrentProfile:TProjProfile;
begin
  if (fCurrentProfileIndex < 0) or (fCurrentProfileIndex > fProfiles.count-1) then
  begin
    Result:=nil;
    exit;
  end;
  Result:=fProfiles[fCurrentProfileIndex];
end;

procedure TProject.SetCurrentProfile(Value:TProjProfile);
begin
  if (fCurrentProfileIndex < 0) or (fCurrentProfileIndex > fProfiles.count-1) then
    exit;
  fProfiles[fCurrentProfileIndex]:=Value;
end;

procedure TProject.SetModified(value: boolean);
begin
  // only mark modified if *not* read-only
{$WARN SYMBOL_PLATFORM OFF}
  if not FileExists(FileName) or (FileExists(FileName) and (FileGetAttr(FileName) and faReadOnly = 0)) then
{$WARN SYMBOL_PLATFORM ON}
    fModified := value;
end;

procedure TProject.SetNode(value: TTreeNode);
begin
  if assigned(fNode) then
  begin
    fNode.DeleteChildren;
    fNode := Value;
  end;
end;

procedure TProject.SetNodeValue(value: TTreeNode);
begin
  fNode := Value;
end;

procedure TProject.Exportto(const HTML: boolean);
  function ConvertFilename(Filename, FinalPath, Extension: string): string;
  begin
    Result := ExtractRelativePath(Directory, Filename);
    Result := StringReplace(Result, '.', '_', [rfReplaceAll]);
    Result := StringReplace(Result, '\', '_', [rfReplaceAll]);
    Result := StringReplace(Result, '/', '_', [rfReplaceAll]);
    Result := IncludeTrailingPathDelimiter(FinalPath) + Result + Extension;
  end;
var
  idx: integer;
  sl: TStringList;
  fname: string;
  Size: integer;
  SizeStr: string;
  link: string;
  BaseDir: string;
  hFile: integer;
begin
  with dmMain.SaveDialog do begin
    Filter := dmMain.SynExporterHTML.DefaultFilter;
    DefaultExt := HTML_EXT;
    Title := Lang[ID_NV_EXPORT];
    if not Execute then
      Abort;
    fname := Filename;
  end;

  BaseDir := ExtractFilePath(fname);
  CreateDir(IncludeTrailingPathDelimiter(BaseDir) + 'files');
  sl := TStringList.Create;
  try
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
    for idx := 0 to Units.Count - 1 do begin
      hFile := FileOpen(Units[idx].FileName, fmOpenRead);
      if hFile > 0 then begin
        Size := FileSeek(hFile, 0, 2);
        if Size >= 1024 then
          SizeStr := IntToStr(Size div 1024) + ' Kb'
        else
          SizeStr := IntToStr(Size) + ' bytes';
        FileClose(hFile);
      end
      else
        SizeStr := '0 bytes';
      link := ExtractFilename(ConvertFilename(ExtractRelativePath(Directory,Units[idx].FileName), BaseDir, HTML_EXT));
      sl.Add('<TR><TD><A HREF="files/' + link + '">' + ExtractFilename(Units[idx].FileName) + '</A></TD><TD>' + ExpandFilename(Units[idx].FileName) + '</TD><TD>' + SizeStr + '</TD></TR>');
    end;
    sl.Add('</TABLE>');
    sl.Add('<HR WIDTH="80%">');
    sl.Add('<P ALIGN="CENTER">');
    sl.Add('<FONT SIZE=1>');
    sl.Add('Exported by <A HREF="' + DEVCPP_WEBPAGE + '>' + DEVCPP + '</A> v' + DEVCPP_VERSION);
    sl.Add('</FONT></P>');
    sl.Add('</BODY>');
    sl.Add('</HTML>');
    sl.SaveToFile(fname);

    // export project files
    for idx := 0 to Units.Count - 1 do begin
      fname := Units[idx].FileName;
      sl.LoadFromFile(fname);
      fname := ConvertFilename(ExtractRelativePath(Directory, Units[idx].FileName), IncludeTrailingPathDelimiter(BaseDir) + 'files',HTML_EXT);
      if HTML then
        dmMain.ExportToHtml(sl, fname)
      else
        dmMain.ExportToRtf(sl, fname);
    end;
  finally
    sl.Free;
  end;
end;

procedure TProject.ShowOptions;
var
  IconFileName: String;
  dlg:TfrmProjectOptions;
begin
  dlg:=TfrmProjectOptions.Create(MainForm);

  try
    dlg.Project := Self;
    //Internal to the TfrmProjectOptions SetProfile function the CopyDataFrom
    //function of the profile is called
    dlg.Profiles := Self.fProfiles;
    dlg.CurrentProfileIndex := self.CurrentProfileIndex;
    dlg.btnRemoveIcon.Enabled := Length(CurrentProfile.Icon) > 0;
    if dlg.ShowModal = mrOk then
    begin
      SetModified(TRUE);
      SortUnitsByPriority;
      RebuildNodes;
      fProfiles.CopyDataFrom(dlg.Profiles);
      IconFileName := ChangeFileExt(ExtractFileName(FileName), '.ico');
      self.CurrentProfileIndex := dlg.CurrentProfileIndex;

      if (CompareText(IconFileName, CurrentProfile.Icon) <> 0) and (CurrentProfile.Icon <> '') then
      begin
        CopyFile(PChar(CurrentProfile.Icon), PChar(ExpandFileto(IconFileName,Directory)), False);
        CurrentProfile.Icon := IconFileName;
      end;

      // rebuild the resource file
      BuildPrivateResource;

      // update the projects main node caption
      if dlg.edProjectName.Text <> '' then
      begin
        fName := dlg.edProjectName.Text;
        fNode.Text := fName;
      end;
    end;
  finally
    dlg.Free;
  end;
  
   //Update the compiler set to be up-to-date with the latest settings (be it cancelled or otherwise)
  devCompiler.CompilerSet:=CurrentProfile.CompilerSet;
  devCompilerSet.LoadSet(CurrentProfile.CompilerSet);
  devCompilerSet.AssignToCompiler;
  devCompiler.OptionStr:=CurrentProfile.CompilerOptions;

end;

function TProject.AssignTemplate(const aFileName: string; const aTemplate:TTemplate): boolean;
var
  Options: TProjectProfileList;
  idx: integer;
  s, s2: string;
 OriginalIcon, DestIcon: String;
begin
  result := TRUE;
  Options:=TProjectProfileList.Create;
  try
    if aTemplate.Version = -1 then
    begin
      fName := format(Lang[ID_NEWPROJECT], [dmmain.GetNumber]);
      fNode.Text := fName;
      finiFile.FileName := aFileName;
      NewUnit(FALSE);
      with fUnits[fUnits.Count - 1] do
      begin
        Editor := TEditor.Create;
        Editor.init(TRUE, ExtractFileName(FileName), FileName, FALSE);
        Editor.InsertDefaultText;
        Editor.Activate;
      end;
      exit;
    end;
    fName := aTemplate.ProjectName;
    finifile.FileName := aFileName;
    if aTemplate.AssignedPlugin <> '' then
    begin
        if MainForm.unit_plugins.Exists(aTemplate.AssignedPlugin) then
            fPlugin := aTemplate.AssignedPlugin;
    end;

    Options.CopyDataFrom(aTemplate.OptionsRec);
    fProfiles.CopyDataFrom(Options);

    if Length(aTemplate.ProjectIcon) > 0 then
    begin
      OriginalIcon := ExtractFilePath(aTemplate.FileName) + aTemplate.ProjectIcon;
      DestIcon := ExpandFileTo(ExtractFileName(ChangeFileExt(FileName, '.ico')), Directory);
      CopyFile(PChar(OriginalIcon), PChar(DestIcon), False);
      //TODO: Guru: Not sure what will come here
      //TODO: lowjoel: Are we sure we want to place project icons as part of the profile? Shouldn't all profiles use the same icon?
      CurrentProfile.Icon := ExtractFileName(DestIcon);
    end;

    if aTemplate.Version > 0 then // new multi units
      for idx := 0 to pred(aTemplate.UnitCount) do
      begin
        if aTemplate.OptionsRec.useGPP then
          s := aTemplate.Units[idx].CppText
        else
          s := aTemplate.Units[idx].CText;

        if aTemplate.OptionsRec.useGPP then
          NewUnit(FALSE, aTemplate.Units[idx].CppName)
        else
          NewUnit(FALSE, aTemplate.Units[idx].CName);

        with fUnits[fUnits.Count - 1] do
        begin
          Editor := TEditor.Create;
          try
            Editor.Init(TRUE, ExtractFileName(filename), FileName, FALSE);
            if (Length(aTemplate.Units[idx].CppName) > 0) and
              (aTemplate.OptionsRec.useGPP) then
            begin
              Editor.FileName := aTemplate.Units[idx].CppName;
              fUnits[fUnits.Count - 1].FileName := aTemplate.Units[idx].CppName;
            end else if Length(aTemplate.Units[idx].CName) > 0 then
            begin
              Editor.FileName := aTemplate.Units[idx].CName;
              fUnits[fUnits.Count - 1].FileName := aTemplate.Units[idx].CName;
            end;
            // ** if file isn't found blindly inserts text of unit
            s2 := validateFile(s, devDirs.Templates);
            if s2 <> '' then
            begin
              Editor.Text.Lines.LoadFromFile(s2);
              Editor.Modified := TRUE;
{$IFDEF PLUGIN_BUILD}
              if fPlugin <> '' then
              begin
                  if MainForm.plugins[MainForm.unit_plugins[Editor.AssignedPlugin]].ManagesUnit then
                  begin
                    MainForm.plugins[MainForm.unit_plugins[Editor.AssignedPlugin]].ReloadFromFile(Editor.FileName, s2);   // EAB TODO: A general semantic meaning for "ReloadFromFile" is not clear
                  end;
              end;
{$ENDIF}
            end
            else 
              if s <> '' then
              begin
              	s := StringReplace(s, '#13#10', #13#10, [rfReplaceAll]);
                 	Editor.InsertString(s, FALSE);
              	Editor.Modified := TRUE;
              end;
            	Editor.Activate;
          except
            Editor.Free;
          end;
        end;
      end
    else
    begin
      NewUnit(FALSE);
      with fUnits[fUnits.Count - 1] do
      begin
        Editor := TEditor.Create;
        Editor.init(TRUE, FileName, FileName, FALSE);
        if fProfiles.useGPP then
          s := aTemplate.OldData.CppText
        else
          s := aTemplate.OldData.CText;
        s := ValidateFile(s, ExpandFileto(devDirs.Templates, devDirs.Exec));
        if s <> '' then
        begin
          Editor.Text.Lines.LoadFromFile(s);
          Editor.Modified := TRUE;
        end;
        Editor.Activate;
      end;
    end;
  except
    result := FALSE;
  end;
  Options.Free;
end;

procedure TProject.RebuildNodes;
var
  idx: integer;
  oldPaths: TStrings;
  tempnode: TTreeNode;

begin
  MainForm.ProjectView.Items.BeginUpdate;

  //remember if folder nodes were expanded or collapsed
  //create a list of expanded folder nodes
  oldPaths := TStringList.Create;
  with MainForm.ProjectView do
    for idx := 0 to Items.Count - 1 do
    begin
      tempnode := Items[idx];
      if tempnode.Expanded AND (tempnode.Data=Pointer(-1)) then //data=pointer(-1) - it's folder
        oldPaths.Add(GetFolderPath(tempnode));
    end;

  fNode.DeleteChildren;

  CreateFolderNodes;
  {
    for idx:=0 to pred(fFolders.Count) do
      MakeNewFileNode(fFolders[idx], True).Data:=Pointer(-1);}
  for idx := 0 to pred(fUnits.Count) do
  begin
    fUnits[idx].Node := MakeNewFileNode(ExtractFileName(fUnits[idx].FileName), False, FolderNodeFromName(fUnits[idx].Folder));
    fUnits[idx].Node.Data := pointer(idx);
  end;
  for idx := 0 to pred(fFolders.Count) do
    TTreeNode(fFolderNodes[idx]).AlphaSort(False);
  Node.AlphaSort(False);

  //expand nodes expanded before recreating the project tree
  fNode.Collapse(True);
  with MainForm.ProjectView do
    for idx := 0 to Items.Count - 1 do
    begin
      tempnode := Items[idx];
      if (tempnode.Data = Pointer(-1)) then //it's a folder
        if oldPaths.IndexOf(GetFolderPath(tempnode)) >= 0 then
          tempnode.Expand(False);
    end;
  FreeAndNil(oldPaths);

  fNode.Expand(False);
  MainForm.ProjectView.Items.EndUpdate;
end;

procedure TProject.UpdateFolders;
  procedure RunNode(Node: TTreeNode);
  var
    I: integer;
  begin
    for I := 0 to Node.Count - 1 do
      if Node.Item[I].Data = Pointer(-1) then begin
        fFolders.Add(GetFolderPath(Node.Item[I]));
        if Node.Item[I].HasChildren then
          RunNode(Node.Item[I]);
      end;
  end;
var
  idx: integer;
begin
  fFolders.Clear;
  RunNode(fNode);
  for idx := 0 to Units.Count - 1 do
    Units[idx].Folder := GetFolderPath(Units[idx].Node.Parent);
  SetModified(TRUE);
end;

function TProject.GetFolderPath(Node: TTreeNode): string;
begin
  Result := '';
  if not Assigned(Node) then
    Exit;

  if Node.Data <> Pointer(-1) then // not a folder
    Exit;

  while Node.Data = Pointer(-1) do begin
    Result := Format('%s/%s', [Node.Text, Result]);
    Node := Node.Parent;
  end;
  Delete(Result, Length(Result), 1); // remove last '/'
end;

procedure TProject.AddFolder(s: string);
begin
  if fFolders.IndexOf(s) = -1 then begin
    fFolders.Add(s);
    RebuildNodes;
    MainForm.ProjectView.Select(FolderNodeFromName(s));
    FolderNodeFromName(s).MakeVisible;
    SetModified(TRUE);
  end;
end;

procedure TProject.RemoveFolder(s: string);
var
  idx, I: Integer;
begin
  idx := fFolders.IndexOf(s);
  if idx = -1 then
    Exit;

  for I := Units.Count - 1 downto 0 do
    if Copy(Units[I].Folder, 0, Length(s)) = s then
      Units.Remove(I);
end;

procedure TProject.SetHostApplication(s: string);
begin
  CurrentProfile.HostApplication := s;
end;

procedure TProject.CheckProjectFileForUpdate;
var
  oldRes: string;
  sl: TStringList;
  i, uCount: integer;
  cnvt: boolean;
begin
  cnvt := False;
  finifile.Section := 'Project';
  uCount := fIniFile.Read('UnitCount', 0);

  // check if using old way to store resources and fix it
  oldRes := finifile.Read('Resources', '');
  if oldRes <> '' then begin
    CopyFile(PChar(Filename), PChar(FileName + '.bak'), False);
    sl := TStringList.Create;
    try
      sl.Delimiter := ';';
      sl.DelimitedText := oldRes;
      for i := 0 to sl.Count - 1 do begin
        finifile.WriteUnit(uCount + i, 'Filename', sl[i]);
        finifile.WriteUnit(uCount + i, 'Folder', 'Resources');
        finifile.WriteUnit(uCount + i, 'Compile', True);
      end;
      fIniFile.Write('UnitCount', uCount + sl.Count);
      oldRes := finifile.Read('Folders', '');
      if oldRes <> '' then
        oldRes := oldRes + ',Resources'
      else
        oldRes := 'Resources';
      fIniFile.Write('Folders', oldRes);
      fFolders.Add('Resources');
    finally
      sl.Free;
    end;
    cnvt := True;
  end;

  finifile.DeleteKey('Resources');
  finifile.DeleteKey('Focused');
  finifile.DeleteKey('Order');
  finifile.DeleteKey('DebugInfo');
  finifile.DeleteKey('ProfileInfo');

  if cnvt then
    MessageDlg('Your project was succesfully updated to a newer file format!'#13#10 +
      'If something has gone wrong, we kept a backup-file: "' +
      FileName + '.bak"...', mtInformation, [mbOk], 0);
end;

procedure TProject.SortUnitsByPriority;
var
  I: integer;
  tmpU: TProjUnit;
  Again: boolean;
begin
  repeat
    I := 0;
    Again := False;
    while I < Units.Count - 1 do begin
      if Units[I + 1].Priority < Units[I].Priority then begin
        tmpU := TProjUnit.Create(Self);
        tmpU.Assign(Units[I]);
        Units[I].Assign(Units[I + 1]);
        Units[I + 1].Assign(tmpU);
        tmpU.Free;
        Again := True;
      end;
      Inc(I);
    end;
  until not Again;
end;

procedure TProject.SetCmdLineArgs(const Value: string);
begin
  if (Value <> fCmdLineArgs) then begin
    fCmdLineArgs := Value;
    SetModified(TRUE);
  end;
end;

procedure TProject.IncrementBuildNumber;
begin
  Inc(VersionInfo.Build);
  SetModified(True);
end;

function TProject.ExportToExternalProject(const aFileName:string):boolean;
var
  xmlObj:TJvSimpleXML;
  mkelement,exeelement:TJvSimpleXMLElemClassic;
  strFileNames:String;
  i:Integer;

  function GetAppTypeString(apptyp:Integer):string;
  begin
    case apptyp of
    dptGUI:
      Result:='GUI';
    dptCon:
      Result:='console';
    dptStat:
      Result:='lib';
    dptDyn:
      Result:='dll';
    end;
  end;  
  function GetAppTag(apptyp:Integer):string;
  begin
    case apptyp of
    dptGUI,
    dptCon:
      Result:='exe';
    dptStat:
      Result:='lib';
    dptDyn:
      Result:='dll';
    end;
  end;
begin
  xmlObj:=TJvSimpleXML.Create(nil);
  mkelement:=xmlObj.Root.Container.Add('makefile');

  exeelement:=mkelement.Container.Add(GetAppTag(CurrentProfile.typ));
  for i:= 0 to fUnits.count -1 do
  begin
    strFileNames := strFileNames + ' '+fUnits[i].FileName;
  end;
  exeelement.Container.Add('sources',strFileNames);

  if (CurrentProfile.typ = dptGUI) or  (CurrentProfile.typ = dptCon) then
    exeelement.Container.Add('app-type',GetAppTypeString(CurrentProfile.typ));
  //Add Include and Lib directories   
  try
  xmlObj.SaveToFile(aFileName);
  except
  end;  
  xmlObj.Destroy;
  Result:=true;
end;

{ TUnitList }

constructor TUnitList.Create;
begin
  inherited Create;
  fList := TObjectList.Create;
end;

destructor TUnitList.Destroy;
var
  idx: integer;
begin
  for idx := pred(fList.Count) downto 0 do Remove(0);
  fList.Free;
  inherited;
end;

function TUnitList.Add(aunit: TProjUnit): integer;
begin
  result := fList.Add(aunit);
end;

procedure TUnitList.Remove(index: integer);
begin
  fList.Delete(index);
  fList.Pack;
  fList.Capacity := fList.Count;
end;

function TUnitList.GetCount: integer;
begin
  result := fList.Count;
end;

function TUnitList.GetItem(index: integer): TProjUnit;
begin
  result := TProjUnit(fList[index]);
end;

procedure TUnitList.SetItem(index: integer; value: TProjUnit);
begin
  fList[index] := value;
end;

function TUnitList.Indexof(Editor: TEditor): integer;
begin
  result := Indexof(editor.FileName);
end;

function TUnitList.Indexof(FileName: string): integer;
var
  s1, s2: String;
begin
  for result := 0 to pred(fList.Count) do
  begin
    s1 := GetRealPath(TProjUnit(fList[result]).FileName,
      TProjUnit(fList[result]).fParent.Directory);
    s2 := GetRealPath(FileName, TProjUnit(fList[result]).fParent.Directory);
    if CompareText(s1, s2) = 0 then exit;
  end;
  result := -1;
end;

function TUnitList.Indexof(Node: TTreeNode): integer;
begin
  for result := 0 to pred(fList.Count) do
    if TProjUnit(fList[result]).Node = Node then exit;
  result := -1;
end;


{ TdevINI }

destructor TdevINI.Destroy;
begin
  if assigned(fIniFile) then
    fIniFile.Free;
  inherited;
end;

procedure TdevINI.SetFileName(const Value: string);
begin
  fFileName := Value;
  if not assigned(fINIFile) then
    fINIFile := TmemINIFile.Create(fFileName)
  else
    fINIFile.ReName(fFileName, FALSE);
end;

procedure TdevINI.SetSection(const Value: string);
begin
  fSection := Value;
end;

// reads a boolean value from fsection
function TdevINI.Read(Name: string; Default: boolean): boolean;
begin
  result := fINIFile.ReadBool(fSection, Name, Default);
end;

// reads a integer value from fsection
function TdevINI.Read(Name: string; Default: integer): integer;
begin
  result := fINIFile.ReadInteger(fSection, Name, Default);
end;

// reads unit filename for passed index
function TdevINI.ReadUnit(index: integer): string;
begin
  result := fINIFile.ReadString('Unit' + inttostr(index + 1), 'FileName', '');
end;

// reads a string subitem from a unit entry
function TdevINI.ReadUnit(index: integer; Item: string; default: string): string;
begin
  result := fINIFile.ReadString('Unit' + inttostr(index + 1), Item, default);
end;

// reads a boolean subitem from a unit entry
function TdevINI.ReadUnit(index: integer; Item: string; default: boolean): boolean;
begin
  result := fINIFile.ReadBool('Unit' + inttostr(index + 1), Item, default);
end;

// reads an integer subitem from a unit entry
function TdevINI.ReadUnit(index: integer; Item: string; default: integer): integer;
begin
  result := fINIFile.ReadInteger('Unit' + inttostr(index + 1), Item, default);
end;

// reads a string subitem from a Profile entry
function TdevINI.ReadProfile(index: integer; Item: string; default: string): string;
begin
  result := fINIFile.ReadString('Profile' + inttostr(index + 1), Item, default);
end;

// reads a boolean subitem from a Profile entry
function TdevINI.ReadProfile(index: integer; Item: string; default: boolean): boolean;
begin
  result := fINIFile.ReadBool('Profile' + inttostr(index + 1), Item, default);
end;

// reads an integer subitem from a Profile entry
function TdevINI.ReadProfile(index: integer; Item: string; default: integer): integer;
begin
  result := fINIFile.ReadInteger('Profile' + inttostr(index + 1), Item, default);
end;

// reads string value from fsection
function TdevINI.Read(Name, Default: string): string;
begin
  result := fINIFile.ReadString(fSection, Name, Default);
end;

// write unit entry for passed index
procedure TdevINI.WriteUnit(index: integer; value: string);
begin
  finifile.WriteString('Unit' + inttostr(index + 1), 'FileName', value);
end;

// write a string subitem in a unit entry
procedure TdevINI.WriteUnit(index: integer; Item: string; Value: string);
begin
  finifile.WriteString('Unit' + inttostr(index + 1), Item, Value);
end;

// write a boolean subitem in a unit entry
procedure TdevINI.WriteUnit(index: integer; Item: string; Value: boolean);
begin
  finifile.WriteBool('Unit' + inttostr(index + 1), Item, Value);
end;

// write an integer subitem in a unit entry
procedure TdevINI.WriteUnit(index: integer; Item: string; Value: integer);
begin
  finifile.WriteInteger('Unit' + inttostr(index + 1), Item, Value);
end;

// write a string subitem in a Profile entry
procedure TdevINI.WriteProfile(index: integer; Item: string; Value: string);
begin
  finifile.WriteString('Profile' + inttostr(index + 1), Item, Value);
end;

// write a boolean subitem in a Profile entry
procedure TdevINI.WriteProfile(index: integer; Item: string; Value: boolean);
begin
  finifile.WriteBool('Profile' + inttostr(index + 1), Item, Value);
end;

// write an integer subitem in a Profile entry
procedure TdevINI.WriteProfile(index: integer; Item: string; Value: integer);
begin
  finifile.WriteInteger('Profile' + inttostr(index + 1), Item, Value);
end;


// write string value to fsection
procedure TdevINI.Write(Name, value: string);
begin
  finifile.WriteString(fSection, Name, Value);
end;

// write boolean value to fsection
procedure TdevINI.Write(Name: string; value: boolean);
begin
  fINIFile.WriteBool(fSection, Name, Value);
end;

// write integer value to fsection
procedure TdevINI.Write(Name: string; value: integer);
begin
  fINIFile.WriteInteger(fSection, Name, Value);
end;

procedure TdevINI.UpdateFile;
begin
{$WARN SYMBOL_PLATFORM OFF}
  if not FileExists(FileName) or (FileExists(FileName) and (FileGetAttr(FileName) and faReadOnly = 0)) then
{$WARN SYMBOL_PLATFORM ON}
    fINIFile.UpdateFile;
end;

procedure TdevINI.ClearSection(const Section: string = '');
var
  s: string;
  tmp: TStringList;
  idx: integer;
begin
  if Section = '' then
    s := fSection
  else
    s := Section;

  if not finifile.SectionExists(s) then exit;
  tmp := TStringList.Create;
  try
    finifile.ReadSectionValues(s, tmp);
    if tmp.Count = 0 then exit;
    for idx := 0 to pred(tmp.Count) do
      finifile.DeleteKey(s, tmp[idx]);
  finally
    tmp.Free;
  end;
end;

procedure TdevINI.EraseUnit(const index: integer);
var
  s: string;
begin
  s := 'Unit' + inttostr(index + 1);
  if finifile.SectionExists(s) then
    finifile.EraseSection(s);
end;

procedure TdevINI.DeleteKey(const value: string);
begin
  if ValueExists(value) then
    finifile.DeleteKey(fSection, value);
end;

function TdevINI.ValueExists(const value: string): boolean;
begin
  result := finifile.ValueExists(fSection, value);
end;

end.

