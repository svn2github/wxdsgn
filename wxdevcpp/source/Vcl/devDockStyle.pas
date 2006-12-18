unit devDockStyle;

interface
uses
  JvDockVSNetStyle, Classes;

type
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
  end;

  TdevDockPanel = class(TJvDockVSNETPanel)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TdevDockStyle = class(TJvDockVSNetStyle)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation
uses
  ComCtrls, Windows, Graphics, UxTheme, JvDockVIDStyle, madStackTrace, dialogs,
  Dbugintf, Controls;

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
  ThemeData := OpenThemeData(Handle, 'TAB');
  if ThemeData = HTheme(nil) then
  begin
    inherited;
    Exit;
  end;

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
    IconPoint := Point(CompleteWidth + TabLeftOffset + CaptionLeftOffset,
                 TabBottomOffset + CaptionTopOffset + 1);
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
      end;

      tpTop:
      begin
        TabRect := Rect(CompleteWidth + TabLeftOffset, TabTopOffset,
                       CompleteWidth + TabLeftOffset + CurrTabWidth, PanelHeight);
        LblRect := Rect(CompleteWidth + TabLeftOffset + CaptionLeftOffset +
                       Integer(ShowTabImages) * (ImageWidth + CaptionLeftOffset),
                       TabTopOffset + CaptionTopOffset + 1,
                       CompleteWidth + TabLeftOffset + CurrTabWidth - CaptionRightOffset,
                       PanelHeight);
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
      end;
    end;
    
    //Select the state of the image to be drawn
    if Page.ActivePageIndex = I then
    begin
      TabState := TIS_SELECTED;
      LblRect.Top := LblRect.Top + 1;
      IconPoint.Y := IconPoint.Y + 1;
    end
    else
    begin
      Tab.Height := Tab.Height - 2;
      TabRect.Bottom := TabRect.Bottom - 2;
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
    RotateBitmap(Tab, 180);
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

procedure TdevDockChannel.Paint;
var
  I: Integer;
  ThemeData: HTheme;
  Tab: TBitmap;
  
  procedure DrawSingleBlock(Block: TJvDockVSBlock);
  var
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

      if Align in [alTop, alBottom] then
      begin
        Inc(DrawRect.Left, 6);
        if Align = alBottom then
          Inc(DrawRect.Top, 3);
      end
      else if Align in [alLeft, alRight] then
      begin
        Inc(DrawRect.Top, 6);
        if Align = alLeft then
          DrawRect.Left := 15
        else
          DrawRect.Left := 20;
        DrawRect.Right := DrawRect.Left + (DrawRect.Bottom - DrawRect.Top);
      end;
      
      Canvas.Brush.Color := TabColor;
      Canvas.Pen.Color := clBlack;

      Dec(DrawRect.Right, 3);
      OldGraphicsMode := SetGraphicsMode(Canvas.Handle, GM_ADVANCED);
      Canvas.Brush.Style := bsClear;
      DrawText(Canvas.Handle, PChar(Block.VSPane[I].DockForm.Caption), -1, DrawRect, DT_END_ELLIPSIS or DT_NOCLIP);
      SetGraphicsMode(Canvas.Handle, OldGraphicsMode);
    end;
    CurrentPos := CurrentPos + BlockInterval;
  end;

begin
  //See if we can acquire a handle to our theme, if not, revert to our old
  //implementation
  ThemeData := OpenThemeData(Handle, 'TAB');
  if ThemeData = HTheme(nil) then
  begin
    inherited;
    Exit;
  end;

  //Create our temporal bitmap
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
end;

end.
