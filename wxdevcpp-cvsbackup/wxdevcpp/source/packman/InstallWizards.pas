unit InstallWizards;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InstallFiles, ExtCtrls, StdCtrls, Buttons, ShellAPI, ComCtrls,
  Installers, PackmanExitCodesU;

type
  TInstallWizard = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    StepsPanel: TPanel;
    Bevel1: TBevel;
    PrevBtn: TBitBtn;
    NextBtn: TBitBtn;
    Cancel: TBitBtn;
    Notebook1: TNotebook;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ReadmeMemo: TMemo;
    Label6: TLabel;
    ProgressBar1: TProgressBar;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    LicenseMemo: TMemo;
    Label16: TLabel;
    GroupBox2: TGroupBox;
    Descr: TMemo;
    AboutBtn: TBitBtn;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    UrlLabel: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Step1: TLabel;
    Step2: TLabel;
    Step3: TLabel;
    Step4: TLabel;
    Step5: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    procedure Notebook1PageChanged(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure PrevBtnClick(Sender: TObject);
    procedure NextBtnClick(Sender: TObject);
    procedure CancelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AboutBtnClick(Sender: TObject);
    procedure UrlLabelClick(Sender: TObject);
    procedure Label22Click(Sender: TObject);
    procedure Label23Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FileName: String;
    InstallInfo: TInstallInfo;
    Installer: TInstaller;
    IsCompressed: Boolean;
    TempFilesDir: String;
    TempFiles, TempDirs: TStringList;
    procedure ChangeLabels;
    procedure StartInstall;
    procedure Progress(Sender: TObject; CurrentFile: TInstallFile; Progress, Max: Integer);
  public
    DontShowError: Boolean;
    PMExitCode: TPackmanExitCode;
    constructor Create(AOwner: TComponent); override;
    function SetFileName(AFileName: String): Boolean;
  end;

var
  InstallWizard: TInstallWizard;

implementation

uses
  Bzip2, LibTar, ExtractionProgressDialog;

const
  PageCount = 5;

var
  AppDir: String;

{$R *.dfm}

procedure Mkdir(const DirName: String);
var
  Dirs: TStringList;
  i: Integer;
begin
  Dirs := TStringList.Create;
  for i := 1 to Length(DirName) do
      if DirName[i] = '\' then
          Dirs.Add(Copy(DirName, 0, i - 1));
  Dirs.Add(DirName);

  for i := 0 to Dirs.Count - 1 do
      if not DirectoryExists(Dirs.Strings[i]) then
          CreateDirectory(PChar(Dirs.Strings[i]), nil);
  Dirs.Free;
end;

function ConvertSlashes(Path: String): String;
var
  i: Integer;
begin
  Result := Path;
  for i := 1 to Length(Result) do
      if Result[i] = '/' then
          Result[i] := '\';
end;

function TInstallWizard.SetFileName(AFileName: String): Boolean;
const
  BufSize = 1024 * 64;
var
  F: File;
  Buf: array[0..3] of Char;
  TempPath: array[0..MAX_PATH] of Char;
  BytesRead: LongInt;

  Bz2File: TFileStream;
  Bz2: TBZDecompressionStream;
  Bz2Buf: array[0..BufSize - 1] of Char;
  Tar: TTarArchive;
  DirRec: TTarDirRec;
  TarFile: String;
  ExtractedFile: TFileStream;

  FN, ExtractDir: String;
  PackageFile: String;

  i: Integer;
  EntryName: String;
  DepErrors: TStringList;
begin
  IsCompressed := False;
  Result := False;
  FileName := AFileName;

  { Check for Bzip2 signature }
  FileMode := 0;
  AssignFile(F, AFileName);
  Reset(F, 1);
  FillChar(Buf, SizeOf(Buf) - 1, #0);
  BlockRead(F, Buf, 3, BytesRead);
  if BytesRead = 3 then
  begin
      if Buf = 'BZh' then
          IsCompressed := True;
  end;
  CloseFile(F);

  { If compressed, extract the package to a temporary file }
  if IsCompressed then
  begin
      Bz2File := nil;
      Bz2 := nil;
      try
         Bz2File := TFileStream.Create(AFileName, fmOpenRead);
         Bz2 := TBZDecompressionStream.Create(Bz2File);
      except
         if Assigned(Bz2) then
             Bz2.Free;
         if Assigned(Bz2File) then
             Bz2File.Free;
         PMExitCode := PACKMAN_EXITCODE_INVALID_FORMAT;
         Exit;
      end;

      FillChar(TempPath, SizeOf(TempPath) - 1, 0);
      FillChar(TarFile, SizeOf(TarFile) - 1, 0);
      GetTempPath(SizeOf(TempPath) - 1, TempPath);
      TarFile := TempPath + IntToStr(Random(1000)) + '-Dev-' +
        IntToStr(Random(1000)) + '-Package.tar';

      ExtractionProgress := TExtractionProgress.Create(Self);
      ExtractionProgress.Show;
      ExtractedFile := nil;
      try
         ExtractedFile := TFileStream.Create(TarFile, fmCreate);
         ExtractionProgress.ProgressBar1.Max := Bz2File.Size * 2;
         BytesRead := Bz2.Read(Bz2Buf, BufSize - 1);
         while BytesRead > 0 do
         begin
             ExtractedFile.Write(Bz2Buf, BufSize - 1);
             BytesRead := Bz2.Read(Bz2Buf, BufSize - 1);
             ExtractionProgress.ProgressBar1.Position := Bz2File.Position;
             Application.ProcessMessages;
         end;
      except
         if Assigned(ExtractedFile) then
             ExtractedFile.Free;
         ExtractionProgress.Free;
         PMExitCode := PACKMAN_EXITCODE_INVALID_FORMAT;
         Exit;
      end;
      ExtractedFile.Free;

      Bz2.Free;
      Bz2File.Free;
  end;

  { Now extract the file }
  if IsCompressed then
  begin
      Bz2File := TFileStream.Create(TarFile, fmOpenRead);
      Tar := TTarArchive.Create(Bz2File);
      ExtractionProgress.ProgressBar1.Max := Tar.FStream.Size * 2;
      ExtractionProgress.ProgressBar1.Position := Tar.FStream.Position;

      ExtractDir := TempPath + IntToStr(Random(1000)) + '-Dev-' +
        IntToStr(Random(1000)) + '-Package\';
      TempFilesDir := ExtractDir;
      TempFiles := TStringList.Create;
      TempDirs := TStringList.Create;
      MkDir(ExtractDir);
      PackageFile := '';

      try
         while Tar.FindNext(DirRec) do
         begin
             FN := ExtractDir + ConvertSlashes(DirRec.Name);
             // fix, was : if DirRec.Name[Length(DirRec.Name)] = '/' then
             if (DirRec.FileType = ftDirectory) then
             begin
                 TempDirs.Add(FN);
                 Continue;
             end;
             if not DirectoryExists(ExtractFileDir(FN)) then
                 MkDir(ExtractFileDir(FN));

             ExtractedFile := TFileStream.Create(FN, fmCreate);
             TempFiles.Add(FN);
             Tar.ReadFile(ExtractedFile);
             ExtractedFile.Free;

             if (not FileExists(PackageFile)) and (CompareText(ExtractFileExt(FN),
               '.DevPackage') = 0) then
                 PackageFile := FN;

             ExtractionProgress.ProgressBar1.Position := Tar.FStream.Size +
               Tar.FStream.Position;
             Application.ProcessMessages;
         end;
      except
         ExtractionProgress.Free;
         Tar.Free;
         Bz2File.Free;
         DeleteFile(TarFile);
         PMExitCode := PACKMAN_EXITCODE_INVALID_FORMAT;
         Exit;
      end;
      ExtractionProgress.Free;
      Tar.Free;
      Bz2File.Free;
      DeleteFile(TarFile);

      FileName := PackageFile;
      if not FileExists(PackageFile) then
      begin
          Application.MessageBox('A package description file (*.DevPackage) ' +
            'has not been found in this archive.', 'Error', MB_ICONHAND);
          DontShowError := True;
          PMExitCode := PACKMAN_EXITCODE_NO_PACKAGE_DESCRIPTION;
          Exit;
      end;
  end;


  { Go on with the installation }

  try
      InstallInfo := TInstallInfo.Create(FileName);
  except
      Application.MessageBox('This file is not a valid package file.',
        'Error', MB_ICONERROR);
      Close;
      DontShowError := True;
      PMExitCode := PACKMAN_EXITCODE_INVALID_FORMAT;
      Exit;
  end;

  if InstallInfo.Version > SupportedVersion then
  begin
      Application.MessageBox(PChar('This version of Package Manager only' +
        ' supports packages up to version ' + IntToStr(SupportedVersion) +
        '.' + #13#10 + 'The package you selected has version number ' +
        IntToStr(InstallInfo.Version) + '.' + #13#10#13#10 +
        'This means the package format has changed.' + #13#10 +
        'It is highly recommended to upgrade to the latest version of ' +
        'Dev-C++ and Package Manager.'),
        'Incompatible version', MB_ICONERROR);
      Close;
      DontShowError := True;
      PMExitCode := PACKMAN_EXITCODE_VERSION_NOT_SUPPORTED;
      Exit;
  end;

  AppDir := ExtractFileDir(ParamStr(0));
  DepErrors := TStringList.Create;
  for i := 0 to InstallInfo.Dependencies.Count - 1 do
  begin
      EntryName := ChangeFileExt(InstallInfo.Dependencies.Strings[i], '.entry');
      EntryName := AppDir + '\Packages\' + EntryName;
      if not FileExists(EntryName) then
          DepErrors.Add(InstallInfo.Dependencies.Strings[i]);
  end;
  if DepErrors.Count > 0 then
  begin
      Application.MessageBox(PChar('This package depends on some ' +
       'other packages, which are not installed on your system.' + #13#10 +
       'Please install them first. The required depencies are:' + #13#10 +
       DepErrors.Text), 'Dependency Error', MB_ICONERROR);
      Close;
      DontShowError := True;
      PMExitCode := PACKMAN_EXITCODE_DEPENDACIES_NOT_MET;
      Exit;
  end;
  DepErrors.Free;

  Installer := nil;
  Notebook1.PageIndex := 0;
  Label3.Caption := Format(Label3.Caption, [InstallInfo.AppVerName]);
  Label2.Caption := Format(Label2.Caption, [InstallInfo.AppName]);
  Label16.Caption := Format(Label16.Caption, [InstallInfo.AppName]);
  Label20.Caption := Format(Label20.Caption, [InstallInfo.AppName]);

  Label19.Visible := Length(InstallInfo.URL) > 0;
  UrlLabel.Visible := Length(InstallInfo.URL) > 0;
  UrlLabel.Caption := InstallInfo.URL;

  GroupBox2.Visible := Length(InstallInfo.Description) > 0;
  Descr.Text := InstallInfo.Description;

  if (Length(InstallInfo.Readme) = 0) and (Length(InstallInfo.License) = 0) then
      NextBtn.Caption := '&Install >';
  if Length(InstallInfo.Readme) = 0 then
      Step2.Font.Color := clSilver
  else
      ReadmeMemo.Text := InstallInfo.Readme;

  if Length(InstallInfo.License) = 0 then
      Step3.Font.Color := clSilver
  else
      LicenseMemo.Text := InstallInfo.License;

  if InstallInfo.Reboot then
  begin
      Label21.Show;
      RadioButton1.Show;
      RadioButton2.Show;
  end;

  PMExitCode := PACKMAN_EXITCODE_NO_ERROR;
  Result := True;
end;

procedure TInstallWizard.Notebook1PageChanged(Sender: TObject);
begin
  PrevBtn.Enabled := (Notebook1.PageIndex > 0) and
                     (Notebook1.PageIndex < PageCount - 1) and
                     (Notebook1.PageIndex <> 3);
  Cancel.Enabled := Notebook1.PageIndex < PageCount - 1;
  Cancel.Visible := Notebook1.PageIndex < PageCount - 1;
  NextBtn.Enabled := Notebook1.PageIndex <> 3;
  ChangeLabels;

  if Notebook1.PageIndex = 3 then
      StartInstall;
end;

procedure TInstallWizard.CancelClick(Sender: TObject);
begin
  if Assigned(Installer) then
  begin
      if Application.MessageBox('Do you really wish to abort the installation?',
        'Warning', MB_ICONQUESTION + MB_YESNO) = IDYES then begin
           Installer.Abort
      end
      else
          Exit;
  end;
  PMExitCode := PACKMAN_EXITCODE_INSTALL_CANCELLED;
  Close;
end;

procedure TInstallWizard.PrevBtnClick(Sender: TObject);
begin
  case Notebook1.PageIndex of
  3: if Length(InstallInfo.License) > 0 then
         Notebook1.PageIndex := 2
     else if Length(InstallInfo.Readme) > 0 then
         Notebook1.PageIndex := 1
     else
         Notebook1.PageIndex := 0;
  2: if Length(InstallInfo.Readme) > 0 then
         Notebook1.PageIndex := 1
     else
         Notebook1.PageIndex := 0;
  else Notebook1.PageIndex := Notebook1.PageIndex - 1;
  end;
  if (Length(InstallInfo.Readme) = 0) and (Length(InstallInfo.License) = 0) then
      NextBtn.Caption := '&Install >';
end;

procedure TInstallWizard.NextBtnClick(Sender: TObject);
begin
  case Notebook1.PageIndex of
  0: if Length(InstallInfo.Readme) > 0 then
         Notebook1.PageIndex := 1
     else if Length(InstallInfo.License) > 0 then
         Notebook1.PageIndex := 2
     else
         Notebook1.PageIndex := 3;
  1: if Length(InstallInfo.License) > 0 then
         Notebook1.PageIndex := 2
     else
         Notebook1.PageIndex := 3;
  PageCount - 1: Close;
  else Notebook1.PageIndex := Notebook1.PageIndex + 1;
  end;
end;

procedure TInstallWizard.ChangeLabels;
const
  Steps: array[0..PageCount - 1] of String = (
    'Welcome',
    'Readme',
    'License',
    'Installing',
    'Finished'
  );
var
  i: Integer;
  L: TLabel;
begin
  case Notebook1.PageIndex of
  2: NextBtn.Caption := '&Install >';
  4: NextBtn.Caption := '&Finish';
  else NextBtn.Caption := '&Next >';
  end;

  for i := 0 to StepsPanel.ControlCount - 2 do
  begin
      L := TLabel(StepsPanel.Controls[i + 1]);
      if Notebook1.PageIndex = i then
      begin
          L.Caption := '> ' + Steps[i];
          L.Font.Style := L.Font.Style + [fsBold];
      end else
      begin
          L.Caption := Steps[i];
          L.Font.Style := L.Font.Style - [fsBold];
      end;
  end;
end;

procedure TInstallWizard.CancelKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
      if Application.MessageBox('Do you need help on this wizard?', 'Question',
        MB_ICONQUESTION + MB_YESNO) = IDYES then
          ShellExecute(GetDesktopWindow, nil,
            'http://catalog.dummies.com/product.asp?isbn=0764502611', nil, nil,
            1)
      else
          { Do something? }
  end;
end;

procedure TInstallWizard.AboutBtnClick(Sender: TObject);
begin
  Application.MessageBox(
    'Dev-C++ Package Installation Wizard' + #13#10 +
    'Copyright (c) 2002 Hongli Lai' + #13#10 + #13#10 +
    'Licensed under the GNU General Public License.',
    'About', MB_ICONASTERISK);
end;

procedure TInstallWizard.Progress(Sender: TObject; CurrentFile: TInstallFile; Progress, Max: Integer);
begin
  ProgressBar1.Position := Progress;
  Label7.Caption := 'Current progress (' +
    IntToStr(Round(Progress / (InstallInfo.Files(AppDir).Count / 100))) +
    '%):';
  Label10.Caption := CurrentFile.Source;
  Label13.Caption := IntToStr(Progress);
  Label14.Caption := IntToStr(InstallInfo.Files(AppDir).Count - Progress);
end;

procedure TInstallWizard.StartInstall;
begin
  Installer := TInstaller.Create(InstallInfo);
  Installer.OnProgress := Progress;
  ProgressBar1.Max := InstallInfo.Files(AppDir).Count;
  Label14.Caption := IntToStr(ProgressBar1.Max);
  Label18.Caption := IntToStr(ProgressBar1.Max);
  BorderIcons := BorderIcons - [biSystemMenu];
  ActiveControl := Cancel;

  Application.ProcessMessages;
  if not Installer.Install then
  begin
      Installer.Free;
      Installer := nil;
      Close;
  end;
  Installer.Free;
  Installer := nil;
  BorderIcons := BorderIcons + [biSystemMenu];
  Notebook1.PageIndex := Notebook1.PageIndex + 1;
  ActiveControl := NextBtn;
end;

procedure TInstallWizard.UrlLabelClick(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow, nil, PChar(TLabel(Sender).Caption),
    nil, nil, 1);
end;

procedure TInstallWizard.Label22Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, 'notepad.exe',
    PChar('"' + InstallInfo.ReadmeFile + '"'),
    nil, SW_MAXIMIZE);
end;

procedure TInstallWizard.Label23Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, 'notepad.exe',
    PChar('"' + InstallInfo.LicenseFile + '"'),
    nil, SW_MAXIMIZE);
end;

procedure TInstallWizard.FormCreate(Sender: TObject);
begin
  DontShowError := False;
end;

procedure TInstallWizard.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i: Integer;
begin
  InstallInfo.Free;

  if IsCompressed and DirectoryExists(TempFilesDir) then
  begin
      for i := TempFiles.Count - 1 downto 0 do
          DeleteFile(ConvertSlashes(TempFiles.Strings[i]));
      TempFiles.Free;

      for i := TempDirs.Count - 1 downto 0 do
          RemoveDir(ConvertSlashes(TempDirs.Strings[i]));
      TempDirs.Free;
      RemoveDir(TempFilesDir);
  end;

  if (Assigned(InstallInfo)) and (InstallInfo.Reboot) and
    (RadioButton1.Checked) then
  begin
      ExitWindowsEx(EWX_REBOOT, 0);
      Application.Terminate;
  end;

  Action := caFree;
end;

constructor TInstallWizard.Create(AOwner: TComponent);
begin
  inherited;

  PMExitCode := PACKMAN_EXITCODE_ERRCODE_UNKNOWN;
end;

end.
