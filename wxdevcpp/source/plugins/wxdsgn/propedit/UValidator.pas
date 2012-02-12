{                                                                    }
{   Copyright © 2003-2007 by Guru Kathiresan                         }
{                                                                    }
{License :                                                           }
{=========                                                           }
{The wx-devC++ Components, Form Designer, Utils classes              }
{are exclusive properties of Guru Kathiresan.                        }
{The code is available in dual Licenses:                             }
{                               1)GPL Compatible  License            }
{                               2)Commercial License                 }
{                                                                    }
{1)GPL License :                                                     }
{ Code can be used in any project as long as the project's sourcecode}
{ is published under GPL license.                                    }
{                                                                    }
{2)Commercial License:                                               }
{Use of code in this file or the one that bear this license text     }
{can be used in Non-GPL projects as long as you get the permission   }
{from the Author - Guru Kathiresan.                                  }
{Use of the Code in any non-gpl projects without the permission of   }
{the author is illegal.                                              }
{Contact gururamnath@yahoo.com for details                           }
{ ****************************************************************** }

Unit UValidator;

Interface

Uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, Buttons, ExtCtrls, XPMenu;

Type
    TwxValidator = Class(TForm)
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
        XPMenu: TXPMenu;

        Procedure ValidatorTypeChange(Sender: TObject);
        Procedure OnChange(Sender: TObject);
        Procedure VariableChange(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
    Private
    { Private declarations }
        Procedure GenerateCode;
    Public
    { Public declarations }
        Function GetValidatorString: String;
        Procedure SetValidatorString(strValue: String);

    End;

Var
    wxValidator: TwxValidator;

Implementation
{uses
  devCfg;} // EAB TODO: fix this
{$R *.dfm}

Function TwxValidator.GetValidatorString: String;
Begin
    Result := '' + self.ValidatorString.Text;
End;

Procedure TwxValidator.SetValidatorString(strValue: String);
Var
    Style: String;
    Variable: String;
Begin
  //Attempt to parse the string
    strValue := Trim(strValue);
    If Copy(strValue, 1, 16) = 'wxTextValidator(' Then
    Begin
    //OK, we have a TextValidator
        ValidatorType.ItemIndex := 1;

    //See what styles we are using
        Style := Copy(strValue, 17, Length(strValue));
        If Pos(',', Style) <> 0 Then
            Style := Copy(Style, 1, Pos(',', Style) - 1)
        Else
            Style := Copy(Style, 1, Length(Style) - 1);

    //Set the style
        FilterStyle.ItemIndex := FilterStyle.Items.IndexOf(Style);
        If FilterStyle.ItemIndex = -1 Then
            FilterStyle.ItemIndex := 0;

    //And get the name of the validator variable
        If Pos(',', strValue) <> 0 Then
        Begin
            Variable := Copy(strValue, 16, Length(strValue));
            Variable := Copy(Variable, Pos(',', Variable) + 2, Length(Variable));
            Variable := Copy(Variable, 0, Pos(Variable, ')'));
            ValidatorVariable.Text := Variable;
        End;
    End
    Else
    If strValue <> '' Then
        ValidatorType.ItemIndex := 2
    Else
        ValidatorType.ItemIndex := 0;

  //Set the text field
    ValidatorTypeChange(Nil);
    GenerateCode;
End;

Procedure TwxValidator.ValidatorTypeChange(Sender: TObject);
Begin
  //Enable/disable the controls
    FilterStyle.Enabled := ValidatorType.ItemIndex = 1; //Must be a wxTextValidator
    ValidatorVariable.Enabled := ValidatorType.ItemIndex <> 0; //Must be a validator
    ValidatorString.Enabled := ValidatorType.ItemIndex <> 0; //Must be a validator
    ValidatorString.ReadOnly := ValidatorType.ItemIndex = 1; //TextValidator

  //Regenerate the code
    GenerateCode;
End;

Procedure TwxValidator.OnChange(Sender: TObject);
Var
    strVarValue: String;
Begin
    If Trim(ValidatorVariable.Text) = '' Then
        strVarValue := 'NULL'
    Else
        strVarValue := Trim(ValidatorVariable.Text);
    ValidatorString.Text := 'wxTextValidator(' + FilterStyle.Items[FilterStyle.ItemIndex] +
        ', ' + strVarValue + ')';
End;

Procedure TwxValidator.VariableChange(Sender: TObject);
Begin
    GenerateCode;
End;

Procedure TwxValidator.FormCreate(Sender: TObject);
Begin
    ValidatorTypeChange(Sender);
    DesktopFont := True;
  //XPMenu.Active := devData.XPTheme;
End;

Procedure TwxValidator.GenerateCode;
Var
    VarValue: String;
Begin
  //Decide what to use for the validator variable
    If Trim(ValidatorVariable.Text) = '' Then
        VarValue := 'NULL'
    Else
        VarValue := Trim(ValidatorVariable.Text);

    Case ValidatorType.ItemIndex Of
        0:
            ValidatorString.Text := '';
        1:
            ValidatorString.Text := 'wxTextValidator(' + FilterStyle.Text + ', ' + VarValue + ')';
        2:
            ValidatorString.Text := 'wxGenericValidator(' + VarValue + ')';
    End;
End;

End.
