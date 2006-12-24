unit UStrings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, XPMenu;

type
  TStringsForm = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnHelp: TBitBtn;
    grpMemo: TGroupBox;
    Memo: TMemo;
    XPMenu: TXPMenu;

    procedure MemoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OnContentsChanged: TNotifyEvent;
  end;

var
  StringsForm: TStringsForm;

implementation
uses
  devCfg;

{$R *.DFM}

procedure TStringsForm.MemoChange(Sender: TObject);
var
  lbl: string;
begin
    if Memo.Lines.Count = 1 then
        lbl := ' Line'
    else
        lbl := ' Lines';
    
    grpMemo.Caption := IntToStr(Memo.Lines.Count) + lbl;

    //Broadcast the event
    if Assigned(OnContentsChanged) then
        OnContentsChanged(Sender);
end;

procedure TStringsForm.FormCreate(Sender: TObject);
begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme
end;

end.
