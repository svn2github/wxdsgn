// $Id$
//

unit DesignerOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons,INIFiles,devCfg, XPMenu, ExtCtrls;

type
  TDesignerForm = class(TForm)
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    btnHelp: TBitBtn;
    PageControl1: TPageControl;
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
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure lbGridXStepUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure lbGridYStepUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DesignerForm: TDesignerForm;

implementation

{$R *.dfm}

uses main,ELDsgnr;

procedure TDesignerForm.FormCreate(Sender: TObject);
begin
    if devData.XPTheme then
        XPMenu.Active := true
    else
        XPMenu.Active := false;
    cbGridVisible.Checked:=MainForm.ELDesigner1.Grid.Visible;
    lbGridXStep.Caption := IntToStr (MainForm.ELDesigner1.Grid.XStep);
    lbGridXStepUpDown.Position:=MainForm.ELDesigner1.Grid.XStep;

    lbGridYStep.Caption := IntToStr (MainForm.ELDesigner1.Grid.YStep);
    lbGridYStepUpDown.Position:=MainForm.ELDesigner1.Grid.YStep;
    cbSnapToGrid.Checked:=MainForm.ELDesigner1.SnapToGrid;

    cbControlHints.Checked:= htControl in MainForm.ELDesigner1.ShowingHints;
    cbSizeHints.Checked:=htSize in MainForm.ELDesigner1.ShowingHints;
    cbMoveHints.Checked:=htMove in MainForm.ELDesigner1.ShowingHints;
    cbInsertHints.Checked:=htInsert in MainForm.ELDesigner1.ShowingHints;
end;

procedure TDesignerForm.btnOkClick(Sender: TObject);
var
    ini : TiniFile;
begin
    MainForm.ELDesigner1.Grid.Visible:=cbGridVisible.Checked;
    MainForm.ELDesigner1.Grid.XStep:=lbGridXStepUpDown.Position;

    MainForm.ELDesigner1.Grid.YStep:=lbGridYStepUpDown.Position;
    MainForm.ELDesigner1.SnapToGrid:=cbSnapToGrid.Checked;

    if cbControlHints.Checked then
        MainForm.ELDesigner1.ShowingHints:=MainForm.ELDesigner1.ShowingHints + [htControl];
    if cbSizeHints.Checked then
        MainForm.ELDesigner1.ShowingHints :=[htSize] + MainForm.ELDesigner1.ShowingHints;
    if cbMoveHints.Checked then
        MainForm.ELDesigner1.ShowingHints :=[htMove] + MainForm.ELDesigner1.ShowingHints;
    if cbInsertHints.Checked then
        MainForm.ELDesigner1.ShowingHints := [htInsert] + MainForm.ELDesigner1.ShowingHints;

    ini := TiniFile.Create(devDirs.Config + 'devcpp.ini');
    try
        ini.WriteBool('wxWidgets','cbGridVisible',cbGridVisible.checked);
        ini.WriteInteger('wxWidgets','lbGridXStepUpDown',lbGridXStepUpDown.Position);
        ini.WriteInteger('wxWidgets','lbGridYStepUpDown',lbGridYStepUpDown.Position);
        ini.WriteBool('wxWidgets','cbSnapToGrid',cbSnapToGrid.Checked);
        ini.WriteBool('wxWidgets','cbControlHints',cbControlHints.Checked);
        ini.WriteBool('wxWidgets','cbSizeHints',cbSizeHints.Checked);
        ini.WriteBool('wxWidgets','cbMoveHints',cbMoveHints.Checked);
        ini.WriteBool('wxWidgets','cbInsertHints',cbInsertHints.Checked);
    except
        ini.destroy;
    end;

end;

procedure TDesignerForm.lbGridXStepUpDownClick(Sender: TObject;
  Button: TUDBtnType);
begin
    lbGridXStep.Caption:=IntToStr(lbGridXStepUpDown.position);
end;

procedure TDesignerForm.lbGridYStepUpDownClick(Sender: TObject;
  Button: TUDBtnType);
begin
    lbGridYStep.Caption:=IntToStr(lbGridYStepUpDown.position);
end;

procedure TDesignerForm.FormShow(Sender: TObject);
begin
  if devData.XPTheme then
    XPMenu.Active := true
  else
    XPMenu.Active := false;
end;

end.
