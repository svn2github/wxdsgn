; $Id$
; this file was automatically created after full installation
; on Linux by running the following commands:
;
/* cd Dev-Cpp/ && \
 find -type f -exec echo "  Delete {} " \; | \
sed -e "s/\"\./\"\$INSTDIR/"" | \
grep -v "CVS" | \
 todos \
 >>../installed_files.txt
find -type d -exec echo "  RMDir  {}" \; | \
  sed -e "s/\"\./\"\$INSTDIR/"" | \
 grep -v "CVS" | \
 sort -r -f  \
 >>../installed_files.txt
 */
;
;--------------------------------------------

!ifdef HAVE_MINGW 

;ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\binutils.entry" /version "2.15.91-20040904-1"'  // You can specify the version to uninstall if necessary
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\binutils.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\gcc-core.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\gcc-g++.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\gdb.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\make.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\mingw-runtime.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\w32api.entry"'
  
   ; Added for wx-devcpp  -- START
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\${wxWidgetsContrib}"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\${wxWidgets}"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\${wxWidgetsSamples}"'
  ;ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\libpng.entry"'
  ;ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\libtiff.entry"'
  ;ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\libjpeg.entry"'
  ;ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\zlib.entry"'
  ; Added for wx-devcpp  -- END

!endif

  Delete "$INSTDIR\Examples\FileEditor\FileEditor.dev"
  Delete "$INSTDIR\Examples\FileEditor\FileEditor.ico"
  Delete "$INSTDIR\Examples\FileEditor\FileEditor.rc"
  Delete "$INSTDIR\Examples\FileEditor\Main.c"
  Delete "$INSTDIR\Examples\FileEditor\Main.h"
  Delete "$INSTDIR\Examples\FileEditor\Menu.rc"
  Delete "$INSTDIR\Examples\Hello\Hello.cpp"
  Delete "$INSTDIR\Examples\Hello\Hello.dev"
  Delete "$INSTDIR\Examples\Jackpot\Jackpot.dev"
  Delete "$INSTDIR\Examples\Jackpot\main.cpp"
  Delete "$INSTDIR\Examples\MDIApp\MdiApp.dev"
  Delete "$INSTDIR\Examples\MDIApp\MdiApp.rc"
  Delete "$INSTDIR\Examples\MDIApp\mdi_res.rc"
  Delete "$INSTDIR\Examples\MDIApp\mdi_unit.c"
  Delete "$INSTDIR\Examples\MDIApp\mdi_unit.h"
  Delete "$INSTDIR\Examples\OpenGL\Main.cpp"
  Delete "$INSTDIR\Examples\OpenGL\OpenGL.dev"
  Delete "$INSTDIR\Examples\OpenGL\mainicon.ico"
  Delete "$INSTDIR\Examples\Simpwin\Main.cpp"
  Delete "$INSTDIR\Examples\Simpwin\Simple.dev"
  Delete "$INSTDIR\Examples\Simpwin\Simple.ico"
  Delete "$INSTDIR\Examples\Simpwin\Simple.rc"
  Delete "$INSTDIR\Examples\WinAnim\Anim.dev"
  Delete "$INSTDIR\Examples\WinAnim\Anim.ico"
  Delete "$INSTDIR\Examples\WinAnim\Anim.rc"
  Delete "$INSTDIR\Examples\WinAnim\Images.rc"
  Delete "$INSTDIR\Examples\WinAnim\Main.c"
  Delete "$INSTDIR\Examples\WinAnim\ball.bmp"
  Delete "$INSTDIR\Examples\WinAnim\ballmask.bmp"
  Delete "$INSTDIR\Examples\WinMenu\Rsrc.rc"
  Delete "$INSTDIR\Examples\WinMenu\WinMenu.dev"
  Delete "$INSTDIR\Examples\WinMenu\main.cpp"
  Delete "$INSTDIR\Examples\WinMenu\main.h"
  Delete "$INSTDIR\Examples\WinTest\Test.c"
  Delete "$INSTDIR\Examples\WinTest\WinTest.dev"
  Delete "$INSTDIR\Examples\WinTest\WinTest.ico"
  Delete "$INSTDIR\Examples\WinTest\WinTest.rc"
  Delete "$INSTDIR\Help\devcpp.cnt"
  Delete "$INSTDIR\Help\devcpp.hlp"
  
  ; Added for wx-devcpp  -- START
  Delete "$INSTDIR\Help\wx.hlp"
  Delete "$INSTDIR\Help\wx.chm"
  Delete "$INSTDIR\Help\wx.cnt"
  Delete "$INSTDIR\Help\wx.gid"
  Delete "$INSTDIR\Help\devhelp.ini"
  Delete "$INSTDIR\Help\wx-devcpp Tutorial Help.chm"
  ; Added for wx-devcpp  -- END
  
  Delete "$INSTDIR\Icons\Book.ico"
  Delete "$INSTDIR\Icons\Communication.ico"
  Delete "$INSTDIR\Icons\Console.ico"
  Delete "$INSTDIR\Icons\Crazy.ico"
  Delete "$INSTDIR\Icons\Danger.ico"
  Delete "$INSTDIR\Icons\Documentation.ico"
  Delete "$INSTDIR\Icons\Edit.ico"
  Delete "$INSTDIR\Icons\Editor.ico"
  Delete "$INSTDIR\Icons\File Management.ico"
  Delete "$INSTDIR\Icons\Folder.ico"
  Delete "$INSTDIR\Icons\Food.ico"
  Delete "$INSTDIR\Icons\Games.ico"
  Delete "$INSTDIR\Icons\Goofy.ico"
  Delete "$INSTDIR\Icons\Movie.ico"
  Delete "$INSTDIR\Icons\Multimedia.ico"
  Delete "$INSTDIR\Icons\Paint.ico"
  Delete "$INSTDIR\Icons\Rescue.ico"
  Delete "$INSTDIR\Icons\Smile.ico"
  Delete "$INSTDIR\Icons\Software.ico"
  Delete "$INSTDIR\Icons\Ufo.ico"
  Delete "$INSTDIR\Icons\Window.ico"
  Delete "$INSTDIR\Icons\mainicon.ico"
  Delete "$INSTDIR\Lang\Arabic.lng"
  Delete "$INSTDIR\Lang\Arabic.tips"
  Delete "$INSTDIR\Lang\Belarussian.lng"
  Delete "$INSTDIR\Lang\Belarussian.tips"
  Delete "$INSTDIR\Lang\Bulgarian.lng"
  Delete "$INSTDIR\Lang\Catalan.lng"
  Delete "$INSTDIR\Lang\Catalan.tips"
  Delete "$INSTDIR\Lang\Chinese.lng"
  Delete "$INSTDIR\Lang\Chinese_TC.lng"
  Delete "$INSTDIR\Lang\Croatian.lng"
  Delete "$INSTDIR\Lang\Czech.lng"
  Delete "$INSTDIR\Lang\Czech.tips"
  Delete "$INSTDIR\Lang\Danish.lng"
  Delete "$INSTDIR\Lang\Danish.tips"
  Delete "$INSTDIR\Lang\Dutch.lng"
  Delete "$INSTDIR\Lang\Dutch.tips"
  Delete "$INSTDIR\Lang\English.lng"
  Delete "$INSTDIR\Lang\English.tips"
  Delete "$INSTDIR\Lang\English_UK.lng"
  Delete "$INSTDIR\Lang\English_UK.tips"
  Delete "$INSTDIR\Lang\Euskera.lng"
  Delete "$INSTDIR\Lang\Euskera.tips"
  Delete "$INSTDIR\Lang\Estonian.lng"
  Delete "$INSTDIR\Lang\Estonian.tips"
  Delete "$INSTDIR\Lang\French.lng"
  Delete "$INSTDIR\Lang\French.tips"
  Delete "$INSTDIR\Lang\Galego.lng"
  Delete "$INSTDIR\Lang\Galego.tips"
  Delete "$INSTDIR\Lang\German.lng"
  Delete "$INSTDIR\Lang\German.tips"
  Delete "$INSTDIR\Lang\Greek.lng"
  Delete "$INSTDIR\Lang\Hebrew.lng"
  Delete "$INSTDIR\Lang\Hebrew.tips"
  Delete "$INSTDIR\Lang\Hungarian.lng"
  Delete "$INSTDIR\Lang\Hungarian.tips"
  Delete "$INSTDIR\Lang\Italian.lng"
  Delete "$INSTDIR\Lang\Italian.tips"
  Delete "$INSTDIR\Lang\Korean.lng"
  Delete "$INSTDIR\Lang\Korean.tips"
  Delete "$INSTDIR\Lang\Latvian.lng"
  Delete "$INSTDIR\Lang\Latvian.tips"
  Delete "$INSTDIR\Lang\Norwegian.lng"
  Delete "$INSTDIR\Lang\Norwegian.tips"
  Delete "$INSTDIR\Lang\Polish.lng"
  Delete "$INSTDIR\Lang\Polish.tips"
  Delete "$INSTDIR\Lang\Portuguese.lng"
  Delete "$INSTDIR\Lang\Portuguese.tips"
  Delete "$INSTDIR\Lang\Portuguese_BR.lng"
  Delete "$INSTDIR\Lang\Portuguese_BR.tips"
  Delete "$INSTDIR\Lang\Romanian.lng"
  Delete "$INSTDIR\Lang\Romanian.tips"
  Delete "$INSTDIR\Lang\Russian.lng"
  Delete "$INSTDIR\Lang\Russian.tips"
  Delete "$INSTDIR\Lang\Slovak.lng"
  Delete "$INSTDIR\Lang\Slovenian.lng"
  Delete "$INSTDIR\Lang\Slovenian.tips"
  Delete "$INSTDIR\Lang\Spanish.lng"
  Delete "$INSTDIR\Lang\Spanish.tips"
  Delete "$INSTDIR\Lang\SpanishCastellano.lng"
  Delete "$INSTDIR\Lang\SpanishCastellano.tips"
  Delete "$INSTDIR\Lang\Swedish.lng"
  Delete "$INSTDIR\Lang\Swedish.tips"
  Delete "$INSTDIR\Lang\Turkish.lng"
  Delete "$INSTDIR\Lang\Turkish.tips"
  Delete "$INSTDIR\Lang\Ukrainian.lng"
  Delete "$INSTDIR\Lang\Ukrainian.tips"
  Delete "$INSTDIR\Templates\1-WinApp.template"
  Delete "$INSTDIR\Templates\2-ConsoleApp.template"
  Delete "$INSTDIR\Templates\3-StaticLib.template"
  Delete "$INSTDIR\Templates\4-DLL.template"
  Delete "$INSTDIR\Templates\5-Empty.template"
  Delete "$INSTDIR\Templates\ConsoleApp_c.txt"
  Delete "$INSTDIR\Templates\ConsoleApp_cpp.txt"
  Delete "$INSTDIR\Templates\Dll_c.txt"
  Delete "$INSTDIR\Templates\Dll_cpp.txt"
  Delete "$INSTDIR\Templates\Dll_h.txt"
  Delete "$INSTDIR\Templates\Dll_hpp.txt"
  Delete "$INSTDIR\Templates\Hello.ico"
  Delete "$INSTDIR\Templates\Hello.template"
  Delete "$INSTDIR\Templates\Hello_c.txt"
  Delete "$INSTDIR\Templates\Hello_cpp.txt"
  Delete "$INSTDIR\Templates\OpenGL.template"
  Delete "$INSTDIR\Templates\OpenGL.txt"
  Delete "$INSTDIR\Templates\WinApp_c.txt"
  
  ; Added for wx-devcpp  -- START
  Delete "$INSTDIR\Templates\1-Empty.template"
  Delete "$INSTDIR\Templates\0-wxWidgets.template"
  Delete "$INSTDIR\Templates\00-wxWidgets.template"
  Delete "$INSTDIR\Templates\wxWidgets\wxprojDlg.cpp"
  Delete "$INSTDIR\Templates\wxWidgets\wxprojDlg.h"
  Delete "$INSTDIR\Templates\wxWidgets\wxprojDlgApp.cpp"
  Delete "$INSTDIR\Templates\wxWidgets\wxprojDlgApp.h"
  Delete "$INSTDIR\Templates\wxWidgets\wxprojFrame.cpp"
  Delete "$INSTDIR\Templates\wxWidgets\wxprojFrame.h"
   Delete "$INSTDIR\Templates\wxWidgets\wxprojFrameApp.cpp"
  Delete "$INSTDIR\Templates\wxWidgets\wxprojFrameApp.h"
  Delete "$INSTDIR\Templates\wxWidgets\wxDlg.h.code"
  Delete "$INSTDIR\Templates\wxWidgets\wxDlg.cpp.code"
  Delete "$INSTDIR\Templates\wxWidgets\wxFrame.h.code"
  Delete "$INSTDIR\Templates\wxWidgets\wxFrame.cpp.code"
  Delete "$INSTDIR\Templates\wxWidgets\wx_precompiled_headers.h"
  ; Added for wx-devcpp  -- END
  
  Delete "$INSTDIR\copying.txt"
  Delete "$INSTDIR\wxdevcpp ${WXDEVCPP_VERSION} changes.html"
  Delete "$INSTDIR\devcpp.map"
  Delete "$INSTDIR\Packages\DevCppHelp.entry"
  Delete "$INSTDIR\Packages\Dev-C++_Map.entry"
  Delete "$INSTDIR\devcpp.exe"
  Delete "$INSTDIR\Packman.exe"
  Delete "$INSTDIR\Packman.map"

  Delete "$INSTDIR\bin\rm.exe"
  
  ; Added for wx-devcpp  -- START
  Delete "$INSTDIR\devcpp.pallete"
  Delete "$INSTDIR\devcpp.mad"
  Delete "$INSTDIR\devcpp.exe"
  
  RMDir "$INSTDIR\Templates\wxWidgets"
  ; Added for wx-devcpp  -- END

  RMDir  "$INSTDIR\Templates"
  RMDir  "$INSTDIR\Packages"
  RMDir  "$INSTDIR\Lang"
  RMDir  "$INSTDIR\Icons"
  RMDir  "$INSTDIR\Help"
  RMDir  "$INSTDIR\Examples\WinTest"
  RMDir  "$INSTDIR\Examples\WinMenu"
  RMDir  "$INSTDIR\Examples\WinAnim"
  RMDir  "$INSTDIR\Examples\Simpwin"
  RMDir  "$INSTDIR\Examples\OpenGL"
  RMDir  "$INSTDIR\Examples\MDIApp"
  RMDir  "$INSTDIR\Examples\Jackpot"
  RMDir  "$INSTDIR\Examples\Hello"
  RMDir  "$INSTDIR\Examples\FileEditor"
  RMDir  "$INSTDIR\Examples"
  RMDir  "$INSTDIR\bin"
  RMDir  "$INSTDIR"
