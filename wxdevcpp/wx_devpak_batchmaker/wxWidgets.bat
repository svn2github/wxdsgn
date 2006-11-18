CALL common_vars.bat

set STARTDIR=%CD%

cd %WXWIN%

rem build the main distribution of wxWidgets
cd build\msw

rem Clean the wxWidgets directories
mingw32-make -f makefile.gcc clean

rem Build the wxWidgets libraries
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_base.txt


cd %WXWIN%

rem make the folder for contrib libraries
md contrib\lib\gcc_lib

rem replace all occurrences of ..\..\..\lib\gcc_ with ..\..\lib\gcc_ in contrib makefiles
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\deprecated\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\fl\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\foldbar\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\gizmos\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\ifm\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\mmedia\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\net\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\ogl\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\plot\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\stc\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\svg\makefile.gcc

rem Copy the setup.h up one level
cd %WXWIN%\include\wx\msw
copy setup.h ..\setup.h


rem Write the files to subdirectory setup devpak

cd %STARTDIR%

set DEVPAKDIR=devpaks_%WXVER%
md %DEVPAKDIR%

copy wxWidgets_common.DevPackage %DEVPAKDIR%\wxWidgets_%WXVER%_common.DevPackage
copy wxWidgets_gcc.DevPackage %DEVPAKDIR%\wxWidgets_%WXVER%_gcc.DevPackage

cd %DEVPAKDIR%

%STARTDIR%\gsar -s_WXVER_ -r"%WXVER%" -o wxWidgets_%WXVER%_common.DevPackage
%STARTDIR%\gsar -s_WXVER_ -r"%WXVER%" -o wxWidgets_%WXVER%_gcc.DevPackage

%STARTDIR%\gsar -s_WXWIN_ -r"%WXWIN_GSAR%" -o wxWidgets_%WXVER%_common.DevPackage
%STARTDIR%\gsar -s_WXWIN_ -r"%WXWIN_GSAR%" -o wxWidgets_%WXVER%_gcc.DevPackage

rem Copy the wxWidgets libs and include files to the new devpak directory
xcopy /S %WXWIN%\lib\gcc_lib gcc_lib\
xcopy /S %WXWIN%\include include\


cd %WXWIN%

cd contrib\build\deprecated
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_deprecated.txt 

cd ..\fl
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1  2> error_fl.txt

cd ..\foldbar
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_foldbar.txt 

cd ..\gizmos
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_gizmos.txt 

cd ..\ifm
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_ifm.txt 

cd ..\mmedia
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_mmedia.txt 

cd ..\net
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_net.txt 

cd ..\ogl
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_ogl.txt 

cd ..\plot
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_plot.txt 

cd ..\stc
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_stc.txt 

cd ..\svg
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1  2> error_svg.txt

cd ..\..\..

rem Change the plotctrl files 
gsar -sWX_DEFINE_USER_EXPORTED_ARRAY_DOUBLE -r//WX_DEFINE_USER_EXPORTED_ARRAY_DOUBLE -o 3rdparty\include/wx/plotctrl/plotcurv.h
rem make the folder for 3rd party libraries
md 3rdparty\lib\gcc_lib

rem Change the sheet files     
rem gsar -s#include:x20"wx/dcscreen.h":x0d:x0a#endif -r#include "wx/dcscreen.h":x0d:x0a#include:x20"wx/combobox.h":x0d:x0a#endif -o 3rdParty\src\sheet\sheet.cpp


cd 3rdparty\build\chartart
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_chartart.txt 

cd ..\ifm
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_plotctrl.txt 

cd ..\plotctrl
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_plotctrl.txt 

cd ..\propgrid
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1  2> error_propgrid.txt

cd ..\scintilla
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1  2> error_scintilla.txt

cd ..\sheet
rem mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_sheet.txt 
copy output\*.a ..\..\lib\gcc_lib

cd ..\things
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_things.txt 

cd ..\treelistctrl
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_treelist.txt 

cd ..\treemultictrl
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_treemultictrl.txt 

rem Change back to the initial directory
cd %STARTDIR%

pause
