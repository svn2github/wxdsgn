/*
  Name: Main (module)
  Author: Kip Warner
  Description: Dialog box message handling...
  Copyright: Yes
*/

#include "prototypes.h"

    // Global variables...
    vRoachGlobals g_globals;

// Main window dialog procedure...
BOOL CALLBACK MainDialogProc(HWND hDlg, UINT msg, WPARAM wParam, LPARAM lParam)
{
    // Variables...
    static  FILE               *hFile                       = NULL;
    static  char                szTemp[1024]                = {0};
            char               *pszTemp                     = NULL;
            TCHAR               szWideTemp[1024]            = {0};
            int                 i                           = 0;
    static  vRoachSessionData   session;
    static  HDC                 hdc, hdcMemoryImage;
    static  char                szStatus[1024]              = {0};
    static  HANDLE              hThread                     = 0;
    static  DWORD               dwThreadId                  = 0;
    static  DWORD               dwTemp                      = 0;
    static  RECT                rect;
    static  PAINTSTRUCT         ps;
    static  HBITMAP             hLogo                       = 0;
            BITMAP              strBitmap;
    static  OSVERSIONINFO       os;
    static  HBRUSH              hBrush                      = 0;
    static  HBRUSH              hbrBackground               = 0;
    static  LOGBRUSH            logicalBrush;
            HANDLE              hSearchHandle               = 0;
            WIN32_FIND_DATA     FindData;
    
    // Message handling...
    switch(msg)
    {
        // Init dialog...
        case WM_INITDIALOG:

            // Get module handle...
            g_globals.hInstance = (HINSTANCE) GetWindowLong(hDlg, GWL_HINSTANCE);

            // Get handle...
            g_globals.hDlg = hDlg;

            // Init background..
            hbrBackground = CreateSolidBrush(RGB(214, 206, 198));

            // Check for command line parameter (custom user comments)...
            pszTemp = GetCommandLine();

                // Find vRoach file name...
                pszTemp = strstr(pszTemp, "vRoach.exe\"");
                
                    // No parameters, use default...
                    if(!pszTemp)
                    {
                        SetDlgItemText(hDlg, IDD_CLIENT_COMMENTS, 
                                       "If this is a bug report, make sure you tell us EXACTLY "
                                       "on how to reproduce it. Being a power charlie and saying "
                                       "\"It crashed.\" will accomplish nothing but your report "
                                       "being deleted. vRoach is a tool to help us build a better "
                                       "product for you, don't abuse it.");
                    }
                    // Parameters...
                    else
                    {
                        // Seek pointer to end...
                        pszTemp += strlen("vRoach.exe\" ");
                        
                        // Set comments window to parameter string...
                        SetDlgItemText(hDlg, IDD_CLIENT_COMMENTS, pszTemp);
                    }

            // Get handle to our logo...
            hLogo = LoadBitmap(g_globals.hInstance, MAKEINTRESOURCE(IDD_LOGO));
            GetObject(hLogo, sizeof(BITMAP), &strBitmap);

                // Can't get logo...
                if(!hLogo)
                {
                    MessageBox(hDlg, "Sorry, but there was an error while rendering my logo.\n"
                                     "This can happen when another program screws something up.\n"
                                     "Try rebooting.",
                                     "Error", MB_OK);
                    PostQuitMessage(0);
                }

            // Read settings...

                // Options file on disk?...
                hFile = fopen("vRoach.ini", "r");

                    // No settings file, create...
                    if(!hFile)
                    {
                        hFile = fopen("vRoach.ini", "w");

                        // Can't create...
                        if(!hFile)
                        {
                            MessageBox(NULL, "Error reading settings...", VROACH_NAME,
                                       MB_OK | MB_ICONERROR);
                            PostQuitMessage(0);
                        }

                        // Write default settings...
                        fputs("[Position]\n"
                              "StartX           = \"320\"\n"
                              "StartY           = \"240\"\n\n"

                              "[Server]\n"
                              "SMTP             = \"" VROACH_DEFAULT_SMTP "\"\n"
                              "Port             = \"25\"\n"
                              "EmailTo          = \"" VROACH_DEFAULT_EMAILTO "\"\n\n"

                              "[User]\n"
                              "Name             = \"\"\n"
                              "Email            = \"\"\n"
                              "AttachSpecs      = \"0\"\n"
                              "AttachConfigs    = \"0\"\n"
                              "BugSubmits       = \"0\"\n\n"
                              
                              "[Misc]\n"
                              "DebugMode        = \"0\"\n"
                              "PlaySound        = \"1\"\n\n",
                              hFile);
                      
                        // Close stream...
                        fclose(hFile);
                        
                        // First run...

                            // Show about and warning message box...
                            if(VROACH_SHOW_ABOUT)
                            {
                                DialogBox(g_globals.hInstance, "AboutBox", hDlg, AboutDialogProc);
                                MessageBox(hDlg, "Control + Enter sends.",
                                                 VROACH_NAME, MB_OK | MB_ICONINFORMATION);
                            }
                    }
                    
                    // It exists, close handle and set focus to comments window...
                    else
                    {
                        SetFocus(GetDlgItem(hDlg, IDD_CLIENT_COMMENTS));
                        
                        // Highlight text...
                        SendMessage(GetDlgItem(hDlg, IDD_CLIENT_COMMENTS), EM_SETSEL, (WPARAM) 0, (LPARAM) -1);
                        fclose(hFile);
                    }
                    
                // Opened settings, parse...
                
                    // Position key...
    
                            // StartX...
                            if(INI_ALL_GOOD != ini_GetField("vRoach.ini", "Position", "StartX", szTemp))
                                session.nStartX = 320;
                            else
                                session.nStartX = atoi(szTemp);
                                
                            // StartY...
                            if(INI_ALL_GOOD != ini_GetField("vRoach.ini", "Position", "StartY", szTemp))
                                session.nStartY = 240;
                            else
                                session.nStartY = atoi(szTemp);
                        
                    // Server key...

                        // SMTP...
                        if(INI_ALL_GOOD != ini_GetField("vRoach.ini", "Server", "SMTP", session.szSMTPServer))
                            strcpy(session.szSMTPServer, "mail.zero47.com");
                            
                        // Port...
                        if(INI_ALL_GOOD != ini_GetField("vRoach.ini", "Server", "Port", szTemp))
                            session.nPort = 25;
                        else
                            session.nPort = atoi(szTemp);
                            
                        // EmailTo...
                        if(INI_ALL_GOOD != ini_GetField("vRoach.ini", "Server", "EmailTo", session.szEmailTo))
                            strcpy(session.szEmailTo, VROACH_DEFAULT_EMAILTO);

                    // User key...

                        // Name...
                        if(INI_ALL_GOOD != ini_GetField("vRoach.ini", "User", "Name", session.szName))
                        {
                            // Get name of currently logged in user...
                            dwTemp = sizeof(szTemp);
                            GetUserName(session.szName, &dwTemp);
                            SetDlgItemText(hDlg, IDD_CLIENT_NAME, session.szName);
                            
                            // Set focus in name window and highlight contents...
                            SetFocus(GetDlgItem(hDlg, IDD_CLIENT_NAME));
                            SendMessage(GetDlgItem(hDlg, IDD_CLIENT_NAME), EM_SETSEL, (WPARAM) 0, (LPARAM) -1);
                        }
                        else
                        {
                            // Set name...
                            SetDlgItemText(hDlg, IDD_CLIENT_NAME, session.szName);
                        }
                        
                        // Email...
                        if(INI_ALL_GOOD != ini_GetField("vRoach.ini", "User", "Email", session.szEmail))
                            strcpy(session.szEmail, "");
                        
                        // AttachSpecs...
                        if(INI_ALL_GOOD != ini_GetField("vRoach.ini", "User", "AttachSpecs", szTemp))
                            session.bAttachSpecs = FALSE;
                        else
                            session.bAttachSpecs = strtobool(szTemp);
                            
                        // AttachConfigs...
                        if(INI_ALL_GOOD != ini_GetField("vRoach.ini", "User", "AttachConfigs", szTemp))
                            session.bAttachConfigs = FALSE;
                        else
                            session.bAttachConfigs = strtobool(szTemp);

                        // BugSubmits...
                        if(INI_ALL_GOOD != ini_GetField("vRoach.ini", "User", "BugSubmits", szTemp))
                            session.nBugSubmits = 0;
                        else
                            session.nBugSubmits = atoi(szTemp);
                        
                    // Misc key...

                        // DebugMode...
                        if(INI_ALL_GOOD != ini_GetField("vRoach.ini", "Misc", "DebugMode", szTemp))
                            session.bDebugMode = FALSE;
                        else
                            session.bDebugMode = strtobool(szTemp);

                        // PlaySound...
                        if(INI_ALL_GOOD != ini_GetField("vRoach.ini", "Misc", "PlaySound", szTemp))
                            session.bPlaySound = TRUE;
                        else
                            session.bPlaySound = strtobool(szTemp);


                // Implement settings...

                    // Position key...

                        // StartX / StartY...
                        SetWindowPos(hDlg, HWND_TOPMOST, session.nStartX, session.nStartY, 0, 0,
                                     SWP_NOSIZE | SWP_NOZORDER);

                    // User key...

                        // Name (implemented on ini read above)...
                        
                        // Email...
                        SetDlgItemText(hDlg, IDD_CLIENT_EMAIL, session.szEmail);
                        
                        // AttachSpecs...
                        CheckDlgButton(hDlg, IDD_ATTACH_SPECS, session.bAttachSpecs ? BST_CHECKED : BST_UNCHECKED);
                                             
                        // AttachConfigs...
                        CheckDlgButton(hDlg, IDD_ATTACH_CONFIGS, session.bAttachConfigs ? BST_CHECKED : BST_UNCHECKED);

                        // BugSubmits...
                        sprintf(szStatus, "Ready...\n%s\n(You have submitted %i %s)", 
                                session.bDebugMode ? "***DEBUG MODE***" : " ",
                                session.nBugSubmits, (session.nBugSubmits == 1) ? "time" : "times");
                        SetDlgItemText(hDlg, IDD_STATUS, szStatus);
                    
                    // Misc key...

                        // PlaySound...
                        if(session.bPlaySound)
                            PlaySound("IDW_SOUND", g_globals.hInstance, SND_ASYNC | SND_RESOURCE);
                            
            // Set submit type combo box contents...

                // Dev-C++ distro...
                #ifdef DEVCPP_DISTRO
                SendMessage(GetDlgItem(hDlg, IDD_CLIENT_TYPE), CB_ADDSTRING, 0, (LPARAM) "Dev-C++ - Bug report");
                SendMessage(GetDlgItem(hDlg, IDD_CLIENT_TYPE), CB_ADDSTRING, 0, (LPARAM) "Dev-C++ - Other");
                SendMessage(GetDlgItem(hDlg, IDD_CLIENT_TYPE), CB_ADDSTRING, 0, (LPARAM) "Dev-C++ - Feature request");
                SendMessage(GetDlgItem(hDlg, IDD_CLIENT_TYPE), CB_ADDSTRING, 0, (LPARAM) "Dev-C++ - Packman");
                SendMessage(GetDlgItem(hDlg, IDD_CLIENT_TYPE), CB_ADDSTRING, 0, (LPARAM) "Dev-C++ - vRoach");
                SendMessage(GetDlgItem(hDlg, IDD_CLIENT_TYPE), CB_ADDSTRING, 0, (LPARAM) "Dev-C++ - vUpdate");
                SendMessage(GetDlgItem(hDlg, IDD_CLIENT_TYPE), CB_ADDSTRING, 0, (LPARAM) "Dev-C++ - My window keeps closing");
                #endif DEVCPP_DISTRO
                
                // Tentnology distro...
                #ifdef TENTNOLOGY_DISTRO
                SendMessage(GetDlgItem(hDlg, IDD_CLIENT_TYPE), CB_ADDSTRING, 0, (LPARAM) "Tentnology - Bug report");
                SendMessage(GetDlgItem(hDlg, IDD_CLIENT_TYPE), CB_ADDSTRING, 0, (LPARAM) "Tentnology - Other");
                SendMessage(GetDlgItem(hDlg, IDD_CLIENT_TYPE), CB_ADDSTRING, 0, (LPARAM) "Tentnology - Feature request");
                SendMessage(GetDlgItem(hDlg, IDD_CLIENT_TYPE), CB_ADDSTRING, 0, (LPARAM) "Tentnology - vRoach");
                #endif TENTNOLOGY_DISTRO

            // Return false cause we called SetFocus()...
            return FALSE;

        // Set dialog box colors...
        case WM_CTLCOLORDLG:
            return (LONG) hbrBackground;

        // Set edit box colors...
        case WM_CTLCOLOREDIT:
            
            // Delete old brush...
            DeleteObject(hBrush);
            
            // Create a brush...
            hBrush = CreateBrushIndirect(&logicalBrush);
            SetTextColor((HDC) wParam, RGB(255, 255, 255));
            SetBkColor((HDC) wParam, RGB(0, 0, 0));
            SelectObject((HDC) wParam, hBrush);
            
            // Return the brush...
            return (LONG) hBrush;

        // Command...
        case WM_COMMAND:
            
            // Which button?...
            switch(LOWORD(wParam))
            {
                // Send button hit...
                case IDD_SEND:

                    // Check validity of data entered...
                    
                        // Check name...
                        if(!GetWindowTextLength(GetDlgItem(hDlg, IDD_CLIENT_NAME)))
                        {
                            MessageBox(hDlg, "Enter your name...", VROACH_NAME, 
                                       MB_OK | MB_ICONINFORMATION);
                            SetFocus(GetDlgItem(hDlg, IDD_CLIENT_NAME));
                            return TRUE;
                        }
                        
                        // Check email address...

                            // No address...
                            if(GetDlgItemText(hDlg, IDD_CLIENT_EMAIL, szTemp, 64) <= 5)
                            {
                                MessageBox(hDlg, "Enter your email address...", VROACH_NAME, 
                                           MB_OK | MB_ICONINFORMATION);
                                SetFocus(GetDlgItem(hDlg, IDD_CLIENT_EMAIL));
                                return TRUE;
                            }
                            
                            // Invalid address...
                            if(!strstr(szTemp, "@") || !strstr(szTemp, "."))
                            {
                                MessageBox(hDlg, "Invalid email address...", VROACH_NAME, 
                                           MB_OK | MB_ICONINFORMATION);
                                SetFocus(GetDlgItem(hDlg, IDD_CLIENT_EMAIL));
                                return TRUE;
                            }
                        
                        // Check submit type...
                        
                            // No submit type...
                                
                                // Get text...
                                GetDlgItemText(hDlg, IDD_CLIENT_TYPE, session.szType, sizeof(session.szType) - 1);
                            
                                // No selection...
                                if(!strlen(session.szType))
                                {
                                    MessageBox(hDlg, "You must select a submit type...", VROACH_NAME,
                                               MB_OK | MB_ICONINFORMATION);
                                    SetFocus(GetDlgItem(hDlg, IDD_CLIENT_TYPE));
                                    return TRUE;
                                }
                                
                                // Made selection...
                                else
                                {
                                    // Window closing, make fun of them...
                                    if(strcmp(session.szType, "Dev-C++ - My window keeps closing") == 0)
                                    {
                                        MessageBox(hDlg, "Charlie, RTFM: http://bloodshed.net/dev/faq.html...", VROACH_NAME,
                                                   MB_OK | MB_ICONINFORMATION);
                                        return TRUE;
                                    }
                                }
                            

                        // Comments too short, 21 characters or less...
                        if(GetWindowTextLength(GetDlgItem(hDlg, IDD_CLIENT_COMMENTS)) <= 21)
                        {
                            MessageBox(hDlg, "Comments too short...", VROACH_NAME, 
                                       MB_OK | MB_ICONINFORMATION);
                            SetFocus(GetDlgItem(hDlg, IDD_CLIENT_COMMENTS));
                            return TRUE;
                        }
                        
                        // Comments contain default text...
                        szTemp[0] = '\x0';
                        GetDlgItemText(hDlg, IDD_CLIENT_COMMENTS, szTemp, sizeof(szTemp) - 1);
                        if(strncmp(szTemp, "If this is a bug report,", strlen("If this is a bug report,")) == 0)
                        {
                            MessageBox(hDlg, "You must change the comments...", VROACH_NAME, 
                                       MB_OK | MB_ICONINFORMATION);
                            SetFocus(GetDlgItem(hDlg, IDD_CLIENT_COMMENTS));
                            return TRUE;
                        }
                    
                    // Disable windows....
                    EnableWindow(GetDlgItem(g_globals.hDlg, IDD_CLIENT_NAME), FALSE);
                    EnableWindow(GetDlgItem(g_globals.hDlg, IDD_CLIENT_EMAIL), FALSE);
                    EnableWindow(GetDlgItem(g_globals.hDlg, IDD_CLIENT_TYPE), FALSE);
                    EnableWindow(GetDlgItem(g_globals.hDlg, IDD_CLIENT_COMMENTS), FALSE);
                    EnableWindow(GetDlgItem(g_globals.hDlg, IDD_SEND), FALSE);
                    EnableWindow(GetDlgItem(g_globals.hDlg, IDD_ABOUT), FALSE);
                    EnableWindow(GetDlgItem(g_globals.hDlg, IDD_ATTACH_SPECS), FALSE);
                    EnableWindow(GetDlgItem(g_globals.hDlg, IDD_ATTACH_CONFIGS), FALSE);

                    // Get information...

                        // Assemble message...
                        
                            // Allocate space for user comments and other shit...
                            session.pszComments     = (char *) malloc(GetWindowTextLength(GetDlgItem(hDlg, IDD_CLIENT_COMMENTS)) + 10);

                            // NT...
                            if(IsNT())
                            {
                                session.pszEmailMessage = 
                                    (char *) malloc(GetWindowTextLength(GetDlgItem(hDlg, IDD_CLIENT_COMMENTS)) 
                                                    + getFileSizeAppDirectory("devcpp.ini") + getFileSizeAppDirectory("devcpp.cfg")
                                                    + getFileSizeAppDirectory("devshortcuts.cfg") + getFileSize("vUpdate Install Database.txt")
                                                    + getFileSize("vUpdate Debug Log.txt") + 4096);
                            }
                            // 9x...
                            else
                            {
                                session.pszEmailMessage = 
                                    (char *) malloc(GetWindowTextLength(GetDlgItem(hDlg, IDD_CLIENT_COMMENTS)) 
                                                    + getFileSize("devcpp.ini") + getFileSize("devcpp.cfg")
                                                    + getFileSize("devshortcuts.cfg") + getFileSize("vUpdate Install Database.txt")
                                                    + getFileSize("vUpdate Debug Log.txt") + 4096);
                            }

                            // Get window data...
                            GetDlgItemText(hDlg, IDD_CLIENT_NAME, session.szName, sizeof(session.szName) - 1);
                            GetDlgItemText(hDlg, IDD_CLIENT_EMAIL, session.szEmail, sizeof(session.szEmail) - 1);
                            GetDlgItemText(hDlg, IDD_CLIENT_COMMENTS, session.pszComments, GetWindowTextLength(GetDlgItem(hDlg, IDD_CLIENT_COMMENTS)) + 1);
                            
                                // Error...
                                if(!(session.pszComments && session.pszEmailMessage))
                                {
                                    MessageBox(hDlg, "Sorry dude, not enough memory...", 
                                               VROACH_NAME, MB_OK | MB_ICONERROR);
                                    return TRUE;
                                }
                            
                            // Get OS info...
                            os.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);

                                // Error...
                                if(!GetVersionEx(&os))
                                {
                                    MessageBox(hDlg, "Sorry dude, but I couldn't get some info on your system...",
                                               VROACH_NAME, MB_OK | MB_ICONERROR);
                                    return TRUE;
                                }
                                
                            // Assemble requested info into message...

                                // Main info...

                                    // Version...
                                    sprintf(szTemp, "vRoach Version: %s\r\n", VROACH_NAME);
                                    strcpy(session.pszEmailMessage, szTemp);
                                    
                                    // Submitted by?...
                                    sprintf(szTemp, "Submitted by: %s\r\n", session.szName);
                                    strcat(session.pszEmailMessage, szTemp);
                                    
                                    // Total submits...
                                    sprintf(szTemp, "Total submits: %i\r\n", session.nBugSubmits);
                                    strcat(session.pszEmailMessage, szTemp);
                                    
                                    // Email...
                                    sprintf(szTemp, "Email: %s\r\n", session.szEmail);
                                    strcat(session.pszEmailMessage, szTemp);
                                    
                                    // User's Comment...
                                    sprintf(szTemp, "Comment: ");
                                    strcat(session.pszEmailMessage, szTemp);
                                    strcat(session.pszEmailMessage, session.pszComments);
                                    strcat(session.pszEmailMessage, "\r\n\r\n");
                                    
                                // Attach system specs (if enabled)...
                                strcat(session.pszEmailMessage, "System specification...\r\n"
                                                                "=========================================\r\n");
                                if(IsDlgButtonChecked(hDlg, IDD_ATTACH_SPECS) == BST_CHECKED)
                                {
                                    // Platform ID...
                                    sprintf(szTemp, "Platform ID: %s\r\n", 
                                           (os.dwPlatformId == VER_PLATFORM_WIN32_NT) ? "Winblows NT" 
                                                                                      : "Winblows 9x");
                                    strcat(session.pszEmailMessage, szTemp);
                                    
                                    // Platform version...
                                    sprintf(szTemp, "Platform Version: %i.%i\r\n", os.dwMajorVersion,
                                            os.dwMinorVersion);
                                    strcat(session.pszEmailMessage, szTemp);
                                    
                                    // Platform build number...
                                    sprintf(szTemp, "Platform Build Number: %i\r\n",
                                            (os.dwPlatformId == VER_PLATFORM_WIN32_NT) ? os.dwBuildNumber 
                                                                                       : LOWORD(os.dwBuildNumber));
                                    strcat(session.pszEmailMessage, szTemp);

                                    // Platform extra info...
                                    sprintf(szTemp, "Platform Extra Info: %s\r\n", os.szCSDVersion);
                                    strcat(session.pszEmailMessage, szTemp);
                                    
                                    // Screen resolution...
                                    sprintf(szTemp, "Screen Resolution: %i by %i\r\n",
                                        GetSystemMetrics(SM_CXSCREEN), GetSystemMetrics(SM_CYSCREEN));
                                    strcat(session.pszEmailMessage, szTemp);
                                    
                                    // Footer...
                                    strcat(session.pszEmailMessage, "\r\n=========================================\r\n\r\n");
                                }
                                else
                                {
                                    strcat(session.pszEmailMessage, "User chose not to release..."
                                                                    "\r\n=========================================\r\n\r\n");
                                }
                                
                                // Attach configs (if enabled)...
                                strcat(session.pszEmailMessage, "Program configuration settings...\r\n"
                                                                "=========================================\r\n");
                                if(IsDlgButtonChecked(hDlg, IDD_ATTACH_CONFIGS) == BST_CHECKED)
                                {
                                    // Files to include if for Dev-C++...
                                    #ifdef DEVCPP_DISTRO

                                        // devcpp.ini...
                                        strcat(session.pszEmailMessage, IsNT() ? getFileContentsAppDirectory("devcpp.ini", TRUE)
                                                                               : getFileContents("devcpp.ini", TRUE));
                                        
                                        // devcpp.cfg...
                                        strcat(session.pszEmailMessage, IsNT() ? getFileContentsAppDirectory("devcpp.cfg", TRUE)
                                                                               : getFileContents("devcpp.cfg", TRUE));
                                        
                                        // devshortcuts.cfg...
                                        strcat(session.pszEmailMessage, IsNT() ? getFileContentsAppDirectory("devshortcuts.cfg", TRUE)
                                                                               : getFileContents("devshortcuts.cfg", TRUE));
                                        
                                        // vUpdate Install Database.txt...
                                        strcat(session.pszEmailMessage, getFileContents("vUpdate Install Database.txt", TRUE));
                                        
                                        // User's vUpdate Debug Log.txt...
                                        strcat(session.pszEmailMessage, getFileContents("vUpdate Debug Log.txt", TRUE));

                                    #endif DEVCPP_DISTRO
                                    
                                    // Files to include if for Tentnology...
                                    #ifdef TENTNOLOGY_DISTRO
                                        
                                        // Find tentnology ini file...
                                        hSearchHandle = FindFirstFile("*tent*.ini", &FindData);
                                        
                                            // Can't find file...
                                            if(hSearchHandle == INVALID_HANDLE_VALUE)
                                            {
                                                strcat(session.pszEmailMessage, getFileContents("Tent98v6.5.1.INI", TRUE));
                                                FindClose(hSearchHandle);
                                            }
                                            // Found it...
                                            else
                                            {
                                                strcat(session.pszEmailMessage, getFileContents(FindData.cFileName, TRUE));
                                                FindClose(hSearchHandle);
                                            }
                                        
                                    #endif TENTNOLOGY_DISTRO
                                    
                                    // Footer...
                                    strcat(session.pszEmailMessage, "\r\n=========================================\r\n\r\n");
                                }
                                else
                                {
                                    strcat(session.pszEmailMessage, "User chose not to release..."
                                                                    "\r\n=========================================\r\n\r\n");
                                }
                                
                                // vRoach developer comments...
                                strcat(session.pszEmailMessage, "\r\n\r\nQuestions, comments, and suggestions about vRoach\r\n"
                                                                "can be sent to kip@zero47.com. Good luck. L8tr.\r\n\r\n");

                            // Debug mode on, display, but don't send message...
                            if(session.bDebugMode)
                            {
                                // Show transmission in message box...
                                MessageBox(hDlg, session.pszEmailMessage, "Report to send...", MB_OK);
                                
                                // Kill thread...
                                SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, TRUE);
                                
                                // Re-enable buttons...
                                EnableWindow(GetDlgItem(g_globals.hDlg, IDD_CLIENT_NAME), TRUE);
                                EnableWindow(GetDlgItem(g_globals.hDlg, IDD_CLIENT_EMAIL), TRUE);
                                EnableWindow(GetDlgItem(g_globals.hDlg, IDD_CLIENT_TYPE), TRUE);
                                EnableWindow(GetDlgItem(g_globals.hDlg, IDD_CLIENT_COMMENTS), TRUE);
                                EnableWindow(GetDlgItem(g_globals.hDlg, IDD_SEND), TRUE);
                                EnableWindow(GetDlgItem(g_globals.hDlg, IDD_ABOUT), TRUE);
                                EnableWindow(GetDlgItem(g_globals.hDlg, IDD_ATTACH_SPECS), TRUE);
                                EnableWindow(GetDlgItem(g_globals.hDlg, IDD_ATTACH_CONFIGS), TRUE);
                                return TRUE;
                            }

                    // Send email...
                    hThread = CreateThread(NULL, 0, SocketThread, &session, 0, &dwThreadId);

                        // Check for error...
                        if(!hThread)
                        {
                            // Enable windows....
                            EnableWindow(GetDlgItem(g_globals.hDlg, IDD_CLIENT_NAME), TRUE);
                            EnableWindow(GetDlgItem(g_globals.hDlg, IDD_CLIENT_EMAIL), TRUE);
                            EnableWindow(GetDlgItem(g_globals.hDlg, IDD_CLIENT_TYPE), TRUE);
                            EnableWindow(GetDlgItem(g_globals.hDlg, IDD_CLIENT_COMMENTS), TRUE);
                            EnableWindow(GetDlgItem(g_globals.hDlg, IDD_SEND), TRUE);
                            EnableWindow(GetDlgItem(g_globals.hDlg, IDD_ABOUT), TRUE);
                            EnableWindow(GetDlgItem(g_globals.hDlg, IDD_ATTACH_SPECS), TRUE);
                            EnableWindow(GetDlgItem(g_globals.hDlg, IDD_ATTACH_CONFIGS), TRUE);

                            // Tell user...
                            StatusOut("Thread error...");
                            return TRUE;
                        }

                    return TRUE;

                // About button hit...
                case IDD_ABOUT:
                    DialogBox(g_globals.hInstance, "AboutBox", hDlg, AboutDialogProc);
                    return TRUE;

                // Cancel button hit...
                case IDD_CLOSE:
                    SendMessage(hDlg, WM_CLOSE, 0, 0);
                    CloseHandle(hBrush);
                    CloseHandle(hbrBackground);
                    return TRUE;

                // Window has focus, clear...
                case IDD_CLIENT_COMMENTS:
                {
                    switch(HIWORD(wParam))
                    {
                        // Contents going to change...
                        case EN_CHANGE:
                            
                            // They hit ctrl-enter, request send...
                            if((GetKeyState(VK_CONTROL) < 0) && (GetKeyState(VK_RETURN) < 0))
                            {
                                SendMessage(hDlg, WM_COMMAND, IDD_SEND, 0);
                                return 0;
                            }

                            return 0;
                    }
                }
            }
            break;

        // Close button hit...
        case WM_CLOSE:

            // Shutdown winsock...
            WSACleanup();

            // Get settings...

                // Position key...

                    // StartX / StartY...
                    GetWindowRect(hDlg, &rect);
                    session.nStartX = rect.left;
                    session.nStartY = rect.top;

                // User key...

                    // Name...
                    GetDlgItemText(hDlg, IDD_CLIENT_NAME, session.szName, sizeof(session.szName) - 1);

                    // AttachSpecs...
                    (IsDlgButtonChecked(hDlg, IDD_ATTACH_SPECS) == BST_CHECKED)
                        ? session.bAttachSpecs = TRUE : session.bAttachSpecs = FALSE;

                    // AttachConfigs...
                    (IsDlgButtonChecked(hDlg, IDD_ATTACH_CONFIGS) == BST_CHECKED)
                        ? session.bAttachConfigs = TRUE : session.bAttachConfigs = FALSE;

                    // Email...
                    GetDlgItemText(hDlg, IDD_CLIENT_EMAIL, session.szEmail, sizeof(session.szEmail) - 1);

            // Save settings...

                // Position key...

                    // StartX / StartY...
                    ini_SetField("vRoach.ini", "Position", "StartX",    itoa(session.nStartX, szTemp, 10));
                    ini_SetField("vRoach.ini", "Position", "StartY",    itoa(session.nStartY, szTemp, 10));

                // Server key...

                    // SMTP...
                    ini_SetField("vRoach.ini", "Server", "SMTP",        session.szSMTPServer);

                    // Port...
                    ini_SetField("vRoach.ini", "Server", "Port",        itoa(session.nPort, szTemp, 10));

                    // EmailTo...
                    ini_SetField("vRoach.ini", "Server", "EmailTo",     session.szEmailTo);

                // User key...

                    // Name...
                    ini_SetField("vRoach.ini", "User", "Name",          session.szName);

                    // Email...
                    ini_SetField("vRoach.ini", "User", "Email",         session.szEmail);

                    // AttachSpecs...
                    ini_SetField("vRoach.ini", "User", "AttachSpecs",   itoa(session.bAttachSpecs, szTemp, 10));

                    // AttachConfigs...
                    ini_SetField("vRoach.ini", "User", "AttachConfigs", itoa(session.bAttachConfigs, szTemp, 10));

                    // BugSubmits...
                    ini_SetField("vRoach.ini", "User", "BugSubmits",    itoa(session.nBugSubmits, szTemp, 10));

                // Misc...
                
                    // DebugMode...
                    ini_SetField("vRoach.ini", "Misc", "DebugMode",     itoa(session.bDebugMode, szTemp, 10));

                    // PlaySound...
                    ini_SetField("vRoach.ini", "Misc", "PlaySound",     itoa(session.bPlaySound, szTemp, 10));

            // Kill dialog box...
            EndDialog(hDlg, 0);
            return TRUE;
            
        // Done socket thread...
        case WM_DONE_SOCKET_THREAD:

            // Unload winsock and close any open sockets...
            WSACleanup();

            // Sent email successfully, keep buttons greyed out...
            if(lParam == TRUE)
            {
                SetFocus(GetDlgItem(hDlg, IDD_CLOSE));
                return FALSE;
            }

            // Enable windows...
            EnableWindow(GetDlgItem(g_globals.hDlg, IDD_CLIENT_NAME), TRUE);
            EnableWindow(GetDlgItem(g_globals.hDlg, IDD_CLIENT_EMAIL), TRUE);
            EnableWindow(GetDlgItem(g_globals.hDlg, IDD_CLIENT_TYPE), TRUE);
            EnableWindow(GetDlgItem(g_globals.hDlg, IDD_CLIENT_COMMENTS), TRUE);
            EnableWindow(GetDlgItem(g_globals.hDlg, IDD_SEND), TRUE);
            EnableWindow(GetDlgItem(g_globals.hDlg, IDD_ABOUT), TRUE);
            EnableWindow(GetDlgItem(g_globals.hDlg, IDD_ATTACH_SPECS), TRUE);
            EnableWindow(GetDlgItem(g_globals.hDlg, IDD_ATTACH_CONFIGS), TRUE);

            return FALSE;
            
        // Repaint time...
        case WM_PAINT:

            // Get device contexts...
            hdc             = BeginPaint(hDlg, &ps);
            
            // Put logo in memory device context...
            hdcMemoryImage  = CreateCompatibleDC(hdc);
            SelectObject(hdcMemoryImage, hLogo);
            
            // Draw it on the picture box...
            BitBlt(hdc, 12, 5, 280, 55, hdcMemoryImage, 0, 0, SRCCOPY);
            
            // Delete the device contexts...
            DeleteDC(hdc);
            DeleteDC(hdcMemoryImage);
            
            // End paints...
            EndPaint(hDlg, &ps);
            return 0;

    }
    return FALSE;
}

// About box proc...
BOOL CALLBACK AboutDialogProc(HWND hDlg, UINT msg, WPARAM wParam, LPARAM lParam)
{
    // Variables...
    static char szBuffer[] =    "[INTRODUCTION]\r\n"
                                "Hey there,\r\n\r\n"
                                "vRoach is a cool way of getting feedback from the "
                                "public to us. Just enter your data and hit ctrl-enter. "
                                "Check out vRoach.ini for cool customizations. Speaking " 
                                "of which, you can add more than one email address in the "
                                "EmailTo field in the ini. Just seperate each address with "
                                "a space.\r\n\r\n"

                                "[CHANGE-LOG]\r\n"
                                "vRoach 1.505:\r\n"
                                "* Start of change log\r\n"
                                "* Fixed bug in not sending config files in NT\r\n\r\n"
                                
                                "vRoach 1.504\r\n"
                                "* Source code released. Browse to /Vertigo on cvs\r\n\r\n"

                                "[HINTS]\r\n"
                                "If this is a bug report, make sure you tell us EXACTLY "
                                "on how to reproduce it. Being a power charlie and saying "
                                "\"It crashed.\" will accomplish nothing but your report "
                                "being deleted. vRoach is a tool to help us build a better "
                                "product for you, don't abuse it.\r\n\r\n"
    
                                "[ABOUT]\r\n"
                                "Proudly written in pure C...\r\n"
                                "unlike the rest of this shit ;)\r\n\r\n"
                                
                                "[THANKS]\r\n"
                                "Andreas Åberg\r\n"
                                "Colin Laplace\r\n"
                                "Fernando\r\n"
                                "Françoise\r\n"
                                "Hick Kemp\r\n"
                                "Lim Yubin\r\n"
                                "Reed Weikum\r\n"
                                "The FSM/UPX/LAG/JO/Dev/DoD crews\r\n"
                                "Wayne (the old)\r\n"
                                "Zero Valintine and his friends\r\n"
                                "And all the other non-anon's ;)\r\n\r\n"

                                "[LICENSE]\r\n"
                                "This program is distributed in the hope that it will "
                                "be useful, but WITHOUT ANY WARRANTY; without even "
                                "the implied warranty of MERCHANTABILITY or "
                                "FITNESS FOR A PARTICULAR PURPOSE.\r\n\r\n";

    // Message handling...
    switch(msg)
    {
        // Dialog is being created...
        case WM_INITDIALOG:
            SetDlgItemText(hDlg, IDD_LICENSE, szBuffer);
            return TRUE;

        // Command...
        case WM_COMMAND:
            switch(LOWORD(wParam))
            {
                // Ok button hit...
                case IDOK:
                    
                    // Kill dialog box...
                    EndDialog(hDlg, 0);
                    return TRUE;

                // Programmer button hit...
                case IDD_PROGRAMMER:
                    ShellExecute(NULL, "open", "http://zero47.com/html/bio.html",
                                     NULL, NULL, SW_MAXIMIZE);
                    return TRUE;

                // Email button hit...
                case IDD_EMAIL:
                    ShellExecute(NULL, "open", "mailto:kip@zero47.com?subject= " 
                                 VROACH_NAME " - " VROACH_DISTRIBUTION,
                                 NULL, NULL, SW_MAXIMIZE);
                    return TRUE;

                // ICQ button hit...
                case IDD_ICQ:
                    ShellExecute(NULL, "open", "http://wwp.icq.com/whitepages/message_me/1,,,00.icq?uin=29008229&action=message",
                                 NULL, NULL, SW_MAXIMIZE);
                    return TRUE;
                    
                // URL button hit...
                case IDD_URL:
                    ShellExecute(NULL, "open", "http://www.zero47.com/",
                                 NULL, NULL, SW_MAXIMIZE);
                    return TRUE;

                // User manual button hit...
                case IDD_USER_MANUAL:
                    ShellExecute(NULL, "open", "http://www.zero47.com/vertigo/vRoach/UserManual.html",
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
