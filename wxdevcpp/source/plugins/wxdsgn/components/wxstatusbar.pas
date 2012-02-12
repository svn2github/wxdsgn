 { ****************************************************************** }
 {                                                                    }
{ $Id: wxstatusbar.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
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

Unit WxStatusBar;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, ComCtrls, WxUtils, WxSizerPanel, Dialogs;

Type
    TWxStatusBar = Class(TStatusBar, IWxComponentInterface,
        IWxDialogNonInsertableInterface, IWxStatusBarInterface, IWxContainerInterface,
        IWxContainerAndSizerInterface)
    Private
    { Private fields of TWxStatusBar }
        FOrientation: TWxSizerOrientation;
        FWx_Caption: String;
        FWx_Class: String;
        FWx_ControlOrientation: TWxControlOrientation;
        FWx_EventList: TStringList;
        FWx_IDName: String;
        FWx_IDValue: Integer;
        FWx_StretchFactor: Integer;
        FWx_PropertyList: TStringList;
        FInvisibleBGColorString: String;
        FInvisibleFGColorString: String;
        FWx_StatusbarStyleSet: TWxsbrStyleSet;
        FWx_GeneralStyle: TWxStdStyleSet;
        FWx_ToolTip: String;
        FWx_Enabled: Boolean;
        FWx_Hidden: Boolean;
        FWx_HelpText: String;
        FWx_Border: Integer;
        FWx_Comments: TStrings;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;

    { Private methods of TWxStatusBar }
        Procedure AutoInitialize;
        Procedure AutoDestroy;

    Protected
    { Protected fields of TWxStatusBar }

    { Protected methods of TWxStatusBar }
        Procedure Click; Override;
        Procedure Loaded; Override;
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
        Function GenerateLastCreationCode: String;

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

    Public
    { Public fields and properties of TWxStatusBar }
    { Public fields and properties of TWxTreeCtrl }
        defaultBGColor: TColor;
        defaultFGColor: TColor;
    { Public methods of TWxStatusBar }
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;

    Published
    { Published properties of TWxStatusBar }
        Property OnClick;
        Property OnResize;
        Property Orientation: TWxSizerOrientation
            Read FOrientation Write FOrientation Default wxHorizontal;
        Property Wx_Caption: String Read FWx_Caption Write FWx_Caption;
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_ControlOrientation: TWxControlOrientation
            Read FWx_ControlOrientation Write FWx_ControlOrientation;
        Property Wx_EventList: TStringList Read FWx_EventList Write FWx_EventList;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue Default -1;
        Property Wx_StatusbarStyleSet: TWxsbrStyleSet
            Read FWx_StatusbarStyleSet Write FWx_StatusbarStyleSet;
        Property Wx_GeneralStyle: TWxStdStyleSet
            Read FWx_GeneralStyle Write FWx_GeneralStyle;

        Property Wx_Hidden: Boolean Read FWx_Hidden Write FWx_Hidden;
        Property Wx_ToolTip: String Read FWx_ToolTip Write FWx_ToolTip;
        Property Wx_HelpText: String Read FWx_HelpText Write FWx_HelpText;
        Property Wx_Enabled: Boolean Read FWx_Enabled Write FWx_Enabled;

        Property InvisibleBGColorString: String Read FInvisibleBGColorString Write FInvisibleBGColorString;
        Property InvisibleFGColorString: String Read FInvisibleFGColorString Write FInvisibleFGColorString;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;

        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
     { Register TWxStatusBar with wxWidgets as its
       default page on the Delphi component palette }
    RegisterComponents('wxWidgets', [TWxStatusBar]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxStatusBar.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FOrientation := wxHorizontal;
    FWx_Class := 'wxStatusBar';
    FWx_EventList := TStringList.Create;
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_IDValue := -1;
    FWx_StretchFactor := 0;
    FWx_Enabled := True;
    FWx_Comments := TStringList.Create;

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxStatusBar.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_EventList.Destroy;
    FWx_Comments.Destroy;
End; { of AutoDestroy }

{ Override OnClick handler from TStatusBar }
Procedure TWxStatusBar.Click;
Begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
    Inherited Click;

     { Code to execute after click behavior
       of parent }

End;

Constructor TWxStatusBar.Create(AOwner: TComponent);
Begin
  { Call the Create method of the parent class }
    Inherited Create(AOwner);

  { AutoInitialize sets the initial values of variables and      }
  { properties; also, it creates objects for properties of       }
  { standard Delphi object types (e.g., TFont, TTimer,           }
  { TPicture) and for any variables marked as objects.           }
  { AutoInitialize method is generated by Component Create.      }
    AutoInitialize;

  { Code to perform other tasks when the component is created }
    PopulateGenericProperties(FWx_PropertyList);
    FWx_PropertyList.add('Panels:Fields');
    FWx_PropertyList.add('Wx_StatusbarStyleSet:Statusbar Styles');
    FWx_PropertyList.add('wxST_SIZEGRIP:wxST_SIZEGRIP');

End;

Destructor TWxStatusBar.Destroy;
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

Procedure TWxStatusBar.Loaded;
Begin
    Inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

End;

Function TWxStatusBar.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxStatusBar.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
End;

Function TWxStatusBar.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxStatusBar.GenerateXRCControlCreation(IndentString: String): TStringList;
Var
    I: Integer;
    min1used: Boolean;
    temp: String;
Begin

    Result := TStringList.Create;

    Try
        Result.Add(IndentString + Format('<object class="%s" name="%s">',
            [self.Wx_Class, self.Name]));
        Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
        Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));
{   
    if not(UseDefaultSize)then
      Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    if not(UseDefaultPos) then
      Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));
}
        Result.Add(IndentString + Format('  <fields>%d</fields>', [self.Panels.Count]));

        temp := IndentString + '  <widths>';

        min1used := False;
        For I := 0 To Panels.Count - 2 Do    // Iterate
        Begin
            If self.Panels.items[i].Width = -1 Then
                min1used := True;
            temp := temp + Format('%d, ', [self.Panels.items[i].Width]);
        End;
        If min1used = False Then
            temp := temp + '-1</widths>'
        Else
            temp := temp + Format('%d, ', [self.Panels.items[Panels.Count - 1].Width]) + '</widths>';


        Result.Add(temp);

        Result.Add(IndentString + Format('  <style>%s</style>',
            [GetScrollbarSpecificStyle(self.Wx_GeneralStyle, Wx_StatusbarStyleSet)]));
        Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxStatusBar.GenerateGUIControlCreation: String;
Var
    I: Integer;
    strColorStr: String;
    strStyle, parentName, strAlignment: String;
    min1used: Boolean;
Begin
    Result := '';

    { if (self.Parent is TForm) or (self.Parent is TWxSizerPanel) then
       parentName:=GetWxWidgetParent(self)
    else
       parentName:=self.Parent.name; }

    parentName := GetWxWidgetParent(self, False);

    strStyle := GetScrollbarSpecificStyle(self.Wx_GeneralStyle, Wx_StatusbarStyleSet);

    If (trim(strStyle) <> '') Then
        strStyle := ', ' + strStyle;


    If (XRCGEN) And Not (self.Parent Is TForm) Then
    Begin//generate xrc loading code
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
            [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);
    End
    Else
    Begin
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = new %s(%s, %s%s);', [self.Name, self.wx_Class, parentName,
            GetWxIDString(self.Wx_IDName, self.Wx_IDValue), strStyle]);

        If self.Panels.Count > 0 Then
        Begin
            Result := Result + #13 + Format('%s->SetFieldsCount(%d);',
                [self.Name, self.Panels.Count]);
            For I := 0 To Panels.Count - 1 Do    // Iterate
                Result := Result + #13 + Format('%s->SetStatusText(%s,%d);',
                    [self.Name, GetCppString(self.Panels.items[i].Text), I]);    // for

            Result := Result + #13 + Format('int %s_Widths[%d];',
                [self.Name, self.Panels.Count]);

            min1used := False;
            For I := 0 To Panels.Count - 1 Do    // Iterate
                If I = (Panels.Count - 1) Then
                    If min1used = False Then
                        Result := Result + #13 + Format('%s_Widths[%d] = %d;', [self.Name, I, -1])
                    Else
                        Result := Result + #13 + Format('%s_Widths[%d] = %d;',
                            [self.Name, I, self.Panels.items[i].Width])
                Else
                Begin
                    If self.Panels.items[i].Width = -1 Then
                        min1used := True;

                    Result := Result + #13 + Format('%s_Widths[%d] = %d;',
                        [self.Name, I, self.Panels.items[i].Width]);
                End;
            // for loop end

            Result := Result + #13 + Format('%s->SetStatusWidths(%d,%s_Widths);',
                [self.Name, self.Panels.Count, self.Name]);

        End;
    End; //not xrcgen

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


  //strColorStr:=GetWxFontDeclaration(self.Font);
  //if strColorStr <> '' then
  //Result:=Result+#13+Format('%s->SetFont(%s);',[self.Name,strColorStr]);
    If Not (XRCGEN) Then //NUKLEAR ZELPH
        If (self.Parent Is TWxSizerPanel) Then
        Begin
            strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
            Result := Result + #13 + Format('%s->Add(%s, %d, %s, %d);',
                [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
                self.Wx_Border]);
        End;

End;

Function TWxStatusBar.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
End;

Function TWxStatusBar.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/statusbr.h>';
End;

Function TWxStatusBar.GenerateImageInclude: String;
Begin
    Result := '';
End;

Function TWxStatusBar.GetEventList: TStringList;
Begin
    Result := FWx_EventList;
End;

Function TWxStatusBar.GetIDName: String;
Begin
    Result := '';
    Result := wx_IDName;
End;

Function TWxStatusBar.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxStatusBar.GetParameterFromEventName(EventName: String): String;
Begin
    Result := '';
End;

Function TWxStatusBar.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxStatusBar.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxStatusBar.GetTypeFromEventName(EventName: String): String;
Begin
    Result := '';
End;

Function TWxStatusBar.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxStatusBar.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxStatusBar.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxStatusBar.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxStatusBar.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxStatusBar';
    Result := wx_Class;
End;

Procedure TWxStatusBar.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxStatusBar.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxStatusBar.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxStatusBar.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxStatusBar.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxStatusBar.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxStatusBar.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxStatusBar.GetFGColor: String;
Begin
    Result := FInvisibleFGColorString;
End;

Procedure TWxStatusBar.SetFGColor(strValue: String);
Begin
    FInvisibleFGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Font.Color := defaultFGColor
    Else
        self.Font.Color := GetColorFromString(strValue);
End;

Function TWxStatusBar.GetBGColor: String;
Begin
    Result := FInvisibleBGColorString;
End;

Procedure TWxStatusBar.SetBGColor(strValue: String);
Begin
    FInvisibleBGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Color := defaultBGColor
    Else
        self.Color := GetColorFromString(strValue);
End;

Procedure TWxStatusBar.SetProxyFGColorString(Value: String);
Begin
    FInvisibleFGColorString := Value;
    self.Color := GetColorFromString(Value);
End;

Procedure TWxStatusBar.SetProxyBGColorString(Value: String);
Begin
    FInvisibleBGColorString := Value;
    self.Font.Color := GetColorFromString(Value);
End;

Function TWxStatusBar.GenerateLastCreationCode: String;
Begin
    Result := '';
End;

End.
