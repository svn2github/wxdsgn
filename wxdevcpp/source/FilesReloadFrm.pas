unit FilesReloadFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, XPMenu, devMonitorTypes, ComCtrls, ExtCtrls;

type
  TFilesReloadFrm = class(TForm)
    lblTitle: TLabel;
    btnOK: TButton;
    btnClose: TButton;
    XPMenu: TXPMenu;
    ctlFiles: TPageControl;
    tabModified: TTabSheet;
    tabDeleted: TTabSheet;
    lbModified: TCheckListBox;
    lblModified: TLabel;
    lbDeleted: TListBox;
    pnlModifiedSelectAll: TPanel;
    chkSelectAll: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbModifiedClickCheck(Sender: TObject);
    procedure chkSelectAllClick(Sender: TObject);
  private
    { Private declarations }
    ReloadFilenames: TList;
    CheckedItems: Integer;

    procedure SetFilenames(Files: TList);
  public
    { Public declarations }
    property Files: TList read ReloadFilenames write SetFilenames;
  end;

  PReloadFile = ^TReloadFile;
  TReloadFile = packed record
    FileName: string;
    ChangeType: TdevMonitorChangeType;
  end;
var
  FilesReloadForm: TFilesReloadFrm;

implementation
uses
  devcfg;
{$R *.dfm}

procedure TFilesReloadFrm.FormCreate(Sender: TObject);
begin
  XPMenu.Active := devData.XPTheme;
  ReloadFilenames := TList.Create;
  DesktopFont := True;
  CheckedItems := 0;
end;

procedure TFilesReloadFrm.FormDestroy(Sender: TObject);
begin
  ReloadFilenames.Free;
end;

procedure TFilesReloadFrm.SetFilenames(Files: TList);
var
  I, Idx: Integer;
begin
  ReloadFilenames.Assign(Files);
  for I := 0 to ReloadFilenames.Count - 1 do
    with PReloadFile(Files[I])^ do
      if ChangeType = mctDeleted then
      begin
        Idx := lbDeleted.Items.IndexOf(FileName);
        if Idx = -1 then
          lbDeleted.Items.Add(FileName);
      end
      else
      begin
        Idx := lbModified.Items.IndexOf(FileName);
        if Idx = -1 then
        begin
          Inc(CheckedItems);
          lbModified.Items.Add(FileName);
          lbModified.Checked[lbModified.Count - 1] := True;
        end;
      end;

  if CheckedItems = lbModified.Count then
    chkSelectAll.State := cbChecked
  else if CheckedItems = 0 then
    chkSelectAll.State := cbUnchecked
  else
    chkSelectAll.State := cbGrayed;
end;

procedure TFilesReloadFrm.lbModifiedClickCheck(Sender: TObject);
var
  I: Integer;
begin
  CheckedItems := 0;
  for I := 0 to lbModified.Count - 1 do
    if lbModified.Checked[I] then
      Inc(CheckedItems);

  if CheckedItems = lbModified.Count then
    chkSelectAll.State := cbChecked
  else if CheckedItems = 0 then
    chkSelectAll.State := cbUnchecked
  else
    chkSelectAll.State := cbGrayed;
end;

procedure TFilesReloadFrm.chkSelectAllClick(Sender: TObject);
var
  I: Integer;
begin
  if chkSelectAll.State = cbChecked then
    for I := 0 to lbModified.Count - 1 do
      lbModified.Checked[I] := True
  else if chkSelectAll.State = cbUnchecked then
    for I := 0 to lbModified.Count - 1 do
      lbModified.Checked[I] := False;
end;

end.
