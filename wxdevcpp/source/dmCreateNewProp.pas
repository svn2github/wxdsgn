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

unit dmCreateNewProp;

interface
{$Warnings Off}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, JvBaseDlg, JvBrowseFolder, JvSelectDirectory, JvAppStorage,
  JvAppRegistryStorage, JvComponent, FileCtrl, JvFormPlacement, version,
  XPMenu, devcfg, JvComponentBase, utils;
{$Warnings On}
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
    Result := false;
    if trim(txtSaveTo.Text) = '' then
    begin
      MessageDlg('Please select a proper directory', mtError, [mbOK], 0);
      btBrowse.SetFocus;
      exit;
    end;

    if ValidateFileName(txtFileName.Text) > 0 then
    begin
      if(MessageDlg('Your file name is not valid. Do you want it fixed automatically?',mtError, [mbYes, mbNo],0) = mrYes) then
        begin
          txtFileName.Text := CreateValidFileName(txtFileName.Text);
        end
      else
        begin
          MessageDlg('Valid file names cannot contain "*:\/<>|, or spaces. Please fix.',mtError, [mbOK],0);
      txtFileName.SetFocus;
      exit;
    end;
      end;

    if (ValidateClassName(txtClassName.Text) > 0) then
    begin
      if(MessageDlg('Your class name is not valid. Do you want it fixed automatically?',mtError, [mbYes, mbNo],0) = mrYes) then
        begin
          txtClassName.Text := CreateValidClassName(txtClassName.Text);
        end
      else
        begin
          MessageDlg('Valid name must not start with a number and can only contain alphanumeric character or an underscore. Please fix.',mtError, [mbOK],0);
      txtClassName.SetFocus;
      exit;
    end;
      end;

    Result := true;
  end;

  function DoesExisit: Boolean;
  var
    strFName: string;
    boolExisit: Boolean;
  begin
    Result := false;
    strFName := IncludeTrailingPathDelimiter(trim(txtSaveTo.Text)) +
      trim(txtFileName.Text);

    boolExisit := ( {$IFDEF WX_BUILD} (FileExists(ChangeFileExt(strFName, WXFORM_EXT))) or{$ENDIF}
      (FileExists(ChangeFileExt(strFName, CPP_EXT))) or
      (FileExists(ChangeFileExt(strFName, H_EXT))));

    if boolExisit then
    begin
      if MessageDlg('Some source files with same file name already exist.' + #13
        + #10 + '' + #13 + #10 + 'Do you want to overwrite them?', mtError,
        [mbYES, mbNO], 0) <> mrYES then
      begin
        exit;
      end;
    end;

    Result := True;
  end;

begin
  if not isValid then
    exit;

  if not DoesExisit then
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
