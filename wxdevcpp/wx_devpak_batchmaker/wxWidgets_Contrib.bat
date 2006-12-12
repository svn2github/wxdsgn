md %WXWIN%\contrib\lib
md %WXWIN%\contrib\lib\%1_lib
cd /d %wxwin%
%STARTDIR%\gsar -s..\..\..\lib\ -r..\..\lib\ -o contrib\build\deprecated\makefile.%1
%STARTDIR%\gsar -s..\..\..\lib\ -r..\..\lib\ -o contrib\build\fl\makefile.%1
%STARTDIR%\gsar -s..\..\..\lib\ -r..\..\lib\ -o contrib\build\foldbar\makefile.%1
%STARTDIR%\gsar -s..\..\..\lib\ -r..\..\lib\ -o contrib\build\gizmos\makefile.%1
%STARTDIR%\gsar -s..\..\..\lib\ -r..\..\lib\ -o contrib\build\mmedia\makefile.%1
%STARTDIR%\gsar -s..\..\..\lib\ -r..\..\lib\ -o contrib\build\net\makefile.%1
%STARTDIR%\gsar -s..\..\..\lib\ -r..\..\lib\ -o contrib\build\ogl\makefile.%1
%STARTDIR%\gsar -s..\..\..\lib\ -r..\..\lib\ -o contrib\build\plot\makefile.%1
%STARTDIR%\gsar -s..\..\..\lib\ -r..\..\lib\ -o contrib\build\stc\makefile.%1
%STARTDIR%\gsar -s..\..\..\lib\ -r..\..\lib\ -o contrib\build\svg\makefile.%1

IF "%1"=="gcc" SET MAKEPROG=mingw32-make
IF "%1"=="vc" SET MAKEPROG=nmake
IF "%1"=="dmc" SET MAKEPROG=make
IF "%1"=="bcc" SET MAKEPROG=make


IF "%1"=="gcc" SET PATH=%gccpath%
IF "%1"=="vc" SET PATH=%vcpath%
IF "%1"=="dmc" SET PATH=%dmcpath%
IF "%1"=="bcc" SET PATH=%bccpath%


cd /d %wxwin%\contrib\build\deprecated

%MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 VENDOR=wxdevcpp 2> error_%1_deprecated.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\fl
%MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 VENDOR=wxdevcpp  2> error_%1_fl.txt
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\foldbar
%MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 VENDOR=wxdevcpp 2> error_%1_foldbar.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\gizmos
%MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 VENDOR=wxdevcpp 2> error_%1_gizmos.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\mmedia
%MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 VENDOR=wxdevcpp 2> error_%1_mmedia.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\net
%MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 VENDOR=wxdevcpp 2> error_%1_net.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\ogl
%MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 VENDOR=wxdevcpp 2> error_%1_ogl.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\plot
%MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 VENDOR=wxdevcpp 2> error_%1_plot.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\stc
%MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 VENDOR=wxdevcpp 2> error_%1_stc.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\svg
%MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 VENDOR=wxdevcpp  2> error_%1_svg.txt
if NOT errorlevel 1 goto CONTRIB_END

:CONTRIB_BUILD_ERR
SET BUILDRESULT=F
:CONTRIB_END


set path=%OLDPATH%
