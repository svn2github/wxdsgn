//---------------------------------------------------------------------------
//
// Name:        InstallDevPak.h
// Author:      Tony Reina / Edward Toovey (Sof.T)
// Created:     05/06/2008 11:23:34 PM
// Description: DevPak Installation Code Headers.
//     These headers for the InstallDevPak namespace functions.
//---------------------------------------------------------------------------

#ifndef __INSTALLDEVPAK_h__
#define __INSTALLDEVPAK_h__

#include <wx/filedlg.h>
#include <wx/filename.h>
#include <wx/fileconf.h>
#include <wx/filesys.h>
#include <wx/filefn.h>
#include <wx/tarstrm.h>
#include <wx/wfstream.h>
#include <wx/msgdlg.h>
#include <3rdparty/wx/bzipstream.h>
#include <wx/textfile.h>
#include <wx/msw/registry.h>
#include <wx/stdpaths.h>
#include <wx/log.h>
#include <wx/textctrl.h>
#include <wx/listbox.h>

#include "DevPakInfo.h"
#include "RemoveDlg.h"
#include "ErrorDlg.h"

namespace InstallDevPak
{
bool GetPackageInfo(DevPakInfo *info, wxString szFileName);
bool DoSilentInstall(wxFileName filename);  // Silent install routine (no wizard) starts here
bool DoWizardIntall();  // Wizard install routine
bool ExtractPackageINI(const wxString sArchive); // Grab package INI descriptor
bool GetINIFileList(wxString INIFileName, DevPakInfo *info); // Grab list of archived files/directories
wxString GetAppDir(); // Grab the <app> directory from the Windows registry
bool ReadEntryFile(DevPakInfo *info);
bool SaveEntryFileSetup(DevPakInfo *info);
bool ProcessDirs(wxString archiveDir, DevPakInfo *info); //Replace macros in directory names
bool ExtractArchive(const wxString sArchive, DevPakInfo info, wxListBox *lbInstalledFiles); // Un-bzip, un-tar devpak archive and install
bool ExtractArchive(const wxString sArchive, DevPakInfo info); // Un-bzip, un-tar devpak archive and install
bool ExtractSingleFile(const wxString sArchive, wxString sFilename, wxTextCtrl *txtControl);
bool ExtractSingleFile(const wxString sArchive, wxString sFilename);
bool RemoveDevPak(DevPakInfo *info);
bool VerifyDevPak(DevPakInfo *info);
};

#endif
