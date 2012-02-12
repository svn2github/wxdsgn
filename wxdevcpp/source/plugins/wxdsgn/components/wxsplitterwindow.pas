 { ****************************************************************** }
 {                                                                    }
{ $Id: wxsplitterwindow.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
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

Unit WxSplitterWindow;

Interface

Uses WinTypes, WinProcs, Messages, Classes, Controls,
    Forms, Graphics, ExtCtrls, WxUtils, WxSizerPanel, WxAuiNotebookPage, wxAuiToolBar;

Type
    TWxSplitterWindow = Class(TPanel, IWxComponentInterface, IWxWindowInterface,
        IWxContainerInterface, IWxContainerAndSizerInterface, IWxSplitterInterface)
    Private
        FOrientation: TWxSizerOrientation;
        FSpaceValue: Integer;
        FWx_Class: String;
        FWx_ControlOrientation: TWxControlOrientation;
        FWx_EventList: TStringList;
        FWx_IDName: String;
        FWx_IDValue: Integer;
        FWx_StretchFactor: Integer;
        FWx_Border: Integer;
        FWx_PropertyList: TStringList;
        FInvisibleBGColorString: String;
        FInvisibleFGColorString: String;
        FWx_GeneralStyle: TWxStdStyleSet;
        FWx_SplitterStyle: TWxSplitterWinStyleSet;
        FWx_Comments: TStrings;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;

        FEVT_SPLITTER_SASH_POS_CHANGING: String;
        FEVT_SPLITTER_SASH_POS_CHANGED: String;
        FEVT_SPLITTER_UNSPLIT: String;
        FEVT_SPLITTER_DCLICK: String;
        FEVT_UPDATE_UI: String;
        FWx_SashPosition: Integer;

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


        Procedure AutoInitialize;
        Procedure AutoDestroy;
   // procedure SetWx_EventList(Value: TStringList);

    Protected
        Procedure Click; Override;
        Procedure KeyPress(Var Key: Char); Override;
        Procedure Resize; Override;
        Procedure Loaded; Override;
        Procedure WMPaint(Var Message: TWMPaint); Message WM_PAINT;

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

        Function GenerateLastCreationCode: String;

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

    Published
        Property OnClick;
        Property OnDblClick;
        Property OnDragDrop;
        Property OnEnter;
        Property OnExit;
        Property OnKeyDown;
        Property OnKeyPress;
        Property OnKeyUp;
        Property OnMouseDown;
        Property OnMouseMove;
        Property OnMouseUp;
        Property OnResize;
        Property EVT_SPLITTER_SASH_POS_CHANGING: String
            Read FEVT_SPLITTER_SASH_POS_CHANGING Write FEVT_SPLITTER_SASH_POS_CHANGING;
        Property EVT_SPLITTER_SASH_POS_CHANGED: String
            Read FEVT_SPLITTER_SASH_POS_CHANGED Write FEVT_SPLITTER_SASH_POS_CHANGED;
        Property EVT_SPLITTER_UNSPLIT: String Read FEVT_SPLITTER_UNSPLIT
            Write FEVT_SPLITTER_UNSPLIT;
        Property EVT_SPLITTER_DCLICK: String Read FEVT_SPLITTER_DCLICK
            Write FEVT_SPLITTER_DCLICK;
        Property EVT_UPDATE_UI: String Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
        Property Orientation: TWxSizerOrientation
            Read FOrientation Write FOrientation Default wxHorizontal;
        Property SpaceValue: Integer Read FSpaceValue Write FSpaceValue Default 5;
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_ControlOrientation: TWxControlOrientation
            Read FWx_ControlOrientation Write FWx_ControlOrientation;
        Property Wx_EventList: TStringList Read FWx_EventList Write FWx_EventList;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue Default -1;
        Property Wx_SashPosition: Integer Read FWx_SashPosition Write FWx_SashPosition;
        Property Wx_GeneralStyle: TWxStdStyleSet
            Read FWx_GeneralStyle Write FWx_GeneralStyle;
        Property Wx_SplitterStyle: TWxSplitterWinStyleSet
            Read FWx_SplitterStyle Write FWx_SplitterStyle;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;

        Property InvisibleBGColorString: String Read FInvisibleBGColorString Write FInvisibleBGColorString;
        Property InvisibleFGColorString: String Read FInvisibleFGColorString Write FInvisibleFGColorString;

        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

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
Uses
    SysUtils;

Procedure Register;
Begin
    RegisterComponents('wxSplitterWindow', [TWxSplitterWindow]);
End;

Procedure TWxSplitterWindow.AutoInitialize;
Begin
    FWx_EventList := TStringList.Create;
    FWx_Comments := TStringList.Create;
    FWx_PropertyList := TStringList.Create;
    FOrientation := wxHorizontal;
    FSpaceValue := 5;
    FWx_Border := 0;
    FWx_SashPosition := 0;
    FWx_Class := 'wxSplitterWindow';
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_IDValue := -1;
End; { of AutoInitialize }

Procedure TWxSplitterWindow.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_EventList.Destroy;
    FWx_Comments.Destroy;
End; { of AutoDestroy }

Procedure TWxSplitterWindow.Click;
Begin
    Inherited Click;
End;

Procedure TWxSplitterWindow.KeyPress(Var Key: Char);
Const
    TabKey = Char(VK_TAB);
    EnterKey = Char(VK_RETURN);
Begin
    Inherited KeyPress(Key);
End;

Procedure TWxSplitterWindow.Resize;
Begin
    Inherited Resize;
End;

Constructor TWxSplitterWindow.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);
    AutoInitialize;

    PopulateGenericProperties(FWx_PropertyList);
    PopulateAuiGenericProperties(FWx_PropertyList);

    FWx_PropertyList.add('Wx_SplitterStyle : Splitter Window Styles');
    FWx_PropertyList.add('wxSP_3D:wxSP_3D');
    FWx_PropertyList.add('wxSP_3DSASH:wxSP_3DSASH');
    FWx_PropertyList.add('wxSP_3DBORDER:wxSP_3DBORDER');
    FWx_PropertyList.add('wxSP_BORDER :wxSP_BORDER');
    FWx_PropertyList.add('wxSP_NOBORDER:wxSP_NOBORDER');
    FWx_PropertyList.add('wxSP_NO_XP_THEME:wxSP_NO_XP_THEME');
    FWx_PropertyList.add('wxSP_PERMIT_UNSPLIT:wxSP_PERMIT_UNSPLIT');
    FWx_PropertyList.add('wxSP_LIVE_UPDATE:wxSP_LIVE_UPDATE');
    FWx_PropertyList.add('Orientation:Orientation');
    FWx_PropertyList.add('Wx_SashPosition:Sash Position');

    FWx_EventList.Add('EVT_SPLITTER_SASH_POS_CHANGING : OnSashPosChanging');
    FWx_EventList.Add('EVT_SPLITTER_SASH_POS_CHANGED : OnSashPosChanged');
    FWx_EventList.Add('EVT_SPLITTER_UNSPLIT : OnUnSplit');
    FWx_EventList.Add('EVT_SPLITTER_DCLICK : OnDoubleClick');
    FWx_EventList.Add('EVT_UPDATE_UI : OnUpdateUI');

End;

Destructor TWxSplitterWindow.Destroy;
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


Function TWxSplitterWindow.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxSplitterWindow.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
End;

Function TWxSplitterWindow.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';

    If (XRCGEN) Then
    Begin
        If trim(EVT_SPLITTER_SASH_POS_CHANGING) <> '' Then
            Result := Format('EVT_SPLITTER_SASH_POS_CHANGING(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_SPLITTER_SASH_POS_CHANGING]) + '';

        If trim(EVT_SPLITTER_SASH_POS_CHANGED) <> '' Then
            Result := Format('EVT_SPLITTER_SASH_POS_CHANGED(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_SPLITTER_SASH_POS_CHANGED]) + '';

        If trim(EVT_SPLITTER_DCLICK) <> '' Then
            Result := Format('EVT_SPLITTER_DCLICK(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_SPLITTER_DCLICK]) + '';

        If trim(EVT_SPLITTER_UNSPLIT) <> '' Then
            Result := Format('EVT_SPLITTER_UNSPLIT(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_SPLITTER_UNSPLIT]) + '';

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
    End
    Else
    Begin
        If trim(EVT_SPLITTER_SASH_POS_CHANGING) <> '' Then
            Result := Format('EVT_SPLITTER_SASH_POS_CHANGING(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_SPLITTER_SASH_POS_CHANGING]) + '';

        If trim(EVT_SPLITTER_SASH_POS_CHANGED) <> '' Then
            Result := Format('EVT_SPLITTER_SASH_POS_CHANGED(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_SPLITTER_SASH_POS_CHANGED]) + '';

        If trim(EVT_SPLITTER_DCLICK) <> '' Then
            Result := Format('EVT_SPLITTER_DCLICK(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_SPLITTER_DCLICK]) + '';

        If trim(EVT_SPLITTER_UNSPLIT) <> '' Then
            Result := Format('EVT_SPLITTER_UNSPLIT(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_SPLITTER_UNSPLIT]) + '';

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
    End;
End;

Function TWxSplitterWindow.GenerateXRCControlCreation(IndentString: String): TStringList;
Var
    strOrientation: String;
    i: Integer;
    wxcompInterface: IWxComponentInterface;
    tempstring: TStringList;
Begin

    Result := TStringList.Create;

    Try
        Result.Add(IndentString + Format('<object class="%s" name="%s">',
            [self.Wx_Class, self.Name]));
        Result.Add(IndentString + Format('  <label>%s</label>', [self.Caption]));
        Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
        Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));

        If Not (UseDefaultSize) Then
            Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
        If Not (UseDefaultPos) Then
            Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

        Result.Add(IndentString + Format('  <sashpos>%d</sashpos>', [self.Wx_SashPosition]));
        If Orientation = wxVertical Then
            strOrientation := 'vertical'
        Else
            strOrientation := 'horizontal';
        Result.Add(IndentString + Format('  <orientation>%s</orientation>', [strOrientation]));
        Result.Add(IndentString + Format('  <style>%s</style>',
            [GetSplitterWindowSpecificStyle(self.Wx_GeneralStyle, Wx_SplitterStyle)]));

        For i := 0 To self.ControlCount - 1 Do // Iterate
            If self.Controls[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) Then
        // Only add the XRC control if it is a child of the top-most parent (the form)
        //  If it is a child of a sizer, panel, or other object, then it's XRC code
        //  is created in GenerateXRCControlCreation of that control.
                If (self.Controls[i].GetParentComponent.Name = self.Name) Then
                Begin
                    tempstring := wxcompInterface.GenerateXRCControlCreation('    ' + IndentString);
                    Try
                        Result.AddStrings(tempstring);
                    Finally
                        tempstring.Free;
                    End;
                End; // for

        Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxSplitterWindow.GenerateGUIControlCreation: String;
Var
    strColorStr: String;
    strAlignment: String;
    parentName: String;
    strStyle: String;
Begin
    If FWx_PaneCaption = '' Then
        FWx_PaneCaption := Self.Name;
    If FWx_PaneName = '' Then
        FWx_PaneName := Self.Name + '_Pane';

    parentName := GetWxWidgetParent(self, Wx_AuiManaged);
    strStyle := GetSplitterWindowSpecificStyle(self.Wx_GeneralStyle,
        self.Wx_SplitterStyle);

    If (trim(strStyle) <> '') Then
        strStyle := ', ' + strStyle;

    If (XRCGEN) Then
    Begin//generate xrc loading code
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
            [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);
    End
    Else
    Begin
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = new %s(%s, %s, %s, %s%s);',
            [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
            self.Wx_IDValue),
            GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);
    End;

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
                    self.wx_Border]);
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

Function TWxSplitterWindow.GenerateGUIControlDeclaration: String;
Begin
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxSplitterWindow.GenerateHeaderInclude: String;
Begin
    Result := '#include <wx/splitter.h>';
End;

Function TWxSplitterWindow.GenerateImageInclude: String;
Begin

End;

Function TWxSplitterWindow.GetEventList: TStringList;
Begin
    Result := Wx_EventList;
End;

Function TWxSplitterWindow.GetIDName: String;
Begin
    Result := wx_IDName;
End;

Function TWxSplitterWindow.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxSplitterWindow.GetParameterFromEventName(EventName: String): String;
Begin
    If (EventName = 'EVT_SPLITTER_SASH_POS_CHANGING') Or
        (EventName = 'EVT_SPLITTER_SASH_POS_CHANGED') Or
        (EventName = 'EVT_SPLITTER_UNSPLIT') Or (EventName = 'EVT_SPLITTER_DCLICK') Then
    Begin
        Result := 'wxSplitterEvent& event';
        exit;
    End;

    If EventName = 'EVT_UPDATE_UI' Then
    Begin
        Result := 'wxUpdateUIEvent& event';
        exit;
    End;
End;

Function TWxSplitterWindow.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxSplitterWindow.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxSplitterWindow.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxSplitterWindow.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxSplitterWindow.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxSplitterWindow.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxSplitterWindow.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxSplitterWindow.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxSplitterWindow';
    Result := wx_Class;
End;

Procedure TWxSplitterWindow.Loaded;
Begin
    Inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

End;

Procedure TWxSplitterWindow.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxSplitterWindow.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxSplitterWindow.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxSplitterWindow.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxSplitterWindow.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Procedure TWxSplitterWindow.WMPaint(Var Message: TWMPaint);
Var
    extraHeight: Integer;
    maxWidth, maxHt: Integer;
    totalmaxWidth, totalmaxHt: Integer;
    startX: Integer;
    i: Integer;
    coordTop, coordLeft: Integer;
    wxcompInterface: IWxComponentInterface;
    cntIntf: IWxContainerInterface;
    splitIntf: IWxSplitterInterface;
Begin
  //Make this component look like its parent component by calling its parent's
  //Paint method.
    Caption := '';
    If ControlCount < 1 Then
    Begin
        Inherited;
        Exit;
    End;

    If (ControlCount > 0) And (Wx_SashPosition = 0) Then
        Wx_SashPosition := self.Controls[0].Width;

    totalmaxWidth := 0;
    totalmaxHt := 0;
    maxWidth := 0;
    maxHt := 2 * self.FSpaceValue;

    For i := 0 To self.ControlCount - 1 Do
    Begin
    //Calculate the total size for all children
        If IsControlWxNonVisible(Controls[i]) Then
            Continue;

        totalmaxWidth := totalmaxWidth + self.Controls[i].Width + 2 * self.FSpaceValue;
        totalmaxHt := totalmaxHt + self.Controls[i].Height + 2 * self.FSpaceValue;

        If self.Controls[i].Width > maxWidth Then
            maxWidth := self.Controls[i].Width;

        If self.Controls[i].Height > maxHt Then
            maxHt := self.Controls[i].Height;

    //Set the control orientation
        If self.Controls[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) Then
            If Orientation = wxVertical Then
                wxcompInterface.SaveControlOrientation(wxControlVertical)
            Else
                wxcompInterface.SaveControlOrientation(wxControlHorizontal);
    End;

    If self.Parent Is TForm Then
    Begin
        extraHeight := 0;
        For i := 0 To TForm(self.Parent).ControlCount - 1 Do
            If Parent.Controls[i].ClassName = 'TWxStatusBar' Then
                Inc(extraHeight, Parent.Controls[i].Height);

        If totalmaxWidth < 20 Then
            self.Parent.ClientWidth := 20
        Else
        If self.Orientation = wxHorizontal Then
            self.Parent.ClientWidth := totalmaxWidth + self.FSpaceValue + self.FSpaceValue
        Else
            self.Parent.ClientWidth := maxWidth + self.FSpaceValue + self.FSpaceValue + self.FSpaceValue;

        If totalmaxht < 20 Then
            self.Parent.ClientHeight := 20 + extraHeight
        Else
        If self.Orientation = wxVertical Then
            If maxht + 2 * self.FSpaceValue < 35 Then
                self.Parent.ClientHeight := 35 + extraHeight
            Else
                self.Parent.ClientHeight := totalmaxht + self.FSpaceValue + self.FSpaceValue + extraHeight
        Else
            self.Parent.ClientHeight := maxht + self.FSpaceValue + self.FSpaceValue + extraHeight;
        self.Align := alClient;
    End
    Else
    Begin
        If self.parent.GetInterface(IDD_IWxContainerInterface, cntIntf) Then
            If self.parent.GetInterface(IID_IWxSplitterInterface, splitIntf) Then
                self.Align := alNone
            Else
                self.Align := alClient
        Else
            self.Align := alNone;

        If self.Orientation = wxVertical Then
        Begin
            If maxHt * self.ControlCount + self.ControlCount * 2 * self.FSpaceValue = 0 Then
                self.Height := 4 * self.FSpaceValue
            Else
                self.Height := totalmaxHt;
            self.Width := maxWidth + 2 * self.FSpaceValue;
        End
        Else
        Begin
            If maxWidth = 0 Then
                self.Width := 4 * self.FSpaceValue
            Else
                self.Width := totalmaxWidth + 2 * self.FSpaceValue;
            self.Height := maxHt + 2 * self.FSpaceValue;
        End;
    End;

    startX := FSpaceValue;

    If Orientation = wxHorizontal Then
        For i := 0 To self.ControlCount - 1 Do
        Begin
            If IsControlWxNonVisible(Controls[i]) Then
                continue;

            coordTop := maxHt + 2 * FSpaceValue - self.Controls[i].Height;
            self.Controls[i].Top := coordTop Div 2;
            self.Controls[i].left := startX;
            startX := startX + self.Controls[i].Width + FSpaceValue + FSpaceValue;
        End
    Else
        For i := 0 To self.ControlCount - 1 Do
        Begin
            If IsControlWxNonVisible(Controls[i]) Then
                continue;

            coordLeft := maxWidth + 2 * FSpaceValue - self.Controls[i].Width;
            self.Controls[i].left := coordLeft Div 2;
            self.Controls[i].Top := startX;
            startX := startX + self.Controls[i].Height + FSpaceValue + self.FSpaceValue;
        End;


{  //if self.parent.GetInterface(IDD_IWxContainerInterface,cntIntf) then
  begin
    if Self.Height > parent.Height then
      parent.Height := Self.Height;

    if Self.Width > parent.Width then
      parent.Width := Self.Width;
  end;}

    Inherited;
End;

Function TWxSplitterWindow.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxSplitterWindow.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxSplitterWindow.GetFGColor: String;
Begin
End;

Procedure TWxSplitterWindow.SetFGColor(strValue: String);
Begin
End;

Function TWxSplitterWindow.GetBGColor: String;
Begin
End;

Procedure TWxSplitterWindow.SetBGColor(strValue: String);
Begin
End;

Function TWxSplitterWindow.GenerateLastCreationCode: String;
Var
    strFirstControl, strSecondControl, strOrientation: String;

    Function GenerateParentSizerCode: String;
    Begin

    End;

Begin
    Result := GenerateParentSizerCode;
    If self.ControlCount = 0 Then
        exit;

    If self.ControlCount > 0 Then
        strFirstControl := self.Controls[0].Name;

    If self.ControlCount > 1 Then
        strSecondControl := self.Controls[1].Name;

    strOrientation := 'SplitHorizontally';
    If self.Orientation = wxVertical Then
        strOrientation := 'SplitHorizontally'
    Else
        strOrientation := 'SplitVertically';

    If Not XRCGEN Then
    Begin
        If self.ControlCount = 1 Then
        Begin
            If Result = '' Then
                Result := Format('%s->Initialize(%s);', [self.Name, strFirstControl])
            Else
                Result := Result + #13 + #10 +
                    Format('%s->Initialize(%s);', [self.Name, strFirstControl]);
            exit;
        End;

        If self.ControlCount > 1 Then
        Begin
            If Result = '' Then
                Result := Format('%s->%s(%s,%s,%d);',
                    [self.Name, strOrientation, strFirstControl, strSecondControl,
                    self.Wx_SashPosition])
            Else
                Result := Result + #13 + #10 + Format('%s->%s(%s,%s,%d);',
                    [self.Name, strOrientation, strFirstControl, strSecondControl,
                    self.Wx_SashPosition]);
            exit;
        End;
    End;//Nuklear Zelph
End;

End.
