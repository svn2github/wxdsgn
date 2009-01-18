// $Id$
{                                                                    }
{   Copyright © 2003-2009 by Guru Kathiresan                         }
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

unit wxAuiNoteBookPage;

interface

uses
  Windows, Messages, SysUtils, Graphics, Classes, Controls, ComCtrls,
  WxUtils, Forms, WxSizerPanel;

type
  TWxAuiNoteBookPage =  class (TTabSheet, IWxComponentInterface, IWxContainerInterface)
//class(TBitmapTabControl, IWxComponentInterface, IWxContainerInterface)
private
    { Private declarations }
    FEVT_UPDATE_UI: string;
    FWx_BKColor: TColor;
    FWx_Border: integer;
    FWx_Class: string;
    FWx_ControlOrientation: TWxControlOrientation;
    FWx_Default: boolean;
    FWx_Enabled: boolean;
    FWx_EventList: TStringList;
    FWx_FGColor: TColor;
    FWx_GeneralStyle: TWxStdStyleSet;
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

  protected
    { Protected declarations }
  public
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    procedure AutoInitialize;
    procedure AutoDestroy;

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

    function GetGenericColor(strVariableName: string): string;
    procedure SetGenericColor(strVariableName, strValue: string);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

  published
    { Published declarations }
    property EVT_UPDATE_UI: string read FEVT_UPDATE_UI write FEVT_UPDATE_UI;
    property Wx_BKColor: TColor read FWx_BKColor write FWx_BKColor;
    property Wx_Class: string read FWx_Class write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      read FWx_ControlOrientation write FWx_ControlOrientation;
    property Wx_Default: boolean read FWx_Default write FWx_Default;
    property Wx_Enabled: boolean read FWx_Enabled write FWx_Enabled default True;
    property Wx_EventList: TStringList read FWx_EventList write FWx_EventList;
    property Wx_FGColor: TColor read FWx_FGColor write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      read FWx_GeneralStyle write FWx_GeneralStyle;
    property Wx_HelpText: string read FWx_HelpText write FWx_HelpText;
    property Wx_Hidden: boolean read FWx_Hidden write FWx_Hidden;
    property Wx_IDName: string read FWx_IDName write FWx_IDName;
    property Wx_IDValue: longint read FWx_IDValue write FWx_IDValue default -1;
    property Wx_ToolTip: string read FWx_ToolTip write FWx_ToolTip;

    property Wx_ProxyBGColorString: TWxColorString read FWx_ProxyBGColorString write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString read FWx_ProxyFGColorString write FWx_ProxyFGColorString;
    property InvisibleBGColorString: string read FInvisibleBGColorString write FInvisibleBGColorString;
    property InvisibleFGColorString: string read FInvisibleFGColorString write FInvisibleFGColorString;

    property Wx_Border: integer read GetBorderWidth write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment read GetBorderAlignment write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet read FWx_Alignment write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer read GetStretchFactor write SetStretchFactor default 0;

    property Wx_Comments: TStrings read FWx_Comments write FWx_Comments;

  end;

procedure Register;

implementation

constructor TWxAuiNoteBookPage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  AutoInitialize;

  { Code to perform other tasks when the component is created }
  PopulateGenericProperties(FWx_PropertyList);

  FWx_PropertyList.add('Caption:Label');

  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxAuiNoteBookPage.Destroy;
begin
  AutoDestroy;
  inherited Destroy;
end;

{ Method to set variable and property values and create objects }

procedure TWxAuiNoteBookPage.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_EventList := TStringList.Create;
  FWx_Border := 5;
  FWx_Class := 'wxPanel';
  FWx_Enabled := True;
  FWx_BorderAlignment := [wxAll];
  FWx_Alignment := [wxALIGN_CENTER];
  FWx_IDValue := -1;
  FWx_StretchFactor := 0;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor := self.color;
  defaultFGColor := self.font.color;
  FWx_Comments := TStringList.Create;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }

procedure TWxAuiNoteBookPage.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

function TWxAuiNoteBookPage.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxAuiNoteBookPage.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxAuiNoteBookPage.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

end;

function TWxAuiNoteBookPage.GenerateXRCControlCreation(IndentString: string): TStringList;
var
  i: integer;
  wxcompInterface: IWxComponentInterface;
  tempstring: TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));
    Result.Add(IndentString + Format('  <label>%s</label>', [XML_Label(self.Caption)]));

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

function TWxAuiNoteBookPage.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strStyle: string;
  parentName, strAlignment: string;

begin
{  Result := '';
  strStyle := GetStdStyleString(self.Wx_GeneralStyle);
  if trim(strStyle) <> '' then
    strStyle := ', ' + strStyle;

  parentName := GetWxWidgetParent(self, Wx_AuiManaged);

  strBitmap := 'wxBitmap ' + self.Name + '_BITMAP' + ' (wxNullBitmap);';

  if assigned(Wx_Bitmap) then
    if Wx_Bitmap.Bitmap.Handle <> 0 then
      strBitmap := 'wxBitmap ' + self.Name + '_BITMAP' + ' (' + GetDesignerFormName(self) + '_' + self.Name + '_XPM' + ');';
}
  Result := GetCommentString(self.FWx_Comments.Text);

{  if (XRCGEN) then
  begin //generate xrc loading code
    Result := GetCommentString(self.FWx_Comments.Text) +
      Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
      [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);
  end
  else
  begin //generate the cpp code
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
  if not (XRCGEN) then //NUKLEAR ZELPH
    Result := Result + #13 + Format('%s->AddPage(%s, %s, false, %s);',
      [parentName, self.Name, GetCppString(self.Caption), strBitmap]);
}
end;

function TWxAuiNoteBookPage.GenerateGUIControlDeclaration: string;
begin
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxAuiNoteBookPage.GenerateHeaderInclude: string;
begin
  Result := '#include <wx/panel.h>';
end;

function TWxAuiNoteBookPage.GenerateImageInclude: string;
begin

end;

function TWxAuiNoteBookPage.GetEventList: TStringList;
begin
  Result := Wx_EventList;
end;

function TWxAuiNoteBookPage.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxAuiNoteBookPage.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxAuiNoteBookPage.GetParameterFromEventName(EventName: string): string;
begin
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxAuiNoteBookPage.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxAuiNoteBookPage.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxAuiNoteBookPage.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxAuiNoteBookPage.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxAuiNoteBookPage.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxAuiNoteBookPage.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxAuiNoteBookPage.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxAuiNoteBookPage.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxPanel';
  Result := wx_Class;
end;

procedure TWxAuiNoteBookPage.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxAuiNoteBookPage.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxAuiNoteBookPage.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxAuiNoteBookPage.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxAuiNoteBookPage.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxAuiNoteBookPage.GetGenericColor(strVariableName: string): string;
begin

end;

procedure TWxAuiNoteBookPage.SetGenericColor(strVariableName, strValue: string);
begin

end;

function TWxAuiNoteBookPage.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxAuiNoteBookPage.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxAuiNoteBookPage.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxAuiNoteBookPage.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxAuiNoteBookPage.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxAuiNoteBookPage.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxAuiNoteBookPage]);
end;

end.

