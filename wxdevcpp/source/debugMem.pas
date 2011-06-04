unit debugMem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, ValEdit, StdCtrls, ExtCtrls, ComCtrls;


type
  TDebugMemFrm = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MemoryRefreshButton: TButton;
    MemoryAddressEdit: TEdit;
    MemoryCountEdit: TEdit;
    MemoryRichEdit: TRichEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MemoryRefreshButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    procedure RefreshMemory;

  public
    { Public declarations }
  end;

var
  DebugMemFrm: TDebugMemFrm;

implementation

uses main;

{$R *.dfm}

//=================================================================

procedure TDebugMemFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
//
//  Uncheck the exerciser menu
//
//  (This must be suitably altered to interface with the IDE)
//
begin
    MainForm.ViewMemory1.Checked := false;
end;

//=================================================================

procedure TDebugMemFrm.MemoryRefreshButtonClick(Sender: TObject);
begin
  RefreshMemory;
end;

//=================================================================

procedure TDebugMemFrm.RefreshMemory;
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

procedure TDebugMemFrm.FormShow(Sender: TObject);
begin
  RefreshMemory;
end;

//=================================================================

procedure TDebugMemFrm.FormCreate(Sender: TObject);
begin

if Assigned(DebugMemFrm) then
begin
  DebugMemFrm.Visible := true;
  DebugMemFrm.BringToFront;

  RefreshMemory;
end;

end;

//=================================================================

end.
