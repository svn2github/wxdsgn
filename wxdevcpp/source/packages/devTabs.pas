{
    This file is part of Dev-C++
    Copyright (c) 2004 Bloodshed Software

    Dev-C++ is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Dev-C++ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Dev-C++; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

(*
 devTabs: reimplementation of TabControl from Gavina UI pack.
*)
unit devTabs;

interface

uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ImgList;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QImgList, Types;
{$ENDIF}

type
    TdevTabOrientation = (toTop, toBottom);

    TdevTabChangingEvent = procedure(Sender: TObject; NewIndex: integer; var AllowChange: boolean) of object;
    TdevTabMovedEvent = procedure(Sender: TObject; OldIndex, NewIndex: integer) of object;

    TdevTabGetImageEvent = procedure(Sender: TObject; TabIndex: integer; var ImageIndex: integer) of object;

    TdevCustomTabs = class(TCustomControl)
    private
        FOrientation: TdevTabOrientation;
        FLeftMargin: integer;
        FRightMargin: integer;
        FTabMargin: integer;
        FTabs: TStrings;
        FTabIndex: integer;
        FTabHeight: integer;
        FBackTextColor: TColor;
        FBackColor: TColor;
        FAMList: TList;
        FImageChangeLink: TChangeLink;
        FImages: TCustomImageList;
        FStarted: boolean;
        FOnMoved: TdevTabMovedEvent;
        FOnChanging: TdevTabChangingEvent;
        FOnTabDrag: TNotifyEvent;
        FOnGetImage: TdevTabGetImageEvent;
        fOnChange: TNotifyEvent;
        FTabHidden: boolean;
        function GetTabHidden: boolean;
        function ClippedTabAtPos(Pos: TPoint; var AIndex: integer): boolean;
        function IntTabAtPos(Pos: TPoint; AList: TList): integer;
        function CalcTabWidth(AOriginal: TList): TList;
        procedure SetBackTextColor(Value: TColor);
        procedure SetBackColor(Value: TColor);
        procedure SetLeftMargin(Value: integer);
        procedure SetRightMargin(Value: integer);
        procedure SetTabIndex(Value: integer);
        procedure SetTabMargin(Value: integer);
        procedure SetTabs(Value: TStrings);
        procedure SetOrientation(Value: TdevTabOrientation);
        procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
        procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
        procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
        procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
        procedure WMSize(var Message: TWMSize); message WM_SIZE;
        function GetAutoMove: boolean;
        procedure SetAutoMove(Value: boolean);
        procedure ResetAutoMove;
        procedure CalcTabHeight;
        procedure AdjustTabs;
        procedure GetTabArea(var ARect: TRect);
        procedure GetTabRect(var ARect: TRect);
        procedure SetImages(Value: TCustomImageList);
        procedure ImageListChanged(Sender: TObject);
        procedure SetTabHidden(Value: boolean);
        procedure Change;
    protected
        procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer); override;
        procedure MouseMove(Shift: TShiftState; X, Y: integer); override;
        procedure CreateParams(var Params: TCreateParams); override;
        procedure BeginTabDrag; dynamic;
        procedure AdjustClientRect(var ARect: TRect); override;
        procedure Paint; override;
        procedure Moved(AFrom, ATo: integer); dynamic;
        function GetTabBrush: THandle; virtual;
        function GetTabEnabled(TabIndex: integer): boolean; virtual;
        function GetImageIndex(TabIndex: integer): integer; virtual;
        function CanChange(NewIndex: integer): boolean; dynamic;
        function TabAtPos(Pos: TPoint): integer;
        function TabRect(Item: integer): TRect;
        property OnMoved: TdevTabMovedEvent read FOnMoved write FOnMoved;
        property OnChange: TNotifyEvent read fOnChange write fOnChange;
        property OnChanging: TdevTabChangingEvent read FOnChanging write FOnChanging;
        property OnGetImageIndex: TdevTabGetImageEvent read FOnGetImage write FOnGetImage;
        property OnTabDrag: TNotifyEvent read FOnTabDrag write FOnTabDrag;
        property AutoMove: boolean read GetAutoMove write SetAutoMove default FALSE;
        property LeftMargin: integer read FLeftMargin write SetLeftMargin default 5;
        property TabMargin: integer read FTabMargin write SetTabMargin default 4;
        property RightMargin: integer read FRightMargin write SetRightMargin default 5;
        property BackTextColor: TColor read FBackTextColor write SetBackTextColor default clBtnHighlight;
        property BackColor: TColor read FBackColor write SetBackColor default clBtnShadow;
        property Orientation: TdevTabOrientation read FOrientation write SetOrientation default toTop;
        property Tabs: TStrings read FTabs write SetTabs;
        property TabIndex: integer read FTabIndex write SetTabIndex default -1;
        property Images: TCustomImageList read FImages write SetImages;
    public
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
        procedure SelectNext(Direction: boolean);
        property TabHeight: integer read FTabHeight;
        property TabHidden: boolean read FTabHidden write SetTabHidden default FALSE;
        property Color nodefault;
        property ParentFont default TRUE;
        property ParentColor default TRUE;
    end;

    TdevTabs = class(TdevCustomTabs)
    published
        property Align;
        property AutoMove;
        property Anchors;
        property BevelEdges;
        property BevelKind;
        property BevelInner;
        property BevelOuter;
        property Constraints;
        property DragKind;
        property OnEndDock;
        property OnStartDock;
        property OnTabDrag;
        property Ctl3D;
        property Color;
        property DragCursor;
        property DragMode;
        property Enabled;
        property LeftMargin;
        property TabMargin;
        property Font;
        property Images;
        property PopupMenu;
        property RightMargin;
        property ParentColor;
        property ParentCtl3D;
        property BackTextColor;
        property BackColor;
        property Orientation;
        property Tabs;
        property TabIndex;
        property TabHidden;
        property Visible;
        property OnClick;
        property OnMoved;
        property OnChange;
        property OnChanging;
        property OnDragDrop;
        property OnDragOver;
        property OnEndDrag;
        property OnEnter;
        property OnExit;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
        property OnKeyDown;
        property OnKeyUp;
        property OnKeyPress;
        property OnStartDrag;
        property OnGetImageIndex;
    end;

    TdevPage = class;

    TdevCustomPages = class(TdevCustomTabs)
    private
        FPage: TdevPage;
        FPages: TList;
        FNewDockPage,
        FUndockingPage: TdevPage;
        function GetPage(AIndex: integer): TdevPage;
        function GetPageCount: integer;
        function GetActivePageIndex: integer;
        function GetPageFromDockClient(Client: TControl): TdevPage;
        function GetDockClientFromPage(APage: TdevPage): TControl;
        procedure SetActivePage(Value: TdevPage);
        procedure SetActivePageIndex(Value: integer);
        procedure AddPage(APage: TdevPage);
        procedure RemovePage(APage: TdevPage);
        procedure AddVisPage(APage: TdevPage);
        procedure RemoveVisPage(APage: TdevPage);
        procedure UpdatePage(APage: TdevPage);
        procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
        procedure CMDockClient(var Message: TCMDockClient); message CM_DOCKCLIENT;
        procedure CMDockNotification(var Message: TCMDockNotification); message CM_DOCKNOTIFICATION;
        procedure CMUnDockClient(var Message: TCMUnDockClient); message CM_UNDOCKCLIENT;
        procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
        procedure ChangeActive(Page: TdevPage);
    protected
        function GetTabBrush: THandle; override;
        function GetTabEnabled(ATabIndex: integer): boolean; override;
        function CanChange(NewIndex: integer): boolean; override;
        function GetImageIndex(ATabIndex: integer): integer; override;
        procedure BeginTabDrag; override;
        procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
        procedure SetChildOrder(Child: TComponent; Order: integer); override;
        procedure Moved(AFrom, ATo: integer); override;
        procedure DoAddDockClient(Client: TControl; const ARect: TRect); override;
        procedure DockOver(Source: TDragDockObject; X, Y: integer; State: TDragState; var Accept: boolean); override;
        procedure DoRemoveDockClient(Client: TControl); override;
        procedure GetSiteInfo(Client: TControl; var InfluenceRect: TRect; MousePos: TPoint; var CanDock: boolean); override;
        property Pages[AIndex: integer]: TdevPage read GetPage;
        property PageCount: integer read GetPageCount;
        property ActivePageIndex: integer read GetActivePageIndex write SetActivePageIndex;
        property ActivePage: TdevPage read FPage write SetActivePage;
    public
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
    end;

{  TImageIndex = Integer;
}
    TdevPage = class(TScrollBox)
    private
        FPages: TdevCustomPages;
        FImageIndex: TImageIndex;
        FSaveMode: TDragMode;
        FSaveDS: boolean;
        FOnShow: TNotifyEvent;
        FOnHide: TNotifyEvent;
        FTabVisible: boolean;
        function GetIndex: integer;
        procedure SetIndex(Value: integer);
        procedure SetPages(Value: TdevCustomPages);
        procedure CMVisibleChanged(var Msg: TMessage); message CM_VISIBLECHANGED;
        procedure CMTextChanged(var Msg: TMessage); message CM_TEXTCHANGED;
        procedure CMEnableChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
        procedure CMColorChanged(var Msg: TMessage); message CM_COLORCHANGED;
        procedure SetImageIndex(Value: TImageIndex);
        procedure SetTabVisible(Value: boolean);
    protected
        procedure SetParent(AParent: TWinControl); override;
        procedure CreateParams(var Params: TCreateParams); override;
    public
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
        property Pages: TdevCustomPages read FPages write SetPages;
    published
        property BevelEdges;
        property BevelKind;
        property BevelInner;
        property BevelOuter;
        property BorderStyle default bsNone;
        property PageIndex: integer read GetIndex write SetIndex stored FALSE;
        property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;
        property Enabled;
        property TabVisible: boolean read FTabVisible write SetTabVisible default TRUE;
        property Caption;
        property Color;
        property ParentColor default TRUE;
        property Font;
        property ParentFont default TRUE;
        property Ctl3D;
        property ParentCtl3D;
        property OnShow: TNotifyEvent read FOnShow write FOnShow;
        property OnHide: TNotifyEvent read FOnHide write FOnHide;
        property OnEnter;
        property OnExit;
        property OnMouseMove;
        property OnMouseDown;
        property OnMouseUp;
        property OnKeyDown;
        property OnKeyUp;
        property OnKeyPress;
        property OnResize;
        property OnEndDrag;
        property OnStartDrag;
        property OnClick;
        property OnDblClick;
    end;

    TdevPages = class(TdevCustomPages)
    public
        property Pages;
        property PageCount;
        property ActivePageIndex;
    published
        property Align;
        property AutoMove;
        property ActivePage;
        property Anchors;
        property BevelEdges;
        property BevelKind;
        property BevelInner;
        property BevelOuter;
        property Constraints;
        property DragKind;
        property OnEndDock;
        property OnStartDock;
        property Ctl3D;
        property Color;
        property DragCursor;
        property DragMode;
        property DockSite;
        property Enabled;
        property LeftMargin;
        property TabMargin;
        property Font;
        property PopupMenu;
        property RightMargin;
        property ParentColor;
        property ParentCtl3D;
        property BackTextColor;
        property BackColor;
        property Images;
        property TabHidden;
        property Orientation;
        property Visible;
        property OnClick;
        property OnChange;
        property OnChanging;
        property OnDragDrop;
        property OnDragOver;
        property OnEndDrag;
        property OnEnter;
        property OnExit;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
        property OnKeyDown;
        property OnKeyUp;
        property OnKeyPress;
        property OnStartDrag;
        property OnResize;
    end;

function ExtractCaption(AControl: TControl): string;

implementation

function Min(A, B: integer): integer;
begin
    if A < B then
        Result := A else Result := B;
end;

function Max(A, B: integer): integer;
begin
    if A > B then
        Result := A else Result := B;
end;

type
    TdevTabItems = class(TStringList)
    private
        FTabs: TdevCustomTabs;
        procedure UpdateTabs(ACount: integer);
    public
        constructor Create(ATabs: TdevCustomTabs);
        function Add(const S: string): integer; override;
        procedure Insert(Index: integer; const S: string); override;
        procedure Delete(Index: integer); override;
        procedure Put(Index: integer; const S: string); override;
        procedure Clear; override;
        procedure AddStrings(Strings: TStrings); override;
    end;

{ TdevTabItems }

procedure TdevTabItems.UpdateTabs(ACount: integer);
begin
    if Count = ACount then
        FTabs.AdjustTabs
    else FTabs.Invalidate;
end;

function TdevTabItems.Add(const S: string): integer;
begin
    Result := inherited Add(S);
    UpdateTabs(1);
end;

procedure TdevTabItems.Insert(Index: integer; const S: string);
begin
    inherited Insert(Index, S);
    if Index <= FTabs.FTabIndex then
        Inc(FTabs.FTabIndex);
    UpdateTabs(1);
end;

procedure TdevTabItems.Delete(Index: integer);
var
    OldIndex: integer;
begin
    OldIndex := FTabs.TabIndex;
    inherited Delete(Index);
    if Index <= OldIndex then
        Dec(FTabs.FTabIndex);
    FTabs.FTabIndex := Min(Max(0, FTabs.TabIndex), Count - 1);
    UpdateTabs(0);
    if (OldIndex = Index) then
        FTabs.Click;
    FTabs.ResetAutoMove;
end;

procedure TdevTabItems.Put(Index: integer; const S: string);
begin
    inherited Put(Index, S);
    FTabs.Invalidate;
end;

procedure TdevTabItems.Clear;
begin
    inherited Clear;
    FTabs.FTabIndex := -1;
    FTabs.ResetAutoMove;
    FTabs.Invalidate;
end;

procedure TdevTabItems.AddStrings(Strings: TStrings);
begin
    BeginUpdate;
    try
        inherited AddStrings(Strings);
    finally
        EndUpdate;
    end;
end;

constructor TdevTabItems.Create(ATabs: TdevCustomTabs);
begin
    inherited Create;
    FTabs := ATabs;
end;

{ TdevCustomTabs }

constructor TdevCustomTabs.Create(AOwner: TComponent);
begin
    inherited Create(aOwner);
    FTabs := TdevTabItems.Create(Self);
    DoubleBuffered := TRUE;
    ControlStyle := [csAcceptsControls, csCaptureMouse, csDoubleClicks, csOpaque];
    Width := 185;
    Height := 21;
    ParentFont := TRUE;
    ParentColor := TRUE;
    ParentShowHint := FALSE;
    ShowHint := TRUE;
    CalcTabHeight;
    FImageChangeLink := TChangeLink.Create;
    FImageChangeLink.OnChange := ImageListChanged;
    FTabIndex := -1;
    FTabMargin := 4;
    FLeftMargin := 5;
    FRightMargin := 5;
    FBackTextColor := clBtnHighlight;
    FBackColor := clBtnShadow;
end;

destructor TdevCustomTabs.Destroy;
begin
    if Assigned(FTabs) then
        FreeAndNil(FTabs) else FTabs := NIL;
    if Assigned(FImageChangeLink) then
        FreeAndNil(FImageChangeLink)
    else FImageChangeLink := NIL;
    AutoMove := FALSE;
    inherited Destroy;
end;

procedure TdevCustomTabs.ImageListChanged(Sender: TObject);
begin
    Invalidate;
end;

function TdevCustomTabs.IntTabAtPos(Pos: TPoint; AList: TList): integer;
var
    I: integer;
    RTab: TRect;
begin
    Result := -1;
    GetTabArea(RTab);
    if (Pos.Y >= RTab.Top) and (Pos.Y < RTab.Bottom) then
    begin
        for I := 0 to AList.Count - 1 do
        begin
            RTab.Right := RTab.Left + integer(AList[I]);
            if PtInRect(RTab, Pos) then
            begin
                Result := I;
                exit;
            end;
            RTab.Left := RTab.Right;
        end;
    end;
end;

function TdevCustomTabs.ClippedTabAtPos(Pos: TPoint; var AIndex: integer): boolean;
var
    LWidth: TList;
    OWidth: TList;
begin
    Result := FALSE;
    AIndex := -1;
    if HandleAllocated then
    begin
        OWidth := TList.Create;
        try
            LWidth := CalcTabWidth(OWidth);
            try
                AIndex := IntTabAtPos(Pos, LWidth);
                if AIndex >= 0
                then
                    Result := OWidth.IndexOf(Pointer(AIndex)) >= 0;
            finally
                LWidth.Free;
            end;
        finally
            OWidth.Free;
        end;
    end;
end;

function TdevCustomTabs.TabAtPos(Pos: TPoint): integer;
begin
    ClippedTabAtPos(Pos, Result);
end;

procedure TdevCustomTabs.GetTabRect(var ARect: TRect);
begin
    Windows.GetClientRect(Handle, ARect);
    if FOrientation = toTop then
        ARect.Bottom := ARect.Top + FTabHeight
    else ARect.Top := ARect.Bottom - FTabHeight;
end;

procedure TdevCustomTabs.GetTabArea(var ARect: TRect);
begin
    GetTabRect(ARect);
    InflateRect(ARect, -1, -1);
    if Orientation = toTop then
        Inc(ARect.Top, 3)
    else Dec(ARect.Bottom, 3);
    Inc(ARect.Left, LeftMargin);
end;

function TdevCustomTabs.TabRect(Item: integer): TRect;
var
    I: integer;
    RTab: TRect;
    LWidth: TList;
begin
    if not GetTabHidden and (Item >= 0) and (Item < Tabs.Count) then
    begin
        GetTabArea(RTab);
        LWidth := CalcTabWidth(NIL);
        try
            for I := 0 to Item - 1 do
                Inc(RTab.Left, integer(LWidth[I]));
            RTab.Right := RTab.Left + integer(LWidth[Item]);
            Result := RTab;
        finally
            LWidth.Free;
        end;
    end
    else Result := Rect(0, 0, 0, 0);
end;

procedure TdevCustomTabs.AdjustClientRect(var ARect: TRect);
begin
    inherited;
    if not GetTabHidden and (Tabs.Count > 0) then
        if FOrientation = toTop then
            Inc(ARect.Top, FTabHeight + 2)
        else Dec(ARect.Bottom, FTabHeight + 2);
end;

function TdevCustomTabs.CalcTabWidth(AOriginal: TList): TList;
var
    I, Image,
    OldCount,
    BigCount,
    DiffSize,
    AverSize,
    FreeSize: integer;
    MaxList: TList;
begin
    Result := TList.Create;
    FreeSize := ClientWidth - (LeftMargin + RightMargin);
    BigCount := Tabs.Count;
    if (BigCount > 0) and (FreeSize >= BigCount) then
    begin
        MaxList := TList.Create;
        try
            Canvas.Font := Font;
      // Fill the Result table
            for I := 0 to BigCount - 1 do
            begin
                Result.Add(Pointer(Canvas.TextWidth(Tabs[I]) + (TabMargin + 2) * 2));
                MaxList.Add(Pointer(I));
            end;
            if FImages <> NIL then
            begin
                Image := FImages.Width;
                for I := 0 to BigCount - 1 do
                    if GetImageIndex(I) >= 0 then
                        Result[I] := Pointer(integer(Result[I]) + Image);
            end;
      // Smart calc average
            AverSize := 0;
            OldCount := 0;
            while (BigCount > 0) and (BigCount <> OldCount) do
            begin
                AverSize := FreeSize div BigCount;
                OldCount := BigCount;
                for I := OldCount - 1 downto 0 do
                begin
                    DiffSize := integer(Result[integer(MaxList[I])]);
                    if AverSize >= DiffSize then
                    begin
                        Dec(FreeSize, DiffSize);
                        Dec(BigCount);
                        MaxList.Delete(I);
                    end;
                end;
            end;
            if BigCount > 0 then
            begin
                OldCount := (FreeSize mod AverSize) - 1;
        // adjust result table
                for I := 0 to BigCount - 1 do
                    Result[integer(MaxList[I])] := Pointer(AverSize + byte(I < OldCount));
                if AOriginal <> NIL then
                begin
                    AOriginal.Count := BigCount;
                    Move(MaxList.List^, AOriginal.List^, SizeOf(integer) * BigCount);
                end;
            end;
        finally
            MaxList.Free;
        end;
    end;
end;

procedure TdevCustomTabs.Paint;

    procedure PaintTab(AIndex: integer; const ARect: TRect; ASelected: boolean);
    var
        PR: TRect;
        II: integer;
    begin
        if ARect.Right - ARect.Left >= (TabMargin + 2) * 2 then
        begin
            PR := ARect;
            if ASelected then
            begin
                if Orientation = toTop then
                    PR.Bottom := 5000 else PR.Top := -5000;
                InflateRect(PR, 0, 1);
                DrawEdge(Canvas.Handle, PR, EDGE_RAISED, BF_RECT or BF_ADJUST);
                Windows.FillRect(Canvas.Handle, PR, GetTabBrush);
                Canvas.Font.Color := Font.Color;
            end
            else
                with Canvas do
                begin
                    Pen.Color := clBtnFace;
                    MoveTo(PR.Right, PR.Top + 2 + byte(Orientation));
                    LineTo(PR.Right, PR.Bottom - 3 + byte(Orientation));
                    Font.Color := BackTextColor;
                end;
            PR := ARect;
            InflateRect(PR, -TabMargin - 2, 0);
            if (FImages <> NIL) then
            begin
                II := GetImageIndex(AIndex);
                if II >= 0 then
                begin
                    FImages.Draw(Canvas, PR.Left - 2, PR.Top, II, GetTabEnabled(AIndex));
                    Inc(PR.Left, FImages.Width);
                end;
            end;
            SetBkMode(Canvas.Handle, TRANSPARENT);
            DrawText(Canvas.Handle, pchar(Tabs[AIndex]), -1, PR, DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS);
        end;
    end;

var
    RClient, RTab: TRect;
    LWidth: TList;
    I: integer;
begin
    if not HandleAllocated then
        Exit;
    if (Tabs.Count > 0) and not GetTabHidden then
    begin
        GetTabRect(RClient);
        Canvas.Brush.Color := BackColor;
        FillRect(Canvas.Handle, RClient, Canvas.Brush.Handle);
        DrawEdge(Canvas.Handle, RClient, BDR_SUNKENOUTER, BF_RECT or BF_SOFT);
        LWidth := CalcTabWidth(NIL);
        try
            Canvas.Font := Font;
            Canvas.Pen.Color := BackTextColor;
            GetTabArea(RTab);
            for I := 0 to LWidth.Count - 1 do
            begin
                RTab.Right := RTab.Left + integer(LWidth[I]);
                PaintTab(I, RTab, I = TabIndex);
                RTab.Left := RTab.Right;
            end;
        finally
            LWidth.Free;
        end;
        ExcludeClipRect(Canvas.Handle, RClient.Left, RClient.Top, RClient.Right, RClient.Bottom);
    end;
    RClient := ClientRect;
    FillRect(Canvas.Handle, RClient, Brush.Handle);
end;

procedure TdevCustomTabs.SetBackTextColor(Value: TColor);
begin
    if Value <> BackTextColor then
    begin
        FBackTextColor := Value;
        Invalidate;
    end;
end;

procedure TdevCustomTabs.SetBackColor(Value: TColor);
begin
    if Value <> BackColor then
    begin
        FBackColor := Value;
        Invalidate;
    end;
end;

procedure TdevCustomTabs.SetLeftMargin(Value: integer);
begin
    if Value <> LeftMargin then
    begin
        FLeftMargin := Value;
        if Tabs.Count > 0 then
            Invalidate;
    end;
end;

procedure TdevCustomTabs.SetRightMargin(Value: integer);
begin
    if Value <> RightMargin then
    begin
        FRightMargin := Value;
        if Tabs.Count > 0 then
            Invalidate;
    end;
end;

function TdevCustomTabs.CanChange(NewIndex: integer): boolean;
begin
    Result := TRUE;
    if Assigned(FOnChanging) then
        FOnChanging(Self, NewIndex, Result)
    else Result := GetTabEnabled(NewIndex);
end;

procedure TdevCustomTabs.Change;
begin
    if assigned(fOnChange) then
        fOnChange(Self);
end;

procedure TdevCustomTabs.SetTabIndex(Value: integer);
begin
    if Value <> FTabIndex then
    begin
        FTabs[Value];
        if CanChange(Value) then
        begin
            FTabIndex := Value;
            Caption := Tabs[Value];
            ResetAutoMove;
            Change;
            if not (csLoading in ComponentState) then
                Click;
            Invalidate;
        end;
    end;
end;

procedure TdevCustomTabs.SelectNext(Direction: boolean);
var
    NewIndex: integer;
begin
    if Tabs.Count > 1 then
    begin
        NewIndex := TabIndex;
        if Direction then
            Inc(NewIndex)
        else Dec(NewIndex);
        if NewIndex = Tabs.Count then
            NewIndex := 0
        else
        if NewIndex < 0 then
            NewIndex := Tabs.Count - 1;
        TabIndex := NewIndex;
    end;
end;

procedure TdevCustomTabs.SetTabs(Value: TStrings);
begin
    FTabs.Assign(Value);
    FTabIndex := -1;
    if FTabs.Count > 0 then
        TabIndex := 0
    else Invalidate;
end;

procedure TdevCustomTabs.SetOrientation(Value: TdevTabOrientation);
begin
    if Value <> Orientation then
    begin
        FOrientation := Value;
        Invalidate;
        Realign;
    end;
end;

procedure TdevCustomTabs.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
    I: integer;
begin
    FStarted := FALSE;
    if not (ssDouble in Shift) then
    begin
        I := TabAtPos(Point(X, Y));
        if I >= 0 then
        begin
            TabIndex := I;
            FStarted := TRUE;
        end;
    end;
    inherited MouseDown(Button, Shift, X, Y);
end;

procedure TdevCustomTabs.CMFontChanged(var Message: TMessage);
begin
    inherited;
    CalcTabHeight;
    Invalidate;
end;

procedure TdevCustomTabs.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
    Message.Result := DLGC_WANTALLKEYS;
end;

procedure TdevCustomTabs.CMDialogChar(var Message: TCMDialogChar);
var
    I: integer;
begin
    for I := 0 to FTabs.Count - 1 do
    begin
        if IsAccel(Message.CharCode, FTabs[I]) then
        begin
            Message.Result := 1;
            if FTabIndex <> I then
                SetTabIndex(I);
            Exit;
        end;
    end;
    inherited;
end;

procedure TdevCustomTabs.SetTabMargin(Value: integer);
begin
    if Value < 0 then
        Value := 0;
    if Value <> TabMargin then
    begin
        FTabMargin := Value;
        if Tabs.Count > 0 then
            Invalidate;
    end;
end;

procedure TdevCustomTabs.MouseMove(Shift: TShiftState; X, Y: integer);
var
    R: TRect;
    I: integer;
begin
    if GetCapture = Handle then
    begin
        if FStarted then
        begin
            if AutoMove then
            begin
                I := IntTabAtPos(Point(X, Y), FAMList);
                if (I >= 0) and (I <> TabIndex) then
                begin
                    Tabs.Exchange(I, TabIndex);
                    Moved(I, TabIndex);
                    FTabIndex := I;
                    Invalidate;
                end;
            end;
            GetTabRect(R);
            if not PtInRect(R, Point(X, Y)) then
                BeginTabDrag;
        end;
    end;
    inherited;
end;

function TdevCustomTabs.GetAutoMove: boolean;
begin
    Result := FAMList <> NIL;
end;

procedure TdevCustomTabs.SetAutoMove(Value: boolean);
begin
    if Value <> AutoMove then
    begin
        if Value then
            FAMList := CalcTabWidth(NIL)
        else FreeAndNil(FAMList);
    end;
end;

procedure TdevCustomTabs.ResetAutoMove;
begin
    if AutoMove then
    begin
        AutoMove := FALSE;
        AutoMove := TRUE;
    end;
end;

procedure TdevCustomTabs.CalcTabHeight;
var
    C: TCanvas;
    DC: HDC;
begin
    DC := GetDC(0);
    try
        C := TCanvas.Create;
        try
            C.Handle := DC;
            try
                C.Font := Font;
                FTabHeight := 5 + C.TextHeight('A');
                if (FImages <> NIL) and (FImages.Height > FTabHeight)
                then
                    FTabHeight := FImages.Height;
                Inc(FTabHeight, 3);
            finally
                C.Handle := 0;
            end;
        finally
            C.Free;
        end;
    finally
        ReleaseDC(0, DC);
    end;
end;

procedure TdevCustomTabs.CreateParams(var Params: TCreateParams);
begin
    inherited;
    Params.Style := Params.Style or WS_CLIPCHILDREN or WS_CLIPSIBLINGS;
    with Params.WindowClass do
        Style := Style and not (CS_HREDRAW or CS_VREDRAW);
end;

function TdevCustomTabs.GetTabBrush: THandle;
begin
    Result := Brush.Handle;
end;

procedure TdevCustomTabs.AdjustTabs;
begin
    Invalidate;
    Realign;
end;

procedure TdevCustomTabs.Moved(AFrom, ATo: integer);
begin
    if Assigned(FOnMoved) then
        FOnMoved(Self, AFrom, ATo);
end;

function TdevCustomTabs.GetImageIndex(TabIndex: integer): integer;
begin
    Result := -1;
    if Assigned(FOnGetImage) then
        FOnGetImage(Self, TabIndex, Result);
end;

procedure TdevCustomTabs.SetImages(Value: TCustomImageList);
begin
    if Images <> NIL then
        Images.UnRegisterChanges(FImageChangeLink);
    FImages := Value;
    if Images <> NIL then
    begin
        Images.RegisterChanges(FImageChangeLink);
        Images.FreeNotification(Self);
    end;
    CalcTabHeight;
    AdjustTabs;
end;

function TdevCustomTabs.GetTabEnabled(TabIndex: integer): boolean;
begin
    Result := TRUE;
end;

procedure TdevCustomTabs.WMSize(var Message: TWMSize);
var
    R: TRect;
begin
    inherited;
    GetTabRect(R);
    InflateRect(R, 0, 2);
    InvalidateRect(Handle, @R, FALSE);
end;

procedure TdevCustomTabs.BeginTabDrag;
begin
    if Assigned(FOnTabDrag) then
        FOnTabDrag(Self);
end;

procedure TdevCustomTabs.CMHintShow(var Message: TCMHintShow);
var
    I: integer;
begin
    inherited;
    with Message do
        if Result = 0 then
        begin
            I := TabAtPos(HintInfo^.CursorPos);
            HintInfo^.HintStr := '';
            if I >= 0 then
            begin
                HintInfo^.HintStr := Tabs[I];
                if pos('&&', HintInfo^.HintStr) > 0 then
                    Delete(HintInfo^.HintStr, pos('&&', HintInfo^.HintStr), 1);
                HintInfo^.CursorRect := TabRect(I);
            end;
        end;
end;

function ExtractCaption(AControl: TControl): string;
var
    I: integer;
begin
    Result := THintWindow(AControl).Caption;
    for I := 1 to Length(Result) do
        if Result[I] in [#13, #10] then
        begin
            SetLength(Result, I - 1);
            Break;
        end;
end;

procedure TdevCustomPages.AddVisPage(APage: TdevPage);
var
    I, VI: integer;
    WPage: TdevPage;
begin
    VI := 0;
    for I := 0 to FPages.Count - 1 do
    begin
        WPage := FPages[I];
        if WPage = APage then
            Break
        else
        if WPage.TabVisible or (csDesigning in ComponentState) then
            Inc(VI);
    end;
    Tabs.InsertObject(VI, APage.Caption, APage);
end;

procedure TdevCustomPages.AddPage(APage: TdevPage);
begin
    FPages.Add(APage);
    if (csDesigning in ComponentState) or APage.TabVisible then
    begin
        AddVisPage(APage);
        if (csDesigning in ComponentState) then
            ActivePage := APage;
    end;
end;

constructor TdevCustomPages.Create(AOwner: TComponent);
begin
    inherited;
    ControlStyle := ControlStyle - [csAcceptsControls];
    FPages := TList.Create;
end;

destructor TdevCustomPages.Destroy;
var
    I: integer;
begin
    for I := 0 to FPages.Count - 1 do
        TdevPage(FPages[I]).FPages := NIL;
    FPages.Free;
    inherited;
end;

function TdevCustomPages.CanChange(NewIndex: integer): boolean;
begin
    Result := inherited CanChange(NewIndex);
    if Result then
        ActivePage := TdevPage(Tabs.Objects[NewIndex]);
end;

function TdevCustomPages.GetTabEnabled(ATabIndex: integer): boolean;
begin
    Result := (csDesigning in ComponentState) or TdevPage(Tabs.Objects[ATabIndex]).Enabled;
end;

function TdevCustomPages.GetPage(AIndex: integer): TdevPage;
begin
    Result := TdevPage(FPages[AIndex]);
end;

function TdevCustomPages.GetPageCount: integer;
begin
    Result := FPages.Count;
end;

function TdevCustomPages.GetActivePageIndex: integer;
begin
    Result := -1;
    if FPage <> NIL then
        Result := FPage.PageIndex;
end;

procedure TdevCustomPages.RemovePage(APage: TdevPage);
begin
    FPages.Remove(APage);
    if APage.TabVisible then
        RemoveVisPage(APage);
end;

procedure TdevCustomPages.RemoveVisPage(APage: TdevPage);
var
    I: integer;
begin
    I := Tabs.IndexOfObject(APage);
    if I >= 0 then
    begin
        Tabs.Delete(I);
        UpdatePage(NIL);
    end;
end;

procedure TdevCustomPages.ChangeActive(Page: TdevPage);
var
    ParentForm: TCustomForm;
begin
    ParentForm := GetParentForm(Self);
    if (ParentForm <> NIL) and (FPage <> NIL) and FPage.ContainsControl(ParentForm.ActiveControl) then
    begin
        ParentForm.ActiveControl := FPage;
        if ParentForm.ActiveControl <> FPage then
        begin
            TabIndex := Tabs.IndexOfObject(FPage);
            Exit;
        end;
    end;
    if Page <> NIL then
    begin
        Page.BringToFront;
        Page.Visible := TRUE;
        if (ParentForm <> NIL) and (FPage <> NIL) and
            (ParentForm.ActiveControl = FPage) then
            if Page.CanFocus then
                ParentForm.ActiveControl := Page else
                ParentForm.ActiveControl := Self;
    end;
    if FPage <> NIL then
        FPage.Visible := FALSE;
    FPage := Page;
    if (ParentForm <> NIL) and (FPage <> NIL) and
        (ParentForm.ActiveControl = FPage) then
        FPage.SelectFirst;
end;

procedure TdevCustomPages.SetActivePage(Value: TdevPage);
begin
    if (Value <> NIL) and (Value.Pages <> Self) then
        Exit;
    if Value <> FPage then
    begin
        ChangeActive(Value);
        if Value = NIL then
            TabIndex := -1
        else
        if Value = FPage then
            TabIndex := Tabs.IndexOfObject(FPage);
    end;
end;

procedure TdevCustomPages.SetActivePageIndex(Value: integer);
begin
    ActivePage := Pages[Value];
end;

function TdevCustomPages.GetTabBrush: THandle;
begin
    if FPage <> NIL then
        Result := FPage.Brush.Handle
    else Result := Brush.Handle;
end;

procedure TdevCustomPages.SetChildOrder(Child: TComponent; Order: integer);
begin
    TdevPage(Child).PageIndex := Order;
end;

procedure TdevCustomPages.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
    I: integer;
begin
    for I := 0 to FPages.Count - 1 do
        Proc(TComponent(FPages[I]));
end;

procedure TdevCustomPages.UpdatePage(APage: TdevPage);
var
    I: integer;
begin
    if APage = NIL then
    begin
        if TabIndex = -1 then
            ActivePage := NIL
        else ActivePage := TdevPage(Tabs.Objects[TabIndex]);
    end
    else
    begin
        I := FTabs.IndexOfObject(APage);
        if APage.TabVisible or (csDesigning in ComponentState) then
        begin
            if I >= 0 then
                Tabs[I] := APage.Caption
            else AddVisPage(APage);
        end
        else
        if I >= 0 then
            RemoveVisPage(APage);
    end;
end;

procedure TdevCustomPages.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
    inherited;
    if TabAtPos(SmallPointToPoint(Msg.Pos)) >= 0 then
        Msg.Result := HTCLIENT;
end;

procedure TdevCustomPages.Moved(AFrom, ATo: integer);
begin
    FPages.Exchange(TdevPage(Tabs.Objects[AFrom]).PageIndex, TdevPage(Tabs.Objects[ATo]).PageIndex);
end;

function TdevCustomPages.GetImageIndex(ATabIndex: integer): integer;
begin
    Result := TdevPage(FTabs.Objects[ATabIndex]).ImageIndex;
end;

procedure TdevCustomPages.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
    DockCtl: TControl;
begin
    inherited;
    DockCtl := GetDockClientFromPage(ActivePage);
    if DockCtl <> NIL then
        DockCtl.ManualDock(NIL, NIL, alNone);
end;

procedure TdevCustomPages.CMDockClient(var Message: TCMDockClient);
var
    IsVisible: boolean;
    DockCtl: TControl;
begin
    Message.Result := 0;
    FNewDockPage := TdevPage.Create(Self);
    try
        try
            DockCtl := Message.DockSource.Control;
            FNewDockPage.Caption := ExtractCaption(DockCtl);
            FNewDockPage.FSaveMode := TdevPages(DockCtl).DragMode;
            if DockCtl is TWinControl then
                FNewDockPage.FSaveDS := TdevPages(DockCtl).DockSite;
            TdevPages(DockCtl).DragMode := dmManual;
            FNewDockPage.Pages := Self;
            DockCtl.Dock(Self, Message.DockSource.DockRect);
        except
            FNewDockPage.Free;
            raise;
        end;
        IsVisible := DockCtl.Visible;
        FNewDockPage.Visible := IsVisible;
        if IsVisible then
            ActivePage := FNewDockPage;
        DockCtl.Align := alClient;
    finally
        FNewDockPage := NIL;
    end;
end;

function TdevCustomPages.GetPageFromDockClient(Client: TControl): TdevPage;
var
    I: integer;
begin
    Result := NIL;
    for I := 0 to PageCount - 1 do
    begin
        if (Client.Parent = Pages[I]) and (Client.HostDockSite = Self) then
        begin
            Result := Pages[I];
            exit;
        end;
    end;
end;

procedure TdevCustomPages.CMDockNotification(var Message: TCMDockNotification);
var
    Page: TdevPage;
begin
    Page := GetPageFromDockClient(Message.Client);
    if Page <> NIL then
        case Message.NotifyRec.ClientMsg of
            WM_SETTEXT:
                Page.Caption := ExtractCaption(Message.Client);
            CM_VISIBLECHANGED:
            begin
                Page.Visible := boolean(Message.NotifyRec.MsgWParam);
                if Page.Visible then
                    ActivePage := Page;
            end;
        end;
    inherited;
end;

procedure TdevCustomPages.CMUnDockClient(var Message: TCMUnDockClient);
var
    Page: TdevPage;
    DockCtl: TControl;
begin
    Message.Result := 0;
    Page := GetPageFromDockClient(Message.Client);
    if Page <> NIL then
    begin
        FUndockingPage := Page;
        DockCtl := Message.Client;
        if DockCtl is TWinControl then
            TdevPages(DockCtl).DockSite := Page.FSaveDS;
        TdevPages(DockCtl).DragMode := Page.FSaveMode;
        DockCtl.Align := alNone;
    end;
end;

procedure TdevCustomPages.DoAddDockClient(Client: TControl; const ARect: TRect);
begin
    if FNewDockPage <> NIL then
        Client.Parent := FNewDockPage;
end;

procedure TdevCustomPages.DockOver(Source: TDragDockObject; X, Y: integer;
    State: TDragState; var Accept: boolean);
var
    R: TRect;
begin
    GetWindowRect(Handle, R);
    Source.DockRect := R;
    DoDockOver(Source, X, Y, State, Accept);
end;

procedure TdevCustomPages.DoRemoveDockClient(Client: TControl);
begin
    if (FUndockingPage <> NIL) and not (csDestroying in ComponentState)
    then
        FreeAndNil(FUndockingPage);
end;

procedure TdevCustomPages.GetSiteInfo(Client: TControl;
    var InfluenceRect: TRect; MousePos: TPoint; var CanDock: boolean);
var
    R: TRect;
begin
    CanDock := GetPageFromDockClient(Client) = NIL;
    if CanDock then
    begin
        GetTabRect(R);
        CanDock := PtInRect(R, ScreenToClient(MousePos));
    end;
    inherited GetSiteInfo(Client, InfluenceRect, MousePos, CanDock);
end;

procedure TdevCustomPages.BeginTabDrag;
var
    DockCtl: TControl;
begin
    DockCtl := GetDockClientFromPage(ActivePage);
    if (DockCtl <> NIL) then
        DockCtl.BeginDrag(FALSE);
end;

function TdevCustomPages.GetDockClientFromPage(APage: TdevPage): TControl;
begin
    Result := NIL;
    if (APage.ControlCount > 0) then
    begin
        Result := APage.Controls[0];
        if Result.HostDockSite <> Self then
            Result := NIL;
    end;
end;

procedure TdevCustomTabs.SetTabHidden(Value: boolean);
begin
    if Value <> FTabHidden then
    begin
        FTabHidden := Value;
        if not (csDesigning in ComponentState) then
        begin
            Realign;
            Invalidate;
        end;
    end;
end;

function TdevCustomTabs.GetTabHidden: boolean;
begin
    Result := FTabHidden;
    if csDesigning in ComponentState then
        Result := FALSE;
end;

{ TdevPage }

procedure TdevPage.CMTextChanged(var Msg: TMessage);
begin
    inherited;
    if FPages <> NIL then
        FPages.UpdatePage(Self);
end;

procedure TdevPage.CMVisibleChanged(var Msg: TMessage);
begin
    inherited;
    if not (csLoading in ComponentState) then
    begin
        if Visible then
        begin
            if Assigned(FOnShow) then
                FOnShow(Self);
        end
        else
        if Assigned(FOnHide) then
            FOnHide(Self);
    end;
end;

constructor TdevPage.Create(AOwner: TComponent);
begin
    inherited;
    ControlStyle := ControlStyle + [csAcceptsControls, csNoDesignVisible];
    BorderStyle := bsNone;
    ParentColor := TRUE;
    ParentFont := TRUE;
    Visible := FALSE;
    Align := alClient;
    TabVisible := TRUE;
    HorzScrollBar.Smooth := TRUE;
    HorzScrollBar.Tracking := TRUE;
    VertScrollBar.Smooth := TRUE;
    VertScrollBar.Tracking := TRUE;
    FImageIndex := -1;
end;

destructor TdevPage.Destroy;
begin
    if (Pages <> NIL) and not (csDestroying in Pages.ComponentState) then
    begin
        if Pages.FUndockingPage = Self then
            FPages.FUndockingPage := NIL;
        Pages := NIL;
    end;
    inherited;
end;

function TdevPage.GetIndex: integer;
begin
    Result := -1;
    if Pages <> NIL then
        Result := Pages.FPages.IndexOf(Self);
end;

procedure TdevPage.SetImageIndex(Value: TImageIndex);
begin
    if FImageIndex <> Value then
    begin
        FImageIndex := Value;
        if FPages <> NIL then
            FPages.Invalidate;
    end;
end;

procedure TdevPage.SetIndex(Value: integer);
var
    I: integer;
begin
    if (FPages <> NIL) then
    begin
        I := PageIndex;
        if Value <> I then
        begin
            FPages.FPages.Move(I, Value);
            if TabVisible or (csDesigning in ComponentState) then
            begin
                FPages.RemoveVisPage(Self);
                FPages.AddVisPage(Self);
            end;
        end;
    end;
end;

procedure TdevPage.SetPages(Value: TdevCustomPages);
begin
    if FPages <> Value then
    begin
        if FPages <> NIL then
            FPages.RemovePage(Self);
        FPages := Value;
        if FPages <> NIL then
        begin
            Parent := FPages;
            FPages.AddPage(Self);
        end;
    end;
end;

procedure TdevPage.SetParent(AParent: TWinControl);
begin
    if AParent is TdevPage then
        AParent := TdevPage(AParent).Pages;
    inherited;
    if (AParent = NIL) or (AParent is TdevCustomPages) then
        Pages := TdevCustomPages(AParent);
end;

procedure TdevPage.CMEnableChanged(var Msg: TMessage);
begin
    inherited;
    if FPages <> NIL then
        FPages.Invalidate;
end;

procedure TdevPage.CMColorChanged(var Msg: TMessage);
begin
    inherited;
    if Pages <> NIL then
        Pages.Invalidate;
end;

procedure TdevPage.CreateParams(var Params: TCreateParams);
begin
    inherited;
    with Params.WindowClass do
        style := style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TdevPage.SetTabVisible(Value: boolean);
begin
    if FTabVisible <> Value then
    begin
        FTabVisible := Value;
        if FPages <> NIL then
            FPages.UpdatePage(Self);
    end;
end;

end.
