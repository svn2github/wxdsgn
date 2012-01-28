IF "%1"=="gcc" SET MAKEPROG=mingw32-make
IF "%1"=="vc" SET MAKEPROG=nmake
IF "%1"=="dmc" SET MAKEPROG=make
IF "%1"=="bcc" SET MAKEPROG=make

IF "%1"=="gcc" SET PATH=%gccpath%
IF "%1"=="vc" SET PATH=%vcpath%
IF "%1"=="dmc" SET PATH=%dmcpath%
IF "%1"=="bcc" SET PATH=%bccpath%



cd %WXWIN%
cd build\msw


echo Cleaning old build
%MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 UNICODE=%UNICODE_FLAG% VENDOR=wxdevcpp clean


rem %MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 rem USE_EXCEPTIONS=1 USE_STC=1 USE_SVG=1 USE_XRC=1 UNICODE=%UNICODE_FLAG% -DWXUSINGDLL VENDOR=wxdevcpp all 2> rem error_%1_base.txt

echo Creating new build
%MAKEPROG% -f makefile.%1 BUILD=release MONOLITHIC=1 UNICODE=%UNICODE_FLAG% VENDOR=wxdevcpp all 2> error_%1_base.txt

if NOT errorlevel 1 goto BASE_END

:BASE_BUILD_ERR
SET BUILDRESULT=F
:BASE_END


set path=%oldpath%
