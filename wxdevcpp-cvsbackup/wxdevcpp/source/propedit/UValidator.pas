unit UValidator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, xprocs;

type
  TwxValidator = class(TForm)
    OK: TBitBtn;
    Cancel: TBitBtn;
    ValidatorString: TEdit;
    ValidatorType: TComboBox;
    ValidatorVariable: TEdit;
    FilterStyle: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure ValidatorTypeChange(Sender: TObject);
    procedure OnChange(Sender: TObject);
    procedure VariableChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetValidatorString: string;
    procedure SetValidatorString(strValue: string);

  end;

var
  wxValidator: TwxValidator;

implementation

{$R *.dfm}

function TwxValidator.GetValidatorString: string;
begin
  Result := '' + self.ValidatorString.Text;
end;

procedure TwxValidator.SetValidatorString(strValue: string);
begin
  self.ValidatorString.Text := strValue;
end;

procedure TwxValidator.ValidatorTypeChange(Sender: TObject);
Var
    strVarValue:String;
begin
    if Trim(ValidatorVariable.Text) = '' then
        strVarValue := 'NULL'
    else
        strVarValue := Trim(ValidatorVariable.Text);

  if strEqual(ValidatorType.Items[ValidatorType.ItemIndex], 'wxTextValidator') then
  begin
    ValidatorString.ReadOnly:=true;
    FilterStyle.Enabled := True;
    SetValidatorString('wxTextValidator(' + FilterStyle.Items[FilterStyle.ItemIndex] + ', ' + strVarValue + ')')
  end
  else begin
    ValidatorString.ReadOnly:=false;
    FilterStyle.Enabled := False;
    SetValidatorString('wxTextValidator(' + strVarValue + ')');
  end;

end;

procedure TwxValidator.OnChange(Sender: TObject);
Var
    strVarValue:String;
begin
    if Trim(ValidatorVariable.Text) = '' then
        strVarValue := 'NULL'
    else
        strVarValue := Trim(ValidatorVariable.Text);
    SetValidatorString('wxTextValidator(' + FilterStyle.Items[FilterStyle.ItemIndex] + ', ' +
    strVarValue + ')')
end;

procedure TwxValidator.VariableChange(Sender: TObject);
Var
    strVarValue:String;
begin
    if Trim(ValidatorVariable.Text) = '' then
        strVarValue := 'NULL'
    else
        strVarValue := Trim(ValidatorVariable.Text);

  if strEqual(ValidatorType.Items[ValidatorType.ItemIndex], 'wxTextValidator') then
  begin
    FilterStyle.Enabled := True;
    SetValidatorString('wxTextValidator(' +
      FilterStyle.Items[FilterStyle.ItemIndex] + ', ' +
      strVarValue + ')')

  end
  else begin
    FilterStyle.Enabled := False;
    SetValidatorString('wxTextValidator(' + strVarValue + ')');
  end;
end;

end.
