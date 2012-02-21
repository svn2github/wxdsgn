{
    $Id: compiler.pas 934 2007-04-26 22:12:25Z lowjoel $

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

Unit compiler;

Interface
Uses
    xprocs,
{$IFDEF WIN32}
    Windows, SysUtils, Dialogs, StdCtrls, ComCtrls, Forms,
    devrun, version, project, utils, prjtypes, Classes, Graphics;
{$ENDIF}

Const
    RmExe = 'rm -f';

Type
    TLogEntryEvent = Procedure(Const msg: String) Of Object;
    TOutputEvent = Procedure(Const _Line, _Unit, _Message: String) Of Object;
    TSuccessEvent = Procedure(Const messages: Integer) Of Object;

    TTarget = (ctNone, ctFile, ctProject);

    TCompiler = Class
    Private
        fOnLogEntry: TLogEntryEvent;
        fOnOutput: TOutputEvent;
        fOnResOutput: TOutputEvent;
        fOnSuccess: TSuccessEvent;
        fPerfectDepCheck: Boolean;
        fProject: TProject;
        fSourceFile: String;
        fRunParams: String;
        fMakefile: String;
        fTarget: TTarget;
        fErrCount: Integer;
        DoCheckSyntax: Boolean;
        fWarnCount: Integer;
        fSingleFile: Boolean;
        fOriginalSet: Integer;
        fStartCompile: Cardinal;

        Procedure DoLogEntry(Const msg: String);
        Procedure DoOutput(Const s, s2, s3: String);
        Procedure DoResOutput(Const s, s2, s3: String);
        Function GetMakeFile: String;
        Function GetCompiling: Boolean;
        Procedure InitProgressForm(Status: String);
        Procedure EndProgressForm;
        Procedure ReleaseProgressForm;
        Procedure ProcessProgressForm(Line: String);
        Procedure SwitchToProjectCompilerSet; // stores the original compiler set
        Procedure SwitchToOriginalCompilerSet;
        // switches the original compiler set to index
        Procedure SetProject(Project: TProject);
    Public
        OnCompilationEnded: Procedure(Sender: TObject) Of Object;

        Procedure BuildMakeFile;
        Procedure CheckSyntax; Virtual;
        Procedure Compile(SingleFile: String = ''); Virtual;
        Function Clean: Boolean; Virtual;
        Function RebuildAll: Boolean; Virtual;
        Procedure ShowResults; Virtual;
        Function FindDeps(TheFile: String): String; Overload;
        Function FindDeps(TheFile: String; Var VisitedFiles: TStringList): String;
            Overload;
        Function UpToDate: Boolean;

        Property Compiling: Boolean Read GetCompiling;
        Property Project: TProject Read fProject Write SetProject;
        Property OnLogEntry: TLogEntryEvent Read fOnLogEntry Write fOnLogEntry;
        Property OnOutput: TOutputEvent Read fOnOutput Write fOnOutput;
        Property OnResOutput: TOutputEvent Read fOnResOutput Write fOnResOutput;
        Property OnSuccess: TSuccessEvent Read fOnSuccess Write fOnSuccess;
        Property SourceFile: String Read fSourceFile Write fSourceFile;
        Property PerfectDepCheck: Boolean Read fPerfectDepCheck
            Write fPerfectDepCheck;
        Property RunParams: String Read fRunParams Write fRunParams;
        Property MakeFile: String Read GetMakeFile Write fMakeFile;
        Property Target: TTarget Read fTarget Write fTarget;
        Property ErrorCount: Integer Read fErrCount;
        Procedure OnAbortCompile(Sender: TObject);
        Procedure AbortThread;
        Procedure ParseLine(Line: String);
    Protected
        fCompileParams: String;
        fCppCompileParams: String;
        fLibrariesParams: String;
        fResObjects: String;
        fLibrariesLibs: String;
        fIncludesParams: String;
        fCppIncludesParams: String;
        fRcIncludesParams: String;
        fBinDirs: String;
        fUserParams: String;
        fDevRun: TDevRun;
        fAbortThread: Boolean;

        Procedure CreateMakefile; Virtual;
        Procedure CreateStaticMakefile; Virtual;
        Procedure CreateDynamicMakefile; Virtual;
        Procedure GetCompileParams; Virtual;
        Procedure GetLibrariesParams; Virtual;
        Procedure GetIncludesParams; Virtual;
        Procedure LaunchThread(s, dir: String); Virtual;
        Procedure OnCompilationTerminated(Sender: TObject); Virtual;
        Procedure OnLineOutput(Sender: TObject; Const Line: String); Virtual;
        Procedure ParseResults; Virtual;
        Function NewMakeFile(Var F: TextFile): Boolean; Virtual;
        Procedure WriteMakeClean(Var F: TextFile); Virtual;
        Procedure WriteMakeObjFilesRules(Var F: TextFile); Virtual;
        Function PreprocDefines: String;
        Function ExtractLibParams(strFullLibStr: String): String;
        Function ExtractLibFiles(strFullLibStr: String): String;
    Published
        Constructor Create;
    End;

Implementation

Uses
    MultiLangSupport, devcfg, Macros, devExec, CompileProgressFm,
    StrUtils, RegExpr,
    SynEdit, SynEditHighlighter, SynEditTypes, datamod, main;
// DbugIntf, EAB removed Gexperts debug stuff.

Constructor TCompiler.Create;
Begin
    fOriginalSet := -1;
End;

Procedure TCompiler.DoLogEntry(Const msg: String);
Begin
    If assigned(fOnLogEntry) Then
        fOnLogEntry(msg);
End;

Procedure TCompiler.DoOutput(Const s, s2, s3: String);
Begin
    If assigned(fOnOutput) Then
        fOnOutput(s, s2, s3);
End;

Procedure TCompiler.DoResOutput(Const s, s2, s3: String);
Begin
    If assigned(fOnResOutput) Then
        fOnResOutput(s, s2, s3);
End;

Function TCompiler.GetMakeFile: String;
Begin
    If Not FileExists(fMakeFile) Then
        BuildMakeFile;
    result := fMakeFile;
End;

// create makefile for fproject if assigned
Procedure TCompiler.BuildMakeFile;
Begin
    //Make sure we have an active project
    If Not Assigned(fProject) Then
    Begin
        fMakeFile := '';
        Exit;
    End

    //Exit if we have a custom makefile
    Else
    If fProject.CurrentProfile.UseCustomMakefile Then
    Begin
        fMakefile := fProject.CurrentProfile.CustomMakefile;
        Exit;
    End;

    //Create the object and executable output directory if it doesn't exist
    If (fProject.CurrentProfile.ObjectOutput <> '') And
        (Not DirectoryExists(fProject.CurrentProfile.ObjectOutput)) Then
        ForceDirectories(GetRealPath(SubstituteMakeParams(
            fProject.CurrentProfile.ObjectOutput), fProject.Directory));
    If (fProject.CurrentProfile.ExeOutput <> '') And
        (Not DirectoryExists(fProject.CurrentProfile.ExeOutput)) Then
        ForceDirectories(GetRealPath(SubstituteMakeParams(
            fProject.CurrentProfile.ExeOutput), fProject.Directory));

    //Then show the compilation progres form
    If Assigned(CompileProgressForm) Then
        CompileProgressForm.btnClose.Enabled := False;

    //Generate a makefile for the current project type
    Case Project.CurrentProfile.typ Of
        dptStat:
            CreateStaticMakeFile;
        dptDyn:
            CreateDynamicMakeFile;
    Else
        CreateMakeFile;
    End;

    If FileExists(fMakeFile) Then
        FileSetDate(fMakefile, DateTimeToFileDate(Now));
    // fix the "Clock skew detected" warning ;)
    If Assigned(CompileProgressForm) Then
        CompileProgressForm.btnClose.Enabled := True;
End;

Function TCompiler.NewMakeFile(Var F: TextFile): Boolean;
Const
    cAppendStr = '%s %s';

Var
    ObjResFile, Objects, LinkObjects, Comp_ProgCpp, Comp_Prog, tfile: String;
    i: Integer;
Begin
    Objects := '';

    For i := 0 To Pred(fProject.Units.Count) Do
    Begin
        If (GetFileTyp(fProject.Units[i].FileName) = utRes) Or
            ((Not fProject.Units[i].Compile) And (Not fProject.Units[i].Link)) Then
            Continue;

        If fProject.CurrentProfile.ObjectOutput <> '' Then
        Begin
            tfile := IncludeTrailingPathDelimiter(
                fProject.CurrentProfile.ObjectOutput) +
                ExtractFileName(fProject.Units[i].FileName);
            tfile := ExtractRelativePath(fProject.FileName, tfile);
        End
        Else
            tfile := ExtractRelativePath(fProject.FileName,
                fProject.Units[i].FileName);

        If GetFileTyp(tfile) <> utHead Then
        Begin
            Objects := Format(cAppendStr,
                [Objects, GenMakePath(ChangeFileExt(tfile, OBJ_EXT), True, False, True)]);
            If fProject.Units[i].Link Then
            Begin
                If (devCompiler.CompilerType = ID_COMPILER_DMARS) Then
                    LinkObjects := Format(cAppendStr,
                        [LinkObjects, GenMakePath3(ChangeFileExt(tfile, OBJ_EXT))])
                Else
                    LinkObjects := Format(cAppendStr, [LinkObjects, '"' +
                        GenMakePath(ChangeFileExt(tfile, OBJ_EXT), False, False, True) + '"']);
            End;
        End
        Else
        If ((devCompiler.CompilerType = ID_COMPILER_MINGW) Or
            (devCompiler.CompilerType = ID_COMPILER_LINUX)) And
            (I = fProject.PchHead) Then
            Objects := Format(cAppendStr,
                [Objects, GenMakePath(ChangeFileExt(ExtractRelativePath(
                fProject.FileName, fProject.Units[i].FileName), PCH_EXT), True, False, True)]);
    End;

    If Length(fProject.CurrentProfile.PrivateResource) = 0 Then
        ObjResFile := ''
    Else
    Begin
        If fProject.CurrentProfile.ObjectOutput <> '' Then
        Begin
            ObjResFile := ChangeFileExt(fProject.CurrentProfile.PrivateResource,
                RES_EXT);
            ObjResFile := ExtractRelativePath(fProject.FileName, ObjResFile);
        End
        Else
            ObjResFile := ExtractRelativePath(fProject.FileName,
                ChangeFileExt(fProject.CurrentProfile.PrivateResource, RES_EXT));
        If devCompiler.CompilerType <> ID_COMPILER_DMARS Then
            //Make the resource file into a usable path
            LinkObjects := Format(cAppendStr, [LinkObjects, GenMakePath(ObjResFile)])
        Else
            LinkObjects := LinkObjects + '_@@_' + GenMakePath(ObjResFile);

        Objects := Format(cAppendStr, [Objects, GenMakePath2(ObjResFile)]);
    End;

    If devCompiler.gppName <> '' Then
        If devCompiler.compilerType In ID_COMPILER_VC Then
            Comp_ProgCpp := '"' + devCompiler.gppName + '" /nologo'
        Else
            Comp_ProgCpp := devCompiler.gppName
    Else
        Comp_ProgCpp := CPP_PROGRAM(devCompiler.CompilerType);

    If devCompiler.gccName <> '' Then
        If devCompiler.compilerType In ID_COMPILER_VC Then
            Comp_Prog := '"' + devCompiler.gccName + '" /nologo'
        Else
            Comp_Prog := devCompiler.gccName
    Else
        Comp_Prog := CP_PROGRAM(devCompiler.CompilerType);

    GetCompileParams;
    GetLibrariesParams;
    GetIncludesParams;

    fMakefile := fProject.Directory + DEV_MAKE_FILE;
    OnLineOutput(Nil, 'Building Makefile: "' + fMakefile + '"');
    Assignfile(F, fMakefile);
    Try
        Rewrite(F);
    Except
        on E: Exception Do
        Begin
            MessageDlg('Could not create Makefile: "' + fMakefile + '"'
                + #13#10 + E.Message, mtError, [mbOK], 0);
            result := False;
            exit;
        End;
    End;
    result := True;
    writeln(F, '# Project: ' + fProject.Name);
    writeln(F, '# Compiler: ' + devCompiler.Name);
    Case devCompiler.CompilerType Of
        ID_COMPILER_MINGW:
            writeln(F, '# Compiler Type: MingW 3');
        ID_COMPILER_VC6:
            writeln(F, '# Compiler Type: Visual C++ 6');
        ID_COMPILER_VC2003:
            writeln(F, '# Compiler Type: Visual C++ .NET 2003');
        ID_COMPILER_VC2005:
            writeln(F, '# Compiler Type: Visual C++ 2005');
        ID_COMPILER_VC2008:
            writeln(F, '# Compiler Type: Visual C++ 2008');
        ID_COMPILER_VC2010:
            writeln(F, '# Compiler Type: Visual C++ 2010');
        ID_COMPILER_DMARS:
            writeln(F, '# Compiler Type: Digital Mars');
        ID_COMPILER_BORLAND:
            writeln(F, '# Compiler Type: Borland C++ 5.5');
        ID_COMPILER_WATCOM:
            writeln(F, '# Compiler Type: OpenWatCom');
        ID_COMPILER_LINUX:
            writeln(F, '# Compiler Type: Linux gcc');
    End;
    writeln(F, Format('# Makefile created by %s on %s',
        [DEVCPP_VERSION,
        FormatDateTime('dd/mm/yy hh:nn', Now)]));

    If DoCheckSyntax Then
    Begin
        writeln(F, '# This Makefile is written for syntax check!');
        writeln(F, '# Regenerate it if you want to use this Makefile to build.');
    End;
    writeln(F);

{$IFDEF PLUGIN_BUILD}
    For i := 0 To MainForm.pluginsCount - 1 Do
        writeln(F, MainForm.plugins[i].GetCompilerMacros);
{$ENDIF}

    writeln(F, 'CPP       = ' + Comp_ProgCpp);
    writeln(F, 'CC        = ' + Comp_Prog);
    If (devCompiler.windresName <> '') Then
        writeln(F, 'WINDRES   = "' + devCompiler.windresName + '"')
    Else
        writeln(F, 'WINDRES   = ' + RES_PROGRAM(devCompiler.CompilerType));
    writeln(F, 'OBJ       =' + Objects);

    If (devCompiler.CompilerType = ID_COMPILER_DMARS) Then
    Begin
        writeln(F, 'LINKOBJ   = ' + ExtractLibParams(LinkObjects));
        fResObjects := StringReplace(ExtractLibFiles(LinkObjects),
            '/', '\', [rfReplaceAll]);
    End
    Else
        writeln(F, 'LINKOBJ   =' + LinkObjects);

    If (devCompiler.CompilerType = ID_COMPILER_DMARS) Then
        writeln(F, 'LIBS      =' + ExtractLibFiles(fLibrariesParams))
    Else
        writeln(F, 'LIBS      =' + StringReplace(fLibrariesParams,
            '\', '/', [rfReplaceAll]));

    writeln(F, 'INCS      =' + StringReplace(fIncludesParams,
        '\', '/', [rfReplaceAll]));
    writeln(F, 'CXXINCS   =' + StringReplace(fCppIncludesParams,
        '\', '/', [rfReplaceAll]));
    writeln(F, 'RCINCS    =' + StringReplace(fRcIncludesParams,
        '\', '/', [rfReplaceAll]));
    writeln(F, 'BIN       = ' +
        GenMakePath(ExtractRelativePath(Makefile, fProject.Executable),
        False, False, True));
    writeln(F, 'DEFINES   = ' + PreprocDefines);
    writeln(F, 'CXXFLAGS  = $(CXXINCS) $(DEFINES) ' + fCppCompileParams);
    writeln(F, 'CFLAGS    = $(INCS) $(DEFINES) ' + fCompileParams);
    writeln(F, 'GPROF     = ' + devCompilerSet.gprofName);
  //  writeln(F, 'RM        = ' + RmExe);
    writeln(F, 'ifeq ($(OS),Windows_NT)');
    writeln(F, '   RM = del /Q');
    writeln(F, '   FixPath = $(subst /,\,$1)');
    writeln(F, 'else');
    writeln(F, '   RM = rm -f');
    writeln(F, '   FixPath = $1');
    writeln(F, 'endif');

    If devCompiler.CompilerType In ID_COMPILER_VC Then
        If (assigned(fProject) And (fProject.CurrentProfile.typ = dptStat)) Then
            writeln(F, 'LINK      = ' + devCompiler.dllwrapName)
        Else
        Begin
            If (devCompiler.CompilerType In ID_COMPILER_VC_CURRENT) Then
                writeln(F, 'LINK      = "' + devCompiler.dllwrapName +
                    '" /nologo /manifest')
            Else
                writeln(F, 'LINK      = "' + devCompiler.dllwrapName + '" /nologo');
        End
    Else
    If ((devCompiler.CompilerType = ID_COMPILER_MINGW) Or
        (devCompiler.CompilerType = ID_COMPILER_LINUX)) Then
        If (assigned(fProject) And (fProject.CurrentProfile.typ = dptStat)) Then
            writeln(F, 'LINK      = ar')
        Else
        If fProject.Profiles.useGPP Then
            writeln(F, 'LINK      = ' + Comp_ProgCpp)
        Else
            writeln(F, 'LINK      = ' + Comp_Prog)
    Else
    If devCompiler.CompilerType = ID_COMPILER_DMARS Then
    Begin //fixme: Check what is the options for static Lib file generation
        writeln(F, 'LINK      = ' + devCompiler.dllwrapName +
            ' /NOLOGO /SILENT /NOI /DELEXECUTABLE ' + ExtractLibParams(fLibrariesParams));
    End;

    Writeln(F, '');
    If DoCheckSyntax Then
        Writeln(F, '.PHONY: all all-before all-after clean clean-custom $(OBJ) $(BIN)')
    Else
        Writeln(F, '.PHONY: all all-before all-after clean clean-custom');
    Writeln(F, 'all: all-before $(BIN) all-after');
    Writeln(F, '');

    For i := 0 To fProject.CurrentProfile.MakeIncludes.Count - 1 Do
    Begin
        Writeln(F, 'include ' +
            GenMakePath(fProject.CurrentProfile.MakeIncludes.Strings[i]));
    End;

    WriteMakeClean(F);
    writeln(F);
End;

Function TCompiler.FindDeps(TheFile: String): String;
Var
    Visited: TStringList;
Begin
    Try
        Visited := TStringList.Create;
        Result := FindDeps(TheFile, Visited);
    Finally
        Visited.Free;
    End;
End;

Function TCompiler.FindDeps(TheFile: String;
    Var VisitedFiles: TStringList): String;
Var
    Editor: TSynEdit;
    i, Start: Integer;
    Includes: TStringList;
    Token, Quote, FilePath: String;
    Attri: TSynHighlighterAttributes;

    Function StartsStr(start: String; str: String): Boolean;
    Var
        i: Integer;
    Begin
        //Skip whitespace
        Result := False;
        For i := 1 To Length(str) - 1 Do
        Begin
            If str[i] In [' ', #9, #13, #10] Then
                continue;

            //OK, no more whitespace, see if we start the string
            Result := Copy(str, i, Length(start)) = start;
            Exit;
        End;
    End;
Begin;
    Result := '';
    Includes := Nil;

    //First check that we have not been visited
    If VisitedFiles.IndexOf(TheFile) <> -1 Then
        Exit;

    //Otherwise mark ourselves as visited
    Editor := TSynEdit.Create(Application);
    Editor.Highlighter := dmMain.Cpp;
    VisitedFiles.Add(TheFile);
    Application.ProcessMessages;

    Try
        //Load the lines of the file
        Includes := TStringList.Create;
        Editor.Lines.LoadFromFile(TheFile);

        //Iterate over the lines of the file
        For i := 0 To Editor.Lines.Count - 1 Do
            If StartsStr('#', Editor.Lines[i]) Then
            Begin
                Start := Pos('#', Editor.Lines[i]);
                Editor.GetHighlighterAttriAtRowCol(BufferCoord(start, i + 1),
                    Token, Attri);

                //Is it a preprocessor directive?
                If Attri.Name <> 'Preprocessor' Then
                    Continue;

                //Is it an include?
                Token := Trim(Copy(Token, 2, Length(Token))); //copy after #
                If Not AnsiStartsStr('include', Token) Then
                    Continue;

                //Extract the include filename
                Token := Copy(Token, Pos('include', Token) + 7, Length(Token));
                //copy after 'include'
                Token := Trim(Token);

                //Extract the type of closing quote
                quote := Token[1];
                If quote = '<' Then
                    quote := '>';

                //Remove the start and close quotes
                Token := Copy(Token, 2, Length(Token));
                Token := Copy(Token, 1, Pos(quote, Token) - 1); //Remove "" or <>

                //Now that tempstr contains the path, does it exist, hence we can depend on it?
                FilePath := GetRealPath(Token, ExtractFilePath(TheFile));
                If Not FileExists(FilePath) Then
                    Continue;

                //When we do get here, the file does exist. Convert the path to the one relative to the makefile
                Result := Result + ' ' +
                    GenMakePath2(ExtractRelativePath(fProject.Directory, FilePath));

                //Recurse into the include
                Result := result + FindDeps(FilePath, VisitedFiles);
            End;

    Finally
        If Assigned(Includes) Then
            Includes.Free;
        Editor.Free;
    End;
End;

Procedure TCompiler.WriteMakeObjFilesRules(Var F: TextFile);
Var
    i: Integer;
    RCDir: String;
    PCHObj, PCHFile, PCHHead: String;
    tfile, ofile, ResFiles, tmp: String;
Begin
    //Calculate the PCH file for this project
    PCHFile := '';
    PCHHead := '';
    PCHObj := '';

    Try
        If ((devCompiler.CompilerType = ID_COMPILER_MINGW) Or
            (devCompiler.CompilerType = ID_COMPILER_LINUX)) Then
        Begin
            If fProject.PchHead <> -1 Then
            Begin
                PCHObj := GenMakePath2(ExtractRelativePath(Makefile,
                    GetRealPath(ChangeFileExt(fProject.Units[fProject.PchHead].FileName, PCH_EXT),
                    fProject.Directory)));
                PCHHead := ExtractRelativePath(fProject.Directory,
                    fProject.Units[fProject.PchHead].FileName);
                PCHFile := GenMakePath(ExtractFileName(PCHHead) + PCH_EXT);
            End;
        End
        Else
        If devCompiler.CompilerType In ID_COMPILER_VC Then
        Begin
            If (fProject.PchHead <> -1) And (fProject.PchSource <> -1) Then
            Begin
                If fProject.CurrentProfile.ObjectOutput <> '' Then
                Begin
                    PCHObj := IncludeTrailingPathDelimiter(
                        fProject.CurrentProfile.ObjectOutput);
                    PCHFile := PCHObj;
                End;
                PCHObj := GenMakePath2(PCHObj + ExtractRelativePath(
                    Makefile, GetRealPath(ChangeFileExt(
                    fProject.Units[fProject.PchSource].FileName, OBJ_EXT), fProject.Directory)));
                PCHHead := ExtractRelativePath(fProject.Directory,
                    fProject.Units[fProject.PchHead].FileName);
                PCHFile := GenMakePath(PCHFile + ExtractFileName(PCHHead) + PCH_EXT);
            End
            Else
            If (fProject.PchHead <> -1) Or (fProject.PchSource <> -1) Then
            Begin
                DoOutput('', '', Format(Lang[ID_COMPMSG_MAKEFILEWARNING],
                    [Lang[ID_COMPMSG_PCHINCOMPLETE]]));
                Inc(fWarnCount);
            End;
        End;
    Except
        on e: Exception Do
            If devCompiler.CompilerType In ID_COMPILER_VC Then
            Begin
                DoOutput('', '', Format(Lang[ID_COMPMSG_MAKEFILEWARNING],
                    [Lang[ID_COMPMSG_PCHINCOMPLETE]]));
                Inc(fWarnCount);
            End;
    End;

    For i := 0 To pred(fProject.Units.Count) Do
    Begin
        If Not fProject.Units[i].Compile Then
            Continue;

        // skip resource files
        If GetFileTyp(fProject.Units[i].FileName) = utRes Then
            Continue;

        tfile := fProject.Units[i].FileName;
        If FileSamePath(tfile, fProject.Directory) Then
            tfile := ExtractFileName(tFile)
        Else
            tfile := ExtractRelativePath(Makefile, tfile);

        If GetFileTyp(tfile) <> utHead Then
        Begin
            writeln(F);
            If fProject.CurrentProfile.ObjectOutput <> '' Then
            Begin
                ofile := IncludeTrailingPathDelimiter(
                    fProject.CurrentProfile.ObjectOutput) +
                    ExtractFileName(fProject.Units[i].FileName);
                ofile := ExtractRelativePath(fProject.FileName,
                    ChangeFileExt(ofile, OBJ_EXT));
            End
            Else
                ofile := ChangeFileExt(tfile, OBJ_EXT);

            If (PCHObj <> '') And (((devCompiler.CompilerType In ID_COMPILER_VC) And
                (I <> fProject.PchSource)) Or
                (Not (devCompiler.CompilerType In ID_COMPILER_VC))) Then
                tmp := PCHObj + ' '
            Else
                tmp := '';

            If PerfectDepCheck And Not fSingleFile Then
                writeln(F, GenMakePath2(ofile) + ': $(GLOBALDEPS) ' +
                    tmp + GenMakePath2(tfile) + FindDeps(fProject.Directory + tfile))
            Else
                writeln(F, GenMakePath2(ofile) + ': $(GLOBALDEPS) ' +
                    tmp + GenMakePath2(tfile));

            If fProject.Units[i].OverrideBuildCmd And
                (fProject.Units[i].BuildCmd <> '') Then
            Begin
                tmp := fProject.Units[i].BuildCmd;
                tmp := StringReplace(tmp, '<CRTAB>', #10#9, [rfReplaceAll]);
                writeln(F, #9 + tmp);
            End
            Else
            Begin
                //Decide on whether we pass a PCH creation or usage argument
                With devCompiler Do
                Begin
                    tmp := '';
                    If CompilerType In ID_COMPILER_VC Then
                    Begin
                        If PCHHead <> '' Then
                        Begin
                            If I <> fProject.PchSource Then
                                tmp := PchUseFormat
                            Else
                                tmp := PchCreateFormat;
                            tmp := Format(' ' + tmp + ' ' + PchFileFormat,
                                [GenMakePath(PCHHead), PCHFile]);
                        End;
                    End;
                End;

                If Not DoCheckSyntax Then
                    If fProject.Units[i].CompileCpp Then
                        writeln(F, #9 + '$(CPP) ' +
                            format(devCompiler.OutputFormat, [GenMakePath(tfile), GenMakePath(ofile)]) +
                            tmp + ' $(CXXFLAGS)')
                    Else
                        writeln(F, #9 + '$(CC) ' +
                            format(devCompiler.OutputFormat, [GenMakePath(tfile), GenMakePath(ofile)]) +
                            tmp + ' $(CFLAGS)')
                Else
                If fProject.Units[i].CompileCpp Then
                    writeln(F, #9 + '$(CPP) ' +
                        format(devCompiler.CheckSyntaxFormat, [GenMakePath(tfile)]) +
                        tmp + ' $(CXXFLAGS)')
                Else
                    writeln(F, #9 + '$(CC) ' +
                        format(devCompiler.CheckSyntaxFormat, [GenMakePath(tfile)]) +
                        tmp + ' $(CFLAGS)');
            End;
        End
        Else
        If ((devCompiler.CompilerType = ID_COMPILER_MINGW) Or
            (devCompiler.CompilerType = ID_COMPILER_LINUX)) And
            (I = fProject.PchHead) And (PchHead <> '') Then
        Begin
            If Not DoCheckSyntax Then
            Begin
                writeln(F);
                ofile := ChangeFileExt(tfile, '.h.gch');

                If PerfectDepCheck Then
                    writeln(F, GenMakePath2(ofile) + ': $(GLOBALDEPS) ' +
                        tmp + GenMakePath2(tfile) + FindDeps(fProject.Directory + tfile))
                Else
                    writeln(F, GenMakePath2(ofile) + ': $(GLOBALDEPS) ' +
                        tmp + GenMakePath2(tfile));

                If fProject.Units[i].OverrideBuildCmd And
                    (fProject.Units[i].BuildCmd <> '') Then
                Begin
                    tmp := fProject.Units[i].BuildCmd;
                    tmp := StringReplace(tmp, '<CRTAB>', #10#9, [rfReplaceAll]);
                    writeln(F, #9 + tmp);
                End
                Else
                Begin
                    //Decide on whether we pass a PCH creation or usage argument
                    With devCompiler Do
                    Begin
                        If (PCHHead <> '') And (PchCreateFormat <> '') Then
                            tmp := Format(' ' + PchCreateFormat, [GenMakePath(PCHHead)])
                        Else
                            tmp := '';
                    End;

                    If fProject.Units[i].CompileCpp Then
                        writeln(F, #9 + '$(CPP) ' +
                            format(devCompiler.OutputFormat, [GenMakePath(tfile), GenMakePath(ofile)]) +
                            tmp + ' $(CXXFLAGS)')
                    Else
                        writeln(F, #9 + '$(CC) ' +
                            format(devCompiler.OutputFormat, [GenMakePath(tfile), GenMakePath(ofile)]) +
                            tmp + ' $(CFLAGS)');
                End;
            End;
        End;
    End;

    If (Length(fProject.CurrentProfile.PrivateResource) > 0) Then
    Begin
        ResFiles := '';
        For i := 0 To fProject.Units.Count - 1 Do
        Begin
            If GetFileTyp(fProject.Units[i].FileName) <> utRes Then
                Continue;
            If FileExists(GetRealPath(fProject.Units[i].FileName,
                fProject.Directory)) Then
                ResFiles := ResFiles +
                    GenMakePath2(ExtractRelativePath(fProject.Directory,
                    fProject.Units[i].FileName)) + ' ';
        End;
        writeln(F);

        //Get the path of the resource
        ofile := ChangeFileExt(fProject.CurrentProfile.PrivateResource, RES_EXT);
        If (fProject.CurrentProfile.ObjectOutput <> '') Then
            RCDir := fProject.CurrentProfile.ObjectOutput
        Else
            RCDir := fProject.Directory;
        RCDir := IncludeTrailingPathDelimiter(GetRealPath(RCDir,
            fProject.Directory));

        //Then get the path to the resource object relative to our project directory
        ofile := GenMakePath2(ExtractRelativePath(fProject.Directory, ofile));
        tfile := ExtractRelativePath(fProject.FileName,
            fProject.CurrentProfile.PrivateResource);

        writeln(F, ofile + ': ' + GenMakePath2(tfile) + ' ' + ResFiles);
        If devCompiler.CompilerType = ID_COMPILER_MINGW Then
            writeln(F, #9 + '$(WINDRES) ' +
                format(devCompiler.ResourceFormat,
                [GenMakePath(ChangeFileExt(tfile, RES_EXT)) + ' $(RCINCS) ' +
                GenMakePath(GetShortName(tfile))]))
        Else
        If (devCompiler.CompilerType <> ID_COMPILER_LINUX) Then
            writeln(F, #9 + '$(WINDRES) ' +
                format(devCompiler.ResourceFormat,
                [GenMakePath(ChangeFileExt(tfile, RES_EXT)) + ' $(RCINCS) ' +
                GenMakePath(tfile)]));
    End;
End;

Procedure TCompiler.WriteMakeClean(Var F: TextFile);
Begin
    Writeln(F, 'clean: clean-custom');
    Writeln(F, #9 + '$(RM) $(call FixPath,$(LINKOBJ)) "$(call FixPath,$(BIN))"');
End;

Procedure TCompiler.CreateMakefile;
Var
    F: TextFile;
Begin
    If Not NewMakeFile(F) Then
        exit;
    writeln(F, '$(BIN): $(OBJ)');

    If Not DoCheckSyntax Then
    Begin

        If devCompiler.compilerType <> ID_COMPILER_DMARS Then
            writeln(F, #9 + '$(LINK) $(LINKOBJ) ' +
                format(devCompiler.LinkerFormat, ['$(BIN)']) + ' $(LIBS) ')
        Else
            writeln(F, #9 + '$(LINK) $(LINKOBJ) ' +
                format(devCompiler.LinkerFormat, ['$(BIN)']) + ', ,$(LIBS),,' + fResObjects);

        If (devCompiler.compilerType In ID_COMPILER_VC_CURRENT) Then
        Begin
            writeln(F, #9 + '$(GPROF) /nologo /manifest "' +
                ExtractRelativePath(Makefile, fProject.Executable) +
                '.manifest" /outputresource:"' + ExtractRelativePath(
                Makefile, fProject.Executable) + '"');
            writeln(F, #9 + '@$(RM) "' +
                ExtractRelativePath(Makefile, fProject.Executable) + '.manifest"');
        End;
    End;

    WriteMakeObjFilesRules(F);
    Flush(F);
    CloseFile(F);
End;

Procedure TCompiler.CreateStaticMakefile;
Var
    F: TextFile;
Begin
    If Not NewMakeFile(F) Then
        exit;
    writeln(F, '$(BIN): $(OBJ)');
    If Not DoCheckSyntax Then
    Begin
        If ((devCompiler.CompilerType = ID_COMPILER_MINGW) Or
            (devCompiler.CompilerType = ID_COMPILER_LINUX)) Then
            writeln(F, #9 + '$(LINK) ' + format(devCompiler.LibFormat, ['$(BIN)']) +
                ' $(LINKOBJ)')
        Else
            writeln(F, #9 + '$(LINK) ' + format(devCompiler.LibFormat, ['$(BIN)']) +
                ' $(LINKOBJ) $(LIBS)');
    End;
    WriteMakeObjFilesRules(F);
    Flush(F);
    CloseFile(F);
End;

Procedure TCompiler.CreateDynamicMakefile;
Var
    backward, forward: Integer;
    F: TextFile;
    binary: String;
    pfile, tfile: String;
Begin
    If Not NewMakeFile(F) Then
        exit;
    pfile := ExtractFilePath(Project.Executable);
    tfile := pfile + ExtractFileName(Project.Executable);
    If FileSamePath(tfile, Project.Directory) Then
        tfile := ExtractFileName(tFile)
    Else
        tfile := ExtractRelativePath(Makefile, tfile);

    //If we are MingW then change the library name to start with lib
    If ((devCompiler.CompilerType = ID_COMPILER_MINGW) Or
        (devCompiler.CompilerType = ID_COMPILER_LINUX)) Then
    Begin
        Forward := GetLastPos('/', tfile);
        Backward := GetLastPos('\', tfile);
        If Backward > Forward Then
            Insert('lib', tfile, Backward + 1)
        Else
            Insert('lib', tfile, Forward + 1);
    End;

    writeln(F, '$(BIN): $(OBJ)');

    If Not DoCheckSyntax Then
    Begin
        binary := GenMakePath(ExtractRelativePath(Makefile, fProject.Executable));
        If ((devCompiler.CompilerType = ID_COMPILER_MINGW) Or
            (devCompiler.CompilerType = ID_COMPILER_LINUX)) Then
            writeln(F, #9 + '$(LINK) -shared $(STATICLIB) $(LINKOBJ) $(LIBS) ' +
                format(devcompiler.DllFormat,
                [GenMakePath(ChangeFileExt(tfile, LIB_EXT)), binary]))
        Else
            writeln(F, #9 + '$(LINK) ' + format(devcompiler.DllFormat,
                [GenMakePath(ChangeFileExt(tfile, '.lib')), binary]) + ' $(LINKOBJ) $(LIBS)');

        If (devCompiler.compilerType In ID_COMPILER_VC_CURRENT) Then
        Begin
            writeln(F, #9 + '$(GPROF) /nologo /manifest "' +
                ExtractRelativePath(Makefile, fProject.Executable) +
                '.manifest" /outputresource:"' + ExtractRelativePath(
                Makefile, fProject.Executable) + ';#2"');
            writeln(F, #9 + '@$(RM) "' + ExtractRelativePath(
                Makefile, fProject.Executable) + '.manifest"');
        End;
    End;

    WriteMakeObjFilesRules(F);
    Flush(F);
    CloseFile(F);
End;

Procedure TCompiler.GetCompileParams;
    Procedure AppendStr(Var s: String; value: String);
    Begin
        s := s + ' ' + value;
    End;
Var
    I, val: Integer;
Begin
    { Check user's compiler options }
    With devCompiler Do
    Begin
        fCompileParams := '';
        fCppCompileParams := '';
        fUserParams := '';

        If Assigned(fProject) Then
        Begin
            fCppCompileParams :=
                StringReplace(fProject.CurrentProfile.CppCompiler, '_@@_',
                ' ', [rfReplaceAll]);
            fCompileParams := StringReplace(fProject.CurrentProfile.Compiler,
                '_@@_', ' ', [rfReplaceAll]);
        End;

        If CmdOpts <> '' Then
            AppendStr(fUserParams, CmdOpts);
        AppendStr(fCompileParams, fUserParams);
        AppendStr(fCppCompileParams, fUserParams);

        For I := 0 To OptionsCount - 1 Do
            // consider project specific options for the compiler
            If (Assigned(fProject) And
                (I < Length(fProject.CurrentProfile.CompilerOptions)) And
                Not (fProject.CurrentProfile.typ In
                devCompiler.Options[I].optExcludeFromTypes)) Or
                (Not Assigned(fProject) And (Options[I].optValue > 0)) Then
            Begin
                If devCompiler.Options[I].optIsC Then
                Begin
                    If Assigned(devCompiler.Options[I].optChoices) Then
                    Begin
                        If Assigned(fProject) Then
                            val := devCompiler.ConvertCharToValue(
                                fProject.CurrentProfile.CompilerOptions[I + 1])
                        Else
                            val := devCompiler.Options[I].optValue;
                        If (val > 0) And
                            (val < devCompiler.Options[I].optChoices.Count) Then
                            AppendStr(fCompileParams, devCompiler.Options[I].optSetting +
                                devCompiler.Options[I].optChoices.Values[devCompiler.Options
                                [I].optChoices.Names[val]]);
                    End
                    Else
                    If (Assigned(fProject) And
                        (StrToIntDef(fProject.CurrentProfile.CompilerOptions[I + 1], 0) = 1)) Or
                        (Not Assigned(fProject)) Then
                        AppendStr(fCompileParams, devCompiler.Options[I].optSetting);
                End;
                If devCompiler.Options[I].optIsCpp Then
                Begin
                    If Assigned(devCompiler.Options[I].optChoices) Then
                    Begin
                        If Assigned(fProject) Then
                            val := devCompiler.ConvertCharToValue(
                                fProject.CurrentProfile.CompilerOptions[I + 1])
                        Else
                            val := devCompiler.Options[I].optValue;
                        If (val > 0) And
                            (val < devCompiler.Options[I].optChoices.Count) Then
                            AppendStr(fCppCompileParams, devCompiler.Options[I].optSetting +
                                devCompiler.Options[I].optChoices.Values[devCompiler.Options
                                [I].optChoices.Names[val]]);
                    End
                    Else
                    If (Assigned(fProject) And
                        (StrToIntDef(fProject.CurrentProfile.CompilerOptions[I + 1], 0) = 1)) Or
                        (Not Assigned(fProject)) Then
                        AppendStr(fCppCompileParams, devCompiler.Options[I].optSetting);
                End;
            End;

        fCompileParams := ParseMacros(fCompileParams);
        fCppCompileParams := ParseMacros(fCppCompileParams);
    End;
End;

Procedure TCompiler.GetLibrariesParams;
Var
    i, val: Integer;
    cAppendStr, compilerSetOptionStr: String;
    strLst, strProfileLinkerLst: TStringList;
    libStr, temps: String;
Begin
    fLibrariesParams := '';
    If devCompiler.compilerType <> ID_COMPILER_DMARS Then
    Begin
        cAppendStr := '%s ' + devCompiler.LinkerPaths;
        fLibrariesParams := CommaStrToStr(devDirs.lib, cAppendStr);

        If devCompilerSet.LinkOpts <> '' Then
            fLibrariesParams := fLibrariesParams + ' ' + devCompilerSet.LinkOpts;
        If (fTarget = ctProject) And assigned(fProject) Then
        Begin
            For i := 0 To pred(fProject.CurrentProfile.Libs.Count) Do
                fLibrariesParams :=
                    format(cAppendStr, [fLibrariesParams, fProject.CurrentProfile.Libs[i]]);
            fLibrariesParams := fLibrariesParams + ' ' +
                StringReplace(fProject.CurrentProfile.Linker, '_@@_', ' ', [rfReplaceAll]);
        End;

        //TODO: lowjoel:What does this do?
        If (pos(' -pg', fCompileParams) <> 0) And
            (pos('-lgmon', fLibrariesParams) = 0) Then
            fLibrariesParams := fLibrariesParams + ' -lgmon -pg ';

        fLibrariesParams := fLibrariesParams + ' ';
        For I := 0 To devCompiler.OptionsCount - 1 Do
            // consider project specific options for the compiler
            If (
                Assigned(fProject) And
                (I < Length(fProject.CurrentProfile.CompilerOptions)) And
                Not (fProject.CurrentProfile.typ In
                devCompiler.Options[I].optExcludeFromTypes)
                ) Or
                // else global compiler options
                (Not Assigned(fProject) And (devCompiler.Options[I].optValue > 0)) Then
            Begin
                If devCompiler.Options[I].optIsLinker Then
                    If Assigned(devCompiler.Options[I].optChoices) Then
                    Begin
                        If Assigned(fProject) Then
                            val := devCompiler.ConvertCharToValue(
                                fProject.CurrentProfile.CompilerOptions[I + 1])
                        Else
                            val := devCompiler.Options[I].optValue;
                        If (val > 0) And
                            (val < devCompiler.Options[I].optChoices.Count) Then
                            fLibrariesParams := fLibrariesParams
                                + devCompiler.Options[I].optSetting +
                                devCompiler.Options[I].optChoices.Values[devCompiler.Options
                                [I].optChoices.Names[val]] + ' ';
                    End
                    Else
                    If (Assigned(fProject) And
                        (StrToIntDef(fProject.CurrentProfile.CompilerOptions[I + 1], 0) = 1)) Or
                        (Not Assigned(fProject)) Then
                        fLibrariesParams := fLibrariesParams
                            + devCompiler.Options[I].optSetting + ' ';
            End;
    End
    Else //if ID_COMPILER_DMARS
    Begin
        fLibrariesParams := ' ';
        strLst := TStringList.Create;
        cAppendStr := '%s ' + devCompiler.LinkerPaths;

        StrtoList(devDirs.lib, strLst, ';');

        If devCompilerSet.LinkOpts <> '' Then
            compilerSetOptionStr := devCompilerSet.LinkOpts;

        For I := 0 To devCompiler.OptionsCount - 1 Do
            // consider project specific options for the compiler
            If (
                Assigned(fProject) And
                (I < Length(fProject.CurrentProfile.CompilerOptions)) And
                Not (fProject.CurrentProfile.typ In
                devCompiler.Options[I].optExcludeFromTypes)
                ) Or
                // else global compiler options
                (Not Assigned(fProject) And (devCompiler.Options[I].optValue > 0)) Then
            Begin
                If devCompiler.Options[I].optIsLinker Then
                    If Assigned(devCompiler.Options[I].optChoices) Then
                    Begin
                        If Assigned(fProject) Then
                            val := devCompiler.ConvertCharToValue(
                                fProject.CurrentProfile.CompilerOptions[I + 1])
                        Else
                            val := devCompiler.Options[I].optValue;
                        If (val > 0) And
                            (val < devCompiler.Options[I].optChoices.Count) Then
                            compilerSetOptionStr := compilerSetOptionStr
                                + devCompiler.Options[I].optSetting +
                                devCompiler.Options[I].optChoices.Values[devCompiler.Options
                                [I].optChoices.Names[val]] + ' ';
                    End
                    Else
                    If (Assigned(fProject) And
                        (StrToIntDef(fProject.CurrentProfile.CompilerOptions[I + 1], 0) = 1)) Or
                        (Not Assigned(fProject)) Then
                        compilerSetOptionStr := compilerSetOptionStr
                            + devCompiler.Options[I].optSetting + ' ';
            End;

        If (fTarget = ctProject) And assigned(fProject) Then
        Begin
            For i := 0 To pred(fProject.CurrentProfile.Libs.Count) Do
            Begin
                strLst.Add(fProject.CurrentProfile.Libs[i]);
            End;
            strProfileLinkerLst := TStringList.Create;
            temps := StringReplace(fProject.CurrentProfile.Linker, '_@@_',
                '~', [rfReplaceAll]);
            StrtoList(temps, strProfileLinkerLst, '~');

            For i := 0 To strProfileLinkerLst.Count - 1 Do
            Begin
                If trim(strProfileLinkerLst[i]) = '' Then
                    continue;
                temps := copy(trim(strProfileLinkerLst[i]), 0, 1);
                If (temps = '-') Or (temps = '/') Then
                    compilerSetOptionStr :=
                        compilerSetOptionStr + ' ' + strProfileLinkerLst[i]
                Else
                    fLibrariesParams := fLibrariesParams + ' ' + strProfileLinkerLst[i];
            End;
            //fLibrariesParams := fLibrariesParams + ' ' + StringReplace(fProject.CurrentProfile.Linker, '_@@_', ' ', [rfReplaceAll]);

        End;

        libStr := '';
        If trim(fLibrariesParams) <> '' Then
        Begin
            For i := 0 To strLst.count - 1 Do
            Begin
                If AnsiContainsText(strLst[i], '\lib\dmars') Or
                    AnsiContainsText(strLst[i], '\lib\dmars\') Then
                    libStr := libStr + ' ' + fLibrariesParams
                Else
                    libStr := libStr + ' ' + '"' + strLst[i] + '"' + ' ' +
                        fLibrariesParams;
            End;
        End;
        fLibrariesParams := compilerSetOptionStr + '_@@_' + libStr;
    End;
End;

Procedure TCompiler.GetIncludesParams;
Var
    i: Integer;
    cAppendStr, cRCString: String;
    strLst: TStringList;
Begin
    fIncludesParams := '';
    fCppIncludesParams := '';
    cAppendStr := '%s ' + devCompiler.IncludeFormat;
    fIncludesParams := CommaStrToStr(devDirs.C, cAppendStr);
    fCppIncludesParams := CommaStrToStr(devDirs.Cpp, cAppendStr);

    strLst := TStringList.Create;
    strTokenToStrings(devDirs.RC, ';', strLst);
    cRCString := '';
    For i := 0 To strLst.Count - 1 Do
        cRCString := cRCString + GetShortName(strLst.Strings[i]) + ';';
    fRcIncludesParams := CommaStrToStr(cRCString, '%s ' +
        devCompiler.ResourceIncludeFormat);
    strLst.Free;

    If (fTarget = ctProject) And assigned(fProject) Then
    Begin
        For i := 0 To pred(fProject.CurrentProfile.Includes.Count) Do
            If directoryExists(fProject.CurrentProfile.Includes[i]) Then
            Begin
                fIncludesParams :=
                    format(cAppendStr, [fIncludesParams, fProject.CurrentProfile.Includes[i]]);
                fCppIncludesParams :=
                    format('%s ' + devCompiler.IncludeFormat, [fCppIncludesParams,
                    fProject.CurrentProfile.Includes[i]]);
            End;
        For i := 0 To pred(fProject.CurrentProfile.ResourceIncludes.Count) Do
            If directoryExists(fProject.CurrentProfile.ResourceIncludes[i]) Then
                fRcIncludesParams :=
                    format(cAppendStr, [fRcIncludesParams,
                    GetShortName(fProject.CurrentProfile.ResourceIncludes[i])]);
    End;
End;

Function TCompiler.ExtractLibParams(strFullLibStr: String): String;
Var
    nPos: Integer;
Begin
    nPos := pos('_@@_', strFullLibStr);
    If nPos = 0 Then
        Result := strFullLibStr
    Else
        Result := copy(strFullLibStr, 0, nPos - 1);
End;

Function TCompiler.ExtractLibFiles(strFullLibStr: String): String;
Var
    nPos: Integer;
Begin
    nPos := pos('_@@_', strFullLibStr);
    If nPos = 0 Then
        Result := ''
    Else
        Result := copy(strFullLibStr, nPos + 4, length(strFullLibStr));
End;


Function TCompiler.PreprocDefines: String;
Var
    i: Integer;
    values: TStringList;
{$IFDEF PLUGIN_BUILD}
    temp: String;
{$ENDIF}
Begin
    Result := '';
    If assigned(fProject) Then
    Begin
        values := TStringList.Create;
        strTokenToStrings(StringReplace(fProject.CurrentProfile.PreprocDefines,
            '_@@_', #10, [rfReplaceAll]), #10, values);

        For i := 0 To values.Count - 1 Do
            Result := Result + ' ' + Format(devCompiler.PreprocDefines, [values[i]]);

        //Clean up
        values.Free;
    End;

{$IFDEF PLUGIN_BUILD}//EAB TODO: Make this more general (not easy to do :P )
    For i := 0 To MainForm.pluginsCount - 1 Do
    Begin
        temp := MainForm.plugins[i].GetCompilerPreprocDefines;
        If temp <> '' Then
            Result := Result + ' ' + Format(devCompiler.PreprocDefines, [temp]);
    End;
{$ENDIF}
    Result := Trim(Result);
End;

Procedure TCompiler.ShowResults;
Begin
    // display compile results dialog
End;

Procedure TCompiler.CheckSyntax;
Begin
    DoCheckSyntax := True;
    Compile;
    DoCheckSyntax := False;
End;

Procedure TCompiler.Compile(SingleFile: String);
Resourcestring
    cMakeLine = '%s -f "%s" all';
    cSingleFileMakeLine = '%s -f "%s" %s';
    cMake = ' make';
    cDots = '...';
Var
    cmdline: String;
    s: String;
    ofile: String;
    cCmdLine: String;
Begin
    cCmdLine := devCompiler.SingleCompile;
    fSingleFile := SingleFile <> '';
    If Assigned(fDevRun) Then
    Begin
        MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0);
        Exit;
    End;

    If fTarget = ctNone Then
        exit;

    DoLogEntry(Format('%s: %s', [Lang[ID_COPT_COMPTAB],
        devCompilerSet.SetName(devCompiler.CompilerSet)]));

    InitProgressForm('Compiling...');

    GetCompileParams;
    GetLibrariesParams;
    GetIncludesParams;

    If fTarget = ctProject Then
    Begin
        BuildMakeFile;
        Application.ProcessMessages;
        If SingleFile <> '' Then
        Begin
            If fProject.CurrentProfile.ObjectOutput <> '' Then
            Begin
                ofile := IncludeTrailingPathDelimiter(
                    fProject.CurrentProfile.ObjectOutput) + ExtractFileName(SingleFile);
                ofile := GenMakePath(ExtractRelativePath(
                    fProject.FileName, ChangeFileExt(ofile, OBJ_EXT)));
            End
            Else
                ofile := GenMakePath(ExtractRelativePath(
                    fProject.FileName, ChangeFileExt(SingleFile, OBJ_EXT)));
            fMakeFile := ExtractRelativePath(fProject.Directory, fMakeFile);

            If (devCompiler.makeName <> '') Then
                cmdline := format(cSingleFileMakeLine,
                    [devCompiler.makeName, fMakeFile, ofile]) + ' ' + devCompiler.makeopts
            Else
                cmdline := format(cSingleFileMakeLine,
                    [MAKE_PROGRAM(devCompiler.CompilerType), fMakeFile, ofile]) +
                    ' ' + devCompiler.makeopts;
        End
        Else
        Begin
            fMakeFile := ExtractRelativePath(fProject.Directory, fMakeFile);

            If (devCompiler.makeName <> '') Then
                cmdline := format(cMakeLine, [devCompiler.makeName, fMakeFile]) +
                    ' ' + devCompiler.makeopts
            Else
                cmdline := format(cMakeLine,
                    [MAKE_PROGRAM(devCompiler.CompilerType), fMakeFile]) + ' ' +
                    devCompiler.makeopts;
        End;

        DoLogEntry(format(Lang[ID_EXECUTING], [cMake + cDots]));
        DoLogEntry(cmdline);
        Sleep(devCompiler.Delay);
        LaunchThread(cmdline, ExtractFilePath(Project.FileName));
    End
    Else
    If (GetFileTyp(fSourceFile) = utRes) Then
    Begin
        If (devCompiler.windresName <> '') Then
            s := devCompiler.windresName
        Else
            s := RES_PROGRAM(devCompiler.CompilerType);

        cmdline := s + ' ' + GenMakePath(fSourceFile) +
            Format(devCompiler.ResourceFormat,
            [GenMakePath(ChangeFileExt(fSourceFile, OBJ_EXT))]);
        DoLogEntry(format(Lang[ID_EXECUTING], [' ' + s + cDots]));
        DoLogEntry(cmdline);
    End
    Else
    Begin
        If (GetFileTyp(fSourceFile) = utSrc) And
            (GetExTyp(fSourceFile) = utCppSrc) Then
        Begin
            If (devCompiler.gppName <> '') Then
                s := devCompiler.gppName
            Else
                s := CPP_PROGRAM(devCompiler.CompilerType);
            If DoCheckSyntax Then
                cmdline := format(cCmdLine,
                    [s, fSourceFile, 'nul', fCppCompileParams,
                    fCppIncludesParams, fLibrariesParams])
            Else
            Begin
                If devCompiler.CompilerType In ID_COMPILER_VC Then
                    cmdline := format(cCmdLine,
                        [s, fSourceFile, fCppCompileParams, fCppIncludesParams,
                        fLibrariesParams])
                Else
                Begin
                    // GAR 10 Nov 2009
                    // Hack for Wine/Linux
                    // ProductName returns empty string for Wine/Linux
                    // for Windows, it returns OS name (e.g. Windows Vista).
                    If (MainForm.JvComputerInfoEx1.OS.ProductName = '') Then
                        cmdline := format(cCmdLine,
                            [s, fSourceFile, ChangeFileExt(fSourceFile, ''),
                            fCppCompileParams, fCppIncludesParams, fLibrariesParams])
                    Else
                        cmdline := format(cCmdLine,
                            [s, fSourceFile, ChangeFileExt(fSourceFile, EXE_EXT),
                            fCppCompileParams, fCppIncludesParams, fLibrariesParams]);

                    cmdline := StringReplace(cmdline, '\', '/', [rfReplaceAll]);
                    // EAB fixes compilation
                End;
            End;
            DoLogEntry(format(Lang[ID_EXECUTING], [' ' + s + cDots]));
            DoLogEntry(cmdline);
        End
        Else
        Begin
            If (devCompiler.gccName <> '') Then
                s := devCompiler.gccName
            Else
                s := CP_PROGRAM(devCompiler.CompilerType);
            If DoCheckSyntax Then
                cmdline := format(cCmdLine,
                    [s, fSourceFile, 'nul', fCompileParams,
                    fIncludesParams, fLibrariesParams])
            Else
            // GAR 10 Nov 2009
            // Hack for Wine/Linux
            // ProductName returns empty string for Wine/Linux
            // for Windows, it returns OS name (e.g. Windows Vista).
            If (MainForm.JvComputerInfoEx1.OS.ProductName = '') Then
                cmdline := format(cCmdLine,
                    [s, fSourceFile, ChangeFileExt(fSourceFile, ''),
                    fCompileParams, fIncludesParams, fLibrariesParams])
            Else
                cmdline := format(cCmdLine,
                    [s, fSourceFile, ChangeFileExt(fSourceFile, EXE_EXT),
                    fCompileParams, fIncludesParams, fLibrariesParams]);

            DoLogEntry(format(Lang[ID_EXECUTING], [' ' + s + cDots]));
            DoLogEntry(cmdline);
        End;

        LaunchThread(cmdline, ExtractFilePath(fSourceFile));
    End;
End;

Function TCompiler.Clean: Boolean;
Const
    cCleanLine = '%s clean -f "%s" %s';
    cmsg = ' make clean';
Var
    cmdLine: String;
    s: String;
Begin
    fSingleFile := True;
    // fool clean; don't run deps checking since all we do is cleaning
    If Project <> Nil Then
    Begin
        DoLogEntry(Format('%s: %s', [Lang[ID_COPT_COMPTAB],
            devCompilerSet.SetName(devCompiler.CompilerSet)]));
        Result := True;
        InitProgressForm('Cleaning...');
        BuildMakeFile;
        If Not FileExists(fMakefile) Then
        Begin
            DoLogEntry(Lang[ID_ERR_NOMAKEFILE]);
            DoLogEntry(Lang[ID_ERR_CLEANFAILED]);
            MessageBox(Application.MainForm.Handle,
                Pchar(Lang[ID_ERR_NOMAKEFILE]),
                Pchar(Lang[ID_ERROR]), MB_OK Or MB_ICONHAND);
            Result := False;
            Exit;
        End;

        DoLogEntry(Format(Lang[ID_EXECUTING], [cmsg]));
        If (devCompiler.makeName <> '') Then
            s := devCompiler.makeName
        Else
            s := MAKE_PROGRAM(devCompiler.CompilerType);

        fMakeFile := ExtractRelativePath(fProject.Directory, fMakeFile);

        cmdLine := Format(cCleanLine, [s, fMakeFile, devCompiler.MakeOpts]);
        LaunchThread(cmdLine, fProject.Directory);
    End
    Else
        Result := False;
End;

Function TCompiler.RebuildAll: Boolean;
Const
    cCleanLine = '%s -f "%s" clean all';
    cmsg = ' make clean';
Var
    cmdLine: String;
    s: String;
Begin
    fSingleFile := True;
    // fool rebuild; don't run deps checking since all files will be rebuilt
    Result := True;

    DoLogEntry(Format('%s: %s',
        [Lang[ID_COPT_COMPTAB], devCompilerSet.SetName(devCompiler.CompilerSet)]));
    InitProgressForm('Rebuilding...');
    If Project <> Nil Then
    Begin
        BuildMakeFile;
        If Not FileExists(fMakefile) Then
        Begin
            DoLogEntry(Lang[ID_ERR_NOMAKEFILE]);
            DoLogEntry(Lang[ID_ERR_CLEANFAILED]);
            MessageBox(Application.MainForm.Handle,
                Pchar(Lang[ID_ERR_NOMAKEFILE]),
                Pchar(Lang[ID_ERROR]), MB_OK Or MB_ICONERROR);
            Result := False;
            Exit;
        End;

        DoLogEntry(Format(Lang[ID_EXECUTING], [cmsg]));

        If (devCompiler.makeName <> '') Then
            s := devCompiler.makeName
        Else
            s := MAKE_PROGRAM(devCompiler.CompilerType);

        fMakeFile := ExtractRelativePath(fProject.Directory, fMakeFile);
        cmdLine := Format(cCleanLine, [s, fMakeFile]) + ' ' + devCompiler.makeopts;
        LaunchThread(cmdLine, fProject.Directory);
    End
    Else
    Begin
        Compile;
        Result := True;
    End;
End;

Procedure TCompiler.LaunchThread(s, dir: String);
Begin
    If Assigned(fDevRun) Then
        MessageDlg(Lang[ID_MSG_ALREADYCOMP], mtInformation, [mbOK], 0)
    Else
    Begin
        Application.ProcessMessages;
        fStartCompile := GetTickCount Div 1000;
        fAbortThread := False;
        fDevRun := TDevRun.Create(True);
        fDevRun.Command := s;
        fDevRun.Directory := dir;
        fDevRun.OnTerminate := OnCompilationTerminated;
        fDevRun.OnLineOutput := OnLineOutput;
        fDevRun.FreeOnTerminate := True;
        fDevRun.Resume;
    End;
End;

Procedure TCompiler.AbortThread;
Begin
    If Not Assigned(fDevRun) Then
        Exit;
    fDevRun.Terminate;
    fAbortThread := True;
End;

Procedure TCompiler.OnAbortCompile(Sender: TObject);
Begin
    If Assigned(fDevRun) Then
    Begin
        fDevRun.Terminate;
        fAbortThread := True;
    End
    Else
        ReleaseProgressForm;
End;

Procedure TCompiler.OnCompilationTerminated(Sender: TObject);
Var
    FWinfo: TFlashWInfo;
    MainForm: TMainForm;
Begin
    ParseResults;
    EndProgressForm;
    DoLogEntry(Lang[ID_EXECUTIONTERM]);
    MainForm := TMainForm(Application.MainForm);

    If fAbortThread Then
        DoLogEntry(Lang[ID_COMPILEABORT])
    Else
    If (fErrCount = 0) And (fDevRun.ExitCode = 0) Then
    Begin
        DoLogEntry(Lang[ID_COMPILESUCCESS]);
        DoLogEntry('Compilation took ' + TCompileProgressForm.FormatTime(
            (GetTickCount Div 1000) - fStartCompile) + ' to complete');
        Application.ProcessMessages;
        MainForm.StatusBar.Panels[3].Text :=
            Lang[ID_COMPILESUCCESS] + '; Compilation took ' +
            TCompileProgressForm.FormatTime(
            (GetTickCount Div 1000) - fStartCompile);
        If Assigned(OnCompilationEnded) Then
            OnCompilationEnded(Self);
    End
    Else
    Begin
        DoLogEntry('Compilation Failed. Make returned ' +
            IntToStr(fDevRun.ExitCode));
        MainForm.StatusBar.Panels[3].Text :=
            Format('Compilation failed with %d errors and %d warnings',
            [fErrCount, fWarnCount]);
    End;

    //Clean up
    fDevRun := Nil;
    OnCompilationEnded := Nil;
    Application.ProcessMessages;

    //Flash the taskbar icon if the form is minimized
    If IsIconic(Application.Handle) Then
    Begin
        FWinfo.cbSize := SizeOf(FWinfo);
        FWinfo.hwnd := Application.Handle;
        FWinfo.dwflags := FLASHW_ALL;
        FWinfo.ucount := 10;
        FWinfo.dwtimeout := 0;
        FlashWindowEx(FWinfo);
    End;
End;

Procedure TCompiler.OnLineOutput(Sender: TObject; Const Line: String);
Begin
    ParseLine(Line);
    DoLogEntry(Line);
    ProcessProgressForm(Line);
End;

Procedure TCompiler.ParseLine(Line: String);
Var
    RegEx: TRegExpr;
    LowerLine: String;
    cpos: Integer;
Begin
    RegEx := TRegExpr.Create;

    Try
        If (devCompiler.compilerType In ID_COMPILER_VC) Then
        Begin
            //Check for command line errors
            RegEx.Expression := 'Command line error (.*) : (.*)';
            If RegEx.Exec(Line) Then
                Inc(fErrCount);

            //Command line warnings
            RegEx.Expression := 'Command line warning (.*) : (.*)';
            If RegEx.Exec(Line) Then
                Inc(fWarnCount);

            //Fatal error
            RegEx.Expression := '(.*)\(([0-9]+)\) : fatal error ([^:]*): (.*)';
            If Regex.Exec(Line) Then
                Inc(fErrCount);

            //LINK fatal error
            RegEx.Expression := 'LINK : fatal error ([^:]*): (.*)';
            If RegEx.Exec(Line) Then
                Inc(fErrCount);

            //General compiler error
            RegEx.Expression := '(.*)\(([0-9]+)\) : error ([^:]*): (.*)';
            If RegEx.Exec(Line) Then
                Inc(fErrCount);

            //Compiler warning
            RegEx.Expression := '(.*)\(([0-9]+)\) : warning ([^:]*): (.*)';
            If RegEx.Exec(Line) Then
                Inc(fWarnCount);
        End
        Else //if (devCompiler.CompilerType = ID_COMPILER_MINGW) or (devCompiler.compilerType = ID_COMPILER_DMARS) then
        Begin
            LowerLine := LowerCase(Line);

            { Make errors }
            If (Pos('make.exe: ***', LowerCase(Line)) > 0) And
                (Pos('Clock skew detected. Your build may be incomplete',
                LowerCase(Line)) <= 0) Then
            Begin
                If fErrCount = 0 Then
                    fErrCount := 1;
            End;

            { windres errors }
            If Pos('windres.exe: ', LowerCase(Line)) > 0 Then
            Begin
                { Delete 'windres.exe :' }
                Delete(Line, 1, 13);

                cpos := GetLastPos('warning: ', Line);
                If cpos > 0 Then
                Begin
                    { Delete 'warning: ' }
                    Delete(Line, 1, 9);
                    cpos := Pos(':', Line);
                    Delete(Line, 1, cpos);
                    Inc(fWarnCount);
                End
                Else
                Begin
                    { Does it contain a filename and line number? }
                    cpos := GetLastPos(':', Line);
                    If (cpos > 0) And (Pos(':', Line) <> cpos) Then
                    Begin
                        Delete(Line, cpos, Length(Line) - cpos + 1);
                        cpos := GetLastPos(':', Line);
                        Delete(Line, cpos, Length(Line) - 1);
                    End;
                    Inc(fErrCount);
                End;
            End;


            { foo.c: In function 'bar': }
            If Pos('In function', Line) > 0 Then
            Begin
                { Get message }
                cpos := GetLastPos(': ', Line);
                Delete(Line, cpos, Length(Line) - cpos + 1);
                Inc(fWarnCount);
            End;

            { In file included from C:/foo.h:1, }
            If Pos('In file included from ', Line) > 0 Then
            Begin
                Delete(Line, Length(Line), 1);
                cpos := GetLastPos(':', Line);
                Delete(Line, cpos, Length(Line) - cpos + 1);
            End;

            { from blabla.c:1: }
            If Pos('                 from ', Line) > 0 Then
            Begin
                Delete(Line, Length(Line), 1);
                cpos := GetLastPos(':', Line);
                Delete(Line, cpos, Length(Line) - cpos + 1);
            End;


            { foo.cpp: In method `bool MyApp::Bar()': }
            cpos := GetLastPos('In method `', Line);
            // GCC >= 3.2 support
            If cpos <= 0 Then
                { foo.cpp: In member function `bool MyApp::Bar()': }
                cpos := GetLastPos('In member function `', Line);
            If cpos <= 0 Then
                { foo.cpp: In constructor `MyApp::MyApp()': }
                cpos := GetLastPos('In constructor `', Line);
            If cpos <= 0 Then
                { foo.cpp: In destructor `MyApp::MyApp()': }
                cpos := GetLastPos('In destructor `', Line);
            If cpos > 0 Then
            Begin
                Delete(Line, cpos - 2, Length(Line) - cpos + 3);
            End;


            { C:\TEMP\foo.o(.text+0xc)://C/bar.c: undefined reference to `hello' }
            cpos := Pos('undefined reference to ', Line);
            If cpos > 0 Then
            Begin
                Inc(fErrCount);
            End;


            { foo.cpp:1:[2:] bar.h: No such file or directory }
            cpos := GetLastPos('No such file or directory', Line);
            If cpos > 0 Then
            Begin
                Inc(fErrCount);
            End;

            { foo.cpp:1: candidates are: FooClass::Bar(void) }
            cpos := GetLastPos(': candidates are: ', Line);
            If cpos > 0 Then
            Begin
                Delete(Line, cpos, Length(Line) - cpos + 1);
                cpos := GetLastPos(':', Line);
                Delete(Line, cpos, Length(Line) - cpos + 1);
            End;

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
            If cpos > 0 Then
            Begin // mandrav fix
                Delete(Line, cpos + 2, Length(Line) - cpos - 1);

                cpos := Pos('warning: ', Line);
                If cpos > 0 Then
                Begin
                    Inc(fWarnCount);
                    Delete(Line, cpos - 2, Length(Line) - cpos + 2);
                End;

                // GCC >= 3.2. support
                If Pos(': error', Line) > 0 Then
                Begin
                    Delete(Line, Pos(': error', Line), Length(Line) - cpos + 1);
                    cpos := GetLastPos(':', Line);
                    Delete(Line, cpos, Length(Line) - cpos + 1);
                End
                Else
                Begin
                    cpos := GetLastPos(':', Line);
                    If StrToIntDef(Copy(Line, cpos + 1, Length(Line) - cpos - 1),
                        -1) <> -1 Then
                    Begin
                        Delete(Line, cpos, Length(Line) - cpos + 1);
                        //filename may also contain column as "filename:line:col"
                        cpos := GetLastPos(':', Line);
                        If StrToIntDef(Copy(Line, cpos + 1, Length(Line) - cpos),
                            -1) <> -1 Then
                        Begin
                            Delete(Line, cpos, Length(Line) - cpos + 1);
                        End;
                    End;
                End;
            End;
        End;
    Finally
        RegEx.Free;
    End;

    If Assigned(CompileProgressForm) Then
        With CompileProgressForm Do
        Begin
            lblErr.Caption := IntToStr(fErrCount);
            lblWarn.Caption := IntToStr(fWarnCount);
        End;
End;

Procedure TCompiler.ParseResults;
Var
    LOutput: TStringList;
    cpos, curLine: Integer;
    O_file, // file error in
    O_Line, // line error on
    O_Msg, // message for error
    Line, LowerLine: String;
    Messages, IMod: Integer;
    gcc, gpp: String;
    RegEx: TRegExpr;

Begin
    Messages := 0;
    fErrCount := 0;
    RegEx := TRegExpr.Create;
    LOutput := TStringList.Create;

    If (devCompiler.gccName <> '') Then
        gcc := devCompiler.gccName
    Else
        gcc := CP_PROGRAM(devCompiler.CompilerType);
    If (devCompiler.gppName <> '') Then
        gpp := devCompiler.gppName
    Else
        gpp := CPP_PROGRAM(devCompiler.CompilerType);
    Try
        LOutput.Text := fdevRun.Output;

        IMod := CalcMod(pred(LOutput.Count));

        // Concatenate errors which are on multiple lines
        If ((devCompiler.CompilerType = ID_COMPILER_MINGW) Or
            (devCompiler.CompilerType = ID_COMPILER_LINUX)) Then
            For curLine := 0 To pred(LOutput.Count) Do
            Begin
                If (curLine > 0) And AnsiStartsStr('   ', LOutput[curLine]) Then
                Begin
                    O_Msg := LOutput[curLine];
                    Delete(O_Msg, 1, 2);
                    LOutput[curLine - 1] := LOutput[curLine - 1] + O_Msg;
                End;
            End;

        For curLine := 0 To pred(LOutput.Count) Do
        Begin
            If (IMod = 0) Or (curLine Mod IMod = 0) Then
                Application.ProcessMessages;

            If Messages > 500 Then
            Begin
                DoOutput('', '', Format(Lang[ID_COMPMSG_GENERALERROR],
                    [Lang[ID_COMPMSG_TOOMANYMSGS]]));
                Break;
            End;

            Line := LOutput.Strings[curLine];
            LowerLine := LowerCase(Line);
            O_Msg := '';
            O_Line := '';
            O_File := '';

            If devCompiler.compilerType In ID_COMPILER_VC Then
            Begin
                //Do we have to ignore this message?
                If
                (Line = '') Or //Empty line?!
                    (Copy(Line, 1, Length(devCompiler.gccName)) = devCompiler.gccName) Or
                    (Copy(Line, 1, Length(devCompiler.gppName)) = devCompiler.gppName) Or
                    (Copy(Line, 1, Length(devCompiler.dllwrapName)) =
                    devCompiler.dllwrapName) Or
                    (Copy(Line, 1, Length(devCompiler.windresName)) =
                    devCompiler.windresName) Or
                    (Copy(Line, 1, Length(devCompiler.gprofName)) =
                    devCompiler.gprofName) Or
                    (Copy(Line, 1, Length(RmExe)) = RmExe) Or
                    (Copy(Line, 1, 19) = '   Creating library') Or
                    (Length(Line) = 2) Or //One word lines?
                    (Pos('*** [', Line) > 0) Or
                    (((Pos('.c', Line) > 0) Or (Pos('.cpp', Line) > 0)) And
                    (Pos('(', Line) = 0)) Or
                    (Pos('Nothing to be done for', Line) > 0) Or
                    (Pos('while trying to match the argument list', Line) > 0) Or
                    (Line = 'Generating code') Or
                    (Line = 'Finished generating code')
                Then
                    continue;

                //Check for command line errors
                If RegEx.Exec(Line, 'Command line error ([^:]*) : (.*)') Then
                Begin
                    O_Msg := RegEx.Substitute('[Command line error $1] $2');
                    Inc(fErrCount);
                End
                //Command line warnings
                Else
                If RegEx.Exec(Line, 'Command line warning ([^:]*) : (.*)') Then
                Begin
                    O_Msg := RegEx.Substitute('[Command line warning $1] $2');
                    Inc(fWarnCount);
                End
                //Fatal error
                Else
                If Regex.Exec(Line, '(.*)\(([0-9]+)\) : fatal error ([^:]*): (.*)') Then
                Begin
                    O_Msg := RegEx.Substitute('[Error $3] $4');
                    O_Line := RegEx.Substitute('$2');
                    O_File := RegEx.Substitute('$1');
                    Inc(fErrCount);
                End
                //LINK fatal error
                Else
                If RegEx.Exec(Line, 'LINK : fatal error ([^:]*): (.*)') Then
                Begin
                    O_Msg := RegEx.Substitute('[Error $1] $2');
                    Inc(fErrCount);
                End
                //General compiler error
                Else
                If RegEx.Exec(Line, '(.*)\(([0-9]+)\) : error ([^:]*): (.*)') Then
                Begin
                    O_Msg := RegEx.Substitute('[Error $3] $4');
                    O_Line := RegEx.Substitute('$2');
                    O_File := RegEx.Substitute('$1');
                    Inc(fErrCount);
                End
                //Compiler warning
                Else
                If RegEx.Exec(Line, '(.*)\(([0-9]+)\) : warning ([^:]*): (.*)') Then
                Begin
                    O_Msg := RegEx.Substitute('[Warning $3] $4');
                    O_Line := RegEx.Substitute('$2');
                    O_File := RegEx.Substitute('$1');
                    Inc(fWarnCount);
                End
                //LINK error
                Else
                If RegEx.Exec(Line, '(.*)\((.*)\) : error ([^:]*): (.*)') Then
                Begin
                    O_Msg := RegEx.Substitute('[Error $3] $4');
                    O_File := RegEx.Substitute('$2');
                    Inc(FErrCount);
                End
                Else
                If RegEx.Exec(Line, '(.*) : error ([^:]*): (.*)') Then
                Begin
                    O_Msg := RegEx.Substitute('[Error $2] $3');
                    O_File := RegEx.Substitute('$1');
                    Inc(fErrCount);
                End
                Else
                If RegEx.Exec(Line, 'LINK : warning ([^:]*): (.*)') Then
                Begin
                    O_Msg := RegEx.Substitute('[Warning $1] $2');
                    Inc(fWarnCount);
                End
                //General compiler errors can produce extra filenames at the end. Take those into account
                Else
                If RegEx.Exec(Line,
                    '( +)(.*)\(([0-9]+)\)(| ): (could be|or|see declaration of) ''(.*)''') Then
                Begin
                    O_Msg := RegEx.Substitute('$1$5 $6');
                    O_Line := RegEx.Substitute('$3');
                    O_File := RegEx.Substitute('$2');
                End
                //Do we have any spare messages floating around?
                Else
                    O_Msg := Line;
            End
            Else //ID_COMPILER_MINGW
            Begin
                Line := LOutput.Strings[curLine];
                LowerLine := LowerCase(Line);
                { Is this a compiler message? }
                If (Pos(':', Line) <= 0) Or
                    (CompareText(Copy(LowerLine, 1, Length(gpp)), gpp) = 0) Or
                    (CompareText(Copy(LowerLine, 1, Length(gcc)), gcc) = 0) Or
                    (CompareText(Copy(LowerLine, 1, Length(devCompiler.dllwrapName) + 1),
                    devCompiler.dllwrapName + ' ') = 0) Or
                    (Pos(devCompiler.makeName + ': nothing to be done for ',
                    LowerLine) > 0) Or
                    (Pos('has modification time in the future', LowerLine) > 0) Or
                    (Pos(devCompiler.dllwrapName + ':', LowerLine) > 0) Or
                    (Pos('is up to date.', LowerLine) > 0)
                Then
                    Continue;

                { Make errors }
                If (Pos(devCompiler.makeName + ': ***', LowerCase(Line)) > 0) And
                    (Pos('Clock skew detected. Your build may be incomplete',
                    LowerCase(Line)) <= 0) Then
                Begin
                    cpos := Length(devCompiler.makeName + ': ***');
                    O_Msg := '[Build Error] ' + Copy(Line, cpos + 1, Length(Line) - cpos);

                    If Assigned(fProject) Then
                        O_file := Makefile
                    Else
                        O_file := '';

                    If Messages = 0 Then
                        Messages := 1;
                    If fErrCount = 0 Then
                        fErrCount := 1;

                    DoOutput('', O_file, O_Msg);
                    Continue;
                End;


                { windres errors }
                If Pos(devCompiler.windresName + ': ', LowerCase(Line)) > 0 Then
                Begin
                    { Delete 'windres.exe :' }
                    Delete(Line, 1, Length(devCompiler.windresName) + 2);

                    cpos := GetLastPos('warning: ', Line);
                    If cpos > 0 Then
                    Begin
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
                    End
                    Else
                    Begin
                        { Does it contain a filename and line number? }
                        cpos := GetLastPos(':', Line);
                        If (cpos > 0) And (Pos(':', Line) <> cpos) Then
                        Begin
                            O_Msg := Copy(Line, cpos + 2, Length(Line) - cpos - 1);
                            Delete(Line, cpos, Length(Line) - cpos + 1);

                            cpos := GetLastPos(':', Line);
                            O_Line := Copy(Line, cpos + 1, Length(Line) - 2);
                            Delete(Line, cpos, Length(Line) - 1);

                            O_file := Line;

                            { It doesn't contain a filename and line number after all }
                            If StrToIntDef(O_Line, -1) = -1 Then
                            Begin
                                O_Msg := LOutput.Strings[curLine];
                                Delete(O_Msg, 1, 13);
                                O_Line := '';
                                O_file := '';
                            End;
                        End
                        Else
                        Begin
                            O_Line := '';
                            O_file := '';
                            O_Msg := Line;
                        End;

                        Inc(Messages);
                        Inc(fErrCount);
                        DoResOutput(O_Line, O_file, O_Msg);
                        DoOutput(O_Line, O_file,
                            Format(Lang[ID_COMPMSG_RESOURCEERROR], [O_Msg]));
                        Continue;
                    End;
                End;


                { foo.c: In function 'bar': }
                If Pos('In function', Line) > 0 Then
                Begin
                    { Get message }
                    cpos := GetLastPos(': ', Line);
                    O_Msg := Copy(Line, cpos + 2, Length(Line) - cpos - 1);
                    Delete(Line, cpos, Length(Line) - cpos + 1);

                    { Get file }
                    O_file := Line;

                    Inc(fWarnCount);
                    DoOutput('', O_file, O_Msg + ':');
                    Continue;
                End;

                { In file included from C:/foo.h:1, }
                If Pos('In file included from ', Line) > 0 Then
                Begin
                    Delete(Line, Length(Line), 1);
                    cpos := GetLastPos(':', Line);
                    O_Line := Copy(Line, cpos + 1, Length(Line) - cpos);
                    Delete(Line, cpos, Length(Line) - cpos + 1);
                    O_Msg := Line;

                    cpos := Length('In file included from ');
                    O_file := Copy(Line, cpos + 1, Length(Line) - cpos);

                    DoOutput(O_Line, O_file, O_Msg);
                    Continue;
                End;

                { from blabla.c:1: }
                If Pos('                 from ', Line) > 0 Then
                Begin
                    Delete(Line, Length(Line), 1);
                    cpos := GetLastPos(':', Line);
                    O_Line := Copy(Line, cpos + 1, Length(Line) - cpos);
                    Delete(Line, cpos, Length(Line) - cpos + 1);
                    O_Msg := Line;

                    cpos := Length('                 from ');
                    O_file := Copy(Line, cpos + 1, Length(Line) - cpos);

                    DoOutput(O_Line, O_file, O_Msg);
                    Continue;
                End;


                { foo.cpp: In method `bool MyApp::Bar()': }
                cpos := GetLastPos('In method ''', Line);
                // GCC >= 3.2 support
                If cpos <= 0 Then
                    { foo.cpp: In member function `bool MyApp::Bar()': }
                    cpos := GetLastPos('In member function ''', Line);
                If cpos <= 0 Then
                    { foo.cpp: In constructor `MyApp::MyApp()': }
                    cpos := GetLastPos('In constructor `', Line);
                If cpos <= 0 Then
                    { foo.cpp: In destructor `MyApp::MyApp()': }
                    cpos := GetLastPos('In destructor ''', Line);
                If cpos > 0 Then
                Begin
                    O_Msg := Copy(Line, cpos, Length(Line) - cpos + 1);
                    Delete(Line, cpos - 2, Length(Line) - cpos + 3);
                    O_file := Line;

                    DoOutput('', O_file, O_Msg);
                    Continue;
                End;


                { C:\TEMP\foo.o(.text+0xc)://C/bar.c: undefined reference to `hello' }
                cpos := Pos('undefined reference to ', Line);
                If cpos > 0 Then
                Begin
                    O_Msg := Line;
                    Delete(O_Msg, 1, cpos - 1);

                    Inc(fErrCount);
                    Inc(Messages);
                    DoOutput('', '', Format(Lang[ID_COMPMSG_LINKERERROR], [O_Msg]));
                    Continue;
                End;


                { foo.cpp:1:[2:] bar.h: No such file or directory }
                cpos := GetLastPos('No such file or directory', Line);
                If cpos > 0 Then
                Begin
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
                End;

                { foo.cpp:1: candidates are: FooClass::Bar(void) }
                cpos := GetLastPos(': candidates are: ', Line);
                If cpos > 0 Then
                Begin
                    O_Msg := Copy(Line, cpos + 2, Length(Line) - cpos - 1);
                    Delete(Line, cpos, Length(Line) - cpos + 1);

                    cpos := GetLastPos(':', Line);
                    O_Line := Copy(Line, cpos + 1, Length(Line) - cpos);
                    Delete(Line, cpos, Length(Line) - cpos + 1);

                    O_file := Line;

                    DoOutput(O_Line, O_file, O_Msg);
                    Continue;
                End;

                { windres.exe ... }//normal command, *not* an error
                cpos := GetLastPos(devCompiler.windresName + ' ', Line);
                If cpos > 0 Then
                Begin
                    Line := '';
                    Continue;
                End;

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
                If cpos > 0 Then
                Begin // mandrav fix

                    O_Msg := Copy(Line, cpos + 2, Length(Line) - cpos - 1);
                    Delete(Line, cpos + 2, Length(Line) - cpos - 1);

                    cpos := Pos('warning: ', Line);
                    If cpos > 0 Then
                    Begin
                        Inc(fWarnCount);
                        If Pos('warning: ignoring pragma: ', Line) > 0 Then
                            O_Msg := 'ignoring pragma: ' + O_Msg;
                        If Pos('#warning ', O_Msg) <= 0 Then
                            O_Msg := '[Warning] ' + O_Msg;

                        { Delete 'warning: ' }
                        Delete(Line, cpos - 2, Length(Line) - cpos + 2);
                    End
                    Else
                    If Pos('Info: ', Line) = 1 Then
                    Begin
                        O_Line := '';
                        O_file := '';
                        Delete(Line, 1, 6);
                        O_Msg := '[Info] ' + Line;
                    End
                    Else
                    Begin
                        //We have no idea what this is, just call it a normal message
                        Delete(Line, Length(Line) - 1, 1);
                    End;
                    Inc(Messages);


                    // GCC >= 3.2. support
                    If Pos(': error', Line) > 0 Then
                    Begin
                        Delete(Line, Pos(': error', Line), Length(Line) - cpos + 1);
                        cpos := GetLastPos(':', Line);
                        O_Line := Copy(Line, cpos + 1, Length(Line) - cpos + 1);
                        Delete(Line, cpos, Length(Line) - cpos + 1);
                        O_file := Line;
                    End
                    Else
                    Begin
                        cpos := GetLastPos(':', Line);
                        If StrToIntDef(Copy(Line, cpos + 1, Length(Line) - cpos - 1),
                            -1) <> -1 Then
                        Begin
                            O_Line := Copy(Line, cpos + 1, Length(Line) - cpos - 1);
                            Delete(Line, cpos, Length(Line) - cpos + 1);
                            O_file := Line;
                            //filename may also contain column as "filename:line:col"
                            cpos := GetLastPos(':', Line);
                            If StrToIntDef(Copy(Line, cpos + 1, Length(Line) - cpos),
                                -1) <> -1 Then
                            Begin
                                O_Line := Copy(Line, cpos + 1, Length(Line) - cpos) +
                                    ':' + O_Line;
                                Delete(Line, cpos, Length(Line) - cpos + 1);
                                O_file := Line;
                            End;
                        End;
                    End;

                    cpos := Pos('parse error before ', O_Msg);
                    If (cpos > 0) And (StrToIntDef(O_Line, 0) > 0) Then
                        O_Line := IntToStr(StrToInt(O_Line)); // - 1); *mandrav*: why -1 ???

                    If (Pos('(Each undeclared identifier is reported only once',
                        O_Msg) > 0) Or (Pos('for each function it appears in.)',
                        O_Msg) > 0) Or (Pos('At top level:', O_Msg) > 0) Then
                    Begin
                        O_Line := '';
                        O_file := '';
                        Dec(Messages);
                    End;

                    { This is an error in the Makefile }
                    If (MakeFile <> '') And SameFileName(Makefile,
                        GetRealPath(O_file)) Then
                        If Pos('[Warning] ', O_Msg) <> 1 Then
                            O_Msg := '[Build Error] ' + O_Msg;
                End;
            End;

            Inc(Messages);
            DoOutput(O_Line, O_file, O_Msg);
        End;
    Finally
        RegEx.Free;
        Application.ProcessMessages;
        If devCompiler.SaveLog Then
            Try
                If (fTarget = ctProject) And assigned(fProject) Then
                    LOutput.SavetoFile(ChangeFileExt(fProject.FileName, '.compiler.out'))
                Else
                    LOutput.SavetoFile(ChangeFileExt(fSourceFile, '.compiler.out'));
            Except
                // swallow
            End;
        LOutput.Free;
    End;

    // there are no compiler errors/warnings
    If (Assigned(fOnSuccess)) Then
        fOnSuccess(Messages);
End;

Function TCompiler.GetCompiling: Boolean;
Begin
    Result := fDevRun <> Nil;
End;

Procedure TCompiler.SwitchToOriginalCompilerSet;
Begin
    If fOriginalSet = devCompiler.CompilerSet Then
        Exit;

    devCompilerSet.LoadSet(fOriginalSet);
    devCompilerSet.AssignToCompiler;
    devCompiler.CompilerSet := fOriginalSet;
    fOriginalSet := -1;
End;

Procedure TCompiler.SwitchToProjectCompilerSet;
Begin
    If fOriginalSet = -1 Then
        fOriginalSet := devCompiler.CompilerSet;

    If (Not Assigned(fProject)) Or
        (devCompiler.CompilerSet = fProject.CurrentProfile.CompilerSet) Or
        (fProject.CurrentProfile.CompilerSet >= devCompilerSet.Sets.Count) Then
        Exit;

    devCompilerSet.LoadSet(fProject.CurrentProfile.CompilerSet);
    devCompilerSet.AssignToCompiler;
    devCompiler.CompilerSet := fProject.CurrentProfile.CompilerSet;
End;

Procedure TCompiler.SetProject(Project: TProject);
Begin
    //Just assign it
    fProject := Project;

    //Do we swap the compiler set?
    If fProject <> Nil Then
        SwitchToProjectCompilerSet
    Else
        SwitchToOriginalCompilerSet;
End;

Function TCompiler.UpToDate: Boolean;
Var
    sa: TSecurityAttributes;
    tpi: TProcessInformation;
    tsi: TStartupInfo;
    ec: Cardinal;
Begin
    Result := False;
    Assert(fTarget = ctProject);
    sa.nLength := SizeOf(TSecurityAttributes);
    sa.lpSecurityDescriptor := Nil;
    sa.bInheritHandle := True;

    FillChar(tsi, SizeOf(TStartupInfo), 0);
    tsi.cb := SizeOf(TStartupInfo);
    tsi.dwFlags := STARTF_USESHOWWINDOW;
    If CreateProcess(Nil, Pchar(format('%s -q -f "%s" all',
        [devCompiler.makeName, MakeFile]) +
        ' ' + devCompiler.makeopts), @sa,
        @sa, True, 0, Nil,
        Nil, tsi, tpi) Then
    Begin
        //Wait for make to come up with a result
        While WaitForSingleObject(tpi.hProcess, 100) = WAIT_TIMEOUT Do
            Application.ProcessMessages;

        If GetExitCodeProcess(tpi.hProcess, ec) Then
            Result := ec = 0;
    End;
    CloseHandle(tpi.hProcess);
    CloseHandle(tpi.hThread);
End;

Procedure TCompiler.InitProgressForm(Status: String);
Begin
    If Not devData.ShowProgress Then
        exit;
    If Not Assigned(CompileProgressForm) Then
        CompileProgressForm := TCompileProgressForm.Create(Application);
    With CompileProgressForm Do
    Begin
        Memo1.Lines.Clear;
        btnClose.Caption := Lang[ID_BTN_CANCEL];
        btnClose.OnClick := OnAbortCompile;
        Show;
        Memo1.Lines.Add(Format('%s: %s', [Lang[ID_COPT_COMPTAB],
            devCompilerSet.SetName(devCompiler.CompilerSet)]));
        lblCompiler.Caption := devCompilerSet.SetName(devCompiler.CompilerSet);
        lblStatus.Caption := Status;
        lblStatus.Font.Style := [];
        lblFile.Caption := '';
        lblErr.Caption := '0';
        lblWarn.Caption := '0';
        pb.Position := 0;
        pb.Step := 1;
        If Assigned(fProject) Then
            pb.Max := fProject.Units.Count +
                2  // all project units + linking output + private resource
        Else
            pb.Max := 1; // just fSourceFile
    End;
    fWarnCount := 0;
    fErrCount := 0;
    Application.ProcessMessages;
End;

Procedure TCompiler.EndProgressForm;
Var
    sMsg: String;
Begin
    If Assigned(CompileProgressForm) Then
    Begin
        With CompileProgressForm Do
        Begin
            pb.Position := 0;
            btnClose.Caption := Lang[ID_BTN_CLOSE];
            lblErr.Caption := IntToStr(fErrCount);
            lblWarn.Caption := IntToStr(fWarnCount);
            If fAbortThread Then
                sMsg := 'Aborted'
            Else
                sMsg := 'Done';
            If fErrCount > 0 Then
                sMsg := sMsg + ' with errors.'
            Else
            If fWarnCount > 0 Then
                sMsg := sMsg + ' with warnings.'
            Else
                sMsg := sMsg + '.';
            Memo1.Lines.Add(sMsg);
            lblStatus.Caption := sMsg;
            lblStatus.Font.Style := [fsBold];
            lblFile.Caption := '';
            timeTimer.Enabled := False;
        End;
        Application.ProcessMessages;
        If devData.AutoCloseProgress Or (fErrCount > 0) Or (fWarnCount > 0) Then
            ReleaseProgressForm;
    End;
End;

Procedure TCompiler.ProcessProgressForm(Line: String);
Var
    I: Integer;
    srch: String;
    schk: Boolean;
    act, fil: String;
    OK: Boolean;
    prog: Integer;
Begin
    If Not Assigned(CompileProgressForm) Then
        Exit;
    With CompileProgressForm Do
    Begin
        // report currently compiling file
        If Not Assigned(fProject) Then
        Begin
            Memo1.Lines.Add(fSourceFile);
            Memo1.Lines.Add('Compiling ' + fil);
            lblStatus.Caption := 'Compiling...';
            lblFile.Caption := fSourceFile;
            Exit;
        End;

        // the progress reported is the index of the unit in the project
        prog := pb.Position;
        OK := False;
        schk := Pos(devCompiler.CheckSyntaxFormat, Line) > 0;
        If schk Then
            act := 'Syntax checking'
        Else
        Begin
            schk := Pos('Building Makefile', Line) > 0;
            If schk Then
                act := 'Building Makefile'
            Else
                act := '';
        End;

        srch := Format(devCompiler.PchCreateFormat, ['']);
        If Pos(srch, Line) > 0 Then
        Begin
            OK := False;
            act := 'Precompiling';
            fil := '';

            For i := Pos(srch, Line) + 3 To Length(Line) - Pos(srch, Line) + 3 Do
            Begin
                If (Line[i] = '"') Then
                    OK := Not OK;

                If ((Line[i] = ' ') Or ((Line[i] = '"') And (OK))) Then
                    break
                Else
                    fil := fil + Line[i];
            End;
        End
        Else
        Begin
            fil := '';
            For I := 0 To fProject.Units.Count - 1 Do
            Begin
                srch := ' ' + GenMakePath(ExtractRelativePath(fProject.FileName,
                    fProject.Units[I].FileName), False, True) + ' ';
                If Pos(srch, Line) > 0 Then
                Begin
                    fil := ExtractFilename(fProject.Units[I].FileName);
                    prog := I + 1;
                    If Not schk Then
                        act := 'Compiling';
                    OK := True;

                    //Is it a header file being compiled?
                    If GetFileTyp(fil) = utHead Then
                    Begin
                        act := 'Precompiling';
                        prog := 1;
                    End;
                    Break;
                End;
            End;
            If Not OK Then
            Begin
                srch := ExtractFileName(SubstituteMakeParams(
                    fProject.CurrentProfile.PrivateResource));
                If Pos(srch, Line) > 0 Then
                Begin
                    fil := srch;
                    prog := pb.Max - 1;
                    If Not schk Then
                        act := 'Compiling';
                    lblFile.Caption := srch;
                End;

                srch := ExtractFileName(fProject.Executable);
                If (Pos(srch, Line) > 0) And (Pos(RmExe, Line) > 0) Then
                Begin
                    fil := srch;
                    prog := 1;
                    If Not schk Then
                        act := 'Cleaning';
                    lblFile.Caption := '';
                End
                Else
                If (Pos(srch, Line) > 0) Then
                Begin
                    fil := srch;
                    prog := pb.Max;
                    If Not schk Then
                        act := 'Linking';
                    lblFile.Caption := srch;
                End;

                If devCompiler.CompilerType In ID_COMPILER_VC Then
                Begin
                    //Check for the manifest tool
                    srch := devCompiler.gprofName;
                    If ((devCompiler.CompilerType In ID_COMPILER_VC_CURRENT)) And
                        (Pos(UpperCase(srch), UpperCase(Trim(Line))) = 1) Then
                    Begin
                        act := 'Embedding manifest';
                        fil := Copy(Line, Pos(UpperCase('/outputresource:'),
                            UpperCase(Line)) + 17, Length(Line));
                        fil := Copy(fil, 0, Pos(Line, '"'));
                    End;

                    //Link-time code generation?
                    srch := 'Generating code';
                    If (Pos(UpperCase(srch), UpperCase(Trim(Line)))) = 1 Then
                    Begin
                        act := 'Generating code';
                    End;
                End;
            End;
        End;

        If act + ' ' + fil <> ' ' Then
            Memo1.Lines.Add(Trim(act + ' ' + fil));
        If trim(act) <> '' Then
            lblStatus.Caption := act + '...';
        If trim(fil) <> '' Then
            lblFile.Caption := fil;
        If (fil <> '') And (pb.Position < pb.Max) Then
            pb.Position := prog;
    End;

    Application.ProcessMessages;
End;

Procedure TCompiler.ReleaseProgressForm;
Begin
    If Not Assigned(CompileProgressForm) Then
        Exit;

    CompileProgressForm.Close; // it's freed on close
    CompileProgressForm := Nil;
End;

End.
