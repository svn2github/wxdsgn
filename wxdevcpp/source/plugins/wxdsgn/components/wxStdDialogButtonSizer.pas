//******************************************************************
//
// Name:        components/wxStdDialogButtonSizer.pas
// Author:      Joel Low
// Modified:    19th November 2006, 4:33 PM
// Description: wxStdDialogButtonSizer implementation
//
//******************************************************************

Unit wxStdDialogButtonSizer;

Interface

Uses Classes, WinProcs, Messages, WinTypes, SysUtils, StdCtrls, Forms, Controls,
    wxUtils, WxSizerPanel;

Type
    TWxStdDialogButtonSizer = Class(TWxSizerPanel, IWxComponentInterface)
    Private
        FWx_Border: Integer;
        FWx_Class: String;
        FWx_EventList: TStringList;
        FWx_IDName: String;
        FWx_IDValue: Integer;
        FWx_StretchFactor: Integer;
        FWx_PropertyList: TStringList;
        FWx_Buttons: TWxStdDialogButtons;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;
        FInvisibleBGColorString: String;
        FInvisibleFGColorString: String;

        FEVT_OK_BUTTON: String;
        FEVT_OK_UPDATE_UI: String;
        FEVT_YES_BUTTON: String;
        FEVT_YES_UPDATE_UI: String;
        FEVT_SAVE_BUTTON: String;
        FEVT_SAVE_UPDATE_UI: String;
        FEVT_APPLY_BUTTON: String;
        FEVT_APPLY_UPDATE_UI: String;
        FEVT_NO_BUTTON: String;
        FEVT_NO_UPDATE_UI: String;
        FEVT_CANCEL_BUTTON: String;
        FEVT_CANCEL_UPDATE_UI: String;
        FEVT_HELP_BUTTON: String;
        FEVT_HELP_UPDATE_UI: String;
        FEVT_CONTEXT_HELP_BUTTON: String;
        FEVT_CONTEXT_HELP_UPDATE_UI: String;

    { Private methods of TWxStdDialogButtonSizer }
        Procedure AutoInitialize;
        Procedure AutoDestroy;
        Procedure SetWx_EventList(Value: TStringList);
        Procedure SetWx_Buttons(Buttons: TWxStdDialogButtons);

    Protected
    { Protected methods of TWxStdDialogButtonSizer }
        Procedure WMPaint(Var Message: TWMPaint); Message WM_PAINT;

    Public
    { Public methods of TWxStdDialogButtonSizer }
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

        Function GenerateLastCreationCode: String;
        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

    Published
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
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_EventList: TStringList Read FWx_EventList Write SetWx_EventList;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue Default -1;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_Buttons: TWxStdDialogButtons Read FWx_Buttons Write SetWx_Buttons;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;

        Property InvisibleBGColorString: String Read FInvisibleBGColorString Write FInvisibleBGColorString;
        Property InvisibleFGColorString: String Read FInvisibleFGColorString Write FInvisibleFGColorString;

        Property EVT_OK_BUTTON: String Read FEVT_OK_BUTTON Write FEVT_OK_BUTTON;
        Property EVT_OK_UPDATE_UI: String Read FEVT_OK_UPDATE_UI Write FEVT_OK_UPDATE_UI;
        Property EVT_YES_BUTTON: String Read FEVT_YES_BUTTON Write FEVT_YES_BUTTON;
        Property EVT_YES_UPDATE_UI: String Read FEVT_YES_UPDATE_UI Write FEVT_YES_UPDATE_UI;
        Property EVT_SAVE_BUTTON: String Read FEVT_SAVE_BUTTON Write FEVT_SAVE_BUTTON;
        Property EVT_SAVE_UPDATE_UI: String Read FEVT_SAVE_UPDATE_UI Write FEVT_SAVE_UPDATE_UI;
        Property EVT_APPLY_BUTTON: String Read FEVT_APPLY_BUTTON Write FEVT_APPLY_BUTTON;
        Property EVT_APPLY_UPDATE_UI: String Read FEVT_APPLY_UPDATE_UI Write FEVT_APPLY_UPDATE_UI;
        Property EVT_NO_BUTTON: String Read FEVT_NO_BUTTON Write FEVT_NO_BUTTON;
        Property EVT_NO_UPDATE_UI: String Read FEVT_NO_UPDATE_UI Write FEVT_NO_UPDATE_UI;
        Property EVT_CANCEL_BUTTON: String Read FEVT_CANCEL_BUTTON Write FEVT_CANCEL_BUTTON;
        Property EVT_CANCEL_UPDATE_UI: String Read FEVT_CANCEL_UPDATE_UI Write FEVT_CANCEL_UPDATE_UI;
        Property EVT_HELP_BUTTON: String Read FEVT_HELP_BUTTON Write FEVT_HELP_BUTTON;
        Property EVT_HELP_UPDATE_UI: String Read FEVT_HELP_UPDATE_UI Write FEVT_HELP_UPDATE_UI;
        Property EVT_CONTEXT_HELP_BUTTON: String Read FEVT_CONTEXT_HELP_BUTTON Write FEVT_CONTEXT_HELP_BUTTON;
        Property EVT_CONTEXT_HELP_UPDATE_UI: String Read FEVT_CONTEXT_HELP_UPDATE_UI Write FEVT_CONTEXT_HELP_UPDATE_UI;

    End;

Implementation

Procedure TWxStdDialogButtonSizer.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Border := 5;
    FWx_Class := 'wxStdDialogButtonSizer';
    FWx_EventList := TStringList.Create;
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    Wx_Buttons := [wxID_OK, wxID_CANCEL];
    FWx_IDValue := -1;
    ControlStyle := [];
End;

Procedure TWxStdDialogButtonSizer.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_EventList.Destroy;
End;

Procedure TWxStdDialogButtonSizer.SetWx_EventList(Value: TStringList);
Begin
    FWx_EventList.Assign(Value);
End;

Constructor TWxStdDialogButtonSizer.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);
    AutoInitialize;

    FWx_PropertyList.add('Name:Name');
    FWx_PropertyList.add('Orientation:Orientation');

    FWx_PropertyList.add('Wx_StretchFactor:Stretch Factor');
    FWx_PropertyList.add('Wx_Alignment:Alignment');
    FWx_PropertyList.Add('wxALIGN_LEFT:wxALIGN_LEFT');
    FWx_PropertyList.Add('wxALIGN_RIGHT:wxALIGN_RIGHT');
    FWx_PropertyList.Add('wxALIGN_TOP:wxALIGN_TOP');
    FWx_PropertyList.Add('wxALIGN_BOTTOM:wxALIGN_BOTTOM');
    FWx_PropertyList.Add('wxALIGN_CENTER:wxALIGN_CENTER');
    FWx_PropertyList.Add('wxALIGN_CENTER_HORIZONTAL:wxALIGN_CENTER_HORIZONTAL');
    FWx_PropertyList.Add('wxALIGN_CENTER_VERTICAL:wxALIGN_CENTER_VERTICAL');
    FWx_PropertyList.Add('wxEXPAND:wxEXPAND');
    FWx_PropertyList.add('Wx_Border:Border');
    FWx_PropertyList.add('Wx_BorderAlignment:Borders');
    FWx_PropertyList.add('wxALL:wxALL');
    FWx_PropertyList.add('wxTOP:wxTOP');
    FWx_PropertyList.add('wxLEFT:wxLEFT');
    FWx_PropertyList.add('wxRIGHT:wxRIGHT');
    FWx_PropertyList.add('wxBOTTOM:wxBOTTOM');

    FWx_PropertyList.add('Wx_Buttons:Buttons');
    FWx_PropertyList.add('wxID_OK:wxID_OK');
    FWx_PropertyList.add('wxID_YES:wxID_YES');
    FWx_PropertyList.add('wxID_SAVE:wxID_SAVE');
    FWx_PropertyList.add('wxID_APPLY:wxID_APPLY');
    FWx_PropertyList.add('wxID_NO:wxID_NO');
    FWx_PropertyList.add('wxID_CANCEL:wxID_CANCEL');
    FWx_PropertyList.add('wxID_HELP:wxID_HELP');
    FWx_PropertyList.add('wxID_CONTEXT_HELP:wxID_CONTEXT_HELP');

    FWx_EventList.add('EVT_OK_BUTTON:OnOkClick');
    FWx_EventList.add('EVT_OK_UPDATE_UI:OnOkUpdateUI');
    FWx_EventList.add('EVT_YES_BUTTON:OnYesClick');
    FWx_EventList.add('EVT_YES_UPDATE_UI:OnYesUpdateUI');
    FWx_EventList.add('EVT_SAVE_BUTTON:OnSaveClick');
    FWx_EventList.add('EVT_SAVE_UPDATE_UI:OnSaveUpdateUI');
    FWx_EventList.add('EVT_APPLY_BUTTON:OnApplyClick');
    FWx_EventList.add('EVT_APPLY_UPDATE_UI:OnApplyUpdateUI');
    FWx_EventList.add('EVT_NO_BUTTON:OnNoClick');
    FWx_EventList.add('EVT_NO_UPDATE_UI:OnNoUpdateUI');
    FWx_EventList.add('EVT_CANCEL_BUTTON:OnCancelClick');
    FWx_EventList.add('EVT_CANCEL_UPDATE_UI:OnCancelUpdateUI');
    FWx_EventList.add('EVT_HELP_BUTTON:OnHelpClick');
    FWx_EventList.add('EVT_HELP_UPDATE_UI:OnHelpUpdateUI');
    FWx_EventList.add('EVT_CONTEXT_HELP_BUTTON:OnContextHelpClick');
    FWx_EventList.add('EVT_CONTEXT_HELP_UPDATE_UI:OnContextHelpUpdateUI');

End;

Destructor TWxStdDialogButtonSizer.Destroy;
Begin
    AutoDestroy;
    Inherited Destroy;
End;

Function TWxStdDialogButtonSizer.GenerateXRCControlCreation(IndentString: String): TStringList;
Var
    i: Integer;
    wxcompInterface: IWxComponentInterface;
    tempstring: TStringList;
Begin
    Result := TStringList.Create;
  //NUKLEAR ZELPH no creation without sizer parent, check unneded
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
        [self.Wx_Class, self.Name]));

    If wxID_OK In Wx_Buttons Then
    Begin
        Result.Add(IndentString + '  <object class="button">');
        Result.Add(IndentString + '  <flag>' + SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment) + '</flag>');
        Result.Add(IndentString + '  <border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
        Result.Add(IndentString + '    <object class="wxButton" name="wxID_OK">');
        Result.Add(IndentString + '    <label>&amp;Ok</label>');
        Result.Add(IndentString + '    </object>');
        Result.Add(IndentString + '  </object>');
    End

    Else
    If wxID_YES In Wx_Buttons Then
    Begin
        Result.Add(IndentString + '  <object class="button">');
        Result.Add(IndentString + '  <flag>' + SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment) + '</flag>');
        Result.Add(IndentString + '  <border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
        Result.Add(IndentString + '    <object class="wxButton" name="wxID_YES">');
        Result.Add(IndentString + '    <label>&amp;Yes</label>');
        Result.Add(IndentString + '    </object>');
        Result.Add(IndentString + '  </object>');
    End

    Else
    If wxID_SAVE In Wx_Buttons Then
    Begin
        Result.Add(IndentString + '  <object class="button">');
        Result.Add(IndentString + '  <flag>' + SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment) + '</flag>');
        Result.Add(IndentString + '  <border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
        Result.Add(IndentString + '    <object class="wxButton" name="wxID_SAVE">');
        Result.Add(IndentString + '    <label>&amp;Save</label>');
        Result.Add(IndentString + '    </object>');
        Result.Add(IndentString + '  </object>');
    End;

    If wxID_APPLY In Wx_Buttons Then
    Begin
        Result.Add(IndentString + '  <object class="button">');
        Result.Add(IndentString + '  <flag>' + SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment) + '</flag>');
        Result.Add(IndentString + '  <border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
        Result.Add(IndentString + '    <object class="wxButton" name="wxID_APPLY">');
        Result.Add(IndentString + '    <label>&amp;Apply</label>');
        Result.Add(IndentString + '    </object>');
        Result.Add(IndentString + '  </object>');
    End;

    If wxID_NO In Wx_Buttons Then
    Begin
        Result.Add(IndentString + '  <object class="button">');
        Result.Add(IndentString + '  <flag>' + SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment) + '</flag>');
        Result.Add(IndentString + '  <border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
        Result.Add(IndentString + '    <object class="wxButton" name="wxID_NO">');
        Result.Add(IndentString + '    <label>&amp;No</label>');
        Result.Add(IndentString + '    </object>');
        Result.Add(IndentString + '  </object>');
    End;

    If wxID_CANCEL In Wx_Buttons Then
    Begin
        Result.Add(IndentString + '  <object class="button">');
        Result.Add(IndentString + '  <flag>' + SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment) + '</flag>');
        Result.Add(IndentString + '  <border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
        Result.Add(IndentString + '    <object class="wxButton" name="wxID_CANCEL">');
        Result.Add(IndentString + '    <label>&amp;Cancel</label>');
        Result.Add(IndentString + '    </object>');
        Result.Add(IndentString + '  </object>');
    End;

    If wxID_HELP In Wx_Buttons Then
    Begin
        Result.Add(IndentString + '  <object class="button">');
        Result.Add(IndentString + '  <flag>' + SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment) + '</flag>');
        Result.Add(IndentString + '  <border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
        Result.Add(IndentString + '    <object class="wxButton" name="wxID_HELP">');
        Result.Add(IndentString + '    <label>&amp;Help</label>');
        Result.Add(IndentString + '    </object>');
        Result.Add(IndentString + '  </object>');
    End

    Else
    If wxID_CONTEXT_HELP In Wx_Buttons Then
    Begin
        Result.Add(IndentString + '  <object class="button">');
        Result.Add(IndentString + '  <flag>' + SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment) + '</flag>');
        Result.Add(IndentString + '  <border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
        Result.Add(IndentString + '    <object class="wxButton" name="wxID_CONTEXT_HELP">');
        Result.Add(IndentString + '    <label>?</label>');
        Result.Add(IndentString + '    </object>');
        Result.Add(IndentString + '  </object>');
    End;

   //NUKLEAR ZELPH no creation without sizer parent, check unneeded
    Result.Add(IndentString + '</object>');
End;

Function TWxStdDialogButtonSizer.GenerateGUIControlCreation: String;
Var
    strAlignment: String;
Begin

    If trim(Result) <> '' Then
        Result := Result + #13;

    If Not (XRCGEN) Then //Nuklear Zelph
    Begin
  //Create the sizer
        Result := Format('%s = new %s;', [self.Name, self.wx_Class]);
        If wxID_OK In FWx_Buttons Then
        Begin
            Result := Result + #13 + 'btnOK = new wxButton( this, wxID_OK );';
            Result := Result + #13 + Format('%s->AddButton( btnOK );', [self.Name]);
        End
        Else
        If wxID_YES In FWx_Buttons Then
        Begin
            Result := Result + #13 + 'btnYES = new wxButton( this, wxID_YES );';
            Result := Result + #13 + Format('%s->AddButton( btnYES );', [self.Name]);
        End
        Else
        If wxID_SAVE In FWx_Buttons Then
        Begin
            Result := Result + #13 + 'btnSAVE = new wxButton( this, wxID_SAVE );';
            Result := Result + #13 + Format('%s->AddButton( btnSAVE );', [self.Name]);
        End;

        If wxID_APPLY In FWx_Buttons Then
        Begin
            Result := Result + #13 + 'btnAPPLY = new wxButton( this, wxID_APPLY );';
            Result := Result + #13 + Format('%s->AddButton( btnAPPLY );', [self.Name]);
        End;

        If wxID_NO In FWx_Buttons Then
        Begin
            Result := Result + #13 + 'btnNO = new wxButton( this, wxID_NO );';
            Result := Result + #13 + Format('%s->AddButton( btnNO );', [self.Name]);
        End;

        If wxID_CANCEL In FWx_Buttons Then
        Begin
            Result := Result + #13 + 'btnCANCEL = new wxButton( this, wxID_CANCEL );';
            Result := Result + #13 + Format('%s->AddButton( btnCANCEL );', [self.Name]);
        End;

        If wxID_HELP In FWx_Buttons Then
        Begin
            Result := Result + #13 + 'btnHELP = new wxButton( this, wxID_HELP );';
            Result := Result + #13 + Format('%s->AddButton( btnHELP );', [self.Name]);
        End

        Else
        If wxID_CONTEXT_HELP In FWx_Buttons Then
        Begin
            Result := Result + #13 + 'btnCtxHELP = new wxButton( this, wxID_CONTEXT_HELP );';
            Result := Result + #13 + Format('%s->AddButton( btnCtxHELP );', [self.Name]);
        End;
        Result := Result + #13 + Format('%s->Realize();', [self.Name]);

  //Add the sizer unto our global sizer
        strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
        Result := Result + #13 + Format('%s->Add(%s, %d, %s, %d);',
            [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
            self.Wx_Border]);
    End;//Nuklear Zelph
End;

Procedure TWxStdDialogButtonSizer.SetWx_Buttons(Buttons: TWxStdDialogButtons);
    Procedure CreateButton(capt: String);
    Var
        Button: TButton;
    Begin
        Button := TButton.Create(Self);
        Button.Parent := Self;
        Button.Caption := capt;
        Button.Height := 23;
        Button.Show;
    End;
Begin
  //Set the buttons
    FWx_Buttons := Buttons;

  //Clear the current buttons that we have
    While ControlCount > 0 Do
        Controls[0].Destroy;

  //Then add the buttons. Buttons are always added affirmative, negative, cancel,
  //apply the help under Windows.
    If wxID_OK In Buttons Then
        CreateButton('OK')
    Else
    Begin
        If wxID_YES In Buttons Then
            CreateButton('Yes')
        Else
        If wxID_SAVE In Buttons Then
            CreateButton('Save');
    End;

    If wxID_NO In Buttons Then
        CreateButton('No');
    If wxID_CANCEL In Buttons Then
        CreateButton('Cancel');
    If wxID_APPLY In Buttons Then
        CreateButton('Apply');

    If wxID_HELP In Buttons Then
        CreateButton('Help')
    Else
    If wxID_CONTEXT_HELP In Buttons Then
        CreateButton('?');

  //Force a redraw
    Refresh;
    Update;
End;

Function TWxStdDialogButtonSizer.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxStdDialogButtonSizer.GenerateControlIDs: String;
Begin
    Result := '';
End;

Function TWxStdDialogButtonSizer.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';

    If wxID_OK In FWx_Buttons Then
    Begin
        If trim(EVT_OK_BUTTON) <> '' Then
            Result := Format('EVT_BUTTON(%s, %s::%s)', ['wxID_OK', CurrClassName,
                EVT_OK_BUTTON]) + '';

        If trim(EVT_OK_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
                ['wxID_OK', CurrClassName, EVT_OK_UPDATE_UI]) + '';
    End
    Else
    If wxID_YES In FWx_Buttons Then
    Begin
        If trim(EVT_YES_BUTTON) <> '' Then
        Begin
            If trim(Result) <> '' Then
                Result := Result + #13;

            Result := Result + Format('EVT_BUTTON(%s, %s::%s)', ['wxID_YES', CurrClassName,
                EVT_YES_BUTTON]) + '';
        End;

        If trim(EVT_YES_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
                ['wxID_YES', CurrClassName, EVT_YES_UPDATE_UI]) + '';
    End
    Else
    If wxID_SAVE In FWx_Buttons Then
    Begin
        If trim(EVT_SAVE_BUTTON) <> '' Then
        Begin
            If trim(Result) <> '' Then
                Result := Result + #13;

            Result := Result + Format('EVT_BUTTON(%s, %s::%s)', ['wxID_SAVE', CurrClassName,
                EVT_SAVE_BUTTON]) + '';
        End;

        If trim(EVT_YES_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
                ['wxID_SAVE', CurrClassName, EVT_SAVE_UPDATE_UI]) + '';
    End;

    If wxID_APPLY In FWx_Buttons Then
    Begin
        If trim(EVT_APPLY_BUTTON) <> '' Then
        Begin
            If trim(Result) <> '' Then
                Result := Result + #13;

            Result := Result + Format('EVT_BUTTON(%s, %s::%s)', ['wxID_APPLY', CurrClassName,
                EVT_APPLY_BUTTON]) + '';
        End;

        If trim(EVT_APPLY_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
                ['wxID_APPLY', CurrClassName, EVT_APPLY_UPDATE_UI]) + '';
    End;

    If wxID_NO In FWx_Buttons Then
    Begin
        If trim(EVT_NO_BUTTON) <> '' Then
        Begin
            If trim(Result) <> '' Then
                Result := Result + #13;

            Result := Result + Format('EVT_BUTTON(%s, %s::%s)', ['wxID_NO', CurrClassName,
                EVT_NO_BUTTON]) + '';
        End;

        If trim(EVT_NO_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
                ['wxID_NO', CurrClassName, EVT_NO_UPDATE_UI]) + '';
    End;

    If wxID_CANCEL In FWx_Buttons Then
    Begin
        If trim(EVT_CANCEL_BUTTON) <> '' Then
        Begin
            If trim(Result) <> '' Then
                Result := Result + #13;

            Result := Result + Format('EVT_BUTTON(%s, %s::%s)', ['wxID_CANCEL', CurrClassName,
                EVT_CANCEL_BUTTON]) + '';
        End;

        If trim(EVT_CANCEL_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
                ['wxID_CANCEL', CurrClassName, EVT_CANCEL_UPDATE_UI]) + '';
    End;

    If wxID_HELP In FWx_Buttons Then
    Begin
        If trim(EVT_HELP_BUTTON) <> '' Then
        Begin
            If trim(Result) <> '' Then
                Result := Result + #13;

            Result := Result + Format('EVT_BUTTON(%s, %s::%s)', ['wxID_HELP', CurrClassName,
                EVT_HELP_BUTTON]) + '';
        End;
        If trim(EVT_HELP_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
                ['wxID_HELP', CurrClassName, EVT_HELP_UPDATE_UI]) + '';
    End

    Else
    If wxID_CONTEXT_HELP In FWx_Buttons Then
    Begin
        If trim(EVT_CONTEXT_HELP_BUTTON) <> '' Then
        Begin
            If trim(Result) <> '' Then
                Result := Result + #13;

            Result := Result + Format('EVT_BUTTON(%s, %s::%s)', ['wxID_CONTEXT_HELP', CurrClassName,
                EVT_HELP_BUTTON]) + '';
        End;
        If trim(EVT_HELP_UPDATE_UI) <> '' Then
            Result := Result + #13 + Format('EVT_UPDATE_UI(%s, %s::%s)',
                ['wxID_CONTEXT_HELP', CurrClassName, EVT_HELP_UPDATE_UI]) + '';
    End;

End;

Function TWxStdDialogButtonSizer.GenerateGUIControlDeclaration: String;
Begin
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
    If wxID_OK In FWx_Buttons Then
    Begin
        Result := Result + #13 + 'wxButton *btnOK;';
    End
    Else
    If wxID_YES In FWx_Buttons Then
    Begin
        Result := Result + #13 + 'wxButton *btnYES;';
    End
    Else
    If wxID_SAVE In FWx_Buttons Then
    Begin
        Result := Result + #13 + 'wxButton *btnSAVE;';
    End;

    If wxID_APPLY In FWx_Buttons Then
    Begin
        Result := Result + #13 + 'wxButton *btnAPPLY;';
    End;

    If wxID_NO In FWx_Buttons Then
    Begin
        Result := Result + #13 + 'wxButton *btnNO;';
    End;

    If wxID_CANCEL In FWx_Buttons Then
    Begin
        Result := Result + #13 + 'wxButton *btnCANCEL;';
    End;

    If wxID_HELP In FWx_Buttons Then
    Begin
        Result := Result + #13 + 'wxButton *btnHELP;';
    End

    Else
    If wxID_CONTEXT_HELP In FWx_Buttons Then
    Begin
        Result := Result + #13 + 'wxButton *btnCtxHELP;';
    End;

End;

Function TWxStdDialogButtonSizer.GenerateHeaderInclude: String;
Begin
    Result := '#include <wx/sizer.h>';
End;

Function TWxStdDialogButtonSizer.GenerateImageInclude: String;
Begin
End;

Function TWxStdDialogButtonSizer.GetEventList: TStringList;
Begin
    Result := Wx_EventList;
End;

Function TWxStdDialogButtonSizer.GetIDName: String;
Begin
    Result := '';
End;

Function TWxStdDialogButtonSizer.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxStdDialogButtonSizer.GetParameterFromEventName(EventName: String): String;
Begin
    If EventName = 'EVT_BUTTON' Then
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

Function TWxStdDialogButtonSizer.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxStdDialogButtonSizer.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxStdDialogButtonSizer.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxStdDialogButtonSizer.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxStdDialogButtonSizer.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxStdDialogButtonSizer.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxStdDialogButtonSizer.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxStdDialogButtonSizer.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxStdDialogButtonSizer';
    Result := wx_Class;
End;

Procedure TWxStdDialogButtonSizer.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin
End;

Procedure TWxStdDialogButtonSizer.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxStdDialogButtonSizer.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxStdDialogButtonSizer.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxStdDialogButtonSizer.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Procedure TWxStdDialogButtonSizer.WMPaint(Var Message: TWMPaint);
Var
    maxHeight: Integer;
    totalmaxWidth: Integer;
    startX: Integer;
    i: Integer;
    coordTop: Integer;
    cntIntf: IWxContainerInterface;
    splitIntf: IWxSplitterInterface;
Begin
    totalmaxWidth := 0;
    maxHeight := 0;
    self.Caption := '';

    For i := 0 To self.ControlCount - 1 Do
    Begin
    //Calculate how much space this child component needs
        totalmaxWidth := totalmaxWidth + Controls[i].Width + 5;
        If Controls[i].Height > maxHeight Then
            maxHeight := Controls[i].Height;
    End;

  //Remove the extra 5 pixels at the end
    If totalmaxWidth > 0 Then
        totalmaxWidth := totalmaxWidth - 5;

    If self.parent.GetInterface(IDD_IWxContainerInterface, cntIntf) Then
    Begin
        If self.parent.GetInterface(IID_IWxSplitterInterface, splitIntf) Then
            self.Align := alNone
        Else
            self.Align := alClient;
    End
    Else
        self.Align := alNone;

    If totalmaxWidth = 0 Then
        self.Width := 20
    Else
        self.Width := totalmaxWidth;

    If maxHeight = 0 Then
        self.Height := 20
    Else
        self.Height := maxHeight;

  //Initialize the starting coordinates
    startX := 0;

    For i := 0 To self.ControlCount - 1 Do
    Begin
        If IsControlWxNonVisible(Controls[i]) Then
            continue;

    //Set the raw available width
        coordTop := maxHeight - self.Controls[i].Height;

    //Shift the controls
        self.Controls[i].Top := coordTop Div 2;
        self.Controls[i].left := startX;

    //Add the width to the total width
        startX := startX + self.Controls[i].Width + 5;
    End;

  //Fix the parent's height and width
    If Self.Height > parent.Height Then
        parent.Height := Self.Height;

    If Self.Width > parent.Width Then
        parent.Width := Self.Width;

  //Call the base class' paint handler
    Inherited;
End;

Function TWxStdDialogButtonSizer.GetGenericColor(strVariableName: String): String;
Begin
End;

Procedure TWxStdDialogButtonSizer.SetGenericColor(strVariableName, strValue: String);
Begin
End;

Function TWxStdDialogButtonSizer.GetFGColor: String;
Begin
End;

Procedure TWxStdDialogButtonSizer.SetFGColor(strValue: String);
Begin
End;

Function TWxStdDialogButtonSizer.GetBGColor: String;
Begin
End;

Procedure TWxStdDialogButtonSizer.SetBGColor(strValue: String);
Begin
End;

Function TWxStdDialogButtonSizer.GenerateLastCreationCode: String;
Begin
End;

End.
