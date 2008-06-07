//---------------------------------------------------------------------------
//
// Name:        FileForm.cpp
// Author:      Programming
// Created:     16/05/2007 19:47:56
// Description: FileForm class implementation
//
//---------------------------------------------------------------------------

#include "FileForm.h"

//Do not add custom headers
//wxDev-C++ designer will remove them
////Header Include Start
#include "Images/FileForm_btnLoad_XPM.xpm"
////Header Include End
#include <wx/dirdlg.h>
#include <wx/stdpaths.h>
#include <wx/filename.h>

//----------------------------------------------------------------------------
// FileForm
//----------------------------------------------------------------------------
//Add Custom Events only in the appropriate block.
//Code added in other places will be removed by wxDev-C++
////Event Table Start
BEGIN_EVENT_TABLE(FileForm,wxDialog)
	////Manual Code Start
	////Manual Code End
	
	EVT_CLOSE(FileForm::OnClose)
	EVT_BUTTON(ID_BTNLOAD,FileForm::btnLoadClick)
END_EVENT_TABLE()
////Event Table End

FileForm::FileForm(wxWindow *parent, wxWindowID id, const wxString &title, const wxPoint &position, const wxSize& size, long style)
: wxDialog(parent, id, title, position, size, style)
{
	CreateGUIControls();
}

FileForm::~FileForm()
{
} 

void FileForm::CreateGUIControls()
{
	//Do not add custom code between
	//GUI Items Creation Start and GUI Items Creation End.
	//wxDev-C++ designer will remove them.
	//Add the custom code before or after the blocks
	////GUI Items Creation Start

	SetTitle(wxT("Add file or directory"));
	SetIcon(wxNullIcon);
	SetSize(8,8,268,126);
	Center();
	

	OpenDialog =  new wxFileDialog(this, wxT("Choose a file"), wxT(""), wxT(""), wxT("*.*"), wxOPEN);

	BtnCancel = new wxButton(this, wxID_CANCEL, wxT("Cancel"), wxPoint(195,71), wxSize(61,20), 0, wxDefaultValidator, wxT("BtnCancel"));
	BtnCancel->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	btnOK = new wxButton(this, wxID_OK, wxT("OK"), wxPoint(123,72), wxSize(61,20), 0, wxDefaultValidator, wxT("btnOK"));
	btnOK->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	wxArrayString arrayStringFor_edDest;
	arrayStringFor_edDest.Add(wxT("<app>\\"));
	arrayStringFor_edDest.Add(wxT("<src>\\"));
	arrayStringFor_edDest.Add(wxT("<win>\\"));
	arrayStringFor_edDest.Add(wxT("<sys>\\"));
	edDest = new wxComboBox(this, ID_EDDEST, wxT("<app>\\"), wxPoint(6,45), wxSize(250,21), arrayStringFor_edDest, 0, wxDefaultValidator, wxT("edDest"));
	edDest->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	lblDest = new wxStaticText(this, ID_LBLDEST, wxT("Destination (if destination is a directory, put a \\ at the end)"), wxPoint(6,25), wxDefaultSize, 0, wxT("lblDest"));
	lblDest->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	wxBitmap btnLoad_BITMAP (FileForm_btnLoad_XPM);
	btnLoad = new wxBitmapButton(this, ID_BTNLOAD, btnLoad_BITMAP, wxPoint(240,6), wxSize(16,16), wxBU_AUTODRAW, wxDefaultValidator, wxT("btnLoad"));
	btnLoad->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	edSource = new wxTextCtrl(this, ID_EDSOURCE, wxT(""), wxPoint(46,7), wxSize(189,16), 0, wxDefaultValidator, wxT("edSource"));
	edSource->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));

	lblSource = new wxStaticText(this, ID_LBLSOURCE, wxT("Source :"), wxPoint(6,7), wxDefaultSize, 0, wxT("lblSource"));
	lblSource->SetFont(wxFont(8, wxSWISS, wxNORMAL,wxNORMAL, false, wxT("Tahoma")));
	////GUI Items Creation End
}

void FileForm::OnClose(wxCloseEvent& /*event*/)
{
	Destroy();
}

void FileForm::SetMode(bool d)
{
    Dir = d;
    if(Dir)
        SetTitle(wxT("Add Directory"));
    else
        SetTitle(wxT("Add File"));
}

/*
 * btnLoadClick
 */
void FileForm::btnLoadClick(wxCommandEvent& event)
{
	// insert your code here
	static wxString DirectoryString = wxPathOnly(FileName); //Set directory string to root of the DevPackage
	// insert your code here
	wxString s;
	
	if(Dir)
	{
        wxDirDialog TempDirDlg(this,wxT("Select Directory"),DirectoryString);
        if(TempDirDlg.ShowModal() == wxID_OK)
        {
	        //wxFileName TempFileName(TempDirDlg.GetPath());
	        //TempFileName.MakeRelativeTo(wxPathOnly(wxTheApp->argv[0]));
            //edSource->SetValue(TempFileName.GetFullPath());
            edSource->SetValue(TempDirDlg.GetPath());
            DirectoryString = TempDirDlg.GetPath();
        }
    }
    else
    {
        OpenDialog->SetPath(wxPathOnly(wxTheApp->argv[0]));//app path
        if(OpenDialog->ShowModal() == wxID_OK)
        {
	       //wxFileName TempFileName(OpenDialog->GetPath());
	       //TempFileName.MakeRelativeTo(wxPathOnly(wxTheApp->argv[0]));
	       //edSource->SetValue(TempFileName.GetFullPath());
	       edSource->SetValue(OpenDialog->GetPath());
        }
    }
}
