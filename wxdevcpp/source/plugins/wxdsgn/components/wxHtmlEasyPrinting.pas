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


Unit wxHtmlEasyPrinting;

Interface

Uses
    Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

Type
    TWxHtmlEasyPrinting = Class(TWxNonVisibleBaseComponent, IWxComponentInterface)
    Private
    { Private declarations }
        FWx_Class: String;
        FWx_PropertyList: TStringList;
        FWx_EventList: TStringList;
        FWx_FooterString: String;
        FWx_FooterPage: Integer;
        FWx_HeaderString: String;
        FWx_HeaderPage: Integer;
        FWx_Title: String;
        FWx_Comments: TStrings;


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
        Property Wx_FooterString: String Read FWx_FooterString Write FWx_FooterString;
        Property Wx_FooterPage: Integer Read FWx_FooterPage Write FWx_FooterPage;
        Property Wx_HeaderString: String Read FWx_HeaderString Write FWx_HeaderString;
        Property Wx_HeaderPage: Integer Read FWx_HeaderPage Write FWx_HeaderPage;
        Property Wx_Title: String Read FWx_Title Write FWx_Title;
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxHtmlEasyPrinting]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxHtmlEasyPrinting.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_EventList := TStringList.Create;
    FWx_Class := 'wxHtmlEasyPrinting';
    FWx_Comments := TStringList.Create;
    FWx_FooterPage := 0;
    FWx_HeaderPage := 0;
    Glyph.Handle := LoadBitmap(hInstance, 'TWxHtmlEasyPrinting');
End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxHtmlEasyPrinting.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_EventList.Destroy;
    FWx_Comments.Destroy;
    Glyph.Assign(Nil);
End; { of AutoDestroy }

Constructor TWxHtmlEasyPrinting.Create(AOwner: TComponent);
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

    FWx_PropertyList.add('Wx_FooterString:Footer String');
    FWx_PropertyList.add('Wx_FooterPage:Footer Page');
    FWx_PropertyList.add('Wx_HeaderString:Header String');
    FWx_PropertyList.add('Wx_HeaderPage:Header Page');
    FWx_PropertyList.add('Wx_Title:Title');

End;

Destructor TWxHtmlEasyPrinting.Destroy;
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

Function TWxHtmlEasyPrinting.GenerateControlIDs: String;
Begin
    Result := '';
End;

Function TWxHtmlEasyPrinting.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxHtmlEasyPrinting.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxHtmlEasyPrinting.GenerateXRCControlCreation(IndentString: String): TStringList;
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

Function TWxHtmlEasyPrinting.GenerateGUIControlCreation: String;
Begin

    Result := '';
    Result := GetCommentString(self.FWx_Comments.Text);

    Result := Result + #13 + Format('%s =  new %s(%s,this);',
        [self.Name, Wx_Class, GetCppString(self.wx_Title)]);

    If trim(wx_HeaderString) <> '' Then
	       Result := Result + #13 + Format('%s->SetHeader(%s,%d);', [self.Name, GetCppString(self.wx_HeaderString), wx_HeaderPage]);
    If trim(wx_FooterString) <> '' Then
	       Result := Result + #13 + Format('%s->SetFooter(%s,%d);', [self.Name, GetCppString(self.wx_FooterString), wx_FooterPage]);

End;

Function TWxHtmlEasyPrinting.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxHtmlEasyPrinting.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/html/htmprint.h>';
End;

Function TWxHtmlEasyPrinting.GenerateImageInclude: String;
Begin

End;

Function TWxHtmlEasyPrinting.GetEventList: TStringList;
Begin
    Result := Nil;
End;

Function TWxHtmlEasyPrinting.GetIDName: String;
Begin

End;

Function TWxHtmlEasyPrinting.GetIDValue: Integer;
Begin
    Result := 0;
End;

Function TWxHtmlEasyPrinting.GetParameterFromEventName(EventName: String): String;
Begin

End;

Function TWxHtmlEasyPrinting.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxHtmlEasyPrinting.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxHtmlEasyPrinting.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxHtmlEasyPrinting.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxHtmlEasyPrinting.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxHtmlEasyPrinting.SetBorderWidth(width: Integer);
Begin
End;

Function TWxHtmlEasyPrinting.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxHtmlEasyPrinting.GetWxClassName: String;
Begin
    If trim(Wx_Class) = '' Then
        Wx_Class := 'wxHtmlEasyPrinting';
    Result := Wx_Class;
End;

Procedure TWxHtmlEasyPrinting.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin

End;

Procedure TWxHtmlEasyPrinting.SetIDName(IDName: String);
Begin

End;

Procedure TWxHtmlEasyPrinting.SetIDValue(IDValue: Integer);
Begin

End;

Procedure TWxHtmlEasyPrinting.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxHtmlEasyPrinting.SetWxClassName(wxClassName: String);
Begin
    Wx_Class := wxClassName;
End;

Function TWxHtmlEasyPrinting.GetFGColor: String;
Begin

End;

Procedure TWxHtmlEasyPrinting.SetFGColor(strValue: String);
Begin
End;

Function TWxHtmlEasyPrinting.GetBGColor: String;
Begin
End;

Procedure TWxHtmlEasyPrinting.SetBGColor(strValue: String);
Begin
End;

Procedure TWxHtmlEasyPrinting.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxHtmlEasyPrinting.SetProxyBGColorString(Value: String);
Begin
End;

Function TWxHtmlEasyPrinting.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxHtmlEasyPrinting.SetGenericColor(strVariableName, strValue: String);
Begin

End;


End.
 