// $Id: wxFindReplaceDialog.pas 936 2007-05-15 03:47:39Z gururamnath $
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


Unit WxFindReplaceDialog;

Interface

Uses
    Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

Type
    TWxFindReplaceDialog = Class(TWxNonVisibleBaseComponent, IWxComponentInterface)
    Private
    { Private declarations }
        FWx_Class: String;
        FWx_PropertyList: TStringList;
        FWx_FindString: String;
        FWx_ReplaceString: String;
        FWx_Title: String;
        FWx_Flags: TWxFindReplaceFlagSet;
        FWx_Styles: TwxFindReplaceDialogStyleSet;

        FEVT_FIND: String;
        FEVT_FIND_NEXT: String;
        FEVT_FIND_REPLACE: String;
        FEVT_FIND_REPLACE_ALL: String;
        FEVT_FIND_CLOSE: String;
        FEVT_UPDATE_UI: String;
        FWx_EventList: TStringList;

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
        Property Wx_FindString: String Read FWx_FindString Write FWx_FindString;
        Property Wx_ReplaceString: String Read FWx_ReplaceString Write FWx_ReplaceString;
        Property Wx_Title: String Read FWx_Title Write FWx_Title;
        Property Wx_Flags: TWxFindReplaceFlagSet Read FWx_Flags Write FWx_Flags;
        Property Wx_Styles: TwxFindReplaceDialogStyleSet Read FWx_Styles Write FWx_Styles;

        Property EVT_FIND: String Read FEVT_FIND Write FEVT_FIND;
        Property EVT_FIND_NEXT: String Read FEVT_FIND_NEXT Write FEVT_FIND_NEXT;
        Property EVT_FIND_REPLACE: String Read FEVT_FIND_REPLACE Write FEVT_FIND_REPLACE;
        Property EVT_FIND_REPLACE_ALL: String Read FEVT_FIND_REPLACE_ALL Write FEVT_FIND_REPLACE_ALL;
        Property EVT_FIND_CLOSE: String Read FEVT_FIND_CLOSE Write FEVT_FIND_CLOSE;
        Property EVT_UPDATE_UI: String Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
        Property Wx_EventList: TStringList Read FWx_EventList Write FWx_EventList;
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxFindReplaceDialog]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxFindReplaceDialog.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Class := 'wxFindReplaceDialog';
    Glyph.Handle := LoadBitmap(hInstance, 'TWxFindReplaceDialog');
    FWx_EventList := TStringList.Create;

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxFindReplaceDialog.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    Glyph.Assign(Nil);
    FWx_EventList.Destroy;
End; { of AutoDestroy }

Constructor TWxFindReplaceDialog.Create(AOwner: TComponent);
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
    FWx_PropertyList.add('Wx_Flags:Flags');
    FWx_PropertyList.add('Wx_Styles:Styles');

    FWx_PropertyList.add('wxFR_DOWN:wxFR_DOWN');
    FWx_PropertyList.add('wxFR_WHOLEWORD:wxFR_WHOLEWORD');
    FWx_PropertyList.add('wxFR_MATCHCASE:wxFR_MATCHCASE');
    FWx_PropertyList.add('wxFR_REPLACEDIALOG:wxFR_REPLACEDIALOG');
    FWx_PropertyList.add('wxFR_NOUPDOWN:wxFR_NOUPDOWN');
    FWx_PropertyList.add('wxFR_NOMATCHCASE:wxFR_NOMATCHCASE');
    FWx_PropertyList.add('wxFR_NOWHOLEWORD:wxFR_NOWHOLEWORD');

    FWx_PropertyList.add('Wx_Message:Message');
    FWx_PropertyList.add('Name:Name');
    FWx_PropertyList.add('Wx_Class:Base Class');
    FWx_PropertyList.add('Wx_Title:Title');

    FWx_PropertyList.add('Wx_FindString:FindString');
    FWx_PropertyList.add('Wx_ReplaceString:ReplaceString');

    FWx_EventList.add('EVT_FIND:OnFind');
    FWx_EventList.add('EVT_FIND_NEXT:OnFindNext');
    FWx_EventList.add('EVT_FIND_REPLACE:OnReplace');
    FWx_EventList.add('EVT_FIND_REPLACE_ALL:OnReplaceAll');
    FWx_EventList.add('EVT_FIND_CLOSE:OnClose');
    FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');


End;

Destructor TWxFindReplaceDialog.Destroy;
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

Function TWxFindReplaceDialog.GenerateControlIDs: String;
Begin
    Result := '';
End;

Function TWxFindReplaceDialog.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxFindReplaceDialog.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';

    If (XRCGEN) Then
    Begin
        If trim(EVT_FIND) <> '' Then
            Result := Result + #13 + Format('EVT_FIND(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
                EVT_FIND]) + '';

        If trim(EVT_FIND_NEXT) <> '' Then
            Result := Result + #13 + Format('EVT_FIND_NEXT(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
                EVT_FIND_NEXT]) + '';

        If trim(EVT_FIND_REPLACE) <> '' Then
            Result := Result + #13 + Format('EVT_FIND_REPLACE(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
                EVT_FIND_REPLACE]) + '';

        If trim(EVT_FIND_REPLACE_ALL) <> '' Then
            Result := Result + #13 + Format('EVT_FIND_REPLACE_ALL(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
                EVT_FIND_REPLACE_ALL]) + '';

        If trim(EVT_FIND_CLOSE) <> '' Then
            Result := Result + #13 + Format('EVT_FIND_CLOSE(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
                EVT_FIND_CLOSE]) + '';

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';

    End
    Else
    Begin
        If trim(EVT_FIND) <> '' Then
            Result := Result + #13 + Format('EVT_FIND(wxID_ANY,%s::%s)', [CurrClassName,
                EVT_FIND]) + '';

        If trim(EVT_FIND_NEXT) <> '' Then
            Result := Result + #13 + Format('EVT_FIND_NEXT(wxID_ANY,%s::%s)', [CurrClassName,
                EVT_FIND_NEXT]) + '';

        If trim(EVT_FIND_REPLACE) <> '' Then
            Result := Result + #13 + Format('EVT_FIND_REPLACE(wxID_ANY,%s::%s)', [CurrClassName,
                EVT_FIND_REPLACE]) + '';

        If trim(EVT_FIND_REPLACE_ALL) <> '' Then
            Result := Result + #13 + Format('EVT_FIND_REPLACE_ALL(wxID_ANY,%s::%s)', [CurrClassName,
                EVT_FIND_REPLACE_ALL]) + '';

        If trim(EVT_FIND_CLOSE) <> '' Then
            Result := Result + #13 + Format('EVT_FIND_CLOSE(wxID_ANY,%s::%s)', [CurrClassName,
                EVT_FIND_CLOSE]) + '';

{
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
}
    End;

End;

Function TWxFindReplaceDialog.GenerateXRCControlCreation(IndentString: String):
TStringList;
Begin

    Result := TStringList.Create;

    Try
        Result.Add(Format('<object class="%s" name="%s">', [self.Wx_Class, self.Name]));
        Result.Add('</object>');
    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxFindReplaceDialog.GenerateGUIControlCreation: String;
Var
    strFlag, strStyle: String;

Begin
    Result := '';
    strFlag := GetFindReplaceFlagString(Wx_Flags);
    If strFlag = '' Then
        strFlag := '0';
    Result := self.Name + '_Data = new wxFindReplaceData(' + strFlag + ');';
    Result := Result + #13 + self.Name + '_Data->SetFindString(' + GetCppString(
        Wx_FindString) + ');';
    Result := Result + #13 + self.Name + '_Data->SetReplaceString(' + GetCppString(
        Wx_ReplaceString) + ');';

    strStyle := GetFindReplaceDialogStyleString(Wx_Styles);
    If strStyle = '' Then
        strStyle := ',0';

    Result := Result + #13 + Format('%s =  new %s(this, %s, %s %s);',
        [self.Name, self.wx_Class, self.Name + '_Data', GetCppString(Wx_Title), strStyle]);

End;

Function TWxFindReplaceDialog.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
    Result := Result + #13 + Format('wxFindReplaceData *%s_Data;', [trim(Self.Name)]);
End;

Function TWxFindReplaceDialog.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/fdrepdlg.h>';
End;

Function TWxFindReplaceDialog.GenerateImageInclude: String;
Begin

End;

Function TWxFindReplaceDialog.GetEventList: TStringList;
Begin
    Result := Wx_EventList;
End;

Function TWxFindReplaceDialog.GetIDName: String;
Begin

End;

Function TWxFindReplaceDialog.GetIDValue: Integer;
Begin
    Result := 0;
End;

Function TWxFindReplaceDialog.GetParameterFromEventName(EventName: String): String;
Begin

    If EventName = 'EVT_FIND' Then
    Begin
        Result := 'wxFindDialogEvent& event';
        exit;
    End;
    If EventName = 'EVT_FIND_NEXT' Then
    Begin
        Result := 'wxFindDialogEvent& event';
        exit;
    End;
    If EventName = 'EVT_FIND_REPLACE' Then
    Begin
        Result := 'wxFindDialogEvent& event';
        exit;
    End;
    If EventName = 'EVT_FIND_REPLACE_ALL' Then
    Begin
        Result := 'wxFindDialogEvent& event';
        exit;
    End;
    If EventName = 'EVT_FIND_CLOSE' Then
    Begin
        Result := 'wxFindDialogEvent& event';
        exit;
    End;
    If EventName = 'EVT_UPDATE_UI' Then
    Begin
        Result := 'wxUpdateUIEvent& event';
        exit;
    End;

End;

Function TWxFindReplaceDialog.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxFindReplaceDialog.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxFindReplaceDialog.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxFindReplaceDialog.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxFindReplaceDialog.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxFindReplaceDialog.SetBorderWidth(width: Integer);
Begin
End;

Function TWxFindReplaceDialog.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxFindReplaceDialog.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxFindReplaceDialog';
    Result := wx_Class;
End;

Procedure TWxFindReplaceDialog.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin

End;

Procedure TWxFindReplaceDialog.SetIDName(IDName: String);
Begin

End;

Procedure TWxFindReplaceDialog.SetIDValue(IDValue: Integer);
Begin

End;

Procedure TWxFindReplaceDialog.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxFindReplaceDialog.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxFindReplaceDialog.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxFindReplaceDialog.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxFindReplaceDialog.GetFGColor: String;
Begin

End;

Procedure TWxFindReplaceDialog.SetFGColor(strValue: String);
Begin
End;

Function TWxFindReplaceDialog.GetBGColor: String;
Begin
End;

Procedure TWxFindReplaceDialog.SetBGColor(strValue: String);
Begin
End;

Procedure TWxFindReplaceDialog.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxFindReplaceDialog.SetProxyBGColorString(Value: String);
Begin
End;

End.
