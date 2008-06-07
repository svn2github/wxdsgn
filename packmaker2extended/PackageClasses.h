#ifndef DEV_PACKAGE_CLASSES_H
#define DEV_PACKAGE_CLASSES_H

#include <wx/fileconf.h>
#include <wx/string.h>
#include <wx/dynarray.h>
//Gauge to show package build progress
#include "BuildForm.h"

//Various Helpful defines
#define SETUP_SECTION           wxT("/Setup")
#define FILES_SECTION           wxT("/Files")
#define ICONS_SECTION           wxT("/Icons")
#define EXTENDED_SETUP_SECTION  wxT("/ExtendedSetup")
#define RECURSE                 wxT(";recursive")
#define DEVPAK_VERSION          wxT("2")
#define DEVPAK_SUBVERSION       wxT("1")

//We need to write the path format to the devpak, if this does not exist we will
//assume windows format, if it does exist then wxFileName must use the correct
//format
#if defined(__WXMSW__)
#define PATH_FORMAT wxT("Windows")
#elif defined(__WXMOTIF__) || defined(__WXGTK20__) || defined(__WXGTK__) || defined(__WXCOCOA__)
#define PATH_FORMAT wxT("Unix")
#elif defined(__WXMAC__)
#define PATH_FORMAT wxT("Mac")
#else
#define PATH_FORMAT wxT("Undefined")
#endif

//!  The FileInfo class holds information about each file or directory contained 
/*!
  The FileInfo class is used in a list to contain information about all the files
  and directories contained in the package.
  
  It contains the following information
  SourceName - This corresponds to the Name of the file or directory in the package
  if SourceName is a directory then all the files in it will be copied.
  DestinationDirectory - This corresponds to where the file or directory should be
  installed on the users computer. If it is a directory it MUST end with a backslash
  or else it will be interpreted as a filename.
  The SourceName and Dirctory
*/

class FileInfo
{
    public: //Constructors and Destructor
        FileInfo();
        ~FileInfo();
    public: // Accessors
        const wxString GetSourceName(){return _SourceName;};
        void SetSourceName(const wxString& SourceName){_SourceName = SourceName;};
        const wxString GetDestinationDirectory(){return _DestinationDirectory;};
        void SetDestinationDirectory(const wxString& DestinationDirectory){_DestinationDirectory = DestinationDirectory;};
        const wxString GetDestinationName(){return _DestinationName;};
        void SetDestinationName(const wxString& DestinationName){_DestinationName = DestinationName;};
        const wxString GetOptionalFlags(){return _OptionalFlags;};
        void SetOptionalFlags(const wxString& OptionalFlags){_OptionalFlags = OptionalFlags;};
        bool GetIsDirectory(){return _IsDirectory;};
        void SetIsDirectory(bool IsDirectory){_IsDirectory = IsDirectory;};
    private:
        wxString _SourceName; //The name of the source file, relative to the .DevPackage file.
        wxString _DestinationDirectory; //The destination directory. Please note that Destdir must *always* end with a backkslash (\)
        wxString _DestinationName; //If this is specified, the copied file will be renamed to the specified filename
        wxString _OptionalFlags; //There is only one flag at present recursive which recursively copies a directories contents  
        bool _IsDirectory;
};
    
WX_DECLARE_OBJARRAY(FileInfo, FileInfoList);

//!  The IconInfo class holds information about entries to be added to the specified system menu
/*!
    If the PackageClass member _MenuName is not empty then IconInfo class holds 
    information about each entry that should be added to the menu entry.
*/
class IconInfo
{
    public:
        IconInfo();
        ~IconInfo();
    public:
        const wxString GetMenuEntryName(){return _MenuEntryName;};
        void SetMenuEntryName(const wxString& MenuEntryName){ _MenuEntryName = MenuEntryName;};
        const wxString GetMenuEntryTarget(){return _MenuEntryTarget;};
        void SetMenuEntryTarget(const wxString& MenuEntryTarget){ _MenuEntryTarget = MenuEntryTarget;};
        const wxString GetOptionalIcon(){return _OptionalIcon;};
        void SetOptionalIcon(const wxString& OptionalIcon){ _OptionalIcon = OptionalIcon;};
    private:
        wxString _MenuEntryName;
        wxString _MenuEntryTarget;
        wxString _OptionalIcon;
};

WX_DECLARE_OBJARRAY(IconInfo, IconInfoList);

//! The DevPackage class holds information about package itself which is used by the installer
/*!
    The installer will look for the information contained in a DevPak to see where
    the contained files should be installed to. It also contains information such
    as readme and license files.
*/

class DevPackage
{
    public:
        DevPackage();
        DevPackage(wxFileConfig * PackageFile);
        ~DevPackage();
        
    public:
        /**
       * Creates a DevPackage from a .DevPackage file.
       * @param PackageFile a wxFileConfig class which is the file to load from.
       * @param FileName The full file name on the system used to create absolute loacations.
       * @see WritePackageFileToString()
       */
        void LoadFromPackageFile(wxFileConfig * PackageFile = NULL, const wxString& FileName = wxEmptyString);
        /**
       * Writes a .DevPackage file to a string this is needed since wxFileConfig does not add a space at the start of the file.
       * @see LoadFromPackageFile()
       * @return A wxString containing the contents of the file
       */
        const wxString WritePackageFileToString();
        /**
       * Clears the contents of the DevPackage class and sets basic defaults.
       * @see Init()
       */
        void Clear(){Init();};
        /**
       * Writes a .DevPak file. First it creates a Tar file then it packages this into a bz2 compressed file.
       * @param FileName The full file name of the .DevPackage file used to create absolute locations
       * @param buildForm A pointer to the form used to display the progress gauge.
       * @param Silent A boolean value which deteremines if the guage and messageboxes are used.
       * @return A boolean value of true if no errors were encountered or false otherwise. NOTE: even on a false value the DevPak may have been built correctly.
       * @see WritePackageFileToString()
       */
        bool BuildPackage(const wxString& FileName, BuildForm * buildForm = NULL, bool Silent = true, bool LogErrors = false);
        
    public: //Accessor Functions
        /** @name Standard Accessor Functions
        *  Setter and Getter functions for the various standard private members. 
        */
        //@{
        /** Getter for the _PackageName member. Returns the value of the member _PackageName. */
        const wxString GetPackageName(){return _PackageName;};
        /** Setter for the _PackageName member. Sets the value of the member _PackageName. */
        void SetPackageName(const wxString& PackageName){_PackageName = PackageName;};
        /** Getter for the _PackageVersionName member. Returns the value of the member _PackageVersionName. */
        const wxString GetPackageVersionName(){return _PackageVersionName;};
        /** Setter for the _PackageVersionName member. Sets the value of the member _PackageVersionName. */
        void SetPackageVersionName(const wxString& PackageVersionName){_PackageVersionName = PackageVersionName;};
        /** Getter for the _PackageVersion member. Returns the value of the member _PackageVersion. */
        const wxString GetPackageVersion(){return _PackageVersion;};
        /** Setter for the _PackageVersion member. Sets the value of the member _PackageVersion. */
        void SetPackageVersion(const wxString& PackageVersion){_PackageVersion = PackageVersion;};
        /** Getter for the _MenuName member. Returns the value of the member _MenuName. */
        const wxString GetMenuName(){return _MenuName;};
        /** Setter for the _MenuName member. Sets the value of the member _MenuName. */
        void SetMenuName(const wxString& MenuName){_MenuName = MenuName;};
        /** Getter for the _PackageDescription member. Returns the value of the member _PackageDesciption. */
        const wxString GetPackageDescription(){return _PackageDescription;};
        /** Setter for the _PackageDescription member. Sets the value of the member _PackageDesciption. */
        void SetPackageDesciption(const wxString& PackageDescription){_PackageDescription = PackageDescription;};
        /** Getter for the _URL member. Returns the value of the member _URL. */
        const wxString GetURL(){return _URL;};
        /** Setter for the _URL member. Sets the value of the member _URL. */
        void SetURL(const wxString& URL){_URL = URL;};
        /** Getter for the _Readme member. Returns the value of the member _Readme. */
        const wxString GetReadMe(){return _Readme;};
        /** Setter for the _Readme member. Sets the value of the member _Readme. */
        void SetReadMe(const wxString& ReadMe){_Readme = ReadMe;};
        /** Getter for the _LicenseText member. Returns the value of the member _LicenseText. */
        const wxString GetLicenseText(){return _LicenseText;};
        /** Setter for the _LicenseText member. Sets the value of the member _LicenseText. */
        void SetLicenseText(const wxString& LicenseText){_LicenseText = LicenseText;};
        /** Getter for the _Picture member. Returns the value of the member _Picture. */
        const wxString GetPicture(){return _Picture;};
        /** Setter for the _Picture member. Sets the value of the member _Picture. */
        void SetPicture(const wxString& Picture){_Picture = Picture;};
        /** Getter for the _Dependencies member. Returns the value of the member _Dependencies. */
        const wxString GetDependencies(){return _Dependencies;};
        /** Setter for the _Dependencies member. Sets the value of the member _Dependencies. */
        void SetDependencies(const wxString& Dependencies){_Dependencies = Dependencies;};
        /** Getter for the _Reboot member. Returns the value of the member _Reboot. */
        bool GetReboot(){return _Reboot;};
        /** Setter for the _Reboot member. Sets the value of the member _Reboot. */
        void SetReboot(const bool Reboot){_Reboot = Reboot;};
        /** Adds a new file to the _FileList. */
        void AddFile(const FileInfo& File);
        /** Adds a new file to the _FileList. */
        void AddFile(const wxString& DestinationDirectory, const wxString& DestinationName, const wxString& SourceName, const wxString& OptionalFlags, bool IsDirectory);
        /** Getter for the _FileList member. Returns the value of the member _FileList. */
        const FileInfoList GetFileList(){return _FileList;};
        /** Adds a new menu entry to the _IconList. */
        void AddMenuEntry(const IconInfo& Icon);
        /** Adds a new menu entry to the _IconList. */
        void AddMenuEntry(const wxString& MenuEntryName, const wxString& MenuEntryTarget, const wxString& OptionalIcon);
        /** Getter for the _IconList member. Returns the value of the member _IconList. */
        const IconInfoList GetIconList(){return _IconList;};
        //@}
        /** @name Extended Accessor Functions
        *  Setter and Getter functions for the various extended private members.
        */
        //@{
        /** Getter for the _SupportExtendedFormat member. Returns the value of the member _SupportExtendedFormat. */
        bool GetSupportExtendedFormat(){return _SupportExtendedFormat;};
        /** Setter for the _SupportExtendedFormat member. Sets the value of the member _SupportExtendedFormat. */
        void SetSupportExtendedFormat(const bool SupportExtendedFormat){_SupportExtendedFormat = SupportExtendedFormat;};
        /** Getter for the _PackagerName member. Returns the value of the member _PackagerName. */  
        const wxString GetPackagerName(){return _PackagerName;};
        /** Setter for the _PackagerName member. Sets the value of the member _PackagerName. */
        void SetPackagerName(const wxString& PackagerName){_PackagerName = PackagerName;};
        /** Getter for the _PackagerEmail member. Returns the value of the member _PackagerEmail. */
        const wxString GetPackagerEmail(){return _PackagerEmail;};
        /** Setter for the _PackagerEmail member. Sets the value of the member _PackagerEmail. */
        void SetPackagerEmail(const wxString& PackagerEmail){_PackagerEmail = PackagerEmail;};                 
        //@}
    
    private:
        /**
       * Clears the contents of the DevPackage class and sets basic defaults. Called by the constructors and Clear function.
       * @see Clear()
       * @see DevPackage()
       * @see DevPackage(wxFileConfig * PackageFile)
       */
        void Init();
    private:
        //Setup Info
        /** @name Standard Private Members
        *  Private memebrs for the standard package format.
        */
        //@{
        /** Holds the package name. This corresponds to AppName section in the .DevPackage file. */
        wxString _PackageName;
        /** Holds the package name and version. This corresponds to AppVerName section in the .DevPackage file. */
        wxString _PackageVersionName;
        /** Holds the package version number. This corresponds to AppVersion section in the .DevPackage file. */
        wxString _PackageVersion;
        /** Holds the menu name the package will occupy in the start menu. This corresponds to MenuName section in the .DevPackage file. */
        wxString _MenuName;
        /** Holds the package description. This corresponds to Description section in the .DevPackage file. */
        wxString _PackageDescription;
        /** Holds the URL to a website related to the package. This corresponds to Url section in the .DevPackage file. */
        wxString _URL;
        /** Holds the Readme file name. This corresponds to Readme section in the .DevPackage file. */
        wxString _Readme;
        /** Holds the license information for the package contents. This corresponds to License section in the .DevPackage file. */
        wxString _LicenseText;
        /** Holds a file name of a picture to be displayed. This corresponds to Picture section in the .DevPackage file. */
        wxString _Picture;
        /** Holds the list of package names this package depends on. This corresponds to Dependencies section in the .DevPackage file. */
        wxString _Dependencies;
        /** Holds the reboot value specifying whether a reboot is needed after installation. This corresponds to Reboot section in the .DevPackage file. */
        bool _Reboot;
        //@}
        //Extended Setup Info
        /** @name Extended Private Memebers
        *  Private Memebers for the extended package format.
        */
        //@{
        /** Holds a value to see if this package supports extended information. */
        bool _SupportExtendedFormat;
        /** Holds the packager's name. This corresponds to Packager section in the extended section of the .DevPackage file. */
        wxString _PackagerName;
        /** Holds the packager's email addess. This corresponds to PackagerEmail section in the extended section of the .DevPackage file. */
        wxString _PackagerEmail;
        /** Holds the list of file contained in the package. This corresponds to files in the Files section of the .DevPackage file. */
        FileInfoList _FileList;
        /** Holds the list of menu entries and icons to add to the start menu. This corresponds to the Icons section of the .DevPackage file. */
        IconInfoList _IconList;
        //@}
};
#endif
