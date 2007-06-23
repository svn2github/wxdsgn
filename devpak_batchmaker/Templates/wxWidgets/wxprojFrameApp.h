//---------------------------------------------------------------------------
//
// Name:        %PROJECT_NAME%App.h
// Author:      %AUTHOR_NAME%
// Created:     %DATE_STRING%
// Description: 
//
//---------------------------------------------------------------------------

#ifndef __%CAP_CLASS_NAME%App_h__
#define __%CAP_CLASS_NAME%App_h__

#ifdef __BORLANDC__
	#pragma hdrstop
#endif

#ifndef WX_PRECOMP
	#include <wx/wx.h>
#else
	#include <wx/wxprec.h>
#endif

class %CLASS_NAME%App : public wxApp
{
	public:
		bool OnInit();
		int OnExit();
};

#endif
