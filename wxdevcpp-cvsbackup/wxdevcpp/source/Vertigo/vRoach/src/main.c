/* 
   Name: main (module)
   Author: Kip Warner
   Description: Main module. Execution begins in here.
   Copyright: Yes
*/

#include "prototypes.h"

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR pszCmdLine, int nCmdShow)
{
    // Variables...
    WNDCLASS            wc;
    MSG                 msg;
    HWND                hwnd;
    HANDLE              hHandle;
    
    // Are we already running?...
        
        // Create mutex, if you can...
        hHandle = CreateMutex(NULL, TRUE, "vRoach");
    
        // Can't create, cause it already exists. Quit...
        if(GetLastError() == ERROR_ALREADY_EXISTS)
        {
            MessageBox(NULL, "vRoach is already open. Please close the\n"
                             "other instance before opening another.",
                             VROACH_NAME, MB_OK | MB_ICONERROR);
            exit(1);
        }
    
    DialogBox(hInstance, "MainBox", GetDesktopWindow(), MainDialogProc);

    // Quit...
    return msg.wParam;
}
