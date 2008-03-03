unit iplugin;

interface

uses
    Classes, Forms, ExtCtrls, Windows, Controls, ComCtrls;

type    

TSetting = record
    name: String;
    value: String;
end;

TSettings = array of TSetting;    

const
	IID_IPlug_In: TGUID = '{C9E8FCF9-BEBD-4A51-80C1-16AF5197BBB3}';

type

  IPlug_In = interface(IInterface) ['{C9E8FCF9-BEBD-4A51-80C1-16AF5197BBB3}']
  
	//Startup and shutdown
  procedure Initialize(name: String; module: HModule; _parent: HWND; _controlBar: TControlBar; _owner: TForm; Config: String; toolbar_x: Integer; toolbar_y: Integer);
  procedure Destroy;

  //Properties
  function GetPluginName: String;
  function IsDelphiPlugin: Boolean;

  // Replace with <Object> is IPluginDesigner?? Does the is operator support this?
  function IsCurrentPageDesigner: Boolean;

  function GetChild: HWND;     // EAB TODO: Remove this one ... ?

  // This function should be not broadcasted to all plugins; only to plugin-profile components
  function HasDesigner(editorName: String): Boolean;

  function SaveFileAndCloseEditor(s: String; b: Boolean): Boolean;
  procedure InitEditor(strFileName: String);
  procedure OpenFile(s: String);
  procedure OpenUnit(s: String);
  function IsForm(s: String): Boolean;
  function SaveFile(s: String; var pluginFileExist: Boolean): Boolean;

  function IsSource(FileName: String): Boolean;
  function GetDefaultText(FileName: String): String;
  function GetFilter(editorName: String): String;
  function Get_EXT(editorName: String): String;
  procedure GenerateXPM(s:String; b: Boolean);     // EAB TODO: I guess this is not common to all plugins.. ?
  procedure CreateNewXPMs(strFileName:String);     // EAB TODO: I guess this is not common to all plugins.. ?
  procedure NewProject(s: String);
  function MainPageChanged(askIfShouldGetFocus: Boolean; FileName: String): Boolean;
  function IsCurrentEditorInPlugin(FileName: String; curFilename: String): Boolean;
  procedure Reload(FileName: String);
  function  ReloadForm(FileName: String): Boolean;
  procedure ReloadFromFile(FileName: String; fileToReloadFrom: String);
  procedure TerminateEditor(FileName: String);
  function Retrieve_Form_Items: TList;
  function Retrieve_LeftDock_Panels: TList;
  function Retrieve_RightDock_Panels: TList;
  function Retrieve_BottomDock_Panels: TList;
  function Retrieve_Toolbars: TToolBar;
  function ConvertLibsToCurrentVersion(strValue: String): String;  // EAB TODO: I guess this is not common to all plugins.. ?
  function GetXMLExtension: String;   // EAB TODO: I guess this is not common to all plugins.. ?
  function EditorDisplaysText(FileName: String): Boolean;
  function GetTextHighlighterType(FileName: String): String;
  function GET_COMMON_CPP_INCLUDE_DIR: String;  // EAB TODO: Generalize this.
  function GetCompilerMacros: String;
  function GetCompilerPreprocDefines: String;
  function GetCompilerOptions: TSettings;
  procedure SetCompilerOptionstoDefaults;

  procedure LoadCompilerSettings(name: string; value: string);
  procedure LoadCompilerOptions;
  procedure SaveCompilerOptions;

  procedure CutExecute;
  procedure CopyExecute;
  procedure PasteExecute;
end;

implementation

end.

