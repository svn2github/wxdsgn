// $Id: wxDialUpManager.pas 936 2007-05-15 03:47:39Z gururamnath $
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


unit wxDialUpManager;

interface

uses
  Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

type
  TWxDialUpManager = class(TWxNonVisibleBaseComponent, IWxComponentInterface)
  private
    { Private declarations }
    FWx_Class: string;
    FWx_PropertyList: TStringList;
    FWx_EventList   : TStringList;
    FWx_Comments: TStrings;
    FEVT_DIALUP_CONNECTED:String;
    FEVT_DIALUP_DISCONNECTED:String;

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
    
    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

  published
    { Published declarations }
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
    property EVT_DIALUP_CONNECTED:String Read FEVT_DIALUP_CONNECTED Write FEVT_DIALUP_CONNECTED;
    property EVT_DIALUP_DISCONNECTED:String Read FEVT_DIALUP_DISCONNECTED Write FEVT_DIALUP_DISCONNECTED;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxDialUpManager]);
end;

{ Method to set variable and property values and create objects }
procedure TWxDialUpManager.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_EventList    := TStringList.Create;
  FWx_Class    := 'wxDialUpManager';
  FWx_Comments := TStringList.Create;
  Glyph.Handle := LoadBitmap(hInstance, 'TWxDialUpManager');
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxDialUpManager.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_Comments.Destroy;
  Glyph.Assign(nil);
end; { of AutoDestroy }

constructor TWxDialUpManager.Create(AOwner: TComponent);
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
  FWx_EventList.add('EVT_DIALUP_CONNECTED:OnDialupConnected');
  FWx_EventList.add('EVT_DIALUP_DISCONNECTED:OnDialupDisConnected');  
end;

destructor TWxDialUpManager.Destroy;
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

function TWxDialUpManager.GenerateControlIDs: string;
begin
  Result := '';
end;

function TWxDialUpManager.GenerateEnumControlIDs: string;
begin
  Result := '';
end;

function TWxDialUpManager.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
  
  if trim(EVT_DIALUP_CONNECTED) <> '' then
    Result := Format('EVT_DIALUP_CONNECTED(%s::%s)',
      [ CurrClassName, EVT_DIALUP_CONNECTED]) + '';

  if trim(EVT_DIALUP_DISCONNECTED) <> '' then
    Result := Result + #13 + Format('EVT_DIALUP_DISCONNECTED(%s::%s)',
      [CurrClassName, EVT_DIALUP_DISCONNECTED]) + '';
  
end;

function TWxDialUpManager.GenerateXRCControlCreation(IndentString: string): TStringList;
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

function TWxDialUpManager.GenerateGUIControlCreation: string;
begin

  Result := '';
  Result := GetCommentString(self.FWx_Comments.Text);

  Result := Result + #13 + Format('%s =  %s::Create();',
    [self.Name, self.wx_Class]);

end;

function TWxDialUpManager.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);  
end;

function TWxDialUpManager.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/dialup.h>';  
end;

function TWxDialUpManager.GenerateImageInclude: string;
begin

end;

function TWxDialUpManager.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxDialUpManager.GetIDName: string;
begin

end;

function TWxDialUpManager.GetIDValue: integer;
begin
  Result := 0;
end;

function TWxDialUpManager.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_DIALUP_CONNECTED' then
  begin
    Result := 'wxDialUpEvent& event';
    exit;
  end;
  if EventName = 'EVT_DIALUP_DISCONNECTED' then
  begin
    Result := 'wxDialUpEvent& event';
    exit;
  end;
end;

function TWxDialUpManager.GetStretchFactor: integer;
begin
    Result := 1;
end;

function TWxDialUpManager.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxDialUpManager.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := [];
end;

procedure TWxDialUpManager.SetBorderAlignment(border: TWxBorderAlignment);
begin
end;

function TWxDialUpManager.GetBorderWidth: integer;
begin
  Result := 0;
end;

procedure TWxDialUpManager.SetBorderWidth(width: integer);
begin
end;

function TWxDialUpManager.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxDialUpManager.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxDialUpManager';
  Result := wx_Class;
end;

procedure TWxDialUpManager.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin

end;

procedure TWxDialUpManager.SetIDName(IDName: string);
begin

end;

procedure TWxDialUpManager.SetIDValue(IDValue: integer);
begin

end;

procedure TWxDialUpManager.SetStretchFactor(intValue: integer);
begin
end;

procedure TWxDialUpManager.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxDialUpManager.GetFGColor: string;
begin

end;

procedure TWxDialUpManager.SetFGColor(strValue: string);
begin
end;

function TWxDialUpManager.GetBGColor: string;
begin
end;

procedure TWxDialUpManager.SetBGColor(strValue: string);
begin
end;

procedure TWxDialUpManager.SetProxyFGColorString(Value: string);
begin
end;

procedure TWxDialUpManager.SetProxyBGColorString(Value: string);
begin
end;

function TWxDialUpManager.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxDialUpManager.SetGenericColor(strVariableName,strValue: string);
begin

end;

end.
 