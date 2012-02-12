 { ****************************************************************** }
 {                                                                    }
 { $Id: wxstaticline.pas 936 2007-05-15 03:47:39Z gururamnath $ }
 {                                                                    }
{                                                                    }
{   Copyright © 2003-2007 by Guru Kathiresan                         }
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

Unit WxStaticline;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, StdCtrls, Wxutils, ExtCtrls, WxSizerPanel;

Type
    TWxStaticLine = Class(TRadioGroup, IWxComponentInterface)
    Private
    { Private fields of TWxStaticLine }
    { Storage for property Wx_BGColor }
        FWx_BGColor: TColor;
    { Storage for property Wx_Border }
        FWx_Border: Integer;
    { Storage for property Wx_Class }
        FWx_Class: String;
    { Storage for property Wx_ControlOrientation }
        FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_Enabled }
        FWx_Enabled: Boolean;
    { Storage for property Wx_FGColor }
        FWx_FGColor: TColor;
    { Storage for property Wx_GeneralStyle }
        FWx_GeneralStyle: TWxStdStyleSet;
    { Storage for property Wx_HelpText }
        FWx_HelpText: String;
    { Storage for property Wx_Hidden }
        FWx_Hidden: Boolean;
        FWx_Length: Integer;
    { Storage for property Wx_IDName }
        FWx_IDName: String;
    { Storage for property Wx_IDValue }
        FWx_IDValue: Integer;
    { Storage for property Wx_ProxyBGColorString }
        FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
        FWx_ProxyFGColorString: TWxColorString;
    { Storage for property Wx_StretchFactor }
        FWx_StretchFactor: Integer;
    { Storage for property Wx_ToolTip }
        FWx_ToolTip: String;
        FWx_PropertyList: TStringList;
        FInvisibleBGColorString: String;
        FInvisibleFGColorString: String;
        FWx_LIOrientation: TWx_LIOrientation;
        FLastOrientation: TWx_LIOrientation;
        FWx_Comments: TStrings;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;

    { Private methods of TWxStaticLine }
    { Method to set variable and property values and create objects }
        Procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
        Procedure AutoDestroy;

    Protected
    { Protected fields of TWxStaticLine }

    { Protected methods of TWxStaticLine }
        Procedure Click; Override;
        Procedure KeyPress(Var Key: Char); Override;
        Procedure Loaded; Override;
        Procedure Paint; Override;

    Public
    { Public fields and properties of TWxStaticLine }
        defaultBGColor: TColor;
        defaultFGColor: TColor;
    { Public methods of TWxStaticLine }
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
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

        Function GetGenericColor(strVariableName: String): String;
        Procedure SetGenericColor(strVariableName, strValue: String);

        Procedure SetProxyFGColorString(Value: String);
        Procedure SetProxyBGColorString(Value: String);

        Function GetLineOrientation(Value: TWx_LIOrientation): String;
        Procedure WMSizeX(Var Message: TWMSize); Message WM_PAINT;

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

    Published
    { Published properties of TWxStaticLine }
        Property OnClick;
        Property OnDblClick;
        Property OnDragDrop;
        Property OnEnter;
        Property OnExit;
        Property OnKeyDown;
        Property OnKeyPress;
        Property OnKeyUp;
        Property OnMouseDown;
        Property OnMouseMove;
        Property OnMouseUp;
        Property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_ControlOrientation: TWxControlOrientation
            Read FWx_ControlOrientation Write FWx_ControlOrientation;
        Property Wx_Enabled: Boolean Read FWx_Enabled Write FWx_Enabled Default True;
        Property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
        Property Wx_GeneralStyle: TWxStdStyleSet
            Read FWx_GeneralStyle Write FWx_GeneralStyle;
        Property Wx_HelpText: String Read FWx_HelpText Write FWx_HelpText;
        Property Wx_Hidden: Boolean Read FWx_Hidden Write FWx_Hidden Default False;
        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue;
        Property Wx_ToolTip: String Read FWx_ToolTip Write FWx_ToolTip;
        Property Wx_LIOrientation: TWx_LIOrientation Read FWx_LIOrientation Write FWx_LIOrientation;
        Property Wx_Length: Integer Read FWx_Length Write FWx_Length;
        Property LastOrientation: TWx_LIOrientation Read FLastOrientation Write FLastOrientation;

        Property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
        Property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
        Property InvisibleBGColorString: String Read FInvisibleBGColorString Write FInvisibleBGColorString;
        Property InvisibleFGColorString: String Read FInvisibleFGColorString Write FInvisibleFGColorString;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
     { Register TWxStaticLine with wxWidgets as its
       default page on the Delphi component palette }
    RegisterComponents('wxWidgets', [TWxStaticLine]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxStaticLine.AutoInitialize;
Begin
    FWx_Length := 150;
    FWx_PropertyList := TStringList.Create;
    FWx_Border := 5;
    FWx_Class := 'wxStaticLine';
    FWx_Enabled := True;
    FWx_Hidden := False;
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_StretchFactor := 0;
    FWx_ProxyBGColorString := TWxColorString.Create;
    FWx_ProxyFGColorString := TWxColorString.Create;
    defaultBGColor := clBtnFace;
    defaultFGColor := self.font.color;
    FWx_Comments := TStringList.Create;
    LastOrientation := FWx_LIOrientation;

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxStaticLine.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_Comments.Destroy;
    FWx_ProxyFGColorString.Destroy;
    FWx_ProxyBGColorString.Destroy;
End; { of AutoDestroy }

{ Override OnClick handler from TRadioGroup,IWxComponentInterface }
Procedure TWxStaticLine.Click;
Begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
    Inherited Click;

     { Code to execute after click behavior
       of parent }

End;

{ Override OnKeyPress handler from TRadioGroup,IWxComponentInterface }
Procedure TWxStaticLine.KeyPress(Var Key: Char);
Const
    TabKey = Char(VK_TAB);
    EnterKey = Char(VK_RETURN);
Begin
     { Key contains the character produced by the keypress.
       It can be tested or assigned a new value before the
       call to the inherited KeyPress method.  Setting Key
       to #0 before call to the inherited KeyPress method
       terminates any further processing of the character. }

  { Activate KeyPress behavior of parent }
    Inherited KeyPress(Key);

  { Code to execute after KeyPress behavior of parent }

End;

Constructor TWxStaticLine.Create(AOwner: TComponent);
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

  { Code to perform other tasks when the component is created }
    FWx_PropertyList.add('Wx_Enabled:Enabled');
    FWx_PropertyList.add('Wx_Class:Base Class');
    FWx_PropertyList.add('Wx_Hidden:Hidden');
    FWx_PropertyList.add('Wx_Default:Default');
    FWx_PropertyList.add('Wx_HelpText:Help Text');
    FWx_PropertyList.add('Wx_IDName:ID Name');
    FWx_PropertyList.add('Wx_IDValue:ID Value');
    FWx_PropertyList.add('Wx_ToolTip:Tooltip');
    FWx_PropertyList.add('Wx_Comments:Comments');
    FWx_PropertyList.Add('Wx_Validator:Validator code');
    FWx_PropertyList.add('Wx_ProxyBGColorString:Background Color');
    FWx_PropertyList.add('Wx_ProxyFGColorString:Foreground Color');

    FWx_PropertyList.add('Wx_StretchFactor:Stretch Factor');
    FWx_PropertyList.add('Wx_Alignment:Alignment');
    FWx_PropertyList.add('Wx_Border: Border');
    FWx_PropertyList.add('Wx_BorderAlignment:Borders');
    FWx_PropertyList.add('wxALL:wxALL');
    FWx_PropertyList.add('wxTOP:wxTOP');
    FWx_PropertyList.add('wxLEFT:wxLEFT');
    FWx_PropertyList.add('wxRIGHT:wxRIGHT');
    FWx_PropertyList.add('wxBOTTOM:wxBOTTOM');

    FWx_PropertyList.add('Wx_GeneralStyle:General Styles');
    FWx_PropertyList.Add('wxNO_3D:wxNO_3D');
    FWx_PropertyList.Add('wxNO_BORDER:wxNO_BORDER');
    FWx_PropertyList.Add('wxWANTS_CHARS:wxWANTS_CHARS');
    FWx_PropertyList.Add('wxCLIP_CHILDREN:wxCLIP_CHILDREN');
    FWx_PropertyList.Add('wxSIMPLE_BORDER:wxSIMPLE_BORDER');
    FWx_PropertyList.Add('wxDOUBLE_BORDER:wxDOUBLE_BORDER');
    FWx_PropertyList.Add('wxSUNKEN_BORDER:wxSUNKEN_BORDER');
    FWx_PropertyList.Add('wxRAISED_BORDER:wxRAISED_BORDER');
    FWx_PropertyList.Add('wxSTATIC_BORDER:wxSTATIC_BORDER');
    FWx_PropertyList.Add('wxTAB_TRAVERSAL:wxTAB_TRAVERSAL');
    FWx_PropertyList.Add('wxTRANSPARENT_WINDOW:wxTRANSPARENT_WINDOW');
    FWx_PropertyList.Add('wxNO_FULL_REPAINT_ON_RESIZE:wxNO_FULL_REPAINT_ON_RESIZE');
    FWx_PropertyList.Add('wxVSCROLL:wxVSCROLL');
    FWx_PropertyList.Add('wxHSCROLL:wxHSCROLL');

    FWx_PropertyList.add('Font:Font');
    FWx_PropertyList.add('Name:Name');
    FWx_PropertyList.add('Left:Left');
    FWx_PropertyList.add('Top:Top');
    FWx_PropertyList.add('Wx_Length:Length');
    FWx_PropertyList.add('Wx_LIOrientation:Orientation');
    self.Caption := '';

End;

Destructor TWxStaticLine.Destroy;
Begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
    AutoDestroy;

  { Here, free any other dynamic objects that the component methods  }
  { created but have not yet freed.  Also perform any other clean-up }
  { operations needed before the component is destroyed.             }

  { Last, free the component by calling the Destroy method of the    }
  { parent class.                                                    }
    Inherited Destroy;
End;


Function TWxStaticLine.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxStaticLine.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
End;

Function TWxStaticLine.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxStaticLine.GenerateXRCControlCreation(IndentString: String): TStringList;
Begin

    Result := TStringList.Create;

    Try
        Result.Add(IndentString + Format('<object class="%s" name="%s">',
            [self.Wx_Class, self.Name]));
        Result.Add(IndentString + Format('  <label>%s</label>', [self.Text]));
        Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
        Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));

        If Not (UseDefaultSize) Then
            Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
        If Not (UseDefaultPos) Then
            Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

        Result.Add(IndentString + Format('  <orient>%s</orient>',
            [GetLineOrientation(FWx_LIOrientation)]));

        Result.Add(IndentString + Format('  <style>%s</style>',
            [GetStdStyleString(self.Wx_GeneralStyle)]));
        Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxStaticLine.GenerateGUIControlCreation: String;
Var
    strColorStr: String;
    strStyle, parentName, strAlignment: String;
Begin
    Result := '';

    parentName := GetWxWidgetParent(self, False);

    strStyle := GetStdStyleString(self.Wx_GeneralStyle);

    If (trim(strStyle) <> '') Then
        strStyle := ', ' + GetLineOrientation(FWx_LIOrientation) +
            ' | ' + strStyle
    Else
        strStyle := ', ' + GetLineOrientation(FWx_LIOrientation);

    If (XRCGEN) Then
    Begin//generate xrc loading code
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
            [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);
    End
    Else
    Begin
        If (FWx_LIOrientation = wxLI_HORIZONTAL) Then
            Result := GetCommentString(self.FWx_Comments.Text) +
                Format('%s = new %s(%s, %s, %s, %s%s);',
                [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
                self.Wx_IDValue),
                GetWxPosition(self.Left, self.Top), GetWxSize(FWx_Length, -1), strStyle])
        Else
            Result := GetCommentString(self.FWx_Comments.Text) +
                Format('%s = new %s(%s, %s, %s, %s%s);',
                [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
                self.Wx_IDValue),
                GetWxPosition(self.Left, self.Top), GetWxSize(-1, FWx_Length), strStyle]);
    End;

    If trim(self.Wx_ToolTip) <> '' Then
        Result := Result + #13 + Format('%s->SetToolTip(%s);',
            [self.Name, GetCppString(self.Wx_ToolTip)]);

    If self.Wx_Hidden Then
        Result := Result + #13 + Format('%s->Show(false);', [self.Name]);

    If Not Wx_Enabled Then
        Result := Result + #13 + Format('%s->Enable(false);', [self.Name]);

    If trim(self.Wx_HelpText) <> '' Then
        Result := Result + #13 + Format('%s->SetHelpText(%s);',
            [self.Name, GetCppString(self.Wx_HelpText)]);

    strColorStr := trim(GetwxColorFromString(InvisibleFGColorString));
    If strColorStr <> '' Then
        Result := Result + #13 + Format('%s->SetForegroundColour(%s);',
            [self.Name, strColorStr]);

    strColorStr := trim(GetwxColorFromString(InvisibleBGColorString));
    If strColorStr <> '' Then
        Result := Result + #13 + Format('%s->SetBackgroundColour(%s);',
            [self.Name, strColorStr]);


    strColorStr := GetWxFontDeclaration(self.Font);
    If strColorStr <> '' Then
        Result := Result + #13 + Format('%s->SetFont(%s);', [self.Name, strColorStr]);
    If Not (XRCGEN) Then //NUKLEAR ZELPH
        If (self.Parent Is TWxSizerPanel) Then
        Begin
            strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
            Result := Result + #13 + Format('%s->Add(%s, %d, %s, %d);',
                [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
                self.Wx_Border]);
        End;

    If (FWx_LIOrientation = wxLI_HORIZONTAL) Then
    Begin
        If (self.FWx_Length <> Width) Then
            Width := self.FWx_Length;
    End
    Else
    If (self.FWx_Length <> Height) Then
        Height := self.FWx_Length;

End;

Function TWxStaticLine.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxStaticLine.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/statline.h>';
End;

Function TWxStaticLine.GenerateImageInclude: String;
Begin

End;

Function TWxStaticLine.GetEventList: TStringList;
Begin
    Result := Nil;
End;

Function TWxStaticLine.GetIDName: String;
Begin
    Result := wx_IDName;
End;

Function TWxStaticLine.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxStaticLine.GetParameterFromEventName(EventName: String): String;
Begin

End;

Function TWxStaticLine.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxStaticLine.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxStaticLine.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxStaticLine.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxStaticLine.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxStaticLine.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxStaticLine.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxStaticLine.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxStaticLine';
    Result := wx_Class;
End;

Procedure TWxStaticLine.Loaded;
Begin
    Inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

End;

Procedure TWxStaticLine.Paint;
Begin
     { Make this component look like its parent component by calling
       its parent's Paint method. }
    Inherited Paint;

     { To change the appearance of the component, use the methods
       supplied by the component's Canvas property (which is of
       type TCanvas).  For example, }

  { Canvas.Rectangle(0, 0, Width, Height); }
End;

Procedure TWxStaticLine.SaveControlOrientation(ControlOrientation:
    TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxStaticLine.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxStaticLine.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxStaticLine.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxStaticLine.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Procedure TWxStaticLine.WMSizeX(Var Message: TWMSize);
Var
    W, H: Integer;
Begin
    Inherited;
    Caption := '';

    If (FWx_LIOrientation = wxLI_HORIZONTAL) Then
    Begin
        { Copy the new width and height of the component
        so we can use SetBounds to change both at once }
        W := Width;
        FWx_Length := Width;
    { Code to check and adjust W and H }
        H := 7;
    End
    Else
    Begin
        W := 3;
        H := Height;
        FWx_Length := Height;
    End;

  { Update the component size if we adjusted W or H }
    If (W <> Width) Or (H <> Height) Then
        Inherited SetBounds(Left, Top, W, H);

     { Code to update dimensions of any owned sub-components
       by reading their Height and Width properties and updating
       via their SetBounds methods }

    Message.Result := 0;
End;

Function TWxStaticLine.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxStaticLine.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxStaticLine.GetFGColor: String;
Begin
    Result := FInvisibleFGColorString;
End;

Procedure TWxStaticLine.SetFGColor(strValue: String);
Begin
    FInvisibleFGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Font.Color := defaultFGColor
    Else
        self.Font.Color := GetColorFromString(strValue);
End;

Function TWxStaticLine.GetBGColor: String;
Begin
    Result := FInvisibleBGColorString;
End;

Procedure TWxStaticLine.SetBGColor(strValue: String);
Begin
    FInvisibleBGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Color := defaultBGColor
    Else
        self.Color := GetColorFromString(strValue);
End;

Procedure TWxStaticLine.SetProxyFGColorString(Value: String);
Begin
    FInvisibleFGColorString := Value;
    self.Color := GetColorFromString(Value);
End;

Procedure TWxStaticLine.SetProxyBGColorString(Value: String);
Begin
    FInvisibleBGColorString := Value;
    self.Font.Color := GetColorFromString(Value);
End;

Function TWxStaticLine.GetLineOrientation(Value: TWx_LIOrientation): String;
Var
    temp: Integer;
Begin
    Result := '';
    If Value = wxLI_VERTICAL Then
        Result := 'wxLI_VERTICAL';
    If Value = wxLI_HORIZONTAL Then
        Result := 'wxLI_HORIZONTAL';

    If (FLastOrientation <> FWx_LIOrientation) Then
    Begin
        FLastOrientation := FWx_LIOrientation;
        temp := Width;
        Width := Height;
        Height := temp;
        Inherited SetBounds(Left, Top, Width, Height);
    End;

End;

End.
