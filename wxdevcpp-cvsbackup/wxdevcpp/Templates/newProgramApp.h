//---------------------------------------------------------------------------
//
// Name:        mbxApp.h
// Author:      Guru Kathiresan
// Created:     12/10/2003 9:47:07 PM
// Copyright:
//
//---------------------------------------------------------------------------


#include <wx/wx.h>

class newProgramApp:public wxApp
{
public:
	bool OnInit();
	bool OnExceptionInMainLoop();
	int OnExit();
	void OnUnhandledException();
	void HandleEvent(wxEvtHandler *handler, wxEventFunction func, wxEvent& event) const;
};

 
