// $Id$


unit wxProgressDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

type
  TWxProgressDialog = class(TWxNonVisibleBaseComponent, IWxComponentInterface)
  private
    { Private declarations }
    FWx_Class: string;
    FWx_PropertyList: TStringList;
    FWx_ProgressDialogStyle: TWxProgressDialogStyleSet;
    FWx_Title: string;
    FWX_MAXValue: integer;
    FWX_AutoShow: boolean;
    FWx_Message: string;
    FWx_Comments: TStrings;

    procedure AutoInitialize;
    procedure AutoDestroy;

  protected

  public
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
    function GetStretchFactor: integer;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: longint);
    procedure SetStretchFactor(intValue: integer);
    procedure SetWxClassName(wxClassName: string);
    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);
    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);
  published
    { Published declarations }
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_Message: string Read FWx_Message Write FWx_Message;
    property Wx_Title: string Read FWx_Title Write FWx_Title;
    property WX_MAXValue: integer Read FWX_MAXValue Write FWX_MAXValue default 100;
    property WX_AutoShow: boolean Read FWX_AutoShow Write FWX_AutoShow default False;

    property Wx_ProgressDialogStyle: TWxProgressDialogStyleSet
      Read FWx_ProgressDialogStyle Write FWx_ProgressDialogStyle;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxProgressDialog]);
end;

procedure TWxProgressDialog.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Class    := 'wxProgressDialog';
  Glyph.Handle := LoadBitmap(hInstance, 'TWxProgressDialog');
  FWX_MAXValue := 100;
  FWX_AutoShow := False;
  FWx_ProgressDialogStyle := [wxPD_AUTO_HIDE, wxPD_APP_MODAL];
  FWx_Comments := TStringList.Create;

end; { of AutoInitialize }

procedure TWxProgressDialog.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_Comments.Destroy;
  Glyph.Assign(nil);
end; { of AutoDestroy }

constructor TWxProgressDialog.Create(AOwner: TComponent);
begin
  { Call the Create method of the container's parent class       }
  inherited Create(AOwner);

  AutoInitialize;
  { Code to perform other tasks when the component is created }
  FWx_PropertyList.add('Wx_ProgressDialogStyle:Progress Dialog Style');
  FWx_PropertyList.add('wxPD_APP_MODAL:wxPD_APP_MODAL');
  FWx_PropertyList.add('wxPD_SMOOTH:wxPD_SMOOTH');
  FWx_PropertyList.add('wxPD_CAN_SKIP:wxPD_CAN_SKIP');
  FWx_PropertyList.add('wxPD_AUTO_HIDE:wxPD_AUTO_HIDE');
  FWx_PropertyList.add('wxPD_CAN_ABORT:wxPD_CAN_ABORT');
  FWx_PropertyList.add('wxPD_ELAPSED_TIME:wxPD_ELAPSED_TIME');
  FWx_PropertyList.add('wxPD_ESTIMATED_TIME:wxPD_ESTIMATED_TIME');
  FWx_PropertyList.add('wxPD_REMAINING_TIME:wxPD_REMAINING_TIME');
  FWx_PropertyList.add('Wx_Message:Message');
  FWx_PropertyList.add('Wx_Title:Title');
  FWx_PropertyList.add('WX_MAXValue:MAX Value');
  FWx_PropertyList.add('WX_AutoShow:Auto Show');
  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Wx_Class:Base Class');
  FWx_PropertyList.add('Wx_Comments:Comments');

end;

destructor TWxProgressDialog.Destroy;
begin
  AutoDestroy;
  inherited Destroy;
end;

function TWxProgressDialog.GenerateControlIDs: string;
begin
  Result := '';
end;

function TWxProgressDialog.GenerateEnumControlIDs: string;
begin
  Result := '';
end;

function TWxProgressDialog.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
end;

function TWxProgressDialog.GenerateGUIControlCreation: string;
begin
  Result := '';
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s =  new %s( %s, %s, %d , this  %s);',
    [self.Name, self.wx_Class, GetCppString(self.Wx_Title), self.Wx_Message,
    Wx_MaxValue, GetProgressDialogStyleString(Wx_ProgressDialogStyle)]);

  if not WX_AutoShow then
    Result := Result + #13 + self.Name + '->Show(false);'
end;

function TWxProgressDialog.GenerateXRCControlCreation(IndentString: string): TStringList;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + '</object>');
  except
    Result.Free;
    raise;
  end;

end;

function TWxProgressDialog.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxProgressDialog.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/progdlg.h>';
end;

function TWxProgressDialog.GenerateImageInclude: string;
begin

end;

function TWxProgressDialog.GetEventList: TStringList;
begin
  Result := nil;
end;

function TWxProgressDialog.GetIDName: string;
begin

end;

function TWxProgressDialog.GetIDValue: longint;
begin
  Result := 0;
end;

function TWxProgressDialog.GetParameterFromEventName(EventName: string): string;
begin

end;

function TWxProgressDialog.GetStretchFactor: integer;
begin
    Result := 1;
end;

function TWxProgressDialog.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxProgressDialog.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxProgressDialog.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxProgressDialog';
  Result := wx_Class;
end;

procedure TWxProgressDialog.SaveControlOrientation(
  ControlOrientation: TWxControlOrientation);
begin

end;

procedure TWxProgressDialog.SetIDName(IDName: string);
begin

end;

procedure TWxProgressDialog.SetIDValue(IDValue: longint);
begin

end;

procedure TWxProgressDialog.SetStretchFactor(intValue: integer);
begin
end;

procedure TWxProgressDialog.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxProgressDialog.GetFGColor: string;
begin

end;

procedure TWxProgressDialog.SetFGColor(strValue: string);
begin
end;

function TWxProgressDialog.GetBGColor: string;
begin
end;

procedure TWxProgressDialog.SetBGColor(strValue: string);
begin
end;

procedure TWxProgressDialog.SetProxyFGColorString(Value: string);
begin
end;

procedure TWxProgressDialog.SetProxyBGColorString(Value: string);
begin
end;

end.
 