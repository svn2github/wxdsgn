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

unit prjtypes;

interface

uses
{$IFDEF WIN32}
  Classes, editor, ComCtrls, datamod
{$ENDIF}
{$IFDEF LINUX}
  Classes, editor, QComCtrls, datamod
{$ENDIF}
{$IFDEF WX_BUILD}
  ,SysUtils,Contnrs
{$ENDIF}
;
const
  dptGUI = 0;
  dptCon = 1;
  dptStat = 2;
  dptDyn = 3;

type
  TProjType = byte;
  TProjTypeSet = set of TProjType;

  TProjVersionInfo = record
    Major: integer;
    Minor: integer;
    Release: integer;
    Build: integer;
    LanguageID: integer;
    CharsetID: integer;
    CompanyName: string;
    FileVersion: string;
    FileDescription: string;
    InternalName: string;
    LegalCopyright: string;
    LegalTrademarks: string;
    OriginalFilename: string;
    ProductName: string;
    ProductVersion: string;
    AutoIncBuildNrOnCompile: boolean;
    AutoIncBuildNrOnRebuild: boolean;
  end;

  TProjProfile = class
  public
    ProfileName:String;
    typ: TProjType;
    compilerType: integer;
    Objfiles: TStringList;
    Compiler: string;
    CppCompiler: string;
    Linker: string;
    Includes: TStringList;
    Libs: TStringList;
    PrivateResource: String; // Dev-C++ will overwrite this file
    ResourceIncludes: TStringList;
    MakeIncludes: TStringList;
    Icon: string;
    ExeOutput: String;
    ObjectOutput: String;
    OverrideOutput: boolean;
    OverridenOutput: string;
    HostApplication: string;
    IncludeVersionInfo: boolean;
    SupportXPThemes: boolean;
    CompilerSet: integer;
    CompilerOptions: string;
    VersionInfo: TProjVersionInfo;
    PreprocDefines: string;
    //New Items From Project
    UseCustomMakefile: boolean;
    CustomMakefile: string;

    constructor Create;
    destructor Destroy; override;
    procedure CopyProfileFrom(R1: TProjProfile);
  end;

  TProjectProfileList = class
  private
    fList: TObjectList;
    fVer:Integer;
    fuseGpp:Boolean;
    function GetCount: integer;
    function GetItem(index: integer): TProjProfile;
    procedure SetItem(index: integer; value: TProjProfile);
  public
    constructor Create;
    destructor Destroy; override;
    procedure CopyDataFrom(ProfileList:TProjectProfileList);
    function Add(aprofile: TProjProfile): integer;
    procedure Remove(index: integer);
    procedure Clear;

    property Items[index: integer]: TProjProfile read GetItem write SetItem; default;
    property Count: integer read GetCount;
    property Ver:Integer read fVer write fVer;
    property useGpp:Boolean read fuseGpp write fuseGpp;
  end;

  
(*
  TProjOptions = record
    typ: TProjType;
    Ver: integer;
    cmdLines: record
      GCC_Compiler: string;
      GCC_CppCompiler: string;
      GCC_Linker: string;
      VC2005_Compiler: string;
      VC2005_CppCompiler: string;
      VC2005_Linker: string;
      VC2003_Compiler: string;
      VC2003_CppCompiler: string;
      VC2003_Linker: string;
      VC6_Compiler: string;
      VC6_CppCompiler: string;
      VC6_Linker: string;
      BORLAND_Compiler: string;
      BORLAND_CppCompiler: string;
      BORLAND_Linker: string;
      DMARS_Compiler: string;
      DMARS_CppCompiler: string;
      DMARS_Linker: string;
      WATCOM_Compiler: string;
      WATCOM_CppCompiler: string;
      WATCOM_Linker: string;
    end;

    Includes: TStrings;
    Libs: TStrings;
    PrivateResource: String; // Dev-C++ will overwrite this file
    ResourceIncludes: TStringList;
    MakeIncludes: TStringList;
    useGPP: boolean;
    Icon: string;

    ExeOutput: String;
    ObjectOutput: String;
    OverrideOutput: boolean;
    OverridenOutput: string;

    HostApplication: string;
    IncludeVersionInfo: boolean;
    SupportXPThemes: boolean;
    CompilerSet: integer;

    GCC_CompilerOptions: string;
    VC2005_CompilerOptions: string;
    VC2003_CompilerOptions: string;
    VC6_CompilerOptions: string;
    DMARS_CompilerOptions: string;
    BORLAND_CompilerOptions: string;
    WATCOM_CompilerOptions: string;

    VersionInfo: TProjVersionInfo;

    GCC_PreprocDefines: string;
    VC2005_PreprocDefines: string;
    VC2003_PreprocDefines: string;
    VC6_PreprocDefines: string;
    DMARS_PreprocDefines: string;
    BORLAND_PreprocDefines: string;
    WATCOM_PreprocDefines: string;
  end;
*)

//procedure InitOptionsRec(var Rec: TProjOptions);
//procedure AssignOptionsRec(var R1, R2: TProjOptions);

implementation

uses
  devcfg;

constructor TProjProfile.Create;
begin
  Objfiles:= TStringList.Create;
  Includes:= TStringList.Create;
  Libs:= TStringList.Create;
  ResourceIncludes:= TStringList.Create;
  MakeIncludes:= TStringList.Create;

  Includes.Delimiter := ';';
  Libs.Delimiter := ';';
  PrivateResource := '';
  ResourceIncludes.Delimiter := ';';
  MakeIncludes.Delimiter := ';';
  ObjFiles.Delimiter := ';';
  Icon := '';
  ExeOutput := '';
  ObjectOutput := '';
  HostApplication := '';
  SupportXPThemes := False;
  CompilerSet := 0;
  CompilerOptions := devCompiler.OptionStr;
  IncludeVersionInfo := False;
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
end;

destructor TProjProfile.Destroy;
begin
  Objfiles.Free;
  Includes.Free;
  Libs.Free;
  ResourceIncludes.Free;
  MakeIncludes.Free;
end;

procedure TProjProfile.CopyProfileFrom(R1: TProjProfile);
begin
    ProfileName:=R1.ProfileName;
    typ := R1.typ;
    Objfiles.Text := r1.ObjFiles.Text;
    Includes.Text := StringReplace(R1.Includes.Text,'%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);
    Libs.Text := StringReplace(R1.Libs.Text,'%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);
    PrivateResource := StringReplace(R1.PrivateResource,'%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);
    ResourceIncludes.Text := StringReplace(R1.ResourceIncludes.Text,'%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);
    MakeIncludes.Text := StringReplace(R1.MakeIncludes.Text,'%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);

    Compiler := R1.Compiler;
    CppCompiler := R1.CppCompiler;
    Linker := R1.Linker;
    PreprocDefines := R1.PreprocDefines;
    CompilerOptions := R1.CompilerOptions;

    icon := R1.icon;
    ExeOutput := R1.ExeOutput;
    ObjectOutput := R1.ObjectOutput;
    OverrideOutput:=R1.OverrideOutput;
    OverridenOutput:= R1.OverridenOutput;
    HostApplication := R1.HostApplication;
    IncludeVersionInfo := R1.IncludeVersionInfo;
    SupportXPThemes := R1.SupportXPThemes;
    CompilerSet := R1.CompilerSet;
    compilerType := R1.compilerType;
    VersionInfo := R1.VersionInfo;
    UseCustomMakefile:=R1.UseCustomMakefile;
    CustomMakefile:=R1.CustomMakefile;
end;

{ TProjectProfileList }
constructor TProjectProfileList.Create;
begin
  inherited Create;
  fList := TObjectList.Create;
end;

destructor TProjectProfileList.Destroy;
var
  idx: integer;
begin
  for idx := pred(fList.Count) downto 0 do Remove(0);
  fList.Free;
  inherited;
end;

function TProjectProfileList.Add(aprofile: TProjProfile): integer;
begin
  result := fList.Add(aprofile);
end;

procedure TProjectProfileList.Remove(index: integer);
begin
  fList.Delete(index);
  fList.Pack;
  fList.Capacity := fList.Count;
end;

procedure TProjectProfileList.Clear;
var
  i:Integer;
begin
  for i:= Count -1 downto 0 do
  begin
    //fixme: check for MemLeak here
    //if self[i] <> nil then
    //  self[i].Destroy;
    Remove(i);
  end;
end;

function TProjectProfileList.GetCount: integer;
begin
  result := fList.Count;
end;

function TProjectProfileList.GetItem(index: integer): TProjProfile;
begin
  result := TProjProfile(fList[index]);
end;

procedure TProjectProfileList.SetItem(index: integer; value: TProjProfile);
begin
  fList[index] := value;
end;

procedure TProjectProfileList.CopyDataFrom(ProfileList:TProjectProfileList);
var
  i:Integer;
  NewProfile:TProjProfile;
begin
  self.Clear;

  Ver := ProfileList.ver;
  useGpp := ProfileList.useGpp;
  for i :=0 to ProfileList.Count -1 Do
  Begin
    NewProfile:=TProjProfile.Create;
    NewProfile.CopyProfileFrom(ProfileList[i]);
    Self.Add(NewProfile);
  End;
end;


(*
procedure InitOptionsRec(var Rec: TProjOptions);
begin
  with Rec do
  begin
    Includes := TStringList.Create;
    Libs := TStringList.Create;
    ResourceIncludes := TStringList.Create;
    MakeIncludes := TStringList.Create;
    //ObjFiles := TStringList.Create;
    Includes.Delimiter := ';';
    Libs.Delimiter := ';';
    PrivateResource := '';
    ResourceIncludes.Delimiter := ';';
    MakeIncludes.Delimiter := ';';
    //ObjFiles.Delimiter := ';';
    Icon := '';
    ExeOutput := '';
    ObjectOutput := '';
    HostApplication := '';
    SupportXPThemes := False;
    CompilerSet := 0;
    if(devCompiler.CompilerType = ID_COMPILER_MINGW) then
      GCC_CompilerOptions := devCompiler.OptionStr
    else if (devCompiler.CompilerType = ID_COMPILER_VC2005) then
      VC2005_CompilerOptions := devCompiler.OptionStr
    else if (devCompiler.CompilerType = ID_COMPILER_VC2003) then
      VC2003_CompilerOptions := devCompiler.OptionStr
    else if (devCompiler.CompilerType = ID_COMPILER_VC6) then
      VC6_CompilerOptions := devCompiler.OptionStr
    else if (devCompiler.CompilerType = ID_COMPILER_DMARS) then
      DMARS_CompilerOptions := devCompiler.OptionStr
    else if (devCompiler.CompilerType = ID_COMPILER_BORLAND) then
      BORLAND_CompilerOptions := devCompiler.OptionStr
    else if (devCompiler.CompilerType = ID_COMPILER_WATCOM) then
      WATCOM_CompilerOptions := devCompiler.OptionStr;
    IncludeVersionInfo := False;
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
  end;
end;

procedure AssignOptionsRec(var R1, R2: TProjOptions);
begin
  with R2 do
  begin
    typ := R1.typ;
    Ver := r1.ver;
    //Objfiles.Text := r1.ObjFiles.Text;

 {$IFDEF WX_BUILD}
    Includes.Text := StringReplace(R1.Includes.Text,
         '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);
    Libs.Text := StringReplace(R1.Libs.Text,
         '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);
    PrivateResource := StringReplace(R1.PrivateResource,
      '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);
    ResourceIncludes.Text := StringReplace(R1.ResourceIncludes.Text,
          '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);
    MakeIncludes.Text := StringReplace(R1.MakeIncludes.Text,
       '%DEVCPP_DIR%', devDirs.Exec, [rfReplaceAll]);
 {$ELSE}
    Includes.Text := R1.Includes.Text;
    Libs.Text := R1.Libs.Text;
    PrivateResource := R1.PrivateResource;
    ResourceIncludes.Text := R1.ResourceIncludes.Text;
    MakeIncludes.Text := R1.MakeIncludes.Text;
 {$ENDIF}

    cmdLines.GCC_Compiler := R1.cmdLines.GCC_Compiler;
    cmdLines.GCC_CppCompiler := R1.cmdLines.GCC_CppCompiler;
    cmdLines.GCC_Linker := R1.cmdLines.GCC_Linker;
    GCC_PreprocDefines := R1.GCC_PreprocDefines;
    GCC_CompilerOptions := R1.GCC_CompilerOptions;

    cmdLines.VC2005_Compiler := R1.cmdLines.VC2005_Compiler;
    cmdLines.VC2005_CppCompiler := R1.cmdLines.VC2005_CppCompiler;
    cmdLines.VC2005_Linker := R1.cmdLines.VC2005_Linker;
    VC2005_PreprocDefines := R1.VC2005_PreprocDefines;
    VC2005_CompilerOptions := R1.VC2005_CompilerOptions;

    cmdLines.VC2003_Compiler := R1.cmdLines.VC2003_Compiler;
    cmdLines.VC2003_CppCompiler := R1.cmdLines.VC2003_CppCompiler;
    cmdLines.VC2003_Linker := R1.cmdLines.VC2003_Linker;
    VC2003_PreprocDefines := R1.VC2003_PreprocDefines;
    VC2003_CompilerOptions := R1.VC2003_CompilerOptions;

    cmdLines.VC6_Compiler := R1.cmdLines.VC6_Compiler;
    cmdLines.VC6_CppCompiler := R1.cmdLines.VC6_CppCompiler;
    cmdLines.VC6_Linker := R1.cmdLines.VC6_Linker;
    VC6_PreprocDefines := R1.VC6_PreprocDefines;
    VC6_CompilerOptions := R1.VC6_CompilerOptions;

    cmdLines.DMARS_Compiler := R1.cmdLines.DMARS_Compiler;
    cmdLines.DMARS_CppCompiler := R1.cmdLines.DMARS_CppCompiler;
    cmdLines.DMARS_Linker := R1.cmdLines.DMARS_Linker;
    DMARS_PreprocDefines := R1.DMARS_PreprocDefines;
    DMARS_CompilerOptions := R1.DMARS_CompilerOptions;

    cmdLines.BORLAND_Compiler := R1.cmdLines.BORLAND_Compiler;
    cmdLines.BORLAND_CppCompiler := R1.cmdLines.BORLAND_CppCompiler;
    cmdLines.BORLAND_Linker := R1.cmdLines.BORLAND_Linker;
    BORLAND_PreprocDefines := R1.BORLAND_PreprocDefines;
    BORLAND_CompilerOptions := R1.BORLAND_CompilerOptions;

    cmdLines.WATCOM_Compiler := R1.cmdLines.WATCOM_Compiler;
    cmdLines.WATCOM_CppCompiler := R1.cmdLines.WATCOM_CppCompiler;
    cmdLines.WATCOM_Linker := R1.cmdLines.WATCOM_Linker;
    WATCOM_PreprocDefines := R1.WATCOM_PreprocDefines;
    WATCOM_CompilerOptions := R1.WATCOM_CompilerOptions;

    useGPP := R1.useGPP;
    icon := R1.icon;
    ExeOutput := R1.ExeOutput;
    ObjectOutput := R1.ObjectOutput;
    HostApplication := R1.HostApplication;
    IncludeVersionInfo := R1.IncludeVersionInfo;
    SupportXPThemes := R1.SupportXPThemes;
    CompilerSet := R1.CompilerSet;
    VersionInfo := R1.VersionInfo;
  end;
end;
*)
end.

