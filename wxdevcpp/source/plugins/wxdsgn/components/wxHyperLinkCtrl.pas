 { ****************************************************************** }
 {                                                                    }
{ $Id: wxHyperLinkCtrl.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
 {                                                                    }
{                                                                    }
{   Copyright � 2003-2007 by Guru Kathiresan                         }
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

unit wxHyperLinkCtrl;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, StdCtrls, WxUtils, ExtCtrls, WxSizerPanel, WxToolBar, dbugintf;

{
*************IMPORTANT*************
If you want to change any of the wxwidgets components,  you have to use comp screate by David Price.
You can download a copy from

http://torry.net/tools/components/compcreation/cc.zip

***IF YOU FOLLOW THIS YOUR UPDATES WONT BE INCLUDED IN THE DISTRIBUTION****
}

type
  TWxHyperLinkCtrl = class(TStaticText, IWxComponentInterface, IWxVariableAssignmentInterface)
  private
    { Private fields of TWxHyperLinkCtrl }
    { Storage for property Wx_BGColor }
    FEVT_HYPERLINK:String;
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

    FWx_URL:String;

    { Storage for property Wx_IDName }
    FWx_IDName: string;
    { Storage for property Wx_IDValue }
    FWx_IDValue: longint;
    FWx_HyperLinkStyle: TWxHyperLnkStyleSet;
    { Storage for property Wx_ProxyBGColorString }
    FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
    FWx_ProxyFGColorString: TWxColorString;

    FWx_ProxyHoverColorString: TWxColorString;
    FWx_ProxyNormalColorString: TWxColorString;
    FWx_ProxyVisitedColorString: TWxColorString;

    { Storage for property Wx_StretchFactor }
    FWx_StretchFactor: integer;
    { Storage for property Wx_ToolTip }
    FWx_ToolTip: string;
    FWx_EventList: TStringList;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    
    FInvisibleHoverColorString: string;
    FInvisibleNormalColorString: string;
    FInvisibleVisitedColorString: string;

    FWx_Comments: TStrings;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;
    FWx_LHSValue : String;
    FWx_RHSValue : String;
    defaultBGColor: TColor;
    defaultFGColor: TColor;

    { Private methods of TWxHyperLinkCtrl }
    { Method to set variable and property values and create objects }
    procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
    procedure AutoDestroy;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;

  protected
    { Protected fields of TWxHyperLinkCtrl }

    { Protected methods of TWxHyperLinkCtrl }
    procedure Click; override;
    procedure Loaded; override;

  published
    { Public fields and properties of TWxHyperLinkCtrl }

    { Public methods of TWxHyperLinkCtrl }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GenerateControlIDs: string;
    function GenerateEnumControlIDs: string; virtual;
    function GenerateEventTableEntries(CurrClassName: string): string; virtual;
    function GenerateGUIControlCreation: string; virtual;
    function GenerateXRCControlCreation(IndentString: string): TStringList;
    function GenerateGUIControlDeclaration: string; virtual;
    function GenerateHeaderInclude: string; virtual;
    function GenerateImageInclude: string;
    function GetEventList: TStringList;
    function GetIDName: string;
    function GetIDValue: longint;
    function GetParameterFromEventName(EventName: string): string;
    function GetPropertyList: TStringList; virtual;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string; virtual;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: longint);
    procedure SetWxClassName(wxClassName: string);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);
    
    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);
    
    function GetLHSVariableAssignment:String;
    function GetRHSVariableAssignment:String;

  published
    { Published properties of TWxHyperLinkCtrl }
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property EVT_HYPERLINK:String Read FEVT_HYPERLINK Write FEVT_HYPERLINK;
    property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
    property Wx_URL: String Read FWx_URL Write FWx_URL;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_HyperLinkStyle: TWxHyperLnkStyleSet Read FWx_HyperLinkStyle Write FWx_HyperLinkStyle;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;

    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

    property InvisibleHoverColorString: string Read FInvisibleHoverColorString Write FInvisibleHoverColorString;
    property InvisibleNormalColorString: string Read FInvisibleNormalColorString Write FInvisibleNormalColorString;
    property InvisibleVisitedColorString: string Read FInvisibleVisitedColorString Write FInvisibleVisitedColorString;
    property Wx_ProxyHoverColorString: TWxColorString Read FWx_ProxyHoverColorString Write FWx_ProxyHoverColorString;
    property Wx_ProxyNormalColorString: TWxColorString Read FWx_ProxyNormalColorString Write FWx_ProxyNormalColorString;
    property Wx_ProxyVisitedColorString: TWxColorString Read FWx_ProxyVisitedColorString Write FWx_ProxyVisitedColorString;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
    property Wx_LHSValue: string Read FWx_LHSValue Write FWx_LHSValue;
    property Wx_RHSValue: string Read FWx_RHSValue Write FWx_RHSValue;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxHyperLinkCtrl]);
end;

{ Method to set variable and property values and create objects }
procedure TWxHyperLinkCtrl.AutoInitialize;
begin
  FWx_EventList          := TStringList.Create;
  FWx_PropertyList       := TStringList.Create;
  FWx_Comments           := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxHyperlinkCtrl';
  FWx_URL                := 'http://wxdsgn.sf.net';
  FWx_Enabled            := True;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_IDValue            := -1;
  FWx_StretchFactor      := 0;
  FWx_HyperLinkStyle     := [wxHL_CONTEXTMENU, wxHL_ALIGN_CENTRE];
  FWx_GeneralStyle       := [wxNO_BORDER];
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  FWx_ProxyHoverColorString:= TWxColorString.Create;
  FWx_ProxyNormalColorString:= TWxColorString.Create;
  FWx_ProxyVisitedColorString:= TWxColorString.Create;

  InvisibleFGColorString:='STD:wxBLUE';
  defaultBGColor         := clBtnFace;;
  self.Font.Color        :=clBlue;
  defaultFGColor         := self.font.color;

  AutoSize               := True;
  Font.Style := Font.Style + [fsUnderline]; 
  Fwx_HyperLinkStyle := [wxHL_CONTEXTMENU];
  FWx_GeneralStyle := [wxNO_BORDER];
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxHyperLinkCtrl.AutoDestroy;
begin
  FWx_EventList.Destroy;
  FWx_PropertyList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_ProxyHoverColorString.Destroy;
  FWx_ProxyNormalColorString.Destroy;
  FWx_ProxyVisitedColorString.Destroy;

  FWx_Comments.Destroy;
end; { of AutoDestroy }

{ Override OnClick handler from TStaticText,IWxComponentInterface }
procedure TWxHyperLinkCtrl.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
  inherited Click;

     { Code to execute after click behavior
       of parent }

end;

constructor TWxHyperLinkCtrl.Create(AOwner: TComponent);
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

  FWx_PropertyList.add('Wx_ProxyFGColorString:Normal Color');
  FWx_PropertyList.add('Wx_ProxyHoverColorString:Hover Color');
  FWx_PropertyList.add('Wx_ProxyVisitedColorString:Visited Color');
  
  FWx_PropertyList.add('wx_HyperLinkStyle:HyperLink Style');
  FWx_PropertyList.add('wxHL_ALIGN_LEFT:wxHL_ALIGN_LEFT');
  FWx_PropertyList.add('wxHL_ALIGN_RIGHT:wxHL_ALIGN_RIGHT');
  FWx_PropertyList.add('wxHL_ALIGN_CENTRE:wxHL_ALIGN_CENTRE');
  FWx_PropertyList.Add('wxHL_CONTEXTMENU:wxHL_CONTEXTMENU');
  FWx_PropertyList.add('Caption:Label');
  FWx_PropertyList.add('Wx_LHSValue   : LHS Variable');
  FWx_PropertyList.add('Wx_RHSValue   : RHS Variable');

  FWx_EventList.add('EVT_HYPERLINK:OnHyperLink');

end;

destructor TWxHyperLinkCtrl.Destroy;
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

function TWxHyperLinkCtrl.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxHyperLinkCtrl.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxHyperLinkCtrl.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

   if (XRCGEN) then
 begin//generate xrc loading code  needs to be edited
  if trim(EVT_HYPERLINK) <> '' then
    Result := Format('EVT_HYPERLINK(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_HYPERLINK]) + '';
 end
 else
 begin//generate the cpp code
  if trim(EVT_HYPERLINK) <> '' then
    Result := Format('EVT_HYPERLINK(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_HYPERLINK]) + '';
 end;
end;

function TWxHyperLinkCtrl.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <label>%s</label>', [XML_Label(self.Caption)]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));
    Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));
    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetHyperLnkSpecificStyle(Wx_GeneralStyle, Wx_HyperLinkStyle)]));
    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxHyperLinkCtrl.GenerateGUIControlCreation: string;
var
  strSize: string;
  strColorStr: string;
  strStyle, parentName, strAlignment: string;
begin
  Result := '';
  parentName := GetWxWidgetParent(self);


  //Determine whether we should just use wxDefaultSize
  strSize := Format('wxSize(%d, %d)', [self.width, self.height]);
  
  //Set the static text style
  strStyle := GetHyperLnkSpecificStyle(Wx_GeneralStyle, Wx_HyperLinkStyle);
  if trim(strStyle) = '' then
    strStyle := '0';
  strStyle := ', ' + strStyle + ', ' + GetCppString(Name);

   if (XRCGEN) then
 begin//generate xrc loading code
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
    [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);   
 end
 else
 begin//generate the cpp code
  //Last comma is removed because it depends on the user selection of the properties.
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, %s, %s, wxPoint(%d,%d), %s%s);',
    [self.Name, self.Wx_Class, ParentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    GetCppString(self.Caption), GetCppString(wx_URL),self.Left, self.Top, strSize, strStyle]);
 end;//end of if xrc
 
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

  //strColorStr := trim(GetwxColorFromString(InvisibleFGColorString));
  //if strColorStr <> '' then
  //  Result := Result + #13 + Format('%s->SetForegroundColour(%s);',
  //      [self.Name, strColorStr]);

  //strColorStr := trim(GetwxColorFromString(InvisibleBGColorString));
  //if strColorStr <> '' then
  //  Result := Result + #13 + Format('%s->SetBackgroundColour(%s);',[self.Name, strColorStr]);

  strColorStr := trim(GetwxColorFromString(InvisibleHoverColorString));
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetHoverColour(%s);',[self.Name, strColorStr]);

  strColorStr := trim(GetwxColorFromString(InvisibleFGColorString));
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetNormalColour(%s);',[self.Name, strColorStr]);

  strColorStr := trim(GetwxColorFromString(InvisibleVisitedColorString));
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetVisitedColour(%s);',[self.Name, strColorStr]);


  strColorStr := GetWxFontDeclaration(self.Font);
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetFont(%s);', [self.Name, strColorStr]);
if not (XRCGEN) then //NUKLEAR ZELPH
  if (self.Parent is TWxSizerPanel) then
  begin
    strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
    Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);
  end;

  // Change the text justification in the form designer
  if wxHL_ALIGN_LEFT in Wx_HyperLinkStyle then
    self.Alignment := taLeftJustify;

  if wxHL_ALIGN_CENTRE in Wx_HyperLinkStyle then
    self.Alignment := taCenter;

  if wxHL_ALIGN_RIGHT in Wx_HyperLinkStyle then
    self.Alignment := taRightJustify;

  self.AutoSize := false;
  self.Repaint;

end;

function TWxHyperLinkCtrl.GenerateGUIControlDeclaration: string;
begin
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxHyperLinkCtrl.GenerateHeaderInclude: string;
begin
  Result := '#include <wx/hyperlink.h>';
end;

function TWxHyperLinkCtrl.GenerateImageInclude: string;
begin

end;

function TWxHyperLinkCtrl.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxHyperLinkCtrl.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxHyperLinkCtrl.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxHyperLinkCtrl.GetParameterFromEventName(EventName: string): string;
begin
  Result := '';
  if EventName = 'EVT_HYPERLINK' then
  begin
    Result := 'wxHyperlinkEvent& event' + '';
    exit;
  end;

end;

function TWxHyperLinkCtrl.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxHyperLinkCtrl.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxHyperLinkCtrl.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxHyperLinkCtrl.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxHyperlinkCtrl';
  Result := wx_Class;
end;

function TWxHyperLinkCtrl.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxHyperLinkCtrl.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxHyperLinkCtrl.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxHyperLinkCtrl.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

procedure TWxHyperLinkCtrl.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxHyperLinkCtrl.SaveControlOrientation(ControlOrientation:
  TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxHyperLinkCtrl.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxHyperLinkCtrl.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxHyperLinkCtrl.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxHyperLinkCtrl.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

procedure TWxHyperLinkCtrl.WMSize(var Message: TWMSize);
var
  W, H: integer;
begin
  inherited;

  //Copy the new width and height of the component so we can use SetBounds to
  //change both at once
  W := Width;
  H := Height;

  //Update the component size if we adjusted W or H
  if (W <> Width) or (H <> Height) then
    inherited SetBounds(Left, Top, W, H);

  Message.Result := 0;
end;

function TWxHyperLinkCtrl.GetGenericColor(strVariableName:String): string;
begin
  Result:='';
  if UpperCase(strVariableName) = UpperCase('Wx_ProxyHoverColorString') then
    Result:= FInvisibleHoverColorString
  else
    if UpperCase(strVariableName) = UpperCase('Wx_ProxyNormalColorString') then
      Result:=FInvisibleNormalColorString
    else
    if UpperCase(strVariableName) = UpperCase('Wx_ProxyVisitedColorString') then
      Result:=FInvisibleVisitedColorString;
end;

procedure TWxHyperLinkCtrl.SetGenericColor(strVariableName,strValue: string);
begin
  if UpperCase(strVariableName) = UpperCase('Wx_ProxyHoverColorString') then
    FInvisibleHoverColorString:=strValue
  else
    if UpperCase(strVariableName) = UpperCase('Wx_ProxyNormalColorString') then
      FInvisibleNormalColorString:=strValue
    else
    if UpperCase(strVariableName) = UpperCase('Wx_ProxyVisitedColorString') then
      FInvisibleVisitedColorString:=strValue;
end;

function TWxHyperLinkCtrl.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxHyperLinkCtrl.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;

  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxHyperLinkCtrl.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxHyperLinkCtrl.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxHyperLinkCtrl.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxHyperLinkCtrl.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxHyperLinkCtrl.GetLHSVariableAssignment:String;
begin
    Result:='';
    if trim(Wx_LHSValue) = '' then
        exit;
    Result:= Format('%s = %s->GetValue();',[Wx_LHSValue,self.Name]);
end;

function TWxHyperLinkCtrl.GetRHSVariableAssignment:String;
begin
    Result:='';
    if trim(Wx_RHSValue) = '' then
        exit;
    Result:= Format('%s->SetValue(%s);',[self.Name,Wx_RHSValue]);
end;


end.
