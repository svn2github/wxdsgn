echo Contrib
cd /d %wxwin%
%STARTDIR%\gsar -s..\..\..\lib\ -r..\..\lib\ -o src\stc\makefile.%1
%STARTDIR%\gsar -s..\..\..\lib\ -r..\..\lib\ -o src\svg\makefile.%1

IF "%1"=="gcc" SET MAKEPROG=mingw32-make
IF "%1"=="vc" SET MAKEPROG=nmake
IF "%1"=="dmc" SET MAKEPROG=make
IF "%1"=="bcc" SET MAKEPROG=make


IF "%1"=="gcc" SET PATH=%gccpath%
IF "%1"=="vc" SET PATH=%vcpath%
IF "%1"=="dmc" SET PATH=%dmcpath%
IF "%1"=="bcc" SET PATH=%bccpath%



cd ..\stc
%MAKEPROG% -f makefile_stc.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_ODBC=1 RUNTIME_LIBS=static UNICODE=%UNICODE_FLAG% USE_RTTI=0 USE_EXCEPTIONS=1 VENDOR=wxdevcpp DEBUG_FLAG=0 2> error_%1_stc.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\svg
%MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_ODBC=1 \
RUNTIME_LIBS=static UNICODE=%UNICODE_FLAG% USE_RTTI=0 USE_EXCEPTIONS=1 \
VENDOR=wxdevcpp  2> error_%1_svg.txt
if NOT errorlevel 1 goto CONTRIB_END

:CONTRIB_BUILD_ERR
SET BUILDRESULT=F
:CONTRIB_END


set path=%OLDPATH%
