CALL common_vars.bat

cd /d %STARTDIR%

rem remove a previously built devpak dir

rd /S /Q %DEVPAKDIR%



SET BUILDRESULT=P

@echo --------------------------------------------------------------------
@echo -
@echo -    Build Base wxWidgets Libraries
@echo -
@echo --------------------------------------------------------------------


rem Copy the setup.h up one level
del %WXWIN%\include\wx\setup.h
cd /d %WXWIN%\include\wx\msw
%STARTDIR%\gsar -s#define:x20wxUSE_GLCANVAS:x20:x20:x20:x20:x20:x20:x200 -r#define:x20wxUSE_GLCANVAS:x20:x20:x20:x20:x20:x20:x201 -o setup.h
%STARTDIR%\gsar -s#define:x20wxUSE_ODBC:x20:x20:x20:x20:x20:x20:x20:x20:x20:x200 -r#define:x20wxUSE_ODBC:x20:x20:x20:x20:x20:x20:x20:x20:x20:x201 -o setup.h
%STARTDIR%\gsar -s#define:x20wxUSE_DATEPICKCTRL_GENERIC:x200 -r#define:x20wxUSE_DATEPICKCTRL_GENERIC:x201 -o setup.h
copy setup.h ..\setup.h

rem If we don't build the libraries, we still copy the Include files 
IF NOT "%BUILDBASE%"=="Y" GOTO BASE_COMMON

cd /d %WXWIN%

rem build the main distribution of wxWidgets
cd build\msw

IF NOT "%BUILDGCC%"=="Y" GOTO VC_BASE_BUILD

echo Building gcc...
CALL %STARTDIR%\wxWidgets_base.bat gcc

IF NOT "%BUILDRESULT%"=="P" GOTO GCC_BASE_BUILD_ERR

:VC_BASE_BUILD
echo Building vc...
IF NOT "%BUILDVC%"=="Y" GOTO DMC_BASE_BUILD

CALL %STARTDIR%\wxWidgets_base.bat vc
IF NOT "%BUILDRESULT%"=="P" GOTO VC_BASE_BUILD_ERR


:DMC_BASE_BUILD
echo Building DMC...
IF NOT "%BUILDDMC%"=="Y" GOTO BCC_BASE_BUILD

CALL %STARTDIR%\wxWidgets_base.bat dmc
IF NOT "%BUILDRESULT%"=="P" GOTO DMC_BASE_BUILD_ERR


:BCC_BASE_BUILD
IF NOT "%BUILDBCC%"=="Y" GOTO BASE_DEVPAK

echo Building bcc...
CALL %STARTDIR%\wxWidgets_base.bat bcc
IF NOT "%BUILDRESULT%"=="P" GOTO BCC_BASE_BUILD_ERR


:BASE_DEVPAK
@echo --------------------------------------------------------------------
@echo - 
@echo -    Prepare Base wxWidgets devpak
@echo -
@echo --------------------------------------------------------------------


cd /d %STARTDIR%
md %DEVPAKDIR%

IF NOT "%BUILDGCC%"=="Y" GOTO VC_BASE_DEVPAK
call %STARTDIR%\set_base gcc

:VC_BASE_DEVPAK
IF NOT "%BUILDVC%"=="Y" GOTO DMC_BASE_DEVPAK
call %STARTDIR%\set_base vc

:DMC_BASE_DEVPAK
IF NOT "%BUILDDMC%"=="Y" GOTO BCC_BASE_DEVPAK
call %STARTDIR%\set_base dmc

:BCC_BASE_DEVPAK
IF NOT "%BUILDBCC%"=="Y" GOTO BASE_COMMON
call %STARTDIR%\set_base bcc


:BASE_COMMON
echo basecommon

cd /d %STARTDIR%

IF NOT EXIST %DEVPAKDIR% md %DEVPAKDIR%
md %DEVPAKDIR%\docs
copy /Y %WXWIN%\docs\licence.txt %DEVPAKDIR%\docs\
copy /Y %WXWIN%\docs\readme.txt %DEVPAKDIR%\docs\

copy wxWidgets_common.DevPackage %DEVPAKDIR%\wxWidgets_common.DevPackage

cd /d %devpakdir%
%STARTDIR%\gsar -s_WXVER_ -r"%WXVER%" -o wxWidgets_common.DevPackage
%STARTDIR%\gsar -s_WXWIN_ -r"%WXWIN_GSAR%" -o wxWidgets_common.DevPackage

md common
md common\include
md common\include\msvc
md common\include\msvc\wx
md common\include\wx
md common\include\wx\aui
md common\include\wx\common
md common\include\wx\generic
md common\include\wx\html
md common\include\wx\msdos
md common\include\wx\msw
md common\include\wx\msw\ole
md common\include\wx\msw\wince
md common\include\wx\private
md common\include\wx\protocol
md common\include\wx\richtext
md common\include\wx\univ
md common\include\wx\unix
md common\include\wx\xml
md common\include\wx\xrc

cd /d %DEVPAKDIR%\common\include
copy /Y %WXWIN%\include\*.*

cd %DEVPAKDIR%\common\include\msvc
copy /Y %WXWIN%\include\msvc\*.*

cd %DEVPAKDIR%\common\include\msvc\wx
copy /Y %WXWIN%\include\msvc\wx\*.*

cd %DEVPAKDIR%\common\include\wx
copy /Y %WXWIN%\include\wx\*.*

cd %DEVPAKDIR%\common\include\wx\aui
copy /Y %WXWIN%\include\wx\aui\*.*

cd %DEVPAKDIR%\common\include\wx\common
copy /Y %WXWIN%\include\wx\common\*.*

cd %DEVPAKDIR%\common\include\wx\generic
copy /Y %WXWIN%\include\wx\generic\*.*

cd %DEVPAKDIR%\common\include\wx\html
copy /Y %WXWIN%\include\wx\html\*.*

cd %DEVPAKDIR%\common\include\wx\msdos
copy /Y %WXWIN%\include\wx\msdos\*.*

cd %DEVPAKDIR%\common\include\wx\msw
copy /Y %WXWIN%\include\wx\msw\*.*

cd %DEVPAKDIR%\common\include\wx\msw\ole
copy /Y %WXWIN%\include\wx\msw\ole\*.*

cd %DEVPAKDIR%\common\include\wx\msw\wince
copy /Y %WXWIN%\include\wx\msw\wince\*.*

cd %DEVPAKDIR%\common\include\wx\private
copy /Y %WXWIN%\include\wx\private\*.*

cd %DEVPAKDIR%\common\include\wx\protocol
copy /Y %WXWIN%\include\wx\protocol\*.*

cd %DEVPAKDIR%\common\include\wx\richtext
copy /Y %WXWIN%\include\wx\richtext\*.*

cd %DEVPAKDIR%\common\include\wx\univ
copy /Y %WXWIN%\include\wx\univ\*.*

cd %DEVPAKDIR%\common\include\wx\unix
copy /Y %WXWIN%\include\wx\unix\*.*

cd %DEVPAKDIR%\common\include\wx\xml
copy /Y %WXWIN%\include\wx\xml\*.*

cd %DEVPAKDIR%\common\include\wx\xrc
copy /Y %WXWIN%\include\wx\xrc\*.*

cd /d %STARTDIR%
md %DEVPAKDIR%\common\Templates
md %DEVPAKDIR%\common\Templates\wxWidgets
copy ..\Templates\*wx*.* %DEVPAKDIR%\common\Templates\
copy ..\Templates\wxWidgets\wx*.* %DEVPAKDIR%\common\Templates\wxWidgets\


@echo --------------------------------------------------------------------
@echo -
@echo -    Build Contrib wxWidgets Libraries
@echo -
@echo --------------------------------------------------------------------


IF NOT "%BUILDCONTRIB%"=="Y" GOTO COMMON_CONTRIB_DEVPAK


cd /d %WXWIN%

IF NOT "%BUILDGCC%"=="Y" GOTO VCMAKESCONT

CALL %STARTDIR%\wxWidgets_contrib.bat gcc
IF NOT "%BUILDRESULT%"=="P" GOTO GCC_CONTRIB_BUILD_ERR


:VCMAKESCONT
IF NOT "%BUILDVC%"=="Y" GOTO DMCMAKESCONT

CALL %STARTDIR%\wxWidgets_contrib.bat vc
IF NOT "%BUILDRESULT%"=="P" GOTO VC_CONTRIB_BUILD_ERR


:DMCMAKESCONT
IF NOT "%BUILDDMC%"=="Y" GOTO BCCMAKESCONT

CALL %STARTDIR%\wxWidgets_contrib.bat dmc
IF NOT "%BUILDRESULT%"=="P" GOTO DMC_CONTRIB_BUILD_ERR


:BCCMAKESCONT
IF NOT "%BUILDBCC%"=="Y" GOTO CONTDEP

CALL %STARTDIR%\wxWidgets_contrib.bat bcc
IF NOT "%BUILDRESULT%"=="P" GOTO BCC_CONTRIB_BUILD_ERR

:CONTDEP

@echo --------------------------------------------------------------------
@echo -
@echo -    Prepare Contrib wxWidgets devpak
@echo -
@echo --------------------------------------------------------------------


rem Write the files to subdirectory setup devpak

IF NOT "%BUILDGCC%"=="Y" GOTO VC_CONT_DEVPAK
call %STARTDIR%\set_contribs gcc

:VC_CONT_DEVPAK
IF NOT "%BUILDVC%"=="Y" GOTO DMC_CONT_DEVPAK
call %STARTDIR%\set_contribs vc

:DMC_CONT_DEVPAK
IF NOT "%BUILDDMC%"=="Y" GOTO BCC_CONT_DEVPAK
call %STARTDIR%\set_contribs dmc

:BCC_CONT_DEVPAK
IF NOT "%BUILDBCC%"=="Y" GOTO COMMON_CONTRIB_DEVPAK
call %STARTDIR%\set_contribs bcc

:COMMON_CONTRIB_DEVPAK

FOR /R %WXWIN%\contrib\samples %%G IN (makefile.*, *.bkl, *.ds?, *.vc?, *.pro, descrip.mms) DO del %%G


cd /d %STARTDIR%
copy wxWidgets_contrib_common.DevPackage %DEVPAKDIR%\wxWidgets_contrib_common.DevPackage

cd /d %DEVPAKDIR%

%STARTDIR%\gsar -s_WXVER_ -r"%WXVER%" -o wxWidgets_contrib_common.DevPackage
%STARTDIR%\gsar -s_WXWIN_ -r"%WXWIN_GSAR%" -o wxWidgets_contrib_common.DevPackage

IF NOT EXIST %DEVPAKDIR%\contrib md %DEVPAKDIR%\contrib
IF NOT EXIST %DEVPAKDIR%\contrib\include md %DEVPAKDIR%\contrib\include
IF NOT EXIST %DEVPAKDIR%\contrib\samples md %DEVPAKDIR%\contrib\samples

xcopy %WXWIN%\contrib\include contrib\include\ /e /Y /Q
xcopy %WXWIN%\contrib\samples contrib\samples\ /e /Y /Q


@echo --------------------------------------------------------------------
@echo -
@echo -    Build 3rd Party wxWidgets Libraries
@echo -
@echo --------------------------------------------------------------------
:BUILD3RDPARTY
cd /d %WXWIN%

md 3rdParty\art
copy %WXCODE%\wxplotctrl\art\*.xpm %WXWIN%\3rdParty\art\



md 3rdParty\build\chartart
md 3rdParty\build\plotctrl
md 3rdParty\build\scintilla
md 3rdParty\build\sheet
md 3rdParty\build\things
md 3rdParty\build\treelistctrl
md 3rdParty\build\treemultictrl

md 3rdParty\include
md 3rdParty\include\wx
md 3rdParty\include\wx\chartart
rem copy %WXCODE%\wxchart\build\msw\*.rc %WXWIN%\3rdParty\build\msw\

copy %WXCODE%\wxchart\include\wx\*.h %WXWIN%\3rdParty\include\wx\
copy %WXCODE%\wxchart\include\wx\chartart\*.* %WXWIN%\3rdParty\include\wx\chartart\

md 3rdParty\include\wx\plotctrl
copy %WXCODE%\wxplotctrl\include\wx\plotctrl\*.h %WXWIN%\3rdParty\include\wx\plotctrl\

copy %WXCODE%\wxscintilla\include\wx\*.h %WXWIN%\3rdParty\include\wx\

md 3rdParty\include\wx\sheet
copy %WXCODE%\wxsheet\include\wx\sheet\*.h %WXWIN%\3rdParty\include\wx\sheet\

md 3rdParty\include\wx\things
copy %WXCODE%\wxthings\include\wx\things\*.h %WXWIN%\3rdParty\include\wx\things\

copy %WXCODE%\treelistctrl\include\wx\*.h %WXWIN%\3rdParty\include\wx\

md 3rdParty\include\wx\treemultictrl
copy %WXCODE%\treemultictrl\contrib\include\wx\treemultictrl\*.h %WXWIN%\3rdParty\include\wx\treemultictrl

md 3rdParty\src
md 3rdParty\src\chartart
copy %WXCODE%\wxchart\src\*.c* %WXWIN%\3rdParty\src\chartart\
 
md 3rdParty\src\plotctrl
copy %WXCODE%\wxplotctrl\src\*.c* %WXWIN%\3rdParty\src\plotctrl\
copy %WXCODE%\wxplotctrl\src\*.h* %WXWIN%\3rdParty\src\plotctrl\

md 3rdParty\src\scintilla
md 3rdParty\src\scintilla\include
md 3rdParty\src\scintilla\src
copy %WXCODE%\wxscintilla\src\*.c* %WXWIN%\3rdParty\src\
copy %WXCODE%\wxscintilla\src\*.h* %WXWIN%\3rdParty\src\
copy %WXCODE%\wxscintilla\src\scintilla\include\*.h* %WXWIN%\3rdParty\src\scintilla\include\
copy %WXCODE%\wxscintilla\src\scintilla\src\*.c* %WXWIN%\3rdParty\src\scintilla\src\
copy %WXCODE%\wxscintilla\src\scintilla\src\*.h* %WXWIN%\3rdParty\src\scintilla\src\

md 3rdParty\src\sheet
copy %WXCODE%\wxsheet\src\*.c* %WXWIN%\3rdParty\src\sheet\

md 3rdParty\src\things
copy %WXCODE%\wxthings\src\*.c* %WXWIN%\3rdParty\src\things\

md 3rdParty\src\treelistctrl
copy %WXCODE%\treelistctrl\src\*.c* %WXWIN%\3rdParty\src\treelistctrl\

md 3rdParty\src\treemultictrl
md 3rdParty\src\treemultictrl\images
copy %WXCODE%\treemultictrl\contrib\src\treemultictrl\*.c* %WXWIN%\3rdParty\src\treemultictrl\
copy %WXCODE%\treemultictrl\contrib\src\treemultictrl\*.x* %WXWIN%\3rdParty\src\treemultictrl\
copy %WXCODE%\treemultictrl\contrib\src\treemultictrl\images\*.p* %WXWIN%\3rdParty\src\treemultictrl\images\


md 3rdParty\samples
md 3rdParty\samples\chartart
copy %WXCODE%\wxchart\samples\*.* %WXWIN%\3rdParty\samples\chartart\

md 3rdParty\samples\plotctrl
copy %WXCODE%\wxplotctrl\samples\plotctrl\wx*.* %WXWIN%\3rdParty\samples\plotctrl\

md 3rdParty\samples\scintilla
copy %WXCODE%\wxscintilla\samples\test\*.* %WXWIN%\3rdParty\samples\scintilla\

md 3rdParty\samples\sheet
copy %WXCODE%\wxsheet\samples\sheet\*.* %WXWIN%\3rdParty\samples\sheet\

md 3rdParty\samples\things
md 3rdParty\samples\things\filebrws
md 3rdParty\samples\things\things
copy %WXCODE%\wxthings\samples\filebrws\file*.* %WXWIN%\3rdParty\samples\things\filebrws\
copy %WXCODE%\wxthings\samples\filebrws\wxfile*.* %WXWIN%\3rdParty\samples\things\filebrws\
copy %WXCODE%\wxthings\samples\things\things*.* %WXWIN%\3rdParty\samples\things\things\

md 3rdParty\samples\treelisttest
md 3rdParty\samples\treelisttest\bitmaps
copy %WXCODE%\treelistctrl\samples\treelisttest\*.c* %WXWIN%\3rdParty\samples\treelisttest\ 
copy %WXCODE%\treelistctrl\samples\treelisttest\*.rc* %WXWIN%\3rdParty\samples\treelisttest\ 
copy %WXCODE%\treelistctrl\samples\treelisttest\*.ic* %WXWIN%\3rdParty\samples\treelisttest\ 
copy %WXCODE%\treelistctrl\samples\treelisttest\bitmaps\*.x* %WXWIN%\3rdParty\samples\treelisttest\bitmaps\ 
copy %WXCODE%\treelistctrl\samples\treelisttest\bitmaps\*.b* %WXWIN%\3rdParty\samples\treelisttest\bitmaps\ 

md 3rdParty\samples\treemultictrl
copy %WXCODE%\treemultictrl\contrib\samples\treemultictrl\*.* %WXWIN%\3rdParty\src\treemultictrl\


cd /d %WXWIN%
rem change unix line endings to windows/dos line endings
rem for /R ""%%G in (*.cpp *.h *.c) do %STARTDIR%\gsar -ud -o %%G


rem Change the plotctrl files 
%STARTDIR%\gsar -sWX_DEFINE_USER_EXPORTED_ARRAY_DOUBLE -r//WX_DEFINE_USER_EXPORTED_ARRAY_DOUBLE -o 3rdparty\include/wx/plotctrl/plotcurv.h
%STARTDIR%\gsar -s#include:x20:x22wx/bitmap -r#include:x20:x22wx/window.h:x22:x0d:x0a#include:x20:x22wx/bitmap -o 3rdparty\include/wx/plotctrl/plotctrl.h

rem Change the sheet files
%STARTDIR%\gsar -sdcscreen:x2eh:x22:x0a#endif -rdcscreen:x2eh:x22:x0a#include:x20:x22wx/combobox:x2eh:x22:x0d:x0a#endif -o 3rdparty\src/sheet/sheet.cpp
%STARTDIR%\gsar -sWX_DELEGATE_TO_CONTROL_CONTAINER(wxSheetSplitter) -rWX_DELEGATE_TO_CONTROL_CONTAINER(wxSheetSplitter,:x20wxWindow) -o 3rdparty\src/sheet/sheetspt.cpp

rem Change the things files
rem need to remove the change first if we have already done this once 
rem %STARTDIR%\gsar -s#define:x20exp10(X):x20pow(10.0,:x20(X)) -r -o 3rdparty\src\things\matrix2d.cpp
rem now do the change
rem %STARTDIR%\gsar -s#include:x20:x3cmath.h:x3e -r#include:x20:x3cmath.h:x3e:x0d:x0a#define:x20exp10(X):x20pow(10.0,:x20(X)) -o 3rdparty\src\things\matrix2d.cpp
%STARTDIR%\gsar -s#include:x20:x3cmath.h:x3e -r#include:x20:x3cmath.h:x3e:x0d:x0a#define:x20exp10(X):x20pow(10.0,:x20(X)) -o 3rdparty\src\things\matrix2d.cpp

rem Change the treelistctrl files
%STARTDIR%\gsar -sscrolwin.h:x3e:x0a -rscrolwin.h:x3e:x0a#include:x20:x3cwx/dcmemory.h:x3e -o 3rdparty\src\treelistctrl\treelistctrl.cpp

FOR /R %WXWIN%\3rdParty\samples\ %%G IN (makefile.*, *.bkl, *.ds?, *.vc?, *.pro, descrip.mms) DO del %%G

rem make the folder for 3rd party libraries
md 3rdparty\lib

cd /d %WXWIN%
IF NOT "%BUILDGCC%"=="Y" GOTO VCMAKE3rdp

CALL %STARTDIR%\wxWidgets_3rdparty.bat gcc
IF NOT "%BUILDRESULT%"=="P" GOTO GCC_3RDPARTY_BUILD_ERR

:VCMAKE3rdp
IF NOT "%BUILDVC%"=="Y" GOTO DMCMAKE3rdp
CALL %STARTDIR%\wxWidgets_3rdparty.bat vc
IF NOT "%BUILDRESULT%"=="P" GOTO VC_3RDPARTY_BUILD_ERR


:DMCMAKE3rdp
IF NOT "%BUILDDMC%"=="Y" GOTO BCCMAKE3rdp
CALL %STARTDIR%\wxWidgets_3rdparty.bat dmc
IF NOT "%BUILDRESULT%"=="P" GOTO DMC_3RDPARTY_BUILD_ERR


:BCCMAKE3rdp
IF NOT "%BUILDBCC%"=="Y" GOTO 3rdpDEP
CALL %STARTDIR%\wxWidgets_3rdparty.bat bcc
IF NOT "%BUILDRESULT%"=="P" GOTO BCC_3RDPARTY_BUILD_ERR


:3rdpDEP

@echo --------------------------------------------------------------------
@echo -
@echo -    Prepare 3rd Party wxWidgets devpak
@echo -
@echo --------------------------------------------------------------------


rem Write the files to subdirectory setup devpak

IF NOT "%BUILDGCC%"=="Y" GOTO VC_EXT_DEVPAK
call %STARTDIR%\set_extras gcc

:VC_EXT_DEVPAK
IF NOT "%BUILDVC%"=="Y" GOTO DMC_EXT_DEVPAK
call %STARTDIR%\set_extras vc

:DMC_EXT_DEVPAK
IF NOT "%BUILDDMC%"=="Y" GOTO BCC_EXT_DEVPAK
call %STARTDIR%\set_extras dmc

:BCC_EXT_DEVPAK
IF NOT "%BUILDBCC%"=="Y" GOTO EXT_COMMON
call %STARTDIR%\set_extras bcc


:EXT_COMMON
cd /d %STARTDIR%
copy wxWidgets_extras_common.DevPackage %DEVPAKDIR%\wxWidgets_extras_common.DevPackage

cd /d %DEVPAKDIR%
%STARTDIR%\gsar -s_WXVER_ -r"%WXVER%" -o wxWidgets_extras_common.DevPackage
%STARTDIR%\gsar -s_WXWIN_ -r"%WXWIN_GSAR%" -o wxWidgets_extras_common.DevPackage

xcopy %WXWIN%\3rdParty\include extras\include\ /e /Y /Q
xcopy %WXWIN%\3rdParty\samples extras\samples\ /e /Y /Q
copy %WXCODE%\wxchart\build\msw\wxchart.rc extras\


:BUILD_OK
FOR /R %WXWIN%\demos\ %%G IN (makefile.*, *.bkl, *.ds?, *.vc?, *.pro, descrip.mms) DO del %%G
FOR /R %WXWIN%\samples\ %%G IN (makefile.*, *.bkl, *.ds?, *.vc?, *.pro, descrip.mms) DO del %%G


rem Write the Sample files to subdirectory setup devpak

cd /d %STARTDIR%

copy wxWidgets_samples.DevPackage %DEVPAKDIR%\wxWidgets_samples.DevPackage

cd /d %DEVPAKDIR%

%STARTDIR%\gsar -s_WXVER_ -r"%WXVER%" -o wxWidgets_samples.DevPackage

%STARTDIR%\gsar -s_WXWIN_ -r"%WXWIN_GSAR%" -o wxWidgets_samples.DevPackage

md samples
md samples\samples
md samples\samples\generic

rem Copy the wxWidgets demo and example files to the new devpak directory
xcopy %WXWIN%\demos samples\samples\ /e /Y /Q
xcopy %WXWIN%\samples samples\samples\ /e /Y /Q
xcopy %WXWIN%\src\generic samples\samples\generic\ /e /Y /Q
xcopy %WXWIN%\art samples\art\ /e /Y /Q

FOR /R %DEVPAKDIR% %%G IN (*.bak) DO del %%G

@echo wxWidgets build completed successfully

rem restore current directory
chdir /d %STARTDIR%

goto EXIT

:GCC_BASE_BUILD_ERR
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
@echo X
@echo      GCC
@echo X
@echo      Base wxWidgets build failed
@echo X
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
goto ERROR_EXIT

:VC_BASE_BUILD_ERR
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
@echo X
@echo      Visual C++
@echo X
@echo      Base wxWidgets build failed
@echo X
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
goto ERROR_EXIT

:DMC_BASE_BUILD_ERR
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
@echo X
@echo      Digital Mars
@echo X
@echo      Base wxWidgets build failed
@echo X
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
goto ERROR_EXIT

:BCC_BASE_BUILD_ERR
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
@echo X
@echo      Borland
@echo X
@echo      Base wxWidgets build failed
@echo X
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
goto ERROR_EXIT

:GCC_CONTRIB_BUILD_ERR
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
@echo X
@echo      GCC
@echo X
@echo      Contrib wxWidgets build failed
@echo X
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
goto ERROR_EXIT

:VC_CONTRIB_BUILD_ERR
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
@echo X
@echo      Visual C++
@echo X
@echo      Contrib wxWidgets build failed
@echo X
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
goto ERROR_EXIT

:DMC_CONTRIB_BUILD_ERR
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
@echo X
@echo      Digital Mars
@echo X
@echo      Contrib wxWidgets build failed
@echo X
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
goto ERROR_EXIT

:BCC_CONTRIB_BUILD_ERR
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
@echo X
@echo      Borland
@echo X
@echo      Contrib wxWidgets build failed
@echo X
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
goto ERROR_EXIT

:GCC_3RDPARTY_BUILD_ERR
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
@echo X
@echo      GCC
@echo X
@echo      3rd Party wxWidgets build failed
@echo X
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
goto ERROR_EXIT

:VC_3RDPARTY_BUILD_ERR
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
@echo X
@echo      Visual C++
@echo X
@echo      3rd Party wxWidgets build failed
@echo X
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
goto ERROR_EXIT

:DMC_3RDPARTY_BUILD_ERR
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
@echo X
@echo      Digital Mars
@echo X
@echo      3rd Party wxWidgets build failed
@echo X
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
goto ERROR_EXIT

:BCC_3RDPARTY_BUILD_ERR
@echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
@echo X
@echo      Borland
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
