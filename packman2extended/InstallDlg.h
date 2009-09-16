///-------------------------------------------------------------------
///
/// @file        InstallDlg.h
/// @author      Tony Reina and Edward Toovey (Sof.T)
/// Created:     5/13/2008 11:23:50 PM
/// @section DESCRIPTION
///          InstallDlg class declaration
/// @section LICENSE  wxWidgets license
/// @version $Id$
///--------------------------------------------------------------------

#ifndef __INSTALLDLG_h__
#define __INSTALLDLG_h__

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
#include <wx/hyperlink.h>
#include <wx/textctrl.h>
#include <wx/panel.h>
#include <wx/notebook.h>
#include <wx/stattext.h>
#include <wx/statbmp.h>
#include <wx/sizer.h>
////Header Include End
#include "InstallDevPak.h"
#include <wx/utils.h>

////Dialog Style Start
#undef InstallDlg_STYLE
#define InstallDlg_STYLE wxCAPTION | wxRESIZE_BORDER | wxSTAY_ON_TOP
////Dialog Style End

class InstallDlg : public wxDialog
{
private:
    DECLARE_EVENT_TABLE();

public:
    InstallDlg(wxWindow *parent, wxWindowID id = 1, const wxString &title = wxT("Installing DevPak"), const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = InstallDlg_STYLE);
    void btPreviousClick(wxCommandEvent& event);
    void btNextClick(wxCommandEvent& event);
    virtual ~InstallDlg();
    void btCancelClick(wxCommandEvent& event);
private:
    //Do not add custom control declarations between
    //GUI Control Declaration Start and GUI Control Declaration End.
    //wxDev-C++ will remove them. Add custom code after the block.
    ////GUI Control Declaration Start
    wxButton *btCancel;
    wxButton *btNext;
    wxButton *btPrevious;
    wxBoxSizer *WxBoxSizer4;
    wxStaticText *WxStaticText8;
    wxStaticText *stFinished;
    wxPanel *nbFinished;
    wxListBox *lbInstalledFiles;
    wxBoxSizer *WxBoxSizer8;
    wxPanel *nbInstalled;
    wxStaticText *WxStaticText3;
    wxStaticText *WxStaticText6;
    wxTextCtrl *txtLicense;
    wxStaticText *WxStaticText2;
    wxBoxSizer *WxBoxSizer7;
    wxPanel *nbLicense;
    wxTextCtrl *txtReadme;
    wxBoxSizer *WxBoxSizer6;
    wxPanel *nbReadme;
    wxHyperlinkCtrl *htUrl;
    wxStaticText *WxStaticText5;
    wxTextCtrl *txtDescription;
    wxStaticBoxSizer *WxStaticBoxSizer1;
    wxStaticText *WxStaticText7;
    wxStaticText *stWelcome;
    wxStaticText *WxStaticText4;
    wxBoxSizer *WxBoxSizer9;
    wxPanel *nbWelcome;
    wxNotebook *nbInstallerPages;
    wxBoxSizer *WxBoxSizer3;
    wxStaticText *stInstallProcedure;
    wxStaticText *WxStaticText1;
    wxBoxSizer *WxBoxSizer5;
    wxStaticBitmap *WxStaticBitmap1;
    wxBoxSizer *WxBoxSizer2;
    wxBoxSizer *WxBoxSizer1;
    ////GUI Control Declaration End

private:
    //Note: if you receive any error with these enum IDs, then you need to
    //change your old form code that are based on the #define control IDs.
    //#defines may replace a numeric value for the enum names.
    //Try copy and pasting the below block in your old form header files.
    enum
    {
        ////GUI Enum Control ID Start
        ID_BTCANCEL = 1020,
        ID_BTNEXT = 1019,
        ID_BTPREVIOUS = 1018,
        ID_WXSTATICTEXT8 = 1100,
        ID_STFINISHED = 1099,
        ID_NBFINISHED = 1038,
        ID_LBINSTALLEDFILES = 1095,
        ID_NBINSTALLED = 1037,
        ID_WXSTATICTEXT3 = 1107,
        ID_WXSTATICTEXT6 = 1106,
        ID_TXTLICENSE = 1104,
        ID_WXSTATICTEXT2 = 1043,
        ID_NBLICENSE = 1036,
        ID_TXTREADME = 1098,
        ID_NBREADME = 1035,
        ID_HTURL = 1092,
        ID_WXSTATICTEXT5 = 1091,
        ID_TXTDESCRIPTION = 1090,
        ID_WXSTATICTEXT7 = 1088,
        ID_STWELCOME = 1087,
        ID_WXSTATICTEXT4 = 1086,
        ID_NBWELCOME = 1034,
        ID_NBINSTALLERPAGES = 1033,
        ID_STINSTALLPROCEDURE = 1008,
        ID_WXSTATICTEXT1 = 1007,
        ID_WXSTATICBITMAP1 = 1005,
        ////GUI Enum Control ID End
        ID_DUMMY_VALUE_ //don't remove this value unless you have other enum values
    };

public:
    void OnClose(wxCloseEvent& event);
    void CreateGUIControls();
    wxString sArchiveName;
    DevPakInfo info;
    bool bFilesInstalled;
    void InstallDlgInitDialog(wxInitDialogEvent& event);
};

#endif
