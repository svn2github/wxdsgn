{
    $Id: main.pas 741 2006-12-18 04:48:06Z lowjoel $

    This file is part of wxDev-C++
    Copyright (c) 2006 wxDev-C++ Developers

    wxDev-C++ is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.
    
    wxDev-C++ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Dev-C++; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

unit devDockStyle;

interface
uses
  {$IFNDEF COMPILER_7_UP}TmSchema,{$ENDIF} JvDockVSNetStyle, JvDockTree, Windows,
  Messages, Classes, Graphics, Controls;

type
  TdevDockTree = class(TJvDockVSNETTree)
  protected
    AutoHideButtonWidth: Integer;
    AutoHideButtonHeight: Integer;
    procedure DrawDockGrabber(Control: TControl; const aRect: TRect); override;
    procedure DrawAutoHideButton(Zone: TJvDockZone; Left, Top: Integer); override;
    procedure DrawCloseButton(Canvas: TCanvas; Zone: TJvDockZone; Left, Top: Integer); override;
    function GetTopGrabbersHTFlag(const MousePos: TPoint; out HTFlag: Integer; Zone: TJvDockZone): TJvDockZone; override;
  public
    constructor Create(DockSite: TWinControl; DockZoneClass: TJvDockZoneClass;
                       ADockStyle: TJvDockObservableStyle); override;
  end;
  
  TdevDockTabPanel = class(TJvDockVSNETTabPanel)
  public
    constructor Create(AOwner: TComponent); override;
  private
    property TabSplitterWidth default 0;

  protected
    procedure Paint; override;
    property TabLeftOffset default 0;
    property TabRightOffset default 0;
    property TabTopOffset default 0;
  end;

  TdevDockTabPageControl = class(TJvDockVSNETTabPageControl)
  protected
    procedure CreatePanel; override;
    
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TdevDockTabSheet = class(TJvDockVSNETTabSheet)
  public
    property ShowTabWidth;
  end;

  TdevDockChannel = class(TJvDockVSChannel)
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TdevDockPanel = class(TJvDockVSNETPanel)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TdevDockStyle = class(TJvDockVSNetStyle)
  private
    fNativeDocks: Boolean;
    procedure SetNativeDocks(NativeDocks: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    property NativeDocks: Boolean read fNativeDocks write SetNativeDocks default True;
  end;

implementation
uses
  ComCtrls, UxTheme, JvDockVIDStyle, Dialogs, Forms, StrUtils, SysUtils,
  JvDockControlForm, JvDockGlobals;

type
  TJvDockVSNETZoneAccess = class(TJvDockVSNETZone);

procedure RotateBitmap(var src: TBitmap; degrees : integer);
var
  Result: TBitmap;
  X, Y: Integer;
begin
  while degrees > 360 do
    Dec(degrees, 360);

  Result := TBitmap.Create;
  case degrees of
    0:
      Exit;

    90:
    begin
      Result.Width := src.Height;
      Result.Height := src.Width;
      for X := 0 to src.Width do
        for Y := 0 to src.Height do
          BitBlt(Result.Canvas.Handle, Y, X, 1, 1, src.Canvas.Handle,
                 X, Y, SRCCOPY);
    end;

    180:
    begin
      Result.Width := src.Width;
      Result.Height := src.Height;
      for X := 0 to src.Width do
        for Y := 0 to src.Height do
          BitBlt(Result.Canvas.Handle, src.Width - X - 1, src.Height - Y - 1, 1, 1,
                 src.Canvas.Handle, X, Y, SRCCOPY);
   end;

    270:
    begin
      Result.Width := src.Height;
      Result.Height := src.Width;
      for X := 0 to src.Width do
        for Y := 0 to src.Height do
          BitBlt(Result.Canvas.Handle, src.Height - Y - 1, src.Width - X - 1, 1, 1,
                 src.Canvas.Handle, X, Y, SRCCOPY);
    end;
  end;

  src.Free;
  src := Result;
end;

constructor TdevDockStyle.Create(AOwner: TComponent);
begin
  inherited;
  TabDockClass := TdevDockTabPageControl;
  DockPanelClass := TdevDockPanel;
  DockPanelTreeClass := TdevDockTree;
  ConjoinPanelTreeClass := TdevDockTree;
end;

procedure TdevDockStyle.SetNativeDocks(NativeDocks: Boolean);
begin
  if NativeDocks = fNativeDocks then
    Exit;
  fNativeDocks := NativeDocks;
  SendStyleEvent;
end;

constructor TdevDockTree.Create(DockSite: TWinControl; DockZoneClass: TJvDockZoneClass;
                                ADockStyle: TJvDockObservableStyle);
begin
  inherited;
  TopOffset := 3;
  ButtonSplitter := 5;
  ButtonHeight := 13;
  ButtonWidth := ButtonHeight;
  AutoHideButtonWidth := ButtonWidth;
  AutoHideButtonHeight := ButtonHeight;
end;

procedure TdevDockTree.DrawDockGrabber(Control: TControl; const aRect: TRect);
const
  ExtentStr = 'ABCDEFHXfgkjy';
var
  GrabberState: Integer;
  ThemeData: HTheme;
  DrawRect: TRect;
begin
  if (not IsThemeActive) or (not TdevDockStyle(DockStyle).NativeDocks) then
  begin
    inherited;
    Exit;
  end;

  //Decide on the state of the caption
  ThemeData := OpenThemeData(DockSite.Handle, 'WINDOW');
  if GetActiveControl = Control then
    GrabberState := CS_ACTIVE
  else
    GrabberState := CS_INACTIVE;

  //Draw the background of the caption
  if IsThemeBackgroundPartiallyTransparent(ThemeData, WP_SMALLCAPTION, GrabberState) then
    DrawThemeParentBackground(ThemeData, Canvas.Handle, @ARect);
  DrawThemeBackground(ThemeData, Canvas.Handle, WP_SMALLCAPTION, GrabberState, ARect, nil);

  //The fonts that we use should be those that the main form uses
  Canvas.Font.Assign(Application.MainForm.Font);

  //Then draw the text
  DrawRect := aRect;
  DrawRect.Left := DrawRect.Left + 6;
  DrawRect.Top := DrawRect.Top + ((GrabberSize - Canvas.TextHeight(ExtentStr)) div 2);
  DrawRect.Right := DrawRect.Right - RightOffset - ButtonWidth - ButtonSplitter - AutoHideButtonWidth;
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Style := [fsBold];
  Canvas.Font.Color := clHighlightText;
  DrawText(Canvas.Handle, PChar(TForm(Control).Caption), -1, DrawRect, DT_LEFT or DT_SINGLELINE or DT_END_ELLIPSIS);

  //Draw the pin
  if DockSite.Align <> alClient then
    DrawAutoHideButton(FindControlZone(Control), ARect.Right - RightOffset - ButtonWidth - ButtonSplitter - AutoHideButtonWidth,
                       ARect.Top + TopOffset - 2);

  //And the close button
  if ShowCloseButtonOnGrabber or not (Control is TJvDockTabHostForm) then
    DrawCloseButton(Canvas, FindControlZone(Control), ARect.Right - RightOffset - ButtonWidth, ARect.Top + TopOffset);
  CloseThemeData(ThemeData);
end;

procedure TdevDockTree.DrawAutoHideButton(Zone: TJvDockZone; Left, Top: Integer);
var
  PinState: Integer;
  ThemeData: HTheme;
  ARect: TRect;
  AZone: TJvDockVSNETZoneAccess;
begin
  if (not IsThemeActive) or (not TdevDockStyle(DockStyle).NativeDocks) then
  begin
    inherited;
    Exit;
  end;

  ThemeData := OpenThemeData(DockSite.Handle, 'EXPLORERBAR');
  AutoHideButtonHeight := ButtonHeight + 2;

  //Determine the state icon to use
  AZone := TJvDockVSNETZoneAccess(Zone);
  case AZone.AutoHideBtnState of
    JvDockVSNetStyle.bsNormal:
      PinState := EBHP_NORMAL;
    JvDockVSNetStyle.bsUp:
      PinState := EBHP_HOT;
    JvDockVSNetStyle.bsDown:
      PinState := EBHP_PRESSED;
    else
      PinState := EBHP_NORMAL;
  end;

  //Draw the pin icon
  ARect := Rect(Left, Top, Left + AutoHideButtonWidth, Top + AutoHideButtonHeight);
  if IsThemeBackgroundPartiallyTransparent(ThemeData, EBP_HEADERPIN, PinState) then
    DrawThemeParentBackground(ThemeData, Canvas.Handle, @ARect);
  DrawThemeBackground(ThemeData, Canvas.Handle, EBP_HEADERPIN, PinState, ARect, nil);
  CloseThemeData(ThemeData);
end;

procedure TdevDockTree.DrawCloseButton(Canvas: TCanvas; Zone: TJvDockZone; Left, Top: Integer);
var
  ARect: TRect;
  ButtonState: Integer;
  ThemeData: HTHEME;
  AZone: TJvDockVSNETZoneAccess;
  ADockClient: TJvDockClient;
begin
  if (not IsThemeActive) or (not TdevDockStyle(DockStyle).NativeDocks) then
  begin
    inherited;
    Exit;
  end;

  ThemeData := OpenThemeData(DockSite.Handle, 'WINDOW');
  AZone := TJvDockVSNETZoneAccess(Zone);
  if AZone <> nil then
  begin
    ADockClient := FindDockClient(Zone.ChildControl);
    if (ADockClient <> nil) and not ADockClient.EnableCloseButton then
      Exit;

    //Determine the state of the button
    case AZone.CloseBtnState of
      JvDockVSNETStyle.bsUp:
        ButtonState := CBS_HOT;
      JvDockVSNETStyle.bsNormal:
        ButtonState := CBS_NORMAL;
      JvDockVSNETStyle.bsDown:
        ButtonState := CBS_PUSHED;
      else
        ButtonState := CBS_NORMAL;
    end;

    ARect := Rect(Left, Top, Left + ButtonWidth, Top + ButtonHeight);
    if IsThemeBackgroundPartiallyTransparent(ThemeData, WP_SMALLCLOSEBUTTON, ButtonState) then
      DrawThemeParentBackground(ThemeData, Canvas.Handle, @ARect);
    DrawThemeBackground(ThemeData, Canvas.Handle, WP_SMALLCLOSEBUTTON, ButtonState, ARect, nil);
  end;
  CloseThemeData(ThemeData);
end;

function TdevDockTree.GetTopGrabbersHTFlag(const MousePos: TPoint;
  out HTFlag: Integer; Zone: TJvDockZone): TJvDockZone;
begin
  Result := inherited GetTopGrabbersHTFlag(MousePos, HTFlag, Zone);
  if (Zone <> nil) and (DockSite.Align <> alClient) and (HTFlag = HTAUTOHIDE) then
    with Zone.ChildControl do
      if PtInRect(Rect(
        Left + Width - AutoHideButtonWidth - ButtonWidth - RightOffset - ButtonSplitter,
        Top - GrabberSize + TopOffset - 1,
        Left + Width - AutoHideButtonWidth - RightOffset - ButtonSplitter,
        Top - GrabberSize + TopOffset + AutoHideButtonHeight - 2), MousePos) then
        HTFlag := HTAUTOHIDE
      else
        HTFlag := 0;
end;

constructor TdevDockTabPanel.Create(AOwner: TComponent);
begin
  inherited;
  DoubleBuffered := True;
  
  CaptionTopOffset := 0;
  CaptionLeftOffset := 5;
  CaptionRightOffset := 5;
  TabBottomOffset := 0;
  TabTopOffset := 0;
  TabSplitterWidth := 0;
  TabHeight := 22;
end;

procedure TdevDockTabPanel.Paint;
var
  IconPoint: TPoint;
  ARect, TabRect, LblRect: TRect;
  I, CurrTabWidth, CompleteWidth, ImageWidth: Integer;

  ThemeData: HTheme;
  TabState: Integer;
  Tab: TBitmap;
begin
  if Page = nil then
    Exit;

  //See if we should revert to the default implementation
  if not IsThemeActive then
  begin
    inherited;
    Exit;
  end;

  ThemeData := OpenThemeData(Handle, 'TAB');
  if (Page.Images <> nil) and (Page.ShowTabImages) then
    ImageWidth := Page.Images.Width
  else
    ImageWidth := 0;

  CompleteWidth := 0;
  Tab := TBitmap.Create;

  //First begin by flooding the whole area with the background colour
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(Rect(0, 0, Width, Height));
  Canvas.Brush.Style := bsClear;
  
  for I := 0 to Page.Count - 1 do
  begin
    if not Page.Pages[I].TabVisible then
      Continue;

    //Calculate the values for this tab
    CurrTabWidth := TdevDockTabSheet(Page.Pages[I]).ShowTabWidth;
    Tab.Width := CurrTabWidth;
    Tab.Height := PanelHeight - TabTopOffset;

    //Create the rectangle the tab to be drawn on
    case Page.TabPosition of
      tpLeft:
      begin
        TabRect := Rect(TabTopOffset, CompleteWidth + TabLeftOffset,
                        PanelHeight, CompleteWidth + TabLeftOffset + CurrTabWidth);
        LblRect := Rect(TabTopOffset + CaptionTopOffset + 1,
                        CompleteWidth + TabLeftOffset + CaptionLeftOffset,
                        PanelHeight,
                        CompleteWidth + TabLeftOffset + CurrTabWidth - CaptionRightOffset);
        IconPoint := Point(CompleteWidth + TabLeftOffset + CaptionLeftOffset,
                       TabBottomOffset + CaptionTopOffset + 1);
      end;

      tpRight:
      begin
        TabRect := Rect(TabBottomOffset, CompleteWidth + TabLeftOffset,
                      PanelHeight - TabTopOffset,
                      CompleteWidth + TabLeftOffset + CurrTabWidth);
        LblRect := Rect(TabBottomOffset + CaptionTopOffset + 1,
                       CompleteWidth + TabLeftOffset + CaptionLeftOffset,
                       PanelHeight,
                       CompleteWidth + TabLeftOffset + CurrTabWidth - CaptionRightOffset);
        IconPoint := Point(CompleteWidth + TabLeftOffset + CaptionLeftOffset,
                       TabBottomOffset + CaptionTopOffset + 1);
      end;

      tpTop:
      begin
        TabRect := Rect(CompleteWidth + TabLeftOffset, TabTopOffset,
                       CompleteWidth + TabLeftOffset + CurrTabWidth, PanelHeight);
        LblRect := Rect(CompleteWidth + TabLeftOffset + CaptionLeftOffset +
                       Integer(ShowTabImages) * (ImageWidth + CaptionLeftOffset),
                       TabTopOffset + CaptionTopOffset + 5,
                       CompleteWidth + TabLeftOffset + CurrTabWidth - CaptionRightOffset,
                       PanelHeight);
        IconPoint := Point(CompleteWidth + TabLeftOffset + CaptionLeftOffset,
                           TabBottomOffset + CaptionTopOffset + 5);
      end;
      
      tpBottom:
      begin
        TabRect := Rect(CompleteWidth + TabLeftOffset, TabBottomOffset,
                      CompleteWidth + TabLeftOffset + CurrTabWidth,
                      CompleteWidth + TabLeftOffset + Tab.Height);
        LblRect := Rect(CompleteWidth + TabLeftOffset + CaptionLeftOffset +
                       Integer(ShowTabImages) * (ImageWidth + CaptionLeftOffset),
                       TabBottomOffset + CaptionTopOffset + 1,
                       CompleteWidth + TabLeftOffset + CurrTabWidth - CaptionRightOffset,
                       PanelHeight);
        IconPoint := Point(CompleteWidth + TabLeftOffset + CaptionLeftOffset,
                           TabBottomOffset + CaptionTopOffset + 1);
      end;
    end;

    //Select the state of the image to be drawn
    if Page.ActivePageIndex = I then
    begin
      TabState := TIS_SELECTED;
      case Page.TabPosition of
        tpTop:
        begin
          LblRect.Top := LblRect.Top - 1;
          IconPoint.Y := IconPoint.Y - 1;
        end;
        tpLeft,
        tpBottom:
        begin
          LblRect.Top := LblRect.Top + 1;
          IconPoint.Y := IconPoint.Y + 1;
        end;
      end;
    end
    else
    begin
      case Page.TabPosition of
        tpTop:
        begin
          Tab.Height := Tab.Height - 2;
          TabRect.Top := TabRect.Top + 2;
        end;
        tpBottom:
        begin
          Tab.Height := Tab.Height - 2;
          TabRect.Bottom := TabRect.Bottom - 2;
        end;
      end;

      if SelectHotIndex = I then
        TabState := TIS_HOT
      else
        TabState := TIS_NORMAL;
    end;

    //Draw the image unto the bitmap
    ARect := Rect(0, 0, Tab.Width, Tab.Height);
    if IsThemeBackgroundPartiallyTransparent(ThemeData, TABP_TABITEM, TabState) then
      DrawThemeParentBackground(Handle, Tab.Canvas.Handle, @ARect);
    DrawThemeBackground(ThemeData, Tab.Canvas.Handle, TABP_TABITEM, TabState, ARect, nil);

    //Blit the rotated bitmap unto our canvas
    case Page.TabPosition of
      tpLeft:
        RotateBitmap(Tab, 90);
      tpBottom:
        RotateBitmap(Tab, 180);
      tpRight:
        RotateBitmap(Tab, 270);
    end;
    BitBlt(Canvas.Handle, TabRect.Left, TabRect.Top, TabRect.Right - TabRect.Left,
           TabRect.Bottom - TabRect.Top, Tab.Canvas.Handle, 0, 0, SRCCopy);

    //Draw the caption
    DrawThemeText(ThemeData, Canvas.Handle, TABP_TABITEM, TabState,
      PWideChar(WideString(Page.Pages[I].Caption)), -1,
      DT_LEFT or DT_SINGLELINE or DT_END_ELLIPSIS, 0, LblRect);

    //As well as the tab images
    if ShowTabImages and (Page.Images <> nil) and (CurrTabWidth > ImageWidth + 2 * CaptionLeftOffset) then
      Page.Images.Draw(Canvas, IconPoint.X, IconPoint.Y, Page.Pages[I].ImageIndex, True);

    Inc(CompleteWidth, CurrTabWidth);
  end;

  //Free our bitmap
  Tab.Destroy;
  CloseThemeData(ThemeData);
end;

constructor TdevDockTabPageControl.Create(AOwner: TComponent);
begin
  inherited;
  TabSheetClass := TJvDockVSNETTabSheet;
  TabPanelClass := TdevDockTabPanel;
  HotTrack := True;
end;

procedure TdevDockTabPageControl.CreatePanel;
begin
  if FPanel = nil then
  begin
    FPanel := TabPanelClass.Create(Self);
    FPanel.Page := Self;
    FPanel.Parent := Self;
  end;
  Resize;
end;

constructor TdevDockPanel.Create(AOwner: TComponent);
begin
  inherited;
  VSChannelClass := TdevDockChannel;
end;

constructor TdevDockChannel.Create(AOwner: TComponent);
begin
  inherited;
  ChannelWidth := 23;
end;

procedure TdevDockChannel.Paint;
var
  I: Integer;
  ThemeData: HTheme;
  Tab: TBitmap;
  
  procedure DrawSingleBlock(Block: TJvDockVSBlock);
  var
    Bmp: TBitmap;
    ARect: TRect;
    DrawRect: TRect;
    I: Integer;
    OldGraphicsMode: Integer;

    TabState: Integer;
  begin
    for I := 0 to Block.VSPaneCount - 1 do
    begin
      if not Block.VSPane[I].Visible then
        Continue;

      //Calculate the values for this tab
      GetBlockRect(Block, I, DrawRect);
      case Align of
        alLeft, alRight:
        begin
          Tab.Width := DrawRect.Bottom - DrawRect.Top;
          Tab.Height := DrawRect.Right - DrawRect.Left;
        end;
        alBottom, alTop:
        begin
          Tab.Width := DrawRect.Right - DrawRect.Left;
          Tab.Height := DrawRect.Bottom - DrawRect.Top;
        end;
      end;
      
      //Select the state of the image to be drawn
      if Block.ActivePane = Block.VSPane[I] then
        TabState := TIS_SELECTED
      else
      begin
        Tab.Height := Tab.Height - 2;
        case Align of
          alLeft: Dec(DrawRect.Right, 2);
          alRight: Inc(DrawRect.Left, 2);
          alBottom: Inc(DrawRect.Top, 2);
          alTop: Dec(DrawRect.Bottom, 2);
        end;

        TabState := TIS_NORMAL;
      end;

      //Draw the image unto the bitmap
      ARect := Rect(0, 0, Tab.Width, Tab.Height);
      if IsThemeBackgroundPartiallyTransparent(ThemeData, TABP_TABITEM, TabState) then
        DrawThemeParentBackground(Handle, Tab.Canvas.Handle, @ARect);
      DrawThemeBackground(ThemeData, Tab.Canvas.Handle, TABP_TABITEM, TabState, ARect, nil);

      //Blit the rotated bitmap unto our canvas
      case Align of
        alTop:
          RotateBitmap(Tab, 180);
        alRight:
          RotateBitmap(Tab, 90);
        alLeft:
          RotateBitmap(Tab, 270);
      end;
      BitBlt(Canvas.Handle, DrawRect.Left, DrawRect.Top, DrawRect.Right - DrawRect.Left,
             DrawRect.Bottom - DrawRect.Top, Tab.Canvas.Handle, 0, 0, SRCCopy);

      //See if we are able to get a bitmap for the current tab
      Bmp := TBitmap.Create;
      if Block.ImageList.GetBitmap(I, Bmp) then
        Block.ImageList.Draw(Canvas, DrawRect.Left + 3, DrawRect.Top + 3, I);

      if Align in [alTop, alBottom] then
      begin
        Inc(DrawRect.Left, 6 + Bmp.Width);
        if Align = alBottom then
          Inc(DrawRect.Top, 3);
      end
      else if Align in [alLeft, alRight] then
      begin
        Inc(DrawRect.Top, 6 + Bmp.Height);
        if Align = alLeft then
          DrawRect.Left := 15
        else
          DrawRect.Left := 20;
        DrawRect.Right := DrawRect.Left + (DrawRect.Bottom - DrawRect.Top);
      end;

      Canvas.Font.Assign(Application.MainForm.Font);
      Canvas.Brush.Color := TabColor;
      Canvas.Pen.Color := clBlack;

      Dec(DrawRect.Right, 3);
      OldGraphicsMode := SetGraphicsMode(Canvas.Handle, GM_ADVANCED);
      Canvas.Brush.Style := bsClear;
      DrawText(Canvas.Handle, PChar(Block.VSPane[I].DockForm.Caption), -1, DrawRect, DT_END_ELLIPSIS or DT_NOCLIP);
      SetGraphicsMode(Canvas.Handle, OldGraphicsMode);
      Bmp.Free;
    end;
    CurrentPos := CurrentPos + BlockInterval;
  end;

begin
  //See if we can acquire a handle to our theme, if not, revert to our old
  //implementation
  if not IsThemeActive then
  begin
    inherited;
    Exit;
  end;

  //Create our temporal bitmap
  ThemeData := OpenThemeData(Handle, 'TAB');
  Tab := TBitmap.Create;
  CurrentPos := BlockStartOffset;

  //Flood the canvas
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(Rect(0, 0, Width, Height));
  Canvas.Brush.Style := bsClear;

  //Draw all the tabs
  for I := 0 to BlockCount - 1 do
    DrawSingleBlock(Block[I]);

  //Free our bitmap
  Tab.Destroy;
  CloseThemeData(ThemeData);
end;

end.
