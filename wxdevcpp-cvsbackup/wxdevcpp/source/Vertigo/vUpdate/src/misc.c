/*
   Name: Misc (module)
   Author: Kip Warner
   Description: Miscellanious functions, too lazy to build another header..
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

// Scans pszString for '\' + 'n' and replaces with \r\n...
void fixNewLine(char *pszString)
{
    // Variables...
    unsigned int i  = 0;;
    
    for(i = 0; i < strlen(pszString)-1; i++)
    {
        if(pszString[i] == '\\' && pszString[i + 1] == 'n')
        {
            pszString[i] = '\r';
            pszString[i+1] = '\n';
        }
    }
}

// Put a '/' character on the end of a url if there isn't one....
void fixURL(char *pszURL)
{
    if(pszURL[strlen(pszURL)-1] != '/')
    {
        strcat(pszURL, "/");
    }
}

// Extract host name from a url...
BOOL GetHostName(char *pszServerName, char *pszURL)
{
    // Variables...
    char    szTemp[1024]    = {0};
    char   *pszStart        = NULL;
    char   *pszEnd          = NULL;

    // Get start of server name...
    strcpy(szTemp, pszURL);
    pszStart = strstr(szTemp, "//");

        // No protocol segment, must begin with server name then...
        if(!pszStart)
            pszStart = pszURL;

        // Seek past protocol...
        else
        {
            // Cut off protocol part...
            pszStart = pszStart + strlen("//");        
        }
    
    // Find end of server name...
    pszEnd = strstr(pszStart, "/");

        // There is more after server name, we're not interested though...
        if(pszEnd)
        {
            // Kill remainder...
            *pszEnd = '\x0';

            // Copy in server name...
            strcpy(pszServerName, pszStart);

            // Done...
            return TRUE;
        }

    // Copy in server name...
    strcpy(pszServerName, pszStart);

    // Done...
    return TRUE;
}

// Get user's local app data directory...
char *GetLocalAppDataDirectory(void)
{
    // Variables...
    static char     szDirectory[1024]   = {0};

    // My headers didn't have CSIDL_LOCAL_APPDATA so I did it manually incase u are wondering
    //  what 0x001c is...
    if (NOERROR != SHGetFolderPath(0, 0x001c, 0, 0, szDirectory))
    {
      if (NOERROR != SHGetFolderPath(0, 0x001a, 0, 0, szDirectory))
        return NULL;
    }
        
    // Return string...
    return szDirectory;
}

// Return formatted time and date...
char *getTimeDate()
{
    // Declare time data type...
    time_t DateTime;
    
    // Get calendar time...
    DateTime = time(0);

    // Return converted calendar time...
    return ctime(&DateTime);
}

// Returns true if pszFile has been deleted or is already gone...
BOOL GoodDeleteFile(char *pszFileName)
{
    // Variables...
    DWORD   dwWord  = 0;

    // Verify...
    if(!pszFileName)
        return FALSE;

    DeleteFile(pszFileName);
    
    dwWord = GetLastError();
    
    // Can't find file, thats fine...
    if(dwWord == ERROR_FILE_NOT_FOUND)
        return TRUE;

    // Failed to delete...
    else
        return FALSE;
}

// Return true if windows NT class OS...
BOOL IsNT(void)
{
    // Variables...
    OSVERSIONINFO   os;
    
    DebugOut("Winblows NT detected...");
    
    // Init...
    os.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);

    // Query and check for error...
    if(!GetVersionEx(&os))
    {
        MessageBox(NULL, "An error occured while querying your operating system on its version.",
                   "Error", MB_OK | MB_ICONERROR);
        return FALSE;
    }
    
    // Is NT?...
    if(os.dwPlatformId == VER_PLATFORM_WIN32_NT)
        return TRUE;
    
    // Not NT, probably 9x...
    else
        return FALSE;
}

// Creates a given directory recursively. Will create parent directories as needed...
BOOL KickAssCreateDirectory(char *pszPath)
{
    char    *pszToken                   = NULL;
    char    szPath[256];
    char    szTokenizedPath[32][256];
    int     i                           = 0;
    int     nNumFolders                 = 0;
    char    szSequentialPath[256]       = "\x0";
    BOOL    bStatus                     = FALSE;
    
    // Get the path they want...
    strcpy(szPath, pszPath);
    
    // Append an '\' to the end so strtok dosen't barf...
    strcat(szPath, "\\");
    
    // Tokenize first part...
    strcpy(szTokenizedPath[0], strtok(szPath, "\\"));
    
    // Tokenize the rest using same handle...
    for(nNumFolders = 1; ;nNumFolders++)
    {
        pszToken = strtok(NULL, "\\");
        
        if(!pszToken)
            break;
            
        strcpy(szTokenizedPath[nNumFolders], pszToken);
    }
    
    // Create each directory recursively...
    for(i = 0; i < nNumFolders; i++)
    {
        if(i > 0)
        {
            strcat(szSequentialPath, "\\");
        }
        strcat(szSequentialPath, szTokenizedPath[i]);
        bStatus = CreateDirectory(szSequentialPath, NULL);
    }
    
    // Return status of operation...
    return bStatus;
}

// Dump string out to status buffer...
void StatusOut(char *pszMessage, HWND hwndStatusWindow)
{
    // Variables...
    char    szBuffer[1024];
        
    // Format and write string for log...
    sprintf(szBuffer, "Status: %s", pszMessage);
    DebugOut(szBuffer);
    
    // Is this an error message?...

        // Yes, put '* ' infront...
        if(strstr(pszMessage, "Error: "))
        {
            sprintf(szBuffer, "* %s", pszMessage);
            MessageBeep(MB_ICONERROR);
        }
        
        // Just spaces...
        else if(strncmp(pszMessage, "   ", 3) == 0)
            strcpy(szBuffer, pszMessage);

        // No, '] ' infront...
        else
            sprintf(szBuffer, "] %s", pszMessage);
    
    // Output the message...
    SendMessage(hwndStatusWindow, LB_ADDSTRING, (WPARAM) -1, (LPARAM) szBuffer);
    
    // Scroll to the bottom...
    SendMessage(hwndStatusWindow, WM_VSCROLL, SB_BOTTOM, 0);

    // Repaint window...
    SendMessage(hwndStatusWindow, WM_PAINT, 0, 0);
}

// Count how many times pszKey occured in pszList...
int strocc(char *pszList, char *pszKey)
{
    char *pszOccurence = NULL;
    int  nOccurences = 0;
    
    // Error control...
    if(strlen(pszKey) > strlen(pszList))
        return -1;

    // Search for the first occurence...
    pszOccurence = strstr(pszList, pszKey);
        
    // None found?...
    if(pszOccurence == NULL)
    {
        nOccurences = 0;
        return(nOccurences);
    }
            
    // Found one, count it...
    nOccurences++;

    for(;;)
    {
        // Have we reached the end of the array?...
        if(pszOccurence + 1 == '\x0')
            return nOccurences;
        
        // Search for another occurence...
        pszOccurence = strstr(pszOccurence + 1, pszKey);
        
        // No more found?...
        if(pszOccurence == NULL)
            return nOccurences;

        // Found one, count it...
        nOccurences++;
    }
}

// If pszString is TRUE, true, or, t, return TRUE...
BOOL strtobool(char *pszString)
{
    // Null pointer...
    if(pszString == NULL)
        return FALSE;
        
    // Empty string?...
    if(strlen(pszString) == 0)
        return FALSE;

    // True...
    if((toupper(pszString[0]) == 'T') || (pszString[0] == '1'))
        return TRUE;
        
    // False...
    else
        return FALSE;
}

// Returns an all uppercase copy of pszString...
char *strupp(char *pszString)
{
    // Variables...
    static  char                szNewString[256]    = {0};
            unsigned   int      i                   = 0;
    
    // Make copy...
    strcpy(szNewString, pszString);
    
    // Scan and replace...
    for(i = 0; i < strlen(pszString); i++)
    {
        // This character is a letter...
        if(isalpha(pszString[i]))
            szNewString[i] = toupper(pszString[i]);
    }
    
    // Return new string...
    return szNewString;
}
