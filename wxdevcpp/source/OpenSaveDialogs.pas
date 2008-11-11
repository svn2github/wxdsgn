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

    OpenDialog := TOpenDialog.Create(ParentWND);
end;


function TOpenDialogEx.Execute: Boolean;
var
    fileN: String;
begin

    if IsWindowsVista then
    begin
        fileN := FileName;
        Result := OpenSaveFileDialog(ParentWND, DefaultExt, Filter, InitialDir, Title, fileN, Files, false, false, false, true);
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
    end;

end;

constructor TSaveDialogEx.Create(AOwner: TWinControl);
begin
    ParentWND := AOwner;
    DefaultExt := '';
    Filter := '';
    InitialDir := '';
    Title := '';
    FileName := '';

    SaveDialog := TSaveDialog.Create(ParentWND);

end;

function TSaveDialogEx.Execute: Boolean;
var
    fileN: String;
begin

    if IsWindowsVista then
    begin
        fileN := FileName;
        Result := OpenSaveFileDialog(ParentWND, DefaultExt, Filter, InitialDir, Title, fileN, Files, false, false, false, false);
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
    end;

end;


end.
