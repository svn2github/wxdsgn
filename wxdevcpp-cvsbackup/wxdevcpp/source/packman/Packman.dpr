program Packman;

uses
  Dialogs,
  Forms,
  ShellAPI,
  Windows,
  SysUtils,
  InstallWizards in 'InstallWizards.pas' {InstallWizard},
  InstallFiles in 'InstallFiles.pas',
  Installers in 'Installers.pas',
  Main in 'Main.pas' {MainForm},
  PackmanUtils in 'PackmanUtils.pas',
  RemoveForms in 'RemoveForms.pas' {RemoveForm},
  VerifyForms in 'VerifyForms.pas' {VerifyForm},
  DetailsForms in 'DetailsForms.pas' {DetailsForm},
  AboutForms in 'AboutForms.pas' {AboutForm},
  BZip2 in 'bzip2.pas',
  LibTar in 'LibTar.pas',
  ExtractionProgressDialog in 'ExtractionProgressDialog.pas' {ExtractionProgress},
  PackmanExitCodesU in 'PackmanExitCodesU.pas',
  ExceptionsAnalyzer in 'ExceptionsAnalyzer.pas' {frmExceptionsAnalyzer},
  Unzip in 'unzip\UNZIP.PAS',
  ziptypes in 'unzip\ZIPTYPES.PAS';

{$R *.res}
{$R ../winxp.res}

var
  P: TSHFileOpStruct;
  Params: String;
  I: Integer;
begin
  Application.Initialize;
  Application.Title := 'Package Manager';

  //Decide whether we want to update a certain binary?
  if (ParamCount > 2) and (ParamStr(1) = '/update') then
  begin
    I := 0;
    P.wFunc := FO_COPY;
    P.pFrom := PChar(ParamStr(2));
    P.pTo := PChar(ParamStr(3));
    P.fFlags := FOF_NOCONFIRMATION or FOF_NOERRORUI;
    P.fAnyOperationsAborted := False;
    P.hNameMappings := nil;
    P.lpszProgressTitle := nil;

    while True do
    begin
      Inc(I);
      Sleep(10);

      if SHFileOperation(P) <> 0 then
      begin
        for I := 4 to ParamCount do
          Params := Params + '"' + ParamStr(I) + '" ';
        ShellExecute(HWND(nil), 'open', PChar(ParamStr(3)), PChar(Params), nil, SW_SHOW);
        Break;
      end
      else if I > 3000 then
      begin
        MessageBox(0, PChar(Format('%s could not be updated. (Error %d)', [ParamStr(3), GetLastError])), PChar('Package Manager'), MB_ICONSTOP or MB_OK);
        Break;
      end;
    end;

    //Clean up
    DeleteFile(p.pFrom);
  end
  else
  begin
    Application.CreateForm(TMainForm, MainForm);
    Application.Run;
  end;
end.
