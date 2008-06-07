//---------------------------------------------------------------------------
//
// Name:        ActionDlg.cpp
// Author:      Programming
// Created:     19/05/2007 16:16:47
// Description: ActionDlg class implementation
//
//---------------------------------------------------------------------------

#include "ActionDlg.h"

//Do not add custom headers
//wxDev-C++ designer will remove them
////Header Include Start
////Header Include End

//----------------------------------------------------------------------------
// ActionDlg
//----------------------------------------------------------------------------
//Add Custom Events only in the appropriate block.
//Code added in other places will be removed by wxDev-C++
////Event Table Start
BEGIN_EVENT_TABLE(ActionDlg,wxDialog)
	////Manual Code Start
	////Manual Code End
	
	EVT_CLOSE(ActionDlg::OnClose)
	EVT_BUTTON(ID_BTNOK,ActionDlg::btnOKClick)
END_EVENT_TABLE()
////Event Table End

ActionDlg::ActionDlg(wxWindow *parent, wxWindowID id, const wxString &title, const wxPoint &position, const wxSize& size, long style)
: wxDialog(parent, id, title, position, size, style)
{
	CreateGUIControls();
}

ActionDlg::~ActionDlg()
{
} 

void ActionDlg::CreateGUIControls()
{
	//Do not add custom code between
	//GUI Items Creation Start and GUI Items Creation End.
	//wxDev-C++ designer will remove them.
	//Add the custom code before or after the blocks
	////GUI Items Creation Start

	SetTitle(wxT("Choose an Action"));
	SetIcon(wxNullIcon);
	SetSize(8,8,209,204);
	Center();
	

	wxSaveAsDefault = new wxCheckBox(this, ID_WXSAVEASDEFAULT, wxT("Save above option as &default"), wxPoint(13,112), wxSize(169,17), 0, wxDefaultValidator, wxT("wxSaveAsDefault"));
	wxSaveAsDefault->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	chkWizard = new wxCheckBox(this, ID_CHKWIZARD, wxT("Use &Wizard based interface"), wxPoint(13,91), wxSize(166,17), 0, wxDefaultValidator, wxT("chkWizard"));
	chkWizard->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	WxStaticBox2 = new wxStaticBox(this, ID_WXSTATICBOX2, wxT(" Additional Options "), wxPoint(5,71), wxSize(190,66));
	WxStaticBox2->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	btnCancel = new wxButton(this, wxID_CANCEL, wxT("Cancel"), wxPoint(110,149), wxSize(61,20), 0, wxDefaultValidator, wxT("btnCancel"));
	btnCancel->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	btnOK = new wxButton(this, ID_BTNOK, wxT("OK"), wxPoint(29,149), wxSize(61,20), 0, wxDefaultValidator, wxT("btnOK"));
	btnOK->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	WxRadioButton2 = new wxRadioButton(this, ID_WXRADIOBUTTON2, wxT("&Open an existing package"), wxPoint(13,43), wxSize(166,14), 0, wxDefaultValidator, wxT("WxRadioButton2"));
	WxRadioButton2->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	WxRadioButton1 = new wxRadioButton(this, ID_WXRADIOBUTTON1, wxT("&Create a new package"), wxPoint(13,24), wxSize(148,13), 0, wxDefaultValidator, wxT("WxRadioButton1"));
	WxRadioButton1->SetValue(true);
	WxRadioButton1->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	WxStaticBox1 = new wxStaticBox(this, ID_WXSTATICBOX1, wxT(" What would you like to do ? "), wxPoint(5,6), wxSize(190,58));
	WxStaticBox1->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));
	////GUI Items Creation End
}

void ActionDlg::OnClose(wxCloseEvent& /*event*/)
{
	Destroy();
}

/*
 * btnOKClick
 */
void ActionDlg::btnOKClick(wxCommandEvent& event)
{
	// insert your code here
	if(WxRadioButton1->GetValue())
	   EndModal(CREATE_PACKAGE);
	else
	   EndModal(OPEN_PACKAGE);
}

/*
 * chkWizardClick
 */
void ActionDlg::chkWizardClick(wxCommandEvent& event)
{
	// insert your code here
}
