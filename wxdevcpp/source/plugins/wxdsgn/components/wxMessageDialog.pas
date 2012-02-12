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


Unit wxMessageDialog;

Interface

Uses
    Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

Type
    TWxMessageDialog = Class(TWxNonVisibleBaseComponent, IWxComponentInterface)
    Private
    { Private declarations }
        FWx_Class: String;
        FWx_PropertyList: TStringList;
        FWx_Message: String;
        FWx_Caption: String;
        FWx_Comments: TStrings;

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

    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxMessageDialog]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxMessageDialog.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Class := 'wxMessageDialog';
    Glyph.Handle := LoadBitmap(hInstance, 'TWxMessageDialog');
    FWx_Caption := 'Message box';
    FWx_Comments := TStringList.Create;

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxMessageDialog.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_Comments.Destroy;
    Glyph.Assign(Nil);
End; { of AutoDestroy }

Constructor TWxMessageDialog.Create(AOwner: TComponent);
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

End;

Destructor TWxMessageDialog.Destroy;
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

Function TWxMessageDialog.GenerateControlIDs: String;
Begin
    Result := '';
End;


Function TWxMessageDialog.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxMessageDialog.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxMessageDialog.GenerateXRCControlCreation(IndentString: String): TStringList;
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

Function TWxMessageDialog.GenerateGUIControlCreation: String;
Var
    strStyle: String;
Begin
    Result := '';
    strStyle := GetMessageDialogStyleString(self.Wx_DialogStyle, False);
    Result := GetCommentString(self.FWx_Comments.Text) +
        Format('%s =  new %s(this, %s, %s%s);', [self.Name, self.wx_Class,
        GetCppString(wx_Message), GetCppString(wx_Caption), strStyle]);
End;

Function TWxMessageDialog.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxMessageDialog.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/msgdlg.h>';
End;

Function TWxMessageDialog.GenerateImageInclude: String;
Begin

End;

Function TWxMessageDialog.GetEventList: TStringList;
Begin
    Result := Nil;
End;

Function TWxMessageDialog.GetIDName: String;
Begin

End;

Function TWxMessageDialog.GetIDValue: Integer;
Begin
    Result := 0;
End;

Function TWxMessageDialog.GetParameterFromEventName(EventName: String): String;
Begin

End;

Function TWxMessageDialog.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxMessageDialog.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxMessageDialog.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxMessageDialog.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxMessageDialog.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxMessageDialog.SetBorderWidth(width: Integer);
Begin
End;

Function TWxMessageDialog.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxMessageDialog.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxMessageDialog';
    Result := wx_Class;
End;

Procedure TWxMessageDialog.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin

End;

Procedure TWxMessageDialog.SetIDName(IDName: String);
Begin

End;

Procedure TWxMessageDialog.SetIDValue(IDValue: Integer);
Begin

End;

Procedure TWxMessageDialog.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxMessageDialog.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxMessageDialog.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxMessageDialog.SetGenericColor(strVariableName, strValue: String);
Begin

End;


Function TWxMessageDialog.GetFGColor: String;
Begin

End;

Procedure TWxMessageDialog.SetFGColor(strValue: String);
Begin
End;

Function TWxMessageDialog.GetBGColor: String;
Begin
End;

Procedure TWxMessageDialog.SetBGColor(strValue: String);
Begin
End;

Procedure TWxMessageDialog.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxMessageDialog.SetProxyBGColorString(Value: String);
Begin

End;

End.
 