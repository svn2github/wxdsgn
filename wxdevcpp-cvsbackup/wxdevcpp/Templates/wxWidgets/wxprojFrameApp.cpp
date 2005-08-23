//---------------------------------------------------------------------------
//
// Name:        %PROJECT_NAME%App.cpp
// Author:      %AUTHOR_NAME%
// Created:     %DATE_STRING%
// Description: 
//
//---------------------------------------------------------------------------

#include "%PROJECT_NAME%App.h"
#include "%FILE_NAME%.h"

IMPLEMENT_APP(%CLASS_NAME%App)

bool %CLASS_NAME%App::OnInit()
{
    %CLASS_NAME%* frame = new %CLASS_NAME%(NULL);
    SetTopWindow(frame);
    frame->Show(true);		
    return true;
}
 
int %CLASS_NAME%App::OnExit()
{
	return 0;
}
