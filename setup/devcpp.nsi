;--------------------------------
; $Id$
; Author: Tony Reina
; LGPL license
; NSIS Install Script for wx-devcpp
; http://nsis.sourceforge.net/

!define WXDEVCPP_VERSION "7.0(rc2)"
!define PROGRAM_NAME "wxdevcpp"
!define EXECUTABLE_NAME "wxdevcpp.exe"
!define DEFAULT_START_MENU_DIRECTORY "wxdevcpp"
!define DISPLAY_NAME "${PROGRAM_NAME} ${WXDEVCPP_VERSION}"
!define MSVC_VERSION "9.0" ; 2005 = version 8.0, 2008 = version 9.0
!define MSVC_YEAR "2008"
!define HAVE_MINGW
!define HAVE_MSVC

!define wxWidgets_version "2.8.9"
!define wxWidgets_name "wxWidgets"


!ifdef HAVE_MINGW

  !define wxWidgets_mingw_devpak "${wxWidgets_name}_gcc.devpak" ; name of the wxWidgets Mingw gcc devpak
  
  !define wxWidgetsContribGcc_devpak "${wxWidgets_name}_gcc_contrib.devpak"  ; name of the contrib devpak
 
  !define wxWidgetsExtrasGcc_devpak "${wxWidgets_name}_gcc_extras.devpak"  ; name of the extras devpak
 
!endif

!ifdef HAVE_MSVC

  !define wxWidgets_msvc_devpak "${wxWidgets_name}_vc${MSVC_YEAR}.devpak" ; name of the wxWidgets MS VC devpak
 
  !define wxWidgetsContribMSVC_devpak "${wxWidgets_name}_vc${MSVC_YEAR}_contrib.devpak"  ; name of the contrib devpak
 
  !define wxWidgetsExtrasMSVC_devpak "${wxWidgets_name}_vc${MSVC_YEAR}_extras.devpak"  ; name of the extras devpak
 
!endif

!define wxWidgetsCommon_devpak "${wxWidgets_name}_common.devpak"  ; name of the common includes devpak
!define wxWidgetsSamples_devpak "${wxWidgets_name}_samples.devpak"  ; name of the samples devpak

Var LOCAL_APPDATA
;Var USE_MINGW
;Var USE_MSVC
;Var RUN_WXDEVCPP
;Var RUN_WXBOOK
;Var WXBOOK_INSTALLED

!macro InstallDevPak DEVPAK_NAME
; Installs a wxDev-C++ devpak using the devpak manager

  SetOutPath $INSTDIR\Packages
  File "Packages\${DEVPAK_NAME}"   ; Copy the devpak over -- NOTE: We assume the devpak is located within the PAckages subdirectory when we build the installer
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /install "$INSTDIR\Packages\${DEVPAK_NAME}"'
  Delete  "$INSTDIR\Packages\${DEVPAK_NAME}"
  SetOutPath $INSTDIR
  
!macroend

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"
  !include "Sections.nsh"
  !include "logiclib.nsh" ; needed by ${switch}
;--------------------------------

# [Installer Attributes]

Name "${DISPLAY_NAME}"
!ifdef HAVE_MINGW 
OutFile "${PROGRAM_NAME}_${WXDEVCPP_VERSION}_setup.exe"
!else
OutFile "${PROGRAM_NAME}_${WXDEVCPP_VERSION}_nomingw_setup.exe"
!endif
Caption "${DISPLAY_NAME}"

# [Licence Attributes]
LicenseText "${PROGRAM_NAME} is distributed under the GNU General Public License :"
LicenseData "license.txt"

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

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "wxdevcpp.bmp" ; use our IDE's icon
!define MUI_ABORTWARNING

;--------------------------------

  Var STARTMENU_FOLDER

  !define MUI_COMPONENTSPAGE_SMALLDESC

  !insertmacro MUI_PAGE_LICENSE "license.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  
  !define MUI_STARTMENUPAGE_DEFAULTFOLDER ${DEFAULT_START_MENU_DIRECTORY}
  !insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER

  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  
 ; !define MUI_FINISHPAGE_RUN "$INSTDIR\${EXECUTABLE_NAME}"
  
  ;!define MUI_FINISHPAGE_NOREBOOTSUPPORT
  ;!insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
;Languages - Commented out languages are not currently supported by NSIS

  !insertmacro MUI_LANGUAGE "English"
  !insertmacro MUI_LANGUAGE "Bulgarian"
  !insertmacro MUI_LANGUAGE "Catalan"
  ;!insertmacro MUI_LANGUAGE "Chinese"
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

# [Files]

Section "${PROGRAM_NAME} program files (required)" SectionMain
  SectionIn 1 2 3 RO
  SetOutPath $INSTDIR
 
 ; We just need the license and the Package Manager files.
 ; All other files are contained within devpaks and will be installed by the pakman
  File "license.txt"
  File "packman.exe"

  SetOutPath $INSTDIR\Lang
  ; Basic English language file
  File "Lang\English.lng"
  File "Lang\English.tips"
  
  ; Find all installed devpaks and uninstall them
  FindFirst $0 $1 $INSTDIR\Packages\*.entry
loop_devpaks:
  StrCmp $1 "" done_devpaks
  DetailPrint 'Uninstalling package $1'
  ExecWait '"$INSTDIR\packman.exe" /auto /quiet /uninstall "$INSTDIR\Packages\$1"'
  FindNext $0 $1
  Goto loop_devpaks
done_devpaks:

; Ok, now we should have successfully uninstalled all previously-installed devpaks.

; Install the main IDE devpaks
; We're installing most of the files by using the Package Manager
; This will help us keep tabs on things and make upgrades easier.
; In fact, the InstallDevPak directory can be setup to download a devpak
; if a local version is not available.
  
  ; Install wxDev-C++ executable
 !insertmacro InstallDevPak "wxdevcpp_rc1.devpak"
 
; Install make - All compilers use the Mingw32 GNU make system
 !insertmacro InstallDevPak "make.devpak"

 ; Install binutils
 !insertmacro InstallDevPak "binutils.devpak"

; Install mingw-runtime
  !insertmacro InstallDevPak "mingw-runtime.devpak"

; Install win32-api
  !insertmacro InstallDevPak "win32api.devpak"

  ; Install Dev-C++ examples
  !insertmacro InstallDevPak "devcpp_examples.devpak"

  
  ; Delete old devcpp.map to avoid confusion in bug reports
  Delete "$INSTDIR\devcpp.map"

  SetOutPath $INSTDIR

SectionEnd

SectionGroup /e "wxWidgets ${wxWidgets_version}" SectionGroupwxWidgetsMain

Section "wxWidgets ${wxWidgets_version} common files" SectionwxWidgetsCommon
  SectionIn 1 2

  !insertmacro InstallDevPak ${wxWidgetsCommon_devpak}

SectionEnd

!ifdef HAVE_MINGW
SectionGroup /e "Mingw gcc wxWidgets ${wxWidgets_version}" SectionGroupwxWidgetsGCC

Section "Libraries" SectionwxWidgetsMingw

  SectionIn 1 2
  
  !insertmacro InstallDevPak ${wxWidgets_mingw_devpak}
  
SectionEnd


Section /o "Contribs" SectionwxWidgetsContribGcc
  SectionIn 1
  
  !insertmacro InstallDevPak ${wxWidgets_name}_contrib_common.devpak
  
  !insertmacro InstallDevPak ${wxWidgetsContribGcc_devpak}
 
SectionEnd

Section /o "Extras" SectionwxWidgetsExtrasGcc

  SectionIn 1

  !insertmacro InstallDevPak ${wxWidgets_name}_extras_common.devpak
  
  !insertmacro InstallDevPak ${wxWidgetsExtrasGcc_devpak}
  
SectionEnd

SectionGroupEnd
!endif

!ifdef HAVE_MSVC

SectionGroup /e "MS VC++ ${MSVC_YEAR} wxWidgets ${wxWidgets_version}" SectionGroupwxWidgetsMSVC

Section /o "Libraries" SectionwxWidgetsMSVC

  SectionIn 1

  !insertmacro InstallDevPak ${wxWidgets_msvc_devpak}
  
SectionEnd

Section /o "Contribs" SectionwxWidgetsContribMSVC

  SectionIn 1

  !insertmacro InstallDevPak ${wxWidgets_name}_contrib_common.devpak
  
  !insertmacro InstallDevPak ${wxWidgetsContribMSVC_devpak}
  
SectionEnd

Section /o "Extras" SectionwxWidgetsExtrasMSVC

  SectionIn 1

  !insertmacro InstallDevPak ${wxWidgets_name}_extras_common.devpak
  
  !insertmacro InstallDevPak ${wxWidgetsExtrasMSVC_devpak}
  
SectionEnd
SectionGroupEnd

!endif

Section "Samples" SectionwxWidgetsSamples

  SectionIn 1

  !insertmacro InstallDevPak ${wxWidgetsSamples_devpak}
  
SectionEnd

SectionGroupEnd  ; SectionGroupwxWidgetsMain

!ifdef HAVE_MINGW
Section "Mingw compiler system (headers and libraries)" SectionMingw
  SectionIn 1 2
  
  ; Install gcc-core
  !insertmacro InstallDevPak "gcc-core.devpak"
  
; Install gcc-g++
  !insertmacro InstallDevPak "gcc-g++.devpak"
  
; Install gdb
  !insertmacro InstallDevPak "gdb.devpak"
  
  SetOutPath $INSTDIR
  
SectionEnd
!endif

SectionGroup /e "Help files" SectionGroupHelp

Section /o "${PROGRAM_NAME} help" SectionHelp

  SectionIn 1 2 3 RO
  
; Install wxDevCpp Help Files
  !insertmacro InstallDevPak "DevCppHelp.devpak"
  SetOutPath $INSTDIR

SectionEnd

Section /o "Sof.T's ${PROGRAM_NAME} Book" SectionWxBook

  SectionIn 1

  ; Install SofT's wxDev-C++ programming book
  !insertmacro InstallDevPak "Programming with wxDev-C++.devpak"

  ;StrCpy $WXBOOK_INSTALLED "Yes"

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
  
  !insertmacro InstallDevPak "Language.devpak"
  
  SetOutPath $INSTDIR
  
SectionEnd

# [File association]
SubSection "Associate C and C++ files to ${PROGRAM_NAME}" SectionAssocs

Section "Associate .dev files to ${PROGRAM_NAME}"
  SectionIn 1 2

  StrCpy $0 ".dev"
  Call BackupAssoc

  StrCpy $0 $INSTDIR\${EXECUTABLE_NAME}
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

  StrCpy $0 $INSTDIR\${EXECUTABLE_NAME}
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

  StrCpy $0 $INSTDIR\${EXECUTABLE_NAME}
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

  StrCpy $0 $INSTDIR\${EXECUTABLE_NAME}
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

  StrCpy $0 $INSTDIR\${EXECUTABLE_NAME}
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

  StrCpy $0 $INSTDIR\${EXECUTABLE_NAME}
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

  StrCpy $0 $INSTDIR\${EXECUTABLE_NAME}
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

  StrCpy $0 $INSTDIR\${EXECUTABLE_NAME}
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

  StrCpy $0 $INSTDIR\${EXECUTABLE_NAME}
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
  CreateShortCut "$QUICKLAUNCH\${PROGRAM_NAME}.lnk" "$INSTDIR\${EXECUTABLE_NAME}"
  
  SetOutPath $INSTDIR
  
SectionEnd

Section "Remove all previous configuration files" SectionConfig
   SectionIn 1 2

  Delete "$APPDATA\Dev-Cpp\*.*"

  ;Delete "$APPDATA\Dev-Cpp\devcpp.ini"
  ;Delete "$APPDATA\Dev-Cpp\devcpp.cfg"
  ;Delete "$APPDATA\Dev-Cpp\cache.ccc"
  ;Delete "$APPDATA\Dev-Cpp\defaultcode.cfg"
  ;Delete "$APPDATA\Dev-Cpp\devshortcuts.cfg"
  ;Delete "$APPDATA\Dev-Cpp\classfolders.dcf"
  ;Delete "$APPDATA\Dev-Cpp\mirrors.cfg"
  ;Delete "$APPDATA\Dev-Cpp\tools.ini"
  ;Delete "$APPDATA\Dev-Cpp\devcpp.ci"
  
  Call GetLocalAppData
  Delete "$LOCAL_APPDATA\devcpp.ini"
  Delete "$LOCAL_APPDATA\devcpp.cfg"
  Delete "$LOCAL_APPDATA\cache.ccc"
  Delete "$LOCAL_APPDATA\defaultcode.cfg"
  Delete "$LOCAL_APPDATA\devshortcuts.cfg"
  Delete "$LOCAL_APPDATA\classfolders.dcf"
  Delete "$LOCAL_APPDATA\mirrors.cfg"
  Delete "$LOCAL_APPDATA\tools.ini"
  Delete "$LOCAL_APPDATA\devcpp.ci"
  Delete "$LOCAL_APPDATA\wxdevcpp.ini"
  Delete "$LOCAL_APPDATA\wxdevcpp.cfg"
  Delete "$LOCAL_APPDATA\wxdevcpp.ci"

  Delete "$APPDATA\devcpp.ini"
  Delete "$APPDATA\devcpp.cfg"
  Delete "$APPDATA\cache.ccc"
  Delete "$APPDATA\defaultcode.cfg"
  Delete "$APPDATA\devshortcuts.cfg"
  Delete "$APPDATA\classfolders.dcf"
  Delete "$APPDATA\mirrors.cfg"
  Delete "$APPDATA\tools.ini"
  Delete "$APPDATA\devcpp.ci"
  Delete "$APPDATA\wxdevcpp.ini"
  Delete "$APPDATA\wxdevcpp.cfg"
  Delete "$APPDATA\wxdevcpp.ci"
  
  Delete "$INSTDIR\devcpp.ini"
  Delete "$INSTDIR\devcpp.cfg"
  Delete "$INSTDIR\cache.ccc"
  Delete "$INSTDIR\defaultcode.cfg"
  Delete "$INSTDIR\devshortcuts.cfg"
  Delete "$INSTDIR\classfolders.dcf"
  Delete "$INSTDIR\mirrors.cfg"
  Delete "$INSTDIR\tools.ini"
  Delete "$INSTDIR\devcpp.ci"
  Delete "$INSTDIR\wxdevcpp.ini"
  Delete "$INSTDIR\wxdevcpp.cfg"
  Delete "$INSTDIR\wxdevcpp.ci"
  
  SetOutPath $INSTDIR
  
SectionEnd

;--------------------------------

# [Sections' descriptions (on mouse over)]
  LangString TEXT_IO_SUBTITLE ${LANG_ENGLISH} "Compiler Selection for ${PROGRAM_NAME}"

  LangString DESC_SectionMain ${LANG_ENGLISH} "The ${PROGRAM_NAME} IDE (Integrated Development Environment), package manager and templates"
  
   LangString DESC_SectionGroupwxWidgetsMain ${LANG_ENGLISH} "wxWidgets version ${wxWidgets_version}"

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

;--------------------------------

; Functions
Function .onInstSuccess
; If the installation was successful, then let's write to the registry

; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\${PROGRAM_NAME} "Install_Dir" "$INSTDIR"

  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}" "DisplayName" "${DISPLAY_NAME}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROGRAM_NAME}" "NoRepair" 1
  WriteUninstaller "$INSTDIR\uninstall.exe"

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
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\${PROGRAM_NAME}.lnk" "$INSTDIR\${EXECUTABLE_NAME}"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\License.lnk" "$INSTDIR\copying.txt"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall ${PROGRAM_NAME}.lnk" "$INSTDIR\uninstall.exe"

!insertmacro MUI_STARTMENU_WRITE_END


FunctionEnd


!ifdef HAVE_MSVC
Function .onSelChange

   Call CheckMSVC ; Check to see if we've selected to install wxWidgets devpak with MS VC++

FunctionEnd
!endif

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

!ifdef HAVE_MSVC
#Check to see if user wants the MS VC++ devpak. If so, message box to remind him to download the SDK and compiler
Function CheckMSVC

  SectionGetFlags ${SectionwxWidgetsMSVC} $R0  ; Is wxWidgetsMSVC section is checked?
  IntOp $R0 $R0 & ${SF_SELECTED}
  IntCmp $R0 ${SF_SELECTED} detectvc

  Abort

detectvc:    ; Try to detect the MS VC compiler
 
  ; VS C++ Free Version
  ReadRegStr $0 HKLM "SOFTWARE\Microsoft\VisualStudio\${MSVC_VERSION}\Setup\VS" "MSMDir"
  IfErrors 0 detectsdk   ; If it's detected, then we probably don't need to remind user to install it.

  ; VS C++ Enterprise Version
  ReadRegStr $0 HKLM "SOFTWARE\Microsoft\VisualStudio\${MSVC_VERSION}\Setup\VS" "ProductDir"
  IfErrors 0 detectsdk   ; If it's detected, then we probably don't need to remind user to install it.

  Goto show
  
detectsdk:    ; Try to detect the MS SDK
  ;ReadRegStr $0 HKLM "SOFTWARE\Microsoft\VisualStudio\SxS\FrameworkSDK" "8.0"
  ;IfErrors 0 dontshow  ; If it's detected, then we probably don't need to remind user to install it.

  ;ReadRegStr $0 HKLM "SOFTWARE\Microsoft\VisualStudio\SxS\FrameworkSDK" "7.1"
  ;IfErrors 0 dontshow   ; If it's detected, then we probably don't need to remind user to install it.
  Goto dontshow
  
show:
  ;Remind user to download and install MS VC++ and the MS SDK
  MessageBox MB_OK|MB_ICONINFORMATION "You've selected to install the wxWidgets MS VC++ ${MSVC_YEAR} devpak.$\r$\n\
             If you have the MS VC++ ${MSVC_YEAR} compiler and MS SDK installed, then please continue.$\r$\n\
             If not, then please download and install before you install ${PROGRAM_NAME}.$\r$\n\
             You can find them at the official Microsoft website.$\r$\n\
             http://msdn.microsoft.com/vstudio/express/visualc/"

dontshow:

FunctionEnd
!endif

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
