rem This contains all of the common variables used in all batch files

echo off
cls

rem Default wxWidgets root directory
set WXVER=2.7.2

echo What version of wxWidgets are you building (Default = %WXVER%)?
set /P WXVER=

set WXWIN=\wxMSW-%WXVER%

echo In what directory is wxWidgets located (Default = %WXWIN%)?
set /P WXWIN=


rem The path needs to point to where your mingw32-make executable lives
path=c:\Progra~1\Dev-Cpp\bin;%path%

echo on


