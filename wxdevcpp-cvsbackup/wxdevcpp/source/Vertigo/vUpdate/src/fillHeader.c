/* 
   Name: fillHeader (function)
   Author: Kip Warner
   Description: Scans string for http header data and dumps it in header structure...
   Version: 1.0
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

// Scans string for http header data and dumps it in header structure...
void fillHeader(char *pszHeaderBuffer, http_header *header)
{
    // Variables...
    char    *pszString          = NULL;
    char    *pszEnd             = NULL;
    char    szTemp[4096];

    // Get http code...
    strcpy(szTemp, pszHeaderBuffer);
    pszString = strstr(szTemp, "HTTP/");

        // No code...
        if(!pszString)
            header->nCode = -1;

        // Code...
        else
        {
            strtok(szTemp, " ");
            header->nCode = atoi(strtok(NULL, " "));
        }
        

    // Get date...
    strcpy(szTemp, pszHeaderBuffer);
    pszString = strstr(szTemp, "Date: ");
    
        // No date...
        if(!pszString)
            strcpy(header->szDate, "?");
    
        // Date...
        else
        {
            pszString += strlen("Date: ");
            pszEnd = strstr(pszString, "\r");
            *pszEnd = '\0';
            strcpy(header->szDate, pszString);
        }
        
    // Get server type...
    strcpy(szTemp, pszHeaderBuffer);
    pszString = strstr(szTemp, "Server: ");
    
        // No server type...
        if(!pszString)
            header->szServerType[0] = '\x0';
            
        // Server type...
        else
        {
            pszString += strlen("Server: ");
            pszEnd = strstr(pszString, "\r");
            *pszEnd = '\0';
            strcpy(header->szServerType, pszString);
        }
    
    // Get date of last modification...
    strcpy(szTemp, pszHeaderBuffer);
    pszString = strstr(szTemp, "Last-Modified: ");
    
        // No date...
        if(!pszString)
            strcpy(header->szLastModified, "?");
        
        // Date...
        else
        {
            pszString += strlen("Last-Modified: ");
            pszEnd = strstr(pszString, "\r");
            *pszEnd = '\0';
            strcpy(header->szLastModified, pszString);
        }
    
    // Get E-Tag (I have no clue what this is for)...
    strcpy(szTemp, pszHeaderBuffer);
    pszString = strstr(szTemp, "ETag: ");
    
        // No ETag...
        if(!pszString)
            strcpy(header->szETag, "?");
            
        // ETag...
        else
        {
            pszString += strlen("ETag: ");
            pszEnd = strstr(pszString, "\r");
            *pszEnd = '\0';
            strcpy(header->szETag, pszString);
        }

    // Get accept ranges...
    strcpy(szTemp, pszHeaderBuffer);
    pszString = strstr(szTemp, "Accept-Ranges: ");
    
        // No accept ranges...
        if(!pszString)
            strcpy(header->szAcceptRanges, "?");
        
        // Accept ranges...
        else
        {
            pszString += strlen("Accept-Ranges: ");
            pszEnd = strstr(pszString, "\r");
            *pszEnd = '\0';
            strcpy(header->szAcceptRanges, pszString);
        }

    // Get file size...
    strcpy(szTemp, pszHeaderBuffer);
    pszString = strstr(szTemp, "Length: ");
    
        // No file size...
        if(!pszString)
            header->nContentLength = 0;

        // File size...
        else
        {
            pszString += strlen("Length: ");
            pszEnd = strstr(pszString, "\r");
            *pszEnd = '\0';
            header->nContentLength = atoi(pszString);
            
            // Reject 0 bytes (server probably petered out)...
            if(header->nContentLength == 0)
                header->nContentLength = 0;
        }

    // Get connection status...
    strcpy(szTemp, pszHeaderBuffer);
    pszString = strstr(szTemp, "Connection: ");
    
        // No connection status...
        if(!pszString)
            strcpy(header->szConnection, "?");
            
        // Connection status...
        else
        {
            pszString += strlen("Connection: ");
            pszEnd = strstr(pszString, "\r");
            *pszEnd = '\0';
            strcpy(header->szConnection, pszString);
        }

    // Get file type...
    strcpy(szTemp, pszHeaderBuffer);
    pszString = strstr(szTemp, "Content-Type: ");
    
        // No content type...
        if(!pszString)
            strcpy(header->szContentType, "?");

        // Content tyoe...
        else
        {
            pszString += strlen("Content-Type: ");
            pszEnd = strstr(pszString, "\r");
            *pszEnd = '\0';
            strcpy(header->szContentType, pszString);
        }
}
