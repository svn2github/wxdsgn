unit WxSeparator;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
     Forms, Graphics, Stdctrls, Wxutils, ExtCtrls, WxSizerPanel,ComCtrls;


type

  TWxSeparator = class(TToolButton ,IWxComponentInterface,IWxToolBarInsertableInterface,IWxToolBarNonInsertableInterface)
    private
        FEVT_BUTTON : String;
        FEVT_UPDATE_UI : String;
        FWx_BKColor : TColor;
        FWx_Border : Integer;
        FWx_ButtonStyle : TWxBtnStyleSet;
        FWx_Class : String;
        FWx_ControlOrientation : TWxControlOrientation;
        FWx_Default : Boolean;
        FWx_Enabled : Boolean;
        FWx_EventList : TstringList;
        FWx_FGColor : TColor;
        FWx_GeneralStyle : TWxStdStyleSet;
        FWx_HelpText : String;
        FWx_Hidden : Boolean;
        FWx_HorizontalAlignment : TWxSizerHorizontalAlignment;
        FWx_IDName : String;
        FWx_IDValue : Longint;
        FWx_ProxyBGColorString : TWxColorString;
        FWx_ProxyFGColorString : TWxColorString;
        FWx_StretchFactor : Integer;
        FWx_ToolTip : String;
        FWx_Bitmap:TPicture;
        FWx_VerticalAlignment : TWxSizerVerticalAlignment;
        FWx_PropertyList : TStringList;
        FInvisibleBGColorString : String;
        FInvisibleFGColorString : String;

      { Private methods of TWxButton }

        procedure AutoInitialize;
        procedure AutoDestroy;
        procedure SetWx_EventList(Value : TstringList);

    protected
      { Protected fields of TWxButton }

      { Protected methods of TWxButton }

    public
      { Public fields and properties of TWxButton }
       defaultBGColor:TColor;	
       defaultFGColor:TColor;

      { Public methods of TWxButton }
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
        procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
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
        procedure SetButtonBitmap(value:TPicture);

    published
      { Published properties of TWxButton }
        property OnClick;
        property OnDblClick;
        property OnDragDrop;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
        property EVT_BUTTON : String read FEVT_BUTTON write FEVT_BUTTON;
        property EVT_UPDATE_UI : String read FEVT_UPDATE_UI write FEVT_UPDATE_UI;
        property Wx_BKColor : TColor read FWx_BKColor write FWx_BKColor;
        property Wx_Border : Integer read FWx_Border write FWx_Border default 5;
        property Wx_ButtonStyle : TWxBtnStyleSet read FWx_ButtonStyle write FWx_ButtonStyle;
        property Wx_Class : String read FWx_Class write FWx_Class;
        property Wx_ControlOrientation : TWxControlOrientation read FWx_ControlOrientation write FWx_ControlOrientation;
        property Wx_Default : Boolean read FWx_Default write FWx_Default;
        property Wx_Enabled : Boolean read FWx_Enabled write FWx_Enabled default True;
        property Wx_EventList : TstringList read FWx_EventList write SetWx_EventList;
        property Wx_FGColor : TColor read FWx_FGColor write FWx_FGColor;
        property Wx_GeneralStyle : TWxStdStyleSet read FWx_GeneralStyle write FWx_GeneralStyle;
        property Wx_HelpText : String read FWx_HelpText write FWx_HelpText;
        property Wx_Hidden : Boolean read FWx_Hidden write FWx_Hidden;
        property Wx_HorizontalAlignment : TWxSizerHorizontalAlignment read FWx_HorizontalAlignment write FWx_HorizontalAlignment default wxSZALIGN_CENTER_HORIZONTAL;
        property Wx_IDName : String read FWx_IDName write FWx_IDName;
        property Wx_IDValue : Longint read FWx_IDValue write FWx_IDValue default -1;
        property Wx_ProxyBGColorString : TWxColorString read FWx_ProxyBGColorString write FWx_ProxyBGColorString;
        property Wx_ProxyFGColorString : TWxColorString read FWx_ProxyFGColorString write FWx_ProxyFGColorString;
        property Wx_StretchFactor : Integer read FWx_StretchFactor write FWx_StretchFactor default 0;
	    property Wx_StrechFactor : Integer read FWx_StretchFactor write FWx_StretchFactor;
        property Wx_ToolTip : String read FWx_ToolTip write FWx_ToolTip;
        property Wx_VerticalAlignment : TWxSizerVerticalAlignment read FWx_VerticalAlignment write FWx_VerticalAlignment default wxSZALIGN_CENTER_VERTICAL;
        property InvisibleBGColorString:String read FInvisibleBGColorString write FInvisibleBGColorString;
        property InvisibleFGColorString:String read FInvisibleFGColorString write FInvisibleFGColorString;
        property Color;
        property Wx_BITMAP: TPicture read FWx_BITMAP write SetButtonBitmap;
  end;

procedure Register;

implementation

procedure Register;
begin
    RegisterComponents('wxWidgets', [TWxSeparator]);
end;

procedure TWxSeparator.AutoInitialize;
begin
     FWx_PropertyList := TStringList.Create;
     FWx_Border := 5;
     FWx_Class := 'wxToolBarTool';
     FWx_Enabled := True;
     FWx_EventList := TstringList.Create;
     FWx_HorizontalAlignment := wxSZALIGN_CENTER_HORIZONTAL;
     FWx_IDValue := -1;
     FWx_StretchFactor := 0;
     FWx_VerticalAlignment := wxSZALIGN_CENTER_VERTICAL;
     FWx_ProxyBGColorString := TWxColorString.Create;
     FWx_ProxyFGColorString := TWxColorString.Create;
     defaultBGColor:=self.color;
     defaultFGColor:=self.font.color;
     Caption:='';
     FWx_Bitmap:=TPicture.Create;
     self.Style:=tbsDivider	;
     self.Width:=5;
end; { of AutoInitialize }


procedure TWxSeparator.AutoDestroy;
begin
     FWx_PropertyList.Free;
     FWx_EventList.Free;
     FWx_Bitmap.Free;
     FWx_ProxyBGColorString.Free;
     FWx_ProxyFGColorString.Free;
end; { of AutoDestroy }


procedure TWxSeparator.SetWx_EventList(Value : TstringList);
begin
    FWx_EventList.Assign(Value);
end;

constructor TWxSeparator.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);

    AutoInitialize;
    self.Caption:='';

    //FWx_PropertyList.add('wx_Class:Base Class');
    //FWx_PropertyList.add('Wx_Hidden :Hidden');
    //FWx_PropertyList.add('Wx_Border : Border ');
    //FWx_PropertyList.add('Wx_HelpText :HelpText ');
    //FWx_PropertyList.add('Wx_IDName : IDName ');
    //FWx_PropertyList.add('Wx_IDValue : IDValue ');
    //FWx_PropertyList.add('Wx_ToolTip :ToolTip ');
    //FWx_PropertyList.add('Name : Name');
    //FWx_PropertyList.add('Left : Left');
    //FWx_PropertyList.add('Top : Top');
    FWx_PropertyList.add('Width : Width');
    //FWx_PropertyList.add('Height:Height');

    FWx_EventList.add('EVT_BUTTON:OnClick');
    FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxSeparator.Destroy;
begin
    AutoDestroy;
    inherited Destroy;
end;

procedure TWxSeparator.WMPaint(var Message: TWMPaint);
begin
    self.Caption:='';
    inherited;
end;


function TWxSeparator.GenerateEnumControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('%s = %d , ',[Wx_IDName,Wx_IDValue]);
end;

function TWxSeparator.GenerateControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('#define %s %d ',[Wx_IDName,Wx_IDValue]);
end;

function TWxSeparator.GenerateEventTableEntries(CurrClassName:String):String;
begin
     Result:='';
    if not IsControlWxToolBar(self.parent) then
        exit;
             
     if trim(EVT_BUTTON) <> '' then
     begin
          Result:=Format('EVT_BUTTON(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_BUTTON]) +'';
     end;

     if trim(EVT_UPDATE_UI) <> '' then
     begin
          Result:=Result+#13+Format('EVT_UPDATE_UI(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_UPDATE_UI]) +'';
     end;

end;

function TWxSeparator.GenerateGUIControlCreation:String;
var
     parentName:String;
begin
    Result:='';
    if not IsControlWxToolBar(self.parent) then
        exit;    
    parentName:=GetWxWidgetParent(self);
    Result:=parentName+'->AddSeparator();';
end;

function TWxSeparator.GenerateGUIControlDeclaration:String;
begin
     Result:='';
end;

function TWxSeparator.GenerateHeaderInclude:String;
begin
Result:='';
end;

function TWxSeparator.GenerateImageInclude: string;
begin
  if assigned(Wx_Bitmap) then
  begin
    if Wx_Bitmap.Bitmap.Handle <>0 then
    begin
        result :='#include "'+self.Name+'_XPM.xpm"';
    end;
  end;
end;

function TWxSeparator.GetEventList:TStringlist;
begin
     Result:=Wx_EventList;
end;

function TWxSeparator.GetIDName:String;
begin
     Result:=wx_IDName;
end;

function TWxSeparator.GetIDValue:LongInt;
begin
     Result:=wx_IDValue;
end;

function TWxSeparator.GetParameterFromEventName(EventName: string):String;
begin
if EventName = 'EVT_BUTTON' then
begin
 Result:='wxCommandEvent& event';
 exit;
end;
if EventName = 'EVT_UPDATE_UI' then
begin
 Result:='wxUpdateUIEvent& event';
 exit;
end;
end;

function TWxSeparator.GetPropertyList:TStringList;
begin
     Result:=FWx_PropertyList;
end;

function TWxSeparator.GetStretchFactor:Integer;
begin
    result:=Wx_StretchFactor;
end;

function TWxSeparator.GetTypeFromEventName(EventName: string):string;
begin

end;

function TWxSeparator.GetWxClassName:String;
begin
     if trim(wx_Class) = '' then
        wx_Class:='';
     Result:=wx_Class;
end;

procedure TWxSeparator.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
wx_ControlOrientation:=ControlOrientation;
end;

procedure TWxSeparator.SetIDName(IDName:String);
begin
     wx_IDName:=IDName;
end;

procedure TWxSeparator.SetIDValue(IDValue:longInt);
begin
     Wx_IDValue:=IDVAlue;
end;

procedure TWxSeparator.SetStretchFactor(intValue:Integer);
begin
    Wx_StretchFactor:=intValue;
end;

procedure TWxSeparator.SetWxClassName(wxClassName:String);
begin
     wx_Class:=wxClassName;
end;

function TWxSeparator.GetFGColor:string;
begin
   Result:=FInvisibleFGColorString;
end;

procedure TWxSeparator.SetFGColor(strValue:String);
begin
    FInvisibleFGColorString:=strValue;
   if IsDefaultColorStr(strValue) then
	self.Font.Color:=defaultFGColor
   else
	self.Font.Color:=GetColorFromString(strValue);
end;

function TWxSeparator.GetBGColor:string;
begin
   Result:=FInvisibleBGColorString;
end;

procedure TWxSeparator.SetBGColor(strValue:String);
begin
    FInvisibleBGColorString:=strValue;
   if IsDefaultColorStr(strValue) then
	self.Color:=defaultBGColor
   else
	self.Color:=GetColorFromString(strValue);
end;
procedure TWxSeparator.SetProxyFGColorString(value:String);
begin
    FInvisibleFGColorString:=value;
    self.Color:=GetColorFromString(value);
end;

procedure TWxSeparator.SetProxyBGColorString(value:String);
begin
   FInvisibleBGColorString:=value;
   self.Font.Color:=GetColorFromString(value);
end;

procedure TWxSeparator.SetButtonBitmap(value:TPicture);
begin
    if not assigned(value) then
        exit;
    //self.Glyph.Assign(value.Bitmap);
end;

end.
