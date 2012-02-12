{ ****************************************************************** }
{                                                                    }
{ $Id$                                                               }
{                                                                    }
{   Copyright © 2009 by Malcolm Nealon                        }
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

Unit wxAuiBar;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, ExtCtrls, WxUtils, WxSizerPanel;

Type
    TWxAuiBar = Class(TControlBar, IWxComponentInterface, IWxWindowInterface,
        IWxContainerInterface, IWxContainerAndSizerInterface)
    Private
    { Private fields of TWxAuiBar }
    {Property Listing}
        FWx_Class: String;
        FWx_PropertyList: TStringList;
        FWx_EventList: TStringList;
        FWx_Comments: TStrings;
        FWx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem;

    {Event Lisiting}

    { Private methods of TWxAuiBar }
        Procedure AutoInitialize;
        Procedure AutoDestroy;

    Protected
    { Protected fields of TWxAuiBar }

    { Protected methods of TWxAuiBar }


    Public
    { Public fields and properties of TWxAuiBar }

    { Public methods of TWxAuiBar }
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Procedure Paint; Override;
        Function GenerateControlIDs: String;
        Function GenerateEnumControlIDs: String;
        Function GenerateEventTableEntries(CurrClassName: String): String;
        Function GenerateGUIControlCreation: String;
        Function GenerateXRCControlCreation(IndentString: String): TStringList;
        Function GenerateGUIControlDeclaration: String;
        Function GenerateHeaderInclude: String;
        Function GenerateImageInclude: String;
        Function GetEventList: TStringList;
        Function GetIDName: String;
        Function GetIDValue: Integer;
        Function GetParameterFromEventName(EventName: String): String;
        Function GetPropertyList: TStringList;
        Function GetTypeFromEventName(EventName: String): String;
        Function GetWxClassName: String;
        Procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
        Procedure SetIDName(IDName: String);
        Procedure SetIDValue(IDValue: Integer);
        Procedure SetWxClassName(wxClassName: String);
        Function GetFGColor: String;
        Procedure SetFGColor(strValue: String);
        Function GetBGColor: String;
        Procedure SetBGColor(strValue: String);
        Procedure SetProxyFGColorString(Value: String);
        Procedure SetProxyBGColorString(Value: String);
        Function GenerateLastCreationCode: String;

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);
        Function GetGenericColor(strVariableName: String): String;
        Procedure SetGenericColor(strVariableName, strValue: String);

        Procedure GetAuiDockDirection(Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem);
    Published
    { Published properties of TWxPanel }
        Property Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem Read FWx_Aui_Dock_Direction Write FWx_Aui_Dock_Direction;
//    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
//    property Wx_BKColor: TColor Read FWx_BKColor Write FWx_BKColor;
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
//    property Wx_ControlOrientation: TWxControlOrientation
//      Read FWx_ControlOrientation Write FWx_ControlOrientation;
//    property Wx_Default: boolean Read FWx_Default Write FWx_Default;
//    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
        Property Wx_EventList: TStringList Read FWx_EventList Write FWx_EventList;
//    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
//    property Wx_GeneralStyle: TWxStdStyleSet
//      Read FWx_GeneralStyle Write FWx_GeneralStyle;
//    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
//    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
//    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;

//    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;

//    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
//    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
//    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
//    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;

//    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
//    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
//    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
//    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxAuiBar]);
End;


Procedure TWxAuiBar.AutoInitialize;
Begin
    Caption := '';
    FWx_Class := '';
    FWx_PropertyList := TStringList.Create;
    FWx_EventList := TStringList.Create;
    FWx_Comments := TStringList.Create;
//  FWx_Border             := 5;
//  FWx_Enabled            := True;
// FWx_BorderAlignment    := [wxAll];
//  FWx_Alignment          := [wxALIGN_CENTER];
//  FWx_IDValue            := -1;
//  FWx_StretchFactor      := 0;
//  FWx_ProxyBGColorString := TWxColorString.Create;
//  FWx_ProxyFGColorString := TWxColorString.Create;
//  defaultBGColor         := self.color;
//  defaultFGColor         := self.font.color;

{$IFDEF COMPILER_7_UP}
  //Set the background colour for Delphi to draw
  Self.ParentColor := False;
  Self.ParentBackground := False;
{$ENDIF}
End; { of AutoInitialize }


Procedure TWxAuiBar.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_EventList.Destroy;
//  FWx_ProxyBGColorString.Destroy;
//  FWx_ProxyFGColorString.Destroy;
    FWx_Comments.Destroy;
End; { of AutoDestroy }

Constructor TWxAuiBar.Create(AOwner: TComponent);
Begin
  { Call the Create method of the container's parent class       }
    Inherited Create(AOwner);

  { AutoInitialize sets the initial values of variables          }
  { (including subcomponent variables) and properties;           }
  { also, it creates objects for properties of standard          }
  { Delphi object types (e.g., TFont, TTimer, TPicture)          }
  { and for any variables marked as objects.                     }
  { AutoInitialize method is generated by Component Create.      }
    AutoInitialize;

  { Code to perform other tasks when the container is created    }
//  PopulateGenericProperties(FWx_PropertyList);
    FWx_PropertyList.add('Wx_Aui_Dock_Direction:Dock Direction');
    FWx_PropertyList.add('wxAUI_DOCK_NONE:wxAUI_DOCK_NONE');
    FWx_PropertyList.add('wxAUI_DOCK_TOP:wxAUI_DOCK_TOP');
    FWx_PropertyList.add('wxAUI_DOCK_RIGHT:wxAUI_DOCK_RIGHT');
    FWx_PropertyList.add('wxAUI_DOCK_BOTTOM:wxAUI_DOCK_BOTTOM');
    FWx_PropertyList.add('wxAUI_DOCK_LEFT:wxAUI_DOCK_LEFT');



End;

Destructor TWxAuiBar.Destroy;
Begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
    AutoDestroy;

  { Last, free the component by calling the Destroy method of the    }
  { parent class.                                                    }
    Inherited Destroy;
End;

Procedure TWxAuiBar.Paint;
Begin
    self.Caption := '';
     { Make this component look like its parent component by calling
       its parent's Paint method. }
    Inherited Paint;
End;


Function TWxAuiBar.GenerateControlIDs: String;
Begin
    Result := '';
End;

Function TWxAuiBar.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxAuiBar.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxAuiBar.GenerateXRCControlCreation(IndentString: String): TStringList;
Begin

    Result := TStringList.Create;
    Try
        Result.Add('');
    Except
        Result.Free;
        Raise;
    End;


End;

Function TWxAuiBar.GenerateGUIControlCreation: String;
Var
    strColorStr: String;
    strStyle, parentName, strAlignment: String;
    xrctlpanel, kill: Boolean; //is this panel a child of another panel
    i: Integer;
    wxcompInterface: IWxComponentInterface;
Begin
    Result := '';
    GetAuiDockDirection(Self.Wx_Aui_Dock_Direction);
{
  parentName := GetWxWidgetParent(self, false);

  strStyle := GetStdStyleString(self.Wx_GeneralStyle);
  if trim(strStyle) <> '' then
    strStyle := ', ' + strStyle;

  xrctlpanel := false;
//how do i find the panels? need the component interface of the tform.
 if (XRCGEN) then
 begin//generate xrc loading code

   if  xrctlpanel then
   begin//this is not the top panel
   Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
    [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);   
   end
   else
   begin
   Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = wxXmlResource::Get()->LoadPanel(%s,%s("%s"));',
    [self.Name, parentName, StringFormat, self.Name])
   end//this is the top level panel
   
 end
 else
 begin//generate the cpp code
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s, %s, %s, %s%s);',
    [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);
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
      [self.Name, GetCppString(self.Wx_HelpText)]);

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

    if ((not (XRCGEN)) and (self.Parent is TWxSizerPanel)) or ((self.Parent is TWxSizerPanel) and (self.Parent.Parent is TForm) and (XRCGEN)) then
  begin
    strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
    Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);
  end;
}
End;

Function TWxAuiBar.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
//  Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
End;

Function TWxAuiBar.GenerateHeaderInclude: String;
Begin
    Result := '';
//  Result := '#include <wx/panel.h>';
End;

Function TWxAuiBar.GenerateImageInclude: String;
Begin

End;

Function TWxAuiBar.GetEventList: TStringList;
Begin
    Result := FWx_EventList;
End;

Function TWxAuiBar.GetIDName: String;
Begin
    Result := '';
//  Result := wx_IDName;
End;

Function TWxAuiBar.GetIDValue: Integer;
Begin
    Result := 0;
End;

Function TWxAuiBar.GetParameterFromEventName(EventName: String): String;
Begin
    If EventName = 'EVT_UPDATE_UI' Then
    Begin
        Result := 'wxUpdateUIEvent& event';
        exit;
    End;
End;

Function TWxAuiBar.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxAuiBar.GetStretchFactor: Integer;
Begin
    Result := 0;//FWx_StretchFactor;
End;

Function TWxAuiBar.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxAuiBar.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [wxAll];//FWx_BorderAlignment;
End;

Procedure TWxAuiBar.SetBorderAlignment(border: TWxBorderAlignment);
Begin
//  FWx_BorderAlignment := border;
End;

Function TWxAuiBar.GetBorderWidth: Integer;
Begin
    Result := 0;//FWx_Border;
End;

Procedure TWxAuiBar.SetBorderWidth(width: Integer);
Begin
//  FWx_Border := width;
End;

Function TWxAuiBar.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxPanel';
    Result := wx_Class;
End;

Procedure TWxAuiBar.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin
//  wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxAuiBar.SetIDName(IDName: String);
Begin
//  wx_IDName := IDName;
End;

Procedure TWxAuiBar.SetIDValue(IDValue: Integer);
Begin
//  Wx_IDValue := IDVAlue;
End;

Procedure TWxAuiBar.SetStretchFactor(intValue: Integer);
Begin
//  FWx_StretchFactor := intValue;
End;

Procedure TWxAuiBar.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxAuiBar.GetGenericColor(strVariableName: String): String;
Begin

End;

Procedure TWxAuiBar.SetGenericColor(strVariableName, strValue: String);
Begin

End;


Function TWxAuiBar.GetFGColor: String;
Begin
//  Result := FInvisibleFGColorString;
End;

Procedure TWxAuiBar.SetFGColor(strValue: String);
Begin
{  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);   }
End;

Function TWxAuiBar.GetBGColor: String;
Begin
//  Result := FInvisibleBGColorString;
End;

Procedure TWxAuiBar.SetBGColor(strValue: String);
Begin
{  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);   }
End;

Procedure TWxAuiBar.SetProxyFGColorString(Value: String);
Begin
 // FInvisibleFGColorString := Value;
//  self.Color := GetColorFromString(Value);
End;

Procedure TWxAuiBar.SetProxyBGColorString(Value: String);
Begin
//  FInvisibleBGColorString := Value;
 // self.Font.Color := GetColorFromString(Value);
End;

Function TWxAuiBar.GenerateLastCreationCode: String;
Begin
    Result := '';
End;

Procedure TWxAuiBar.GetAuiDockDirection(Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem);
Begin
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_NONE Then
    Begin
        Self.Align := alNone;
        exit;
    End;
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_TOP Then
    Begin
        Self.Align := alTop;
        exit;
    End;
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_RIGHT Then
    Begin
        Self.Align := alRight;
        exit;
    End;
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_BOTTOM Then
    Begin
        Self.Align := alBottom;
        exit;
    End;
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_LEFT Then
    Begin
        Self.Align := alLeft;
        exit;
    End;
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_CENTER Then
    Begin
        Self.Align := alNone;
        exit;
    End;
End;

End.
