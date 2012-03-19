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

Unit LangFrm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, Buttons, ExtCtrls, Menus, XPMenu, ComCtrls, CppParser, 
{$WARNINGS OFF}
    FileCtrl;
{$WARNINGS ON}
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, QExtCtrls, QMenus, QComCtrls;
{$ENDIF}

Type
    TLangForm = Class(TForm)
        OkBtn: TBitBtn;
        PicPanel: TPanel;
        PopupMenu: TPopupMenu;
        N1: TMenuItem;
        Image2: TImage;
        XPMenu: TXPMenu;
        FirstPanel: TPanel;
        ListBox: TListBox;
        GroupBox1: TGroupBox;
        Label1: TLabel;
        ThemeGroupBox: TGroupBox;
        ThemeBox: TComboBox;
        PreviewBtn: TBitBtn;
        XPCheckBox: TCheckBox;
        CachePanel: TPanel;
        Label2: TLabel;
        Label3: TLabel;
        BuildPanel: TPanel;
        YesCache: TRadioButton;
        NoCache: TRadioButton;
        DirCheckBox: TCheckBox;
        DirEdit: TEdit;
        LoadBtn: TSpeedButton;
        ProgressPanel: TPanel;
        pbCCCache: TProgressBar;
        ParseLabel: TLabel;
        SecondPanel: TPanel;
        SecondLabel: TLabel;
        Label5: TLabel;
        YesClassBrowser: TRadioButton;
        NoClassBrowser: TRadioButton;
        FinishPanel: TPanel;
        Label6: TLabel;
        Label4: TLabel;
        Label7: TLabel;
        Label8: TLabel;
        Procedure PreviewBtnClick(Sender: TObject);
        Procedure FormActivate(Sender: TObject);
        Procedure OkBtnClick(Sender: TObject);
        Procedure XPCheckBoxClick(Sender: TObject);
        Procedure DirCheckBoxClick(Sender: TObject);
        Procedure LoadBtnClick(Sender: TObject);
        Procedure ThemeBoxChange(Sender: TObject);
    Private
        HasProgressStarted: Boolean;

        Function GetSelected: Integer;
        Procedure CppParserTotalProgress(Sender: TObject; FileName: String;
            Total, Current: Integer);
        Procedure CppParserStartParsing(Sender: TObject);
        Procedure CppParserEndParsing(Sender: TObject);

    Public
        Procedure UpdateList(Const List: TStrings);
        Property Selected: Integer Read GetSelected;
    End;

Implementation

Uses
    MultiLangSupport, datamod, DevThemes, devcfg, utils, main, version,
    Splash;

{$R *.dfm}

Procedure TLangForm.UpdateList;
Var
    idx: Integer;
    sel, selEnglish: Integer;
Begin
    ListBox.Clear;
    selEnglish := 0;
    For idx := 0 To pred(List.Count) Do
    Begin
        sel := ListBox.Items.Add(List.Values[List.Names[idx]]);
        If Pos('english (original)', LowerCase(ListBox.Items[sel])) > 0 Then
        begin
            selEnglish := sel;
            ListBox.Selected[sel] := True;
        end
    End;
    ListBox.TopIndex := -1 + selEnglish;
End;

Function TLangForm.GetSelected: Integer;
Begin
    result := ListBox.ItemIndex;
End;

Procedure TLangForm.PreviewBtnClick(Sender: TObject);
Var
    aPoint: TPoint;
Begin
    If ThemeBox.ItemIndex = 1 Then
        PopupMenu.Images := dmMain.MenuImages_Gnome
    Else
    If ThemeBox.ItemIndex = 2 Then
        PopupMenu.Images := dmMain.MenuImages_Blue
    Else
    If ThemeBox.ItemIndex = 3 Then
        PopupMenu.Images := dmMain.MenuImages_Classic
    Else
        PopupMenu.Images := dmMain.MenuImages_NewLook;
    aPoint := Point(0, 0);
    aPoint := PreviewBtn.ClientToScreen(aPoint);
    PopupMenu.Popup(aPoint.X, aPoint.Y);
End;

Procedure TLangForm.FormActivate(Sender: TObject);
Var s: Array [0..255] Of Char;
    d: DWORD;
    sl: TStrings;
Begin
  //  DesktopFont := True;
    SplashForm.Hide; // Hide the splash form

    HasProgressStarted := False;
    sl := devTheme.ThemeList;
    ThemeBox.Items.AddStrings(sl);
    sl.Free;
    ThemeBox.ItemIndex := 0;
    Image2.Picture.Bitmap.LoadFromResourceName(HInstance, 'THEMENEWLOOK');
    GetUserName(s, d);
{$IFDEF BETAVERSION}
  MessageBox(Self.Handle,
             PChar('This is a beta version of wxDev-C++.'#13#13
             +WrapText('Please report bugs to https://sourceforge.net/tracker/?group_id=95606&atid=611982.', 85) +#13
             +WrapText('Your configuration files will be stored in ' +  ExtractFileDir(devData.INIFile) + '.', 85) + #13#13
             +'You can change the directory in Tools > Environment Options > Files & Directories or ' + #13
             +'pass -c "Configuration File Directory" when starting wxDev-C++.'),
             PChar('Beta Version Notice'), MB_OK);
{$ENDIF}
End;

Procedure TLangForm.CppParserStartParsing(Sender: TObject);
Begin
    pbCCCache.Visible := True;
End;

Procedure TLangForm.CppParserEndParsing(Sender: TObject);
Begin
    pbCCCache.Visible := False;
End;

Procedure TLangForm.CppParserTotalProgress(Sender: TObject;
    FileName: String; Total, Current: Integer);
Begin
    If Not HasProgressStarted Then
    Begin
        pbCCCache.Max := Total;
        HasProgressStarted := True;
    End;
    pbCCCache.Position := pbCCCache.Position + Current;
    If FileName <> '' Then
        ParseLabel.Caption := 'Parsing file: ' + FileName
    Else
        ParseLabel.Caption := 'Finalizing... Please wait';
    ParseLabel.Width := 250;
    Application.ProcessMessages;
End;

Procedure TLangForm.OkBtnClick(Sender: TObject);
Var s: TStringList;
    i: Integer;

procedure CacheFilesFromWildcard(Directory, Mask: String;
        Subdirs, ShowDirs, Multitasking: Boolean);
Var
    SearchRec: TSearchRec;
    Attr, Error: Integer;
    fileName : string;
Begin
    Directory := IncludeTrailingPathDelimiter(Directory);

    { First, find the required file... }
    Attr := faAnyFile;
    If ShowDirs = False Then
        Attr := Attr - faDirectory;
    Error := FindFirst(Directory + Mask, Attr, SearchRec);
    If (Error = 0) Then
    Begin
        While (Error = 0) Do
        Begin
            { Found one! }
            fileName := Directory + SearchRec.Name;
             If (MainForm.CppParser1.CacheContents.IndexOf(fileName) = -1) Then
                        MainForm.CppParser1.AddFileToScan(fileName);

            Error := FindNext(SearchRec);
            If Multitasking Then
                Application.ProcessMessages;
        End;
        FindClose(SearchRec);
    End;

    { Then walk through all subdirectories. }
    If Subdirs Then
    Begin
        Error := FindFirst(Directory + '*.*', faAnyFile, SearchRec);
        If (Error = 0) Then
        Begin
            While (Error = 0) Do
            Begin
                { Found one! }
                If (SearchRec.Name[1] <> '.') And (SearchRec.Attr And
                    faDirectory <> 0) Then
                    { We do this recursively! }
                    CacheFilesFromWildcard(Directory + SearchRec.Name, Mask,
                        Subdirs, ShowDirs, Multitasking);
                Error := FindNext(SearchRec);
            End;
            FindClose(SearchRec);
        End;
    End;
End;

Begin
    If OkBtn.Tag = 0 Then
    Begin
        OkBtn.Tag := 1;
        SecondPanel.Visible := True;
        FirstPanel.Visible := False;
        devData.ThemeChange := True;
        devData.Theme := ThemeBox.Items[ThemeBox.ItemIndex];
        devData.XPTheme := XPCheckBox.Checked;
        devClassBrowsing.Enabled := True;
        // EAB: There's no reason for classbrowsing disabled by default as far as we know.
    End
    Else
    If OkBtn.Tag = 1 Then
    Begin
        If YesClassBrowser.Checked Then
        Begin
            OkBtn.Tag := 2;
            CachePanel.Visible := True;
            SecondPanel.Visible := False;
        End
        Else
        Begin
            OkBtn.Tag := 3;
            OkBtn.Kind := bkOK;
            OkBtn.ModalResult := mrOK;
            FinishPanel.Visible := True;
            SecondPanel.Visible := False;
            devCodeCompletion.Enabled := False;
            devCodeCompletion.UseCacheFiles := False;
            devClassBrowsing.Enabled := False;
            devClassBrowsing.ParseLocalHeaders := False;
            devClassBrowsing.ParseGlobalHeaders := False;
            SaveOptions;
        End;
    End
    Else
    If OkBtn.Tag = 2 Then
    Begin
        If YesCache.Checked Then
        Begin
            YesCache.Enabled := False;
            NoCache.Enabled := False;
            OkBtn.Enabled := False;
            DirEdit.Enabled := False;
            DirCheckBox.Enabled := False;
            LoadBtn.Enabled := False;
            BuildPanel.Visible := False;
            ProgressPanel.Visible := True;
            OkBtn.Caption := 'Please wait...';
            MainForm.CacheCreated := True;
            Application.ProcessMessages;
            devCodeCompletion.Enabled := True;
            devCodeCompletion.UseCacheFiles := True;
            devClassBrowsing.Enabled := True;
            devClassBrowsing.ParseLocalHeaders := True;
            devClassBrowsing.ParseGlobalHeaders := False;
            SaveOptions;

            MainForm.CppParser1.ParseLocalHeaders := True;
            MainForm.CppParser1.ParseGlobalHeaders := True;
            MainForm.CppParser1.OnStartParsing := CppParserStartParsing;
            MainForm.CppParser1.OnEndParsing := CppParserEndParsing;
            MainForm.CppParser1.OnTotalProgress := CppParserTotalProgress;
            MainForm.CppParser1.Tokenizer := MainForm.CppTokenizer1;
            MainForm.CppParser1.Enabled := True;
            MainForm.ClassBrowser1.SetUpdateOff;

            s := TStringList.Create;
            If DirCheckBox.Checked Then
                StrToList(DirEdit.Text, s)
            Else
            Begin
       {$IFDEF PLUGIN_BUILD}
                For i := 0 To MainForm.pluginsCount - 1 Do
                Begin
                    If (devDirs.Cpp = '') Then
                        devDirs.Cpp := devDirs.Cpp + ';' +
                            devDirs.CallValidatePaths(MainForm.plugins[i].GET_COMMON_CPP_INCLUDE_DIR)
                    // EAB TODO: make it multiplugin functional.
                    Else
                        devDirs.Cpp := devDirs.Cpp + ';' +
                            devDirs.CallValidatePaths(MainForm.plugins[i].GET_COMMON_CPP_INCLUDE_DIR);
                    // EAB TODO: make it multiplugin functional.
                End;
        {$ENDIF}
                StrToList(devDirs.Cpp, s);
            End;

            For i := 0 To s.Count - 1 Do
            Begin
                If DirectoryExists(s[i]) Then
                Begin
                    CacheFilesFromWildcard(s[i], '*.h', True, False, False);
                    Screen.Cursor := crHourglass;
                    Application.ProcessMessages;
                End
                Else
                    MessageDlg('Directory "' + s[i] + '" does not exist.',
                        mtWarning, [mbOK], 0);
            End;
            Application.ProcessMessages;
            MainForm.CppParser1.ParseList;
            ParseLabel.Caption := 'Saving cache to disk...';

            Application.ProcessMessages;
            MainForm.CppParser1.Save(devDirs.Config + DEV_COMPLETION_CACHE);
            MainForm.ClassBrowser1.SetUpdateOn;
            Application.ProcessMessages;

            Screen.Cursor := crDefault;

            s.Clear;
            s.Free;

        End
        Else
        Begin
            devClassBrowsing.ParseLocalHeaders := False;
            devClassBrowsing.ParseGlobalHeaders := False;
        End;
        OkBtn.Tag := 3;
        OkBtn.Kind := bkOK;
        OkBtn.ModalResult := mrOK;
        OkBtn.Enabled := True;
        FinishPanel.Visible := True;
        CachePanel.Visible := False;

    End;
End;

Procedure TLangForm.XPCheckBoxClick(Sender: TObject);
Begin
    If XPCheckBox.Checked Then
        XPMenu.Active := True
    Else
        XPMenu.Active := False;
End;

Procedure TLangForm.DirCheckBoxClick(Sender: TObject);
Begin

    DirEdit.Enabled := DirCheckBox.Checked;
    LoadBtn.Enabled := DirCheckBox.Checked;
        
End;

Procedure TLangForm.LoadBtnClick(Sender: TObject);
Var
{$IFDEF WIN32}
    s: String;
{$ENDIF}
{$IFDEF LINUX}
  s: WideString;
{$ENDIF}
Begin
    If SelectDirectory('Include Directory', '', s) Then
        DirEdit.Text := s;
End;

Procedure TLangForm.ThemeBoxChange(Sender: TObject);
Begin
    Case ThemeBox.ItemIndex Of
        1:
            Image2.Picture.Bitmap.LoadFromResourceName(HInstance, 'THEMEGNOME');
        2:
            Image2.Picture.Bitmap.LoadFromResourceName(HInstance, 'THEMEBLUE');
        3:
            Image2.Picture.Bitmap.LoadFromResourceName(HInstance, 'THEMECLASSIC');

    Else
        Image2.Picture.Bitmap.LoadFromResourceName(HInstance, 'THEMENEWLOOK');
    End;
End;

End.
