//---------------------------------INCLUDES-------------------------------------
#include <windows.h>                                                            // Guess...
#include "resources/resources.h"                                                // Resource file ids...
#include <commctrl.h>                                                           // For progress bar...
#include <string.h>                                                             // File I/O...
#include <math.h>                                                               // atof()...
#include <stdlib.h>                                                             // atof()...
#include <stdio.h>                                                              // File I/O...
#include <malloc.h>                                                             // malloc()....
#include <ctype.h>                                                              // toupper() and isalnum()...
#include <time.h>                                                               // Time stamps in install database...
#include <shlobj.h>                                                             // GetLocalAppDataDirectory(void)...
//-------------------------------DEFINITIONS------------------------------------

// Message proc...
#define WM_DONE_SOCKET_THREAD                           WM_USER + 40

// Ini parsing engine...
#define INI_ALL_GOOD                                    1
#define INI_ERROR_CANNOT_OPEN                           0
#define INI_ERROR_EMPTY_FILE                            -1
#define INI_ERROR_INVALID_FILE                          -2
#define INI_ERROR_OUT_OF_MEMORY                         -3
#define INI_ERROR_KEY_NOT_FOUND                         -4
#define INI_ERROR_FIELD_NOT_FOUND                       -5
#define INI_ERROR_CANNOT_WRITE                          -6

// Misc...
#ifndef TRUE
    #define TRUE                                        !FALSE
    #define FALSE                                       0
#endif  TRUE

#define VROACH_TOP_FILE                                 "/\\------------------------------------/\\"
#define VROACH_BOTTOM_FILE                              "\\/------------------------------------\\/"

//------------------------------CHOKE-POINT-------------------------------------

#define VROACH_FILE_VERSION                            1, 5, 0, 5               // For exe image in resource file...
#define VROACH_VERSION_FLOAT                           1.505
#define VROACH_NAME                                    "vRoach 1.505"

    // Distribution...
///*
        // Dev-C++...
        #define DEVCPP_DISTRO
        #define VROACH_USER_AGENT                              "vRoach_DCPP/1.504 (Bug Submitter)"               // Who we are to server...
        #define VROACH_DISTRIBUTION                            "Dev-C++"
        #define VROACH_DEFAULT_SMTP                            "mail.zero47.com"
        #define VROACH_DEFAULT_EMAILTO                         "devcpp_bugs@zero47.com"
        #define VROACH_SHOW_ABOUT                              TRUE
        #define VROACH_LOGO                                    "resources/devcpp.bmp"
        #define VROACH_SOUND                                   "resources/devcpp.wav"
//*/
/*
        // Tentnology...
        #define TENTNOLOGY_DISTRO
        #define VROACH_USER_AGENT                              "vRoach_TENT/1.504 (Bug Submitter)"               // Who we are to server...
        #define VROACH_DISTRIBUTION                            "Tentnology"
        #define VROACH_DEFAULT_SMTP                            "shawmail.vs.shawcable.net"
        #define VROACH_DEFAULT_EMAILTO                         "dougdark@telus.net"
        #define VROACH_SHOW_ABOUT                              FALSE
        #define VROACH_LOGO                                    "resources/tentnology.bmp"
        #define VROACH_SOUND                                   "resources/tentnology.wav"
*/
//--------------------------------GLOBALS---------------------------------------

//---------------------------------TO-DO----------------------------------------
/*
    * Fix check box disable bug...
    * Implement code to take first passed parameter and place in comments window...
    * Implement code to check for default text in comments window...
    _ Implement an 'Attach file" system using GetOpenFileName()...
    * Update ini lib to 2.3...
*/

//--------------------------------DATA-TYPES------------------------------------

    // Global variables...
    typedef struct
    {
        HWND        hDlg;
        HINSTANCE   hInstance;

    }vRoachGlobals;
    
    // Options...
    typedef struct
    {
        // Position key...
        int         nStartX;
        int         nStartY;
        
        // Server key...
        char        szSMTPServer[1024];
        int         nPort;
        char        szEmailTo[1024];
        
        // User key...
        char        szName[1024];
        char        szEmail[256];
        char        szType[1024];
        BOOL        bAttachSpecs;
        BOOL        bAttachConfigs;
        int         nBugSubmits;
        char        *pszComments;
        
        // Misc...
        BOOL        bDebugMode;
        BOOL        bPlaySound;
        
        // Transmitted stuff...
        char        *pszEmailMessage;

    }vRoachSessionData;

//--------------------------------SIGNATURES------------------------------------

    // About box dialog procedure...
    BOOL    CALLBACK AboutDialogProc(HWND hDlg, UINT msg, WPARAM wParam, LPARAM lParam);

    // Main window dialog procedure...
    BOOL    CALLBACK MainDialogProc(HWND hDlg, UINT msg, WPARAM wParam, LPARAM lParam);

    // Returns a character pointer to a file's contents...
    char    *getFileContents(char *pszFileName, BOOL bFormatFile);

    // Returns a character pointer to a file's contents...
    char    *getFileContentsAppDirectory(char *pszFileName, BOOL bFormatFile);

    // Returns the file size of pszFileName in bytes. -1 on error...
    int     getFileSize(char *pszFileName);

    // Returns the file size of pszFileName in bytes in the application data directory. -1 on error...
    int     getFileSizeAppDirectory(char *pszFileName);

    // Get user's local app data directory...
    char    *GetLocalAppDataDirectory(void);

    // Get a field under pszKey names pszField and store in pszData...
    int     ini_GetField(char *pszFileName, char *pszKey, char *pszField, char *pszData);
    
    // Write a field to pszFileName (an ini file)...
    int     ini_SetField(char *pszFileName, char *pszKey, char *pszField, char *pszData);

    // Return true if windows NT class OS...
    BOOL    IsNT(void);

    // Receives a response on skSocket (use after transmitting)...
    char    *ReceiveResponse(SOCKET skSocket);

    // Thread that looks up a word...
    DWORD   WINAPI SocketThread(vRoachSessionData *session);

    // Set status window text...
    BOOL    StatusOut(char *pszString);

    // Returns the amount of occurences of pszKey in pszList...
    int     strocc(char *pszList, char *pszKey);
    
    // If pszString is TRUE, true, or, t, return TRUE...
    BOOL   strtobool(char *pszString);

//---------------------------------NOTES----------------------------------------
/*
    

*/


