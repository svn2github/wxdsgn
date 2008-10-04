; $Id$
; Author: Tony Reina
; LGPL license
; NSIS Install Script for wx-devcpp
; http://nsis.sourceforge.net/
; Uninstaller for wxDev-C++
; The installer should have tried to install everything via depaks.
; If it worked, then we should be able to uninstall mostly all files
; by uninstalling those devpaks. Anything left over is stuff the user
; created.
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

  Delete "$INSTDIR\devcpp.exe"
  Delete "$INSTDIR\Packman.exe"
  Delete "$INSTDIR\Packman.map"

  Delete "$INSTDIR\Icons\*.*"
  Delete "$INSTDIR\license.txt"

  Delete "$INSTDIR\bin\rm.exe"
  
  RMDir  "$INSTDIR\Templates"
  RMDir  "$INSTDIR\Packages"
  RMDir  "$INSTDIR\Lang"
  RMDir  "$INSTDIR\Icons"
  RMDir  "$INSTDIR\Help"
  RMDir  "$INSTDIR\bin"
  RMDir  "$INSTDIR"
