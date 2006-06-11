unit UValidator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, xprocs;

type
  TwxValidator = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    Settings: TGroupBox;
    ValidatorTypeLbl: TLabel;
    ValidatorVariableLbl: TLabel;
    FilterStyleLbl: TLabel;
    ValidatorVariableOpt: TLabel;
    ValidatorType: TComboBox;
    ValidatorVariable: TEdit;
    FilterStyle: TComboBox;
    ValidatorCommand: TGroupBox;
    ValidatorString: TEdit;

    procedure ValidatorTypeChange(Sender: TObject);
    procedure OnChange(Sender: TObject);
    procedure VariableChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure GenerateCode;
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
var
  Style: string;
  Variable: string;
begin
  //Attempt to parse the string
  strValue := Trim(strValue);
  if Copy(strValue, 1, 16) = 'wxTextValidator(' then
  begin
    //OK, we have a TextValidator
    ValidatorType.ItemIndex := 1;

    //See what styles we are using
    Style := Copy(strValue, 17, Length(strValue));
    if Pos(',', Style) <> 0 then
      Style := Copy(Style, 1, Pos(',', Style) - 1)
    else
      Style := Copy(Style, 1, Length(Style) - 1);

    //Set the style
    FilterStyle.ItemIndex := FilterStyle.Items.IndexOf(Style);
    if FilterStyle.ItemIndex = -1 then
      FilterStyle.ItemIndex := 0;

    //And get the name of the validator variable
    if Pos(',', strValue) <> 0 then
    begin
      Variable := Copy(strValue, 16, Length(strValue));
      Variable := Copy(Variable, Pos(',', Variable) + 2, Length(Variable));
      Variable := Copy(Variable, 0, Pos(Variable, ')'));
      ValidatorVariable.Text := Variable;
    end;
  end
  else if strValue <> '' then
    ValidatorType.ItemIndex := 2
  else
    ValidatorType.ItemIndex := 0;

  //Set the text field
  ValidatorTypeChange(nil);
  GenerateCode;
end;

procedure TwxValidator.ValidatorTypeChange(Sender: TObject);
begin
  //Enable/disable the controls
  FilterStyle.Enabled := ValidatorType.ItemIndex = 1; //Must be a wxTextValidator
  ValidatorVariable.Enabled := ValidatorType.ItemIndex <> 0; //Must be a validator
  ValidatorString.Enabled := ValidatorType.ItemIndex <> 0; //Must be a validator
  ValidatorString.ReadOnly := ValidatorType.ItemIndex = 1; //TextValidator

  //Regenerate the code
  GenerateCode;
end;

procedure TwxValidator.OnChange(Sender: TObject);
Var
    strVarValue:String;
begin
    if Trim(ValidatorVariable.Text) = '' then
        strVarValue := 'NULL'
    else
        strVarValue := Trim(ValidatorVariable.Text);
    ValidatorString.Text := 'wxTextValidator(' + FilterStyle.Items[FilterStyle.ItemIndex] +
                            ', ' + strVarValue + ')';
end;

procedure TwxValidator.VariableChange(Sender: TObject);
begin
  GenerateCode;
end;

procedure TwxValidator.FormCreate(Sender: TObject);
begin
  ValidatorTypeChange(Sender);
end;

procedure TwxValidator.GenerateCode;
var
  VarValue: string;
begin
  //Decide what to use for the validator variable
  if Trim(ValidatorVariable.Text) = '' then
    VarValue := 'NULL'
  else
    VarValue := Trim(ValidatorVariable.Text);

  case ValidatorType.ItemIndex of
    0: ValidatorString.Text := '';
    1: ValidatorString.Text := 'wxTextValidator(' + FilterStyle.Text + ', ' + VarValue + ')';
    2: ValidatorString.Text := 'wxGenericValidator(' + VarValue + ')';
  end;
end;

end.
