/*
  Name: AboutDialogProc (function)
  Author: Kip Warner
  Description: Window procedure for the about dialog box...
*/


#include "prototypes.h"

    // Directory where vUpdate is...
    extern char    g_szExeDirectory[256];
    
    // Directory of temp folder...
    extern char    g_szTempDirectory[256];
    
    // Guess...
    extern char    g_szAppName[32];
    
    // Debug mode...
    extern BOOL    g_bDebugMode;

// Options box proc...
BOOL CALLBACK OptionsDialogProc(HWND hDlg, UINT msg, WPARAM wParam, LPARAM lParam)
{
    // Variables...
    static  vUpdateOptions      *options            = NULL;
    static  HWND                hParent             = 0;
            char                szTemp[1024]        = {0};
            int                 nStatus             = 0;
    static  char szBuffer[] =   
        "[INTERFACE]\r\n\r\n"

        "Cool progress bar:\r\n"
        "Smooth progress bar instead of ugly segmented one.\r\n\r\n"

        "Cheesy Dev-C++ theme:\r\n"
        "I'm not sure what this does, email me if any of you guys find out.\r\n\r\n"

        "Enable previews:\r\n"
        "Check this if you want to enable preview pictures to be displayed in the logo "
        "box for packages that have this feature. Note that preview pics eat up your "
        "bandwidth, so if you are cheap or in a hurry you might want to disable this. "
        "Although, I have noticed that vUpdate downloads them very fast when the server is "
        "in a good mood (and they look rad too).\r\n\r\n"

        "[LIST]\r\n\r\n"

        "Check the types of updates you want vUpdate to show you each time you scan "
        "for updates. If vUpdate comes across one that its not familiar with, it will "
        "by default go under \"other\".\r\n\r\n"
        
        "[ADVANCED]\r\n\r\n"
        
        "Generate debug log:\r\n"
        "This is for the power charlies. If vUpdate does something that annoys you, "
        "you can check out the debug log vUpdate creates that may help in finding "
        "out what went wrong. This is also very useful for helping me to fix bugs. "
        "Just vRoach the log, along with the problem, and I will do what I can.\r\n\r\n";

    // Message handling...
    switch(msg)
    {
        // Dialog being created...
        case WM_INITDIALOG:

            // Get address of vUpdateOptions...
            options = (vUpdateOptions *) lParam;

            // Get parent window handle...
            hParent = GetParent(hDlg);

                // Error...
                if(!hParent)
                {
                    MessageBox(NULL, "Can't get parent window handle...", "Error", MB_OK);
                    EndDialog(hDlg, 0);
                    return TRUE;
                }

            // Extract macros and user options. Check for error...
            SendMessage(hParent, WM_LOAD_OPTIONS, 0, 0);
            
            // Check stuff that needs checking...

                // Interface options...
                CheckDlgButton(hDlg, IDD_INTERFACE_SMOOTH_PROGRESS_BAR, 
                    (options->bInterfaceSmoothProgressBar == TRUE) ? BST_CHECKED : BST_UNCHECKED);

                CheckDlgButton(hDlg, IDD_INTERFACE_DEV_THEME, 
                    (options->bInterfaceDevTheme == TRUE) ? BST_CHECKED : BST_UNCHECKED);

                CheckDlgButton(hDlg, IDD_INTERFACE_PREVIEWS, 
                    (options->bInterfacePreviews == TRUE) ? BST_CHECKED : BST_UNCHECKED);

                // List options...
                CheckDlgButton(hDlg, IDD_LIST_PACKAGES, 
                    (options->bListPackages == TRUE) ? BST_CHECKED : BST_UNCHECKED);

                CheckDlgButton(hDlg, IDD_LIST_PATCHES, 
                    (options->bListPatches == TRUE) ? BST_CHECKED : BST_UNCHECKED);

                CheckDlgButton(hDlg, IDD_LIST_LANGUAGES, 
                    (options->bListLanguages == TRUE) ? BST_CHECKED : BST_UNCHECKED);

                    // Fill in language listings...
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "All");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Bulgarian");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Charlenese");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Chinese");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Croatian");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Czech");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Danish");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Dutch");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "English");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "French");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "German");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Greek");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Italian");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Korean");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Latvian");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Polish");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Portuguese");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Russian");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Slovak");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Spanish");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Swedish");
                    SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_ADDSTRING, 0, (LPARAM) "Turkish");

                    // Select the saved one...
                    
                        // Query...
                        nStatus = SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_FINDSTRINGEXACT,
                                              (WPARAM) -1, (LPARAM) options->szListSelectedLanguage);
                                          
                        // No error...
                        if(nStatus)
                            SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_SETCURSEL,
                                        (WPARAM) nStatus, 0);

                        // Error, select default...
                        else
                            SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_SETCURSEL, 0, 0);

                CheckDlgButton(hDlg, IDD_LIST_HELP, 
                    (options->bListHelp == TRUE) ? BST_CHECKED : BST_UNCHECKED);
                    
                CheckDlgButton(hDlg, IDD_LIST_OTHER, 
                    (options->bListOther == TRUE) ? BST_CHECKED : BST_UNCHECKED);
                    
                // Advanced options...
                CheckDlgButton(hDlg, IDD_ADVANCED_DEBUG_LOG, 
                    (options->bAdvancedDebugLog == TRUE) ? BST_CHECKED : BST_UNCHECKED);
                    
                    // Bandwidth throttle code goes here...
                
                CheckDlgButton(hDlg, IDD_ADVANCED_PROXY_FLAG,
                    (options->bAdvancedUseProxy == TRUE) ? BST_CHECKED : BST_UNCHECKED);
                    
                SetDlgItemText(hDlg, IDD_ADVANCED_PROXY_SERVER, options->szAdvancedProxyServer);
                
                SetDlgItemInt(hDlg, IDD_ADVANCED_PROXY_PORT, options->nAdvancedProxyPort, FALSE);

            // Set options description window caption...
            SetDlgItemText(hDlg, IDD_OPTION_DESCRIPTION, szBuffer);

            return TRUE;

        // Command...
        case WM_COMMAND:
            
            // Which button?...
            switch(LOWORD(wParam))
            {
                // Ok button hit...
                case IDOK:
                    
                    // What options have they changed?...
                        
                        // Interface options...
                        options->bInterfaceSmoothProgressBar = (IsDlgButtonChecked(hDlg, IDD_INTERFACE_SMOOTH_PROGRESS_BAR) == BST_CHECKED) ? TRUE : FALSE;
                        options->bInterfaceDevTheme = (IsDlgButtonChecked(hDlg, IDD_INTERFACE_DEV_THEME) == BST_CHECKED) ? TRUE : FALSE;
                        options->bInterfacePreviews = (IsDlgButtonChecked(hDlg, IDD_INTERFACE_PREVIEWS) == BST_CHECKED) ? TRUE : FALSE;
                        
                        // List options...
                        options->bListPackages = (IsDlgButtonChecked(hDlg, IDD_LIST_PACKAGES) == BST_CHECKED) ? TRUE : FALSE;
                        options->bListPatches = (IsDlgButtonChecked(hDlg, IDD_LIST_PATCHES) == BST_CHECKED) ? TRUE : FALSE;
                        options->bListLanguages = (IsDlgButtonChecked(hDlg, IDD_LIST_LANGUAGES) == BST_CHECKED) ? TRUE : FALSE;
                        
                            // List selected language...
                            
                                // Query...
                                nStatus = SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_GETCURSEL, 0, 0);
                            
                                // Error...
                                if(nStatus == CB_ERR)
                                {
                                    MessageBox(NULL, "Please select a language to list.", "Options", MB_OK);
                                    return FALSE;
                                }
                                
                                // Retrieve...
                                SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_GETLBTEXT, (WPARAM) nStatus, (LPARAM) options->szListSelectedLanguage);
                                
                        options->bListHelp = (IsDlgButtonChecked(hDlg, IDD_LIST_HELP) == BST_CHECKED) ? TRUE : FALSE;
                        options->bListOther = (IsDlgButtonChecked(hDlg, IDD_LIST_OTHER) == BST_CHECKED) ? TRUE : FALSE;

                        // Advanced options...
                        options->bAdvancedDebugLog = (IsDlgButtonChecked(hDlg, IDD_ADVANCED_DEBUG_LOG) == BST_CHECKED) ? TRUE : FALSE;
                        
                            // Bandwidth throttle code goes here...

                        options->bAdvancedUseProxy = (IsDlgButtonChecked(hDlg, IDD_ADVANCED_PROXY_FLAG) == BST_CHECKED) ? TRUE : FALSE;

                            // Get proxy server...
                            GetDlgItemText(hDlg, IDD_ADVANCED_PROXY_SERVER, szTemp, sizeof(szTemp));
                            
                                // Extract host name and check for error...
                                if(!GetHostName(options->szAdvancedProxyServer, szTemp))
                                {
                                    MessageBox(NULL, "Invalid proxy server. Example: \"server.com\".", 
                                               "Error", MB_OK | MB_ICONINFORMATION);
                                    return TRUE;
                                }
                        options->nAdvancedProxyPort = GetDlgItemInt(hDlg, IDD_ADVANCED_PROXY_PORT, NULL, FALSE);

                    // Save options...
                    SendMessage(hParent, WM_SAVE_OPTIONS, 0, 0);

                    // Kill dialog...
                    EndDialog(hDlg, 0);
                    return FALSE;

                // Default button hit...
                case IDD_DEFAULT:

                    // Check stuff that needs checking...

                        // Interface options...
                        CheckDlgButton(hDlg, IDD_INTERFACE_SMOOTH_PROGRESS_BAR, BST_CHECKED);
                        CheckDlgButton(hDlg, IDD_INTERFACE_DEV_THEME, BST_UNCHECKED);
                        CheckDlgButton(hDlg, IDD_INTERFACE_PREVIEWS, BST_UNCHECKED);

                        // List options...
                        CheckDlgButton(hDlg, IDD_LIST_PACKAGES, BST_CHECKED);
                        CheckDlgButton(hDlg, IDD_LIST_PATCHES, BST_CHECKED);
                        CheckDlgButton(hDlg, IDD_LIST_LANGUAGES, BST_CHECKED);
                        SendMessage(GetDlgItem(hDlg, IDD_LIST_LANGUAGES_LIST), CB_SETCURSEL, 0, 0);
                        CheckDlgButton(hDlg, IDD_LIST_HELP, BST_CHECKED);
                        CheckDlgButton(hDlg, IDD_LIST_OTHER, BST_CHECKED);

                        // Advanced options...
                        CheckDlgButton(hDlg, IDD_ADVANCED_DEBUG_LOG, BST_UNCHECKED);

                            // Bandwidth throttle code goes here...

                        CheckDlgButton(hDlg, IDD_ADVANCED_PROXY_FLAG, BST_UNCHECKED);
                        SetDlgItemText(hDlg, IDD_ADVANCED_PROXY_SERVER, "server.com");
                        SetDlgItemText(hDlg, IDD_ADVANCED_PROXY_PORT, "8010");

                    return TRUE;

                // Edit install log button hit...
                case IDD_ADVANCED_EDIT_INSTALL_LOG:
                    GetCurrentDirectory(sizeof(szTemp), szTemp);
                    SetCurrentDirectory(g_szExeDirectory);
                    ShellExecute(NULL, "open", "vUpdate Install Database.txt",
                                 NULL, NULL, SW_SHOW);
                    SetCurrentDirectory(szTemp);
                    return 0;

                // Manual update button hit...
                case IDD_ADVANCED_MANUAL_UPDATE:
                    ShellExecute(NULL, "open", "http://www.zero47.com/updates/vUpdate.exe",
                                 NULL, NULL, SW_MAXIMIZE);
                    return TRUE;
            }
            break;

        // Close button hit...
        case WM_CLOSE:

            // Kill dialog box...
            EndDialog(hDlg, 0);
            return TRUE;

    }
    return FALSE;
}

// About box proc...
BOOL CALLBACK AboutDialogProc(HWND hDlg, UINT msg, WPARAM wParam, LPARAM lParam)
{
    // Variables...
    char szBuffer[] =   "[ABOUT]\r\n"
                        "Proudly written in pure C...\r\n"
                        "Compiled under GCC " __VERSION__ " / Dev-C++ 4.9.6.0 "
                        "on " __DATE__ " at " __TIME__ "\r\n\r\n"

                        "[CHANGE-LOG]\r\n"
                        "vUpdate 1.614:\r\n"
                        "* Added Bulgarian language in options\r\n\r\n"
                        
                        "vUpdate 1.613:\r\n"
                        "* Start button is disabled if there are problems "
                        "in devcpp.cfg\r\n\r\n"
                        
                        "vUpdate 1.612:\r\n"
                        "* Many bug fixes\r\n"
                        "* Fixed a bug in packman not launching\r\n"
                        "* Replaced self update code with VSU\r\n\r\n"
                        
                        "vUpdate 1.609:\r\n"
                        "* Added Croatian in custom language listing\r\n"
                        "* Fixed bug that opened incorrect manual update url\r\n\r\n"
                        
                        "vUpdate 1.608:\r\n"
                        "* Anti cache code. They are fucking annoying.\r\n"
                        "* Server type shown in status window for no particular reason\r\n"
                        "* Fixed title bar bug\r\n\r\n"
                        
                        "vUpdate 1.607:\r\n"
                        "* Added russian support in language list\r\n\r\n"
                        
                        "vUpdate 1.606:\r\n"
                        "* Changed update script URL\r\n"
                        "* Filename in window title when downloading\r\n\r\n"

                        "vUpdate 1.605:\r\n"
                        "* Changed error message for devcpp.cfg error\r\n"
                        "* Updated ini_io to 2.3\r\n"
                        "* Changed some other stuff\r\n\r\n"

                        "vUpdate 1.604:\r\n"
                        "* devcpp.cfg read from Application Data "
                          "directory on NT class systems\r\n"
                        "* Changed selfupdate script url\r\n\r\n"

                        "vUpdate 1.603:\r\n"
                        "* Fixed bug in about box\r\n\r\n"

                        "vUpdate 1.602:\r\n"
                        "* vUpdate version now stamped in install log\r\n"
                        "* Download progress now shown in title bar (for the "
                           "power charlies)\r\n"
                        "* Fixed bug in vUpdate incorrectly reporting progress "
                           "in debug log\r\n"
                        "* Some other stuff too, but too lazy to remember\r\n\r\n"

                        "vUpdate 1.601:\r\n"
                        "* Added \"Pragma: no-cache\\r\\n\" in http string because "
                           "Te1us is a shitty ISP\r\n\r\n"

                        "vUpdate 1.600:\r\n"
                        "* Start of change log ;)\r\n"
                        "* Added proxy support\r\n"
                        "* Fixed some small bugs...\r\n"
                        "* Description window shows more info now\r\n"
                        "* Fixed memory leak\r\n"
                        "* Fixed bug in start button when rescanning\r\n"
                        "* Added specific language listing in options\r\n\r\n"

                        "[LICENSE]\r\n"
                        "This version of vUpdate is allowed to be used freely ONLY "
                        "with the Dev-C++ IDE. This program is distributed in the "
                        "hope that it will be useful, but WITHOUT ANY WARRANTY; "
                        "without even the implied warranty of MERCHANTABILITY or "
                        "FITNESS FOR A PARTICULAR PURPOSE.\r\n\r\n"

                        "[THANKS]\r\n"
                        "Andreas Åberg\r\n"
                        "Charlie Louie\r\n"
                        "Colin Laplace\r\n"
                        "Françoise\r\n"
                        "Fernando\r\n"
                        "Hick Kemp\r\n"
                        "Lim Yubin\r\n"
                        "Michael Nwawudu\r\n"
                        "Reed Weikum\r\n"
                        "The FSM/UPX/LAG/JO/Dev/DoD crews\r\n"
                        "The power charlies on the forum\r\n"
                        "Wayne (the old)\r\n"
                        "Zero Valintine and his friends\r\n\r\n";

    // Message handling...
    switch(msg)
    {
        // Dialog is being created...
        case WM_INITDIALOG:
        
            // Set license text...
            SetDlgItemText(hDlg, IDD_LICENSE, szBuffer);
            
            // Play streaming tune...
            
            return TRUE;

        // Command...
        case WM_COMMAND:
            switch(LOWORD(wParam))
            {
                // Ok button hit...
                case IDOK:
                    
                    // Kill dialog box...
                    EndDialog(hDlg, 0);
                    return FALSE;

                // Programmer button hit...
                case IDD_PROGRAMMER:
                    ShellExecute(NULL, "open", "http://zero47.com/html/bio.html",
                                     NULL, NULL, SW_MAXIMIZE);
                    return FALSE;

                // Email button hit...
                case IDD_EMAIL:
                    MessageBox(NULL, "Please, please, please don't bug me unless you are absolutely\n"
                                     "positive there is a bug or something. Otherwise, just use your\n"
                                     "common sense. vUpdate is not that hard to use. Thanks =)",
                                     "ICQ Kip", MB_OK | MB_ICONINFORMATION);
                    ShellExecute(NULL, "open", "mailto:kip@zero47.com?subject=vUpdate " VUPDATE_VERSION_CHAR,
                                 NULL, NULL, SW_MAXIMIZE);
                    return FALSE;

                // ICQ button hit...
                case IDD_ICQ:
                    MessageBox(NULL, "Please, please, please don't bug me unless you are absolutely\n"
                                     "positive there is a bug or something. Otherwise, just use your\n"
                                     "common sense. vUpdate is not that hard to use. Thanks =)",
                                     "ICQ Kip", MB_OK | MB_ICONINFORMATION);
                    ShellExecute(NULL, "open", "http://wwp.icq.com/whitepages/message_me/1,,,00.icq?uin=29008229&action=message",
                                 NULL, NULL, SW_MAXIMIZE);
                    return FALSE;
                    
                // URL button hit...
                case IDD_URL:
                    ShellExecute(NULL, "open", "http://www.zero47.com/",
                                 NULL, NULL, SW_MAXIMIZE);
                    return FALSE;

                // User manual button hit...
                case IDD_USER_MANUAL:
                    ShellExecute(NULL, "open", "http://www.zero47.com/vertigo/vUpdate/UserManual.html",
                                 NULL, NULL, SW_MAXIMIZE);
                    return FALSE;
                    
            }
            break;
            
        // Close button hit...
        case WM_CLOSE:
            
            // Kill dialog box...
            EndDialog(hDlg, 0);
            return TRUE;
    }
    return FALSE;
}

// Selfupdate dialog proc...
BOOL CALLBACK SelfUpdateDialogProc(HWND hDlg, UINT msg, WPARAM wParam, LPARAM lParam)
{
    // Variables...
    SelfUpdateData  *selfUpdate;

    switch(msg)
    {
        case WM_INITDIALOG:

            // Get pointer to selfUpdate data...
            selfUpdate = (SelfUpdateData *) lParam;
            
            // Fix new line char...
            fixNewLine(selfUpdate->szComments);

            // Fill in fields in the window...
            SetDlgItemText(hDlg, IDD_AVAILABLE_VERSION, selfUpdate->szLatestVersion);
            SetDlgItemText(hDlg, IDD_UPDATE_COMMENTS, selfUpdate->szComments);
            return TRUE;
            
        // Command...
        case WM_COMMAND:
            switch(LOWORD(wParam))
            {
                // Yes button hit...
                case IDYES:
                    
                    // Kill dialog box...
                    EndDialog(hDlg, TRUE);
                    return TRUE;
                
                // No button hit...
                case IDNO:
                    
                    // Kill dialog box...
                    EndDialog(hDlg, FALSE);
                    return FALSE;

            }

    }
    return FALSE;
}
