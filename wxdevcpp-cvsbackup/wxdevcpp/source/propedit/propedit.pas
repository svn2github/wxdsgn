unit propedit;
// 이 유니트는 프로그램에서 속성 편집기를 사용할 수 있도록 속성 편집기를 등록한다.
// 속성 편집기를 등록하지 않으면 델파이는 기본적인 속성 편집기를 이용하므로
// TFontProperty와 같은 다른 속성 편집기를 사용할 수 없다.
// 이 유니트는 Object Inspector가 생성될 때 , Register 프로시저를 이용해
// 속성 편집기를 등록한다.

interface

uses
   Classes,DsgnIntf,Graphics,Controls,FileCtrl,uComponentList,Forms, Buttons,
   SysUtils,ComCtrls, {$IFDEF DBVERSION} DB, {$ENDIF} mask, stdctrls, compedit,
   extctrls, grids;

type
   // TStrings 타입의 속성을 편집하기 위한 속성 편집기
   TYB_StringListProperty = class(TClassProperty)
   public
      procedure Edit;override;
      function GetAttributes: TPropertyAttributes;override;
   end;

   TYB_MaskEditProperty = class(TClassProperty)
   public
      procedure Edit;override;
      function GetAttributes: TPropertyAttributes;override;
   end;

   TYB_PictureProperty = class(TClassProperty)
   public
      procedure Edit;override;
      function GetAttributes: TPropertyAttributes;override;
   end;

   TYB_GraphicProperty = class(TClassProperty)
   public
      procedure Edit;override;
      function GetAttributes: TPropertyAttributes;override;
   end;

   TYB_TreeNodesProperty = class(TClassProperty)
   public
      procedure Edit;override;
      function GetAttributes: TPropertyAttributes;override;
   end;

   TYB_ListItemsProperty = class(TClassProperty)
   public
      procedure Edit;override;
      function GetAttributes: TPropertyAttributes;override;
   end;

  TYB_ImageListProperty = class(TPropertyEditor)
  private
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc:TgetStrProc); override;
  end;

  TYB_MenuItemProperty = class(TClassProperty)
   public
      procedure Edit;override;
      function GetAttributes: TPropertyAttributes;override;
   end;

  TYB_PopupMenuProperty = class(TPropertyEditor)
  private
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc:TgetStrProc); override;
  end;

  {$IFDEF DBVERSION}
  TYB_DataSetProperty = class(TPropertyEditor)
  private
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc:TgetStrProc); override;
  end;

  TYB_DataSourceProperty = class(TPropertyEditor)
  private
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc:TgetStrProc); override;
  end;
  {$ENDIF}

procedure Register;

implementation

uses UStrings,upicedit,Menus,Dialogs,umenuitem, utreeview, ulistview, umaskedit;

procedure Register;
begin
    RegisterPropertyEditor(TypeInfo(TFont),nil,'',TFontProperty);
    RegisterPropertyEditor(TypeInfo(TColor),nil,'',TColorProperty);
    RegisterPropertyEditor(TypeInfo(TCursor),nil,'',TCursorProperty);
    RegisterPropertyEditor(TypeInfo(TStrings),nil,'',TYB_StringListProperty);
    RegisterPropertyEditor(TypeInfo(TPicture),nil,'',TYB_PictureProperty);
    RegisterPropertyEditor(TypeInfo(TIcon), nil,'',TYB_GraphicProperty);
    RegisterPropertyEditor(TypeInfo(TBitmap), nil,'',TYB_GraphicProperty);
    RegisterPropertyEditor(TypeInfo(TTreeNodes), nil,'',TYB_TreeNodesProperty);
    RegisterPropertyEditor(TypeInfo(TListColumns), nil,'',TYB_ListItemsProperty);
    RegisterPropertyEditor(TypeInfo(TImageList), nil,'',TYB_ImageListProperty);
    RegisterPropertyEditor(TypeInfo(TMenuItem),nil,'TMenuItem',TYB_MenuItemProperty);
    RegisterPropertyEditor(TypeInfo(TPopupMenu),nil,'',TYB_PopupMenuProperty);
    RegisterPropertyEditor(TypeInfo(string),TMaskEdit,'EditMask',TYB_MaskEditProperty);
    {$IFDEF DBVERSION}
    RegisterPropertyEditor(TypeInfo(TDataSet),nil,'',TYB_DataSetProperty);
    RegisterPropertyEditor(TypeInfo(TDataSource),nil,'',TYB_DataSourceProperty);
    {$ENDIF}
    RegisterComponentEditor(TLabel, TYB_DefaultEditor);
    RegisterComponentEditor(TButton, TYB_DefaultEditor);
    RegisterComponentEditor(TPanel, TYB_DefaultEditor);
    RegisterComponentEditor(TEdit, TYB_DefaultEditor);
    RegisterComponentEditor(TMemo, TYB_DefaultEditor);
    RegisterComponentEditor(TCheckBox, TYB_DefaultEditor);
    RegisterComponentEditor(TRadioButton, TYB_DefaultEditor);
    RegisterComponentEditor(TListBox, TYB_DefaultEditor);
    RegisterComponentEditor(TComboBox, TYB_DefaultEditor);
    RegisterComponentEditor(TGroupBox, TYB_DefaultEditor);
    RegisterComponentEditor(TRadioGroup, TYB_DefaultEditor);
    RegisterComponentEditor(TBitBtn, TYB_DefaultEditor);
    RegisterComponentEditor(TSpeedButton, TYB_DefaultEditor);
    RegisterComponentEditor(TStringGrid, TYB_DefaultEditor);
    RegisterComponentEditor(TDrawGrid, TYB_DefaultEditor);
    RegisterComponentEditor(TImage, TYB_DefaultEditor);
    RegisterComponentEditor(TShape, TYB_DefaultEditor);
    RegisterComponentEditor(TBevel, TYB_DefaultEditor);
    RegisterComponentEditor(TPageControl, TYB_DefaultEditor);
    RegisterComponentEditor(TRichEdit, TYB_DefaultEditor);
    RegisterComponentEditor(TTreeView, TYB_DefaultEditor);
    RegisterComponentEditor(TListView, TYB_DefaultEditor);
    RegisterComponentEditor(TStatusBar, TYB_DefaultEditor);
end;

{TYB_StringListProperty}
procedure TYB_StringListProperty.Edit;
begin
   with TStringsForm.Create(nil) do
   begin
       try
          Memo1.Lines:=TStrings(GetOrdValue);
          if ShowModal=mrOK then  SetOrdValue(Longint(Memo1.Lines));
       finally
          Free;
       end;
   end;
end;

function TYB_StringListProperty.GetAttributes:TPropertyAttributes;
begin
   Result:= inherited GetAttributes + [paDialog];
end;

{TYB_MaskEditProperty}
procedure TYB_MaskEditProperty.Edit;
begin
   with TMaskEditForm.Create(nil) do
   begin
       try
          ShowModal;
       finally
          Free;
       end;
   end;
end;

function TYB_MaskEditProperty.GetAttributes:TPropertyAttributes;
begin
   Result:= inherited GetAttributes + [paDialog];
end;


{TYB_PictureProperty}
procedure TYB_PictureProperty.Edit;
begin
   with TPictureEdit.Create(nil) do
   begin
       try
          Image1.Picture:= TPicture(GetOrdValue);
          if ShowModal=mrOK then  SetOrdValue(Longint(Image1.Picture));
       finally
          Free;
       end;
   end;
end;

function TYB_PictureProperty.GetAttributes:TPropertyAttributes;
begin
   Result:= inherited GetAttributes + [paDialog, paReadOnly] - [paSubProperties];
end;

{TYB_GraphicProperty}
procedure TYB_GraphicProperty.Edit;
begin
   with TPictureEdit.Create(nil) do
   begin
       try
          Image1.Picture:= TPicture(GetOrdValue);
          if ShowModal=mrOK then  SetOrdValue(Longint(Image1.Picture.Graphic));
       finally
          Free;
       end;
   end;
end;

function TYB_GraphicProperty.GetAttributes:TPropertyAttributes;
begin
   Result:= inherited GetAttributes + [paDialog, paReadOnly] - [paSubProperties];
end;

{TYB_TreeNodesProperty}
procedure TYB_TreeNodesProperty.Edit;
begin
   with TTreeViewForm.Create(nil) do
   begin
       try
          ShowModal;
       finally
          Free;
       end;
   end;
end;

function TYB_TreeNodesProperty.GetAttributes:TPropertyAttributes;
begin
   Result:= inherited GetAttributes + [paDialog, paReadOnly] - [paSubProperties];
end;


{TYB_ListItemsProperty}
procedure TYB_ListItemsProperty.Edit;
begin
   with TListViewForm.Create(nil) do
   begin
       try
          ShowModal;
       finally
          Free;
       end;
   end;
end;

function TYB_ListItemsProperty.GetAttributes:TPropertyAttributes;
begin
   Result:= inherited GetAttributes + [paDialog, paReadOnly] - [paSubProperties];
end;

{TYB_ImageListProperty}
function TYB_ImageListProperty.GetValue: string;
begin
end;

procedure TYB_ImageListProperty.SetValue(const Value: string);
begin
   Modified;
end;

function TYB_ImageListProperty.GetAttributes:TPropertyAttributes;
begin
   Result:= inherited GetAttributes + [paValueList, paSortList];
end;

procedure TYB_ImageListProperty.GetValues(Proc: TGetStrProc);
var
   I:Integer;
begin
    for I:= 0  to Designer.Form.ComponentCount - 1 do
       if (Designer.Form.Components[I] is TImageList) then
          Proc(Designer.Form.Components[I].Name);
end;

{TYB_MenuItemProperty}
procedure TYB_MenuItemProperty.Edit;
var
  Menuitem:TMenuItem;
begin
   with TMenuItemForm.Create(Application, Designer) do
   begin
       try
          //MenuItems:= TMenuItem(GetOrdValue);
          MenuItems:= TMenuItem(GetComponent(0));
          if ShowModal= mrOK then {SetOrdValue(MenuItem.Handle)};
       finally
          Free;
       end;
   end;
end;

function TYB_MenuItemProperty.GetAttributes:TPropertyAttributes;
begin
   Result:= inherited GetAttributes + [paDialog];
end;

{TYB_PopupMenuProperty}
function TYB_PopupMenuProperty.GetValue: string;
begin
   inherited GetValue;
end;

procedure TYB_PopupMenuProperty.SetValue(const Value: string);
begin
   inherited SetValue(Value);
end;

function TYB_PopupMenuProperty.GetAttributes:TPropertyAttributes;
begin
   Result:= inherited GetAttributes + [paValueList, paSortList];
end;

procedure TYB_PopupMenuProperty.GetValues(Proc: TGetStrProc);
var
   I:Integer;
begin
    for I:= 0  to Designer.Form.ComponentCount - 1 do
       if (Designer.Form.Components[I] is TPopupMenu) then
          Proc(Designer.Form.Components[I].Name);
end;

{$IFDEF DBVERSION}
{TYB_DataSetProperty}
function TYB_DataSetProperty.GetValue: string;
begin
end;

procedure TYB_DataSetProperty.SetValue(const Value: string);
begin
   Modified;
end;

function TYB_DataSetProperty.GetAttributes:TPropertyAttributes;
begin
   Result:=inherited GetAttributes + [paValueList, paSortList];
end;

procedure TYB_DataSetProperty.GetValues(Proc: TGetStrProc);
var
   I:Integer;
begin
    for I:= 0  to Designer.Form.ComponentCount - 1 do
       if (Designer.Form.Components[I] is TDataSet) then
          Proc(Designer.Form.Components[I].Name);
end;

{TYB_DataSourceProperty}
function TYB_DataSourceProperty.GetValue: string;
begin
end;

procedure TYB_DataSourceProperty.SetValue(const Value: string);
begin
   Modified;
end;

function TYB_DataSourceProperty.GetAttributes:TPropertyAttributes;
begin
   Result:=inherited GetAttributes + [paValueList, paSortList];
end;

procedure TYB_DataSourceProperty.GetValues(Proc: TGetStrProc);
var
   I:Integer;
begin
    for I:= 0  to Designer.Form.ComponentCount - 1 do
       if (Designer.Form.Components[I] is TDataSource) then
          Proc(Designer.Form.Components[I].Name);
end;
{$ENDIF}

end.
