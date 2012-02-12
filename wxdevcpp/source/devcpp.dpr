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

Program devcpp;

{$WARN SYMBOL_PLATFORM OFF}

Uses
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
    main In 'main.pas' {MainForm},
    MultiLangSupport In 'MultiLangSupport.pas',
    Splash In 'Splash.pas' {SplashForm},
    version In 'version.pas',
    utils In 'utils.pas',
    LangFrm In 'LangFrm.pas' {LangForm},
    project In 'project.pas',
    Templates In 'Templates.pas',
    NewProjectFrm In 'NewProjectFrm.pas' {NewProjectForm},
    RemoveUnitFrm In 'RemoveUnitFrm.pas' {RemoveUnitForm},
    GotoLineFrm In 'GotoLineFrm.pas' {GotoLineForm},
    PrintFrm In 'PrintFrm.pas' {PrintForm},
    AboutFrm In 'AboutFrm.pas' {AboutForm},
    compiler In 'compiler.pas',
    devrun In 'devrun.pas',
    ProjectOptionsFrm In 'ProjectOptionsFrm.pas' {ProjectOptionsForm},
    CompOptionsFrm In 'CompOptionsFrm.pas' {CompForm},
    ToolFrm In 'ToolFrm.pas' {ToolForm},
    ToolEditFrm In 'ToolEditFrm.pas' {ToolEditForm},
    IconFrm In 'IconFrm.pas' {IconForm},
    devcfg In 'devcfg.pas',
    datamod In 'datamod.pas' {dmMain: TDataModule},
    helpfrm In 'helpfrm.pas' {frmHelpEdit},
    EditorOptfrm In 'EditorOptfrm.pas' {EditorOptForm},
    CodeIns In 'CodeIns.pas' {frmCodeEdit},
    Incrementalfrm In 'Incrementalfrm.pas' {frmIncremental},
    Search_Center In 'Search_Center.pas',
    Replacefrm In 'Replacefrm.pas' {frmReplace},
    Findfrm In 'Findfrm.pas' {frmFind},
    editor In 'editor.pas',
    Envirofrm In 'Envirofrm.pas' {EnviroForm},
    debugger In 'debugger.pas',
    CFGData In 'CFGData.pas',
    CFGINI In 'CFGINI.pas',
    CFGReg In 'CFGReg.pas',
    prjtypes In 'prjtypes.pas',
    debugfrm In 'debugfrm.pas' {DebugForm},
    Macros In 'Macros.pas',
    devExec In 'devExec.pas',
    NewTemplateFm In 'NewTemplateFm.pas' {NewTemplateForm},
    FunctionSearchFm In 'FunctionSearchFm.pas' {FunctionSearchForm},
    NewVarFm In 'NewVarFm.pas' {NewVarForm},
    NewMemberFm In 'NewMemberFm.pas' {NewMemberForm},
    NewClassFm In 'NewClassFm.pas' {NewClassForm},
    ProfileAnalysisFm In 'ProfileAnalysisFm.pas' {ProfileAnalysisForm},
    FilePropertiesFm In 'FilePropertiesFm.pas' {FilePropertiesForm},
    AddToDoFm In 'AddToDoFm.pas' {AddToDoForm},
    ImportMSVCFm In 'ImportMSVCFm.pas' {ImportMSVCForm},
    FileAssocs In 'FileAssocs.pas',
    TipOfTheDayFm In 'TipOfTheDayFm.pas' {TipOfTheDayForm},
    CVSFm In 'CVSFm.pas' {CVSForm},
    WindowListFrm In 'WindowListFrm.pas' {WindowListForm},
    CVSThread In 'CVSThread.pas',
    CVSPasswdFm In 'CVSPasswdFm.pas' {CVSPasswdForm},
    DevThemes In 'DevThemes.pas',
    ParamsFrm In 'ParamsFrm.pas' {ParamsForm},
    CompilerOptionsFrame In 'CompilerOptionsFrame.pas' {CompOptionsFrame: TFrame},
    CompileProgressFm In 'CompileProgressFm.pas' {CompileProgressForm},
    ProcessListFrm In 'ProcessListFrm.pas' {ProcessListForm},
    ModifyVarFrm In 'ModifyVarFrm.pas' {ModifyVarForm},
    FilesReloadFrm In 'FilesReloadFrm.pas' {FilesReloadFrm},
    PackmanExitCodesU In '..\..\packman\PackmanExitCodesU.pas',
    ImageTheme In 'ImageTheme.pas',
    iplugin_dll In 'plugins\interfaces\iplugin_dll.pas',
    iplugger In 'plugins\interfaces\iplugger.pas',
    iplugin In 'plugins\interfaces\iplugin.pas',
    iplugin_bpl In 'plugins\interfaces\iplugin_bpl.pas',
    hh In 'hh.pas',
    hh_funcs In 'hh_funcs.pas',
    SynAutoIndent In 'packages\SynAutoIndent.pas',
    debugCPU In 'debugCPU.pas' {DebugCPUFrm};

{$R 'winxp.res'}
{$R 'icons.res' 'icons.rc'}
{$R 'DefaultFiles.res' 'DefaultFiles.rc'}
{$R 'LangFrm.res' 'LangFrm.rc'}
{$R *.res}

{$IFDEF PLUGIN_BUILD}
{$R STDREG.res}
{$ENDIF}

//Single Instance feature
Function CanStart: Boolean;
Var
    Wdw: HWND;
Begin
    Wdw := DuplicateAppInstWdw;
    If Wdw = 0 Then
        Result := True
    Else
        Result := Not SwitchToPrevInst(Wdw);
End;

Const
WXVERSION = 7;
Var
    // ConfigMode moved to devcfg, 'cause I need it in enviroform (for AltConfigFile)
    UserHome, strLocalAppData, strAppData, strIniFile: String;
    tempc: Array [0..MAX_PATH] Of Char;
    iniFile: TIniFile;
    paramIndex: Integer;
    paramString: String;
    configFound: Boolean;
    versionNum: Integer;

Begin
    strIniFile := ChangeFileExt(ExtractFileName(Application.EXEName), INI_EXT);

    configFound := False;
    paramString := '';

    If (ParamCount > 0) Then
    Begin

        paramIndex := 1;

        While ((paramIndex <= ParamCount) And (Not configFound)) Do
        Begin
            If ((ParamStr(paramIndex) = CONFIG_PARAM)
                And ((paramIndex + 1) <= ParamCount)) Then
            Begin

                paramString := IncludeTrailingPathDelimiter(ParamStr(paramIndex + 1));

                If Not DirectoryExists(paramString) Then
                    If Not ForceDirectories(paramString) Then
                    Begin
                        ShowMessage('The configuration directory #10#13#10#13' +
                            paramString +
                            '#10#13#10#13does not exist and we were unable to ' +
                            'create it. Please check that the path is not read-only and that ' +
                            'you have sufficient privilieges to write to it.'#10#13#10#13 +
                            'wxDev-C++ will now exit.');
                        Application.Terminate;
                    End;

                devData.INIFile := paramString + strIniFile;
                ConfigMode := CFG_PARAM;
                configFound := True;
            End;

            paramIndex := paramIndex + 1;

        End;
    End;

    If Not configFound Then
    Begin

        If IsWinNT Then
        Begin
        //default dir should be %APPDATA%\Dev-Cpp
            strLocalAppData := '';
            If SUCCEEDED(SHGetFolderPath(0, CSIDL_LOCAL_APPDATA, 0, 0, tempc)) Then
                strLocalAppData := IncludeTrailingPathDelimiter(String(tempc));

            strAppData := '';
            If SUCCEEDED(SHGetFolderPath(0, CSIDL_APPDATA, 0, 0, tempc)) Then
                strAppData := IncludeTrailingPathDelimiter(String(tempc));

            If (strLocalAppData <> '') And FileExists(strLocalAppData +
                strIniFile) Then
            Begin
                UserHome := strLocalAppData;
                devData.INIFile := UserHome + strIniFile;
                ConfigMode := CFG_USER;
            End
            Else
            If (strAppData <> '') And FileExists(strAppData + strIniFile) Then
            Begin
                UserHome := strAppData;
                devData.INIFile := UserHome + strIniFile;
                ConfigMode := CFG_USER;
            End
            Else
            If (strAppData <> '') And (DirectoryExists(strAppData + 'Dev-Cpp') Or
                CreateDir(strAppData + 'Dev-Cpp')) Then
            Begin
                UserHome := strAppData + 'Dev-Cpp\';
                devData.INIFile := UserHome + strIniFile;
                ConfigMode := CFG_USER;
            End
            Else
                devData.INIFile := ChangeFileExt(Application.EXEName, INI_EXT);
        End
        Else
            devData.INIFile := ChangeFileExt(Application.EXEName, INI_EXT);

    End;

    If FileExists(devData.INIFile + '.ver') = False Then
    Begin
        DeleteFile(devData.INIFile);
    End;
    iniFile := TIniFile.Create(devData.INIFile + '.ver');
    Try
        versionNum := iniFile.ReadInteger('Program', 'Version', -1);
        If versionNum <> WXVERSION Then
            DeleteFile(devData.INIFile);
        iniFile.WriteInteger('Program', 'Version', WXVERSION);
    Finally
        iniFile.Free;
    End;

    devData.UseRegistry := False;
    devData.BoolAsWords := False;
    devData.INISection := OPT_OPTIONS;

    // support for user-defined alternate ini file (permanent, but overriden by command-line -c)
    If ConfigMode <> CFG_PARAM Then
    Begin
        StandardConfigFile := devData.INIFile;
        CheckForAltConfigFile(devData.INIFile);
        If UseAltConfigFile And (AltConfigFile <> '') And
            FileExists(AltConfigFile) Then
            devData.INIFile := AltConfigFile;
    End;

    InitializeOptions;
    If ConfigMode = CFG_PARAM Then
        devDirs.Config := paramString
    Else
    If ConfigMode = CFG_USER Then
        devDirs.Config := UserHome;

    devData.ReadConfigData;

    If devData.SingleInstance Then
        If Not CanStart Then
            exit;
    devTheme := TdevTheme.Create;
    Application.Initialize;
    Application.Title := 'wxDev-C++';
    Application.HelpFile := '..\Help\devcpp.chm';
    Application.CreateForm(TMainForm, MainForm);
    If Not devData.NoSplashScreen Then
    Begin
        SplashForm := TSplashForm.Create(Application);
        SplashForm.Show;
        SplashForm.Update;
    End;

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
    If Not devData.NoSplashScreen Then
        SplashForm.Free;

    If devData.ShowTipsOnStart And (ParamCount = 0) Then
        // do not show tips if dev-c++ is launched with a file
        MainForm.actShowTips.Execute;

    Application.Run;
End.
