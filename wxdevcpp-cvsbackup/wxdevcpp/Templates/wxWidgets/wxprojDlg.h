//---------------------------------------------------------------------------
//
// Name:        %FILE_NAME%.h
// Author:      %AUTHOR_NAME%
// Created:     %DATE_STRING%
// Description: 
//
//---------------------------------------------------------------------------

#ifndef __%CAP_CLASS_NAME%_h__
#define __%CAP_CLASS_NAME%_h__

#ifdef __BORLANDC__
	#pragma hdrstop
#endif

#ifndef WX_PRECOMP
	#include <wx/wx.h>
	#include <wx/dialog.h>
#else
	#include <wx/wxprec.h>
#endif

//Do not add custom headers
//wxDev-C++ designer will remove them
////Header Include Start
////Header Include End

//Compatibility for 2.4 code
#ifndef wxCLOSE_BOX
	#define wxCLOSE_BOX 0x1000
#endif
#ifndef wxFIXED_MINSIZE
	#define wxFIXED_MINSIZE 0
#endif

////Dialog Style Start
#define %CLASS_NAME%_STYLE %CLASS_STYLE_STRING%
////Dialog Style End

class %CLASS_NAME% : public wxDialog
{
	private:
		DECLARE_EVENT_TABLE();
		
	public:
		%CLASS_NAME%(wxWindow *parent, wxWindowID id = 1, const wxString &title = wxT("%CLASS_TITLE%"), const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = %CLASS_NAME%_STYLE);
		virtual ~%CLASS_NAME%();
	
	public:
		//Do not add custom control declarations
		//wxDev-C++ will remove them. Add custom code after the block.
		////GUI Control Declaration Start
		////GUI Control Declaration End
		
	public:
		//Note: if you receive any error with these enum IDs, then you need to
		//change your old form code that are based on the #define control IDs.
		//#defines may replace a numeric value for the enum names.
		//Try copy and pasting the below block in your old form header files.
		enum
		{
			////GUI Enum Control ID Start
			////GUI Enum Control ID End
			ID_DUMMY_VALUE_ //don't remove this value unless you have other enum values
		}; //End of Enum
	
	public:
		void %CLASS_NAME%Close(wxCloseEvent& event);
		void CreateGUIControls(void);
};

#endif
