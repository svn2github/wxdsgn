//---------------------------------------------------------------------------
//
// Name:        %PROJECT_NAME%App.h
// Author:      %AUTHOR_NAME%
// Created:     %DATE_STRING%
//
//---------------------------------------------------------------------------

// For compilers that support precompilation, includes "wx.h".
#include <wx/wxprec.h>

#include "%DEVCPP_DIR%Templates\wxWidgets\wx_precompiled_headers.h"

class %CLASS_NAME%App:public wxApp
{
public:
	bool OnInit();
	int OnExit();
};

 
