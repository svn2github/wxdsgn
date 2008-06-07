//---------------------------------------------------------------------------
//
// Name:        PackMaker2App.cpp
// Author:      Programming
// Created:     14/05/2007 17:42:15
// Description: 
//
//---------------------------------------------------------------------------

#include "PackMaker2App.h"
#include "PackMaker2Frm.h"

#include "ActionDlg.h"

#include <wx/cmdline.h>
#include <wx/msgdlg.h>
#include <wx/filename.h>
IMPLEMENT_APP(PackMaker2FrmApp)

bool PackMaker2FrmApp::OnInit()
{
    bool RetVal = false;
    bool ValidInputFile = false;
    wxString InputFile, OutputFile;
    bool SilentMode = false;
    //First parse the command line
    static const wxCmdLineEntryDesc cmdLineDesc[] =
    {
        { wxCMD_LINE_SWITCH, "h", "help",       "Show help info" },
        { wxCMD_LINE_SWITCH, "s", "silent",     "Don't show a GUI" },
        { wxCMD_LINE_SWITCH, "l", "log",        "Log error messages to a file" },
        { wxCMD_LINE_OPTION, "o", "output",     "Output file" },
        { wxCMD_LINE_OPTION, "i", "input",      "Input file" },

        { wxCMD_LINE_NONE }
    };

    wxCmdLineParser parser(argc,argv);

    parser.SetDesc(cmdLineDesc);
    
    //If we have any options specified then use those
    //If -H is specified then show help message and quit
    //If -S is specified then don't show any forms
    //If -L is specified then log error messages to a file
    //If -I:<Filename> is specified then use this as the package name
    //If -O:<Filename> is specified then use this as the output filename
    int result = parser.Parse();
    switch(result)
    {
        case -1:
            parser.Usage();
            break;
        case 0:
            {
                if(parser.Found(wxT("h")))
                {
                    parser.Usage();
                }
                else
                {
                    SilentMode = parser.Found(wxT("s"));
                    PackMaker2Frm* frame = new PackMaker2Frm(NULL);
                    //Check to see if we have input or output files
                    //if so set these in the main frame
                    if(parser.Found(wxT("i"),&InputFile))
                    {
                        ValidInputFile = !InputFile.IsEmpty();
                        {
                            if(ValidInputFile)
                            {
                                wxFileName TempFileName(InputFile);
                                if(TempFileName.IsRelative())
                                {
                                    TempFileName.AssignCwd();
                                    TempFileName.SetFullName(InputFile);
                                    InputFile = TempFileName.GetFullPath();
                                }
                                ValidInputFile = TempFileName.FileExists();
                                if(!ValidInputFile)
                                {
                                    wxMessageBox("File does not exist",TempFileName.GetFullPath());
                                    TempFileName.AssignCwd();
                                    TempFileName.SetFullName(InputFile);
                                    ValidInputFile = TempFileName.FileExists();
                                    if(ValidInputFile)
                                    {
                                        InputFile = TempFileName.GetFullPath();
                                        wxMessageBox("Valid File",TempFileName.GetFullPath());
                                    }
                                    else
                                        wxMessageBox("File does not exist",TempFileName.GetFullPath());
                                }
                                else
                                {
                                    wxMessageBox("File Exists", TempFileName.GetFullPath());
                                }
                            }
                            else
                                wxMessageBox("FileEmpty");
                        }
                        if(parser.Found(wxT("o"),&OutputFile));
                    }
                   else
                        if (SilentMode) wxMessageBox("No Input File");
                        
                    //If not silent mode
                    if(!SilentMode)
                    {
                        if(ValidInputFile)
                        {
                            frame->SetFileName(InputFile);
                            SetTopWindow(frame);
                            frame->Show();
                            RetVal = true;
                        }
                        else
                        {        
                            //If not show the action dialog
                            ActionDlg TempActionDlg(NULL);
                            int DlgRetVal;
                            
                            // Keep action dialog visible until action RetVal true or action cancelled
                            while ( (!RetVal) && ((DlgRetVal = TempActionDlg.ShowModal()) != wxID_CANCEL) ) {
                                            
                                SetTopWindow(frame);
                                if(DlgRetVal == CREATE_PACKAGE) {
                                    if (frame->CreateNewFile()) {
                                        RetVal = true;
                                        frame->Show();      
                                    }
                                }
                                else {
                                    if (frame->OpenItemClick()) {
                             
                                        RetVal = true;
                                        frame->Show();
                                    }
                                }
                            } 
                        }
                    }
                    else
                    {
                        //Check to see if we have an input file
                        //If not we cannot proceed in silent mode
                        if(ValidInputFile)
                        {
                            frame->SetFileName(InputFile);
                            if(!OutputFile.IsEmpty())
                            {
                                frame->SetOutputFileName(OutputFile);
                            }
                            frame->BuildPackage();
                        }
                        //Destroy the frame
                        frame->Destroy();   
                        //Signal the end of the application
                        RetVal = false;
                    }
                }
            }
            break;
        default:
            //Error processing commandline
            break;
    };
            
    // If none of these are specified then open the Action Dialog
    
    //First check to see if we have an existing INI file
    //If not display a dialog asking if we want to start in wizard mode
    //If answer is yes display wizard
    //If no start in frame mode
    /*ActionDlg TempActionDlg(NULL);
    int DlgRetVal = TempActionDlg.ShowModal();
    if(DlgRetVal != wxID_CANCEL)
    {
        PackMaker2Frm* frame = new PackMaker2Frm(NULL);
        SetTopWindow(frame);
        if(DlgRetVal == CREATE_PACKAGE)
            frame->CreateNewFile();
        else
            frame->OpenItemClick();
        frame->Show();
        RetVal = true;
    }*/
    return RetVal;
}
 
int PackMaker2FrmApp::OnExit()
{
	return 0;
}
