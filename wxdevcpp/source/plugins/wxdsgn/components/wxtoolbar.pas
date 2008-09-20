 { ****************************************************************** }
 {                                                                    }
{ $Id: wxtoolbar.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
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

unit WxToolBar;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ComCtrls, WxUtils, WxSizerPanel;

type
  TWxToolBar = class(TToolBar, IWxComponentInterface, IWxDialogNonInsertableInterface,
    IWxToolBarInterface, IWxContainerInterface, IWxContainerAndSizerInterface)
  private
    { Private fields of TWxToolBar }
    FOrientation: TWxSizerOrientation;
    FWx_Caption: string;
    FWx_Class: string;
    FWx_ControlOrientation: TWxControlOrientation;
    FWx_EventList: TStringList;
    FWx_ToolbarStyleSet: TWxtbrStyleSet;
    FWx_GeneralStyle: TWxStdStyleSet;
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
    FWx_Comments: TStrings;
    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

    FEVT_TOOL: string;
    FEVT_MENU: string;
    FEVT_TOOL_RCLICKED: string;
    FEVT_TOOL_ENTER: string;
    FEVT_UPDATE_UI: string;

    { Private methods of TWxToolBar }
    procedure AutoInitialize;
    procedure AutoDestroy;

  protected
    { Protected fields of TWxToolBar }

    { Protected methods of TWxToolBar }
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;

  public
    { Public fields and properties of TWxToolBar }
    defaultBGColor: TColor;
    defaultFGColor: TColor;

    { Public methods of TWxToolBar }
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

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

    procedure SetWxClassName(wxClassName: string);
    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);
    procedure DummySizerNonInsertableInterfaceProcedure;
    function GenerateLastCreationCode: string;
    procedure SetToolbarStyle(Value:TWxtbrStyleSet);

  published
    { Published properties of TWxToolBar }
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
    property Orientation: TWxSizerOrientation
      Read FOrientation Write FOrientation default wxHorizontal;
    property Wx_Caption: string Read FWx_Caption Write FWx_Caption;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_EventList: TStringList Read FWx_EventList Write FWx_EventList;
    property Wx_ToolbarStyleSet: TWxtbrStyleSet
      Read FWx_ToolbarStyleSet Write SetToolbarStyle;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: integer Read FWx_IDValue Write FWx_IDValue default -1;
    property Wx_StretchFactor: integer Read FWx_StretchFactor
      Write FWx_StretchFactor default 0;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

    property InvisibleBGColorString: string
      Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string
      Read FInvisibleFGColorString Write FInvisibleFGColorString;

    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;

    property Wx_Alignment: TWxSizerAlignmentSet
      Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment
      Write SetBorderAlignment default [wxALL];

    property EVT_TOOL: string Read FEVT_TOOL Write FEVT_TOOL;
    property EVT_MENU: string Read FEVT_MENU Write FEVT_MENU;
    property EVT_TOOL_RCLICKED: string Read FEVT_TOOL_RCLICKED Write FEVT_TOOL_RCLICKED;
    property EVT_TOOL_ENTER: string Read FEVT_TOOL_ENTER Write FEVT_TOOL_ENTER;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxToolBar with wxWidgets as its
       default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TWxToolBar]);
end;

{ Method to set variable and property values and create objects }
procedure TWxToolBar.AutoInitialize;
begin
  FWx_PropertyList    := TStringList.Create;
  FOrientation        := wxHorizontal;
  FWx_Class           := 'wxToolBar';
  FWx_EventList       := TStringList.Create;
  FWx_BorderAlignment := [wxALL];
  FWx_Alignment       := [wxALIGN_CENTER];
  FWx_IDValue         := -1;
  FWx_StretchFactor   := 0;
  FWx_Enabled         := True;
  FWx_Comments        := TStringList.Create;
  self.ShowCaptions   := false;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxToolBar.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_Comments.Destroy;
end; { of AutoDestroy }

{ Override OnClick handler from TToolBar }
procedure TWxToolBar.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
  inherited Click;

     { Code to execute after click behavior
       of parent }
end;

{ Override OnKeyPress handler from TToolBar }
procedure TWxToolBar.KeyPress(var Key: char);
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

constructor TWxToolBar.Create(AOwner: TComponent);
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

  FWx_PropertyList.add('Wx_ToolbarStyleSet:Toolbar Styles');
  FWx_PropertyList.add('wxTB_FLAT:wxTB_FLAT');
  FWx_PropertyList.add('wxTB_DOCKABLE:wxTB_DOCKABLE');
  FWx_PropertyList.add('wxTB_HORIZONTAL:wxTB_HORIZONTAL');
  FWx_PropertyList.add('wxTB_VERTICAL:wxTB_VERTICAL');
  FWx_PropertyList.add('wxTB_TEXT:wxTB_TEXT');
  FWx_PropertyList.add('wxTB_NOICONS:wxTB_NOICONS');
  FWx_PropertyList.add('wxTB_NODIVIDER:wxTB_NODIVIDER');
  FWx_PropertyList.add('wxTB_NOALIGN:wxTB_NOALIGN');
  FWx_PropertyList.add('wxTB_HORZ_LAYOUT:wxTB_HORZ_LAYOUT');
  FWx_PropertyList.add('wxTB_HORZ_TEXT:wxTB_HORZ_TEXT');

  FWx_EventList.add('EVT_TOOL:OnTool');
  FWx_EventList.add('EVT_MENU:OnMenu');
  FWx_EventList.add('EVT_TOOL_RCLICKED:OnRightClick');
  FWx_EventList.add('EVT_TOOL_ENTER:OnToolEnter');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxToolBar.Destroy;
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

procedure TWxToolBar.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }
  self.ParentColor := False;
  self.Color := clBtnFace;
end;

function TWxToolBar.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxToolBar.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxToolBar.GenerateEventTableEntries(CurrClassName: string): string;
begin

  Result := '';

 if (XRCGEN) then
 begin//generate xrc loading code
  if trim(EVT_TOOL) <> '' then
    Result := Format('EVT_TOOL(XRCID(%s("%s")),%s::%s)', [StringFormat, self.Name, CurrClassName, EVT_TOOL]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_MENU) <> '' then
    Result := Result + #13 + Format('EVT_MENU(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_MENU]) + '';

  if trim(EVT_TOOL_RCLICKED) <> '' then
    Result := Result + #13 + Format('EVT_TOOL_RCLICKED(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TOOL_RCLICKED]) + '';

  if trim(EVT_TOOL_ENTER) <> '' then
    Result := Result + #13 + Format('EVT_TOOL_ENTER(XRCID(%s("%s")),%s::%s)',
      [StringFormat, self.Name, CurrClassName, EVT_TOOL_ENTER]) + '';
end
else
begin
  if trim(EVT_TOOL) <> '' then
    Result := Format('EVT_TOOL(%s,%s::%s)', [WX_IDName, CurrClassName, EVT_TOOL]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

  if trim(EVT_MENU) <> '' then
    Result := Result + #13 + Format('EVT_MENU(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_MENU]) + '';

  if trim(EVT_TOOL_RCLICKED) <> '' then
    Result := Result + #13 + Format('EVT_TOOL_RCLICKED(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TOOL_RCLICKED]) + '';

  if trim(EVT_TOOL_ENTER) <> '' then
    Result := Result + #13 + Format('EVT_TOOL_ENTER(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_TOOL_ENTER]) + '';
end;

end;

function TWxToolbar.GenerateXRCControlCreation(IndentString: string): TStringList;
var
  i: integer;
  wxcompInterface: IWxComponentInterface;
  tempstring: TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="wxToolBar" name="%s">', [self.Name]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));
    //Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    //Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetToolBarSpecificStyle(self.Wx_GeneralStyle, self.Wx_ToolbarStyleSet)]));

    for i := 0 to self.ControlCount - 1 do // Iterate
      if self.Controls[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) then
        // Only add the XRC control if it is a child of the top-most parent (the form)
        //  If it is a child of a sizer, panel, or other object, then it's XRC code
        //  is created in GenerateXRCControlCreation of that control.
        if (self.Controls[i].GetParentComponent.Name = self.Name) then
        begin
          tempstring := wxcompInterface.GenerateXRCControlCreation('  ' + IndentString);
          try
            Result.AddStrings(tempstring);
          finally
            tempstring.Free;
          end;
        end;
    ; // for

    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;

end;

function TWxToolBar.GenerateGUIControlCreation: string;
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

  strStyle := GetToolBarSpecificStyle(self.Wx_GeneralStyle, self.Wx_ToolbarStyleSet);
  if (trim(strStyle) <> '') then
    strStyle := ', ' + strStyle;

if (XRCGEN) then
 begin//generate xrc loading code
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = wxXmlResource::Get()->LoadToolBar(%s,%s("%s"));',
    [self.Name, parentName, StringFormat, self.Name]);
 end
 else
 begin
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, wxPoint(%d,%d), wxSize(%d,%d)%s);',
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
      [self.Name, GetCppString(Wx_HelpText)]);

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

function TWxToolBar.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
end;

function TWxToolBar.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/toolbar.h>';
end;

function TWxToolBar.GenerateImageInclude: string;
begin

end;

function TWxToolBar.GetEventList: TStringList;
begin
  Result := FWx_EventList;
end;

function TWxToolBar.GetIDName: string;
begin
  Result := '';
  Result := wx_IDName;
end;

function TWxToolBar.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxToolBar.GetParameterFromEventName(EventName: string): string;
begin

  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
  if EventName = 'EVT_TOOL' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;  
  if EventName = 'EVT_MENU' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;
   if EventName = 'EVT_TOOL_ENTER' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;
  if EventName = 'EVT_TOOL_RCLICKED' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;
end;

function TWxToolBar.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxToolBar.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxToolBar.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxToolBar.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxToolBar';
  Result := wx_Class;
end;


procedure TWxToolBar.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxToolBar.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxToolBar.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDValue;
end;

procedure TWxToolBar.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

function TWxToolBar.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxToolBar.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxToolBar.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxToolBar.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

procedure TWxToolBar.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxToolBar.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxToolBar.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxToolBar.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxToolBar.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxToolBar.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxToolBar.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxToolBar.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxToolBar.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

procedure TWxToolBar.DummySizerNonInsertableInterfaceProcedure;
begin
end;

function TWxToolBar.GenerateLastCreationCode: string;
begin
  Result := '';
end;

procedure TWxToolBar.SetToolbarStyle(Value:TWxtbrStyleSet);
begin
    if (wxTB_TEXT in Value) or (wxTB_HORZ_TEXT in Value) then
      self.ShowCaptions:=true
    else
      self.ShowCaptions:=false;       
    FWx_ToolbarStyleSet:=Value;
end;



end.
