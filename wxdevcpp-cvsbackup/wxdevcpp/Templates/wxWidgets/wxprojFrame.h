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

////Header Include Start
////Header Include End

#include <wx/frame.h>

////GUI Control ID Start
////GUI Control ID End

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
  ////GUI Control Declaration Start
  ////GUI Control Declaration End

public:
    void %CLASS_NAME%Close(wxCloseEvent& event);
    void CreateGUIControls(void);

};

#endif
 
 
 
 
