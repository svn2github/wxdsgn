//---------------------------------------------------------------------------
//
// Name:        ActionForm.h
// Author:      Programming
// Created:     16/05/2007 19:37:47
// Description: ActionForm class declaration
//
//---------------------------------------------------------------------------

#ifndef __ACTIONFORM_h__
#define __ACTIONFORM_h__

#ifdef __BORLANDC__
	#pragma hdrstop
#endif

#ifndef WX_PRECOMP
	#include <wx/wx.h>
	#include <wx/frame.h>
#else
	#include <wx/wxprec.h>
#endif

//Do not add custom headers between 
//Header Include Start and Header Include End.
//wxDev-C++ designer will remove them. Add custom headers after the block.
////Header Include Start
#include <wx/button.h>
#include <wx/radiobut.h>
#include <wx/statbox.h>
#include <wx/panel.h>
////Header Include End

////Dialog Style Start
#undef ActionForm_STYLE
#define ActionForm_STYLE wxCAPTION | wxSYSTEM_MENU | wxMINIMIZE_BOX | wxCLOSE_BOX
////Dialog Style End

class ActionForm : public wxFrame
{
	private:
		DECLARE_EVENT_TABLE();
		
	public:
		ActionForm(wxWindow *parent, wxWindowID id = 1, const wxString &title = wxT("Choose an Action"), const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = ActionForm_STYLE);
		virtual ~ActionForm();
		
	private:
		//Do not add custom control declarations between
		//GUI Control Declaration Start and GUI Control Declaration End.
		//wxDev-C++ will remove them. Add custom code after the block.
		////GUI Control Declaration Start
		wxButton *btnCancel;
		wxButton *btnOK;
		wxRadioButton *WxRadioButton2;
		wxRadioButton *WxRadioButton1;
		wxStaticBox *WxStaticBox1;
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
			ID_BTNCANCEL = 1006,
			ID_BTNOK = 1005,
			ID_WXRADIOBUTTON2 = 1004,
			ID_WXRADIOBUTTON1 = 1003,
			ID_WXSTATICBOX1 = 1002,
			ID_WXPANEL1 = 1001,
			////GUI Enum Control ID End
			ID_DUMMY_VALUE_ //don't remove this value unless you have other enum values
		};
		
	private:
		void OnClose(wxCloseEvent& event);
		void CreateGUIControls();
};

#endif
