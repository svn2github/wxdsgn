unit inspImageEditor;

interface

uses
    SysUtils, Windows, Classes, Contnrs, TypInfo, Controls, StdCtrls, Graphics,
    Messages, IniFiles, JvComponent, JvTypes, JvInspector, inspImageEditorForm;

type
    TJvInspectorTPictureItem = class(TJvCustomInspectorItem)
    protected
    //procedure ContentsChanged(Sender: TObject);
    //function GetDisplayValue: string; override;
        procedure Edit; override;
    //procedure SetDisplayValue(const Value: string); override;
        procedure SetFlags(const Value: TInspectorItemFlags); override;
    public
        constructor Create(const AParent: TJvCustomInspectorItem;
            const AData: TJvCustomInspectorData); override;
    end;
implementation

constructor TJvInspectorTPictureItem.Create(const AParent: TJvCustomInspectorItem; const AData: TJvCustomInspectorData);
begin
    inherited Create(AParent, AData);
    RowSizing.MinHeight := irsItemHeight;
    Flags := Flags + [iifEditButton];
end;

//procedure TJvInspectorTPictureItem.ContentsChanged(Sender: TObject);
//var
//  Obj: TStrings;
//begin
//  Obj := TStrings(Data.AsOrdinal);
//  Obj.Text := TMemo(Sender).Lines.Text;
//end;
//
//function TJvInspectorTPictureItem.GetDisplayValue: string;
//var
//  Obj: TObject;
//begin
//  Obj := TObject(Data.AsOrdinal);
//  if not Multiline then
//  begin
//    if Obj <> nil then
//      Result := Result + '('+ Obj.ClassName + ')'
//    else
//      Result := Result + '(' + GetTypeData(Data.TypeInfo).ClassType.ClassName + ')';
//  end
//  else
//    Result := TPicture(Obj).Bitmap;
//end;

procedure TJvInspectorTPictureItem.Edit;
var
  //SL: TStrings;
    picObj: TPicture;
begin
    with TpropImageEditorForm.CreateNew(Inspector) do
    try
        picObj := TPicture(Data.AsOrdinal);
        imgPicture.Picture.Assign(picObj);

    //if AutoUpdate then
    //  OnContentsChanged := ContentsChanged;

        if ShowModal = mrOK then
            picObj.assign(imgPicture.Picture);
    finally
        Free;
    end;

end;

//procedure TJvInspectorTPictureItem.SetDisplayValue(const Value: string);
//var
//  Obj: TObject;
//begin
//  if Multiline then
//  begin
//    Obj := TObject(Data.AsOrdinal);
//    TStrings(Obj).Text := Value;
//  end;
//end;

procedure TJvInspectorTPictureItem.SetFlags(const Value: TInspectorItemFlags);
var
    OldMask: TInspectorItemFlags;
    NewMask: TInspectorItemFlags;
begin
  { The item has either an edit button or is multiline. If one of them is set, the otherone will
    removed }
    OldMask := Flags * [iifEditButton, iifMultiLine];
    NewMask := Value * [iifEditButton, iifMultiLine];
    if OldMask <> NewMask then
    begin
        if Multiline and not (iifEditButton in OldMask) and (iifEditButton in NewMask) then
            inherited SetFlags(Value - [iifMultiline]) // iifEditButton has changed
        else
            if not Multiline and (iifEditButton in OldMask) and (iifMultiline in NewMask) then
                inherited SetFlags(Value - [iifEditButton]) // iifMultiline has changed
            else
                inherited SetFlags(Value); // Neither flag has changed. Should never occur.
    end
    else // Flags have not changed
        inherited SetFlags(Value);
    if RowSizing <> nil then
    begin
        RowSizing.Sizable := Multiline; // Update sizable state
        if not Multiline then
            RowSizing.SizingFactor := irsNoReSize
        else
            RowSizing.SizingFactor := irsValueHeight;
    end;
end;

end.
