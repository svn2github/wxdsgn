// $Id: WxSaveFileDialog.pas 936 2007-05-15 03:47:39Z gururamnath $
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


Unit WxSaveFileDialog;

Interface

Uses
    Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

Type
    TWxSaveFileDialog = Class(TWxNonVisibleBaseComponent, IWxComponentInterface)
    Private
    { Private declarations }
        FWx_Class: String;
        FWx_PropertyList: TStringList;
        FWx_Message: String;
        FWx_Extensions: String;
        FWx_DefaultFile: String;
        FWx_DefaultDir: String;
        FWx_DialogStyle: TWxFileDialogStyleSet;
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
        Property Wx_Extensions: String Read FWx_Extensions Write FWx_Extensions;
        Property Wx_DefaultFile: String Read FWx_DefaultFile Write FWx_DefaultFile;
        Property Wx_DefaultDir: String Read FWx_DefaultDir Write FWx_DefaultDir;
        Property Wx_DialogStyle: TWxFileDialogStyleSet
            Read FWx_DialogStyle Write FWx_DialogStyle;
        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxSaveFileDialog]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxSaveFileDialog.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Class := 'wxFileDialog';
    Glyph.Handle := LoadBitmap(hInstance, 'TWxSaveFileDialog');
    self.FWx_Extensions := '*.*';
    self.wx_Message := 'Choose a file';
    FWx_Comments := TStringList.Create;

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxSaveFileDialog.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_Comments.Destroy;
    Glyph.Assign(Nil);
End; { of AutoDestroy }

Constructor TWxSaveFileDialog.Create(AOwner: TComponent);
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
    FWx_PropertyList.add('Wx_DialogStyle:File Dialog Style');

 // FWx_PropertyList.add('wxHIDE_READONLY:wxHIDE_READONLY');
    FWx_PropertyList.add('wxOVERWRITE_PROMPT:wxOVERWRITE_PROMPT');
    FWx_PropertyList.add('wxCHANGE_DIR:wxCHANGE_DIR');

    FWx_PropertyList.add('Wx_DefaultDir:Default Dir');
    FWx_PropertyList.add('Wx_DefaultFile:Default File');
    FWx_PropertyList.add('Wx_Extensions:Extensions');
    FWx_PropertyList.add('Wx_Message:Message');
    FWx_PropertyList.add('Name:Name');
    FWx_PropertyList.add('Wx_Class:Base Class');
    FWx_PropertyList.add('Wx_Comments:Comments');

End;

Destructor TWxSaveFileDialog.Destroy;
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

Function TWxSaveFileDialog.GenerateControlIDs: String;
Begin
    Result := '';
End;

Function TWxSaveFileDialog.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxSaveFileDialog.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxSaveFileDialog.GenerateXRCControlCreation(IndentString: String): TStringList;
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

Function TWxSaveFileDialog.GenerateGUIControlCreation: String;
Var
    strType, strStyle: String;
Begin
    Result := '';
    strType := 'wxFD_SAVE';
    strStyle := GetFileDialogStyleString(self.Wx_DialogStyle);

    Result := GetCommentString(self.FWx_Comments.Text) +
        Format('%s =  new %s(this, %s, %s, %s, %s, %s);',
        [self.Name, self.wx_Class, GetCppString(wx_Message), GetCppString(
        wx_DefaultDir), GetCppString(wx_DefaultFile), GetCppString(wx_Extensions), strType + strStyle]);
End;

Function TWxSaveFileDialog.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxSaveFileDialog.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/filedlg.h>';
End;

Function TWxSaveFileDialog.GenerateImageInclude: String;
Begin

End;

Function TWxSaveFileDialog.GetEventList: TStringList;
Begin
    Result := Nil;
End;

Function TWxSaveFileDialog.GetIDName: String;
Begin

End;

Function TWxSaveFileDialog.GetIDValue: Integer;
Begin
    Result := 0;
End;

Function TWxSaveFileDialog.GetParameterFromEventName(EventName: String): String;
Begin

End;

Function TWxSaveFileDialog.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxSaveFileDialog.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxSaveFileDialog.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxSaveFileDialog.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxSaveFileDialog.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxSaveFileDialog.SetBorderWidth(width: Integer);
Begin
End;

Function TWxSaveFileDialog.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxSaveFileDialog.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxFileDialog';
    Result := wx_Class;
End;

Procedure TWxSaveFileDialog.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin

End;

Procedure TWxSaveFileDialog.SetIDName(IDName: String);
Begin

End;

Procedure TWxSaveFileDialog.SetIDValue(IDValue: Integer);
Begin

End;

Procedure TWxSaveFileDialog.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxSaveFileDialog.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxSaveFileDialog.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxSaveFileDialog.SetGenericColor(strVariableName, strValue: String);
Begin

End;


Function TWxSaveFileDialog.GetFGColor: String;
Begin

End;

Procedure TWxSaveFileDialog.SetFGColor(strValue: String);
Begin
End;

Function TWxSaveFileDialog.GetBGColor: String;
Begin
End;

Procedure TWxSaveFileDialog.SetBGColor(strValue: String);
Begin
End;

Procedure TWxSaveFileDialog.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxSaveFileDialog.SetProxyBGColorString(Value: String);
Begin
End;

End.
 