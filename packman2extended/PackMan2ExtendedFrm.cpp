//---------------------------------------------------------------------------
//
// Name:        PackMan2ExtendedFrm.cpp
// Author:      Tony Reina / Edward Toovey (Sof.T)
// Created:     3/18/2008 1:46:40 PM
// Description: PackMan2ExtendedFrm class implementation
// $Id$
//---------------------------------------------------------------------------

#include "PackMan2ExtendedFrm.h"
#include "InstallDlg.h"
#include "AboutDlg.h"
#include "Images/PackageLrg.xpm"

//Do not add custom headers between
//Header Include Start and Header Include End
//wxDev-C++ designer will remove them
////Header Include Start
#include "Images/PackMan2ExtendedFrm_ID_MNU_INSTALLPACKAGE_1002_XPM.xpm"
#include "Images/PackMan2ExtendedFrm_ID_MNU_VERIFYFILES_1003_XPM.xpm"
#include "Images/PackMan2ExtendedFrm_ID_MNU_RELOADDATABASE_1028_XPM.xpm"
#include "Images/PackMan2ExtendedFrm_ID_MNU_EXIT_1010_XPM.xpm"
#include "Images/PackMan2ExtendedFrm_ID_MNU_HELP_1030_XPM.xpm"
#include "Images/PackMan2ExtendedFrm_ID_MNU_ABOUT_1006_XPM.xpm"

#include "Images/PackMan2ExtendedFrm_btnExit_XPM.xpm"
#include "Images/PackMan2ExtendedFrm_btnAbout_XPM.xpm"
#include "Images/PackMan2ExtendedFrm_btnHelp_XPM.xpm"
#include "Images/PackMan2ExtendedFrm_btnRemove_XPM.xpm"
#include "Images/PackMan2ExtendedFrm_btnVerify_XPM.xpm"
#include "Images/PackMan2ExtendedFrm_btnInstall_XPM.xpm"
////Header Include End

//----------------------------------------------------------------------------
// PackMan2ExtendedFrm
//----------------------------------------------------------------------------
//Add Custom Events only in the appropriate block.
//Code added in other places will be removed by wxDev-C++
////Event Table Start
BEGIN_EVENT_TABLE(PackMan2ExtendedFrm,wxFrame)
    ////Manual Code Start
    ////Manual Code End

    EVT_CLOSE(PackMan2ExtendedFrm::OnClose)

    EVT_TEXT_URL(ID_EDTURL,PackMan2ExtendedFrm::edtUrlClickUrl)
    EVT_MENU(ID_MNU_INSTALLPACKAGE_1002, PackMan2ExtendedFrm::ActionInstallPackage)
    EVT_MENU(ID_MNU_VERIFYFILES_1003, PackMan2ExtendedFrm::ActionVerifyPackage)
    EVT_UPDATE_UI(ID_MNU_VERIFYFILES_1003, PackMan2ExtendedFrm::ActionVerifyUpdateUI)
    EVT_MENU(ID_MNU_DELETEPACKAGE_1004, PackMan2ExtendedFrm::ActionRemovePackage)
    EVT_UPDATE_UI(ID_MNU_DELETEPACKAGE_1004, PackMan2ExtendedFrm::ActionRemoveUpdate)
    EVT_MENU(ID_MNU_RELOADDATABASE_1028, PackMan2ExtendedFrm::MnuReloadDatabaseClick)
    EVT_MENU(ID_MNU_EXIT_1010, PackMan2ExtendedFrm::ActionExit)
    EVT_MENU(ID_MNU_DETAILS_CTRL_D_1031, PackMan2ExtendedFrm::ActionShowDetails)
    EVT_UPDATE_UI(ID_MNU_DETAILS_CTRL_D_1031, PackMan2ExtendedFrm::ActionShowDetailsUpdate)
    EVT_MENU(ID_MNU_SUBMENUITEM17_1033, PackMan2ExtendedFrm::ActionShowToolbar)
    EVT_UPDATE_UI(ID_MNU_SUBMENUITEM17_1033, PackMan2ExtendedFrm::ActionShowToolbarUpdate)
    EVT_MENU(ID_MNU_HELP_1030, PackMan2ExtendedFrm::ActionShowHelp)
    EVT_MENU(ID_MNU_ABOUT_1006, PackMan2ExtendedFrm::ActionShowAbout)

    EVT_LIST_ITEM_SELECTED(ID_LSTPACKAGES,PackMan2ExtendedFrm::lstPackagesSelected)
    EVT_MENU(ID_BTNEXIT,PackMan2ExtendedFrm::ActionExit)
    EVT_MENU(ID_BTNABOUT,PackMan2ExtendedFrm::ActionShowAbout)
    EVT_MENU(ID_BTNHELP,PackMan2ExtendedFrm::ActionShowHelp)
    EVT_MENU(ID_BTNREMOVE,PackMan2ExtendedFrm::ActionRemovePackage)
    EVT_UPDATE_UI(ID_BTNREMOVE,PackMan2ExtendedFrm::ActionRemoveUpdate)
    EVT_MENU(ID_BTNVERIFY,PackMan2ExtendedFrm::ActionVerifyPackage)
    EVT_UPDATE_UI(ID_BTNVERIFY,PackMan2ExtendedFrm::btnVerifyUpdateUI)
    EVT_MENU(ID_BTNINSTALL,PackMan2ExtendedFrm::ActionInstallPackage)
END_EVENT_TABLE()
////Event Table End

PackMan2ExtendedFrm::PackMan2ExtendedFrm(wxWindow *parent, wxWindowID id, const wxString &title, const wxPoint &position, const wxSize& size, long style)
        : wxFrame(parent, id, title, position, size, style)
{
    CreateGUIControls();
}

PackMan2ExtendedFrm::~PackMan2ExtendedFrm()
{

}

void PackMan2ExtendedFrm::CreateGUIControls()
{
    //Do not add custom code between
    //GUI Items Creation Start and GUI Items Creation End
    //wxDev-C++ designer will remove them.
    //Add the custom code before or after the blocks
    ////GUI Items Creation Start


    DockManager = new wxAuiManager(this, wxAUI_MGR_ALLOW_FLOATING  | wxAUI_MGR_TRANSPARENT_HINT  | wxAUI_MGR_HINT_FADE  | wxAUI_MGR_NO_VENETIAN_BLINDS_FADE );

    WxToolBar1 = new wxAuiToolBar(this, ID_WXTOOLBAR1, wxPoint(11, 2), wxSize(258, 48));

    wxBitmap btnInstall_BITMAP (PackMan2ExtendedFrm_btnInstall_XPM);
    wxBitmap btnInstall_DISABLE_BITMAP (wxNullBitmap);
    WxToolBar1->AddTool(ID_BTNINSTALL, wxT(""), btnInstall_BITMAP, btnInstall_DISABLE_BITMAP, wxITEM_NORMAL, wxT("Install a package"), wxT(""), NULL);

    wxBitmap btnVerify_BITMAP (PackMan2ExtendedFrm_btnVerify_XPM);
    wxBitmap btnVerify_DISABLE_BITMAP (wxNullBitmap);
    WxToolBar1->AddTool(ID_BTNVERIFY, wxT(""), btnVerify_BITMAP, btnVerify_DISABLE_BITMAP, wxITEM_NORMAL, wxT(""), wxT(""), NULL);

    wxBitmap btnRemove_BITMAP (PackMan2ExtendedFrm_btnRemove_XPM);
    wxBitmap btnRemove_DISABLE_BITMAP (wxNullBitmap);
    WxToolBar1->AddTool(ID_BTNREMOVE, wxT(""), btnRemove_BITMAP, btnRemove_DISABLE_BITMAP, wxITEM_NORMAL, wxT(""), wxT(""), NULL);

    wxBitmap btnHelp_BITMAP (PackMan2ExtendedFrm_btnHelp_XPM);
    wxBitmap btnHelp_DISABLE_BITMAP (wxNullBitmap);
    WxToolBar1->AddTool(ID_BTNHELP, wxT(""), btnHelp_BITMAP, btnHelp_DISABLE_BITMAP, wxITEM_NORMAL, wxT("Displays a help dialog"), wxT(""), NULL);

    wxBitmap btnAbout_BITMAP (PackMan2ExtendedFrm_btnAbout_XPM);
    wxBitmap btnAbout_DISABLE_BITMAP (wxNullBitmap);
    WxToolBar1->AddTool(ID_BTNABOUT, wxT(""), btnAbout_BITMAP, btnAbout_DISABLE_BITMAP, wxITEM_NORMAL, wxT("Displays the about dialog"), wxT(""), NULL);

    wxBitmap btnExit_BITMAP (PackMan2ExtendedFrm_btnExit_XPM);
    wxBitmap btnExit_DISABLE_BITMAP (wxNullBitmap);
    WxToolBar1->AddTool(ID_BTNEXIT, wxT(""), btnExit_BITMAP, btnExit_DISABLE_BITMAP, wxITEM_NORMAL, wxT("Quit the application"), wxT(""), NULL);

    nbkPackageDetails = new wxAuiNotebook(this, ID_NBKPACKAGEDETAILS, wxPoint(4, 57), wxSize(240, 379), wxNB_DEFAULT);
    DockManager->AddPane(nbkPackageDetails, wxAuiPaneInfo().Name(wxT("nbkPackageDetails_Pane")).Caption(wxT("Package Details")).Left().Dockable(false).CaptionVisible(true).DestroyOnClose(false).Floatable(false).Gripper(false).Resizable(false).CloseButton().Row(0).Position(0).Layer(0));

    WxNoteBookPage2 = new wxPanel(nbkPackageDetails, ID_WXNOTEBOOKPAGE2, wxPoint(4, 26), wxSize(232, 349));
    nbkPackageDetails->AddPage(WxNoteBookPage2, wxT("General"));

    WxStaticText1 = new wxStaticText(WxNoteBookPage2, ID_WXSTATICTEXT1, wxT("Package Name:"), wxPoint(9, 10), wxDefaultSize, 0, wxT("WxStaticText1"));

    edtPackageName = new wxTextCtrl(WxNoteBookPage2, ID_EDTPACKAGENAME, wxT(""), wxPoint(8, 30), wxSize(200, 22), wxTE_READONLY, wxDefaultValidator, wxT("edtPackageName"));

    WxStaticText2 = new wxStaticText(WxNoteBookPage2, ID_WXSTATICTEXT2, wxT("Package Version:"), wxPoint(9, 65), wxDefaultSize, 0, wxT("WxStaticText2"));

    edtPackageVersion = new wxTextCtrl(WxNoteBookPage2, ID_EDTPACKAGEVERSION, wxT(""), wxPoint(8, 83), wxSize(200, 22), wxTE_READONLY, wxDefaultValidator, wxT("edtPackageVersion"));

    WxStaticText3 = new wxStaticText(WxNoteBookPage2, ID_WXSTATICTEXT3, wxT("Package Description:"), wxPoint(9, 125), wxDefaultSize, 0, wxT("WxStaticText3"));

    mmoPackageDescription = new wxTextCtrl(WxNoteBookPage2, ID_MMOPACKAGEDESCRIPTION, wxEmptyString, wxPoint(8, 146), wxSize(200, 123), wxTE_READONLY | wxTE_MULTILINE, wxDefaultValidator, wxT("mmoPackageDescription"));
    mmoPackageDescription->SetMaxLength(0);
    mmoPackageDescription->SetFocus();
    mmoPackageDescription->SetInsertionPointEnd();

    lstFiles = new wxListBox(nbkPackageDetails, ID_LSTFILES, wxPoint(4, 26), wxSize(232, 349));
    nbkPackageDetails->AddPage(lstFiles, wxT("Files"));

    wxArrayString arrayStringFor_WxPackageInstalledFiles;
    WxPackageInstalledFiles = new wxListBox(lstFiles, ID_WXPACKAGEINSTALLEDFILES, wxPoint(1, 2), wxSize(204, 340), arrayStringFor_WxPackageInstalledFiles, wxLB_SINGLE | wxVSCROLL | wxHSCROLL);

    lstPackages = new wxListCtrl(this, ID_LSTPACKAGES, wxPoint(253, 55), wxSize(319, 378), wxLC_ICON | wxLC_AUTOARRANGE, wxDefaultValidator, wxT("lstPackages"));
    DockManager->AddPane(lstPackages, wxAuiPaneInfo().Name(wxT("lstPackages_Pane")).Caption(wxT("Package List")).Center().Dockable(false).CaptionVisible(false).DestroyOnClose(false).Floatable(true).Gripper(false).Resizable(true).Row(0).Position(0).Layer(0));

    WxStatusBar1 = new wxStatusBar(this, ID_WXSTATUSBAR1);

    WxMenuBar1 = new wxMenuBar();
    wxMenu *ID_MNU_FILE_1001_Mnu_Obj = new wxMenu(0);
    wxMenuItem * ID_MNU_INSTALLPACKAGE_1002_mnuItem_obj = new wxMenuItem (ID_MNU_FILE_1001_Mnu_Obj, ID_MNU_INSTALLPACKAGE_1002, wxT("&Install Package...\tCtrl+O"), wxT("Select and install a new library package"), wxITEM_NORMAL);
    wxBitmap ID_MNU_INSTALLPACKAGE_1002_mnuItem_obj_BMP(PackMan2ExtendedFrm_ID_MNU_INSTALLPACKAGE_1002_XPM);
    ID_MNU_INSTALLPACKAGE_1002_mnuItem_obj->SetBitmap(ID_MNU_INSTALLPACKAGE_1002_mnuItem_obj_BMP);
    ID_MNU_FILE_1001_Mnu_Obj->Append(ID_MNU_INSTALLPACKAGE_1002_mnuItem_obj);
    ID_MNU_FILE_1001_Mnu_Obj->AppendSeparator();
    wxMenuItem * ID_MNU_VERIFYFILES_1003_mnuItem_obj = new wxMenuItem (ID_MNU_FILE_1001_Mnu_Obj, ID_MNU_VERIFYFILES_1003, wxT("&Verify files\tAlt+V"), wxT("Verify the files contained"), wxITEM_NORMAL);
    wxBitmap ID_MNU_VERIFYFILES_1003_mnuItem_obj_BMP(PackMan2ExtendedFrm_ID_MNU_VERIFYFILES_1003_XPM);
    ID_MNU_VERIFYFILES_1003_mnuItem_obj->SetBitmap(ID_MNU_VERIFYFILES_1003_mnuItem_obj_BMP);
    ID_MNU_FILE_1001_Mnu_Obj->Append(ID_MNU_VERIFYFILES_1003_mnuItem_obj);
    ID_MNU_FILE_1001_Mnu_Obj->Append(ID_MNU_DELETEPACKAGE_1004, wxT("&Remove Package\tCtrl+A"), wxT("Uninstall an installed library"), wxITEM_NORMAL);
    ID_MNU_FILE_1001_Mnu_Obj->AppendSeparator();
    wxMenuItem * ID_MNU_RELOADDATABASE_1028_mnuItem_obj = new wxMenuItem (ID_MNU_FILE_1001_Mnu_Obj, ID_MNU_RELOADDATABASE_1028, wxT("Re&load Database\tF5"), wxT("Reload the package database"), wxITEM_NORMAL);
    wxBitmap ID_MNU_RELOADDATABASE_1028_mnuItem_obj_BMP(PackMan2ExtendedFrm_ID_MNU_RELOADDATABASE_1028_XPM);
    ID_MNU_RELOADDATABASE_1028_mnuItem_obj->SetBitmap(ID_MNU_RELOADDATABASE_1028_mnuItem_obj_BMP);
    ID_MNU_FILE_1001_Mnu_Obj->Append(ID_MNU_RELOADDATABASE_1028_mnuItem_obj);
    ID_MNU_FILE_1001_Mnu_Obj->AppendSeparator();
    wxMenuItem * ID_MNU_EXIT_1010_mnuItem_obj = new wxMenuItem (ID_MNU_FILE_1001_Mnu_Obj, ID_MNU_EXIT_1010, wxT("E&xit\\Ctrl+Q"), wxT("Quit the application"), wxITEM_NORMAL);
    wxBitmap ID_MNU_EXIT_1010_mnuItem_obj_BMP(PackMan2ExtendedFrm_ID_MNU_EXIT_1010_XPM);
    ID_MNU_EXIT_1010_mnuItem_obj->SetBitmap(ID_MNU_EXIT_1010_mnuItem_obj_BMP);
    ID_MNU_FILE_1001_Mnu_Obj->Append(ID_MNU_EXIT_1010_mnuItem_obj);
    WxMenuBar1->Append(ID_MNU_FILE_1001_Mnu_Obj, wxT("&Package"));

    wxMenu *wxID_STATIC_Mnu_Obj = new wxMenu(0);
    wxID_STATIC_Mnu_Obj->Append(ID_MNU_DETAILS_CTRL_D_1031, wxT("&Details\\Ctrl+D"), wxT("Show/hide the package details side bar"), wxITEM_CHECK);
    wxID_STATIC_Mnu_Obj->Check(ID_MNU_DETAILS_CTRL_D_1031,true);
    wxID_STATIC_Mnu_Obj->AppendSeparator();
    wxID_STATIC_Mnu_Obj->Append(ID_MNU_SUBMENUITEM17_1033, wxT("&Toolbar"), wxT("Show/hide the toolbar"), wxITEM_CHECK);
    wxID_STATIC_Mnu_Obj->Check(ID_MNU_SUBMENUITEM17_1033,true);
    WxMenuBar1->Append(wxID_STATIC_Mnu_Obj, wxT("&View"));

    wxMenu *ID_MNU_HELP_1005_Mnu_Obj = new wxMenu(0);
    wxMenuItem * ID_MNU_HELP_1030_mnuItem_obj = new wxMenuItem (ID_MNU_HELP_1005_Mnu_Obj, ID_MNU_HELP_1030, wxT("&Help\tF1"), wxT("Display help dialog"), wxITEM_NORMAL);
    wxBitmap ID_MNU_HELP_1030_mnuItem_obj_BMP(PackMan2ExtendedFrm_ID_MNU_HELP_1030_XPM);
    ID_MNU_HELP_1030_mnuItem_obj->SetBitmap(ID_MNU_HELP_1030_mnuItem_obj_BMP);
    ID_MNU_HELP_1005_Mnu_Obj->Append(ID_MNU_HELP_1030_mnuItem_obj);
    wxMenuItem * ID_MNU_ABOUT_1006_mnuItem_obj = new wxMenuItem (ID_MNU_HELP_1005_Mnu_Obj, ID_MNU_ABOUT_1006, wxT("&About..."), wxT("Display about dialog"), wxITEM_NORMAL);
    wxBitmap ID_MNU_ABOUT_1006_mnuItem_obj_BMP(PackMan2ExtendedFrm_ID_MNU_ABOUT_1006_XPM);
    ID_MNU_ABOUT_1006_mnuItem_obj->SetBitmap(ID_MNU_ABOUT_1006_mnuItem_obj_BMP);
    ID_MNU_HELP_1005_Mnu_Obj->Append(ID_MNU_ABOUT_1006_mnuItem_obj);
    WxMenuBar1->Append(ID_MNU_HELP_1005_Mnu_Obj, wxT("Help"));
    SetMenuBar(WxMenuBar1);

    edtUrl = new wxTextCtrl(WxNoteBookPage2, ID_EDTURL, wxT(""), wxPoint(8, 298), wxSize(200, 19), wxTE_READONLY | wxTE_RICH | wxTE_AUTO_URL, wxDefaultValidator, wxT("edtUrl"));
    edtUrl->SetBackgroundColour(*wxLIGHT_GREY);

    WebsiteLabel = new wxStaticText(WxNoteBookPage2, ID_WEBSITELABEL, wxT("Website"), wxPoint(9, 280), wxDefaultSize, 0, wxT("WebsiteLabel"));

    SetStatusBar(WxStatusBar1);
    WxToolBar1->SetToolBitmapSize(wxSize(32,32));
    WxToolBar1->Realize();
    DockManager->AddPane(WxToolBar1, wxAuiPaneInfo().Name(wxT("WxAuiToolBar1_Pane")).Caption(wxT("WxAuiToolBar1")).Top().Dockable(false).CaptionVisible(false).DestroyOnClose(false).Floatable(false).Gripper(false).ToolbarPane().Row(0).Position(0).Layer(10));
    SetTitle(wxT("PackMan2Extended"));
    SetIcon(wxNullIcon);
    SetSize(8,8,646,499);
    Center();
    DockManager->Update();

    ////GUI Items Creation End

    //Create package imagelist
    wxImageList * PackageImageList = new wxImageList(48,48);
    PackageImageList->Add(wxBitmap(PackageLrg_xpm));
    lstPackages->AssignImageList(PackageImageList,wxIMAGE_LIST_NORMAL);

    UpdatePackageList();
    selectedPackage = -1;

}

void PackMan2ExtendedFrm::OnClose(wxCloseEvent& event)
{
    Destroy();
}

// Initializes a vector called entryInfo
//    which will store the devpak info (e.g.
//    filenames, app name, version, etc.) for
//    all installed packages
void PackMan2ExtendedFrm::UpdatePackageList()
{

    DevPakInfo info;

    lstPackages->ClearAll();

    // entryInfo is a vector containing the devpak info for all currently installed packages
    entryInfo.clear();  // Clear vector of devpakinfo

    info.SetEntryFileName("*.entry");  // Set the entry to wildcard name
    wxString fEntryName = wxFindFirstFile(info.GetEntryFileName());

    int ii = 0;
    // Go through each .entry file in the Packages directory to get the devpak info
    while ( !fEntryName.empty() )
    {
        info.SetEntryFileName(fEntryName);
        InstallDevPak::ReadEntryFile(&info);  // Read the devpak info from the entry file
        entryInfo.push_back(info);  // Store the devpak entry info in a STL vector

        lstPackages->InsertItem(ii, info.AppName,0);

        ii++;
        fEntryName = wxFindNextFile();

    }

    // Unselect packages
    selectedPackage = -1;

    edtUrl->SetValue("");
    mmoPackageDescription->SetValue("");
    edtPackageVersion->SetValue("");
    edtPackageName->SetValue("");

    WxPackageInstalledFiles->Clear();

}

/*
 * WxToolBar1Menu
 */
void PackMan2ExtendedFrm::WxToolBar1Menu(wxCommandEvent& event)
{
    // insert your code here
}

void PackMan2ExtendedFrm::ActionShowHelp(wxCommandEvent& event)
{
    wxMessageBox(wxString(wxT("Package Manager is a tool to install and manage addon\n"))
                 + wxT("libraries for wxDev-C++.\n\n")
                 + wxT("To install a library, click on the Install button and select a\n")
                 + wxT(".DevPak file or .DevPackage file, and follow the instructions.\n")
                 + wxT("To uninstall an installed library, select it and click on the\n")
                 + wxT("Remove button."),wxT("Help"),wxICON_INFORMATION);
}

// Show the About dialog box
void PackMan2ExtendedFrm::ActionShowAbout(wxCommandEvent& event)
{
    AboutDlg About(this);
    About.ShowModal();
}

// Remove/uninstall a devpak
void PackMan2ExtendedFrm::ActionRemovePackage(wxCommandEvent& event)
{
    // Remove the devpak and update the package list
    InstallDevPak::RemoveDevPak(&(entryInfo.at(selectedPackage)));
    UpdatePackageList();

}
void PackMan2ExtendedFrm::ActionInstallPackage(wxCommandEvent& event)
{

    InstallDlg *dlg = new InstallDlg(this);
    if ( dlg->ShowModal() == wxID_OK );
    UpdatePackageList();

}

// Verify DevPak
// Determines if the files listed in the DevPak entry info are actually
//    present in the correct directories. If not, gives a list of files not
//    found.
void PackMan2ExtendedFrm::ActionVerifyPackage(wxCommandEvent& event)
{
    if (!InstallDevPak::VerifyDevPak(&(entryInfo.at(selectedPackage))));

}
void PackMan2ExtendedFrm::ActionExit(wxCommandEvent& event)
{
    Destroy();
}

/*
 * lstPackagesSelected
 * Updates GUI with the DevPak information for the selected package
 */
void PackMan2ExtendedFrm::lstPackagesSelected(wxListEvent& event)
{
    selectedPackage = event.GetIndex();
    // Grab the devpak info from the entryInfo vector at the selected package's index
    DevPakInfo info = entryInfo.at(selectedPackage);

    // Fill devpak info in GUI
    edtUrl->SetValue(info.Url);
    mmoPackageDescription->SetValue(info.Description);
    edtPackageVersion->SetValue(info.AppVersion);
    edtPackageName->SetValue(info.AppName);

    // Fill file list with names of installed files from package
    WxPackageInstalledFiles->Clear();
    if (info.InstalledFiles.GetCount() > 0) {
        for (size_t ii = 0; ii < info.InstalledFiles.GetCount(); ii++) {
            WxPackageInstalledFiles->Append(wxT(info.InstalledFiles.Item(ii)));
        }
    }

}

void PackMan2ExtendedFrm::ActionRemoveUpdate(wxUpdateUIEvent &event)
{
    if (lstPackages->GetSelectedItemCount() > 0)
        event.Enable(true);
    else
        event.Enable(false);
}

void PackMan2ExtendedFrm::ActionShowDetailsUpdate(wxUpdateUIEvent &event)
{
    if (DockManager->GetPane(nbkPackageDetails).IsShown())
        event.Check(true);
    else
        event.Check(false);
}

void PackMan2ExtendedFrm::ActionShowToolbarUpdate(wxUpdateUIEvent &event)
{
    if (DockManager->GetPane(WxToolBar1).IsShown())
        event.Check(true);
    else
        event.Check(false);
}

/*
 * ActionShowDetails
 */
void PackMan2ExtendedFrm::ActionShowDetails(wxCommandEvent& event)
{
    if (event.IsChecked())
    {
        DockManager->GetPane(nbkPackageDetails).Show(true);
    }
    else
    {
        DockManager->GetPane(nbkPackageDetails).Show(false);
    }
    DockManager->Update();
}

/*
 * ActionShowToolbar
 */
void PackMan2ExtendedFrm::ActionShowToolbar(wxCommandEvent& event)
{
    if (event.IsChecked())
        DockManager->GetPane(WxToolBar1).Show(true);
    else
        DockManager->GetPane(WxToolBar1).Show(false);

    DockManager->Update();
}

/*
 * MnuReloadDatabaseClick
 */
void PackMan2ExtendedFrm::MnuReloadDatabaseClick(wxCommandEvent& event)
{
    UpdatePackageList();
}

/*
 * btnVerifyUpdateUI
 */
void PackMan2ExtendedFrm::btnVerifyUpdateUI(wxUpdateUIEvent& event)
{
    if (lstPackages->GetSelectedItemCount() > 0)
        event.Enable(true);
    else
        event.Enable(false);
}

/*
 * ActionVerifyUpdateUI
 */
void PackMan2ExtendedFrm::ActionVerifyUpdateUI(wxUpdateUIEvent& event)
{
    if (lstPackages->GetSelectedItemCount() > 0)
        event.Enable(true);
    else
        event.Enable(false);
}

/*
 * edtUrlClickUrl
 */
void PackMan2ExtendedFrm::edtUrlClickUrl(wxTextUrlEvent& event)
{
    wxString url = edtUrl->GetValue();
    // if (::wxLaunchDefaultBrowser(url));
    wxMessageBox(url);

}
