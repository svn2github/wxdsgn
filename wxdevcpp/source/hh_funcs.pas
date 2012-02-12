{*******************************************************}
{                                                       }
{       HTML Help helper functions                      }
{                                                       }
{       Copyright (c) 1999-2007 The Helpware Group      }
{                                                       }
{*******************************************************}

{$IFDEF VER140}  //D6 only
{$warn SYMBOL_PLATFORM off}
{$warn UNIT_PLATFORM off}
{$ENDIF}

{
========================================================
  hh_funcs.pas
  Version 1.9
  Html Help helper functions

  Copyright (c) 1999-2007 The Helpware Group
  Email: support@helpware.net
  Web: http://www.helpware.net
  Platform: Delphi 2, 3, 4, 5, ...
  Changes Notes: See hh_doc.txt

1.51
  Debug info now displays Operating system type and version
1.6 25-Sept-2001
  Add Window Media Player detection
  Update IE HH version numbers
1.7 20-Jan-2002
  In HHCloseAll() don't call HH_CLOSE_ALL unless HH API is available
1.8 24-Feb-2006
  Some minor additions only -- Changes Notes: See hh_doc.txt
    Download: http://helpware.net/delphi/delphikit.zip
    from Kit Home Page: http://helpware.net/delphi/
1.9 08-Mar-2007
  GetIEFriendlyVer() now simply returns IE version for v7 and above.



========================================================
}
Unit hh_funcs;

Interface

Uses Windows,   //This line will not compile under Delphi 1 -- D1 is not supported
    SysUtils,
    Classes,
    Forms,
    ShellApi,
    Registry,
    FileCtrl;


{ >> Create conditional symbols.
     Note: This module is Delphi 2/3/4/5/.. compatible

     VER90     - Predefined by Delphi 2 compiler.
     VER100    - Predefined by Delphi 3 compiler.
     VER120    - Predefined by Delphi 4 compiler.
     VER130    - Predefined by Delphi 5 compiler.
     VER140    - Predefined by Delphi 6 compiler.
     VER150    - Predefined by Delphi 7 compiler.

     D3PLUS    - Compiler is Delphi 3 or greater
     D4PLUS    - Compiler is Delphi 4 or greater
}

{$DEFINE D3PLUS}
{$DEFINE D4PLUS}
{$DEFINE D5PLUS}
{$DEFINE D6PLUS}
{$DEFINE D7PLUS}

{$IFDEF VER90}        //Dephi 2
  {$UNDEF D3PLUS}
  {$UNDEF D4PLUS}
  {$UNDEF D5PLUS}
  {$UNDEF D6PLUS}
  {$UNDEF D7PLUS}
{$ENDIF}

{$IFDEF VER100}       //Dephi 3
  {$UNDEF D4PLUS}
  {$UNDEF D5PLUS}
  {$UNDEF D6PLUS}
  {$UNDEF D7PLUS}
{$ENDIF}

{$IFDEF VER120}       //Dephi 4
  {$UNDEF D5PLUS}
  {$UNDEF D6PLUS}
  {$UNDEF D7PLUS}
{$ENDIF}

{$IFDEF VER130}       //Dephi 5
  {$UNDEF D6PLUS}
  {$UNDEF D7PLUS}
{$ENDIF}

{$IFDEF VER140}       //Dephi 6
  {$UNDEF D7PLUS}
{$ENDIF}


{ Host Type }
Type THostType = (htHHAPI, htKeyHHexe, htHHexe);

{ HH comand line prefix}
Type TPrefixType = (ptNone, ptIE3, ptIE4);

{Exports}
Procedure HHCloseAll;

Function HHDisplayTopic(aChmFile, aTopic, aWinDef: String;
    aHostType: THostType): Integer;
Function HHHelpContext(aChmFile: String; aContextID: DWord;
    aWinDef: String; aHostType: THostType): Integer;

Function HHTopic(aCHMPath: String; aHostType: THostType): Integer;
Function HHContext(aChmPath: String; aContextId: Integer;
    aHostType: THostType): Integer;

Function HHFormat(aChmFile, aTopic, aWinDef: String;
    aPrefixType: TPrefixType): String;
Procedure HHSlitCmdStr(s: String; Var aChmFile, aTopic, aWinDef: String);
//typo kept for backward compatibility
Procedure HHSplitCmdStr(s: String; Var aChmFile, aTopic, aWinDef: String);

Procedure HHShowError(err: Integer);


{Callbacks available for THookHelpSystem}
Type
    THelpProcCallback1 = Procedure(Data: Longint);
    THelpProcCallback2 = Procedure(Data: Longint; X, Y: Integer);


{THookHelpSystem}
Type
    THookHelpSystem = Class(TObject)
    Private
        FOldHelpEvent: THelpEvent;
        FChmFile: String;
        FWinDef: String;
        FHostType: THostType;
        FPopupXY: TPoint;
        Function HelpHook(Command: Word; Data: Longint;
            Var CallHelp: Boolean): Boolean;
    Public
        {Optional callback funcs called when Help events come in}
        HelpCallback1: THelpProcCallback1;
        HelpCallback2: THelpProcCallback2;
        FOKToCallOldHelpEvent: Boolean;

        Constructor Create(aDefChmFile, aDefWinDef: String; aHostType: THostType);
        Destructor Destroy; Override;

        Function HelpContext(aContextId: DWord): Integer;
        Function HelpTopic(aTopic: String): Integer;
        Function HelpTopic2(aChmFile, aTopic, aWinDef: String): Integer;
        Function HelpTopic3(aChmPath: String): Integer;

        Property ChmFile: String Read FChmFile Write FChmFile;
        Property WinDef: String Read FWinDef Write FWinDef;
        Property HostType: THostType Read FHostType Write FHostType;
    End;

    {General purpose Log File}
    TDLogFile = Class
    Private
        FFilename: String;
        FDebugMode: Boolean;
        FTimeStamp: Boolean;
        FHeaderDump: Boolean;
        FAppendMode: Boolean;
    Public
        Constructor Create(aFilename: String; aDebugMode: Boolean;
            aTimeStamp: Boolean; aHeaderDump, aAppendMode: Boolean);
        Destructor Destroy; Override;
        Procedure CopyLogTo(aNewFilename: String);
        Procedure DebugOut(msgStr: String; Const Args: Array Of Const);
        Procedure DebugOut2(msgStr: String; Const Args: Array Of Const);
        Procedure ReportError(errStr: String; Const Args: Array Of Const);
        Procedure Show;
        Procedure Reset;
        Function GetLogDir: String;

        Property Filename: String Read FFilename Write FFilename;
        Property DebugMode: Boolean Read FDebugMode Write FDebugMode;
        //Only log if this is true
        Property HeaderDump: Boolean Read FHeaderDump Write FHeaderDump;
        //Used by Reset
        Property AppendMode: Boolean Read FAppendMode Write FAppendMode;
        //Used by Reset
    End;


{ See Module initialization }
Var
    { 'hhctrl.ocx' version info }
    _hhInstalled: Boolean = False;          //Is Html Help 'hhctrl.ocx' installed
    _hhVerStr: String = '';
    //eg. '4.73.8252.1' or '' if not found
    _hhMajVer: Word = 0;                    //eg. 4
    _hhMinVer: Word = 0;                    //eg. 73
    _hhBuildNo: Word = 0;                   //eg. 8252
    _hhSubBuildNo: Word = 0;                //eg. 1
    _hhFriendlyVerStr: String = '';         //eg. '1.2'

    { 'Shdocvw.dll' version info }
    _ieInstalled: Boolean = False;          //Is Internet Explorer Installed
    _ieVerStr: String = '';                 //eg. '5.00.0910.1309'
    _ieFriendlyVerStr: String = '';         //eg. 'Internet Explorer 5'

    { General }
    _RunDir: String = '';
    //applications run directory. Or Host EXE directory if part of DLL.
    _ModulePath: String;
    //If part of DLL this is the full path to the DLL
    _ModuleDir: String;
    //If part of DLL this is the DLL Dir and different from _RunDir
    _ModuleName: String;
//If part of DLL this is the DLL name otherwise it is host exe name

{ Debug Log file

  We always create this Debug Log Object - If debugging is enabled we fill it with stuff
  To make your own Log file change its properties, then call reset. Or Create your own Obj from scratch.
  Example:
    _HHDbgObj.DebugMode := true;       //Must force logging on to make logging work
    _HHDbgObj.Filename := _HHDbgObj.GetLogDir + '\MyLogfile.txt';   //new log filename
    _HHDbgObj.HeaderDump := true;      //Dump debug header on Reset call
    _HHDbgObj.AppendMode := false;     //Delete old file on reset
    _HHDbgObj.Reset;                   //Resets the Log file
}
Var
    _HHDbgObj: TDLogFile = Nil;

{ Host Apps - Live in the Windows Dir }
Const
    HOST_HHEXE = 'HH.EXE';
    HOST_KEYHHEXE = 'KeyHH.EXE';

{ HH comand line prefix}
Const
    HH_PREFIX_IE4 = 'ms-its:';
    //IE4 and above compatible command line prefix
    HH_PREFIX_IE3 = 'mk:@MSITStore:';
//IE3 and above compatible command line prefix


{ HH Errors }
Const
    HH_ERR_AllOK = 0;
    HH_ERR_HHNotInstalled = 1;     //Html Help is not installed on this PC
    HH_ERR_KeyHHexeNotFound = 2;
    //KeyHH.EXE was not found in the Windows folder
    HH_ERR_HHexeNotFound = 3;
//HH.EXE was not found in the Windows folder


{ exports - General functions }

Procedure DosToUnix(Var filename: String);
Procedure UnixToDos(Var filename: String);
Function StrPosC(Const s: String; Const find: String): Integer;
Function StrPosI(Const s: String; Const find: String): Integer;
Function StrRepC(Var s: String; Const find, repl: String): Integer;
Function StrRepI(Var s: String; Const find, repl: String): Integer;
Function StrRepCA(Var s: String; Const find, repl: String): Integer;
Function StrRepIA(Var s: String; Const find, repl: String): Integer;
Procedure StripL(Var s: String; c: Char);
Procedure StripR(Var s: String; c: Char);
Procedure StripLR(Var s: String; c: Char);
Function MkStr(c: Char; count: Integer): String;
Function BoolToYN(b: Boolean): String;

Function GetWinDir: String;
Function GetWinSysDir: String;
Function GetWinTempDir: String;

Function VerCompare(va1, va2, va3, va4, vb1, vb2, vb3, vb4: Word): Integer;
Function GetFileVer(aFilename: String; Var aV1, aV2, aV3, aV4: Word): String;
Function GetFileVerStr(aFilename: String): String;
Function GetIEVer(Var V1, V2, V3, V4: Word): String;
Function Check_HH_Version(x1, x2, x3, x4: Integer): Integer;
Function Check_IE_Version(x1, x2, x3, x4: Integer): Integer;
Function GetHHFriendlyVer: String;
Function GetIEFriendlyVer: String;

Function Check_WMP_Version(x1, x2, x3, x4: Integer): Integer;

Function ShellExec(aFilename: String; aParams: String): Boolean;
Function GetLastErrorStr: String;
Function GetRegStr(rootkey: HKEY; Const key, dataName: String): String;
Procedure PutRegStr(rootkey: HKEY; Const key, name, value: String);
Function RegKeyNameExists(rootkey: HKEY; Const key, dataName: String): Boolean;

Procedure DebugOut(msgStr: String; Const Args: Array Of Const);
Procedure DebugOut2(msgStr: String; Const Args: Array Of Const);
Procedure ShowDebugFile;
Procedure ResetDebugFile;
Function IsDirWritable(aDir: String): Boolean;
Function DirExists(dirName: String): Boolean;

Procedure ShowMessage2(aMsg: String);
Function MessageBox2(aMsg: String; Uflags: UInt): Integer;
Function YNBox2(aMsg: String): Boolean;

Procedure ReportError(errStr: String; Const Args: Array Of Const);


{$IFDEF D3PLUS} // -- Delphi >=3
resourcestring
{$ELSE}// -- Delphi 2
Const
{$ENDIF}

    //Error Strings
    st_HH_ERR_HHNotInstalled = 'MS Html Help is not installed on this PC.';
    st_HH_ERR_KeyHHexeNotFound =
        'System file KeyHH.EXE was not found in the Windows folder.';
    st_HH_ERR_HHexeNotFound =
        'System file HH.EXE was not found in the Windows folder.';
    st_HH_ERR_Unknown = 'Unknown error returned by HHHelpContext';

    //For GetLastError
    st_GLE_FileNotFound = 'File Not Found';
    st_GLE_PathNotFound = 'Path Not Found';
    st_GLE_AccessDenied = 'Access Denied';
    st_GLE_InsufficientMemory = 'Insufficient Memory';
    st_GLE_MediaIsWriteProtected = 'Media Is Write Protected';
    st_GLE_DeviceNotReady = 'Device Not Ready';
    st_GLE_FileInUse = 'File In Use';
    st_GLE_DiskFull = 'Disk Full';
    st_GLE_WindowsVersionIncorrect = 'Windows Version Incorrect';
    st_GLE_NotAWindowsOrMSDosProgram = 'Not A Windows Or MSDos Program';
    st_GLE_CorruptFileOrDisk = 'Corrupt File Or Disk';
    st_GLE_CorruptRegistry = 'Corrupt Registry';
    st_GLE_GeneralFailure = 'General Failure';

{ Debug File Options }
Var
    _DebugMode: Boolean = False;


Implementation

Uses
    hh;  //HH API

Var
    { Debug File Options}
    DBG_TIMESTAMP: Boolean = True;
    DBG_HEADERDUMP: Boolean = True;
    DBG_APPENDMODE: Boolean = False;
    DBG_FILENAME: String = '\HHDebug.txt';
    DBG_DIR: String = '';   //set to app dir in module init


{Use this popuop means we don't have to use Borland Dialogs Unit
 See MessageBox help for more
 Set Uflags = 0 for OK
}
Function MessageBox2(aMsg: String; Uflags: UInt): Integer;
Begin
    Result := windows.MessageBox(0, Pchar(aMsg),
        Pchar(application.Title), Uflags);
End;

Procedure ShowMessage2(aMsg: String);
Begin
    MessageBox2(aMsg, 0);
End;

Function YNBox2(aMsg: String): Boolean;
Begin
    Result := windows.MessageBox(0, Pchar(aMsg), Pchar(application.Title),
        MB_YESNO Or MB_ICONQUESTION) = IDYES;
End;




{---------------------------------------------------------------------]
  Hook Help System

  Delphi allows you to trap all help calls and redirect them
  to your own handler. Thus we get Html Help working under D3/4.

  Usage:

    var mHHelp: THookHelpSystem;

    procedure TMainForm.FormCreate(Sender: TObject);
    begin
      //Set CHM file, Window Definition to use if reqired and Mode of operation
      mHHelp := THookHelpSystem.Create(pathToCHM, '', htHHAPI);
      ...

    procedure TMainForm.FormDestroy(Sender: TObject);
    begin
      //Unhook and free
      mHHelp.Free;
      ...

  Show help in the normal way
  o Set "Form.HelpContext := xx" to display page sensitive help via F1 key.
  o Set "Control.HelpContext := xx" to display field sensitive help via F1 and "whats this" help.
  o Call Application.HelpContext(xx) to show help directly from a memu or help button.
  o Make sure that Topic xx, xx is a context ID, is defined in the CHM help file.
  eg. Application.HelpContext(1133)

  To display a topic by topic filename use
  mHHelp.HelpTopic('index.html');

[---------------------------------------------------------------------}

Constructor THookHelpSystem.Create(aDefChmFile, aDefWinDef: String;
    aHostType: THostType);
Begin
    Inherited Create;
    FChmFile := aDefChmFile;
    FWinDef := aDefWinDef;
    FHostType := aHostType;

    {Hook in our help}
    FOldHelpEvent := Application.OnHelp;
    Application.OnHelp := HelpHook;

    FOKToCallOldHelpEvent := False;

    {Debug}
    DebugOut2('THookHelpSystem.Create("%s","%s", %d)',
        [aDefChmFile, aDefWinDef, ord(aHostType)]);
End; { THookHelpSystem.Create }

Destructor THookHelpSystem.Destroy;
Begin
    {Must call this or get access violation}
    If FHostType = htHHAPI Then
        hh_funcs.HHCloseAll;

    {Unhook our help}
    Application.OnHelp := FOldHelpEvent;
    Inherited destroy;
    DebugOut2('THookHelpSystem.Destroy', ['']);
End; { THookHelpSystem.Destroy }

{ Debug aid - Commands to pass to WinHelp() }
Function WinHelpCmdToStr(cmd: Integer): String;
Begin
    Case cmd Of
        HELP_CONTEXT:
            result := 'HELP_CONTEXT';       { Display topic in ulTopic  }
        HELP_QUIT:
            result := 'HELP_QUIT';            { Terminate help  }
        HELP_INDEX:
            result := 'HELP_INDEX or HELP_CONTENTS';         { Display index  }
        HELP_HELPONHELP:
            result := 'HELP_HELPONHELP';    { Display help on using help  }
        HELP_SETINDEX:
            result := 'HELP_SETINDEX or HELP_SETCONTENTS';
        { Set current Index for multi index help  }
        HELP_CONTEXTPOPUP:
            result := 'HELP_CONTEXTPOPUP';
        HELP_FORCEFILE:
            result := 'HELP_FORCEFILE';
        HELP_KEY:
            result := 'HELP_KEY';         { Display topic for keyword in offabData  }
        HELP_COMMAND:
            result := 'HELP_COMMAND';
        HELP_PARTIALKEY:
            result := 'HELP_PARTIALKEY';
        HELP_MULTIKEY:
            result := 'HELP_MULTIKEY';
        HELP_SETWINPOS:
            result := 'HELP_SETWINPOS';
        HELP_CONTEXTMENU:
            result := 'HELP_CONTEXTMENU';
        HELP_FINDER:
            result := 'HELP_FINDER';
        HELP_WM_HELP:
            result := 'HELP_WM_HELP';
        HELP_SETPOPUP_POS:
            result := 'HELP_SETPOPUP_POS';
    Else
        result := '??';
    End;
    result := inttostr(cmd) + ' (' + result + ')';
End;


{ All application help calls to help come here }
Function THookHelpSystem.HelpHook(Command: Word; Data: Longint;
    Var CallHelp: Boolean): Boolean;
Begin
    result := True;
    DebugOut2('THookHelpSystem.HelpHook(%s, %d)',
        [WinHelpCmdToStr(Command), Data]);

    //new: 19/4/2003 - Call old help event
    If FOKToCallOldHelpEvent And Assigned(FOldHelpEvent) Then
        result := FOldHelpEvent(Command, Data, CallHelp);

    CallHelp := False;
    Case Command Of
        Help_Context:      //help button
        Begin
            If Assigned(HelpCallback1)
            Then
                HelpCallback1(Data)           //Call back
            Else Self.HelpContext(Data);     //Call help
        End;
        HELP_SETPOPUP_POS: //call #1 of F1 Popup (Whats This) help
            FPopupXY := SmallPointToPoint(TSmallPoint(Data));
        //data = x,y pos for popup
        Help_ContextPopup: //call #2 of F1 Popup (Whats This) help
        Begin
            If Assigned(HelpCallback2)
            Then
                HelpCallback2(Data, FPopupXY.X, FPopupXY.Y)   //Call back
            Else Self.HelpContext(Data);                       //Call help
        End
    Else
        CallHelp := True; //Default handling - WinHelp
    End;
End; { THookHelpSystem.HelpHook }


{ No need to call this directly. Instead call Application.HelpContext(xx) and it will call this
  function because of the hook we have installed.
  Uses ChmFile, WinDef & Hosttype specified by create}
Function THookHelpSystem.HelpContext(aContextId: DWord): Integer;
Begin
    result := HHHelpContext(FChmFile, aContextId, FWinDef, FHostType);
    HHShowError(result);
End;

{Show a help topic - 1
 Uses ChmFile, Topic, WinDef & HostType specified by create}
Function THookHelpSystem.HelpTopic(aTopic: String): Integer;
Begin
    result := HHDisplayTopic(FChmFile, aTopic, FWinDef, FHostType);
    HHShowError(result);
End;

{Show a help topic - 2
 overrides default Chm and WinDef - still uses initially specified Host Type}
Function THookHelpSystem.HelpTopic2(aChmFile, aTopic, aWinDef:
    String): Integer;
Begin
    result := HHDisplayTopic(aChmFile, aTopic, aWinDef, FHostType);
End;

{Show a help topic - 3
 overrides default Chm and WinDef - Specify a full path EG. c:\help\help.chm::/htm/topic.htm}
Function THookHelpSystem.HelpTopic3(aChmPath: String): Integer;
Begin
    Result := HHTopic(aCHMPath, FHostType);
End;


{ Show Error }
Procedure HHShowError(err: Integer);
Var s: String;
Begin
    Case err Of
        HH_ERR_AllOK:
            s := '';
        HH_ERR_HHNotInstalled:
            s := st_HH_ERR_HHNotInstalled;
        HH_ERR_KeyHHexeNotFound:
            s := st_HH_ERR_KeyHHexeNotFound;
        HH_ERR_HHexeNotFound:
            s := st_HH_ERR_HHexeNotFound;
    Else
        s := st_HH_ERR_Unknown;
    End;
    If s <> '' Then
    Begin
        MessageBox2(s, MB_OK Or MB_ICONWARNING);
        DebugOut2('HHShowError(%d), "%s"', [err, s]);
    End;
End;


{---------------------------------------------------------------------]
   HH Functions
[---------------------------------------------------------------------}

{ Call HHCloseAll if you are calling help using the HH API.
  It will tell the HH API to close all HH Windows opened by this application.

 Warning: if you are calling HH API function to display help you must call this before
   application shutdown or your application will crash

 Warning: Call this from the mainform OnCloseQuery NOT the OnDestroy.
   This gives more time for the HH API Close thread to return before closing the link to the DLL library.
}
Procedure HHCloseAll;
Begin
    If HH.HHCtrlHandle <> 0 Then
        //20-Jan-2001, Don't call HH API if no API available
    Begin
        HH.HtmlHelp(0, Nil, HH_CLOSE_ALL, 0);
        Sleep(0);   //17-Dec-2001 fix timing problem - bug where HH going off on a thread
    End;
End;

{ HHDisplayTopic()
  Display a Topic from the CHM file using a Window Definition
    aChmFile: In
      Name of compressed help file to display.
      Generally this should be full path as NT is less forgiving with relative paths.
    aTopic: In
      Path to html file in Chm file.
      Leave blank to display open the Chm at the default page
    aWinDef: In
      Specify a window definition. Leading slash will be added if missing.
      Leave blank to display open the Chm with the default window definition
      Note: not supported by some versions of HH.EXE and KeyHH.EXE
    aHostType: In
      Who will host the HH Window
      - htHHAPI:  This application will host via API calls.
      - htKeyHHexe:  Windows KeyHH.EXE will.
      - htHHexe:   Windows HH.EXE will.
    Returns:
      Possible returns
       0 = All OK
       HH_ERR_HHNotInstalled
       HH_ERR_KeyHHexeNotFound (aHostType = htKeyHHexe)
       HH_ERR_HHexeNotFound (aHostType = htHHexe)
  Other Info
      - No checking is done on any of the params.
        Caller should first verify that the chmFile exists.
  Example:
      HHDisplayTopic('windows.chm','about_magnify.htm','windefault', htHHAPI);
}
Function HHDisplayTopic(aChmFile, aTopic, aWinDef: String;
    aHostType: THostType): Integer;
Var target: String;
Begin
    //Showmessage(format('%s, %s, %s, %d',[aChmFile, aTopic, aWinDef, ord(aHostType)]));
    DebugOut2('HHHelpContext("%s", %s, "%s", %d)',
        [aChmFile, aTopic, aWinDef, Ord(aHostType)]);

    If aHostType = htHHexe Then
        //Prefix required by early versions - use IE3 prefix
        target := HHFormat(aChmFile, aTopic, aWinDef, ptIE3)
    Else                         //No prefix needed
        target := HHFormat(aChmFile, aTopic, aWinDef, ptNone);
    result := HHTopic(target, aHostType);
End;

{
   HHTopic()
   Same as above except aCHMPath may be a combination
   chmfile, Topic, WinDef in the form chmfile::/Topic>WinDef
   Note: HH.EXE normally requires a path prefix.
}
Function HHTopic(aCHMPath: String; aHostType: THostType): Integer;
Var appPath: String; h: HWND;
Begin
    DebugOut2('ShowTopic("%s", %d)', [aChmPath, Ord(aHostType)]);
    result := HH_ERR_AllOK;  {0}

    { Check HH Installed on this PC }
    If Not _hhInstalled Then
        result := HH_ERR_HHNotInstalled
    Else
        Case aHostType Of

            //Host Type = This app using HH API
            htHHAPI:
            Begin
                h := HH.HtmlHelp(GetDesktopWindow, Pchar(aCHMPath),
                    HH_DISPLAY_TOPIC, 0);
                If h > 0 Then
                    SetForegroundWindow(h);
            End;

            //Host Type = KeyHH.EXE (must be installed)
            htKeyHHexe:
            Begin
                appPath := GetWinDir + '\' + HOST_KEYHHEXE;
                If Not FileExists(appPath) Then
                    result := HH_ERR_KeyHHexeNotFound
                Else
                Begin
          { Pass the parameters to KeyHH.exe using "-win" for single window.
            hh path prefix is not required by KeyHH.EXE
          }
                    ShellExec(appPath, '-win ' + aCHMPath);
                End;
            End;

            //Host Type = HH.EXE (part of Html Help)
            htHHexe:
            Begin
                appPath := GetWinDir + '\' + HOST_HHEXE;
                If Not FileExists(appPath) Then
                    result := HH_ERR_HHexeNotFound
                Else
                Begin
                    { HH.EXE requires a prefix. }
                    ShellExec(appPath, aCHMPath);
                End;
            End;
        End; {case}
    DebugOut2('  returned - %d', [result]);
End;




{ HHHelpContext()
  Displays a help topic based on a mapped topic ID.

  Function documentation is the same as above except replace "aTopic" by...

    aContextID
      Specifies the numeric ID of the topic to display

  returns same errors

  Example:
     HHHelpContext('windows.chm',200,'windefault', htHHAPI);
}
Function HHHelpContext(aChmFile: String; aContextID: DWord;
    aWinDef: String; aHostType: THostType): Integer;
Var target: String;
Begin
    DebugOut2('HHHelpContext("%s", %d, "%s", %d)',
        [aChmFile, aContextID, aWinDef, Ord(aHostType)]);
    If aHostType = htHHexe //Prefix required by early versions - use IE3 prefix
    Then
        target := HHFormat(aChmFile, '', aWinDef, ptIE3)
    Else target := HHFormat(aChmFile, '', aWinDef, ptNone);  //No prefix needed
    result := HHContext(target, aContextID, aHostType);
End;


{
   HHContext()
   Same as above except aCHMPath may be a combination
   chmfile & WinDef in the form chmfile>WinDef
   Note: HH.EXE does not support context mapped help - use KeyHH.exe instead
}
Function HHContext(aChmPath: String; aContextId: Integer;
    aHostType: THostType): Integer;
Var appPath: String; h: HWND;
Begin
    DebugOut2('ShowContext("%s", %d)', [aChmPath, Ord(aHostType)]);
    result := HH_ERR_AllOK;  {0}

    { Check HH Installed on this PC }
    If Not _hhInstalled Then
        result := HH_ERR_HHNotInstalled
    Else
        Case aHostType Of

            //Host Type = This app using HH API
            htHHAPI:
            Begin
                h := HH.HtmlHelp(GetDesktopWindow, Pchar(aChmPath),
                    HH_HELP_CONTEXT, aContextID);
                If h > 0 Then
                    SetForegroundWindow(h);
            End;

            //Host Type = KeyHH.EXE (must be installed)
            htKeyHHexe:
            Begin
                appPath := GetWinDir + '\' + HOST_KEYHHEXE;
                If Not FileExists(appPath) Then
                    result := HH_ERR_KeyHHexeNotFound
                Else
                Begin
          { Pass the parameters to KeyHH.exe
            using "-win" for single window and "-#mapid xx " for the context
            hh path prefix is not required by KeyHH.EXE
          }
                    ShellExec(appPath, '-win -#mapid ' + IntToStr(aContextID) +
                        ' ' + aChmPath);
                End;
            End;

            //Host Type = HH.EXE (part of Html Help)
            htHHexe:
            Begin
                appPath := GetWinDir + '\' + HOST_HHEXE;
                If Not FileExists(appPath) Then
                    result := HH_ERR_HHexeNotFound
                Else
                    ShellExec(appPath, '-mapid ' + IntToStr(aContextID) +
                        ' ' + aChmPath);
            End;

        End; {case}
    DebugOut2('  returned - %d', [result]);
End;



{
  This creates a command line suitable for use with HH.EXE, KeyHH or HHServer.EXE
    chmFile:
       Name of CHM file. Full or relative path.
    Topic:
       Html filename in Chm. Can be blank.
       Under IE4 this can include a bookmark.
    WinDef:
       Window Definition to use. Can be blank.
    aPrefixType:
       What to prefix string to add
       ptNone - No Prefix added
       ptIE3 - IE3 and above compatible prefix added - 'mk:@MSITStore:'
       ptIE4 - IE4 and above compatible prefix added - 'ms-its:'
  Result examples
    HHFormat('windows.chm', 'about_magnify.htm', 'windefault', ptIE3);
    => 'mk:@MSITStore:windows.chm::/about_magnify.htm>windefault'

    chmFile.chm
    chmFile.chm>WinDef
    Helpfile.chm::/Topic.htm>WinDef
    ms-its:chmFile.chm>WinDef
    mk:@MSITStore:Helpfile.chm::/Topic.htm>WinDef

}
Function HHFormat(aChmFile, aTopic, aWinDef: String;
    aPrefixType: TPrefixType): String;
Begin
    //  Rename all %20 to space
    StrRepCA(aChmFile, '%20', ' ');
    StrRepCA(aTopic, '%20', ' ');
    StrRepCA(aWinDef, '%20', ' ');

    StripLR(aChmFile, ' ');   StripLR(aTopic, ' ');
    StripLR(aWinDef, ' ');  //no lead trail spaces

    {make chm and topic}
    If aTopic = '' Then
        result := aChmFile
    Else
    Begin
        DosToUnix(aTopic);
        //Topics should always contain '/' unix slashes
        If aTopic[1] <> '/' Then              //we want a leading slash
            aTopic := '/' + aTopic;
        result := aTopic;
        If aChmFile <> '' Then
            //Allow no chmfile so we can format the topic
            result := aChmFile + '::' + result;
    End;

    {add win definition}
    If aWinDef <> '' Then
        result := result + '>' + aWinDef;

    {add prefix}
    Case aPrefixType Of
        ptIE3:
            result := HH_PREFIX_IE3 + result;
        ptIE4:
            result := HH_PREFIX_IE4 + result;
    End;
End;


{
  Given a string s like
    mk:@MSITStore:aChmFile::aTopic>aWinDef
  eg.
    chmFile.chm
    chmFile.chm>WinDef
    Helpfile.chm::/Topic.htm>WinDef
    ms-its:chmFile.chm>WinDef
    mk:@MSITStore:Helpfile.chm::/Topic.htm>WinDef
  return the components
    aChmFile, aTopic, aWinDef
}
//Backward compatible Fix - Typo - Should be Split not Slit
Procedure HHSlitCmdStr(s: String; Var aChmFile, aTopic, aWinDef: String);
Begin
    HHSplitCmdStr(s, aChmFile, aTopic, aWinDef);
End;

Procedure HHSplitCmdStr(s: String; Var aChmFile, aTopic, aWinDef: String);
Var i: Integer;
Begin
    //  Replace all %20 to space
    StrRepCA(s, '%20', ' ');

    {Get WinDef}
    i := StrPosC(s, '>');
    If i > 0 Then
    Begin
        aWinDef := Copy(s, i + 1, Maxint);
        SetLength(s, i - 1);
    End;

    {Get Topic}
    i := StrPosC(s, '::');
    If i > 0 Then
    Begin
        aTopic := Copy(s, i + 2, Maxint);
        SetLength(s, i - 1);
        DosToUnix(aTopic);
        //Topics should always contain '/' unix slashes
    End;

    {Get chmFile}
    i := StrPosI(s, 'its:'); //'ms-its:'
    If i > 0 Then
        aChmFile := Copy(s, i + length('its:'), Maxint)
    Else
    Begin
        i := StrPosI(s, 'store:');  //'mk:@MSITStore:'
        If i > 0 Then
            aChmFile := Copy(s, i + length('store:'), Maxint)
        Else
            aChmFile := s;
    End;

    StripLR(aChmFile, ' ');
    StripLR(aTopic, ' ');
    StripLR(aWinDef, ' ');
End;



{---------------------------------------------------------------------]
   General Functions
[---------------------------------------------------------------------}


{ Sometimes safest to work in Unix / slashes }
Procedure DosToUnix(Var filename: String);
Begin
    Repeat Until StrRepC(filename, '\', '/') = 0;
End;

Procedure UnixToDos(Var filename: String);
Begin
    Repeat Until StrRepC(filename, '/', '\') = 0;
End;

{Find pos of sub string in string. Case Sensitive - returns 0 not found or 1..n}
Function StrPosC(Const s: String; Const find: String): Integer;
Var p: Pchar;
Begin
{$IFDEF D3PLUS} // -- Delphi >=3
  p := AnsiStrPos( PChar(s) , PChar(find) );   //double byte safe
{$ELSE}// -- Delphi 2
    p := StrPos(Pchar(s), Pchar(find));   //double byte safe
{$ENDIF}
    If p = Nil Then
        result := 0
    Else
        result := p - Pchar(s) + 1;
End;

{Same as Above only ignores case}
Function StrPosI(Const s: String; Const find: String): Integer;
Var s2, find2: String;
Begin
{$IFDEF D3PLUS} // -- Delphi >=3
  s2 := AnsiUpperCase(s);
  find2 := AnsiUpperCase(find);
{$ELSE}// -- Delphi 2
    s2 := UpperCase(s);
    find2 := UpperCase(find);
{$ENDIF}

    result := StrPosC(s2, find2);
End;


{returns pos where subString replacements was done - 0 = none done - Case Sensitive}
Function StrRepC(Var s: String; Const find, repl: String): Integer;
Begin
    result := StrPosC(s, find);
    If result > 0 Then     {found - replace}
    Begin
        Delete(s, result, Length(find));
        Insert(repl, s, result);
    End;
End;

{returns pos where subString replacements was done - 0 = none done - Ignore Sensitive}
Function StrRepI(Var s: String; Const find, repl: String): Integer;
Begin
    result := StrPosI(s, find);
    If result > 0 Then     {found - replace}
    Begin
        Delete(s, result, Length(find));
        Insert(repl, s, result);
    End;
End;


{Replace all ocurrences (Ignore Case) - returns replacements done}
Function StrRepIA(Var s: String; Const find, repl: String): Integer;
Begin
    result := 0;
    Repeat
        If StrRepI(s, find, repl) > 0 Then
            inc(result)
        Else
            break;
    Until False;
End;

{Replace all ocurrences (Case Sensitive) - returns replacements done}
Function StrRepCA(Var s: String; Const find, repl: String): Integer;
Begin
    result := 0;
    Repeat
        If StrRepC(s, find, repl) > 0 Then
            inc(result)
        Else
            break;
    Until False;
End;

{Strip leading chars}
Procedure StripL(Var s: String; c: Char);
Begin
    While (s <> '') And (s[1] = c) Do
        Delete(s, 1, 1);
End;

{Strip trailing chars}
Procedure StripR(Var s: String; c: Char);
Var p: Pchar;
Begin
{$IFDEF D3PLUS} // -- Delphi >=3
  repeat
    p := AnsiLastChar(S);    //nil if S = empty
    if (p <> nil) and (p = c) then
      SetLength(s, Length(s)-1)
    else
      break;
  until p = nil;
{$ELSE}// -- Delphi 2
    Repeat
        If (s <> '') And (s[length(s)] = c) Then
            SetLength(s, Length(s) - 1)
        Else
            break;
    Until False;
{$ENDIF}
End;


{Strip leading and trailing chars}
Procedure StripLR(Var s: String; c: Char);
Begin
    StripL(s, c);
    StripR(s, c);
End;

{Make string of chars}
Function MkStr(c: Char; count: Integer): String;
Var i: Integer;
Begin
    result := '';
    For i := 1 To count Do
        result := result + c;
End;

{ Boolean to Yes / No }
Function BoolToYN(b: Boolean): String;
Begin
    If b Then
        result := 'YES' Else result := 'NO';
End;


{Return Windows Dir}
Function GetWinDir: String;
Var path: Array[0..260] Of Char;
Begin
    GetWindowsDirectory(path, SizeOf(path));
    result := path;
    StripR(result, '\');  //no trailing slash
End;

{Return Windows System Dir}
Function GetWinSysDir: String;
Var path: Array[0..260] Of Char;
Begin
    GetSystemDirectory(path, SizeOf(path));
    result := path;
    StripR(result, '\');  //no trailing slash
End;

{Get Windows Temp Dir - with no trailing slash}
Function GetWinTempDir: String;
Var dwLen: DWORD;
Begin
    SetLength(result, 300);
    dwLen := GetTempPath(300, @result[1]);
    SetLength(result, dwLen);

    //problems
    If DirectoryExists(result) = False Then
        result := 'c:';
    StripR(result, '\');  //no trailing slash
End;



{
  Get the product version number from a file (exe, dll, ocx etc.)
  Return '' if info not available - eg. file not found
  eg. Returns '7.47.3456.0', aV1=7, aV2=47, aV3=3456 aV4=0
  ie. major.minor.release.build
}
Function GetFileVer(aFilename: String; Var aV1, aV2, aV3, aV4: Word): String;
Var  InfoSize: DWORD; Wnd: DWORD; VerBuf: Pointer; VerSize: DWORD;
    FI: PVSFixedFileInfo;
Begin
    result := '';
    aV1 := 0;  aV2 := 0;  aV3 := 0;  aV4 := 0;

    If (aFilename = '') Or (Not FileExists(aFilename)) Then
        exit;  //don't continue if file not found

    InfoSize := GetFileVersionInfoSize(Pchar(aFilename), Wnd);

    //Note: we strip out the resource info for our dll to keep it small
    //Result := SysErrorMessage(GetLastError);

    If InfoSize <> 0 Then
    Begin
        GetMem(VerBuf, InfoSize);
        Try
            If GetFileVersionInfo(Pchar(aFilename), Wnd, InfoSize, VerBuf) Then
            Begin
                If VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) Then
                Begin
                    aV1 := HiWord(FI^.dwFileVersionMS);
                    aV2 := LoWord(FI^.dwFileVersionMS);
                    aV3 := HiWord(FI^.dwFileVersionLS);
                    aV4 := LoWord(FI^.dwFileVersionLS);
                    result := IntToStr(HiWord(FI^.dwFileVersionMS)) + '.' +
                        IntToStr(LoWord(FI^.dwFileVersionMS)) + '.' +
                        IntToStr(HiWord(FI^.dwFileVersionLS)) + '.' +
                        IntToStr(LoWord(FI^.dwFileVersionLS));
                End;
            End
        Finally
            FreeMem(VerBuf);
        End;
    End;
End; //GetFileVer


{ Same as above but only returns version string }
Function GetFileVerStr(aFilename: String): String;
Var aV1, aV2, aV3, aV4: Word;
Begin
    result := GetFileVer(aFilename, aV1, aV2, aV3, aV4);
End;


Function GetIEVer(Var V1, V2, V3, V4: Word): String;
Begin
    result := GetFileVer(GetWinSysDir + '\Shdocvw.dll', V1, V2, V3, V4);
    //trick -- Early versions of IE had only 3 numbers
    If (v1 = 4) And (v2 <= 70) And (v3 = 0) Then
    Begin
        v3 := v4;  v4 := 0;
        result := format('%d.%d.%d.%d', [v1, v2, v3, v4]);
    End;
End;

{
  Version Compare : returns -1 if Va < Vb, 0 if Va = Vb, 1 if Va > Vb
  eg. VerCompar(1,0,0,1, 1,0,0,2) will return -1
  eg. VerCompar(2,0,0,1, 1,0,6,90) will return 1 because 2.0.0.1 is > 1.0.6.90
}
Function VerCompare(va1, va2, va3, va4, vb1, vb2, vb3, vb4: Word): Integer;
Begin
    If (va1 = vb1) And (va2 = vb2) And (va3 = vb3) And (va4 = vb4) Then
        result := 0
    Else
    If (va1 > vb1)
        Or ((va1 = vb1) And (va2 > vb2))
        Or ((va1 = vb1) And (va2 = vb2) And (va3 > vb3))
        Or ((va1 = vb1) And (va2 = vb2) And (va3 = vb3) And (va4 > vb4)) Then
        result := 1
    Else
        result := -1;
End;


{ Get Friendly version numbers for HTML Help 'hhctrl.ocx'
    V1.0 is   4.72.7290 - IE4
    V1.1 is   4.72.7323
    V1.1a is  4.72.7325 - Windows98
    V1.1b is  4.72.8164 - MSDN
    V1.2 is   4.73.8252 - Adds extra search control & Favorites tab
    V1.21 is  4.73.8412 - Bug fixes
    V1.21a is 4.73.8474 - Quick update to fix FTS on CDROM
    V1.22 is  4.73.8561 - This release fixes three bugs in 1.21a that caused problems for Arabic, Hebrew, and Far East languages.
    V1.3 is   4.74.8702 - Win2000 Unicode support
    V1.31 is  4.74.8793 - Minor update
    V1.32 is  4.74.8875 - Windows ME+ IE5.5
    V1.33 is  4.74.9273 - Windows XP+ IE6.0
    V1.4 is   5.2.3626 - Windows XP SP1 - Moved to Windows Version numbering
    V1.4a is  5.2.3669 - Security update and fixes a problem with multi-page print introduced with 1.4 release. 

  return '' if hhctrl.ocx not found, otherwise a version string like '1.2'.

  Get up to date version info from http://helpware.net/htmlhelp/hh_info.htm
}
Function GetHHFriendlyVer: String;
Var  v1, v2, v3, v4: Word; fn, s: String;
Begin
    fn := hh.GetPathToHHCtrlOCX;
    s := GetFileVer(fn, v1, v2, v3, v4);
    If s = '' Then
        result := ''
    Else
    If VerCompare(v1, v2, v3, v4, 5, 2, 3669, 0) > 0 Then
        result := '> 1.4a'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 2, 3669, 0) >= 0 Then
        result := '1.4a'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 2, 3626, 0) >= 0 Then
        result := '1.4'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 74, 9273, 0) >= 0 Then
        result := '1.33'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 74, 8857, 0) >= 0 Then
        result := '1.32'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 74, 8793, 0) >= 0 Then
        result := '1.31'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 74, 8702, 0) >= 0 Then
        result := '1.3'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 73, 8561, 0) >= 0 Then
        result := '1.22'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 73, 8474, 0) >= 0 Then
        result := '1.21a'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 73, 8412, 0) >= 0 Then
        result := '1.21'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 73, 8252, 0) >= 0 Then
        result := '1.2'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 72, 8164, 0) >= 0 Then
        result := '1.1b'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 72, 7325, 0) >= 0 Then
        result := '1.1a'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 72, 7323, 0) >= 0 Then
        result := '1.1'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 72, 7290, 0) >= 0 Then
        result := '1.0'
    Else
        result := '< 1.0';
End;


{
  Check is IE Version x.x.x.x is installed.
  returns
    -1   ... A lesser version of x.x.x.x is installed.
     0   ... x.x.x.x is the version installed
    +1   ... A greater version of x.x.x.x is installed.

  Example
    if Check_IE_Version(4,70,1300,0) < 0 then
      ShowMessage('HtmlHelp requires that you installed IE3.02 or better.');
}
Function Check_IE_Version(x1, x2, x3, x4: Integer): Integer;
Var  v1, v2, v3, v4: Word; fn: String;
Begin
    result := -1;
    fn := GetWinSysDir + '\Shdocvw.dll';
    If GetFileVer(fn, v1, v2, v3, v4) <> '' Then
    Begin
        //trick -- Early versions of IE had only 3 numbers
        If (v1 = 4) And (v2 <= 70) And (v3 = 0) Then
        Begin
            v3 := v4;  v4 := 0;
        End;

        result := VerCompare(v1, v2, v3, v4, x1, x2, x3, x4);
        //Compare installed version with x.x.x.x 
    End;
End;

{
. MediaPlayer 6.4 = 22D6F312-B0F6-11D0-94AB-0080C74C7E95   //MediaPlayer.MediaPlayer.1
   InProc  C:\WINNT\System32\msdxm.ocx  (6.4.9.1117)  (6.4.9.1109)
. MediaPlayer 7.0 = 6BF52A52-394A-11d3-B153-00C04F79FAA6   //WMPlayer.OCX.7
   InProc  C:\WINNT\System32\wmp.ocx (7.1.0.3055)
}
Function Check_WMP_Version(x1, x2, x3, x4: Integer): Integer;
Var  v1, v2, v3, v4: Word; fn: String;
Begin
    result := -1;

    If x1 = 6 Then
        fn := GetWinSysDir + '\msdxm.ocx'           //6.4 player
    Else
    If x1 >= 7 Then
        fn := GetWinSysDir + '\wmp.ocx'             //7.x player
    Else
        Exit;

    If GetFileVer(fn, v1, v2, v3, v4) <> '' Then
        result := VerCompare(v1, v2, v3, v4, x1, x2, x3, x4);
    //Compare installed version with x.x.x.x
End;



{ Get Friendly version numbers of IE (see above)
  return '' if Shdocvw.dll not found. otherwise a descriptive version string

  The following are the versions of Shdocvw.dll and the browser version that each represents
  <major version>.<minor version>.<build number>.<sub-build number>

  From http://support.microsoft.com/support/kb/articles/q164/5/39.asp
  or get up to date version info from http://helpware.net/htmlhelp/hh_info.htm

Shdocvw.dll -------------- May be different from the about box

   Version         Product
   --------------------------------------------------------------
   4.70.1155       Internet Explorer 3.0
   4.70.1158       Internet Explorer 3.0 (OSR2)
   4.70.1215       Internet Explorer 3.01
   4.70.1300       Internet Explorer 3.02
   4.71.1008.3     Internet Explorer 4.0 PP2
   4.71.1712.5     Internet Explorer 4.0
   4.72.2106.7     Internet Explorer 4.01
   4.72.3110.3     Internet Explorer 4.01 Service Pack 1
   4.72.3612.1707  Internet Explorer 4.01 SP2
   5.00.0518.5     Internet Explorer 5 Developer Preview (Beta 1)
   5.00.0910.1308  Internet Explorer 5 Beta (Beta 2)
   5.00.2014.213   Internet Explorer 5.0
   5.00.2314.1000  Internet Explorer 5.0a -- Released with Win98 SE and MSDN
   5.00.2614.3500  Internet Explorer 5.0b -- Contains Java VM and DCOM security patch as an update to Win98 SE
   5.00.2721.1400  Internet Explorer 5 with Update for "ImportExport - Favorites()" Security Issue installed
   5.0.2723.2900   Internet Explorer 5.0 with Update for "Server-side Page Reference Redirect" Issue installed.

   5.00.2919.800    Internet Explorer 5.01 (Windows 2000 RC1, build 5.00.2072)
   5.00.2919.3800   Internet Explorer 5.01 (Windows 2000 RC2, build 5.00.2128)
   5.00.2919.6307   Internet Explorer 5.01
   5.00.2919.6400   Internet Explorer 5.01 with Update for "Server-side Page Reference Redirect" Issue installed.
   5.50.3825.1300   Internet Explorer 5.5 Developer Preview (Beta)

   5.50.4030.2400   Internet Explorer 5.5 & Internet Tools Beta
   5.50.4134.0100   Windows Me (4.90.3000)
   5.50.4134.0600   Internet Explorer 5.5
   5.50.4308.2900   Internet Explorer 5.5 Advanced Security Privacy Beta
   5.50.4522.1800   Internet Explorer 5.5 Service Pack 1

   5.50.4522.1800 Internet Explorer 5.5 Service Pack 1
   5.50.4807.2300 Internet Explorer 5.5 Service Pack 2
   6.00.2462.0000 Internet Explorer 6 Public Preview (Beta)
   6.00.2479.0006 Internet Explorer 6 Public Preview (Beta) Refresh
   6.00.2600.0000 Internet Explorer 6 (Windows XP)
   6.00.2712.300  Internet Explorer 6 patched (Windows XP)   ?????
   6.0.2800.1106 Windows XP SP1

   6.00.2900.2180   Internet Explorer 6 for Windows XP SP2
   6.00.3663.0000   Internet Explorer 6 for Microsoft Windows Server 2003 RC1
   6.00.3718.0000   Internet Explorer 6 for Windows Server 2003 RC2
   6.00.3790.0000   Internet Explorer 6 for Windows Server 2003 (released)

   7.00.5730.1100   Internet Explorer 7 for Windows XP and Windows Server 2003
   7.00.6000.16386  Internet Explorer 7 for Windows Vista

}
Function GetIEFriendlyVer: String;
Var  v1, v2, v3, v4: Word; fn, s: String;
Begin
    fn := GetWinSysDir + '\Shdocvw.dll';
    s := GetFileVer(fn, v1, v2, v3, v4);
    //trick -- Early versions of IE had only 3 numbers
    If (v1 = 4) And (v2 <= 70) And (v3 = 0) Then
    Begin
        v3 := v4;  v4 := 0;
        s := format('%d.%d.%d.%d', [v1, v2, v3, v4]);
    End;

    If s = '' Then
        result := ''
    Else

    If v1 >= 7 Then
        result := '>= Internet Explorer ' + s

    Else
    If VerCompare(v1, v2, v3, v4, 6, 00, 3790, 0000) >= 0 Then
        result := 'Internet Explorer 6 (Windows Server 2003)'
    Else
    If VerCompare(v1, v2, v3, v4, 6, 00, 3718, 0000) >= 0 Then
        result := 'Internet Explorer 6 (Windows Server 2003 RC2)'
    Else
    If VerCompare(v1, v2, v3, v4, 6, 00, 3663, 0000) >= 0 Then
        result := 'Internet Explorer 6 (Windows Server 2003 RC1)'
    Else
    If VerCompare(v1, v2, v3, v4, 6, 00, 2900, 2180) >= 0 Then
        result := 'Internet Explorer 6 (Windows XP SP2)'
    Else
    If VerCompare(v1, v2, v3, v4, 6, 00, 2800, 1106) >= 0 Then
        result := 'Internet Explorer 6 SP1'
    Else
    If VerCompare(v1, v2, v3, v4, 6, 00, 2712, 300) >= 0 Then
        result := 'Internet Explorer 6 (Windows XP + minor update)'
    Else
    If VerCompare(v1, v2, v3, v4, 6, 00, 2600, 0000) >= 0 Then
        result := 'Internet Explorer 6 (Windows XP)'
    Else
    If VerCompare(v1, v2, v3, v4, 6, 00, 2479, 0006) >= 0 Then
        result := 'Internet Explorer 6 Public Preview (Beta) Refresh'
    Else
    If VerCompare(v1, v2, v3, v4, 6, 00, 2462, 0000) >= 0 Then
        result := 'Internet Explorer 6 Public Preview (Beta)'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 50, 4807, 2300) >= 0 Then
        result := 'Internet Explorer 5.5 Service Pack 2'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 50, 4522, 1800) >= 0 Then
        result := 'Internet Explorer 5.5 Service Pack 1'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 50, 4522, 1800) >= 0 Then
        result := 'Internet Explorer 5.5 Service Pack 1'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 50, 4308, 2900) >= 0 Then
        result := 'Internet Explorer 5.5 Advanced Security Privacy Beta'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 50, 4134, 0600) >= 0 Then
        result := 'Internet Explorer 5.5'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 50, 4134, 0100) >= 0 Then
        result := 'Internet Explorer 5.5 for Windows Me (4.90.3000)'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 50, 4030, 2400) >= 0 Then
        result := 'Internet Explorer 5.5 & Internet Tools Beta'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 50, 3825, 1300) >= 0 Then
        result := 'Internet Explorer 5.5 Developer Preview'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 00, 2919, 6400) >= 0 Then
        result := 'Internet Explorer 5.01'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 00, 2919, 6307) >= 0 Then
        result := 'Internet Explorer 5.01'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 00, 2919, 3800) >= 0 Then
        result := 'Internet Explorer 5.01 (Windows 2000 RC2, build 5.00.2128)'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 00, 2919, 800) >= 0 Then
        result := 'Internet Explorer 5.01 (Windows 2000 RC1, build 5.00.2072)'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 00, 2723, 2900) >= 0 Then
        result := 'Internet Explorer 5.0 updated'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 00, 2721, 1400) >= 0 Then
        result := 'Internet Explorer 5.0 updated'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 00, 2614, 0) >= 0 Then
        result := 'Internet Explorer 5.0b'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 00, 2314, 0) >= 0 Then
        result := 'Internet Explorer 5.0a'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 00, 2014, 0) >= 0 Then
        result := 'Internet Explorer 5.0'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 00, 0910, 0) >= 0 Then
        result := 'Internet Explorer 5 Beta (Beta 2)'
    Else
    If VerCompare(v1, v2, v3, v4, 5, 00, 0518, 0) >= 0 Then
        result := 'Internet Explorer 5 Developer Preview (Beta 1)'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 72, 3612, 0) >= 0 Then
        result := 'Internet Explorer 4.01 Service Pack 2 (SP2)'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 72, 3110, 0) >= 0 Then
        result := 'Internet Explorer 4.01 Service Pack 1 (SP1)'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 72, 2106, 0) >= 0 Then
        result := 'Internet Explorer 4.01'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 71, 1712, 0) >= 0 Then
        result := 'Internet Explorer 4.0'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 71, 1008, 0) >= 0 Then
        result := 'Internet Explorer 4.0 Platform Preview 2.0 (PP2)'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 71, 544, 0) >= 0 Then
        result := 'Internet Explorer 4.0 Platform Preview 1.0 (PP1)'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 70, 1300, 0) >= 0 Then
        result := 'Internet Explorer 3.02'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 70, 1215, 0) >= 0 Then
        result := 'Internet Explorer 3.01'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 70, 1158, 0) >= 0 Then
        result := 'Internet Explorer 3.0 (OSR2)'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 70, 1155, 0) >= 0 Then
        result := 'Internet Explorer 3.0'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 40, 520, 0) >= 0 Then
        result := 'Internet Explorer 2.0'
    Else
    If VerCompare(v1, v2, v3, v4, 4, 40, 308, 0) >= 0 Then
        result := 'Internet Explorer 1.0 (Plus!)'
    Else
        result := '< Internet Explorer 1.0 (Plus!)';
End;


{
  Check is HtmlHelp Version x.x.x.x is installed.
  returns
    -1   ... A lesser version of x.x.x.x is installed.
     0   ... x.x.x.x is the version installed
    +1   ... A greater version of x.x.x.x is installed.

  Example
    if Check_HH_Version(4,73,8252,0) < 0 then
      ShowMessage('HtmlHelp 1.2 or greater is required. Please download a new version.');
}
Function Check_HH_Version(x1, x2, x3, x4: Integer): Integer;
Var  v1, v2, v3, v4: Word; fn: String;
Begin
    result := -1;
    fn := hh.GetPathToHHCtrlOCX;
    If GetFileVer(fn, v1, v2, v3, v4) <> '' Then
        result := VerCompare(v1, v2, v3, v4, x1, x2, x3, x4);
End;


{
  ShellExec()
  =============================
  Calls Windows shellexecute(h,'open',...)
  eg. Shellexec('mailto:robert.chandler@osi.varian.com', '');
  Returns TRUE if windows reports no errors
}
Function ShellExec(aFilename: String; aParams: String): Boolean;
Var h: THandle; handle: hWnd;
Begin
  {
    Get Handle of parent window
  }
    If (Screen <> Nil) And (Screen.ActiveForm <> Nil) And
        (Screen.ActiveForm.handle <> 0) Then
        handle := Screen.ActiveForm.handle
    Else
    If Assigned(Application) And Assigned(Application.Mainform) Then
        handle := Application.Mainform.handle
    Else
        handle := 0;

    h := ShellExecute(handle, 'open', Pchar(aFilename), Pchar(aParams),
        Nil, SW_SHOWDEFAULT);
    result := (h > 32);  //success?
    If Not result Then
        ReportError('Function ShellExecute(%s)' + #13
            + 'Returned: %s', [aFilename + ', ' + aParams, GetLastErrorStr]);
End;


{
  Return error description of last error
}
Function GetLastErrorStr: String;
Var ErrCode: Integer;
Begin
    ErrCode := GetlastError;
    Case ErrCode Of
        ERROR_FILE_NOT_FOUND:
            result := st_GLE_FileNotFound;
        ERROR_PATH_NOT_FOUND:
            result := st_GLE_PathNotFound;
        ERROR_ACCESS_DENIED:
            result := st_GLE_AccessDenied;
        ERROR_NOT_ENOUGH_MEMORY:
            result := st_GLE_InsufficientMemory;
        ERROR_WRITE_PROTECT:
            result := st_GLE_MediaIsWriteProtected;
        ERROR_NOT_READY:
            result := st_GLE_DeviceNotReady;
        ERROR_SHARING_VIOLATION,
        ERROR_LOCK_VIOLATION:
            result := st_GLE_FileInUse;
        ERROR_HANDLE_DISK_FULL,
        ERROR_DISK_FULL:
            result := st_GLE_DiskFull;
        ERROR_OLD_WIN_VERSION:
            result := st_GLE_WindowsVersionIncorrect;
        ERROR_APP_WRONG_OS:
            result := st_GLE_NotAWindowsOrMSDosProgram;
        ERROR_EA_FILE_CORRUPT,
        ERROR_UNRECOGNIZED_VOLUME,
        ERROR_FILE_CORRUPT,
        ERROR_DISK_CORRUPT:
            result := st_GLE_CorruptFileOrDisk;
        ERROR_BADDB,
        ERROR_INTERNAL_DB_CORRUPTION:
            result := st_GLE_CorruptRegistry;
    Else
        result := st_GLE_GeneralFailure;
    End; {case}
    result := '[Error:' + IntToStr(ErrCode) + '] ' + result;
End;


{
  Get a value from the registry
  dataName = '' for default value.
  Returns '' if not found
}
Function GetRegStr(rootkey: HKEY; Const key, dataName: String): String;
Var rg: TRegistry;
Begin
    result := '';  //default return
    rg := TRegistry.Create;
    rg.RootKey := rootkey;

{$IFDEF D4PLUS} // -- Delphi >=4
  if rg.OpenKeyReadOnly(key) AND rg.ValueExists(dataName) then //safer call under NT
{$ELSE}// -- Delphi 2, 3
    If rg.OpenKey(key, False) And rg.ValueExists(dataName) Then
{$ENDIF}
    Begin
        result := rg.ReadString(dataName);
        rg.CloseKey;
    End;
    rg.Free;
End;


Function RegKeyNameExists(rootkey: HKEY; Const key, dataName: String): Boolean;
Var rg: TRegistry;
Begin
    rg := TRegistry.Create;
    rg.RootKey := rootkey;
{$IFDEF D4PLUS} // -- Delphi >=4
  Result := rg.OpenKeyReadOnly(key) AND rg.ValueExists(dataName); //safer call under NT
{$ELSE}// -- Delphi 2, 3
    Result := rg.OpenKey(key, False) And rg.ValueExists(dataName);
{$ENDIF}
    If Result Then
        rg.CloseKey;
    rg.Free;
End;


{
  Creates a Key and addes a Value
  An absolute key begins with a backslash (\) and is a subkey of the root key.
}
Procedure PutRegStr(rootkey: HKEY; Const key, name, value: String);
Var rg: TRegistry;
Begin
    rg := TRegistry.Create;
    rg.RootKey := rootkey;
    If rg.OpenKey(key, True {create if not found}) Then
    Begin
        rg.WriteString(name, value);
        rg.CloseKey;
    End;
    rg.Free;
End;


{
  Sometimes the only way we can test if a drive is writable is to write a test file.
  aDir is some Dir on a valid disk drive
}
Function IsDirWritable(aDir: String): Boolean;
Var F: File; fn: String;
Begin
    StripR(aDir, '\');  //no trailing slash
    fn := aDir + '\$_Temp_$.$$$';   //Any abnormal filename will do
    FileMode := 2;  //read/write
    AssignFile(F, fn);
  {$I-} Rewrite(F, 1);
    result := (IOResult = 0);
    If result Then
    Begin
        CloseFile(F);
        DeleteFile(fn);
    End;
End;

{Check if a directory name is vaid}
Function DirExists(dirName: String): Boolean;
Var SearchRec: TSearchRec;
Begin
    Result := (SysUtils.FindFirst(dirName, faDirectory, SearchRec) = 0)
        And ((SearchRec.Attr And faDirectory) <> 0);
    SysUtils.FindClose(SearchRec);
End;

{----------------------- Debug Log File -------------------------------}

{ Debug Log file. If no file is specified then the default
  folder and filename is used. If the folder is readonly
  then the Log file is created in the Windows Temp folder.

  dbg := TDLogFile.Create(filename, _DebugMode, false, false, false);
  dbg.Reset;
  dbg.debugout('text out',[])
  ...
  dbg.Free;
}
Constructor TDLogFile.Create(aFilename: String; aDebugMode: Boolean;
    aTimeStamp: Boolean; aHeaderDump, aAppendMode: Boolean);
Var Dir: String;
Begin
    If aFilename = '' Then
        aFilename := DBG_DIR + DBG_FILENAME;

    //Valid Directory? If not default to Windows Temp Dir
    Dir := SysUtils.ExtractFilePath(aFilename);
    StripR(Dir, '\');
    If Not (DirectoryExists(Dir) And IsDirWritable(Dir)) Then
        aFilename := GetWinTempDir + '\' + SysUtils.ExtractFileName(aFilename);

    Self.FFilename := aFilename;
    Self.FDebugMode := aDebugMode;
    Self.FTimeStamp := aTimeStamp;
    Self.FHeaderDump := aHeaderDump;
    Self.FAppendMode := aAppendMode;

    //Clear any file attributes
    If FileExists(aFilename) Then
        FileSetAttr(aFilename, 0);

    Self.Reset;
End;

Destructor TDLogFile.Destroy;
Begin
End;

//Save the current log to another location
Procedure TDLogFile.CopyLogTo(aNewFilename: String);
Var SL: TStringList;
Begin
    SL := TStringList.Create;
    If FileExists(FFilename) Then
        SL.LoadFromFile(FFilename);
    Try
        SL.SaveToFile(aNewFilename);
    Except
    End;
    SL.Free;
End;

Procedure TDLogFile.DebugOut(msgStr: String; Const Args: Array Of Const);
Var f: TextFile; s, timedate: String;
Begin
  {$I-}
    AssignFile(f, FFilename);
    If (Not FileExists(FFilename))
    Then
        Rewrite(f)  //create
    Else Append(f);

    If FTimeStamp
    Then
        timedate := TimeToStr(now) + '   '
    Else timedate := '';

    If ioresult = 0 Then
    Begin
        Try
            If (Length(Args) = 0)
            Then
                s := msgStr
            Else s := format(msgStr, Args);
            If s = '-' Then   //separator
                s := MkStr('-', 80);
            If s = '=' Then   //separator
                s := MkStr('=', 80);
            If (s <> '') And (s[1] In ['-', '=', '!'])
            Then
                s := Copy(S, 2, maxint)
            Else s := timedate + s;
            Writeln(f, s);
            Flush(f);
        Finally
            CloseFile(f);
        End;
    End;
End;

{Same as above but checks the debug flag before wrieting output}
Procedure TDLogFile.DebugOut2(msgStr: String; Const Args: Array Of Const);
Begin
    If FDebugMode Then
        DebugOut(msgStr, Args);
End;

{All Errors reported here. Uses same format as the Delphi Format() function }
Procedure TDLogFile.ReportError(errStr: String; Const Args: Array Of Const);
Var s: String;
Begin
    s := format(errStr, Args);
    MessageBox2(s, MB_OK Or MB_ICONWARNING);
    If FDebugMode Then
        DebugOut(s, ['']);
End;

{Display Log file in default viewer}
Procedure TDLogFile.Show;
Begin
    If FileExists(FFilename)
    Then
        ShellExec(FFilename, '')
    Else ShowMessage2('File not found'#13 + FFilename + #13 +
            'Debug Enabled = ' + IntToStr(Integer(FDebugMode)));
End;


{ Returns a suitable Folder for the log file - No Trailing \
  With the current dir where this EXE or DLL lives (if writable)
  or the window temp dir
}
Function TDLogFile.GetLogDir: String;
Begin
    Result := DBG_DIR;
End;



{Delete and start a new debug file
  FHeaderDump - Dump block of system info (usefull for debugging latter)
  FAppendMode - If false always delete any previous log file. If true prev log file will be appended to.
}
Procedure TDLogFile.Reset;
Var i: Integer; s, os, spack: String;
Begin
    If FileExists(FFilename) And (Not FAppendMode) Then
        DeleteFile(FFilename);

    If FDebugMode And FHeaderDump Then
    Begin
        DebugOut('=', ['']);
        DebugOut('!Log File:             %s', [#9 + FFilename]);
        DebugOut('!Date:                 %s', [#9 + DateTimeToStr(now)]);
{$IFDEF D3PLUS} // -- Delphi >=3
    if Win32CSDVersion <> ''
      then spack := Win32CSDVersion
      else spack := 'No Service Pack';

    if SysUtils.Win32Platform = VER_PLATFORM_WIN32_NT then
    begin
      if (Win32MajorVersion = 4) then
         os := 'Windows NT4'
      else if (Win32MajorVersion = 5) and (Win32MinorVersion = 0) then
         os := 'Windows 2000'
      else if (Win32MajorVersion = 5) and (Win32MinorVersion = 1) then
         os := 'Windows XP'
      else
         os := 'Windows NT';
      DebugOut('!Operating System:      %s %d.%d (Build %d) %s',[#9+os,Win32MajorVersion, Win32MinorVersion, Win32BuildNumber, spack]);
    end
    else DebugOut('!Operating System:      %s %d.%d (Build %d) %s',[#9'Windows',Win32MajorVersion, Win32MinorVersion, Win32BuildNumber, spack]);

    DebugOut('!SysLocale.DefaultLCID: %s (%s)',[#9+'0x'+IntToHex(SysLocale.DefaultLCID, 4), inttostr(SysLocale.DefaultLCID)]);
    DebugOut('!SysLocale.PriLangID:   %s (%s)',[#9+'0x'+IntToHex(SysLocale.PriLangID, 4), inttostr(SysLocale.PriLangID)]);
    DebugOut('!SysLocale.SubLangID:   %s (%s)',[#9+'0x'+IntToHex(SysLocale.SubLangID, 4), inttostr(SysLocale.SubLangID)]);
{$ENDIF}
        DebugOut('!DecimalSeparator:      %s', [#9 + DecimalSeparator]);

        DebugOut('-', ['']);
        DebugOut('!EXE Path =          %s', [#9 + ParamStr(0)]);
        DebugOut('!EXE Version =       %s', [#9 + GetFileVerStr(ParamStr(0))]);

        s := '';
        For i := 1 To ParamCount Do
        Begin
            If s <> '' Then
                s := s + ' | ';
            s := s + ParamStr(i);
        End;
        DebugOut('!Cmdline Param(s) =  %s', [#9 + s]);
        DebugOut('!Actual CmdLine =  %s', [#9 + CmdLine]);
        DebugOut('!_RunDir =           %s', [#9 + _RunDir]);
        DebugOut('!_ModuleName =       %s', [#9 + _ModuleName]);
        DebugOut('!_ModuleDir =        %s', [#9 + _ModuleDir]);
        DebugOut('!_ModulePath =        %s', [#9 + _ModulePath]);
        DebugOut('!Module Version =       %s', [#9 + GetFileVerStr(_ModulePath)]);

        DebugOut('-', ['']);
        DebugOut('!_hhInstalled =      %s', [#9 + BoolToYN(_hhInstalled)]);
        DebugOut('!_hhVerStr =         %s', [#9 + _hhVerStr]);
        DebugOut('!_hhFriendlyVerStr = %s', [#9 + _hhFriendlyVerStr]);
        DebugOut('-', ['']);
        DebugOut('!_ieInstalled =      %s', [#9 + BoolToYN(_ieInstalled)]);
        DebugOut('!_ieVerStr =         %s', [#9 + _ieVerStr]);
        DebugOut('!_ieFriendlyVerStr = %s', [#9 + _ieFriendlyVerStr]);
        DebugOut('=', ['']);
    End;
End;



Procedure DebugOut(msgStr: String; Const Args: Array Of Const);
Begin
    _HHDbgObj.DebugOut(msgStr, Args);
End;

Procedure DebugOut2(msgStr: String; Const Args: Array Of Const);
Begin
    _HHDbgObj.DebugOut2(msgStr, Args);  //Only add to log if debug is enabled
End;

Procedure ShowDebugFile;
Begin
    _HHDbgObj.Show;           //Display Debug Log file
End;

Procedure ResetDebugFile;
Begin
    _HHDbgObj.Reset;
End;

Procedure ReportError(errStr: String; Const Args: Array Of Const);
Begin
    _HHDbgObj.ReportError(errStr, Args);
    //Popup Warning and if debug enabled log it
End;


{ Module initialization }
Procedure ModuleInit;
Var
    v1, v2, v3, v4, i: Word;
    FileName: Array[0..300] Of Char;
Begin
    //Get run dir & Progname - or DLL or EXE
    GetModuleFileName(HInstance, FileName, SizeOf(FileName));
    _ModulePath := Filename;
    _ModuleDir := SysUtils.ExtractFilePath(_ModulePath);
    _ModuleName := SysUtils.ExtractFileName(_ModulePath);
    StripR(_ModuleDir, '\');

    { get run dir }
    _RunDir := ExtractFilePath(ParamStr(0));
    StripR(_RunDir, '\');

    { Debug Dir is current dir, Or root of Windows dir if readonly. CD? }
    If IsDirWritable(_ModuleDir) Then
        DBG_DIR := _ModuleDir        //Where EXE or DLL lives
    Else
        DBG_DIR := GetWinTempDir;    //Window Temp folder

    {debug mode enabled is file debug.debug found in the Modules dir OR a /debug or -debug cmdline switch}
    _DebugMode := FileExists(_ModuleDir + '\debug.debug');
    If Not _DebugMode Then
        For i := 1 To ParamCount Do
            If (CompareText(paramstr(i), '/debug') = 0) Or
                (CompareText(paramstr(i), '-debug') = 0) Then
            Begin
                _DebugMode := True;
                break;
            End;

    {get version info of 'hhctrl.ocx' - returns '' and 0s if not found}
    _hhVerStr := GetFileVer(hh.GetPathToHHCtrlOCX, _hhMajVer,
        _hhMinVer, _hhBuildNo, _hhSubBuildNo);

    _hhInstalled := (_hhVerStr <> '');
    _hhFriendlyVerStr := GetHHFriendlyVer;

    {ie info}
    _ieVerStr := GetIEVer(v1, v2, v3, v4);
    _ieInstalled := (_ieVerStr <> '');
    _ieFriendlyVerStr := GetIEFriendlyVer;

    //Create Debug file - _DebugMode, TimeStamp:Yes, HeaderDump:Yes, AppendMode:No
    _HHDbgObj := TDLogFile.Create(DBG_DIR + DBG_FILENAME, _DebugMode,
        DBG_TIMESTAMP, DBG_HEADERDUMP, DBG_APPENDMODE);
End;


Initialization
    ModuleInit;
Finalization
    _HHDbgObj.Free;
End.
