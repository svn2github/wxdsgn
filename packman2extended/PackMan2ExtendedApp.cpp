//---------------------------------------------------------------------------
//
// Name:        PackMan2ExtendedApp.cpp
// Author:      Tony Reina / Edward Toovey (Sof.T)
// Created:     3/18/2008 1:46:39 PM
// Description:
//
//---------------------------------------------------------------------------

#include "PackMan2ExtendedApp.h"
#include "PackMan2ExtendedFrm.h"

IMPLEMENT_APP(PackMan2ExtendedFrmApp)

bool PackMan2ExtendedFrmApp::OnInit()
{
    PackMan2ExtendedFrm* frame = new PackMan2ExtendedFrm(NULL);
    SetTopWindow(frame);
    frame->Show();
    return true;
}

int PackMan2ExtendedFrmApp::OnExit()
{
    return 0;
}
