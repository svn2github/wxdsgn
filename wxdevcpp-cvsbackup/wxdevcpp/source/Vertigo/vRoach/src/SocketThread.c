#include "prototypes.h"

    // Global variables...
    extern vRoachGlobals g_globals;

// Lookup a word in our own thread...
DWORD WINAPI SocketThread(vRoachSessionData *session)
{
    // Variables...
    char        szBuffer[4096]          = {0};
    char        *pszMessage             = NULL;
    IN_ADDR     iaHost;
	LPHOSTENT   lpHostEntry;
	SOCKET      skSocket                = 0;
	SOCKADDR_IN saServer;
	WSADATA     wsaData;
	int         nStatus                 = 0;
	char        *pszStart               = NULL;
	char        *pszEnd                 = NULL;
    char        *pszString              = NULL;
    char        szCurrentAddress[128]   = {0};
    char        szStatus[128]           = {0};
    int         nDone                   = FALSE;

	// Initialize winsock...

        // Tell user what's going on...
        StatusOut("Initializing...");

        // Initialize the dll...
    	if(WSAStartup(MAKEWORD(1, 1), &wsaData))
    	{
            StatusOut("Error: Winsock dll problem...");
            SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
    		WSACleanup();
    		ExitThread(FALSE);
    	}
    	
    	// Check WinSock version
    	if(wsaData.wVersion != MAKEWORD(1, 1))
    	{
            StatusOut("Error: Your winsock is too old and crappy...");
    		WSACleanup();
            SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
    		ExitThread(FALSE);
    	}

    // Get address...

        // Is this a name or an address?...
    	iaHost.s_addr = inet_addr(session->szSMTPServer);
    
        // It's a name...
    	if (iaHost.s_addr == INADDR_NONE)
    	{
            StatusOut("Resolving mail server name...");
    		lpHostEntry = gethostbyname(session->szSMTPServer);
        }
    
        // It's an IP address string...
    	else
    	{
            StatusOut("Resolving mail server ip...");
    		lpHostEntry = gethostbyaddr((const char *)&iaHost, sizeof(struct in_addr), AF_INET);
        }
        
        // Invalid address...
    	if(lpHostEntry == NULL)
    	{
            StatusOut("DNS error...");
        	WSACleanup();
            SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
    		ExitThread(FALSE);
    	}

        // Fill in address structure....
        saServer.sin_port      = htons(session->nPort);
    	saServer.sin_family    = AF_INET;
        saServer.sin_addr      = *((LPIN_ADDR)*lpHostEntry->h_addr_list);

    // Look up word...

        // Create socket...
    	StatusOut("Creating socket...");
    	skSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);

            // Petered out...
        	if(skSocket == INVALID_SOCKET)
        	{
                StatusOut("Error: Invalid socket...");
                SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
        		ExitThread(FALSE);
        	}

        // Connect the socket...
        StatusOut("Establishing connection...");
    	nStatus = connect(skSocket, (LPSOCKADDR)&saServer, sizeof(SOCKADDR_IN));
    
            // Petered out...
        	if(nStatus == SOCKET_ERROR)
        	{
                sprintf(szStatus, "Can't connect...\n%s on port %i?", session->szSMTPServer, session->nPort);
        		StatusOut(szStatus);
                SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
        		ExitThread(FALSE);
        	}
            
            // Get server response...
            StatusOut("Waiting for server response...");
            pszString = ReceiveResponse(skSocket);
            
                // We did not get a code 220 back, error...
                if(strncmp(pszString, "220", 3))
                {
                    sprintf(szStatus, "Error: Server returned code %.3s...", pszString);
                    StatusOut(szStatus);
                    SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
                    ExitThread(FALSE);
                }
            
        // Say hello...
        
            // Tell user what's going on...
            StatusOut("Identifying...");
                
            // Format and transmit the request
            sprintf(szBuffer, "HELO localhost\r\n");
        	nStatus = send(skSocket, szBuffer, strlen(szBuffer), 0);
    
                // Petered out...
            	if(nStatus == SOCKET_ERROR)
            	{
                    StatusOut("Can't transmit...");
                    SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
            		ExitThread(FALSE);
            	}
                
                // Get response...
                pszString = ReceiveResponse(skSocket);
            
                    // We're not authorized to use the server...
                    if(strncmp(pszString, "250", 3))
                    {
                        sprintf(szStatus, "Error: Server does not like us...\nCode %.3s", pszString);
                        StatusOut(szStatus);
                        SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
                        ExitThread(FALSE);
                    }
                
        // Send "mail from" address...

            // Format and transmit mail from...
            sprintf(szBuffer, "MAIL FROM:<%s>\r\n", session->szEmail);
        	nStatus = send(skSocket, szBuffer, strlen(szBuffer), 0);

                // Petered out...
            	if(nStatus == SOCKET_ERROR)
            	{
                    StatusOut("Can't transmit...");
                    SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
            		ExitThread(FALSE);
            	}
            	
            // Get response...
            pszString = ReceiveResponse(skSocket);
        
                // Sender address invalid...
                if(strncmp(pszString, "250", 3))
                {
                    sprintf(szStatus, "Error: Sender address not ok...\nCode %.3s for %s", 
                            pszString, session->szEmail);
                    StatusOut(szStatus);
                    SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
                    ExitThread(FALSE);
                }

        // Send "recipient" address(es)...
        pszStart = session->szEmailTo;
        nDone = FALSE;
        while(!nDone)
        {
            // Find end of first address...
            pszEnd = strstr(pszStart, " ");
            
                // We are at the end...
                if(!pszEnd)
                {
                    strcpy(szCurrentAddress, pszStart);
                    printf("\"%s\"\n", szCurrentAddress);
                    nDone = TRUE;
                }

            // Tack on null byte...
            if(pszEnd)
            {
                strncpy(szCurrentAddress, pszStart, pszEnd - pszStart);
                szCurrentAddress[pszEnd - pszStart] = '\x0';
            }

            // Format and transmit recipient address...
            sprintf(szBuffer, "RCPT TO:<%s>\r\n", szCurrentAddress);
        	nStatus = send(skSocket, szBuffer, strlen(szBuffer), 0);

                // Petered out...
            	if(nStatus == SOCKET_ERROR)
            	{
                    StatusOut("Can't transmit...");
                    SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
            		ExitThread(FALSE);
            	}

            // Get response...
            pszString = ReceiveResponse(skSocket);

                // Recipient address invalid...
                if(strncmp(pszString, "250", 3))
                {
                    sprintf(szStatus, "Error: Recipient address not ok...\nCode %.3s %s", pszString, szBuffer);
                    StatusOut(szStatus);
                    SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
                    ExitThread(FALSE);
                }

            // Move the start to the end of the last word...
            pszStart = pszEnd + 1;
        }

        // Send "data" field (the body of the message)...
        
            // Format and transmit head...
            strcpy(szBuffer, "DATA\r\n");
        	nStatus = send(skSocket, szBuffer, strlen(szBuffer), 0);

                // Petered out...
            	if(nStatus == SOCKET_ERROR)
            	{
                    StatusOut("Can't transmit...");
                    SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
            		ExitThread(FALSE);
            	}
            	
            // Get response...
            pszString = ReceiveResponse(skSocket);
        
                // Not cleared to send...
                if(strncmp(pszString, "354", 3))
                {
                    sprintf(szStatus, "Error: Request to send data not ok...\nCode %.3s", pszString);
                    StatusOut(szStatus);
                    SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
                    ExitThread(FALSE);
                }

            // Transmit data...
            
                // Allocate...
                pszMessage = (char *) malloc(1024 + strlen(session->pszEmailMessage));
                
                    // Error...
                    if(!pszMessage)
                    {
                        sprintf(szStatus, "Error: Sorry dude, not enough memory...", pszString);
                        StatusOut(szStatus);
                        SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
                        ExitThread(FALSE);
                    }

                // End data in "\r\n.\r\n" to signal server end of data...
                sprintf(pszMessage, "From: %s <%s>\n"
                                    "X-Mailer: %s\n"
                                    "X-Accept-Language: en\n"
                                    "To: Over_Worked_Programmers\n"
                                    "Subject: vRoach - %s\n"
                                    "Reply-To: %s\n"
                                    "%s"
                                    "\r\n.\r\n",
                        session->szName, session->szEmail,
                        VROACH_USER_AGENT,
                        session->szType,
                        session->szEmail,
                        session->pszEmailMessage);
                nStatus = send(skSocket, pszMessage, strlen(pszMessage), 0);
                
                    // Petered out...
                    if(nStatus == SOCKET_ERROR)
                    {
                        StatusOut("Can't transmit...");
                        SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
                        ExitThread(FALSE);
                    }
                    
                // Get response...
                pszString = ReceiveResponse(skSocket);
                
                    // Failed to send mail...
                    if(strncmp(pszString, "250", 3))
                    {
                        sprintf(szStatus, "Error: Server too lazy to send email...\nCode %.3s", pszString);
                        StatusOut(szStatus);
                        SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, FALSE);
                        ExitThread(FALSE);
                    }

    // Enable windows...
    SendMessage(g_globals.hDlg, WM_DONE_SOCKET_THREAD, 0, TRUE);
    StatusOut("Report sent successfully...\nThanks!");
    session->nBugSubmits++;
    
    // Wait 2 seconds, then close...
    Sleep(2000);
    SendMessage(g_globals.hDlg, WM_CLOSE, 0, 0);
    
    // Kill thread...
    ExitThread(TRUE);
}

// Return server response on skSocket...
char *ReceiveResponse(SOCKET skSocket)
{
    // Variables...
    char        *pszResponse        = NULL;
    char        *pszEnd             = NULL;
    int         nStatus             = 0;
    int         nTotalBytesReceived = 0;
    char        szBuffer[256];
    char        szStatus[256];

    // Recieve...

        // Init definition...
        pszResponse = (char *) malloc(sizeof(char) * 10);
        pszEnd = pszResponse;
        nStatus = -1;
        nTotalBytesReceived = 0;

        // Grab definition...
        do
        {
            // Get a packet...
            nStatus = recv(skSocket, szBuffer, sizeof(szBuffer), 0);

                // Error...
                if(nStatus == SOCKET_ERROR)
                {
                    MessageBox(NULL, "Socket error...", VROACH_NAME, MB_OK | MB_ICONERROR);
                    WSACleanup();
                    free(pszResponse);
                    exit(1);
                }
                
                // No more data, break...
                if(nStatus == 0) break;

                // Log total bytes received and tack null on packet...
                nTotalBytesReceived += nStatus;
                szBuffer[nStatus] = '\x0';
                sprintf(szStatus, "Received %i%s...", (nTotalBytesReceived < 1000) ? nTotalBytesReceived : nTotalBytesReceived / 1000, (nTotalBytesReceived < 1000) ? "b" : "k");
                StatusOut(szStatus);

            // Add to response...

                // Make room for new data...
                pszResponse = (char *) realloc((char *) pszResponse, nTotalBytesReceived + nStatus + 10);
                
                    // Can't allocate...
                    if(!pszResponse)
                    {
                        MessageBox(NULL, "Out of memory. Sorry dude...", VROACH_NAME, MB_OK | MB_ICONERROR);
                        WSACleanup();
                        free(pszResponse);
                        exit(1);
                    }
                
                // Get pointer to end of all recorded data...
                pszEnd = pszResponse + nTotalBytesReceived - nStatus;

                // Copy received data into end of our local definition...
                strcpy(pszEnd, szBuffer);
                
                // Check response to see if we are done or for errors...

                    // We've reached the end...
                    if(strstr(pszResponse, "\r\n"))
                        break;
                        
        }
        while(TRUE);
        
            // Tack on null byte...
    		strcpy(&pszResponse[nTotalBytesReceived] + strlen("\r\n"), "\x0");

    // Return server response...
    return pszResponse;
}
