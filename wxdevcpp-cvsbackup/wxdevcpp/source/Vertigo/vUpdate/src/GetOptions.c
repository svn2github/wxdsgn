/*
  Name: GetOptions() (function)
  Author: Kip Warner
  Description: Get options from devcpp.cfg...
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

// Extract options and macros from devcpp.cfg...
int GetOptions(vUpdateOptions *options, controlData *controls)
{
    // Variables...
    char    szBuffer[256]       = {0};
    char    *pszString          = NULL;
    char    szTemp[256]         = {0};
    char    szDebug[1024]       = {0};
    char    szOldPath[1024]     = {0};

    // Set root directory so we can read cfg file...
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
                                     "directory while opening your options.", "Error", 
                                     MB_OK | MB_ICONERROR);
                    ExitProcess(1);
                }

            SetCurrentDirectory(pszString);
        }
        // 9x or compatible...
        else
            SetCurrentDirectory(g_szExeDirectory);

    // Error while getting field in devcpp.cfg, turn on debug mode by default...
    if(INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "AdvancedDebugLog", szTemp))
        options->bAdvancedDebugLog = FALSE;

        // Got debug field...
        else
        {
            options->bAdvancedDebugLog = strtobool(szTemp);
            g_bDebugMode = options->bAdvancedDebugLog ? TRUE : FALSE;
        }

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

    // Extract macros...

        if(INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "$ROOT",      options->szRootPath))
        {
            StatusOut("Error: Your devcpp.cfg file is missing", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            the $ROOT field in its", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            [VUPDATE] section...", controls[ID_STATUS_WINDOW].hwnd);
            SetCurrentDirectory(szOldPath);
            return FALSE;
        }

        if(INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "$BIN",       options->szBinPath))
        {
            StatusOut("Error: Your devcpp.cfg file is missing", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            the $BIN field in its", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            [VUPDATE] section...", controls[ID_STATUS_WINDOW].hwnd);
            SetCurrentDirectory(szOldPath);
            return FALSE;
        }

        if(INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "$HELP",      options->szHelpPath))
        {
            StatusOut("Error: Your devcpp.cfg file is missing", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            the $HELP field in its", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            [VUPDATE] section...", controls[ID_STATUS_WINDOW].hwnd);
            SetCurrentDirectory(szOldPath);
            return FALSE;
        }

        if(INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "$ICONS",     options->szIconsPath))
        {
            StatusOut("Error: Your devcpp.cfg file is missing", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            the $ICONS field in its", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            [VUPDATE] section...", controls[ID_STATUS_WINDOW].hwnd);
            SetCurrentDirectory(szOldPath);
            return FALSE;
        }

        if(INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "$INCLUDE",   options->szIncludePath))
        {
            StatusOut("Error: Your devcpp.cfg file is missing", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            the $INCLUDE field in its", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            [VUPDATE] section...", controls[ID_STATUS_WINDOW].hwnd);
            SetCurrentDirectory(szOldPath);
            return FALSE;
        }
    
        if(INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "$LIB",       options->szLibPath))
        {
            StatusOut("Error: Your devcpp.cfg file is missing", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            the $LIB field in its", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            [VUPDATE] section...", controls[ID_STATUS_WINDOW].hwnd);
            SetCurrentDirectory(szOldPath);
            return FALSE;
        }
    
        if(INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "$LANG",      options->szLangPath))
        {
            StatusOut("Error: Your devcpp.cfg file is missing", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            the $LANG field in its", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            [VUPDATE] section...", controls[ID_STATUS_WINDOW].hwnd);
            SetCurrentDirectory(szOldPath);
            return FALSE;
        }
    
        if(INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "$TEMPLATES", options->szTemplatesPath))
        {
            StatusOut("Error: Your devcpp.cfg file is missing", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            the $TEMPLATES field in its", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            [VUPDATE] section...", controls[ID_STATUS_WINDOW].hwnd);
            SetCurrentDirectory(szOldPath);
            return FALSE;
        }
    
        if(INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "$THEMES",    options->szThemesPath))
        {
            StatusOut("Error: Your devcpp.cfg file is missing", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            the $THEMES field in its", controls[ID_STATUS_WINDOW].hwnd);
            StatusOut("            [VUPDATE] section...", controls[ID_STATUS_WINDOW].hwnd);
            SetCurrentDirectory(szOldPath);
            return FALSE;
        }

        // Get temp...
        strcpy(options->szTempPath, options->szRootPath);
        strcat(options->szTempPath, "Temp");

        // Output to debug log...
        sprintf(szDebug, "According to your devcpp.cfg, vUpdate thinks these are your macros...\n"
                         "$ROOT: \"%s\"\n$BIN: \"%s\"\n$HELP: \"%s\"\n$ICONS: \"%s\"\n"
                         "$INCLUDE: \"%s\"\n$LIB: \"%s\"\n$LANG: \"%s\"\n$TEMPLATES: \"%s\"\n"
                         "$THEMES: \"%s\"", options->szRootPath, options->szBinPath,
                         options->szHelpPath, options->szIconsPath, options->szIncludePath,
                         options->szLibPath, options->szLangPath, options->szTemplatesPath,
                         options->szThemesPath);
        DebugOut(szDebug);
        
    // Get options...

        // Interface options...

            // Progress bar...
            (INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "InterfaceSmoothProgressBar", szTemp)) ?
                options->bInterfaceSmoothProgressBar = TRUE : options->bInterfaceSmoothProgressBar = strtobool(szTemp);
                                    // Default value --^                               Value in file --^

            // Dev theme...
            (INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "InterfaceDevTheme", szTemp)) ?
                options->bInterfaceDevTheme = TRUE : options->bInterfaceDevTheme = strtobool(szTemp);

            // Preview...
            (INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "InterfacePreviews", szTemp)) ?
                options->bInterfacePreviews = TRUE : options->bInterfacePreviews = strtobool(szTemp);

        // List options...

            // List packages...
            (INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "ListPackages", szTemp)) ?
                options->bListPackages = TRUE : options->bListPackages = strtobool(szTemp);

            // List patches...
            (INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "ListPatches", szTemp)) ?
                options->bListPatches = TRUE : options->bListPatches = strtobool(szTemp);
                
            // List languages...
            (INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "ListLanguages", szTemp)) ?
                options->bListLanguages = TRUE : options->bListLanguages = strtobool(szTemp);
                
            // Selected language...
            if(INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "ListSelectedLanguage", options->szListSelectedLanguage))
                strcpy(options->szListSelectedLanguage, "All");

            // List help...
            (INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "ListHelp", szTemp)) ?
                options->bListHelp = TRUE : options->bListHelp = strtobool(szTemp);

            // List other...
            (INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "ListOther", szTemp)) ?
                options->bListOther = TRUE : options->bListOther = strtobool(szTemp);

        // Advanced options...

            // Debug log...
            /* First thing that is scanned up at the top */

            // Bandwidth throttle...
            (INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "AdvancedBandwidthThrottle", szTemp)) ?
                options->fAdvancedBandwidthThrottle = 100.0 : options->fAdvancedBandwidthThrottle = atof(szTemp);

            // Use proxy?...
            (INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "AdvancedUseProxy", szTemp)) ?
                options->bAdvancedUseProxy = FALSE : options->bAdvancedUseProxy = strtobool(szTemp);

            // Proxy server name...
            if(INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "AdvancedProxyServer", options->szAdvancedProxyServer))
                strcpy(options->szAdvancedProxyServer, "proxyserver");

            // Proxy port number...
            if(INI_ALL_GOOD != ini_GetField("devcpp.cfg", "VUPDATE", "AdvancedProxyPort", szTemp))
                options->nAdvancedProxyPort = 8010;
            else
                options->nAdvancedProxyPort = atoi(szTemp);

        // Output to debug log...
        sprintf(szDebug, "According to your devcpp.cfg, vUpdate thinks these are your options...\n"
                         "bInterfaceSmoothProgressBar: \"%i\"\n"
                         "bInterfaceDevTheme: \"%i\"\n"
                         "bInterfacePreviews: \"%i\"\n"
                         "bListPackages: \"%i\"\n"
                         "bListPatches: \"%i\"\n"
                         "bListLanguages: \"%i\"\n"
                         "bListHelp: \"%i\"\n"
                         "bListOther: \"%i\"\n"
                         "bAdvancedDebugLog: \"%i\"\n"
                         "fBandwidthThrottle: \"%f\"\n"
                         "bAdvancedUseProxy: \"%i\"\n"
                         "szAdvancedProxyServer: \"%s\"\n"
                         "nAdvancedProxyPort: \"%i\"\n", 
                         
                         options->bInterfaceSmoothProgressBar,
                         options->bInterfaceDevTheme, 
                         options->bInterfacePreviews,
                         options->bListPackages, 
                         options->bListPatches, 
                         options->bListLanguages,
                         options->bListHelp, 
                         options->bListOther, 
                         options->bAdvancedDebugLog, 
                         options->fAdvancedBandwidthThrottle,
                         options->bAdvancedUseProxy,
                         options->szAdvancedProxyServer,
                         options->nAdvancedProxyPort);
        DebugOut(szDebug);

    // All good....
    SetCurrentDirectory(szOldPath);
    return TRUE;
}
