//---------------------------------------------------------------------------
//
// Name:        newProgramFrame.cpp
// Author:      
// Created:     10/27/2004 12:22:10 AM
// Copyright:
//
//---------------------------------------------------------------------------

#ifdef __GNUG__
    #pragma implementation "newProgramFrame.cpp"
#endif

/* for compilers that support precompilation
   includes "wx/wx.h" */

#include "wx/wxprec.h"

#ifdef __BORLANDC__
    #pragma hdrstop
#endif


#include "newProgramFrame.h"

////Header Include Start
////Header Include End


//----------------------------------------------------------------------------
// newProgramFrame
//----------------------------------------------------------------------------

    ////Event Table Start
BEGIN_EVENT_TABLE(newProgramFrame,wxFrame)
	////Manual Code Start
	////Manual Code End
	
	EVT_CLOSE(newProgramFrame::newProgramFrameClose)
END_EVENT_TABLE()
    ////Event Table End



newProgramFrame::newProgramFrame( wxWindow *parent, wxWindowID id, const wxString &title, const wxPoint &position, const wxSize& size, long style )
    : wxFrame( parent, id, title, position, size, style)
{
    CreateGUIControls();
}

newProgramFrame::~newProgramFrame()
{
    
} 

void newProgramFrame::CreateGUIControls(void)
{
    ////GUI Items Creation Start

	this->SetSize(7,6,324,334);
	this->SetTitle(wxString("newProgramFrame"));
	this->Center();
	this->SetIcon(wxNullIcon);
	
    ////GUI Items Creation End
}

void newProgramFrame::newProgramFrameClose(wxCloseEvent& event)
{
    // --> Don't use Close with a Frame,
    // use Destroy instead.
    Destroy();
}
 
