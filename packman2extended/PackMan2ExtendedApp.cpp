///-------------------------------------------------------------------
///
/// @file        PackMan2ExtendedApp.cpp
/// @author      Tony Reina / Edward Toovey (Sof.T)
/// Created:     3/18/2008 1:46:39 PM
/// @section DESCRIPTION
///          The main PackMan application GUI routines
/// @section LICENSE  wxWidgets license
/// @version $Id$
///-------------------------------------------------------------------

#include "PackMan2ExtendedApp.h"
#include "PackMan2ExtendedFrm.h"
#include <iostream>

IMPLEMENT_APP(PackMan2ExtendedFrmApp)

// parse command line
// PackMan2Extended [/auto] [/quiet] [/silent] [[file] | [/uninstall file [/version number]]]
//   /auto - close packman after finishing
//   /quiet - don't require the user to press any buttons
//   file - filename of the devpak
//   /uninstall file - filename of the *.entry of the devpak to uninstall
//   /version number - check the version number of the *.entry to uninstall (AppVersion)

bool PackMan2ExtendedFrmApp::OnInit()
{

    bQuiet = false;
    // Parse the commandline options
    wxAppConsole::OnInit();

    if (bQuiet) { // Quite mode - No GUIs
        wxMessageBox("Silent running. " + pakFilenames.Item(0));
        InstallDevPak::DoSilentInstall(wxFileName(pakFilenames.Item(0)));
        return false;
    }
    else  // GUI mode
    {
        PackMan2ExtendedFrm* frame = new PackMan2ExtendedFrm(NULL);
        SetTopWindow(frame);
        frame->Show();

        return true;
    }
}

int PackMan2ExtendedFrmApp::OnRun()
{
    int exitcode = wxApp::OnRun();
    return exitcode;
}

void PackMan2ExtendedFrmApp::OnInitCmdLine(wxCmdLineParser& parser)
{
    wxAppConsole::OnInitCmdLine(parser);
    parser.SetDesc (g_cmdLineDesc);
}

bool PackMan2ExtendedFrmApp::OnCmdLineParsed(wxCmdLineParser& parser)
{
    // silent_mode = parser.Found(wxT("s"));
    if (parser.Found(wxT("quiet"))) {

        bQuiet = true;
    }

    // to get at your unnamed parameters use
    wxArrayString inputfiles;
    inputfiles.Clear();
    for (size_t i = 0; i < parser.GetParamCount(); i++)
    {
        inputfiles.Add(parser.GetParam(i));
    }

    // and other command line parameters

    // then do what you need with them.

    pakFilenames = inputfiles;
    if (pakFilenames.Count() == 0) {
        bQuiet = false;
    }

    return wxAppConsole::OnCmdLineParsed(parser);
}

int PackMan2ExtendedFrmApp::OnExit()
{
    return 0;
}
