/*
  Name: SaveOptions() (function)
  Author: Kip Warner
  Description: Save options...
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

// Save options and macros into devcpp.cfg...
int SaveOptions(vUpdateOptions *options, controlData *controls)
{
    // Variables...
    char    szBuffer[256]   = {0};
    char    *pszString      = NULL;
    char    szTemp[256]     = {0};
    char    szOldPath[1024] = {0};

    // Set directory so we can read cfg file...
    DebugOut("Preparing to save macros and options......");
    GetCurrentDirectory(sizeof(szOldPath) / sizeof(char), szOldPath);

        // If we are on NT compatible system, settings are in local data directory...
        if(IsNT())
        {
            // Query...
            pszString = GetLocalAppDataDirectory();
            
                // Error...
                if(!pszString)
                {
                    MessageBox(NULL, "An error occured while getting your local application\n"
                                     "directory while saving your options.", "Error", 
                                     MB_OK | MB_ICONERROR);
                    ExitProcess(1);
                }

            SetCurrentDirectory(pszString);
        }
        // 9x or compatible...
        else
            SetCurrentDirectory(g_szExeDirectory);

    // Check to make sure I can open devcpp.cfg...
    if(INI_ERROR_CANNOT_OPEN == ini_GetField("devcpp.cfg", "VUPDATE", "n/a", szBuffer))
    {
        MessageBox(NULL, "Error: devcpp.cfg not found. Please check to make sure\n"
                         "this file is located in your root Dev-C++ directory on\n"
                         "Winblows 9x class systems or in your application data\n"
                         "directory on Winblows NT class systems.\n\n"
                         
                         "Example: C:\\Docume~1\\User\\Local Settings\\Application Data",
                   "vUpdate", MB_OK | MB_ICONERROR);
        PostQuitMessage(0);
        SetCurrentDirectory(szOldPath);
        return FALSE;
    }
    
    // I opened it, but our key isn't there...
    if(INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "INI_FIND_KEY", szBuffer))
    {
        StatusOut("Error: Your devcpp.cfg file is missing", controls[ID_STATUS_WINDOW].hwnd);
        StatusOut("            the [VUPDATE] section....", controls[ID_STATUS_WINDOW].hwnd);
        SetCurrentDirectory(szOldPath);
        return FALSE;
    }

    // Save options...
    DebugOut("Saving your options...");
    
        // Interface options...

            // Progress bar...
            ini_SetField("devcpp.cfg", "VUPDATE", "InterfaceSmoothProgressBar", itoa(options->bInterfaceSmoothProgressBar, szTemp, 10));

            // Dev theme...
            ini_SetField("devcpp.cfg", "VUPDATE", "InterfaceDevTheme", itoa(options->bInterfaceDevTheme, szTemp, 10));

            // Preview...
            ini_SetField("devcpp.cfg", "VUPDATE", "InterfacePreviews", itoa(options->bInterfacePreviews, szTemp, 10));

        // List options...

            // List packages...
            ini_SetField("devcpp.cfg", "VUPDATE", "ListPackages", itoa(options->bListPackages, szTemp, 10));

            // List patches...
            ini_SetField("devcpp.cfg", "VUPDATE", "ListPatches", itoa(options->bListPatches, szTemp, 10));
            
            // List languages...
            ini_SetField("devcpp.cfg", "VUPDATE", "ListLanguages", itoa(options->bListLanguages, szTemp, 10));
            
            // List selected language...
            ini_SetField("devcpp.cfg", "VUPDATE", "ListSelectedLanguage", options->szListSelectedLanguage);

            // List help...
            ini_SetField("devcpp.cfg", "VUPDATE", "ListHelp", itoa(options->bListHelp, szTemp, 10));

            // List other...
            ini_SetField("devcpp.cfg", "VUPDATE", "ListOther", itoa(options->bListOther, szTemp, 10));

        // Advanced options...

            // Debug log...
            ini_SetField("devcpp.cfg", "VUPDATE", "AdvancedDebugLog", itoa(options->bAdvancedDebugLog, szTemp, 10));

            // Bandwidth throttle...
            sprintf(szTemp, "%f", options->fAdvancedBandwidthThrottle);
            ini_SetField("devcpp.cfg", "VUPDATE", "AdvancedBandwidthThrottle", szTemp);

            // Use proxy?...
            ini_SetField("devcpp.cfg", "VUPDATE", "AdvancedUseProxy", itoa(options->bAdvancedUseProxy, szTemp, 10));

            // Proxy server name...
            ini_SetField("devcpp.cfg", "VUPDATE", "AdvancedProxyServer", options->szAdvancedProxyServer);

            // Proxy port number...
            itoa(options->nAdvancedProxyPort, szTemp, 10);
            ini_SetField("devcpp.cfg", "VUPDATE", "AdvancedProxyPort", szTemp);

        DebugOut("Saved options...");

    // All good....
    SetCurrentDirectory(szOldPath);
    return TRUE;
}
