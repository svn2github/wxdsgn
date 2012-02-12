Unit ColorPickerButton;

// This unit contains a special speed button which can be used to let the user select
// a specific color. The control does not use the standard Windows color dialog, but
// a popup window very similar to the one in Office97, which has been improved a lot
// to support the task of picking one color out of millions. Included is also the
// ability to pick one of the predefined system colors (e.g. clBtnFace).
// Note: The layout is somewhat optimized to look pretty with the predefined box size
//       of 18 pixels (the size of one little button in the predefined color area) and
//       the number of color comb levels. It is easily possible to change this, but
//       if you want to do so then you have probably to make some additional
//       changes to the overall layout.
//
// TColorPickerButton works only with D4 and BCB!
// (BCB check by Josue Andrade Gomes gomesj@bsi.com.br)
//
// (c) 1999, written by Dipl. Ing. Mike Lischke (public@lischke-online.de)
// All rights reserved. This unit is freeware and may be used in any software
// product (free or commercial) under the condition that I'm given proper credit
// (Titel, Name and eMail address in the documentation or the About box of the
// product this source code is used in).
// Portions copyright by Borland. The implementation of the speed button has been
// taken from Delphi sources.
//
// 22-JUN-99 ml: a few improvements for the overall layout (mainly indicator rectangle
//               does now draw in four different styles and considers the layout
//               property of the button (changed to version 1.2, BCB compliance is
//               now proved by Josue Andrade Gomes)
// 18-JUN-99 ml: message redirection bug removed (caused an AV under some circumstances)
//               and accelerator key handling bug removed (wrong flag for EndSelection)
//               (changed to version 1.1)
// 16-JUN-99 ml: initial release

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Controls, Forms, Graphics, StdCtrls,
    ExtCtrls, CommCtrl;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QControls, QForms, QGraphics, QStdCtrls,
  QCommCtrl;
{$ENDIF}

Const // constants used in OnHint and internally to indicate a specific cell
    DefaultCell = -3;
    CustomCell = -2;
    NoCell = -1;

Type
    TButtonLayout = (blGlyphLeft, blGlyphRight, blGlyphTop, blGlyphBottom);
    TButtonState = (bsUp, bsDisabled, bsDown, bsExclusive);
    TButtonStyle = (bsAutoDetect, bsWin31, bsNew);
    TNumGlyphs = 1..4;

    TIndicatorBorder = (ibNone, ibFlat, ibSunken, ibRaised);

    THintEvent = Procedure(Sender: TObject; Cell: Integer; Var Hint: String) Of Object;
    TDropChangingEvent = Procedure(Sender: TObject; Var Allowed: Boolean) Of Object;

    TColorPickerButton = Class(TGraphicControl)
    Private
        FGroupIndex: Integer;
        FGlyph: Pointer;
        FDown: Boolean;
        FDragging: Boolean;
        FAllowAllUp: Boolean;
        FLayout: TButtonLayout;
        FSpacing: Integer;
        FMargin: Integer;
        FFlat: Boolean;
        FMouseInControl: Boolean;
        FTransparent: Boolean;
        FIndicatorBorder: TIndicatorBorder;

        FDropDownArrowColor: TColor;
        FDropDownWidth: Integer;
        FDropDownZone: Boolean;
        FDroppedDown: Boolean;
        FSelectionColor: TColor;
        FState: TButtonState;
        FColorPopup: TWinControl;
        FPopupWnd: HWND;

        FOnChange,
        FOnDefaultSelect,
        FOnDropChanged: TNotifyEvent;
        FOnDropChanging: TDropChangingEvent;
        FOnHint: THintEvent;
        Procedure GlyphChanged(Sender: TObject);
        Procedure UpdateExclusive;
        Function GetGlyph: TBitmap;
        Procedure SetDropDownArrowColor(Value: TColor);
        Procedure SetDropDownWidth(Value: Integer);
        Procedure SetGlyph(Value: TBitmap);
        Function GetNumGlyphs: TNumGlyphs;
        Procedure SetNumGlyphs(Value: TNumGlyphs);
        Procedure SetDown(Value: Boolean);
        Procedure SetFlat(Value: Boolean);
        Procedure SetAllowAllUp(Value: Boolean);
        Procedure SetGroupIndex(Value: Integer);
        Procedure SetLayout(Value: TButtonLayout);
        Procedure SetSpacing(Value: Integer);
        Procedure SetMargin(Value: Integer);
        Procedure UpdateTracking;
        Procedure CMEnabledChanged(Var Message: TMessage); Message CM_ENABLEDCHANGED;
        Procedure CMButtonPressed(Var Message: TMessage); Message CM_BUTTONPRESSED;
        Procedure CMDialogChar(Var Message: TCMDialogChar); Message CM_DIALOGCHAR;
        Procedure CMFontChanged(Var Message: TMessage); Message CM_FONTCHANGED;
        Procedure CMTextChanged(Var Message: TMessage); Message CM_TEXTCHANGED;
        Procedure CMSysColorChange(Var Message: TMessage); Message CM_SYSCOLORCHANGE;
        Procedure CMMouseEnter(Var Message: TMessage); Message CM_MOUSEENTER;
        Procedure CMMouseLeave(Var Message: TMessage); Message CM_MOUSELEAVE;
        Procedure WMLButtonDblClk(Var Message: TWMLButtonDown); Message WM_LBUTTONDBLCLK;

        Procedure DrawButtonSeperatorUp(Canvas: TCanvas);
        Procedure DrawButtonSeperatorDown(Canvas: TCanvas);
        Procedure DrawTriangle(Canvas: TCanvas; Top, Left, Width: Integer);
        Procedure SetDroppedDown(Const Value: Boolean);
        Procedure SetSelectionColor(Const Value: TColor);
        Procedure PopupWndProc(Var Msg: TMessage);
        Function GetCustomText: String;
        Procedure SetCustomText(Const Value: String);
        Function GetDefaultText: String;
        Procedure SetDefaultText(Const Value: String);
        Procedure SetShowSystemColors(Const Value: Boolean);
        Function GetShowSystemColors: Boolean;
        Procedure SetTransparent(Const Value: Boolean);
        Procedure SetIndicatorBorder(Const Value: TIndicatorBorder);
        Function GetPopupSpacing: Integer;
        Procedure SetPopupSpacing(Const Value: Integer);
    Protected
        Procedure DoDefaultEvent; Virtual;
        Procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); Override;
        Function GetPalette: HPALETTE; Override;
        Procedure Loaded; Override;
        Procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); Override;
        Procedure MouseMove(Shift: TShiftState; X, Y: Integer); Override;
        Procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); Override;
        Procedure Paint; Override;
    Public
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;

        Procedure Click; Override;

        Property DroppedDown: Boolean Read FDroppedDown Write SetDroppedDown;
    Published
        Property Action;
        Property AllowAllUp: Boolean Read FAllowAllUp Write SetAllowAllUp Default False;
        Property Anchors;
        Property BiDiMode;
        Property Caption;
        Property Constraints;
        Property CustomText: String Read GetCustomText Write SetCustomText;
        Property DefaultText: String Read GetDefaultText Write SetDefaultText;
        Property Down: Boolean Read FDown Write SetDown Default False;
        Property DropDownArrowColor: TColor Read FDropDownArrowColor Write SetDropDownArrowColor Default clBlack;
        Property DropDownWidth: Integer Read FDropDownWidth Write SetDropDownWidth Default 15;
        Property Enabled;
        Property Flat: Boolean Read FFlat Write SetFlat Default False;
        Property Font;
        Property Glyph: TBitmap Read GetGlyph Write SetGlyph;
        Property GroupIndex: Integer Read FGroupIndex Write SetGroupIndex Default 0;
        Property IndicatorBorder: TIndicatorBorder Read FIndicatorBorder Write SetIndicatorBorder Default ibFlat;
        Property Layout: TButtonLayout Read FLayout Write SetLayout Default blGlyphLeft;
        Property Margin: Integer Read FMargin Write SetMargin Default -1;
        Property NumGlyphs: TNumGlyphs Read GetNumGlyphs Write SetNumGlyphs Default 1;
        Property ParentBiDiMode;
        Property ParentFont;
        Property ParentShowHint;
        Property PopupSpacing: Integer Read GetPopupSpacing Write SetPopupSpacing;
        Property SelectionColor: TColor Read FSelectionColor Write SetSelectionColor Default clBlack;
        Property ShowHint;
        Property ShowSystemColors: Boolean Read GetShowSystemColors Write SetShowSystemColors;
        Property Spacing: Integer Read FSpacing Write SetSpacing Default 4;
        Property Transparent: Boolean Read FTransparent Write SetTransparent Default True;
        Property Visible;

        Property OnChange: TNotifyEvent Read FOnChange Write FOnChange;
        Property OnClick;
        Property OnDblClick;
        Property OnDefaultSelect: TNotifyEvent Read FOnDefaultSelect Write FOnDefaultSelect;
        Property OnDropChanged: TNotifyEvent Read FOnDropChanged Write FOnDropChanged;
        Property OnDropChanging: TDropChangingEvent Read FOnDropChanging Write FOnDropChanging;
        Property OnHint: THintEvent Read FOnHint Write FOnHint;
        Property OnMouseDown;
        Property OnMouseMove;
        Property OnMouseUp;
    End;

Implementation

{$IFDEF WIN32}
Uses
    ActnList, ImgList;
{$ENDIF}
{$IFDEF LINUX}
uses
  QActnList, QImgList, Types;
{$ENDIF}

Const
    DRAW_BUTTON_UP = 8208;
    DRAW_BUTTON_DOWN = 8720;

Type
    TColorEntry = Record
        Name: Pchar;
        Case Boolean Of
            True: (R, G, B, reserved: Byte);
            False: (Color: COLORREF);
    End;

Const DefaultColorCount = 40;
      // these colors are the same as used in Office 97/2000
    DefaultColors: Array[0..DefaultColorCount - 1] Of TColorEntry = (
        (Name: 'Black'; Color: $000000),
        (Name: 'Brown'; Color: $003399),
        (Name: 'Olive Green'; Color: $003333),
        (Name: 'Dark Green'; Color: $003300),
        (Name: 'Dark Teal'; Color: $663300),
        (Name: 'Dark blue'; Color: $800000),
        (Name: 'Indigo'; Color: $993333),
        (Name: 'Gray-80%'; Color: $333333),

        (Name: 'Dark Red'; Color: $000080),
        (Name: 'Orange'; Color: $0066FF),
        (Name: 'Dark Yellow'; Color: $008080),
        (Name: 'Green'; Color: $008000),
        (Name: 'Teal'; Color: $808000),
        (Name: 'Blue'; Color: $FF0000),
        (Name: 'Blue-Gray'; Color: $996666),
        (Name: 'Gray-50%'; Color: $808080),

        (Name: 'Red'; Color: $0000FF),
        (Name: 'Light Orange'; Color: $0099FF),
        (Name: 'Lime'; Color: $00CC99),
        (Name: 'Sea Green'; Color: $669933),
        (Name: 'Aqua'; Color: $CCCC33),
        (Name: 'Light Blue'; Color: $FF6633),
        (Name: 'Violet'; Color: $800080),
        (Name: 'Grey-40%'; Color: $969696),

        (Name: 'Pink'; Color: $FF00FF),
        (Name: 'Gold'; Color: $00CCFF),
        (Name: 'Yellow'; Color: $00FFFF),
        (Name: 'Bright Green'; Color: $00FF00),
        (Name: 'Turquoise'; Color: $FFFF00),
        (Name: 'Sky Blue'; Color: $FFCC00),
        (Name: 'Plum'; Color: $663399),
        (Name: 'Gray-25%'; Color: $C0C0C0),

        (Name: 'Rose'; Color: $CC99FF),
        (Name: 'Tan'; Color: $99CCFF),
        (Name: 'Light Yellow'; Color: $99FFFF),
        (Name: 'Light Green'; Color: $CCFFCC),
        (Name: 'Light Turquoise'; Color: $FFFFCC),
        (Name: 'Pale Blue'; Color: $FFCC99),
        (Name: 'Lavender'; Color: $FF99CC),
        (Name: 'White'; Color: $FFFFFF)
        );

    SysColorCount = 25;
    SysColors: Array[0..SysColorCount - 1] Of TColorEntry = (
        (Name: 'system color: scroll bar'; Color: COLORREF(clScrollBar)),
        (Name: 'system color: background'; Color: COLORREF(clBackground)),
        (Name: 'system color: active caption'; Color: COLORREF(clActiveCaption)),
        (Name: 'system color: inactive caption'; Color: COLORREF(clInactiveCaption)),
        (Name: 'system color: menu'; Color: COLORREF(clMenu)),
        (Name: 'system color: window'; Color: COLORREF(clWindow)),
        (Name: 'system color: window frame'; Color: COLORREF(clWindowFrame)),
        (Name: 'system color: menu text'; Color: COLORREF(clMenuText)),
        (Name: 'system color: window text'; Color: COLORREF(clWindowText)),
        (Name: 'system color: caption text'; Color: COLORREF(clCaptionText)),
        (Name: 'system color: active border'; Color: COLORREF(clActiveBorder)),
        (Name: 'system color: inactive border'; Color: COLORREF(clInactiveBorder)),
        (Name: 'system color: application workspace'; Color: COLORREF(clAppWorkSpace)),
        (Name: 'system color: highlight'; Color: COLORREF(clHighlight)),
        (Name: 'system color: highlight text'; Color: COLORREF(clHighlightText)),
        (Name: 'system color: button face'; Color: COLORREF(clBtnFace)),
        (Name: 'system color: button shadow'; Color: COLORREF(clBtnShadow)),
        (Name: 'system color: gray text'; Color: COLORREF(clGrayText)),
        (Name: 'system color: button text'; Color: COLORREF(clBtnText)),
        (Name: 'system color: inactive caption text'; Color: COLORREF(clInactiveCaptionText)),
        (Name: 'system color: button highlight'; Color: COLORREF(clBtnHighlight)),
        (Name: 'system color: 3D dark shadow'; Color: COLORREF(cl3DDkShadow)),
        (Name: 'system color: 3D light'; Color: COLORREF(cl3DLight)),
        (Name: 'system color: info text'; Color: COLORREF(clInfoText)),
        (Name: 'system color: info background'; Color: COLORREF(clInfoBk))
        );

Type
    TGlyphList = Class(TImageList)
    Private
        FUsed: TBits;
        FCount: Integer;
        Function AllocateIndex: Integer;
    Public
        Constructor CreateSize(AWidth, AHeight: Integer);
        Destructor Destroy; Override;

        Function AddMasked(Image: TBitmap; MaskColor: TColor): Integer;
        Procedure Delete(Index: Integer);
        Property Count: Integer Read FCount;
    End;

    TGlyphCache = Class
    Private
        FGlyphLists: TList;
    Public
        Constructor Create;
        Destructor Destroy; Override;

        Function GetList(AWidth, AHeight: Integer): TGlyphList;
        Procedure ReturnList(List: TGlyphList);
        Function Empty: Boolean;
    End;

    TButtonGlyph = Class
    Private
        FOriginal: TBitmap;
        FGlyphList: TGlyphList;
        FIndexes: Array[TButtonState] Of Integer;
        FTransparentColor: TColor;
        FNumGlyphs: TNumGlyphs;
        FOnChange: TNotifyEvent;
        Procedure GlyphChanged(Sender: TObject);
        Procedure SetGlyph(Value: TBitmap);
        Procedure SetNumGlyphs(Value: TNumGlyphs);
        Procedure Invalidate;
        Function CreateButtonGlyph(State: TButtonState): Integer;
        Procedure DrawButtonGlyph(Canvas: TCanvas; Const GlyphPos: TPoint;
            State: TButtonState; Transparent: Boolean);
        Procedure DrawButtonText(Canvas: TCanvas; Const Caption: String;
            TextBounds: TRect; State: TButtonState; BiDiFlags: Longint);
        Procedure CalcButtonLayout(Canvas: TCanvas; Const Client: TRect;
            Const Offset: TPoint; Const Caption: String; Layout: TButtonLayout;
            Margin, Spacing: Integer; Var GlyphPos: TPoint; Var TextBounds: TRect;
            Const DropDownWidth: Integer; BiDiFlags: Longint);
    Public
        Constructor Create;
        Destructor Destroy; Override;

        Function Draw(Canvas: TCanvas; Const Client: TRect; Const Offset: TPoint;
            Const Caption: String; Layout: TButtonLayout; Margin, Spacing: Integer;
            State: TButtonState; Transparent: Boolean;
            Const DropDownWidth: Integer; BiDiFlags: Longint): TRect;

        Property Glyph: TBitmap Read FOriginal Write SetGlyph;
        Property NumGlyphs: TNumGlyphs Read FNumGlyphs Write SetNumGlyphs;
        Property OnChange: TNotifyEvent Read FOnChange Write FOnChange;
    End;

    TCombEntry = Record
        Position: TPoint;
        Color: COLORREF;
    End;

    TCombArray = Array Of TCombEntry;

    TFloatPoint = Record
        X, Y: Extended;
    End;

    TRGB = Record
        Red, Green, Blue: Single;
    End;

    TSelectionMode = (smNone, smColor, smBW, smRamp);

    TColorPopup = Class(TWinControl)
    Private
        FDefaultText,
        FCustomText: String;
        FCurrentColor: TCOlor;
        FCanvas: TCanvas;
        FMargin,
        FSpacing,
        FColumnCount,
        FRowCount,
        FSysRowCount,
        FBoxSize: Integer;
        FSelectedIndex,
        FHoverIndex: Integer;
        FWindowRect,
        FCustomTextRect,
        FDefaultTextRect,
        FColorCombRect,
        FBWCombRect,
        FSliderRect,
        FCustomColorRect: TRect;
        FShowSysColors: Boolean;

    // custom color picking
        FCombSize,
        FLevels: Integer;
        FBWCombs,
        FColorCombs: TCombArray;
        FCombCorners: Array[0..5] Of TFloatPoint;
        FCenterColor: TRGB;
        FCenterIntensity: Single; // scale factor for the center color
        FCustomIndex,             // If FSelectedIndex contains CustomCell then this index shows
                              // which index in the custom area has been selected.
                              // Positive values indicate the color comb and negativ values
                              // indicate the B&W combs (complement). This value is offset with
                              // 1 to use index 0 to show no selection.
        FRadius: Integer;
        FSelectionMode: TSelectionMode; // indicates where the user has clicked
                                    // with the mouse to restrict draw selection
        Procedure SelectColor(Color: TColor);
        Procedure ChangeHoverSelection(Index: Integer);
        Procedure DrawCell(Index: Integer);
        Procedure InvalidateCell(Index: Integer);
        Procedure EndSelection(Cancel: Boolean);
        Function GetCellRect(Index: Integer; Var Rect: TRect): Boolean;
        Function GetColumn(Index: Integer): Integer;
        Function GetIndex(Row, Col: Integer): Integer;
        Function GetRow(Index: Integer): Integer;
        Procedure Initialise;
        Procedure AdjustWindow;
        Procedure SetSpacing(Value: Integer);
        Procedure SetSelectedColor(Const Value: TColor);
        Procedure CMHintShow(Var Message: TMessage); Message CM_HINTSHOW;
        Procedure CNKeyDown(Var Message: TWMKeyDown); Message CN_KEYDOWN;
        Procedure CNSysKeyDown(Var Message: TWMChar); Message CN_SYSKEYDOWN;
        Procedure WMActivateApp(Var Message: TWMActivateApp); Message WM_ACTIVATEAPP;
        Procedure WMLButtonDown(Var Message: TWMLButtonDown); Message WM_LBUTTONDOWN;
        Procedure WMKillFocus(Var Message: TWMKillFocus); Message WM_KILLFOCUS;
        Procedure WMLButtonUp(Var Message: TWMLButtonUp); Message WM_LBUTTONUP;
        Procedure WMMouseMove(Var Message: TWMMouseMove); Message WM_MOUSEMOVE;
        Procedure WMPaint(Var Message: TWMPaint); Message WM_PAINT;
        Function SelectionFromPoint(P: TPoint): Integer;
        Procedure DrawCombControls;
        Procedure DrawComb(Canvas: TCanvas; X, Y, Size: Integer);
        Function HandleBWArea(Const Message: TWMMouse): Boolean;
        Function HandleColorComb(Const Message: TWMMouse): Boolean;
        Function HandleSlider(Const Message: TWMMouse): Boolean;
        Function PtInComb(Comb: TCombEntry; P: TPoint; Scale: Integer): Boolean;
        Procedure HandleCustomColors(Var Message: TWMMouse);
        Function GetHint(Cell: Integer): String;
        Function FindBWArea(X, Y: Integer): Integer;
        Function FindColorArea(X, Y: Integer): Integer;
        Procedure DrawSeparator(Left, Top, Right: Integer);
        Procedure ChangeSelection(NewSelection: Integer);
    Protected
        Procedure CalculateCombLayout;
        Procedure CreateParams(Var Params: TCreateParams); Override;
        Procedure CreateWnd; Override;
        Procedure ShowPopupAligned;
    Public
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;

        Property SelectedColor: TColor Read FCurrentColor Write SetSelectedColor;
        Property Spacing: Integer Read FSpacing Write SetSpacing;
    End;

Const DefCenterColor: TRGB = (Red: 1; Green: 1; Blue: 1);  // White
    DefColors: Array[0..5] Of TRGB = (
        (Red: 1; Green: 0; Blue: 1),     // Magenta
        (Red: 1; Green: 0; Blue: 0),     // Red
        (Red: 1; Green: 1; Blue: 0),     // Yellow
        (Red: 0; Green: 1; Blue: 0),     // Green
        (Red: 0; Green: 1; Blue: 1),     // Cyan
        (Red: 0; Green: 0; Blue: 1)       // Blue
        );
    DefCenter: TFloatPoint = (X: 0; Y: 0);

Var GlyphCache: TGlyphCache;
    ButtonCount: Integer;

//----------------- TGlyphList ------------------------------------------------

Constructor TGlyphList.CreateSize(AWidth, AHeight: Integer);

Begin
    Inherited CreateSize(AWidth, AHeight);
    FUsed := TBits.Create;
End;

//-----------------------------------------------------------------------------

Destructor TGlyphList.Destroy;

Begin
    If Assigned(FUsed) Then
        FUsed.Free;
    Inherited Destroy;
End;

//-----------------------------------------------------------------------------

Function TGlyphList.AllocateIndex: Integer;

Begin
    Result := FUsed.OpenBit;
    If Result >= FUsed.Size Then
    Begin
        Result := Inherited Add(Nil, Nil);
        FUsed.Size := Result + 1;
    End;
    FUsed[Result] := True;
End;

//-----------------------------------------------------------------------------

Function TGlyphList.AddMasked(Image: TBitmap; MaskColor: TColor): Integer;

Begin
    Result := AllocateIndex;
    ReplaceMasked(Result, Image, MaskColor);
    Inc(FCount);
End;

//-----------------------------------------------------------------------------

Procedure TGlyphList.Delete(Index: Integer);

Begin
    If FUsed[Index] Then
    Begin
        Dec(FCount);
        FUsed[Index] := False;
    End;
End;

//----------------- TGlyphCache -----------------------------------------------

Constructor TGlyphCache.Create;

Begin
    Inherited Create;
    FGlyphLists := TList.Create;
End;

//-----------------------------------------------------------------------------

Destructor TGlyphCache.Destroy;

Begin
    If Assigned(FGlyphLists) Then
        FGlyphLists.Free;
    Inherited Destroy;
End;

//-----------------------------------------------------------------------------

Function TGlyphCache.GetList(AWidth, AHeight: Integer): TGlyphList;

Var I: Integer;

Begin
    For I := FGlyphLists.Count - 1 Downto 0 Do
    Begin
        Result := FGlyphLists[I];
        With Result Do
            If (AWidth = Width) And (AHeight = Height) Then
                Exit;
    End;
    Result := TGlyphList.CreateSize(AWidth, AHeight);
    FGlyphLists.Add(Result);
End;

//-----------------------------------------------------------------------------

Procedure TGlyphCache.ReturnList(List: TGlyphList);

Begin
    If List = Nil Then
        Exit;
    If List.Count = 0 Then
    Begin
        FGlyphLists.Remove(List);
        List.Free;
    End;
End;

//-----------------------------------------------------------------------------

Function TGlyphCache.Empty: Boolean;

Begin
    Result := FGlyphLists.Count = 0;
End;

//----------------- TButtonGlyph ----------------------------------------------

Constructor TButtonGlyph.Create;

Var I: TButtonState;

Begin
    Inherited Create;
    FOriginal := TBitmap.Create;
    FOriginal.OnChange := GlyphChanged;
    FTransparentColor := clOlive;
    FNumGlyphs := 1;
    For I := Low(I) To High(I) Do
        FIndexes[I] := -1;
    If GlyphCache = Nil Then
        GlyphCache := TGlyphCache.Create;
End;

//-----------------------------------------------------------------------------

Destructor TButtonGlyph.Destroy;

Begin
    If Assigned(FOriginal) Then
        FOriginal.Free;
    Invalidate;
    If Assigned(GlyphCache) And GlyphCache.Empty Then
    Begin
        GlyphCache.Free;
        GlyphCache := Nil;
    End;
    Inherited Destroy;
End;

//-----------------------------------------------------------------------------

Procedure TButtonGlyph.Invalidate;

Var I: TButtonState;

Begin
    For I := Low(I) To High(I) Do
    Begin
        If FIndexes[I] <> -1 Then
            FGlyphList.Delete(FIndexes[I]);
        FIndexes[I] := -1;
    End;
    GlyphCache.ReturnList(FGlyphList);
    FGlyphList := Nil;
End;

//-----------------------------------------------------------------------------

Procedure TButtonGlyph.GlyphChanged(Sender: TObject);

Begin
    If Sender = FOriginal Then
    Begin
        FTransparentColor := FOriginal.TransparentColor;
        Invalidate;
        If Assigned(FOnChange) Then
            FOnChange(Self);
    End;
End;

//-----------------------------------------------------------------------------

Procedure TButtonGlyph.SetGlyph(Value: TBitmap);

Var Glyphs: Integer;

Begin
    Invalidate;
    FOriginal.Assign(Value);
    If (Value <> Nil) And (Value.Height > 0) Then
    Begin
        FTransparentColor := Value.TransparentColor;
        If Value.Width Mod Value.Height = 0 Then
        Begin
            Glyphs := Value.Width Div Value.Height;
            If Glyphs > 4 Then
                Glyphs := 1;
            SetNumGlyphs(Glyphs);
        End;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TButtonGlyph.SetNumGlyphs(Value: TNumGlyphs);

Begin
    If (Value <> FNumGlyphs) And (Value > 0) Then
    Begin
        Invalidate;
        FNumGlyphs := Value;
        GlyphChanged(Glyph);
    End;
End;

//-----------------------------------------------------------------------------

Function TButtonGlyph.CreateButtonGlyph(State: TButtonState): Integer;

Const ROP_DSPDxax = $00E20746;

Var TmpImage, DDB, MonoBmp: TBitmap;
    IWidth, IHeight: Integer;
    IRect, ORect: TRect;
    I: TButtonState;
    DestDC: HDC;

Begin
    If (State = bsDown) And (NumGlyphs < 3) Then
        State := bsUp;
    Result := FIndexes[State];
    If Result <> -1 Then
        Exit;
    If (FOriginal.Width Or FOriginal.Height) = 0 Then
        Exit;

    IWidth := FOriginal.Width Div FNumGlyphs;
    IHeight := FOriginal.Height;
    If FGlyphList = Nil Then
    Begin
        If GlyphCache = Nil Then
            GlyphCache := TGlyphCache.Create;
        FGlyphList := GlyphCache.GetList(IWidth, IHeight);
    End;
    TmpImage := TBitmap.Create;
    Try
        TmpImage.Width := IWidth;
        TmpImage.Height := IHeight;
        IRect := Rect(0, 0, IWidth, IHeight);
        TmpImage.Canvas.Brush.Color := clBtnFace;
        TmpImage.Palette := CopyPalette(FOriginal.Palette);
        I := State;
        If Ord(I) >= NumGlyphs Then
            I := bsUp;
        ORect := Rect(Ord(I) * IWidth, 0, (Ord(I) + 1) * IWidth, IHeight);
        Case State Of
            bsUp, bsDown,
            bsExclusive:
            Begin
                TmpImage.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
                If FOriginal.TransparentMode = tmFixed Then
                    FIndexes[State] := FGlyphList.AddMasked(TmpImage, FTransparentColor)
                Else
                    FIndexes[State] := FGlyphList.AddMasked(TmpImage, clDefault);
            End;
            bsDisabled:
            Begin
                MonoBmp := Nil;
                DDB := Nil;
                Try
                    MonoBmp := TBitmap.Create;
                    DDB := TBitmap.Create;
                    DDB.Assign(FOriginal);
                    DDB.HandleType := bmDDB;
                    If NumGlyphs > 1 Then
                        With TmpImage.Canvas Do
                        Begin
              // Change white & gray to clBtnHighlight and clBtnShadow
                            CopyRect(IRect, DDB.Canvas, ORect);
                            MonoBmp.Monochrome := True;
                            MonoBmp.Width := IWidth;
                            MonoBmp.Height := IHeight;

              // Convert white to clBtnHighlight
                            DDB.Canvas.Brush.Color := clWhite;
                            MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
                            Brush.Color := clBtnHighlight;
                            DestDC := Handle;
                            SetTextColor(DestDC, clBlack);
                            SetBkColor(DestDC, clWhite);
                            BitBlt(DestDC, 0, 0, IWidth, IHeight, MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);

              // Convert gray to clBtnShadow
                            DDB.Canvas.Brush.Color := clGray;
                            MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
                            Brush.Color := clBtnShadow;
                            DestDC := Handle;
                            SetTextColor(DestDC, clBlack);
                            SetBkColor(DestDC, clWhite);
                            BitBlt(DestDC, 0, 0, IWidth, IHeight, MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);

              // Convert transparent color to clBtnFace
                            DDB.Canvas.Brush.Color := ColorToRGB(FTransparentColor);
                            MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
                            Brush.Color := clBtnFace;
                            DestDC := Handle;
                            SetTextColor(DestDC, clBlack);
                            SetBkColor(DestDC, clWhite);
                            BitBlt(DestDC, 0, 0, IWidth, IHeight, MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
                        End
                    Else
                    Begin
              // Create a disabled version
                        With MonoBmp Do
                        Begin
                            Assign(FOriginal);
                            HandleType := bmDDB;
                            Canvas.Brush.Color := clBlack;
                            Width := IWidth;
                            If Monochrome Then
                            Begin
                                Canvas.Font.Color := clWhite;
                                Monochrome := False;
                                Canvas.Brush.Color := clWhite;
                            End;
                            Monochrome := True;
                        End;

                        With TmpImage.Canvas Do
                        Begin
                            Brush.Color := clBtnFace;
                            FillRect(IRect);
                            Brush.Color := clBtnHighlight;
                            SetTextColor(Handle, clBlack);
                            SetBkColor(Handle, clWhite);
                            BitBlt(Handle, 1, 1, IWidth, IHeight, MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
                            Brush.Color := clBtnShadow;
                            SetTextColor(Handle, clBlack);
                            SetBkColor(Handle, clWhite);
                            BitBlt(Handle, 0, 0, IWidth, IHeight, MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
                        End;
                    End;
                Finally
                    DDB.Free;
                    MonoBmp.Free;
                End;
                FIndexes[State] := FGlyphList.AddMasked(TmpImage, clDefault);
            End;
        End;
    Finally
        TmpImage.Free;
    End;
    Result := FIndexes[State];
    FOriginal.Dormant;
End;

//-----------------------------------------------------------------------------

Procedure TButtonGlyph.DrawButtonGlyph(Canvas: TCanvas; Const GlyphPos: TPoint;
    State: TButtonState; Transparent: Boolean);

Var Index: Integer;

Begin
    If Assigned(FOriginal) Then
    Begin
        If (FOriginal.Width = 0) Or (FOriginal.Height = 0) Then
            Exit;

        Index := CreateButtonGlyph(State);

        With GlyphPos Do
            If Transparent Or (State = bsExclusive) Then
                ImageList_DrawEx(FGlyphList.Handle, Index, Canvas.Handle, X, Y, 0, 0, clNone, clNone, ILD_Transparent)
            Else
                ImageList_DrawEx(FGlyphList.Handle, Index, Canvas.Handle, X, Y, 0, 0, ColorToRGB(clBtnFace), clNone, ILD_Normal);
    End;
End;

//-----------------------------------------------------------------------------

Procedure TButtonGlyph.DrawButtonText(Canvas: TCanvas; Const Caption: String;
    TextBounds: TRect; State: TButtonState;
    BiDiFlags: Longint);

Begin
    With Canvas Do
    Begin
        Brush.Style := bsClear;
        If State = bsDisabled Then
        Begin
            OffsetRect(TextBounds, 1, 1);
            Font.Color := clBtnHighlight;
            DrawText(Handle, Pchar(Caption), Length(Caption), TextBounds, DT_CENTER Or DT_VCENTER Or BiDiFlags);
            OffsetRect(TextBounds, -1, -1);
            Font.Color := clBtnShadow;
            DrawText(Handle, Pchar(Caption), Length(Caption), TextBounds, DT_CENTER Or DT_VCENTER Or BiDiFlags);
        End
        Else
            DrawText(Handle, Pchar(Caption), Length(Caption), TextBounds, DT_CENTER Or DT_VCENTER Or BiDiFlags);
    End;
End;

//-----------------------------------------------------------------------------

Procedure TButtonGlyph.CalcButtonLayout(Canvas: TCanvas; Const Client: TRect;
    Const Offset: TPoint; Const Caption: String; Layout: TButtonLayout; Margin,
    Spacing: Integer; Var GlyphPos: TPoint; Var TextBounds: TRect;
    Const DropDownWidth: Integer; BiDiFlags: Longint);

Var TextPos: TPoint;
    ClientSize,
    GlyphSize,
    TextSize: TPoint;
    TotalSize: TPoint;

Begin
    If (BiDiFlags And DT_RIGHT) = DT_RIGHT Then
        If Layout = blGlyphLeft Then
            Layout := blGlyphRight
        Else
        If Layout = blGlyphRight Then
            Layout := blGlyphLeft;

  // calculate the item sizes
    ClientSize := Point(Client.Right - Client.Left - DropDownWidth, Client.Bottom - Client.Top);

    If FOriginal <> Nil Then
        GlyphSize := Point(FOriginal.Width Div FNumGlyphs, FOriginal.Height)
    Else GlyphSize := Point(0, 0);

    If Length(Caption) > 0 Then
    Begin
        TextBounds := Rect(0, 0, Client.Right - Client.Left, 0);
        DrawText(Canvas.Handle, Pchar(Caption), Length(Caption), TextBounds, DT_CALCRECT Or BiDiFlags);
        TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom - TextBounds.Top);
    End
    Else
    Begin
        TextBounds := Rect(0, 0, 0, 0);
        TextSize := Point(0, 0);
    End;

  // If the layout has the glyph on the right or the left, then both the
  // text and the glyph are centered vertically.  If the glyph is on the top
  // or the bottom, then both the text and the glyph are centered horizontally.
    If Layout In [blGlyphLeft, blGlyphRight] Then
    Begin
        GlyphPos.Y := (ClientSize.Y - GlyphSize.Y + 1) Div 2;
        TextPos.Y := (ClientSize.Y - TextSize.Y + 1) Div 2;
    End
    Else
    Begin
        GlyphPos.X := (ClientSize.X - GlyphSize.X + 1) Div 2;
        TextPos.X := (ClientSize.X - TextSize.X + 1) Div 2;
    End;

  // if there is no text or no bitmap, then Spacing is irrelevant
    If (TextSize.X = 0) Or (GlyphSize.X = 0) Then
        Spacing := 0;

  // adjust Margin and Spacing
    If Margin = -1 Then
    Begin
        If Spacing = -1 Then
        Begin
            TotalSize := Point(GlyphSize.X + TextSize.X, GlyphSize.Y + TextSize.Y);
            If Layout In [blGlyphLeft, blGlyphRight] Then
                Margin := (ClientSize.X - TotalSize.X) Div 3
            Else Margin := (ClientSize.Y - TotalSize.Y) Div 3;
            Spacing := Margin;
        End
        Else
        Begin
            TotalSize := Point(GlyphSize.X + Spacing + TextSize.X, GlyphSize.Y + Spacing + TextSize.Y);
            If Layout In [blGlyphLeft, blGlyphRight] Then
                Margin := (ClientSize.X - TotalSize.X + 1) Div 2
            Else Margin := (ClientSize.Y - TotalSize.Y + 1) Div 2;
        End;
    End
    Else
    Begin
        If Spacing = -1 Then
        Begin
            TotalSize := Point(ClientSize.X - (Margin + GlyphSize.X), ClientSize.Y - (Margin + GlyphSize.Y));
            If Layout In [blGlyphLeft, blGlyphRight] Then
                Spacing := (TotalSize.X - TextSize.X) Div 2
            Else Spacing := (TotalSize.Y - TextSize.Y) Div 2;
        End;
    End;

    Case Layout Of
        blGlyphLeft:
        Begin
            GlyphPos.X := Margin;
            TextPos.X := GlyphPos.X + GlyphSize.X + Spacing;
        End;
        blGlyphRight:
        Begin
            GlyphPos.X := ClientSize.X - Margin - GlyphSize.X;
            TextPos.X := GlyphPos.X - Spacing - TextSize.X;
        End;
        blGlyphTop:
        Begin
            GlyphPos.Y := Margin;
            TextPos.Y := GlyphPos.Y + GlyphSize.Y + Spacing;
        End;
        blGlyphBottom:
        Begin
            GlyphPos.Y := ClientSize.Y - Margin - GlyphSize.Y;
            TextPos.Y := GlyphPos.Y - Spacing - TextSize.Y;
        End;
    End;

  // fixup the result variables
    With GlyphPos Do
    Begin
        Inc(X, Client.Left + Offset.X);
        Inc(Y, Client.Top + Offset.Y);
    End;
    OffsetRect(TextBounds, TextPos.X + Client.Left + Offset.X, TextPos.Y + Client.Top + Offset.X);
End;

//-----------------------------------------------------------------------------

Function TButtonGlyph.Draw(Canvas: TCanvas; Const Client: TRect;
    Const Offset: TPoint; Const Caption: String; Layout: TButtonLayout;
    Margin, Spacing: Integer; State: TButtonState; Transparent: Boolean;
    Const DropDownWidth: Integer; BiDiFlags: Longint): TRect;

Var GlyphPos: TPoint;
    R: TRect;

Begin
    CalcButtonLayout(Canvas, Client, Offset, Caption, Layout, Margin, Spacing, GlyphPos, R, DropDownWidth, BidiFlags);
    DrawButtonGlyph(Canvas, GlyphPos, State, Transparent);
    DrawButtonText(Canvas, Caption, R, State, BiDiFlags);

  // return a rectangle wherein the color indicator can be drawn
    If Caption = '' Then
    Begin
        Result := Client;
        Dec(Result.Right, DropDownWidth + 2);
        InflateRect(Result, -2, -2);

    // consider glyph if no text is to be painted (else it is already taken into account)
        If Assigned(FOriginal) And (FOriginal.Width > 0) And (FOriginal.Height > 0) Then
            Case Layout Of
                blGlyphLeft:
                Begin
                    Result.Left := GlyphPos.X + FOriginal.Width + 4;
                    Result.Top := GlyphPos.Y;
                    Result.Bottom := GlyphPos.Y + FOriginal.Height;
                End;
                blGlyphRight:
                Begin
                    Result.Right := GlyphPos.X - 4;
                    Result.Top := GlyphPos.Y;
                    Result.Bottom := GlyphPos.Y + FOriginal.Height;
                End;
                blGlyphTop:
                    Result.Top := GlyphPos.Y + FOriginal.Height + 4;
                blGlyphBottom:
                    Result.Bottom := GlyphPos.Y - 4;
            End;
    End
    Else
    Begin
    // consider caption
        Result := Rect(R.Left, R.Bottom, R.Right, R.Bottom + 6);
        If (Result.Bottom + 2) > Client.Bottom Then
            Result.Bottom := Client.Bottom - 2;
    End;
End;

//----------------- TColorPopup ------------------------------------------------

Constructor TColorPopup.Create(AOwner: TComponent);

Begin
    Inherited;
    ControlStyle := ControlStyle - [csAcceptsControls] + [csOpaque];

    FCanvas := TCanvas.Create;
    Color := clBtnFace;
    ShowHint := True;

    Initialise;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.Initialise;

Var I: Integer;

Begin
    FBoxSize := 18;
    FMargin := GetSystemMetrics(SM_CXEDGE);
    FSpacing := 8;
    FHoverIndex := NoCell;
    FSelectedIndex := NoCell;

  // init comb caclulation
    For I := 0 To 5 Do
    Begin
        FCombCorners[I].X := 0.5 * cos(Pi * (90 - I * 60) / 180);
        FCombCorners[I].Y := 0.5 * sin(Pi * (90 - I * 60) / 180);
    End;
    FRadius := 66;
    FLevels := 7;
    FCombSize := Trunc(FRadius / (FLevels - 1));
    FCenterColor := DefCenterColor;
    FCenterIntensity := 1;
End;

//------------------------------------------------------------------------------

Destructor TColorPopup.Destroy;

Begin
    FBWCombs := Nil;
    FColorCombs := Nil;
    If Assigned(FCanvas) Then
        FCanvas.Free;
    Inherited;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.CNSysKeyDown(Var Message: TWMKeyDown);

// handles accelerator keys

Begin
    With Message Do
    Begin
        If (Length(FDefaultText) > 0) And IsAccel(CharCode, FDefaultText) Then
        Begin
            ChangeSelection(DefaultCell);
            EndSelection(False);
            Result := 1;
        End
        Else
        If (FSelectedIndex <> CustomCell) And
            (Length(FCustomText) > 0) And
            IsAccel(CharCode, FCustomText) Then
        Begin
            ChangeSelection(CustomCell);
            Result := 1;
        End
        Else Inherited;
    End;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.CNKeyDown(Var Message: TWMKeyDown);

// if an arrow key is pressed, then move the selection

Var Row,
    MaxRow,
    Column: Integer;

Begin
    Inherited;

    If FHoverIndex <> NoCell Then
    Begin
        Row := GetRow(FHoverIndex);
        Column := GetColumn(FHoverIndex);
    End
    Else
    Begin
        Row := GetRow(FSelectedIndex);
        Column := GetColumn(FSelectedIndex);
    End;

    If FShowSysColors Then
        MaxRow := DefaultColorCount + SysColorCount - 1
    Else MaxRow := DefaultColorCount - 1;

    Case Message.CharCode Of
        VK_DOWN:
        Begin
            If Row = DefaultCell Then
            Begin
                Row := 0;
                Column := 0;
            End
            Else
            If Row = CustomCell Then
            Begin
                If Length(FDefaultText) > 0 Then
                Begin
                    Row := DefaultCell;
                    Column := Row;
                End
                Else
                Begin
                    Row := 0;
                    Column := 0;
                End;
            End
            Else
            Begin
                Inc(Row);
                If GetIndex(Row, Column) < 0 Then
                Begin
                    If Length(FCustomText) > 0 Then
                    Begin
                        Row := CustomCell;
                        Column := Row;
                    End
                    Else
                    Begin
                        If Length(FDefaultText) > 0 Then
                        Begin
                            Row := DefaultCell;
                            Column := Row;
                        End
                        Else
                        Begin
                            Row := 0;
                            Column := 0;
                        End;
                    End;
                End;
            End;
            ChangeHoverSelection(GetIndex(Row, Column));
            Message.Result := 1;
        End;

        VK_UP:
        Begin
            If Row = DefaultCell Then
            Begin
                If Length(FCustomText) > 0 Then
                Begin
                    Row := CustomCell;
                    Column := Row;
                End
                Else
                Begin
                    Row := GetRow(MaxRow);
                    Column := GetColumn(MaxRow);
                End;
            End
            Else
            If Row = CustomCell Then
            Begin
                Row := GetRow(MaxRow);
                Column := GetColumn(MaxRow);
            End
            Else
            If Row > 0 Then
                Dec(Row)
            Else
            Begin
                If Length(FDefaultText) > 0 Then
                Begin
                    Row := DefaultCell;
                    Column := Row;
                End
                Else
                If Length(FCustomText) > 0 Then
                Begin
                    Row := CustomCell;
                    Column := Row;
                End
                Else
                Begin
                    Row := GetRow(MaxRow);
                    Column := GetColumn(MaxRow);
                End;
            End;
            ChangeHoverSelection(GetIndex(Row, Column));
            Message.Result := 1;
        End;

        VK_RIGHT:
        Begin
            If Row = DefaultCell Then
            Begin
                Row := 0;
                Column := 0;
            End
            Else
            If Row = CustomCell Then
            Begin
                If Length(FDefaultText) > 0 Then
                Begin
                    Row := DefaultCell;
                    Column := Row;
                End
                Else
                Begin
                    Row := 0;
                    Column := 0;
                End;
            End
            Else
            If Column < FColumnCount - 1 Then
                Inc(Column)
            Else
            Begin
                Column := 0;
                Inc(Row);
            End;

            If GetIndex(Row, Column) = NoCell Then
            Begin
                If Length(FCustomText) > 0 Then
                Begin
                    Row := CustomCell;
                    Column := Row;
                End
                Else
                If Length(FDefaultText) > 0 Then
                Begin
                    Row := DefaultCell;
                    Column := Row;
                End
                Else
                Begin
                    Row := 0;
                    Column := 0;
                End;
            End;
            ChangeHoverSelection(GetIndex(row, Column));
            Message.Result := 1;
        End;

        VK_LEFT:
        Begin
            If Row = DefaultCell Then
            Begin
                If Length(FCustomText) > 0 Then
                Begin
                    Row := CustomCell;
                    Column := Row;
                End
                Else
                Begin
                    Row := GetRow(MaxRow);
                    Column := GetColumn(MaxRow);
                End;
            End
            Else
            If Row = CustomCell Then
            Begin
                Row := GetRow(MaxRow);
                Column := GetColumn(MaxRow);
            End
            Else
            If Column > 0 Then
                Dec(Column)
            Else
            Begin
                If Row > 0 Then
                Begin
                    Dec(Row);
                    Column := FColumnCount - 1;
                End
                Else
                Begin
                    If Length(FDefaultText) > 0 Then
                    Begin
                        Row := DefaultCell;
                        Column := Row;
                    End
                    Else
                    If Length(FCustomText) > 0 Then
                    Begin
                        Row := CustomCell;
                        Column := Row;
                    End
                    Else
                    Begin
                        Row := GetRow(MaxRow);
                        Column := GetColumn(MaxRow);
                    End;
                End;
            End;
            ChangeHoverSelection(GetIndex(Row, Column));
            Message.Result := 1;
        End;

        VK_ESCAPE:
        Begin
            EndSelection(True);
            Message.Result := 1;
        End;

        VK_RETURN,
        VK_SPACE:
        Begin
        // this case can only occur if there was no click on the window
        // hence the hover index is the new color
            FSelectedIndex := FHoverIndex;
            EndSelection(False);
            Message.Result := 1;
        End;
    End;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.DrawSeparator(Left, Top, Right: Integer);

Var R: TRect;

Begin
    R := Rect(Left, Top, Right, Top);
    DrawEdge(FCanvas.Handle, R, EDGE_ETCHED, BF_TOP);
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.DrawCell(Index: Integer);

Var R, MarkRect: TRect;
    CellColor: TColor;

Begin
  // for the custom text area
    If (Length(FCustomText) > 0) And (Index = CustomCell) Then
    Begin
    // the extent of the actual text button
        R := FCustomTextRect;

    // fill background
        FCanvas.Brush.Color := clBtnFace;
        FCanvas.FillRect(R);

        With FCustomTextRect Do
            DrawSeparator(Left, Top - 2 * FMargin, Right);

        InflateRect(R, -1, 0);

    // fill background
        If (FSelectedIndex = Index) And (FHoverIndex <> Index) Then
            FCanvas.Brush.Color := clBtnHighlight
        Else FCanvas.Brush.Color := clBtnFace;

        FCanvas.FillRect(R);
    // draw button
        If (FSelectedIndex = Index) Or
            ((FHoverIndex = Index) And (csLButtonDown In ControlState)) Then
            DrawEdge(FCanvas.Handle, R, BDR_SUNKENOUTER, BF_RECT)
        Else
        If FHoverIndex = Index Then
            DrawEdge(FCanvas.Handle, R, BDR_RAISEDINNER, BF_RECT);

    // draw custom text
        DrawText(FCanvas.Handle, Pchar(FCustomText), Length(FCustomText), R, DT_CENTER Or DT_VCENTER Or DT_SINGLELINE);

    // draw preview color rectangle
        If FCustomIndex = 0 Then
        Begin
            FCanvas.Brush.Color := clBtnShadow;
            FCanvas.FrameRect(FCustomColorRect);
        End
        Else
        Begin
            FCanvas.Pen.Color := clGray;
            If FCustomIndex > 0 Then
                FCanvas.Brush.Color := FColorCombs[FCustomIndex - 1].Color
            Else FCanvas.Brush.Color := FBWCombs[-(FCustomIndex + 1)].Color;
            With FCustomColorRect Do
                FCanvas.Rectangle(Left, Top, Right, Bottom);
        End;
    End
    Else
    // for the default text area
    If (Length(FDefaultText) > 0) And (Index = DefaultCell) Then
    Begin
        R := FDefaultTextRect;

      // Fill background
        FCanvas.Brush.Color := clBtnFace;
        FCanvas.FillRect(R);

        InflateRect(R, -1, -1);

      // fill background
        If (FSelectedIndex = Index) And (FHoverIndex <> Index) Then
            FCanvas.Brush.Color := clBtnHighlight
        Else FCanvas.Brush.Color := clBtnFace;

        FCanvas.FillRect(R);
      // draw button
        If (FSelectedIndex = Index) Or
            ((FHoverIndex = Index) And (csLButtonDown In ControlState)) Then
            DrawEdge(FCanvas.Handle, R, BDR_SUNKENOUTER, BF_RECT)
        Else
        If FHoverIndex = Index Then
            DrawEdge(FCanvas.Handle, R, BDR_RAISEDINNER, BF_RECT);

      // draw small rectangle
        With MarkRect Do
        Begin
            MarkRect := R;
            InflateRect(MarkRect, -FMargin - 1, -FMargin - 1);
            FCanvas.Brush.Color := clBtnShadow;
            FCanvas.FrameRect(MarkRect);
        End;

      // draw default text
        SetBkMode(FCanvas.Handle, TRANSPARENT);
        DrawText(FCanvas.Handle, Pchar(FDefaultText), Length(FDefaultText), R, DT_CENTER Or DT_VCENTER Or DT_SINGLELINE);
    End
    Else
    Begin
        If GetCellRect(Index, R) Then
        Begin
            If Index < DefaultColorCount Then
                CellColor := TColor(DefaultColors[Index].Color)
            Else CellColor := TColor(SysColors[Index - DefaultColorCount].Color);
            FCanvas.Pen.Color := clGray;
        // fill background
            If (FSelectedIndex = Index) And (FHoverIndex <> Index) Then
                FCanvas.Brush.Color := clBtnHighlight
            Else FCanvas.Brush.Color := clBtnFace;
            FCanvas.FillRect(R);

        // draw button
            If (FSelectedIndex = Index) Or
                ((FHoverIndex = Index) And (csLButtonDown In ControlState)) Then
                DrawEdge(FCanvas.Handle, R, BDR_SUNKENOUTER, BF_RECT)
            Else
            If FHoverIndex = Index Then
                DrawEdge(FCanvas.Handle, R, BDR_RAISEDINNER, BF_RECT);

            FCanvas.Brush.Color := CellColor;

        // draw the cell colour
            InflateRect(R, -(FMargin + 1), -(FMargin + 1));
            FCanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
        End;
    End;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.DrawComb(Canvas: TCanvas; X, Y: Integer; Size: Integer);

// draws one single comb at position X, Y and with size Size
// fill color must already be set on call

Var I: Integer;
    P: Array[0..5] Of TPoint;

Begin
    For I := 0 To 5 Do
    Begin
        P[I].X := Round(FCombCorners[I].X * Size + X);
        P[I].Y := Round(FCombCorners[I].Y * Size + Y);
    End;
    Canvas.Polygon(P);
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.DrawCombControls;

Var I, Index: Integer;
    XOffs, YOffs,
    Count: Integer;
    dColor: Single;
    OffScreen: TBitmap;
    {$ifdef DEBUG}
      R: TRect;
    {$endif}

Begin
  // to make the painting (and selecting) flicker free we use an offscreen
  // bitmap here
    OffScreen := TBitmap.Create;
    Try
        OffScreen.Width := Width;
        OffScreen.Height := FColorCombRect.Bottom - FColorCombRect.Top +
            FBWCombRect.Bottom - FBWCombRect.Top + 2 * FMargin;

        With OffScreen.Canvas Do
        Begin
            Brush.Color := clBtnFace;
            FillRect(ClipRect);
            Pen.Style := psClear;
      // draw color comb from FColorCombs array
            XOffs := FRadius + FColorCombRect.Left;
            YOffs := FRadius;

      // draw the combs
            For I := 0 To High(FColorCombs) Do
            Begin
                Brush.Color := FColorCombs[I].Color;
                DrawComb(OffScreen.Canvas, FColorCombs[I].Position.X + XOffs, FColorCombs[I].Position.Y + YOffs, FCombSize);
            End;

      // mark selected comb
            If FCustomIndex > 0 Then
            Begin
                Index := FCustomIndex - 1;
                Pen.Style := psSolid;
                Pen.Mode := pmXOR;
                Pen.Color := clWhite;
                Pen.Width := 2;
                Brush.Style := bsClear;
                DrawComb(OffScreen.Canvas, FColorCombs[Index].Position.X + XOffs, FColorCombs[Index].Position.Y + YOffs, FCombSize);
                Pen.Style := psClear;
                Pen.Mode := pmCopy;
                Pen.Width := 1;
            End;

      // draw white-to-black combs
            XOffs := FColorCombRect.Left;
            YOffs := FColorCombRect.Bottom - FColorCombRect.Top - 4;
      // brush is automatically reset to bsSolid
            For I := 0 To High(FBWCombs) Do
            Begin
                Brush.Color := FBWCombs[I].Color;
                If I In [0, High(FBWCombs)]
                Then
                    DrawComb(OffScreen.Canvas, FBWCombs[I].Position.X + XOffs, FBWCombs[I].Position.Y + YOffs, 2 * FCombSize)
                Else DrawComb(OffScreen.Canvas, FBWCombs[I].Position.X + XOffs, FBWCombs[I].Position.Y + YOffs, FCombSize);
            End;

      // mark selected comb 
            If FCustomIndex < 0 Then
            Begin
                Index := -(FCustomIndex + 1);
                Pen.Style := psSolid;
                Pen.Mode := pmXOR;
                Pen.Color := clWhite;
                Pen.Width := 2;
                Brush.Style := bsClear;
                If Index In [0, High(FBWCombs)]
                Then
                    DrawComb(OffScreen.Canvas, FBWCombs[Index].Position.X + XOffs, FBWCombs[Index].Position.Y + YOffs, 2 * FCombSize)
                Else DrawComb(OffScreen.Canvas, FBWCombs[Index].Position.X + XOffs, FBWCombs[Index].Position.Y + YOffs, FCombSize);
                Pen.Style := psClear;
                Pen.Mode := pmCopy;
                Pen.Width := 1;
            End;

      // center-color trackbar
            XOffs := FSliderRect.Left;
            YOffs := FSliderRect.Top - FColorCombRect.Top;
            Count := FSliderRect.Bottom - FSliderRect.Top - 1;
            dColor := 255 / Count;
            Pen.Style := psSolid;
      // b&w ramp
            For I := 0 To Count Do
            Begin
                Pen.Color := RGB(Round((Count - I) * dColor),
                    Round((Count - I) * dColor),
                    Round((Count - I) * dColor));
                MoveTo(XOffs, YOffs + I);
                LineTo(XOffs + 10, YOffs + I);
            End;

      // marker
            Inc(XOffs, 11);
            Inc(YOffs, Round(Count * (1 - FCenterIntensity)));
            Brush.Color := clBlack;
            Polygon([Point(XOffs, YOffs), Point(XOffs + 5, YOffs - 3), Point(XOffs + 5, YOffs + 3)]);

      {$ifdef DEBUG}
        Brush.Color := clRed;
        R := FColorCombRect;
        OffsetRect(R, 0, - FColorCombRect.Top);
        FrameRect(R);
        R := FBWCombRect;
        OffsetRect(R, 0, - FColorCombRect.Top);
        FrameRect(R);
        R := FSliderRect;
        OffsetRect(R, 0, - FColorCombRect.Top);
        FrameRect(R);
      {$endif}

            Pen.Style := psClear;
        End;
    // finally put the drawing on the screen
        FCanvas.Draw(0, FColorCombRect.Top, OffScreen);
    Finally
        Offscreen.Free;
    End;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.WMPaint(Var Message: TWMPaint);

Var PS: TPaintStruct;
    I: Cardinal;
    R: TRect;
    SeparatorTop: Integer;

Begin
    If Message.DC = 0 Then
        FCanvas.Handle := BeginPaint(Handle, PS)
    Else FCanvas.Handle := Message.DC;
    Try
    // use system default font for popup text 
        FCanvas.Font.Handle := GetStockObject(DEFAULT_GUI_FONT);
        If FColorCombs = Nil Then
            CalculateCombLayout;

    // default area text
        If Length(FDefaultText) > 0 Then
            DrawCell(DefaultCell);

    // Draw colour cells
        For I := 0 To DefaultColorCount - 1 Do
            DrawCell(I);

        If FShowSysColors Then
        Begin
            SeparatorTop := FRowCount * FBoxSize + FMargin;
            If Length(FDefaultText) > 0 Then
                Inc(SeparatorTop, FDefaultTextRect.Bottom);
            With FCustomTextRect Do
                DrawSeparator(FMargin + FSpacing, SeparatorTop, Width - FMargin - FSpacing);

            For I := 0 To SysColorCount - 1 Do
                DrawCell(I + DefaultColorCount);
        End;

    // Draw custom text
        If Length(FCustomText) > 0 Then
            DrawCell(CustomCell);

        If FSelectedIndex = CustomCell Then
            DrawCombControls;

    // draw raised window edge (ex-window style WS_EX_WINDOWEDGE is supposed to do this,
    // but for some reason doesn't paint it)
        R := ClientRect;
        DrawEdge(FCanvas.Handle, R, EDGE_RAISED, BF_RECT);
    Finally
        FCanvas.Font.Handle := 0; // a stock object never needs to be freed
        FCanvas.Handle := 0;
        If Message.DC = 0 Then
            EndPaint(Handle, PS);
    End;
End;

//------------------------------------------------------------------------------

Function TColorPopup.SelectionFromPoint(P: TPoint): Integer;

// determines the button at the given position

Begin
    Result := NoCell;

  // first check we aren't in text box
    If (Length(FCustomText) > 0) And PtInRect(FCustomTextRect, P) Then
        Result := CustomCell
    Else
    If (Length(FDefaultText) > 0) And PtInRect(FDefaultTextRect, P) Then
        Result := DefaultCell
    Else
    Begin
      // take into account text box
        If Length(FDefaultText) > 0 Then
            Dec(P.Y, FDefaultTextRect.Bottom - FDefaultTextRect.Top);

      // Get the row and column
        If P.X > FSpacing Then
        Begin
            Dec(P.X, FSpacing);
        // take the margin into account, 2 * FMargin is too small while 3 * FMargin
        // is correct, but looks a bit strange (the arrow corner is so small, it isn't
        // really recognized by the eye) hence I took 2.5 * FMargin
            Dec(P.Y, 5 * FMargin Div 2);
            If (P.X >= 0) And (P.Y >= 0) Then
            Begin
          // consider system colors
                If FShowSysColors And ((P.Y Div FBoxSize) >= FRowCount) Then
                Begin
            // here we know the point is out of the default color area, so
            // take the separator line between default and system colors into account
                    Dec(P.Y, 3 * FMargin);
            // if we now are back in the default area then the point was originally
            // between both areas and we have therefore to reject a hit
                    If (P.Y Div FBoxSize) < FRowCount Then
                        Exit;
                End;
                Result := GetIndex(P.Y Div FBoxSize, P.X Div FBoxSize);
            End;
        End;
    End;
End;

//------------------------------------------------------------------------------

Function TColorPopup.HandleSlider(Const Message: TWMMouse): Boolean;

// determines whether the mouse position is within the slider area (result is then True
// else False) and acts accordingly

Var Shift: TShiftState;
    dY: Integer;
    R: TRect;

Begin
    Result := PtInRect(FSliderRect, Point(Message.XPos, Message.YPos)) And (FSelectionMode = smNone) Or
        ((Message.XPos >= FSliderRect.Left) And (Message.XPos <= FSliderRect.Right) And (FSelectionMode = smRamp));
    If Result Then
    Begin
        Shift := KeysToShiftState(Message.Keys);
        If ssLeft In Shift Then
        Begin
            FSelectionMode := smRamp;
      // left mouse button pressed -> change the intensity of the center color comb
            dY := FSliderRect.Bottom - FSliderRect.Top;
            FCenterIntensity := 1 - (Message.YPos - FSliderRect.Top) / dY;
            If FCenterIntensity < 0 Then
                FCenterIntensity := 0;
            If FCenterIntensity > 1 Then
                FCenterIntensity := 1;
            FCenterColor.Red := DefCenterColor.Red * FCenterIntensity;
            FCenterColor.Green := DefCenterColor.Green * FCenterIntensity;
            FCenterColor.Blue := DefCenterColor.Blue * FCenterIntensity;
            R := FSliderRect;
            Dec(R.Top, 3);
            Inc(R.Bottom, 3);
            Inc(R.Left, 10);
            InvalidateRect(Handle, @R, False);
            FColorCombs := Nil;
            InvalidateRect(Handle, @FColorCombRect, False);
            InvalidateRect(Handle, @FCustomColorRect, False);
            UpdateWindow(Handle);
        End;
    End;
End;

//------------------------------------------------------------------------------

Function TColorPopup.PtInComb(Comb: TCombEntry; P: TPoint; Scale: Integer): Boolean;

// simplyfied "PointInPolygon" test, we know a comb is "nearly" a circle...

Begin
    Result := (Sqr(Comb.Position.X - P.X) + Sqr(Comb.Position.Y - P.Y)) <= (Scale * Scale);
End;

//------------------------------------------------------------------------------

Function TColorPopup.FindBWArea(X, Y: Integer): Integer;

// Looks for a comb at position (X, Y) in the black&white area.
// Result is -1 if nothing could be found else the index of the particular comb
// into FBWCombs.

Var I: Integer;
    Pt: TPoint;
    Scale: Integer;

Begin
    Result := -1;
    Pt := Point(X - FBWCombRect.Left, Y - FBWCombRect.Top);

    For I := 0 To High(FBWCombs) Do
    Begin
        If I In [0, High(FBWCombs)] Then
            Scale := FCombSize
        Else Scale := FCombSize Div 2;
        If PtInComb(FBWCombs[I], Pt, Scale) Then
        Begin
            Result := I;
            Break;
        End;
    End;
End;

//------------------------------------------------------------------------------

Function TColorPopup.HandleBWArea(Const Message: TWMMouse): Boolean;

// determines whether the mouse position is within the B&W comb area (result is then True
// else False) and acts accordingly

Var Index: Integer;
    Shift: TShiftState;

Begin
    Result := PtInRect(FBWCombRect, Point(Message.XPos, Message.YPos)) And (FSelectionMode In [smNone, smBW]);
    If Result Then
    Begin
        Shift := KeysToShiftState(Message.Keys);
        If ssLeft In Shift Then
        Begin
            FSelectionMode := smBW;
            Index := FindBWArea(Message.XPos, Message.YPos);

            If Index > -1 Then
            Begin
        // remove selection comb if it was previously in color comb
                If FCustomIndex > 0 Then
                    InvalidateRect(Handle, @FColorCombRect, False);
                If FCustomIndex <> -(Index + 1) Then
                Begin
                    FCustomIndex := -(Index + 1);
                    InvalidateRect(Handle, @FBWCombRect, False);
                    InvalidateRect(Handle, @FCustomColorRect, False);
                    UpdateWindow(Handle);
                End;
            End
            Else Result := False;
        End;
    End;
End;

//------------------------------------------------------------------------------

Function TColorPopup.FindColorArea(X, Y: Integer): Integer;

// Looks for a comb at position (X, Y) in the custom color area.
// Result is -1 if nothing could be found else the index of the particular comb
// into FColorCombs.

Var I: Integer;
    Pt: TPoint;

Begin
    Result := -1;
    Pt := Point(X - (FRadius + FColorCombRect.Left),
        Y - (FRadius + FColorCombRect.Top));

    For I := 0 To High(FColorCombs) Do
    Begin
        If PtInComb(FColorCombs[I], Pt, FCombSize Div 2) Then
        Begin
            Result := I;
            Break;
        End;
    End;
End;

//------------------------------------------------------------------------------

Function TColorPopup.HandleColorComb(Const Message: TWMMouse): Boolean;

// determines whether the mouse position is within the color comb area (result is then True
// else False) and acts accordingly

Var Index: Integer;
    Shift: TShiftState;

Begin
    Result := PtInRect(FColorCombRect, Point(Message.XPos, Message.YPos)) And (FSelectionMode In [smNone, smColor]);
    If Result Then
    Begin
        Shift := KeysToShiftState(Message.Keys);
        If ssLeft In Shift Then
        Begin
            FSelectionMode := smColor;
            Index := FindColorArea(Message.XPos, Message.YPos);
            If Index > -1 Then
            Begin
        // remove selection comb if it was previously in b&w comb
                If FCustomIndex < 0 Then
                    InvalidateRect(Handle, @FBWCombRect, False);
                If FCustomIndex <> (Index + 1) Then
                Begin
                    FCustomIndex := Index + 1;
                    InvalidateRect(Handle, @FColorCombRect, False);
                    InvalidateRect(Handle, @FCustomColorRect, False);
                    UpdateWindow(Handle);
                End;
            End
            Else Result := False;
        End;
    End;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.HandleCustomColors(Var Message: TWMMouse);

Begin
    If Not HandleSlider(Message) Then
        If Not HandleBWArea(Message) Then
            If Not HandleColorComb(Message) Then
            Begin
        // user has clicked somewhere else, so remove last custom selection
                If FCustomIndex > 0 Then
                    InvalidateRect(Handle, @FColorCombRect, False)
                Else
                If FCustomIndex < 0 Then
                    InvalidateRect(Handle, @FBWCombRect, False);

                InvalidateRect(Handle, @FCustomColorRect, False);
                FCustomIndex := 0;
                UpdateWindow(Handle);
            End;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.WMMouseMove(Var Message: TWMMouseMove);

Var NewSelection: Integer;

Begin
    Inherited;
  // determine new hover index
    NewSelection := SelectionFromPoint(Point(Message.XPos, Message.YPos));

    If NewSelection <> FHoverIndex Then
        ChangeHoverSelection(NewSelection);
    If (NewSelection = -1) And
        PtInRect(ClientRect, Point(Message.XPos, Message.YPos)) And
        (csLButtonDown In ControlState) Then
        HandleCustomColors(Message);
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.WMLButtonDown(Var Message: TWMLButtonDown);

Begin
    Inherited;

    If PtInRect(ClientRect, Point(Message.XPos, Message.YPos)) Then
    Begin

        If FHoverIndex <> NoCell Then
        Begin
            InvalidateCell(FHoverIndex);
            UpdateWindow(Handle);
        End;

        If FHoverIndex = -1 Then
            HandleCustomColors(Message);
    End
    Else EndSelection(True); // hide popup window if the user has clicked elsewhere
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.ShowPopupAligned;

Var Pt: TPoint;
    Parent: TColorPickerButton;
    ParentTop: Integer;
    R: TRect;
    H: Integer;

Begin
    HandleNeeded;
    If FSelectedIndex = CustomCell Then
    Begin
    // make room for the custem color picking area
        R := Rect(FWindowRect.Left, FWindowRect.Bottom - 3, FWindowRect.Right, FWindowRect.Bottom);
        H := FBWCombRect.Bottom + 2 * FMargin;
    End
    Else
    Begin
    // hide the custem color picking area
        R := Rect(FWindowRect.Left, FWindowRect.Bottom - 3, FWindowRect.Right, FWindowRect.Bottom);
        H := FWindowRect.Bottom;
    End;
  // to ensure the window frame is drawn correctly we invalidate the lower bound explicitely
    InvalidateRect(Handle, @R, True);

  // Make sure the window is still entirely visible and aligned.
  // There's no VCL parent window as this popup is a child of the desktop,
  // but we have the owner and get the parent from this.
    Parent := TColorPickerButton(Owner);
    Pt := Parent.Parent.ClientToScreen(Point(Parent.Left - 1, Parent.Top + Parent.Height));
    If (Pt.y + H) > Screen.Height Then
        Pt.y := Screen.Height - H;
    ParentTop := Parent.Parent.ClientToScreen(Point(Parent.Left, Parent.Top)).y;
    If Pt.y < ParentTop Then
        Pt.y := ParentTop - H;
    If (Pt.x + Width) > Screen.Width Then
        Pt.x := Screen.Width - Width;
    If Pt.x < 0 Then
        Pt.x := 0;
    SetWindowPos(Handle, HWND_TOPMOST, Pt.X, Pt.Y, FWindowRect.Right, H, SWP_SHOWWINDOW);
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.ChangeSelection(NewSelection: Integer);

Begin
    If NewSelection <> NoCell Then
    Begin
        If FSelectedIndex <> NoCell Then
            InvalidateCell(FSelectedIndex);
        FSelectedIndex := NewSelection;
        If FSelectedIndex <> NoCell Then
            InvalidateCell(FSelectedIndex);

        If FSelectedIndex = CustomCell Then
            ShowPopupAligned;
    End;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.WMLButtonUp(Var Message: TWMLButtonUp);

Var NewSelection: Integer;
    LastMode: TSelectionMode;

Begin
    Inherited;
  // determine new selection index
    NewSelection := SelectionFromPoint(Point(Message.XPos, Message.YPos));
    LastMode := FSelectionMode;
    FSelectionMode := smNone;
    If (NewSelection <> NoCell) Or
        ((FSelectedIndex = CustomCell) And (FCustomIndex <> 0)) Then
    Begin
        ChangeSelection(NewSelection);
        If ((FSelectedIndex = CustomCell) And (LastMode In [smColor, smBW])) Or
            (FSelectedIndex <> NoCell) And
            (FSelectedIndex <> CustomCell) Then
            EndSelection(False)
        Else SetCapture(TColorPickerButton(Owner).FPopupWnd);
    End
    Else
    // we need to restore the mouse capturing, else the utility window will loose it
    // (safety feature of Windows?)
        SetCapture(TColorPickerButton(Owner).FPopupWnd);
End;

//------------------------------------------------------------------------------

Function TColorPopup.GetIndex(Row, Col: Integer): Integer;

Begin
    Result := NoCell;
    If ((Row = CustomCell) Or (Col = CustomCell)) And
        (Length(FCustomText) > 0) Then
        Result := CustomCell
    Else
    If ((Row = DefaultCell) Or (Col = DefaultCell)) And
        (Length(FDefaultText) > 0) Then
        Result := DefaultCell
    Else
    If (Col In [0..FColumnCount - 1]) And (Row >= 0) Then
    Begin

        If Row < FRowCount Then
        Begin
            Result := Row * FColumnCount + Col;
          // consider not fully filled last row
            If Result >= DefaultColorCount Then
                Result := NoCell;
        End
        Else
        If FShowSysColors Then
        Begin
            Dec(Row, FRowCount);
            If Row < FSysRowCount Then
            Begin
                Result := Row * FColumnCount + Col;
              // consider not fully filled last row
                If Result >= SysColorCount Then
                    Result := NoCell
                Else Inc(Result, DefaultColorCount);
            End;
        End;
    End;
End;

//------------------------------------------------------------------------------

Function TColorPopup.GetRow(Index: Integer): Integer;

Begin
    If (Index = CustomCell) And (Length(FCustomText) > 0) Then
        Result := CustomCell
    Else
    If (Index = DefaultCell) And (Length(FDefaultText) > 0) Then
        Result := DefaultCell
    Else Result := Index Div FColumnCount;
End;

//------------------------------------------------------------------------------

Function TColorPopup.GetColumn(Index: Integer): Integer;

Begin
    If (Index = CustomCell) And (Length(FCustomText) > 0) Then
        Result := CustomCell
    Else
    If (Index = DefaultCell) And (Length(FDefaultText) > 0) Then
        Result := DefaultCell
    Else Result := Index Mod FColumnCount;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.SelectColor(Color: TColor);

// looks up the given color in our lists and sets the proper indices

Var I: Integer;
    C: COLORREF;
    found: Boolean;

Begin
    found := False;

  // handle special colors first
    If Color = clNone Then
        FSelectedIndex := NoCell
    Else
    If Color = clDefault Then
        FSelectedIndex := DefaultCell
    Else
    Begin
      // if the incoming color is one of the predefined colors (clBtnFace etc.) and
      // system colors are active then start looking in the system color list
        If FShowSysColors And (Color < 0) Then
        Begin
            For I := 0 To SysColorCount - 1 Do
                If TColor(SysColors[I].Color) = Color Then
                Begin
                    FSelectedIndex := I + DefaultColorCount;
                    found := True;
                    Break;
                End;
        End;

        If Not found Then
        Begin
            C := ColorToRGB(Color);
            For I := 0 To DefaultColorCount - 1 Do
          // only Borland knows why the result of ColorToRGB is Longint not COLORREF,
          // in order to make the compiler quiet I need a Longint cast here
                If ColorToRGB(DefaultColors[I].Color) = Longint(C) Then
                Begin
                    FSelectedIndex := I;
                    found := True;
                    Break;
                End;

        // look in the system colors if not already done yet
            If Not found And FShowSysColors And (Color >= 0) Then
            Begin
                For I := 0 To SysColorCount - 1 Do
                Begin
                    If ColorToRGB(TColor(SysColors[I].Color)) = Longint(C) Then
                    Begin
                        FSelectedIndex := I + DefaultColorCount;
                        found := True;
                        Break;
                    End;
                End;
            End;

            If Not found Then
            Begin
                If FColorCombs = Nil Then
                    CalculateCombLayout;
                FCustomIndex := 0;
                FSelectedIndex := NoCell;
                For I := 0 To High(FBWCombs) Do
                    If FBWCombs[I].Color = C Then
                    Begin
                        FSelectedIndex := CustomCell;
                        FCustomIndex := -(I + 1);
                        found := True;
                        Break;
                    End;

                If Not found Then
                    For I := 0 To High(FColorCombs) Do
                        If FColorCombs[I].Color = C Then
                        Begin
                            FSelectedIndex := CustomCell;
                            FCustomIndex := I + 1;
                            Break;
                        End;
            End;
        End;
    End;
End;

//------------------------------------------------------------------------------

Function TColorPopup.GetCellRect(Index: Integer; Var Rect: TRect): Boolean;

// gets the dimensions of the colour cell given by Index

Begin
    Result := False;
    If Index = CustomCell Then
    Begin
        Rect := FCustomTextRect;
        Result := True;
    End
    Else
    If Index = DefaultCell Then
    Begin
        Rect := FDefaultTextRect;
        Result := True;
    End
    Else
    If Index >= 0 Then
    Begin
        Rect.Left := GetColumn(Index) * FBoxSize + FMargin + FSpacing;
        Rect.Top := GetRow(Index) * FBoxSize + 2 * FMargin;

        // move everything down if we are displaying a default text area
        If Length(FDefaultText) > 0 Then
            Inc(Rect.Top, FDefaultTextRect.Bottom - 2 * FMargin);

        // move everything further down if we consider syscolors
        If Index >= DefaultColorCount Then
            Inc(Rect.Top, 3 * FMargin);

        Rect.Right := Rect.Left + FBoxSize;
        Rect.Bottom := Rect.Top + FBoxSize;

        Result := True;
    End;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.AdjustWindow;

// works out an appropriate size and position of this window

Var TextSize,
    DefaultSize: TSize;
    DC: HDC;
    WHeight: Integer;

Begin
  // If we are showing a custom or default text area, get the font and text size.
    If (Length(FCustomText) > 0) Or (Length(FDefaultText) > 0) Then
    Begin
        DC := GetDC(Handle);
        FCanvas.Handle := DC;
        FCanvas.Font.Handle := GetStockObject(DEFAULT_GUI_FONT);
        Try
      // Get the size of the custom text (if there IS custom text)
            TextSize.cx := 0;
            TextSize.cy := 0;
            If Length(FCustomText) > 0 Then
                TextSize := FCanvas.TextExtent(FCustomText);

      // Get the size of the default text (if there IS default text)
            If Length(FDefaultText) > 0 Then
            Begin
                DefaultSize := FCanvas.TextExtent(FDefaultText);
                If DefaultSize.cx > TextSize.cx Then
                    TextSize.cx := DefaultSize.cx;
                If DefaultSize.cy > TextSize.cy Then
                    TextSize.cy := DefaultSize.cy;
            End;

            Inc(TextSize.cx, 2 * FMargin);
            Inc(TextSize.cy, 4 * FMargin + 2);

        Finally
            FCanvas.Font.Handle := 0;
            FCanvas.Handle := 0;
            ReleaseDC(Handle, DC);
        End;
    End;

  // Get the number of columns and rows
    FColumnCount := 8;
    FRowCount := DefaultColorCount Div FColumnCount;
    If (DefaultColorCount Mod FColumnCount) <> 0 Then
        Inc(FRowCount);

    FWindowRect := Rect(0, 0,
        FColumnCount * FBoxSize + 2 * FMargin + 2 * FSpacing,
        FRowCount * FBoxSize + 4 * FMargin);

    FRadius := Trunc(7 * (FColumnCount * FBoxSize) / 16);
    FCombSize := Round(0.5 + FRadius / (FLevels - 1));

  // if default text, then expand window if necessary, and set text width as
  // window width
    If Length(FDefaultText) > 0 Then
    Begin
        If TextSize.cx > (FWindowRect.Right - FWindowRect.Left) Then
            FWindowRect.Right := FWindowRect.Left + TextSize.cx;
        TextSize.cx := FWindowRect.Right - FWindowRect.Left - 2 * FMargin;

    // work out the text area
        FDefaultTextRect := Rect(FMargin + FSpacing, 2 * FMargin, FMargin - FSpacing + TextSize.cx, 2 * FMargin + TextSize.cy);
        Inc(FWindowRect.Bottom, FDefaultTextRect.Bottom - FDefaultTextRect.Top + 2 * FMargin);
    End;

    If FShowSysColors Then
    Begin
        FSysRowCount := SysColorCount Div FColumnCount;
        If (SysColorCount Mod FColumnCount) <> 0 Then
            Inc(FSysRowCount);
        Inc(FWindowRect.Bottom, FSysRowCount * FBoxSize + 2 * FMargin);
    End;

  // if custom text, then expand window if necessary, and set text width as
  // window width
    If Length(FCustomText) > 0 Then
    Begin
        If TextSize.cx > (FWindowRect.Right - FWindowRect.Left) Then
            FWindowRect.Right := FWindowRect.Left + TextSize.cx;
        TextSize.cx := FWindowRect.Right - FWindowRect.Left - 2 * FMargin;

    // work out the text area
        WHeight := FWindowRect.Bottom - FWindowRect.Top;
        FCustomTextRect := Rect(FMargin + FSpacing,
            WHeight,
            FMargin - FSpacing + TextSize.cx,
            WHeight + TextSize.cy);
    // precalculate also the small preview box for custom color selection for fast updates
        FCustomColorRect := Rect(0, 0, FBoxSize, FBoxSize);
        InflateRect(FCustomColorRect, -(FMargin + 1), -(FMargin + 1));
        OffsetRect(FCustomColorRect,
            FCustomTextRect.Right - FBoxSize - FMargin,
            FCustomTextRect.Top + (FCustomTextRect.Bottom - FCustomTextRect.Top - FCustomColorRect.Bottom - FMargin - 1) Div 2);

        Inc(FWindowRect.Bottom, FCustomTextRect.Bottom - FCustomTextRect.Top + 2 * FMargin);
    End;

  // work out custom color choice area (color combs) (FWindowRect covers only the always visible part)
    FColorCombRect := Rect(FMargin + FSpacing,
        FWindowRect.Bottom,
        FMargin + FSpacing + 2 * FRadius,
        FWindowRect.Bottom + 2 * FRadius);
  // work out custom color choice area (b&w combs)
    FBWCombRect := Rect(FColorCombRect.Left,
        FColorCombRect.Bottom - 4,
        Round(17 * FCombSize * cos(Pi / 6) / 2) + 6 * FCombSize,
        FColorCombRect.Bottom + 2 * FCombSize);
  // work out slider area
    FSliderRect := Rect(FColorCombRect.Right,
        FColorCombRect.Top + FCombSize,
        FColorCombRect.Right + 20,
        FColorCombRect.Bottom - FCombSize);

  // set the window size
    With FWindowRect Do
        SetBounds(Left, Top, Right - Left, Bottom - Top);
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.ChangeHoverSelection(Index: Integer);

Begin
    If Not FShowSysColors And (Index >= DefaultColorCount) Or
        (Index >= (DefaultColorCount + SysColorCount)) Then
        Index := NoCell;

  // remove old hover selection
    InvalidateCell(FHoverIndex);

    FHoverIndex := Index;
    InvalidateCell(FHoverIndex);
    UpdateWindow(Handle);
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.EndSelection(Cancel: Boolean);

Begin
    With Owner As TColorPickerButton Do
    Begin
        If Not Cancel Then
        Begin
            If FSelectedIndex > -1 Then
                If FSelectedIndex < DefaultColorCount Then
                    SelectionColor := TColor(DefaultColors[FSelectedIndex].Color)
                Else SelectionColor := TColor(SysColors[FSelectedIndex - DefaultColorCount].Color)
            Else
            If FSelectedIndex = CustomCell Then
            Begin
                If FCustomIndex < 0 Then
                    SelectionColor := FBWCombs[-(FCustomIndex + 1)].Color
                Else
                If FCustomIndex > 0 Then
                    SelectionColor := FColorCombs[FCustomIndex - 1].Color;
            End
            Else DoDefaultEvent;
        End;
        DroppedDown := False;
    End;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.WMKillFocus(Var Message: TWMKillFocus);

Begin
    Inherited;
    (Owner As TColorPickerButton).DroppedDown := False;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.CalculateCombLayout;

// fills arrays with centers and colors for the custom color and black & white combs,
// these arrays are used to quickly draw the combx and do hit tests

  //--------------- local functions -----------------------

    Function RGBFromFloat(Color: TRGB): COLORREF;

    Begin
        Result := RGB(Round(255 * Color.Red), Round(255 * Color.Green), Round(255 * Color.Blue));
    End;

  //-------------------------------------------------------

    Function GrayFromIntensity(Intensity: Byte): COLORREF;

    Begin
        Result := RGB(Intensity, Intensity, Intensity);
    End;

  //--------------- end local functions -------------------

Var CurrentIndex: Cardinal;
    CurrentColor: TRGB;
    CurrentPos: TFloatPoint;
    CombCount: Cardinal;
    I, J,
    Level: Cardinal;
    Scale: Extended;

    // triangle vars
    Pos1, Pos2: TFloatPoint;
    dPos1, dPos2: TFloatPoint;
    Color1, Color2: TRGB;
    dColor1, dColor2: TRGB;
    dPos: TFloatPoint;
    dColor: TRGB;

Begin
  // this ensures the radius and comb size is set correctly
    HandleNeeded;
    If FLevels < 1 Then
        FLevels := 1;
  // To draw perfectly aligned combs we split the final comb into six triangles (sextants)
  // and calculate each separately. The center comb is stored as first entry in the array
  // and will not considered twice (as with the other shared combs too).
  //
  // The way used here for calculation of the layout seems a bit complicated, but works
  // correctly for all cases (even if the comb corners are rotated).

  // initialization
    CurrentIndex := 0;
    CurrentColor := FCenterColor;

  // number of combs can be calculated by:
  // 1 level: 1 comb (the center)
  // 2 levels: 1 comb + 6 combs
  // 3 levels: 1 comb + 1 * 6 combs + 2 * 6 combs
  // n levels: 1 combs + 1 * 6 combs + 2 * 6 combs + .. + (n-1) * 6 combs
  // this equals to 1 + 6 * (1 + 2 + 3 + .. + (n-1)), by using Gauss' famous formula we get:
  // Count = 1 + 6 * (((n-1) * n) / 2)
  // Because there's always an even number involved (either n or n-1) we can use an integer div
  // instead of a float div here...
    CombCount := 1 + 6 * (((FLevels - 1) * FLevels) Div 2);
    SetLength(FColorCombs, CombCount);

  // store center values
    FColorCombs[CurrentIndex].Position := Point(0, 0);
    FColorCombs[CurrentIndex].Color := RGBFromFloat(CurrentColor);
    Inc(CurrentIndex);

  // go out off here if there are not further levels to draw
    If FLevels < 2 Then
        Exit;

  // now go for each sextant, the generic corners have been calculated already at creation
  // time for a comb with diameter 1
  //              ------
  //             /\  1 /\
  //            /  \  /  \
  //           / 2  \/  0 \
  //           -----------
  //           \ 3  /\  5 /
  //            \  /  \  /
  //             \/  4 \/
  //              ------

    For I := 0 To 5 Do
    Begin
    // initialize triangle corner values
    //
    //                center (always at 0,0)
    //                 /\
    //     dPos1      /  \    dPos2
    //     dColor1   /    \   dColor2
    //              / dPos \
    //             /--------\ (span)
    //            /  dColor  \
    //           /____________\
    //    comb corner 1     comb corner 2
    //
    // Pos1, Pos2, Color1, Color2 are running terms for both sides of the triangle
    // incremented by dPos1/2 and dColor1/2.
    // dPos and dColor are used to interpolate a span between the values just mentioned.
    //
    // The small combs are actually oriented with corner 0 at top (i.e. mirrored at y = x,
    // compared with the values in FCombCorners), we can achieve that by simply exchanging
    // X and Y values.

        Scale := 2 * FRadius * cos(Pi / 6);
        Pos1.X := FCombCorners[I].Y * Scale;
        Pos1.Y := FCombCorners[I].X * Scale;
        Color1 := DefColors[I];
        If I = 5 Then
        Begin
            Pos2.X := FCombCorners[0].Y * Scale;
            Pos2.Y := FCombCorners[0].X * Scale;
            Color2 := DefColors[0];
        End
        Else
        Begin
            Pos2.X := FCombCorners[I + 1].Y * Scale;
            Pos2.Y := FCombCorners[I + 1].X * Scale;
            Color2 := DefColors[I + 1];
        End;
        dPos1.X := Pos1.X / (FLevels - 1);
        dPos1.Y := Pos1.Y / (FLevels - 1);
        dPos2.X := Pos2.X / (FLevels - 1);
        dPos2.Y := Pos2.Y / (FLevels - 1);

        dColor1.Red := (Color1.Red - FCenterColor.Red) / (FLevels - 1);
        dColor1.Green := (Color1.Green - FCenterColor.Green) / (FLevels - 1);
        dColor1.Blue := (Color1.Blue - FCenterColor.Blue) / (FLevels - 1);

        dColor2.Red := (Color2.Red - FCenterColor.Red) / (FLevels - 1);
        dColor2.Green := (Color2.Green - FCenterColor.Green) / (FLevels - 1);
        dColor2.Blue := (Color2.Blue - FCenterColor.Blue) / (FLevels - 1);

        Pos1 := DefCenter;
        Pos2 := DefCenter;
        Color1 := FCenterColor;
        Color2 := FCenterColor;

    // Now that we have finished the initialization for this step we'll go
    // through a loop for each level to calculate the spans.
    // We can ignore level 0 (as this is the center we already have determined) as well
    // as the last step of each span (as this is the start value in the next triangle and will
    // be calculated there). We have, though, take them into the calculation of the running terms. 
        For Level := 0 To FLevels - 1 Do
        Begin
            If Level > 0 Then
            Begin
        // initialize span values
                dPos.X := (Pos2.X - Pos1.X) / Level;
                dPos.Y := (Pos2.Y - Pos1.Y) / Level;
                dColor.Red := (Color2.Red - Color1.Red) / Level;
                dColor.Green := (Color2.Green - Color1.Green) / Level;
                dColor.Blue := (Color2.Blue - Color1.Blue) / Level;
                CurrentPos := Pos1;
                CurrentColor := Color1;

                For J := 0 To Level - 1 Do
                Begin
          // store current values in the array
                    FColorCombs[CurrentIndex].Position.X := Round(CurrentPos.X);
                    FColorCombs[CurrentIndex].Position.Y := Round(CurrentPos.Y);
                    FColorCombs[CurrentIndex].Color := RGBFromFloat(CurrentColor);
                    Inc(CurrentIndex);

          // advance in span
                    CurrentPos.X := CurrentPos.X + dPos.X;
                    CurrentPos.Y := CurrentPos.Y + dPos.Y;

                    CurrentColor.Red := CurrentColor.Red + dColor.Red;
                    CurrentColor.Green := CurrentColor.Green + dColor.Green;
                    CurrentColor.Blue := CurrentColor.Blue + dColor.Blue;
                End;
            End;
      // advance running terms
            Pos1.X := Pos1.X + dPos1.X;
            Pos1.Y := Pos1.Y + dPos1.Y;
            Pos2.X := Pos2.X + dPos2.X;
            Pos2.Y := Pos2.Y + dPos2.Y;

            Color1.Red := Color1.Red + dColor1.Red;
            Color1.Green := Color1.Green + dColor1.Green;
            Color1.Blue := Color1.Blue + dColor1.Blue;

            Color2.Red := Color2.Red + dColor2.Red;
            Color2.Green := Color2.Green + dColor2.Green;
            Color2.Blue := Color2.Blue + dColor2.Blue;
        End;
    End;

  // second step is to build a list for the black & white area
  // 17 entries from pure white to pure black
  // the first and last are implicitely of double comb size
    SetLength(FBWCombs, 17);
    CurrentIndex := 0;
    FBWCombs[CurrentIndex].Color := GrayFromIntensity(255);
    FBWCombs[CurrentIndex].Position := Point(FCombSize, FCombSize);
    Inc(CurrentIndex);

    CurrentPos.X := 3 * FCombSize;
    CurrentPos.Y := 3 * (FCombSize Div 4);
    dPos.X := Round(FCombSize * cos(Pi / 6) / 2);
    dPos.Y := Round(FCombSize * (1 + sin(Pi / 6)) / 2);
    For I := 0 To 14 Do
    Begin
        FBWCombs[CurrentIndex].Color := GrayFromIntensity((16 - CurrentIndex) * 15);
        If Odd(I) Then
            FBWCombs[CurrentIndex].Position := Point(Round(CurrentPos.X + I * dPos.X), Round(CurrentPos.Y + dPos.Y))
        Else FBWCombs[CurrentIndex].Position := Point(Round(CurrentPos.X + I * dPos.X), Round(CurrentPos.Y));
        Inc(CurrentIndex);
    End;
    FBWCombs[CurrentIndex].Color := 0;
    FBWCombs[CurrentIndex].Position := Point(Round(CurrentPos.X + 16 * dPos.X + FCombSize), FCombSize);
End;

//-----------------------------------------------------------------------------

Procedure TColorPopup.CreateParams(Var Params: TCreateParams);

Begin
    Inherited CreateParams(Params);
    With Params Do
    Begin
        WndParent := GetDesktopWindow;
        Style := WS_CLIPSIBLINGS Or WS_CHILD;
        ExStyle := WS_EX_TOPMOST Or WS_EX_TOOLWINDOW;
        WindowClass.Style := CS_DBLCLKS Or CS_SAVEBITS;
    End;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.CreateWnd;

Begin
    Inherited;
    AdjustWindow;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.SetSpacing(Value: Integer);

Begin
    If Value < 0 Then
        Value := 0;
    If FSpacing <> Value Then
    Begin
        FSpacing := Value;
        Invalidate;
    End;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.InvalidateCell(Index: Integer);

Var R: TRect;

Begin
    If GetCellRect(Index, R) Then
        InvalidateRect(Handle, @R, False);
End;

//------------------------------------------------------------------------------

Function TColorPopup.GetHint(Cell: Integer): String;

Begin
    Result := '';
    If Assigned(TColorPickerButton(Owner).FOnHint) Then
        TColorPickerButton(Owner).FOnHint(Owner, Cell, Result);
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.CMHintShow(Var Message: TMessage);

// determine hint message (tooltip) and out-of-hint rect

Var Index: Integer;
    r, g, b: Byte;
    Colors: TCombArray;

Begin
    Colors := Nil;
    With TCMHintShow(Message) Do
    Begin
        If Not TColorPickerButton(Owner).ShowHint Then
            Message.Result := 1
        Else
        Begin
            With HintInfo^ Do
            Begin
        // show that we want a hint
                Result := 0;
        // predefined colors always get their names as tooltip
                If FHoverIndex >= 0 Then
                Begin
                    GetCellRect(FHoverIndex, CursorRect);
                    If FHoverIndex < DefaultColorCount Then
                        HintStr := DefaultColors[FHoverIndex].Name
                    Else HintStr := SysColors[FHoverIndex - DefaultColorCount].Name;
                End
                Else
          // both special cells get their hint either from the application by
          // means of the OnHint event or the hint string of the owner control
                If (FHoverIndex = DefaultCell) Or
                    (FHoverIndex = CustomCell) Then
                Begin
                    HintStr := GetHint(FHoverIndex);
                    If HintStr = '' Then
                        HintStr := TColorPickerButton(Owner).Hint
                    Else
                    Begin
              // if the application supplied a hint by event then deflate the cursor rect
              // to the belonging button
                        If FHoverIndex = DefaultCell Then
                            CursorRect := FDefaultTextRect
                        Else CursorRect := FCustomTextRect;
                    End;
                End
                Else
                Begin
            // well, mouse is not hovering over one of the buttons, now check for
            // the ramp and the custom color areas
                    If PtInRect(FSliderRect, Point(CursorPos.X, CursorPos.Y)) Then
                    Begin
              // in case of the intensity slider we show the current intensity
                        HintStr := Format('Intensity: %d%%', [Round(100 * FCenterIntensity)]);
                        CursorRect := Rect(FSliderRect.Left, CursorPos.Y - 2,
                            FSliderRect.Right, CursorPos.Y + 2);
                        HintPos := ClientToScreen(Point(FSliderRect.Right, CursorPos.Y - 8));
                        HideTimeout := 5000;
                        CursorRect := Rect(FSliderRect.Left, CursorPos.Y,
                            FSliderRect.Right, CursorPos.Y);
                    End
                    Else
                    Begin
                        Index := -1;
                        If PtInRect(FBWCombRect, Point(CursorPos.X, CursorPos.Y)) Then
                        Begin
                // considering black&white area...
                            If csLButtonDown In ControlState Then
                                Index := -(FCustomIndex + 1)
                            Else Index := FindBWArea(CursorPos.X, CursorPos.Y);
                            Colors := FBWCombs;
                        End
                        Else
                        If PtInRect(FColorCombRect, Point(CursorPos.X, CursorPos.Y)) Then
                        Begin
                  // considering color comb area...
                            If csLButtonDown In ControlState Then
                                Index := FCustomIndex - 1
                            Else Index := FindColorArea(CursorPos.X, CursorPos.Y);
                            Colors := FColorCombs;
                        End;

                        If (Index > -1) And (Colors <> Nil) Then
                        Begin
                            With Colors[Index] Do
                            Begin
                                r := GetRValue(Color);
                                g := GetGValue(Color);
                                b := GetBValue(Color);
                            End;
                            HintStr := Format('red: %d, green: %d, blue: %d', [r, g, b]);
                            HideTimeout := 5000;
                        End
                        Else HintStr := GetHint(NoCell);

              // make the hint follow the mouse
                        CursorRect := Rect(CursorPos.X, CursorPos.Y,
                            CursorPos.X, CursorPos.Y);
                    End;
                End;
            End;
        End;
    End;
End;

//------------------------------------------------------------------------------

Procedure TColorPopup.SetSelectedColor(Const Value: TColor);

Begin
    FCurrentColor := Value;
    SelectColor(Value);
End;

//----------------- TColorPickerButton ------------------------------------------

Constructor TColorPickerButton.Create(AOwner: TComponent);

Begin
    Inherited Create(AOwner);
    FSelectionColor := clBlack;
    FColorPopup := TColorPopup.Create(Self);
  // park the window somewhere it can't be seen
    FColorPopup.Left := -1000;
  // to avoid "deprecated" message use
  // Classes.AllocateHWnd not Forms.AllocateHWnd
    FPopupWnd := Classes.AllocateHWnd(PopupWndProc);

    FGlyph := TButtonGlyph.Create;
    TButtonGlyph(FGlyph).OnChange := GlyphChanged;
    SetBounds(0, 0, 45, 22);
    FDropDownWidth := 15;
    ControlStyle := [csCaptureMouse, csDoubleClicks];
    ParentFont := True;
    Color := clBtnFace;
    FSpacing := 4;
    FMargin := -1;
    FLayout := blGlyphLeft;
    FTransparent := True;
    FIndicatorBorder := ibFlat;

    Inc(ButtonCount);
End;

//-----------------------------------------------------------------------------

Destructor TColorPickerButton.Destroy;

Begin
  // to avoid "deprecated" message use
  // Classes.AllocateHWnd not Forms.AllocateHWnd
    Classes.DeallocateHWnd(FPopupWnd);
    Dec(ButtonCount);
  // the color popup window will automatically be freed since the button is the owner
  // of the popup
    TButtonGlyph(FGlyph).Free;
    Inherited Destroy;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.PopupWndProc(Var Msg: TMessage);

Var P: TPoint;

Begin
    Case Msg.Msg Of
        WM_MOUSEFIRST..WM_MOUSELAST:
        Begin
            With TWMMouse(Msg) Do
            Begin
                P := SmallPointToPoint(Pos);
                MapWindowPoints(FPopupWnd, FColorPopup.Handle, P, 1);
                Pos := PointToSmallPoint(P);
            End;
            FColorPopup.WindowProc(Msg);
        End;
        CN_KEYDOWN,
        CN_SYSKEYDOWN:
            FColorPopup.WindowProc(Msg);
    Else
        With Msg Do
            Result := DefWindowProc(FPopupWnd, Msg, wParam, lParam);
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetDropDownArrowColor(Value: TColor);

Begin
    If Not (FDropDownArrowColor = Value) Then;
    Begin
        FDropDownArrowColor := Value;
        Invalidate;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetDropDownWidth(Value: Integer);

Begin
    If Not (FDropDownWidth = Value) Then;
    Begin
        FDropDownWidth := Value;
        Invalidate;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.Paint;

Const MAX_WIDTH = 5;
    DownStyles: Array[Boolean] Of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
    FillStyles: Array[Boolean] Of Integer = (BF_MIDDLE, 0);

Var PaintRect: TRect;
    ExtraRect: TRect;
    DrawFlags: Integer;
    Offset: TPoint;
    LeftPos: Integer;

Begin
    If Not Enabled Then
    Begin
        FState := bsDisabled;
        FDragging := False;
    End
    Else
    If (FState = bsDisabled) Then
    Begin
        If FDown And (GroupIndex <> 0) Then
            FState := bsExclusive
        Else FState := bsUp;
    End;

    Canvas.Font := Self.Font;

  // Creates a rectangle that represent the button and the drop down area,
  // determines also the position to draw the arrow...
    PaintRect := Rect(0, 0, Width, Height);
    ExtraRect := Rect(Width - FDropDownWidth, 0, Width, Height);
    LeftPos := (Width - FDropDownWidth) + ((FDropDownWidth + MAX_WIDTH) Div 2) - MAX_WIDTH - 1;

  // Determines if the button is a flat or normal button... each uses
  // different painting methods
    If Not FFlat Then
    Begin
        DrawFlags := DFCS_BUTTONPUSH Or DFCS_ADJUSTRECT;

        If FState In [bsDown, bsExclusive] Then
            DrawFlags := DrawFlags Or DFCS_PUSHED;

    // Check if the mouse is in the drop down zone. If it is we then check
    // the state of the button to determine the drawing sequence
        If FDropDownZone Then
        Begin
            If FDroppedDown Then
            Begin
        // paint pressed Drop Down Button
                DrawFrameControl(Canvas.Handle, PaintRect, DFC_BUTTON, DRAW_BUTTON_UP);
                DrawFrameControl(Canvas.Handle, ExtraRect, DFC_BUTTON, DRAW_BUTTON_DOWN);
            End
            Else
            Begin
        // paint depressed Drop Down Button
                DrawFrameControl(Canvas.Handle, PaintRect, DFC_BUTTON, DRAW_BUTTON_UP);
                DrawFrameControl(Canvas.Handle, ExtraRect, DFC_BUTTON, DRAW_BUTTON_UP);
                DrawButtonSeperatorUp(Canvas);
            End;
        End
        Else
        Begin
            DrawFrameControl(Canvas.Handle, PaintRect, DFC_BUTTON, DrawFlags);

      // Determine the type of drop down seperator...
            If (FState In [bsDown, bsExclusive]) Then
                DrawButtonSeperatorDown(Canvas)
            Else DrawButtonSeperatorUp(Canvas);
        End;
    End
    Else
    Begin
        If (FState In [bsDown, bsExclusive]) Or
            (FMouseInControl And (FState <> bsDisabled)) Or
            (csDesigning In ComponentState) Then
        Begin
      // Check if the mouse is in the drop down zone. If it is we then check
      // the state of the button to determine the drawing sequence
            If FDropDownZone Then
            Begin
                If FDroppedDown Then
                Begin
          // Paint pressed Drop Down Button
                    DrawEdge(Canvas.Handle, PaintRect, DownStyles[False], FillStyles[FTransparent] Or BF_RECT);
                    DrawEdge(Canvas.Handle, ExtraRect, DownStyles[True], FillStyles[FTransparent] Or BF_RECT);
                End
                Else
                Begin
          // Paint depressed Drop Down Button
                    DrawEdge(Canvas.Handle, PaintRect, DownStyles[False], FillStyles[FTransparent] Or BF_RECT);
                    DrawEdge(Canvas.Handle, ExtraRect, DownStyles[False], FillStyles[FTransparent] Or BF_RECT);
                    DrawButtonSeperatorUp(Canvas);
                End;
            End
            Else
            Begin
                DrawEdge(Canvas.Handle, PaintRect, DownStyles[FState In [bsDown, bsExclusive]], FillStyles[FTransparent] Or BF_RECT);

                If (FState In [bsDown, bsExclusive]) Then
                    DrawButtonSeperatorDown(Canvas)
                Else DrawButtonSeperatorUp(Canvas);
            End;
        End
        Else
        If Not FTransparent Then
        Begin
            Canvas.Brush.Style := bsSolid;
            Canvas.Brush.Color := Color;
            Canvas.FillRect(PaintRect);
        End;
        InflateRect(PaintRect, -1, -1);
    End;


    If (FState In [bsDown, bsExclusive]) And Not (FDropDownZone) Then
    Begin
        If (FState = bsExclusive) And (Not FFlat Or Not FMouseInControl) Then
        Begin
            Canvas.Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
            Canvas.FillRect(PaintRect);
        End;
        Offset.X := 1;
        Offset.Y := 1;
    End
    Else
    Begin
        Offset.X := 0;
        Offset.Y := 0;
    End;

    PaintRect := TButtonGlyph(FGlyph).Draw(Canvas, PaintRect, Offset, Caption, FLayout, FMargin,
        FSpacing, FState, FTransparent, FDropDownWidth, DrawTextBiDiModeFlags(0));

  // draw color indicator
    Canvas.Brush.Color := FSelectionColor;
    Canvas.Pen.Color := clBtnShadow;

    Case FIndicatorBorder Of
        ibNone:
            Canvas.FillRect(PaintRect);
        ibFlat:
            With PaintRect Do
                Canvas.Rectangle(Left, Top, Right, Bottom);
    Else
        If FIndicatorBorder = ibSunken Then
            DrawEdge(Canvas.Handle, PaintRect, BDR_SUNKENOUTER, BF_RECT)
        Else DrawEdge(Canvas.Handle, PaintRect, BDR_RAISEDINNER, BF_RECT);
        InflateRect(PaintRect, -1, -1);
        Canvas.FillRect(PaintRect);
    End;

  // Draws the arrow for the correct state
    If FState = bsDisabled Then
    Begin
        Canvas.Pen.Style := psClear;
        Canvas.Brush.Color := clBtnShadow;
    End
    Else
    Begin
        Canvas.Pen.Color := FDropDownArrowColor;
        Canvas.Brush.Color := FDropDownArrowColor;
    End;

    If FDropDownZone And FDroppedDown Or (FState = bsDown) And Not (FDropDownZone) Then
        DrawTriangle(Canvas, (Height Div 2) + 1, LeftPos + 1, MAX_WIDTH)
    Else
        DrawTriangle(Canvas, (Height Div 2), LeftPos, MAX_WIDTH);
End;


//-----------------------------------------------------------------------------

Procedure TColorPickerButton.UpdateTracking;

Var P: TPoint;

Begin
    If FFlat Then
    Begin
        If Enabled Then
        Begin
            GetCursorPos(P);
            FMouseInControl := Not (FindDragTarget(P, True) = Self);
            If FMouseInControl Then
                Perform(CM_MOUSELEAVE, 0, 0)
            Else Perform(CM_MOUSEENTER, 0, 0);
        End;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.Loaded;

Var State: TButtonState;

Begin
    Inherited Loaded;
    If Enabled Then
        State := bsUp
    Else State := bsDisabled;
    TButtonGlyph(FGlyph).CreateButtonGlyph(State);
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

Begin
    Inherited MouseDown(Button, Shift, X, Y);

    If (Button = mbLeft) And Enabled Then
    Begin
    // Determine if mouse is currently in the drop down section...
        FDropDownZone := (X > Width - FDropDownWidth);

    // If so display the button in the proper state and display the menu
        If FDropDownZone Then
        Begin
            If Not FDroppedDown Then
            Begin
                Update;
                DroppedDown := True;
            End;

      // Setting this flag to false is very important, we want the dsUp state to
      // be used to display the button properly the next time the mouse moves in
            FDragging := False;
        End
        Else
        Begin
            If Not FDown Then
            Begin
                FState := bsDown;
                Invalidate;
            End;

            FDragging := True;
        End;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.MouseMove(Shift: TShiftState; X, Y: Integer);

Var NewState: TButtonState;

Begin
    Inherited MouseMove(Shift, X, Y);
    If FDragging Then
    Begin
        If Not FDown Then
            NewState := bsUp
        Else NewState := bsExclusive;
        If (X >= 0) And (X < ClientWidth) And (Y >= 0) And (Y <= ClientHeight) Then
            If FDown Then
                NewState := bsExclusive
            Else NewState := bsDown;
        If NewState <> FState Then
        Begin
            FState := NewState;
            Invalidate;
        End;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

Var DoClick: Boolean;

Begin
    Inherited MouseUp(Button, Shift, X, Y);
    If FDragging Then
    Begin
        FDragging := False;
        DoClick := (X >= 0) And (X < ClientWidth) And (Y >= 0) And (Y <= ClientHeight);
        If FGroupIndex = 0 Then
        Begin
      // Redraw face in case mouse is captured
            FState := bsUp;
            FMouseInControl := False;
            If DoClick And Not (FState In [bsExclusive, bsDown]) Then
                Invalidate;
        End
        Else
        If DoClick Then
        Begin
            SetDown(Not FDown);
            If FDown Then
                Repaint;
        End
        Else
        Begin
            If FDown Then
                FState := bsExclusive;
            Repaint;
        End;
        If DoClick Then
            Click;
        UpdateTracking;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.Click;

Begin
    Inherited Click;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.DoDefaultEvent;

Begin
    If Assigned(FOnDefaultSelect) Then
        FOnDefaultSelect(Self);
End;

//-----------------------------------------------------------------------------

Function TColorPickerButton.GetPalette: HPALETTE;

Begin
    Result := Glyph.Palette;
End;

//-----------------------------------------------------------------------------

Function TColorPickerButton.GetGlyph: TBitmap;

Begin
    Result := TButtonGlyph(FGlyph).Glyph;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetGlyph(Value: TBitmap);

Begin
    TButtonGlyph(FGlyph).Glyph := Value;
    Invalidate;
End;

//-----------------------------------------------------------------------------

Function TColorPickerButton.GetNumGlyphs: TNumGlyphs;

Begin
    Result := TButtonGlyph(FGlyph).NumGlyphs;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.DrawButtonSeperatorUp(Canvas: TCanvas);

Begin
    With Canvas Do
    Begin
        Pen.Style := psSolid;
        Brush.Style := bsClear;
        Pen.Color := clBtnHighlight;
        Rectangle(Width - DropDownWidth, 1, Width - DropDownWidth + 1, Height - 1);
        Pen.Color := clBtnShadow;
        Rectangle(Width - DropDownWidth - 1, 1, Width - DropDownWidth, Height - 1);
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.DrawButtonSeperatorDown(Canvas: TCanvas);

Begin
    With Canvas Do
    Begin
        Pen.Style := psSolid;
        Brush.Style := bsClear;
        Pen.Color := clBtnHighlight;
        Rectangle(Width - DropDownWidth + 1, 2, Width - DropDownWidth + 2, Height - 2);
        Pen.Color := clBtnShadow;
        Rectangle(Width - DropDownWidth, 2, Width - DropDownWidth + 1, Height - 2);
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.DrawTriangle(Canvas: TCanvas; Top, Left, Width: Integer);

Begin
    If Odd(Width) Then
        Inc(Width);
    dec(Top);
    dec(left);
    Canvas.Polygon([Point(Left, Top),
        Point(Left + Width, Top),
        Point(Left + Width Div 2, Top + Width Div 2)]);
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetNumGlyphs(Value: TNumGlyphs);

Begin
    If Value < 0 Then
        Value := 1
    Else
    If Value > 4 Then
        Value := 4;

    If Value <> TButtonGlyph(FGlyph).NumGlyphs Then
    Begin
        TButtonGlyph(FGlyph).NumGlyphs := Value;
        Invalidate;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.GlyphChanged(Sender: TObject);

Begin
    Invalidate;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.UpdateExclusive;

Var Msg: TMessage;

Begin
    If (FGroupIndex <> 0) And (Parent <> Nil) Then
    Begin
        Msg.Msg := CM_BUTTONPRESSED;
        Msg.WParam := FGroupIndex;
        Msg.LParam := Longint(Self);
        Msg.Result := 0;
        Parent.Broadcast(Msg);
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetDown(Value: Boolean);

Begin
    If FGroupIndex = 0 Then
        Value := False;
    If Value <> FDown Then
    Begin
        If FDown And (Not FAllowAllUp) Then
            Exit;
        FDown := Value;
        If Value Then
        Begin
            If FState = bsUp Then
                Invalidate;
            FState := bsExclusive;
        End
        Else
        Begin
            FState := bsUp;
            Repaint;
        End;
        If Value Then
            UpdateExclusive;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetFlat(Value: Boolean);

Begin
    If Value <> FFlat Then
    Begin
        FFlat := Value;
        If Value Then
            ControlStyle := ControlStyle - [csOpaque]
        Else ControlStyle := ControlStyle + [csOpaque];
        Invalidate;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetGroupIndex(Value: Integer);

Begin
    If FGroupIndex <> Value Then
    Begin
        FGroupIndex := Value;
        UpdateExclusive;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetLayout(Value: TButtonLayout);

Begin
    If FLayout <> Value Then
    Begin
        FLayout := Value;
        Invalidate;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetMargin(Value: Integer);

Begin
    If (Value <> FMargin) And (Value >= -1) Then
    Begin
        FMargin := Value;
        Invalidate;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetSpacing(Value: Integer);

Begin
    If Value <> FSpacing Then
    Begin
        FSpacing := Value;
        Invalidate;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetAllowAllUp(Value: Boolean);

Begin
    If FAllowAllUp <> Value Then
    Begin
        FAllowAllUp := Value;
        UpdateExclusive;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPopup.WMActivateApp(Var Message: TWMActivateApp);

Begin
    Inherited;
    If Not Message.Active Then
        EndSelection(True);
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.WMLButtonDblClk(Var Message: TWMLButtonDown);

Begin
    Inherited;
    If FDown Then
        DblClick;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.CMEnabledChanged(Var Message: TMessage);

Const NewState: Array[Boolean] Of TButtonState = (bsDisabled, bsUp);

Begin
    TButtonGlyph(FGlyph).CreateButtonGlyph(NewState[Enabled]);
    UpdateTracking;
    Repaint;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.CMButtonPressed(Var Message: TMessage);

Var Sender: TColorPickerButton;

Begin
    If Message.WParam = FGroupIndex Then
    Begin
        Sender := TColorPickerButton(Message.LParam);
        If Sender <> Self Then
        Begin
            If Sender.Down And FDown Then
            Begin
                FDown := False;
                FState := bsUp;
                Invalidate;
            End;
            FAllowAllUp := Sender.AllowAllUp;
        End;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.CMDialogChar(Var Message: TCMDialogChar);

Begin
    With Message Do
        If IsAccel(CharCode, Caption) And
            Enabled And
            Visible And
            Assigned(Parent) And
            Parent.Showing Then
        Begin
            Click;
            Result := 1;
        End
        Else Inherited;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.CMFontChanged(Var Message: TMessage);

Begin
    Invalidate;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.CMTextChanged(Var Message: TMessage);

Begin
    Invalidate;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.CMSysColorChange(Var Message: TMessage);

Begin
    With TButtonGlyph(FGlyph) Do
    Begin
        Invalidate;
        CreateButtonGlyph(FState);
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.CMMouseEnter(Var Message: TMessage);

Begin
    Inherited;
    If FFlat And Not FMouseInControl And Enabled Then
    Begin
        FMouseInControl := True;
        Repaint;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.CMMouseLeave(Var Message: TMessage);

Begin
    Inherited;
    If FFlat And FMouseInControl And Enabled And Not FDragging Then
    Begin
        FMouseInControl := False;
        Invalidate;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetDroppedDown(Const Value: Boolean);

Var Allowed: Boolean;

Begin
    If FDroppedDown <> Value Then
    Begin
        Allowed := True;
        If Assigned(FOnDropChanging) Then
            FOnDropChanging(Self, Allowed);
        If Allowed Then
        Begin
            FDroppedDown := Value;
            If FDroppedDown Then
            Begin
                FState := bsDown;
                TColorPopup(FColorPopup).SelectedColor := FSelectionColor;
                TColorPopup(FColorPopup).ShowPopupAligned;
                SetCapture(FPopupWnd);
            End
            Else
            Begin
                FState := bsUp;
                ReleaseCapture;
                ShowWindow(FColorPopup.Handle, SW_HIDE);
            End;
            If Assigned(FOnDropChanged) Then
                FOnDropChanged(Self);
            Invalidate;
        End;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetSelectionColor(Const Value: TColor);

Begin
    If FSelectionColor <> Value Then
    Begin
        FSelectionColor := Value;
        Invalidate;
        If FDroppedDown Then
            TColorPopup(FColorPopup).SelectColor(Value);
        If Assigned(FOnChange) Then
            FOnChange(Self);
    End;
End;

//-----------------------------------------------------------------------------

Function TColorPickerButton.GetCustomText: String;

Begin
    Result := TColorPopup(FColorPopup).FCustomText;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetCustomText(Const Value: String);

Begin
    With TColorPopup(FColorPopup) Do
    Begin
        If FCustomText <> Value Then
        Begin
            FCustomText := Value;
            If (FCustomText = '') And (FSelectedIndex = CustomCell) Then
                FSelectedIndex := NoCell;
            AdjustWindow;
            If FDroppedDown Then
            Begin
                Invalidate;
                ShowPopupAligned;
            End;
        End;
    End;
End;

//-----------------------------------------------------------------------------

Function TColorPickerButton.GetDefaultText: String;

Begin
    Result := TColorPopup(FColorPopup).FDefaultText;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetDefaultText(Const Value: String);

Begin
    If TColorPopup(FColorPopup).FDefaultText <> Value Then
    Begin
        With TColorPopup(FColorPopup) Do
        Begin
            FDefaultText := Value;
            AdjustWindow;
            If FDroppedDown Then
            Begin
                Invalidate;
                ShowPopupAligned;
            End;
        End;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetShowSystemColors(Const Value: Boolean);

Begin
    With TColorPopup(FColorPopup) Do
    Begin
        If FShowSysColors <> Value Then
        Begin
            FShowSysColors := Value;
            AdjustWindow;
            If FDroppedDown Then
            Begin
                Invalidate;
                ShowPopupAligned;
            End;
        End;
    End;
End;

//-----------------------------------------------------------------------------

Function TColorPickerButton.GetShowSystemColors: Boolean;

Begin
    Result := TColorPopup(FColorPopup).FShowSysColors;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetTransparent(Const Value: Boolean);

Begin
    If Value <> FTransparent Then
    Begin
        FTransparent := Value;
        If Value Then
            ControlStyle := ControlStyle - [csOpaque]
        Else ControlStyle := ControlStyle + [csOpaque];
        Invalidate;
    End;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);

  //--------------- local functions -----------------------

    Procedure CopyImage(ImageList: TCustomImageList; Index: Integer);

    Begin
        With Glyph Do
        Begin
            Width := ImageList.Width;
            Height := ImageList.Height;
            Canvas.Brush.Color := clFuchsia;//! for lack of a better color
            Canvas.FillRect(Rect(0, 0, Width, Height));
            ImageList.Draw(Canvas, 0, 0, Index);
        End;
    End;

  //--------------- end local functions -------------------

Begin
    Inherited ActionChange(Sender, CheckDefaults);
    If Sender Is TCustomAction Then
        With TCustomAction(Sender) Do
        Begin
      // Copy image from action's imagelist
            If Glyph.Empty And
                Assigned(ActionList) And
                Assigned(ActionList.Images) And
                (ImageIndex >= 0) And
                (ImageIndex < ActionList.Images.Count) Then
                CopyImage(ActionList.Images, ImageIndex);
        End;
End;

//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetIndicatorBorder(Const Value: TIndicatorBorder);

Begin
    If FIndicatorBorder <> Value Then
    Begin
        FIndicatorBorder := Value;
        Invalidate;
    End;
End;

//-----------------------------------------------------------------------------

Function TColorPickerButton.GetPopupSpacing: Integer;

Begin
    Result := TColorPopup(FColorPopup).Spacing;
End;

//-----------------------------------------------------------------------------

Procedure TColorPickerButton.SetPopupSpacing(Const Value: Integer);

Begin
    TColorPopup(FColorPopup).Spacing := Value;
End;

//-----------------------------------------------------------------------------

End.
