{
wxDialog Designer
}
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


{$WARN UNIT_PLATFORM OFF}
unit dmCreateNewProp;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, JvBaseDlg, JvBrowseFolder, JvSelectDirectory, JvAppStorage,
  JvAppRegistryStorage, JvComponent, FileCtrl, JvFormPlacement, version,
  XPMenu, devcfg, JvComponentBase, utils;
type
  TfrmCreateFormProp = class(TForm)
    Label1: TLabel;
    txtSaveTo: TEdit;
    Label2: TLabel;
    txtClassName: TEdit;
    Label3: TLabel;
    txtFileName: TEdit;
    btBrowse: TButton;
    Label5: TLabel;
    txtTitle: TEdit;
    Bevel1: TBevel;
    btCancel: TButton;
    btCreate: TButton;
    Label7: TLabel;
    Label8: TLabel;
    txtAuthorName: TEdit;
    JvFormStorage1: TJvFormStorage;
    JvAppRegistryStorage1: TJvAppRegistryStorage;
    Label6: TLabel;
    cbUseCaption: TCheckBox;
    cbResizeBorder: TCheckBox;
    cbSystemMenu: TCheckBox;
    cbThickBorder: TCheckBox;
    cbStayOnTop: TCheckBox;
    cbNoParent: TCheckBox;
    cbMinButton: TCheckBox;
    cbMaxButton: TCheckBox;
    cbCloseButton: TCheckBox;
    XPMenu: TXPMenu;
    ProfileNameSelect: TComboBox;
    ProfileLabel: TLabel;
    procedure btBrowseClick(Sender: TObject);
    procedure btCreateClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCreateFormProp: TfrmCreateFormProp;

implementation

{$R *.DFM}

procedure TfrmCreateFormProp.btBrowseClick(Sender: TObject);
var
dir : string;
begin
  dir := txtSaveTo.text;
  if SelectDirectory('Select a directory', '', dir) then
    txtSaveTo.text := dir;
end;

procedure TfrmCreateFormProp.btCreateClick(Sender: TObject);
  function isValid: Boolean;
  begin
    Result := False;
    if Trim(txtSaveTo.Text) = '' then
    begin
      MessageDlg('Please select a folder to save the form files to.', mtError, [mbOK], Handle);
      btBrowse.SetFocus;
      Exit;
    end;

    if ValidateFileName(txtFileName.Text) > 0 then
    begin
      if MessageDlg('File names cannont contain "*:<> and |.'#10#13#10#13 +
                    'Do you want wxDev-C++ to replace these characters with underscores?',
                    mtConfirmation, [mbYes, mbNo], Handle) = mrYes then
        txtFileName.Text := CreateValidFileName(txtFileName.Text)
      else
      begin
        txtFileName.SetFocus;
        Exit;
      end;
    end;

    if (ValidateClassName(txtClassName.Text) > 0) then
    begin
      if MessageDlg('Your class name is not a valid C++ identifier.'#10#13#10#13 +
                    'Do you want wxDev-C++ to fix your Class Name automatically?',
                    mtConfirmation, [mbYes, mbNo], Handle) = mrYes then
        txtClassName.Text := CreateValidClassName(txtClassName.Text)
      else
      begin
        txtClassName.SetFocus;
        Exit;
      end;
    end;

    Result := True;
  end;

  function DoesExist: Boolean;
  var
    strFName: string;
  begin
    Result := False;
    strFName := IncludeTrailingPathDelimiter(trim(txtSaveTo.Text)) +
      trim(txtFileName.Text);

    if FileExists(ChangeFileExt(strFName, WXFORM_EXT)) or
       FileExists(ChangeFileExt(strFName, CPP_EXT)) or
       FileExists(ChangeFileExt(strFName, H_EXT)) then
    begin
      if MessageDlg('Source files with same file names as the one you are about to create ' +
                    'already exist.'#13#10#13#10'Do you want to overwrite them with the new files?',
                    mtConfirmation, [mbYes, mbNo], Handle) <> mrYes then
        Exit;
    end;

    Result := True;
  end;

begin
  if not isValid then
    exit;

  if not DoesExist then
    exit;

  close;
  ModalResult := mrOk;
end;

procedure TfrmCreateFormProp.btCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCreateFormProp.FormShow(Sender: TObject);
begin
  DesktopFont := True;
  XPMenu.Active := devData.XPTheme;
end;
end.
