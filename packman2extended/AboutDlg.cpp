//---------------------------------------------------------------------------
//
// Name:        AboutDlg.cpp
// Author:      Sof.T
// Created:     18/05/2008 17:09:47
// Description: AboutDlg class implementation
// $Id$
//---------------------------------------------------------------------------

#include "AboutDlg.h"

//Do not add custom headers
//wxDev-C++ designer will remove them
////Header Include Start
#include "Images/AboutDlg_WxStaticBitmap1_XPM.xpm"
////Header Include End

//----------------------------------------------------------------------------
// AboutDlg
//----------------------------------------------------------------------------
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

    WxButton1 = new wxButton(this, ID_WXBUTTON1, wxT("OK"), wxPoint(62, 393), wxSize(87, 29), 0, wxDefaultValidator, wxT("WxButton1"));

    WxMemo1 = new wxTextCtrl(this, ID_WXMEMO1, wxEmptyString, wxPoint(-1, 228), wxSize(277, 159), wxTE_READONLY | wxTE_CENTRE | wxTE_MULTILINE, wxDefaultValidator, wxT("WxMemo1"));
    WxMemo1->SetMaxLength(0);
    WxMemo1->AppendText(wxT("Based on Package "));
    WxMemo1->AppendText(wxT("Manager\n"));
    WxMemo1->AppendText(wxT("by Hongli Lai\n\n"));
    WxMemo1->AppendText(wxT(""));
    WxMemo1->AppendText(wxT("Rewritten in C++ and\n"));
    WxMemo1->AppendText(wxT("wxWidgets by\n\n"));
    WxMemo1->AppendText(wxT(""));
    WxMemo1->AppendText(wxT("Tony Reina & Sof.T"));
    WxMemo1->SetFocus();
    WxMemo1->SetInsertionPointEnd();
    WxMemo1->SetFont(wxFont(12, wxSWISS, wxNORMAL, wxBOLD, false, wxT("Tahoma")));

    wxBitmap WxStaticBitmap1_BITMAP(AboutDlg_WxStaticBitmap1_XPM);
    WxStaticBitmap1 = new wxStaticBitmap(this, ID_WXSTATICBITMAP1, WxStaticBitmap1_BITMAP, wxPoint(-1, -1), wxSize(275, 231));
    WxStaticBitmap1->Enable(false);

    SetTitle(wxT("About Package Manager"));
    SetIcon(wxNullIcon);
    SetSize(9,0,312,471);
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
