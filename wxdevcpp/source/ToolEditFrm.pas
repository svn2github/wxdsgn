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

{$WARN UNIT_PLATFORM OFF}
Unit ToolEditFrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ExtCtrls, Buttons, XPMenu, Macros, OpenSaveDialogs;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QExtCtrls, QButtons, Macros;
{$ENDIF}

Type
    TToolEditForm = Class(TForm)
        lblTitle: TLabel;
        edTitle: TEdit;
        lblProg: TLabel;
        edProgram: TEdit;
        lblWorkDir: TLabel;
        edWorkDir: TEdit;
        lblParam: TLabel;
        edParams: TEdit;
        btnCancel: TBitBtn;
        btnOk: TBitBtn;
        Panel1: TPanel;
        lblMacros: TLabel;
        lstMacro: TListBox;
        btnInsert: TBitBtn;
        btnHelp: TBitBtn;
        Bevel1: TBevel;
        lblDesc: TLabel;
        Bevel2: TBevel;
        XPMenu: TXPMenu;
        ParamText: TEdit;
        btnProg: TSpeedButton;
        btnWorkDir: TSpeedButton;
        Procedure btnCancelClick(Sender: TObject);
        Procedure HelpClick(Sender: TObject);
        Procedure btnInsertClick(Sender: TObject);
        Procedure lstMacroClick(Sender: TObject);
        Procedure btnProgClick(Sender: TObject);
        Procedure btnWorkDirClick(Sender: TObject);
        Procedure EditEnter(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure edProgramChange(Sender: TObject);
        Procedure edParamsChange(Sender: TObject);
    Private
        fMacroTarget: TEdit;
        OpenDialog: TOpenDialogEx;
        Procedure LoadText;
    End;

Implementation

Uses
{$IFDEF WIN32}
    FileCtrl, MultiLangSupport, devcfg, utils, main;
{$ENDIF}
{$IFDEF LINUX}
  MultiLangSupport, devcfg, utils;
{$ENDIF}

{$R *.dfm}

Procedure TToolEditForm.btnCancelClick(Sender: TObject);
Begin
    Close;
End;

Procedure TToolEditForm.HelpClick(Sender: TObject);
Begin
    Application.MessageBox(
        'You can use macros when calling a tool, how it can acts depending on what your doing'
        +
        #10#13 +
        'in Dev-C++. For example, if you are willing to add a tool to Dev-C++ that can compress'
        +
        #10#13 +
        'executable files, you may need to know the filename of your project''s executable that'
        +
        #10#13 +
        'when calling the tool it automatically compress the current project''s executable.'
        + #10#13 +
        'You can use many different parameters macros for your tool, for more information on'
        + #10#13 +
        'what they can do see the Macro lists on the previous dialog.'
        , 'Quick help on macros',
{$IFDEF WIN32}
        MB_ICONINFORMATION);
{$ENDIF}
{$IFDEF LINUX}
    [smbOK], smsInformation);
{$ENDIF}
End;

Procedure TToolEditForm.btnInsertClick(Sender: TObject);
Begin
    If lstMacro.itemindex > -1 Then
        fMacroTarget.SelText := lstMacro.Items[lstMacro.itemindex];
End;

Procedure TToolEditForm.lstMacroClick(Sender: TObject);
Begin
    lblDesc.Caption := Lang[lstMacro.ItemIndex + ID_ET_MACROS];
End;

Procedure TToolEditForm.btnProgClick(Sender: TObject);
Begin
    If OpenDialog.Execute Then
    Begin
        edProgram.Text := OpenDialog.FileName;
        edWorkDir.Text := ExtractFilePath(OpenDialog.FileName);
    End;
End;

Procedure TToolEditForm.btnWorkDirClick(Sender: TObject);
Var
{$IFDEF WIN32}
    new: String;
{$ENDIF}
{$IFDEF LINUX}
  new: WideString;
{$ENDIF}
Begin
    If (Trim(edWorkDir.Text) <> '') And DirectoryExists(Trim(edWorkDir.Text)) Then
        new := edWorkDir.Text
    Else
        new := ExtractFilePath(edProgram.Text);
    If SelectDirectory('Select Working Dir', '', new) Then
        edWorkDir.text := New;
End;

Procedure TToolEditForm.EditEnter(Sender: TObject);
Begin
    fMacroTarget := Sender As TEdit;
End;

Procedure TToolEditForm.FormCreate(Sender: TObject);
Begin
    OpenDialog := TOpenDialogEx.Create(MainForm);
    OpenDialog.Filter := 'Applications (*.exe)|*.exe|All files (*.*)|*.*';
    fMacroTarget := edParams;
    LoadText;
End;

Procedure TToolEditForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_TE];
    lblTitle.Caption := Lang[ID_TE_TITLE] + ':';
    lblProg.Caption := Lang[ID_TE_PROG] + ':';
    lblWorkDir.Caption := Lang[ID_TE_WORK] + ':';
    lblParam.Caption := Lang[ID_TE_PARAM] + ':';
    lblMacros.Caption := Lang[ID_TE_AVAIL] + ':';
    btnInsert.Caption := Lang[ID_TE_INSERT];

    btnOk.Caption := Lang[ID_BTN_OK];
    btnCancel.Caption := Lang[ID_BTN_CANCEL];
    btnHelp.Caption := Lang[ID_BTN_HELP];
End;

Procedure TToolEditForm.edProgramChange(Sender: TObject);
Begin
    ParamText.Text := ParseMacros(edProgram.Text + ' ' + edParams.Text);
End;

Procedure TToolEditForm.edParamsChange(Sender: TObject);
Begin
    ParamText.Text := ParseMacros(edProgram.Text + ' ' + edParams.Text);
End;

End.
