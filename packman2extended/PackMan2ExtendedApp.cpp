//---------------------------------------------------------------------------
//
// Name:        PackMan2ExtendedApp.cpp
// Author:      Tony Reina / Edward Toovey (Sof.T)
// Created:     3/18/2008 1:46:39 PM
// Description:
// $Id$
//---------------------------------------------------------------------------

#include "PackMan2ExtendedApp.h"
#include "PackMan2ExtendedFrm.h"

IMPLEMENT_APP(PackMan2ExtendedFrmApp)

// parse command line
// PackMan2Extended [/auto] [/quiet] [[file] | [/uninstall file [/version number]]]
//   /auto - close packman after finishing
//   /quiet - don't require the user to press any buttons
//   file - filename of the devpak
//   /uninstall file - filename of the *.entry of the devpak to uninstall
//   /version number - check the version number of the *.entry to uninstall (AppVersion)

bool PackMan2ExtendedFrmApp::OnInit()
{
    wxAppConsole::OnInit();
    PackMan2ExtendedFrm* frame = new PackMan2ExtendedFrm(NULL);
    SetTopWindow(frame);
    frame->Show();
    return true;
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
    if (parser.Found(wxT("silent")))
        wxMessageBox("Silent running.");

    // to get at your unnamed parameters use
    wxArrayString inputfiles;
    for (size_t i = 0; i < parser.GetParamCount(); i++)
    {
        inputfiles.Add(parser.GetParam(i));
    }

    // and other command line parameters

    // then do what you need with them.

    return wxAppConsole::OnCmdLineParsed(parser);
}

int PackMan2ExtendedFrmApp::OnExit()
{
    return 0;
}
