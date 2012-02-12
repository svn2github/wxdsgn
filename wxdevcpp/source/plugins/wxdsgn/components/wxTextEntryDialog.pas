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

Unit wxTextEntryDialog;

Interface

Uses
    Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

Type
    TWxTextEntryDialog = Class(TWxNonVisibleBaseComponent, IWxComponentInterface)
    Private
    { Private declarations }
        FWx_Class: String;
        FWx_PropertyList: TStringList;
        FWx_DialogStyle: TWxMessageDialogStyleSet;
        FWx_EditStyle: TWxEdtGeneralStyleSet;
        FWx_Caption: String;
        FWx_Value: String;
        FWx_Message: String;
        FWx_Comments: TStrings;

        Procedure AutoInitialize;
        Procedure AutoDestroy;

    { Read method for property Wx_EditStyle }
        Function GetWx_EditStyle: TWxEdtGeneralStyleSet;
    { Write method for property Wx_EditStyle }
        Procedure SetWx_EditStyle(Value: TWxEdtGeneralStyleSet);

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
        Property Wx_Value: String Read FWx_Value Write FWx_Value;

        Property Wx_DialogStyle: TWxMessageDialogStyleSet Read FWx_DialogStyle Write FWx_DialogStyle;
        Property Wx_EditStyle: TWxEdtGeneralStyleSet
            Read GetWx_EditStyle Write SetWx_EditStyle;
        //Read FWx_EditStyle write FWx_EditStyle;
        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxTextEntryDialog]);
End;

Procedure TWxTextEntryDialog.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Class := 'wxTextEntryDialog';
    Glyph.Handle := LoadBitmap(hInstance, 'TWxMessageDialog');
    FWX_Caption := 'Please enter text';
    FWX_Value := '';
    FWx_DialogStyle := [wxOK, wxCANCEL, wxCENTRE];
    FWx_Comments := TStringList.Create;

End; { of AutoInitialize }

Procedure TWxTextEntryDialog.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_Comments.Destroy;
    Glyph.Assign(Nil);
End; { of AutoDestroy }

Constructor TWxTextEntryDialog.Create(AOwner: TComponent);
Begin
  { Call the Create method of the container's parent class       }
    Inherited Create(AOwner);

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

End;

Destructor TWxTextEntryDialog.Destroy;
Begin
    AutoDestroy;
    Inherited Destroy;
End;

Function TWxTextEntryDialog.GenerateControlIDs: String;
Begin
    Result := '';
End;

Function TWxTextEntryDialog.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxTextEntryDialog.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxTextEntryDialog.GenerateGUIControlCreation: String;
Var
	   parentName: String;
Begin
    Result := '';
    parentName := GetWxWidgetParent(self, False);
    Result := GetCommentString(self.FWx_Comments.Text) +
        Format('%s =  new %s( this,%s, %s, %s %s);',
        [self.Name, self.wx_Class, GetCppString(self.Wx_Message), GetCppString(self.Wx_Caption),
        GetCppString(self.Wx_Value), GetTextEntryDialogStyleString(Wx_DialogStyle, Wx_EditStyle)]);

End;

Function TWxTextEntryDialog.GenerateXRCControlCreation(IndentString: String): TStringList;
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

Function TWxTextEntryDialog.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxTextEntryDialog.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/textdlg.h>';
End;

Function TWxTextEntryDialog.GenerateImageInclude: String;
Begin

End;

Function TWxTextEntryDialog.GetEventList: TStringList;
Begin
    Result := Nil;
End;

Function TWxTextEntryDialog.GetIDName: String;
Begin

End;

Function TWxTextEntryDialog.GetIDValue: Integer;
Begin
    Result := 0;
End;

Function TWxTextEntryDialog.GetParameterFromEventName(EventName: String): String;
Begin

End;

Function TWxTextEntryDialog.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxTextEntryDialog.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxTextEntryDialog.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxTextEntryDialog.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxTextEntryDialog.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxTextEntryDialog.SetBorderWidth(width: Integer);
Begin
End;

Function TWxTextEntryDialog.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxTextEntryDialog.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxTextEntryDialog';
    Result := wx_Class;
End;

Procedure TWxTextEntryDialog.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin

End;

Procedure TWxTextEntryDialog.SetIDName(IDName: String);
Begin

End;

Procedure TWxTextEntryDialog.SetIDValue(IDValue: Integer);
Begin

End;

Procedure TWxTextEntryDialog.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxTextEntryDialog.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxTextEntryDialog.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxTextEntryDialog.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxTextEntryDialog.GetFGColor: String;
Begin

End;

Procedure TWxTextEntryDialog.SetFGColor(strValue: String);
Begin
End;

Function TWxTextEntryDialog.GetBGColor: String;
Begin
End;

Procedure TWxTextEntryDialog.SetBGColor(strValue: String);
Begin
End;

Procedure TWxTextEntryDialog.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxTextEntryDialog.SetProxyBGColorString(Value: String);
Begin
End;

{ Read method for property Wx_EditStyle }
Function TWxTextEntryDialog.GetWx_EditStyle: TWxEdtGeneralStyleSet;
Begin
    Result := FWx_EditStyle;
End;

{ Write method for property Wx_EditStyle }
Procedure TWxTextEntryDialog.SetWx_EditStyle(Value: TWxEdtGeneralStyleSet);
Begin
    FWx_EditStyle := GetRefinedWxEdtGeneralStyleValue(Value);
End;

End.
 