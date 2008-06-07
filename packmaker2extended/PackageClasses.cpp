#include "PackageClasses.h"
#include <wx/arrimpl.cpp>
#include <wx/filename.h>
#include <wx/filefn.h>
#include <wx/wfstream.h>
#include <wx/tarstrm.h>
#include <wx/dir.h>
#include <wx/sstream.h>
#include <3rdparty/wx/bzipstream.h>

WX_DEFINE_OBJARRAY(FileInfoList);
WX_DEFINE_OBJARRAY(IconInfoList);

FileInfo::FileInfo()
{
    //Although the strings should be created empty make it explicit
    _SourceName = wxEmptyString;
    _DestinationDirectory = wxEmptyString;
    _DestinationName = wxEmptyString;
    _OptionalFlags = wxEmptyString;
}

FileInfo::~FileInfo()
{
}

IconInfo::IconInfo()
{
    //Although the strings should be created empty make it explicit
    _MenuEntryName = wxEmptyString;
    _MenuEntryTarget = wxEmptyString;
    _OptionalIcon = wxEmptyString;
}

IconInfo::~IconInfo()
{
}

DevPackage::DevPackage()
{
    Init();
}

DevPackage::DevPackage(wxFileConfig * PackageFile)
{
    Init();
    LoadFromPackageFile(PackageFile);
}

DevPackage::~DevPackage()
{
}

void DevPackage::Init()
{
    _PackageName = wxT("MyPackage");
    _PackageVersion = wxT("1.0");
    _PackageVersionName = _PackageName + wxT(" Version ") + _PackageVersion;
    _MenuName = wxEmptyString;
    _PackageDescription = wxEmptyString;
    _URL = wxEmptyString;
    _Readme = wxEmptyString;
    _LicenseText = wxEmptyString;
    _Picture = wxEmptyString;
    _Dependencies = wxEmptyString;
    _Reboot = false;
    _SupportExtendedFormat = false;
    _PackagerName = wxEmptyString;
    _PackagerEmail = wxEmptyString;
    _FileList.Clear();
    _IconList.Clear();
}

void DevPackage::LoadFromPackageFile(wxFileConfig * PackageFile, const wxString& FileName)
{    
    if(PackageFile)
    {
        //Clear the existing contents
        Clear();
        
        PackageFile->SetPath(SETUP_SECTION);
        _SupportExtendedFormat = !PackageFile->Read(wxT("SubVersion"), wxT("")).IsEmpty();
        _PackageName = PackageFile->Read(wxT("AppName"), wxT(""));
        _PackageVersionName = PackageFile->Read(wxT("AppVerName"), wxT(""));
        _PackageVersion = PackageFile->Read(wxT("AppVersion"), wxT(""));
        _MenuName = PackageFile->Read(wxT("MenuName"), wxT(""));

        _PackageDescription = PackageFile->Read(wxT("Description"), wxT(""));
        _URL = PackageFile->Read(wxT("Url"), wxT(""));
        _Readme = PackageFile->Read(wxT("Readme"), wxT(""));
        _LicenseText = PackageFile->Read(wxT("License"), wxT(""));
        _Picture = PackageFile->Read(wxT("Picture"), wxT(""));
        _Dependencies = PackageFile->Read(wxT("Dependencies"), wxT(""));
        PackageFile->Read(wxT("Reboot"), &_Reboot, false);
        
        if(_SupportExtendedFormat)
        {
            PackageFile->SetPath(EXTENDED_SETUP_SECTION);
            _PackagerName = PackageFile->Read(wxT("Packager"), wxT(""));
            _PackagerEmail = PackageFile->Read(wxT("Email"), wxT(""));
        }

        wxArrayString Files;
        wxString Str;
        long dummy;
        PackageFile->SetPath(FILES_SECTION);
        bool bCont = PackageFile->GetFirstEntry(Str, dummy);
        while ( bCont )
        {
            Files.Add(Str);

            bCont = PackageFile->GetNextEntry(Str, dummy);
        }

        for(size_t i = 0; i < Files.GetCount(); i++)
        {
            FileInfo TempFileInfo;
            TempFileInfo.SetSourceName(Files[i]);
            wxString TempString = PackageFile->Read(Files[i],wxT(""));
            //Set flag property to all characters after the first ';'
            TempFileInfo.SetOptionalFlags(TempString.AfterFirst(';'));
            wxFileName TempFileName(FileName);
            wxFileName TempSourceName(Files[i]);
            TempSourceName.MakeAbsolute(TempFileName.GetPath());
            //Check if the local file is a directory
            TempFileInfo.SetIsDirectory(wxDirExists(TempSourceName.GetFullPath()));
            //If it is a directory then set the destination name
            if(TempFileInfo.GetIsDirectory())
            {
                TempFileInfo.SetDestinationDirectory(TempString.BeforeFirst(';'));
            }
            //If it is not a directory see if we need to give it a different name
            else
            {
                wxString FileNameString = TempString;
                //Strip off the <..> macro
                FileNameString = FileNameString.AfterFirst('>');
                //String off the flags
                FileNameString = FileNameString.BeforeFirst(';');
                wxFileName DestFileName(FileNameString);
                TempFileInfo.SetDestinationName(DestFileName.GetFullName());
                TempFileInfo.SetDestinationDirectory(TempString.substr(0,TempString.Find(DestFileName.GetFullName())));
            }
            _FileList.Add(TempFileInfo);
        }


        PackageFile->SetPath(ICONS_SECTION);
        Files.Clear();
        bCont = PackageFile->GetFirstEntry(Str, dummy);
        while ( bCont )
        {
            Files.Add(Str);

            bCont = PackageFile->GetNextEntry(Str, dummy);
        }

        for(size_t i = 0; i < Files.GetCount(); i++)
        {
            IconInfo TempIconInfo;
            TempIconInfo.SetMenuEntryName(Files[i]);
            wxString TempString = PackageFile->Read(Files[i],wxT(""));
            TempIconInfo.SetMenuEntryTarget(TempString.BeforeLast(','));
            if(TempString.Find(',') != wxNOT_FOUND)
                TempIconInfo.SetOptionalIcon(TempString.AfterLast(','));
            _IconList.Add(TempIconInfo);
        }
    }
}

//This function is needed because the version of Packman that comes with Dev-C++
//fails when reading a config file without a new line at the start. So we can't
//just use wxFileConfig to write the file back
const wxString DevPackage::WritePackageFileToString()
{
    wxString TempString;

    TempString << wxT("\n[Setup]\n");
    TempString << wxT("Version=") << DEVPAK_VERSION << wxT("\n");
    if(_SupportExtendedFormat)
    {
        TempString << wxT("SubVersion=") << DEVPAK_SUBVERSION << wxT("\n");
    }
    TempString << wxT("AppName=") << _PackageName << wxT("\n");

    TempString << wxT("AppVerName=") << _PackageVersionName << wxT("\n");
    TempString << wxT("AppVersion=") << _PackageVersion << wxT("\n");
    TempString << wxT("MenuName=") << _MenuName << wxT("\n");

    TempString << wxT("Description=") << _PackageDescription << wxT("\n");
    TempString << wxT("Url=") << _URL << wxT("\n");
    TempString << wxT("Readme=") << _Readme << wxT("\n");
    TempString << wxT("License=") << _LicenseText << wxT("\n");
    TempString << wxT("Picture=") << _Picture << wxT("\n");
    TempString << wxT("Dependencies=") << _Dependencies << wxT("\n");
    TempString << wxT("Reboot=") << _Reboot << wxT("\n");


    if(_SupportExtendedFormat)
    {
        TempString << wxT("\n[ExtendedSetup]\n");
        TempString << wxT("Packager=") << _PackagerName << wxT("\n");
        TempString << wxT("Email=") << _PackagerEmail << wxT("\n");
        TempString << wxT("PathFormat=") << PATH_FORMAT << wxT("\n");
    }
        
    if(!_FileList.IsEmpty())
    {
        TempString << wxT("\n[Files]\n");

        for(size_t i = 0; i < _FileList.GetCount(); i++)
        {
            TempString << _FileList[i].GetSourceName() << wxT("=") << _FileList[i].GetDestinationDirectory() << _FileList[i].GetDestinationName();
            if(!_FileList[i].GetOptionalFlags().IsEmpty())
            {
                TempString << wxT(";") << _FileList[i].GetOptionalFlags();
            }
            TempString << wxT("\n");
        }
    }

    if(!_IconList.IsEmpty())
    {
        TempString << wxT("\n[Icons]\n");

        for(size_t i = 0; i < _IconList.GetCount(); i++)
        {
            TempString << _IconList[i].GetMenuEntryName() << _IconList[i].GetMenuEntryTarget();
            if(!_IconList[i].GetOptionalIcon().IsEmpty())
            {
                TempString << wxT(",") << _IconList[i].GetOptionalIcon();
            }
            TempString << wxT("\n");
        }
    }
    
    return TempString;
}

bool DevPackage::BuildPackage(const wxString& FileName, BuildForm * buildForm, bool Silent, bool LogErrors)
{
    bool RetVal = true;
    
    wxFileName TempFileName(FileName);
    const int BufferSize = 1024*32;

    //Make TAR
    TempFileName.SetExt(wxT("tar"));
    wxFileOutputStream out(TempFileName.GetFullPath());
    wxTarOutputStream TarStream(out);

    if(!Silent && buildForm)
    {
        buildForm->WxStaticBox1->SetLabel(wxT(" Building tar archive... "));
        buildForm->WxGauge1->SetRange((_FileList.GetCount() +1) *2);
        buildForm->WxGauge1->SetValue(1);
    }

    TempFileName.SetExt(wxT("DevPackage"));
    //Add the file name to tar.PutNextEntry
    TarStream.PutNextEntry(TempFileName.GetFullName());
    //Added to test
    wxStringInputStream TempInputStringStream(WritePackageFileToString());
    TarStream.Write(TempInputStringStream);
    //Send data into tar

    wxString TempCWD = wxGetCwd();
    {
        wxFileName TempFileName(FileName);
        wxSetWorkingDirectory(TempFileName.GetPath());
    }

    for(size_t i = 0; i < _FileList.GetCount();i++)
    {
        if(_FileList[i].GetIsDirectory())
        {
            wxArrayString sl;
            wxDir::GetAllFiles(_FileList[i].GetSourceName(),&sl);
            TarStream.PutNextDirEntry(_FileList[i].GetSourceName());
            wxString CurrentDir = _FileList[i].GetSourceName();
            for(size_t j = 0; j < sl.GetCount();j++)
            {
                if(wxDir::Exists(sl[j]))
                {
                    //Add the file name to tar.PutNextDirEntry
                    TarStream.PutNextDirEntry(sl[j]);
                }
                else
                {
                    wxFileName CurrentFileName(sl[j]);

                    wxFileInputStream InputFile(CurrentFileName.GetFullPath());
                    if(InputFile.IsOk())
                    {
                        //Add the file name to tar.PutNextEntry
                        TarStream.PutNextEntry(CurrentFileName.GetFullPath());
                        //Send data into tar
                        TarStream.Write(InputFile);
                    }
                }
            }
        }
        else
        {
            wxFileName CurrentFileName(_FileList[i].GetSourceName());

            wxFileInputStream InputFile(CurrentFileName.GetFullPath());
            if(InputFile.IsOk())
            {
                //Add the file name to zip.PutNextEntry
                TarStream.PutNextEntry(CurrentFileName.GetFullName());
                //Send data into zip;
                TarStream.Write(InputFile);
            }
        }
        if(!Silent && buildForm)
        {
            buildForm->WxGauge1->SetValue(buildForm->WxGauge1->GetValue() + 1);
        }
    }

    if(_Readme.IsEmpty())
    {
        wxFileName TempFileName(FileName);
        wxFileName TempSourceName(_Readme);
        TempSourceName.MakeAbsolute(TempFileName.GetPath());
        if(wxFileExists(TempSourceName.GetFullPath()))
        {
            wxFileInputStream InputFile(TempSourceName.GetFullPath());
            if(InputFile.IsOk())
            {
                //Add the file name to zip.PutNextEntry
                TarStream.PutNextEntry(TempSourceName.GetFullName());
                //Send data into zip;
                TarStream.Write(InputFile);
            }
        }
        else
        {
            if(!Silent)
            {
                if(wxMessageBox(wxT("Your readme file doesn't exist. Do you want to abort the creation of the package?"), wxT("File Error...") , wxICON_ERROR|wxYES|wxNO) == wxID_YES)
                    return false;
                else
                    RetVal = false;
            }
        }
    }

    if(_LicenseText.IsEmpty())
    {
        wxFileName TempFileName(FileName);
        wxFileName TempSourceName(_LicenseText);
        TempSourceName.MakeAbsolute(TempFileName.GetPath());
        if(wxFileExists(TempSourceName.GetFullPath()))
        {
            wxFileInputStream InputFile(TempSourceName.GetFullPath());
            if(InputFile.IsOk())
            {
                //Add the file name to zip.PutNextEntry
                TarStream.PutNextEntry(TempSourceName.GetFullName());
                //Send data into zip;
                TarStream.Write(InputFile);
            }
        }
        else
        {
            if(!Silent)
            {
                 if(wxMessageBox(wxT("Your license file doesn't exist. Do you want to abort the creation of the package?"), wxT("File Error...") , wxICON_ERROR|wxYES|wxNO) == wxID_YES)
                    return false;
                else
                    RetVal = false;
            }
        }
    }

    TarStream.Close();
    if(!out.Close())
    {
        if(!Silent)
        {
            wxMessageBox(wxT("Error closing the tar stream"));
            RetVal = false;
        }
    }

    // Make the Bzip2 file
    TempFileName.SetExt(wxT("DevPak"));
    wxFileOutputStream bzout(TempFileName.GetFullPath());
    wxBZipOutputStream bzfile(bzout,9);

    // Set the status in the UI
    if(!Silent && buildForm)
    {
        buildForm->WxStaticBox1->SetLabel(wxT(" Building Bzip2 archive... "));
        buildForm->WxGauge1->SetValue(buildForm->WxGauge1->GetValue() + 4);
    }

    TempFileName.SetExt(wxT("tar"));
    {
        wxFileInputStream InputFile(TempFileName.GetFullPath());
        wxTarInputStream TempTarStream(InputFile);
        if(!Silent && buildForm)
        {
            buildForm->WxGauge1->SetRange((InputFile.GetLength()/BufferSize)*2);
            buildForm->WxGauge1->SetValue((InputFile.GetLength()/BufferSize));
        }
        char Buffer[BufferSize];

        while(!InputFile.Eof())
        {
            InputFile.Read(Buffer,BufferSize);
            bzfile.Write(Buffer,InputFile.LastRead());
            if(!Silent && buildForm)
            {
                buildForm->WxGauge1->SetValue(buildForm->WxGauge1->GetValue()+1);
            }
        }
    }
    //Close bzfile file flushing remaining data
    bzfile.Close();
    bzout.Close();
    //Remove tar file
    if(!wxRemoveFile(TempFileName.GetFullPath()))
    {
        if(!Silent)
        {
            wxMessageBox(wxString(wxT("Couldn't remove temporary tar file named: ")) + TempFileName.GetFullPath());
            RetVal = false;
        }
    }
    // Sucess message
    if(!Silent)
    {
        TempFileName.SetExt(wxT("DevPak"));
        wxMessageBox(wxString(wxT("Your Dev-C++ Package has been successfully created to ")) +
        TempFileName.GetFullPath() + wxT(". It is now ready for testing and distribution."), wxT("Success"),
        wxICON_INFORMATION|wxOK);
    }
    return RetVal;
}

void DevPackage::AddFile(const wxString& DestinationDirectory, const wxString& DestinationName, const wxString& SourceName, const wxString& OptionalFlags, bool IsDirectory)
{
    FileInfo TempFileInfo;
    TempFileInfo.SetDestinationDirectory(DestinationDirectory);
    TempFileInfo.SetDestinationName(DestinationName);
    TempFileInfo.SetSourceName(SourceName);
    TempFileInfo.SetOptionalFlags(OptionalFlags);
    _FileList.Add(TempFileInfo);
}
void DevPackage::AddFile(const FileInfo& File)
{
    _FileList.Add(File);
}
void DevPackage::AddMenuEntry(const wxString& MenuEntryName, const wxString& MenuEntryTarget, const wxString& OptionalIcon)
{
    IconInfo TempIconInfo;
    TempIconInfo.SetMenuEntryName(MenuEntryName);
    TempIconInfo.SetMenuEntryTarget(MenuEntryTarget);
    TempIconInfo.SetOptionalIcon(OptionalIcon);
    _IconList.Add(TempIconInfo);
}
void DevPackage::AddMenuEntry(const IconInfo& Icon)
{
    _IconList.Add(Icon);
}
