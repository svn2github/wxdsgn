unit WxToolButton;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
     Forms, Graphics, Stdctrls, Wxutils, ExtCtrls, WxSizerPanel,ComCtrls,Buttons;


type

  TWxToolButton = class(TBitBtn ,IWxComponentInterface,IWxToolBarInsertableInterface,IWxToolBarNonInsertableInterface)
    private
        FEVT_MENU : String;
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
        FWx_DISABLE_BITMAP:TPicture;
        FWx_VerticalAlignment : TWxSizerVerticalAlignment;
        FWx_PropertyList : TStringList;
        FInvisibleBGColorString : String;
        FInvisibleFGColorString : String;
        FToolKind:TWxToolbottonItemStyleItem;
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
        procedure SetDisableBitmap(value:TPicture);
    published
      { Published properties of TWxButton }
        property OnClick;
        property OnDblClick;
        property OnDragDrop;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
        property EVT_MENU : String read FEVT_MENU write FEVT_MENU;
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
        property ToolKind:TWxToolbottonItemStyleItem read FToolKind write FToolKind default wxITEM_NORMAL;
        property Color;
        property Wx_BITMAP: TPicture read FWx_BITMAP write SetButtonBitmap;
        property Wx_DISABLE_BITMAP: TPicture read FWx_DISABLE_BITMAP write SetDisableBitmap;

  end;

procedure Register;

implementation

procedure Register;
begin
    RegisterComponents('wxWidgets', [TWxToolButton]);
end;

procedure TWxToolButton.AutoInitialize;
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
     FWx_DISABLE_BITMAP:=TPicture.Create;
     self.width :=24;
     self.Height :=24;
     self.Layout:=blGlyphTop;
end; { of AutoInitialize }


procedure TWxToolButton.AutoDestroy;
begin
     FWx_PropertyList.Free;
     FWx_EventList.Free;
     FWx_Bitmap.Free;
     FWx_DISABLE_BITMAP.Free;
     FWx_ProxyBGColorString.Free;
     FWx_ProxyFGColorString.Free;
end; { of AutoDestroy }


procedure TWxToolButton.SetWx_EventList(Value : TstringList);
begin
    FWx_EventList.Assign(Value);
end;

constructor TWxToolButton.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);

    AutoInitialize;
    self.Caption:='';

    //FWx_PropertyList.add('wx_Class:Base Class');
    //FWx_PropertyList.add('Wx_Hidden :Hidden');
    //FWx_PropertyList.add('Wx_Border : Border ');
    FWx_PropertyList.add('Wx_HelpText :HelpText ');
    FWx_PropertyList.add('Wx_IDName : IDName ');
    FWx_PropertyList.add('Wx_IDValue : IDValue ');
    FWx_PropertyList.add('Wx_ToolTip :ToolTip ');
    //FWx_PropertyList.add('Name : Name');
    FWx_PropertyList.add('ToolKind : ToolKind');
    FWx_PropertyList.add('Caption : Label');
    //FWx_PropertyList.add('Width : Width');
    //FWx_PropertyList.add('Height:Height');

    FWx_PropertyList.add('Wx_Bitmap:Active Bitmap');
    //FWx_PropertyList.add('Wx_DISABLE_BITMAP:Disable Bitmap');

    FWx_EventList.add('EVT_MENU:OnClick');
    FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxToolButton.Destroy;
begin
    AutoDestroy;
    inherited Destroy;
end;

procedure TWxToolButton.WMPaint(var Message: TWMPaint);
begin
    inherited;
end;

function TWxToolButton.GenerateEnumControlIDs:String;
begin
     Result:='';
    if not IsControlWxToolBar(self.parent) then
        exit;

     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('%s = %d , ',[Wx_IDName,Wx_IDValue]);
end;

function TWxToolButton.GenerateControlIDs:String;
begin
     Result:='';
    if not IsControlWxToolBar(self.parent) then
        exit;

     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('#define %s  %d ',[Wx_IDName,Wx_IDValue]);
end;

function TWxToolButton.GenerateEventTableEntries(CurrClassName:String):String;
begin
     Result:='';

    if not IsControlWxToolBar(self.parent) then
        exit;

     if trim(EVT_MENU) <> '' then
     begin
          Result:=Format('EVT_MENU(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_MENU]) +'';
     end;

     if trim(EVT_UPDATE_UI) <> '' then
     begin
          Result:=Result+#13+Format('EVT_UPDATE_UI(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_UPDATE_UI]) +'';
     end;
end;

function TWxToolButton.GenerateGUIControlCreation:String;
var
     parentName:String;
     strFirstBitmap,strSecondBitmap:String;
begin
    Result:='';
    parentName:=GetWxWidgetParent(self);

    if not IsControlWxToolBar(self.parent) then
        exit;


    strFirstBitmap:='wxBitmap '+self.Name+'_BITMAP'+' (wxNullBitmap);';
    strSecondBitmap:='wxBitmap '+self.Name+'_DISABLE_BITMAP'+' (wxNullBitmap);';

    //Result:='wxBitmap '+self.Name+'_BITMAP'+' (wxNullBitmap);';

    if assigned(Wx_Bitmap) then
    begin
        if Wx_Bitmap.Bitmap.Handle <>0 then
            strFirstBitmap:='wxBitmap '+self.Name+'_BITMAP'+' ('+self.Name+'_XPM'+');';
    end;

    if assigned(Wx_DISABLE_BITMAP) then
    begin
        if Wx_DISABLE_BITMAP.Bitmap.Handle <>0 then
            strSecondBitmap:='wxBitmap '+self.Name+'_DISABLE_BITMAP'+' ('+self.Name+'_DISABLE_BITMAP_XPM'+');';
    end;

    Result:=strFirstBitmap+#13+strSecondBitmap;
    Result:=Result+#13+Format('%s->AddTool(%s,_("%s"),%s , %s, %s,_("%s"),_("%s"));',[parentName,GetWxIDString(self.Wx_IDName,self.Wx_IDValue),self.Caption,self.Name+'_BITMAP',self.Name+'_DISABLE_BITMAP',GetToolButtonKindAsText(ToolKind),self.Wx_ToolTip,self.Wx_HelpText] );

end;

function TWxToolButton.GenerateGUIControlDeclaration:String;
begin
    Result:='';
end;

function TWxToolButton.GenerateHeaderInclude:String;
begin
    Result:='';
end;

function TWxToolButton.GenerateImageInclude: string;
begin
  if assigned(Wx_Bitmap) then
  begin
    if Wx_Bitmap.Bitmap.Handle <>0 then
    begin
        result :='#include "'+self.Name+'_XPM.xpm"';
    end;
  end;
end;

function TWxToolButton.GetEventList:TStringlist;
begin
     Result:=Wx_EventList;
end;

function TWxToolButton.GetIDName:String;
begin
     Result:=wx_IDName;
end;

function TWxToolButton.GetIDValue:LongInt;
begin
     Result:=wx_IDValue;
end;

function TWxToolButton.GetParameterFromEventName(EventName: string):String;
begin
if EventName = 'EVT_MENU' then
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

function TWxToolButton.GetPropertyList:TStringList;
begin
     Result:=FWx_PropertyList;
end;

function TWxToolButton.GetStretchFactor:Integer;
begin
    result:=Wx_StretchFactor;
end;

function TWxToolButton.GetTypeFromEventName(EventName: string):string;
begin

end;

function TWxToolButton.GetWxClassName:String;
begin
     if trim(wx_Class) = '' then
        wx_Class:='';
     Result:=wx_Class;
end;

procedure TWxToolButton.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
wx_ControlOrientation:=ControlOrientation;
end;

procedure TWxToolButton.SetIDName(IDName:String);
begin
     wx_IDName:=IDName;
end;

procedure TWxToolButton.SetIDValue(IDValue:longInt);
begin
     Wx_IDValue:=IDVAlue;
end;

procedure TWxToolButton.SetStretchFactor(intValue:Integer);
begin
    Wx_StretchFactor:=intValue;
end;

procedure TWxToolButton.SetWxClassName(wxClassName:String);
begin
     wx_Class:=wxClassName;
end;

function TWxToolButton.GetFGColor:string;
begin
   Result:=FInvisibleFGColorString;
end;

procedure TWxToolButton.SetFGColor(strValue:String);
begin
    FInvisibleFGColorString:=strValue;
   if IsDefaultColorStr(strValue) then
	self.Font.Color:=defaultFGColor
   else
	self.Font.Color:=GetColorFromString(strValue);
end;

function TWxToolButton.GetBGColor:string;
begin
   Result:=FInvisibleBGColorString;
end;

procedure TWxToolButton.SetBGColor(strValue:String);
begin
    FInvisibleBGColorString:=strValue;
   if IsDefaultColorStr(strValue) then
	self.Color:=defaultBGColor
   else
	self.Color:=GetColorFromString(strValue);
end;
procedure TWxToolButton.SetProxyFGColorString(value:String);
begin
    FInvisibleFGColorString:=value;
    self.Color:=GetColorFromString(value);
end;

procedure TWxToolButton.SetProxyBGColorString(value:String);
begin
   FInvisibleBGColorString:=value;
   self.Font.Color:=GetColorFromString(value);
end;

procedure TWxToolButton.SetButtonBitmap(value:TPicture);
begin
    if not assigned(value) then
        exit;
    self.Glyph.Assign(value.Bitmap);
end;

procedure TWxToolButton.SetDisableBitmap(value:TPicture);
begin
    if not assigned(value) then
        exit;
    FWx_DISABLE_BITMAP.Assign(value);
end;


end.
