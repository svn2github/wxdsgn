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

unit UStatusbar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, ExtCtrls, XPMenu;

type
  TStatusBarForm = class(TForm)
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
    procedure btAddClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure lbxColumnNamesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btMoveUpClick(Sender: TObject);
    procedure btMoveDownClick(Sender: TObject);
  private
    { Private declarations }
    lastIdx: Integer;
    
  public
    { Public declarations }
    lstColumns: TListColumns;
    procedure fillListInfo;
  end;

var
  StatusBarForm: TStatusBarForm;

implementation
{$R *.DFM}
uses
  devCfg;

procedure TStatusBarForm.FormCreate(Sender: TObject);
begin
  DesktopFont := True;
  XPMenu.Active := devData.XPTheme;
  lastIdx := -1;
end;

procedure TStatusBarForm.fillListInfo;
var
  I: integer;
begin
  lbxColumnNames.Items.BeginUpdate;
  lbxColumnNames.Items.Clear;
  for I := 0 to StatusBarObj.Panels.Count - 1 do // Iterate
    lbxColumnNames.Items.Add(StatusBarObj.Panels[i].Text); // for
  lbxColumnNames.Items.EndUpdate;
end;

procedure TStatusBarForm.btAddClick(Sender: TObject);
var
  lstColumn: TStatusPanel;
begin
  //update the status bar
  lstColumn       := StatusBarObj.Panels.Add;
  lstColumn.Text  := txtCaption.Text;
  lstColumn.Width := StrToInt(txtWidth.Text);

  //update the listbox
  lbxColumnNames.Items.Add(txtCaption.Text);
  lbxColumnNames.ItemIndex := lbxColumnNames.Count - 1;
  lastIdx := lbxColumnNames.ItemIndex;
end;

procedure TStatusBarForm.btDeleteClick(Sender: TObject);
var
  intColPos: integer;
begin
  intColPos := lbxColumnNames.ItemIndex;
  if intColPos = -1 then
    Exit;

  lbxColumnNames.DeleteSelected;
  StatusBarObj.Panels.Delete(intColPos);

  if lbxColumnNames.ItemIndex > lbxColumnNames.Items.Count then
    lbxColumnNames.ItemIndex := 0
  else
    lbxColumnNames.ItemIndex := -1;
  lbxColumnNamesClick(lbxColumnNames);
end;

procedure TStatusBarForm.lbxColumnNamesClick(Sender: TObject);
begin
  //Should we enable the buttons?
  btDelete.Enabled   := lbxColumnNames.ItemIndex <> -1;
  btMoveUp.Enabled   := lbxColumnNames.ItemIndex > 0;
  btMoveDown.Enabled := (lbxColumnNames.ItemIndex <> -1) and
                        (lbxColumnNames.ItemIndex <> lbxColumnNames.Count - 1);

  if lbxColumnNames.ItemIndex = -1 then
  begin
    lastIdx := -1;
    Exit;
  end;

  //Save the old panel
  if lastIdx <> -1 then
  begin
    lbxColumnNames.Items[lastIdx]      := txtCaption.Text;
    StatusBarObj.Panels[lastIdx].Text  := txtCaption.Text;
    StatusBarObj.Panels[lastIdx].Width := StrToInt(txtWidth.Text);
  end;

  //Set the new strings
  lastIdx         := lbxColumnNames.ItemIndex;
  txtCaption.Text := StatusBarObj.Panels[lbxColumnNames.ItemIndex].Text;
  txtWidth.Text   := IntToStr(StatusBarObj.Panels[lbxColumnNames.ItemIndex].Width);
end;

procedure TStatusBarForm.btMoveUpClick(Sender: TObject);
var
tmpString: string;
tmpWidth: Integer;
begin
  //Get the old panel
  tmpString := StatusBarObj.Panels.Items[lastIdx - 1].Text;
  tmpWidth  := StatusBarObj.Panels.Items[lastIdx - 1].Width;

  //Perform a swap
  StatusBarObj.Panels.Items[lastIdx - 1] := StatusBarObj.Panels.Items[lastIdx];
  
  //Then set the current panel as the backed up on
  StatusBarObj.Panels.Items[lastIdx].Text  := tmpString;
  StatusBarObj.Panels.Items[lastIdx].Width := tmpWidth;

  //set the new listbox selection
  lbxColumnNames.Items.Move(lastIdx, lastIdx - 1);
  lbxColumnNames.ItemIndex := lastIdx - 1;
  lastIdx := lastIdx - 1;

  //Lastly, do the button enabling
  btDelete.Enabled   := lastIdx <> -1;
  btMoveUp.Enabled   := lastIdx > 0;
  btMoveDown.Enabled := lastIdx < lbxColumnNames.Count - 1;
end;

procedure TStatusBarForm.btMoveDownClick(Sender: TObject);
var
tmpString: string;
tmpWidth: Integer;
begin
  //Get the old panel
  tmpString := StatusBarObj.Panels.Items[lastIdx + 1].Text;
  tmpWidth  := StatusBarObj.Panels.Items[lastIdx + 1].Width;

  //Perform a swap
  StatusBarObj.Panels.Items[lastIdx + 1] := StatusBarObj.Panels.Items[lastIdx];
  
  //Then set the current panel as the backed up on
  StatusBarObj.Panels.Items[lastIdx].Text  := tmpString;
  StatusBarObj.Panels.Items[lastIdx].Width := tmpWidth;

  //set the new listbox selection
  lbxColumnNames.Items.Move(lastIdx, lastIdx + 1);
  lbxColumnNames.ItemIndex := lastIdx + 1;
  lastIdx := lastIdx + 1;

  //Lastly, do the button enabling
  btDelete.Enabled   := lastIdx <> -1;
  btMoveUp.Enabled   := lastIdx > 0;
  btMoveDown.Enabled := lastIdx < lbxColumnNames.Count - 1;
end;

end.
