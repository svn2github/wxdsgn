unit wxdesigner;

interface

uses
  Classes, iniFiles, ActnList, Menus, ExtCtrls, ComCtrls, Controls, Types, Messages,
  StdCtrls, Forms, SysUtils, Windows, Dialogs, Graphics, Spin,
  JclStrings, JvExControls, JvComponent, TypInfo, JclRTTI, JvStringHolder,
  ELDsgnr, JvInspector, dmCreateNewProp,
  wxSizerpanel, Designerfrm, ELPropInsp, {$IFNDEF COMPILER_7_UP}ThemeMgr, {$ENDIF}
  CompFileIO, SynEdit, StrUtils,
  DesignerOptions, JvExStdCtrls, JvEdit, iplugin, iplugin_bpl, iplugger,
  hashes,
  SynEditHighlighter, SynHighlighterMulti,
  JvComponentBase, JvDockControlForm, JvDockTree, JvDockVIDStyle, JvDockVSNetStyle,
  wxUtils, xprocs, JvComputerInfoEx,
  ComponentPalette;

{$I ..\..\LangIDs.inc}

type
  TdevWxOptions = record
    majorVersion: ShortInt;
    minorVersion: ShortInt;
    releaseVersion: ShortInt;

    unicodeSupport: Boolean;
    monolithicLibrary: Boolean;
    debugLibrary: Boolean;
    staticLibrary: Boolean;
  end;

type
  TWXDsgn = class(TComponent, IPlug_In_BPL)
    actNewwxDialog: TAction;
    NewWxDialogItem: TMenuItem;
    ShowPropertyInspItem: TMenuItem;
    ShowComponentPaletteItem: TMenuItem;
    actDesignerCopy: TAction;
    actDesignerCut: TAction;
    actDesignerPaste: TAction;
    actDesignerDelete: TAction;
    actShowPropertyInspItem: TAction;
    actShowComponentPaletteItem: TAction;
    ProgramResetBtn: TToolButton;
    SurroundWithPopItem: TMenuItem;
    actDelete: TAction;
    N71: TMenuItem;
    N72: TMenuItem;
    N70: TMenuItem;
    NewWxFrameItem: TMenuItem;
    actNewWxFrame: TAction;
    ToolsMenuDesignerOptions: TMenuItem;
    DebugStopBtn: TToolButton;
    actWxPropertyInspectorCut: TAction;
    actWxPropertyInspectorCopy: TAction;
    actWxPropertyInspectorPaste: TAction;
    editors: TObjectHash;

    procedure actDesignerCopyExecute(Sender: TObject);
    procedure actDesignerCutExecute(Sender: TObject);
    procedure actWxPropertyInspectorCutExecute(Sender: TObject);
    procedure actWxPropertyInspectorCopyExecute(Sender: TObject);
    procedure actWxPropertyInspectorPasteExecute(Sender: TObject);
    procedure actWxPropertyInspectorDeleteExecute(Sender: TObject);
    procedure actDesignerPasteExecute(Sender: TObject);
    procedure actDesignerDeleteExecute(Sender: TObject);
    procedure WxPropertyInspectorContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure ELDesigner1ContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure ELDesigner1ChangeSelection(Sender: TObject);
    procedure ELDesigner1ControlDeleted(Sender: TObject; AControl: TControl);
    procedure ELDesigner1ControlHint(Sender: TObject; AControl: TControl; var AHint: string);
    procedure ELDesigner1ControlInserted(Sender: TObject; AControl: TControl);
    procedure ELDesigner1ControlInserting(Sender: TObject; var AParent: TWinControl; var AControlClass: TControlClass);
    procedure ELDesigner1ControlDoubleClick(Sender: TObject);
    procedure ELDesigner1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ELDesigner1Modified(Sender: TObject);
    procedure JvInspPropertiesAfterItemCreate(Sender: TObject; Item: TJvCustomInspectorItem);
    procedure JvInspPropertiesDataValueChanged(Sender: TObject; Data: TJvCustomInspectorData);
    procedure JvInspEventsAfterItemCreate(Sender: TObject; Item: TJvCustomInspectorItem);
    procedure JvInspEventsDataValueChanged(Sender: TObject; Data: TJvCustomInspectorData);
    procedure JvInspEventsMouseMove(Sender: TObject; Shift: TShiftState; X: Integer; Y:Integer);
    procedure JvInspEventsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y:Integer);
    procedure JvInspEventsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure JvInspEventsItemValueChanged(Sender: TObject; Item: TJvCustomInspectorItem);
    procedure cbxControlsxChange(Sender: TObject);
    procedure JvInspPropertiesBeforeSelection(Sender: TObject; NewItem: TJvCustomInspectorItem; var Allow: Boolean);
    procedure JvInspPropertiesItemValueChanged(Sender: TObject; Item: TJvCustomInspectorItem);
    procedure ViewControlIDsClick(Sender: TObject);
    procedure AlignToGridClick(Sender: TObject);
    procedure AlignToLeftClick(Sender: TObject);
    procedure AlignToRightClick(Sender: TObject);
    procedure AlignToMiddleVerticalClick(Sender: TObject);
    procedure AlignToMiddleHorizontalClick(Sender: TObject);
    procedure AlignToTopClick(Sender: TObject);
    procedure AlignToBottomClick(Sender: TObject);
    procedure DesignerOptionsClick(Sender: TObject);
    procedure ChangeCreationOrder1Click(Sender: TObject);
    procedure SelectParentClick(Sender: TObject);
    procedure LockControlClick(Sender: TObject);
    procedure OnPropertyItemSelected(Sender: TObject);
    function IsFromScrollBarShowing: boolean;
    procedure actNewWxFrameExecute(Sender: TObject);
    procedure actNewwxDialogExecute(Sender: TObject);
    procedure UpdateXRC(editorName: string);
    procedure actShowPropertyInspItemExecute(Sender: TObject);
    procedure actShowComponentPaletteItemExecute(Sender: TObject);

  private
    plugin_name: string;
    palettePanel: TPanel;
    cleanUpJvInspEvents: Boolean;
  public
    ownerForm: TForm;
    editorNames: Array of String;
    function GetCurrentFileName: string;
    function GetCurrentClassName: string;
 public
    // Wx Property Inspector Popup Menu
    WxPropertyInspectorPopup: TPopupMenu;
    WxPropertyInspectorMenuEdit: TMenuItem;
    WxPropertyInspectorMenuCopy: TMenuItem;
    WxPropertyInspectorMenuCut: TMenuItem;
    WxPropertyInspectorMenuPaste: TMenuItem;
    WxPropertyInspectorMenuDelete: TMenuItem;
    //PopUpMenu
    DesignerPopup: TPopupMenu;
    DesignerMenuEdit: TMenuItem;
    DesignerMenuCopy: TMenuItem;
    DesignerMenuCut: TMenuItem;
    DesignerMenuPaste: TMenuItem;
    DesignerMenuDelete: TMenuItem;
    DesignerMenuSep1: TMenuItem;
    DesignerMenuCopyWidgetName: TMenuItem;
    DesignerMenuChangeCreationOrder: TMenuItem;
    DesignerMenuViewIDs: TMenuItem;
    DesignerMenuSep2: TMenuItem;
    DesignerMenuSelectParent: TMenuItem;
    DesignerMenuAlign: TMenuItem;
    DesignerMenuAlignToGrid, DesignerMenuAlignVertical, DesignerMenuAlignHorizontal,
    DesignerMenuAlignToLeft, DesignerMenuAlignToRight,
    DesignerMenuAlignToTop, DesignerMenuAlignToBottom,
    DesignerMenuAlignToMiddle: TMenuItem;
    DesignerMenuAlignToMiddleVertical, DesignerMenuAlignToMiddleHorizontal: TMenuItem;
    DesignerMenuLocked: TMenuItem;
    DesignerMenuSep3: TMenuItem;
    DesignerMenuDesignerOptions: TMenuItem;

    JvInspectorDotNETPainter1: TJvInspectorBorlandPainter;
    JvInspectorDotNETPainter2: TJvInspectorBorlandPainter;

    ELDesigner1: TELDesigner;
    //Property Inspector controls
    cbxControlsx: TComboBox;
    pgCtrlObjectInspector: TPageControl;
    TabProperty: TTabSheet;
    TabEvent: TTabSheet;
    pnlMainInsp: TPanel;
    JvInspProperties: TJvInspector;
    JvInspEvents: TJvInspector;

    //Component palette
    ComponentPalette: TComponentPalette;

    //Docking controls
    frmPaletteDock: TForm;
    frmInspectorDock: TForm;

    strStdwxIDList: TStringList;

    XPTheme: boolean; // Use XP theme
    configFolder: String;

    tabwxWidgets: TTabSheet; // For compiler options pane
    grpwxVersion: TGroupBox;
    grpwxType: TGroupBox;
    rdwxLibraryType: TRadioGroup;
    spwxRelease: TSpinEdit;
    spwxMinor: TSpinEdit;
    spwxMajor: TSpinEdit;
    lblwxRelease: TLabel;
    lblwxMajor: TLabel;
    lblwxMinor: TLabel;
    chkwxDebug: TCheckBox;
    chkwxMonolithic: TCheckBox;
    chkwxUnicode: TCheckBox;
    staticLib: TRadioButton;
    dynamicLib: TRadioButton;


  private
    fwxOptions: TdevWxOptions;
    pendingEditorSwitch: Boolean; // EAB: Let's see if we can make JvInspector to behave when switching to editor from Events field
    property wxOptions: TdevWxOptions read fwxOptions write fwxOptions;
    procedure CreateNewDialogOrFrameCode(dsgnType: TWxDesignerType; frm: TfrmCreateFormProp; insertProj: integer);
    procedure NewWxProjectCode(dsgnType: TWxDesignerType);
    procedure ParseAndSaveTemplate(template, destination: string; frm: TfrmCreateFormProp); 
    function CreateCreateFormDlg(dsgnType: TWxDesignerType; insertProj: integer; projShow: boolean; filenamebase: string = ''): TfrmCreateFormProp; 

    function CreateFormFile(strFName, strCName, strFTitle: string; dlgSStyle: TWxDlgStyleSet; dsgnType: TWxDesignerType): Boolean;
    procedure GetIntialFormData(frm: TfrmCreateFormProp; var strFName, strCName, strFTitle: string; var dlgStyle: TWxDlgStyleSet; dsgnType: TWxDesignerType);
    function CreateSourceCodes(strCppFile, strHppFile: string; FCreateFormProp: TfrmCreateFormProp; var cppCode, hppCode: string; dsgnType: TWxDesignerType): Boolean;
    function CreateAppSourceCodes(strCppFile, strHppFile, strAppCppFile, strAppHppFile: string; FCreateFormProp: TfrmCreateFormProp; var cppCode, hppCode, appcppCode, apphppCode: string; dsgnType: TWxDesignerType): Boolean;
    procedure LoadText(force:Boolean);

  public
    CacheCreated: boolean;
    main: IPlug;
    parentHande: HWND;
    {Guru's Code}

    ComputerInfo1 : TJvComputerInfoEx;

    strGlobalCurrentFunction: string;
    DisablePropertyBuilding: Boolean;
    boolInspectorDataClear: Boolean;
    intControlCount: integer;
    SelectedComponent: TComponent;
    PreviousComponent: TComponent;
    PreviousStringValue: string;
    PreviousComponentName: string;
    FirstComponentBeingDeleted: string;
    procedure GenerateSource(sourceFileName: string; text: TSynEdit);
    procedure BuildProperties(Comp: TControl; boolForce: Boolean = false);
    procedure BuildComponentList(Designer: TfrmNewForm);
    function isCurrentFormFilesNeedToBeSaved: Boolean;
    function saveCurrentFormFiles: Boolean;
    function CreateFunctionInEditor(var strFunctionName: string; strReturnType, strParameter: string; var ErrorString: string; strClassName: string = ''): Boolean; overload;
    function CreateFunctionInEditor(strClassName: string; SelComponent: TComponent; var strFunctionName: string; strEventFullName: string; var ErrorString: string): Boolean; overload;
    function LocateFunctionInEditor(eventProperty: TJvCustomInspectorData; strClassName: string; SelComponent: TComponent; var strFunctionName: string; strEventFullName: string): Boolean;
    procedure OnEventPopup(Item: TJvCustomInspectorItem; Value: TStrings);
    procedure OnStdWxIDListPopup(Item: TJvCustomInspectorItem; Value: TStrings);
    procedure UpdateDefaultFormContent;
    function GetCurrentDesignerForm: TfrmNewForm;
    function IsCurrentPageDesigner: Boolean;
    function IsDelphiPlugin: Boolean;
    function ReplaceClassNameInEditor(strLst: TStringList; text: TSynEdit; FromClassName, ToClassName: string): boolean;

    function LocateFunction(strFunctionName: string): boolean;

    // iplugin methods
    function SaveFileAndCloseEditor(EditorFilename: string): Boolean;
    procedure CutExecute;
    procedure CopyExecute;
    procedure PasteExecute;
    procedure InitEditor(strFileName: string);
    procedure Initialize(name: string; module: HModule; _parent: HWND; _controlBar: TControlBar; _owner: TForm; Config: string; toolbar_x: Integer; toolbar_y: Integer);
    procedure AssignPlugger(plug: IPlug);
    procedure DisableDesignerControls;
    procedure OpenFile(s: string);
    procedure OpenUnit(EditorFilename: string);
    function IsForm(s: string): Boolean;
    function GetFilters: TStringList;
    function GetSrcFilters: TStringList;
    function GetFilter(editorName: string): string;
    function Get_EXT(editorName: string): string;
    function Get_EXT_Index(editorName: String): Integer;
    procedure NewProject(s: string);
    procedure GenerateXPM(s: string; b: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SetDesignerActiveState(state: Boolean);
    procedure EnableDesignerControls;
    procedure SetBoolInspectorDataClear(b: Boolean);
    procedure SetDisablePropertyBuilding(b: Boolean);
    procedure AssignDesignerControl(editorName: string);
    function SaveFile(EditorFilename: string): Boolean;
    procedure ActivateDesigner(s: string);
    function GetLoginName: string;
    function GetLangString(LangID: Integer): string;

    procedure UpdateDesignerData(FileName: string);
    procedure Reload(FileName: string);
    function ReloadForm(FileName: string): Boolean;
    procedure ReloadFromFile(FileName: string; fileToReloadFrom: string);
    procedure TerminateEditor(FileName: string);
    procedure Destroy;
    procedure OnDockableFormClosed(Sender: TObject; var Action: TCloseAction);
    function IsSource(FileName: string): Boolean;
    function GetDefaultText(FileName: string): string;
    function MainPageChanged(FileName: string): Boolean;
    function ShouldNotCloseEditor(FileName: string; curFilename: string): Boolean;
    function HasDesigner(editorName: string): Boolean;
    function ManagesUnit: Boolean;

    procedure OnToolbarEvent(WM_COMMAND: Word);
    function Retrieve_File_New_Menus: TList;
    function Retrieve_File_Import_Menus: TList;
    function Retrieve_File_Export_Menus: TList;
    function Retrieve_Edit_Menus: TList;
    function Retrieve_Search_Menus: TList;
    function Retrieve_View_Menus: TList;
    function Retrieve_View_Toolbars_Menus: TList;
    function Retrieve_Project_Menus: TList;
    function Retrieve_Execute_Menus: TList;
    function Retrieve_Debug_Menus: TList;
    function Retrieve_Tools_Menus: TList;
    function Retrieve_Help_Menus: TList;
    function Retrieve_Toolbars: TToolBar;
    function Retrieve_Message_Tabs: TList;
    procedure SetEditorName(currentName:String; newName: string);
    function GetPluginName: string;
    function GetChild: HWND;
    function GetXMLExtension: string;
    function Retrieve_LeftDock_Panels: TList;
    function Retrieve_RightDock_Panels: TList;
    function Retrieve_BottomDock_Panels: TList;
    function ConvertLibsToCurrentVersion(strValue: string): string;
    procedure CreateNewXPMs(strFileName: string);
    function EditorDisplaysText(FileName: string): Boolean;
    function GetTextHighlighterType(FileName: string): string;
    function GET_COMMON_CPP_INCLUDE_DIR: string; 
    function GetCompilerMacros: string;
    function GetCompilerPreprocDefines: string;
    function Retrieve_CompilerOptionsPane: TTabSheet;
    procedure LoadCompilerSettings(name: string; value: string);
    procedure LoadCompilerOptions;
    procedure SaveCompilerOptions;
    function GetCompilerOptions: TSettings;
    procedure SetCompilerOptionstoDefaults;
    procedure TestReport;
    procedure AfterStartupCheck;
    procedure FullScreenSwitch;
    function GetContextForHelp: String;
    
  end;

var
  wx_designer: TWXDsgn;

implementation

uses

  //Components
  CreateOrderFm, ViewIDForm,
  WxSplitterWindow, wxchoicebook, wxlistbook, WxNotebook, wxtoolbook, wxtreebook,
  WxNoteBookPage, WxToolbar, WxToolButton, WxChoice, WxCustomButton,
  WxSeparator, WxStatusBar, WxNonVisibleBaseComponent, WxMenuBar, WxPopupMenu, WxPanel,
  WxStaticBitmap, WxBitmapButton, WxStdDialogButtonSizer, wxversion, wxeditor,
  wxAuiToolBar, wxAuiNotebook, wxAuiBar, WxAuiNoteBookPage
  ;

const

  IniVersion = 1;
  INT_BRACES = 1;
  INT_TRY_CATCH = 2;
  INT_TRY_FINALLY = 3;
  INT_TRY_CATCH_FINALLY = 4;
  INT_C_COMMENT = 5;
  INT_FOR = 6;
  INT_FOR_I = 7;
  INT_WHILE = 8;
  INT_DO_WHILE = 9;
  INT_IF = 10;
  INT_IF_ELSE = 11;
  INT_SWITCH = 12;
  INT_CPP_COMMENT = 13;

procedure TWXDsgn.Initialize(name: string; module: HModule; _parent: HWND; _controlBar: TControlBar; _owner: TForm; Config: string; toolbar_x: Integer; toolbar_y: Integer);
var
  I: Integer;
  ini: TiniFile;
begin
  plugin_name := name;
  XPTheme := False;
  ownerForm := _owner;
  wx_designer := Self;
  editors := TObjectHash.Create;
  configFolder := Config;
  parentHande := _parent;
  pendingEditorSwitch := false;

  cleanUpJvInspEvents := false;

  ComputerInfo1 := TJvComputerInfoEx.Create(ownerForm);

  //Property Inspector
  frmInspectorDock := TForm.Create(ownerForm);
  frmInspectorDock.ParentFont := True;
  frmInspectorDock.Font.Assign(ownerForm.Font);
  with frmInspectorDock do
  begin
    Name := 'frmInspectorDock';
    Caption := GetLangString(ID_WX_PROPINSPECTOR);
    BorderStyle := bsSizeToolWin;
    Color := clBtnFace;
    Width := 300;

    DockSite := True;
    DragKind := dkDock;
    DragMode := dmAutomatic;
    FormStyle := fsStayOnTop;
    OnClose := OnDockableFormClosed;
  end;

  frmPaletteDock := TForm.Create(ownerForm);
  frmPaletteDock.ParentFont := True;
  frmPaletteDock.Font.Assign(ownerForm.Font);
  palettePanel := TPanel.Create(frmPaletteDock);
  palettePanel.Parent := frmPaletteDock;
  palettePanel.BevelInner := bvLowered;
  palettePanel.BorderWidth := 1;
  palettePanel.BevelWidth := 1;
  palettePanel.Align := alClient;
  palettePanel.Anchors := [akLeft,akTop,akRight,akBottom];

  ComponentPalette := TComponentPalette.Create(palettePanel);
  ComponentPalette.Visible := false;
  with frmPaletteDock do
  begin
    Name := 'frmPaletteDock';
    Caption := main.GetLangString(133);
    BorderStyle := bsSizeToolWin;
    Color := clBtnFace;
    Width := 170;    

    DockSite := True;
    DragKind := dkDock;
    DragMode := dmAutomatic;
    FormStyle := fsStayOnTop;
    OnClose := OnDockableFormClosed;
  end;

  //Add the property inspector view menu item
  ShowPropertyInspItem := TMenuItem.Create(Self);
  with ShowPropertyInspItem do
  begin
    Caption := GetLangString(ID_WX_SHOWPROPINSPECTOR); //'Show Property Inspector';
    Action := actShowPropertyInspItem;
    OnClick := actShowPropertyInspItemExecute;
    Checked := true;
  end;

    //Add the property inspector view menu item
  ShowComponentPaletteItem := TMenuItem.Create(Self);
  with ShowComponentPaletteItem do
  begin
    Caption := GetLangString(ID_WX_SHOWCOMPPALETTE); //'Show Component Palette';
    Action := actShowComponentPaletteItem;
    OnClick := actShowComponentPaletteItemExecute;
    Checked := true;
  end;

  boolInspectorDataClear := True;
  DisablePropertyBuilding := False;

  NewWxDialogItem := TMenuItem.Create(Self);
  with NewWxDialogItem do
  begin
    Caption := GetLangString(ID_WX_NEWDIALOG); //'New wxDialog';
    ImageIndex := 1;
    Action := actNewwxDialog;
    OnClick := actNewWxDialogExecute;
  end;

  NewWxFrameItem := TMenuItem.Create(Self);
  with NewWxFrameItem do
  begin
    Caption := GetLangString(ID_WX_NEWFRAME); //'New wxFrame';
    ImageIndex := 1;
    Action := actNewWxFrame;
    OnClick := actNewWxFrameExecute;
  end;

  actDesignerCopy := TAction.Create(Self);
  with actDesignerCopy do
  begin
    Category := 'Designer';
    Caption := GetLangString(ID_ITEM_COPY); //'Copy';
    ShortCut := 49219;
    OnExecute := actDesignerCopyExecute;
  end;
  actDesignerCut := TAction.Create(Self);
  with actDesignerCut do
  begin
    Category := 'Designer';
    Caption := GetLangString(ID_ITEM_CUT); //'Cut';
    ShortCut := 49240;
    OnExecute := actDesignerCutExecute;
  end;
  actDesignerPaste := TAction.Create(Self);
  with actDesignerPaste do
  begin
    Category := 'Designer';
    Caption := GetLangString(ID_ITEM_PASTE); //'Paste';
    ShortCut := 49238;
    OnExecute := actDesignerPasteExecute;
  end;
  actDesignerDelete := TAction.Create(Self);
  with actDesignerDelete do
  begin
    Category := 'Designer';
    Caption := GetLangString(ID_ITEM_DELETE); //'Delete';
    ShortCut := 16430;
    OnExecute := actDesignerDeleteExecute;
  end;
  actNewWxFrame := TAction.Create(Self);
  with actNewWxFrame do
  begin
    Category := 'File';
    Caption := GetLangString(ID_WX_NEWFRAME); //'New wxFrame';
    ImageIndex := 1;
    OnExecute := actNewWxFrameExecute;
  end;
  actWxPropertyInspectorCut := TAction.Create(Self);
  with actWxPropertyInspectorCut do
  begin
    Category := 'Designer';
    Caption := GetLangString(ID_ITEM_CUT); //'Cut';
    ShortCut := 16472;
    OnExecute := actWxPropertyInspectorCutExecute;
  end;
  actWxPropertyInspectorCopy := TAction.Create(Self);
  with actWxPropertyInspectorCopy do
  begin
    Category := 'Designer';
    Caption := GetLangString(ID_ITEM_COPY); //'Copy';
    ShortCut := 16451;
    OnExecute := actWxPropertyInspectorCopyExecute;
  end;
  actWxPropertyInspectorPaste := TAction.Create(Self);
  with actWxPropertyInspectorPaste do
  begin
    Category := 'Designer';
    Caption := GetLangString(ID_ITEM_PASTE); //'Paste';
    ShortCut := 16470;
    OnExecute := actWxPropertyInspectorPasteExecute;
  end;

  { END Initialization of past code from TMainForm }

  strStdwxIDList := GetPredefinedwxIds;

  WxPropertyInspectorPopup := TPopupMenu.Create(Self);
  WxPropertyInspectorMenuEdit := TMenuItem.Create(Self);
  WxPropertyInspectorMenuCopy := TMenuItem.Create(Self);
  WxPropertyInspectorMenuCut := TMenuItem.Create(Self);
  WxPropertyInspectorMenuPaste := TMenuItem.Create(Self);
  WxPropertyInspectorMenuDelete := TMenuItem.Create(Self);

  DesignerPopup := TPopupMenu.Create(Self);
  DesignerMenuEdit := TMenuItem.Create(Self);
  DesignerMenuCopy := TMenuItem.Create(Self);
  DesignerMenuCut := TMenuItem.Create(Self);
  DesignerMenuPaste := TMenuItem.Create(Self);
  DesignerMenuDelete := TMenuItem.Create(Self);
  DesignerMenuSep1 := TMenuItem.Create(Self);
  DesignerMenuCopyWidgetName := TMenuItem.Create(Self);
  DesignerMenuChangeCreationOrder := TMenuItem.Create(Self);
  DesignerMenuSelectParent := TMenuItem.Create(Self);
  DesignerMenuLocked := TMenuItem.Create(Self);
  DesignerMenuViewIDs := TMenuItem.Create(Self);
  DesignerMenuSep2 := TMenuItem.Create(Self);
  DesignerMenuAlign := TMenuItem.Create(Self);
  DesignerMenuAlignToGrid := TMenuItem.Create(DesignerMenuAlign);
  DesignerMenuAlignVertical := TMenuItem.Create(DesignerMenuAlign);
  DesignerMenuAlignHorizontal := TMenuItem.Create(DesignerMenuAlign);
  DesignerMenuAlignToTop := TMenuItem.Create(DesignerMenuAlignVertical);
  DesignerMenuAlignToMiddleVertical := TMenuItem.Create(DesignerMenuAlignVertical);
  DesignerMenuAlignToBottom := TMenuItem.Create(DesignerMenuAlignVertical);
  DesignerMenuAlignToLeft := TMenuItem.Create(DesignerMenuAlignHorizontal);
  DesignerMenuAlignToMiddleHorizontal := TMenuItem.Create(DesignerMenuAlignHorizontal);
  DesignerMenuAlignToRight := TMenuItem.Create(DesignerMenuAlignHorizontal);
  DesignerMenuSep3 := TMenuItem.Create(DesignerPopup);
  DesignerMenuDesignerOptions := TMenuItem.Create(Self);
  ToolsMenuDesignerOptions := TMenuItem.Create(Self);

  with WxPropertyInspectorPopup do
  begin
    Name := 'WxPropertyInspectorPopup';
  end;
  with WxPropertyInspectorMenuEdit do
  begin
    Name := 'WxPropertyInspectorMenuEdit';
    Caption := GetLangString(ID_WX_PROPERTYEDIT); //'Wx Property Edit';
  end;
  with WxPropertyInspectorMenuCopy do
  begin
    Name := 'WxPropertyInspectorMenuCopy';
    Action := actWxPropertyInspectorCopy;
  end;
  with WxPropertyInspectorMenuCut do
  begin
    Name := 'WxPropertyInspectorMenuCut';
    Action := actWxPropertyInspectorCut;
  end;
  with WxPropertyInspectorMenuPaste do
  begin
    Name := 'WxPropertyInspectorMenuPaste';
    Action := actWxPropertyInspectorPaste;
  end;
  with WxPropertyInspectorMenuDelete do
  begin
    Name := 'WxPropertyInspectorMenuDelete';
    Action := actDelete;
  end;

  with DesignerPopup do
  begin
    Name := 'DesignerPopup';
  end;
  with DesignerMenuEdit do
  begin
    Name := 'DesignerMenuEdit';
    Caption := GetLangString(ID_MNU_EDIT); //'Edit';
  end;
  with DesignerMenuCopy do
  begin
    Name := 'DesignerMenuCopy';
    Action := actDesignerCopy;
  end;
  with DesignerMenuCut do
  begin
    Name := 'DesignerMenuCut';
    Action := actDesignerCut;
  end;
  with DesignerMenuPaste do
  begin
    Name := 'DesignerMenuPaste';
    Action := actDesignerPaste;
  end;
  with DesignerMenuDelete do
  begin
    Name := 'DesignerMenuDelete';
    Action := actDesignerDelete;
  end;
  with DesignerMenuSep1 do
  begin
    Name := 'DesignerMenuSep1';
    Caption := '-';
  end;
  with DesignerMenuCopyWidgetName do
  begin
    Name := 'DesignerMenuCopyWidgetName';
    Caption := GetLangString(ID_WX_COPYNAME); //'Copy Widget Name';
    Visible := False;
  end;
  with DesignerMenuChangeCreationOrder do
  begin
    Name := 'DesignerMenuChangeCreationOrder';
    Caption := GetLangString(ID_WX_CHANGEORDER); //'Change Creation Order';
    OnClick := ChangeCreationOrder1Click;
  end;
  with DesignerMenuSelectParent do
  begin
    Name := 'DesignerMenuSelectParent';
    Caption := GetLangString(ID_WX_SELECTPARENT); //'Select Parent';
  end;
  with DesignerMenuLocked do
  begin
    Name := 'DesignerMenuLocked';
    Caption := GetLangString(ID_WX_LOCKCONTROL); //'Lock Control';
    OnClick := LockControlClick;
  end;
  with DesignerMenuSep2 do
  begin
    Name := 'DesignerMenuSep2';
    Caption := '-';
  end;
  with DesignerMenuViewIDs do
  begin
    Name := 'DesignerMenuViewIDs';
    Caption := GetLangString(ID_WX_VIEWCONTROLID); //'View Control IDs';
    OnClick := ViewControlIDsClick;
  end;
  with DesignerMenuAlign do
  begin
    Name := 'DesignerMenuAlign';
    Caption := GetLangString(ID_WX_ALIGN); //'Align';
  end;

  with DesignerMenuAlignToGrid do
  begin
    Name := 'DesignerMenuAlignToGrid';
    Caption := GetLangString(ID_WX_TOGRID); //'To Grid';
    OnClick := AlignToGridClick;
  end;

  with DesignerMenuAlignVertical do
  begin
    Name := 'DesignerMenuAlignVertical';
    Caption := GetLangString(ID_WX_VERTICAL); //'Vertical';
  end;

  with DesignerMenuAlignHorizontal do
  begin
    Name := 'DesignerMenuAlignHorizontal';
    Caption := GetLangString(ID_WX_HORIZONTAL); //'Horizontal';
  end;

  with DesignerMenuAlignToLeft do
  begin
    Name := 'DesignerMenuAlignToLeft';
    Caption := GetLangString(ID_WX_TOLEFT); //'To Left';
    OnClick := AlignToLeftClick;
  end;

  with DesignerMenuAlignToRight do
  begin
    Name := 'DesignerMenuAlignToRight';
    Caption := GetLangString(ID_WX_TORIGHT); //'To Right';
    OnClick := AlignToRightClick;
  end;

  with DesignerMenuAlignToMiddleVertical do
  begin
    Name := 'DesignerMenuAlignToMiddleVertical';
    Caption := GetLangString(ID_WX_TOCENTER); //'To Center';
    OnClick := AlignToMiddleVerticalClick;
  end;

  with DesignerMenuAlignToMiddleHorizontal do
  begin
    Name := 'DesignerMenuAlignToMiddleHorizontal';
    Caption := GetLangString(ID_WX_TOCENTER); //'To Center';
    OnClick := AlignToMiddleHorizontalClick;
  end;

  with DesignerMenuAlignToTop do
  begin
    Name := 'DesignerMenuAlignToTop';
    Caption := GetLangString(ID_WX_TOTOP); //'To Top';
    OnClick := AlignToTopClick;
  end;

  with DesignerMenuAlignToBottom do
  begin
    Name := 'DesignerMenuAlignToBottom';
    Caption := GetLangString(ID_WX_TOBOTTOM); //'To Bottom';
    OnClick := AlignToBottomClick;
  end;

  with DesignerMenuSep3 do
  begin
    Name := 'DesignerMenuSep3';
    Caption := '-';
  end;
  with DesignerMenuDesignerOptions do
  begin
    Name := 'DesignerMenuDesignerOptions';
    Caption := GetLangString(ID_WX_DESIGNEROPTS); //'Designer Options';
    OnClick := DesignerOptionsClick;
  end;
  with ToolsMenuDesignerOptions do
  begin
    Name := 'ToolsMenuDesignerOptions';
    Caption := GetLangString(ID_WX_DESIGNEROPTS); //'Designer Options';
    OnClick := DesignerOptionsClick;
  end;

  WxPropertyInspectorPopup.Items.Add(WxPropertyInspectorMenuCut);
  WxPropertyInspectorPopup.Items.Add(WxPropertyInspectorMenuCopy);
  WxPropertyInspectorPopup.Items.Add(WxPropertyInspectorMenuPaste);
  WxPropertyInspectorPopup.Items.Add(WxPropertyInspectorMenuDelete);

  DesignerPopup.Items.Add(DesignerMenuCut);
  DesignerPopup.Items.Add(DesignerMenuCopy);
  DesignerPopup.Items.Add(DesignerMenuPaste);
  DesignerPopup.Items.Add(DesignerMenuDelete);
  DesignerPopup.Items.Add(DesignerMenuSep1);
  DesignerPopup.Items.Add(DesignerMenuCopyWidgetName);
  DesignerPopup.Items.Add(DesignerMenuChangeCreationOrder);
  DesignerPopup.Items.Add(DesignerMenuViewIDs);
  DesignerPopup.Items.Add(DesignerMenuSep2);
  DesignerPopup.Items.Add(DesignerMenuSelectParent);
  DesignerPopup.Items.Add(DesignerMenuAlign);
  DesignerPopup.Items.Add(DesignerMenuLocked);
  DesignerPopup.Items.Add(DesignerMenuSep3);
  DesignerPopup.Items.Add(DesignerMenuDesignerOptions);

  DesignerMenuAlign.Add(DesignerMenuAlignToGrid);
  DesignerMenuAlign.Add(DesignerMenuAlignHorizontal);
  DesignerMenuAlignHorizontal.Add(DesignerMenuAlignToLeft);
  DesignerMenuAlignHorizontal.Add(DesignerMenuAlignToMiddleHorizontal);
  DesignerMenuAlignHorizontal.Add(DesignerMenuAlignToRight);

  DesignerMenuAlign.Add(DesignerMenuAlignVertical);
  DesignerMenuAlignVertical.Add(DesignerMenuAlignToTop);
  DesignerMenuAlignVertical.Add(DesignerMenuAlignToMiddleVertical);
  DesignerMenuAlignVertical.Add(DesignerMenuAlignToBottom);

  //Object inspector Styles
  JvInspectorDotNETPainter1 := TJvInspectorBorlandPainter.Create(frmInspectorDock);
  JvInspectorDotNETPainter2 := TJvInspectorBorlandPainter.Create(frmInspectorDock);
  with JvInspectorDotNETPainter1 do
  begin
    Name := 'JvInspectorDotNETPainter1';
    DrawNameEndEllipsis := False;
  end;
  with JvInspectorDotNETPainter2 do
  begin
    Name := 'JvInspectorDotNETPainter2';
    DrawNameEndEllipsis := False;
  end;

  ELDesigner1 := TELDesigner.Create(Self);
  with ELDesigner1 do
  begin
    Name := 'ELDesigner1';
    ClipboardFormat := 'Extension Library designer components';
    PopupMenu := DesignerPopup;
    SnapToGrid := false;
    GenerateXRC := false;
    Floating := false;
    OnContextPopup := ELDesigner1ContextPopup;
    OnChangeSelection := ELDesigner1ChangeSelection;
    OnControlDeleted := ELDesigner1ControlDeleted;
    OnControlHint := ELDesigner1ControlHint;
    OnControlInserted := ELDesigner1ControlInserted;
    OnControlInserting := ELDesigner1ControlInserting;
    OnModified := ELDesigner1Modified;
    OnDblClick := ELDesigner1ControlDoubleClick;
    OnKeyDown := ELDesigner1KeyDown;
  end;
 
  ini := TiniFile.Create(Config + ChangeFileExt(ExtractFileName(Application.ExeName),'') + '.ini');      
  try
    ELDesigner1.Grid.Visible := ini.ReadBool('wxWidgets', 'cbGridVisible', ELDesigner1.Grid.Visible);
    ELDesigner1.Grid.XStep := ini.ReadInteger('wxWidgets', 'lbGridXStepUpDown', ELDesigner1.Grid.XStep);
    ELDesigner1.Grid.YStep := ini.ReadInteger('wxWidgets', 'lbGridYStepUpDown', ELDesigner1.Grid.YStep);
    ELDesigner1.SnapToGrid := ini.ReadBool('wxWidgets', 'cbSnapToGrid', ELDesigner1.SnapToGrid);
    ELDesigner1.GenerateXRC := ini.ReadBool('wxWidgets', 'cbGenerateXRC', ELDesigner1.GenerateXRC);
    ELDesigner1.Floating := ini.ReadBool('wxWidgets', 'cbFloating', ELDesigner1.Floating);
    XRCGEN := ELDesigner1.GenerateXRC; //Nuklear Zelph 
    // String format tells us what function to wrap strings with in the generated C++ code
    // Possible values are wxT(), _T(), and _()
    StringFormat := ini.ReadString('wxWidgets', 'cbStringFormat', StringFormat);
    // if there's no preference saved in the ini file, then default to wxT()
    if trim(StringFormat) = '' then
      StringFormat := 'wxT';
    UseDefaultPos := ini.ReadBool('wxWidgets', 'cbUseDefaultPos', False); // ?? UseDefaultPos);
    UseDefaultSize := ini.ReadBool('wxWidgets', 'cbUseDefaultSize', False); //?? UseDefaultSize);
    UseIndividEnums := ini.ReadBool('wxWidgets', 'cbIndividualEnums', True); //?? UseIndividEnums);

    if ini.ReadBool('wxWidgets', 'cbControlHints', true) then
      ELDesigner1.ShowingHints := ELDesigner1.ShowingHints + [htControl]
    else
      ELDesigner1.ShowingHints := ELDesigner1.ShowingHints - [htControl];

    if ini.ReadBool('wxWidgets', 'cbSizeHints', true) then
      ELDesigner1.ShowingHints := ELDesigner1.ShowingHints + [htSize]
    else
      ELDesigner1.ShowingHints := ELDesigner1.ShowingHints - [htSize];

    if ini.ReadBool('wxWidgets', 'cbMoveHints', true) then
      ELDesigner1.ShowingHints := ELDesigner1.ShowingHints + [htMove]
    else
      ELDesigner1.ShowingHints := ELDesigner1.ShowingHints - [htMove];

    if ini.ReadBool('wxWidgets', 'cbInsertHints', true) then
      ELDesigner1.ShowingHints := ELDesigner1.ShowingHints + [htInsert]
    else
      ELDesigner1.ShowingHints := ELDesigner1.ShowingHints - [htInsert];
  finally
    ini.destroy;
  end;

  pnlMainInsp := TPanel.Create(frmInspectorDock);
  cbxControlsx := TComboBox.Create(frmInspectorDock);
  pgCtrlObjectInspector := TPageControl.Create(frmInspectorDock);
  TabProperty := TTabSheet.Create(frmInspectorDock);
  JvInspProperties := TJvInspector.Create(frmInspectorDock);
  TabEvent := TTabSheet.Create(frmInspectorDock);
  JvInspEvents := TJvInspector.Create(frmInspectorDock);

  with pnlMainInsp do
  begin
    Name := 'pnlMainInsp';
    Caption := '';
    Parent := frmInspectorDock;
    Left := 0;
    Top := 0;
    Width := 196;
    Height := 28;
    Align := alClient;
    BevelOuter := bvNone;
    TabOrder := 0;
  end;
  with cbxControlsx do
  begin
    Name := 'cbxControlsx';
    Parent := pnlMainInsp;
    Align := alTop;
    Left := 0;
    Top := 1;
    Width := 201;
    Height := 21;
    Style := csDropDownList;
    Enabled := False;
    ItemHeight := 13;
    Sorted := True;
    TabOrder := 0;
    OnChange := cbxControlsxChange;
  end;
  with pgCtrlObjectInspector do
  begin
    Name := 'pgCtrlObjectInspector';
    Parent := pnlMainInsp;
    Left := 0;
    Top := 28;
    Width := 196;
    Height := 79;
    ActivePage := TabProperty;
    Align := alClient;
    Enabled := False;
    TabIndex := 0;
    TabOrder := 1;
  end;
  with TabProperty do
  begin
    Name := 'TabProperty';
    Parent := pgCtrlObjectInspector;
    PageControl := pgCtrlObjectInspector;
    Caption := GetLangString(ID_WX_PROPERTIES);
    ImageIndex := -1;
  end;
  with JvInspProperties do
  begin
    Name := 'JvInspProperties';
    Parent := TabProperty;
    Left := 0;
    Top := 0;
    Width := 188;
    Height := 51;
    Align := alClient;
    BandWidth := 150;
    BevelInner := bvNone;
    RelativeDivider := False;
    Divider := 100;
    ItemHeight := 16;
    Painter := JvInspectorDotNETPainter1;
    ReadOnly := False;
    UseBands := False;
    WantTabs := False;

    // Add popup menu for Wx property inspector
    OnEditorContextPopup := WxPropertyInspectorContextPopup;
    AfterItemCreate := JvInspPropertiesAfterItemCreate;
    BeforeSelection := JvInspPropertiesBeforeSelection;
    OnDataValueChanged := JvInspPropertiesDataValueChanged;
    OnItemValueChanged := JvInspPropertiesItemValueChanged;
  end;
  with TabEvent do
  begin
    Name := 'TabEvent';
    Parent := pgCtrlObjectInspector;
    PageControl := pgCtrlObjectInspector;
    Caption := GetLangString(ID_WX_EVENTS);
    ImageIndex := -1;
  end;
  with JvInspEvents do
  begin
    Name := 'JvInspEvents';
    Parent := TabEvent;
    Left := 0;
    Top := 0;
    Width := 188;
    Height := 51;
    Align := alClient;
    BandWidth := 150;
    BevelInner := bvNone;
    RelativeDivider := False;
    Divider := 100;
    ItemHeight := 16;
    Painter := JvInspectorDotNETPainter2;
    ReadOnly := False;
    UseBands := False;
    WantTabs := False;

    // Add popup menu for Wx property inspector
    OnEditorContextPopup := WxPropertyInspectorContextPopup;
    AfterItemCreate := JvInspEventsAfterItemCreate;
    OnDataValueChanged := JvInspEventsDataValueChanged;
    OnItemValueChanged := JvInspEventsItemValueChanged;
    OnItemSelected := OnPropertyItemSelected;
    OnMouseMove := JvInspEventsMouseMove;
    OnMouseUp := JvInspEventsMouseUp;
    OnEditorKeyDown := JvInspEventsKeyDown;
  end;

  //Setting data for the newly created GUI
  intControlCount := 1000;

  boolInspectorDataClear := true;
  DisablePropertyBuilding := false;

  // Initializing compiler options pane
  lblwxMinor := TLabel.Create(ownerForm);
  with lblwxMinor do
  begin
    Left := 8;
    Top := 46;
    Width := 29;
    Height := 13;
    ParentFont := false;
    Caption := GetLangString(ID_POPT_VMINOR); //'Minor:';
  end;

  lblwxMajor := TLabel.Create(ownerForm);
  with lblwxMajor do
  begin
    Left := 8;
    Top := 19;
    Width := 29;
    Height := 13;
    ParentFont := false;
    Caption := GetLangString(ID_POPT_VMAJOR); //'Major:';
  end;

  lblwxRelease := TLabel.Create(ownerForm);
  with lblwxRelease do
  begin
    Left := 8;
    Top := 73;
    Width := 42;
    Height := 13;
    ParentFont := false;
    Caption := GetLangString(ID_POPT_VRELEASE); //'Release:';
  end;

  spwxMajor := TSpinEdit.Create(ownerForm);
  with spwxMajor do
  begin
    Left := 60;
    Top := 16;
    Width := 45;
    Height := 22;
    MaxValue := 1000;
    MinValue := 0;
    TabOrder := 0;
    Value := 2;
    ParentFont := false;
  end;

  spwxMinor := TSpinEdit.Create(ownerForm);
  with spwxMinor do
  begin
    Left := 60;
    Top := 43;
    Width := 45;
    Height := 22;
    MaxValue := 1000;
    MinValue := 0;
    TabOrder := 1;
    Value := 9;
    ParentFont := false;
  end;

  spwxRelease := TSpinEdit.Create(ownerForm);
  with spwxRelease do
  begin
    Left := 60;
    Top := 70;
    Width := 45;
    Height := 22;
    MaxValue := 1000;
    MinValue := 0;
    TabOrder := 2;
    Value := 2;
    ParentFont := false;
  end;

  grpwxVersion := TGroupBox.Create(ownerForm);
  with grpwxVersion do
  begin
    Left := 8;
    Top := 5;
    Width := 403;
    Height := 100;
    Caption := GetLangString(ID_POPT_VERTAB); //'Version';
    TabOrder := 0;
    ParentFont := false;
  end;
  grpwxVersion.InsertControl(spwxRelease);
  grpwxVersion.InsertControl(spwxMinor);
  grpwxVersion.InsertControl(spwxMajor);
  grpwxVersion.InsertControl(lblwxRelease);
  grpwxVersion.InsertControl(lblwxMajor);
  grpwxVersion.InsertControl(lblwxMinor);

  chkwxUnicode := TCheckBox.Create(ownerForm);
  with chkwxUnicode do
  begin
    Left := 8;
    Top := 16;
    Width := 130;
    Height := 17;
    Caption := 'Unicode Support';
    ParentFont := false;
    TabOrder := 0;
  end;

  chkwxMonolithic := TCheckBox.Create(ownerForm);
  with chkwxMonolithic do
  begin
    Left := 8;
    Top := 36;
    Width := 130;
    Height := 17;
    Caption := 'Monolithic Library';
    ParentFont := false;
    TabOrder := 1;
  end;

  chkwxDebug := TCheckBox.Create(ownerForm);
  with chkwxDebug do
  begin
    Left := 8;
    Top := 56;
    Width := 97;
    Height := 17;
    Caption := 'Debug Build';
    ParentFont := false;
    TabOrder := 2;
  end;

  grpwxType := TGroupBox.Create(ownerForm);
  with grpwxType do
  begin
    Left := 8;
    Top := 112;
    Width := 403;
    Height := 80;
    Caption := 'Features';
    ParentFont := false;
    TabOrder := 1;
  end;
  grpwxType.InsertControl(chkwxDebug);
  grpwxType.InsertControl(chkwxMonolithic);
  grpwxType.InsertControl(chkwxUnicode);

  rdwxLibraryType := TRadioGroup.Create(self);
  with rdwxLibraryType do
  begin
    Left := 8;
    Top := 200;
    Width := 403;
    Height := 65;
    Caption := 'Library Type';
    ItemIndex := 0;
    TabOrder := 2;
    ParentFont := false;
  end;

  staticLib := TRadioButton.Create(self);
  with staticLib do
  begin
    Left := 10;
    Top := 15;
    Width := 150;
    Height := 20;
    Caption := 'Static Import Library';
    ParentFont := false;
  end;
  staticLib.Caption := 'Static Import Library';

  dynamicLib := TRadioButton.Create(self);
  with dynamicLib do
  begin
    Left := 10;
    Top := 35;
    Width := 150;
    Height := 20;
    Caption := 'Dynamic Library (DLL)';
    ParentFont := false;
  end;

  rdwxLibraryType.InsertControl(staticLib);
  rdwxLibraryType.InsertControl(dynamicLib);

  tabwxWidgets := TTabSheet.Create(self);
  with tabwxWidgets do
  begin
    Caption := 'wxWidgets';
    ImageIndex := 4;
    Visible := true;
    ParentFont := false;
  end;

  tabwxWidgets.InsertControl(grpwxVersion);
  tabwxWidgets.InsertControl(grpwxType);
  tabwxWidgets.InsertControl(rdwxLibraryType);



end; // end Initialize

procedure TWXDsgn.AssignPlugger(plug: IPlug);
begin
  main := plug as IPlug;
  XPTheme := main.IsUsingXPTheme;
end;

procedure TWXDsgn.OpenFile(s: string);
begin
  if IsForm(s) then
  begin
    main.OpenFile(GetLongName(ChangeFileExt(s, H_EXT)), True);
    main.OpenFile(GetLongName(ChangeFileExt(s, CPP_EXT)), True);
    if ELDesigner1.GenerateXRC then
      main.OpenFile(ChangeFileExt(s, XRC_EXT), True);
  end
end;

procedure TWXDsgn.LoadText(force:Boolean);
begin
  frmInspectorDock.Caption := GetLangString(ID_WX_PROPINSPECTOR);
  frmPaletteDock.Caption := GetLangString(ID_WX_COMPONENTS);
  ShowPropertyInspItem.Caption := GetLangString(ID_WX_SHOWPROPINSPECTOR);
  ShowComponentPaletteItem.Caption := GetLangString(ID_WX_SHOWCOMPPALETTE);
  NewWxDialogItem.Caption := GetLangString(ID_WX_NEWDIALOG);
  NewWxFrameItem.Caption := GetLangString(ID_WX_NEWFRAME);

  actDesignerCopy.Caption := GetLangString(ID_ITEM_COPY);
  actDesignerCut.Caption := GetLangString(ID_ITEM_CUT);
  actDesignerPaste.Caption := GetLangString(ID_ITEM_PASTE);
  actDesignerDelete.Caption := GetLangString(ID_ITEM_DELETE);
  actNewWxFrame.Caption := GetLangString(ID_WX_NEWFRAME);

  actWxPropertyInspectorCut.Caption := GetLangString(ID_ITEM_CUT);
  actWxPropertyInspectorCopy.Caption := GetLangString(ID_ITEM_COPY);
  actWxPropertyInspectorPaste.Caption := GetLangString(ID_ITEM_PASTE);
  WxPropertyInspectorMenuEdit.Caption := GetLangString(ID_WX_PROPERTYEDIT);
  DesignerMenuEdit.Caption := GetLangString(ID_MNU_EDIT);
  DesignerMenuCopyWidgetName.Caption := GetLangString(ID_WX_COPYNAME);
  DesignerMenuChangeCreationOrder.Caption := GetLangString(ID_WX_CHANGEORDER);
  DesignerMenuSelectParent.Caption := GetLangString(ID_WX_SELECTPARENT);
  DesignerMenuLocked.Caption := GetLangString(ID_WX_LOCKCONTROL);
  DesignerMenuViewIDs.Caption := GetLangString(ID_WX_VIEWCONTROLID);
  DesignerMenuAlign.Caption := GetLangString(ID_WX_ALIGN);
  DesignerMenuAlignToGrid.Caption := GetLangString(ID_WX_TOGRID);
  DesignerMenuAlignVertical.Caption := GetLangString(ID_WX_VERTICAL);
  DesignerMenuAlignHorizontal.Caption := GetLangString(ID_WX_HORIZONTAL);
  DesignerMenuAlignToLeft.Caption := GetLangString(ID_WX_TOLEFT);
  DesignerMenuAlignToRight.Caption := GetLangString(ID_WX_TORIGHT);
  DesignerMenuAlignToMiddleVertical.Caption := GetLangString(ID_WX_TOCENTER);
  DesignerMenuAlignToMiddleHorizontal.Caption := GetLangString(ID_WX_TOCENTER);
  DesignerMenuAlignToTop.Caption := GetLangString(ID_WX_TOTOP);
  DesignerMenuAlignToBottom.Caption := GetLangString(ID_WX_TOBOTTOM);
  DesignerMenuDesignerOptions.Caption := GetLangString(ID_WX_DESIGNEROPTS);
  ToolsMenuDesignerOptions.Caption := GetLangString(ID_WX_DESIGNEROPTS);
  TabProperty.Caption := GetLangString(ID_WX_PROPERTIES);
  TabEvent.Caption := GetLangString(ID_WX_EVENTS);
  lblwxMinor.Caption := GetLangString(ID_POPT_VMINOR);
  lblwxMajor.Caption := GetLangString(ID_POPT_VMAJOR);
  lblwxRelease.Caption := GetLangString(ID_POPT_VRELEASE);
  grpwxVersion.Caption := GetLangString(ID_POPT_VERTAB);
end;

function TWXDsgn.IsForm(s: string): Boolean;
begin
  if (CompareStr(ExtractFileExt(s), WXFORM_EXT) = 0) then
    Result := True
  else
    Result := False;
end;

function TWXDsgn.GetFilter(editorName: string): string;
begin
  if isXRCExt(editorName) then
    Result := FLT_XRC
  else
    Result := FLT_WXFORMS;
end;

function TWXDsgn.Get_EXT(editorName: string): string;
begin
  if isXRCExt(editorName) then
    Result := XRC_EXT
  else
    Result := WXFORM_EXT;
end;

function TWXDsgn.Get_EXT_Index(editorName: String): Integer;
begin
  if isXRCExt(editorName) then
    Result := 8     // EAB: this should be done dinamically; giving plugins the last current index at creation time.
  else
    Result := 7;
end;

function TWXDsgn.SaveFile(EditorFilename: string): Boolean;
begin
  Result := false;
  //For a wxDev-C++ build, there are a few related editors that must be saved at
  //the same time.

  //See if the current file is a Form-related document
  //TODO: lowjoel: the following code assumes that the editor for the sibling file
  //               is open. Why do we need such a lousy restriction?
  if FileExists(ChangeFileExt(EditorFilename, WXFORM_EXT)) then
    //The current file is a form and has related files. If we save the form, all
       //the related files needs to be saved at the same time.
  begin
    if main.isFileOpenedinEditor(ChangeFileExt(EditorFilename, WXFORM_EXT)) then
    begin
      Result := main.SaveFileFromPlugin(ChangeFileExt(EditorFilename, WXFORM_EXT));

      //Just Generate XPM's while saving the file
      GenerateXPM(EditorFilename, false);
      if editors.Exists(EditorFilename) then
        (editors[ChangeFileExt(EditorFilename, WXFORM_EXT)] as TWXEditor).GetDesigner.CreateNewXPMs(EditorFilename);
    end;

    //If the user wants XRC files to be generated, save the XRC file as well
    //BUT: if the user does NOT want XRC files, we should not confuse the user
    //     and delete the file
    if ELDesigner1.GenerateXRC then
    begin
      if main.isFileOpenedinEditor(ChangeFileExt(EditorFilename, XRC_EXT)) then
      begin
        Result := Result and main.SaveFileFromPlugin(ChangeFileExt(EditorFilename, XRC_EXT));
      end;
    end
    else
      ;
    //Delete the now-outdated XRC file
    //TODO: lowjoel: safer way?

    if main.isFileOpenedinEditor(ChangeFileExt(EditorFilename, H_EXT)) then
    begin
      Result := Result and main.SaveFileFromPlugin(ChangeFileExt(EditorFilename, H_EXT));
    end;

    if main.isFileOpenedinEditor(ChangeFileExt(EditorFilename, CPP_EXT)) then
    begin
      Result := Result and main.SaveFileFromPlugin(ChangeFileExt(EditorFilename, CPP_EXT));
    end;

  end
end;

function TWXDsgn.SaveFileAndCloseEditor(EditorFilename: string): Boolean;
var
  flag: Boolean;

begin
  flag := False;
  if FileExists(ChangeFileExt(EditorFilename, WXFORM_EXT)) then
  begin
    flag := True;
    main.SaveFileFromPlugin(ChangeFileExt(EditorFilename, CPP_EXT));
    main.CloseEditorFromPlugin(ChangeFileExt(EditorFilename, CPP_EXT));

    main.SaveFileFromPlugin(ChangeFileExt(EditorFilename, H_EXT));
    main.CloseEditorFromPlugin(ChangeFileExt(EditorFilename, H_EXT));

    main.SaveFileFromPlugin(ChangeFileExt(EditorFilename, WXFORM_EXT));
    main.CloseEditorFromPlugin(ChangeFileExt(EditorFilename, WXFORM_EXT));

    main.SaveFileFromPlugin(ChangeFileExt(EditorFilename, XRC_EXT));
    main.CloseEditorFromPlugin(ChangeFileExt(EditorFilename, XRC_EXT));
  end;

  Result := flag;

end;

procedure TWXDsgn.OpenUnit(EditorFilename: string);
var
  AlreadyActivated: boolean;
begin
  AlreadyActivated := true;
  if FileExists(ChangeFileExt(EditorFilename, WXFORM_EXT)) then
  begin
    if not main.isFileOpenedinEditor(ChangeFileExt(EditorFilename, WXFORM_EXT)) then
      if not main.OpenUnitInProject(ChangeFileExt(EditorFilename, WXFORM_EXT)) then
        main.OpenFile(ChangeFileExt(EditorFilename, WXFORM_EXT), true);

    if (ELDesigner1.GenerateXRC) and FileExists(ChangeFileExt(EditorFilename, XRC_EXT))
      and (not main.isFileOpenedinEditor(ChangeFileExt(EditorFilename, XRC_EXT))) then
      if not main.OpenUnitInProject(ChangeFileExt(EditorFilename, XRC_EXT)) then
        main.OpenFile(ChangeFileExt(EditorFilename, XRC_EXT), true);

    if FileExists(ChangeFileExt(EditorFilename, H_EXT)) and (not main.isFileOpenedinEditor(ChangeFileExt(EditorFilename, H_EXT))) then
      if not main.OpenUnitInProject(ChangeFileExt(EditorFilename, H_EXT)) then
        main.OpenFile(ChangeFileExt(EditorFilename, H_EXT), true);

    if FileExists(ChangeFileExt(EditorFilename, CPP_EXT)) and (not main.isFileOpenedinEditor(ChangeFileExt(EditorFilename, CPP_EXT))) then
      if not main.OpenUnitInProject(ChangeFileExt(EditorFilename, CPP_EXT)) then
        main.OpenFile(ChangeFileExt(EditorFilename, CPP_EXT), true);

    //Reactivate the editor;
    if FileExists(EditorFilename) then
    begin
      if not main.isFileOpenedinEditor(EditorFilename) then
        main.OpenFile(EditorFilename, true)
      else
      begin
        main.ActivateEditor(EditorFilename);
        AlreadyActivated := true;
      end;
    end;
  end;
  if AlreadyActivated = false then
    main.ActivateEditor(EditorFilename);
end;

procedure TWXDsgn.NewProject(s: string);
begin
  if strContains('wxWidgets Frame', s) then
    NewWxProjectCode(dtWxFrame)
  else if strContains('wxWidgets Dialog', s) then
    NewWxProjectCode(dtWxDialog);
end;

procedure TWXDsgn.CutExecute;
begin
  if (JvInspProperties.Focused) or (JvInspEvents.Focused) then // If property inspector is focused, then cut text
    actWxPropertyInspectorCut.Execute
  else // Otherwise form component is selected so cut whole component (control and code)
    actDesignerCut.Execute
end;

procedure TWXDsgn.CopyExecute;
begin
  if (JvInspProperties.Focused) or (JvInspEvents.Focused) then // If property inspector is focused, then copy text
    actWxPropertyInspectorCopy.Execute
  else // Otherwise form component is selected so copy whole component (control and code)
    actDesignerCopy.Execute
end;

procedure TWXDsgn.PasteExecute;
begin
  if (JvInspProperties.Focused) or (JvInspEvents.Focused) then // If property inspector is focused, then paste text
    actWxPropertyInspectorPaste.Execute
  else // Otherwise form component is selected so paste whole component (control and code)
    actDesignerPaste.Execute
end;

procedure TWXDsgn.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i: Integer;
  designerFlag: Boolean;
begin

  designerFlag := true;
  if ELDesigner1.Floating then
    designerFlag := self.IsForm(main.GetActiveEditorName);

  if (ssCtrl in Shift) and ELDesigner1.Active and designerFlag and not JvInspProperties.Focused and
    not JvInspEvents.Focused and not cleanUpJvInspEvents then // If Designer Form is in focus
  begin
    case key of
      //Move the selected component
      VK_Left:
        for i := 0 to (ELDesigner1.SelectedControls.Count - 1) do
          ELDesigner1.SelectedControls.Items[i].Left := ELDesigner1.SelectedControls.Items[i].Left - 1;
      VK_Right:
        for i := 0 to (ELDesigner1.SelectedControls.Count - 1) do
          ELDesigner1.SelectedControls.Items[i].Left := ELDesigner1.SelectedControls.Items[i].Left + 1;
      VK_Up:
        for i := 0 to (ELDesigner1.SelectedControls.Count - 1) do
          ELDesigner1.SelectedControls.Items[i].Top := ELDesigner1.SelectedControls.Items[i].Top - 1;
      VK_Down:
        for i := 0 to (ELDesigner1.SelectedControls.Count - 1) do
          ELDesigner1.SelectedControls.Items[i].Top := ELDesigner1.SelectedControls.Items[i].Top + 1;
    end;


    ELDesigner1.OnModified(Sender);

    end;

end;

procedure TWXDsgn.AssignDesignerControl(editorName: string);
begin
  if editors.Exists(editorName) then
    ELDesigner1.DesignControl := (editors[editorName] as TWXEditor).GetDesigner;
end;

procedure TWXDsgn.SetDesignerActiveState(state: Boolean);
begin
  ELDesigner1.Active := state;
end;

// Get the login name to use as a default if the author name is unknown

function TWXDsgn.GetLoginName: string;
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if main.RetrieveUserName(buffer, size) then
    Result := buffer
  else
    Result := ''
end;

function TWXDsgn.GetLangString(LangID: Integer): string;
begin

Result := main.GetLangString(LangID);

end;

// Create a dialog that will be destroyed by the client code

function TWXDsgn.CreateCreateFormDlg(dsgnType: TWxDesignerType; insertProj: integer; projShow: boolean; filenamebase: string = ''): TfrmCreateFormProp;
var
  SuggestedFilename: string;
  INI: Tinifile;
  profileNames: TStrings;
  defaultProfileIndex: Integer;
begin
  if filenamebase = '' then
    SuggestedFilename := main.GetUntitledFileName
  else
    SuggestedFilename := filenamebase;
  Result := TfrmCreateFormProp.Create(self);
  Result.JvFormStorage1.RestoreFormPlacement;
  Result.JvFormStorage1.Active := False;
  Result.txtTitle.Text := SuggestedFilename;

  if dsgnType = dtWxFrame then
    Result.Caption := GetLangString(ID_WX_NEWFRAME) //'New wxWidgets Frame'
  else
    Result.Caption := GetLangString(ID_WX_NEWDIALOG); //'New wxWidgets Dialog';

  //Suggest a filename to the user
  if dsgnType = dtWxFrame then
  begin
    Result.txtFileName.Text := CreateValidFileName(SuggestedFilename + 'Frm');
    Result.txtClassName.Text := CreateValidClassName(SuggestedFilename + 'Frm');
  end
  else
  begin
    Result.txtFileName.Text := CreateValidFileName(SuggestedFilename + 'Dlg');
    Result.txtClassName.Text := CreateValidClassName(SuggestedFilename + 'Dlg');
  end;

  // Open the ini file and see if we have any default values for author, class, license
  // ReadString will return either the ini key or the default
  INI := TiniFile.Create(ConfigFolder + ChangeFileExt(ExtractFileName(Application.ExeName),'') + '.ini');
  Result.txtAuthorName.Text := INI.ReadString('wxWidgets', 'Author', GetLoginName);
  INI.free;

  // Add compiler profile names to the dropdown box
  profileNames := main.GetCompilerProfileNames(defaultProfileIndex);
  if (profileNames.Count <> 0) and (projShow = true) then // if nil, then this is not part of a project (so no profile)
  begin
    Result.ProfileNameSelect.Show;
    Result.ProfileLabel.Show;
    Result.ProfileNameSelect.Clear;
    Result.ProfileNameSelect.Items := profileNames;
    Result.ProfileNameSelect.ItemIndex := defaultProfileIndex; // default compiler profile selection
  end
  else
  begin
    Result.ProfileNameSelect.Hide;
    Result.ProfileLabel.Hide;
  end;
  //Decide where the file will be stored
  if insertProj = 1 then
    Result.txtSaveTo.Text := IncludeTrailingPathDelimiter(ExtractFileDir(main.GetProjectFileName))
  else
    Result.txtSaveTo.Text := IncludeTrailingPathDelimiter(LocalAppDataPath)
  {else if main.GetDevDirsDefault <> '' then
    Result.txtSaveTo.Text := IncludeTrailingPathDelimiter(main.GetDevDirsDefault)
  else if Trim(Result.txtSaveTo.Text) = '' then
    Result.txtSaveTo.Text := IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName));}
end;

procedure TWXDsgn.CreateNewDialogOrFrameCode(dsgnType: TWxDesignerType; frm: TfrmCreateFormProp; insertProj: integer);
var
  TemplatesDir: string;
  BaseFilename: string;
  currFile: string;
  OwnsDlg: boolean;

  strFName, strCName, strFTitle: string;
  dlgSStyle: TWxDlgStyleSet;
  strCppFile, strHppFile: string;
  INI: Tinifile;

  strLstXRCCode: TStringList;

begin
  //Get the path of our templates
  TemplatesDir := IncludeTrailingPathDelimiter(main.GetRealPathFix(main.GetDevDirsTemplates, ExtractFileDir(Application.ExeName)));

  //Get the paths of the source code
  if dsgnType = dtWxFrame then
  begin
    strCppFile := TemplatesDir + 'wxWidgets\wxFrame.cpp.code';
    strHppFile := TemplatesDir + 'wxWidgets\wxFrame.h.code';
  end
  else
  begin
    strCppFile := TemplatesDir + 'wxWidgets\wxDlg.cpp.code';
    strHppFile := TemplatesDir + 'wxWidgets\wxDlg.h.code';
  end;

  if (not fileExists(strCppFile)) then
  begin
    MessageDlg('Unable to find wxWidgets Template file: ' + strCppFile + #13 + #10#13 + #10 +
      'Please provide the template files in the template directory.', mtError, [mbOK], 0);
    exit;
  end
  else if (not fileExists(strHppFile)) then
  begin
    MessageDlg('Unable to find wxWidgets Template file: ' + strHppFile + #13#10#13#10 +
      'Please provide the template files in the template directory.', mtError, [mbOK], 0);
    exit;
  end;

  //Ask the user what he wants to do if the project parameter is set to 'prompt' (2)
  if main.IsProjectAssigned and (insertProj = 2) then
    if MessageBox(ownerForm.Handle, PChar(main.GetLangString(ID_MSG_NEWFILE)), 'wxDev-C++', MB_ICONQUESTION or MB_YESNO) = 6 then
      insertProj := 1                                   
    else
      insertProj := 0
  else if (not main.IsProjectAssigned) then
    insertProj := 0;

  //Create the dialog and ask the user if we didn't specify a dialog to use
  OwnsDlg := not Assigned(frm);
  if (not Assigned(frm)) then
  begin
    //Get an instance of the dialog
    frm := CreateCreateFormDlg(dsgnType, insertProj, false);
    //Show the dialog
    if frm.showModal <> mrOK then
    begin
      frm.Destroy;
      exit;
    end;

    //Wow, the user clicked OK: save the user name
    INI := TiniFile.Create(ConfigFolder + ChangeFileExt(ExtractFileName(Application.ExeName),'') + '.ini');
    INI.WriteString('wxWidgets', 'Author', frm.txtAuthorName.Text);
    INI.free;
  end;
    if not DirectoryExists(Trim(frm.txtSaveTo.Text)) then
    if not CreateDir(Trim(frm.txtSaveTo.Text)) then
    raise Exception.Create('Cannot create ' + ' ' + Trim(frm.txtSaveTo.Text));

  //And get the base filename
  BaseFilename := IncludeTrailingPathDelimiter(Trim(frm.txtSaveTo.Text)) + Trim(frm.txtFileName.Text);

  //OK, load the template and parse and save it
  ParseAndSaveTemplate(StrHppFile, ChangeFileExt(BaseFilename, H_EXT), frm);
  ParseAndSaveTemplate(StrCppFile, ChangeFileExt(BaseFilename, CPP_EXT), frm);
  GetIntialFormData(frm, strFName, strCName, strFTitle, dlgSStyle, dsgnType);
  CreateFormFile(strFName, strCName, strFTitle, dlgSStyle, dsgnType);

  //NinjaNL: If we have Generate XRC turned on then we need to create a blank XRC
  //         file on project initialisation
  if ELDesigner1.GenerateXRC then
  begin
    strLstXRCCode := CreateBlankXRC;
    try
      strLstXRCCode.SaveToFile(ChangeFileExt(BaseFilename, XRC_EXT));
    finally
      strLstXRCCode.Destroy;
    end;
  end;

  //Destroy the dialog if we own it
  if OwnsDlg then
    frm.Destroy;

  currFile := ChangeFileExt(BaseFilename, H_EXT);
  main.PrepareFileForEditor(currFile, insertProj, false, true, false, 'wxdsgn');

  currFile := ChangeFileExt(BaseFilename, CPP_EXT);
  main.PrepareFileForEditor(currFile, insertProj, false, true, false, 'wxdsgn');

  if (ELDesigner1.GenerateXRC) then
  begin
    currFile := ChangeFileExt(BaseFilename, XRC_EXT);
    main.PrepareFileForEditor(currFile, insertProj, false, true, false, 'wxdsgn');
  end;

  currFile := ChangeFileExt(BaseFilename, WXFORM_EXT);
  main.PrepareFileForEditor(currFile, insertProj, false, true, true, 'wxdsgn');

  UpdateDesignerData(currFile);

  if not main.IsClassBrowserEnabled then
    MessageDlg('The Class Browser is not enabled.' + #13#10#13#10 +
      'The addition of event handlers and other features of the Form ' +
      'Designer won''t work properly.' + #13#10#13#10 +
      'Please enable the Class Browser.', mtInformation, [mbOK], 0);
end;

procedure TWXDsgn.NewWxProjectCode(dsgnType: TWxDesignerType);
// This code creates a new wxWidgets project
// including c++ code, headers, and resource files
// It was scavenged from TMainForm.CreateNewDialogOrFrameCode (above).
// The template for this code should be in the \Templates directory.
//
//  For wxFrame projects, the templates are:
//       Templates\wxWidgets\wxprojFrame.cpp,
//       Templates\wxWidgets\wxprojFrame.h,
//       Templates\wxWidgets\wxprojFrameApp.cpp, and
//       Templates\wxWidgets\wxprojFrameApp.h
//
//  For wxDialog projects, the templates are:
//       Templates\wxWidgets\wxprojDlg.cpp,
//       Templates\wxWidgets\wxprojDlg.h,
//       Templates\wxWidgets\wxprojDlgApp.cpp, and
//       Templates\wxWidgets\wxprojDlgApp.h
var
  frm: TfrmCreateFormProp;
  TemplatesDir: string;
  BaseFilename: string;
  currFile: string;
  strAppCppFile, strAppHppFile, strAppRcFile: string;
  ini: Tinifile;
  UseRC: boolean;

begin

// GAR 10 Nov 2009
// Hack for Wine/Linux
// ProductName returns empty string for Wine/Linux
// for Windows, it returns OS name (e.g. Windows Vista).
if (ComputerInfo1.OS.ProductName = '') then
UseRC := false
else
UseRC := true;

  //Get the path of our templates
  TemplatesDir := IncludeTrailingPathDelimiter(main.GetRealPathFix(main.GetDevDirsTemplates, ExtractFileDir(Application.ExeName)));

  if (UseRC) then
  begin
    //Get the filepaths of the templates
    strAppRcFile := TemplatesDir + 'wxWidgets\wxprojRes.rc';
  end;

  if dsgnType = dtWxFrame then
  begin
    strAppCppFile := TemplatesDir + 'wxWidgets\wxprojFrameApp.cpp';
    strAppHppFile := TemplatesDir + 'wxWidgets\wxprojFrameApp.h';
  end
  else
  begin
    strAppCppFile := TemplatesDir + 'wxWidgets\wxprojDlgApp.cpp';
    strAppHppFile := TemplatesDir + 'wxWidgets\wxprojDlgApp.h';
  end;

  //If template files don't exist, we need to send an error message to user.
  if (not fileExists(strAppCppFile)) then
  begin
    MessageDlg('Unable to find wxWidgets Template file: ' + strAppCppFile + #13 + #10#13 + #10 +
      'Please provide the template files in the template directory.', mtError, [mbOK], 0);
    exit;
  end
  else if (not fileExists(strAppHppFile)) then
  begin
    MessageDlg('Unable to find wxWidgets Template file: ' + strAppHppFile + #13 + #10#13 + #10 +
      'Please provide the template files in the template directory.', mtError, [mbOK], 0);
    exit;
  end;

  //Create an instance of the form creation dialog and show it
  frm := CreateCreateFormDlg(dsgnType, 1, true, ChangeFileExt(ExtractFileName(main.GetProjectFileName), ''));
  if frm.showModal <> mrOK then
  begin
    frm.Destroy;
    exit;
  end;

  // Change the current profile to what the user selected in the new project dialog
  main.ChangeProjectProfile(frm.ProfileNameSelect.ItemIndex);

  //Write the current strings back as the default
  INI := TiniFile.Create(ConfigFolder + ChangeFileExt(ExtractFileName(Application.ExeName),'') + '.ini');
  INI.WriteString('wxWidgets', 'Author', frm.txtAuthorName.Text);
  INI.free;

  //Then add the application initialization code
  BaseFilename := Trim(ChangeFileExt(main.GetProjectFileName, '')) + APP_SUFFIX;
  ParseAndSaveTemplate(StrAppHppFile, ChangeFileExt(BaseFilename, H_EXT), frm);
  ParseAndSaveTemplate(StrAppCppFile, ChangeFileExt(BaseFilename, CPP_EXT), frm);

if (ComputerInfo1.OS.ProductName <> '') then
  ParseAndSaveTemplate(strAppRcFile, ChangeFileExt(BaseFilename, RC_EXT), frm);

  //Add the application entry source fle
  currFile := ChangeFileExt(BaseFilename, CPP_EXT);
  main.PrepareFileForEditor(currFile, 0, true, true, false, '');

  currFile := ChangeFileExt(BaseFilename, H_EXT);
  main.PrepareFileForEditor(currFile, 0, true, false, false, '');

  if (UseRC) then
  begin
    currFile := ChangeFileExt(BaseFilename, RC_EXT);
    main.PrepareFileForEditor(currFile, 0, true, false, false, '');
  end;

  //Finally create the form creation code
  CreateNewDialogOrFrameCode(dsgnType, frm, 1);
end;

procedure TWXDsgn.InitEditor(strFileName: string);
var
  editor: TWXEditor;
  tabSheet: TTabSheet;
  text: TSynEdit;
  editorName: string;
begin
  editorName := ChangeFileExt(strFileName, WXFORM_EXT);
  tabSheet := main.GetEditorTabSheet(editorName);
  text := main.GetEditorText(editorName);
  editor := TWXEditor.Create;
  SetLength(editorNames, editors.ItemCount + 1);
  editorNames[editors.ItemCount] := editorName;
  editors[editorName] := editor;
  editor.Init(tabSheet, text, DesignerPopup, True, editorName);
  editor.editorNumber := editors.ItemCount - 1;
end;

function TWXDsgn.CreateFormFile(strFName, strCName, strFTitle: string; dlgSStyle: TWxDlgStyleSet; dsgnType: TWxDesignerType): Boolean;
var
  FNewFormObj: TfrmNewForm;
begin
  Result := True;
  FNewFormObj := TfrmNewForm.Create(ownerForm);
  try
    try
      if dsgnType = dtWxFrame then
        FNewFormObj.Wx_DesignerType := dtWxFrame
      else
        FNewFormObj.Wx_DesignerType := dtWxDialog;

      FNewFormObj.Caption := strFTitle;
      FNewFormObj.Wx_DialogStyle := dlgSStyle; 
      FNewFormObj.Wx_Name := strCName;
      FNewFormObj.Wx_Center := True;
      FNewFormObj.fileName := strFName;
      FNewFormObj.EVT_CLOSE := 'OnClose';
      WriteComponentsToFile([FNewFormObj], ChangeFileExt(strFName, wxform_Ext));
    except
      Result := False;
    end;
  finally
    FNewFormObj.Destroy;
  end;
end;

procedure TWXDsgn.GetIntialFormData(frm: TfrmCreateFormProp; var strFName, strCName, strFTitle: string; var dlgStyle: TWxDlgStyleSet; dsgnType: TWxDesignerType);
begin
  strCName := Trim(frm.txtClassName.Text);
  strFTitle := Trim(frm.txtTitle.Text);
  strFName := IncludeTrailingPathDelimiter(Trim(frm.txtSaveTo.Text)) + Trim(frm.txtFileName.Text);

  dlgStyle := [];
  if frm.cbUseCaption.checked then
    dlgStyle := [wxCAPTION];

  if frm.cbResizeBorder.checked then
    dlgStyle := dlgStyle + [wxRESIZE_BORDER];

  if frm.cbSystemMenu.checked then
    dlgStyle := dlgStyle + [wxSYSTEM_MENU];

  if frm.cbThickBorder.checked then
    dlgStyle := dlgStyle + [wxTHICK_FRAME];

  if frm.cbStayOnTop.checked then
    dlgStyle := dlgStyle + [wxSTAY_ON_TOP];

  if frm.cbNoParent.checked then
    dlgStyle := dlgStyle + [wxDIALOG_NO_PARENT];

  if frm.cbMinButton.checked then
    dlgStyle := dlgStyle + [wxMINIMIZE_BOX];

  if frm.cbMaxButton.checked then
    dlgStyle := dlgStyle + [wxMAXIMIZE_BOX];

  if frm.cbCloseButton.checked then
    dlgStyle := dlgStyle + [wxCLOSE_BOX];
end;

procedure TWXDsgn.ParseAndSaveTemplate(template, destination: string; frm: TfrmCreateFormProp);
var
  TemplateStrings: TStringList;
  OutputString: string;
  WindowStyle: string;
  ClassName: string;
  Filename: string;
  DateStr: string;
  Author: string;
  Title: string;
  tempFileName: string;
begin
  //Determine the window style
  if frm.cbUseCaption.checked then
    WindowStyle := 'wxCAPTION | ';

  if frm.cbResizeBorder.checked then
    WindowStyle := WindowStyle + 'wxRESIZE_BORDER | ';

  if frm.cbSystemMenu.checked then
    WindowStyle := WindowStyle + 'wxSYSTEM_MENU | ';

  if frm.cbThickBorder.checked then
    WindowStyle := WindowStyle + 'wxTHICK_FRAME | ';

  if frm.cbStayOnTop.checked then
    WindowStyle := WindowStyle + 'wxSTAY_ON_TOP | ';

  if frm.cbNoParent.checked then
    WindowStyle := WindowStyle + 'wxDIALOG_NO_PARENT | ';

  if frm.cbMinButton.checked then
    WindowStyle := WindowStyle + 'wxMINIMIZE_BOX | ';

  if frm.cbMaxButton.checked then
    WindowStyle := WindowStyle + 'wxMAXIMIZE_BOX | ';

  if frm.cbCloseButton.checked then
    WindowStyle := WindowStyle + 'wxCLOSE_BOX | ';

  //Finalize the window style string
  if Length(WindowStyle) <> 0 then
    WindowStyle := Copy(WindowStyle, 0, Length(WindowStyle) - 3)
  else
    WindowStyle := '0';

  //Get the remaining properties
  ClassName := Trim(frm.txtClassName.Text);

  tempFileName := IncludeTrailingPathDelimiter(Trim(frm.txtSaveTo.Text)) + Trim(frm.txtFileName.Text);
  Filename := ExtractRelativePath(destination, tempFileName);

  DateStr := DateTimeToStr(now);
  Author := Trim(frm.txtAuthorName.Text);
  Title := Trim(frm.txtTitle.Text);
  if (FileExists(template) = false) then
  begin
    ShowMessage('Unable to find Template file ' + template);
    exit;
  end;
  //Load the strings from file
  TemplateStrings := TStringList.Create;
  try
    TemplateStrings.LoadFromFile(template);

    OutputString := TemplateStrings.text;
    strSearchReplace(OutputString, '%FILE_NAME%', Filename, [srAll]);
    strSearchReplace(OutputString, '%DEVCPP_DIR%', main.GetDevDirsExec, [srAll]);
    strSearchReplace(OutputString, '%CLASS_NAME%', ClassName, [srAll]);
    strSearchReplace(OutputString, '%AUTHOR_NAME%', Author, [srAll]);
    strSearchReplace(OutputString, '%DATE_STRING%', DateStr, [srAll]);
    strSearchReplace(OutputString, '%CLASS_TITLE%', Title, [srAll]);
    strSearchReplace(OutputString, '%CAP_CLASS_NAME%', UpperCase(ClassName), [srAll]);
    strSearchReplace(OutputString, '%CLASS_STYLE_STRING%', WindowStyle, [srAll]);

    //Replace the project only options
    if main.IsProjectAssigned then
    begin
      strSearchReplace(OutputString, '%PROJECT_NAME%', ChangeFileExt(ExtractFileName(main.GetProjectFileName), ''), [srAll]);
      strSearchReplace(OutputString, '%APP_NAME%', ChangeFileExt(ExtractFileName(main.GetProjectFileName), '') + APP_SUFFIX, [srAll]);
    end
    else
    begin
      strSearchReplace(OutputString, '%PROJECT_NAME%', '', [srAll]);
      strSearchReplace(OutputString, '%APP_NAME%', '', [srAll]);
    end;

    //Finally save the entire string to file
    SaveStringToFile(OutputString, destination);
  finally
    TemplateStrings.Destroy;
  end
end;

function TWXDsgn.CreateSourceCodes(strCppFile, strHppFile: string; FCreateFormProp: TfrmCreateFormProp; var cppCode, hppCode: string; dsgnType: TWxDesignerType): Boolean;
var
  strClassName, strClassTitle, strClassStyleString, strFileName, strDate, strAuthor: string;
  strLstHeaderCode, strLstSourceCode, strLstXRCCode: TStringList;

  function GetStyleString: string;
  var
    I: Integer;
    strLst: TStringList;
  begin
    strLst := TStringList.Create;

    if FCreateFormProp.cbUseCaption.checked then
      strLst.add('wxCAPTION');

    if FCreateFormProp.cbResizeBorder.checked then
      strLst.add('wxRESIZE_BORDER');

    if FCreateFormProp.cbSystemMenu.checked then
      strLst.add('wxSYSTEM_MENU');

    if FCreateFormProp.cbThickBorder.checked then
      strLst.add('wxTHICK_FRAME');

    if FCreateFormProp.cbStayOnTop.checked then
      strLst.add('wxSTAY_ON_TOP');

    if (dsgnType = dtWxDialog) then
      if FCreateFormProp.cbNoParent.checked then
        strLst.add('wxDIALOG_NO_PARENT');

    if FCreateFormProp.cbMinButton.checked then
      strLst.add('wxMINIMIZE_BOX');

    if FCreateFormProp.cbMaxButton.checked then
      strLst.add('wxMAXIMIZE_BOX');

    if FCreateFormProp.cbCloseButton.checked then
      strLst.add('wxCLOSE_BOX');

    if strLst.Count = 0 then
    begin
      if (dsgnType = dtWxDialog) then
      begin
        Result := 'wxDEFAULT_DIALOG_STYLE';
      end;
      if (dsgnType = dtWxFrame) then
      begin
        Result := 'wxDEFAULT_FRAME_STYLE';
      end;
    end
    else
    begin
      for I := 0 to strLst.count - 1 do // Iterate
      begin
        if i <> strLst.count - 1 then
          Result := Result + strLst[i] + ' | '
        else
          Result := Result + ' ' + strLst[i] + ' ';
      end; // for
    end;
    strLst.destroy;
  end;

  function replaceAllSymbolsInStrLst(strLst: TStrings; var strFileSrc: string):
      Boolean;
  begin
    Result := True;
    try
      strFileSrc := strLst.text;
      strSearchReplace(strFileSrc, '%FILE_NAME%', ExtractFileName(strFileName), [srAll]);
      strSearchReplace(strFileSrc, '%DEVCPP_DIR%', main.GetExec, [srAll]);
      strSearchReplace(strFileSrc, '%AUTHOR_NAME%', strAuthor, [srAll]);
      strSearchReplace(strFileSrc, '%DATE_STRING%', strDate, [srAll]);
      strSearchReplace(strFileSrc, '%CLASS_NAME%', strClassName, [srAll]);
      strSearchReplace(strFileSrc, '%CAP_CLASS_NAME%', UpperCase(strClassName), [srAll]);

      strSearchReplace(strFileSrc, '%CLASS_TITLE%', strClassTitle, [srAll]);
      strSearchReplace(strFileSrc, '%CLASS_STYLE_STRING%', strClassStyleString, [srAll]);

    finally

    end;
  end;
begin
  Result := False;
  if not assigned(FCreateFormProp) then
    exit;

  strClassName := Trim(FCreateFormProp.txtClassName.Text);
  strDate := DateTimeToStr(now);
  strAuthor := Trim(FCreateFormProp.txtAuthorName.Text);
  strClassTitle := Trim(FCreateFormProp.txtTitle.Text);
  strClassStyleString := GetStyleString();

  strFileName := IncludeTrailingPathDelimiter(Trim(FCreateFormProp.txtSaveTo.Text))
    + Trim(FCreateFormProp.txtFileName.Text);

  strLstHeaderCode := TStringList.Create;
  strLstSourceCode := TStringList.Create;

  strLstHeaderCode.LoadFromFile(strHppFile);
  strLstSourceCode.LoadFromFile(strCppFile);

  //Create Dlg Cpp Code
  replaceAllSymbolsInStrLst(strLstSourceCode, cppCode);

  //Create Dlg Hpp Code
  replaceAllSymbolsInStrLst(strLstHeaderCode, hppCode);

  strLstHeaderCode.Destroy;
  strLstSourceCode.Destroy;

  Result := SaveStringToFile(cppCode, ChangeFileExt(strFileName, CPP_EXT));
  //Create Source Code for the Cpp, H, and Form Files
  if Result then
  begin
    SaveStringToFile(hppCode, ChangeFileExt(strFileName, H_EXT));

    if (ELDesigner1.GenerateXRC) then
    begin
      strLstXRCCode := CreateBlankXRC;
      Result := SaveStringToFile(strLstXRCCode.Text, ChangeFileExt(strFileName, XRC_EXT));
      strLstXRCCode.Destroy
    end;

  end;

end;

function TWXDsgn.CreateAppSourceCodes(strCppFile, strHppFile, strAppCppFile, strAppHppFile: string; FCreateFormProp: TfrmCreateFormProp; var cppCode, hppCode, appcppCode, apphppCode: string; dsgnType: TWxDesignerType): Boolean;
// This is scavenged from TMainForm.CreateSourceCodes (above)
// It uses the template files passed to it through the file names contained in
// strCppFile,strHppFile, strAppCppFile, and strAppHppFile to create new
// .cpp and .h files based on those templates. It replaces the keywords
// in the templates (%FILE_NAME%, %CLASS_NAME%, %AUTHOR_NAME%, etc.) with
// those supplied by the user. Finally, it creates a resource file and a
// wxform file for the new project.
var
  strClassName, strClassTitle, strClassStyleString, strFileName, strDate, strAuthor: string;
  strLstHeaderCode, strLstSourceCode, strLstAppHeaderCode, strLstAppSourceCode, strLstXRCCode: TStringList;

  function GetStyleString: string;
  var
    I: Integer;
    strLst: TStringList;
  begin
    strLst := TStringList.Create;

    if FCreateFormProp.cbUseCaption.checked then
      strLst.add('wxCAPTION');

    if FCreateFormProp.cbResizeBorder.checked then
      strLst.add('wxRESIZE_BORDER');

    if FCreateFormProp.cbSystemMenu.checked then
      strLst.add('wxSYSTEM_MENU');

    if FCreateFormProp.cbThickBorder.checked then
      strLst.add('wxTHICK_FRAME');

    if FCreateFormProp.cbStayOnTop.checked then
      strLst.add('wxSTAY_ON_TOP');

    if (dsgnType = dtWxDialog) then
      if FCreateFormProp.cbNoParent.checked then
        strLst.add('wxDIALOG_NO_PARENT');

    if FCreateFormProp.cbMinButton.checked then
      strLst.add('wxMINIMIZE_BOX');

    if FCreateFormProp.cbMaxButton.checked then
      strLst.add('wxMAXIMIZE_BOX');

    if FCreateFormProp.cbCloseButton.checked then
      strLst.add('wxCLOSE_BOX');

    if strLst.Count = 0 then
    begin
      if (dsgnType = dtWxDialog) then
        Result := 'wxDEFAULT_DIALOG_STYLE';

      if (dsgnType = dtWxFrame) then
        Result := 'wxDEFAULT_FRAME_STYLE';
    end
    else
    begin
      for I := 0 to strLst.count - 1 do // Iterate
      begin
        if i <> strLst.count - 1 then
          Result := Result + strLst[i] + '  |  '
        else
          Result := Result + ' ' + strLst[i] + ' ';
      end; // for
    end;
    strLst.destroy;
  end;

  // A function within a function
  // This replaces all occurrences of several keywords in a text string

  function replaceAllSymbolsInStrLst(strLst: TStrings; var strFileSrc: string):
      Boolean;
  begin
    Result := True;
    try
      strFileSrc := strLst.text;
      strSearchReplace(strFileSrc, '%FILE_NAME%', ExtractFileName(strFileName), [srAll]);
      strSearchReplace(strFileSrc, '%DEVCPP_DIR%', main.GetExec, [srAll]);
      strSearchReplace(strFileSrc, '%AUTHOR_NAME%', strAuthor, [srAll]);
      strSearchReplace(strFileSrc, '%DATE_STRING%', strDate, [srAll]);
      strSearchReplace(strFileSrc, '%CLASS_NAME%', strClassName, [srAll]);
      strSearchReplace(strFileSrc, '%CAP_CLASS_NAME%', UpperCase(strClassName), [srAll]);

      strSearchReplace(strFileSrc, '%CLASS_TITLE%', strClassTitle, [srAll]);
      strSearchReplace(strFileSrc, '%CLASS_STYLE_STRING%', strClassStyleString, [srAll]);
      strSearchReplace(strFileSrc, '%PROJECT_NAME%', ChangeFileExt(ExtractFileName(main.GetProjectFileName), ''), [srAll]);
      strSearchReplace(strFileSrc, '%APP_NAME%', ChangeFileExt(ExtractFileName(main.GetProjectFileName), '') + APP_SUFFIX, [srAll]);

    finally

    end;
  end;
begin
  Result := False;
  if not assigned(FCreateFormProp) then
    exit;

  strClassName := Trim(FCreateFormProp.txtClassName.Text);
  strDate := DateTimeToStr(now);
  strAuthor := Trim(FCreateFormProp.txtAuthorName.Text);
  strClassTitle := Trim(FCreateFormProp.txtTitle.Text);
  strClassStyleString := GetStyleString;

  strFileName := IncludeTrailingPathDelimiter(Trim(FCreateFormProp.txtSaveTo.Text))
    + Trim(FCreateFormProp.txtFileName.Text);

  // Create a bunch of string buffers to hold the text of the template files
  strLstHeaderCode := TStringList.Create;
  strLstSourceCode := TStringList.Create;
  strLstAppHeaderCode := TStringList.Create;
  strLstAppSourceCode := TStringList.Create;

  // Load the template files into the string buffers we just created
  strLstHeaderCode.LoadFromFile(strHppFile);
  strLstSourceCode.LoadFromFile(strCppFile);
  strLstAppHeaderCode.LoadFromFile(strAppHppFile);
  strLstAppSourceCode.LoadFromFile(strAppCppFile);

  //Create Dlg Cpp Code
  replaceAllSymbolsInStrLst(strLstSourceCode, cppCode);

  //Create Dlg Hpp Code
  replaceAllSymbolsInStrLst(strLstHeaderCode, hppCode);

  //Create App Hpp Code
  replaceAllSymbolsInStrLst(strLstAppHeaderCode, apphppCode);

  //Create App Cpp Code
  replaceAllSymbolsInStrLst(strLstAppSourceCode, appcppCode);

  strLstHeaderCode.Destroy;
  strLstSourceCode.Destroy;
  strLstAppSourceCode.Destroy;
  strLstAppHeaderCode.Destroy;

  //Create Source Code for the Cpp, H, RC, and Form Files
  Result := SaveStringToFile(cppCode, ChangeFileExt(strFileName, CPP_EXT));
  if Result then
    Result := SaveStringToFile(hppCode, ChangeFileExt(strFileName, H_EXT));
  if Result then
    Result := SaveStringToFile(apphppCode, ChangeFileExt(main.GetProjectFileName, '') + APP_SUFFIX + H_EXT);
  if Result then
    Result := SaveStringToFile(appcppCode, ChangeFileExt(main.GetProjectFileName, '') + APP_SUFFIX + CPP_EXT);

  if Result and ELDesigner1.GenerateXRC then
  begin
    strLstXRCCode := CreateBlankXRC;
    Result := SaveStringToFile(strLstXRCCode.Text, ChangeFileExt(strFileName, XRC_EXT));
    strLstXRCCode.Destroy
  end;

  if Result then
    Result := SaveStringToFile('#include <wx/msw/wx.rc>', ChangeFileExt(main.GetProjectFileName, '') + APP_SUFFIX + '.rc');

end;

procedure TWXDsgn.ELDesigner1ContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
  CurrentControl: TControl;
  NewMenuItem: TMenuItem;
  strControlName: string;
  FrmInterface: IWxDesignerFormInterface;
begin
  //Create the selected control's "inheritence" tree
  if ELDesigner1.SelectedControls.Count > 0 then
  begin
    DesignerMenuSelectParent.Clear;
    DesignerMenuSelectParent.Enabled := True;
    DesignerMenuLocked.Enabled := True;

    //First check or uncheck the locking mode of the component
    CurrentControl := ELDesigner1.SelectedControls.Items[0];
    DesignerMenuLocked.Checked := ELDesigner1.GetLockMode(CurrentControl) <> [];
    DesignerMenuCut.Enabled := not DesignerMenuLocked.Checked;
    DesignerMenuDelete.Enabled := not DesignerMenuLocked.Checked;

    while CurrentControl.Parent <> nil do
    begin
      CurrentControl := CurrentControl.Parent;
      NewMenuItem := TMenuItem.Create(Self);
      if CurrentControl.GetInterface(IID_IWxDesignerFormInterface, FrmInterface) = true then
        strControlName := FrmInterface.GetFormName
      else
        strControlName := CurrentControl.Name;
      NewMenuItem.Caption := strControlName;
      NewMenuItem.OnClick := SelectParentClick;
      DesignerMenuSelectParent.Add(NewMenuItem);
    end;
  end
  else
  begin
    DesignerMenuSelectParent.Enabled := False;
    DesignerMenuLocked.Enabled := False;
  end;

  Handled := true;
  DesignerPopup.Popup(MousePos.X, MousePos.Y);
end;

procedure TWXDsgn.WxPropertyInspectorContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
  Pos: TPoint;
begin
  //Create a temporary var variable
  Pos := MousePos;
  Handled := true;

  //Convert to screen coordinates
  Windows.ClientToScreen(GetFocus, Pos);

  //Pop the menu up
  WxPropertyInspectorPopup.Popup(Pos.X, Pos.Y);
end;

procedure TWXDsgn.ELDesigner1ChangeSelection(Sender: TObject);
begin
{$IFNDEF PRIVATE_BUILD}
  try
{$ENDIF}
    if (ELDesigner1 = nil) or (ELDesigner1.DesignControl = nil) then
      Exit;

    //Make sure the Designer Form has the focus
    ELDesigner1.DesignControl.SetFocus;

    //Find the index of the current control and show its properties
    if ELDesigner1.SelectedControls.Count > 0 then
    begin
      cbxControlsx.ItemIndex :=
        cbxControlsx.Items.IndexOfObject(ELDesigner1.SelectedControls[0]);
      BuildProperties(ELDesigner1.SelectedControls[0]);
    end
    else if isCurrentPageDesigner then
      BuildProperties(GetCurrentDesignerForm);
{$IFNDEF PRIVATE_BUILD}
  finally
  end;
{$ENDIF}
end;

procedure TWXDsgn.ELDesigner1ControlDeleted(Sender: TObject;
  AControl: TControl);
var
  intCtrlPos, i: Integer;
  strCompName: string;
  wxcompInterface: IWxComponentInterface;
  editorName: string;
begin
  intCtrlPos := -1;

  for i := cbxControlsx.Items.Count - 1 downto 0 do
  begin
    if AControl.GetInterface(IID_IWxComponentInterface, wxcompInterface) then
    begin
      strCompName := AControl.Name + ':' + wxcompInterface.GetWxClassName;
      if AnsiSameText(cbxControlsx.Items[i], strCompName) then
      begin
        cbxControlsx.Items.Delete(i);
        intCtrlPos := i;
      end;
    end;
  end;

  if intCtrlPos <> -1 then
  begin
    if isCurrentPageDesigner then
    begin
      intCtrlPos := cbxControlsx.Items.IndexOfObject(GetCurrentDesignerForm);
      if ELDesigner1.SelectedControls.Count > 0 then
        FirstComponentBeingDeleted := ELDesigner1.SelectedControls[0].Name;

      SelectedComponent := GetCurrentDesignerForm;
      BuildProperties(ELDesigner1.DesignControl);

      if intCtrlPos <> -1 then
        cbxControlsx.ItemIndex := intCtrlPos;
    end;

    if AControl is TWinControl then
    begin
      for i := 0 to TWinControl(AControl).ControlCount - 1 do
      begin
        intCtrlPos := cbxControlsx.Items.IndexOfObject(TWinControl(AControl).Controls[i]);
        if intCtrlPos <> -1 then
          cbxControlsx.Items.Delete(intCtrlPos);
      end;
    end;
  end;

  editorName := main.GetActiveEditorName;
  if main.IsEditorAssigned(editorName) then
    UpdateDesignerData(editorName);

end;

procedure TWXDsgn.ELDesigner1ControlHint(Sender: TObject;
  AControl: TControl; var AHint: string);
var
  compIntf: IWxComponentInterface;
begin
  if AControl.GetInterface(IID_IWxComponentInterface, compIntf) then
  begin
    AHint := Format('%s:%s', [AControl.name, compIntf.GetWxClassName]);
  end;
end;

procedure TWXDsgn.ELDesigner1ControlInserted(Sender: TObject; AControl: TControl);
var
  I: Integer;
  compObj: TComponent;
  wxcompInterface: IWxComponentInterface;
  strClass: string;
  wxControlPanelInterface: IWxControlPanelInterface;
begin
  FirstComponentBeingDeleted := '';
  if ELDesigner1.SelectedControls.Count > 0 then
  begin
    compObj := ELDesigner1.SelectedControls[ELDesigner1.SelectedControls.Count - 1];
    ELDesigner1.SelectedControls[ELDesigner1.SelectedControls.Count - 1].BringToFront;
    ELDesigner1.SelectedControls[ELDesigner1.SelectedControls.Count - 1].Visible := true;

    if compObj.GetInterface(IID_IWxComponentInterface, wxcompInterface) then
    begin
      strClass := wxcompInterface.GetWxClassName;
      SelectedComponent := compObj;
    end;

    cbxControlsx.ItemIndex :=
      cbxControlsx.Items.AddObject(ELDesigner1.SelectedControls[ELDesigner1.SelectedControls.Count - 1].Name + ':' +
      strClass, ELDesigner1.SelectedControls[ELDesigner1.SelectedControls.Count - 1]);

  end;

  if (AControl is TWinControl) then
  begin
    //TODO: Guru: Try to create an interface to make sure whether a container has
    //a limiting control. If someone is dropping more than one control then we'll
    //make the controls's parent as the parent of SplitterWindow
    if (TWinControl(AControl).Parent <> nil) and (TWinControl(AControl).Parent is TWxSplitterWindow) then
      if TWinControl(AControl).Parent.ControlCount > 2 then
        TWinControl(AControl).Parent := TWinControl(AControl).Parent.Parent;

    if SelectedComponent <> nil then
    begin
      if (SelectedComponent is TWxNoteBookPage) then
      begin
        TWinControl(SelectedComponent).Parent := TWinControl(PreviousComponent);
        if (PreviousComponent is TWxNotebook) then
        begin
        TWxNoteBookPage(SelectedComponent).PageControl := TPageControl(PreviousComponent);
      end;

        if (PreviousComponent is TWxChoicebook) then
        begin
          TWxNoteBookPage(SelectedComponent).PageControl := TPageControl(TWxChoicebook(PreviousComponent).pgc1);
          TWxNoteBookPage(SelectedComponent).TabVisible := False;
        end;

        if (PreviousComponent is TWxListbook) then
        begin
          TWxNoteBookPage(SelectedComponent).PageControl := TPageControl(TWxListbook(PreviousComponent).pgc1);
          TWxNoteBookPage(SelectedComponent).TabVisible := False;
        end;

        if (PreviousComponent is TWxToolbook) then
        begin
          TWxNoteBookPage(SelectedComponent).PageControl := TPageControl(TWxToolbook(PreviousComponent).pgc1);
          TWxNoteBookPage(SelectedComponent).TabVisible := False;
        end;

        if (PreviousComponent is TWxTreebook) then
        begin
          TWxNoteBookPage(SelectedComponent).PageControl := TPageControl(TWxTreebook(PreviousComponent).pgc1);
          TWxNoteBookPage(SelectedComponent).TabVisible := False;
        end;
      end;

      if (SelectedComponent is TWxAuiNoteBookPage) then
      begin
        TWinControl(SelectedComponent).Parent := TWinControl(PreviousComponent);
        if (PreviousComponent is TWxAuiNotebook) then
        begin
          TWxAuiNoteBookPage(SelectedComponent).PageControl := TPageControl(PreviousComponent);
        end;
      end;

      if (SelectedComponent is TWxNonVisibleBaseComponent) and not(SelectedComponent.ClassName = 'TWxAuiPaneInfo')then
        TWxNonVisibleBaseComponent(SelectedComponent).Parent := ELDesigner1.DesignControl;

      if TfrmNewForm(ELDesigner1.DesignControl).Wx_DesignerType = dtWxFrame then
      begin
        if (SelectedComponent is TWxToolBar) then
          TWxToolBar(SelectedComponent).Parent := ELDesigner1.DesignControl;

        if (SelectedComponent is TWxStatusBar) then
          TWxStatusBar(SelectedComponent).Parent := ELDesigner1.DesignControl;
      end;

      {      //Like wxWidgets' default behaviour, fill the whole screen if only one control
      //is on the screen
      if GetWxWindowControls(ELDesigner1.DesignControl) = 1 then
        if IsControlWxWindow(Tcontrol(SelectedComponent)) then
          if TWincontrol(SelectedComponent).Parent is TForm then
            TWincontrol(SelectedComponent).Align := alClient;
      }
    end;
  end;

  PreviousComponent := nil;
  for I := 0 to ELDesigner1.SelectedControls.Count - 1 do // Iterate
  begin
    compObj := ELDesigner1.SelectedControls[i];
    if compObj is TWinControl then
      //if we drop a control to image or other static controls that are derived
      //from TWxControlPanel

      if TWinControl(compObj).Parent.GetInterface(IID_IWxControlPanelInterface, wxControlPanelInterface) then
      begin
{$IFNDEF PRIVATE_BUILD}
        try
{$ENDIF}
          if assigned(TWinControl(compObj).parent.parent) then
            TWinControl(compObj).parent := TWinControl(compObj).parent.parent;
{$IFNDEF PRIVATE_BUILD}
        except
        end;
{$ENDIF}
      end;

{$IFNDEF PRIVATE_BUILD}
    try
{$ENDIF}
      if compObj.GetInterface(IID_IWxComponentInterface, wxcompInterface) then
      begin
        Inc(intControlCount);
        wxcompInterface.SetIDName('ID_' + UpperCase(compObj.Name));
        wxcompInterface.SetIDValue(intControlCount);
      end;
{$IFNDEF PRIVATE_BUILD}
    except
    end;
{$ENDIF}
  end; // End for

  ComponentPalette.UnselectComponents;
  main.UnSetActiveControl;
  UpdateDesignerData(main.GetActiveEditorName);

  //This makes the Sizers get painted properly.
  if ELDesigner1.SelectedControls.Count > 0 then
  begin
    compObj := ELDesigner1.SelectedControls[0].parent;
    if compObj is TWinControl then
      while (compObj <> nil) do
      begin
        TWinControl(compObj).refresh;
        TWinControl(compObj).repaint;
        TWinControl(compObj) := TWinControl(compObj).parent;
      end; // for
  end;

  ELDesigner1.DesignControl.Refresh;
  ELDesigner1.DesignControl.Repaint;
end;

procedure TWXDsgn.DisableDesignerControls;
begin
  //Show a busy cursor
  Screen.Cursor := crHourglass;
  Application.ProcessMessages;

  cbxControlsx.Enabled := False;
  pgCtrlObjectInspector.Enabled := False;
  JvInspProperties.Enabled := False;
  JvInspEvents.Enabled := False;
  ComponentPalette.Enabled := False;
  ComponentPalette.Visible := False;
  palettePanel.BevelInner := bvLowered;

  ELDesigner1.Active := False;
  ELDesigner1.DesignControl := nil;

  SelectedComponent := nil;
  if boolInspectorDataClear then
  begin
    JvInspProperties.Clear;
    if Assigned(JvInspProperties.Root) then
      JvInspProperties.Root.Clear;
    JvInspEvents.Clear;
    if Assigned(JvInspEvents.Root) then
      JvInspEvents.Root.Clear;
  end;

  boolInspectorDataClear := true;
  cbxControlsx.Items.Clear;
  Screen.Cursor := crDefault;
end;

procedure TWXDsgn.EnableDesignerControls;
begin
  //TODO: Guru: I have no clue why I'm getting an error at this place.
{$IFNDEF PRIVATE_BUILD}
  try
{$ENDIF}
    if Assigned(ELDesigner1.DesignControl) then
    begin
      ELDesigner1.Active := True;
      ELDesigner1.DesignControl.SetFocus;
    end;
{$IFNDEF PRIVATE_BUILD}
  finally
{$ENDIF}
    cbxControlsx.Enabled := true;
{$IFNDEF PRIVATE_BUILD}
  end;
{$ENDIF}

    if cleanUpJvInspEvents then
    begin
        JvInspEvents.Root.Visible := true;
        JvInspProperties.Root.Visible := true;
        cleanUpJvInspEvents := false;
    end;

  pgCtrlObjectInspector.Enabled := true;
  JvInspProperties.Enabled := true;
  JvInspEvents.Enabled := True;
  palettePanel.BevelInner := bvNone;
  ComponentPalette.Enabled := True;
  ComponentPalette.Visible := True;
end;

procedure TWXDsgn.ELDesigner1ControlDoubleClick(Sender: TObject);    // EAB: Look here for designer doubleclick events
var
  i, nSlectedItem: Integer;
begin
  if JvInspEvents.Root.Count = 0 then
    exit;
  nSlectedItem := -1;
  for i := 0 to JvInspEvents.Root.Count - 1 do
  begin
    if JvInspEvents.Root.Items[i].Hidden = false then
    begin
      nSlectedItem := i;
      break;
    end;
  end;
  if nSlectedItem = -1 then
    exit;

  JvInspEvents.Show;
  //If we dont select it then the Selection Event wont get fired
  JvInspEvents.SelectedIndex := JvInspEvents.Root.Items[nSlectedItem].DisplayIndex;

  if JvInspEvents.Root.Items[nSlectedItem].Data.AsString <> '' then
  begin
    strGlobalCurrentFunction := JvInspEvents.Root.Items[nSlectedItem].Data.AsString;
    JvInspEvents.OnDataValueChanged := nil;
    JvInspEvents.Root.Items[nSlectedItem].Data.AsString := '<Goto Function>';
    JvInspEvents.Root.Items[nSlectedItem].DoneEdit(true);
    JvInspEvents.OnDataValueChanged := JvInspEventsDataValueChanged;
    JvInspEventsDataValueChanged(nil, JvInspEvents.Root.Items[nSlectedItem].Data);
  end
  else
  begin
    JvInspEvents.OnDataValueChanged := nil;
    JvInspEvents.Root.Items[nSlectedItem].Data.AsString := '<Add New Function>';
    JvInspEvents.Root.Items[nSlectedItem].DoneEdit(true);
    JvInspEvents.OnDataValueChanged := JvInspEventsDataValueChanged;
    JvInspEventsDataValueChanged(nil, JvInspEvents.Root.Items[nSlectedItem].Data);
  end;
  if pendingEditorSwitch then
  begin
    JvInspEvents.OnMouseMove := nil;
    JvInspEvents.OnMouseUp := nil;
    pendingEditorSwitch := false;
  end;
end;

procedure TWXDsgn.ELDesigner1ControlInserting(Sender: TObject;
  var AParent: TWinControl; var AControlClass: TControlClass);
var
  dlgInterface: IWxDialogNonInsertableInterface;
  tlbrInterface: IWxToolBarInsertableInterface;
  nontlbrInterface: IWxToolBarNonInsertableInterface;
  compObj: TComponent;
  I: Integer;

  function GetNonAllowAbleControlCountForFrame(winCtrl: TWinControl): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    //TODO: Guru: Weird error remover ... Shitty solution.
    FirstComponentBeingDeleted := '';

    if winCtrl = nil then
      Exit;
    Result := 0;
    for I := 0 to winCtrl.ControlCount - 1 do
    begin
      if (winCtrl.Controls[i] is TWxToolBar) or (winCtrl.Controls[i] is TWxMenuBar)
        or (winCtrl.Controls[i] is TWxStatusBar) or (winCtrl.Controls[i] is TWxPopupMenu)
        or (winCtrl.Controls[i] is TWxNonVisibleBaseComponent) then
        Continue;
      Inc(Result);
    end;
  end;

  function isSizerAvailable(winCtrl: TWinControl): Boolean;
  var
    I: Integer;
  begin
    Result := false;
    //TODO: Guru: Weird error remover ... Shitty solution.
    FirstComponentBeingDeleted := '';

    if winCtrl = nil then
      Exit;
    for I := 0 to winCtrl.ComponentCount - 1 do
    begin
      if winCtrl.Components[i] is TWxSizerPanel then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;

  procedure ShowErrorAndReset(msgstr: string);
  begin
    MessageDlg(msgstr, mtError, [mbOK], ownerForm.Handle);
    ComponentPalette.UnselectComponents;
    PreviousComponent := nil;
    AControlClass := nil;

    //Select the parent
    SendMessage(AParent.Handle, WM_LBUTTONDOWN, 0, MAKELONG(100, 100));
    PostMessage(AParent.Handle, WM_LBUTTONDOWN, 0, MAKELONG(100, 100));
    SendMessage(AParent.Handle, BM_CLICK, 0, MAKELONG(100, 100));
    PostMessage(AParent.Handle, BM_CLICK, 0, MAKELONG(100, 100));
    SendMessage(AParent.Handle, WM_LBUTTONUP, 0, MAKELONG(100, 100));
    PostMessage(AParent.Handle, WM_LBUTTONUP, 0, MAKELONG(100, 100));
  end;

begin
  if(Screen.Cursor = crDrag) then
    Screen.Cursor := crDefault;
    
  //Make sure we have a component we want to insert
  if Trim(ComponentPalette.SelectedComponent) = '' then
    Exit;

  //Make sure that the type of control is valid
  AControlClass := TControlClass(GetClass(ComponentPalette.SelectedComponent));
  if AControlClass = nil then
    Exit;

  //Do some sanity checks
  if TFrmNewForm(ELDesigner1.DesignControl).Wx_DesignerType = dtWxFrame then
  begin
    if strContainsU(ComponentPalette.SelectedComponent, 'TWxStatusBar') and
      (GetAvailableControlCount(ELDesigner1.DesignControl, 'TWxStatusBar') > 0) then
    begin
      ShowErrorAndReset('Each frame can only have one statusbar.');
      Exit;
    end;

    if strContainsU(ComponentPalette.SelectedComponent, 'TWxMenuBar') and
      (GetAvailableControlCount(ELDesigner1.DesignControl, 'TWxMenuBar') > 0) then
    begin
      ShowErrorAndReset('Each frame can only have one menubar.');
      Exit;
    end;

    if StrContainsU(ComponentPalette.SelectedComponent, 'TWxStdDialogButtonSizer') then
    begin
      ShowErrorAndReset('wxStdDialogButtonSizers can only be inserted onto a wxDialog.');
      Exit;
    end;

    //TODO: Guru: Is this dead code? Why are you checking for a wxDialog when your IF states that
    //            this part will be executed when it's a wxFrame?
    if TWinControl(AControlClass.NewInstance).GetInterface(IID_IWxToolBarInsertableInterface, tlbrInterface) then
    begin
      if not (StrContainsU(AParent.ClassName, 'TWxToolBar')) and
        not (TWinControl(AControlClass.NewInstance).GetInterface(IID_IWxToolBarNonInsertableInterface, nontlbrInterface)) then
      begin
        ShowErrorAndReset('You cannot insert Toolbar control in Dialog. Use Toolbar only in wxFrame.');
        Exit;
      end;
    end
    else
    begin
      if (not strContainsU(AParent.ClassName, 'TFrmNewForm')) and
        (AParent.Parent <> nil) and (StrContainsU(AParent.Parent.ClassName, 'TWxToolBar')) then
      begin
        ShowErrorAndReset('You cannot insert this control in a toolbar');
        Exit;
      end;

      if StrContainsU(AParent.ClassName, 'TWxToolBar') then
      begin
        ShowErrorAndReset('You cannot insert this control in a toolbar');
        Exit;
      end;

      if StrContainsU(AParent.ClassName, 'TWxAuiToolBar') then
      begin
        PreviousComponent := TWinControl(ELDesigner1.SelectedControls[0].GetParentComponent()).Parent;
        Exit;
      end;

    end;

  end
  else
  begin
    if TWinControl(AControlClass.NewInstance).GetInterface(IID_IWxDialogNonInsertableInterface, dlgInterface) then
    begin
      ShowErrorAndReset('This control cannot be used in dialogs.');
      Exit;
    end;

    if StrContainsU(ComponentPalette.SelectedComponent, 'TWxStdDialogButtonSizer') then
    begin
      if not isSizerAvailable(ELDesigner1.DesignControl) then
      begin
        ShowErrorAndReset('wxStdDialogButtonSizers need a parent sizer to attach to.'#13#10#13#10 +
          'Insert a wxBoxSizer onto the wxDialog before inserting the wxStdDialogButtonSizer.');
        Exit;
      end;

      for I := 0 to ELDesigner1.DesignControl.ComponentCount - 1 do
        if ELDesigner1.DesignControl.Components[i] is TWxSizerPanel then
          AParent := ELDesigner1.DesignControl.Components[i] as TWinControl;
    end;

  end;

  //Malcolm
  // This is the testing for the new wxAui interface stuff
  //Only wxAuiEnabled components should be allowed to be dropped onto a form when a wxAuiManager is present
  if TWinControl(AControlClass.NewInstance).GetInterface(IID_IWxAuiNonInsertableInterface, dlgInterface) and
    (GetAvailableControlCount(ELDesigner1.DesignControl, 'TWxAuiManager') > 0)
    and (ELDesigner1.SelectedControls[0] is TfrmNewForm) then
  begin
    ShowErrorAndReset('This control cannot be placed on a form where a wxAuiManager is present.'#13#10#13#10 +
      'Please use the wxAui version which contains wxAuiPaneInfo data.');
    Exit;
  end;

  //Only wxAuiEnabled components should be allowed to be dropped onto a form when a wxAuiManager is present
  if TWinControl(AControlClass.NewInstance).GetInterface(IID_IWxAuiPaneInfoInterface, dlgInterface) and
    (GetAvailableControlCount(ELDesigner1.DesignControl, 'TWxAuiManager') = 0) then
  begin
    ShowErrorAndReset('This control can only be placed onto a form where a wxAuiManager is present.'#13#10#13#10 +
      'Please place a wxAuiManager component on the form first.');
    Exit;
  end;

  // each frame/dialog can only have one wxAuiManager component
      if strContainsU(ComponentPalette.SelectedComponent, 'TWxAuiManager') and
        (GetAvailableControlCount(ELDesigner1.DesignControl, 'TWxAuiManager') > 0) then
      begin
    ShowErrorAndReset('Each frame or dialog can only have one Aui Manager.');
        Exit;
      end;

  // the user should add the wxAuiManager first before any other wxAuiComponent
  if strContainsU(ComponentPalette.SelectedComponent, 'TWxAuiBar') and
    (GetAvailableControlCount(ELDesigner1.DesignControl, 'TWxAuiManager') = 0) then
  begin
    ShowErrorAndReset('This control can only be placed onto a form where a wxAuiManager is present.'#13#10#13#10 +
      'Please place a wxAuiManager component on the form first.');
    Exit;
  end;

  if strContainsU(ComponentPalette.SelectedComponent, 'TWxAuiBar') and
    (GetAvailableControlCount(ELDesigner1.DesignControl, 'TWxAuiBar') > 3) then
  begin
    ShowErrorAndReset('Each frame or dialog can only contain four AuiToolBar designer items.');
    Exit;
    end;

  if strContainsU(ComponentPalette.SelectedComponent, 'TWxAuiToolBar') and
    ((AParent.Parent = nil) or not (StrContainsU(AParent.ClassName, 'TWxAuiBar'))) then
  begin
    ShowErrorAndReset('This component must be dropped onto a wxAuibar design aid.');
    Exit;
  end;

  // GAR 18 August 2009 - I don't think this is valid any more.
  //  You should be able to add sizers into components as of wxWidgets 2.6
 // if TWinControl(AControlClass.NewInstance) is TWxSizerPanel and not StrContainsU(AParent.ClassName, 'TWxPanel') then
 // begin
 //   if (ELDesigner1.DesignControl.ComponentCount - GetNonVisualComponentCount(TForm(ELDesigner1.DesignControl))) > 0 then
 //   begin
 //     if isSizerAvailable(ELDesigner1.DesignControl) = false then
 //     begin
 //       if GetNonAllowAbleControlCountForFrame(ELDesigner1.DesignControl) > 0 then
 //       begin
 //         ShowErrorAndReset('You cannot add a sizer if you have other controls.'#13#10#13#10 +
 //           'Please remove all the controls before adding a sizer.');
 //         Exit;
 //       end;
 //     end;
 //   end;
 // end;

  PreviousComponent := nil;
  if TWinControl(AControlClass.NewInstance) is TWxNoteBookPage then
  begin
    if ELDesigner1.SelectedControls.count = 0 then
    begin
      ShowErrorAndReset('Please select a Book Container and drop the page.');
      Exit;
    end;

    PreviousComponent := ELDesigner1.SelectedControls[0];
    if (ELDesigner1.SelectedControls[0] is TWxNoteBookPage) then
    begin
      PreviousComponent := ELDesigner1.SelectedControls[0].Parent;
      if (PreviousComponent is TWxNotebook) then
        Exit
      else
      begin
        if (PreviousComponent is TPageControl) then
        begin
          PreviousComponent := PreviousComponent.GetParentComponent;
          Exit
        end
        else
        begin
          PreviousComponent := PreviousComponent.GetParentComponent; // this should be enough to do the page dropping
          ShowMessage('non notebook');

      Exit;
    end;
      end;
    end;

    if not (ELDesigner1.SelectedControls[0] is TWxChoiceBook) and
      not (ELDesigner1.SelectedControls[0] is TWxNoteBook) and
      not (ELDesigner1.SelectedControls[0] is TWxListBook) and
      not (ELDesigner1.SelectedControls[0] is TWxToolBook) and
      not (ELDesigner1.SelectedControls[0] is TWxTreeBook) and
      not (ELDesigner1.SelectedControls[0] is TPageControl) then
    begin
      ShowErrorAndReset('Please select a Book Container and drop the page.');
      Exit;
    end;
  end;

  if TWinControl(AControlClass.NewInstance) is TWxAuiNoteBookPage then
 begin
   if ELDesigner1.SelectedControls.count = 0 then
   begin
      ShowErrorAndReset('Please select a wxAuiNoteBook Container and drop the page.');
     Exit;
   end;

    PreviousComponent := ELDesigner1.SelectedControls[0];
    if (ELDesigner1.SelectedControls[0] is TWxAuiNoteBookPage) then
   begin
      PreviousComponent := ELDesigner1.SelectedControls[0].Parent;
      if (PreviousComponent is TWxAuiNotebook) then
        Exit
      else
      begin
        ShowMessage('Please select a wxAuiNoteBook Container and drop the page.');
     Exit;
   end;
 end;
  end;

  /// Fix for Bug Report #1060562
  if TWinControl(AControlClass.NewInstance) is TWxToolButton then
  begin
    if ELDesigner1.SelectedControls.count = 0 then
    begin
      ShowErrorAndReset('Please select either a Toolbar or AuiToolbar before dropping this control.');
      Exit;
    end;

    PreviousComponent := ELDesigner1.SelectedControls[0];
    if (ELDesigner1.SelectedControls[0] is TWxToolBar) then
    begin
      PreviousComponent := ELDesigner1.SelectedControls[0].Parent;
      Exit;
    end;

{mn
    if (ELDesigner1.SelectedControls[0] is TWxAuiToolBar) then
    begin
      PreviousComponent := TWinControl(ELDesigner1.SelectedControls[0].GetParentComponent()).Parent;
      Exit;
    end;
}
    if (not (ELDesigner1.SelectedControls[0] is TWxToolBar)) and (not (ELDesigner1.SelectedControls[0] is TWxAuiToolBar)) then
    begin
      ShowErrorAndReset('Please select either a Toolbar or AuiToolbar before dropping this control.');
      Exit;
    end;
  end;

  if TControl(AControlClass.NewInstance) is TWxSeparator then
  begin
    if ELDesigner1.SelectedControls.count = 0 then
    begin
      ShowErrorAndReset('Please select either a Toolbar or AuiToolbar before dropping this control.');
      Exit;
    end;

    PreviousComponent := ELDesigner1.SelectedControls[0];
    if (ELDesigner1.SelectedControls[0] is TWxToolBar) then
    begin
      PreviousComponent := ELDesigner1.SelectedControls[0].Parent;
      Exit;
    end;

    if (ELDesigner1.SelectedControls[0] is TWxAuiToolBar) then
    begin
      PreviousComponent := TWinControl(ELDesigner1.SelectedControls[0].GetParentComponent()).Parent;
      Exit;
    end;

    if (not (ELDesigner1.SelectedControls[0] is TWxToolBar)) and (not (ELDesigner1.SelectedControls[0] is TWxAuiToolBar)) then
    begin
      ShowErrorAndReset('Please select either a Toolbar or AuiToolbar before dropping this control.');
      Exit;
    end;
  end;

  {
    if TControl(AControlClass.NewInstance).GetInterface(IID_IWxToolBarInsertableInterface, tlbrInterface) then
    begin
      if (ELDesigner1.SelectedControls[0] is TWxAuiToolBar) then
      begin
        PreviousComponent := TWinControl(ELDesigner1.SelectedControls[0].GetParentComponent()).Parent;
      Exit;
    end;
  end;
  }
end;

procedure TWXDsgn.ELDesigner1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Shift = [ssCtrl] then
  begin
    if (Key = Ord('C')) then
      ELDesigner1.Copy;
    if (Key = Ord('X')) then
      ELDesigner1.Cut;
    if (Key = Ord('V')) then
      ELDesigner1.Paste;
  end;

  // Need to hijack delete function in designer form
  // so that the proper code cleanup is done
  if (Key = VK_DELETE) then
  begin
        actDesignerDeleteExecute(nil);
  end;

end;

procedure TWXDsgn.ELDesigner1Modified(Sender: TObject);
begin
  if not DisablePropertyBuilding then
    ELDesigner1ChangeSelection(Sender);
  JvInspProperties.RefreshValues;
  UpdateDesignerData(main.GetActiveEditorName);
end;

procedure TWXDsgn.BuildProperties(Comp: TControl; boolForce: Boolean);
var
  strValue: string;
  strSelName, strCompName: string;
begin
  if not boolForce then
  begin
    if DisablePropertyBuilding = true then
      Exit;
    if Assigned(SelectedComponent) then
      strSelName := SelectedComponent.Name;
    if Assigned(comp) then
      strCompName := comp.Name;

    PreviousStringValue := '';
    if AnsiSameText(strSelName, strCompName) then
    begin
      SelectedComponent := Comp;
      Exit;
    end;

    if FirstComponentBeingDeleted = Comp.Name then
      Exit;
  end;

  if Comp = nil then
    Exit;

  SelectedComponent := Comp;

  if JvInspProperties.Root <> nil then
    if JvInspProperties.Root.Data <> nil then
{$IFNDEF PRIVATE_BUILD}
      try
{$ENDIF}
        strValue := TWinControl(TJvInspectorPropData(JvInspProperties.Root.Data).Instance).Name;
{$IFNDEF PRIVATE_BUILD}
      except
        Exit;
      end;
{$ENDIF}

  //Populate the properties list
  JvInspProperties.BeginUpdate;
  JvInspProperties.Root.Clear;
  TJvInspectorPropData.New(JvInspProperties.Root, Comp);
  JvInspProperties.EndUpdate;

  //And the events list
  JvInspEvents.BeginUpdate;
  JvInspEvents.Root.Clear;
  TJvInspectorPropData.New(JvInspEvents.Root, Comp);
  JvInspEvents.EndUpdate;
end;

procedure TWXDsgn.BuildComponentList(Designer: TfrmNewForm);
var
  i: Integer;
  intControlMaxValue: Integer;
  wxcompInterface: IWxComponentInterface;
begin
  intControlMaxValue := -1;
  cbxControlsx.Clear;
  cbxControlsx.Items.BeginUpdate;

  cbxControlsx.AddItem(Designer.Wx_Name + ':' + Trim(Designer.Wx_Class),
    Designer);
  for I := 0 to Designer.ComponentCount - 1 do // Iterate
  begin
    if Designer.Components[i].GetInterface(IID_IWxComponentInterface,
      wxcompInterface) then
    begin
      cbxControlsx.AddItem(Designer.Components[i].Name + ':' +
        wxcompInterface.GetWxClassName, Designer.Components[i]);
      if wxcompInterface.GetIDValue > intControlMaxValue then
      begin
        intControlMaxValue := wxcompInterface.GetIDValue;
      end;
    end;
  end; // for

  // Correct ID numbers > 32768
  if (intControlMaxValue > 32768) then
  begin
    intControlMaxValue := 1001;
     for I := 0 to Designer.ComponentCount - 1 do // Iterate
    if Designer.Components[i].GetInterface(IID_IWxComponentInterface,
      wxcompInterface) then
    begin
        wxcompInterface.SetIDValue(intControlMaxValue);
        intControlMaxValue := intControlMaxValue + 1;
    end

  end;

  cbxControlsx.Items.EndUpdate;

  if intControlMaxValue = -1 then
    intControlMaxValue := 1000;

  intControlCount := intControlMaxValue;

  if cbxControlsx.Items.Count > 0 then
    cbxControlsx.ItemIndex := 0;

end;

procedure TWXDsgn.JvInspPropertiesAfterItemCreate(Sender: TObject; Item: TJvCustomInspectorItem);
var
  I: Integer;
  StrCompName, StrCompCaption: string;
  boolOk: Boolean;
  strLst: TStringList;
  strTemp: string;
  wxcompInterface: IWxComponentInterface;
begin
  boolOk := False;
  if SelectedComponent = nil then
    Exit;

  if not Assigned(Item) then
    Exit;

  if SelectedComponent <> nil then
  begin
    if IsValidClass(SelectedComponent) then
    begin
      strTemp := SelectedComponent.ClassName;
      if SelectedComponent.GetInterface(IID_IWxComponentInterface, wxcompInterface) then
        strLst := wxcompInterface.GetPropertyList
      else
        strLst := nil;

{$IFNDEF PRIVATE_BUILD}
      try
{$ENDIF}
        if strLst <> nil then
        begin
          if strLst.Count > 0 then
            strLst[0] := strLst[0];
        end
        else
          Exit;
{$IFNDEF PRIVATE_BUILD}
      except
        Exit;
      end;
{$ENDIF}

      //Populate the std wx Ids for the ID_Name selection
      if AnsiSameText('Wx_IDName', trim(Item.DisplayName)) then
      begin
        Item.Flags := Item.Flags + [iifValueList, iifAllowNonListValues];
        Item.OnGetValueList := OnStdWxIDListPopup;
      end;

      for I := 0 to strLst.Count - 1 do // Iterate
      begin
        StrCompName := trim(ExtractComponentPropertyName(strLst[i]));
        StrCompCaption := trim(ExtractComponentPropertyCaption(strLst[i]));
        if AnsiSameText(StrCompName, trim(Item.DisplayName)) then
        begin
          if AnsiSameText(Item.Data.TypeInfo.Name, 'TCaption') then
            Item.Flags := Item.Flags - [iifMultiLine];
          if AnsiSameText(Item.Data.TypeInfo.Name, 'TPicture') then
            Item.Flags := Item.Flags + [iifEditButton];
          if AnsiSameText(Item.Data.TypeInfo.Name, 'TListItems') then
            Item.Flags := Item.Flags + [iifEditButton];
          if AnsiSameText(Item.Data.TypeInfo.Name, 'TTreeNodes') then
            Item.Flags := Item.Flags + [iifEditButton];

          Item.DisplayName := StrCompCaption;
          boolOk := true;
          Break;
        end;
      end; // for
    end;
  end;
  Item.Hidden := not boolOk;
end;

function TWXDsgn.GetCurrentFileName: string;
begin
  Result := main.GetActiveEditorName;
end;

function TWXDsgn.GetCurrentClassName: string;
var
  editorName: string;
begin
  editorName := main.GetActiveEditorName;
  Result := trim((editors[editorName] as TWXEditor).GetDesigner().Wx_Name);
end;

procedure TWXDsgn.JvInspPropertiesDataValueChanged(Sender: TObject;
  Data: TJvCustomInspectorData);
var
  idxName: Integer;
  comp: TComponent;
  wxcompInterface: IWxComponentInterface;
  strValue, strDirName, editorName: string;
  cppStrLst, hppStrLst: TStringList;
begin
  if JvInspProperties.Selected <> nil then
  begin

    if assigned(JvInspProperties.Selected.Data) then
    begin
      strValue := JvInspProperties.Selected.Data.TypeInfo.Name;
      if (UpperCase(strValue) = UpperCase('TPicture')) or
        (UpperCase(strvalue) = UpperCase('TComponentName')) then
      begin
        strValue := TJvInspectorPropData(JvInspProperties.Selected.Data).Instance.ClassName;
        if main.IsEditorAssigned then
        begin
          editorName := main.GetActiveEditorName;
          if ( (UpperCase(SelectedComponent.ClassName) = UpperCase('TFrmNewForm'))
            and (not TFrmNewForm(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).KeepFormat) ) then
            GenerateXPMDirectly(TFrmNewForm(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Wx_ICON.Bitmap, (editors[editorName] as TWXEditor).GetDesigner.Wx_Name, 'Self', editorName);

          if ( ( UpperCase(SelectedComponent.ClassName) = UpperCase('TWxStaticBitmap') )
            and (not TWxStaticBitmap(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).KeepFormat) ) then
            GenerateXPMDirectly(TWxStaticBitmap(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Picture.Bitmap, SelectedComponent.Name, (editors[editorName] as TWXEditor).GetDesigner.Wx_Name, editorName);

          if ((UpperCase(SelectedComponent.ClassName) = UpperCase('TWxBitmapButton'))
            and (not TWxBitmapButton(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).KeepFormat) ) then
            GenerateXPMDirectly(TWxBitmapButton(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Wx_Bitmap.Bitmap, SelectedComponent.Name, (editors[editorName] as TWXEditor).GetDesigner.Wx_Name, editorName);

          if ( (UpperCase(SelectedComponent.ClassName) = UpperCase('TWxCustomButton'))
            and (not TWxCustomButton(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).KeepFormat) ) then
            GenerateXPMDirectly(TWxCustomButton(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Wx_Bitmap.Bitmap, SelectedComponent.Name, (editors[editorName] as TWXEditor).GetDesigner.Wx_Name, editorName);

          if ( (UpperCase(SelectedComponent.ClassName) = UpperCase('TWxToolButton'))
           and (not TWxToolButton(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).KeepFormat) ) then
            GenerateXPMDirectly(TWxToolButton(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Wx_Bitmap.Bitmap, SelectedComponent.Name, (editors[editorName] as TWXEditor).GetDesigner.Wx_Name, editorName);

        end;
      end;
    end;

    if UpperCase(Trim(JvInspProperties.Selected.DisplayName)) = UpperCase('NAME') then
    begin
      if not main.IsClassBrowserEnabled then
        Exit;

      comp := Self.SelectedComponent;
      idxName := cbxControlsx.Items.IndexOfObject(comp);
      if idxName <> -1 then
      begin
        if comp is TfrmNewForm then
        begin
          if comp.GetInterface(IID_IWxComponentInterface, wxcompInterface) then
          begin

            if AnsiSameText('ID_' + PreviousComponentName, wxcompInterface.GetIDName()) then
            begin
              wxcompInterface.SetIDName(UpperCase('ID_' + comp.Name));
            end;

            cbxControlsx.Items[idxName] := TfrmNewForm(comp).Wx_Name + ':' + wxcompInterface.GetWxClassName;
            cbxControlsx.ItemIndex := idxName;
            //Update the ClassName using PreviousStringValue
            if main.IsEditorAssigned then
            begin
              editorName := main.GetActiveEditorName;
              hppStrLst := TStringList.Create;
              cppStrLst := TStringList.Create;
              hppStrLst.Duplicates := dupIgnore;
              cppStrLst.Duplicates := dupIgnore;
              try
                main.GetClassNameLocationsInEditorFiles(hppStrLst, cppStrLst, ChangeFileExt(editorName, CPP_EXT), PreviousStringValue, TfrmNewForm(comp).Wx_Name);
                ReplaceClassNameInEditor(hppStrLst, main.GetEditorText(ChangeFileExt(editorName, H_EXT)), PreviousStringValue, TfrmNewForm(comp).Wx_Name);
                ReplaceClassNameInEditor(cppStrLst, main.GetEditorText(ChangeFileExt(editorName, CPP_EXT)), PreviousStringValue, TfrmNewForm(comp).Wx_Name);
                if ((hppStrLst.count = 0) and (cppStrLst.count = 0)) then
                  MessageDlg('Unable to get Class Information. Please rename the class name in H/CPP files manually. If you dont rename it them, then the Designer wont work. ', mtWarning, [mbOK], 0)
                else
                begin
                  MessageDlg('Contructor Function(in Header) or Sometimes all the Functions(in Source)  might not be renamed. ' + #13 + #10 + '' + #13 + #10 + 'Please rename them manually.' + #13 + #10 + '' + #13 + #10 + 'We hope to fix this bug asap.' + #13 + #10 + 'Sorry for the trouble.', mtInformation, [mbOK], 0);
                  strDirName := IncludeTrailingPathDelimiter(ExtractFileDir(editorName));
                  RenameFile(strDirName + '\' + PreviousStringValue + '_XPM.xpm', strDirName + '\' + TfrmNewForm(comp).Wx_Name + '_XPM.xpm');
                  Designerfrm.GenerateXPM((editors[editorName] as TWXEditor).GetDesigner, editorName, true);
                end;
              finally
                hppStrLst.Destroy;
                cppStrLst.Destroy;
              end;
            end;
          end
          else
          begin
            MessageDlg('Some problem !!!', mtWarning, [mbOK], 0);
          end;
        end
        else
        begin
          if comp.GetInterface(IID_IWxComponentInterface, wxcompInterface) then
          begin
            if AnsiSameText('ID_' + PreviousComponentName, wxcompInterface.GetIDName()) then
            begin
              wxcompInterface.SetIDName(UpperCase('ID_' + comp.Name));
            end;
            cbxControlsx.Items[idxName] := comp.Name + ':' + wxcompInterface.GetWxClassName;
            cbxControlsx.ItemIndex := idxName;
          end;
        end;
      end;
    end;
    UpdateDefaultFormContent;
  end;
end;

procedure TWXDsgn.JvInspEventsAfterItemCreate(Sender: TObject;
  Item: TJvCustomInspectorItem);
var
  I: Integer;
  StrCompName, StrCompCaption: string;
  boolOk: Boolean;
  strLst: TStringList;
  strTemp: string;
  wxcompInterface: IWxComponentInterface;
begin
  boolOk := false;
  Item.Hidden := true;

  if SelectedComponent <> nil then
  begin
    if IsValidClass(SelectedComponent) then
    begin
      strTemp := SelectedComponent.ClassName;
      if SelectedComponent.GetInterface(IID_IWxComponentInterface,
        wxcompInterface) then
        strLst := wxcompInterface.GetEventList
      else
        strLst := nil;

      if strLst = nil then
        exit;
      try
        if strLst.Count > 0 then
          strLst[0] := strLst[0];
      except
        Exit;
      end;

      for I := 0 to strLst.Count - 1 do // Iterate
      begin
        StrCompName := trim(ExtractComponentPropertyName(strLst[i]));
        StrCompCaption := trim(ExtractComponentPropertyCaption(strLst[i]));
        if AnsiSameText(StrCompName, trim(Item.DisplayName)) then
        begin
          Item.DisplayName := StrCompCaption;
          Item.Flags := Item.Flags + [iifValueList, iifAllowNonListValues];
          Item.OnGetValueList := OnEventPopup;
          boolOk := true;
          break;
        end;
      end; // for
    end;

  end;

  //  if Item is TJvInspectorBooleanItem then
  //    TJvInspectorBooleanItem(Item).ShowAsCheckbox := True;

  Item.Hidden := not boolOk;
  //Item.Hidden:= false;
end;

function TWXDsgn.IsCurrentPageDesigner: Boolean;
var
  wx: TfrmNewForm;
  editorName: string;
begin
  Result := False;

  editorName := main.GetActiveEditorName;

  if not main.IsEditorAssigned(editorName) then
    Exit;

  if isForm(editorName) then
    wx := (editors[editorName] as TWXEditor).GetDesigner()
  else
    Exit;

  if not Assigned(wx) then
    Result := false
  else
    Result := true;
end;

function TWXDsgn.IsDelphiPlugin: Boolean;
begin
  Result := True;
end;

function TWXDsgn.LocateFunction(strFunctionName: string): boolean;
begin
  Result := False;
end;

function TWXDsgn.GetCurrentDesignerForm: TfrmNewForm;
var
  editorName: string;
begin
  Result := nil;

  if not main.IsEditorAssigned then
    Exit;

  editorName := main.GetActiveEditorName;
  if isForm(editorName) then
    Result := (editors[editorName] as TWXEditor).GetDesigner();
end;

procedure TWXDsgn.JvInspEventsDataValueChanged(Sender: TObject;
  Data: TJvCustomInspectorData);       // EAB *** Look here for after doubleclick designer components event and event inspector
var
  propertyName, wxClassName, propDisplayName, strNewValue, str, ErrorString: string;
  componentInstance: TComponent;
  boolIsFilesDirty: Boolean;
  editorName: string;
  strDisplayName: string;
  compSelectedOne: TComponent;
  switchEditor: Boolean;

  procedure SetPropertyValue(Comp: TComponent; strPropName, strPropValue: string);
  var
    PropInfo: PPropInfo;
  begin
    { Get info record for Enabled property }
    PropInfo := GetPropInfo(Comp.ClassInfo, strPropName);
    { If property exists, set value to False }
    if Assigned(PropInfo) then
      SetStrProp(Comp, PropInfo, strPropValue);
  end;
begin
  switchEditor := false;
  try
    //Do some sanity checks
    if (JvInspEvents.Selected = nil) or (not JvInspEvents.Selected.Visible) then
      Exit;

    editorName := main.GetActiveEditorName;
    if not main.IsEditorAssigned(editorName) or not IsForm(editorName) then
      Exit;

    //Then get the value as a string
    strNewValue := Data.AsString;

    //See we have to do with our new value
    if strNewValue = '<Add New Function>' then
    begin
      if not main.IsClassBrowserEnabled then
      begin
        MessageDlg('The Class Browser is not enabled; wxDev-C++ will be unable to' +
          'create an event handler for you.'#10#10'Please see Help for instructions ' +
          'on enabling the Class Browser', mtWarning, [mbOK], ownerForm.Handle);
        JvInspEvents.OnDataValueChanged := nil;
        Data.AsString := '';
        JvInspEvents.OnDataValueChanged := JvInspEventsDataValueChanged;
        Exit;
      end;

      boolIsFilesDirty := false;
      if main.IsFileOpenedInEditor(ChangeFileExt(editorName, H_EXT)) then
        boolIsFilesDirty := main.IsEditorModified(ChangeFileExt(editorName, H_EXT));

      if not boolIsFilesDirty then
        if main.IsFileOpenedInEditor(ChangeFileExt(editorName, CPP_EXT)) then
          boolIsFilesDirty := main.IsEditorModified(ChangeFileExt(editorName, CPP_EXT));

      if boolIsFilesDirty then
      begin
        if main.IsFileOpenedInEditor(ChangeFileExt(editorName, H_EXT)) then
          //This wont open a new editor window
          main.SaveFileFromPlugin(ChangeFileExt(editorName, H_EXT), true);

        if main.IsFileOpenedInEditor(ChangeFileExt(editorName, CPP_EXT)) then
          //This wont open a new editor window
          main.SaveFileFromPlugin(ChangeFileExt(editorName, CPP_EXT), true);
      end;

      //TODO: Guru: add code to make sure the files are saved properly
      if SelectedComponent <> nil then
      begin
        str := JvInspEvents.Selected.DisplayName;

        if SelectedComponent is TfrmNewForm then
          str := TfrmNewForm(SelectedComponent).Wx_Name + Copy(str, 3, Length(str))
        else
          str := SelectedComponent.Name + Copy(str, 3, Length(str));
        JvInspEvents.OnDataValueChanged := nil;
        Data.AsString := str;
        JvInspEvents.OnDataValueChanged := JvInspEventsDataValueChanged;
        str := Trim(str);

        componentInstance := SelectedComponent;
        propertyName := Data.Name;
        wxClassName := Trim((editors[editorName] as TWXEditor).getDesigner().Wx_Name);
        propDisplayName := JvInspEvents.Selected.DisplayName;
        if CreateFunctionInEditor(wxClassName, SelectedComponent, str, propDisplayName, ErrorString) then
        begin
          SetPropertyValue(componentInstance, propertyName, str);

          // EAB: commented ugly ass problematic hack and replaced with corresponding code. Still ugly, but not as problematic :)

          JvInspEvents.OnDataValueChanged := nil;
          Data.AsString := str;
          JvInspEvents.OnDataValueChanged := JvInspEventsDataValueChanged;

          // Now trigger a Goto function to display the new C++ code
          // BEGIN Goto Function trigger
          strGlobalCurrentFunction := str; // Pass the name of the new function
          JvInspEvents.OnDataValueChanged := nil;
          Data.AsString := '<Goto Function>';
          JvInspEvents.Root.DoneEdit(true);
          JvInspEvents.OnDataValueChanged := JvInspEventsDataValueChanged;
          JvInspEventsDataValueChanged(nil, Data);

          // END Goto Function trigger
        end
        else
        begin
          Data.AsString := '';
          if ErrorString = '' then
            MessageDlg('Unable to add function', mtError, [mbOK], 0)
          else
            MessageDlg(ErrorString, mtError, [mbOK], 0);
        end;
      end;
    end
    else if strNewValue = '<Goto Function>' then
    begin
      //Reset the value, we won't need the <Goto> value anymore
      Data.AsString := strGlobalCurrentFunction;
      strGlobalCurrentFunction := '';

      if not main.IsClassBrowserEnabled then
      begin
        MessageDlg('The Class Browser has been disabled; All event handling ' +
          'automation code will not work.'#10#10'See Help for instructions on ' +
          'enabling the Class Browser.', mtError, [mbOK], 0);
        Exit;
      end;

      if main.IsFileOpenedInEditor(ChangeFileExt(editorName, H_EXT)) then
        main.SaveFileFromPlugin(ChangeFileExt(editorName, H_EXT), true);

      if main.IsFileOpenedInEditor(ChangeFileExt(editorName, CPP_EXT)) then
        main.SaveFileFromPlugin(ChangeFileExt(editorName, CPP_EXT), true);

      if SelectedComponent <> nil then
      begin
        str := trim(Data.AsString);
        strDisplayName := JvInspEvents.Selected.DisplayName;
        compSelectedOne := SelectedComponent;
        LocateFunctionInEditor(Data, Trim((editors[editorName] as TWXEditor).getDesigner().Wx_Name), compSelectedOne,
          str, strDisplayName);

        switchEditor := true;

        if(strNewValue = '<Goto Function>') and ((editors[editorName] as TWXEditor).getDesigner().Floating) then
            main.SendToFront;
      end;
    end
    else if strNewValue = '<Remove Function>' then
      Data.AsString := '';

    JvInspEvents.Root.DoneEdit(true);
    UpdateDefaultFormContent;

     if switchEditor then
     begin
        cleanUpJvInspEvents := true;
        main.SetPageControlActivePageEditor(ChangeFileExt(editorName, CPP_EXT));
        JvInspProperties.Root.Visible := false;
        JvInspEvents.Root.Visible := false;

        pendingEditorSwitch := true;
        JvInspEvents.OnMouseMove := JvInspEventsMouseMove;
        JvInspEvents.OnMouseUp := JvInspEventsMouseUp;
        JvInspEvents.OnEditorKeyDown := JvInspEventsKeyDown;

      end;

  except
    on E: Exception do
      MessageBox(ownerForm.Handle, PChar(E.Message), PChar(Application.Title), MB_ICONERROR or MB_OK or MB_TASKMODAL);
  end;
end;

procedure TWXDsgn.JvInspEventsMouseMove(Sender: TObject; Shift: TShiftState; X: Integer; Y:Integer);
begin
  if pendingEditorSwitch then
  begin
    JvInspEvents.OnMouseMove := nil;
    JvInspEvents.OnMouseUp := nil;
    JvInspEvents.OnEditorKeyDown := nil;
    pendingEditorSwitch := false;
    main.forceEditorFocus;
  end;
end;

procedure TWXDsgn.JvInspEventsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y:Integer);
begin
  if pendingEditorSwitch then
  begin
    JvInspEvents.OnMouseMove := nil;
    JvInspEvents.OnMouseUp := nil;
    JvInspEvents.OnEditorKeyDown := nil;
    pendingEditorSwitch := false;
    main.forceEditorFocus;
  end;
end;

procedure TWXDsgn.JvInspEventsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if pendingEditorSwitch then
  begin
    JvInspEvents.OnMouseMove := nil;
    JvInspEvents.OnMouseUp := nil;
    JvInspEvents.OnEditorKeyDown := nil;
    pendingEditorSwitch := false;
    main.forceEditorFocus;
    Key := 0;
  end;
end;

procedure TWXDsgn.JvInspEventsItemValueChanged(Sender: TObject;
  Item: TJvCustomInspectorItem);
begin
  if JvInspEvents.Selected = nil then
    Exit;

  if JvInspEvents.Selected.Visible = False then
    Exit;
end;

procedure TWXDsgn.OnStdWxIDListPopup(Item: TJvCustomInspectorItem; Value: TStrings);
begin
  Value.Clear;
  Value.Assign(strStdwxIDList);
end;

procedure TWXDsgn.OnEventPopup(Item: TJvCustomInspectorItem; Value: TStrings);
var
  boolNoFunction: Boolean;
  strPrevvalue: string;
  strClassesLst: TStringList;
  idx: Integer;
begin
  strGlobalCurrentFunction := '';
  if not isCurrentPageDesigner then
    Exit;

  strPrevvalue := Item.Data.AsString;
  if Trim(strPrevvalue) = '' then
    boolNoFunction := true
  else
    boolNoFunction := false;

  Value.Clear;
  if boolNoFunction then
  begin
    Value.Add('<Add New Function>');
    strClassesLst := TStringList.Create;
    try
      strClassesLst.Sorted := True;
      if IsCurrentPageDesigner then
        main.GetFunctionsFromSource(GetCurrentDesignerForm().Wx_Name, strClassesLst);
      Value.AddStrings(strClassesLst);
    finally
      strClassesLst.Destroy;
    end;
  end;

  if Trim(strPrevvalue) <> '' then
  begin
    //Add other functions here...
    strClassesLst := TStringList.Create;
    try
      strClassesLst.Sorted := True;
      if IsCurrentPageDesigner then
        main.GetFunctionsFromSource(GetCurrentDesignerForm().Wx_Name, strClassesLst);
      Value.AddStrings(strClassesLst);
    finally
      strClassesLst.Destroy;
    end;
    //if Function list is not available in CPPParser
    idx := Value.IndexOf(strPrevvalue);
    if idx = -1 then
    begin
      Value.Add(strPrevvalue);
      idx := Value.IndexOf(strPrevvalue);
    end;

    if idx <> -1 then
    begin
      Value.Insert(idx + 1, '<Goto Function>');
      strGlobalCurrentFunction := strPrevvalue;
    end;

    Value.Add('<Remove Function>');

    strPrevvalue := Item.Parent.ClassName;
    strPrevvalue := Item.Parent.ClassName;
  end;

end;

procedure TWXDsgn.UpdateDesignerData(FileName: string);
var
  STartTimeX: longword;
  temp: string;

  function GetElapsedTimeStr(StartTime: LongWord): string;
  begin
    Result := Format('%.3f seconds', [(GetTickCount - StartTime) / 1000]);
  end;
begin
  if isForm(FileName) then
  begin
    StartTimeX := GetTickCount;
    main.EditorInsertDefaultText(FileName);
    temp := 'C++ Source Generation: ' + GetElapsedTimeStr(StartTimeX);
    main.UpdateEditor(ChangeFileExt(FileName, CPP_EXT), temp);
    StartTimeX := GetTickCount;
    main.UpdateEditor(ChangeFileExt(FileName, H_EXT), temp + ' / Header Declaration Generation = ' + GetElapsedTimeStr(StartTimeX));
  end;
  if ELDesigner1.GenerateXRC then
    UpdateXRC(FileName);

end;

function TWXDsgn.LocateFunctionInEditor(eventProperty: TJvCustomInspectorData; strClassName: string; SelComponent: TComponent; var strFunctionName: string; strEventFullName: string): Boolean;
var
  strOldFunctionName: string;
  strFname: string;
  intLineNum: Integer;
  stID: Integer;
  boolFound: Boolean;
  editorName: string;
  e_text: TSynEdit;
begin
  Result := False;
  boolFound := False;
  intLineNum := 0;

  if not main.IsEditorAssigned then
    Exit;

  editorName := main.GetActiveEditorName;

  if not isForm(editorName) then
    Exit;

  StID := main.FindStatementID(strClassName, boolFound);

  if not boolFound then
    Exit;

  if main.isFunctionAvailableInEditor(StID, strOldFunctionName, intLineNum, strFname) then
  begin
    boolInspectorDataClear := False;
    editorName := strFname;
    main.OpenFile(editorName);
    if main.IsEditorAssigned(editorName) then
    begin
      //TODO: check for a valid line number
      e_text := main.GetEditorText(editorName);
      e_text.CaretX := 0;
      e_text.CaretY := intLineNum;
    end;
    boolInspectorDataClear := False;
  end;
end;

function TWXDsgn.isCurrentFormFilesNeedToBeSaved: Boolean;
var
  editorName: string;
begin
  Result := false;

  editorName := main.GetActiveEditorName;
  if not main.IsEditorAssigned(editorName) then
    Exit;

  if not isForm(editorName) then
    Exit;

  if not main.IsEditorAssigned(editorName) then // <-- EAB: This shouldn't be executing...¿?
  begin
    MessageDlg('Unable to Get the Designer Info.', mtError, [mbOK], 0);
    Exit;
  end;

  if not main.IsEditorAssigned(ChangeFileExt(editorName, H_EXT)) then
  begin
    MessageDlg('Unable to Get Header File Editor Info.', mtError, [mbOK], 0);
    Exit;
  end;

  if not main.IsEditorAssigned(ChangeFileExt(editorName, CPP_EXT)) then
  begin
    MessageDlg('Unable to Get Source File Editor Info.', mtError, [mbOK], 0);
    Exit;
  end;
  if ((main.IsEditorModified(editorName) = true) or (main.IsEditorModified(ChangeFileExt(editorName, H_EXT)) = true) or (main.IsEditorModified(ChangeFileExt(editorName, CPP_EXT)))) then
    Result := true
  else
    Result := false;

end;

function TWXDsgn.saveCurrentFormFiles: Boolean;
var
  editorName: string;
begin
  Result := false;

  editorName := main.GetActiveEditorName;
  if not main.IsEditorAssigned(editorName) then
    Exit;

  if not isForm(editorName) then
    Exit;

  Result := true;
  main.SaveFileFromPlugin(editorName, true);

  if main.IsFileOpenedInEditor(ChangeFileExt(editorName, H_EXT)) then
  begin
    main.SaveFileFromPlugin(ChangeFileExt(editorName, H_EXT), true);
  end;

  if main.IsFileOpenedInEditor(ChangeFileExt(editorName, CPP_EXT)) then
  begin
    main.SaveFileFromPlugin(ChangeFileExt(editorName, CPP_EXT), true);
  end;
end;

function TWXDsgn.CreateFunctionInEditor(var strFunctionName: string; strReturnType, strParameter: string;
  var ErrorString: string; strClassName: string): Boolean;
var
  intFunctionCounter: Integer;
  strOldFunctionName: string;
  Line: Integer;
  AddScopeStr: Boolean;
  VarType: string;
  VarArguments: string;
  StID: Integer;
  boolFound: Boolean;
  editorName: string;
  CppEditor, Hppeditor: TSynEdit;
begin
  Result := false;
  boolFound := false;
  AddScopeStr := false;
  editorName := main.GetActiveEditorName;
  if not main.IsEditorAssigned(editorName) or not isForm(editorName) then
    Exit;

  //Give us a class name if none is specified
  if strClassName = '' then
    strClassName := trim((editors[editorName] as TWXEditor).GetDesigner.Wx_Name);

  StID := main.FindStatementID(strClassName, boolFound);

  if not boolFound then
    Exit;

  //Come up with an unused function name
  intFunctionCounter := 0;
  strOldFunctionName := strFunctionName;
  while main.isFunctionAvailable(StID, strFunctionName) do
  begin
    strFunctionName := strOldFunctionName + IntToStr(intFunctionCounter);
    Inc(intFunctionCounter);
  end;

  //Temp Settings Start
  VarType := strReturnType;
  VarArguments := strParameter;

  if trim(VarType) = '' then
    VarType := 'void';

  if trim(VarArguments) = '' then
    VarArguments := 'void';
  //Temp Settings End

  Line := main.GetSuggestedInsertionLine(StID, AddScopeStr);
  if Line = -1 then
    Exit;

  Hppeditor := main.GetEditorText(ChangeFileExt(editorName, H_EXT));
  CppEditor := main.GetEditorText(ChangeFileExt(editorName, CPP_EXT));

  if Assigned(HppEditor) then
  begin
    if AnsiStartsText('////GUI Control Declaration End', Trim(Hppeditor.Lines[Line])) then
      Line := Line + 1;

    Hppeditor.Lines.Insert(Line, Format(#9#9'%s %s(%s);', [VarType, strFunctionName, VarArguments]));
    if AddScopeStr then
      Hppeditor.Lines.Insert(Line, #9'public:');
    main.TouchEditor(ChangeFileExt(editorName, H_EXT));
  end;

  if Assigned(CppEditor) then
  begin
    // insert the implementation
    if Trim(CppEditor.Lines[CppEditor.Lines.Count - 1]) <> '' then
      CppEditor.Lines.Append('');

    // insert the comment
    CppEditor.Lines.Append('/*');
    Cppeditor.Lines.Append(' * ' + strFunctionName);
    Cppeditor.Lines.Append(' */');

    // and the function body
    Cppeditor.Lines.Append(Format('%s %s::%s(%s)', [VarType, strClassName, strFunctionName, VarArguments]));
    Cppeditor.Lines.Append('{');
    Cppeditor.Lines.Append(#9'// insert your code here');
    Cppeditor.Lines.Append('}');
    Cppeditor.Lines.Append('');

    Result := True;
    CppEditor.CaretY := CppEditor.Lines.Count;
    main.TouchEditor(ChangeFileExt(editorName, CPP_EXT));
    UpdateDesignerData(editorName);
  end;
end;

function TWXDsgn.CreateFunctionInEditor(strClassName: string; SelComponent: TComponent;
  var strFunctionName: string; strEventFullName: string;
  var ErrorString: string): Boolean;
var
  VarType, VarArguments, strEName: string;
  intfObj: IWxComponentInterface;
begin
  //Assemble the function prototype
  VarType := 'void';
  VarArguments := '';

  //Parse the event string to get the parts of the declaration
  if SelComponent.GetInterface(IID_IWxComponentInterface, intfObj) then
  begin
    strEName := Trim(GetEventNameFromDisplayName(strEventFullName, intfObj.GetEventList));
    VarType := intfObj.GetTypeFromEventName(strEName);
    VarArguments := intfObj.GetParameterFromEventName(strEName);
  end;

  //If we have no return type assume it to be void
  if trim(VarType) = '' then
    VarType := 'void';

  //Then call the actual function
  Result := CreateFunctionInEditor(strFunctionName, VarType, VarArguments, ErrorString, strClassName);
end;

procedure TWXDsgn.UpdateDefaultFormContent;
var
  editorName: string;
begin
  editorName := main.GetActiveEditorName;

  if not main.IsEditorAssigned(editorName) then
    Exit;

  if not isForm(editorName) then
    Exit;

  UpdateDesignerData(editorName);
end;

procedure TWXDsgn.cbxControlsxChange(Sender: TObject);
var
  strCompName: string;
  compControl: TComponent;
  intColPos: Integer;

  function GetComponentFromName(strCompName: string): TComponent;
  var
    I: Integer;
    frmNewFormX: TfrmNewForm;
    editorName: string;
  begin
    Result := nil;

    editorName := main.GetActiveEditorName;
    frmNewFormX := (editors[editorName] as TWXEditor).GetDesigner();

    if Assigned(frmNewFormX) = False then
      Exit;

    for I := 0 to frmNewFormX.ComponentCount - 1 do // Iterate
    begin
      if AnsiSameText(trim(frmNewFormX.Components[i].Name), trim(strCompName)) then
      begin
        Result := frmNewFormX.Components[i];
        exit;
      end;
    end;
  end;

begin
  if cbxControlsx.ItemIndex = -1 then
    exit;

  if not isCurrentPageDesigner then
    Exit;

  strCompName := trim(cbxControlsx.Items[cbxControlsx.ItemIndex]);
  intColPos := Pos(':', strCompName);
  if intColPos <> 0 then
  begin
    strCompName := Trim(Copy(strCompName, 0, intColPos - 1));
  end;

  compControl := GetComponentFromName(strCompName);
  if compControl <> nil then
  begin
    ELDesigner1.SelectedControls.Clear;
    ELDesigner1.SelectedControls.Add(TWinControl(compControl));
    BuildProperties(TControl(compControl));
  end
  else
  begin
    ELDesigner1.SelectedControls.Clear;
    BuildProperties(TControl(GetCurrentDesignerForm()));
  end;

end;

procedure TWXDsgn.actDesignerCopyExecute(Sender: TObject);
begin
  if ELDesigner1.CanCopy then
    ELDesigner1.Copy;
end;

procedure TWXDsgn.actDesignerCutExecute(Sender: TObject);
begin
  if IsFromScrollBarShowing then
  begin
    MessageDlg('The Designer Form is scrolled. ' + #13 + #10 + '' + #13 + #10 + 'Please resize the form to hide the scrollbar before deleting controls.', mtError, [mbOK], 0);
    exit;
  end;

  BuildProperties(ELDesigner1.DesignControl, true);
  DisablePropertyBuilding := True;
{$IFNDEF PRIVATE_BUILD}
  try
{$ENDIF}
    if ELDesigner1.CanCut then
      ELDesigner1.Cut;
{$IFNDEF PRIVATE_BUILD}
  except
  end;
{$ENDIF}
  DisablePropertyBuilding := False;

  ELDesigner1.SelectedControls.Clear;
  ELDesigner1.SelectedControls.Add(ELDesigner1.DesignControl);
  BuildProperties(ELDesigner1.DesignControl);
end;

procedure TWXDsgn.actDesignerPasteExecute(Sender: TObject);
begin
  if IsFromScrollBarShowing then
  begin
    MessageDlg('The Designer Form is scrolled. ' + #13 + #10 + '' + #13 + #10 + 'Please resize the form to hide the scrollbar before deleting controls.', mtError, [mbOK], 0);
    exit;
  end;

  BuildProperties(ELDesigner1.DesignControl, true);
  DisablePropertyBuilding := true;
{$IFNDEF PRIVATE_BUILD}
  try
{$ENDIF}
    if ELDesigner1.CanPaste then
      ELDesigner1.Paste;
{$IFNDEF PRIVATE_BUILD}
  except
  end;
{$ENDIF}
  DisablePropertyBuilding := false;

  ELDesigner1.SelectedControls.Clear;
  ELDesigner1.SelectedControls.Add(ELDesigner1.DesignControl);
  BuildProperties(ELDesigner1.DesignControl);
end;

function TWXDsgn.IsFromScrollBarShowing: boolean;
begin
  if ((TFrmNewForm(ELDesigner1.DesignControl).HorzScrollBar.IsScrollBarVisible = true) or
    (TFrmNewForm(ELDesigner1.DesignControl).VertScrollBar.IsScrollBarVisible = true)) then
    result := true
  else
    result := false;
end;

procedure TWXDsgn.actDesignerDeleteExecute(Sender: TObject);
begin
  BuildProperties(ELDesigner1.DesignControl, true);
  DisablePropertyBuilding := true;
  ELDesigner1.DeleteSelectedControls;
  DisablePropertyBuilding := false;

  GetCurrentDesignerForm();
  ELDesigner1.SelectedControls.Clear;
  ELDesigner1.SelectedControls.Add(ELDesigner1.DesignControl);
  BuildProperties(ELDesigner1.SelectedControls[0]);

end;

procedure TWXDsgn.JvInspPropertiesBeforeSelection(Sender: TObject;
  NewItem: TJvCustomInspectorItem; var Allow: Boolean);
begin
  Allow := True;
  if not Assigned(NewItem) then
    Exit;

  if not Assigned(NewItem.Data) then
    Exit;
  try
    if AnsiSameText(NewItem.DisplayName, 'name') and
      AnsiSameText(NewItem.Data.Name, 'wx_Name') then
      PreviousStringValue := NewItem.Data.AsString;
    if AnsiSameText(NewItem.DisplayName, 'name') then
      PreviousComponentName := NewItem.Data.AsString
  except
  end;

end;

function TWXDsgn.ReplaceClassNameInEditor(strLst: TStringList; text: TSynEdit; FromClassName, ToClassName: string): boolean;
var
  I: Integer;
  lineNum: Integer;
  lineStr: string;

  function IsNumeric(s: string): boolean;
  var
    i: integer;
  begin
    result := true;
    for i := 1 to length(s) do
      if not (s[i] in ['0'..'9']) then
      begin
        result := false;
        exit;
      end;
  end;
begin
  Result := False;
  if strLst.Count < 1 then
    exit;

  for I := 0 to strLst.Count - 1 do // Iterate
  begin
    if not IsNumeric(strLst[i]) then
      continue;
    lineNum := StrToInt(strLst[i]);
    if lineNum > text.Lines.Count then
      continue;
    try
      lineStr := text.Lines[lineNum];

      strSearchReplace(lineStr, FromClassName, ToClassName, [srWord, srCase, srAll]);
      text.Lines[lineNum] := lineStr;
    except

    end;
  end; // for

  //TODO: Guru: Is there a better way of implementing the class search and replace?
  for I := 0 to text.Lines.Count - 1 do // Iterate
  begin
    try
      lineStr := text.Lines[i];
      strSearchReplace(lineStr, FromClassName + '::' + FromClassName, ToClassName + '::' + ToClassName, [srWord, srCase, srAll]);
      strSearchReplace(lineStr, '~' + FromClassName, '~' + ToClassName, [srWord, srCase, srAll]);
      strSearchReplace(lineStr, ' ' + FromClassName + '(', ' ' + ToClassName + '(', [srWord, srCase, srAll]);
      text.Lines[i] := lineStr;

    except
    end;
  end; // for

  Result := True;

end;

procedure TWXDsgn.JvInspPropertiesItemValueChanged(Sender: TObject;
  Item: TJvCustomInspectorItem);
begin
  //sendDebug('Yes it is changed!!!');
end;

procedure TWXDsgn.DesignerOptionsClick(Sender: TObject);
begin
  with TDesignerForm.Create(self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TWXDsgn.AlignToGridClick(Sender: TObject);
begin
  ELDesigner1.SelectedControls.AlignToGrid;
end;

procedure TWXDsgn.AlignToLeftClick(Sender: TObject);
begin
  ELDesigner1.SelectedControls.Align(atLeftTop, atNoChanges);
end;

procedure TWXDsgn.AlignToRightClick(Sender: TObject);
begin
  ELDesigner1.SelectedControls.Align(atRightBottom, atNoChanges);
end;

procedure TWXDsgn.AlignToMiddleHorizontalClick(Sender: TObject);
begin
  ELDesigner1.SelectedControls.Align(atCenter, atNoChanges);
end;

procedure TWXDsgn.AlignToMiddleVerticalClick(Sender: TObject);
begin
  ELDesigner1.SelectedControls.Align(atNoChanges, atCenter);
end;

procedure TWXDsgn.AlignToTopClick(Sender: TObject);
begin
  ELDesigner1.SelectedControls.Align(atNoChanges, atLeftTop);
end;

procedure TWXDsgn.AlignToBottomClick(Sender: TObject);
begin
  ELDesigner1.SelectedControls.Align(atNoChanges, atRightBottom);
end;

procedure TWXDsgn.ViewControlIDsClick(Sender: TObject);
var
  vwCtrlIDsFormObj: TViewControlIDsForm;
begin
  vwCtrlIDsFormObj := TViewControlIDsForm.Create(self);

  vwCtrlIDsFormObj.SetMainControl(TWinControl(ELDesigner1.DesignControl));
  vwCtrlIDsFormObj.PopulateControlList;
  vwCtrlIDsFormObj.ShowModal;
end;

procedure TWXDsgn.ChangeCreationOrder1Click(Sender: TObject);
var
  Control: TWinControl;
  editorName, hppEditor, cppEditor: string;
begin
  if main.GetPageControlActivePageIndex = -1 then
    exit;

  if ELDesigner1.SelectedControls.Count = 0 then
    exit;
  //Attempt to get a control that has sub-controls
  Control := TWinControl(ELDesigner1.SelectedControls.Items[0]);
  while Control.Parent <> nil do
  begin
    if Control.ControlCount > 1 then
      Break;
    Control := Control.Parent;
  end;

  //We give up - there isn't one to use
  if Control.ControlCount = 0 then
  begin
    //MessageDlg('You cannot do anything with this control. '+#13+'Select its parent Dialog or Sizer.', mtError, [mbOK], 0);
    Exit;
  end;

  if MessageDlg('All Designer related Files will be saved before proceeding.' + #13 + #10 + '' + #13 + #10 + 'Do you want to continue ?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    exit;

  editorName := main.GetActiveEditorName;
  if not main.IsEditorAssigned(editorName) then
    Exit;

  hppEditor := ChangeFileExt(editorName, H_EXT);
  if main.IsFileOpenedInEditor(hppEditor) then
  begin
    if main.IsEditorAssigned(hppEditor) then
    begin
      main.SaveFileFromPlugin(hppEditor, true);
    end;
  end;

  cppEditor := ChangeFileExt(editorName, CPP_EXT);
  if main.IsFileOpenedInEditor(cppEditor) then
  begin
    if main.IsEditorAssigned(cppEditor) then
    begin
      main.SaveFileFromPlugin(cppEditor, true);
    end;
  end;

  main.SaveFileFromPlugin(editorName, true);

  with TCreationOrderForm.Create(Self) do
    try
      SetMainControl(Control);
      PopulateControlList;
      ShowModal;
    finally
      Free
    end;

  ELDesigner1.Active := false;
  ELDesigner1.DesignControl := nil;

  //This should copy the Form's content to the Text Editor
  main.EditorInsertDefaultText(editorName);

  //Save form file
  main.SetEditorModified(editorName, true);

  main.SaveFileFromPlugin(editorName, true);
  (editors[editorName] as TWXEditor).ReloadForm;
  UpdateDesignerData(editorName);

  if main.IsFileOpenedInEditor(hppEditor) then
  begin
    if main.IsEditorAssigned(hppEditor) then
    begin
      main.SaveFileFromPlugin(hppEditor, true);
    end;
  end;

  if main.IsFileOpenedInEditor(cppEditor) then
  begin
    if main.IsEditorAssigned(cppEditor) then
    begin
      main.SaveFileFromPlugin(cppEditor, true);
    end;
  end;

  main.SaveFileFromPlugin(editorName, true);

  ELDesigner1.DesignControl := (editors[editorName] as TWXEditor).GetDesigner;
  BuildComponentList((editors[editorName] as TWXEditor).GetDesigner);
  ELDesigner1.Active := true;

end;

procedure TWXDsgn.SelectParentClick(Sender: TObject);
var
  ActiveControl: TControl;
  SelectedItem: TMenuItem;
  SelectedLevel: integer;
begin
  //Get all the information we need
  SelectedItem := TMenuItem(Sender);
  SelectedLevel := SelectedItem.Parent.IndexOf(SelectedItem) + 1;
  ActiveControl := ELDesigner1.SelectedControls.Items[0];

  //Select the control we want
  while SelectedLevel > 0 do
  begin
    ActiveControl := ActiveControl.Parent;
    SelectedLevel := SelectedLevel - 1;
  end;

  //Set set the active control
  ELDesigner1.SelectedControls.Clear;
  ELDesigner1.SelectedControls.Add(ActiveControl);
end;

procedure TWXDsgn.LockControlClick(Sender: TObject);
var
  I: Integer;
begin
  //Do we lock or unlock them?
  if not DesignerMenuLocked.Checked then
    for I := 0 to ELDesigner1.SelectedControls.Count - 1 do
      ELDesigner1.LockControl(ELDesigner1.SelectedControls[I], [lmNoMove, lmNoResize, lmNoDelete, lmNoInsertIn])
  else
    for I := 0 to ELDesigner1.SelectedControls.Count - 1 do
      ELDesigner1.LockControl(ELDesigner1.SelectedControls[I], []);
end;

procedure TWXDsgn.OnPropertyItemSelected(Sender: TObject);
begin
  if assigned(SelectedComponent) then
  begin
    if SelectedComponent is TFrmNewForm then
      PreviousComponentName := TFrmNewForm(SelectedComponent).Wx_Name
    else
      PreviousComponentName := SelectedComponent.Name;
  end;
end;

procedure TWXDsgn.actNewWxFrameExecute(Sender: TObject);
begin
  CreateNewDialogOrFrameCode(dtWxFrame, nil, 2);
end;

procedure TWXDsgn.actNewwxDialogExecute(Sender: TObject);
begin
  CreateNewDialogOrFrameCode(dtWxDialog, nil, 2);
end;

procedure TWXDsgn.actWxPropertyInspectorCutExecute(Sender: TObject);
begin
  SendMessage(GetFocus, WM_CUT, 0, 0);
end;

procedure TWXDsgn.actWxPropertyInspectorCopyExecute(Sender: TObject);
begin
  SendMessage(GetFocus, WM_COPY, 0, 0);
end;

procedure TWXDsgn.actWxPropertyInspectorPasteExecute(Sender: TObject);
begin
  SendMessage(GetFocus, WM_PASTE, 0, 0);
end;

procedure TWXDsgn.actWxPropertyInspectorDeleteExecute(Sender: TObject);
begin
  if (GetFocus <> 0) then
    SendMessage(GetFocus, WM_CLEAR, 0, 0)
  else
    MessageDlg('nothing selected', mtError, [mbOK], 0);

end;

procedure TWXDsgn.GenerateSource(sourceFileName: string; text: TSynEdit);
var
  editorName, ext: string;
begin
  ext := ExtractFileExt(sourceFileName);
  editorName := ChangeFileExt(sourceFileName, WXFORM_EXT);
  if ext = CPP_EXT then
    GenerateCpp((editors[editorName] as TWXEditor).GetDesigner, (editors[editorName] as TWXEditor).GetDesigner().Wx_Name, text)
  else if ext = H_EXT then
    GenerateHpp((editors[editorName] as TWXEditor).GetDesigner, (editors[editorName] as TWXEditor).GetDesigner().Wx_Name, text);
end;

procedure TWXDsgn.ActivateDesigner(s: string);
begin
  if isForm(s) then
  begin
    if Assigned((editors[s] as TWXEditor).GetDesigner()) then
    begin
      ELDesigner1.Active := False;
      try
        ELDesigner1.DesignControl := (editors[s] as TWXEditor).GetDesigner();
        ELDesigner1.Active := True;
      except
      end;
      BuildComponentList((editors[s] as TWXEditor).GetDesigner());
    end;
  end;
end;

procedure TWXDsgn.UpdateXRC(editorName: string);
var
  resourceName: string;
  text: TSynEdit;
begin
  if IsForm(editorName) then
  begin

    if (ELDesigner1.GenerateXRC) then
      resourceName := ChangeFileExt(editorName, XRC_EXT);
    if FileExists(resourceName) then
    begin
      main.OpenFile(resourceName, true);

      if main.IsEditorAssigned(resourceName) then
      begin
        text := main.GetEditorText(resourceName);
        text.BeginUpdate;
        try
          GenerateXRC((editors[editorName] as TWXEditor).GetDesigner(), (editors[editorName] as TWXEditor).GetDesigner().Wx_Name, text, editorName);
          main.SetEditorModified(resourceName, true);
        except
        end;
        main.TouchEditor(resourceName);
        text.EndUpdate;
      end;

      {  if Assigned(e) then
        begin
          try
             e.Text.ClearAll;

             e.Text.Lines.Append('<?xml version="1.0" encoding="ISO-8859-1"?>');
             e.Text.Lines.Append('<resource xmlns="http://www.wxwidgets.org/wxxrc" version="2.3.0.1">');


            GenerateCpp(fDesigner, fDesigner.Wx_Name, e.Text,e.FileName);
            e.Modified:=true;

             e.Text.Lines.Append('</object>');
             e.Text.Lines.Append('</object>');
             e.Text.Lines.Append('</resource>');

          except
          end;
        end;
        }
    end;

  end;
end;

procedure TWXDsgn.GenerateXPM(s: string; b: Boolean);
begin
  if editors.Exists(s) then
    Designerfrm.GenerateXPM((editors[s] as TWXEditor).GetDesigner, s, b);
end;

procedure TWXDsgn.SetBoolInspectorDataClear(b: Boolean);
begin
  boolInspectorDataClear := b;
end;

function TWXDsgn.GetFilters: TStringList;
var
  filters: TStringList;
begin
  filters := TStringList.Create;
  filters.Add(FLT_WXFORMS);
  filters.Add(FLT_XRC);
  Result := filters;
end;

function TWXDsgn.GetSrcFilters: TStringList;
var
  filters: TStringList;
begin
  filters := TStringList.Create;
  filters.Add(FLT_XRC);
  Result := filters;
end;

procedure TWXDsgn.SetDisablePropertyBuilding(b: Boolean);
begin
  DisablePropertyBuilding := b;
end;

procedure TWXDsgn.Reload(FileName: string);
begin
  (editors[FileName] as TWXEditor).ReloadForm;
end;

function TWXDsgn.ReloadForm(FileName: string): Boolean;
begin
  Result := false;
  if isForm(FileName) then
  begin
    (editors[FileName] as TWXEditor).ReloadFormFromFile(FileName);
    Result := true;
  end;
end;

procedure TWXDsgn.ReloadFromFile(FileName: string; fileToReloadFrom: string);
begin
  (editors[FileName] as TWXEditor).ReloadFormFromFile(fileToReloadFrom);
end;

procedure TWXDsgn.TerminateEditor(FileName: string);
begin
  if (editors.Exists(FileName)) then
  begin
    (editors[FileName] as TWXEditor).Terminate;
    editors.Delete(FileName);
  end;
end;

procedure TWXDsgn.Destroy;
begin
  editors.Free;
  ComponentPalette.Free;
  JvInspProperties.Free;
  JvInspEvents.Free;
  JvInspectorDotNETPainter1.Free;
  JvInspectorDotNETPainter2.Free;
  ComputerInfo1.Free;
  main := nil;
end;

procedure TWXDsgn.OnDockableFormClosed(Sender: TObject; var Action: TCloseAction);
begin
  if TForm(Sender) = frmInspectorDock then
  begin
    ShowPropertyInspItem.Checked := False
  end
  else if TForm(Sender) = frmPaletteDock then
  begin
    ShowComponentPaletteItem.Checked := False
  end;

end;

function TWXDsgn.IsSource(FileName: string): Boolean;
begin
  Result := not isForm(FileName);
end;

function TWXDsgn.GetDefaultText(FileName: string): string;
begin
  Result := (editors[FileName] as TWXEditor).GetDefaultText;
end;

function TWXDsgn.MainPageChanged(FileName: string): Boolean;
begin
  Result := false;
  if IsForm(FileName) then
  begin
    pendingEditorSwitch := false;
    //Show a busy cursor
    Screen.Cursor := crHourglass;

    Application.ProcessMessages;

    if not ELDesigner1.Active or cleanUpJvInspEvents then
      EnableDesignerControls;
    ActivateDesigner(FileName);
    Screen.Cursor := crDefault;
    Result := true;
    if(ELDesigner1.Floating) then
        (editors[FileName] AS TWxEditor).GetDesigner.Show;  // EAB proper focus when designer floating

    if (Trim(ComponentPalette.SelectedComponent) <> '') and (TControlClass(GetClass(ComponentPalette.SelectedComponent)) <> nil) then
      Screen.Cursor := crDrag;

  end
  else
  begin
    if ELDesigner1.Active then
      DisableDesignerControls;
  end;
end;

procedure TWXDsgn.OnToolbarEvent(WM_COMMAND: Word);
begin

end;

function TWXDsgn.Retrieve_LeftDock_Panels: TList;
var
  items: TList;
begin
  items := TList.Create;
  items.Add(frmInspectorDock);
  items.Add(frmPaletteDock);
  Result := items;
end;

function TWXDsgn.Retrieve_RightDock_Panels: TList;
begin
  Result := nil;
end;

function TWXDsgn.Retrieve_BottomDock_Panels: TList;
begin
  Result := nil;
end;

function TWXDsgn.Retrieve_File_New_Menus: TList;
var
  items: TList;
begin
  items := TList.Create;
  items.Add(NewWxDialogItem);
  items.Add(NewWxFrameItem);
  Result := items;
end;

function TWXDsgn.Retrieve_File_Import_Menus: TList;
begin
  Result := nil;
end;

function TWXDsgn.Retrieve_File_Export_Menus: TList;
begin
  Result := nil;
end;

function TWXDsgn.Retrieve_Edit_Menus: TList;
begin
  Result := nil;
end;

function TWXDsgn.Retrieve_Search_Menus: TList;
begin
  Result := nil;
end;

function TWXDsgn.Retrieve_View_Menus: TList;
var
  items: TList;
begin
  items := TList.Create;
  items.Add(ShowPropertyInspItem);
  items.Add(ShowComponentPaletteItem);
  Result := items;
end;

function TWXDsgn.Retrieve_View_Toolbars_Menus: TList;
begin
  Result := nil;
end;

function TWXDsgn.Retrieve_Project_Menus: TList;
begin
  Result := nil;
end;

function TWXDsgn.Retrieve_Execute_Menus: TList;
begin
  Result := nil;
end;

function TWXDsgn.Retrieve_Debug_Menus: TList;
begin
  Result := nil;
end;

function TWXDsgn.Retrieve_Tools_Menus: TList;
var
  items: TList;
begin
  items := TList.Create;
  items.Add(ToolsMenuDesignerOptions);
  Result := items;
end;

function TWXDsgn.Retrieve_Help_Menus: TList;
begin
  Result := nil;
end;

function TWXDsgn.Retrieve_Toolbars: TToolBar;
begin
  Result := nil;
end;

function TWXDsgn.Retrieve_Message_Tabs: TList;
begin
  Result := nil;
end;

procedure TWXDsgn.SetEditorName(currentName:String; newName: string);
var
  tempEditor: TWXEditor;
begin
  if editors.Exists(currentName) then
  begin
    tempEditor := editors[currentName] as TWXEditor;
    editorNames[tempEditor.editorNumber] := newName;
    tempEditor.FileName := newName;
    editors.Rename(currentName, newName);
  end;
end;

function TWXDsgn.GetPluginName: string;
begin
  Result := plugin_name;
end;

function TWXDsgn.GetChild: HWND;
begin
  Result := 0;
end;

function TWXDsgn.ShouldNotCloseEditor(FileName: string; curFilename: string): Boolean;
begin
  Result := false;
  if (AnsiLowerCase(ChangeFileExt(FileName, WXFORM_EXT)) = curFilename) or
    (AnsiLowerCase(ChangeFileExt(FileName, H_EXT)) = curFilename) or
    (AnsiLowerCase(ChangeFileExt(FileName, CPP_EXT)) = curFilename) or
    (AnsiLowerCase(ChangeFileExt(FileName, XRC_EXT)) = curFilename) then
    Result := true;
end;

procedure TWXDsgn.actShowPropertyInspItemExecute(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  main.ToggleDockForm(frmInspectorDock, TMenuItem(Sender).Checked)
end;

procedure TWXDsgn.actShowComponentPaletteItemExecute(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  main.ToggleDockForm(frmPaletteDock, TMenuItem(Sender).Checked)
end;


function TWXDsgn.GetXMLExtension: string;
begin
  Result := XRC_EXT;
end;

function TWXDsgn.ConvertLibsToCurrentVersion(strValue: string): string;
begin
  Result := LocalConvertLibsToCurrentVersion(strValue);
end;

procedure TWXDsgn.CreateNewXPMs(strFileName: string);
begin
  (editors[strFileName] as TWXEditor).GetDesigner.CreateNewXPMs(strFileName);
end;

function TWXDsgn.HasDesigner(editorName: string): Boolean;
begin
  Result := not (editors[editorName] as TWXEditor).IsDesignerNil;
end;

function TWXDsgn.ManagesUnit: Boolean;
begin
  Result := true;
end;

function TWXDsgn.EditorDisplaysText(FileName: string): Boolean;
begin
  Result := false;
end;

function TWXDsgn.GetTextHighlighterType(FileName: string): string;
begin
  Result := 'RES';
end;

function TWXDsgn.GET_COMMON_CPP_INCLUDE_DIR: string;
begin
  Result := COMMON_CPP_INCLUDE_DIR;
end;

function TWXDsgn.GetCompilerMacros: string;
var
  WxLibName: string;
begin
  WxLibName := Format('wxmsw%d%d', [WxOptions.majorVersion, WxOptions.minorVersion]);

  //And then do the library features
  if WxOptions.unicodeSupport then
    WxLibName := WxLibName + 'u';
  if WxOptions.debugLibrary then
    WxLibName := WxLibName + 'd';

  Result := 'WXLIBNAME = ' + WxLibName;
end;

function TWXDsgn.GetCompilerPreprocDefines: string;
begin
  //Add the WXUSINGDLL if we are using a DLL build

  if not WxOptions.staticLibrary then
    Result := 'WXUSINGDLL'

  else

    Result := ''

end;

function TWXDsgn.Retrieve_CompilerOptionsPane: TTabSheet;
begin
  Result := tabwxWidgets;
end;

procedure TWXDsgn.LoadCompilerSettings(name: string; value: string);
begin
  // Loading Compiler settings:
  if name = 'wxOpts.Major' then
  begin
    fwxOptions.majorVersion := StrToInt(value);
  end
  else if name = 'wxOpts.Minor' then
  begin
    fwxOptions.minorVersion := StrToInt(value);
  end
  else if name = 'wxOpts.Release' then
  begin
    fwxOptions.releaseVersion := StrToInt(value);
  end
  else if name = 'wxOpts.Unicode' then
  begin
    fwxOptions.unicodeSupport := StrToBool(value);
  end
  else if name = 'wxOpts.Monolithic' then
  begin
    fwxOptions.monolithicLibrary := StrToBool(value);
  end
  else if name = 'wxOpts.Debug' then
  begin
    fwxOptions.debugLibrary := StrToBool(value);
  end
  else if name = 'wxOpts.Static' then
  begin
    fwxOptions.staticLibrary := StrToBool(value);
  end;
end;

procedure TWXDsgn.LoadCompilerOptions;
begin
  with wxOptions do
  begin
    spwxMajor.Value := majorVersion;
    spwxMinor.Value := minorVersion;
    spwxRelease.Value := releaseVersion;

    chkwxUnicode.Checked := unicodeSupport;
    chkwxMonolithic.Checked := monolithicLibrary;
    chkwxDebug.Checked := debugLibrary;
    if staticLibrary then
      staticLib.Checked := true
    else
      dynamicLib.Checked := true
  end;
end;

procedure TWXDsgn.SaveCompilerOptions;
begin
  with wxOptions do
  begin
    majorVersion := spwxMajor.Value;
    minorVersion := spwxMinor.Value;
    releaseVersion := spwxRelease.Value;

    unicodeSupport := chkwxUnicode.Checked;
    monolithicLibrary := chkwxMonolithic.Checked;
    debugLibrary := chkwxDebug.Checked;
    staticLibrary := staticLib.Checked;
  end
end;

function TWXDsgn.GetCompilerOptions: TSettings;
var
  settings: TSettings;
  setting: TSetting;
begin
  SetLength(settings, 7);

  setting.name := 'wxOpts.Major';
  setting.value := IntToStr(wxOptions.majorVersion);
  settings[0] := setting;

  setting.name := 'wxOpts.Minor';
  setting.value := IntToStr(wxOptions.minorVersion);
  settings[1] := setting;

  setting.name := 'wxOpts.Release';
  setting.value := IntToStr(wxOptions.ReleaseVersion);
  settings[2] := setting;

  setting.name := 'wxOpts.Unicode';
  setting.value := BoolToStr(wxOptions.unicodeSupport);
  settings[3] := setting;

  setting.name := 'wxOpts.Monolithic';
  setting.value := BoolToStr(wxOptions.monolithicLibrary);
  settings[4] := setting;

  setting.name := 'wxOpts.Debug';
  setting.value := BoolToStr(wxOptions.debugLibrary);
  settings[5] := setting;

  setting.name := 'wxOpts.Static';
  setting.value := BoolToStr(wxOptions.staticLibrary);
  settings[6] := setting;

  Result := settings;
end;

procedure TWXDsgn.SetCompilerOptionstoDefaults;
begin
  // wxWidgets options
  with wxOptions do
  begin
    majorVersion := 2;
    minorVersion := 9;
    releaseVersion := 3;

    unicodeSupport := True;
    monolithicLibrary := True;
    debugLibrary := False;
    staticLibrary := True;
  end;
end;

procedure TWXDsgn.TestReport;
begin
  ShowMessage('wxdsgn plugin has been loaded.');
end;

procedure TWXDsgn.AfterStartupCheck;
begin
    ShowPropertyInspItem.Checked := frmInspectorDock.Visible;
    ShowComponentPaletteItem.Checked := frmPaletteDock.Visible;
end;

procedure TWXDsgn.FullScreenSwitch;
var
    i: Integer;
begin
    for i := 0 to editors.ItemCount - 1 do
        (editors[editorNames[i]] as TWXEditor).RestorePosition;
end;

function TWXDsgn.GetContextForHelp: String;
begin
    Result := '';
end;

initialization
  TWxJvInspectorTStringsItem.RegisterAsDefaultItem;
  TJvInspectorMyFontItem.RegisterAsDefaultItem;
  TJvInspectorMenuItem.RegisterAsDefaultItem;
  TJvInspectorBitmapItem.RegisterAsDefaultItem;
  TJvInspectorListColumnsItem.RegisterAsDefaultItem;
  TJvInspectorColorEditItem.RegisterAsDefaultItem;
  TJvInspectorFileNameEditItem.RegisterAsDefaultItem;
  TJvInspectorAnimationFileNameEditItem.RegisterAsDefaultItem;
  TJvInspectorStatusBarItem.RegisterAsDefaultItem;
  TJvInspectorValidatorItem.RegisterAsDefaultItem;
  TJvInspectorTreeNodesItem.RegisterAsDefaultItem;
  TJvInspectorListItemsItem.RegisterAsDefaultItem;
  Classes.RegisterClass(TWXDsgn);
finalization
  Classes.UnRegisterClass(TWXDsgn);

end.

