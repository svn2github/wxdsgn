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


{object OpenDialog: TOpenDialog
    Filter =
      'Dev-C++ project files|*.dev|C and C++ files|*.c;*.cpp|C++ files|' +
      '*.cpp|C files|*.c|Header files|*.h|C++ Header files|*.hpp|Resour' +
      'ce header|*.rh|Resource files|*.rc|Dev-C++ Project, C/C++ and re' +
      'source files|*.c;*.cpp;*.dev;*.rc|All files (*.*)|*.*'
    FilterIndex = 9
    Options = [ofHideReadOnly, ofNoChangeDir, ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Open file'
    Left = 149
    Top = 378
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'cpp'
    Filter = 'Dev-C++ project file (*.dev)|*.dev'
    Options = [ofHideReadOnly, ofNoChangeDir, ofPathMustExist, ofCreatePrompt, ofNoReadOnlyReturn, ofEnableSizing, ofDontAddToRecent]
    Title = 'Create new project'
    Left = 500
    Top = 241
  end
  }

constructor TOpenDialogEx.Create(AOwner: TWinControl);
begin
    ParentWND := AOwner;
    DefaultExt := '';
    Filter := '';
    InitialDir := '';
    Title := '';
    FileName := '';

    OpenDialog := TOpenDialog.Create(ParentWND);
    OpenDialog.Filter := 'Dev-C++ project files|*.dev|C and C++ files|*.c;*.cpp|C++ files|' +
      '*.cpp|C files|*.c|Header files|*.h|C++ Header files|*.hpp|Resour' +
      'ce header|*.rh|Resource files|*.rc|Dev-C++ Project, C/C++ and re' +
      'source files|*.c;*.cpp;*.dev;*.rc|All files (*.*)|*.*';
    OpenDialog.FilterIndex := 9;
    OpenDialog.Options := [ofHideReadOnly, ofNoChangeDir, ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofEnableSizing];
    OpenDialog.Title := 'Open file';
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
    SaveDialog.DefaultExt := 'cpp';
    SaveDialog.Filter := 'Dev-C++ project file (*.dev)|*.dev';
    SaveDialog.Options := [ofHideReadOnly, ofNoChangeDir, ofPathMustExist, ofCreatePrompt, ofNoReadOnlyReturn, ofEnableSizing, ofDontAddToRecent];
    SaveDialog.Title := 'Create new project';
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
        Result := SaveDialog.Execute;
    end;

end;


end.
