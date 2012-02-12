// $Id: wxProgressDialog.pas 936 2007-05-15 03:47:39Z gururamnath $
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


Unit wxProgressDialog;

Interface

Uses
    Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

Type
    TWxProgressDialog = Class(TWxNonVisibleBaseComponent, IWxComponentInterface)
    Private
    { Private declarations }
        FWx_Class: String;
        FWx_PropertyList: TStringList;
        FWx_ProgressDialogStyle: TWxProgressDialogStyleSet;
        FWx_Title: String;
        FWX_MAXValue: Integer;
        FWX_AutoShow: Boolean;
        FWx_Message: String;
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
        Property Wx_Title: String Read FWx_Title Write FWx_Title;
        Property WX_MAXValue: Integer Read FWX_MAXValue Write FWX_MAXValue Default 100;
        Property WX_AutoShow: Boolean Read FWX_AutoShow Write FWX_AutoShow Default False;

        Property Wx_ProgressDialogStyle: TWxProgressDialogStyleSet
            Read FWx_ProgressDialogStyle Write FWx_ProgressDialogStyle;
        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxProgressDialog]);
End;

Procedure TWxProgressDialog.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Class := 'wxProgressDialog';
    Glyph.Handle := LoadBitmap(hInstance, 'TWxProgressDialog');
    FWX_MAXValue := 100;
    FWX_AutoShow := False;
    FWx_ProgressDialogStyle := [wxPD_AUTO_HIDE, wxPD_APP_MODAL];
    FWx_Comments := TStringList.Create;

End; { of AutoInitialize }

Procedure TWxProgressDialog.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_Comments.Destroy;
    Glyph.Assign(Nil);
End; { of AutoDestroy }

Constructor TWxProgressDialog.Create(AOwner: TComponent);
Begin
  { Call the Create method of the container's parent class       }
    Inherited Create(AOwner);

    AutoInitialize;
  { Code to perform other tasks when the component is created }
    FWx_PropertyList.add('Wx_ProgressDialogStyle:Progress Dialog Style');
    FWx_PropertyList.add('wxPD_APP_MODAL:wxPD_APP_MODAL');
    FWx_PropertyList.add('wxPD_SMOOTH:wxPD_SMOOTH');
    FWx_PropertyList.add('wxPD_CAN_SKIP:wxPD_CAN_SKIP');
    FWx_PropertyList.add('wxPD_AUTO_HIDE:wxPD_AUTO_HIDE');
    FWx_PropertyList.add('wxPD_CAN_ABORT:wxPD_CAN_ABORT');
    FWx_PropertyList.add('wxPD_ELAPSED_TIME:wxPD_ELAPSED_TIME');
    FWx_PropertyList.add('wxPD_ESTIMATED_TIME:wxPD_ESTIMATED_TIME');
    FWx_PropertyList.add('wxPD_REMAINING_TIME:wxPD_REMAINING_TIME');
    FWx_PropertyList.add('Wx_Message:Message');
    FWx_PropertyList.add('Wx_Title:Title');
    FWx_PropertyList.add('WX_MAXValue:MAX Value');
    FWx_PropertyList.add('WX_AutoShow:Auto Show');
    FWx_PropertyList.add('Name:Name');
    FWx_PropertyList.add('Wx_Class:Base Class');
    FWx_PropertyList.add('Wx_Comments:Comments');

End;

Destructor TWxProgressDialog.Destroy;
Begin
    AutoDestroy;
    Inherited Destroy;
End;

Function TWxProgressDialog.GenerateControlIDs: String;
Begin
    Result := '';
End;

Function TWxProgressDialog.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxProgressDialog.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxProgressDialog.GenerateGUIControlCreation: String;
Begin
    Result := '';
    Result := GetCommentString(self.FWx_Comments.Text) +
        Format('%s =  new %s( %s, %s, %d , this  %s);',
        [self.Name, self.wx_Class, GetCppString(self.Wx_Title), GetCppString(self.Wx_Message),
        Wx_MaxValue, GetProgressDialogStyleString(Wx_ProgressDialogStyle)]);

    If Not WX_AutoShow Then
        Result := Result + #13 + self.Name + '->Show(false);';
End;

Function TWxProgressDialog.GenerateXRCControlCreation(IndentString: String): TStringList;
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

Function TWxProgressDialog.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxProgressDialog.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/progdlg.h>';
End;

Function TWxProgressDialog.GenerateImageInclude: String;
Begin

End;

Function TWxProgressDialog.GetEventList: TStringList;
Begin
    Result := Nil;
End;

Function TWxProgressDialog.GetIDName: String;
Begin

End;

Function TWxProgressDialog.GetIDValue: Integer;
Begin
    Result := 0;
End;

Function TWxProgressDialog.GetParameterFromEventName(EventName: String): String;
Begin

End;

Function TWxProgressDialog.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxProgressDialog.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxProgressDialog.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxProgressDialog.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxProgressDialog.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxProgressDialog.SetBorderWidth(width: Integer);
Begin
End;

Function TWxProgressDialog.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxProgressDialog.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxProgressDialog';
    Result := wx_Class;
End;

Procedure TWxProgressDialog.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin

End;

Procedure TWxProgressDialog.SetIDName(IDName: String);
Begin

End;

Procedure TWxProgressDialog.SetIDValue(IDValue: Integer);
Begin

End;

Procedure TWxProgressDialog.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxProgressDialog.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxProgressDialog.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxProgressDialog.SetGenericColor(strVariableName, strValue: String);
Begin

End;


Function TWxProgressDialog.GetFGColor: String;
Begin

End;

Procedure TWxProgressDialog.SetFGColor(strValue: String);
Begin
End;

Function TWxProgressDialog.GetBGColor: String;
Begin
End;

Procedure TWxProgressDialog.SetBGColor(strValue: String);
Begin
End;

Procedure TWxProgressDialog.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxProgressDialog.SetProxyBGColorString(Value: String);
Begin
End;

End.
 