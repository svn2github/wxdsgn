//---------------------------------------------------------------------------
//
// Name:        ActionDlg.h
// Author:      Programming
// Created:     19/05/2007 16:16:47
// Description: ActionDlg class declaration
//
//---------------------------------------------------------------------------

#ifndef __ACTIONDLG_h__
#define __ACTIONDLG_h__

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
#include <wx/checkbox.h>
#include <wx/button.h>
#include <wx/radiobut.h>
#include <wx/statbox.h>
////Header Include End

#define CREATE_PACKAGE 1
#define OPEN_PACKAGE 2

////Dialog Style Start
#undef ActionDlg_STYLE
#define ActionDlg_STYLE wxCAPTION | wxSYSTEM_MENU | wxDIALOG_NO_PARENT | wxMINIMIZE_BOX | wxCLOSE_BOX
////Dialog Style End

class ActionDlg : public wxDialog
{
	private:
		DECLARE_EVENT_TABLE();
		
	public:
		ActionDlg(wxWindow *parent, wxWindowID id = 1, const wxString &title = wxT("Choose an Action"), const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = ActionDlg_STYLE);
		virtual ~ActionDlg();
		void btnOKClick(wxCommandEvent& event);
		void chkWizardClick(wxCommandEvent& event);
	
	private:
		//Do not add custom control declarations between 
		//GUI Control Declaration Start and GUI Control Declaration End.
		//wxDev-C++ will remove them. Add custom code after the block.
		////GUI Control Declaration Start
		wxCheckBox *wxSaveAsDefault;
		wxCheckBox *chkWizard;
		wxStaticBox *WxStaticBox2;
		wxButton *btnCancel;
		wxButton *btnOK;
		wxRadioButton *WxRadioButton2;
		wxRadioButton *WxRadioButton1;
		wxStaticBox *WxStaticBox1;
		////GUI Control Declaration End
		
	private:
		//Note: if you receive any error with these enum IDs, then you need to
		//change your old form code that are based on the #define control IDs.
		//#defines may replace a numeric value for the enum names.
		//Try copy and pasting the below block in your old form header files.
		enum
		{
			////GUI Enum Control ID Start
			ID_WXSAVEASDEFAULT = 1018,
			ID_CHKWIZARD = 1017,
			ID_WXSTATICBOX2 = 1016,
			ID_BTNOK = 1014,
			ID_WXRADIOBUTTON2 = 1013,
			ID_WXRADIOBUTTON1 = 1012,
			ID_WXSTATICBOX1 = 1011,
			////GUI Enum Control ID End
			ID_DUMMY_VALUE_ //don't remove this value unless you have other enum values
		};
	
	private:
		void OnClose(wxCloseEvent& event);
		void CreateGUIControls();
};

#endif
