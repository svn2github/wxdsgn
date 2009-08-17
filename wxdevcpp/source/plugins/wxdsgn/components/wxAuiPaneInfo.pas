// $Id$
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

unit wxAuiPaneInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms, wxUtils, WxNonVisibleBaseComponent;

type
  TWxAuiPaneInfo = class(TWxNonVisibleBaseComponent, IWxComponentInterface, IWxAuiPaneInfoInterface,
      IWxToolBarInsertableInterface, IWxToolBarNonInsertableInterface)
  private
    { Private declarations }
    FWx_Class: string;
    FWx_PropertyList: TStringList;
    FWx_Comments: TStrings;
    FWx_EventList: TStringList;
    FWx_Caption: string;
    FWx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem;
    FWx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet;
    FWx_Aui_Pane_Style: TwxAuiPaneStyleSet;
    FWx_Aui_Pane_Buttons: TwxAuiPaneButtonSet;
    FWx_BestSize_Height: Integer;
    FWx_BestSize_Width: Integer;
    FWx_MinSize_Height: Integer;
    FWx_MinSize_Width: Integer;
    FWx_MaxSize_Height: Integer;
    FWx_MaxSize_Width: Integer;
    FWx_Row: Integer;
    FWx_Position: Integer;

    procedure AutoInitialize;
    procedure AutoDestroy;

  protected

  public
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
    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);

    function GetGenericColor(strVariableName: string): string;
    procedure SetGenericColor(strVariableName, strValue: string);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

    function GetAuiDockDirection(Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem): string;
    function GetAuiDockableDirections(Wx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet): string;
    function GetAui_Pane_Style(Wx_Aui_Pane_Style: TwxAuiPaneStyleSet): string;
    function GetAui_Pane_Buttons(Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet): string;
    function GetAuiRow(row: Integer): string;
    function GetAuiPosition(position: Integer): string;
    function GetAuiPaneBestSize: string;
    function GetAuiPaneMinSize: string;
    function GetAuiPaneMaxSize: string;
    function GetAuiPaneCaption: string;
    procedure SetAuiPaneCaption(Caption: string);
    function GetAuiPaneName: string;

    function GetWx_BestSize_Height: integer;
    procedure SetWx_BestSize_Height(height: integer);
    function GetWx_BestSize_Width: integer;
    procedure SetWx_BestSize_Width(width: integer);

    function GetWx_MinSize_Height: integer;
    procedure SetWx_MinSize_Height(height: integer);
    function GetWx_MinSize_Width: integer;
    procedure SetWx_MinSize_Width(width: integer);

    function GetWx_MaxSize_Height: integer;
    procedure SetWx_MaxSize_Height(height: integer);
    function GetWx_MaxSize_Width: integer;
    procedure SetWx_MaxSize_Width(width: integer);

    function GetWx_Row: integer;
    procedure SetWx_Row(row: integer);

    function GetWx_Position: integer;
    procedure SetWx_Position(position: integer);

    function HasToolbarPaneStyle(Wx_Aui_Pane_Style: TwxAuiPaneStyleSet): Boolean;
  published
    { Published declarations }
    property Wx_Class: string read FWx_Class write FWx_Class;
    property Wx_Comments: TStrings read FWx_Comments write FWx_Comments;
    property Wx_EventList: TStringList read FWx_EventList write FWx_EventList;
    property Wx_Caption: string read FWx_Caption write FWx_Caption;
    property Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem read FWx_Aui_Dock_Direction write FWx_Aui_Dock_Direction;
    property Wx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet read FWx_Aui_Dockable_Direction write FWx_Aui_Dockable_Direction;
    property Wx_Aui_Pane_Style: TwxAuiPaneStyleSet read FWx_Aui_Pane_Style write FWx_Aui_Pane_Style;
    property Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet read FWx_Aui_Pane_Buttons write FWx_Aui_Pane_Buttons;
    property Wx_BestSize_Height: integer read GetWx_BestSize_Height write SetWx_BestSize_Height default 0;
    property Wx_BestSize_Width: integer read GetWx_BestSize_Width write SetWx_BestSize_Width default 0;
    property Wx_MinSize_Height: integer read GetWx_MinSize_Height write SetWx_MinSize_Height default 0;
    property Wx_MinSize_Width: integer read GetWx_MinSize_Width write SetWx_MinSize_Width default 0;
    property Wx_MaxSize_Height: integer read GetWx_MaxSize_Height write SetWx_MaxSize_Height default 0;
    property Wx_MaxSize_Width: integer read GetWx_MaxSize_Width write SetWx_MaxSize_Width default 0;
    property Wx_Row: integer read GetWx_Row write SetWx_Row default 0;
    property Wx_Position: integer read GetWx_Position write SetWx_Position default 0;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxAuiPaneInfo]);
end;

{ Method to set variable and property values and create objects }

procedure TWxAuiPaneInfo.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Class := 'wxAuiPaneInfo';
  FWx_Comments := TStringList.Create;
  FWx_EventList := TStringList.Create;
  Glyph.Handle := LoadBitmap(hInstance, 'TWxAuiPaneInfo');
  FWx_BestSize_Height := 0;
  FWx_BestSize_Width := 0;
  FWx_MinSize_Height := 0;
  FWx_MinSize_Width := 0;
  FWx_MaxSize_Height := 0;
  FWx_MaxSize_Width := 0;
  FWx_Row := 0;
  FWx_Position := 0;
  FWx_Aui_Pane_Buttons := [CloseButton];
  //  Wx_Caption := '';
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }

procedure TWxAuiPaneInfo.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_Comments.Destroy;
  FWx_EventList.Destroy;
  Glyph.Assign(nil);
end; { of AutoDestroy }

constructor TWxAuiPaneInfo.Create(AOwner: TComponent);
begin
  { Call the Create method of the container's parent class       }
  inherited Create(AOwner);

  { AutoInitialize method is generated by Component Create.      }
  AutoInitialize;

  { Code to perform other tasks when the component is created }
  { Code to perform other tasks when the component is created }
  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Wx_Class:Base Class');
  FWx_PropertyList.add('Wx_Comments:Comments');
  FWx_PropertyList.add('Wx_Caption:Caption');
  FWx_PropertyList.add('Wx_Aui_Dock_Direction:Dock Direction');
  FWx_PropertyList.add('wxAUI_DOCK_NONE:wxAUI_DOCK_NONE');
  FWx_PropertyList.add('wxAUI_DOCK_TOP:wxAUI_DOCK_TOP');
  FWx_PropertyList.add('wxAUI_DOCK_RIGHT:wxAUI_DOCK_RIGHT');
  FWx_PropertyList.add('wxAUI_DOCK_BOTTOM:wxAUI_DOCK_BOTTOM');
  FWx_PropertyList.add('wxAUI_DOCK_LEFT:wxAUI_DOCK_LEFT');
  FWx_PropertyList.add('wxAUI_DOCK_CENTER:wxAUI_DOCK_CENTER');
  FWx_PropertyList.add('Wx_Aui_Dockable_Direction:Dockable Direction');
  FWx_PropertyList.add('Dockable:Dockable');
  FWx_PropertyList.add('TopDockable:TopDockable');
  FWx_PropertyList.add('RightDockable:RightDockable');
  FWx_PropertyList.add('BottomDockable:BottomDockable');
  FWx_PropertyList.add('LeftDockable:LeftDockable');
  FWx_PropertyList.add('Wx_Aui_Pane_Style:Pane Style');
  FWx_PropertyList.add('CaptionVisible:CaptionVisible');
  FWx_PropertyList.add('DestroyOnClose:DestroyOnClose');
  FWx_PropertyList.add('DockFixed:DockFixed');
  FWx_PropertyList.add('Floatable:Floatable');
  FWx_PropertyList.add('Gripper:Gripper');
  FWx_PropertyList.add('GripperTop:GripperTop');
  FWx_PropertyList.add('Movable:Movable');
  FWx_PropertyList.add('PaneBorder:PaneBorder');
  FWx_PropertyList.add('Resizable:Resizable');
  FWx_PropertyList.add('ToolbarPane:ToolbarPane');
  FWx_PropertyList.add('Wx_Aui_Pane_Buttons:Pane Buttons');
  FWx_PropertyList.add('CloseButton:CloseButton');
  FWx_PropertyList.add('MaximizeButton:MaximizeButton');
  FWx_PropertyList.add('RightDockable:RightDockable');
  FWx_PropertyList.add('MinimizeButton:MinimizeButton');
  FWx_PropertyList.add('PinButton:PinButton');
  FWx_PropertyList.add('Wx_BestSize_Height:Best Height');
  FWx_PropertyList.add('Wx_BestSize_Width:Best Width');
  FWx_PropertyList.add('Wx_MinSize_Height:Min Height');
  FWx_PropertyList.add('Wx_MinSize_Width:Min Width');
  FWx_PropertyList.add('Wx_MaxSize_Height:Max Height');
  FWx_PropertyList.add('Wx_MaxSize_Width:Max Width');
  FWx_PropertyList.add('Wx_Row:Row');
  FWx_PropertyList.add('Wx_Position:Position');

end;

destructor TWxAuiPaneInfo.Destroy;
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

function TWxAuiPaneInfo.GenerateControlIDs: string;
begin
  Result := '';
end;

function TWxAuiPaneInfo.GenerateEnumControlIDs: string;
begin
  Result := '';
end;

function TWxAuiPaneInfo.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
end;

function TWxAuiPaneInfo.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxAuiPaneInfo.GenerateGUIControlCreation: string;
var
  parentName, strAlignment: string;
begin
  parentName := GetWxWidgetParent(self);

  Result := '';
  Result := GetCommentString(self.FWx_Comments.Text);

  if not HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) then
  begin
    if (self.Parent.ClassName = 'TWxPanel') then
      if not (self.Parent.Parent is TForm) then
        Result := Result + #13 + Format('%s->Reparent(this);', [parentName]);
  end;

  if HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) then
  begin
    Result := Result + #13 + Format('%s->Realize();', [parentName]);
  end;

  Result := Result + #13 + Format('WxAuiManager1->AddPane(%s, wxAuiPaneInfo()%s%s%s%s%s%s%s%s%s%s%s);',
    [parentName, GetAuiPaneName, GetAuiPaneCaption, GetAuiDockDirection(Self.Wx_Aui_Dock_Direction), GetAuiDockableDirections(self.Wx_Aui_Dockable_Direction),
    GetAui_Pane_Style(Self.Wx_Aui_Pane_Style), GetAui_Pane_Buttons(Self.Wx_Aui_Pane_Buttons), GetAuiRow(Self.Wx_Row), GetAuiPosition(Self.Wx_Position), GetAuiPaneBestSize, GetAuiPaneMinSize, GetAuiPaneMaxSize]);

end;

function TWxAuiPaneInfo.GenerateGUIControlDeclaration: string;
begin
  Result := '';
end;

function TWxAuiPaneInfo.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/aui/aui.h>';
end;

function TWxAuiPaneInfo.GenerateImageInclude: string;
begin

end;

function TWxAuiPaneInfo.GetEventList: TStringList;
begin
  Result := Wx_EventList;
end;

function TWxAuiPaneInfo.GetIDName: string;
begin

end;

function TWxAuiPaneInfo.GetIDValue: integer;
begin
  Result := 0;
end;

function TWxAuiPaneInfo.GetParameterFromEventName(EventName: string): string;
begin
  Result := '';
end;

function TWxAuiPaneInfo.GetStretchFactor: integer;
begin
  Result := 1;
end;

function TWxAuiPaneInfo.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxAuiPaneInfo.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := [];
end;

procedure TWxAuiPaneInfo.SetBorderAlignment(border: TWxBorderAlignment);
begin
end;

function TWxAuiPaneInfo.GetBorderWidth: integer;
begin
  Result := 0;
end;

procedure TWxAuiPaneInfo.SetBorderWidth(width: integer);
begin
end;

function TWxAuiPaneInfo.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxAuiPaneInfo.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxAuiPaneInfo';
  Result := wx_Class;
end;

procedure TWxAuiPaneInfo.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin

end;

procedure TWxAuiPaneInfo.SetIDName(IDName: string);
begin

end;

procedure TWxAuiPaneInfo.SetIDValue(IDValue: integer);
begin

end;

procedure TWxAuiPaneInfo.SetStretchFactor(intValue: integer);
begin
end;

procedure TWxAuiPaneInfo.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxAuiPaneInfo.GetFGColor: string;
begin

end;

procedure TWxAuiPaneInfo.SetFGColor(strValue: string);
begin
end;

function TWxAuiPaneInfo.GetBGColor: string;
begin
end;

procedure TWxAuiPaneInfo.SetBGColor(strValue: string);
begin
end;

procedure TWxAuiPaneInfo.SetProxyFGColorString(Value: string);
begin
end;

procedure TWxAuiPaneInfo.SetProxyBGColorString(Value: string);
begin
end;

function TWxAuiPaneInfo.GetGenericColor(strVariableName: string): string;
begin
end;

procedure TWxAuiPaneInfo.SetGenericColor(strVariableName, strValue: string);
begin

end;

function TWxAuiPaneInfo.GetAuiDockDirection(Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem): string;
begin
  Result := '';
  if Wx_Aui_Dock_Direction = wxAUI_DOCK_NONE then
  begin
    Result := '';
    exit;
  end;
  if Wx_Aui_Dock_Direction = wxAUI_DOCK_TOP then
  begin
    Result := '.Top()';
    exit;
  end;
  if Wx_Aui_Dock_Direction = wxAUI_DOCK_RIGHT then
  begin
    Result := '.Right()';
    exit;
  end;
  if Wx_Aui_Dock_Direction = wxAUI_DOCK_BOTTOM then
  begin
    Result := '.Bottom()';
    exit;
  end;
  if Wx_Aui_Dock_Direction = wxAUI_DOCK_LEFT then
  begin
    Result := '.Left()';
    exit;
  end;
  if Wx_Aui_Dock_Direction = wxAUI_DOCK_CENTER then
  begin
    Result := '.Center()';
    exit;
  end;
end;

function TWxAuiPaneInfo.GetAui_Pane_Style(Wx_Aui_Pane_Style: TwxAuiPaneStyleSet): string;
begin
  Result := '';
  if CaptionVisible in Wx_Aui_Pane_Style then
    Result := Result + '.CaptionVisible()';

  if DestroyOnClose in Wx_Aui_Pane_Style then
    Result := Result + '.DestroyOnClose()';

  if DockFixed in Wx_Aui_Pane_Style then
    Result := Result + '.DockFixed()';

  if Floatable in Wx_Aui_Pane_Style then
    Result := Result + '.Floatable()';

  if Gripper in Wx_Aui_Pane_Style then
    Result := Result + '.Gripper()';

  if GripperTop in Wx_Aui_Pane_Style then
    Result := Result + '.GripperTop()';

  if Movable in Wx_Aui_Pane_Style then
    Result := Result + '.Movable()';

  if PaneBorder in Wx_Aui_Pane_Style then
    Result := Result + '.PaneBorder()';

  if Resizable in Wx_Aui_Pane_Style then
    Result := Result + '.Resizable()';

  if ToolbarPane in Wx_Aui_Pane_Style then
    Result := Result + '.ToolbarPane()';

end;

function TWxAuiPaneInfo.GetAuiDockableDirections(Wx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet): string;
begin
  Result := '';
  if Dockable in Wx_Aui_Dockable_Direction then
  begin
    Result := Result + '.Dockable()';
    Exit;
  end;

  if LeftDockable in Wx_Aui_Dockable_Direction then
    Result := Result + '.LeftDockable()';

  if RightDockable in Wx_Aui_Dockable_Direction then
    Result := Result + '.RightDockable()';

  if TopDockable in Wx_Aui_Dockable_Direction then
    Result := Result + '.TopDockable()';

  if BottomDockable in Wx_Aui_Dockable_Direction then
    Result := Result + '.BottomDockable()';
end;

function TWxAuiPaneInfo.GetAui_Pane_Buttons(Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet): string;
begin
  Result := '';

  if CloseButton in Wx_Aui_Pane_Buttons then
    Result := Result + '.CloseButton()';

  if MaximizeButton in Wx_Aui_Pane_Buttons then
    Result := Result + '.MaximizeButton()';

  if MinimizeButton in Wx_Aui_Pane_Buttons then
    Result := Result + '.MinimizeButton()';

  if PinButton in Wx_Aui_Pane_Buttons then
    Result := Result + '.PinButton()';
end;

function TWxAuiPaneInfo.GetAuiRow(row: Integer): string;
begin
  Result := '';

  if row > 0 then
    Result := Format('.Row(%d)', [row]);
end;

function TWxAuiPaneInfo.GetAuiPosition(position: Integer): string;
begin
  Result := '';

  if position > 0 then
    Result := Format('.Position(%d)', [position]);
end;

function TWxAuiPaneInfo.GetAuiPaneBestSize: string;
var
  height: Integer;
  width: Integer;
begin
  Result := '';
  height := self.GetWx_BestSize_Height;
  width := Self.GetWx_BestSize_Width;
  if (height > 0) and (width > 0) then
    Result := Format('.BestSize(wxSize(%d, %d))', [width, height]);
end;

function TWxAuiPaneInfo.GetWx_BestSize_Height: integer;
begin
  Result := FWx_BestSize_Height;
end;

procedure TWxAuiPaneInfo.SetWx_BestSize_Height(height: integer);
begin
  FWx_BestSize_Height := height;
end;

function TWxAuiPaneInfo.GetWx_BestSize_Width: integer;
begin
  Result := FWx_BestSize_Width;
end;

procedure TWxAuiPaneInfo.SetWx_BestSize_Width(width: integer);
begin
  FWx_BestSize_Width := width;
end;

function TWxAuiPaneInfo.GetAuiPaneMinSize: string;
var
  height: Integer;
  width: Integer;
begin
  Result := '';
  height := self.GetWx_MinSize_Height;
  width := Self.GetWx_MinSize_Width;
  if (height > 0) and (width > 0) then
    Result := Format('.MinSize(wxSize(%d, %d))', [width, height]);
end;

function TWxAuiPaneInfo.GetWx_MinSize_Height: integer;
begin
  Result := FWx_MinSize_Height;
end;

procedure TWxAuiPaneInfo.SetWx_MinSize_Height(height: integer);
begin
  FWx_MinSize_Height := height;
end;

function TWxAuiPaneInfo.GetWx_MinSize_Width: integer;
begin
  Result := FWx_MinSize_Width;
end;

procedure TWxAuiPaneInfo.SetWx_MinSize_Width(width: integer);
begin
  FWx_MinSize_Width := width;
end;

function TWxAuiPaneInfo.GetAuiPaneMaxSize: string;
var
  height: Integer;
  width: Integer;
begin
  Result := '';
  height := self.GetWx_MaxSize_Height;
  width := Self.GetWx_MaxSize_Width;
  if (height > 0) and (width > 0) then
    Result := Format('.MaxSize(wxSize(%d, %d))', [width, height]);
end;

function TWxAuiPaneInfo.GetWx_MaxSize_Height: integer;
begin
  Result := FWx_MaxSize_Height;
end;

procedure TWxAuiPaneInfo.SetWx_MaxSize_Height(height: integer);
begin
  FWx_MaxSize_Height := height;
end;

function TWxAuiPaneInfo.GetWx_MaxSize_Width: integer;
begin
  Result := FWx_MaxSize_Width;
end;

procedure TWxAuiPaneInfo.SetWx_MaxSize_Width(width: integer);
begin
  FWx_MaxSize_Width := width;
end;

function TWxAuiPaneInfo.GetAuiPaneCaption: string;
begin
  if trim(Wx_Caption) = '' then
    Result := ''
  else
    Result := Format('.Caption(wxT("%s"))', [Self.FWx_Caption]);
end;

procedure TWxAuiPaneInfo.SetAuiPaneCaption(Caption: string);
begin
  Wx_Caption := Caption;
end;

function TWxAuiPaneInfo.GetAuiPaneName: string;
begin
  Result := Format('.Name(wxT("%s"))', [self.Name]);
end;

function TWxAuiPaneInfo.HasToolbarPaneStyle(Wx_Aui_Pane_Style: TwxAuiPaneStyleSet): Boolean;
begin
  Result := ToolbarPane in Wx_Aui_Pane_Style;

end;

function TWxAuiPaneInfo.GetWx_Row: integer;
begin
  Result := FWx_Row;
end;

procedure TWxAuiPaneInfo.SetWx_Row(row: integer);
begin
  FWx_Row := row;
end;

function TWxAuiPaneInfo.GetWx_Position: integer;
begin
  Result := FWx_Position;
end;

procedure TWxAuiPaneInfo.SetWx_Position(position: integer);
begin
  FWx_Position := position;
end;

end.

