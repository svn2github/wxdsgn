//---------------------------------------------------------------------------
//
// Name:        PackMan2ExtendedApp.h
// Author:      Tony Reina / Edward Toovey (Sof.T)
// Created:     3/18/2008 1:46:39 PM
// Description:
//
//---------------------------------------------------------------------------

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

class PackMan2ExtendedFrmApp : public wxApp
{
public:
    bool OnInit();
    int OnExit();
};

#endif
