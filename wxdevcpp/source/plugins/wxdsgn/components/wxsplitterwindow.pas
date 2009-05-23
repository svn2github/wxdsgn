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

unit WxSplitterWindow;

interface

uses WinTypes, WinProcs, Messages, Classes, Controls,
  Forms, Graphics, ExtCtrls, WxUtils, WxSizerPanel, WxAuiNotebookPage, wxAuiToolBar, dbugintf;

type
  TWxSplitterWindow = class(TPanel, IWxComponentInterface, IWxWindowInterface,
    IWxContainerInterface, IWxContainerAndSizerInterface,IWxSplitterInterface)
  private
    FOrientation: TWxSizerOrientation;
    FSpaceValue: integer;
    FWx_Class: string;
    FWx_ControlOrientation: TWxControlOrientation;
    FWx_EventList: TStringList;
    FWx_IDName: string;
    FWx_IDValue: integer;
    FWx_StretchFactor: integer;
    FWx_Border: integer;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_GeneralStyle: TWxStdStyleSet;
    FWx_SplitterStyle: TWxSplitterWinStyleSet;
    FWx_Comments: TStrings;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

    FEVT_SPLITTER_SASH_POS_CHANGING: string;
    FEVT_SPLITTER_SASH_POS_CHANGED: string;
    FEVT_SPLITTER_UNSPLIT: string;
    FEVT_SPLITTER_DCLICK: string;
    FEVT_UPDATE_UI: string;
    FWx_SashPosition: integer;

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


    procedure AutoInitialize;
    procedure AutoDestroy;
   // procedure SetWx_EventList(Value: TStringList);

  protected
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Resize; override;
    procedure Loaded; override;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;

  public
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

    function GenerateLastCreationCode: string;

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

  published
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
    property EVT_SPLITTER_SASH_POS_CHANGING: string
      Read FEVT_SPLITTER_SASH_POS_CHANGING Write FEVT_SPLITTER_SASH_POS_CHANGING;
    property EVT_SPLITTER_SASH_POS_CHANGED: string
      Read FEVT_SPLITTER_SASH_POS_CHANGED Write FEVT_SPLITTER_SASH_POS_CHANGED;
    property EVT_SPLITTER_UNSPLIT: string Read FEVT_SPLITTER_UNSPLIT
      Write FEVT_SPLITTER_UNSPLIT;
    property EVT_SPLITTER_DCLICK: string Read FEVT_SPLITTER_DCLICK
      Write FEVT_SPLITTER_DCLICK;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Orientation: TWxSizerOrientation
      Read FOrientation Write FOrientation default wxHorizontal;
    property SpaceValue: integer Read FSpaceValue Write FSpaceValue default 5;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_EventList: TStringList Read FWx_EventList Write FWx_EventList;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: integer Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_SashPosition: integer Read FWx_SashPosition Write FWx_SashPosition;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_SplitterStyle: TWxSplitterWinStyleSet
      Read FWx_SplitterStyle Write FWx_SplitterStyle;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;

    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

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
uses
  SysUtils;

procedure Register;
begin
  RegisterComponents('wxSplitterWindow', [TWxSplitterWindow]);
end;

procedure TWxSplitterWindow.AutoInitialize;
begin
  FWx_EventList       := TStringList.Create;
  FWx_Comments        := TStringList.Create;
  FWx_PropertyList    := TStringList.Create;
  FOrientation        := wxHorizontal;
  FSpaceValue         := 5;
  FWx_Border          := 0;
  FWx_SashPosition    := 0;
  FWx_Class           := 'wxSplitterWindow';
  FWx_BorderAlignment := [wxAll];
  FWx_Alignment       := [wxALIGN_CENTER];
  FWx_IDValue         := -1;
end; { of AutoInitialize }

procedure TWxSplitterWindow.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

procedure TWxSplitterWindow.Click;
begin
  inherited Click;
end;

procedure TWxSplitterWindow.KeyPress(var Key: char);
const
  TabKey   = char(VK_TAB);
  EnterKey = char(VK_RETURN);
begin
  inherited KeyPress(Key);
end;

procedure TWxSplitterWindow.Resize;
begin
  inherited Resize;
end;

constructor TWxSplitterWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
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

end;

destructor TWxSplitterWindow.Destroy;
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


function TWxSplitterWindow.GenerateEnumControlIDs: string;
begin
  Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
end;

function TWxSplitterWindow.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxSplitterWindow.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
  
    if (XRCGEN) then
 begin
    if trim(EVT_SPLITTER_SASH_POS_CHANGING) <> '' then
    Result := Format('EVT_SPLITTER_SASH_POS_CHANGING(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_SPLITTER_SASH_POS_CHANGING]) + '';
  
  if trim(EVT_SPLITTER_SASH_POS_CHANGED) <> '' then
    Result := Format('EVT_SPLITTER_SASH_POS_CHANGED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_SPLITTER_SASH_POS_CHANGED]) + '';
  
  if trim(EVT_SPLITTER_DCLICK) <> '' then
    Result := Format('EVT_SPLITTER_DCLICK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_SPLITTER_DCLICK]) + '';
  
  if trim(EVT_SPLITTER_UNSPLIT) <> '' then
    Result := Format('EVT_SPLITTER_UNSPLIT(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_SPLITTER_UNSPLIT]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';
   end
 else
 begin
  if trim(EVT_SPLITTER_SASH_POS_CHANGING) <> '' then
    Result := Format('EVT_SPLITTER_SASH_POS_CHANGING(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_SPLITTER_SASH_POS_CHANGING]) + '';
  
  if trim(EVT_SPLITTER_SASH_POS_CHANGED) <> '' then
    Result := Format('EVT_SPLITTER_SASH_POS_CHANGED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_SPLITTER_SASH_POS_CHANGED]) + '';
  
  if trim(EVT_SPLITTER_DCLICK) <> '' then
    Result := Format('EVT_SPLITTER_DCLICK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_SPLITTER_DCLICK]) + '';
  
  if trim(EVT_SPLITTER_UNSPLIT) <> '' then
    Result := Format('EVT_SPLITTER_UNSPLIT(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_SPLITTER_UNSPLIT]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';
  end
end;

function TWxSplitterWindow.GenerateXRCControlCreation(IndentString: string): TStringList;
  var
  strOrientation: string;
  i: integer;
  wxcompInterface: IWxComponentInterface;
  tempstring: TStringList;
  begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <label>%s</label>', [self.Caption]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));

    if not(UseDefaultSize)then
      Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    if not(UseDefaultPos) then
      Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + Format('  <sashpos>%d</sashpos>', [self.Wx_SashPosition]));
    if Orientation = wxVertical then
      strOrientation := 'vertical'
    else
      strOrientation := 'horizontal';
    Result.Add(IndentString + Format('  <orientation>%s</orientation>', [strOrientation]));
    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetSplitterWindowSpecificStyle(self.Wx_GeneralStyle, Wx_SplitterStyle)]));
  
  for i := 0 to self.ControlCount - 1 do // Iterate
      if self.Controls[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) then
        // Only add the XRC control if it is a child of the top-most parent (the form)
        //  If it is a child of a sizer, panel, or other object, then it's XRC code
        //  is created in GenerateXRCControlCreation of that control.
        if (self.Controls[i].GetParentComponent.Name = self.Name) then
        begin
          tempstring := wxcompInterface.GenerateXRCControlCreation('    ' + IndentString);
          try
            Result.AddStrings(tempstring);
          finally
            tempstring.Free;
          end;
        end; // for
  
    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxSplitterWindow.GenerateGUIControlCreation: string;
var
  strColorStr:  string;
  strAlignment: string;
  parentName:   string;
  strStyle:     string;
begin
    if FWx_PaneCaption = '' then
    FWx_PaneCaption := Self.Name;
  if FWx_PaneName = '' then
    FWx_PaneName := Self.Name + '_Pane';

  parentName := GetWxWidgetParent(self, Wx_AuiManaged);
  strStyle   := GetSplitterWindowSpecificStyle(self.Wx_GeneralStyle,
    self.Wx_SplitterStyle);

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
      self.wx_Border]);
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

function TWxSplitterWindow.GenerateGUIControlDeclaration: string;
begin
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxSplitterWindow.GenerateHeaderInclude: string;
begin
  Result := '#include <wx/splitter.h>';
end;

function TWxSplitterWindow.GenerateImageInclude: string;
begin

end;

function TWxSplitterWindow.GetEventList: TStringList;
begin
  Result := Wx_EventList;
end;

function TWxSplitterWindow.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxSplitterWindow.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxSplitterWindow.GetParameterFromEventName(EventName: string): string;
begin
  if (EventName = 'EVT_SPLITTER_SASH_POS_CHANGING') or
    (EventName = 'EVT_SPLITTER_SASH_POS_CHANGED') or
    (EventName = 'EVT_SPLITTER_UNSPLIT') or (EventName = 'EVT_SPLITTER_DCLICK') then
  begin
    Result := 'wxSplitterEvent& event';
    exit;
  end;

  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxSplitterWindow.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxSplitterWindow.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxSplitterWindow.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxSplitterWindow.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxSplitterWindow.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxSplitterWindow.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxSplitterWindow.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxSplitterWindow.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxSplitterWindow';
  Result := wx_Class;
end;

procedure TWxSplitterWindow.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxSplitterWindow.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxSplitterWindow.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxSplitterWindow.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxSplitterWindow.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxSplitterWindow.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

procedure TWxSplitterWindow.WMPaint(var Message: TWMPaint);
var
  extraHeight: integer;
  maxWidth, maxHt: integer;
  totalmaxWidth, totalmaxHt: integer;
  startX : integer;
  i: integer;
  coordTop, coordLeft: integer;
  wxcompInterface: IWxComponentInterface;
  cntIntf: IWxContainerInterface;
  splitIntf: IWxSplitterInterface;  
begin
  //Make this component look like its parent component by calling its parent's
  //Paint method.
  Caption := '';
  if ControlCount < 1 then
  begin
    inherited;
    Exit;
  end;

  if (ControlCount > 0) and (Wx_SashPosition = 0) then
    Wx_SashPosition := self.Controls[0].Width;

  totalmaxWidth := 0;
  totalmaxHt    := 0;
  maxWidth      := 0;
  maxHt         := 2 * self.FSpaceValue;

  for i := 0 to self.ControlCount - 1 do
  begin
    //Calculate the total size for all children
    if IsControlWxNonVisible(Controls[i]) then
      Continue;

    totalmaxWidth := totalmaxWidth + self.Controls[i].Width + 2 * self.FSpaceValue;
    totalmaxHt    := totalmaxHt + self.Controls[i].Height + 2 * self.FSpaceValue;

    if self.Controls[i].Width > maxWidth then
      maxWidth := self.Controls[i].Width;

    if self.Controls[i].Height > maxHt then
      maxHt := self.Controls[i].Height;

    //Set the control orientation
    if self.Controls[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) then
      if Orientation = wxVertical then
        wxcompInterface.SaveControlOrientation(wxControlVertical)
      else
        wxcompInterface.SaveControlOrientation(wxControlHorizontal);
  end;

  if self.Parent is TForm then
  begin
    extraHeight := 0;
    for i := 0 to TForm(self.Parent).ControlCount - 1 do
      if Parent.Controls[i].ClassName = 'TWxStatusBar' then
        Inc(extraHeight, Parent.Controls[i].Height);

    if totalmaxWidth < 20 then
      self.Parent.ClientWidth := 20
    else if self.Orientation = wxHorizontal then
      self.Parent.ClientWidth := totalmaxWidth + self.FSpaceValue + self.FSpaceValue
    else
      self.Parent.ClientWidth := maxWidth + self.FSpaceValue + self.FSpaceValue + self.FSpaceValue;

    if totalmaxht < 20 then
      self.Parent.ClientHeight := 20 + extraHeight
    else if self.Orientation = wxVertical then
      if maxht + 2 * self.FSpaceValue < 35 then
        self.Parent.ClientHeight := 35 + extraHeight
      else
        self.Parent.ClientHeight := totalmaxht + self.FSpaceValue + self.FSpaceValue + extraHeight
    else
      self.Parent.ClientHeight := maxht + self.FSpaceValue + self.FSpaceValue + extraHeight;
    self.Align := alClient;
  end
  else
  begin
    if self.parent.GetInterface(IDD_IWxContainerInterface, cntIntf) then
      if self.parent.GetInterface(IID_IWxSplitterInterface, splitIntf) then
        self.Align := alNone
      else
        self.Align := alClient
    else
      self.Align := alNone;

    if self.Orientation = wxVertical then
    begin
      if maxHt * self.ControlCount + self.ControlCount * 2 * self.FSpaceValue = 0 then
        self.Height := 4 * self.FSpaceValue
      else
        self.Height := totalmaxHt;
      self.Width := maxWidth + 2 * self.FSpaceValue;
    end
    else
    begin
      if maxWidth = 0 then
        self.Width := 4 * self.FSpaceValue
      else
        self.Width := totalmaxWidth + 2 * self.FSpaceValue;
      self.Height := maxHt + 2 * self.FSpaceValue;
    end;
  end;

  startX := FSpaceValue;

  if Orientation = wxHorizontal then
    for i := 0 to self.ControlCount - 1 do
    begin
      if IsControlWxNonVisible(Controls[i]) then
        continue;

      coordTop := maxHt + 2 * FSpaceValue - self.Controls[i].Height;
      self.Controls[i].Top := coordTop div 2;
      self.Controls[i].left := startX;
      startX   := startX + self.Controls[i].Width + FSpaceValue + FSpaceValue;
    end
  else
    for i := 0 to self.ControlCount - 1 do
    begin
      if IsControlWxNonVisible(Controls[i]) then
        continue;

      coordLeft := maxWidth + 2 * FSpaceValue - self.Controls[i].Width;
      self.Controls[i].left := coordLeft div 2;
      self.Controls[i].Top := startX;
      startX    := startX + self.Controls[i].Height + FSpaceValue + self.FSpaceValue;
    end;


{  //if self.parent.GetInterface(IDD_IWxContainerInterface,cntIntf) then
  begin
    if Self.Height > parent.Height then
      parent.Height := Self.Height;

    if Self.Width > parent.Width then
      parent.Width := Self.Width;
  end;}

  inherited;
end;

function TWxSplitterWindow.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxSplitterWindow.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxSplitterWindow.GetFGColor: string;
begin
end;

procedure TWxSplitterWindow.SetFGColor(strValue: string);
begin
end;

function TWxSplitterWindow.GetBGColor: string;
begin
end;

procedure TWxSplitterWindow.SetBGColor(strValue: string);
begin
end;

function TWxSplitterWindow.GenerateLastCreationCode: string;
var
  strFirstControl, strSecondControl, strOrientation: string;

  function GenerateParentSizerCode: string;
  begin

  end;

begin
  Result := GenerateParentSizerCode;
  if self.ControlCount = 0 then
    exit;

  if self.ControlCount > 0 then
    strFirstControl := self.Controls[0].Name;

  if self.ControlCount > 1 then
    strSecondControl := self.Controls[1].Name;

  strOrientation := 'SplitHorizontally';
  if self.Orientation = wxVertical then
    strOrientation := 'SplitHorizontally'
  else
    strOrientation := 'SplitVertically';
  
if not XRCGEN then
begin
  if self.ControlCount = 1 then
  begin
    if Result = '' then
      Result := Format('%s->Initialize(%s);', [self.Name, strFirstControl])
    else
      Result := Result + #13 + #10 +
        Format('%s->Initialize(%s);', [self.Name, strFirstControl]);
    exit;
  end;

  if self.ControlCount > 1 then
  begin
    if Result = '' then
      Result := Format('%s->%s(%s,%s,%d);',
        [self.Name, strOrientation, strFirstControl, strSecondControl,
        self.Wx_SashPosition])
    else
      Result := Result + #13 + #10 + Format('%s->%s(%s,%s,%d);',
        [self.Name, strOrientation, strFirstControl, strSecondControl,
        self.Wx_SashPosition]);
    exit;
  end;
end;//Nuklear Zelph
end;

end.
