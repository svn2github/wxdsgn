//---------------------------------------------------------------------------
//
// Name:        FileForm.h
// Author:      Programming
// Created:     16/05/2007 19:47:56
// Description: FileForm class declaration
//
//---------------------------------------------------------------------------

#ifndef __FILEFORM_h__
#define __FILEFORM_h__

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
#include <wx/filedlg.h>
#include <wx/button.h>
#include <wx/combobox.h>
#include <wx/bmpbuttn.h>
#include <wx/textctrl.h>
#include <wx/stattext.h>
////Header Include End

////Dialog Style Start
#undef FileForm_STYLE
#define FileForm_STYLE wxCAPTION | wxSYSTEM_MENU | wxDIALOG_NO_PARENT | wxMINIMIZE_BOX | wxCLOSE_BOX
////Dialog Style End

class FileForm : public wxDialog
{
	private:
		DECLARE_EVENT_TABLE();
		
	public:
		FileForm(wxWindow *parent, wxWindowID id = 1, const wxString &title = wxT("Add file or directory"), const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = FileForm_STYLE);
		virtual ~FileForm();
		void btnLoadClick(wxCommandEvent& event);
	
	private:
		//Do not add custom control declarations between 
		//GUI Control Declaration Start and GUI Control Declaration End.
		//wxDev-C++ will remove them. Add custom code after the block.
		////GUI Control Declaration Start
		wxFileDialog *OpenDialog;
		wxButton *BtnCancel;
		wxButton *btnOK;
		wxComboBox *edDest;
		wxStaticText *lblDest;
		wxBitmapButton *btnLoad;
		wxTextCtrl *edSource;
		wxStaticText *lblSource;
		////GUI Control Declaration End
		wxString FileName;
		
	private:
		//Note: if you receive any error with these enum IDs, then you need to
		//change your old form code that are based on the #define control IDs.
		//#defines may replace a numeric value for the enum names.
		//Try copy and pasting the below block in your old form header files.
		enum
		{
			////GUI Enum Control ID Start
			ID_EDDEST = 1005,
			ID_LBLDEST = 1004,
			ID_BTNLOAD = 1003,
			ID_EDSOURCE = 1002,
			ID_LBLSOURCE = 1001,
			////GUI Enum Control ID End
			ID_DUMMY_VALUE_ //don't remove this value unless you have other enum values
		};
	
	private:
		void OnClose(wxCloseEvent& event);
		void CreateGUIControls();
		bool Dir;
	public:
		void SetMode(bool d);
		const wxString GetSource(){return edSource->GetValue();};
		const wxString GetDestination(){return edDest->GetValue();};
};

#endif
