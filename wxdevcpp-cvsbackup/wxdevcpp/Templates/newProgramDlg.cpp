//---------------------------------------------------------------------------
//
// Name:        newProgramDlg.cpp
// Author:      
// Created:     7/17/2004 12:11:38 AM
// Copyright:
//
//---------------------------------------------------------------------------

#ifdef __GNUG__
    #pragma implementation "newProgramDlg.cpp"
#endif

/* for compilers that support precompilation
   includes "wx/wx.h" */

#include "wx/wxprec.h"

#ifdef __BORLANDC__
    #pragma hdrstop
#endif


#include "newProgramDlg.h"

////Header Include Start
////Header Include End


//----------------------------------------------------------------------------
// newProgramDlg
//----------------------------------------------------------------------------

    ////Event Table Start
BEGIN_EVENT_TABLE(newProgramDlg,wxDialog)
	
	EVT_CLOSE(newProgramDlg::newProgramDlgClose)
END_EVENT_TABLE()
    ////Event Table End



newProgramDlg::newProgramDlg( wxWindow *parent, wxWindowID id, const wxString &title, const wxPoint &position, const wxSize& size, long style )
    : wxDialog( parent, id, title, position, size, style)
{
    CreateGUIControls();
}

newProgramDlg::~newProgramDlg()
{
} 

void newProgramDlg::CreateGUIControls(void)
{
    ////GUI Items Creation Start

	this->SetSize(8,8,317,312);
	this->SetTitle(wxString("new Program Dialog"));
	this->Center();
	this->SetIcon(wxNullIcon);
	
    ////GUI Items Creation End
}

void newProgramDlg::newProgramDlgClose(wxCloseEvent& event)
{
    // --> Don't use Close with a wxDialog,
    // use Destroy instead.
    Destroy();
}
