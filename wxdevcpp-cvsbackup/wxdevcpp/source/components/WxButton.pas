unit WxButton;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, 
     Forms, Graphics, Stdctrls, Wxutils, ExtCtrls, WxSizerPanel,WxToolBar;

type
  TDrawButtonEvent = procedure(Control: TWinControl;
    Rect: TRect; State: TOwnerDrawState) of object;
    
  TWxButton = class(TButton,IWxComponentInterface,IWxToolBarInsertableInterface,IWxToolBarNonInsertableInterface)
    private
        FCanvas: TCanvas;
        FOnDrawButton: TDrawButtonEvent;    
      { Private fields of TWxButton }

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
        FWx_VerticalAlignment : TWxSizerVerticalAlignment;
        FWx_PropertyList : TStringList;
        FInvisibleBGColorString : String;
        FInvisibleFGColorString : String;        

        procedure AutoInitialize;
        procedure AutoDestroy;

    protected
      { Protected fields of TWxButton }

      { Protected methods of TWxButton }
        procedure Click; override;

    public
      { Public fields and properties of TWxButton }
       defaultBGColor:TColor;
       defaultFGColor:TColor;
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
  public
    property Canvas: TCanvas read FCanvas;

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
        property Wx_EventList : TstringList read FWx_EventList write FWx_EventList;
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
        property Wx_VerticalAlignment : TWxSizerVerticalAlignment
             read FWx_VerticalAlignment write FWx_VerticalAlignment
             default wxSZALIGN_CENTER_VERTICAL;
        property InvisibleBGColorString:String read FInvisibleBGColorString write FInvisibleBGColorString;
        property InvisibleFGColorString:String read FInvisibleFGColorString write FInvisibleFGColorString;

        property OnDrawButton: TDrawButtonEvent read FOnDrawButton write FOnDrawButton;
        property Color;
  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxButton with wxWidgets as its
       default page on the Delphi component palette }
     RegisterComponents('wxWidgets', [TWxButton]);
end;

{ Method to set variable and property values and create objects }
procedure TWxButton.AutoInitialize;
begin
     FWx_PropertyList := TStringList.Create;
     FWx_Border := 5;
     FWx_Class := 'wxButton';
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
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxButton.AutoDestroy;
begin
     FWx_PropertyList.Free;
     FWx_EventList.Free;
end; { of AutoDestroy }

{ Override OnClick handler from TButton,IWxComponentInterface }
procedure TWxButton.Click;
begin
     inherited Click;
end;

constructor TWxButton.Create(AOwner: TComponent);
begin
     inherited Create(AOwner);
    FCanvas := TCanvas.Create;
    AutoInitialize;

    { Code to perform other tasks when the component is created }

    FWx_PropertyList.add('wx_Class:Base Class');
    FWx_PropertyList.add('Wx_Hidden :Hidden');
    FWx_PropertyList.add('Wx_Border : Border ');
     FWx_PropertyList.add('Wx_HelpText :HelpText ');
     FWx_PropertyList.add('Wx_IDName : IDName ');
     FWx_PropertyList.add('Wx_IDValue : IDValue ');
     FWx_PropertyList.add('Wx_ToolTip :ToolTip ');
     FWx_PropertyList.add('Caption : Label');
     FWx_PropertyList.add('Name : Name');
     FWx_PropertyList.add('Left : Left');
     FWx_PropertyList.add('Top : Top');
     FWx_PropertyList.add('Width : Width');
     FWx_PropertyList.add('Height:Height');
     FWx_PropertyList.add('Wx_ProxyBGColorString:Background Color');
     FWx_PropertyList.add('Wx_ProxyFGColorString:Foreground Color');
     FWx_PropertyList.add('Wx_GeneralStyle: General Styles');
     FWx_PropertyList.Add('wxSIMPLE_BORDER:wxSIMPLE_BORDER');
     FWx_PropertyList.Add('wxDOUBLE_BORDER:wxDOUBLE_BORDER');
     FWx_PropertyList.Add('wxSUNKEN_BORDER:wxSUNKEN_BORDER');
     FWx_PropertyList.Add('wxRAISED_BORDER:wxRAISED_BORDER');
     FWx_PropertyList.Add('wxSTATIC_BORDER:wxSTATIC_BORDER');
     FWx_PropertyList.Add('wxTRANSPARENT_WINDOW:wxTRANSPARENT_WINDOW');
     FWx_PropertyList.Add('wxNO_3D:wxNO_3D');
     FWx_PropertyList.Add('wxTAB_TRAVERSAL:wxTAB_TRAVERSAL');
     FWx_PropertyList.Add('wxWANTS_CHARS:wxWANTS_CHARS');
     FWx_PropertyList.Add('wxNO_FULL_REPAINT_ON_RESIZE:wxNO_FULL_REPAINT_ON_RESIZE');
     FWx_PropertyList.Add('wxVSCROLL:wxVSCROLL');
     FWx_PropertyList.Add('wxHSCROLL:wxHSCROLL');
     FWx_PropertyList.Add('wxCLIP_CHILDREN:wxCLIP_CHILDREN');
     FWx_PropertyList.add('Font : Font');
     FWx_PropertyList.add('Wx_ButtonStyle:Button Style');
     FWx_PropertyList.add('wxBU_LEFT:wxBU_LEFT');
     FWx_PropertyList.add('wxBU_TOP:wxBU_TOP');
     FWx_PropertyList.add('wxBU_RIGHT:wxBU_RIGHT');
     FWx_PropertyList.add('wxBU_BOTTOM:wxBU_BOTTOM');
     FWx_PropertyList.add('wxBU_EXACTFIT:wxBU_EXACTFIT');
     FWx_PropertyList.add('Wx_HorizontalAlignment : HorizontalAlignment');
     FWx_PropertyList.add('Wx_VerticalAlignment   : VerticalAlignment');
     FWx_PropertyList.add('Wx_StretchFactor   : StretchFactor');
     FWx_PropertyList.add('Default   : Default');

     FWx_EventList.add('EVT_BUTTON:OnClick');
     FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxButton.Destroy;
begin
     AutoDestroy;
     inherited Destroy;
     FCanvas.Free;
end;


function TWxButton.GenerateEnumControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('%s = %d , ',[Wx_IDName,Wx_IDValue]);
end;

function TWxButton.GenerateControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('#define %s %d ',[Wx_IDName,Wx_IDValue]);
end;


function TWxButton.GenerateEventTableEntries(CurrClassName:String):String;
begin
     Result:='';
     if trim(EVT_BUTTON) <> '' then
     begin
          Result:=Format('EVT_BUTTON(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_BUTTON]) +'';
     end;

     if trim(EVT_UPDATE_UI) <> '' then
     begin
          Result:=Result+#13+Format('EVT_UPDATE_UI(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_UPDATE_UI]) +'';
     end;

end;

function TWxButton.GenerateGUIControlCreation:String;
var
     strColorStr:String;
     strStyle:String;
     parentName,strAlignment:String;
begin
    Result:='';
    strStyle:=GetButtonSpecificStyle(self.Wx_GeneralStyle,Wx_ButtonStyle);
    parentName:=GetWxWidgetParent(self);

    Result:=Format('%s =  new %s(%s, %s, _("%s") , wxPoint(%d,%d),wxSize(%d,%d) %s);',[self.Name,self.wx_Class,parentName,GetWxIDString(self.Wx_IDName,self.Wx_IDValue),GetCppString(self.Text),self.Left,self.Top,self.width,self.Height,strStyle] );

    if trim(self.Wx_ToolTip) <> '' then
        Result:=Result + #13+Format('%s->SetToolTip(wxT(_("%s")));',[self.Name,GetCppString(self.Wx_ToolTip)]);

    if self.Wx_Hidden then
        Result:=Result + #13+Format('%s->Show(false);',[self.Name]);

    if not Wx_Enabled then
        Result:=Result + #13+Format('%s->Enable(false);',[self.Name]);

    if trim(self.Wx_HelpText) <> '' then
        Result:=Result +#13+Format('%s->SetHelpText(_("%s"));',[self.Name,GetCppString(self.Wx_HelpText)]);

    if self.Default then
        Result:=Result +#13+Format('%s->SetDefault();',[self.Name]);


    strColorStr:=trim(GetwxColorFromString(InvisibleFGColorString));
    if strColorStr <> '' then
	Result:=Result+#13+Format('%s->SetForegroundColour(%s);',[self.Name,strColorStr]);

    strColorStr:=trim(GetwxColorFromString(InvisibleBGColorString));
    if strColorStr <> '' then
	Result:=Result+#13+Format('%s->SetBackgroundColour(%s);',[self.Name,strColorStr]);


    strColorStr:=GetWxFontDeclaration(self.Font);
    if strColorStr <> '' then
	Result:=Result+#13+Format('%s->SetFont(%s);',[self.Name,strColorStr]);

    if(self.Parent is TWxSizerPanel) then
    begin

        strAlignment:=SizerAlignmentToStr(Wx_HorizontalAlignment) + ' | '+ SizerAlignmentToStr(Wx_VerticalAlignment) +' | wxALL';
        if wx_ControlOrientation = wxControlVertical then
            strAlignment:=SizerAlignmentToStr(Wx_HorizontalAlignment)+ ' | wxALL';

         if wx_ControlOrientation = wxControlHorizontal then
             strAlignment:=SizerAlignmentToStr(Wx_VerticalAlignment)+ ' | wxALL';

         Result:=Result +#13+Format('%s->Add(%s,%d,%s,%d);',[self.Parent.Name,self.Name,self.Wx_StretchFactor,strAlignment,self.Wx_Border]);

    end;
    if(self.Parent is TWxToolBar) then
    begin
        Result:=Result +#13+Format('%s->AddControl(%s);',[self.Parent.Name,self.Name]);
    end;
end;

function TWxButton.GenerateGUIControlDeclaration:String;
begin
     Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TWxButton.GenerateHeaderInclude:String;
begin
Result:='#include <wx/button.h>';
end;

function TWxButton.GenerateImageInclude: string;
begin

end;

function TWxButton.GetEventList:TStringlist;
begin
     Result:=Wx_EventList;
end;

function TWxButton.GetIDName:String;
begin
     Result:=wx_IDName;
end;

function TWxButton.GetIDValue:LongInt;
begin
     Result:=wx_IDValue;
end;

function TWxButton.GetParameterFromEventName(EventName: string):String;
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

function TWxButton.GetPropertyList:TStringList;
begin
     Result:=FWx_PropertyList;
end;

function TWxButton.GetStretchFactor:Integer;
begin
    result:=Wx_StretchFactor;
end;

function TWxButton.GetTypeFromEventName(EventName: string):string;
begin

end;

function TWxButton.GetWxClassName:String;
begin
     if trim(wx_Class) = '' then
        wx_Class:='wxButton';
     Result:=wx_Class;
end;

procedure TWxButton.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
wx_ControlOrientation:=ControlOrientation;
end;

procedure TWxButton.SetIDName(IDName:String);
begin
     wx_IDName:=IDName;
end;

procedure TWxButton.SetIDValue(IDValue:longInt);
begin
     Wx_IDValue:=IDVAlue;
end;

procedure TWxButton.SetStretchFactor(intValue:Integer);
begin
    Wx_StretchFactor:=intValue;
end;

procedure TWxButton.SetWxClassName(wxClassName:String);
begin
     wx_Class:=wxClassName;
end;

function TWxButton.GetFGColor:string;
begin
   Result:=FInvisibleFGColorString;
end;

procedure TWxButton.SetFGColor(strValue:String);
begin
    FInvisibleFGColorString:=strValue;
   if IsDefaultColorStr(strValue) then
	self.Font.Color:=defaultFGColor
   else
	self.Font.Color:=GetColorFromString(strValue);
end;

function TWxButton.GetBGColor:string;
begin
   Result:=FInvisibleBGColorString;
end;

procedure TWxButton.SetBGColor(strValue:String);
begin
    FInvisibleBGColorString:=strValue;
   if IsDefaultColorStr(strValue) then
	self.Color:=defaultBGColor
   else
	self.Color:=GetColorFromString(strValue);
end;
procedure TWxButton.SetProxyFGColorString(value:String);
begin
    FInvisibleFGColorString:=value;
    self.Color:=GetColorFromString(value);
end;

procedure TWxButton.SetProxyBGColorString(value:String);
begin
   FInvisibleBGColorString:=value;
   self.Font.Color:=GetColorFromString(value);
end;

end.
