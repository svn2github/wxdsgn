/* 
   Name: WndProc (module)
   Author: Kip Warner
   Description: Main window proc...
   Copyright: Yes
*/


#include "prototypes.h"

    // Directory where vUpdate is...
    extern char    g_szExeDirectory[256];
    
    // Directory of temp folder...
    extern char    g_szTempDirectory[256];
    
    // Guess...
    extern char    g_szAppName[32];
    
    // Button window proc procedure...
    extern WNDPROC OldProc;
    
    // Debug mode...
    extern BOOL    g_bDebugMode;

LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
    // Variables...
    static  HMENU               hMenu                   = 0;
    static  HINSTANCE           hInstance               = 0;
    static  HBRUSH              hBrush                  = 0;
    static  HFONT               hFont                   = 0;
    static  char                szBuffer[1024]          = {0};
    static  char                szAnnouncements[1024]   = {0};
    static  LOGBRUSH            logicalBrush;
            int                 i                       = 0;
    static  int                 nNumControls            = 0;
    static  int                 nNumPackage             = 0;
    static  int                 nTopPackage             = 0;
    static  RECT                rcLogo;
    static  POINT               ptMouse;
    static  POINT               ptMouseOld;
    static  int                 nNumDisplayed           = 0;
    static  short               nDownloadMode           = MODE_READY;
    static  DownloadUpdatesData updatesData;
    static  HANDLE              hThread                 = 0;
    static  DWORD               dwThreadId              = 69;
    
    // Stuff for WM_PAINT...
    static  HBITMAP             hLogo                   = 0;
            BITMAP              strBitmap;
            HDC                 hdc;
            HDC                 hdcPictureBox;
            HDC                 hdcMemoryImage;
            PAINTSTRUCT         ps;
    
    // Stuff for CreateWindowEx all in one place...
    static  controlData controls[] = 
            {
                {NULL, 0, "button", "Status:", WS_CHILD | WS_VISIBLE | BS_GROUPBOX, 8, 4, 217, 78, (HMENU) ID_STATUS_GROUPBOX},
                {NULL, 0, "button", "Announcements:", WS_CHILD | WS_VISIBLE | BS_GROUPBOX, 8, 87, 217, 106, (HMENU) ID_ANNOUNCEMENTS_GROUPBOX},
                {NULL, 0, "button", "Descriptions:", WS_CHILD | WS_VISIBLE | BS_GROUPBOX, 224, 87, 241, 106, (HMENU) ID_DESCRIPTION_GROUPBOX},
                {NULL, 0, "button", "Packages:", WS_CHILD | WS_VISIBLE | BS_GROUPBOX, 224, 4, 180, 78, (HMENU) ID_PACKAGES_GROUPBOX},
                {NULL, 0, "static", "", WS_CHILD | WS_VISIBLE | SS_SUNKEN, 420, 10, 132, 72, (HMENU) ID_PICTURE_BOX},
                {NULL, WS_EX_CLIENTEDGE, "listbox", "", WS_CHILD | WS_VSCROLL | WS_VISIBLE | LBS_STANDARD & ~LBS_SORT, 16, 18, 201, 75, (HMENU) ID_STATUS_WINDOW},
                {NULL, WS_EX_CLIENTEDGE, "edit", "", WS_CHILD | WS_VISIBLE | ES_LEFT | ES_MULTILINE | ES_AUTOVSCROLL | WS_VSCROLL, 16, 104, 201, 81, (HMENU) ID_ANNOUNCEMENTS},
                {NULL, WS_EX_CLIENTEDGE, "edit", "", WS_CHILD | WS_VISIBLE | ES_LEFT | ES_MULTILINE | ES_AUTOVSCROLL | WS_VSCROLL, 232, 104, 225, 81, (HMENU) ID_DESCRIPTION},
                {NULL, 0, "button", "Start", WS_CHILD | WS_VISIBLE | BS_DEFPUSHBUTTON, 472, 93, 80, 24, (HMENU) ID_START},
                {NULL, 0, "button", "Options", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 472, 124, 80, 24, (HMENU) ID_OPTIONS},
                {NULL, 0, "button", "About", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 472, 156, 80, 24, (HMENU) ID_ABOUT},
                {NULL, 0, "button", "Exit", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON, 472, 188, 80, 24, (HMENU) ID_EXIT},
                {NULL, 0, PROGRESS_CLASS, (LPSTR) NULL, WS_CHILD | WS_VISIBLE | PBS_SMOOTH, 8, 199, 457, 12, (HMENU) 0},
                {NULL, 0, "scrollbar", (LPSTR) NULL, WS_CHILD | SBS_VERT, 404, 10, 15, 70, (HMENU) ID_SCROLL_BAR}
            };
            
    static  ScriptSettings  settings;
    static  Package         package[64];
    static  vUpdateOptions  options;

    // Main message loop...
    switch(msg)
    {
        // Create our interface...
        case WM_CREATE:

            // Get module handle...
            hInstance = ((LPCREATESTRUCT) lParam)->hInstance;
            
            // How many controls do we have to create?...
            nNumControls = sizeof(controls) / sizeof(controls[0]);
            
            // Add stuff to system menu...
            hMenu = GetSystemMenu(hwnd, FALSE);
            AppendMenu(hMenu, MF_SEPARATOR, 0, NULL);
            AppendMenu(hMenu, MF_STRING, IDM_SYS_OPTIONS, "Options");
            AppendMenu(hMenu, MF_STRING, IDM_SYS_ABOUT, "About");
            
            // Create all our controls...
            for(i = 0; i < nNumControls; i++)
                controls[i].hwnd = CreateWindowEx(controls[i].dwExStyle, controls[i].lpClassName,
                                                  controls[i].lpWindowName, controls[i].dwStyle,
                                                  controls[i].x, controls[i].y, controls[i].nWidth,
                                                  controls[i].nHeight, hwnd, (HMENU) controls[i].hMenu, hInstance, 
                                                  NULL);

            // Can't create progress bar. Probaby cause common ctrl dll isn't loaded...
            if(!controls[ID_PROGRESS_BAR].hwnd)
            {
                MessageBox(hwnd, "Sorry, but I couldn't draw myself."
                " Something is probably messed with your system",
                "vUpdate", MB_OK | MB_ICONERROR);
                PostQuitMessage(0);
            }

            // Create font...
            hFont = CreateFont(13, 0, 0, 0, FW_NORMAL, 0, 0, 0,
                               DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
                               DEFAULT_QUALITY, DEFAULT_PITCH, "Arial");
            
                // Petered out...
                if(!hFont) 
                {
                    MessageBox(hwnd, "There was a problem while rendering the font. "
                               "Please ensure that your system carries Lucida Console font.",
                               "Error", MB_OK | MB_ICONERROR);
                    PostQuitMessage(0);
                }

            // Set font...
            wParam = (WPARAM) hFont;
            lParam = MAKELPARAM(TRUE, 0);
            for(i = 0; i < nNumControls; i++)
                SendMessage(controls[i].hwnd, WM_SETFONT, wParam, lParam);

            // Tab focus on start button...
            SetFocus(controls[ID_START].hwnd);

            // Get handle to our logo and check for error...
            hLogo = LoadBitmap(hInstance, MAKEINTRESOURCE(ID_LOGOBOX));
            GetObject(hLogo, sizeof(BITMAP), &strBitmap);

                if(!hLogo)
                {
                    MessageBox(hwnd, "Sorry, but there was a while rendering my logo.",
                                     "Error", MB_OK);
                    PostQuitMessage(0);
                }

            // Fill in dimensions of rect for logo box... 420, 10, 132, 72
            rcLogo.left     = 420;
            rcLogo.top      = 10;
            rcLogo.right    = 552;
            rcLogo.bottom   = 82;
            ptMouseOld.x    = 0;
            ptMouseOld.y    = 0;

            // Extract macros and user options. Check for error...
            SendMessage(hwnd, WM_LOAD_OPTIONS, 0, 0);

            // Create timer to monitor mouse overs...
            SetTimer(hwnd, ID_TIMER, TIMER_DELAY, NULL);

            // Tell user whats going on...
            StatusOut("Ready, hit start to begin...", controls[ID_STATUS_WINDOW].hwnd);

            return 0;

        // Command occured...
        case WM_COMMAND:
            switch(LOWORD(wParam))
            {
                // Start button pressed...
                case ID_START:

                    // Extract macros and user options. Check for error...
                    SendMessage(hwnd, WM_LOAD_OPTIONS, 0, 0);

                    // Don't scan for updates because download mode is set...
                    if(nDownloadMode == MODE_DOWNLOAD_SET)
                    {
                        SendMessage(hwnd, WM_DOWNLOAD_UPDATES, 0, 0);
                        return 0;
                    }
                    
                    // Change to hour glass cursor...
                    SetCursor(LoadCursor(NULL, IDC_WAIT));
                    
                    // Reset display, incase they are re-scanning...
                    ResetState(hwnd, controls, package);

                    // Execute start button code...
                    nNumPackage = StartButton(hwnd, controls, &settings, package, &options);
                    SetWindowText(controls[ID_START].hwnd, "Start");
                    EnableWindow(controls[ID_START].hwnd, TRUE);
                    
                    // Reset cursor...
                    SetCursor(LoadCursor(NULL, IDC_ARROW));
                    
                    // Configure scroll bar...
                    SetScrollRange(controls[ID_SCROLL_BAR].hwnd, SB_CTL, 0, nNumPackage - 1, TRUE);
                    SetScrollPos(controls[ID_SCROLL_BAR].hwnd, SB_CTL, 0, TRUE);

                    // There are packages...
                    if(nNumPackage > 0)
                    {
                        // Set announcements...
                        SetWindowText(controls[ID_ANNOUNCEMENTS].hwnd, settings.szAnnouncements);
                    
                        // Backup announcements box text incase user edits...
                        GetWindowText(controls[ID_ANNOUNCEMENTS].hwnd, szAnnouncements, 1024);

                        // Set description window...
                        sprintf(szBuffer, "There are %i packages available...", nNumPackage);
                        SetWindowText(controls[ID_DESCRIPTION].hwnd, szBuffer);
                        
                        // Set package groupbox title...
                        sprintf(szBuffer, "Packages (%i): ", nNumPackage);
                        SetWindowText(controls[ID_PACKAGES_GROUPBOX].hwnd, szBuffer);
                        
                        // Display the updates...
                        DisplayUpdates(hwnd, package, nNumPackage, 1);
                        
                        // Display scroll bar...
                        ShowWindow(controls[ID_SCROLL_BAR].hwnd, SW_SHOW);
                        
                        // Top package should be 1...
                        nTopPackage = 1;
                        
                        // Reset focus to main form...
                        SetFocus(controls[ID_EXIT].hwnd);
                        return 0;
                    }
                    
                    // There are no packages, or an error occured...
                    else
                    {
                        ResetState(hwnd, controls, package);
                        return 0;
                    }

                // Options button pressed...
                case ID_OPTIONS:

                    // Open dialog box...
                    DialogBoxParam(hInstance, "OptionsBox", hwnd, OptionsDialogProc, (LPARAM) &options);

                    return 0;

                // About button pressed...
                case ID_ABOUT:
                    DialogBox(hInstance, "AboutBox", hwnd, AboutDialogProc);
                    return 0;

                // Exit button pressed...
                case ID_EXIT:

                    // Close any possibly open sockets...
                    WSACleanup();
                    
                    // Post quit message...
                    PostQuitMessage(0);
                    return 0;

                // Announcements box...
                case ID_ANNOUNCEMENTS:

                    // They are trying to type something in it...
                    if(HIWORD(wParam) == EN_CHANGE)
                    {
                        SetWindowText(controls[ID_ANNOUNCEMENTS].hwnd,
                                      szAnnouncements);
                        return 0;
                    }
                    break;

                // Top item on the list clicked...
                case ID_TOP_LIST_ITEM:

                    // Negate whatever it was...
                    package[nTopPackage].bChecked       = !package[nTopPackage].bChecked;
                    return 0;

                // Middle item on the list clicked...
                case ID_MIDDLE_LIST_ITEM:

                    // Negate whatever it was...
                    package[nTopPackage + 1].bChecked   = !package[nTopPackage + 1].bChecked;
                    return 0;

                // Bottom item on the list clicked...
                case ID_BOTTOM_LIST_ITEM:

                    // Negate whatever it was...
                    package[nTopPackage + 2].bChecked   = !package[nTopPackage + 2].bChecked;
                    return 0;
            }
            break;

        // Set listbox colors...
        case WM_CTLCOLORLISTBOX:

            // Delete old brush...
            DeleteObject(hBrush);

            // Create a brush...
            hBrush = CreateBrushIndirect(&logicalBrush);
            SetTextColor((HDC) wParam, RGB(255, 255, 255));
            SetBkColor((HDC) wParam, RGB(0,0,0));
            SelectObject((HDC) wParam, hBrush);
            
            // Return the brush...
            return (LONG) hBrush;

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

        // Download updates button clicked...
        case WM_DOWNLOAD_UPDATES:

            // Remove list items, incase already some there...
            DisplayUpdates(hwnd, package, 0, 0);
            
            // Prep DownloadUpdatesThread() data...
            updatesData.hwnd        = hwnd;
            updatesData.controls    = controls;
            updatesData.settings    = &settings;
            updatesData.package     = package;
            updatesData.nNumPackage = nNumPackage;
            updatesData.options     = &options;
            
            // Set mode...
            nDownloadMode = MODE_DOWNLOADING;
            
            // Clear announcements and description window...
            SetWindowText(controls[ID_ANNOUNCEMENTS].hwnd, "");
            SetWindowText(controls[ID_DESCRIPTION].hwnd, "");
            
            // Launch thread and begin downloads...
            hThread = CreateThread(NULL, 0, DownloadUpdatesThread, &updatesData,
                                   0, &dwThreadId);

                    // Check for error...
                    if(!hThread)
                    {
                        MessageBox(hwnd, "Unable to create thread. Windows may have gone stupid.",
                                   g_szAppName, MB_OK | MB_ICONERROR);
                        PostQuitMessage(0);
                    }

            return 0;
            
        // Download thread says its done...
        case WM_FINISHED_ALL_DOWNLOADS:

            // Turn off downloading mode...
            nDownloadMode = MODE_READY;
            
            // Kill thread (for no apparent reason)...
            CloseHandle(hThread);

            // Reset stuff back to normal...
            ResetState(hwnd, controls, package);
            nNumPackage = 0;
            FlashWindow(hwnd, TRUE);
            MessageBeep(MB_ICONINFORMATION);

            return 0;

        // Keyboard key pressed...
        case WM_KEYDOWN:

            // What key was pressed?...
            switch(wParam)
            {
                // User hit f1 for about...
                case VK_F1:
                    DialogBox(hInstance, "AboutBox", hwnd, AboutDialogProc);
                    return 0;
                    
                // User hit f2 for options...
                case VK_F2:
                    
                    // Open dialog box...
                    DialogBoxParam(hInstance, "OptionsBox", hwnd, OptionsDialogProc, (LPARAM) &options);

                    return 0;
                
                // User hit escape...
                case VK_ESCAPE:
                    PostQuitMessage(0);
                    return 0;
            }
            break;

        // Load options and implement...
        case WM_LOAD_OPTIONS:

            // Extract macros and user options. Check for error...
            if(!GetOptions(&options, controls))
            {
                ResetState(hwnd, controls, package);
                EnableWindow(controls[ID_START].hwnd, FALSE);
                return 0;
            }
            
            // Implement their options...
            SendMessage(hwnd, WM_IMPLEMENT_OPTIONS, 0, 0);
            
            return 0;

        // Save options and implement...
        case WM_SAVE_OPTIONS:

            // Save macros and user options. Check for error...
            if(!SaveOptions(&options, controls))
            {
                ResetState(hwnd, controls, package);
                return 0;
            }

            // Implement their options...
            SendMessage(hwnd, WM_IMPLEMENT_OPTIONS, 0, 0);

            return 0;

        // Implement their options...
        case WM_IMPLEMENT_OPTIONS:

            // Imlement their options and check for error...
            if(!ImplementOptions(&options, controls))
            {
                ResetState(hwnd, controls, package);
                return 0;
            }
            return 0;

        // Window invalidated, repaint...
        case WM_PAINT:
            
            // Get device contexts...
            hdc             = BeginPaint(hwnd, &ps);
            hdcPictureBox   = BeginPaint(controls[ID_PICTURE_BOX].hwnd, &ps);
            hdcMemoryImage  = CreateCompatibleDC(hdcPictureBox);
            
            // Put logo in memory device context...
            SelectObject(hdcMemoryImage, hLogo);
            
            // Draw it on the picture box...
            BitBlt(hdcPictureBox, 0, 0, 130, 70, hdcMemoryImage, 0, 0, SRCCOPY);

            // Delete the device contexts...
            DeleteDC(hdc);
            DeleteDC(hdcPictureBox);
            DeleteDC(hdcMemoryImage);
            
            // End paints...
            EndPaint(hwnd, &ps);
            EndPaint(controls[ID_PICTURE_BOX].hwnd, &ps);
            return 0;

        // Update interface if necessary...
        case WM_TIMER:

            // Check if any item is checked...
            if(nDownloadMode != MODE_DOWNLOADING)
            {
                for(i = 1; i <= nNumPackage; i++)
                {                
                    nDownloadMode = MODE_READY;
    
                    // At least one item is checked, set download mode and stop iterating...
                    if(package[i].bChecked)
                    {
                        nDownloadMode = MODE_DOWNLOAD_SET;
                        break;
                    }
                }
            }
            
            // Change start button caption to reflect this...
            switch(nDownloadMode)
            {
                case MODE_READY:
                    SetWindowText(controls[ID_START].hwnd, "Start");
                    break;
                    
                case MODE_DOWNLOAD_SET:
                    SetWindowText(controls[ID_START].hwnd, "Download");
                    break;
                    
                case MODE_DOWNLOADING:
                    SetWindowText(controls[ID_START].hwnd, "Busy");
                    break;
            }

            // How many items are listed this moment? (1, 2, or 3)...
            (nNumPackage > 0) ? nNumDisplayed = nNumPackage - nTopPackage + 1 : nNumDisplayed = 0;
            
                // Get mouse coordinates...
                GetCursorPos(&ptMouse);
            
                // Check if they are the same as last time. If so, don't paint...
                if((ptMouse.x == ptMouseOld.x) && (ptMouse.y == ptMouse.y))
                    return 0;
                
                // Get mouse coordinates again...
                GetCursorPos(&ptMouseOld);
            
                // Convert to client coordinates...
                ScreenToClient(hwnd, &ptMouse);

            // Mouse over top list item...               230, 21, 172, 10
            if(package[nTopPackage].bDownloadedPreview && (nDownloadMode != MODE_DOWNLOADING) && 
               (230 <= ptMouse.x && ptMouse.x <= 402) && (21 <= ptMouse.y && ptMouse.y <= 31) && (nNumDisplayed > 0))
            {
                // Change description caption...
                SetWindowText(controls[ID_DESCRIPTION].hwnd, package[nTopPackage].szDescription);
                
                // Change preview pic, if there is one...
                if(strcmp(package[nTopPackage].szPreviewPic, "NA") != 0)
                {
                    // Delete old pic...
                    DeleteObject(hLogo);

                    // Load their pic...
                    hLogo = (HBITMAP)LoadImage(hInstance, package[nTopPackage].szPreviewPic, IMAGE_BITMAP,
                                0, 0, LR_CREATEDIBSECTION | LR_LOADFROMFILE);
                                
                    if(!hLogo)
                    {
                        sprintf(szBuffer, "Error: Can't preview %s...", package[nTopPackage].szPreviewPic);
                        StatusOut(szBuffer, controls[ID_STATUS_WINDOW].hwnd);
                    }
                                
                    // Invalidate...
                    InvalidateRect(hwnd, &rcLogo, TRUE);
                }

                return 0;
            }
            
            // Mouse over middle list item...            230, 41, 172, 10
            else if(package[nTopPackage + 1].bDownloadedPreview && (nDownloadMode != MODE_DOWNLOADING) && 
                   (230 <= ptMouse.x && ptMouse.x <= 402) && (41 <= ptMouse.y && ptMouse.y <= 51) && (nNumDisplayed > 1))
            {
                // Change description caption...
                SetWindowText(controls[ID_DESCRIPTION].hwnd, package[nTopPackage + 1].szDescription);
                
                // Change preview pic, if there is one...
                if(strcmp(package[nTopPackage + 1].szPreviewPic, "NA") != 0)
                {
                    // Delete old pic...
                    DeleteObject(hLogo);

                    // Load their pic...
                    hLogo = (HBITMAP)LoadImage(hInstance, package[nTopPackage + 1].szPreviewPic, IMAGE_BITMAP,
                                0, 0, LR_CREATEDIBSECTION | LR_LOADFROMFILE);
                    
                        // Can't load...
                        if(!hLogo)
                        {
                            sprintf(szBuffer, "Error: Can't preview %s...", package[nTopPackage + 1].szPreviewPic);
                            StatusOut(szBuffer, controls[ID_STATUS_WINDOW].hwnd);
                        }
                                
                    // Invalidate...
                    InvalidateRect(hwnd, &rcLogo, TRUE);
                }

                return 0;
            }
            
            // Mouse over bottom list item...            230, 61, 172, 10
            else if(package[nTopPackage + 2].bDownloadedPreview && (nDownloadMode != MODE_DOWNLOADING) && 
                    (230 <= ptMouse.x && ptMouse.x <= 402) && (61 <= ptMouse.y && ptMouse.y <= 71) && (nNumDisplayed > 2))
            {
                // Change description caption...
                SetWindowText(controls[ID_DESCRIPTION].hwnd, package[nTopPackage + 2].szDescription);
                
                // Change preview pic, if there is one...
                if(strcmp(package[nTopPackage + 2].szPreviewPic, "NA") != 0)
                {
                    // Delete old pic...
                    DeleteObject(hLogo);

                    // Load their pic...
                    hLogo = (HBITMAP)LoadImage(hInstance, package[nTopPackage + 2].szPreviewPic, IMAGE_BITMAP,
                                0, 0, LR_CREATEDIBSECTION | LR_LOADFROMFILE);
                                
                    if(!hLogo)
                    {
                        sprintf(szBuffer, "Error: Can't preview %s...", package[nTopPackage + 2].szPreviewPic);
                        StatusOut(szBuffer, controls[ID_STATUS_WINDOW].hwnd);
                    }
                                
                    // Invalidate...
                    InvalidateRect(hwnd, &rcLogo, TRUE);
                }

                return 0;
            }
            // Mouse not over any of the above...
            else
            {
                // Delete old pic...
                DeleteObject(hLogo);

                // Get handle to our logo and check for error...
                hLogo = LoadBitmap(hInstance, MAKEINTRESOURCE(ID_LOGOBOX));
                GetObject(hLogo, sizeof(BITMAP), &strBitmap);
                
                // Invalidate...
                
                    // We have already drawn default logo, no need to draw again...
                    UpdateWindow(hwnd);
                        // InvalidateRect(hwnd, &rcLogo, TRUE);

                return 0;
            }

        // Scroll bar clicked...
        case WM_VSCROLL:
            switch(LOWORD(wParam))
            {
                // Bottom arrow hit...
                case SB_PAGEDOWN:
                case SB_LINEDOWN:
                    if(nTopPackage >= 1 && nTopPackage < nNumPackage)
                        nTopPackage++;
                    DisplayUpdates(hwnd, package, nNumPackage, nTopPackage);
                    
                    SetScrollPos(controls[ID_SCROLL_BAR].hwnd, SB_CTL,
                                 GetScrollPos(controls[ID_SCROLL_BAR].hwnd, SB_CTL) + 1,
                                 TRUE);
                    return 0;
                    
                // Top arrow hit...
                case SB_PAGEUP:
                case SB_LINEUP:
                    if(nTopPackage > 1)
                        nTopPackage--;
                    DisplayUpdates(hwnd, package, nNumPackage, nTopPackage);
                    
                    SetScrollPos(controls[ID_SCROLL_BAR].hwnd, SB_CTL,
                                 GetScrollPos(controls[ID_SCROLL_BAR].hwnd, SB_CTL) - 1,
                                 TRUE);
                    return 0;
                    
                // Dragging the thumb...
                case SB_THUMBTRACK:
                    DisplayUpdates(hwnd, package, nNumPackage, HIWORD(wParam) + 1);
                    
                    SetScrollPos(controls[ID_SCROLL_BAR].hwnd, SB_CTL,
                                 HIWORD(wParam),
                                 TRUE);
                    nTopPackage = HIWORD(wParam) + 1;
                    return 0;
            }
            break;
        
        // User activated something in the system menu...
        case WM_SYSCOMMAND:
            switch(LOWORD(wParam))
            {
                // Options menu item clicked...
                case IDM_SYS_OPTIONS:

                    // Open dialog box...
                    DialogBoxParam(hInstance, "OptionsBox", hwnd, OptionsDialogProc, (LPARAM) &options);

                    return 0;

                // About menu item clicked...
                case IDM_SYS_ABOUT:
                    DialogBox(hInstance, "AboutBox", hwnd, AboutDialogProc);
                    return 0;
            }
            break;
    
        // Time to quit...
        case WM_DESTROY:
            DeleteObject(hFont);
            DeleteObject(hLogo);
            DeleteObject(hBrush);
            KillTimer(hwnd, ID_TIMER);
            PostQuitMessage(0);
            return 0;
    }
    return DefWindowProc(hwnd, msg, wParam, lParam);
}
