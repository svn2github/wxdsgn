// $Id$
//

unit wxColourDialog;

interface

uses
  Windows, Messages, SysUtils, Classes,wxUtils,WxNonVisibleBaseComponent;

type
  TWxColourDialog = class(TWxNonVisibleBaseComponent,IWxComponentInterface)
  private
    { Private declarations }
        FWx_Class : String;
        FWx_PropertyList : TStringList;
        procedure AutoInitialize;
        procedure AutoDestroy;

  protected

  public
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
        function GenerateControlIDs:String;
        function GenerateEnumControlIDs:String;
        function GenerateEventTableEntries(CurrClassName:String):String;
        function GenerateGUIControlCreation:String;
        function GenerateGUIControlDeclaration:String;
        function GenerateHeaderInclude:String;
        function GenerateImageInclude: string;
        function GetEventList:TStringlist;
        function GetIDName:String;
        function GetIDValue:LongInt;
        function GetParameterFromEventName(EventName: string):String;
        function GetPropertyList:TStringList;
        function GetStretchFactor:Integer;
        function GetTypeFromEventName(EventName: string):string;
        function GetWxClassName:String;
        procedure SaveControlOrientation(ControlOrientation:TWxControlOrientation);
        procedure SetIDName(IDName:String);
        procedure SetIDValue(IDValue:longInt);
        procedure SetStretchFactor(intValue:Integer);
        procedure SetWxClassName(wxClassName:String);
        function GetFGColor:string;
        procedure SetFGColor(strValue:String);
        function GetBGColor:string;
        procedure SetBGColor(strValue:String);
        procedure SetProxyFGColorString(value:String);
        procedure SetProxyBGColorString(value:String);
  published
    { Published declarations }
        property Wx_Class : String read FWx_Class write FWx_Class;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxColourDialog]);
end;

{ Method to set variable and property values and create objects }
procedure TWxColourDialog.AutoInitialize;
begin
     FWx_PropertyList := TStringList.Create;
     FWx_Class := 'wxColourDialog';
     Glyph.Handle:=LoadBitmap(hInstance, 'TWxColourDialog');
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxColourDialog.AutoDestroy;
begin
     FWx_PropertyList.Free;
end; { of AutoDestroy }

constructor TWxColourDialog.Create(AOwner: TComponent);
begin
     inherited Create(AOwner);
     AutoInitialize;
     FWx_PropertyList.add('Name:Name');
     FWx_PropertyList.add('Wx_Class:Base Class');
end;

destructor TWxColourDialog.Destroy;
begin
     AutoDestroy;
     inherited Destroy;
end;

function TWxColourDialog.GenerateControlIDs:String;
begin
     Result:='';
end;

function TWxColourDialog.GenerateEnumControlIDs:String;
begin
     Result:='';
end;

function TWxColourDialog.GenerateEventTableEntries(CurrClassName:String):String;
begin
     Result:='';
end;

function TWxColourDialog.GenerateGUIControlCreation:String;
begin
     Result:='';
    Result:=Format('%s =  new %s(this);',[self.Name,self.wx_Class] );
end;

function TWxColourDialog.GenerateGUIControlDeclaration:String;
begin
     Result:='';
     Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TWxColourDialog.GenerateHeaderInclude:String;
begin
     Result:='';
     Result:='#include <wx/colordlg.h>';
end;

function TWxColourDialog.GenerateImageInclude: string;
begin

end;

function TWxColourDialog.GetEventList:TStringlist;
begin
Result:=nil;
end;

function TWxColourDialog.GetIDName:String;
begin

end;

function TWxColourDialog.GetIDValue:LongInt;
begin
Result:=0;
end;

function TWxColourDialog.GetParameterFromEventName(EventName: string):String;
begin

end;

function TWxColourDialog.GetStretchFactor:Integer;
begin
//
end;

function TWxColourDialog.GetPropertyList:TStringList;
begin
     Result:=FWx_PropertyList;
end;

function TWxColourDialog.GetTypeFromEventName(EventName: string):string;
begin

end;

function TWxColourDialog.GetWxClassName:String;
begin
     if trim(wx_Class) = '' then
        wx_Class:='wxColourDialog';
     Result:=wx_Class;
end;

procedure TWxColourDialog.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
    //
end;

procedure TWxColourDialog.SetIDName(IDName:String);
begin

end;

procedure TWxColourDialog.SetIDValue(IDValue:longInt);
begin

end;

procedure TWxColourDialog.SetStretchFactor(intValue:Integer);
begin
end;

procedure TWxColourDialog.SetWxClassName(wxClassName:String);
begin
     wx_Class:=wxClassName;
end;

function TWxColourDialog.GetFGColor:string;
begin

end;

procedure TWxColourDialog.SetFGColor(strValue:String);
begin
end;
    
function TWxColourDialog.GetBGColor:string;
begin
end;

procedure TWxColourDialog.SetBGColor(strValue:String);
begin
end;
procedure TWxColourDialog.SetProxyFGColorString(value:String);
begin
end;

procedure TWxColourDialog.SetProxyBGColorString(value:String);
begin
end;

end.
 
