unit compedit;

interface

uses
   Classes,DsgnIntf,SysUtils, ObjectInspec;

type
   // Base class of Component Editor
   TYB_DefaultEditor = class(TDefaultEditor)
   protected
     procedure EditProperty(PropertyEditor: TPropertyEditor;
        var Continue, FreeEditor: Boolean); override;
   public
      procedure Edit;override;
   end;

implementation

procedure TYB_DefaultEditor.EditProperty(PropertyEditor: TPropertyEditor;
  var Continue, FreeEditor: Boolean);
var
  PropName: string;
  procedure ReplaceBest;
  begin
     PropertyEditor.Edit;
     Continue:= False;
  end;
begin
  PropName := PropertyEditor.GetName;
  if CompareText(PropName, 'ONCREATE') = 0 then
    ReplaceBest
  else if CompareText(PropName, 'ONCREATE') <> 0 then
    if CompareText(PropName, 'ONCHANGE') = 0 then
      ReplaceBest
    else if CompareText(PropName, 'ONCHANGE') <> 0 then
      if CompareText(PropName, 'ONCLICK') = 0 then
        ReplaceBest;
end;

procedure TYB_DefaultEditor.Edit;
begin
  // inherited Edit;
   ObjectInspector.EditEventHandler(0);
end;

end.
