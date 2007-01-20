rem This contains all of the common variables used in all batch files

rem ask all the questions first

set STARTDIR=%CD%

echo off
cls

rem Default wxWidgets root directory
set WXVER=2.8.0

echo What version of wxWidgets are you building (Default = %WXVER%)?
set /P WXVER=
set DEVPAKDIR=%STARTDIR%\devpaks_%WXVER%

set WXWIN=c:\wxWidgets-%WXVER%

echo In what directory is wxWidgets located (Default = %WXWIN%)?
set /P WXWIN=

set WXCODE=c:\wxCode
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
echo Preparing Visual C++ Paths


REM -------------------------------------------------------------------
REM Set common variables
REM -------------------------------------------------------------------
Set MSSdk=D:\Program Files\Microsoft Platform SDK for Windows Server 2003 R2
Set Bkoffice=%MSSdk%\
Set Basemake=%MSSdk%\Include\BKOffice.Mak
Set INETSDK=%MSSdk%
Set MSSdk=%MSSdk%
Set Mstools=%MSSdk%


REM -------------------------------------------------------------------
REM Set Windows 2000 specific variables
:Set2000_2000
REM -------------------------------------------------------------------
Echo Targeting Windows 2000 and IE 5.0 %DEBUGMSG%
Echo.
Set Lib=%MSSdk%\Lib;%Lib%
Set Include=%MSSdk%\Include;%Include%

Set Path=%MSSdk%\Bin;%MSSdk%\Bin\WinNT;
Set APPVER=5.0
Set TARGETOS=WINNT
Title Microsoft Platform SDK Windows 2000 IE 5.0 %DEBUGMSG% Build Environment



@SET VSINSTALLDIR=C:\Program Files\Microsoft Visual Studio 8
@SET VCINSTALLDIR=C:\Program Files\Microsoft Visual Studio 8\VC
@SET FrameworkDir=C:\WINNT\Microsoft.NET\Framework
@SET FrameworkVersion=v2.0.50727
@SET FrameworkSDKDir=C:\Program Files\Microsoft Visual Studio 8\SDK\v2.0
@if "%VSINSTALLDIR%"=="" goto error_no_VSINSTALLDIR
@if "%VCINSTALLDIR%"=="" goto error_no_VCINSTALLDIR


@rem Root of Visual Studio IDE installed files.
@rem
@set DevEnvDir=%VSINSTALLDIR%\Common7\IDE
echo 1
@set VCPATH=%DevEnvDir%;%VCINSTALLDIR%\BIN;%VSINSTALLDIR%\Common7\Tools;%VSINSTALLDIR%\SDK\v2.0\bin;C:\WINNT\Microsoft.NET\Framework\v2.0.50727;%VCINSTALLDIR%\VCPackages;%PATH%
echo 2
@set INCLUDE=C:\Program Files\Microsoft Visual Studio 8\VC\INCLUDE;%INCLUDE%
echo 3
rem mn dont forget @set LIB=C:\Program Files\Microsoft Visual Studio 8\VC\LIB;C:\Program Files\Microsoft Visual Studio 8\SDK\v2.0\lib;%LIB%
echo 4
@set LIBPATH=C:\WINNT\Microsoft.NET\Framework\v2.0.50727

echo 4
@goto TEST_DMC
echo 5

:error_no_VCINSTALLDIR
@echo ERROR: VCINSTALLDIR variable is not set. 
@goto end

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
