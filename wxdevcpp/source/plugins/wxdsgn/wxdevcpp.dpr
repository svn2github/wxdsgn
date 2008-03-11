{
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

{$R '..\..\icons.res' '..\..\icons.rc'}
{$R '..\..\LangFrm.res' '..\..\LangFrm.rc'}
{$R '..\..\DefaultFiles.res' '..\..\DefaultFiles.rc'}

{$WARN SYMBOL_PLATFORM OFF}

uses
  FastMM4,
  FastCode,
  LanguagesDEPFix,
  Windows,
  Forms,
  sysUtils,
  SHFolder,
  Dialogs,
  main in '..\..\main.pas' {MainForm},
  MultiLangSupport in '..\..\MultiLangSupport.pas',
  Splash in '..\..\Splash.pas' {SplashForm},
  version in '..\..\version.pas',
  utils in '..\..\utils.pas',
  LangFrm in '..\..\LangFrm.pas' {LangForm},
  project in '..\..\project.pas',
  Templates in '..\..\Templates.pas',
  NewProjectFrm in '..\..\NewProjectFrm.pas' {NewProjectForm},
  RemoveUnitFrm in '..\..\RemoveUnitFrm.pas' {RemoveUnitForm},
  GotoLineFrm in '..\..\GotoLineFrm.pas' {GotoLineForm},
  PrintFrm in '..\..\PrintFrm.pas' {PrintForm},
  AboutFrm in '..\..\AboutFrm.pas' {AboutForm},
  compiler in '..\..\compiler.pas',
  devrun in '..\..\devrun.pas',
  ProjectOptionsFrm in '..\..\ProjectOptionsFrm.pas' {ProjectOptionsForm},
  CompOptionsFrm in '..\..\CompOptionsFrm.pas' {CompForm},
  ToolFrm in '..\..\ToolFrm.pas' {ToolForm},
  ToolEditFrm in '..\..\ToolEditFrm.pas' {ToolEditForm},
  IconFrm in '..\..\IconFrm.pas' {IconForm},
  devcfg in '..\..\devcfg.pas',
  datamod in '..\..\datamod.pas' {dmMain: TDataModule},
  helpfrm in '..\..\helpfrm.pas' {frmHelpEdit},
  EditorOptfrm in '..\..\EditorOptfrm.pas' {EditorOptForm},
  CodeIns in '..\..\CodeIns.pas' {frmCodeEdit},
  Incrementalfrm in '..\..\Incrementalfrm.pas' {frmIncremental},
  Search_Center in '..\..\Search_Center.pas',
  Replacefrm in '..\..\Replacefrm.pas' {frmReplace},
  Findfrm in '..\..\Findfrm.pas' {frmFind},
  editor in '..\..\editor.pas',
  Envirofrm in '..\..\Envirofrm.pas' {EnviroForm},
  debugwait in '..\..\debugwait.pas',
  debugger in '..\..\debugger.pas',
  CFGData in '..\..\CFGData.pas',
  CFGINI in '..\..\CFGINI.pas',
  CFGReg in '..\..\CFGReg.pas',
  prjtypes in '..\..\prjtypes.pas',
  debugfrm in '..\..\debugfrm.pas' {DebugForm},
  Macros in '..\..\Macros.pas',
  devExec in '..\..\devExec.pas',
  NewTemplateFm in '..\..\NewTemplateFm.pas' {NewTemplateForm},
  FunctionSearchFm in '..\..\FunctionSearchFm.pas' {FunctionSearchForm},
  NewVarFm in '..\..\NewVarFm.pas' {NewVarForm},
  NewMemberFm in '..\..\NewMemberFm.pas' {NewMemberForm},
  NewClassFm in '..\..\NewClassFm.pas' {NewClassForm},
  ProfileAnalysisFm in '..\..\ProfileAnalysisFm.pas' {ProfileAnalysisForm},
  FilePropertiesFm in '..\..\FilePropertiesFm.pas' {FilePropertiesForm},
  AddToDoFm in '..\..\AddToDoFm.pas' {AddToDoForm},
  ImportMSVCFm in '..\..\ImportMSVCFm.pas' {ImportMSVCForm},
  CPUFrm in '..\..\CPUFrm.pas' {CPUForm},
  FileAssocs in '..\..\FileAssocs.pas',
  TipOfTheDayFm in '..\..\TipOfTheDayFm.pas' {TipOfTheDayForm},
  CVSFm in '..\..\CVSFm.pas' {CVSForm},
  WindowListFrm in '..\..\WindowListFrm.pas' {WindowListForm},
  CVSThread in '..\..\CVSThread.pas',
  CVSPasswdFm in '..\..\CVSPasswdFm.pas' {CVSPasswdForm},
  DevThemes in '..\..\DevThemes.pas',
  ParamsFrm in '..\..\ParamsFrm.pas' {ParamsForm},
  CompilerOptionsFrame in '..\..\CompilerOptionsFrame.pas' {CompOptionsFrame: TFrame},
  CompileProgressFm in '..\..\CompileProgressFm.pas' {CompileProgressForm},
  WebThread in '..\..\webupdate\WebThread.pas',
  WebUpdate in '..\..\webupdate\WebUpdate.pas' {WebUpdateForm},
  ProcessListFrm in '..\..\ProcessListFrm.pas' {ProcessListForm},
  ModifyVarFrm in '..\..\ModifyVarFrm.pas' {ModifyVarForm},
  ImageTheme in '..\..\ImageTheme.pas',
  devFileMonitor in '..\..\Vcl\devFileMonitor.pas',
  DesignerOptions in 'DesignerOptions.pas' {DesignerForm},
  Designerfrm in 'Designerfrm.pas' {frmNewForm},
  wxdesigner in 'wxdesigner.pas',
  dmCreateNewProp in 'dmCreateNewProp.pas' {frmCreateFormProp},
  wxversion in 'wxversion.pas',
  dmCodeGen in 'dmCodeGen.pas',
  CompFileIo in 'CompFileIo.pas',
  CreateOrderFm in 'CreateOrderFm.pas' {CreationOrderForm},
  ViewIDForm in 'ViewIDForm.pas' {ViewControlIDsForm},
  wxeditor in 'wxeditor.pas',
  ELDsgnr in 'ELDsgnr.pas',
  WxUtils in 'components\wxUtils.pas',
  iplugin_dll in '..\interfaces\iplugin_dll.pas',
  iplugger in '..\interfaces\iplugger.pas',
  iplugin in '..\interfaces\iplugin.pas',
  iplugin_bpl in '..\interfaces\iplugin_bpl.pas',
  cfgTypes in '..\..\cfgTypes.pas',
  PackmanExitCodesU in '..\..\..\..\packman\PackmanExitCodesU.pas',
  xProcs in '..\..\xprocs.pas',
  ExceptionFilterUnit in '..\..\ExceptionFilterUnit.pas',
  Hashes in '..\..\packages\Hashes.pas';

{$R *.res}

type
  TMainFormHack = class(TMainForm);
  
var
    // ConfigMode moved to devcfg, 'cause I need it in enviroform (for AltConfigFile)
    UserHome, strLocalAppData, strAppData, strIniFile: String;
    tempc: array [0..MAX_PATH] of char;

begin
  strIniFile := ChangeFileExt(ExtractFileName(Application.EXEName), INI_EXT);

  if (ParamCount > 0) and (ParamStr(1) = CONFIG_PARAM) then begin
    if not DirectoryExists(ParamStr(2)) then begin
      MessageDlg('The directory "' + ParamStr(2) + '" doesn''t exist. Dev-C++ will now quit, please create the directory first.', mtError, [mbOK], 0);
      Application.Terminate;
      exit;
    end;
    devData.INIFile := IncludeTrailingBackslash(ParamStr(2)) + strIniFile;
    ConfigMode := CFG_PARAM;
  end
  else if IsWinNT then begin
     //default dir should be %APPDATA%\Dev-Cpp
     strLocalAppData := '';
     if SUCCEEDED(SHGetFolderPath(0, CSIDL_LOCAL_APPDATA, 0, 0, tempc)) then
       strLocalAppData := IncludeTrailingBackslash(String(tempc));

     strAppData := '';
     if SUCCEEDED(SHGetFolderPath(0, CSIDL_APPDATA, 0, 0, tempc)) then
       strAppData := IncludeTrailingBackslash(String(tempc));

     if (strLocalAppData <> '') and
     FileExists(strLocalAppData + strIniFile) then begin
       UserHome := strLocalAppData;
       devData.INIFile := UserHome + strIniFile;
       ConfigMode := CFG_USER;
     end
     else if (strAppData <> '')
     and FileExists(strAppData + strIniFile) then begin
       UserHome := strAppData;
       devData.INIFile := UserHome + strIniFile;
       ConfigMode := CFG_USER;
     end
     else if (strAppData <> '')
     and (DirectoryExists(strAppData + 'Dev-Cpp') or CreateDir(strAppData + 'Dev-Cpp')) then begin
       UserHome := strAppData + 'Dev-Cpp\';
       devData.INIFile := UserHome + strIniFile;
       ConfigMode := CFG_USER;
     end
     else
       devData.INIFile:= ChangeFileExt(Application.EXEName, INI_EXT);
  end
  else
    devData.INIFile:= ChangeFileExt(Application.EXEName, INI_EXT);

  devData.UseRegistry:= FALSE;
  devData.BoolAsWords:= FALSE;
  devData.INISection:= OPT_OPTIONS;

  // support for user-defined alternate ini file (permanent, but overriden by command-line -c)
  if ConfigMode <> CFG_PARAM then begin
    StandardConfigFile:=devData.INIFile;
    CheckForAltConfigFile(devData.INIFile);
    if UseAltConfigFile and (AltConfigFile<>'') and FileExists(AltConfigFile) then
      devData.INIFile:=AltConfigFile;
  end;

  InitializeOptions;
  if ConfigMode = CFG_PARAM then
    devDirs.Config := IncludeTrailingBackslash(ParamStr(2))
  else if ConfigMode = CFG_USER then
    devDirs.Config := UserHome;
  devData.ReadConfigData;
  devTheme:= TdevTheme.Create;

  
  Application.Initialize;
  Application.Title := 'wxDev-C++';
  Application.CreateForm(TMainForm, MainForm);
  MainForm.Hide; // hide it
  
  
  if not devData.NoSplashScreen then 
  begin
    SplashForm := TSplashForm.Create(Application);
    SplashForm.Show;
    SplashForm.Update;
  end;
  
  {*** modified by peter ***}
  // make the creation when the splashscreen is displayed
  // because it takes quite a while ...
  TMainFormHack(MainForm).DoCreateEverything;

  
  Application.CreateForm(TfrmIncremental, frmIncremental);
  Application.CreateForm(TfrmFind, frmFind);
  Application.CreateForm(TfrmReplace, frmReplace);
  Application.CreateForm(TWebUpdateForm, WebUpdateForm);
  
  {*** modified by peter ***}
  // apply the window placement. this method forced
  // the form to show,
  TMainFormHack(MainForm).DoApplyWindowPlacement;

  if not devData.NoSplashScreen then
    SplashForm.Free;

  Application.Run;
end.
