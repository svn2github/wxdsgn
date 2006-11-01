set WXWIN=c:\wxWidgets
path=c:\Progra~1\Dev-Cpp\bin;%path%

rem build the main distribution of wxWidgets
cd build\msw
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_base.txt


pause
