unit TreePageControl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TTreePageControl = class(TPanel)
    tv1: TTreeview;
    pgc1: TPageControl;
  private
    { Private declarations }
  protected
    { Protected declarations }
//    procedure CreateWindowHandle(const Params: TCreateParams);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published properties and events }
  end; { TOkCancelHelp }

implementation

procedure Register;
begin
  RegisterComponents('wxDevCpp', [TTreePageControl]);
end; { Register }

constructor TTreePageControl.Create(AOwner: TComponent);
{ Creates an object of type TComboPageControl, and initializes properties. }
begin
  inherited Create(AOwner);
  Self.Width := 185;
  Self.Height := 129;
  Self.BevelOuter := bvNone;
  Self.TabOrder := 0;
  Self.Align := alClient;

  Self.tv1 := TTreeView.Create(Self);
  Self.tv1.Parent := Self;
  Self.tv1.Align := alLeft;
  Self.tv1.Width := 150;

  Self.pgc1 := TPageControl.Create(AOwner);
  Self.pgc1.Parent := Self;
  Self.pgc1.Align := alClient;

end; { Create }

destructor TTreePageControl.Destroy;
begin
  inherited Destroy;
end;

initialization
  RegisterClass(TTreeView);
  RegisterClass(TPageControl);

end.

