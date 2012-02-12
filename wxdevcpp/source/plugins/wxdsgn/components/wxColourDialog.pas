// $Id: wxColourDialog.pas 936 2007-05-15 03:47:39Z gururamnath $
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


Unit WxColourDialog;

Interface

Uses
    Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

Type
    TWxColourDialog = Class(TWxNonVisibleBaseComponent, IWxComponentInterface)
    Private
    { Private declarations }
        FWx_Class: String;
        FWx_PropertyList: TStringList;
        Procedure AutoInitialize;
        Procedure AutoDestroy;

    Protected

    Public
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Function GenerateControlIDs: String;
        Function GenerateEnumControlIDs: String;
        Function GenerateEventTableEntries(CurrClassName: String): String;
        Function GenerateGUIControlCreation: String;
        Function GenerateXRCControlCreation(IndentString: String): TStringList;
        Function GenerateGUIControlDeclaration: String;
        Function GenerateHeaderInclude: String;
        Function GenerateImageInclude: String;
        Function GetEventList: TStringList;
        Function GetIDName: String;
        Function GetIDValue: Integer;
        Function GetParameterFromEventName(EventName: String): String;
        Function GetPropertyList: TStringList;
        Function GetTypeFromEventName(EventName: String): String;
        Function GetWxClassName: String;
        Procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
        Procedure SetIDName(IDName: String);
        Procedure SetIDValue(IDValue: Integer);
        Procedure SetWxClassName(wxClassName: String);
        Function GetFGColor: String;
        Procedure SetFGColor(strValue: String);
        Function GetBGColor: String;
        Procedure SetBGColor(strValue: String);
        Function GetGenericColor(strVariableName: String): String;
        Procedure SetGenericColor(strVariableName, strValue: String);

        Procedure SetProxyFGColorString(Value: String);
        Procedure SetProxyBGColorString(Value: String);

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

    Published
    { Published declarations }
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxColourDialog]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxColourDialog.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Class := 'wxColourDialog';
    Glyph.Handle := LoadBitmap(hInstance, 'TWxColourDialog');
End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxColourDialog.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    Glyph.Assign(Nil);
End; { of AutoDestroy }

Constructor TWxColourDialog.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);
    AutoInitialize;
    FWx_PropertyList.add('Name:Name');
    FWx_PropertyList.add('Wx_Class:Base Class');
End;

Destructor TWxColourDialog.Destroy;
Begin
    AutoDestroy;
    Inherited Destroy;
End;

Function TWxColourDialog.GenerateControlIDs: String;
Begin
    Result := '';
End;

Function TWxColourDialog.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxColourDialog.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxColourDialog.GenerateXRCControlCreation(IndentString: String): TStringList;
Begin

    Result := TStringList.Create;

    Try
        Result.Add(IndentString + Format('<object class="%s" name="%s">',
            [self.Wx_Class, self.Name]));
        Result.Add(IndentString + '</object>');
    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxColourDialog.GenerateGUIControlCreation: String;
Begin
    Result := '';
    Result := Format('%s =  new %s(this);', [self.Name, self.wx_Class]);
End;

Function TWxColourDialog.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxColourDialog.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/colordlg.h>';
End;

Function TWxColourDialog.GenerateImageInclude: String;
Begin

End;

Function TWxColourDialog.GetEventList: TStringList;
Begin
    Result := Nil;
End;

Function TWxColourDialog.GetIDName: String;
Begin

End;

Function TWxColourDialog.GetIDValue: Integer;
Begin
    Result := 0;
End;

Function TWxColourDialog.GetParameterFromEventName(EventName: String): String;
Begin

End;

Function TWxColourDialog.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxColourDialog.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxColourDialog.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxColourDialog.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxColourDialog.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxColourDialog.SetBorderWidth(width: Integer);
Begin
End;

Function TWxColourDialog.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxColourDialog.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxColourDialog';
    Result := wx_Class;
End;

Procedure TWxColourDialog.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin

End;

Procedure TWxColourDialog.SetIDName(IDName: String);
Begin

End;

Procedure TWxColourDialog.SetIDValue(IDValue: Integer);
Begin

End;

Procedure TWxColourDialog.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxColourDialog.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxColourDialog.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxColourDialog.SetGenericColor(strVariableName, strValue: String);
Begin

End;


Function TWxColourDialog.GetFGColor: String;
Begin

End;

Procedure TWxColourDialog.SetFGColor(strValue: String);
Begin
End;

Function TWxColourDialog.GetBGColor: String;
Begin
End;

Procedure TWxColourDialog.SetBGColor(strValue: String);
Begin
End;

Procedure TWxColourDialog.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxColourDialog.SetProxyBGColorString(Value: String);
Begin
End;

End.
 