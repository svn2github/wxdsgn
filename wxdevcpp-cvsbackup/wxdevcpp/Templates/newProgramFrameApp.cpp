//---------------------------------------------------------------------------
//
// Name:        newProgramFrameApp.cpp
// Author:      Guru Kathiresan
// Created:     12/10/2003 9:47:07 PM
// Copyright:
//
//---------------------------------------------------------------------------
#include "newProgramFrameApp.h"
#include "newProgramFrame.h"

IMPLEMENT_APP(newProgramFrameApp)

bool newProgramFrameApp::OnInit()
{
	newProgramFrame *myFrame = new  newProgramFrame(NULL);
	SetTopWindow(myFrame);
	myFrame->Show(TRUE);		
	return TRUE;
}
 
int newProgramFrameApp::OnExit()
{
	return 0;
}
