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

unit wxListbook;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ComCtrls, ExtCtrls, StdCtrls, WxUtils, WxSizerPanel, WxListCtrl, wxnotebook, ListViewPageControl, WxAuiNotebookPage, wxAuiToolBar;

type
  TWxListbook = class(TListViewPageControl, IWxComponentInterface, IWxContainerInterface,
    IWxContainerAndSizerInterface, IWxWindowInterface)
  private
    FOrientation: TWxSizerOrientation;
    FWx_Caption: string;
    FWx_Class: string;
    FWx_ControlOrientation: TWxControlOrientation;
    FWx_EventList: TStringList;
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
//    FWx_ListBookStyle: TWxlbbxStyleSet;
    FWx_GeneralStyle: TWxStdStyleSet;
    FWx_Comments: TStrings;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

    FWx_ProxyBGColorString: TWxColorString;
    FWx_ProxyFGColorString: TWxColorString;

    FWx_BookAlignment: TWxlbbxAlignStyleItem;



    FEVT_UPDATE_UI: string;
    FEVT_LISTBOOK_PAGE_CHANGED: string;
    FEVT_LISTBOOK_PAGE_CHANGING: string;



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

    { Private methods of TWxListbook }
    procedure AutoInitialize;
    procedure AutoDestroy;

  protected

    procedure Loaded; override;

  public
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxListbook }
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
    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    function GenerateLastCreationCode: string;
//    procedure SetListbookStyle(style: TWxlbbxStyleSet);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

    function GetBookAlignment(Value: TWxlbbxAlignStyleItem): string;


  published
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property EVT_LISTBOOK_PAGE_CHANGED: string
      Read FEVT_LISTBOOK_PAGE_CHANGED Write FEVT_LISTBOOK_PAGE_CHANGED;
    property EVT_LISTBOOK_PAGE_CHANGING: string
      Read FEVT_LISTBOOK_PAGE_CHANGING Write FEVT_LISTBOOK_PAGE_CHANGING;
    
    property Orientation: TWxSizerOrientation
      Read FOrientation Write FOrientation default wxHorizontal;
    property Wx_Caption: string Read FWx_Caption Write FWx_Caption;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_EventList: TStringList Read FWx_EventList Write FWx_EventList;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: integer Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
//    property Wx_ListBookStyle: TWxlbbxStyleSet Read FWx_ListBookStyle Write SetListbookStyle;
    property Wx_GeneralStyle: TWxStdStyleSet Read FWx_GeneralStyle Write FWx_GeneralStyle;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;
    
    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;
    property Wx_BookAlignment: TWxlbbxAlignStyleItem Read FWx_BookAlignment Write FWx_BookAlignment;


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
  RegisterComponents('wxWidgets', [TWxListbook]);
end;

procedure TWxListbook.AutoInitialize;
begin
  FWx_PropertyList       := TStringList.Create;
  FWx_EventList          := TStringList.Create;
  FWx_Comments           := TStringList.Create;
  FOrientation           := wxHorizontal;
  FWx_Class              := 'wxListbook';
  FWx_IDValue            := -1;
  FWx_StretchFactor      := 0;
  FWx_Border             := 5;
  FWx_Enabled            := True;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor         := self.color;
  defaultFGColor         := self.font.color;
//  FWx_ListBookStyle    := [];
  FWx_BookAlignment := wxLB_DEFAULT;

end; { of AutoInitialize }


procedure TWxListbook.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

constructor TWxListbook.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoInitialize;
  
  PopulateGenericProperties(FWx_PropertyList);
  PopulateAuiGenericProperties(FWx_PropertyList);

{
  FWx_PropertyList.add('Wx_ListBookStyle:Listbook Styles');
}
  FWx_PropertyList.Add('Wx_BookAlignment:Book Styles');


  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');
  FWx_EventList.add('EVT_LISTBOOK_PAGE_CHANGED:OnPageChanged');
  FWx_EventList.add('EVT_LISTBOOK_PAGE_CHANGING:OnPageChanging');

end;

destructor TWxListbook.Destroy;
begin
  AutoDestroy;
  inherited Destroy;
end;

procedure TWxListbook.Loaded;
begin
  inherited Loaded;
end;


function TWxListbook.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxListbook.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;



function TWxListbook.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

    if (XRCGEN) then
 begin
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_LISTBOOK_PAGE_CHANGED) <> '' then
    Result := Result + #13 + Format('EVT_LISTBOOK_PAGE_CHANGED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LISTBOOK_PAGE_CHANGED]) + '';

  if trim(EVT_LISTBOOK_PAGE_CHANGING) <> '' then
    Result := Result + #13 + Format('EVT_LISTBOOK_PAGE_CHANGING(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_LISTBOOK_PAGE_CHANGING]) + '';
 end
 else
 begin  
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_LISTBOOK_PAGE_CHANGED) <> '' then
    Result := Result + #13 + Format('EVT_LISTBOOK_PAGE_CHANGED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LISTBOOK_PAGE_CHANGED]) + '';

  if trim(EVT_LISTBOOK_PAGE_CHANGING) <> '' then
    Result := Result + #13 + Format('EVT_LISTBOOK_PAGE_CHANGING(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_LISTBOOK_PAGE_CHANGING]) + '';
end
end;

function TWxListbook.GenerateXRCControlCreation(IndentString: string): TStringList;
var
  i: integer;
  wxcompInterface: IWxComponentInterface;
  tempstring: TStringList;
  stylstr: string;
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

    stylstr := GetListbookSpecificStyle(self.Wx_GeneralStyle{, self.Wx_BookAlignment, Self.Wx_NoteBookStyle});
    if stylstr <> '' then
      Result.Add(IndentString + Format('  <style>%s | %s</style>',
        [GetBookAlignment(self.Wx_BookAlignment), stylstr]))
    else
    Result.Add(IndentString + Format('  <style>%s</style>',
        [GetBookAlignment(self.Wx_BookAlignment)]));

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

function TWxListbook.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment, strAlign: string;
begin
  Result := '';

    if FWx_PaneCaption = '' then
    FWx_PaneCaption := Self.Name;
  if FWx_PaneName = '' then
    FWx_PaneName := Self.Name + '_Pane';

  parentName := GetWxWidgetParent(self, Wx_AuiManaged);
  strAlign := ', ' + GetBookAlignment(Self.Wx_BookAlignment);

  strStyle := GetListbookSpecificStyle(self.Wx_GeneralStyle{, self.Wx_BookAlignment, self.Wx_ListBookStyle});


  if (trim(strStyle) <> '') then
    strStyle := strAlign + ' | ' + strStyle
  else
    strStyle := strAlign;

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

function TWxListbook.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxListbook.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/listbook.h>';
end;

function TWxListbook.GenerateImageInclude: string;
begin

end;

function TWxListbook.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxListbook.GetIDName: string;
begin
  Result := '';
  Result := wx_IDName;
end;

function TWxListbook.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxListbook.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
  if EventName = 'EVT_LISTBOOK_PAGE_CHANGED' then
  begin
    Result := 'wxListbookEvent& event';
    exit;
  end;

  if EventName = 'EVT_LISTBOOK_PAGE_CHANGING' then
  begin
    Result := 'wxListbookEvent& event';
    exit;
  end;

end;

function TWxListbook.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxListbook.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxListbook.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxListbook.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxListbook.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxListbook.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxListbook.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxListbook.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxListbook';
  Result := wx_Class;
end;

procedure TWxListbook.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

{
	procedure TWxListbook.SetListbookStyle(style: TWxlbbxStyleSet);
begin
  FWx_ListbookStyle := style;

  //mn we need to set the Choice position here, we go backwards from bottom, right, left to top
  //mn wxLB_DEFAULT and wxLB_LEFT are assumed to be the same
  If (wxLB_BOTTOM in FWx_ListbookStyle) then
    Self.lv1.Align :=  alBottom;

  If (wxLB_RIGHT in FWx_ListbookStyle) then
    Self.lv1.Align := alRight;

  If (wxLB_TOP in FWx_ListbookStyle) then
    Self.lv1.Align := alTop;

  If (wxLB_LEFT in FWx_ListbookStyle) or (wxLB_DEFAULT in FWx_ListbookStyle) then
    Self.lv1.Align := alLeft;
end;
}

procedure TWxListbook.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxListbook.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxListbook.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxListbook.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxListbook.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxListbook.SetGenericColor(strVariableName,strValue: string);
begin

end;


function TWxListbook.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxListbook.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxListbook.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxListbook.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxListbook.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxListbook.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxListbook.GenerateLastCreationCode: string;
begin
  Result := '';
end;

function TWxListbook.GetBookAlignment(Value: TWxlbbxAlignStyleItem): string;
begin
  if Value = wxLB_BOTTOM then
  begin
    Result := 'wxLB_BOTTOM';
    Self.lv1.Align :=  alBottom;
    exit;
  end;
  if Value = wxLB_RIGHT then
  begin
    Result := 'wxLB_RIGHT';
    Self.lv1.Align := alRight;
    Self.lv1.Width := 145;
    exit;
  end;
  if Value = wxLB_LEFT then
  begin
    Result := 'wxLB_LEFT';
    Self.lv1.Align := alLeft;
    Self.lv1.Width := 145;
    exit;
  end;
  if Value = wxLB_TOP then
  begin
    Result := 'wxLB_TOP';
    Self.lv1.Align := alTop;
    exit;
  end;
  if Value = wxLB_DEFAULT then
  begin
    Result := 'wxLB_DEFAULT';
    Self.lv1.Align := alLeft;
    Self.lv1.Width := 145;
    exit;
  end;

end;



end.
