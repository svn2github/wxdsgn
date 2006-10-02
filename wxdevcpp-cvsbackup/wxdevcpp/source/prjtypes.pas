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
  ,SysUtils
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

  TProjOptions = record
    typ: TProjType;
    Ver: integer;
    Objfiles: TStrings;

    cmdLines: record
      GCC_Compiler: string;
      GCC_CppCompiler: string;
      GCC_Linker: string;
      VC_Compiler: string;
      VC_CppCompiler: string;
      VC_Linker: string;
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
    CompilerOptions: string;
    VersionInfo: TProjVersionInfo;

    GCC_PreprocDefines: string;
    VC_PreprocDefines: string;
    DMARS_PreprocDefines: string;
    BORLAND_PreprocDefines: string;
    WATCOM_PreprocDefines: string;
  end;

procedure InitOptionsRec(var Rec: TProjOptions);
procedure AssignOptionsRec(var R1, R2: TProjOptions);

implementation

uses 
  devcfg;

procedure InitOptionsRec(var Rec: TProjOptions);
begin
  with Rec do
  begin
    Includes := TStringList.Create;
    Libs := TStringList.Create;
    ResourceIncludes := TStringList.Create;
    MakeIncludes := TStringList.Create;
    ObjFiles := TStringList.Create;
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
end;

procedure AssignOptionsRec(var R1, R2: TProjOptions);
begin
  with R2 do
  begin
    typ := R1.typ;
    Ver := r1.ver;
    Objfiles.Text := r1.ObjFiles.Text;

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
    
    cmdLines.VC_Compiler := R1.cmdLines.VC_Compiler;
    cmdLines.VC_CppCompiler := R1.cmdLines.VC_CppCompiler;
    cmdLines.VC_Linker := R1.cmdLines.VC_Linker;
    VC_PreprocDefines := R1.VC_PreprocDefines;
    
    cmdLines.DMARS_Compiler := R1.cmdLines.DMARS_Compiler;
    cmdLines.DMARS_CppCompiler := R1.cmdLines.DMARS_CppCompiler;
    cmdLines.DMARS_Linker := R1.cmdLines.DMARS_Linker;
    DMARS_PreprocDefines := R1.DMARS_PreprocDefines;
    
    cmdLines.BORLAND_Compiler := R1.cmdLines.BORLAND_Compiler;
    cmdLines.BORLAND_CppCompiler := R1.cmdLines.BORLAND_CppCompiler;
    cmdLines.BORLAND_Linker := R1.cmdLines.BORLAND_Linker;
    BORLAND_PreprocDefines := R1.BORLAND_PreprocDefines;
    
    cmdLines.WATCOM_Compiler := R1.cmdLines.WATCOM_Compiler;
    cmdLines.WATCOM_CppCompiler := R1.cmdLines.WATCOM_CppCompiler;
    cmdLines.WATCOM_Linker := R1.cmdLines.WATCOM_Linker;
    WATCOM_PreprocDefines := R1.WATCOM_PreprocDefines;
                    
    useGPP := R1.useGPP;
    icon := R1.icon;
    ExeOutput := R1.ExeOutput;
    ObjectOutput := R1.ObjectOutput;
    HostApplication := R1.HostApplication;
    IncludeVersionInfo := R1.IncludeVersionInfo;
    SupportXPThemes := R1.SupportXPThemes;
    CompilerSet := R1.CompilerSet;
    CompilerOptions := R1.CompilerOptions;
    VersionInfo := R1.VersionInfo;
  end;
end;

end.

