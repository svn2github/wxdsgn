#include "prototypes.h"

    // Global variables...
    extern vRoachGlobals g_globals;

// Returns a character pointer to a file's contents...
char *getFileContents(char *pszFileName, BOOL bFormatFile)
{
    // Variables...
    static  char *pszFile           = NULL;
            FILE *hFile             = NULL;
            char szBuffer[1024]     = {0};
            char szTemp[1024]       = {0};
            
    // Open file...
    hFile = fopen(pszFileName, "r");

        // Can't open...
        if(!hFile)
        {
            // Format error message...
            sprintf(szTemp, "User's %s...\r\n"
                            VROACH_TOP_FILE "\r\n"
                            "Not detected...\r\n"
                            VROACH_BOTTOM_FILE "\r\n\r\n",
                    pszFileName);
        
            // Allocate...
            pszFile = (char *) malloc(strlen(szTemp));

                // Allocated...
                if(pszFile)
                {
                    strcpy(pszFile, szTemp);
                    return pszFile;
                }

                // Can't allocate...
                else
                    return NULL;
        }
        

    // Allocate storage...
    pszFile = (char *) malloc(getFileSize(pszFileName) + 1024);
    
        // Error...
        if(!pszFile)
            return NULL;
            
    // Init...
    if(bFormatFile)
    {
        sprintf(pszFile, "User's %s...\r\n"
                         VROACH_TOP_FILE "\r\n",
                pszFileName);
    }
    else
    {
        strcpy(pszFile, "\x0");
    }

    // Parse...
    while(fgets(szBuffer, 1024, hFile))
    {
        strcat(pszFile, szBuffer);
    }
    
    // Format end of file in memory...
    if(bFormatFile)
    {
        strcat(pszFile, "\r\n" VROACH_BOTTOM_FILE "\r\n\r\n");
    }
    
    // Close stream and return file...
    fclose(hFile);
    return pszFile;
}

// Returns a character pointer to a file's contents...
char *getFileContentsAppDirectory(char *pszFileName, BOOL bFormatFile)
{
    // Variables...
    static  char    *pszFile                    = NULL;
            FILE    *hFile                      = NULL;
            char    szBuffer[1024]              = {0};
            char    szTemp[1024]                = {0};
            char    szCurrentDirectory[4096]    = {0};
            char    *pszLocalAppDataDirectory   = NULL;
            
    // Remember current directory...
    GetCurrentDirectory(sizeof(szCurrentDirectory), szCurrentDirectory);

    // Get local app data directory...
    pszLocalAppDataDirectory = GetLocalAppDataDirectory();
    
        // Error...
        if(!pszLocalAppDataDirectory)
            return NULL;
    
    // Get into local app data directory...
    SetCurrentDirectory(pszLocalAppDataDirectory);

    // Open file...
    hFile = fopen(pszFileName, "r");

        // Can't open...
        if(!hFile)
        {
            // Format error message...
            sprintf(szTemp, "User's %s...\r\n"
                            VROACH_TOP_FILE "\r\n"
                            "Not detected...\r\n"
                            VROACH_BOTTOM_FILE "\r\n\r\n",
                    pszFileName);
        
            // Allocate...
            pszFile = (char *) malloc(strlen(szTemp));

                // Allocated...
                if(pszFile)
                {
                    strcpy(pszFile, szTemp);
                    SetCurrentDirectory(szCurrentDirectory);
                    return pszFile;
                }

                // Can't allocate...
                else
                {
                    SetCurrentDirectory(szCurrentDirectory);
                    return NULL;
                }
        }
        

    // Allocate storage...
    pszFile = (char *) malloc(getFileSize(pszFileName) + 1024);
    
        // Error...
        if(!pszFile)
        {
            SetCurrentDirectory(szCurrentDirectory);
            return NULL;
        }
            
    // Init...
    if(bFormatFile)
    {
        sprintf(pszFile, "User's %s...\r\n"
                         VROACH_TOP_FILE "\r\n",
                pszFileName);
    }
    else
    {
        strcpy(pszFile, "\x0");
    }

    // Parse...
    while(fgets(szBuffer, 1024, hFile))
    {
        strcat(pszFile, szBuffer);
    }
    
    // Format end of file in memory...
    if(bFormatFile)
    {
        strcat(pszFile, "\r\n" VROACH_BOTTOM_FILE "\r\n\r\n");
    }
    
    // Close stream and return file...
    fclose(hFile);
    SetCurrentDirectory(szCurrentDirectory);
    return pszFile;
}

// Returns the file size of pszFileName in bytes. -1 on error...
int getFileSize(char *pszFileName)
{
    // Variables...
    int nFileSize = 0;
    FILE *someFile;

    // Open the file...
    someFile = fopen(pszFileName, "r");

    // Check for error...
    if(!someFile)
        return -1;

    // Get file size...
    fseek(someFile, 0, SEEK_END);
    nFileSize = ftell(someFile);

    // Close stream...
    fclose(someFile);

    // Return file size...
    return nFileSize;
}

// Returns the file size of pszFileName in bytes in the application data directory. -1 on error...
int getFileSizeAppDirectory(char *pszFileName)
{
    // Variables...
    int     nFileSize                   = 0;
    FILE    *someFile                   = NULL;
    char    *pszLocalAppDataDirectory   = NULL;
    char    szCurrentDirectory[4096]    = {0};

    // Remember current directory...
    GetCurrentDirectory(sizeof(szCurrentDirectory), szCurrentDirectory);

    // Get local app data directory...
    pszLocalAppDataDirectory = GetLocalAppDataDirectory();
    
        // Error...
        if(!pszLocalAppDataDirectory)
            return -1;
    
    // Get into local app data directory...
    SetCurrentDirectory(pszLocalAppDataDirectory);

    // Open the file...
    someFile = fopen(pszFileName, "r");

    // Check for error...
    if(!someFile)
    {
        SetCurrentDirectory(szCurrentDirectory);
        return -1;
    }

    // Get file size...
    fseek(someFile, 0, SEEK_END);
    nFileSize = ftell(someFile);

    // Close stream...
    fclose(someFile);

    // Return file size...
    SetCurrentDirectory(szCurrentDirectory);
    return nFileSize;
}

// Get user's local app data directory...
char *GetLocalAppDataDirectory(void)
{
    // Variables...
    LPITEMIDLIST    pidl                = NULL;
    LPMALLOC        pShellMalloc        = NULL;
    static char     szDirectory[1024]   = {0};

    // Get address of shell malloc function...
    if(NOERROR == SHGetMalloc(&pShellMalloc))
    {
        // My headers didn't have CSIDL_LOCAL_APPDATA so I did it manually incase u are wondering
        //  what 0x001c is...
        if(NOERROR == SHGetSpecialFolderLocation(NULL, 0x001c, &pidl))
        {
            // Convert to path name, check for error...
            if(!SHGetPathFromIDList(pidl, szDirectory))
                return NULL;

            // Cleanup...
            pShellMalloc->Free(pidl);
        }
        
        // Cleanup...
        pShellMalloc->Release();

    }

    // Failed to get address of shell malloc function...
    else
        return NULL;
        
    // Return string...
    return szDirectory;
}

// Return true if windows NT class OS...
BOOL IsNT(void)
{
    // Variables...
    OSVERSIONINFO   os;

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

// Set text in status window...
BOOL StatusOut(char *pszString)
{
    // Passed null...
    if(!pszString)
    {
        SetDlgItemText(g_globals.hDlg, IDD_STATUS, "Error: pszString");
        return FALSE;
    }

    // Set status window text...
    return SetDlgItemText(g_globals.hDlg, IDD_STATUS, pszString);
}

// Count how many times pszKey occured in pszList...
int strocc(char *pszList, char *pszKey)
{
    char *pszOccurence = NULL;
    int  nOccurences = 0;
    int  nLength = 0;
    
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
