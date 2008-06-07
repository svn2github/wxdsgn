//---------------------------------------------------------------------------
//
// Name:        PackMaker2Frm.cpp
// Author:      Programming
// Created:     14/05/2007 17:42:15
// Description: PackMaker2Frm class implementation
//
//---------------------------------------------------------------------------

#include "PackMaker2Frm.h"

//Do not add custom headers between
//Header Include Start and Header Include End
//wxDev-C++ designer will remove them
////Header Include Start
#include "Images/PackMaker2Frm_ID_MNU_NEW_1082_XPM.xpm"
#include "Images/PackMaker2Frm_ID_MNU_OPEN____1084_XPM.xpm"
#include "Images/PackMaker2Frm_ID_MNU_SAVE_1086_XPM.xpm"
#include "Images/PackMaker2Frm_ID_MNU_SAVEAS____1087_XPM.xpm"
#include "Images/PackMaker2Frm_ID_MNU_BUILD_1089_XPM.xpm"
#include "Images/PackMaker2Frm_ID_MNU_EXIT_1091_XPM.xpm"
#include "Images/PackMaker2Frm_ID_MNU_ABOUT_1092_XPM.xpm"

#include "Images/PackMaker2Frm_WxToolButton6_XPM.xpm"
#include "Images/PackMaker2Frm_WxToolButton5_XPM.xpm"
#include "Images/PackMaker2Frm_WxToolButton4_XPM.xpm"
#include "Images/PackMaker2Frm_WxToolButton3_XPM.xpm"
#include "Images/PackMaker2Frm_WxToolButton2_XPM.xpm"
#include "Images/PackMaker2Frm_WxToolButton1_XPM.xpm"
#include "Images/PackMaker2Frm_btnRemove_XPM.xpm"
#include "Images/PackMaker2Frm_btnAddFile_XPM.xpm"
#include "Images/PackMaker2Frm_btnAddDir_XPM.xpm"
#include "Images/PackMaker2Frm_btnRemoveIcon_XPM.xpm"
#include "Images/PackMaker2Frm_btnEditItem_XPM.xpm"
#include "Images/PackMaker2Frm_btnAddItem_XPM.xpm"
#include "Images/PackMaker2Frm_btnPicture_XPM.xpm"
#include "Images/PackMaker2Frm_btnLicense_XPM.xpm"
#include "Images/PackMaker2Frm_btnReadMe_XPM.xpm"
////Header Include End
#include <wx/filefn.h>
#include <wx/filename.h>
#include <wx/wfstream.h>
#include <wx/tarstrm.h>
#include <wx/dir.h>
#include <wx/sstream.h>
#include <3rdparty/wx/bzipstream.h>

#include "MenuForm.h"
#include "FileForm.h"
//----------------------------------------------------------------------------
// PackMaker2Frm
//----------------------------------------------------------------------------
//Add Custom Events only in the appropriate block.
//Code added in other places will be removed by wxDev-C++
////Event Table Start
BEGIN_EVENT_TABLE(PackMaker2Frm,wxFrame)
	////Manual Code Start
	////Manual Code End
	
	EVT_CLOSE(PackMaker2Frm::OnClose)
	EVT_MENU(ID_MNU_OPEN____1084, PackMaker2Frm::Mnuopen1084Click)
	EVT_MENU(ID_MNU_SAVE_1086, PackMaker2Frm::Mnusave1086Click)
	EVT_MENU(ID_MNU_SAVEAS____1087, PackMaker2Frm::Mnusaveas1087Click)
	EVT_MENU(ID_MNU_BUILD_1089, PackMaker2Frm::Mnubuild1089Click)
	EVT_MENU(ID_MNU_EXIT_1091, PackMaker2Frm::Mnuexit1091Click)
	EVT_MENU(ID_MNU_ABOUT_1092, PackMaker2Frm::Mnuabout1092Click)
	EVT_MENU(ID_WXTOOLBUTTON6,PackMaker2Frm::WxToolButton6Click)
	EVT_MENU(ID_WXTOOLBUTTON5,PackMaker2Frm::WxToolButton5Click)
	EVT_MENU(ID_WXTOOLBUTTON4,PackMaker2Frm::WxToolButton4Click)
	EVT_MENU(ID_WXTOOLBUTTON3,PackMaker2Frm::WxToolButton3Click)
	EVT_MENU(ID_WXTOOLBUTTON2,PackMaker2Frm::WxToolButton2Click)
	EVT_MENU(ID_WXTOOLBUTTON1,PackMaker2Frm::WxToolButton1Click)
	EVT_BUTTON(ID_BTNREMOVE,PackMaker2Frm::btnRemoveClick)
	EVT_BUTTON(ID_BTNADDFILE,PackMaker2Frm::btnAddFileClick)
	EVT_BUTTON(ID_BTNADDDIR,PackMaker2Frm::btnAddDirClick)
	EVT_BUTTON(ID_BTNREMOVEICON,PackMaker2Frm::btnRemoveIconClick)
	EVT_BUTTON(ID_BTNEDITITEM,PackMaker2Frm::btnEditItemClick)
	EVT_BUTTON(ID_BTNADDITEM,PackMaker2Frm::btnAddItemClick)
	EVT_BUTTON(ID_BTNPICTURE,PackMaker2Frm::btnPictureClick)
	EVT_BUTTON(ID_BTNLICENSE,PackMaker2Frm::btnLicenseClick)
	EVT_BUTTON(ID_BTNREADME,PackMaker2Frm::btnReadMeClick)
	
	EVT_TEXT(ID_EDLICENSE,PackMaker2Frm::WxEdit4Updated)
	
	EVT_TEXT(ID_EDREADME,PackMaker2Frm::edReadMeUpdated1)
	
	EVT_TEXT(ID_EDNAME,PackMaker2Frm::edNameUpdated)
END_EVENT_TABLE()
////Event Table End

PackMaker2Frm::PackMaker2Frm(wxWindow *parent, wxWindowID id, const wxString &title, const wxPoint &position, const wxSize& size, long style)
: wxFrame(parent, id, title, position, size, style)
{
	CreateGUIControls();
	IniFile = NULL;
	buildForm = NULL;
}

PackMaker2Frm::~PackMaker2Frm()
{
}

void PackMaker2Frm::CreateGUIControls()
{
	//Do not add custom code between
	//GUI Items Creation Start and GUI Items Creation End
	//wxDev-C++ designer will remove them.
	//Add the custom code before or after the blocks
	////GUI Items Creation Start

	WxPanel1 = new wxPanel(this, ID_WXPANEL1, wxPoint(0,29), wxSize(569,339));

	WxStaticBox1 = new wxStaticBox(WxPanel1, ID_WXSTATICBOX1, wxT(" Setup Info : "), wxPoint(7,7), wxSize(225,94));

	WxStaticBox2 = new wxStaticBox(WxPanel1, ID_WXSTATICBOX2, wxT(" Optional Info : "), wxPoint(7,110), wxSize(225,205));

	WxStaticBox3 = new wxStaticBox(WxPanel1, ID_WXSTATICBOX3, wxT(" Start Menu Icons : "), wxPoint(239,7), wxSize(319,105));

	WxStaticBox4 = new wxStaticBox(WxPanel1, ID_WXSTATICBOX4, wxT(" Files/Directories to install : "), wxPoint(239,117), wxSize(320,198));

	lblName = new wxStaticText(WxPanel1, ID_LBLNAME, wxT("Package Name :"), wxPoint(15,28), wxDefaultSize, 0, wxT("lblName"));

	WxStaticText2 = new wxStaticText(WxPanel1, ID_WXSTATICTEXT2, wxT("Name and Version : "), wxPoint(15,48), wxDefaultSize, 0, wxT("WxStaticText2"));

	lblVersion = new wxStaticText(WxPanel1, ID_LBLVERSION, wxT("Version :"), wxPoint(15,67), wxDefaultSize, 0, wxT("lblVersion"));

	edName = new wxTextCtrl(WxPanel1, ID_EDNAME, wxT("MyPackage"), wxPoint(113,26), wxSize(111,17), 0, wxDefaultValidator, wxT("edName"));

	edNameVersion = new wxTextCtrl(WxPanel1, ID_EDNAMEVERSION, wxT("MyPackage version 1.0"), wxPoint(113,45), wxSize(111,17), 0, wxDefaultValidator, wxT("edNameVersion"));

	edVersion = new wxTextCtrl(WxPanel1, ID_EDVERSION, wxT("1.0"), wxPoint(113,65), wxSize(111,17), 0, wxDefaultValidator, wxT("edVersion"));

	lblDescription = new wxStaticText(WxPanel1, ID_LBLDESCRIPTION, wxT("Description :"), wxPoint(15,133), wxDefaultSize, 0, wxT("lblDescription"));

	lblURL = new wxStaticText(WxPanel1, ID_LBLURL, wxT("URL :"), wxPoint(15,153), wxDefaultSize, 0, wxT("lblURL"));

	lblReadMe = new wxStaticText(WxPanel1, ID_LBLREADME, wxT("ReadMe File :"), wxPoint(15,172), wxDefaultSize, 0, wxT("lblReadMe"));

	lblLicense = new wxStaticText(WxPanel1, ID_LBLLICENSE, wxT("License File :"), wxPoint(15,192), wxDefaultSize, 0, wxT("lblLicense"));

	lblPicture = new wxStaticText(WxPanel1, ID_LBLPICTURE, wxT("Picture File :"), wxPoint(15,211), wxDefaultSize, 0, wxT("lblPicture"));

	lblStartMenu = new wxStaticText(WxPanel1, ID_LBLSTARTMENU, wxT("Start Menu Group :"), wxPoint(15,231), wxDefaultSize, 0, wxT("lblStartMenu"));

	lblDepends = new wxStaticText(WxPanel1, ID_LBLDEPENDS, wxT("Depends on packages (separate by a \",\")"), wxPoint(15,252), wxDefaultSize, 0, wxT("lblDepends"));

	edDescription = new wxTextCtrl(WxPanel1, ID_EDDESCRIPTION, wxT(""), wxPoint(112,133), wxSize(111,17), 0, wxDefaultValidator, wxT("edDescription"));

	edURL = new wxTextCtrl(WxPanel1, ID_EDURL, wxT(""), wxPoint(112,153), wxSize(111,16), 0, wxDefaultValidator, wxT("edURL"));

	edReadMe = new wxTextCtrl(WxPanel1, ID_EDREADME, wxT(""), wxPoint(112,172), wxSize(90,17), 0, wxDefaultValidator, wxT("edReadMe"));

	edLicense = new wxTextCtrl(WxPanel1, ID_EDLICENSE, wxT(""), wxPoint(112,192), wxSize(90,16), 0, wxDefaultValidator, wxT("edLicense"));

	edPicture = new wxTextCtrl(WxPanel1, ID_EDPICTURE, wxT(""), wxPoint(112,211), wxSize(90,17), 0, wxDefaultValidator, wxT("edPicture"));

	edStartMenu = new wxTextCtrl(WxPanel1, ID_EDSTARTMENU, wxT(""), wxPoint(112,231), wxSize(111,16), 0, wxDefaultValidator, wxT("edStartMenu"));

	edDepend = new wxTextCtrl(WxPanel1, ID_EDDEPEND, wxT(""), wxPoint(15,269), wxSize(203,16), 0, wxDefaultValidator, wxT("edDepend"));

	chbReboot = new wxCheckBox(WxPanel1, ID_CHBREBOOT, wxT("Reboot system after install"), wxPoint(15,289), wxSize(133,13), 0, wxDefaultValidator, wxT("chbReboot"));

	wxBitmap btnReadMe_BITMAP (PackMaker2Frm_btnReadMe_XPM);
	btnReadMe = new wxBitmapButton(WxPanel1, ID_BTNREADME, btnReadMe_BITMAP, wxPoint(207,172), wxSize(16,17), wxBU_AUTODRAW, wxDefaultValidator, wxT("btnReadMe"));

	wxBitmap btnLicense_BITMAP (PackMaker2Frm_btnLicense_XPM);
	btnLicense = new wxBitmapButton(WxPanel1, ID_BTNLICENSE, btnLicense_BITMAP, wxPoint(207,192), wxSize(16,16), wxBU_AUTODRAW, wxDefaultValidator, wxT("btnLicense"));

	wxBitmap btnPicture_BITMAP (PackMaker2Frm_btnPicture_XPM);
	btnPicture = new wxBitmapButton(WxPanel1, ID_BTNPICTURE, btnPicture_BITMAP, wxPoint(207,211), wxSize(16,17), wxBU_AUTODRAW, wxDefaultValidator, wxT("btnPicture"));

	wxBitmap btnAddItem_BITMAP (PackMaker2Frm_btnAddItem_XPM);
	btnAddItem = new wxBitmapButton(WxPanel1, ID_BTNADDITEM, btnAddItem_BITMAP, wxPoint(269,23), wxSize(61,20), wxBU_AUTODRAW, wxDefaultValidator, wxT("btnAddItem"));
	btnAddItem->SetToolTip(wxT("Add Icon"));
	btnAddItem->SetHelpText(wxT("Add Icon"));

	wxBitmap btnEditItem_BITMAP (PackMaker2Frm_btnEditItem_XPM);
	btnEditItem = new wxBitmapButton(WxPanel1, ID_BTNEDITITEM, btnEditItem_BITMAP, wxPoint(347,23), wxSize(61,20), wxBU_AUTODRAW, wxDefaultValidator, wxT("btnEditItem"));
	btnEditItem->SetToolTip(wxT("Edit Icon"));
	btnEditItem->SetHelpText(wxT("Edit Icon"));

	wxBitmap btnRemoveIcon_BITMAP (PackMaker2Frm_btnRemoveIcon_XPM);
	btnRemoveIcon = new wxBitmapButton(WxPanel1, ID_BTNREMOVEICON, btnRemoveIcon_BITMAP, wxPoint(430,23), wxSize(61,20), wxBU_AUTODRAW, wxDefaultValidator, wxT("btnRemoveIcon"));
	btnRemoveIcon->SetToolTip(wxT("Remove Icon"));
	btnRemoveIcon->SetHelpText(wxT("Remove Icon"));

	IconView = new wxListCtrl(WxPanel1, ID_ICONVIEW, wxPoint(244,47), wxSize(304,58), wxLC_REPORT);
	IconView->InsertColumn(0,wxT("Icon"),wxLIST_FORMAT_LEFT,67 );
	IconView->InsertColumn(0,wxT("Target"),wxLIST_FORMAT_LEFT,111 );
	IconView->InsertColumn(0,wxT("Name"),wxLIST_FORMAT_LEFT,107 );

	wxBitmap btnAddDir_BITMAP (PackMaker2Frm_btnAddDir_XPM);
	btnAddDir = new wxBitmapButton(WxPanel1, ID_BTNADDDIR, btnAddDir_BITMAP, wxPoint(270,134), wxSize(61,20), wxBU_AUTODRAW, wxDefaultValidator, wxT("btnAddDir"));
	btnAddDir->SetToolTip(wxT("Add directory to devpak"));
	btnAddDir->SetHelpText(wxT("Add directory to devpak"));

	wxBitmap btnAddFile_BITMAP (PackMaker2Frm_btnAddFile_XPM);
	btnAddFile = new wxBitmapButton(WxPanel1, ID_BTNADDFILE, btnAddFile_BITMAP, wxPoint(350,134), wxSize(61,20), wxBU_AUTODRAW, wxDefaultValidator, wxT("btnAddFile"));
	btnAddFile->SetToolTip(wxT("Add file to devpak"));
	btnAddFile->SetHelpText(wxT("Add file to devpak"));

	wxBitmap btnRemove_BITMAP (PackMaker2Frm_btnRemove_XPM);
	btnRemove = new wxBitmapButton(WxPanel1, ID_BTNREMOVE, btnRemove_BITMAP, wxPoint(432,134), wxSize(61,20), wxBU_AUTODRAW, wxDefaultValidator, wxT("btnRemove"));
	btnRemove->SetToolTip(wxT("Delete selection from devpak"));
	btnRemove->SetHelpText(wxT("Delete from devpak"));

	FileView = new wxListCtrl(WxPanel1, ID_FILEVIEW, wxPoint(242,160), wxSize(303,148), wxLC_REPORT);
	FileView->InsertColumn(0,wxT("Is Directory"),wxLIST_FORMAT_LEFT,73 );
	FileView->InsertColumn(0,wxT("Destination"),wxLIST_FORMAT_LEFT,124 );
	FileView->InsertColumn(0,wxT("Source"),wxLIST_FORMAT_LEFT,100 );

	WxToolBar1 = new wxToolBar(this, ID_WXTOOLBAR1, wxPoint(0,0), wxSize(569,29));

	/* New devpak file descriptor
	*/
	wxBitmap WxToolButton1_BITMAP (PackMaker2Frm_WxToolButton1_XPM);
	wxBitmap WxToolButton1_DISABLE_BITMAP (wxNullBitmap);
	WxToolBar1->AddTool(ID_WXTOOLBUTTON1, wxT(""), WxToolButton1_BITMAP, WxToolButton1_DISABLE_BITMAP, wxITEM_NORMAL, wxT("New File"), wxT("New file"));

	/* Open new devpak file descriptor
	*/
	wxBitmap WxToolButton2_BITMAP (PackMaker2Frm_WxToolButton2_XPM);
	wxBitmap WxToolButton2_DISABLE_BITMAP (wxNullBitmap);
	WxToolBar1->AddTool(ID_WXTOOLBUTTON2, wxT(""), WxToolButton2_BITMAP, WxToolButton2_DISABLE_BITMAP, wxITEM_NORMAL, wxT("Open File"), wxT("Open file"));

	WxToolBar1->AddSeparator();

	/* Saves the devpak file descriptor
	*/
	wxBitmap WxToolButton3_BITMAP (PackMaker2Frm_WxToolButton3_XPM);
	wxBitmap WxToolButton3_DISABLE_BITMAP (wxNullBitmap);
	WxToolBar1->AddTool(ID_WXTOOLBUTTON3, wxT(""), WxToolButton3_BITMAP, WxToolButton3_DISABLE_BITMAP, wxITEM_NORMAL, wxT("Save File"), wxT("Save File"));

	/* Saves the devpak file descriptor with new file name
	*/
	wxBitmap WxToolButton4_BITMAP (PackMaker2Frm_WxToolButton4_XPM);
	wxBitmap WxToolButton4_DISABLE_BITMAP (wxNullBitmap);
	WxToolBar1->AddTool(ID_WXTOOLBUTTON4, wxT(""), WxToolButton4_BITMAP, WxToolButton4_DISABLE_BITMAP, wxITEM_NORMAL, wxT("Save File As..."), wxT("Save As..."));

	WxToolBar1->AddSeparator();

	/* Start the package build
	*/
	wxBitmap WxToolButton5_BITMAP (PackMaker2Frm_WxToolButton5_XPM);
	wxBitmap WxToolButton5_DISABLE_BITMAP (wxNullBitmap);
	WxToolBar1->AddTool(ID_WXTOOLBUTTON5, wxT(""), WxToolButton5_BITMAP, WxToolButton5_DISABLE_BITMAP, wxITEM_NORMAL, wxT("Build package"), wxT("Build package"));

	WxToolBar1->AddSeparator();

	/* About box
	*/
	wxBitmap WxToolButton6_BITMAP (PackMaker2Frm_WxToolButton6_XPM);
	wxBitmap WxToolButton6_DISABLE_BITMAP (wxNullBitmap);
	WxToolBar1->AddTool(ID_WXTOOLBUTTON6, wxT(""), WxToolButton6_BITMAP, WxToolButton6_DISABLE_BITMAP, wxITEM_NORMAL, wxT("About box"), wxT(""));

	WxStatusBar1 = new wxStatusBar(this, ID_WXSTATUSBAR1);

	WxMenuBar1 = new wxMenuBar();
	wxMenu *ID_MNU_FILE_1080_Mnu_Obj = new wxMenu(0);
	wxMenuItem * ID_MNU_NEW_1082_mnuItem_obj = new wxMenuItem (ID_MNU_FILE_1080_Mnu_Obj, ID_MNU_NEW_1082, wxT("&New...\tCtrl+N"), wxT("Create a new package"), wxITEM_NORMAL);
	wxBitmap ID_MNU_NEW_1082_mnuItem_obj_BMP(PackMaker2Frm_ID_MNU_NEW_1082_XPM);
	ID_MNU_NEW_1082_mnuItem_obj->SetBitmap(ID_MNU_NEW_1082_mnuItem_obj_BMP);
	ID_MNU_FILE_1080_Mnu_Obj->Append(ID_MNU_NEW_1082_mnuItem_obj);
	ID_MNU_FILE_1080_Mnu_Obj->AppendSeparator();
	wxMenuItem * ID_MNU_OPEN____1084_mnuItem_obj = new wxMenuItem (ID_MNU_FILE_1080_Mnu_Obj, ID_MNU_OPEN____1084, wxT("&Open...\tCtrl+O"), wxT("Open an existing package"), wxITEM_NORMAL);
	wxBitmap ID_MNU_OPEN____1084_mnuItem_obj_BMP(PackMaker2Frm_ID_MNU_OPEN____1084_XPM);
	ID_MNU_OPEN____1084_mnuItem_obj->SetBitmap(ID_MNU_OPEN____1084_mnuItem_obj_BMP);
	ID_MNU_FILE_1080_Mnu_Obj->Append(ID_MNU_OPEN____1084_mnuItem_obj);
	wxMenuItem * ID_MNU_SAVE_1086_mnuItem_obj = new wxMenuItem (ID_MNU_FILE_1080_Mnu_Obj, ID_MNU_SAVE_1086, wxT("&Save\tCtrl+S"), wxT("Save the current package"), wxITEM_NORMAL);
	wxBitmap ID_MNU_SAVE_1086_mnuItem_obj_BMP(PackMaker2Frm_ID_MNU_SAVE_1086_XPM);
	ID_MNU_SAVE_1086_mnuItem_obj->SetBitmap(ID_MNU_SAVE_1086_mnuItem_obj_BMP);
	ID_MNU_FILE_1080_Mnu_Obj->Append(ID_MNU_SAVE_1086_mnuItem_obj);
	wxMenuItem * ID_MNU_SAVEAS____1087_mnuItem_obj = new wxMenuItem (ID_MNU_FILE_1080_Mnu_Obj, ID_MNU_SAVEAS____1087, wxT("Save&As..."), wxT("Save the current package with a new name"), wxITEM_NORMAL);
	wxBitmap ID_MNU_SAVEAS____1087_mnuItem_obj_BMP(PackMaker2Frm_ID_MNU_SAVEAS____1087_XPM);
	ID_MNU_SAVEAS____1087_mnuItem_obj->SetBitmap(ID_MNU_SAVEAS____1087_mnuItem_obj_BMP);
	ID_MNU_FILE_1080_Mnu_Obj->Append(ID_MNU_SAVEAS____1087_mnuItem_obj);
	ID_MNU_FILE_1080_Mnu_Obj->AppendSeparator();
	wxMenuItem * ID_MNU_BUILD_1089_mnuItem_obj = new wxMenuItem (ID_MNU_FILE_1080_Mnu_Obj, ID_MNU_BUILD_1089, wxT("&Build"), wxT("Build the current package"), wxITEM_NORMAL);
	wxBitmap ID_MNU_BUILD_1089_mnuItem_obj_BMP(PackMaker2Frm_ID_MNU_BUILD_1089_XPM);
	ID_MNU_BUILD_1089_mnuItem_obj->SetBitmap(ID_MNU_BUILD_1089_mnuItem_obj_BMP);
	ID_MNU_FILE_1080_Mnu_Obj->Append(ID_MNU_BUILD_1089_mnuItem_obj);
	ID_MNU_FILE_1080_Mnu_Obj->AppendSeparator();
	wxMenuItem * ID_MNU_EXIT_1091_mnuItem_obj = new wxMenuItem (ID_MNU_FILE_1080_Mnu_Obj, ID_MNU_EXIT_1091, wxT("&Exit\tAlt+F4"), wxT("Quit this program"), wxITEM_NORMAL);
	wxBitmap ID_MNU_EXIT_1091_mnuItem_obj_BMP(PackMaker2Frm_ID_MNU_EXIT_1091_XPM);
	ID_MNU_EXIT_1091_mnuItem_obj->SetBitmap(ID_MNU_EXIT_1091_mnuItem_obj_BMP);
	ID_MNU_FILE_1080_Mnu_Obj->Append(ID_MNU_EXIT_1091_mnuItem_obj);
	WxMenuBar1->Append(ID_MNU_FILE_1080_Mnu_Obj, wxT("&File"));
	
	wxMenu *ID_MNU_HELP_1081_Mnu_Obj = new wxMenu(0);
	wxMenuItem * ID_MNU_ABOUT_1092_mnuItem_obj = new wxMenuItem (ID_MNU_HELP_1081_Mnu_Obj, ID_MNU_ABOUT_1092, wxT("&About\tF1"), wxT("About this program"), wxITEM_NORMAL);
	wxBitmap ID_MNU_ABOUT_1092_mnuItem_obj_BMP(PackMaker2Frm_ID_MNU_ABOUT_1092_XPM);
	ID_MNU_ABOUT_1092_mnuItem_obj->SetBitmap(ID_MNU_ABOUT_1092_mnuItem_obj_BMP);
	ID_MNU_HELP_1081_Mnu_Obj->Append(ID_MNU_ABOUT_1092_mnuItem_obj);
	WxMenuBar1->Append(ID_MNU_HELP_1081_Mnu_Obj, wxT("&Help"));
	SetMenuBar(WxMenuBar1);

	OpenDialog =  new wxFileDialog(this, wxT("Open File"), wxT(""), wxT(""), wxT("Package Description File (*.DevPackage)|*.DevPackage|All Files (*.*)|*.*"), wxOPEN);

	SaveDialog =  new wxFileDialog(this, wxT("Create DevPackage file"), wxT(""), wxT(""), wxT("Package Description File (*.DevPackage)|*.DevPackage|All Files (*.*)|*.*"), wxSAVE);

	SetStatusBar(WxStatusBar1);
	WxToolBar1->SetToolBitmapSize(wxSize(16,16));
	WxToolBar1->Realize();
	SetToolBar(WxToolBar1);
	SetTitle(wxT("PackMaker2"));
	SetIcon(wxNullIcon);
	SetSize(9,9,577,421);
	Center();
	
	////GUI Items Creation End
}

void PackMaker2Frm::OnClose(wxCloseEvent& event)
{
	Destroy();
}

/*
 * edNameUpdated
 */
void PackMaker2Frm::edNameUpdated(wxCommandEvent& event)
{
	// insert your code here
}

/*
 * WxEdit4Updated
 */
void PackMaker2Frm::WxEdit4Updated(wxCommandEvent& event)
{
	// insert your code here
}

/*
 * Mnuexit1091Click
 */
void PackMaker2Frm::Mnuexit1091Click(wxCommandEvent& event)
{
	// insert your code here
	Destroy();
}

/*
 * WxToolButton6Click
 */
void PackMaker2Frm::WxToolButton6Click(wxCommandEvent& event)
{
	AboutClick();
}

/*
 * Mnuabout1092Click
 */
void PackMaker2Frm::Mnuabout1092Click(wxCommandEvent& event)
{
	AboutClick();
}

void PackMaker2Frm::Clear()
{
    FileName = wxT("");
    if(IniFile)
    {
        delete IniFile;
        IniFile = NULL;
    }
    edName->SetValue(wxT(""));
    edNameVersion->SetValue(wxT(""));
    edVersion->SetValue(wxT(""));
    edStartMenu->SetValue(wxT(""));

    edDescription->SetValue(wxT(""));
    edURL->SetValue(wxT(""));
    edReadMe->SetValue(wxT(""));
    edLicense->SetValue(wxT(""));
    edPicture->SetValue(wxT(""));
    edDepend->SetValue(wxT(""));
    chbReboot->SetValue(false);

    IconView->DeleteAllItems();
    FileView->DeleteAllItems();
}

/*
 * WxToolButton1Click
 */
void PackMaker2Frm::WxToolButton1Click(wxCommandEvent& event)
{
	// insert your code here
    Clear();
    CreateNewFile();
}

bool PackMaker2Frm::CreateNewFile()
{
    bool Result = false, Abort = false;
    while (!(Abort) && (SaveDialog->ShowModal() != wxID_OK) )
      if(wxMessageBox(
        wxT("You must create the file before starting because filenames you\nwill use later will be relative to that file.\nDo you wish to continue?"),
        wxT("Error"),wxYES_NO|wxICON_EXCLAMATION) == wxNO) 
       return Result;
     
    if(IniFile)
    {
        delete IniFile;
        IniFile = NULL;
    }
    FileName = SaveDialog->GetPath();
    if(wxFileExists(FileName))
    {
        IniFile = new wxFileConfig(wxEmptyString, wxEmptyString,FileName,wxEmptyString,wxCONFIG_USE_LOCAL_FILE | wxCONFIG_USE_NO_ESCAPE_CHARACTERS);
        ReadDevPackFile();
    }
    else
        IniFile = new wxFileConfig(wxEmptyString, wxEmptyString,FileName,wxEmptyString,wxCONFIG_USE_LOCAL_FILE | wxCONFIG_USE_NO_ESCAPE_CHARACTERS);
        
    Result = true;
    return Result;
}

void PackMaker2Frm::SaveItemClick()
{
    if(FileName.IsEmpty())
        SaveAsItemClick();
    else
        WriteDevPackFile();
}

void PackMaker2Frm::SaveAsItemClick()
{
    if(SaveDialog->ShowModal())
    {
        FileName = SaveDialog->GetPath();
        if(IniFile)
        {
            delete IniFile;
            IniFile = NULL;
        }
        IniFile = new wxFileConfig(wxEmptyString, wxEmptyString,FileName,wxEmptyString,wxCONFIG_USE_LOCAL_FILE | wxCONFIG_USE_NO_ESCAPE_CHARACTERS);
        SaveItemClick();
    }
}
void PackMaker2Frm::AboutClick()
{
	wxMessageBox(wxT("Dev-C++ Package Maker\n\nAuthor : Colin Laplace and Hongli Lai\nC++ Conversion : Sof.T\nUses wxWidget Library : Julian Smart et al\n\nCopyright Bloodshed Software\nUnder the GNU General Public License"),wxT("About PackMaker 2"), wxICON_INFORMATION|wxOK);
}

/*
 * WxToolButton3Click
 */
void PackMaker2Frm::WxToolButton3Click(wxCommandEvent& event)
{
	// insert your code here
	SaveItemClick();
}

/*
 * WxToolButton4Click
 */
void PackMaker2Frm::WxToolButton4Click(wxCommandEvent& event)
{
	// insert your code here
	SaveAsItemClick();
}

/*
 * Mnusave1086Click
 */
void PackMaker2Frm::Mnusave1086Click(wxCommandEvent& event)
{
	// insert your code here
	SaveItemClick();
}

/*
 * Mnusaveas1087Click
 */
void PackMaker2Frm::Mnusaveas1087Click(wxCommandEvent& event)
{
	// insert your code here
	SaveAsItemClick();
}

/*
 * btnReadMeClick
 */
void PackMaker2Frm::btnReadMeClick(wxCommandEvent& event)
{
	// insert your code here
	OpenDialog->SetWildcard(wxT("Text files (*.txt)|*.txt"));
	if(OpenDialog->ShowModal() == wxID_OK)
	{
	   wxFileName TempFileName(FileName);
       wxFileName TempSourceName(OpenDialog->GetPath());
	   TempSourceName.MakeRelativeTo(TempFileName.GetPath());
	   edReadMe->SetValue(TempSourceName.GetFullPath());
    }
}

/*
 * btnLicenseClick
 */
void PackMaker2Frm::btnLicenseClick(wxCommandEvent& event)
{
	// insert your code here
	OpenDialog->SetWildcard(wxT("Text files (*.txt)|*.txt"));
	if(OpenDialog->ShowModal() == wxID_OK)
	{
	   wxFileName TempFileName(FileName);
       wxFileName TempSourceName(OpenDialog->GetPath());
	   TempSourceName.MakeRelativeTo(TempFileName.GetPath());
	   edLicense->SetValue(TempSourceName.GetFullPath());
    }
}

/*
 * btnPictureClick
 */
void PackMaker2Frm::btnPictureClick(wxCommandEvent& event)
{
	// insert your code here
	OpenDialog->SetWildcard(wxT("Bitmaps (*.bmp)|*.bmp"));
	if(OpenDialog->ShowModal() == wxID_OK)
	{
	   wxFileName TempFileName(FileName);
       wxFileName TempSourceName(OpenDialog->GetPath());
	   TempSourceName.MakeRelativeTo(TempFileName.GetPath());
	   edPicture->SetValue(TempSourceName.GetFullPath());
    }
}

void PackMaker2Frm::BuildPackage()
{
    wxFileName TempFileName(FileName);
    const int BufferSize = 1024*32;
    
    //Make TAR
    TempFileName.SetExt(wxT("tar"));
    wxFileOutputStream out(TempFileName.GetFullPath());
    wxTarOutputStream TarStream(out);
        
    if(buildForm)
    {
        buildForm->WxStaticBox1->SetLabel(wxT(" Building tar archive... "));
        buildForm->WxGauge1->SetRange((FileView->GetItemCount()+1) *2);
        buildForm->WxGauge1->SetValue(1);
    } 
    
    TempFileName.SetExt(wxT("DevPackage"));
    //Add the file name to tar.PutNextEntry
    TarStream.PutNextEntry(TempFileName.GetFullName());
    //Added to test
    wxStringInputStream TempInputStringStream(WriteDevPackFileToString());
    TarStream.Write(TempInputStringStream);
    //Send data into tar
        
    wxString TempCWD = wxGetCwd();
    {
        wxFileName TempFileName(FileName);
        wxSetWorkingDirectory(TempFileName.GetPath());
    }
        
    wxListItem Column1;
    Column1.SetColumn(1);
    Column1.SetMask(wxLIST_MASK_TEXT);
    wxListItem Column2;
    Column2.SetColumn(2);
    Column2.SetMask(wxLIST_MASK_TEXT);

    for(int i = 0; i < FileView->GetItemCount();i++)
    {
        Column1.SetId(i);
        FileView->GetItem(Column1);
        Column2.SetId(i);
        FileView->GetItem(Column2);
        if(Column2.GetText().CmpNoCase(wxT("Y")) == 0)
        {
            wxArrayString sl;
            wxDir::GetAllFiles(FileView->GetItemText(i),&sl);
            TarStream.PutNextDirEntry(FileView->GetItemText(i));
            wxString CurrentDir = FileView->GetItemText(i);
            for(size_t j = 0; j < sl.GetCount();j++)
            {
                if(wxDir::Exists(sl[j]))
                {
                    //Add the file name to tar.PutNextDirEntry
                    TarStream.PutNextDirEntry(sl[j]);
                }
                else
                {
                    wxFileName CurrentFileName(sl[j]);
                        
                    wxFileInputStream InputFile(CurrentFileName.GetFullPath());
                    if(InputFile.IsOk())
                    {
                        //Add the file name to tar.PutNextEntry
                        TarStream.PutNextEntry(CurrentFileName.GetFullPath());
                        //Send data into tar
                        TarStream.Write(InputFile);
                    }
                }
            }
        }
        else
        {
            wxFileName CurrentFileName(FileView->GetItemText(i));

            wxFileInputStream InputFile(CurrentFileName.GetFullPath());
            if(InputFile.IsOk())
            {
                //Add the file name to zip.PutNextEntry
                TarStream.PutNextEntry(CurrentFileName.GetFullPath());
                //Send data into zip;
                TarStream.Write(InputFile);
            }
        }
        if(buildForm)
        {
            buildForm->WxGauge1->SetValue(buildForm->WxGauge1->GetValue() + 1);
        }
    }
      
    if(!edReadMe->GetValue().IsEmpty())
    {
        wxFileName TempFileName(FileName);
        wxFileName TempSourceName(edReadMe->GetValue());     
              
        if(wxFileExists(TempSourceName.GetFullPath()))
        {
                 
             wxFileInputStream InputFile(TempSourceName.GetFullPath());
             if(InputFile.IsOk())
             {

                 //Add the file name to zip.PutNextEntry
                 TarStream.PutNextEntry(TempSourceName.GetFullPath());
                 //Send data into zip;
                 TarStream.Write(InputFile);
             }

        }
        else
        {
            if(buildForm)
            { 
                if(wxMessageBox(wxT("Your readme file doesn't exist. Do you want to abort the creation of the package?"), wxT("File Error...") , wxICON_ERROR|wxYES|wxNO) == wxID_YES)
                return;
            }
        }
    }

    if(!edLicense->GetValue().IsEmpty())
    {
        wxFileName TempFileName(FileName);
        wxFileName TempSourceName(edLicense->GetValue());
        
        if(wxFileExists(TempSourceName.GetFullPath()))
        {
            wxFileInputStream InputFile(TempSourceName.GetFullPath());
            if(InputFile.IsOk())
            {
                //Add the file name to zip.PutNextEntry
                TarStream.PutNextEntry(TempSourceName.GetFullPath());
                //Send data into zip;
                TarStream.Write(InputFile);
            }
        }
        else
        {
            if(buildForm)
            {
                 if(wxMessageBox(wxT("Your license file doesn't exist. Do you want to abort the creation of the package?"), wxT("File Error...") , wxICON_ERROR|wxYES|wxNO) == wxID_YES)
                 return;
            }
        }
    }
      
    TarStream.Close();
    if(!out.Close())
    {
        if(buildForm)
        {
            wxMessageBox(wxT("Error closing the tar stream"));
        }
    }
    
    // Make the Bzip2 file
    TempFileName.SetExt(wxT("DevPak"));
    wxFileOutputStream bzout(TempFileName.GetFullPath());
    wxBZipOutputStream bzfile(bzout,9);
        
    // Set the status in the UI
    if(buildForm)
    {
        buildForm->WxStaticBox1->SetLabel(wxT(" Building Bzip2 archive... "));
        buildForm->WxGauge1->SetValue(buildForm->WxGauge1->GetValue() + 4);
    }
  
    TempFileName.SetExt(wxT("tar"));
    {
        wxFileInputStream InputFile(TempFileName.GetFullPath());
        wxTarInputStream TempTarStream(InputFile);
        if(buildForm)
        {
            buildForm->WxGauge1->SetRange((InputFile.GetLength()/BufferSize)*2);
            buildForm->WxGauge1->SetValue((InputFile.GetLength()/BufferSize));
        }
        char Buffer[BufferSize];
        
        while(!InputFile.Eof())
        {
            InputFile.Read(Buffer,BufferSize);
            bzfile.Write(Buffer,InputFile.LastRead());
            if(buildForm)
            {
                buildForm->WxGauge1->SetValue(buildForm->WxGauge1->GetValue()+1);
            }
        }
    }
    //Close bzfile file flushing remaining data
    bzfile.Close();
    bzout.Close();
    //Remove tar file
    if(!wxRemoveFile(TempFileName.GetFullPath()))
    {
        if(buildForm)
        {
            wxMessageBox(wxString(wxT("Couldn't remove temporary tar file named: ")) + TempFileName.GetFullPath());
        }
    }
    // Sucess message
    if(buildForm)
    {
        TempFileName.SetExt(wxT("DevPak"));
        wxMessageBox(wxString(wxT("Your Dev-C++ Package has been successfully created to ")) +
        TempFileName.GetFullPath() + wxT(". It is now ready for testing and distribution."), wxT("Success"),
        wxICON_INFORMATION|wxOK);
    }
}

void PackMaker2Frm::BuildItemClick()
{
    if(!FileName.IsEmpty())
    {
        buildForm = new BuildForm(this);
    
        wxFileName TempFileName(FileName);
        TempFileName.SetExt(wxT("DevPak"));
        buildForm->Show();
        SaveItemClick();
        if(wxFileExists(TempFileName.GetFullPath()))
            wxRemoveFile(TempFileName.GetFullPath());
        BuildPackage();
    
        buildForm->Destroy();
        buildForm = NULL;
    }
    else
        wxMessageBox(wxT("You need to create a new item before trying to build"),wxT("Build Error"),wxOK|wxICON_WARNING);
}

void PackMaker2Frm::ReadDevPackFile()
{
    bool TempBool = false;
/*var files, icons : TStringList;
    i  : integer;
    fi : TFileItem;
    ic : TIconItem;
begin*/
    if(IniFile)
    {
        IniFile->SetPath(SETUP_SECTION);
        edName->SetValue(IniFile->Read(wxT("AppName"), wxT("")));
        edNameVersion->SetValue(IniFile->Read(wxT("AppVerName"), wxT("")));
        edVersion->SetValue(IniFile->Read(wxT("AppVersion"), wxT("")));
        edStartMenu->SetValue(IniFile->Read(wxT("MenuName"), wxT("")));

        edDescription->SetValue(IniFile->Read(wxT("Description"), wxT("")));
        edURL->SetValue(IniFile->Read(wxT("Url"), wxT("")));
        edReadMe->SetValue(IniFile->Read(wxT("Readme"), wxT("")));
        edLicense->SetValue(IniFile->Read(wxT("License"), wxT("")));
        edPicture->SetValue(IniFile->Read(wxT("Picture"), wxT("")));
        edDepend->SetValue(IniFile->Read(wxT("Dependencies"), wxT("")));
        IniFile->Read(wxT("Reboot"), &TempBool, false);
        chbReboot->SetValue(TempBool);

        wxArrayString Files;
        wxString Str;
        long dummy;
        IniFile->SetPath(FILES_SECTION);
        bool bCont = IniFile->GetFirstEntry(Str, dummy);
        while ( bCont )
        {
            Files.Add(Str);

            bCont = IniFile->GetNextEntry(Str, dummy);
        }
        
        for(size_t i = 0; i < Files.GetCount(); i++)
        {
            int Index = FileView->GetItemCount();
            FileView->InsertItem(Index,Files[i]);
            FileView->SetItem(Index,1,IniFile->Read(Files[i],wxT("")));
            wxFileName TempFileName(FileName);
            wxFileName TempSourceName(Files[i]);
            TempSourceName.MakeAbsolute(TempFileName.GetPath());
            if(wxDirExists(TempSourceName.GetFullPath()))
                FileView->SetItem(Index,2,wxT("Y"));
            else
                FileView->SetItem(Index,2,wxT("N"));
        }


        IniFile->SetPath(ICONS_SECTION);
        Files.Clear();
        bCont = IniFile->GetFirstEntry(Str, dummy);
        while ( bCont )
        {
            Files.Add(Str);

            bCont = IniFile->GetNextEntry(Str, dummy);
        }

        for(size_t i = 0; i < Files.GetCount(); i++)
        {
            int Index = IconView->GetItemCount();
            IconView->InsertItem(Index,Files[i]);
            wxString TempString = IniFile->Read(Files[i],wxT(""));
            if(TempString.Find(wxT("<")) != wxNOT_FOUND)
            {
                IconView->SetItem(Index,1,TempString.BeforeFirst(','));
                IconView->SetItem(Index,2,TempString.AfterFirst(','));
            }
            else
            {
                IconView->SetItem(Index,1,IniFile->Read(Files[i]));
                IconView->SetItem(Index,2,wxT(""));
            }
        }
    }
}

void PackMaker2Frm::WriteDevPackFile()
{
    if(IniFile)
    {
        IniFile->SetPath(SETUP_SECTION);
        IniFile->Write(wxT("Version"), DEVPAK_VERSION);
        IniFile->Write(wxT("AppName"), edName->GetValue());
        IniFile->Write(wxT("AppVerName"), edNameVersion->GetValue());
        IniFile->Write(wxT("AppVersion"), edVersion->GetValue());
        IniFile->Write(wxT("MenuName"), edStartMenu->GetValue());

        IniFile->Write(wxT("Description"), edDescription->GetValue());
        IniFile->Write(wxT("Url"), edURL->GetValue());
        IniFile->Write(wxT("Readme"), edReadMe->GetValue());
        IniFile->Write(wxT("License"), edLicense->GetValue());
        IniFile->Write(wxT("Picture"), edPicture->GetValue());
        IniFile->Write(wxT("Dependencies"), edDepend->GetValue());
        IniFile->Write(wxT("Reboot"), chbReboot->IsChecked());

        wxListItem Column1;
        Column1.SetColumn(1);
        Column1.SetMask(wxLIST_MASK_TEXT);
        wxListItem Column2;
        Column2.SetColumn(2);
        Column2.SetMask(wxLIST_MASK_TEXT);
        
        IniFile->SetPath(FILES_SECTION);
        
        for(int i = 0; i < FileView->GetItemCount(); i++)
        {
            Column1.SetId(i);
            FileView->GetItem(Column1);
            Column2.SetId(i);
            FileView->GetItem(Column2);
            if((Column2.GetText().CmpNoCase(wxT("Y")) == 0) && (Column1.GetText().Last() != wxFileName::GetPathSeparator()))
                IniFile->Write(FileView->GetItemText(i), Column1.GetText() + wxFileName::GetPathSeparator());//May need to add a trailing backslash here
            else
                IniFile->Write(FileView->GetItemText(i), Column1.GetText());
        }

        IniFile->SetPath(ICONS_SECTION);
        for(int i = 0; i < IconView->GetItemCount(); i++)
        {
            Column1.SetId(i);
            IconView->GetItem(Column1);
            Column2.SetId(i);
            IconView->GetItem(Column2);
            if(!Column2.GetText().IsEmpty())
                IniFile->Write(IconView->GetItemText(i), wxString(Column1.GetText()) +
                    wxT(",") + Column2.GetText());
            else
                IniFile->Write(IconView->GetItemText(i), Column1.GetText());
        }
        IniFile->Flush();
    }
}

wxString PackMaker2Frm::WriteDevPackFileToString()
{
    wxString TempString;
    
    TempString << wxT("\n[Setup]\n");
    TempString << wxT("Version=") << DEVPAK_VERSION << wxT("\n");
    TempString << wxT("AppName=") << edName->GetValue() << wxT("\n");
    
    TempString << wxT("AppVerName=") << edNameVersion->GetValue() << wxT("\n");
    TempString << wxT("AppVersion=") << edVersion->GetValue() << wxT("\n");
    TempString << wxT("MenuName=") << edStartMenu->GetValue() << wxT("\n");

    TempString << wxT("Description=") << edDescription->GetValue() << wxT("\n");
    TempString << wxT("Url=") << edURL->GetValue() << wxT("\n");
    TempString << wxT("Readme=") << edReadMe->GetValue() << wxT("\n");
    TempString << wxT("License=") << edLicense->GetValue() << wxT("\n");
    TempString << wxT("Picture=") << edPicture->GetValue() << wxT("\n");
    TempString << wxT("Dependencies=") << edDepend->GetValue() << wxT("\n");
    TempString << wxT("Reboot=") << chbReboot->IsChecked() << wxT("\n");

    wxListItem Column1;
    Column1.SetColumn(1);
    Column1.SetMask(wxLIST_MASK_TEXT);
    wxListItem Column2;
    Column2.SetColumn(2);
    Column2.SetMask(wxLIST_MASK_TEXT);

    TempString << wxT("\n[Files]\n");

    for(int i = 0; i < FileView->GetItemCount(); i++)
    {
        Column1.SetId(i);
        FileView->GetItem(Column1);
        Column2.SetId(i);
        FileView->GetItem(Column2);
        if((Column2.GetText().CmpNoCase(wxT("Y")) == 0) && (Column1.GetText().Last() != wxFileName::GetPathSeparator()))
            /* TODO (SofT#1#): Does adding the file seperator cause a problem when 
                               reading back since on windows this is \ followed by \n 
                               which would escape the backslash */
            TempString << FileView->GetItemText(i) << wxT("=") << Column1.GetText() << wxString(wxFileName::GetPathSeparator()) << wxT("\n");
        else
            TempString << FileView->GetItemText(i) << wxT("=") << Column1.GetText() << wxT("\n");
    }

    TempString << wxT("\n[Icons]\n");
    
    for(int i = 0; i < IconView->GetItemCount(); i++)
    {
        Column1.SetId(i);
        IconView->GetItem(Column1);
        Column2.SetId(i);
        IconView->GetItem(Column2);
        if(!Column2.GetText().IsEmpty())
            TempString << IconView->GetItemText(i) << wxT("=") << Column1.GetText() << wxT(",") << Column2.GetText() << wxT("\n");
        else
            TempString << IconView->GetItemText(i) << wxT("=") << Column1.GetText() << wxT("\n");
            
    }
    return TempString;
}
/*
 * btnAddItemClick
 */
void PackMaker2Frm::btnAddItemClick(wxCommandEvent& event)
{
	// insert your code here
    MenuForm m(this);
    
    if(m.ShowModal() == wxID_OK)
    {
        int Index = IconView->GetItemCount();
        IconView->InsertItem(Index,m.edName->GetValue());
        IconView->SetItem(Index,1,m.edTarget->GetValue());
        IconView->SetItem(Index,2,m.edIcon->GetValue());
    }
}

/*
 * btnEditItemClick
 */
void PackMaker2Frm::btnEditItemClick(wxCommandEvent& event)
{
	// insert your code here
    if(IconView->GetSelectedItemCount() <= 0)
        return;
    MenuForm m(this);
    
    wxListItem Column1;
    Column1.SetColumn(1);
    Column1.SetMask(wxLIST_MASK_TEXT);
    wxListItem Column2;
    Column2.SetColumn(2);
    Column2.SetMask(wxLIST_MASK_TEXT);
    
    int Selected = IconView->GetNextItem(-1,wxLIST_NEXT_ALL,wxLIST_STATE_SELECTED);
    m.edName->SetValue(IconView->GetItemText(Selected));
    Column1.SetId(Selected);
    IconView->GetItem(Column1);
    m.edTarget->SetValue(Column1.GetText());
    Column2.SetId(Selected);
    IconView->GetItem(Column2);
    m.edIcon->SetValue(Column2.GetText());
    if(m.ShowModal() == wxID_OK)
    {
        IconView->SetItem(Selected,0,m.edName->GetValue());
        IconView->SetItem(Selected,1,m.edTarget->GetValue());
        IconView->SetItem(Selected,2,m.edIcon->GetValue());
    }
}

/*
 * btnRemoveIconClick
 */
void PackMaker2Frm::btnRemoveIconClick(wxCommandEvent& event)
{
	// insert your code here
    if(IconView->GetSelectedItemCount() <= 0)
        return;
        
    if(IniFile)
    {
        IniFile->SetPath(ICONS_SECTION);
        IniFile->DeleteEntry(IconView->GetItemText(IconView->GetNextItem(-1,wxLIST_NEXT_ALL,wxLIST_STATE_SELECTED)));
    }
    IconView->DeleteItem(IconView->GetNextItem(-1,wxLIST_NEXT_ALL,wxLIST_STATE_SELECTED));
}

/*
 * btnRemoveClick
 */
void PackMaker2Frm::btnRemoveClick(wxCommandEvent& event)
{
	// insert your code here
    if(FileView->GetSelectedItemCount() <= 0)
        return;

    if(IniFile)
    {
        IniFile->SetPath(FILES_SECTION);
        IniFile->DeleteEntry(FileView->GetItemText(FileView->GetNextItem(-1,wxLIST_NEXT_ALL,wxLIST_STATE_SELECTED)));
    }
    FileView->DeleteItem(FileView->GetNextItem(-1,wxLIST_NEXT_ALL,wxLIST_STATE_SELECTED));
}

/*
 * btnAddDirClick
 */
void PackMaker2Frm::btnAddDirClick(wxCommandEvent& event)
{
    FileForm f(this);

    f.SetMode(true);
    if(f.ShowModal() == wxID_OK)
    {
        int Index = FileView->GetItemCount();
        wxFileName TempFileName(FileName);
        wxFileName TempSourceName(f.GetSource());
        TempSourceName.MakeRelativeTo(TempFileName.GetPath());
        FileView->InsertItem(Index,TempSourceName.GetFullPath());
        //FileView->InsertItem(Index,f.edSource->GetValue());
        FileView->SetItem(Index,1,f.GetDestination());
        FileView->SetItem(Index,2,wxT("Y"));
    }
}

/*
 * btnAddFileClick
 */
void PackMaker2Frm::btnAddFileClick(wxCommandEvent& event)
{
    FileForm f(this);

    f.SetMode(false);
    if(f.ShowModal() == wxID_OK)
    {
        int Index = FileView->GetItemCount();
        wxFileName TempFileName(FileName);
        wxFileName TempSourceName(f.GetSource());
        TempSourceName.MakeRelativeTo(TempFileName.GetPath());
        FileView->InsertItem(Index,TempSourceName.GetFullPath());
        //FileView->InsertItem(Index,f.edSource->GetValue());
        FileView->SetItem(Index,1,f.GetDestination());
        FileView->SetItem(Index,2,wxT("N"));
    }
}

/*
 * WxToolButton5Click
 */
void PackMaker2Frm::WxToolButton5Click(wxCommandEvent& event)
{
	// insert your code here
	BuildItemClick();
}

/*
 * Mnubuild1089Click
 */
void PackMaker2Frm::Mnubuild1089Click(wxCommandEvent& event)
{
	// insert your code here
	BuildItemClick();
}

bool PackMaker2Frm::OpenItemClick()
{
	OpenDialog->SetWildcard(wxT("Package Description File (*.DevPackage)|*.DevPackage|All Files (*.*)|*.*"));
    if(OpenDialog->ShowModal() == wxID_OK)
    {
        SetFileName(OpenDialog->GetPath());
        return true;
    }
    else
        return false;
}

void PackMaker2Frm::SetFileName(wxString fileName)
{
    Clear();
    FileName = fileName;
    if(IniFile)
    {
        delete IniFile;
        IniFile = NULL;
    }
    IniFile = new wxFileConfig(wxEmptyString, wxEmptyString,FileName,wxEmptyString,wxCONFIG_USE_LOCAL_FILE | wxCONFIG_USE_NO_ESCAPE_CHARACTERS);
    ReadDevPackFile();
}

/*
 * WxToolButton2Click
 */
void PackMaker2Frm::WxToolButton2Click(wxCommandEvent& event)
{
	// insert your code here
	OpenItemClick();
}

/*
 * Mnuopen1084Click
 */
void PackMaker2Frm::Mnuopen1084Click(wxCommandEvent& event)
{
	// insert your code here
	OpenItemClick();
}

/*
 * edReadMeUpdated
 */
void PackMaker2Frm::edReadMeUpdated(wxCommandEvent& event)
{
	// insert your code here
}

/*
 * edReadMeUpdated1
 */
void PackMaker2Frm::edReadMeUpdated1(wxCommandEvent& event)
{
	// insert your code here
}
