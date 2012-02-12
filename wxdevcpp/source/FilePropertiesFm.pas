{
    $Id: FilePropertiesFm.pas 760 2006-12-22 03:07:17Z lowjoel $

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
Unit FilePropertiesFm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StrUtils, ExtCtrls, StdCtrls, SynEdit,
    SynEditTypes, FileCtrl, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, StrUtils, QExtCtrls, QStdCtrls, QSynEdit,
  QSynEditTypes;
{$ENDIF}

Type
    TFilePropertiesForm = Class(TForm)
        btnOK: TButton;
        XPMenu: TXPMenu;
        GroupBox1: TGroupBox;
        Label2: TLabel;
        lblProject: TLabel;
        lblRelative: TLabel;
        lblAbsolute: TLabel;
        Label1: TLabel;
        Label9: TLabel;
        Label10: TLabel;
        cmbFiles: TComboBox;
        GroupBox2: TGroupBox;
        Label3: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        Label11: TLabel;
        Label8: TLabel;
        Label6: TLabel;
        Label7: TLabel;
        lblTotal: TLabel;
        lblCode: TLabel;
        lblComments: TLabel;
        lblTimestamp: TLabel;
        lblIncludes: TLabel;
        lblSize: TLabel;
        lblEmpty: TLabel;
        Procedure FormCreate(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure btnOKClick(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Procedure FormShow(Sender: TObject);
        Procedure cmbFilesClick(Sender: TObject);
    Private
        { Private declarations }
        fFilename: String;
        fEdit: TSynEdit;
        Procedure LoadText;
        Procedure CalculateFile(Filename: String);
        Procedure CalculateSize(Filename: String);
        Procedure ShowPropsFor(Filename: String);
        Procedure FillFiles;
    Public
        { Public declarations }
        Procedure SetFile(Filename: String);
    End;

Var
    FilePropertiesForm: TFilePropertiesForm;
    Size, Stamp, Total, Code, Comments, Includes, Empty: Integer;

Implementation

Uses
{$IFDEF WIN32}
    SynEditHighlighter, main, MultiLangSupport, datamod, project, editor, devcfg;
{$ENDIF}
{$IFDEF LINUX}
  QSynEditHighlighter, main, MultiLangSupport, datamod, project, editor, devcfg;
{$ENDIF}

{$R *.dfm}

{ TFilePropertiesForm }

Procedure TFilePropertiesForm.CalculateSize(Filename: String);
Var
    hFile: Integer;
Begin
    hFile := FileOpen(Filename, fmOpenRead);
    If hFile > 0 Then
    Begin
        Stamp := FileGetDate(hFile);
        Size := FileSeek(hFile, 0, 2);
        FileClose(hFile);
    End
    Else
    Begin
        Stamp := 0;
        Size := 0;
    End;
End;

Procedure TFilePropertiesForm.CalculateFile(Filename: String);
Var
    Attri: TSynHighlighterAttributes;
    Current, Token: String;
    I, C: Integer;
Begin
    If Not Assigned(fEdit) Then
        Exit;

    CalculateSize(FileName);

    Total := fEdit.Lines.Count;
    Code := 0;
    Empty := 0;
    Includes := 0;
    Comments := 0;

    // iterate through all lines of file
    For I := 0 To fEdit.Lines.Count - 1 Do
    Begin
        Current := fEdit.Lines[I];

        // locate first non-space char in line
        C := 1;
        While (C <= Length(Current)) And (Current[C] In [#9, ' ']) Do
            Inc(C);

        // take the token type of the first word of the line
        fEdit.GetHighlighterAttriAtRowCol(BufferCoord(C, I + 1), Token, Attri);

        // if we get a token type...
        If Assigned(Attri) Then
        Begin
            // if it is preprocessor...
            If Attri.Name = 'Preprocessor' Then
            Begin
                // check for includes
                If AnsiStartsStr('#include', Token) Or
                    AnsiStartsStr('# include', Token) Then
                    Inc(Includes);
                // preprocessor directives are considered as code
                Inc(Code);
            End

            // if it is a comment
            Else
            If Attri.Name = 'Comment' Then
                Inc(Comments)

            // else it is code
            Else
                Inc(Code);
        End
        // if we don't get a token type, this line is empty or contains only spaces
        Else
            Inc(Empty);
    End;
End;

Procedure TFilePropertiesForm.FormCreate(Sender: TObject);
Begin
    LoadText;
    fEdit := TSynEdit.Create(Application);
    fEdit.Parent := Nil;
    fEdit.Highlighter := dmMain.Cpp;
    fFilename := '';

    lblCode.Font.Style := [fsBold];
    lblComments.Font.Style := [fsBold];
    lblEmpty.Font.Style := [fsBold];
    lblIncludes.Font.Style := [fsBold];
    lblSize.Font.Style := [fsBold];
    lblTimestamp.Font.Style := [fsBold];
    lblTotal.Font.Style := [fsBold];
End;

Procedure TFilePropertiesForm.FormClose(Sender: TObject;
    Var Action: TCloseAction);
Begin
    Action := caFree;
End;

Procedure TFilePropertiesForm.btnOKClick(Sender: TObject);
Begin
    Close;
End;

Procedure TFilePropertiesForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_ITEM_PROPERTIES];
    btnOK.Caption := Lang[ID_BTN_OK];
    Label1.Caption := Lang[ID_PROPS_FILENAME] + ':';
    Label2.Caption := Lang[ID_PROPS_INPROJECT] + ':';
    Label3.Caption := Lang[ID_PROPS_TOTAL] + ':';
    Label4.Caption := Lang[ID_PROPS_CODE] + ':';
    Label5.Caption := Lang[ID_PROPS_COMMENTS] + ':';
    Label6.Caption := Lang[ID_PROPS_FILESIZE] + ':';
    Label7.Caption := Lang[ID_PROPS_EMPTY] + ':';
    Label8.Caption := Lang[ID_PROPS_INCLUDES] + ':';
    Label9.Caption := Lang[ID_PROPS_ABSOLUTE] + ':';
    Label10.Caption := Lang[ID_PROPS_RELATIVE] + ':';
    Label11.Caption := Lang[ID_PROPS_TIMESTAMP] + ':';
End;

Procedure TFilePropertiesForm.FormDestroy(Sender: TObject);
Begin
    fEdit.Free;
End;

Procedure TFilePropertiesForm.FormShow(Sender: TObject);
Begin
    If fFilename = '' Then
        fFilename := MainForm.GetEditor.FileName;
    FillFiles;
    ShowPropsFor(fFilename);
End;

Procedure TFilePropertiesForm.ShowPropsFor(Filename: String);
Begin
    Try
        fEdit.Lines.LoadFromFile(Filename);
        CalculateFile(Filename);
    Except
        // probably the file does not exist (isn't saved yet maybe?)
        Total := 0;
        Size := 0;
        Stamp := 0;
        Code := 0;
        Empty := 0;
        Includes := 0;
        Comments := 0;
    End;

    If Assigned(MainForm.fProject) Then
    Begin
        lblProject.Caption := MainForm.fProject.Name;
        lblRelative.Caption :=
            ExtractRelativePath(MainForm.fProject.Directory, Filename);
    End
    Else
    Begin
        lblProject.Caption := '-';
        lblRelative.Caption := '-';
    End;
    lblAbsolute.Caption := Filename;
    lblTotal.Caption := IntToStr(Total);
    lblSize.Caption := FormatFloat('#,###,##0', Size);
    lblCode.Caption := IntToStr(Code);
    lblEmpty.Caption := IntToStr(Empty);
    lblIncludes.Caption := IntToStr(Includes);
    lblComments.Caption := IntToStr(Comments);
    If Stamp = 0 Then
        lblTimestamp.Caption := '-'
    Else
        lblTimestamp.Caption :=
            FormatDateTime(ShortDateFormat + ' hh:nn:ss', FileDateToDateTime(Stamp));
End;

Procedure TFilePropertiesForm.FillFiles;
Var
    I: Integer;
    idx: Integer;
    e: TEditor;
Begin
    cmbFiles.Clear;
    // add all project files
    If Assigned(MainForm.fProject) Then
    Begin
        For I := 0 To MainForm.fProject.Units.Count - 1 Do
            cmbFiles.Items.AddObject(ExtractFileName(
                MainForm.fProject.Units[I].FileName), Pointer(MainForm.fProject.Units[I]));
    End;

    // add all open editor files not in project
    For I := 0 To MainForm.PageControl.PageCount - 1 Do
    Begin
        e := MainForm.GetEditor(I);
        If Not e.InProject Then
            cmbFiles.Items.Add(e.FileName);
    End;

    idx := cmbFiles.Items.IndexOf(ExtractFileName(fFilename));
    If idx = -1 Then
        idx := cmbFiles.Items.IndexOf(fFilename);
    If idx <> -1 Then // just to be on the safe side
        cmbFiles.ItemIndex := idx;
End;

Procedure TFilePropertiesForm.cmbFilesClick(Sender: TObject);
Begin
    If Assigned(cmbFiles.Items.Objects[cmbFiles.ItemIndex]) Then
    Begin
        fFilename := TProjUnit(cmbFiles.Items.Objects[cmbFiles.ItemIndex]).FileName;
        ShowPropsFor(fFilename);
    End
    Else
        ShowPropsFor(cmbFiles.Items[cmbFiles.ItemIndex]);
End;

Procedure TFilePropertiesForm.SetFile(Filename: String);
Begin
    fFilename := Filename;
End;

End.
