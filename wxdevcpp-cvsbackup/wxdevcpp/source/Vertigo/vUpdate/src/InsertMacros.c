/*
   Name: InsertMacros() (function)
   Author: Kip Warner
   Description: Take a string and replace macro tag with macro data...
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

// Check pszBuffer for macro. Insert if need be...
char *InsertMacro(char *pszBuffer, vUpdateOptions *options)
{
    // Variables...
    static  char    szFixedMacro[128]   = "\x0";
    char            *pszTemp            = NULL;
    char            szTemp[128];
    char            szMacro[128];
    
    // Copy their string into our workspace...
    strcpy(szFixedMacro, pszBuffer);
    
    // $ROOT...
    pszTemp = strstr(szFixedMacro, "$ROOT");
    if(pszTemp)
    {
        // Go grab the macro they requested...
        strcpy(szMacro, options->szRootPath);
        
        // Remove trailing '\' if there is one...
        if(szMacro[strlen(szMacro)-1] == '\\')
            szMacro[strlen(szMacro) -1]     = '\x0';
        
        // Copy whatever is past the macro into temp...
        strcpy(szTemp, pszTemp + strlen("$ROOT"));
        
        // Append a '\' if there isn't one to the end of their string...
        if(szTemp[strlen(szTemp) - 1] != '\\')
            strcat(szTemp, "\\");
        
        // Replace with the macro...
        strcpy(pszTemp, szMacro);
        
        // Copy back whatever was after the macro originaly...
        strcpy(pszTemp + strlen(szMacro), szTemp);

        return szFixedMacro;
    }
    
    // $BIN...
    pszTemp = strstr(szFixedMacro, "$BIN");
    if(pszTemp)
    {
        // Go grab the macro they requested...
        strcpy(szMacro, options->szBinPath);
        
        // Remove trailing '\' if there is one...
        if(szMacro[strlen(szMacro)-1] == '\\')
            szMacro[strlen(szMacro) -1]     = '\x0';
        
        // Copy whatever is past the macro into temp...
        strcpy(szTemp, pszTemp + strlen("$BIN"));
        
        // Append a '\' if there isn't one to the end of their string...
        if(szTemp[strlen(szTemp) - 1] != '\\')
            strcat(szTemp, "\\");
        
        // Replace with the macro...
        strcpy(pszTemp, szMacro);
        
        // Copy back whatever was after the macro originaly...
        strcpy(pszTemp + strlen(szMacro), szTemp);

        return szFixedMacro;
    }

    // $HELP...
    pszTemp = strstr(szFixedMacro, "$HELP");
    if(pszTemp)
    {
        // Go grab the macro they requested...
        strcpy(szMacro, options->szHelpPath);
        
        // Remove trailing '\' if there is one...
        if(szMacro[strlen(szMacro)-1] == '\\')
            szMacro[strlen(szMacro) -1]     = '\x0';
        
        // Copy whatever is past the macro into temp...
        strcpy(szTemp, pszTemp + strlen("$HELP"));
        
        // Append a '\' if there isn't one to the end of their string...
        if(szTemp[strlen(szTemp) - 1] != '\\')
            strcat(szTemp, "\\");
        
        // Replace with the macro...
        strcpy(pszTemp, szMacro);
        
        // Copy back whatever was after the macro originaly...
        strcpy(pszTemp + strlen(szMacro), szTemp);

        return szFixedMacro;
    }

    // $ICONS...
    pszTemp = strstr(szFixedMacro, "$ICONS");
    if(pszTemp)
    {
        // Go grab the macro they requested...
        strcpy(szMacro, options->szIconsPath);
        
        // Remove trailing '\' if there is one...
        if(szMacro[strlen(szMacro)-1] == '\\')
            szMacro[strlen(szMacro) -1]     = '\x0';
        
        // Copy whatever is past the macro into temp...
        strcpy(szTemp, pszTemp + strlen("$ICONS"));
        
        // Append a '\' if there isn't one to the end of their string...
        if(szTemp[strlen(szTemp) - 1] != '\\')
            strcat(szTemp, "\\");
        
        // Replace with the macro...
        strcpy(pszTemp, szMacro);
        
        // Copy back whatever was after the macro originaly...
        strcpy(pszTemp + strlen(szMacro), szTemp);

        return szFixedMacro;
    }
    
    // $INCLUDE...
    pszTemp = strstr(szFixedMacro, "$INCLUDE");
    if(pszTemp)
    {
        // Go grab the macro they requested...
        strcpy(szMacro, options->szIncludePath);
        
        // Remove trailing '\' if there is one...
        if(szMacro[strlen(szMacro)-1] == '\\')
            szMacro[strlen(szMacro) -1]     = '\x0';
        
        // Copy whatever is past the macro into temp...
        strcpy(szTemp, pszTemp + strlen("$INCLUDE"));
        
        // Append a '\' if there isn't one to the end of their string...
        if(szTemp[strlen(szTemp) - 1] != '\\')
            strcat(szTemp, "\\");
        
        // Replace with the macro...
        strcpy(pszTemp, szMacro);
        
        // Copy back whatever was after the macro originaly...
        strcpy(pszTemp + strlen(szMacro), szTemp);

        return szFixedMacro;
    }

    // $LIB...
    pszTemp = strstr(szFixedMacro, "$LIB");
    if(pszTemp)
    {
        // Go grab the macro they requested...
        strcpy(szMacro, options->szLibPath);
        
        // Remove trailing '\' if there is one...
        if(szMacro[strlen(szMacro)-1] == '\\')
            szMacro[strlen(szMacro) -1]     = '\x0';
        
        // Copy whatever is past the macro into temp...
        strcpy(szTemp, pszTemp + strlen("$LIB"));
        
        // Append a '\' if there isn't one to the end of their string...
        if(szTemp[strlen(szTemp) - 1] != '\\')
            strcat(szTemp, "\\");
        
        // Replace with the macro...
        strcpy(pszTemp, szMacro);
        
        // Copy back whatever was after the macro originaly...
        strcpy(pszTemp + strlen(szMacro), szTemp);

        return szFixedMacro;
    }
    
    // $LANG...
    pszTemp = strstr(szFixedMacro, "$LANG");
    if(pszTemp)
    {
        // Go grab the macro they requested...
        strcpy(szMacro, options->szLangPath);
        
        // Remove trailing '\' if there is one...
        if(szMacro[strlen(szMacro)-1] == '\\')
            szMacro[strlen(szMacro) -1]     = '\x0';
        
        // Copy whatever is past the macro into temp...
        strcpy(szTemp, pszTemp + strlen("$LANG"));
        
        // Append a '\' if there isn't one to the end of their string...
        if(szTemp[strlen(szTemp) - 1] != '\\')
            strcat(szTemp, "\\");
        
        // Replace with the macro...
        strcpy(pszTemp, szMacro);
        
        // Copy back whatever was after the macro originaly...
        strcpy(pszTemp + strlen(szMacro), szTemp);

        return szFixedMacro;
    }
    
    // $TEMPLATES...
    pszTemp = strstr(szFixedMacro, "$TEMPLATES");
    if(pszTemp)
    {
        // Go grab the macro they requested...
        strcpy(szMacro, options->szTemplatesPath);
        
        // Remove trailing '\' if there is one...
        if(szMacro[strlen(szMacro)-1] == '\\')
            szMacro[strlen(szMacro) -1]     = '\x0';
        
        // Copy whatever is past the macro into temp...
        strcpy(szTemp, pszTemp + strlen("$TEMPLATES"));
        
        // Append a '\' if there isn't one to the end of their string...
        if(szTemp[strlen(szTemp) - 1] != '\\')
            strcat(szTemp, "\\");
        
        // Replace with the macro...
        strcpy(pszTemp, szMacro);
        
        // Copy back whatever was after the macro originaly...
        strcpy(pszTemp + strlen(szMacro), szTemp);

        return szFixedMacro;
    }
    
    // $TEMP...
    pszTemp = strstr(szFixedMacro, "$TEMP");
    if(pszTemp)
    {
        // Go grab the macro they requested...
        strcpy(szMacro, options->szTempPath);
        
        // Remove trailing '\' if there is one...
        if(szMacro[strlen(szMacro)-1] == '\\')
            szMacro[strlen(szMacro) -1]     = '\x0';
        
        // Copy whatever is past the macro into temp...
        strcpy(szTemp, pszTemp + strlen("$TEMP"));
        
        // Append a '\' if there isn't one to the end of their string...
        if(szTemp[strlen(szTemp) - 1] != '\\')
            strcat(szTemp, "\\");
        
        // Replace with the macro...
        strcpy(pszTemp, szMacro);
        
        // Copy back whatever was after the macro originaly...
        strcpy(pszTemp + strlen(szMacro), szTemp);

        return szFixedMacro;
    }

    // $THEMES...
    pszTemp = strstr(szFixedMacro, "$THEMES");
    if(pszTemp)
    {
        // Go grab the macro they requested...
        strcpy(szMacro, options->szThemesPath);
        
        // Remove trailing '\' if there is one...
        if(szMacro[strlen(szMacro)-1] == '\\')
            szMacro[strlen(szMacro) -1]     = '\x0';
        
        // Copy whatever is past the macro into temp...
        strcpy(szTemp, pszTemp + strlen("$THEMES"));
        
        // Append a '\' if there isn't one to the end of their string...
        if(szTemp[strlen(szTemp) - 1] != '\\')
            strcat(szTemp, "\\");
        
        // Replace with the macro...
        strcpy(pszTemp, szMacro);
        
        // Copy back whatever was after the macro originaly...
        strcpy(pszTemp + strlen(szMacro), szTemp);

        return szFixedMacro;
    }

    // No macros, return what was passed...
    return szFixedMacro;
}
