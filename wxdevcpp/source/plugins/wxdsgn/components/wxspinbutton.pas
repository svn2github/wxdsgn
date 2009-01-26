 { ****************************************************************** }
 {                                                                    }
{ $Id: wxspinbutton.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
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

unit WxSpinButton;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ComCtrls, WxUtils, ExtCtrls, WxSizerPanel, wxAuiToolBar, WxAuiNotebookPage, WxToolBar;

type
  TWxSpinButton = class(TUpDown, IWxComponentInterface, IWxToolBarInsertableInterface,
    IWxToolBarNonInsertableInterface)
  private
    { Private fields of TWxSpinButton }
    { Storage for property EVT_SPIN }
    FEVT_SPIN: string;
    { Storage for property EVT_SPIN_DOWN }
    FEVT_SPIN_DOWN: string;
    { Storage for property EVT_SPIN_UP }
    FEVT_SPIN_UP: string;
    { Storage for property EVT_UPDATE_UI }
    FEVT_UPDATE_UI: string;
    { Storage for property Wx_BGColor }
    FWx_BGColor: TColor;
    { Storage for property Wx_Border }
    FWx_Border: integer;
    { Storage for property Wx_Class }
    FWx_Class: string;
    { Storage for property Wx_ControlOrientation }
    FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_Enabled }
    FWx_Enabled: boolean;
    { Storage for property Wx_FGColor }
    FWx_FGColor: TColor;
    { Storage for property Wx_GeneralStyle }
    FWx_GeneralStyle: TWxStdStyleSet;
    { Storage for property Wx_HelpText }
    FWx_HelpText: string;
    { Storage for property Wx_Hidden }
    FWx_Hidden: boolean;
    { Storage for property Wx_IDName }
    FWx_IDName: string;
    { Storage for property Wx_IDValue }
    FWx_IDValue: longint;
    { Storage for property Wx_Max }
    FWx_Max: integer;
    { Storage for property Wx_Position }
//mn    FWx_Position: integer;
    { Storage for property Wx_ProxyBGColorString }
    FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
    FWx_ProxyFGColorString: TWxColorString;
    { Storage for property Wx_SpinButtonStyle }
    FWx_SpinButtonStyle: TWxsbtnStyleSet;
    { Storage for property Wx_SpinButtonOrientation }
    FWx_SpinButtonOrientation: TWxsbtnOrientation;
    { Storage for property Wx_StretchFactor }
    FWx_StretchFactor: integer;
    { Storage for property Wx_ToolTip }
    FWx_ToolTip: string;
    FWx_EventList: TStringList;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_Comments: TStrings;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

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

    { Private methods of TWxSpinButton }
    { Method to set variable and property values and create objects }
    procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
    procedure AutoDestroy;

  protected
    { Protected fields of TWxSpinButton }

    { Protected methods of TWxSpinButton }
    procedure Loaded; override;

  public
    { Public fields and properties of TWxSpinButton }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxSpinButton }
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
    function GetIDValue: longint;
    function GetParameterFromEventName(EventName: string): string;
    function GetPropertyList: TStringList;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: longint);
    procedure SetWxClassName(wxClassName: string);

    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    function GetSpinButtonOrientation(Value: TWxsbtnOrientation): string;

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

  published
    { Published properties of TWxSpinButton }
    property EVT_SPIN: string Read FEVT_SPIN Write FEVT_SPIN;
    property EVT_SPIN_DOWN: string Read FEVT_SPIN_DOWN Write FEVT_SPIN_DOWN;
    property EVT_SPIN_UP: string Read FEVT_SPIN_UP Write FEVT_SPIN_UP;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden default False;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_Max: integer Read FWx_Max Write FWx_Max;
//    property Wx_Position: integer Read FWx_Position Write FWx_Position;
    property Wx_SpinButtonStyle: TWxsbtnStyleSet
      Read FWx_SpinButtonStyle Write FWx_SpinButtonStyle;
    property Wx_SpinButtonOrientation: TWxsbtnOrientation
      Read FWx_SpinButtonOrientation Write FWx_SpinButtonOrientation;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;

    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

//Aui Properties
    property Wx_AuiManaged: boolean read FWx_AuiManaged write FWx_AuiManaged default False;
    property Wx_PaneCaption: string read FWx_PaneCaption write FWx_PaneCaption;
    property Wx_PaneName: string read FWx_PaneName write FWx_PaneName;
    property Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem read FWx_Aui_Dock_Direction write FWx_Aui_Dock_Direction;
    property Wx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet read FWx_Aui_Dockable_Direction write FWx_Aui_Dockable_Direction;
    property Wx_Aui_Pane_Style: TwxAuiPaneStyleSet read FWx_Aui_Pane_Style write FWx_Aui_Pane_Style;
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
     { Register TWxSpinButton with wxWidgets as its
       default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TWxSpinButton]);
end;

{ Method to set variable and property values and create objects }
procedure TWxSpinButton.AutoInitialize;
begin
  FWx_Comments           := TStringList.Create;
  FWx_EventList          := TStringList.Create;
  FWx_PropertyList       := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxSpinButton';
  FWx_Enabled            := True;
  FWx_Hidden             := False;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_IDValue            := -1;
  FWx_StretchFactor      := 0;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor         := self.color;
  defaultFGColor         := self.font.color;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxSpinButton.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_Comments.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
end; { of AutoDestroy }

constructor TWxSpinButton.Create(AOwner: TComponent);
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

  FWx_PropertyList.add('Wx_SpinButtonStyle:Spin Button Style');
  FWx_PropertyList.add('Wx_SpinButtonOrientation:Orientation');
  FWx_PropertyList.Add('wxSP_ARROW_KEYS:wxSP_ARROW_KEYS');
  FWx_PropertyList.Add('wxSP_WRAP:wxSP_WRAP');

  FWx_PropertyList.add('Max:Max');
  FWx_PropertyList.add('Min:Min');

  FWx_EventList.add('EVT_SPIN : OnUpdated');
  FWx_EventList.add('EVT_SPIN_UP : OnUp');
  FWx_EventList.add('EVT_SPIN_DOWN : OnDown');
  FWx_EventList.add('EVT_UPDATE_UI : OnUpdateUI');

end;

destructor TWxSpinButton.Destroy;
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

function TWxSpinButton.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxSpinButton.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxSpinButton.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

if (XRCGEN) then
 begin//generate xrc loading code 
  if trim(EVT_SPIN) <> '' then
    Result := Format('EVT_SPIN(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName, EVT_SPIN]) + '';

  if trim(EVT_SPIN_UP) <> '' then
    Result := Result + #13 + Format('EVT_SPIN_UP(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_SPIN_UP]) + '';
  if trim(EVT_SPIN_DOWN) <> '' then
    Result := Result + #13 + Format('EVT_SPIN_DOWN (XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_SPIN_DOWN]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
end
else
begin
  if trim(EVT_SPIN) <> '' then
    Result := Format('EVT_SPIN(%s,%s::%s)', [WX_IDName, CurrClassName, EVT_SPIN]) + '';

  if trim(EVT_SPIN_UP) <> '' then
    Result := Result + #13 + Format('EVT_SPIN_UP(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_SPIN_UP]) + '';
  if trim(EVT_SPIN_DOWN) <> '' then
    Result := Result + #13 + Format('EVT_SPIN_DOWN (%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_SPIN_DOWN]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
end;

end;

function TWxSpinButton.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));

    if not(UseDefaultSize)then
      Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    if not(UseDefaultPos) then
      Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + Format('  <min>%d</min>', [self.Min]));
    Result.Add(IndentString + Format('  <max>%d</max>', [self.Max]));
    Result.Add(IndentString + Format('  <value>%d</value>', [self.Position]));

    Result.Add(IndentString + Format('  <orient>%s</orient>',
      [GetSpinButtonOrientation(Wx_SpinButtonOrientation)]));

    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetSpinButtonSpecificStyle(self.Wx_GeneralStyle, Wx_SpinButtonStyle, [])]));

    Result.Add(IndentString + '</object>');
  except
    Result.Free;
    raise;
  end;

end;

function TWxSpinButton.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment: string;
begin
  Result := '';

  {  if self.Orientation = udHorizontal then
        Wx_SpinButtonStyle:=Wx_SpinButtonStyle - [wxSP_VERTICAL  ] + [wxSP_HORIZONTAL]
    else
        Wx_SpinButtonStyle:=Wx_SpinButtonStyle - [wxSP_HORIZONTAL] + [wxSP_VERTICAL  ];
    }

    if FWx_PaneCaption = '' then
    FWx_PaneCaption := Self.Name;
  if FWx_PaneName = '' then
    FWx_PaneName := Self.Name + '_Pane';

  parentName := GetWxWidgetParent(self, Wx_AuiManaged);

  strStyle := GetSpinButtonSpecificStyle(self.Wx_GeneralStyle, Wx_SpinButtonStyle, []);
  if (trim(strStyle) <> '') then
    strStyle := ', ' + GetSpinButtonOrientation(Wx_SpinButtonOrientation) +
      ' | ' + strStyle
  else
    strStyle := ', ' + GetSpinButtonOrientation(Wx_SpinButtonOrientation);

  strStyle := strStyle + ', ' + GetCppString(Name);

if (XRCGEN) then
 begin
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
    [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);
 end
 else
 begin
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, %s, %s%s);',
    [self.Name, self.Wx_Class, parentName, GetWxIDString(self.Wx_IDName,
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
      [self.Name, GetCppString(self.Wx_HelpText)]);

 if not (XRCGEN) then
 begin
  Result := Result + #13 + Format('%s->SetRange(%d,%d);',
    [self.Name, self.Min, self.Max]);
  Result := Result + #13 + Format('%s->SetValue(%d);', [self.Name, self.Position]);
 end;
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
  begin
    if (Wx_AuiManaged and FormHasAuiManager(self)) and not (self.Parent is TWxSizerPanel) then
    begin
      if HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) then
      begin
        Self.Wx_Aui_Pane_Style := Self.Wx_Aui_Pane_Style + [ToolbarPane]; //always make sure we are a toolbar
        Self.Wx_Layer := 10;
      end;

      if not HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) then
      begin
        if (self.Parent.ClassName = 'TWxPanel') then
          if not (self.Parent.Parent is TForm) then
            Result := Result + #13 + Format('%s->Reparent(this);', [parentName]);
      end;

      if (self.Parent is TWxAuiToolBar) then
        Result := Result + #13 + Format('%s->AddControl(%s);',
          [self.Parent.Name, self.Name])
      else
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
    else
    begin
  if (self.Parent is TWxSizerPanel) then
  begin
    strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
    Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);
  end;

      if (self.Parent is TWxAuiNotebookPage) then
      begin
        //        strParentLabel := TWxAuiNoteBookPage(Self.Parent).Caption;
        Result := Result + #13 + Format('%s->AddPage(%s, %s);',
          //          [self.Parent.Parent.Name, self.Name, GetCppString(strParentLabel)]);
          [self.Parent.Parent.Name, self.Name, GetCppString(TWxAuiNoteBookPage(Self.Parent).Caption)]);
      end;

      if (self.Parent is TWxAuiToolBar) or (self.Parent is TWxToolBar) then
    Result := Result + #13 + Format('%s->AddControl(%s);',
      [self.Parent.Name, self.Name]);
    end;
  end;

end;

function TWxSpinButton.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxSpinButton.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/spinbutt.h>';
end;

function TWxSpinButton.GenerateImageInclude: string;
begin

end;

function TWxSpinButton.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxSpinButton.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxSpinButton.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxSpinButton.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_SPIN' then
  begin
    Result := 'wxSpinEvent& event';
    exit;
  end;

  if EventName = 'EVT_SPIN_UP' then
  begin
    Result := 'wxSpinEvent& event';
    exit;
  end;

  if EventName = 'EVT_SPIN_DOWN' then
  begin
    Result := 'wxSpinEvent& event';
    exit;
  end;

  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxSpinButton.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxSpinButton.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxSpinButton.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxSpinButton.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxSpinButton.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxSpinButton.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxSpinButton.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxSpinButton.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxSpinButton';
  Result := wx_Class;
end;

procedure TWxSpinButton.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxSpinButton.SaveControlOrientation(ControlOrientation:
  TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxSpinButton.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxSpinButton.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxSpinButton.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxSpinButton.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxSpinButton.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxSpinButton.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxSpinButton.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxSpinButton.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxSpinButton.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxSpinButton.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxSpinButton.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxSpinButton.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxSpinButton.GetSpinButtonOrientation(Value: TWxsbtnOrientation): string;
begin
  Result := '';
  if Value = wxSP_VERTICAL then
  begin
    Result := 'wxSP_VERTICAL';
    self.Orientation := udVertical;
    exit;
  end;
  if Value = wxSP_HORIZONTAL then
  begin
    Result := 'wxSP_HORIZONTAL';
    self.Orientation := udHorizontal;
    exit;
  end;

end;

end.
