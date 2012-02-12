{ ****************************************************************** }
{                                                                    }
{ $Id$ }
{                                                                    }
{   Copyright © 2003-2007 by Malcolm Nealon                          }
{   based on work performed by Guru Kathiresan                       }
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

Unit wxAnimationCtrl;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, ExtCtrls, WxUtils, Wxcontrolpanel, WxAuiNotebookPage,
    WxSizerPanel, wxAuiToolBar, xProcs, JvExControls, JvAnimatedImage, JvGIFCtrl;

Type
    TwxAnimationCtrl = Class(TImage, IWxComponentInterface)
    Private
    { Private fields of TwxAnimationCtrl }
        FWx_AnimationCtrlStyle: TWxAnimationCtrlStyleSet;
        FWx_Border: Integer;
        FWx_Class: String;
        FWx_ControlOrientation: TWxControlOrientation;
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

    { Storage for property Wx_ProxyBGColorString }
        FWx_ProxyBGColorString: TWxColorString;
    { Storage for property Wx_ProxyFGColorString }
        FWx_ProxyFGColorString: TWxColorString;
    { Storage for property Wx_StretchFactor }
        FWx_StretchFactor: Integer;
        FWx_Comments: TStrings;
    { Storage for property Wx_ToolTip }
        FWx_ToolTip: String;
        FWx_EventList: TStringList;

        FWx_LoadFromFile: TWxAnimationFileNameString;
        FWx_FiletoLoad: String;
        FWx_Play: Boolean;

        FWx_PropertyList: TStringList;
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

    { Private methods of TwxAnimationCtrl }
    { Method to set variable and property values and create objects }
        Procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
        Procedure AutoDestroy;

    Protected
    { Protected fields of TwxAnimationCtrl }

    { Protected methods of TwxAnimationCtrl }
        Procedure Loaded; Override;

    Public
    { Public fields and properties of TwxAnimationCtrl }
        defaultBGColor: TColor;
        defaultFGColor: TColor;
    { Public methods of TwxAnimationCtrl }
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
        Procedure SetWxFileName(wxFileName: String);

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

        Function GetAnimationCtrlStyleString(stdStyle: TWxAnimationCtrlStyleSet): String;

    Published
    { Published properties of TwxAnimationCtrl }
        Property OnClick;
        Property OnDblClick;
        Property OnDragDrop;
        Property OnMouseDown;
        Property OnMouseMove;
        Property OnMouseUp;
        Property OnResize;

        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_ControlOrientation: TWxControlOrientation
            Read FWx_ControlOrientation Write FWx_ControlOrientation;
        Property Wx_Enabled: Boolean Read FWx_Enabled Write FWx_Enabled Default True;
        Property Wx_GeneralStyle: TWxStdStyleSet Read FWx_GeneralStyle Write FWx_GeneralStyle;
        Property Wx_HelpText: String Read FWx_HelpText Write FWx_HelpText;
        Property Wx_Hidden: Boolean Read FWx_Hidden Write FWx_Hidden Default False;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue;
        Property Wx_ToolTip: String Read FWx_ToolTip Write FWx_ToolTip;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;

        Property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
        Property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
        Property InvisibleBGColorString: String Read FInvisibleBGColorString Write FInvisibleBGColorString;
        Property InvisibleFGColorString: String Read FInvisibleFGColorString Write FInvisibleFGColorString;

        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

        Property Wx_AnimationCtrlStyle: TWxAnimationCtrlStyleSet Read FWx_AnimationCtrlStyle Write FWx_AnimationCtrlStyle;
        Property Wx_LoadFromFile: TWxAnimationFileNameString Read FWx_LoadFromFile Write FWx_LoadFromFile;
        Property Wx_FiletoLoad: String Read FWx_FiletoLoad Write FWx_FiletoLoad;
        Property Wx_Play: Boolean Read FWx_Play Write FWx_Play;

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
  { Register TwxAnimationCtrl with Standard as its
    default page on the Delphi component palette }
    RegisterComponents('wxWidgets', [TwxAnimationCtrl]);
End;

{ Method to set variable and property values and create objects }

Procedure TwxAnimationCtrl.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Border := 5;
    FWx_Class := 'wxAnimationCtrl';
    FWx_Hidden := False;
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_StretchFactor := 0;

    FWx_ProxyBGColorString := TWxColorString.Create;
    FWx_ProxyFGColorString := TWxColorString.Create;
    defaultBGColor := self.color;
    defaultFGColor := self.font.color;
    FWx_LoadFromFile := TWxAnimationFileNameString.Create;
    FWx_Comments := TStringList.Create;

  {
     FImage.Align  := alClient;
    FImage.Center := True;
    self.Caption  := '';
    self.Height   := 20;
    self.Width    := 20;
  }
End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }

Procedure TwxAnimationCtrl.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_ProxyBGColorString.Destroy;
    FWx_ProxyFGColorString.Destroy;
    FWx_LoadFromFile.Destroy;
    FWx_Comments.Destroy;
End; { of AutoDestroy }

Constructor TwxAnimationCtrl.Create(AOwner: TComponent);
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
  //  FWx_PropertyList.add('Image:Image');
    FWx_PropertyList.add('Wx_AnimationCtrlStyle:AnimationCtrl Styles');
    FWx_PropertyList.add('wxAC_DEFAULT_STYLE:wxAC_DEFAULT_STYLE');
    FWx_PropertyList.add('wxAC_NO_AUTORESIZE:wxAC_NO_AUTORESIZE');
    FWx_PropertyList.Add('Wx_LoadFromFile:Load From File');
    FWx_PropertyList.Add('Wx_Play:Play');

End;

Destructor TwxAnimationCtrl.Destroy;
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

Function TwxAnimationCtrl.GenerateEnumControlIDs: String;
Begin
    Result := GetWxEnum(self.Wx_IDValue, self.Wx_IDName);
End;

Function TwxAnimationCtrl.GenerateControlIDs: String;
Begin
    Result := '';
    If (Wx_IDValue > 0) And (trim(Wx_IDName) <> '') Then
        Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
End;

Function TwxAnimationCtrl.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TwxAnimationCtrl.GenerateXRCControlCreation(IndentString: String): TStringList;
Var
    tempstring: TStringList;
    stylstr: String;
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

        stylstr := GetAnimationCtrlSpecificStyle(self.Wx_GeneralStyle);
        If stylstr <> '' Then
            Result.Add(IndentString + Format('  <style>%s | %s</style>',
                [GetAnimationCtrlStyleString(self.Wx_AnimationCtrlStyle), stylstr]))
        Else
            Result.Add(IndentString + Format('  <style>%s</style>',
        //      [GetChoicebookSpecificStyle(self.Wx_GeneralStyle{, self.Wx_ChoiceAlignment, self.Wx_ChoiceBookStyle})]));
                [GetAnimationCtrlStyleString(self.Wx_AnimationCtrlStyle)]));

        Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;

End;

Function TwxAnimationCtrl.GenerateGUIControlCreation: String;
Var
    strColorStr: String;
    aniStyle, stdStyle, strStyle, parentName, strAlignment, strBitmapArrayName: String;
Begin
    Result := '';
    stdStyle := GetStdStyleString(self.Wx_GeneralStyle);
    aniStyle := GetAnimationCtrlStyleString(self.Wx_AnimationCtrlStyle);

    If (trim(stdStyle) <> '') Or (trim(aniStyle) <> '') Then
        strStyle := ', ';

    If (trim(stdStyle) <> '') And (trim(aniStyle) <> '') Then
        strStyle := strStyle + stdStyle + ' | ' + aniStyle
    Else
        strStyle := strStyle + stdStyle + aniStyle;

    If FWx_PaneCaption = '' Then
        FWx_PaneCaption := Self.Name;
    If FWx_PaneName = '' Then
        FWx_PaneName := Self.Name + '_Pane';

    parentName := GetWxWidgetParent(self, Wx_AuiManaged);

  //  if self.Picture.Bitmap.handle = 0 then
    strBitmapArrayName := 'wxNullAnimation';
  {  else begin
      strBitmapArrayName := self.Name + '_ANIMATION';
      Result := GetCommentString(self.FWx_Comments.Text) +
        'wxBitmap ' + strBitmapArrayName + '(' + GetDesignerFormName(self)+'_'+self.Name + '_XPM' + ');';
    end;
  }
    If (XRCGEN) Then
    Begin//generate xrc loading code
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = XRCCTRL(*%s, %s("%s"), %s);',
            [self.Name, parentName, StringFormat, self.Name, self.wx_Class]);
    End
    Else
    Begin
        If Result <> '' Then
            Result := Result + #13 + Format('%s = new %s(%s, %s, %s, %s, %s%s);',
                [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
                self.Wx_IDValue),
                strBitmapArrayName, GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle])
        Else
            Result := GetCommentString(self.FWx_Comments.Text) +
                Format('%s = new %s(%s, %s, %s, %s, %s %s);',
                [self.Name, self.wx_Class, parentName, GetWxIDString(self.Wx_IDName,
                self.Wx_IDValue),
                strBitmapArrayName, GetWxPosition(self.Left, self.Top), GetWxSize(self.Width, self.Height), strStyle]);
    End;
    SetWxFileName(self.FWx_LoadFromFile.FstrFileNameValue);
    If FWx_FiletoLoad <> '' Then
    Begin
        Begin
            Self.Picture.LoadFromFile(FWx_FiletoLoad);
            Result := Result + #13 + Format('%s->LoadFile("%s");',
                [self.Name, FWx_FiletoLoad]);
        End;

        If FWx_Play = True Then
        Begin
            Result := Result + #13 + Format('%s->Play();', [self.Name]);
        End;

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

Function TwxAnimationCtrl.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TwxAnimationCtrl.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/animate.h>';
End;

Function TwxAnimationCtrl.GenerateImageInclude: String;
Begin
    Result := '';
  {  if self.Picture.Bitmap.Handle <> 0 then
      Result := '#include "Images/' + GetDesignerFormName(self)+'_'+self.Name + '_XPM.xpm"'  }
End;

Function TwxAnimationCtrl.GetEventList: TStringList;
Begin
    Result := Nil;
End;

Function TwxAnimationCtrl.GetIDName: String;
Begin
    Result := wx_IDName;
End;

Function TwxAnimationCtrl.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TwxAnimationCtrl.GetParameterFromEventName(EventName: String): String;
Begin
    Result := '';

End;

Function TwxAnimationCtrl.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TwxAnimationCtrl.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TwxAnimationCtrl.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TwxAnimationCtrl.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TwxAnimationCtrl.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TwxAnimationCtrl.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TwxAnimationCtrl.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TwxAnimationCtrl.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxAnimationCtrl';
    Result := wx_Class;
End;

Procedure TwxAnimationCtrl.Loaded;
Begin
    Inherited Loaded;

  { Perform any component setup that depends on the property
    values having been set }

End;

Procedure TWxAnimationCtrl.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TwxAnimationCtrl.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TwxAnimationCtrl.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TwxAnimationCtrl.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TwxAnimationCtrl.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TwxAnimationCtrl.GetGenericColor(strVariableName: String): String;
Begin

End;

Procedure TwxAnimationCtrl.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TwxAnimationCtrl.GetFGColor: String;
Begin
    Result := FInvisibleFGColorString;
End;

Procedure TwxAnimationCtrl.SetFGColor(strValue: String);
Begin
    FInvisibleFGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Font.Color := defaultFGColor
    Else
        self.Font.Color := GetColorFromString(strValue);
End;

Function TwxAnimationCtrl.GetBGColor: String;
Begin
    Result := FInvisibleBGColorString;
End;

Procedure TwxAnimationCtrl.SetBGColor(strValue: String);
Begin
    FInvisibleBGColorString := strValue;
    If IsDefaultColorStr(strValue) Then
        self.Color := defaultBGColor
    Else
        self.Color := GetColorFromString(strValue);
End;

Procedure TwxAnimationCtrl.SetProxyFGColorString(Value: String);
Begin
    FInvisibleFGColorString := Value;
    self.Color := GetColorFromString(Value);
End;

Procedure TwxAnimationCtrl.SetProxyBGColorString(Value: String);
Begin
    FInvisibleBGColorString := Value;
    self.Font.Color := GetColorFromString(Value);
End;

Procedure TwxAnimationCtrl.SetWxFileName(wxFileName: String);
Begin
    FWx_FiletoLoad := trim(wxFileName);
    strSearchReplace(FWx_FiletoLoad, '\', '/', [srAll]);
    Wx_LoadFromFile.FstrFileNameValue := FWx_FiletoLoad;
End;

Function TwxAnimationCtrl.GetAnimationCtrlStyleString(stdStyle: TWxAnimationCtrlStyleSet): String;
Var
    I: Integer;
    strLst: TStringList;
Begin

    strLst := TStringList.Create;

    Try
        If wxAC_DEFAULT_STYLE In stdStyle Then
            strLst.add('wxAC_DEFAULT_STYLE');

        If wxAC_NO_AUTORESIZE In stdStyle Then
        Begin
            strLst.add('wxAC_NO_AUTORESIZE');
            self.AutoSize := False;
        End
        Else
        Begin
            self.AutoSize := True;
        End;

        If strLst.Count = 0 Then
            Result := ''
        Else
            For I := 0 To strLst.Count - 1 Do // Iterate
                If i <> strLst.Count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + strLst[i] // for
        ;
    //sendDebug(Result);

    Finally
        strLst.Destroy;
    End;
End;

End.
