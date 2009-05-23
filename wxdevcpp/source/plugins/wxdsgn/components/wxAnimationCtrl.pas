{ ****************************************************************** }
{                                                                    }
{ $Id$ }
{                                                                    }
{   Copyright © 2003-2007 by Malcolm Nealon                          }
{   based on work performed by Guru Kathiresan                       }
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

unit wxAnimationCtrl;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ExtCtrls, WxUtils, Wxcontrolpanel, WxAuiNotebookPage,
  WxSizerPanel, wxAuiToolBar, xProcs, JvExControls, JvAnimatedImage, JvGIFCtrl;

type
  TwxAnimationCtrl = class(TImage, IWxComponentInterface)
  private
    { Private fields of TwxAnimationCtrl }
    FWx_AnimationCtrlStyle: TWxAnimationCtrlStyleSet;
    FWx_Border: integer;
    FWx_Class: string;
    FWx_ControlOrientation: TWxControlOrientation;
    FWx_Enabled: boolean;
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

    { Storage for property Wx_ProxyBGColorString }
    FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
    FWx_ProxyFGColorString: TWxColorString;
    { Storage for property Wx_StretchFactor }
    FWx_StretchFactor: integer;
    FWx_Comments: TStrings;
    { Storage for property Wx_ToolTip }
    FWx_ToolTip: string;
    FWx_EventList: TStringList;

    FWx_LoadFromFile: TWxAnimationFileNameString;
    FWx_FiletoLoad: string;
    FWx_Play: Boolean;

    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
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

    { Private methods of TwxAnimationCtrl }
    { Method to set variable and property values and create objects }
    procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
    procedure AutoDestroy;

  protected
    { Protected fields of TwxAnimationCtrl }

    { Protected methods of TwxAnimationCtrl }
    procedure Loaded; override;

  public
    { Public fields and properties of TwxAnimationCtrl }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TwxAnimationCtrl }
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
    procedure SetWxFileName(wxFileName: string);

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

    function GetAnimationCtrlStyleString(stdStyle: TWxAnimationCtrlStyleSet): string;

  published
    { Published properties of TwxAnimationCtrl }
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;

    property Wx_Class: string read FWx_Class write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      read FWx_ControlOrientation write FWx_ControlOrientation;
    property Wx_Enabled: boolean read FWx_Enabled write FWx_Enabled default True;
    property Wx_GeneralStyle: TWxStdStyleSet read FWx_GeneralStyle write FWx_GeneralStyle;
    property Wx_HelpText: string read FWx_HelpText write FWx_HelpText;
    property Wx_Hidden: boolean read FWx_Hidden write FWx_Hidden default False;
    property Wx_IDName: string read FWx_IDName write FWx_IDName;
    property Wx_IDValue: longint read FWx_IDValue write FWx_IDValue;
    property Wx_ToolTip: string read FWx_ToolTip write FWx_ToolTip;

    property Wx_Border: integer read GetBorderWidth write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment read GetBorderAlignment write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet read FWx_Alignment write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer read GetStretchFactor write SetStretchFactor default 0;

    property Wx_ProxyBGColorString: TWxColorString read FWx_ProxyBGColorString write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString read FWx_ProxyFGColorString write FWx_ProxyFGColorString;
    property InvisibleBGColorString: string read FInvisibleBGColorString write FInvisibleBGColorString;
    property InvisibleFGColorString: string read FInvisibleFGColorString write FInvisibleFGColorString;

    property Wx_Comments: TStrings read FWx_Comments write FWx_Comments;

    property Wx_AnimationCtrlStyle: TWxAnimationCtrlStyleSet read FWx_AnimationCtrlStyle write FWx_AnimationCtrlStyle;
    property Wx_LoadFromFile: TWxAnimationFileNameString read FWx_LoadFromFile write FWx_LoadFromFile;
    property Wx_FiletoLoad: string read FWx_FiletoLoad write FWx_FiletoLoad;
    property Wx_Play: Boolean read FWx_Play write FWx_Play;

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
  { Register TwxAnimationCtrl with Standard as its
    default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TwxAnimationCtrl]);
end;

{ Method to set variable and property values and create objects }

procedure TwxAnimationCtrl.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Border := 5;
  FWx_Class := 'wxAnimationCtrl';
  FWx_Hidden := False;
  FWx_BorderAlignment := [wxAll];
  FWx_Alignment := [wxALIGN_CENTER];
  FWx_StretchFactor := 0;

  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor := self.color;
  defaultFGColor := self.font.color;
  FWx_LoadFromFile := TWxAnimationFileNameString.Create;
  FWx_Comments := TStringList.Create;

  {
     FImage.Align  := alClient;
    FImage.Center := True;
    self.Caption  := '';
    self.Height   := 20;
    self.Width    := 20;
  }
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }

procedure TwxAnimationCtrl.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_LoadFromFile.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

constructor TwxAnimationCtrl.Create(AOwner: TComponent);
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

  { Code to perform other tasks when the component is created }
  PopulateGenericProperties(FWx_PropertyList);
  PopulateAuiGenericProperties(FWx_PropertyList);
  //  FWx_PropertyList.add('Image:Image');
  FWx_PropertyList.add('Wx_AnimationCtrlStyle:AnimationCtrl Styles');
  FWx_PropertyList.add('wxAC_DEFAULT_STYLE:wxAC_DEFAULT_STYLE');
  FWx_PropertyList.add('wxAC_NO_AUTORESIZE:wxAC_NO_AUTORESIZE');
  FWx_PropertyList.Add('Wx_LoadFromFile:Load From File');
  FWx_PropertyList.Add('Wx_Play:Play');

end;

destructor TwxAnimationCtrl.Destroy;
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

function TwxAnimationCtrl.GenerateEnumControlIDs: string;
begin
  Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
end;

function TwxAnimationCtrl.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TwxAnimationCtrl.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
end;

function TwxAnimationCtrl.GenerateXRCControlCreation(IndentString: string): TStringList;
var
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

    stylstr := GetAnimationCtrlSpecificStyle(self.Wx_GeneralStyle);
    if stylstr <> '' then
      Result.Add(IndentString + Format('  <style>%s | %s</style>',
        [GetAnimationCtrlStyleString(self.Wx_AnimationCtrlStyle), stylstr]))
    else
      Result.Add(IndentString + Format('  <style>%s</style>',
        //      [GetChoicebookSpecificStyle(self.Wx_GeneralStyle{, self.Wx_ChoiceAlignment, self.Wx_ChoiceBookStyle})]));
        [GetAnimationCtrlStyleString(self.Wx_AnimationCtrlStyle)]));

    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TwxAnimationCtrl.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  aniStyle, stdStyle, strStyle, parentName, strAlignment, strBitmapArrayName: string;
begin
  Result := '';
  stdStyle := GetStdStyleString(self.Wx_GeneralStyle);
  aniStyle := GetAnimationCtrlStyleString(self.Wx_AnimationCtrlStyle);

  if (trim(stdStyle) <> '') or (trim(aniStyle) <> '') then
    strStyle := ', ';

  if (trim(stdStyle) <> '') and (trim(aniStyle) <> '') then
    strStyle := strStyle + stdStyle + ' | ' + aniStyle
  else
    strStyle := strStyle + stdStyle + aniStyle;

  if FWx_PaneCaption = '' then
    FWx_PaneCaption := Self.Name;
  if FWx_PaneName = '' then
    FWx_PaneName := Self.Name + '_Pane';

  parentName := GetWxWidgetParent(self, Wx_AuiManaged);

  //  if self.Picture.Bitmap.handle = 0 then
  strBitmapArrayName := 'wxNullAnimation';
  {  else begin
      strBitmapArrayName := self.Name + '_ANIMATION';
      Result := GetCommentString(self.FWx_Comments.Text) +
        'wxBitmap ' + strBitmapArrayName + '(' + GetDesignerFormName(self)+'_'+self.Name + '_XPM' + ');';
    end;
  }
  if (XRCGEN) then
 begin//generate xrc loading code
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
    [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);   
 end
 else
 begin
  if Result <> '' then
    Result := Result + #13 + Format('%s = new %s(%s, %s, %s, %s, %s%s);',
      [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
        self.Wx_IDValue),
      strBitmapArrayName, GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle])
  else
    Result := GetCommentString(self.FWx_Comments.Text) +
      Format('%s = new %s(%s, %s, %s, %s, %s %s);',
      [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
        self.Wx_IDValue),
      strBitmapArrayName, GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);
end;
  SetWxFileName(self.FWx_LoadFromFile.FstrFileNameValue);
  if FWx_FiletoLoad <> '' then
  begin
    begin
      Self.Picture.LoadFromFile(FWx_FiletoLoad);
      Result := Result + #13 + Format('%s->LoadFile("%s");',
        [self.Name, FWx_FiletoLoad]);
    end;

    if FWx_Play = True then
    begin
      Result := Result + #13 + Format('%s->Play();', [self.Name]);
    end;

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

function TwxAnimationCtrl.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TwxAnimationCtrl.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/animate.h>';
end;

function TwxAnimationCtrl.GenerateImageInclude: string;
begin
  Result := '';
  {  if self.Picture.Bitmap.Handle <> 0 then
      Result := '#include "Images/' + GetDesignerFormName(self)+'_'+self.Name + '_XPM.xpm"'  }
end;

function TwxAnimationCtrl.GetEventList: TStringList;
begin
  Result := nil;
end;

function TwxAnimationCtrl.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TwxAnimationCtrl.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TwxAnimationCtrl.GetParameterFromEventName(EventName: string): string;
begin
  Result := '';

end;

function TwxAnimationCtrl.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TwxAnimationCtrl.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TwxAnimationCtrl.GetTypeFromEventName(EventName: string): string;
begin

end;

function TwxAnimationCtrl.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TwxAnimationCtrl.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TwxAnimationCtrl.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TwxAnimationCtrl.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TwxAnimationCtrl.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxAnimationCtrl';
  Result := wx_Class;
end;

procedure TwxAnimationCtrl.Loaded;
begin
  inherited Loaded;

  { Perform any component setup that depends on the property
    values having been set }

end;

procedure TWxAnimationCtrl.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TwxAnimationCtrl.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TwxAnimationCtrl.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TwxAnimationCtrl.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TwxAnimationCtrl.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TwxAnimationCtrl.GetGenericColor(strVariableName: string): string;
begin

end;

procedure TwxAnimationCtrl.SetGenericColor(strVariableName, strValue: string);
begin

end;

function TwxAnimationCtrl.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TwxAnimationCtrl.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TwxAnimationCtrl.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TwxAnimationCtrl.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TwxAnimationCtrl.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TwxAnimationCtrl.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

procedure TwxAnimationCtrl.SetWxFileName(wxFileName: string);
begin
  FWx_FiletoLoad := trim(wxFileName);
  strSearchReplace(FWx_FiletoLoad, '\', '/', [srAll]);
  Wx_LoadFromFile.FstrFileNameValue := FWx_FiletoLoad;
end;

function TwxAnimationCtrl.GetAnimationCtrlStyleString(stdStyle: TWxAnimationCtrlStyleSet): string;
var
  I: integer;
  strLst: TStringList;
begin

  strLst := TStringList.Create;

  try
    if wxAC_DEFAULT_STYLE in stdStyle then
      strLst.add('wxAC_DEFAULT_STYLE');

    if wxAC_NO_AUTORESIZE in stdStyle then
    begin
      strLst.add('wxAC_NO_AUTORESIZE');
      self.AutoSize := False;
    end
    else
    begin
      self.AutoSize := True;
    end;

    if strLst.Count = 0 then
      Result := ''
    else
      for I := 0 to strLst.Count - 1 do // Iterate
        if i <> strLst.Count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + strLst[i] // for
          ;
    //sendDebug(Result);

  finally
    strLst.Destroy;
  end;
end;

end.

