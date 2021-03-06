 { ****************************************************************** }
 {                                                                    }
{ $Id: wxEdit.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
 {                                                                    }
{                                                                    }
{   Copyright � 2003-2007 by Guru Kathiresan                         }
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

Unit WxEdit;

Interface

Uses
    WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, Forms, Graphics,
    StdCtrls, WxUtils, ExtCtrls, wxAuiToolBar, WxToolbar, WxSizerPanel, WxAuiNotebookPage, JvEdit, UValidator;

Type
    TWxEdit = Class(TJvEdit, IWxComponentInterface, IWxToolBarInsertableInterface,
        IWxToolBarNonInsertableInterface, IWxVariableAssignmentInterface, IWxValidatorInterface)
    Private
    { Private fields of TWxEdit }
    { Storage for property EVT_TEXT }
        FEVT_TEXT: String;
    { Storage for property EVT_TEXT_ENTER }
        FEVT_TEXT_ENTER: String;
    { Storage for property EVT_TEXT_MAXLEN }
        FEVT_TEXT_MAXLEN: String;
    { Storage for property EVT_TEXT_URL }
        FEVT_TEXT_URL: String;
    { Storage for property EVT_UPDATE_UI }
        FEVT_UPDATE_UI: String;
    { Storage for property Wx_BGColor }
        FWx_BGColor: TColor;
    { Storage for property Wx_Border }
        FWx_Border: Integer;
    { Storage for property Wx_Class }
        FWx_Class: String;
    { Storage for property Wx_ControlOrientation }
        FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_EditStyle }
        FWx_EditStyle: TWxEdtGeneralStyleSet;
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
    { Storage for property Wx_IDName }
        FWx_IDName: String;
    { Storage for property Wx_IDValue }
        FWx_IDValue: Integer;
    { Storage for property Wx_ProxyBGColorString }
        FWx_ProxyBGColorString: TWxColorString;
        FWx_ProxyFGColorString: TWxColorString;
    { Storage for property Wx_StretchFactor }
        FWx_StretchFactor: Integer;
    { Storage for property Wx_ToolTip }
        FWx_ToolTip: String;
        FWx_Validator: String;
        FWx_ProxyValidatorString: TWxValidatorString;
        FWx_EventList: TStringList;
        FWx_PropertyList: TStringList;
        FInvisibleBGColorString: String;
        FInvisibleFGColorString: String;
        FWx_MaxLength: Integer;
        FWx_Comments: TStrings;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;
        FWx_LHSValue: String;
        FWx_RHSValue: String;

//Aui Properties
        FWx_AuiManaged: Boolean;
        FWx_PaneCaption: String;
        FWx_PaneName: String;
        FWx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem;
        FWx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet;
        FWx_Aui_Pane_Style: TwxAuiPaneStyleSet;
        FWx_Aui_Pane_Buttons: TwxAuiPaneButtonSet;
        FWx_BestSize_Height: Integer;
        FWx_BestSize_Width: Integer;
        FWx_MinSize_Height: Integer;
        FWx_MinSize_Width: Integer;
        FWx_MaxSize_Height: Integer;
        FWx_MaxSize_Width: Integer;
        FWx_Floating_Height: Integer;
        FWx_Floating_Width: Integer;
        FWx_Floating_X_Pos: Integer;
        FWx_Floating_Y_Pos: Integer;
        FWx_Layer: Integer;
        FWx_Row: Integer;
        FWx_Position: Integer;

    { Private methods of TWxEdit }
    { Method to set variable and property values and create objects }
        Procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
        Procedure AutoDestroy;
    { Read method for property Wx_EditStyle }
        Function GetWx_EditStyle: TWxEdtGeneralStyleSet;
    { Write method for property Wx_EditStyle }
        Procedure SetWx_EditStyle(Value: TWxEdtGeneralStyleSet);

    Protected
    { Protected fields of TWxEdit }

    { Protected methods of TWxEdit }
        Procedure Change; Override;
        Procedure Click; Override;
        Procedure KeyPress(Var Key: Char); Override;
        Procedure Loaded; Override;

    Public
    { Public fields and properties of TWxEdit }
        defaultBGColor: TColor;
        defaultFGColor: TColor;
    { Public methods of TWxEdit }
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

        Function GetValidator: String;
        Procedure SetValidator(value: String);
        Function GetValidatorString: TWxValidatorString;
        Procedure SetValidatorString(Value: TWxValidatorString);

        Function GetFGColor: String;
        Procedure SetFGColor(strValue: String);
        Function GetBGColor: String;
        Procedure SetBGColor(strValue: String);

        Function GetGenericColor(strVariableName: String): String;
        Procedure SetGenericColor(strVariableName, strValue: String);

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

        Procedure SetProxyFGColorString(Value: String);
        Procedure SetProxyBGColorString(Value: String);
        Procedure DummyToolBarInsertableInterfaceProcedure;
        Function GetLHSVariableAssignment: String;
        Function GetRHSVariableAssignment: String;

    Published
    { Published properties of TWxEdit }
        Property OnChange;
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
        Property EVT_TEXT: String Read FEVT_TEXT Write FEVT_TEXT;
        Property EVT_TEXT_ENTER: String Read FEVT_TEXT_ENTER Write FEVT_TEXT_ENTER;
        Property EVT_TEXT_MAXLEN: String Read FEVT_TEXT_MAXLEN Write FEVT_TEXT_MAXLEN;
        Property EVT_TEXT_URL: String Read FEVT_TEXT_URL Write FEVT_TEXT_URL;
        Property EVT_UPDATE_UI: String Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
        Property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_ControlOrientation: TWxControlOrientation
            Read FWx_ControlOrientation Write FWx_ControlOrientation;
    { TWxEdtGeneralStyleSet }
        Property Wx_EditStyle: TWxEdtGeneralStyleSet
            Read GetWx_EditStyle Write SetWx_EditStyle;
        Property Wx_Enabled: Boolean Read FWx_Enabled Write FWx_Enabled Default True;
        Property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
        Property Wx_GeneralStyle: TWxStdStyleSet
            Read FWx_GeneralStyle Write FWx_GeneralStyle;
        Property Wx_HelpText: String Read FWx_HelpText Write FWx_HelpText;
        Property Wx_Hidden: Boolean Read FWx_Hidden Write FWx_Hidden;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue Default -1;
        Property Wx_ProxyBGColorString: TWxColorString
            Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
        Property Wx_ProxyFGColorString: TWxColorString
            Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;

        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
        Property Wx_Validator: String Read FWx_Validator Write FWx_Validator;
        Property Wx_ProxyValidatorString: TWxValidatorString Read GetValidatorString Write SetValidatorString;
        Property Wx_ToolTip: String Read FWx_ToolTip Write FWx_ToolTip;

        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read FWx_StretchFactor Write FWx_StretchFactor Default 0;
        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];

        Property Wx_MaxLength: Integer Read FWx_MaxLength Write FWx_MaxLength;
        Property InvisibleBGColorString: String
            Read FInvisibleBGColorString Write FInvisibleBGColorString;
        Property InvisibleFGColorString: String
            Read FInvisibleFGColorString Write FInvisibleFGColorString;

        Property Wx_LHSValue: String Read FWx_LHSValue Write FWx_LHSValue;
        Property Wx_RHSValue: String Read FWx_RHSValue Write FWx_RHSValue;

//Aui Properties
        Property Wx_AuiManaged: Boolean Read FWx_AuiManaged Write FWx_AuiManaged Default False;
        Property Wx_PaneCaption: String Read FWx_PaneCaption Write FWx_PaneCaption;
        Property Wx_PaneName: String Read FWx_PaneName Write FWx_PaneName;
        Property Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem Read FWx_Aui_Dock_Direction Write FWx_Aui_Dock_Direction;
        Property Wx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet Read FWx_Aui_Dockable_Direction Write FWx_Aui_Dockable_Direction;
        Property Wx_Aui_Pane_Style: TwxAuiPaneStyleSet Read FWx_Aui_Pane_Style Write FWx_Aui_Pane_Style;
        Property Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet Read FWx_Aui_Pane_Buttons Write FWx_Aui_Pane_Buttons;
        Property Wx_BestSize_Height: Integer Read FWx_BestSize_Height Write FWx_BestSize_Height Default -1;
        Property Wx_BestSize_Width: Integer Read FWx_BestSize_Width Write FWx_BestSize_Width Default -1;
        Property Wx_MinSize_Height: Integer Read FWx_MinSize_Height Write FWx_MinSize_Height Default -1;
        Property Wx_MinSize_Width: Integer Read FWx_MinSize_Width Write FWx_MinSize_Width Default -1;
        Property Wx_MaxSize_Height: Integer Read FWx_MaxSize_Height Write FWx_MaxSize_Height Default -1;
        Property Wx_MaxSize_Width: Integer Read FWx_MaxSize_Width Write FWx_MaxSize_Width Default -1;
        Property Wx_Floating_Height: Integer Read FWx_Floating_Height Write FWx_Floating_Height Default -1;
        Property Wx_Floating_Width: Integer Read FWx_Floating_Width Write FWx_Floating_Width Default -1;
        Property Wx_Floating_X_Pos: Integer Read FWx_Floating_X_Pos Write FWx_Floating_X_Pos Default -1;
        Property Wx_Floating_Y_Pos: Integer Read FWx_Floating_Y_Pos Write FWx_Floating_Y_Pos Default -1;
        Property Wx_Layer: Integer Read FWx_Layer Write FWx_Layer Default 0;
        Property Wx_Row: Integer Read FWx_Row Write FWx_Row Default 0;
        Property Wx_Position: Integer Read FWx_Position Write FWx_Position Default 0;


    End;

Procedure Register;

Implementation

Procedure Register;
Begin
     { Register TWxEdit with wxWidgets as its
       default page on the Delphi component palette }
    RegisterComponents('wxWidgets', [TWxEdit]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxEdit.AutoInitialize;
Begin
    FWx_EventList := TStringList.Create;
    FWx_PropertyList := TStringList.Create;
    FWx_Border := 5;
    FWx_Class := 'wxTextCtrl';
    FWx_Enabled := True;
    fWX_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_IDValue := -1;
    FWx_StretchFactor := 0;
    FWx_ProxyBGColorString := TWxColorString.Create;
    FWx_ProxyFGColorString := TWxColorString.Create;
    FWx_ProxyValidatorString := TwxValidatorString.Create(self);
    defaultBGColor := self.color;
    defaultFGColor := self.font.color;
    BorderStyle := bsSingle;
    FWx_Comments := TStringList.Create;
    AutoSize := False;

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxEdit.AutoDestroy;
Begin
    FWx_Comments.Destroy;
    FWx_EventList.Destroy;
    FWx_PropertyList.Destroy;
    FWx_ProxyBGColorString.Destroy;
    FWx_ProxyFGColorString.Destroy;
    FWx_ProxyValidatorString.Destroy;
End; { of AutoDestroy }

{ Read method for property Wx_EditStyle }
Function TWxEdit.GetWx_EditStyle: TWxEdtGeneralStyleSet;
Begin
    Result := FWx_EditStyle;
End;

{ Write method for property Wx_EditStyle }
Procedure TWxEdit.SetWx_EditStyle(Value: TWxEdtGeneralStyleSet);
Begin

    FWx_EditStyle := GetRefinedWxEdtGeneralStyleValue(Value);
    If wxTE_PASSWORD In FWx_EditStyle Then
        PasswordChar := '*'
    Else
        PasswordChar := #0;

  // Change the text justification in the form designer
    If wxTE_CENTRE In Value Then
        self.Alignment := taCenter
    Else
    If wxTE_RIGHT In Value Then
        self.Alignment := taRightJustify
    Else
        self.Alignment := taLeftJustify;

End;

{ Override OnChange handler from TEdit,IWxComponentInterface }
Procedure TWxEdit.Change;
Begin
    Inherited Change;
End;

{ Override OnClick handler from TEdit,IWxComponentInterface }
Procedure TWxEdit.Click;
Begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
    Inherited Click;

     { Code to execute after click behavior
       of parent }

End;

{ Override OnKeyPress handler from TEdit,IWxComponentInterface }
Procedure TWxEdit.KeyPress(Var Key: Char);
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

Constructor TWxEdit.Create(AOwner: TComponent);
Begin
  { Call the Create method of the parent class }
    Inherited Create(AOwner);

  { AutoInitialize sets the initial values of variables and      }
  { properties; also, it creates objects for properties of       }
  { standard Delphi object types (e.g., TFont, TTimer,           }
  { TPicture) and for any variables marked as objects.           }
  { AutoInitialize method is generated by Component Create.      }
    AutoInitialize;
    FWx_EditStyle := [];
  { Code to perform other tasks when the component is created }
    PopulateGenericProperties(FWx_PropertyList);
    PopulateAuiGenericProperties(FWx_PropertyList);

    FWx_PropertyList.Add('Wx_EditStyle:Edit Style');
    FWx_PropertyList.Add('wxTE_PROCESS_ENTER:wxTE_PROCESS_ENTER');
    FWx_PropertyList.Add('wxTE_PROCESS_TAB:wxTE_PROCESS_TAB');
    FWx_PropertyList.Add('wxTE_PASSWORD:wxTE_PASSWORD');
    FWx_PropertyList.Add('wxTE_READONLY:wxTE_READONLY');
    FWx_PropertyList.Add('wxTE_MULTILINE:wxTE_MULTILINE');
    FWx_PropertyList.Add('wxTE_RICH:wxTE_RICH');
    FWx_PropertyList.Add('wxTE_RICH2:wxTE_RICH2');
    FWx_PropertyList.Add('wxTE_AUTO_URL:wxTE_AUTO_URL');
    FWx_PropertyList.Add('wxTE_NOHIDESEL:wxTE_NOHIDESEL');
    FWx_PropertyList.Add('wxTE_LEFT:wxTE_LEFT');
    FWx_PropertyList.Add('wxTE_CENTRE:wxTE_CENTRE');
    FWx_PropertyList.Add('wxTE_RIGHT:wxTE_RIGHT');
    FWx_PropertyList.Add('wxTE_LINEWRAP:wxTE_LINEWRAP');
    FWx_PropertyList.Add('wxTE_WORDWRAP:wxTE_WORDWRAP');
    FWx_PropertyList.Add('wxTE_DONTWRAP:wxTE_DONTWRAP');
    FWx_PropertyList.Add('wxTE_CHARWRAP:wxTE_CHARWRAP');
    FWx_PropertyList.Add('wxTE_BESTWRAP:wxTE_BESTWRAP');
    FWx_PropertyList.Add('wxTE_CAPITALIZE:wxTE_CAPITALIZE');

    FWx_PropertyList.add('Text:Text');
    FWx_PropertyList.add('Wx_MaxLength :MaxLength ');

    FWx_PropertyList.add('Wx_LHSValue   : LHS Variable');
    FWx_PropertyList.add('Wx_RHSValue   : RHS Variable');

    FWx_EventList.add('EVT_TEXT_ENTER:OnEnter');
    FWx_EventList.add('EVT_TEXT:OnUpdated');
    FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');
    FWx_EventList.add('EVT_TEXT_MAXLEN:OnMaxLen');
    FWx_EventList.add('EVT_TEXT_URL:OnClickUrl');

End;

Destructor TWxEdit.Destroy;
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


Function TWxEdit.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxEdit.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
End;

Function TWxEdit.GenerateEventTableEntries(CurrClassName: String): String;
Begin

    Result := '';

    If (XRCGEN) Then
    Begin//generate xrc loading code  needs to be edited
        If trim(EVT_TEXT_ENTER) <> '' Then
            Result := Format('EVT_TEXT_ENTER(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TEXT_ENTER]) + '';

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_UPDATE_UI]) + '';

        If trim(EVT_TEXT) <> '' Then
            Result := Result + #13 + Format('EVT_TEXT(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TEXT]) + '';

        If trim(EVT_TEXT_MAXLEN) <> '' Then
            Result := Result + #13 + Format('EVT_TEXT_MAXLEN(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TEXT_MAXLEN]) + '';

        If trim(EVT_TEXT_URL) <> '' Then
            Result := Result + #13 + Format('EVT_TEXT_URL(XRCID(%s("%s")),%s::%s)',
                [StringFormat, self.Name, CurrClassName, EVT_TEXT_URL]) + '';
    End
    Else
    Begin//generate the cpp code
        If trim(EVT_TEXT_ENTER) <> '' Then
            Result := Format('EVT_TEXT_ENTER(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_TEXT_ENTER]) + '';

        If trim(EVT_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

        If trim(EVT_TEXT) <> '' Then
            Result := Result + #13 + Format('EVT_TEXT(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_TEXT]) + '';

        If trim(EVT_TEXT_MAXLEN) <> '' Then
            Result := Result + #13 + Format('EVT_TEXT_MAXLEN(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_TEXT_MAXLEN]) + '';

        If trim(EVT_TEXT_URL) <> '' Then
            Result := Result + #13 + Format('EVT_TEXT_URL(%s,%s::%s)',
                [WX_IDName, CurrClassName, EVT_TEXT_URL]) + '';
    End;

End;

Function TWxEdit.GenerateXRCControlCreation(IndentString: String): TStringList;
Begin

    Result := TStringList.Create;

    Try
        Result.Add(IndentString + Format('<object class="%s" name="%s">',
            [self.Wx_Class, self.Name]));
        Result.Add(IndentString + Format('<IDident>%s</IDident>', [self.Wx_IDName]));
        Result.Add(IndentString + Format('<ID>%d</ID>', [self.Wx_IDValue]));

        If Not (UseDefaultSize) Then
            Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
        If Not (UseDefaultPos) Then
            Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

        Result.Add(IndentString + Format('<style>%s</style>',
            [GetEditSpecificStyle(self.Wx_GeneralStyle, self.Wx_EditStyle)]));
        Result.Add(IndentString + Format('<value>%s</value>', [XML_Label(self.Caption)]));
        Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxEdit.GenerateGUIControlCreation: String;
Var
    strColorStr: String;
    strStyle, parentName, strAlignment: String;
Begin
    Result := '';

    If FWx_PaneCaption = '' Then
        FWx_PaneCaption := Self.Name;
    If FWx_PaneName = '' Then
        FWx_PaneName := Self.Name + '_Pane';

    parentName := GetWxWidgetParent(self, Wx_AuiManaged);

    AutoSize := False;

    strStyle := GetEditSpecificStyle(self.Wx_GeneralStyle, self.Wx_EditStyle);

    If trim(Wx_ProxyValidatorString.strValidatorValue) <> '' Then
    Begin
        If trim(strStyle) <> '' Then
            strStyle := ', ' + strStyle + ', ' + Wx_ProxyValidatorString.strValidatorValue
        Else
            strStyle := ', 0, ' + Wx_ProxyValidatorString.strValidatorValue;

        strStyle := strStyle + ', ' + GetCppString(Name);

    End
    Else
    If trim(strStyle) <> '' Then
        strStyle := ', ' + strStyle + ', wxDefaultValidator, ' + GetCppString(Name)
    Else
        strStyle := ', 0, wxDefaultValidator, ' + GetCppString(Name);


    If (XRCGEN) Then
    Begin//generate xrc loading code
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
            [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);
        If FWx_PaneCaption = '' Then
            FWx_PaneCaption := Self.Name;
        If FWx_PaneName = '' Then
            FWx_PaneName := Self.Name + '_Pane';

        parentName := GetWxWidgetParent(self, Wx_AuiManaged);
    End
    Else
    Begin//generate the cpp code
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = new %s(%s, %s, %s, %s, %s%s);',
            [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
            self.Wx_IDValue),
            GetCppString(self.Text), GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);
    End;//end of if xrc

    If trim(self.Wx_ToolTip) <> '' Then
        Result := Result + #13 + Format('%s->SetToolTip(%s);',
            [self.Name, GetCppString(self.Wx_ToolTip)]);

    If self.Wx_MaxLength <> 0 Then
        Result := Result + #13 + Format('%s->SetMaxLength(%d);',
            [self.Name, self.Wx_MaxLength]);

    If self.Wx_Hidden Then
        Result := Result + #13 + Format('%s->Show(false);', [self.Name]);

    If Not Wx_Enabled Then
        Result := Result + #13 + Format('%s->Enable(false);', [self.Name]);

    If (trim(self.Wx_HelpText) <> '') Then
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
    Begin
        If (Wx_AuiManaged And FormHasAuiManager(self)) And Not (self.Parent Is TWxSizerPanel) Then
        Begin
            If HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) Then
            Begin
                Self.Wx_Aui_Pane_Style := Self.Wx_Aui_Pane_Style + [ToolbarPane]; //always make sure we are a toolbar
                Self.Wx_Layer := 10;
            End;

            If Not HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) Then
            Begin
                If (self.Parent.ClassName = 'TWxPanel') Then
                    If Not (self.Parent.Parent Is TForm) Then
                        Result := Result + #13 + Format('%s->Reparent(this);', [parentName]);
            End;

            If (self.Parent Is TWxAuiToolBar) Then
                Result := Result + #13 + Format('%s->AddControl(%s);',
                    [self.Parent.Name, self.Name])
            Else
                Result := Result + #13 + Format('%s->AddPane(%s, wxAuiPaneInfo()%s%s%s%s%s%s%s%s%s%s%s%s);',
                    [GetAuiManagerName(self), self.Name,
                    GetAuiPaneName(Self.Wx_PaneName),
                    GetAuiPaneCaption(Self.Wx_PaneCaption),
                    GetAuiDockDirection(Self.Wx_Aui_Dock_Direction),
                    GetAuiDockableDirections(self.Wx_Aui_Dockable_Direction),
                    GetAui_Pane_Style(Self.Wx_Aui_Pane_Style),
                    GetAui_Pane_Buttons(Self.Wx_Aui_Pane_Buttons),
                    GetAuiRow(Self.Wx_Row),
                    GetAuiPosition(Self.Wx_Position),
                    GetAuiLayer(Self.Wx_Layer),
                    GetAuiPaneBestSize(Self.Wx_BestSize_Width, Self.Wx_BestSize_Height),
                    GetAuiPaneMinSize(Self.Wx_MinSize_Width, Self.Wx_MinSize_Height),
                    GetAuiPaneMaxSize(Self.Wx_MaxSize_Width, Self.Wx_MaxSize_Height)]);

        End
        Else
        Begin
            If (self.Parent Is TWxSizerPanel) Then
            Begin
                strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
                Result := Result + #13 + Format('%s->Add(%s, %d, %s, %d);',
                    [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
                    self.Wx_Border]);
            End;

            If (self.Parent Is TWxAuiNotebookPage) Then
            Begin
        //        strParentLabel := TWxAuiNoteBookPage(Self.Parent).Caption;
                Result := Result + #13 + Format('%s->AddPage(%s, %s);',
          //          [self.Parent.Parent.Name, self.Name, GetCppString(strParentLabel)]);
                    [self.Parent.Parent.Name, self.Name, GetCppString(TWxAuiNoteBookPage(Self.Parent).Caption)]);
            End;

            If (self.Parent Is TWxAuiToolBar) Or (self.Parent Is TWxToolBar) Then
                Result := Result + #13 + Format('%s->AddControl(%s);',
                    [self.Parent.Name, self.Name]);
        End;
    End;

  // Set border style
    If wxSUNKEN_BORDER In self.Wx_GeneralStyle Then
    Begin
        self.BevelInner := bvLowered;
        self.BevelOuter := bvLowered;
        self.BevelKind := bkSoft;
    End
    Else
    If wxRAISED_BORDER In self.Wx_GeneralStyle Then
    Begin
        self.BevelInner := bvRaised;
        self.BevelOuter := bvRaised;
        self.BevelKind := bkSoft;
    End
    Else
    If wxNO_BORDER In self.Wx_GeneralStyle Then
    Begin
        self.BevelInner := bvNone;
        self.BevelOuter := bvNone;
        self.BevelKind := bkNone;
    End
    Else
    If wxDOUBLE_BORDER In self.Wx_GeneralStyle Then
    Begin
        self.BevelInner := bvSpace;
        self.BevelOuter := bvSpace;
        self.BevelKind := bkTile;
    End
    Else
    Begin
        self.BevelInner := bvNone;
        self.BevelOuter := bvNone;
        self.BevelKind := bkNone;
    End;

End;

Function TWxEdit.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [Self.wx_Class, Self.Name]);
End;

Function TWxEdit.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/textctrl.h>';
End;

Function TWxEdit.GenerateImageInclude: String;
Begin

End;

Function TWxEdit.GetEventList: TStringList;
Begin
    Result := FWx_EventList;
End;

Function TWxEdit.GetIDName: String;
Begin
    Result := '';
    Result := wx_IDName;
End;

Function TWxEdit.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxEdit.GetParameterFromEventName(EventName: String): String;
Begin
    If EventName = 'EVT_TEXT' Then
    Begin
        Result := 'wxCommandEvent& event';
        exit;
    End;
    If EventName = 'EVT_TEXT_MAXLEN' Then
    Begin
        Result := 'wxCommandEvent& event';
        exit;
    End;
    If EventName = 'EVT_TEXT_URL' Then
    Begin
        Result := 'wxTextUrlEvent& event';
        exit;
    End;
    If EventName = 'EVT_TEXT_ENTER' Then
    Begin
        Result := 'wxCommandEvent& event';
        exit;
    End;
    If EventName = 'EVT_UPDATE_UI' Then
    Begin
        Result := 'wxUpdateUIEvent& event';
        exit;
    End;
End;

Function TWxEdit.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxEdit.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxEdit.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxEdit.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxEdit.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxEdit.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxEdit.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxEdit.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxTextCtrl';

    Result := wx_Class;
End;

Procedure TWxEdit.Loaded;
Begin
    Inherited Loaded;
    BorderStyle := bsSingle;
End;

Procedure TWxEdit.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxEdit.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxEdit.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxEdit.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxEdit.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxEdit.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxEdit.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxEdit.GetFGColor: String;
Begin
    Result := FInvisibleFGColorString;
End;

Procedure TWxEdit.SetFGColor(strValue: String);
Begin
    FInvisibleFGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Font.Color := defaultFGColor
    Else
        self.Font.Color := GetColorFromString(strValue);
End;

Function TWxEdit.GetBGColor: String;
Begin
    Result := FInvisibleBGColorString;
End;

Procedure TWxEdit.SetBGColor(strValue: String);
Begin
    FInvisibleBGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Color := defaultBGColor
    Else
        self.Color := GetColorFromString(strValue);
End;

Procedure TWxEdit.SetProxyFGColorString(Value: String);
Begin
    FInvisibleFGColorString := Value;
    self.Color := GetColorFromString(Value);
End;

Procedure TWxEdit.SetProxyBGColorString(Value: String);
Begin
    FInvisibleBGColorString := Value;
    self.Font.Color := GetColorFromString(Value);
End;

Procedure TWxEdit.DummyToolBarInsertableInterfaceProcedure;
Begin

End;

Function TWxEdit.GetLHSVariableAssignment: String;
Var
    nPos: Integer;

Begin
    Result := '';
    If trim(Wx_LHSValue) = '' Then
        exit;
    nPos := pos('|', Wx_LHSValue);
    If (UpperCase(copy(Wx_LHSValue, 0, 2)) = 'F:') And (nPos <> -1) Then
    Begin
        Result := Format('%s = %s(%s->GetValue());', [copy(Wx_LHSValue, 3, nPos - 3), copy(Wx_LHSValue, nPos + 1, length(Wx_LHSValue)), self.Name]);
    End
    Else
        Result := Format('%s = %s->GetValue();', [Wx_LHSValue, self.Name]);
End;

Function TWxEdit.GetRHSVariableAssignment: String;
Begin
    Result := '';
    If trim(Wx_RHSValue) = '' Then
        exit;
    Result := Format('%s->SetValue(%s);', [self.Name, Wx_RHSValue]);
End;

Function TWxEdit.GetValidatorString: TWxValidatorString;
Begin
    Result := FWx_ProxyValidatorString;
    Result.FstrValidatorValue := Wx_Validator;
End;

Procedure TWxEdit.SetValidatorString(Value: TWxValidatorString);
Begin
    FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
    Wx_Validator := Value.FstrValidatorValue;
End;

Function TWxEdit.GetValidator: String;
Begin
    Result := Wx_Validator;
End;

Procedure TWxEdit.SetValidator(value: String);
Begin
    Wx_Validator := value;
End;

End.
