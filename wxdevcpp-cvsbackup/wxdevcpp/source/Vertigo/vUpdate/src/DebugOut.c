/*
   Name: DebugOut (function)
   Author: Kip Warner
   Description: Output stuff to debug log...
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

void DebugOut(char *pszString)
{
    // Variables...
    char    szOldPath[1024];
    FILE    *hDebugLog          = NULL;

    // Is debug mode enabled? If not, return...
    if(!g_bDebugMode)
        return;

    // Get current path...
    GetCurrentDirectory(sizeof(szOldPath), szOldPath);
    
    // Get into root path...
    SetCurrentDirectory(g_szExeDirectory);
    
    // Output to debug log...
    hDebugLog = fopen("vUpdate Debug Log.txt", "a");
    
        // Can't open. Who cares, return...
        if(!hDebugLog)
        {
            // Reset path, close stream, and return...
            fclose(hDebugLog);
            SetCurrentDirectory(szOldPath);
            return;
        }

    // Output to log...
    //fprintf(hDebugLog, "# %s%s\ng_szExeDirectory: %s\ng_szTempDirectory: %s\nszOldPath: %s\n\n",
    //        getTimeDate(), pszString, g_szExeDirectory, g_szTempDirectory, szOldPath);

    fprintf(hDebugLog, "# v%s %s%s\n\n", VUPDATE_VERSION_CHAR, getTimeDate(), pszString);

    // Reset directory, close stream, and return...
    fclose(hDebugLog);
    SetCurrentDirectory(szOldPath);
}
