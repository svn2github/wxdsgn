/* 
   Name: resources.h
   Author: Kip Warner
   Description: All our ids for every resource we plan on using...
   Copyright: Yes
*/

// Basic stuff...
#define IDI_ICON                                    4000
#define IDC_CURSOR                                  4010

// Swap.exe...
#define IDE_SWAP                                    4015

// System menu...
#define IDM_SYS_DEBUG                               4020
#define IDM_SYS_OPTIONS                             4025
#define IDM_SYS_ABOUT                               4027

// Controls (MUST start at 0 and be continuous kip)...
#define ID_STATUS_GROUPBOX                          0
#define ID_ANNOUNCEMENTS_GROUPBOX                   1
#define ID_DESCRIPTION_GROUPBOX                     2
#define ID_PACKAGES_GROUPBOX                        3
#define ID_PICTURE_BOX                              4
#define ID_STATUS_WINDOW                            5
#define ID_ANNOUNCEMENTS                            6
#define ID_DESCRIPTION                              7
#define ID_START                                    8
#define ID_OPTIONS                                  9
#define ID_ABOUT                                    10
#define ID_EXIT                                     11
#define ID_PROGRESS_BAR                             12
#define ID_SCROLL_BAR                               13

#define ID_TOP_LIST_ITEM                            14
#define ID_MIDDLE_LIST_ITEM                         15
#define ID_BOTTOM_LIST_ITEM                         16

// Dialog boxes...
#define IDC_STATIC                                  0

    // About box...
    #define IDD_LICENSE                             4000
    #define IDD_USER_MANUAL                         4010
    #define IDD_PROGRAMMER                          4020
    #define IDD_EMAIL                               4030
    #define IDD_ICQ                                 4040
    #define IDD_URL                                 4050

    // Options window...
    #define IDD_OPTION_DESCRIPTION                  4100
    #define IDD_DEFAULT                             4110

        // Interface options...
        #define IDD_INTERFACE_SMOOTH_PROGRESS_BAR   4200
        #define IDD_INTERFACE_DEV_THEME             4210
        #define IDD_INTERFACE_PREVIEWS              4220

        // List options...
        #define IDD_LIST_PACKAGES                   4300
        #define IDD_LIST_PATCHES                    4310
        #define IDD_LIST_LANGUAGES                  4320
        #define IDD_LIST_LANGUAGES_LIST             4330
        #define IDD_LIST_HELP                       4340
        #define IDD_LIST_OTHER                      4350

        // Advanced options...
        #define IDD_ADVANCED_DEBUG_LOG              4400
        #define IDD_ADVANCED_BANDWIDTH_THROTTLE     4410
        #define IDD_ADVANCED_EDIT_INSTALL_LOG       4420
        #define IDD_ADVANCED_MANUAL_UPDATE          4430
        #define IDD_ADVANCED_PROXY_FLAG             4440
        #define IDD_ADVANCED_PROXY_SERVER           4450
        #define IDD_ADVANCED_PROXY_PORT             4460
        
    // Selfupdate box...
    #define IDD_LOCAL_VERSION                       4500
    #define IDD_AVAILABLE_VERSION                   4510
    #define IDD_UPDATE_COMMENTS                     4520

// Misc...
#define ID_TIMER                                    4600
#define ID_LOGOBOX                                  4610
