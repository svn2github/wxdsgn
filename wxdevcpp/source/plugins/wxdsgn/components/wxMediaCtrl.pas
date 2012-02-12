 { ****************************************************************** }
 {                                                                    }
{ $Id: wxMediaCtrl.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
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


Unit WxMediaCtrl;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, ExtCtrls, WxUtils, Wxcontrolpanel, WxAuiToolBar,
    WxAuiNotebookPage, WxSizerPanel, UValidator;

Type


    TWxMediaControlBackEndItem = (NONE, wxMEDIABACKEND_DIRECTSHOW, wxMEDIABACKEND_QUICKTIME,
        wxMEDIABACKEND_GSTREAMER, wxMEDIABACKEND_WMP10);
 //TWxMediaControlBackEndSet = set of TWxMediaControlBackEndItem;

    TWxMediaCtrl = Class(TWxControlPanel, IWxComponentInterface, IWxValidatorInterface)
    Private
        FEVT_MEDIA_STOP: String;
        FEVT_MEDIA_LOADED: String;
        FEVT_MEDIA_PLAY: String;
        FEVT_MEDIA_PAUSE: String;
        FEVT_MEDIA_FINISHED: String;

    { Private fields of TWxMediaCtrl }
    { Storage for property Picture }
        FPicture: TPicture;
    { Storage for property Wx_Border }
        FWx_Border: Integer;
    { Storage for property Wx_Class }
        FWx_Class: String;
    { Storage for property Wx_ControlOrientation }
        FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_Enabled }
        FWx_Enabled: Boolean;
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
    { Storage for property Wx_StretchFactor }
        FWx_StretchFactor: Integer;

        FWx_Control: TWxMediaCtrlControl;
        FWx_FileName: String;

        FWx_Validator: String;
        FWx_ProxyValidatorString: TWxValidatorString;

    { Storage for property Wx_ProxyBGColorString }
        FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
        FWx_ProxyFGColorString: TWxColorString;
        FWx_Comments: TStrings;
    { Storage for property Wx_ToolTip }
        FWx_ToolTip: String;
        FImage: TImage;
        FWx_PropertyList: TStringList;
        FWx_EventList: TStringList;
        FInvisibleBGColorString: String;
        FInvisibleFGColorString: String;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;

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

        FWx_Backend: TWxMediaControlBackEndItem;

    { Private methods of TWxMediaCtrl }
    { Method to set variable and property values and create objects }
        Procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
        Procedure AutoDestroy;
    { Read method for property Picture }
        Function GetPicture: TPicture;
    { Write method for property Picture }
        Procedure SetPicture(Value: TPicture);

    Protected
    { Protected fields of TWxMediaCtrl }

    { Protected methods of TWxMediaCtrl }
        Procedure Click; Override;
        Procedure KeyPress(Var Key: Char); Override;
        Procedure Loaded; Override;
        Procedure Paint; Override;

    Public
    { Public fields and properties of TWxMediaCtrl }
        defaultBGColor: TColor;
        defaultFGColor: TColor;
    { Public methods of TWxMediaCtrl }
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

        Procedure SetProxyFGColorString(Value: String);
        Procedure SetProxyBGColorString(Value: String);

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

        Function GetBackend(Wx_MediaBackend: TWxMediaControlBackEndItem): String;

    Published
    { Published properties of TWxMediaCtrl }
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
        Property OnResize;
        Property Picture: TPicture Read GetPicture Write SetPicture;
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_ControlOrientation: TWxControlOrientation Read FWx_ControlOrientation Write FWx_ControlOrientation;
        Property Wx_Enabled: Boolean Read FWx_Enabled Write FWx_Enabled Default True;
        Property Wx_GeneralStyle: TWxStdStyleSet
            Read FWx_GeneralStyle Write FWx_GeneralStyle;
        Property Wx_HelpText: String Read FWx_HelpText Write FWx_HelpText;
        Property Wx_Hidden: Boolean Read FWx_Hidden Write FWx_Hidden Default False;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue;
        Property Wx_ToolTip: String Read FWx_ToolTip Write FWx_ToolTip;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;

        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
        Property Wx_Control: TWxMediaCtrlControl Read FWx_Control Write FWx_Control;
        Property Wx_FileName: String Read FWx_FileName Write FWx_FileName;

        Property Wx_Validator: String Read FWx_Validator Write FWx_Validator;
        Property Wx_ProxyValidatorString: TWxValidatorString Read GetValidatorString Write SetValidatorString;

        Property Wx_Backend: TWxMediaControlBackEndItem Read FWx_Backend Write FWx_Backend;

        Property EVT_MEDIA_STOP: String Read FEVT_MEDIA_STOP Write FEVT_MEDIA_STOP;
        Property EVT_MEDIA_LOADED: String Read FEVT_MEDIA_LOADED Write FEVT_MEDIA_LOADED;
        Property EVT_MEDIA_PLAY: String Read FEVT_MEDIA_PLAY Write FEVT_MEDIA_PLAY;
        Property EVT_MEDIA_PAUSE: String Read FEVT_MEDIA_PAUSE Write FEVT_MEDIA_PAUSE;
        Property EVT_MEDIA_FINISHED: String Read FEVT_MEDIA_FINISHED Write FEVT_MEDIA_FINISHED;

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
     { Register TWxMediaCtrl with Standard as its
       default page on the Delphi component palette }
    RegisterComponents('Standard', [TWxMediaCtrl]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxMediaCtrl.AutoInitialize;
Begin
    FImage := TImage.Create(Self);
    FImage.Parent := Self;
    FWx_PropertyList := TStringList.Create;
    FWx_EventList := TStringList.Create;
    FPicture := TPicture.Create;
    FWx_Border := 5;
    FWx_Class := 'wxMediaCtrl';
    FWx_Hidden := False;
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_StretchFactor := 0;
    FWx_Control := wxMEDIACTRLPLAYERCONTROLS_NONE;
    FWx_ProxyBGColorString := TWxColorString.Create;
    FWx_ProxyFGColorString := TWxColorString.Create;
    defaultBGColor := self.color;
    defaultFGColor := self.font.color;
    FWx_Comments := TStringList.Create;
    FWx_ProxyValidatorString := TwxValidatorString.Create(self);

    FImage.Align := alClient;
    FImage.Center := True;
    FImage.Stretch := False;
    FImage.Picture.Bitmap.Handle := LoadBitmap(hInstance, 'MEDIAPLAYERIMG');
    self.Caption := '';
    self.Height := 150;
    self.Width := 150;
End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxMediaCtrl.AutoDestroy;
Begin
    FImage.Destroy;
    FWx_PropertyList.Destroy;
    FWx_EventList.Destroy;
    FWx_ProxyBGColorString.Destroy;
    FWx_ProxyFGColorString.Destroy;
    FPicture.Destroy;
    FWx_Comments.Destroy;
    FWx_ProxyValidatorString.Destroy;
End; { of AutoDestroy }

{ Read method for property Picture }
Function TWxMediaCtrl.GetPicture: TPicture;
Begin
    Result := FImage.Picture;
End;

{ Write method for property Picture }
Procedure TWxMediaCtrl.SetPicture(Value: TPicture);
Begin
     { Use Assign method because TPicture is an object type
       and FPicture has been created. }
    FImage.Picture.Assign(Value);

     { If changing this property affects the appearance of
       the component, call Invalidate here so the image will be
       updated. }
  { Invalidate; }

    If FImage.Picture.bitmap.handle <> 0 Then
    Begin
        self.Height := FImage.Picture.bitmap.Height;
        self.Width := FImage.Picture.bitmap.Width;
    End;
End;

{ Override OnClick handler from TWxControlPanel,IWxComponentInterface }
Procedure TWxMediaCtrl.Click;
Begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
    Inherited Click;

     { Code to execute after click behavior
       of parent }

End;

{ Override OnKeyPress handler from TWxControlPanel,IWxComponentInterface }
Procedure TWxMediaCtrl.KeyPress(Var Key: Char);
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

Constructor TWxMediaCtrl.Create(AOwner: TComponent);
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
    PopulateGenericProperties(FWx_PropertyList);
    PopulateAuiGenericProperties(FWx_PropertyList);

    FWx_PropertyList.add('Wx_FileName:File Name');
    FWx_PropertyList.add('Wx_Controls:Controls');
    FWx_PropertyList.add('wxMEDIACTRLPLAYERCONTROLS_NONE:wxMEDIACTRLPLAYERCONTROLS_NONE');
    FWx_PropertyList.add('wxMEDIACTRLPLAYERCONTROLS_STEP:wxMEDIACTRLPLAYERCONTROLS_STEP');
    FWx_PropertyList.add('wxMEDIACTRLPLAYERCONTROLS_VOLUME:wxMEDIACTRLPLAYERCONTROLS_VOLUME');

    FWx_PropertyList.add('Wx_Backend:Backend');
    FWx_PropertyList.add('NONE:NONE');
    FWx_PropertyList.add('wxMEDIABACKEND_DIRECTSHOW:wxMEDIABACKEND_DIRECTSHOW');
    FWx_PropertyList.add('wxMEDIABACKEND_QUICKTIME:wxMEDIABACKEND_QUICKTIME');
    FWx_PropertyList.add('wxMEDIABACKEND_GSTREAMER:wxMEDIABACKEND_GSTREAMER');
    FWx_PropertyList.add('wxMEDIABACKEND_WMP10:wxMEDIABACKEND_WMP10');

    FWx_EventList.add('EVT_MEDIA_STOP:OnMediaStop');
    FWx_EventList.add('EVT_MEDIA_LOADED:OnMediaLoaded');
    FWx_EventList.add('EVT_MEDIA_PLAY:OnMediaPlay');
    FWx_EventList.add('EVT_MEDIA_PAUSE:OnMediaPause');
    FWx_EventList.add('EVT_MEDIA_FINISHED:OnMediaFinished');

End;

Destructor TWxMediaCtrl.Destroy;
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

Function TWxMediaCtrl.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TWxMediaCtrl.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
End;

Function TWxMediaCtrl.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
    If trim(EVT_MEDIA_STOP) <> '' Then
        Result := Result + #13 + Format('EVT_MEDIA_STOP(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_MEDIA_STOP]) + '';

    If trim(EVT_MEDIA_LOADED) <> '' Then
        Result := Result + #13 + Format('EVT_MEDIA_LOADED(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_MEDIA_LOADED]) + '';

    If trim(EVT_MEDIA_PLAY) <> '' Then
        Result := Result + #13 + Format('EVT_MEDIA_PLAY(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_MEDIA_PLAY]) + '';

    If trim(EVT_MEDIA_PAUSE) <> '' Then
        Result := Result + #13 + Format('EVT_MEDIA_PAUSE(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_MEDIA_PAUSE]) + '';

    If trim(EVT_MEDIA_FINISHED) <> '' Then
        Result := Result + #13 + Format('EVT_MEDIA_FINISHED(%s,%s::%s)',
            [WX_IDName, CurrClassName, EVT_MEDIA_FINISHED]) + '';
End;

Function TWxMediaCtrl.GenerateXRCControlCreation(IndentString: String): TStringList;
Begin

    Result := TStringList.Create;

    Try
        Result.Add(IndentString + Format('<object class="%s" name="%s">',
            [self.Wx_Class, self.Name]));
        Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
        Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));

        If Not (UseDefaultSize) Then
            Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
        If Not (UseDefaultPos) Then
            Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

        Result.Add('<backend>' + GetBackend(Wx_Backend) + '</backend>');

        Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxMediaCtrl.GenerateGUIControlCreation: String;
Var
    strColorStr: String;
    strControlString: String;
    strStyle, parentName, strAlignment: String;
Begin
    Result := '';
    strStyle := GetStdStyleString(self.Wx_GeneralStyle);

    If (trim(strStyle) = '') Then
        strStyle := '0';

    strStyle := ', ' + strStyle + ', ' + GetBackend(Wx_Backend);

    If trim(Wx_ProxyValidatorString.strValidatorValue) <> '' Then
        strStyle := strStyle + ', ' + Wx_ProxyValidatorString.strValidatorValue
            + ', ' + GetCppString(Name)

    Else
        strStyle := strStyle + ', wxDefaultValidator, ' + GetCppString(Name);

    If FWx_PaneCaption = '' Then
        FWx_PaneCaption := Self.Name;
    If FWx_PaneName = '' Then
        FWx_PaneName := Self.Name + '_Pane';

    parentName := GetWxWidgetParent(self, Wx_AuiManaged);

    If Result <> '' Then
        Result := Result + #13 + Format(
            '%s = new %s(%s, %s, %s, %s, %s%s);',
            [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
            self.Wx_IDValue), GetCppString(Wx_FileName),
            GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle])
    Else
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = new %s(%s, %s, %s, %s, %s%s);',
            [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
            self.Wx_IDValue), GetCppString(Wx_FileName),
            GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);


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

    strColorStr := GetWxFontDeclaration(self.Font);
    If strColorStr <> '' Then
        Result := Result + #13 + Format('%s->SetFont(%s);', [self.Name, strColorStr]);

    strControlString := GetMediaCtrlStyle(wx_Control);
    If trim(strControlString) <> '' Then
        Result := Result + #13 + Format('%s->ShowPlayerControls(%s);', [self.Name, strControlString]);



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

            If (self.Parent Is TWxAuiToolBar) Then
                Result := Result + #13 + Format('%s->AddControl(%s);',
                    [self.Parent.Name, self.Name]);
        End;
    End;

End;

Function TWxMediaCtrl.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxMediaCtrl.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/mediactrl.h>';
End;

Function TWxMediaCtrl.GenerateImageInclude: String;
Begin
    Result := '';
End;

Function TWxMediaCtrl.GetEventList: TStringList;
Begin
    Result := FWx_EventList;
End;

Function TWxMediaCtrl.GetIDName: String;
Begin
    Result := wx_IDName;
End;

Function TWxMediaCtrl.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxMediaCtrl.GetParameterFromEventName(EventName: String): String;
Begin
    Result := '';
    If (EventName = 'EVT_MEDIA_STOP') Or (EventName = 'EVT_MEDIA_LOADED') Or (EventName = 'EVT_MEDIA_PLAY') Or
        (EventName = 'EVT_MEDIA_PAUSE') Or (EventName = 'EVT_MEDIA_FINISHED') Then
    Begin
        Result := 'wxMediaEvent& event';
        exit;
    End;
End;

Function TWxMediaCtrl.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxMediaCtrl.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxMediaCtrl.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxMediaCtrl.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxMediaCtrl.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxMediaCtrl.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxMediaCtrl.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxMediaCtrl.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxMediaCtrl';
    Result := wx_Class;
End;

Procedure TWxMediaCtrl.Loaded;
Begin
    Inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

End;

Procedure TWxMediaCtrl.Paint;
Begin
     { Make this component look like its parent component by calling
       its parent's Paint method. }
    Inherited Paint;

     { To change the appearance of the component, use the methods
       supplied by the component's Canvas property (which is of
       type TCanvas).  For example, }

  { Canvas.Rectangle(0, 0, Width, Height); }
    self.Caption := '';
    FImage.stretch := True;
End;

Procedure TWxMediaCtrl.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxMediaCtrl.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxMediaCtrl.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxMediaCtrl.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxMediaCtrl.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxMediaCtrl.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxMediaCtrl.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxMediaCtrl.GetValidatorString: TWxValidatorString;
Begin
    Result := FWx_ProxyValidatorString;
    Result.FstrValidatorValue := Wx_Validator;
End;

Procedure TWxMediaCtrl.SetValidatorString(Value: TWxValidatorString);
Begin
    FWx_ProxyValidatorString.FstrValidatorValue := Value.FstrValidatorValue;
    Wx_Validator := Value.FstrValidatorValue;
End;

Function TWxMediaCtrl.GetValidator: String;
Begin
    Result := Wx_Validator;
End;

Procedure TWxMediaCtrl.SetValidator(value: String);
Begin
    Wx_Validator := value;
End;

Function TWxMediaCtrl.GetFGColor: String;
Begin
    Result := FInvisibleFGColorString;
End;

Procedure TWxMediaCtrl.SetFGColor(strValue: String);
Begin
    FInvisibleFGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Font.Color := defaultFGColor
    Else
        self.Font.Color := GetColorFromString(strValue);
End;

Function TWxMediaCtrl.GetBGColor: String;
Begin
    Result := FInvisibleBGColorString;
End;

Procedure TWxMediaCtrl.SetBGColor(strValue: String);
Begin
    FInvisibleBGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Color := defaultBGColor
    Else
        self.Color := GetColorFromString(strValue);
End;

Procedure TWxMediaCtrl.SetProxyFGColorString(Value: String);
Begin
    FInvisibleFGColorString := Value;
    self.Color := GetColorFromString(Value);
End;

Procedure TWxMediaCtrl.SetProxyBGColorString(Value: String);
Begin
    FInvisibleBGColorString := Value;
    self.Font.Color := GetColorFromString(Value);
End;

Function TWxMediaCtrl.GetBackend(Wx_MediaBackend: TWxMediaControlBackEndItem): String;
Begin
    Result := '';

    If Wx_MediaBackend = wxMEDIABACKEND_DIRECTSHOW Then
    Begin
        Result := 'wxMEDIABACKEND_DIRECTSHOW';
    End;
    If Wx_MediaBackend = wxMEDIABACKEND_QUICKTIME Then
    Begin
        Result := 'wxMEDIABACKEND_QUICKTIME';
    End;
    If Wx_MediaBackend = wxMEDIABACKEND_GSTREAMER Then
    Begin
        Result := 'wxMEDIABACKEND_GSTREAMER';
    End;
    If Wx_MediaBackend = wxMEDIABACKEND_WMP10 Then
    Begin
        Result := 'wxMEDIABACKEND_WMP10';
    End;

    Result := GetCppString(Result);

End;

End.
