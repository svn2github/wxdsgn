//---------------------------------------------------------------------------
//
// Name:        matterDlgApp.cpp
// Author:      Guru Kathiresan
// Created:     12/10/2003 9:47:07 PM
// Copyright:
//
//---------------------------------------------------------------------------
#include "newProgramApp.h"
#include "newProgramDlg.h"

IMPLEMENT_APP(newProgramApp)

bool newProgramApp::OnInit()
{
	newProgramDlg *myDlg = new  newProgramDlg(NULL);
	SetTopWindow(myDlg);
	myDlg->Show(TRUE);		
	return TRUE;
}
 
