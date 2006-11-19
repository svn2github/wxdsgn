CALL common_vars.bat



@echo --------------------------------------------------------------------
@echo -
@echo -    Build Base wxWidgets Libraries
@echo -
@echo --------------------------------------------------------------------


rem Copy the setup.h up one level
del %WXWIN%\include\wx\setup.h
cd %WXWIN%\include\wx\msw
%STARTDIR%\gsar -s#define:x20wxUSE_GLCANVAS:x20:x20:x20:x20:x20:x20:x200 -r#define:x20wxUSE_GLCANVAS:x20:x20:x20:x20:x20:x20:x201 -o setup.h
%STARTDIR%\gsar -s##define:x20wxUSE_ODBC:x20:x20:x20:x20:x20:x20:x20:x20:x20:x200 -r#define:x20wxUSE_ODBC:x20:x20:x20:x20:x20:x20:x20:x20:x20:x201 -o setup.h
%STARTDIR%\gsar -s##define:x20wxUSE_DATEPICKCTRL_GENERIC:x200 -r#define:x20wxUSE_DATEPICKCTRL_GENERIC:x201 -o setup.h
copy setup.h ..\setup.h

cd %WXWIN%

rem build the main distribution of wxWidgets
cd build\msw

rem Clean the wxWidgets directories
rem mingw32-make -f makefile.gcc clean BUILD=release

rem Build the wxWidgets libraries
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_base.txt

if errorlevel 1 goto BASE_BUILD_ERR

@echo --------------------------------------------------------------------
@echo -
@echo -    Prepare Base wxWidgets devpak
@echo -
@echo --------------------------------------------------------------------

cd %STARTDIR%

rem remove a previously built devpak dir

rd /S /Q %DEVPAKDIR% 


md %DEVPAKDIR%
md %DEVPAKDIR%\docs
copy %WXWIN%\docs\licence.txt %DEVPAKDIR%\docs\
copy %WXWIN%\docs\readme.txt %DEVPAKDIR%\docs\

copy wxWidgets_common.DevPackage %DEVPAKDIR%\wxWidgets_%WXVER%_common.DevPackage
copy wxWidgets_gcc.DevPackage %DEVPAKDIR%\wxWidgets_%WXVER%_gcc.DevPackage

cd %DEVPAKDIR%

%STARTDIR%\gsar -s_WXVER_ -r"%WXVER%" -o wxWidgets_%WXVER%_common.DevPackage
%STARTDIR%\gsar -s_WXVER_ -r"%WXVER%" -o wxWidgets_%WXVER%_gcc.DevPackage

%STARTDIR%\gsar -s_WXWIN_ -r"%WXWIN_GSAR%" -o wxWidgets_%WXVER%_common.DevPackage
%STARTDIR%\gsar -s_WXWIN_ -r"%WXWIN_GSAR%" -o wxWidgets_%WXVER%_gcc.DevPackage

rem Copy the wxWidgets libs and include files to the new devpak directory
xcopy /S %WXWIN%\lib\gcc_lib gcc\gcc_lib\
xcopy /S %WXWIN%\include common\include\

cd %STARTDIR%
md %DEVPAKDIR%\common\Templates
md %DEVPAKDIR%\common\Templates\wxWidgets
copy ..\Templates\*wx*.* %DEVPAKDIR%\common\Templates\
copy ..\Templates\wxWidgets\wx*.* %DEVPAKDIR%\common\Templates\wxWidgets\



@echo --------------------------------------------------------------------
@echo -
@echo -    Build Contrib wxWidgets Libraries
@echo -
@echo --------------------------------------------------------------------

rem make the folder for contrib libraries
cd %WXWIN%
md contrib\lib\gcc_lib

%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\deprecated\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\fl\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\foldbar\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\gizmos\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\mmedia\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\net\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\ogl\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\plot\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\stc\makefile.gcc
%STARTDIR%\gsar -s..\..\..\lib\gcc_ -r..\..\lib\gcc_ -o contrib\build\svg\makefile.gcc

cd contrib\build\deprecated
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_deprecated.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\fl
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1  2> error_fl.txt
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\foldbar
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_foldbar.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\gizmos
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_gizmos.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\mmedia
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_mmedia.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\net
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_net.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\ogl
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_ogl.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\plot
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_plot.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\stc
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_stc.txt 
if errorlevel 1 goto CONTRIB_BUILD_ERR

cd ..\svg
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1  2> error_svg.txt
if errorlevel 1 goto CONTRIB_BUILD_ERR

FOR /R %WXWIN%\contrib\samples %%G IN (makefile.*, *.bkl, *.ds?, *.vc?, *.pro, descrip.mms) DO del %%G

@echo --------------------------------------------------------------------
@echo -
@echo -    Prepare Contrib wxWidgets devpak
@echo -
@echo --------------------------------------------------------------------


rem Write the files to subdirectory setup devpak

cd %STARTDIR%

copy wxWidgets_gcc_contrib.DevPackage %DEVPAKDIR%\wxWidgets_%WXVER%_gcc_contrib.DevPackage

cd %DEVPAKDIR%

%STARTDIR%\gsar -s_WXVER_ -r"%WXVER%" -o wxWidgets_%WXVER%_gcc_contrib.DevPackage

%STARTDIR%\gsar -s_WXWIN_ -r"%WXWIN_GSAR%" -o wxWidgets_%WXVER%_gcc_contrib.DevPackage

rem Copy the wxWidgets libs and include files to the new devpak directory
xcopy /S %WXWIN%\contrib\lib\gcc_lib contrib\gcc_lib\
xcopy /S %WXWIN%\contrib\include contrib\include\
xcopy /S %WXWIN%\contrib\samples contrib\samples\

@echo --------------------------------------------------------------------
@echo -
@echo -    Build 3rd Party wxWidgets Libraries
@echo -
@echo --------------------------------------------------------------------

cd %WXWIN%

md 3rdParty
md 3rdParty\art
copy %WXCODE%\components\wxplotctrl\art\*.xpm %WXWIN%\3rdParty\art\

md 3rdParty\build
md 3rdParty\build\chartart
copy %STARTDIR%\chartart.gcc %WXWIN%\3rdParty\build\chartart\makefile.gcc

md 3rdParty\build\plotctrl
copy %STARTDIR%\plotctrl.gcc %WXWIN%\3rdParty\build\plotctrl\makefile.gcc

md 3rdParty\build\scintilla
copy %STARTDIR%\scintilla.gcc %WXWIN%\3rdParty\build\scintilla\makefile.gcc

md 3rdParty\build\sheet
copy %STARTDIR%\sheet.gcc %WXWIN%\3rdParty\build\sheet\makefile.gcc

md 3rdParty\build\things
copy %STARTDIR%\things.gcc %WXWIN%\3rdParty\build\things\makefile.gcc

md 3rdParty\build\treelistctrl
copy %STARTDIR%\treelistctrl.gcc %WXWIN%\3rdParty\build\treelistctrl\makefile.gcc

md 3rdParty\build\treemultictrl
copy %STARTDIR%\treemultictrl.gcc %WXWIN%\3rdParty\build\treemultictrl\makefile.gcc

md 3rdParty\include
md 3rdParty\include\wx
md 3rdParty\include\wx\chartart
copy %WXCODE%\components\wxchart\build\msw\*.rc %WXWIN%\3rdParty\build\msw\

copy %WXCODE%\components\wxchart\include\wx\*.h %WXWIN%\3rdParty\include\wx\
copy %WXCODE%\components\wxchart\include\wx\chartart\chart*.* %WXWIN%\3rdParty\include\wx\chartart\

md 3rdParty\include\wx\plotctrl
copy %WXCODE%\components\wxplotctrl\include\wx\plotctrl\*.h %WXWIN%\3rdParty\include\wx\plotctrl\

copy %WXCODE%\components\wxscintilla\include\wx\*.h %WXWIN%\3rdParty\include\wx\

md 3rdParty\include\wx\sheet
copy %WXCODE%\components\wxsheet\include\wx\sheet\*.h %WXWIN%\3rdParty\include\wx\sheet\

md 3rdParty\include\wx\things
copy %WXCODE%\components\wxthings\include\wx\things\*.h %WXWIN%\3rdParty\include\wx\things\

copy %WXCODE%\components\treelistctrl\include\wx\*.h %WXWIN%\3rdParty\include\wx\

md 3rdParty\include\wx\treemultictrl
copy %WXCODE%\components\treemultictrl\contrib\include\wx\treemultictrl\*.h %WXWIN%\3rdParty\include\wx\treemultictrl

md 3rdParty\src
md 3rdParty\src\chartart
copy %WXCODE%\components\wxchart\src\*.c* %WXWIN%\3rdParty\src\chartart\
 
md 3rdParty\src\plotctrl
copy %WXCODE%\components\wxplotctrl\src\*.c* %WXWIN%\3rdParty\src\plotctrl\
copy %WXCODE%\components\wxplotctrl\src\*.h* %WXWIN%\3rdParty\src\plotctrl\

md 3rdParty\src\scintilla
md 3rdParty\src\scintilla\include
md 3rdParty\src\scintilla\src
copy %WXCODE%\components\wxscintilla\src\*.c* %WXWIN%\3rdParty\src\
copy %WXCODE%\components\wxscintilla\src\*.h* %WXWIN%\3rdParty\src\
copy %WXCODE%\components\wxscintilla\src\scintilla\include\*.h* %WXWIN%\3rdParty\src\scintilla\include\
copy %WXCODE%\components\wxscintilla\src\scintilla\src\*.c* %WXWIN%\3rdParty\src\scintilla\src\
copy %WXCODE%\components\wxscintilla\src\scintilla\src\*.h* %WXWIN%\3rdParty\src\scintilla\src\

md 3rdParty\src\sheet
copy %WXCODE%\components\wxsheet\src\*.c* %WXWIN%\3rdParty\src\sheet\

md 3rdParty\src\things
copy %WXCODE%\components\wxthings\src\*.c* %WXWIN%\3rdParty\src\things\

md 3rdParty\src\treelistctrl
copy %WXCODE%\components\treelistctrl\src\*.c* %WXWIN%\3rdParty\src\treelistctrl\

md 3rdParty\src\treemultictrl
md 3rdParty\src\treemultictrl\images
copy %WXCODE%\components\treemultictrl\contrib\src\treemultictrl\*.c* %WXWIN%\3rdParty\src\treemultictrl\
copy %WXCODE%\components\treemultictrl\contrib\src\treemultictrl\*.x* %WXWIN%\3rdParty\src\treemultictrl\
copy %WXCODE%\components\treemultictrl\contrib\src\treemultictrl\images\*.p* %WXWIN%\3rdParty\src\treemultictrl\images\


md 3rdParty\samples
md 3rdParty\samples\chartart
copy %WXCODE%\components\wxchart\samples\*.* %WXWIN%\3rdParty\samples\chartart\

md 3rdParty\samples\plotctrl
copy %WXCODE%\components\wxplot\src\demowxplot\*.* %WXWIN%\3rdParty\samples\plotctrl\

md 3rdParty\samples\scintilla
copy %WXCODE%\components\wxscintilla\samples\test\*.* %WXWIN%\3rdParty\samples\scintilla\

md 3rdParty\samples\sheet
copy %WXCODE%\components\wxsheet\samples\sheet\*.* %WXWIN%\3rdParty\samples\sheet\

md 3rdParty\samples\things
md 3rdParty\samples\things\filebrws
md 3rdParty\samples\things\things
copy %WXCODE%\components\wxthings\samples\filebrws\*.* %WXWIN%\3rdParty\samples\things\filebrws\
copy %WXCODE%\components\wxthings\samples\*.* %WXWIN%\3rdParty\samples\things\things\

md 3rdParty\samples\treelisttest
md 3rdParty\samples\treelisttest\bitmaps
copy %WXCODE%\components\treelistctrl\samples\treelisttest\*.c* %WXWIN%\3rdParty\samples\treelisttest\ 
copy %WXCODE%\components\treelistctrl\samples\treelisttest\*.rc* %WXWIN%\3rdParty\samples\treelisttest\ 
copy %WXCODE%\components\treelistctrl\samples\treelisttest\*.ic* %WXWIN%\3rdParty\samples\treelisttest\ 
copy %WXCODE%\components\treelistctrl\samples\treelisttest\*.x* %WXWIN%\3rdParty\samples\treelisttest\bitmaps\ 
copy %WXCODE%\components\treelistctrl\samples\treelisttest\*.b* %WXWIN%\3rdParty\samples\treelisttest\bitmaps\ 

md 3rdParty\samples\treemultictrl
copy %WXCODE%\components\treemultictrl\contrib\src\*.* %WXWIN%\3rdParty\src\treemultictrl\

rem make the folder for 3rd party libraries
md 3rdparty\lib
md 3rdparty\lib\gcc_lib



rem Change the plotctrl files 
rem %STARTDIR%\gsar -sWX_DEFINE_USER_EXPORTED_ARRAY_DOUBLE -r//WX_DEFINE_USER_EXPORTED_ARRAY_DOUBLE -o 3rdparty\include/wx/plotctrl/plotcurv.h

rem Change the things files
rem need to remove the change first if we have already done this once 
%STARTDIR%\gsar -s#define:x20exp10(X):x20pow(10.0,:x20(X)) -r -o 3rdparty\src\things\matrix2d.cpp
rem now do the change
%STARTDIR%\gsar -s#include:x20:x3cmath.h:x3e -r#include:x20:x3cmath.h:x3e:x0d:x0a#define:x20exp10(X):x20pow(10.0,:x20(X)) -o 3rdparty\src\things\matrix2d.cpp

cd 3rdparty\build\chartart
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_chartart.txt 
if errorlevel 1 goto 3RDPARTY_BUILD_ERR

cd ..\plotctrl
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_plotctrl.txt 
if errorlevel 1 goto 3RDPARTY_BUILD_ERR

cd ..\scintilla
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1  2> error_scintilla.txt
if errorlevel 1 goto 3RDPARTY_BUILD_ERR

cd ..\sheet
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_sheet.txt 
if errorlevel 1 goto 3RDPARTY_BUILD_ERR

cd ..\things
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_things.txt 
if errorlevel 1 goto 3RDPARTY_BUILD_ERR

cd ..\treelistctrl
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_treelist.txt 
if errorlevel 1 goto 3RDPARTY_BUILD_ERR

cd ..\treemultictrl
mingw32-make -f makefile.gcc BUILD=release MONOLITHIC=1 USE_OPENGL=1 USE_XRC=1 USE_ODBC=1 RUNTIME_LIBS=static USE_RTTI=0 USE_EXCEPTIONS=1 2> error_treemultictrl.txt 
if errorlevel 1 goto 3RDPARTY_BUILD_ERR

FOR /R %WXWIN%\3rdParty\samples\ %%G IN (makefile.*, *.bkl, *.ds?, *.vc?, *.pro, descrip.mms) DO del %%G

@echo --------------------------------------------------------------------
@echo -
@echo -    Prepare 3rd Party wxWidgets devpak
@echo -
@echo --------------------------------------------------------------------


rem Write the files to subdirectory setup devpak

cd %STARTDIR%

copy wxWidgets_gcc_extras.DevPackage %DEVPAKDIR%\wxWidgets_%WXVER%_gcc_extras.DevPackage

cd %DEVPAKDIR%

%STARTDIR%\gsar -s_WXVER_ -r"%WXVER%" -o wxWidgets_%WXVER%_gcc_extras.DevPackage

%STARTDIR%\gsar -s_WXWIN_ -r"%WXWIN_GSAR%" -o wxWidgets_%WXVER%_gcc_extras.DevPackage

rem Copy the wxWidgets libs and include files to the new devpak directory
xcopy /S %WXWIN%\3rdparty\lib\gcc_lib extras\gcc_lib\
xcopy /S %WXWIN%\3rdParty\include extras\include\
xcopy /S %WXWIN%\3rdParty\samples extras\samples\
copy %WXCODE%\components\wxchart\build\msw\wxchart.rc extras\

:BUILD_OK

FOR /R %WXWIN%\demos\ %%G IN (makefile.*, *.bkl, *.ds?, *.vc?, *.pro, descrip.mms) DO del %%G
FOR /R %WXWIN%\samples\ %%G IN (makefile.*, *.bkl, *.ds?, *.vc?, *.pro, descrip.mms) DO del %%G


rem Write the Sample files to subdirectory setup devpak

cd %STARTDIR%

copy wxWidgets_samples.DevPackage %DEVPAKDIR%\wxWidgets_%WXVER%_samples.DevPackage

cd %DEVPAKDIR%

%STARTDIR%\gsar -s_WXVER_ -r"%WXVER%" -o wxWidgets_%WXVER%_samples.DevPackage

%STARTDIR%\gsar -s_WXWIN_ -r"%WXWIN_GSAR%" -o wxWidgets_%WXVER%_samples.DevPackage

rem Copy the wxWidgets demo and example files to the new devpak directory
xcopy /S %WXWIN%\demos samples\samples\
xcopy /S %WXWIN%\samples samples\samples\
xcopy /S %WXWIN%\src\generic samples\samples\generic\
xcopy /S %WXWIN%\art samples\art\

FOR /R %DEVPAKDIR% %%G IN (*.bak) DO del %%G

@echo wxWidgets build completed successfully

rem restore current directory
chdir /d %STARTDIR%

goto EXIT



:BASE_BUILD_ERR
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
@echo X
@echo      Base wxWidgets build failed
@echo X
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
goto ERROR_EXIT

:CONTRIB_BUILD_ERR
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
@echo X
@echo      Contrib wxWidgets build failed
@echo X
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
goto ERROR_EXIT

:3RDPARTY_BUILD_ERR
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
@echo X
@echo      3rd Party wxWidgets build failed
@echo X
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
goto ERROR_EXIT

:EXIT
rem restore current directory
chdir /d %STARTDIR%
call copydev
:ERROR_EXIT


pause
