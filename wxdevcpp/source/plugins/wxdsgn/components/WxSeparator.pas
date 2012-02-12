// $Id: WxSeparator.pas 936 2007-05-15 03:47:39Z gururamnath $
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


Unit WxSeparator;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, StdCtrls, Wxutils, ExtCtrls, WxSizerPanel, ComCtrls;

Type

    TWxSeparator = Class(TToolButton, IWxComponentInterface,
        IWxToolBarInsertableInterface, IWxToolBarNonInsertableInterface)
    Private
        FEVT_BUTTON: String;
        FEVT_UPDATE_UI: String;
        FWx_BKColor: TColor;
        FWx_Border: Integer;
        FWx_ButtonStyle: TWxBtnStyleSet;
        FWx_Class: String;
        FWx_ControlOrientation: TWxControlOrientation;
        FWx_Default: Boolean;
        FWx_Enabled: Boolean;
        FWx_EventList: TStringList;
        FWx_FGColor: TColor;
        FWx_GeneralStyle: TWxStdStyleSet;
        FWx_HelpText: String;
        FWx_Hidden: Boolean;
        FWx_IDName: String;
        FWx_IDValue: Integer;
        FWx_ProxyBGColorString: TWxColorString;
        FWx_ProxyFGColorString: TWxColorString;
        FWx_StretchFactor: Integer;
        FWx_ToolTip: String;
        FWx_Bitmap: TPicture;
        FWx_PropertyList: TStringList;
        FInvisibleBGColorString: String;
        FInvisibleFGColorString: String;
        FWx_Comments: TStrings;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;

    { Private methods of TWxButton }

        Procedure AutoInitialize;
        Procedure AutoDestroy;
        Procedure SetWx_EventList(Value: TStringList);

    Protected
    { Protected fields of TWxButton }

    { Protected methods of TWxButton }

    Public
    { Public fields and properties of TWxButton }
        defaultBGColor: TColor;
        defaultFGColor: TColor;

    { Public methods of TWxButton }
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Procedure WMPaint(Var Message: TWMPaint); Message WM_PAINT;
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
        Procedure SetButtonBitmap(Value: TPicture);

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

    Published
    { Published properties of TWxButton }
        Property OnClick;
        Property OnDblClick;
        Property OnDragDrop;
        Property OnMouseDown;
        Property OnMouseMove;
        Property OnMouseUp;
        Property EVT_BUTTON: String Read FEVT_BUTTON Write FEVT_BUTTON;
        Property EVT_UPDATE_UI: String Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
        Property Wx_BKColor: TColor Read FWx_BKColor Write FWx_BKColor;
        Property Wx_ButtonStyle: TWxBtnStyleSet Read FWx_ButtonStyle Write FWx_ButtonStyle;
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_ControlOrientation: TWxControlOrientation
            Read FWx_ControlOrientation Write FWx_ControlOrientation;
        Property Wx_Default: Boolean Read FWx_Default Write FWx_Default;
        Property Wx_Enabled: Boolean Read FWx_Enabled Write FWx_Enabled Default True;
        Property Wx_EventList: TStringList Read FWx_EventList Write SetWx_EventList;
        Property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
        Property Wx_GeneralStyle: TWxStdStyleSet
            Read FWx_GeneralStyle Write FWx_GeneralStyle;
        Property Wx_HelpText: String Read FWx_HelpText Write FWx_HelpText;
        Property Wx_Hidden: Boolean Read FWx_Hidden Write FWx_Hidden;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue Default -1;
        Property Wx_ToolTip: String Read FWx_ToolTip Write FWx_ToolTip;
        Property Color;
        Property Wx_BITMAP: TPicture Read FWx_BITMAP Write SetButtonBitmap;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;

        Property InvisibleBGColorString: String Read FInvisibleBGColorString Write FInvisibleBGColorString;
        Property InvisibleFGColorString: String Read FInvisibleFGColorString Write FInvisibleFGColorString;
        Property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
        Property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;

        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxSeparator]);
End;

Procedure TWxSeparator.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Comments := TStringList.Create;
    FWx_EventList := TStringList.Create;
    FWx_Border := 5;
    FWx_Class := 'wxToolBarTool';
    FWx_Enabled := True;
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_IDValue := -1;
    FWx_StretchFactor := 0;
    FWx_ProxyBGColorString := TWxColorString.Create;
    FWx_ProxyFGColorString := TWxColorString.Create;
    defaultBGColor := self.color;
    defaultFGColor := self.font.color;
    Caption := '';
    FWx_Bitmap := TPicture.Create;
    self.Style := tbsDivider;
    self.Width := 5;
End; { of AutoInitialize }


Procedure TWxSeparator.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_EventList.Destroy;
    FWx_Bitmap.Destroy;
    FWx_ProxyBGColorString.Destroy;
    FWx_ProxyFGColorString.Destroy;
    FWx_Comments.Destroy;
End; { of AutoDestroy }


Procedure TWxSeparator.SetWx_EventList(Value: TStringList);
Begin
    FWx_EventList.Assign(Value);
End;

Constructor TWxSeparator.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);

    AutoInitialize;
    self.Caption := '';
    FWx_PropertyList.add('Width:Width');
    FWx_PropertyList.add('Wx_Comments:Comments');

    FWx_EventList.add('EVT_BUTTON:OnClick');
    FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

End;

Destructor TWxSeparator.Destroy;
Begin
    AutoDestroy;
    Inherited Destroy;
End;

Procedure TWxSeparator.WMPaint(Var Message: TWMPaint);
Begin
    self.Caption := '';
    Inherited;
End;


Function TWxSeparator.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxSeparator.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
End;

Function TWxSeparator.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
    If Not IsControlWxToolBar(self.parent) Then
        exit;

    If (XRCGEN) Then
    Begin//generate xrc loading code
        If trim(EVT_BUTTON) <> '' Then
            Result := Format('EVT_BUTTON(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_BUTTON]) + '';

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
    End
    Else
    Begin
        If trim(EVT_BUTTON) <> '' Then
            Result := Format('EVT_BUTTON(%s,%s::%s)', [WX_IDName, CurrClassName,
                EVT_BUTTON]) + '';

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
    End;
End;

Function TWxSeparator.GenerateXRCControlCreation(IndentString: String): TStringList;
Begin

    Result := TStringList.Create;
    Try
        Result.Add(IndentString + '<object class="separator"/>');
    //Result.Add(IndentString + '</object>');
    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxSeparator.GenerateGUIControlCreation: String;
Var
    parentName: String;
Begin
    Result := '';
    If Not (XRCGEN) Then
    Begin
        If Not IsControlWxToolBar(self.parent) Then
            exit;
        parentName := GetWxWidgetParent(self, False);
        Result := GetCommentString(self.FWx_Comments.Text) + parentName +
            '->AddSeparator();';
    End;
End;

Function TWxSeparator.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
End;

Function TWxSeparator.GenerateHeaderInclude: String;
Begin
    Result := '';
End;

Function TWxSeparator.GenerateImageInclude: String;
Begin
    If assigned(Wx_Bitmap) Then
        If Wx_Bitmap.Bitmap.Handle <> 0 Then
            Result := '#include "' + self.Name + '_XPM.xpm"';
End;

Function TWxSeparator.GetEventList: TStringList;
Begin
    Result := Wx_EventList;
End;

Function TWxSeparator.GetIDName: String;
Begin
    Result := wx_IDName;
End;

Function TWxSeparator.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxSeparator.GetParameterFromEventName(EventName: String): String;
Begin
    If EventName = 'EVT_UPDATE_UI' Then
    Begin
        Result := 'wxUpdateUIEvent& event';
        exit;
    End;
End;

Function TWxSeparator.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxSeparator.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxSeparator.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxSeparator.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxSeparator.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxSeparator.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxSeparator.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxSeparator.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := '';
    Result := wx_Class;
End;

Procedure TWxSeparator.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxSeparator.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxSeparator.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxSeparator.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxSeparator.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxSeparator.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxSeparator.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxSeparator.GetFGColor: String;
Begin
    Result := FInvisibleFGColorString;
End;

Procedure TWxSeparator.SetFGColor(strValue: String);
Begin
    FInvisibleFGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Font.Color := defaultFGColor
    Else
        self.Font.Color := GetColorFromString(strValue);
End;

Function TWxSeparator.GetBGColor: String;
Begin
    Result := FInvisibleBGColorString;
End;

Procedure TWxSeparator.SetBGColor(strValue: String);
Begin
    FInvisibleBGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Color := defaultBGColor
    Else
        self.Color := GetColorFromString(strValue);
End;

Procedure TWxSeparator.SetProxyFGColorString(Value: String);
Begin
    FInvisibleFGColorString := Value;
    self.Color := GetColorFromString(Value);
End;

Procedure TWxSeparator.SetProxyBGColorString(Value: String);
Begin
    FInvisibleBGColorString := Value;
    self.Font.Color := GetColorFromString(Value);
End;

Procedure TWxSeparator.SetButtonBitmap(Value: TPicture);
Begin
    If Not assigned(Value) Then
        exit;
  //self.Glyph.Assign(value.Bitmap);
End;

End.
