///----------------------------------------------------------------
///
/// @file        AboutDlg.cpp
/// @author      Sof.T
/// Created:     18/05/2008 17:09:47
/// @section DESCRIPTION AboutDlg class implementation
/// @section LICENSE  wxWidgets license
/// @version $Id$
///
///----------------------------------------------------------------

#include "AboutDlg.h"

//Do not add custom headers
//wxDev-C++ designer will remove them
////Header Include Start
#include "Images/AboutDlg_WxStaticBitmap1_XPM.xpm"
////Header Include End

//------------------------------------------------------------
// AboutDlg
//---------------------------------------------------------------
//Add Custom Events only in the appropriate block.
//Code added in other places will be removed by wxDev-C++
////Event Table Start
BEGIN_EVENT_TABLE(AboutDlg,wxDialog)
    ////Manual Code Start
    ////Manual Code End

    EVT_CLOSE(AboutDlg::OnClose)
    EVT_BUTTON(ID_WXBUTTON1,AboutDlg::WxButton1Click)
END_EVENT_TABLE()
////Event Table End

AboutDlg::AboutDlg(wxWindow *parent, wxWindowID id, const wxString &title, const wxPoint &position, const wxSize& size, long style)
        : wxDialog(parent, id, title, position, size, style)
{
    CreateGUIControls();
}

AboutDlg::~AboutDlg()
{
}

void AboutDlg::CreateGUIControls()
{
    //Do not add custom code between
    //GUI Items Creation Start and GUI Items Creation End.
    //wxDev-C++ designer will remove them.
    //Add the custom code before or after the blocks
    ////GUI Items Creation Start

    WxPanel1 = new wxPanel(this, ID_WXPANEL1, wxPoint(-1, -2), wxSize(274, 397));

    wxBitmap WxStaticBitmap1_BITMAP(AboutDlg_WxStaticBitmap1_XPM);
    WxStaticBitmap1 = new wxStaticBitmap(WxPanel1, ID_WXSTATICBITMAP1, WxStaticBitmap1_BITMAP, wxPoint(-2, 0), wxSize(275, 231));
    WxStaticBitmap1->Enable(false);

    WxButton1 = new wxButton(WxPanel1, ID_WXBUTTON1, wxT("OK"), wxPoint(95, 364), wxSize(75, 25), 0, wxDefaultValidator, wxT("WxButton1"));

    WxStaticText1 = new wxStaticText(WxPanel1, ID_WXSTATICTEXT1, wxT("Based on Package Manager by Hongli Lai"), wxPoint(9, 240), wxSize(252, 61), wxALIGN_CENTRE | wxST_NO_AUTORESIZE, wxT("WxStaticText1"));
    WxStaticText1->SetFont(wxFont(14, wxSWISS, wxNORMAL, wxNORMAL, false));

    WxStaticText2 = new wxStaticText(WxPanel1, ID_WXSTATICTEXT2, wxT("Re-written in C++/wxWidgets"), wxPoint(10, 294), wxDefaultSize, 0, wxT("WxStaticText2"));
    WxStaticText2->SetFont(wxFont(14, wxSWISS, wxNORMAL, wxNORMAL, false));

    WxStaticText3 = new wxStaticText(WxPanel1, ID_WXSTATICTEXT3, wxT("by Tony Reina and Sof.T"), wxPoint(35, 320), wxDefaultSize, 0, wxT("WxStaticText3"));
    WxStaticText3->SetFont(wxFont(14, wxSWISS, wxNORMAL, wxNORMAL, false));

    SetTitle(wxT("About Package Manager"));
    SetIcon(wxNullIcon);
    SetSize(8,8,287,431);
    Center();

    ////GUI Items Creation End
}

void AboutDlg::OnClose(wxCloseEvent& /*event*/)
{
    Destroy();
}

/*
 * WxButton1Click
 */
void AboutDlg::WxButton1Click(wxCommandEvent& event)
{
    // insert your code here
    EndModal(wxID_OK);
}
