unit WxOpenDialog;

interface

uses
  Windows, Messages, SysUtils, Classes,wxUtils,WxNonVisibleBaseComponent;

type
  TWxOpenFileDialog = class(TWxNonVisibleBaseComponent,IWxComponentInterface)
  private
    { Private declarations }
        FWx_Class : String;
        FWx_Enabled : Boolean;
        FWx_Hidden : Boolean;
        FWx_IDName : String;
        FWx_IDValue : Longint;
        FWx_PropertyList : TStringList;
        FWx_Message: String;
        FWx_Extensions: String;
        FWx_DefaultFile: String;
        FWx_DefaultDir: String;

        procedure AutoInitialize;
        procedure AutoDestroy;

  protected

  public
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
        function GenerateControlIDs:String;
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
        property Wx_Enabled : Boolean read FWx_Enabled write FWx_Enabled default True;
        property Wx_Hidden : Boolean read FWx_Hidden write FWx_Hidden default False;
        property Wx_IDName : String read FWx_IDName write FWx_IDName;
        property Wx_IDValue : Longint read FWx_IDValue write FWx_IDValue;
        property Wx_Message: String read FWx_Message write FWx_Message;
        property Wx_Extensions: String read FWx_Extensions write FWx_Extensions;
        property Wx_DefaultFile: String read FWx_DefaultFile write FWx_DefaultFile;
        property Wx_DefaultDir: String read FWx_DefaultDir write FWx_DefaultDir;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxOpenDialog]);
end;

{ Method to set variable and property values and create objects }
procedure TWxOpenFileDialog.AutoInitialize;
begin
     FWx_PropertyList := TStringList.Create;
     FWx_Class := 'wxFileDialog';
     FWx_Enabled := True;
     FWx_Hidden := False;
     Glyph.Handle:=LoadBitmap(hInstance, 'TWXOPENFILEDIALOG')
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxOpenFileDialog.AutoDestroy;
begin
     FWx_PropertyList.Free;
    FWx_MenuItems.Free;
end; { of AutoDestroy }

constructor TWxOpenFileDialog.Create(AOwner: TComponent);
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
     { Code to perform other tasks when the component is created }
     FWx_PropertyList.add('Wx_DefaultDir:Default Dir');
     FWx_PropertyList.add('Wx_DefaultFile:Default File');
     FWx_PropertyList.add('Wx_Extensions:Extensions');
     FWx_PropertyList.add('Wx_Message:Message');
     FWx_PropertyList.add('Name:Name');
     FWx_PropertyList.add('Wx_Class:Base Class');
end;

destructor TWxOpenFileDialog.Destroy;
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

function TWxOpenFileDialog.GenerateControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('#define %s %d ',[Wx_IDName,Wx_IDValue]);
end;

function TWxOpenFileDialog.GenerateEventTableEntries(CurrClassName:String):String;
begin
     Result:='';
end;

function TWxOpenFileDialog.GenerateGUIControlCreation:String;
var
     strType:String;
begin
     Result:='';
    strType:='wxOPEN';
    Result:=Format('%s =  new %s(this, "%s" , "%s" , "%s" , "%s", %s);',[self.Name,self.wx_Class,wx_Message,wx_DefaultDir,wx_DefaultFile,wx_Extensions,strType+strStyle] );
end;

function TWxOpenFileDialog.GenerateGUIControlDeclaration:String;
begin
     Result:='';
     Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TWxOpenFileDialog.GenerateHeaderInclude:String;
begin
     Result:='';
     Result:='#include <wx/menu.h>';
end;

function TWxOpenFileDialog.GenerateImageInclude: string;
begin

end;

function TWxOpenFileDialog.GetEventList:TStringlist;
begin
Result:=nil;
end;

function TWxOpenFileDialog.GetIDName:String;
begin
     Result:=wx_IDName;
end;

function TWxOpenFileDialog.GetIDValue:LongInt;
begin
     Result:=wx_IDValue;
end;

function TWxOpenFileDialog.GetParameterFromEventName(EventName: string):String;
begin

end;

function TWxOpenFileDialog.GetStretchFactor:Integer;
begin
//
end;

function TWxOpenFileDialog.GetPropertyList:TStringList;
begin
     Result:=FWx_PropertyList;
end;

function TWxOpenFileDialog.GetTypeFromEventName(EventName: string):string;
begin

end;

function TWxOpenFileDialog.GetWxClassName:String;
begin
     Result:=wx_Class;
end;

procedure TWxOpenFileDialog.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
    //
end;

procedure TWxOpenFileDialog.SetIDName(IDName:String);
begin
     wx_IDName:=IDName;
end;

procedure TWxOpenFileDialog.SetIDValue(IDValue:longInt);
begin
     Wx_IDValue:=IDVAlue;
end;

procedure TWxOpenFileDialog.SetStretchFactor(intValue:Integer);
begin
end;

procedure TWxOpenFileDialog.SetWxClassName(wxClassName:String);
begin
     wx_Class:=wxClassName;
end;

function TWxOpenFileDialog.GetFGColor:string;
begin

end;

procedure TWxOpenFileDialog.SetFGColor(strValue:String);
begin
end;
    
function TWxOpenFileDialog.GetBGColor:string;
begin
end;

procedure TWxOpenFileDialog.SetBGColor(strValue:String);
begin
end;
procedure TWxOpenFileDialog.SetProxyFGColorString(value:String);
begin
end;

procedure TWxOpenFileDialog.SetProxyBGColorString(value:String);
begin
end;

end.
 