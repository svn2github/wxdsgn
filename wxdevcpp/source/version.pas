{
    $Id: version.pas 845 2007-01-20 08:23:50Z gururamnath $

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

Unit version;

Interface

Uses xprocs, SysUtils, Registry, Windows, Classes, utils;

Var
    LIB_EXT: String;
    OBJ_EXT: String;
    PCH_EXT: String;
    COMMON_CPP_INCLUDE_DIR: String;

Const
    //path delimiter
{$IFDEF WIN32}
    pd = '\';
{$ENDIF}
{$IFDEF LINUX}
  pd                   = '/';
{$ENDIF}

Resourcestring
    // misc strings
    DEVCPP = 'wxDev-C++';
    //DEVCPP_VERSION    = '7.4';
    DEVCPP_WEBPAGE = 'http://wxdsgn.sourceforge.net/';
    DEFAULT_LANG_FILE = 'English.lng';
    HTTP = 'http://';
    DEV_INTERNAL_OPEN = '$__DEV_INTERNAL_OPEN';
    DEV_SEARCHLOOP = '$__DEV_SEARCH_LOOP';
    DEV_COMPLETION_CACHE = 'cache.ccc';
    DEV_DEFAULTCODE_FILE = 'defaultcode.cfg';
    DEV_SHORTCUTS_FILE = 'devshortcuts.cfg';
    DEV_CLASSFOLDERS_FILE = 'classfolders.dcf';
    DEV_WEBMIRRORS_FILE = 'mirrors.cfg';
    DEV_MAKE_FILE = 'Makefile.win';
    DEV_TOOLS_FILE = 'tools.ini';
    DEV_HELP_INI = 'devhelp.ini';
    DEV_CODEINS_FILE = 'devcpp.ci';
    DEV_MAINHELP_FILE = 'devcpp.chm';
    DEV_GNOME_THEME = 'Gnome';
    DEV_NEWLOOK_THEME = 'New Look';
    DEV_BLUE_THEME = 'Blue';
    DEV_CLASSIC_THEME = 'Classic';
    DEV_INTERNAL_THEME = 'New Look';

    // default directories
    GCC_BIN_DIR = 'Bin;';
    GCC_LIB_DIR = 'Lib;';
    GCC_C_INCLUDE_DIR = 'Include;';
    GCC_RC_INCLUDE_DIR = 'include' + pd + 'common;';

    //Vc++
    VC2010_BIN_DIR = 'Bin' + pd + 'VC2010;Bin;';
    VC2010_LIB_DIR = 'Lib' + pd + 'VC2010';
    VC2010_C_INCLUDE_DIR = 'Include' + pd + 'common;Include' + pd + 'VC2010;';
    VC2010_RC_INCLUDE_DIR = 'include' + pd + 'common;';

    VC2008_BIN_DIR = 'Bin' + pd + 'VC2008;Bin;';
    VC2008_LIB_DIR = 'Lib' + pd + 'VC2008';
    VC2008_C_INCLUDE_DIR = 'Include' + pd + 'common;Include' + pd + 'VC2008;';
    VC2008_RC_INCLUDE_DIR = 'include' + pd + 'common;';

    VC2005_BIN_DIR = 'Bin' + pd + 'VC2005;Bin;';
    VC2005_LIB_DIR = 'Lib' + pd + 'VC2005';
    VC2005_C_INCLUDE_DIR = 'Include' + pd + 'common;Include' + pd + 'VC2005;';
    VC2005_RC_INCLUDE_DIR = 'include' + pd + 'common;';

    VC2003_BIN_DIR = 'Bin' + pd + 'VC2003;Bin;';
    VC2003_LIB_DIR = 'Lib' + pd + 'VC2003';
    VC2003_C_INCLUDE_DIR = 'Include' + pd + 'common;Include' + pd + 'VC2003;';
    VC2003_RC_INCLUDE_DIR = 'include' + pd + 'common;';

    VC6_BIN_DIR = 'Bin' + pd + 'VC6;Bin;';
    VC6_LIB_DIR = 'Lib' + pd + 'VC6';
    VC6_C_INCLUDE_DIR = 'Include' + pd + 'common;Include' + pd + 'VC6;';
    VC6_RC_INCLUDE_DIR = 'include' + pd + 'common;';

    //DMAR
    DMARS_BIN_DIR = 'Bin;Bin' + pd + 'dmars;';
    DMARS_LIB_DIR = 'Lib' + pd + 'dmars;';
    DMARS_C_INCLUDE_DIR = 'Include' + pd + 'common;Include' + pd + 'dmars;';
    DMARS_RC_INCLUDE_DIR =
        'include' + pd + 'common;' + ';include' + pd + 'dmars' + pd + 'include;' +
        ';include' + pd + 'dmars' + pd + 'include' + pd + 'win32;';

    //Borland
    BORLAND_BIN_DIR = 'Bin;Bin' + pd + 'borland;';
    BORLAND_LIB_DIR = 'Lib' + pd + 'borland;';
    BORLAND_C_INCLUDE_DIR = 'Include' + pd + 'borland;Include' + pd + 'common;';
    BORLAND_RC_INCLUDE_DIR = 'include' + pd + 'common;';

    //Borland
    WATCOM_BIN_DIR = 'Bin;Bin' + pd + 'watcom;';
    WATCOM_LIB_DIR = 'Lib' + pd + 'watcom;';
    WATCOM_C_INCLUDE_DIR = 'Include' + pd + 'watcom;Include' + pd + 'common;';
    WATCOM_RC_INCLUDE_DIR = 'include' + pd + 'common;';

    //Wine/Linux
    LINUX_BIN_DIR = '\bin;\usr\bin';
    LINUX_LIB_DIR = '\usr\lib';
    LINUX_C_INCLUDE_DIR = '\usr\include';
    LINUX_RC_INCLUDE_DIR = '';

    GCC_CPP_INCLUDE_DIR = ';include';

    VC2010_CPP_INCLUDE_DIR =
        ';include' + pd + 'VC2010;' + 'include' + pd + 'common;';

    VC2008_CPP_INCLUDE_DIR =
        ';include' + pd + 'VC2008;' + 'include' + pd + 'common;';

    VC2005_CPP_INCLUDE_DIR =
        ';include' + pd + 'VC2005;' + 'include' + pd + 'common;';

    VC2003_CPP_INCLUDE_DIR =
        ';include' + pd + 'VC2003;' + 'include' + pd + 'common;';

    VC6_CPP_INCLUDE_DIR =
        ';include' + pd + 'VC6;' + 'include' + pd + 'common;';
    BORLAND_CPP_INCLUDE_DIR =
        ';include' + pd + 'borland;' + 'include' + pd + 'common;';

    DMARS_CPP_INCLUDE_DIR =
        ';include' + pd + 'dmars' + pd + 'include;' +
        ';include' + pd + 'dmars' + pd + 'include' + pd + 'win32;' +
        ';include' + pd + 'common;' + ';include' + pd + 'dmars' + pd + 'stlport' + pd + 'stlport;';

    WATCOM_CPP_INCLUDE_DIR =
        ';include' + pd + 'watcom;' + 'include' + pd + 'common;';

    LINUX_CPP_INCLUDE_DIR = '';

    LANGUAGE_DIR = 'Lang' + pd;
    ICON_DIR = 'Icons' + pd;
    HELP_DIR = 'Help' + pd;
    TEMPLATE_DIR = 'Templates' + pd;
    THEME_DIR = 'Themes' + pd;
    PACKAGES_DIR = 'Packages' + pd;

    // file fxtensions
    DLL_EXT = '.dll';
    EXE_EXT = '.exe';
    DEV_EXT = '.dev';
    HTML_EXT = '.html';
    RTF_EXT = '.rtf';
    INI_EXT = '.ini';
    TEMPLATE_EXT = '.template';
    SYNTAX_EXT = '.syntax';

    // programs
    PACKMAN_PROGRAM = 'packman.exe';
    UPDATE_PROGRAM = 'updater.exe';

    GCC_MAKE_PROGRAM = 'mingw32-make.exe';
    GCC_CP_PROGRAM = 'gcc.exe';
    GCC_CPP_PROGRAM = 'g++.exe';
    GCC_DBG_PROGRAM = 'gdb.exe';
    GCC_RES_PROGRAM = 'windres.exe';
    GCC_DLL_PROGRAM = 'dllwrap.exe';
    GCC_PROF_PROGRAM = 'gprof.exe';
    GCC_COMPILER_CMD_LINE = '';
    GCC_LINKER_CMD_LINE = '';
    GCC_MAKE_CMD_LINE = '';

    VC_MAKE_PROGRAM = 'mingw32-make.exe';
    VC_CP_PROGRAM = 'cl.exe';
    VC_CPP_PROGRAM = 'cl.exe';
    VC_DBG_PROGRAM = 'cdb.exe';
    VC_RES_PROGRAM = 'rc.exe';
    VC_DLL_PROGRAM = 'link.exe';
    VC_PROF_PROGRAM = 'mt.exe';
    VC_COMPILER_CMD_LINE = '';
    VC_LINKER_CMD_LINE = '';
    VC_MAKE_CMD_LINE = '';

    DMARS_MAKE_PROGRAM = 'mingw32-make.exe';
    DMARS_CP_PROGRAM = 'dmc.exe';
    DMARS_CPP_PROGRAM = 'dmc.exe';
    DMARS_DBG_PROGRAM = 'cdb.exe';
    DMARS_RES_PROGRAM = 'rcc.exe';
    DMARS_DLL_PROGRAM = 'link.exe';
    DMARS_PROF_PROGRAM = '';
    DMARS_COMPILER_CMD_LINE = '-D_STLP_NO_NEW_IOSTREAMS';
    DMARS_LINKER_CMD_LINE = '';
    DMARS_MAKE_CMD_LINE = '';

    BORLAND_MAKE_PROGRAM = 'mingw32-make.exe';
    BORLAND_CP_PROGRAM = 'borgcc.exe';
    BORLAND_CPP_PROGRAM = 'borg++.exe';
    BORLAND_DBG_PROGRAM = 'borgdb.exe';
    BORLAND_RES_PROGRAM = 'borwindres.exe';
    BORLAND_DLL_PROGRAM = 'link.exe';
    BORLAND_PROF_PROGRAM = 'borgprof.exe';
    BORLAND_COMPILER_CMD_LINE = '';
    BORLAND_LINKER_CMD_LINE = '';
    BORLAND_MAKE_CMD_LINE = '';

    WATCOM_MAKE_PROGRAM = 'mingw32-make.exe';
    WATCOM_CP_PROGRAM = 'owatgcc.exe';
    WATCOM_CPP_PROGRAM = 'owatg++.exe';
    WATCOM_DBG_PROGRAM = 'owatgdb.exe';
    WATCOM_RES_PROGRAM = 'owatwindres.exe';
    WATCOM_DLL_PROGRAM = 'link.exe';
    WATCOM_PROF_PROGRAM = 'owatgprof.exe';
    WATCOM_COMPILER_CMD_LINE = '';
    WATCOM_LINKER_CMD_LINE = '';
    WATCOM_MAKE_CMD_LINE = '';

    LINUX_MAKE_PROGRAM = '/usr/bin/make';
    LINUX_CP_PROGRAM = 'gcc';
    LINUX_CPP_PROGRAM = 'gcc';
    LINUX_DBG_PROGRAM = 'gdb';
    LINUX_RES_PROGRAM = '';
    LINUX_DLL_PROGRAM = 'gcc';
    LINUX_PROF_PROGRAM = 'gprof';
    LINUX_COMPILER_CMD_LINE = '';
    LINUX_LINKER_CMD_LINE = '';
    LINUX_MAKE_CMD_LINE = '';

    // GDB commands and Displays
    GDB_FILE = 'file';
    GDB_EXECFILE = 'exec-file';
    GDB_RUN = 'run';
    GDB_BREAK = 'break';
    GDB_CONTINUE = 'continue';
    GDB_NEXT = 'next';
    GDB_STEP = 'step';
    GDB_DISPLAY = 'display';
    GDB_UNDISPLAY = 'undisplay';
    GDB_PRINT = 'print';
    GDB_SETVAR = 'set var';
    GDB_DELETE = 'delete';
    GDB_PROMPT = '(gdb) ';
    GDB_BACKTRACE = 'bt';
    GDB_DISASSEMBLE = 'disas';
    GDB_SETFLAVOR = 'set disassembly-flavor';
    GDB_INTEL = 'intel';
    GDB_ATT = 'att';
    GDB_REG = 'displ/x';
    GDB_EAX = '$eax';
    GDB_EBX = '$ebx';
    GDB_ECX = '$ecx';
    GDB_EDX = '$edx';
    GDB_ESI = '$esi';
    GDB_EDI = '$edi';
    GDB_EBP = '$ebp';
    GDB_ESP = '$esp';
    GDB_EIP = '$eip';
    GDB_CS = '$cs';
    GDB_DS = '$ds';
    GDB_SS = '$ss';
    GDB_ES = '$es';
    GDB_SETARGS = 'set args';
    GDB_ATTACH = 'attach';
    GDB_SET = 'set';

    // option sections
    OPT_DIRS = 'Directories';
    OPT_EDITOR = 'Editor';
    OPT_HISTORY = 'History';
    OPT_OPTIONS = 'Options';
    OPT_POS = 'Positions';
    OPT_START = 'Startup';
    OPT_COMPILERSETS = 'CompilerSets';
    WEBUPDATE_SECTION = 'WEBUPDATE';

    GCC_DEFCOMPILERSET = 'Default GCC compiler';
    VC2010_DEFCOMPILERSET = 'Default VC2010 compiler';
    VC2008_DEFCOMPILERSET = 'Default VC2008 compiler';
    VC2005_DEFCOMPILERSET = 'Default VC2005 compiler';
    VC2003_DEFCOMPILERSET = 'Default VC2003 compiler';
    VC6_DEFCOMPILERSET = 'Default VC6 compiler';
    DMARS_DEFCOMPILERSET = 'Default DigitalMars compiler';
    BORLAND_DEFCOMPILERSET = 'Default Borland compiler';
    WATCOM_DEFCOMPILERSET = 'Default Watcom compiler';
    LINUX_DEFCOMPILERSET = 'Default Linux gcc compiler';

    //Filters
    FLT_BASE = 'All known Files||';
    FLT_ALLFILES = 'All files (*.*)|*.*|';
    FLT_PROJECTS = 'Dev-C++ project (*.dev)|*.dev';
    FLT_HEADS = 'Header files (*.h;*.hpp;*.rh;*.hh)|*.h;*.hpp;*.rh;*.hh';
    FLT_CS = 'C source files (*.c)|*.c';
    FLT_CPPS =
        'C++ source files (*.cpp;*.cc;*.cxx;*.c++;*.cp)|*.cpp;*.cc;*.cxx;*.c++;*.cp';
    FLT_RES = 'Resource scripts (*.rc)|*.rc';
    FLT_HELPS =
        'Help files (*.hlp;*.chm;*.col)|*.hlp;*.chm;*.col|HTML files (*.htm;*.html)|*.htm;*.html|Text files (*.doc;*.rtf;*.txt)|*.doc;*.rtf;*.txt|All files (*.*)|*.*';
    FLT_MSVCPROJECTS = 'MS Visual C++ projects (*.dsp)|*.dsp';

    cBP = 'Break points';
    cErr = 'Error Line';
    cABP = 'Active Breakpoints';
    cGut = 'Gutter';
    cSel = 'Selected text';

    COMPILER_INI_LABEL = 'CompilerSettings';
    CPP_INI_LABEL = 'CppCompiler';
    C_INI_LABEL = 'Compiler';
    LINKER_INI_LABEL = 'Linker';
    PREPROC_INI_LABEL = 'PreprocDefines';


Const
    //  source file extensions
    C_EXT = '.c';
    CPP_EXT = '.cpp';
    CC_EXT = '.cc';
    CXX_EXT = '.cxx';
    CP2_EXT = '.c++';
    CP_EXT = '.cp';
    H_EXT = '.h';
    HPP_EXT = '.hpp';
    RC_EXT = '.rc';
    RES_EXT = '.res';
    RH_EXT = '.rh';
    PATH_LEN = 16384;
    CONFIG_PARAM = '-c';

    // file type arrays used in getfileex in utils
    cTypes: Array[0..0] Of String[4] = (C_EXT);
    cppTypes: Array[0..4] Of String[4] =
        (CPP_EXT, CC_EXT, CXX_EXT, CP2_EXT, CP_EXT);
    headTypes: Array[0..2] Of String[4] = (H_EXT, HPP_EXT, RH_EXT);
    resTypes: Array[0..2] Of String[4] = (RES_EXT, RC_EXT, RH_EXT);

    // GPROF commands and displays
    GPROF_CHECKFILE = 'gmon.out';
    GPROF_CMD_GENFLAT = '-p';
    GPROF_CMD_GENMAP = '-q';

Function DEVCPP_VERSION: String;
Function MAKE_PROGRAM(CompilerID: Integer): String;
Function CP_PROGRAM(CompilerID: Integer): String;
Function CPP_PROGRAM(CompilerID: Integer): String;
Function DBG_PROGRAM(CompilerID: Integer): String;
Function RES_PROGRAM(CompilerID: Integer): String;
Function DLL_PROGRAM(CompilerID: Integer): String;
Function PROF_PROGRAM(CompilerID: Integer): String;
Function DEFCOMPILERSET(CompilerID: Integer): String;
Function COMPILER_CMD_LINE(CompilerID: Integer): String;
Function LINKER_CMD_LINE(CompilerID: Integer): String;
Function MAKE_CMD_LINE(CompilerID: Integer): String;
// default directories
Function BIN_DIR(CompilerID: Integer): String;
Function LIB_DIR(CompilerID: Integer): String;
Function C_INCLUDE_DIR(CompilerID: Integer): String;
Function CPP_INCLUDE_DIR(CompilerID: Integer): String;
Function RC_INCLUDE_DIR(CompilerID: Integer): String;

Function GetRefinedPathList(StrPathValue, strVSInstallPath,
    strVCPPInstallPath, strFSDKInstallDir, strWinSDKPath: String): String;
Function GetVC200XPath(versionString: String; PathType: Integer): String;
Function GetVC6Path(PathType: Integer): String;
Function GetVC2010Include: String;
Function GetVC2008Include: String;
// EAB Comment: Is that OK to keep adding functions for each new compiler? Wouldn't it be better to have something more flexible like config files?
Function GetVC2005Include: String;
Function GetVC2003Include: String;
Function GetVC6Include: String;
Function GetVC2010Bin: String;
Function GetVC2008Bin: String;
Function GetVC2005Bin: String;
Function GetVC2003Bin: String;
Function GetVC6Bin: String;
Function GetVC2010Lib: String;
Function GetVC2008Lib: String;
Function GetVC2005Lib: String;
Function GetVC2003Lib: String;
Function GetVC6Lib: String;
Function GetTDMGCCDir: String;

Var
    DevCppDir: String;

Implementation
Uses devcfg;

Function DEVCPP_VERSION: String;
Var
    verblock: PVSFIXEDFILEINFO;
    versionMS, versionLS: Cardinal;
    verlen: Cardinal;
    rs: TResourceStream;
    m: TMemoryStream;
    p: pointer;
    s: Cardinal;
    AppVersionString: String;
Begin
    m := TMemoryStream.Create;
    Try
        rs := TResourceStream.CreateFromID(HInstance, 1, RT_VERSION);
        Try
            m.CopyFrom(rs, rs.Size);
        Finally
            rs.Free;
        End;
        m.Position := 0;
        If VerQueryValue(m.Memory, '\', pointer(verblock), verlen) Then
        Begin
            VersionMS := verblock.dwFileVersionMS;
            VersionLS := verblock.dwFileVersionLS;
            AppVersionString :=
                IntToStr(versionMS Shr 16) + '.' +
                IntToStr(versionMS And $FFFF) + '.' +
                IntToStr(VersionLS Shr 16) + '.' +
                IntToStr(VersionLS And $FFFF);
        End;
        If VerQueryValue(m.Memory, Pchar('\\StringFileInfo\\' +
            IntToHex(GetThreadLocale, 4) + IntToHex(GetACP, 4) +
            '\\FileDescription'), p, s) Or
            VerQueryValue(m.Memory, '\\StringFileInfo\\040904E4\\FileDescription',
            p, s) Then //en-us
            AppVersionString := Pchar(p) + ' ' + AppVersionString;
    Finally
        m.Free;
    End;
    Result := AppVersionString;
End;

Function GetProgramFilesDir: String;
Var
    TempString: String;
    reg: TRegistry;
Begin
    reg := TRegistry.Create;
    reg.RootKey := HKEY_LOCAL_MACHINE;
    Try
        TempString := '\Software\Microsoft\Windows\CurrentVersion';
        If (reg.OpenKey(TempString, False) = False) Then
            Result := 'C:\Program Files'
        Else
        Begin
            Result := reg.ReadString('ProgramFilesDir');
            reg.CloseKey;
        End;
    Finally
        reg.Free;
    End;
End;

Function MAKE_PROGRAM(CompilerID: Integer): String;
Begin
    Case CompilerID Of
        ID_COMPILER_MINGW:
            Result := GCC_MAKE_PROGRAM;

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_MAKE_PROGRAM;

        ID_COMPILER_DMARS:
            Result := DMARS_MAKE_PROGRAM;

        ID_COMPILER_BORLAND:
            Result := BORLAND_MAKE_PROGRAM;

        ID_COMPILER_WATCOM:
            Result := WATCOM_MAKE_PROGRAM;

        ID_COMPILER_LINUX:
            Result := LINUX_MAKE_PROGRAM;

    End;

End;

Function CP_PROGRAM(CompilerID: Integer): String;
Begin
    Case CompilerID Of
        ID_COMPILER_MINGW:
            Result := GCC_CP_PROGRAM;

        //ID_COMPILER_VC2008:
        //    Result := '"' + StringReplace(GetProgramFilesDir, '\', '/', [rfReplaceAll]) + '/Microsoft Visual Studio 9.0/VC/Bin/' + VC_CP_PROGRAM + '"';

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_CP_PROGRAM;

        ID_COMPILER_DMARS:
            Result := DMARS_CP_PROGRAM;

        ID_COMPILER_BORLAND:
            Result := BORLAND_CP_PROGRAM;

        ID_COMPILER_WATCOM:
            Result := WATCOM_CP_PROGRAM;

        ID_COMPILER_LINUX:
            Result := LINUX_CP_PROGRAM;

    End;
End;

Function CPP_PROGRAM(CompilerID: Integer): String;
Begin
    Case CompilerID Of
        ID_COMPILER_MINGW:
            Result := GCC_CPP_PROGRAM;

        //ID_COMPILER_VC2008:
        //    Result := '"' + StringReplace(GetProgramFilesDir, '\', '/', [rfReplaceAll]) + '/Microsoft Visual Studio 9.0/VC/Bin/' + VC_CPP_PROGRAM + '"';

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_CPP_PROGRAM;

        ID_COMPILER_DMARS:
            Result := DMARS_CPP_PROGRAM;

        ID_COMPILER_BORLAND:
            Result := BORLAND_CPP_PROGRAM;

        ID_COMPILER_WATCOM:
            Result := WATCOM_CPP_PROGRAM;

        ID_COMPILER_LINUX:
            Result := LINUX_CPP_PROGRAM;

    End;
End;


Function DBG_PROGRAM(CompilerID: Integer): String;
Begin
    Case CompilerID Of
        ID_COMPILER_MINGW:
            Result := GCC_DBG_PROGRAM;

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008:
            If DirectoryExists(GetProgramFilesDir +
                '\Debugging Tools for Windows (x86)') Then
                Result := GetProgramFilesDir +
                    '\Debugging Tools for Windows (x86)\' + VC_DBG_PROGRAM
            Else
                Result := GetProgramFilesDir + '\Debugging Tools for Windows\' +
                    VC_DBG_PROGRAM;

        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_DBG_PROGRAM;

        ID_COMPILER_DMARS:
            Result := DMARS_DBG_PROGRAM;

        ID_COMPILER_BORLAND:
            Result := BORLAND_DBG_PROGRAM;

        ID_COMPILER_WATCOM:
            Result := WATCOM_DBG_PROGRAM;

        ID_COMPILER_LINUX:
            Result := LINUX_DBG_PROGRAM;

    End;
End;

Function RES_PROGRAM(CompilerID: Integer): String;
Begin
    Case CompilerID Of
        ID_COMPILER_MINGW:
            Result := GCC_RES_PROGRAM;

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_RES_PROGRAM;

        ID_COMPILER_DMARS:
            Result := DMARS_RES_PROGRAM;

        ID_COMPILER_BORLAND:
            Result := BORLAND_RES_PROGRAM;

        ID_COMPILER_WATCOM:
            Result := WATCOM_RES_PROGRAM;

        ID_COMPILER_LINUX:
            Result := LINUX_RES_PROGRAM;
    End;
End;

Function DLL_PROGRAM(CompilerID: Integer): String;
Begin
    Case CompilerID Of
        ID_COMPILER_MINGW:
            Result := GCC_DLL_PROGRAM;

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_DLL_PROGRAM;

        ID_COMPILER_DMARS:
            Result := DMARS_DLL_PROGRAM;

        ID_COMPILER_BORLAND:
            Result := BORLAND_DLL_PROGRAM;

        ID_COMPILER_WATCOM:
            Result := WATCOM_DLL_PROGRAM;

        ID_COMPILER_LINUX:
            Result := LINUX_DLL_PROGRAM;
    End;
End;

Function DEFCOMPILERSET(CompilerID: Integer): String;
Begin
    Case CompilerID Of
        ID_COMPILER_MINGW:
            Result := GCC_DEFCOMPILERSET;

        ID_COMPILER_VC2010:
            Result := VC2010_DEFCOMPILERSET;

        ID_COMPILER_VC2008:
            Result := VC2008_DEFCOMPILERSET;

        ID_COMPILER_VC2005:
            Result := VC2005_DEFCOMPILERSET;

        ID_COMPILER_VC2003:
            Result := VC2003_DEFCOMPILERSET;

        ID_COMPILER_VC6:
            Result := VC6_DEFCOMPILERSET;

        ID_COMPILER_DMARS:
            Result := DMARS_DEFCOMPILERSET;

        ID_COMPILER_BORLAND:
            Result := BORLAND_DEFCOMPILERSET;

        ID_COMPILER_WATCOM:
            Result := WATCOM_DEFCOMPILERSET;

        ID_COMPILER_LINUX:
            Result := LINUX_DEFCOMPILERSET;
    End;
End;

Function COMPILER_CMD_LINE(CompilerID: Integer): String;
Begin
    Case CompilerID Of
        ID_COMPILER_MINGW:
            Result := GCC_COMPILER_CMD_LINE;

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_COMPILER_CMD_LINE;

        ID_COMPILER_BORLAND:
            Result := BORLAND_COMPILER_CMD_LINE;

        ID_COMPILER_WATCOM:
            Result := WATCOM_COMPILER_CMD_LINE;

        ID_COMPILER_DMARS:
            Result := DMARS_COMPILER_CMD_LINE;

        ID_COMPILER_LINUX:
            Result := LINUX_COMPILER_CMD_LINE;
    End;
End;

Function LINKER_CMD_LINE(CompilerID: Integer): String;
Begin
    Case CompilerID Of
        ID_COMPILER_MINGW:
            Result := GCC_LINKER_CMD_LINE;

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_LINKER_CMD_LINE;

        ID_COMPILER_BORLAND:
            Result := BORLAND_LINKER_CMD_LINE;

        ID_COMPILER_WATCOM:
            Result := WATCOM_LINKER_CMD_LINE;

        ID_COMPILER_DMARS:
            Result := DMARS_LINKER_CMD_LINE;

        ID_COMPILER_LINUX:
            Result := LINUX_LINKER_CMD_LINE;
    End;
End;

Function MAKE_CMD_LINE(CompilerID: Integer): String;
Begin
    Case CompilerID Of
        ID_COMPILER_MINGW:
            Result := GCC_MAKE_CMD_LINE;

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_MAKE_CMD_LINE;

        ID_COMPILER_BORLAND:
            Result := BORLAND_MAKE_CMD_LINE;

        ID_COMPILER_WATCOM:
            Result := WATCOM_MAKE_CMD_LINE;

        ID_COMPILER_DMARS:
            Result := DMARS_MAKE_CMD_LINE;

        ID_COMPILER_LINUX:
            Result := LINUX_MAKE_CMD_LINE;
    End;
End;

Function PROF_PROGRAM(CompilerID: Integer): String;
Begin
    Case CompilerID Of
        ID_COMPILER_MINGW:
            Result := GCC_PROF_PROGRAM;

        ID_COMPILER_VC2010,
        ID_COMPILER_VC2008,
        ID_COMPILER_VC2005,
        ID_COMPILER_VC2003,
        ID_COMPILER_VC6:
            Result := VC_PROF_PROGRAM;

        ID_COMPILER_DMARS:
            Result := DMARS_PROF_PROGRAM;

        ID_COMPILER_BORLAND:
            Result := BORLAND_PROF_PROGRAM;

        ID_COMPILER_WATCOM:
            Result := WATCOM_PROF_PROGRAM;

        ID_COMPILER_LINUX:
            Result := LINUX_PROF_PROGRAM;
    End;
End;

Function BIN_DIR(CompilerID: Integer): String;
Begin
    Case CompilerID Of
        ID_COMPILER_MINGW:

        Begin
            Result := GetTDMGCCDir;
            If (Result = '') Then
                Result := GCC_BIN_DIR
            Else
                Result := Result + pd + 'bin';

        End;

        ID_COMPILER_VC2010:
            Result := VC2010_BIN_DIR + GetVC2010Bin;

        ID_COMPILER_VC2008:
            Result := VC2008_BIN_DIR + GetVC2008Bin;

        ID_COMPILER_VC2005:
            Result := VC2005_BIN_DIR + GetVC2005Bin;

        ID_COMPILER_VC2003:
            Result := VC2003_BIN_DIR + GetVC2003Bin;

        ID_COMPILER_VC6:
            Result := VC6_BIN_DIR + GetVC6Bin;

        ID_COMPILER_DMARS:
            Result := DMARS_BIN_DIR;

        ID_COMPILER_BORLAND:
            Result := BORLAND_BIN_DIR;

        ID_COMPILER_WATCOM:
            Result := WATCOM_BIN_DIR;

        ID_COMPILER_LINUX:
            Result := LINUX_BIN_DIR;
    End;
End;

Function LIB_DIR(CompilerID: Integer): String;
Begin
    Case CompilerID Of
        ID_COMPILER_MINGW:

        Begin
            Result := GetTDMGCCDir;
            If (Result = '') Then
                Result := GCC_LIB_DIR
            Else
                Result := Result + pd + 'lib;' + GCC_LIB_DIR;
        End;

        ID_COMPILER_VC2010:
            Result := VC2010_LIB_DIR + GetVC2010Lib;

        ID_COMPILER_VC2008:
            Result := VC2008_LIB_DIR + GetVC2008Lib;

        ID_COMPILER_VC2005:
            Result := VC2005_LIB_DIR + GetVC2005Lib;

        ID_COMPILER_VC2003:
            Result := VC2003_LIB_DIR + GetVC2003Lib;

        ID_COMPILER_VC6:
            Result := VC6_LIB_DIR + GetVC6Lib;

        ID_COMPILER_DMARS:
            Result := DMARS_LIB_DIR;

        ID_COMPILER_BORLAND:
            Result := BORLAND_LIB_DIR;

        ID_COMPILER_WATCOM:
            Result := WATCOM_LIB_DIR;

        ID_COMPILER_LINUX:
            Result := LINUX_LIB_DIR;
    End;
End;

Function C_INCLUDE_DIR(CompilerID: Integer): String;
Begin
    Case CompilerID Of
        ID_COMPILER_MINGW:

        Begin
            Result := GetTDMGCCDir;
            If (Result = '') Then
                Result := GCC_C_INCLUDE_DIR
            Else
                Result := Result + pd + 'include';

        End;

        ID_COMPILER_VC2010:
            Result := COMMON_CPP_INCLUDE_DIR + VC2010_C_INCLUDE_DIR +
                GetVC2010Include;

        ID_COMPILER_VC2008:
            Result := COMMON_CPP_INCLUDE_DIR + VC2008_C_INCLUDE_DIR +
                GetVC2008Include;

        ID_COMPILER_VC2005:
            Result := COMMON_CPP_INCLUDE_DIR + VC2005_C_INCLUDE_DIR +
                GetVC2005Include;

        ID_COMPILER_VC2003:
            Result := COMMON_CPP_INCLUDE_DIR + VC2003_C_INCLUDE_DIR +
                GetVC2003Include;

        ID_COMPILER_VC6:
            Result := COMMON_CPP_INCLUDE_DIR + VC6_C_INCLUDE_DIR + GetVC6Include;

        ID_COMPILER_DMARS:
            Result := DMARS_C_INCLUDE_DIR;

        ID_COMPILER_BORLAND:
            Result := BORLAND_C_INCLUDE_DIR;

        ID_COMPILER_WATCOM:
            Result := WATCOM_C_INCLUDE_DIR;

        ID_COMPILER_LINUX:
            Result := LINUX_C_INCLUDE_DIR;
    End;
End;

Function CPP_INCLUDE_DIR(CompilerID: Integer): String;
Begin
    Case CompilerID Of
        ID_COMPILER_MINGW:

        Begin
            Result := GetTDMGCCDir;
            If (Result = '') Then
                Result := COMMON_CPP_INCLUDE_DIR + GCC_CPP_INCLUDE_DIR
            Else
                Result := Result + pd + 'include';

        End;

        ID_COMPILER_VC2010:
            Result := GetVC2010Include + VC2010_CPP_INCLUDE_DIR +
                COMMON_CPP_INCLUDE_DIR;

        ID_COMPILER_VC2008:
            Result := GetVC2008Include + VC2008_CPP_INCLUDE_DIR +
                COMMON_CPP_INCLUDE_DIR;

        ID_COMPILER_VC2005:
            Result := GetVC2005Include + VC2005_CPP_INCLUDE_DIR +
                COMMON_CPP_INCLUDE_DIR;

        ID_COMPILER_VC2003:
            Result := GetVC2003Include + VC2003_CPP_INCLUDE_DIR +
                COMMON_CPP_INCLUDE_DIR;

        ID_COMPILER_VC6:
            Result := GetVC6Include + VC6_CPP_INCLUDE_DIR +
                COMMON_CPP_INCLUDE_DIR;

        ID_COMPILER_DMARS:
            Result := COMMON_CPP_INCLUDE_DIR + DMARS_CPP_INCLUDE_DIR;

        ID_COMPILER_BORLAND:
            Result := COMMON_CPP_INCLUDE_DIR + BORLAND_CPP_INCLUDE_DIR;

        ID_COMPILER_WATCOM:
            Result := COMMON_CPP_INCLUDE_DIR + WATCOM_CPP_INCLUDE_DIR;

        ID_COMPILER_LINUX:
            Result := LINUX_CPP_INCLUDE_DIR;
    End;
End;

Function RC_INCLUDE_DIR(CompilerID: Integer): String;
Begin
    Case CompilerID Of
        ID_COMPILER_MINGW:
            Result := GCC_RC_INCLUDE_DIR;

        ID_COMPILER_VC2010:
            Result := GetVC2010Include + VC2010_RC_INCLUDE_DIR;

        ID_COMPILER_VC2008:
            Result := GetVC2008Include + VC2008_RC_INCLUDE_DIR;

        ID_COMPILER_VC2005:
            Result := GetVC2005Include + VC2005_RC_INCLUDE_DIR;

        ID_COMPILER_VC2003:
            Result := GetVC2003Include + VC2003_RC_INCLUDE_DIR;

        ID_COMPILER_VC6:
            Result := GetVC6Include + VC6_RC_INCLUDE_DIR;

        ID_COMPILER_DMARS:
            Result := DMARS_RC_INCLUDE_DIR;

        ID_COMPILER_BORLAND:
            Result := BORLAND_RC_INCLUDE_DIR;

        ID_COMPILER_WATCOM:
            Result := WATCOM_RC_INCLUDE_DIR;

        ID_COMPILER_LINUX:
            Result := LINUX_RC_INCLUDE_DIR;
    End;
End;


Function GetVC6Path(PathType: Integer): String;
Var
    strInclude, strBin, strLib, TempString: String;
    reverseList: TStringList;
    i: Integer;
Begin
    TempString := 'Software\Microsoft\DevStudio\6.0\Build System\Components\Platforms\Win32 (x86)\Directories\';

    Case PathType Of
        0:
        Begin
            TempString := TempString + 'Include Dirs';
            strInclude := regReadValue(HKEY_CURRENT_USER, TempString, dtString);
            Result := ';' + strInclude + ';';
        End;
        1:
        Begin
            TempString := TempString + 'Path Dirs';
            strBin := regReadValue(HKEY_CURRENT_USER, TempString, dtString);
            Result := ';' + strBin + ';';
        End;
        2:
        Begin

            TempString := TempString + 'Library Dirs';
            strLib := regReadValue(HKEY_CURRENT_USER, TempString, dtString);
            Result := ';' + strLib + ';';
        End;
    End;
    reverseList := TStringList.Create;
    StrToArrays(Result, ';', reverseList);
    Result := '';
    For i := reverseList.Count - 1 Downto 0 Do
    Begin
        Result := Result + ';' + reverseList[i];
    End;

    //reverseList.destroy;
    Result := Result + ';';

End;

Function GetRefinedPathList(StrPathValue, strVSInstallPath,
    strVCPPInstallPath, strFSDKInstallDir, strWinSDKPath: String): String;
Var
    strLst: TStringList;
    i: Integer;
Begin
    strLst := TStringList.Create;
    strVCPPInstallPath := IncludeTrailingPathDelimiter(strVCPPInstallPath);
    strVSInstallPath := IncludeTrailingPathDelimiter(strVSInstallPath);
    strWinSDKPath := IncludeTrailingPathDelimiter(strWinSDKPath);

    StrPathValue := StringReplace(StrPathValue, '$(VCInstallDir)',
        strVCPPInstallPath, [rfReplaceAll, rfIgnoreCase]);
    StrPathValue := StringReplace(StrPathValue, '$(VSInstallDir)',
        strVSInstallPath, [rfReplaceAll, rfIgnoreCase]);
    StrPathValue := StringReplace(StrPathValue, '$(WinSDKDir)',
        strWinSDKPath, [rfReplaceAll, rfIgnoreCase]);
    Result := StrPathValue;
    StrToArrays(Result, ';', strLst);
    Result := '';
    For i := strLst.Count - 1 Downto 0 Do
        Result := Result + ';' + strLst[i];
    Result := Result + ';';
    strLst.Free;
End;

Function GetWinSDKDir: String;
Var
    strFSDKInstallDir: String;
    TempString: String;
    reg, reg2: TRegistry;
    strLst: TStringList;
    i: Integer;
Begin
    reg := TRegistry.Create;
    reg2 := TRegistry.Create;
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg2.RootKey := HKEY_LOCAL_MACHINE;

    TempString := 'SOFTWARE\Microsoft\MicrosoftSDK\InstalledSDKs';
    strLst := TStringList.Create;
    If (reg.OpenKey(TempString, False)) Then
    Begin
        reg.GetKeyNames(strLst);
        For i := 0 To strLst.Count - 1 Do
        Begin
            TempString := 'SOFTWARE\Microsoft\MicrosoftSDK\InstalledSDKs\' + strLst[i];
            If (reg2.OpenKey(TempString, False)) Then
            Begin
                strFSDKInstallDir := reg2.ReadString('Install Dir');
                If (strFSDKInstallDir <> '') Then
                    break;
            End;
        End;
    End;

    If trim(strFSDKInstallDir) = '' Then
        Result := 'Invalid_SDK_DIR'
    Else
        Result := strFSDKInstallDir;

    strLst.Free;
    reg.CloseKey;
    reg2.CloseKey;

    reg.Free;
    reg2.Free;
End;

Function GetVC200XPath(versionString: String; PathType: Integer): String;
Var
    strVSInstallDir,
    strVCPPInstallDir,
    strInclude,
    strBin,
    strLib,
    strFSDKInstallDir, strWinSDKDir: String;
    TempString: String;
    reg: TRegistry;
    reg2: TRegistry;
Begin
    reg := TRegistry.Create;
    reg2 := TRegistry.Create;
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg2.RootKey := HKEY_LOCAL_MACHINE;
    Try
        TempString := Format('SOFTWARE\Microsoft\VisualStudio\%s\Setup\VC\',
            [VersionString]);
        If (reg.OpenKey(TempString, False) = False) Then
            strVCPPInstallDir := ''
        Else
        Begin
            strVCPPInstallDir := reg.ReadString('ProductDir');
            reg.CloseKey;
        End;

        If strVCPPInstallDir = '' Then
        Begin
            TempString := 'SOFTWARE\Microsoft\VisualStudio\SxS\VC7\';
            If reg2.OpenKey(TempString, False) = False Then
            Begin
                reg.Free;
                reg2.Free;
                exit;
            End;
            strVCPPInstallDir := reg2.ReadString(versionString);
            reg2.CloseKey;
        End;

        TempString := Format('SOFTWARE\Microsoft\VisualStudio\%s\Setup\VS\',
            [VersionString]);
        If (reg.OpenKey(TempString, False) = False) Then
            strVSInstallDir := ''
        Else
        Begin
            strVSInstallDir := reg.ReadString('ProductDir');
            reg.CloseKey;
        End;

        If strVSInstallDir = '' Then
        Begin
            TempString := 'SOFTWARE\Microsoft\VisualStudio\SxS\VS7\';
            If reg2.OpenKey(TempString, False) = False Then
            Begin
                reg.Free;
                reg2.Free;
                exit;
            End;
            strVSInstallDir := reg2.ReadString(versionString);
            reg2.CloseKey;
        End;

        If (strVCPPInstallDir = '') Then
        Begin
            If versionString = '7.1' Then
                strVCPPInstallDir :=
                    GetProgramFilesDir + '\Microsoft Visual Studio .NET 2003\Vc7\';
            If versionString = '8.0' Then
                strVCPPInstallDir :=
                    GetProgramFilesDir + '\Microsoft Visual Studio\Vc8\';
            If versionString = '9.0' Then
                strVCPPInstallDir :=
                    GetProgramFilesDir + '\Microsoft Visual Studio 9.0\VC\';
            If versionString = '10.0' Then
                strVCPPInstallDir :=
                    GetProgramFilesDir + '\Microsoft Visual Studio 10.0\VC\';
        End;

        TempString := 'SOFTWARE\Microsoft\VisualStudio\SxS\FRAMEWORKSDK\';
        If (reg.OpenKey(TempString, False)) Then
        Begin
            strFSDKInstallDir := reg.ReadString(VersionString);
            If trim(strFSDKInstallDir) = '' Then
            Begin
                strFSDKInstallDir := reg.ReadString('10.0');
                If trim(strFSDKInstallDir) = '' Then
                    strFSDKInstallDir := reg.ReadString('9.0');
                If trim(strFSDKInstallDir) = '' Then
                    strFSDKInstallDir := reg.ReadString('8.0');
                If trim(strFSDKInstallDir) = '' Then
                    strFSDKInstallDir := reg.ReadString('7.1');
            End;
        End;
        reg.CloseKey;

        // On Windows 7, they moved to their own registry item
        If trim(strFSDKInstallDir) = '' Then
        Begin

            TempString := 'SOFTWARE\Microsoft\MicrosoftSDKs\Windows\';
            If (reg.OpenKey(TempString, False)) Then
            Begin
                strFSDKInstallDir := reg.ReadString('CurrentInstallFolder');
            End;
            reg.CloseKey;

        End;


        //Guru : Make sure we set some invalid names to the dir,
        //otherwise with the empty string it will set \include and
        //this will be mapped to mingW's Include path
        If (strVSInstallDir = '') Then
            strVSInstallDir := 'VSInstall_INVALID_FOLDER';

        strWinSDKDir := GetWinSDKDir;
        If (strWinSDKDir = '') Then
        Begin
            If versionString = '10.0' Then
                strWinSDKDir := GetProgramFilesDir + '\Microsoft SDKs\'
            Else
            If versionString = '9.0' Then
                strWinSDKDir := GetProgramFilesDir + '\Microsoft SDKs\'
            Else
                strWinSDKDir := 'WinSDK_INVALID_FOLDER';
        End;

        TempString := Format(
            'SOFTWARE\Microsoft\VisualStudio\%s\VC\VC_OBJECTS_PLATFORM_INFO\Win32\Directories\',
            [VersionString]);
        If (reg.OpenKey(TempString, False)) Then
        Begin
            strInclude := reg.ReadString('Include Dirs');
            strBin := reg.ReadString('Path Dirs');
            strLib := reg.ReadString('Library Dirs');
            reg.CloseKey;
        End
        Else
        Begin
            strInclude := '';
            strBin := '';
            strLib := '';
        End;
        Case PathType Of
            0:
            Begin

                If Trim(strInclude) = '' Then
                    strInclude :=
                        '$(VCInstallDir)include;$(VCInstallDir)atlmfc\include;$(VCInstallDir)PlatformSDK\include\prerelease;$(VCInstallDir)PlatformSDK\include;$(FrameworkSDKDir)include;';
                If ((versionString = '9.0') Or (versionString = '10.0')) Then
                    strInclude :=
                        strInclude + ';' + StringReplace(GetProgramFilesDir, ' (x86)', '', []) +
                        '\Microsoft SDKs\Windows\v6.0A\Include;';
                strInclude := strInclude + ';$(WinSDKDir)include;';
                Result := GetRefinedPathList(
                    strInclude, strVSInstallDir, strVCPPInstallDir, strFSDKInstallDir, strWinSDKDir);
            End;
            1:
            Begin

                If Trim(strBin) = '' Then
                    strBin :=
                        '$(VCInstallDir)bin;$(VSInstallDir)Common7\Tools\bin\prerelease;$(VSInstallDir)Common7\Tools\bin;$(VSInstallDir)Common7\tools;$(VSInstallDir)Common7\ide;' + GetProgramFilesDir + '\HTML Help Workshop\;$(FrameworkSDKDir)bin;$(FrameworkDir)$(FrameworkVersion);';
                If ((versionString = '9.0') Or (versionString = '10.0')) Then
                    strBin := strBin + ';' +
                        StringReplace(GetProgramFilesDir, ' (x86)', '', []) +
                        '\Microsoft SDKs\Windows\v6.0A\Bin;';
                strBin := strBin + ';$(WinSDKDir)bin;';
                Result := GetRefinedPathList(strBin, strVSInstallDir,
                    strVCPPInstallDir, strFSDKInstallDir, strWinSDKDir);
            End;
            2:
            Begin
                If Trim(strLib) = '' Then
                    strLib :=
                        '$(VCInstallDir)lib;$(VCInstallDir)atlmfc\lib;$(VCInstallDir)PlatformSDK\lib\prerelease;$(VCInstallDir)PlatformSDK\lib;$(FrameworkSDKDir)lib';
                If ((versionString = '9.0') Or (versionString = '10.0')) Then
                    strLib := strLib + ';' +
                        StringReplace(GetProgramFilesDir, ' (x86)', '', []) +
                        '\Microsoft SDKs\Windows\v6.0A\Lib;';
                strLib := strLib + ';$(WinSDKDir)lib;';
                Result := GetRefinedPathList(strLib, strVSInstallDir,
                    strVCPPInstallDir, strFSDKInstallDir, strWinSDKDir);
            End;
        End;
    Finally
    End;

    reg.Free;
    reg2.Free;

End;

Function GetVC2010Include: String;
Begin
    Result := GetVC200XPath('10.0', 0);
End;

Function GetVC2008Include: String;
Begin
    Result := GetVC200XPath('9.0', 0);
End;

Function GetVC2005Include: String;
Begin
    Result := GetVC200XPath('8.0', 0);
End;

Function GetVC2003Include: String;
Begin
    Result := GetVC200XPath('7.1', 0);
End;

Function GetVC6Include: String;
Begin
    Result := GetVC6Path(0);
End;

Function GetVC2010Bin: String;
Begin
    Result := GetVC200XPath('10.0', 1);
End;

Function GetVC2008Bin: String;
Begin
    Result := GetVC200XPath('9.0', 1);
End;

Function GetVC2005Bin: String;
Begin
    Result := GetVC200XPath('8.0', 1);
End;

Function GetVC2003Bin: String;
Begin
    Result := GetVC200XPath('7.1', 1);
End;

Function GetVC6Bin: String;
Begin
    Result := GetVC6Path(1);
End;

Function GetVC2010Lib: String;
Begin
    Result := GetVC200XPath('10.0', 2);
End;

Function GetVC2008Lib: String;
Begin
    Result := GetVC200XPath('9.0', 2);
End;

Function GetVC2005Lib: String;
Begin
    Result := GetVC200XPath('8.0', 2);
End;

Function GetVC2003Lib: String;
Begin
    Result := GetVC200XPath('7.1', 2);
End;

Function GetVC6Lib: String;
Begin
    Result := GetVC6Path(2);
End;

Function GetTDMGCCDir: String;
Var
    Reg: TRegistry;
Begin

    Reg := TRegistry.Create;
    Try
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        If Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Uninstall\TDM-GCC', False) Then
        Begin
            Result := Reg.ReadString('InstallLocation');
        End
        Else
            Result := '';

        Reg.CloseKey;
    Finally
        Reg.Free;
    End;

End;

End.
