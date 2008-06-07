//---------------------------------------------------------------------------
//
// Name:        BuildForm.h
// Author:      Programming
// Created:     16/05/2007 19:43:55
// Description: BuildForm class declaration
//
//---------------------------------------------------------------------------

#ifndef __BUILDFORM_h__
#define __BUILDFORM_h__

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
#include <wx/gauge.h>
#include <wx/statbox.h>
////Header Include End

////Dialog Style Start
#undef BuildForm_STYLE
#define BuildForm_STYLE wxCAPTION | wxSYSTEM_MENU | wxDIALOG_NO_PARENT | wxMINIMIZE_BOX | wxCLOSE_BOX
////Dialog Style End

class BuildForm : public wxDialog
{
	private:
		DECLARE_EVENT_TABLE();
		
	public:
		BuildForm(wxWindow *parent, wxWindowID id = 1, const wxString &title = wxT("Building Package..."), const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = BuildForm_STYLE);
		virtual ~BuildForm();
	
	private:
    public:
		//Do not add custom control declarations between 
		//GUI Control Declaration Start and GUI Control Declaration End.
		//wxDev-C++ will remove them. Add custom code after the block.
		////GUI Control Declaration Start
		wxGauge *WxGauge1;
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
			ID_WXGAUGE1 = 1002,
			ID_WXSTATICBOX1 = 1001,
			////GUI Enum Control ID End
			ID_DUMMY_VALUE_ //don't remove this value unless you have other enum values
		};
	
	private:
		void OnClose(wxCloseEvent& event);
		void CreateGUIControls();
};

#endif
