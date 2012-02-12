 { ****************************************************************** }
 {                                                                    }
{ $Id: wxCalendarCtrl.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
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

Unit wxCalendarCtrl;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, ExtCtrls, WxUtils, wxCalendarBase, WxAuiToolBar, WxAuiNotebookPage, WxSizerPanel;

Type
    TWxCalendarCtrl = Class(TrmCustomCalendar, IWxComponentInterface, IWxControlPanelInterface)
    Private
    { Private fields of TWxCalendarCtrl }
    {Property Listing}
        FWx_BKColor: TColor;
        FWx_Border: Integer;
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
        FWx_PropertyList: TStringList;
        FInvisibleBGColorString: String;
        FInvisibleFGColorString: String;
        FWx_Comments: TStrings;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;
        FWx_Calctrlstyle: TWxcalctrlStyleSet;
        FWx_SelectedDate: TDateTime;
    {Event Lisiting}
        FEVT_UPDATE_UI: String;
        FEVT_CALENDAR_SEL_CHANGED: String;
        FEVT_CALENDAR_DAY: String;
        FEVT_CALENDAR_MONTH: String;
        FEVT_CALENDAR_YEAR: String;
        FEVT_CALENDAR_WEEKDAY_CLICKED: String;

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

    { Private methods of TWxCalendarCtrl }
        Procedure AutoInitialize;
        Procedure AutoDestroy;

    Protected
    { Protected fields of TWxCalendarCtrl }

    { Protected methods of TWxCalendarCtrl }


    Public
    { Public fields and properties of TWxCalendarCtrl }
        defaultBGColor: TColor;
        defaultFGColor: TColor;

    { Public methods of TWxCalendarCtrl }
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Procedure Paint; Override;
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
        Function GenerateLastCreationCode: String;

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

        Function GetSelectedDate: TDateTime;
        Procedure SetSelectedDate(Value: TDateTime);

    Published
    { Published properties of TWxCalendarCtrl }
        Property EVT_UPDATE_UI: String Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
        Property EVT_CALENDAR_SEL_CHANGED: String Read FEVT_CALENDAR_SEL_CHANGED Write FEVT_CALENDAR_SEL_CHANGED;
        Property EVT_CALENDAR_DAY: String Read FEVT_CALENDAR_DAY Write FEVT_CALENDAR_DAY;
        Property EVT_CALENDAR_MONTH: String Read FEVT_CALENDAR_MONTH Write FEVT_CALENDAR_MONTH;
        Property EVT_CALENDAR_YEAR: String Read FEVT_CALENDAR_YEAR Write FEVT_CALENDAR_YEAR;
        Property EVT_CALENDAR_WEEKDAY_CLICKED: String Read FEVT_CALENDAR_WEEKDAY_CLICKED Write FEVT_CALENDAR_WEEKDAY_CLICKED;

        Property WxCalCtrlstyle: TWxcalctrlStyleSet Read FWx_Calctrlstyle Write FWx_Calctrlstyle;
        Property WxSelectedDate: TDateTime Read GetSelectedDate Write SetSelectedDate;

        Property Wx_BKColor: TColor Read FWx_BKColor Write FWx_BKColor;
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_ControlOrientation: TWxControlOrientation
            Read FWx_ControlOrientation Write FWx_ControlOrientation;
        Property Wx_Default: Boolean Read FWx_Default Write FWx_Default;
        Property Wx_Enabled: Boolean Read FWx_Enabled Write FWx_Enabled Default True;
        Property Wx_EventList: TStringList Read FWx_EventList Write FWx_EventList;
        Property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
        Property Wx_GeneralStyle: TWxStdStyleSet
            Read FWx_GeneralStyle Write FWx_GeneralStyle;
        Property Wx_HelpText: String Read FWx_HelpText Write FWx_HelpText;
        Property Wx_Hidden: Boolean Read FWx_Hidden Write FWx_Hidden;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue Default -1;
        Property Wx_ToolTip: String Read FWx_ToolTip Write FWx_ToolTip;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;

        Property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
        Property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
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

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxCalendarCtrl]);
End;


Procedure TWxCalendarCtrl.AutoInitialize;
Begin
    Caption := '';
    FWx_PropertyList := TStringList.Create;
    FWx_EventList := TStringList.Create;
    FWx_Comments := TStringList.Create;
    FWx_Border := 5;
    FWx_Class := 'wxCalendarCtrl';
    FWx_Enabled := True;
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_IDValue := -1;
    FWx_StretchFactor := 0;
    FWx_ProxyBGColorString := TWxColorString.Create;
    FWx_ProxyFGColorString := TWxColorString.Create;
    defaultBGColor := self.color;
    defaultFGColor := self.font.color;
    ShowGridLines := False;
    ShowWeekends := False;
    FWx_SelectedDate := Now;
    SelectedDate := FWx_SelectedDate;
    FWx_Calctrlstyle := [wxCAL_SUNDAY_FIRST, wxCAL_SHOW_HOLIDAYS, wxCAL_NO_MONTH_CHANGE, wxCAL_SHOW_SURROUNDING_WEEKS, wxCAL_SEQUENTIAL_MONTH_SELECTION];
  //CalendarColors.


End; { of AutoInitialize }


Procedure TWxCalendarCtrl.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_EventList.Destroy;
    FWx_ProxyBGColorString.Destroy;
    FWx_ProxyFGColorString.Destroy;
    FWx_Comments.Destroy;
End; { of AutoDestroy }

Constructor TWxCalendarCtrl.Create(AOwner: TComponent);
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

  { Code to perform other tasks when the container is created    }
    PopulateGenericProperties(FWx_PropertyList);
    PopulateAuiGenericProperties(FWx_PropertyList);

    FWx_PropertyList.Add('WxSelectedDate:Selected Date');
    FWx_PropertyList.Add('WxCalCtrlstyle:Calendar Style');
    FWx_PropertyList.Add('wxCAL_SUNDAY_FIRST:wxCAL_SUNDAY_FIRST');
    FWx_PropertyList.Add('wxCAL_MONDAY_FIRST:wxCAL_MONDAY_FIRST');
    FWx_PropertyList.Add('wxCAL_SHOW_HOLIDAYS:wxCAL_SHOW_HOLIDAYS');
    FWx_PropertyList.Add('wxCAL_NO_YEAR_CHANGE:wxCAL_NO_YEAR_CHANGE');
    FWx_PropertyList.Add('wxCAL_NO_MONTH_CHANGE:wxCAL_NO_MONTH_CHANGE');
    FWx_PropertyList.Add('wxCAL_SHOW_SURROUNDING_WEEKS:wxCAL_SHOW_SURROUNDING_WEEKS');
    FWx_PropertyList.Add('wxCAL_SEQUENTIAL_MONTH_SELECTION:wxCAL_SEQUENTIAL_MONTH_SELECTION');

    FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');
    FWx_EventList.add('EVT_CALENDAR_SEL_CHANGED:OnSelChanged ');
    FWx_EventList.add('EVT_CALENDAR_DAY:OnDay ');
    FWx_EventList.add('EVT_CALENDAR_MONTH:OnMonth ');
    FWx_EventList.add('EVT_CALENDAR_YEAR:OnYear ');
    FWx_EventList.add('EVT_CALENDAR_WEEKDAY_CLICKED:OnWeekDayClicked');

End;

Destructor TWxCalendarCtrl.Destroy;
Begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
    AutoDestroy;

  { Last, free the component by calling the Destroy method of the    }
  { parent class.                                                    }
    Inherited Destroy;
End;

Procedure TWxCalendarCtrl.Paint;
Begin
    self.Caption := '';
     { Make this component look like its parent component by calling
       its parent's Paint method. }
    Inherited Paint;
End;


Function TWxCalendarCtrl.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxCalendarCtrl.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
End;

Function TWxCalendarCtrl.GenerateEventTableEntries(CurrClassName: String): String;
Begin

    Result := '';
    If (XRCGEN) Then
    Begin//generate xrc loading code
        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';

        If trim(EVT_CALENDAR_SEL_CHANGED) <> '' Then
            Result := Result + #13 + Format('EVT_CALENDAR_SEL_CHANGED(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_CALENDAR_SEL_CHANGED]) + '';

        If trim(EVT_CALENDAR_DAY) <> '' Then
            Result := Result + #13 + Format('EVT_CALENDAR_DAY(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_CALENDAR_DAY]) + '';

        If trim(EVT_CALENDAR_MONTH) <> '' Then
            Result := Result + #13 + Format('EVT_CALENDAR_MONTH(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_CALENDAR_MONTH]) + '';

        If trim(EVT_CALENDAR_YEAR) <> '' Then
            Result := Result + #13 + Format('EVT_CALENDAR_YEAR(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_CALENDAR_YEAR]) + '';

        If trim(EVT_CALENDAR_WEEKDAY_CLICKED) <> '' Then
            Result := Result + #13 + Format('EVT_CALENDAR_WEEKDAY_CLICKED(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_CALENDAR_WEEKDAY_CLICKED]) + '';

    End
    Else
    Begin//generate the cpp code
        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

        If trim(EVT_CALENDAR_SEL_CHANGED) <> '' Then
            Result := Result + #13 + Format('EVT_CALENDAR_SEL_CHANGED(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_CALENDAR_SEL_CHANGED]) + '';

        If trim(EVT_CALENDAR_DAY) <> '' Then
            Result := Result + #13 + Format('EVT_CALENDAR_DAY(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_CALENDAR_DAY]) + '';

        If trim(EVT_CALENDAR_MONTH) <> '' Then
            Result := Result + #13 + Format('EVT_CALENDAR_MONTH(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_CALENDAR_MONTH]) + '';

        If trim(EVT_CALENDAR_YEAR) <> '' Then
            Result := Result + #13 + Format('EVT_CALENDAR_YEAR(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_CALENDAR_YEAR]) + '';

        If trim(EVT_CALENDAR_WEEKDAY_CLICKED) <> '' Then
            Result := Result + #13 + Format('EVT_CALENDAR_WEEKDAY_CLICKED(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_CALENDAR_WEEKDAY_CLICKED]) + '';
    End;
End;

Function TWxCalendarCtrl.GenerateXRCControlCreation(IndentString: String): TStringList;
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

        Result.Add(IndentString + Format('  <style>%s</style>',
            [GetStdStyleString(self.Wx_GeneralStyle)]));

        Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxCalendarCtrl.GenerateGUIControlCreation: String;
Var
    strColorStr: String;
    strStyle, parentName, strAlignment: String;
    strDateString: String;
Begin
    Result := '';

    If FWx_PaneCaption = '' Then
        FWx_PaneCaption := Self.Name;
    If FWx_PaneName = '' Then
        FWx_PaneName := Self.Name + '_Pane';

    parentName := GetWxWidgetParent(self, Wx_AuiManaged);
    strDateString := GetDateVariableExpansion(WxSelectedDate);
    strStyle := GetCalendarCtrlSpecificStyle(self.Wx_GeneralStyle, self.WxCalctrlstyle);
    If trim(strStyle) <> '' Then
        strStyle := ', ' + strStyle;

    If (XRCGEN) Then
    Begin//generate xrc loading code
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
            [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);
    End
    Else
    Begin//generate the cpp code
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = new %s(%s, %s, %s,%s, %s%s);',
            [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
            self.Wx_IDValue), strDateString,
            GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);
    End;//end of if xrc
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

Function TWxCalendarCtrl.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
End;

Function TWxCalendarCtrl.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/calctrl.h>';
End;

Function TWxCalendarCtrl.GenerateImageInclude: String;
Begin

End;

Function TWxCalendarCtrl.GetEventList: TStringList;
Begin
    Result := FWx_EventList;
End;

Function TWxCalendarCtrl.GetIDName: String;
Begin
    Result := '';
    Result := wx_IDName;
End;

Function TWxCalendarCtrl.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxCalendarCtrl.GetParameterFromEventName(EventName: String): String;
Begin
    If EventName = 'EVT_UPDATE_UI' Then
    Begin
        Result := 'wxUpdateUIEvent& event';
        exit;
    End;

    If EventName = 'EVT_CALENDAR_SEL_CHANGED' Then
    Begin
        Result := 'wxCalendarEvent& event';
        exit;
    End;

    If EventName = 'EVT_CALENDAR_DAY' Then
    Begin
        Result := 'wxCalendarEvent& event';
        exit;
    End;

    If EventName = 'EVT_CALENDAR_MONTH' Then
    Begin
        Result := 'wxCalendarEvent& event';
        exit;
    End;

    If EventName = 'EVT_CALENDAR_YEAR' Then
    Begin
        Result := 'wxCalendarEvent& event';
        exit;
    End;

    If EventName = 'EVT_CALENDAR_WEEKDAY_CLICKED' Then
    Begin
        Result := 'wxCalendarEvent& event';
        exit;
    End;
End;

Function TWxCalendarCtrl.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxCalendarCtrl.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxCalendarCtrl.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxCalendarCtrl.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxCalendarCtrl.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxCalendarCtrl.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxCalendarCtrl.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxCalendarCtrl.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxCalendarCtrl';
    Result := wx_Class;
End;

Procedure TWxCalendarCtrl.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxCalendarCtrl.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxCalendarCtrl.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxCalendarCtrl.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Function TWxCalendarCtrl.GetSelectedDate: TDateTime;
Begin
    Result := FWx_SelectedDate;
End;

Procedure TWxCalendarCtrl.SetSelectedDate(Value: TDateTime);
Begin
    SelectedDate := Value;
    FWx_SelectedDate := Value;
End;

Procedure TWxCalendarCtrl.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxCalendarCtrl.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxCalendarCtrl.SetGenericColor(strVariableName, strValue: String);
Begin

End;


Function TWxCalendarCtrl.GetFGColor: String;
Begin
    Result := FInvisibleFGColorString;
End;

Procedure TWxCalendarCtrl.SetFGColor(strValue: String);
Begin
    FInvisibleFGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Font.Color := defaultFGColor
    Else
        self.Font.Color := GetColorFromString(strValue);
End;

Function TWxCalendarCtrl.GetBGColor: String;
Begin
    Result := FInvisibleBGColorString;
End;

Procedure TWxCalendarCtrl.SetBGColor(strValue: String);
Begin
    FInvisibleBGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Color := defaultBGColor
    Else
        self.Color := GetColorFromString(strValue);
End;

Procedure TWxCalendarCtrl.SetProxyFGColorString(Value: String);
Begin
    FInvisibleFGColorString := Value;
    self.Color := GetColorFromString(Value);
End;

Procedure TWxCalendarCtrl.SetProxyBGColorString(Value: String);
Begin
    FInvisibleBGColorString := Value;
    self.Font.Color := GetColorFromString(Value);
End;

Function TWxCalendarCtrl.GenerateLastCreationCode: String;
Begin
    Result := '';
End;


End. 