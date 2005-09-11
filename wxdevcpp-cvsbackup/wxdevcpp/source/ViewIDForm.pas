unit ViewIDForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls,wxUtils, ComCtrls, XPMenu, devcfg;

type
  TViewControlIDsForm = class(TForm)
    btClose: TBitBtn;
    XPMenu: TXPMenu;
    GroupBox1: TGroupBox;
    ControlListBox: TListView;
    procedure FormCreate(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FMainControl:TWinControl;
  public
    { Public declarations }
    procedure SetMainControl(winCtrl:TWinControl);
    procedure PopulateControlList;
  end;

var
  ViewControlIDsForm: TViewControlIDsForm;

implementation

{$R *.DFM}

procedure TViewControlIDsForm.SetMainControl(winCtrl:TWinControl);
begin
    FMainControl:=winCtrl;
end;

procedure TViewControlIDsForm.FormCreate(Sender: TObject);
begin
    FMainControl:=nil;
end;

procedure TViewControlIDsForm.PopulateControlList;
var
  I: Integer;
  lstitem:TListItem ;
  wxcompInterface: IWxComponentInterface;
begin
    if FMainControl = nil then
        exit;

    ControlListBox.Items.Clear;
    for I := 0 to FMainControl.ComponentCount - 1 do    // Iterate
    begin
        if FMainControl.Components[i].GetInterface(IID_IWxComponentInterface,wxcompInterface) then
        begin
            lstitem := ControlListBox.Items.Add;
            lstitem.Caption:=IntToStr(wxcompInterface.GetIDValue);
            lstitem.SubItems.Add(wxcompInterface.GetIDName);
            lstitem.SubItems.Add(FMainControl.Components[i].Name);
        end;

    end;    // for

end;

procedure TViewControlIDsForm.btCloseClick(Sender: TObject);
begin
    close;
end;

procedure TViewControlIDsForm.btRefreshClick(Sender: TObject);
begin
    if FMainControl = nil then
        exit;
    FMainControl.repaint;
end;

procedure TViewControlIDsForm.FormShow(Sender: TObject);
begin
  if devData.XPTheme then
    XPMenu.Active := true
  else
    XPMenu.Active := false;
end;

end.
