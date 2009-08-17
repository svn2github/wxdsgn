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

unit wxAuiManager;

interface

uses
  Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

type
  TWxAuiManager = class(TWxNonVisibleBaseComponent, IWxComponentInterface, IWxAuiManagerInterface)
  private
    { Private declarations }
    FWx_Class: string;
    FWx_PropertyList: TStringList;
    FWx_Comments: TStrings;
    FWx_EventList: TStringList;
    FWx_AuiManagerStyle: TwxAuiManagerFlagSet;

    FEVT_AUI_PANE_BUTTON: string;
    FEVT_AUI_PANE_CLOSE: string;
    FEVT_AUI_PANE_MAXIMIZE: string;
    FEVT_AUI_PANE_RESTORE: string;
    FEVT_AUI_RENDER: string;
    FEVT_AUI_FIND_MANAGER: string;
    FEVT_UPDATE_UI: string;

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

    function GetAuiManagerFlags(Wx_AuiManagerStyles: TwxAuiManagerFlagSet): string;

  published
    { Published declarations }
    property Wx_Class: string read FWx_Class write FWx_Class;
    property Wx_Comments: TStrings read FWx_Comments write FWx_Comments;
    property Wx_EventList: TStringList read FWx_EventList write FWx_EventList;
    property Wx_AuiManagerStyle: TwxAuiManagerFlagSet read FWx_AuiManagerStyle write FWx_AuiManagerStyle;

    property EVT_AUI_PANE_BUTTON: string Read FEVT_AUI_PANE_BUTTON Write FEVT_AUI_PANE_BUTTON;
    property EVT_AUI_PANE_CLOSE: string Read FEVT_AUI_PANE_CLOSE Write FEVT_AUI_PANE_CLOSE;
    property EVT_AUI_PANE_MAXIMIZE: string Read FEVT_AUI_PANE_MAXIMIZE Write FEVT_AUI_PANE_MAXIMIZE;
    property EVT_AUI_PANE_RESTORE: string Read FEVT_AUI_PANE_RESTORE Write FEVT_AUI_PANE_RESTORE;
    property EVT_AUI_RENDER: string Read FEVT_AUI_RENDER Write FEVT_AUI_RENDER;
    property EVT_AUI_FIND_MANAGER: string Read FEVT_AUI_FIND_MANAGER Write FEVT_AUI_FIND_MANAGER;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxAuiManager]);
end;

{ Method to set variable and property values and create objects }

procedure TWxAuiManager.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Class := 'wxAuiManager';
  FWx_Comments := TStringList.Create;
  FWx_EventList := TStringList.Create;
  Glyph.Handle := LoadBitmap(hInstance, 'TWxAuiManager');
  FWx_AuiManagerStyle := [wxAUI_MGR_ALLOW_FLOATING, wxAUI_MGR_TRANSPARENT_HINT, wxAUI_MGR_HINT_FADE, wxAUI_MGR_NO_VENETIAN_BLINDS_FADE];
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }

procedure TWxAuiManager.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_Comments.Destroy;
  FWx_EventList.Destroy;
  Glyph.Assign(nil);
end; { of AutoDestroy }

constructor TWxAuiManager.Create(AOwner: TComponent);
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
  FWx_PropertyList.add('Wx_AuiManagerStyle:wxAuiManager Styles');
  FWx_PropertyList.add('wxAUI_MGR_ALLOW_FLOATING:wxAUI_MGR_ALLOW_FLOATING');
  FWx_PropertyList.add('wxAUI_MGR_ALLOW_ACTIVE_PANE:wxAUI_MGR_ALLOW_ACTIVE_PANE');
  FWx_PropertyList.add('wxAUI_MGR_TRANSPARENT_DRAG:wxAUI_MGR_TRANSPARENT_DRAG');
  FWx_PropertyList.add('wxAUI_MGR_TRANSPARENT_HINT:wxAUI_MGR_TRANSPARENT_HINT');
  FWx_PropertyList.add('wxAUI_MGR_VENETIAN_BLINDS_HINT:wxAUI_MGR_VENETIAN_BLINDS_HINT');
  FWx_PropertyList.add('wxAUI_MGR_RECTANGLE_HINT:wxAUI_MGR_RECTANGLE_HINT');
  FWx_PropertyList.add('wxAUI_MGR_HINT_FADE:wxAUI_MGR_HINT_FADE');
  FWx_PropertyList.add('wxAUI_MGR_NO_VENETIAN_BLINDS_FADE:wxAUI_MGR_NO_VENETIAN_BLINDS_FADE');

  FWx_EventList.add('EVT_AUI_PANE_BUTTON:OnPaneButton');
  FWx_EventList.add('EVT_AUI_PANE_CLOSE:OnPaneClose');
  FWx_EventList.add('EVT_AUI_PANE_MAXIMIZE:OnPaneMaximize');
  FWx_EventList.add('EVT_AUI_PANE_RESTORE:OnPaneRestore');
  FWx_EventList.add('EVT_AUI_RENDER:OnRender');
  FWx_EventList.add('EVT_AUI_FIND_MANAGER:OnFindManager');
//mn  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxAuiManager.Destroy;
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

function TWxAuiManager.GenerateControlIDs: string;
begin
  Result := '';
end;

function TWxAuiManager.GenerateEnumControlIDs: string;
begin
  Result := '';
end;

function TWxAuiManager.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

  if (XRCGEN) then
 begin
  if trim(EVT_AUI_PANE_BUTTON) <> '' then
    Result := Format('EVT_AUI_PANE_BUTTON(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
      EVT_AUI_PANE_BUTTON]) + '';

  if trim(EVT_AUI_PANE_CLOSE) <> '' then
    Result := Format('EVT_AUI_PANE_CLOSE(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
      EVT_AUI_PANE_CLOSE]) + '';

  if trim(EVT_AUI_PANE_MAXIMIZE) <> '' then
    Result := Format('EVT_AUI_PANE_MAXIMIZE(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
      EVT_AUI_PANE_MAXIMIZE]) + '';

  if trim(EVT_AUI_PANE_RESTORE) <> '' then
    Result := Format('EVT_AUI_PANE_RESTORE(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
      EVT_AUI_PANE_RESTORE]) + '';

  if trim(EVT_AUI_RENDER) <> '' then
    Result := Format('EVT_AUI_RENDER(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
      EVT_AUI_RENDER]) + '';

  if trim(EVT_AUI_FIND_MANAGER) <> '' then
    Result := Format('EVT_AUI_FIND_MANAGER(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
      EVT_AUI_FIND_MANAGER]) + '';

{
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';        \

}
 end
 else
 begin
  if trim(EVT_AUI_PANE_BUTTON) <> '' then
    Result := Format('EVT_AUI_PANE_BUTTON(%s::%s)', [CurrClassName,
      EVT_AUI_PANE_BUTTON]) + '';

  if trim(EVT_AUI_PANE_CLOSE) <> '' then
    Result := Format('EVT_AUI_PANE_CLOSE(%s::%s)', [CurrClassName,
      EVT_AUI_PANE_CLOSE]) + '';

  if trim(EVT_AUI_PANE_MAXIMIZE) <> '' then
    Result := Format('EVT_AUI_PANE_MAXIMIZE(%s::%s)', [CurrClassName,
      EVT_AUI_PANE_MAXIMIZE]) + '';

  if trim(EVT_AUI_PANE_RESTORE) <> '' then
    Result := Format('EVT_AUI_PANE_RESTORE(%s::%s)', [CurrClassName,
      EVT_AUI_PANE_RESTORE]) + '';

  if trim(EVT_AUI_RENDER) <> '' then
    Result := Format('EVT_AUI_RENDER(%s::%s)', [CurrClassName,
      EVT_AUI_RENDER]) + '';

  if trim(EVT_AUI_FIND_MANAGER) <> '' then
    Result := Format('EVT_AUI_FIND_MANAGER(%s::%s)', [CurrClassName,
      EVT_AUI_FIND_MANAGER]) + '';

{
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
}
 end;

end;

function TWxAuiManager.GenerateXRCControlCreation(IndentString: string): TStringList;
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

function TWxAuiManager.GenerateGUIControlCreation: string;
begin

  Result := '';
  Result := GetCommentString(self.FWx_Comments.Text);

  Result := Result + #13 + Format('%s = new %s(this, %s);',
    [self.Name, self.wx_Class, GetAuiManagerFlags(self.Wx_AuiManagerStyle)]);

end;

function TWxAuiManager.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxAuiManager.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/aui/aui.h>';
end;

function TWxAuiManager.GenerateImageInclude: string;
begin

end;

function TWxAuiManager.GetEventList: TStringList;
begin
  Result := Wx_EventList;
end;

function TWxAuiManager.GetIDName: string;
begin

end;

function TWxAuiManager.GetIDValue: integer;
begin
  Result := 0;
end;

function TWxAuiManager.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_AUI_PANE_BUTTON' then
  begin
    Result := 'wxAuiManagerEvent& event';
    exit;
  end;
  if EventName = 'EVT_AUI_PANE_CLOSE' then
  begin
    Result := 'wxAuiManagerEvent& event';
    exit;
  end;
  if EventName = 'EVT_AUI_PANE_MAXIMIZE' then
  begin
    Result := 'wxAuiManagerEvent& event';
    exit;
  end;
  if EventName = 'EVT_AUI_PANE_RESTORE' then
  begin
    Result := 'wxAuiManagerEvent& event';
    exit;
  end;
  if EventName = 'EVT_AUI_RENDER' then
  begin
    Result := 'wxAuiManagerEvent& event';
    exit;
  end;
  if EventName = 'EVT_AUI_FIND_MANAGER' then
  begin
    Result := 'wxAuiManagerEvent& event';
    exit;
  end;
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxAuiManager.GetStretchFactor: integer;
begin
  Result := 1;
end;

function TWxAuiManager.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxAuiManager.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := [];
end;

procedure TWxAuiManager.SetBorderAlignment(border: TWxBorderAlignment);
begin
end;

function TWxAuiManager.GetBorderWidth: integer;
begin
  Result := 0;
end;

procedure TWxAuiManager.SetBorderWidth(width: integer);
begin
end;

function TWxAuiManager.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxAuiManager.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxAuiManager';
  Result := wx_Class;
end;

procedure TWxAuiManager.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin

end;

procedure TWxAuiManager.SetIDName(IDName: string);
begin

end;

procedure TWxAuiManager.SetIDValue(IDValue: integer);
begin

end;

procedure TWxAuiManager.SetStretchFactor(intValue: integer);
begin
end;

procedure TWxAuiManager.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxAuiManager.GetFGColor: string;
begin

end;

procedure TWxAuiManager.SetFGColor(strValue: string);
begin
end;

function TWxAuiManager.GetBGColor: string;
begin
end;

procedure TWxAuiManager.SetBGColor(strValue: string);
begin
end;

procedure TWxAuiManager.SetProxyFGColorString(Value: string);
begin
end;

procedure TWxAuiManager.SetProxyBGColorString(Value: string);
begin
end;

function TWxAuiManager.GetGenericColor(strVariableName: string): string;
begin
end;

procedure TWxAuiManager.SetGenericColor(strVariableName, strValue: string);
begin

end;

function TWxAuiManager.GetAuiManagerFlags(Wx_AuiManagerStyles: TwxAuiManagerFlagSet): string;
var
  I: integer;
  strLst: TStringList;
begin
  strLst := TStringList.Create;

  try

    if wxAUI_MGR_ALLOW_FLOATING in Wx_AuiManagerStyles then
      strLst.add('wxAUI_MGR_ALLOW_FLOATING ');

    if wxAUI_MGR_ALLOW_ACTIVE_PANE in Wx_AuiManagerStyles then
      strLst.add('wxAUI_MGR_ALLOW_ACTIVE_PANE ');

    if wxAUI_MGR_TRANSPARENT_DRAG in Wx_AuiManagerStyles then
      strLst.add('wxAUI_MGR_TRANSPARENT_DRAG ');

    if wxAUI_MGR_TRANSPARENT_HINT in Wx_AuiManagerStyles then
      strLst.add('wxAUI_MGR_TRANSPARENT_HINT ');

    if wxAUI_MGR_VENETIAN_BLINDS_HINT in Wx_AuiManagerStyles then
      strLst.add('wxAUI_MGR_VENETIAN_BLINDS_HINT ');

    if wxAUI_MGR_RECTANGLE_HINT in Wx_AuiManagerStyles then
      strLst.add('wxAUI_MGR_RECTANGLE_HINT ');

    if wxAUI_MGR_HINT_FADE in Wx_AuiManagerStyles then
      strLst.add('wxAUI_MGR_HINT_FADE ');

    if wxAUI_MGR_NO_VENETIAN_BLINDS_FADE in Wx_AuiManagerStyles then
      strLst.add('wxAUI_MGR_NO_VENETIAN_BLINDS_FADE ');

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i] // for
          ;
    //sendDebug(Result);
  finally
    strLst.Destroy;
  end;
end;

end.
 
