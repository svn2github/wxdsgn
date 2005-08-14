// $Id$


unit WxFontDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

type
  TWxFontDialog = class(TWxNonVisibleBaseComponent, IWxComponentInterface)
  private
    { Private declarations }
    FWx_Class: string;
    FWx_PropertyList: TStringList;

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
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxFontDialog]);
end;

{ Method to set variable and property values and create objects }
procedure TWxFontDialog.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Class    := 'wxFontDialog';
  Glyph.Handle := LoadBitmap(hInstance, 'TWxFontDialog');
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxFontDialog.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  Glyph.Assign(nil);
end; { of AutoDestroy }

constructor TWxFontDialog.Create(AOwner: TComponent);
begin
  { Call the Create method of the container's parent class       }
  inherited Create(AOwner);

  AutoInitialize;

  FWx_PropertyList.add('Name:Name');
  FWx_PropertyList.add('Wx_Class:Base Class');
end;

destructor TWxFontDialog.Destroy;
begin
  AutoDestroy;
  inherited Destroy;
end;

function TWxFontDialog.GenerateControlIDs: string;
begin
  Result := '';
end;

function TWxFontDialog.GenerateEnumControlIDs: string;
begin
  Result := '';
end;

function TWxFontDialog.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
end;

function TWxFontDialog.GenerateXRCControlCreation(IndentString: string): TStringList;
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

function TWxFontDialog.GenerateGUIControlCreation: string;
begin
  Result := '';
  Result := Format('%s =  new %s(this);', [self.Name, self.wx_Class]);
end;

function TWxFontDialog.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxFontDialog.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/fontdlg.h>';
end;

function TWxFontDialog.GenerateImageInclude: string;
begin

end;

function TWxFontDialog.GetEventList: TStringList;
begin
  Result := nil;
end;

function TWxFontDialog.GetIDName: string;
begin

end;

function TWxFontDialog.GetIDValue: longint;
begin
  Result := 0;
end;

function TWxFontDialog.GetParameterFromEventName(EventName: string): string;
begin

end;

function TWxFontDialog.GetStretchFactor: integer;
begin

end;

function TWxFontDialog.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxFontDialog.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxFontDialog.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxFontDialog';
  Result := wx_Class;
end;

procedure TWxFontDialog.SaveControlOrientation(ControlOrientation:
  TWxControlOrientation);
begin

end;

procedure TWxFontDialog.SetIDName(IDName: string);
begin

end;

procedure TWxFontDialog.SetIDValue(IDValue: longint);
begin

end;

procedure TWxFontDialog.SetStretchFactor(intValue: integer);
begin
end;

procedure TWxFontDialog.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxFontDialog.GetFGColor: string;
begin

end;

procedure TWxFontDialog.SetFGColor(strValue: string);
begin
end;

function TWxFontDialog.GetBGColor: string;
begin
end;

procedure TWxFontDialog.SetBGColor(strValue: string);
begin
end;

procedure TWxFontDialog.SetProxyFGColorString(Value: string);
begin
end;

procedure TWxFontDialog.SetProxyBGColorString(Value: string);
begin
end;

end.
