{================================================================================
Copyright (C) 1997-2002 Mills Enterprise

Original Unit     : rmCalendar
Purpose  : Replacement for the windows comctrl calendar.
           Also has CalendarCombo.
Date     : 01-01-1999
Original Author   : Ryan J. Mills
Modified by : Guru Kathiresan 09/28/2006
Version  : 1.92
================================================================================
}
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

Unit wxCalendarBase;

Interface

Uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, ExtCtrls, Grids, Buttons;

Type
    TrmCustomCalendar = Class;

    TCurrentDateValue = (cdvYear, cdvMonth, cdvDay);

    TPaintCellEvent = Procedure(Sender: TObject; ARow, ACol: Longint; Rect: TRect; State: TGridDrawState; Date: TDate) Of Object;

    TrmCalendarColors = Class(TPersistent)
    Private
        fWeekendText: TColor;
        fWeekdaybackground: TColor;
        fDayNamesBackground: TColor;
        fWeekdayText: TColor;
        fTodayText: TColor;
        fWeekendBackground: TColor;
        fDayNamesText: TColor;
        fOtherMonthDayBackground: TColor;
        fOtherMonthDayText: TColor;
        fCustomCalendar: TrmCustomCalendar;
        Procedure SetDayNamesBackground(Const Value: TColor);
        Procedure SetDayNamesText(Const Value: TColor);
        Procedure SetOtherMonthDayBackground(Const value: TColor);
        Procedure SetOtherMonthDayText(Const Value: TColor);
        Procedure SetTodayText(Const Value: TColor);
        Procedure Setweekdaybackground(Const Value: TColor);
        Procedure SetWeekdayText(Const Value: TColor);
        Procedure SetWeekendBackground(Const Value: TColor);
        Procedure SetWeekendText(Const Value: TColor);
        Procedure UpdateController;
    Public
        Constructor create;
        Procedure Assign(Source: TPersistent); Override;
        Property CustomCalendar: TrmCustomCalendar Read fCustomCalendar Write fCustomCalendar;
    Published
        Property WeekdayBackgroundColor: TColor Read fWeekdaybackground Write Setweekdaybackground Default clwindow;
        Property WeekdayTextColor: TColor Read fWeekdayText Write SetWeekdayText Default clWindowText;
        Property WeekendBackgroundColor: TColor Read fWeekendBackground Write SetWeekendBackground Default $00E1E1E1;
        Property WeekendTextColor: TColor Read fWeekendText Write SetWeekendText Default clTeal;
        Property DayNamesBackgroundColor: TColor Read fDayNamesBackground Write SetDayNamesBackground Default clBtnFace;
        Property DayNamesTextColor: TColor Read fDayNamesText Write SetDayNamesText Default clBtnText;
        Property TodayTextColor: TColor Read fTodayText Write SetTodayText Default clRed;
        Property OtherMonthDayTextColor: TColor Read fOtherMonthDayText Write SetOtherMonthDayText Default clBtnFace;
        Property OtherMonthDayBackgroundColor: TColor Read fOtherMonthDayBackground Write SetOtherMonthDayBackground Default clWindow;
    End;

    TrmCustomCalendar = Class(TCustomPanel)
    Private
    { Private declarations }
        fCalendarGrid: TDrawGrid;
        fLabel1: TLabel;
        fShowWeekends: Boolean;
        wYear, //Working Year
        wMonth, //Working Month
        wDay, //Working Day
        wfdow, //Working First Day of the Month (index into sun, mon, tue...)
        wdom: Word; //Working Days of Month
        fSelectionValid,
        fBoldSysdate: Boolean;
        fSelectedDate,
        fMinSelectDate,
        fMaxSelectDate,
        fworkingdate: TDate;
        fOnWorkingDateChange: TNotifyEvent;
        fOnSelectedDateChange: TNotifyEvent;
        fCalendarFont: TFont;
        fUseDateRanges: Boolean;
        fOnPaintCell: TPaintCellEvent;
        fCalendarColors: TrmCalendarColors;
        fShowGridLines: Boolean;
        Procedure setShowWeekends(Const Value: Boolean);
        Procedure SetSelectedDate(Const Value: TDate);
        Procedure SetWorkingDate(Const Value: TDate);
        Procedure SetCalendarFont(Const Value: TFont);
        Procedure SetMaxDate(Const Value: TDate);
        Procedure SetMinDate(Const Value: TDate);
        Procedure SetUseDateRanges(Const Value: Boolean);
        Procedure GetRowColInfo(wDate: TDate; Var Row, Col: Integer);
        Function CheckDateRange(wDate: TDate): TDate;

        Function ValidateDOW(row, col: Integer; Var daynumber: Integer): Boolean;
        Function MyEncodeDate(year, month, day: Word): TDateTime;
        Function CurrentDateValue(Value: TCurrentDateValue): Word;

        Procedure wmSize(Var Msg: TMessage); Message WM_Size;
        Procedure wmEraseBkgrnd(Var Msg: TMessage); Message WM_EraseBkgnd;
        Procedure CalendarSelectDate(Sender: TObject; Col, Row: Integer;
            Var CanSelect: Boolean);
        Procedure SetBoldSystemDate(Const Value: Boolean);
        Function GetCellCanvas: TCanvas;
        Procedure SetCalendarColors(Const Value: TrmCalendarColors);
        Procedure SetGridLines(Const Value: Boolean);
    Protected
    { Protected declarations }
        Procedure SetCellSizes;
        Procedure PaintCalendarCell(Sender: TObject; Col, Row: Longint; Rect: TRect; State: TGridDrawState);

        Procedure CalendarDblClick(Sender: TObject); Virtual;
        Procedure CalendarGridKeyPress(Sender: TObject; Var Key: Char); Virtual;
        Procedure CalendarKeyMovement(Sender: TObject; Var Key: Word; Shift: TShiftState); Virtual;

        Property ShowGridLines: Boolean Read fShowGridLines Write SetGridLines Default False;
        Property CalendarColors: TrmCalendarColors Read fCalendarColors Write SetCalendarColors;
        Property BoldSystemDate: Boolean Read fboldsysdate Write SetBoldSystemDate Default True;
        Property UseDateRanges: Boolean Read fUseDateRanges Write SetUseDateRanges Default False;
        Property MinDate: TDate Read fMinSelectDate Write SetMinDate;
        Property MaxDate: TDate Read fMaxSelectDate Write SetMaxDate;
        Property CalendarFont: TFont Read fCalendarFont Write SetCalendarFont;
        Property SelectedDate: TDate Read fSelectedDate Write SetSelectedDate;
        Property WorkingDate: TDate Read fworkingdate;
        Property ShowWeekends: Boolean Read fShowWeekends Write SetShowWeekends Default True;
        Property OnWorkingDateChange: TNotifyEvent Read fOnWorkingDateChange Write fOnWorkingDateChange;
        Property OnSelectedDateChange: TNotifyEvent Read fOnSelectedDateChange Write fOnSelectedDateChange;
        Property OnPaintCell: TPaintCellEvent Read fOnPaintCell Write fOnPaintCell;
    Public
    { Public declarations }
        Constructor create(AOwner: TComponent); Override;
        Destructor destroy; Override;
        Property CellCanvas: TCanvas Read GetCellCanvas;
        Procedure NextMonth;
        Procedure PrevMonth;
        Procedure NextYear;
        Procedure PrevYear;
        Function GoodCalendarSize(NewWidth: Integer): Boolean;
        Procedure Invalidate; Override;
    End;

    TrmCalendar = Class(TrmCustomCalendar)
    Public
    { Public declarations }
    Published
    { Published declarations }
        Property Align;
        Property Anchors;
        Property BorderStyle Default bsSingle;
        Property BevelInner Default bvNone;
        Property BevelOuter Default bvNone;

        Property CalendarColors;
        Property CalendarFont;
        Property SelectedDate;
        Property WorkingDate;
        Property ShowWeekends;
        Property UseDateRanges;
        Property MinDate;
        Property MaxDate;
        Property ShowGridLines;
        Property OnWorkingDateChange;
        Property OnSelectedDateChange;
        Property OnPaintCell;
    End;

Const
    WX_DaysOfMonth: Array[0..13] Of Integer = (31, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, 31); //Wrapped for proper month calculations...
    WX_WeekDay: Array[0..8] Of String = ('Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun');
    WX_MonthOfYear: Array[0..13] Of String = ('December', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December', 'January');


Implementation


Constructor TrmCustomCalendar.create(AOwner: TComponent);
Begin
    Inherited create(AOwner);

    ControlStyle := ControlStyle + [csOpaque];

    fCalendarColors := TrmCalendarColors.create;
    fCalendarColors.CustomCalendar := self;

    BorderWidth := 1;
    BorderStyle := bsSingle;
    BevelOuter := bvNone;
    BevelInner := bvNone;
    width := 205;
    height := 158;
    fUseDateRanges := False;
    fMinSelectDate := Now - 365; //Default it to be 1 year back
    fMaxSelectDate := Now + 365; //Default it to be 1 year ahead
    fBoldSysDate := True;

    fCalendarFont := tfont.create;
    fCalendarFont.assign(self.font);

    fLabel1 := TLabel.create(self);
    With fLabel1 Do
    Begin
        ParentFont := False;
        Parent := self;
        Align := alTop;
        Caption := WX_MonthOfYear[CurrentDateValue(cdvMonth)] + ' ' + inttostr(CurrentDateValue(cdvYear));
        Alignment := taCenter;
        Font.Size := self.font.size;
        Font.Style := [];
        TabStop := False;
    End;

    fShowGridLines := False;

    fCalendarGrid := TDrawGrid.Create(self);
    With FCalendarGrid Do
    Begin
        ParentFont := False;
        Parent := self;
        ControlStyle := ControlStyle - [csDesignInteractive];
        Align := alClient;
        BorderStyle := bsNone;
        ColCount := 7;
        FixedCols := 0;
        fixedRows := 0;
        RowCount := 7;
        ScrollBars := ssNone;
        Options := [];
        OnDrawCell := PaintCalendarCell;
        OnSelectCell := CalendarSelectDate;
        OnDblClick := CalendarDblClick;
        OnKeyPress := CalendarGridKeyPress;
        OnKeyDown := CalendarKeyMovement;
    End;

    fShowWeekends := True;

    SetCellSizes;
    SelectedDate := Now;
End;

Destructor TrmCustomCalendar.destroy;
Begin
    fCalendarGrid.free;
    fCalendarGrid := Nil;
    fLabel1.free;
    fCalendarFont.free;
    fCalendarColors.free;
    Inherited;
End;

Procedure TrmCustomCalendar.PaintCalendarCell(Sender: TObject; Col, Row: Integer;
    Rect: TRect; State: TGridDrawState);
Var
    TextToPaint: String;
    xpos, ypos, wdom, Daynumber: Integer;
    NewDayNumber: Integer;
    wPaintDate: Boolean;
    wPDate: TDate;
Begin
    wPDate := now;  //useless, only required to get past a compiler warning in D6
    wPaintDate := False;
    Case row Of
        0:
        Begin
            fCalendarGrid.canvas.brush.color := fCalendarColors.DayNamesBackgroundColor; //clbtnface;
            If ((col = 0) Or (col = 6)) And fShowWeekends Then
                fCalendarGrid.canvas.font.color := fCalendarColors.WeekendTextColor//fWeekendColor
            Else
                fCalendarGrid.canvas.font.color := fCalendarColors.DayNamesTextColor;//clbtntext;
            TextToPaint := WX_WeekDay[col + 1];
        End;
    Else
    Begin
        If ValidateDOW(row, col, DayNumber) Then
        Begin
            If (gdFocused In state) Then
                fSelectionValid := True;
            TextToPaint := inttostr(DayNumber);
            wPaintDate := True;
            wPDate := encodeDate(wyear, wmonth, DayNumber);
            If (gdSelected In state) Then
            Begin
                fCalendarGrid.canvas.font.color := clHighlightText;
                fCalendarGrid.canvas.brush.color := clHighlight;
                fworkingdate := MyEncodeDate(wYear, wMonth, DayNumber);
            End
            Else
            Begin
                If (((col = 0) Or (col = 6)) And fShowWeekends) Then
                Begin
                    fCalendarGrid.canvas.font.color := fCalendarColors.WeekendTextColor; //fWeekendColor;
                    fCalendarGrid.canvas.brush.color := fCalendarColors.WeekendBackgroundColor;//fweekendBkColor;
                End
                Else
                Begin
                    fCalendarGrid.canvas.font.color := fCalendarColors.WeekdayTextColor;//clWindowText;
                    fCalendarGrid.canvas.brush.color := fCalendarColors.WeekdayBackgroundColor;//clwindow;
                End;
            End;
        End
        Else
        Begin
            fCalendarGrid.canvas.font.color := fCalendarColors.OtherMonthDayTextColor; //clBtnFace;
            fCalendarGrid.canvas.brush.color := fCalendarColors.OtherMonthDayBackgroundColor;//clWindow;
            wdom := WX_DaysOfMonth[wmonth];
            If (IsLeapYear(wyear)) And (wmonth = 2) Then
                inc(wdom);
            If daynumber > wdom Then
            Begin
                NewDayNumber := daynumber - wdom;
                If NewDayNumber > wdom Then
                Begin
                    fCalendarGrid.canvas.brush.color := clInactiveCaption;
                    fCalendarGrid.canvas.brush.style := bsDiagCross;
                    fCalendarGrid.canvas.pen.Style := psClear;
                    fCalendarGrid.canvas.Rectangle(rect.left, rect.Top, rect.right + 1, rect.bottom + 1);
                    fCalendarGrid.canvas.brush.style := bsClear;
                    NewDayNumber := DayNumber;
                End;
            End
            Else
            Begin
                If (wmonth = 3) And IsLeapYear(wyear) Then
                Begin
                    NewDayNumber := (daynumber + WX_DaysOfMonth[wmonth - 1] + 1);
                    If (NewDayNumber > WX_DaysOfMonth[wmonth - 1] + 1) Then
                    Begin
                        fCalendarGrid.canvas.brush.color := clInactiveCaption;
                        fCalendarGrid.canvas.brush.style := bsDiagCross;
                        fCalendarGrid.canvas.pen.Style := psClear;
                        fCalendarGrid.canvas.Rectangle(rect.left, rect.Top, rect.right + 1, rect.bottom + 1);
                        fCalendarGrid.canvas.brush.style := bsClear;
                        NewDayNumber := DayNumber;
                    End;
                End
                Else
                Begin
                    NewDayNumber := (daynumber + WX_DaysOfMonth[wmonth - 1]);
                    If (NewDayNumber > WX_DaysOfMonth[wmonth - 1]) Then
                    Begin
                        fCalendarGrid.canvas.brush.color := clInactiveCaption;
                        fCalendarGrid.canvas.brush.style := bsDiagCross;
                        fCalendarGrid.canvas.pen.Style := psClear;
                        fCalendarGrid.canvas.Rectangle(rect.left, rect.Top, rect.right + 1, rect.bottom + 1);
                        fCalendarGrid.canvas.brush.style := bsClear;
                        NewDayNumber := DayNumber;
                    End;
                End;
            End;

            TextToPaint := inttostr(NewDayNumber);
        End;
        If (CurrentDateValue(cdvYear) = wyear) And (CurrentDateValue(cdvMonth) = wmonth) And (CurrentDateValue(cdvDay) = daynumber) Then
        Begin
            If (fboldsysdate) Then
                fCalendarGrid.canvas.font.Style := [fsBold]
            Else
                fCalendarGrid.canvas.font.Style := [];
            If Not (gdSelected In state) Then
                fCalendarGrid.Canvas.Font.Color := fCalendarColors.TodayTextColor;
        End;
    End;
    End;
    xpos := rect.Left + ((rect.right - rect.left) Shr 1) - (fCalendarGrid.canvas.textwidth(TextToPaint) Shr 1);
    ypos := rect.Top + ((rect.bottom - rect.top) Shr 1) - (fCalendarGrid.canvas.textheight(TextToPaint) Shr 1);

    If TextToPaint <> '' Then
        fCalendarGrid.canvas.TextRect(rect, xpos, ypos, TextToPaint);

    If wPaintDate And assigned(fonPaintCell) Then
        fOnPaintCell(Sender, Col, Row, Rect, State, wPDate);
End;

Procedure TrmCustomCalendar.SetCellSizes;
Var
    loop: Integer;
    h, w: Integer;
    mh, mw: Integer;
Begin
    h := fCalendarGrid.Height Div 7;
    mh := fCalendarGrid.Height Mod 7;
    w := fCalendarGrid.Width Div 7;
    mw := fCalendarGrid.Width Mod 7;

    For loop := 0 To 6 Do
    Begin
        If mw > 0 Then
        Begin
            dec(mw);
            If fShowGridLines Then
                fCalendarGrid.ColWidths[loop] := w
            Else
                fCalendarGrid.ColWidths[loop] := w + 1;
        End
        Else
            fCalendarGrid.ColWidths[loop] := w;

        If mh > 0 Then
        Begin
            dec(mh);
            If fShowGridLines Then
                fCalendarGrid.RowHeights[loop] := h
            Else
                fCalendarGrid.RowHeights[loop] := h + 1;
        End
        Else
            fCalendarGrid.RowHeights[loop] := h;
    End;
End;

Procedure TrmCustomCalendar.SetShowWeekends(Const Value: Boolean);
Begin
    fShowWeekends := value;
    fCalendarGrid.invalidate;
End;

Procedure TrmCustomCalendar.wmSize(Var Msg: TMessage);
Begin
    Inherited;
    SetCellSizes;
End;

Function TrmCustomCalendar.ValidateDOW(row, col: Integer;
    Var daynumber: Integer): Boolean;
Begin
    daynumber := ((col + ((row - 1) * 7)) - wfdow) + 2;
    If (daynumber >= 1) And (daynumber <= wdom) Then
        result := True
    Else
        result := False;

    If result And fUseDateRanges Then
    Begin
        result := (MyEncodeDate(wYear, wMonth, daynumber) >= fMinSelectDate) And
            (MyEncodeDate(wYear, wMonth, daynumber) <= fMaxSelectDate);
    End;
End;

Function TrmCustomCalendar.MyEncodeDate(year, month, day: Word): TDateTime;
Begin
    If day > WX_DaysOfMonth[month] Then
    Begin
        If (month = 2) And IsLeapYear(year) And (day >= 29) Then
            day := 29
        Else
            day := WX_DaysOfMonth[month];
    End;
    result := encodedate(year, month, day);
End;

Function TrmCustomCalendar.CurrentDateValue(
    Value: TCurrentDateValue): Word;
Var
    y, m, d: Word;
Begin
    decodeDate(Now, y, m, d);
    Case value Of
        cdvYear:
            result := y;
        cdvMonth:
            result := m;
        cdvDay:
            result := d;
    Else
        Raise exception.create('Unknown parameter');
    End;
End;

Procedure TrmCustomCalendar.SetSelectedDate(Const Value: TDate);
Var
    row, col: Integer;
Begin
    fSelectedDate := CheckDateRange(value);

    GetRowColInfo(fSelectedDate, row, Col);
    DecodeDate(fSelectedDate, wYear, wMonth, wDay);
    wdom := WX_DaysOfMonth[wmonth];
    wfdow := DayOfWeek(MyEncodeDate(wyear, wmonth, 1));
    If (isleapyear(wyear)) And (wmonth = 2) Then
        inc(wdom);

    fLabel1.Caption := WX_MonthOfYear[wMonth] + ' ' + inttostr(wYear);

    fCalendarGrid.Selection := TGridRect(rect(col, row, col, row));
    fCalendarGrid.Invalidate;

    If fworkingdate <> fSelectedDate Then
    Begin
        fworkingdate := fSelectedDate;
        If assigned(fOnWorkingDateChange) Then
            fOnWorkingDateChange(self);
    End;

    If assigned(fOnSelectedDateChange) Then
        fOnSelectedDateChange(self);
End;

Procedure TrmCustomCalendar.CalendarDblClick(Sender: TObject);
Begin
    If fSelectionValid Then
        SetSelectedDate(fWorkingDate);
End;

Procedure TrmCustomCalendar.CalendarGridKeyPress(Sender: TObject;
    Var Key: Char);
Begin
    If (key = #13) And fSelectionValid Then
        SetSelectedDate(fWorkingDate);
End;

Procedure TrmCustomCalendar.CalendarKeyMovement(Sender: TObject;
    Var Key: Word; Shift: TShiftState);
Var
    sday, smonth, syear: Word;
    dummy: Boolean;
    row, col: Integer;
Begin
    fCalendarGrid.setfocus;
    If key In [vk_left, vk_right, vk_up, vk_down] Then
        decodedate(fworkingdate, syear, smonth, sday);
    Case key Of
        vk_Left:
        Begin
            If ssCtrl In Shift Then
            Begin
                PrevMonth;
                Key := 0;
            End
            Else
            Begin
                If (fCalendarGrid.col - 1 = -1) Then
                Begin
                    If sDay - 1 >= 1 Then
                    Begin
                        GetRowColInfo(MyEncodeDate(sYear, sMonth, sDay - 1), Row, Col);
                        CalendarSelectDate(self, Col, Row, dummy);
                    End;
                    Key := 0;
                End;
            End;
        End;
        vk_Right:
        Begin
            If ssCtrl In Shift Then
            Begin
                NextMonth;
                Key := 0;
            End
            Else
            Begin
                If (fCalendarGrid.col + 1 = 7) Then
                Begin
                    If sDay + 1 <= wdom Then
                    Begin
                        GetRowColInfo(MyEncodeDate(sYear, sMonth, sDay + 1), Row, Col);
                        CalendarSelectDate(self, Col, Row, dummy);
                    End;
                    Key := 0;
                End;
            End;
        End;
        vk_Up:
        Begin
            If ssCtrl In Shift Then
            Begin
                PrevYear;
                key := 0;
            End
            Else
            Begin
            End;
        End;
        vk_Down:
        Begin
            If ssCtrl In Shift Then
            Begin
                NextYear;
                key := 0;
            End
            Else
            Begin
            End;
        End;
    End;
End;

Procedure TrmCustomCalendar.CalendarSelectDate(Sender: TObject; Col,
    Row: Integer; Var CanSelect: Boolean);
Var
    day: Integer;
Begin
    canselect := ValidateDOW(row, col, day);
    If canselect Then
        SetWorkingDate(MyEncodeDate(wyear, wmonth, day));
End;

Procedure TrmCustomCalendar.SetCalendarFont(Const Value: TFont);
Begin
    fCalendarFont.assign(value);
    fCalendarGrid.font.assign(fCalendarFont);
    fLabel1.font.assign(fCalendarFont);
    fLabel1.Font.size := fLabel1.Font.size + 4;
    fLabel1.Font.Style := fLabel1.Font.Style + [fsBold];
End;

Procedure TrmCustomCalendar.SetMaxDate(Const Value: TDate);
Var
    wDate: TDate;
Begin
    wDate := trunc(value);
    If wDate <> fMaxSelectDate Then
    Begin
        If wDate <= fMinSelectDate Then
            Raise Exception.Create('MaxDate value can''t be less than or equal to the MinDate value');
        fMaxSelectDate := wDate;
        If UseDateRanges And (SelectedDate > fMaxSelectDate) Then
            SelectedDate := fMaxSelectDate;
        fCalendarGrid.Invalidate;
    End;
End;

Procedure TrmCustomCalendar.SetMinDate(Const Value: TDate);
Var
    wDate: TDate;
Begin
    wDate := trunc(value);
    If wDate <> fMinSelectDate Then
    Begin
        If wDate >= fMaxSelectDate Then
            Raise Exception.Create('MinDate value can''t be greater than or equal to the MaxDate value');
        fMinSelectDate := wDate;
        If UseDateRanges And (SelectedDate < fMinSelectDate) Then
            SelectedDate := fMinSelectDate;
        fCalendarGrid.Invalidate;
    End;
End;

Procedure TrmCustomCalendar.SetUseDateRanges(Const Value: Boolean);
Begin
    If value <> fUseDateRanges Then
    Begin
        fUseDateRanges := Value;

        If fUseDateRanges Then
        Begin
            If SelectedDate < fMinSelectDate Then
                SelectedDate := fMinSelectDate;

            If SelectedDate > fMaxSelectDate Then
                SelectedDate := fMaxSelectDate;
        End;
        fCalendarGrid.Invalidate;
    End;
End;

Procedure TrmCustomCalendar.NextMonth;
Var
    sday, smonth, syear: Word;
Begin
    decodedate(fworkingdate, syear, smonth, sday);
    inc(sMonth);
    If sMonth > 12 Then
    Begin
        sMonth := 1;
        inc(sYear);
    End;
    SetWorkingDate(MyEncodeDate(sYear, sMonth, sDay));
End;

Procedure TrmCustomCalendar.NextYear;
Var
    sday, smonth, syear: Word;
Begin
    decodedate(fworkingdate, syear, smonth, sday);
    SetWorkingDate(MyEncodeDate(sYear + 1, sMonth, sDay));
End;

Procedure TrmCustomCalendar.PrevMonth;
Var
    sday, smonth, syear: Word;
Begin
    decodedate(fworkingdate, syear, smonth, sday);

    dec(sMonth);
    If sMonth < 1 Then
    Begin
        sMonth := 12;
        dec(sYear);
    End;

    SetWorkingDate(MyEncodeDate(sYear, sMonth, sDay));
End;

Procedure TrmCustomCalendar.PrevYear;
Var
    sday, smonth, syear: Word;
Begin
    decodedate(fworkingdate, syear, smonth, sday);
    SetWorkingDate(MyEncodeDate(sYear - 1, sMonth, sDay));
End;

Procedure TrmCustomCalendar.GetRowColInfo(wDate: TDate; Var Row,
    Col: Integer);
Var
    wyear, wmonth, wday: Word;
    wfdow: Integer;
Begin
    decodedate(wDate, wYear, wMonth, wDay);
    wfdow := DayOfWeek(MyEncodeDate(wyear, wmonth, 1));
    row := (((wday - 2) + wfdow) Div 7) + 1;
    col := (((wday - 2) + wfdow) Mod 7);
End;

Function TrmCustomCalendar.CheckDateRange(wDate: TDate): TDate;
Begin
    If fUseDateRanges Then
    Begin
        result := trunc(wDate);

        If (result < fMinSelectDate) Then
            result := fMinSelectDate;

        If (result > fMaxSelectDate) Then
            result := fMaxSelectDate;
    End
    Else
        result := trunc(wDate);
End;

Procedure TrmCustomCalendar.SetWorkingDate(Const Value: TDate);
Var
    row, col: Integer;
Begin
    fworkingdate := CheckDateRange(value);

    GetRowColInfo(fWorkingDate, row, col);

    DecodeDate(fworkingdate, wYear, wMonth, wDay);
    wdom := WX_DaysOfMonth[wmonth];
    wfdow := DayOfWeek(MyEncodeDate(wyear, wmonth, 1));
    If (isleapyear(wyear)) And (wmonth = 2) Then
        inc(wdom);

    fLabel1.Caption := WX_MonthOfYear[wMonth] + ' ' + inttostr(wYear);

    fCalendarGrid.Selection := TGridRect(rect(col, row, col, row));
    fCalendarGrid.Invalidate;
    If assigned(fOnWorkingDateChange) Then
        fOnWorkingDateChange(self);
End;

Procedure TrmCustomCalendar.SetBoldSystemDate(Const Value: Boolean);
Begin
    fboldsysdate := Value;
    invalidate;
End;

Function TrmCustomCalendar.GetCellCanvas: TCanvas;
Begin
    result := fCalendarGrid.Canvas;
End;

Procedure TrmCustomCalendar.SetCalendarColors(
    Const Value: TrmCalendarColors);
Begin
    fCalendarColors.Assign(Value);
    fCalendarGrid.Invalidate;
End;

Procedure TrmCustomCalendar.SetGridLines(Const Value: Boolean);
Begin
    If fShowGridLines <> Value Then
    Begin
        fShowGridLines := Value;
        If fShowGridLines Then
            fCalendarGrid.Options := [goVertLine, goHorzLine]
        Else
            fCalendarGrid.Options := [];
        SetCellSizes;
    End;
End;

Function TrmCustomCalendar.GoodCalendarSize(NewWidth: Integer): Boolean;
Begin
    Result := (NewWidth Mod 7) = 0;
End;

Procedure TrmCustomCalendar.wmEraseBkgrnd(Var Msg: TMessage);
Begin
    msg.result := 1;
End;

Procedure TrmCustomCalendar.Invalidate;
Begin
    If fCalendarGrid <> Nil Then
        fCalendarGrid.Invalidate;
    Inherited;
End;

{ TrmCalendarColors }

Procedure TrmCalendarColors.Assign(Source: TPersistent);
Var
    wColors: TrmCalendarColors;
Begin
    Inherited;
    If source Is TrmCalendarColors Then
    Begin
        wColors := TrmCalendarColors(source);
        fWeekendText := wColors.WeekdayTextColor;
        fWeekdaybackground := wColors.WeekdayBackgroundColor;
        fDayNamesBackground := wColors.DayNamesBackgroundColor;
        fDayNamesText := wColors.DayNamesTextColor;
        fWeekdayText := wColors.WeekdayTextColor;
        fTodayText := wColors.TodayTextColor;
        fWeekendBackground := wColors.WeekendBackgroundColor;
        fOtherMonthDayBackground := wColors.OtherMonthDayBackgroundColor;
        fOtherMonthDayText := wColors.OtherMonthDayTextColor;

        UpdateController;
    End;
End;

Constructor TrmCalendarColors.create;
Begin
    Inherited;
    fWeekendText := clTeal;
    fWeekdaybackground := clWindow;
    fDayNamesBackground := clBtnFace;
    fDayNamesText := clBtnText;
    fWeekdayText := clWindowText;
    fTodayText := clRed;
    fWeekendBackground := $00E1E1E1;
    fOtherMonthDayBackground := clWindow;
    fOtherMonthDayText := clBtnFace;
End;

Procedure TrmCalendarColors.SetDayNamesBackground(Const Value: TColor);
Begin
    If fDayNamesBackground <> Value Then
    Begin
        fDayNamesBackground := Value;
        fCustomCalendar.fLabel1.Color := Value;
        UpdateController;
    End;
End;

Procedure TrmCalendarColors.SetDayNamesText(Const Value: TColor);
Begin
    If fDayNamesText <> Value Then
    Begin
        fDayNamesText := Value;
        fCustomCalendar.fLabel1.Font.color := Value;
        UpdateController;
    End;
End;

Procedure TrmCalendarColors.SetOtherMonthDayBackground(Const Value: TColor);
Begin
    If (fOtherMonthDayBackground <> value) Then
    Begin
        fOtherMonthDayBackground := value;
        UpdateController;
    End;
End;

Procedure TrmCalendarColors.SetOtherMonthDayText(Const Value: TColor);
Begin
    If fOtherMonthDayText <> Value Then
    Begin
        fOtherMonthDayText := Value;
        UpdateController;
    End;
End;

Procedure TrmCalendarColors.SetTodayText(Const Value: TColor);
Begin
    If fTodayText <> Value Then
    Begin
        fTodayText := Value;
        UpdateController;
    End;
End;

Procedure TrmCalendarColors.Setweekdaybackground(Const Value: TColor);
Begin
    If fWeekdaybackground <> Value Then
    Begin
        fWeekdaybackground := Value;
        UpdateController;
    End;
End;

Procedure TrmCalendarColors.SetWeekdayText(Const Value: TColor);
Begin
    If fWeekdayText <> Value Then
    Begin
        fWeekdayText := Value;
        UpdateController;
    End;
End;

Procedure TrmCalendarColors.SetWeekendBackground(Const Value: TColor);
Begin
    If fWeekendBackground <> Value Then
    Begin
        fWeekendBackground := Value;
        UpdateController;
    End;
End;

Procedure TrmCalendarColors.SetWeekendText(Const Value: TColor);
Begin
    If fWeekendText <> Value Then
    Begin
        fWeekendText := Value;
        UpdateController;
    End;
End;

Procedure TrmCalendarColors.UpdateController;
Begin
    If assigned(fCustomCalendar) Then
        fcustomCalendar.fCalendarGrid.Invalidate;
End;

End.
