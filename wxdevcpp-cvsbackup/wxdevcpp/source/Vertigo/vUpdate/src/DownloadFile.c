/* 
   Name: Network (module)
   Author: Kip Warner
   Description: Network code...
   Version: 1.2
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

// Download file via http at pszURL and save as pszFileName...
int DownloadFile(char *pszURL, char *pszFileName, controlData *controls, vUpdateOptions *options)
{
    // Variables...

        // Socket stuff...
        IN_ADDR     iaHost;
    	LPHOSTENT   lpHostEntry;
    	SOCKET      skSocket;
    	SOCKADDR_IN saServer;
    	WSADATA     wsaData;
    	int         nStatus                 = 0;
    	char        szHeader[4096]          = {0};
    	int         nHeaderLength           = 0;
    	int         nHeaderCurrentLength    = 0;
        char        szBuffer[4096]          = {0};
        char        szServerName[256]       = {0};
        float       fProgress               = 0.0;

        long        nTotalBytesReceived     = 0;
        BOOL        bDownloadingHeader      = FALSE;
        
        char        szDebug[1024]           = {0};
        
        char        *pszString              = NULL;
        http_header header;

        // File I/O...
        FILE        *hFile                  = NULL;

        // URL tokenizing...
        char        szFilePath[256]         = {0};
        char        szTemp[256]             = {0};
        char        *pszStart               = NULL;

        // Interface...
        HWND        hStatus                = controls[ID_STATUS_WINDOW].hwnd;

    // Initialize progress bar...

        // Put at zero percent...
        SendMessage(controls[ID_PROGRESS_BAR].hwnd, PBM_SETPOS, 0, 0);

        // Set range to 100...
        SendMessage(controls[ID_PROGRESS_BAR].hwnd, PBM_SETRANGE, 0, MAKELPARAM(0, 100));

        // Each increment, go up by one...
        SendMessage(controls[ID_PROGRESS_BAR].hwnd, PBM_SETSTEP, (WPARAM) 1, 0);

    // Get server name...
    if(!GetHostName(szServerName, pszURL))
    {
        StatusOut("Error: Invalid URL...", hStatus);
        return DOWNLOAD_ERROR_URL;    
    }

        // Tell user if we're using proxy server...
        if(options->bAdvancedUseProxy)
            StatusOut("Using proxy...", hStatus);

    // Get file path on server...
    strcpy(szFilePath, pszURL);
    pszStart = strstr(szFilePath, "//");
    pszStart += strlen("//");
    pszStart = strstr(pszStart, "/");
    strcpy(szFilePath, pszStart);

	// Initialize winsock...

        // Initialize the dll...
    	if(WSAStartup(MAKEWORD(1, 1), &wsaData))
    	{
            StatusOut("Error: Can't initialize winsock dll...", hStatus);
    		WSACleanup();
            return DOWNLOAD_ERROR_WINSOCK_DLL;
    	}

    	// Check WinSock version
    	if (wsaData.wVersion != MAKEWORD(1, 1))
    	{
            StatusOut("Error: Winsock version unsupported...", hStatus);
    		WSACleanup();
    		return DOWNLOAD_ERROR_WINSOCK_VERSION;
    	}

    // Get address...

        // Is this a name or an address?...
    	iaHost.s_addr = inet_addr(options->bAdvancedUseProxy ? options->szAdvancedProxyServer : szServerName);

        // It's a name...
    	if (iaHost.s_addr == INADDR_NONE)
    	{
            sprintf(szDebug, "Resolving name %s...", options->bAdvancedUseProxy ? options->szAdvancedProxyServer : szServerName);
            DebugOut(szDebug);
            StatusOut("Resolving server name...", hStatus);
    		lpHostEntry = gethostbyname(options->bAdvancedUseProxy ? options->szAdvancedProxyServer : szServerName);
        }

        // It's an IP address string...
    	else
    	{
            StatusOut("Resolving IP address...", hStatus);
    		lpHostEntry = gethostbyaddr((const char *)&iaHost, sizeof(struct in_addr), AF_INET);
        }

        DebugOut("Resolved...");

        // Invalid address...
    	if(lpHostEntry == NULL)
    	{
            StatusOut("Error: Invalid address...", hStatus);
            sprintf(szDebug, "Address was %s...", options->bAdvancedUseProxy ? options->szAdvancedProxyServer : szServerName);
            DebugOut(szDebug);
        	WSACleanup();
    		return DOWNLOAD_ERROR_HOSTNAME;
    	}

    // Get port...
    int nPort = options->bAdvancedUseProxy ? options->nAdvancedProxyPort : 80;

    // Fill in address structure....
    saServer.sin_port      = htons(nPort);
	saServer.sin_family    = AF_INET;
	saServer.sin_addr      = *((LPIN_ADDR)*lpHostEntry->h_addr_list);

    // Get the file...

        // Create socket...
    	DebugOut("Creating socket...");
    	skSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);

            // Petered out...
        	if(skSocket == INVALID_SOCKET)
        	{
                StatusOut("Error: Can't create socket...", hStatus);
                WSACleanup();
        		return DOWNLOAD_ERROR_CREATE_SOCKET;
        	}

        // Connect the socket...
        StatusOut("Connecting to server...", hStatus);
    	nStatus = connect(skSocket, (LPSOCKADDR)&saServer, sizeof(SOCKADDR_IN));
        UpdateWindow(GetParent(controls[ID_STATUS_GROUPBOX].hwnd));
    
            // Petered out...
        	if(nStatus == SOCKET_ERROR)
        	{
                sprintf(szBuffer, "Error: Can't connect to %s...", szServerName);
        		StatusOut(szBuffer, hStatus);
        		closesocket(skSocket);
        		WSACleanup();
        		return DOWNLOAD_ERROR_CONNECT;
        	}

    	// Format and transmit the HTTP request
    	
            // Using proxy...
            if(options->bAdvancedUseProxy)
            {
                sprintf(szBuffer, "GET %s HTTP/1.0\r\n"
                                  "Host: %s\r\n"
                                  "Connection: close\r\n"
                                  "Pragma: no-cache\r\n"
                                  "Cache-Control: no-cache\r\n"
                                  "User-Agent: %s\r\n\r\n",
                        pszURL,
                        szServerName,
                        VUPDATE_USER_AGENT);
            }
            
            // Don't use proxy...
            else
            {
                sprintf(szBuffer, "GET %s HTTP/1.0\r\n"
                                  "Host: %s\r\n"
                                  "Connection: close\r\n"
                                  "Pragma: no-cache\r\n"
                                  "Cache-Control: no-cache\r\n"
                                  "User-Agent: %s\r\n\r\n",
                        szFilePath,
                        szServerName,
                        VUPDATE_USER_AGENT);
            }

    	DebugOut("Requesting file...");
        sprintf(szDebug, "Transmitting header to \"%s\". Will send...\n%s", szServerName, szBuffer);
        DebugOut(szDebug);
    	nStatus = send(skSocket, szBuffer, strlen(szBuffer), 0);

            // Petered out...
        	if(nStatus == SOCKET_ERROR)
        	{
                StatusOut("Error: Can't send request...", hStatus);
                closesocket(skSocket);
        		WSACleanup();
        		return DOWNLOAD_ERROR_SEND;
        	}

        // If the file already exists, we should back it up...
    
            // Open it...
            hFile = fopen(pszFileName, "r");
            
                // It exists...
                if(hFile)
                {
                    // Copy file...
                    sprintf(szBuffer, "%s.BACKUP", pszFileName);

                    if(!CopyFile(pszFileName, szBuffer, FALSE))
                        StatusOut("Error: Can't backup file...", hStatus);
                    else
                        StatusOut("Backed up local file...", hStatus);

                    // Close stream...
                    fclose(hFile);
                }

        // Begin disk write...
        do
        {
        
            // Try to create file...
        	hFile = fopen(pszFileName, "w+b");
            
                // All good, continue...
                if(hFile)
                    break;
            
            // Can't create...
            
                // Tell user whats going on...
                StatusOut("Error: Can't create file for writing...", hStatus);
                strcpy(szDebug, "Can't write file...");
                DebugOut(szDebug);

                // Prompt user...
                sprintf(szBuffer, "The following file appears to be in use...\n"
                                  "%s\n"
                                  "No worries, close it and hit retry.\n", pszFileName);

                    // Try again...
                    if(IDRETRY == MessageBox(GetParent(controls[ID_STATUS_WINDOW].hwnd),
                                  szBuffer, g_szAppName, MB_RETRYCANCEL | MB_ICONINFORMATION))
                        continue;

                    // Peter out...
                    else
                    {
                        closesocket(skSocket);
                        WSACleanup();
                        return DOWNLOAD_ERROR_FILE_IO;                        
                    }
        }
        while(TRUE);
        DebugOut("Beginning write...");
    	   

    	// Receive file...
        StatusOut("Downloading...", hStatus);
    	DebugOut("Getting header...");
    	bDownloadingHeader = TRUE;
    	while(1)
    	{
    		// Wait to receive, nStatus is the number of bytes received...
    		nStatus = recv(skSocket, szBuffer, sizeof(szBuffer), 0);

                // Error...
        		if(nStatus == SOCKET_ERROR)
                {
        			StatusOut("Error: Socket error...", hStatus);
        			
        			// Delete incomplete file...
                    fclose(hFile);
                    DeleteFile(pszFileName);
                    closesocket(skSocket);
                	WSACleanup();
                    return FALSE;
        		}

    		// No more data...
    		if(nStatus == 0)
    		{
                DebugOut("Done receiving...");
                break;
            }
            
            // How much have we downloaded so far?...
            nTotalBytesReceived += nStatus;

            // We need to extract the http header out before we write to disk...
            if(bDownloadingHeader)
            {
                // Calculate current length of local header...
                nHeaderCurrentLength += nStatus;

                // We are still downloading header, append to local data...
                memcpy(szHeader, szBuffer, nStatus);
               
                // Do we have the entire header? (ends in \r\n\r\n")...
                pszString = strstr(szHeader, "\r\n\r\n");
                
                    // End of header found...
                    if(pszString)
                    {
                        // Move pszString to start of file data...
                        pszString += strlen("\r\n\r\n");
                        
                        // Tack null byte on end of header...
                        *(pszString-1) = '\x0';

                        // Calculate header length...
                        pszStart = szHeader;
                        nHeaderLength = pszString - pszStart;
                        
                        // Send header structure from our header buffer...
                        fillHeader(szHeader, &header);
                        
                        // Say what type of server we are using if one is specified...
                        if(header.szServerType[0])
                        {
                            sprintf(szTemp, "%s server detected...", header.szServerType);
                            StatusOut(szTemp, hStatus);
                        }
                        
                        // Check header...

                            // Server returned an error code...
                            if(header.nCode != 200)
                            {
                                closesocket(skSocket);
                            	WSACleanup();
                            	fclose(hFile);
                            	DeleteFile(pszFileName);
                            	
                            	sprintf(szBuffer, "Error: Server returned code %i...", header.nCode);
                            	StatusOut(szBuffer, controls[ID_STATUS_WINDOW].hwnd);
                                return DOWNLOAD_ERROR_HTTP_CODE_NOT_200;
                            }

                            sprintf(szDebug, "Server's header returned...\n"
                                             "Code:     %i\nDate:     %s\nServer:   %s\nModified: %s\n"
                                             "E-Tag:    %s\nRange:    %s\nLength:   %lu\nType:     %s\n",
                                    header.nCode, header.szDate, header.szServerType, header.szLastModified,
                                    header.szETag, header.szAcceptRanges, header.nContentLength, header.szContentType);
                            DebugOut(szDebug);

                        // Write what was just passed the header to disk because it is part of the file...
                        fwrite(pszString, sizeof(char), nTotalBytesReceived - nHeaderLength, hFile);

                        // We're done with the header, start grabbing the file...
                        DebugOut("Downloaded header...");
                        bDownloadingHeader = FALSE;
                        continue;
                    }
            }
            
            // Known content length...
            if(header.nContentLength)
            {
                // Calculate progress...
                fProgress = (double)((double)(nTotalBytesReceived - nHeaderLength) / header.nContentLength) * 100;
                sprintf(szDebug, "Received %0.1f%% (%li/%li bytes)...", fProgress, nTotalBytesReceived - nHeaderLength, !header.nContentLength ? 0 : header.nContentLength);
                DebugOut(szDebug);
                
                // Update progress bar...
                SendMessage(controls[ID_PROGRESS_BAR].hwnd, PBM_SETPOS, (int) fProgress, 0);
                
                    // Update title bar...
                    sprintf(szTemp, "%0.1f%% of %s", fProgress, 
                            strrchr(pszFileName, '\\') ? strrchr(pszFileName, '\\') + 1 : "something");
                    SetWindowText(GetParent(controls[ID_PROGRESS_BAR].hwnd), szTemp);
            }
            // Unknown content length...
            else
            {
                // Debug...
                sprintf(szDebug, "Received ?%% (%li / ? bytes)...", nTotalBytesReceived - nHeaderLength);
                DebugOut(szDebug);
                
                sprintf(szTemp, "Received %li bytes (Content-Length unknown)...", nTotalBytesReceived - nHeaderLength);
                SetWindowText(GetParent(controls[ID_PROGRESS_BAR].hwnd), szTemp);
            }

    		// Write buffer to disk...
            fwrite(szBuffer, sizeof(char), nStatus, hFile);
    	}

    sprintf(szDebug, "Received a total of %li bytes (including header)...", nTotalBytesReceived);
    DebugOut(szDebug);

    // Reset title bar...
    SetWindowText(GetParent(controls[ID_PROGRESS_BAR].hwnd), g_szAppName);

	// Unload dll, close socket / file, return...
    closesocket(skSocket);
	WSACleanup();
    fclose(hFile);
    return DOWNLOAD_OK;
}
