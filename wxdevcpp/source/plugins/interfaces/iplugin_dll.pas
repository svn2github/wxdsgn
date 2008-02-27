unit iplugin_dll;

interface

uses
    Classes, Forms, Windows, Controls, ComCtrls, ExtCtrls, ToolWin, iplugin;

type PHWND = ^HWND;

type

  IPlug_In_DLL = interface(IPlug_In) ['{4AC04F94-BEBC-4A17-AA98-23809EF78D0C}']
     procedure OnToolbarEvent(WM_COMMAND: Word);
end;

type

  TPlug_In_DLL = class(TComponent, IPlug_In_DLL)
  private
    parent: HWND;
    child: HWND;
    controlBar: TControlBar;
    owner: TWinControl;
    tool: TToolBar;
    button: TToolButton;
    plugin_name: String;
    C_CutExecute: procedure; stdcall;
    C_CopyExecute: procedure; stdcall;
    C_PasteExecute: procedure; stdcall;
    C_Destroy: procedure; stdcall;
    C_OnToolbarEvent: procedure(WM_COMMAND: Word); stdcall;
    C_SetBoolInspectorDataClear: procedure(b: Boolean); stdcall;
    C_SetDisablePropertyBuilding: procedure(b: Boolean); stdcall;
    C_IsCurrentPageDesigner: function: Boolean; stdcall;
    C_HasDesigner: function: Boolean; stdcall;

    C_SaveFileAndCloseEditor: function(s: PChar; b: Boolean): Boolean; stdcall;
    C_InitEditor: procedure(strFileName: PChar); stdcall;
    C_OpenFile: procedure(s: PChar); stdcall;
    C_OpenUnit: procedure(s: PChar); stdcall;
    C_IsForm: function(s: PChar): Boolean; stdcall;
    C_SaveFile: function(s: PChar; var b: Boolean): Boolean; stdcall;
    C_IsSource: function(FileName: PChar): Boolean; stdcall;
    C_GetDefaultText: function(FileName: PChar): PChar; stdcall;
    C_GetFilter: function(editorName: PChar): PChar; stdcall;
    C_Get_EXT: function(editorName: PChar): PChar; stdcall;
    C_GenerateXPM: procedure(s:PChar; b: Boolean); stdcall;
    C_CreateNewXPMs: procedure(s:PChar); stdcall;
    C_NewProject: procedure(s: PChar); stdcall;
    C_MainPageChanged: function(askIfShouldGetFocus: Boolean; FileName: PChar): Boolean; stdcall;	
    C_IsCurrentEditorInPlugin: function(FileName: PChar; curFilename: PChar): Boolean; stdcall;

    C_Reload: procedure(FileName: PChar); stdcall;
    C_ReloadForm: function(FileName: PChar): Boolean; stdcall;
    C_ReloadFromFile: procedure(FileName: PChar; fileToReloadFrom: PChar); stdcall;
    C_TerminateEditor: procedure(FileName: PChar); stdcall;
    C_Retrieve_Form_Items: function: PHWND; stdcall;
    C_Retrieve_Tabbed_LeftDock_Panels: function: PHWND; stdcall;
    C_Retrieve_LeftDock_Panels: function: PHWND; stdcall;
    C_Retrieve_Toolbars: function(_hwnd: HWND): HWND; stdcall;
    C_ConvertLibsToCurrentVersion: function(strValue: PChar): PChar; stdcall;
    C_GetXMLExtension: function: PChar; stdcall;
	C_EditorDisplaysText: function(FileName: PChar): Boolean; stdcall;
	C_GetTextHighlighterType: function(FileName: PChar): PChar; stdcall;
	C_GET_COMMON_CPP_INCLUDE_DIR: function: PChar; stdcall;  // EAB TODO: Generalize this.
    C_GetCompilerMacros: function: PChar; stdcall;
    C_GetCompilerPreprocDefines: function: PChar; stdcall;

    C_LoadCompilerSettings: procedure(name: PChar; value: PChar); stdcall;
    C_LoadCompilerOptions: procedure; stdcall;
    C_SaveCompilerOptions: procedure; stdcall;
    C_GetCompilerOptions: function: PChar; stdcall;
    C_SetCompilerOptionstoDefaults: procedure; stdcall;

  public
    procedure Initialize(name: String; module: HModule; _parent: HWND; _controlBar: TControlBar; _owner: TForm; Config: String; toolbar_x: Integer; toolbar_y: Integer);
    procedure CutExecute;
    procedure CopyExecute;
    procedure PasteExecute;
    procedure Destroy;
    procedure OnToolbarEvent(WM_COMMAND: Word);
    procedure SetBoolInspectorDataClear(b: Boolean);
    procedure SetDisablePropertyBuilding(b: Boolean);	
    function IsCurrentPageDesigner: Boolean;
    function IsDelphiPlugin: Boolean;
    function GetChild: HWND;
    function HasDesigner(editorName: String): Boolean;
	
    function SaveFileAndCloseEditor(s: String; b: Boolean): Boolean;
    procedure InitEditor(strFileName: String);
    procedure OpenFile(s: String);
    procedure OpenUnit(s: String);
    function IsForm(s: String): Boolean;
    function SaveFile(s: String; var b: Boolean): Boolean;
    function IsSource(FileName: String): Boolean;
    function GetDefaultText(FileName: String): String;
    function GetFilter(editorName: String): String;
    function Get_EXT(editorName: String): String;
    procedure GenerateXPM(s:String; b: Boolean);
    procedure CreateNewXPMs(s:String);
    procedure NewProject(s: String);
    function MainPageChanged(askIfShouldGetFocus: Boolean; FileName: String): Boolean;
    function IsCurrentEditorInPlugin(FileName: String; curFilename: String): Boolean;
    procedure Reload(FileName: String);
    function  ReloadForm(FileName: String): Boolean;
    procedure ReloadFromFile(FileName: String; fileToReloadFrom: String);
    procedure TerminateEditor(FileName: String);
    function Retrieve_Form_Items: TList;
    function Retrieve_Tabbed_LeftDock_Panels: TList;
    function Retrieve_LeftDock_Panels: TList;
    function Retrieve_Toolbars: TToolBar;
    function GetPluginName: String;
    function ConvertLibsToCurrentVersion(strValue: String): String;
    function GetXMLExtension: String;
    function EditorDisplaysText(FileName: String): Boolean;
    function GetTextHighlighterType(FileName: String): String;
    function GET_COMMON_CPP_INCLUDE_DIR: String;  // EAB TODO: Generalize this.
    function GetCompilerMacros: String;
    function GetCompilerPreprocDefines: String;

    procedure LoadCompilerSettings(name: string; value: string);
    procedure LoadCompilerOptions;
    procedure SaveCompilerOptions;
    function GetCompilerOptions: TSettings;
    procedure SetCompilerOptionstoDefaults;
  end;

implementation

procedure TPlug_In_DLL.Initialize(name: String; module: HModule; _parent: HWND; _controlBar: TControlBar; _owner: TForm; Config: String; toolbar_x: Integer; toolbar_y: Integer);
begin
    parent := _parent;
    owner := _owner;
    controlBar := _controlBar;
    plugin_name := name;
    @C_CutExecute := GetProcAddress(module, 'CutExecute');
    @C_CopyExecute := GetProcAddress(module, 'CopyExecute');
    @C_PasteExecute := GetProcAddress(module, 'PasteExecute');
    @C_Destroy := GetProcAddress(module, 'Terminate');
    @C_OnToolbarEvent := GetProcAddress(module, 'OnToolbarEvent');
    @C_SetBoolInspectorDataClear := GetProcAddress(module, 'SetBoolInspectorDataClear');
    @C_SetDisablePropertyBuilding := GetProcAddress(module, 'SetDisablePropertyBuilding');
    @C_IsCurrentPageDesigner := GetProcAddress(module, 'IsCurrentPageDesigner');
    @C_HasDesigner := GetProcAddress(module, 'IsDesignerNil');

    @C_SaveFileAndCloseEditor := GetProcAddress(module, 'SaveFileAndCloseEditor');
    @C_InitEditor := GetProcAddress(module, 'InitEditor');
    @C_OpenFile := GetProcAddress(module, 'OpenFile');
    @C_OpenUnit := GetProcAddress(module, 'OpenUnit');
    @C_IsForm := GetProcAddress(module, 'IsForm');
    @C_SaveFile := GetProcAddress(module, 'SaveFile');
    @C_IsSource := GetProcAddress(module, 'IsSource');
    @C_GetDefaultText := GetProcAddress(module, 'GetDefaultText');
    @C_GetFilter := GetProcAddress(module, 'GetFilter');
    @C_Get_EXT := GetProcAddress(module, 'Get_EXT');
    @C_GenerateXPM := GetProcAddress(module, 'GenerateXPM');
    @C_CreateNewXPMs := GetProcAddress(module, 'CreateNewXPMs');
    @C_NewProject := GetProcAddress(module, 'NewProject');
    @C_MainPageChanged := GetProcAddress(module, 'MainPageChanged');
    @C_IsCurrentEditorInPlugin := GetProcAddress(module, 'IsCurrentEditorInPlugin');
    @C_Reload := GetProcAddress(module, 'Reload');
    @C_Reload := GetProcAddress(module, 'ReloadForm');
    @C_ReloadFromFile := GetProcAddress(module, 'ReloadFromFile');
    @C_TerminateEditor := GetProcAddress(module, 'TerminateEditor');
    @C_Retrieve_Form_Items := GetProcAddress(module, 'Retrieve_Form_Items');
    @C_Retrieve_Tabbed_LeftDock_Panels := GetProcAddress(module, 'Retrieve_Tabbed_LeftDock_Panels');
    @C_Retrieve_LeftDock_Panels := GetProcAddress(module, 'Retrieve_LeftDock_Panels');
    @C_Retrieve_Toolbars := GetProcAddress(module, 'Retrieve_Toolbars');
    @C_ConvertLibsToCurrentVersion := GetProcAddress(module, 'ConvertLibsToCurrentVersion');
    @C_GetXMLExtension := GetProcAddress(module, 'GetXMLExtension');
	@C_EditorDisplaysText := GetProcAddress(module, 'EditorDisplaysText');
	@C_GetTextHighlighterType := GetProcAddress(module, 'GetTextHighlighterType');
	@C_GET_COMMON_CPP_INCLUDE_DIR := GetProcAddress(module, 'GET_COMMON_CPP_INCLUDE_DIR');
    @C_GetCompilerMacros := GetProcAddress(module, 'GetCompilerMacros');
    @C_GetCompilerPreprocDefines := GetProcAddress(module, 'GetCompilerPreprocDefines');

    @C_LoadCompilerSettings := GetProcAddress(module, 'LoadCompilerSettings');
    @C_LoadCompilerOptions := GetProcAddress(module, 'LoadCompilerOptions');
    @C_SaveCompilerOptions := GetProcAddress(module, 'SaveCompilerOptions');
    @C_GetCompilerOptions := GetProcAddress(module, 'GetCompilerOptions');
    @C_SetCompilerOptionstoDefaults := GetProcAddress(module, 'SetCompilerOptionstoDefaults');

    tool := TToolBar.Create(nil);
    tool.Left:= toolbar_x;
    tool.Top:= toolbar_y;
    tool.AutoSize := true;
    tool.Visible := false;
    tool.Parent := owner;
    with TToolButton.Create(tool) do
    begin
        Parent := tool;
        Width := 23;
        Height := 22;
    end;
    tool.EdgeInner := esNone;
    tool.EdgeOuter := esNone;
    tool.Flat := true;
    child := C_Retrieve_Toolbars(tool.Handle);
    tool.Width := 70;    
end;

procedure TPlug_In_DLL.CutExecute;
begin
    C_CutExecute;
end;

procedure TPlug_In_DLL.CopyExecute;
begin
    C_CopyExecute;
end;

procedure TPlug_In_DLL.PasteExecute;
begin
    C_PasteExecute;
end;

procedure TPlug_In_DLL.Destroy;
begin
    C_Destroy;
end;

procedure TPlug_In_DLL.OnToolbarEvent(WM_COMMAND: Word);
begin
    C_OnToolbarEvent(WM_COMMAND);
end;

procedure TPlug_In_DLL.SetBoolInspectorDataClear(b: Boolean);
begin
    C_SetBoolInspectorDataClear(b);
end;

procedure TPlug_In_DLL.SetDisablePropertyBuilding(b: Boolean);
begin
    C_SetDisablePropertyBuilding(b);
end;

function TPlug_In_DLL.IsCurrentPageDesigner: Boolean;
begin
    Result := C_IsCurrentPageDesigner;
end;

function TPlug_In_DLL.IsDelphiPlugin: Boolean;
begin
    Result := False;
end;

function TPlug_In_DLL.HasDesigner(editorName: String): Boolean;
begin
    Result := False;
end;

function TPlug_In_DLL.SaveFileAndCloseEditor(s: String; b: Boolean): Boolean;
begin
    Result := C_SaveFileAndCloseEditor(PChar(s), b);
end;

procedure TPlug_In_DLL.InitEditor(strFileName: String);
begin
    C_InitEditor(PChar(strFileName));
end;

procedure TPlug_In_DLL.OpenFile(s: String);
begin
    C_OpenFile(PChar(s));
end;

procedure TPlug_In_DLL.OpenUnit(s: String);
begin
    OpenUnit(PChar(s));
end;

function TPlug_In_DLL.IsForm(s: String): Boolean;
begin
    Result := C_IsForm(PChar(s));
end;

function TPlug_In_DLL.SaveFile(s: String; var b: Boolean): Boolean;
begin
    Result := C_SaveFile(PChar(s), b); // EAB TODO: Check for the proper parameter for returning values in "b"
end;

function TPlug_In_DLL.IsSource(FileName: String): Boolean;
begin
    Result := C_IsSource(PChar(FileName));
end;

function TPlug_In_DLL.GetDefaultText(FileName: String): String;
var
    temp: PChar;
    res: String;
begin
    temp := PChar(FileName);
    temp := C_GetDefaultText(temp);
    res := temp;
    Result := res;
end;

function TPlug_In_DLL.GetFilter(editorName: String): String;
var
    temp: PAnsiChar;
    res: String;
begin
    temp := C_GetFilter(PAnsiChar(editorName));
    res := temp;
    Result := res;
end;

function TPlug_In_DLL.Get_EXT(editorName: String): String;
var
    temp: PChar;
    res: String;
begin
    temp := C_Get_EXT(PChar(editorName));
    res := temp;
    Result := res;
end;

procedure TPlug_In_DLL.GenerateXPM(s:String; b: Boolean);
begin
    C_GenerateXPM(PChar(s), b);
end;

procedure TPlug_In_DLL.CreateNewXPMs(s:String);
begin
    C_CreateNewXPMs(PChar(s));
end;

procedure TPlug_In_DLL.NewProject(s: String);
begin
    C_NewProject(PChar(s));
end;

function TPlug_In_DLL.MainPageChanged(askIfShouldGetFocus: Boolean; FileName: String): Boolean;
begin
    Result := C_MainPageChanged(askIfShouldGetFocus, PChar(FileName));
end;

function TPlug_In_DLL.IsCurrentEditorInPlugin(FileName: String; curFilename: String): Boolean;
begin
    Result := C_IsCurrentEditorInPlugin(PChar(FileName), PChar(curFilename));
end;

procedure TPlug_In_DLL.Reload(FileName: String);
begin
    C_Reload(PChar(FileName));
end;

function TPlug_In_DLL.ReloadForm(FileName: String): Boolean;
begin
    Result := C_ReloadForm(PChar(FileName));
end;

procedure TPlug_In_DLL.ReloadFromFile(FileName: String; fileToReloadFrom: String);
begin
    C_ReloadFromFile(PChar(FileName), PChar(fileToReloadFrom));
end;

procedure TPlug_In_DLL.TerminateEditor(FileName: String);
begin
    C_TerminateEditor(PChar(FileName));
end;

function TPlug_In_DLL.Retrieve_Form_Items: TList;
var
    temp: PHWND;
    res: TList;
    control: TWinControl;
begin
    temp := nil;
    temp := C_Retrieve_Tabbed_LeftDock_Panels;
    if temp <> nil then
    begin
      res := TList.Create;
      while temp <> nil do
      begin
        control := FindControl(temp^);
        if control <> nil then
          res.Add(control);
        Inc(temp);
      end;
      Result := res;
    end
    else
      Result := nil;
end;

function TPlug_In_DLL.Retrieve_Tabbed_LeftDock_Panels: TList;
var
    temp: PHWND;
    res: TList;
    control: TWinControl;
begin
    temp := nil;
    temp := C_Retrieve_Tabbed_LeftDock_Panels;
    if temp <> nil then
    begin
      res := TList.Create;
      while temp <> nil do
      begin
        control := FindControl(temp^);
        if control <> nil then
          res.Add(control);
        Inc(temp);
      end;
      Result := res;
    end
    else
      Result := nil;
end;

function TPlug_In_DLL.Retrieve_LeftDock_Panels: TList;
var
    temp: PHWND;
    res: TList;
    control: TWinControl;
begin
    temp := nil;
    temp := C_Retrieve_Tabbed_LeftDock_Panels;
    if temp <> nil then
    begin
      res := TList.Create;
      while temp <> nil do
      begin
        control := FindControl(temp^);
        if control <> nil then
          res.Add(control);
        Inc(temp);
      end;
      Result := res;
    end
    else
      Result := nil;
end;

function TPlug_In_DLL.Retrieve_Toolbars: TToolBar;
begin
    Result := tool;
end;

function TPlug_In_DLL.GetPluginName: String;
begin
    Result := plugin_name;
end;

function TPlug_In_DLL.GetChild: HWND;
begin
    Result := child;
end;

function TPlug_In_DLL.ConvertLibsToCurrentVersion(strValue: String): String;
var
    temp: PChar;
    res: String;
begin
    temp := C_ConvertLibsToCurrentVersion(PChar(strValue));
    res := temp;
    Result := res;
end;

function TPlug_In_DLL.GetXMLExtension: String;
var
    temp: PChar;
    res: String;
begin
    temp := C_GetXMLExtension;
    res := temp;
    Result := res;
end;

function TPlug_In_DLL.EditorDisplaysText(FileName: String): Boolean;
begin
    Result := C_EditorDisplaysText(PChar(FileName));
end;

function TPlug_In_DLL.GetTextHighlighterType(FileName: String): String;
var
    temp: PChar;
    res: String;
begin
    temp := C_GetTextHighlighterType(PChar(FileName));
    res := temp;
    Result := res;
end;

function TPlug_In_DLL.GET_COMMON_CPP_INCLUDE_DIR: String;  // EAB TODO: Generalize this.
var
    temp: PChar;
    res: String;
begin
    temp := C_GET_COMMON_CPP_INCLUDE_DIR;
    res := temp;
    Result := res;
end;

function TPlug_In_DLL.GetCompilerMacros: String;
var
    temp: PChar;
    res: String;
begin
    temp := C_GetCompilerMacros;
    res := temp;
    Result := res;
end;

function TPlug_In_DLL.GetCompilerPreprocDefines: String;
var
    temp: PChar;
    res: String;
begin
    temp := C_GetCompilerPreprocDefines;
    res := temp;
    Result := res;
end;

procedure TPlug_In_DLL.LoadCompilerSettings(name: String; value: String);
begin
    C_LoadCompilerSettings(PChar(name), PChar(value));
end;

procedure TPlug_In_DLL.LoadCompilerOptions;
begin
    C_LoadCompilerOptions;
end;

procedure TPlug_In_DLL.SaveCompilerOptions;
begin
    C_SaveCompilerOptions;
end;

function TPlug_In_DLL.GetCompilerOptions: TSettings;
var
    settings: TSettings;
begin
    settings := nil;
    //C_GetCompilerOptions; // EAB TODO: Add parsing logic to allocate name,value pairs returned from the dll C_ function
    Result := settings;
end;

procedure TPlug_In_DLL.SetCompilerOptionstoDefaults;
begin
    C_SetCompilerOptionstoDefaults;
end;

end.
