//---------------------------------------------------------------------------
//
// Name:        RemoveDlg.h
// Author:      Tony Reina and Edward Toovey (Sof.T)
// Created:     6/17/2008 10:31:37 PM
// Description: RemoveDlg class declaration
// $Id$
//---------------------------------------------------------------------------

#ifndef __REMOVEDLG_h__
#define __REMOVEDLG_h__

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
#include <wx/timer.h>
#include <wx/button.h>
#include <wx/gauge.h>
#include <wx/statbox.h>
#include <wx/stattext.h>
////Header Include End

#include "ErrorDlg.h"

////Dialog Style Start
#undef RemoveDlg_STYLE
#define RemoveDlg_STYLE wxCAPTION | wxSTAY_ON_TOP
////Dialog Style End

class RemoveDlg : public wxDialog
{
private:
    DECLARE_EVENT_TABLE();

public:
    RemoveDlg(wxWindow *parent, wxWindowID id = 1, const wxString &title = wxT("RemoveDlg"), const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = RemoveDlg_STYLE);
    virtual ~RemoveDlg();

private:
    //Do not add custom control declarations between
    //GUI Control Declaration Start and GUI Control Declaration End.
    //wxDev-C++ will remove them. Add custom code after the block.
    ////GUI Control Declaration Start
    wxTimer *WxTimer1;
    wxButton *WxCancel;
    wxStaticText *WxStaticText4;
    wxStaticText *WxStaticText3;
    wxStaticText *WxStaticText2;
    wxStaticText *txtFilesRemaining;
    wxStaticText *txtFilesDeleted;
    wxStaticText *txtTotalFiles;
    wxGauge *WxGauge1;
    wxStaticBox *ProgressBox;
    wxStaticText *WxStaticText1;
    wxStaticText *txtDeleteFile;
    ////GUI Control Declaration End
    // Create an error dialog for error messages

protected:
    ErrorDlg *errordlg;  // Error message window

private:
    //Note: if you receive any error with these enum IDs, then you need to
    //change your old form code that are based on the #define control IDs.
    //#defines may replace a numeric value for the enum names.
    //Try copy and pasting the below block in your old form header files.
    enum
    {
        ////GUI Enum Control ID Start
        ID_WXTIMER1 = 1012,
        ID_WXCANCEL = 1011,
        ID_WXSTATICTEXT4 = 1010,
        ID_WXSTATICTEXT3 = 1009,
        ID_WXSTATICTEXT2 = 1008,
        ID_TXTFILESREMAINING = 1007,
        ID_TXTFILESDELETED = 1006,
        ID_TXTTOTALFILES = 1005,
        ID_WXGAUGE1 = 1004,
        ID_PROGRESSBOX = 1003,
        ID_WXSTATICTEXT1 = 1002,
        ID_TXTDELETEFILE = 1001,
        ////GUI Enum Control ID End
        ID_DUMMY_VALUE_ //don't remove this value unless you have other enum values
    };

private:
    void OnClose(wxCloseEvent& event);
    void CreateGUIControls();

public:
    DevPakInfo *info;
    void WxTimer1Timer(wxTimerEvent& event);
    void RemoveDlgInitDialog(wxInitDialogEvent& event);
    void WxCancelClick(wxCommandEvent& event);
    bool RemoveFiles();
};

#endif
