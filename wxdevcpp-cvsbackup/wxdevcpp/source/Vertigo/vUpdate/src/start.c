/* 
   Name: Start (function)
   Author: Kip Warner
   Description: This is where execution begins after start button pressed...
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

int StartButton(HWND hwnd, controlData controls[], ScriptSettings *settings, Package package[], vUpdateOptions *options)
{
    // Variables...
    static  char            szURL[256]              = VUPDATE_SCRIPT_URL;
    static  int             i                       = 0;
    static  char            szBuffer[512]           = {0};
    static  char            szPackageID[512]        = {0};
    static  char            szTemp[512]             = {0};
    static  int             nStatus                 = 0;
    static  int             nNumPackage             = 0;   
    static  int             nPackageOffset          = 0;
    static  HWND            hStatus                 = controls[ID_STATUS_WINDOW].hwnd;
    static  SelfUpdateData  selfUpdate;
    static  HINSTANCE       hInstance               = (HINSTANCE) GetWindowLong(hStatus, GWL_HINSTANCE);
            HANDLE          hResource               = 0;
            void           *pRawData                = NULL;
            FILE           *hFile                   = NULL;
            DWORD           dwWord                  = 0;

    // Disable start button cause we are busy...
    EnableWindow(controls[ID_START].hwnd, FALSE);

    // Change our button title...
    SetWindowText(controls[ID_START].hwnd, "Busy");

    // Set back directory to temp...
    SetCurrentDirectory(g_szTempDirectory);

    // Clear the status buffer...
    SendMessage(controls[ID_STATUS_WINDOW].hwnd, LB_RESETCONTENT, 0, 0);
    
    // Check for newer version of vUpdate...

        // Tell client whats going on...
        StatusOut("Checking for newer vUpdate...", hStatus);
        
        // Download self update script...
        if(DOWNLOAD_OK == DownloadFile(VUPDATE_SELF_UPDATE_URL, "selfupdate.ini", controls, options))
        {
            // Get latest version...
            ini_GetField("selfupdate.ini", "VUPDATE", "LatestVersion", selfUpdate.szLatestVersion);
            
            // There is a newer version...
            if((double) atof(VUPDATE_VERSION_CHAR) < (double) atof(selfUpdate.szLatestVersion))
            {
                StatusOut("Newer vUpdate available...", hStatus);
                
                // Get comments...
                ini_GetField("selfupdate.ini", "VUPDATE", "Comments", selfUpdate.szComments);
                
                // Get URL...
                ini_GetField("selfupdate.ini", "VUPDATE", "URL", selfUpdate.szURL);

                // Display...
                nStatus = DialogBoxParam(hInstance, "SelfUpdate", GetParent(hStatus), SelfUpdateDialogProc, (LPARAM) &selfUpdate);

                    // User chose to upgrade...
                    if(nStatus == TRUE)
                    {
                        StatusOut("Downloading self upgrade...", hStatus);
                        SetCurrentDirectory(g_szExeDirectory);
                        
                        // Download upgrade...
                        if(DOWNLOAD_OK == DownloadFile(selfUpdate.szURL, "vUpdate.tmp", controls, options))
                        {
                            StatusOut("Done...", hStatus);
                            ResetState(hwnd, controls, package);

                            // Write swap.exe to disk...

                                // Find it...
                                hResource = FindResource(NULL, MAKEINTRESOURCE(IDE_SWAP), "EXE");

                                    // Error...
                                    if(!hResource)
                                    {
                                        // Error...
                                        dwWord = GetLastError();
                                        sprintf(szBuffer, "Can't find swap.exe, code %u...", dwWord);
                                        StatusOut(szBuffer, hStatus);
    
                                        // Re-enable start button cause we are done...
                                        EnableWindow(controls[ID_START].hwnd, TRUE);
    
                                        // Exit...
                                        ExitThread(0);
                                    }
                                
                                // Calculate size...
                                dwWord = SizeofResource(GetModuleHandle(NULL), (HRSRC) hResource);
                                
                                    // Error...
                                    if(!dwWord)
                                    {
                                        // Error...
                                        StatusOut("Can't calculate swap.exe size...", hStatus);
    
                                        // Re-enable start button cause we are done...
                                        EnableWindow(controls[ID_START].hwnd, TRUE);
    
                                        // Exit...
                                        ExitThread(0);
                                    }
    
                                // Load it...
                                hResource = LoadResource(GetModuleHandle(NULL), (HRSRC) hResource);
                                
                                    // Error...
                                    if(!hResource)
                                    {
                                        // Error...
                                        StatusOut("Failed to load swap.exe...", hStatus);
                                        
                                        // Re-enable start button cause we are done...
                                        EnableWindow(controls[ID_START].hwnd, TRUE);
                                        
                                        // Exit...
                                        ExitThread(0);
                                    }
                                
                                // Lock it...
                                pRawData = LockResource(hResource);
                                
                                    // Error...
                                    if(!pRawData)
                                    {
                                        // Error...
                                        StatusOut("Failed to lock swap.exe...", hStatus);
                                        
                                        // Re-enable start button cause we are done...
                                        EnableWindow(controls[ID_START].hwnd, TRUE);
                                        
                                        // Exit...
                                        ExitThread(0);
                                    }
                                
                                // Write it...
                                hFile = fopen("swap.exe", "wb");
                                
                                    // Error...
                                    if(!hFile)
                                    {
                                        // Error...
                                        StatusOut("Failed to create swap.exe...", hStatus);
                                        
                                        // Re-enable start button cause we are done...
                                        EnableWindow(controls[ID_START].hwnd, TRUE);
                                        
                                        // Exit...
                                        ExitThread(0);
                                    }
                                    
                                    // Write...
                                    fwrite(pRawData, 1, dwWord, hFile);
                                    
                                    // Close stream...
                                    fclose(hFile);
    
                            // Execute swap.exe...
                            if(ShellExecute(GetDesktopWindow(), NULL, "swap.exe", 
                                            "vUpdate.exe vUpdate.tmp",
                                            szBuffer, SW_SHOW) <= (HINSTANCE) 32)
                            {
                                // Error...
                                StatusOut("Error launching swap.exe...", hStatus);
                                
                                // Re-enable start button cause we are done...
                                EnableWindow(controls[ID_START].hwnd, TRUE);
                                
                                // Exit...
                                ExitThread(0);
                            }

                            // Cleanup and quit...
                            FlushBuffer();
                            ExitProcess(0);
                        }
                        
                        // Download failed...
                        else
                        {
                            StatusOut("Failed...", hStatus);
                            MessageBox(NULL, "An error occured while downloading the latest\n"
                                             "vUpdate. The update server could be down.\n",
                                       g_szAppName,
                                       MB_OK | MB_DEFBUTTON1 | MB_ICONINFORMATION);
                            ResetState(hwnd, controls, package);
                            ExitProcess(1);
                        }
                    }
                    
                    // User chose not to upgrade, quit to avoid unpredictable behaviour in update.ini script behavior...
                    else
                    {
                        ExitProcess(0);
                        return 0;
                    }
            }
        }

        // Can't get selfupdate.ini...
        else
            StatusOut("Error: Can't get selfupdate.ini...", hStatus);

    // Tell client whats going on...
    StatusOut("Fetching update list...", hStatus);

    // Download update list...
    nStatus = DownloadFile(szURL, "update.ini", controls, options);

    // Couldn't get the list...
    if(nStatus != DOWNLOAD_OK)
    {
        StatusOut("Error: Server temporarily down?...", hStatus);
        ResetState(hwnd, controls, package);
        return 0;
    }

    // Got the list, tell the user...
    StatusOut("Got it...", hStatus);

    // Before we do anything else, check to make sure script is not corrupt...
    if(INI_ALL_GOOD != ini_GetField("update.ini", "END", "INI_FIND_KEY", szBuffer))
    {
        StatusOut("Error: Corrupt script (no [END] key)...", hStatus);
        ResetState(hwnd, controls, package);
        return 0;
    }

    // We have the list, parse...

        // Tell user whats going on...
        StatusOut("Thinking...", hStatus);

        // Grab their settings...

            // Pick random file server from list (this s a mandatory field)...

                // How many mirrors are listed? Scan for up to 64...
                for(i = 1; i <= 64; i++)
                {
                    // Format field...
                    sprintf(szBuffer, "Mirror%i", i);

                    // No more mirrors, break...
                    if(INI_ERROR_FIELD_NOT_FOUND == ini_GetField("update.ini", "SETTINGS", szBuffer, szTemp))
                    {
                        i--;
                        break;
                    }
                }

                    // There are no mirrors...
                    if(!i)
                    {
                        StatusOut("Error: \"Mirror1\" not specified...", hStatus);
                        ResetState(hwnd, controls, package);
                        return 0;
                    }

                // We have 'i' mirrors, pick a random one...
                i = rand() % i + 1;
                sprintf(szBuffer, "Mirror%i", i);
                
                // Extract...
                if(INI_ALL_GOOD != ini_GetField("update.ini", "SETTINGS", szBuffer, settings->szFileServer)) 
                {
                    StatusOut("Error: File I/O...", hStatus);
                    ResetState(hwnd, controls, package);
                    return 0;
                }
                
                // Tell user what's going on....
                sprintf(szBuffer, "Using mirror %i...", i);
                StatusOut(szBuffer, hStatus);
                StatusOut("Thinking...", hStatus);
            
                // URL is invalid, we only know how to deal with http so far...
                if(strncmp(settings->szFileServer, "http://", 7) != 0)
                {
                    StatusOut("Error: Invalid file server...", hStatus);
                    ResetState(hwnd, controls, package);
                    return 0;
                }

                // URL is valid, tack on a '/' at the end if neccessary...
                fixURL(settings->szFileServer);

            // Get announcements...

                // Extract...
                if(INI_ALL_GOOD != ini_GetField("update.ini", "SETTINGS", "Announcements",
                                                settings->szAnnouncements))
                {
                    // None, use default...
                    strcpy(settings->szAnnouncements, "There are no announcements...");
                }
                // Scan for new line code...
                fixNewLine(settings->szAnnouncements);

        // Start grabbing package tags (they start at 1, not 0)...
        for(nNumPackage = 1, nPackageOffset = 0; nNumPackage < 65; nNumPackage++)
        {
            // Initialize our data...
            package[nNumPackage].bChecked   = 0;
            
            // Format key and find one...
            sprintf(szPackageID, "PACKAGE%i", nNumPackage + nPackageOffset);
            nStatus = ini_GetField("update.ini", szPackageID, "INI_FIND_KEY", szTemp);

            // We found one, parse and increment package count...
            if(nStatus == INI_ALL_GOOD)
            {

                // Get "Title" field data...
                if(INI_ALL_GOOD != ini_GetField("update.ini", szPackageID, "Title", package[nNumPackage].szTitle))
                {
                    sprintf(szBuffer, "Error: Tag %i: No \"Title\" field...", nNumPackage);
                    StatusOut(szBuffer, hStatus);
                    ResetState(hwnd, controls, package);
                    return 0;
                }
                
                // Get "EntryCode" field...
                if(INI_ALL_GOOD != ini_GetField("update.ini", szPackageID, "EntryCode", package[nNumPackage].szEntryCode))
                {
                    // Not found...
                    sprintf(szBuffer, "Error: Tag %i: No \"EntryCode\" field...", nNumPackage);
                    StatusOut(szBuffer, hStatus);
                    ResetState(hwnd, controls, package);
                    return 0;
                }

                // Get "Version" field data...
                if(INI_ALL_GOOD != ini_GetField("update.ini", szPackageID, "Version", package[nNumPackage].szVersion))
                {
                    sprintf(szBuffer, "Error: Tag %i: No \"Version\" field...", nNumPackage);
                    StatusOut(szBuffer, hStatus);
                    ResetState(hwnd, controls, package);
                    return 0;
                }
                
                    // This package is already installed, skip it...
                    if(IsAlreadyInstalled(package[nNumPackage], hStatus) == PACKAGE_INSTALLED)
                    {
                        sprintf(szBuffer, "Skipping %s...", package[nNumPackage].szEntryCode);
                        StatusOut(szBuffer, hStatus);
                        nPackageOffset++;
                        nNumPackage--;
                        continue;
                    }

                // Get "FileName" field data...
                if(INI_ALL_GOOD != ini_GetField("update.ini", szPackageID, "FileName", package[nNumPackage].szFileName))
                {
                    sprintf(szBuffer, "Error: Tag %i: No \"FileName\" field...", nNumPackage);
                    StatusOut(szBuffer, hStatus);
                    ResetState(hwnd, controls, package);
                    return 0;
                }
                
                // Get "DownloadTo" field data...
                if(INI_ALL_GOOD != ini_GetField("update.ini", szPackageID, "DownloadTo", package[nNumPackage].szDownloadTo))
                {
                    sprintf(szBuffer, "Error: Tag %i: No \"DownloadTo\" field...", nNumPackage);
                    StatusOut(szBuffer, hStatus);
                    ResetState(hwnd, controls, package);
                    return 0;
                }
                
                // Get optional fields. Fill in undeclared ones with default values...
                    
                    // File size...
                    if(INI_ALL_GOOD != ini_GetField("update.ini", szPackageID, "FileSize", package[nNumPackage].szFileSize))
                        strcpy(package[nNumPackage].szFileSize, "?");

                    // Type...
                    if(INI_ALL_GOOD != ini_GetField("update.ini", szPackageID, "Type", package[nNumPackage].szType))
                        strcpy(package[nNumPackage].szType, "Other");
                        
                        // Did the user choose not to view this type?...

                            // Make uppercase...
                            strcpy(szTemp, strupp(package[nNumPackage].szType));

                            // PACKAGE...
                            if((strcmp(szTemp, "PACKAGE") == 0) && !options->bListPackages)
                            {
                                nPackageOffset++;
                                nNumPackage--;
                                continue;
                            }

                            // PATCH...
                            if((strcmp(szTemp, "PATCH") == 0) && !options->bListPatches)
                            {
                                nPackageOffset++;
                                nNumPackage--;
                                continue;
                            }

                            // LANG...
                            if((strcmp(szTemp, "LANGUAGE") == 0) && !options->bListLanguages)
                            {
                                nPackageOffset++;
                                nNumPackage--;
                                continue;
                            }
                            
                            // Is this a selected language and list all is not selected?...
                            if((strcmp(szTemp, "LANGUAGE") == 0) && 
                               (strcmp(options->szListSelectedLanguage, "All")) &&
                               options->bListLanguages)
                            {
                                // Not selected language, skip...
                                if(!strstr(package[nNumPackage].szTitle, options->szListSelectedLanguage))
                                {
                                    nPackageOffset++;
                                    nNumPackage--;
                                    continue;
                                }
                            }

                            // HELP...
                            if((strcmp(szTemp, "HELP") == 0) && 
                               !options->bListHelp)
                            {
                                nPackageOffset++;
                                nNumPackage--;
                                continue;
                            }

                            // OTHER...
                            if((strcmp(szTemp, "OTHER") == 0) && !options->bListOther)
                            {
                                nPackageOffset++;
                                nNumPackage--;
                                continue;
                            }

                    // Description...
                    if(INI_ALL_GOOD != ini_GetField("update.ini", szPackageID, "Description", szTemp))
                        sprintf(package[nNumPackage].szDescription, "Version: %s\r\nSize: %s\r\nType: %s\r\n\r\nNo description available...", package[nNumPackage].szVersion, package[nNumPackage].szFileSize, package[nNumPackage].szType);
                    else
                        sprintf(package[nNumPackage].szDescription, "Version: %s\r\nSize: %s\r\nType: %s\r\n\r\n%s", package[nNumPackage].szVersion, package[nNumPackage].szFileSize, package[nNumPackage].szType, szTemp);

                        // Scan for new line code...
                        fixNewLine(package[nNumPackage].szDescription);

                    // MessageBox...
                    if(INI_ALL_GOOD != ini_GetField("update.ini", szPackageID, "MessageBox", package[nNumPackage].szMessageBox))
                        strcpy(package[nNumPackage].szMessageBox, "NA");
                    else
                        fixNewLine(package[nNumPackage].szMessageBox);

                    // Preview pic...
                    if(INI_ALL_GOOD != ini_GetField("update.ini", szPackageID, "PreviewPic", package[nNumPackage].szPreviewPic))
                        strcpy(package[nNumPackage].szPreviewPic, "NA");

                    // Execute flag...
                    if(INI_ALL_GOOD != ini_GetField("update.ini", szPackageID, "Execute", szTemp))
                        package[nNumPackage].bExecute = FALSE;
                    else
                    {
                        if(strstr(szTemp, "1") || strstr(szTemp, "TRUE") || strstr(szTemp, "true"))
                            package[nNumPackage].bExecute = TRUE;
                        else
                            package[nNumPackage].bExecute = FALSE;
                    }
                    
                    // Init DownloadedPreview to false...
                    package[nNumPackage].bDownloadedPreview = FALSE;
            }

            // No more packages...
            else
            {
                // Subtract one because it was incremented at beginning of loop...
                nNumPackage--;
                break;
            }
        }
        
        // Preview pics enabled...
        if(options->bInterfacePreviews)
        {

            // Tell user what we're up to...
            sprintf(szTemp, "Fetching previews...");
            StatusOut(szTemp, hStatus);
            SetWindowText(controls[ID_ANNOUNCEMENTS].hwnd, "");
            
            // Physicaly download them...
            for(i = 1; i <= nNumPackage; i++)
            {
                // There is no preview pic for this package, skip...
                if(strcmp(package[i].szPreviewPic, "NA") == 0)
                {
                    // Mark as downloaded so mouse overs don't get confused...
                    package[i].bDownloadedPreview = TRUE;
                    continue;
                }

                // Build url...
                sprintf(szBuffer, "%s%s", settings->szFileServer, package[i].szPreviewPic);
            
                // Download the pic...
                if(DOWNLOAD_OK != DownloadFile(szBuffer, package[i].szPreviewPic, controls, options))
                {
                    sprintf(szTemp, "Error: Tag %i: Can't get \"%s\"...", i, package[i].szPreviewPic);
                    StatusOut(szTemp, hStatus);
                    package[i].bDownloadedPreview = FALSE;
                }
                else
                    package[i].bDownloadedPreview = TRUE;
            }
            StatusOut("Done...", hStatus);
        }
        
        // Preview pics not enabled, skip...
        else
        {
            for(i = 1; i <= nNumPackage; i++)
            {
                package[i].bDownloadedPreview = TRUE;
                strcpy(package[i].szPreviewPic, "NA");
            }
        }
        
        // Tell user we're done and return the number of packages...
        nNumPackage ? StatusOut("Ready when you are...", hStatus) : StatusOut("No files available...", hStatus);
        return nNumPackage;
}
