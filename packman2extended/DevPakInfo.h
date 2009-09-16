///---------------------------------------------------------------------------
///
/// @file     DevPakInfo.h
/// @author   Tony Reina and Edward Toovey (Sof.T)
/// Created:  9/2/2008 07:54:34 PM
/// @section  DESCRIPTION
///           DevPak info class
/// @section LICENSE  wxWidgets license
/// @version $Id$
///---------------------------------------------------------------------------

#ifndef __DEVPAKINFO_h__
#define __DEVPAKINFO_h__

#ifndef WX_PRECOMP
#include <wx/wx.h>
#include <wx/dialog.h>
#else
#include <wx/wxprec.h>
#endif

/** DevPakInfo contains the devpak information class.
 */

enum StatusType { COMPLETED, IN_PROCESS, ABORTED, ERROR_STATE};

/**
 * DevPak information class structure
*/
class DevPakInfo {
private:
    wxString EntryFileName;

public:

    wxString AppName,
    AppVerName,
    AppVersion,
    MenuName,
    Description,
    Url,
    Readme,
    License,
    Picture,
    Dependencies,
    Reboot;
    wxArrayString TargetDirs,
    DestinationDirs,
    InstalledFiles;
    size_t currentFileNumber;
    StatusType pakStatus;

public:
    bool SetEntryFileName(wxString filename);
    wxString GetEntryFileName();

};

#endif
