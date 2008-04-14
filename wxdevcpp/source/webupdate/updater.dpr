program updater;

uses
  Forms,
  WebUpdate in 'WebUpdate.pas' {WebUpdateForm},
  WebThread in 'WebThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWebUpdateForm, WebUpdateForm);
  Application.Run;
end.
