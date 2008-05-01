unit ListViewPageControl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TListViewPageControl = class(TPanel)
    lv1: TListView;
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
  RegisterComponents('wxDevCpp', [TListViewPageControl]);
end; { Register }

constructor TListViewPageControl.Create(AOwner: TComponent);
{ Creates an object of type TComboPageControl, and initializes properties. }
begin
  inherited Create(AOwner);
  Self.Width := 185;
  Self.Height := 129;
  Self.BevelOuter := bvNone;
  Self.TabOrder := 0;
  Self.Align := alClient;

  Self.lv1 := TListView.Create(Self);
  Self.lv1.Parent := Self;
  Self.lv1.Align := alLeft;
  Self.lv1.Width := 150;

  Self.pgc1 := TPageControl.Create(AOwner);
  Self.pgc1.Parent := Self;
  Self.pgc1.Align := alClient;

end; { Create }

destructor TListViewPageControl.Destroy;
begin
  inherited Destroy;
end;


initialization
  RegisterClass(TListView);
  RegisterClass(TPageControl);

end.

