// $Id: wxFindReplaceDialog.pas 936 2007-05-15 03:47:39Z gururamnath $
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


unit WxFindReplaceDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

type
  TWxFindReplaceDialog = class(TWxNonVisibleBaseComponent, IWxComponentInterface)
  private
    { Private declarations }
    FWx_Class: string;
    FWx_PropertyList: TStringList;
    FWx_FindString: string;
    FWx_ReplaceString: string;
    FWx_Title: string;
    FWx_Flags: TWxFindReplaceFlagSet;
    FWx_Styles: TwxFindReplaceDialogStyleSet;

    FEVT_FIND: string;
    FEVT_FIND_NEXT: string;
    FEVT_FIND_REPLACE: string;
    FEVT_FIND_REPLACE_ALL: string;
    FEVT_FIND_CLOSE: string;
    FEVT_UPDATE_UI: string;
    FWx_EventList: TStringList;

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
    property Wx_FindString: string Read FWx_FindString Write FWx_FindString;
    property Wx_ReplaceString: string Read FWx_ReplaceString Write FWx_ReplaceString;
    property Wx_Title: string Read FWx_Title Write FWx_Title;
    property Wx_Flags: TWxFindReplaceFlagSet Read FWx_Flags Write FWx_Flags;
    property Wx_Styles: TwxFindReplaceDialogStyleSet Read FWx_Styles Write FWx_Styles;

    property EVT_FIND: string Read FEVT_FIND Write FEVT_FIND;
    property EVT_FIND_NEXT: string Read FEVT_FIND_NEXT Write FEVT_FIND_NEXT;
    property EVT_FIND_REPLACE: string Read FEVT_FIND_REPLACE Write FEVT_FIND_REPLACE;
    property EVT_FIND_REPLACE_ALL: string Read FEVT_FIND_REPLACE_ALL Write FEVT_FIND_REPLACE_ALL;
    property EVT_FIND_CLOSE: string Read FEVT_FIND_CLOSE Write FEVT_FIND_CLOSE;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Wx_EventList: TStringList Read FWx_EventList Write FWx_EventList;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxFindReplaceDialog]);
end;

{ Method to set variable and property values and create objects }
procedure TWxFindReplaceDialog.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Class    := 'wxFindReplaceDialog';
  Glyph.Handle := LoadBitmap(hInstance, 'TWxFindReplaceDialog');
  FWx_EventList          := TStringList.Create;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxFindReplaceDialog.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  Glyph.Assign(nil);
  FWx_EventList.Destroy;
end; { of AutoDestroy }

constructor TWxFindReplaceDialog.Create(AOwner: TComponent);
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
  FWx_PropertyList.add('Wx_Flags:Flags');
  FWx_PropertyList.add('Wx_Styles:Styles');

  FWx_PropertyList.add('wxFR_DOWN:wxFR_DOWN');
  FWx_PropertyList.add('wxFR_WHOLEWORD:wxFR_WHOLEWORD');
  FWx_PropertyList.add('wxFR_MATCHCASE:wxFR_MATCHCASE');
  FWx_PropertyList.add('wxFR_REPLACEDIALOG:wxFR_REPLACEDIALOG');
  FWx_PropertyList.add('wxFR_NOUPDOWN:wxFR_NOUPDOWN');
  FWx_PropertyList.add('wxFR_NOMATCHCASE:wxFR_NOMATCHCASE');
  FWx_PropertyList.add('wxFR_NOWHOLEWORD:wxFR_NOWHOLEWORD');

  FWx_PropertyList.add('Wx_Message:Message');
  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Wx_Class:Base Class');
  FWx_PropertyList.add('Wx_Title:Title');

  FWx_PropertyList.add('Wx_FindString:FindString');
  FWx_PropertyList.add('Wx_ReplaceString:ReplaceString');

  FWx_EventList.add('EVT_FIND:OnFind');
  FWx_EventList.add('EVT_FIND_NEXT:OnFindNext');
  FWx_EventList.add('EVT_FIND_REPLACE:OnReplace');
  FWx_EventList.add('EVT_FIND_REPLACE_ALL:OnReplaceAll');
  FWx_EventList.add('EVT_FIND_CLOSE:OnClose');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');


end;

destructor TWxFindReplaceDialog.Destroy;
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

function TWxFindReplaceDialog.GenerateControlIDs: string;
begin
  Result := '';
end;

function TWxFindReplaceDialog.GenerateEnumControlIDs: string;
begin
  Result := '';
end;

function TWxFindReplaceDialog.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

  if (XRCGEN) then
 begin
  if trim(EVT_FIND) <> '' then
    Result := Format('EVT_FIND(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
      EVT_FIND]) + '';

  if trim(EVT_FIND_NEXT) <> '' then
    Result := Format('EVT_FIND_NEXT(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
      EVT_FIND_NEXT]) + '';

  if trim(EVT_FIND_REPLACE) <> '' then
    Result := Format('EVT_FIND_REPLACE(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
      EVT_FIND_REPLACE]) + '';

  if trim(EVT_FIND_REPLACE_ALL) <> '' then
    Result := Format('EVT_FIND_REPLACE_ALL(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
      EVT_FIND_REPLACE_ALL]) + '';

  if trim(EVT_FIND_CLOSE) <> '' then
    Result := Format('EVT_FIND_CLOSE(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
      EVT_FIND_CLOSE]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';

 end
 else
 begin
  if trim(EVT_FIND) <> '' then
    Result := Format('EVT_FIND(wxID_ANY,%s::%s)', [CurrClassName,
      EVT_FIND]) + '';

  if trim(EVT_FIND_NEXT) <> '' then
    Result := Format('EVT_FIND_NEXT(wxID_ANY,%s::%s)', [CurrClassName,
      EVT_FIND_NEXT]) + '';

  if trim(EVT_FIND_REPLACE) <> '' then
    Result := Format('EVT_FIND_REPLACE(wxID_ANY,%s::%s)', [CurrClassName,
      EVT_FIND_REPLACE]) + '';

  if trim(EVT_FIND_REPLACE_ALL) <> '' then
    Result := Format('EVT_FIND_REPLACE_ALL(wxID_ANY,%s::%s)', [CurrClassName,
      EVT_FIND_REPLACE_ALL]) + '';

  if trim(EVT_FIND_CLOSE) <> '' then
    Result := Format('EVT_FIND_CLOSE(wxID_ANY,%s::%s)', [CurrClassName,
      EVT_FIND_CLOSE]) + '';

{
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
}
 end;

end;

function TWxFindReplaceDialog.GenerateXRCControlCreation(IndentString: string):
TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(Format('<object class="%s" name="%s">', [self.Wx_Class, self.Name]));
    Result.Add('</object>');
  except
    Result.Free;
    raise;
  end;

end;

function TWxFindReplaceDialog.GenerateGUIControlCreation: string;
var
  strFlag, strStyle: string;

begin
  Result  := '';
  strFlag := GetFindReplaceFlagString(Wx_Flags);
  if strFlag = '' then
    strFlag := '0';
  Result := self.Name + '_Data = new wxFindReplaceData(' + strFlag + ');';
  Result := Result + #13 + self.Name + '_Data->SetFindString(' + GetCppString(
    Wx_FindString) + ');';
  Result := Result + #13 + self.Name + '_Data->SetReplaceString(' + GetCppString(
    Wx_ReplaceString) + ');';

  strStyle := GetFindReplaceDialogStyleString(Wx_Styles);
  if strStyle = '' then
    strStyle := ',0';

  Result := Result + #13 + Format('%s =  new %s(this, %s, %s %s);',
    [self.Name, self.wx_Class, self.Name + '_Data', GetCppString(Wx_Title), strStyle]);

end;

function TWxFindReplaceDialog.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
  Result := Result + #13 + Format('wxFindReplaceData *%s_Data;', [trim(Self.Name)]);
end;

function TWxFindReplaceDialog.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/fdrepdlg.h>';
end;

function TWxFindReplaceDialog.GenerateImageInclude: string;
begin

end;

function TWxFindReplaceDialog.GetEventList: TStringList;
begin
  Result := Wx_EventList;
end;

function TWxFindReplaceDialog.GetIDName: string;
begin

end;

function TWxFindReplaceDialog.GetIDValue: longint;
begin
  Result := 0;
end;

function TWxFindReplaceDialog.GetParameterFromEventName(EventName: string): string;
begin

  if EventName = 'EVT_FIND' then
  begin
    Result := 'wxFindDialogEvent& event';
    exit;
  end;
  if EventName = 'EVT_FIND_NEXT' then
  begin
    Result := 'wxFindDialogEvent& event';
    exit;
  end;
  if EventName = 'EVT_FIND_REPLACE' then
  begin
    Result := 'wxFindDialogEvent& event';
    exit;
  end;
  if EventName = 'EVT_FIND_REPLACE_ALL' then
  begin
    Result := 'wxFindDialogEvent& event';
    exit;
  end;
  if EventName = 'EVT_FIND_CLOSE' then
  begin
    Result := 'wxFindDialogEvent& event';
    exit;
  end;
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;

end;

function TWxFindReplaceDialog.GetStretchFactor: integer;
begin
   Result := 1;
end;

function TWxFindReplaceDialog.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxFindReplaceDialog.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := [];
end;

procedure TWxFindReplaceDialog.SetBorderAlignment(border: TWxBorderAlignment);
begin
end;

function TWxFindReplaceDialog.GetBorderWidth: integer;
begin
  Result := 0;
end;

procedure TWxFindReplaceDialog.SetBorderWidth(width: integer);
begin
end;

function TWxFindReplaceDialog.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxFindReplaceDialog.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxFindReplaceDialog';
  Result := wx_Class;
end;

procedure TWxFindReplaceDialog.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin

end;

procedure TWxFindReplaceDialog.SetIDName(IDName: string);
begin

end;

procedure TWxFindReplaceDialog.SetIDValue(IDValue: longint);
begin

end;

procedure TWxFindReplaceDialog.SetStretchFactor(intValue: integer);
begin
end;

procedure TWxFindReplaceDialog.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxFindReplaceDialog.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxFindReplaceDialog.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxFindReplaceDialog.GetFGColor: string;
begin

end;

procedure TWxFindReplaceDialog.SetFGColor(strValue: string);
begin
end;

function TWxFindReplaceDialog.GetBGColor: string;
begin
end;

procedure TWxFindReplaceDialog.SetBGColor(strValue: string);
begin
end;

procedure TWxFindReplaceDialog.SetProxyFGColorString(Value: string);
begin
end;

procedure TWxFindReplaceDialog.SetProxyBGColorString(Value: string);
begin
end;

end.
