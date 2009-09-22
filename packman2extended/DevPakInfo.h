///---------------------------------------------------------------------------
///
/// @file     DevPakInfo.h
/// @author   Tony Reina and Edward Toovey (Sof.T)
/// Created:  9/2/2008 07:54:34 PM
/// @section  DESCRIPTION
///           DevPak info class
/// @section LICENSE  wxWidgets license
/// @version $Id$
///
///---------------------------------------------------------------------------

#ifndef __DEVPAKINFO_h__
#define __DEVPAKINFO_h__

#ifndef WX_PRECOMP
#include <wx/wx.h>
#include <wx/dialog.h>
#else
#include <wx/wxprec.h>
#endif

/**
 * DevPak information class structure
*/
class DevPakInfo {
private:
    wxString EntryFileName;

public:
    /** Current state of the devpak installation.
    *   Values are COMPLETED, IN_PROCESS, ABORTED, ERROR_STATE
    */
    enum StatusType { COMPLETED, IN_PROCESS, ABORTED, ERROR_STATE};

public:
    DevPakInfo(); // constructor
    wxString AppName, /** \brief DevPak name */
    AppVerName,       /** \brief DevPak name + version */
    AppVersion,       /** \brief DevPak version */
    MenuName,         /** \brief name of associated menu */
    Description,      /** \brief Description of devpak */
    Url,              /** \brief Internet address associated with devpak */
    Readme,           /** \brief Readme file for devpak */
    License,          /** \brief License file for devpak */
    Picture,          /** \brief Graphic file for devpak */
    Dependencies;     /** \brief Files required by devpak */
    wxArrayString TargetDirs,
    /** \brief Absolute file path name within devpak */
    DestinationDirs,
    /** \brief Relative file path indicating where to install file */
    InstalledFiles;
    /** \brief List of files that were installed from devpak */
    size_t currentFileNumber;
    /** \brief Index of current file being installed. */
    StatusType pakStatus;
    /** \brief Status of devpak installation */
    bool Reboot;           /** \brief Reboot needed after installation? */

public:
    bool SetEntryFileName(wxString filename);
    wxString GetEntryFileName();

};

#endif
