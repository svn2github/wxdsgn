/* 
   Name: DownloadUpdatesThread (thread function)
   Author: Kip Warner
   Description: Network code...
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

// Download and install all checked updates...
DWORD WINAPI DownloadUpdatesThread(DownloadUpdatesData *updatesData)
{
    // Variables...
    char            szBuffer[128];
    int             nStatus             = FALSE;
    int             i                   = 0;
    static  HWND    hStatus             = updatesData->controls[ID_STATUS_WINDOW].hwnd;
    int             nNumChecked         = 0;
    char            szURL[1024]         = {0};
    char            szPath[4096]        = {0};
    char            szExtension[32]     = {0};
    char            *pszString          = NULL;
    HINSTANCE       hPackman            = NULL;
    char            szDebugString[1024];

    // Disable start button cause we are busy...
    EnableWindow(updatesData->controls[ID_START].hwnd, FALSE);
    SetWindowText(updatesData->controls[ID_START].hwnd, "Busy");
    
    // Set hour glass cursor...
    SetCursor(LoadCursor(NULL, IDC_WAIT));

    // Find out how many we have to download...
    for(i = 1; i <= updatesData->nNumPackage; i++)
        if(updatesData->package[i].bChecked)
            nNumChecked++;

    // Initialize download state of all packages...
    for(i = 1; i <= updatesData->nNumPackage; i++)
        updatesData->package[i].bDownloaded = FALSE;

    // Go through the packages and download the ones that are checked...
    for(i = 1; i <= updatesData->nNumPackage; i++)
    {
        // This package is marked for download, download it...
        if(updatesData->package[i].bChecked)
        {
            // Tell user whats going on...
            sprintf(szBuffer, "Downloading %s...", updatesData->package[i].szTitle);
            StatusOut(szBuffer, hStatus);

            // Construct url to file on server...
            sprintf(szURL, "%s%s", updatesData->settings->szFileServer, updatesData->package[i].szFileName);
            
            // Construct path to file on hard drive...
            sprintf(szPath, "%s%s", InsertMacro(updatesData->package[i].szDownloadTo, updatesData->options), updatesData->package[i].szFileName);
            
            // Create the destination directory, incase it dosen't exist...
            KickAssCreateDirectory(InsertMacro(updatesData->package[i].szDownloadTo, updatesData->options));
            
            // Get the file extension...
            pszString = strrchr(updatesData->package[i].szFileName, '.');
            if(pszString)
                strcpy(szExtension, strupp(pszString));
            else
                strcpy(szExtension, "NA");

            // Physicaly download the file...
            nStatus = DownloadFile(szURL, szPath, updatesData->controls, updatesData->options);
            
            // Mark download as successful...
            updatesData->package[i].bDownloaded = TRUE;

            // Unless the download failed...
            if(nStatus != DOWNLOAD_OK)
            {
                sprintf(szBuffer, "Error: Can't download %s...", updatesData->package[i].szFileName);
                StatusOut(szBuffer, hStatus);
                
                // Mark download as failure...
                updatesData->package[i].bDownloaded = FALSE;
            }

            // Downloaded successfully...
            if(nStatus == DOWNLOAD_OK)
            {
                // Tell user what's going on...
                StatusOut("Remembering this install...", hStatus);
                
                // Log install and check for error...
                if(!LogInstallation(updatesData->package[i], hStatus))
                    StatusOut("Error: Can't log install entry...", hStatus);
            }
        }
    }

    // We are done downloading and installing all the packages, display message box for ones that need it...
    for(i = 1; i <= updatesData->nNumPackage; i++)
        if(strcmp(updatesData->package[i].szMessageBox, "NA") && updatesData->package[i].bDownloaded)
            MessageBox(updatesData->hwnd, updatesData->package[i].szMessageBox,
                       updatesData->package[i].szTitle, MB_OK | MB_ICONINFORMATION);

    // We are done downloading and installing all the packages, execute ones that are flagged...
    StatusOut("Done...", hStatus);
    for(i = 1; i <= updatesData->nNumPackage; i++)
    {
        if(updatesData->package[i].bExecute && updatesData->package[i].bChecked && updatesData->package[i].bDownloaded)
        {
            // Construct path to file on hard drive...
            sprintf(szPath, "%s%s", InsertMacro(updatesData->package[i].szDownloadTo, updatesData->options), updatesData->package[i].szFileName);

            // Tell user whats going on...
            sprintf(szBuffer, "Executing %s...", updatesData->package[i].szFileName);
            StatusOut(szBuffer, hStatus);

            // Need some kind of wait for process to complete or something here...

            // Execute package...
            ShellExecute(NULL, "open", szPath, NULL, NULL, SW_SHOW);
            StatusOut("Done...", hStatus);
        }
    }
    
    // Check for bad downloads...
    nStatus = FALSE;
    for(i = 1; i <= updatesData->nNumPackage; i++)
    {
        if(updatesData->package[i].bChecked && !updatesData->package[i].bDownloaded)
            nStatus++;
    }

    // Tell user what's going on...
    if(nStatus == 0)
        StatusOut("Done all jobs...", hStatus);
    
    else
    {
        nStatus == 1 ? sprintf(szBuffer, "Done, with one error. Check above...")
                     : sprintf(szBuffer, "Done, with %i errors. Check above...", nStatus);
        
        StatusOut(szBuffer, hStatus);
    }
    
    // Reset cursor...
    SetCursor(LoadCursor(NULL, IDC_ARROW));

    // Re-enable start button...
    EnableWindow(updatesData->controls[ID_START].hwnd, TRUE);

    // Uncheck all items...
    for(i = 1; i <= updatesData->nNumPackage; i++)
        updatesData->package[i].bChecked = FALSE;
        
    // We're done everything we can, tell main thread...
    SendMessage(updatesData->hwnd, WM_FINISHED_ALL_DOWNLOADS, 0, 0);
    return 0;
}
