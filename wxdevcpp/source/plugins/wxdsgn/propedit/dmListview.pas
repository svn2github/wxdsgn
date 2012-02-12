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

Unit dmListview;

Interface

Uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, ComCtrls, Buttons, ExtCtrls, XPMenu;

Type
    TListviewForm = Class(TForm)
        GroupBox1: TGroupBox;
        GroupBox2: TGroupBox;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        txtCaption: TEdit;
        txtWidth: TEdit;
        cbAlign: TComboBox;
        btMoveDown: TButton;
        btMoveUp: TButton;
        btDelete: TButton;
        btAdd: TButton;
        lbxColumnNames: TListBox;
        GroupBox3: TGroupBox;
        LstViewObj: TListView;
        XPMenu: TXPMenu;
        btnOK: TBitBtn;
        btnCancel: TBitBtn;
        btUpdate: TButton;
        Procedure btAddClick(Sender: TObject);
        Procedure btDeleteClick(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure lbxColumnNamesClick(Sender: TObject);
        Procedure btMoveUpClick(Sender: TObject);
        Procedure btMoveDownClick(Sender: TObject);
        Procedure btUpdateClick(Sender: TObject);
    Private
    { Private declarations }
        lastidx: Integer;

    Public
    { Public declarations }
        lstColumns: TListColumns;
        Procedure fillListInfo;
    End;

Var
    ListviewForm: TListviewForm;

Implementation

Uses
    wxdesigner;

{$R *.DFM}

Procedure TListviewForm.FormCreate(Sender: TObject);
Begin
    DesktopFont := True;
    XPMenu.Active := wx_designer.XPTheme;
    cbAlign.ItemIndex := 0;
    lastIdx := -1;
End;

Procedure TListviewForm.fillListInfo;
Var
    I: Integer;
Begin
    lbxColumnNames.Items.BeginUpdate;
    lbxColumnNames.Items.Clear;
    For I := 0 To LstViewObj.Columns.Count - 1 Do // Iterate
    Begin
        lbxColumnNames.Items.Add(LstViewObj.Columns[i].Caption);
    End; // for
    lbxColumnNames.Items.EndUpdate;
End;

Procedure TListviewForm.btAddClick(Sender: TObject);
Var
    lstColumn: TListColumn;
Begin
    lstColumn := LstViewObj.Columns.Add;
    lstColumn.Width := StrToInt(txtWidth.Text);
    lstColumn.Caption := txtCaption.Text;
    lstColumn.ImageIndex := -1;
    Case cbAlign.ItemIndex Of
        -1, 0:
            lstColumn.Alignment := taLeftJustify;
        1:
            lstColumn.Alignment := taCenter;
        2:
            lstColumn.Alignment := taRightJustify;
    End; // case
    fillListInfo;
End;

Procedure TListviewForm.btDeleteClick(Sender: TObject);
Var
    intColPos: Integer;
Begin
    intColPos := lbxColumnNames.ItemIndex;
    If intColPos = -1 Then
        Exit;

    lbxColumnNames.DeleteSelected;
    LstViewObj.Columns.Delete(intColPos);

    If lbxColumnNames.ItemIndex > lbxColumnNames.Items.Count Then
        lbxColumnNames.ItemIndex := 0
    Else
        lbxColumnNames.ItemIndex := -1;
    lbxColumnNamesClick(lbxColumnNames);
End;

Procedure TListviewForm.lbxColumnNamesClick(Sender: TObject);
Begin
  //Should we enable the buttons?
    btDelete.Enabled := lbxColumnNames.ItemIndex <> -1;
    btMoveUp.Enabled := lbxColumnNames.ItemIndex > 0;
    btMoveDown.Enabled := (lbxColumnNames.ItemIndex <> -1) And
        (lbxColumnNames.ItemIndex <> lbxColumnNames.Count - 1);

    btUpdate.Enabled := lbxColumnNames.ItemIndex <> -1;

    If lbxColumnNames.ItemIndex = -1 Then
    Begin
        lastidx := -1;
        Exit;
    End;

  //Save the old panel
    If lastIdx <> -1 Then
    Begin
        lbxColumnNames.Items[lastIdx] := txtCaption.Text;
        LstViewObj.Columns[lastIdx].Caption := txtCaption.Text;
        LstViewObj.Columns[lastIdx].Width := StrToInt(txtWidth.Text);
        Case cbAlign.ItemIndex Of
            0:
                LstViewObj.Columns[lbxColumnNames.ItemIndex].Alignment := taLeftJustify;
            1:
                LstViewObj.Columns[lbxColumnNames.ItemIndex].Alignment := taCenter;
            2:
                LstViewObj.Columns[lbxColumnNames.ItemIndex].Alignment := taRightJustify;
        End;
    End;

    lastIdx := lbxColumnNames.ItemIndex;
    txtCaption.Text := LstViewObj.Columns[lbxColumnNames.ItemIndex].Caption;
    txtWidth.Text := IntToStr(LstViewObj.Columns[lbxColumnNames.ItemIndex].Width);
    Case LstViewObj.Columns[lbxColumnNames.ItemIndex].Alignment Of //
        taLeftJustify:
            cbAlign.ItemIndex := 0;
        taCenter:
            cbAlign.ItemIndex := 1;
        taRightJustify:
            cbAlign.ItemIndex := 2;
    End; // case

End;

Procedure TListviewForm.btMoveUpClick(Sender: TObject);
Var
    idx: Integer;
Begin
    idx := lbxColumnNames.ItemIndex;
    If idx = -1 Then
        Exit;

  //Perform a swap
    LstViewObj.Columns[idx].Index := idx - 1;

  //Set the new listbox selection
    lbxColumnNames.Items.Move(lastIdx, lastIdx - 1);
    lbxColumnNames.ItemIndex := lastIdx - 1;
    lastIdx := lastIdx - 1;

  //Lastly, do the button enabling
    btDelete.Enabled := lastIdx <> -1;
    btMoveUp.Enabled := lastIdx > 0;
    btMoveDown.Enabled := lastIdx < lbxColumnNames.Count - 1;
End;

Procedure TListviewForm.btMoveDownClick(Sender: TObject);
Var
    idx: Integer;
Begin
    idx := lbxColumnNames.ItemIndex;
    If idx = -1 Then
        Exit;

  //Perform a swap
    LstViewObj.Columns[idx].Index := idx + 1;

  //set the new listbox selection
    lbxColumnNames.Items.Move(lastIdx, lastIdx + 1);
    lbxColumnNames.ItemIndex := lastIdx + 1;
    lastIdx := lastIdx + 1;

  //Lastly, do the button enabling
    btDelete.Enabled := lastIdx <> -1;
    btMoveUp.Enabled := lastIdx > 0;
    btMoveDown.Enabled := lastIdx < lbxColumnNames.Count - 1;
End;

Procedure TListviewForm.btUpdateClick(Sender: TObject);
Var
    idx: Integer;
Begin
    idx := lbxColumnNames.ItemIndex;
    If idx = -1 Then
        Exit;

    If idx <> -1 Then
    Begin
        LstViewObj.Columns[idx].Caption := txtCaption.Text;
        LstViewObj.Columns[idx].Width := StrToInt(txtWidth.Text);
        Case cbAlign.ItemIndex Of
            0:
                LstViewObj.Columns[idx].Alignment := taLeftJustify;
            1:
                LstViewObj.Columns[idx].Alignment := taCenter;
            2:
                LstViewObj.Columns[idx].Alignment := taRightJustify;
        End;
    End;

End;

End.
