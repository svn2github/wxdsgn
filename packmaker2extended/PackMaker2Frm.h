//---------------------------------------------------------------------------
//
// Name:        PackMaker2Frm.h
// Author:      Programming
// Created:     14/05/2007 17:42:15
// Description: PackMaker2Frm class declaration
//
//---------------------------------------------------------------------------

#ifndef __PACKMAKER2FRM_h__
#define __PACKMAKER2FRM_h__

#ifdef __BORLANDC__
	#pragma hdrstop
#endif

#ifndef WX_PRECOMP
	#include <wx/wx.h>
	#include <wx/frame.h>
#else
	#include <wx/wxprec.h>
#endif

//Do not add custom headers between 
//Header Include Start and Header Include End.
//wxDev-C++ designer will remove them. Add custom headers after the block.
////Header Include Start
#include <wx/filedlg.h>
#include <wx/menu.h>
#include <wx/statusbr.h>
#include <wx/toolbar.h>
#include <wx/listctrl.h>
#include <wx/bmpbuttn.h>
#include <wx/checkbox.h>
#include <wx/textctrl.h>
#include <wx/stattext.h>
#include <wx/statbox.h>
#include <wx/panel.h>
////Header Include End
#include <wx/fileconf.h>
#include <wx/dynarray.h>
#include "BuildForm.h"

////Dialog Style Start
#undef PackMaker2Frm_STYLE
#define PackMaker2Frm_STYLE wxCAPTION | wxSYSTEM_MENU | wxMINIMIZE_BOX | wxCLOSE_BOX
////Dialog Style End

#define SETUP_SECTION  wxT("/Setup")
#define FILES_SECTION  wxT("/Files")
#define ICONS_SECTION  wxT("/Icons")
#define RECURSE        wxT(";recursive")
#define DEVPAK_VERSION wxT("2")

class PackMaker2Frm : public wxFrame
{
	private:
		DECLARE_EVENT_TABLE();
		
	public:
		PackMaker2Frm(wxWindow *parent, wxWindowID id = 1, const wxString &title = wxT("PackMaker2"), const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = PackMaker2Frm_STYLE);
		virtual ~PackMaker2Frm();
		void edNameUpdated(wxCommandEvent& event);
		void WxEdit4Updated(wxCommandEvent& event);
	void Mnuexit1091Click(wxCommandEvent& event);
		void WxToolButton6Click(wxCommandEvent& event);
	void Mnuabout1092Click(wxCommandEvent& event);
		void WxToolButton1Click(wxCommandEvent& event);
		void WxToolButton3Click(wxCommandEvent& event);
		void WxToolButton4Click(wxCommandEvent& event);
	void Mnusave1086Click(wxCommandEvent& event);
	void Mnusaveas1087Click(wxCommandEvent& event);
		void btnReadMeClick(wxCommandEvent& event);
		void btnLicenseClick(wxCommandEvent& event);
		void btnPictureClick(wxCommandEvent& event);
		void btnAddItemClick(wxCommandEvent& event);
		void btnEditItemClick(wxCommandEvent& event);
		void btnRemoveIconClick(wxCommandEvent& event);
		void btnRemoveClick(wxCommandEvent& event);
		void btnAddDirClick(wxCommandEvent& event);
		void btnAddFileClick(wxCommandEvent& event);
		void WxToolButton5Click(wxCommandEvent& event);
	void Mnubuild1089Click(wxCommandEvent& event);
		void WxToolButton2Click(wxCommandEvent& event);
	void Mnuopen1084Click(wxCommandEvent& event);
		
	private:
		//Do not add custom control declarations between
		//GUI Control Declaration Start and GUI Control Declaration End.
		//wxDev-C++ will remove them. Add custom code after the block.
		////GUI Control Declaration Start
		wxFileDialog *SaveDialog;
		wxFileDialog *OpenDialog;
		wxMenuBar *WxMenuBar1;
		wxStatusBar *WxStatusBar1;
		wxToolBar *WxToolBar1;
		wxListCtrl *FileView;
		wxBitmapButton *btnRemove;
		wxBitmapButton *btnAddFile;
		wxBitmapButton *btnAddDir;
		wxListCtrl *IconView;
		wxBitmapButton *btnRemoveIcon;
		wxBitmapButton *btnEditItem;
		wxBitmapButton *btnAddItem;
		wxBitmapButton *btnPicture;
		wxBitmapButton *btnLicense;
		wxBitmapButton *btnReadMe;
		wxCheckBox *chbReboot;
		wxTextCtrl *edDepend;
		wxTextCtrl *edStartMenu;
		wxTextCtrl *edPicture;
		wxTextCtrl *edLicense;
		wxTextCtrl *edReadMe;
		wxTextCtrl *edURL;
		wxTextCtrl *edDescription;
		wxStaticText *lblDepends;
		wxStaticText *lblStartMenu;
		wxStaticText *lblPicture;
		wxStaticText *lblLicense;
		wxStaticText *lblReadMe;
		wxStaticText *lblURL;
		wxStaticText *lblDescription;
		wxTextCtrl *edVersion;
		wxTextCtrl *edNameVersion;
		wxTextCtrl *edName;
		wxStaticText *lblVersion;
		wxStaticText *WxStaticText2;
		wxStaticText *lblName;
		wxStaticBox *WxStaticBox4;
		wxStaticBox *WxStaticBox3;
		wxStaticBox *WxStaticBox2;
		wxStaticBox *WxStaticBox1;
		wxPanel *WxPanel1;
		////GUI Control Declaration End
		BuildForm * buildForm;
		
	private:
		//Note: if you receive any error with these enum IDs, then you need to
		//change your old form code that are based on the #define control IDs.
		//#defines may replace a numeric value for the enum names.
		//Try copy and pasting the below block in your old form header files.
		enum
		{
			////GUI Enum Control ID Start
			ID_MNU_FILE_1080 = 1080,
			ID_MNU_NEW_1082 = 1082,
			ID_MNU_OPEN____1084 = 1084,
			ID_MNU_SAVE_1086 = 1086,
			ID_MNU_SAVEAS____1087 = 1087,
			ID_MNU_BUILD_1089 = 1089,
			ID_MNU_EXIT_1091 = 1091,
			ID_MNU_HELP_1081 = 1081,
			ID_MNU_ABOUT_1092 = 1092,
			
			ID_WXSTATUSBAR1 = 1119,
			ID_WXTOOLBUTTON6 = 1075,
			ID_WXSEPARATOR3 = 1074,
			ID_WXTOOLBUTTON5 = 1073,
			ID_WXSEPARATOR2 = 1072,
			ID_WXTOOLBUTTON4 = 1071,
			ID_WXTOOLBUTTON3 = 1070,
			ID_WXSEPARATOR1 = 1069,
			ID_WXTOOLBUTTON2 = 1068,
			ID_WXTOOLBUTTON1 = 1067,
			ID_WXTOOLBAR1 = 1063,
			ID_FILEVIEW = 1118,
			ID_BTNREMOVE = 1117,
			ID_BTNADDFILE = 1116,
			ID_BTNADDDIR = 1115,
			ID_ICONVIEW = 1114,
			ID_BTNREMOVEICON = 1113,
			ID_BTNEDITITEM = 1112,
			ID_BTNADDITEM = 1111,
			ID_BTNPICTURE = 1110,
			ID_BTNLICENSE = 1109,
			ID_BTNREADME = 1108,
			ID_CHBREBOOT = 1107,
			ID_EDDEPEND = 1106,
			ID_EDSTARTMENU = 1105,
			ID_EDPICTURE = 1104,
			ID_EDLICENSE = 1103,
			ID_EDREADME = 1102,
			ID_EDURL = 1101,
			ID_EDDESCRIPTION = 1100,
			ID_LBLDEPENDS = 1099,
			ID_LBLSTARTMENU = 1098,
			ID_LBLPICTURE = 1097,
			ID_LBLLICENSE = 1096,
			ID_LBLREADME = 1095,
			ID_LBLURL = 1094,
			ID_LBLDESCRIPTION = 1093,
			ID_EDVERSION = 1085,
			ID_EDNAMEVERSION = 1084,
			ID_EDNAME = 1083,
			ID_LBLVERSION = 1082,
			ID_WXSTATICTEXT2 = 1081,
			ID_LBLNAME = 1080,
			ID_WXSTATICBOX4 = 1079,
			ID_WXSTATICBOX3 = 1078,
			ID_WXSTATICBOX2 = 1077,
			ID_WXSTATICBOX1 = 1076,
			ID_WXPANEL1 = 1062,
			////GUI Enum Control ID End
			ID_DUMMY_VALUE_ //don't remove this value unless you have other enum values
		};
		
	private:
		void OnClose(wxCloseEvent& event);
		void CreateGUIControls();
        
        wxString FileName;
        wxString OutputFileName;
        wxFileConfig * IniFile;
        
    public:

        void WriteDevPackFile();
        void ReadDevPackFile();
        void Clear();
        void BuildPackage();

        void SaveItemClick();
        void SaveAsItemClick();
        void AboutClick();
        void BuildItemClick();

        wxString WriteDevPackFileToString();
        
        void SetFileName(wxString fileName);
        wxString GetFileName(){return FileName;};
        void SetOutputFileName(wxString outputFileName){OutputFileName = outputFileName;};
        wxString GetOutputFileName(){return OutputFileName;};
        
        bool CreateNewFile();
        bool OpenItemClick();
		void edReadMeUpdated(wxCommandEvent& event);
		void edReadMeUpdated1(wxCommandEvent& event);
        
        //procedure GetDirFiles(s : string; var sl : TStringList);
};

#endif
