// $Id$
//
unit ExceptionFilterUnit;

interface

implementation

uses Classes,windows,madExcept,JvInspector,ELDsgnr,sysutils;

// GAR 1/8/06
// Looks like this needs to be the procedure definition for the newer versions of madExcept (> 2.8)
// To keep our custom exception handling boxes working, go to Project->madExcept Settings...
// In the tab for "Exception filter", set the first exception filter ("Exception class filter 1")
// to work with classes: EELDesigner, EConvertError, EJvInspectorItem, EComponentError
// And select the "Don't show anything" in the dropdown box. This way madExcept will pass
// those exceptions through to this procedure instead (where we define our custom exception handler windows).
// For all other exception classes, have madExcept handle it with the "Show an assistant", type "SaveAssistant".
//
procedure ExceptionFilter(const exceptIntf : IMEException; var Handled : Boolean);

// This was the old (< version 2.8) definition
//procedure ExceptionFilter( frozen          : boolean;
//                          exceptObject    : TObject;
//                          exceptAddr      : pointer;
//                          crashedThreadId : dword;
//                          var bugReport   : string;
//                          var screenShot  : string;
//                          var canContinue : boolean;
//                          var handled     : boolean);


begin
  //This is for People who try to enter caption or Label information in the Name Property
  if (exceptObject <> nil) and (exceptObject is EComponentError) then begin
    MessageBox(0, pchar(EComponentError(exceptObject).Message +#13+#10+#13+#10+'After closing this message Box, press escape to restore last value.'), 'Error...', MB_ICONERROR or MB_TASKMODAL);
    handled := true;
  end;
  //This is for screwing up some Property Inspector Editor specifics like Entering Data
  // in the Orientation Information
  if (exceptObject <> nil) and (exceptObject is EJvInspectorItem) then begin
    MessageBox(0, pchar(EJvInspectorItem(exceptObject).Message+#13+#10+#13+#10+'After closing this message Box, press escape to restore last value.'), 'Error...', MB_ICONERROR or MB_TASKMODAL);
    handled := true;
  end;
  //For some Weird Designer Errors.
  if (exceptObject <> nil) and (exceptObject is EELDesigner) then begin
    MessageBox(0, pchar(EELDesigner(exceptObject).Message+#13+#10+#13+#10+'After closing this message Box, press escape to restore last value.'), 'Error...', MB_ICONERROR or MB_TASKMODAL);
    handled := true;
  end;
  //If user accidently entered text to a Integer field
  if (exceptObject <> nil) and (exceptObject is EConvertError) then begin
    MessageBox(0, pchar(EConvertError(exceptObject).Message+#13+#10+#13+#10+'After closing this message Box, press escape to restore last value.'), 'Error...', MB_ICONERROR or MB_TASKMODAL);
    handled := true;
  end;
end;

initialization
  RegisterExceptionHandler(ExceptionFilter, stTrySyncCallOnSuccess);

end.