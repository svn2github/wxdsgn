unit ComboPageControl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, ComCtrls, StdCtrls, JvExStdCtrls, JvCombobox,
  ExtCtrls;

type
  TComboPageControl = class(TPanel)
    cbb1: TJvComboBox;
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
  RegisterComponents('wxDevCpp', [TComboPageControl]);
end; { Register }

constructor TComboPageControl.Create(AOwner: TComponent);
{ Creates an object of type TComboPageControl, and initializes properties. }
begin
  inherited Create(AOwner);
  Self.Width := 185;
  Self.Height := 129;
  Self.BevelOuter := bvNone;
  Self.TabOrder := 0;
  Self.Align := alClient;

  Self.cbb1 := TJvComboBox.Create(Self);
  Self.cbb1.Parent := Self;
  Self.cbb1.Align := alTop;
  Self.cbb1.Width := 150;

  Self.pgc1 := TPageControl.Create(AOwner);
  Self.pgc1.Parent := Self;
  Self.pgc1.Align := alClient;

end; { Create }

destructor TComboPageControl.Destroy;
begin
  inherited Destroy;
end;

{mn
procedure TComboPageControl.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited CreateWindowHandle(Params);

  with cbb1 do
  begin
    Left := 0;
    Top := 0;
    Width := 75;
    Height := 25;
    //    ModalResult := 1;
    TabOrder := 0;
  end; // ComboControl

  with pgc1 do
  begin
    Left := 0;
    Top := 35;
    Width := 75;
    Height := 25;
    //    Cancel := True;
    //    ModalResult := 2;
    TabOrder := 1;
  end;  //PageControl

end; // CreateWindowHandle
mn}

initialization
  RegisterClass(TJvComboBox);
  RegisterClass(TPageControl);

end.

