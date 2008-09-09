//---------------------------------------------------------------------------
//
// Name:        ErrorDlg.h
// Author:      Tony Reina and Edward Toovey (Sof.T)
// Created:     9/4/2008 12:52:29 PM
// Description: ErrorDlg class declaration
//
//---------------------------------------------------------------------------

#ifndef __ERRORDLG_h__
#define __ERRORDLG_h__

#ifdef __BORLANDC__
#pragma hdrstop
#endif

#ifndef WX_PRECOMP
#include <wx/wx.h>
#include <wx/dialog.h>
#else
#include <wx/wxprec.h>
#endif

//Do not add custom headers between
//Header Include Start and Header Include End.
//wxDev-C++ designer will remove them. Add custom headers after the block.
////Header Include Start
#include <wx/button.h>
#include <wx/listbox.h>
////Header Include End

////Dialog Style Start
#undef ErrorDlg_STYLE
#define ErrorDlg_STYLE wxCAPTION | wxDIALOG_NO_PARENT | wxMINIMIZE_BOX | wxCLOSE_BOX
////Dialog Style End

class ErrorDlg : public wxDialog
{
private:
    DECLARE_EVENT_TABLE();

public:
    ErrorDlg(wxWindow *parent, wxWindowID id = 666, const wxString &title = wxT("Error Messages"), const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = ErrorDlg_STYLE);
    virtual ~ErrorDlg();

private:
    //Do not add custom control declarations between
    //GUI Control Declaration Start and GUI Control Declaration End.
    //wxDev-C++ will remove them. Add custom code after the block.
    ////GUI Control Declaration Start
    wxButton *WxOK;
    wxListBox *ErrorMessageBox;
    ////GUI Control Declaration End

private:
    //Note: if you receive any error with these enum IDs, then you need to
    //change your old form code that are based on the #define control IDs.
    //#defines may replace a numeric value for the enum names.
    //Try copy and pasting the below block in your old form header files.
    enum
    {
        ////GUI Enum Control ID Start
        ID_ERRORMESSAGEBOX = 1002,
        ////GUI Enum Control ID End
        ID_DUMMY_VALUE_ //don't remove this value unless you have other enum values
    };

private:
    void OnClose(wxCloseEvent& event);
    void CreateGUIControls();

public:
    bool ClearErrorList();
    bool AddError(wxString message);
    void ErrorDlg::ShowOK(bool value);
};

#endif
