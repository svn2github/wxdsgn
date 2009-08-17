// $Id: wxHtmlEasyPrinting.pas 936 2007-05-15 03:47:39Z gururamnath $
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


unit wxHtmlEasyPrinting;

interface

uses
  Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

type
  TWxHtmlEasyPrinting = class(TWxNonVisibleBaseComponent, IWxComponentInterface)
  private
    { Private declarations }
    FWx_Class: string;
    FWx_PropertyList: TStringList;
    FWx_EventList   : TStringList;
    FWx_FooterString: string;
    FWx_FooterPage: integer;
    FWx_HeaderString: string;
    FWx_HeaderPage: integer;
    FWx_Title:String;    
    FWx_Comments: TStrings;


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
    property Wx_FooterString: string Read FWx_FooterString Write FWx_FooterString;
    property Wx_FooterPage: integer Read FWx_FooterPage Write FWx_FooterPage;
    property Wx_HeaderString: string Read FWx_HeaderString Write FWx_HeaderString;
    property Wx_HeaderPage: integer Read FWx_HeaderPage Write FWx_HeaderPage;
    property Wx_Title:String Read FWx_Title Write FWx_Title;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxHtmlEasyPrinting]);
end;

{ Method to set variable and property values and create objects }
procedure TWxHtmlEasyPrinting.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_EventList    := TStringList.Create;
  FWx_Class    := 'wxHtmlEasyPrinting';
  FWx_Comments := TStringList.Create;
  FWx_FooterPage:= 0;  
  FWx_HeaderPage:= 0;
  Glyph.Handle := LoadBitmap(hInstance, 'TWxHtmlEasyPrinting');
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxHtmlEasyPrinting.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_Comments.Destroy;
  Glyph.Assign(nil);
end; { of AutoDestroy }

constructor TWxHtmlEasyPrinting.Create(AOwner: TComponent);
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

  FWx_PropertyList.add('Wx_FooterString:Footer String');
  FWx_PropertyList.add('Wx_FooterPage:Footer Page');
  FWx_PropertyList.add('Wx_HeaderString:Header String');
  FWx_PropertyList.add('Wx_HeaderPage:Header Page');
  FWx_PropertyList.add('Wx_Title:Title');
    
end;

destructor TWxHtmlEasyPrinting.Destroy;
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

function TWxHtmlEasyPrinting.GenerateControlIDs: string;
begin
  Result := '';
end;

function TWxHtmlEasyPrinting.GenerateEnumControlIDs: string;
begin
  Result := '';
end;

function TWxHtmlEasyPrinting.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := ''; 
end;

function TWxHtmlEasyPrinting.GenerateXRCControlCreation(IndentString: string): TStringList;
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

function TWxHtmlEasyPrinting.GenerateGUIControlCreation: string;
begin

  Result := '';
  Result := GetCommentString(self.FWx_Comments.Text);

  Result := Result + #13 + Format('%s =  new %s(%s,this);',
    [self.Name, Wx_Class,GetCppString(self.wx_Title)]);

  if trim(wx_HeaderString) <> '' then
	Result := Result + #13 + Format('%s->SetHeader(%s,%d);',[self.Name, GetCppString(self.wx_HeaderString),wx_HeaderPage]);
  if trim(wx_FooterString) <> '' then
	Result := Result + #13 + Format('%s->SetFooter(%s,%d);',[self.Name, GetCppString(self.wx_FooterString),wx_FooterPage]);

end;

function TWxHtmlEasyPrinting.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);  
end;

function TWxHtmlEasyPrinting.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/html/htmprint.h>';  
end;

function TWxHtmlEasyPrinting.GenerateImageInclude: string;
begin

end;

function TWxHtmlEasyPrinting.GetEventList: TStringList;
begin
  Result := nil;
end;

function TWxHtmlEasyPrinting.GetIDName: string;
begin

end;

function TWxHtmlEasyPrinting.GetIDValue: integer;
begin
  Result := 0;
end;

function TWxHtmlEasyPrinting.GetParameterFromEventName(EventName: string): string;
begin

end;

function TWxHtmlEasyPrinting.GetStretchFactor: integer;
begin
    Result := 1;
end;

function TWxHtmlEasyPrinting.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxHtmlEasyPrinting.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := [];
end;

procedure TWxHtmlEasyPrinting.SetBorderAlignment(border: TWxBorderAlignment);
begin
end;

function TWxHtmlEasyPrinting.GetBorderWidth: integer;
begin
  Result := 0;
end;

procedure TWxHtmlEasyPrinting.SetBorderWidth(width: integer);
begin
end;

function TWxHtmlEasyPrinting.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxHtmlEasyPrinting.GetWxClassName: string;
begin
  if trim(Wx_Class) = '' then
    Wx_Class := 'wxHtmlEasyPrinting';
  Result := Wx_Class;
end;

procedure TWxHtmlEasyPrinting.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin

end;

procedure TWxHtmlEasyPrinting.SetIDName(IDName: string);
begin

end;

procedure TWxHtmlEasyPrinting.SetIDValue(IDValue: integer);
begin

end;

procedure TWxHtmlEasyPrinting.SetStretchFactor(intValue: integer);
begin
end;

procedure TWxHtmlEasyPrinting.SetWxClassName(wxClassName: string);
begin
  Wx_Class := wxClassName;
end;

function TWxHtmlEasyPrinting.GetFGColor: string;
begin

end;

procedure TWxHtmlEasyPrinting.SetFGColor(strValue: string);
begin
end;

function TWxHtmlEasyPrinting.GetBGColor: string;
begin
end;

procedure TWxHtmlEasyPrinting.SetBGColor(strValue: string);
begin
end;

procedure TWxHtmlEasyPrinting.SetProxyFGColorString(Value: string);
begin
end;

procedure TWxHtmlEasyPrinting.SetProxyBGColorString(Value: string);
begin
end;

function TWxHtmlEasyPrinting.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxHtmlEasyPrinting.SetGenericColor(strVariableName,strValue: string);
begin

end;


end.
 