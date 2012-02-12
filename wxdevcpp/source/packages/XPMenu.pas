{
XPMenu for Delphi
Author: Khaled Shagrouni
URL: http://www.shagrouni.com/english/software/xpmenu.html
e-mail: khaled@shagrouni.com

Version 3.1 - 22.02.2004



XPMenu is a Delphi component to mimic Office XP menu and toolbar style.
Copyright (C) 2001, 2003 Khaled Shagrouni.

This component is FREEWARE with source code. I still hold the copyright, but
you can use it for whatever you like: freeware, shareware or commercial software.
If you have any ideas for improvement or bug reports, don't hesitate to e-mail
me <khaled@shagrouni.com> (Please state the XPMenu version and OS information).
}

{$IFDEF VER130}
{$DEFINE VER5U}
{$ENDIF}

{$IFDEF VER140}
{$DEFINE VER5U}
{$DEFINE VER6U}
{$ENDIF}

{$IFDEF VER150}
{$DEFINE VER5U}
{$DEFINE VER6U}
{$DEFINE VER7U}
{$ENDIF}

Unit XPMenu;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, ComCtrls, Forms,
    Menus, Commctrl, ExtCtrls, StdCtrls, Buttons;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QComCtrls, QForms,
  QMenus, Commctrl, QStdCtrls, QButtons;
{$ENDIF}

Type
    TXPContainer = (xccForm, xccFrame, xccToolbar, xccCoolbar, xccControlbar, xccPanel,
        xccScrollBox, xccGroupBox, xccTabSheet, xccPageScroller);
    TXPContainers = Set Of TXPContainer;

    TXPControl = (xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar, xcCombo, xcListBox,
        xcEdit, xcMaskEdit, xcMemo, xcRichEdit, xcMiscEdit, xcCheckBox,
        xcRadioButton, xcButton, xcBitBtn, xcSpeedButton, xcUpDown, xcPanel,
        xcGroupBox, xcTreeView, xcListView, xcProgressBar, xcHotKey);
                {xcStringGrid, xcDrawGrid, xcDBGrid);}

    TXPControls = Set Of TXPControl;

    TXPMenu = Class;

    TControlSubClass = Class(TComponent)   //:   "Fabian Jakubowski" <fj@sambreville.com>
    Private
        fControl: TControl;
        FBuilding: Boolean;
        FMouseInControl: Boolean;
        FLButtonBressed: Boolean;
        FBressed: Boolean;
        FIsKeyDown: Boolean;
        FIsFocused: Boolean;
        orgWindowProc: TWndMethod;
        XPMenu: TXPMenu;
        FCtl3D: Boolean;
        FBorderStyle: TBorderStyle;
  {FOnDrawCell: TDrawCellEvent;}
        FDefaultDrawing: Boolean;
        FSelCol, FSelRow: Integer;
        FMsg: Cardinal;
        Procedure ControlSubClass(Var Message: TMessage);
        Procedure PaintControlXP;
        Procedure PaintCombo;
        Procedure PaintDBLookupCombo;
        Procedure PaintEdit;
        Procedure PaintRichEdit;
        Procedure PaintCheckBox;
        Procedure PaintRadio;
        Procedure PaintButton;
        Procedure PaintBitButn;
        Procedure PaintUpDownButton;
        Procedure PaintSpeedButton;
        Procedure PaintPanel;
        Procedure PaintGroupBox;
        Procedure PaintNCWinControl;
        Procedure PaintProgressBar;
        Procedure PaintHotKey;
        Procedure SetControl(AControl: TControl);
        Property Control: TControl Read fControl Write SetControl;
    End;

    TXPMenu = Class(TComponent)
    Private
        FActive: Boolean;
    {Changes MMK FForm to TScrollingWinControl}
        FForm: TScrollingWinControl;
        FFont: TFont;
        FColor: TColor;
        FIconBackColor: TColor;
        FMenuBarColor: TColor;
        FCheckedColor: TColor;
        FSeparatorColor: TColor;
        FSelectBorderColor: TColor;
        FSelectColor: TColor;
        FDisabledColor: TColor;
        FSelectFontColor: TColor;
        FIconWidth: Integer;
        FDrawSelect: Boolean;
        FUseSystemColors: Boolean;
        FColorsChanged: Boolean; // +jt

        FFColor, FFIconBackColor, FFSelectColor, FFSelectBorderColor,
        FFSelectFontColor, FCheckedAreaColor, FCheckedAreaSelectColor,
        FFCheckedColor, FFMenuBarColor, FFDisabledColor, FFSeparatorColor,
        FMenuBorderColor, FMenuShadowColor: TColor;

        Is16Bit: Boolean;
        FOverrideOwnerDraw: Boolean;
        FGradient: Boolean;
        FFlatMenu: Boolean;
        FAutoDetect: Boolean;
        FXPContainers: TXPContainers;
        FXPControls: TXPControls;
        FGrayLevel: Byte;
        FDimLevel: Byte;
        FDrawMenuBar: Boolean;
        FUseDimColor: Boolean;
        FDimParentColor, FDimParentColorSelect: Integer;
   // FUseParentClor: boolean;
// +jt
        FSettingWindowRng: Boolean;
        FIsW2k: Boolean;
        FIsWXP: Boolean;
        FIsWNT: Boolean;
//   FTransparentColor: TColor;
// +jt

   // Do not allow the component to be used for subclassing
        FDisableSubclassing: Boolean;
        Procedure SetDisableSubclassing(Const Value: Boolean);

        Procedure SetActive(Const Value: Boolean);
        Procedure SetAutoDetect(Const Value: Boolean);
        Procedure SetForm(Const Value: TScrollingWinControl);
        Procedure SetFont(Const Value: TFont);
        Procedure SetColor(Const Value: TColor);
        Procedure SetIconBackColor(Const Value: TColor);
        Procedure SetMenuBarColor(Const Value: TColor);
        Procedure SetCheckedColor(Const Value: TColor);
        Procedure SetDisabledColor(Const Value: TColor);
        Procedure SetSelectColor(Const Value: TColor);
        Procedure SetSelectBorderColor(Const Value: TColor);
        Procedure SetSeparatorColor(Const Value: TColor);
        Procedure SetSelectFontColor(Const Value: TColor);
        Procedure SetIconWidth(Const Value: Integer);
        Procedure SetDrawSelect(Const Value: Boolean);
        Procedure SetUseSystemColors(Const Value: Boolean);
        Procedure SetOverrideOwnerDraw(Const Value: Boolean);
        Procedure SetGradient(Const Value: Boolean);
        Procedure SetFlatMenu(Const Value: Boolean);
        Procedure SetXPContainers(Const Value: TXPContainers);
        Procedure SetXPControls(Const Value: TXPControls);
        Procedure SetDrawMenuBar(Const Value: Boolean);
        Procedure SetUseDimColor(Const Value: Boolean);

    Protected
        Procedure Loaded; Override; //add by Cunha, liyang.
        Procedure InitItems(wForm: TWinControl; Enable, Update: Boolean);
        Procedure InitItem(Comp: TComponent; Enable, Update: Boolean); // Tom: "Thomas Knoblauch" <thomas@tom-the-bomb.de> 27.08
        Procedure DrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
            Selected: Boolean);
        Procedure MenueDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
            Selected: Boolean);
    {$IFDEF VER5U}
        Procedure ToolBarDrawButton(Sender: TToolBar;
            Button: TToolButton; State: TCustomDrawState; Var DefaultDraw: Boolean);
    {$ENDIF}
        Procedure ControlBarPaint(Sender: TObject; Control: TControl;
            Canvas: TCanvas; Var ARect: TRect; Var Options: TBandPaintOptions);

        Procedure SetGlobalColor(ACanvas: TCanvas);
        Procedure DrawTopMenuItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
            BckColor: Tcolor; IsRightToLeft: Boolean);
        Procedure DrawCheckedItem(FMenuItem: TMenuItem; Selected, Enabled,
            HasImgLstBitmap: Boolean; ACanvas: TCanvas; CheckedRect: TRect);
        Procedure DrawTheText(Sender: TObject; txt, ShortCuttext: String;
            ACanvas: TCanvas; TextRect: TRect;
            Selected, Enabled, Default, TopMenu, IsRightToLeft: Boolean;
            Var TxtFont: TFont; TextFormat: Integer);
        Procedure DrawIcon(Sender: TObject; ACanvas: TCanvas; B: TBitmap;
            IconRect: Trect; Hot, Selected, Enabled, Checked, FTopMenu,
            IsRightToLeft: Boolean);

        Procedure MeasureItem(Sender: TObject; ACanvas: TCanvas;
            Var Width, Height: Integer);

    //function GetImageExtent(MenuItem: TMenuItem): TPoint;
        Function GetImageExtent(MenuItem: TMenuItem; FTopMenu: TMenu): TPoint; // +jt
        Function TopMenuFontColor(ACanvas: TCanvas; Color: TColor): TColor;
        Procedure DrawGradient(ACanvas: TCanvas; ARect: TRect;
            IsRightToLeft: Boolean);

        Procedure DrawWindowBorder(hWnd: HWND; IsRightToLeft: Boolean);

        Procedure Notification(AComponent: TComponent;
            Operation: TOperation); Override;

    Public
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Procedure InitComponent(Comp: TComponent); // Tom: Added for usage by the main program ."Thomas Knoblauch" <thomas@tom-the-bomb.de> 27.08
        Procedure ActivateMenuItem(MenuItem: TMenuItem; SubMenus: Boolean); // +jt
        Property Form: TScrollingWinControl Read FForm Write SetForm;
// +jt
        Property IsWXP: Boolean Read FIsWXP;
        Property IsW2k: Boolean Read FIsW2k;
        Property IsWNT: Boolean Read FIsWNT;
//   property TransparentColor: TColor read FTransparentColor write FTransparentColor;
// +jt
    Published
        Property DimLevel: Byte Read FDimLevel Write FDimLevel;
        Property GrayLevel: Byte Read FGrayLevel Write FGrayLevel;
        Property Font: TFont Read FFont Write SetFont;
        Property Color: TColor Read FColor Write SetColor;
        Property DrawMenuBar: Boolean Read FDrawMenuBar Write SetDrawMenuBar;
        Property IconBackColor: TColor Read FIconBackColor Write SetIconBackColor;
        Property MenuBarColor: TColor Read FMenuBarColor Write SetMenuBarColor;
        Property SelectColor: TColor Read FSelectColor Write SetSelectColor;
        Property SelectBorderColor: TColor Read FSelectBorderColor
            Write SetSelectBorderColor;
        Property SelectFontColor: TColor Read FSelectFontColor
            Write SetSelectFontColor;
        Property DisabledColor: TColor Read FDisabledColor Write SetDisabledColor;
        Property SeparatorColor: TColor Read FSeparatorColor
            Write SetSeparatorColor;
        Property CheckedColor: TColor Read FCheckedColor Write SetCheckedColor;
        Property IconWidth: Integer Read FIconWidth Write SetIconWidth;
        Property DrawSelect: Boolean Read FDrawSelect Write SetDrawSelect;
        Property UseSystemColors: Boolean Read FUseSystemColors
            Write SetUseSystemColors;
        Property UseDimColor: Boolean Read FUseDimColor Write SetUseDimColor;
        Property OverrideOwnerDraw: Boolean Read FOverrideOwnerDraw
            Write SetOverrideOwnerDraw;

        Property Gradient: Boolean Read FGradient Write SetGradient;
        Property FlatMenu: Boolean Read FFlatMenu Write SetFlatMenu;
        Property AutoDetect: Boolean Read FAutoDetect Write SetAutoDetect;
        Property XPContainers: TXPContainers Read FXPContainers Write SetXPContainers
            Default [xccForm, xccFrame, xccToolbar, xccCoolbar, xccControlbar, xccPanel,
            xccScrollBox, xccGroupBox, xccTabSheet, xccPageScroller];
        Property XPControls: TXPControls Read FXPControls Write SetXPControls
            Default [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar, xcCombo, xcListBox,
            xcEdit, xcMaskEdit, xcMemo, xcRichEdit, xcMiscEdit, xcCheckBox,
            xcRadioButton, xcButton, xcBitBtn, xcSpeedButton, xcUpDown, xcPanel,
            xcGroupBox, xcTreeView, xcListView, xcProgressBar, xcHotKey];
               {xcStringGrid, xcDrawGrid, xcDBGrid];}

        Property Active: Boolean Read FActive Write SetActive;
        Property DisableSubclassing: Boolean Read FDisableSubclassing Write SetDisablesubclassing
            Default False;
    End;

    TXPMenuManager = Class(TPersistent)
    Private
        FXPMenuList: TList;
        FPendingFormsList: TList;
        FFormList: TList;
        FActiveXPMenu: TXPMenu;
        FDisableSubclassing: Boolean;

        Function MainWindowHook(Var Message: TMessage): Boolean;
        Procedure CollectForms;
        Procedure RemoveChildSubclassing(AForm: TCustomForm);
        Procedure SetDisableSubclassing(AValue: Boolean);
        Function FindSubclassingXPMenu(Exclude: TXPMenu): TXPMenu;

    Protected
        Procedure Notification(AComponent: TComponent; Operation: TOperation);

    Public
        Constructor Create;
        Destructor Destroy; Override;
        Procedure Add(AXPMenu: TXPMenu);
        Procedure Delete(AXPMenu: TXPMenu);
        Procedure UpdateActiveXPMenu(AXPMenu: TXPMenu);
        Procedure AddForm(AForm: TCustomForm);
        Procedure RemoveForm(AForm: TCustomForm);
        Function IsFormSubclassed(AForm: TCustomForm): Boolean;
        Function IsComponentSubclassed(AComponent: TComponent): Boolean;

        Property ActiveXPMenu: TXPMenu Read FActiveXPMenu;
        Property DisableSubclassing: Boolean Read FDisableSubclassing Write SetDisableSubclassing
            Default False;
    End;

Function GetShadeColor(ACanvas: TCanvas; clr: TColor; Value: Integer): TColor;
Function MergColor(Colors: Array Of TColor): TColor;
Function NewColor(ACanvas: TCanvas; clr: TColor; Value: Integer): TColor;
Procedure DimBitmap(ABitmap: TBitmap; Value: Integer);

Procedure DrawArrow(ACanvas: TCanvas; X, Y: Integer); Overload;
Procedure DrawArrow(ACanvas: TCanvas; X, Y, Orientation: Integer); Overload;
Function GrayColor(ACanvas: TCanvas; clr: TColor; Value: Integer): TColor;
Function GetInverseColor(AColor: TColor): TColor;

Procedure GrayBitmap(ABitmap: TBitmap; Value: Integer);
Procedure DrawBitmapShadow(B: TBitmap; ACanvas: TCanvas; X, Y: Integer;
    ShadowColor: TColor);
Procedure DrawCheckMark(ACanvas: TCanvas; X, Y: Integer);

Procedure GetSystemMenuFont(Font: TFont);
Procedure Register;

Const
    WM_DRAWMENUBORDER = CN_NOTIFY + 101;   // +jt
    WM_DRAWMENUBORDER2 = CN_NOTIFY + 102;   // +jt

// Gloabal access to the XPMenuManager
Var
    XPMenuManager: TXPMenuManager;

Implementation

Procedure Register;
Begin
    RegisterComponents('XP', [TXPMenu]);
End;

// Set up the global variable that represents the XPMenuManager
Procedure InitControls;
Begin
    If XPMenuManager = Nil Then
        XPMenuManager := TXPMenuManager.Create;
End;

// Delete the global variable that represents the XPMenuManager
Procedure DoneControls;
Begin
    If (XPMenuManager <> Nil) Then
    Begin
        XPMenuManager.Free;
        XPMenuManager := Nil;
    End;
End;

// Test if mouse cursor is in the given rect of the application's main form
Function IsMouseInRect(TheForm: TScrollingWinControl; DestRect: TRect): Boolean;
Var
    p: TPoint;

Begin

    If Assigned(TheForm) Then
    Begin
        p := Mouse.CursorPos;
        p.x := p.x - TheForm.Left;
        p.y := p.y - TheForm.Top;

        Dec(DestRect.Right);
        Dec(DestRect.Bottom, 2);
        Result := (p.x >= DestRect.Left) And (p.x <= DestRect.Right) And
            (p.y >= DestRect.Top) And (p.y <= DestRect.Bottom);
    End
    Else Result := False;
End;

{ TXPMenue }

Constructor TXPMenu.Create(AOwner: TComponent);
Var
    OSVersionInfo: TOSVersionInfo; // +jt
Begin
    Inherited Create(AOwner);
    FFont := TFont.Create;

    FDisableSubclassing := False;        // enable XPMenu to be used for global subclassing


{$IFDEF VER5U}
    FFont.Assign(Screen.MenuFont);
{$ELSE}
  GetSystemMenuFont(FFont);
{$ENDIF}
    FForm := Owner As TScrollingWinControl;

    FUseSystemColors := True;

    FColor := clBtnFace;
    FIconBackColor := clBtnFace;
    FSelectColor := clHighlight;
    FSelectBorderColor := clHighlight;
    FMenuBarColor := clBtnFace;
    FDisabledColor := clInactiveCaption;
    FSeparatorColor := clBtnFace;
    FCheckedColor := clHighlight;
    FSelectFontColor := FFont.Color;
    FGrayLevel := 10;
    FDimLevel := 30;
    FIconWidth := 24;
    FDrawSelect := True;
    XPContainers := [xccForm, xccFrame, xccToolbar, xccCoolbar, xccControlbar, xccPanel,
        xccScrollBox, xccGroupBox, xccTabSheet, xccPageScroller];
    XPControls := [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar, xcCombo, xcListBox,
        xcEdit, xcMaskEdit, xcMemo, xcRichEdit, xcMiscEdit, xcCheckBox,
        xcRadioButton, xcButton, xcBitBtn, xcSpeedButton, xcUpDown, xcPanel,
        xcGroupBox, xcTreeView, xcListView, xcProgressBar, xcHotKey];
            {xcStringGrid, xcDrawGrid, xcDBGrid];}

    If Assigned(FForm) Then
        SetGlobalColor(TForm(FForm).Canvas);

// +jt
// FTransparentColor := clFuchsia;
    FColorsChanged := False;
    OSVersionInfo.dwOSVersionInfoSize := sizeof(OSVersionInfo);
    GetVersionEx(OSVersionInfo);
    FIsWXP := False;
    FIsW2k := False;
    FIsWNT := False;
    If OSVersionInfo.dwPlatformId = VER_PLATFORM_WIN32_NT Then
    Begin
        FIsWNT := True;
        If (OSVersionInfo.dwMajorVersion = 5) And (OSVersionInfo.dwMinorVersion = 0) Then
            FIsW2k := True;
        If (OSVersionInfo.dwMajorVersion = 5) And (OSVersionInfo.dwMinorVersion = 1) Then
            FIsWXP := True;
    End;
// +jt

    If Not (csDesigning In ComponentState) Then
        InitControls;
End;

Destructor TXPMenu.Destroy;
Begin
    If Assigned(FForm) Then    //oleg oleg@vdv-s.ru  Mon Oct  7
        InitItems(FForm, False, False);

// Remove XPMenu from XPMenuManager
    If Assigned(XPMenuManager) And Not (csDesigning In ComponentState) Then
    Begin
        XPMenuManager.Delete(Self);
        FForm.Update;
        If XPMenuManager.FXPMenuList.Count = 0 Then
            DoneControls;
    End;

    FFont.Free;
    Inherited;
End;

//add by:
//liyang <liyang@guangdainfo.com> ,2002-07-19
//Pedro Miguel Cunha <PCunha@codeware.pt>- 02 Apr 2002
Procedure TXPMenu.Loaded;
Begin
    Inherited Loaded;

// Add the XPMenu to the XPMenuManager
    If Assigned(XPMenuManager) And Not (csDesigning In ComponentState) Then
        XPMenuManager.Add(Self);
End;

{to check for new sub items}
Procedure TXPMenu.ActivateMenuItem(MenuItem: TMenuItem; SubMenus: Boolean); // +jt

    Procedure Activate(MenuItem: TMenuItem);
    Begin
        If (MenuItem.Tag <> 999) Then
            If addr(MenuItem.OnDrawItem) <> addr(TXPMenu.DrawItem) Then
            Begin
                If (Not assigned(MenuItem.OnDrawItem)) Or (FOverrideOwnerDraw) Then
                    MenuItem.OnDrawItem := DrawItem;
                If (Not assigned(MenuItem.OnMeasureItem)) Or (FOverrideOwnerDraw) Then
                    MenuItem.OnMeasureItem := MeasureItem;
            End;
    End;

Var
    i{, j}: Integer;
Begin

    Activate(MenuItem);
    If (SubMenus = True) Then // +jt
    Begin
        For i := 0 To MenuItem.Count - 1 Do
        Begin
            ActivateMenuItem(MenuItem.Items[i], True);
        End;
    End;
End;

Procedure TXPMenu.InitItems(wForm: TWinControl; Enable, Update: Boolean);
Var
    i: Integer;
    Comp: TComponent;
Begin
    For i := 0 To wForm.ComponentCount - 1 Do
    Begin
        Comp := wForm.Components[i];
        InitItem(Comp, Enable, Update); // Tom: "Thomas Knoblauch" <thomas@tom-the-bomb.de> 27.08
    End;
End;

Procedure TXPMenu.InitComponent(Comp: TComponent); // Tom: for external (by the main program) use without parameters. "Thomas Knoblauch" <thomas@tom-the-bomb.de> 27.08
Begin
    If FActive Then
        InitItem(Comp, True, True);
End;



// Tom: "Thomas Knoblauch" <thomas@tom-the-bomb.de> 27.08
Procedure TXPMenu.InitItem(Comp: TComponent; Enable, Update: Boolean);
    Procedure Activate(MenuItem: TMenuItem);
    Begin
        If Enable Then
        Begin
            If (MenuItem.Tag <> 999) Then
            Begin
                If (Not assigned(MenuItem.OnDrawItem)) Or (FOverrideOwnerDraw) Then
                    MenuItem.OnDrawItem := DrawItem;
                If (Not assigned(MenuItem.OnMeasureItem)) Or (FOverrideOwnerDraw) Then
                    MenuItem.OnMeasureItem := MeasureItem;
            End;
        End
        Else
        Begin
            If addr(MenuItem.OnDrawItem) = addr(TXPMenu.DrawItem) Then
                MenuItem.OnDrawItem := Nil;
            If addr(MenuItem.OnMeasureItem) = addr(TXPMenu.MeasureItem) Then
                MenuItem.OnMeasureItem := Nil;
        End;
    End;

    Procedure ItrateMenu(MenuItem: TMenuItem);
    Var
        i: Integer;
    Begin
        Activate(MenuItem);
        For i := 0 To MenuItem.Count - 1 Do
        Begin
            ItrateMenu(MenuItem.Items[i]);
        End;
    End;

Var
    x: Integer;
    s: String;

Begin
    If (Comp Is TMainMenu) And (xcMainMenu In XPControls) And (TMainMenu(Comp).Tag <> 999) Then
    Begin
        TMainMenu(Comp).OwnerDraw := Enable;
        For x := 0 To TMainMenu(Comp).Items.Count - 1 Do
            ItrateMenu(TMainMenu(Comp).Items[x]);

    // Selly way to force top menu in other forms to repaint
        S := TMainMenu(Comp).Items[0].Caption;
        TMainMenu(Comp).Items[0].Caption := '';
        TMainMenu(Comp).Items[0].Caption := S;
    End;

    If (Comp Is TMenuItem) And (xcMainMenu In XPControls) Then
    Begin
        ItrateMenu(TMenuItem(Comp));
    End;

    If (Comp Is TPopupMenu) And (xcPopupMenu In XPControls) Then
    Begin
        For x := 0 To TPopupMenu(Comp).Items.Count - 1 Do
        Begin
            TPopupMenu(Comp).OwnerDraw := Enable;
            ItrateMenu(TPopupMenu(Comp).Items[x]);

        End;
    End;

{$IFDEF VER5U}
    If (Comp Is TToolBar) And (xcToolBar In FXPControls) Then
        If Not (csDesigning In ComponentState) Then
        Begin
            If Not TToolBar(Comp).Flat Then
                TToolBar(Comp).Flat := True;

            If Enable Then
            Begin
                For x := 0 To TToolBar(Comp).ButtonCount - 1 Do
                    If (Not assigned(TToolBar(Comp).OnCustomDrawButton))
                        Or (FOverrideOwnerDraw) Then
                    Begin
                        TToolBar(Comp).OnCustomDrawButton :=
                            ToolBarDrawButton;

                    End;
            End
            Else
            Begin
                If addr(TToolBar(Comp).OnCustomDrawButton) =
                    addr(TXPMenu.ToolBarDrawButton) Then
                    TToolBar(Comp).OnCustomDrawButton := Nil;
            End;
            If Update Then
                TToolBar(Comp).Invalidate;
        End;
{$ENDIF}

    If (Comp Is TControlBar) And (xcControlBar In FXPControls) Then
        If Not (csDesigning In ComponentState) Then
        Begin
            If Enable Then
            Begin
                If (Not assigned(TControlBar(Comp).OnBandPaint))
                    Or (FOverrideOwnerDraw) Then
                Begin
                    TControlBar(Comp).OnBandPaint := ControlBarPaint;
                End;
            End
            Else
            Begin
                If addr(TControlBar(Comp).OnBandPaint) =
                    addr(TXPMenu.ControlBarPaint) Then
                    TControlBar(Comp).OnBandPaint := Nil;
            End;
            If Update Then
                TControlBar(Comp).Invalidate;
        End;

    If Not (csDesigning In ComponentState) Then
        If {$IFDEF VER6U}
        ((Comp Is TCustomCombo) And (xcCombo In FXPControls)) Or
            ((Comp Is TCustomLabeledEdit) And (xcEdit In FXPControls)) Or

       {$ELSE}
       ((Comp is TCustomComboBox) and (xcCombo in FXPControls)) or
       {$ENDIF}
            ((Comp Is TEdit) And (xcEdit In FXPControls)) Or
            ((Comp.ClassName = 'TMaskEdit') And (xcMaskEdit In FXPControls)) Or
            ((Comp.ClassName = 'TDBEdit') And (xcMaskEdit In FXPControls)) Or
            ((Comp Is TCustomMemo) And (xcMemo In FXPControls)) Or
            ((Comp Is TCustomRichEdit) And (xcRichEdit In FXPControls)) Or
            ((Comp Is TCustomCheckBox) And (xcCheckBox In FXPControls)) Or
            ((Comp Is TRadioButton) And (xcRadioButton In FXPControls)) Or
            ((Comp.ClassName = 'TBitBtn') And (xcBitBtn In FXPControls)) Or
            ((Comp.ClassName = 'TButton') And (xcButton In FXPControls)) Or
            ((Comp.ClassName = 'TUpDown') And (xcUpDown In FXPControls)) Or
            ((Comp Is TSpeedButton) And (xcSpeedButton In FXPControls)) Or
            ((Comp Is TCustomPanel) And (xcPanel In FXPControls)) Or
            ((Comp.ClassName = 'TDBNavigator') And (xcButton In FXPControls)) Or
            ((Comp.ClassName = 'TDBLookupComboBox') And (xcButton In FXPControls)) Or
            ((Comp Is TCustomGroupBox) And (xcGroupBox In FXPControls)) Or
            ((Comp Is TCustomListBox) And (xcListBox In FXPControls)) Or
            ((Comp Is TCustomTreeView) And (xcTreeView In FXPControls)) Or
            ((Comp Is TCustomListView) And (xcListView In FXPControls)) Or
            ((Comp Is TProgressBar) And (xcProgressBar In FXPControls)) Or
            ((Comp Is TCustomHotKey) And (xcHotKey In FXPControls))
        Then
            If ((TControl(Comp).Parent Is TToolbar) And (xccToolBar In FXPContainers)) Or
                ((TControl(Comp).Parent Is TCoolbar) And (xccCoolbar In FXPContainers)) Or
                ((TControl(Comp).Parent Is TCustomPanel) And (xccPanel In FXPContainers)) Or
                ((TControl(Comp).Parent Is TControlbar) And (xccControlbar In FXPContainers)) Or
                ((TControl(Comp).Parent Is TScrollBox) And (xccScrollBox In FXPContainers)) Or
                ((TControl(Comp).Parent Is TCustomGroupBox) And (xccGroupBox In FXPContainers)) Or
                ((TControl(Comp).Parent Is TTabSheet) And (xccTabSheet In FXPContainers)) Or
                ((TControl(Comp).Parent Is TTabControl) And (xccTabSheet In FXPContainers)) Or
                ((TControl(Comp).Parent.ClassName = 'TdxTabSheet') And (xccTabSheet In FXPContainers)) Or //DeveloperExpress
                ((TControl(Comp).Parent Is TPageScroller) And (xccPageScroller In FXPContainers)) Or
         {$IFDEF VER5U}
                ((TControl(Comp).Parent Is TCustomFrame) And (xccFrame In FXPContainers)) Or
         {$ENDIF}
                ((TControl(Comp).Parent.ClassName = 'TDBCtrlPanel') And (xccFrame In FXPContainers)) Or
                ((TControl(Comp).Parent Is TCustomForm) And (xccForm In FXPContainers))


            Then
            Begin
                If (Enable) And (Comp.Tag <> 999) And (TControl(Comp).Parent.Tag <> 999) Then
                                    {skip if Control/Control.parent.tag = 999}
                    With TControlSubClass.Create(Self) Do
                    Begin
                        Control := TControl(Comp);
                        If Addr(Control.WindowProc) <> Addr(TControlSubClass.ControlSubClass) Then
                        Begin
                            orgWindowProc := Control.WindowProc;
                            Control.WindowProc := ControlSubClass;
                        End;
                        XPMenu := self;

                        If (Control Is TCustomEdit) Then
                        Begin
                            FCtl3D := TEdit(Control).Ctl3D;
                            FBorderStyle := TRichEdit(Control).BorderStyle;
                        End;
                        If Control.ClassName = 'TDBLookupComboBox' Then
                        Begin
                            FCtl3D := TComboBox(Control).Ctl3D;
                        End;
                        If (Control Is TCustomListBox) Then
                        Begin
                            FCtl3D := TListBox(Control).Ctl3D;
                            FBorderStyle := TListBox(Control).BorderStyle;
                        End;
                        If (Control Is TCustomListView) Then
                        Begin
                            FCtl3D := TListView(Control).Ctl3D;
                            FBorderStyle := TListView(Control).BorderStyle;
                        End;
                        If (Control Is TCustomTreeView) Then
                        Begin
                            FCtl3D := TTreeView(Control).Ctl3D;
                            FBorderStyle := TTreeView(Control).BorderStyle;
                        End;

                    End;

                If Update Then
                Begin
                    TControl(Comp).invalidate;    //in TControlSubClass.ControlSubClass
                End;

            End;

  // Recursive call for possible containers.
  // Do recursive call for RadioGroups
    If (((Comp Is TCustomRadioGroup)) And (xccGroupBox In FXPContainers)) Then
        self.InitItems(Comp As TWinControl, Enable, Update);


    If {$IFDEF VER5U}((Comp Is TCustomFrame) And (xccFrame In FXPContainers))
        Or {$ENDIF}(Comp.ClassName = 'TDBNavigator')
        Or (Comp Is TCustomForm) Then  //By Geir Wikran <gwikran@online.no>
        self.InitItems(Comp As TWinControl, Enable, Update);


End;

Procedure TXPMenu.DrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
    Selected: Boolean);
Begin
    Try  //"Steve Rice" <srice@pclink.com>
        If FActive Then
            MenueDrawItem(Sender, ACanvas, ARect, Selected);
    Except
    End;
End;

Function TXPMenu.GetImageExtent(MenuItem: TMenuItem; FTopMenu: TMenu): TPoint;
Var
    HasImgLstBitmap: Boolean;
    B: TBitmap;
Begin
    B := TBitmap.Create;
    Try
        B.Width := 0;
        B.Height := 0;
        Result.x := 0;
        Result.Y := 0;
        HasImgLstBitmap := False;
// +jt
        If Assigned(FTopMenu) Then
        Begin
            If FTopMenu.Images <> Nil Then
                If MenuItem.ImageIndex <> -1 Then
                    HasImgLstBitmap := True;
        End;

        If (MenuItem.Parent.GetParentMenu.Images <> Nil)
    {$IFDEF VER5U}
            Or (MenuItem.Parent.SubMenuImages <> Nil)
    {$ENDIF}
        Then
        Begin
            If MenuItem.ImageIndex <> -1 Then
                HasImgLstBitmap := True
            Else
                HasImgLstBitmap := False;
        End;

        If HasImgLstBitmap Then
        Begin
    {$IFDEF VER5U}
            If MenuItem.Parent.SubMenuImages <> Nil Then
                MenuItem.Parent.SubMenuImages.GetBitmap(MenuItem.ImageIndex, B)
            Else
    {$ENDIF}
                MenuItem.Parent.GetParentMenu.Images.GetBitmap(MenuItem.ImageIndex, B);
        End
        Else
        If MenuItem.Bitmap.Width > 0 Then
            B.Assign(TBitmap(MenuItem.Bitmap));

        Result.x := B.Width;
        Result.Y := B.Height;

        If Not Assigned(FTopMenu) Then // +jt
            If Result.x < FIconWidth Then
                Result.x := FIconWidth;
    Finally
        B.Free;
    End;
End;

Procedure TXPMenu.MeasureItem(Sender: TObject; ACanvas: TCanvas;
    Var Width, Height: Integer);
Var
    s: String;
    W, H: Integer;
    P: TPoint;
    IsLine: Boolean;
    FTopMenu: Boolean; // +jt
    FMenu: TMenu; // +jt
    i: Integer; // +jt
Begin

    FTopMenu := False; //+jt
    If FActive Then
    Begin
        S := TMenuItem(Sender).Caption;

        If S = '-' Then
            IsLine := True Else IsLine := False;
        If IsLine Then
            S := '';

        If Trim(ShortCutToText(TMenuItem(Sender).ShortCut)) <> '' Then
            S := S + ShortCutToText(TMenuItem(Sender).ShortCut) + 'WWW';

        ACanvas.Font.Assign(FFont);
        W := ACanvas.TextWidth(s);
        Inc(W, 5);
        If pos('&', s) > 0 Then
            W := W - ACanvas.TextWidth('&');

// +jt
        FMenu := TMenuItem(Sender).Parent.GetParentMenu;
        If FMenu Is TMainMenu Then
        Begin
            For i := 0 To TMenuItem(Sender).GetParentMenu.Items.Count - 1 Do
                If TMenuItem(Sender).GetParentMenu.Items[i] = TMenuItem(Sender) Then
                Begin
                    FTopMenu := True;
                    break;
                End;
        End;
        If Not FTopMenu Then
            FMenu := Nil;
        If (Not FTopMenu) And (TMenuItem(Sender).Count > 0) Then
            Inc(W, 6); // +jt
// +jt

        P := GetImageExtent(TMenuItem(Sender), FMenu); // +jt
        W := W + P.x;


        If Width < W Then
            Width := W;

        If IsLine Then
            Height := 4
        Else
        Begin
            H := ACanvas.TextHeight(s) + Round(ACanvas.TextHeight(s) * 0.75);
            If P.y + 6 > H Then
                H := P.y + 6;

            If Height < H Then
                Height := H;
        End;
    End;

End;

Procedure TXPMenu.MenueDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
    Selected: Boolean);
Var
    txt: String;
    B: TBitmap;
    IconRect, TextRect, CheckedRect: TRect;
    FillRect: TRect; // +jt
    i, X1, X2: Integer;
    TextFormat: Integer;
    HasImgLstBitmap: Boolean;
    HasBitmap: Boolean;
    FMenuItem: TMenuItem;
    FMenu: TMenu;
    FTopMenu: Boolean;
    IsLine: Boolean;
    ImgListHandle: HImageList;  {Commctrl.pas}
    ImgIndex: Integer;
    hWndM: HWND;
    hDcM: HDC;
    DrawTopMenuBorder: Boolean;
    msg: TMSG; // +jt
    buff: TBitmap; // +jt
    OrigRect: TRect; // +jt
    OrigCanvas: TCanvas; // +jt
Begin


    OrigCanvas := Nil;

    FTopMenu := False;
    FMenuItem := TMenuItem(Sender);

// +jt
    B := TBitmap.Create;
    buff := TBitmap.Create;
    Try
        origrect := ARect;
        Dec(origrect.Left, 4);
        origcanvas := ACanvas;
        ARect.Right := (ARect.Right - ARect.Left) + 4;
        ARect.Bottom := ARect.Bottom - ARect.Top;
        ARect.Left := 4;
        ARect.Top := 0;
        buff.Width := ARect.Right;
        buff.Height := ARect.Bottom;
        ACanvas := buff.Canvas;
  // +jt
  //SetGlobalColor(ACanvas);

        If FMenuItem.Caption = '-' Then
            IsLine := True Else IsLine := False;

        FMenu := FMenuItem.Parent.GetParentMenu;

        If FMenu Is TMainMenu Then
            For i := 0 To FMenuItem.GetParentMenu.Items.Count - 1 Do
                If FMenuItem.GetParentMenu.Items[i] = FMenuItem Then
                Begin
                    FTopMenu := True;
  // +jt
                    ARect.Left := 0;
                    Inc(origrect.Left, 4);
                    Dec(ARect.Right, 4);
                    buff.Width := ARect.Right;
                    Dec(ARect.Bottom, 1);
  // +jt
                    break;
                End;
        If (FColorsChanged) Then
            SetGlobalColor(ACanvas); // +jt

        ACanvas.Font.Assign(FFont);

        Inc(ARect.Bottom, 1);
        TextRect := ARect;
        txt := ' ' + FMenuItem.Caption;

//  B := TBitmap.Create;     //Leslie Cutting lesnes@absamail.co.za  Jul 8 2003
        HasBitmap := False;
        HasImgLstBitmap := False;


        If (FMenuItem.Parent.GetParentMenu.Images <> Nil)
  {$IFDEF VER5U}
            Or (FMenuItem.Parent.SubMenuImages <> Nil)
  {$ENDIF}
        Then
        Begin
            If FMenuItem.ImageIndex <> -1 Then
                HasImgLstBitmap := True
            Else
                HasImgLstBitmap := False;
        End;

        If FMenuItem.Bitmap.Width > 0 Then
            HasBitmap := True;

  //-------
        If HasBitmap Then
        Begin
            B.Width := FMenuItem.Bitmap.Width;
            B.Height := FMenuItem.Bitmap.Height;
  // +jt
     //B.Canvas.Brush.Color := FTransparentColor; // ACanvas.Brush.Color;
            B.Canvas.Brush.Color := B.Canvas.Pixels[0, B.Height - 1];//"Todd Asher" <ashert@yadasystems.com>
            B.Canvas.FillRect(Rect(0, 0, B.Width, B.Height));
            FMenuItem.Bitmap.Transparent := True;
            FMenuItem.Bitmap.TransparentMode := tmAuto;
            B.Canvas.Draw(0, 0, FMenuItem.Bitmap);
  // +jt
        End;


        If HasImgLstBitmap Then
        Begin
  {$IFDEF VER5U}
            If FMenuItem.Parent.SubMenuImages <> Nil Then
            Begin
                ImgListHandle := FMenuItem.Parent.SubMenuImages.Handle;
                ImgIndex := FMenuItem.ImageIndex;

                B.Width := FMenuItem.Parent.SubMenuImages.Width;
                B.Height := FMenuItem.Parent.SubMenuImages.Height;
     // B.Canvas.Brush.Color := FTransparentColor; // ACanvas.Brush.Color; // +jt
                B.Canvas.Brush.Color := B.Canvas.Pixels[0, B.Height - 1];//"Todd Asher" <ashert@yadasystems.com>
                B.Canvas.FillRect(Rect(0, 0, B.Width, B.Height));
                ImageList_DrawEx(ImgListHandle, ImgIndex,
                    B.Canvas.Handle, 0, 0, 0, 0, clNone, clNone, ILD_Transparent);

            End
            Else
  {$ENDIF}
            If FMenuItem.Parent.GetParentMenu.Images <> Nil Then
            Begin
                ImgListHandle := FMenuItem.Parent.GetParentMenu.Images.Handle;
                ImgIndex := FMenuItem.ImageIndex;

                B.Width := FMenuItem.Parent.GetParentMenu.Images.Width;
                B.Height := FMenuItem.Parent.GetParentMenu.Images.Height;
      //B.Canvas.Brush.Color := FTransparentColor; //ACanvas.Pixels[2,2]; // +jt
                B.Canvas.Brush.Color := B.Canvas.Pixels[0, B.Height - 1];//"Todd Asher" <ashert@yadasystems.com>
                B.Canvas.FillRect(Rect(0, 0, B.Width, B.Height));
                ImageList_DrawEx(ImgListHandle, ImgIndex,
                    B.Canvas.Handle, 0, 0, 0, 0, clNone, clNone, ILD_Transparent);

            End;

        End;

  //-----

        If FMenu.IsRightToLeft Then
        Begin
            X1 := ARect.Right - FIconWidth;
            X2 := ARect.Right;
        End
        Else
        Begin
            X1 := ARect.Left;
            X2 := ARect.Left + FIconWidth;
        End;
        IconRect := Rect(X1, ARect.Top, X2, ARect.Bottom);


        If HasImgLstBitmap Or HasBitmap Then
        Begin
            CheckedRect := IconRect;
            Inc(CheckedRect.Left, 1);
            Inc(CheckedRect.Top, 2);
            Dec(CheckedRect.Right, 3);
            Dec(CheckedRect.Bottom, 2);
        End
        Else
        Begin
            CheckedRect.Left := IconRect.Left +
                (IConRect.Right - IconRect.Left - 10) Div 2;
            CheckedRect.Top := IconRect.Top +
                (IConRect.Bottom - IconRect.Top - 10) Div 2;
            CheckedRect.Right := CheckedRect.Left + 10;
            CheckedRect.Bottom := CheckedRect.Top + 10;
        End;

        If B.Width > FIconWidth Then
            If FMenu.IsRightToLeft Then
                CheckedRect.Left := CheckedRect.Right - B.Width
            Else
                CheckedRect.Right := CheckedRect.Left + B.Width;

        If FTopMenu Then
            Dec(CheckedRect.Top, 1);


        If FMenu.IsRightToLeft Then
        Begin
            X1 := ARect.Left;
            If Not FTopMenu Then
                Dec(X2, FIconWidth)
            Else
                Dec(X2, 4);
            If (ARect.Right - B.Width) < X2 Then
                X2 := ARect.Right - B.Width - 8;
        End
        Else
        Begin
            X1 := ARect.Left;
            If Not FTopMenu Then
                Inc(X1, FIconWidth)
            Else
                Inc(X1, 4);

            If (ARect.Left + B.Width) > X1 Then
                X1 := ARect.Left + B.Width + 4;
            X2 := ARect.Right;
        End;

        TextRect := Rect(X1, ARect.Top, X2, ARect.Bottom);
  // +jt
        FillRect := ARect;
        Dec(FillRect.Left, 4);
  // +jt

        If FTopMenu Then
        Begin
            If Not (HasImgLstBitmap Or HasBitmap) Then
            Begin
                TextRect := ARect;
            End
            Else
            Begin
                If FMenu.IsRightToLeft Then
                    TextRect.Right := TextRect.Right + 5
                Else
                    TextRect.Left := TextRect.Left - 5;
            End;

        End;

        If FTopMenu Then
        Begin
            If FDrawMenuBar Then
                FFMenuBarColor := FMenuBarColor;
            ACanvas.brush.color := FFMenuBarColor;
            ACanvas.Pen.Color := FFMenuBarColor;
  //    Inc(ARect.Bottom, 2);
            ACanvas.FillRect(ARect);

  //--
            If FDrawMenuBar Then
            Begin
                If FMenuItem.GetParentMenu.Items[FMenuItem.GetParentMenu.Items.Count - 1] =
                    FMenuItem Then
                Begin
                    If FMenu.IsRightToLeft Then
                        ACanvas.Rectangle(3, ARect.Top, ARect.Right, ARect.Bottom)
                    Else
                        ACanvas.Rectangle(ARect.Left, ARect.Top, TScrollingWinControl(FMenu.Owner).ClientWidth + 5{FForm.ClientWidth+5},
                            ARect.Bottom);
                End
                Else
                If FMenu.IsRightToLeft Then
                    ACanvas.Rectangle(ARect.Left, ARect.Top, ARect.Right + 7, ARect.Bottom);
            End;
  //--
        End
        Else
        Begin
            If (Is16Bit And FGradient) Then
            Begin
                inc(ARect.Right, 2);  //needed for RightToLeft
                DrawGradient(ACanvas, ARect, FMenu.IsRightToLeft);
                Dec(ARect.Right, 2);

            End
            Else
            Begin
                ACanvas.brush.color := FFColor;
                ACanvas.FillRect(FillRect); // +jt
                ACanvas.brush.color := FFIconBackColor;
                ACanvas.FillRect(IconRect);
            End;


  //------------
        End;


        If FMenuItem.Enabled Then
            ACanvas.Font.Color := FFont.Color
        Else
            ACanvas.Font.Color := FDisabledColor;

        DrawTopMenuBorder := False;
        If Selected And FDrawSelect Then
        Begin
            ACanvas.brush.Style := bsSolid;
            If FTopMenu Then
            Begin
                DrawTopMenuItem(FMenuItem, ACanvas, ARect, FMenuBarColor, FMenu.IsRightToLeft);
            End
            Else
            If FMenuItem.Enabled Then
            Begin
                Inc(ARect.Top, 1);
                Dec(ARect.Bottom, 1);
                If FFlatMenu Then
                    Dec(ARect.Right, 1);
                ACanvas.brush.color := FFSelectColor;
                ACanvas.FillRect(ARect);
                ACanvas.Pen.color := FFSelectBorderColor;
                ACanvas.Brush.Style := bsClear;
                ACanvas.RoundRect(Arect.Left, Arect.top, Arect.Right, Arect.Bottom, 0, 0);
                Dec(ARect.Top, 1);
                Inc(ARect.Bottom, 1);
                If FFlatMenu Then
                    Inc(ARect.Right, 1);
            End;
            DrawTopMenuBorder := True;
        End

  // Draw the menubar in XP Style when hovering over an main menu item
        Else
        Begin
    //if FMenuItem.Enabled and FTopMenu and IsMouseInRect( TScrollingWinControl(FMenu.Owner), ARect) then
            If FMenuItem.Enabled And FTopMenu And IsWNT And
                IsMouseInRect(TScrollingWinControl(FMenu.Owner), origrect) Then // +jt
            Begin
                ACanvas.brush.Style := bsSolid;
                ACanvas.brush.color := FFSelectColor;
                DrawTopMenuBorder := True;
                ACanvas.Pen.color := FFSelectBorderColor;
                ACanvas.Rectangle(ARect.Left, ARect.Top, ARect.Right - 7, ARect.Bottom);
            End;
        End;


        If (FMenuItem.Checked) Or (FMenuItem.RadioItem) Then  //x
            DrawCheckedItem(FMenuItem, Selected, FMenuItem.Enabled, HasImgLstBitmap Or HasBitmap,
                ACanvas, CheckedRect);

        If (B <> Nil) And (B.Width > 0) Then  // X
            DrawIcon(FMenuItem, ACanvas, B, IconRect,
                Selected Or DrawTopMenuBorder, False, FMenuItem.Enabled, FMenuItem.Checked,
                FTopMenu, FMenu.IsRightToLeft);



        If Not IsLine Then
        Begin

            If FMenu.IsRightToLeft Then
            Begin
                TextFormat := DT_RIGHT + DT_RTLREADING;
                Dec(TextRect.Right, 3);
            End
            Else
            Begin
                TextFormat := 0;
                Inc(TextRect.Left, 3);
            End;
            TextRect.Top := TextRect.Top +
                ((TextRect.Bottom - TextRect.Top) - ACanvas.TextHeight('W')) Div 2;
            DrawTheText(FMenuItem, txt, ShortCutToText(FMenuItem.ShortCut),
                ACanvas, TextRect,
                Selected, FMenuItem.Enabled, FMenuItem.Default,
                FTopMenu, FMenu.IsRightToLeft, FFont, TextFormat);

        End
        Else
        Begin
            If FMenu.IsRightToLeft Then
            Begin
                X1 := TextRect.Left;
                X2 := TextRect.Right - 7;
            End
            Else
            Begin
                X1 := TextRect.Left + 7;
                X2 := TextRect.Right;
            End;

            ACanvas.Pen.Color := FFSeparatorColor;
            ACanvas.MoveTo(X1,
                TextRect.Top +
                Round((TextRect.Bottom - TextRect.Top) / 2));
            ACanvas.LineTo(X2,
                TextRect.Top +
                Round((TextRect.Bottom - TextRect.Top) / 2));
        End;

  // +jt
        BitBlt(origcanvas.Handle, origrect.Left, origrect.Top, buff.Width, buff.Height, ACanvas.Handle, 0, 0, SRCCOPY);
    Finally
        B.free;
        buff.free;
        ACanvas := OrigCanvas;
        ARect := origrect;
    End;
// +jt

    If Not (csDesigning In ComponentState) Then
    Begin
        If (FFlatMenu) And (Not FTopMenu) Then
        Begin
            hDcM := ACanvas.Handle;
            hWndM := WindowFromDC(hDcM);
// +jt
            If (hWndM = 0) And (Application.Handle <> 0) Then
            Begin
                If Not PeekMessage(msg, Application.Handle, WM_DRAWMENUBORDER, WM_DRAWMENUBORDER2, PM_NOREMOVE) Then
                    PostMessage(Application.Handle, WM_DRAWMENUBORDER, 0, Integer(FMenuItem));
            End
            Else
            If hWndM <> FForm.Handle Then
            Begin
                If Not PeekMessage(msg, Application.Handle, WM_DRAWMENUBORDER, WM_DRAWMENUBORDER2, PM_NOREMOVE) Then
                    PostMessage(Application.Handle, WM_DRAWMENUBORDER2, Integer(FMenu.IsRightToLeft), Integer(hWndM));
            End;
        End;
    End;

//-----

End;

{$IFDEF VER5U}
Procedure TXPMenu.ToolBarDrawButton(Sender: TToolBar;
    Button: TToolButton; State: TCustomDrawState; Var DefaultDraw: Boolean);

Var
    ACanvas: TCanvas;

    ARect, HoldRect: TRect;
    B: TBitmap;
    HasBitmap: Boolean;
  {Sylvain ...}
    HasHotBitMap: Boolean;
    HasDisBitMap: Boolean;
    ImglstHand: THandle;
    CanDraw: Boolean;
  {... Sylvain}
    BitmapWidth: Integer;
    TextFormat: Integer;
    XButton: TToolButton;
    HasBorder: Boolean;
    HasBkg: Boolean;
    IsTransparent: Boolean;
    FBSelectColor: TColor;

    Procedure DrawBorder;
    Var
        BRect, WRect: TRect;
        Procedure DrawRect;
        Begin
            ACanvas.Pen.color := FFSelectBorderColor;
            ACanvas.MoveTo(WRect.Left, WRect.Top);
            ACanvas.LineTo(WRect.Right, WRect.Top);
            ACanvas.LineTo(WRect.Right, WRect.Bottom);
            ACanvas.LineTo(WRect.Left, WRect.Bottom);
            ACanvas.LineTo(WRect.Left, WRect.Top);
        End;

    Begin
        BRect := HoldRect;
        Dec(BRect.Bottom, 1);
        Inc(BRect.Top, 1);
        Dec(BRect.Right, 1);

        WRect := BRect;
        If Button.Style = tbsDropDown Then
        Begin
            Dec(WRect.Right, 13);
            DrawRect;

            WRect := BRect;
            Inc(WRect.Left, WRect.Right - WRect.Left - 13);
            DrawRect;
        End
        Else
        Begin

            DrawRect;
        End;
    End;

Begin

    B := Nil;

  {Added By Sylvain ...}
    HasHotBitmap := (Sender.HotImages <> Nil) And
        (Button.ImageIndex <> -1) And
        (Button.ImageIndex <= Sender.HotImages.Count - 1);


    HasDisBitmap := (Sender.DisabledImages <> Nil) And
        (Button.ImageIndex <> -1) And
        (Button.ImageIndex <= Sender.DisabledImages.Count - 1);
  {...Sylvain}

    HasBitmap := (Sender.Images <> Nil) And
        (Button.ImageIndex <> -1) And
        (Button.ImageIndex <= Sender.Images.Count - 1);


    IsTransparent := Sender.Transparent;

    ACanvas := Sender.Canvas;

  //SetGlobalColor(ACanvas);
    If (FColorsChanged) Then
        SetGlobalColor(ACanvas); // +jt

    If (Is16Bit) And (Not UseSystemColors) Then
        FBSelectColor := NewColor(ACanvas, FSelectColor, 68)
    Else
        FBSelectColor := FFSelectColor;


    HoldRect := Button.BoundsRect;

    ARect := HoldRect;

    If Is16Bit Then
        ACanvas.brush.color := NewColor(ACanvas, Sender.Color, 16)
    Else
        ACanvas.brush.color := Sender.Color;

    If Not IsTransparent Then
        ACanvas.FillRect(ARect);

    HasBorder := False;
    HasBkg := False;

    If (cdsHot In State) Then
    Begin
        If (cdsChecked In State) Or (Button.Down) Or (cdsSelected In State) Then
            ACanvas.Brush.Color := FCheckedAreaSelectColor
        Else
            ACanvas.brush.color := FBSelectColor;
        HasBorder := True;
        HasBkg := True;
    End;

    If ((cdsChecked In State) And Not (cdsHot In State)) Then
    Begin
        ACanvas.Brush.Color := FCheckedAreaColor;
        HasBorder := True;
        HasBkg := True;
    End;

    If (cdsIndeterminate In State) And Not (cdsHot In State) Then
    Begin
        ACanvas.Brush.Color := FBSelectColor;
        HasBkg := True;
    End;


    If (Button.MenuItem <> Nil) And (State = []) Then
    Begin
        ACanvas.brush.color := Sender.Color;
        If Not IsTransparent Then
            HasBkg := True;
    End;


    Inc(ARect.Top, 1);



    If HasBkg Then
        ACanvas.FillRect(ARect);

    If HasBorder Then
        DrawBorder;


    If ((Button.MenuItem <> Nil) Or (Button.DropdownMenu <> Nil))
        And (cdsSelected In State) Then
    Begin
        DrawTopMenuItem(Button, ACanvas, ARect, Sender.Color, False);
        DefaultDraw := False;
    End;

    ARect := HoldRect;
    DefaultDraw := False;


    If Button.Style = tbsDropDown Then
    Begin
        ACanvas.Pen.Color := clBlack;
        DrawArrow(ACanvas, (ARect.Right - 14) + ((14 - 5) Div 2),
            ARect.Top + ((ARect.Bottom - ARect.Top - 3) Div 2) + 1);
    End;

    BitmapWidth := 0;
{ Rem by Sylvain ...
  if HasBitmap then
  begin
... Sylvain}
    Try
        B := TBitmap.Create;
        CanDraw := False;
        ImglstHand := 0;
        If (cdsHot In State) And HasHotBitmap Then
        Begin
            B.Width := Sender.HotImages.Width;
            B.Height := Sender.HotImages.Height;
            ImglstHand := Sender.HotImages.Handle;
            CanDraw := True;
        End
        Else
        If (cdsDisabled In State) And HasDisBitmap Then
        Begin
            B.Width := Sender.DisabledImages.Width;
            B.Height := Sender.DisabledImages.Height;
            ImglstHand := Sender.DisabledImages.Handle;
            CanDraw := True;
        End
        Else
        If HasBitMap Then
        Begin
            B.Width := Sender.Images.Width;
            B.Height := Sender.Images.Height;
            ImglstHand := Sender.Images.Handle;
            CanDraw := True;
        End;
        If CanDraw Then
        Begin {CanDraw}
       // B.Canvas.Brush.Color := TransparentColor; // ACanvas.Brush.Color; // +jt
            B.Canvas.Brush.Color := B.Canvas.Pixels[0, B.Height - 1];//"Todd Asher" <ashert@yadasystems.com>
            B.Canvas.FillRect(Rect(0, 0, B.Width, B.Height));
            ImageList_DrawEx(ImglstHand, Button.ImageIndex,
                B.Canvas.Handle, 0, 0, 0, 0, clNone, clNone, ILD_Transparent);

            BitmapWidth := b.Width;

            If Button.Style = tbsDropDown Then
                Dec(ARect.Right, 12);


            If TToolBar(Button.Parent).List Then
            Begin

                If Button.BiDiMode = bdRightToLeft Then
                Begin
                    Dec(ARect.Right, 3);
                    ARect.Left := ARect.Right - BitmapWidth;

                End
                Else
                Begin
                    Inc(ARect.Left, 3);
                    ARect.Right := ARect.Left + BitmapWidth;
                End;


            End
            Else
                ARect.Left := Round(ARect.Left + (ARect.Right - ARect.Left - B.Width) / 2);

            inc(ARect.Top, 2);
            ARect.Bottom := ARect.Top + B.Height + 6;

            DrawIcon(Button, ACanvas, B, ARect, (cdsHot In State),
                (cdsSelected In State), Button.Enabled, (cdsChecked In State), False,
                False);

        End; {CanDraw}
    Finally
        B.Free;
    End;
    ARect := HoldRect;
    DefaultDraw := False;
{rem by sylvain ...
  end;
...Sylvain}
//-----------

    If Sender.ShowCaptions Then
    Begin

        If Button.Style = tbsDropDown Then
            Dec(ARect.Right, 12);


        If Not TToolBar(Button.Parent).List Then
        Begin
            TextFormat := DT_Center;

            ARect.Top := ARect.Bottom - ACanvas.TextHeight(Button.Caption) - 6;
        End
        Else
        Begin
            TextFormat := DT_VCENTER;
            If Button.BiDiMode = bdRightToLeft Then
            Begin
                TextFormat := TextFormat + DT_Right;
                Dec(ARect.Right, BitmapWidth + 7);
            End
            Else
            Begin
                If BitmapWidth > 0 Then //"Dan Downs" <dan@laserformsinc.com>
                    If Sender.List Then     //Michaël Moreno <michael@weatherderivs.com>
                        Inc(ARect.Left, BitmapWidth + 6)
                    Else
                        Inc(ARect.Left, BitmapWidth);
            End;

        End;

        If (Button.MenuItem <> Nil) Then
        Begin
            TextFormat := DT_Center;
      //Inc(ARect.Left, 1);
        End;

        If Button.BiDiMode = bdRightToLeft Then
            TextFormat := TextFormat + DT_RTLREADING;

        If Button.Down And Not Button.Enabled Then //"felix" <felix@unidreamtech.com>  23/5
            InflateRect(ARect, -1, -1);

    {alexs alexs75@hotbox.ru}
        ARect.Top := ARect.Top + ((ARect.Bottom - ARect.Top) - ACanvas.TextHeight('W')) Div 2;

        DrawTheText(Button, Button.Caption, '',
            ACanvas, ARect,
            (cdsSelected In State), Button.Enabled, False,
            (Button.MenuItem <> Nil),
            (Button.BidiMode = bdRightToLeft), FFont, TextFormat);

        ARect := HoldRect;
        DefaultDraw := False;
    End;


    If Button.Index > 0 Then
    Begin
        XButton := {TToolBar(Button.Parent)}Sender.Buttons[Button.Index - 1];
        If (XButton.Style = tbsDivider) Or (XButton.Style = tbsSeparator) Then
        Begin
            ARect := XButton.BoundsRect;
            If Is16Bit Then
                ACanvas.brush.color := NewColor(ACanvas, Sender.Color, 16)
            Else
                ACanvas.brush.color := Sender.Color;

            If Not IsTransparent Then
                ACanvas.FillRect(ARect);
     // if (XButton.Style = tbsDivider) then  // Can't get it.
            If XButton.Tag > 0 Then
            Begin
                Inc(ARect.Top, 2);
                Dec(ARect.Bottom, 1);

                ACanvas.Pen.color := GetShadeColor(ACanvas, Sender.Color, 30);
                ARect.Left := ARect.Left + (ARect.Right - ARect.Left) Div 2;
                ACanvas.MoveTo(ARect.Left, ARect.Top);
                ACanvas.LineTo(ARect.Left, ARect.Bottom);

            End;
            ARect := Button.BoundsRect;
            DefaultDraw := False;
        End;

    End;

  {if Button.MenuItem <> nil then
    if (xcMainMenu in XPControls) then
      ActivateMenuItem(Button.MenuItem);}
End;
{$ENDIF}

// Controlbar Paint. Added by Michiel van Oudheusden (27 sep 2001)
// Paints the bands of a controlbar like the office XP style
Procedure TXPMenu.ControlBarPaint(Sender: TObject; Control: TControl;
    Canvas: TCanvas; Var ARect: TRect; Var Options: TBandPaintOptions);
Var
    i: Integer;
    intInc: Integer;
Begin

    If (FColorsChanged) Then
        SetGlobalColor(Canvas); // +jt
  // No frame and grabber drawing. We do it ourselfes
    Options := [];

  // First background

    If Is16Bit Then
        Canvas.brush.color := NewColor(Canvas, TControlBar(Sender).Color, 6)
    Else
        Canvas.brush.color := TControlBar(Sender).Color;

    Canvas.FillRect(ARect);

    intInc := 30;
    For i := (ARect.Top + 5) To (ARect.Bottom - 5) Do
    Begin
        Canvas.Pen.Color := GetShadeColor(Canvas, TControlBar(Sender).Color, intInc);
        If i Mod 2 = 0 Then
        Begin
            Canvas.MoveTo(ARect.Left + 3, i);
            Canvas.LineTo(ARect.Left + 6, i);
            Inc(intInc, 7);
        End;
    End;

End;

Procedure TXPMenu.SetGlobalColor(ACanvas: TCanvas);
Begin
//-----
    FColorsChanged := False; // +jt

    If GetDeviceCaps(ACanvas.Handle, BITSPIXEL) < 16 Then
        Is16Bit := False
    Else
        Is16Bit := True;


    FDimParentColor := 16;
    FDimParentColorSelect := 40;

    FFColor := FColor;
    FFIconBackColor := FIconBackColor;

    If Is16Bit Then
    Begin
        If FUseDimColor Then
        Begin
            FFSelectColor := NewColor(ACanvas, FSelectColor, 68);
            FCheckedAreaColor := NewColor(ACanvas, FSelectColor, 80);
            FCheckedAreaSelectColor := NewColor(ACanvas, FSelectColor, 50);
        End
        Else
        Begin
            FFSelectColor := FSelectColor;
            FCheckedAreaColor := FSelectColor;
            FCheckedAreaSelectColor := FSelectColor;
        End;

        FMenuBorderColor := GetShadeColor(ACanvas, clBtnFace, 90);
        FMenuShadowColor := GetShadeColor(ACanvas, clBtnFace, 76);
    End
    Else
    Begin
        FFSelectColor := FSelectColor;
        FCheckedAreaColor := clWhite;
        FCheckedAreaSelectColor := clSilver;
        FMenuBorderColor := clBtnShadow;
        FMenuShadowColor := clBtnShadow;
    End;

    FFSelectBorderColor := FSelectBorderColor;
    FFSelectFontColor := FSelectFontColor;
    FFMenuBarColor := FMenuBarColor;
    FFDisabledColor := FDisabledColor;
    FFCheckedColor := FCheckedColor;
    FFSeparatorColor := FSeparatorColor;



    If FUseSystemColors Then
    Begin
//    GetSystemMenuFont(FFont);
        FFSelectFontColor := FFont.Color;
        If Not Is16Bit Then
        Begin
            FFColor := clWhite;
            FFIconBackColor := clBtnFace;
            FFSelectColor := clWhite;
            FFSelectBorderColor := clHighlight;
            FFMenuBarColor := FFIconBackColor;
            FFDisabledColor := clBtnShadow;
            FFCheckedColor := clHighlight;
            FFSeparatorColor := clBtnShadow;
            FCheckedAreaColor := clWhite;
            FCheckedAreaSelectColor := clWhite;

        End
        Else
        Begin
            FFColor := NewColor(ACanvas, clBtnFace, 86);
            FFIconBackColor := NewColor(ACanvas, clBtnFace, 16);
            FFSelectColor := NewColor(ACanvas, clHighlight, 68);
            FFSelectBorderColor := clHighlight;
            FFMenuBarColor := clBtnFace;

            FFDisabledColor := NewColor(ACanvas, clBtnShadow, 10);
            FFSeparatorColor := NewColor(ACanvas, clBtnShadow, 25);
            FFCheckedColor := clHighlight;
            FCheckedAreaColor := NewColor(ACanvas, clHighlight, 80);
            FCheckedAreaSelectColor := NewColor(ACanvas, clHighlight, 50);

        End;
    End;

End;

Procedure TXPMenu.DrawTopMenuItem(Sender: TObject; ACanvas: TCanvas;
    ARect: TRect; BckColor: Tcolor; IsRightToLeft: Boolean);
Var
    X1, X2: Integer;
    DefColor, HoldColor: TColor;
Begin
    X1 := ARect.Left;
    X2 := ARect.Right;


    ACanvas.brush.Style := bsSolid;
    ACanvas.brush.color := FFSelectColor;

    ACanvas.FillRect(ARect);
    ACanvas.Pen.Color := FFSelectBorderColor;

    If (Not IsRightToLeft) And (Is16Bit) And (Sender Is TMenuItem) Then
    Begin
        ACanvas.MoveTo(X1, ARect.Bottom - 1);
        ACanvas.LineTo(X1, ARect.Top);
        ACanvas.LineTo(X2 - 8, ARect.Top);
        ACanvas.LineTo(X2 - 8, ARect.Bottom);
//    ACanvas.LineTo(X1, ARect.Bottom);

        DefColor := FFMenuBarColor;


        HoldColor := GetShadeColor(ACanvas, DefColor, 10);
        ACanvas.Brush.Style := bsSolid;
        ACanvas.Brush.Color := HoldColor;
        ACanvas.Pen.Color := HoldColor;

        ACanvas.FillRect(Rect(X2 - 7, ARect.Top, X2, ARect.Bottom));

        HoldColor := GetShadeColor(ACanvas, DefColor, 30);
        ACanvas.Brush.Color := HoldColor;
        ACanvas.Pen.Color := HoldColor;
        ACanvas.FillRect(Rect(X2 - 7, ARect.Top + 3, X2 - 2, ARect.Bottom));

        HoldColor := GetShadeColor(ACanvas, DefColor, 40 + 20);
        ACanvas.Brush.Color := HoldColor;
        ACanvas.Pen.Color := HoldColor;
        ACanvas.FillRect(Rect(X2 - 7, ARect.Top + 5, X2 - 3, ARect.Bottom));

        HoldColor := GetShadeColor(ACanvas, DefColor, 60 + 40);
        ACanvas.Brush.Color := HoldColor;
        ACanvas.Pen.Color := HoldColor;
        ACanvas.FillRect(Rect(X2 - 7, ARect.Top + 6, X2 - 5, ARect.Bottom));

    //---

        ACanvas.Pen.Color := DefColor;
        ACanvas.MoveTo(X2 - 5, ARect.Top + 1);
        ACanvas.LineTo(X2 - 1, ARect.Top + 1);
        ACanvas.LineTo(X2 - 1, ARect.Top + 6);

        ACanvas.MoveTo(X2 - 3, ARect.Top + 2);
        ACanvas.LineTo(X2 - 2, ARect.Top + 2);
        ACanvas.LineTo(X2 - 2, ARect.Top + 3);
        ACanvas.LineTo(X2 - 3, ARect.Top + 3);



        ACanvas.Pen.Color := GetShadeColor(ACanvas, DefColor, 10);
        ACanvas.MoveTo(X2 - 6, ARect.Top + 3);
        ACanvas.LineTo(X2 - 3, ARect.Top + 3);
        ACanvas.LineTo(X2 - 3, ARect.Top + 6);
        ACanvas.LineTo(X2 - 4, ARect.Top + 6);
        ACanvas.LineTo(X2 - 4, ARect.Top + 3);

        ACanvas.Pen.Color := GetShadeColor(ACanvas, DefColor, 30);
        ACanvas.MoveTo(X2 - 5, ARect.Top + 5);
        ACanvas.LineTo(X2 - 4, ARect.Top + 5);
        ACanvas.LineTo(X2 - 4, ARect.Top + 9);

        ACanvas.Pen.Color := GetShadeColor(ACanvas, DefColor, 40);
        ACanvas.MoveTo(X2 - 6, ARect.Top + 5);
        ACanvas.LineTo(X2 - 6, ARect.Top + 7);

    End
    Else
    Begin

        ACanvas.Pen.Color := FFSelectBorderColor;
        ACanvas.Brush.Color := GetShadeColor(ACanvas, BckColor, 70);

        ACanvas.MoveTo(X1, ARect.Bottom - 1);
        ACanvas.LineTo(X1, ARect.Top);
        ACanvas.LineTo(X2 - 3, ARect.Top);
        ACanvas.LineTo(X2 - 3, ARect.Bottom);


        ACanvas.Pen.Color := ACanvas.Brush.Color;
        ACanvas.FillRect(Rect(X2 - 2, ARect.Top + 2, X2, ARect.Bottom));

        ACanvas.Brush.Color := BckColor;
        ACanvas.FillRect(Rect(X2 - 2, ARect.Top, X2, ARect.Top + 2));


    End;

End;


Procedure TXPMenu.DrawCheckedItem(FMenuItem: TMenuItem; Selected, Enabled,
    HasImgLstBitmap: Boolean; ACanvas: TCanvas; CheckedRect: TRect);
Var
    X1, X2: Integer;
Begin
    If FMenuItem.RadioItem Then
    Begin
        If FMenuItem.Checked Then
        Begin
            If Enabled Then
            Begin
                ACanvas.Pen.color := FFSelectBorderColor;
                If selected Then
                    ACanvas.Brush.Color := FCheckedAreaSelectColor
                Else
                    ACanvas.Brush.Color := FCheckedAreaColor;
            End
            Else
                ACanvas.Pen.color := FFDisabledColor;

            ACanvas.Brush.Style := bsSolid;
            If HasImgLstBitmap Then
            Begin
                ACanvas.RoundRect(CheckedRect.Left, CheckedRect.Top,
                    CheckedRect.Right, CheckedRect.Bottom,
                    6, 6);
            End
            Else
            Begin
                ACanvas.Ellipse(CheckedRect.Left, CheckedRect.Top,
                    CheckedRect.Right, CheckedRect.Bottom);
// +jt
                InflateRect(CheckedRect, -2, -2);
                ACanvas.Brush.color := ACanvas.Pen.Color;
                ACanvas.Ellipse(CheckedRect.Left, CheckedRect.Top,
                    CheckedRect.Right, CheckedRect.Bottom);
// +jt
            End;
        End;
    End
    Else
    Begin
        If (FMenuItem.Checked) Then
            If (Not HasImgLstBitmap) Then
            Begin
                If Enabled Then
                Begin
                    ACanvas.Pen.color := FFCheckedColor;
                    If selected Then
                        ACanvas.Brush.Color := FCheckedAreaSelectColor
                    Else
                        ACanvas.Brush.Color := FCheckedAreaColor; ;
                End
                Else
                    ACanvas.Pen.color := FFDisabledColor;

                ACanvas.Brush.Style := bsSolid;
                ACanvas.Rectangle(CheckedRect.Left, CheckedRect.Top,
                    CheckedRect.Right, CheckedRect.Bottom);
                If Enabled Then
                    ACanvas.Pen.color := clBlack
                Else
                    ACanvas.Pen.color := FFDisabledColor;
                x1 := CheckedRect.Left + 1;
                x2 := CheckedRect.Top + 5;
                ACanvas.MoveTo(x1, x2);

                x1 := CheckedRect.Left + 4;
                x2 := CheckedRect.Bottom - 2;
                ACanvas.LineTo(x1, x2);
        //--
                x1 := CheckedRect.Left + 2;
                x2 := CheckedRect.Top + 5;
                ACanvas.MoveTo(x1, x2);

                x1 := CheckedRect.Left + 4;
                x2 := CheckedRect.Bottom - 3;
                ACanvas.LineTo(x1, x2);
        //--
                x1 := CheckedRect.Left + 2;
                x2 := CheckedRect.Top + 4;
                ACanvas.MoveTo(x1, x2);

                x1 := CheckedRect.Left + 5;
                x2 := CheckedRect.Bottom - 3;
                ACanvas.LineTo(x1, x2);
        //-----------------

                x1 := CheckedRect.Left + 4;
                x2 := CheckedRect.Bottom - 3;
                ACanvas.MoveTo(x1, x2);

                x1 := CheckedRect.Right + 2;
                x2 := CheckedRect.Top - 1;
                ACanvas.LineTo(x1, x2);
        //--
                x1 := CheckedRect.Left + 4;
                x2 := CheckedRect.Bottom - 2;
                ACanvas.MoveTo(x1, x2);

                x1 := CheckedRect.Right - 2;
                x2 := CheckedRect.Top + 3;
                ACanvas.LineTo(x1, x2);

            End
            Else
            Begin


                If Enabled Then
                Begin
                    ACanvas.Pen.color := FFSelectBorderColor;
                    If selected Then
                        ACanvas.Brush.Color := FCheckedAreaSelectColor
                    Else
                        ACanvas.Brush.Color := FCheckedAreaColor; ;
                End
                Else
                    ACanvas.Pen.color := FFDisabledColor;

                ACanvas.Brush.Style := bsSolid;
                ACanvas.Rectangle(CheckedRect.Left, CheckedRect.Top,
                    CheckedRect.Right, CheckedRect.Bottom);
            End;
    End;

End;

Procedure TXPMenu.DrawTheText(Sender: TObject; txt, ShortCuttext: String;
    ACanvas: TCanvas; TextRect: TRect;
    Selected, Enabled, Default, TopMenu, IsRightToLeft: Boolean;
    Var TxtFont: TFont; TextFormat: Integer);
Var
    DefColor: TColor;
    B: TBitmap;
    BRect: TRect;
Begin
    TextFormat := TextFormat + DT_EXPANDTABS;
    DefColor := TxtFont.Color;

    ACanvas.Font.Assign(TxtFont);

    If Selected Then
        DefColor := FFSelectFontColor;

    If Not Enabled Then
    Begin
        DefColor := FFDisabledColor;

        If (Sender Is TToolButton) Then
        Begin
            TextRect.Top := TextRect.Top +
                ((TextRect.Bottom - TextRect.Top) - ACanvas.TextHeight('W')) Div 2;
            B := TBitmap.Create;
            Try
                B.Width := TextRect.Right - TextRect.Left;
                B.Height := TextRect.Bottom - TextRect.Top;
                BRect := Rect(0, 0, B.Width, B.Height);


                B.Canvas.Brush.Color := ACanvas.Brush.Color;
                B.Canvas.FillRect(BRect);
  //      B.Canvas.Font := FFont; //felix added for resolving font problems in Win98
                                //27.08
                B.Canvas.Font.color := DefColor;

                DrawtextEx(B.Canvas.Handle,
                    Pchar(txt),
                    Length(txt),
                    BRect, TextFormat + DT_VCENTER, Nil);
                ACanvas.CopyRect(TextRect, B.Canvas, BRect);
            Finally
                B.Free;
            End;
            exit;
        End;

    End;

    If (TopMenu And Selected) Then
        If FUseSystemColors Then
            DefColor := TopMenuFontColor(ACanvas, FFIconBackColor);

    ACanvas.Font.color := DefColor;    // will not affect Buttons

    SetBkMode(ACanvas.Handle, TRANSPARENT);


    If Default And Enabled Then
    Begin

        Inc(TextRect.Left, 1);
        ACanvas.Font.color := GetShadeColor(ACanvas,
            ACanvas.Pixels[TextRect.Left, TextRect.Top], 30);
        DrawtextEx(ACanvas.Handle,
            Pchar(txt),
            Length(txt),
            TextRect, TextFormat, Nil);
        Dec(TextRect.Left, 1);


        Inc(TextRect.Top, 2);
        Inc(TextRect.Left, 1);
        Inc(TextRect.Right, 1);


        ACanvas.Font.color := GetShadeColor(ACanvas,
            ACanvas.Pixels[TextRect.Left, TextRect.Top], 30);
        DrawtextEx(ACanvas.Handle,
            Pchar(txt),
            Length(txt),
            TextRect, TextFormat, Nil);


        Dec(TextRect.Top, 1);
        Dec(TextRect.Left, 1);
        Dec(TextRect.Right, 1);

        ACanvas.Font.color := GetShadeColor(ACanvas,
            ACanvas.Pixels[TextRect.Left, TextRect.Top], 40);
        DrawtextEx(ACanvas.Handle,
            Pchar(txt),
            Length(txt),
            TextRect, TextFormat, Nil);


        Inc(TextRect.Left, 1);
        Inc(TextRect.Right, 1);

        ACanvas.Font.color := GetShadeColor(ACanvas,
            ACanvas.Pixels[TextRect.Left, TextRect.Top], 60);
        DrawtextEx(ACanvas.Handle,
            Pchar(txt),
            Length(txt),
            TextRect, TextFormat, Nil);

        Dec(TextRect.Left, 1);
        Dec(TextRect.Right, 1);
        Dec(TextRect.Top, 1);

        ACanvas.Font.color := DefColor;
    End;

    DrawtextEx(ACanvas.Handle,
        Pchar(txt),
        Length(txt),
        TextRect, TextFormat, Nil);


    txt := ShortCutText + ' ';
  {
  if not Is16Bit then
    ACanvas.Font.color := DefColor
  else
    ACanvas.Font.color := GetShadeColor(ACanvas, DefColor, -40);
  }


    If IsRightToLeft Then
    Begin
        Inc(TextRect.Left, 10);
        TextFormat := DT_LEFT;
    End
    Else
    Begin
        Dec(TextRect.Right, 10);
        TextFormat := DT_RIGHT;
    End;


    DrawtextEx(ACanvas.Handle,
        Pchar(txt),
        Length(txt),
        TextRect, TextFormat, Nil);

End;

Procedure TXPMenu.DrawIcon(Sender: TObject; ACanvas: TCanvas; B: TBitmap;
    IconRect: Trect; Hot, Selected, Enabled, Checked, FTopMenu,
    IsRightToLeft: Boolean);
Var
    DefColor: TColor;
    X, Y: Integer;
Begin

    If (B <> Nil) And (B.Width > 0) Then
    Begin
        X := IconRect.Left;
        Y := IconRect.Top + 1;

        If (Sender Is TMenuItem) Then
        Begin
            inc(Y, 2);
            If FIconWidth > B.Width Then
                X := X + ((FIconWidth - B.Width) Div 2) - 1
            Else
            Begin
                If IsRightToLeft Then
                    X := IconRect.Right - b.Width - 2
                Else
                    X := IconRect.Left + 2;
            End;
        End;

        If FTopMenu Then
        Begin
            If IsRightToLeft Then
                X := IconRect.Right - b.Width - 5
            Else
                X := IconRect.Left + 1;
        End;

        If (Hot) And (FTopMenu) And (Enabled) Then
            If Not Selected Then
            Begin
                dec(X, 1);
                dec(Y, 2);
            End;

        If (Hot) And (Not FTopMenu) And (Enabled) And (Not Checked) Then
            If Not Selected Then
            Begin
                dec(X, 1);
                dec(Y, 1);
            End;

        If (Not Hot) And (Enabled) And (Not Checked) Then
            If Is16Bit Then
                DimBitmap(B, FDimLevel{30});


        If Not Enabled Then
        Begin
            GrayBitmap(B, FGrayLevel);
            DimBitmap(B, 40);
        End;

        If (Hot) And (Enabled) And (Not Checked) Then
        Begin
            If (Is16Bit) And (Not UseSystemColors) And (Sender Is TToolButton) Then
                DefColor := NewColor(ACanvas, FSelectColor, 68)
            Else
                DefColor := FFSelectColor;

            DefColor := GetShadeColor(ACanvas, DefColor, 50);
            DrawBitmapShadow(B, ACanvas, X + 2, Y + 2, DefColor);
        End;

        B.Transparent := True;
        ACanvas.Draw(X, Y, B);
    End;

End;


Function TXPMenu.TopMenuFontColor(ACanvas: TCanvas; Color: TColor): TColor;
Var
    r, g, b, avg: Integer;
Begin

    Color := ColorToRGB(Color);
    r := Color And $000000FF;
    g := (Color And $0000FF00) Shr 8;
    b := (Color And $00FF0000) Shr 16;

    Avg := (r + b) Div 2;

    If (Avg > 150) Or (g > 200) Then
        Result := FFont.Color
    Else
        Result := NewColor(ACanvas, Color, 90);

End;

Procedure TXPMenu.SetDisableSubclassing(Const Value: Boolean);
Begin
    If Value = FDisableSubclassing Then
        Exit;
    If XPMenuManager.ActiveXPMenu = Self Then
        XPMenuManager.UpdateActiveXPMenu(Self)
    Else
    If (XPMenuManager.ActiveXPMenu = Nil) And Not (FDisableSubclassing) Then
        XPMenuManager.UpdateActiveXPMenu(Nil);
End;


Procedure TXPMenu.SetActive(Const Value: Boolean);
Begin
    If Value = FActive Then
        exit;

    FActive := Value;
    InitItems(FForm, FActive, True);

    If FForm.Handle <> 0 Then
        Windows.DrawMenuBar(FForm.Handle);
End;

Procedure TXPMenu.SetAutoDetect(Const Value: Boolean);
Begin
    FAutoDetect := Value;
End;

Procedure TXPMenu.SetForm(Const Value: TScrollingWinControl);
Var
    Hold: Boolean;
Begin
    If Value <> FForm Then
    Begin
        Hold := Active;
        Active := False;
        FForm := Value;
        If Hold Then
            Active := True;
    End;
End;

Procedure TXPMenu.SetFont(Const Value: TFont);
Begin
    FFont.Assign(Value);
    Windows.DrawMenuBar(FForm.Handle);

End;

Procedure TXPMenu.SetColor(Const Value: TColor);
Begin
    FColor := Value;
    FColorsChanged := True; // +jt
End;

Procedure TXPMenu.SetIconBackColor(Const Value: TColor);
Begin
    FIconBackColor := Value;
    FColorsChanged := True; // +jt
End;

Procedure TXPMenu.SetMenuBarColor(Const Value: TColor);
Begin
    FMenuBarColor := Value;
    FColorsChanged := True; // +jt
    Windows.DrawMenuBar(FForm.Handle);
End;

Procedure TXPMenu.SetCheckedColor(Const Value: TColor);
Begin
    FCheckedColor := Value;
    FColorsChanged := True; // +jt
End;

Procedure TXPMenu.SetSeparatorColor(Const Value: TColor);
Begin
    FSeparatorColor := Value;
    FColorsChanged := True; // +jt
End;

Procedure TXPMenu.SetSelectBorderColor(Const Value: TColor);
Begin
    FSelectBorderColor := Value;
    FColorsChanged := True; // +jt
End;

Procedure TXPMenu.SetSelectColor(Const Value: TColor);
Begin
    FSelectColor := Value;
    FColorsChanged := True; // +jt
End;

Procedure TXPMenu.SetDisabledColor(Const Value: TColor);
Begin
    FDisabledColor := Value;
    FColorsChanged := True; // +jt
End;

Procedure TXPMenu.SetSelectFontColor(Const Value: TColor);
Begin
    FSelectFontColor := Value;
    FColorsChanged := True; // +jt
End;

Procedure TXPMenu.SetIconWidth(Const Value: Integer);
Begin
    FIconWidth := Value;
End;

Procedure TXPMenu.SetDrawSelect(Const Value: Boolean);
Begin
    FDrawSelect := Value;
End;



Procedure TXPMenu.SetOverrideOwnerDraw(Const Value: Boolean);
Begin
    FOverrideOwnerDraw := Value;
    If FActive Then
        Active := True;
End;


Procedure TXPMenu.SetUseSystemColors(Const Value: Boolean);
Begin
    FUseSystemColors := Value;
    Windows.DrawMenuBar(FForm.Handle);
End;

Procedure TXPMenu.SetGradient(Const Value: Boolean);
Begin
    FGradient := Value;
End;

Procedure TXPMenu.SetFlatMenu(Const Value: Boolean);
Begin
    FFlatMenu := Value;
End;

Procedure TXPMenu.SetXPContainers(Const Value: TXPContainers);
Begin
    If Value <> FXPContainers Then
    Begin
        If FActive Then
        Begin
            FActive := False;
            InitItems(FForm, False, True);
            FActive := True;
            FXPContainers := Value;
            InitItems(FForm, True, True);
        End;
    End;
    FXPContainers := Value;

End;

Procedure TXPMenu.SetXPControls(Const Value: TXPControls);
Begin
    If Value <> FXPControls Then
    Begin
        If FActive Then
        Begin
            FActive := False;
            InitItems(FForm, False, True);
            FActive := True;
            FXPControls := Value;
            InitItems(FForm, True, True);
        End;
    End;
    FXPControls := Value;

End;

Procedure TXPMenu.SetDrawMenuBar(Const Value: Boolean);
Begin
    FDrawMenuBar := Value;
End;

Procedure TXPMenu.SetUseDimColor(Const Value: Boolean);
Begin
    FUseDimColor := Value;
End;

Procedure GetSystemMenuFont(Font: TFont);
Var
    FNonCLientMetrics: TNonCLientMetrics;
Begin
    FNonCLientMetrics.cbSize := Sizeof(TNonCLientMetrics);
    If SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @FNonCLientMetrics, 0) Then
    Begin
        Font.Handle := CreateFontIndirect(FNonCLientMetrics.lfMenuFont);
        Font.Color := clMenuText;
    End;
End;

Procedure TXPMenu.DrawGradient(ACanvas: TCanvas; ARect: TRect;
    IsRightToLeft: Boolean);
Var
    i: Integer;
    v: Integer;
    FRect: TRect;
Begin

    fRect := ARect;
    V := 0;
    If IsRightToLeft Then
    Begin
        fRect.Left := fRect.Right - 1;
        For i := ARect.Right Downto ARect.Left Do
        Begin
            If (fRect.Left < ARect.Right)
                And (fRect.Left > ARect.Right - FIconWidth + 5) Then
                inc(v, 3)
            Else
                inc(v, 1);

            If v > 96 Then
                v := 96;
            ACanvas.Brush.Color := NewColor(ACanvas, FFIconBackColor, v);
            ACanvas.FillRect(fRect);

            fRect.Left := fRect.Left - 1;
            fRect.Right := fRect.Left - 1;
        End;
    End
    Else
    Begin
        fRect.Right := fRect.Left + 1;
        For i := ARect.Left To ARect.Right Do
        Begin
            If (fRect.Left > ARect.Left)
                And (fRect.Left < ARect.Left + FIconWidth + 5) Then
                inc(v, 3)
            Else
                inc(v, 1);

            If v > 96 Then
                v := 96;
            ACanvas.Brush.Color := NewColor(ACanvas, FFIconBackColor, v);
            ACanvas.FillRect(fRect);

            fRect.Left := fRect.Left + 1;
            fRect.Right := fRect.Left + 1;
        End;
    End;
End;

Function MenuWindowProc(hwnd: HWND; uMsg: Integer; WParam: WPARAM; lParam: LPARAM): LRESULT; Stdcall;
Var
    oldproc: Integer;
    r: TRect;
    pt: TPoint;
Begin
    If (uMsg = WM_ERASEBKGND) Then
    Begin
        Result := 1;
        exit;
    End;
    If ((uMsg = WM_SHOWWINDOW) And (Not Boolean(WParam))) Or (uMsg = WM_CLOSE) Or (uMsg = WM_DESTROY) Then
    Begin
        SetWindowRgn(hwnd, 0, False);
        oldproc := GetWindowLong(hWnd, GWL_USERDATA);
        SetWindowLong(hWnd, GWL_WNDPROC, oldproc);
        SetWindowLong(hWnd, GWL_USERDATA, 0);
        Result := CallWindowProc(Pointer(oldproc), hwnd, uMsg, wParam, lParam);
        GetWindowRect(hWnd, r);
        pt.x := r.Right + 2;
        pt.y := r.Top + 2;
        hWnd := WindowFromPoint(pt);
        If GetWindowLong(hWnd, GWL_WNDPROC) <> Integer(@MenuWindowProc) Then
        Begin
            pt.x := r.Right + 2;
            pt.y := r.Bottom - 2;
            hWnd := WindowFromPoint(pt);
            If GetWindowLong(hWnd, GWL_WNDPROC) <> Integer(@MenuWindowProc) Then
                exit;
        End;
        InvalidateRect(hwnd, Nil, False);
    End
    Else Result := CallWindowProc(Pointer(GetWindowLong(hWnd, GWL_USERDATA)), hwnd, uMsg, wParam, lParam);
End;

Procedure TXPMenu.DrawWindowBorder(hWnd: HWND; IsRightToLeft: Boolean);
Var
    WRect: TRect;
    dCanvas: TCanvas;
    wDC: HDC; // +jt

    regiontype: Integer; // +jt
    r1, r2, wr, region: HRGN; // +jt
    rgnr: TRect; // +jt
Begin


    If (hWnd <= 0) Or (FSettingWindowRng) Then
    Begin
        exit;
    End;
// +jt
    wDC := GetWindowDC(hWnd); //GetDesktopWindow
    If wDC = 0 Then
        exit;
// +jt
    FSettingWindowRng := True; // +jt
    dCanvas := TCanvas.Create;
    Try
        dCanvas.Handle := wDC; // +jt
        GetWindowRect(hWnd, WRect);
  // +jt
        WRect.Right := WRect.Right - WRect.Left;
        WRect.Bottom := WRect.Bottom - WRect.Top;
        WRect.Top := 0;
        WRect.Left := 0;
        If GetWindowLong(hWnd, GWL_WNDPROC) <> Integer(@MenuWindowProc) Then
        Begin
            SetWindowLong(hWnd, GWL_USERDATA, GetWindowLong(hWnd, GWL_WNDPROC));
            SetWindowLong(hWnd, GWL_WNDPROC, Integer(@MenuWindowProc));
        End;
        If Not IsWXP Then
        Begin
            wr := CreateRectRgn(0, 0, 0, 0);
            regiontype := GetWindowRgn(hWnd, wr);
            GetRgnBox(wr, rgnr);
            DeleteObject(wr);
            If (regionType = ERROR) Or (abs(rgnr.Right - WRect.Right) > 5) Or (abs(rgnr.Bottom - WRect.Bottom) > 5) Then
            Begin
                region := CreateRectRgn(0, 0, 0, 0);
                r1 := CreateRectRgn(WRect.Left, WRect.Top, WRect.Right - 2, WRect.Bottom - 2);
                r2 := CreateRectRgn(WRect.Left + 2, WRect.Top + 2, WRect.Right, WRect.Bottom);
                CombineRgn(region, r1, r2, RGN_OR);
                DeleteObject(r1);
                DeleteObject(r2);
                SetWindowRgn(hWnd, region, True);
            End;
 // +jt
            Dec(WRect.Right, 2);
            Dec(WRect.Bottom, 2);
        End; // +jt
        dCanvas.Brush.Style := bsClear;
        dCanvas.Pen.Color := FMenuBorderColor;
        dCanvas.Rectangle(WRect.Left, WRect.Top, WRect.Right, WRect.Bottom);
        If IsRightToLeft Then
        Begin
            dCanvas.Pen.Color := FFIconBackColor;
            dCanvas.MoveTo(WRect.Right - 3, WRect.Top + 2);
            dCanvas.LineTo(WRect.Right - 2, WRect.Bottom - 1);
        End
        Else
        Begin
            dCanvas.Pen.Color := FFIconBackColor;
            dCanvas.Rectangle(WRect.Left + 1, WRect.Top + 2,
                WRect.Left + 3, WRect.Bottom - 1);
        End;
// +jt
        StretchBlt(dCanvas.Handle, WRect.Left + 1, WRect.Top + 1, WRect.Right - WRect.Left - 1, 2,
            dCanvas.Handle, WRect.Left + 1, WRect.Top + 3, WRect.Right - WRect.Left - 1, 1, SRCCOPY);
        If IsWXP Then
        Begin
            StretchBlt(dCanvas.Handle, WRect.Left + 1, WRect.Bottom - 3, WRect.Right - WRect.Left - 1, 2,
                dCanvas.Handle, WRect.Left + 1, WRect.Top + 3, WRect.Right - WRect.Left - 1, 1, SRCCOPY);
            dCanvas.Pen.Color := FFColor;
            dCanvas.Rectangle(WRect.Right - 3, WRect.Top + 1, WRect.Right - 1,
                WRect.Bottom - 1);
        End;
// +jt
        Inc(WRect.Right, 2);
        Inc(WRect.Bottom, 2);
        If Not IsWXP Then // +jt
        Begin // +jt
            dCanvas.Pen.Color := FMenuShadowColor;
            dCanvas.Rectangle(WRect.Left + 2, WRect.Bottom, WRect.Right, WRect.Bottom - 2);
            dCanvas.Rectangle(WRect.Right - 2, WRect.Bottom, WRect.Right, WRect.Top + 2);
        End; // +jt

    Finally
        ReleaseDC(hWnd, wDC); // +jt
        dCanvas.Free;
        FSettingWindowRng := False;
    End;

End;

Procedure TXPMenu.Notification(AComponent: TComponent; Operation: TOperation);
Begin
    If Not Assigned(XPMenuManager) Then
        Exit;
// Pass the notification information to the XPMenuManager
    If Not (csDesigning In ComponentState) Then
        XPMenuManager.Notification(AComponent, Operation);

    Inherited Notification(AComponent, Operation);
    If (Not FActive) Or (Not FAutoDetect) Then
        Exit;
    If (Operation = opInsert) And
        ((AComponent Is TMenuItem) Or (AComponent Is TToolButton) Or (AComponent Is TControlBar)) Then
        If Not (csDesigning In ComponentState) Then
            InitItem(AComponent, True, True);  // Tom: This will process this new component
End;


Function GetShadeColor(ACanvas: TCanvas; clr: TColor; Value: Integer): TColor;
Var
    r, g, b: Integer;

Begin
    clr := ColorToRGB(clr);
    r := Clr And $000000FF;
    g := (Clr And $0000FF00) Shr 8;
    b := (Clr And $00FF0000) Shr 16;

    r := (r - value);
    If r < 0 Then
        r := 0;
    If r > 255 Then
        r := 255;

    g := (g - value) + 2;
    If g < 0 Then
        g := 0;
    If g > 255 Then
        g := 255;

    b := (b - value);
    If b < 0 Then
        b := 0;
    If b > 255 Then
        b := 255;

  //Result := Windows.GetNearestColor(ACanvas.Handle, RGB(r, g, b));
    Result := RGB(r, g, b);
End;

Function MergColor(Colors: Array Of TColor): TColor;
Var
    r, g, b, i: Integer;
    clr: TColor;
Begin
    r := 0; g := 0; b := 0;

    For i := 0 To High(Colors) Do
    Begin

        clr := ColorToRGB(Colors[i]);
        r := r + (Clr And $000000FF) Div High(Colors);
        g := g + ((Clr And $0000FF00) Shr 8) Div High(Colors);
        b := b + ((Clr And $00FF0000) Shr 16) Div High(Colors);
    End;

    Result := RGB(r, g, b);

End;
Function NewColor(ACanvas: TCanvas; clr: TColor; Value: Integer): TColor;
Var
    r, g, b: Integer;

Begin
    If Value > 100 Then
        Value := 100;
    clr := ColorToRGB(clr);
    r := Clr And $000000FF;
    g := (Clr And $0000FF00) Shr 8;
    b := (Clr And $00FF0000) Shr 16;


    r := r + Round((255 - r) * (value / 100));
    g := g + Round((255 - g) * (value / 100));
    b := b + Round((255 - b) * (value / 100));

  //Result := Windows.GetNearestColor(ACanvas.Handle, RGB(r, g, b));
    Result := RGB(r, g, b);

End;

Function GetInverseColor(AColor: TColor): TColor;
Begin
    Result := ColorToRGB(AColor) Xor $FFFFFF;
End;

Function GrayColor(ACanvas: TCanvas; Clr: TColor; Value: Integer): TColor;
Var
    r, g, b, avg: Integer;

Begin

    clr := ColorToRGB(clr);
    r := Clr And $000000FF;
    g := (Clr And $0000FF00) Shr 8;
    b := (Clr And $00FF0000) Shr 16;

    Avg := (r + g + b) Div 3;
    Avg := Avg + Value;

    If Avg > 240 Then
        Avg := 240;
  //if ACanvas <> nil then
  //  Result := Windows.GetNearestColor (ACanvas.Handle,RGB(Avg, avg, avg));
    Result := RGB(Avg, avg, avg);
End;

Procedure GrayBitmap(ABitmap: TBitmap; Value: Integer);
Var
    x, y: Integer;
    LastColor1, LastColor2, Color: TColor;
Begin
    LastColor1 := 0;
    LastColor2 := 0;

    For y := 0 To ABitmap.Height Do
        For x := 0 To ABitmap.Width Do
        Begin
            Color := ABitmap.Canvas.Pixels[x, y];
            If Color = LastColor1 Then
                ABitmap.Canvas.Pixels[x, y] := LastColor2
            Else
            Begin
                LastColor2 := GrayColor(ABitmap.Canvas, Color, Value);
                ABitmap.Canvas.Pixels[x, y] := LastColor2;
                LastColor1 := Color;
            End;
        End;
End;
{Modified  by felix@unidreamtech.com}
{
procedure GrayBitmap(ABitmap: TBitmap; Value: integer);
var
  Pixel: PRGBTriple;
  w, h: Integer;
  x, y: Integer;
  avg: integer;
begin
  ABitmap.PixelFormat := pf24Bit;
  w := ABitmap.Width;
  h := ABitmap.Height;
  for y := 0 to h - 1 do
  begin
    Pixel := ABitmap.ScanLine[y];
    for x := 0 to w - 1 do
    begin
      avg := ((Pixel^.rgbtRed + Pixel^.rgbtGreen + Pixel^.rgbtBlue) div 3)
        + Value;
      if avg > 240 then avg := 240;
      Pixel^.rgbtRed := avg;
      Pixel^.rgbtGreen := avg;
      Pixel^.rgbtBlue := avg;
      Inc(Pixel);
    end;
  end;
end;
}

Procedure DimBitmap(ABitmap: TBitmap; Value: Integer);
Var
    x, y: Integer;
    LastColor1, LastColor2, Color: TColor;
Begin
    If Value > 100 Then
        Value := 100;
    LastColor1 := -1;
    LastColor2 := -1;
    For y := 0 To ABitmap.Height - 1 Do
        For x := 0 To ABitmap.Width - 1 Do
        Begin
            Color := ABitmap.Canvas.Pixels[x, y];
            If Color = LastColor1 Then
                ABitmap.Canvas.Pixels[x, y] := LastColor2
            Else
            Begin
                LastColor2 := NewColor(ABitmap.Canvas, Color, Value);
                ABitmap.Canvas.Pixels[x, y] := LastColor2;
                LastColor1 := Color;
            End;
        End;
End;

// LIne 2647
{Modified  by felix@unidreamtech.com}
{works  fine for 24 bit color
procedure DimBitmap(ABitmap: TBitmap; Value: integer);
var
  Pixel: PRGBTriple;
  w, h: Integer;
  x, y, c1, c2: Integer;
begin
  ABitmap.PixelFormat := pf24Bit;
  w := ABitmap.Width;
  h := ABitmap.Height;

  c1 := Value * 255;
  c2 := 100 - Value;
  for y := 0 to h - 1 do
  begin
    Pixel := ABitmap.ScanLine[y];
    for x := 0 to w - 1 do
    begin
      Pixel^.rgbtRed := ((c2 * Pixel^.rgbtRed) + c1) div 100;
      Pixel^.rgbtGreen := ((c2 * Pixel^.rgbtGreen) + c1) div 100;
      Pixel^.rgbtBlue := ((c2 * Pixel^.rgbtBlue) + c1) div 100;
      Inc(Pixel);
    end;
  end;
end;
}
Procedure DrawArrow(ACanvas: TCanvas; X, Y: Integer);
Begin
    ACanvas.MoveTo(X, Y);
    ACanvas.LineTo(X + 5, Y);

    ACanvas.MoveTo(X + 1, Y + 1);
    ACanvas.LineTo(X + 4, Y);

    ACanvas.MoveTo(X + 2, Y + 2);
    ACanvas.LineTo(X + 3, Y);

End;

Procedure DrawArrow(ACanvas: TCanvas; X, Y, Orientation: Integer);
Begin
    Case Orientation Of
        0:
        Begin

            ACanvas.MoveTo(X, Y);
            ACanvas.LineTo(X, Y - 1);

            ACanvas.MoveTo(X + 1, Y + 1);
            ACanvas.LineTo(X + 4, Y + 4);

            ACanvas.MoveTo(X, Y + 1);
            ACanvas.LineTo(X + 3, Y + 4);

            ACanvas.MoveTo(X, Y + 2);
            ACanvas.LineTo(X + 2, Y + 4);


            ACanvas.MoveTo(X - 1, Y + 1);
            ACanvas.LineTo(X - 4, Y + 4);

            ACanvas.MoveTo(X, Y + 2);
            ACanvas.LineTo(X - 3, Y + 4);

            ACanvas.MoveTo(X, Y + 1);
            ACanvas.LineTo(X - 2, Y + 4);

        End;
        1:
        Begin
            ACanvas.MoveTo(X, Y + 3);
            ACanvas.LineTo(X, Y + 4);

            ACanvas.MoveTo(X + 1, Y + 2);
            ACanvas.LineTo(X + 4, Y - 1);

            ACanvas.MoveTo(X, Y + 2);
            ACanvas.LineTo(X + 3, Y - 1);

            ACanvas.MoveTo(X, Y + 1);
            ACanvas.LineTo(X + 2, Y + 0);



            ACanvas.MoveTo(X - 1, Y + 2);
            ACanvas.LineTo(X - 4, Y - 1);

            ACanvas.MoveTo(X, Y + 2);
            ACanvas.LineTo(X - 3, Y - 1);

            ACanvas.MoveTo(X, Y + 1);
            ACanvas.LineTo(X - 2, Y + 0);


        End;
    End;
End;
Procedure DrawBitmapShadow(B: TBitmap; ACanvas: TCanvas; X, Y: Integer;
    ShadowColor: TColor);
Var
    BX, BY: Integer;
    TransparentColor: TColor;
Begin
    TransparentColor := B.Canvas.Pixels[0, B.Height - 1];
    For BY := 0 To B.Height - 1 Do
        For BX := 0 To B.Width - 1 Do
        Begin
            If B.Canvas.Pixels[BX, BY] <> TransparentColor Then
                ACanvas.Pixels[X + BX, Y + BY] := ShadowColor;
        End;
End;

Procedure DrawCheckMark(ACanvas: TCanvas; X, Y: Integer);
Begin
    Inc(X, 2);
    Dec(Y, 3);
    ACanvas.MoveTo(X, Y - 2);
    ACanvas.LineTo(X + 2, Y);
    ACanvas.LineTo(X + 8, Y - 6);

    ACanvas.MoveTo(X, Y - 3);
    ACanvas.LineTo(X + 2, Y - 1);
    ACanvas.LineTo(X + 8, Y - 7);

    ACanvas.MoveTo(X, Y - 4);
    ACanvas.LineTo(X + 2, Y - 2);
    ACanvas.LineTo(X + 8, Y - 8);
End;

{ TCustomComboSubClass }
Procedure TControlSubClass.SetControl(AControl: TControl);
Begin
    fControl := AControl;
End;

//By Heath Provost (Nov 20, 2001)
// ComboBox Subclass WndProc.
// Message processing to allow control to repond to
// messages needed to paint using Office XP style.
Procedure TControlSubClass.ControlSubClass(Var Message: TMessage);

Begin
  //Call original WindowProc FIRST. We are trying to emulate inheritance, so
  //original WindowProc must handle all messages before we do.
    If ((Message.Msg = WM_PAINT) And ((Control Is TGraphicControl))) Or
        ((Control.ClassName = 'TDBLookupComboBox') And (Message.Msg = WM_NCPAINT)) Then
        Message.Result := 1
    Else
    //"Marcus Paulo Tavares" <marcuspt@terra.com.br>
        orgWindowProc(Message);

    If (XPMenu <> Nil) And (Not XPMenu.FActive) Then
    Begin
        Try
            Message.Result := 1;
            If Control <> Nil Then
            Begin
                Control.WindowProc := orgWindowProc;
                If Control Is TCustomEdit Then
                    TEdit(Control).Ctl3D := FCtl3D;
                If Control Is TCustomRichEdit Then
                    TRichEdit(Control).BorderStyle := FBorderStyle;
                If Control.ClassName = 'TDBLookupComboBox' Then
                    TComboBox(Control).Ctl3D := FCtl3D;
                If Control Is TCustomListBox Then
                    TListBox(Control).BorderStyle := FBorderStyle;
                If Control Is TCustomListView Then
                    TListView(Control).BorderStyle := FBorderStyle;
                If Control Is TCustomTreeView Then
                    TTreeView(Control).BorderStyle := FBorderStyle;
                Control := Nil;
                Free;
            End;
            Exit;
        Except
            exit;
        End;
    End;

    FMsg := Message.Msg;
    Case Message.Msg Of


        EM_GETMODIFY, // For edit
        CM_INVALIDATE:
        Begin
            FBuilding := True;
        End;

        CM_PARENTCOLORCHANGED:
        Begin
            PaintControlXP;
        End;

        WM_DESTROY:
        Begin
            If Not FBuilding Then
            Begin
                Try
                    If Control <> Nil Then
                    Begin
                        Control.WindowProc := orgWindowProc;
                        FBuilding := False;
                        Free;
                    End;
                Except
                End;
         //FBuilding := false;
            End;
            Exit;
        End;

        WM_PAINT:
        Begin
            FBuilding := False;
            PaintControlXP;
        End;

        CM_MOUSEENTER:
            If TControl(Control).Enabled Then
            Begin
//        if FmouseInControl then exit;
                FmouseInControl := True;
                If Control Is TGraphicControl Then
                Begin
                    Control.Repaint;
                    exit;
                End;
                PaintControlXP;


        {if Control is TGraphicControl then
        begin
          if not FMouseInControl and Control.Enabled
            and (GetCapture = 0) then
          begin
            FMouseInControl := True;
            Control.Repaint;
          end;
        end
        else
        begin
          FmouseInControl := true;
          PaintControlXP;
        end;}


            End;
        CM_MOUSELEAVE:
            If TControl(Control).Enabled Then
            Begin
                FmouseInControl := False;
                If Control Is TGraphicControl Then
                Begin
                    Control.Invalidate;
                    exit;
                End;
                PaintControlXP;


        {if Control is TGraphicControl then
        begin
          if FMouseInControl and Control.Enabled then
          begin
            FMouseInControl := False;
            Control.Invalidate;
          end;
        end
        else
        begin
          FmouseInControl := false;
          PaintControlXP;
        end;}
            End;

        WM_MOUSEMOVE:
        Begin
            If TControl(Control).Enabled And (Control.ClassName = 'TUpDown') Then
                PaintControlXP;
        End;
        WM_LBUTTONDOWN:
        Begin
            FLButtonBressed := True;
            PaintControlXP;
        End;

        WM_LBUTTONUP:
        Begin
            FLButtonBressed := False;
            If Control Is TGraphicControl Then
            Begin
                Control.Repaint;
                exit;
            End;
            PaintControlXP;
        End;

        WM_KEYDOWN:
            If Message.WParam = VK_SPACE Then
            Begin
                FBressed := True;
                If Not FIsKeyDown Then
                    PaintControlXP;
                FIsKeyDown := True;
            End;

        WM_KEYUP:
            If Message.WParam = VK_SPACE Then
            Begin
                FBressed := False;
                FIsKeyDown := False;
                PaintControlXP;
            End;

        WM_SETFOCUS:
        Begin
            FmouseInControl := True;
            PaintControlXP;
        End;
        WM_KILLFOCUS:
        Begin
            FmouseInControl := False;
            PaintControlXP;
        End;
        CM_FOCUSCHANGED:    //??
            PaintControlXP;

        CM_EXIT:
        Begin
            FmouseInControl := False;
            PaintControlXP;
        End;

        BM_SETCHECK:
        Begin
            FmouseInControl := False;
            PaintControlXP;
        End;
        BM_GETCHECK:
        Begin
            FmouseInControl := False;
            PaintControlXP;
        End;
        CM_ENABLEDCHANGED:
        Begin
            If (Message.WParam = 0) Then
                FmouseInControl := False;//Dirk Bottcher <dirk.boettcher@gmx.net>
            PaintControlXP;
        End;

        CM_TEXTCHANGED:
        Begin
            PaintControlXP;
        End;


        CM_CTL3DCHANGED, CM_PARENTCTL3DCHANGED:
        Begin
            FBuilding := True;
        End;
        WM_LBUTTONDBLCLK:    //for button, check
        Begin
            If (Control Is TButton) Or
                (Control Is TSpeedButton) Or
                (Control Is TCheckBox) Then
                Control.Perform(WM_LBUTTONDOWN, Message.WParam, Longint(Message.LParam));
        End;
    {CN_DRAWITEM,} BM_SETSTATE:
        Begin
            PaintControlXP;   // button
        End;
        WM_WINDOWPOSCHANGED, CN_PARENTNOTIFY:     // Moving From parent to other
        Begin
            FBuilding := True;
        End;
        WM_NCPAINT:
        Begin
            Message.Result := 0;
            If (Control Is TCustomListBox) Or (Control Is TCustomTreeView) Or
                (Control Is TCustomListBox)
            Then
                PaintNCWinControl;
        End;
    End;

End;

// changes added by Heath Provost (Nov 20, 2001)
{ TCustomComboSubClass }
// paints an overlay over the control to make it mimic
// Office XP style.

Procedure TControlSubClass.PaintControlXP;
Begin

    If Control Is TWinControl Then
        FIsFocused := TWinControl(Control).Focused
    Else
        FIsFocused := False;
  {$IFDEF VER6U}
    If (Control Is TCustomCombo) Then
        PaintCombo;
  {$ELSE}
  if (Control is TCustomComboBox) then
    PaintCombo;
  {$ENDIF}
    If Control.ClassName = 'TDBLookupComboBox' Then
        PaintDBLookupCombo;

    If Control Is TCustomRichEdit Then
        PaintRichEdit
    Else
    If Control Is TCustomEdit Then
        PaintEdit;

    If Control Is TCustomCheckBox Then
        PaintCheckBox;
    If Control Is TRadioButton Then
        PaintRadio;

    If Control Is TBitBtn Then
        PaintBitButn
    Else
    If Control Is TButton Then
        PaintButton;

    If Control Is TUpDown Then
        PaintUpDownButton;

    If Control Is TSpeedButton Then
        If Control.Visible Then
            PaintSpeedButton;

    If Control Is TCustomPanel Then
        PaintPanel;

    If Control Is TCustomGroupBox Then
        PaintGroupBox;

    If (Control Is TCustomListBox) Or (Control Is TCustomTreeView) Or
        (Control Is TCustomListView)
    Then
        PaintNCWinControl;

    If Control Is TProgressBar Then
        PaintProgressBar;

    If Control Is TCustomHotKey Then
        PaintHotKey;
{
  if Control is TDrawGrid then
    PaintGrid;
}
End;

Procedure TControlSubClass.PaintCombo;
Var
    C: TControlCanvas;
    R: TRect;
    SelectColor, BorderColor, ArrowColor: TColor;
    X: Integer;
Begin

    C := TControlCanvas.Create;
    Try
        C.Control := Control;

//    XPMenu.SetGlobalColor(C);
        If Control.Enabled Then
            ArrowColor := clBlack Else ArrowColor := clWhite;


        If (FmouseinControl) Then
        Begin
            borderColor := XPMenu.FFSelectBorderColor;
            SelectColor := XPMenu.FFSelectColor;
        End
        Else
        Begin
            borderColor := TComboBox(Control).Color;
            If Control.Tag = 1000 Then
                SelectColor := NewColor(C, TControl(Control).Parent.Brush.Color, xpMenu.FDimParentColor)
            Else
                selectColor := clBtnFace;
        End;

        If (Not FmouseinControl) And (FIsFocused) Then
        Begin
            borderColor := NewColor(C, XPMenu.FFSelectBorderColor, 60);
            SelectColor := XPMenu.FCheckedAreaColor;
        End;

        R := Control.ClientRect;

        C.Brush.Color := Control.Parent.Brush.Color;
        C.FrameRect(R);
        InflateRect(R, -1, -1);

        C.Pen.Color := C.Brush.Color;
        C.MoveTo(R.Left, R.Top);
        C.LineTo(R.Right, R.Top);

        InflateRect(R, 0, -1);

        If (FmouseinControl Or FIsFocused) Then
            InflateRect(R, 1, 1);

        C.Brush.Color := TComboBox(Control).Color;;
        C.FrameRect(R);

        Inc(R.Bottom, 1);
        C.Brush.Color := BorderColor;
        C.FrameRect(R);

    {$IFDEF VER6U}
        If TCustomCombo(Control).DroppedDown Then
    {$ELSE}
    if TCustomComboBox(Control).DroppedDown then
    {$ENDIF}
        Begin
            BorderColor := XPMenu.FFSelectBorderColor;
            ArrowColor := clWhite;
            SelectColor := XPMenu.FCheckedAreaSelectColor;
        End;

        If TComboBox(Control).style <> csSimple Then
        Begin

            InflateRect(R, -1, -1);

            If Control.BiDiMode = bdRightToLeft Then
                R.Right := R.Left + GetSystemMetrics(SM_CXHTHUMB) + 1
            Else
                R.Left := R.Right - GetSystemMetrics(SM_CXHTHUMB) - 1;

            If (FmouseinControl Or FIsFocused) Then
            Begin
                If Control.BiDiMode = bdRightToLeft Then
                    Inc(R.Right, 2)
                Else
                    Dec(R.Left, 1);
            End;

            C.Brush.Color := SelectColor;
            C.FillRect(R);

            If Control.BiDiMode = bdRightToLeft Then
                R.Left := R.Right - 5
            Else
                R.Right := R.Left + 5;

            C.Brush.Color := TComboBox(Control).Color;
            C.FillRect(R);

            C.Pen.Color := BorderColor;

            If Control.BiDiMode = bdRightToLeft Then
            Begin
                C.Moveto(R.Left, R.Top);
                C.LineTo(R.Left, R.Bottom);
            End
            Else
            Begin
                C.Moveto(R.Right, R.Top);
                C.LineTo(R.Right, R.Bottom);
            End;
            C.Pen.Color := arrowColor;

            R := Control.ClientRect;

            If Control.BiDiMode = bdRightToLeft Then
                X := R.Left + 5
            Else
                X := R.Right - 10;

            C.Moveto(X + 0, R.Top + 10);
            C.LineTo(X + 5, R.Top + 10);
            C.Moveto(X + 1, R.Top + 11);
            C.LineTo(X + 4, R.Top + 11);
            C.Moveto(X + 2, R.Top + 12);
            C.LineTo(X + 3, R.Top + 12);
        End;
    Finally
        C.Free;
    End;

End;

Procedure TControlSubClass.PaintDBLookupCombo;
Var
    C: TControlCanvas;
    R: TRect;
    FrameColor, SelectColor, BorderColor, ArrowColor: TColor;
    X: Integer;
    DC: HDC;

Begin
    C := TControlCanvas.Create;
    DC := GetWindowDC(TWinControl(Control).Handle);
    Try
        C.Control := Control;
        C.Handle := DC;
        If TComboBox(Control).Ctl3D Then
        Begin
            FBuilding := True;
            TComboBox(Control).Ctl3D := False;
        End;

    //XPMenu.SetGlobalColor(C);
        If Control.Enabled Then
            ArrowColor := clBlack Else ArrowColor := clWhite;


        If (FmouseinControl) Then
        Begin
            FrameColor := XPMenu.FFSelectBorderColor;
            borderColor := XPMenu.FFSelectBorderColor;
            SelectColor := XPMenu.FFSelectColor;
        End
        Else
        Begin
            FrameColor := GetShadeColor(C, Control.Parent.Brush.Color, 60);
            borderColor := NewColor(C, XPMenu.FFSelectBorderColor, 60);
            selectColor := clBtnFace;
        End;
        If (Not FmouseinControl) And (FIsFocused) Then
        Begin
            FrameColor := GetShadeColor(C, Control.Parent.Brush.Color, 60);
            borderColor := NewColor(C, XPMenu.FFSelectBorderColor, 60);
            SelectColor := XPMenu.FCheckedAreaColor;
        End;


        R := Rect(0, 0, Control.Width, Control.Height);
        C.Brush.Color := TComboBox(Control).Color;
        C.Brush.Color := FrameColor;
        C.FrameRect(R);


        R := Control.ClientRect;

    // Move the thumb one pixel to the right and one pixel down
        OffsetRect(R, 1, 1);


        C.Brush.Color := TComboBox(Control).Color;
        C.FrameRect(R);

    {$IFDEF VER6U}
        If TCustomCombo(Control).DroppedDown Then
    {$ELSE}
    if TCustomComboBox(Control).DroppedDown then
    {$ENDIF}
        Begin
            BorderColor := XPMenu.FFSelectBorderColor;
            ArrowColor := clWhite;
            SelectColor := XPMenu.FCheckedAreaSelectColor;
        End;

        If TComboBox(Control).style <> csSimple Then
        Begin

            InflateRect(R, -1, -1);

            If Control.BiDiMode = bdRightToLeft Then
                R.Right := R.Left + GetSystemMetrics(SM_CXHTHUMB) + 1
            Else
                R.Left := R.Right - GetSystemMetrics(SM_CXHTHUMB) - 1;

            If (FmouseinControl Or FIsFocused) Then
            Begin
                If Control.BiDiMode = bdRightToLeft Then
                    Inc(R.Right, 1)
                Else
                    Dec(R.Left, 1);
            End;


            C.Brush.Color := SelectColor;
            C.FillRect(R);
            C.Brush.Color := BorderColor;
            C.FrameRect(R);

            If Control.BiDiMode = bdRightToLeft Then
                R.Left := R.Right - 5
            Else
                R.Right := R.Left + 5;

            C.Brush.Color := TComboBox(Control).Color;
            C.FillRect(R);

            C.Pen.Color := BorderColor;

            If Control.BiDiMode = bdRightToLeft Then
            Begin
                C.Moveto(R.Left, R.Top);
                C.LineTo(R.Left, R.Bottom);
            End
            Else
            Begin
                C.Moveto(R.Right, R.Top);
                C.LineTo(R.Right, R.Bottom);
            End;
            C.Pen.Color := arrowColor;

            R := Control.ClientRect;

            If Control.BiDiMode = bdRightToLeft Then
                X := R.Left + 5
            Else
                X := R.Right - 9; // Changed by Uwe Runkel, uwe@runkel.info
                          // Changed value from 10 to 9 because the thumb has
                          // moved one pixel to the right

            C.Moveto(X + 0, R.Top + 8);
            C.LineTo(X + 5, R.Top + 8);
            C.Moveto(X + 1, R.Top + 9);
            C.LineTo(X + 4, R.Top + 9);
            C.Moveto(X + 2, R.Top + 10);
            C.LineTo(X + 3, R.Top + 10);
        End;
    Finally
        C.Free;
        ReleaseDC(TWinControl(Control).Handle, DC);
    End;

End;

Procedure TControlSubClass.PaintEdit;
Var
    C: TControlCanvas;
    R: TRect;
    BorderColor: TColor;
Begin

    C := TControlCanvas.Create;
    Try
        C.Control := Control;

    //XPMenu.SetGlobalColor(C);

        If TEdit(Control).Ctl3D <> False Then
        Begin
            FBuilding := True;
            TEdit(Control).Ctl3D := False;
        End;

        If (FmouseinControl) Or (FIsFocused) Then
            borderColor := NewColor(C, XPMenu.FFSelectBorderColor, 60)
        Else
            borderColor := GetShadeColor(C, Control.Parent.Brush.Color, 60);


        If FBorderStyle = bsNone Then
        Begin
            If (FmouseinControl) And (Not FIsFocused) Then
        //borderColor := NewColor(C, Control.Parent.Brush.Color, 60)
                borderColor := NewColor(C, MergColor([TEdit(Control).Color, Control.Parent.Brush.Color]), 40)

            Else
                borderColor := TEdit(Control).Color;
        End;


        R := Control.ClientRect;

        C.Pen.Color := BorderColor;
        C.Brush.Style := bsClear;

        C.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
    Finally
        C.Free;
    End;
End;

Procedure TControlSubClass.PaintRichEdit;
Var
    C: TControlCanvas;
    R: TRect;
    BorderColor: TColor;
Begin

    C := TControlCanvas.Create;
    Try
        C.Control := Control.Parent;

        R := Control.BoundsRect;
        InflateRect(R, 1, 1);

        If FBorderStyle = bsSingle Then
        Begin
            FBuilding := True;
            TRichEdit(Control).BorderStyle := bsNone;
            If TRichEdit(Control).BorderWidth < 2 Then
                TRichEdit(Control).BorderWidth := 2;
        End;

        If (FmouseinControl) Or (FIsFocused) Then
            borderColor := NewColor(C, XPMenu.FFSelectBorderColor, 60)


        Else
        Begin
            If FBorderStyle = bsSingle Then
                borderColor := GetShadeColor(C, Control.Parent.Brush.Color, 60)
            Else
                borderColor := Control.Parent.Brush.Color;
        End;

        Frame3D(C, R, borderColor, borderColor, 1);

    Finally
        C.Free;
    End;

End;

Procedure TControlSubClass.PaintCheckBox;
Var
    C: TControlCanvas;
    R: TRect;
    SelectColor, BorderColor: TColor;
Begin

    C := TControlCanvas.Create;
    Try
        C.Control := Control;

        If FMouseInControl Then
        Begin
            SelectColor := XPMenu.FFSelectColor;
            BorderColor := xpMenu.FFSelectBorderColor;
        End
        Else
        Begin
            SelectColor := clWindow;
            BorderColor := clBtnShadow;
        End;

        If (FIsFocused) Then
        Begin
            SelectColor := XPMenu.FFSelectColor;
            BorderColor := xpMenu.FFSelectBorderColor;
        End;
        If (FBressed) Or (FLButtonBressed) Then
            SelectColor := XPMenu.FCheckedAreaSelectColor;

        If TCheckBox(Control).State = cbGrayed Then
            SelectColor := clSilver;
        R := Control.ClientRect;

    //The minimum size of the check box is 17px, so if the rectangle is smaller than that
    //expand it
        If R.Bottom - R.Top < 17 Then
        Begin
      //We are going to call inflateRect so we have to measure the difference
            If (17 - R.Bottom - R.Top) Mod 2 = 0 Then
                InflateRect(R, 0, (17 - R.Bottom - R.Top) Div 2)
            Else
            Begin
                InflateRect(R, 0, (17 - R.Bottom - R.Top) Div 2);
                R.Top := R.Top - 1;
            End;
        End;
    //InflateRect(R, 0, 2);
    //R.Top := R.Top + ((R.Bottom - R.Top - GetSystemMetrics(SM_CXHTHUMB)) div 2);
    //R.Top := R.Top - 2;
    //R.Bottom := R.Top + GetSystemMetrics(SM_CXHTHUMB);

        If ((Control.BiDiMode = bdRightToLeft) And
            (TCheckBox(Control).Alignment = taRightJustify)) Or
            ((Control.BiDiMode = bdLeftToRight) And
            (TCheckBox(Control).Alignment = taLeftJustify))
        Then
            R.Left := R.Right - GetSystemMetrics(SM_CXHTHUMB) + 1
        Else
        If ((Control.BiDiMode = bdLeftToRight) And
            (TCheckBox(Control).Alignment = taRightJustify)) Or
            ((Control.BiDiMode = bdRightToLeft) And
            (TCheckBox(Control).Alignment = taLeftJustify)) Then
        Begin
            R.Left := R.Left - 2;
            R.Right := R.Left + GetSystemMetrics(SM_CXHTHUMB);
        End;

    //HELP: Extraneous border?
    //C.Brush.Color := TCheckBox(Control).Color;
    //C.FillRect(R);
        InflateRect(R, -2, -2);
        C.Brush.Color := SelectColor;
        C.Pen.Color := BorderColor;
        C.Rectangle(R.Left, R.Top, R.Right, R.Bottom);

        If (TCheckBox(Control).Checked) Or
            (TCheckBox(Control).State = cbGrayed) Then
        Begin
            If Control.Enabled Then
            Begin
                If (FBressed) Or (FLButtonBressed) Then
                    C.Pen.color := clWindow
                Else
                Begin
                    If TCheckBox(Control).State = cbGrayed Then
                        C.Pen.color := clGray
                    Else
                        C.Pen.color := clHighlight;
                End;
            End
            Else
                C.Pen.color := xpMenu.FFDisabledColor;

            DrawCheckMark(C, R.Left, R.Bottom);
        End;

    Finally
        C.Free;
    End;


End;

Procedure TControlSubClass.PaintRadio;
Var
    C: TControlCanvas;
    R: TRect;
    RectHeight: Integer;
    SelectColor, BorderColor: TColor;
Begin

    C := TControlCanvas.Create;
    Try
        C.Control := Control;

        If FMouseInControl Then
        Begin
            SelectColor := XPMenu.FFSelectColor;
            BorderColor := xpMenu.FFSelectBorderColor;
        End
        Else
        Begin
            SelectColor := clWindow;
            BorderColor := clBtnShadow;
        End;
        If (FIsFocused) Then
            SelectColor := XPMenu.FFSelectColor;

        R := Control.ClientRect;
        If (R.Bottom - R.Top) <= 18 Then
            R.Bottom := R.Top + GetSystemMetrics(SM_CXHTHUMB)
        Else
        Begin
            RectHeight := (R.Bottom - R.Top - GetSystemMetrics(SM_CXHTHUMB)) Div 2;
            R.Top := R.Top + RectHeight;
            R.Bottom := R.Bottom - RectHeight;
            If R.Bottom - R.Top > GetSystemMetrics(SM_CXHTHUMB) Then
                R.Bottom := R.Bottom - 1;
        End;
        If ((Control.BiDiMode = bdRightToLeft) And
            (TCheckBox(Control).Alignment = taRightJustify)) Or
            ((Control.BiDiMode = bdLeftToRight) And
            (TCheckBox(Control).Alignment = taLeftJustify))
        Then
            R.Left := R.Right - GetSystemMetrics(SM_CXHTHUMB) + 1
        Else
        If ((Control.BiDiMode = bdLeftToRight) And
            (TCheckBox(Control).Alignment = taRightJustify)) Or
            ((Control.BiDiMode = bdRightToLeft) And
            (TCheckBox(Control).Alignment = taLeftJustify)) Then
        Begin
            R.Left := R.Left - 2;
            R.Right := R.Left + GetSystemMetrics(SM_CXHTHUMB);
        End;

        InflateRect(R, -2, -2);
        C.Brush.Color := SelectColor;
        C.Pen.Color := BorderColor;
        C.Ellipse(R.Left, R.Top, R.Right, R.Bottom);

        If TRadioButton(Control).Checked Then
        Begin
            InflateRect(R, -3, -3);

            If Control.Enabled Then
                C.Brush.Color := clHighlight
            Else
                C.Brush.color := xpMenu.FFDisabledColor;

            C.Pen.Color := C.Brush.Color;
            C.Ellipse(R.Left, R.Top, R.Right, R.Bottom);
        End;
    Finally
        C.Free;
    End;


End;

Procedure TControlSubClass.PaintButton;
Var
    C: TControlCanvas;
    R: TRect;
    SelectColor, BorderColor: TColor;
    Txt: String;
    TextRect: TRect;
    TxtFont: TFont;

    CWidth, CHeight, TWidth, THeight: Integer;
    TextFormat: Integer;

Begin

    C := TControlCanvas.Create;
    Try
        C.Control := Control;

        If (FMouseInControl) Then
        Begin
            If Control.Tag = 1000 Then // UseParentColor
                SelectColor := NewColor(C, TControl(Control).Parent.Brush.Color, xpMenu.FDimParentColorSelect)
            Else
                SelectColor := NewColor(C, clBtnFace, xpMenu.FDimParentColorSelect);

            BorderColor := NewColor(C, XPMenu.FFSelectBorderColor, 60);
        End
        Else
        Begin
            If Control.Tag = 1000 Then
                SelectColor := NewColor(C, TControl(Control).Parent.Brush.Color, xpMenu.FDimParentColor)
            Else
                SelectColor := XPMenu.FFIconBackColor;
            BorderColor := clBtnShadow;
        End;


        If (Not FmouseinControl) And (FIsFocused) Then
        Begin
            BorderColor := NewColor(C, XPMenu.FFSelectBorderColor, 60);
        End;

        TextFormat := DT_CENTER + DT_VCENTER;
        R := Control.ClientRect;

        CWidth := (R.Right - R.Left);
        CHeight := (R.Bottom - R.Top);

        C.Brush.Color := Control.Parent.Brush.Color;
        C.FillRect(R);

        C.Brush.Color := SelectColor;

        C.Pen.Color := NewColor(C, BorderColor, 30);
        C.RoundRect(R.Left, R.Top, R.Right, R.Bottom, 4, 4);

        If TControl(Control).Enabled Then
            If FBressed Or (FLButtonBressed And FmouseinControl) {or FBressed} Then
            Begin
                C.Pen.Color := GetShadeColor(C, BorderColor, 50);
                C.MoveTo(R.Left, R.Bottom - 2);
                C.LineTo(R.Left, R.Top + 1);
                C.LineTo(R.Left + 1, R.Top);
                C.LineTo(R.Right - 1, R.Top);
            End
            Else
            Begin
                C.Pen.Color := GetShadeColor(C, BorderColor, 50);
                C.MoveTo(R.Right - 1, R.Top + 1);
                C.LineTo(R.Right - 1, R.Bottom - 2);
                C.LineTo(R.Right - 2, R.Bottom - 1);
                C.LineTo(R.Left, R.Bottom - 1);
            End;

        Txt := TButton(Control).Caption;

        TextRect := R;

        TxtFont := TButton(Control).Font;
        C.Font.Assign(TxtFont);


        If TButton(Control).IsRightToLeft Then
            TextFormat := TextFormat + DT_RTLREADING;

//--- //"Holger Lembke" <holger@hlembke.de>

        If (Txt <> '') Then
        Begin
            FillChar(TextRect, SizeOf(TextRect), 0);
            DrawText(C.Handle,
                Pchar(Txt), Length(Txt),
                TextRect,
                DT_CALCRECT + control.DrawTextBiDiModeFlags(0));
            TWidth := TextRect.Right;
            THeight := TextRect.Bottom;
        End
        Else
        Begin
            TWidth := 0;
            THeight := 0;
        End;

//---
        TextRect.Left := (CWidth - (TWidth)) Div 2;
        TextRect.Right := TextRect.Left + TWidth;
        TextRect.Top := (CHeight - (THeight)) Div 2;
        TextRect.Bottom := TextRect.Top + THeight;


        XPMenu.DrawTheText(Control,
            Txt, '', C,
            TextRect, False,
            TControl(Control).Enabled,
            TButton(Control).Default,
            False,
            TControl(Control).IsRightToLeft,
            TxtFont,
            TextFormat);

    Finally
        C.Free;
    End;

End;

Procedure TControlSubClass.PaintSpeedButton;
Var
    C: TControlCanvas;
    R: TRect;
    SelectColor, BorderColor: TColor;
    Txt: String;
    TextRect, IconRect: TRect;
    TxtFont: TFont;
    B, BF: TBitmap;
    CWidth, CHeight, BWidth, BHeight, TWidth, THeight, Space,
    NumGlyphs, Offset: Integer;
    TextFormat: Integer;
    FDown, FFlat, FTransparent: Boolean;
    FLayout: TButtonLayout;
    P: TPoint;
Begin

    C := TControlCanvas.Create;
    Try
        C.Control := Control;

        FDown := TSpeedButton(Control).Down;
        FFlat := TSpeedButton(Control).Flat;
        FTransparent := TSpeedButton(Control).Transparent;
        NumGlyphs := TSpeedButton(Control).NumGlyphs;

//----------
        If FFlat Then
            If FMouseInControl Then
            Begin
                p := Mouse.CursorPos;
                P := Control.ScreenToClient(P);
                R := Control.ClientRect;
                FMouseInControl := (p.x >= R.Left) And (p.x <= R.Right) And
                    (p.y >= R.Top) And (p.y <= R.Bottom);
            End;

//----------
        If (FMouseInControl) Then
        Begin
            If Control.Tag = 1000 Then // UseParentColor
            Begin
                SelectColor := NewColor(C, TControl(Control).Parent.Brush.Color, xpMenu.FDimParentColorSelect);
                If FFlat Then
                    SelectColor := xpMenu.FFSelectColor;
            End
            Else
            Begin
                SelectColor := NewColor(C, clBtnFace, xpMenu.FDimParentColorSelect);
                If FFlat Then
                    SelectColor := xpMenu.FFSelectColor;
            End;
            BorderColor := NewColor(C, XPMenu.FFSelectBorderColor, 60);
        End
        Else
        Begin
            If Control.Tag = 1000 Then
                SelectColor := NewColor(C, TControl(Control).Parent.Brush.Color, xpMenu.FDimParentColor)
            Else
                SelectColor := XPMenu.FFIconBackColor;
            If FFlat Then
                SelectColor := TControl(Control).Parent.Brush.Color;

            If (Control.ClassName = 'TNavButton') And FFlat Then
            Begin
                SelectColor := TControl(Control).Parent.Brush.Color;
            End;
            BorderColor := clBtnShadow;
        End;


        If FDown Then
        Begin
            SelectColor := XPMenu.FCheckedAreaColor;
            BorderColor := xpMenu.FFSelectBorderColor;
        End;

        If FDown And FMouseInControl Then
        Begin
            SelectColor := XPMenu.FCheckedAreaSelectColor;
            BorderColor := xpMenu.FFSelectBorderColor;
        End;

        If Not TControl(Control).Enabled Then
            BorderColor := clBtnShadow;


        TextFormat := +DT_CENTER + DT_VCENTER;;
        R := Control.ClientRect;

        CWidth := (R.Right - R.Left);
        CHeight := (R.Bottom - R.Top);


        If (FDown Or FMouseInControl) And FTransparent Then
        Begin
            BF := TBitmap.Create;
            Try
                BF.Width := R.Right - R.Left;
                BF.Height := R.Bottom - R.Top;

                If FFlat Then
                Begin
                    If GetDeviceCaps(C.Handle, BITSPIXEL) > 16 Then
                        BF.Canvas.Brush.Color := NewColor(C, xpMenu.FFSelectColor, 20)
                    Else
                        BF.Canvas.Brush.Color := SelectColor;
                End
                Else
                Begin
                    If GetDeviceCaps(C.Handle, BITSPIXEL) > 16 Then
                        BF.Canvas.Brush.Color := NewColor(C, SelectColor, 5)
                    Else
                        BF.Canvas.Brush.Color := SelectColor;
                End;
                BF.Canvas.FillRect(R);
                BitBlt(C.handle,
                    R.Left,
                    R.Top,
                    R.Right - R.left,
                    R.Bottom - R.top,
                    BF.Canvas.Handle,
                    0,
                    0,
                    SRCAND);
            Finally
                BF.Free;
            End;
        End;




        C.Brush.Color := SelectColor;
        If Not FTransparent Then
            c.FillRect(R);

        If Control.ClassName = 'TNavButton' Then
        Begin
            c.FillRect(R);
        End;
        C.Pen.Color := NewColor(C, BorderColor, 30);

        If (FFlat) And (Not FTransparent) And (Not FDown) And (Not FMouseInControl) Then
            C.Pen.Color := C.Brush.Color;

        If FTransparent Then
            C.Brush.Style := bsClear;
        If ((FTransparent) And (FMouseInControl)) Or
            ((FTransparent) And (FDown)) Or
            ((Not FTransparent)) Or
            ((Not FFlat))
        Then
        Begin
            C.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
        End;

        If TControl(Control).Enabled Then
        Begin
            If (FFlat) Then
            Begin
                If (FLButtonBressed) Or (FDown) Then
                Begin
                    C.Pen.Color := BorderColor;
                    C.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
                    C.Pen.Color := GetShadeColor(C, BorderColor, 50);

                    C.MoveTo(R.Left, R.Bottom - 1);
                    C.LineTo(R.Left, R.Top);
                    C.LineTo(R.Right, R.Top);
                End
                Else
                If (FMouseInControl) Then
                Begin
                    C.Pen.Color := xpmenu.FFSelectBorderColor;
                    C.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
                End;
            End;

            If (Not FFlat) Then
                If (FLButtonBressed) Or (FDown) Then
                Begin
                    C.Pen.Color := GetShadeColor(C, BorderColor, 50);
                    C.MoveTo(R.Left, R.Bottom - 1);
                    C.LineTo(R.Left, R.Top);
                    C.LineTo(R.Right, R.Top);
                End
                Else
                Begin
                    C.Pen.Color := GetShadeColor(C, BorderColor, 50);
                    C.MoveTo(R.Right - 1, R.Top);
                    C.LineTo(R.Right - 1, R.Bottom - 1);
                    C.LineTo(R.Left, R.Bottom - 1);
                End;
        End;
        Txt := TSpeedButton(Control).Caption;

        TextRect := R;

        TxtFont := TSpeedButton(Control).Font;
        C.Font.Assign(TxtFont);

        TWidth := C.TextWidth(Txt);
    //THeight := C.TextHeight(Txt);
        TextRect.Left := (CWidth - TWidth) Div 2;


        If TControl(Control).IsRightToLeft Then
            TextFormat := TextFormat + DT_RTLREADING;

//--- //"Holger Lembke" <holger@hlembke.de>

        If (Txt <> '') Then
        Begin
            FillChar(TextRect, sizeof(TextRect), 0);
            DrawText(C.Handle,
                Pchar(Txt), Length(Txt),
                TextRect,
                DT_CALCRECT + control.DrawTextBiDiModeFlags(0));
            TWidth := TextRect.Right;
            THeight := TextRect.Bottom;
        End
        Else
        Begin
            TWidth := 0;
            THeight := 0;
        End;

//---

        If (TSpeedButton(Control).Glyph <> Nil) Then
        Begin
            B := TBitmap.Create;
            BWidth := TSpeedButton(Control).Glyph.Width Div
                TSpeedButton(Control).NumGlyphs;

            BHeight := TSpeedButton(Control).Glyph.Height;

            B.Width := BWidth;
            B.Height := BHeight;
            If Length(TSpeedButton(Control).Caption) > 0 Then
                Space := TSpeedButton(Control).Spacing
            Else
                Space := 0;

            IconRect := Rect(R.Left, R.Top, R.Left + BWidth, R.Top + BHeight);


      // Suggested by : "Holger Lembke" <holger@hlembke.de>
            Offset := 1;
            If (Not Control.Enabled) And (NumGlyphs > 1) Then
                Offset := 2;
            If (FLButtonBressed) And (NumGlyphs > 2) Then
                Offset := 3;
            If (FDown) And (NumGlyphs > 3) Then
                Offset := 4;


            B.Canvas.CopyRect(Rect(0, 0, BWidth, BHeight),
                TSpeedButton(Control).Glyph.Canvas,
                Rect((BWidth * Offset) - BWidth, 0, BWidth * Offset, BHeight));


            FLayout := TSpeedButton(Control).Layout;
            If Control.IsRightToLeft Then
            Begin
                If FLayout = blGlyphLeft Then
                    FLayout := blGlyphRight
                Else
                If FLayout = blGlyphRight Then
                    FLayout := blGlyphLeft;
            End;
            Case FLayout Of
                blGlyphLeft:
                Begin
                    IconRect.Left := (CWidth - (BWidth + Space + TWidth)) Div 2;
                    IconRect.Right := IconRect.Left + BWidth;
                    IconRect.Top := ((CHeight - (BHeight)) Div 2) - 1;
                    IconRect.Bottom := IconRect.Top + BHeight;

                    TextRect.Left := IconRect.Right + Space;
                    TextRect.Right := TextRect.Left + TWidth;
                    TextRect.Top := (CHeight - (THeight)) Div 2;
                    TextRect.Bottom := TextRect.Top + THeight;

                End;
                blGlyphRight:
                Begin
                    IconRect.Right := (CWidth + (BWidth + Space + TWidth)) Div 2;
                    IconRect.Left := IconRect.Right - BWidth;
                    IconRect.Top := (CHeight - (BHeight)) Div 2;
                    IconRect.Bottom := IconRect.Top + BHeight;

                    TextRect.Right := IconRect.Left - Space;
                    TextRect.Left := TextRect.Right - TWidth;
                    TextRect.Top := (CHeight - (THeight)) Div 2;
                    TextRect.Bottom := TextRect.Top + THeight;

                End;
                blGlyphTop:
                Begin
                    IconRect.Left := (CWidth - BWidth) Div 2;
                    IconRect.Right := IconRect.Left + BWidth;
                    IconRect.Top := (CHeight - (BHeight + Space + THeight)) Div 2;
                    IconRect.Bottom := IconRect.Top + BHeight;

                    TextRect.Left := (CWidth - (TWidth)) Div 2;
                    TextRect.Right := TextRect.Left + TWidth;
                    TextRect.Top := IconRect.Bottom + Space;
                    TextRect.Bottom := TextRect.Top + THeight;

                End;
                blGlyphBottom:
                Begin
                    IconRect.Left := (CWidth - BWidth) Div 2;
                    IconRect.Right := IconRect.Left + BWidth;
                    IconRect.Bottom := (CHeight + (BHeight + Space + THeight)) Div 2;
                    IconRect.Top := IconRect.Bottom - BHeight;

                    TextRect.Left := (CWidth - (TWidth)) Div 2;
                    TextRect.Right := TextRect.Left + TWidth;
                    TextRect.Bottom := IconRect.Top - Space;
                    TextRect.Top := TextRect.Bottom - THeight;

                End;

            End;

            xpMenu.DrawIcon(Control, C, B, IconRect,
                FMouseinControl,
                FIsFocused,
                TControl(Control).Enabled,
                FDown Or FLButtonBressed,
                False,
                TControl(Control).IsRightToLeft);

            B.Free;
        End;

        XPMenu.DrawTheText(Control,
            Txt, '', C,
            TextRect, False,
            TControl(Control).Enabled,
            False,
            False,
            TControl(Control).IsRightToLeft,
            TxtFont,
            TextFormat);
    Finally
        C.Free;
    End;

End;

Procedure TControlSubClass.PaintBitButn;
Var
    C: TControlCanvas;
    R: TRect;
    SelectColor, BorderColor: TColor;
    Txt: String;
    TextRect, IconRect: TRect;
    TxtFont: TFont;
    B: TBitmap;
    CWidth, CHeight, BWidth, BHeight, TWidth, THeight, Space: Integer;
    TextFormat: Integer;
Begin

    C := TControlCanvas.Create;
    Try
        C.Control := Control;

        If (FMouseInControl Or FBressed) Then
        Begin
            If (Control.Tag And 1000) = 1000 Then
                SelectColor := NewColor(C,
                    TControl(Control).Parent.Brush.Color, xpMenu.FDimParentColorSelect)
            Else
                SelectColor := NewColor(C, clBtnFace, xpMenu.FDimParentColorSelect);
            BorderColor := NewColor(C, XPMenu.FFSelectBorderColor, 60);
        End
        Else
        Begin
            If (Control.Tag And 1000) = 1000 Then
                SelectColor := NewColor(C, TControl(Control).Parent.Brush.Color, xpMenu.FDimParentColor)
            Else
                SelectColor := XPMenu.FFIconBackColor;
            BorderColor := clBtnShadow;
        End;

        If (Not FmouseinControl) And (FIsFocused) Then
        Begin
            BorderColor := NewColor(C, XPMenu.FFSelectBorderColor, 60);
        End;

        If (Control.Tag And 1001) = 1001 Then
        Begin
            BorderColor := SelectColor;
        End;


        TextFormat := +DT_CENTER + DT_VCENTER;

        R := Control.ClientRect;

        CWidth := (R.Right - R.Left);
        CHeight := (R.Bottom - R.Top);


        C.Brush.Color := Control.Parent.Brush.Color;
        C.FillRect(R);

        C.Brush.Color := SelectColor;


        C.Pen.Color := NewColor(C, BorderColor, 30);
        c.RoundRect(R.Left, R.Top, R.Right, R.Bottom, 4, 4);

        If (Control.Tag And 1001) <> 1001 Then
        Begin
            If TControl(Control).Enabled Then
                If (FLButtonBressed And FmouseinControl) Or (FBressed) Then
                Begin
                    C.Pen.Color := GetShadeColor(C, BorderColor, 50);
                    C.MoveTo(R.Left, R.Bottom - 2);
                    C.LineTo(R.Left, R.Top + 1);
                    C.LineTo(R.Left + 1, R.Top);
                    C.LineTo(R.Right - 1, R.Top);
                End
                Else
                Begin
                    C.Pen.Color := GetShadeColor(C, BorderColor, 50);
                    C.MoveTo(R.Right - 1, R.Top + 1);
                    C.LineTo(R.Right - 1, R.Bottom - 2);
                    C.LineTo(R.Right - 2, R.Bottom - 1);
                    C.LineTo(R.Left, R.Bottom - 1);
                End;
        End;
        Txt := TBitBtn(Control).Caption;

        TextRect := R;

        TxtFont := TBitBtn(Control).Font;
        C.Font.Assign(TxtFont);

        TWidth := C.TextWidth(Txt);

        TextRect.Left := (CWidth - TWidth) Div 2;


//--- //"Holger Lembke" <holger@hlembke.de>

        If (Txt <> '') Then
        Begin
            FillChar(TextRect, sizeof(TextRect), 0);
            DrawText(C.Handle,
                Pchar(Txt), Length(Txt),
                TextRect,
                DT_CALCRECT + control.DrawTextBiDiModeFlags(0));
            TWidth := TextRect.Right;
            THeight := TextRect.Bottom;
        End
        Else
        Begin
            TWidth := 0;
            THeight := 0;
        End;

//---
        If TBitBtn(Control).IsRightToLeft Then
            TextFormat := TextFormat + DT_RTLREADING;


        If (TBitBtn(Control).Glyph <> Nil) Then
        Begin
            B := TBitmap.Create;
            BWidth := TBitBtn(Control).Glyph.Width Div
                TBitBtn(Control).NumGlyphs;

            BHeight := TBitBtn(Control).Glyph.Height;

            B.Width := BWidth;
            B.Height := BHeight;
            Space := TBitBtn(Control).Spacing;
            If (Trim(TBitBtn(Control).Caption) = '') Then
                Space := 0; //"Holger Lembke" <holger@hlembke.de>
            IconRect := Rect(R.Left, R.Top, R.Left + BWidth, R.Top + BHeight);

            B.Canvas.CopyRect(Rect(0, 0, BWidth, BHeight),
                TBitBtn(Control).Glyph.Canvas,
                Rect(0, 0, BWidth, BHeight));

            Case TBitBtn(Control).Layout Of
                blGlyphLeft:
                Begin
                    IconRect.Left := (CWidth - (BWidth + Space + TWidth)) Div 2;
                    IconRect.Right := IconRect.Left + BWidth;
                    IconRect.Top := (CHeight - (BHeight)) Div 2;
                    IconRect.Bottom := IconRect.Top + BHeight;

                    TextRect.Left := IconRect.Right + Space;
                    TextRect.Right := TextRect.Left + TWidth;

                    TextRect.Top := (CHeight - (THeight)) Div 2;
                    TextRect.Bottom := TextRect.Top + THeight;
                End;
                blGlyphRight:
                Begin
                    IconRect.Right := (CWidth + (BWidth + Space + TWidth)) Div 2;
                    IconRect.Left := IconRect.Right - BWidth;
                    IconRect.Top := (CHeight - (BHeight)) Div 2;
                    IconRect.Bottom := IconRect.Top + BHeight;

                    TextRect.Right := IconRect.Left - Space;
                    TextRect.Left := TextRect.Right - TWidth;
                    TextRect.Top := (CHeight - (THeight)) Div 2;
                    TextRect.Bottom := TextRect.Top + THeight;
                End;
                blGlyphTop:
                Begin
                    IconRect.Left := (CWidth - BWidth) Div 2;
                    IconRect.Right := IconRect.Left + BWidth;
                    IconRect.Top := (CHeight - (BHeight + Space + THeight)) Div 2;
                    IconRect.Bottom := IconRect.Top + BHeight;

                    TextRect.Left := (CWidth - (TWidth)) Div 2;
                    TextRect.Right := TextRect.Left + TWidth;
                    TextRect.Top := IconRect.Bottom + Space;
                    TextRect.Bottom := TextRect.Top + THeight;

                End;
                blGlyphBottom:
                Begin
                    IconRect.Left := (CWidth - BWidth) Div 2;
                    IconRect.Right := IconRect.Left + BWidth;
                    IconRect.Bottom := (CHeight + (BHeight + Space + THeight)) Div 2;
                    IconRect.Top := IconRect.Bottom - BHeight;

                    TextRect.Left := (CWidth - (TWidth)) Div 2;
                    TextRect.Right := TextRect.Left + TWidth;
                    TextRect.Bottom := IconRect.Top - Space;
                    TextRect.Top := TextRect.Bottom - THeight;

                End;
            End;

            xpMenu.DrawIcon(Control, C, B, IconRect,
                FMouseinControl,
                FIsFocused,
                TControl(Control).Enabled,
                False,
                False,
                TControl(Control).IsRightToLeft);

            B.Free;
        End;

        If (Control.Tag And 1002) = 1002 Then
        Begin
            If TBitBtn(Control).IsRightToLeft Then
                TextFormat := +DT_RIGHT + DT_VCENTER
            Else
                TextFormat := +DT_LEFT + DT_VCENTER;
            TextRect := R;
            InflateRect(TextRect, -4, -2);
        End;

        XPMenu.DrawTheText(Control,
            Txt, '', C,
            TextRect, False,
            TControl(Control).Enabled,
            TBitBtn(Control).Default,
            False,
            TControl(Control).IsRightToLeft,
            TxtFont,
            TextFormat);

    Finally
        C.Free;
    End;
End;

Procedure TControlSubClass.PaintUpDownButton;
Var
    C: TControlCanvas;
    R: TRect;
    SelectColor, BorderColor, ArrowColor: TColor;
    P: TPoint;
    H: Integer;

    Procedure DrawUpDownButton(ARect: TRect; Arrow: Integer; Active: Boolean);
    Begin
        If Control.Enabled Then
            ArrowColor := clBlack Else ArrowColor := clWhite;
        If Active Then
        Begin
            If FLButtonBressed Then
            Begin
                BorderColor := XPMenu.FFSelectBorderColor;
                SelectColor := XPMenu.FCheckedAreaSelectColor;
                ArrowColor := clWhite;
            End
            Else
            Begin
                BorderColor := XPMenu.FFSelectBorderColor;
                SelectColor := NewColor(C, XPMenu.FFSelectColor, 60);//XPMenu.FFSelectColor;
            End;
        End
        Else
        Begin
            If Control.Tag = 1000 Then
                SelectColor := NewColor(C, TControl(Control).Parent.Brush.Color, xpMenu.FDimParentColor)
            Else
                SelectColor := NewColor(C, XPMenu.FFSelectColor, xpMenu.FDimParentColor);//clBtnFace;
            BorderColor := NewColor(C, TControl(Control).Parent.Brush.Color, 80);//SelectColor;
        End;

        C.Pen.Color := BorderColor;
        C.Brush.Color := SelectColor;
        C.Font.Color := ArrowColor;

        If C.Pixels[ARect.Left, ARect.Top] <> ColorToRGB(BorderColor) Then
        Begin
            C.Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
            C.Pen.Color := ArrowColor;
            DrawArrow(C, ARect.Left + ((ARect.Right - ARect.Left) Div 2),
                ARect.Top + ((ARect.Bottom - ARect.Top) Div 2) - 2, Arrow);
        End;
    End;

Begin
    C := TControlCanvas.Create;
    Try
        C.Control := Control;
        R := Control.ClientRect;

        H := (R.Bottom - R.Top) Div 2;
        P := Control.ScreenToClient(Mouse.CursorPos);
        DrawUpDownButton(Rect(R.Left, R.Top, R.Right, R.Top + H), 0,
            TControl(Control).Enabled And FMouseInControl And (P.Y < H));
        DrawUpDownButton(Rect(R.Left, R.Bottom - H, R.Right, R.Bottom), 1,
            TControl(Control).Enabled And FMouseInControl And Not (P.Y < H));
    Finally
        C.Free;
    End;
End;

Procedure TControlSubClass.PaintGroupBox;
Var
    C: TControlCanvas;
    R, RText: TRect;
    ShadowColor, LightColor: TColor;
    TextHeight, TextWidth: Integer;
    Text: String;
Begin

    If FMsg <> WM_PAINT Then
        exit;
    C := TControlCanvas.Create;
    Try
        C.Control := Control;

        R := Control.ClientRect;
        C.Font.Assign(TGroupBox(Control).Font);
        C.Font.Height := TGroupBox(Control).Font.Height;
        Text := TGroupBox(Control).Caption;

        TextHeight := C.TextHeight(Text);
        TextWidth := C.TextWidth(Text);
        If Length(Text) = 0 Then
            TextHeight := C.TextHeight(' ');
        ShadowColor := GetShadeColor(C, TGroupBox(Control).color, 60);
        LightColor := NewColor(C, TGroupBox(Control).color, 60);

        InflateRect(R, -1, -1);
        Inc(R.Top, (TextHeight) - 1);
        C.Brush.Style := bsClear;
        C.Pen.Color := TGroupBox(Control).Color; // Control Color;
        C.Rectangle(R.Left, R.Top, R.Right, R.Bottom);


    //----Draw the outer Frame
        R := Control.ClientRect;
        Inc(R.Top, (TextHeight Div 2) - 1);
        C.Pen.Color := TGroupBox(Control).Color;
        C.MoveTo(R.Left + 1, R.Top);   // Repeat
        C.LineTo(R.Left + 1, R.Bottom);
        If TGroupBox(Control).Ctl3D Then
            Frame3D(C, R, LightColor, ShadowColor, 1)
        Else
            Frame3D(C, R, ShadowColor, ShadowColor, 1);


    // Fill Upper part (outside frame)
        R := Control.ClientRect;
        R.Bottom := R.Top + (TextHeight Div 2) + 1;
        C.Brush.Style := bsSolid;
        C.Brush.Color := Control.Parent.Brush.Color;  // Parent Color;
        C.Pen.Color := C.Brush.Color;
        C.FillRect(R);


        If Control.IsRightToLeft Then
        Begin
            C.TextFlags := ETO_RTLREADING;
            RText.Right := R.Right - 9;
            RText.Left := RText.Right - TextWidth;
        End
        Else
        Begin
            RText.Left := R.Left + 9;
            RText.Right := RText.Left + TextWidth;
        End;

        RText.Top := R.Top;
        RText.Bottom := R.Top + TextHeight;

                     //(inside frame)
        InflateRect(R, -1, 0);
        R.Top := R.Bottom;
        R.Bottom := R.Top + (TextHeight Div 2) + 1;
        C.Brush.Style := bsSolid;
        R.Left := RText.Left;
        R.Right := RText.Right;
        C.Brush.Color := TGroupBox(Control).Color; // Control Color;
        C.Pen.Color := C.Brush.Color;
        C.FillRect(R);

        R.Right := Control.ClientRect.Right;

        C.MoveTo(R.Right - 2, R.Top);
        C.LineTo(R.Right - 2, RText.Bottom);

        C.Brush.Style := bsClear;
        If Control.IsRightToLeft Then
            C.TextFlags := ETO_RTLREADING;

        C.TextRect(RText, RText.Left, RText.Top, Text);

    // Draw Upper Line
        R := Control.ClientRect;
        Inc(R.Top, (TextHeight Div 2) + 1);
        If TGroupBox(Control).Ctl3D Then
            C.Pen.Color := LightColor
        Else
            C.Pen.Color := ShadowColor;
        C.MoveTo(R.Left, R.Top);
        C.LineTo(RText.Left, R.Top);

        C.MoveTo(RText.Right, R.Top);
        C.LineTo(R.Right - 1, R.Top);

    Finally
        C.Free;
    End;
End;

Procedure TControlSubClass.PaintPanel;
Var
    C: TControlCanvas;
    R: TRect;
    ShadowColor, LightColor: TColor;
Begin
    If FMsg <> WM_PAINT Then
        exit;
    C := TControlCanvas.Create;
    Try
        C.Control := Control;

        R := Control.ClientRect;
        ShadowColor := GetShadeColor(C, TPanel(Control).color, 60);
        LightColor := NewColor(C, TPanel(Control).color, 60);
        If TPanel(Control).BevelOuter <> bvNone Then
        Begin
            If TPanel(Control).BevelOuter = bvLowered Then
                Frame3D(C, R, ShadowColor, LightColor, TPanel(Control).BevelWidth)
            Else
                Frame3D(C, R, LightColor, ShadowColor, TPanel(Control).BevelWidth);
        End;

        If TPanel(Control).BevelInner <> bvNone Then
        Begin
            InflateRect(R, -TPanel(Control).BorderWidth, -TPanel(Control).BorderWidth);

            If TPanel(Control).BevelInner = bvLowered Then
                Frame3D(C, R, ShadowColor, LightColor, TPanel(Control).BevelWidth)
            Else
                Frame3D(C, R, LightColor, ShadowColor, TPanel(Control).BevelWidth);
        End;
    Finally
        C.Free;
    End;

End;

Type
    TCastWinControl = Class(TWinControl);

Procedure TControlSubClass.PaintNCWinControl;
Var
    DC: HDC;
    C: TControlCanvas;
    R: TRect;
    BorderColor: TColor;

Begin
    C := TControlCanvas.Create;
    DC := GetWindowDC(TWinControl(Control).Handle);
    Try
        C.Control := Control;
        C.Handle := DC;

        XPMenu.SetGlobalColor(C);

        If (FMouseInControl) Or (FIsFocused) Then
        Begin
            If FBorderStyle = bsSingle Then
                BorderColor := NewColor(C, XPMenu.FFSelectBorderColor, 60)
            Else
                BorderColor := NewColor(C, XPMenu.FFSelectBorderColor, 80);
        End
        Else
        Begin
            If FBorderStyle = bsSingle Then
                borderColor := GetShadeColor(C, Control.Parent.Brush.Color, 60)
            Else
                borderColor := Control.Parent.Brush.Color;
        End;

        If TCastWinControl(Control).Ctl3D <> False Then
        Begin
            FBuilding := True;
            TCastWinControl(Control).Ctl3D := False;
        End;

        C.Pen.Color := BorderColor;
        C.Brush.Style := bsClear;

        R := Rect(0, 0, Control.Width, Control.Height);
        C.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
    Finally
        C.Free;
        ReleaseDC(TWinControl(Control).Handle, DC);
    End;
End;

Procedure TControlSubClass.PaintProgressBar;
Var
    DC: HDC;
    C: TControlCanvas;
    R: TRect;
    BorderColor: TColor;

Begin
    C := TControlCanvas.Create;
    DC := GetWindowDC(TWinControl(Control).Handle);
    Try
        C.Control := Control;
        C.Handle := DC;

        If (FMouseInControl) Then
            BorderColor := XPMenu.FFSelectBorderColor
        Else
            BorderColor := GetShadeColor(C, Control.Parent.Brush.Color, 60);

        C.Pen.Color := BorderColor;
        C.Brush.Style := bsClear;

        R := Rect(0, 0, Control.Width, Control.Height);
        C.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
    Finally
        C.Free;
        ReleaseDC(TWinControl(Control).Handle, DC);
    End;
End;

Procedure TControlSubClass.PaintHotKey;
Var
    DC: HDC;
    C: TControlCanvas;
    R: TRect;
    BorderColor: TColor;

Begin
    C := TControlCanvas.Create;
    DC := GetWindowDC(TWinControl(Control).Handle);
    Try
        C.Control := Control;
        C.Handle := DC;

        XPMenu.SetGlobalColor(C);

        If (FMouseInControl) Or (FIsFocused) Then
            BorderColor := NewColor(C, XPMenu.FFSelectBorderColor, 60)
        Else
            BorderColor := GetShadeColor(C, Control.Parent.Brush.Color, 60);

        C.Pen.Color := BorderColor;
        C.Brush.Style := bsClear;

        R := Rect(0, 0, Control.Width, Control.Height);
        C.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
        InflateRect(R, -1, -1);
        C.Pen.Color := clWindow;
        C.Rectangle(R.Left, R.Top, R.Right, R.Bottom);

    Finally
        C.Free;
        ReleaseDC(TWinControl(Control).Handle, DC);
    End;
End;

// XPMenuManager
//
// Uwe Runkel, uwe@runkel.info
//
// Enable XPMenu to be used globally (all windows in the application use XPMenu).
// Hence you don't need more than one instance in an application. However it is also
// possible to have more than one instance. But only one instance is used for subclassing.
// If this instance is destroyed the manager looks if there is another instance which is
// allowed to subclass.

Constructor TXPMenuManager.Create;
Begin
    Inherited Create;
    FXPMenuList := TList.Create;         // list of XPMenu components in the application
    FFormList := TList.Create;           // list of subclassed forms
    FPendingFormsList := TList.Create;   // list of forms inserted but not subclassed yet
    FDisableSubclassing := False;        // This disables the XPMenuManager
    FActiveXPMenu := Nil;                // Currently for subclassing used XPMenu
                                       //    if this is nil no subclassing is done.
    Application.HookMainWindow(MainWindowHook);
End;

Destructor TXPMenuManager.Destroy;
Begin
{Bret Goldsmith bretg@yahoo.com}
{alexs <alexs75@hotbox.ru>  }
    Application.UnhookMainWindow(MainWindowHook);

    FPendingFormsList.Free;
    FXPMenuList.Free;
    FFormList.Free;
    Inherited;
End;

// A component has been inserted or removed, if it is a form and subclassing is
// allowed then subclass it, so this form doesn't need a XPMenu component as well
Procedure TXPMenuManager.Notification(AComponent: TComponent; Operation: TOperation);
Begin
    If (FActiveXPMenu = Nil) Or FDisableSubclassing Then
        Exit;
    Case Operation Of
        opInsert:
      // At this place we cannot subclass the control because it did not yet get its
      // initial window procedure.
      // So we add it to an intermediate list and subclass it at a later moment.
            If (AComponent Is TCustomForm) And (FPendingFormsList.IndexOf(AComponent) < 0) Then
                FPendingFormsList.Add(AComponent);
        opRemove:
            If (AComponent Is TWinControl) Then
            Begin
                If AComponent Is TCustomForm Then
                Begin
          // Remove the destroyed form from any form list if it is still there.
                    FPendingFormsList.Remove(AComponent);
                    FFormList.Remove(AComponent);
                End;
            End;
    End;
End;

// Add some XPMenu to the manager
Procedure TXPMenuManager.Add(AXPMenu: TXPMenu);
Begin
    FXPMenuList.Add(AXPMenu);
    FFormList.Add(AXPMenu.Form);
    If (FActiveXPMenu = Nil) And AXPMenu.Active And Not (AXPMenu.DisableSubclassing) And
        Not (FDisableSubclassing) Then
    Begin
        FActiveXPMenu := AXPMenu;
        CollectForms;
    End;
End;

// Remove some XPMenu from the manager
Procedure TXPMenuManager.Delete(AXPMenu: TXPMenu);
Begin
    If AXPMenu = FActiveXPMenu Then
        UpdateActiveXPMenu(AXPMenu);
    FXPMenuList.Remove(AXPMenu);
End;

// Select a new ActiveXPMenu (except the one given in the parameter)
Procedure TXPMenuManager.UpdateActiveXPMenu(AXPMenu: TXPMenu);
Var
    Cnt: Integer;
    XPM: TXPMenu;
    Item: TControlSubClass;
    Comp: TControlSubClass;

Begin
    XPM := FindSubclassingXPMenu(AXPMenu);
    If XPM = Nil Then
    Begin
        FPendingFormsList.Clear;
        If Not Assigned(Application.MainForm) Then
            Exit;
        For Cnt := 0 To FFormList.Count - 1 Do
            If (AXPMenu = Nil) Or (FFormList[Cnt] <> AXPMenu.Form) Then
                RemoveChildSubclassing(TCustomForm(FFormList[Cnt]));
        FFormList.Clear;
        FActiveXPMenu := XPM;
    End
    Else
    Begin
        If FActiveXPMenu = Nil Then
        Begin
            FActiveXPMenu := XPM;
            CollectForms;
        End
        Else
        Begin
            For Cnt := 0 To FActiveXPMenu.ComponentCount - 1 Do
                If (FActiveXPMenu.Components[Cnt] Is TControlSubClass) Then
                Begin
                    Comp := FActiveXPMenu.Components[Cnt] As TControlSubClass;
                    If (AXPMenu <> Nil) And Not (AXPMenu.Form.ContainsControl(Comp.Control)) Then
                    Begin
                        Item := TControlSubClass.Create(XPM);
                        Item.Control := Comp.Control;
                        Item.orgWindowProc := Comp.orgWindowProc;
                        Item.Control.WindowProc := Item.ControlSubClass;
                        Item.XPMenu := XPM;
                        Item.FCtl3D := Comp.FCtl3D;
                        Item.FBorderStyle := Comp.FBorderStyle;
      {Item.FOnDrawCell := Comp.FOnDrawCell;}
                        Item.FDefaultDrawing := Comp.FDefaultDrawing;
                        Item.FSelCol := Comp.FSelCol;
                        Item.FSelRow := Comp.FSelRow;
                    End;
                End;
            FActiveXPMenu := XPM;
        End;
    End;
End;

// Find an XPMenu which can be used for subclassing
Function TXPMenuManager.FindSubclassingXPMenu(Exclude: TXPMenu): TXPMenu;
Var
    XPM: TXPMenu;
    Cnt: Integer;

Begin
    Result := Nil;
    If (FXPMenuList.Count = 0) Or FDisableSubclassing Then
        Exit;
    Cnt := 0;
    Repeat
        XPM := TXPMenu(FXPMenuList[Cnt]);
        If XPM.Active And Not (XPM.DisableSubclassing) And (XPM <> Exclude)
        Then
            Result := XPM;
        inc(Cnt);
    Until (Result <> Nil) Or (Cnt = FXPMenuList.Count);
End;

// Listens to messages sent to the application and looks if a window is inserted.
Function TXPMenuManager.MainWindowHook(Var Message: TMessage): Boolean;
Var
    i: Integer;
    NewForm: TCustomForm;

    FMenuItem: TMenuItem; // +jt
    FMenu: TMenu; // +jt
    r: TRECT; // +jt
    pt: TPOINT; // +jt
    hWndM: HWND; // +j
Begin
    Result := False;
  // +ahuser// ahuser: "Andreas Hausladen" <Andreas.Hausladen@gmx.de>
    If XPMenuManager = Nil Then  // prevent AVs on termination
        Exit;
  // +ahuser
    If Message.Msg = WM_DRAWMENUBORDER Then
    Begin
        FMenuItem := TMenuItem(Message.LParam);
        If Assigned(FMenuItem) Then
        Begin
            GetMenuItemRect(0, FMenuItem.Parent.Handle, FMenuItem.MenuIndex, r);
            FMenu := FMenuItem.Parent.GetParentMenu;
            pt.x := r.Left + (r.Right - r.Left) Div 2;
            pt.y := r.Top + (r.Bottom - r.Top) Div 2;
            hWndM := WindowFromPoint(pt);
            If (hWndM <> 0) And Assigned(FActiveXPMenu) Then  //Rappido <rappido@quicknet.nl> 2003 09 13
                FActiveXPMenu.DrawWindowBorder(hWndM, FMenu.IsRightToLeft);
        End;
    End;

    If Message.Msg = WM_DRAWMENUBORDER2 Then
    Begin
        hWndM := HWND(Message.LParam);
        If (hWndM <> 0) And Assigned(FActiveXPMenu) Then //Rappido <rappido@quicknet.nl> 2003 09 13
            FActiveXPMenu.DrawWindowBorder(hWndM, Boolean(Message.WParam));
    End;

    If (Assigned(FPendingFormsList)) And (FPendingFormsList <> Nil) Then
        Try
            If (FPendingFormsList.Count > 0) Then
            Begin
                For i := 0 To FPendingFormsList.Count - 1 Do
                Begin
                    NewForm := TCustomForm(FPendingFormsList[i]);
                    If FFormList.IndexOf(NewForm) < 0 Then
                    Begin
                        FFormList.Add(NewForm);
                        If Not (FDisableSubclassing) Then
                            FActiveXPMenu.InitItems(NewForm, True, True);
                    End;
                End;
                FPendingFormsList.Clear;
            End;
        Except
        End;


End;

// Collect all forms of the application and subclass them
Procedure TXPMenuManager.CollectForms;
Var
    FCnt, CCnt: Integer;
    HasXPMenu: Boolean;

Begin
    If Not FDisableSubclassing Then
        For FCnt := 0 To Screen.FormCount - 1 Do
            If (FFormList.IndexOf(Screen.Forms[FCnt]) < 0) And (Screen.Forms[FCnt].Tag <> 999) Then
            Begin
                HasXPMenu := False;
                For CCnt := 0 To Screen.Forms[FCnt].ComponentCount - 1 Do
                    HasXPMenu := HasXPMenu Or (Screen.Forms[FCnt].Components[CCnt] Is TXPMenu);
                If Not (HasXPMenu) Then
                    FPendingFormsList.Add(Screen.Forms[FCnt]);
            End;
End;

// Remove subclassing from the original components
Procedure TXPMenuManager.RemoveChildSubclassing(AForm: TCustomForm);
Var
    Cnt: Integer;
    Comp: TComponent;
    Control: TControl;

Begin
//exit;
    For Cnt := FActiveXPMenu.ComponentCount - 1 Downto 0 Do
    Begin
        Comp := FActiveXPMenu.Components[Cnt];
        If (Comp Is TControlSubClass) Then
        Begin
            Control := TControlSubClass(Comp).Control;
            If AForm.ContainsControl(Control) Then
            Begin
                Try
                    Control.WindowProc := TControlSubClass(Comp).orgWindowProc;
                    If Control Is TCustomEdit Then
                    Begin
                        TEdit(Control).Ctl3D := TControlSubClass(Comp).FCtl3D;
                        TEdit(Control).BorderStyle := TControlSubClass(Comp).FBorderStyle;
                    End;
                    If Control.ClassName = 'TDBLookupComboBox' Then
                        TComboBox(Control).Ctl3D := TControlSubClass(Comp).FCtl3D;
                    If Control Is TCustomListBox Then
                    Begin
                        TListBox(Control).Ctl3D := TControlSubClass(Comp).FCtl3D;
                        TListBox(Control).BorderStyle := TControlSubClass(Comp).FBorderStyle;
                    End;
                    If Control Is TCustomListView Then
                    Begin
                        TListView(Control).Ctl3D := TControlSubClass(Comp).FCtl3D;
                        TListView(Control).BorderStyle := TControlSubClass(Comp).FBorderStyle;
                    End;
                    If Control Is TCustomTreeView Then
                    Begin
                        TTreeView(Control).Ctl3D := TControlSubClass(Comp).FCtl3D;
                        TTreeView(Control).BorderStyle := TControlSubClass(Comp).FBorderStyle;
                    End;
                Except
                End;
            End;
        End;
    End;
End;

// Add a form manually to the current XPMenu
Procedure TXPMenuManager.AddForm(AForm: TCustomForm);
Begin
    If FPendingFormsList.IndexOf(AForm) < 0 Then
        FPendingFormsList.Add(AForm);
End;

// Remove a form manually from the current XPMenu
Procedure TXPMenuManager.RemoveForm(AForm: TCustomForm);
Begin
    If FPendingFormsList.IndexOf(AForm) >= 0 Then
        FPendingFormsList.Remove(AForm);
    If FFormList.IndexOf(AForm) >= 0 Then
        FFormList.Remove(AForm);
End;

// Disable/Enable subclassing by the manager
Procedure TXPMenuManager.SetDisableSubclassing(AValue: Boolean);
Begin
    If FDisableSubclassing = AValue Then
        Exit;
    FDisableSubclassing := AValue;
    UpdateActiveXPMenu(Nil);
End;

// Check if a Form is subclassed
Function TXPMenuManager.IsFormSubclassed(AForm: TCustomForm): Boolean;
Begin
    Result := ((FFormList <> Nil) And (FFormList.IndexOf(AForm) >= 0)) Or
        ((FPendingFormsList <> Nil) And (FPendingFormsList.IndexOf(AForm) >= 0));
End;

// Check if a Component is subclassed
Function TXPMenuManager.IsComponentSubclassed(AComponent: TComponent): Boolean;
Var
    Cnt: Integer;

Begin
    Result := False;
    With FActiveXPMenu Do
        For Cnt := 0 To ComponentCount - 1 Do
            If Components[Cnt] Is TControlSubClass Then
                If TControlSubClass(Components[Cnt]).Control = TControl(AComponent) Then
                Begin
                    Result := True;
                    Break; // ahuser
                End;
End;


End.
