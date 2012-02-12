{
    $Id: devMsgBox.pas 894 2007-02-20 11:10:37Z lowjoel $

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

Unit devMsgBox;

Interface
Uses
    Windows, Controls, Messages, StdCtrls;

Function devMessageBox(Parent: TWinControl; Prompt, Title, CheckText: String; Style: DWORD): Integer;

Implementation
Uses
    Classes, Forms, SysUtils;

Type
    TdevMessageBox = Class
        Parent: TWinControl;
        Prompt: String;
        Title: String;
        Style: DWORD;

        CheckText: String;
        CheckBox: HWND;
        Checked: Boolean;
    Public
        Constructor Create(Parent: TWinControl; Prompt, Title, CheckText: String; Style: DWORD);
        Function Show: Integer;
    End;

Var
    CurrentBox: TdevMessageBox;
    OldProc: Function(hWnd: HWND; uMsg: UINT; wParam: wParam; lParam: LPARAM): LRESULT;
    Hook: HHOOK;

Function HookProc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; Stdcall;
Var
    CheckboxPlacement: WINDOWPLACEMENT;
    Placement: WINDOWPLACEMENT;
    CheckboxSize: TSize;
Begin
  //Forward the call to Windows to handle everything (we are only supplementing)
    Result := CallWindowProc(@OldProc, hWnd, uMsg, wParam, lParam);

  //If we are creating the new Message Box, initialize it
    If uMsg = WM_INITDIALOG Then
    Begin
    //Get the position of the Message Box
        GetWindowPlacement(hwnd, @Placement);

    //Create the Check box
        CurrentBox.CheckBox := CreateWindow('BUTTON', Pchar(CurrentBox.CheckText),
            WS_CHILD Or WS_VISIBLE Or BS_AUTOCHECKBOX,
            13, Placement.rcNormalPosition.Bottom - Placement.rcNormalPosition.Top - 40,
            0, 0, hWnd, 1000, 0, Nil);
        SendMessage(CurrentBox.CheckBox, WM_SETFONT, SendMessage(GetDlgItem(hwnd, 65535), WM_GETFONT, 0, 0), 0);

    //Calculate the length of the label
        GetTextExtentPoint(GetDC(CurrentBox.CheckBox), Pchar(CurrentBox.CheckText), Length(CurrentBox.CheckText), CheckboxSize);
        GetWindowPlacement(CurrentBox.CheckBox, @CheckboxPlacement);
        MoveWindow(CurrentBox.CheckBox, CheckboxPlacement.rcNormalPosition.Left,
            CheckboxPlacement.rcNormalPosition.Top, CheckboxSize.cx,
            CheckboxSize.cy, True);

    //Resize the dialog
        MoveWindow(hWnd, Placement.rcNormalPosition.Left, Placement.rcNormalPosition.Top,
            Placement.rcNormalPosition.Right - Placement.rcNormalPosition.Left,
            Placement.rcNormalPosition.Bottom - Placement.rcNormalPosition.Top + CheckboxSize.cy, True);
    End
    Else
    If (uMsg = WM_COMMAND) And (wParam = 1000) Then
        CurrentBox.Checked := SendMessage(CurrentBox.CheckBox, BM_GETCHECK, 0, 0) = BST_CHECKED;
End;

Function SetHook(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; Stdcall;
Type
    PCWPSTRUCT = ^CWPSTRUCT;
Var
    pwp: CWPSTRUCT;
Begin
    If nCode = HC_ACTION Then
    Begin
        pwp := PCWPSTRUCT(lParam)^;
        If pwp.message = WM_INITDIALOG Then
            OldProc := Pointer(SetWindowLong(pwp.hwnd, GWL_WNDPROC, Longint(@HookProc)));
    End;

    Result := CallNextHookEx(Hook, nCode, wParam, lParam);
End;

Function devMessageBox(Parent: TWinControl; Prompt, Title, CheckText: String; Style: DWORD): Integer;
Begin
    With TdevMessageBox.Create(Parent, Prompt, Title, CheckText, Style) Do
    Begin
        Result := Show;
        Free;
    End;
End;

Constructor TdevMessageBox.Create(Parent: TWinControl; Prompt, Title, CheckText: String; Style: DWORD);
Begin
    Self.Parent := Parent;
    Self.Prompt := Prompt;
    Self.Title := Title;
    Self.Style := Style;
    Self.CheckText := CheckText;
End;

Function TdevMessageBox.Show: Integer;
Begin
  //Install the hook procedure
    CurrentBox := Self;
    Hook := SetWindowsHookEx(WH_CALLWNDPROC, @SetHook, 0, GetCurrentThreadId);

  //Show the message box
    Result := MessageBox(Parent.Handle, Pchar(Prompt), Pchar(Title), Style);

  //Uninstall the hook
    UnhookWindowsHookEx(Hook);
    If Not CurrentBox.Checked Then
        Result := -Result;
    CurrentBox := Nil;
End;

End.
 