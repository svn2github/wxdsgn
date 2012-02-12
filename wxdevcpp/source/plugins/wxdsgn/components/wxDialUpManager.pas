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


Unit wxDialUpManager;

Interface

Uses
    Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

Type
    TWxDialUpManager = Class(TWxNonVisibleBaseComponent, IWxComponentInterface)
    Private
    { Private declarations }
        FWx_Class: String;
        FWx_PropertyList: TStringList;
        FWx_EventList: TStringList;
        FWx_Comments: TStrings;
        FEVT_DIALUP_CONNECTED: String;
        FEVT_DIALUP_DISCONNECTED: String;

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
        Procedure SetProxyFGColorString(Value: String);
        Procedure SetProxyBGColorString(Value: String);

        Function GetGenericColor(strVariableName: String): String;
        Procedure SetGenericColor(strVariableName, strValue: String);

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

    Published
    { Published declarations }
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
        Property EVT_DIALUP_CONNECTED: String Read FEVT_DIALUP_CONNECTED Write FEVT_DIALUP_CONNECTED;
        Property EVT_DIALUP_DISCONNECTED: String Read FEVT_DIALUP_DISCONNECTED Write FEVT_DIALUP_DISCONNECTED;
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxDialUpManager]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxDialUpManager.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_EventList := TStringList.Create;
    FWx_Class := 'wxDialUpManager';
    FWx_Comments := TStringList.Create;
    Glyph.Handle := LoadBitmap(hInstance, 'TWxDialUpManager');
End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxDialUpManager.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_EventList.Destroy;
    FWx_Comments.Destroy;
    Glyph.Assign(Nil);
End; { of AutoDestroy }

Constructor TWxDialUpManager.Create(AOwner: TComponent);
Begin
  { Call the Create method of the container's parent class       }
    Inherited Create(AOwner);

  { AutoInitialize method is generated by Component Create.      }
    AutoInitialize;

  { Code to perform other tasks when the component is created }
  { Code to perform other tasks when the component is created }
    FWx_PropertyList.add('Name:Name');
    FWx_PropertyList.add('Wx_Class:Base Class');
    FWx_PropertyList.add('Wx_Comments:Comments');
    FWx_EventList.add('EVT_DIALUP_CONNECTED:OnDialupConnected');
    FWx_EventList.add('EVT_DIALUP_DISCONNECTED:OnDialupDisConnected');
End;

Destructor TWxDialUpManager.Destroy;
Begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
    AutoDestroy;

  { Here, free any other dynamic objects that the component methods  }
  { created but have not yet freed.  Also perform any other clean-up }
  { operations needed before the component is destroyed.             }

  { Last, free the component by calling the Destroy method of the    }
  { parent class.                                                    }
    Inherited Destroy;
End;

Function TWxDialUpManager.GenerateControlIDs: String;
Begin
    Result := '';
End;

Function TWxDialUpManager.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxDialUpManager.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';

    If trim(EVT_DIALUP_CONNECTED) <> '' Then
        Result := Format('EVT_DIALUP_CONNECTED(%s::%s)',
            [CurrClassName, EVT_DIALUP_CONNECTED]) + '';

    If trim(EVT_DIALUP_DISCONNECTED) <> '' Then
        Result := Result + #13 + Format('EVT_DIALUP_DISCONNECTED(%s::%s)',
            [CurrClassName, EVT_DIALUP_DISCONNECTED]) + '';

End;

Function TWxDialUpManager.GenerateXRCControlCreation(IndentString: String): TStringList;
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

Function TWxDialUpManager.GenerateGUIControlCreation: String;
Begin

    Result := '';
    Result := GetCommentString(self.FWx_Comments.Text);

    Result := Result + #13 + Format('%s =  %s::Create();',
        [self.Name, self.wx_Class]);

End;

Function TWxDialUpManager.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxDialUpManager.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/dialup.h>';
End;

Function TWxDialUpManager.GenerateImageInclude: String;
Begin

End;

Function TWxDialUpManager.GetEventList: TStringList;
Begin
    Result := FWx_EventList;
End;

Function TWxDialUpManager.GetIDName: String;
Begin

End;

Function TWxDialUpManager.GetIDValue: Integer;
Begin
    Result := 0;
End;

Function TWxDialUpManager.GetParameterFromEventName(EventName: String): String;
Begin
    If EventName = 'EVT_DIALUP_CONNECTED' Then
    Begin
        Result := 'wxDialUpEvent& event';
        exit;
    End;
    If EventName = 'EVT_DIALUP_DISCONNECTED' Then
    Begin
        Result := 'wxDialUpEvent& event';
        exit;
    End;
End;

Function TWxDialUpManager.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxDialUpManager.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxDialUpManager.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxDialUpManager.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxDialUpManager.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxDialUpManager.SetBorderWidth(width: Integer);
Begin
End;

Function TWxDialUpManager.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxDialUpManager.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxDialUpManager';
    Result := wx_Class;
End;

Procedure TWxDialUpManager.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin

End;

Procedure TWxDialUpManager.SetIDName(IDName: String);
Begin

End;

Procedure TWxDialUpManager.SetIDValue(IDValue: Integer);
Begin

End;

Procedure TWxDialUpManager.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxDialUpManager.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxDialUpManager.GetFGColor: String;
Begin

End;

Procedure TWxDialUpManager.SetFGColor(strValue: String);
Begin
End;

Function TWxDialUpManager.GetBGColor: String;
Begin
End;

Procedure TWxDialUpManager.SetBGColor(strValue: String);
Begin
End;

Procedure TWxDialUpManager.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxDialUpManager.SetProxyBGColorString(Value: String);
Begin
End;

Function TWxDialUpManager.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxDialUpManager.SetGenericColor(strVariableName, strValue: String);
Begin

End;

End.
 