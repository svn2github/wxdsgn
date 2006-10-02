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

unit version;

interface

var
  LIB_EXT: string;
  OBJ_EXT: string;
  
const
  GCC_VERSION          = '3.4.2';
  //path delimiter
{$IFDEF WIN32}
  pd                   = '\';
{$ENDIF}
{$IFDEF LINUX}
  pd                   = '/';
{$ENDIF}

resourcestring
  // misc strings
  DEVCPP = 'wxDev-C++';
  DEVCPP_VERSION    = '6.10';
  DEFAULT_LANG_FILE = 'English.lng';
  HTTP = 'http://';
  DEV_INTERNAL_OPEN = '$__DEV_INTERNAL_OPEN';
  DEV_SEARCHLOOP = '$__DEV_SEARCH_LOOP';
  DEV_COMPLETION_CACHE = 'cache.ccc';
  DEV_DEFAULTCODE_FILE = 'defaultcode.cfg';
  DEV_SHORTCUTS_FILE = 'devshortcuts.cfg';
  DEV_CLASSFOLDERS_FILE= 'classfolders.dcf';
  DEV_WEBMIRRORS_FILE = 'mirrors.cfg';
  DEV_MAKE_FILE = 'Makefile.win';
  DEV_TOOLS_FILE = 'tools.ini';
  DEV_HELP_INI = 'devhelp.ini';
  DEV_CODEINS_FILE = 'devcpp.ci';
  DEV_MAINHELP_FILE = 'devcpp.hlp';
  DEV_GNOME_THEME = 'Gnome';
  DEV_NEWLOOK_THEME = 'New Look';
  DEV_BLUE_THEME = 'Blue';
  DEV_INTERNAL_THEME = 'New Look';
  // default directories
  GCC_BIN_DIR = 'Bin;';
  GCC_LIB_DIR = 'Lib;';
  GCC_C_INCLUDE_DIR = 'Include;';
  GCC_RC_INCLUDE_DIR  = 'include'+ pd + 'common;';

  //Vc++
  VC_BIN_DIR = 'Bin'+pd+'VC;Bin;';
  VC_LIB_DIR = 'Lib'+pd+'VC';
  VC_C_INCLUDE_DIR = 'Include'+pd+'common;Include'+pd+'VC;';
  VC_RC_INCLUDE_DIR  = 'include'+ pd + 'common;';

  //DMAR
  DMARS_BIN_DIR = 'Bin;Bin'+pd+'dmars;';
  DMARS_LIB_DIR = 'Lib'+pd+'dmars;';
  DMARS_C_INCLUDE_DIR = 'Include'+pd+'common;Include'+pd+'dmars;';
  DMARS_RC_INCLUDE_DIR  = 'include'+ pd + 'common;';

  //Borland
  BORLAND_BIN_DIR = 'Bin;Bin'+pd+'borland;';
  BORLAND_LIB_DIR = 'Lib'+pd+'borland;';
  BORLAND_C_INCLUDE_DIR = 'Include'+pd+'borland;Include'+pd+'common;';
  BORLAND_RC_INCLUDE_DIR  = 'include'+ pd + 'common;';

  //Borland
  WATCOM_BIN_DIR = 'Bin;Bin'+pd+'watcom;';
  WATCOM_LIB_DIR = 'Lib'+pd+'watcom;';
  WATCOM_C_INCLUDE_DIR = 'Include'+pd+'watcom;Include'+pd+'common;';
  WATCOM_RC_INCLUDE_DIR  = 'include'+ pd + 'common;';


  COMMON_CPP_INCLUDE_DIR      =
//The Dir are taken from bottom to up. So I added the dir in the inverted order in which
//they are picked by the parser.
                       'include' + pd + 'common;'
                       +'include' + pd + 'common' + pd + 'wx;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'xrc;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'xml;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'svg;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'stc;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'protocol;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'plot;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'ogl;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'net;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'mmedia;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'html;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'gizmos;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'fl;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'animate;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'generic;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'msw;'  ;

  GCC_CPP_INCLUDE_DIR  =
                        ';include'
                       //one of below directories will be deleted if don't exist, later
                       + ';include' + pd + 'c++' + pd + GCC_VERSION
                       + ';include' + pd + 'c++' + pd + GCC_VERSION + pd + 'mingw32'
                       + ';include' + pd + 'c++' + pd + GCC_VERSION + pd + 'backward'
                       + ';lib' + pd + 'gcc' + pd + 'mingw32' + pd + GCC_VERSION + pd + 'include;'
					   ;

  VC_CPP_INCLUDE_DIR  =
                        ';include'+pd+'VC;'+'include'+pd+'common;';

  BORLAND_CPP_INCLUDE_DIR  =
                        ';include'+pd+'borland;'+'include'+pd+'common;';

  DMARS_CPP_INCLUDE_DIR  =
                        ';include'+pd+'dmars;' + 'include'+pd+'common;';

  WATCOM_CPP_INCLUDE_DIR  =
                        ';include'+pd+'watcom;'+'include'+pd+'common;';

  LANGUAGE_DIR         = 'Lang' + pd;
  ICON_DIR             = 'Icons' + pd;
  HELP_DIR             = 'Help' + pd;
  TEMPLATE_DIR         = 'Templates' + pd;
  THEME_DIR            = 'Themes' + pd;
  PACKAGES_DIR         = 'Packages' + pd;

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

  GCC_MAKE_PROGRAM = 'mingw32-make.exe';
  GCC_CP_PROGRAM = 'gcc.exe';
  GCC_CPP_PROGRAM = 'g++.exe';
  GCC_DBG_PROGRAM = 'gdb.exe';
  GCC_RES_PROGRAM = 'windres.exe';
  GCC_DLL_PROGRAM = 'dllwrap.exe';
  GCC_PROF_PROGRAM = 'gprof.exe';


  VC_MAKE_PROGRAM = 'mingw32-make.exe';
  VC_CP_PROGRAM = 'cl.exe';
  VC_CPP_PROGRAM = 'cl.exe';
  VC_DBG_PROGRAM = 'cdb.exe';
  VC_RES_PROGRAM = 'res.exe';
  VC_DLL_PROGRAM = 'link.exe';
  VC_PROF_PROGRAM = '';


  DMARS_MAKE_PROGRAM = 'mingw32-make.exe';
  DMARS_CP_PROGRAM = 'cl.exe';
  DMARS_CPP_PROGRAM = 'cl.exe';
  DMARS_DBG_PROGRAM = 'cdb.exe';
  DMARS_RES_PROGRAM = 'rcc.exe';
  DMARS_DLL_PROGRAM = 'link.exe';
  DMARS_PROF_PROGRAM = '';

  BORLAND_MAKE_PROGRAM = 'mingw32-make.exe';
  BORLAND_CP_PROGRAM = 'borgcc.exe';
  BORLAND_CPP_PROGRAM = 'borg++.exe';
  BORLAND_DBG_PROGRAM = 'borgdb.exe';
  BORLAND_RES_PROGRAM = 'borwindres.exe';
  BORLAND_DLL_PROGRAM = 'link.exe';
  BORLAND_PROF_PROGRAM = 'borgprof.exe';

  WATCOM_MAKE_PROGRAM = 'mingw32-make.exe';
  WATCOM_CP_PROGRAM = 'owatgcc.exe';
  WATCOM_CPP_PROGRAM = 'owatg++.exe';
  WATCOM_DBG_PROGRAM = 'owatgdb.exe';
  WATCOM_RES_PROGRAM = 'owatwindres.exe';
  WATCOM_DLL_PROGRAM = 'link.exe';
  WATCOM_PROF_PROGRAM = 'owatgprof.exe';

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
  VC_DEFCOMPILERSET = 'Default VC compiler';
  DMARS_DEFCOMPILERSET = 'Default DigitalMars compiler';
  BORLAND_DEFCOMPILERSET = 'Default Borland compiler';
  WATCOM_DEFCOMPILERSET = 'Default Watcom compiler';

  //Filters
  FLT_BASE = 'All known Files||';
  FLT_ALLFILES = 'All files (*.*)|*.*|';
  FLT_PROJECTS = 'Dev-C++ project (*.dev)|*.dev';
{$IFDEF WX_BUILD}
  FLT_WXFORMS = 'wxWidgets Forms (*.wxForm)|*.wxForm';
  FLT_XRC = 'XRC/XML files (*.xml) |*.xml';
{$ENDIF}
  FLT_HEADS = 'Header files (*.h;*.hpp;*.rh;*.hh)|*.h;*.hpp;*.rh;*.hh';
  FLT_CS = 'C source files (*.c)|*.c';
  FLT_CPPS             = 'C++ source files (*.cpp;*.cc;*.cxx;*.c++;*.cp)|*.cpp;*.cc;*.cxx;*.c++;*.cp';
  FLT_RES = 'Resource scripts (*.rc)|*.rc';
  FLT_HELPS            = 'Help files (*.hlp;*.chm;*.col)|*.hlp;*.chm;*.col|HTML files (*.htm;*.html)|*.htm;*.html|Text files (*.doc;*.rtf;*.txt)|*.doc;*.rtf;*.txt|All files (*.*)|*.*';
  FLT_MSVCPROJECTS = 'MS Visual C++ projects (*.dsp)|*.dsp';

  cBP = 'Break points';
  cErr = 'Error Line';
  cABP = 'Active Breakpoints';
  cGut = 'Gutter';
  cSel = 'Selected text';

const
  //  source file extensions
  C_EXT = '.c';
  CPP_EXT = '.cpp';
  CC_EXT = '.cc';
  CXX_EXT = '.cxx';
  CP2_EXT = '.c++';
  CP_EXT = '.cp';
  H_EXT = '.h';
  PCH_EXT = '.pch';
  HPP_EXT = '.hpp';
  RC_EXT = '.rc';
  RES_EXT = '.res';
  RH_EXT = '.rh';
{$IFDEF WX_BUILD}
  APP_SUFFIX = 'App';
  WXFORM_EXT = '.wxform';
  XRC_EXT = '.xml';
{$ENDIF}
  PATH_LEN = 512;
  CONFIG_PARAM = '-c';

  // file type arrays used in getfileex in utils
  cTypes: array[0..0] of string[4] = (C_EXT);
  cppTypes:  array[0..4] of string[4] = (CPP_EXT, CC_EXT, CXX_EXT, CP2_EXT, CP_EXT);
  headTypes: array[0..2] of string[4] = (H_EXT, HPP_EXT, RH_EXT);
  resTypes: array[0..3] of string[4] = (RES_EXT, RC_EXT, RH_EXT, XRC_EXT);

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

  T_PROMPT = 'prompt';
  T_BREAKPOINT = 'breakpoint';
  T_SOURCE = 'source';
  T_DISPLAY_EXPRESSION = 'display-expression';
  T_DISPLAY_BEGIN = 'display-begin';
  T_DISPLAY_VALUE = 'display-value';
  T_DISPLAY_END = 'display-end';
  T_FIELD_NAME = 'field-begin';
  T_FIELD_VALUE = 'field-value';
  T_FIELD_END = 'field-end';
  T_GDB_ERROR = 'error';
  T_GDB_ERRORBEGIN = 'error-begin';
  T_FRAME_FUNCNAME = 'frame-function-name';
  T_FRAME_ARGS = 'frame-args';
  T_FRAME_ARG_BEGIN = 'arg-begin';
  T_FRAME_ARG_NAME_END = 'arg-name-end';
  T_FRAME_ARG_VALUE = 'arg-value';
  T_FRAME_ARG_END = 'arg-end';
  T_FRAME_SOURCEFILE = 'frame-source-file';
  T_FRAME_SOURCELINE = 'frame-source-line';
  T_DUMP = 'Dump';
  T_OF = 'of';
  T_POST_PROMPT = 'post-prompt';
  T_ASM = 'assembler';
  T_SIGNAL_STRING = 'signal-string';
  T_SEGFAULT = 'Segmentation';
  T_ARRAYSECTION_BEGIN = 'array-section-begin';
  T_ARRAYSECTION_END = 'array-section-end';

  // GPROF commands and displays
  GPROF_CHECKFILE = 'gmon.out';
  GPROF_CMD_GENFLAT = '-p';
  GPROF_CMD_GENMAP = '-q';

  function MAKE_PROGRAM(CompilerID:Integer):String;
  function CP_PROGRAM(CompilerID:Integer):String;
  function CPP_PROGRAM(CompilerID:Integer):String;
  function DBG_PROGRAM(CompilerID:Integer):String;
  function RES_PROGRAM(CompilerID:Integer):String;
  function DLL_PROGRAM(CompilerID:Integer):String;
  function PROF_PROGRAM(CompilerID:Integer):String;
  function DEFCOMPILERSET(CompilerID:Integer):String;

   // default directories
  function BIN_DIR(CompilerID:Integer):String;
  function LIB_DIR(CompilerID:Integer):String;
  function C_INCLUDE_DIR(CompilerID:Integer):String;
  function CPP_INCLUDE_DIR(CompilerID:Integer):String;
  function RC_INCLUDE_DIR(CompilerID:Integer):String;

  function CPP_INI_LABEL(CompilerID:Integer):String;
  function C_INI_LABEL(CompilerID:Integer):String;
  function LINKER_INI_LABEL(CompilerID:Integer):String;
  function PREPROC_INI_LABEL(CompilerID:Integer):String;  
var
  DevCppDir: string;

implementation
uses devcfg;

function CPP_INI_LABEL(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := 'CppCompiler';

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := 'VC_CppCompiler';

      ID_COMPILER_DMARS:
        Result := 'DMARS_CppCompiler';

      ID_COMPILER_BORLAND:
        Result := 'BORLAND_CppCompiler';

      ID_COMPILER_WATCOM:
        Result := 'WATCOM_CppCompiler';
  end;

end;


function C_INI_LABEL(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := 'Compiler';

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := 'VC_Compiler';

      ID_COMPILER_DMARS:
        Result := 'DMARS_Compiler';

      ID_COMPILER_BORLAND:
        Result := 'BORLAND_Compiler';

      ID_COMPILER_WATCOM:
        Result := 'WATCOM_Compiler';
  end;
end;


function LINKER_INI_LABEL(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := 'Linker';

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := 'VC_Linker';

      ID_COMPILER_DMARS:
        Result := 'DMARS_Linker';

      ID_COMPILER_BORLAND:
        Result := 'BORLAND_Linker';

      ID_COMPILER_WATCOM:
        Result := 'WATCOM_Linker';
  end;
end;

function PREPROC_INI_LABEL(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := 'PreprocDefines';

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := 'VC_PreprocDefines';

      ID_COMPILER_DMARS:
        Result := 'DMARS_PreprocDefines';

      ID_COMPILER_BORLAND:
        Result := 'BORLAND_PreprocDefines';

      ID_COMPILER_WATCOM:
        Result := 'WATCOM_PreprocDefines';
  end;
end;


function MAKE_PROGRAM(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := GCC_MAKE_PROGRAM;

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := VC_MAKE_PROGRAM;

      ID_COMPILER_DMARS:
        Result := DMARS_MAKE_PROGRAM;

      ID_COMPILER_BORLAND:
        Result := BORLAND_MAKE_PROGRAM;

      ID_COMPILER_WATCOM:
        Result := WATCOM_MAKE_PROGRAM;

  end;

end;

function CP_PROGRAM(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := GCC_CP_PROGRAM;

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := VC_CP_PROGRAM;

      ID_COMPILER_DMARS:
        Result := DMARS_CP_PROGRAM;

      ID_COMPILER_BORLAND:
        Result := BORLAND_CP_PROGRAM;

      ID_COMPILER_WATCOM:
        Result := WATCOM_CP_PROGRAM;

  end;
end;

function CPP_PROGRAM(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := GCC_CPP_PROGRAM;

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := VC_CPP_PROGRAM;

      ID_COMPILER_DMARS:
        Result := DMARS_CPP_PROGRAM;

      ID_COMPILER_BORLAND:
        Result := BORLAND_CPP_PROGRAM;

      ID_COMPILER_WATCOM:
        Result := WATCOM_CPP_PROGRAM;
  end;
end;


function DBG_PROGRAM(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := GCC_DBG_PROGRAM;

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := VC_DBG_PROGRAM;

      ID_COMPILER_DMARS:
        Result := DMARS_DBG_PROGRAM;

      ID_COMPILER_BORLAND:
        Result := BORLAND_DBG_PROGRAM;

      ID_COMPILER_WATCOM:
        Result := WATCOM_DBG_PROGRAM;
  end;
end;

function RES_PROGRAM(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := GCC_RES_PROGRAM;

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := VC_RES_PROGRAM;

      ID_COMPILER_DMARS:
        Result := DMARS_RES_PROGRAM;

      ID_COMPILER_BORLAND:
        Result := BORLAND_RES_PROGRAM;

      ID_COMPILER_WATCOM:
        Result := WATCOM_RES_PROGRAM;
  end;
end;

function DLL_PROGRAM(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := GCC_DLL_PROGRAM;

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := VC_DLL_PROGRAM;

      ID_COMPILER_DMARS:
        Result := DMARS_DLL_PROGRAM;

      ID_COMPILER_BORLAND:
        Result := BORLAND_DLL_PROGRAM;

      ID_COMPILER_WATCOM:
        Result := WATCOM_DLL_PROGRAM;

  end;
end;

function DEFCOMPILERSET(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := GCC_DEFCOMPILERSET;

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := VC_DEFCOMPILERSET;

      ID_COMPILER_DMARS:
        Result := DMARS_DEFCOMPILERSET;

      ID_COMPILER_BORLAND:
        Result := BORLAND_DEFCOMPILERSET;

      ID_COMPILER_WATCOM:
        Result := WATCOM_DEFCOMPILERSET;
  end;
end;


function PROF_PROGRAM(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := GCC_PROF_PROGRAM;

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := VC_PROF_PROGRAM;

      ID_COMPILER_DMARS:
        Result := DMARS_PROF_PROGRAM;

      ID_COMPILER_BORLAND:
        Result := BORLAND_PROF_PROGRAM;

      ID_COMPILER_WATCOM:
        Result := WATCOM_PROF_PROGRAM;

  end;
end;

function BIN_DIR(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := GCC_BIN_DIR;

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := VC_BIN_DIR;

      ID_COMPILER_DMARS:
        Result := DMARS_BIN_DIR;

      ID_COMPILER_BORLAND:
        Result := BORLAND_BIN_DIR;

      ID_COMPILER_WATCOM:
        Result := WATCOM_BIN_DIR;
  end;
end;

function LIB_DIR(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := GCC_LIB_DIR;

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := VC_LIB_DIR;

      ID_COMPILER_DMARS:
        Result := DMARS_LIB_DIR;

      ID_COMPILER_BORLAND:
        Result := BORLAND_LIB_DIR;

      ID_COMPILER_WATCOM:
        Result := WATCOM_LIB_DIR;

  end;
end;

function C_INCLUDE_DIR(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := GCC_C_INCLUDE_DIR;

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := VC_C_INCLUDE_DIR;

      ID_COMPILER_DMARS:
        Result := DMARS_C_INCLUDE_DIR;

      ID_COMPILER_BORLAND:
        Result := BORLAND_C_INCLUDE_DIR;

      ID_COMPILER_WATCOM:
        Result := WATCOM_C_INCLUDE_DIR;
  end;
end;

function CPP_INCLUDE_DIR(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := COMMON_CPP_INCLUDE_DIR + GCC_CPP_INCLUDE_DIR;

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := COMMON_CPP_INCLUDE_DIR + VC_CPP_INCLUDE_DIR;

      ID_COMPILER_DMARS:
        Result := COMMON_CPP_INCLUDE_DIR + DMARS_CPP_INCLUDE_DIR ;

      ID_COMPILER_BORLAND:
        Result := COMMON_CPP_INCLUDE_DIR+ BORLAND_CPP_INCLUDE_DIR ;

      ID_COMPILER_WATCOM:
        Result := COMMON_CPP_INCLUDE_DIR+ WATCOM_CPP_INCLUDE_DIR ;
  end;
end;

function RC_INCLUDE_DIR(CompilerID:Integer):String;
begin
  case CompilerID of
      ID_COMPILER_MINGW :
          Result := GCC_RC_INCLUDE_DIR;

      ID_COMPILER_VC2005,
      ID_COMPILER_VC:
          Result := VC_RC_INCLUDE_DIR;

      ID_COMPILER_DMARS:
        Result := DMARS_RC_INCLUDE_DIR;

      ID_COMPILER_BORLAND:
        Result := BORLAND_RC_INCLUDE_DIR;

      ID_COMPILER_WATCOM:
        Result := WATCOM_RC_INCLUDE_DIR;
  end;
end;

end.
