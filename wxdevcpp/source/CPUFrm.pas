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

unit CPUFrm;

interface

uses
{$IFDEF WIN32}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, SynEdit, XPMenu, debugger,
  SynEditHighlighter, SynHighlighterAsm, ExtCtrls, ComCtrls;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QButtons, QSynEdit, debugger;
{$ENDIF}

type
  TCPUForm = class(TForm)
    gbAsm: TGroupBox;
    edFunc: TEdit;
    lblFunc: TLabel;
    CodeList: TSynEdit;
    gbRegisters: TGroupBox;
    XPMenu: TXPMenu;
    SynAsmSyn1: TSynAsmSyn;
    rgSyntax: TRadioGroup;
    Registers: TListView;
    CloseBtn: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edFuncKeyPress(Sender: TObject; var Key: Char);
    procedure rgSyntaxClick(Sender: TObject);
    procedure OnActiveLine(Sender: TObject; Line: Integer;
      var Special: Boolean; var FG, BG: TColor);
    procedure CloseBtnClick(Sender: TObject);

  private
    ActiveLine: integer;
    fDebugger: TDebugger;

    procedure LoadText;
    procedure OnRegisters(Registers: TRegisters);
    procedure OnDisassembly(Disassembly: string);

    { Private declarations }
  public
    { Public declarations }
    procedure PopulateRegisters(debugger: TDebugger);
  end;

var
  CPUForm: TCPUForm;

implementation

uses 
  main, version, MultiLangSupport, utils, devcfg, //debugwait,
  Types; 

{$R *.dfm}

procedure TCPUForm.FormCreate(Sender: TObject);
begin
  ActiveLine := -1;
  LoadText;
end;

procedure TCPUForm.LoadText;
begin
  DesktopFont := True;
  XPMenu.Active := devData.XPTheme;
  with Lang do begin
    Caption := Strings[ID_CPU_CAPTION];
    gbAsm.Caption := Strings[ID_CPU_ASMCODE];
    rgSyntax.Caption := Strings[ID_CPU_SYNTAX];
    gbRegisters.Caption := Strings[ID_CPU_REGISTERS];
    lblFunc.Caption := Strings[ID_CPU_FUNC];
    CloseBtn.Caption := Strings[ID_BTN_CLOSE];
  end;
end;

procedure TCPUForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  fDebugger.OnDisassemble := nil;
  fDebugger.OnRegisters := nil;
  CPUForm := nil;
end;

procedure TCPUForm.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TCPUForm.rgSyntaxClick(Sender: TObject);
begin
  if fDebugger.Executing then
  begin
    if TRadioGroup(Sender).ItemIndex = 0 then
      fDebugger.SetAssemblySyntax(asIntel)
    else
      fDebugger.SetAssemblySyntax(asATnT);

    //Reload the disassembly
    fDebugger.Disassemble;
  end;
end;

procedure TCPUForm.edFuncKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and fDebugger.Executing then
    fDebugger.Disassemble(edFunc.Text);
end;

procedure TCPUForm.PopulateRegisters(debugger: TDebugger);
begin
  //Set the assembly syntax to be Intel's syntax (we ARE on x86, after all!)
  //Now, some debuggers do not support the changing of assembly syntaxes and
  //only support Intel's assembly syntax. So we surround the entire function with
  //a try-catch, if we catch an AbstractError we disable the syntax switching radio group.
{$WARNINGS OFF (EAbstractError is specific to a platform)}
  try
    debugger.SetAssemblySyntax(asIntel);
  except
    on E: EAbstractError do
     rgSyntax.Enabled := False;
  end;
{$WARNINGS ON}
  
  fDebugger := debugger;
  fDebugger.OnRegisters := OnRegisters;
  fDebugger.OnDisassemble := OnDisassembly;
  fDebugger.GetRegisters;
  fDebugger.Disassemble;
end;

procedure TCPUForm.OnRegisters(Registers: TRegisters);
begin
  with Registers do
    with Self.Registers do
    begin
      Items[0].SubItems.Add(EAX);
      Items[1].SubItems.Add(EBX);
      Items[2].SubItems.Add(ECX);
      Items[3].SubItems.Add(EDX);
      Items[4].SubItems.Add(ESI);
      Items[5].SubItems.Add(EDI);
      Items[6].SubItems.Add(EBP);
      Items[7].SubItems.Add(ESP);
      Items[8].SubItems.Add(EIP);
      Items[9].SubItems.Add(CS);
      Items[10].SubItems.Add(DS);
      Items[11].SubItems.Add(SS);
      Items[12].SubItems.Add(ES);
      Items[13].SubItems.Add(FS);
      Items[14].SubItems.Add(GS);
      Items[15].SubItems.Add(EFLAGS);
    end;
end;

procedure TCPUForm.OnActiveLine(Sender: TObject; Line: Integer;
  var Special: Boolean; var FG, BG: TColor);
var pt : TPoint;
  begin
   if (Line = ActiveLine) then begin
    StrtoPoint(pt, devEditor.Syntax.Values[cABP]);
    BG := pt.X;
    FG := pt.Y;
    Special := TRUE;
  end;
end;

procedure TCPUForm.OnDisassembly(Disassembly: string);
var
  i: integer;
begin
  CodeList.Lines.Text := Disassembly;
  for i := 0 to CodeList.Lines.Count - 1 do
    if pos(Registers.Items[8].SubItems[0], CodeList.Lines[i]) <> 0 then begin
      if (ActiveLine <> i) and (ActiveLine <> -1) then
        CodeList.InvalidateLine(ActiveLine);
      ActiveLine := i + 1;
      CodeList.InvalidateLine(ActiveLine);
      CodeList.CaretY := ActiveLine;
      CodeList.EnsureCursorPosVisible;
      break;
    end;
end;

end.
