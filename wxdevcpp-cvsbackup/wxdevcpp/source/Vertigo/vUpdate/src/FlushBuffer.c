/* 
   Name: flushBuffer (function)
   Author: Kip Warner
   Description: Removes any junk files / directories vUpdate may have created.
                Will also backup the last update file so the power charlies can
                check it out...
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

// Replace this with api calls. system() ones are lame...
void FlushBuffer()
{
    // Variables...
    char            szBufferOne[256];
    char            szBufferTwo[256];
    char            szCommand[256];
    int             nStatus = 0;
    SHFILEOPSTRUCTA  shFileOperation         = {0};
    
    DebugOut("Flushing buffer...");
    
    // Set temp directory and remove all the files in it...
    sprintf(g_szTempDirectory, "%s\\Temp", g_szExeDirectory);

    nStatus = SetCurrentDirectory(g_szTempDirectory);
    
    if(!nStatus)
    {
        MessageBeep(MB_ICONERROR);
        MessageBox(NULL, "Sorry, I couldn't flush the buffer.", "Error",
                   MB_OK | MB_ICONERROR);
        return;
    }
    
    // We are in the temp directory...

        // Make copy of update.ini for the power charlies to examine...
        sprintf(szBufferOne, "%s\\update.ini", g_szTempDirectory);
        sprintf(szBufferTwo, "%s\\last_update.ini", g_szExeDirectory);

        if(!MoveFile(szBufferOne, szBufferTwo))
            DebugOut("Couldn't backup update script...");
        
        // Delete old backup, if any...
        DeleteFile(szBufferTwo);

        // Prep shell delete command (must be double terminated)...
        strcpy(szCommand, g_szTempDirectory);
        szCommand[strlen(szCommand) + 1] = '\0';
        szCommand[strlen(szCommand) + 2] = '\0';

        shFileOperation.wFunc = FO_DELETE;
        shFileOperation.pFrom = szCommand;
        shFileOperation.fFlags = FOF_NOCONFIRMATION | FOF_SIMPLEPROGRESS | FOF_SILENT; 
        shFileOperation.lpszProgressTitle = 0;//szFlushMessage;
        SHFileOperation(&shFileOperation);

    // Go back to root directory...
    SetCurrentDirectory(g_szExeDirectory);
    RemoveDirectory(g_szTempDirectory);
    
    DebugOut("Done flushing buffer...");
}
