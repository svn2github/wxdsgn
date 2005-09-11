// $Id$
//
unit ExceptionFilterUnit;

interface

implementation

uses Classes,windows,madExcept,JvInspector,ELDsgnr,sysutils;

procedure ExceptionFilter(frozen          : boolean;
                          exceptObject    : TObject;
                          exceptAddr      : pointer;
                          crashedThreadId : dword;
                          var bugReport   : string;
                          var screenShot  : string;
                          var canContinue : boolean;
                          var handled     : boolean);
begin
  //This is for People who try to enter caption or Label information in the Name Property
  if (exceptObject <> nil) and (exceptObject is EComponentError) then begin
    MessageBox(0, pchar(EComponentError(exceptObject).Message +#13+#10+#13+#10+'After closing this message Box, press escape to resume.'), 'Error...', MB_ICONERROR or MB_TASKMODAL);
    handled := true;
  end;
  //This is for screwing up some Property Inspector Editor specifics like Entering Data
  // in the Orientation Information
  if (exceptObject <> nil) and (exceptObject is EJvInspectorItem) then begin
    MessageBox(0, pchar(EJvInspectorItem(exceptObject).Message+#13+#10+#13+#10+'After closing this message Box, press escape to resume.'), 'Error...', MB_ICONERROR or MB_TASKMODAL);
    handled := true;
  end;
  //For some Weird Designer Errors.
  if (exceptObject <> nil) and (exceptObject is EELDesigner) then begin
    MessageBox(0, pchar(EELDesigner(exceptObject).Message+#13+#10+#13+#10+'After closing this message Box, press escape to resume.'), 'Error...', MB_ICONERROR or MB_TASKMODAL);
    handled := true;
  end;
  //If user accidently entered text to a Integer field
  if (exceptObject <> nil) and (exceptObject is EConvertError) then begin
    MessageBox(0, pchar(EConvertError(exceptObject).Message+#13+#10+#13+#10+'After closing this message Box, press escape to resume.'), 'Error...', MB_ICONERROR or MB_TASKMODAL);
    handled := true;
  end;
end;

{$IfNDef MadExcept3}
initialization
  RegisterExceptionHandler(ExceptionFilter, stTrySyncCallOnSuccess);
{$EndIf}
end.