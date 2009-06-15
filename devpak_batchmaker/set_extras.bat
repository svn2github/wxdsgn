cd /d %STARTDIR%

copy wxWidgets_%1_extras.DevPackage %DEVPAKDIR%\wxWidgets_%1_extras.DevPackage

cd /d %DEVPAKDIR%

%STARTDIR%\gsar -s_WXVER_ -r"%WXVER%" -o wxWidgets_%1_extras.DevPackage
%STARTDIR%\gsar -s_WXWIN_ -r"%WXWIN_GSAR%" -o wxWidgets_%1_extras.DevPackage
IF "%1"=="vc"  %STARTDIR%\gsar -s_VC_VER_ -r"%VC_VER%" -o wxWidgets_%1_extras.DevPackage

md extras
md extras\%1_lib

rem Copy the wxWidgets libs and include files to the new devpak directory
xcopy %WXWIN%\3rdparty\lib\%1_lib extras\%1_lib\ /e /Y /Q

