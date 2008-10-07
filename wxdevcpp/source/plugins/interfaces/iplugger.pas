unit iplugger;

interface

uses
  Classes, Types, ComCtrls, Forms, SynEdit, Windows, Controls;
const
	IID_IPlugger: TGUID = '{DF833707-BDDA-438F-8B50-B2F406943F41}';
type
  IPlug = interface(IInterface) ['{DF833707-BDDA-438F-8B50-B2F406943F41}']
  function IsEditorAssigned(editorName: String = ''):Boolean;
  function IsProjectAssigned:Boolean;
  function IsProjectNotNil: Boolean;
  function GetDMNum:Integer;
  function GetProjectFileName:String;
  procedure ParseCustomCmdLine(strLst:TStringList); //Added By Guru
  procedure ReParseFile(FileName: String);
  function IsClassBrowserEnabled:Boolean;
  procedure OpenFile(s: String; withoutActivation: Boolean = false); // Modified for plugins
  function OpenUnitInProject(s: String): Boolean;
  function FileAlreadyExistsInProject(s: String): Boolean;
  function SaveFileFromPlugin(FileName: String; forcing: Boolean = FALSE): Boolean;
  procedure CloseEditorFromPlugin(FileName: String);
  procedure ActivateEditor(EditorFilename: String);
  function RetrieveUserName(var buffer: array of char; size: dword): Boolean;
  procedure CreateEditor(strFileN: String; extension: String; InProject: Boolean);
  procedure PrepareFileForEditor(currFile: String; insertProj: Integer; creatingProject: Boolean; assertMessage: Boolean; alsoReasignEditor: Boolean; assocPlugin: String);
  procedure UnSetActiveControl;
  function GetActiveEditorName: String;
  procedure UpdateEditor(filename: String; messageToDysplay: String);
  function GetEditorTabSheet(FileName: String): TTabSheet;
  function GetEditorText(FileName: String): TSynEdit;
  function IsFileOpenedInEditor(strFile: string): Boolean;
  function IsEditorModified(FileName: String): Boolean;
  function isFunctionAvailableInEditor(intClassID: Integer; strFunctionName: String; var intLineNum: Integer; var strFname: String): boolean;
  function isFunctionAvailable(intClassID:Integer;strFunctionName:String):boolean;
  function FindStatementID(strClassName: string; var boolFound: Boolean): Integer;
  procedure TouchEditor(editorName: String);
  function GetSuggestedInsertionLine(StID: Integer; AddScopeStr: Boolean): Integer;
  function GetPageControlActivePageIndex: Integer;
  procedure SetEditorModified(editorName: String; modified: Boolean);
  procedure EditorInsertDefaultText(editorName: String);
  procedure GetClassNameLocationsInEditorFiles(var HppStrLst,CppStrLst:TStringList;FileName, FromClassName, ToClassName:string);
  function GetFunctionsFromSource(classname: string; var strLstFuncs:TStringList): Boolean;
  function DoesFileAlreadyExists(FileName: String): Boolean;
  procedure AddProjectUnit(FileName: String; b: Boolean);
  procedure CloseUnit(FileName: String);
  procedure SurroundWithClick(Sender: TObject);
  function GetActiveTabSheet: TTabSheet;
  function GetLangString(index: Integer):String;
  function IsUsingXPTheme: Boolean;
  function GetConfig: String;
  function GetExec: String;
  procedure ChangeProjectProfile(Index: Integer);
  function GetUntitledFileName: String;
  function GetDevDirsConfig: String;
  function GetDevDirsDefault: String;
  function GetDevDirsTemplates: String;
  function GetDevDirsExec: String;
  function GetCompilerProfileNames(var defaultProfileIndex: Integer): TStrings;
  function GetRealPathFix(BrokenFileName: String; Directory: String = ''): String;
  procedure SetPageControlActivePageEditor(editorName: String);
  procedure ToggleDockForm(form: TForm; b: Boolean);
  procedure SendToFront;
	
  end;

implementation

end.



