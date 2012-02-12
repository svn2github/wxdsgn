// $Id: WxToolButton.pas 936 2007-05-15 03:47:39Z gururamnath $
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

Unit WxToolButton;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, StrUtils,
    Forms, Graphics, StdCtrls, Wxutils, ExtCtrls, WxSizerPanel, ComCtrls, Buttons;

Type

    TWxToolButton = Class(TBitBtn, IWxComponentInterface, IWxToolBarInsertableInterface,
        IWxToolBarNonInsertableInterface, IWxImageContainerInterface)
    Private
        FEVT_MENU: String;
        FEVT_UPDATE_UI: String;
        FWx_Caption: String;
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
        FWx_Disable_Bitmap: TPicture;
        FWx_Bitmap: TPicture;
        FWx_PropertyList: TStringList;
        FInvisibleBGColorString: String;
        FInvisibleFGColorString: String;
        FToolKind: TWxToolbottonItemStyleItem;
        FWx_Comments: TStrings;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;
        FKeepFormat: Boolean;
        FWx_Filename: String;
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
        Procedure Loaded; Override;
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
        Procedure SetDisableBitmap(Value: TPicture);

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);
        Function GetBitmapCount: Integer;
        Function GetBitmap(Idx: Integer; Var bmp: TBitmap; Var PropertyName: String): Boolean;
        Function GetPropertyName(Idx: Integer): String;
        Function PreserveFormat: Boolean;

        Function GetGraphicFileName: String;
        Function SetGraphicFileName(strFileName: String): Boolean;

    Published
    { Published properties of TWxButton }
        Property OnClick;
        Property OnDblClick;
        Property OnDragDrop;
        Property OnMouseDown;
        Property OnMouseMove;
        Property OnMouseUp;
        Property EVT_MENU: String Read FEVT_MENU Write FEVT_MENU;
        Property EVT_UPDATE_UI: String Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
        Property Wx_Caption: String Read FWx_Caption Write FWx_Caption;
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
        Property ToolKind: TWxToolbottonItemStyleItem
            Read FToolKind Write FToolKind Default wxITEM_NORMAL;
        Property Color;
        Property Wx_BITMAP: TPicture Read FWx_BITMAP Write SetButtonBitmap;
        Property Wx_DISABLE_BITMAP: TPicture Read FWx_DISABLE_BITMAP Write SetDisableBitmap;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;

        Property InvisibleBGColorString: String Read FInvisibleBGColorString Write FInvisibleBGColorString;
        Property InvisibleFGColorString: String Read FInvisibleFGColorString Write FInvisibleFGColorString;
        Property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
        Property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;

        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

        Property KeepFormat: Boolean Read FKeepFormat Write FKeepFormat Default False;
        Property Wx_Filename: String Read FWx_Filename Write FWx_Filename;

    End;

Procedure Register;

Implementation

Uses
    WxToolbar;

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxToolButton]);
End;

Procedure TWxToolButton.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Border := 5;
    FWx_Class := 'wxToolBarTool';
    FWx_Caption := '';
    FWx_Enabled := True;
    FWx_EventList := TStringList.Create;
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
    FWx_DISABLE_BITMAP := TPicture.Create;
    self.Width := 24;
    self.Height := 24;
    self.Layout := blGlyphTop;
    FWx_Comments := TStringList.Create;

End; { of AutoInitialize }


Procedure TWxToolButton.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_EventList.Destroy;
    FWx_Bitmap.Destroy;
    FWx_DISABLE_BITMAP.Destroy;
    FWx_ProxyBGColorString.Destroy;
    FWx_ProxyFGColorString.Destroy;
    FWx_Comments.Destroy;
End; { of AutoDestroy }

Procedure TWxToolButton.Loaded;
Begin
    Inherited Loaded;
    If self.Caption <> '' Then
        FWx_Caption := self.Caption;
    self.Caption := '';
End;

Procedure TWxToolButton.SetWx_EventList(Value: TStringList);
Begin
    FWx_EventList.Assign(Value);
End;

Constructor TWxToolButton.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);

    AutoInitialize;
    self.Caption := '';
    FWx_PropertyList.add('Wx_HelpText:Help Text');
    FWx_PropertyList.add('Wx_IDName:ID Name');
    FWx_PropertyList.add('Wx_IDValue:ID Value');
    FWx_PropertyList.add('Wx_ToolTip:Tooltip');
    FWx_PropertyList.add('Name:Name');
    FWx_PropertyList.add('ToolKind:Type');
    FWx_PropertyList.add('Wx_Caption:Label');
    FWx_PropertyList.add('Wx_Bitmap:Bitmap');
    FWx_PropertyList.add('Wx_Comments:Comments');

    FWx_EventList.add('EVT_MENU:OnClick');
    FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

End;

Destructor TWxToolButton.Destroy;
Begin
    AutoDestroy;
    Inherited Destroy;
End;

Procedure TWxToolButton.WMPaint(Var Message: TWMPaint);
Begin
    If Parent Is TWxToolbar Then
    Begin
        If TWxToolbar(Parent).ShowCaptions = True Then
            self.Caption := FWx_Caption
        Else
            self.Caption := '';
    End;
    Inherited;
End;

Function TWxToolButton.GenerateEnumControlIDs: String;
Begin
    Result := '';
    If Not IsControlWxToolBar(self.parent) Then
        exit;

    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxToolButton.GenerateControlIDs: String;
Begin
    Result := '';
    If Not IsControlWxToolBar(self.parent) Then
        exit;

    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
End;

Function TWxToolButton.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';

    If Not IsControlWxToolBar(self.parent) Then
        exit;
    If (XRCGEN) Then
    Begin
        If trim(EVT_MENU) <> '' Then
            Result := Format('EVT_MENU(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName, EVT_MENU]) + '';

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
    End
    Else
    Begin
        If trim(EVT_MENU) <> '' Then
            Result := Format('EVT_MENU(%s,%s::%s)', [WX_IDName, CurrClassName, EVT_MENU]) + '';

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
    End;
End;

Function TWxToolButton.GenerateXRCControlCreation(IndentString: String): TStringList;
Begin

    Result := TStringList.Create;

    Try
        Result.Add(IndentString + Format('<object class="tool" name="%s">', [self.Name]));
        Result.Add(IndentString + Format('<IDident>%s</IDident>', [self.Wx_IDName]));
        Result.Add(IndentString + Format('<ID>%d</ID>', [self.Wx_IDValue]));

        If assigned(Wx_Bitmap) Then
            Result.Add(IndentString + '<bitmap>' + '"' + GetGraphicFileName + '"' + '</bitmap>)');

        Result.Add(IndentString + Format('<tooltip>%s</tooltip>', [self.Wx_Tooltip]));
        Result.Add(IndentString + Format('<longhelp>%s</longhelp>', [self.Wx_HelpText]));

        Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxToolButton.GenerateGUIControlCreation: String;
Var
    parentName: String;
    strFirstBitmap, strSecondBitmap: String;
Begin
    Result := '';
    parentName := GetWxWidgetParent(self, False);

    If Not IsControlWxToolBar(self.parent) Then
        exit;

    strFirstBitmap := 'wxBitmap ' + self.Name + '_BITMAP' + ' (wxNullBitmap);';
    strSecondBitmap := 'wxBitmap ' + self.Name + '_DISABLE_BITMAP' + ' (wxNullBitmap);';

  //Result:='wxBitmap '+self.Name+'_BITMAP'+' (wxNullBitmap);';

    If assigned(Wx_Bitmap) Then
        If Wx_Bitmap.Bitmap.Handle <> 0 Then
            If (KeepFormat) Then
            Begin
                Wx_FileName := AnsiReplaceText(Wx_FileName, '\', '/');

                strFirstBitmap := 'wxBitmap ' + self.Name + '_BITMAP' + ' (' + GetCppString(Wx_FileName) + ', wxBITMAP_TYPE_' +
                    GetExtension(Wx_FileName) + ');';
            End
            Else
                strFirstBitmap := 'wxBitmap ' + self.Name + '_BITMAP' + ' (' + GetDesignerFormName(self) + '_' + self.Name + '_XPM' + ');';

    If assigned(Wx_DISABLE_BITMAP) Then
        If Wx_DISABLE_BITMAP.Bitmap.Handle <> 0 Then
            strSecondBitmap := 'wxBitmap ' + self.Name + '_DISABLE_BITMAP' + ' (' + GetDesignerFormName(self) + '_' + self.Name + '_DISABLE_BITMAP_XPM' + ');';

    If Not (XRCGEN) Then
    Begin
        Result := GetCommentString(self.FWx_Comments.Text) + strFirstBitmap + #13 + strSecondBitmap;
        If (self.Parent Is TWxToolBar) Then
            Result := Result + #13 + Format('%s->AddTool(%s, %s, %s, %s, %s, %s, %s);',
                [parentName, GetWxIDString(self.Wx_IDName, self.Wx_IDValue), GetCppString(
                self.Wx_Caption), self.Name + '_BITMAP', self.Name + '_DISABLE_BITMAP',
                GetToolButtonKindAsText(ToolKind), GetCppString(self.Wx_ToolTip),
                GetCppString(self.Wx_HelpText)])
        Else            //    (self.Parent is TWxAuiToolBar)
            Result := Result + #13 + Format('%s->AddTool(%s, %s, %s, %s, %s, %s, %s, NULL);',
                [parentName, GetWxIDString(self.Wx_IDName, self.Wx_IDValue), GetCppString(
                self.Wx_Caption), self.Name + '_BITMAP', self.Name + '_DISABLE_BITMAP',
                GetToolButtonKindAsText(ToolKind), GetCppString(self.Wx_ToolTip),
                GetCppString(self.Wx_HelpText)]);
    End
    Else
    Begin
        If assigned(Wx_Bitmap) Then
            Result := Result + #13 + Format('%s->%s_BITMAP', [self.Name, self.Name]);
        If assigned(Wx_DISABLE_BITMAP) Then
            Result := Result + #13 + Format('%s->%s_DISABLE_BITMAP', [self.Name, self.Name]);
    End;

End;

Function TWxToolButton.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
End;

Function TWxToolButton.GenerateHeaderInclude: String;
Begin
    Result := '';
End;

Function TWxToolButton.GenerateImageInclude: String;
Begin
    If assigned(Wx_Bitmap) Then
        If Wx_Bitmap.Bitmap.Handle <> 0 Then
            If (Not KeepFormat) Then
                Result := '#include "' + GetGraphicFileName + '"';
End;

Function TWxToolButton.GetEventList: TStringList;
Begin
    Result := Wx_EventList;
End;

Function TWxToolButton.GetIDName: String;
Begin
    Result := wx_IDName;
End;

Function TWxToolButton.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxToolButton.GetParameterFromEventName(EventName: String): String;
Begin
    If EventName = 'EVT_MENU' Then
    Begin
        Result := 'wxCommandEvent& event';
        exit;
    End;
    If EventName = 'EVT_UPDATE_UI' Then
    Begin
        Result := 'wxUpdateUIEvent& event';
        exit;
    End;
End;

Function TWxToolButton.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxToolButton.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxToolButton.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxToolButton.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxToolButton.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxToolButton.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxToolButton.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxToolButton.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := '';
    Result := wx_Class;
End;

Procedure TWxToolButton.SaveControlOrientation(ControlOrientation:
    TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxToolButton.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxToolButton.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxToolButton.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxToolButton.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxToolButton.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxToolButton.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxToolButton.GetFGColor: String;
Begin
    Result := FInvisibleFGColorString;
End;

Procedure TWxToolButton.SetFGColor(strValue: String);
Begin
    FInvisibleFGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Font.Color := defaultFGColor
    Else
        self.Font.Color := GetColorFromString(strValue);
End;

Function TWxToolButton.GetBGColor: String;
Begin
    Result := FInvisibleBGColorString;
End;

Procedure TWxToolButton.SetBGColor(strValue: String);
Begin
    FInvisibleBGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Color := defaultBGColor
    Else
        self.Color := GetColorFromString(strValue);
End;

Procedure TWxToolButton.SetProxyFGColorString(Value: String);
Begin
    FInvisibleFGColorString := Value;
    self.Color := GetColorFromString(Value);
End;

Procedure TWxToolButton.SetProxyBGColorString(Value: String);
Begin
    FInvisibleBGColorString := Value;
    self.Font.Color := GetColorFromString(Value);
End;

Procedure TWxToolButton.SetButtonBitmap(Value: TPicture);
Begin
    If Not assigned(Value) Then
        exit;
    self.Glyph.Assign(Value.Bitmap);
End;

Procedure TWxToolButton.SetDisableBitmap(Value: TPicture);
Begin
    If Not assigned(Value) Then
        exit;
    FWx_DISABLE_BITMAP.Assign(Value);
End;

Function TWxToolButton.GetBitmapCount: Integer;
Begin
    Result := 1; //fixme later
End;

Function TWxToolButton.GetBitmap(Idx: Integer; Var bmp: TBitmap; Var PropertyName: String): Boolean;
Begin
    bmp := Wx_Bitmap.Bitmap;
    PropertyName := Name;
    Result := True;
End;

Function TWxToolButton.GetPropertyName(Idx: Integer): String;
Begin
    Result := Name;
End;

Function TWxToolButton.GetGraphicFileName: String;
Begin
    Result := Wx_Filename;
End;

Function TWxToolButton.SetGraphicFileName(strFileName: String): Boolean;
Begin

 // If no filename passed, then auto-generate XPM filename
    If (strFileName = '') Then
        strFileName := GetDesignerFormName(self) + '_' + self.Name + '_XPM.xpm';

    If Not KeepFormat Then
        strFileName := 'Images\' + strFileName;

    Wx_Filename := CreateGraphicFileName(strFileName);
    Result := True;

End;

Function TWxToolButton.PreserveFormat: Boolean;
Begin
    Result := KeepFormat;
End;

End.
