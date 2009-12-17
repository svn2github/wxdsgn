 { ****************************************************************** }
 {                                                                    }
{ $Id: wxflexgridsizer.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
{                                                                    }
{   Copyright © 2003-2007 by Guru Kathiresan                         }
{                                                                    }
{License :                                                           }
{=========                                                           }
{The wx-devC++ Components, Form Designer, Utils classes              }
{are exclusive properties of Guru Kathiresan.                        }
{The code is available in dual Licenses:                             }
{                               1)GPL Compatible  License            }
{                               2)Commercial License                 }
{                                                                    }
{1)GPL License :                                                     }
{ Code can be used in any project as long as the project's sourcecode}
{ is published under GPL license.                                    }
{                                                                    }
{2)Commercial License:                                               }
{Use of code in this file or the one that bear this license text     }
{can be used in Non-GPL projects as long as you get the permission   }
{from the Author - Guru Kathiresan.                                  }
{Use of the Code in any non-gpl projects without the permission of   }
{the author is illegal.                                              }
{Contact gururamnath@yahoo.com for details                           }
{ ****************************************************************** }

unit WxFlexGridSizer;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ExtCtrls, WxUtils, WxSizerPanel, wxAuiManager;

type
  TWxFlexGridSizer = class(TWxSizerPanel, IWxComponentInterface,
    IWxContainerAndSizerInterface)
  private
    { Private fields of TWxFlexGridSizer }
    { Storage for property ColumnSpacing }
    FColumnSpacing: integer;
    { Storage for property Columns }
    FColumns: integer;
    { Storage for property RowSpacing }
    FRowSpacing: integer;
    { Storage for property Rows }
    FRows: integer;
    { Storage for property FWx_Border }
    FWx_Border: integer;
    { Storage for property Wx_Class }
    FWx_Class: string;
    { Storage for property Wx_ControlOrientation }
    FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_EventList }
    FWx_EventList: TStringList;
    { Storage for property Wx_IDName }
    FWx_IDName: string;
    { Storage for property Wx_IDValue }
    FWx_IDValue: integer;
    { Storage for property Wx_StretchFactor }
    FWx_StretchFactor: integer;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

    { Private methods of TWxFlexGridSizer }
    { Method to set variable and property values and create objects }
    procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
    procedure AutoDestroy;
    { Write method for property Wx_EventList }
    procedure SetWx_EventList(Value: TStringList);

  protected
    { Protected fields of TWxFlexGridSizer }

    { Protected methods of TWxFlexGridSizer }

  public
    { Public fields and properties of TWxFlexGridSizer }

    { Public methods of TWxFlexGridSizer }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GenerateControlIDs: string;
    function GenerateEnumControlIDs: string;
    function GenerateEventTableEntries(CurrClassName: string): string;
    function GenerateGUIControlCreation: string;
    function GenerateXRCControlCreation(IndentString: string): TStringList;
    function GenerateGUIControlDeclaration: string;
    function GenerateHeaderInclude: string;
    function GenerateImageInclude: string;
    function GetEventList: TStringList;
    function GetIDName: string;
    function GetIDValue: integer;
    function GetParameterFromEventName(EventName: string): string;
    function GetPropertyList: TStringList;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: integer);
    procedure SetWxClassName(wxClassName: string);
    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    function maxHeightOfRow(rowIndex: integer): integer;
    function maxWidthOfColumn(colIndex: integer): integer;
    function GenerateLastCreationCode: string;

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

  published
    { Published properties of TWxFlexGridSizer }
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property ColumnSpacing: integer Read FColumnSpacing Write FColumnSpacing default 0;
    property Columns: integer Read FColumns Write FColumns default 2;
    property RowSpacing: integer Read FRowSpacing Write FRowSpacing default 0;
    property Rows: integer Read FRows Write FRows default 2;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_EventList: TStringList Read FWx_EventList Write SetWx_EventList;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: integer Read FWx_IDValue Write FWx_IDValue default -1;

    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;
  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxFlexGridSizer with Standard as its
       default page on the Delphi component palette }
  RegisterComponents('Standard', [TWxFlexGridSizer]);
end;

{ Method to set variable and property values and create objects }
procedure TWxFlexGridSizer.AutoInitialize;
begin
  FWx_PropertyList    := TStringList.Create;
  FColumnSpacing      := 0;
  FColumns            := 2;
  FRowSpacing         := 0;
  FRows                    := 2;
  Wx_Border           := 5;
  FWx_Class           := 'wxFlexGridSizer';
  FWx_EventList       := TStringList.Create;
  FWx_BorderAlignment := [wxAll];
  FWx_Alignment       := [wxALIGN_CENTER];
  FWx_IDValue         := -1;
  FWx_StretchFactor   := 0;
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxFlexGridSizer.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
end; { of AutoDestroy }

{ Write method for property Wx_EventList }
procedure TWxFlexGridSizer.SetWx_EventList(Value: TStringList);
begin
  //Use Assign method because TStringList is an object type and FWx_EventList
  //has been created.
  FWx_EventList.Assign(Value);
end;

constructor TWxFlexGridSizer.Create(AOwner: TComponent);
begin
  { Call the Create method of the container's parent class       }
  inherited Create(AOwner);

  { AutoInitialize sets the initial values of variables          }
  { (including subcomponent variables) and properties;           }
  { also, it creates objects for properties of standard          }
  { Delphi object types (e.g., TFont, TTimer, TPicture)          }
  { and for any variables marked as objects.                     }
  { AutoInitialize method is generated by Component Create.      }
  AutoInitialize;

  { Code to perform other tasks when the container is created    }
  FWx_PropertyList.add('Wx_Class:Base Class');
  FWx_PropertyList.add('Wx_IDName:ID Name');
  FWx_PropertyList.add('Wx_IDValue:ID Value');

  FWx_PropertyList.add('Wx_StretchFactor:Stretch Factor');
  FWx_PropertyList.add('Wx_Alignment:Alignment');
  FWx_PropertyList.Add('wxALIGN_LEFT:wxALIGN_LEFT');
  FWx_PropertyList.Add('wxALIGN_RIGHT:wxALIGN_RIGHT');
  FWx_PropertyList.Add('wxALIGN_TOP:wxALIGN_TOP');
  FWx_PropertyList.Add('wxALIGN_BOTTOM:wxALIGN_BOTTOM');
  FWx_PropertyList.Add('wxALIGN_CENTER:wxALIGN_CENTER');
  FWx_PropertyList.Add('wxALIGN_CENTER_HORIZONTAL:wxALIGN_CENTER_HORIZONTAL');
  FWx_PropertyList.Add('wxALIGN_CENTER_VERTICAL:wxALIGN_CENTER_VERTICAL');
  FWx_PropertyList.Add('wxEXPAND:wxEXPAND');
  FWx_PropertyList.add('Wx_Border:Border');
  FWx_PropertyList.add('Wx_BorderAlignment:Borders');
  FWx_PropertyList.add('wxALL:wxALL');
  FWx_PropertyList.add('wxTOP:wxTOP');
  FWx_PropertyList.add('wxLEFT:wxLEFT');
  FWx_PropertyList.add('wxRIGHT:wxRIGHT');
  FWx_PropertyList.add('wxBOTTOM:wxBOTTOM');

  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Columns:Columns');
  FWx_PropertyList.add('ColumnSpacing:Column Spacing');
  FWx_PropertyList.add('Rows:Rows');
  FWx_PropertyList.add('RowSpacing:Row Spacing');
  
  

end;

destructor TWxFlexGridSizer.Destroy;
begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
  AutoDestroy;

  { Here, free any other dynamic objects that the component methods  }
  { created but have not yet freed.  Also perform any other clean-up }
  { operations needed before the component is destroyed.             }

  { Last, free the component by calling the Destroy method of the    }
  { parent class.                                                    }
  inherited Destroy;
end;


function TWxFlexGridSizer.GenerateEnumControlIDs: string;
begin
  Result := '';
end;

function TWxFlexGridSizer.GenerateControlIDs: string;
begin
  Result := '';
end;

function TWxFlexGridSizer.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
end;

function TWxFlexGridSizer.GenerateXRCControlCreation(IndentString: string): TStringList;
var
  i: integer;
  wxcompInterface: IWxComponentInterface;
 tempstring: TStringList;
begin

  Result := TStringList.Create;

  try
 if not (self.Parent is TForm) then //NUKLEAR ZELPH
 begin
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <rows>%d</rows>', [self.rows]));
    Result.Add(IndentString + Format('  <cols>%d</cols>', [self.columns]));
    Result.Add(IndentString + Format('  <vgap>%d</vgap>', [self.rowSpacing]));
    Result.Add(IndentString + Format('  <hgap>%d</hgap>', [self.columnSpacing]));
 end;//NUKLEAR ZELPH
 
    for i := 0 to self.ControlCount - 1 do // Iterate
      if self.Controls[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) then
        // Only add the XRC control if it is a child of the top-most parent (the form)
        //  If it is a child of a sizer, panel, or other object, then it's XRC code
        //  is created in GenerateXRCControlCreation of that control.
        if (self.Controls[i].GetParentComponent.Name = self.Name) then
        begin
	   tempstring  := TStringList.Create;
	   if (self.Parent is TForm) then
           begin
	    tempstring.Add('    ' + IndentString + '<!--sizeritem-->' );
	    tempstring.Add('      ' + IndentString + '<!--option>' + IntToStr(wxcompInterface.GetStretchFactor) + '</option-->');
	    tempstring.Add('      ' + IndentString + '<!--border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border-->');
	    tempstring.Add('      ' + IndentString + '<!--flag>' + BorderAlignmentToStr(wxcompInterface.GetBorderAlignment) + '</flag-->');
	  end
	  else
	  begin
	    tempstring.Add('    ' + IndentString + '<sizeritem>' );
	    tempstring.Add('      ' + IndentString + '<option>' + IntToStr(wxcompInterface.GetStretchFactor) + '</option>');
	    tempstring.Add('      ' + IndentString + '<border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
	    tempstring.Add('      ' + IndentString + '<flag>' + BorderAlignmentToStr(wxcompInterface.GetBorderAlignment) + '</flag>');
	  end;
	  tempstring.AddStrings(wxcompInterface.GenerateXRCControlCreation('        ' + IndentString));  
	  if (self.Parent is TForm) then
	    tempstring.Add('    ' + IndentString + '<!--/sizeritem-->')
	  else
	    tempstring.Add('    ' + IndentString + '</sizeritem>');
	
          try
            Result.AddStrings(tempstring);
          finally
            tempstring.Free
          end
        end; // for
	  
 if (self.Parent is TForm) then //NUKLEAR ZELPH
    Result.Add(IndentString + '<!--/object-->')
 else
    Result.Add(IndentString + '</object>');
 
  except
    Result.Free;
    raise;
  end;

end;

function TWxFlexGridSizer.GenerateGUIControlCreation: string;

  function HasAuiManagedForm: Boolean;
  var
    I: Integer;
    isAuimanagerAvailable: Boolean;
  wxAuimanagerInterface: IWxAuiManagerInterface;
  begin
    isAuimanagerAvailable := False;
    if self.Parent.Parent is TForm then
    begin
      //MN detect whether there is a wxAuiManager component
      for I := self.Parent.Parent.ComponentCount - 1 downto 0 do // Iterate
      begin
          if self.Parent.Parent.Components[i].ClassName = 'TWxAuiManager' then
        //if self.Parent.Parent.Components[i].GetInterface(IID_IWxAuiManagerInterface, wxAuimanagerInterface) then
          isAuimanagerAvailable := True;
        break;
      end; // for
    end;
    Result :=  isAuimanagerAvailable;
  end;

var
  strAlignment: string;
  parentName:  string;
begin
if not (XRCGEN) or ((XRCGEN) and (self.Parent is TForm)) then //NUKLEAR ZELPH
begin
  Result := Format('%s = new wxFlexGridSizer(%d, %d, %d, %d);',
    [self.Name, 0, self.columns, self.rowSpacing, self.columnSpacing]);
  if ((self.Parent is TForm) or (IsControlWxContainer(self.Parent))) then
  begin
    if (self.Parent is TForm) then
      parentName := 'this'
    else if (self.Parent.ClassName = 'TWxPanel') then
        if self.Parent.Parent is TForm and not HasAuiManagedForm then
	parentName := 'this'
      else if (self.Parent.Parent.ClassName <> 'TWxNotebook') then
	parentName := self.Parent.Name
      else
	parentName := self.Parent.Parent.Name
    else
      parentName := self.Parent.Name;
    Result := Result + #13 + Format('%s->SetSizer(%s);', [parentName, self.Name]);
    Result := Result + #13 + Format('%s->SetAutoLayout(true);', [parentName]);
  end
  else begin
    strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
    Result := Result + #13 + Format('%s->Add(%s, %d, %s, %d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);
  end;
 end;//NUKLEAR ZELPH
end;

function TWxFlexGridSizer.GenerateGUIControlDeclaration: string;
begin
if not (XRCGEN) or ((XRCGEN) and (self.Parent is TForm)) then //NUKLEAR ZELPH
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxFlexGridSizer.GenerateHeaderInclude: string;
begin
  Result:='#include <wx/sizer.h>';
end;

function TWxFlexGridSizer.GenerateImageInclude: string;
begin

end;

function TWxFlexGridSizer.GetEventList: TStringList;
begin
  Result := Wx_EventList;
end;

function TWxFlexGridSizer.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxFlexGridSizer.GetIDValue: integer;
begin
  Result := wx_IDValue;
end;

function TWxFlexGridSizer.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_BUTTON' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;

end;

function TWxFlexGridSizer.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxFlexGridSizer.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxFlexGridSizer.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxFlexGridSizer.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxFlexGridSizer.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxFlexGridSizer.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxFlexGridSizer.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxFlexGridSizer.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxFlexGridSizer';
  Result := wx_Class;
end;

procedure TWxFlexGridSizer.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxFlexGridSizer.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxFlexGridSizer.SetIDValue(IDValue: integer);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxFlexGridSizer.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxFlexGridSizer.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

procedure TWxFlexGridSizer.WMPaint(var Message: TWMPaint);
var
  i, j: integer;
  oriRows: integer;
  rowCount, colCount: integer;
  coordTop, coordLeft: integer;
  tmpHtofRow, tmpWtofCol: integer;
  totalmaxWidth, totalmaxHt: integer;
  controlWidth, controlHeight: integer;

  cntIntf: IWxContainerInterface;
  wxCompInterface: IWxComponentInterface;
  splitIntf: IWxSplitterInterface;
begin
  self.Caption  := '';

  //Calculate the number of rows ths control has
  oriRows := self.ControlCount div self.Columns;
  if oriRows * self.Columns < self.ControlCount then
    oriRows := oriRows + 1;

  //Determine the maximum height
  totalmaxHt := 0;
  for i := 0 to oriRows - 1 do
  begin
    tmpHtofRow := maxHeightOfRow(i);
    totalmaxHt := totalmaxHt + tmpHtofRow + RowSpacing;
  end;

  //And the maximum width
  totalmaxWidth := 0;
  for i := 0 to columns - 1 do
  begin
    tmpWtofCol := maxWidthOfColumn(i);
    totalmaxWidth := totalmaxWidth + tmpWtofCol + ColumnSpacing;
  end;

  //Remove the column spacing from the last column and row
  if columns <> 0 then
    totalmaxWidth := totalmaxWidth - ColumnSpacing;
  if oriRows <> 0 then
    totalmaxHt := totalmaxHt - RowSpacing;

  if self.Parent is TForm then
  begin
    self.Align := alClient;
  end
  else
  begin
    if self.parent.GetInterface(IDD_IWxContainerInterface, cntIntf) then
    begin
      if self.parent.GetInterface(IID_IWxSplitterInterface, splitIntf) then
      begin
        self.Align := alNone;
      end
      else
        self.Align := alClient;
    end
    else
      self.Align := alNone;

    if totalmaxWidth = 0 then
      self.Width := 20
    else
      self.Width := totalmaxWidth;

    if totalmaxht = 0 then
      self.Height := 20
    else
      self.Height := totalmaxHt;
  end;

  colCount := 0;
  rowCount := 0;

  for i := 0 to self.ControlCount - 1 do
  begin
    //Skip nonvisible controls
    if IsControlWxNonVisible(Controls[i]) then
      continue;

    //Calculate the base position of the control
    coordTop := 0;
    coordLeft := 0;
    for j := 0 to rowCount - 1 do
      coordTop := coordTop + maxHeightOfRow(j) + RowSpacing;
    for j := 0 to colCount - 1 do
      coordLeft := coordLeft + maxWidthOfColumn(j) + ColumnSpacing;

    //Calculate the base dimensions of the control
    controlWidth := Controls[i].Width;
    controlHeight := Controls[i].Height;

    //Add the control's borders
    if Controls[i].GetInterface(IID_IWxComponentInterface, wxCompInterface) then
    begin
      if (wxTOP in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment) then
      begin
        coordTop := coordTop + wxCompInterface.GetBorderWidth;
        controlHeight := controlHeight + wxCompInterface.GetBorderWidth;
      end;
      if (wxBOTTOM in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment) then
        controlHeight := controlHeight + wxCompInterface.GetBorderWidth;
      if (wxLEFT in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment) then
      begin
        coordLeft := coordLeft + wxCompInterface.GetBorderWidth;
        controlWidth := controlWidth + wxCompInterface.GetBorderWidth;
      end;
      if (wxRIGHT in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment) then
        controlWidth := controlWidth + wxCompInterface.GetBorderWidth;
    end;

    //Then centre the control
    coordTop := coordTop + (maxHeightOfRow(rowCount) - controlHeight) div 2;
    coordLeft := coordLeft + (maxWidthOfColumn(colCount) - controlWidth) div 2;

    //Move the control to the given position
    self.Controls[i].Top := coordTop;
    self.Controls[i].left := coordLeft;

    //Increment the column that we want to fill
    Inc(colCount);

    //Increment the row if we are done with the current row
    if colCount >= Columns then
    begin
      colCount := 0;
      Inc(rowCount);
    end;
  end;

  inherited;

end;

function TWxFlexGridSizer.maxHeightOfRow(rowIndex: integer): integer;
var
  controlHeight: integer;
  startItem, endItem, i: integer;
  wxCompInterface: IWxComponentInterface;
begin
  startItem := rowIndex * columns;
  endItem   := rowIndex * columns + columns - 1;
  Result    := 0;

  //Do we have controls in the first place?
  if startItem > ControlCount then
    Exit;

  //Make sure the end item is lesser than the number of controls
  if endItem >= self.ControlCount then
    endItem := self.ControlCount - 1;
  for i := startItem to endItem do
  begin
    if IsControlWxNonVisible(Controls[i]) then
      continue;

    //Calculate the height of this control
    controlHeight := self.Controls[i].Height;

    //Add the child's borders
    if Controls[i].GetInterface(IID_IWxComponentInterface, wxCompInterface) then
    begin
      if (wxTOP in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment) then
      begin
        controlHeight := controlHeight + wxCompInterface.GetBorderWidth;
      end;
      if (wxBOTTOM in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment) then
      begin
        controlHeight := controlHeight + wxCompInterface.GetBorderWidth;
      end;
    end;

    //And see if the height is greatere than the original
    if Result < controlHeight then
        Result := controlHeight;
  end;
end;

function TWxFlexGridSizer.maxWidthOfColumn(colIndex: integer): integer;
var
  i: integer;
  controlWidth: integer;
  wxCompInterface: IWxComponentInterface;
begin
  Result := 0;
  i := colIndex;

  while i < self.ControlCount do
  begin
    if IsControlWxNonVisible(Controls[i]) then
      continue;

    //Calculate the width of this control
    controlWidth := self.Controls[i].Width;

    //Add the borders
    if Controls[i].GetInterface(IID_IWxComponentInterface, wxCompInterface) then
    begin
      if (wxLEFT in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment) then
      begin
        controlWidth := controlWidth + wxCompInterface.GetBorderWidth;
      end;
      if (wxRIGHT in wxCompInterface.GetBorderAlignment) or (wxALL in wxCompInterface.GetBorderAlignment) then
      begin
        controlWidth := controlWidth + wxCompInterface.GetBorderWidth;
      end;
    end;

    //Update the result
    if Result < controlWidth then
      Result := controlWidth;

    //Increment the current control
    i := i + self.Columns;
  end;
end;

function TWxFlexGridSizer.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxFlexGridSizer.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxFlexGridSizer.GetFGColor: string;
begin
end;

procedure TWxFlexGridSizer.SetFGColor(strValue: string);
begin
end;

function TWxFlexGridSizer.GetBGColor: string;
begin
end;

procedure TWxFlexGridSizer.SetBGColor(strValue: string);
begin
end;

function TWxFlexGridSizer.GenerateLastCreationCode: string;
begin
  Result := '';
end;

end.
