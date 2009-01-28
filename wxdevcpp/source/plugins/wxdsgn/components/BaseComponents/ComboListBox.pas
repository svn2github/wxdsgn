{  $Id$ }
unit ComboListBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, ComCtrls, StdCtrls, JvExStdCtrls, JvCombobox,
  ExtCtrls, wxRichTextStyleListBox;

type
  TComboListBox = class(TPanel)
    cbb1: TJvComboBox;
    ltb1: TwxRichTextStyleListBox;
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
  RegisterComponents('wxDevCpp', [TComboListBox]);
end; { Register }

constructor TComboListBox.Create(AOwner: TComponent);
{ Creates an object of type TComboListBox, and initializes properties. }
begin
  inherited Create(AOwner);
  Self.Width := 185;
  Self.Height := 129;
  Self.BevelOuter := bvNone;
  Self.TabOrder := 0;
  Self.Align := alNone;

  Self.ltb1 := TwxRichTextStyleListBox.Create(Self);
  Self.ltb1.Parent := Self;
  Self.ltb1.Align := alClient;

  Self.cbb1 := TJvComboBox.Create(Self);
  Self.cbb1.Parent := Self;
  Self.cbb1.Align := alBottom;
  Self.cbb1.Width := 150;

end; { Create }

destructor TComboListBox.Destroy;
begin
  inherited Destroy;
end;

{mn
procedure TComboListBox.CreateWindowHandle(const Params: TCreateParams);
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
  RegisterClass(TwxRichTextStyleListBox);

end.

