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

Unit UColorEdit;

Interface

Uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, Buttons, ExtCtrls, wxutils, JvExButtons, JvButtons,
    XPMenu;

Type
    TColorEdit = Class(TForm)
        btnOK: TBitBtn;
        btnCancel: TBitBtn;
        colorDlg: TColorDialog;
        XPMenu: TXPMenu;
        rbDefaultColor: TRadioButton;
        rbStandardColor: TRadioButton;
        rbSystemColor: TRadioButton;
        rbCustomColor: TRadioButton;
        txtRed: TEdit;
        Label1: TLabel;
        Label2: TLabel;
        txtGreen: TEdit;
        Label3: TLabel;
        txtBlue: TEdit;
        btChoose: TButton;
        cbSystemColor: TComboBox;
        cbStandardColor: TComboBox;
        pnlPreview: TPanel;
        Label4: TLabel;
        Procedure btChooseClick(Sender: TObject);
        Procedure rbDefaultColorClick(Sender: TObject);
        Procedure rbStandardColorClick(Sender: TObject);
        Procedure rbSystemColorClick(Sender: TObject);
        Procedure rbCustomColorClick(Sender: TObject);
        Procedure btnOKClick(Sender: TObject);
        Procedure cbStandardColorChange(Sender: TObject);
        Procedure cbSystemColorChange(Sender: TObject);
        Procedure txtRedChange(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
    Private
    { Private declarations }
    Public
    { Public declarations }
        strColorString: String;
        Function GetColorString: String;
        Procedure SetColorString(strValue: String);

    End;

Var
    ColorEdit: TColorEdit;

Implementation

Uses
    wxdesigner;

{$R *.dfm}

Procedure TColorEdit.btChooseClick(Sender: TObject);
Var
    ColorInt: Integer;
Begin
    colorDlg.Color := RGB(StrToInt(txtRed.Text), StrToInt(txtGreen.Text), StrToInt(txtBlue.Text));
    If colorDlg.Execute = False Then
        exit;
    ColorInt := ColorToRGB(colorDlg.Color);
    txtRed.Text := IntToStr(GetRValue(ColorInt));
    txtGreen.Text := IntToStr(GetGValue(ColorInt));
    txtBlue.Text := IntToStr(GetBValue(ColorInt));

End;

Procedure TColorEdit.rbDefaultColorClick(Sender: TObject);
Begin
    cbStandardColor.enabled := Not rbDefaultColor.Checked;
    cbSystemColor.enabled := Not rbDefaultColor.Checked;
    btChoose.enabled := Not rbDefaultColor.Checked;
    pnlPreview.Color := clBtnFace;
End;

Procedure TColorEdit.rbStandardColorClick(Sender: TObject);
Begin
    cbStandardColor.enabled := rbStandardColor.Checked;
    cbSystemColor.enabled := Not rbStandardColor.Checked;
    btChoose.enabled := Not rbStandardColor.Checked;
    cbStandardColorChange(self);
End;

Procedure TColorEdit.rbSystemColorClick(Sender: TObject);
Begin
    cbStandardColor.enabled := Not rbSystemColor.Checked;
    cbSystemColor.enabled := rbSystemColor.Checked;
    btChoose.enabled := Not rbSystemColor.Checked;
    cbSystemColorChange(self);
End;

Procedure TColorEdit.rbCustomColorClick(Sender: TObject);
Begin
    cbStandardColor.enabled := Not rbCustomColor.Checked;
    cbSystemColor.enabled := Not rbCustomColor.Checked;
    btChoose.enabled := rbCustomColor.Checked;
    txtRedChange(self);
End;

Function TColorEdit.GetColorString: String;
Begin
    Result := '' + self.strColorString;
End;

Procedure TColorEdit.SetColorString(strValue: String);
Var
    strChoice, strClr: String;
    ColorInt: Integer;
Begin
    rbDefaultColor.Checked := True;
    strColorString := strValue;
    strChoice := copy(strValue, 0, 4);
    strClr := copy(strValue, 4 + 1, length(strValue));
    If AnsiSameText(strChoice, 'Def:') Then
    Begin
        rbDefaultColor.Checked := True;

    End;
    If AnsiSameText(strChoice, 'STD:') Then
    Begin
        rbStandardColor.Checked := True;
        If cbStandardColor.Items.IndexOf(strClr) <> -1 Then
        Begin
            cbStandardColor.ItemIndex := cbStandardColor.Items.IndexOf(strClr);
        End;
        cbStandardColorChange(self);

    End;

    If AnsiSameText(strChoice, 'SYS:') Then
    Begin
        rbSystemColor.Checked := True;
        If cbSystemColor.Items.IndexOf(strClr) <> -1 Then
        Begin
            cbSystemColor.ItemIndex := cbSystemColor.Items.IndexOf(strClr);
        End;
        self.cbSystemColorChange(self);
    End;

    If AnsiSameText(strChoice, 'CUS:') Then
    Begin
        rbCustomColor.Checked := True;
        strValue := trim(strValue);
        pnlPreview.Color := GetColorFromString(strValue);
        ColorInt := ColorToRGB(pnlPreview.Color);
        txtRed.Text := IntToStr(GetRValue(ColorInt));
        txtGreen.Text := IntToStr(GetGValue(ColorInt));
        txtBlue.Text := IntToStr(GetBValue(ColorInt));

    End;


End;

Procedure TColorEdit.btnOKClick(Sender: TObject);
Begin
    If rbDefaultColor.Checked Then
    Begin
        strColorString := 'DEF:';
    End;

    If rbStandardColor.Checked Then
    Begin
        strColorString := 'STD:' + cbStandardColor.Items[cbStandardColor.itemindex];
    End;

    If rbSystemColor.Checked Then
    Begin
        strColorString := 'SYS:' + cbSystemColor.Items[cbSystemColor.itemindex];
    End;
    If rbCustomColor.Checked Then
    Begin
        strColorString := 'CUS:' + txtRed.Text + ',' + txtGreen.Text + ',' + txtBlue.Text;
    End;
    close;
    ModalResult := mrOk;
End;

Procedure TColorEdit.cbStandardColorChange(Sender: TObject);
Var
    clr: TColor;
Begin
    If cbStandardColor.ItemIndex = -1 Then
        exit;
    clr := GetGeneralColorFromString(cbStandardColor.Items[cbStandardColor.ItemIndex]);
    pnlPreview.Color := clr;
End;

Procedure TColorEdit.cbSystemColorChange(Sender: TObject);
Var
    clr: TColor;
Begin
    If cbSystemColor.ItemIndex = -1 Then
        exit;
    clr := GetGeneralColorFromString(cbSystemColor.Items[cbSystemColor.ItemIndex]);
    pnlPreview.Color := clr;
End;

Procedure TColorEdit.txtRedChange(Sender: TObject);
Var
    clr: TColor;
Begin
    clr := RGB(StrToInt(txtRed.Text), StrToInt(txtGreen.Text), StrToInt(txtBlue.Text));
    pnlPreview.Color := clr;
End;

Procedure TColorEdit.FormCreate(Sender: TObject);
Begin
    DesktopFont := True;
    XPMenu.Active := wx_designer.XPTheme;
End;

End.
