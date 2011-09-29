 { ****************************************************************** }
 {                                                                    }
{ $Id: wxMediaCtrl.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
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


unit WxMediaCtrl;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ExtCtrls, WxUtils, Wxcontrolpanel, WxAuiToolBar,
  WxAuiNotebookPage, WxSizerPanel, UValidator;

type


 TWxMediaControlBackEndItem = (NONE, wxMEDIABACKEND_DIRECTSHOW, wxMEDIABACKEND_QUICKTIME,
       wxMEDIABACKEND_GSTREAMER, wxMEDIABACKEND_WMP10);
 //TWxMediaControlBackEndSet = set of TWxMediaControlBackEndItem;

  TWxMediaCtrl = class(TWxControlPanel, IWxComponentInterface, IWxValidatorInterface)
  private
    FEVT_MEDIA_STOP:String;
    FEVT_MEDIA_LOADED:String;
    FEVT_MEDIA_PLAY:String;
    FEVT_MEDIA_PAUSE:String;
    FEVT_MEDIA_FINISHED:String;

    { Private fields of TWxMediaCtrl }
    { Storage for property Picture }
    FPicture: TPicture;
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
    { Storage for property Wx_IDName }
    FWx_IDName: string;
    { Storage for property Wx_IDValue }
    FWx_IDValue: integer;
    { Storage for property Wx_StretchFactor }
    FWx_StretchFactor: integer;
    
    FWx_Control:TWxMediaCtrlControl;
    FWx_FileName:string;

    FWx_Validator: string;
    FWx_ProxyValidatorString : TWxValidatorString;

    { Storage for property Wx_ProxyBGColorString }
    FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
    FWx_ProxyFGColorString: TWxColorString;
    FWx_Comments: TStrings;
    { Storage for property Wx_ToolTip }
    FWx_ToolTip: string;
    FImage: TImage;
    FWx_PropertyList: TStringList;
    FWx_EventList: TStringList;
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

    FWx_Backend : TWxMediaControlBackEndItem;

    { Private methods of TWxMediaCtrl }
    { Method to set variable and property values and create objects }
    procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
    procedure AutoDestroy;
    { Read method for property Picture }
    function GetPicture: TPicture;
    { Write method for property Picture }
    procedure SetPicture(Value: TPicture);

  protected
    { Protected fields of TWxMediaCtrl }

    { Protected methods of TWxMediaCtrl }
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;
    procedure Paint; override;

  public
    { Public fields and properties of TWxMediaCtrl }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxMediaCtrl }
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
    function GetIDValue: integer;
    function GetParameterFromEventName(EventName: string): string;
    function GetPropertyList: TStringList;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: integer);
    procedure SetWxClassName(wxClassName: string);

    function GetValidator:String;
    procedure SetValidator(value:String);
    function GetValidatorString:TWxValidatorString;
    procedure SetValidatorString(Value:TWxValidatorString);

    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

    function GetBackend(Wx_MediaBackend: TWxMediaControlBackEndItem) : string;

  published
    { Published properties of TWxMediaCtrl }
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
    property Picture: TPicture Read GetPicture Write SetPicture;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden default False;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: integer Read FWx_IDValue Write FWx_IDValue;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
    property Wx_Control: TWxMediaCtrlControl Read FWx_Control Write FWx_Control;
    property Wx_FileName: string Read FWx_FileName Write FWx_FileName;

    property Wx_Validator: string Read FWx_Validator Write FWx_Validator;
    property Wx_ProxyValidatorString : TWxValidatorString Read GetValidatorString Write SetValidatorString;

    property Wx_Backend : TWxMediaControlBackEndItem read FWx_Backend write FWx_Backend;
    
    property EVT_MEDIA_STOP:String Read FEVT_MEDIA_STOP Write FEVT_MEDIA_STOP;
    property EVT_MEDIA_LOADED:String Read FEVT_MEDIA_LOADED Write FEVT_MEDIA_LOADED;
    property EVT_MEDIA_PLAY:String Read FEVT_MEDIA_PLAY Write FEVT_MEDIA_PLAY;
    property EVT_MEDIA_PAUSE:String Read FEVT_MEDIA_PAUSE Write FEVT_MEDIA_PAUSE;
    property EVT_MEDIA_FINISHED:String Read FEVT_MEDIA_FINISHED Write FEVT_MEDIA_FINISHED;

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
     { Register TWxMediaCtrl with Standard as its
       default page on the Delphi component palette }
  RegisterComponents('Standard', [TWxMediaCtrl]);
end;

{ Method to set variable and property values and create objects }
procedure TWxMediaCtrl.AutoInitialize;
begin
  FImage                 := TImage.Create(Self);
  FImage.Parent          := Self;
  FWx_PropertyList       := TStringList.Create;
  FWx_EventList          := TStringList.Create;
  FPicture               := TPicture.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxMediaCtrl';
  FWx_Hidden             := False;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_StretchFactor      := 0;
  FWx_Control            := wxMEDIACTRLPLAYERCONTROLS_NONE;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor         := self.color;
  defaultFGColor         := self.font.color;
  FWx_Comments           := TStringList.Create;
  FWx_ProxyValidatorString := TwxValidatorString.Create(self);

  FImage.Align  := alClient	;
  FImage.Center := True;
  FImage.Stretch:=false ;
  FImage.Picture.Bitmap.Handle :=  LoadBitmap(hInstance, 'MEDIAPLAYERIMG');
  self.Caption  := '';
  self.Height   := 150;
  self.Width    := 150;
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxMediaCtrl.AutoDestroy;
begin
  FImage.Destroy;
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_ProxyBGColorString.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FPicture.Destroy;
  FWx_Comments.Destroy;
  FWx_ProxyValidatorString.Destroy;
end; { of AutoDestroy }

{ Read method for property Picture }
function TWxMediaCtrl.GetPicture: TPicture;
begin
  Result := FImage.Picture;
end;

{ Write method for property Picture }
procedure TWxMediaCtrl.SetPicture(Value: TPicture);
begin
     { Use Assign method because TPicture is an object type
       and FPicture has been created. }
  FImage.Picture.Assign(Value);

     { If changing this property affects the appearance of
       the component, call Invalidate here so the image will be
       updated. }
  { Invalidate; }

  if FImage.Picture.bitmap.handle <> 0 then
  begin
    self.Height := FImage.Picture.bitmap.Height;
    self.Width  := FImage.Picture.bitmap.Width;
  end;
end;

{ Override OnClick handler from TWxControlPanel,IWxComponentInterface }
procedure TWxMediaCtrl.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
  inherited Click;

     { Code to execute after click behavior
       of parent }

end;

{ Override OnKeyPress handler from TWxControlPanel,IWxComponentInterface }
procedure TWxMediaCtrl.KeyPress(var Key: char);
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

constructor TWxMediaCtrl.Create(AOwner: TComponent);
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

  FWx_PropertyList.add('Wx_FileName:File Name');
  FWx_PropertyList.add('Wx_Controls:Controls');
  FWx_PropertyList.add('wxMEDIACTRLPLAYERCONTROLS_NONE:wxMEDIACTRLPLAYERCONTROLS_NONE');
  FWx_PropertyList.add('wxMEDIACTRLPLAYERCONTROLS_STEP:wxMEDIACTRLPLAYERCONTROLS_STEP');
  FWx_PropertyList.add('wxMEDIACTRLPLAYERCONTROLS_VOLUME:wxMEDIACTRLPLAYERCONTROLS_VOLUME');

  FWx_PropertyList.add('Wx_Backend:Backend');
  FWx_PropertyList.add('NONE:NONE');
  FWx_PropertyList.add('wxMEDIABACKEND_DIRECTSHOW:wxMEDIABACKEND_DIRECTSHOW');
  FWx_PropertyList.add('wxMEDIABACKEND_QUICKTIME:wxMEDIABACKEND_QUICKTIME');
  FWx_PropertyList.add('wxMEDIABACKEND_GSTREAMER:wxMEDIABACKEND_GSTREAMER');
  FWx_PropertyList.add('wxMEDIABACKEND_WMP10:wxMEDIABACKEND_WMP10');

  FWx_EventList.add('EVT_MEDIA_STOP:OnMediaStop');
  FWx_EventList.add('EVT_MEDIA_LOADED:OnMediaLoaded');
  FWx_EventList.add('EVT_MEDIA_PLAY:OnMediaPlay');
  FWx_EventList.add('EVT_MEDIA_PAUSE:OnMediaPause');
  FWx_EventList.add('EVT_MEDIA_FINISHED:OnMediaFinished');

end;

destructor TWxMediaCtrl.Destroy;
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

function TWxMediaCtrl.GenerateEnumControlIDs: string;
begin
  Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
end;

function TWxMediaCtrl.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxMediaCtrl.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
  if trim(EVT_MEDIA_STOP) <> '' then
    Result := Result + #13 + Format('EVT_MEDIA_STOP(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_MEDIA_STOP]) + '';

  if trim(EVT_MEDIA_LOADED) <> '' then
    Result := Result + #13 + Format('EVT_MEDIA_LOADED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_MEDIA_LOADED]) + '';

  if trim(EVT_MEDIA_PLAY) <> '' then
    Result := Result + #13 + Format('EVT_MEDIA_PLAY(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_MEDIA_PLAY]) + '';

  if trim(EVT_MEDIA_PAUSE) <> '' then
    Result := Result + #13 + Format('EVT_MEDIA_PAUSE(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_MEDIA_PAUSE]) + '';

  if trim(EVT_MEDIA_FINISHED) <> '' then
    Result := Result + #13 + Format('EVT_MEDIA_FINISHED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_MEDIA_FINISHED]) + '';
end;

function TWxMediaCtrl.GenerateXRCControlCreation(IndentString: string): TStringList;
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

    Result.Add('<backend>' + GetBackend(Wx_Backend) + '</backend>');

    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxMediaCtrl.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  strControlString:string;
  strStyle, parentName, strAlignment: string;
begin
  Result   := '';
  strStyle := GetStdStyleString(self.Wx_GeneralStyle);

  if (trim(strStyle) = '')  then
     strStyle := '0';

  strStyle := ', ' + strStyle + ', ' + GetBackend(Wx_Backend);

  if trim(Wx_ProxyValidatorString.strValidatorValue) <> '' then
   strStyle := strStyle + ', ' + Wx_ProxyValidatorString.strValidatorValue
                   + ', ' + GetCppString(Name)

  else
    strStyle := strStyle + ', wxDefaultValidator, ' + GetCppString(Name);

    if FWx_PaneCaption = '' then
    FWx_PaneCaption := Self.Name;
  if FWx_PaneName = '' then
    FWx_PaneName := Self.Name + '_Pane';

  parentName := GetWxWidgetParent(self, Wx_AuiManaged);

  if Result <> '' then
    Result := Result + #13 + Format(
      '%s = new %s(%s, %s, %s, %s, %s%s);',
      [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
      self.Wx_IDValue),GetCppString(Wx_FileName),
      GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle])
  else
    Result := GetCommentString(self.FWx_Comments.Text) +
      Format('%s = new %s(%s, %s, %s, %s, %s%s);',
      [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
      self.Wx_IDValue),GetCppString(Wx_FileName),
      GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);


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

  strColorStr := GetWxFontDeclaration(self.Font);
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetFont(%s);', [self.Name, strColorStr]);

  strControlString := GetMediaCtrlStyle(wx_Control);
  if trim(strControlString) <> '' then
      Result := Result + #13 + Format('%s->ShowPlayerControls(%s);', [self.Name, strControlString]);



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
    Result := Result + #13 + Format('%s->Add(%s, %d, %s, %d);',
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

function TWxMediaCtrl.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxMediaCtrl.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/mediactrl.h>';
end;

function TWxMediaCtrl.GenerateImageInclude: string;
begin
  Result := '';
end;

function TWxMediaCtrl.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxMediaCtrl.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxMediaCtrl.GetIDValue: integer;
begin
  Result := wx_IDValue;
end;

function TWxMediaCtrl.GetParameterFromEventName(EventName: string): string;
begin
  Result := '';
 if (EventName = 'EVT_MEDIA_STOP') or (EventName = 'EVT_MEDIA_LOADED') or (EventName = 'EVT_MEDIA_PLAY') or
 (EventName = 'EVT_MEDIA_PAUSE') or (EventName = 'EVT_MEDIA_FINISHED') then
  begin
    Result := 'wxMediaEvent& event';
    exit;
  end;
end;

function TWxMediaCtrl.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxMediaCtrl.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxMediaCtrl.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxMediaCtrl.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxMediaCtrl.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxMediaCtrl.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxMediaCtrl.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxMediaCtrl.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxMediaCtrl';
  Result := wx_Class;
end;

procedure TWxMediaCtrl.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxMediaCtrl.Paint;
begin
     { Make this component look like its parent component by calling
       its parent's Paint method. }
  inherited Paint;

     { To change the appearance of the component, use the methods
       supplied by the component's Canvas property (which is of
       type TCanvas).  For example, }

  { Canvas.Rectangle(0, 0, Width, Height); }
  self.Caption   := '';
  FImage.stretch := True;
end;

procedure TWxMediaCtrl.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxMediaCtrl.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxMediaCtrl.SetIDValue(IDValue: integer);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxMediaCtrl.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxMediaCtrl.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxMediaCtrl.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxMediaCtrl.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxMediaCtrl.GetValidatorString:TWxValidatorString;
begin
  Result := FWx_ProxyValidatorString;
  Result.FstrValidatorValue := Wx_Validator;
end;

procedure TWxMediaCtrl.SetValidatorString(Value:TWxValidatorString);
begin
  FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
  Wx_Validator := Value.FstrValidatorValue;
end;

function TWxMediaCtrl.GetValidator:String;
begin
  Result := Wx_Validator;
end;

procedure TWxMediaCtrl.SetValidator(value:String);
begin
  Wx_Validator := value;
end;

function TWxMediaCtrl.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxMediaCtrl.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxMediaCtrl.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxMediaCtrl.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxMediaCtrl.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxMediaCtrl.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxMediaCtrl.GetBackend(Wx_MediaBackend: TWxMediaControlBackEndItem) : string;
begin
  Result := '';

  if Wx_MediaBackend = wxMEDIABACKEND_DIRECTSHOW then
  begin
    Result := 'wxMEDIABACKEND_DIRECTSHOW';
  end;
  if Wx_MediaBackend = wxMEDIABACKEND_QUICKTIME then
  begin
    Result := 'wxMEDIABACKEND_QUICKTIME';
  end;
  if Wx_MediaBackend = wxMEDIABACKEND_GSTREAMER then
  begin
    Result := 'wxMEDIABACKEND_GSTREAMER';
  end;
  if Wx_MediaBackend = wxMEDIABACKEND_WMP10 then
  begin
    Result := 'wxMEDIABACKEND_WMP10';
  end;

  Result := GetCppString(Result);

end;

end.
