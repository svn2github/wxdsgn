Unit FilesReloadFrm;

Interface

Uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, CheckLst, XPMenu, devMonitorTypes, ComCtrls, ExtCtrls;

Type
    TFilesReloadFrm = Class(TForm)
        lblTitle: TLabel;
        btnOK: TButton;
        btnClose: TButton;
        XPMenu: TXPMenu;
        ctlFiles: TPageControl;
        tabModified: TTabSheet;
        tabDeleted: TTabSheet;
        lbModified: TCheckListBox;
        lblModified: TLabel;
        lbDeleted: TListBox;
        pnlModifiedSelectAll: TPanel;
        chkSelectAll: TCheckBox;
        Procedure FormCreate(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Procedure lbModifiedClickCheck(Sender: TObject);
        Procedure chkSelectAllClick(Sender: TObject);
    Private
        { Private declarations }
        ReloadFilenames: TList;
        CheckedItems: Integer;

        Procedure SetFilenames(Files: TList);
    Public
        { Public declarations }
        Property Files: TList Read ReloadFilenames Write SetFilenames;
    End;

    PReloadFile = ^TReloadFile;
    TReloadFile = Packed Record
        FileName: String;
        ChangeType: TdevMonitorChangeType;
    End;
Var
    FilesReloadForm: TFilesReloadFrm;

Implementation
Uses
    devcfg;
{$R *.dfm}

Procedure TFilesReloadFrm.FormCreate(Sender: TObject);
Begin
    XPMenu.Active := devData.XPTheme;
    ReloadFilenames := TList.Create;
    DesktopFont := True;
    CheckedItems := 0;
End;

Procedure TFilesReloadFrm.FormDestroy(Sender: TObject);
Begin
    ReloadFilenames.Free;
End;

Procedure TFilesReloadFrm.SetFilenames(Files: TList);
Var
    I, Idx: Integer;
Begin
    ReloadFilenames.Assign(Files);
    For I := 0 To ReloadFilenames.Count - 1 Do
        With PReloadFile(Files[I])^ Do
            If ChangeType = mctDeleted Then
            Begin
                Idx := lbDeleted.Items.IndexOf(FileName);
                If Idx = -1 Then
                    lbDeleted.Items.Add(FileName);
            End
            Else
            Begin
                Idx := lbModified.Items.IndexOf(FileName);
                If Idx = -1 Then
                Begin
                    Inc(CheckedItems);
                    lbModified.Items.Add(FileName);
                    lbModified.Checked[lbModified.Count - 1] := True;
                End;
            End;

    If CheckedItems = lbModified.Count Then
        chkSelectAll.State := cbChecked
    Else
    If CheckedItems = 0 Then
        chkSelectAll.State := cbUnchecked
    Else
        chkSelectAll.State := cbGrayed;
End;

Procedure TFilesReloadFrm.lbModifiedClickCheck(Sender: TObject);
Var
    I: Integer;
Begin
    CheckedItems := 0;
    For I := 0 To lbModified.Count - 1 Do
        If lbModified.Checked[I] Then
            Inc(CheckedItems);

    If CheckedItems = lbModified.Count Then
        chkSelectAll.State := cbChecked
    Else
    If CheckedItems = 0 Then
        chkSelectAll.State := cbUnchecked
    Else
        chkSelectAll.State := cbGrayed;
End;

Procedure TFilesReloadFrm.chkSelectAllClick(Sender: TObject);
Var
    I: Integer;
Begin
    If chkSelectAll.State = cbChecked Then
        For I := 0 To lbModified.Count - 1 Do
            lbModified.Checked[I] := True
    Else
    If chkSelectAll.State = cbUnchecked Then
        For I := 0 To lbModified.Count - 1 Do
            lbModified.Checked[I] := False;
End;

End.
