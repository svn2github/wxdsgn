//---------------------------------------------------------------------------
//
// Name:        BuildForm.cpp
// Author:      Programming
// Created:     16/05/2007 19:43:55
// Description: BuildForm class implementation
//
//---------------------------------------------------------------------------

#include "BuildForm.h"

//Do not add custom headers
//wxDev-C++ designer will remove them
////Header Include Start
////Header Include End

//----------------------------------------------------------------------------
// BuildForm
//----------------------------------------------------------------------------
//Add Custom Events only in the appropriate block.
//Code added in other places will be removed by wxDev-C++
////Event Table Start
BEGIN_EVENT_TABLE(BuildForm,wxDialog)
	////Manual Code Start
	////Manual Code End
	
	EVT_CLOSE(BuildForm::OnClose)
END_EVENT_TABLE()
////Event Table End

BuildForm::BuildForm(wxWindow *parent, wxWindowID id, const wxString &title, const wxPoint &position, const wxSize& size, long style)
: wxDialog(parent, id, title, position, size, style)
{
	CreateGUIControls();
}

BuildForm::~BuildForm()
{
} 

void BuildForm::CreateGUIControls()
{
	//Do not add custom code between
	//GUI Items Creation Start and GUI Items Creation End.
	//wxDev-C++ designer will remove them.
	//Add the custom code before or after the blocks
	////GUI Items Creation Start

	SetTitle(wxT("Building Package..."));
	SetIcon(wxNullIcon);
	SetSize(8,8,262,78);
	Center();
	

	WxGauge1 = new wxGauge(this, ID_WXGAUGE1, 10, wxPoint(9,23), wxSize(233,14), wxGA_HORIZONTAL, wxDefaultValidator, wxT("WxGauge1"));
	WxGauge1->SetRange(10);
	WxGauge1->SetValue(0);
	WxGauge1->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	WxStaticBox1 = new wxStaticBox(this, ID_WXSTATICBOX1, wxT(" Progress... "), wxPoint(2,3), wxSize(248,43));
	WxStaticBox1->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));
	////GUI Items Creation End
}

void BuildForm::OnClose(wxCloseEvent& /*event*/)
{
	Destroy();
}
