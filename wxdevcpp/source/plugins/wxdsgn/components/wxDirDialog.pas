// $Id: wxDirDialog.pas 936 2007-05-15 03:47:39Z gururamnath $
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


Unit WxDirDialog;

Interface

Uses
    Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

Type
    TWxDirDialog = Class(TWxNonVisibleBaseComponent, IWxComponentInterface)
    Private
    { Private declarations }
        FWx_Class: String;
        FWx_Comments: TStrings;
        FWx_PropertyList: TStringList;
        FWx_Message: String;
        FWx_DefaultDir: String;
        FWx_DirDialogStyle: TWxDirDialogStyleSet;
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
        Property Wx_Message: String Read FWx_Message Write FWx_Message;
        Property Wx_DefaultDir: String Read FWx_DefaultDir Write FWx_DefaultDir;
        Property Wx_DirDialogStyle: TWxDirDialogStyleSet
            Read FWx_DirDialogStyle Write FWx_DirDialogStyle;
        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxDirDialog]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxDirDialog.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Class := 'wxDirDialog';
    FWx_Message := 'Choose a directory';
    Glyph.Handle := LoadBitmap(hInstance, 'TWxDirDialog');
    FWx_Comments := TStringList.Create;

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxDirDialog.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_Comments.Destroy;
    Glyph.Assign(Nil);
End; { of AutoDestroy }

Constructor TWxDirDialog.Create(AOwner: TComponent);
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
    FWx_PropertyList.add('Wx_DirDialogStyle:Dir Dialog Style');
    FWx_PropertyList.add('wxDD_NEW_DIR_BUTTON:wxDD_NEW_DIR_BUTTON');

    FWx_PropertyList.add('Wx_DefaultDir:Default Dir');
    FWx_PropertyList.add('Wx_Message:Message');
    FWx_PropertyList.add('Name:Name');
    FWx_PropertyList.add('Wx_Class:Base Class');
    FWx_PropertyList.add('Wx_Comments:Comments');

End;

Destructor TWxDirDialog.Destroy;
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

Function TWxDirDialog.GenerateControlIDs: String;
Begin
    Result := '';
End;


Function TWxDirDialog.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxDirDialog.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxDirDialog.GenerateXRCControlCreation(IndentString: String): TStringList;
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

Function TWxDirDialog.GenerateGUIControlCreation: String;
Var
    strStyle: String;
Begin
    Result := '';
    strStyle := GetDirDialogStyleString(self.Wx_DirDialogStyle);
    Result := GetCommentString(self.FWx_Comments.Text) +
        Format('%s =  new %s(this, %s, %s%s);', [self.Name, self.wx_Class,
        GetCppString(wx_Message), GetCppString(wx_DefaultDir), strStyle]);
End;

Function TWxDirDialog.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxDirDialog.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/dirdlg.h>';
End;

Function TWxDirDialog.GenerateImageInclude: String;
Begin

End;

Function TWxDirDialog.GetEventList: TStringList;
Begin
    Result := Nil;
End;

Function TWxDirDialog.GetIDName: String;
Begin

End;

Function TWxDirDialog.GetIDValue: Integer;
Begin
    Result := 0;
End;

Function TWxDirDialog.GetParameterFromEventName(EventName: String): String;
Begin

End;

Function TWxDirDialog.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxDirDialog.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxDirDialog.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxDirDialog.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxDirDialog.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxDirDialog.SetBorderWidth(width: Integer);
Begin
End;

Function TWxDirDialog.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxDirDialog.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxDirDialog';
    Result := wx_Class;
End;

Procedure TWxDirDialog.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin

End;

Procedure TWxDirDialog.SetIDName(IDName: String);
Begin

End;

Procedure TWxDirDialog.SetIDValue(IDValue: Integer);
Begin

End;

Procedure TWxDirDialog.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxDirDialog.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxDirDialog.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxDirDialog.SetGenericColor(strVariableName, strValue: String);
Begin

End;


Function TWxDirDialog.GetFGColor: String;
Begin

End;

Procedure TWxDirDialog.SetFGColor(strValue: String);
Begin
End;

Function TWxDirDialog.GetBGColor: String;
Begin
End;

Procedure TWxDirDialog.SetBGColor(strValue: String);
Begin
End;

Procedure TWxDirDialog.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxDirDialog.SetProxyBGColorString(Value: String);
Begin
End;

End.
 