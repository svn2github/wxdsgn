// $Id: WxScrolledWindow.pas 936 2007-05-15 03:47:39Z gururamnath $
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


unit WxScrolledWindow;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Graphics, wxUtils, wxSizerPanel, WxAuiNotebookPage, wxAuiToolBar;

type
  TWxScrolledWindow = class(TScrollBox, IWxComponentInterface,
    IWxWindowInterface, IWxContainerInterface, IWxContainerAndSizerInterface)
  private
    { Private declarations }
    FWx_BKColor: TColor;
    FWx_Border: integer;
    FWx_Class: string;
    FWx_ControlOrientation: TWxControlOrientation;
    FWx_Default: boolean;
    FWx_Enabled: boolean;
    FWx_EventList: TStringList;
    FWx_FGColor: TColor;
    FWx_GeneralStyle: TWxStdStyleSet;
    FWx_ScrollWinStyle: TWxScrWinStyleSet;

    FWx_HelpText: string;
    FWx_Hidden: boolean;
    FWx_IDName: string;
    FWx_IDValue: longint;
    FWx_ProxyBGColorString: TWxColorString;
    FWx_ProxyFGColorString: TWxColorString;
    FWx_StretchFactor: integer;
    FWx_ToolTip: string;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_Comments: TStrings;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

    {Event Lisiting}
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

    { Private methods of TWxScrolledWindow }
    procedure AutoInitialize;
    procedure AutoDestroy;
  protected
    { Protected declarations }
  public
    { Public declarations }
    { Public fields and properties of TWxScrolledWindow }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxScrolledWindow }
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

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);
    function GenerateLastCreationCode: string;

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

  published
    { Published properties of TWxScrolledWindow }
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Wx_BKColor: TColor Read FWx_BKColor Write FWx_BKColor;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_Default: boolean Read FWx_Default Write FWx_Default;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_EventList: TStringList Read FWx_EventList Write FWx_EventList;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_ScrollWinStyle: TWxScrWinStyleSet
      Read FWx_ScrollWinStyle Write FWx_ScrollWinStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue default -1;
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
  RegisterComponents('wxWidgets', [TWxScrolledWindow]);
end;

procedure TWxScrolledWindow.AutoInitialize;
begin
  Caption                := '';
  FWx_Comments           := TStringList.Create;
  FWx_PropertyList       := TStringList.Create;
  FWx_EventList          := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxScrolledWindow';
  FWx_Enabled            := True;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_IDValue            := -1;
  FWx_StretchFactor      := 0;
  FWx_GeneralStyle       := [wxHSCROLL, wxVSCROLL];
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor         := self.color;
  defaultFGColor         := self.font.color;

end; { of AutoInitialize }


procedure TWxScrolledWindow.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

constructor TWxScrolledWindow.Create(AOwner: TComponent);
begin
  { Call the Create method of the container's parent class       }
  inherited Create(AOwner);

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

  FWx_PropertyList.add('Wx_ScrollWinStyle: Scrolled Window Styles');
  FWx_PropertyList.add('wxRETAINED :wxRETAINED ');

  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxScrolledWindow.Destroy;
begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
  AutoDestroy;

  { Last, free the component by calling the Destroy method of the    }
  { parent class.                                                    }
  inherited Destroy;
end;


function TWxScrolledWindow.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxScrolledWindow.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxScrolledWindow.GenerateEventTableEntries(CurrClassName: string): string;
begin

  Result := '';

    if (XRCGEN) then
 begin
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
 end
 else
 begin
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
 end;

end;

function TWxScrolledWindow.GenerateXRCControlCreation(IndentString: string): TStringList;
var
  tempstring: TStringList;
  i: integer;
  wxcompInterface: IWxComponentInterface;
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

    for i := 0 to self.ControlCount - 1 do // Iterate
      if self.Controls[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) then
        // Only add the XRC control if it is a child of the top-most parent (the form)
        //  If it is a child of a sizer, panel, or other object, then it's XRC code
        //  is created in GenerateXRCControlCreation of that control.
        if (self.Controls[i].GetParentComponent.Name = self.Name) then
        begin
          tempstring := wxcompInterface.GenerateXRCControlCreation('    ' + IndentString);
          try
            Result.AddStrings(tempstring)
          finally
            tempstring.Free
          end
        end; // for

    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxScrolledWindow.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment: string;
begin
  Result := '';

    if FWx_PaneCaption = '' then
    FWx_PaneCaption := Self.Name;
  if FWx_PaneName = '' then
    FWx_PaneName := Self.Name + '_Pane';

  parentName := GetWxWidgetParent(self, Wx_AuiManaged);

  strStyle := GetScrolledWindowSpecificStyle(self.Wx_GeneralStyle,
    self.Wx_ScrollWinStyle);
  if (trim(strStyle) <> '') then
    strStyle := ', ' + strStyle;

if (XRCGEN) then
 begin//generate xrc loading code
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
    [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);   
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
      [self.Name, GetCppString(self.Wx_HelpText)]);

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

      if (self.Parent is TWxAuiToolBar) then
        Result := Result + #13 + Format('%s->AddControl(%s);',
          [self.Parent.Name, self.Name]);
    end;
  end;

end;

function TWxScrolledWindow.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxScrolledWindow.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/scrolwin.h>';
end;

function TWxScrolledWindow.GenerateImageInclude: string;
begin

end;

function TWxScrolledWindow.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxScrolledWindow.GetIDName: string;
begin
  Result := '';
  Result := wx_IDName;
end;

function TWxScrolledWindow.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxScrolledWindow.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxScrolledWindow.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxScrolledWindow.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxScrolledWindow.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxScrolledWindow.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxScrolledWindow.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxScrolledWindow.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxScrolledWindow.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxScrolledWindow.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxScrolledWindow';
  Result := wx_Class;
end;

procedure TWxScrolledWindow.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxScrolledWindow.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxScrolledWindow.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxScrolledWindow.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxScrolledWindow.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxScrolledWindow.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxScrolledWindow.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxScrolledWindow.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxScrolledWindow.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxScrolledWindow.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxScrolledWindow.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxScrolledWindow.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxScrolledWindow.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxScrolledWindow.GenerateLastCreationCode: string;
begin
  Result := '';
end;


end.
