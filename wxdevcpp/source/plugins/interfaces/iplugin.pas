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
  procedure TestReport;

  //Properties
  function GetPluginName: String;
  function IsDelphiPlugin: Boolean;
  function ManagesUnit: Boolean;       // May be better to sepparate this into another type of plugin

  function GetChild: HWND;  // Used on C dll plugins, for control bar toolbars
  procedure OpenFile(s: String);
  function SaveFile(s: String): Boolean;
  function GetDefaultText(FileName: String): String;
  function MainPageChanged(activeEditorName: String): Boolean;

  function Retrieve_LeftDock_Panels: TList;
  function Retrieve_RightDock_Panels: TList;
  function Retrieve_BottomDock_Panels: TList;
  function Retrieve_Toolbars: TToolBar;
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

  procedure LoadText(force:Boolean);

  procedure CutExecute;
  procedure CopyExecute;
  procedure PasteExecute;

  // Unit aware plugins:
  function HasDesigner(editorName: String): Boolean;
  function SaveFileAndCloseEditor(s: String): Boolean;
  procedure InitEditor(strFileName: String);
  procedure OpenUnit(s: String);
  function IsForm(s: String): Boolean;
  function IsSource(FileName: String): Boolean;
  function GetFilter(editorName: String): String;
  function Get_EXT(editorName: String): String;
  procedure CreateNewXPMs(strFileName:String);
  procedure NewProject(s: String);
  function ShouldNotCloseEditor(FileName: String; curFilename: String): Boolean; 
  procedure Reload(FileName: String);
  function  ReloadForm(FileName: String): Boolean;
  procedure ReloadFromFile(FileName: String; fileToReloadFrom: String);
  procedure TerminateEditor(FileName: String);
  function ConvertLibsToCurrentVersion(strValue: String): String;  
  function GetXMLExtension: String;
  procedure AfterStartupCheck;
  procedure FullScreenSwitch;
  function GetContextForHelp: String;
end;

implementation

end.

