unit devconnect;

interface

uses
  Classes, Windows, StdCtrls, Forms, CheckForUpdate;

type
  TDevConnect = class(TThread)

  public
    Check : TCheckForUpdate;
    L     : TLabel;

  protected
    msg   : string;

    procedure Execute; override;
    procedure Sync;

  end;

implementation

{ TDevConnect }

procedure TDevConnect.Sync;
begin
  L.Caption := msg;
  Application.ProcessMessages;
end;

procedure TDevConnect.Execute;
begin
  with Check do begin
    msg := 'Connecting...';
    Synchronize(sync);
    Connect;
    msg := 'Downloading update file...';
    Synchronize(sync);
    Download;
    Synchronize(sync);
    msg := 'Disconnecting...';
    Synchronize(sync);
    Disconnect;
    msg := 'Checking update file...';
    Synchronize(sync);
    Check;
    msg := 'Done';
    Synchronize(sync);
  end;
end;

end.
