 { ****************************************************************** }
 {                                                                    }
{ $Id: wxgrid.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
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

Unit WxGrid;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, Grids, wxUtils, WxSizerPanel, WxAuiNotebookPage, wxAuiToolBar;

Type
    TWxGrid = Class(TStringGrid, IWxComponentInterface, IWxWindowInterface)
    Private
    { Private fields of TWxGrid }
        FEVT_GRID_CELL_LEFT_CLICK: String;
        FEVT_GRID_CELL_RIGHT_CLICK: String;
        FEVT_GRID_CELL_LEFT_DCLICK: String;
        FEVT_GRID_CELL_RIGHT_DCLICK: String;
        FEVT_GRID_LABEL_LEFT_CLICK: String;
        FEVT_GRID_LABEL_RIGHT_CLICK: String;
        FEVT_GRID_LABEL_LEFT_DCLICK: String;
        FEVT_GRID_LABEL_RIGHT_DCLICK: String;
        FEVT_GRID_CELL_CHANGE: String;
        FEVT_GRID_SELECT_CELL: String;
        FEVT_GRID_EDITOR_HIDDEN: String;
        FEVT_GRID_EDITOR_SHOWN: String;
        FEVT_GRID_COL_SIZE: String;
        FEVT_GRID_ROW_SIZE: String;
        FEVT_GRID_RANGE_SELECT: String;
        FEVT_GRID_EDITOR_CREATED: String;
        FEVT_UPDATE_UI: String;

    { Storage for property Wx_BGColor }
        FWx_BGColor: TColor;
        FWx_LabelColSize: Integer;
        FWx_LabelRowSize: Integer;
    { Storage for property Wx_Border }
        FWx_Border: Integer;
    { Storage for property Wx_Class }
        FWx_Class: String;
    { Storage for property Wx_ControlOrientation }
        FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_EditStyle }
        FWx_EditStyle: TWxEdtGeneralStyleSet;
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
    { Storage for property Wx_IDName }
        FWx_IDName: String;
    { Storage for property Wx_IDValue }
        FWx_IDValue: Integer;
    { Storage for property Wx_ProxyBGColorString }
        FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
        FWx_ProxyFGColorString: TWxColorString;
    { Storage for property Wx_StretchFactor }
        FWx_StretchFactor: Integer;
    { Storage for property Wx_ToolTip }
        FWx_ToolTip: String;
        FWx_Comments: TStrings;
        FWx_EventList: TStringList;
        FWx_PropertyList: TStringList;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;

        FGridSelection: TWxGridSelection;

        FInvisibleBGColorString: String;
        FInvisibleFGColorString: String;


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

    { Private methods of TWxGrid }
    { Method to set variable and property values and create objects }
        Procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
        Procedure AutoDestroy;

    { Read method for property Wx_EditStyle }
        Function GetWx_EditStyle: TWxEdtGeneralStyleSet;
    { Write method for property Wx_EditStyle }
        Procedure SetWx_EditStyle(Value: TWxEdtGeneralStyleSet);

        Function GetVirtualColCount: Integer;
        Procedure SetVirtualColCount(Value: Integer);

        Function GetVirtualRowCount: Integer;
        Procedure SetVirtualRowCount(Value: Integer);

        Function GetVirtualLabelColSize: Integer;
        Procedure SetVirtualLabelColSize(Value: Integer);
        Function GetVirtualLabelRowSize: Integer;
        Procedure SetVirtualLabelRowSize(Value: Integer);

    Protected
    { Protected fields of TWxGrid }

    { Protected methods of TWxGrid }
        Procedure Click; Override;
        Procedure KeyPress(Var Key: Char); Override;
        Procedure Loaded; Override;
        Procedure Paint; Override;

    Public
    { Public fields and properties of TWxGrid }
        defaultBGColor: TColor;
        defaultFGColor: TColor;

    { Public methods of TWxGrid }
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
    { Published properties of TWxGrid }
        Property OnClick;
        Property OnDblClick;
        Property OnDragDrop;
        Property OnDrawCell;
        Property OnEnter;
        Property OnExit;
        Property OnKeyDown;
        Property OnKeyPress;
        Property OnKeyUp;
        Property OnMouseDown;
        Property OnMouseMove;
        Property OnMouseUp;
        Property EVT_GRID_CELL_LEFT_CLICK: String
            Read FEVT_GRID_CELL_LEFT_CLICK Write FEVT_GRID_CELL_LEFT_CLICK;
        Property EVT_GRID_CELL_RIGHT_CLICK: String
            Read FEVT_GRID_CELL_RIGHT_CLICK Write FEVT_GRID_CELL_RIGHT_CLICK;
        Property EVT_GRID_CELL_LEFT_DCLICK: String
            Read FEVT_GRID_CELL_LEFT_DCLICK Write FEVT_GRID_CELL_LEFT_DCLICK;
        Property EVT_GRID_CELL_RIGHT_DCLICK: String
            Read FEVT_GRID_CELL_RIGHT_DCLICK Write FEVT_GRID_CELL_RIGHT_DCLICK;
        Property EVT_GRID_LABEL_LEFT_CLICK: String
            Read FEVT_GRID_LABEL_LEFT_CLICK Write FEVT_GRID_LABEL_LEFT_CLICK;
        Property EVT_GRID_LABEL_RIGHT_CLICK: String
            Read FEVT_GRID_LABEL_RIGHT_CLICK Write FEVT_GRID_LABEL_RIGHT_CLICK;
        Property EVT_GRID_LABEL_LEFT_DCLICK: String
            Read FEVT_GRID_LABEL_LEFT_DCLICK Write FEVT_GRID_LABEL_LEFT_DCLICK;
        Property EVT_GRID_LABEL_RIGHT_DCLICK: String
            Read FEVT_GRID_LABEL_RIGHT_DCLICK Write FEVT_GRID_LABEL_RIGHT_DCLICK;
        Property EVT_GRID_CELL_CHANGE: String Read FEVT_GRID_CELL_CHANGE
            Write FEVT_GRID_CELL_CHANGE;
        Property EVT_GRID_SELECT_CELL: String Read FEVT_GRID_SELECT_CELL
            Write FEVT_GRID_SELECT_CELL;
        Property EVT_GRID_EDITOR_HIDDEN: String
            Read FEVT_GRID_EDITOR_HIDDEN Write FEVT_GRID_EDITOR_HIDDEN;
        Property EVT_GRID_EDITOR_SHOWN: String
            Read FEVT_GRID_EDITOR_SHOWN Write FEVT_GRID_EDITOR_SHOWN;
        Property EVT_GRID_COL_SIZE: String Read FEVT_GRID_COL_SIZE Write FEVT_GRID_COL_SIZE;
        Property EVT_GRID_ROW_SIZE: String Read FEVT_GRID_ROW_SIZE Write FEVT_GRID_ROW_SIZE;
        Property EVT_GRID_RANGE_SELECT: String
            Read FEVT_GRID_RANGE_SELECT Write FEVT_GRID_RANGE_SELECT;
        Property EVT_GRID_EDITOR_CREATED: String
            Read FEVT_GRID_EDITOR_CREATED Write FEVT_GRID_EDITOR_CREATED;
        Property EVT_UPDATE_UI: String Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;

        Property Wx_ColCount: Integer Read GetVirtualColCount
            Write SetVirtualColCount Default 5;
        Property Wx_RowCount: Integer Read GetVirtualRowCount
            Write SetVirtualRowCount Default 5;

        Property Wx_LabelColSize: Integer Read GetVirtualLabelColSize
            Write SetVirtualLabelColSize Default 5;
        Property Wx_LabelRowSize: Integer Read GetVirtualLabelRowSize
            Write SetVirtualLabelRowSize Default 5;

        Property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_ControlOrientation: TWxControlOrientation
            Read FWx_ControlOrientation Write FWx_ControlOrientation;
        Property Wx_EditStyle: TWxEdtGeneralStyleSet
            Read GetWx_EditStyle Write SetWx_EditStyle;
        Property Wx_Enabled: Boolean Read FWx_Enabled Write FWx_Enabled Default True;
        Property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
        Property Wx_GeneralStyle: TWxStdStyleSet
            Read FWx_GeneralStyle Write FWx_GeneralStyle;
        Property Wx_HelpText: String Read FWx_HelpText Write FWx_HelpText;
        Property Wx_Hidden: Boolean Read FWx_Hidden Write FWx_Hidden;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue Default -1;
        Property Wx_GridSelection: TWxGridSelection
            Read FGridSelection Write FGridSelection Default wxGridSelectCells;
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
     { Register TWxGrid with wxWidgets as its
       default page on the Delphi component palette }
    RegisterComponents('wxWidgets', [TWxGrid]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxGrid.AutoInitialize;
Begin
    FWx_EventList := TStringList.Create;
    FWx_PropertyList := TStringList.Create;
    FWx_Border := 5;
    FWx_Class := 'wxGrid';
    FWx_Enabled := True;
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_IDValue := -1;
    FWx_StretchFactor := 0;
    FWx_ProxyBGColorString := TWxColorString.Create;
    FWx_ProxyFGColorString := TWxColorString.Create;
    defaultBGColor := self.color;
    defaultFGColor := self.font.color;
    FWx_Comments := TStringList.Create;

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxGrid.AutoDestroy;
Begin
    FWx_EventList.Destroy;
    FWx_PropertyList.Destroy;
    FWx_ProxyBGColorString.Destroy;
    FWx_ProxyFGColorString.Destroy;
    FWx_Comments.Destroy;

End; { of AutoDestroy }

{ Read method for property Wx_EditStyle }
Function TWxGrid.GetWx_EditStyle: TWxEdtGeneralStyleSet;
Begin
    Result := FWx_EditStyle;
End;

{ Write method for property Wx_EditStyle }
Procedure TWxGrid.SetWx_EditStyle(Value: TWxEdtGeneralStyleSet);
Begin
    FWx_EditStyle := GetRefinedWxEdtGeneralStyleValue(Value);
End;

Function TWxGrid.GetVirtualColCount: Integer;
Begin
    Result := ColCount - 1;
End;

Procedure TWxGrid.SetVirtualColCount(Value: Integer);
Var
    I: Integer;
Begin
    If Value < 1 Then
        Value := 1;

    ColCount := Value + 1;
    For I := 1 To ColCount - 1 Do    // Iterate
        self.Cols[0].Strings[i] := IntToStr(i);    // for
End;

Function TWxGrid.GetVirtualRowCount: Integer;
Begin
    Result := RowCount - 1;
End;

Procedure TWxGrid.SetVirtualRowCount(Value: Integer);
Var
    i: Integer;
    IncChar: Char;
Begin
    If Value < 1 Then
        Value := 1;
    RowCount := Value + 1;
    IncChar := 'A';
    For I := 1 To RowCount - 1 Do    // Iterate
    Begin
        If IncChar = 'Z' Then
            IncChar := 'A';
        self.Rows[0].Strings[i] := IncChar;
        Inc(IncChar);
    End;    // for
End;

Function TWxGrid.GetVirtualLabelColSize: Integer;
Begin
    Result := FWx_LabelColSize;
End;

Procedure TWxGrid.SetVirtualLabelColSize(Value: Integer);
Begin
    ColWidths[0] := Value;
    FWx_LabelColSize := Value;
End;

Function TWxGrid.GetVirtualLabelRowSize: Integer;
Begin
    Result := FWx_LabelRowSize;
End;

Procedure TWxGrid.SetVirtualLabelRowSize(Value: Integer);
Begin
    RowHeights[0] := Value;
    FWx_LabelRowSize := Value;
End;

{ Override OnClick handler from TStringGrid }
Procedure TWxGrid.Click;
Begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
    Inherited Click;

     { Code to execute after click behavior
       of parent }

End;

{ Override OnKeyPress handler from TStringGrid }
Procedure TWxGrid.KeyPress(Var Key: Char);
Const
    TabKey = Char(VK_TAB);
    EnterKey = Char(VK_RETURN);
Begin
     { Key contains the character produced by the keypress.
       It can be tested or assigned a new value before the
       call to the inherited KeyPress method.  Setting Key 
       to #0 before call to the inherited KeyPress method 
       terminates any further processing of the character. }

  { Activate KeyPress behavior of parent }
    Inherited KeyPress(Key);

  { Code to execute after KeyPress behavior of parent }

End;

Constructor TWxGrid.Create(AOwner: TComponent);
Begin
  { Call the Create method of the parent class }
    Inherited Create(AOwner);

  { AutoInitialize sets the initial values of variables and      }
  { properties; also, it creates objects for properties of       }
  { standard Delphi object types (e.g., TFont, TTimer,           }
  { TPicture) and for any variables marked as objects.           }
  { AutoInitialize method is generated by Component Create.      }
    AutoInitialize;

    self.DefaultColWidth := 50;
    self.DefaultRowHeight := 25;

    self.Wx_LabelColSize := 50;
    self.Wx_LabelRowSize := 25;

    self.RowCount := 5;
    self.ColCount := 5;

    SetVirtualRowCount(self.RowCount);
    SetVirtualColCount(self.ColCount);

  { Code to perform other tasks when the component is created }
    PopulateGenericProperties(FWx_PropertyList);
    PopulateAuiGenericProperties(FWx_PropertyList);

    FWx_PropertyList.Add('Wx_RowCount:Row Count');
    FWx_PropertyList.Add('Wx_ColCount:Column Count');
    FWx_PropertyList.Add('DefaultColWidth:Column Width');
    FWx_PropertyList.Add('DefaultRowHeight:Row Height');
    FWx_PropertyList.Add('Wx_LabelColSize:Label Column Width');
    FWx_PropertyList.Add('Wx_LabelRowSize:Label Row Height');
    FWx_PropertyList.Add('Wx_GridSelection:Grid Selection');

    FWx_EventList.add('EVT_GRID_CELL_LEFT_CLICK:OnCellLeftClick');
    FWx_EventList.add('EVT_GRID_CELL_RIGHT_CLICK:OnCellRightClick');
    FWx_EventList.add('EVT_GRID_CELL_LEFT_DCLICK:OnCellLeftDoubleClick');
    FWx_EventList.add('EVT_GRID_CELL_RIGHT_DCLICK:OnCellRightDoubleClick');
    FWx_EventList.add('EVT_GRID_LABEL_LEFT_CLICK:OnLabelLeftClick');
    FWx_EventList.add('EVT_GRID_LABEL_RIGHT_CLICK:OnLabelRightClick');
    FWx_EventList.add('EVT_GRID_LABEL_LEFT_DCLICK:OnLabelLeftDoubleClick');
    FWx_EventList.add('EVT_GRID_LABEL_RIGHT_DCLICK:OnLabelRightDoubleClick');
    FWx_EventList.add('EVT_GRID_CELL_CHANGE:OnCellChange');
    FWx_EventList.add('EVT_GRID_SELECT_CELL:OnSelectCell');
    FWx_EventList.add('EVT_GRID_EDITOR_HIDDEN:OnEditorHidden');
    FWx_EventList.add('EVT_GRID_EDITOR_SHOWN:OnEditorShown');
    FWx_EventList.add('EVT_GRID_COL_SIZE:OnColumnSize');
    FWx_EventList.add('EVT_GRID_ROW_SIZE:OnRowSize');
    FWx_EventList.add('EVT_GRID_RANGE_SELECT:OnRangeSelect');
    FWx_EventList.add('EVT_GRID_EDITOR_CREATED:OnEditorCreated');
    FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

End;

Destructor TWxGrid.Destroy;
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

Procedure TWxGrid.Loaded;
Begin
    Inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

End;

Procedure TWxGrid.Paint;
Begin
     { Make this component look like its parent component by calling
       its parent's Paint method. }
    Inherited Paint;

     { To change the appearance of the component, use the methods 
       supplied by the component's Canvas property (which is of 
       type TCanvas).  For example, }

  { Canvas.Rectangle(0, 0, Width, Height); }
End;


Function TWxGrid.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxGrid.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
End;

Function TWxGrid.GenerateEventTableEntries(CurrClassName: String): String;
Begin

    Result := '';

    If trim(EVT_GRID_CELL_LEFT_CLICK) <> '' Then
        Result := Format('EVT_GRID_CELL_LEFT_CLICK(%s::%s)',
            [CurrClassName, EVT_GRID_CELL_LEFT_CLICK]) + '';

    If trim(EVT_GRID_CELL_RIGHT_CLICK) <> '' Then
        Result := Result + #13 + Format('EVT_GRID_CELL_RIGHT_CLICK(%s::%s)',
            [CurrClassName, EVT_GRID_CELL_RIGHT_CLICK]) + '';

    If trim(EVT_GRID_CELL_LEFT_DCLICK) <> '' Then
        Result := Result + #13 + Format('EVT_GRID_CELL_LEFT_DCLICK(%s::%s)',
            [CurrClassName, EVT_GRID_CELL_LEFT_DCLICK]) + '';

    If trim(EVT_GRID_CELL_RIGHT_DCLICK) <> '' Then
        Result := Result + #13 + Format('EVT_GRID_CELL_RIGHT_DCLICK(%s::%s)',
            [CurrClassName, EVT_GRID_CELL_RIGHT_DCLICK]) + '';

    If trim(EVT_GRID_LABEL_LEFT_CLICK) <> '' Then
        Result := Result + #13 + Format('EVT_GRID_LABEL_LEFT_CLICK(%s::%s)',
            [CurrClassName, EVT_GRID_LABEL_LEFT_CLICK]) + '';

    If trim(EVT_GRID_LABEL_RIGHT_CLICK) <> '' Then
        Result := Format('EVT_GRID_LABEL_RIGHT_CLICK(%s::%s)',
            [CurrClassName, EVT_GRID_LABEL_RIGHT_CLICK]) + '';

    If trim(EVT_GRID_LABEL_LEFT_DCLICK) <> '' Then
        Result := Result + #13 + Format('EVT_GRID_LABEL_LEFT_DCLICK(%s::%s)',
            [CurrClassName, EVT_GRID_LABEL_LEFT_DCLICK]) + '';

    If trim(EVT_GRID_LABEL_RIGHT_DCLICK) <> '' Then
        Result := Result + #13 + Format('EVT_GRID_LABEL_RIGHT_DCLICK(%s::%s)',
            [CurrClassName, EVT_GRID_LABEL_RIGHT_DCLICK]) + '';

    If trim(EVT_GRID_CELL_CHANGE) <> '' Then
        Result := Result + #13 + Format('EVT_GRID_CELL_CHANGE(%s::%s)',
            [CurrClassName, EVT_GRID_CELL_CHANGE]) + '';

    If trim(EVT_GRID_SELECT_CELL) <> '' Then
        Result := Result + #13 + Format('EVT_GRID_SELECT_CELL(%s::%s)',
            [CurrClassName, EVT_GRID_SELECT_CELL]) + '';

    If trim(EVT_GRID_EDITOR_HIDDEN) <> '' Then
        Result := Result + #13 + Format('EVT_GRID_EDITOR_HIDDEN(%s::%s)',
            [CurrClassName, EVT_GRID_EDITOR_HIDDEN]) + '';

    If trim(EVT_GRID_EDITOR_SHOWN) <> '' Then
        Result := Result + #13 + Format('EVT_GRID_EDITOR_SHOWN(%s::%s)',
            [CurrClassName, EVT_GRID_EDITOR_SHOWN]) + '';

    If trim(EVT_GRID_COL_SIZE) <> '' Then
        Result := Result + #13 + Format('EVT_GRID_COL_SIZE(%s::%s)',
            [CurrClassName, EVT_GRID_COL_SIZE]) + '';

    If trim(EVT_GRID_ROW_SIZE) <> '' Then
        Result := Result + #13 + Format('EVT_GRID_ROW_SIZE(%s::%s)',
            [CurrClassName, EVT_GRID_ROW_SIZE]) + '';

    If trim(EVT_GRID_RANGE_SELECT) <> '' Then
        Result := Result + #13 + Format('EVT_GRID_RANGE_SELECT(%s::%s)',
            [CurrClassName, EVT_GRID_RANGE_SELECT]) + '';

    If trim(EVT_GRID_EDITOR_CREATED) <> '' Then
        Result := Result + #13 + Format('EVT_GRID_EDITOR_CREATED(%s::%s)',
            [CurrClassName, EVT_GRID_EDITOR_CREATED]) + '';
End;

Function TWxGrid.GenerateXRCControlCreation(IndentString: String): TStringList;
Begin

    Result := TStringList.Create;

    Try
        Result.Add(IndentString + Format('<object class="%s" name="%s">',
            [self.Wx_Class, self.Name]));
        Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
        Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));

        If Not (UseDefaultSize) Then
            Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
        If Not (UseDefaultPos) Then
            Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

        Result.Add(IndentString + Format('  <style>%s</style>',
            [GetEditSpecificStyle(self.Wx_GeneralStyle, self.Wx_EditStyle)]));
        Result.Add(IndentString + '</object>');
    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxGrid.GenerateGUIControlCreation: String;
Var
    strColorStr, strSelectionStr: String;
    strStyle, parentName, strAlignment: String;
Begin
    Result := '';

    If FWx_PaneCaption = '' Then
        FWx_PaneCaption := Self.Name;
    If FWx_PaneName = '' Then
        FWx_PaneName := Self.Name + '_Pane';

    parentName := GetWxWidgetParent(self, Wx_AuiManaged);

    strStyle := GetEditSpecificStyle(self.Wx_GeneralStyle, self.Wx_EditStyle);

    If trim(strStyle) <> '' Then
        strStyle := ', ' + strStyle;

    If (XRCGEN) Then
    Begin
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

    strSelectionStr := GetGridSelectionToString(self.Wx_GridSelection);
    strSelectionStr := 'wxGrid::' + strSelectionStr;

    Result := Result + #13 + Format('%s->SetDefaultColSize(%d);',
        [self.Name, DefaultColWidth]);
    Result := Result + #13 + Format('%s->SetDefaultRowSize(%d);',
        [self.Name, DefaultRowHeight]);

  // I think these are reversed
  // Result:=Result+#13+Format('%s->SetColLabelSize(%d);',[self.Name,Wx_LabelColSize]);
  // Result:=Result+#13+Format('%s->SetRowLabelSize(%d);',[self.Name,Wx_LabelRowSize]);

  // I reversed these to make the grid on the designer look like the grid produced on execution
    Result := Result + #13 + Format('%s->SetRowLabelSize(%d);',
        [self.Name, Wx_LabelColSize]);
    Result := Result + #13 + Format('%s->SetColLabelSize(%d);',
        [self.Name, Wx_LabelRowSize]);

    Result := Result + #13 + Format('%s->CreateGrid(%d,%d,%s);',
        [self.Name, wx_RowCount, wx_ColCount, strSelectionStr]);

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

Function TWxGrid.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
End;

Function TWxGrid.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/grid.h>';
End;

Function TWxGrid.GenerateImageInclude: String;
Begin

End;

Function TWxGrid.GetEventList: TStringList;
Begin
    Result := FWx_EventList;
End;

Function TWxGrid.GetIDName: String;
Begin
    Result := '';
    Result := wx_IDName;
End;

Function TWxGrid.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxGrid.GetParameterFromEventName(EventName: String): String;
Begin
    Result := '';

    If EventName = 'EVT_UPDATE_UI' Then
    Begin
        Result := 'wxUpdateUIEvent& event';
        exit;
    End;

    If trim(EVT_GRID_CELL_LEFT_CLICK) <> '' Then
    Begin
        Result := 'wxGridEvent& event';
        exit;
    End;

    If trim(EVT_GRID_CELL_RIGHT_CLICK) <> '' Then
    Begin
        Result := 'wxGridEvent& event';
        exit;
    End;

    If trim(EVT_GRID_CELL_LEFT_DCLICK) <> '' Then
    Begin
        Result := 'wxGridEvent& event';
        exit;
    End;

    If trim(EVT_GRID_CELL_RIGHT_DCLICK) <> '' Then
    Begin
        Result := 'wxGridEvent& event';
        exit;
    End;

    If trim(EVT_GRID_LABEL_LEFT_CLICK) <> '' Then
    Begin
        Result := 'wxGridEvent& event';
        exit;
    End;
    If trim(EVT_GRID_LABEL_RIGHT_CLICK) <> '' Then
    Begin
        Result := 'wxGridEvent& event';
        exit;
    End;

    If trim(EVT_GRID_LABEL_LEFT_DCLICK) <> '' Then
    Begin
        Result := 'wxGridEvent& event';
        exit;
    End;

    If trim(EVT_GRID_LABEL_RIGHT_DCLICK) <> '' Then
    Begin
        Result := 'wxGridEvent& event';
        exit;
    End;

    If trim(EVT_GRID_CELL_CHANGE) <> '' Then
    Begin
        Result := 'wxGridEvent& event';
        exit;
    End;

    If trim(EVT_GRID_SELECT_CELL) <> '' Then
    Begin
        Result := 'wxGridEvent& event';
        exit;
    End;
    If trim(EVT_GRID_EDITOR_HIDDEN) <> '' Then
    Begin
        Result := 'wxGridEvent& event';
        exit;
    End;

    If trim(EVT_GRID_EDITOR_SHOWN) <> '' Then
    Begin
        Result := 'wxGridEvent& event';
        exit;
    End;

    If trim(EVT_GRID_COL_SIZE) <> '' Then
    Begin
        Result := 'wxGridSizeEvent& event';
        exit;
    End;
    If trim(EVT_GRID_ROW_SIZE) <> '' Then
    Begin
        Result := 'wxGridSizeEvent& event';
        exit;
    End;

    If trim(EVT_GRID_RANGE_SELECT) <> '' Then
    Begin
        Result := 'wxGridRangeSelectEvent& event';
        exit;
    End;
    If trim(EVT_GRID_EDITOR_CREATED) <> '' Then
    Begin
        Result := 'wxGridEditorCreatedEvent& event';
        exit;
    End;


End;

Function TWxGrid.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxGrid.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxGrid.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxGrid.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxGrid.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxGrid.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxGrid.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxGrid.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxGrid';
    Result := wx_Class;
End;

Procedure TWxGrid.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxGrid.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxGrid.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxGrid.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxGrid.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxGrid.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxGrid.SetGenericColor(strVariableName, strValue: String);
Begin

End;


Function TWxGrid.GetFGColor: String;
Begin
    Result := FInvisibleFGColorString;
End;

Procedure TWxGrid.SetFGColor(strValue: String);
Begin
    FInvisibleFGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Font.Color := defaultFGColor
    Else
        self.Font.Color := GetColorFromString(strValue);
End;

Function TWxGrid.GetBGColor: String;
Begin
    Result := FInvisibleBGColorString;
End;

Procedure TWxGrid.SetBGColor(strValue: String);
Begin
    FInvisibleBGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Color := defaultBGColor
    Else
        self.Color := GetColorFromString(strValue);
End;

Procedure TWxGrid.SetProxyFGColorString(Value: String);
Begin
    FInvisibleFGColorString := Value;
    self.Color := GetColorFromString(Value);
End;

Procedure TWxGrid.SetProxyBGColorString(Value: String);
Begin
    FInvisibleBGColorString := Value;
    self.Font.Color := GetColorFromString(Value);
End;


End.
