/* 
   Name: DisplayUpdates
   Author: Kip Warner
   Description: Code for displaying the updates in a list...
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

void DisplayUpdates(HWND hwnd, Package package[], int nNumPackage, int nTopPackage)
{
    // Variables...
    HINSTANCE   hInstance               = NULL;
    WPARAM      wParam                  = 0;
    LPARAM      lParam                  = 0;
    HFONT       hFont                   = NULL;
    static      HWND    hwndItemOne     = NULL;
    static      HWND    hwndItemTwo     = NULL;
    static      HWND    hwndItemThree   = NULL;
    
    // Get module handle...
    hInstance = (HINSTANCE) GetWindowLong(hwnd, GWL_HINSTANCE);
    
    // Delete old ones, if any, to prep for drawing new ones...
    DestroyWindow(hwndItemOne);
    DestroyWindow(hwndItemTwo);
    DestroyWindow(hwndItemThree);
    
    // Check if they scrolled past the bottom of the list...
    if(nTopPackage > nNumPackage)
        nTopPackage = nNumPackage;

    // Delete old font...
    DeleteObject(hFont);

    // Create font...
    hFont = CreateFont(13, 0, 0, 0, FW_NORMAL, 0, 0, 0,
                       DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
                       DEFAULT_QUALITY, DEFAULT_PITCH, "Arial");

        // Petered out...
        if(!hFont) 
        {
            MessageBox(hwnd, "There was a problem while rendering the font. "
                             "Please ensure that your system carries the Lucida Console font.",
                             "Error", MB_OK | MB_ICONERROR);
            PostQuitMessage(0);
        }
        
        // Initialize font...
        wParam = (WPARAM) hFont;
        lParam = MAKELPARAM(TRUE, 0);

    
    // Create the first item...
    if(nNumPackage)
    {
        hwndItemOne = CreateWindow("button", package[nTopPackage].szTitle,
                                   WS_CHILD | WS_VISIBLE | BS_AUTOCHECKBOX,
                                   230, 21, 172, 10, hwnd, (HMENU) ID_TOP_LIST_ITEM,
                                   hInstance, NULL);

            // Set its font...
            SendMessage(hwndItemOne, WM_SETFONT, wParam, lParam);
            
            // Set its check state...
            package[nTopPackage].bChecked ? SendMessage(hwndItemOne, BM_SETCHECK, BST_CHECKED, 0)
                                          : SendMessage(hwndItemOne, BM_SETCHECK, BST_UNCHECKED, 0);
    }
                               
    // Create the second item...
    if(nTopPackage < nNumPackage)
    {
        hwndItemTwo = CreateWindow("button", package[nTopPackage + 1].szTitle,
                                   WS_CHILD | WS_VISIBLE | BS_AUTOCHECKBOX,
                                   230, 21 + 20, 172, 10, hwnd, (HMENU) ID_MIDDLE_LIST_ITEM,
                                   hInstance, NULL);
                               
            // Set its font...
            SendMessage(hwndItemTwo, WM_SETFONT, wParam, lParam);
            
            // Set its check state...
            package[nTopPackage + 1].bChecked ? SendMessage(hwndItemTwo, BM_SETCHECK, BST_CHECKED, 0)
                                              : SendMessage(hwndItemTwo, BM_SETCHECK, BST_UNCHECKED, 0);
    }
    
    // Create the third item...
    if(nTopPackage + 1 < nNumPackage)
    {
        hwndItemThree = CreateWindow("button", package[nTopPackage + 2].szTitle,
                                     WS_CHILD | WS_VISIBLE | BS_AUTOCHECKBOX,
                                     230, 21 + 40, 172, 10, hwnd, (HMENU) ID_BOTTOM_LIST_ITEM,
                                     hInstance, NULL);
    
            // Set its font...
            SendMessage(hwndItemThree, WM_SETFONT, wParam, lParam);
            
            // Set its check state...
            package[nTopPackage + 2].bChecked ? SendMessage(hwndItemThree, BM_SETCHECK, BST_CHECKED, 0)
                                              : SendMessage(hwndItemThree, BM_SETCHECK, BST_UNCHECKED, 0);
    }
}
