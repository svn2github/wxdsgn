rem This contains all of the common variables used in all batch files

rem ask all the questions first

set STARTDIR=%CD%

echo off
cls

rem Default wxWidgets root directory
set WXVER=2.9.1

rem Set UNICODE 0=off 1=on
set UNICODE_FLAG=1

echo What version of wxWidgets are you building (Default = %WXVER%)?
set /P WXVER=
set DEVPAKDIR=%STARTDIR%\devpaks_%WXVER%

rem Get the library version (e.g. 2.8.5 becomes 28)
rem wxlibversion.exe is a simple C++ program 
rem that takes the first 2 numbers of the library name
rem and removes the dots.
rem e.g wxlibversion.exe 2.8.10
rem   Output  SET WXLIBVERSION=28
wxlibversion.exe %WXVER% >> temp123.bat
call temp123.bat
del temp123.bat

set WXWIN=H:\wxWidgets-%WXVER%

echo In what directory is wxWidgets located (Default = %WXWIN%)?
set /P WXWIN=

set WXCODE=H:\wxCode
echo In what directory are the wxCode components located (Default = %WXCODE%)?
set /P WXCODE=

set BUILDBASE=Y
%STARTDIR%\CP /T:Y,5 Do you wish to build the BASE libraries (Default = %BUILDBASE%)?
IF ERRORLEVEL 1 GOTO BaseKeyPressed
GOTO BuildBaseEND
:BaseKeyPressed
rem echo. current errorlevel is %errorlevel%

rem IF ERRORLEVEL 2 IF NOT ERRORLEVEL 1 GOTO NoBaseBuild
IF ERRORLEVEL 2 GOTO NoBaseBuild
GOTO BuildBaseEND
:NoBaseBuild
set BUILDBASE=N
:BuildBaseEND


set BUILDCONTRIB=Y
%STARTDIR%\CP /T:Y,5 Do you wish to build the CONTRIB libraries (Default = %BUILDCONTRIB%)?
IF ERRORLEVEL 1 GOTO ContribKeyPressed
GOTO BuildContribEND
:ContribKeyPressed
rem echo. current errorlevel is %errorlevel%

rem IF ERRORLEVEL 2 IF NOT ERRORLEVEL 1 GOTO NoContribBuild
IF ERRORLEVEL 2 GOTO NoContribBuild
GOTO BuildContribEND
:NoContribBuild
set BUILDCONTRIB=N
:BuildContribEND


set BUILD3RDP=Y
%STARTDIR%\CP /T:Y,5 Do you wish to build the 3RD PARTY libraries (Default = %BUILD3RDP%)?
IF ERRORLEVEL 1 GOTO 3RDPKeyPressed
GOTO BUILD3RDPEND
:3RDPKeyPressed
rem echo. current errorlevel is %errorlevel%

rem IF ERRORLEVEL 2 IF NOT ERRORLEVEL 1 GOTO No3RDPBuild
IF ERRORLEVEL 2 GOTO No3RDPBuild
GOTO BUILD3RDPEND
:No3RDPBuild
set BUILD3RDP=N
:BUILD3RDPEND


set BUILDGCC=Y
%STARTDIR%\CP /T:Y,5 Do you wish to build using the GCC compiler (Default = %BUILDGCC%)?
IF ERRORLEVEL 1 GOTO GCCKeyPressed
GOTO BUILDGCCEND
:GCCKeyPressed
rem echo. current errorlevel is %errorlevel%

rem IF ERRORLEVEL 2 IF NOT ERRORLEVEL 1 GOTO NoGCCBuild
IF ERRORLEVEL 2 GOTO NoGCCBuild
GOTO BUILDGCCEND
:NoGCCBuild
set BUILDGCC=N
:BUILDGCCEND


set BUILDVC=N
%STARTDIR%\CP /T:N,5  Do you wish to build using the Microsoft compiler (Default = %BUILDVC%)?
IF ERRORLEVEL 1 GOTO VCKeyPressed
GOTO BUILDVCEND
:VCKeyPressed
echo. current errorlevel is %errorlevel%
IF ERRORLEVEL 2 GOTO BUILDVCEND
set BUILDVC=Y
:BUILDVCEND

set BUILDDMC=N
%STARTDIR%\CP /T:N,5  Do you wish to build using the Digital Mars compiler (Default = %BUILDVC%)?
IF ERRORLEVEL 1 GOTO DMCKeyPressed
GOTO BUILDDMCEND
:DMCKeyPressed
echo. current errorlevel is %errorlevel%
IF ERRORLEVEL 2 GOTO BUILDDMCEND
set BUILDDMC=Y
:BUILDDMCEND

set BUILDBCC=N
%STARTDIR%\CP /T:N,5  Do you wish to build using the Borland compiler (Default = %BUILDVC%)?
IF ERRORLEVEL 1 GOTO BCCKeyPressed
GOTO BUILDBCCEND
:BCCKeyPressed
echo. current errorlevel is %errorlevel%
IF ERRORLEVEL 2 GOTO BUILDBCCEND
set BUILDBCC=Y
:BUILDBCCEND

rem we have to make at least ONE library, so if all are N then we set GCC =Y
IF "%BUILDGCC%"=="Y" GOTO GSAR_SET
IF "%BUILDVC%"=="Y" GOTO GSAR_SET
IF "%BUILDDMC%"=="Y" GOTO GSAR_SET
IF "%BUILDBCC%"=="Y" GOTO GSAR_SET
set BUILDGCC=Y


:GSAR_SET

rem This is a work around for getting colons to work for gsar
rem gsar doesn't like the colon in the directory name (e.g. c:\)
rem so we'll write it to a file, then use gsar to turn the single
rem colons into double colons. This is saved to the variable
rem %whatever%_GSAR
echo set WXWIN_GSAR=%WXWIN%> temp123.bat
gsar -s:: -r:::: -o temp123.bat
call temp123.bat
del temp123.bat

echo set DEVPAKDIR_GSAR=%DEVPAKDIR%> temp123.bat
gsar -s:: -r:::: -o temp123.bat
call temp123.bat
del temp123.bat

set oldpath=%path%

:TEST_GCC
IF NOT "%BUILDGCC%"=="Y" GOTO TEST_VC

:GCC_PATH
echo Preparing GCC paths
set gccpath=c:\Progra~1\Dev-Cpp\bin;%oldpath%

:TEST_VC
IF NOT "%BUILDVC%"=="Y" GOTO TEST_DMC

:VC_PATH
echo It is preferable to run this script from the VS Command Prompt
echo to build the VC devpaks
echo Otherwise, the paths might not be correct.
echo Trying to prepare Visual C++ Paths (by running vcvarsall.bat)

rem Look up the Visual Studio directory in the Windows registry
rem Version 9.0 = VS 2008; Version 8.0 = VS 2005
FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\VisualStudio\SxS\VC7" /v 9.0') DO SET VCVARS_DIR=%%B
set VC_VER=2008
IF EXIST "%VCVARS_DIR%vcvarsall.bat" goto found_VCVARS

rem Look up the Visual Studio directory in the Windows registry
rem Version 9.0 = VS 2008; Version 8.0 = VS 2005
FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\VisualStudio\SxS\VC7" /v 8.0') DO SET VCVARS_DIR=%%B
set VC_VER=2005
IF EXIST "%VCVARS_DIR%vcvarsall.bat" goto found_VCVARS

echo In what directory is vcvarsall.bat located (Default = %VCVARS_DIR%)?
set /P VCVARS_DIR=
IF EXIST "%VCVARS_DIR%vcvarsall.bat" goto found_VCVARS

echo "vcvarsall.bat cannot be found in directory %VCVARS_DIR%"
pause
EXIT /B

:found_VCVARS
rem Run the Visual Studio setup script
call "%VCVARS_DIR%vcvarsall.bat"
set vcpath=%path%

:TEST_DMC
IF NOT "%BUILDDMC%"=="Y" GOTO TEST_BCC

:DMC_PATH
echo Preparing DMC paths
set DMCpath=c:\Progra~1\Dev-Cpp\bin\dmars;%oldpath%

:TEST_BCC
IF NOT "%BUILDBCC%"=="Y" GOTO end

:BCC_PATH
echo Preparing BCC paths
set BCCpath=c:\Borland\bcc55\bin;%oldpath%

:end
