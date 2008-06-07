//---------------------------------------------------------------------------
//
// Name:        InstallDevPak.cpp
// Author:      Tony Reina / Edward Toovey (Sof.T)
// Created:     05/06/2008 11:23:34 PM
// Description: DevPak Installation Code.
//     These functions are used to un-bzip, un-tar a Dev-Cpp devpak
//      and install it.
//---------------------------------------------------------------------------


#include "InstallDevPak.h"

bool InstallDevPak::GetPackageInfo(DevPakInfo *info, wxString szFileName)
{
    // Procedure
    // =========
    // 1. Prompt for devpak file to install
    // 2. Extract the devpak INI descriptor
    // 3. Parse the INI descriptor for the files/directories to install

    wxFileName filename(szFileName);

    // wxFileName filename(wxFileSelector(wxT("Choose a devpak to open"),"","","", wxT("All supported package formats (*.DevPak) |*.devpak|All files (*.*)|*.*")));
    if ( filename.FileExists() )
    {
        // work with the file
        wxString archiveDir = filename.GetPath();

        // Get a temporary directory
        ::wxSetWorkingDirectory(wxStandardPaths::Get().GetTempDir());

        wxString szINIFileName;

        if (!InstallDevPak::ExtractPackageINI(filename.GetFullPath())) {
            wxMessageBox("No *.DevPackage file found. DevPak format incorrect or corrupted.");
            return false;
        }

        filename.SetExt("devpackage");  // Grab the devpackage descriptor file
        if (!InstallDevPak::GetINIFileList(filename.GetFullName(), info)) // Grabs the files
            return false;

        if (!InstallDevPak::ProcessDirs(archiveDir, info))
            return false;

    }
    return true;

}

// Devpak installation main code starts here
bool InstallDevPak::DoSilentInstall(wxFileName filename)
{
    // Procedure
    // =========
    // 1. Prompt for devpak file to install
    // 2. Extract the devpak INI descriptor
    // 3. Parse the INI descriptor for the files/directories to install
    // 4. Replace any macros in the directory names
    // 5. Extract the files/directories from the devpak archive

    // wxFileName filename(wxFileSelector(wxT("Choose a devpak to open"),"","","", wxT("All supported package formats (*.DevPak) |*.devpak|All files (*.*)|*.*")));
    if ( filename.FileExists() )
    {
        // work with the file
        wxString archiveDir = filename.GetPath();

        // Get a temporary directory
        ::wxSetWorkingDirectory(wxStandardPaths::Get().GetTempDir());

        wxString szINIFileName;

        if (!InstallDevPak::ExtractPackageINI(filename.GetFullPath())) {
            wxMessageBox("No *.DevPackage file found. DevPak format incorrect or corrupted.");
            return false;
        }

        DevPakInfo info;

        filename.SetExt("devpackage");  // Grab the devpackage descriptor file
        if (!InstallDevPak::GetINIFileList(filename.GetFullName(), &info)) // Grabs the files
            return false;

        if (!InstallDevPak::ProcessDirs(archiveDir, &info))
            return false;

        filename.SetExt("DevPak");

        if (!InstallDevPak::ExtractArchive(filename.GetFullPath(), info))
            return false;

    }
    return true;
}

// Extract the devpak INI file descriptor
bool InstallDevPak::ExtractPackageINI(const wxString sArchive)
{
    // This code takes a tar'd, bzip2'd archive named sArchive
    // (*.tar.bz2) and
    // uncompresses it to a stream, then writes the devpak
    // configuration ini file (*.DevPackage)
    // to the current working directory.
    // You'll need to include the wxBZipInputstream and
    // the wxTarInputStream stuff:
    // #include <wx/filename.h>
    // #include <wx/filesys.h>
    // #include <wx/tarstrm.h>
    //#include <wx/wfstream.h>
    // #include <3rdparty/wx/bzipstream.h>
    //
    // * Code below is modified from a wxHatch code snippet *

    bool bFoundINI = false;
    wxFileSystem fs;
    std::auto_ptr<wxTarEntry> entry(new wxTarEntry);

    wxFileInputStream in(sArchive);
    if (!in)
    {
        wxMessageBox(wxT("Can''t find input archive file: ") + sArchive);
        return false;
    }

    wxBZipInputStream bzip2In(in);   // Un-bzip the stream
    wxTarInputStream TarInStream(bzip2In);  // Un-tar the bzip2In stream

    while ((entry.reset(TarInStream.GetNextEntry()), entry.get() != NULL) &&
            (!bFoundINI) )
    {

        // access meta-data from tar archive
        wxString sFile = entry->GetName();

        if (!wxFileName::IsCaseSensitive() ) sFile.MakeLower();

        wxString sDir = sFile.BeforeLast(wxFILE_SEP_PATH);  // Get directory name
        wxString sFilenme = sFile.AfterLast(wxFILE_SEP_PATH); // Get file name

        if (sFilenme.Matches(wxT("*.devpackage")))
        {

            wxFile anOutFile ;
            int fileMode = wxS_DEFAULT ;
#ifndef __WXMSW__
            int iMode = entry->GetMode();
            if ( iMode & 0700 ) fileMode = fileMode |  wxS_IXUSR ;
#endif
            anOutFile.Create(sFile, TRUE /*overwrite any existing file*/, fileMode);

            wxFileOutputStream outfile ( anOutFile );
            if (!outfile.IsOk())
            {
                wxMessageBox(wxT("Extracting ") + sFile + wxT(" failed : Disk full? Permissions?"));
                return false;
            }

            outfile.Write (TarInStream);
            if (outfile.GetLastError() == wxSTREAM_WRITE_ERROR)
            {
                wxMessageBox(wxT("Extracting ") + sFile + wxT(" failed : Disk full? Permissions?"));
                return false;
            }

            bFoundINI = true;

        }
    } //end of while

    return bFoundINI;
}

// Parse the devpak ini file descriptor for the file and directories to extract/install
bool InstallDevPak::GetINIFileList(wxString INIFileName, DevPakInfo *info)
{

    if ( !wxFileName::FileExists( INIFileName ) )
    {
        wxMessageBox(wxT("Can't find DevPackage file: " + INIFileName));
        return false;
    }

    wxTextFile fIni, fEntry;
    wxString szLine, szTarget, szDestination;
    wxString EntryFileName;

    fIni.Open(INIFileName); // Open the INI file

    if (fIni.GetFirstLine() != "[Setup]") {
        while ((!fIni.Eof()) && (fIni.GetNextLine() != "[Setup]")); // Loop through file until you encounter EOF or [Setup]
    }

    if (fIni.GetLine(fIni.GetCurrentLine()) != "[Setup]") {
        wxMessageBox("Error: [Setup] section not found in " + INIFileName);
        return false;
    }

    // Create the entry file (or replace it if it exists)
    EntryFileName = InstallDevPak::GetEntryFileName(INIFileName);

    if ( wxFileName::FileExists( EntryFileName ) )
    {
        fEntry.Open(EntryFileName);
        fEntry.Clear(); // Delete all lines in the .entry file
    }
    else
        fEntry.Create(EntryFileName);

    fEntry.AddLine("[Setup]");

    wxString junk;  // Placeholder for matching strings
    while ((!fIni.Eof()) && (fIni.GetNextLine() != "[Files]")) // Loop through file until you encounter EOF or [Files]
    {
        if (fIni.GetLine(fIni.GetCurrentLine()).StartsWith("AppName=", &junk)) {
            fEntry.AddLine(fIni.GetLine(fIni.GetCurrentLine()));
            info->AppName = fIni.GetLine(fIni.GetCurrentLine()).AfterLast('=');
        }

        if (fIni.GetLine(fIni.GetCurrentLine()).StartsWith("AppVersion=", &junk)) {
            fEntry.AddLine(fIni.GetLine(fIni.GetCurrentLine()));
            info->AppVersion = fIni.GetLine(fIni.GetCurrentLine()).AfterLast('=');
        }

        if (fIni.GetLine(fIni.GetCurrentLine()).StartsWith("Description=", &junk)) {
            fEntry.AddLine(fIni.GetLine(fIni.GetCurrentLine()));
            info->Description = fIni.GetLine(fIni.GetCurrentLine()).AfterLast('=');
        }

        if (fIni.GetLine(fIni.GetCurrentLine()).StartsWith("Url=", &junk)) {
            fEntry.AddLine(fIni.GetLine(fIni.GetCurrentLine()));
            info->Url = fIni.GetLine(fIni.GetCurrentLine()).AfterLast('=');
        }

        if (fIni.GetLine(fIni.GetCurrentLine()).StartsWith("Readme=", &junk)) {
            info->Readme = fIni.GetLine(fIni.GetCurrentLine()).AfterLast('=');
        }

        if (fIni.GetLine(fIni.GetCurrentLine()).StartsWith("License=", &junk)) {
            info->License = fIni.GetLine(fIni.GetCurrentLine()).AfterLast('=');
        }

    }

    if (fIni.GetLine(fIni.GetCurrentLine()) != "[Files]") {
        wxMessageBox("Error: [Files] section not found in " + INIFileName);
        return false;
    }

    if (!fIni.Eof())
        szLine = fIni.GetNextLine();
    // Now go through the file section called [Files] until we either Eof or reach another section
    while ( (!fIni.Eof()) && ( !szLine.Trim(false).Trim(true).Matches("[*]") ) ) {

        szTarget = szLine.BeforeFirst('=');
        szDestination = szLine.AfterFirst('=');

        // Grab the target and destination directories
        // target = directory name within devpak archive
        // destination = directory name to extract to during install
        if ((!szTarget.IsEmpty()) && (!szDestination.IsEmpty())) {
            info->TargetDirs.Add(szTarget);         // Add the source directory to the list
            info->DestinationDirs.Add(szDestination);    // Add the destination directory to the list
        }

        szLine = fIni.GetNextLine();

    }

    fIni.Close();  // Close the INI file

    fEntry.AddLine("");
    fEntry.AddLine("[Files]");
    fEntry.Write();  // Commit the .entry file changes
    fEntry.Close();  // Close the .entry file

    return true;

}


bool InstallDevPak::ReadEntryFile(wxString EntryFileName, DevPakInfo *info)
{
    wxTextFile fIni;

    if ( wxFileName::FileExists( EntryFileName ) )
        fIni.Open(EntryFileName);
    else {
        wxMessageBox(wxT("Error: Entry file ") + EntryFileName + wxT(" does not exist."));
        return false;
    }

    info->EntryFileName = EntryFileName;

    if (fIni.GetFirstLine() != "[Setup]") {
        while ((!fIni.Eof()) && (fIni.GetNextLine() != "[Setup]")); // Loop through file until you encounter EOF or [Setup]
    }

    if (fIni.GetLine(fIni.GetCurrentLine()) != "[Setup]") {
        wxMessageBox("Error: [Setup] section not found in " + EntryFileName);
        return false;
    }

    wxString junk;  // Placeholder for matching strings
    while ((!fIni.Eof()) && (fIni.GetNextLine() != "[Files]")) // Loop through file until you encounter EOF or [Files]
    {
        if (fIni.GetLine(fIni.GetCurrentLine()).StartsWith("AppName=", &junk)) {
            info->AppName = fIni.GetLine(fIni.GetCurrentLine()).AfterLast('=');
        }

        if (fIni.GetLine(fIni.GetCurrentLine()).StartsWith("AppVersion=", &junk)) {
            info->AppVersion = fIni.GetLine(fIni.GetCurrentLine()).AfterLast('=');
        }

        if (fIni.GetLine(fIni.GetCurrentLine()).StartsWith("Description=", &junk)) {
            info->Description = fIni.GetLine(fIni.GetCurrentLine()).AfterLast('=');
        }

        if (fIni.GetLine(fIni.GetCurrentLine()).StartsWith("Url=", &junk)) {
            info->Url = fIni.GetLine(fIni.GetCurrentLine()).AfterLast('=');
        }

        if (fIni.GetLine(fIni.GetCurrentLine()).StartsWith("Readme=", &junk)) {
            info->Readme = fIni.GetLine(fIni.GetCurrentLine()).AfterLast('=');
        }

        if (fIni.GetLine(fIni.GetCurrentLine()).StartsWith("License=", &junk)) {
            info->License = fIni.GetLine(fIni.GetCurrentLine()).AfterLast('=');
        }

    }

    info->InstalledFiles.Clear();

    if (fIni.GetLine(fIni.GetCurrentLine()) == "[Files]") {

        fIni.GetNextLine();

        while (!fIni.Eof())
        {

            info->InstalledFiles.Add(fIni.GetLine(fIni.GetCurrentLine()));
            fIni.GetNextLine();
        }
    }
    fIni.Close();
    return true;

}

// Determine the name of the .entry file
wxString InstallDevPak::GetEntryFileName(wxString INIFileName)
{
    wxFileName EntryFileName(InstallDevPak::GetAppDir() + "//Packages//" + INIFileName);
    EntryFileName.SetExt("entry");

    return EntryFileName.GetFullPath();

}

// Grab the name of the Dev-Cpp install directory from the
//    Windows registry.
wxString InstallDevPak::GetAppDir()
{
    // Grab install directory from Windows Registry
    wxRegKey *pRegKey = new wxRegKey("HKEY_LOCAL_MACHINE\\SOFTWARE\\wx-devcpp");
    wxString strInstallDir = "none";

    if (!pRegKey->Exists())
        return strInstallDir;

    if (!pRegKey->QueryValue("Install_Dir", strInstallDir)) {
        delete pRegKey;
        return strInstallDir;
    }
    else
        delete pRegKey;

    return strInstallDir;

}

// Replace all of the macros in the directory names
bool InstallDevPak::ProcessDirs(wxString archiveDir, DevPakInfo *info)
{
    // Get the <app> directory from the Windows registry entry
    wxString strInstallDir = InstallDevPak::GetAppDir();
    if (strInstallDir == "none")
        return false;  // No <app> entry in Windows registry

    // Replace any macros in the directory names
    for (size_t ii = 0; ii < info->TargetDirs.GetCount(); ii++) {

        info->TargetDirs.Item(ii).Replace("<app>", strInstallDir, true);
        info->TargetDirs.Item(ii).Replace("<win>", ::wxGetOSDirectory(), true);
        info->TargetDirs.Item(ii).Replace("<sys>", ::wxGetOSDirectory() + wxFILE_SEP_PATH + wxT("system"), true);
        info->TargetDirs.Item(ii).Replace("<src>", archiveDir, true);

        info->DestinationDirs.Item(ii).Replace("<app>", strInstallDir, true);
        info->DestinationDirs.Item(ii).Replace("<win>", ::wxGetOSDirectory(), true);
        info->DestinationDirs.Item(ii).Replace("<sys>", ::wxGetOSDirectory() + wxFILE_SEP_PATH + wxT("system"), true);
        info->DestinationDirs.Item(ii).Replace("<src>", archiveDir, true);

    }

    return true;

}

// Extract the files/directories from the devpak archive
bool InstallDevPak::ExtractArchive(const wxString sArchive, DevPakInfo info, wxListBox *lbInstalledFiles)
{

    wxSortedArrayString aDirs ;
    bool bPromptOnDirExists=false, bExtractDirectory = false;
    wxString sDir = wxGetCwd();
    wxString EntryFileName = InstallDevPak::GetEntryFileName(sArchive);

    wxTextFile fEntry;

    wxFileSystem fs;
    std::auto_ptr<wxTarEntry> entry(new wxTarEntry);

    // All of the installed files are logged into the .entry file
    if ( !wxFileName::FileExists( EntryFileName ) )
    {
        wxMessageBox(wxT("ERROR: Entry file " + EntryFileName + " does not exists."));
        return false;
    }
    else {
        fEntry.Open(EntryFileName);  // Open the entry file
    }

    wxFileInputStream in(sArchive);
    if (!in)
    {
        wxMessageBox(wxT("Can''t find input archive file: ") + sArchive);
        return false;
    }

    wxBZipInputStream bzip2In(in);   // Un-bzip the stream
    wxTarInputStream TarInStream(bzip2In);  // Un-tar the bzip2In stream

    while ( (entry.reset(TarInStream.GetNextEntry()), entry.get() != NULL) )
    {
        // Get the filename/directory for this entry in the devpak archive
        wxString sFile = entry->GetName();

// If it ends with a \ in the devpak, then it's a directory to unpack
        wxString s2File = sFile;
        if (s2File.Last() == '\\')
            s2File.RemoveLast();

        // Search our list of targets for this filename
        int sourceIndex = info.TargetDirs.Index(s2File);

        if ((sourceIndex != wxNOT_FOUND) || bExtractDirectory) {
            if (sourceIndex != wxNOT_FOUND) {
                bExtractDirectory = false;

                // sourceIndex holds the destination directory
                sDir = info.DestinationDirs.Item(sourceIndex);
            }

            if (!wxFileName::IsCaseSensitive() ) sFile.MakeLower();

            wxString sFilenme = sFile.AfterLast(wxFILE_SEP_PATH); // Get file name

            if (entry->IsDir()) // Is the entry a directory?
            {
                // Just set boolean flag so that we can extract all of the
                // files from this directory within the devpak archive in the
                // subsequent loops
                bExtractDirectory = true;
            }
            else    // Entry is a file
            {

                if (aDirs.Index(sDir) == wxNOT_FOUND )  // Has the directory been previously created?
                {
                    // a new dir
                    aDirs.Add( sDir );
                    bool bDirExists = wxDirExists(sDir);

                    // Do we want to overwrite files if they exist?
                    if ( (bPromptOnDirExists) && (bDirExists) )
                    {

                        if ( wxMessageBox(wxT("Files already exist in this directory:\n" + sDir + "\nDo you want to overwrite them?"), wxT("Please confirm"),
                                          wxICON_QUESTION | wxYES_NO) == wxNO )
                        {
                            // answer was no
                            wxMessageBox(wxT("Extraction of ") + sArchive + wxT( " to " ) + sDir + wxT(" cancelled (files already exist)"));
                            return false;
                        }
                        bDirExists = false;
                    }

                    // Create the new directory and
                    //prevent logging of creating existing dirs
                    wxLogNull logNo;
                    int perm = entry->GetMode();
                    wxFileName::Mkdir(sDir, perm, wxPATH_MKDIR_FULL);

                }

                // Ok, now create the output file
                wxFile anOutFile ;
                int fileMode = wxS_DEFAULT ;
#ifndef __WXMSW__
                int iMode = entry->GetMode();
                if ( iMode & 0700 ) fileMode = fileMode |  wxS_IXUSR ;
#endif


                wxString sFilenme = sFile.AfterLast(wxFILE_SEP_PATH); // Get file name
                anOutFile.Create(sDir + sFilenme, TRUE /*overwrite any existing file*/, fileMode);

                wxString relativeDir;
                sDir.StartsWith(InstallDevPak::GetAppDir() + "\\", &relativeDir);
                fEntry.AddLine(relativeDir + sFilenme); //Add the file to the entry file

                lbInstalledFiles->Append(relativeDir + sFilenme);
                ::wxSafeYield();

                wxFileOutputStream outfile ( anOutFile );
                if (!outfile.IsOk())
                {
                    wxMessageBox(wxT("Extracting ") + sFile + wxT(" failed : Disk full? Permissions?"));
                    return false;
                }

                // Now write the unzipped, untarred archive file to the outfile
                outfile.Write (TarInStream);
                if (outfile.GetLastError() == wxSTREAM_WRITE_ERROR)
                {
                    wxMessageBox(wxT("Extracting ") + sFile + wxT(" failed : Disk full? Permissions?"));
                    return false;
                }
            }
        }
    } //end of while

    fEntry.Write(); //Commit the entry file
    fEntry.Close();

    return true;

}

// Extract the files/directories from the devpak archive
bool InstallDevPak::ExtractArchive(const wxString sArchive, DevPakInfo info)
{

    wxSortedArrayString aDirs ;
    bool bPromptOnDirExists=false, bExtractDirectory = false;
    wxString sDir = wxGetCwd();
    wxString EntryFileName = InstallDevPak::GetEntryFileName(sArchive);

    wxTextFile fEntry;

    wxFileSystem fs;
    std::auto_ptr<wxTarEntry> entry(new wxTarEntry);

    // All of the installed files are logged into the .entry file
    if ( !wxFileName::FileExists( EntryFileName ) )
    {
        wxMessageBox(wxT("ERROR: Entry file " + EntryFileName + " does not exists."));
        return false;
    }
    else {
        fEntry.Open(EntryFileName);  // Open the entry file
    }

    wxFileInputStream in(sArchive);
    if (!in)
    {
        wxMessageBox(wxT("Can''t find input archive file: ") + sArchive);
        return false;
    }

    wxBZipInputStream bzip2In(in);   // Un-bzip the stream
    wxTarInputStream TarInStream(bzip2In);  // Un-tar the bzip2In stream

    while ( (entry.reset(TarInStream.GetNextEntry()), entry.get() != NULL) )
    {
        // Get the filename/directory for this entry in the devpak archive
        wxString sFile = entry->GetName();

// If it ends with a \ in the devpak, then it's a directory to unpack
        wxString s2File = sFile;
        if (s2File.Last() == '\\')
            s2File.RemoveLast();

        // Search our list of targets for this filename
        int sourceIndex = info.TargetDirs.Index(s2File);

        if ((sourceIndex != wxNOT_FOUND) || bExtractDirectory) {
            if (sourceIndex != wxNOT_FOUND) {
                bExtractDirectory = false;

                // sourceIndex holds the destination directory
                sDir = info.DestinationDirs.Item(sourceIndex + 1);
            }

            if (!wxFileName::IsCaseSensitive() ) sFile.MakeLower();

            wxString sFilenme = sFile.AfterLast(wxFILE_SEP_PATH); // Get file name

            if (entry->IsDir()) // Is the entry a directory?
            {
                // Just set boolean flag so that we can extract all of the
                // files from this directory within the devpak archive in the
                // subsequent loops
                bExtractDirectory = true;
            }
            else    // Entry is a file
            {

                if (aDirs.Index(sDir) == wxNOT_FOUND )  // Has the directory been previously created?
                {
                    // a new dir
                    aDirs.Add( sDir );
                    bool bDirExists = wxDirExists(sDir);

                    // Do we want to overwrite files if they exist?
                    if ( (bPromptOnDirExists) && (bDirExists) )
                    {

                        if ( wxMessageBox(wxT("Files already exist in this directory:\n" + sDir + "\nDo you want to overwrite them?"), wxT("Please confirm"),
                                          wxICON_QUESTION | wxYES_NO) == wxNO )
                        {
                            // answer was no
                            wxMessageBox(wxT("Extraction of ") + sArchive + wxT( " to " ) + sDir + wxT(" cancelled (files already exist)"));
                            return false;
                        }
                        bDirExists = false;
                    }

                    // Create the new directory and
                    //prevent logging of creating existing dirs
                    wxLogNull logNo;
                    int perm = entry->GetMode();
                    wxFileName::Mkdir(sDir, perm, wxPATH_MKDIR_FULL);

                }

                // Ok, now create the output file
                wxFile anOutFile ;
                int fileMode = wxS_DEFAULT ;
#ifndef __WXMSW__
                int iMode = entry->GetMode();
                if ( iMode & 0700 ) fileMode = fileMode |  wxS_IXUSR ;
#endif


                wxString sFilenme = sFile.AfterLast(wxFILE_SEP_PATH); // Get file name
                anOutFile.Create(sDir + sFilenme, TRUE /*overwrite any existing file*/, fileMode);

                wxString relativeDir;
                sDir.StartsWith(InstallDevPak::GetAppDir() + "\\", &relativeDir);
                fEntry.AddLine(relativeDir + sFilenme); //Add the file to the entry file

                wxFileOutputStream outfile ( anOutFile );
                if (!outfile.IsOk())
                {
                    wxMessageBox(wxT("Extracting ") + sFile + wxT(" failed : Disk full? Permissions?"));
                    return false;
                }

                // Now write the unzipped, untarred archive file to the outfile
                outfile.Write (TarInStream);
                if (outfile.GetLastError() == wxSTREAM_WRITE_ERROR)
                {
                    wxMessageBox(wxT("Extracting ") + sFile + wxT(" failed : Disk full? Permissions?"));
                    return false;
                }
            }
        }
    } //end of while

    fEntry.Write(); //Commit the entry file
    fEntry.Close();

    return true;

}

// Extract a single from the devpak archive and pass the file's text to txtControl
bool InstallDevPak::ExtractSingleFile(const wxString sArchive, wxString sFileName, wxTextCtrl *txtControl)
{

    bool bPromptOnDirExists=false;
    wxString sDir = wxGetCwd();

    wxFileSystem fs;
    std::auto_ptr<wxTarEntry> entry(new wxTarEntry);

    wxFileInputStream in(sArchive);
    if (!in)
    {
        wxMessageBox(wxT("Can''t find input archive file: ") + sArchive);
        return false;
    }

    wxBZipInputStream bzip2In(in);   // Un-bzip the stream
    wxTarInputStream TarInStream(bzip2In);  // Un-tar the bzip2In stream

    while ( (entry.reset(TarInStream.GetNextEntry()), entry.get() != NULL) )
    {
        // Get the filename/directory for this entry in the devpak archive
        wxString sFile = entry->GetName();

// If it ends with a \ in the devpak, then it's a directory to unpack
        wxString s2File = sFile;
        if (s2File.Last() == '\\')
            s2File.RemoveLast();

        if (sFile == sFileName) {

            if (!wxFileName::IsCaseSensitive() ) sFile.MakeLower();

            wxString sFilenme = sFile.AfterLast(wxFILE_SEP_PATH); // Get file name

            if (!entry->IsDir()) // Is the entry a directory?

            {

                // a new dir
                bool bDirExists = wxDirExists(sDir);

                // Do we want to overwrite files if they exist?
                if ( (bPromptOnDirExists) && (bDirExists) )
                {

                    if ( wxMessageBox(wxT("Files already exist in this directory:\n" + sDir + "\nDo you want to overwrite them?"), wxT("Please confirm"),
                                      wxICON_QUESTION | wxYES_NO) == wxNO )
                    {
                        // answer was no
                        wxMessageBox(wxT("Extraction of ") + sArchive + wxT( " to " ) + sDir + wxT(" cancelled (files already exist)"));
                        return false;
                    }
                    bDirExists = false;
                }

                // Create the new directory and
                //prevent logging of creating existing dirs
                wxLogNull logNo;
                int perm = entry->GetMode();
                wxFileName::Mkdir(sDir, perm, wxPATH_MKDIR_FULL);


                // Ok, now create the output file
                wxFile anOutFile ;
                int fileMode = wxS_DEFAULT ;
#ifndef __WXMSW__
                int iMode = entry->GetMode();
                if ( iMode & 0700 ) fileMode = fileMode |  wxS_IXUSR ;
#endif


                wxString sFilenme = sFile.AfterLast(wxFILE_SEP_PATH); // Get file name

                anOutFile.Create(sDir + sFilenme, TRUE /*overwrite any existing file*/, fileMode);

                wxFileOutputStream outfile ( anOutFile );
                if (!outfile.IsOk())
                {
                    wxMessageBox(wxT("Extracting ") + sFile + wxT(" failed : Disk full? Permissions?"));
                    return false;
                }

                // Now write the unzipped, untarred archive file to the outfile
                outfile.Write (TarInStream);
                if (outfile.GetLastError() == wxSTREAM_WRITE_ERROR)
                {
                    wxMessageBox(wxT("Extracting ") + sFile + wxT(" failed : Disk full? Permissions?"));
                    return false;
                }
                txtControl->LoadFile(sDir + sFilenme);
            }
        }
    } //end of while

    return true;

}

// Delete/uninstall a devpak
bool InstallDevPak::RemoveDevPak(DevPakInfo info)
{

    wxMessageBox("Removing devpak: " + info.EntryFileName);
    for (size_t ii=0; info.InstalledFiles.GetCount(); ii++)
        ::wxRemoveFile(info.InstalledFiles.Item(ii));

    return true;

}


