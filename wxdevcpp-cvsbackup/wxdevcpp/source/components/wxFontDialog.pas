unit WxFontDialog;

interface

uses
  Windows, Messages, SysUtils, Classes,wxUtils,WxNonVisibleBaseComponent;

type
  TWxFontDialog = class(TWxNonVisibleBaseComponent,IWxComponentInterface)
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
  RegisterComponents('wxWidgets', [TWxFontDialog]);
end;

{ Method to set variable and property values and create objects }
procedure TWxFontDialog.AutoInitialize;
begin
     FWx_PropertyList := TStringList.Create;
     FWx_Class := 'wxFontDialog';
     Glyph.Handle:=LoadBitmap(hInstance, 'TWxFontDialog');
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxFontDialog.AutoDestroy;
begin
     FWx_PropertyList.Free;
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

function TWxFontDialog.GenerateControlIDs:String;
begin
     Result:='';
end;

function TWxFontDialog.GenerateEnumControlIDs:String;
begin
     Result:='';
end;

function TWxFontDialog.GenerateEventTableEntries(CurrClassName:String):String;
begin
     Result:='';
end;

function TWxFontDialog.GenerateGUIControlCreation:String;
begin
     Result:='';
    Result:=Format('%s =  new %s(this);',[self.Name,self.wx_Class] );
end;

function TWxFontDialog.GenerateGUIControlDeclaration:String;
begin
     Result:='';
     Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TWxFontDialog.GenerateHeaderInclude:String;
begin
     Result:='';
     Result:='#include <wx/fontdlg.h>';
end;

function TWxFontDialog.GenerateImageInclude: string;
begin

end;

function TWxFontDialog.GetEventList:TStringlist;
begin
Result:=nil;
end;

function TWxFontDialog.GetIDName:String;
begin

end;

function TWxFontDialog.GetIDValue:LongInt;
begin
Result:=0;
end;

function TWxFontDialog.GetParameterFromEventName(EventName: string):String;
begin

end;

function TWxFontDialog.GetStretchFactor:Integer;
begin
//
end;

function TWxFontDialog.GetPropertyList:TStringList;
begin
     Result:=FWx_PropertyList;
end;

function TWxFontDialog.GetTypeFromEventName(EventName: string):string;
begin

end;

function TWxFontDialog.GetWxClassName:String;
begin
     if trim(wx_Class) = '' then
        wx_Class:='wxFontDialog';
     Result:=wx_Class;
end;

procedure TWxFontDialog.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
    //
end;

procedure TWxFontDialog.SetIDName(IDName:String);
begin

end;

procedure TWxFontDialog.SetIDValue(IDValue:longInt);
begin

end;

procedure TWxFontDialog.SetStretchFactor(intValue:Integer);
begin
end;

procedure TWxFontDialog.SetWxClassName(wxClassName:String);
begin
     wx_Class:=wxClassName;
end;

function TWxFontDialog.GetFGColor:string;
begin

end;

procedure TWxFontDialog.SetFGColor(strValue:String);
begin
end;
    
function TWxFontDialog.GetBGColor:string;
begin
end;

procedure TWxFontDialog.SetBGColor(strValue:String);
begin
end;
procedure TWxFontDialog.SetProxyFGColorString(value:String);
begin
end;

procedure TWxFontDialog.SetProxyBGColorString(value:String);
begin
end;

end.

