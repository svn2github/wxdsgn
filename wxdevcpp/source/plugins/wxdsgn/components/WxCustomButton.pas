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

Unit WxCustomButton;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, StrUtils,
    Forms, Graphics, StdCtrls, Wxutils, ExtCtrls, WxAuiToolBar, WxSizerPanel, Buttons, WxAuiNotebookPage,
    UValidator;

Type

    TWxCustomButton = Class(TBitBtn, IWxComponentInterface, IWxImageContainerInterface,
        IWxValidatorInterface)
    Private
        FEVT_BUTTON: String;
        FEVT_TOGGLEBUTTON: String;
        FEVT_UPDATE_UI: String;
        FWx_BKColor: TColor;
        FWx_Border: Integer;
        FWx_ButtonStyle: TWxCBtnStyleSubItem;
        FWx_ButtonPosStyle: TWxCBtnPosStyleSubItem;
        FWx_ButtonDwgStyle: TWxCBtnDwgStyleSubSet;
        FWx_Class: String;
        FWx_ControlOrientation: TWxControlOrientation;
        FWx_Default: Boolean;
        FWx_Enabled: Boolean;
        FWx_EventList: TStringList;
        FWx_FGColor: TColor;
        FWx_GeneralStyle: TWxStdStyleSet;
        FWx_HelpText: String;
        FWx_Hidden: Boolean;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;
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
        FWx_Validator: String;
        FWx_ProxyValidatorString: TWxValidatorString;
        FWx_Comments: TStrings;
        FKeepFormat: Boolean;
        FWx_Filename: String;

//Aui Properties
        FWx_AuiManaged: Boolean;
        FWx_PaneCaption: String;
        FWx_PaneName: String;
        FWx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem;
        FWx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet;
        FWx_Aui_Pane_Style: TwxAuiPaneStyleSet;
        FWx_Aui_Pane_Buttons: TwxAuiPaneButtonSet;
        FWx_BestSize_Height: Integer;
        FWx_BestSize_Width: Integer;
        FWx_MinSize_Height: Integer;
        FWx_MinSize_Width: Integer;
        FWx_MaxSize_Height: Integer;
        FWx_MaxSize_Width: Integer;
        FWx_Floating_Height: Integer;
        FWx_Floating_Width: Integer;
        FWx_Floating_X_Pos: Integer;
        FWx_Floating_Y_Pos: Integer;
        FWx_Layer: Integer;
        FWx_Row: Integer;
        FWx_Position: Integer;

    { Private methods of TWxCustomButton }

        Procedure AutoInitialize;
        Procedure AutoDestroy;
        Procedure SetWx_EventList(Value: TStringList);

        Function GetBitmapCount: Integer;
        Function GetBitmap(Idx: Integer; Var bmp: TBitmap; Var PropertyName: String): Boolean;
        Function GetPropertyName(Idx: Integer): String;
        Function PreserveFormat: Boolean;

    Protected
    { Protected fields of TWxButton }

    { Protected methods of TWxButton }

    Public
    { Public fields and properties of TWxButton }
        defaultBGColor: TColor;
        defaultFGColor: TColor;

    { Public methods of TWxCustomButton }
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

        Function GetValidator: String;
        Procedure SetValidator(value: String);
        Function GetValidatorString: TWxValidatorString;
        Procedure SetValidatorString(Value: TWxValidatorString);

        Procedure SetProxyFGColorString(Value: String);
        Procedure SetProxyBGColorString(Value: String);
        Procedure SetButtonBitmap(Value: TPicture);

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

        Function GetCustomButtonStyle(Wx_ButtonStyle: TWxCBtnStyleSubItem): String;
        Function GetCustomButtonDwgStyle(Wx_ButtonDwgStyle: TWxCBtnDwgStyleSubSet): String;
        Function GetCustomButtonPosStyle(Wx_ButtonPosStyle: TWxCBtnPosStyleSubItem): String;
        Function GetCustomButtonSpecificStyle: String;

        Function GetGraphicFileName: String;
        Function SetGraphicFileName(strFileName: String): Boolean;

    Published
        Property Color;
        Property OnClick;
//    property OnToggleClick;
        Property OnDblClick;
        Property OnDragDrop;
        Property OnMouseDown;
        Property OnMouseMove;
        Property OnMouseUp;
        Property EVT_BUTTON: String Read FEVT_BUTTON Write FEVT_BUTTON;
        Property EVT_TOGGLEBUTTON: String Read FEVT_TOGGLEBUTTON Write FEVT_TOGGLEBUTTON;
        Property EVT_UPDATE_UI: String Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
        Property Wx_BKColor: TColor Read FWx_BKColor Write FWx_BKColor;
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
        Property Wx_BITMAP: TPicture Read FWx_BITMAP Write SetButtonBitmap;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue Default -1;
        Property Wx_Validator: String Read FWx_Validator Write FWx_Validator;
        Property Wx_ProxyValidatorString: TWxValidatorString Read GetValidatorString Write SetValidatorString;
        Property Wx_ToolTip: String Read FWx_ToolTip Write FWx_ToolTip;

        Property KeepFormat: Boolean Read FKeepFormat Write FKeepFormat Default False;
        Property Wx_Filename: String Read FWx_Filename Write FWx_Filename;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;

        Property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
        Property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
        Property InvisibleBGColorString: String Read FInvisibleBGColorString Write FInvisibleBGColorString;
        Property InvisibleFGColorString: String Read FInvisibleFGColorString Write FInvisibleFGColorString;

        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

        Property Wx_ButtonStyle: TWxCBtnStyleSubItem Read FWx_ButtonStyle Write FWx_ButtonStyle;
        Property Wx_ButtonPosStyle: TWxCBtnPosStyleSubItem Read FWx_ButtonPosStyle Write FWx_ButtonPosStyle;
        Property Wx_ButtonDwgStyle: TWxCBtnDwgStyleSubSet Read FWx_ButtonDwgStyle Write FWx_ButtonDwgStyle;

//Aui Properties
        Property Wx_AuiManaged: Boolean Read FWx_AuiManaged Write FWx_AuiManaged Default False;
        Property Wx_PaneCaption: String Read FWx_PaneCaption Write FWx_PaneCaption;
        Property Wx_PaneName: String Read FWx_PaneName Write FWx_PaneName;
        Property Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem Read FWx_Aui_Dock_Direction Write FWx_Aui_Dock_Direction;
        Property Wx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet Read FWx_Aui_Dockable_Direction Write FWx_Aui_Dockable_Direction;
        Property Wx_Aui_Pane_Style: TwxAuiPaneStyleSet Read FWx_Aui_Pane_Style Write FWx_Aui_Pane_Style;
        Property Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet Read FWx_Aui_Pane_Buttons Write FWx_Aui_Pane_Buttons;
        Property Wx_BestSize_Height: Integer Read FWx_BestSize_Height Write FWx_BestSize_Height Default -1;
        Property Wx_BestSize_Width: Integer Read FWx_BestSize_Width Write FWx_BestSize_Width Default -1;
        Property Wx_MinSize_Height: Integer Read FWx_MinSize_Height Write FWx_MinSize_Height Default -1;
        Property Wx_MinSize_Width: Integer Read FWx_MinSize_Width Write FWx_MinSize_Width Default -1;
        Property Wx_MaxSize_Height: Integer Read FWx_MaxSize_Height Write FWx_MaxSize_Height Default -1;
        Property Wx_MaxSize_Width: Integer Read FWx_MaxSize_Width Write FWx_MaxSize_Width Default -1;
        Property Wx_Floating_Height: Integer Read FWx_Floating_Height Write FWx_Floating_Height Default -1;
        Property Wx_Floating_Width: Integer Read FWx_Floating_Width Write FWx_Floating_Width Default -1;
        Property Wx_Floating_X_Pos: Integer Read FWx_Floating_X_Pos Write FWx_Floating_X_Pos Default -1;
        Property Wx_Floating_Y_Pos: Integer Read FWx_Floating_Y_Pos Write FWx_Floating_Y_Pos Default -1;
        Property Wx_Layer: Integer Read FWx_Layer Write FWx_Layer Default 0;
        Property Wx_Row: Integer Read FWx_Row Write FWx_Row Default 0;
        Property Wx_Position: Integer Read FWx_Position Write FWx_Position Default 0;

    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxCustomButton]);
End;

Procedure TWxCustomButton.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Border := 5;
    FWx_Class := 'wxCustomButton';
    FWx_Enabled := True;
    FWx_EventList := TStringList.Create;
    FWx_IDValue := -1;
    FWx_StretchFactor := 0;
    FWx_ProxyBGColorString := TWxColorString.Create;
    FWx_ProxyFGColorString := TWxColorString.Create;
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_ButtonDwgStyle := [];
    defaultBGColor := self.color;
    defaultFGColor := self.font.color;
    FWx_Bitmap := TPicture.Create;
    FWx_ProxyValidatorString := TwxValidatorString.Create(self);
    FWx_Comments := TStringList.Create;
    FWx_Filename := '';

End; { of AutoInitialize }


Procedure TWxCustomButton.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_EventList.Destroy;
    FWx_Bitmap.Destroy;
    FWx_ProxyBGColorString.Destroy;
    FWx_ProxyFGColorString.Destroy;
    FWx_Comments.Destroy;
    FWx_ProxyValidatorString.Destroy;

End; { of AutoDestroy }


Procedure TWxCustomButton.SetWx_EventList(Value: TStringList);
Begin
    FWx_EventList.Assign(Value);
End;

Constructor TWxCustomButton.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);
    AutoInitialize;

    PopulateGenericProperties(FWx_PropertyList);
    PopulateAuiGenericProperties(FWx_PropertyList);

    FWx_PropertyList.add('Caption:Label');
    FWx_PropertyList.add('Wx_Bitmap:Bitmap');
    FWx_PropertyList.add('Wx_ButtonStyle:Button Type');
    FWx_PropertyList.add('wxCUSTBUT_NOTOGGLE:wxCUSTBUT_NOTOGGLE');
    FWx_PropertyList.add('wxCUSTBUT_BUTTON:wxCUSTBUT_BUTTON');
    FWx_PropertyList.add('wxCUSTBUT_TOGGLE:wxCUSTBUT_TOGGLE');
    FWx_PropertyList.add('wxCUSTBUT_BUT_DCLICK_TOG:wxCUSTBUT_BUT_DCLICK_TOG');
    FWx_PropertyList.add('wxCUSTBUT_TOG_DCLICK_BUT:wxCUSTBUT_TOG_DCLICK_BUT');
    FWx_PropertyList.add('Wx_ButtonPosStyle:Label Position');
    FWx_PropertyList.add('wxCUSTBUT_LEFT:wxCUSTBUT_LEFT');
    FWx_PropertyList.add('wxCUSTBUT_RIGHT:wxCUSTBUT_RIGHT');
    FWx_PropertyList.add('wxCUSTBUT_TOP:wxCUSTBUT_TOP');
    FWx_PropertyList.add('wxCUSTBUT_BOTTOM:wxCUSTBUT_BOTTOM');
    FWx_PropertyList.add('Wx_ButtonDwgStyle:Button Drawing Style');
    FWx_PropertyList.Add('wxCUSTBUT_FLAT:wxCUSTBUT_FLAT');

    FWx_EventList.add('EVT_BUTTON:OnClick');
    FWx_EventList.add('EVT_TOGGLEBUTTON:OnToggleClick ');
    FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

    FWx_ButtonStyle := wxCUSTBUT_BUTTON;
    FWx_ButtonPosStyle := wxCUSTBUT_RIGHT;
    FWx_ButtonDwgStyle := [];

End;

Destructor TWxCustomButton.Destroy;
Begin
    AutoDestroy;
    Inherited Destroy;
End;


Function TWxCustomButton.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxCustomButton.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d', [Wx_IDName, Wx_IDValue]);
End;

Function TWxCustomButton.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';

    If (XRCGEN) Then
    Begin
        If trim(EVT_BUTTON) <> '' Then
            Result := Format('EVT_BUTTON(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
                EVT_BUTTON]) + '';

        If Not (Wx_ButtonStyle = wxCUSTBUT_BUTTON) Then
        Begin
            If trim(EVT_TOGGLEBUTTON) <> '' Then
                Result := Result + #13 + Format('EVT_TOGGLEBUTTON(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName,
                    EVT_TOGGLEBUTTON]) + '';
        End;

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
    End
    Else
    Begin
        If trim(EVT_BUTTON) <> '' Then
            Result := Format('EVT_BUTTON(%s,%s::%s)', [WX_IDName, CurrClassName,
                EVT_BUTTON]) + '';

        If Not (Wx_ButtonStyle = wxCUSTBUT_BUTTON) Then
        Begin
            If trim(EVT_TOGGLEBUTTON) <> '' Then
                Result := Result + #13 + Format('EVT_TOGGLEBUTTON(%s,%s::%s)', [WX_IDName, CurrClassName,
                    EVT_TOGGLEBUTTON]) + '';
        End;

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
    End;

End;

Function TWxCustomButton.GenerateXRCControlCreation(IndentString: String): TStringList;
Var
    stylestring: String;
Begin

    Result := TStringList.Create;

    Try
        Result.Add(IndentString + Format('<object class="%s" name="%s">',
            [self.Wx_Class, self.Name]));
        Result.Add(IndentString + Format('  <label>%s</label>', [XML_Label(self.Caption)]));
        Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
        Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));

        If Not (UseDefaultSize) Then
            Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
        If Not (UseDefaultPos) Then
            Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

        stylestring := GetCustomButtonSpecificStyle();
        Result.Add(IndentString + Format('  <style>%s</style>', [stylestring]));

        Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxCustomButton.GenerateGUIControlCreation: String;
Var
    strColorStr: String;
    strStyle: String;
    parentName, strAlignment: String;
Begin
    Result := '';
    strStyle := GetCustomButtonSpecificStyle();

    If trim(Wx_ProxyValidatorString.strValidatorValue) <> '' Then
    Begin
        strStyle := ', ' + strStyle + ', ' + Wx_ProxyValidatorString.strValidatorValue;

        strStyle := strStyle + ', ' + GetCppString(Name);

    End
    Else
        strStyle := ', ' + strStyle + ', wxDefaultValidator, ' + GetCppString(Name);

    If FWx_PaneCaption = '' Then
        FWx_PaneCaption := Self.Name;
    If FWx_PaneName = '' Then
        FWx_PaneName := Self.Name + '_Pane';

    parentName := GetWxWidgetParent(self, Wx_AuiManaged);

    Result := GetCommentString(self.FWx_Comments.Text) +
        'wxBitmap ' + self.Name + '_BITMAP' + ' (wxNullBitmap);';

    If assigned(Wx_Bitmap) Then
        If Wx_Bitmap.Bitmap.Handle <> 0 Then
            If (KeepFormat) Then
            Begin
                Wx_FileName := AnsiReplaceText(Wx_FileName, '\', '/');
                Result := 'wxBitmap ' + self.Name + '_BITMAP (' +
                    GetCppString(Wx_FileName) + ', wxBITMAP_TYPE_' +
                    GetExtension(Wx_FileName) + ');';

            End
            Else
                Result := 'wxBitmap ' + self.Name + '_BITMAP' + ' (' + GetDesignerFormName(self) + '_' + self.Name + '_XPM' + ');';

    If (XRCGEN) Then
    Begin
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
            [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);
    End
    Else
        Result := Result + #13 + Format(
            '%s = new %s(%s, %s, %s, %s, %s, %s%s);',
            [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
            self.Wx_IDValue), GetCppString(self.Text),
            self.Name + '_BITMAP', GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);

    If trim(self.Wx_ToolTip) <> '' Then
        Result := Result + #13 + Format('%s->SetToolTip(%s);',
            [self.Name, GetCppString(self.Wx_ToolTip)]);

    If self.Wx_Hidden Then
        Result := Result + #13 + Format('%s->Show(false);', [self.Name]);

    If Not Wx_Enabled Then
        Result := Result + #13 + Format('%s->Enable(false);', [self.Name]);

    If trim(self.Wx_HelpText) <> '' Then
        Result := Result + #13 + Format('%s->SetHelpText(%s);',
            [self.Name, GetCppString(self.Wx_HelpText)]);

    strColorStr := trim(GetwxColorFromString(InvisibleFGColorString));
    If strColorStr <> '' Then
        Result := Result + #13 + Format('%s->SetForegroundColour(%s);',
            [self.Name, strColorStr]);

    strColorStr := trim(GetwxColorFromString(InvisibleBGColorString));
    If strColorStr <> '' Then
        Result := Result + #13 + Format('%s->SetBackgroundColour(%s);',
            [self.Name, strColorStr]);


    strColorStr := GetWxFontDeclaration(self.Font);
    If strColorStr <> '' Then
        Result := Result + #13 + Format('%s->SetFont(%s);', [self.Name, strColorStr]);
    If Not (XRCGEN) Then //NUKLEAR ZELPH
    Begin
        If (Wx_AuiManaged And FormHasAuiManager(self)) And Not (self.Parent Is TWxSizerPanel) Then
        Begin
            If HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) Then
            Begin
                Self.Wx_Aui_Pane_Style := Self.Wx_Aui_Pane_Style + [ToolbarPane]; //always make sure we are a toolbar
                Self.Wx_Layer := 10;
            End;

            If Not HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) Then
            Begin
                If (self.Parent.ClassName = 'TWxPanel') Then
                    If Not (self.Parent.Parent Is TForm) Then
                        Result := Result + #13 + Format('%s->Reparent(this);', [parentName]);
            End;

            If (self.Parent Is TWxAuiToolBar) Then
                Result := Result + #13 + Format('%s->AddControl(%s);',
                    [self.Parent.Name, self.Name])
            Else
                Result := Result + #13 + Format('%s->AddPane(%s, wxAuiPaneInfo()%s%s%s%s%s%s%s%s%s%s%s%s);',
                    [GetAuiManagerName(self), self.Name,
                    GetAuiPaneName(Self.Wx_PaneName),
                    GetAuiPaneCaption(Self.Wx_PaneCaption),
                    GetAuiDockDirection(Self.Wx_Aui_Dock_Direction),
                    GetAuiDockableDirections(self.Wx_Aui_Dockable_Direction),
                    GetAui_Pane_Style(Self.Wx_Aui_Pane_Style),
                    GetAui_Pane_Buttons(Self.Wx_Aui_Pane_Buttons),
                    GetAuiRow(Self.Wx_Row),
                    GetAuiPosition(Self.Wx_Position),
                    GetAuiLayer(Self.Wx_Layer),
                    GetAuiPaneBestSize(Self.Wx_BestSize_Width, Self.Wx_BestSize_Height),
                    GetAuiPaneMinSize(Self.Wx_MinSize_Width, Self.Wx_MinSize_Height),
                    GetAuiPaneMaxSize(Self.Wx_MaxSize_Width, Self.Wx_MaxSize_Height)]);

        End
        Else
        Begin
            If (self.Parent Is TWxSizerPanel) Then
            Begin

                strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);

                Result := Result + #13 + Format('%s->Add(%s, %d, %s, %d);',
                    [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
                    self.Wx_Border]);
            End;

            If (self.Parent Is TWxAuiNotebookPage) Then
            Begin
        //        strParentLabel := TWxAuiNoteBookPage(Self.Parent).Caption;
                Result := Result + #13 + Format('%s->AddPage(%s, %s);',
          //          [self.Parent.Parent.Name, self.Name, GetCppString(strParentLabel)]);
                    [self.Parent.Parent.Name, self.Name, GetCppString(TWxAuiNoteBookPage(Self.Parent).Caption)]);
            End;

            If (self.Parent Is TWxAuiToolBar) Then
                Result := Result + #13 + Format('%s->AddControl(%s);',
                    [self.Parent.Name, self.Name]);
        End;
    End;

End;

Function TWxCustomButton.GenerateGUIControlDeclaration: String;
Begin
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxCustomButton.GenerateHeaderInclude: String;
Begin
    Result := '';
    If Not (Wx_ButtonStyle = wxCUSTBUT_BUTTON) Then
    Begin
        Result := '#include <wx/tglbtn.h>';
        Result := Result + #13;
    End;

    Result := Result + '#include <wx\things\toggle.h>';
End;

Function TWxCustomButton.GenerateImageInclude: String;
Begin
    If assigned(Wx_Bitmap) Then
        If Wx_Bitmap.Bitmap.Handle <> 0 Then
            If (Not KeepFormat) Then
                Result := '#include "' + GetGraphicFileName + '"';

End;

Function TWxCustomButton.GetEventList: TStringList;
Begin
    Result := Wx_EventList;
End;

Function TWxCustomButton.GetIDName: String;
Begin
    Result := wx_IDName;
End;

Function TWxCustomButton.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxCustomButton.GetParameterFromEventName(EventName: String): String;
Begin
    If EventName = 'EVT_BUTTON' Then
    Begin
        Result := 'wxCommandEvent& event';
        exit;
    End;
    If EventName = 'EVT_TOGGLEBUTTON' Then
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

Function TWxCustomButton.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxCustomButton.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxCustomButton.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxCustomButton.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxCustomButton.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxCustomButton.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxCustomButton.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxCustomButton.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxCustomButton';
    Result := wx_Class;
End;

Procedure TWxCustomButton.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxCustomButton.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxCustomButton.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDValue;
End;

Procedure TWxCustomButton.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxCustomButton.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxCustomButton.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxCustomButton.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxCustomButton.GetFGColor: String;
Begin
    Result := FInvisibleFGColorString;
End;

Procedure TWxCustomButton.SetFGColor(strValue: String);
Begin
    FInvisibleFGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Font.Color := defaultFGColor
    Else
        self.Font.Color := GetColorFromString(strValue);
End;

Function TWxCustomButton.GetBGColor: String;
Begin
    Result := FInvisibleBGColorString;
End;

Procedure TWxCustomButton.SetBGColor(strValue: String);
Begin
    FInvisibleBGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Color := defaultBGColor
    Else
        self.Color := GetColorFromString(strValue);
End;

Procedure TWxCustomButton.SetProxyFGColorString(Value: String);
Begin
    FInvisibleFGColorString := Value;
    self.Color := GetColorFromString(Value);
End;

Procedure TWxCustomButton.SetProxyBGColorString(Value: String);
Begin
    FInvisibleBGColorString := Value;
    self.Font.Color := GetColorFromString(Value);
End;

Procedure TWxCustomButton.SetButtonBitmap(Value: TPicture);
Begin
    If Not assigned(Value) Then
        exit;
    self.Glyph.Assign(Value.Bitmap);
End;

Function TWxCustomButton.GetBitmapCount: Integer;
Begin
    Result := 1;
End;

Function TWxCustomButton.GetBitmap(Idx: Integer; Var bmp: TBitmap; Var PropertyName: String): Boolean;
Begin
    bmp := Wx_Bitmap.Bitmap;
    PropertyName := Name;
    Result := True;
End;

Function TWxCustomButton.GetPropertyName(Idx: Integer): String;
Begin
    Result := Name;
End;


Function TWxCustomButton.GetGraphicFileName: String;
Begin
    Result := Wx_Filename;
End;

Function TWxCustomButton.SetGraphicFileName(strFileName: String): Boolean;
Begin

 // If no filename passed, then auto-generate XPM filename
    If (strFileName = '') Then
        strFileName := GetDesignerFormName(self) + '_' + self.Name + '_XPM.xpm';

    Wx_Filename := CreateGraphicFileName(strFileName);
    Result := True;

End;

Function TWxCustomButton.GetValidatorString: TWxValidatorString;
Begin
    Result := FWx_ProxyValidatorString;
    Result.FstrValidatorValue := Wx_Validator;
End;

Procedure TWxCustomButton.SetValidatorString(Value: TWxValidatorString);
Begin
    FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
    Wx_Validator := Value.FstrValidatorValue;
End;

Function TWxCustomButton.GetValidator: String;
Begin
    Result := Wx_Validator;
End;

Procedure TWxCustomButton.SetValidator(value: String);
Begin
    Wx_Validator := value;
End;


Function TWxCustomButton.GetCustomButtonStyle(Wx_ButtonStyle: TWxCBtnStyleSubItem): String;
Begin
    Result := '';
    If Wx_ButtonStyle = wxCUSTBUT_NOTOGGLE Then
    Begin
        Result := 'wxCUSTBUT_NOTOGGLE';
        exit;
    End;
    If Wx_ButtonStyle = wxCUSTBUT_BUTTON Then
    Begin
        Result := 'wxCUSTBUT_BUTTON';
        exit;
    End;
    If Wx_ButtonStyle = wxCUSTBUT_TOGGLE Then
    Begin
        Result := 'wxCUSTBUT_TOGGLE';
        exit;
    End;
    If Wx_ButtonStyle = wxCUSTBUT_BUT_DCLICK_TOG Then
    Begin
        Result := 'wxCUSTBUT_BUT_DCLICK_TOG';
        exit;
    End;
    If Wx_ButtonStyle = wxCUSTBUT_TOG_DCLICK_BUT Then
    Begin
        Result := 'wxCUSTBUT_TOG_DCLICK_BUT';
        exit;
    End;
End;

Function TWxCustomButton.GetCustomButtonDwgStyle(Wx_ButtonDwgStyle: TWxCBtnDwgStyleSubSet): String;
Begin
    Result := '';

    If wxCUSTBUT_FLAT In Wx_ButtonDwgStyle Then
        Result := 'wxCUSTBUT_FLAT';

End;

Function TWxCustomButton.GetCustomButtonPosStyle(Wx_ButtonPosStyle: TWxCBtnPosStyleSubItem): String;
Begin
    Result := '';
    If Wx_ButtonPosStyle = wxCUSTBUT_LEFT Then
    Begin
        Result := 'wxCUSTBUT_LEFT';
        Self.Layout := blGlyphRight;
        exit;
    End;
    If Wx_ButtonPosStyle = wxCUSTBUT_RIGHT Then
    Begin
        Result := 'wxCUSTBUT_RIGHT';
        Self.Layout := blGlyphLeft;
        exit;
    End;
    If Wx_ButtonPosStyle = wxCUSTBUT_TOP Then
    Begin
        Result := 'wxCUSTBUT_TOP';
        Self.Layout := blGlyphBottom;
        exit;
    End;
    If Wx_ButtonPosStyle = wxCUSTBUT_BOTTOM Then
    Begin
        Result := 'wxCUSTBUT_BOTTOM';
        Self.Layout := blGlyphTop;
        exit;
    End;

End;

Function TWxCustomButton.GetCustomButtonSpecificStyle(): String;
Var
    strA: String;
Begin
    Result := GetCustomButtonStyle(self.Wx_ButtonStyle) + ' | ' + GetCustomButtonPosStyle(self.Wx_ButtonPosStyle);
    strA := trim(GetCustomButtonDwgStyle(self.Wx_ButtonDwgStyle));
    If strA <> '' Then
        Result := Result + ' | ' + strA;

End;

Function TWxCustomButton.PreserveFormat: Boolean;
Begin
    Result := KeepFormat;
End;

End.
