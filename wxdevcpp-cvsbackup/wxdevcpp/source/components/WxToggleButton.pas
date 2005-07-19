// $Id$ 
//

unit WxToggleButton;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,  MultiLangSupport,
     Forms, Graphics, Stdctrls, Wxutils, ExtCtrls, WxSizerPanel,WxToolBar;

type
  TDrawButtonEvent = procedure(Control: TWinControl;
    Rect: TRect; State: TOwnerDrawState) of object;
    
  TWxToggleButton = class(TMultiLineBtn,IWxComponentInterface,IWxToolBarInsertableInterface,IWxToolBarNonInsertableInterface)
    private
          FCanvas: TCanvas;
        FOnDrawButton: TDrawButtonEvent;    
      { Private fields of TWxToggleButton }

        FEVT_TOGGLEBUTTON : String;
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
        FWx_Validator : String;
        FWx_Comments : TStrings;

        procedure AutoInitialize;
        procedure AutoDestroy;

    protected
      { Protected fields of TWxToggleButton }

      { Protected methods of TWxToggleButton }
        procedure Click; override;

    public
      { Public fields and properties of TWxToggleButton }
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
      { Published properties of TWxToggleButton }
        property OnClick;
        property OnDblClick;
        property OnDragDrop;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
        property EVT_TOGGLEBUTTON : String read FEVT_TOGGLEBUTTON write FEVT_TOGGLEBUTTON;
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
        property Wx_Validator : String read FWx_Validator write FWx_Validator;
        property Wx_ToolTip : String read FWx_ToolTip write FWx_ToolTip;
        property Wx_VerticalAlignment : TWxSizerVerticalAlignment
             read FWx_VerticalAlignment write FWx_VerticalAlignment
             default wxSZALIGN_CENTER_VERTICAL;

        property Wx_Comments : TStrings read FWx_Comments write FWx_Comments;

        property InvisibleBGColorString:String read FInvisibleBGColorString write FInvisibleBGColorString;
        property InvisibleFGColorString:String read FInvisibleFGColorString write FInvisibleFGColorString;

        property OnDrawButton: TDrawButtonEvent read FOnDrawButton write FOnDrawButton;
        property Color;

  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxToggleButton with wxWidgets as its
       default page on the Delphi component palette }
      RegisterComponents('wxWidgets', [TWxToggleButton]);
end;

{ Method to set variable and property values and create objects }
procedure TWxToggleButton.AutoInitialize;
begin
     FWx_PropertyList := TStringList.Create;
     FWx_Border := 5;
     FWx_Class := 'wxToggleButton';
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

     FWx_Comments := TStringList.Create;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxToggleButton.AutoDestroy;
begin
     FWx_PropertyList.Free;
     FWx_EventList.Free;
end; { of AutoDestroy }

{ Override OnClick handler from TButton,IWxComponentInterface }
procedure TWxToggleButton.Click;
begin
     inherited Click;
end;

constructor TWxToggleButton.Create(AOwner: TComponent);
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
     FWx_PropertyList.add('Name :' + Lang.Strings[ID_NP_PRJNAME]);
     FWx_PropertyList.add('Left : Left');
     FWx_PropertyList.add('Top : Top');
     FWx_PropertyList.add('Width :' + Lang.Strings[ID_EOPT_WIDTH]);
     FWx_PropertyList.add('Height:Height');
     FWx_PropertyList.add('Wx_ProxyBGColorString:' + Lang.Strings[ID_EOPT_BACK] + ' ' + Lang.Strings[ID_EOPT_COLOR]);
     FWx_PropertyList.add('Wx_ProxyFGColorString:' + Lang.Strings[ID_EOPT_FORE] + ' ' + Lang.Strings[ID_EOPT_COLOR]);
     FWx_PropertyList.add('Wx_GeneralStyle: ' + Lang.Strings[ID_EOPT_GENTAB] + ' ' + Lang.Strings[ID_NEWVAR_COMMENTSSTYLE]);
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
     FWx_PropertyList.add('Font :' + Lang.Strings[ID_EOPT_FONT]);
     FWx_PropertyList.add('Wx_HorizontalAlignment : HorizontalAlignment');
     FWx_PropertyList.add('Wx_VerticalAlignment   : VerticalAlignment');
     FWx_PropertyList.add('Wx_StretchFactor   : StretchFactor');
     FWx_PropertyList.add('Wx_Validator : Validator code');
     FWx_PropertyList.add('Default :' + Lang.Strings[ID_BTN_DEFAULT]);

     FWx_PropertyList.add('Wx_Comments:' + Lang.Strings[ID_ITEM_COMMENTSELECTION]);

     FWx_EventList.add('EVT_TOGGLEBUTTON:OnClick');
     FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxToggleButton.Destroy;
begin
     AutoDestroy;
     inherited Destroy;
     FCanvas.Free;
end;


function TWxToggleButton.GenerateEnumControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('%s = %d, ',[Wx_IDName,Wx_IDValue]);
end;

function TWxToggleButton.GenerateControlIDs:String;
begin
     Result:='';
     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
        Result:=Format('#define %s %d ',[Wx_IDName,Wx_IDValue]);
end;


function TWxToggleButton.GenerateEventTableEntries(CurrClassName:String):String;
begin
     Result:='';
     if trim(EVT_TOGGLEBUTTON) <> '' then
     begin
          Result:=Format('EVT_TOGGLEBUTTON(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_TOGGLEBUTTON]) +'';
     end;

     if trim(EVT_UPDATE_UI) <> '' then
     begin
          Result:=Result+#13+Format('EVT_UPDATE_UI(%s,%s::%s)',[WX_IDName,CurrClassName,EVT_UPDATE_UI]) +'';
     end;

end;

function TWxToggleButton.GenerateGUIControlCreation:String;
var
     strColorStr:String;
     strStyle:String;
     parentName,strAlignment:String;
begin
    Result:='';
    strStyle:=GetButtonSpecificStyle(self.Wx_GeneralStyle,Wx_ButtonStyle);
    parentName:=GetWxWidgetParent(self);

    if trim(self.FWx_Validator) <> '' then
    begin
       if trim(strStyle) <> '' then
           strStyle := strStyle + ', ' + self.Wx_Validator
       else
           strStyle := ', 0, ' + self.Wx_Validator;

       strStyle := strStyle + ', ' + GetCppString(Name);

    end
    else
      if trim(strStyle) <> '' then
           strStyle := strStyle + ', wxDefaultValidator, ' + GetCppString(Name)
      else
           strStyle := ', 0, wxDefaultValidator, ' + GetCppString(Name);

    Result:= GetCommentString(self.FWx_Comments.Text) + Format('%s = new %s(%s, %s, %s, wxPoint(%d,%d), wxSize(%d,%d)%s);',[self.Name,self.wx_Class,parentName,GetWxIDString(self.Wx_IDName,self.Wx_IDValue),GetCppString(self.Text),self.Left,self.Top,self.width,self.Height,strStyle] );

    if trim(self.Wx_ToolTip) <> '' then
        Result:=Result + #13+Format('%s->SetToolTip(%s);',[self.Name,GetCppString(self.Wx_ToolTip)]);

    if self.Wx_Hidden then
        Result:=Result + #13+Format('%s->Show(false);',[self.Name]);

    if not Wx_Enabled then
        Result:=Result + #13+Format('%s->Enable(false);',[self.Name]);

    if trim(self.Wx_HelpText) <> '' then
        Result:=Result +#13+Format('%s->SetHelpText(%s);',[self.Name,GetCppString(self.Wx_HelpText)]);

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

    HorizAlign := halCentre;

    VerticalAlign := valCentre;

end;

function TWxToggleButton.GenerateGUIControlDeclaration:String;
begin
     Result:=Format('%s *%s;',[trim(Self.Wx_Class),trim(Self.Name)]);
end;

function TWxToggleButton.GenerateHeaderInclude:String;
begin
Result:='#include <wx/tglbtn.h>';
end;

function TWxToggleButton.GenerateImageInclude: string;
begin

end;

function TWxToggleButton.GetEventList:TStringlist;
begin
     Result:=Wx_EventList;
end;

function TWxToggleButton.GetIDName:String;
begin
     Result:=wx_IDName;
end;

function TWxToggleButton.GetIDValue:LongInt;
begin
     Result:=wx_IDValue;
end;

function TWxToggleButton.GetParameterFromEventName(EventName: string):String;
begin
if EventName = 'EVT_TOGGLEBUTTON' then
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

function TWxToggleButton.GetPropertyList:TStringList;
begin
     Result:=FWx_PropertyList;
end;

function TWxToggleButton.GetStretchFactor:Integer;
begin
    result:=Wx_StretchFactor;
end;

function TWxToggleButton.GetTypeFromEventName(EventName: string):string;
begin

end;

function TWxToggleButton.GetWxClassName:String;
begin
     if trim(wx_Class) = '' then
        wx_Class:='wxToggleButton';
     Result:=wx_Class;
end;

procedure TWxToggleButton.SaveControlOrientation(ControlOrientation:TWxControlOrientation);
begin
wx_ControlOrientation:=ControlOrientation;
end;

procedure TWxToggleButton.SetIDName(IDName:String);
begin
     wx_IDName:=IDName;
end;

procedure TWxToggleButton.SetIDValue(IDValue:longInt);
begin
     Wx_IDValue:=IDVAlue;
end;

procedure TWxToggleButton.SetStretchFactor(intValue:Integer);
begin
    Wx_StretchFactor:=intValue;
end;

procedure TWxToggleButton.SetWxClassName(wxClassName:String);
begin
     wx_Class:=wxClassName;
end;

function TWxToggleButton.GetFGColor:string;
begin
   Result:=FInvisibleFGColorString;
end;

procedure TWxToggleButton.SetFGColor(strValue:String);
begin
    FInvisibleFGColorString:=strValue;
   if IsDefaultColorStr(strValue) then
	self.Font.Color:=defaultFGColor
   else
	self.Font.Color:=GetColorFromString(strValue);
end;

function TWxToggleButton.GetBGColor:string;
begin
   Result:=FInvisibleBGColorString;
end;

procedure TWxToggleButton.SetBGColor(strValue:String);
begin
    FInvisibleBGColorString:=strValue;
   if IsDefaultColorStr(strValue) then
	self.Color:=defaultBGColor
   else
	self.Color:=GetColorFromString(strValue);
end;
procedure TWxToggleButton.SetProxyFGColorString(value:String);
begin
    FInvisibleFGColorString:=value;
    self.Color:=GetColorFromString(value);
end;

procedure TWxToggleButton.SetProxyBGColorString(value:String);
begin
   FInvisibleBGColorString:=value;
   self.Font.Color:=GetColorFromString(value);
end;

end.
