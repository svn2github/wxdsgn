// $Id: wxSingleChoiceDialog.pas 936 2007-05-15 03:47:39Z gururamnath $
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


Unit wxSingleChoiceDialog;

Interface

Uses
    Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

Type
    TWxSingleChoiceDialog = Class(TWxNonVisibleBaseComponent, IWxComponentInterface)
    Private
    { Private declarations }
        FWx_Class: String;
        FWx_PropertyList: TStringList;
        FWx_Message: String;
        FWx_Caption: String;
        FWx_Comments: TStrings;
        FWx_ValueList: TStrings;

        FWx_DialogStyle: TWxMessageDialogStyleSet;
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
        Property Wx_Message: String Read FWx_Message Write FWx_Message;
        Property Wx_Caption: String Read FWx_Caption Write FWx_Caption;
        Property Wx_DialogStyle: TWxMessageDialogStyleSet
            Read FWx_DialogStyle Write FWx_DialogStyle;
        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
        Property Wx_ValueList: TStrings Read FWx_ValueList Write FWx_ValueList;

    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxSingleChoiceDialog]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxSingleChoiceDialog.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Class := 'wxSingleChoiceDialog';
    Glyph.Handle := LoadBitmap(hInstance, 'TwxSingleChoiceDialog');
    FWx_Caption := 'Single Choice List';
    FWx_Comments := TStringList.Create;
    FWx_ValueList := TStringList.Create;

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxSingleChoiceDialog.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_Comments.Destroy;
    FWx_ValueList.Destroy;
    Glyph.Assign(Nil);
End; { of AutoDestroy }

Constructor TWxSingleChoiceDialog.Create(AOwner: TComponent);
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
    FWx_PropertyList.add('Wx_DialogStyle:Message Dialog Style');

    FWx_PropertyList.add('wxOK:wxOK');
    FWx_PropertyList.add('wxCENTRE:wxCENTRE');
    FWx_PropertyList.add('wxCANCEL:wxCANCEL');
    FWx_PropertyList.add('wxYES_NO:wxYES_NO');
    FWx_PropertyList.add('wxYES_DEFAULT:wxYES_DEFAULT');
    FWx_PropertyList.add('wxNO_DEFAULT:wxNO_DEFAULT');

    FWx_PropertyList.add('Wx_ValueList:Items');

    FWx_PropertyList.add('Wx_Message:Message');
    FWx_PropertyList.add('Wx_Caption:Caption');
    FWx_PropertyList.add('Name:Name');
    FWx_PropertyList.add('Wx_Class:Base Class');
    FWx_PropertyList.add('Wx_Comments:Comments');

End;

Destructor TWxSingleChoiceDialog.Destroy;
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

Function TWxSingleChoiceDialog.GenerateControlIDs: String;
Begin
    Result := '';
End;


Function TWxSingleChoiceDialog.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxSingleChoiceDialog.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxSingleChoiceDialog.GenerateXRCControlCreation(IndentString: String): TStringList;
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

Function TWxSingleChoiceDialog.GenerateGUIControlCreation: String;
Var
    strStyle: String;
    i: Integer;
Begin
    Result := '';
    strStyle := GetMessageDialogStyleString(self.Wx_DialogStyle, False);

    Result := GetCommentString(self.FWx_Comments.Text) +
        'wxArrayString arrayStringFor_' + self.Name + ';';

    For i := 0 To self.Wx_ValueList.Count - 1 Do
        Result := Result + #13 + Format(
            '%s.Add(%s);', ['arrayStringFor_' + self.Name, GetCppString(self.Wx_ValueList[i])]);

    Result := Result + #13 + Format('%s =  new %s(this, %s, %s, %s,NULL%s);', [self.Name, self.wx_Class,
        GetCppString(wx_Message), GetCppString(wx_Caption), 'arrayStringFor_' + self.Name, strStyle]);

End;

Function TWxSingleChoiceDialog.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxSingleChoiceDialog.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/choicdlg.h>';
End;

Function TWxSingleChoiceDialog.GenerateImageInclude: String;
Begin

End;

Function TWxSingleChoiceDialog.GetEventList: TStringList;
Begin
    Result := Nil;
End;

Function TWxSingleChoiceDialog.GetIDName: String;
Begin

End;

Function TWxSingleChoiceDialog.GetIDValue: Integer;
Begin
    Result := 0;
End;

Function TWxSingleChoiceDialog.GetParameterFromEventName(EventName: String): String;
Begin

End;

Function TWxSingleChoiceDialog.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxSingleChoiceDialog.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxSingleChoiceDialog.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxSingleChoiceDialog.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxSingleChoiceDialog.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxSingleChoiceDialog.SetBorderWidth(width: Integer);
Begin
End;

Function TWxSingleChoiceDialog.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxSingleChoiceDialog.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxMessageDialog';
    Result := wx_Class;
End;

Procedure TWxSingleChoiceDialog.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin

End;

Procedure TWxSingleChoiceDialog.SetIDName(IDName: String);
Begin

End;

Procedure TWxSingleChoiceDialog.SetIDValue(IDValue: Integer);
Begin

End;

Procedure TWxSingleChoiceDialog.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxSingleChoiceDialog.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxSingleChoiceDialog.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxSingleChoiceDialog.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxSingleChoiceDialog.GetFGColor: String;
Begin

End;

Procedure TWxSingleChoiceDialog.SetFGColor(strValue: String);
Begin
End;

Function TWxSingleChoiceDialog.GetBGColor: String;
Begin
End;

Procedure TWxSingleChoiceDialog.SetBGColor(strValue: String);
Begin
End;

Procedure TWxSingleChoiceDialog.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxSingleChoiceDialog.SetProxyBGColorString(Value: String);
Begin

End;

End.
 