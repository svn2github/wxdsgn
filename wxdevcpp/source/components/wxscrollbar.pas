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

unit WxScrollBar;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, StdCtrls, WxUtils, ExtCtrls, WxSizerPanel;

type
//  TWxScrollBar = class(TScrollBar, IWxComponentInterface, IWxStatusBarInterface)
  TWxScrollBar = class(TScrollBar, IWxComponentInterface)
  private
    { Private fields of TWxScrollBar }

    { Storage for property EVT_COMMAND_SCROLL }
    FEVT_COMMAND_SCROLL: string;
    { Storage for property EVT_COMMAND_SCROLL_TOP }
    FEVT_COMMAND_SCROLL_TOP: string;
    { Storage for property EVT_COMMAND_SCROLL_BOTTOM }
    FEVT_COMMAND_SCROLL_BOTTOM: string;
    { Storage for property EVT_COMMAND_SCROLL_LINEUP }
    FEVT_COMMAND_SCROLL_LINEUP: string;
    { Storage for property EVT_COMMAND_SCROLL_LINEDOWN }
    FEVT_COMMAND_SCROLL_LINEDOWN: string;
    { Storage for property EVT_COMMAND_SCROLL_PAGEUP }
    FEVT_COMMAND_SCROLL_PAGEUP: string;
    { Storage for property EVT_COMMAND_SCROLL_PAGEDOWN }
    FEVT_COMMAND_SCROLL_PAGEDOWN: string;
    { Storage for property EVT_COMMAND_SCROLL_THUMBTRACK }
    FEVT_COMMAND_SCROLL_THUMBTRACK: string;
    { Storage for property EVT_COMMAND_SCROLL_THUMBRELEASE }
    FEVT_COMMAND_SCROLL_THUMBRELEASE: string;
    { Storage for property EVT_COMMAND_SCROLL_ENDSCROLL }
    FEVT_COMMAND_SCROLL_ENDSCROLL: string;
    { Storage for property EVT_SCROLLBAR }
    FEVT_SCROLLBAR: string;
    { Storage for property EVT_UPDATE_UI }
    FEVT_UPDATE_UI: string;
    { Storage for property Wx_Border }
    FWx_Border: integer;
    { Storage for property Wx_Class }
    FWx_Class: string;
    { Storage for property Wx_ControlOrientation }
    FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_Enabled }
    FWx_Enabled: boolean;
    { Storage for property Wx_GeneralStyle }
    FWx_GeneralStyle: TWxStdStyleSet;
    { Storage for property Wx_HelpText }
    FWx_HelpText: string;
    { Storage for property Wx_Hidden }
    FWx_Hidden: boolean;
    FWx_Validator: string;
    FWx_Comments: TStrings;
    { Storage for property Wx_IDName }
    FWx_IDName: string;
    { Storage for property Wx_IDValue }
    FWx_IDValue: longint;
    { Storage for property Wx_ProxyBGColorString }
    FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
    FWx_ProxyFGColorString: TWxColorString;
    { Storage for property Wx_StretchFactor }
    FWx_StretchFactor: integer;
    { Storage for property Wx_ToolTip }
    FWx_ToolTip: string;
    FWx_EventList: TStringList;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_SBOrientation: TWx_SBOrientation;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

    { Private methods of TWxScrollBar }
    { Method to set variable and property values and create objects }
    procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
    procedure AutoDestroy;

  protected
    { Protected fields of TWxScrollBar }

    { Protected methods of TWxScrollBar }
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;

  public
    { Public fields and properties of TWxScrollBar }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxScrollBar }
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
    function GetSBOrientation(Wx_SBOrientation: TWx_SBOrientation): string;

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

  published
    { Published properties of TWxScrollBar }
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
    property EVT_COMMAND_SCROLL: string Read FEVT_COMMAND_SCROLL Write FEVT_COMMAND_SCROLL;
    property EVT_COMMAND_SCROLL_TOP: string Read FEVT_COMMAND_SCROLL_TOP Write FEVT_COMMAND_SCROLL_TOP;
    property EVT_COMMAND_SCROLL_BOTTOM: string Read FEVT_COMMAND_SCROLL_BOTTOM Write FEVT_COMMAND_SCROLL_BOTTOM;
    property EVT_COMMAND_SCROLL_LINEUP: string Read FEVT_COMMAND_SCROLL_LINEUP Write FEVT_COMMAND_SCROLL_LINEUP;
    property EVT_COMMAND_SCROLL_LINEDOWN: string Read FEVT_COMMAND_SCROLL_LINEDOWN Write FEVT_COMMAND_SCROLL_LINEDOWN;
    property EVT_COMMAND_SCROLL_PAGEUP: string Read FEVT_COMMAND_SCROLL_PAGEUP Write FEVT_COMMAND_SCROLL_PAGEUP;
    property EVT_COMMAND_SCROLL_PAGEDOWN: string Read FEVT_COMMAND_SCROLL_PAGEDOWN Write FEVT_COMMAND_SCROLL_PAGEDOWN;
    property EVT_COMMAND_SCROLL_THUMBTRACK: string Read FEVT_COMMAND_SCROLL_THUMBTRACK Write FEVT_COMMAND_SCROLL_THUMBTRACK;
    property EVT_COMMAND_SCROLL_THUMBRELEASE: string Read FEVT_COMMAND_SCROLL_THUMBRELEASE Write FEVT_COMMAND_SCROLL_THUMBRELEASE;
    property EVT_COMMAND_SCROLL_ENDSCROLL: string Read FEVT_COMMAND_SCROLL_ENDSCROLL Write FEVT_COMMAND_SCROLL_ENDSCROLL;
    property EVT_SCROLLBAR: string Read FEVT_SCROLLBAR Write FEVT_SCROLLBAR;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_Validator: string Read FWx_Validator Write FWx_Validator;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;
    property Wx_SBOrientation: TWx_SBOrientation
      Read FWx_SBOrientation Write FWx_SBOrientation;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;

    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxScrollBar with wxWidgets as its
       default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TWxScrollBar]);
end;

{ Method to set variable and property values and create objects }
procedure TWxScrollBar.AutoInitialize;
begin
  FWx_Comments           := TStringList.Create;
  FWx_EventList          := TStringList.Create;
  FWx_PropertyList       := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxScrollBar';
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
procedure TWxScrollBar.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

{ Override OnClick handler from TScrollBar,IWxComponentInterface }
procedure TWxScrollBar.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
  inherited Click;

     { Code to execute after click behavior
       of parent }

end;

{ Override OnKeyPress handler from TScrollBar,IWxComponentInterface }
procedure TWxScrollBar.KeyPress(var Key: char);
const
  TabKey   = char(VK_TAB);
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

constructor TWxScrollBar.Create(AOwner: TComponent);
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
  FWx_PropertyList.add('Wx_SBOrientation:Orientation');

  FWx_EventList.add('EVT_SCROLLBAR : OnScrollbar');
  FWx_EventList.add('EVT_COMMAND_SCROLL   :  OnScroll');
  FWx_EventList.add('EVT_COMMAND_SCROLL_TOP   :  OnScrollTop');
  FWx_EventList.add('EVT_COMMAND_SCROLL_BOTTOM   :  OnScrollBottom');
  FWx_EventList.add('EVT_COMMAND_SCROLL_LINEUP   :  OnScrollLineUp');
  FWx_EventList.add('EVT_COMMAND_SCROLL_LINEDOWN   :  OnScrollLineDown');
  FWx_EventList.add('EVT_COMMAND_SCROLL_PAGEUP   :  OnScrollPageUp');
  FWx_EventList.add('EVT_COMMAND_SCROLL_PAGEDOWN   :  OnScrollPageDown');
  FWx_EventList.add('EVT_COMMAND_SCROLL_THUMBTRACK   :  OnScrollThumbtrack');
  FWx_EventList.add('EVT_COMMAND_SCROLL_THUMBRELEASE   :  OnScrollThumbRelease');
  FWx_EventList.add('EVT_COMMAND_SCROLL_ENDSCROLL   :  OnScrollEnd');
  FWx_EventList.add('EVT_UPDATE_UI   :  OnUpdateUI');

end;

destructor TWxScrollBar.Destroy;
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


function TWxScrollBar.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxScrollBar.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxScrollBar.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
  if trim(EVT_SCROLLBAR) <> '' then
    Result := Format('EVT_SCROLLBAR(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_SCROLLBAR]) + '';

  if trim(EVT_COMMAND_SCROLL) <> '' then
    Result := Result + #13 + Format('EVT_COMMAND_SCROLL(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL]) + '';

  if trim(EVT_COMMAND_SCROLL_TOP) <> '' then
    Result := Result + #13 + Format('EVT_COMMAND_SCROLL_TOP(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_TOP]) + '';

  if trim(EVT_COMMAND_SCROLL_BOTTOM) <> '' then
    Result := Result + #13 + Format('EVT_COMMAND_SCROLL_BOTTOM(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_BOTTOM]) + '';

  if trim(EVT_COMMAND_SCROLL_LINEUP) <> '' then
    Result := Result + #13 + Format('EVT_COMMAND_SCROLL_LINEUP(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_LINEUP]) + '';

  if trim(EVT_COMMAND_SCROLL_LINEDOWN) <> '' then
    Result := Result + #13 + Format('EVT_COMMAND_SCROLL_LINEDOWN(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_LINEDOWN]) + '';

  if trim(EVT_COMMAND_SCROLL_PAGEUP) <> '' then
    Result := Result + #13 + Format('EVT_COMMAND_SCROLL_PAGEUP(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_PAGEUP]) + '';

  if trim(EVT_COMMAND_SCROLL_PAGEDOWN) <> '' then
    Result := Result + #13 + Format('EVT_COMMAND_SCROLL_PAGEDOWN(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_PAGEDOWN]) + '';

  if trim(EVT_COMMAND_SCROLL_THUMBTRACK) <> '' then
    Result := Result + #13 + Format('EVT_COMMAND_SCROLL_THUMBTRACK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_THUMBTRACK]) + '';

  if trim(EVT_COMMAND_SCROLL_THUMBRELEASE) <> '' then
    Result := Result + #13 + Format('EVT_COMMAND_SCROLL_THUMBRELEASE(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_THUMBRELEASE]) + '';

  if trim(EVT_COMMAND_SCROLL_ENDSCROLL) <> '' then
    Result := Result + #13 + Format('EVT_COMMAND_SCROLL_ENDSCROLL(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_COMMAND_SCROLL_ENDSCROLL]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

end;

function TWxScrollBar.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));
    Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

    //Result.Add(IndentString + Format('  <value>%d</value>', [self.Position]));
    //Result.Add(IndentString + Format('  <range>%d</range>', [self.Max]));

    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetStdStyleString(self.Wx_GeneralStyle)]));
    Result.Add(IndentString + Format('  <orient>%s</orient>',
      [GetSBOrientation(self.Wx_SBOrientation)]));

    // Result.Add(IndentString + Format('  <value>%d</value>', [);

    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxScrollBar.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment: string;
begin
  Result := '';

  //    if (self.Parent is TForm) or (self.Parent is TWxSizerPanel) then
  //       parentName:=GetWxWidgetParent(self)
  //    else
  //       parentName:=self.Parent.name;

  parentName := GetWxWidgetParent(self);

  strStyle := GetStdStyleString(self.Wx_GeneralStyle);
  if (trim(strStyle) <> '') then
    strStyle := ' | ' + strStyle;

  strStyle := ', ' + GetSBOrientation(self.Wx_SBOrientation) + strStyle;

  if trim(self.FWx_Validator) <> '' then
  begin
    if trim(strStyle) <> '' then
      strStyle := strStyle + ', ' + self.Wx_Validator
    else
      strStyle := ', wxSB_HORIZONTAL, ' + self.Wx_Validator;

    strStyle := strStyle + ', ' + GetCppString(Name);

  end
  else if trim(strStyle) <> '' then
    strStyle := strStyle + ', wxDefaultValidator, ' + GetCppString(Name)
  else
    strStyle := ', 0, wxDefaultValidator, ' + GetCppString(Name);

  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, wxPoint(%d,%d), wxSize(%d,%d)%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    self.Left, self.Top, self.Width, self.Height, strStyle]);

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

  if (self.Parent is TWxSizerPanel) then
  begin
    strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
    Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);
  end;

end;

function TWxScrollBar.GenerateGUIControlDeclaration: string;
begin
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxScrollBar.GenerateHeaderInclude: string;
begin
  Result := '#include <wx/scrolbar.h>';
end;

function TWxScrollBar.GenerateImageInclude: string;
begin

end;

function TWxScrollBar.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxScrollBar.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxScrollBar.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxScrollBar.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_SCROLLBAR' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;
  if EventName = 'EVT_COMMAND_SCROLL' then
  begin
    Result := 'wxScrollEvent& event';
    exit;
  end;
  if EventName = 'EVT_COMMAND_SCROLL_TOP' then
  begin
    Result := 'wxScrollEvent& event';
    exit;
  end;
  if EventName = 'EVT_COMMAND_SCROLL_BOTTOM' then
  begin
    Result := 'wxScrollEvent& event';
    exit;
  end;
  if EventName = 'EVT_COMMAND_SCROLL_LINEUP' then
  begin
    Result := 'wxScrollEvent& event';
    exit;
  end;
  if EventName = 'EVT_COMMAND_SCROLL_LINEDOWN' then
  begin
    Result := 'wxScrollEvent& event';
    exit;
  end;
  if EventName = 'EVT_COMMAND_SCROLL_PAGEUP' then
  begin
    Result := 'wxScrollEvent& event';
    exit;
  end;
  if EventName = 'EVT_COMMAND_SCROLL_PAGEDOWN' then
  begin
    Result := 'wxScrollEvent& event';
    exit;
  end;
  if EventName = 'EVT_COMMAND_SCROLL_THUMBTRACK' then
  begin
    Result := 'wxScrollEvent& event';
    exit;
  end;
  if EventName = 'EVT_COMMAND_SCROLL_THUMBRELEASE' then
  begin
    Result := 'wxScrollEvent& event';
    exit;
  end;
  if EventName = 'EVT_COMMAND_SCROLL_ENDSCROLL' then
  begin
    Result := 'wxScrollEvent& event';
    exit;
  end;
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxScrollBar.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxScrollBar.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxScrollBar.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxScrollBar.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxScrollBar.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxScrollBar.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxScrollBar.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxScrollBar.GetWxClassName: string;
begin
  if wx_Class = '' then
    wx_Class := 'wxScrollBar';
  Result := wx_Class;
end;

procedure TWxScrollBar.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxScrollBar.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxScrollBar.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxScrollBar.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxScrollBar.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxScrollBar.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxScrollBar.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxScrollBar.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxScrollBar.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxScrollBar.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxScrollBar.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxScrollBar.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxScrollBar.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxScrollBar.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxScrollBar.GetSBOrientation(Wx_SBOrientation: TWx_SBOrientation): string;
begin
  Result := '';
  if Wx_SBOrientation = wxSB_VERTICAL then
  begin
    Result    := 'wxSB_VERTICAL';
    self.Kind := sbVertical;
  end;
  if Wx_SBOrientation = wxSB_HORIZONTAL then
  begin
    Result    := 'wxSB_HORIZONTAL';
    self.Kind := sbHorizontal;
  end;

end;

end.
