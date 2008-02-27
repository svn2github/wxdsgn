 { ****************************************************************** }
 {                                                                    }
{ $Id: wxslider.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
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

unit WxSlider;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ComCtrls, Wxutils, ExtCtrls, WxSizerPanel, WxToolBar, UValidator;

type
  TWxSlider = class(TTrackBar, IWxComponentInterface, IWxToolBarInsertableInterface,
    IWxToolBarNonInsertableInterface,IWxVariableAssignmentInterface, IWxValidatorInterface)
  private
    { Private fields of TWxSlider }
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
    { Storage for property EVT_SLIDER }
    FEVT_SLIDER: string;
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
    FWx_Validator: string;
    FWx_ProxyValidatorString : TWxValidatorString;
    
    { Storage for property Wx_IDName }
    FWx_IDName: string;
    { Storage for property Wx_IDValue }
    FWx_IDValue: longint;
    { Storage for property Wx_ProxyBGColorString }
    FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
    FWx_ProxyFGColorString: TWxColorString;
    { Storage for property Wx_SliderStyle }
    FWx_SliderStyle: TWxsldrStyleSet;
    { Storage for property Wx_SliderOrientation }
    FWx_SliderOrientation: TWx_SliderOrientation;
    { Storage for property TWx_SliderRange }
    FWx_SliderRange: TWx_SliderRange;
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
    FWx_LHSValue : String;
    FWx_RHSValue : String;

    { Private methods of TWxSlider }
    { Method to set variable and property values and create objects }
    procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
    procedure AutoDestroy;

  protected
    { Protected fields of TWxSlider }

    { Protected methods of TWxSlider }
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;

  public
    { Public fields and properties of TWxSlider }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxSlider }
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

    function GetValidator:String;
    procedure SetValidator(value:String);
    function GetValidatorString:TWxValidatorString;
    procedure SetValidatorString(Value:TWxValidatorString);

    function GetSliderOrientation(Value: TWx_SliderOrientation): string;
    function GetSliderRange(Value: TWx_SliderRange): string;
    function GetLHSVariableAssignment:String;
    function GetRHSVariableAssignment:String;

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);
    
  published
    { Published properties of TWxSlider }
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
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
    property EVT_SLIDER: string Read FEVT_SLIDER Write FEVT_SLIDER;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_Validator: string Read FWx_Validator Write FWx_Validator;
    property Wx_ProxyValidatorString : TWxValidatorString Read GetValidatorString Write SetValidatorString;
    
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden default False;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue;
    property Wx_SliderStyle: TWxsldrStyleSet Read FWx_SliderStyle Write FWx_SliderStyle;
    property Wx_SliderOrientation: TWx_SliderOrientation
      Read FWx_SliderOrientation Write FWx_SliderOrientation;
    property Wx_SliderRange: TWx_SliderRange Read FWx_SliderRange Write FWx_SliderRange;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;

    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
    property Wx_LHSValue: string Read FWx_LHSValue Write FWx_LHSValue;
    property Wx_RHSValue: string Read FWx_RHSValue Write FWx_RHSValue;
      
  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxSlider with wxWidgets as its
       default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TWxSlider]);
end;

{ Method to set variable and property values and create objects }
procedure TWxSlider.AutoInitialize;
begin
  FWx_EventList          := TStringList.Create;
  FWx_PropertyList       := TStringList.Create;
  FWx_Comments           := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxSlider';
  FWx_Enabled            := True;
  FWx_Hidden             := False;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_StretchFactor      := 0;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor         := self.color;
  defaultFGColor         := self.font.color;
  FWx_ProxyValidatorString := TwxValidatorString.Create(self);

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxSlider.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_Comments.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_ProxyValidatorString.Destroy;
end; { of AutoDestroy }

{ Override OnKeyPress handler from TTrackBar,IWxComponentInterface }
procedure TWxSlider.KeyPress(var Key: char);
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

constructor TWxSlider.Create(AOwner: TComponent);
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

  FWx_PropertyList.Add('Wx_SliderRange:Selection Style');
  FWx_PropertyList.add('Wx_SliderStyle:Slider Style');
  FWx_PropertyList.Add('wxSL_AUTOTICKS:wxSL_AUTOTICKS');
  FWx_PropertyList.Add('wxSL_LABELS:wxSL_LABELS');
  FWx_PropertyList.Add('wxSL_LEFT:wxSL_LEFT');
  FWx_PropertyList.Add('wxSL_RIGHT:wxSL_RIGHT');
  FWx_PropertyList.Add('wxSL_TOP:wxSL_TOP');
  FWx_PropertyList.Add('wxSL_BOTTOM:wxSL_BOTTOM');

  FWx_PropertyList.add('Min:Min');
  FWx_PropertyList.add('Max:Max');
  FWx_PropertyList.add('Wx_SliderOrientation :Orientation');

  FWx_PropertyList.add('Wx_LHSValue   : LHS Variable');
  FWx_PropertyList.add('Wx_RHSValue   : RHS Variable');

  FWx_EventList.add('EVT_SLIDER : OnSlider');
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
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI ');

end;

destructor TWxSlider.Destroy;
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

function TWxSlider.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxSlider.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxSlider.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

  if trim(EVT_SLIDER) <> '' then
    Result := Format('EVT_SLIDER(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_SLIDER]) + '';

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

function TWxSlider.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));
    Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));
    Result.Add(IndentString + Format('  <value>%d</value>', [self.Position]));
    Result.Add(IndentString + Format('  <min>%d</min>', [self.Min]));
    Result.Add(IndentString + Format('  <max>%d</max>', [self.Max]));

    Result.Add(IndentString + Format('  <orient>%s</orient>',
      [GetSliderOrientation(Wx_SliderOrientation)]));
    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetSliderSpecificStyle(self.Wx_GeneralStyle, Wx_SliderStyle)]));
    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxSlider.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment: string;
begin
  Result := '';

  //    if (self.Parent is TForm) or (self.Parent is TWxSizerPanel) then
  //       parentName:=GetWxWidgetParent(self)
  //    else
  //       parentName:=self.Parent.name;
 {   if self.Orientation = trHorizontal then
        Wx_SliderStyle:=Wx_SliderStyle + [wxSL_HORIZONTAL] - [wxSL_VERTICAL]
    else
        Wx_SliderStyle:=Wx_SliderStyle + [wxSL_VERTICAL] - [wxSL_HORIZONTAL];
  }

  parentName := GetWxWidgetParent(self);

  strStyle := ', ' + GetSliderOrientation(Wx_SliderOrientation);
  if GetSliderSpecificStyle(self.Wx_GeneralStyle, Wx_SliderStyle) <> '' then
    strStyle := strStyle + ' | ' + GetSliderSpecificStyle(
      self.Wx_GeneralStyle, Wx_SliderStyle);

  strStyle := strStyle + GetSliderRange(Wx_SliderRange);

  if trim(Wx_ProxyValidatorString.strValidatorValue) <> '' then
  begin
    if trim(strStyle) <> '' then
      strStyle := strStyle + ', ' + Wx_ProxyValidatorString.strValidatorValue
    else
      strStyle := ', wxSL_HORIZONTAL, ' + Wx_ProxyValidatorString.strValidatorValue;

    strStyle := strStyle + ', ' + GetCppString(Name);

  end
  else if trim(strStyle) <> '' then
    strStyle := strStyle + ', wxDefaultValidator, ' + GetCppString(Name)
  else
    strStyle := ', 0, wxDefaultValidator, ' + GetCppString(Name);

  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, %d, %d, %d, wxPoint(%d,%d), wxSize(%d,%d)%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    self.position, self.Min, self.Max, self.Left, self.Top, self.Width,
    self.Height, strStyle]);

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

  Result := Result + #13 + Format('%s->SetRange(%d,%d);',
    [self.Name, self.Min, self.Max]);
  Result := Result + #13 + Format('%s->SetValue(%d);', [self.Name, self.Position]);

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

  if (self.Parent is TWxToolBar) then
    Result := Result + #13 + Format('%s->AddControl(%s);',
      [self.Parent.Name, self.Name]);

end;

function TWxSlider.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxSlider.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/slider.h>';
end;

function TWxSlider.GenerateImageInclude: string;
begin

end;

function TWxSlider.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxSlider.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxSlider.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxSlider.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_SLIDER' then
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

function TWxSlider.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxSlider.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxSlider.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxSlider.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxSlider.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxSlider.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxSlider.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxSlider.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxSlider';
  Result := wx_Class;
end;

procedure TWxSlider.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxSlider.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxSlider.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxSlider.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxSlider.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxSlider.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxSlider.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxSlider.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxSlider.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxSlider.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxSlider.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxSlider.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxSlider.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxSlider.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxSlider.GetSliderOrientation(Value: TWx_SliderOrientation): string;
begin
  Result := '';
  if Value = wxSL_VERTICAL then
  begin
    Result := 'wxSL_VERTICAL';
    self.Orientation := trVertical;
    exit;
  end;
  if Value = wxSL_HORIZONTAL then
  begin
    Result := 'wxSL_HORIZONTAL';
    self.Orientation := trHorizontal;
    exit;
  end;

end;

function TWxSlider.GetSliderRange(Value: TWx_SliderRange): string;
begin
  Result := '';
  if Value = wxSL_SELRANGE then
  begin
    Result := ' | wxSL_SELRANGE ';
    exit;
  end;

  if Value = wxSL_INVERSE then
  begin
    Result := ' | wxSL_INVERSE ';
    exit;
  end;
end;

function TWxSlider.GetLHSVariableAssignment:String;
begin
    Result:= '';
end;

function TWxSlider.GetRHSVariableAssignment:String;
begin
    Result:='';
end;

function TWxSlider.GetValidatorString:TWxValidatorString;
begin
  Result := FWx_ProxyValidatorString;
  Result.FstrValidatorValue := Wx_Validator;
end;

procedure TWxSlider.SetValidatorString(Value:TWxValidatorString);
begin
  FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
  Wx_Validator := Value.FstrValidatorValue;
end;

function TWxSlider.GetValidator:String;
begin
  Result := Wx_Validator;
end;

procedure TWxSlider.SetValidator(value:String);
begin
  Wx_Validator := value;
end;

end.
