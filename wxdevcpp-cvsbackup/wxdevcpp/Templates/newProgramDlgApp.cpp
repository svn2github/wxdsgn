//---------------------------------------------------------------------------
//
// Name:        newProgramDlgApp.cpp
// Author:      Guru Kathiresan
// Created:     12/10/2003 9:47:07 PM
// Copyright:
//
//---------------------------------------------------------------------------
#include "newProgramDlgApp.h"
#include "newProgramDlg.h"

IMPLEMENT_APP(newProgramDlgApp)

bool newProgramDlgApp::OnInit()
{
	newProgramDlg *myDlg = new  newProgramDlg(NULL);
	SetTopWindow(myDlg);
	myDlg->Show(TRUE);		
	return TRUE;
}
 
int newProgramDlgApp::OnExit()
{
	return 0;
}