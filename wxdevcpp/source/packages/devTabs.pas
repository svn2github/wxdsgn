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
Unit devTabs;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ImgList;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QImgList, Types;
{$ENDIF}

Type
    TdevTabOrientation = (toTop, toBottom);

    TdevTabChangingEvent = Procedure(Sender: TObject; NewIndex: Integer; Var AllowChange: Boolean) Of Object;
    TdevTabMovedEvent = Procedure(Sender: TObject; OldIndex, NewIndex: Integer) Of Object;

    TdevTabGetImageEvent = Procedure(Sender: TObject; TabIndex: Integer; Var ImageIndex: Integer) Of Object;

    TdevCustomTabs = Class(TCustomControl)
    Private
        FOrientation: TdevTabOrientation;
        FLeftMargin: Integer;
        FRightMargin: Integer;
        FTabMargin: Integer;
        FTabs: TStrings;
        FTabIndex: Integer;
        FTabHeight: Integer;
        FBackTextColor: TColor;
        FBackColor: TColor;
        FAMList: TList;
        FImageChangeLink: TChangeLink;
        FImages: TCustomImageList;
        FStarted: Boolean;
        FOnMoved: TdevTabMovedEvent;
        FOnChanging: TdevTabChangingEvent;
        FOnTabDrag: TNotifyEvent;
        FOnGetImage: TdevTabGetImageEvent;
        fOnChange: TNotifyEvent;
        FTabHidden: Boolean;
        Function GetTabHidden: Boolean;
        Function ClippedTabAtPos(Pos: TPoint; Var AIndex: Integer): Boolean;
        Function IntTabAtPos(Pos: TPoint; AList: TList): Integer;
        Function CalcTabWidth(AOriginal: TList): TList;
        Procedure SetBackTextColor(Value: TColor);
        Procedure SetBackColor(Value: TColor);
        Procedure SetLeftMargin(Value: Integer);
        Procedure SetRightMargin(Value: Integer);
        Procedure SetTabIndex(Value: Integer);
        Procedure SetTabMargin(Value: Integer);
        Procedure SetTabs(Value: TStrings);
        Procedure SetOrientation(Value: TdevTabOrientation);
        Procedure CMFontChanged(Var Message: TMessage); Message CM_FONTCHANGED;
        Procedure WMGetDlgCode(Var Message: TWMGetDlgCode); Message WM_GETDLGCODE;
        Procedure CMDialogChar(Var Message: TCMDialogChar); Message CM_DIALOGCHAR;
        Procedure CMHintShow(Var Message: TCMHintShow); Message CM_HINTSHOW;
        Procedure WMSize(Var Message: TWMSize); Message WM_SIZE;
        Function GetAutoMove: Boolean;
        Procedure SetAutoMove(Value: Boolean);
        Procedure ResetAutoMove;
        Procedure CalcTabHeight;
        Procedure AdjustTabs;
        Procedure GetTabArea(Var ARect: TRect);
        Procedure GetTabRect(Var ARect: TRect);
        Procedure SetImages(Value: TCustomImageList);
        Procedure ImageListChanged(Sender: TObject);
        Procedure SetTabHidden(Value: Boolean);
        Procedure Change;
    Protected
        Procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); Override;
        Procedure MouseMove(Shift: TShiftState; X, Y: Integer); Override;
        Procedure CreateParams(Var Params: TCreateParams); Override;
        Procedure BeginTabDrag; Dynamic;
        Procedure AdjustClientRect(Var ARect: TRect); Override;
        Procedure Paint; Override;
        Procedure Moved(AFrom, ATo: Integer); Dynamic;
        Function GetTabBrush: THandle; Virtual;
        Function GetTabEnabled(TabIndex: Integer): Boolean; Virtual;
        Function GetImageIndex(TabIndex: Integer): Integer; Virtual;
        Function CanChange(NewIndex: Integer): Boolean; Dynamic;
        Function TabAtPos(Pos: TPoint): Integer;
        Function TabRect(Item: Integer): TRect;
        Property OnMoved: TdevTabMovedEvent Read FOnMoved Write FOnMoved;
        Property OnChange: TNotifyEvent Read fOnChange Write fOnChange;
        Property OnChanging: TdevTabChangingEvent Read FOnChanging Write FOnChanging;
        Property OnGetImageIndex: TdevTabGetImageEvent Read FOnGetImage Write FOnGetImage;
        Property OnTabDrag: TNotifyEvent Read FOnTabDrag Write FOnTabDrag;
        Property AutoMove: Boolean Read GetAutoMove Write SetAutoMove Default False;
        Property LeftMargin: Integer Read FLeftMargin Write SetLeftMargin Default 5;
        Property TabMargin: Integer Read FTabMargin Write SetTabMargin Default 4;
        Property RightMargin: Integer Read FRightMargin Write SetRightMargin Default 5;
        Property BackTextColor: TColor Read FBackTextColor Write SetBackTextColor Default clBtnHighlight;
        Property BackColor: TColor Read FBackColor Write SetBackColor Default clBtnShadow;
        Property Orientation: TdevTabOrientation Read FOrientation Write SetOrientation Default toTop;
        Property Tabs: TStrings Read FTabs Write SetTabs;
        Property TabIndex: Integer Read FTabIndex Write SetTabIndex Default -1;
        Property Images: TCustomImageList Read FImages Write SetImages;
    Public
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Procedure SelectNext(Direction: Boolean);
        Property TabHeight: Integer Read FTabHeight;
        Property TabHidden: Boolean Read FTabHidden Write SetTabHidden Default False;
        Property Color Nodefault;
        Property ParentFont Default True;
        Property ParentColor Default True;
    End;

    TdevTabs = Class(TdevCustomTabs)
    Published
        Property Align;
        Property AutoMove;
        Property Anchors;
        Property BevelEdges;
        Property BevelKind;
        Property BevelInner;
        Property BevelOuter;
        Property Constraints;
        Property DragKind;
        Property OnEndDock;
        Property OnStartDock;
        Property OnTabDrag;
        Property Ctl3D;
        Property Color;
        Property DragCursor;
        Property DragMode;
        Property Enabled;
        Property LeftMargin;
        Property TabMargin;
        Property Font;
        Property Images;
        Property PopupMenu;
        Property RightMargin;
        Property ParentColor;
        Property ParentCtl3D;
        Property BackTextColor;
        Property BackColor;
        Property Orientation;
        Property Tabs;
        Property TabIndex;
        Property TabHidden;
        Property Visible;
        Property OnClick;
        Property OnMoved;
        Property OnChange;
        Property OnChanging;
        Property OnDragDrop;
        Property OnDragOver;
        Property OnEndDrag;
        Property OnEnter;
        Property OnExit;
        Property OnMouseDown;
        Property OnMouseMove;
        Property OnMouseUp;
        Property OnKeyDown;
        Property OnKeyUp;
        Property OnKeyPress;
        Property OnStartDrag;
        Property OnGetImageIndex;
    End;

    TdevPage = Class;

    TdevCustomPages = Class(TdevCustomTabs)
    Private
        FPage: TdevPage;
        FPages: TList;
        FNewDockPage,
        FUndockingPage: TdevPage;
        Function GetPage(AIndex: Integer): TdevPage;
        Function GetPageCount: Integer;
        Function GetActivePageIndex: Integer;
        Function GetPageFromDockClient(Client: TControl): TdevPage;
        Function GetDockClientFromPage(APage: TdevPage): TControl;
        Procedure SetActivePage(Value: TdevPage);
        Procedure SetActivePageIndex(Value: Integer);
        Procedure AddPage(APage: TdevPage);
        Procedure RemovePage(APage: TdevPage);
        Procedure AddVisPage(APage: TdevPage);
        Procedure RemoveVisPage(APage: TdevPage);
        Procedure UpdatePage(APage: TdevPage);
        Procedure CMDesignHitTest(Var Msg: TCMDesignHitTest); Message CM_DESIGNHITTEST;
        Procedure CMDockClient(Var Message: TCMDockClient); Message CM_DOCKCLIENT;
        Procedure CMDockNotification(Var Message: TCMDockNotification); Message CM_DOCKNOTIFICATION;
        Procedure CMUnDockClient(Var Message: TCMUnDockClient); Message CM_UNDOCKCLIENT;
        Procedure WMLButtonDblClk(Var Message: TWMLButtonDblClk); Message WM_LBUTTONDBLCLK;
        Procedure ChangeActive(Page: TdevPage);
    Protected
        Function GetTabBrush: THandle; Override;
        Function GetTabEnabled(ATabIndex: Integer): Boolean; Override;
        Function CanChange(NewIndex: Integer): Boolean; Override;
        Function GetImageIndex(ATabIndex: Integer): Integer; Override;
        Procedure BeginTabDrag; Override;
        Procedure GetChildren(Proc: TGetChildProc; Root: TComponent); Override;
        Procedure SetChildOrder(Child: TComponent; Order: Integer); Override;
        Procedure Moved(AFrom, ATo: Integer); Override;
        Procedure DoAddDockClient(Client: TControl; Const ARect: TRect); Override;
        Procedure DockOver(Source: TDragDockObject; X, Y: Integer; State: TDragState; Var Accept: Boolean); Override;
        Procedure DoRemoveDockClient(Client: TControl); Override;
        Procedure GetSiteInfo(Client: TControl; Var InfluenceRect: TRect; MousePos: TPoint; Var CanDock: Boolean); Override;
        Property Pages[AIndex: Integer]: TdevPage Read GetPage;
        Property PageCount: Integer Read GetPageCount;
        Property ActivePageIndex: Integer Read GetActivePageIndex Write SetActivePageIndex;
        Property ActivePage: TdevPage Read FPage Write SetActivePage;
    Public
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
    End;

{  TImageIndex = Integer;
}
    TdevPage = Class(TScrollBox)
    Private
        FPages: TdevCustomPages;
        FImageIndex: TImageIndex;
        FSaveMode: TDragMode;
        FSaveDS: Boolean;
        FOnShow: TNotifyEvent;
        FOnHide: TNotifyEvent;
        FTabVisible: Boolean;
        Function GetIndex: Integer;
        Procedure SetIndex(Value: Integer);
        Procedure SetPages(Value: TdevCustomPages);
        Procedure CMVisibleChanged(Var Msg: TMessage); Message CM_VISIBLECHANGED;
        Procedure CMTextChanged(Var Msg: TMessage); Message CM_TEXTCHANGED;
        Procedure CMEnableChanged(Var Msg: TMessage); Message CM_ENABLEDCHANGED;
        Procedure CMColorChanged(Var Msg: TMessage); Message CM_COLORCHANGED;
        Procedure SetImageIndex(Value: TImageIndex);
        Procedure SetTabVisible(Value: Boolean);
    Protected
        Procedure SetParent(AParent: TWinControl); Override;
        Procedure CreateParams(Var Params: TCreateParams); Override;
    Public
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Property Pages: TdevCustomPages Read FPages Write SetPages;
    Published
        Property BevelEdges;
        Property BevelKind;
        Property BevelInner;
        Property BevelOuter;
        Property BorderStyle Default bsNone;
        Property PageIndex: Integer Read GetIndex Write SetIndex Stored False;
        Property ImageIndex: TImageIndex Read FImageIndex Write SetImageIndex Default -1;
        Property Enabled;
        Property TabVisible: Boolean Read FTabVisible Write SetTabVisible Default True;
        Property Caption;
        Property Color;
        Property ParentColor Default True;
        Property Font;
        Property ParentFont Default True;
        Property Ctl3D;
        Property ParentCtl3D;
        Property OnShow: TNotifyEvent Read FOnShow Write FOnShow;
        Property OnHide: TNotifyEvent Read FOnHide Write FOnHide;
        Property OnEnter;
        Property OnExit;
        Property OnMouseMove;
        Property OnMouseDown;
        Property OnMouseUp;
        Property OnKeyDown;
        Property OnKeyUp;
        Property OnKeyPress;
        Property OnResize;
        Property OnEndDrag;
        Property OnStartDrag;
        Property OnClick;
        Property OnDblClick;
    End;

    TdevPages = Class(TdevCustomPages)
    Public
        Property Pages;
        Property PageCount;
        Property ActivePageIndex;
    Published
        Property Align;
        Property AutoMove;
        Property ActivePage;
        Property Anchors;
        Property BevelEdges;
        Property BevelKind;
        Property BevelInner;
        Property BevelOuter;
        Property Constraints;
        Property DragKind;
        Property OnEndDock;
        Property OnStartDock;
        Property Ctl3D;
        Property Color;
        Property DragCursor;
        Property DragMode;
        Property DockSite;
        Property Enabled;
        Property LeftMargin;
        Property TabMargin;
        Property Font;
        Property PopupMenu;
        Property RightMargin;
        Property ParentColor;
        Property ParentCtl3D;
        Property BackTextColor;
        Property BackColor;
        Property Images;
        Property TabHidden;
        Property Orientation;
        Property Visible;
        Property OnClick;
        Property OnChange;
        Property OnChanging;
        Property OnDragDrop;
        Property OnDragOver;
        Property OnEndDrag;
        Property OnEnter;
        Property OnExit;
        Property OnMouseDown;
        Property OnMouseMove;
        Property OnMouseUp;
        Property OnKeyDown;
        Property OnKeyUp;
        Property OnKeyPress;
        Property OnStartDrag;
        Property OnResize;
    End;

Function ExtractCaption(AControl: TControl): String;

Implementation

Function Min(A, B: Integer): Integer;
Begin
    If A < B Then
        Result := A Else Result := B;
End;

Function Max(A, B: Integer): Integer;
Begin
    If A > B Then
        Result := A Else Result := B;
End;

Type
    TdevTabItems = Class(TStringList)
    Private
        FTabs: TdevCustomTabs;
        Procedure UpdateTabs(ACount: Integer);
    Public
        Constructor Create(ATabs: TdevCustomTabs);
        Function Add(Const S: String): Integer; Override;
        Procedure Insert(Index: Integer; Const S: String); Override;
        Procedure Delete(Index: Integer); Override;
        Procedure Put(Index: Integer; Const S: String); Override;
        Procedure Clear; Override;
        Procedure AddStrings(Strings: TStrings); Override;
    End;

{ TdevTabItems }

Procedure TdevTabItems.UpdateTabs(ACount: Integer);
Begin
    If Count = ACount Then
        FTabs.AdjustTabs
    Else FTabs.Invalidate;
End;

Function TdevTabItems.Add(Const S: String): Integer;
Begin
    Result := Inherited Add(S);
    UpdateTabs(1);
End;

Procedure TdevTabItems.Insert(Index: Integer; Const S: String);
Begin
    Inherited Insert(Index, S);
    If Index <= FTabs.FTabIndex Then
        Inc(FTabs.FTabIndex);
    UpdateTabs(1);
End;

Procedure TdevTabItems.Delete(Index: Integer);
Var
    OldIndex: Integer;
Begin
    OldIndex := FTabs.TabIndex;
    Inherited Delete(Index);
    If Index <= OldIndex Then
        Dec(FTabs.FTabIndex);
    FTabs.FTabIndex := Min(Max(0, FTabs.TabIndex), Count - 1);
    UpdateTabs(0);
    If (OldIndex = Index) Then
        FTabs.Click;
    FTabs.ResetAutoMove;
End;

Procedure TdevTabItems.Put(Index: Integer; Const S: String);
Begin
    Inherited Put(Index, S);
    FTabs.Invalidate;
End;

Procedure TdevTabItems.Clear;
Begin
    Inherited Clear;
    FTabs.FTabIndex := -1;
    FTabs.ResetAutoMove;
    FTabs.Invalidate;
End;

Procedure TdevTabItems.AddStrings(Strings: TStrings);
Begin
    BeginUpdate;
    Try
        Inherited AddStrings(Strings);
    Finally
        EndUpdate;
    End;
End;

Constructor TdevTabItems.Create(ATabs: TdevCustomTabs);
Begin
    Inherited Create;
    FTabs := ATabs;
End;

{ TdevCustomTabs }

Constructor TdevCustomTabs.Create(AOwner: TComponent);
Begin
    Inherited Create(aOwner);
    FTabs := TdevTabItems.Create(Self);
    DoubleBuffered := True;
    ControlStyle := [csAcceptsControls, csCaptureMouse, csDoubleClicks, csOpaque];
    Width := 185;
    Height := 21;
    ParentFont := True;
    ParentColor := True;
    ParentShowHint := False;
    ShowHint := True;
    CalcTabHeight;
    FImageChangeLink := TChangeLink.Create;
    FImageChangeLink.OnChange := ImageListChanged;
    FTabIndex := -1;
    FTabMargin := 4;
    FLeftMargin := 5;
    FRightMargin := 5;
    FBackTextColor := clBtnHighlight;
    FBackColor := clBtnShadow;
End;

Destructor TdevCustomTabs.Destroy;
Begin
    If Assigned(FTabs) Then
        FreeAndNil(FTabs) Else FTabs := Nil;
    If Assigned(FImageChangeLink) Then
        FreeAndNil(FImageChangeLink)
    Else FImageChangeLink := Nil;
    AutoMove := False;
    Inherited Destroy;
End;

Procedure TdevCustomTabs.ImageListChanged(Sender: TObject);
Begin
    Invalidate;
End;

Function TdevCustomTabs.IntTabAtPos(Pos: TPoint; AList: TList): Integer;
Var
    I: Integer;
    RTab: TRect;
Begin
    Result := -1;
    GetTabArea(RTab);
    If (Pos.Y >= RTab.Top) And (Pos.Y < RTab.Bottom) Then
    Begin
        For I := 0 To AList.Count - 1 Do
        Begin
            RTab.Right := RTab.Left + Integer(AList[I]);
            If PtInRect(RTab, Pos) Then
            Begin
                Result := I;
                exit;
            End;
            RTab.Left := RTab.Right;
        End;
    End;
End;

Function TdevCustomTabs.ClippedTabAtPos(Pos: TPoint; Var AIndex: Integer): Boolean;
Var
    LWidth: TList;
    OWidth: TList;
Begin
    Result := False;
    AIndex := -1;
    If HandleAllocated Then
    Begin
        OWidth := TList.Create;
        Try
            LWidth := CalcTabWidth(OWidth);
            Try
                AIndex := IntTabAtPos(Pos, LWidth);
                If AIndex >= 0
                Then
                    Result := OWidth.IndexOf(Pointer(AIndex)) >= 0;
            Finally
                LWidth.Free;
            End;
        Finally
            OWidth.Free;
        End;
    End;
End;

Function TdevCustomTabs.TabAtPos(Pos: TPoint): Integer;
Begin
    ClippedTabAtPos(Pos, Result);
End;

Procedure TdevCustomTabs.GetTabRect(Var ARect: TRect);
Begin
    Windows.GetClientRect(Handle, ARect);
    If FOrientation = toTop Then
        ARect.Bottom := ARect.Top + FTabHeight
    Else ARect.Top := ARect.Bottom - FTabHeight;
End;

Procedure TdevCustomTabs.GetTabArea(Var ARect: TRect);
Begin
    GetTabRect(ARect);
    InflateRect(ARect, -1, -1);
    If Orientation = toTop Then
        Inc(ARect.Top, 3)
    Else Dec(ARect.Bottom, 3);
    Inc(ARect.Left, LeftMargin);
End;

Function TdevCustomTabs.TabRect(Item: Integer): TRect;
Var
    I: Integer;
    RTab: TRect;
    LWidth: TList;
Begin
    If Not GetTabHidden And (Item >= 0) And (Item < Tabs.Count) Then
    Begin
        GetTabArea(RTab);
        LWidth := CalcTabWidth(Nil);
        Try
            For I := 0 To Item - 1 Do
                Inc(RTab.Left, Integer(LWidth[I]));
            RTab.Right := RTab.Left + Integer(LWidth[Item]);
            Result := RTab;
        Finally
            LWidth.Free;
        End;
    End
    Else Result := Rect(0, 0, 0, 0);
End;

Procedure TdevCustomTabs.AdjustClientRect(Var ARect: TRect);
Begin
    Inherited;
    If Not GetTabHidden And (Tabs.Count > 0) Then
        If FOrientation = toTop Then
            Inc(ARect.Top, FTabHeight + 2)
        Else Dec(ARect.Bottom, FTabHeight + 2);
End;

Function TdevCustomTabs.CalcTabWidth(AOriginal: TList): TList;
Var
    I, Image,
    OldCount,
    BigCount,
    DiffSize,
    AverSize,
    FreeSize: Integer;
    MaxList: TList;
Begin
    Result := TList.Create;
    FreeSize := ClientWidth - (LeftMargin + RightMargin);
    BigCount := Tabs.Count;
    If (BigCount > 0) And (FreeSize >= BigCount) Then
    Begin
        MaxList := TList.Create;
        Try
            Canvas.Font := Font;
      // Fill the Result table
            For I := 0 To BigCount - 1 Do
            Begin
                Result.Add(Pointer(Canvas.TextWidth(Tabs[I]) + (TabMargin + 2) * 2));
                MaxList.Add(Pointer(I));
            End;
            If FImages <> Nil Then
            Begin
                Image := FImages.Width;
                For I := 0 To BigCount - 1 Do
                    If GetImageIndex(I) >= 0 Then
                        Result[I] := Pointer(Integer(Result[I]) + Image);
            End;
      // Smart calc average
            AverSize := 0;
            OldCount := 0;
            While (BigCount > 0) And (BigCount <> OldCount) Do
            Begin
                AverSize := FreeSize Div BigCount;
                OldCount := BigCount;
                For I := OldCount - 1 Downto 0 Do
                Begin
                    DiffSize := Integer(Result[Integer(MaxList[I])]);
                    If AverSize >= DiffSize Then
                    Begin
                        Dec(FreeSize, DiffSize);
                        Dec(BigCount);
                        MaxList.Delete(I);
                    End;
                End;
            End;
            If BigCount > 0 Then
            Begin
                OldCount := (FreeSize Mod AverSize) - 1;
        // adjust result table
                For I := 0 To BigCount - 1 Do
                    Result[Integer(MaxList[I])] := Pointer(AverSize + Byte(I < OldCount));
                If AOriginal <> Nil Then
                Begin
                    AOriginal.Count := BigCount;
                    Move(MaxList.List^, AOriginal.List^, SizeOf(Integer) * BigCount);
                End;
            End;
        Finally
            MaxList.Free;
        End;
    End;
End;

Procedure TdevCustomTabs.Paint;

    Procedure PaintTab(AIndex: Integer; Const ARect: TRect; ASelected: Boolean);
    Var
        PR: TRect;
        II: Integer;
    Begin
        If ARect.Right - ARect.Left >= (TabMargin + 2) * 2 Then
        Begin
            PR := ARect;
            If ASelected Then
            Begin
                If Orientation = toTop Then
                    PR.Bottom := 5000 Else PR.Top := -5000;
                InflateRect(PR, 0, 1);
                DrawEdge(Canvas.Handle, PR, EDGE_RAISED, BF_RECT Or BF_ADJUST);
                Windows.FillRect(Canvas.Handle, PR, GetTabBrush);
                Canvas.Font.Color := Font.Color;
            End
            Else
                With Canvas Do
                Begin
                    Pen.Color := clBtnFace;
                    MoveTo(PR.Right, PR.Top + 2 + Byte(Orientation));
                    LineTo(PR.Right, PR.Bottom - 3 + Byte(Orientation));
                    Font.Color := BackTextColor;
                End;
            PR := ARect;
            InflateRect(PR, -TabMargin - 2, 0);
            If (FImages <> Nil) Then
            Begin
                II := GetImageIndex(AIndex);
                If II >= 0 Then
                Begin
                    FImages.Draw(Canvas, PR.Left - 2, PR.Top, II, GetTabEnabled(AIndex));
                    Inc(PR.Left, FImages.Width);
                End;
            End;
            SetBkMode(Canvas.Handle, TRANSPARENT);
            DrawText(Canvas.Handle, Pchar(Tabs[AIndex]), -1, PR, DT_SINGLELINE Or DT_VCENTER Or DT_END_ELLIPSIS);
        End;
    End;

Var
    RClient, RTab: TRect;
    LWidth: TList;
    I: Integer;
Begin
    If Not HandleAllocated Then
        Exit;
    If (Tabs.Count > 0) And Not GetTabHidden Then
    Begin
        GetTabRect(RClient);
        Canvas.Brush.Color := BackColor;
        FillRect(Canvas.Handle, RClient, Canvas.Brush.Handle);
        DrawEdge(Canvas.Handle, RClient, BDR_SUNKENOUTER, BF_RECT Or BF_SOFT);
        LWidth := CalcTabWidth(Nil);
        Try
            Canvas.Font := Font;
            Canvas.Pen.Color := BackTextColor;
            GetTabArea(RTab);
            For I := 0 To LWidth.Count - 1 Do
            Begin
                RTab.Right := RTab.Left + Integer(LWidth[I]);
                PaintTab(I, RTab, I = TabIndex);
                RTab.Left := RTab.Right;
            End;
        Finally
            LWidth.Free;
        End;
        ExcludeClipRect(Canvas.Handle, RClient.Left, RClient.Top, RClient.Right, RClient.Bottom);
    End;
    RClient := ClientRect;
    FillRect(Canvas.Handle, RClient, Brush.Handle);
End;

Procedure TdevCustomTabs.SetBackTextColor(Value: TColor);
Begin
    If Value <> BackTextColor Then
    Begin
        FBackTextColor := Value;
        Invalidate;
    End;
End;

Procedure TdevCustomTabs.SetBackColor(Value: TColor);
Begin
    If Value <> BackColor Then
    Begin
        FBackColor := Value;
        Invalidate;
    End;
End;

Procedure TdevCustomTabs.SetLeftMargin(Value: Integer);
Begin
    If Value <> LeftMargin Then
    Begin
        FLeftMargin := Value;
        If Tabs.Count > 0 Then
            Invalidate;
    End;
End;

Procedure TdevCustomTabs.SetRightMargin(Value: Integer);
Begin
    If Value <> RightMargin Then
    Begin
        FRightMargin := Value;
        If Tabs.Count > 0 Then
            Invalidate;
    End;
End;

Function TdevCustomTabs.CanChange(NewIndex: Integer): Boolean;
Begin
    Result := True;
    If Assigned(FOnChanging) Then
        FOnChanging(Self, NewIndex, Result)
    Else Result := GetTabEnabled(NewIndex);
End;

Procedure TdevCustomTabs.Change;
Begin
    If assigned(fOnChange) Then
        fOnChange(Self);
End;

Procedure TdevCustomTabs.SetTabIndex(Value: Integer);
Begin
    If Value <> FTabIndex Then
    Begin
        FTabs[Value];
        If CanChange(Value) Then
        Begin
            FTabIndex := Value;
            Caption := Tabs[Value];
            ResetAutoMove;
            Change;
            If Not (csLoading In ComponentState) Then
                Click;
            Invalidate;
        End;
    End;
End;

Procedure TdevCustomTabs.SelectNext(Direction: Boolean);
Var
    NewIndex: Integer;
Begin
    If Tabs.Count > 1 Then
    Begin
        NewIndex := TabIndex;
        If Direction Then
            Inc(NewIndex)
        Else Dec(NewIndex);
        If NewIndex = Tabs.Count Then
            NewIndex := 0
        Else
        If NewIndex < 0 Then
            NewIndex := Tabs.Count - 1;
        TabIndex := NewIndex;
    End;
End;

Procedure TdevCustomTabs.SetTabs(Value: TStrings);
Begin
    FTabs.Assign(Value);
    FTabIndex := -1;
    If FTabs.Count > 0 Then
        TabIndex := 0
    Else Invalidate;
End;

Procedure TdevCustomTabs.SetOrientation(Value: TdevTabOrientation);
Begin
    If Value <> Orientation Then
    Begin
        FOrientation := Value;
        Invalidate;
        Realign;
    End;
End;

Procedure TdevCustomTabs.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
    I: Integer;
Begin
    FStarted := False;
    If Not (ssDouble In Shift) Then
    Begin
        I := TabAtPos(Point(X, Y));
        If I >= 0 Then
        Begin
            TabIndex := I;
            FStarted := True;
        End;
    End;
    Inherited MouseDown(Button, Shift, X, Y);
End;

Procedure TdevCustomTabs.CMFontChanged(Var Message: TMessage);
Begin
    Inherited;
    CalcTabHeight;
    Invalidate;
End;

Procedure TdevCustomTabs.WMGetDlgCode(Var Message: TWMGetDlgCode);
Begin
    Message.Result := DLGC_WANTALLKEYS;
End;

Procedure TdevCustomTabs.CMDialogChar(Var Message: TCMDialogChar);
Var
    I: Integer;
Begin
    For I := 0 To FTabs.Count - 1 Do
    Begin
        If IsAccel(Message.CharCode, FTabs[I]) Then
        Begin
            Message.Result := 1;
            If FTabIndex <> I Then
                SetTabIndex(I);
            Exit;
        End;
    End;
    Inherited;
End;

Procedure TdevCustomTabs.SetTabMargin(Value: Integer);
Begin
    If Value < 0 Then
        Value := 0;
    If Value <> TabMargin Then
    Begin
        FTabMargin := Value;
        If Tabs.Count > 0 Then
            Invalidate;
    End;
End;

Procedure TdevCustomTabs.MouseMove(Shift: TShiftState; X, Y: Integer);
Var
    R: TRect;
    I: Integer;
Begin
    If GetCapture = Handle Then
    Begin
        If FStarted Then
        Begin
            If AutoMove Then
            Begin
                I := IntTabAtPos(Point(X, Y), FAMList);
                If (I >= 0) And (I <> TabIndex) Then
                Begin
                    Tabs.Exchange(I, TabIndex);
                    Moved(I, TabIndex);
                    FTabIndex := I;
                    Invalidate;
                End;
            End;
            GetTabRect(R);
            If Not PtInRect(R, Point(X, Y)) Then
                BeginTabDrag;
        End;
    End;
    Inherited;
End;

Function TdevCustomTabs.GetAutoMove: Boolean;
Begin
    Result := FAMList <> Nil;
End;

Procedure TdevCustomTabs.SetAutoMove(Value: Boolean);
Begin
    If Value <> AutoMove Then
    Begin
        If Value Then
            FAMList := CalcTabWidth(Nil)
        Else FreeAndNil(FAMList);
    End;
End;

Procedure TdevCustomTabs.ResetAutoMove;
Begin
    If AutoMove Then
    Begin
        AutoMove := False;
        AutoMove := True;
    End;
End;

Procedure TdevCustomTabs.CalcTabHeight;
Var
    C: TCanvas;
    DC: HDC;
Begin
    DC := GetDC(0);
    Try
        C := TCanvas.Create;
        Try
            C.Handle := DC;
            Try
                C.Font := Font;
                FTabHeight := 5 + C.TextHeight('A');
                If (FImages <> Nil) And (FImages.Height > FTabHeight)
                Then
                    FTabHeight := FImages.Height;
                Inc(FTabHeight, 3);
            Finally
                C.Handle := 0;
            End;
        Finally
            C.Free;
        End;
    Finally
        ReleaseDC(0, DC);
    End;
End;

Procedure TdevCustomTabs.CreateParams(Var Params: TCreateParams);
Begin
    Inherited;
    Params.Style := Params.Style Or WS_CLIPCHILDREN Or WS_CLIPSIBLINGS;
    With Params.WindowClass Do
        Style := Style And Not (CS_HREDRAW Or CS_VREDRAW);
End;

Function TdevCustomTabs.GetTabBrush: THandle;
Begin
    Result := Brush.Handle;
End;

Procedure TdevCustomTabs.AdjustTabs;
Begin
    Invalidate;
    Realign;
End;

Procedure TdevCustomTabs.Moved(AFrom, ATo: Integer);
Begin
    If Assigned(FOnMoved) Then
        FOnMoved(Self, AFrom, ATo);
End;

Function TdevCustomTabs.GetImageIndex(TabIndex: Integer): Integer;
Begin
    Result := -1;
    If Assigned(FOnGetImage) Then
        FOnGetImage(Self, TabIndex, Result);
End;

Procedure TdevCustomTabs.SetImages(Value: TCustomImageList);
Begin
    If Images <> Nil Then
        Images.UnRegisterChanges(FImageChangeLink);
    FImages := Value;
    If Images <> Nil Then
    Begin
        Images.RegisterChanges(FImageChangeLink);
        Images.FreeNotification(Self);
    End;
    CalcTabHeight;
    AdjustTabs;
End;

Function TdevCustomTabs.GetTabEnabled(TabIndex: Integer): Boolean;
Begin
    Result := True;
End;

Procedure TdevCustomTabs.WMSize(Var Message: TWMSize);
Var
    R: TRect;
Begin
    Inherited;
    GetTabRect(R);
    InflateRect(R, 0, 2);
    InvalidateRect(Handle, @R, False);
End;

Procedure TdevCustomTabs.BeginTabDrag;
Begin
    If Assigned(FOnTabDrag) Then
        FOnTabDrag(Self);
End;

Procedure TdevCustomTabs.CMHintShow(Var Message: TCMHintShow);
Var
    I: Integer;
Begin
    Inherited;
    With Message Do
        If Result = 0 Then
        Begin
            I := TabAtPos(HintInfo^.CursorPos);
            HintInfo^.HintStr := '';
            If I >= 0 Then
            Begin
                HintInfo^.HintStr := Tabs[I];
                If pos('&&', HintInfo^.HintStr) > 0 Then
                    Delete(HintInfo^.HintStr, pos('&&', HintInfo^.HintStr), 1);
                HintInfo^.CursorRect := TabRect(I);
            End;
        End;
End;

Function ExtractCaption(AControl: TControl): String;
Var
    I: Integer;
Begin
    Result := THintWindow(AControl).Caption;
    For I := 1 To Length(Result) Do
        If Result[I] In [#13, #10] Then
        Begin
            SetLength(Result, I - 1);
            Break;
        End;
End;

Procedure TdevCustomPages.AddVisPage(APage: TdevPage);
Var
    I, VI: Integer;
    WPage: TdevPage;
Begin
    VI := 0;
    For I := 0 To FPages.Count - 1 Do
    Begin
        WPage := FPages[I];
        If WPage = APage Then
            Break
        Else
        If WPage.TabVisible Or (csDesigning In ComponentState) Then
            Inc(VI);
    End;
    Tabs.InsertObject(VI, APage.Caption, APage);
End;

Procedure TdevCustomPages.AddPage(APage: TdevPage);
Begin
    FPages.Add(APage);
    If (csDesigning In ComponentState) Or APage.TabVisible Then
    Begin
        AddVisPage(APage);
        If (csDesigning In ComponentState) Then
            ActivePage := APage;
    End;
End;

Constructor TdevCustomPages.Create(AOwner: TComponent);
Begin
    Inherited;
    ControlStyle := ControlStyle - [csAcceptsControls];
    FPages := TList.Create;
End;

Destructor TdevCustomPages.Destroy;
Var
    I: Integer;
Begin
    For I := 0 To FPages.Count - 1 Do
        TdevPage(FPages[I]).FPages := Nil;
    FPages.Free;
    Inherited;
End;

Function TdevCustomPages.CanChange(NewIndex: Integer): Boolean;
Begin
    Result := Inherited CanChange(NewIndex);
    If Result Then
        ActivePage := TdevPage(Tabs.Objects[NewIndex]);
End;

Function TdevCustomPages.GetTabEnabled(ATabIndex: Integer): Boolean;
Begin
    Result := (csDesigning In ComponentState) Or TdevPage(Tabs.Objects[ATabIndex]).Enabled;
End;

Function TdevCustomPages.GetPage(AIndex: Integer): TdevPage;
Begin
    Result := TdevPage(FPages[AIndex]);
End;

Function TdevCustomPages.GetPageCount: Integer;
Begin
    Result := FPages.Count;
End;

Function TdevCustomPages.GetActivePageIndex: Integer;
Begin
    Result := -1;
    If FPage <> Nil Then
        Result := FPage.PageIndex;
End;

Procedure TdevCustomPages.RemovePage(APage: TdevPage);
Begin
    FPages.Remove(APage);
    If APage.TabVisible Then
        RemoveVisPage(APage);
End;

Procedure TdevCustomPages.RemoveVisPage(APage: TdevPage);
Var
    I: Integer;
Begin
    I := Tabs.IndexOfObject(APage);
    If I >= 0 Then
    Begin
        Tabs.Delete(I);
        UpdatePage(Nil);
    End;
End;

Procedure TdevCustomPages.ChangeActive(Page: TdevPage);
Var
    ParentForm: TCustomForm;
Begin
    ParentForm := GetParentForm(Self);
    If (ParentForm <> Nil) And (FPage <> Nil) And FPage.ContainsControl(ParentForm.ActiveControl) Then
    Begin
        ParentForm.ActiveControl := FPage;
        If ParentForm.ActiveControl <> FPage Then
        Begin
            TabIndex := Tabs.IndexOfObject(FPage);
            Exit;
        End;
    End;
    If Page <> Nil Then
    Begin
        Page.BringToFront;
        Page.Visible := True;
        If (ParentForm <> Nil) And (FPage <> Nil) And
            (ParentForm.ActiveControl = FPage) Then
            If Page.CanFocus Then
                ParentForm.ActiveControl := Page Else
                ParentForm.ActiveControl := Self;
    End;
    If FPage <> Nil Then
        FPage.Visible := False;
    FPage := Page;
    If (ParentForm <> Nil) And (FPage <> Nil) And
        (ParentForm.ActiveControl = FPage) Then
        FPage.SelectFirst;
End;

Procedure TdevCustomPages.SetActivePage(Value: TdevPage);
Begin
    If (Value <> Nil) And (Value.Pages <> Self) Then
        Exit;
    If Value <> FPage Then
    Begin
        ChangeActive(Value);
        If Value = Nil Then
            TabIndex := -1
        Else
        If Value = FPage Then
            TabIndex := Tabs.IndexOfObject(FPage);
    End;
End;

Procedure TdevCustomPages.SetActivePageIndex(Value: Integer);
Begin
    ActivePage := Pages[Value];
End;

Function TdevCustomPages.GetTabBrush: THandle;
Begin
    If FPage <> Nil Then
        Result := FPage.Brush.Handle
    Else Result := Brush.Handle;
End;

Procedure TdevCustomPages.SetChildOrder(Child: TComponent; Order: Integer);
Begin
    TdevPage(Child).PageIndex := Order;
End;

Procedure TdevCustomPages.GetChildren(Proc: TGetChildProc; Root: TComponent);
Var
    I: Integer;
Begin
    For I := 0 To FPages.Count - 1 Do
        Proc(TComponent(FPages[I]));
End;

Procedure TdevCustomPages.UpdatePage(APage: TdevPage);
Var
    I: Integer;
Begin
    If APage = Nil Then
    Begin
        If TabIndex = -1 Then
            ActivePage := Nil
        Else ActivePage := TdevPage(Tabs.Objects[TabIndex]);
    End
    Else
    Begin
        I := FTabs.IndexOfObject(APage);
        If APage.TabVisible Or (csDesigning In ComponentState) Then
        Begin
            If I >= 0 Then
                Tabs[I] := APage.Caption
            Else AddVisPage(APage);
        End
        Else
        If I >= 0 Then
            RemoveVisPage(APage);
    End;
End;

Procedure TdevCustomPages.CMDesignHitTest(Var Msg: TCMDesignHitTest);
Begin
    Inherited;
    If TabAtPos(SmallPointToPoint(Msg.Pos)) >= 0 Then
        Msg.Result := HTCLIENT;
End;

Procedure TdevCustomPages.Moved(AFrom, ATo: Integer);
Begin
    FPages.Exchange(TdevPage(Tabs.Objects[AFrom]).PageIndex, TdevPage(Tabs.Objects[ATo]).PageIndex);
End;

Function TdevCustomPages.GetImageIndex(ATabIndex: Integer): Integer;
Begin
    Result := TdevPage(FTabs.Objects[ATabIndex]).ImageIndex;
End;

Procedure TdevCustomPages.WMLButtonDblClk(Var Message: TWMLButtonDblClk);
Var
    DockCtl: TControl;
Begin
    Inherited;
    DockCtl := GetDockClientFromPage(ActivePage);
    If DockCtl <> Nil Then
        DockCtl.ManualDock(Nil, Nil, alNone);
End;

Procedure TdevCustomPages.CMDockClient(Var Message: TCMDockClient);
Var
    IsVisible: Boolean;
    DockCtl: TControl;
Begin
    Message.Result := 0;
    FNewDockPage := TdevPage.Create(Self);
    Try
        Try
            DockCtl := Message.DockSource.Control;
            FNewDockPage.Caption := ExtractCaption(DockCtl);
            FNewDockPage.FSaveMode := TdevPages(DockCtl).DragMode;
            If DockCtl Is TWinControl Then
                FNewDockPage.FSaveDS := TdevPages(DockCtl).DockSite;
            TdevPages(DockCtl).DragMode := dmManual;
            FNewDockPage.Pages := Self;
            DockCtl.Dock(Self, Message.DockSource.DockRect);
        Except
            FNewDockPage.Free;
            Raise;
        End;
        IsVisible := DockCtl.Visible;
        FNewDockPage.Visible := IsVisible;
        If IsVisible Then
            ActivePage := FNewDockPage;
        DockCtl.Align := alClient;
    Finally
        FNewDockPage := Nil;
    End;
End;

Function TdevCustomPages.GetPageFromDockClient(Client: TControl): TdevPage;
Var
    I: Integer;
Begin
    Result := Nil;
    For I := 0 To PageCount - 1 Do
    Begin
        If (Client.Parent = Pages[I]) And (Client.HostDockSite = Self) Then
        Begin
            Result := Pages[I];
            exit;
        End;
    End;
End;

Procedure TdevCustomPages.CMDockNotification(Var Message: TCMDockNotification);
Var
    Page: TdevPage;
Begin
    Page := GetPageFromDockClient(Message.Client);
    If Page <> Nil Then
        Case Message.NotifyRec.ClientMsg Of
            WM_SETTEXT:
                Page.Caption := ExtractCaption(Message.Client);
            CM_VISIBLECHANGED:
            Begin
                Page.Visible := Boolean(Message.NotifyRec.MsgWParam);
                If Page.Visible Then
                    ActivePage := Page;
            End;
        End;
    Inherited;
End;

Procedure TdevCustomPages.CMUnDockClient(Var Message: TCMUnDockClient);
Var
    Page: TdevPage;
    DockCtl: TControl;
Begin
    Message.Result := 0;
    Page := GetPageFromDockClient(Message.Client);
    If Page <> Nil Then
    Begin
        FUndockingPage := Page;
        DockCtl := Message.Client;
        If DockCtl Is TWinControl Then
            TdevPages(DockCtl).DockSite := Page.FSaveDS;
        TdevPages(DockCtl).DragMode := Page.FSaveMode;
        DockCtl.Align := alNone;
    End;
End;

Procedure TdevCustomPages.DoAddDockClient(Client: TControl; Const ARect: TRect);
Begin
    If FNewDockPage <> Nil Then
        Client.Parent := FNewDockPage;
End;

Procedure TdevCustomPages.DockOver(Source: TDragDockObject; X, Y: Integer;
    State: TDragState; Var Accept: Boolean);
Var
    R: TRect;
Begin
    GetWindowRect(Handle, R);
    Source.DockRect := R;
    DoDockOver(Source, X, Y, State, Accept);
End;

Procedure TdevCustomPages.DoRemoveDockClient(Client: TControl);
Begin
    If (FUndockingPage <> Nil) And Not (csDestroying In ComponentState)
    Then
        FreeAndNil(FUndockingPage);
End;

Procedure TdevCustomPages.GetSiteInfo(Client: TControl;
    Var InfluenceRect: TRect; MousePos: TPoint; Var CanDock: Boolean);
Var
    R: TRect;
Begin
    CanDock := GetPageFromDockClient(Client) = Nil;
    If CanDock Then
    Begin
        GetTabRect(R);
        CanDock := PtInRect(R, ScreenToClient(MousePos));
    End;
    Inherited GetSiteInfo(Client, InfluenceRect, MousePos, CanDock);
End;

Procedure TdevCustomPages.BeginTabDrag;
Var
    DockCtl: TControl;
Begin
    DockCtl := GetDockClientFromPage(ActivePage);
    If (DockCtl <> Nil) Then
        DockCtl.BeginDrag(False);
End;

Function TdevCustomPages.GetDockClientFromPage(APage: TdevPage): TControl;
Begin
    Result := Nil;
    If (APage.ControlCount > 0) Then
    Begin
        Result := APage.Controls[0];
        If Result.HostDockSite <> Self Then
            Result := Nil;
    End;
End;

Procedure TdevCustomTabs.SetTabHidden(Value: Boolean);
Begin
    If Value <> FTabHidden Then
    Begin
        FTabHidden := Value;
        If Not (csDesigning In ComponentState) Then
        Begin
            Realign;
            Invalidate;
        End;
    End;
End;

Function TdevCustomTabs.GetTabHidden: Boolean;
Begin
    Result := FTabHidden;
    If csDesigning In ComponentState Then
        Result := False;
End;

{ TdevPage }

Procedure TdevPage.CMTextChanged(Var Msg: TMessage);
Begin
    Inherited;
    If FPages <> Nil Then
        FPages.UpdatePage(Self);
End;

Procedure TdevPage.CMVisibleChanged(Var Msg: TMessage);
Begin
    Inherited;
    If Not (csLoading In ComponentState) Then
    Begin
        If Visible Then
        Begin
            If Assigned(FOnShow) Then
                FOnShow(Self);
        End
        Else
        If Assigned(FOnHide) Then
            FOnHide(Self);
    End;
End;

Constructor TdevPage.Create(AOwner: TComponent);
Begin
    Inherited;
    ControlStyle := ControlStyle + [csAcceptsControls, csNoDesignVisible];
    BorderStyle := bsNone;
    ParentColor := True;
    ParentFont := True;
    Visible := False;
    Align := alClient;
    TabVisible := True;
    HorzScrollBar.Smooth := True;
    HorzScrollBar.Tracking := True;
    VertScrollBar.Smooth := True;
    VertScrollBar.Tracking := True;
    FImageIndex := -1;
End;

Destructor TdevPage.Destroy;
Begin
    If (Pages <> Nil) And Not (csDestroying In Pages.ComponentState) Then
    Begin
        If Pages.FUndockingPage = Self Then
            FPages.FUndockingPage := Nil;
        Pages := Nil;
    End;
    Inherited;
End;

Function TdevPage.GetIndex: Integer;
Begin
    Result := -1;
    If Pages <> Nil Then
        Result := Pages.FPages.IndexOf(Self);
End;

Procedure TdevPage.SetImageIndex(Value: TImageIndex);
Begin
    If FImageIndex <> Value Then
    Begin
        FImageIndex := Value;
        If FPages <> Nil Then
            FPages.Invalidate;
    End;
End;

Procedure TdevPage.SetIndex(Value: Integer);
Var
    I: Integer;
Begin
    If (FPages <> Nil) Then
    Begin
        I := PageIndex;
        If Value <> I Then
        Begin
            FPages.FPages.Move(I, Value);
            If TabVisible Or (csDesigning In ComponentState) Then
            Begin
                FPages.RemoveVisPage(Self);
                FPages.AddVisPage(Self);
            End;
        End;
    End;
End;

Procedure TdevPage.SetPages(Value: TdevCustomPages);
Begin
    If FPages <> Value Then
    Begin
        If FPages <> Nil Then
            FPages.RemovePage(Self);
        FPages := Value;
        If FPages <> Nil Then
        Begin
            Parent := FPages;
            FPages.AddPage(Self);
        End;
    End;
End;

Procedure TdevPage.SetParent(AParent: TWinControl);
Begin
    If AParent Is TdevPage Then
        AParent := TdevPage(AParent).Pages;
    Inherited;
    If (AParent = Nil) Or (AParent Is TdevCustomPages) Then
        Pages := TdevCustomPages(AParent);
End;

Procedure TdevPage.CMEnableChanged(Var Msg: TMessage);
Begin
    Inherited;
    If FPages <> Nil Then
        FPages.Invalidate;
End;

Procedure TdevPage.CMColorChanged(Var Msg: TMessage);
Begin
    Inherited;
    If Pages <> Nil Then
        Pages.Invalidate;
End;

Procedure TdevPage.CreateParams(Var Params: TCreateParams);
Begin
    Inherited;
    With Params.WindowClass Do
        style := style And Not (CS_HREDRAW Or CS_VREDRAW);
End;

Procedure TdevPage.SetTabVisible(Value: Boolean);
Begin
    If FTabVisible <> Value Then
    Begin
        FTabVisible := Value;
        If FPages <> Nil Then
            FPages.UpdatePage(Self);
    End;
End;

End.
