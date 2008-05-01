unit ToolbarPageControl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TToolbarPageControl = class(TPanel)
    tb1: TToolBar;
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
  RegisterComponents('wxDevCpp', [TToolbarPageControl]);
end; { Register }

constructor TToolbarPageControl.Create(AOwner: TComponent);
{ Creates an object of type TComboPageControl, and initializes properties. }
begin
  inherited Create(AOwner);
  Self.Width := 185;
  Self.Height := 129;
  Self.BevelOuter := bvNone;
  Self.TabOrder := 0;
  Self.Align := alClient;

  Self.tb1 := TToolbar.Create(Self);
  Self.tb1.Parent := Self;

  Self.pgc1 := TPageControl.Create(AOwner);
  Self.pgc1.Parent := Self;
  Self.pgc1.Align := alClient;

end; { Create }

destructor TToolbarPageControl.Destroy;
begin
  inherited Destroy;
end;

initialization
  RegisterClass(TListView);
  RegisterClass(TPageControl);

end.

