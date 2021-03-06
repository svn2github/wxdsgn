{
    $Id: devcpp.dpr 853 2007-01-23 13:20:54Z lowjoel $

    This file is part of Dev-C++
    Copyright (c) 2004 Bloodshed Software

    Dev-C++ is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Dev-C++ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Dev-C++; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

program devcpp;

{$WARN SYMBOL_PLATFORM OFF}

uses
    LanguagesDEPFix,
    madListHardware,
    madListProcesses,
    madListModules,
    madExcept,
    madLinkDisAsm,
    inifiles,
    Windows,
    Forms,
    SHFolder,
    Dialogs,
    sysUtils,
    main in 'main.pas' {MainForm},
    MultiLangSupport in 'MultiLangSupport.pas',
    Splash in 'Splash.pas' {SplashForm},
    version in 'version.pas',
    utils in 'utils.pas',
    LangFrm in 'LangFrm.pas' {LangForm},
    project in 'project.pas',
    Templates in 'Templates.pas',
    NewProjectFrm in 'NewProjectFrm.pas' {NewProjectForm},
    RemoveUnitFrm in 'RemoveUnitFrm.pas' {RemoveUnitForm},
    GotoLineFrm in 'GotoLineFrm.pas' {GotoLineForm},
    PrintFrm in 'PrintFrm.pas' {PrintForm},
    AboutFrm in 'AboutFrm.pas' {AboutForm},
    compiler in 'compiler.pas',
    devrun in 'devrun.pas',
    ProjectOptionsFrm in 'ProjectOptionsFrm.pas' {ProjectOptionsForm},
    CompOptionsFrm in 'CompOptionsFrm.pas' {CompForm},
    ToolFrm in 'ToolFrm.pas' {ToolForm},
    ToolEditFrm in 'ToolEditFrm.pas' {ToolEditForm},
    IconFrm in 'IconFrm.pas' {IconForm},
    devcfg in 'devcfg.pas',
    datamod in 'datamod.pas' {dmMain: TDataModule},
    helpfrm in 'helpfrm.pas' {frmHelpEdit},
    EditorOptfrm in 'EditorOptfrm.pas' {EditorOptForm},
    CodeIns in 'CodeIns.pas' {frmCodeEdit},
    Incrementalfrm in 'Incrementalfrm.pas' {frmIncremental},
    Search_Center in 'Search_Center.pas',
    Replacefrm in 'Replacefrm.pas' {frmReplace},
    Findfrm in 'Findfrm.pas' {frmFind},
    editor in 'editor.pas',
    Envirofrm in 'Envirofrm.pas' {EnviroForm},
    debugger in 'debugger.pas',
    CFGData in 'CFGData.pas',
    CFGINI in 'CFGINI.pas',
    CFGReg in 'CFGReg.pas',
    prjtypes in 'prjtypes.pas',
    debugfrm in 'debugfrm.pas' {DebugForm},
    Macros in 'Macros.pas',
    devExec in 'devExec.pas',
    NewTemplateFm in 'NewTemplateFm.pas' {NewTemplateForm},
    FunctionSearchFm in 'FunctionSearchFm.pas' {FunctionSearchForm},
    NewVarFm in 'NewVarFm.pas' {NewVarForm},
    NewMemberFm in 'NewMemberFm.pas' {NewMemberForm},
    NewClassFm in 'NewClassFm.pas' {NewClassForm},
    ProfileAnalysisFm in 'ProfileAnalysisFm.pas' {ProfileAnalysisForm},
    FilePropertiesFm in 'FilePropertiesFm.pas' {FilePropertiesForm},
    AddToDoFm in 'AddToDoFm.pas' {AddToDoForm},
    ImportMSVCFm in 'ImportMSVCFm.pas' {ImportMSVCForm},
    FileAssocs in 'FileAssocs.pas',
    TipOfTheDayFm in 'TipOfTheDayFm.pas' {TipOfTheDayForm},
    CVSFm in 'CVSFm.pas' {CVSForm},
    WindowListFrm in 'WindowListFrm.pas' {WindowListForm},
    CVSThread in 'CVSThread.pas',
    CVSPasswdFm in 'CVSPasswdFm.pas' {CVSPasswdForm},
    DevThemes in 'DevThemes.pas',
    ParamsFrm in 'ParamsFrm.pas' {ParamsForm},
    CompilerOptionsFrame in 'CompilerOptionsFrame.pas' {CompOptionsFrame: TFrame},
    CompileProgressFm in 'CompileProgressFm.pas' {CompileProgressForm},
    ProcessListFrm in 'ProcessListFrm.pas' {ProcessListForm},
    ModifyVarFrm in 'ModifyVarFrm.pas' {ModifyVarForm},
    FilesReloadFrm in 'FilesReloadFrm.pas' {FilesReloadFrm},
    PackmanExitCodesU in '..\..\packman\PackmanExitCodesU.pas',
    ImageTheme in 'ImageTheme.pas',
    iplugin_dll in 'plugins\interfaces\iplugin_dll.pas',
    iplugger in 'plugins\interfaces\iplugger.pas',
    iplugin in 'plugins\interfaces\iplugin.pas',
    iplugin_bpl in 'plugins\interfaces\iplugin_bpl.pas',
    hh in 'hh.pas',
    hh_funcs in 'hh_funcs.pas',
    SynAutoIndent in 'packages\SynAutoIndent.pas',
    debugCPU in 'debugCPU.pas' {DebugCPUFrm};

{$R 'winxp.res'}
{$R 'icons.res' 'icons.rc'}
{$R 'DefaultFiles.res' 'DefaultFiles.rc'}
{$R 'LangFrm.res' 'LangFrm.rc'}
{$R *.res}

{$IFDEF PLUGIN_BUILD}
{$R STDREG.res}
{$ENDIF}

//Single Instance feature
function CanStart: boolean;
var
    Wdw: HWND;
begin
    Wdw := DuplicateAppInstWdw;
    if Wdw = 0 then
        Result := TRUE
    else
        Result := not SwitchToPrevInst(Wdw);
end;

const
WXVERSION = 7;
var
    // ConfigMode moved to devcfg, 'cause I need it in enviroform (for AltConfigFile)
    UserHome, strLocalAppData, strAppData, strIniFile: string;
    tempc: array [0..MAX_PATH] of char;
    iniFile: TIniFile;
    paramIndex: integer;
    paramString: string;
    configFound: boolean;
    versionNum: integer;

begin
    strIniFile := ChangeFileExt(ExtractFileName(Application.EXEName), INI_EXT);

    configFound := FALSE;
    paramString := '';

    if (ParamCount > 0) then
    begin

        paramIndex := 1;

        while ((paramIndex <= ParamCount) and (not configFound)) do
        begin
            if ((ParamStr(paramIndex) = CONFIG_PARAM)
                and ((paramIndex + 1) <= ParamCount)) then
            begin

                paramString := IncludeTrailingPathDelimiter(GetRealPath(ParamStr(paramIndex + 1), GetCurrentDir));

                if not DirectoryExists(paramString) then
                    if not ForceDirectories(paramString) then
                    begin
                        ShowMessage('The configuration directory ' + #10#13 +
                            paramString + #10#13 +
                            ' does not exist and we were unable to ' +
                            'create it. Please check that the path is not read-only and that ' +
                            'you have sufficient privilieges to write to it.'#10#13#10#13 +
                            'wxDev-C++ will now exit.');
                        Application.Terminate;
                    end;

                devData.INIFile := paramString + strIniFile;
                ConfigMode := CFG_PARAM;
                configFound := TRUE;
            end;

            paramIndex := paramIndex + 1;

        end;
    end;

    if not configFound then
    begin

        if IsWinNT then
        begin
        //default dir should be %APPDATA%\Dev-Cpp
            strLocalAppData := '';
            if SUCCEEDED(SHGetFolderPath(0, CSIDL_LOCAL_APPDATA, 0, 0, tempc)) then
                strLocalAppData := IncludeTrailingPathDelimiter(string(tempc));

            strAppData := '';
            if SUCCEEDED(SHGetFolderPath(0, CSIDL_APPDATA, 0, 0, tempc)) then
                strAppData := IncludeTrailingPathDelimiter(string(tempc));

            if (strLocalAppData <> '') and FileExists(strLocalAppData +
                strIniFile) then
            begin
                UserHome := strLocalAppData;
                devData.INIFile := UserHome + strIniFile;
                ConfigMode := CFG_USER;
            end
            else
            if (strAppData <> '') and FileExists(strAppData + strIniFile) then
            begin
                UserHome := strAppData;
                devData.INIFile := UserHome + strIniFile;
                ConfigMode := CFG_USER;
            end
            else
            if (strAppData <> '') and (DirectoryExists(strAppData + 'Dev-Cpp') or
                CreateDir(strAppData + 'Dev-Cpp')) then
            begin
                UserHome := strAppData + 'Dev-Cpp\';
                devData.INIFile := UserHome + strIniFile;
                ConfigMode := CFG_USER;
            end
            else
                devData.INIFile := ChangeFileExt(Application.EXEName, INI_EXT);
        end
        else
            devData.INIFile := ChangeFileExt(Application.EXEName, INI_EXT);

    end;

    if FileExists(devData.INIFile + '.ver') = FALSE then
    begin
        DeleteFile(devData.INIFile);
    end;
    iniFile := TIniFile.Create(devData.INIFile + '.ver');
    try
        versionNum := iniFile.ReadInteger('Program', 'Version', -1);
        if versionNum <> WXVERSION then
            DeleteFile(devData.INIFile);
        iniFile.WriteInteger('Program', 'Version', WXVERSION);
    finally
        iniFile.Free;
    end;

    devData.UseRegistry := FALSE;
    devData.BoolAsWords := FALSE;
    devData.INISection := OPT_OPTIONS;

    // support for user-defined alternate ini file (permanent, but overriden by command-line -c)
    if ConfigMode <> CFG_PARAM then
    begin
        StandardConfigFile := devData.INIFile;
        CheckForAltConfigFile(devData.INIFile);
        if UseAltConfigFile and (AltConfigFile <> '') and
            FileExists(AltConfigFile) then
            devData.INIFile := AltConfigFile;
    end;

    InitializeOptions;
    if ConfigMode = CFG_PARAM then
        devDirs.Config := paramString
    else
    if ConfigMode = CFG_USER then
        devDirs.Config := UserHome;

    devData.ReadConfigData;

    if devData.SingleInstance then
        if not CanStart then
            exit;
    devTheme := TdevTheme.Create;
    Application.Initialize;
    Application.Title := 'wxDev-C++';
    Application.HelpFile := '..\Help\devcpp.chm';
    Application.CreateForm(TMainForm, MainForm);
    if not devData.NoSplashScreen then
    begin
        SplashForm := TSplashForm.Create(Application);
        SplashForm.Show;
        SplashForm.Update;
    end;

    // do all the initialization when the splash screen is displayed
    // because it takes quite a while to complete
    Application.CreateForm(TfrmIncremental, frmIncremental);
    Application.CreateForm(TfrmFind, frmFind);
    Application.CreateForm(TfrmReplace, frmReplace);
    MainForm.DoCreateEverything;

    // EAB: try to fix include directories with plugins
    InitializeOptionsAfterPlugins;

    // apply the window placement. this method forces the form to show.
    MainForm.DoApplyWindowPlacement;
    if not devData.NoSplashScreen then
        SplashForm.Free;

    if devData.ShowTipsOnStart and (ParamCount = 0) then
        // do not show tips if dev-c++ is launched with a file
        MainForm.actShowTips.Execute;

    Application.Run;
end.
