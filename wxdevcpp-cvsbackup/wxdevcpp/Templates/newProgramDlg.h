//---------------------------------------------------------------------------
//
// Name:        newProgramDlg.h
// Author:      
// Created:     7/17/2004 12:11:38 AM
// Copyright:
//
//---------------------------------------------------------------------------
#ifndef __NEWPROGRAMDLG_HPP_
#define __NEWPROGRAMDLG_HPP_


#ifndef WX_PRECOMP
    #include "wx/wx.h"
#endif



////Header Include Start
////Header Include End

#include <wx/dialog.h>

////GUI Control ID Start
////GUI Control ID End

////Dialog Style Start
	#define THIS_DIALOG_STYLE wxCAPTION | wxSYSTEM_MENU | wxTHICK_FRAME | wxMINIMIZE_BOX |  wxCLOSE_BOX
////Dialog Style End

class newProgramDlg : public wxDialog
{
public:
    newProgramDlg( wxWindow *parent, wxWindowID id = 1, const wxString &title = _T("Untitled1"),
        const wxPoint& pos = wxDefaultPosition,
        const wxSize& size = wxDefaultSize,
        long style = THIS_DIALOG_STYLE);
    virtual ~newProgramDlg();
public:
  ////GUI Control Declaration Start
  ////GUI Control Declaration End

private:
    DECLARE_EVENT_TABLE()

public:
    void newProgramDlgClose(wxCloseEvent& event);
    void CreateGUIControls(void);
};


#endif
 
 
 
 
