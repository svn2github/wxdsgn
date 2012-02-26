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
    plugin_name: String;
    C_TestReport: procedure(h: HWND); cdecl;
    C_CutExecute: procedure; cdecl;
    C_CopyExecute: procedure; cdecl;
    C_PasteExecute: procedure; cdecl;
    C_Destroy: procedure; cdecl;
    C_OnToolbarEvent: procedure(WM_COMMAND: Word); cdecl;
    C_SetBoolInspectorDataClear: procedure(b: Boolean); cdecl;
    C_SetDisablePropertyBuilding: procedure(b: Boolean); cdecl;
    C_HasDesigner: function: Boolean; cdecl;
    C_ManagesUnit: function: Boolean; cdecl;

    C_SaveFileAndCloseEditor: function(s: PChar): Boolean; cdecl;
    C_InitEditor: procedure(strFileName: PChar); cdecl;
    C_OpenFile: procedure(s: PChar); cdecl;
    C_OpenUnit: procedure(s: PChar); cdecl;
    C_IsForm: function(s: PChar): Boolean; cdecl;
    C_SaveFile: function(s: PChar): Boolean; cdecl;
    C_IsSource: function(FileName: PChar): Boolean; cdecl;
    C_GetDefaultText: function(FileName: PChar): PChar; cdecl;
    C_GetFilter: function(editorName: PChar): PChar; cdecl;
    C_Get_EXT: function(editorName: PChar): PChar; cdecl;
    C_CreateNewXPMs: procedure(s:PChar); cdecl;
    C_NewProject: procedure(s: PChar); cdecl;
    C_MainPageChanged: function(activeEditorName: PChar): Boolean; cdecl;
    C_ShouldNotCloseEditor: function(FileName: PChar; curFilename: PChar): Boolean; cdecl;

    C_Reload: procedure(FileName: PChar); cdecl;
    C_ReloadForm: function(FileName: PChar): Boolean; cdecl;
    C_ReloadFromFile: procedure(FileName: PChar; fileToReloadFrom: PChar); cdecl;
    C_TerminateEditor: procedure(FileName: PChar); cdecl;
    C_Retrieve_LeftDock_Panels: function: PHWND; cdecl;
    C_Retrieve_RightDock_Panels: function: PHWND; cdecl;
    C_Retrieve_BottomDock_Panels: function: PHWND; cdecl;
    C_Retrieve_Toolbars: function(_hwnd: HWND): HWND; cdecl;
    C_ConvertLibsToCurrentVersion: function(strValue: PChar): PChar; cdecl;
    C_GetXMLExtension: function: PChar; cdecl;
    C_EditorDisplaysText: function(FileName: PChar): Boolean; cdecl;
    C_GetTextHighlighterType: function(FileName: PChar): PChar; cdecl;
    C_GET_COMMON_CPP_INCLUDE_DIR: function: PChar; cdecl;  // EAB TODO: Generalize this.
    C_GetCompilerMacros: function: PChar; cdecl;
    C_GetCompilerPreprocDefines: function: PChar; cdecl;

    C_LoadCompilerSettings: procedure(name: PChar; value: PChar); cdecl;
    C_LoadCompilerOptions: procedure; cdecl;
    C_SaveCompilerOptions: procedure; cdecl;
    C_GetCompilerOptions: function: PChar; cdecl;
    C_SetCompilerOptionstoDefaults: procedure; cdecl;
    C_AfterStartupCheck: procedure; cdecl;
    C_FullScreenSwitch: procedure; cdecl;

    C_LoadText: procedure(force: Boolean); cdecl;
    C_GetContextForHelp: function: String; cdecl;

  public
    procedure TestReport;  
    procedure Initialize(name: String; module: HModule; _parent: HWND; _controlBar: TControlBar; _owner: TForm; Config: String; toolbar_x: Integer; toolbar_y: Integer);
    procedure CutExecute;
    procedure CopyExecute;
    procedure PasteExecute;
    procedure DestroyDLL;
    procedure OnToolbarEvent(WM_COMMAND: Word);
    procedure SetBoolInspectorDataClear(b: Boolean);
    procedure SetDisablePropertyBuilding(b: Boolean);
    function IsDelphiPlugin: Boolean;
    function ManagesUnit: Boolean;
    function GetChild: HWND;
    function HasDesigner(editorName: String): Boolean;

    function SaveFileAndCloseEditor(s: String): Boolean;
    procedure InitEditor(strFileName: String);
    procedure OpenFile(s: String);
    procedure OpenUnit(s: String);
    function IsForm(s: String): Boolean;
    function SaveFile(s: String): Boolean;
    function IsSource(FileName: String): Boolean;
    function GetDefaultText(FileName: String): String;
    function GetFilter(editorName: String): String;
    function Get_EXT(editorName: String): String;
    function Get_EXT_Index(editorName: String): Integer;
    procedure CreateNewXPMs(s:String);
    procedure NewProject(s: String);
    function MainPageChanged(activeEditorName: String): Boolean;
    function ShouldNotCloseEditor(FileName: String; curFilename: String): Boolean;
    procedure Reload(FileName: String);
    function  ReloadForm(FileName: String): Boolean;
    procedure ReloadFromFile(FileName: String; fileToReloadFrom: String);
    procedure TerminateEditor(FileName: String);
    function Retrieve_LeftDock_Panels: TList;
    function Retrieve_RightDock_Panels: TList;
    function Retrieve_BottomDock_Panels: TList;
    function Retrieve_Toolbars: TToolBar;
    procedure SetEditorName(currentName:String; newName: string);
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
    procedure AfterStartupCheck;
    procedure FullScreenSwitch;

    procedure LoadText(force:Boolean);
    function GetContextForHelp: String;

  end;

implementation

procedure TPlug_In_DLL.Initialize(name: String; module: HModule; _parent: HWND; _controlBar: TControlBar; _owner: TForm; Config: String; toolbar_x: Integer; toolbar_y: Integer);
begin
  self.parent := _parent;
  self.owner := _owner;
  self.controlBar := _controlBar;
  self.plugin_name := name;

    @self.C_TestReport := nil;
    @self.C_CutExecute := nil;
    @self.C_CopyExecute := nil;
    @self.C_PasteExecute := nil;
    @self.C_Destroy := nil;
    @self.C_OnToolbarEvent := nil;
    @self.C_SetBoolInspectorDataClear := nil;
    @self.C_SetDisablePropertyBuilding := nil;
    @self.C_HasDesigner := nil;
    @self.C_ManagesUnit := nil;

    @self.C_SaveFileAndCloseEditor := nil;
    @self.C_InitEditor := nil;
    @self.C_OpenFile := nil;
    @self.C_OpenUnit := nil;
    @self.C_IsForm := nil;
    @self.C_SaveFile := nil;
    @self.C_IsSource := nil;
    @self.C_GetDefaultText := nil;
    @self.C_GetFilter := nil;
    @self.C_Get_EXT := nil;
    @self.C_CreateNewXPMs := nil;
    @self.C_NewProject := nil;
    @self.C_MainPageChanged := nil;
    @self.C_ShouldNotCloseEditor := nil;
    @self.C_Reload := nil;
    @self.C_ReloadForm := nil;
    @self.C_ReloadFromFile := nil;
    @self.C_TerminateEditor := nil;
    @self.C_Retrieve_LeftDock_Panels := nil;
    @self.C_Retrieve_RightDock_Panels := nil;
    @self.C_Retrieve_BottomDock_Panels := nil;
    @self.C_Retrieve_Toolbars := nil;
    @self.C_ConvertLibsToCurrentVersion := nil;
    @self.C_GetXMLExtension := nil;
    @self.C_EditorDisplaysText := nil;
    @self.C_GetTextHighlighterType := nil;
    @self.C_GET_COMMON_CPP_INCLUDE_DIR := nil;
    @self.C_GetCompilerMacros := nil;
    @self.C_GetCompilerPreprocDefines := nil;

    @self.C_LoadCompilerSettings := nil;
    @self.C_LoadCompilerOptions := nil;
    @self.C_SaveCompilerOptions := nil;
    @self.C_GetCompilerOptions := nil;
    @self.C_SetCompilerOptionstoDefaults := nil;
    @self.C_AfterStartupCheck := nil;
    @self.C_FullScreenSwitch := nil;
    @self.C_GetContextForHelp := nil;


    @self.C_TestReport := GetProcAddress(module, 'TestReport');
    @self.C_CutExecute := GetProcAddress(module, 'CutExecute');
    @self.C_CopyExecute := GetProcAddress(module, 'CopyExecute');
    @self.C_PasteExecute := GetProcAddress(module, 'PasteExecute');
    @self.C_Destroy := GetProcAddress(module, 'Terminate');
    @self.C_OnToolbarEvent := GetProcAddress(module, 'OnToolbarEvent');
    @self.C_SetBoolInspectorDataClear := GetProcAddress(module, 'SetBoolInspectorDataClear');
    @self.C_SetDisablePropertyBuilding := GetProcAddress(module, 'SetDisablePropertyBuilding');
    @self.C_HasDesigner := GetProcAddress(module, 'HasDesigner');
    @self.C_ManagesUnit := GetProcAddress(module, 'ManagesUnit');

    @self.C_SaveFileAndCloseEditor := GetProcAddress(module, 'SaveFileAndCloseEditor');
    @self.C_InitEditor := GetProcAddress(module, 'InitEditor');
    @self.C_OpenFile := GetProcAddress(module, 'OpenFile');
    @self.C_OpenUnit := GetProcAddress(module, 'OpenUnit');
    @self.C_IsForm := GetProcAddress(module, 'IsForm');
    @self.C_SaveFile := GetProcAddress(module, 'SaveFile');
    @self.C_IsSource := GetProcAddress(module, 'IsSource');
    @self.C_GetDefaultText := GetProcAddress(module, 'GetDefaultText');
    @self.C_GetFilter := GetProcAddress(module, 'GetFilter');
    @self.C_Get_EXT := GetProcAddress(module, 'Get_EXT');
    @self.C_CreateNewXPMs := GetProcAddress(module, 'CreateNewXPMs');
    @self.C_NewProject := GetProcAddress(module, 'NewProject');
    @self.C_MainPageChanged := GetProcAddress(module, 'MainPageChanged');
    @self.C_ShouldNotCloseEditor := GetProcAddress(module, 'ShouldNotCloseEditor');
    @self.C_Reload := GetProcAddress(module, 'Reload');
    @self.C_ReloadForm := GetProcAddress(module, 'ReloadForm');
    @self.C_ReloadFromFile := GetProcAddress(module, 'ReloadFromFile');
    @self.C_TerminateEditor := GetProcAddress(module, 'TerminateEditor');
    @self.C_Retrieve_LeftDock_Panels := GetProcAddress(module, 'Retrieve_LeftDock_Panels');
    @self.C_Retrieve_RightDock_Panels := GetProcAddress(module, 'Retrieve_RightDock_Panels');
    @self.C_Retrieve_BottomDock_Panels := GetProcAddress(module, 'Retrieve_BottomDock_Panels');
    @self.C_Retrieve_Toolbars := GetProcAddress(module, 'Retrieve_Toolbars');
    @self.C_ConvertLibsToCurrentVersion := GetProcAddress(module, 'ConvertLibsToCurrentVersion');
    @self.C_GetXMLExtension := GetProcAddress(module, 'GetXMLExtension');
    @self.C_EditorDisplaysText := GetProcAddress(module, 'EditorDisplaysText');
    @self.C_GetTextHighlighterType := GetProcAddress(module, 'GetTextHighlighterType');
    @self.C_GET_COMMON_CPP_INCLUDE_DIR := GetProcAddress(module, 'GET_COMMON_CPP_INCLUDE_DIR');
    @self.C_GetCompilerMacros := GetProcAddress(module, 'GetCompilerMacros');
    @self.C_GetCompilerPreprocDefines := GetProcAddress(module, 'GetCompilerPreprocDefines');

    @self.C_LoadCompilerSettings := GetProcAddress(module, 'LoadCompilerSettings');
    @self.C_LoadCompilerOptions := GetProcAddress(module, 'LoadCompilerOptions');
    @self.C_SaveCompilerOptions := GetProcAddress(module, 'SaveCompilerOptions');
    @self.C_GetCompilerOptions := GetProcAddress(module, 'GetCompilerOptions');
    @self.C_SetCompilerOptionstoDefaults := GetProcAddress(module, 'SetCompilerOptionstoDefaults');
    @self.C_AfterStartupCheck := GetProcAddress(module, 'AfterStartupCheck');
    @self.C_FullScreenSwitch := GetProcAddress(module, 'FullScreenSwitch');

    @self.C_LoadText := GetProcAddress(module, 'LoadText');
    @self.C_GetContextForHelp := GetProcAddress(module, 'GetContextForHelp');


  self.tool := TToolBar.Create(nil);
  self.tool.Left := toolbar_x;
  self.tool.Top := toolbar_y;
  self.tool.AutoSize := true;
  self.tool.Visible := false;
  self.tool.Parent := _controlBar;
  with TToolButton.Create(self.tool) do
    begin
    Parent := self.tool;
        Width := 23;
        Height := 22;
    end;
  self.tool.EdgeInner := esNone;
  self.tool.EdgeOuter := esNone;
  self.tool.Flat := true;
  self.tool.Width := 70; //default value just to put a toolbar on the coolbar

    if (@self.C_Retrieve_Toolbars <> nil) then
    begin
        child := self.C_Retrieve_Toolbars(tool.Handle);
    self.tool.Visible := true; {mal testing}
end;

end;

procedure TPlug_In_DLL.TestReport;
begin
    if (@self.C_TestReport <> nil) then
        self.C_TestReport(parent);
end;

procedure TPlug_In_DLL.CutExecute;
begin
    if (@self.C_CutExecute <> nil) then
        self.C_CutExecute;
end;

procedure TPlug_In_DLL.CopyExecute;
begin
    if (@self.C_CopyExecute <> nil) then
        self.C_CopyExecute;
end;

procedure TPlug_In_DLL.PasteExecute;
begin
    if (@self.C_PasteExecute <> nil) then
        self.C_PasteExecute;
end;

Procedure TPlug_In_DLL.DestroyDLL;
begin
    if (@self.C_Destroy <> nil) then
        self.C_Destroy;
end;

procedure TPlug_In_DLL.OnToolbarEvent(WM_COMMAND: Word);
begin
    if (@self.C_OnToolbarEvent <> nil) then
        self.C_OnToolbarEvent(WM_COMMAND);
end;

procedure TPlug_In_DLL.SetBoolInspectorDataClear(b: Boolean);
begin
    if (@self.C_SetBoolInspectorDataClear <> nil) then
        self.C_SetBoolInspectorDataClear(b);
end;

procedure TPlug_In_DLL.SetDisablePropertyBuilding(b: Boolean);
begin
    if (@self.C_SetDisablePropertyBuilding <> nil) then
        self.C_SetDisablePropertyBuilding(b);
end;

function TPlug_In_DLL.IsDelphiPlugin: Boolean;
begin
    Result := False;
end;

function TPlug_In_DLL.HasDesigner(editorName: String): Boolean;
begin
    Result := False;
end;

function TPlug_In_DLL.ManagesUnit: Boolean;
begin
    if (@self.C_ManagesUnit <> nil) then
        Result := self.C_ManagesUnit
    else
        Result := False;
end;

function TPlug_In_DLL.SaveFileAndCloseEditor(s: String): Boolean;
begin
    if (@self.C_SaveFileAndCloseEditor <> nil) then
        Result := self.C_SaveFileAndCloseEditor(PChar(s))
    else
        Result := False;
end;

procedure TPlug_In_DLL.InitEditor(strFileName: String);
begin
    if (@self.C_InitEditor <> nil) then
        self.C_InitEditor(PChar(strFileName));
end;

procedure TPlug_In_DLL.OpenFile(s: String);
begin
    if (@self.C_OpenFile <> nil) then
        self.C_OpenFile(PChar(s));
end;

procedure TPlug_In_DLL.OpenUnit(s: String);
begin
  if (@self.C_OpenUnit <> nil) then
    self.C_OpenUnit(PChar(s));
end;

function TPlug_In_DLL.IsForm(s: String): Boolean;
begin
    if (@self.C_IsForm <> nil) then
        Result := self.C_IsForm(PChar(s))
    else
        Result := False;
end;

function TPlug_In_DLL.SaveFile(s: String): Boolean;
begin
    if (@self.C_SaveFile <> nil) then
        Result := self.C_SaveFile(PChar(s)) 
    else
        Result := False;
end;

function TPlug_In_DLL.IsSource(FileName: String): Boolean;
begin
    if (@self.C_IsSource <> nil) then
        Result := self.C_IsSource(PChar(FileName))
    else
        Result := False;
end;

function TPlug_In_DLL.GetDefaultText(FileName: String): String;
var
    temp: PChar;
    res: String;
begin
    temp := PChar(FileName);
    if (@self.C_GetDefaultText <> nil) then
        temp := self.C_GetDefaultText(temp);
    res := temp;
    Result := res;
end;

function TPlug_In_DLL.GetFilter(editorName: String): String;
var
    temp: PAnsiChar;
    res: String;
begin
    temp := '';
    if (@self.C_GetFilter <> nil) then
        temp := self.C_GetFilter(PAnsiChar(editorName));
    res := temp;
    Result := res;
end;

function TPlug_In_DLL.Get_EXT(editorName: String): String;
var
    temp: PChar;
    res: String;
begin
    temp := '';
    if (@self.C_Get_EXT <> nil) then
        temp := self.C_Get_EXT(PChar(editorName));
    res := temp;
    Result := res;
end;

function TPlug_In_DLL.Get_EXT_Index(editorName: String): Integer;
begin
    Result := 0;
end;

procedure TPlug_In_DLL.CreateNewXPMs(s:String);
begin
    if (@self.C_CreateNewXPMs <> nil) then
        self.C_CreateNewXPMs(PChar(s));
end;

procedure TPlug_In_DLL.NewProject(s: String);
begin
    if (@self.C_NewProject <> nil) then
        self.C_NewProject(PChar(s));
end;

function TPlug_In_DLL.MainPageChanged(activeEditorName: String): Boolean;
begin
    if (@self.C_MainPageChanged <> nil) then
        Result := self.C_MainPageChanged(PChar(activeEditorName))
    else
        Result := False;
end;

function TPlug_In_DLL.ShouldNotCloseEditor(FileName: String; curFilename: String): Boolean;
begin
    if (@self.C_ShouldNotCloseEditor <> nil) then
        Result := self.C_ShouldNotCloseEditor(PChar(FileName), PChar(curFilename))
    else
        Result := False;
end;

procedure TPlug_In_DLL.Reload(FileName: String);
begin
    if (@self.C_Reload <> nil) then
        self.C_Reload(PChar(FileName));
end;

function TPlug_In_DLL.ReloadForm(FileName: String): Boolean;
begin
    if (@self.C_ReloadForm <> nil) then
        Result := self.C_ReloadForm(PChar(FileName))
    else
        Result := False;
end;

procedure TPlug_In_DLL.ReloadFromFile(FileName: String; fileToReloadFrom: String);
begin
    if (@self.C_ReloadFromFile <> nil) then
        self.C_ReloadFromFile(PChar(FileName), PChar(fileToReloadFrom));
end;

procedure TPlug_In_DLL.TerminateEditor(FileName: String);
begin
    if (@self.C_TerminateEditor <> nil) then
        self.C_TerminateEditor(PChar(FileName));
end;

function TPlug_In_DLL.Retrieve_LeftDock_Panels: TList;
var
    temp: PHWND;
    res: TList;
    control: TWinControl;
begin
    temp := nil;
    if (@self.C_Retrieve_LeftDock_Panels <> nil) then
        temp := self.C_Retrieve_LeftDock_Panels;
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

function TPlug_In_DLL.Retrieve_RightDock_Panels: TList;
var
    temp: PHWND;
    res: TList;
    control: TWinControl;
begin
    temp := nil;
    if (@self.C_Retrieve_RightDock_Panels <> nil) then
        temp := self.C_Retrieve_RightDock_Panels;
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

function TPlug_In_DLL.Retrieve_BottomDock_Panels: TList;
var
    temp: PHWND;
    res: TList;
    control: TWinControl;
begin
    temp := nil;
    if (@self.C_Retrieve_BottomDock_Panels <> nil) then
        temp := self.C_Retrieve_BottomDock_Panels;
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

procedure TPlug_In_DLL.SetEditorName(currentName:String; newName: string);
begin
    plugin_name := name;
end;

function TPlug_In_DLL.GetPluginName: String;
begin
    Result := plugin_name;
end;

function TPlug_In_DLL.GetChild: HWND;
begin
  Result := self.child;
end;

function TPlug_In_DLL.ConvertLibsToCurrentVersion(strValue: String): String;
var
    temp: PChar;
    res: String;
begin
    temp := '';
    if (@self.C_ConvertLibsToCurrentVersion <> nil) then
        temp := self.C_ConvertLibsToCurrentVersion(PChar(strValue));
    res := temp;
    Result := res;
end;

function TPlug_In_DLL.GetXMLExtension: String;
var
    temp: PChar;
    res: String;
begin
    temp := '';
    if (@self.C_GetXMLExtension <> nil) then
        temp := self.C_GetXMLExtension;
    res := temp;
    Result := res;
end;

function TPlug_In_DLL.EditorDisplaysText(FileName: String): Boolean;
begin
    if (@self.C_EditorDisplaysText <> nil) then
        Result := self.C_EditorDisplaysText(PChar(FileName))
    else
        Result := False;
end;

function TPlug_In_DLL.GetTextHighlighterType(FileName: String): String;
var
    temp: PChar;
    res: String;
begin
    temp := '';
    if (@self.C_GetTextHighlighterType <> nil) then
        temp := self.C_GetTextHighlighterType(PChar(FileName));
    res := temp;
    Result := res;
end;

function TPlug_In_DLL.GET_COMMON_CPP_INCLUDE_DIR: String;  // EAB TODO: Generalize this.
var
    temp: PChar;
    res: String;
begin
    temp := '';
    if (@self.C_GET_COMMON_CPP_INCLUDE_DIR <> nil) then
        temp := self.C_GET_COMMON_CPP_INCLUDE_DIR;
    res := temp;
    Result := res;
end;

function TPlug_In_DLL.GetCompilerMacros: String;
var
    temp: PChar;
    res: String;
begin
    temp := '';
    if (@self.C_GetCompilerMacros <> nil) then
        temp := self.C_GetCompilerMacros;
    res := temp;
    Result := res;
end;

function TPlug_In_DLL.GetCompilerPreprocDefines: String;
var
    temp: PChar;
    res: String;
begin
    temp := '';
    if (@self.C_GetCompilerPreprocDefines <> nil) then
        temp := self.C_GetCompilerPreprocDefines;
    res := temp;
    Result := res;
end;

procedure TPlug_In_DLL.LoadCompilerSettings(name: String; value: String);
begin
    if (@self.C_LoadCompilerSettings <> nil) then
        self.C_LoadCompilerSettings(PChar(name), PChar(value));
end;

procedure TPlug_In_DLL.LoadCompilerOptions;
begin
    if (@self.C_LoadCompilerOptions <> nil) then
        self.C_LoadCompilerOptions;
end;

procedure TPlug_In_DLL.SaveCompilerOptions;
begin
    if (@self.C_SaveCompilerOptions <> nil) then
        self.C_SaveCompilerOptions;
end;

procedure TPlug_In_DLL.LoadText(force:Boolean);
begin
    if (@self.C_LoadText <> nil) then
        self.C_LoadText(force);
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
    if (@self.C_SetCompilerOptionstoDefaults <> nil) then
        self.C_SetCompilerOptionstoDefaults;
end;

procedure TPlug_In_DLL.AfterStartupCheck;
begin
    if (@self.C_AfterStartupCheck <> nil) then
        self.C_AfterStartupCheck;
end;

procedure TPlug_In_DLL.FullScreenSwitch;
begin
end;

function TPlug_In_DLL.GetContextForHelp: String;
begin
    Result := '';
end;

end.
