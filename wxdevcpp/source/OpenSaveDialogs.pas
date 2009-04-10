unit OpenSaveDialogs;

interface

uses
    Windows, Controls, SysUtils, Classes, Dialogs, Forms, ShellAPI, ShlObj;

type
    TOpenDialogEx = class(TObject)

    Options: TOpenOptions;
    OptionsEx: TOpenOptionsEx;

private
    OpenDialog: TOpenDialog;
    ParentWND: TWinControl;

public

    Title: String;
    Filter: String;
    DefaultExt: String;
    InitialDir: String;
    FileName: TFileName;
    Files: TStrings;
    FilterIndex: Integer;
    HistoryList: TStrings;
    function Execute: Boolean;
    constructor Create(AOwner: TWinControl);
    destructor Destroy; override;
end;

type
    TSaveDialogEx = class(TObject)
    Options: TOpenOptions;
    OptionsEx: TOpenOptionsEx;
private
    SaveDialog: TSaveDialog;
    ParentWND: TWinControl;
public

    Title: String;
    Filter: String;
    DefaultExt: String;
    InitialDir: String;
    FileName: TFileName;
    Files: TStrings;
    FilterIndex: Integer;
    HistoryList: TStrings;
    function Execute: Boolean;
    constructor Create(AOwner: TWinControl);
    destructor Destroy; override;
end;

function BrowseDialogCallBack(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): integer stdcall;

function BrowseDialog(const Title: string; const Flag: integer; const initialFolder: String = '' ): string;

implementation

uses
    uvista;

var
  lg_StartFolder: String;

constructor TOpenDialogEx.Create(AOwner: TWinControl);
begin
    ParentWND := AOwner;
    DefaultExt := '';
    Filter := '';
    InitialDir := '';
    Title := '';
    FileName := '';
    Files := TStringList.Create;

    OpenDialog := TOpenDialog.Create(ParentWND);
end;


function TOpenDialogEx.Execute: Boolean;
var
    fileN: String;
begin

    if IsWindowsVista then
    begin
        fileN := FileName;
        Result := OpenSaveFileDialog(ParentWND, DefaultExt, Filter, InitialDir, Title, fileN, Files, FilterIndex,
            (ofReadOnly in Options),
            (ofOverwritePrompt in Options),
            (ofHideReadOnly in Options),
            (ofNoChangeDir in Options),
            (ofShowHelp in Options),
            (ofNoValidate in Options),
            (ofAllowMultiSelect in Options),
            (ofExtensionDifferent in Options),
            (ofPathMustExist in Options),
            (ofFileMustExist in Options),
            (ofCreatePrompt in Options),
            (ofShareAware in Options),
            (ofNoReadOnlyReturn in Options),
            (ofNoTestFileCreate in Options),
            (ofNoNetworkButton in Options),
            (ofNoLongNames in Options),
            (ofOldStyleDialog in Options),
            (ofNoDereferenceLinks in Options),
            (ofEnableIncludeNotify in Options),
            (ofEnableSizing in Options),
            (ofDontAddToRecent in Options),
            true);
        FileName := fileN;
    end
    else
    begin
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
    end;

end;

destructor TOpenDialogEx.Destroy;
begin
    Files.Free;
    OpenDialog.Free;
end;

constructor TSaveDialogEx.Create(AOwner: TWinControl);
begin
    ParentWND := AOwner;
    DefaultExt := '';
    Filter := '';
    InitialDir := '';
    Title := '';
    FileName := '';
    Files := TStringList.Create;

    SaveDialog := TSaveDialog.Create(ParentWND);

end;

function TSaveDialogEx.Execute: Boolean;
var
    fileN: String;
begin

    if IsWindowsVista then
    begin
        fileN := FileName;
        Result := OpenSaveFileDialog(ParentWND, DefaultExt, Filter, InitialDir, Title, fileN, Files, FilterIndex,
            (ofReadOnly in Options),
            (ofOverwritePrompt in Options),
            (ofHideReadOnly in Options),
            (ofNoChangeDir in Options),
            (ofShowHelp in Options),
            (ofNoValidate in Options),
            (ofAllowMultiSelect in Options),
            (ofExtensionDifferent in Options),
            (ofPathMustExist in Options),
            (ofFileMustExist in Options),
            (ofCreatePrompt in Options),
            (ofShareAware in Options),
            (ofNoReadOnlyReturn in Options),
            (ofNoTestFileCreate in Options),
            (ofNoNetworkButton in Options),
            (ofNoLongNames in Options),
            (ofOldStyleDialog in Options),
            (ofNoDereferenceLinks in Options),
            (ofEnableIncludeNotify in Options),
            (ofEnableSizing in Options),
            (ofDontAddToRecent in Options),
            false);
        FileName := fileN;
    end
    else
    begin
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
    end;

end;

destructor TSaveDialogEx.Destroy;
begin
    Files.Free;
    SaveDialog.Free;
end;


function BrowseDialogCallBack(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): integer stdcall;
var
  wa, rect : TRect;
  dialogPT : TPoint;
begin
  //center in work area
  if uMsg = BFFM_INITIALIZED then
  begin
    SendMessage(Wnd,BFFM_SETSELECTION, 1, Integer(@lg_StartFolder[1]));
    wa := Screen.WorkAreaRect;
    GetWindowRect(Wnd, Rect);
    dialogPT.X := ((wa.Right-wa.Left) div 2) - 
                  ((rect.Right-rect.Left) div 2);
    dialogPT.Y := ((wa.Bottom-wa.Top) div 2) - 
                  ((rect.Bottom-rect.Top) div 2);
    MoveWindow(Wnd,
               dialogPT.X,
               dialogPT.Y,
               Rect.Right - Rect.Left,
               Rect.Bottom - Rect.Top,
               True);
  end;

  Result := 0;
end; (*BrowseDialogCallBack*)

function BrowseDialog(const Title: string; const Flag: integer; const initialFolder: String = '' ): string;
var
  lpItemID : PItemIDList;
  BrowseInfo : TBrowseInfo;
  DisplayName : array[0..MAX_PATH] of char;
  TempPath : array[0..MAX_PATH] of char;
begin
  Result:='';
  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  with BrowseInfo do begin
    hwndOwner := Application.Handle;
    lg_StartFolder := initialFolder;
    pszDisplayName := @DisplayName;
    lpszTitle := PChar(Title);
    ulFlags := Flag;
    lpfn := BrowseDialogCallBack;
  end;
  lpItemID := SHBrowseForFolder(BrowseInfo);
  if lpItemId <> nil then begin
    SHGetPathFromIDList(lpItemID, TempPath);
    Result := TempPath;
    GlobalFreePtr(lpItemID);
  end;
end;

end.
