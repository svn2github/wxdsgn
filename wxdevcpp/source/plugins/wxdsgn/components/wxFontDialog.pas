// $Id: wxFontDialog.pas 936 2007-05-15 03:47:39Z gururamnath $
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


Unit WxFontDialog;

Interface

Uses
    Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

Type
    TWxFontDialog = Class(TWxNonVisibleBaseComponent, IWxComponentInterface)
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
    RegisterComponents('wxWidgets', [TWxFontDialog]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxFontDialog.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Class := 'wxFontDialog';
    Glyph.Handle := LoadBitmap(hInstance, 'TWxFontDialog');
End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxFontDialog.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    Glyph.Assign(Nil);
End; { of AutoDestroy }

Constructor TWxFontDialog.Create(AOwner: TComponent);
Begin
  { Call the Create method of the container's parent class       }
    Inherited Create(AOwner);

    AutoInitialize;

    FWx_PropertyList.add('Name:Name');
    FWx_PropertyList.add('Wx_Class:Base Class');
End;

Destructor TWxFontDialog.Destroy;
Begin
    AutoDestroy;
    Inherited Destroy;
End;

Function TWxFontDialog.GenerateControlIDs: String;
Begin
    Result := '';
End;

Function TWxFontDialog.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxFontDialog.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxFontDialog.GenerateXRCControlCreation(IndentString: String): TStringList;
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

Function TWxFontDialog.GenerateGUIControlCreation: String;
Begin
    Result := '';
    Result := Format('%s =  new %s(this);', [self.Name, self.wx_Class]);
End;

Function TWxFontDialog.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxFontDialog.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/fontdlg.h>';
End;

Function TWxFontDialog.GenerateImageInclude: String;
Begin

End;

Function TWxFontDialog.GetEventList: TStringList;
Begin
    Result := Nil;
End;

Function TWxFontDialog.GetIDName: String;
Begin

End;

Function TWxFontDialog.GetIDValue: Integer;
Begin
    Result := 0;
End;

Function TWxFontDialog.GetParameterFromEventName(EventName: String): String;
Begin

End;

Function TWxFontDialog.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxFontDialog.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxFontDialog.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxFontDialog.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxFontDialog.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxFontDialog.SetBorderWidth(width: Integer);
Begin
End;

Function TWxFontDialog.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxFontDialog.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxFontDialog';
    Result := wx_Class;
End;

Procedure TWxFontDialog.SaveControlOrientation(ControlOrientation:
    TWxControlOrientation);
Begin

End;

Procedure TWxFontDialog.SetIDName(IDName: String);
Begin

End;

Procedure TWxFontDialog.SetIDValue(IDValue: Integer);
Begin

End;

Procedure TWxFontDialog.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxFontDialog.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxFontDialog.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxFontDialog.SetGenericColor(strVariableName, strValue: String);
Begin

End;


Function TWxFontDialog.GetFGColor: String;
Begin

End;

Procedure TWxFontDialog.SetFGColor(strValue: String);
Begin
End;

Function TWxFontDialog.GetBGColor: String;
Begin
End;

Procedure TWxFontDialog.SetBGColor(strValue: String);
Begin
End;

Procedure TWxFontDialog.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxFontDialog.SetProxyBGColorString(Value: String);
Begin
End;

End.
