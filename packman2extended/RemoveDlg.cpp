///---------------------------------------------------------------------------
///
/// @file        RemoveDlg.cpp
/// @author      Tony Reina and Edward Toovey (Sof.T)
/// Created:     6/17/2008 10:31:38 PM
/// @section DESCRIPTION
///          RemoveDlg class implementation
/// @version $Id$
///---------------------------------------------------------------

#include "DevPakInfo.h"
#include "InstallDevPak.h"
#include "RemoveDlg.h"

//Do not add custom headers
//wxDev-C++ designer will remove them
////Header Include Start
////Header Include End

//----------------------------------------------------------------------------
// RemoveDlg
//----------------------------------------------------------------------------
//Add Custom Events only in the appropriate block.
//Code added in other places will be removed by wxDev-C++
////Event Table Start
BEGIN_EVENT_TABLE(RemoveDlg,wxDialog)
    ////Manual Code Start
    ////Manual Code End

    EVT_CLOSE(RemoveDlg::OnClose)
    EVT_INIT_DIALOG(RemoveDlg::RemoveDlgInitDialog)
    EVT_TIMER(ID_WXTIMER1,RemoveDlg::WxTimer1Timer)
    EVT_BUTTON(ID_WXCANCEL,RemoveDlg::WxCancelClick)
END_EVENT_TABLE()
////Event Table End

RemoveDlg::RemoveDlg(wxWindow *parent, wxWindowID id, const wxString &title, const wxPoint &position, const wxSize& size, long style)
        : wxDialog(parent, id, title, position, size, style)
{
    CreateGUIControls();
}

RemoveDlg::~RemoveDlg()
{

}

void RemoveDlg::CreateGUIControls()
{
    //Do not add custom code between
    //GUI Items Creation Start and GUI Items Creation End.
    //wxDev-C++ designer will remove them.
    //Add the custom code before or after the blocks
    ////GUI Items Creation Start

    WxTimer1 = new wxTimer();
    WxTimer1->SetOwner(this, ID_WXTIMER1);
    WxTimer1->Start(100);

    WxCancel = new wxButton(this, ID_WXCANCEL, wxT("Abort"), wxPoint(152, 243), wxSize(87, 29), 0, wxDefaultValidator, wxT("WxCancel"));

    WxStaticText4 = new wxStaticText(this, ID_WXSTATICTEXT4, wxT("Files remaining"), wxPoint(68, 195), wxDefaultSize, 0, wxT("WxStaticText4"));
    WxStaticText4->SetFont(wxFont(9, wxSWISS, wxNORMAL, wxBOLD, false, wxT("Tahoma")));

    WxStaticText3 = new wxStaticText(this, ID_WXSTATICTEXT3, wxT("Files deleted"), wxPoint(84, 164), wxDefaultSize, 0, wxT("WxStaticText3"));
    WxStaticText3->SetFont(wxFont(9, wxSWISS, wxNORMAL, wxBOLD, false, wxT("Tahoma")));

    WxStaticText2 = new wxStaticText(this, ID_WXSTATICTEXT2, wxT("Total files"), wxPoint(103, 132), wxDefaultSize, 0, wxT("WxStaticText2"));
    WxStaticText2->SetFont(wxFont(9, wxSWISS, wxNORMAL, wxBOLD, false, wxT("Tahoma")));

    txtFilesRemaining = new wxStaticText(this, ID_TXTFILESREMAINING, wxT("txtFilesRemaining"), wxPoint(189, 195), wxDefaultSize, 0, wxT("txtFilesRemaining"));

    txtFilesDeleted = new wxStaticText(this, ID_TXTFILESDELETED, wxT("txtFilesDeleted"), wxPoint(189, 164), wxDefaultSize, 0, wxT("txtFilesDeleted"));

    txtTotalFiles = new wxStaticText(this, ID_TXTTOTALFILES, wxT("txtTotalFiles"), wxPoint(189, 132), wxDefaultSize, 0, wxT("txtTotalFiles"));

    WxGauge1 = new wxGauge(this, ID_WXGAUGE1, 100, wxPoint(48, 91), wxSize(292, 26), wxGA_HORIZONTAL, wxDefaultValidator, wxT("WxGauge1"));
    WxGauge1->SetRange(100);
    WxGauge1->SetValue(0);

    ProgressBox = new wxStaticBox(this, ID_PROGRESSBOX, wxT("Progress (0%)"), wxPoint(35, 60), wxSize(326, 171));

    WxStaticText1 = new wxStaticText(this, ID_WXSTATICTEXT1, wxT("Deleting file:"), wxPoint(18, 24), wxDefaultSize, 0, wxT("WxStaticText1"));
    WxStaticText1->SetFont(wxFont(9, wxSWISS, wxNORMAL, wxBOLD, false, wxT("Tahoma")));

    txtDeleteFile = new wxStaticText(this, ID_TXTDELETEFILE, wxT("%s"), wxPoint(104, 24), wxDefaultSize, 0, wxT("txtDeleteFile"));

    SetTitle(wxT("RemoveDlg"));
    SetIcon(wxNullIcon);
    SetSize(8,8,420,320);
    Center();

    ////GUI Items Creation End

}

void RemoveDlg::OnClose(wxCloseEvent& /*event*/)
{
    Destroy();
}

/*
 * WxTimer1Timer
 */
void RemoveDlg::WxTimer1Timer(wxTimerEvent& event)
{
    // The timer starts automatically.
    // With each tick, we evaluate the pakStatus
    // If IN_PROCESS, then we call RemoveFiles which
    //   removes the next file in the list
    // Once all files have been removed from the devpak,
    //  pakStatus becomes COMPLETED and we stop the timer
    //  and close the dialog
    // If abort button is pushed, pakStatus gets set to
    //   ABORTED and we close the dialog without further
    //   processing. NOTE: There's currently no way to
    //   un-delete any files that have been already deleted
    //   in the case of an abort.
    if (info->pakStatus == IN_PROCESS) {
        txtFilesRemaining->SetLabel(wxString::Format("%d", info->InstalledFiles.GetCount()-info->currentFileNumber));
        txtFilesDeleted->SetLabel(wxString::Format("%d", info->currentFileNumber));
        WxGauge1->SetValue(info->currentFileNumber);
        ProgressBox->SetLabel(wxString::Format("Progress (%d %%)", (int)(info->currentFileNumber * 100.0 / info->InstalledFiles.GetCount())));
        RemoveFiles();
    }

    if (info->pakStatus == COMPLETED) {

        // Remove the .entry file associated with this devpak.
        if (::wxFileExists(info->GetEntryFileName()))
            ::wxRemoveFile(info->GetEntryFileName());
        else
        {
            errordlg->AddError(info->GetEntryFileName() + wxT(" does not exist"));
            errordlg->Show(true);
        }

        Close();
    }

    if (info->pakStatus == ABORTED) {
        WxTimer1->Stop();
        wxMessageBox(wxT("Aborted"));
        Close();
    }
}

/*
 * RemoveDlgInitDialog
 */
void RemoveDlg::RemoveDlgInitDialog(wxInitDialogEvent& event)
{

    info->pakStatus = IN_PROCESS;
    info->currentFileNumber = 0;  // Index of the file to delete next
    SetTitle(wxT("Remove DevPak: " + info->AppName));
    WxGauge1->SetRange(info->InstalledFiles.GetCount());

    txtTotalFiles->SetLabel(wxString::Format("%d", info->InstalledFiles.GetCount()));

    // Set the working directory to the IDE installation directory
    // Most files are installed relative to that directory
    // If not, then they should be specified with the absolute directory
    //   path instead.
    ::wxSetWorkingDirectory(InstallDevPak::GetAppDir());

    // I don't think we need to explicitly close or delete the error window
    //   so long as it has a parent
    ErrorDlg *errordlg = new ErrorDlg(this);
    errordlg->Show(false);
    errordlg->ClearErrorList();

}

/*
 * WxCancelClick
 */
void RemoveDlg::WxCancelClick(wxCommandEvent& event)
{
    info->pakStatus = ABORTED;
}

// Delete/uninstall files from the devpak
bool RemoveDlg::RemoveFiles()
{
    wxString txtFileName;

    if (info->InstalledFiles.GetCount() > 0) {

        txtFileName = info->InstalledFiles.Item(info->currentFileNumber);

        txtFileName.Trim(true).Trim(false);
        txtDeleteFile->SetLabel(txtFileName);

        if (!txtFileName.IsEmpty()) {
            if (::wxFileExists(txtFileName)) {
                // Delete the file
                ::wxRemoveFile(info->InstalledFiles.Item(info->currentFileNumber));
                ::wxSafeYield();
            }
            else {
                errordlg->AddError(wxT("File '") + info->InstalledFiles.Item(info->currentFileNumber) + wxT("' does not exist."));
                errordlg->Show(true);
            }
        }
    }
    else {
        info->currentFileNumber = info->InstalledFiles.GetCount() + 1;
        errordlg->AddError(wxT("Warning! Entry has no files associated.\nMight be corrupted. Deleting entry file"));
        errordlg->Show(true);
    }

    info->currentFileNumber++;  // Set next index to delete

    // If next index is more than number of files to delete, then we are done.
    if (info->currentFileNumber >= info->InstalledFiles.GetCount())
        info->pakStatus = COMPLETED;

    return true;

}
