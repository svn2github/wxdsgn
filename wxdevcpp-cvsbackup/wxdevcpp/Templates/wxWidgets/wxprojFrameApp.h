//---------------------------------------------------------------------------
//
// Name:        %PROJECT_NAME%App.h
// Author:      %AUTHOR_NAME%
// Created:     %DATE_STRING%
//
//---------------------------------------------------------------------------

#include <wx/wxprec.h>
#ifdef __BORLANDC__
        #pragma hdrstop
#endif
#ifndef WX_PRECOMP
        #include <wx/wx.h>
#endif

class %CLASS_NAME%App:public wxApp
{
public:
	bool OnInit();
	int OnExit();
};

 
