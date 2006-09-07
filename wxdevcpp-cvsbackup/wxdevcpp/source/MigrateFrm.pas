{
    This file is part of Dev-C++
    Copyright (c) 2004 Bloodshed Software

    Dev-C++ is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Dev-C++ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Dev-C++; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

unit MigrateFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, SynEdit, SynMemo, Buttons, JvExButtons,
  JvBitBtn, ExtCtrls, XPMenu, devCfg;

type
  TMigrateFrm = class(TForm)
    grpFiles: TGroupBox;
    lblSource: TLabel;
    Source: TEdit;
    btnSource: TJvBitBtn;
    chkBackup: TCheckBox;
    btnGo: TButton;
    grpStatus: TGroupBox;
    Progress: TProgressBar;
    lblAction: TLabel;
    bvlStatus: TBevel;
    Action: TLabel;
    lblLine: TLabel;
    Line: TLabel;
    bvlLine: TBevel;
    lblChanges: TLabel;
    Changes: TLabel;
    bvlChanges: TBevel;
    XPMenu1: TXPMenu;
    procedure btnGoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  end;

implementation
uses
  StrUtils;
{$R *.dfm}

procedure TMigrateFrm.btnGoClick(Sender: TObject);
var
  Position: integer;
  Changes: integer;
  Strings: TStringList;
  i: integer;
begin
  //Create our array
  btnGo.Enabled := false;
  Strings := TStringList.Create;
  Changes := 0;
  i := 0;

  //Load the file
  Strings.LoadFromFile(Source.Text);
  Progress.Max := Strings.Count;

  //Save a backup
  if chkBackup.Checked then
    Strings.SaveToFile(Source.Text + '.bak');

  //Interate over the file's lines
  while true do
  begin
    //SpaceValue
    if Pos('SpaceValue', Trim(Strings[i])) = 1 then
    begin
      Position := Pos('SpaceValue', Strings[i]);
      Strings[i] := Copy(Strings[i], 1, Position - 1) + 'Wx_Border' + Copy(Strings[i], Position + 10, Length(Strings[i]));
      Inc(Changes);
    end

    //StrechFactor
    else if Pos('Wx_StrechFactor =', Trim(Strings[i])) = 1 then
    begin
      Strings.Delete(i);
      Dec(I);
      Inc(Changes);
    end

    //Wx_ControlOrientation
    else if Pos('Wx_ControlOrientation =', Trim(Strings[i])) = 1 then
    begin
      Strings.Delete(i);
      Dec(I);
      Inc(Changes);
    end

    //Wx_HorizontalAlignment
    else if Pos('Wx_HorizontalAlignment =', Trim(Strings[i])) = 1 then
    begin
      Strings.Delete(i);
      Dec(I);
      Inc(Changes);
    end

    //Wx_VerticalAlignment
    else if Pos('Wx_VerticalAlignment =', Trim(Strings[i])) = 1 then
    begin
      Strings.Delete(i);
      Dec(I);
      Inc(Changes);
    end

    //wxTE_PROCESS_ENTER
    else if (Pos('wxPROCESS_ENTER', Trim(Strings[i])) > Pos('Wx_ComboboxStyle', Trim(Strings[i]))) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxPROCESS_ENTER,', '');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxPROCESS_ENTER', '');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxPROCESS_ENTER', '');
      Strings.Add('Wx_EditStyle = [wxTE_PROCESS_ENTER]');
      Inc(Changes);
    end

    //wxLC_* constants
    else if (Pos('wxLC_ICON', Trim(Strings[i])) > Pos('Wx_ListviewStyle', Trim(Strings[i]))) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_ICON,', '');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxLC_ICON', '');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_ICON', '');
      Strings.Add('Wx_ListviewView = wxLC_ICON');
      Inc(Changes);
    end
    else if (Pos('wxLC_SMALL_ICON', Trim(Strings[i])) > Pos('Wx_ListviewStyle', Trim(Strings[i]))) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_SMALL_ICON,', '');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxLC_SMALL_ICON', '');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_SMALL_ICON', '');
      Strings.Add('Wx_ListviewView = wxLC_SMALL_ICON');
      Inc(Changes);
    end
    else if (Pos('wxLC_LIST', Trim(Strings[i])) > Pos('Wx_ListviewStyle', Trim(Strings[i]))) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_LIST,', '');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxLC_LIST', '');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_LIST', '');
      Strings.Add('Wx_ListviewView = wxLC_LIST');
      Inc(Changes);
    end
    else if (Pos('wxLC_REPORT', Trim(Strings[i])) > Pos('Wx_ListviewStyle', Trim(Strings[i]))) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_REPORT,', '');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxLC_REPORT', '');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_REPORT', '');
      Strings.Add('Wx_ListviewView = wxLC_REPORT');
      Inc(Changes);
    end
    else if (Pos('wxLC_VIRTUAL', Trim(Strings[i])) > Pos('Wx_ListviewStyle', Trim(Strings[i]))) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_VIRTUAL,', '');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxLC_VIRTUAL', '');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_VIRTUAL', '');
      Strings.Add('Wx_ListviewView = wxLC_VIRTUAL');
      Inc(Changes);
    end
    else if (Pos('wxLC_TILE', Trim(Strings[i])) > Pos('Wx_ListviewStyle', Trim(Strings[i]))) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_TILE,', '');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxLC_TILE', '');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_TILE', '');
      Strings.Add('Wx_ListviewView = wxLC_TILE');
      Inc(Changes);
    end

    //wxALIGN_LEFT for wxStaticText
    else if (Pos('wxALIGN_LEFT', Trim(Strings[i])) > Pos('Wx_LabelStyle', Trim(Strings[i]))) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxALIGN_LEFT,', 'wxST_ALIGN_LEFT,');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxALIGN_LEFT', ', wxST_ALIGN_LEFT');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxALIGN_LEFT', 'wxST_ALIGN_LEFT');
      Inc(Changes);
    end
    else if (Pos('wxALIGN_CENTRE', Trim(Strings[i])) > Pos('Wx_LabelStyle', Trim(Strings[i]))) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxALIGN_CENTRE,', 'wxST_ALIGN_CENTRE,');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxALIGN_CENTRE', ', wxST_ALIGN_CENTRE');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxALIGN_CENTRE', 'wxST_ALIGN_CENTRE');
      Inc(Changes);
    end
    else if (Pos('wxALIGN_RIGHT', Trim(Strings[i])) > Pos('Wx_LabelStyle', Trim(Strings[i]))) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxALIGN_RIGHT,', 'wxST_ALIGN_RIGHT,');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxALIGN_RIGHT', ', wxST_ALIGN_RIGHT');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxALIGN_RIGHT', 'wxST_ALIGN_RIGHT');
      Inc(Changes);
    end;

    //Update the UI
    Progress.Position := i;
    Progress.Max := Strings.Count;
    Self.Changes.Caption := inttostr(Changes);
    Line.Caption := inttostr(i + 1) + '/' + inttostr(Strings.Count);
    Application.ProcessMessages;

    //Do we break?
    if i >= Strings.Count - 1 then
      Break
    else
      Inc(I);
  end;

  //Save the file
  Action.Caption := 'Saving changes...';
  Strings.SaveToFile(Source.Text);

  //Free our memory
  Strings.Destroy;
  btnGo.Enabled := true;
  Action.Caption := 'Done';
end;

procedure TMigrateFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Self.Action.Caption = 'Done' then
    self.ModalResult := mrOK;
end;

procedure TMigrateFrm.FormCreate(Sender: TObject);
begin
  if devData.XPTheme then
    XPMenu1.Active := true;
end;

end.
