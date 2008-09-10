//---------------------------------------------------------------------------
//
// Name:        ErrorDlg.cpp
// Author:      Tony Reina and Edward Toovey (Sof.T)
// Created:     9/4/2008 12:52:29 PM
// Description: ErrorDlg class implementation
// $Id$
//---------------------------------------------------------------------------

#include "ErrorDlg.h"

//Do not add custom headers
//wxDev-C++ designer will remove them
////Header Include Start
////Header Include End

//----------------------------------------------------------------------------
// ErrorDlg
//----------------------------------------------------------------------------
//Add Custom Events only in the appropriate block.
//Code added in other places will be removed by wxDev-C++
////Event Table Start
BEGIN_EVENT_TABLE(ErrorDlg,wxDialog)
    ////Manual Code Start
    ////Manual Code End

    EVT_CLOSE(ErrorDlg::OnClose)
END_EVENT_TABLE()
////Event Table End

ErrorDlg::ErrorDlg(wxWindow *parent, wxWindowID id, const wxString &title, const wxPoint &position, const wxSize& size, long style)
        : wxDialog(parent, id, title, position, size, style)
{
    CreateGUIControls();
}

ErrorDlg::~ErrorDlg()
{
}

void ErrorDlg::CreateGUIControls()
{
    //Do not add custom code between
    //GUI Items Creation Start and GUI Items Creation End.
    //wxDev-C++ designer will remove them.
    //Add the custom code before or after the blocks
    ////GUI Items Creation Start

    SetTitle(wxT("Error Messages"));
    SetIcon(wxNullIcon);
    SetSize(8,8,355,210);
    Center();


    /* All errors and messages are passed to this log.
    */
    ErrorMessageBox = new wxTextCtrl(this, ID_ERRORMESSAGEBOX, wxT(""), wxPoint(13,12), wxSize(318,127), wxTE_READONLY | wxTE_MULTILINE, wxDefaultValidator, wxT("ErrorMessageBox"));
    ErrorMessageBox->SetMaxLength(0);
    ErrorMessageBox->SetFocus();
    ErrorMessageBox->SetInsertionPointEnd();

    WxOK = new wxButton(this, wxID_OK, wxT("Ok"), wxPoint(138,145), wxSize(75,25), 0, wxDefaultValidator, wxT("WxOK"));
    WxOK->Show(false);
    ////GUI Items Creation End
}

void ErrorDlg::OnClose(wxCloseEvent& /*event*/)
{
    Destroy();
}

bool ErrorDlg::ClearErrorList()
{
    ErrorMessageBox->Clear();
    return true;
}

bool ErrorDlg::AddError(wxString message)
{
    ErrorMessageBox->AppendText(message);
    return true;
}

void ErrorDlg::ShowOK(bool value)
{
    WxOK->Show(value);
}
