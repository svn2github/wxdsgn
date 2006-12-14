;--------------------------------
; $Id$
; NSIS Install Script for wx-devcpp
; http://nsis.sourceforge.net/

!define DEVCPP_VERSION "4.9.9.2"
!define WXDEVCPP_VERSION "6.10.1beta"
!define PROGRAM_NAME "wx-devcpp"
!define DEFAULT_START_MENU_DIRECTORY "wx-devcpp"
!define DISPLAY_NAME "${PROGRAM_NAME} ${WXDEVCPP_VERSION} (${DEVCPP_VERSION})"
!define HAVE_MINGW
!define HAVE_MSVC
!define NEW_INTERFACE

!define wxWidgets_version "2.8.0"
!define wxWidgets_name "wxWidgets_${wxWidgets_version}"

!ifdef HAVE_MINGW

  !define wxWidgets_mingw_devpak "${wxWidgets_name}_gcc.DevPak" ; name of the wxWidgets Mingw gcc devpak
  
  !define wxWidgetsContribGcc_devpak "${wxWidgets_name}_gcc_contrib.devpak"  ; name of the contrib devpak
 
  !define wxWidgetsExtrasGcc_devpak "${wxWidgets_name}_gcc_extras.devpak"  ; name of the extras devpak
 
!endif

!ifdef HAVE_MSVC

  !define wxWidgets_msvc_devpak "${wxWidgets_name}_vc.DevPak" ; name of the wxWidgets MS VC devpak
 
  !define wxWidgetsContribMSVC_devpak "${wxWidgets_name}_vc_contrib.devpak"  ; name of the contrib devpak
 
  !define wxWidgetsExtrasMSVC_devpak "${wxWidgets_name}_vc_extras.devpak"  ; name of the extras devpak
 
!endif

!define wxWidgetsCommon_devpak "${wxWidgets_name}_common.devpak"  ; name of the common includes devpak

!define wxWidgetsSamples_devpak "${wxWidgets_name}_samples.devpak"  ; name of the samples devpak

Var LOCAL_APPDATA
Var USE_MINGW
Var USE_MSVC
Var RUN_WXDEVCPP
Var RUN_WXBOOK
Var WXBOOK_INSTALLED

!ifdef NEW_INTERFACE
;--------------------------------
;Include Modern UI

  !include "MUI.nsh"
  !include "Sections.nsh"

!endif

  !include "logiclib.nsh" ; needed by ${switch}
;--------------------------------

# [Installer Attributes]

Name "${DISPLAY_NAME}"
!ifdef HAVE_MINGW 
OutFile "${PROGRAM_NAME}-${WXDEVCPP_VERSION}_setup.exe"
!else
OutFile "${PROGRAM_NAME}-${WXDEVCPP_VERSION}_nomingw_setup.exe"
!endif
Caption "${DISPLAY_NAME}"

# [Licence Attributes]
LicenseText "${PROGRAM_NAME} is distributed under the GNU General Public License :"
LicenseData "copying.txt"

# [Directory Selection]
InstallDir "$PROGRAMFILES\Dev-Cpp"
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
InstType "Minimal" ;2

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

  Var STARTMENU_FOLDER

  ; Display custom page which allows user to select which compiler(s) to install for
  Page custom CustomInstallOptions
  
  !define MUI_COMPONENTSPAGE_SMALLDESC

  !insertmacro MUI_PAGE_LICENSE "copying.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  
  !define      MUI_PAGE_CUSTOMFUNCTION_LEAVE dirLeave  ; Check if default directory name is valid

  !define MUI_STARTMENUPAGE_DEFAULTFOLDER ${DEFAULT_START_MENU_DIRECTORY}
  !insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER

  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  
  ; Display custom page which allows user to select which programs to run
  Page custom InstallCompleteOptions

 ; !define MUI_FINISHPAGE_RUN "$INSTDIR\devcpp.exe" 
  
  ;!define MUI_FINISHPAGE_NOREBOOTSUPPORT
  ;!insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
;Languages - Commented out languages are not currently supported by NSIS

  !insertmacro MUI_LANGUAGE "English"
  !insertmacro MUI_LANGUAGE "Bulgarian"
  !insertmacro MUI_LANGUAGE "Catalan"
 ; !insertmacro MUI_LANGUAGE "Chinese"
  ;!insertmacro MUI_LANGUAGE "Chinese_TC"
  !insertmacro MUI_LANGUAGE "Croatian"
  !insertmacro MUI_LANGUAGE "Czech"
  !insertmacro MUI_LANGUAGE "Danish"
  !insertmacro MUI_LANGUAGE "Dutch"
  !insertmacro MUI_LANGUAGE "Estonian"
  !insertmacro MUI_LANGUAGE "French"
  ;!insertmacro MUI_LANGUAGE "Galego"
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
  !insertmacro MUI_LANGUAGE "Russian"
  !insertmacro MUI_LANGUAGE "Slovak"
  !insertmacro MUI_LANGUAGE "Slovenian"
  !insertmacro MUI_LANGUAGE "Spanish"
  ;!insertmacro MUI_LANGUAGE "SpanishCastellano"
  !insertmacro MUI_LANGUAGE "Swedish"
  !insertmacro MUI_LANGUAGE "Turkish"
  !insertmacro MUI_LANGUAGE "Ukrainian"

!endif ;NEW_INTERFACE
;--------------------------------

ReserveFile "CustomInstallPage.ini"
ReserveFile "InstallCompletePage.ini"
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

# [Files]

Section "${PROGRAM_NAME} program files (required)" SectionMain
  SectionIn 1 2 3 RO
  SetOutPath $INSTDIR
 
  File "devcpp.exe"
  File "copying.txt"
  ;File "wxdevcpp ${WXDEVCPP_VERSION} changes.html"
  File "packman.exe"
  SetOutPath $INSTDIR\Lang
  File "Lang\English.*"
  SetOutPath $INSTDIR\Templates
  File "Templates\*"
  SetOutPath $INSTDIR\bin
  File "bin\rm.exe"

  ; Find all installed devpaks and uninstall them
  FindFirst $0 $1 $INSTDIR\Packages\*.entry
loop_devpaks:
  StrCmp $1 "" done_devpaks
  DetailPrint 'Uninstalling package $1'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\$1"'
  FindNext $0 $1
  Goto loop_devpaks
done_devpaks:

  SetOutPath $INSTDIR

  ; All compilers will use the Mingw make system so they all need binutils
  File /r "bin"
  File /r "libexec"
  SetOutPath $INSTDIR\Packages
  File "Packages\binutils.entry"
  File "Packages\make.entry"
 
  SetOutPath $INSTDIR\Packages

  ; Install Dev-C++ examples
  File "Packages\devcpp_examples.DevPak"   ; Copy the devpak over
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /install "$INSTDIR\Packages\devcpp_examples.DevPak"'
  Delete  "$INSTDIR\Packages\devcpp_examples.DevPak"


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

  SetOutPath $INSTDIR

SectionEnd

Section "wxWidgets ${wxWidgets_version} common files" SectionwxWidgetsCommon
  SectionIn 1 2 RO

  SetOutPath $INSTDIR\Packages

  File "Packages\${wxWidgetsCommon_devpak}"   ; Copy the devpak over
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /install "$INSTDIR\Packages\${wxWidgetsCommon_devpak}"'
  Delete  "$INSTDIR\Packages\${wxWidgetsCommon_devpak}"

SectionEnd

SectionGroup /e "Mingw gcc wxWidgets ${wxWidgets_version}" SectionGroupwxWidgetsGCC

!ifdef HAVE_MINGW

Section "Libraries" SectionwxWidgetsMingw

  SectionIn 1 2
  
  SetOutPath $INSTDIR\Packages
  File "Packages\${wxWidgets_mingw_devpak}"   ; Copy the devpak over

  ; Install wxWidgets Mingw gcc library through the devpak
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /install "$INSTDIR\Packages\${wxWidgets_mingw_devpak}"'
  Delete "$INSTDIR\Packages\${wxWidgets_mingw_devpak}"   ; Delete the original devpak (its files should be installed now)

SectionEnd
!endif

Section /o "Contribs" SectionwxWidgetsContribGcc
  SectionIn 1
  
  SetOutPath $INSTDIR\Packages
  
  File "Packages\${wxWidgets_name}_contrib_common.DevPak"   ; Copy the devpak over
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /install "$INSTDIR\Packages\${wxWidgets_name}_contrib_common.DevPak"'
  Delete  "$INSTDIR\Packages\${wxWidgets_name}_contrib_common.DevPak"

  File "Packages\${wxWidgetsContribGcc_devpak}"   ; Copy the devpak over
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /install "$INSTDIR\Packages\${wxWidgetsContribGcc_devpak}"'
  Delete  "$INSTDIR\Packages\${wxWidgetsContribGcc_devpak}"

SectionEnd

Section /o "Extras" SectionwxWidgetsExtrasGcc

  SectionIn 1

  SetOutPath $INSTDIR\Packages

File "Packages\${wxWidgets_name}_extras_common.DevPak"   ; Copy the devpak over
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /install "$INSTDIR\Packages\${wxWidgets_name}_extras_common.DevPak"'
  Delete  "$INSTDIR\Packages\${wxWidgets_name}_extras_common.DevPak"

  File "Packages\${wxWidgetsExtrasGcc_devpak}"   ; Copy the devpak over
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /install "$INSTDIR\Packages\${wxWidgetsExtrasGcc_devpak}"'
  Delete  "$INSTDIR\Packages\${wxWidgetsExtrasGcc_devpak}"

SectionEnd

SectionGroupEnd

!ifdef HAVE_MSVC

SectionGroup /e "MS VC++ 2005 wxWidgets ${wxWidgets_version}" SectionGroupwxWidgetsMSVC

Section /o "Libraries" SectionwxWidgetsMSVC

  SectionIn 1

  SetOutPath $INSTDIR\Packages
  File "Packages\${wxWidgets_msvc_devpak}"   ; Copy the devpak over

  ; Install wxWidgets MS VC 2005 library through the devpak
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /install "$INSTDIR\Packages\${wxWidgets_msvc_devpak}"'
  Delete "$INSTDIR\Packages\${wxWidgets_msvc_devpak}"   ; Delete the original devpak (its files should be installed now)
  
SectionEnd

Section /o "Contribs" SectionwxWidgetsContribMSVC

  SectionIn 1

  SetOutPath $INSTDIR\Packages

  File "Packages\${wxWidgets_name}_contrib_common.DevPak"   ; Copy the devpak over
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /install "$INSTDIR\Packages\${wxWidgets_name}_contrib_common.DevPak"'
  Delete  "$INSTDIR\Packages\${wxWidgets_name}_contrib_common.DevPak"

  File "Packages\${wxWidgetsContribMSVC_devpak}"   ; Copy the devpak over
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /install "$INSTDIR\Packages\${wxWidgetsContribMSVC_devpak}"'
  Delete  "$INSTDIR\Packages\${wxWidgetsContribMSVC_devpak}"

SectionEnd

Section /o "Extras" SectionwxWidgetsExtrasMSVC

  SectionIn 1

  SetOutPath $INSTDIR\Packages

  File "Packages\${wxWidgets_name}_extras_common.DevPak"   ; Copy the devpak over
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /install "$INSTDIR\Packages\${wxWidgets_name}_extras_common.DevPak"'
  Delete  "$INSTDIR\Packages\${wxWidgets_name}_extras_common.DevPak"

  File "Packages\${wxWidgetsExtrasMSVC_devpak}"   ; Copy the devpak over
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /install "$INSTDIR\Packages\${wxWidgetsExtrasMSVC_devpak}"'
  Delete  "$INSTDIR\Packages\${wxWidgetsExtrasMSVC_devpak}"

SectionEnd
SectionGroupEnd

!endif

Section "Samples" SectionwxWidgetsSamples

  SectionIn 1

  SetOutPath $INSTDIR\Packages

  File "Packages\${wxWidgetsSamples_devpak}"   ; Copy the devpak over
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /install "$INSTDIR\Packages\${wxWidgetsSamples_devpak}"'
  Delete  "$INSTDIR\Packages\${wxWidgetsSamples_devpak}"

SectionEnd


!ifdef HAVE_MINGW
Section "Mingw compiler system (headers and libraries)" SectionMingw
  SectionIn 1 2
  SetOutPath $INSTDIR
  
  File /r "include"
  File /r "lib"
  File /r "mingw32"
  SetOutPath $INSTDIR\Packages
  File "Packages\gcc-core.entry"
  File "Packages\gcc-g++.entry"
  File "Packages\gdb.entry"
  File "Packages\mingw-runtime.entry"
  File "Packages\w32api.entry"
  
  ; Add links to START MENU
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  
   ;try to read from registry if last installation installed for All Users/Current User
  ReadRegStr $0 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}\Backup" \
      "Shortcuts"
  StrCmp $0 "" cont exists
  cont:

  SetShellVarContext all
  MessageBox MB_YESNO "Do you want to install ${PROGRAM_NAME} for all users on this computer ?" IDYES AllUsers
  SetShellVarContext current

AllUsers:
  StrCpy $0 "$SMPROGRAMS\$STARTMENU_FOLDER"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}\Backup" \
      "Shortcuts" "$0"

exists:

  CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"
  SetOutPath $INSTDIR
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\${PROGRAM_NAME}.lnk" "$INSTDIR\devcpp.exe"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\License.lnk" "$INSTDIR\copying.txt"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall ${PROGRAM_NAME}.lnk" "$INSTDIR\uninstall.exe"
  
!insertmacro MUI_STARTMENU_WRITE_END

  SetOutPath $INSTDIR
  
SectionEnd
!endif

SectionGroup /e "Help files" SectionGroupHelp

Section /o "${PROGRAM_NAME} help" SectionHelp

  SectionIn 1 2
  SetOutPath $INSTDIR\Help
  File "Help\DevCpp.hlp"
  File "Help\DevCpp.cnt"
  SetOutPath $INSTDIR\Packages
  File "Packages\DevCppHelp.entry"

  ; Added for wx-devcpp  -- START
  SetOutPath $INSTDIR\Help
  File "Help\wx.gid"
  File "Help\devhelp.ini"
  File "Help\wx-devcpp Tutorial Help.chm"
  File "Help\wx.hlp"
  File "Help\wx.chm"
  ; Added for wx-devcpp  -- END

  SetOutPath $INSTDIR

SectionEnd

Section /o "Sof.T's ${PROGRAM_NAME} Book" SectionWxBook

  SectionIn 1

  SetOutPath $INSTDIR\Help
  File "Help\Programming with wxDev-C++.pdf"
  
  StrCpy $WXBOOK_INSTALLED "Yes"
  
  SetOutPath $INSTDIR
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Sof.T's ${PROGRAM_NAME} Book.lnk" "$INSTDIR\Help\Programming with wxDev-C++.pdf"
  
SectionEnd

SectionGroupEnd

Section "Icon files" SectionIcons
  SectionIn 1 2
  SetOutPath $INSTDIR\Icons
  File "Icons\*.ico"

  SetOutPath $INSTDIR

SectionEnd

Section "Language files" SectionLangs
  SectionIn 1
  SetOutPath $INSTDIR\Lang
  File "Lang\*"
  
  SetOutPath $INSTDIR
  
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
  
  SetOutPath $INSTDIR
  
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
  
  SetOutPath $INSTDIR
  
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
  
  SetOutPath $INSTDIR
  
SectionEnd

Section "Associate .h files to ${PROGRAM_NAME}"
  SectionIn 1 2

  StrCpy $0 ".h"
  Call BackupAssoc

  StrCpy $0 $INSTDIR\DevCpp.exe
  WriteRegStr HKCR ".h" "" "${PROGRAM_NAME}.h"
  WriteRegStr HKCR "${PROGRAM_NAME}.h" "" "C Header File"
  WriteRegStr HKCR "${PROGRAM_NAME}.h\DefaultIcon" "" '$0,6'
  WriteRegStr HKCR "${PROGRAM_NAME}.h\Shell\Open\Command" "" '$0 "%1"'
  Call RefreshShellIcons
  
  SetOutPath $INSTDIR
  
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
  
  SetOutPath $INSTDIR
  
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
  
  SetOutPath $INSTDIR
  
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
  
  SetOutPath $INSTDIR
  
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
  
  SetOutPath $INSTDIR
  
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
  
  SetOutPath $INSTDIR
  
SectionEnd

SubSectionEnd

Section "Create Quick Launch shortcut" SectionQuickLaunch
  SectionIn 1 2
  SetShellVarContext current
  CreateShortCut "$QUICKLAUNCH\${PROGRAM_NAME}.lnk" "$INSTDIR\devcpp.exe"
  
  SetOutPath $INSTDIR
  
SectionEnd

Section "Debug files" SectionDebug
  SectionIn 1
  SetOutPath $INSTDIR
  ;File "devcpp.map"
  File "Packman.map"
  SetOutPath $INSTDIR\Packages
  File "Packages\Dev-C++_Map.entry"
  
  SetOutPath $INSTDIR
  
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
  
  SetOutPath $INSTDIR
  
SectionEnd

; Custom Install Options Page allows the user to select programs to run after installation
Function InstallCompleteOptions

  !insertmacro MUI_INSTALLOPTIONS_EXTRACT "InstallCompletePage.ini"

  !insertmacro MUI_HEADER_TEXT "Installation complete for ${PROGRAM_NAME}" "Do you want to run the programs now?"
  
  !insertmacro MUI_INSTALLOPTIONS_WRITE "InstallCompletePage.ini" "Field 2" "Flags" ""

  StrCmp $WXBOOK_INSTALLED "No" 0 +3   ; If wx pdf book isn't installed, then don't give that option
  !insertmacro MUI_INSTALLOPTIONS_WRITE "InstallCompletePage.ini" "Field 2" "State" "0"
  !insertmacro MUI_INSTALLOPTIONS_WRITE "InstallCompletePage.ini" "Field 2" "Flags" "DISABLED"
  
  !insertmacro MUI_INSTALLOPTIONS_DISPLAY "InstallCompletePage.ini"

  ;Read a value from an CustomInstallPage INI file
  !insertmacro MUI_INSTALLOPTIONS_READ $RUN_WXDEVCPP "InstallCompletePage.ini" "Field 1" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $RUN_WXBOOK "InstallCompletePage.ini" "Field 2" "State"

  StrCmp $RUN_WXBOOK "1" 0 +3
  ReadRegStr $R0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\AcroRd32.exe" "Path" ; Find Adobe Acrobat install path
  Exec '"$R0\acrord32.exe" "$INSTDIR\Help\Programming with wxDev-C++.pdf"'
 
  StrCmp $RUN_WXDEVCPP "1" 0 +2
  Exec '"$INSTDIR\devcpp.exe"'

FunctionEnd

; Custom Install Options Page allows the user to select which compiler(s) to use
Function CustomInstallOptions

  !insertmacro MUI_HEADER_TEXT "$(TEXT_IO_TITLE)" "$(TEXT_IO_SUBTITLE)"
  !insertmacro MUI_INSTALLOPTIONS_DISPLAY "CustomInstallPage.ini"
  
  ;Read a value from an CustomInstallPage INI file
  !insertmacro MUI_INSTALLOPTIONS_READ $USE_MINGW "CustomInstallPage.ini" "Field 2" "State"
  !insertmacro MUI_INSTALLOPTIONS_READ $USE_MSVC "CustomInstallPage.ini" "Field 3" "State"

  StrCpy $WXBOOK_INSTALLED "No" ; Initialize variable

  ; Select the compiler sections according to which compiler types the user has chosen
  SectionSetFlags ${SectionwxWidgetsMingw} $USE_MINGW
  SectionSetFlags ${SectionwxWidgetsContribGcc} $USE_MINGW
  SectionSetFlags ${SectionwxWidgetsExtrasGcc} $USE_MINGW
  
  SectionSetFlags ${SectionwxWidgetsMSVC} $USE_MSVC
  SectionSetFlags ${SectionwxWidgetsContribMSVC} $USE_MSVC
  SectionSetFlags ${SectionwxWidgetsExtrasMSVC} $USE_MSVC
  
  StrCmp $USE_MSVC "1" 0 +2
    Call CheckMSVC   ; Check to see if user really has MSVC installed

FunctionEnd

;--------------------------------

# [Sections' descriptions (on mouse over)]
!ifdef NEW_INTERFACE

  LangString TEXT_IO_TITLE ${LANG_ENGLISH} "InstallOptions page"
  LangString TEXT_IO_SUBTITLE ${LANG_ENGLISH} "Compiler Selection for ${PROGRAM_NAME}"

  LangString DESC_SectionMain ${LANG_ENGLISH} "The ${PROGRAM_NAME} IDE (Integrated Development Environment), package manager and templates"
  
  LangString DESC_SectionwxWidgetsCommon ${LANG_ENGLISH} "wxWidgets version ${wxWidgets_version} common include files. All compilers use these files."

!ifdef HAVE_MINGW
  LangString DESC_SectionGroupwxWidgetsGCC ${LANG_ENGLISH} "wxWidgets version ${wxWidgets_version} for Mingw gcc"
  LangString DESC_SectionwxWidgetsMingw ${LANG_ENGLISH} "wxWidgets version ${wxWidgets_version} libraries compiled with Mingw gcc"
  LangString DESC_SectionMingw ${LANG_ENGLISH} "The MinGW gcc compiler and associated tools, headers and libraries"
  LangString DESC_SectionwxWidgetsContribGcc ${LANG_ENGLISH} "wxWidgets version ${wxWidgets_version} contrib directory for Mingw gcc"
  LangString DESC_SectionwxWidgetsExtrasGcc ${LANG_ENGLISH} "wxWidgets version ${wxWidgets_version} extras directory"
!endif
!ifdef HAVE_MSVC
  LangString DESC_SectionGroupwxWidgetsMSVC ${LANG_ENGLISH} "wxWidgets version ${wxWidgets_version} for MS VC++ 2005"
  LangString DESC_SectionwxWidgetsMSVC ${LANG_ENGLISH} "wxWidgets version ${wxWidgets_version} libraries compiled with MS VC 2005"
  LangString DESC_SectionwxWidgetsContribMSVC ${LANG_ENGLISH} "wxWidgets version ${wxWidgets_version} contrib directory for MS VC++ 2005"
  LangString DESC_SectionwxWidgetsExtrasMSVC ${LANG_ENGLISH} "wxWidgets version ${wxWidgets_version} extras directory for MS VC++ 2005"
!endif

  LangString DESC_SectionwxWidgetsSamples ${LANG_ENGLISH} "wxWidgets version ${wxWidgets_version} samples directory"
  
  LangString DESC_SectionGroupHelp ${LANG_ENGLISH} "Documentation for ${PROGRAM_NAME}"
  LangString DESC_SectionHelp ${LANG_ENGLISH} "Help on using ${PROGRAM_NAME} and programming in C"
  LangString DESC_SectionWxBook ${LANG_ENGLISH} "Sof.T's book on using ${PROGRAM_NAME} and programming in C/C++"
  LangString DESC_SectionIcons ${LANG_ENGLISH} "Various icons that you can use in your programs"

  LangString DESC_SectionLangs ${LANG_ENGLISH} "The ${PROGRAM_NAME} interface translated to different languages (other than English which is built-in)"
  LangString DESC_SectionAssocs ${LANG_ENGLISH} "Use ${PROGRAM_NAME} as the default application for opening these types of files"
  LangString DESC_SectionShortcuts ${LANG_ENGLISH} "Create a '${PROGRAM_NAME}' program group with shortcuts, in the start menu"
  LangString DESC_SectionQuickLaunch ${LANG_ENGLISH} "Create a shortcut to ${PROGRAM_NAME} in the QuickLaunch toolbar"
  LangString DESC_SectionDebug ${LANG_ENGLISH} "Debug file to help debugging ${PROGRAM_NAME}"
  LangString DESC_SectionConfig ${LANG_ENGLISH} "Remove all previous configuration files"

  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionMain} $(DESC_SectionMain)
    
     !insertmacro MUI_DESCRIPTION_TEXT ${SectionwxWidgetsCommon} $(DESC_SectionwxWidgetsCommon)

!ifdef HAVE_MINGW
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionGroupwxWidgetsGCC} $(DESC_SectionGroupwxWidgetsGCC)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionwxWidgetsMingw} $(DESC_SectionwxWidgetsMingw)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionMingw} $(DESC_SectionMingw)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionwxWidgetsContribGcc} $(DESC_SectionwxWidgetsContribGcc)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionwxWidgetsExtrasGcc} $(DESC_SectionwxWidgetsExtrasGcc)
!endif
!ifdef HAVE_MSVC
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionGroupwxWidgetsMSVC} $(DESC_SectionGroupwxWidgetsMSVC)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionwxWidgetsMSVC} $(DESC_SectionwxWidgetsMSVC)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionwxWidgetsContribMSVC} $(DESC_SectionwxWidgetsContribMSVC)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionwxWidgetsExtrasMSVC} $(DESC_SectionwxWidgetsExtrasMSVC)
!endif

    !insertmacro MUI_DESCRIPTION_TEXT ${SectionGroupwxWidgetsExamples} $(DESC_SectionGroupwxWidgetsExamples)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionwxWidgetsSamples} $(DESC_SectionwxWidgetsSamples)
    
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionGroupHelp} $(DESC_SectionGroupHelp)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionHelp} $(DESC_SectionHelp)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionWxBook} $(DESC_SectionWxBook)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionIcons} $(DESC_SectionIcons)

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

  MessageBox MB_OK "Welcome to ${PROGRAM_NAME} install program.$\r$\nPlease do not install this version of ${PROGRAM_NAME} over an existing installation$\r$\n(i.e. uninstall DevCpp and/or wx-devcpp beforehand)."
 
  !insertmacro MUI_LANGDLL_DISPLAY

  !insertmacro MUI_INSTALLOPTIONS_EXTRACT "CustomInstallPage.ini"

  SetCurInstType 0  ; Indexed from 0

FunctionEnd

Function .onSelChange

   Call CheckMSVC ; Check to see if we've selected to install wxWidgets devpak with MS VC++

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
  ReadRegStr $1 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}\Backup" "$0"
  ;don't backup if backup exists in registry
  StrCmp $1 "" 0 no_assoc

  ReadRegStr $1 HKCR "$0" ""
  ;don't backup dev-cpp associations
  StrCmp $1 "DevCpp$0" no_assoc

  StrCmp $1 "" no_assoc
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}\Backup" "$0" "$1"
  no_assoc:
  
FunctionEnd

;restore file association
Function un.RestoreAssoc
  ;$0 is an extension - for example ".dev"

  DeleteRegKey HKCR "$0"
  ReadRegStr $1 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}\Backup" "$0"
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

#Check to see if user wants the MS VC++ devpak. If so, message box to remind him to download the SDK and compiler
Function CheckMSVC

  SectionGetFlags ${SectionwxWidgetsMSVC} $R0  ; Is wxWidgetsMSVC section is checked?
  IntOp $R0 $R0 & ${SF_SELECTED}
  IntCmp $R0 ${SF_SELECTED} detectvc

  Abort

detectvc:    ; Try to detect the MS VC compiler
 
  ; VS C++ 8.0 Free Version
  ReadRegStr $0 HKLM "SOFTWARE\Microsoft\VisualStudio\8.0\Setup\VS" "MSMDir"
  IfErrors 0 detectsdk   ; If it's detected, then we probably don't need to remind user to install it.

  ; VS C++ 8.0 Enterprise Version
  ReadRegStr $0 HKLM "SOFTWARE\Microsoft\VisualStudio\8.0\Setup\VS" "ProductDir"
  IfErrors 0 detectsdk   ; If it's detected, then we probably don't need to remind user to install it.

  Goto show
  
detectsdk:    ; Try to detect the MS SDK
  ReadRegStr $0 HKLM "SOFTWARE\Microsoft\VisualStudio\SxS\FrameworkSDK" "8.0"
  IfErrors 0 dontshow  ; If it's detected, then we probably don't need to remind user to install it.

  ReadRegStr $0 HKLM "SOFTWARE\Microsoft\VisualStudio\SxS\FrameworkSDK" "7.1"
  IfErrors 0 dontshow   ; If it's detected, then we probably don't need to remind user to install it.
  
show:
  ;Remind user to download and install MS VC++ and the MS SDK
  MessageBox MB_OK|MB_ICONINFORMATION "You've selected to install the wxWidgets MS VC++ 2005 devpak.$\r$\n\
             If you have the MS VC++ 2005 compiler and MS SDK installed, then please continue.$\r$\n\
             If not, then please download and install before you install ${PROGRAM_NAME}.$\r$\n\
             You can find them at the official Microsoft website.$\r$\n\
             http://msdn.microsoft.com/vstudio/express/visualc/"

dontshow:

FunctionEnd


#Verify the installation directory
Function dirLeave
  Push "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz:-_\ ()"
  Push $INSTDIR
  Call StrCSpnReverse
  Pop $R0
  StrCmp $R0 "" +3
  MessageBox MB_OK|MB_ICONEXCLAMATION "Installation directory cannot contain: '$R0'. Only letters, numbers and ':-_\ ()' are allowed."
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

UninstallText "This program will uninstall ${PROGRAM_NAME}. Continue ?"
ShowUninstDetails show

Section "Uninstall"

  ; Remove files and uninstaller
  Delete "$INSTDIR\uninstall.exe"
  !include ".\installed_files.nsh"

  ; Remove icons
  ReadRegStr $0 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}\Backup" \
     "Shortcuts"
     
  ; Determine if the STARUP_MENU DIRECTORY was created during install
  StrCmp $0 "" bypass_startupmenu remove_startupmenu
remove_startupmenu:
  Delete "$0\${PROGRAM_NAME}.lnk"
  Delete "$0\License.lnk"
  Delete "$0\Uninstall ${PROGRAM_NAME}.lnk"
  RMDir  "$0"
  
bypass_startupmenu:
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
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}"
  DeleteRegKey HKLM "SOFTWARE\${PROGRAM_NAME}"

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
  MessageBox MB_OK "${PROGRAM_NAME} has been uninstalled.$\r$\nPlease now delete the $INSTDIR directory if it doesn't contain some of your documents"

SectionEnd

#eof!
