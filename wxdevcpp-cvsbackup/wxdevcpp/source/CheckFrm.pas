unit CheckFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Menus,
  Forms, Dialogs, StdCtrls, Extctrls, ComCtrls, Buttons;

type

  TCheckForm = class(TForm)
    grpTask: TGroupBox;
    grpResults: TGroupBox;
    lblRelVer: TLabel;
    lblNeed: TLabel;
    L: TLabel;
    lblDesc: TLabel;
    Memo: TMemo;
    Release: TLabel;
    Need_version: TLabel;
    lblSites: TLabel;
    SiteList: TListBox;
    btnOk: TBitBtn;
    procedure btnOkClick(Sender: TObject);
    procedure SiteListDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    FirstStart: Boolean;
    procedure LoadText;
  end;

var
 CheckForm: TCheckForm;

implementation

{$R *.DFM}

uses
  Registry, ShellApi, CheckForUpdate, DevConnect, version, MultiLangSupport;

procedure TCheckForm.btnOkClick(Sender: TObject);
begin
  Close;
end;

// ** should add updated list to downloaded update file
procedure TCheckForm.SiteListDblClick(Sender: TObject);
var i : integer;
begin
  for i := 0 to SiteList.Items.Count-1 do
      if SiteList.Selected[i] then
         ShellExecute(GetDesktopWindow, 'open',
                      pChar(SiteList.Items[i]),
                      nil, nil, SW_SHOWNORMAL);
end;

procedure TCheckForm.FormCreate(Sender: TObject);
begin
  FirstStart := True;
  LoadText;
end;

procedure TCheckForm.FormActivate(Sender: TObject);
var
  Check: TCheckForUpdate;
  Connect : TDevConnect;
begin
  if not FirstStart then Exit;
  FirstStart := False;
  Check := TCheckForUpdate.Create;
  Connect := TDevConnect.Create(true);
  Connect.Check := Check;
  Connect.L := L;
  Connect.FreeOnTerminate := True;
  Connect.Resume;
end;

procedure TCheckForm.LoadText;
begin
  Caption:=            Lang[ID_UCF];
  grpTask.Caption:=    '  '+Lang[ID_UCF_GRP_TASK]+'  ';
  grpResults.Caption:= '  '+Lang[ID_UCF_GRP_RESULTS]+'  ';
  lblRelVer.Caption:=  Lang[ID_UCF_RELEASE];
  lblNeed.Caption:=    Lang[ID_UCF_NEED];
  lblDesc.Caption:=    Lang[ID_UCF_DESC];
  lblSites.Caption:=   Lang[ID_UCF_SITES];

  btnOk.Caption:=      Lang[ID_BTN_OK];
end;

end.
