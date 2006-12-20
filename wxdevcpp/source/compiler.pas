{
    $Id$

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

unit compiler;

interface
uses
xprocs,
{$IFDEF WIN32}
  Windows, SysUtils, Dialogs, StdCtrls, ComCtrls, Forms,
  devrun, version, project, utils, prjtypes, Classes, Graphics;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, QDialogs, QStdCtrls, QComCtrls, QForms,
  devrun, version, project, utils, prjtypes, Classes, QGraphics;
{$ENDIF}

const
  RmExe = 'rm -f';

type
  TLogEntryEvent = procedure(const msg: string) of object;
  TOutputEvent = procedure(const _Line, _Unit, _Message: string) of object;
  TSuccessEvent = procedure(const messages: integer) of object;

  TTarget = (ctNone, ctFile, ctProject);

  TCompiler = class
  private
    fOnLogEntry: TLogEntryEvent;
    fOnOutput: TOutputEvent;
    fOnResOutput: TOutputEvent;
    fOnSuccess: TSuccessEvent;
    fPerfectDepCheck: Boolean;
    fProject: TProject;
    fSourceFile: string;
    fRunParams: string;
    fMakefile: string;
    fTarget: TTarget;
    fErrCount: integer;
    DoCheckSyntax: Boolean;
    fWarnCount: integer;
    fSingleFile: boolean;
    fOriginalSet : integer;
    procedure DoLogEntry(const msg: string);
    procedure DoOutput(const s, s2, s3: string);
    procedure DoResOutput(const s, s2, s3: string);
    function GetMakeFile: string;
    function GetCompiling: Boolean;
    procedure InitProgressForm(Status: string);
    procedure EndProgressForm;
    procedure ReleaseProgressForm;
    procedure ProcessProgressForm(Line: string);
    function SwitchToProjectCompilerSet: integer; // returns the original compiler set
    procedure SwitchToOriginalCompilerSet; // switches the original compiler set to index
    procedure SetProject(Project: TProject);
  public
    OnCompilationEnded: procedure(Sender: TObject) of object;

    procedure BuildMakeFile;
    procedure CheckSyntax; virtual;
    procedure Compile(SingleFile: string = ''); virtual;
    function Clean: Boolean; virtual;
    function RebuildAll: Boolean; virtual;
    procedure ShowResults; virtual;
    function FindDeps(TheFile: String): String; Overload;
    function FindDeps(TheFile: String; var VisitedFiles: TStringList): String; Overload;
    function UpToDate: Boolean;

    property Compiling: Boolean read GetCompiling;
    property Project: TProject read fProject write SetProject;
    property OnLogEntry: TLogEntryEvent read fOnLogEntry write fOnLogEntry;
    property OnOutput: TOutputEvent read fOnOutput write fOnOutput;
    property OnResOutput: TOutputEvent read fOnResOutput write fOnResOutput;
    property OnSuccess: TSuccessEvent read fOnSuccess write fOnSuccess;
    property SourceFile: string read fSourceFile write fSourceFile;
    property PerfectDepCheck: Boolean read fPerfectDepCheck write fPerfectDepCheck;
    property RunParams: string read fRunParams write fRunParams;
    property MakeFile: string read GetMakeFile write fMakeFile;
    property Target: TTarget read fTarget write fTarget;
    property ErrorCount: integer read fErrCount;
    procedure OnAbortCompile(Sender: TObject);
    procedure AbortThread;
    procedure ParseLine(Line: String);
  protected
    fCompileParams: string;
    fCppCompileParams: string;
    fLibrariesParams: string;
    fIncludesParams: string;
    fCppIncludesParams: string;
    fRcIncludesParams: string;
    fBinDirs: string;
    fUserParams: string;
    fDevRun: TDevRun;
    fAbortThread: boolean;
    
    procedure CreateMakefile; virtual;
    procedure CreateStaticMakefile; virtual;
    procedure CreateDynamicMakefile; virtual;
    procedure GetCompileParams; virtual;
    procedure GetLibrariesParams; virtual;
    procedure GetIncludesParams; virtual;
    procedure LaunchThread(s, dir: string); virtual;
    procedure ThreadCheckAbort(var AbortThread: boolean); virtual;
    procedure OnCompilationTerminated(Sender: TObject); virtual;
    procedure OnLineOutput(Sender: TObject; const Line: String); virtual;
    procedure ParseResults; virtual;
    function NewMakeFile(var F: TextFile): boolean; virtual;
    procedure WriteMakeClean(var F: TextFile); virtual;
    procedure WriteMakeObjFilesRules(var F: TextFile); virtual;
    function PreProcDefines: string;
  published
    constructor Create;
  end;

implementation

uses
  MultiLangSupport, devcfg, Macros, devExec, CompileProgressFm, StrUtils, RegExpr,
  DbugIntf, SynEdit, SynEditHighlighter, SynEditTypes, datamod;

constructor TCompiler.Create;
begin
  fOriginalSet := -1;
end;

procedure TCompiler.DoLogEntry(const msg: string);
begin
  if assigned(fOnLogEntry) then
    fOnLogEntry(msg);
end;

procedure TCompiler.DoOutput(const s, s2, s3: string);
begin
  if assigned(fOnOutput) then
    fOnOutput(s, s2, s3);
end;

procedure TCompiler.DoResOutput(const s, s2, s3: string);
begin
  if assigned(fOnResOutput) then
    fOnResOutput(s, s2, s3);
end;

function TCompiler.GetMakeFile: string;
begin
  if not FileExists(fMakeFile) then
    BuildMakeFile;
  result := fMakefile;
end;

// create makefile for fproject if assigned
procedure TCompiler.BuildMakeFile;
begin
  if not assigned(fProject) then
  begin
    fMakeFile := '';
    exit;
  end
  else begin
    if fProject.CurrentProfile.UseCustomMakefile then begin
      fMakefile := fProject.CurrentProfile.CustomMakefile;
      Exit;
    end;
  end;
  if Assigned(CompileProgressForm) then
    CompileProgressForm.btnClose.Enabled := False;
  case Project.CurrentProfile.typ of
    dptStat: CreateStaticMakeFile;
    dptDyn: CreateDynamicMakeFile;
  else
    CreateMakeFile;    
  end;
  if FileExists(fMakeFile) then
    FileSetDate(fMakefile, DateTimeToFileDate(Now)); // fix the "Clock skew detected" warning ;)
  if Assigned(CompileProgressForm) then
    CompileProgressForm.btnClose.Enabled := True;
end;

function TCompiler.NewMakeFile(var F: TextFile): boolean;
const
  cAppendStr = '%s %s';

var
  ObjResFile, Objects, LinkObjects, Comp_ProgCpp, Comp_Prog, tfile: string;
  i: integer;
begin
  Objects := '';

  // create the object output directory if we have to
  if (fProject.CurrentProfile.ObjectOutput <> '') and (not DirectoryExists(fProject.CurrentProfile.ObjectOutput)) then
    ForceDirectories(GetRealPath(SubstituteMakeParams(fProject.CurrentProfile.ObjectOutput), fProject.Directory));

  for i := 0 to Pred(fProject.Units.Count) do
  begin
    if (GetFileTyp(fProject.Units[i].FileName) = utRes) or
       ((not fProject.Units[i].Compile) and (not fProject.Units[i].Link)) then
      Continue;

    if fProject.CurrentProfile.ObjectOutput <> '' then
    begin
      tfile := IncludeTrailingPathDelimiter(fProject.CurrentProfile.ObjectOutput) + ExtractFileName(fProject.Units[i].FileName);
      tfile := ExtractRelativePath(fProject.FileName, tfile);
    end
    else
      tfile := ExtractRelativePath(fProject.FileName, fProject.Units[i].FileName);

    if GetFileTyp(tfile) <> utHead then
    begin
      Objects := Format(cAppendStr, [Objects, GenMakePath2(ChangeFileExt(tfile, OBJ_EXT))]);
      if fProject.Units[i].Link then
        LinkObjects := Format(cAppendStr, [LinkObjects, GenMakePath(ChangeFileExt(tfile, OBJ_EXT))]);
    end
    else if (devCompiler.CompilerType = ID_COMPILER_MINGW) and (I = fProject.PchHead) then
      Objects := Format(cAppendStr, [Objects, GenMakePath2(ChangeFileExt(ExtractRelativePath(fProject.FileName, fProject.Units[i].FileName), PCH_EXT))]);
  end;

  if Length(fProject.CurrentProfile.PrivateResource) = 0 then
    ObjResFile := ''
  else
  begin
    if fProject.CurrentProfile.ObjectOutput <> '' then begin
      ObjResFile := ChangeFileExt(fProject.CurrentProfile.PrivateResource, RES_EXT);
      ObjResFile := ExtractRelativePath(fProject.FileName, ObjResFile);
    end
    else
      ObjResFile := ExtractRelativePath(fProject.FileName, ChangeFileExt(fProject.CurrentProfile.PrivateResource, RES_EXT));

    //Make the resource file into a usable path
    LinkObjects := Format(cAppendStr, [LinkObjects, GenMakePath(ObjResFile)]);
    Objects := Format(cAppendStr, [Objects, GenMakePath2(ObjResFile)]);
  end;

  if devCompiler.gppName <> '' then
    if devCompiler.compilerType in ID_COMPILER_VC then
      Comp_ProgCpp := devCompiler.gppName + ' /nologo'
    else
      Comp_ProgCpp := devCompiler.gppName
  else
    Comp_ProgCpp := CPP_PROGRAM(devCompiler.CompilerType);

  if devCompiler.gccName <> '' then
    if devCompiler.compilerType in ID_COMPILER_VC then
      Comp_Prog := devCompiler.gccName + ' /nologo'
    else
      Comp_Prog := devCompiler.gccName
  else
    Comp_Prog := CP_PROGRAM(devCompiler.CompilerType);

  GetCompileParams;
  GetLibrariesParams;
  GetIncludesParams;

  fMakefile := fProject.Directory + DEV_MAKE_FILE;
  OnLineOutput(nil, 'Building Makefile: "' + fMakefile + '"');
  Assignfile(F, fMakefile);
  try
    Rewrite(F);
  except
    on E: Exception do
    begin
      MessageDlg('Could not create Makefile: "' + fMakefile + '"'
        + #13#10 + E.Message, mtError, [mbOK], 0);
      result := false;
      exit;
    end;
  end;
  result := true;
  writeln(F, '# Project: ' + fProject.Name);
  writeln(F, '# Compiler: ' + devCompiler.Name);
  case devCompiler.CompilerType of
    ID_COMPILER_MINGW : writeln(F, '# Compiler Type: MingW 3');
    ID_COMPILER_VC6    : writeln(F, '# Compiler Type: Visual C++ 6');
    ID_COMPILER_VC2003   : writeln(F, '# Compiler Type: Visual C++ .NET 2003');    
    ID_COMPILER_VC2005: writeln(F, '# Compiler Type: Visual C++ 2005');
    ID_COMPILER_DMARS : writeln(F, '# Compiler Type: Digital Mars');
    ID_COMPILER_BORLAND    : writeln(F, '# Compiler Type: Borland C++ 5.5');
    ID_COMPILER_WATCOM: writeln(F, '# Compiler Type: OpenWatCom');
  end;
  writeln(F, Format('# Makefile created by %s %s on %s',
                    [DEVCPP, DEVCPP_VERSION, FormatDateTime('dd/mm/yy hh:nn', Now)]));
  
  if DoCheckSyntax then
  begin
    writeln(F, '# This Makefile is written for syntax check!');
    writeln(F, '# Regenerate it if you want to use this Makefile to build.');
  end;
  writeln(F);
  writeln(F, 'CPP       = ' + Comp_ProgCpp);
  writeln(F, 'CC        = ' + Comp_Prog);
  if (devCompiler.windresName <> '') then
    writeln(F, 'WINDRES   = ' + devCompiler.windresName)
  else
    writeln(F, 'WINDRES   = ' + RES_PROGRAM(devCompiler.CompilerType));
  writeln(F, 'OBJ       =' + Objects);
  writeln(F, 'LINKOBJ   =' + LinkObjects);
  writeln(F, 'LIBS      =' + StringReplace(fLibrariesParams, '\', '/', [rfReplaceAll]));
  writeln(F, 'INCS      =' + StringReplace(fIncludesParams, '\', '/', [rfReplaceAll]));
  writeln(F, 'CXXINCS   =' + StringReplace(fCppIncludesParams, '\', '/', [rfReplaceAll]));
  writeln(F, 'RCINCS    =' + StringReplace(fRcIncludesParams, '\', '/', [rfReplaceAll]));
  writeln(F, 'BIN       = ' + GenMakePath2(ExtractRelativePath(Makefile, fProject.Executable)));
  writeln(F, 'DEFINES   = ' + PreprocDefines);
  writeln(F, 'CXXFLAGS  = $(CXXINCS) $(DEFINES) ' + fCppCompileParams);
  writeln(F, 'CFLAGS    = $(INCS) $(DEFINES) ' + fCompileParams);
  writeln(F, 'GPROF     = ' + devCompilerSet.gprofName);
  writeln(F, 'RM        = ' + RmExe);

  if devCompiler.CompilerType in ID_COMPILER_VC then
    if (assigned(fProject) and (fProject.CurrentProfile.typ = dptStat)) then
      writeln(F, 'LINK      = ' + devCompiler.dllwrapName)
    else
    begin
      if devCompiler.CompilerType = ID_COMPILER_VC2005 then
        writeln(F, 'LINK      = ' + devCompiler.dllwrapName + ' /nologo /manifest')
      else
        writeln(F, 'LINK      = ' + devCompiler.dllwrapName + ' /nologo');
    end
  else if devCompiler.CompilerType = ID_COMPILER_MINGW then
    if (assigned(fProject) and (fProject.CurrentProfile.typ = dptStat)) then
      writeln(F, 'LINK      = ar')
    else if fProject.Profiles.useGPP then
      writeln(F, 'LINK      = ' + Comp_ProgCpp)
    else
      writeln(F, 'LINK      = ' + Comp_Prog);

  Writeln(F, '');
  if DoCheckSyntax then
    Writeln(F,'.PHONY: all all-before all-after clean clean-custom $(OBJ) $(BIN)')
  else
    Writeln(F, '.PHONY: all all-before all-after clean clean-custom');
  Writeln(F, 'all: all-before $(BIN) all-after');
  Writeln(F, '');

  for i := 0 to fProject.CurrentProfile.MakeIncludes.Count - 1 do
  begin
    Writeln(F, 'include ' +
      GenMakePath(fProject.CurrentProfile.MakeIncludes.Strings[i]));
  end;

  WriteMakeClean(F);
  writeln(F);
end;

function TCompiler.FindDeps(TheFile: String): String;
var
  Visited: TStringList;
begin
  try
    Visited := TStringList.Create;
    Result := FindDeps(TheFile, Visited);
  finally
    Visited.Destroy;
  end;
end;

function TCompiler.FindDeps(TheFile: String; var VisitedFiles: TStringList): String;
var
  Editor: TSynEdit;
  i, Start: integer;
  Includes: TStringList;
  Token, Quote, FilePath: string;
  Attri: TSynHighlighterAttributes;

  function StartsStr(start: string; str: string) : Boolean;
  var
    i: integer;
  begin
    //Skip whitespace
    Result := False;
    for i := 1 to Length(str) - 1 do
    begin
      if str[i] in [' ', #9, #13, #10] then
        continue;

      //OK, no more whitespace, see if we start the string
      Result := Copy(str, i, Length(start)) = start;
      Exit;
    end;
  end;
begin;
  Result := '';
  Includes := nil;

  //First check that we have not been visited
  if VisitedFiles.IndexOf(TheFile) <> -1 then
    Exit;

  //Otherwise mark ourselves as visited
  Editor := TSynEdit.Create(Application);
  Editor.Highlighter := dmMain.Cpp;
  VisitedFiles.Add(TheFile);
  Application.ProcessMessages;
  
  try
    //Load the lines of the file
    Includes := TStringList.Create;
    Editor.Lines.LoadFromFile(TheFile);

    //Iterate over the lines of the file
    for i := 0 to Editor.Lines.Count - 1 do
      if StartsStr('#', Editor.Lines[i]) then
      begin
        Start := Pos('#', Editor.Lines[i]);
        Editor.GetHighlighterAttriAtRowCol(BufferCoord(start, i + 1), Token, Attri);

        //Is it a preprocessor directive?
        if Attri.Name <> 'Preprocessor' then
          Continue;

        //Is it an include?
        Token := Trim(Copy(Token, 2, Length(Token))); //copy after #
        if not AnsiStartsStr('include', Token) then
          Continue;

        //Extract the include filename
        Token := Copy(Token, Pos('include', Token) + 7, Length(Token)); //copy after 'include'
        Token := Trim(Token);

        //Extract the type of closing quote
        quote := Token[1];
        if quote = '<' then
          quote := '>';

        //Remove the start and close quotes
        Token := Copy(Token, 2, Length(Token));
        Token := Copy(Token, 1, Pos(quote, Token) - 1); //Remove "" or <>

        //Now that tempstr contains the path, does it exist, hence we can depend on it?
        FilePath := GetRealPath(Token, ExtractFilePath(TheFile));
        if not FileExists(FilePath) then
          Continue;

        //When we do get here, the file does exist. Convert the path to the one relative to the makefile
        Result := Result + ' ' + GenMakePath2(ExtractRelativePath(fProject.Directory, FilePath));

        //Recurse into the include
        Result := result + FindDeps(FilePath, VisitedFiles);
      end;

  finally
    if Assigned (Includes) then
      Includes.Destroy;
    Editor.Free;
  end;
end;

procedure TCompiler.WriteMakeObjFilesRules(var F: TextFile);
var
  i: integer;
  RCDir: String;
  PCHObj, PCHFile, PCHHead: String;
  tfile, ofile, ResFiles, tmp: string;
begin
  //Calculate the PCH file for this project
  PCHFile := '';
  PCHHead := '';
  PCHObj := '';

  try
    if devCompiler.CompilerType = ID_COMPILER_MINGW then
    begin
      if fProject.PchHead <> -1 then
      begin
        PCHObj := GenMakePath2(ExtractRelativePath(Makefile, GetRealPath(ChangeFileExt(fProject.Units[fProject.PchHead].FileName, PCH_EXT), fProject.Directory)));
        PCHHead := ExtractRelativePath(fProject.Directory, fProject.Units[fProject.PchHead].FileName);
        PCHFile := GenMakePath(ExtractFileName(PCHHead) + PCH_EXT);
      end;
    end
    else
    begin
      if (fProject.PchHead <> -1) and (fProject.PchSource <> -1) then
      begin
        if fProject.CurrentProfile.ObjectOutput <> '' then
        begin
          PCHObj := IncludeTrailingPathDelimiter(fProject.CurrentProfile.ObjectOutput);
          PCHFile := PCHObj;
        end;
        PCHObj := GenMakePath2(PCHObj + ExtractRelativePath(Makefile, GetRealPath(ChangeFileExt(fProject.Units[fProject.PchSource].FileName, OBJ_EXT), fProject.Directory)));
        PCHHead := ExtractRelativePath(fProject.Directory, fProject.Units[fProject.PchHead].FileName);
        PCHFile := GenMakePath(PCHFile + ExtractFileName(PCHHead) + PCH_EXT);
      end
      else if (fProject.PchHead <> -1) or (fProject.PchSource <> -1) then
      begin
        DoOutput('', '', Format(Lang[ID_COMPMSG_MAKEFILEWARNING], [Lang[ID_COMPMSG_PCHINCOMPLETE]]));
        Inc(fWarnCount);
      end;
    end;
  except
    on e: Exception do
      if devCompiler.CompilerType in ID_COMPILER_VC then
      begin
        DoOutput('', '', Format(Lang[ID_COMPMSG_MAKEFILEWARNING], [Lang[ID_COMPMSG_PCHINCOMPLETE]]));
        Inc(fWarnCount);
      end;
  end;

  for i := 0 to pred(fProject.Units.Count) do
  begin
    if not fProject.Units[i].Compile then
      Continue;

    // skip resource files
    if GetFileTyp(fProject.Units[i].FileName) = utRes then
      Continue;

    tfile := fProject.Units[i].FileName;
    if FileSamePath(tfile, fProject.Directory) then
      tfile := ExtractFileName(tFile)
    else
      tfile := ExtractRelativePath(Makefile, tfile);

    if GetFileTyp(tfile) <> utHead then
    begin
      writeln(F);
      if fProject.CurrentProfile.ObjectOutput <> '' then
      begin
        ofile := IncludeTrailingPathDelimiter(fProject.CurrentProfile.ObjectOutput) + ExtractFileName(fProject.Units[i].FileName);
        ofile := ExtractRelativePath(fProject.FileName, ChangeFileExt(ofile, OBJ_EXT));
      end
      else
        ofile := ChangeFileExt(tfile, OBJ_EXT);

      if DoCheckSyntax then
      begin
        writeln(F, GenMakePath2(ofile) + ':' + GenMakePath2(tfile));

        if fProject.Units[i].CompileCpp then
          writeln(F, #9'$(CPP) ' + format(devCompiler.CheckSyntaxFormat, [GenMakePath(tfile)]) + ' $(CXXFLAGS)')
        else
          writeln(F, #9'$(CC) ' + format(devCompiler.CheckSyntaxFormat, [GenMakePath(tfile)]) + ' $(CFLAGS)');
      end
      else
      begin
        if (PCHObj <> '') and (((devCompiler.CompilerType in ID_COMPILER_VC) and
           (I <> fProject.PchSource)) or (not (devCompiler.CompilerType in ID_COMPILER_VC))) then
          tmp := PCHObj + ' '
        else
          tmp := '';

        if PerfectDepCheck and not fSingleFile then
          writeln(F, GenMakePath2(ofile) + ': $(GLOBALDEPS) ' + tmp + GenMakePath2(tfile) + FindDeps(fProject.Directory + tfile))
        else
          writeln(F, GenMakePath2(ofile) + ': $(GLOBALDEPS) ' + tmp + GenMakePath2(tfile));

        if fProject.Units[i].OverrideBuildCmd and (fProject.Units[i].BuildCmd <> '') then  begin
          tmp := fProject.Units[i].BuildCmd;
          tmp := StringReplace(tmp, '<CRTAB>', #10#9, [rfReplaceAll]);
          writeln(F, #9 + tmp);
        end
        else
        begin
          //Decide on whether we pass a PCH creation or usage argument
          with devCompiler do
          begin
            tmp := '';
            if CompilerType in ID_COMPILER_VC then
            begin
              if PCHHead <> '' then
              begin
                if I <> fProject.PchSource then
                  tmp := PchUseFormat
                else
                  tmp := PchCreateFormat;
                tmp := Format(' ' + tmp + ' ' + PchFileFormat, [GenMakePath(PCHHead), PCHFile]);
              end
            end;
          end;

          if fProject.Units[i].CompileCpp then
            writeln(F, #9 + '$(CPP) ' + format(devCompiler.OutputFormat, [GenMakePath(tfile), GenMakePath(ofile)]) + tmp + ' $(CXXFLAGS)')
          else
            writeln(F, #9 + '$(CC) ' + format(devCompiler.OutputFormat, [GenMakePath(tfile), GenMakePath(ofile)]) + tmp + ' $(CFLAGS)');
        end;
      end;
    end
    else if (devCompiler.CompilerType = ID_COMPILER_MINGW) and (I = fProject.PchHead) and (PchHead <> '') then
    begin
      if not DoCheckSyntax then
      begin
        writeln(F);
        ofile := ChangeFileExt(tfile, '.h.gch');

        if PerfectDepCheck then
          writeln(F, GenMakePath2(ofile) + ': $(GLOBALDEPS) ' + tmp + GenMakePath2(tfile) + FindDeps(fProject.Directory + tfile))
        else
          writeln(F, GenMakePath2(ofile) + ': $(GLOBALDEPS) ' + tmp + GenMakePath2(tfile));

        if fProject.Units[i].OverrideBuildCmd and (fProject.Units[i].BuildCmd <> '') then  begin
          tmp := fProject.Units[i].BuildCmd;
          tmp := StringReplace(tmp, '<CRTAB>', #10#9, [rfReplaceAll]);
          writeln(F, #9 + tmp);
        end
        else
        begin
          //Decide on whether we pass a PCH creation or usage argument
          with devCompiler do
          begin
            if (PCHHead <> '') and (PchCreateFormat <> '') then
              tmp := Format(' ' + PchCreateFormat, [GenMakePath(PCHHead)])
            else
              tmp := '';
          end;

          if fProject.Units[i].CompileCpp then
            writeln(F, #9 + '$(CPP) ' + format(devCompiler.OutputFormat, [GenMakePath(tfile), GenMakePath(ofile)]) + tmp + ' $(CXXFLAGS)')
          else
            writeln(F, #9 + '$(CC) ' + format(devCompiler.OutputFormat, [GenMakePath(tfile), GenMakePath(ofile)]) + tmp + ' $(CFLAGS)');
        end;
      end;
    end;
  end;

  if (Length(fProject.CurrentProfile.PrivateResource) > 0) then
  begin
    ResFiles := '';
    for i := 0 to fProject.Units.Count - 1 do
    begin
      if GetFileTyp(fProject.Units[i].FileName) <> utRes then
        Continue;
      if FileExists(GetRealPath(fProject.Units[i].FileName, fProject.Directory)) then
        ResFiles := ResFiles + GenMakePath2(ExtractRelativePath(fProject.Directory,
                                            fProject.Units[i].FileName)) + ' ';
    end;
    writeln(F);

    //Get the path of the resource
    ofile := ChangeFileExt(fProject.CurrentProfile.PrivateResource, RES_EXT);
    if (fProject.CurrentProfile.ObjectOutput <> '') then
      RCDir := fProject.CurrentProfile.ObjectOutput
    else
      RCDir := fProject.Directory;
    RCDir := IncludeTrailingPathDelimiter(GetRealPath(RCDir, fProject.Directory));

    //Then get the path to the resource object relative to our project directory
    ofile := GenMakePath2(ExtractRelativePath(fProject.Directory, ofile));
    tfile := ExtractRelativePath(fProject.FileName, fProject.CurrentProfile.PrivateResource);

    writeln(F, ofile + ': ' + GenMakePath2(tfile) + ' ' + ResFiles);
    if devCompiler.CompilerType = ID_COMPILER_MINGW then
      writeln(F, #9 + '$(WINDRES) ' + format(devCompiler.ResourceFormat, [GenMakePath(ChangeFileExt(tfile, RES_EXT)) + ' $(RCINCS) ' + GenMakePath(GetShortName(tfile))]))
    else
      writeln(F, #9 + '$(WINDRES) ' + format(devCompiler.ResourceFormat, [GenMakePath(ChangeFileExt(tfile, RES_EXT)) + ' $(RCINCS) ' + GenMakePath(tfile)]))
  end;
end;

procedure TCompiler.WriteMakeClean(var F: TextFile);
begin
  Writeln(F, 'clean: clean-custom');
  Writeln(F, #9 + '$(RM) $(OBJ) $(BIN)');
end;

procedure TCompiler.CreateMakefile;
var
  F: TextFile;
begin
  if not NewMakeFile(F) then
    exit;
  writeln(F, '$(BIN): $(OBJ)');

  if not DoCheckSyntax then
  begin
    writeln(F, #9 + '$(LINK) $(LINKOBJ) ' + format(devCompiler.LinkerFormat, [ExtractRelativePath(Makefile,fProject.Executable)]) + ' $(LIBS)');
    if devCompiler.compilerType = ID_COMPILER_VC2005 then
    begin
      writeln(F, #9 + '$(GPROF) /nologo /manifest "' + ExtractRelativePath(Makefile,fProject.Executable) + '.manifest" /outputresource:"' + ExtractRelativePath(Makefile,fProject.Executable) + '"');
      writeln(F, #9 + '@$(RM) "' + ExtractRelativePath(Makefile,fProject.Executable) + '.manifest"');
    end;
  end;

  WriteMakeObjFilesRules(F);
  Flush(F);
  CloseFile(F);
end;

procedure TCompiler.CreateStaticMakefile;
var
  F: TextFile;
begin
  if not NewMakeFile(F) then
    exit;
  writeln(F, '$(BIN): $(OBJ)');
  if not DoCheckSyntax then
  begin
    if devCompiler.CompilerType <> ID_COMPILER_MINGW then
      writeln(F, #9 + '$(LINK) ' + format(devCompiler.LibFormat, ['$(BIN)']) + ' $(LINKOBJ) $(LIBS)')
    else
      writeln(F, #9 + '$(LINK) ' + format(devCompiler.LibFormat, ['$(BIN)']) + ' $(LINKOBJ)');
  end;
  WriteMakeObjFilesRules(F);
  Flush(F);
  CloseFile(F);
end;

procedure TCompiler.CreateDynamicMakefile;
var
  backward, forward: integer;
  F: TextFile;
  binary: string;
  pfile, tfile: string;
begin
  if not NewMakeFile(F) then
    exit;
  pfile := ExtractFilePath(Project.Executable);
  tfile := pfile + ExtractFileName(Project.Executable);
  if FileSamePath(tfile, Project.Directory) then
    tfile := ExtractFileName(tFile)
  else
    tfile := ExtractRelativePath(Makefile, tfile);

  //If we are MingW then change the library name to start with lib
  if devCompiler.CompilerType = ID_COMPILER_MINGW then
  begin
    Forward := GetLastPos('/', tfile);
    Backward := GetLastPos('\', tfile);
    if Backward > Forward then
      Insert('lib', tfile, Backward + 1)
    else
      Insert('lib', tfile, Forward + 1);
  end;

  writeln(F, '$(BIN): $(OBJ)');

  if not DoCheckSyntax then
  begin
    binary := GenMakePath(ExtractRelativePath(Makefile, fProject.Executable));
    if devCompiler.CompilerType = ID_COMPILER_MINGW then
      writeln(F, #9 + '$(LINK) -shared $(STATICLIB) $(LINKOBJ) $(LIBS) ' + format(devcompiler.DllFormat, [GenMakePath(ChangeFileExt(tfile, LIB_EXT)), binary]))
    else
      writeln(F, #9 + '$(LINK) ' + format(devcompiler.DllFormat, [GenMakePath(ChangeFileExt(tfile, '.lib')), binary]) + ' $(LINKOBJ) $(LIBS)');

    if devCompiler.compilerType = ID_COMPILER_VC2005 then
    begin
      writeln(F, #9 + '$(GPROF) /nologo /manifest "' + ExtractRelativePath(Makefile,fProject.Executable) + '.manifest" /outputresource:"' + ExtractRelativePath(Makefile,fProject.Executable) + ';#2"');
      writeln(F, #9 + '@rm "' + ExtractRelativePath(Makefile,fProject.Executable) + '.manifest"');
    end;
  end;

  WriteMakeObjFilesRules(F);
  Flush(F);
  CloseFile(F);
end;

procedure TCompiler.GetCompileParams;
  procedure AppendStr(var s: string; value: string);
  begin
    s := s + ' ' + value;
  end;
var
  I, val: integer;
begin
  { Check user's compiler options }
  with devCompiler do
  begin
    fCompileParams := '';
    fCppCompileParams := '';
    fUserParams := '';

    if Assigned(fProject) then begin
      fCppCompileParams := StringReplace(fProject.CurrentProfile.CppCompiler, '_@@_', ' ', [rfReplaceAll]);
      fCompileParams := StringReplace(fProject.CurrentProfile.Compiler, '_@@_',' ', [rfReplaceAll]);
    end;

    if CmdOpts <> '' then
      AppendStr(fUserParams, CmdOpts);
    AppendStr(fCompileParams, fUserParams);
    AppendStr(fCppCompileParams, fUserParams);

    for I := 0 to OptionsCount - 1 do
      // consider project specific options for the compiler
      if (Assigned(fProject) and (I < Length(fProject.CurrentProfile.CompilerOptions)) and
           not (fProject.CurrentProfile.typ in devCompiler.Options[I].optExcludeFromTypes)) or
         (not Assigned(fProject) and (Options[I].optValue > 0)) then
      begin
        if devCompiler.Options[I].optIsC then begin
          if Assigned(devCompiler.Options[I].optChoices) then begin
            if Assigned(fProject) then
              val := devCompiler.ConvertCharToValue(fProject.CurrentProfile.CompilerOptions[I+ 1])
            else
              val := devCompiler.Options[I].optValue;
            if (val > 0) and (val < devCompiler.Options[I].optChoices.Count) then
              AppendStr(fCompileParams, devCompiler.Options[I].optSetting + devCompiler.Options[I].optChoices.Values[devCompiler.Options[I].optChoices.Names[val]]);
          end
          else if (Assigned(fProject) and (StrToIntDef(fProject.CurrentProfile.CompilerOptions[I + 1], 0) = 1)) or (not Assigned(fProject)) then
            AppendStr(fCompileParams, devCompiler.Options[I].optSetting);
        end;
        if devCompiler.Options[I].optIsCpp then begin
          if Assigned(devCompiler.Options[I].optChoices) then begin
            if Assigned(fProject) then
              val := devCompiler.ConvertCharToValue(fProject.CurrentProfile.CompilerOptions[I+ 1])
            else
              val := devCompiler.Options[I].optValue;
            if (val > 0) and (val < devCompiler.Options[I].optChoices.Count) then
              AppendStr(fCppCompileParams, devCompiler.Options[I].optSetting + devCompiler.Options[I].optChoices.Values[devCompiler.Options[I].optChoices.Names[val]]);
          end
          else if (Assigned(fProject) and (StrToIntDef(fProject.CurrentProfile.CompilerOptions[I + 1], 0) = 1)) or (not Assigned(fProject)) then
            AppendStr(fCppCompileParams, devCompiler.Options[I].optSetting);
        end;
      end;

    fCompileParams := ParseMacros(fCompileParams);
    fCppCompileParams := ParseMacros(fCppCompileParams);
  end;
end;

procedure TCompiler.GetLibrariesParams;
var
  i, val: integer;
  cAppendStr : string;
begin
  fLibrariesParams := '';
  cAppendStr := '%s ' + devCompiler.LinkerPaths;
  fLibrariesParams := CommaStrToStr(devDirs.lib, cAppendStr);

  if devCompilerSet.LinkOpts <> '' then
    fLibrariesParams := fLibrariesParams + ' ' + devCompilerSet.LinkOpts;
  if (fTarget = ctProject) and assigned(fProject) then
  begin
    for i := 0 to pred(fProject.CurrentProfile.Libs.Count) do
      fLibrariesParams := format(cAppendStr, [fLibrariesParams, fProject.CurrentProfile.Libs[i]]);
    fLibrariesParams := fLibrariesParams + ' ' + StringReplace(fProject.CurrentProfile.Linker, '_@@_', ' ', [rfReplaceAll]);
  end;

  //TODO: lowjoel:What does this do?
  if (pos(' -pg', fCompileParams) <> 0) and (pos('-lgmon', fLibrariesParams) = 0) then
    fLibrariesParams := fLibrariesParams + ' -lgmon -pg ';

  fLibrariesParams := fLibrariesParams + ' ';
  for I := 0 to devCompiler.OptionsCount - 1 do
    // consider project specific options for the compiler
    if (
      Assigned(fProject) and
      (I < Length(fProject.CurrentProfile.CompilerOptions)) and
      not (fProject.CurrentProfile.typ in devCompiler.Options[I].optExcludeFromTypes)
      ) or
      // else global compiler options
    (not Assigned(fProject) and (devCompiler.Options[I].optValue > 0)) then begin
      if devCompiler.Options[I].optIsLinker then
        if Assigned(devCompiler.Options[I].optChoices) then begin
          if Assigned(fProject) then
            val :=devCompiler.ConvertCharToValue(fProject.CurrentProfile.CompilerOptions[I +1])
          else
            val := devCompiler.Options[I].optValue;
          if (val > 0) and (val < devCompiler.Options[I].optChoices.Count) then
              fLibrariesParams := fLibrariesParams
                + devCompiler.Options[I].optSetting + devCompiler.Options[I].optChoices.Values[devCompiler.Options[I].optChoices.Names[val]] + ' ';
        end
        else if (Assigned(fProject) and (StrToIntDef(fProject.CurrentProfile.CompilerOptions[I + 1], 0) = 1)) or (not Assigned(fProject)) then
            fLibrariesParams := fLibrariesParams
              + devCompiler.Options[I].optSetting + ' ';
    end;

end;

procedure TCompiler.GetIncludesParams;
var
  i: integer;
  cAppendStr, cRCString : string;
  strLst: TStringList;
begin
  fIncludesParams := '';
  fCppIncludesParams := '';
  cAppendStr := '%s ' + devCompiler.IncludeFormat;
  fIncludesParams := CommaStrToStr(devDirs.C, cAppendStr);
  fCppIncludesParams := CommaStrToStr(devDirs.Cpp, cAppendStr);

  strLst := TStringList.Create;
  strTokenToStrings(devDirs.RC, ';', strLst);
  cRCString := '';
  for i := 0 to strLst.Count - 1 do
    cRCString := cRCString + GetShortName(strLst.Strings[i]) + ';';
  fRcIncludesParams := CommaStrToStr(cRCString, '%s ' + devCompiler.ResourceIncludeFormat);
  strLst.Destroy;

  if (fTarget = ctProject) and assigned(fProject) then
  begin
    for i := 0 to pred(fProject.CurrentProfile.Includes.Count) do
      if directoryExists(fProject.CurrentProfile.Includes[i]) then begin
        fIncludesParams := format(cAppendStr, [fIncludesParams, fProject.CurrentProfile.Includes[i]]);
        fCppIncludesParams := format('%s ' + devCompiler.IncludeFormat, [fCppIncludesParams, fProject.CurrentProfile.Includes[i]]);
      end;
    for i := 0 to pred(fProject.CurrentProfile.ResourceIncludes.Count) do
      if directoryExists(fProject.CurrentProfile.ResourceIncludes[i]) then
        fRcIncludesParams := format(cAppendStr, [fRcIncludesParams, GetShortName(fProject.CurrentProfile.ResourceIncludes[i])]);
  end;
end;

function TCompiler.PreProcDefines: string;
var
i: integer;
values: TStringList;
tempvalues: string;
begin
  Result := '';
  if assigned(fProject) then
  begin
    values := TStringList.Create;
    tempvalues := StringReplace(fProject.CurrentProfile.PreprocDefines, '_@@_', #10, [rfReplaceAll]);
    strTokenToStrings(tempvalues, #10, values);

    for i := 0 to values.Count - 1 do
    begin
      Result := Result + ' ' + Format(devCompiler.PreprocDefines, [values[i]]);
    end;

    //Clean up
    values.Destroy;
  end;
end;

procedure TCompiler.ShowResults;
begin
  // display compile results dialog
end;

procedure TCompiler.CheckSyntax;
begin
  DoCheckSyntax := True;
  Compile;
  DoCheckSyntax := False;
end;

procedure TCompiler.Compile(SingleFile: string);
resourcestring
  cMakeLine = '%s -f "%s" all';
  cSingleFileMakeLine = '%s -f "%s" %s';
  cMake = ' make';
  cDots = '...';
var
  cmdline: string;
  s: string;
  ofile: string;
  cCmdLine: string;
begin
  cCmdLine := devCompiler.SingleCompile;
  fSingleFile := SingleFile <> '';
  if Assigned(fDevRun) then
  begin
    MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
    Exit;
  end;

  if fTarget = ctNone then exit;

  DoLogEntry(Format('%s: %s', [Lang[ID_COPT_COMPTAB], devCompilerSet.SetName(devCompiler.CompilerSet)]));

  InitProgressForm('Compiling...');

  GetCompileParams;
  GetLibrariesParams;
  GetIncludesParams;

  if fTarget = ctProject then
  begin
    BuildMakeFile;
    Application.ProcessMessages;

    if SingleFile <> '' then
    begin
      if fProject.CurrentProfile.ObjectOutput <> '' then
      begin
        ofile := IncludeTrailingPathDelimiter(fProject.CurrentProfile.ObjectOutput) + ExtractFileName(SingleFile);
        ofile := GenMakePath(ExtractRelativePath(fProject.FileName,ChangeFileExt(ofile, OBJ_EXT)));
      end
      else
        ofile := GenMakePath(ExtractRelativePath(fProject.FileName,ChangeFileExt(SingleFile, OBJ_EXT)));
      if (devCompiler.makeName <> '') then
        cmdline := format(cSingleFileMakeLine, [devCompiler.makeName, fMakeFile,ofile]) + ' ' + devCompiler.makeopts
      else
        cmdline := format(cSingleFileMakeLine, [MAKE_PROGRAM(devCompiler.CompilerType), fMakeFile, ofile]) + ' ' + devCompiler.makeopts;
    end
    else begin
      if (devCompiler.makeName <> '') then
        cmdline := format(cMakeLine, [devCompiler.makeName, fMakeFile]) + ' ' + devCompiler.makeopts
      else
        cmdline := format(cMakeLine, [MAKE_PROGRAM(devCompiler.CompilerType), fMakeFile]) + ' ' + devCompiler.makeopts;
    end;

    DoLogEntry(format(Lang[ID_EXECUTING], [cMake + cDots]));
    DoLogEntry(cmdline);
    Sleep(devCompiler.Delay);
    LaunchThread(cmdline, ExtractFilePath(Project.FileName));
  end
  else if (GetFileTyp(fSourceFile) = utRes) then begin
    if (devCompiler.windresName <> '') then
      s := devCompiler.windresName
    else
      s := RES_PROGRAM(devCompiler.CompilerType);
    
    cmdline := s + ' ' + GenMakePath(fSourceFile) + Format(devCompiler.ResourceFormat, [GenMakePath(ChangeFileExt(fSourceFile, OBJ_EXT))]);
    DoLogEntry(format(Lang[ID_EXECUTING], [' ' + s + cDots]));
    DoLogEntry(cmdline);
  end
  else begin
    if (GetFileTyp(fSourceFile) = utSrc) and
      (GetExTyp(fSourceFile) = utCppSrc) then
    begin
      if (devCompiler.gppName <> '') then
        s := devCompiler.gppName
      else
        s := CPP_PROGRAM(devCompiler.CompilerType);
      if DoCheckSyntax then
        cmdline := format(cCmdLine,
          [s, fSourceFile, 'nul', fCppCompileParams,
          fCppIncludesParams, fLibrariesParams])
      else
      begin
        if devCompiler.CompilerType in ID_COMPILER_VC then
          cmdline := format(cCmdLine,
            [s, fSourceFile, fCppCompileParams, fCppIncludesParams, fLibrariesParams])
        else
          cmdline := format(cCmdLine,
            [s, fSourceFile, ChangeFileExt(fSourceFile, EXE_EXT),
            fCppCompileParams, fCppIncludesParams, fLibrariesParams]);
      end;
      DoLogEntry(format(Lang[ID_EXECUTING], [' ' + s + cDots]));
      DoLogEntry(cmdline);
    end
    else
    begin
      if (devCompiler.gccName <> '') then
        s := devCompiler.gccName
      else
        s := CP_PROGRAM(devCompiler.CompilerType);
      if DoCheckSyntax then
        cmdline := format(cCmdLine,
          [s, fSourceFile, 'nul', fCompileParams,
          fIncludesParams, fLibrariesParams])
      else
        cmdline := format(cCmdLine,
          [s, fSourceFile, ChangeFileExt(fSourceFile, EXE_EXT),
          fCompileParams, fIncludesParams, fLibrariesParams]);
      DoLogEntry(format(Lang[ID_EXECUTING], [' ' + s + cDots]));
      DoLogEntry(cmdline);
    end;
    LaunchThread(cmdline, ExtractFilePath(fSourceFile));
  end;
end;

function TCompiler.Clean: Boolean;
const
  cCleanLine = '%s clean -f "%s" %s';
  cmsg = ' make clean';
var
  cmdLine: string;
  s: string;
begin
  fSingleFile := True; // fool clean; don't run deps checking since all we do is cleaning
  if Project <> nil then
  begin
    DoLogEntry(Format('%s: %s', [Lang[ID_COPT_COMPTAB], devCompilerSet.SetName(devCompiler.CompilerSet)]));
    Result := True;
    InitProgressForm('Cleaning...');
    BuildMakeFile;
    if not FileExists(fMakefile) then
    begin
      DoLogEntry(Lang[ID_ERR_NOMAKEFILE]);
      DoLogEntry(Lang[ID_ERR_CLEANFAILED]);
      MessageBox(Application.MainForm.Handle,
        PChar(Lang[ID_ERR_NOMAKEFILE]),
        PChar(Lang[ID_ERROR]), MB_OK or MB_ICONHAND);
      Result := False;
      Exit;
    end;

    DoLogEntry(Format(Lang[ID_EXECUTING], [cmsg]));
    if (devCompiler.makeName <> '') then
      s := devCompiler.makeName
    else
      s := MAKE_PROGRAM(devCompiler.CompilerType);
    cmdLine := Format(cCleanLine, [s, fMakeFile, devCompiler.MakeOpts]);
    LaunchThread(cmdLine, fProject.Directory);
  end else
    Result := False;
end;

function TCompiler.RebuildAll: Boolean;
const
  cCleanLine = '%s -f "%s" clean all';
  cmsg = ' make clean';
var
  cmdLine: string;
  s: string;
begin
  fSingleFile := True; // fool rebuild; don't run deps checking since all files will be rebuilt
  Result := True;

  DoLogEntry(Format('%s: %s', [Lang[ID_COPT_COMPTAB],devCompilerSet.SetName(devCompiler.CompilerSet)]));
  InitProgressForm('Rebuilding...');
  if Project <> nil then
  begin
    BuildMakeFile;
    if not FileExists(fMakefile) then
    begin
      DoLogEntry(Lang[ID_ERR_NOMAKEFILE]);
      DoLogEntry(Lang[ID_ERR_CLEANFAILED]);
      MessageBox(Application.MainForm.Handle,
        PChar(Lang[ID_ERR_NOMAKEFILE]),
        PChar(Lang[ID_ERROR]), MB_OK or MB_ICONERROR);
      Result := False;
      Exit;
    end;

    DoLogEntry(Format(Lang[ID_EXECUTING], [cmsg]));

    if (devCompiler.makeName <> '') then
      s := devCompiler.makeName
    else
      s := MAKE_PROGRAM(devCompiler.CompilerType);
    
    cmdLine := Format(cCleanLine, [s, fMakeFile]) + ' ' + devCompiler.makeopts;
    LaunchThread(cmdLine, fProject.Directory);
  end
  else
  begin
    Compile;
    Result := True;
  end;
end;

procedure TCompiler.LaunchThread(s, dir: string);
begin
  if Assigned(fDevRun) then
    MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0)
  else
  begin
    Application.ProcessMessages;
    fAbortThread := False;
    fDevRun := TDevRun.Create(true);
    fDevRun.Command := s;
    fDevRun.Directory := dir;
    fDevRun.OnTerminate := OnCompilationTerminated;
    fDevRun.OnLineOutput := OnLineOutput;
    fDevRun.OnCheckAbort := ThreadCheckAbort;
    fDevRun.FreeOnTerminate := True;
    fDevRun.Resume;
  end;
end;

procedure TCompiler.ThreadCheckAbort(var AbortThread: boolean);
begin
  AbortThread := fAbortThread;
end;

procedure TCompiler.AbortThread;
begin
  if not Assigned(fDevRun) then
    Exit;
  fAbortThread := True;
end;

procedure TCompiler.OnAbortCompile(Sender: TObject);
begin
  if Assigned(fDevRun) then  begin
    fAbortThread := True;
  end
  else
    ReleaseProgressForm;
end;

procedure TCompiler.OnCompilationTerminated(Sender: TObject);
begin
  ParseResults;
  EndProgressForm;
  DoLogEntry(Lang[ID_EXECUTIONTERM]);

  if fAbortThread then
    DoLogEntry(Lang[ID_COMPILEABORT])
  else if (fErrCount = 0) and (fDevRun.ExitCode = 0) then
  begin
    DoLogEntry(Lang[ID_COMPILESUCCESS]);
    Application.ProcessMessages;
    if Assigned(OnCompilationEnded) then
      OnCompilationEnded(Self);
  end;

  //Clean up
  fDevRun := nil;
  OnCompilationEnded := nil;
  Application.ProcessMessages;
end;

procedure TCompiler.OnLineOutput(Sender: TObject; const Line: String);
begin
  ParseLine(Line);
  DoLogEntry(Line);
  ProcessProgressForm(Line);
end;

procedure TCompiler.ParseLine(Line: String);
var
  RegEx: TRegExpr;
  LowerLine: string;
  cpos: integer;
begin
  RegEx := TRegExpr.Create;
  
  try
    if devCompiler.compilerType in ID_COMPILER_VC then
    begin
      //Check for command line errors
      RegEx.Expression := 'Command line error (.*) : (.*)';
      if RegEx.Exec(Line) then
        Inc(fErrCount);

      //Command line warnings
      RegEx.Expression := 'Command line warning (.*) : (.*)';
      if RegEx.Exec(Line) then
        Inc(fWarnCount);

      //Fatal error
      RegEx.Expression := '(.*)\(([0-9]+)\) : fatal error ([^:]*): (.*)';
      if Regex.Exec(Line) then
        Inc(fErrCount);

      //LINK fatal error
      RegEx.Expression := 'LINK : fatal error ([^:]*): (.*)';
      if RegEx.Exec(Line) then
        Inc(fErrCount);

      //General compiler error
      RegEx.Expression := '(.*)\(([0-9]+)\) : error ([^:]*): (.*)';
      if RegEx.Exec(Line) then
        Inc(fErrCount);

      //Compiler warning
      RegEx.Expression := '(.*)\(([0-9]+)\) : warning ([^:]*): (.*)';
      if RegEx.Exec(Line) then
        Inc(fWarnCount);
    end
    else if devCompiler.CompilerType = ID_COMPILER_MINGW then
    begin
      LowerLine := LowerCase(Line);

      { Make errors }
      if (Pos('make.exe: ***', LowerCase(Line)) > 0) and
        (Pos('Clock skew detected. Your build may be incomplete',
        LowerCase(Line)) <= 0) then
      begin
        if fErrCount = 0 then
          fErrCount := 1;
      end;

      { windres errors }
      if Pos('windres.exe: ', LowerCase(Line)) > 0 then
      begin
        { Delete 'windres.exe :' }
        Delete(Line, 1, 13);

        cpos := GetLastPos('warning: ', Line);
        if cpos > 0 then
        begin
          { Delete 'warning: ' }
          Delete(Line, 1, 9);
          cpos := Pos(':', Line);
          Delete(Line, 1, cpos);
          Inc(fWarnCount);
        end
        else
        begin
          { Does it contain a filename and line number? }
          cpos := GetLastPos(':', Line);
          if (cpos > 0) and (Pos(':', Line) <> cpos) then
          begin
            Delete(Line, cpos, Length(Line) - cpos + 1);
            cpos := GetLastPos(':', Line);
            Delete(Line, cpos, Length(Line) - 1);
          end;
          Inc(fErrCount);
        end;
      end;


      { foo.c: In function 'bar': }
      if Pos('In function', Line) > 0 then
      begin
        { Get message }
        cpos := GetLastPos(': ', Line);
        Delete(Line, cpos, Length(Line) - cpos + 1);
        Inc(fWarnCount);
      end;

      { In file included from C:/foo.h:1, }
      if Pos('In file included from ', Line) > 0 then
      begin
        Delete(Line, Length(Line), 1);
        cpos := GetLastPos(':', Line);
        Delete(Line, cpos, Length(Line) - cpos + 1);
      end;

      { from blabla.c:1: }
      if Pos('                 from ', Line) > 0 then
      begin
        Delete(Line, Length(Line), 1);
        cpos := GetLastPos(':', Line);
        Delete(Line, cpos, Length(Line) - cpos + 1);
      end;


      { foo.cpp: In method `bool MyApp::Bar()': }
      cpos := GetLastPos('In method `', Line);
      // GCC >= 3.2 support
      if cpos <= 0 then
        { foo.cpp: In member function `bool MyApp::Bar()': }
        cpos := GetLastPos('In member function `', Line);
      if cpos <= 0 then
        { foo.cpp: In constructor `MyApp::MyApp()': }
        cpos := GetLastPos('In constructor `', Line);
      if cpos <= 0 then
        { foo.cpp: In destructor `MyApp::MyApp()': }
        cpos := GetLastPos('In destructor `', Line);
      if cpos > 0 then
      begin
        Delete(Line, cpos - 2, Length(Line) - cpos + 3);
      end;


      { C:\TEMP\foo.o(.text+0xc)://C/bar.c: undefined reference to `hello' }
      cpos := Pos('undefined reference to ', Line);
      if cpos > 0 then
      begin
        Inc(fErrCount);
      end;


      { foo.cpp:1:[2:] bar.h: No such file or directory }
      cpos := GetLastPos('No such file or directory', Line);
      if cpos > 0 then
      begin
        Inc(fErrCount);
      end;

      { foo.cpp:1: candidates are: FooClass::Bar(void) }
      cpos := GetLastPos(': candidates are: ', Line);
      if cpos > 0 then
      begin
        Delete(Line, cpos, Length(Line) - cpos + 1);
        cpos := GetLastPos(':', Line);
        Delete(Line, cpos, Length(Line) - cpos + 1);
      end;

      { Other messages }
      cpos := GetLastPos(': ', Line);

      // there is no reason to run the following block if cpos=0.
      // the bug appeared when added an "all-after" Makefile rule
      // with the following contents:
      //
      // all-after:
      //     copy $(BIN) c:\$(BIN)
      //
      // the following block of code freaked-out with the ":"!
      if cpos > 0 then begin // mandrav fix
        Delete(Line, cpos + 2, Length(Line) - cpos - 1);

        cpos := Pos('warning: ', Line);
        if cpos > 0 then
        begin
          Inc(fWarnCount);
          Delete(Line, cpos - 2, Length(Line) - cpos + 2);
        end;

        // GCC >= 3.2. support
        if Pos(': error', Line) > 0 then begin
          Delete(Line, Pos(': error', Line), Length(Line) - cpos + 1);
          cpos := GetLastPos(':', Line);
          Delete(Line, cpos, Length(Line) - cpos + 1);
        end
        else begin
          cpos := GetLastPos(':', Line);
           if StrToIntDef(Copy(Line, cpos + 1, Length(Line) - cpos - 1), -1) <> -1 then
           begin
             Delete(Line, cpos, Length(Line) - cpos + 1);
             //filename may also contain column as "filename:line:col"
             cpos := GetLastPos(':', Line);
             if StrToIntDef(Copy(Line, cpos + 1, Length(Line) - cpos), -1) <> -1 then
             begin
               Delete(Line, cpos, Length(Line) - cpos + 1);
             end;
           end;
        end;
      end;
    end;
  finally
    RegEx.Destroy;
  end;

  if Assigned(CompileProgressForm) then
    with CompileProgressForm do
    begin
        lblErr.Caption := IntToStr(fErrCount);
        lblWarn.Caption := IntToStr(fWarnCount);
    end
end;

procedure TCompiler.ParseResults;
var
  LOutput: TStringList;
  cpos, curLine: integer;
  O_file, // file error in
  O_Line, // line error on
  O_Msg, // message for error
  Line, LowerLine: string;
  Messages, IMod: Integer;
  gcc, gpp: string;
  RegEx: TRegExpr;
  
begin
  Messages := 0;
  fErrCount := 0;
  RegEx := TRegExpr.Create;
  LOutput := TStringList.Create;

  if (devCompiler.gccName <> '') then
    gcc := devCompiler.gccName
  else
    gcc := CP_PROGRAM(devCompiler.CompilerType);
  if (devCompiler.gppName <> '') then
    gpp := devCompiler.gppName
  else
    gpp := CPP_PROGRAM(devCompiler.CompilerType);
  try
    LOutput.Text := fdevRun.Output;
    IMod := CalcMod(pred(LOutput.Count));

    // Concatenate errors which are on multiple lines
    if devCompiler.compilerType = ID_COMPILER_MINGW then
      for curLine := 0 to pred(LOutput.Count) do begin
        if (curLine > 0) and AnsiStartsStr('   ', LOutput[curLine]) then begin
          O_Msg := LOutput[curLine];
          Delete(O_Msg, 1, 2);
          LOutput[curLine - 1] := LOutput[curLine - 1] + O_Msg;
        end;
      end;

    for curLine := 0 to pred(LOutput.Count) do
    begin
      if (IMod = 0) or (curLine mod IMod = 0) then
        Application.ProcessMessages;

      if Messages > 500 then
      begin
        DoOutput('', '', Format(Lang[ID_COMPMSG_GENERALERROR], [Lang[ID_COMPMSG_TOOMANYMSGS]]));
        Break;
      end;

      Line := LOutput.Strings[curLine];
      LowerLine := LowerCase(Line);
      O_Msg := '';
      O_Line := '';
      O_File := '';

    if devCompiler.compilerType in ID_COMPILER_VC then
    begin
      //Do we have to ignore this message?
      if
        (Line = '') or //Empty line?!
        (Copy(Line, 1, Length(devCompiler.gccName)) = devCompiler.gccName) or
        (Copy(Line, 1, Length(devCompiler.gppName)) = devCompiler.gppName) or
        (Copy(Line, 1, Length(devCompiler.dllwrapName)) = devCompiler.dllwrapName) or
        (Copy(Line, 1, Length(devCompiler.windresName)) = devCompiler.windresName) or
        (Copy(Line, 1, Length(devCompiler.gprofName)) = devCompiler.gprofName) or
        (Copy(Line, 1, Length(RmExe)) = RmExe) or
        (Copy(Line, 1, 19) = '   Creating library') or
        (Length(Line) = 2) or //One word lines?
        (Pos('*** [', Line) > 0) or
        (((Pos('.c', Line) > 0) or (Pos('.cpp', Line) > 0)) and (Pos('(', Line) = 0)) or
        (Pos('Nothing to be done for', Line) > 0) or
        (Pos('while trying to match the argument list', Line) > 0) or
        (Line = 'Generating code') or
        (Line = 'Finished generating code')
      then
        continue;

      //Check for command line errors
      if RegEx.Exec(Line, 'Command line error ([^:]*) : (.*)') then
      begin
        O_Msg := RegEx.Substitute('[Command line error $1] $2');
        Inc(fErrCount);
      end
      //Command line warnings
      else if RegEx.Exec(Line, 'Command line warning ([^:]*) : (.*)') then
      begin
        O_Msg := RegEx.Substitute('[Command line warning $1] $2');
        Inc(fWarnCount);
      end
      //Fatal error
      else if Regex.Exec(Line, '(.*)\(([0-9]+)\) : fatal error ([^:]*): (.*)') then
      begin
        O_Msg := RegEx.Substitute('[Error $3] $4');
        O_Line := RegEx.Substitute('$2');
        O_File := RegEx.Substitute('$1');
        Inc(fErrCount);
      end
      //LINK fatal error
      else if RegEx.Exec(Line, 'LINK : fatal error ([^:]*): (.*)') then
      begin
        O_Msg := RegEx.Substitute('[Error $1] $2');
        Inc(fErrCount);
      end
      //General compiler error
      else if RegEx.Exec(Line, '(.*)\(([0-9]+)\) : error ([^:]*): (.*)') then
      begin
        O_Msg := RegEx.Substitute('[Error $3] $4');
        O_Line := RegEx.Substitute('$2');
        O_File := RegEx.Substitute('$1');
        Inc(fErrCount);
      end
      //Compiler warning
      else if RegEx.Exec(Line, '(.*)\(([0-9]+)\) : warning ([^:]*): (.*)') then
      begin
        O_Msg := RegEx.Substitute('[Warning $3] $4');
        O_Line := RegEx.Substitute('$2');
        O_File := RegEx.Substitute('$1');
        Inc(fWarnCount);
      end
      //LINK error
      else if RegEx.Exec(Line, '(.*)\((.*)\) : error ([^:]*): (.*)') then
      begin
        O_Msg := RegEx.Substitute('[Error $3] $4');
        O_File := RegEx.Substitute('$2');
        Inc(FErrCount);
      end
      else if RegEx.Exec(Line, '(.*) : error ([^:]*): (.*)') then
      begin
        O_Msg := RegEx.Substitute('[Error $2] $3');
        O_File := RegEx.Substitute('$1');
        Inc(fErrCount);
      end
      else if RegEx.Exec(Line, 'LINK : warning ([^:]*): (.*)') then
      begin
        O_Msg := RegEx.Substitute('[Warning $1] $2');
        Inc(fWarnCount);
      end
      //General compiler errors can produce extra filenames at the end. Take those into account
      else if RegEx.Exec(Line, '( +)(.*)\(([0-9]+)\)(| ): (could be|or|see declaration of) ''(.*)''') then
      begin
        O_Msg := RegEx.Substitute('$1$5 $6');
        O_Line := RegEx.Substitute('$3');
        O_File := RegEx.Substitute('$2');
      end
      //Do we have any spare messages floating around?
      else
        O_Msg := Line;
    end
    else //ID_COMPILER_MINGW
    begin
      Line := LOutput.Strings[curLine];
      LowerLine := LowerCase(Line);
      { Is this a compiler message? }
      if (Pos(':', Line) <= 0) or
        (CompareText(Copy(LowerLine, 1, 7), gpp) = 0) or
        (CompareText(Copy(LowerLine, 1, 7), gcc) = 0) or
        (CompareText(Copy(LowerLine, 1, 12), 'dllwrap.exe ') = 0) or
        (Pos('make.exe: nothing to be done for ', LowerLine) > 0) or
        (Pos('has modification time in the future', LowerLine) > 0) or
        (Pos('dllwrap.exe:', LowerLine) > 0) or
        (Pos('is up to date.', LowerLine) > 0) 
     then
        Continue;

      { Make errors }
      if (Pos('make.exe: ***', LowerCase(Line)) > 0) and
        (Pos('Clock skew detected. Your build may be incomplete',
        LowerCase(Line)) <= 0) then
      begin
        cpos := Length('make.exe: ***');
        O_Msg := '[Build Error] ' + Copy(Line, cpos + 1, Length(Line) - cpos);

        if Assigned(fProject) then
          O_file := Makefile
        else
          O_file := '';

        if Messages = 0 then
          Messages := 1;
        if fErrCount = 0 then
          fErrCount := 1;

        DoOutput('', O_file, O_Msg);
        Continue;
      end;


      { windres errors }
      if Pos('windres.exe: ', LowerCase(Line)) > 0 then
      begin
        { Delete 'windres.exe :' }
        Delete(Line, 1, 13);

        cpos := GetLastPos('warning: ', Line);
        if cpos > 0 then
        begin
          { Delete 'warning: ' }
          Delete(Line, 1, 9);
          cpos := Pos(':', Line);

          O_Line := Copy(Line, 1, cpos - 1);
          Delete(Line, 1, cpos);

          O_file := '';
          O_Msg := Line;

          Inc(Messages);
          Inc(fWarnCount);
          DoResOutput(O_Line, O_file, O_Msg);
          Continue;
        end else
        begin
          { Does it contain a filename and line number? }
          cpos := GetLastPos(':', Line);
          if (cpos > 0) and (Pos(':', Line) <> cpos) then
          begin
            O_Msg := Copy(Line, cpos + 2, Length(Line) - cpos - 1);
            Delete(Line, cpos, Length(Line) - cpos + 1);

            cpos := GetLastPos(':', Line);
            O_Line := Copy(Line, cpos + 1, Length(Line) - 2);
            Delete(Line, cpos, Length(Line) - 1);

            O_file := Line;

            { It doesn't contain a filename and line number after all }
            if StrToIntDef(O_Line, -1) = -1 then
            begin
              O_Msg := LOutput.Strings[curLine];
              Delete(O_Msg, 1, 13);
              O_Line := '';
              O_file := '';
            end;
          end
          else
          begin
            O_Line := '';
            O_file := '';
            O_Msg := Line;
          end;

          Inc(Messages);
          Inc(fErrCount);
          DoResOutput(O_Line, O_file, O_Msg);
          DoOutput(O_Line, O_file, Format(Lang[ID_COMPMSG_RESOURCEERROR], [O_Msg]));
          Continue;
        end;
      end;


      { foo.c: In function 'bar': }
      if Pos('In function', Line) > 0 then
      begin
        { Get message }
        cpos := GetLastPos(': ', Line);
        O_Msg := Copy(Line, cpos + 2, Length(Line) - cpos - 2);
        Delete(Line, cpos, Length(Line) - cpos + 1);

        { Get file }
        O_file := Line;

        Inc(fWarnCount);
        DoOutput('', O_file, O_Msg + ':');
        Continue;
      end;

      { In file included from C:/foo.h:1, }
      if Pos('In file included from ', Line) > 0 then
      begin
        Delete(Line, Length(Line), 1);
        cpos := GetLastPos(':', Line);
        O_Line := Copy(Line, cpos + 1, Length(Line) - cpos);
        Delete(Line, cpos, Length(Line) - cpos + 1);
        O_Msg := Line;

        cpos := Length('In file included from ');
        O_file := Copy(Line, cpos + 1, Length(Line) - cpos);

        DoOutput(O_Line, O_file, O_Msg);
        Continue;
      end;

      { from blabla.c:1: }
      if Pos('                 from ', Line) > 0 then
      begin
        Delete(Line, Length(Line), 1);
        cpos := GetLastPos(':', Line);
        O_Line := Copy(Line, cpos + 1, Length(Line) - cpos);
        Delete(Line, cpos, Length(Line) - cpos + 1);
        O_Msg := Line;

        cpos := Length('                 from ');
        O_file := Copy(Line, cpos + 1, Length(Line) - cpos);

        DoOutput(O_Line, O_file, O_Msg);
        Continue;
      end;


      { foo.cpp: In method `bool MyApp::Bar()': }
      cpos := GetLastPos('In method `', Line);
      // GCC >= 3.2 support
      if cpos <= 0 then
        { foo.cpp: In member function `bool MyApp::Bar()': }
        cpos := GetLastPos('In member function `', Line);
      if cpos <= 0 then
        { foo.cpp: In constructor `MyApp::MyApp()': }
        cpos := GetLastPos('In constructor `', Line);
      if cpos <= 0 then
        { foo.cpp: In destructor `MyApp::MyApp()': }
        cpos := GetLastPos('In destructor `', Line);
      if cpos > 0 then
      begin
        O_Msg := Copy(Line, cpos, Length(Line) - cpos + 1);
        Delete(Line, cpos - 2, Length(Line) - cpos + 3);
        O_file := Line;

        DoOutput('', O_file, O_Msg);
        Continue;
      end;


      { C:\TEMP\foo.o(.text+0xc)://C/bar.c: undefined reference to `hello' }
      cpos := Pos('undefined reference to ', Line);
      if cpos > 0 then
      begin
        O_Msg := Line;
        Delete(O_Msg, 1, cpos - 1);

        Inc(fErrCount);
        Inc(Messages);
        DoOutput('', '', Format(Lang[ID_COMPMSG_LINKERERROR], [O_Msg]));
        Continue;
      end;


      { foo.cpp:1:[2:] bar.h: No such file or directory }
      cpos := GetLastPos('No such file or directory', Line);
      if cpos > 0 then
      begin
        { Get file name }
        Delete(Line, cpos - 2, Length(Line) - cpos + 3);
        cpos := GetLastPos(': ', Line);
        O_Msg := Copy(Line, cpos + 2, Length(Line) - cpos) +
          ': No such file or directory.';


        { Get file name }
        cpos := Pos(':', Line);
        O_file := Copy(Line, 1, cpos - 1);
        Delete(Line, 1, cpos);


        { Get line number }
        cpos := Pos(':', Line);
        O_Line := Copy(Line, 1, cpos - 1);


        Inc(fErrCount);
        Inc(Messages);
        DoOutput(O_Line, O_file, O_Msg);
        Continue;
      end;

      { foo.cpp:1: candidates are: FooClass::Bar(void) }
      cpos := GetLastPos(': candidates are: ', Line);
      if cpos > 0 then
      begin
        O_Msg := Copy(Line, cpos + 2, Length(Line) - cpos - 1);
        Delete(Line, cpos, Length(Line) - cpos + 1);

        cpos := GetLastPos(':', Line);
        O_Line := Copy(Line, cpos + 1, Length(Line) - cpos);
        Delete(Line, cpos, Length(Line) - cpos + 1);

        O_file := Line;

        DoOutput(O_Line, O_file, O_Msg);
        Continue;
      end;

      { windres.exe ... }//normal command, *not* an error
      cpos := GetLastPos('windres.exe ', Line);
      if cpos > 0 then
      begin
        Line := '';
        Continue;
      end;

      { Other messages }
      cpos := GetLastPos(': ', Line);

      // there is no reason to run the following block if cpos=0.
      // the bug appeared when added an "all-after" Makefile rule
      // with the following contents:
      //
      // all-after:
     //     copy $(BIN) c:\$(BIN)
      //
      // the following block of code freaked-out with the ":"!
      if cpos > 0 then begin // mandrav fix

        O_Msg := Copy(Line, cpos + 2, Length(Line) - cpos - 1);
        Delete(Line, cpos + 2, Length(Line) - cpos - 1);

        cpos := Pos('warning: ', Line);
        if cpos > 0 then
        begin
          Inc(fWarnCount);
          if Pos('warning: ignoring pragma: ', Line) > 0 then
            O_Msg := 'ignoring pragma: ' + O_Msg;
          if Pos('#warning ', O_Msg) <= 0 then
            O_Msg := '[Warning] ' + O_Msg;

          { Delete 'warning: ' }
          Delete(Line, cpos - 2, Length(Line) - cpos + 2);
        end
        else if Pos('Info: ', Line) = 1 then
        begin
           O_Line := '';
           O_file := '';
           Delete(Line, 1, 6);
           O_Msg := '[Info] ' + Line;
        end
        else
        begin
          //We have no idea what this is, just call it a normal message
          Delete(Line, Length(Line) - 1, 1);          
        end;
        Inc(Messages);


        // GCC >= 3.2. support
        if Pos(': error', Line) > 0 then begin
          Delete(Line, Pos(': error', Line), Length(Line) - cpos + 1);
          cpos := GetLastPos(':', Line);
          O_Line := Copy(Line, cpos + 1, Length(Line) - cpos + 1);
          Delete(Line, cpos, Length(Line) - cpos + 1);
          O_file := Line;
        end
        else begin
          cpos := GetLastPos(':', Line);
           if StrToIntDef(Copy(Line, cpos + 1, Length(Line) - cpos - 1), -1) <> -1 then
           begin
          O_Line := Copy(Line, cpos + 1, Length(Line) - cpos - 1);
          Delete(Line, cpos, Length(Line) - cpos + 1);
          O_file := Line;
             //filename may also contain column as "filename:line:col"
             cpos := GetLastPos(':', Line);
             if StrToIntDef(Copy(Line, cpos + 1, Length(Line) - cpos), -1) <> -1 then
             begin
               O_Line := Copy(Line, cpos + 1, Length(Line) - cpos) + ':' + O_Line;
               Delete(Line, cpos, Length(Line) - cpos + 1);
               O_file := Line;
             end;
           end;
        end;

        cpos := Pos('parse error before ', O_Msg);
        if (cpos > 0) and (StrToIntDef(O_Line, 0) > 0) then
          O_Line := IntToStr(StrToInt(O_Line)); // - 1); *mandrav*: why -1 ???

        if (Pos('(Each undeclared identifier is reported only once',
          O_Msg) > 0) or (Pos('for each function it appears in.)',
          O_Msg) > 0) or (Pos('At top level:', O_Msg) > 0) then
        begin
          O_Line := '';
          O_file := '';
          Dec(Messages);
        end;

        { This is an error in the Makefile }
        if (MakeFile <> '') and SameFileName(Makefile, GetRealPath(O_file)) then
          if Pos('[Warning] ', O_Msg) <> 1 then
            O_Msg := '[Build Error] ' + O_Msg;
      end;
    end;

    Inc(Messages);
    DoOutput(O_Line, O_file, O_Msg);
  end;
  finally
    RegEx.Destroy;
    Application.ProcessMessages;
    if devCompiler.SaveLog then
    try
      if (fTarget = ctProject) and assigned(fProject) then
        LOutput.SavetoFile(ChangeFileExt(fProject.FileName, '.compiler.out'))
      else
        LOutput.SavetoFile(ChangeFileExt(fSourceFile, '.compiler.out'));
    except
      // swallow
    end;
    LOutput.Free;
  end;

  // there are no compiler errors/warnings
  if (Assigned(fOnSuccess)) then
    fOnSuccess(Messages);
end;

function TCompiler.GetCompiling: Boolean;
begin
  Result := fDevRun <> nil;
end;

procedure TCompiler.SwitchToOriginalCompilerSet;
begin
  if fOriginalSet = devCompiler.CompilerSet then
    Exit;

  devCompilerSet.LoadSet(fOriginalSet);
  devCompilerSet.AssignToCompiler;
  devCompiler.CompilerSet := fOriginalSet;
  fOriginalSet := -1;
end;

function TCompiler.SwitchToProjectCompilerSet: integer;
begin
  if fOriginalSet = -1 then
    fOriginalSet := devCompiler.CompilerSet;

  result := 0;

  if not Assigned(fProject) then
    Exit;

  if devCompiler.CompilerSet = fProject.CurrentProfile.CompilerSet then
    Exit;
  
  devCompilerSet.LoadSet(fProject.CurrentProfile.CompilerSet);
  devCompilerSet.AssignToCompiler;
  devCompiler.CompilerSet := fProject.CurrentProfile.CompilerSet;
end;

procedure TCompiler.SetProject(Project: TProject);
begin
  //Just assign it
  fProject := Project;

  //Do we swap the compiler set?
  if fProject <> nil then
    SwitchToProjectCompilerSet
  else
    SwitchToOriginalCompilerSet;
end;

function TCompiler.UpToDate: Boolean;
var
  sa: TSecurityAttributes;
  tpi: TProcessInformation;
  tsi: TStartupInfo;
  ec: Cardinal;
begin
  Result := False;
  Assert(fTarget = ctProject);
  sa.nLength := SizeOf(TSecurityAttributes);
  sa.lpSecurityDescriptor := nil;
  sa.bInheritHandle := True;

  FillChar(tsi, SizeOf(TStartupInfo), 0);
  tsi.cb := SizeOf(TStartupInfo);
  tsi.dwFlags := STARTF_USESHOWWINDOW;
  if CreateProcess(nil, PChar(format('%s -f "%s" all', [devCompiler.makeName, MakeFile]) +
                              ' ' + devCompiler.makeopts), @sa, @sa, true, 0, nil,
                   nil, tsi, tpi) then
  begin
    //Wait for make to come up with a result
    while WaitForSingleObject(tpi.hProcess, 100) = WAIT_TIMEOUT do
      Application.ProcessMessages;

    if GetExitCodeProcess(tpi.hProcess, ec) then
      Result := ec = 0;
  end;
  CloseHandle(tpi.hProcess);
  CloseHandle(tpi.hThread);
end;

procedure TCompiler.InitProgressForm(Status: string);
begin
  if not devData.ShowProgress then exit;
  if not Assigned(CompileProgressForm) then
    CompileProgressForm := TCompileProgressForm.Create(Application);
  with CompileProgressForm do begin
    Memo1.Lines.Clear;
    btnClose.Caption := Lang[ID_BTN_CANCEL];
    btnClose.OnClick := OnAbortCompile;
    Show;
    Memo1.Lines.Add(Format('%s: %s', [Lang[ID_COPT_COMPTAB], devCompilerSet.SetName(devCompiler.CompilerSet)]));
    lblCompiler.Caption := devCompilerSet.SetName(devCompiler.CompilerSet);
    lblStatus.Caption := Status;
    lblStatus.Font.Style := [];
    lblFile.Caption := '';
    lblErr.Caption := '0';
    lblWarn.Caption := '0';
    pb.Position := 0;
    pb.Step := 1;
    if Assigned(fProject) then
      pb.Max := fProject.Units.Count + 2  // all project units + linking output + private resource
    else
      pb.Max := 1; // just fSourceFile
  end;
  fWarnCount := 0;
  fErrCount := 0;
  Application.ProcessMessages;
end;

procedure TCompiler.EndProgressForm;
var
  sMsg: string;
begin
  if Assigned(CompileProgressForm) then begin
    with CompileProgressForm do begin
      pb.Position := 0;
      btnClose.Caption := Lang[ID_BTN_CLOSE];
      lblErr.Caption := IntToStr(fErrCount);
      lblWarn.Caption := IntToStr(fWarnCount);
      if fAbortThread then
        sMsg := 'Aborted'
      else
        sMsg := 'Done';
      if fErrCount > 0 then
        sMsg := sMsg + ' with errors.'
      else if fWarnCount > 0 then
        sMsg := sMsg + ' with warnings.'
      else
        sMsg := sMsg + '.';
      Memo1.Lines.Add(sMsg);
      lblStatus.Caption := sMsg;
      lblStatus.Font.Style := [fsBold];
      lblFile.Caption := '';
    end;
    Application.ProcessMessages;
    if devData.AutoCloseProgress or (fErrCount > 0) or (fWarnCount > 0) then
      ReleaseProgressForm;
  end;
end;

procedure TCompiler.ProcessProgressForm(Line: string);
var
  I: integer;
  srch: string;
  schk: boolean;
  act, fil: string;
  OK: boolean;
  prog: integer;
begin
  if not Assigned(CompileProgressForm) then
    Exit;
  with CompileProgressForm do begin
    // report currently compiling file
    if not Assigned(fProject) then begin
      Memo1.Lines.Add(fSourceFile);
      Memo1.Lines.Add('Compiling ' + fil);
      lblStatus.Caption := 'Compiling...';
      lblFile.Caption := fSourceFile;
      Exit;
    end;

    // the progress reported is the index of the unit in the project
    prog := pb.Position;
    OK := False;
    schk := Pos(devCompiler.CheckSyntaxFormat, Line) > 0;
    if schk then
      act := 'Syntax checking'
    else begin
      schk := Pos('Building Makefile', Line) > 0;
      if schk then
        act := 'Building Makefile'
      else
        act := '';
    end;

    srch := Format(devCompiler.PchCreateFormat, ['']);
    if Pos(srch, Line) > 0 then
    begin
      OK := false;
      act := 'Precompiling';
      fil := '';

      for i := Pos(srch, Line) + 3 to Length(Line) - Pos(srch, Line) + 3 do begin
       if (Line[i] = '"') then
         OK := not OK;

       if ((Line[i] = ' ') or ((Line[i] = '"') and (OK))) then
         break
       else
         fil := fil + Line[i];
      end;
    end
    else
    begin
      fil := '';
      for I := 0 to fProject.Units.Count - 1 do begin
      srch := ' ' + GenMakePath(ExtractRelativePath(fProject.FileName, fProject.Units[I].FileName), False, True) + ' ';
      if Pos(srch, Line) > 0 then
      begin
        fil := ExtractFilename(fProject.Units[I].FileName);
        prog := I + 1;
        if not schk then
          act := 'Compiling';
        OK := True;

        //Is it a header file being compiled?
        if GetFileTyp(fil) = utHead then
        begin
          act := 'Precompiling';
          prog := 1;
        end;
        Break;
      end;
    end;
    if not OK then
    begin
      srch := ExtractFileName(SubstituteMakeParams(fProject.CurrentProfile.PrivateResource));
      if Pos(srch, Line) > 0 then begin
        fil := srch;
        prog := pb.Max - 1;
        if not schk then
          act := 'Compiling';
        lblFile.Caption := srch;
      end;

      srch := ExtractFileName(fProject.Executable);
      if (Pos(srch, Line) > 0) and (Pos(RmExe, Line) > 0) then begin
        fil := srch;
        prog := 1;
        if not schk then
          act := 'Cleaning';
        lblFile.Caption := '';
      end
      else if (Pos(srch, Line) > 0) then begin
        fil := srch;
        prog := pb.Max;
        if not schk then
          act := 'Linking';
        lblFile.Caption := srch;
      end;

      if devCompiler.CompilerType in ID_COMPILER_VC then
      begin
        //Check for the manifest tool
        srch := devCompiler.gprofName;
        if (devCompiler.CompilerType = ID_COMPILER_VC2005) and (Pos(UpperCase(srch), UpperCase(Trim(Line))) = 1) then
        begin
          act := 'Embedding manifest';
          fil := Copy(Line, Pos(UpperCase('/outputresource:'), UpperCase(Line)) + 17, Length(Line));
          fil := Copy(fil, 0, Pos(Line, '"'));
        end;

        //Link-time code generation?
        srch := 'Generating code';
        if (Pos(UpperCase(srch), UpperCase(Trim(Line)))) = 1 then
        begin
          act := 'Generating code';
        end;
      end;
    end;
  end;

  if act + ' ' + fil <> ' ' then
    Memo1.Lines.Add(Trim(act + ' ' + fil));
  if trim(act) <> '' then
    lblStatus.Caption := act + '...';
  if trim(fil) <> '' then
    lblFile.Caption := fil;
  if (fil <> '') and (pb.Position < pb.Max) then
    pb.Position := prog;
  end;
  
  Application.ProcessMessages;
end;

procedure TCompiler.ReleaseProgressForm;
begin
  if not Assigned(CompileProgressForm) then
    Exit;

  CompileProgressForm.Close; // it's freed on close
  CompileProgressForm := nil;
end;

end.

