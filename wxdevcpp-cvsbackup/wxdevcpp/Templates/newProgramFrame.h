//---------------------------------------------------------------------------
//
// Name:        newProgramFrame.h
// Author:      
// Created:     10/27/2004 12:22:10 AM
// Copyright:
//
//---------------------------------------------------------------------------
#ifndef __NEWPROGRAMFRAME_HPP_
#define __NEWPROGRAMFRAME_HPP_


#ifndef WX_PRECOMP
    #include "wx/wx.h"
#endif



////Header Include Start
////Header Include End

#include <wx/frame.h>

////GUI Control ID Start
////GUI Control ID End

////Dialog Style Start
	#define THIS_DIALOG_STYLE wxCAPTION | wxRESIZE_BORDER | wxSYSTEM_MENU | wxTHICK_FRAME | wxMINIMIZE_BOX | wxMAXIMIZE_BOX |  wxCLOSE_BOX
////Dialog Style End

class newProgramFrame : public wxFrame
{
private:
    DECLARE_EVENT_TABLE()
public:
    newProgramFrame( wxWindow *parent, wxWindowID id = 1, const wxString &title = _T("newProgramFrame"),
        const wxPoint& pos = wxDefaultPosition,
        const wxSize& size = wxDefaultSize,
        long style = THIS_DIALOG_STYLE);
    virtual ~newProgramFrame();
public:
  ////GUI Control Declaration Start
  ////GUI Control Declaration End

public:
    void newProgramFrameClose(wxCloseEvent& event);
    void CreateGUIControls(void);

};


#endif
 
 
 
 
