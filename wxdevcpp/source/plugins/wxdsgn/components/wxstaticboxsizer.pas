 { ****************************************************************** }
 {                                                                    }
{ $Id: wxstaticboxsizer.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
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

Unit WxStaticBoxSizer;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, ExtCtrls, WxUtils, WxSizerPanel, wxAuiManager;

Type
    TWxStaticBoxSizer = Class(TWxSizerPanel, IWxComponentInterface,
        IWxContainerAndSizerInterface)
    Private
    { Private fields of TWxStaticBoxSizer }
    { Storage for property Orientation }
        FOrientation: TWxSizerOrientation;
    { Storage for property Wx_Border }
        FWx_Border: Integer;
    { Storage for property Wx_Caption }
        FWx_Caption: String;
    { Storage for property Wx_Class }
        FWx_Class: String;
    { Storage for property Wx_ControlOrientation }
        FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_EventList }
        FWx_EventList: TStringList;
    { Storage for property Wx_IDName }
        FWx_IDName: String;
    { Storage for property Wx_IDValue }
        FWx_IDValue: Integer;
    { Storage for property Wx_StretchFactor }
        FWx_StretchFactor: Integer;
        FWx_PropertyList: TStringList;
        FInvisibleBGColorString: String;
        FInvisibleFGColorString: String;
        FWx_Comments: TStrings;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;

        RdGrp: TRadioGroup;

    { Private methods of TWxStaticBoxSizer }
    { Method to set variable and property values and create objects }
        Procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
        Procedure AutoDestroy;
    { Write method for property Wx_Caption }
        Procedure SetWx_Caption(Value: String);
    { Write method for property Wx_EventList }
        Procedure SetWx_EventList(Value: TStringList);

    Protected
    { Protected fields of TWxStaticBoxSizer }

    { Protected methods of TWxStaticBoxSizer }
        Procedure Click; Override;
        Procedure KeyPress(Var Key: Char); Override;
        Procedure Resize; Override;
        Procedure Loaded; Override;
        Procedure WMPaint(Var Message: TWMPaint); Message WM_PAINT;

    Public
    { Public fields and properties of TWxStaticBoxSizer }

    { Public methods of TWxStaticBoxSizer }
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
    { Published properties of TWxStaticBoxSizer }
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
        Property Orientation: TWxSizerOrientation
            Read FOrientation Write FOrientation Default wxHorizontal;
        Property Wx_Caption: String Read FWx_Caption Write SetWx_Caption;
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_ControlOrientation: TWxControlOrientation
            Read FWx_ControlOrientation Write FWx_ControlOrientation;
        Property Wx_EventList: TStringList Read FWx_EventList Write SetWx_EventList;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue Default -1;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;

        Property InvisibleBGColorString: String Read FInvisibleBGColorString Write FInvisibleBGColorString;
        Property InvisibleFGColorString: String Read FInvisibleFGColorString Write FInvisibleFGColorString;

        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
     { Register TWxStaticBoxSizer with wxTest as its
       default page on the Delphi component palette }
    RegisterComponents('wxTest', [TWxStaticBoxSizer]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxStaticBoxSizer.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    RdGrp := TRadioGroup.Create(Self);
    RdGrp.Parent := Self;
    FOrientation := wxHorizontal;
    FWx_Border := 5;
    FWx_Class := 'wxStaticBoxSizer';
    FWx_EventList := TStringList.Create;
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_IDValue := -1;
    FWx_StretchFactor := 0;
    FWx_Comments := TStringList.Create;
End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxStaticBoxSizer.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    RdGrp.Destroy;
    FWx_EventList.Destroy;
    FWx_Comments.Destroy;
End; { of AutoDestroy }

{ Write method for property Wx_Caption }
Procedure TWxStaticBoxSizer.SetWx_Caption(Value: String);
Begin
    FWx_Caption := Value;

     { If changing this property affects the appearance of
       the component, call Invalidate here so the image will be
       updated. }
  { Invalidate; }
    self.rdGrp.Caption := Value;
End;

{ Write method for property Wx_EventList }
Procedure TWxStaticBoxSizer.SetWx_EventList(Value: TStringList);
Begin
     { Use Assign method because TStringList is an object type
       and FWx_EventList has been created. }
    FWx_EventList.Assign(Value);

     { If changing this property affects the appearance of
       the component, call Invalidate here so the image will be
       updated. }
  { Invalidate; }
End;

{ Override OnClick handler from TWxSizerPanel,IWxComponentInterface }
Procedure TWxStaticBoxSizer.Click;
Begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
    Inherited Click;

     { Code to execute after click behavior
       of parent }

End;

{ Override OnKeyPress handler from TWxSizerPanel,IWxComponentInterface }
Procedure TWxStaticBoxSizer.KeyPress(Var Key: Char);
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

{ Override OnResize handler from TWxSizerPanel,IWxComponentInterface }
Procedure TWxStaticBoxSizer.Resize;
Begin
  { Parent's Resize method }
    Inherited Resize;

     { Code to perform other actions (e.g., resizing any sub-
       components) needed in response to change in size of this
       component }

End;

Constructor TWxStaticBoxSizer.Create(AOwner: TComponent);
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

    rdGrp.Align := alClient;
    rdGrp.Caption := '';

  { Code to perform other tasks when the container is created    }
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

    FWx_PropertyList.add('Name:Name');
    FWx_PropertyList.add('Orientation:Orientation');
    FWx_PropertyList.add('wx_Class:Base Class');
    FWx_PropertyList.add('Wx_Caption:Caption');
    FWx_PropertyList.add('Wx_Comments:Comments');
End;

Destructor TWxStaticBoxSizer.Destroy;
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

Function TWxStaticBoxSizer.GenerateEnumControlIDs: String;
Begin
    Result := '';
  //     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
  //        Result:=Format('%s = %d , ',[Wx_IDName,Wx_IDValue]);
End;

Function TWxStaticBoxSizer.GenerateControlIDs: String;
Begin
    Result := '';
  //     if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
  //        Result:=Format('#define %s %d ',[Wx_IDName,Wx_IDValue]);
End;

Function TWxStaticBoxSizer.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxStaticBoxSizer.GenerateXRCControlCreation(IndentString: String): TStringList;
Var
    strOrientation: String;
    i: Integer;
    wxcompInterface: IWxComponentInterface;
    tempstring: TStringList;
Begin

    Result := TStringList.Create;

    Try
        If (self.Parent Is TForm) Then //NUKLEAR ZELPH
        Begin
            Result.Add(IndentString + Format('<!--object class="%s" name="%s"-->',
                [self.Wx_Class, self.Name]));

            If Orientation = wxVertical Then
                strOrientation := 'wxVERTICAL'
            Else
                strOrientation := 'wxHORIZONTAL';

            Result.Add(IndentString + Format('  <!--orient>%s</orient-->', [strOrientation]));
            Result.Add(IndentString + Format('  <!--label>%s</label-->', [self.Wx_Caption]));
        End
        Else
        Begin
            Result.Add(IndentString + Format('<object class="%s" name="%s">',
                [self.Wx_Class, self.Name]));

            If Orientation = wxVertical Then
                strOrientation := 'wxVERTICAL'
            Else
                strOrientation := 'wxHORIZONTAL';

            Result.Add(IndentString + Format('  <orient>%s</orient>', [strOrientation]));
            Result.Add(IndentString + Format('  <label>%s</label>', [self.Wx_Caption]));
        End;//NUKLEAR ZELPH

        For i := 0 To self.ControlCount - 1 Do // Iterate
            If self.Controls[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) Then
        // Only add the XRC control if it is a child of the top-most parent (the form)
        //  If it is a child of a sizer, panel, or other object, then it's XRC code
        //  is created in GenerateXRCControlCreation of that control.
                If (self.Controls[i].GetParentComponent.Name = self.Name) Then
                Begin
	                   tempstring := TStringList.Create;
	                   If (self.Parent Is TForm) Then
                    Begin
	                       tempstring.Add('    ' + IndentString + '<!--sizeritem-->');
	                       tempstring.Add('      ' + IndentString + '<!--option>' + IntToStr(wxcompInterface.GetStretchFactor) + '</option-->');
	                       tempstring.Add('      ' + IndentString + '<!--border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border-->');
	                       tempstring.Add('      ' + IndentString + '<!--flag>' + BorderAlignmentToStr(wxcompInterface.GetBorderAlignment) + '</flag-->');
	                   End
	                   Else
	                   Begin
	                       tempstring.Add('    ' + IndentString + '<sizeritem>');
	                       tempstring.Add('      ' + IndentString + '<option>' + IntToStr(wxcompInterface.GetStretchFactor) + '</option>');
	                       tempstring.Add('      ' + IndentString + '<border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
	                       tempstring.Add('      ' + IndentString + '<flag>' + BorderAlignmentToStr(wxcompInterface.GetBorderAlignment) + '</flag>');
	                   End;
	                   tempstring.AddStrings(wxcompInterface.GenerateXRCControlCreation('        ' + IndentString));
	                   If (self.Parent Is TForm) Then
	                       tempstring.Add('    ' + IndentString + '<!--/sizeritem-->')
	                   Else
	                       tempstring.Add('    ' + IndentString + '</sizeritem>');

                    Try
                        Result.AddStrings(tempstring)
                    Finally
                        tempstring.Free
                    End;
                End; // for

        If (self.Parent Is TForm) Then //NUKLEAR ZELPH
            Result.Add(IndentString + '<!--/object-->')
        Else
            Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxStaticBoxSizer.GenerateGUIControlCreation: String;

    Function HasAuiManagedForm: Boolean;
    Var
        I: Integer;
        isAuimanagerAvailable: Boolean;
        wxAuimanagerInterface: IWxAuiManagerInterface;
    Begin
        isAuimanagerAvailable := False;
        If self.Parent.Parent Is TForm Then
        Begin
      //MN detect whether there is a wxAuiManager component
            For I := self.Parent.Parent.ComponentCount - 1 Downto 0 Do // Iterate
            Begin
                If self.Parent.Parent.Components[i].ClassName = 'TWxAuiManager' Then
        //if self.Parent.Parent.Components[i].GetInterface(IID_IWxAuiManagerInterface, wxAuimanagerInterface) then
                    isAuimanagerAvailable := True;
                break;
            End; // for
        End;
        Result := isAuimanagerAvailable;
    End;

Var
    strOrientation, strAlignment, staticBoxName: String;
    parentName: String;
Begin
    Result := '';
    If Not (XRCGEN) Or ((XRCGEN) And (self.Parent Is TForm)) Then //NUKLEAR ZELPH
    Begin
        If Orientation = wxVertical Then
            strOrientation := 'wxVERTICAL'
        Else
            strOrientation := 'wxHORIZONTAL';

        staticBoxName := self.Name + '_StaticBoxObj';

        parentName := GetWxWidgetParent(self, False);

        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('wxStaticBox* %s = new wxStaticBox(%s, wxID_ANY, %s);',
            [staticBoxName, parentName, GetCppString(self.Wx_Caption)]);
        Result := Result + #13 +
            Format('%s = new wxStaticBoxSizer(%s, %s);',
            [self.Name, staticBoxName, strOrientation]);
        parentName := self.Parent.Name;

        If ((self.Parent Is TForm) Or (IsControlWxContainer(self.Parent))) Then
        Begin
            If (self.Parent Is TForm) Then
                parentName := 'this'
            Else
            If (self.Parent.ClassName = 'TWxPanel') Then
                If self.Parent.Parent Is TForm And Not HasAuiManagedForm Then
	                   parentName := self.Parent.Name  //'this'
                Else
                If (self.Parent.Parent.ClassName <> 'TWxNotebook') Then
	                   parentName := self.Parent.Name
                Else
	                   parentName := self.Parent.Parent.Name
            Else
                parentName := self.Parent.Name;

            If parentName = '' Then
                parentName := self.Parent.Name;

            Result := Result + #13 + Format('%s->SetSizer(%s);', [parentName, self.Name]);
            Result := Result + #13 + Format('%s->SetAutoLayout(true);', [parentName]);
        End
        Else
        Begin
            strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
            Result := Result + #13 + Format('%s->Add(%s, %d, %s, %d);',
                [parent.Name, self.Name, self.Wx_StretchFactor, strAlignment, self.Wx_Border]);

        End;
    End;//NUKLEAR ZELPH
End;

Function TWxStaticBoxSizer.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    If Not (XRCGEN) Or ((XRCGEN) And (self.Parent Is TForm)) Then //NUKLEAR ZELPH
        Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxStaticBoxSizer.GenerateHeaderInclude: String;
Begin
    Result := '#include <wx/sizer.h>';
End;

Function TWxStaticBoxSizer.GenerateImageInclude: String;
Begin

End;

Function TWxStaticBoxSizer.GetEventList: TStringList;
Begin
    Result := Wx_EventList;
End;

Function TWxStaticBoxSizer.GetIDName: String;
Begin
  //Result:=wx_IDName;
End;

Function TWxStaticBoxSizer.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxStaticBoxSizer.GetParameterFromEventName(EventName: String): String;
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

Function TWxStaticBoxSizer.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxStaticBoxSizer.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxStaticBoxSizer.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxStaticBoxSizer.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxStaticBoxSizer.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxStaticBoxSizer.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxStaticBoxSizer.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxStaticBoxSizer.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxStaticBoxSizer';
    Result := wx_Class;
End;

Procedure TWxStaticBoxSizer.Loaded;
Begin
    Inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

End;

Procedure TWxStaticBoxSizer.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxStaticBoxSizer.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxStaticBoxSizer.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDValue;
End;

Procedure TWxStaticBoxSizer.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxStaticBoxSizer.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Procedure TWxStaticBoxSizer.WMPaint(Var Message: TWMPaint);
Var
    maxWidth, maxHt: Integer;
    totalmaxWidth, totalmaxHt: Integer;
    controlWidth, controlHeight, controlBorder: Integer;
    startX, startY: Integer;
    coordTop, coordLeft: Integer;
    i: Integer;
    wxcompInterface: IWxComponentInterface;
    cntIntf: IWxContainerInterface;
    splitIntf: IWxSplitterInterface;

Begin
    maxHt := 0;
    maxWidth := 0;
    totalmaxWidth := 10;
    totalmaxHt := 20;
    self.Caption := '';

    For i := 0 To self.ControlCount - 1 Do
    Begin
    //Is this child a non-visible component?
        If IsControlWxNonVisible(Controls[i]) Or (self.Controls[i] Is TRadioGroup) Then
            continue;

    //Calculate how much space this child component needs
        totalmaxWidth := totalmaxWidth + Controls[i].Width;
        totalmaxHt := totalmaxHt + Controls[i].Height;
        controlWidth := Controls[i].Width;
        controlHeight := Controls[i].Height;

    //Add the child's borders
        If Controls[i].GetInterface(IID_IWxComponentInterface, wxCompInterface) And
            (Not (Controls[i] Is TWxSizerPanel)) Then
        Begin
            If (wxLEFT In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment) Then
            Begin
                totalmaxWidth := totalMaxWidth + wxCompInterface.GetBorderWidth;
                controlWidth := controlWidth + wxCompInterface.GetBorderWidth;
            End;
            If (wxRIGHT In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment) Then
            Begin
                totalmaxWidth := totalMaxWidth + wxCompInterface.GetBorderWidth;
                controlWidth := controlWidth + wxCompInterface.GetBorderWidth;
            End;
            If (wxTOP In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment) Then
            Begin
                totalmaxHt := totalmaxHt + wxCompInterface.GetBorderWidth;
                controlHeight := controlHeight + wxCompInterface.GetBorderWidth;
            End;
            If (wxBOTTOM In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment) Then
            Begin
                totalmaxHt := totalmaxHt + wxCompInterface.GetBorderWidth;
                controlHeight := controlHeight + wxCompInterface.GetBorderWidth;
            End;
        End;

    //Determine the maximum height/width
        If controlWidth > maxWidth Then
            maxWidth := controlWidth;

        If controlHeight > maxHt Then
            maxHt := controlHeight;
    End;

    If self.Parent Is TForm Then
    Begin
        self.Align := alClient;
    End
    Else
    Begin
        If self.parent.GetInterface(IDD_IWxContainerInterface, cntIntf) Then
        Begin
            If self.parent.GetInterface(IID_IWxSplitterInterface, splitIntf) Then
            Begin
                self.Align := alNone;
            End
            Else
                self.Align := alClient;
        End
        Else
            self.Align := alNone;

        If self.Orientation = wxHorizontal Then
        Begin
            If totalmaxWidth = 0 Then
                self.Width := 20
            Else
                self.Width := totalmaxWidth;
            self.Height := maxHt + 20;
        End
        Else
        Begin
            If totalmaxHt = 0 Then
                self.Width := 20
            Else
                self.Height := totalmaxHt;
            self.Width := maxWidth + 10;
        End;
    End;

  //Initialize the starting coordinates
    startY := 15;
    startX := 5;

    If Orientation = wxHorizontal Then
        For i := 0 To self.ControlCount - 1 Do
        Begin
            If IsControlWxNonVisible(Controls[i]) Or (self.Controls[i] = RdGrp) Then
                continue;

      //Set the raw available width
            coordTop := maxHt - self.Controls[i].Height;
            controlBorder := 0;

      //Subtract the top and bottom borders
            If Controls[i].GetInterface(IID_IWxComponentInterface, wxCompInterface) And
                (Not (Controls[i] Is TWxSizerPanel)) Then
            Begin
                If (Not (Controls[i] Is TWxSizerPanel)) And ((wxTOP In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment)) Then
                Begin
                    controlBorder := wxCompInterface.GetBorderWidth;
                    coordTop := coordTop - wxCompInterface.GetBorderWidth;
                End;
                If (Not (Controls[i] Is TWxSizerPanel)) And ((wxBOTTOM In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment)) Then
                    coordTop := coordTop - wxCompInterface.GetBorderWidth;
                If (wxLEFT In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment) Then
                    startX := startX + wxCompInterface.GetBorderWidth;
            End;

      //Shift the controls
            self.Controls[i].Top := startY + controlBorder + coordTop Div 2;
            self.Controls[i].left := startX;

      //Add the width to the total width
            startX := startX + self.Controls[i].Width;

      //See if this object implements the object interfaces: add the right border
            If Controls[i].GetInterface(IID_IWxComponentInterface, wxCompInterface) And
                (Not (Controls[i] Is TWxSizerPanel)) Then
            Begin
                If (wxRIGHT In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment) Then
                    startX := startX + wxCompInterface.GetBorderWidth;
            End;
        End
    Else
    Begin
        For i := 0 To self.ControlCount - 1 Do
        Begin
            If IsControlWxNonVisible(Controls[i]) Or (self.Controls[i] = RdGrp) Then
                continue;

      //Get the raw space left
            controlBorder := 0;
            coordLeft := maxWidth - self.Controls[i].Width;

      //Add the top border and add the left and right borders
            If Controls[i].GetInterface(IID_IWxComponentInterface, wxCompInterface) And
                (Not (Controls[i] Is TWxSizerPanel)) Then
            Begin
                If (Not (Controls[i] Is TWxSizerPanel)) And ((wxLEFT In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment)) Then
                Begin
                    controlBorder := wxCompInterface.GetBorderWidth;
                    coordLeft := coordLeft - wxCompInterface.GetBorderWidth;
                End;
                If (Not (Controls[i] Is TWxSizerPanel)) And ((wxRIGHT In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment)) Then
                    coordLeft := coordLeft - wxCompInterface.GetBorderWidth;
                If (wxTOP In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment) Then
                    startY := startY + wxCompInterface.GetBorderWidth;
            End;

      //Set the positions of the control
            self.Controls[i].left := startX + controlBorder + (coordLeft Div 2);
            self.Controls[i].Top := startY;

      //Add the height of the last control laid out
            startY := startY + self.Controls[i].Height;

      //Add the bottom border
            If Controls[i].GetInterface(IID_IWxComponentInterface, wxCompInterface) And
                (Not (Controls[i] Is TWxSizerPanel)) Then
            Begin
                If (wxBOTTOM In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment) Then
                    startY := startY + wxCompInterface.GetBorderWidth;
            End;
        End;
    End;

    Inherited;

End;

Function TWxStaticBoxSizer.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxStaticBoxSizer.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxStaticBoxSizer.GetFGColor: String;
Begin
End;

Procedure TWxStaticBoxSizer.SetFGColor(strValue: String);
Begin
End;

Function TWxStaticBoxSizer.GetBGColor: String;
Begin
End;

Procedure TWxStaticBoxSizer.SetBGColor(strValue: String);
Begin
End;

Function TWxStaticBoxSizer.GenerateLastCreationCode: String;
Begin
    Result := '';
End;


End.
