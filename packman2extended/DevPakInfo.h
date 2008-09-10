//---------------------------------------------------------------------------
//
// Name:        DevPakInfo.h
// Author:      Tony Reina and Edward Toovey (Sof.T)
// Created:     9/2/2008 07:54:34 PM
// Description: DevPak info class
// $Id$
//---------------------------------------------------------------------------

#ifndef __DEVPAKINFO_h__
#define __DEVPAKINFO_h__

#ifndef WX_PRECOMP
#include <wx/wx.h>
#include <wx/dialog.h>
#else
#include <wx/wxprec.h>
#endif

enum StatusType { COMPLETED, IN_PROCESS, ABORTED, ERROR_STATE};

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
