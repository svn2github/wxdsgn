// $Id: wxMessageDialog.pas 936 2007-05-15 03:47:39Z gururamnath $
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


unit wxMessageDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

type
  TWxMessageDialog = class(TWxNonVisibleBaseComponent, IWxComponentInterface)
  private
    { Private declarations }
    FWx_Class: string;
    FWx_PropertyList: TStringList;
    FWx_Message: string;
    FWx_Caption: string;
    FWx_Comments: TStrings;

    FWx_DialogStyle: TWxMessageDialogStyleSet;
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
    property Wx_Message: string Read FWx_Message Write FWx_Message;
    property Wx_Caption: string Read FWx_Caption Write FWx_Caption;
    property Wx_DialogStyle: TWxMessageDialogStyleSet
      Read FWx_DialogStyle Write FWx_DialogStyle;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxMessageDialog]);
end;

{ Method to set variable and property values and create objects }
procedure TWxMessageDialog.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Class    := 'wxMessageDialog';
  Glyph.Handle := LoadBitmap(hInstance, 'TWxMessageDialog');
  FWx_Caption  := 'Message box';
  FWx_Comments := TStringList.Create;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxMessageDialog.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_Comments.Destroy;
  Glyph.Assign(nil);
end; { of AutoDestroy }

constructor TWxMessageDialog.Create(AOwner: TComponent);
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
  FWx_PropertyList.add('Wx_DialogStyle:Message Dialog Style');

  FWx_PropertyList.add('wxOK:wxOK');
  FWx_PropertyList.add('wxCENTRE:wxCENTRE');
  FWx_PropertyList.add('wxCANCEL:wxCANCEL');
  FWx_PropertyList.add('wxYES_NO:wxYES_NO');
  FWx_PropertyList.add('wxYES_DEFAULT:wxYES_DEFAULT');
  FWx_PropertyList.add('wxNO_DEFAULT:wxNO_DEFAULT');
  FWx_PropertyList.add('wxICON_EXCLAMATION:wxICON_EXCLAMATION');
  FWx_PropertyList.add('wxICON_HAND:wxICON_HAND');
  FWx_PropertyList.add('wxICON_ERROR:wxICON_ERROR');
  FWx_PropertyList.add('wxICON_QUESTION:wxICON_QUESTION');
  FWx_PropertyList.add('wxICON_INFORMATION:wxICON_INFORMATION');
  FWx_PropertyList.add('wxSTAY_ON_TOP:wxSTAY_ON_TOP');

  FWx_PropertyList.add('Wx_Message:Message');
  FWx_PropertyList.add('Wx_Caption:Caption');
  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Wx_Class:Base Class');
  FWx_PropertyList.add('Wx_Comments:Comments');

end;

destructor TWxMessageDialog.Destroy;
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

function TWxMessageDialog.GenerateControlIDs: string;
begin
  Result := '';
end;


function TWxMessageDialog.GenerateEnumControlIDs: string;
begin
  Result := '';
end;

function TWxMessageDialog.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
end;

function TWxMessageDialog.GenerateXRCControlCreation(IndentString: string): TStringList;
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

function TWxMessageDialog.GenerateGUIControlCreation: string;
var
  strStyle: string;
begin
  Result   := '';
  strStyle := GetMessageDialogStyleString(self.Wx_DialogStyle,false);
  Result   := GetCommentString(self.FWx_Comments.Text) +
    Format('%s =  new %s(this, %s, %s%s);', [self.Name, self.wx_Class,
    GetCppString(wx_Message), GetCppString(wx_Caption), strStyle]);
end;

function TWxMessageDialog.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxMessageDialog.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/msgdlg.h>';
end;

function TWxMessageDialog.GenerateImageInclude: string;
begin

end;

function TWxMessageDialog.GetEventList: TStringList;
begin
  Result := nil;
end;

function TWxMessageDialog.GetIDName: string;
begin

end;

function TWxMessageDialog.GetIDValue: integer;
begin
  Result := 0;
end;

function TWxMessageDialog.GetParameterFromEventName(EventName: string): string;
begin

end;

function TWxMessageDialog.GetStretchFactor: integer;
begin
   Result := 1;
end;

function TWxMessageDialog.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxMessageDialog.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := [];
end;

procedure TWxMessageDialog.SetBorderAlignment(border: TWxBorderAlignment);
begin
end;

function TWxMessageDialog.GetBorderWidth: integer;
begin
  Result := 0;
end;

procedure TWxMessageDialog.SetBorderWidth(width: integer);
begin
end;

function TWxMessageDialog.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxMessageDialog.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxMessageDialog';
  Result := wx_Class;
end;

procedure TWxMessageDialog.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin

end;

procedure TWxMessageDialog.SetIDName(IDName: string);
begin

end;

procedure TWxMessageDialog.SetIDValue(IDValue: integer);
begin

end;

procedure TWxMessageDialog.SetStretchFactor(intValue: integer);
begin
end;

procedure TWxMessageDialog.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxMessageDialog.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxMessageDialog.SetGenericColor(strVariableName,strValue: string);
begin

end;


function TWxMessageDialog.GetFGColor: string;
begin

end;

procedure TWxMessageDialog.SetFGColor(strValue: string);
begin
end;

function TWxMessageDialog.GetBGColor: string;
begin
end;

procedure TWxMessageDialog.SetBGColor(strValue: string);
begin
end;

procedure TWxMessageDialog.SetProxyFGColorString(Value: string);
begin
end;

procedure TWxMessageDialog.SetProxyBGColorString(Value: string);
begin

end;

end.
 