//---------------------------------------------------------------------------
//
// Name:        %FILE_NAME%.h
// Author:      %AUTHOR_NAME%
// Created:     %DATE_STRING%
//
//---------------------------------------------------------------------------
#ifndef __%FILE_NAME%_HPP_
#define __%FILE_NAME%_HPP_

// For compilers that support precompilation, includes "wx.h".
#include <wx/wxprec.h>

#ifdef __BORLANDC__
#pragma hdrstop
#endif

#ifndef WX_PRECOMP
// Include your minimal set of headers here, or wx.h
#include <wx/wx.h>
#endif

//Do not add custom headers.
//wx-dvcpp designer will remove them
////Header Include Start
////Header Include End

#include <wx/frame.h>

////Dialog Style Start
#define THIS_DIALOG_STYLE %CLASS_STYLE_STRING%
////Dialog Style End

class %CLASS_NAME% : public wxFrame
{
private:
    DECLARE_EVENT_TABLE()
public:
    %CLASS_NAME%( wxWindow *parent, wxWindowID id = 1, const wxString &title = _T("%CLASS_TITLE%"),
        const wxPoint& pos = wxDefaultPosition,
        const wxSize& size = wxDefaultSize,
        long style = THIS_DIALOG_STYLE);
    virtual ~%CLASS_NAME%();
public:
  //Do not add custom Control Declarations here.
  //wx-devcpp will remove them. Try adding the custom code 
  //after the block.
  ////GUI Control Declaration Start
  ////GUI Control Declaration End
public:
	//Note: if you receive any error with these enums, then you need to
    //change your old form code that are based on the #define control ids.
	//It may replace a numeric value in the enums names.
	enum {
////GUI Enum Control ID Start
////GUI Enum Control ID End
   ID_DUMMY_VALUE_ //Dont Delete this DummyValue
   }; //End of Enum
public:
    void %CLASS_NAME%Close(wxCloseEvent& event);
    void CreateGUIControls(void);

};

#endif
 
 
 
 
