 { ****************************************************************** }
 {                                                                    }
{ $Id:  $                                                               }
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

unit wxTreebook;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ComCtrls, ExtCtrls, WxUtils, WxSizerPanel, TreePageControl;

type
  TWxTreebook = class(TTreePageControl, IWxComponentInterface, IWxContainerInterface,
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
//    FWx_TreeBookStyle: TWxtrbxStyleSet;
    FWx_GeneralStyle: TWxStdStyleSet;
    FWx_Comments: TStrings;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

    FWx_ProxyBGColorString: TWxColorString;
    FWx_ProxyFGColorString: TWxColorString;

    FWx_BookAlignment: TWxtrbxAlignStyleItem;



    FEVT_UPDATE_UI: string;
    FEVT_TREEBOOK_PAGE_CHANGED: string;
    FEVT_TREEBOOK_PAGE_CHANGING: string;



    { Private methods of TWxTreebook }
    procedure AutoInitialize;
    procedure AutoDestroy;

  protected

    procedure Loaded; override;

  public
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxTreebook }
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
//    procedure SetTreebookStyle(style: TWxtrbxStyleSet);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);


    function GetBookAlignment(Value: TWxtrbxAlignStyleItem): string;


  published
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property EVT_TREEBOOK_PAGE_CHANGED: string
      Read FEVT_TREEBOOK_PAGE_CHANGED Write FEVT_TREEBOOK_PAGE_CHANGED;
    property EVT_TREEBOOK_PAGE_CHANGING: string
      Read FEVT_TREEBOOK_PAGE_CHANGING Write FEVT_TREEBOOK_PAGE_CHANGING;
    
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
//    property Wx_TreeBookStyle: TWxtrbxStyleSet Read FWx_TreeBookStyle Write SetTreebookStyle;
    property Wx_GeneralStyle: TWxStdStyleSet Read FWx_GeneralStyle Write FWx_GeneralStyle;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;
    
    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;
    property Wx_BookAlignment: TWxtrbxAlignStyleItem Read FWx_BookAlignment Write FWx_BookAlignment;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxTreebook]);
end;

procedure TWxTreebook.AutoInitialize;
begin
  FWx_PropertyList       := TStringList.Create;
  FWx_EventList          := TStringList.Create;
  FWx_Comments           := TStringList.Create;
  FOrientation           := wxHorizontal;
  FWx_Class              := 'wxTreebook';
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
//  FWx_TreeBookStyle    := [];
  FWx_BookAlignment := wxBK_DEFAULT;

end; { of AutoInitialize }


procedure TWxTreebook.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

constructor TWxTreebook.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoInitialize;
  

  PopulateGenericProperties(FWx_PropertyList);

{
	  FWx_PropertyList.add('Wx_TreeBookStyle:Treebook Styles');
}
  FWx_PropertyList.Add('Wx_BookAlignment:Book Styles');

  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');
  FWx_EventList.add('EVT_TREEBOOK_PAGE_CHANGED:OnPageChanged');
  FWx_EventList.add('EVT_TREEBOOK_PAGE_CHANGING:OnPageChanging');

end;

destructor TWxTreebook.Destroy;
begin
  AutoDestroy;
  inherited Destroy;
end;

procedure TWxTreebook.Loaded;
begin
  inherited Loaded;
end;


function TWxTreebook.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxTreebook.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;



function TWxTreebook.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';

    if (XRCGEN) then
 begin
    if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_TREEBOOK_PAGE_CHANGED) <> '' then
    Result := Result + #13 + Format('EVT_TREEBOOK_PAGE_CHANGED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREEBOOK_PAGE_CHANGED]) + '';

  if trim(EVT_TREEBOOK_PAGE_CHANGING) <> '' then
    Result := Result + #13 + Format('EVT_TREEBOOK_PAGE_CHANGING(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TREEBOOK_PAGE_CHANGING]) + '';
   end
 else
 begin
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_TREEBOOK_PAGE_CHANGED) <> '' then
    Result := Result + #13 + Format('EVT_TREEBOOK_PAGE_CHANGED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREEBOOK_PAGE_CHANGED]) + '';

  if trim(EVT_TREEBOOK_PAGE_CHANGING) <> '' then
    Result := Result + #13 + Format('EVT_TREEBOOK_PAGE_CHANGING(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TREEBOOK_PAGE_CHANGING]) + '';
end
end;

function TWxTreebook.GenerateXRCControlCreation(IndentString: string): TStringList;
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

    stylstr := GetTreebookSpecificStyle(self.Wx_GeneralStyle{, self.Wx_TabAlignment, Self.Wx_NoteBookStyle});
    if stylstr <> '' then
      Result.Add(IndentString + Format('  <style>%s | %s</style>',
        [GetBookAlignment(self.Wx_BookAlignment), stylstr]))
    else
    Result.Add(IndentString + Format('  <style>%s</style>',
//      [GetTreebookSpecificStyle(self.Wx_GeneralStyle, self.Wx_TreeBookStyle)]));
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

function TWxTreebook.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle, parentName, strAlignment, strAlign: string;
begin
  Result := '';

  //    if (self.Parent is TForm) or (self.Parent is TWxSizerPanel) then
  //       parentName:=GetWxWidgetParent(self)
  //    else
  //       parentName:=self.Parent.name;

  parentName := GetWxWidgetParent(self);
  strAlign := ', ' + GetBookAlignment(Self.Wx_BookAlignment);

//  strStyle := GetTreebookSpecificStyle(self.Wx_GeneralStyle, self.Wx_TreeBookStyle);
  strStyle := GetTreebookSpecificStyle(self.Wx_GeneralStyle{, self.Wx_BookAlignment, self.Wx_TreeBookStyle});


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
  if (self.Parent is TWxSizerPanel) then
  begin
    strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
    Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);
  end;

end;

function TWxTreebook.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxTreebook.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/treebook.h>';
end;

function TWxTreebook.GenerateImageInclude: string;
begin

end;

function TWxTreebook.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxTreebook.GetIDName: string;
begin
  Result := '';
  Result := wx_IDName;
end;

function TWxTreebook.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxTreebook.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
  if EventName = 'EVT_TREEBOOK_PAGE_CHANGED' then
  begin
    Result := 'wxTreebookEvent& event';
    exit;
  end;

  if EventName = 'EVT_TREEBOOK_PAGE_CHANGING' then
  begin
    Result := 'wxTreebookEvent& event';
    exit;
  end;

end;

function TWxTreebook.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxTreebook.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxTreebook.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxTreebook.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxTreebook.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxTreebook.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxTreebook.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxTreebook.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxTreebook';
  Result := wx_Class;
end;

procedure TWxTreebook.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

{
	procedure TWxTreebook.SetTreebookStyle(style: TWxtrbxStyleSet);
begin
  FWx_TreebookStyle := style;

  //mn we need to set the Choice position here, we go backwards from bottom, right, left to top
  //mn wxBK_DEFAULT and wxBK_LEFT are assumed to be the same
  If (wxBK_BOTTOM in FWx_TreebookStyle) then
    Self.tv1.Align :=  alBottom;

  If (wxBK_RIGHT in FWx_TreebookStyle) then
    Self.tv1.Align := alRight;

  If (wxBK_TOP in FWx_TreebookStyle) then
    Self.tv1.Align := alTop;

  If (wxBK_LEFT in FWx_TreebookStyle) or (wxBK_DEFAULT in FWx_TreebookStyle) then
    Self.tv1.Align := alLeft;
end;
}

procedure TWxTreebook.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxTreebook.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxTreebook.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxTreebook.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxTreebook.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxTreebook.SetGenericColor(strVariableName,strValue: string);
begin

end;


function TWxTreebook.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxTreebook.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxTreebook.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxTreebook.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxTreebook.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxTreebook.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxTreebook.GenerateLastCreationCode: string;
begin
  Result := '';
end;

function TWxTreebook.GetBookAlignment(Value: TWxtrbxAlignStyleItem): string;
begin
  if Value = wxBK_BOTTOM then
  begin
    Result := 'wxBK_BOTTOM';
    Self.tv1.Align :=  alBottom;
    exit;
  end;
  if Value = wxBK_RIGHT then
  begin
    Result := 'wxBK_RIGHT';
    Self.tv1.Align := alRight;
    Self.tv1.Width := 105;
    exit;
  end;
  if Value = wxBK_LEFT then
  begin
    Result := 'wxBK_LEFT';
    Self.tv1.Align := alLeft;
    Self.tv1.Width := 105;
    exit;
  end;
  if Value = wxBK_TOP then
  begin
    Result := 'wxBK_TOP';
    Self.tv1.Align := alTop;
    exit;
  end;
  if Value = wxBK_DEFAULT then
begin
    Result := 'wxBK_DEFAULT';
    Self.tv1.Align := alLeft;
    Self.tv1.Width := 105;
    exit;
  end;

end;

end.
