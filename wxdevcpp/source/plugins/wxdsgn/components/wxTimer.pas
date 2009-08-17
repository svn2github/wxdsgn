// $Id: wxTimer.pas 936 2007-05-15 03:47:39Z gururamnath $
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

unit WxTimer;

interface

uses
  Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

type
  TWxTimer = class(TWxNonVisibleBaseComponent, IWxComponentInterface)
  private
    { Private declarations }
    FWx_Class: string;
    FWx_PropertyList: TStringList;
    FWx_EventList: TStringList;
    FWx_IDName: string;
    FWx_IDValue: longint;
    FWx_Interval: integer;
    FWx_AutoStart: boolean;
    FWx_Comments: TStrings;

    FEVT_TIMER: string;

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
    function GetIDValue: longint;
    function GetParameterFromEventName(EventName: string): string;
    function GetPropertyList: TStringList;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: longint);
    procedure SetWxClassName(wxClassName: string);
    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);
    
    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);
    
  published
    { Published declarations }
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue;
    property Wx_Interval: integer Read FWx_Interval Write FWx_Interval;
    property Wx_AutoStart: boolean Read FWx_AutoStart Write FWx_AutoStart;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

    property EVT_TIMER: string Read FEVT_TIMER Write FEVT_TIMER;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxTimer]);
end;

{ Method to set variable and property values and create objects }
procedure TWxTimer.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_EventList := TStringList.Create;
  FWx_Class     := 'wxTimer';
  Glyph.Handle  := LoadBitmap(hInstance, 'TWxTimer');
  FWx_Interval  := 100;
  FWx_AutoStart := False;
  FWx_Comments  := TStringList.Create;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxTimer.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_Comments.Destroy;
  Glyph.Assign(nil);
end; { of AutoDestroy }

constructor TWxTimer.Create(AOwner: TComponent);
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

  { Code to perform other tasks when the component is created }
  { Code to perform other tasks when the component is created }
  FWx_PropertyList.add('Wx_IDName:IDName');
  FWx_PropertyList.add('Wx_IDValue:IDValue');
  FWx_PropertyList.add('Wx_Interval:Interval');
  FWx_PropertyList.add('Wx_AutoStart:AutoStart');

  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Wx_Class:Base Class');

  FWx_PropertyList.add('Wx_Comments:Comments');

  FWx_EventList.add('EVT_TIMER:OnTimer');

end;

destructor TWxTimer.Destroy;
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

function TWxTimer.GenerateEnumControlIDs: string;
begin
  Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
end;

function TWxTimer.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxTimer.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
  if trim(EVT_TIMER) <> '' then
    Result := Format('EVT_TIMER(%s,%s::%s)', [WX_IDName, CurrClassName, EVT_TIMER]) + '';
end;

function TWxTimer.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <interval>%d</interval>', [self.Wx_Interval]));
    Result.Add(IndentString + '</object>');
  except
    Result.Free;
    raise;
  end;

end;

function TWxTimer.GenerateGUIControlCreation: string;
begin
  Result := '';
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s();', [self.Name, self.wx_Class]);
  Result := Result + #13 + Format('%s->SetOwner(this, %s);', [self.Name, Wx_IDName]);

  if Wx_AutoStart = True then
    Result := Result + #13 + Format('%s->Start(%d);', [self.Name, self.Wx_Interval]);

end;

function TWxTimer.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxTimer.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/timer.h>';
end;

function TWxTimer.GenerateImageInclude: string;
begin

end;

function TWxTimer.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxTimer.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxTimer.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxTimer.GetParameterFromEventName(EventName: string): string;
begin
  Result := '';
  if EventName = 'EVT_TIMER' then
  begin
    Result := 'wxTimerEvent& event';
    exit;
  end;
end;

function TWxTimer.GetStretchFactor: Integer;
begin
   Result := 1;
end;

function TWxTimer.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxTimer.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := [];
end;

procedure TWxTimer.SetBorderAlignment(border: TWxBorderAlignment);
begin
end;

function TWxTimer.GetBorderWidth: integer;
begin
  Result := 0;
end;

procedure TWxTimer.SetBorderWidth(width: integer);
begin
end;

function TWxTimer.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxTimer.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxTimer';
  Result := wx_Class;
end;

procedure TWxTimer.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin

end;

procedure TWxTimer.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxTimer.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxTimer.SetStretchFactor(intValue: integer);
begin
end;

procedure TWxTimer.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxTimer.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxTimer.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxTimer.GetFGColor: string;
begin

end;

procedure TWxTimer.SetFGColor(strValue: string);
begin
end;

function TWxTimer.GetBGColor: string;
begin
end;

procedure TWxTimer.SetBGColor(strValue: string);
begin
end;

procedure TWxTimer.SetProxyFGColorString(Value: string);
begin
end;

procedure TWxTimer.SetProxyBGColorString(Value: string);
begin

end;

end.
 