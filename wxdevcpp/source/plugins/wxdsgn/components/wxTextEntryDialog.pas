// $Id: wxTextEntryDialog.pas 936 2007-05-15 03:47:39Z gururamnath $
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

unit wxTextEntryDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

type
  TWxTextEntryDialog = class(TWxNonVisibleBaseComponent, IWxComponentInterface)
  private
    { Private declarations }
    FWx_Class: string;
    FWx_PropertyList: TStringList;
    FWx_DialogStyle: TWxMessageDialogStyleSet;
    FWx_EditStyle: TWxEdtGeneralStyleSet;
    FWx_Caption: string;
    FWx_Value: string;
    FWx_Message: string;
    FWx_Comments: TStrings;

    procedure AutoInitialize;
    procedure AutoDestroy;

    { Read method for property Wx_EditStyle }
    function GetWx_EditStyle: TWxEdtGeneralStyleSet;
    { Write method for property Wx_EditStyle }
    procedure SetWx_EditStyle(Value: TWxEdtGeneralStyleSet);

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
	property Wx_Value: string Read FWx_Value Write FWx_Value;
	
    property Wx_DialogStyle: TWxMessageDialogStyleSet Read FWx_DialogStyle Write FWx_DialogStyle;
    property Wx_EditStyle: TWxEdtGeneralStyleSet
        Read GetWx_EditStyle Write SetWx_EditStyle;
        //Read FWx_EditStyle write FWx_EditStyle;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxTextEntryDialog]);
end;

procedure TWxTextEntryDialog.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Class    := 'wxTextEntryDialog';
  Glyph.Handle := LoadBitmap(hInstance, 'TWxMessageDialog');
  FWX_Caption := 'Please enter text';
  FWX_Value := '';
  FWx_DialogStyle := [wxOK , wxCANCEL , wxCENTRE];
  FWx_Comments := TStringList.Create;

end; { of AutoInitialize }

procedure TWxTextEntryDialog.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_Comments.Destroy;
  Glyph.Assign(nil);
end; { of AutoDestroy }

constructor TWxTextEntryDialog.Create(AOwner: TComponent);
begin
  { Call the Create method of the container's parent class       }
  inherited Create(AOwner);

  AutoInitialize;
  { Code to perform other tasks when the component is created }
  FWx_PropertyList.add('Wx_DialogStyle:Dialog Style');
  FWx_PropertyList.add('wxOK:wxOK');
  FWx_PropertyList.add('wxCANCEL:wxCANCEL');
  FWx_PropertyList.add('wxYES_NO:wxYES_NO');
  FWx_PropertyList.add('wxYES_DEFAULT:wxYES_DEFAULT');
  FWx_PropertyList.add('wxNO_DEFAULT:wxNO_DEFAULT');
  FWx_PropertyList.add('wxCENTRE:wxCENTRE');
  
  FWx_PropertyList.add('Wx_EditStyle:Edit Style');
  FWx_PropertyList.add('wxTE_PASSWORD:wxTE_PASSWORD');
  
  FWx_PropertyList.add('Wx_Message:Message');
  FWx_PropertyList.add('Wx_Caption:Caption');
  FWx_PropertyList.add('WX_Value:Value');
  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Wx_Class:Base Class');
  FWx_PropertyList.add('Wx_Comments:Comments');

end;

destructor TWxTextEntryDialog.Destroy;
begin
  AutoDestroy;
  inherited Destroy;
end;

function TWxTextEntryDialog.GenerateControlIDs: string;
begin
  Result := '';
end;

function TWxTextEntryDialog.GenerateEnumControlIDs: string;
begin
  Result := '';
end;

function TWxTextEntryDialog.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
end;

function TWxTextEntryDialog.GenerateGUIControlCreation: string;
var
	parentName:string;
begin
  Result := '';
  parentName := GetWxWidgetParent(self, False);
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s =  new %s( this,%s, %s, %s %s);',
    [self.Name, self.wx_Class, GetCppString(self.Wx_Message), GetCppString(self.Wx_Caption),
    GetCppString(self.Wx_Value), GetTextEntryDialogStyleString(Wx_DialogStyle,Wx_EditStyle)]);

end;

function TWxTextEntryDialog.GenerateXRCControlCreation(IndentString: string): TStringList;
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

function TWxTextEntryDialog.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxTextEntryDialog.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/textdlg.h>';
end;

function TWxTextEntryDialog.GenerateImageInclude: string;
begin

end;

function TWxTextEntryDialog.GetEventList: TStringList;
begin
  Result := nil;
end;

function TWxTextEntryDialog.GetIDName: string;
begin

end;

function TWxTextEntryDialog.GetIDValue: integer;
begin
  Result := 0;
end;

function TWxTextEntryDialog.GetParameterFromEventName(EventName: string): string;
begin

end;

function TWxTextEntryDialog.GetStretchFactor: integer;
begin
    Result := 1;
end;

function TWxTextEntryDialog.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxTextEntryDialog.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := [];
end;

procedure TWxTextEntryDialog.SetBorderAlignment(border: TWxBorderAlignment);
begin
end;

function TWxTextEntryDialog.GetBorderWidth: integer;
begin
  Result := 0;
end;

procedure TWxTextEntryDialog.SetBorderWidth(width: integer);
begin
end;

function TWxTextEntryDialog.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxTextEntryDialog.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxTextEntryDialog';
  Result := wx_Class;
end;

procedure TWxTextEntryDialog.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin

end;

procedure TWxTextEntryDialog.SetIDName(IDName: string);
begin

end;

procedure TWxTextEntryDialog.SetIDValue(IDValue: integer);
begin

end;

procedure TWxTextEntryDialog.SetStretchFactor(intValue: integer);
begin
end;

procedure TWxTextEntryDialog.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxTextEntryDialog.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxTextEntryDialog.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxTextEntryDialog.GetFGColor: string;
begin

end;

procedure TWxTextEntryDialog.SetFGColor(strValue: string);
begin
end;

function TWxTextEntryDialog.GetBGColor: string;
begin
end;

procedure TWxTextEntryDialog.SetBGColor(strValue: string);
begin
end;

procedure TWxTextEntryDialog.SetProxyFGColorString(Value: string);
begin
end;

procedure TWxTextEntryDialog.SetProxyBGColorString(Value: string);
begin
end;

{ Read method for property Wx_EditStyle }
function TWxTextEntryDialog.GetWx_EditStyle: TWxEdtGeneralStyleSet;
begin
  Result := FWx_EditStyle;
end;

{ Write method for property Wx_EditStyle }
procedure TWxTextEntryDialog.SetWx_EditStyle(Value: TWxEdtGeneralStyleSet);
begin
  FWx_EditStyle := GetRefinedWxEdtGeneralStyleValue(Value);
end;

end.
 