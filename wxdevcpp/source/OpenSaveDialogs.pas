Unit OpenSaveDialogs;

Interface

Uses
    Windows, Controls, SysUtils, Classes, Dialogs, Forms, ShellAPI, ShlObj;

Type
    TOpenDialogEx = Class(TObject)

        Options: TOpenOptions;
        OptionsEx: TOpenOptionsEx;

    Private
        OpenDialog: TOpenDialog;
        ParentWND: TWinControl;

    Public

        Title: String;
        Filter: String;
        DefaultExt: String;
        InitialDir: String;
        FileName: TFileName;
        Files: TStrings;
        FilterIndex: Integer;
        HistoryList: TStrings;
        Function Execute: Boolean;
        Constructor Create(AOwner: TWinControl);
        Destructor Destroy; Override;
    End;

Type
    TSaveDialogEx = Class(TObject)
        Options: TOpenOptions;
        OptionsEx: TOpenOptionsEx;
    Private
        SaveDialog: TSaveDialog;
        ParentWND: TWinControl;
    Public

        Title: String;
        Filter: String;
        DefaultExt: String;
        InitialDir: String;
        FileName: TFileName;
        Files: TStrings;
        FilterIndex: Integer;
        HistoryList: TStrings;
        Function Execute: Boolean;
        Constructor Create(AOwner: TWinControl);
        Destructor Destroy; Override;
    End;

Function BrowseDialogCallBack(Wnd: HWND; uMsg: UINT;
    lParam, lpData: LPARAM): Integer Stdcall;

Function BrowseDialog(Const Title: String; Const Flag: Integer;
    Const initialFolder: String = ''): String;

Implementation

Uses
    uvista;

Var
    lg_StartFolder: String;

Constructor TOpenDialogEx.Create(AOwner: TWinControl);
Begin
    ParentWND := AOwner;
    DefaultExt := '';
    Filter := '';
    InitialDir := '';
    Title := '';
    FileName := '';
    Files := TStringList.Create;

    OpenDialog := TOpenDialog.Create(ParentWND);
End;


Function TOpenDialogEx.Execute: Boolean;
Var
    fileN: String;
Begin

    If IsWindowsVista Then
    Begin
        fileN := FileName;
        Result := OpenSaveFileDialog(ParentWND, DefaultExt,
            Filter, InitialDir, Title, fileN, Files, FilterIndex,
            (ofReadOnly In Options),
            (ofOverwritePrompt In Options),
            (ofHideReadOnly In Options),
            (ofNoChangeDir In Options),
            (ofShowHelp In Options),
            (ofNoValidate In Options),
            (ofAllowMultiSelect In Options),
            (ofExtensionDifferent In Options),
            (ofPathMustExist In Options),
            (ofFileMustExist In Options),
            (ofCreatePrompt In Options),
            (ofShareAware In Options),
            (ofNoReadOnlyReturn In Options),
            (ofNoTestFileCreate In Options),
            (ofNoNetworkButton In Options),
            (ofNoLongNames In Options),
            (ofOldStyleDialog In Options),
            (ofNoDereferenceLinks In Options),
            (ofEnableIncludeNotify In Options),
            (ofEnableSizing In Options),
            (ofDontAddToRecent In Options),
            True);
        FileName := fileN;
    End
    Else
    Begin
        OpenDialog.DefaultExt := DefaultExt;
        OpenDialog.Filter := Filter;
        OpenDialog.InitialDir := InitialDir;
        OpenDialog.Title := Title;
        OpenDialog.FileName := FileName;
        OpenDialog.FilterIndex := FilterIndex;
        OpenDialog.Options := Options;

        Result := OpenDialog.Execute;
        FileName := OpenDialog.FileName;
        Files := OpenDialog.Files;
    End;

End;

Destructor TOpenDialogEx.Destroy;
Begin
    Files.Free;
    OpenDialog.Free;
End;

Constructor TSaveDialogEx.Create(AOwner: TWinControl);
Begin
    ParentWND := AOwner;
    DefaultExt := '';
    Filter := '';
    InitialDir := '';
    Title := '';
    FileName := '';
    Files := TStringList.Create;

    SaveDialog := TSaveDialog.Create(ParentWND);

End;

Function TSaveDialogEx.Execute: Boolean;
Var
    fileN: String;
Begin

    If IsWindowsVista Then
    Begin
        fileN := FileName;
        Result := OpenSaveFileDialog(ParentWND, DefaultExt,
            Filter, InitialDir, Title, fileN, Files, FilterIndex,
            (ofReadOnly In Options),
            (ofOverwritePrompt In Options),
            (ofHideReadOnly In Options),
            (ofNoChangeDir In Options),
            (ofShowHelp In Options),
            (ofNoValidate In Options),
            (ofAllowMultiSelect In Options),
            (ofExtensionDifferent In Options),
            (ofPathMustExist In Options),
            (ofFileMustExist In Options),
            (ofCreatePrompt In Options),
            (ofShareAware In Options),
            (ofNoReadOnlyReturn In Options),
            (ofNoTestFileCreate In Options),
            (ofNoNetworkButton In Options),
            (ofNoLongNames In Options),
            (ofOldStyleDialog In Options),
            (ofNoDereferenceLinks In Options),
            (ofEnableIncludeNotify In Options),
            (ofEnableSizing In Options),
            (ofDontAddToRecent In Options),
            False);
        FileName := fileN;
    End
    Else
    Begin
        SaveDialog.DefaultExt := DefaultExt;
        SaveDialog.Filter := Filter;
        SaveDialog.InitialDir := InitialDir;
        SaveDialog.Title := Title;
        SaveDialog.FileName := FileName;
        SaveDialog.FilterIndex := FilterIndex;
        SaveDialog.Options := Options;

        Result := SaveDialog.Execute;
        FileName := SaveDialog.FileName;
        Files := SaveDialog.Files;
    End;

End;

Destructor TSaveDialogEx.Destroy;
Begin
    Files.Free;
    SaveDialog.Free;
End;


Function BrowseDialogCallBack(Wnd: HWND; uMsg: UINT;
    lParam, lpData: LPARAM): Integer Stdcall;
Var
    wa, rect: TRect;
    dialogPT: TPoint;
Begin
    //center in work area
    If uMsg = BFFM_INITIALIZED Then
    Begin
        SendMessage(Wnd, BFFM_SETSELECTION, 1, Integer(@lg_StartFolder[1]));
        wa := Screen.WorkAreaRect;
        GetWindowRect(Wnd, Rect);
        dialogPT.X := ((wa.Right - wa.Left) Div 2) -
            ((rect.Right - rect.Left) Div 2);
        dialogPT.Y := ((wa.Bottom - wa.Top) Div 2) -
            ((rect.Bottom - rect.Top) Div 2);
        MoveWindow(Wnd,
            dialogPT.X,
            dialogPT.Y,
            Rect.Right - Rect.Left,
            Rect.Bottom - Rect.Top,
            True);
    End;

    Result := 0;
End; (*BrowseDialogCallBack*)

Function BrowseDialog(Const Title: String; Const Flag: Integer;
    Const initialFolder: String = ''): String;
Var
    lpItemID: PItemIDList;
    BrowseInfo: TBrowseInfo;
    DisplayName: Array[0..MAX_PATH] Of Char;
    TempPath: Array[0..MAX_PATH] Of Char;
Begin
    Result := '';
    FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
    With BrowseInfo Do
    Begin
        hwndOwner := Application.Handle;
        lg_StartFolder := initialFolder;
        pszDisplayName := @DisplayName;
        lpszTitle := Pchar(Title);
        ulFlags := Flag;
        lpfn := BrowseDialogCallBack;
    End;
    lpItemID := SHBrowseForFolder(BrowseInfo);
    If lpItemId <> Nil Then
    Begin
        SHGetPathFromIDList(lpItemID, TempPath);
        Result := TempPath;
        GlobalFreePtr(lpItemID);
    End;
End;

End.
