{
wxDialog Designer
Copyright (c) 2003 Guru Kathiresan grk4352@njit.edu
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. The name of the author may not be used to endorse or promote products
   derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}

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
