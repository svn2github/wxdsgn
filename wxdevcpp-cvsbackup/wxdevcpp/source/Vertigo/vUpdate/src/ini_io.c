/*                         
    Name: ini_io (module)
    Author: Kip Warner
    Copyright: Yes
    Version: 2.3
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

// Write a field to pszFileName. Overwrites original value if already exists...
int ini_SetField(char *pszFileName, char *pszKey, char *pszField, char *pszData)
{
    // Variables...
    FILE    *hFile          = NULL;
    long     nBytes         = 0;
    char    szBuffer[4096];
    char    *pszFile        = NULL;
    char    szKey[4096];
    char    szNewLine[4096];
    char    *pszString      = NULL;

    
    // Open file...
    hFile = fopen(pszFileName, "r");
    
        // Error, probably doesn't exist...
        if(!hFile)
        {
            // Try to create...
            hFile = fopen(pszFileName, "w");
            
                // Still can't create, return...
                if(!hFile)
                    return INI_ERROR_CANNOT_OPEN;
        }
        
    // How many bytes are in here?...
    while(fgets(szBuffer, 4095, hFile))
        nBytes += strlen(szBuffer) + 1;

        nBytes -= 1;

        // Reset seek head...
        fseek(hFile, 0, SEEK_SET);

    // Allocate storage for entire file in memory plus some for inserted field / data...
    pszFile = (char *) malloc(nBytes + 4096);
    
        // Can't allocate...
        if(!pszFile)
        {
            fclose(hFile);
            return INI_ERROR_OUT_OF_MEMORY;
        }
            
    // Grab file and dump in memory...
    pszFile[0] = '\x0';
    sprintf(szKey, "[%s]", pszKey);
    while(fgets(szBuffer, 4095, hFile))
    {

        if((strncmp(szBuffer, pszField, strlen(pszField)) == 0) && !isalnum(szBuffer[strlen(pszField) + 1]))
            strcpy(szBuffer, "\x0");

        strcat(pszFile, szBuffer);
        if(strncmp(szBuffer, szKey, strlen(szKey)) == 0)
        {
            // Put on new line or already on a new line?...
            (pszFile[strlen(pszFile) - 1] == '\n') ? sprintf(szNewLine, "%s = \"%s\"\n", pszField, pszData)
                                                   : sprintf(szNewLine, "\n%s = \"%s\"\n", pszField, pszData);

            // Save changes...
            strcat(pszFile, szNewLine);
        }
    }
    fclose(hFile);

    // Does the key exist?...
    pszString = strstr(pszFile, szKey);

        // Dosen't exist...
        if(!pszString)
        {
            /*
            free(pszFile);
            return INI_ERROR_KEY_NOT_FOUND;
            */

            sprintf(szBuffer, "\n%s\n%s = \"%s\"\n", szKey, pszField, pszData);
            strcat(pszFile, szBuffer);
        }

    //puts(pszFile);

    // Re-write file...
    hFile = fopen(pszFileName, "w");
        
        // Can't open...
        if(!hFile)
        {
            free(pszFile);
            return INI_ERROR_CANNOT_WRITE;
        }
        
    fputs(pszFile, hFile);

    free(pszFile);
    fclose(hFile);
    return INI_ALL_GOOD;
}

// Get a field under pszKey names pszField and store in pszData...
int ini_GetField(char *pszFileName, char *pszKey, char *pszField, char *pszData)
{
    // Variables...
    FILE	*hFile				= NULL;
    long	nFileSize			= 0;
    int		nTotalLines			= 0;
    int     nLineError          = 0;
	char	szTemp[256];
	char	*pszTemp			= NULL;
	int		i					= 0;
	char	szLastKeyFound[64];
    char    szKeyList[4096]     = "\x0";

    // Initialize pszData...
    strcpy(pszData, "(uninitialized)");

    // Open file...
    hFile = fopen(pszFileName, "r");

    	// I/O Error...
    	if(!hFile)
    		return INI_ERROR_CANNOT_OPEN;
        
    // Calculate file size...
    fseek(hFile, 0, SEEK_END);
    nFileSize = ftell(hFile);
    
    // Emtpy file, oops...
    if(nFileSize == 0)
        return INI_ERROR_EMPTY_FILE;

    // Reset file and find out how many lines are in here...
    fseek(hFile, 0, SEEK_SET);
	while(fgets(szTemp, 256, hFile))
		nTotalLines++;

	// Reset read head...
	fseek(hFile, 0, SEEK_SET);

	// Allocate storage space...
    char (*fileLine)[4096] = (char(*)[4096]) malloc(sizeof(char *) * 4096 * nTotalLines);

	// Grab each line one at a time...
	for(i = 0; i < nTotalLines; i++, nLineError++)
	{
        // Get a line...
		fgets(fileLine[i], 4096, hFile);

        // They just want to know if the key exists, so just check to see if this line has it...
        if(strcmp(pszField, "INI_FIND_KEY") == 0)
        {
            sprintf(szTemp, "[%s]", pszKey);
            
            if(strncmp(fileLine[i], szTemp, strlen(szTemp)) == 0)
            {
                strcpy(pszData, "FOUND KEY");
                fclose(hFile);
                free(fileLine);
                return INI_ALL_GOOD;
            }
        }
  
		// Line is a new line, is commented out, ignore it...
		if((fileLine[i][0] == '\n') || (fileLine[i][0] == ';'))
		{
			// Decrement index so we copy over this string on next go...
			i--;

			// Empty lines and comments ignored...
			nTotalLines--;
            continue;
		}

        // This line that has stuff on it isn't a key or a field. Its invalid, ignore it..
        if((strocc(fileLine[i], "\"") != 2) && !strstr(fileLine[i], "["))
        {
            // Decrement index so we copy over this string on next go...
			i--;

			// Empty lines or comments don't count...
			nTotalLines--;
            continue;
        }
	}

	// Hunt for the field they requested. Go through each line..
	for(i = 0; i < nTotalLines; i++)
	{
		// We have found some key, remember this...
		if(strncmp(fileLine[i], "[", 1) == 0)
        {
            // Remember it...
			strcpy(szLastKeyFound, fileLine[i]);

            // Add it to the list...
            strcat(szKeyList, szLastKeyFound);
        }

		// We have found  the field, because the last key we found was also
		//  the one they specified...
		sprintf(szTemp, "[%s]", pszKey);
		if((strncmp(fileLine[i], pszField, strlen(pszField)) == 0) && 			// Check for field match &&
		   (strncmp(szLastKeyFound, szTemp, strlen(szTemp)) == 0)  &&           // Key match &&...
            (!isalnum(fileLine[i][strlen(pszField) + 1])))                      // Next char in field found is not another letter (end of field)...
 		{
            // Check for empty string...
            if(strstr(fileLine[i], "\"\""))
            {
                // Close stream...
                fclose(hFile);
                free(fileLine);
    			return INI_ERROR_FIELD_NOT_FOUND;
            }

			strtok(fileLine[i], "\"");
			pszTemp = strtok(NULL, "\"");

			strcpy(pszData, pszTemp);

            // Close stream...
            fclose(hFile);
            free(fileLine);
			return INI_ALL_GOOD;
 		}
	}

    // Close stream and return...
    fclose(hFile);
    free(fileLine);
    return INI_ERROR_FIELD_NOT_FOUND;
}
