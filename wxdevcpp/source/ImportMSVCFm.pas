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

Unit ImportMSVCFm;

Interface

Uses
    xprocs,
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Buttons, StdCtrls, XPMenu, OpenSaveDialogs;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QButtons, QStdCtrls;
{$ENDIF}

Type
    TImportMSVCForm = Class(TForm)
        lbSelect: TLabel;
        txtVC: TEdit;
        btnBrowse: TSpeedButton;
        gbOptions: TGroupBox;
        lbConf: TLabel;
        cmbConf: TComboBox;
        lbDev: TLabel;
        txtDev: TEdit;
        btnImport: TButton;
        btnCancel: TButton;
        XPMenu: TXPMenu;
        btnBrowseDev: TButton;
        Procedure FormCreate(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Procedure FormShow(Sender: TObject);
        Procedure btnImportClick(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure btnBrowseClick(Sender: TObject);
        Procedure txtDevChange(Sender: TObject);
        Procedure btnBrowseDevClick(Sender: TObject);
    Private
        { Private declarations }
        fSL: TStringList;
        fFilename: String;
        fInvalidFiles: String;
        SaveDialog1: TSaveDialogEx;
        OpenDialog1: TOpenDialogEx;
        Procedure LoadText;
        Procedure WriteDev(Section, Key, Value: String);
        Procedure ImportFile(Filename: String);
        Procedure WriteDefaultEntries;
        Procedure SetFilename(Value: String);
        Procedure SetDevName(Value: String);
        Function ReadTargets(Targets: TStringList): Boolean;
        Function LocateTarget(Var StartAt, EndAt: Integer): Boolean;
        Function LocateSourceTarget(Var StartAt, EndAt: Integer): Boolean;
        Function ReadCompilerOptions(StartAt, EndAt: Integer): Boolean;
        Function ReadLinkerOptions(StartAt, EndAt: Integer): Boolean;
        Procedure ReadSourceFiles(StartAt, EndAt: Integer);
        Procedure ReadProjectType;
        Function GetLineValue(StartAt, EndAt: Integer; StartsWith: String): String;
        Function StripQuotesIfNecessary(s: String): String;
        Procedure UpdateButtons;
        Function CheckVersion: Boolean;
    Public
        { Public declarations }
        Function GetFilename: String;
    Protected
        Procedure CreateParams(Var Params: TCreateParams); Override;
    End;

Var
    ImportMSVCForm: TImportMSVCForm;

Implementation

Uses IniFiles, StrUtils, version, MultiLangSupport, devcfg, utils, main;

{$R *.dfm}

{ TImportMSVCForm }

Procedure TImportMSVCForm.UpdateButtons;
Begin
    btnImport.Enabled := FileExists(txtVC.Text) And
        DirectoryExists(ExtractFilePath(txtDev.Text));
    cmbConf.Enabled := txtVC.Text <> '';
    txtDev.Enabled := txtVC.Text <> '';
    btnBrowseDev.Enabled := txtVC.Text <> '';
End;

Procedure TImportMSVCForm.FormCreate(Sender: TObject);
Begin
    SaveDialog1 := TSaveDialogEx.Create(MainForm);
    OpenDialog1 := TOpenDialogEx.Create(MainForm);
    OpenDialog1.Filter := 'MSVC++ files|*.dsp';
    fSL := TStringList.Create;
    LoadText;
End;

Procedure TImportMSVCForm.FormDestroy(Sender: TObject);
Begin
    fSL.Free;
End;

Procedure TImportMSVCForm.FormShow(Sender: TObject);
Begin
    txtVC.Text := '';
    txtDev.Text := '';
    cmbConf.Clear;
    UpdateButtons;
End;

Function TImportMSVCForm.GetLineValue(StartAt, EndAt: Integer;
    StartsWith: String): String;
Var
    I: Integer;
Begin
    Result := '';
    If EndAt > fSL.Count - 1 Then
        EndAt := fSL.Count - 1;
    I := StartAt;
    While I <= EndAt Do
    Begin
        If AnsiStartsText(StartsWith, fSL[I]) Then
        Begin
            Result := StripQuotesIfNecessary(
                Trim(Copy(fSL[I], Length(StartsWith) + 1, Length(fSL[I]) -
                Length(StartsWith))));
            Break;
        End;
        Inc(I);
    End;
End;

Procedure TImportMSVCForm.ImportFile(Filename: String);
Var
    Targets: TStringList;
Begin
    fSL.LoadFromFile(Filename);

    Targets := TStringList.Create;
    Try
        // check file for version
        If Not CheckVersion Then
            Exit;

        // read targets
        If Not ReadTargets(Targets) Then
            Exit;

        // fill the targets combo
        cmbConf.Items.Assign(Targets);
        If cmbConf.Items.Count > 0 Then
        Begin
            cmbConf.ItemIndex := 0;
        End;
    Finally
        Targets.Free;
    End;
End;

Function TImportMSVCForm.LocateTarget(Var StartAt,
    EndAt: Integer): Boolean;
Var
    I: Integer;
Begin
    Result := False;
    I := 0;
    While I < fSL.Count Do
    Begin
        If (AnsiStartsStr('!IF ', fSL[I]) Or AnsiStartsStr('!ELSEIF ', fSL[I])) And
            AnsiContainsStr(fSL[I], cmbConf.Text) Then
        Begin
            Inc(I);
            StartAt := I;
            While Not (AnsiStartsStr('!ENDIF', fSL[I]) Or
                    AnsiStartsStr('!ELSEIF', fSL[I])) And (I < fSL.Count) Do
                Inc(I);
            EndAt := I - 1;
            Result := True;
            Break;
        End;
        Inc(I);
    End;
End;

Function TImportMSVCForm.LocateSourceTarget(Var StartAt,
    EndAt: Integer): Boolean;
Var
    I: Integer;
Begin
    Result := False;
    I := 0;
    While I < fSL.Count Do
    Begin
        If (AnsiStartsStr('# Begin Target', fSL[I])) Then
        Begin
            Inc(I);
            StartAt := I;
            While Not (AnsiStartsStr('# End Target', fSL[I])) Do
                Inc(I);
            EndAt := I - 1;
            Result := True;
            Break;
        End;
        Inc(I);
    End;
End;

Function TImportMSVCForm.ReadCompilerOptions(StartAt,
    EndAt: Integer): Boolean;
Var
    I: Integer;
    inQuotes: Boolean;
    Options, Options_temp: TStringList;
    sCompiler, sCompiler2003, sCompiler2008: String;
    sCompilerSettings, sCompilerSettings2003, sCompilerSettings2008: String;
    sDirs, sDirs2003, sDirs2008: String;
    sPreProc, sPreProc2003, sPreProc2008: String;
    S, Stemp: String;
Begin
    Result := False;

    sCompiler := '';
    sDirs := '';
    sCompilerSettings := '0000000000000000000000';
    sPreProc := '__GNUWIN32__' + '_@@_';

    sCompiler2003 := '';
    sDirs2003 := '';
    sCompilerSettings2003 := '0000000000000000000000000000000000000000';
    sPreProc2003 := '';

    sCompiler2008 := '';
    sDirs2008 := '';
    sCompilerSettings2008 := '000000000000000000000000000000000000';
    sPreProc2008 := '';

    Options := TStringList.Create;
    Options_temp := TStringList.Create;
    Try

        S := GetLineValue(StartAt, EndAt, '# ADD CPP');

        // Use the spaces to Tokenize the linker options
        strTokenToStrings(S, ' ', Options_temp);

        // Let's re-parse our space-delimited list.
        // There may be some double quotes in the options list
        // Spaces can be contained within double quotes so let's
        // recombine items that are within double quotes to correct
        // that tokenizing error.  Also, let's remove any blank
        // options
        inQuotes := False;
        Stemp := '';
        For I := 0 To (Options_temp.Count - 1) Do
        Begin

            If (inQuotes) Then
            Begin
                If AnsiContainsText(Options_temp[I], '"') Then
                Begin
                    inQuotes := False;
                    Stemp := Stemp + ' ' + Options_temp[I];
                    Options.Add(Stemp);
                End
                Else
                    Stemp := Stemp + ' ' + Options_temp[I];

            End
            Else
            Begin
                // If there's only one double quote, then we're at the
                //   start of a string. Continue parsing until the next
                //   double quote. If there's 2 double quotes, then
                //   we don't need to keep parsing.
                If (StrTokenCount(Options_temp[I], '"') = 1) Then
                Begin
                    inQuotes := True;
                    Stemp := Options_temp[I];
                End
                Else
                If (Length(strTrim(Options_temp[I])) > 0) Then
                Begin
                    Options.Add(Options_temp[I]);
                End;
            End;

        End;

        // If we ended within a double quotes, then let's add whatever
        //   was leftover.
        If (inQuotes) Then
            Options.Add(Stemp);

        I := 0;

        While I < Options.Count Do
        Begin

            // ShowMessage('compiler:  ' +  Options[I]);

            If strEqual('/Za', Options[I]) Then
            Begin // disable language extensions

                // MingW gcc
                //sCompiler := sCompiler + '-ansi ';
                // CompilerOptions position 1
                sCompilerSettings[1] := '1';

                // MSVC6/2003
                sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

                // MSVC2005/2008
                sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

                Inc(I);
            End
            Else
            If strEqual('/GX', Options[I]) Then
            Begin // enable exception handling

                // I think /GX and /EHa are the same
                // http://msdn.microsoft.com/en-us/library/d42ws1f6.aspx

                // MingW gcc
                // sCompiler := sCompiler + '-fexceptions ';
                // CompilerOptions position 7
                sCompilerSettings[7] := '1';

                // MSVC6/2003
                // CompilerOptions position 14
                sCompilerSettings2003[14] := 'a';

                // MSVC2005/2008
                // CompilerOptions position 14
                sCompilerSettings2008[14] := 'a';

                Inc(I);
            End
            Else
            If strEqual('/Ot', Options[I]) Then
            Begin

                // MingW gcc
                // CompilerOptions position 11 (O1 is probably the closest analog)
                sCompilerSettings[11] := '1';

                // MSVC6/2003
                // CompilerOptions position 1
                sCompilerSettings2003[1] := '1';

                // MSVC2005/2008
                // CompilerOptions position 1
                sCompilerSettings2008[1] := '1';

                Inc(I);
            End
            Else
            If strEqual('/Os', Options[I]) Then
            Begin

                // MingW gcc
                sCompiler := sCompiler + '-Os' + '_@@_';


                // MSVC6/2003
                // CompilerOptions position 1
                sCompilerSettings2003[1] := 'a';

                // MSVC2005/2008
                // CompilerOptions position 1
                sCompilerSettings2008[1] := 'a';

                Inc(I);
            End
            Else
            If strEqual('/O2', Options[I]) Then
            Begin

                // MingW gcc
                // CompilerOptions position 12
                sCompilerSettings[12] := '1';

                // MSVC6/2003
                // CompilerOptions position 2
                sCompilerSettings2003[2] := '1';

                // MSVC2005/2008
                // CompilerOptions position 2
                sCompilerSettings2008[2] := '1';

                Inc(I);
            End
            Else
            If strEqual('/O1', Options[I]) Then
            Begin

                // MingW gcc
                // CompilerOptions position 11
                sCompilerSettings[11] := '1';

                // MSVC6/2003
                // CompilerOptions position 2
                sCompilerSettings2003[2] := 'a';

                // MSVC2005/2008
                // CompilerOptions position 2
                sCompilerSettings2008[2] := 'a';

                Inc(I);
            End
            Else
            If strEqual('/Og', Options[I]) Then
            Begin

                // MingW gcc
                // CompilerOptions position 13 (-O3 is probably closest analog)
                sCompilerSettings[13] := '1';

                // MSVC6/2003
                // CompilerOptions position 3
                sCompilerSettings2003[3] := '1';

                // MSVC2005/2008
                // CompilerOptions position 3
                sCompilerSettings2008[3] := '1';

                Inc(I);
            End
            Else
            If strEqual('/Oa', Options[I]) Then
            Begin

                // MingW gcc
                // CompilerOptions position 11  (-O1 is probably closest analog)
                sCompilerSettings[11] := '1';

                // MSVC6/2003
                // CompilerOptions position 4
                sCompilerSettings2003[4] := '1';

                // MSVC2005/2008
                // CompilerOptions position 4
                sCompilerSettings2008[4] := '1';

                Inc(I);
            End
            Else
            If strEqual('/Oi', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 5
                sCompilerSettings2003[5] := '1';

                // MSVC2005/2008
                // CompilerOptions position 5
                sCompilerSettings2008[5] := '1';

                Inc(I);
            End
            Else
            If StrEqual('/Ow', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 6
                sCompilerSettings2003[6] := '1';

                // MSVC2005/2008
                // CompilerOptions position 6
                sCompilerSettings2008[6] := '1';

                Inc(I);
            End
            Else
            If strEqual('/GA', Options[I]) Then
            Begin
                // Optimize for Windows applications

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 7
                sCompilerSettings2003[7] := '1';

                // MSVC2005/2008
                // CompilerOptions position 7
                sCompilerSettings2008[7] := '1';

                Inc(I);
            End
            Else
            If strEqual('/Oy', Options[I]) Then
            Begin

                // MingW gcc
                sCompiler := sCompiler + '-fomit-frame-pointer' + '_@@_';

                // MSVC6/2003
                // CompilerOptions position 8
                sCompilerSettings2003[8] := '1';

                // MSVC2005/2008
                // CompilerOptions position 8
                sCompilerSettings2008[8] := '1';

                Inc(I);
            End
            Else
            If strEqual('/GB', Options[I]) Then
            Begin // blend optimization

                // MingW gcc
                // sCompiler := sCompiler + '-mcpu=pentiumpro -D_M_IX86=500 ';
                // CompilerOptions position 21
                sCompilerSettings[21] := '5';

                // MSVC6/2003
                // CompilerOptions position 9
                sCompilerSettings2003[9] := '0';

                // MSVC2005/2008
                sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

                Inc(I);
            End
            Else
            If strEqual('/G5', Options[I]) Then
            Begin // pentium optimization

                // MingW gcc
                // sCompiler := sCompiler + '-mcpu=pentium -D_M_IX86=500 ';
                // CompilerOptions position 21
                sCompilerSettings[21] := '3';

                // MSVC6/2003
                // CompilerOptions position 9
                sCompilerSettings2003[9] := '1';

                // MSVC2005/2008
                sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

                Inc(I);
            End
            Else
            If strEqual('/G6', Options[I]) Then
            Begin // pentium pro optimization

                // MingW gcc
                //sCompiler := sCompiler + '-mcpu=pentiumpro -D_M_IX86=600 ';
                // CompilerOptions position 21
                sCompilerSettings[21] := '4';

                // MSVC6/2003
                // CompilerOptions position 9
                sCompilerSettings2003[9] := 'a';

                // MSVC2005/2008
                sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

                Inc(I);
            End
            Else
            If strEqual('/Gr', Options[I]) Then
            Begin
                // __fastcall

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 10
                sCompilerSettings2003[10] := '1';

                // MSVC2005/2008
                // CompilerOptions position 9
                sCompilerSettings2008[9] := '1';

                Inc(I);
            End
            Else
            If strEqual('/Gz', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 10
                sCompilerSettings2003[10] := 'a';

                // MSVC2005/2008
                // CompilerOptions position 9
                sCompilerSettings2008[9] := 'a';

                Inc(I);
            End
            Else
            If strEqual('/Gf', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 11
                sCompilerSettings2003[11] := '1';

                // MSVC2005/2008
                // CompilerOptions position 10
                sCompilerSettings2008[10] := '1';

                Inc(I);
            End
            Else
            If strEqual('/GF', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 11
                sCompilerSettings2003[11] := 'a';

                // MSVC2005/2008
                // CompilerOptions position 10
                sCompilerSettings2008[10] := 'a';

                Inc(I);
            End
            Else
            If strEqual('/clr', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 12
                sCompilerSettings2003[12] := '1';

                // MSVC2005/2008
                // CompilerOptions position 11
                sCompilerSettings2008[11] := '1';

                Inc(I);
            End
            Else
            If strEqual('/clr:noAssembly', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 12
                sCompilerSettings2003[12] := 'a';

                // MSVC2005/2008
                // CompilerOptions position 11
                sCompilerSettings2008[11] := 'a';

                Inc(I);
            End
            Else
            If strEqual('/clr:pure', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 12
                sCompilerSettings2003[12] := 'b';

                // MSVC2005/2008
                // CompilerOptions position 11
                sCompilerSettings2008[11] := 'b';

                Inc(I);
            End
            Else
            If strEqual('/clr:safe', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 12
                sCompilerSettings2003[12] := 'c';

                // MSVC2005/2008
                // CompilerOptions position 11
                sCompilerSettings2008[11] := 'c';

                Inc(I);
            End
            Else
            If strEqual('/clr:oldSyntax', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 12
                sCompilerSettings2003[12] := 'd';

                // MSVC2005/2008
                // CompilerOptions position 11
                sCompilerSettings2008[11] := 'd';

                Inc(I);
            End
            Else
            If strEqual('/clr:initialAppDomain', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 12
                sCompilerSettings2003[12] := 'e';

                // MSVC2005/2008
                // CompilerOptions position 11
                sCompilerSettings2008[11] := 'e';

                Inc(I);
            End
            Else
            If strEqual('/arch:SSE', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 13
                sCompilerSettings2003[13] := '1';

                // MSVC2005/2008
                // CompilerOptions position 13
                sCompilerSettings2008[13] := '1';

                Inc(I);
            End
            Else
            If strEqual('/arch:SSE2', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 13
                sCompilerSettings2003[13] := 'a';

                // MSVC2005/2008
                // CompilerOptions position 13
                sCompilerSettings2008[13] := 'a';

                Inc(I);
            End
            Else
            If strEqual('/EHs', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 14
                sCompilerSettings2003[14] := '1';

                // MSVC2005/2008
                // CompilerOptions position 14
                sCompilerSettings2008[14] := '1';

                Inc(I);
            End
            Else
            If strEqual('/EHa', Options[I]) Then
            Begin

                // I think /GX and /EHa are the same
                // http://msdn.microsoft.com/en-us/library/d42ws1f6.aspx

                // MingW gcc
                // sCompiler := sCompiler + '-fexceptions ';
                // CompilerOptions position 7
                sCompilerSettings[7] := '1';


                // MSVC6/2003
                // CompilerOptions position 14
                sCompilerSettings2003[14] := 'a';

                // MSVC2005/2008
                // CompilerOptions position 14
                sCompilerSettings2008[14] := 'a';

                Inc(I);
            End
            Else
            If strEqual('/Gh', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 15
                sCompilerSettings2003[15] := '1';

                // MSVC2005/2008
                // CompilerOptions position 15
                sCompilerSettings2008[15] := '1';

                Inc(I);
            End
            Else
            If strEqual('/GH', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 16
                sCompilerSettings2003[16] := '1';

                // MSVC2005/2008
                // CompilerOptions position 16
                sCompilerSettings2008[16] := '1';

                Inc(I);
            End
            Else
            If strEqual('/GR', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 17
                sCompilerSettings2003[17] := '1';

                // MSVC2005/2008
                // CompilerOptions position 17
                sCompilerSettings2008[17] := '1';

                Inc(I);
            End
            Else
            If strEqual('/Gm', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 18
                sCompilerSettings2003[18] := '1';

                // MSVC2005/2008
                // CompilerOptions position 18
                sCompilerSettings2008[18] := '1';

                Inc(I);
            End
            Else
            If strEqual('/GL', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 19
                sCompilerSettings2003[19] := '1';

                // MSVC2005/2008
                // CompilerOptions position 19
                sCompilerSettings2008[19] := '1';

                Inc(I);
            End
            Else
            If strEqual('/EHc', Options[I]) Then
            Begin
                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 20
                sCompilerSettings2003[20] := '1';

                // MSVC2005/2008
                // CompilerOptions position 20
                sCompilerSettings2008[20] := '1';

                Inc(I);
            End
            Else
            If strEqual('/EHsc', Options[I]) Then
            Begin

                // MingW gcc
                // sCompiler := sCompiler + '-fexceptions ';
                // CompilerOptions position 7
                sCompilerSettings[7] := '1';


                // MSVC6/2003
                // CompilerOptions position 14
                sCompilerSettings2003[14] := 'a';

                // MSVC2005/2008
                // CompilerOptions position 14
                sCompilerSettings2008[14] := 'a';

                Inc(I);
            End
            Else
            If strEqual('/Gy', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 21
                sCompilerSettings2003[21] := '1';

                // MSVC2005/2008
                // CompilerOptions position 21
                sCompilerSettings2008[21] := '1';

                Inc(I);
            End
            Else
            If strEqual('/GT', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 22
                sCompilerSettings2003[22] := '1';

                // MSVC2005/2008
                // CompilerOptions position 22
                sCompilerSettings2008[22] := '1';

                Inc(I);
            End
            Else
            If strEqual('/Ge', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 23
                sCompilerSettings2003[23] := '1';

                // MSVC2005/2008
                // CompilerOptions position 23
                sCompilerSettings2008[23] := '1';

                Inc(I);
            End
            Else
            If strEqual('/GS', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 23
                sCompilerSettings2003[23] := '1';

                // MSVC2005/2008
                // CompilerOptions position 23
                sCompilerSettings2008[23] := '1';

                Inc(I);
            End
            Else
            If strEqual('/RTCc', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 24
                sCompilerSettings2003[24] := '1';

                // MSVC2005/2008
                // CompilerOptions position 24
                sCompilerSettings2008[24] := '1';

                Inc(I);
            End
            Else
            If strEqual('/RTCs', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 25
                sCompilerSettings2003[25] := '1';

                // MSVC2005/2008
                // CompilerOptions position 25
                sCompilerSettings2008[25] := '1';

                Inc(I);
            End
            Else
            If strEqual('/RTCu', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 25
                sCompilerSettings2003[25] := '1';

                // MSVC2005/2008
                // CompilerOptions position 25
                sCompilerSettings2008[25] := '1';

                Inc(I);
            End
            Else
            If strEqual('/Zi', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 27
                sCompilerSettings2003[27] := '1';

                // MSVC2005/2008
                // CompilerOptions position 27
                sCompilerSettings2008[27] := '1';

                Inc(I);
            End
            Else
            If strEqual('/ZI', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 27
                sCompilerSettings2003[27] := 'a';

                // MSVC2005/2008
                // CompilerOptions position 27
                sCompilerSettings2008[27] := 'a';

                Inc(I);
            End
            Else
            If strEqual('/Z7', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 27
                sCompilerSettings2003[27] := 'b';

                // MSVC2005/2008
                // CompilerOptions position 27
                sCompilerSettings2008[27] := 'b';

                Inc(I);
            End
            Else
            If strEqual('/Zd', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 27
                sCompilerSettings2003[27] := 'c';

                // MSVC2005/2008
                // CompilerOptions position 27
                sCompilerSettings2008[27] := 'c';

                Inc(I);
            End
            Else
            If strEqual('/Zl', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 28
                sCompilerSettings2003[28] := '1';

                // MSVC2005/2008
                // CompilerOptions position 28
                sCompilerSettings2008[28] := '1';

                Inc(I);
            End
            Else
            If strEqual('/Zg', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 29
                sCompilerSettings2003[29] := '1';

                // MSVC2005/2008
                // CompilerOptions position 29
                sCompilerSettings2008[29] := '1';

                Inc(I);
            End
            Else
            If strEqual('/openmp', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 30
                sCompilerSettings2003[30] := '1';

                // MSVC2005/2008
                // CompilerOptions position 30
                sCompilerSettings2008[30] := '1';

                Inc(I);
            End
            Else
            If strEqual('/Zc:forScope', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 31
                sCompilerSettings2003[31] := '1';

                // MSVC2005/2008
                // CompilerOptions position 31
                sCompilerSettings2008[31] := '1';

                Inc(I);
            End
            Else
            If strEqual('/Zc:wchar_t', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 32
                sCompilerSettings2003[32] := '1';

                // MSVC2005/2008
                // CompilerOptions position 32
                sCompilerSettings2008[32] := '1';

                Inc(I);
            End
            Else
            If strEqual('/WX', Options[I]) Then
            Begin // warnings as errors

                // MingW gcc
                sCompiler := sCompiler + '-Werror' + '_@@_';

                // MSVC6/2003
                // CompilerOptions position 36
                sCompilerSettings2003[36] := '1';

                // MSVC2005/2008
                // CompilerOptions position 33
                sCompilerSettings2008[33] := '1';

                Inc(I);
            End
            Else
            If strEqual('/W1', Options[I]) Or
                strEqual('/W2', Options[I]) Or
                strEqual('/W3', Options[I]) Then
            Begin // warning messages

                // MingW gcc
                sCompiler := sCompiler + '-W' + '_@@_';

                // MSVC6/2003
                // CompilerOptions position 37
                If strEqual('/W2', Options[I]) Then
                    sCompilerSettings2003[37] := '1';

                If strEqual('/W3', Options[I]) Then
                    sCompilerSettings2003[37] := 'a';

                // MSVC2005/2008
                // CompilerOptions position 34
                If strEqual('/W2', Options[I]) Then
                    sCompilerSettings2008[34] := '1';

                If strEqual('/W3', Options[I]) Then
                    sCompilerSettings2008[34] := 'a';

                Inc(I);
            End
            Else
            If strEqual('/W4', Options[I]) Then
            Begin // all warning messages

                // MingW gcc
                sCompiler := sCompiler + '-Wall' + '_@@_';

                // MSVC6/2003
                // CompilerOptions position 37
                sCompilerSettings2003[37] := 'b';

                // MSVC2005/2008
                // CompilerOptions position 34
                sCompilerSettings2008[34] := 'b';

                Inc(I);
            End
            Else
            If strEqual('/Wp64', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 35
                sCompilerSettings2003[35] := '1';

                // MSVC2005/2008
                // CompilerOptions position 35
                sCompilerSettings2008[35] := '1';

                Inc(I);
            End
            Else
            If strEqual('/INCREMENTAL:NO', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                // CompilerOptions position 36
                sCompilerSettings2003[36] := '1';

                // MSVC2005/2008
                // CompilerOptions position 36
                sCompilerSettings2008[36] := '1';

                Inc(I);
            End
            // /D = Defines a preprocessing symbol for your source file.
            Else
            If strEqual('/D', Options[I]) Or
                strEqual('/d', Options[I]) Then
            Begin

                // The format should be /D "option". However, let's just
                // check to make sure that the .dsp file somehow didn't
                // use the space.
                If AnsiStartsStr('/', Options[I + 1]) Then
                Begin
                    // Next token is another option.
                    Stemp := Options[I];
                    Delete(Stemp, 1, 2); // Delete the /D

                    If (Length(strTrim(Stemp)) > 0) Then
                    Begin

                        // MingW gcc
                        S := Format('%s', [AnsiDequotedStr(Stemp, '"')]);
                        sPreProc := sPreProc + S + '_@@_';

                        // MSVC6/2003
                        S := Format('%s', [Stemp]);
                        sPreProc2003 := sPreProc2003 + S + '_@@_';

                        // MSVC2005/2008
                        S := Format('%s', [AnsiDequotedStr(Stemp, '"')]);
                        sPreProc2008 := sPreProc2008 + S + '_@@_';

                    End;

                    Inc(I);

                End
                Else
                Begin
                    // Next token is the value for this option

                    // MingW gcc
                    S := Format('%s', [AnsiDequotedStr(Options[I + 1], '"')]);
                    sPreProc := sPreProc + S + '_@@_';

                    // MSVC6/2003
                    S := Format('%s', [Options[I + 1]]);
                    sPreProc2003 := sPreProc2003 + S + '_@@_';

                    // MSVC2005/2008
                    S := Format('%s', [AnsiDequotedStr(Options[I + 1], '"')]);
                    sPreProc2008 := sPreProc2008 + S + '_@@_';

                    Inc(I); Inc(I);

                End;

            End
            Else
            If strEqual('/U', Options[I]) Then
            Begin

                // The format should be /U "option". However, let's just
                // check to make sure that the .dsp file somehow didn't
                // use the space.
                If AnsiStartsStr('/', Options[I + 1]) Then
                Begin
                    // Next token is another option.
                    Stemp := Options[I];
                    Delete(Stemp, 1, 2); // Delete the /U

                    If (Length(strTrim(Stemp)) > 0) Then
                    Begin

                        S := Format('-U%s', [Stemp]);
                        sCompiler := sCompiler + S + '_@@_';

                        // MSVC6/2003
                        S := Format('/U %s', [Stemp]);
                        sCompiler2003 := sCompiler2003 + S + '_@@_';

                        // MSVC2005/2008
                        S := Format('/U %s', [Stemp]);
                        sCompiler2008 := sCompiler2008 + S + '_@@_';

                    End;

                    Inc(I);

                End
                Else
                Begin

                    S := Format('-U%s', [Options[I + 1]]);
                    sCompiler := sCompiler + S + '_@@_';

                    // MSVC6/2003
                    S := Format('/U %s', [Options[I + 1]]);
                    sCompiler2003 := sCompiler2003 + S + '_@@_';

                    // MSVC2005/2008
                    S := Format('/U %s', [Options[I + 1]]);
                    sCompiler2008 := sCompiler2008 + S + '_@@_';

                    Inc(I); Inc(I);

                End;

            End
            Else
            If strEqual('/I', Options[I]) Or strEqual('/i', Options[I]) Then
            Begin

                // The format should be /I "option". However, let's just
                // check to make sure that the .dsp file somehow didn't
                // use the space.
                If AnsiStartsStr('/', Options[I + 1]) Then
                Begin
                    // Next token is another option.
                    Stemp := Options[I];
                    Delete(Stemp, 1, 2); // Delete the /I

                    If (Length(strTrim(Stemp)) > 0) Then
                    Begin

                        // MingW gcc  +   MSVC2005/2008
                        sDirs := sDirs + Stemp + ';';
                        sDirs2003 := sDirs2003 + Stemp + ';';
                        sDirs2008 := sDirs2008 + Stemp + ';';

                    End;

                    Inc(I);

                End
                Else
                Begin

                    // MingW gcc  +   MSVC2005/2008
                    sDirs := sDirs + Options[I + 1] + ';';
                    sDirs2003 := sDirs2003 + Options[I + 1] + ';';
                    sDirs2008 := sDirs2008 + Options[I + 1] + ';';

                    Inc(I); Inc(I);
                End;
            End
            Else
            If strEqual('/Ob0', Options[I]) Then
            Begin // disable inline expansion

                // MingW gcc
                sCompiler := sCompiler + '-fno-inline' + '_@@_';

                // MSVC6/2003
                sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

                // MSVC2005/2008
                sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

                Inc(I);
            End
            Else
            If strEqual('/Ob2', Options[I]) Then
            Begin // auto inline function expansion

                // MingW gcc
                sCompiler := sCompiler + '-finline-functions' + '_@@_';

                // MSVC6/2003
                sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

                // MSVC2005/2008
                sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

                Inc(I);
            End
            Else
            If strEqual('/G4', Options[I]) Then
            Begin // 486 optimization

                // MingW gcc
                //sCompiler := sCompiler + '-mcpu=i486 -D_M_IX86=400 ';
                // CompilerOptions position 21
                sCompilerSettings[21] := '2';

                // MSVC6/2003
                sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

                // MSVC2005/2008
                sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

                Inc(I);
            End
            Else
            If strEqual('/G3', Options[I]) Then
            Begin // 386 optimization

                // MingW gcc
                //sCompiler := sCompiler + '-mcpu=i386 -D_M_IX86=300 ';
                // CompilerOptions position 21
                sCompilerSettings[21] := '1';

                // MSVC6/2003
                sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

                // MSVC2005/2008
                sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

                Inc(I);
            End
            Else
            If strEqual('/Zp1', Options[I]) Then
            Begin // pack structures

                // MingW gcc
                sCompiler := sCompiler + '-fpack-struct' + '_@@_';

                // MSVC6/2003
                sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

                // MSVC2005/2008
                sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

                Inc(I);
            End
            Else
            If strEqual('/W0', Options[I]) Then
            Begin // no warning messages

                // MingW gcc
                sCompiler := sCompiler + '-w' + '_@@_';

                // MSVC6/2003
                sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

                // MSVC2005/2008
                sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

                Inc(I);
            End
            Else
            If strEqual('/c', Options[I]) Then
            Begin // compile only

                // MingW gcc
                sCompiler := sCompiler + '-c' + '_@@_';

                // MSVC6/2003
                sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

                // MSVC2005/2008
                sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

                Inc(I);
            End
            Else
            If strEqual('/nologo', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

                // MSVC2005/2008
                sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

                Inc(I);
            End
            Else     // No idea what to do with this so let's just send it as is
            Begin

                If (Length(strTrim(Options[I])) > 0) Then
                Begin
                    sCompiler := sCompiler + Options[I] + '_@@_';
                    sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';
                    sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';
                End;
                Inc(I);

            End;
        End;

        // MingW gcc
        WriteDev('Profile1', 'Compiler', sCompiler);
        WriteDev('Profile1', 'CppCompiler', sCompiler);

        WriteDev('Profile1', 'CompilerSettings', sCompilerSettings);
        WriteDev('Profile1', 'PreprocDefines', sPreProc);

        If sDirs <> '' Then
            sDirs := Copy(sDirs, 1, Length(sDirs) - 1);

        WriteDev('Profile1', 'Includes', sDirs);

        // MSVC6/MSVC2003
        WriteDev('Profile2', 'Compiler', sCompiler2003);
        WriteDev('Profile2', 'CppCompiler', sCompiler2003);

        WriteDev('Profile2', 'CompilerSettings', sCompilerSettings2003);

        WriteDev('Profile2', 'PreprocDefines', sPreProc2003);

        If sDirs2003 <> '' Then
            sDirs2003 := Copy(sDirs2003, 1, Length(sDirs2003) - 1);

        WriteDev('Profile2', 'Includes', sDirs2003);

        // MSVC2005/MSVC2008
        WriteDev('Profile3', 'Compiler', sCompiler2008);
        WriteDev('Profile3', 'CppCompiler', sCompiler2008);

        WriteDev('Profile3', 'CompilerSettings', sCompilerSettings2008);
        WriteDev('Profile3', 'PreprocDefines', sPreProc2008);

        If sDirs2008 <> '' Then
            sDirs2008 := Copy(sDirs2008, 1, Length(sDirs2008) - 1);

        WriteDev('Profile3', 'Includes', sDirs2008);

    Finally
        Options.Free;
        Options_temp.Free;
    End;
End;

Function TImportMSVCForm.ReadLinkerOptions(StartAt,
    EndAt: Integer): Boolean;
Var
    I: Integer;
    inQuotes: Boolean;
    Options, Options_temp: TStringList;
    sLibs, sLibs2003, sLibs2008: String;
    sDirs, sDirs2003, sDirs2008: String;
    S, Stemp: String;
Begin

    Result := False;
    sLibs := '';  sLibs2003 := ''; sLibs2008 := '';
    sDirs := '';  sDirs2003 := ''; sDirs2008 := '';

    Options := TStringList.Create;
    Options_temp := TStringList.Create;
    Try

        S := GetLineValue(StartAt, EndAt, '# ADD LINK32');

        // Use the spaces to Tokenize the linker options
        strTokenToStrings(S, ' ', Options_temp);

        // Let's re-parse our space-delimited list.
        // There may be some double quotes in the options list
        // Spaces can be contained within double quotes so let's
        // recombine items that are within double quotes to correct
        // that tokenizing error.  Also, let's remove any blank
        // options
        inQuotes := False;
        Stemp := '';
        For I := 0 To (Options_temp.Count - 1) Do
        Begin
            If (inQuotes) Then
            Begin
                If AnsiContainsText(Options_temp[I], '"') Then
                Begin
                    inQuotes := False;
                    Stemp := Stemp + ' ' + Options_temp[I];
                    Options.Add(Stemp);
                End
                Else
                    Stemp := Stemp + ' ' + Options_temp[I];

            End
            Else
            Begin
                // If there's only one double quote, then we're at the
                //   start of a string. Continue parsing until the next
                //   double quote. If there's 2 double quotes, then
                //   we don't need to keep parsing.
                If (StrTokenCount(Options_temp[I], '"') = 1) Then
                Begin
                    inQuotes := True;
                    Stemp := Options_temp[I];
                End
                Else
                If (Length(strTrim(Options_temp[I])) > 0) Then
                Begin
                    Options.Add(Options_temp[I]);
                End;
            End;

        End;

        // If we ended within a double quotes, then let's add whatever
        //   was leftover.
        If (inQuotes) Then
            Options.Add(Stemp);

        For I := 0 To (Options.Count - 1) Do
        Begin
            //ShowMessage('Linker: ' + Options[I]);

            If AnsiEndsText('.lib', Options[I]) Then
            Begin
                // MingW gcc
                S := Copy(Options[I], 1, Length(Options[I]) - 4);
                If ExtractFilePath(S) <> '' Then
                    sDirs := sDirs + ExtractFilePath(S) + ';';
                S := Format('-l%s', [ExtractFileName(S)]);
                sLibs := sLibs + S + '_@@_';

                sLibs2003 := sLibs2003 + Options[I] + '_@@_';
                sLibs2008 := sLibs2008 + Options[I] + '_@@_';

            End
            Else
            If AnsiStartsText('/base:', Options[I]) Then
            Begin
                S := Copy(Options[I], Length('/base:') + 1, MaxInt);
                sLibs := sLibs + '--image-base ' + S + '_@@_';
                sLibs2003 := sLibs2003 + Options[I] + '_@@_';
                sLibs2008 := sLibs2008 + Options[I] + '_@@_';
            End
            Else
            If AnsiStartsText('/implib:', Options[I]) Then
            Begin
                S := Copy(Options[I], Length('/implib:') + 1, MaxInt);
                sLibs := sLibs + '--implib ' + S + '_@@_';
                sLibs2003 := sLibs2003 + Options[I] + '_@@_';
                sLibs2008 := sLibs2008 + Options[I] + '_@@_';
            End
            Else
            If AnsiStartsText('/map:', Options[I]) Then
            Begin
                S := Copy(Options[I], Length('/map:') + 1, MaxInt);
                sLibs := sLibs + '-Map ' + S + '.map';
                sLibs2003 := sLibs2003 + Options[I] + '_@@_';
                sLibs2008 := sLibs2008 + Options[I] + '_@@_';
            End
            Else
            If AnsiStartsText('/subsystem:', Options[I]) Then
            Begin
                S := Copy(Options[I], Length('/subsystem:') + 1, MaxInt);
                If S = 'windows' Then
                Begin
                    WriteDev('Profile1', 'Type', '0'); // win32 gui
                    WriteDev('Profile2', 'Type', '0'); // win32 gui
                    WriteDev('Profile3', 'Type', '0'); // win32 gui
                End
                Else
                If S = 'console' Then
                Begin
                    WriteDev('Profile1', 'Type', '1'); // console app
                    WriteDev('Profile2', 'Type', '1'); // console app
                    WriteDev('Profile3', 'Type', '1'); // console app
                End;
                //        sLibs := sLibs + '-Wl --subsystem ' + S + ' ';
            End
            Else
            If AnsiStartsText('/libpath:', Options[I]) Then
            Begin
                S := Copy(Options[I], Length('/libpath:') + 1, MaxInt);
                sDirs := sDirs + S + ';';
                sDirs2003 := sDirs2003 + S + ';';
                sDirs2008 := sDirs2008 + S + ';';
            End
            Else
            If strEqual('/nologo', Options[I]) Then
            Begin

                // MingW gcc
                // Do nothing

                // MSVC6/2003
                sLibs2003 := sLibs2003 + Options[I] + '_@@_';

                // MSVC2005/2008
                sLibs2008 := sLibs2008 + Options[I] + '_@@_';

            End
            Else
            Begin
                S := strTrim(Options[I]);
                sLibs := sLibs + S + '_@@_';
                sLibs2003 := sLibs2003 + Options[I] + '_@@_';
                sLibs2008 := sLibs2008 + Options[I] + '_@@_';
            End;
        End;

        WriteDev('Profile1', 'Linker', sLibs);
        WriteDev('Profile2', 'Linker', sLibs2003);
        WriteDev('Profile3', 'Linker', sLibs2008);
        If sDirs <> '' Then
            sDirs := Copy(sDirs, 1, Length(sDirs) - 1);
        WriteDev('Profile1', 'Libs', sDirs);
        WriteDev('Profile2', 'Libs', sDirs2003);
        WriteDev('Profile3', 'Libs', sDirs2008);
    Finally
        Options.Free;
        Options_temp.Free;
    End;
End;

Procedure TImportMSVCForm.ReadSourceFiles(StartAt,
    EndAt: Integer);
Var
    flds: TStringList;
    I, C: Integer;
    UnitName: String;
    folder: String;
    folders: String;
Begin
    fInvalidFiles := '';
    C := 0;
    folders := '';
    flds := TStringList.Create;
    Try
        flds.Delimiter := '/';
        For I := StartAt To EndAt Do
            If (Length(fSL[I]) > 0) Then
            Begin
                If AnsiStartsText('# Begin Group ', fSL[I]) Then
                Begin
                    folder := StripQuotesIfNecessary(Copy(fSL[I], 15, MaxInt));
                    flds.Add(folder);
                    folders := folders + flds.DelimitedText + ',';
                End
                Else
                If AnsiStartsText('# End Group', fSL[I]) Then
                Begin
                    If flds.Count > 0 Then
                        flds.Delete(flds.Count - 1);
                End
                Else
                If AnsiStartsText('SOURCE=', fSL[I]) Then
                Begin
                    UnitName := Copy(fSL[I], 8, Length(fSL[I]) - 7);
                    If FileExists(UnitName) Then
                    Begin
                        UnitName := StringReplace(UnitName, '\', '/', [rfReplaceAll]);
                        WriteDev('Unit' + IntToStr(C + 1), 'FileName', UnitName);
                        WriteDev('Unit' + IntToStr(C + 1), 'Folder', flds.DelimitedText);
                        Case GetFileTyp(UnitName) Of
                            utSrc, utHead:
                            Begin
                                WriteDev('Unit' + IntToStr(C + 1), 'Compile', '1');
                                If AnsiSameText(ExtractFileExt(UnitName), '.c') Then
                                    WriteDev('Unit' + IntToStr(C + 1), 'CompileCpp', '0')
                                Else
                                    WriteDev('Unit' + IntToStr(C + 1), 'CompileCpp', '1');
                                WriteDev('Unit' + IntToStr(C + 1), 'Link', '1');
                            End;
                            utRes:
                            Begin
                                WriteDev('Unit' + IntToStr(C + 1), 'Compile', '1');
                                WriteDev('Unit' + IntToStr(C + 1), 'CompileCpp', '1');
                                WriteDev('Unit' + IntToStr(C + 1), 'Link', '0');
                            End;
                        Else
                        Begin
                            WriteDev('Unit' + IntToStr(C + 1), 'Compile', '0');
                            WriteDev('Unit' + IntToStr(C + 1), 'CompileCpp', '0');
                            WriteDev('Unit' + IntToStr(C + 1), 'Link', '0');
                        End;
                        End;
                        WriteDev('Unit' + IntToStr(C + 1), 'Priority', '1000');
                        Inc(C);
                    End
                    Else
                        fInvalidFiles := fInvalidFiles + UnitName + #13#10;
                End;
            End;
    Finally
        flds.Free;
    End;

    If folders <> '' Then
        Delete(folders, Length(folders), 1);
    WriteDev('Project', 'UnitCount', IntToStr(C));
    WriteDev('Project', 'Folders', folders);
End;

Function TImportMSVCForm.ReadTargets(Targets: TStringList): Boolean;
Var
    I: Integer;
    P: Pchar;
Begin
    Targets.Clear;
    Result := False;
    I := 0;
    While I < fSL.Count Do
    Begin
        If AnsiStartsText('# Begin Target', fSL[I]) Then
        Begin
            // got it
            Inc(I);
            Repeat
                If AnsiStartsText('# Name', fSL[I]) Then
                Begin
                    P := Pchar(Trim(Copy(fSL[I], 7, Length(fSL[I]) - 6)));
                    Targets.Add(AnsiExtractQuotedStr(P, '"'));
                    Result := True;
                End;
                Inc(I);
            Until (I = fSL.Count) Or AnsiStartsText('# Begin Source File', fSL[I]);
            Break;
        End;
        Inc(I);
    End;
End;

Procedure TImportMSVCForm.SetDevName(Value: String);
Begin
    WriteDev('Project', 'Name', Value);
End;

Procedure TImportMSVCForm.SetFilename(Value: String);
Begin
    WriteDev('Project', 'FileName', Value);
    fFilename := Value;
End;

Function TImportMSVCForm.StripQuotesIfNecessary(s: String): String;
Var
    P: Pchar;
Begin
    If AnsiStartsText('"', s) And AnsiEndsText('"', s) Then
    Begin
        P := Pchar(S);
        Result := AnsiExtractQuotedStr(P, '"');
    End
    Else
        Result := S;
End;

Procedure TImportMSVCForm.WriteDefaultEntries;
Begin
    WriteDev('Project', 'Ver', '3');
    WriteDev('Project', 'IsCpp', '1');
    // all MSVC projects are C++ (correct me if I 'm wrong)
    WriteDev('Project', 'ProfilesCount', '3');
    WriteDev('Project', 'ProfileIndex', '0');

    WriteDev('Profile1', 'ProfileName', 'MingW gcc');
    WriteDev('Profile1', 'ExeOutput', 'Output\MingW');
    WriteDev('Profile1', 'ObjectOutput', 'Objects\MingW');
    WriteDev('Profile1', 'ImagesOutput', 'Images\');
    WriteDev('Profile1', 'CompilerSet', '0');
    WriteDev('Profile1', 'CompilerType', '0');

    WriteDev('Profile2', 'ProfileName', 'Visual C++ 2005');
    WriteDev('Profile2', 'ExeOutput', 'Output\Visual C++ 2005');
    WriteDev('Profile2', 'ObjectOutput', 'Objects\Visual C++ 2005');
    WriteDev('Profile2', 'CompilerSet', '1');
    WriteDev('Profile2', 'CompilerType', '1');

    WriteDev('Profile3', 'ProfileName', 'Visual C++ 2008');
    WriteDev('Profile3', 'ExeOutput', 'Output\Visual C++ 2008');
    WriteDev('Profile3', 'ObjectOutput', 'Objects\Visual C++ 2008');
    WriteDev('Profile3', 'CompilerSet', '5');
    WriteDev('Profile3', 'CompilerType', '5');

End;

Procedure TImportMSVCForm.WriteDev(Section, Key, Value: String);
Var
    fIni: TIniFile;
Begin
    fIni := TIniFile.Create(fFilename);
    Try
        fIni.WriteString(Section, Key, Value);
    Finally
        fIni.Free;
    End;
End;

Procedure TImportMSVCForm.btnImportClick(Sender: TObject);
Var
    StartAt, EndAt: Integer;
    SrcStartAt, SrcEndAt: Integer;
    sMsg: String;
Begin
    If FileExists(fFilename) Then
    Begin
        If MessageDlg(fFilename +
            ' exists. Are you sure you want to overwrite it?',
            mtConfirmation, [mbYes, mbNo], 0) = mrNo Then
            Exit;
        DeleteFile(fFilename);
    End;

    Screen.Cursor := crHourGlass;
    btnImport.Enabled := False;

    SetFilename(fFilename);
    SetDevName(StringReplace(ExtractFileName(fFilename), DEV_EXT, '', []));
    WriteDefaultEntries;

    // locate selected target
    If Not LocateTarget(StartAt, EndAt) Then
    Begin
        sMsg := Format(Lang[ID_MSVC_MSG_CANTLOCATETARGET], [cmbConf.Text]);
        MessageDlg(sMsg, mtError, [mbOK], 0);
        Exit;
    End;

    //  WriteDev('Project', 'Type', '0');
    ReadProjectType;
    ReadCompilerOptions(StartAt, EndAt);
    ReadLinkerOptions(StartAt, EndAt);
    LocateSourceTarget(SrcStartAt, SrcEndAt);
    ReadSourceFiles(SrcStartAt, SrcEndAt);
    If fInvalidFiles = '' Then
        sMsg := Lang[ID_MSVC_MSG_SUCCESS]
    Else
        sMsg := 'Some files belonging to project could not be located.'#13#10 +
            'Please locate them and add them to the project manually...'#13#10#13#10 +
            fInvalidFiles + #13#10'Project created with errors. Do you want to open it?';
    If MessageDlg(sMsg, mtConfirmation, [mbYes, mbNo], 0) = mrYes Then
        ModalResult := mrOk
    Else
        Close;

    btnImport.Enabled := True;
    Screen.Cursor := crDefault;

End;

Procedure TImportMSVCForm.ReadProjectType();
Var
    I: Integer;
    P: Pchar;
Begin
    I := 0;
    While I < fSL.Count Do
    Begin
        If AnsiStartsText('# TARGTYPE', fSL[I]) Then
        Begin
            // got it
            P := Pchar(Copy(fSL[I], Length(fSL[I]) - 5, 7));
            If (P = '0x0102') Then // "Win32 (x86) Dynamic-Link Library"
                WriteDev('Project', 'Type', '3')
            Else
            If (P = '0x0103') Then // "Win32 (x86) Console Application"
                WriteDev('Project', 'Type', '1')
            Else
            If (P = '0x0104') Then // "Win32 (x86) Static Library"
                WriteDev('Project', 'Type', '2')
            Else // unknown
                WriteDev('Project', 'Type', '0');
            Break;
        End;
        Inc(I);
    End;
End;

Procedure TImportMSVCForm.FormClose(Sender: TObject;
    Var Action: TCloseAction);
Begin
    Action := caFree;
End;

Procedure TImportMSVCForm.btnBrowseClick(Sender: TObject);
Begin
    OpenDialog1.Filter := FLT_MSVCPROJECTS;
    OpenDialog1.Title := Lang[ID_MSVC_SELECTMSVC];
    If OpenDialog1.Execute Then
    Begin
        fFileName := StringReplace(OpenDialog1.FileName,
            ExtractFileExt(OpenDialog1.FileName), DEV_EXT, []);
        txtVC.Text := OpenDialog1.FileName;
        txtDev.Text := fFilename;
        ImportFile(OpenDialog1.FileName);
    End;
    UpdateButtons;
End;

Function TImportMSVCForm.GetFilename: String;
Begin
    Result := fFilename;
End;

Procedure TImportMSVCForm.txtDevChange(Sender: TObject);
Begin
    UpdateButtons;
End;

Procedure TImportMSVCForm.btnBrowseDevClick(Sender: TObject);
Begin
    SaveDialog1.Filter := FLT_PROJECTS;
    SaveDialog1.Title := Lang[ID_MSVC_SELECTDEV];
    If SaveDialog1.Execute Then
        txtDev.Text := SaveDialog1.Filename;
End;

Procedure TImportMSVCForm.LoadText;
Begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_MSVC_MENUITEM];

    lbSelect.Caption := Lang[ID_MSVC_SELECTMSVC] + ':';
    lbConf.Caption := Lang[ID_MSVC_CONFIGURATION] + ':';
    lbDev.Caption := Lang[ID_MSVC_SELECTDEV] + ':';
    gbOptions.Caption := Lang[ID_MSVC_OPTIONS];
    btnImport.Caption := Lang[ID_BTN_IMPORT];
    btnCancel.Caption := Lang[ID_BTN_CANCEL];
End;

Function TImportMSVCForm.CheckVersion: Boolean;
//var
//    I: integer;
Begin

    Result := True;

    // GAR 24 Oct 2008
    // I think there's no need to check the version. This either works or
    //   it doesn't. Besides, the current format is much different.
    //Result := False;

    //for I := 0 to fSL.Count - 1 do
    //  if AnsiContainsStr(fSL[I], 'Format Version 6.00') then begin
    //    Result := True;
    //    Break;
    //  end;
    //if not Result then
    //  MessageDlg('This file''s version is not one that can be imported...', mtWarning, [mbOK], 0);
End;

Procedure TImportMSVCForm.CreateParams(Var Params: TCreateParams);
Begin
    Inherited;
    If (Parent <> Nil) Or (ParentWindow <> 0) Then
        Exit;  // must not mess with wndparent if form is embedded

    If Assigned(Owner) And (Owner Is TWincontrol) Then
        Params.WndParent := TWinControl(Owner).handle
    Else
    If Assigned(Screen.Activeform) Then
        Params.WndParent := Screen.Activeform.Handle;
End;

End.
