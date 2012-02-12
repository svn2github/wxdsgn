// $Id: ExceptionFilterUnit.pas 488 2006-10-14 00:42:36Z lowjoel $
//
Unit ExceptionFilterUnit;

Interface

Implementation

Uses Classes, Windows, madExcept, JvInspector, ELDsgnr, sysutils, Forms;

// GAR 1/8/06
// Looks like this needs to be the procedure definition for the newer versions of madExcept (> 2.8)
// To keep our custom exception handling boxes working, go to Project->madExcept Settings...
// In the tab for "Exception filter", set the first exception filter ("Exception class filter 1")
// to work with classes: EELDesigner, EConvertError, EJvInspectorItem, EComponentError
// And select the "Don't show anything" in the dropdown box. This way madExcept will pass
// those exceptions through to this procedure instead (where we define our custom exception handler windows).
// For all other exception classes, have madExcept handle it with the "Show an assistant", type "SaveAssistant".
//
Procedure ExceptionFilter(Const exceptIntf: IMEException;
    Var Handled: Boolean);

// This was the old (< version 2.8) definition
//procedure ExceptionFilter( frozen          : boolean;
//                          exceptObject    : TObject;
//                          exceptAddr      : pointer;
//                          crashedThreadId : dword;
//                          var bugReport   : string;
//                          var screenShot  : string;
//                          var canContinue : boolean;
//                          var handled     : boolean);

    Procedure ShowError(AMessage: String);
    Begin
        MessageBox(Application.MainForm.Handle, Pchar(AMessage),
            Pchar(Application.Title), MB_ICONERROR Or MB_TASKMODAL);
        Handled := True;
    End;

Const
    PromptMsg = #13#10#13#10'Please press Escape to restore the previous value.';
Begin
    //Do we have an ACTIVE exception?!
    If exceptObject = Nil Then
        Exit;

    //This is for People who try to enter caption or Label information in the Name Property
    If exceptObject Is EComponentError Then
        ShowError(EComponentError(exceptObject).Message + PromptMsg + 'exceptObject error TR2')
    //This is for screwing up some Property Inspector Editor specifics like Entering Data
    //in the Orientation Information
    Else
    If exceptObject Is EJvInspectorItem Then
        ShowError(EComponentError(exceptObject).Message + PromptMsg + 'Inspector error TR3')
    //For some weird designer errors.
    Else
    If exceptObject Is EELDesigner Then
        ShowError(EELDesigner(exceptObject).Message)
    //If user accidently entered text to a Integer field
    Else
    If exceptObject Is EConvertError Then
        ShowError(EConvertError(exceptObject).Message + PromptMsg + 'Convert error TR4');
End;

Initialization
    RegisterExceptionHandler(ExceptionFilter, stTrySyncCallOnSuccess);

End.