/* 
   Name: main (module)
   Author: Kip Warner
   Description: Main module. Execution begins in here.
   Date Started: 19/06/02 15:00
   Copyright: Yes
*/

#include "prototypes.h"

    // Directory where vUpdate is...
    char    g_szExeDirectory[256];
    
    // Directory of temp folder...
    char    g_szTempDirectory[256];
    
    // Guess...
    char    g_szAppName[32] = "vUpdate - v";
    
    // Button window proc procedure...
    WNDPROC OldProc;
    
    // Debug mode...
    BOOL    g_bDebugMode    = TRUE;

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR pszCmdLine, int nCmdShow)
{
    // Variables...
    WNDCLASS            wc;
    MSG                 msg;
    HWND                hwnd;
    HANDLE              hHandle;
    
    // Set app name...
    strcat(g_szAppName, VUPDATE_VERSION_CHAR);

    // Are we already running?...
        
        // Create mutex, if you can...
        hHandle = CreateMutex(NULL, TRUE, "vUpdate");
    
        // Can't create, cause it already exists. Quit...
        if(GetLastError() == ERROR_ALREADY_EXISTS)
        {
            MessageBox(NULL, "vUpdate is already open. Please close the\n"
                             "other instance before opening another.",
                             g_szAppName, MB_OK | MB_ICONERROR);
            exit(1);
        }
    
    // Delete debug log if it already exists...
    DeleteFile("vUpdate Debug Log.txt");

    // Delete swap.exe...
    while(!GoodDeleteFile("swap.exe"))
    {
        
    }

    // Check for common control dll (replace with ex with gcc 3.1)...
    InitCommonControls();

    // Get exe directory...
    GetCurrentDirectory(sizeof(g_szExeDirectory) / sizeof(char) , g_szExeDirectory);

    // Check for temporary directory, create if necessary...
    CreateDirectory("Temp", NULL);

    // Set Temp directory for all downloads so we don't make a mess...
    if(!SetCurrentDirectory("Temp"))
    {
        MessageBox(NULL, "Sorry, but I couldn't get into my own directory. (\\Temp).", "Error",
                   MB_OK | MB_ICONINFORMATION);
        exit(1);
    }
    
    // Set temp directory path...
    GetCurrentDirectory(sizeof(g_szTempDirectory) / sizeof(char), g_szTempDirectory);
    
    // Prep our window structure...
    wc.style            = CS_HREDRAW | CS_VREDRAW;
    wc.lpfnWndProc      = WndProc;
    wc.cbClsExtra       = 0;
    wc.cbWndExtra       = 0;
    wc.hInstance        = hInstance;
    wc.hIcon            = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_ICON));
    wc.hCursor          = LoadCursor(hInstance, IDC_ARROW);
    wc.hbrBackground    = (HBRUSH) GetStockObject(LTGRAY_BRUSH);
    wc.lpszMenuName     = NULL;
    wc.lpszClassName    = g_szAppName;
    
    // Register window class, and check for error...
    if(!RegisterClass(&wc))
    {
        MessageBox(NULL, "Sorry, but I couldn't register myself with your system...",
                   "Error", MB_OK | MB_ICONERROR);
        exit(1);
    }
    
    // Create window...
    hwnd = CreateWindowEx(WS_EX_CONTEXTHELP,
                          g_szAppName, g_szAppName,
                          WS_OVERLAPPED | WS_SYSMENU,
                          (GetSystemMetrics(SM_CXSCREEN)-VUPDATE_WIDTH)/2, (GetSystemMetrics(SM_CYSCREEN)-VUPDATE_HEIGHT)/2, VUPDATE_WIDTH, VUPDATE_HEIGHT,
                          NULL, NULL, hInstance, NULL);
                        
    // Check for error...
    if(!hwnd)
    {
        MessageBox(NULL, "Sorry, but I couldn't create myself. You may be using"
                   " an older operating system.", "Error", 
                   MB_OK | MB_ICONERROR);
    }
                        
    // Display it...
    ShowWindow(hwnd, nCmdShow);
    UpdateWindow(hwnd);
    
    // Begin message processing...
    while(GetMessage(&msg, NULL, 0, 0))
    {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
    
    // Reset current directory to exe path so we can cleanup...
    FlushBuffer();

    // Quit...
    return msg.wParam;
}
