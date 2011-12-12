echo 3rd party
md %WXWIN%\3rdparty\lib
md %WXWIN%\3rdparty\lib\%1_lib

IF "%1"=="gcc" SET MAKEPROG=mingw32-make
IF "%1"=="vc" SET MAKEPROG=nmake
IF "%1"=="dmc" SET MAKEPROG=make
IF "%1"=="bcc" SET MAKEPROG=make

IF "%1"=="gcc" SET PATH=%gccpath%
IF "%1"=="vc" SET PATH=%vcpath%
IF "%1"=="dmc" SET PATH=%dmcpath%
IF "%1"=="bcc" SET PATH=%bccpath%


copy %STARTDIR%\chartart.%1 %WXWIN%\3rdParty\build\chartart\makefile.%1
copy %STARTDIR%\sheet.%1 %WXWIN%\3rdParty\build\sheet\makefile.%1
copy %STARTDIR%\treelistctrl.%1 %WXWIN%\3rdParty\build\treelistctrl\makefile.%1
copy %STARTDIR%\treemultictrl.%1 %WXWIN%\3rdParty\build\treemultictrl\makefile.%1

echo makefiles copied

rem cd /d %WXWIN%\3rdparty\build\chartart
rem %MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 \
rem UNICODE=%UNICODE_FLAG% USE_OPENGL=1 USE_XRC=1 \
rem USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 \
rem USE_EXCEPTIONS=1 2> error_%1_chartart.txt 
rem if errorlevel 1 goto 3RDPARTY_BUILD_ERR


cd ..\sheet
%MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 \
UNICODE=%UNICODE_FLAG% USE_OPENGL=1 rem USE_XRC=1 \
USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 \
USE_EXCEPTIONS=1 2> error_%1_sheet.txt 
rem if errorlevel 1 goto 3RDPARTY_BUILD_ERR

cd ..\treelistctrl
%MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 \
UNICODE=%UNICODE_FLAG% USE_OPENGL=1 USE_XRC=1 \
USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 \
USE_EXCEPTIONS=1 2> error_%1_treelist.txt 
if errorlevel 1 goto 3RDPARTY_BUILD_ERR

cd ..\treemultictrl
%MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 \
UNICODE=%UNICODE_FLAG% USE_OPENGL=1 USE_XRC=1 \
USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 \
USE_EXCEPTIONS=1 2> error_%1_treemultictrl.txt 
if NOT errorlevel 1 goto 3RDPARTY_END

:3RDPARTY_BUILD_ERR
SET BUILDRESULT=F
:3RDPARTY_END

set path=%OLDPATH%