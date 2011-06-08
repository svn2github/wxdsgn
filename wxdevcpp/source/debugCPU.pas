unit debugCPU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, ValEdit, StdCtrls, ExtCtrls, ComCtrls;


type
  TDebugCPUFrm = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Panel4: TPanel;
    RegisterList: TValueListEditor;
    StaticText1: TStaticText;
    DisassemblyRefreshButton: TButton;
    MemoryRefreshButton: TButton;
    RegistersRefreshButton: TButton;
    MemoryAddressEdit: TEdit;
    MemoryCountEdit: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    MemoryRichEdit: TRichEdit;
    Label5: TLabel;
    SrcFileName: TEdit;
    DisassemblyRichEdit: TRichEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DisassemblyRefreshButtonClick(Sender: TObject);
    procedure MemoryRefreshButtonClick(Sender: TObject);
    procedure RegistersRefreshButtonClick(Sender: TObject);
    procedure RefreshAll(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
    procedure RefreshCPUDisassembly;
    procedure RefreshCPUMemory;
    procedure RefreshCPURegisters;

  public
    { Public declarations }
  end;

const
  NoFile: String = '<Enter here the source file to disassemble>';

  GDBDisassem: String = '-data-disassemble ';
  const CPURegList: String = '0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15';
const CPURegCount: Integer = 15;  // The number of values above - 1

  
var
  DebugCPUFrm: TDebugCPUFrm;

implementation

uses main;

{$R *.dfm}

//=================================================================

procedure TDebugCPUFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    MainForm.ViewCPUItem.Checked := false
end;

//=================================================================

procedure TDebugCPUFrm.DisassemblyRefreshButtonClick(Sender: TObject);
begin
  RefreshCPUDisassembly;
end;

//=================================================================

procedure TDebugCPUFrm.MemoryRefreshButtonClick(Sender: TObject);
begin
  RefreshCPUMemory;
end;

//=================================================================

procedure TDebugCPUFrm.RegistersRefreshButtonClick(Sender: TObject);
begin
  RefreshCPURegisters;
end;

//=================================================================

procedure TDebugCPUFrm.RefreshAll(Sender: TObject);
begin
  RefreshCPUDisassembly;
  RefreshCPUMemory;
  RefreshCPURegisters;
end;

//=================================================================

procedure TDebugCPUFrm.RefreshCPUDisassembly;
var
  cmd: String;

begin

  if (not(MainForm.fDebugger = nil)) then
  begin
    DisassemblyRichEdit.Clear;
    if (not ((SrcFileName.Text = NoFile) or (SrcFileName.Text = ''))) then
    begin
      cmd := format('%s -f %s -l 1 -- 1',[GDBDisassem, SrcFileName.Text]);
      MainForm.fDebugger.WriteToPipe(cmd);
    end;
  end;
end;

//=================================================================

procedure TDebugCPUFrm.RefreshCPUMemory;
begin
  if (not(MainForm.fDebugger = nil)) then
  begin
    MemoryRichEdit.Clear;
    if (not ((MemoryAddressEdit.Text = '')
         or (MemoryCountEdit.Text = '')
         or (MemoryCountEdit.Text = '0'))) then
    MainForm.fDebugger.WriteToPipe('-data-read-memory-bytes '
      + MemoryAddressEdit.Text + ' ' + MemoryCountEdit.Text);
  end;

end;

//=================================================================

procedure TDebugCPUFrm.RefreshCPURegisters;
begin

  if (not(MainForm.fDebugger = nil)) then
  begin
    RegisterList.Strings.Clear;
    MainForm.fDebugger.WriteToPipe('-data-list-register-names ' + CPURegList);
  end;
end;

//=================================================================

procedure TDebugCPUFrm.FormShow(Sender: TObject);
begin

  SrcFileName.Text := MainForm.GetActiveEditorName;
  // fProject.FileName ? ? ?
  RefreshAll(Sender);
end;

//=================================================================

procedure TDebugCPUFrm.FormCreate(Sender: TObject);
begin
  DebugCPUFrm.Visible := true;
  DebugCPUFrm.BringToFront;

  RefreshAll(Sender);
end;

//=================================================================

procedure TDebugCPUFrm.FormActivate(Sender: TObject);
begin
//  RefreshAll(Sender);
end;

//=================================================================

end.
