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

unit devMsgBox;

interface
uses
  Windows, Controls, Messages, StdCtrls;

  function devMessageBox(Parent: TWinControl; Prompt, Title, CheckText: string; Style: DWORD): Integer;

implementation
uses
  Classes, Forms, SysUtils;

type
  TdevMessageBox = class
    Parent: TWinControl;
    Prompt: string;
    Title: string;
    Style: DWORD;

    CheckText: string;
    CheckBox: HWND;
    Checked: Boolean;
  public
    constructor Create(Parent: TWinControl; Prompt, Title, CheckText: string; Style: DWORD);
    function Show: Integer;
  end;

var
  CurrentBox: TdevMessageBox;
  OldProc: function (hWnd: HWND; uMsg: UINT; wParam: wParam; lParam: LPARAM): LRESULT;
  Hook: HHOOK;

function HookProc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  CheckboxPlacement: WINDOWPLACEMENT;
  Placement: WINDOWPLACEMENT;
  CheckboxSize: TSize;
begin
  //Forward the call to Windows to handle everything (we are only supplementing)
  Result := CallWindowProc(@OldProc, hWnd, uMsg, wParam, lParam);

  //If we are creating the new Message Box, initialize it
  if uMsg = WM_INITDIALOG then
  begin
    //Get the position of the Message Box
    GetWindowPlacement(hwnd, @Placement);
    
    //Create the Check box
    CurrentBox.CheckBox := CreateWindow('BUTTON', PChar(CurrentBox.CheckText),
                                        WS_CHILD or WS_VISIBLE or BS_AUTOCHECKBOX,
                                        13, Placement.rcNormalPosition.Bottom - Placement.rcNormalPosition.Top - 40,
                                        0, 0, hWnd, 1000, 0, nil);
    SendMessage(CurrentBox.CheckBox, WM_SETFONT, SendMessage(GetDlgItem(hwnd, 65535), WM_GETFONT, 0, 0), 0);

    //Calculate the length of the label
    GetTextExtentPoint(GetDC(CurrentBox.CheckBox), PChar(CurrentBox.CheckText), Length(CurrentBox.CheckText), CheckboxSize);
    GetWindowPlacement(CurrentBox.CheckBox, @CheckboxPlacement);
    MoveWindow(CurrentBox.CheckBox, CheckboxPlacement.rcNormalPosition.Left,
               CheckboxPlacement.rcNormalPosition.Top, CheckboxSize.cx,
               CheckboxSize.cy, True);

    //Resize the dialog
    MoveWindow(hWnd, Placement.rcNormalPosition.Left, Placement.rcNormalPosition.Top,
               Placement.rcNormalPosition.Right - Placement.rcNormalPosition.Left,
               Placement.rcNormalPosition.Bottom - Placement.rcNormalPosition.Top + CheckboxSize.cy, True);
  end
  else if (uMsg = WM_COMMAND) and (wParam = 1000) then
    CurrentBox.Checked := SendMessage(CurrentBox.CheckBox, BM_GETCHECK, 0, 0) = BST_CHECKED;
end;

function SetHook(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
type
  PCWPSTRUCT = ^CWPSTRUCT; 
var
  pwp: CWPSTRUCT;
begin
  if nCode = HC_ACTION then
  begin
    pwp := PCWPSTRUCT(lParam)^;
    if pwp.message = WM_INITDIALOG then
      OldProc := Pointer(SetWindowLong(pwp.hwnd, GWL_WNDPROC, Longint(@HookProc)));
  end;

  Result := CallNextHookEx(Hook, nCode, wParam, lParam);
end;

function devMessageBox(Parent: TWinControl; Prompt, Title, CheckText: string; Style: DWORD): Integer;
begin
  with TdevMessageBox.Create(Parent, Prompt, Title, CheckText, Style) do
  begin
    Result := Show;
    Free;
  end;
end;

constructor TdevMessageBox.Create(Parent: TWinControl; Prompt, Title, CheckText: string; Style: DWORD);
begin
  Self.Parent := Parent;
  Self.Prompt := Prompt;
  Self.Title := Title;
  Self.Style := Style;
  Self.CheckText := CheckText;
end;

function TdevMessageBox.Show: Integer;
begin
  //Install the hook procedure
  CurrentBox := Self;
  Hook := SetWindowsHookEx(WH_CALLWNDPROC, @SetHook, 0, GetCurrentThreadId);

  //Show the message box
  Result := MessageBox(Parent.Handle, PChar(Prompt), PChar(Title), Style);

  //Uninstall the hook
  UnhookWindowsHookEx(Hook);
  if not CurrentBox.Checked then
    Result := -Result;
  CurrentBox := nil;
end;

end.
 