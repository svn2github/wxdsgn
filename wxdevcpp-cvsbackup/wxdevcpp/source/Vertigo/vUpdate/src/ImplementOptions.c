/*
   Name: ImplementOptions() (function)
   Author: Kip Warner
   Description: Implement options that are in the options structure...
   Copyright: Yes
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

// Implement options that are in the options structure...
int ImplementOptions(vUpdateOptions *options, controlData *controls)
{
    // Variables...
    HWND        hParent         = NULL;
    HINSTANCE   hInstance       = 0;
    
    // Get main window handle...
    hParent = GetParent(controls[ID_START].hwnd);

    // Get module instance...
    hInstance = (HINSTANCE) GetWindowLong(hParent, GWL_HINSTANCE);
    
    if(!hInstance)
        MessageBox(NULL, "GetWindowLong() petered...", "ERROR", MB_OK);

    // Implement options...
    
        // Interface options...
    
            // Smooth progress bar...
            if(options->bInterfaceSmoothProgressBar)
            {
                DestroyWindow(controls[ID_PROGRESS_BAR].hwnd);
                controls[ID_PROGRESS_BAR].hwnd = CreateWindowEx(controls[ID_PROGRESS_BAR].dwExStyle,
                                                                controls[ID_PROGRESS_BAR].lpClassName,
                                                                controls[ID_PROGRESS_BAR].lpWindowName,
                                                                WS_CHILD | WS_VISIBLE | PBS_SMOOTH,
                                                                controls[ID_PROGRESS_BAR].x,
                                                                controls[ID_PROGRESS_BAR].y, 
                                                                controls[ID_PROGRESS_BAR].nWidth,
                                                                controls[ID_PROGRESS_BAR].nHeight, 
                                                                hParent,
                                                                (HMENU) controls[ID_PROGRESS_BAR].hMenu,
                                                                hInstance,
                                                                NULL);
                UpdateWindow(hParent);
            }
            
            // Segmented progress bar...
            else
            {
                DestroyWindow(controls[ID_PROGRESS_BAR].hwnd);
                controls[ID_PROGRESS_BAR].hwnd = CreateWindowEx(controls[ID_PROGRESS_BAR].dwExStyle,
                                                                controls[ID_PROGRESS_BAR].lpClassName,
                                                                controls[ID_PROGRESS_BAR].lpWindowName,
                                                                WS_CHILD | WS_VISIBLE,
                                                                controls[ID_PROGRESS_BAR].x,
                                                                controls[ID_PROGRESS_BAR].y, 
                                                                controls[ID_PROGRESS_BAR].nWidth,
                                                                controls[ID_PROGRESS_BAR].nHeight, 
                                                                hParent,
                                                                (HMENU) controls[ID_PROGRESS_BAR].hMenu,
                                                                hInstance,
                                                                NULL);
                UpdateWindow(hParent);
            }
            
        // Advanced options...
        if(options->bAdvancedDebugLog)
            g_bDebugMode = TRUE;
        else
            g_bDebugMode = FALSE;

    return TRUE;
}
