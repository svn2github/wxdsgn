;--------------------------------
; $Id$
; NSIS Install Script for wx-devcpp
; http://nsis.sourceforge.net/

!define DEVCPP_VERSION "4.9.9.2"
!define WXDEVCPP_VERSION "6.7beta"
!define WXWIDGETS_VERSION "2.5"
!define PROGRAM_NAME "wx-devcpp"
!define START_MENU_DIRECTORY "Bloodshed Dev-C++"
!define DISPLAY_NAME "${PROGRAM_NAME} ${WXDEVCPP_VERSION} (${DEVCPP_VERSION})"
!define HAVE_MINGW
!define NEW_INTERFACE

Var LOCAL_APPDATA

!ifdef NEW_INTERFACE
;--------------------------------
;Include Modern UI

  !include "MUI.nsh"

!endif

  !include "logiclib.nsh" ; needed by ${switch}
;--------------------------------

# [Installer Attributes]

Name "${DISPLAY_NAME}"
!ifdef HAVE_MINGW 
OutFile "devcpp-${WXDEVCPP_VERSION}_setup.exe"
!else
OutFile "devcpp-${WXDEVCPP_VERSION}_nomingw_setup.exe"
!endif
Caption "${DISPLAY_NAME}"

# [Licence Attributes]
LicenseText "${PROGRAM_NAME} is distributed under the GNU General Public License :"
LicenseData "copying.txt"

# [Directory Selection]
InstallDir "C:\Dev-Cpp"
DirText "Select the directory to install ${PROGRAM_NAME} to :"

# [Additional Installer Settings ]
SetCompress force
SetCompressor lzma

;--------------------------------
;Interface Settings

ShowInstDetails show
AutoCloseWindow false
SilentInstall normal
CRCCheck on
SetCompress auto
SetDatablockOptimize on
;SetOverwrite ifnewer
XPStyle on

InstType "Full" ;1
InstType "Typical" ;2

ComponentText "Choose components"

# [Background Gradient]
BGGradient off

!ifdef NEW_INTERFACE
  !define MUI_ABORTWARNING
!endif

;--------------------------------

# [Pages]

!ifndef NEW_INTERFACE
  
Page license
Page components
PageEx directory
  DirVerify leave
  PageCallbacks "" "" dirLeave
PageExEnd
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

!else ;NEW_INTERFACE

  !insertmacro MUI_PAGE_LICENSE "copying.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !define MUI_PAGE_CUSTOMFUNCTION_LEAVE dirLeave
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  
  !define MUI_FINISHPAGE_RUN "$INSTDIR\devcpp.exe"
  !define MUI_FINISHPAGE_NOREBOOTSUPPORT
  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"

  !insertmacro MUI_LANGUAGE "Bulgarian"
  !insertmacro MUI_LANGUAGE "Catalan"
;  !insertmacro MUI_LANGUAGE "Chinese"
;  !insertmacro MUI_LANGUAGE "Chinese_TC"
  !insertmacro MUI_LANGUAGE "Croatian"
  !insertmacro MUI_LANGUAGE "Czech"
  !insertmacro MUI_LANGUAGE "Danish"
  !insertmacro MUI_LANGUAGE "Dutch"
  !insertmacro MUI_LANGUAGE "Estonian"
  !insertmacro MUI_LANGUAGE "French"
;  !insertmacro MUI_LANGUAGE "Galego"
  !insertmacro MUI_LANGUAGE "German"
  !insertmacro MUI_LANGUAGE "Greek"
  !insertmacro MUI_LANGUAGE "Hungarian"
  !insertmacro MUI_LANGUAGE "Italian"
  !insertmacro MUI_LANGUAGE "Korean"
  !insertmacro MUI_LANGUAGE "Latvian"
  !insertmacro MUI_LANGUAGE "Norwegian"
  !insertmacro MUI_LANGUAGE "Polish"
  !insertmacro MUI_LANGUAGE "Portuguese"
  !insertmacro MUI_LANGUAGE "Romanian"
;  !insertmacro MUI_LANGUAGE "Russian"
  !insertmacro MUI_LANGUAGE "Slovak"
  !insertmacro MUI_LANGUAGE "Slovenian"
  !insertmacro MUI_LANGUAGE "Spanish"
;  !insertmacro MUI_LANGUAGE "SpanishCastellano"
  !insertmacro MUI_LANGUAGE "Swedish"
  !insertmacro MUI_LANGUAGE "Turkish"
  !insertmacro MUI_LANGUAGE "Ukrainian"

!endif ;NEW_INTERFACE
;--------------------------------

# [Files]

Section "${PROGRAM_NAME} program files (required)" SectionMain
  SectionIn 1 2 RO
  SetOutPath $INSTDIR
 
  File "devcpp.exe"
  File "copying.txt"
  File "News.txt"
  File "packman.exe"
  SetOutPath $INSTDIR\Lang
  File "Lang\English.*"
  SetOutPath $INSTDIR\Templates
  File "Templates\*"
  SetOutPath $INSTDIR\bin
  File "bin\rm.exe"

 ; Added for wx-devcpp  -- START

  ; Replace the text %DEVCPPINSTALLDIR% in the template files with
  ; whatever installation directory the user selected during
  ; the install
  Push "%DEVCPPINSTALLDIR%" #text to be replaced
  Push $INSTDIR #replace with
  Push all #replace all occurrences
  Push all #replace all occurrences
  Push $INSTDIR\Templates\00-wxWindows.template #file to replace in
  Call AdvReplaceInFile

  Push "%WXVERSION%"  #text to be replaced
  Push ${WXWIDGETS_VERSION}  #replace with
  Push all #replace all occurrences
  Push all #replace all occurrences
  Push $INSTDIR\Templates\00-wxWindows.template #file to replace in
  Call AdvReplaceInFile
  
  Push "%DEVCPPINSTALLDIR%" #text to be replaced
  Push $INSTDIR #replace with
  Push all #replace all occurrences
  Push all #replace all occurrences
  Push $INSTDIR\Templates\0-wxWindows.template #file to replace in
  Call AdvReplaceInFile

  Push "%WXVERSION%"  #text to be replaced
  Push ${WXWIDGETS_VERSION}  #replace with
  Push all #replace all occurrences
  Push all #replace all occurrences
  Push $INSTDIR\Templates\0-wxWindows.template #file to replace in
  Call AdvReplaceInFile

  Push "%DEVCPPINSTALLDIR%" #text to be replaced
  Push $INSTDIR #replace with
  Push all #replace all occurrences
  Push all #replace all occurrences
  Push $INSTDIR\Templates\1-empty.template #file to replace in
  Call AdvReplaceInFile
  ; end replacing text within template files

  Push "%WXVERSION%"  #text to be replaced
  Push ${WXWIDGETS_VERSION}  #replace with
  Push all #replace all occurrences
  Push all #replace all occurrences
  Push $INSTDIR\Templates\1-empty.template #file to replace in
  Call AdvReplaceInFile

 ; SetOutPath $INSTDIR\wx
 ; File /r "wx\*"
  ; Added for wx-devcpp  -- END

  ; Delete old devcpp.map to avoid confusion in bug reports
  Delete "$INSTDIR\devcpp.map"

  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\${PROGRAM_NAME} "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}" "DisplayName" "${DISPLAY_NAME}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}" "NoRepair" 1
  WriteUninstaller "$INSTDIR\uninstall.exe"

SectionEnd

Section "Example files" SectionExamples
  SectionIn 1 2
  SetOutPath $INSTDIR\Examples
  SetOutPath $INSTDIR\Examples\FileEditor
  File "Examples\FileEditor\*"
  SetOutPath $INSTDIR\Examples\Hello
  File "Examples\Hello\*"
  SetOutPath $INSTDIR\Examples\Jackpot
  File "Examples\Jackpot\*"
  SetOutPath $INSTDIR\Examples\MDIApp
  File "Examples\MDIApp\*"
  SetOutPath $INSTDIR\Examples\OpenGL
  File "Examples\OpenGL\*"
  SetOutPath $INSTDIR\Examples\Simpwin
  File "Examples\Simpwin\*"
  SetOutPath $INSTDIR\Examples\WinAnim
  File "Examples\WinAnim\*"
  SetOutPath $INSTDIR\Examples\WinMenu
  File "Examples\WinMenu\*"
  SetOutPath $INSTDIR\Examples\WinTest
  File "Examples\WinTest\*"
SectionEnd

Section "Help files" SectionHelp
  SectionIn 1 2
  SetOutPath $INSTDIR\Help
  File "Help\DevCpp.hlp"
  File "Help\DevCpp.cnt"
  SetOutPath $INSTDIR\Packages
  File "Packages\DevCppHelp.entry"
  
  ; Added for wx-devcpp  -- START
  SetOutPath $INSTDIR\Help
  File "Help\wx.hlp"
  File "Help\wx.cnt"
  File "Help\wx.gid"
  File "Help\devhelp.ini"
  File "Help\wx-devcpp Tutorial Help.chm"
  ; Added for wx-devcpp  -- END

SectionEnd

Section "Icon files" SectionIcons
  SectionIn 1 2
  SetOutPath $INSTDIR\Icons
  File "Icons\*.ico"
  #SetOutPath $INSTDIR\Themes
  #File /r "Themes\*"
SectionEnd

!ifdef HAVE_MINGW
Section "Mingw compiler system (binaries, headers and libraries)" SectionMingw
  SectionIn 1 2
  SetOutPath $INSTDIR
  ; uninstall previous packages
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\binutils.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\gcc-core.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\gcc-g++.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\gcc-objc.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\gdb.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\make.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\mingw-runtime.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\w32api.entry"'
  
  ; Added for wx-devcpp  -- START
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\wxWidgets_contrib.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\wxWidgets.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\libpng.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\libtiff.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\libjpeg.entry"'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\zlib.entry"'
  ; Added for wx-devcpp  -- END

  File /r "bin"
  File /r "include"
  File /r "lib"
  File /r "libexec"
  File /r "mingw32"
  SetOutPath $INSTDIR\Packages
  File "Packages\binutils.entry"
  File "Packages\gcc-core.entry"
  File "Packages\gcc-g++.entry"
  File "Packages\gdb.entry"
  File "Packages\make.entry"
  File "Packages\mingw-runtime.entry"
  File "Packages\w32api.entry"
  
  ; Added for wx-devcpp  -- START
  File "Packages\zlib.entry"
  File "Packages\libjpeg.entry"
  File "Packages\libtiff.entry"
  File "Packages\libpng.entry"
  File "Packages\wxWidgets.entry"
  File "Packages\wxWidgets_contrib.entry"
  ; Added for wx-devcpp  -- END
  
SectionEnd
!endif

# Section "Updater and bug reporter (vUpdate/vRoach)"
#   SectionIn 1 2
#   SetOutPath $INSTDIR
#   File "vUpdate.exe"
#   File "vRoach.exe"
# SectionEnd

Section "Language files" SectionLangs
  SectionIn 1
  SetOutPath $INSTDIR\Lang
  File "Lang\*"
SectionEnd

# [File association]
SubSection "Associate C and C++ files to ${PROGRAM_NAME}" SectionAssocs

Section "Associate .dev files to ${PROGRAM_NAME}"
  SectionIn 1 2

  StrCpy $0 ".dev"
  Call BackupAssoc

  StrCpy $0 $INSTDIR\DevCpp.exe
  WriteRegStr HKCR ".dev" "" "${PROGRAM_NAME}.dev"
  WriteRegStr HKCR "${PROGRAM_NAME}.dev" "" "${PROGRAM_NAME} Project File"
  WriteRegStr HKCR "${PROGRAM_NAME}.dev\DefaultIcon" "" '$0,3'
  WriteRegStr HKCR "${PROGRAM_NAME}.dev\Shell\Open\Command" "" '$0 "%1"'
  Call RefreshShellIcons
SectionEnd

Section "Associate .c files to ${PROGRAM_NAME}"
  SectionIn 1 2

  StrCpy $0 ".c"
  Call BackupAssoc

  StrCpy $0 $INSTDIR\DevCpp.exe
  WriteRegStr HKCR ".c" "" "${PROGRAM_NAME}.c"
  WriteRegStr HKCR "${PROGRAM_NAME}.c" "" "C Source File"
  WriteRegStr HKCR "${PROGRAM_NAME}.c\DefaultIcon" "" '$0,4'
  WriteRegStr HKCR "${PROGRAM_NAME}.c\Shell\Open\Command" "" '$0 "%1"'
  Call RefreshShellIcons
SectionEnd

Section "Associate .cpp files to ${PROGRAM_NAME}"
  SectionIn 1 2

  StrCpy $0 ".cpp"
  Call BackupAssoc

  StrCpy $0 $INSTDIR\DevCpp.exe
  WriteRegStr HKCR ".cpp" "" "${PROGRAM_NAME}.cpp"
  WriteRegStr HKCR "${PROGRAM_NAME}.cpp" "" "C++ Source File"
  WriteRegStr HKCR "${PROGRAM_NAME}.cpp\DefaultIcon" "" '$0,5'
  WriteRegStr HKCR "${PROGRAM_NAME}.cpp\Shell\Open\Command" "" '$0 "%1"'
  Call RefreshShellIcons
SectionEnd

Section "Associate .h files to ${PROGRAM_NAME}"
  SectionIn 1 2

  StrCpy $0 ".h"
  Call BackupAssoc

  StrCpy $0 $INSTDIR\DevCpp.exe
  WriteRegStr HKCR ".h" "" "DevCpp.h"
  WriteRegStr HKCR "${PROGRAM_NAME}.h" "" "C Header File"
  WriteRegStr HKCR "${PROGRAM_NAME}.h\DefaultIcon" "" '$0,6'
  WriteRegStr HKCR "${PROGRAM_NAME}.h\Shell\Open\Command" "" '$0 "%1"'
  Call RefreshShellIcons
SectionEnd

Section "Associate .hpp files to ${PROGRAM_NAME}"
  SectionIn 1 2

  StrCpy $0 ".hpp"
  Call BackupAssoc

  StrCpy $0 $INSTDIR\DevCpp.exe
  WriteRegStr HKCR ".hpp" "" "${PROGRAM_NAME}.hpp"
  WriteRegStr HKCR "${PROGRAM_NAME}.hpp" "" "C++ Header File"
  WriteRegStr HKCR "${PROGRAM_NAME}.hpp\DefaultIcon" "" '$0,7'
  WriteRegStr HKCR "${PROGRAM_NAME}.hpp\Shell\Open\Command" "" '$0 "%1"'
  Call RefreshShellIcons
SectionEnd

Section "Associate .rc files to ${PROGRAM_NAME}"
  SectionIn 1 2

  StrCpy $0 ".rc"
  Call BackupAssoc

  StrCpy $0 $INSTDIR\DevCpp.exe
  WriteRegStr HKCR ".rc" "" "${PROGRAM_NAME}.rc"
  WriteRegStr HKCR "${PROGRAM_NAME}.rc" "" "Resource Source File"
  WriteRegStr HKCR "${PROGRAM_NAME}.rc\DefaultIcon" "" '$0,8'
  WriteRegStr HKCR "${PROGRAM_NAME}.rc\Shell\Open\Command" "" '$0 "%1"'
  Call RefreshShellIcons
SectionEnd

Section "Associate .devpak files to ${PROGRAM_NAME}"
  SectionIn 1 2

  StrCpy $0 ".devpak"
  Call BackupAssoc

  StrCpy $0 $INSTDIR\DevCpp.exe
  StrCpy $1 $INSTDIR\PackMan.exe
  WriteRegStr HKCR ".devpak" "" "${PROGRAM_NAME}.devpak"
  WriteRegStr HKCR "${PROGRAM_NAME}.devpak" "" "${PROGRAM_NAME} Package File"
  WriteRegStr HKCR "${PROGRAM_NAME}.devpak\DefaultIcon" "" '$0,9'
  WriteRegStr HKCR "${PROGRAM_NAME}.devpak\Shell\Open\Command" "" '$1 "%1"'
  Call RefreshShellIcons
SectionEnd

Section "Associate .devpackage files to ${PROGRAM_NAME}"
  SectionIn 1 2

  StrCpy $0 ".devpackage"
  Call BackupAssoc

  StrCpy $0 $INSTDIR\DevCpp.exe
  StrCpy $1 $INSTDIR\PackMan.exe
  WriteRegStr HKCR ".devpackage" "" "${PROGRAM_NAME}.devpackage"
  WriteRegStr HKCR "${PROGRAM_NAME}.devpackage" "" "${PROGRAM_NAME} Package File"
  WriteRegStr HKCR "${PROGRAM_NAME}.devpackage\DefaultIcon" "" '$0,10'
  WriteRegStr HKCR "${PROGRAM_NAME}.devpackage\Shell\Open\Command" "" '$1 "%1"'
  Call RefreshShellIcons
SectionEnd

Section "Associate .template files to ${PROGRAM_NAME}"
  SectionIn 1 2

  StrCpy $0 ".template"
  Call BackupAssoc

  StrCpy $0 $INSTDIR\DevCpp.exe
  WriteRegStr HKCR ".template" "" "${PROGRAM_NAME}.template"
  WriteRegStr HKCR "${PROGRAM_NAME}.template" "" "${PROGRAM_NAME} Template File"
  WriteRegStr HKCR "${PROGRAM_NAME}.template\DefaultIcon" "" '$0,1'
  WriteRegStr HKCR "${PROGRAM_NAME}.template\Shell\Open\Command" "" '$0 "%1"'
  Call RefreshShellIcons
SectionEnd

SubSectionEnd

# [Shortcuts]
Section "Create shortcuts in Start Menu" SectionShortcuts
  SectionIn 1 2

  ;try to read from registry if last installation installed for All Users/Current User
  ReadRegStr $0 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}\Backup" \
      "Shortcuts"
  StrCmp $0 "" cont exists
  cont:

  SetShellVarContext all
  MessageBox MB_YESNO "Do you want to install ${PROGRAM_NAME} for all users on this computer ?" IDYES AllUsers
  SetShellVarContext current
AllUsers:
  StrCpy $0 $SMPROGRAMS
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}\Backup" \
      "Shortcuts" "$0"

exists:
  CreateDirectory "$0\${START_MENU_DIRECTORY}"
  SetOutPath $INSTDIR
  CreateShortCut "$0\${START_MENU_DIRECTORY}\${PROGRAM_NAME}.lnk" "$INSTDIR\devcpp.exe"
  CreateShortCut "$0\$START_MENU_DIRECTORY}\License.lnk" "$INSTDIR\copying.txt"
  CreateShortCut "$0\${START_MENU_DIRECTORY}\Uninstall ${PROGRAM_NAME}.lnk" "$INSTDIR\uninstall.exe"
SectionEnd

Section "Create Quick Launch shortcut" SectionQuickLaunch
  SectionIn 1 2
  SetShellVarContext current
  CreateShortCut "$QUICKLAUNCH\${PROGRAM_NAME}.lnk" "$INSTDIR\devcpp.exe"
SectionEnd

Section "Debug files" SectionDebug
  SectionIn 1
  SetOutPath $INSTDIR
  File "devcpp.map"
  File "Packman.map"
  SetOutPath $INSTDIR\Packages
  File "Packages\Dev-C++_Map.entry"
SectionEnd

Section "Remove all previous configuration files" SectionConfig
   SectionIn 1 2

  Delete "$APPDATA\Dev-Cpp\devcpp.ini"
  Delete "$APPDATA\Dev-Cpp\devcpp.cfg"
  Delete "$APPDATA\Dev-Cpp\cache.ccc"
  Delete "$APPDATA\Dev-Cpp\defaultcode.cfg"
  Delete "$APPDATA\Dev-Cpp\devshortcuts.cfg"
  Delete "$APPDATA\Dev-Cpp\classfolders.dcf"
  Delete "$APPDATA\Dev-Cpp\mirrors.cfg"
  Delete "$APPDATA\Dev-Cpp\tools.ini"
  Delete "$APPDATA\Dev-Cpp\devcpp.ci"
  
  call GetLocalAppData
  Delete "$LOCAL_APPDATA\devcpp.ini"
  Delete "$LOCAL_APPDATA\devcpp.cfg"
  Delete "$LOCAL_APPDATA\cache.ccc"
  Delete "$LOCAL_APPDATA\defaultcode.cfg"
  Delete "$LOCAL_APPDATA\devshortcuts.cfg"
  Delete "$LOCAL_APPDATA\classfolders.dcf"
  Delete "$LOCAL_APPDATA\mirrors.cfg"
  Delete "$LOCAL_APPDATA\tools.ini"
  Delete "$LOCAL_APPDATA\devcpp.ci"

  Delete "$APPDATA\devcpp.ini"
  Delete "$APPDATA\devcpp.cfg"
  Delete "$APPDATA\cache.ccc"
  Delete "$APPDATA\defaultcode.cfg"
  Delete "$APPDATA\devshortcuts.cfg"
  Delete "$APPDATA\classfolders.dcf"
  Delete "$APPDATA\mirrors.cfg"
  Delete "$APPDATA\tools.ini"
  Delete "$APPDATA\devcpp.ci"
  
  Delete "$INSTDIR\devcpp.ini"
  Delete "$INSTDIR\devcpp.cfg"
  Delete "$INSTDIR\cache.ccc"
  Delete "$INSTDIR\defaultcode.cfg"
  Delete "$INSTDIR\devshortcuts.cfg"
  Delete "$INSTDIR\classfolders.dcf"
  Delete "$INSTDIR\mirrors.cfg"
  Delete "$INSTDIR\tools.ini"
  Delete "$INSTDIR\devcpp.ci"
SectionEnd

Function run_devcpp

  MessageBox MB_YESNO "${PROGRAM_NAME} ${WXDEVCPP_VERSION} has been installed successfully.$\r$\nDo you wish to run the program?" IDNO dont_run
  ; For some reason, NSIS uses the last directory it was working on
  ; Because of this, if you try the command $INSTDIR/devcpp.exe, the wx-devcpp
  ; program will run, but it might not be using $INSTDIR as the working directory
  ; This can screw up the code completion cache that's created on the initial run
  ; To get around it, we add this code to specifically change the directory to $INSTDIR
  ; and then run the program.  GAR --21 Feb 2005
   SetOutPath "$INSTDIR"
   Exec "devcpp.exe"
dont_run:
FunctionEnd

;--------------------------------

# [Sections' descriptions (on mouse over)]
!ifdef NEW_INTERFACE

  LangString DESC_SectionMain ${LANG_ENGLISH} "The ${PROGRAM_NAME} IDE (Integrated Development Environment), package manager and templates"
  LangString DESC_SectionExamples ${LANG_ENGLISH} "Example projects for simple console and GUI applications"
  LangString DESC_SectionHelp ${LANG_ENGLISH} "Help on using ${PROGRAM_NAME} and programming in C"
  LangString DESC_SectionIcons ${LANG_ENGLISH} "Various icons that you can use in your programs"
!ifdef HAVE_MINGW
  LangString DESC_SectionMingw ${LANG_ENGLISH} "The MinGW gcc compiler and associated tools, headers and libraries"
!endif
  LangString DESC_SectionLangs ${LANG_ENGLISH} "The ${PROGRAM_NAME} interface translated to different languages (other than English which is built-in)"
  LangString DESC_SectionAssocs ${LANG_ENGLISH} "Use ${PROGRAM_NAME} as the default application for opening these types of files"
  LangString DESC_SectionShortcuts ${LANG_ENGLISH} "Create a '${PROGRAM_NAME}' program group with shortcuts, in the start menu"
  LangString DESC_SectionQuickLaunch ${LANG_ENGLISH} "Create a shortcut to ${PROGRAM_NAME} in the QuickLaunch toolbar"
  LangString DESC_SectionDebug ${LANG_ENGLISH} "Debug file to help debugging ${PROGRAM_NAME}"
  LangString DESC_SectionConfig ${LANG_ENGLISH} "Remove all previous configuration files"

  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionMain} $(DESC_SectionMain)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionExamples} $(DESC_SectionExamples)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionHelp} $(DESC_SectionHelp)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionIcons} $(DESC_SectionIcons)
!ifdef HAVE_MINGW
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionMingw} $(DESC_SectionMingw)
!endif
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionLangs} $(DESC_SectionLangs)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionAssocs} $(DESC_SectionAssocs)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionShortcuts} $(DESC_SectionShortcuts)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionQuickLaunch} $(DESC_SectionQuickLaunch)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionDebug} $(DESC_SectionDebug)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionConfig} $(DESC_SectionConfig)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

!endif ;NEW_INTERFACE

;--------------------------------

; Functions

Function .onInit
  MessageBox MB_OK "Welcome to ${PROGRAM_NAME} install program. Please do not install this version of ${PROGRAM_NAME} over an existing installation."

  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

!ifndef NEW_INTERFACE

;called when the user hits the 'cancel' button
Function .onUserAbort
  MessageBox MB_YESNO "Abort install?" IDYES NoCancelAbort
  Abort
  NoCancelAbort:
FunctionEnd

;called when the install was successful
Function .onInstSuccess
  MessageBox MB_YESNO "Do you want to run ${PROGRAM_NAME} now?" IDNO DontRun
  Exec '"$INSTDIR\devcpp.exe"'
  DontRun:
FunctionEnd

!endif ;!NEW_INTERFACE

;called when the uninstall was successful
Function un.onUninstSuccess
  Delete "$INSTDIR\uninstall.exe"
  RMDir "$INSTDIR"
FunctionEnd

;backup file association
Function BackupAssoc
  ;$0 is an extension - for example ".dev"

  ;check if backup already exists
  ReadRegStr $1 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${START_MENU_DIRECTORY}\Backup" "$0"
  ;don't backup if backup exists in registry
  StrCmp $1 "" 0 no_assoc

  ReadRegStr $1 HKCR "$0" ""
  ;don't backup dev-cpp associations
  StrCmp $1 "DevCpp$0" no_assoc

  StrCmp $1 "" no_assoc
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${START_MENU_DIRECTORY}\Backup" "$0" "$1"
  no_assoc:
  
FunctionEnd

;restore file association
Function un.RestoreAssoc
  ;$0 is an extension - for example ".dev"

  DeleteRegKey HKCR "$0"
  ReadRegStr $1 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${START_MENU_DIRECTORY}\Backup" "$0"
  StrCmp $1 "" no_backup
    WriteRegStr HKCR "$0" "" "$1"
    Call un.RefreshShellIcons
  no_backup:
  
FunctionEnd

;http://nsis.sourceforge.net/archive/viewpage.php?pageid=202
;After changing file associations, you can call this macro to refresh the shell immediatly. 
;It calls the shell32 function SHChangeNotify. This will force windows to reload your changes from the registry.
!define SHCNE_ASSOCCHANGED 0x08000000
!define SHCNF_IDLIST 0

Function RefreshShellIcons
  ; By jerome tremblay - april 2003
  System::Call 'shell32.dll::SHChangeNotify(i, i, i, i) v \
  (${SHCNE_ASSOCCHANGED}, ${SHCNF_IDLIST}, 0, 0)'
FunctionEnd

Function un.RefreshShellIcons
  ; By jerome tremblay - april 2003
  System::Call 'shell32.dll::SHChangeNotify(i, i, i, i) v \
  (${SHCNE_ASSOCCHANGED}, ${SHCNF_IDLIST}, 0, 0)'
FunctionEnd

;http://nsis.sourceforge.net/archive/nsisweb.php?page=628&instances=0,11,122
Function StrCSpnReverse
 Exch $R0 ; string to check
 Exch
 Exch $R1 ; string of chars
 Push $R2 ; current char
 Push $R3 ; current char
 Push $R4 ; char loop
 Push $R5 ; char loop

  StrCpy $R4 -1

  NextCharCheck:
  StrCpy $R2 $R0 1 $R4
  IntOp $R4 $R4 - 1
   StrCmp $R2 "" StrOK

   StrCpy $R5 -1

   NextChar:
   StrCpy $R3 $R1 1 $R5
   IntOp $R5 $R5 - 1
    StrCmp $R3 "" +2
    StrCmp $R3 $R2 NextCharCheck NextChar
     StrCpy $R0 $R2
     Goto Done

 StrOK:
 StrCpy $R0 ""

 Done:

 Pop $R5
 Pop $R4
 Pop $R3
 Pop $R2
 Pop $R1
 Exch $R0
FunctionEnd

#Verify the installation directory
Function dirLeave
  Push "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz:-_\"
  Push $INSTDIR
  Call StrCSpnReverse
  Pop $R0
  StrCmp $R0 "" +3
  MessageBox MB_OK|MB_ICONEXCLAMATION "Installation directory cannot contain: '$R0'. Only letters, numbers and ':-_\' are allowed."
  Abort

  GetInstDirError $0
  ${Switch} $0
    ${Case} 1
      MessageBox MB_OK "invalid installation directory!"
      Abort
      ${Break}
    ${Case} 2
      MessageBox MB_OK "not enough free space!"
      Abort
      ${Break}
  ${EndSwitch}

FunctionEnd

#Fill the global variable with Local\Application Data directory CSIDL_LOCAL_APPDATA
!define CSIDL_LOCAL_APPDATA 0x001C
Function GetLocalAppData
  StrCpy $0 ${NSIS_MAX_STRLEN}

  System::Call 'shfolder.dll::SHGetFolderPathA(i, i, i, i, t) i \
                (0, ${CSIDL_LOCAL_APPDATA}, 0, 0, .r0) .r1'
  
  StrCpy $LOCAL_APPDATA $0
FunctionEnd

Function un.GetLocalAppData
  StrCpy $0 ${NSIS_MAX_STRLEN}

  System::Call 'shfolder.dll::SHGetFolderPathA(i, i, i, i, t) i \
                (0, ${CSIDL_LOCAL_APPDATA}, 0, 0, .r0) .r1'
  
  StrCpy $LOCAL_APPDATA $0
FunctionEnd

; Added for wx-devcpp  -- START

; Replace text within a file
; From http://nsis.sourceforge.net/archive/nsisweb.php?page=511&instances=0,11,311
; USE:
; Push hello #text to be replaced
; Push blah #replace with
; Push all #replace all occurrences
; Push all #replace all occurrences
; Push C:\temp1.bat #file to replace in
; Call AdvReplaceInFile

;Original Written by Afrow UK
; Rewrite to Replace on line within text by rainmanx
; This version works on R4 and R3 of Nullsoft Installer
; It replaces what ever is in the line throught the entire text matching it.
Function AdvReplaceInFile
Exch $0 ;file to replace in
Exch
Exch $1 ;number to replace after
Exch
Exch 2
Exch $2 ;replace and onwards
Exch 2
Exch 3
Exch $3 ;replace with
Exch 3
Exch 4
Exch $4 ;to replace
Exch 4
Push $5 ;minus count
Push $6 ;universal
Push $7 ;end string
Push $8 ;left string
Push $9 ;right string
Push $R0 ;file1
Push $R1 ;file2
Push $R2 ;read
Push $R3 ;universal
Push $R4 ;count (onwards)
Push $R5 ;count (after)
Push $R6 ;temp file name
;-------------------------------
GetTempFileName $R6
FileOpen $R1 $0 r ;file to search in
FileOpen $R0 $R6 w ;temp file
StrLen $R3 $4
StrCpy $R4 -1
StrCpy $R5 -1
loop_read:
ClearErrors
FileRead $R1 $R2 ;read line
IfErrors exit
StrCpy $5 0
StrCpy $7 $R2
loop_filter:
IntOp $5 $5 - 1
StrCpy $6 $7 $R3 $5 ;search
StrCmp $6 "" file_write2
StrCmp $6 $4 0 loop_filter
StrCpy $8 $7 $5 ;left part
IntOp $6 $5 + $R3
StrCpy $9 $7 "" $6 ;right part
StrLen $6 $7
StrCpy $7 $8$3$9 ;re-join
StrCmp -$6 $5 0 loop_filter
IntOp $R4 $R4 + 1
StrCmp $2 all file_write1
StrCmp $R4 $2 0 file_write2
IntOp $R4 $R4 - 1
IntOp $R5 $R5 + 1
StrCmp $1 all file_write1
StrCmp $R5 $1 0 file_write1
IntOp $R5 $R5 - 1
Goto file_write2
file_write1:
FileWrite $R0 $7 ;write modified line
Goto loop_read
file_write2:
FileWrite $R0 $7 ;write modified line
Goto loop_read
exit:
FileClose $R0
FileClose $R1
SetDetailsPrint none
Delete $0
Rename $R6 $0
Delete $R6
SetDetailsPrint both
;-------------------------------
Pop $R6
Pop $R5
Pop $R4
Pop $R3
Pop $R2
Pop $R1
Pop $R0
Pop $9
Pop $8
Pop $7
Pop $6
Pop $5
Pop $4
Pop $3
Pop $2
Pop $1
Pop $0
FunctionEnd

; Added for wx-devcpp  -- END

;--------------------------------

# [UnInstallation]

UninstallText "This program will uninstall ${PROGRAM_NAME}, continue ?"
ShowUninstDetails show

Section "Uninstall"

  ; Remove files and uninstaller
  Delete "$INSTDIR\uninstall.exe"
  !include ".\installed_files.nsh"

  ; Remove icons
  ReadRegStr $0 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${START_MENU_DIRECTORY}\Backup" \
      "Shortcuts"
  Delete "$0\${START_MENU_DIRECTORY}\${PROGRAM_NAME}.lnk"
  Delete "$0\${START_MENU_DIRECTORY}\License.lnk"
  Delete "$0\${START_MENU_DIRECTORY}\Uninstall ${PROGRAM_NAME}.lnk"
  RMDir  "$0\${START_MENU_DIRECTORY}"
  SetShellVarContext current
  Delete "$QUICKLAUNCH\${PROGRAM_NAME}.lnk"

  ; Restore file associations
  StrCpy $0 ".dev"
  Call un.RestoreAssoc
  StrCpy $0 ".c"
  Call un.RestoreAssoc
  StrCpy $0 ".cpp"
  Call un.RestoreAssoc
  StrCpy $0 ".h"
  Call un.RestoreAssoc
  StrCpy $0 ".hpp"
  Call un.RestoreAssoc
  StrCpy $0 ".rc"
  Call un.RestoreAssoc
  StrCpy $0 ".devpak"
  Call un.RestoreAssoc
  StrCpy $0 ".devpackage"
  Call un.RestoreAssoc
  StrCpy $0 ".template" 
  Call un.RestoreAssoc
 
  DeleteRegKey HKCR "${PROGRAM_NAME}.dev"
  DeleteRegKey HKCR "${PROGRAM_NAME}.c"
  DeleteRegKey HKCR "${PROGRAM_NAME}.cpp"
  DeleteRegKey HKCR "${PROGRAM_NAME}.h"
  DeleteRegKey HKCR "${PROGRAM_NAME}.hpp"
  DeleteRegKey HKCR "${PROGRAM_NAME}.rc"
  DeleteRegKey HKCR "${PROGRAM_NAME}.devpak"
  DeleteRegKey HKCR "${PROGRAM_NAME}.devpackage"
  DeleteRegKey HKCR "${PROGRAM_NAME}.template"

  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${START_MENU_DIRECTORY}"
  DeleteRegKey HKLM "SOFTWARE\${START_MENU_DIRECTORY}"

  MessageBox MB_YESNO "Do you want to remove all the remaining configuration files?" IDNO Done

  Delete "$APPDATA\Dev-Cpp\devcpp.ini"
  Delete "$APPDATA\Dev-Cpp\devcpp.cfg"
  Delete "$APPDATA\Dev-Cpp\cache.ccc"
  Delete "$APPDATA\Dev-Cpp\defaultcode.cfg"
  Delete "$APPDATA\Dev-Cpp\devshortcuts.cfg"
  Delete "$APPDATA\Dev-Cpp\classfolders.dcf"
  Delete "$APPDATA\Dev-Cpp\mirrors.cfg"
  Delete "$APPDATA\Dev-Cpp\tools.ini"
  Delete "$APPDATA\Dev-Cpp\devcpp.ci"
  
  call un.GetLocalAppData
  Delete "$LOCAL_APPDATA\devcpp.ini"
  Delete "$LOCAL_APPDATA\devcpp.cfg"
  Delete "$LOCAL_APPDATA\cache.ccc"
  Delete "$LOCAL_APPDATA\defaultcode.cfg"
  Delete "$LOCAL_APPDATA\devshortcuts.cfg"
  Delete "$LOCAL_APPDATA\classfolders.dcf"
  Delete "$LOCAL_APPDATA\mirrors.cfg"
  Delete "$LOCAL_APPDATA\tools.ini"
  Delete "$LOCAL_APPDATA\devcpp.ci"

  Delete "$APPDATA\devcpp.ini"
  Delete "$APPDATA\devcpp.cfg"
  Delete "$APPDATA\cache.ccc"
  Delete "$APPDATA\defaultcode.cfg"
  Delete "$APPDATA\devshortcuts.cfg"
  Delete "$APPDATA\classfolders.dcf"
  Delete "$APPDATA\mirrors.cfg"
  Delete "$APPDATA\tools.ini"
  Delete "$APPDATA\devcpp.ci"
  
  Delete "$INSTDIR\devcpp.ini"
  Delete "$INSTDIR\devcpp.cfg"
  Delete "$INSTDIR\cache.ccc"
  Delete "$INSTDIR\defaultcode.cfg"
  Delete "$INSTDIR\devshortcuts.cfg"
  Delete "$INSTDIR\classfolders.dcf"
  Delete "$INSTDIR\mirrors.cfg"
  Delete "$INSTDIR\tools.ini"
  Delete "$INSTDIR\devcpp.ci"

Done:
  MessageBox MB_OK "${PROGRAM_NAME} has been uninstalled. Please now delete the $INSTDIR directory if it doesn't contain some of your documents"

SectionEnd

#eof!
