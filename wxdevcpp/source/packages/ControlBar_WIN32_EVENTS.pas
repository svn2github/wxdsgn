Unit ControlBar_WIN32_EVENTS;

Interface

Uses
    Windows, Messages, SysUtils, Classes, Controls, ExtCtrls, Forms;

Type
    TWMCommandEvent = Procedure(Sender: TObject; Var TheMessage: TWMCommand) Of Object;

    TControlBar_WIN32_EVENTS = Class(TControlBar)
    Private
        fOnWM_COMMAND: TWMCommandEvent;
    Protected
        Procedure WM_COMMAND_EVENT(Var Message: TWMCommand); Message WM_COMMAND;
    Public
    { Public declarations }
    Published
        Property OnWM_COMMAND: TWMCommandEvent Read fOnWM_COMMAND Write fOnWM_COMMAND;
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('dev-c++', [TControlBar_WIN32_EVENTS]);
End;

Procedure TControlBar_WIN32_EVENTS.WM_COMMAND_EVENT(Var Message: TWMCommand);
Begin
    If Assigned(fOnWM_COMMAND) Then
        fOnWM_COMMAND(Self, Message);
    Inherited;  {Call default processing.}
End;

End.
