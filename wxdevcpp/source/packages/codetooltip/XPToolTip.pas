{----------------------------------------------------------------------------------

  The contents of this file are subject to the GNU General Public License
  Version 1.1 or later (the "License"); you may not use this file except in
  compliance with the License. You may obtain a copy of the License at
  http://www.gnu.org/copyleft/gpl.html

  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
  the specific language governing rights and limitations under the License.

  The Initial Developer of the Original Code is Peter Schraut.
  http://www.console-dev.de

  
  Portions created by Peter Schraut are Copyright 
  (C) 2003, 2003 by Peter Schraut (http://www.console-dev.de) 
  All Rights Reserved.
  
----------------------------------------------------------------------------------}

//
//  TCustomXPToolTip features:  
//
//    Alphablending under windows 2000 and xp
//    Drops a shadow under windows xp
//    draws a black border around the hint, like the system hints from win2k and xp
//

Unit XPToolTip;

Interface

Uses
{$IFDEF WIN32}
    SysUtils, Dialogs, Classes, Windows, Messages, Graphics, Controls, Menus, Forms, StdCtrls;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, QDialogs, Classes, QGraphics, QControls, QMenus, QForms, QStdCtrls, Types;
{$ENDIF}


Type
    TCustomToolTip = Class(THintWindow)
    Private
        FActivated: Boolean;
    Protected
        Property Activated: Boolean Read FActivated;
    Public
        Constructor Create(AOwner: TComponent); Override;
{$IFDEF WIN32}
        Procedure ActivateHint(Rect: TRect; Const AHint: String); Override;
{$ENDIF}
{$IFDEF LINUX}
    procedure ActivateHint(Rect: TRect; const AHint: WideString); override;
{$ENDIF}
        Procedure ReleaseHandle; Virtual;
    End;


    TToolTip = Class(TCustomToolTip)
    Public
        Property Activated;
    End;


    TCustomXPToolTip = Class(TCustomToolTip)
    Private
        FAlphaBlend: Boolean;
        FAlphaBlendValue: Byte;
        FDropShadow: Boolean;
        Procedure SetAlphaBlend(Value: Boolean);
        Procedure SetAlphaBlendValue(Value: Byte);
        Procedure SetDropShadow(Value: Boolean);
        Procedure WMNCHitTest(Var Message: TWMNCHitTest); Message WM_NCHITTEST;
        Procedure WMNCPaint(Var msg: TMessage); Message WM_NCPAINT;
    Protected
        Procedure CreateParams(Var Params: TCreateParams); Override;
        Property AlphaBlend: Boolean Read FAlphaBlend Write SetAlphaBlend Default False;
        Property AlphaBlendValue: Byte Read FAlphaBlendValue Write SetAlphaBlendValue Default 255;
        Property DropShadow: Boolean Read FDropShadow Write SetDropShadow Default True;
    Public
        Constructor Create(AOwner: TComponent); Override;
{$IFDEF WIN32}
        Procedure ActivateHint(Rect: TRect; Const AHint: String); Override;
{$ENDIF}
{$IFDEF LINUX}
    procedure ActivateHint(Rect: TRect; const AHint: WideString); override;
{$ENDIF}
    End;


    TXPToolTip = Class(TCustomXPToolTip)
    Public
        Property Activated;
    Published
        Property AlphaBlend;
        Property AlphaBlendValue;
        Property DropShadow;
    End;

Const
    clXPToolTipBk: TColor = $E1FFFF;

Implementation
Var
    SetLayeredWindowAttributesProc: Function(hWnd: HWND; crKey: TColor; bAlpha: Byte; dwFlags: DWORD): BOOL; Stdcall;

//----------------- local helper functions -----------------------------------------------------------------------------

Function IsWin2kOrLater: Boolean;
  // returns true when the operating system is windows 2000 or newer  
Begin
{$IFDEF WIN32}
    Result := (Win32Platform = VER_PLATFORM_WIN32_NT) And (Win32MajorVersion >= 5);
{$ENDIF}
{$IFDEF LINUX}
    Result := False;
{$ENDIF}
End;

Function IsWinXP: Boolean;
  // returns true when the operating system is windows XP or newer  
Begin
{$IFDEF WIN32}
    Result := (Win32Platform = VER_PLATFORM_WIN32_NT) And (Win32MajorVersion >= 5) And (Win32MinorVersion >= 1);
{$ENDIF}
{$IFDEF LINUX}
    Result := False;
{$ENDIF}
End;

//----------------- TCustomToolTip -------------------------------------------------------------------------------------

Constructor TCustomToolTip.Create(AOwner: TComponent);
Begin
    Inherited;

    FActivated := False;
    Color := clXPToolTipBk;
End;

//----------------------------------------------------------------------------------------------------------------------

{$IFDEF WIN32}
Procedure TCustomToolTip.ActivateHint(Rect: TRect; Const AHint: String);
{$ENDIF}
{$IFDEF LINUX}
procedure TCustomToolTip.ActivateHint(Rect: TRect; const AHint: WideString);
{$ENDIF}
Begin
    Inherited;
    FActivated := True;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomToolTip.ReleaseHandle;
Begin
    FActivated := False;
    DestroyHandle;
End;

//----------------- TCustomXPToolTip -----------------------------------------------------------------------------------

Constructor TCustomXPToolTip.Create(AOwner: TComponent);
Begin
    Inherited;

    Color := clXPToolTipBk;
    FAlphaBlend := False;
    FAlphaBlendValue := 255;
    FDropShadow := True;

    SetAlphaBlend(FAlphaBlend);
    SetAlphaBlendValue(FAlphaBlendValue);
End;

//----------------------------------------------------------------------------------------------------------------------

{$IFDEF WIN32}
Procedure TCustomXPToolTip.ActivateHint(Rect: TRect; Const AHint: String);
{$ENDIF}
{$IFDEF LINUX}
procedure TCustomXPToolTip.ActivateHint(Rect: TRect; const AHint: WideString);
{$ENDIF}
Const
    CS_DROPSHADOW = $00020000;
Begin
    If IsWinXP Then
    Begin
        If FDropShadow Then
            SetClassLong(Handle, GCL_STYLE, GetClassLong(Handle, GCL_STYLE) Or CS_DROPSHADOW)
        Else
            SetClassLong(Handle, GCL_STYLE, GetClassLong(Handle, GCL_STYLE) And Not CS_DROPSHADOW);
    End;

    SetAlphaBlend(FAlphaBlend);
    SetAlphaBlendValue(FAlphaBlendValue);

    Inherited;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomXPToolTip.CreateParams(Var Params: TCreateParams);
Begin
    Inherited;
{TODO: 'winnt: The next line breaks tooltip on nt which crashes anyway'}
    If IsWin2kOrLater Then
        Params.ExStyle := Params.ExStyle Or WS_EX_LAYERED;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomXPToolTip.SetAlphaBlend(Value: Boolean);
Const
    WS_EX_LAYERED = $80000;
Begin
    FAlphaBlend := Value;

    If IsWin2kOrLater Then
    Begin
        If FAlphaBlend Then
        Begin
            SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) Or WS_EX_LAYERED);
            SetAlphaBlendValue(FAlphaBlendValue);
        End
        Else
        Begin
            If (GetWindowLong(Handle, GWL_EXSTYLE) And WS_EX_LAYERED) = WS_EX_LAYERED Then
                SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) And Not WS_EX_LAYERED);
        End;
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomXPToolTip.SetAlphaBlendValue(Value: Byte);
Const
    LWA_COLORKEY = $1;
    LWA_ALPHA = $2;
Begin
    FAlphaBlendValue := Value;

    If IsWin2kOrLater And Assigned(SetLayeredWindowAttributesProc) Then
    Begin
        If FAlphaBlend Then
            SetLayeredWindowAttributesProc(Handle, 0, Value, LWA_ALPHA)
        Else SetLayeredWindowAttributesProc(Handle, 0, Value, 0);
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomXPToolTip.SetDropShadow(Value: Boolean);
Begin
    FDropShadow := Value;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomXPToolTip.WMNCHitTest(Var Message: TWMNCHitTest);
Begin
    Message.Result := HTTRANSPARENT;
  //Message.Result := HTCLIENT;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomXPToolTip.WMNCPaint(Var msg: TMessage);
Var
    R: TRect;
    DC: HDC;
Begin
    DC := GetWindowDC(Handle);
    Try
        R := Rect(0, 0, Width, Height);
        DrawEdge(DC, R, EDGE_ETCHED, BF_RECT Or BF_MONO);
    Finally
        ReleaseDC(Handle, DC);
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Initialization
    SetLayeredWindowAttributesProc := Nil;
    If IsWin2kOrLater Then
        SetLayeredWindowAttributesProc := GetProcAddress(GetModulehandle(user32), 'SetLayeredWindowAttributes');

Finalization
    SetLayeredWindowAttributesProc := Nil;

End.
