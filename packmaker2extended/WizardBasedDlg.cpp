//---------------------------------------------------------------------------
//
// Name:        WizardBasedDlg.cpp
// Author:      Sof.T
// Created:     27/08/2007 21:22:36
// Description: WizardBasedDlg class implementation
//
//---------------------------------------------------------------------------

#include "WizardBasedDlg.h"

//Do not add custom headers
//wxDev-C++ designer will remove them
////Header Include Start
////Header Include End

//----------------------------------------------------------------------------
// WizardBasedDlg
//----------------------------------------------------------------------------
//Add Custom Events only in the appropriate block.
//Code added in other places will be removed by wxDev-C++
////Event Table Start
BEGIN_EVENT_TABLE(WizardBasedDlg, wxDialog)
	////Manual Code Start
	////Manual Code End
	EVT_CLOSE(WizardBasedDlg::OnClose)
END_EVENT_TABLE()
////Event Table End

WizardBasedDlg::WizardBasedDlg(wxWindow *parent, wxWindowID id, const wxString &title, const wxPoint &position, const wxSize& size, long style)
: wxDialog(parent, id, title, position, size, style)
{
	CreateGUIControls();
}

WizardBasedDlg::~WizardBasedDlg()
{
} 

void WizardBasedDlg::CreateGUIControls()
{
	//Do not add custom code between
	//GUI Items Creation Start and GUI Items Creation End.
	//wxDev-C++ designer will remove them.
	//Add the custom code before or after the blocks
	////GUI Items Creation Start
	////GUI Items Creation End
}

void WizardBasedDlg::OnClose(wxCloseEvent& /*event*/)
{
	Destroy();
}
