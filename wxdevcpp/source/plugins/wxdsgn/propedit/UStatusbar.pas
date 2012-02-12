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
// $Id

Unit UStatusbar;

Interface

Uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, ComCtrls, Buttons, ExtCtrls, XPMenu;

Type
    TStatusBarForm = Class(TForm)
        GroupBox1: TGroupBox;
        GroupBox2: TGroupBox;
        Label2: TLabel;
        Label4: TLabel;
        txtCaption: TEdit;
        txtWidth: TEdit;
        btMoveDown: TButton;
        btMoveUp: TButton;
        btDelete: TButton;
        btAdd: TButton;
        lbxColumnNames: TListBox;
        StatusBarObj: TStatusBar;
        XPMenu: TXPMenu;
        btnOK: TBitBtn;
        btnCancel: TBitBtn;
        Procedure btAddClick(Sender: TObject);
        Procedure btDeleteClick(Sender: TObject);
        Procedure lbxColumnNamesClick(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure btMoveUpClick(Sender: TObject);
        Procedure btMoveDownClick(Sender: TObject);
    Private
    { Private declarations }
        lastIdx: Integer;

    Public
    { Public declarations }
        lstColumns: TListColumns;
        Procedure fillListInfo;
    End;

Var
    StatusBarForm: TStatusBarForm;

Implementation
{$R *.DFM}
{uses
  devCfg;} // EAB TODO: Fix this

Procedure TStatusBarForm.FormCreate(Sender: TObject);
Begin
    DesktopFont := True;
  //XPMenu.Active := devData.XPTheme;
    lastIdx := -1;
End;

Procedure TStatusBarForm.fillListInfo;
Var
    I: Integer;
Begin
    lbxColumnNames.Items.BeginUpdate;
    lbxColumnNames.Items.Clear;
    For I := 0 To StatusBarObj.Panels.Count - 1 Do // Iterate
        lbxColumnNames.Items.Add(StatusBarObj.Panels[i].Text); // for
    lbxColumnNames.Items.EndUpdate;
End;

Procedure TStatusBarForm.btAddClick(Sender: TObject);
Var
    lstColumn: TStatusPanel;
Begin
  //update the status bar
    lstColumn := StatusBarObj.Panels.Add;
    lstColumn.Text := txtCaption.Text;
    lstColumn.Width := StrToInt(txtWidth.Text);

  //update the listbox
    lbxColumnNames.Items.Add(txtCaption.Text);
    lbxColumnNames.ItemIndex := lbxColumnNames.Count - 1;
    lastIdx := lbxColumnNames.ItemIndex;
End;

Procedure TStatusBarForm.btDeleteClick(Sender: TObject);
Var
    intColPos: Integer;
Begin
    intColPos := lbxColumnNames.ItemIndex;
    If intColPos = -1 Then
        Exit;

    lbxColumnNames.DeleteSelected;
    StatusBarObj.Panels.Delete(intColPos);

    If lbxColumnNames.ItemIndex > lbxColumnNames.Items.Count Then
        lbxColumnNames.ItemIndex := 0
    Else
        lbxColumnNames.ItemIndex := -1;
    lbxColumnNamesClick(lbxColumnNames);
End;

Procedure TStatusBarForm.lbxColumnNamesClick(Sender: TObject);
Begin
  //Should we enable the buttons?
    btDelete.Enabled := lbxColumnNames.ItemIndex <> -1;
    btMoveUp.Enabled := lbxColumnNames.ItemIndex > 0;
    btMoveDown.Enabled := (lbxColumnNames.ItemIndex <> -1) And
        (lbxColumnNames.ItemIndex <> lbxColumnNames.Count - 1);

    If lbxColumnNames.ItemIndex = -1 Then
    Begin
        lastIdx := -1;
        Exit;
    End;

  //Save the old panel
    If lastIdx <> -1 Then
    Begin
        lbxColumnNames.Items[lastIdx] := txtCaption.Text;
        StatusBarObj.Panels[lastIdx].Text := txtCaption.Text;
        StatusBarObj.Panels[lastIdx].Width := StrToInt(txtWidth.Text);
    End;

  //Set the new strings
    lastIdx := lbxColumnNames.ItemIndex;
    txtCaption.Text := StatusBarObj.Panels[lbxColumnNames.ItemIndex].Text;
    txtWidth.Text := IntToStr(StatusBarObj.Panels[lbxColumnNames.ItemIndex].Width);
End;

Procedure TStatusBarForm.btMoveUpClick(Sender: TObject);
Var
    tmpString: String;
    tmpWidth: Integer;
Begin
  //Get the old panel
    tmpString := StatusBarObj.Panels.Items[lastIdx - 1].Text;
    tmpWidth := StatusBarObj.Panels.Items[lastIdx - 1].Width;

  //Perform a swap
    StatusBarObj.Panels.Items[lastIdx - 1] := StatusBarObj.Panels.Items[lastIdx];

  //Then set the current panel as the backed up on
    StatusBarObj.Panels.Items[lastIdx].Text := tmpString;
    StatusBarObj.Panels.Items[lastIdx].Width := tmpWidth;

  //set the new listbox selection
    lbxColumnNames.Items.Move(lastIdx, lastIdx - 1);
    lbxColumnNames.ItemIndex := lastIdx - 1;
    lastIdx := lastIdx - 1;

  //Lastly, do the button enabling
    btDelete.Enabled := lastIdx <> -1;
    btMoveUp.Enabled := lastIdx > 0;
    btMoveDown.Enabled := lastIdx < lbxColumnNames.Count - 1;
End;

Procedure TStatusBarForm.btMoveDownClick(Sender: TObject);
Var
    tmpString: String;
    tmpWidth: Integer;
Begin
  //Get the old panel
    tmpString := StatusBarObj.Panels.Items[lastIdx + 1].Text;
    tmpWidth := StatusBarObj.Panels.Items[lastIdx + 1].Width;

  //Perform a swap
    StatusBarObj.Panels.Items[lastIdx + 1] := StatusBarObj.Panels.Items[lastIdx];

  //Then set the current panel as the backed up on
    StatusBarObj.Panels.Items[lastIdx].Text := tmpString;
    StatusBarObj.Panels.Items[lastIdx].Width := tmpWidth;

  //set the new listbox selection
    lbxColumnNames.Items.Move(lastIdx, lastIdx + 1);
    lbxColumnNames.ItemIndex := lastIdx + 1;
    lastIdx := lastIdx + 1;

  //Lastly, do the button enabling
    btDelete.Enabled := lastIdx <> -1;
    btMoveUp.Enabled := lastIdx > 0;
    btMoveDown.Enabled := lastIdx < lbxColumnNames.Count - 1;
End;

End.
