// $Id: ExceptionFilterUnit.pas 488 2006-10-14 00:42:36Z lowjoel $
//
unit ExceptionFilterUnit;

interface

implementation

uses Classes, Windows, madExcept, JvInspector, ELDsgnr, sysutils, Forms;

// GAR 1/8/06
// Looks like this needs to be the procedure definition for the newer versions of madExcept (> 2.8)
// To keep our custom exception handling boxes working, go to Project->madExcept Settings...
// In the tab for "Exception filter", set the first exception filter ("Exception class filter 1")
// to work with classes: EELDesigner, EConvertError, EJvInspectorItem, EComponentError
// And select the "Don't show anything" in the dropdown box. This way madExcept will pass
// those exceptions through to this procedure instead (where we define our custom exception handler windows).
// For all other exception classes, have madExcept handle it with the "Show an assistant", type "SaveAssistant".
//
procedure ExceptionFilter(const exceptIntf: IMEException;
    var Handled: boolean);

// This was the old (< version 2.8) definition
//procedure ExceptionFilter( frozen          : boolean;
//                          exceptObject    : TObject;
//                          exceptAddr      : pointer;
//                          crashedThreadId : dword;
//                          var bugReport   : string;
//                          var screenShot  : string;
//                          var canContinue : boolean;
//                          var handled     : boolean);

    procedure ShowError(AMessage: string);
    begin
        MessageBox(Application.MainForm.Handle, pchar(AMessage),
            pchar(Application.Title), MB_ICONERROR or MB_TASKMODAL);
        Handled := TRUE;
    end;

const
    PromptMsg = #13#10#13#10'Please press Escape to restore the previous value.';
begin
    //Do we have an ACTIVE exception?!
    if exceptObject = NIL then
        Exit;

    //This is for People who try to enter caption or Label information in the Name Property
    if exceptObject is EComponentError then
        ShowError(EComponentError(exceptObject).Message + PromptMsg + ' exceptObject error TR2')
    //This is for screwing up some Property Inspector Editor specifics like Entering Data
    //in the Orientation Information
    else
    if exceptObject is EJvInspectorItem then
        ShowError(EComponentError(exceptObject).Message + PromptMsg + ' Inspector error TR3')
    //For some weird designer errors.
    else
    if exceptObject is EELDesigner then
        ShowError(EELDesigner(exceptObject).Message)
    //If user accidently entered text to a Integer field
    else
    if exceptObject is EConvertError then
        ShowError(EConvertError(exceptObject).Message + PromptMsg + ' Convert error TR4');
end;

initialization
    RegisterExceptionHandler(ExceptionFilter, stTrySyncCallOnSuccess);

end.