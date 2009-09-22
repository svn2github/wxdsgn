///-------------------------------------------------------------------
///
/// @file        PackMan2ExtendedApp.h
/// @author      Tony Reina / Edward Toovey (Sof.T)
/// Created:     3/18/2008 1:46:39 PM
/// @section     DESCRIPTION
///              The main GUI implementation
/// @section LICENSE  wxWidgets license
//// @version $Id$
///-------------------------------------------------------------------

#ifndef __PACKMAN2EXTENDEDFRMApp_h__
#define __PACKMAN2EXTENDEDFRMApp_h__

#ifdef __BORLANDC__
#pragma hdrstop
#endif

#ifndef WX_PRECOMP
#include <wx/wx.h>
#else
#include <wx/wxprec.h>
#endif

#include <wx/cmdline.h>

class PackMan2ExtendedFrmApp : public wxApp
{
public:
    bool OnInit();
    int OnExit();
    virtual int OnRun();
    virtual void OnInitCmdLine(wxCmdLineParser& parser);
    virtual bool OnCmdLineParsed(wxCmdLineParser& parser);

    bool bQuiet; /** \brief Run program without GUI */
    wxArrayString pakFilenames; /** \brief DevPak filenames to process */
};

// PackMan2Extended [/auto] [/quiet] [[file] | [/uninstall file [/version number]]]
//   /auto - close packman after finishing
//   /quiet - don't require the user to press any buttons
//   file - filename of the devpak
//   /uninstall file - filename of the *.entry of the devpak to uninstall
//   /version number - check the version number of the *.entry to uninstall (AppVersion)

// Command line arguments
static const wxCmdLineEntryDesc g_cmdLineDesc [] =
{
    { wxCMD_LINE_SWITCH, wxT("auto"), wxT("auto"), wxT("Close packman after finishing")},
    { wxCMD_LINE_SWITCH, wxT("quiet"), wxT("quiet"), wxT("No user input required") },
    { wxCMD_LINE_SWITCH, wxT("version"), wxT("version"), wxT("Version") },
    { wxCMD_LINE_PARAM,  NULL, NULL, "input file", wxCMD_LINE_VAL_STRING, wxCMD_LINE_PARAM_OPTIONAL },
    { wxCMD_LINE_NONE }
};

#endif
