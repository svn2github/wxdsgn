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

Unit prjtypes;

Interface

Uses
{$IFDEF WIN32}
    Classes, editor, ComCtrls, datamod
{$ENDIF}
{$IFDEF LINUX}
  Classes, editor, QComCtrls, datamod
{$ENDIF}
{$IFDEF PLUGIN_BUILD}
    , SysUtils, Contnrs
{$ENDIF}
    ;
Const
    dptGUI = 0;
    dptCon = 1;
    dptStat = 2;
    dptDyn = 3;

Type
    TProjType = Byte;
    TProjTypeSet = Set Of TProjType;

    TProjVersionInfo = Record
        Major: Integer;
        Minor: Integer;
        Release: Integer;
        Build: Integer;
        LanguageID: Integer;
        CharsetID: Integer;
        CompanyName: String;
        FileVersion: String;
        FileDescription: String;
        InternalName: String;
        LegalCopyright: String;
        LegalTrademarks: String;
        OriginalFilename: String;
        ProductName: String;
        ProductVersion: String;
        AutoIncBuildNrOnCompile: Boolean;
        AutoIncBuildNrOnRebuild: Boolean;
    End;

    TProjProfile = Class
    Public
        ProfileName: String;
        typ: TProjType;
        compilerType: Integer;
        Objfiles: TStringList;
        Compiler: String;
        CppCompiler: String;
        Linker: String;
        Includes: TStringList;
        Libs: TStringList;
        PrivateResource: String; // Dev-C++ will overwrite this file
        ResourceIncludes: TStringList;
        MakeIncludes: TStringList;
        Icon: String;
        ExeOutput: String;
        ImagesOutput: String;
        ObjectOutput: String;
        OverrideOutput: Boolean;
        OverridenOutput: String;
        HostApplication: String;
        IncludeVersionInfo: Boolean;
        SupportXPThemes: Boolean;
        CompilerSet: Integer;
        CompilerOptions: String;
        PreprocDefines: String;
        //New Items From Project
        UseCustomMakefile: Boolean;
        CustomMakefile: String;

        Constructor Create;
        Destructor Destroy; Override;
        Procedure CopyProfileFrom(R1: TProjProfile);
    End;

    TProjectProfileList = Class
    Private
        fList: TObjectList;
        fVer: Integer;
        fuseGpp: Boolean;
        Function GetCount: Integer;
        Function GetItem(index: Integer): TProjProfile;
        Procedure SetItem(index: Integer; value: TProjProfile);
    Public
        Constructor Create;
        Destructor Destroy; Override;
        Procedure CopyDataFrom(ProfileList: TProjectProfileList);
        Function Add(aprofile: TProjProfile): Integer;
        Procedure Remove(index: Integer);
        Procedure Clear;

        Property Items[index: Integer]: TProjProfile Read GetItem Write SetItem;
            Default;
        Property Count: Integer Read GetCount;
        Property Ver: Integer Read fVer Write fVer;
        Property useGpp: Boolean Read fuseGpp Write fuseGpp;
    End;

Implementation

Uses
    devcfg;

Constructor TProjProfile.Create;
Begin
    Objfiles := TStringList.Create;
    Includes := TStringList.Create;
    Libs := TStringList.Create;
    ResourceIncludes := TStringList.Create;
    MakeIncludes := TStringList.Create;

    Includes.Delimiter := ';';
    Libs.Delimiter := ';';
    PrivateResource := '';
    ResourceIncludes.Delimiter := ';';
    MakeIncludes.Delimiter := ';';
    ObjFiles.Delimiter := ';';
    Icon := '';
    ExeOutput := '';
    ImagesOutput := 'Images\';
    ObjectOutput := '';
    HostApplication := '';
    SupportXPThemes := False;
    CompilerSet := 0;
    CompilerOptions := devCompiler.OptionStr;
    IncludeVersionInfo := False;

    typ := 0;
    compilerType := ID_COMPILER_MINGW;
    Compiler := '';
    CppCompiler := '';
    Linker := '';
    ObjFiles.DelimitedText := '';
    Includes.DelimitedText := '';
    Libs.DelimitedText := '';
    PrivateResource := '';
    ResourceIncludes.DelimitedText := '';
    MakeIncludes.DelimitedText := '';
    Icon := '';
    OverrideOutput := False;
    OverridenOutput := '';
    HostApplication := '';
    IncludeVersionInfo := False;
    SupportXPThemes := False;
    PreprocDefines := '';
End;

Destructor TProjProfile.Destroy;
Begin
    Objfiles.Free;
    Includes.Free;
    Libs.Free;
    ResourceIncludes.Free;
    MakeIncludes.Free;
End;

Procedure TProjProfile.CopyProfileFrom(R1: TProjProfile);
Begin
    ProfileName := R1.ProfileName;
    typ := R1.typ;
    Objfiles.Text := r1.ObjFiles.Text;
    Includes.Text := StringReplace(R1.Includes.Text, '%DEVCPP_DIR%',
        devDirs.Exec, [rfReplaceAll]);
    Libs.Text := StringReplace(R1.Libs.Text, '%DEVCPP_DIR%',
        devDirs.Exec, [rfReplaceAll]);
    PrivateResource := StringReplace(R1.PrivateResource, '%DEVCPP_DIR%',
        devDirs.Exec, [rfReplaceAll]);
    ResourceIncludes.Text :=
        StringReplace(R1.ResourceIncludes.Text, '%DEVCPP_DIR%',
        devDirs.Exec, [rfReplaceAll]);
    MakeIncludes.Text := StringReplace(R1.MakeIncludes.Text, '%DEVCPP_DIR%',
        devDirs.Exec, [rfReplaceAll]);

    Compiler := R1.Compiler;
    CppCompiler := R1.CppCompiler;
    Linker := R1.Linker;
    PreprocDefines := R1.PreprocDefines;
    CompilerOptions := R1.CompilerOptions;

    icon := R1.icon;
    ExeOutput := R1.ExeOutput;
    ImagesOutput := R1.ImagesOutput;
    ObjectOutput := R1.ObjectOutput;
    OverrideOutput := R1.OverrideOutput;
    OverridenOutput := R1.OverridenOutput;
    HostApplication := R1.HostApplication;
    IncludeVersionInfo := R1.IncludeVersionInfo;
    SupportXPThemes := R1.SupportXPThemes;
    CompilerSet := R1.CompilerSet;
    compilerType := R1.compilerType;
    UseCustomMakefile := R1.UseCustomMakefile;
    CustomMakefile := R1.CustomMakefile;
End;

{ TProjectProfileList }
Constructor TProjectProfileList.Create;
Begin
    Inherited Create;
    fList := TObjectList.Create;
End;

Destructor TProjectProfileList.Destroy;
Var
    idx: Integer;
Begin
    For idx := pred(fList.Count) Downto 0 Do
        Remove(0);
    fList.Free;
    Inherited;
End;

Function TProjectProfileList.Add(aprofile: TProjProfile): Integer;
Begin
    result := fList.Add(aprofile);
End;

Procedure TProjectProfileList.Remove(index: Integer);
Begin
    fList.Delete(index);
    fList.Pack;
    fList.Capacity := fList.Count;
End;

Procedure TProjectProfileList.Clear;
Var
    i: Integer;
Begin
    For i := Count - 1 Downto 0 Do
        Remove(i);
    // Self[i].Destroy;  EAB Comment: This change merged from JOEL's 1007 revision breaks new project creation. Reverted.
    //fList.Clear;
End;

Function TProjectProfileList.GetCount: Integer;
Begin
    result := fList.Count;
End;

Function TProjectProfileList.GetItem(index: Integer): TProjProfile;
Begin
    result := TProjProfile(fList[index]);
End;

Procedure TProjectProfileList.SetItem(index: Integer; value: TProjProfile);
Begin
    fList[index] := value;
End;

Procedure TProjectProfileList.CopyDataFrom(ProfileList: TProjectProfileList);
Var
    i: Integer;
    NewProfile: TProjProfile;
Begin
    self.Clear;

    Ver := ProfileList.ver;
    useGpp := ProfileList.useGpp;
    For i := 0 To ProfileList.Count - 1 Do
    Begin
        NewProfile := TProjProfile.Create;
        NewProfile.CopyProfileFrom(ProfileList[i]);
        Self.Add(NewProfile);
    End;
End;

End.
