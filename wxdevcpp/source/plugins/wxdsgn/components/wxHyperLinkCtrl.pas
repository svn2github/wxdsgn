 { ****************************************************************** }
 {                                                                    }
{ $Id: wxHyperLinkCtrl.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
 {                                                                    }
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

Unit wxHyperLinkCtrl;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, StdCtrls, WxUtils, ExtCtrls, WxAuiToolBar, WxAuiNotebookPage, WxSizerPanel, WxToolBar;

{
*************IMPORTANT*************
If you want to change any of the wxwidgets components,  you have to use comp screate by David Price.
You can download a copy from

http://torry.net/tools/components/compcreation/cc.zip

***IF YOU FOLLOW THIS YOUR UPDATES WONT BE INCLUDED IN THE DISTRIBUTION****
}

Type
    TWxHyperLinkCtrl = Class(TStaticText, IWxComponentInterface, IWxVariableAssignmentInterface)
    Private
    { Private fields of TWxHyperLinkCtrl }
    { Storage for property Wx_BGColor }
        FEVT_HYPERLINK: String;
        FWx_BGColor: TColor;
    { Storage for property Wx_Border }
        FWx_Border: Integer;
    { Storage for property Wx_Class }
        FWx_Class: String;
    { Storage for property Wx_ControlOrientation }
        FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_Enabled }
        FWx_Enabled: Boolean;
    { Storage for property Wx_FGColor }
        FWx_FGColor: TColor;
    { Storage for property Wx_GeneralStyle }
        FWx_GeneralStyle: TWxStdStyleSet;
    { Storage for property Wx_HelpText }
        FWx_HelpText: String;
    { Storage for property Wx_Hidden }
        FWx_Hidden: Boolean;

        FWx_URL: String;

    { Storage for property Wx_IDName }
        FWx_IDName: String;
    { Storage for property Wx_IDValue }
        FWx_IDValue: Integer;
        FWx_HyperLinkStyle: TWxHyperLnkStyleSet;
    { Storage for property Wx_ProxyBGColorString }
        FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
        FWx_ProxyFGColorString: TWxColorString;

        FWx_ProxyHoverColorString: TWxColorString;
        FWx_ProxyNormalColorString: TWxColorString;
        FWx_ProxyVisitedColorString: TWxColorString;

    { Storage for property Wx_StretchFactor }
        FWx_StretchFactor: Integer;
    { Storage for property Wx_ToolTip }
        FWx_ToolTip: String;
        FWx_EventList: TStringList;
        FWx_PropertyList: TStringList;
        FInvisibleBGColorString: String;
        FInvisibleFGColorString: String;

        FInvisibleHoverColorString: String;
        FInvisibleNormalColorString: String;
        FInvisibleVisitedColorString: String;

        FWx_Comments: TStrings;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;
        FWx_LHSValue: String;
        FWx_RHSValue: String;
        defaultBGColor: TColor;
        defaultFGColor: TColor;

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

    { Private methods of TWxHyperLinkCtrl }
    { Method to set variable and property values and create objects }
        Procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
        Procedure AutoDestroy;
        Procedure WMSize(Var Message: TWMSize); Message WM_SIZE;

    Protected
    { Protected fields of TWxHyperLinkCtrl }

    { Protected methods of TWxHyperLinkCtrl }
        Procedure Click; Override;
        Procedure Loaded; Override;

    Published
    { Public fields and properties of TWxHyperLinkCtrl }

    { Public methods of TWxHyperLinkCtrl }
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Function GenerateControlIDs: String;
        Function GenerateEnumControlIDs: String; Virtual;
        Function GenerateEventTableEntries(CurrClassName: String): String; Virtual;
        Function GenerateGUIControlCreation: String; Virtual;
        Function GenerateXRCControlCreation(IndentString: String): TStringList;
        Function GenerateGUIControlDeclaration: String; Virtual;
        Function GenerateHeaderInclude: String; Virtual;
        Function GenerateImageInclude: String;
        Function GetEventList: TStringList;
        Function GetIDName: String;
        Function GetIDValue: Integer;
        Function GetParameterFromEventName(EventName: String): String;
        Function GetPropertyList: TStringList; Virtual;
        Function GetTypeFromEventName(EventName: String): String;
        Function GetWxClassName: String; Virtual;
        Procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
        Procedure SetIDName(IDName: String);
        Procedure SetIDValue(IDValue: Integer);
        Procedure SetWxClassName(wxClassName: String);

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

        Function GetGenericColor(strVariableName: String): String;
        Procedure SetGenericColor(strVariableName, strValue: String);

        Function GetFGColor: String;
        Procedure SetFGColor(strValue: String);
        Function GetBGColor: String;
        Procedure SetBGColor(strValue: String);

        Procedure SetProxyFGColorString(Value: String);
        Procedure SetProxyBGColorString(Value: String);

        Function GetLHSVariableAssignment: String;
        Function GetRHSVariableAssignment: String;

    Published
    { Published properties of TWxHyperLinkCtrl }
        Property OnClick;
        Property OnDblClick;
        Property OnDragDrop;
        Property OnMouseDown;
        Property OnMouseMove;
        Property OnMouseUp;
        Property EVT_HYPERLINK: String Read FEVT_HYPERLINK Write FEVT_HYPERLINK;
        Property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_ControlOrientation: TWxControlOrientation
            Read FWx_ControlOrientation Write FWx_ControlOrientation;
        Property Wx_Enabled: Boolean Read FWx_Enabled Write FWx_Enabled Default True;
        Property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
        Property Wx_GeneralStyle: TWxStdStyleSet
            Read FWx_GeneralStyle Write FWx_GeneralStyle;
        Property Wx_HelpText: String Read FWx_HelpText Write FWx_HelpText;
        Property Wx_Hidden: Boolean Read FWx_Hidden Write FWx_Hidden;
        Property Wx_URL: String Read FWx_URL Write FWx_URL;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue Default -1;
        Property Wx_HyperLinkStyle: TWxHyperLnkStyleSet Read FWx_HyperLinkStyle Write FWx_HyperLinkStyle;
        Property Wx_ToolTip: String Read FWx_ToolTip Write FWx_ToolTip;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;

        Property InvisibleBGColorString: String Read FInvisibleBGColorString Write FInvisibleBGColorString;
        Property InvisibleFGColorString: String Read FInvisibleFGColorString Write FInvisibleFGColorString;

        Property InvisibleHoverColorString: String Read FInvisibleHoverColorString Write FInvisibleHoverColorString;
        Property InvisibleNormalColorString: String Read FInvisibleNormalColorString Write FInvisibleNormalColorString;
        Property InvisibleVisitedColorString: String Read FInvisibleVisitedColorString Write FInvisibleVisitedColorString;
        Property Wx_ProxyHoverColorString: TWxColorString Read FWx_ProxyHoverColorString Write FWx_ProxyHoverColorString;
        Property Wx_ProxyNormalColorString: TWxColorString Read FWx_ProxyNormalColorString Write FWx_ProxyNormalColorString;
        Property Wx_ProxyVisitedColorString: TWxColorString Read FWx_ProxyVisitedColorString Write FWx_ProxyVisitedColorString;

        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
        Property Wx_LHSValue: String Read FWx_LHSValue Write FWx_LHSValue;
        Property Wx_RHSValue: String Read FWx_RHSValue Write FWx_RHSValue;

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
    RegisterComponents('wxWidgets', [TWxHyperLinkCtrl]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxHyperLinkCtrl.AutoInitialize;
Begin
    FWx_EventList := TStringList.Create;
    FWx_PropertyList := TStringList.Create;
    FWx_Comments := TStringList.Create;
    FWx_Border := 5;
    FWx_Class := 'wxHyperlinkCtrl';
    FWx_URL := 'http://wxdsgn.sf.net';
    FWx_Enabled := True;
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_IDValue := -1;
    FWx_StretchFactor := 0;
    FWx_HyperLinkStyle := [wxHL_CONTEXTMENU, wxHL_ALIGN_CENTRE];
    FWx_GeneralStyle := [wxNO_BORDER];
    FWx_ProxyBGColorString := TWxColorString.Create;
    FWx_ProxyFGColorString := TWxColorString.Create;
    FWx_ProxyHoverColorString := TWxColorString.Create;
    FWx_ProxyNormalColorString := TWxColorString.Create;
    FWx_ProxyVisitedColorString := TWxColorString.Create;

    InvisibleFGColorString := 'STD:wxBLUE';
    defaultBGColor := clBtnFace;;
    self.Font.Color := clBlue;
    defaultFGColor := self.font.color;

    AutoSize := True;
    Font.Style := Font.Style + [fsUnderline];
    Fwx_HyperLinkStyle := [wxHL_CONTEXTMENU];
    FWx_GeneralStyle := [wxNO_BORDER];
End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxHyperLinkCtrl.AutoDestroy;
Begin
    FWx_EventList.Destroy;
    FWx_PropertyList.Destroy;
    FWx_ProxyBGColorString.Destroy;
    FWx_ProxyFGColorString.Destroy;
    FWx_ProxyHoverColorString.Destroy;
    FWx_ProxyNormalColorString.Destroy;
    FWx_ProxyVisitedColorString.Destroy;

    FWx_Comments.Destroy;
End; { of AutoDestroy }

{ Override OnClick handler from TStaticText,IWxComponentInterface }
Procedure TWxHyperLinkCtrl.Click;
Begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
    Inherited Click;

     { Code to execute after click behavior
       of parent }

End;

Constructor TWxHyperLinkCtrl.Create(AOwner: TComponent);
Begin

  { Call the Create method of the parent class }
    Inherited Create(AOwner);
  { AutoInitialize sets the initial values of variables and      }
  { properties; also, it creates objects for properties of       }
  { standard Delphi object types (e.g., TFont, TTimer,           }
  { TPicture) and for any variables marked as objects.           }
  { AutoInitialize method is generated by Component Create.      }
    AutoInitialize;

  { Code to perform other tasks when the component is created }
    PopulateGenericProperties(FWx_PropertyList);
    PopulateAuiGenericProperties(FWx_PropertyList);

    FWx_PropertyList.add('Wx_ProxyFGColorString:Normal Color');
    FWx_PropertyList.add('Wx_ProxyHoverColorString:Hover Color');
    FWx_PropertyList.add('Wx_ProxyVisitedColorString:Visited Color');

    FWx_PropertyList.add('wx_HyperLinkStyle:HyperLink Style');
    FWx_PropertyList.add('wxHL_ALIGN_LEFT:wxHL_ALIGN_LEFT');
    FWx_PropertyList.add('wxHL_ALIGN_RIGHT:wxHL_ALIGN_RIGHT');
    FWx_PropertyList.add('wxHL_ALIGN_CENTRE:wxHL_ALIGN_CENTRE');
    FWx_PropertyList.Add('wxHL_CONTEXTMENU:wxHL_CONTEXTMENU');
    FWx_PropertyList.add('Caption:Label');
    FWx_PropertyList.add('Wx_LHSValue   : LHS Variable');
    FWx_PropertyList.add('Wx_RHSValue   : RHS Variable');

    FWx_EventList.add('EVT_HYPERLINK:OnHyperLink');

End;

Destructor TWxHyperLinkCtrl.Destroy;
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

Function TWxHyperLinkCtrl.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxHyperLinkCtrl.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
End;

Function TWxHyperLinkCtrl.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';

    If (XRCGEN) Then
    Begin//generate xrc loading code  needs to be edited
        If trim(EVT_HYPERLINK) <> '' Then
            Result := Format('EVT_HYPERLINK(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_HYPERLINK]) + '';
    End
    Else
    Begin//generate the cpp code
        If trim(EVT_HYPERLINK) <> '' Then
            Result := Format('EVT_HYPERLINK(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_HYPERLINK]) + '';
    End;
End;

Function TWxHyperLinkCtrl.GenerateXRCControlCreation(IndentString: String): TStringList;
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

        Result.Add(IndentString + Format('  <style>%s</style>',
            [GetHyperLnkSpecificStyle(Wx_GeneralStyle, Wx_HyperLinkStyle)]));
        Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxHyperLinkCtrl.GenerateGUIControlCreation: String;
Var
    strSize: String;
    strColorStr: String;
    strStyle, parentName, strAlignment: String;
Begin
    Result := '';
    If FWx_PaneCaption = '' Then
        FWx_PaneCaption := Self.Name;
    If FWx_PaneName = '' Then
        FWx_PaneName := Self.Name + '_Pane';

    parentName := GetWxWidgetParent(self, Wx_AuiManaged);


  //Determine whether we should just use wxDefaultSize
    strSize := Format('%s', [GetWxSize(self.Width, self.Height)]);

  //Set the static text style
    strStyle := GetHyperLnkSpecificStyle(Wx_GeneralStyle, Wx_HyperLinkStyle);
    If trim(strStyle) = '' Then
        strStyle := '0';
    strStyle := ', ' + strStyle + ', ' + GetCppString(Name);

    If (XRCGEN) Then
    Begin//generate xrc loading code
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
            [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);
    End
    Else
    Begin//generate the cpp code
  //Last comma is removed because it depends on the user selection of the properties.
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = new %s(%s, %s, %s, %s, %s, %s%s);',
            [self.Name, self.Wx_Class, ParentName, GetWxIDString(self.Wx_IDName,
            self.Wx_IDValue),
            GetCppString(self.Caption), GetCppString(wx_URL), GetWxPosition(self.Left, self.Top), strSize, strStyle]);
    End;// end of if xrc
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

  //strColorStr := trim(GetwxColorFromString(InvisibleFGColorString));
  //if strColorStr <> '' then
  //  Result := Result + #13 + Format('%s->SetForegroundColour(%s);',
  //      [self.Name, strColorStr]);

  //strColorStr := trim(GetwxColorFromString(InvisibleBGColorString));
  //if strColorStr <> '' then
  //  Result := Result + #13 + Format('%s->SetBackgroundColour(%s);',[self.Name, strColorStr]);

    strColorStr := trim(GetwxColorFromString(InvisibleHoverColorString));
    If strColorStr <> '' Then
        Result := Result + #13 + Format('%s->SetHoverColour(%s);', [self.Name, strColorStr]);

    strColorStr := trim(GetwxColorFromString(InvisibleFGColorString));
    If strColorStr <> '' Then
        Result := Result + #13 + Format('%s->SetNormalColour(%s);', [self.Name, strColorStr]);

    strColorStr := trim(GetwxColorFromString(InvisibleVisitedColorString));
    If strColorStr <> '' Then
        Result := Result + #13 + Format('%s->SetVisitedColour(%s);', [self.Name, strColorStr]);


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

            If (self.Parent Is TWxAuiToolBar) Or (self.Parent Is TWxToolBar) Then
                Result := Result + #13 + Format('%s->AddControl(%s);',
                    [self.Parent.Name, self.Name]);
        End;
    End;

  // Change the text justification in the form designer
    If wxHL_ALIGN_LEFT In Wx_HyperLinkStyle Then
        self.Alignment := taLeftJustify;

    If wxHL_ALIGN_CENTRE In Wx_HyperLinkStyle Then
        self.Alignment := taCenter;

    If wxHL_ALIGN_RIGHT In Wx_HyperLinkStyle Then
        self.Alignment := taRightJustify;

    self.AutoSize := False;
    self.Repaint;

End;

Function TWxHyperLinkCtrl.GenerateGUIControlDeclaration: String;
Begin
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxHyperLinkCtrl.GenerateHeaderInclude: String;
Begin
    Result := '#include <wx/hyperlink.h>';
End;

Function TWxHyperLinkCtrl.GenerateImageInclude: String;
Begin

End;

Function TWxHyperLinkCtrl.GetEventList: TStringList;
Begin
    Result := FWx_EventList;
End;

Function TWxHyperLinkCtrl.GetIDName: String;
Begin
    Result := wx_IDName;
End;

Function TWxHyperLinkCtrl.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxHyperLinkCtrl.GetParameterFromEventName(EventName: String): String;
Begin
    Result := '';
    If EventName = 'EVT_HYPERLINK' Then
    Begin
        Result := 'wxHyperlinkEvent& event' + '';
        exit;
    End;

End;

Function TWxHyperLinkCtrl.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxHyperLinkCtrl.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxHyperLinkCtrl.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxHyperLinkCtrl.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxHyperlinkCtrl';
    Result := wx_Class;
End;

Function TWxHyperLinkCtrl.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxHyperLinkCtrl.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxHyperLinkCtrl.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxHyperLinkCtrl.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Procedure TWxHyperLinkCtrl.Loaded;
Begin
    Inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

End;

Procedure TWxHyperLinkCtrl.SaveControlOrientation(ControlOrientation:
    TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxHyperLinkCtrl.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxHyperLinkCtrl.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxHyperLinkCtrl.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxHyperLinkCtrl.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Procedure TWxHyperLinkCtrl.WMSize(Var Message: TWMSize);
Var
    W, H: Integer;
Begin
    Inherited;

  //Copy the new width and height of the component so we can use SetBounds to
  //change both at once
    W := Width;
    H := Height;

  //Update the component size if we adjusted W or H
    If (W <> Width) Or (H <> Height) Then
        Inherited SetBounds(Left, Top, W, H);

    Message.Result := 0;
End;

Function TWxHyperLinkCtrl.GetGenericColor(strVariableName: String): String;
Begin
    Result := '';
    If UpperCase(strVariableName) = UpperCase('Wx_ProxyHoverColorString') Then
        Result := FInvisibleHoverColorString
    Else
    If UpperCase(strVariableName) = UpperCase('Wx_ProxyNormalColorString') Then
        Result := FInvisibleNormalColorString
    Else
    If UpperCase(strVariableName) = UpperCase('Wx_ProxyVisitedColorString') Then
        Result := FInvisibleVisitedColorString;
End;

Procedure TWxHyperLinkCtrl.SetGenericColor(strVariableName, strValue: String);
Begin
    If UpperCase(strVariableName) = UpperCase('Wx_ProxyHoverColorString') Then
        FInvisibleHoverColorString := strValue
    Else
    If UpperCase(strVariableName) = UpperCase('Wx_ProxyNormalColorString') Then
        FInvisibleNormalColorString := strValue
    Else
    If UpperCase(strVariableName) = UpperCase('Wx_ProxyVisitedColorString') Then
        FInvisibleVisitedColorString := strValue;
End;

Function TWxHyperLinkCtrl.GetFGColor: String;
Begin
    Result := FInvisibleFGColorString;
End;

Procedure TWxHyperLinkCtrl.SetFGColor(strValue: String);
Begin
    FInvisibleFGColorString := strValue;

    If IsDefaultColorStr(strValue) Then
        self.Font.Color := defaultFGColor
    Else
        self.Font.Color := GetColorFromString(strValue);
End;

Function TWxHyperLinkCtrl.GetBGColor: String;
Begin
    Result := FInvisibleBGColorString;
End;

Procedure TWxHyperLinkCtrl.SetBGColor(strValue: String);
Begin
    FInvisibleBGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Color := defaultBGColor
    Else
        self.Color := GetColorFromString(strValue);
End;

Procedure TWxHyperLinkCtrl.SetProxyFGColorString(Value: String);
Begin
    FInvisibleFGColorString := Value;
    self.Color := GetColorFromString(Value);
End;

Procedure TWxHyperLinkCtrl.SetProxyBGColorString(Value: String);
Begin
    FInvisibleBGColorString := Value;
    self.Font.Color := GetColorFromString(Value);
End;

Function TWxHyperLinkCtrl.GetLHSVariableAssignment: String;
Begin
    Result := '';
    If trim(Wx_LHSValue) = '' Then
        exit;
    Result := Format('%s = %s->GetValue();', [Wx_LHSValue, self.Name]);
End;

Function TWxHyperLinkCtrl.GetRHSVariableAssignment: String;
Begin
    Result := '';
    If trim(Wx_RHSValue) = '' Then
        exit;
    Result := Format('%s->SetValue(%s);', [self.Name, Wx_RHSValue]);
End;


End.
