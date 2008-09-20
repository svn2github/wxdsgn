{ ****************************************************************** }
{                                                                    }
{ $Id:  $                                                            }
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

unit wxChoicebook;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, Dialogs,
  Forms, Graphics, ComCtrls, ExtCtrls, StdCtrls, WxUtils, WxSizerPanel, ComboPageControl;

type
  TWxChoicebook = class(TComboPageControl, IWxComponentInterface, IWxContainerInterface,
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
    //    FWx_ChoiceBookStyle: TWxchbxStyleSet;
    FWx_GeneralStyle: TWxStdStyleSet;
    FWx_Comments: TStrings;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

    FWx_ProxyBGColorString: TWxColorString;
    FWx_ProxyFGColorString: TWxColorString;

    FWx_BookAlignment: TWxchbxAlignStyleItem;

    FEVT_UPDATE_UI: string;
    FEVT_CHOICEBOOK_PAGE_CHANGED: string;
    FEVT_CHOICEBOOK_PAGE_CHANGING: string;

    { Private methods of TWxChoicebook }
    procedure AutoInitialize;
    procedure AutoDestroy;

  protected

    procedure Loaded; override;

  public
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxChoicebook }
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

    function GetGenericColor(strVariableName: string): string;
    procedure SetGenericColor(strVariableName, strValue: string);

    function GenerateLastCreationCode: string;
    //    procedure SetChoicebookStyle(style: TWxchbxStyleSet);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

    function GetBookAlignment(Value: TWxchbxAlignStyleItem): string;

  published
    property EVT_UPDATE_UI: string read FEVT_UPDATE_UI write FEVT_UPDATE_UI;
    property EVT_CHOICEBOOK_PAGE_CHANGED: string
      read FEVT_CHOICEBOOK_PAGE_CHANGED write FEVT_CHOICEBOOK_PAGE_CHANGED;
    property EVT_CHOICEBOOK_PAGE_CHANGING: string
      read FEVT_CHOICEBOOK_PAGE_CHANGING write FEVT_CHOICEBOOK_PAGE_CHANGING;

    property Orientation: TWxSizerOrientation
      read FOrientation write FOrientation default wxHorizontal;
    property Wx_Caption: string read FWx_Caption write FWx_Caption;
    property Wx_Class: string read FWx_Class write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      read FWx_ControlOrientation write FWx_ControlOrientation;
    property Wx_EventList: TStringList read FWx_EventList write FWx_EventList;
    property Wx_IDName: string read FWx_IDName write FWx_IDName;
    property Wx_IDValue: integer read FWx_IDValue write FWx_IDValue default -1;
    property Wx_Hidden: boolean read FWx_Hidden write FWx_Hidden;
    property Wx_ToolTip: string read FWx_ToolTip write FWx_ToolTip;
    property Wx_HelpText: string read FWx_HelpText write FWx_HelpText;
    property Wx_Enabled: boolean read FWx_Enabled write FWx_Enabled default True;
    //    property Wx_ChoiceBookStyle: TWxchbxStyleSet Read FWx_ChoiceBookStyle Write SetChoicebookStyle;
    property Wx_GeneralStyle: TWxStdStyleSet read FWx_GeneralStyle write FWx_GeneralStyle;

    property Wx_Border: integer read GetBorderWidth write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment read GetBorderAlignment write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet read FWx_Alignment write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer read GetStretchFactor write SetStretchFactor default 0;

    property Wx_ProxyBGColorString: TWxColorString read FWx_ProxyBGColorString write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString read FWx_ProxyFGColorString write FWx_ProxyFGColorString;
    property InvisibleBGColorString: string read FInvisibleBGColorString write FInvisibleBGColorString;
    property InvisibleFGColorString: string read FInvisibleFGColorString write FInvisibleFGColorString;
    property Wx_BookAlignment: TWxchbxAlignStyleItem read FWx_BookAlignment write FWx_BookAlignment;

    property Wx_Comments: TStrings read FWx_Comments write FWx_Comments;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxChoicebook]);
end;

procedure TWxChoicebook.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_EventList := TStringList.Create;
  FWx_Comments := TStringList.Create;
  FOrientation := wxHorizontal;
  FWx_Class := 'wxChoicebook';
  FWx_IDValue := -1;
  FWx_StretchFactor := 0;
  FWx_Border := 5;
  FWx_Enabled := True;
  FWx_BorderAlignment := [wxAll];
  FWx_Alignment := [wxALIGN_CENTER];
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor := self.color;
  defaultFGColor := self.font.color;
  // implemented for future use   FWx_ChoiceBookStyle    := [];
  FWx_BookAlignment := wxCHB_DEFAULT;

end; { of AutoInitialize }

procedure TWxChoicebook.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

constructor TWxChoicebook.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoInitialize;

  PopulateGenericProperties(FWx_PropertyList);

  {
    FWx_PropertyList.add('Wx_ChoiceBookStyle:Choicebook Styles');
  }
  FWx_PropertyList.Add('Wx_BookAlignment:Book Styles');

  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');
  FWx_EventList.add('EVT_CHOICEBOOK_PAGE_CHANGED:OnPageChanged');
  FWx_EventList.add('EVT_CHOICEBOOK_PAGE_CHANGING:OnPageChanging');

end;

destructor TWxChoicebook.Destroy;
begin
  AutoDestroy;
  inherited Destroy;
end;

procedure TWxChoicebook.Loaded;
begin
  inherited Loaded;
end;

function TWxChoicebook.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxChoicebook.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxChoicebook.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
  if (XRCGEN) then
 begin
    if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_CHOICEBOOK_PAGE_CHANGED) <> '' then
    Result := Result + #13 + Format('EVT_CHOICEBOOK_PAGE_CHANGED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_CHOICEBOOK_PAGE_CHANGED]) + '';

  if trim(EVT_CHOICEBOOK_PAGE_CHANGING) <> '' then
    Result := Result + #13 + Format('EVT_CHOICEBOOK_PAGE_CHANGING(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_CHOICEBOOK_PAGE_CHANGING]) + '';
   end
 else
 begin
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_CHOICEBOOK_PAGE_CHANGED) <> '' then
    Result := Result + #13 + Format('EVT_CHOICEBOOK_PAGE_CHANGED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_CHOICEBOOK_PAGE_CHANGED]) + '';

  if trim(EVT_CHOICEBOOK_PAGE_CHANGING) <> '' then
    Result := Result + #13 + Format('EVT_CHOICEBOOK_PAGE_CHANGING(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_CHOICEBOOK_PAGE_CHANGING]) + '';
end
end;

function TWxChoicebook.GenerateXRCControlCreation(IndentString: string): TStringList;
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
    Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

    stylstr := GetChoicebookSpecificStyle(self.Wx_GeneralStyle {, self.Wx_BookAlignment, Self.Wx_NoteBookStyle});
    if stylstr <> '' then
      Result.Add(IndentString + Format('  <style>%s | %s</style>',
        [GetBookAlignment(self.Wx_BookAlignment), stylstr]))
    else
      Result.Add(IndentString + Format('  <style>%s</style>',
        //      [GetChoicebookSpecificStyle(self.Wx_GeneralStyle{, self.Wx_ChoiceAlignment, self.Wx_ChoiceBookStyle})]));
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

function TWxChoicebook.GenerateGUIControlCreation: string;
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

  //  strStyle := GetChoicebookSpecificStyle(self.Wx_GeneralStyle, self.Wx_ChoiceBookStyle);
  strStyle := GetChoicebookSpecificStyle(self.Wx_GeneralStyle {, Self.Wx_BookAlignment, self.Wx_ChoiceBookStyle});

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
    Format('%s = new %s(%s, %s, wxPoint(%d,%d),wxSize(%d,%d)%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
      self.Wx_IDValue),
    self.Left, self.Top, self.Width, self.Height, strStyle]);
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

function TWxChoicebook.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxChoicebook.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/choicebk.h>';
end;

function TWxChoicebook.GenerateImageInclude: string;
begin

end;

function TWxChoicebook.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxChoicebook.GetIDName: string;
begin
  Result := '';
  Result := wx_IDName;
end;

function TWxChoicebook.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxChoicebook.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
  if EventName = 'EVT_CHOICEBOOK_PAGE_CHANGED' then
  begin
    Result := 'wxChoicebookEvent& event';
    exit;
  end;

  if EventName = 'EVT_CHOICEBOOK_PAGE_CHANGING' then
  begin
    Result := 'wxChoicebookEvent& event';
    exit;
  end;

end;

function TWxChoicebook.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxChoicebook.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxChoicebook.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxChoicebook.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxChoicebook.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxChoicebook.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxChoicebook.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxChoicebook.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxChoicebook';
  Result := wx_Class;
end;

procedure TWxChoicebook.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

{
procedure TWxChoicebook.SetChoicebookStyle(style: TWxchbxStyleSet);
begin
  FWx_ChoicebookStyle := style;

  //mn we need to set the Choice position here, we go backwards from bottom, right, left to top
  //mn wxCHB_DEFAULT and wxCHB_TOP are assumed to be the same
  If (wxCHB_BOTTOM in FWx_ChoicebookStyle) then
    Self.cbb1.Align :=  alBottom;

  If (wxCHB_RIGHT in FWx_ChoicebookStyle) then
  begin
    Self.cbb1.Align := alRight;
    Self.cbb1.Width := 145;
  end;

  If (wxCHB_LEFT in FWx_ChoicebookStyle) then
  begin
    Self.cbb1.Align := alLeft;
    Self.cbb1.Width := 145;
  end;

  If (wxCHB_TOP in FWx_ChoicebookStyle) or (wxCHB_DEFAULT in FWx_ChoicebookStyle) then
    Self.cbb1.Align := alTop;

end;
}

procedure TWxChoicebook.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxChoicebook.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxChoicebook.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxChoicebook.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxChoicebook.GetGenericColor(strVariableName: string): string;
begin

end;

procedure TWxChoicebook.SetGenericColor(strVariableName, strValue: string);
begin

end;

function TWxChoicebook.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxChoicebook.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxChoicebook.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxChoicebook.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxChoicebook.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxChoicebook.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxChoicebook.GenerateLastCreationCode: string;
begin
  Result := '';
end;

function TWxChoicebook.GetBookAlignment(Value: TWxchbxAlignStyleItem): string;
begin
  if Value = wxCHB_BOTTOM then
  begin
    Result := 'wxCHB_BOTTOM';
    Self.cbb1.Align := alBottom;
    exit;
  end;
  if Value = wxCHB_RIGHT then
  begin
    Result := 'wxCHB_RIGHT';
    Self.cbb1.Align := alRight;
    Self.cbb1.Width := 130;
    exit;
  end;
  if Value = wxCHB_LEFT then
  begin
    Result := 'wxCHB_LEFT';
    Self.cbb1.Align := alLeft;
    Self.cbb1.Width := 130;
    exit;
  end;
  if Value = wxCHB_TOP then
  begin
    Result := 'wxCHB_TOP';
    Self.cbb1.Align := alTop;
    exit;
  end;
  if Value = wxCHB_DEFAULT then
  begin
    Result := 'wxCHB_DEFAULT';
    Self.cbb1.Align := alTop;
    exit;
  end;

end;

end.

