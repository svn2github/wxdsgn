/*
  Name: ResetState (function)
  Author: Kip Warner
  Description: Resets the state of vUpdate to how it was when you started it up...
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

void ResetState(HWND hwnd, controlData *controls, Package *package)
{
    // Package groupbox title...
    SetWindowText(controls[ID_PACKAGES_GROUPBOX].hwnd, "Packages: ");

    // Hide scroll bar...
    ShowWindow(controls[ID_SCROLL_BAR].hwnd, SW_HIDE);

    // Announcements window...
    SetWindowText(controls[ID_ANNOUNCEMENTS].hwnd, "");

    // Description window...
    SetWindowText(controls[ID_DESCRIPTION].hwnd, "");

    // Clear updates list...
    DisplayUpdates(hwnd, package, 0, 0);

    // Start button....
    SetWindowText(controls[ID_START].hwnd, "Start");
    EnableWindow(controls[ID_START].hwnd, TRUE);

    // Repaint status window...
    UpdateWindow(controls[ID_STATUS_WINDOW].hwnd);

    // Reset focus to exit button...
    SetFocus(controls[ID_START].hwnd);
    
    // Update all windows...
    UpdateWindow(hwnd);
}
