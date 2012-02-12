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

Unit WxTimer;

Interface

Uses
    Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

Type
    TWxTimer = Class(TWxNonVisibleBaseComponent, IWxComponentInterface)
    Private
    { Private declarations }
        FWx_Class: String;
        FWx_PropertyList: TStringList;
        FWx_EventList: TStringList;
        FWx_IDName: String;
        FWx_IDValue: Integer;
        FWx_Interval: Integer;
        FWx_AutoStart: Boolean;
        FWx_Comments: TStrings;

        FEVT_TIMER: String;

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
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue;
        Property Wx_Interval: Integer Read FWx_Interval Write FWx_Interval;
        Property Wx_AutoStart: Boolean Read FWx_AutoStart Write FWx_AutoStart;
        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

        Property EVT_TIMER: String Read FEVT_TIMER Write FEVT_TIMER;

    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxTimer]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxTimer.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_EventList := TStringList.Create;
    FWx_Class := 'wxTimer';
    Glyph.Handle := LoadBitmap(hInstance, 'TWxTimer');
    FWx_Interval := 100;
    FWx_AutoStart := False;
    FWx_Comments := TStringList.Create;

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxTimer.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_EventList.Destroy;
    FWx_Comments.Destroy;
    Glyph.Assign(Nil);
End; { of AutoDestroy }

Constructor TWxTimer.Create(AOwner: TComponent);
Begin
  { Call the Create method of the container's parent class       }
    Inherited Create(AOwner);

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

End;

Destructor TWxTimer.Destroy;
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

Function TWxTimer.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxTimer.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
End;

Function TWxTimer.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
    If trim(EVT_TIMER) <> '' Then
        Result := Format('EVT_TIMER(%s,%s::%s)', [WX_IDName, CurrClassName, EVT_TIMER]) + '';
End;

Function TWxTimer.GenerateXRCControlCreation(IndentString: String): TStringList;
Begin

    Result := TStringList.Create;

    Try
        Result.Add(IndentString + Format('<object class="%s" name="%s">',
            [self.Wx_Class, self.Name]));
        Result.Add(IndentString + Format('  <interval>%d</interval>', [self.Wx_Interval]));
        Result.Add(IndentString + '</object>');
    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxTimer.GenerateGUIControlCreation: String;
Begin
    Result := '';
    Result := GetCommentString(self.FWx_Comments.Text) +
        Format('%s = new %s();', [self.Name, self.wx_Class]);
    Result := Result + #13 + Format('%s->SetOwner(this, %s);', [self.Name, Wx_IDName]);

    If Wx_AutoStart = True Then
        Result := Result + #13 + Format('%s->Start(%d);', [self.Name, self.Wx_Interval]);

End;

Function TWxTimer.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxTimer.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/timer.h>';
End;

Function TWxTimer.GenerateImageInclude: String;
Begin

End;

Function TWxTimer.GetEventList: TStringList;
Begin
    Result := FWx_EventList;
End;

Function TWxTimer.GetIDName: String;
Begin
    Result := wx_IDName;
End;

Function TWxTimer.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxTimer.GetParameterFromEventName(EventName: String): String;
Begin
    Result := '';
    If EventName = 'EVT_TIMER' Then
    Begin
        Result := 'wxTimerEvent& event';
        exit;
    End;
End;

Function TWxTimer.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxTimer.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxTimer.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxTimer.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxTimer.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxTimer.SetBorderWidth(width: Integer);
Begin
End;

Function TWxTimer.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxTimer.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxTimer';
    Result := wx_Class;
End;

Procedure TWxTimer.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin

End;

Procedure TWxTimer.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxTimer.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxTimer.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxTimer.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxTimer.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxTimer.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxTimer.GetFGColor: String;
Begin

End;

Procedure TWxTimer.SetFGColor(strValue: String);
Begin
End;

Function TWxTimer.GetBGColor: String;
Begin
End;

Procedure TWxTimer.SetBGColor(strValue: String);
Begin
End;

Procedure TWxTimer.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxTimer.SetProxyBGColorString(Value: String);
Begin

End;

End.
 