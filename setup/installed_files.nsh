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

; Find all installed devpaks and uninstall them
FindFirst $0 $1 $INSTDIR\Packages\*.entry
loop_devpaks:
  StrCmp $1 "" done_devpaks
  DetailPrint 'Uninstalling package $1'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\$1"'
  FindNext $0 $1
  Goto loop_devpaks
done_devpaks:

!ifdef HAVE_MINGW 

  ;ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\binutils.entry"'
  ;ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\gcc-core.entry"'
  ;ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\gcc-g++.entry"'
  ;ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\gdb.entry"'
  ;ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\make.entry"'
  ;ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\mingw-runtime.entry"'
  ;ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\w32api.entry"'
  
   ; Added for wx-devcpp  -- START
  ;ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\${wxWidgetsContrib}"'
  ;ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\${wxWidgetsSamples}"'
  ;ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\${wxWidgets_gcc}"'
  ; Added for wx-devcpp  -- END

!endif

!ifdef HAVE_MSVC
   ;ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\${wxWidgets_vc}"'
!endif

  ; Added for wx-devcpp  -- START
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
  
  Delete "$INSTDIR\Lang\English.lng"
  Delete "$INSTDIR\Lang\English.tips"
  
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
  ; Added for wx-devcpp  -- END

  RMDir  "$INSTDIR\Templates"
  RMDir  "$INSTDIR\Packages"
  RMDir  "$INSTDIR\Lang"
  RMDir  "$INSTDIR\Icons"
  RMDir  "$INSTDIR\Help"
  RMDir  "$INSTDIR\bin"
  RMDir  "$INSTDIR"
