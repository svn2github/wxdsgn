{ ****************************************************************** }
{                                                                    }
{ $Id$                                                               }
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

unit wxAuiToolBar;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ComCtrls, WxUtils, WxSizerPanel, wxAuiBar;

type
  TWxAuiToolBar = class(TToolBar, IWxComponentInterface,
      IWxAuiToolBarInterface, IWxToolBarInterface, IWxContainerInterface, IWxContainerAndSizerInterface)
  private
    { Private fields of TWxAuiToolBar }
    FOrientation: TWxSizerOrientation;
    FWx_Caption: string;
    FWx_Class: string;
    FWx_ControlOrientation: TWxControlOrientation;
    FWx_EventList: TStringList;
    FWx_ToolbarStyleSet: TWxAuiTbrStyleSet;
    FWx_GeneralStyle: TWxStdStyleSet;
    FWx_IDName: string;
    FWx_IDValue: integer;
    FWx_StretchFactor: integer;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_ToolTip: string;
    FWx_Enabled: boolean;
    FWx_Hidden: boolean;
    FWx_HelpText: string;
    FWx_Border: integer;
    FWx_Comments: TStrings;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

    FEVT_AUITOOLBAR_TOOL_DROPDOWN: string;
    FEVT_AUITOOLBAR_OVERFLOW_CLICK: string;
    FEVT_AUITOOLBAR_RIGHT_CLICK: string;
    FEVT_AUITOOLBAR_MIDDLE_CLICK: string;
    FEVT_AUITOOLBAR_BEGIN_DRAG: string;
    FEVT_UPDATE_UI: string;

    //Aui Properties
    FWx_AuiManaged: Boolean;
    FWx_PaneCaption: string;
    FWx_PaneName: string;
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

    { Private methods of TWxAuiToolBar }
    procedure AutoInitialize;
    procedure AutoDestroy;

  protected
    { Protected fields of TWxAuiToolBar }

    { Protected methods of TWxAuiToolBar }
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;

  public
    { Public fields and properties of TWxAuiToolBar }
    defaultBGColor: TColor;
    defaultFGColor: TColor;

    { Public methods of TWxAuiToolBar }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GenerateControlIDs: string;
    function GenerateEnumControlIDs: string;
    function GenerateEventTableEntries(CurrClassName: string): string;
    function GenerateGUIControlCreation: string;
    function GenerateXRCControlCreation(IndentString: string): TStringList;
    function GenerateGUIControlDeclaration: string;
    function GenerateHeaderInclude: string;
    function GenerateImageInclude: string;
    function GetEventList: TStringList;
    function GetIDName: string;
    function GetIDValue: integer;
    function GetParameterFromEventName(EventName: string): string;
    function GetPropertyList: TStringList;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: integer);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

    procedure SetWxClassName(wxClassName: string);
    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName: string): string;
    procedure SetGenericColor(strVariableName, strValue: string);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);
    procedure DummySizerNonInsertableInterfaceProcedure;
    function GenerateLastCreationCode: string;
    procedure SetToolbarStyle(Value: TWxAuiTbrStyleSet);

    function GetRealizeString: string;

  published
    { Published properties of TWxAuiToolBar }
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property Orientation: TWxSizerOrientation
      read FOrientation write FOrientation default wxHorizontal;
    property Wx_Caption: string read FWx_Caption write FWx_Caption;
    property Wx_Class: string read FWx_Class write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      read FWx_ControlOrientation write FWx_ControlOrientation;
    property Wx_EventList: TStringList read FWx_EventList write FWx_EventList;
    property Wx_ToolbarStyleSet: TWxAuiTbrStyleSet
      read FWx_ToolbarStyleSet write SetToolbarStyle;
    property Wx_GeneralStyle: TWxStdStyleSet
      read FWx_GeneralStyle write FWx_GeneralStyle;
    property Wx_IDName: string read FWx_IDName write FWx_IDName;
    property Wx_IDValue: integer read FWx_IDValue write FWx_IDValue default -1;
    property Wx_StretchFactor: integer read FWx_StretchFactor
      write FWx_StretchFactor default 0;
    property Wx_Comments: TStrings read FWx_Comments write FWx_Comments;

    property InvisibleBGColorString: string
      read FInvisibleBGColorString write FInvisibleBGColorString;
    property InvisibleFGColorString: string
      read FInvisibleFGColorString write FInvisibleFGColorString;

    property Wx_Hidden: boolean read FWx_Hidden write FWx_Hidden;
    property Wx_ToolTip: string read FWx_ToolTip write FWx_ToolTip;
    property Wx_HelpText: string read FWx_HelpText write FWx_HelpText;
    property Wx_Enabled: boolean read FWx_Enabled write FWx_Enabled default True;
    property Wx_Border: integer read GetBorderWidth write SetBorderWidth default 5;

    property Wx_Alignment: TWxSizerAlignmentSet
      read FWx_Alignment write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_BorderAlignment: TWxBorderAlignment read GetBorderAlignment
      write SetBorderAlignment default [wxALL];

    property EVT_AUITOOLBAR_TOOL_DROPDOWN: string read FEVT_AUITOOLBAR_TOOL_DROPDOWN write FEVT_AUITOOLBAR_TOOL_DROPDOWN;
    property EVT_AUITOOLBAR_OVERFLOW_CLICK: string read FEVT_AUITOOLBAR_OVERFLOW_CLICK write FEVT_AUITOOLBAR_OVERFLOW_CLICK;
    property EVT_AUITOOLBAR_RIGHT_CLICK: string read FEVT_AUITOOLBAR_RIGHT_CLICK write FEVT_AUITOOLBAR_RIGHT_CLICK;
    property EVT_AUITOOLBAR_MIDDLE_CLICK: string read FEVT_AUITOOLBAR_MIDDLE_CLICK write FEVT_AUITOOLBAR_MIDDLE_CLICK;
    property EVT_AUITOOLBAR_BEGIN_DRAG: string read FEVT_AUITOOLBAR_BEGIN_DRAG write FEVT_AUITOOLBAR_BEGIN_DRAG;
    property EVT_UPDATE_UI: string read FEVT_UPDATE_UI write FEVT_UPDATE_UI;

    //Aui Properties
    property Wx_AuiManaged: boolean read FWx_AuiManaged write FWx_AuiManaged default True;
    property Wx_PaneCaption: string read FWx_PaneCaption write FWx_PaneCaption;
    property Wx_PaneName: string read FWx_PaneName write FWx_PaneName;
    property Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem read FWx_Aui_Dock_Direction write FWx_Aui_Dock_Direction;
    property Wx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet read FWx_Aui_Dockable_Direction write FWx_Aui_Dockable_Direction;
    property Wx_Aui_Pane_Style: TwxAuiPaneStyleSet read FWx_Aui_Pane_Style write FWx_Aui_Pane_Style default [ToolbarPane];
    property Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet read FWx_Aui_Pane_Buttons write FWx_Aui_Pane_Buttons;
    property Wx_BestSize_Height: integer read FWx_BestSize_Height write FWx_BestSize_Height default -1;
    property Wx_BestSize_Width: integer read FWx_BestSize_Width write FWx_BestSize_Width default -1;
    property Wx_MinSize_Height: integer read FWx_MinSize_Height write FWx_MinSize_Height default -1;
    property Wx_MinSize_Width: integer read FWx_MinSize_Width write FWx_MinSize_Width default -1;
    property Wx_MaxSize_Height: integer read FWx_MaxSize_Height write FWx_MaxSize_Height default -1;
    property Wx_MaxSize_Width: integer read FWx_MaxSize_Width write FWx_MaxSize_Width default -1;
    property Wx_Floating_Height: integer read FWx_Floating_Height write FWx_Floating_Height default -1;
    property Wx_Floating_Width: integer read FWx_Floating_Width write FWx_Floating_Width default -1;
    property Wx_Floating_X_Pos: integer read FWx_Floating_X_Pos write FWx_Floating_X_Pos default -1;
    property Wx_Floating_Y_Pos: integer read FWx_Floating_Y_Pos write FWx_Floating_Y_Pos default -1;
    property Wx_Layer: integer read FWx_Layer write FWx_Layer default 0;
    property Wx_Row: integer read FWx_Row write FWx_Row default 0;
    property Wx_Position: integer read FWx_Position write FWx_Position default 0;

  end;

procedure Register;

implementation

procedure Register;
begin
  { Register TWxAuiToolBar with wxWidgets as its
    default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TWxAuiToolBar]);
end;

{ Method to set variable and property values and create objects }

procedure TWxAuiToolBar.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FOrientation := wxHorizontal;
  FWx_Class := 'wxAuiToolBar';
  FWx_EventList := TStringList.Create;
  FWx_BorderAlignment := [wxALL];
  FWx_Alignment := [wxALIGN_CENTER];
  FWx_IDValue := -1;
  FWx_StretchFactor := 0;
  FWx_Enabled := True;
  FWx_Comments := TStringList.Create;
  self.ShowCaptions := false;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }

procedure TWxAuiToolBar.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

{ Override OnClick handler from TToolBar }

procedure TWxAuiToolBar.Click;
begin
  { Code to execute before activating click
    behavior of component's parent class }

{ Activate click behavior of parent }
  inherited Click;

  { Code to execute after click behavior
    of parent }
end;

{ Override OnKeyPress handler from TToolBar }

procedure TWxAuiToolBar.KeyPress(var Key: char);
const
  TabKey = char(VK_TAB);
  EnterKey = char(VK_RETURN);
begin
  { Key contains the character produced by the keypress.
    It can be tested or assigned a new value before the
    call to the inherited KeyPress method.  Setting Key
    to #0 before call to the inherited KeyPress method
    terminates any further processing of the character. }

{ Activate KeyPress behavior of parent }
  inherited KeyPress(Key);

  { Code to execute after KeyPress behavior of parent }

end;

constructor TWxAuiToolBar.Create(AOwner: TComponent);
begin
  { Call the Create method of the parent class }
  inherited Create(AOwner);

  { AutoInitialize sets the initial values of variables and      }
  { properties; also, it creates objects for properties of       }
  { standard Delphi object types (e.g., TFont, TTimer,           }
  { TPicture) and for any variables marked as objects.           }
  { AutoInitialize method is generated by Component Create.      }
  AutoInitialize;

  { Code to perform other tasks when the component is created }
  PopulateGenericProperties(FWx_PropertyList);
  PopulateAuiGenericProperties(FWx_PropertyList);

  FWx_PropertyList.add('Wx_ToolbarStyleSet:Toolbar Styles');
  FWx_PropertyList.add('wxAUI_TB_TEXT:wxAUI_TB_TEXT');
  FWx_PropertyList.add('wxAUI_TB_NO_TOOLTIPS:wxAUI_TB_NO_TOOLTIPS');
  FWx_PropertyList.add('wxAUI_TB_NO_AUTORESIZE:wxAUI_TB_NO_AUTORESIZE');
  FWx_PropertyList.add('wxAUI_TB_GRIPPER:wxAUI_TB_GRIPPER');
  FWx_PropertyList.add('wxAUI_TB_OVERFLOW:wxAUI_TB_OVERFLOW');
  FWx_PropertyList.add('wxAUI_TB_VERTICAL:wxAUI_TB_VERTICAL');
  FWx_PropertyList.add('wxAUI_TB_HORZ_TEXT:wxAUI_TB_HORZ_TEXT');
  FWx_PropertyList.add('wxAUI_TB_DEFAULT_STYLE:wxAUI_TB_DEFAULT_STYLE');

  FWx_EventList.add('EVT_AUITOOLBAR_TOOL_DROPDOWN:OnToolDropDown');
  FWx_EventList.add('EVT_AUITOOLBAR_OVERFLOW_CLICK:OnOverflowClick');
  FWx_EventList.add('EVT_AUITOOLBAR_RIGHT_CLICK:OnRightClick');
  FWx_EventList.add('EVT_AUITOOLBAR_MIDDLE_CLICK:OnMiddleClick');
  FWx_EventList.add('EVT_AUITOOLBAR_BEGIN_DRAG:OnTBBeginDrag');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxAuiToolBar.Destroy;
begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
  AutoDestroy;

  { Here, free any other dynamic objects that the component methods  }
  { created but have not yet freed.  Also perform any other clean-up }
  { operations needed before the component is destroyed.             }

  { Last, free the component by calling the Destroy method of the    }
  { parent class.                                                    }
  inherited Destroy;
end;

procedure TWxAuiToolBar.Loaded;
begin
  inherited Loaded;

  { Perform any component setup that depends on the property
    values having been set }
  self.ParentColor := False;
  self.Color := clBtnFace;
end;

function TWxAuiToolBar.GenerateEnumControlIDs: string;
begin
  Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
end;

function TWxAuiToolBar.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxAuiToolBar.GenerateEventTableEntries(CurrClassName: string): string;
begin

  Result := '';

  if (XRCGEN) then
  begin //generate xrc loading code
    if trim(EVT_AUITOOLBAR_TOOL_DROPDOWN) <> '' then
      Result := Format('EVT_AUITOOLBAR_TOOL_DROPDOWN(XRCID(%s("%s")),%s::%s)',
        [StringFormat, self.Name, CurrClassName, EVT_AUITOOLBAR_TOOL_DROPDOWN]) + '';

    if trim(EVT_AUITOOLBAR_OVERFLOW_CLICK) <> '' then
      Result := Result + #13 + Format('EVT_AUITOOLBAR_OVERFLOW_CLICK(XRCID(%s("%s")),%s::%s)',
        [StringFormat, self.Name, CurrClassName, EVT_AUITOOLBAR_OVERFLOW_CLICK]) + '';

    if trim(EVT_AUITOOLBAR_RIGHT_CLICK) <> '' then
      Result := Result + #13 + Format('EVT_AUITOOLBAR_RIGHT_CLICK(XRCID(%s("%s")),%s::%s)',
        [StringFormat, self.Name, CurrClassName, EVT_AUITOOLBAR_RIGHT_CLICK]) + '';

    if trim(EVT_AUITOOLBAR_MIDDLE_CLICK) <> '' then
      Result := Result + #13 + Format('EVT_AUITOOLBAR_MIDDLE_CLICK(XRCID(%s("%s")),%s::%s)',
        [StringFormat, self.Name, CurrClassName, EVT_AUITOOLBAR_MIDDLE_CLICK]) + '';

    if trim(EVT_AUITOOLBAR_BEGIN_DRAG) <> '' then
      Result := Result + #13 + Format('EVT_AUITOOLBAR_BEGIN_DRAG(XRCID(%s("%s")),%s::%s)',
        [StringFormat, self.Name, CurrClassName, EVT_AUITOOLBAR_BEGIN_DRAG]) + '';

    if trim(EVT_UPDATE_UI) <> '' then
      Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
        [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';

  end
  else
  begin
    if trim(EVT_AUITOOLBAR_TOOL_DROPDOWN) <> '' then
      Result := Format('EVT_AUITOOLBAR_TOOL_DROPDOWN(%s,%s::%s)',
        [WX_IDName, CurrClassName, EVT_AUITOOLBAR_TOOL_DROPDOWN]) + '';

    if trim(EVT_AUITOOLBAR_OVERFLOW_CLICK) <> '' then
      Result := Result + #13 + Format('EVT_AUITOOLBAR_OVERFLOW_CLICK(%s,%s::%s)',
        [WX_IDName, CurrClassName, EVT_AUITOOLBAR_OVERFLOW_CLICK]) + '';

    if trim(EVT_AUITOOLBAR_RIGHT_CLICK) <> '' then
      Result := Result + #13 + Format('EVT_AUITOOLBAR_RIGHT_CLICK(%s,%s::%s)',
        [WX_IDName, CurrClassName, EVT_AUITOOLBAR_RIGHT_CLICK]) + '';

    if trim(EVT_AUITOOLBAR_MIDDLE_CLICK) <> '' then
      Result := Result + #13 + Format('EVT_AUITOOLBAR_MIDDLE_CLICK(%s,%s::%s)',
        [WX_IDName, CurrClassName, EVT_AUITOOLBAR_MIDDLE_CLICK]) + '';

    if trim(EVT_AUITOOLBAR_BEGIN_DRAG) <> '' then
      Result := Result + #13 + Format('EVT_AUITOOLBAR_BEGIN_DRAG(%s,%s::%s)',
        [WX_IDName, CurrClassName, EVT_AUITOOLBAR_BEGIN_DRAG]) + '';

    if trim(EVT_UPDATE_UI) <> '' then
      Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
        [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

  end;

end;

function TWxAuiToolBar.GenerateXRCControlCreation(IndentString: string): TStringList;
var
  i: integer;
  wxcompInterface: IWxComponentInterface;
  tempstring: TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="wxAuiToolBar" name="%s">', [self.Name]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));

    {
        if not(UseDefaultSize)then
          Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
        if not(UseDefaultPos) then
          Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));
    }
    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetAuiToolBarSpecificStyle(self.Wx_GeneralStyle, self.Wx_ToolbarStyleSet)]));

    for i := 0 to self.ControlCount - 1 do // Iterate
      if self.Controls[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) then
        // Only add the XRC control if it is a child of the top-most parent (the form)
        //  If it is a child of a sizer, panel, or other object, then it's XRC code
        //  is created in GenerateXRCControlCreation of that control.
        if (self.Controls[i].GetParentComponent.Name = self.Name) then
        begin
          tempstring := wxcompInterface.GenerateXRCControlCreation('  ' + IndentString);
          try
            Result.AddStrings(tempstring);
          finally
            tempstring.Free;
          end;
        end;
    ; // for

    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxAuiToolBar.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment: string;
begin
  Result := '';
  Self.Wx_AuiManaged := True; //wxAuiToolbar is ALWAYS managed
  Self.Wx_Aui_Pane_Style :=  Self.Wx_Aui_Pane_Style +[ToolbarPane];                                     //always make sure we are a toolbar
  Self.Wx_Layer := 10;

  if Self.Wx_Aui_Dock_Direction = wxAUI_DOCK_NONE then
    Self.Wx_Aui_Dock_Direction := wxAUI_DOCK_TOP;

  if FWx_PaneCaption = '' then
    FWx_PaneCaption := Self.Name;
  if FWx_PaneName = '' then
    FWx_PaneName := Self.Name + '_Pane';

    parentName := GetWxWidgetParent(self, Wx_AuiManaged);

  strStyle := GetAuiToolBarSpecificStyle(self.Wx_GeneralStyle, self.Wx_ToolbarStyleSet);
  if (trim(strStyle) <> '') then
    strStyle := ', ' + strStyle;

  if (XRCGEN) then
  begin //generate xrc loading code
    Result := GetCommentString(self.FWx_Comments.Text) +
      Format('%s = wxXmlResource::Get()->LoadToolBar(%s,%s("%s"));',
      [self.Name, parentName, StringFormat, self.Name]);
  end
  else
  begin
    Result := GetCommentString(self.FWx_Comments.Text) +
      Format('%s = new %s(%s, %s, %s, %s%s);',
      [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
        self.Wx_IDValue),
      GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);
  end;

  if trim(self.Wx_ToolTip) <> '' then
    Result := Result + #13 + Format('%s->SetToolTip(%s);',
      [self.Name, GetCppString(self.Wx_ToolTip)]);

  if self.Wx_Hidden then
    Result := Result + #13 + Format('%s->Show(false);', [self.Name]);

  if not Wx_Enabled then
    Result := Result + #13 + Format('%s->Enable(false);', [self.Name]);

  if trim(self.Wx_HelpText) <> '' then
    Result := Result + #13 + Format('%s->SetHelpText(%s);',
      [self.Name, GetCppString(Wx_HelpText)]);

  strColorStr := trim(GetwxColorFromString(InvisibleFGColorString));
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetForegroundColour(%s);',
      [self.Name, strColorStr]);

  strColorStr := trim(GetwxColorFromString(InvisibleBGColorString));
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetBackgroundColour(%s);',
      [self.Name, strColorStr]);

  strColorStr := GetWxFontDeclaration(self.Font);
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetFont(%s);', [self.Name, strColorStr]);

  if not (XRCGEN) then //NUKLEAR ZELPH
    if (Wx_AuiManaged and FormHasAuiManager(self)) and not (self.Parent is TWxSizerPanel) then
    begin
{      Result := Result + #13 + Format('%s->Realize();', [self.Name]);
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
}
    end
    else
    begin
      if not (XRCGEN) then //NUKLEAR ZELPH
        if (self.Parent is TWxSizerPanel) then
        begin
          strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
          Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
            [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
            self.Wx_Border]);
        end;
    end;

end;

function TWxAuiToolBar.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxAuiToolBar.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/aui/aui.h>';
end;

function TWxAuiToolBar.GenerateImageInclude: string;
begin

end;

function TWxAuiToolBar.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxAuiToolBar.GetIDName: string;
begin
  Result := '';
  Result := wx_IDName;
end;

function TWxAuiToolBar.GetIDValue: integer;
begin
  Result := wx_IDValue;
end;

function TWxAuiToolBar.GetParameterFromEventName(EventName: string): string;
begin

  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
  if EventName = 'EVT_AUITOOLBAR_TOOL_DROPDOWN' then
  begin
    Result := 'wxAuiToolBarEvent& event';
    exit;
  end;
  if EventName = 'EVT_AUITOOLBAR_OVERFLOW_CLICK' then
  begin
    Result := 'wxAuiToolBarEvent& event';
    exit;
  end;
  if EventName = 'EVT_AUITOOLBAR_RIGHT_CLICK' then
  begin
    Result := 'wxAuiToolBarEvent& event';
    exit;
  end;
  if EventName = 'EVT_AUITOOLBAR_MIDDLE_CLICK' then
  begin
    Result := 'wxAuiToolBarEvent& event';
    exit;
  end;
  if EventName = 'EVT_AUITOOLBAR_BEGIN_DRAG' then
  begin
    Result := 'wxAuiToolBarEvent& event';
    exit;
  end;
end;

function TWxAuiToolBar.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxAuiToolBar.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxAuiToolBar.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxAuiToolBar.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxAuiToolBar';
  Result := wx_Class;
end;

procedure TWxAuiToolBar.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxAuiToolBar.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxAuiToolBar.SetIDValue(IDValue: integer);
begin
  Wx_IDValue := IDValue;
end;

procedure TWxAuiToolBar.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

function TWxAuiToolBar.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxAuiToolBar.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxAuiToolBar.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxAuiToolBar.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

procedure TWxAuiToolBar.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxAuiToolBar.GetGenericColor(strVariableName: string): string;
begin

end;

procedure TWxAuiToolBar.SetGenericColor(strVariableName, strValue: string);
begin

end;

function TWxAuiToolBar.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxAuiToolBar.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxAuiToolBar.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxAuiToolBar.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxAuiToolBar.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxAuiToolBar.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

procedure TWxAuiToolBar.DummySizerNonInsertableInterfaceProcedure;
begin
end;

function TWxAuiToolBar.GenerateLastCreationCode: string;
begin
  Result := '';
end;

procedure TWxAuiToolBar.SetToolbarStyle(Value: TWxAuiTbrStyleSet);
begin
  {mn    if (wxTB_TEXT in Value) or (wxTB_HORZ_TEXT in Value) then
        self.ShowCaptions:=true
      else
        self.ShowCaptions:=false;
      FWx_ToolbarStyleSet:=Value;
  }
end;


function TWxAuiToolBar.GetRealizeString: string;
begin
  Result := '';
  Self.Wx_AuiManaged := True; //wxAuiToolbar is ALWAYS managed
  Self.Wx_Aui_Pane_Style := Self.Wx_Aui_Pane_Style + [ToolbarPane]; //always make sure we are a toolbar
  Self.Wx_Layer := 10;

  if Self.Wx_Aui_Dock_Direction = wxAUI_DOCK_NONE then
    Self.Wx_Aui_Dock_Direction := wxAUI_DOCK_TOP;

  if FWx_PaneCaption = '' then
    FWx_PaneCaption := Self.Name;
  if FWx_PaneName = '' then
    FWx_PaneName := Self.Name + '_Pane';

    if (Wx_AuiManaged and FormHasAuiManager(self)) and not (self.Parent is TWxSizerPanel) then
    begin
   Result := Result + Format('%s->Realize();', [self.Name]);
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
    end
end;

end.

