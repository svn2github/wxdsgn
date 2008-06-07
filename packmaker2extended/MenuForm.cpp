//---------------------------------------------------------------------------
//
// Name:        MenuForm.cpp
// Author:      Programming
// Created:     16/05/2007 20:01:05
// Description: MenuForm class implementation
//
//---------------------------------------------------------------------------

#include "MenuForm.h"

//Do not add custom headers
//wxDev-C++ designer will remove them
////Header Include Start
////Header Include End

//----------------------------------------------------------------------------
// MenuForm
//----------------------------------------------------------------------------
//Add Custom Events only in the appropriate block.
//Code added in other places will be removed by wxDev-C++
////Event Table Start
BEGIN_EVENT_TABLE(MenuForm,wxDialog)
	////Manual Code Start
	////Manual Code End
	
	EVT_CLOSE(MenuForm::OnClose)
END_EVENT_TABLE()
////Event Table End

MenuForm::MenuForm(wxWindow *parent, wxWindowID id, const wxString &title, const wxPoint &position, const wxSize& size, long style)
: wxDialog(parent, id, title, position, size, style)
{
	CreateGUIControls();
}

MenuForm::~MenuForm()
{
} 

void MenuForm::CreateGUIControls()
{
	//Do not add custom code between
	//GUI Items Creation Start and GUI Items Creation End.
	//wxDev-C++ designer will remove them.
	//Add the custom code before or after the blocks
	////GUI Items Creation Start

	SetTitle(wxT("Create start menu item"));
	SetIcon(wxNullIcon);
	SetSize(8,8,242,177);
	Center();
	

	btnCancel = new wxButton(this, wxID_CANCEL, wxT("Cancel"), wxPoint(166,124), wxSize(61,20), 0, wxDefaultValidator, wxT("btnCancel"));
	btnCancel->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	btnOK = new wxButton(this, wxID_OK, wxT("OK"), wxPoint(95,124), wxSize(61,20), 0, wxDefaultValidator, wxT("btnOK"));
	btnOK->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	edIcon = new wxTextCtrl(this, ID_EDICON, wxT("<app>\\MyApp.ico"), wxPoint(6,103), wxSize(221,16), 0, wxDefaultValidator, wxT("edIcon"));
	edIcon->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	WxStaticText2 = new wxStaticText(this, ID_WXSTATICTEXT2, wxT("Icon :"), wxPoint(6,84), wxDefaultSize, 0, wxT("WxStaticText2"));
	WxStaticText2->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	edTarget = new wxTextCtrl(this, ID_EDTARGET, wxT("<app>\\MyApp.exe"), wxPoint(6,65), wxSize(221,15), 0, wxDefaultValidator, wxT("edTarget"));
	edTarget->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	label2 = new wxStaticText(this, ID_LABEL2, wxT("Target :"), wxPoint(6,46), wxDefaultSize, 0, wxT("label2"));
	label2->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	edName = new wxTextCtrl(this, ID_EDNAME, wxT("MyApp"), wxPoint(6,26), wxSize(221,15), 0, wxDefaultValidator, wxT("edName"));
	edName->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	WxStaticText1 = new wxStaticText(this, ID_WXSTATICTEXT1, wxT("Menu Item Name : "), wxPoint(6,7), wxDefaultSize, 0, wxT("WxStaticText1"));
	WxStaticText1->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));
	////GUI Items Creation End
}

void MenuForm::OnClose(wxCloseEvent& /*event*/)
{
	Destroy();
}
