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
    XPMenu: TXPMenu;
    btnNext: TButton;
    Page1: TPanel;
    intro: TLabel;
    filename: TLabel;
    lblSource: TLabel;
    chkBackup: TCheckBox;
    Source: TEdit;
    btnSource: TJvBitBtn;
    Page2: TPanel;
    progress_lbl: TLabel;
    lblAction: TLabel;
    Line: TLabel;
    Action: TLabel;
    bvlStatus: TBevel;
    bvlLine: TBevel;
    lblLine: TLabel;
    lblChanges: TLabel;
    bvlChanges: TBevel;
    Changes: TLabel;
    Progress: TProgressBar;
    Page3: TPanel;
    finish: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
  private
    procedure CleanUp;
  end;

implementation
uses
  StrUtils;
{$R *.dfm}

procedure TMigrateFrm.btnNextClick(Sender: TObject);
begin
  case btnNext.Tag of
    0:
      begin
        Page1.Visible := False;
        Page2.Visible := True;
        Page3.Visible := False;
        btnNext.Tag := 1;
        Application.ProcessMessages;
        CleanUp;
      end;
    1:
      begin
        Page1.Visible := False;
        Page2.Visible := False;
        Page3.Visible := True;
        btnNext.Tag := 2;
        btnNext.Caption := '&Finish';
        Application.ProcessMessages;
      end;
    2:
      begin
        ModalResult := mrOK;
        Close;
      end;
  end;
end;

procedure TMigrateFrm.CleanUp();
var
  Position: integer;
  Changes: integer;
  Strings: TStringList;
  i: integer;
begin
  //Create our array
  btnNext.Enabled := false;
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
  while i < Strings.Count do
  begin
    //Wx_Alignment
    if Pos('Wx_Alignment = ', Trim(Strings[i])) = 1 then
    begin
      Position := Pos('Wx_Alignment = ', Strings[i]);
      Strings[i] := Copy(Strings[i], 1, Position + 14) + '[' + Copy(Strings[i], Position + 15, Length(Strings[i])) + ']';
      Inc(Changes);
    end

    //OnCloseQuery
    else if Pos('OnCloseQuery', Trim(Strings[i])) = 1 then
    begin
      Strings.Delete(i);
      Dec(I);
      Inc(Changes);
    end

    //OnKeyDown
    else if Pos('OnKeyDown = ', Trim(Strings[i])) = 1 then
    begin
      Strings.Delete(i);
      Dec(I);
      Inc(Changes);
    end
    
    //SpaceValue
    else if Pos('SpaceValue', Trim(Strings[i])) = 1 then
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

    //Rows of wxGrid/wxFlexGridSizer
    else if Pos('Rows =', Trim(Strings[i])) = 1 then
    begin
      Strings.Delete(i);
      Dec(I);
      Inc(Changes);
    end

    //wxTE_PROCESS_ENTER
    else if (Pos('wxPROCESS_ENTER', Trim(Strings[i])) > Pos('Wx_ComboboxStyle', Trim(Strings[i]))) and (Pos('Wx_ComboboxStyle', Trim(Strings[i])) <> 0) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxPROCESS_ENTER,', '');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxPROCESS_ENTER', '');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxPROCESS_ENTER', '');
      Strings.Add('Wx_EditStyle = [wxTE_PROCESS_ENTER]');
      Inc(Changes);
    end

    //wxLC_* constants
    else if (Pos('wxLC_ICON', Trim(Strings[i])) > Pos('Wx_ListviewStyle', Trim(Strings[i]))) and (Pos('Wx_ListviewStyle', Trim(Strings[i])) <> 0) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_ICON,', '');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxLC_ICON', '');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_ICON', '');
      Strings.Add('Wx_ListviewView = wxLC_ICON');
      Inc(Changes);
    end
    else if (Pos('wxLC_SMALL_ICON', Trim(Strings[i])) > Pos('Wx_ListviewStyle', Trim(Strings[i]))) and (Pos('Wx_ListviewStyle', Trim(Strings[i])) <> 0) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_SMALL_ICON,', '');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxLC_SMALL_ICON', '');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_SMALL_ICON', '');
      Strings.Add('Wx_ListviewView = wxLC_SMALL_ICON');
      Inc(Changes);
    end
    else if (Pos('wxLC_LIST', Trim(Strings[i])) > Pos('Wx_ListviewStyle', Trim(Strings[i]))) and (Pos('Wx_ListviewStyle', Trim(Strings[i])) <> 0) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_LIST,', '');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxLC_LIST', '');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_LIST', '');
      Strings.Add('Wx_ListviewView = wxLC_LIST');
      Inc(Changes);
    end
    else if (Pos('wxLC_REPORT', Trim(Strings[i])) > Pos('Wx_ListviewStyle', Trim(Strings[i]))) and (Pos('Wx_ListviewStyle', Trim(Strings[i])) <> 0) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_REPORT,', '');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxLC_REPORT', '');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_REPORT', '');
      Strings.Add('Wx_ListviewView = wxLC_REPORT');
      Inc(Changes);
    end
    else if (Pos('wxLC_VIRTUAL', Trim(Strings[i])) > Pos('Wx_ListviewStyle', Trim(Strings[i]))) and (Pos('Wx_ListviewStyle', Trim(Strings[i])) <> 0) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_VIRTUAL,', '');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxLC_VIRTUAL', '');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_VIRTUAL', '');
      Strings.Add('Wx_ListviewView = wxLC_VIRTUAL');
      Inc(Changes);
    end
{$IFDEF PRIVATE_BUILD}
    else if (Pos('wxLC_TILE', Trim(Strings[i])) > Pos('Wx_ListviewStyle', Trim(Strings[i]))) and (Pos('Wx_ListviewStyle', Trim(Strings[i])) <> 0) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_TILE,', '');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxLC_TILE', '');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxLC_TILE', '');
      Strings.Add('Wx_ListviewView = wxLC_TILE');
      Inc(Changes);
    end
{$ENDIF}

    //wxALIGN_LEFT for wxStaticText
    else if (Pos('wxALIGN_LEFT', Trim(Strings[i])) > Pos('Wx_LabelStyle', Trim(Strings[i]))) and (Pos('Wx_LabelStyle', Trim(Strings[i])) <> 0) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxALIGN_LEFT,', 'wxST_ALIGN_LEFT,');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxALIGN_LEFT', ', wxST_ALIGN_LEFT');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxALIGN_LEFT', 'wxST_ALIGN_LEFT');
      Inc(Changes);
    end
    else if (Pos('wxALIGN_CENTRE', Trim(Strings[i])) > Pos('Wx_LabelStyle', Trim(Strings[i]))) and (Pos('Wx_LabelStyle', Trim(Strings[i])) <> 0) then
    begin
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxALIGN_CENTRE,', 'wxST_ALIGN_CENTRE,');
      Strings[i] := AnsiReplaceStr(Strings[i], ', wxALIGN_CENTRE', ', wxST_ALIGN_CENTRE');
      Strings[i] := AnsiReplaceStr(Strings[i], 'wxALIGN_CENTRE', 'wxST_ALIGN_CENTRE');
      Inc(Changes);
    end
    else if (Pos('wxALIGN_RIGHT', Trim(Strings[i])) > Pos('Wx_LabelStyle', Trim(Strings[i]))) and (Pos('Wx_LabelStyle', Trim(Strings[i])) <> 0) then
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
    Inc(I);
  end;

  //Save the file
  Action.Caption := 'Saving changes...';
  Strings.SaveToFile(Source.Text);

  //Free our memory
  Strings.Destroy;
  btnNext.Enabled := true;
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
  btnNext.Tag := 0;
  DesktopFont := True;
  XPMenu.Active := devData.XPTheme;
end;

end.
