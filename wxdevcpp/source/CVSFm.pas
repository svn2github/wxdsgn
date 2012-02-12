{
    $Id: CVSFm.pas 712 2006-12-04 08:12:41Z lowjoel $

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

{$WARN UNIT_PLATFORM OFF}
Unit CVSFm;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, devTabs, StdCtrls, Spin, devRun, ComCtrls, StrUtils, FileCtrl,
    Grids, ValEdit, CVSThread, XPMenu, Menus, CheckLst, DateUtils;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Variants, Classes, QGraphics, QControls, QForms,
  QDialogs, devTabs, QStdCtrls, devRun, QComCtrls, StrUtils, 
  QGrids, CVSThread, QMenus, QCheckLst, DateUtils, Types;
{$ENDIF}

Type
    TCVSAction = (caImport, caCheckout, caCommit, caUpdate, caDiff,
        caLog, caAdd, caRemove, caLogin, caLogout);

    TCVSForm = Class(TForm)
        devPages1: TPageControl;
        tabImport: TTabSheet;
        tabRepos: TTabSheet;
        btnOK: TButton;
        btnCancel: TButton;
        tabGlobal: TTabSheet;
        lblCompression: TLabel;
        spnCompression: TSpinEdit;
        tabCheckout: TTabSheet;
        tabCommit: TTabSheet;
        tabUpdate: TTabSheet;
        tabDiff: TTabSheet;
        tabLog: TTabSheet;
        chkUpdRecurse: TCheckBox;
        chkUpdResetSticky: TCheckBox;
        chkUpdCreateDirs: TCheckBox;
        chkUpdCleanCopy: TCheckBox;
        tabOutput: TTabSheet;
        chkUseSSH: TCheckBox;
        memOutput: TRichEdit;
        chkDiffRecurse: TCheckBox;
        chkLogRecurse: TCheckBox;
        lblCommitMsg: TLabel;
        memCommitMsg: TMemo;
        lblCVSImportDir: TLabel;
        txtCVSImportDir: TEdit;
        btnCVSImportBrws: TButton;
        chkLogDefBranch: TCheckBox;
        chkLogRCS: TCheckBox;
        chkLogNoTag: TCheckBox;
        chkDiffUnified: TCheckBox;
        grpRepDetails: TGroupBox;
        lblMethod: TLabel;
        lblUser: TLabel;
        lblServer: TLabel;
        lblDir: TLabel;
        lblRepos: TLabel;
        txtUser: TEdit;
        txtServer: TEdit;
        txtDir: TEdit;
        cmbMethod: TComboBox;
        lblRep: TLabel;
        cmbRepos: TComboBox;
        lblCOModule: TLabel;
        txtCOmodule: TEdit;
        lblCODir: TLabel;
        txtCOdir: TEdit;
        btnCOBrws: TButton;
        chkCOrecurse: TCheckBox;
        txtCOModuleAs: TEdit;
        chkCOModuleAs: TCheckBox;
        vle: TValueListEditor;
        lblImpAction: TLabel;
        lblImpVendor: TLabel;
        lblImpRelease: TLabel;
        lblImpMsg: TLabel;
        txtImpVendor: TEdit;
        txtImpRelease: TEdit;
        memImpMsg: TMemo;
        lblImpModule: TLabel;
        txtImpModule: TEdit;
        grpUpdRevisions: TGroupBox;
        chkBeforeDate: TCheckBox;
        chkRevision: TCheckBox;
        chkMostRecent: TCheckBox;
        cmbBeforeDate: TComboBox;
        cmbRevision: TComboBox;
        chkUpdPrune: TCheckBox;
        grpLogFilter: TGroupBox;
        chkLogFbyRev: TCheckBox;
        chkLogFbyDate: TCheckBox;
        chkLogFbyUser: TCheckBox;
        cmbLogFbyRev: TComboBox;
        cmbLogFbyDate: TComboBox;
        cmbLogFbyUser: TComboBox;
        grpDiff: TGroupBox;
        txtDiffRev1: TEdit;
        lblDiffRev1: TLabel;
        txtDiffRev2: TEdit;
        lblDiffRev2: TLabel;
        chkDiffDate1: TCheckBox;
        chkDiffDate2: TCheckBox;
        rgbDiff: TRadioButton;
        rgbDiff1: TRadioButton;
        rgbDiff2: TRadioButton;
        tabAdd: TTabSheet;
        tabRemove: TTabSheet;
        lblAddMsg: TLabel;
        memAddMsg: TMemo;
        chkRemove: TCheckBox;
        XPMenu: TXPMenu;
        tabFiles: TTabSheet;
        lblFiles: TLabel;
        lstFiles: TCheckListBox;
        txtPort: TEdit;
        lblPort: TLabel;
        cmbCOBeforeDate: TComboBox;
        chkCOBeforeDate: TCheckBox;
        chkCORevision: TCheckBox;
        cmbCORevision: TComboBox;
        chkCOMostRecent: TCheckBox;
        Procedure FormShow(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure cmbMethodChange(Sender: TObject);
        Procedure btnOKClick(Sender: TObject);
        Procedure btnCancelClick(Sender: TObject);
        Procedure btnCVSImportBrwsClick(Sender: TObject);
        Procedure cmbReposChange(Sender: TObject);
        Procedure btnCOBrwsClick(Sender: TObject);
        Procedure chkCOModuleAsClick(Sender: TObject);
        Procedure vleGetPickList(Sender: TObject; Const KeyName: String;
            Values: TStrings);
        Procedure txtImpModuleChange(Sender: TObject);
        Procedure txtCOmoduleChange(Sender: TObject);
        Procedure chkBeforeDateClick(Sender: TObject);
        Procedure chkRevisionClick(Sender: TObject);
        Procedure chkLogFbyRevClick(Sender: TObject);
        Procedure chkLogFbyDateClick(Sender: TObject);
        Procedure chkLogFbyUserClick(Sender: TObject);
        Procedure rgbDiff1Click(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Procedure lstFilesDrawItem(Control: TWinControl; Index: Integer;
            Rect: TRect; State: TOwnerDrawState);
        Procedure chkCORevisionClick(Sender: TObject);
        Procedure chkCOBeforeDateClick(Sender: TObject);
    Private
        { Private declarations }
        fCVSAction: TCVSAction;
        fFiles: TStrings;
        fAllFiles: TStrings;
        fRunner: TCVSThread;
        fTerminateRunner: Boolean;
        Procedure LoadText;
        Function CVSActionStr(CVSAct: TCVSAction): String;
        Function CVSActionTabStr(CVSAct: TCVSAction): String;
        Procedure UpdateVLE(Path: String);
        Procedure SetupDefaults;
        Procedure BreakUpRepository;
        Procedure UpdateRepositoryDisplay;
        Procedure CVSLineOutput(Sender: TObject; Const Line: String);
        Procedure CVSCheckAbort(Var AbortThread: Boolean);
        Procedure CVSTerminated(Sender: TObject);
        Procedure CVSNeedPassword(Var Passwd: String);
        Procedure FindModifiedFiles;
    Public
        { Public declarations }
        Property CVSAction: TCVSAction Read fCVSAction Write fCVSAction;
        Property Files: TStrings Read fFiles Write fFiles;
        Property AllFiles: TStrings Read fAllFiles Write fAllFiles;
    End;

Var
    CVSForm: TCVSForm;

Implementation

Uses
    devcfg, utils, MultiLangSupport, CVSPasswdFm;

{$R *.dfm}

Procedure TCVSForm.SetupDefaults;
Begin
    cmbBeforeDate.Items.Add(FormatDateTime('yyyy-mm-dd hh:nn', Now));
    cmbBeforeDate.Items.Add(FormatDateTime('=yyyy-mm-dd hh:nn', Now));
    cmbBeforeDate.Items.Add(FormatDateTime('=dd-mm-yyyy hh:nn', Now));
    cmbBeforeDate.Items.Add(FormatDateTime('<=yyyy-mm-dd', Now));
    cmbBeforeDate.Items.Add(FormatDateTime('dd mmm yyyy', Now));
    cmbBeforeDate.Items.Add(FormatDateTime('dd mmm', Now));
    cmbBeforeDate.Items.Add(FormatDateTime('yyyy-mm', Now));
    cmbBeforeDate.Enabled := False;
    cmbRevision.Enabled := False;
    cmbBeforeDate.Text := '';
    cmbRevision.Text := '';
    chkMostRecent.Enabled := False;
    txtCOModuleAs.Text := '';
    txtCOmodule.Text := '';
    If fFiles.Count > 0 Then
        txtCOdir.Text := ExtractFilePath(fFiles[0])
    Else
        txtCOdir.Text := '';
    cmbCOBeforeDate.Text := '';
    cmbCORevision.Text := '';
    chkCOMostRecent.Enabled := False;
    txtImpVendor.Text := 'avendor';
    txtImpRelease.Text := 'arelease';
    txtImpModule.Text := '';
    memImpMsg.Lines.Clear;

    cmbLogFbyRev.Text := '';
    cmbLogFbyDate.Text := '';
    cmbLogFbyUser.Text := '';
    cmbLogFbyDate.Items.Assign(cmbBeforeDate.Items);

    txtDiffRev1.Text := '';
    txtDiffRev2.Text := '';
End;

Procedure TCVSForm.BreakUpRepository;
Var
    idx: Integer;
    S: String;
Begin
    // take the repository (e.g. ":pserver:user@some.host.com:/remote/dir")
    // and break it up to fill in the respective edit boxes
    cmbMethod.ItemIndex := 1;
    txtUser.Text := '';
    txtServer.Text := '';
    txtPort.Text := '';
    txtPort.Text := '';
    txtDir.Text := '';

    Repeat
        S := cmbRepos.Text;
        If (S = '') Or (S[1] <> ':') Then
            Break;
        Delete(S, 1, 1); // remove first ':'

        idx := Pos(':', S);
        If idx = 0 Then
            Break;

        // set method
        cmbMethod.ItemIndex := cmbMethod.Items.IndexOf(Copy(S, 1, idx - 1));
        If cmbMethod.ItemIndex = -1 Then
            Break;
        Delete(S, 1, idx); // remove second ':'

        If cmbMethod.ItemIndex > 0 Then
        Begin
            // set user
            idx := Pos('@', S);
            If idx = 0 Then
                Break;
            txtUser.Text := Copy(S, 1, idx - 1);
            Delete(S, 1, idx); // remove '@'

            // set server
            idx := Pos(':', S);
            If idx = 0 Then
                Break;
            txtServer.Text := Copy(S, 1, idx - 1);
            Delete(S, 1, idx);
        End;

        //set port number
        idx := Pos('/', S);
        If idx > 0 Then
            If StrToIntDef(Copy(S, 1, idx - 1), -1) <> -1 Then
            Begin
                txtPort.Text := Copy(S, 1, idx - 1);
                Delete(S, 1, idx - 1);
            End;

        // set dir
        txtDir.Text := S;

    Until True;

    UpdateRepositoryDisplay;
End;

Procedure TCVSForm.FormShow(Sender: TObject);
Var
    I, idx: Integer;
Begin
    Screen.Cursor := crHourglass;
    LoadText;
    Caption := Format('CVS - %s', [CVSActionStr(fCVSAction)]);

    lstFiles.Items.Assign(fAllFiles);

    // if whole dir
    If ((fFiles.Count = 1) And DirectoryExists(fFiles[0])) Or
        (fFiles.Count = 0) Then
        tabFiles.TabVisible := False

    Else
    If fFiles.Count > 0 Then
    Begin
        tabFiles.TabVisible := True;
        For I := 0 To fFiles.Count - 1 Do
        Begin
            idx := lstFiles.Items.IndexOf(fFiles[I]);
            If idx > -1 Then
                lstFiles.Checked[idx] := True;
        End;
    End;

    FindModifiedFiles;

    cmbRepos.Items.Clear;
    For I := 0 To devCVSHandler.Repositories.Count - 1 Do
        cmbRepos.Items.Add(devCVSHandler.Repositories.Values[IntToStr(I)]);
    cmbRepos.Text := '';
    If fCVSAction In [caImport, caCheckOut, caCommit, caAdd,
        caLogin, caLogout] Then
    Begin
        tabRepos.TabVisible := True;
        If cmbRepos.Items.Count > 0 Then
            cmbRepos.ItemIndex := 0;
        BreakUpRepository;
        If fFiles.Count > 0 Then
            txtCVSImportDir.Text := ExtractFilePath(fFiles[0])
        Else
            txtCVSImportDir.Text := '';
        If (fCVSAction = caImport) And (txtCVSImportDir.Text <> '') And
            (txtCVSImportDir.Text <> devDirs.Default) Then
            UpdateVLE(txtCVSImportDir.Text);
    End
    Else
        tabRepos.TabVisible := False;

    SetupDefaults;

    spnCompression.Value := devCVSHandler.Compression;

    tabImport.Caption := CVSActionTabStr(caImport);
    tabCheckout.Caption := CVSActionTabStr(caCheckout);
    tabCommit.Caption := CVSActionTabStr(caCommit);
    tabUpdate.Caption := CVSActionTabStr(caUpdate);
    tabDiff.Caption := CVSActionTabStr(caDiff);
    tabLog.Caption := CVSActionTabStr(caLog);
    tabAdd.Caption := CVSActionTabStr(caAdd);
    tabRemove.Caption := CVSActionTabStr(caRemove);

    tabImport.TabVisible := fCVSAction = caImport;
    tabCheckout.TabVisible := fCVSAction = caCheckout;
    tabCommit.TabVisible := fCVSAction = caCommit;
    tabUpdate.TabVisible := fCVSAction = caUpdate;
    tabDiff.TabVisible := fCVSAction = caDiff;
    tabLog.TabVisible := fCVSAction = caLog;
    tabAdd.TabVisible := fCVSAction = caAdd;
    tabRemove.TabVisible := fCVSAction = caRemove;

    memOutput.Lines.Clear;
    If fCVSAction In [caLogin, caLogout] Then
        devPages1.ActivePage := tabRepos
    Else
        devPages1.ActivePageIndex := Ord(fCVSAction);
    Screen.Cursor := crDefault;
End;

Procedure TCVSForm.UpdateRepositoryDisplay;
Begin
    If (cmbMethod.ItemIndex > 0) And ((txtUser.Text = '') Or
        (txtServer.Text = '')) Then
    Begin
        btnOK.Enabled := False;
        lblRepos.Caption := 'Invalid repository...';
    End
    Else
    If cmbMethod.ItemIndex = 0 Then
    Begin
        btnOK.Enabled := True;
        lblRepos.Caption := Format(':%s:%s%s', [
            cmbMethod.Text,
            txtPort.Text,
            txtDir.Text
            ]);
    End
    Else
    Begin
        btnOK.Enabled := True;
        lblRepos.Caption := Format(':%s:%s@%s:%s%s', [
            cmbMethod.Text,
            txtUser.Text,
            txtServer.Text,
            txtPort.Text,
            txtDir.Text
            ]);
    End;
End;

Procedure TCVSForm.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    Action := caFree;
End;

Function TCVSForm.CVSActionStr(CVSAct: TCVSAction): String;
Begin
    Case CVSAct Of
        caImport:
            Result := Lang[ID_CVS_IMPORT];
        caCheckout:
            Result := Lang[ID_CVS_CHECKOUT];
        caCommit:
            Result := Lang[ID_CVS_COMMIT];
        caUpdate:
            Result := Lang[ID_CVS_UPDATE];
        caDiff:
            Result := Lang[ID_CVS_DIFF];
        caLog:
            Result := Lang[ID_CVS_LOG];
        caAdd:
            Result := Lang[ID_CVS_ADD];
        caRemove:
            Result := Lang[ID_CVS_REMOVE];
    Else
        Result := '';
    End;
End;

Function TCVSForm.CVSActionTabStr(CVSAct: TCVSAction): String;
Begin
    Case CVSAct Of
        caImport:
            Result := Lang[ID_CVS_IMPORTTAB];
        caCheckout:
            Result := Lang[ID_CVS_CHECKOUTTAB];
        caCommit:
            Result := Lang[ID_CVS_COMMITTAB];
        caUpdate:
            Result := Lang[ID_CVS_UPDATETAB];
        caDiff:
            Result := Lang[ID_CVS_DIFFTAB];
        caLog:
            Result := Lang[ID_CVS_LOGTAB];
        caAdd:
            Result := Lang[ID_CVS_ADDTAB];
        caRemove:
            Result := Lang[ID_CVS_REMOVETAB];
    Else
        Result := '';
    End;
End;

Procedure TCVSForm.cmbMethodChange(Sender: TObject);
Begin
    txtUser.Enabled := cmbMethod.ItemIndex > 0;
    txtServer.Enabled := cmbMethod.ItemIndex > 0;
    UpdateRepositoryDisplay;
End;

Procedure TCVSForm.btnOKClick(Sender: TObject);
Var
    Cmd, sLog, Dir: String;
    I: Integer;
    PrettyCmd: String;
Begin
    If Assigned(fRunner) Then
    Begin
        MessageDlg('Already running a command!', mtWarning, [mbOk], 0);
        Exit;
    End;

    //rebuild the fFiles TStrings based on the lstFiles checked items
    If tabFiles.TabVisible Then
    Begin
        fFiles.Clear;
        For I := 0 To lstFiles.Items.Count - 1 Do
            If lstFiles.Checked[I] Then
                fFiles.Add(lstFiles.Items[I]);
    End;

    If tabRepos.TabVisible Then
    Begin
        I := cmbRepos.Items.IndexOf(lblRepos.Caption);
        If I = -1 Then
            cmbRepos.Items.Insert(0, lblRepos.Caption)
        Else
            cmbRepos.Items.Move(I, 0);
        While cmbRepos.Items.Count > 10 Do
            cmbRepos.Items.Delete(cmbRepos.Items.Count - 1);

        devCVSHandler.Repositories.Clear;
        For I := 0 To cmbRepos.Items.Count - 1 Do
            devCVSHandler.Repositories.Add(Format('%d=%s', [I, cmbRepos.Items[I]]));
    End;
    devCVSHandler.Compression := spnCompression.Value;

    If chkUseSSH.Checked Then
        SetEnvironmentVariable('CVS_RSH', 'ssh.exe')
    Else
        SetEnvironmentVariable('CVS_RSH', 'rsh.exe');

    memOutput.Lines.Clear;

    If fFiles.Count > 0 Then
        Dir := ExcludeTrailingPathDelimiter(ExtractFilePath(fFiles[0]))
    Else
        Dir := GetCurrentDir;

    Case fCVSAction Of

        caImport:
        Begin
            Cmd := Format('%s -z%d -d %s import',
                [devCVSHandler.Executable, devCVSHandler.Compression, lblRepos.Caption]);

            Cmd := Format('%s -I ! -I CVS -I .#*', [Cmd]);
            For I := 1 To vle.Strings.Count Do
                If vle.Cells[1, I] = 'Ignore' Then
                    Cmd := Format('%s -I *%s', [Cmd, vle.Cells[0, I]])
                Else
                If vle.Cells[1, I] = 'Binary' Then
                    Cmd := Format('%s -W "*%s -k''b''"', [Cmd, vle.Cells[0, I]]);

            Dir := txtCVSImportDir.Text;

            sLog := memImpMsg.Text;
            If Trim(sLog) = '' Then
                sLog := '* No message *'
            Else
            Begin
                sLog := StringReplace(memImpMsg.Text, #13#10, #10, [rfReplaceAll]);
                sLog := StringReplace(sLog, '"', '\"', [rfReplaceAll]);
            End;
            Cmd := Format('%s -m "%s" %s %s %s',
                [Cmd, sLog, txtImpModule.Text, txtImpVendor.Text, txtImpRelease.Text]);
        End;

        caCheckout:
        Begin
            Cmd := Format('%s -z%d -d %s checkout',
                [devCVSHandler.Executable, devCVSHandler.Compression, lblRepos.Caption]);

            If Not chkCORecurse.Checked Then
                Cmd := Format('%s -l', [Cmd]);

            If chkCOModuleAs.Checked Then
                Cmd := Format('%s -d %s', [Cmd, txtCOModuleAs.Text]);

            If chkCOBeforeDate.Checked And (Trim(cmbCOBeforeDate.Text) <> '') Then
                Cmd := Format('%s -D "%s"', [Cmd, cmbCOBeforeDate.Text]);

            If chkCORevision.Checked And (Trim(cmbCORevision.Text) <> '') Then
                Cmd := Format('%s -r %s', [Cmd, cmbCORevision.Text]);

            If chkCOMostRecent.Enabled And
                ((chkCOBeforeDate.Checked And (Trim(cmbCOBeforeDate.Text) <> '')) Or
                (chkCORevision.Checked And (Trim(cmbCORevision.Text) <> ''))) Then
                Cmd := Format('%s -f', [Cmd]);

            Dir := txtCOdir.Text;

            Cmd := Format('%s %s', [Cmd, txtCOmodule.Text]);
        End;

        caUpdate:
        Begin
            Cmd := Format('%s -z%d update', [devCVSHandler.Executable,
                devCVSHandler.Compression]);
            If Not chkUpdRecurse.Checked Then
                Cmd := Format('%s -l', [Cmd]);

            If chkUpdResetSticky.Checked Then
                Cmd := Format('%s -A', [Cmd]);

            If chkUpdCreateDirs.Checked Then
                Cmd := Format('%s -d', [Cmd]);

            If chkUpdPrune.Checked Then
                Cmd := Format('%s -P', [Cmd]);

            If chkUpdCleanCopy.Checked Then
                Cmd := Format('%s -C', [Cmd]);

            If chkBeforeDate.Checked And (cmbBeforeDate.Text <> '') Then
                Cmd := Format('%s -D "%s"', [Cmd, cmbBeforeDate.Text]);

            If chkRevision.Checked And (cmbRevision.Text <> '') Then
                Cmd := Format('%s -r %s', [Cmd, cmbRevision.Text]);

            If chkMostRecent.Enabled And
                ((chkBeforeDate.Checked And (cmbBeforeDate.Text <> '')) Or
                (chkRevision.Checked And (cmbRevision.Text <> ''))) Then
                Cmd := Format('%s -f', [Cmd]);

            For I := 0 To fFiles.Count - 1 Do
                Cmd := Format('%s %s',
                    [Cmd, ExtractRelativePath(Dir, ExtractFileName(fFiles[I]))]);
        End;

        caDiff:
        Begin
            Cmd := Format('%s -z%d diff', [devCVSHandler.Executable,
                devCVSHandler.Compression]);
            If Not chkDiffRecurse.Checked Then
                Cmd := Format('%s -l', [Cmd]);
            If chkDiffUnified.Checked Then
                Cmd := Format('%s -u', [Cmd]);
            If (rgbDiff1.Checked Or rgbDiff2.Checked) And
                (txtDiffRev1.Text <> '') Then
            Begin
                If chkDiffDate1.Checked Then
                    Cmd := Format('%s -D "%s"', [Cmd, txtDiffRev1.Text])
                Else
                    Cmd := Format('%s -r%s', [Cmd, txtDiffRev1.Text]);
            End;
            If rgbDiff2.Checked And (txtDiffRev2.Text <> '') Then
            Begin
                If chkDiffDate2.Checked Then
                    Cmd := Format('%s -D "%s"', [Cmd, txtDiffRev2.Text])
                Else
                    Cmd := Format('%s -r%s', [Cmd, txtDiffRev2.Text]);
            End;
            For I := 0 To fFiles.Count - 1 Do
                Cmd := Format('%s %s',
                    [Cmd, ExtractRelativePath(Dir, ExtractFileName(fFiles[I]))]);
        End;

        caLog:
        Begin
            Cmd := Format('%s -z%d log', [devCVSHandler.Executable,
                devCVSHandler.Compression]);
            If Not chkLogRecurse.Checked Then
                Cmd := Format('%s -l', [Cmd]);
            If chkLogDefBranch.Checked Then
                Cmd := Format('%s -r', [Cmd]);
            If chkLogRCS.Checked Then
                Cmd := Format('%s -R', [Cmd]);
            If chkLogNoTag.Checked Then
                Cmd := Format('%s -N', [Cmd]);
            If chkLogFbyRev.Checked And (cmbLogFbyRev.Text <> '') Then
                Cmd := Format('%s -r%s', [Cmd, cmbLogFbyRev.Text]);
            If chkLogFbyDate.Checked And (cmbLogFbyDate.Text <> '') Then
                Cmd := Format('%s -d "%s"', [Cmd, cmbLogFbyDate.Text]);
            If chkLogFbyUser.Checked And (cmbLogFbyUser.Text <> '') Then
                Cmd := Format('%s -w%s', [Cmd, cmbLogFbyUser.Text]);
            For I := 0 To fFiles.Count - 1 Do
                Cmd := Format('%s %s',
                    [Cmd, ExtractRelativePath(Dir, ExtractFileName(fFiles[I]))]);
        End;

        caAdd:
        Begin
            Cmd := Format('%s -d %s -z%d add',
                [devCVSHandler.Executable, lblRepos.Caption, devCVSHandler.Compression]);
            If memAddMsg.Text <> '' Then
                Cmd := Format('%s -m"%s"', [Cmd, memAddMsg.Text]);
            For I := 0 To fFiles.Count - 1 Do
                Cmd := Format('%s %s',
                    [Cmd, ExtractRelativePath(Dir, ExtractFileName(fFiles[I]))]);
        End;

        caRemove:
        Begin
            Cmd := Format('%s -z%d remove', [devCVSHandler.Executable,
                devCVSHandler.Compression]);
            If chkRemove.Checked Then
                Cmd := Format('%s -f', [Cmd]);
            For I := 0 To fFiles.Count - 1 Do
                Cmd := Format('%s %s',
                    [Cmd, ExtractRelativePath(Dir, ExtractFileName(fFiles[I]))]);
        End;

        caCommit:
        Begin
            Cmd := Format('%s -d %s -z%d commit',
                [devCVSHandler.Executable, lblRepos.Caption, devCVSHandler.Compression]);
            sLog := memCommitMsg.Text;
            If Trim(sLog) = '' Then
                sLog := '* No message *'
            Else
            Begin
                sLog := StringReplace(memCommitMsg.Text, #13#10, #10,
                    [rfReplaceAll]);
                sLog := StringReplace(sLog, '"', '\"', [rfReplaceAll]);
            End;
            Cmd := Format('%s -m"%s"', [Cmd, sLog]);
            For I := 0 To fFiles.Count - 1 Do
                Cmd := Format('%s %s',
                    [Cmd, ExtractRelativePath(Dir, ExtractFileName(fFiles[I]))]);
        End;

        caLogin:
            Cmd := Format('%s -z%d -d %s login', [devCVSHandler.Executable,
                devCVSHandler.Compression, lblRepos.Caption]);

        caLogout:
            Cmd := Format('%s -z%d -d %s logout', [devCVSHandler.Executable,
                devCVSHandler.Compression, lblRepos.Caption]);
    End;

    If Cmd <> '' Then
    Begin
        PrettyCmd := StringReplace(Cmd, devCVSHandler.Executable, 'cvs', []);
        If Length(sLog) > 32 Then
            PrettyCmd := StringReplace(PrettyCmd, sLog,
                Copy(sLog, 1, 32) + '...', []);
        PrettyCmd := StringReplace(PrettyCmd, #10, ' ', [rfReplaceAll]);
        CVSLineOutput(Nil, Format('>> Running "%s" (in "%s")', [PrettyCmd, Dir]));
        btnOK.Enabled := False;
        fRunner := TCVSThread.Create(True);
        fRunner.Command := Cmd;
        fRunner.Directory := Dir;
        fRunner.OnTerminate := CVSTerminated;
        fRunner.OnLineOutput := CVSLineOutput;
        fRunner.OnCheckAbort := CVSCheckAbort;
        fRunner.OnNeedPassword := CVSNeedPassword;
        fRunner.FreeOnTerminate := True;
        fRunner.Resume;
        btnCancel.Caption := Lang[ID_BTN_CLOSE];
        devPages1.ActivePage := tabOutput;
        memOutput.SetFocus;
        Screen.Cursor := crHourglass;
        fTerminateRunner := False;
    End;
End;

Procedure TCVSForm.CVSTerminated(Sender: TObject);
Var
    RetValue: Integer;
    S: String;
    I: Integer;
Begin
    S := fRunner.Output;
    I := LastDelimiter(' ', S);
    If I > 0 Then
        Delete(S, 1, I);
    RetValue := StrToIntDef(Trim(S), -1);
    CVSLineOutput(Nil, Format('>> Command complete (exit code: %d)',
        [RetValue]));
    Screen.Cursor := crDefault;
    fRunner := Nil;
    btnCancel.Caption := Lang[ID_BTN_CLOSE];
    btnOK.Enabled := RetValue <> 0;
End;

Procedure TCVSForm.CVSCheckAbort(Var AbortThread: Boolean);
Begin
    AbortThread := fTerminateRunner;
End;

Procedure TCVSForm.CVSNeedPassword(Var Passwd: String);
Begin
    With TCVSPasswdForm.Create(Nil) Do
    Begin
        ShowModal;
        Passwd := txtPass.Text;
        Free;
    End;
End;

Procedure TCVSForm.btnCancelClick(Sender: TObject);
Begin
    If Assigned(fRunner) Then
    Begin
        If fTerminateRunner Then
        Begin
            If MessageDlg('Do you want to force-terminate process?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes Then
                If TerminateThread(fRunner.Handle, Cardinal(-1)) Then
                    CVSTerminated(Nil);
        End
        Else
            fTerminateRunner := True;
    End
    Else
        Close;
End;

Procedure TCVSForm.CVSLineOutput(Sender: TObject; Const Line: String);
Type
    THighlightType = (htNone, htDevCpp, htServer, htUpdated,
        htModified, htConflict, htUnknown, htDiffIn, htDiffOut, htIgnored,
        htNew, htPatched);
Const
    HighlightColors: Array[Low(THighlightType)..High(THighlightType)] Of TColor =
        (clBlack, clBlack, clBlack, clGreen, clRed, clMaroon, clGray,
        clBlue, clRed, clGray, clFuchsia, clGreen);
    HighlightStyles: Array[Low(THighlightType)..High(THighlightType)] Of
        TFontStyles =
        ([], [fsBold], [fsBold], [], [fsBold], [fsBold], [], [], [],
        [], [fsBold], [fsBold]);
Var
    HiType: THighlightType;
    sl: TStringList;
    I: Integer;
Begin
    sl := TStringList.Create;
    Try
        sl.Text := Line;

        For I := 0 To sl.Count - 1 Do
        Begin
            If AnsiStartsStr('>> ', sl[I]) Or
                AnsiStartsStr('@@', sl[I]) Then
                HiType := htDevCPP
            Else
            If AnsiStartsStr('? ', sl[I]) Then
                HiType := htUnknown
            Else
            If AnsiStartsStr('U ', sl[I]) Then
                HiType := htUpdated
            Else
            If AnsiStartsStr('M ', sl[I]) Then
                HiType := htModified
            Else
            If AnsiStartsStr('C ', sl[I]) Then
                HiType := htConflict
            Else
            If AnsiStartsStr('I ', sl[I]) Then
                HiType := htIgnored
            Else
            If AnsiStartsStr('N ', sl[I]) Then
                HiType := htNew
            Else
            If AnsiStartsStr('P ', sl[I]) Then
                HiType := htPatched
            Else
            If AnsiStartsStr('> ', sl[I]) Or
                AnsiStartsStr('+', sl[I]) Then
                HiType := htDiffIn
            Else
            If AnsiStartsStr('< ', sl[I]) Or
                AnsiStartsStr('-', sl[I]) Then
                HiType := htDiffOut
            Else
            If AnsiStartsStr('cvs server: ', sl[I]) Then
                HiType := htServer
            Else
                HiType := htNone;

            memOutput.SelAttributes.Color := HighlightColors[HiType];
            memOutput.SelAttributes.Style := HighlightStyles[HiType];
            memOutput.Lines.Add(sl[I]);
        End;
    Finally
        sl.Free;
    End;
End;

Procedure TCVSForm.btnCVSImportBrwsClick(Sender: TObject);
Var
    s: String;
Begin
    s := txtCVSImportDir.Text;
    If SelectDirectory(Lang[ID_ENV_SELUSERDIR], '', s) Then
        txtCVSImportDir.Text := IncludeTrailingPathDelimiter(s);

    vle.Strings.Clear;
    UpdateVLE(txtCVSImportDir.Text);
End;

Procedure TCVSForm.cmbReposChange(Sender: TObject);
Begin
    BreakUpRepository;
End;

Procedure TCVSForm.btnCOBrwsClick(Sender: TObject);
Var
    s: String;
Begin
    s := txtCOdir.Text;
    If SelectDirectory(Lang[ID_ENV_SELUSERDIR], '', s) Then
        txtCOdir.Text := IncludeTrailingPathDelimiter(s);
End;

Procedure TCVSForm.chkCOModuleAsClick(Sender: TObject);
Begin
    txtCOModuleAs.Enabled := chkCOModuleAs.Checked;
    If txtCOModuleAs.Enabled Then
        txtCOModuleAs.Text := txtCOmodule.Text;
End;

Procedure TCVSForm.UpdateVLE(Path: String);
    Function IsTextOrBinary(Filename: String): Integer;
        // 0:text, 1:binary, 2:ignore
    Var
        hFile: Integer;
        Buf: Array[1..1024] Of Char;
    Begin
        Result := 2;
        hFile := FileOpen(Filename, fmOpenRead);
        If hFile = -1 Then
            Exit;
        While FileRead(hFile, Buf, SizeOf(Buf)) > 0 Do
        Begin
            Result := 0;
            If Pos(#01, Buf) > 0 Then
            Begin
                Result := 1;
                Break;
            End;
        End;
        FileClose(hFile);
    End;
Var
    R: Integer;
    SR: TSearchRec;
Begin
    If FindFirst(Path + '*.*', faAnyFile, SR) = 0 Then
        Repeat
            If (SR.Name = '.') Or (SR.Name = '..') Then
                Continue;
            If (SR.Attr And faDirectory) = faDirectory Then
                UpdateVLE(Path + SR.Name + '\')
            Else
            Begin
                If (Not AnsiStartsStr('.#', SR.Name)) And
                    (ExtractFileExt(SR.Name) <> '') Then
                    If Not vle.FindRow(ExtractFileExt(SR.Name), R) Then
                    Begin
                        Case IsTextOrBinary(Path + SR.Name) Of
                            0:
                                vle.InsertRow(ExtractFileExt(SR.Name), 'Text', True);
                            1:
                                vle.InsertRow(ExtractFileExt(SR.Name), 'Binary', True);
                            2:
                                vle.InsertRow(ExtractFileExt(SR.Name), 'Ignore', True);
                        End;
                        vle.ItemProps[ExtractFileExt(SR.Name)].ReadOnly := True;
                    End;
            End;
        Until FindNext(SR) <> 0;
End;

Procedure TCVSForm.vleGetPickList(Sender: TObject; Const KeyName: String;
    Values: TStrings);
Begin
    Values.Clear;
    Values.Add('Text');
    Values.Add('Binary');
    Values.Add('Ignore');
End;

Procedure TCVSForm.txtImpModuleChange(Sender: TObject);
Begin
    If fCVSAction = caImport Then
        btnOK.Enabled := (txtImpModule.Text <> '') And
            (txtImpVendor.Text <> '') And
            (txtImpRelease.Text <> '');
End;

Procedure TCVSForm.txtCOmoduleChange(Sender: TObject);
Begin
    If fCVSAction = caCheckout Then
        btnOK.Enabled := (txtCOmodule.Text <> '') And
            (txtCOdir.Text <> '') And
            (lblRepos.Caption <> 'Invalid repository...');
End;

Procedure TCVSForm.chkBeforeDateClick(Sender: TObject);
Begin
    cmbBeforeDate.Enabled := chkBeforeDate.Checked;
    chkMostRecent.Enabled := chkBeforeDate.Checked Or chkRevision.Checked;
End;

Procedure TCVSForm.chkRevisionClick(Sender: TObject);
Begin
    cmbRevision.Enabled := chkRevision.Checked;
    chkMostRecent.Enabled := chkBeforeDate.Checked Or chkRevision.Checked;
End;

Procedure TCVSForm.chkLogFbyRevClick(Sender: TObject);
Begin
    cmbLogFbyRev.Enabled := chkLogFbyRev.Checked;
End;

Procedure TCVSForm.chkLogFbyDateClick(Sender: TObject);
Begin
    cmbLogFbyDate.Enabled := chkLogFbyDate.Checked;
End;

Procedure TCVSForm.chkLogFbyUserClick(Sender: TObject);
Begin
    cmbLogFbyUser.Enabled := chkLogFbyUser.Checked;
End;

Procedure TCVSForm.rgbDiff1Click(Sender: TObject);
Begin
    txtDiffRev1.Enabled := rgbDiff1.Checked Or rgbDiff2.Checked;
    txtDiffRev2.Enabled := rgbDiff2.Checked;
    chkDiffDate1.Enabled := txtDiffRev1.Enabled;
    chkDiffDate2.Enabled := txtDiffRev2.Enabled;
End;

Procedure TCVSForm.LoadText;
Begin
    If devData.XPTheme Then
        XPMenu.Active := True
    Else
        XPMenu.Active := False;
    tabImport.Caption := Lang[ID_CVS_IMPORTTAB];
    tabRepos.Caption := Lang[ID_CVS_REPOSITORYTAB];
    tabGlobal.Caption := Lang[ID_CVS_GLOBALTAB];
    tabCheckout.Caption := Lang[ID_CVS_CHECKOUTTAB];
    tabCommit.Caption := Lang[ID_CVS_COMMITTAB];
    tabUpdate.Caption := Lang[ID_CVS_UPDATETAB];
    tabDiff.Caption := Lang[ID_CVS_DIFFTAB];
    tabLog.Caption := Lang[ID_CVS_LOGTAB];
    tabOutput.Caption := Lang[ID_CVS_OUTPUTTAB];
    tabFiles.Caption := Lang[ID_NEWTPL_PAGEFILES];

    lblCVSImportDir.Caption := Lang[ID_CVS_IMPDIR];
    lblImpAction.Caption := Lang[ID_CVS_IMPACTION];
    lblImpVendor.Caption := Lang[ID_CVS_IMPVENDOR];
    lblImpRelease.Caption := Lang[ID_CVS_IMPRELEASE];
    lblImpMsg.Caption := Lang[ID_CVS_LOGMSG];
    lblImpModule.Caption := Lang[ID_CVS_MODULE];
    vle.TitleCaptions[0] := Lang[ID_CVS_IMPEXT];
    vle.TitleCaptions[1] := Lang[ID_CVS_IMPACTION];

    lblCOModule.Caption := Lang[ID_CVS_MODULE];
    chkCOModuleAs.Caption := Lang[ID_CVS_COAS];
    lblCODir.Caption := Lang[ID_CVS_CODIR];
    chkCOrecurse.Caption := Lang[ID_CVS_RECURSE];
    chkCOBeforeDate.Caption := Lang[ID_CVS_BEFOREDATE];
    chkCORevision.Caption := Lang[ID_CVS_REVISION];
    chkCOMostRecent.Caption := Lang[ID_CVS_GETMOSTRECENT];

    lblCommitMsg.Caption := Lang[ID_CVS_LOGMSG];

    chkUpdRecurse.Caption := Lang[ID_CVS_RECURSE];
    chkUpdResetSticky.Caption := Lang[ID_CVS_RESETSTICKY];
    chkUpdCreateDirs.Caption := Lang[ID_CVS_CREATEDIRS];
    chkUpdPrune.Caption := Lang[ID_CVS_PRUNEEMPTY];
    chkUpdCleanCopy.Caption := Lang[ID_CVS_GETCLEAN];
    chkBeforeDate.Caption := Lang[ID_CVS_BEFOREDATE];
    chkRevision.Caption := Lang[ID_CVS_REVISION];
    chkMostRecent.Caption := Lang[ID_CVS_GETMOSTRECENT];
    grpUpdRevisions.Caption := Lang[ID_CVS_OTHERREVISIONS];

    chkDiffRecurse.Caption := Lang[ID_CVS_RECURSE];
    chkDiffUnified.Caption := Lang[ID_CVS_DIFFUNIFIED];
    grpDiff.Caption := Lang[ID_CVS_OTHERREVISIONS];
    rgbDiff.Caption := Lang[ID_CVS_DIFF1];
    rgbDiff1.Caption := Lang[ID_CVS_DIFF2];
    rgbDiff2.Caption := Lang[ID_CVS_DIFF3];
    lblDiffRev1.Caption := Lang[ID_CVS_REVISION] + ' 1';
    lblDiffRev2.Caption := Lang[ID_CVS_REVISION] + ' 2';
    chkDiffDate1.Caption := Lang[ID_CVS_ISDATE];
    chkDiffDate2.Caption := Lang[ID_CVS_ISDATE];

    chkLogRecurse.Caption := Lang[ID_CVS_RECURSE];
    chkLogDefBranch.Caption := Lang[ID_CVS_LOGDEFBRANCH];
    chkLogRCS.Caption := Lang[ID_CVS_LOGRCS];
    chkLogNoTag.Caption := Lang[ID_CVS_LOGNOTAG];
    grpLogFilter.Caption := Lang[ID_CVS_LOGFILTER];
    chkLogFbyRev.Caption := Lang[ID_CVS_LOGBYREV];
    chkLogFbyDate.Caption := Lang[ID_CVS_LOGBYDATE];
    chkLogFbyUser.Caption := Lang[ID_CVS_LOGBYUSER];

    lblAddMsg.Caption := Lang[ID_CVS_LOGMSG];

    chkRemove.Caption := Lang[ID_CVS_REMOVEFILE];

    lblRep.Caption := Lang[ID_CVS_REPOSITORY];
    grpRepDetails.Caption := Lang[ID_CVS_REPDETAILS];
    lblMethod.Caption := Lang[ID_CVS_REPMETHOD];
    lblUser.Caption := Lang[ID_CVS_REPUSER];
    lblServer.Caption := Lang[ID_CVS_REPSERVER];
    lblDir.Caption := Lang[ID_CVS_REPDIR];

    lblCompression.Caption := Lang[ID_ENV_CVSCOMPR];
    chkUseSSH.Caption := Lang[ID_ENV_CVSUSESSH];

    lblFiles.Caption := Lang[ID_NEWTPL_PAGEFILES] + ':';

    btnOK.Caption := Lang[ID_BTN_OK];
    btnCancel.Caption := Lang[ID_BTN_CLOSE];
End;

Procedure TCVSForm.FormCreate(Sender: TObject);
Begin
    fFiles := TStringList.Create;
    fAllFiles := TStringList.Create;
End;

Procedure TCVSForm.FormDestroy(Sender: TObject);
Begin

    If Assigned(fAllFiles) Then
        FreeAndNil(fAllFiles)
    Else
        fAllFiles := Nil;

    If Assigned(fFiles) Then
        FreeAndNil(fFiles)
    Else
        fFiles := Nil;

End;

Procedure TCVSForm.FindModifiedFiles;
    Function GetFileTimeStr(Filename: String): String;
    Var
        d: TDateTime;
        hFile: THandle;
        st: SYSTEMTIME;
        tz: TTimeZoneInformation;
        ft: TFileTime;
        daystr, monthstr: Array[0..16] Of Char;
    Begin
        hFile := FileOpen(Filename, fmOpenRead);
        Try
            GetFileTime(hFile, Nil, Nil, @ft);
            FileTimeToSystemTime(ft, st);
            d := SystemTimeToDateTime(st);
            GetTimeZoneInformation(tz);
        Finally
            FileClose(hFile);
        End;

        GetLocaleInfo($0409, LOCALE_SABBREVDAYNAME1 + DayOfWeek(d) -
            2, daystr, sizeof(daystr));
        GetLocaleInfo($0409, LOCALE_SABBREVMONTHNAME1 + MonthOfTheYear(d) -
            1, monthstr, sizeof(monthstr));

        Result := FormatDateTime('dd hh:nn:ss yyyy', d);
        Result := Format('%s %s %s', [daystr, monthstr, Result]);
    End;
Var
    I, idx: Integer;
    sl: TStringList;
    fname, dstr, S, prefix: String;
    modif: Integer;
Begin
    { Not implemented yet }
    Exit;

    If Not FileExists('CVS\Entries') Then
        Exit;
    If fFiles.Count > 0 Then
        prefix := IncludeTrailingPathDelimiter(ExtractFilePath(fFiles[0]));
    sl := TStringList.Create;
    Try
        sl.LoadFromFile('CVS\Entries');
        For I := 0 To sl.Count - 1 Do
        Begin
            S := sl[I];

            idx := Pos('/', S); // find /
            If idx = 0 Then
                Continue;
            Delete(S, 1, idx);
            // the filename is here
            idx := Pos('/', S); // find /
            If idx = 0 Then
                Continue;
            fname := Copy(S, 1, idx - 1); //fname
            Delete(S, 1, idx);
            idx := Pos('/', S); // find /
            If idx = 0 Then
                Continue;
            Delete(S, 1, idx);
            // the date is here
            idx := Pos('/', S); // find /
            If idx = 0 Then
                Continue;
            dstr := Copy(S, 1, idx - 1); //dstr

            idx := lstFiles.Items.IndexOf(prefix + fname);
            If idx > 0 Then
            Begin
                If GetFileTimeStr(prefix + fname) <> dstr Then
                    modif := 1
                Else
                    modif := 0;
                lstFiles.Items.Objects[idx] := Pointer(modif);
            End
            Else;
        End;
    Finally
        sl.Free;
    End;
End;

Procedure TCVSForm.lstFilesDrawItem(Control: TWinControl; Index: Integer;
    Rect: TRect; State: TOwnerDrawState);
Begin
    With lstFiles.Canvas Do
    Begin
        If lstFiles.Items.Objects[Index] = Pointer(1) Then //modified
            Font.Color := clRed;
        FillRect(Rect);
        TextOut(Rect.Left, Rect.Top, lstFiles.Items[Index]);
    End;
End;

Procedure TCVSForm.chkCORevisionClick(Sender: TObject);
Begin
    cmbCORevision.Enabled := chkCORevision.Checked;
    chkCOMostRecent.Enabled := chkCOBeforeDate.Checked Or chkCORevision.Checked;
End;

Procedure TCVSForm.chkCOBeforeDateClick(Sender: TObject);
Begin
    cmbCOBeforeDate.Enabled := chkCOBeforeDate.Checked;
    chkCOMostRecent.Enabled := chkCOBeforeDate.Checked Or chkCORevision.Checked;
End;

End.
