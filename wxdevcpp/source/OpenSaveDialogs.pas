unit OpenSaveDialogs;

interface

uses
    Controls, SysUtils, Classes, Dialogs;

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

implementation

uses
    uvista;

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

end.
