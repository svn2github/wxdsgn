cd /d %STARTDIR%

copy wxWidgets_%1.DevPackage %DEVPAKDIR%\wxWidgets_%1.DevPackage

cd /d %DEVPAKDIR%

%STARTDIR%\gsar -s_WXVER_ -r"%WXVER%" -o wxWidgets_%1.DevPackage
%STARTDIR%\gsar -s_WXWIN_ -r"%WXWIN_GSAR%" -o wxWidgets_%1.DevPackage
IF "%1"=="vc" %STARTDIR%\gsar -s_VC_VER_ -r"%VC_VER%" -o wxWidgets_%1.DevPackage

md %1
md %1\%1_lib

rem Copy the wxWidgets libs and include files to the new devpak directory
xcopy %WXWIN%\lib\%1_lib %1\%1_lib\ /e /Y /Q

