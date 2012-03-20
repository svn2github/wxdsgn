unit ControlBar_WIN32_EVENTS;

interface

uses
    Windows, Messages, SysUtils, Classes, Controls, ExtCtrls, Forms;

type
    TWMCommandEvent = procedure(Sender: TObject; var TheMessage: TWMCommand) of object;

    TControlBar_WIN32_EVENTS = class(TControlBar)
    private
        fOnWM_COMMAND: TWMCommandEvent;
    protected
        procedure WM_COMMAND_EVENT(var Message: TWMCommand); message WM_COMMAND;
    public
    { Public declarations }
    published
        property OnWM_COMMAND: TWMCommandEvent read fOnWM_COMMAND write fOnWM_COMMAND;
    end;

procedure Register;

implementation

procedure Register;
begin
    RegisterComponents('dev-c++', [TControlBar_WIN32_EVENTS]);
end;

procedure TControlBar_WIN32_EVENTS.WM_COMMAND_EVENT(var Message: TWMCommand);
begin
    if Assigned(fOnWM_COMMAND) then
        fOnWM_COMMAND(Self, Message);
    inherited;  {Call default processing.}
end;

end.
