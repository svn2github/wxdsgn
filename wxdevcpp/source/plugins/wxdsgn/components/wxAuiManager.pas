// $Id$
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

Unit wxAuiManager;

Interface

Uses
    Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

Type
    TWxAuiManager = Class(TWxNonVisibleBaseComponent, IWxComponentInterface, IWxAuiManagerInterface)
    Private
    { Private declarations }
        FWx_Class: String;
        FWx_PropertyList: TStringList;
        FWx_Comments: TStrings;
        FWx_EventList: TStringList;
        FWx_AuiManagerStyle: TwxAuiManagerFlagSet;

        FEVT_AUI_PANE_BUTTON: String;
        FEVT_AUI_PANE_CLOSE: String;
        FEVT_AUI_PANE_MAXIMIZE: String;
        FEVT_AUI_PANE_RESTORE: String;
        FEVT_AUI_RENDER: String;
        FEVT_AUI_FIND_MANAGER: String;
        FEVT_UPDATE_UI: String;

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

        Function GetAuiManagerFlags(Wx_AuiManagerStyles: TwxAuiManagerFlagSet): String;

    Published
    { Published declarations }
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
        Property Wx_EventList: TStringList Read FWx_EventList Write FWx_EventList;
        Property Wx_AuiManagerStyle: TwxAuiManagerFlagSet Read FWx_AuiManagerStyle Write FWx_AuiManagerStyle;

        Property EVT_AUI_PANE_BUTTON: String Read FEVT_AUI_PANE_BUTTON Write FEVT_AUI_PANE_BUTTON;
        Property EVT_AUI_PANE_CLOSE: String Read FEVT_AUI_PANE_CLOSE Write FEVT_AUI_PANE_CLOSE;
        Property EVT_AUI_PANE_MAXIMIZE: String Read FEVT_AUI_PANE_MAXIMIZE Write FEVT_AUI_PANE_MAXIMIZE;
        Property EVT_AUI_PANE_RESTORE: String Read FEVT_AUI_PANE_RESTORE Write FEVT_AUI_PANE_RESTORE;
        Property EVT_AUI_RENDER: String Read FEVT_AUI_RENDER Write FEVT_AUI_RENDER;
        Property EVT_AUI_FIND_MANAGER: String Read FEVT_AUI_FIND_MANAGER Write FEVT_AUI_FIND_MANAGER;
        Property EVT_UPDATE_UI: String Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxAuiManager]);
End;

{ Method to set variable and property values and create objects }

Procedure TWxAuiManager.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Class := 'wxAuiManager';
    FWx_Comments := TStringList.Create;
    FWx_EventList := TStringList.Create;
    Glyph.Handle := LoadBitmap(hInstance, 'TWxAuiManager');
    FWx_AuiManagerStyle := [wxAUI_MGR_ALLOW_FLOATING, wxAUI_MGR_TRANSPARENT_HINT, wxAUI_MGR_HINT_FADE, wxAUI_MGR_NO_VENETIAN_BLINDS_FADE];
End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }

Procedure TWxAuiManager.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_Comments.Destroy;
    FWx_EventList.Destroy;
    Glyph.Assign(Nil);
End; { of AutoDestroy }

Constructor TWxAuiManager.Create(AOwner: TComponent);
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
    FWx_PropertyList.add('Wx_AuiManagerStyle:wxAuiManager Styles');
    FWx_PropertyList.add('wxAUI_MGR_ALLOW_FLOATING:wxAUI_MGR_ALLOW_FLOATING');
    FWx_PropertyList.add('wxAUI_MGR_ALLOW_ACTIVE_PANE:wxAUI_MGR_ALLOW_ACTIVE_PANE');
    FWx_PropertyList.add('wxAUI_MGR_TRANSPARENT_DRAG:wxAUI_MGR_TRANSPARENT_DRAG');
    FWx_PropertyList.add('wxAUI_MGR_TRANSPARENT_HINT:wxAUI_MGR_TRANSPARENT_HINT');
    FWx_PropertyList.add('wxAUI_MGR_VENETIAN_BLINDS_HINT:wxAUI_MGR_VENETIAN_BLINDS_HINT');
    FWx_PropertyList.add('wxAUI_MGR_RECTANGLE_HINT:wxAUI_MGR_RECTANGLE_HINT');
    FWx_PropertyList.add('wxAUI_MGR_HINT_FADE:wxAUI_MGR_HINT_FADE');
    FWx_PropertyList.add('wxAUI_MGR_NO_VENETIAN_BLINDS_FADE:wxAUI_MGR_NO_VENETIAN_BLINDS_FADE');

    FWx_EventList.add('EVT_AUI_PANE_BUTTON:OnPaneButton');
    FWx_EventList.add('EVT_AUI_PANE_CLOSE:OnPaneClose');
    FWx_EventList.add('EVT_AUI_PANE_MAXIMIZE:OnPaneMaximize');
    FWx_EventList.add('EVT_AUI_PANE_RESTORE:OnPaneRestore');
    FWx_EventList.add('EVT_AUI_RENDER:OnRender');
    FWx_EventList.add('EVT_AUI_FIND_MANAGER:OnFindManager');
//mn  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

End;

Destructor TWxAuiManager.Destroy;
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

Function TWxAuiManager.GenerateControlIDs: String;
Begin
    Result := '';
End;

Function TWxAuiManager.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxAuiManager.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';

    If (XRCGEN) Then
    Begin
        If trim(EVT_AUI_PANE_BUTTON) <> '' Then
            Result := Format('EVT_AUI_PANE_BUTTON(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
                EVT_AUI_PANE_BUTTON]) + '';

        If trim(EVT_AUI_PANE_CLOSE) <> '' Then
            Result := Format('EVT_AUI_PANE_CLOSE(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
                EVT_AUI_PANE_CLOSE]) + '';

        If trim(EVT_AUI_PANE_MAXIMIZE) <> '' Then
            Result := Format('EVT_AUI_PANE_MAXIMIZE(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
                EVT_AUI_PANE_MAXIMIZE]) + '';

        If trim(EVT_AUI_PANE_RESTORE) <> '' Then
            Result := Format('EVT_AUI_PANE_RESTORE(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
                EVT_AUI_PANE_RESTORE]) + '';

        If trim(EVT_AUI_RENDER) <> '' Then
            Result := Format('EVT_AUI_RENDER(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
                EVT_AUI_RENDER]) + '';

        If trim(EVT_AUI_FIND_MANAGER) <> '' Then
            Result := Format('EVT_AUI_FIND_MANAGER(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
                EVT_AUI_FIND_MANAGER]) + '';

{
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';        \

}
    End
    Else
    Begin
        If trim(EVT_AUI_PANE_BUTTON) <> '' Then
            Result := Format('EVT_AUI_PANE_BUTTON(%s::%s)', [CurrClassName,
                EVT_AUI_PANE_BUTTON]) + '';

        If trim(EVT_AUI_PANE_CLOSE) <> '' Then
            Result := Format('EVT_AUI_PANE_CLOSE(%s::%s)', [CurrClassName,
                EVT_AUI_PANE_CLOSE]) + '';

        If trim(EVT_AUI_PANE_MAXIMIZE) <> '' Then
            Result := Format('EVT_AUI_PANE_MAXIMIZE(%s::%s)', [CurrClassName,
                EVT_AUI_PANE_MAXIMIZE]) + '';

        If trim(EVT_AUI_PANE_RESTORE) <> '' Then
            Result := Format('EVT_AUI_PANE_RESTORE(%s::%s)', [CurrClassName,
                EVT_AUI_PANE_RESTORE]) + '';

        If trim(EVT_AUI_RENDER) <> '' Then
            Result := Format('EVT_AUI_RENDER(%s::%s)', [CurrClassName,
                EVT_AUI_RENDER]) + '';

        If trim(EVT_AUI_FIND_MANAGER) <> '' Then
            Result := Format('EVT_AUI_FIND_MANAGER(%s::%s)', [CurrClassName,
                EVT_AUI_FIND_MANAGER]) + '';

{
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
}
    End;

End;

Function TWxAuiManager.GenerateXRCControlCreation(IndentString: String): TStringList;
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

Function TWxAuiManager.GenerateGUIControlCreation: String;
Begin

    Result := '';
    Result := GetCommentString(self.FWx_Comments.Text);

    Result := Result + #13 + Format('%s = new %s(this, %s);',
        [self.Name, self.wx_Class, GetAuiManagerFlags(self.Wx_AuiManagerStyle)]);

End;

Function TWxAuiManager.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxAuiManager.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/aui/aui.h>';
End;

Function TWxAuiManager.GenerateImageInclude: String;
Begin

End;

Function TWxAuiManager.GetEventList: TStringList;
Begin
    Result := Wx_EventList;
End;

Function TWxAuiManager.GetIDName: String;
Begin

End;

Function TWxAuiManager.GetIDValue: Integer;
Begin
    Result := 0;
End;

Function TWxAuiManager.GetParameterFromEventName(EventName: String): String;
Begin
    If EventName = 'EVT_AUI_PANE_BUTTON' Then
    Begin
        Result := 'wxAuiManagerEvent& event';
        exit;
    End;
    If EventName = 'EVT_AUI_PANE_CLOSE' Then
    Begin
        Result := 'wxAuiManagerEvent& event';
        exit;
    End;
    If EventName = 'EVT_AUI_PANE_MAXIMIZE' Then
    Begin
        Result := 'wxAuiManagerEvent& event';
        exit;
    End;
    If EventName = 'EVT_AUI_PANE_RESTORE' Then
    Begin
        Result := 'wxAuiManagerEvent& event';
        exit;
    End;
    If EventName = 'EVT_AUI_RENDER' Then
    Begin
        Result := 'wxAuiManagerEvent& event';
        exit;
    End;
    If EventName = 'EVT_AUI_FIND_MANAGER' Then
    Begin
        Result := 'wxAuiManagerEvent& event';
        exit;
    End;
    If EventName = 'EVT_UPDATE_UI' Then
    Begin
        Result := 'wxUpdateUIEvent& event';
        exit;
    End;
End;

Function TWxAuiManager.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxAuiManager.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxAuiManager.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxAuiManager.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxAuiManager.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxAuiManager.SetBorderWidth(width: Integer);
Begin
End;

Function TWxAuiManager.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxAuiManager.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxAuiManager';
    Result := wx_Class;
End;

Procedure TWxAuiManager.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin

End;

Procedure TWxAuiManager.SetIDName(IDName: String);
Begin

End;

Procedure TWxAuiManager.SetIDValue(IDValue: Integer);
Begin

End;

Procedure TWxAuiManager.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxAuiManager.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxAuiManager.GetFGColor: String;
Begin

End;

Procedure TWxAuiManager.SetFGColor(strValue: String);
Begin
End;

Function TWxAuiManager.GetBGColor: String;
Begin
End;

Procedure TWxAuiManager.SetBGColor(strValue: String);
Begin
End;

Procedure TWxAuiManager.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxAuiManager.SetProxyBGColorString(Value: String);
Begin
End;

Function TWxAuiManager.GetGenericColor(strVariableName: String): String;
Begin
End;

Procedure TWxAuiManager.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxAuiManager.GetAuiManagerFlags(Wx_AuiManagerStyles: TwxAuiManagerFlagSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin
    strLst := TStringList.Create;

    Try

        If wxAUI_MGR_ALLOW_FLOATING In Wx_AuiManagerStyles Then
            strLst.add('wxAUI_MGR_ALLOW_FLOATING ');

        If wxAUI_MGR_ALLOW_ACTIVE_PANE In Wx_AuiManagerStyles Then
            strLst.add('wxAUI_MGR_ALLOW_ACTIVE_PANE ');

        If wxAUI_MGR_TRANSPARENT_DRAG In Wx_AuiManagerStyles Then
            strLst.add('wxAUI_MGR_TRANSPARENT_DRAG ');

        If wxAUI_MGR_TRANSPARENT_HINT In Wx_AuiManagerStyles Then
            strLst.add('wxAUI_MGR_TRANSPARENT_HINT ');

        If wxAUI_MGR_VENETIAN_BLINDS_HINT In Wx_AuiManagerStyles Then
            strLst.add('wxAUI_MGR_VENETIAN_BLINDS_HINT ');

        If wxAUI_MGR_RECTANGLE_HINT In Wx_AuiManagerStyles Then
            strLst.add('wxAUI_MGR_RECTANGLE_HINT ');

        If wxAUI_MGR_HINT_FADE In Wx_AuiManagerStyles Then
            strLst.add('wxAUI_MGR_HINT_FADE ');

        If wxAUI_MGR_NO_VENETIAN_BLINDS_FADE In Wx_AuiManagerStyles Then
            strLst.add('wxAUI_MGR_NO_VENETIAN_BLINDS_FADE ');

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
    //sendDebug(Result);
    Finally
        strLst.Destroy;
    End;
End;

End.
 