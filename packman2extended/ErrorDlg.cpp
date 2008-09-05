//---------------------------------------------------------------------------
//
// Name:        ErrorDlg.cpp
// Author:      Tony Reina and Edward Toovey (Sof.T)
// Created:     9/4/2008 12:52:29 PM
// Description: ErrorDlg class implementation
//
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
    SetSize(8,8,355,183);
    Center();


    wxArrayString arrayStringFor_ErrorMessageBox;
    ErrorMessageBox = new wxListBox(this, ID_ERRORMESSAGEBOX, wxPoint(19,8), wxSize(305,128), arrayStringFor_ErrorMessageBox, wxLB_SINGLE);
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
    ErrorMessageBox->Append(message);
    return true;
}
