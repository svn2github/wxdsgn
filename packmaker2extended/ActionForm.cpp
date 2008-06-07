//---------------------------------------------------------------------------
//
// Name:        ActionForm.cpp
// Author:      Programming
// Created:     16/05/2007 19:37:47
// Description: ActionForm class implementation
//
//---------------------------------------------------------------------------

#include "ActionForm.h"

//Do not add custom headers between
//Header Include Start and Header Include End
//wxDev-C++ designer will remove them
////Header Include Start
////Header Include End

//----------------------------------------------------------------------------
// ActionForm
//----------------------------------------------------------------------------
//Add Custom Events only in the appropriate block.
//Code added in other places will be removed by wxDev-C++
////Event Table Start
BEGIN_EVENT_TABLE(ActionForm,wxFrame)
	////Manual Code Start
	////Manual Code End
	
	EVT_CLOSE(ActionForm::OnClose)
END_EVENT_TABLE()
////Event Table End

ActionForm::ActionForm(wxWindow *parent, wxWindowID id, const wxString &title, const wxPoint &position, const wxSize& size, long style)
: wxFrame(parent, id, title, position, size, style)
{
	CreateGUIControls();
}

ActionForm::~ActionForm()
{
}

void ActionForm::CreateGUIControls()
{
	//Do not add custom code between
	//GUI Items Creation Start and GUI Items Creation End
	//wxDev-C++ designer will remove them.
	//Add the custom code before or after the blocks
	////GUI Items Creation Start

	WxPanel1 = new wxPanel(this, ID_WXPANEL1, wxPoint(0,0), wxSize(246,119));
	WxPanel1->SetFont(wxFont(9, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Segoe UI")));

	WxStaticBox1 = new wxStaticBox(WxPanel1, ID_WXSTATICBOX1, wxT(" What would you like to do ? "), wxPoint(6,7), wxSize(232,72));
	WxStaticBox1->SetFont(wxFont(9, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Segoe UI")));

	WxRadioButton1 = new wxRadioButton(WxPanel1, ID_WXRADIOBUTTON1, wxT("&Create a new package"), wxPoint(16,29), wxSize(182,17), 0, wxDefaultValidator, wxT("WxRadioButton1"));
	WxRadioButton1->SetFont(wxFont(9, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Segoe UI")));

	WxRadioButton2 = new wxRadioButton(WxPanel1, ID_WXRADIOBUTTON2, wxT("&Open an existing package"), wxPoint(16,53), wxSize(158,17), 0, wxDefaultValidator, wxT("WxRadioButton2"));
	WxRadioButton2->SetFont(wxFont(9, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Segoe UI")));

	btnOK = new wxButton(WxPanel1, ID_BTNOK, wxT("OK"), wxPoint(33,86), wxSize(75,25), 0, wxDefaultValidator, wxT("btnOK"));
	btnOK->SetFont(wxFont(9, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Segoe UI")));

	btnCancel = new wxButton(WxPanel1, ID_BTNCANCEL, wxT("Cancel"), wxPoint(133,86), wxSize(75,25), 0, wxDefaultValidator, wxT("btnCancel"));
	btnCancel->SetFont(wxFont(9, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Segoe UI")));

	SetTitle(wxT("Choose an Action"));
	SetIcon(wxNullIcon);
	SetSize(8,8,254,146);
	Center();
	
	////GUI Items Creation End
}

void ActionForm::OnClose(wxCloseEvent& event)
{
	Destroy();
}
