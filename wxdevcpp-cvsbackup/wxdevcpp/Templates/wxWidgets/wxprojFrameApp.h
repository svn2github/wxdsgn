//---------------------------------------------------------------------------
//
// Name:        %PROJECT_NAME%App.h
// Author:      %AUTHOR_NAME%
// Created:     %DATE_STRING%
//
//---------------------------------------------------------------------------

// For compilers that support precompilation, includes "wx.h".
#include <wx/wxprec.h>

#ifdef __BORLANDC__
#pragma hdrstop
#endif

#ifndef WX_PRECOMP
// Include your minimal set of headers here, or wx.h
#include <wx/wx.h>
#endif

class %CLASS_NAME%App:public wxApp
{
public:
	bool OnInit();
	int OnExit();
};

 
