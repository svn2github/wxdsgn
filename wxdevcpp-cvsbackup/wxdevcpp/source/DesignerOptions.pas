// $Id$


unit DesignerOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, INIFiles, devCfg, XPMenu, ExtCtrls,
  version, editor, utils, wxutils;

type
  TDesignerForm = class(TForm)
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    btnHelp: TBitBtn;
    notebook: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    lbGridXStep: TLabel;
    lbGridYStep: TLabel;
    cbGridVisible: TCheckBox;
    cbSnapToGrid: TCheckBox;
    lbGridXStepUpDown: TUpDown;
    lbGridYStepUpDown: TUpDown;
    GroupBox3: TGroupBox;
    cbControlHints: TCheckBox;
    cbSizeHints: TCheckBox;
    cbMoveHints: TCheckBox;
    cbInsertHints: TCheckBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    XPMenu: TXPMenu;
    TabSheet2: TTabSheet;
    codegen: TGroupBox;
    cbGenerateXRC: TCheckBox;
    Label1: TLabel;
    cbStringFormat: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure lbGridXStepUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure lbGridYStepUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure FormShow(Sender: TObject);
    procedure cbStringFormatChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DesignerForm: TDesignerForm;

implementation

{$R *.dfm}

uses main, ELDsgnr, Designerfrm;

procedure TDesignerForm.FormCreate(Sender: TObject);
begin
  if devData.XPTheme then
    XPMenu.Active := True
  else
    XPMenu.Active := False;
  cbGridVisible.Checked := MainForm.ELDesigner1.Grid.Visible;
  lbGridXStep.Caption := IntToStr(MainForm.ELDesigner1.Grid.XStep);
  lbGridXStepUpDown.Position := MainForm.ELDesigner1.Grid.XStep;

  lbGridYStep.Caption   := IntToStr(MainForm.ELDesigner1.Grid.YStep);
  lbGridYStepUpDown.Position := MainForm.ELDesigner1.Grid.YStep;
  cbSnapToGrid.Checked  := MainForm.ELDesigner1.SnapToGrid;
  cbGenerateXRC.Checked := MainForm.ELDesigner1.GenerateXRC;
  cbStringFormat.Text := StringFormat;

  cbControlHints.Checked := htControl in MainForm.ELDesigner1.ShowingHints;
  cbSizeHints.Checked    := htSize in MainForm.ELDesigner1.ShowingHints;
  cbMoveHints.Checked    := htMove in MainForm.ELDesigner1.ShowingHints;
  cbInsertHints.Checked  := htInsert in MainForm.ELDesigner1.ShowingHints;
end;

procedure TDesignerForm.btnOkClick(Sender: TObject);
var
  ini:      TiniFile;
  node:     TTreeNode;
  FileName: string;
  strLstXRCCode: TStringList;

begin
  MainForm.ELDesigner1.Grid.Visible := cbGridVisible.Checked;
  MainForm.ELDesigner1.Grid.XStep   := lbGridXStepUpDown.Position;

  MainForm.ELDesigner1.Grid.YStep := lbGridYStepUpDown.Position;
  MainForm.ELDesigner1.SnapToGrid := cbSnapToGrid.Checked;

  if (MainForm.ELDesigner1.GenerateXRC = False) and (cbGenerateXRC.Checked) then
  begin
    FileName := ChangeFileExt(MainForm.GetCurrentFileName, XRC_EXT);
    MainForm.ELDesigner1.GenerateXRC := cbGenerateXRC.Checked;

    //create the file
    if not MainForm.isFileOpenedinEditor(FileName) then
    begin
      strLstXRCCode := CreateBlankXRC;
      SaveStringToFile(strLstXRCCode.Text, FileName);
      strLstXRCCode.Destroy;
    end;

    //then add the unit
    if (MainForm.fProject <> nil) and (not MainForm.fProject.FileAlreadyExists(FileName)) then
    begin
      node := Mainform.fProject.Node;
      MainForm.fProject.AddUnit(FileName, node, False);
    end
  end
  else
  begin
    MainForm.ELDesigner1.GenerateXRC := cbGenerateXRC.Checked;
    if (MainForm.fProject <> nil) then
      MainForm.fProject.CloseUnit(MainForm.fProject.GetUnitFromString(ExtractFileName(FileName)));
  end;

  if cbControlHints.Checked then
    MainForm.ELDesigner1.ShowingHints :=
      MainForm.ELDesigner1.ShowingHints + [htControl];
  if cbSizeHints.Checked then
    MainForm.ELDesigner1.ShowingHints := [htSize] + MainForm.ELDesigner1.ShowingHints;
  if cbMoveHints.Checked then
    MainForm.ELDesigner1.ShowingHints := [htMove] + MainForm.ELDesigner1.ShowingHints;
  if cbInsertHints.Checked then
    MainForm.ELDesigner1.ShowingHints :=
      [htInsert] + MainForm.ELDesigner1.ShowingHints;

  ini := TiniFile.Create(devDirs.Config + 'devcpp.ini');
  try
    ini.WriteBool('wxWidgets', 'cbGridVisible', cbGridVisible.Checked);
    ini.WriteBool('wxWidgets', 'cbGenerateXRC', cbGenerateXRC.Checked);
    ini.WriteInteger('wxWidgets', 'lbGridXStepUpDown', lbGridXStepUpDown.Position);
    ini.WriteInteger('wxWidgets', 'lbGridYStepUpDown', lbGridYStepUpDown.Position);
    ini.WriteBool('wxWidgets', 'cbSnapToGrid', cbSnapToGrid.Checked);
    ini.WriteBool('wxWidgets', 'cbControlHints', cbControlHints.Checked);
    ini.WriteBool('wxWidgets', 'cbSizeHints', cbSizeHints.Checked);
    ini.WriteBool('wxWidgets', 'cbMoveHints', cbMoveHints.Checked);
    ini.WriteBool('wxWidgets', 'cbInsertHints', cbInsertHints.Checked);
    ini.WriteString('wxWidgets', 'cbStringFormat', cbStringFormat.Text);
  except
    ini.Destroy;
  end;

end;

procedure TDesignerForm.lbGridXStepUpDownClick(Sender: TObject; Button: TUDBtnType);
begin
  lbGridXStep.Caption := IntToStr(lbGridXStepUpDown.position);
end;

procedure TDesignerForm.lbGridYStepUpDownClick(Sender: TObject; Button: TUDBtnType);
begin
  lbGridYStep.Caption := IntToStr(lbGridYStepUpDown.position);
end;

procedure TDesignerForm.FormShow(Sender: TObject);
begin
  if devData.XPTheme then
    XPMenu.Active := True
  else
    XPMenu.Active := False;
end;

procedure TDesignerForm.cbStringFormatChange(Sender: TObject);
begin

 StringFormat := cbStringFormat.Text;
 
end;

end.
