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

Unit CompileProgressFm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ExtCtrls, ComCtrls, XPMenu, devcfg;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QExtCtrls, QComCtrls;
{$ENDIF}

Type
    TCompileProgressForm = Class(TForm)
        btnClose: TButton;
        PageControl1: TPageControl;
        TabSheet1: TTabSheet;
        TabSheet2: TTabSheet;
        Memo1: TMemo;
        pb: TProgressBar;
        Label1: TLabel;
        lblCompiler: TLabel;
        Bevel1: TBevel;
        lblStatus: TLabel;
        Bevel2: TBevel;
        Bevel3: TBevel;
        lblFile: TLabel;
        Label5: TLabel;
        Label3: TLabel;
        Label2: TLabel;
        lblErr: TLabel;
        Bevel5: TBevel;
        Label4: TLabel;
        Bevel6: TBevel;
        lblWarn: TLabel;
        XPMenu: TXPMenu;
        Label6: TLabel;
        Bevel4: TBevel;
        lblElapsed: TLabel;
        timeTimer: TTimer;
        chkSelfClose: TCheckBox;
        Procedure FormShow(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure timeTimerTimer(Sender: TObject);
        Procedure chkSelfCloseClick(Sender: TObject);
    Private
        { Private declarations }
        StartTime: Cardinal;
    Public
        { Public declarations }
        Class Function FormatTime(Seconds: Integer): String;
    End;

Var
    CompileProgressForm: TCompileProgressForm;

Implementation

{$R *.dfm}

Procedure TCompileProgressForm.FormShow(Sender: TObject);
Begin
    StartTime := GetTickCount Div 1000;
    DesktopFont := True;
    lblFile.Font.Style := [fsBold];
    PageControl1.ActivePageIndex := 0;
    XPMenu.Active := devData.XPTheme;
    chkSelfClose.Checked := devData.AutoCloseProgress;
    timeTimer.OnTimer(timeTimer);
End;

Procedure TCompileProgressForm.FormClose(Sender: TObject;
    Var Action: TCloseAction);
Begin
    Action := caFree;
End;

Procedure TCompileProgressForm.timeTimerTimer(Sender: TObject);
Begin
    lblElapsed.Caption := FormatTime((GetTickCount Div 1000) - StartTime);
End;

Class Function TCompileProgressForm.FormatTime(Seconds: Integer): String;
    Function GetPlural(amount: Integer): String;
    Begin
        If amount <> 1 Then
            Result := 's'
        Else
            Result := '';
    End;
Var
    Hours, Minutes: Integer;
Begin
    //Format the string
    Hours := Seconds Div 3600;
    Seconds := Seconds Mod 3600;
    Minutes := Seconds Div 60;
    Seconds := Seconds Mod 60;

    If Hours <> 0 Then
        Result := Format('%d hour%s %d minute%s %d second%s',
            [Hours, GetPlural(Hours), Minutes,
            GetPlural(Minutes), Seconds, GetPlural(Seconds)])
    Else
    If Minutes <> 0 Then
        Result := Format('%d minute%s %d second%s',
            [Minutes, GetPlural(Minutes), Seconds, GetPlural(Seconds)])
    Else
        Result := Format('%d second%s', [Seconds, GetPlural(Seconds)]);
End;

Procedure TCompileProgressForm.chkSelfCloseClick(Sender: TObject);
Begin
    devData.AutoCloseProgress := chkSelfClose.Checked;
End;

End.
