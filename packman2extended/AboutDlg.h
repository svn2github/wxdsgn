///--------------------------------------------------------------------
///
/// @file        AboutDlg.h
/// @author      Sof.T
/// Created:     18/05/2008 17:09:46
/// @section DESCRIPTION
///              AboutDlg class declaration
/// @section LICENSE  wxWidgets license
/// @version $Id$
///
///--------------------------------------------------------------------

#ifndef __ABOUTDLG_h__
#define __ABOUTDLG_h__

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
#include <wx/stattext.h>
#include <wx/button.h>
#include <wx/statbmp.h>
#include <wx/panel.h>
////Header Include End

////Dialog Style Start
#undef AboutDlg_STYLE
#define AboutDlg_STYLE wxCAPTION | wxSYSTEM_MENU | wxDIALOG_NO_PARENT | wxMINIMIZE_BOX | wxCLOSE_BOX
////Dialog Style End

class AboutDlg : public wxDialog
{
private:
    DECLARE_EVENT_TABLE();

public:
    AboutDlg(wxWindow *parent, wxWindowID id = 1, const wxString &title = wxT("About Package Manager"), const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = AboutDlg_STYLE);
    virtual ~AboutDlg();
    void WxButton1Click(wxCommandEvent& event);

private:
    //Do not add custom control declarations between
    //GUI Control Declaration Start and GUI Control Declaration End.
    //wxDev-C++ will remove them. Add custom code after the block.
    ////GUI Control Declaration Start
    wxStaticText *WxStaticText3;
    wxStaticText *WxStaticText2;
    wxStaticText *WxStaticText1;
    wxButton *WxButton1;
    wxStaticBitmap *WxStaticBitmap1;
    wxPanel *WxPanel1;
    ////GUI Control Declaration End

private:
    //Note: if you receive any error with these enum IDs, then you need to
    //change your old form code that are based on the #define control IDs.
    //#defines may replace a numeric value for the enum names.
    //Try copy and pasting the below block in your old form header files.
    enum
    {
        ////GUI Enum Control ID Start
        ID_WXSTATICTEXT3 = 1010,
        ID_WXSTATICTEXT2 = 1009,
        ID_WXSTATICTEXT1 = 1008,
        ID_WXBUTTON1 = 1007,
        ID_WXSTATICBITMAP1 = 1006,
        ID_WXPANEL1 = 1005,
        ////GUI Enum Control ID End
        ID_DUMMY_VALUE_ //don't remove this value unless you have other enum values
    };

private:
    void OnClose(wxCloseEvent& event);
    void CreateGUIControls();
};

#endif
