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

unit ImportMSVCFm;

interface

uses
xprocs,
{$IFDEF WIN32}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QButtons, QStdCtrls;
{$ENDIF}

type
  TImportMSVCForm = class(TForm)
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
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    XPMenu: TXPMenu;
    btnBrowseDev: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnBrowseClick(Sender: TObject);
    procedure txtDevChange(Sender: TObject);
    procedure btnBrowseDevClick(Sender: TObject);
  private
    { Private declarations }
    fSL: TStringList;
    fFilename: string;
    fInvalidFiles: string;
    procedure LoadText;
    procedure WriteDev(Section, Key, Value: string);
    procedure ImportFile(Filename: string);
    procedure WriteDefaultEntries;
    procedure SetFilename(Value: string);
    procedure SetDevName(Value: string);
    function ReadTargets(Targets: TStringList): boolean;
    function LocateTarget(var StartAt, EndAt: integer): boolean;
    function LocateSourceTarget(var StartAt, EndAt: integer): boolean;
    function ReadCompilerOptions(StartAt, EndAt: integer): boolean;
    function ReadLinkerOptions(StartAt, EndAt: integer): boolean;
    procedure ReadSourceFiles(StartAt, EndAt: integer);
    procedure ReadProjectType;
    function GetLineValue(StartAt, EndAt: integer; StartsWith: string): string;
    function StripQuotesIfNecessary(s: string): string;
    procedure UpdateButtons;
    function CheckVersion: boolean;
  public
    { Public declarations }
    function GetFilename: string;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  ImportMSVCForm: TImportMSVCForm;

implementation

uses IniFiles, StrUtils, version, MultiLangSupport, devcfg, utils;

{$R *.dfm}

{ TImportMSVCForm }

procedure TImportMSVCForm.UpdateButtons;
begin
  btnImport.Enabled := FileExists(txtVC.Text) and DirectoryExists(ExtractFilePath(txtDev.Text));
  cmbConf.Enabled := txtVC.Text <> '';
  txtDev.Enabled := txtVC.Text <> '';
  btnBrowseDev.Enabled := txtVC.Text <> '';
end;

procedure TImportMSVCForm.FormCreate(Sender: TObject);
begin
  fSL := TStringList.Create;
  LoadText;
end;

procedure TImportMSVCForm.FormDestroy(Sender: TObject);
begin
  fSL.Free;
end;

procedure TImportMSVCForm.FormShow(Sender: TObject);
begin
  txtVC.Text := '';
  txtDev.Text := '';
  cmbConf.Clear;
  UpdateButtons;
end;

function TImportMSVCForm.GetLineValue(StartAt, EndAt: integer;
  StartsWith: string): string;
var
  I: integer;
begin
  Result := '';
  if EndAt > fSL.Count - 1 then
    EndAt := fSL.Count - 1;
  I := StartAt;
  while I <= EndAt do begin
    if AnsiStartsText(StartsWith, fSL[I]) then begin
        Result := StripQuotesIfNecessary(Trim(Copy(fSL[I], Length(StartsWith) + 1, Length(fSL[I]) - Length(StartsWith))));
        Break;
    end;
    Inc(I);
  end;
end;

procedure TImportMSVCForm.ImportFile(Filename: string);
var
  Targets: TStringList;
begin
  fSL.LoadFromFile(Filename);

  Targets := TStringList.Create;
  try
    // check file for version
    if not CheckVersion then
      Exit;

    // read targets
    if not ReadTargets(Targets) then
      Exit;

    // fill the targets combo
    cmbConf.Items.Assign(Targets);
    if cmbConf.Items.Count > 0 then begin
      cmbConf.ItemIndex := 0;
    end;
  finally
    Targets.Free;
  end;
end;

function TImportMSVCForm.LocateTarget(var StartAt,
  EndAt: integer): boolean;
var
  I: integer;
begin
  Result := False;
  I := 0;
  while I < fSL.Count do begin
    if (AnsiStartsStr('!IF ', fSL[I]) or AnsiStartsStr('!ELSEIF ', fSL[I])) and AnsiContainsStr(fSL[I], cmbConf.Text) then begin
      Inc(I);
      StartAt := I;
      while not (AnsiStartsStr('!ENDIF', fSL[I]) or AnsiStartsStr('!ELSEIF', fSL[I])) and (I < fSL.Count) do
        Inc(I);
      EndAt := I - 1;
      Result := True;
      Break;
    end;
    Inc(I);
  end;
end;

function TImportMSVCForm.LocateSourceTarget(var StartAt,
  EndAt: integer): boolean;
var
  I: integer;
begin
  Result := False;
  I := 0;
  while I < fSL.Count do begin
    if (AnsiStartsStr('# Begin Target', fSL[I])) then begin
      Inc(I);
      StartAt := I;
      while not (AnsiStartsStr('# End Target', fSL[I])) do
        Inc(I);
      EndAt := I - 1;
      Result := True;
      Break;
    end;
    Inc(I);
  end;
end;

function TImportMSVCForm.ReadCompilerOptions(StartAt,
  EndAt: integer): boolean;
var
  I: integer;
  inQuotes : boolean;
  Options, Options_temp: TStringList;
  sCompiler, sCompiler2003, sCompiler2008: string;
  sCompilerSettings, sCompilerSettings2003, sCompilerSettings2008 : string;
  sDirs, sDirs2003, sDirs2008: string;
  S, Stemp: string;
begin
  Result := False;

  sCompiler := '-D__GNUWIN32__' + '_@@_';
  sDirs := '';
  sCompilerSettings := '0000000000000000000000';

  sCompiler2003 := '';
  sDirs2003 := '';
  sCompilerSettings2003 := '0000000000000000000000000000000000000000';
                            
  sCompiler2008 := '';
  sDirs2008 := '';
  sCompilerSettings2008 := '000000000000000000000000000000000000';

  Options := TStringList.Create;
  Options_temp := TStringList.Create;
  try

    S := GetLineValue(StartAt, EndAt, '# ADD CPP');

       // Use the spaces to Tokenize the linker options
    strTokenToStrings(S, ' ', Options_temp);

    // Let's re-parse our space-delimited list.
    // There may be some double quotes in the options list
    // Spaces can be contained within double quotes so let's
    // recombine items that are within double quotes to correct
    // that tokenizing error.  Also, let's remove any blank
    // options
    inQuotes := false;
    Stemp := '';
    for I := 0 to (Options_temp.Count - 1) do
    begin
       if (inQuotes) then
        begin
             if AnsiContainsText(Options_temp[I], '"') then
             begin
                inQuotes := false;
                Stemp := Stemp + ' ' + Options_temp[I];
                Options.Add(Stemp);
             end
             else
                Stemp := Stemp + ' ' + Options_temp[I];

        end
        else
        begin
            // If there's only one double quote, then we're at the
            //   start of a string. Continue parsing until the next
            //   double quote. If there's 2 double quotes, then
            //   we don't need to keep parsing.
            if (StrTokenCount(Options_temp[I], '"') = 1) then
             begin
                inQuotes := true;
                Stemp := Options_temp[I];
             end
            else if (Length(strTrim(Options_temp[I])) > 0) then
             begin
                Options.Add(Options_temp[I]);
             end
        end

    end;

    I := 0;

    while I < Options.Count do begin

   // ShowMessage('compiler:  ' +  Options[I]);

       if strEqual('/Za', Options[I]) then
       begin // disable language extensions

        // MingW gcc
        //sCompiler := sCompiler + '-ansi ';
        // CompilerOptions position 1
        sCompilerSettings[1] := '1';

        // MSVC6/2003
        sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

        // MSVC2005/2008
        sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

        Inc(I);
      end
      else if strEqual('/GX', Options[I]) then begin // enable exception handling

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
      end
      else if strEqual('/Ot', Options[I]) then begin

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
      end
      else if strEqual('/Os', Options[I]) then begin

        // MingW gcc
       sCompiler := sCompiler + '-Os' + '_@@_';


        // MSVC6/2003
        // CompilerOptions position 1
        sCompilerSettings2003[1] := 'a';

        // MSVC2005/2008
        // CompilerOptions position 1
        sCompilerSettings2008[1] := 'a';

        Inc(I);
      end
      else if strEqual('/O2', Options[I]) then begin

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
      end
      else if strEqual('/O1', Options[I]) then begin

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
      end
      else if strEqual('/Og', Options[I]) then begin

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
      end
      else if strEqual('/Oa', Options[I]) then begin

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
      end
      else if strEqual('/Oi', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 5
        sCompilerSettings2003[5] := '1';

        // MSVC2005/2008
        // CompilerOptions position 5
        sCompilerSettings2008[5] := '1';

        Inc(I);
      end
      else if StrEqual('/Ow', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 6
        sCompilerSettings2003[6] := '1';

        // MSVC2005/2008
        // CompilerOptions position 6
        sCompilerSettings2008[6] := '1';

        Inc(I);
      end
      else if strEqual('/GA', Options[I]) then begin
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
      end
      else if strEqual('/Oy', Options[I]) then begin

        // MingW gcc
        sCompiler := sCompiler + '-fomit-frame-pointer' + '_@@_';

        // MSVC6/2003
        // CompilerOptions position 8
        sCompilerSettings2003[8] := '1';

        // MSVC2005/2008
        // CompilerOptions position 8
        sCompilerSettings2008[8] := '1';

        Inc(I);
      end
      else if strEqual('/GB', Options[I]) then begin // blend optimization

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
      end
      else if strEqual('/G5', Options[I]) then begin // pentium optimization

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
      end
      else if strEqual('/G6', Options[I]) then begin // pentium pro optimization

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
      end
       else if strEqual('/Gr', Options[I]) then begin
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
      end
      else if strEqual('/Gz', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 10
        sCompilerSettings2003[10] := 'a';

        // MSVC2005/2008
        // CompilerOptions position 9
        sCompilerSettings2008[9] := 'a';

        Inc(I);
      end
      else if strEqual('/Gf', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 11
        sCompilerSettings2003[11] := '1';

        // MSVC2005/2008
        // CompilerOptions position 10
        sCompilerSettings2008[10] := '1';

        Inc(I);
      end
      else if strEqual('/GF', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 11
        sCompilerSettings2003[11] := 'a';

        // MSVC2005/2008
        // CompilerOptions position 10
        sCompilerSettings2008[10] := 'a';

        Inc(I);
      end
      else if strEqual('/clr', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 12
        sCompilerSettings2003[12] := '1';

        // MSVC2005/2008
        // CompilerOptions position 11
        sCompilerSettings2008[11] := '1';

        Inc(I);
      end
      else if strEqual('/clr:noAssembly', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 12
        sCompilerSettings2003[12] := 'a';

        // MSVC2005/2008
        // CompilerOptions position 11
        sCompilerSettings2008[11] := 'a';

        Inc(I);
      end
      else if strEqual('/clr:pure', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 12
        sCompilerSettings2003[12] := 'b';

        // MSVC2005/2008
        // CompilerOptions position 11
        sCompilerSettings2008[11] := 'b';

        Inc(I);
      end
      else if strEqual('/clr:safe', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 12
        sCompilerSettings2003[12] := 'c';

        // MSVC2005/2008
        // CompilerOptions position 11
        sCompilerSettings2008[11] := 'c';

        Inc(I);
      end
      else if strEqual('/clr:oldSyntax', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 12
        sCompilerSettings2003[12] := 'd';

        // MSVC2005/2008
        // CompilerOptions position 11
        sCompilerSettings2008[11] := 'd';

        Inc(I);
      end
      else if strEqual('/clr:initialAppDomain', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 12
        sCompilerSettings2003[12] := 'e';

        // MSVC2005/2008
        // CompilerOptions position 11
        sCompilerSettings2008[11] := 'e';

        Inc(I);
      end
      else if strEqual('/arch:SSE', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 13
        sCompilerSettings2003[13] := '1';

        // MSVC2005/2008
        // CompilerOptions position 13
        sCompilerSettings2008[13] := '1';

        Inc(I);
      end
      else if strEqual('/arch:SSE2', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 13
        sCompilerSettings2003[13] := 'a';

        // MSVC2005/2008
        // CompilerOptions position 13
        sCompilerSettings2008[13] := 'a';

        Inc(I);
      end
      else if strEqual('/EHs', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 14
        sCompilerSettings2003[14] := '1';

        // MSVC2005/2008
        // CompilerOptions position 14
        sCompilerSettings2008[14] := '1';

        Inc(I);
      end
      else if strEqual('/EHa', Options[I]) then begin

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
      end
      else if strEqual('/Gh', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 15
        sCompilerSettings2003[15] := '1';

        // MSVC2005/2008
        // CompilerOptions position 15
        sCompilerSettings2008[15] := '1';

        Inc(I);
      end
       else if strEqual('/GH', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 16
        sCompilerSettings2003[16] := '1';

        // MSVC2005/2008
        // CompilerOptions position 16
        sCompilerSettings2008[16] := '1';

        Inc(I);
      end
       else if strEqual('/GR', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 17
        sCompilerSettings2003[17] := '1';

        // MSVC2005/2008
        // CompilerOptions position 17
        sCompilerSettings2008[17] := '1';

        Inc(I);
      end
       else if strEqual('/Gm', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 18
        sCompilerSettings2003[18] := '1';

        // MSVC2005/2008
        // CompilerOptions position 18
        sCompilerSettings2008[18] := '1';

        Inc(I);
      end
       else if strEqual('/GL', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 19
        sCompilerSettings2003[19] := '1';

        // MSVC2005/2008
        // CompilerOptions position 19
        sCompilerSettings2008[19] := '1';

        Inc(I);
      end
       else if strEqual('/EHc', Options[I]) then begin 
        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 20
        sCompilerSettings2003[20] := '1';

        // MSVC2005/2008
        // CompilerOptions position 20
        sCompilerSettings2008[20] := '1';

        Inc(I);
      end
       else if strEqual('/Gy', Options[I]) then begin 

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 21
        sCompilerSettings2003[21] := '1';

        // MSVC2005/2008
        // CompilerOptions position 21
        sCompilerSettings2008[21] := '1';

        Inc(I);
      end
       else if strEqual('/GT', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 22
        sCompilerSettings2003[22] := '1';

        // MSVC2005/2008
        // CompilerOptions position 22
        sCompilerSettings2008[22] := '1';

        Inc(I);
      end
       else if strEqual('/Ge', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 23
        sCompilerSettings2003[23] := '1';

        // MSVC2005/2008
        // CompilerOptions position 23
        sCompilerSettings2008[23] := '1';

        Inc(I);
      end
      else if strEqual('/GS', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 23
        sCompilerSettings2003[23] := '1';

        // MSVC2005/2008
        // CompilerOptions position 23
        sCompilerSettings2008[23] := '1';

        Inc(I);
      end
      else if strEqual('/RTCc', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 24
        sCompilerSettings2003[24] := '1';

        // MSVC2005/2008
        // CompilerOptions position 24
        sCompilerSettings2008[24] := '1';

        Inc(I);
      end
      else if strEqual('/RTCs', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 25
        sCompilerSettings2003[25] := '1';

        // MSVC2005/2008
        // CompilerOptions position 25
        sCompilerSettings2008[25] := '1';

        Inc(I);
      end
      else if strEqual('/RTCu', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 25
        sCompilerSettings2003[25] := '1';

        // MSVC2005/2008
        // CompilerOptions position 25
        sCompilerSettings2008[25] := '1';

        Inc(I);
      end
      else if strEqual('/Zi', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 27
        sCompilerSettings2003[27] := '1';

        // MSVC2005/2008
        // CompilerOptions position 27
        sCompilerSettings2008[27] := '1';

        Inc(I);
      end
      else if strEqual('/ZI', Options[I])then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 27
        sCompilerSettings2003[27] := 'a';

        // MSVC2005/2008
        // CompilerOptions position 27
        sCompilerSettings2008[27] := 'a';

        Inc(I);
      end
      else if strEqual('/Z7', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 27
        sCompilerSettings2003[27] := 'b';

        // MSVC2005/2008
        // CompilerOptions position 27
        sCompilerSettings2008[27] := 'b';

        Inc(I);
      end
      else if strEqual('/Zd', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 27
        sCompilerSettings2003[27] := 'c';

        // MSVC2005/2008
        // CompilerOptions position 27
        sCompilerSettings2008[27] := 'c';

        Inc(I);
      end
      else if strEqual('/Zl', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 28
        sCompilerSettings2003[28] := '1';

        // MSVC2005/2008
        // CompilerOptions position 28
        sCompilerSettings2008[28] := '1';

        Inc(I);
      end
      else if strEqual('/Zg', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 29
        sCompilerSettings2003[29] := '1';

        // MSVC2005/2008
        // CompilerOptions position 29
        sCompilerSettings2008[29] := '1';

        Inc(I);
      end
      else if strEqual('/openmp', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 30
        sCompilerSettings2003[30] := '1';

        // MSVC2005/2008
        // CompilerOptions position 30
        sCompilerSettings2008[30] := '1';

        Inc(I);
      end
      else if strEqual('/Zc:forScope', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 31
        sCompilerSettings2003[31] := '1';

        // MSVC2005/2008
        // CompilerOptions position 31
        sCompilerSettings2008[31] := '1';

        Inc(I);
      end
      else if strEqual('/Zc:wchar_t', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 32
        sCompilerSettings2003[32] := '1';

        // MSVC2005/2008
        // CompilerOptions position 32
        sCompilerSettings2008[32] := '1';

        Inc(I);
      end
      else if strEqual('/WX', Options[I]) then begin // warnings as errors

        // MingW gcc
        sCompiler := sCompiler + '-Werror' + '_@@_';

        // MSVC6/2003
        // CompilerOptions position 36
        sCompilerSettings2003[36] := '1';

        // MSVC2005/2008
        // CompilerOptions position 33
        sCompilerSettings2008[33] := '1';

        Inc(I);
      end
      else if strEqual('/W1', Options[I]) or
        strEqual('/W2', Options[I]) or
        strEqual('/W3', Options[I]) then
        begin // warning messages

        // MingW gcc
        sCompiler := sCompiler + '-W' + '_@@_';

        // MSVC6/2003
        // CompilerOptions position 37
        if strEqual('/W2', Options[I]) then
           sCompilerSettings2003[37] := '1';

        if strEqual('/W3', Options[I]) then
           sCompilerSettings2003[37] := 'a';

        // MSVC2005/2008
        // CompilerOptions position 34
        if strEqual('/W2', Options[I]) then
           sCompilerSettings2008[34] := '1';

        if strEqual('/W3', Options[I])  then
           sCompilerSettings2008[34] := 'a';

        Inc(I);
      end
      else if strEqual('/W4', Options[I]) then begin // all warning messages

        // MingW gcc
        sCompiler := sCompiler + '-Wall' + '_@@_';

        // MSVC6/2003
        // CompilerOptions position 37
        sCompilerSettings2003[37] := 'b';

        // MSVC2005/2008
        // CompilerOptions position 34
        sCompilerSettings2008[34] := 'b';

        Inc(I);
      end
      else if strEqual('/Wp64', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 35
        sCompilerSettings2003[35] := '1';

        // MSVC2005/2008
        // CompilerOptions position 35
        sCompilerSettings2008[35] := '1';

        Inc(I);
      end
      else if strEqual('/INCREMENTAL:NO', Options[I]) then begin

        // MingW gcc
       // Do nothing

        // MSVC6/2003
        // CompilerOptions position 36
        sCompilerSettings2003[36] := '1';

        // MSVC2005/2008
        // CompilerOptions position 36
        sCompilerSettings2008[36] := '1';

        Inc(I);
      end
      // /D = Defines a preprocessing symbol for your source file.
      else if strEqual('/D', Options[I]) then begin
        // MingW gcc
        S := Format('-D%s', [AnsiDequotedStr(Options[I + 1], '"')]);
        sCompiler := sCompiler + S + '_@@_';

        // MSVC6/2003
        S := Format('/D %s', [Options[I + 1]]);
        sCompiler2003 := sCompiler2003 + S + '_@@_';

        // MSVC2005/2008
        S := Format('/D%s', [AnsiDequotedStr(Options[I + 1], '"')]);
        sCompiler2008 := sCompiler2008 + S + '_@@_';

        Inc(I); Inc(I);
      end
      else if strEqual('/U', Options[I]) then begin

        S := Format('-U%s', [Options[I + 1]]);
        sCompiler := sCompiler + S + '_@@_';

        // MSVC6/2003
        S := Format('/U %s', [Options[I + 1]]);
        sCompiler2003 := sCompiler2003 + S + '_@@_';

        // MSVC2005/2008
        S := Format('/U %s', [Options[I + 1]]);
        sCompiler2008 := sCompiler2008 + S + '_@@_';

        Inc(I); Inc(I);
      end
      else if strEqual('/I', Options[I]) then begin

        // MingW gcc  +   MSVC2005/2008
        sDirs := sDirs + Options[I+1] + ';';
        sDirs2003 := sDirs2003 + Options[I+1] + ';';
        sDirs2008 := sDirs2008 + Options[I+1] + ';';

        Inc(I); Inc(I);
      end
      else if strEqual('/Ob0', Options[I]) then begin // disable inline expansion

        // MingW gcc
        sCompiler := sCompiler + '-fno-inline' + '_@@_';

        // MSVC6/2003
        sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

        // MSVC2005/2008
        sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

        Inc(I);
      end
      else if strEqual('/Ob2', Options[I]) then begin // auto inline function expansion

        // MingW gcc
        sCompiler := sCompiler + '-finline-functions' + '_@@_';

         // MSVC6/2003
        sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

         // MSVC2005/2008
        sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

        Inc(I);
      end
      else if strEqual('/G4', Options[I]) then begin // 486 optimization

        // MingW gcc
        //sCompiler := sCompiler + '-mcpu=i486 -D_M_IX86=400 ';
        // CompilerOptions position 21
        sCompilerSettings[21] := '2';

        // MSVC6/2003
        sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

        // MSVC2005/2008
        sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

        Inc(I);
      end
      else if strEqual('/G3', Options[I]) then begin // 386 optimization

        // MingW gcc
        //sCompiler := sCompiler + '-mcpu=i386 -D_M_IX86=300 ';
        // CompilerOptions position 21
        sCompilerSettings[21] := '1';

        // MSVC6/2003
        sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

        // MSVC2005/2008
        sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

        Inc(I);
      end
      else if strEqual('/Zp1', Options[I]) then begin // pack structures

        // MingW gcc
        sCompiler := sCompiler + '-fpack-struct' + '_@@_';

        // MSVC6/2003
        sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

        // MSVC2005/2008
        sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

        Inc(I);
      end
      else if strEqual('/W0', Options[I]) then begin // no warning messages

        // MingW gcc
        sCompiler := sCompiler + '-w' + '_@@_';

        // MSVC6/2003
        sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

        // MSVC2005/2008
        sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

        Inc(I);
        end
      else if strEqual('/c', Options[I]) then begin // compile only

        // MingW gcc
        sCompiler := sCompiler + '-c' + '_@@_';

        // MSVC6/2003
        sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

        // MSVC2005/2008
        sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

        Inc(I);
        end
      else if strEqual('/nologo', Options[I]) then begin

        // MingW gcc
        // Do nothing

        // MSVC6/2003
        sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';

        // MSVC2005/2008
        sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';

        Inc(I);
        end
      else     // No idea what to do with this so let's just send it as is
         begin

           if (Length(strTrim(Options[I])) > 0) then
           begin
                sCompiler := sCompiler + Options[I] + '_@@_';
                sCompiler2003 := sCompiler2003 + Options[I] + '_@@_';
                sCompiler2008 := sCompiler2008 + Options[I] + '_@@_';
           end ;
           Inc(I);

         end
    end;

    // MingW gcc
    WriteDev('Profile1', 'Compiler', sCompiler);
    WriteDev('Profile1', 'CppCompiler', sCompiler);

    WriteDev('Profile1', 'CompilerSettings', sCompilerSettings);

    if sDirs <> '' then
      sDirs := Copy(sDirs, 1, Length(sDirs) - 1);

    WriteDev('Profile1', 'Includes', sDirs);

    // MSVC6/MSVC2003
    WriteDev('Profile2', 'Compiler', sCompiler2003);
    WriteDev('Profile2', 'CppCompiler', sCompiler2003);

    WriteDev('Profile2', 'CompilerSettings', sCompilerSettings2003);

    if sDirs2003 <> '' then
      sDirs2003 := Copy(sDirs2003, 1, Length(sDirs2003) - 1);

    WriteDev('Profile2', 'Includes', sDirs2003);

    // MSVC2005/MSVC2008
    WriteDev('Profile3', 'Compiler', sCompiler2008);
    WriteDev('Profile3', 'CppCompiler', sCompiler2008);

    WriteDev('Profile3', 'CompilerSettings', sCompilerSettings2008);

    if sDirs2008 <> '' then
      sDirs2008 := Copy(sDirs2008, 1, Length(sDirs2008) - 1);

    WriteDev('Profile3', 'Includes', sDirs2008);

  finally
    Options.Free;
    Options_temp.Free;
  end;
end;

function TImportMSVCForm.ReadLinkerOptions(StartAt,
  EndAt: integer): boolean;
var
  I: integer;
  inQuotes : boolean;
  Options, Options_temp: TStringList;
  sLibs, sLibs2003, sLibs2008 : string;
  sDirs, sDirs2003, sDirs2008 : string;
  S, Stemp: string;
begin
  Result := False;
  sLibs := '';  sLibs2003 := ''; sLibs2008 := '';
  sDirs := '';  sDirs2003 := ''; sDirs2008 := '';
  Options := TStringList.Create;
  Options_temp := TStringList.Create;
  try

    S := GetLineValue(StartAt, EndAt, '# ADD LINK32');

    // Use the spaces to Tokenize the linker options
    strTokenToStrings(S, ' ', Options_temp);

    // Let's re-parse our space-delimited list.
    // There may be some double quotes in the options list
    // Spaces can be contained within double quotes so let's
    // recombine items that are within double quotes to correct
    // that tokenizing error.  Also, let's remove any blank
    // options
    inQuotes := false;
    Stemp := '';
    for I := 0 to (Options_temp.Count - 1) do
    begin
        if (inQuotes) then
        begin
             if AnsiContainsText(Options_temp[I], '"') then
             begin
                inQuotes := false;
                Stemp := Stemp + ' ' + Options_temp[I];
                Options.Add(Stemp);
             end
             else
                Stemp := Stemp + ' ' + Options_temp[I];

        end
        else
        begin
            // If there's only one double quote, then we're at the
            //   start of a string. Continue parsing until the next
            //   double quote. If there's 2 double quotes, then
            //   we don't need to keep parsing.
            if (StrTokenCount(Options_temp[I], '"') = 1) then
             begin
                inQuotes := true;
                Stemp := Options_temp[I];
             end
            else if (Length(strTrim(Options_temp[I])) > 0) then
             begin
                Options.Add(Options_temp[I]);
             end
        end

    end;

    for I := 0 to (Options.Count - 1) do
    begin
     //ShowMessage('Linker: ' + Options[I]);

      if AnsiEndsText('.lib', Options[I]) then
      begin
        // MingW gcc
        S := Copy(Options[I], 1, Length(Options[I]) - 4);
        if ExtractFilePath(S) <> '' then
          sDirs := sDirs + ExtractFilePath(S) + ';';
        S := Format('-l%s', [ExtractFileName(S)]);
        sLibs := sLibs + S + '_@@_';

        sLibs2003 := sLibs2003 + Options[I] + '_@@_';
        sLibs2008 := sLibs2008 + Options[I] + '_@@_';

      end
      else if AnsiStartsText('/base:', Options[I]) then begin
        S := Copy(Options[I], Length('/base:') + 1, MaxInt);
        sLibs := sLibs + '--image-base ' + S + '_@@_';
        sLibs2003 := sLibs2003 + Options[I] + '_@@_';
        sLibs2008 := sLibs2008 + Options[I] + '_@@_';
      end
      else if AnsiStartsText('/implib:', Options[I]) then begin
        S := Copy(Options[I], Length('/implib:') + 1, MaxInt);
        sLibs := sLibs + '--implib ' + S + '_@@_';
        sLibs2003 := sLibs2003 + Options[I] + '_@@_';
        sLibs2008 := sLibs2008 + Options[I] + '_@@_';
      end
      else if AnsiStartsText('/map:', Options[I]) then begin
        S := Copy(Options[I], Length('/map:') + 1, MaxInt);
        sLibs := sLibs + '-Map ' + S + '.map';
        sLibs2003 := sLibs2003 + Options[I] + '_@@_';
        sLibs2008 := sLibs2008 + Options[I] + '_@@_';
      end
      else if AnsiStartsText('/subsystem:', Options[I]) then begin
        S := Copy(Options[I], Length('/subsystem:') + 1, MaxInt);
        if S = 'windows' then begin
          WriteDev('Profile1', 'Type', '0'); // win32 gui
          WriteDev('Profile2', 'Type', '0'); // win32 gui
          WriteDev('Profile3', 'Type', '0'); // win32 gui
          end
        else if S = 'console' then
        begin
          WriteDev('Profile1', 'Type', '1'); // console app
          WriteDev('Profile2', 'Type', '1'); // console app
          WriteDev('Profile3', 'Type', '1'); // console app
        end
        //        sLibs := sLibs + '-Wl --subsystem ' + S + ' ';
      end
      else if AnsiStartsText('/libpath:', Options[I]) then begin
        S := Copy(Options[I], Length('/libpath:') + 1, MaxInt);
        sDirs := sDirs + S + ';';
        sDirs2003 := sDirs2003 + S + ';';
        sDirs2008 := sDirs2008 + S + ';';
      end
      else if strEqual('/nologo', Options[I]) then begin

        // MingW gcc
        // Do nothing

        // MSVC6/2003
        sLibs2003 := sLibs2003 + Options[I] + '_@@_';

        // MSVC2005/2008
        sLibs2008 := sLibs2008 + Options[I] + '_@@_';

        end
      else
      begin
        S := strTrim(Options[I]);
        sLibs := sLibs + S + '_@@_';
        sLibs2003 := sLibs2003 + Options[I] + '_@@_';
        sLibs2008 := sLibs2008 + Options[I] + '_@@_';
      end;
    end;

    WriteDev('Profile1', 'Linker', sLibs);
    WriteDev('Profile2', 'Linker', sLibs2003);
    WriteDev('Profile3', 'Linker', sLibs2008);
    if sDirs <> '' then
      sDirs := Copy(sDirs, 1, Length(sDirs) - 1);
    WriteDev('Profile1', 'Libs', sDirs);
    WriteDev('Profile2', 'Libs', sDirs2003);
    WriteDev('Profile3', 'Libs', sDirs2008);
  finally
    Options.Free;
    Options_temp.Free;
  end;
end;

procedure TImportMSVCForm.ReadSourceFiles(StartAt,
  EndAt: integer);
var
  flds: TStringList;
  I, C: integer;
  UnitName: string;
  folder: string;
  folders: string;
begin
  fInvalidFiles := '';
  C := 0;
  folders := '';
  flds := TStringList.Create;
  try
    flds.Delimiter := '/';
    for I := StartAt to EndAt do
    if (Length(fSL[I]) > 0) then begin
      if AnsiStartsText('# Begin Group ', fSL[I]) then begin
        folder := StripQuotesIfNecessary(Copy(fSL[I], 15, MaxInt));
        flds.Add(folder);
        folders := folders + flds.DelimitedText + ',';
      end
      else if AnsiStartsText('# End Group', fSL[I]) then begin
        if flds.Count > 0 then
          flds.Delete(flds.Count - 1);
      end
      else if AnsiStartsText('SOURCE=', fSL[I]) then begin
        UnitName := Copy(fSL[I], 8, Length(fSL[I]) - 7);
        if FileExists(UnitName) then begin
          UnitName := StringReplace(UnitName, '\', '/', [rfReplaceAll]);
          WriteDev('Unit' + IntToStr(C + 1), 'FileName', UnitName);
          WriteDev('Unit' + IntToStr(C + 1), 'Folder', flds.DelimitedText);
          case GetFileTyp(UnitName) of
            utSrc, utHead: begin
                WriteDev('Unit' + IntToStr(C + 1), 'Compile', '1');
                if AnsiSameText(ExtractFileExt(UnitName), '.c') then
                  WriteDev('Unit' + IntToStr(C + 1), 'CompileCpp', '0')
                else
                  WriteDev('Unit' + IntToStr(C + 1), 'CompileCpp', '1');
                WriteDev('Unit' + IntToStr(C + 1), 'Link', '1');
              end;
            utRes: begin
                WriteDev('Unit' + IntToStr(C + 1), 'Compile', '1');
                WriteDev('Unit' + IntToStr(C + 1), 'CompileCpp', '1');
                WriteDev('Unit' + IntToStr(C + 1), 'Link', '0');
              end;
          else begin
              WriteDev('Unit' + IntToStr(C + 1), 'Compile', '0');
              WriteDev('Unit' + IntToStr(C + 1), 'CompileCpp', '0');
              WriteDev('Unit' + IntToStr(C + 1), 'Link', '0');
            end;
          end;
          WriteDev('Unit' + IntToStr(C + 1), 'Priority', '1000');
          Inc(C);
        end
        else
          fInvalidFiles := fInvalidFiles + UnitName + #13#10;
      end;
      end;
  finally
    flds.Free;
  end;

  if folders <> '' then
    Delete(folders, Length(folders), 1);
  WriteDev('Project', 'UnitCount', IntToStr(C));
  WriteDev('Project', 'Folders', folders);
end;

function TImportMSVCForm.ReadTargets(Targets: TStringList): boolean;
var
  I: integer;
  P: PChar;
begin
  Targets.Clear;
  Result := False;
  I := 0;
  while I < fSL.Count do begin
    if AnsiStartsText('# Begin Target', fSL[I]) then begin
      // got it
      Inc(I);
      repeat
        if AnsiStartsText('# Name', fSL[I]) then begin
          P := PChar(Trim(Copy(fSL[I], 7, Length(fSL[I]) - 6)));
          Targets.Add(AnsiExtractQuotedStr(P, '"'));
          Result := True;
        end;
        Inc(I);
      until (I = fSL.Count) or AnsiStartsText('# Begin Source File', fSL[I]);
      Break;
    end;
    Inc(I);
  end;
end;

procedure TImportMSVCForm.SetDevName(Value: string);
begin
  WriteDev('Project', 'Name', Value);
end;

procedure TImportMSVCForm.SetFilename(Value: string);
begin
  WriteDev('Project', 'FileName', Value);
  fFilename := Value;
end;

function TImportMSVCForm.StripQuotesIfNecessary(s: string): string;
var
  P: PChar;
begin
  if AnsiStartsText('"', s) and AnsiEndsText('"', s) then begin
    P := PChar(S);
    Result := AnsiExtractQuotedStr(P, '"');
  end
  else
    Result := S;
end;

procedure TImportMSVCForm.WriteDefaultEntries;
begin
  WriteDev('Project', 'Ver', '3');
  WriteDev('Project', 'IsCpp', '1'); // all MSVC projects are C++ (correct me if I 'm wrong)
  WriteDev('Project', 'ProfilesCount', '3');
  WriteDev('Project', 'ProfileIndex', '0');

  WriteDev('Profile1', 'ProfileName', 'MingW 3.4.5');
  WriteDev('Profile1', 'ExeOutput', 'Output\MingW');
  WriteDev('Profile1', 'ObjectOutput', 'Objects\MingW');
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

end;

procedure TImportMSVCForm.WriteDev(Section, Key, Value: string);
var
  fIni: TIniFile;
begin
  fIni := TIniFile.Create(fFilename);
  try
    fIni.WriteString(Section, Key, Value);
  finally
    fIni.Free;
  end;
end;

procedure TImportMSVCForm.btnImportClick(Sender: TObject);
var
  StartAt, EndAt: integer;
  SrcStartAt, SrcEndAt: integer;
  sMsg: string;
begin
  if FileExists(fFilename) then begin
    if MessageDlg(fFilename + ' exists. Are you sure you want to overwrite it?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;
    DeleteFile(fFilename);
  end;

  Screen.Cursor := crHourGlass;
  btnImport.Enabled := false;

  SetFilename(fFilename);
  SetDevName(StringReplace(ExtractFileName(fFilename), DEV_EXT, '', []));
  WriteDefaultEntries;

  // locate selected target
  if not LocateTarget(StartAt, EndAt) then begin
    sMsg := Format(Lang[ID_MSVC_MSG_CANTLOCATETARGET], [cmbConf.Text]);
    MessageDlg(sMsg, mtError, [mbOK], 0);
    Exit;
  end;

  //  WriteDev('Project', 'Type', '0');
  ReadProjectType;
  ReadCompilerOptions(StartAt, EndAt);
  ReadLinkerOptions(StartAt, EndAt);
  LocateSourceTarget(SrcStartAt, SrcEndAt);
  ReadSourceFiles(SrcStartAt, SrcEndAt);
  if fInvalidFiles = '' then
    sMsg := Lang[ID_MSVC_MSG_SUCCESS]
  else
    sMsg := 'Some files belonging to project could not be located.'#13#10 +
      'Please locate them and add them to the project manually...'#13#10#13#10 +
      fInvalidFiles + #13#10'Project created with errors. Do you want to open it?';
  if MessageDlg(sMsg, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    ModalResult := mrOk
  else
    Close;

  btnImport.Enabled := true;
  Screen.Cursor := crDefault;

end;

procedure TImportMSVCForm.ReadProjectType();
var
  I: integer;
  P: PChar;
begin
  I := 0;
  while I < fSL.Count do begin
    if AnsiStartsText('# TARGTYPE', fSL[I]) then begin
      // got it
      P := PChar(Copy(fSL[I], Length(fSL[I]) - 5, 7));
      if (P = '0x0102') then // "Win32 (x86) Dynamic-Link Library"
        WriteDev('Project', 'Type', '3')
      else if (P = '0x0103') then // "Win32 (x86) Console Application"
        WriteDev('Project', 'Type', '1')
      else if (P = '0x0104') then // "Win32 (x86) Static Library"
        WriteDev('Project', 'Type', '2')
      else // unknown
        WriteDev('Project', 'Type', '0');
      Break;
    end;
    Inc(I);
  end;
end;

procedure TImportMSVCForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TImportMSVCForm.btnBrowseClick(Sender: TObject);
begin
  OpenDialog1.Filter := FLT_MSVCPROJECTS;
  OpenDialog1.Title := Lang[ID_MSVC_SELECTMSVC];
  if OpenDialog1.Execute then begin
    fFileName := StringReplace(OpenDialog1.FileName, ExtractFileExt(OpenDialog1.FileName), DEV_EXT, []);
    txtVC.Text := OpenDialog1.FileName;
    txtDev.Text := fFilename;
    ImportFile(OpenDialog1.FileName);
  end;
  UpdateButtons;
end;

function TImportMSVCForm.GetFilename: string;
begin
  Result := fFilename;
end;

procedure TImportMSVCForm.txtDevChange(Sender: TObject);
begin
  UpdateButtons;
end;

procedure TImportMSVCForm.btnBrowseDevClick(Sender: TObject);
begin
  SaveDialog1.Filter := FLT_PROJECTS;
  SaveDialog1.Title := Lang[ID_MSVC_SELECTDEV];
  if SaveDialog1.Execute then
    txtDev.Text := SaveDialog1.Filename;
end;

procedure TImportMSVCForm.LoadText;
begin
  DesktopFont       := True;
  XPMenu.Active     := devData.XPTheme;
  Caption           := Lang[ID_MSVC_MENUITEM];

  lbSelect.Caption  := Lang[ID_MSVC_SELECTMSVC] + ':';
  lbConf.Caption    := Lang[ID_MSVC_CONFIGURATION] + ':';
  lbDev.Caption     := Lang[ID_MSVC_SELECTDEV] + ':';
  gbOptions.Caption := Lang[ID_MSVC_OPTIONS];
  btnImport.Caption := Lang[ID_BTN_IMPORT];
  btnCancel.Caption := Lang[ID_BTN_CANCEL];
end;

function TImportMSVCForm.CheckVersion: boolean;
var
  I: integer;
begin

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
end;

procedure TImportMSVCForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if (Parent <> nil) or (ParentWindow <> 0) then
    Exit;  // must not mess with wndparent if form is embedded

  if Assigned(Owner) and (Owner is TWincontrol) then
    Params.WndParent := TWinControl(Owner).handle
  else if Assigned(Screen.Activeform) then
    Params.WndParent := Screen.Activeform.Handle;
end;

end.
