{ ****************************************************************** }
 {                                                                    }
 {                                                                    }
 {   VCL component TCustomWXDRadioGroup                               }
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

Unit CustomWXDRadioGroup;

Interface

Uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, ExtCtrls;

Type
    TWXDOrientation = (wxdHorizontal, wxdVertical);



    TCustomWXDRadioGroup = Class(TCustomRadioGroup)
    Private
    { Private declarations }
        FButtons: TList;
        FItems: TStrings;
        FItemIndex: Integer;
        FColumns: Integer;
        FRows: Integer;
        FOrientation: TWXDOrientation;
        FMajorDimension: Integer;
        FReading: Boolean;
        FUpdating: Boolean;
        Procedure ArrangeButtons;
        Procedure ButtonClick(Sender: TObject);
        Procedure ItemsChange(Sender: TObject);
        Procedure SetButtonCount(Value: Integer);
        Procedure SetColumns(Value: Integer);
        Procedure SetRows(Value: Integer);
        Procedure SetOrientation(Const Value: TWXDOrientation);
        Procedure SetMajorDimension(Value: Integer);
        Procedure SetItemIndex(Value: Integer);
        Procedure SetItems(Value: TStrings);
        Procedure UpdateButtons;
        Procedure CMEnabledChanged(Var Message: TMessage); Message
            CM_ENABLEDCHANGED;
        Procedure CMFontChanged(Var Message: TMessage); Message CM_FONTCHANGED;
        Procedure WMSize(Var Message: TWMSize); Message WM_SIZE;
    Protected
    { Protected declarations }
        Procedure Loaded; Override;
        Procedure ReadState(Reader: TReader); Override;
        Procedure GetChildren(Proc: TGetChildProc; Root: TComponent); Override;
        Property Columns: Integer Read FColumns Write SetColumns Default 1;
        Property Rows: Integer Read FRows Write SetRows Default 1;
        Property MajorDimension: Integer Read FMajorDimension Write SetMajorDimension Default 1;

        Property Orientation: TWXDOrientation Read FOrientation Write SetOrientation;
        Property ItemIndex: Integer Read FItemIndex Write SetItemIndex Default -1;
        Property Items: TStrings Read FItems Write SetItems;
    Public
    { Public declarations }
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Procedure FlipChildren(AllLevels: Boolean); Override;
    Published
    { Published declarations }
    End;

    TWXDRadioGroup = Class(TCustomWXDRadioGroup)
    Published
        Property Align;
        Property Anchors;
        Property BiDiMode;
        Property Caption;
        Property Color;
        Property MajorDimension;
        Property Orientation;
        Property Ctl3D;
        Property DragCursor;
        Property DragKind;
        Property DragMode;
        Property Enabled;
        Property Font;
        Property ItemIndex;
        Property Items;
        Property Constraints;
        Property ParentBiDiMode;
        Property ParentColor;
        Property ParentCtl3D;
        Property ParentFont;
        Property ParentShowHint;
        Property PopupMenu;
        Property ShowHint;
        Property TabOrder;
        Property TabStop;
        Property Visible;
        Property OnClick;
        Property OnContextPopup;
        Property OnDragDrop;
        Property OnDragOver;
        Property OnEndDock;
        Property OnEndDrag;
        Property OnEnter;
        Property OnExit;
        Property OnStartDock;
        Property OnStartDrag;
    End;

Procedure Register;

Implementation

{ TWXDGroupButton }

Type
    TWXDGroupButton = Class(TRadioButton)
    Private
        FInClick: Boolean;
        Procedure CNCommand(Var Message: TWMCommand); Message CN_COMMAND;
    Protected
        Procedure KeyDown(Var Key: Word; Shift: TShiftState); Override;
        Procedure KeyPress(Var Key: Char); Override;
    Public
        Constructor InternalCreate(RadioGroup: TCustomWXDRadioGroup);
        Destructor Destroy; Override;
    End;

Constructor TWXDGroupButton.InternalCreate(RadioGroup: TCustomWXDRadioGroup);
Begin
    Inherited Create(RadioGroup);
    RadioGroup.FButtons.Add(Self);
    Visible := False;
    Enabled := RadioGroup.Enabled;
    ParentShowHint := False;
    OnClick := RadioGroup.ButtonClick;
    Parent := RadioGroup;
End;

Destructor TWXDGroupButton.Destroy;
Begin
    TCustomWXDRadioGroup(Owner).FButtons.Remove(Self);
    Inherited Destroy;
End;

Procedure TWXDGroupButton.CNCommand(Var Message: TWMCommand);
Begin
    If Not FInClick Then
    Begin
        FInClick := True;
        Try
            If ((Message.NotifyCode = BN_CLICKED) Or
                (Message.NotifyCode = BN_DOUBLECLICKED)) And
                TCustomWXDRadioGroup(Parent).CanModify Then
                Inherited;
        Except
            Application.HandleException(Self);
        End;
        FInClick := False;
    End;
End;

Procedure TWXDGroupButton.KeyPress(Var Key: Char);
Begin
    Inherited KeyPress(Key);
    TCustomWXDRadioGroup(Parent).KeyPress(Key);
    If (Key = #8) Or (Key = ' ') Then
    Begin
        If Not TCustomWXDRadioGroup(Parent).CanModify Then
            Key := #0;
    End;
End;

Procedure TWXDGroupButton.KeyDown(Var Key: Word; Shift: TShiftState);
Begin
    Inherited KeyDown(Key, Shift);
    TCustomWXDRadioGroup(Parent).KeyDown(Key, Shift);
End;

{ TCustomWXDRadioGroup }

Constructor TCustomWXDRadioGroup.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);
    ControlStyle := [csSetCaption, csDoubleClicks];
    FButtons := TList.Create;
    FItems := TStringList.Create;
    TStringList(FItems).OnChange := ItemsChange;
    FItemIndex := -1;
    FColumns := 1;
    FRows := 1;
    FMajorDimension := 1;
    FOrientation := wxdHorizontal;
End;

Destructor TCustomWXDRadioGroup.Destroy;
Begin
    SetButtonCount(0);
    TStringList(FItems).OnChange := Nil;
    FItems.Free;
    FButtons.Free;
    Inherited Destroy;
End;

Procedure TCustomWXDRadioGroup.FlipChildren(AllLevels: Boolean);
Begin
  { The radio buttons are flipped using BiDiMode }
End;

Procedure TCustomWXDRadioGroup.ArrangeButtons;
Var
    ButtonWidth, ButtonHeight, TopMargin, I: Integer;
    DC: HDC;
    SaveFont: HFont;
    Metrics: TTextMetric;
    DeferHandle: THandle;
    ALeft, ATop: Integer;
    textlength: Integer;

Begin
    ALeft := 0;
    ATop := 0;
    If (FButtons.Count <> 0) And Not FReading Then
    Begin
  // get the length in pixels of the longest radio button label
        textlength := 0;
        If self.Items.Count <> 0 Then
        Begin
            For I := 0 To self.Items.Count - 1 Do
                If Canvas.TextWidth(self.Items[I]) > textlength Then
                    textlength := Canvas.TextWidth(self.Items[I]);
        End;
        DC := GetDC(0);
        SaveFont := SelectObject(DC, Font.Handle);
        GetTextMetrics(DC, Metrics);
        SelectObject(DC, SaveFont);
        ReleaseDC(0, DC);

        Case Orientation Of
            wxdHorizontal:
            Begin
                FRows := FMajorDimension;
                If (FButtons.Count Mod FMajorDimension) = 0 Then
                    FColumns := FButtons.Count Div FMajorDimension
                Else
                    FColumns := (FButtons.Count Div FMajorDimension) + 1;
            End;
            wxdVertical:
            Begin
                FColumns := FMajorDimension;
                If (FButtons.Count Mod FMajorDimension) = 0 Then
                    FRows := FButtons.Count Div FMajorDimension
                Else
                    FRows := (FButtons.Count Div FMajorDimension) + 1;
            End;
        End;

        ButtonWidth := 24 + textlength;
        ButtonHeight := 19;
        TopMargin := Metrics.tmHeight + 1;
        DeferHandle := BeginDeferWindowPos(FButtons.Count);
        Try
            For I := 0 To FButtons.Count - 1 Do
                With TWXDGroupButton(FButtons[I]) Do
                Begin
                    BiDiMode := Self.BiDiMode;

                    Case Orientation Of
                        wxdHorizontal:
                        Begin
                            ALeft := (I Div FRows) * ButtonWidth + 8;
                            ATop := (I Mod FRows) * ButtonHeight + TopMargin;
                        End;
                        wxdVertical:
                        Begin
                            ALeft := (I Mod FColumns) * ButtonWidth + 8;
                            ATop := (I Div FColumns) * ButtonHeight + TopMargin;
                        End;
                    End;

                    If UseRightToLeftAlignment Then
                        ALeft := Self.ClientWidth - ALeft - ButtonWidth;

                    DeferHandle := DeferWindowPos(DeferHandle, Handle, 0,
                        ALeft,
                        ATop,
                        ButtonWidth, ButtonHeight,
                        SWP_NOZORDER Or SWP_NOACTIVATE);

                    Visible := True;
                End;
        Finally
            EndDeferWindowPos(DeferHandle);
        End;
    End;
End;

Procedure TCustomWXDRadioGroup.ButtonClick(Sender: TObject);
Begin
    If Not FUpdating Then
    Begin
        FItemIndex := FButtons.IndexOf(Sender);
        Changed;
        Click;
    End;
End;

Procedure TCustomWXDRadioGroup.ItemsChange(Sender: TObject);
Begin
    If Not FReading Then
    Begin
        If FItemIndex >= FItems.Count Then
            FItemIndex := FItems.Count - 1;
        UpdateButtons;
    End;
End;

Procedure TCustomWXDRadioGroup.Loaded;
Begin
    Inherited Loaded;
    ArrangeButtons;
End;

Procedure TCustomWXDRadioGroup.ReadState(Reader: TReader);
Begin
    FReading := True;
    Inherited ReadState(Reader);
    FReading := False;
    UpdateButtons;
End;

Procedure TCustomWXDRadioGroup.SetButtonCount(Value: Integer);
Begin
    While FButtons.Count < Value Do
        TWXDGroupButton.InternalCreate(Self);
    While FButtons.Count > Value Do
        TWXDGroupButton(FButtons.Last).Free;
End;

Procedure TCustomWXDRadioGroup.SetColumns(Value: Integer);
Begin
    If Value < 1 Then
        Value := 1;
    If Value > 16 Then
        Value := 16;
    If FColumns <> Value Then
    Begin
        FColumns := Value;
        ArrangeButtons;
        Invalidate;
    End;
End;

Procedure TCustomWXDRadioGroup.SetRows(Value: Integer);
Begin
    If Value < 1 Then
        Value := 1;
    If Value > 16 Then
        Value := 16;
    If FRows <> Value Then
    Begin
        FRows := Value;
        ArrangeButtons;
        Invalidate;
    End;
End;

Procedure TCustomWXDRadioGroup.SetMajorDimension(Value: Integer);
Begin
    If Value < 1 Then
        Value := 1;
    If Value > 16 Then
        Value := 16;
    If FMajorDimension <> Value Then
    Begin
        FMajorDimension := Value;
        ArrangeButtons;
        Invalidate;
    End;
End;

Procedure TCustomWXDRadioGroup.SetItemIndex(Value: Integer);
Begin
    If FReading Then
        FItemIndex := Value Else
    Begin
        If Value < -1 Then
            Value := -1;
        If Value >= FButtons.Count Then
            Value := FButtons.Count - 1;
        If FItemIndex <> Value Then
        Begin
            If FItemIndex >= 0 Then
                TWXDGroupButton(FButtons[FItemIndex]).Checked := False;
            FItemIndex := Value;
            If FItemIndex >= 0 Then
                TWXDGroupButton(FButtons[FItemIndex]).Checked := True;
        End;
    End;
End;

Procedure TCustomWXDRadioGroup.SetItems(Value: TStrings);
Begin
    FItems.Assign(Value);
End;

Procedure TCustomWXDRadioGroup.UpdateButtons;
Var
    I: Integer;
Begin
    SetButtonCount(Items.Count);
    For I := 0 To FButtons.Count - 1 Do
    Begin
        TWXDGroupButton(FButtons[I]).Caption := FItems[I];
    End;
    If FItemIndex >= 0 Then
    Begin
        FUpdating := True;
        TWXDGroupButton(FButtons[FItemIndex]).Checked := True;
        FUpdating := False;
    End;
    ArrangeButtons;
    Invalidate;
End;

Procedure TCustomWXDRadioGroup.CMEnabledChanged(Var Message: TMessage);
Var
    I: Integer;
Begin
    Inherited;
    For I := 0 To FButtons.Count - 1 Do
        TWXDGroupButton(FButtons[I]).Enabled := Enabled;
End;

Procedure TCustomWXDRadioGroup.CMFontChanged(Var Message: TMessage);
Begin
    Inherited;
    ArrangeButtons;
End;

Procedure TCustomWXDRadioGroup.WMSize(Var Message: TWMSize);
Begin
    Inherited;
    ArrangeButtons;
End;

Procedure TCustomWXDRadioGroup.GetChildren(Proc: TGetChildProc; Root:
    TComponent);
Begin
End;

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWXDRadioGroup]);
End;

Procedure TCustomWXDRadioGroup.SetOrientation(Const Value: TWXDOrientation);
Begin
    FOrientation := Value;
    ArrangeButtons;
    Invalidate;
End;


End.