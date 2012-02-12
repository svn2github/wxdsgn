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

Unit PrintFrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, Buttons, MultiLangSupport, Spin, datamod, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, MultiLangSupport, QComCtrls, datamod;
{$ENDIF}

Type
    TPrintForm = Class(TForm)
        btnCancel: TBitBtn;
        btnOk: TBitBtn;
        grpParams: TGroupBox;
        cbColors: TCheckBox;
        cbHighlight: TCheckBox;
        rbLN: TRadioButton;
        rbLNMargin: TRadioButton;
        cbWordWrap: TCheckBox;
        grpPages: TGroupBox;
        lblCopies: TLabel;
        seCopies: TSpinEdit;
        cbSelection: TCheckBox;
        cbLineNum: TCheckBox;
        XPMenu: TXPMenu;
        Procedure FormCreate(Sender: TObject);
        Procedure cbLineNumClick(Sender: TObject);
    Public
        Procedure LoadText;
    End;

Var
    PrintForm: TPrintForm;

Implementation

Uses
    devcfg;

{$R *.dfm}

Procedure TPrintForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_PRT];
    grpParams.Caption := Lang[ID_PRT_GRP_PARAMS];
    grpPages.Caption := Lang[ID_PRT_GRP_PAGES];
    cbColors.Caption := Lang[ID_PRT_COLORS];
    cbHighlight.Caption := Lang[ID_PRT_HIGHLIGHT];
    cbWordWrap.Caption := Lang[ID_PRT_WORDWRAP];
    cbLineNum.Caption := Lang[ID_PRT_LINENUM];
    rbLN.Caption := Lang[ID_PRT_PRTLINENUM];
    rbLNMargin.Caption := Lang[ID_PRT_PRTLINENUMMAR];
    lblCopies.Caption := Lang[ID_PRT_COPIES];
    cbSelection.Caption := Lang[ID_PRT_SELONLY];

    btnOk.Caption := Lang[ID_BTN_OK];
    btnCancel.Caption := Lang[ID_BTN_CANCEL];
End;

Procedure TPrintForm.FormCreate(Sender: TObject);
Begin
    LoadText;
    cbColors.Checked := devData.PrintColors;
    cbHighlight.Checked := devData.PrintHighlight;
    cbWordWrap.Checked := devData.PrintWordWrap;
    If devData.PrintLineNumbers Or devData.PrintLineNumbersMargins Then
        cbLineNum.Checked := True
    Else
        cbLineNum.Checked := False;
    rbLN.Checked := devData.PrintLineNumbers;
    rbLNMargin.Checked := devData.PrintLineNumbersMargins;
End;

Procedure TPrintForm.cbLineNumClick(Sender: TObject);
Begin
    rbLN.Enabled := cbLineNum.Checked;
    rbLNMargin.Enabled := cbLineNum.Checked;
End;

End.
