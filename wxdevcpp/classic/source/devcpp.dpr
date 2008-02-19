{
    $Id$

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
  FastMM4,
  FastCode,
  LanguagesDEPFix,
{$IFNDEF OLD_MADSHI}  
  madListHardware,
  madListProcesses,
  madListModules,
{$ENDIF}
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
  debugwait in 'debugwait.pas',
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
  CPUFrm in 'CPUFrm.pas' {CPUForm},
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
  WebThread in 'webupdate\WebThread.pas',
  WebUpdate in 'webupdate\WebUpdate.pas' {WebUpdateForm},
  ProcessListFrm in 'ProcessListFrm.pas' {ProcessListForm},
  ModifyVarFrm in 'ModifyVarFrm.pas' {ModifyVarForm},
  FilesReloadFrm in 'FilesReloadFrm.pas' {FilesReloadFrm},
  PackmanExitCodesU in '..\..\packman\PackmanExitCodesU.pas',
  ImageTheme in 'ImageTheme.pas' {$IFDEF WX_BUILD},
  Wxcontrolpanel in 'components\Wxcontrolpanel.pas',
  dmCreateNewProp in 'dmCreateNewProp.pas' {frmCreateFormProp},
  DesignerOptions in 'DesignerOptions.pas' {DesignerForm},
  Designerfrm in 'Designerfrm.pas' {frmNewForm},
  MigrateFrm in 'MigrateFrm.pas' {MigrateFrm},
  ViewIDForm in 'ViewIDForm.pas' {ViewControlIDsForm},
  CreateOrderFm in 'CreateOrderFm.pas' {CreationOrderForm},
  ComponentPalette in 'components\ComponentPalette.pas',
  dmListview in 'propedit\dmListview.pas' {ListviewForm},
  UStrings in 'propedit\UStrings.pas' {StringsForm},
  UStatusbar in 'propedit\UStatusbar.pas' {StatusBarForm},
  UPicEdit in 'propedit\UPicEdit.pas' {PictureEdit},
  UColorEdit in 'propedit\UColorEdit.pas' {ColorEdit},
  UMenuitem in 'propedit\UMenuitem.pas' {MenuItemForm},
  UValidator in 'propedit\UValidator.pas' {wxValidator},
  WxUtils in 'components\wxUtils.pas',
  WxBitmapButton in 'components\WxBitmapButton.pas',
  WXCheckBox in 'components\wxcheckbox.pas',
  WxComboBox in 'components\wxcombobox.pas',
  WxEdit in 'components\wxEdit.pas',
  WxGauge in 'components\wxgauge.pas',
  WxGrid in 'components\wxgrid.pas',
  WxListBox in 'components\wxlistbox.pas',
  Wxlistctrl in 'components\wxlistctrl.pas',
  WxMemo in 'components\wxmemo.pas',
  WxRadioButton in 'components\wxradiobutton.pas',
  WxScrollBar in 'components\wxscrollbar.pas',
  WxSlider in 'components\wxslider.pas',
  WxSpinButton in 'components\wxspinbutton.pas',
  WxStaticBitmap in 'components\wxstaticbitmap.pas',
  WxStaticBox in 'components\wxstaticbox.pas',
  WxStaticLine in 'components\wxstaticline.pas',
  WxStaticText in 'components\wxstatictext.pas',
  WxTreeCtrl in 'components\wxtreectrl.pas',
  WxGridSizer in 'components\wxgridsizer.pas',
  WxBoxSizer in 'components\wxboxsizer.pas',
  WxFlexGridSizer in 'components\wxflexgridsizer.pas',
  WxStaticBoxSizer in 'components\wxstaticboxsizer.pas',
  WxSizerPanel in 'components\WXSizerPanel.pas',
  WxButton in 'components\WxButton.pas',
  WxToggleButton in 'components\WxToggleButton.pas',
  WxNotebook in 'components\wxnotebook.pas',
  WxStatusBar in 'components\wxstatusbar.pas',
  WxToolBar in 'components\wxtoolbar.pas',
  WxPanel in 'components\wxpanel.pas',
  WxNoteBookPage in 'components\wxNoteBookPage.pas',
  WxCheckListBox in 'components\wxchecklistbox.pas',
  Wxspinctrl in 'components\wxspinctrl.pas',
  WxChoice in 'components\wxchoice.pas',
  WxHtmlWindow in 'components\wxHtmlWindow.pas',
  WxScrolledWindow in 'components\WxScrolledWindow.pas',
  WxSeparator in 'components\WxSeparator.pas',
  WxToolButton in 'components\WxToolButton.pas',
  WxNonVisibleBaseComponent in 'components\WxNonVisibleBaseComponent.pas',
  WxMenuBar in 'components\WxMenuBar.pas',
  WxPopupMenu in 'components\WxPopupMenu.pas',
  WxCustomMenuItem in 'components\WxCustomMenuItem.pas',
  WxOpenFileDialog in 'components\WxOpenFileDialog.pas',
  WxSaveFileDialog in 'components\WxSaveFileDialog.pas',
  WxFontDialog in 'components\wxFontDialog.pas',
  WxColourDialog in 'components\wxColourDialog.pas',
  WxDirDialog in 'components\wxDirDialog.pas',
  WxFindReplaceDialog in 'components\wxFindReplaceDialog.pas',
  WxPrintDialog in 'components\wxPrintDialog.pas',
  WxProgressDialog in 'components\wxProgressDialog.pas',
  WxTimer in 'components\wxTimer.pas',
  WxPageSetupDialog in 'components\wxPageSetupDialog.pas',
  WxMessageDialog in 'components\wxMessageDialog.pas',
  Wxsplitterwindow in 'components\wxsplitterwindow.pas',
  WxRadioBox in 'components\wxRadioBox.pas',
  WxDatePickerCtrl in 'components\wxDatePickerCtrl.pas',
  CustomWXDRadioGroup in 'components\CustomWXDRadioGroup.pas',
  wxStdDialogButtonSizer in 'components\wxStdDialogButtonSizer.pas',
  WxOwnerDrawnComboBox in 'components\WxOwnerDrawnComboBox.pas',
  WxSTC in 'components\WxSTC.pas',
  WxRichTextCtrl in 'components\WxRichTextCtrl.pas',
  WxTreeListCtrl in 'components\WxTreeListCtrl.pas',
  wxCalendarBase in 'components\wxCalendarBase.pas',
  WxCalendarCtrl in 'components\WxCalendarCtrl.pas',
  WxTextEntryDialog in 'components\WxTextEntryDialog.pas',
  WxPasswordEntryDialog in 'components\WxPasswordEntryDialog.pas',
  WxSingleChoiceDialog in 'components\WxSingleChoiceDialog.pas',
  WxMultiChoiceDialog in 'components\WxMultiChoiceDialog.pas',
  WxHyperLinkCtrl in 'components\WxHyperLinkCtrl.pas',
  WxDialUpManager in 'components\WxDialUpManager.pas',
  WxHtmlEasyPrinting in 'components\WxHtmlEasyPrinting.pas',
  WxMediaCtrl in 'components\WxMediaCtrl.pas'

  
  {$ENDIF};

{$R 'winxp.res'}
{$R 'icons.res' 'icons.rc'}
{$R 'DefaultFiles.res' 'DefaultFiles.rc'}
{$R 'LangFrm.res' 'LangFrm.rc'}
{$R *.res}

{$IFDEF WX_BUILD}
{$R STDREG.res}
{$ENDIF}

//Single Instance feature
function CanStart: Boolean;
var
  Wdw: HWND;
begin
  Wdw := DuplicateAppInstWdw;
  if Wdw = 0 then
    Result := True
  else
    Result := not SwitchToPrevInst(Wdw);
end;

const
  WXVERSION = 6;
var
  // ConfigMode moved to devcfg, 'cause I need it in enviroform (for AltConfigFile)
  UserHome, strLocalAppData, strAppData, strIniFile: String;
  tempc: array [0..MAX_PATH] of char;
  iniFile: TIniFile;
  versionNum: Integer;

begin
  strIniFile := ChangeFileExt(ExtractFileName(Application.EXEName), INI_EXT);

  if (ParamCount > 0) and (ParamStr(1) = CONFIG_PARAM) then
  begin
    if not DirectoryExists(ParamStr(2)) then
      if not ForceDirectories(ParamStr(2)) then
      begin
        ShowMessage('The configuration directory does not exist and we were unable to ' +
                    'create it. Please check that the path is not read-only and that ' +
                    'you have sufficient privilieges to write to it.'#10#13#10#13 +
                    'wxDev-C++ will now exit.');
        Application.Terminate;
      end;
    devData.INIFile := IncludeTrailingBackslash(ParamStr(2)) + strIniFile;
    ConfigMode := CFG_PARAM;
  end
  else if IsWinNT then
  begin
    //default dir should be %APPDATA%\Dev-Cpp
    strLocalAppData := '';
    if SUCCEEDED(SHGetFolderPath(0, CSIDL_LOCAL_APPDATA, 0, 0, tempc)) then
      strLocalAppData := IncludeTrailingBackslash(String(tempc));

    strAppData := '';
    if SUCCEEDED(SHGetFolderPath(0, CSIDL_APPDATA, 0, 0, tempc)) then
      strAppData := IncludeTrailingBackslash(String(tempc));

    if (strLocalAppData <> '') and FileExists(strLocalAppData + strIniFile) then begin
      UserHome := strLocalAppData;
      devData.INIFile := UserHome + strIniFile;
      ConfigMode := CFG_USER;
    end
    else if (strAppData <> '') and FileExists(strAppData + strIniFile) then begin
      UserHome := strAppData;
      devData.INIFile := UserHome + strIniFile;
      ConfigMode := CFG_USER;
    end
    else if (strAppData <> '') and (DirectoryExists(strAppData + 'Dev-Cpp') or CreateDir(strAppData + 'Dev-Cpp')) then begin
      UserHome := strAppData + 'Dev-Cpp\';
      devData.INIFile := UserHome + strIniFile;
      ConfigMode := CFG_USER;
    end
    else
      devData.INIFile := ChangeFileExt(Application.EXEName, INI_EXT);
  end
  else
    devData.INIFile := ChangeFileExt(Application.EXEName, INI_EXT);

  if FileExists(devData.INIFile+'.ver') = false then
  begin
    DeleteFile(devData.INIFile);
  end;
  iniFile:=TIniFile.Create(devData.INIFile+'.ver');
  try
    versionNum:=iniFile.ReadInteger('Program', 'Version', -1);
  if versionNum <> WXVERSION then
    DeleteFile(devData.INIFile);
    iniFile.WriteInteger('Program', 'Version', WXVERSION);
  finally
    iniFile.Destroy;
  end;

  devData.UseRegistry := FALSE;
  devData.BoolAsWords := FALSE;
  devData.INISection := OPT_OPTIONS;

  // support for user-defined alternate ini file (permanent, but overriden by command-line -c)
  if ConfigMode <> CFG_PARAM then begin
    StandardConfigFile := devData.INIFile;
    CheckForAltConfigFile(devData.INIFile);
    if UseAltConfigFile and (AltConfigFile <> '') and FileExists(AltConfigFile) then
      devData.INIFile := AltConfigFile;
  end;

  InitializeOptions;
  if ConfigMode = CFG_PARAM then
    devDirs.Config := IncludeTrailingBackslash(ParamStr(2))
  else if ConfigMode = CFG_USER then
    devDirs.Config := UserHome;

  devData.ReadConfigData;
  
  if devData.SingleInstance then
    if not CanStart then
      exit;
  devTheme := TdevTheme.Create;
  Application.Initialize;
  Application.Title := 'wxDev-C++';
  Application.HelpFile := '..\Help\devcpp.HLP';
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
  Application.CreateForm(TWebUpdateForm, WebUpdateForm);
  MainForm.DoCreateEverything;

  // apply the window placement. this method forces the form to show.
  MainForm.DoApplyWindowPlacement;
  if not devData.NoSplashScreen then
    SplashForm.Free;

  if devData.ShowTipsOnStart and (ParamCount = 0) then  // do not show tips if dev-c++ is launched with a file
    MainForm.actShowTips.Execute;

  Application.Run;
end.
