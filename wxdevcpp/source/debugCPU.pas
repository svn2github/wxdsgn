Unit debugCPU;

Interface

Uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, Grids, ValEdit, StdCtrls, ExtCtrls, ComCtrls;


Type
    TDebugCPUFrm = Class(TForm)
        Panel1: TPanel;
        Splitter1: TSplitter;
        Splitter2: TSplitter;
        Panel2: TPanel;
        Panel3: TPanel;
        Label1: TLabel;
        Label2: TLabel;
        Panel4: TPanel;
        RegisterList: TValueListEditor;
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
        Label6: TLabel;
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure DisassemblyRefreshButtonClick(Sender: TObject);
        Procedure MemoryRefreshButtonClick(Sender: TObject);
        Procedure RegistersRefreshButtonClick(Sender: TObject);
        Procedure RefreshAll(Sender: TObject);
        Procedure FormShow(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure FormActivate(Sender: TObject);

    Private
    { Private declarations }
        Procedure RefreshCPUDisassembly;
        Procedure RefreshCPUMemory;
        Procedure RefreshCPURegisters;

    Public
    { Public declarations }
    End;

Const
    NoFile: String = '<Enter here the source file to disassemble>';

    GDBDisassem: String = '-data-disassemble ';
Const CPURegList: String = '0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15';
Const CPURegCount: Integer = 15;  // The number of values above - 1


Var
    DebugCPUFrm: TDebugCPUFrm;

Implementation

Uses main;

{$R *.dfm}

//=================================================================

Procedure TDebugCPUFrm.FormClose(Sender: TObject;
    Var Action: TCloseAction);
Begin
    MainForm.ViewCPUItem.Checked := False;
End;

//=================================================================

Procedure TDebugCPUFrm.DisassemblyRefreshButtonClick(Sender: TObject);
Begin
    RefreshCPUDisassembly;
End;

//=================================================================

Procedure TDebugCPUFrm.MemoryRefreshButtonClick(Sender: TObject);
Begin
    RefreshCPUMemory;
End;

//=================================================================

Procedure TDebugCPUFrm.RegistersRefreshButtonClick(Sender: TObject);
Begin
    RefreshCPURegisters;
End;

//=================================================================

Procedure TDebugCPUFrm.RefreshAll(Sender: TObject);
Begin
    RefreshCPUDisassembly;
    RefreshCPUMemory;
    RefreshCPURegisters;
End;

//=================================================================

Procedure TDebugCPUFrm.RefreshCPUDisassembly;
Var
    cmd: String;

Begin

    If (Not (MainForm.fDebugger = Nil)) Then
    Begin
        DisassemblyRichEdit.Clear;
        If (Not ((SrcFileName.Text = NoFile) Or (SrcFileName.Text = ''))) Then
        Begin
            cmd := format('%s -f %s -l 1 -- 1', [GDBDisassem, SrcFileName.Text]);
            MainForm.fDebugger.WriteToPipe(cmd);
        End;
    End;
End;

//=================================================================

Procedure TDebugCPUFrm.RefreshCPUMemory;
Begin
    If (Not (MainForm.fDebugger = Nil)) Then
    Begin
        MemoryRichEdit.Clear;
        If (Not ((MemoryAddressEdit.Text = '')
            Or (MemoryCountEdit.Text = '')
            Or (MemoryCountEdit.Text = '0'))) Then
            MainForm.fDebugger.WriteToPipe('-data-read-memory-bytes '
                + MemoryAddressEdit.Text + ' ' + MemoryCountEdit.Text);
    End;

End;

//=================================================================

Procedure TDebugCPUFrm.RefreshCPURegisters;
Begin

    If (Not (MainForm.fDebugger = Nil)) Then
    Begin
        RegisterList.Strings.Clear;
        MainForm.fDebugger.WriteToPipe('-data-list-register-names ' + CPURegList);
    End;
End;

//=================================================================

Procedure TDebugCPUFrm.FormShow(Sender: TObject);
Begin

    SrcFileName.Text := ExtractFileName(MainForm.GetActiveEditorName);
    RefreshAll(Sender);
End;

//=================================================================

Procedure TDebugCPUFrm.FormCreate(Sender: TObject);
Begin
    DebugCPUFrm.Visible := True;
    DebugCPUFrm.BringToFront;

End;

//=================================================================

Procedure TDebugCPUFrm.FormActivate(Sender: TObject);
Begin

End;

//=================================================================

End.
