Unit wxdesigner;

Interface

Uses
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

Type
    TdevWxOptions = Record
        majorVersion: Shortint;
        minorVersion: Shortint;
        releaseVersion: Shortint;

        unicodeSupport: Boolean;
        monolithicLibrary: Boolean;
        debugLibrary: Boolean;
        staticLibrary: Boolean;
    End;

Type
    TWXDsgn = Class(TComponent, IPlug_In_BPL)
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

        Procedure actDesignerCopyExecute(Sender: TObject);
        Procedure actDesignerCutExecute(Sender: TObject);
        Procedure actWxPropertyInspectorCutExecute(Sender: TObject);
        Procedure actWxPropertyInspectorCopyExecute(Sender: TObject);
        Procedure actWxPropertyInspectorPasteExecute(Sender: TObject);
        Procedure actWxPropertyInspectorDeleteExecute(Sender: TObject);
        Procedure actDesignerPasteExecute(Sender: TObject);
        Procedure actDesignerDeleteExecute(Sender: TObject);
        Procedure WxPropertyInspectorContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure ELDesigner1ContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure ELDesigner1ChangeSelection(Sender: TObject);
        Procedure ELDesigner1ControlDeleted(Sender: TObject; AControl: TControl);
        Procedure ELDesigner1ControlHint(Sender: TObject; AControl: TControl; Var AHint: String);
        Procedure ELDesigner1ControlInserted(Sender: TObject; AControl: TControl);
        Procedure ELDesigner1ControlInserting(Sender: TObject; Var AParent: TWinControl; Var AControlClass: TControlClass);
        Procedure ELDesigner1ControlDoubleClick(Sender: TObject);
        Procedure ELDesigner1KeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure ELDesigner1Modified(Sender: TObject);
        Procedure JvInspPropertiesAfterItemCreate(Sender: TObject; Item: TJvCustomInspectorItem);
        Procedure JvInspPropertiesDataValueChanged(Sender: TObject; Data: TJvCustomInspectorData);
        Procedure JvInspEventsAfterItemCreate(Sender: TObject; Item: TJvCustomInspectorItem);
        Procedure JvInspEventsDataValueChanged(Sender: TObject; Data: TJvCustomInspectorData);
        Procedure JvInspEventsMouseMove(Sender: TObject; Shift: TShiftState; X: Integer; Y: Integer);
        Procedure JvInspEventsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
        Procedure JvInspEventsKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure JvInspEventsItemValueChanged(Sender: TObject; Item: TJvCustomInspectorItem);
        Procedure cbxControlsxChange(Sender: TObject);
        Procedure JvInspPropertiesBeforeSelection(Sender: TObject; NewItem: TJvCustomInspectorItem; Var Allow: Boolean);
        Procedure JvInspPropertiesItemValueChanged(Sender: TObject; Item: TJvCustomInspectorItem);
        Procedure ViewControlIDsClick(Sender: TObject);
        Procedure AlignToGridClick(Sender: TObject);
        Procedure AlignToLeftClick(Sender: TObject);
        Procedure AlignToRightClick(Sender: TObject);
        Procedure AlignToMiddleVerticalClick(Sender: TObject);
        Procedure AlignToMiddleHorizontalClick(Sender: TObject);
        Procedure AlignToTopClick(Sender: TObject);
        Procedure AlignToBottomClick(Sender: TObject);
        Procedure DesignerOptionsClick(Sender: TObject);
        Procedure ChangeCreationOrder1Click(Sender: TObject);
        Procedure SelectParentClick(Sender: TObject);
        Procedure LockControlClick(Sender: TObject);
        Procedure OnPropertyItemSelected(Sender: TObject);
        Function IsFromScrollBarShowing: Boolean;
        Procedure actNewWxFrameExecute(Sender: TObject);
        Procedure actNewwxDialogExecute(Sender: TObject);
        Procedure UpdateXRC(editorName: String);
        Procedure actShowPropertyInspItemExecute(Sender: TObject);
        Procedure actShowComponentPaletteItemExecute(Sender: TObject);

    Private
        plugin_name: String;
        palettePanel: TPanel;
        cleanUpJvInspEvents: Boolean;
    Public
        ownerForm: TForm;
        editorNames: Array Of String;
        Function GetCurrentFileName: String;
        Function GetCurrentClassName: String;
    Public
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

        XPTheme: Boolean; // Use XP theme
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


    Private
        fwxOptions: TdevWxOptions;
        pendingEditorSwitch: Boolean; // EAB: Let's see if we can make JvInspector to behave when switching to editor from Events field
        Property wxOptions: TdevWxOptions Read fwxOptions Write fwxOptions;
        Procedure CreateNewDialogOrFrameCode(dsgnType: TWxDesignerType; frm: TfrmCreateFormProp; insertProj: Integer);
        Procedure NewWxProjectCode(dsgnType: TWxDesignerType);
        Procedure ParseAndSaveTemplate(template, destination: String; frm: TfrmCreateFormProp);
        Function CreateCreateFormDlg(dsgnType: TWxDesignerType; insertProj: Integer; projShow: Boolean; filenamebase: String = ''): TfrmCreateFormProp;

        Function CreateFormFile(strFName, strCName, strFTitle: String; dlgSStyle: TWxDlgStyleSet; dsgnType: TWxDesignerType): Boolean;
        Procedure GetIntialFormData(frm: TfrmCreateFormProp; Var strFName, strCName, strFTitle: String; Var dlgStyle: TWxDlgStyleSet; dsgnType: TWxDesignerType);
        Function CreateSourceCodes(strCppFile, strHppFile: String; FCreateFormProp: TfrmCreateFormProp; Var cppCode, hppCode: String; dsgnType: TWxDesignerType): Boolean;
        Function CreateAppSourceCodes(strCppFile, strHppFile, strAppCppFile, strAppHppFile: String; FCreateFormProp: TfrmCreateFormProp; Var cppCode, hppCode, appcppCode, apphppCode: String; dsgnType: TWxDesignerType): Boolean;
        Procedure LoadText(force: Boolean);

    Public
        CacheCreated: Boolean;
        main: IPlug;
        parentHande: HWND;
    {Guru's Code}

        ComputerInfo1: TJvComputerInfoEx;

        strGlobalCurrentFunction: String;
        DisablePropertyBuilding: Boolean;
        boolInspectorDataClear: Boolean;
        intControlCount: Integer;
        SelectedComponent: TComponent;
        PreviousComponent: TComponent;
        PreviousStringValue: String;
        PreviousComponentName: String;
        FirstComponentBeingDeleted: String;
        Procedure GenerateSource(sourceFileName: String; text: TSynEdit);
        Procedure BuildProperties(Comp: TControl; boolForce: Boolean = False);
        Procedure BuildComponentList(Designer: TfrmNewForm);
        Function isCurrentFormFilesNeedToBeSaved: Boolean;
        Function saveCurrentFormFiles: Boolean;
        Function CreateFunctionInEditor(Var strFunctionName: String; strReturnType, strParameter: String; Var ErrorString: String; strClassName: String = ''): Boolean; Overload;
        Function CreateFunctionInEditor(strClassName: String; SelComponent: TComponent; Var strFunctionName: String; strEventFullName: String; Var ErrorString: String): Boolean; Overload;
        Function LocateFunctionInEditor(eventProperty: TJvCustomInspectorData; strClassName: String; SelComponent: TComponent; Var strFunctionName: String; strEventFullName: String): Boolean;
        Procedure OnEventPopup(Item: TJvCustomInspectorItem; Value: TStrings);
        Procedure OnStdWxIDListPopup(Item: TJvCustomInspectorItem; Value: TStrings);
        Procedure UpdateDefaultFormContent;
        Function GetCurrentDesignerForm: TfrmNewForm;
        Function IsCurrentPageDesigner: Boolean;
        Function IsDelphiPlugin: Boolean;
        Function ReplaceClassNameInEditor(strLst: TStringList; text: TSynEdit; FromClassName, ToClassName: String): Boolean;

        Function LocateFunction(strFunctionName: String): Boolean;

    // iplugin methods
        Function SaveFileAndCloseEditor(EditorFilename: String): Boolean;
        Procedure CutExecute;
        Procedure CopyExecute;
        Procedure PasteExecute;
        Procedure InitEditor(strFileName: String);
        Procedure Initialize(name: String; module: HModule; _parent: HWND; _controlBar: TControlBar; _owner: TForm; Config: String; toolbar_x: Integer; toolbar_y: Integer);
        Procedure AssignPlugger(plug: IPlug);
        Procedure DisableDesignerControls;
        Procedure OpenFile(s: String);
        Procedure OpenUnit(EditorFilename: String);
        Function IsForm(s: String): Boolean;
        Function GetFilters: TStringList;
        Function GetSrcFilters: TStringList;
        Function GetFilter(editorName: String): String;
        Function Get_EXT(editorName: String): String;
        Function Get_EXT_Index(editorName: String): Integer;
        Procedure NewProject(s: String);
        Procedure GenerateXPM(s: String; b: Boolean);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
        Procedure SetDesignerActiveState(state: Boolean);
        Procedure EnableDesignerControls;
        Procedure SetBoolInspectorDataClear(b: Boolean);
        Procedure SetDisablePropertyBuilding(b: Boolean);
        Procedure AssignDesignerControl(editorName: String);
        Function SaveFile(EditorFilename: String): Boolean;
        Procedure ActivateDesigner(s: String);
        Function GetLoginName: String;
        Function GetLangString(LangID: Integer): String;

        Procedure UpdateDesignerData(FileName: String);
        Procedure Reload(FileName: String);
        Function ReloadForm(FileName: String): Boolean;
        Procedure ReloadFromFile(FileName: String; fileToReloadFrom: String);
        Procedure TerminateEditor(FileName: String);
        Procedure DestroyDLL;
        Procedure OnDockableFormClosed(Sender: TObject; Var Action: TCloseAction);
        Function IsSource(FileName: String): Boolean;
        Function GetDefaultText(FileName: String): String;
        Function MainPageChanged(FileName: String): Boolean;
        Function ShouldNotCloseEditor(FileName: String; curFilename: String): Boolean;
        Function HasDesigner(editorName: String): Boolean;
        Function ManagesUnit: Boolean;

        Procedure OnToolbarEvent(WM_COMMAND: Word);
        Function Retrieve_File_New_Menus: TList;
        Function Retrieve_File_Import_Menus: TList;
        Function Retrieve_File_Export_Menus: TList;
        Function Retrieve_Edit_Menus: TList;
        Function Retrieve_Search_Menus: TList;
        Function Retrieve_View_Menus: TList;
        Function Retrieve_View_Toolbars_Menus: TList;
        Function Retrieve_Project_Menus: TList;
        Function Retrieve_Execute_Menus: TList;
        Function Retrieve_Debug_Menus: TList;
        Function Retrieve_Tools_Menus: TList;
        Function Retrieve_Help_Menus: TList;
        Function Retrieve_Toolbars: TToolBar;
        Function Retrieve_Message_Tabs: TList;
        Procedure SetEditorName(currentName: String; newName: String);
        Function GetPluginName: String;
        Function GetChild: HWND;
        Function GetXMLExtension: String;
        Function Retrieve_LeftDock_Panels: TList;
        Function Retrieve_RightDock_Panels: TList;
        Function Retrieve_BottomDock_Panels: TList;
        Function ConvertLibsToCurrentVersion(strValue: String): String;
        Procedure CreateNewXPMs(strFileName: String);
        Function EditorDisplaysText(FileName: String): Boolean;
        Function GetTextHighlighterType(FileName: String): String;
        Function GET_COMMON_CPP_INCLUDE_DIR: String;
        Function GetCompilerMacros: String;
        Function GetCompilerPreprocDefines: String;
        Function Retrieve_CompilerOptionsPane: TTabSheet;
        Procedure LoadCompilerSettings(name: String; value: String);
        Procedure LoadCompilerOptions;
        Procedure SaveCompilerOptions;
        Function GetCompilerOptions: TSettings;
        Procedure SetCompilerOptionstoDefaults;
        Procedure TestReport;
        Procedure AfterStartupCheck;
        Procedure FullScreenSwitch;
        Function GetContextForHelp: String;

    End;

Var
    wx_designer: TWXDsgn;

Implementation

Uses

 //Components
    CreateOrderFm, ViewIDForm,
    WxSplitterWindow, wxchoicebook, wxlistbook, WxNotebook, wxtoolbook, wxtreebook,
    WxNoteBookPage, WxToolbar, WxToolButton, WxChoice, WxCustomButton,
    WxSeparator, WxStatusBar, WxNonVisibleBaseComponent, WxMenuBar, WxPopupMenu, WxPanel,
    WxStaticBitmap, WxBitmapButton, WxStdDialogButtonSizer, wxversion, wxeditor,
    wxAuiToolBar, wxAuiNotebook, wxAuiBar, WxAuiNoteBookPage
    ;

Const

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

Procedure TWXDsgn.Initialize(name: String; module: HModule; _parent: HWND; _controlBar: TControlBar; _owner: TForm; Config: String; toolbar_x: Integer; toolbar_y: Integer);
Var
    I: Integer;
    ini: TiniFile;
Begin
    plugin_name := name;
    XPTheme := False;
    ownerForm := _owner;
    wx_designer := Self;
    editors := TObjectHash.Create;
    configFolder := Config;
    parentHande := _parent;
    pendingEditorSwitch := False;

    cleanUpJvInspEvents := False;

    ComputerInfo1 := TJvComputerInfoEx.Create(ownerForm);

  //Property Inspector
    frmInspectorDock := TForm.Create(ownerForm);
    frmInspectorDock.ParentFont := True;
    frmInspectorDock.Font.Assign(ownerForm.Font);
    With frmInspectorDock Do
    Begin
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
    End;

    frmPaletteDock := TForm.Create(ownerForm);
    frmPaletteDock.ParentFont := True;
    frmPaletteDock.Font.Assign(ownerForm.Font);
    palettePanel := TPanel.Create(frmPaletteDock);
    palettePanel.Parent := frmPaletteDock;
    palettePanel.BevelInner := bvLowered;
    palettePanel.BorderWidth := 1;
    palettePanel.BevelWidth := 1;
    palettePanel.Align := alClient;
    palettePanel.Anchors := [akLeft, akTop, akRight, akBottom];

    ComponentPalette := TComponentPalette.Create(palettePanel);
    ComponentPalette.Visible := False;
    With frmPaletteDock Do
    Begin
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
    End;

  //Add the property inspector view menu item
    ShowPropertyInspItem := TMenuItem.Create(Self);
    With ShowPropertyInspItem Do
    Begin
        Caption := GetLangString(ID_WX_SHOWPROPINSPECTOR); //'Show Property Inspector';
        Action := actShowPropertyInspItem;
        OnClick := actShowPropertyInspItemExecute;
        Checked := True;
    End;

    //Add the property inspector view menu item
    ShowComponentPaletteItem := TMenuItem.Create(Self);
    With ShowComponentPaletteItem Do
    Begin
        Caption := GetLangString(ID_WX_SHOWCOMPPALETTE); //'Show Component Palette';
        Action := actShowComponentPaletteItem;
        OnClick := actShowComponentPaletteItemExecute;
        Checked := True;
    End;

    boolInspectorDataClear := True;
    DisablePropertyBuilding := False;

    NewWxDialogItem := TMenuItem.Create(Self);
    With NewWxDialogItem Do
    Begin
        Caption := GetLangString(ID_WX_NEWDIALOG); //'New wxDialog';
        ImageIndex := 1;
        Action := actNewwxDialog;
        OnClick := actNewWxDialogExecute;
    End;

    NewWxFrameItem := TMenuItem.Create(Self);
    With NewWxFrameItem Do
    Begin
        Caption := GetLangString(ID_WX_NEWFRAME); //'New wxFrame';
        ImageIndex := 1;
        Action := actNewWxFrame;
        OnClick := actNewWxFrameExecute;
    End;

    actDesignerCopy := TAction.Create(Self);
    With actDesignerCopy Do
    Begin
        Category := 'Designer';
        Caption := GetLangString(ID_ITEM_COPY); //'Copy';
        ShortCut := 49219;
        OnExecute := actDesignerCopyExecute;
    End;
    actDesignerCut := TAction.Create(Self);
    With actDesignerCut Do
    Begin
        Category := 'Designer';
        Caption := GetLangString(ID_ITEM_CUT); //'Cut';
        ShortCut := 49240;
        OnExecute := actDesignerCutExecute;
    End;
    actDesignerPaste := TAction.Create(Self);
    With actDesignerPaste Do
    Begin
        Category := 'Designer';
        Caption := GetLangString(ID_ITEM_PASTE); //'Paste';
        ShortCut := 49238;
        OnExecute := actDesignerPasteExecute;
    End;
    actDesignerDelete := TAction.Create(Self);
    With actDesignerDelete Do
    Begin
        Category := 'Designer';
        Caption := GetLangString(ID_ITEM_DELETE); //'Delete';
        ShortCut := 16430;
        OnExecute := actDesignerDeleteExecute;
    End;
    actNewWxFrame := TAction.Create(Self);
    With actNewWxFrame Do
    Begin
        Category := 'File';
        Caption := GetLangString(ID_WX_NEWFRAME); //'New wxFrame';
        ImageIndex := 1;
        OnExecute := actNewWxFrameExecute;
    End;
    actWxPropertyInspectorCut := TAction.Create(Self);
    With actWxPropertyInspectorCut Do
    Begin
        Category := 'Designer';
        Caption := GetLangString(ID_ITEM_CUT); //'Cut';
        ShortCut := 16472;
        OnExecute := actWxPropertyInspectorCutExecute;
    End;
    actWxPropertyInspectorCopy := TAction.Create(Self);
    With actWxPropertyInspectorCopy Do
    Begin
        Category := 'Designer';
        Caption := GetLangString(ID_ITEM_COPY); //'Copy';
        ShortCut := 16451;
        OnExecute := actWxPropertyInspectorCopyExecute;
    End;
    actWxPropertyInspectorPaste := TAction.Create(Self);
    With actWxPropertyInspectorPaste Do
    Begin
        Category := 'Designer';
        Caption := GetLangString(ID_ITEM_PASTE); //'Paste';
        ShortCut := 16470;
        OnExecute := actWxPropertyInspectorPasteExecute;
    End;

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

    With WxPropertyInspectorPopup Do
    Begin
        Name := 'WxPropertyInspectorPopup';
    End;
    With WxPropertyInspectorMenuEdit Do
    Begin
        Name := 'WxPropertyInspectorMenuEdit';
        Caption := GetLangString(ID_WX_PROPERTYEDIT); //'Wx Property Edit';
    End;
    With WxPropertyInspectorMenuCopy Do
    Begin
        Name := 'WxPropertyInspectorMenuCopy';
        Action := actWxPropertyInspectorCopy;
    End;
    With WxPropertyInspectorMenuCut Do
    Begin
        Name := 'WxPropertyInspectorMenuCut';
        Action := actWxPropertyInspectorCut;
    End;
    With WxPropertyInspectorMenuPaste Do
    Begin
        Name := 'WxPropertyInspectorMenuPaste';
        Action := actWxPropertyInspectorPaste;
    End;
    With WxPropertyInspectorMenuDelete Do
    Begin
        Name := 'WxPropertyInspectorMenuDelete';
        Action := actDelete;
    End;

    With DesignerPopup Do
    Begin
        Name := 'DesignerPopup';
    End;
    With DesignerMenuEdit Do
    Begin
        Name := 'DesignerMenuEdit';
        Caption := GetLangString(ID_MNU_EDIT); //'Edit';
    End;
    With DesignerMenuCopy Do
    Begin
        Name := 'DesignerMenuCopy';
        Action := actDesignerCopy;
    End;
    With DesignerMenuCut Do
    Begin
        Name := 'DesignerMenuCut';
        Action := actDesignerCut;
    End;
    With DesignerMenuPaste Do
    Begin
        Name := 'DesignerMenuPaste';
        Action := actDesignerPaste;
    End;
    With DesignerMenuDelete Do
    Begin
        Name := 'DesignerMenuDelete';
        Action := actDesignerDelete;
    End;
    With DesignerMenuSep1 Do
    Begin
        Name := 'DesignerMenuSep1';
        Caption := '-';
    End;
    With DesignerMenuCopyWidgetName Do
    Begin
        Name := 'DesignerMenuCopyWidgetName';
        Caption := GetLangString(ID_WX_COPYNAME); //'Copy Widget Name';
        Visible := False;
    End;
    With DesignerMenuChangeCreationOrder Do
    Begin
        Name := 'DesignerMenuChangeCreationOrder';
        Caption := GetLangString(ID_WX_CHANGEORDER); //'Change Creation Order';
        OnClick := ChangeCreationOrder1Click;
    End;
    With DesignerMenuSelectParent Do
    Begin
        Name := 'DesignerMenuSelectParent';
        Caption := GetLangString(ID_WX_SELECTPARENT); //'Select Parent';
    End;
    With DesignerMenuLocked Do
    Begin
        Name := 'DesignerMenuLocked';
        Caption := GetLangString(ID_WX_LOCKCONTROL); //'Lock Control';
        OnClick := LockControlClick;
    End;
    With DesignerMenuSep2 Do
    Begin
        Name := 'DesignerMenuSep2';
        Caption := '-';
    End;
    With DesignerMenuViewIDs Do
    Begin
        Name := 'DesignerMenuViewIDs';
        Caption := GetLangString(ID_WX_VIEWCONTROLID); //'View Control IDs';
        OnClick := ViewControlIDsClick;
    End;
    With DesignerMenuAlign Do
    Begin
        Name := 'DesignerMenuAlign';
        Caption := GetLangString(ID_WX_ALIGN); //'Align';
    End;

    With DesignerMenuAlignToGrid Do
    Begin
        Name := 'DesignerMenuAlignToGrid';
        Caption := GetLangString(ID_WX_TOGRID); //'To Grid';
        OnClick := AlignToGridClick;
    End;

    With DesignerMenuAlignVertical Do
    Begin
        Name := 'DesignerMenuAlignVertical';
        Caption := GetLangString(ID_WX_VERTICAL); //'Vertical';
    End;

    With DesignerMenuAlignHorizontal Do
    Begin
        Name := 'DesignerMenuAlignHorizontal';
        Caption := GetLangString(ID_WX_HORIZONTAL); //'Horizontal';
    End;

    With DesignerMenuAlignToLeft Do
    Begin
        Name := 'DesignerMenuAlignToLeft';
        Caption := GetLangString(ID_WX_TOLEFT); //'To Left';
        OnClick := AlignToLeftClick;
    End;

    With DesignerMenuAlignToRight Do
    Begin
        Name := 'DesignerMenuAlignToRight';
        Caption := GetLangString(ID_WX_TORIGHT); //'To Right';
        OnClick := AlignToRightClick;
    End;

    With DesignerMenuAlignToMiddleVertical Do
    Begin
        Name := 'DesignerMenuAlignToMiddleVertical';
        Caption := GetLangString(ID_WX_TOCENTER); //'To Center';
        OnClick := AlignToMiddleVerticalClick;
    End;

    With DesignerMenuAlignToMiddleHorizontal Do
    Begin
        Name := 'DesignerMenuAlignToMiddleHorizontal';
        Caption := GetLangString(ID_WX_TOCENTER); //'To Center';
        OnClick := AlignToMiddleHorizontalClick;
    End;

    With DesignerMenuAlignToTop Do
    Begin
        Name := 'DesignerMenuAlignToTop';
        Caption := GetLangString(ID_WX_TOTOP); //'To Top';
        OnClick := AlignToTopClick;
    End;

    With DesignerMenuAlignToBottom Do
    Begin
        Name := 'DesignerMenuAlignToBottom';
        Caption := GetLangString(ID_WX_TOBOTTOM); //'To Bottom';
        OnClick := AlignToBottomClick;
    End;

    With DesignerMenuSep3 Do
    Begin
        Name := 'DesignerMenuSep3';
        Caption := '-';
    End;
    With DesignerMenuDesignerOptions Do
    Begin
        Name := 'DesignerMenuDesignerOptions';
        Caption := GetLangString(ID_WX_DESIGNEROPTS); //'Designer Options';
        OnClick := DesignerOptionsClick;
    End;
    With ToolsMenuDesignerOptions Do
    Begin
        Name := 'ToolsMenuDesignerOptions';
        Caption := GetLangString(ID_WX_DESIGNEROPTS); //'Designer Options';
        OnClick := DesignerOptionsClick;
    End;

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
    With JvInspectorDotNETPainter1 Do
    Begin
        Name := 'JvInspectorDotNETPainter1';
        DrawNameEndEllipsis := False;
    End;
    With JvInspectorDotNETPainter2 Do
    Begin
        Name := 'JvInspectorDotNETPainter2';
        DrawNameEndEllipsis := False;
    End;

    ELDesigner1 := TELDesigner.Create(Self);
    With ELDesigner1 Do
    Begin
        Name := 'ELDesigner1';
        ClipboardFormat := 'Extension Library designer components';
        PopupMenu := DesignerPopup;
        SnapToGrid := False;
        GenerateXRC := False;
        Floating := False;
        OnContextPopup := ELDesigner1ContextPopup;
        OnChangeSelection := ELDesigner1ChangeSelection;
        OnControlDeleted := ELDesigner1ControlDeleted;
        OnControlHint := ELDesigner1ControlHint;
        OnControlInserted := ELDesigner1ControlInserted;
        OnControlInserting := ELDesigner1ControlInserting;
        OnModified := ELDesigner1Modified;
        OnDblClick := ELDesigner1ControlDoubleClick;
        OnKeyDown := ELDesigner1KeyDown;
    End;

    ini := TiniFile.Create(Config + ChangeFileExt(ExtractFileName(Application.ExeName), '') + '.ini');
    Try
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
        If trim(StringFormat) = '' Then
            StringFormat := 'wxT';
        UseDefaultPos := ini.ReadBool('wxWidgets', 'cbUseDefaultPos', False); // ?? UseDefaultPos);
        UseDefaultSize := ini.ReadBool('wxWidgets', 'cbUseDefaultSize', False); //?? UseDefaultSize);
        UseIndividEnums := ini.ReadBool('wxWidgets', 'cbIndividualEnums', True); //?? UseIndividEnums);

        If ini.ReadBool('wxWidgets', 'cbControlHints', True) Then
            ELDesigner1.ShowingHints := ELDesigner1.ShowingHints + [htControl]
        Else
            ELDesigner1.ShowingHints := ELDesigner1.ShowingHints - [htControl];

        If ini.ReadBool('wxWidgets', 'cbSizeHints', True) Then
            ELDesigner1.ShowingHints := ELDesigner1.ShowingHints + [htSize]
        Else
            ELDesigner1.ShowingHints := ELDesigner1.ShowingHints - [htSize];

        If ini.ReadBool('wxWidgets', 'cbMoveHints', True) Then
            ELDesigner1.ShowingHints := ELDesigner1.ShowingHints + [htMove]
        Else
            ELDesigner1.ShowingHints := ELDesigner1.ShowingHints - [htMove];

        If ini.ReadBool('wxWidgets', 'cbInsertHints', True) Then
            ELDesigner1.ShowingHints := ELDesigner1.ShowingHints + [htInsert]
        Else
            ELDesigner1.ShowingHints := ELDesigner1.ShowingHints - [htInsert];
    Finally
        ini.destroy;
    End;

    pnlMainInsp := TPanel.Create(frmInspectorDock);
    cbxControlsx := TComboBox.Create(frmInspectorDock);
    pgCtrlObjectInspector := TPageControl.Create(frmInspectorDock);
    TabProperty := TTabSheet.Create(frmInspectorDock);
    JvInspProperties := TJvInspector.Create(frmInspectorDock);
    TabEvent := TTabSheet.Create(frmInspectorDock);
    JvInspEvents := TJvInspector.Create(frmInspectorDock);

    With pnlMainInsp Do
    Begin
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
    End;
    With cbxControlsx Do
    Begin
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
    End;
    With pgCtrlObjectInspector Do
    Begin
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
    End;
    With TabProperty Do
    Begin
        Name := 'TabProperty';
        Parent := pgCtrlObjectInspector;
        PageControl := pgCtrlObjectInspector;
        Caption := GetLangString(ID_WX_PROPERTIES);
        ImageIndex := -1;
    End;
    With JvInspProperties Do
    Begin
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
    End;
    With TabEvent Do
    Begin
        Name := 'TabEvent';
        Parent := pgCtrlObjectInspector;
        PageControl := pgCtrlObjectInspector;
        Caption := GetLangString(ID_WX_EVENTS);
        ImageIndex := -1;
    End;
    With JvInspEvents Do
    Begin
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
    End;

  //Setting data for the newly created GUI
    intControlCount := 1000;

    boolInspectorDataClear := True;
    DisablePropertyBuilding := False;

  // Initializing compiler options pane
    lblwxMinor := TLabel.Create(ownerForm);
    With lblwxMinor Do
    Begin
        Left := 8;
        Top := 46;
        Width := 29;
        Height := 13;
        ParentFont := False;
        Caption := GetLangString(ID_POPT_VMINOR); //'Minor:';
    End;

    lblwxMajor := TLabel.Create(ownerForm);
    With lblwxMajor Do
    Begin
        Left := 8;
        Top := 19;
        Width := 29;
        Height := 13;
        ParentFont := False;
        Caption := GetLangString(ID_POPT_VMAJOR); //'Major:';
    End;

    lblwxRelease := TLabel.Create(ownerForm);
    With lblwxRelease Do
    Begin
        Left := 8;
        Top := 73;
        Width := 42;
        Height := 13;
        ParentFont := False;
        Caption := GetLangString(ID_POPT_VRELEASE); //'Release:';
    End;

    spwxMajor := TSpinEdit.Create(ownerForm);
    With spwxMajor Do
    Begin
        Left := 60;
        Top := 16;
        Width := 45;
        Height := 22;
        MaxValue := 1000;
        MinValue := 0;
        TabOrder := 0;
        Value := 2;
        ParentFont := False;
    End;

    spwxMinor := TSpinEdit.Create(ownerForm);
    With spwxMinor Do
    Begin
        Left := 60;
        Top := 43;
        Width := 45;
        Height := 22;
        MaxValue := 1000;
        MinValue := 0;
        TabOrder := 1;
        Value := 9;
        ParentFont := False;
    End;

    spwxRelease := TSpinEdit.Create(ownerForm);
    With spwxRelease Do
    Begin
        Left := 60;
        Top := 70;
        Width := 45;
        Height := 22;
        MaxValue := 1000;
        MinValue := 0;
        TabOrder := 2;
        Value := 2;
        ParentFont := False;
    End;

    grpwxVersion := TGroupBox.Create(ownerForm);
    With grpwxVersion Do
    Begin
        Left := 8;
        Top := 5;
        Width := 403;
        Height := 100;
        Caption := GetLangString(ID_POPT_VERTAB); //'Version';
        TabOrder := 0;
        ParentFont := False;
    End;
    grpwxVersion.InsertControl(spwxRelease);
    grpwxVersion.InsertControl(spwxMinor);
    grpwxVersion.InsertControl(spwxMajor);
    grpwxVersion.InsertControl(lblwxRelease);
    grpwxVersion.InsertControl(lblwxMajor);
    grpwxVersion.InsertControl(lblwxMinor);

    chkwxUnicode := TCheckBox.Create(ownerForm);
    With chkwxUnicode Do
    Begin
        Left := 8;
        Top := 16;
        Width := 130;
        Height := 17;
        Caption := 'Unicode Support';
        ParentFont := False;
        TabOrder := 0;
    End;

    chkwxMonolithic := TCheckBox.Create(ownerForm);
    With chkwxMonolithic Do
    Begin
        Left := 8;
        Top := 36;
        Width := 130;
        Height := 17;
        Caption := 'Monolithic Library';
        ParentFont := False;
        TabOrder := 1;
    End;

    chkwxDebug := TCheckBox.Create(ownerForm);
    With chkwxDebug Do
    Begin
        Left := 8;
        Top := 56;
        Width := 97;
        Height := 17;
        Caption := 'Debug Build';
        ParentFont := False;
        TabOrder := 2;
    End;

    grpwxType := TGroupBox.Create(ownerForm);
    With grpwxType Do
    Begin
        Left := 8;
        Top := 112;
        Width := 403;
        Height := 80;
        Caption := 'Features';
        ParentFont := False;
        TabOrder := 1;
    End;
    grpwxType.InsertControl(chkwxDebug);
    grpwxType.InsertControl(chkwxMonolithic);
    grpwxType.InsertControl(chkwxUnicode);

    rdwxLibraryType := TRadioGroup.Create(self);
    With rdwxLibraryType Do
    Begin
        Left := 8;
        Top := 200;
        Width := 403;
        Height := 65;
        Caption := 'Library Type';
        ItemIndex := 0;
        TabOrder := 2;
        ParentFont := False;
    End;

    staticLib := TRadioButton.Create(self);
    With staticLib Do
    Begin
        Left := 10;
        Top := 15;
        Width := 150;
        Height := 20;
        Caption := 'Static Import Library';
        ParentFont := False;
    End;
    staticLib.Caption := 'Static Import Library';

    dynamicLib := TRadioButton.Create(self);
    With dynamicLib Do
    Begin
        Left := 10;
        Top := 35;
        Width := 150;
        Height := 20;
        Caption := 'Dynamic Library (DLL)';
        ParentFont := False;
    End;

    rdwxLibraryType.InsertControl(staticLib);
    rdwxLibraryType.InsertControl(dynamicLib);

    tabwxWidgets := TTabSheet.Create(self);
    With tabwxWidgets Do
    Begin
        Caption := 'wxWidgets';
        ImageIndex := 4;
        Visible := True;
        ParentFont := False;
    End;

    tabwxWidgets.InsertControl(grpwxVersion);
    tabwxWidgets.InsertControl(grpwxType);
    tabwxWidgets.InsertControl(rdwxLibraryType);



End; // end Initialize

Procedure TWXDsgn.AssignPlugger(plug: IPlug);
Begin
    main := plug As IPlug;
    XPTheme := main.IsUsingXPTheme;
End;

Procedure TWXDsgn.OpenFile(s: String);
Begin
    If IsForm(s) Then
    Begin
        main.OpenFile(GetLongName(ChangeFileExt(s, H_EXT)), True);
        main.OpenFile(GetLongName(ChangeFileExt(s, CPP_EXT)), True);
        If ELDesigner1.GenerateXRC Then
            main.OpenFile(ChangeFileExt(s, XRC_EXT), True);
    End;
End;

Procedure TWXDsgn.LoadText(force: Boolean);
Begin
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
End;

Function TWXDsgn.IsForm(s: String): Boolean;
Begin
    If (CompareStr(ExtractFileExt(s), WXFORM_EXT) = 0) Then
        Result := True
    Else
        Result := False;
End;

Function TWXDsgn.GetFilter(editorName: String): String;
Begin
    If isXRCExt(editorName) Then
        Result := FLT_XRC
    Else
        Result := FLT_WXFORMS;
End;

Function TWXDsgn.Get_EXT(editorName: String): String;
Begin
    If isXRCExt(editorName) Then
        Result := XRC_EXT
    Else
        Result := WXFORM_EXT;
End;

Function TWXDsgn.Get_EXT_Index(editorName: String): Integer;
Begin
    If isXRCExt(editorName) Then
        Result := 8     // EAB: this should be done dinamically; giving plugins the last current index at creation time.
    Else
        Result := 7;
End;

Function TWXDsgn.SaveFile(EditorFilename: String): Boolean;
Begin
    Result := False;
  //For a wxDev-C++ build, there are a few related editors that must be saved at
  //the same time.

  //See if the current file is a Form-related document
  //TODO: lowjoel: the following code assumes that the editor for the sibling file
  //               is open. Why do we need such a lousy restriction?
    If FileExists(ChangeFileExt(EditorFilename, WXFORM_EXT)) Then
    //The current file is a form and has related files. If we save the form, all
       //the related files needs to be saved at the same time.
    Begin
        If main.isFileOpenedinEditor(ChangeFileExt(EditorFilename, WXFORM_EXT)) Then
        Begin
            Result := main.SaveFileFromPlugin(ChangeFileExt(EditorFilename, WXFORM_EXT));

      //Just Generate XPM's while saving the file
            GenerateXPM(EditorFilename, False);
            If editors.Exists(EditorFilename) Then
                (editors[ChangeFileExt(EditorFilename, WXFORM_EXT)] As TWXEditor).GetDesigner.CreateNewXPMs(EditorFilename);
        End;

    //If the user wants XRC files to be generated, save the XRC file as well
    //BUT: if the user does NOT want XRC files, we should not confuse the user
    //     and delete the file
        If ELDesigner1.GenerateXRC Then
        Begin
            If main.isFileOpenedinEditor(ChangeFileExt(EditorFilename, XRC_EXT)) Then
            Begin
                Result := Result And main.SaveFileFromPlugin(ChangeFileExt(EditorFilename, XRC_EXT));
            End;
        End
        Else
        ;
    //Delete the now-outdated XRC file
    //TODO: lowjoel: safer way?

        If main.isFileOpenedinEditor(ChangeFileExt(EditorFilename, H_EXT)) Then
        Begin
            Result := Result And main.SaveFileFromPlugin(ChangeFileExt(EditorFilename, H_EXT));
        End;

        If main.isFileOpenedinEditor(ChangeFileExt(EditorFilename, CPP_EXT)) Then
        Begin
            Result := Result And main.SaveFileFromPlugin(ChangeFileExt(EditorFilename, CPP_EXT));
        End;

    End;
End;

Function TWXDsgn.SaveFileAndCloseEditor(EditorFilename: String): Boolean;
Var
    flag: Boolean;

Begin
    flag := False;
    If FileExists(ChangeFileExt(EditorFilename, WXFORM_EXT)) Then
    Begin
        flag := True;
        main.SaveFileFromPlugin(ChangeFileExt(EditorFilename, CPP_EXT));
        main.CloseEditorFromPlugin(ChangeFileExt(EditorFilename, CPP_EXT));

        main.SaveFileFromPlugin(ChangeFileExt(EditorFilename, H_EXT));
        main.CloseEditorFromPlugin(ChangeFileExt(EditorFilename, H_EXT));

        main.SaveFileFromPlugin(ChangeFileExt(EditorFilename, WXFORM_EXT));
        main.CloseEditorFromPlugin(ChangeFileExt(EditorFilename, WXFORM_EXT));

        main.SaveFileFromPlugin(ChangeFileExt(EditorFilename, XRC_EXT));
        main.CloseEditorFromPlugin(ChangeFileExt(EditorFilename, XRC_EXT));
    End;

    Result := flag;

End;

Procedure TWXDsgn.OpenUnit(EditorFilename: String);
Var
    AlreadyActivated: Boolean;
Begin
    AlreadyActivated := True;
    If FileExists(ChangeFileExt(EditorFilename, WXFORM_EXT)) Then
    Begin
        If Not main.isFileOpenedinEditor(ChangeFileExt(EditorFilename, WXFORM_EXT)) Then
            If Not main.OpenUnitInProject(ChangeFileExt(EditorFilename, WXFORM_EXT)) Then
                main.OpenFile(ChangeFileExt(EditorFilename, WXFORM_EXT), True);

        If (ELDesigner1.GenerateXRC) And FileExists(ChangeFileExt(EditorFilename, XRC_EXT))
            And (Not main.isFileOpenedinEditor(ChangeFileExt(EditorFilename, XRC_EXT))) Then
            If Not main.OpenUnitInProject(ChangeFileExt(EditorFilename, XRC_EXT)) Then
                main.OpenFile(ChangeFileExt(EditorFilename, XRC_EXT), True);

        If FileExists(ChangeFileExt(EditorFilename, H_EXT)) And (Not main.isFileOpenedinEditor(ChangeFileExt(EditorFilename, H_EXT))) Then
            If Not main.OpenUnitInProject(ChangeFileExt(EditorFilename, H_EXT)) Then
                main.OpenFile(ChangeFileExt(EditorFilename, H_EXT), True);

        If FileExists(ChangeFileExt(EditorFilename, CPP_EXT)) And (Not main.isFileOpenedinEditor(ChangeFileExt(EditorFilename, CPP_EXT))) Then
            If Not main.OpenUnitInProject(ChangeFileExt(EditorFilename, CPP_EXT)) Then
                main.OpenFile(ChangeFileExt(EditorFilename, CPP_EXT), True);

    //Reactivate the editor;
        If FileExists(EditorFilename) Then
        Begin
            If Not main.isFileOpenedinEditor(EditorFilename) Then
                main.OpenFile(EditorFilename, True)
            Else
            Begin
                main.ActivateEditor(EditorFilename);
                AlreadyActivated := True;
            End;
        End;
    End;
    If AlreadyActivated = False Then
        main.ActivateEditor(EditorFilename);
End;

Procedure TWXDsgn.NewProject(s: String);
Begin
    If strContains('wxWidgets Frame', s) Then
        NewWxProjectCode(dtWxFrame)
    Else
    If strContains('wxWidgets Dialog', s) Then
        NewWxProjectCode(dtWxDialog);
End;

Procedure TWXDsgn.CutExecute;
Begin
    If (JvInspProperties.Focused) Or (JvInspEvents.Focused) Then // If property inspector is focused, then cut text
        actWxPropertyInspectorCut.Execute
    Else // Otherwise form component is selected so cut whole component (control and code)
        actDesignerCut.Execute;
End;

Procedure TWXDsgn.CopyExecute;
Begin
    If (JvInspProperties.Focused) Or (JvInspEvents.Focused) Then // If property inspector is focused, then copy text
        actWxPropertyInspectorCopy.Execute
    Else // Otherwise form component is selected so copy whole component (control and code)
        actDesignerCopy.Execute;
End;

Procedure TWXDsgn.PasteExecute;
Begin
    If (JvInspProperties.Focused) Or (JvInspEvents.Focused) Then // If property inspector is focused, then paste text
        actWxPropertyInspectorPaste.Execute
    Else // Otherwise form component is selected so paste whole component (control and code)
        actDesignerPaste.Execute;
End;

Procedure TWXDsgn.FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Var
    i: Integer;
    designerFlag: Boolean;
Begin

    designerFlag := True;
    If ELDesigner1.Floating Then
        designerFlag := self.IsForm(main.GetActiveEditorName);

    If (ssCtrl In Shift) And ELDesigner1.Active And designerFlag And Not JvInspProperties.Focused And
        Not JvInspEvents.Focused And Not cleanUpJvInspEvents Then // If Designer Form is in focus
    Begin
        Case key Of
      //Move the selected component
            VK_Left:
                For i := 0 To (ELDesigner1.SelectedControls.Count - 1) Do
                    ELDesigner1.SelectedControls.Items[i].Left := ELDesigner1.SelectedControls.Items[i].Left - 1;
            VK_Right:
                For i := 0 To (ELDesigner1.SelectedControls.Count - 1) Do
                    ELDesigner1.SelectedControls.Items[i].Left := ELDesigner1.SelectedControls.Items[i].Left + 1;
            VK_Up:
                For i := 0 To (ELDesigner1.SelectedControls.Count - 1) Do
                    ELDesigner1.SelectedControls.Items[i].Top := ELDesigner1.SelectedControls.Items[i].Top - 1;
            VK_Down:
                For i := 0 To (ELDesigner1.SelectedControls.Count - 1) Do
                    ELDesigner1.SelectedControls.Items[i].Top := ELDesigner1.SelectedControls.Items[i].Top + 1;
        End;


        ELDesigner1.OnModified(Sender);

    End;

End;

Procedure TWXDsgn.AssignDesignerControl(editorName: String);
Begin
    If editors.Exists(editorName) Then
        ELDesigner1.DesignControl := (editors[editorName] As TWXEditor).GetDesigner;
End;

Procedure TWXDsgn.SetDesignerActiveState(state: Boolean);
Begin
    ELDesigner1.Active := state;
End;

// Get the login name to use as a default if the author name is unknown

Function TWXDsgn.GetLoginName: String;
Var
    buffer: Array[0..255] Of Char;
    size: dword;
Begin
    size := 256;
    If main.RetrieveUserName(buffer, size) Then
        Result := buffer
    Else
        Result := '';
End;

Function TWXDsgn.GetLangString(LangID: Integer): String;
Begin

    Result := main.GetLangString(LangID);

End;

// Create a dialog that will be destroyed by the client code

Function TWXDsgn.CreateCreateFormDlg(dsgnType: TWxDesignerType; insertProj: Integer; projShow: Boolean; filenamebase: String = ''): TfrmCreateFormProp;
Var
    SuggestedFilename: String;
    INI: Tinifile;
    profileNames: TStrings;
    defaultProfileIndex: Integer;
Begin
    If filenamebase = '' Then
        SuggestedFilename := main.GetUntitledFileName
    Else
        SuggestedFilename := filenamebase;
    Result := TfrmCreateFormProp.Create(self);
    Result.JvFormStorage1.RestoreFormPlacement;
    Result.JvFormStorage1.Active := False;
    Result.txtTitle.Text := SuggestedFilename;

    If dsgnType = dtWxFrame Then
        Result.Caption := GetLangString(ID_WX_NEWFRAME) //'New wxWidgets Frame'
    Else
        Result.Caption := GetLangString(ID_WX_NEWDIALOG); //'New wxWidgets Dialog';

  //Suggest a filename to the user
    If dsgnType = dtWxFrame Then
    Begin
        Result.txtFileName.Text := CreateValidFileName(SuggestedFilename + 'Frm');
        Result.txtClassName.Text := CreateValidClassName(SuggestedFilename + 'Frm');
    End
    Else
    Begin
        Result.txtFileName.Text := CreateValidFileName(SuggestedFilename + 'Dlg');
        Result.txtClassName.Text := CreateValidClassName(SuggestedFilename + 'Dlg');
    End;

  // Open the ini file and see if we have any default values for author, class, license
  // ReadString will return either the ini key or the default
    INI := TiniFile.Create(ConfigFolder + ChangeFileExt(ExtractFileName(Application.ExeName), '') + '.ini');
    Result.txtAuthorName.Text := INI.ReadString('wxWidgets', 'Author', GetLoginName);
    INI.free;

  // Add compiler profile names to the dropdown box
    profileNames := main.GetCompilerProfileNames(defaultProfileIndex);
    If (profileNames.Count <> 0) And (projShow = True) Then // if nil, then this is not part of a project (so no profile)
    Begin
        Result.ProfileNameSelect.Show;
        Result.ProfileLabel.Show;
        Result.ProfileNameSelect.Clear;
        Result.ProfileNameSelect.Items := profileNames;
        Result.ProfileNameSelect.ItemIndex := defaultProfileIndex; // default compiler profile selection
    End
    Else
    Begin
        Result.ProfileNameSelect.Hide;
        Result.ProfileLabel.Hide;
    End;
  //Decide where the file will be stored
    If insertProj = 1 Then
        Result.txtSaveTo.Text := IncludeTrailingPathDelimiter(ExtractFileDir(main.GetProjectFileName))
    Else
        Result.txtSaveTo.Text := IncludeTrailingPathDelimiter(LocalAppDataPath);
  {else if main.GetDevDirsDefault <> '' then
    Result.txtSaveTo.Text := IncludeTrailingPathDelimiter(main.GetDevDirsDefault)
  else if Trim(Result.txtSaveTo.Text) = '' then
    Result.txtSaveTo.Text := IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName));}
End;

Procedure TWXDsgn.CreateNewDialogOrFrameCode(dsgnType: TWxDesignerType; frm: TfrmCreateFormProp; insertProj: Integer);
Var
    TemplatesDir: String;
    BaseFilename: String;
    currFile: String;
    OwnsDlg: Boolean;

    strFName, strCName, strFTitle: String;
    dlgSStyle: TWxDlgStyleSet;
    strCppFile, strHppFile: String;
    INI: Tinifile;

    strLstXRCCode: TStringList;

Begin
  //Get the path of our templates
    TemplatesDir := IncludeTrailingPathDelimiter(main.GetRealPathFix(main.GetDevDirsTemplates, ExtractFileDir(Application.ExeName)));

  //Get the paths of the source code
    If dsgnType = dtWxFrame Then
    Begin
        strCppFile := TemplatesDir + 'wxWidgets\wxFrame.cpp.code';
        strHppFile := TemplatesDir + 'wxWidgets\wxFrame.h.code';
    End
    Else
    Begin
        strCppFile := TemplatesDir + 'wxWidgets\wxDlg.cpp.code';
        strHppFile := TemplatesDir + 'wxWidgets\wxDlg.h.code';
    End;

    If (Not fileExists(strCppFile)) Then
    Begin
        MessageDlg('Unable to find wxWidgets Template file: ' + strCppFile + #13 + #10#13 + #10 +
            'Please provide the template files in the template directory.', mtError, [mbOK], 0);
        exit;
    End
    Else
    If (Not fileExists(strHppFile)) Then
    Begin
        MessageDlg('Unable to find wxWidgets Template file: ' + strHppFile + #13#10#13#10 +
            'Please provide the template files in the template directory.', mtError, [mbOK], 0);
        exit;
    End;

  //Ask the user what he wants to do if the project parameter is set to 'prompt' (2)
    If main.IsProjectAssigned And (insertProj = 2) Then
        If MessageBox(ownerForm.Handle, Pchar(main.GetLangString(ID_MSG_NEWFILE)), 'wxDev-C++', MB_ICONQUESTION Or MB_YESNO) = 6 Then
            insertProj := 1
        Else
            insertProj := 0
    Else
    If (Not main.IsProjectAssigned) Then
        insertProj := 0;

  //Create the dialog and ask the user if we didn't specify a dialog to use
    OwnsDlg := Not Assigned(frm);
    If (Not Assigned(frm)) Then
    Begin
    //Get an instance of the dialog
        frm := CreateCreateFormDlg(dsgnType, insertProj, False);
    //Show the dialog
        If frm.showModal <> mrOK Then
        Begin
            frm.Destroy;
            exit;
        End;

    //Wow, the user clicked OK: save the user name
        INI := TiniFile.Create(ConfigFolder + ChangeFileExt(ExtractFileName(Application.ExeName), '') + '.ini');
        INI.WriteString('wxWidgets', 'Author', frm.txtAuthorName.Text);
        INI.free;
    End;
    If Not DirectoryExists(Trim(frm.txtSaveTo.Text)) Then
        If Not CreateDir(Trim(frm.txtSaveTo.Text)) Then
            Raise Exception.Create('Cannot create ' + ' ' + Trim(frm.txtSaveTo.Text));

  //And get the base filename
    BaseFilename := IncludeTrailingPathDelimiter(Trim(frm.txtSaveTo.Text)) + Trim(frm.txtFileName.Text);

  //OK, load the template and parse and save it
    ParseAndSaveTemplate(StrHppFile, ChangeFileExt(BaseFilename, H_EXT), frm);
    ParseAndSaveTemplate(StrCppFile, ChangeFileExt(BaseFilename, CPP_EXT), frm);
    GetIntialFormData(frm, strFName, strCName, strFTitle, dlgSStyle, dsgnType);
    CreateFormFile(strFName, strCName, strFTitle, dlgSStyle, dsgnType);

  //NinjaNL: If we have Generate XRC turned on then we need to create a blank XRC
  //         file on project initialisation
    If ELDesigner1.GenerateXRC Then
    Begin
        strLstXRCCode := CreateBlankXRC;
        Try
            strLstXRCCode.SaveToFile(ChangeFileExt(BaseFilename, XRC_EXT));
        Finally
            strLstXRCCode.Destroy;
        End;
    End;

  //Destroy the dialog if we own it
    If OwnsDlg Then
        frm.Destroy;

    currFile := ChangeFileExt(BaseFilename, H_EXT);
    main.PrepareFileForEditor(currFile, insertProj, False, True, False, 'wxdsgn');

    currFile := ChangeFileExt(BaseFilename, CPP_EXT);
    main.PrepareFileForEditor(currFile, insertProj, False, True, False, 'wxdsgn');

    If (ELDesigner1.GenerateXRC) Then
    Begin
        currFile := ChangeFileExt(BaseFilename, XRC_EXT);
        main.PrepareFileForEditor(currFile, insertProj, False, True, False, 'wxdsgn');
    End;

    currFile := ChangeFileExt(BaseFilename, WXFORM_EXT);
    main.PrepareFileForEditor(currFile, insertProj, False, True, True, 'wxdsgn');

    UpdateDesignerData(currFile);

    If Not main.IsClassBrowserEnabled Then
        MessageDlg('The Class Browser is not enabled.' + #13#10#13#10 +
            'The addition of event handlers and other features of the Form ' +
            'Designer won''t work properly.' + #13#10#13#10 +
            'Please enable the Class Browser.', mtInformation, [mbOK], 0);
End;

Procedure TWXDsgn.NewWxProjectCode(dsgnType: TWxDesignerType);
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
Var
    frm: TfrmCreateFormProp;
    TemplatesDir: String;
    BaseFilename: String;
    currFile: String;
    strAppCppFile, strAppHppFile, strAppRcFile: String;
    ini: Tinifile;
    UseRC: Boolean;

Begin

// GAR 10 Nov 2009
// Hack for Wine/Linux
// ProductName returns empty string for Wine/Linux
// for Windows, it returns OS name (e.g. Windows Vista).
    If (ComputerInfo1.OS.ProductName = '') Then
        UseRC := False
    Else
        UseRC := True;

  //Get the path of our templates
    TemplatesDir := IncludeTrailingPathDelimiter(main.GetRealPathFix(main.GetDevDirsTemplates, ExtractFileDir(Application.ExeName)));

    If (UseRC) Then
    Begin
    //Get the filepaths of the templates
        strAppRcFile := TemplatesDir + 'wxWidgets\wxprojRes.rc';
    End;

    If dsgnType = dtWxFrame Then
    Begin
        strAppCppFile := TemplatesDir + 'wxWidgets\wxprojFrameApp.cpp';
        strAppHppFile := TemplatesDir + 'wxWidgets\wxprojFrameApp.h';
    End
    Else
    Begin
        strAppCppFile := TemplatesDir + 'wxWidgets\wxprojDlgApp.cpp';
        strAppHppFile := TemplatesDir + 'wxWidgets\wxprojDlgApp.h';
    End;

  //If template files don't exist, we need to send an error message to user.
    If (Not fileExists(strAppCppFile)) Then
    Begin
        MessageDlg('Unable to find wxWidgets Template file: ' + strAppCppFile + #13 + #10#13 + #10 +
            'Please provide the template files in the template directory.', mtError, [mbOK], 0);
        exit;
    End
    Else
    If (Not fileExists(strAppHppFile)) Then
    Begin
        MessageDlg('Unable to find wxWidgets Template file: ' + strAppHppFile + #13 + #10#13 + #10 +
            'Please provide the template files in the template directory.', mtError, [mbOK], 0);
        exit;
    End;

  //Create an instance of the form creation dialog and show it
    frm := CreateCreateFormDlg(dsgnType, 1, True, ChangeFileExt(ExtractFileName(main.GetProjectFileName), ''));
    If frm.showModal <> mrOK Then
    Begin
        frm.Destroy;
        exit;
    End;

  // Change the current profile to what the user selected in the new project dialog
    main.ChangeProjectProfile(frm.ProfileNameSelect.ItemIndex);

  //Write the current strings back as the default
    INI := TiniFile.Create(ConfigFolder + ChangeFileExt(ExtractFileName(Application.ExeName), '') + '.ini');
    INI.WriteString('wxWidgets', 'Author', frm.txtAuthorName.Text);
    INI.free;

  //Then add the application initialization code
    BaseFilename := Trim(ChangeFileExt(main.GetProjectFileName, '')) + APP_SUFFIX;
    ParseAndSaveTemplate(StrAppHppFile, ChangeFileExt(BaseFilename, H_EXT), frm);
    ParseAndSaveTemplate(StrAppCppFile, ChangeFileExt(BaseFilename, CPP_EXT), frm);

    If (ComputerInfo1.OS.ProductName <> '') Then
        ParseAndSaveTemplate(strAppRcFile, ChangeFileExt(BaseFilename, RC_EXT), frm);

  //Add the application entry source fle
    currFile := ChangeFileExt(BaseFilename, CPP_EXT);
    main.PrepareFileForEditor(currFile, 0, True, True, False, '');

    currFile := ChangeFileExt(BaseFilename, H_EXT);
    main.PrepareFileForEditor(currFile, 0, True, False, False, '');

    If (UseRC) Then
    Begin
        currFile := ChangeFileExt(BaseFilename, RC_EXT);
        main.PrepareFileForEditor(currFile, 0, True, False, False, '');
    End;

  //Finally create the form creation code
    CreateNewDialogOrFrameCode(dsgnType, frm, 1);
End;

Procedure TWXDsgn.InitEditor(strFileName: String);
Var
    editor: TWXEditor;
    tabSheet: TTabSheet;
    text: TSynEdit;
    editorName: String;
Begin
    editorName := ChangeFileExt(strFileName, WXFORM_EXT);
    tabSheet := main.GetEditorTabSheet(editorName);
    text := main.GetEditorText(editorName);
    editor := TWXEditor.Create;
    SetLength(editorNames, editors.ItemCount + 1);
    editorNames[editors.ItemCount] := editorName;
    editors[editorName] := editor;
    editor.Init(tabSheet, text, DesignerPopup, True, editorName);
    editor.editorNumber := editors.ItemCount - 1;
End;

Function TWXDsgn.CreateFormFile(strFName, strCName, strFTitle: String; dlgSStyle: TWxDlgStyleSet; dsgnType: TWxDesignerType): Boolean;
Var
    FNewFormObj: TfrmNewForm;
Begin
    Result := True;
    FNewFormObj := TfrmNewForm.Create(ownerForm);
    Try
        Try
            If dsgnType = dtWxFrame Then
                FNewFormObj.Wx_DesignerType := dtWxFrame
            Else
                FNewFormObj.Wx_DesignerType := dtWxDialog;

            FNewFormObj.Caption := strFTitle;
            FNewFormObj.Wx_DialogStyle := dlgSStyle;
            FNewFormObj.Wx_Name := strCName;
            FNewFormObj.Wx_Center := True;
            FNewFormObj.fileName := strFName;
            FNewFormObj.EVT_CLOSE := 'OnClose';
            WriteComponentsToFile([FNewFormObj], ChangeFileExt(strFName, wxform_Ext));
        Except
            Result := False;
        End;
    Finally
        FNewFormObj.Destroy;
    End;
End;

Procedure TWXDsgn.GetIntialFormData(frm: TfrmCreateFormProp; Var strFName, strCName, strFTitle: String; Var dlgStyle: TWxDlgStyleSet; dsgnType: TWxDesignerType);
Begin
    strCName := Trim(frm.txtClassName.Text);
    strFTitle := Trim(frm.txtTitle.Text);
    strFName := IncludeTrailingPathDelimiter(Trim(frm.txtSaveTo.Text)) + Trim(frm.txtFileName.Text);

    dlgStyle := [];
    If frm.cbUseCaption.checked Then
        dlgStyle := [wxCAPTION];

    If frm.cbResizeBorder.checked Then
        dlgStyle := dlgStyle + [wxRESIZE_BORDER];

    If frm.cbSystemMenu.checked Then
        dlgStyle := dlgStyle + [wxSYSTEM_MENU];

    If frm.cbThickBorder.checked Then
        dlgStyle := dlgStyle + [wxTHICK_FRAME];

    If frm.cbStayOnTop.checked Then
        dlgStyle := dlgStyle + [wxSTAY_ON_TOP];

    If frm.cbNoParent.checked Then
        dlgStyle := dlgStyle + [wxDIALOG_NO_PARENT];

    If frm.cbMinButton.checked Then
        dlgStyle := dlgStyle + [wxMINIMIZE_BOX];

    If frm.cbMaxButton.checked Then
        dlgStyle := dlgStyle + [wxMAXIMIZE_BOX];

    If frm.cbCloseButton.checked Then
        dlgStyle := dlgStyle + [wxCLOSE_BOX];
End;

Procedure TWXDsgn.ParseAndSaveTemplate(template, destination: String; frm: TfrmCreateFormProp);
Var
    TemplateStrings: TStringList;
    OutputString: String;
    WindowStyle: String;
    ClassName: String;
    Filename: String;
    DateStr: String;
    Author: String;
    Title: String;
    tempFileName: String;
Begin
  //Determine the window style
    If frm.cbUseCaption.checked Then
        WindowStyle := 'wxCAPTION | ';

    If frm.cbResizeBorder.checked Then
        WindowStyle := WindowStyle + 'wxRESIZE_BORDER | ';

    If frm.cbSystemMenu.checked Then
        WindowStyle := WindowStyle + 'wxSYSTEM_MENU | ';

    If frm.cbThickBorder.checked Then
        WindowStyle := WindowStyle + 'wxTHICK_FRAME | ';

    If frm.cbStayOnTop.checked Then
        WindowStyle := WindowStyle + 'wxSTAY_ON_TOP | ';

    If frm.cbNoParent.checked Then
        WindowStyle := WindowStyle + 'wxDIALOG_NO_PARENT | ';

    If frm.cbMinButton.checked Then
        WindowStyle := WindowStyle + 'wxMINIMIZE_BOX | ';

    If frm.cbMaxButton.checked Then
        WindowStyle := WindowStyle + 'wxMAXIMIZE_BOX | ';

    If frm.cbCloseButton.checked Then
        WindowStyle := WindowStyle + 'wxCLOSE_BOX | ';

  //Finalize the window style string
    If Length(WindowStyle) <> 0 Then
        WindowStyle := Copy(WindowStyle, 0, Length(WindowStyle) - 3)
    Else
        WindowStyle := '0';

  //Get the remaining properties
    ClassName := Trim(frm.txtClassName.Text);

    tempFileName := IncludeTrailingPathDelimiter(Trim(frm.txtSaveTo.Text)) + Trim(frm.txtFileName.Text);
    Filename := ExtractRelativePath(destination, tempFileName);

    DateStr := DateTimeToStr(now);
    Author := Trim(frm.txtAuthorName.Text);
    Title := Trim(frm.txtTitle.Text);
    If (FileExists(template) = False) Then
    Begin
        ShowMessage('Unable to find Template file ' + template);
        exit;
    End;
  //Load the strings from file
    TemplateStrings := TStringList.Create;
    Try
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
        If main.IsProjectAssigned Then
        Begin
            strSearchReplace(OutputString, '%PROJECT_NAME%', ChangeFileExt(ExtractFileName(main.GetProjectFileName), ''), [srAll]);
            strSearchReplace(OutputString, '%APP_NAME%', ChangeFileExt(ExtractFileName(main.GetProjectFileName), '') + APP_SUFFIX, [srAll]);
        End
        Else
        Begin
            strSearchReplace(OutputString, '%PROJECT_NAME%', '', [srAll]);
            strSearchReplace(OutputString, '%APP_NAME%', '', [srAll]);
        End;

    //Finally save the entire string to file
        SaveStringToFile(OutputString, destination);
    Finally
        TemplateStrings.Destroy;
    End;
End;

Function TWXDsgn.CreateSourceCodes(strCppFile, strHppFile: String; FCreateFormProp: TfrmCreateFormProp; Var cppCode, hppCode: String; dsgnType: TWxDesignerType): Boolean;
Var
    strClassName, strClassTitle, strClassStyleString, strFileName, strDate, strAuthor: String;
    strLstHeaderCode, strLstSourceCode, strLstXRCCode: TStringList;

    Function GetStyleString: String;
    Var
        I: Integer;
        strLst: TStringList;
    Begin
        strLst := TStringList.Create;

        If FCreateFormProp.cbUseCaption.checked Then
            strLst.add('wxCAPTION');

        If FCreateFormProp.cbResizeBorder.checked Then
            strLst.add('wxRESIZE_BORDER');

        If FCreateFormProp.cbSystemMenu.checked Then
            strLst.add('wxSYSTEM_MENU');

        If FCreateFormProp.cbThickBorder.checked Then
            strLst.add('wxTHICK_FRAME');

        If FCreateFormProp.cbStayOnTop.checked Then
            strLst.add('wxSTAY_ON_TOP');

        If (dsgnType = dtWxDialog) Then
            If FCreateFormProp.cbNoParent.checked Then
                strLst.add('wxDIALOG_NO_PARENT');

        If FCreateFormProp.cbMinButton.checked Then
            strLst.add('wxMINIMIZE_BOX');

        If FCreateFormProp.cbMaxButton.checked Then
            strLst.add('wxMAXIMIZE_BOX');

        If FCreateFormProp.cbCloseButton.checked Then
            strLst.add('wxCLOSE_BOX');

        If strLst.Count = 0 Then
        Begin
            If (dsgnType = dtWxDialog) Then
            Begin
                Result := 'wxDEFAULT_DIALOG_STYLE';
            End;
            If (dsgnType = dtWxFrame) Then
            Begin
                Result := 'wxDEFAULT_FRAME_STYLE';
            End;
        End
        Else
        Begin
            For I := 0 To strLst.count - 1 Do // Iterate
            Begin
                If i <> strLst.count - 1 Then
                    Result := Result + strLst[i] + ' | '
                Else
                    Result := Result + ' ' + strLst[i] + ' ';
            End; // for
        End;
        strLst.destroy;
    End;

    Function replaceAllSymbolsInStrLst(strLst: TStrings; Var strFileSrc: String):
    Boolean;
    Begin
        Result := True;
        Try
            strFileSrc := strLst.text;
            strSearchReplace(strFileSrc, '%FILE_NAME%', ExtractFileName(strFileName), [srAll]);
            strSearchReplace(strFileSrc, '%DEVCPP_DIR%', main.GetExec, [srAll]);
            strSearchReplace(strFileSrc, '%AUTHOR_NAME%', strAuthor, [srAll]);
            strSearchReplace(strFileSrc, '%DATE_STRING%', strDate, [srAll]);
            strSearchReplace(strFileSrc, '%CLASS_NAME%', strClassName, [srAll]);
            strSearchReplace(strFileSrc, '%CAP_CLASS_NAME%', UpperCase(strClassName), [srAll]);

            strSearchReplace(strFileSrc, '%CLASS_TITLE%', strClassTitle, [srAll]);
            strSearchReplace(strFileSrc, '%CLASS_STYLE_STRING%', strClassStyleString, [srAll]);

        Finally

        End;
    End;
Begin
    Result := False;
    If Not assigned(FCreateFormProp) Then
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
    If Result Then
    Begin
        SaveStringToFile(hppCode, ChangeFileExt(strFileName, H_EXT));

        If (ELDesigner1.GenerateXRC) Then
        Begin
            strLstXRCCode := CreateBlankXRC;
            Result := SaveStringToFile(strLstXRCCode.Text, ChangeFileExt(strFileName, XRC_EXT));
            strLstXRCCode.Destroy;
        End;

    End;

End;

Function TWXDsgn.CreateAppSourceCodes(strCppFile, strHppFile, strAppCppFile, strAppHppFile: String; FCreateFormProp: TfrmCreateFormProp; Var cppCode, hppCode, appcppCode, apphppCode: String; dsgnType: TWxDesignerType): Boolean;
// This is scavenged from TMainForm.CreateSourceCodes (above)
// It uses the template files passed to it through the file names contained in
// strCppFile,strHppFile, strAppCppFile, and strAppHppFile to create new
// .cpp and .h files based on those templates. It replaces the keywords
// in the templates (%FILE_NAME%, %CLASS_NAME%, %AUTHOR_NAME%, etc.) with
// those supplied by the user. Finally, it creates a resource file and a
// wxform file for the new project.
Var
    strClassName, strClassTitle, strClassStyleString, strFileName, strDate, strAuthor: String;
    strLstHeaderCode, strLstSourceCode, strLstAppHeaderCode, strLstAppSourceCode, strLstXRCCode: TStringList;

    Function GetStyleString: String;
    Var
        I: Integer;
        strLst: TStringList;
    Begin
        strLst := TStringList.Create;

        If FCreateFormProp.cbUseCaption.checked Then
            strLst.add('wxCAPTION');

        If FCreateFormProp.cbResizeBorder.checked Then
            strLst.add('wxRESIZE_BORDER');

        If FCreateFormProp.cbSystemMenu.checked Then
            strLst.add('wxSYSTEM_MENU');

        If FCreateFormProp.cbThickBorder.checked Then
            strLst.add('wxTHICK_FRAME');

        If FCreateFormProp.cbStayOnTop.checked Then
            strLst.add('wxSTAY_ON_TOP');

        If (dsgnType = dtWxDialog) Then
            If FCreateFormProp.cbNoParent.checked Then
                strLst.add('wxDIALOG_NO_PARENT');

        If FCreateFormProp.cbMinButton.checked Then
            strLst.add('wxMINIMIZE_BOX');

        If FCreateFormProp.cbMaxButton.checked Then
            strLst.add('wxMAXIMIZE_BOX');

        If FCreateFormProp.cbCloseButton.checked Then
            strLst.add('wxCLOSE_BOX');

        If strLst.Count = 0 Then
        Begin
            If (dsgnType = dtWxDialog) Then
                Result := 'wxDEFAULT_DIALOG_STYLE';

            If (dsgnType = dtWxFrame) Then
                Result := 'wxDEFAULT_FRAME_STYLE';
        End
        Else
        Begin
            For I := 0 To strLst.count - 1 Do // Iterate
            Begin
                If i <> strLst.count - 1 Then
                    Result := Result + strLst[i] + '  |  '
                Else
                    Result := Result + ' ' + strLst[i] + ' ';
            End; // for
        End;
        strLst.destroy;
    End;

  // A function within a function
  // This replaces all occurrences of several keywords in a text string

    Function replaceAllSymbolsInStrLst(strLst: TStrings; Var strFileSrc: String):
    Boolean;
    Begin
        Result := True;
        Try
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

        Finally

        End;
    End;
Begin
    Result := False;
    If Not assigned(FCreateFormProp) Then
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
    If Result Then
        Result := SaveStringToFile(hppCode, ChangeFileExt(strFileName, H_EXT));
    If Result Then
        Result := SaveStringToFile(apphppCode, ChangeFileExt(main.GetProjectFileName, '') + APP_SUFFIX + H_EXT);
    If Result Then
        Result := SaveStringToFile(appcppCode, ChangeFileExt(main.GetProjectFileName, '') + APP_SUFFIX + CPP_EXT);

    If Result And ELDesigner1.GenerateXRC Then
    Begin
        strLstXRCCode := CreateBlankXRC;
        Result := SaveStringToFile(strLstXRCCode.Text, ChangeFileExt(strFileName, XRC_EXT));
        strLstXRCCode.Destroy;
    End;

    If Result Then
        Result := SaveStringToFile('#include <wx/msw/wx.rc>', ChangeFileExt(main.GetProjectFileName, '') + APP_SUFFIX + '.rc');

End;

Procedure TWXDsgn.ELDesigner1ContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Var
    CurrentControl: TControl;
    NewMenuItem: TMenuItem;
    strControlName: String;
    FrmInterface: IWxDesignerFormInterface;
Begin
  //Create the selected control's "inheritence" tree
    If ELDesigner1.SelectedControls.Count > 0 Then
    Begin
        DesignerMenuSelectParent.Clear;
        DesignerMenuSelectParent.Enabled := True;
        DesignerMenuLocked.Enabled := True;

    //First check or uncheck the locking mode of the component
        CurrentControl := ELDesigner1.SelectedControls.Items[0];
        DesignerMenuLocked.Checked := ELDesigner1.GetLockMode(CurrentControl) <> [];
        DesignerMenuCut.Enabled := Not DesignerMenuLocked.Checked;
        DesignerMenuDelete.Enabled := Not DesignerMenuLocked.Checked;

        While CurrentControl.Parent <> Nil Do
        Begin
            CurrentControl := CurrentControl.Parent;
            NewMenuItem := TMenuItem.Create(Self);
            If CurrentControl.GetInterface(IID_IWxDesignerFormInterface, FrmInterface) = True Then
                strControlName := FrmInterface.GetFormName
            Else
                strControlName := CurrentControl.Name;
            NewMenuItem.Caption := strControlName;
            NewMenuItem.OnClick := SelectParentClick;
            DesignerMenuSelectParent.Add(NewMenuItem);
        End;
    End
    Else
    Begin
        DesignerMenuSelectParent.Enabled := False;
        DesignerMenuLocked.Enabled := False;
    End;

    Handled := True;
    DesignerPopup.Popup(MousePos.X, MousePos.Y);
End;

Procedure TWXDsgn.WxPropertyInspectorContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Var
    Pos: TPoint;
Begin
  //Create a temporary var variable
    Pos := MousePos;
    Handled := True;

  //Convert to screen coordinates
    Windows.ClientToScreen(GetFocus, Pos);

  //Pop the menu up
    WxPropertyInspectorPopup.Popup(Pos.X, Pos.Y);
End;

Procedure TWXDsgn.ELDesigner1ChangeSelection(Sender: TObject);
Begin
{$IFNDEF PRIVATE_BUILD}
    Try
{$ENDIF}
        If (ELDesigner1 = Nil) Or (ELDesigner1.DesignControl = Nil) Then
            Exit;

    //Make sure the Designer Form has the focus
        ELDesigner1.DesignControl.SetFocus;

    //Find the index of the current control and show its properties
        If ELDesigner1.SelectedControls.Count > 0 Then
        Begin
            cbxControlsx.ItemIndex :=
                cbxControlsx.Items.IndexOfObject(ELDesigner1.SelectedControls[0]);
            BuildProperties(ELDesigner1.SelectedControls[0]);
        End
        Else
        If isCurrentPageDesigner Then
            BuildProperties(GetCurrentDesignerForm);
{$IFNDEF PRIVATE_BUILD}
    Finally
    End;
{$ENDIF}
End;

Procedure TWXDsgn.ELDesigner1ControlDeleted(Sender: TObject;
    AControl: TControl);
Var
    intCtrlPos, i: Integer;
    strCompName: String;
    wxcompInterface: IWxComponentInterface;
    editorName: String;
Begin
    intCtrlPos := -1;

    For i := cbxControlsx.Items.Count - 1 Downto 0 Do
    Begin
        If AControl.GetInterface(IID_IWxComponentInterface, wxcompInterface) Then
        Begin
            strCompName := AControl.Name + ':' + wxcompInterface.GetWxClassName;
            If AnsiSameText(cbxControlsx.Items[i], strCompName) Then
            Begin
                cbxControlsx.Items.Delete(i);
                intCtrlPos := i;
            End;
        End;
    End;

    If intCtrlPos <> -1 Then
    Begin
        If isCurrentPageDesigner Then
        Begin
            intCtrlPos := cbxControlsx.Items.IndexOfObject(GetCurrentDesignerForm);
            If ELDesigner1.SelectedControls.Count > 0 Then
                FirstComponentBeingDeleted := ELDesigner1.SelectedControls[0].Name;

            SelectedComponent := GetCurrentDesignerForm;
            BuildProperties(ELDesigner1.DesignControl);

            If intCtrlPos <> -1 Then
                cbxControlsx.ItemIndex := intCtrlPos;
        End;

        If AControl Is TWinControl Then
        Begin
            For i := 0 To TWinControl(AControl).ControlCount - 1 Do
            Begin
                intCtrlPos := cbxControlsx.Items.IndexOfObject(TWinControl(AControl).Controls[i]);
                If intCtrlPos <> -1 Then
                    cbxControlsx.Items.Delete(intCtrlPos);
            End;
        End;
    End;

    editorName := main.GetActiveEditorName;
    If main.IsEditorAssigned(editorName) Then
        UpdateDesignerData(editorName);

End;

Procedure TWXDsgn.ELDesigner1ControlHint(Sender: TObject;
    AControl: TControl; Var AHint: String);
Var
    compIntf: IWxComponentInterface;
Begin
    If AControl.GetInterface(IID_IWxComponentInterface, compIntf) Then
    Begin
        AHint := Format('%s:%s', [AControl.name, compIntf.GetWxClassName]);
    End;
End;

Procedure TWXDsgn.ELDesigner1ControlInserted(Sender: TObject; AControl: TControl);
Var
    I: Integer;
    compObj: TComponent;
    wxcompInterface: IWxComponentInterface;
    strClass: String;
    wxControlPanelInterface: IWxControlPanelInterface;
Begin
    FirstComponentBeingDeleted := '';
    If ELDesigner1.SelectedControls.Count > 0 Then
    Begin
        compObj := ELDesigner1.SelectedControls[ELDesigner1.SelectedControls.Count - 1];
        ELDesigner1.SelectedControls[ELDesigner1.SelectedControls.Count - 1].BringToFront;
        ELDesigner1.SelectedControls[ELDesigner1.SelectedControls.Count - 1].Visible := True;

        If compObj.GetInterface(IID_IWxComponentInterface, wxcompInterface) Then
        Begin
            strClass := wxcompInterface.GetWxClassName;
            SelectedComponent := compObj;
        End;

        cbxControlsx.ItemIndex :=
            cbxControlsx.Items.AddObject(ELDesigner1.SelectedControls[ELDesigner1.SelectedControls.Count - 1].Name + ':' +
            strClass, ELDesigner1.SelectedControls[ELDesigner1.SelectedControls.Count - 1]);

    End;

    If (AControl Is TWinControl) Then
    Begin
    //TODO: Guru: Try to create an interface to make sure whether a container has
    //a limiting control. If someone is dropping more than one control then we'll
    //make the controls's parent as the parent of SplitterWindow
        If (TWinControl(AControl).Parent <> Nil) And (TWinControl(AControl).Parent Is TWxSplitterWindow) Then
            If TWinControl(AControl).Parent.ControlCount > 2 Then
                TWinControl(AControl).Parent := TWinControl(AControl).Parent.Parent;

        If SelectedComponent <> Nil Then
        Begin
            If (SelectedComponent Is TWxNoteBookPage) Then
            Begin
                TWinControl(SelectedComponent).Parent := TWinControl(PreviousComponent);
                If (PreviousComponent Is TWxNotebook) Then
                Begin
                    TWxNoteBookPage(SelectedComponent).PageControl := TPageControl(PreviousComponent);
                End;

                If (PreviousComponent Is TWxChoicebook) Then
                Begin
                    TWxNoteBookPage(SelectedComponent).PageControl := TPageControl(TWxChoicebook(PreviousComponent).pgc1);
                    TWxNoteBookPage(SelectedComponent).TabVisible := False;
                End;

                If (PreviousComponent Is TWxListbook) Then
                Begin
                    TWxNoteBookPage(SelectedComponent).PageControl := TPageControl(TWxListbook(PreviousComponent).pgc1);
                    TWxNoteBookPage(SelectedComponent).TabVisible := False;
                End;

                If (PreviousComponent Is TWxToolbook) Then
                Begin
                    TWxNoteBookPage(SelectedComponent).PageControl := TPageControl(TWxToolbook(PreviousComponent).pgc1);
                    TWxNoteBookPage(SelectedComponent).TabVisible := False;
                End;

                If (PreviousComponent Is TWxTreebook) Then
                Begin
                    TWxNoteBookPage(SelectedComponent).PageControl := TPageControl(TWxTreebook(PreviousComponent).pgc1);
                    TWxNoteBookPage(SelectedComponent).TabVisible := False;
                End;
            End;

            If (SelectedComponent Is TWxAuiNoteBookPage) Then
            Begin
                TWinControl(SelectedComponent).Parent := TWinControl(PreviousComponent);
                If (PreviousComponent Is TWxAuiNotebook) Then
                Begin
                    TWxAuiNoteBookPage(SelectedComponent).PageControl := TPageControl(PreviousComponent);
                End;
            End;

            If (SelectedComponent Is TWxNonVisibleBaseComponent) And Not (SelectedComponent.ClassName = 'TWxAuiPaneInfo') Then
                TWxNonVisibleBaseComponent(SelectedComponent).Parent := ELDesigner1.DesignControl;

            If TfrmNewForm(ELDesigner1.DesignControl).Wx_DesignerType = dtWxFrame Then
            Begin
                If (SelectedComponent Is TWxToolBar) Then
                    TWxToolBar(SelectedComponent).Parent := ELDesigner1.DesignControl;

                If (SelectedComponent Is TWxStatusBar) Then
                    TWxStatusBar(SelectedComponent).Parent := ELDesigner1.DesignControl;
            End;

      {      //Like wxWidgets' default behaviour, fill the whole screen if only one control
      //is on the screen
      if GetWxWindowControls(ELDesigner1.DesignControl) = 1 then
        if IsControlWxWindow(Tcontrol(SelectedComponent)) then
          if TWincontrol(SelectedComponent).Parent is TForm then
            TWincontrol(SelectedComponent).Align := alClient;
      }
        End;
    End;

    PreviousComponent := Nil;
    For I := 0 To ELDesigner1.SelectedControls.Count - 1 Do // Iterate
    Begin
        compObj := ELDesigner1.SelectedControls[i];
        If compObj Is TWinControl Then
      //if we drop a control to image or other static controls that are derived
      //from TWxControlPanel

            If TWinControl(compObj).Parent.GetInterface(IID_IWxControlPanelInterface, wxControlPanelInterface) Then
            Begin
{$IFNDEF PRIVATE_BUILD}
                Try
{$ENDIF}
                    If assigned(TWinControl(compObj).parent.parent) Then
                        TWinControl(compObj).parent := TWinControl(compObj).parent.parent;
{$IFNDEF PRIVATE_BUILD}
                Except
                End;
{$ENDIF}
            End;

{$IFNDEF PRIVATE_BUILD}
        Try
{$ENDIF}
            If compObj.GetInterface(IID_IWxComponentInterface, wxcompInterface) Then
            Begin
                Inc(intControlCount);
                wxcompInterface.SetIDName('ID_' + UpperCase(compObj.Name));
                wxcompInterface.SetIDValue(intControlCount);
            End;
{$IFNDEF PRIVATE_BUILD}
        Except
        End;
{$ENDIF}
    End; // End for

    ComponentPalette.UnselectComponents;
    main.UnSetActiveControl;
    UpdateDesignerData(main.GetActiveEditorName);

  //This makes the Sizers get painted properly.
    If ELDesigner1.SelectedControls.Count > 0 Then
    Begin
        compObj := ELDesigner1.SelectedControls[0].parent;
        If compObj Is TWinControl Then
            While (compObj <> Nil) Do
            Begin
                TWinControl(compObj).refresh;
                TWinControl(compObj).repaint;
                TWinControl(compObj) := TWinControl(compObj).parent;
            End; // for
    End;

    ELDesigner1.DesignControl.Refresh;
    ELDesigner1.DesignControl.Repaint;
End;

Procedure TWXDsgn.DisableDesignerControls;
Begin
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
    ELDesigner1.DesignControl := Nil;

    SelectedComponent := Nil;
    If boolInspectorDataClear Then
    Begin
        JvInspProperties.Clear;
        If Assigned(JvInspProperties.Root) Then
            JvInspProperties.Root.Clear;
        JvInspEvents.Clear;
        If Assigned(JvInspEvents.Root) Then
            JvInspEvents.Root.Clear;
    End;

    boolInspectorDataClear := True;
    cbxControlsx.Items.Clear;
    Screen.Cursor := crDefault;
End;

Procedure TWXDsgn.EnableDesignerControls;
Begin
  //TODO: Guru: I have no clue why I'm getting an error at this place.
{$IFNDEF PRIVATE_BUILD}
    Try
{$ENDIF}
        If Assigned(ELDesigner1.DesignControl) Then
        Begin
            ELDesigner1.Active := True;
            ELDesigner1.DesignControl.SetFocus;
        End;
{$IFNDEF PRIVATE_BUILD}
    Finally
{$ENDIF}
        cbxControlsx.Enabled := True;
{$IFNDEF PRIVATE_BUILD}
    End;
{$ENDIF}

    If cleanUpJvInspEvents Then
    Begin
        JvInspEvents.Root.Visible := True;
        JvInspProperties.Root.Visible := True;
        cleanUpJvInspEvents := False;
    End;

    pgCtrlObjectInspector.Enabled := True;
    JvInspProperties.Enabled := True;
    JvInspEvents.Enabled := True;
    palettePanel.BevelInner := bvNone;
    ComponentPalette.Enabled := True;
    ComponentPalette.Visible := True;
End;

Procedure TWXDsgn.ELDesigner1ControlDoubleClick(Sender: TObject);    // EAB: Look here for designer doubleclick events
Var
    i, nSlectedItem: Integer;
Begin
    If JvInspEvents.Root.Count = 0 Then
        exit;
    nSlectedItem := -1;
    For i := 0 To JvInspEvents.Root.Count - 1 Do
    Begin
        If JvInspEvents.Root.Items[i].Hidden = False Then
        Begin
            nSlectedItem := i;
            break;
        End;
    End;
    If nSlectedItem = -1 Then
        exit;

    JvInspEvents.Show;
  //If we dont select it then the Selection Event wont get fired
    JvInspEvents.SelectedIndex := JvInspEvents.Root.Items[nSlectedItem].DisplayIndex;

    If JvInspEvents.Root.Items[nSlectedItem].Data.AsString <> '' Then
    Begin
        strGlobalCurrentFunction := JvInspEvents.Root.Items[nSlectedItem].Data.AsString;
        JvInspEvents.OnDataValueChanged := Nil;
        JvInspEvents.Root.Items[nSlectedItem].Data.AsString := '<Goto Function>';
        JvInspEvents.Root.Items[nSlectedItem].DoneEdit(True);
        JvInspEvents.OnDataValueChanged := JvInspEventsDataValueChanged;
        JvInspEventsDataValueChanged(Nil, JvInspEvents.Root.Items[nSlectedItem].Data);
    End
    Else
    Begin
        JvInspEvents.OnDataValueChanged := Nil;
        JvInspEvents.Root.Items[nSlectedItem].Data.AsString := '<Add New Function>';
        JvInspEvents.Root.Items[nSlectedItem].DoneEdit(True);
        JvInspEvents.OnDataValueChanged := JvInspEventsDataValueChanged;
        JvInspEventsDataValueChanged(Nil, JvInspEvents.Root.Items[nSlectedItem].Data);
    End;
    If pendingEditorSwitch Then
    Begin
        JvInspEvents.OnMouseMove := Nil;
        JvInspEvents.OnMouseUp := Nil;
        pendingEditorSwitch := False;
    End;
End;

Procedure TWXDsgn.ELDesigner1ControlInserting(Sender: TObject;
    Var AParent: TWinControl; Var AControlClass: TControlClass);
Var
    dlgInterface: IWxDialogNonInsertableInterface;
    tlbrInterface: IWxToolBarInsertableInterface;
    nontlbrInterface: IWxToolBarNonInsertableInterface;
    //compObj: TComponent;
    I: Integer;

    Function GetNonAllowAbleControlCountForFrame(winCtrl: TWinControl): Integer;
    Var
        I: Integer;
    Begin
        Result := 0;
    //TODO: Guru: Weird error remover ... Shitty solution.
        FirstComponentBeingDeleted := '';

        If winCtrl = Nil Then
            Exit;
        Result := 0;
        For I := 0 To winCtrl.ControlCount - 1 Do
        Begin
            If (winCtrl.Controls[i] Is TWxToolBar) Or (winCtrl.Controls[i] Is TWxMenuBar)
                Or (winCtrl.Controls[i] Is TWxStatusBar) Or (winCtrl.Controls[i] Is TWxPopupMenu)
                Or (winCtrl.Controls[i] Is TWxNonVisibleBaseComponent) Then
                Continue;
            Inc(Result);
        End;
    End;

    Function isSizerAvailable(winCtrl: TWinControl): Boolean;
    Var
        I: Integer;
    Begin
        Result := False;
    //TODO: Guru: Weird error remover ... Shitty solution.
        FirstComponentBeingDeleted := '';

        If winCtrl = Nil Then
            Exit;
        For I := 0 To winCtrl.ComponentCount - 1 Do
        Begin
            If winCtrl.Components[i] Is TWxSizerPanel Then
            Begin
                Result := True;
                Exit;
            End;
        End;
    End;

    Procedure ShowErrorAndReset(msgstr: String);
    Begin
        MessageDlg(msgstr, mtError, [mbOK], ownerForm.Handle);
        ComponentPalette.UnselectComponents;
        PreviousComponent := Nil;
        AControlClass := Nil;

    //Select the parent
        SendMessage(AParent.Handle, WM_LBUTTONDOWN, 0, MAKELONG(100, 100));
        PostMessage(AParent.Handle, WM_LBUTTONDOWN, 0, MAKELONG(100, 100));
        SendMessage(AParent.Handle, BM_CLICK, 0, MAKELONG(100, 100));
        PostMessage(AParent.Handle, BM_CLICK, 0, MAKELONG(100, 100));
        SendMessage(AParent.Handle, WM_LBUTTONUP, 0, MAKELONG(100, 100));
        PostMessage(AParent.Handle, WM_LBUTTONUP, 0, MAKELONG(100, 100));
    End;

Begin
    If (Screen.Cursor = crDrag) Then
        Screen.Cursor := crDefault;

  //Make sure we have a component we want to insert
    If Trim(ComponentPalette.SelectedComponent) = '' Then
        Exit;

  //Make sure that the type of control is valid
    AControlClass := TControlClass(GetClass(ComponentPalette.SelectedComponent));
    If AControlClass = Nil Then
        Exit;

  //Do some sanity checks
    If TFrmNewForm(ELDesigner1.DesignControl).Wx_DesignerType = dtWxFrame Then
    Begin
        If strContainsU(ComponentPalette.SelectedComponent, 'TWxStatusBar') And
            (GetAvailableControlCount(ELDesigner1.DesignControl, 'TWxStatusBar') > 0) Then
        Begin
            ShowErrorAndReset('Each frame can only have one statusbar.');
            Exit;
        End;

        If strContainsU(ComponentPalette.SelectedComponent, 'TWxMenuBar') And
            (GetAvailableControlCount(ELDesigner1.DesignControl, 'TWxMenuBar') > 0) Then
        Begin
            ShowErrorAndReset('Each frame can only have one menubar.');
            Exit;
        End;

        If StrContainsU(ComponentPalette.SelectedComponent, 'TWxStdDialogButtonSizer') Then
        Begin
            ShowErrorAndReset('wxStdDialogButtonSizers can only be inserted onto a wxDialog.');
            Exit;
        End;

    //TODO: Guru: Is this dead code? Why are you checking for a wxDialog when your IF states that
    //            this part will be executed when it's a wxFrame?
        If TWinControl(AControlClass.NewInstance).GetInterface(IID_IWxToolBarInsertableInterface, tlbrInterface) Then
        Begin
            If Not (StrContainsU(AParent.ClassName, 'TWxToolBar')) And
                Not (TWinControl(AControlClass.NewInstance).GetInterface(IID_IWxToolBarNonInsertableInterface, nontlbrInterface)) Then
            Begin
                ShowErrorAndReset('You cannot insert Toolbar control in Dialog. Use Toolbar only in wxFrame.');
                Exit;
            End;
        End
        Else
        Begin
            If (Not strContainsU(AParent.ClassName, 'TFrmNewForm')) And
                (AParent.Parent <> Nil) And (StrContainsU(AParent.Parent.ClassName, 'TWxToolBar')) Then
            Begin
                ShowErrorAndReset('You cannot insert this control in a toolbar');
                Exit;
            End;

            If StrContainsU(AParent.ClassName, 'TWxToolBar') Then
            Begin
                ShowErrorAndReset('You cannot insert this control in a toolbar');
                Exit;
            End;

            If StrContainsU(AParent.ClassName, 'TWxAuiToolBar') Then
            Begin
                PreviousComponent := TWinControl(ELDesigner1.SelectedControls[0].GetParentComponent()).Parent;
                Exit;
            End;

        End;

    End
    Else
    Begin
        If TWinControl(AControlClass.NewInstance).GetInterface(IID_IWxDialogNonInsertableInterface, dlgInterface) Then
        Begin
            ShowErrorAndReset('This control cannot be used in dialogs.');
            Exit;
        End;

        If StrContainsU(ComponentPalette.SelectedComponent, 'TWxStdDialogButtonSizer') Then
        Begin
            If Not isSizerAvailable(ELDesigner1.DesignControl) Then
            Begin
                ShowErrorAndReset('wxStdDialogButtonSizers need a parent sizer to attach to.'#13#10#13#10 +
                    'Insert a wxBoxSizer onto the wxDialog before inserting the wxStdDialogButtonSizer.');
                Exit;
            End;

            For I := 0 To ELDesigner1.DesignControl.ComponentCount - 1 Do
                If ELDesigner1.DesignControl.Components[i] Is TWxSizerPanel Then
                    AParent := ELDesigner1.DesignControl.Components[i] As TWinControl;
        End;

    End;

  //Malcolm
  // This is the testing for the new wxAui interface stuff
  //Only wxAuiEnabled components should be allowed to be dropped onto a form when a wxAuiManager is present
    If TWinControl(AControlClass.NewInstance).GetInterface(IID_IWxAuiNonInsertableInterface, dlgInterface) And
        (GetAvailableControlCount(ELDesigner1.DesignControl, 'TWxAuiManager') > 0)
        And (ELDesigner1.SelectedControls[0] Is TfrmNewForm) Then
    Begin
        ShowErrorAndReset('This control cannot be placed on a form where a wxAuiManager is present.'#13#10#13#10 +
            'Please use the wxAui version which contains wxAuiPaneInfo data.');
        Exit;
    End;

  //Only wxAuiEnabled components should be allowed to be dropped onto a form when a wxAuiManager is present
    If TWinControl(AControlClass.NewInstance).GetInterface(IID_IWxAuiPaneInfoInterface, dlgInterface) And
        (GetAvailableControlCount(ELDesigner1.DesignControl, 'TWxAuiManager') = 0) Then
    Begin
        ShowErrorAndReset('This control can only be placed onto a form where a wxAuiManager is present.'#13#10#13#10 +
            'Please place a wxAuiManager component on the form first.');
        Exit;
    End;

  // each frame/dialog can only have one wxAuiManager component
    If strContainsU(ComponentPalette.SelectedComponent, 'TWxAuiManager') And
        (GetAvailableControlCount(ELDesigner1.DesignControl, 'TWxAuiManager') > 0) Then
    Begin
        ShowErrorAndReset('Each frame or dialog can only have one Aui Manager.');
        Exit;
    End;

  // the user should add the wxAuiManager first before any other wxAuiComponent
    If strContainsU(ComponentPalette.SelectedComponent, 'TWxAuiBar') And
        (GetAvailableControlCount(ELDesigner1.DesignControl, 'TWxAuiManager') = 0) Then
    Begin
        ShowErrorAndReset('This control can only be placed onto a form where a wxAuiManager is present.'#13#10#13#10 +
            'Please place a wxAuiManager component on the form first.');
        Exit;
    End;

    If strContainsU(ComponentPalette.SelectedComponent, 'TWxAuiBar') And
        (GetAvailableControlCount(ELDesigner1.DesignControl, 'TWxAuiBar') > 3) Then
    Begin
        ShowErrorAndReset('Each frame or dialog can only contain four AuiToolBar designer items.');
        Exit;
    End;

    If strContainsU(ComponentPalette.SelectedComponent, 'TWxAuiToolBar') And
        ((AParent.Parent = Nil) Or Not (StrContainsU(AParent.ClassName, 'TWxAuiBar'))) Then
    Begin
        ShowErrorAndReset('This component must be dropped onto a wxAuibar design aid.');
        Exit;
    End;

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

    PreviousComponent := Nil;
    If TWinControl(AControlClass.NewInstance) Is TWxNoteBookPage Then
    Begin
        If ELDesigner1.SelectedControls.count = 0 Then
        Begin
            ShowErrorAndReset('Please select a Book Container and drop the page.');
            Exit;
        End;

        PreviousComponent := ELDesigner1.SelectedControls[0];
        If (ELDesigner1.SelectedControls[0] Is TWxNoteBookPage) Then
        Begin
            PreviousComponent := ELDesigner1.SelectedControls[0].Parent;
            If (PreviousComponent Is TWxNotebook) Then
                Exit
            Else
            Begin
                If (PreviousComponent Is TPageControl) Then
                Begin
                    PreviousComponent := PreviousComponent.GetParentComponent;
                    Exit;
                End
                Else
                Begin
                    PreviousComponent := PreviousComponent.GetParentComponent; // this should be enough to do the page dropping
                    ShowMessage('non notebook');

                    Exit;
                End;
            End;
        End;

        If Not (ELDesigner1.SelectedControls[0] Is TWxChoiceBook) And
            Not (ELDesigner1.SelectedControls[0] Is TWxNoteBook) And
            Not (ELDesigner1.SelectedControls[0] Is TWxListBook) And
            Not (ELDesigner1.SelectedControls[0] Is TWxToolBook) And
            Not (ELDesigner1.SelectedControls[0] Is TWxTreeBook) And
            Not (ELDesigner1.SelectedControls[0] Is TPageControl) Then
        Begin
            ShowErrorAndReset('Please select a Book Container and drop the page.');
            Exit;
        End;
    End;

    If TWinControl(AControlClass.NewInstance) Is TWxAuiNoteBookPage Then
    Begin
        If ELDesigner1.SelectedControls.count = 0 Then
        Begin
            ShowErrorAndReset('Please select a wxAuiNoteBook Container and drop the page.');
            Exit;
        End;

        PreviousComponent := ELDesigner1.SelectedControls[0];
        If (ELDesigner1.SelectedControls[0] Is TWxAuiNoteBookPage) Then
        Begin
            PreviousComponent := ELDesigner1.SelectedControls[0].Parent;
            If (PreviousComponent Is TWxAuiNotebook) Then
                Exit
            Else
            Begin
                ShowMessage('Please select a wxAuiNoteBook Container and drop the page.');
                Exit;
            End;
        End;
    End;

  /// Fix for Bug Report #1060562
    If TWinControl(AControlClass.NewInstance) Is TWxToolButton Then
    Begin
        If ELDesigner1.SelectedControls.count = 0 Then
        Begin
            ShowErrorAndReset('Please select either a Toolbar or AuiToolbar before dropping this control.');
            Exit;
        End;

        PreviousComponent := ELDesigner1.SelectedControls[0];
        If (ELDesigner1.SelectedControls[0] Is TWxToolBar) Then
        Begin
            PreviousComponent := ELDesigner1.SelectedControls[0].Parent;
            Exit;
        End;

{mn
    if (ELDesigner1.SelectedControls[0] is TWxAuiToolBar) then
    begin
      PreviousComponent := TWinControl(ELDesigner1.SelectedControls[0].GetParentComponent()).Parent;
      Exit;
    end;
}
        If (Not (ELDesigner1.SelectedControls[0] Is TWxToolBar)) And (Not (ELDesigner1.SelectedControls[0] Is TWxAuiToolBar)) Then
        Begin
            ShowErrorAndReset('Please select either a Toolbar or AuiToolbar before dropping this control.');
            Exit;
        End;
    End;

    If TControl(AControlClass.NewInstance) Is TWxSeparator Then
    Begin
        If ELDesigner1.SelectedControls.count = 0 Then
        Begin
            ShowErrorAndReset('Please select either a Toolbar or AuiToolbar before dropping this control.');
            Exit;
        End;

        PreviousComponent := ELDesigner1.SelectedControls[0];
        If (ELDesigner1.SelectedControls[0] Is TWxToolBar) Then
        Begin
            PreviousComponent := ELDesigner1.SelectedControls[0].Parent;
            Exit;
        End;

        If (ELDesigner1.SelectedControls[0] Is TWxAuiToolBar) Then
        Begin
            PreviousComponent := TWinControl(ELDesigner1.SelectedControls[0].GetParentComponent()).Parent;
            Exit;
        End;

        If (Not (ELDesigner1.SelectedControls[0] Is TWxToolBar)) And (Not (ELDesigner1.SelectedControls[0] Is TWxAuiToolBar)) Then
        Begin
            ShowErrorAndReset('Please select either a Toolbar or AuiToolbar before dropping this control.');
            Exit;
        End;
    End;

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
End;

Procedure TWXDsgn.ELDesigner1KeyDown(Sender: TObject; Var Key: Word;
    Shift: TShiftState);
Begin

    If Shift = [ssCtrl] Then
    Begin
        If (Key = Ord('C')) Then
            ELDesigner1.Copy;
        If (Key = Ord('X')) Then
            ELDesigner1.Cut;
        If (Key = Ord('V')) Then
            ELDesigner1.Paste;
    End;

  // Need to hijack delete function in designer form
  // so that the proper code cleanup is done
    If (Key = VK_DELETE) Then
    Begin
        actDesignerDeleteExecute(Nil);
    End;

End;

Procedure TWXDsgn.ELDesigner1Modified(Sender: TObject);
Begin
    If Not DisablePropertyBuilding Then
        ELDesigner1ChangeSelection(Sender);
    JvInspProperties.RefreshValues;
    UpdateDesignerData(main.GetActiveEditorName);
End;

Procedure TWXDsgn.BuildProperties(Comp: TControl; boolForce: Boolean);
Var
    strValue: String;
    strSelName, strCompName: String;
Begin
    If Not boolForce Then
    Begin
        If DisablePropertyBuilding = True Then
            Exit;
        If Assigned(SelectedComponent) Then
            strSelName := SelectedComponent.Name;
        If Assigned(Comp) Then
            strCompName := Comp.Name;

        PreviousStringValue := '';
        If AnsiSameText(strSelName, strCompName) Then
        Begin
            SelectedComponent := Comp;
            Exit;
        End;

        If FirstComponentBeingDeleted = Comp.Name Then
            Exit;
    End;

    If Comp = Nil Then
        Exit;

    SelectedComponent := Comp;

    If JvInspProperties.Root <> Nil Then
        If JvInspProperties.Root.Data <> Nil Then
{$IFNDEF PRIVATE_BUILD}
            Try
{$ENDIF}
                strValue := TWinControl(TJvInspectorPropData(JvInspProperties.Root.Data).Instance).Name;
{$IFNDEF PRIVATE_BUILD}
            Except
                Exit;
            End;
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
End;

Procedure TWXDsgn.BuildComponentList(Designer: TfrmNewForm);
Var
    i: Integer;
    intControlMaxValue: Integer;
    wxcompInterface: IWxComponentInterface;
Begin
    intControlMaxValue := -1;
    cbxControlsx.Clear;
    cbxControlsx.Items.BeginUpdate;

    cbxControlsx.AddItem(Designer.Wx_Name + ':' + Trim(Designer.Wx_Class),
        Designer);
    For I := 0 To Designer.ComponentCount - 1 Do // Iterate
    Begin
        If Designer.Components[i].GetInterface(IID_IWxComponentInterface,
            wxcompInterface) Then
        Begin
            cbxControlsx.AddItem(Designer.Components[i].Name + ':' +
                wxcompInterface.GetWxClassName, Designer.Components[i]);
            If wxcompInterface.GetIDValue > intControlMaxValue Then
            Begin
                intControlMaxValue := wxcompInterface.GetIDValue;
            End;
        End;
    End; // for

  // Correct ID numbers > 32768
    If (intControlMaxValue > 32768) Then
    Begin
        intControlMaxValue := 1001;
        For I := 0 To Designer.ComponentCount - 1 Do // Iterate
            If Designer.Components[i].GetInterface(IID_IWxComponentInterface,
                wxcompInterface) Then
            Begin
                wxcompInterface.SetIDValue(intControlMaxValue);
                intControlMaxValue := intControlMaxValue + 1;
            End;

    End;

    cbxControlsx.Items.EndUpdate;

    If intControlMaxValue = -1 Then
        intControlMaxValue := 1000;

    intControlCount := intControlMaxValue;

    If cbxControlsx.Items.Count > 0 Then
        cbxControlsx.ItemIndex := 0;

End;

Procedure TWXDsgn.JvInspPropertiesAfterItemCreate(Sender: TObject; Item: TJvCustomInspectorItem);
Var
    I: Integer;
    StrCompName, StrCompCaption: String;
    boolOk: Boolean;
    strLst: TStringList;
    strTemp: String;
    wxcompInterface: IWxComponentInterface;
Begin
    boolOk := False;
    If SelectedComponent = Nil Then
        Exit;

    If Not Assigned(Item) Then
        Exit;

    If SelectedComponent <> Nil Then
    Begin
        If IsValidClass(SelectedComponent) Then
        Begin
            strTemp := SelectedComponent.ClassName;
            If SelectedComponent.GetInterface(IID_IWxComponentInterface, wxcompInterface) Then
                strLst := wxcompInterface.GetPropertyList
            Else
                strLst := Nil;

{$IFNDEF PRIVATE_BUILD}
            Try
{$ENDIF}
                If strLst <> Nil Then
                Begin
                    If strLst.Count > 0 Then
                        strLst[0] := strLst[0];
                End
                Else
                    Exit;
{$IFNDEF PRIVATE_BUILD}
            Except
                Exit;
            End;
{$ENDIF}

      //Populate the std wx Ids for the ID_Name selection
            If AnsiSameText('Wx_IDName', trim(Item.DisplayName)) Then
            Begin
                Item.Flags := Item.Flags + [iifValueList, iifAllowNonListValues];
                Item.OnGetValueList := OnStdWxIDListPopup;
            End;

            For I := 0 To strLst.Count - 1 Do // Iterate
            Begin
                StrCompName := trim(ExtractComponentPropertyName(strLst[i]));
                StrCompCaption := trim(ExtractComponentPropertyCaption(strLst[i]));
                If AnsiSameText(StrCompName, trim(Item.DisplayName)) Then
                Begin
                    If AnsiSameText(Item.Data.TypeInfo.Name, 'TCaption') Then
                        Item.Flags := Item.Flags - [iifMultiLine];
                    If AnsiSameText(Item.Data.TypeInfo.Name, 'TPicture') Then
                        Item.Flags := Item.Flags + [iifEditButton];
                    If AnsiSameText(Item.Data.TypeInfo.Name, 'TListItems') Then
                        Item.Flags := Item.Flags + [iifEditButton];
                    If AnsiSameText(Item.Data.TypeInfo.Name, 'TTreeNodes') Then
                        Item.Flags := Item.Flags + [iifEditButton];

                    Item.DisplayName := StrCompCaption;
                    boolOk := True;
                    Break;
                End;
            End; // for
        End;
    End;
    Item.Hidden := Not boolOk;
End;

Function TWXDsgn.GetCurrentFileName: String;
Begin
    Result := main.GetActiveEditorName;
End;

Function TWXDsgn.GetCurrentClassName: String;
Var
    editorName: String;
Begin
    editorName := main.GetActiveEditorName;
    Result := trim((editors[editorName] As TWXEditor).GetDesigner().Wx_Name);
End;

Procedure TWXDsgn.JvInspPropertiesDataValueChanged(Sender: TObject;
    Data: TJvCustomInspectorData);
Var
    idxName: Integer;
    Comp: TComponent;
    wxcompInterface: IWxComponentInterface;
    strValue, strDirName, editorName: String;
    cppStrLst, hppStrLst: TStringList;
Begin
    If JvInspProperties.Selected <> Nil Then
    Begin

        If assigned(JvInspProperties.Selected.Data) Then
        Begin
            strValue := JvInspProperties.Selected.Data.TypeInfo.Name;
            If (UpperCase(strValue) = UpperCase('TPicture')) Or
                (UpperCase(strvalue) = UpperCase('TComponentName')) Then
            Begin
                strValue := TJvInspectorPropData(JvInspProperties.Selected.Data).Instance.ClassName;
                If main.IsEditorAssigned Then
                Begin
                    editorName := main.GetActiveEditorName;
                    If ((UpperCase(SelectedComponent.ClassName) = UpperCase('TFrmNewForm'))
                        And (Not TFrmNewForm(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).KeepFormat)) Then
                        GenerateXPMDirectly(TFrmNewForm(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Wx_ICON.Bitmap, (editors[editorName] As TWXEditor).GetDesigner.Wx_Name, 'Self', editorName);

                    If ((UpperCase(SelectedComponent.ClassName) = UpperCase('TWxStaticBitmap'))
                        And (Not TWxStaticBitmap(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).KeepFormat)) Then
                        GenerateXPMDirectly(TWxStaticBitmap(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Picture.Bitmap, SelectedComponent.Name, (editors[editorName] As TWXEditor).GetDesigner.Wx_Name, editorName);

                    If ((UpperCase(SelectedComponent.ClassName) = UpperCase('TWxBitmapButton'))
                        And (Not TWxBitmapButton(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).KeepFormat)) Then
                        GenerateXPMDirectly(TWxBitmapButton(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Wx_Bitmap.Bitmap, SelectedComponent.Name, (editors[editorName] As TWXEditor).GetDesigner.Wx_Name, editorName);

                    If ((UpperCase(SelectedComponent.ClassName) = UpperCase('TWxCustomButton'))
                        And (Not TWxCustomButton(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).KeepFormat)) Then
                        GenerateXPMDirectly(TWxCustomButton(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Wx_Bitmap.Bitmap, SelectedComponent.Name, (editors[editorName] As TWXEditor).GetDesigner.Wx_Name, editorName);

                    If ((UpperCase(SelectedComponent.ClassName) = UpperCase('TWxToolButton'))
                        And (Not TWxToolButton(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).KeepFormat)) Then
                        GenerateXPMDirectly(TWxToolButton(TJvInspectorPropData(JvInspProperties.Selected.Data).Instance).Wx_Bitmap.Bitmap, SelectedComponent.Name, (editors[editorName] As TWXEditor).GetDesigner.Wx_Name, editorName);

                End;
            End;
        End;

        If UpperCase(Trim(JvInspProperties.Selected.DisplayName)) = UpperCase('NAME') Then
        Begin
            If Not main.IsClassBrowserEnabled Then
                Exit;

            Comp := Self.SelectedComponent;
            idxName := cbxControlsx.Items.IndexOfObject(Comp);
            If idxName <> -1 Then
            Begin
                If Comp Is TfrmNewForm Then
                Begin
                    If Comp.GetInterface(IID_IWxComponentInterface, wxcompInterface) Then
                    Begin

                        If AnsiSameText('ID_' + PreviousComponentName, wxcompInterface.GetIDName()) Then
                        Begin
                            wxcompInterface.SetIDName(UpperCase('ID_' + Comp.Name));
                        End;

                        cbxControlsx.Items[idxName] := TfrmNewForm(Comp).Wx_Name + ':' + wxcompInterface.GetWxClassName;
                        cbxControlsx.ItemIndex := idxName;
            //Update the ClassName using PreviousStringValue
                        If main.IsEditorAssigned Then
                        Begin
                            editorName := main.GetActiveEditorName;
                            hppStrLst := TStringList.Create;
                            cppStrLst := TStringList.Create;
                            hppStrLst.Duplicates := dupIgnore;
                            cppStrLst.Duplicates := dupIgnore;
                            Try
                                main.GetClassNameLocationsInEditorFiles(hppStrLst, cppStrLst, ChangeFileExt(editorName, CPP_EXT), PreviousStringValue, TfrmNewForm(Comp).Wx_Name);
                                ReplaceClassNameInEditor(hppStrLst, main.GetEditorText(ChangeFileExt(editorName, H_EXT)), PreviousStringValue, TfrmNewForm(Comp).Wx_Name);
                                ReplaceClassNameInEditor(cppStrLst, main.GetEditorText(ChangeFileExt(editorName, CPP_EXT)), PreviousStringValue, TfrmNewForm(Comp).Wx_Name);
                                If ((hppStrLst.count = 0) And (cppStrLst.count = 0)) Then
                                    MessageDlg('Unable to get Class Information. Please rename the class name in H/CPP files manually. If you dont rename it them, then the Designer wont work. ', mtWarning, [mbOK], 0)
                                Else
                                Begin
                                    MessageDlg('Contructor Function(in Header) or Sometimes all the Functions(in Source)  might not be renamed. ' + #13 + #10 + '' + #13 + #10 + 'Please rename them manually.' + #13 + #10 + '' + #13 + #10 + 'We hope to fix this bug asap.' + #13 + #10 + 'Sorry for the trouble.', mtInformation, [mbOK], 0);
                                    strDirName := IncludeTrailingPathDelimiter(ExtractFileDir(editorName));
                                    RenameFile(strDirName + '\' + PreviousStringValue + '_XPM.xpm', strDirName + '\' + TfrmNewForm(Comp).Wx_Name + '_XPM.xpm');
                                    Designerfrm.GenerateXPM((editors[editorName] As TWXEditor).GetDesigner, editorName, True);
                                End;
                            Finally
                                hppStrLst.Destroy;
                                cppStrLst.Destroy;
                            End;
                        End;
                    End
                    Else
                    Begin
                        MessageDlg('Some problem !!!', mtWarning, [mbOK], 0);
                    End;
                End
                Else
                Begin
                    If Comp.GetInterface(IID_IWxComponentInterface, wxcompInterface) Then
                    Begin
                        If AnsiSameText('ID_' + PreviousComponentName, wxcompInterface.GetIDName()) Then
                        Begin
                            wxcompInterface.SetIDName(UpperCase('ID_' + Comp.Name));
                        End;
                        cbxControlsx.Items[idxName] := Comp.Name + ':' + wxcompInterface.GetWxClassName;
                        cbxControlsx.ItemIndex := idxName;
                    End;
                End;
            End;
        End;
        UpdateDefaultFormContent;
    End;
End;

Procedure TWXDsgn.JvInspEventsAfterItemCreate(Sender: TObject;
    Item: TJvCustomInspectorItem);
Var
    I: Integer;
    StrCompName, StrCompCaption: String;
    boolOk: Boolean;
    strLst: TStringList;
    strTemp: String;
    wxcompInterface: IWxComponentInterface;
Begin
    boolOk := False;
    Item.Hidden := True;

    If SelectedComponent <> Nil Then
    Begin
        If IsValidClass(SelectedComponent) Then
        Begin
            strTemp := SelectedComponent.ClassName;
            If SelectedComponent.GetInterface(IID_IWxComponentInterface,
                wxcompInterface) Then
                strLst := wxcompInterface.GetEventList
            Else
                strLst := Nil;

            If strLst = Nil Then
                exit;
            Try
                If strLst.Count > 0 Then
                    strLst[0] := strLst[0];
            Except
                Exit;
            End;

            For I := 0 To strLst.Count - 1 Do // Iterate
            Begin
                StrCompName := trim(ExtractComponentPropertyName(strLst[i]));
                StrCompCaption := trim(ExtractComponentPropertyCaption(strLst[i]));
                If AnsiSameText(StrCompName, trim(Item.DisplayName)) Then
                Begin
                    Item.DisplayName := StrCompCaption;
                    Item.Flags := Item.Flags + [iifValueList, iifAllowNonListValues];
                    Item.OnGetValueList := OnEventPopup;
                    boolOk := True;
                    break;
                End;
            End; // for
        End;

    End;

  //  if Item is TJvInspectorBooleanItem then
  //    TJvInspectorBooleanItem(Item).ShowAsCheckbox := True;

    Item.Hidden := Not boolOk;
  //Item.Hidden:= false;
End;

Function TWXDsgn.IsCurrentPageDesigner: Boolean;
Var
    wx: TfrmNewForm;
    editorName: String;
Begin
    Result := False;

    editorName := main.GetActiveEditorName;

    If Not main.IsEditorAssigned(editorName) Then
        Exit;

    If isForm(editorName) Then
        wx := (editors[editorName] As TWXEditor).GetDesigner()
    Else
        Exit;

    If Not Assigned(wx) Then
        Result := False
    Else
        Result := True;
End;

Function TWXDsgn.IsDelphiPlugin: Boolean;
Begin
    Result := True;
End;

Function TWXDsgn.LocateFunction(strFunctionName: String): Boolean;
Begin
    Result := False;
End;

Function TWXDsgn.GetCurrentDesignerForm: TfrmNewForm;
Var
    editorName: String;
Begin
    Result := Nil;

    If Not main.IsEditorAssigned Then
        Exit;

    editorName := main.GetActiveEditorName;
    If isForm(editorName) Then
        Result := (editors[editorName] As TWXEditor).GetDesigner();
End;

Procedure TWXDsgn.JvInspEventsDataValueChanged(Sender: TObject;
    Data: TJvCustomInspectorData);       // EAB *** Look here for after doubleclick designer components event and event inspector
Var
    propertyName, wxClassName, propDisplayName, strNewValue, str, ErrorString: String;
    componentInstance: TComponent;
    boolIsFilesDirty: Boolean;
    editorName: String;
    strDisplayName: String;
    compSelectedOne: TComponent;
    switchEditor: Boolean;

    Procedure SetPropertyValue(Comp: TComponent; strPropName, strPropValue: String);
    Var
        PropInfo: PPropInfo;
    Begin
    { Get info record for Enabled property }
        PropInfo := GetPropInfo(Comp.ClassInfo, strPropName);
    { If property exists, set value to False }
        If Assigned(PropInfo) Then
            SetStrProp(Comp, PropInfo, strPropValue);
    End;
Begin
    switchEditor := False;
    Try
    //Do some sanity checks
        If (JvInspEvents.Selected = Nil) Or (Not JvInspEvents.Selected.Visible) Then
            Exit;

        editorName := main.GetActiveEditorName;
        If Not main.IsEditorAssigned(editorName) Or Not IsForm(editorName) Then
            Exit;

    //Then get the value as a string
        strNewValue := Data.AsString;

    //See we have to do with our new value
        If strNewValue = '<Add New Function>' Then
        Begin
            If Not main.IsClassBrowserEnabled Then
            Begin
                MessageDlg('The Class Browser is not enabled; wxDev-C++ will be unable to' +
                    'create an event handler for you.'#10#10'Please see Help for instructions ' +
                    'on enabling the Class Browser', mtWarning, [mbOK], ownerForm.Handle);
                JvInspEvents.OnDataValueChanged := Nil;
                Data.AsString := '';
                JvInspEvents.OnDataValueChanged := JvInspEventsDataValueChanged;
                Exit;
            End;

            boolIsFilesDirty := False;
            If main.IsFileOpenedInEditor(ChangeFileExt(editorName, H_EXT)) Then
                boolIsFilesDirty := main.IsEditorModified(ChangeFileExt(editorName, H_EXT));

            If Not boolIsFilesDirty Then
                If main.IsFileOpenedInEditor(ChangeFileExt(editorName, CPP_EXT)) Then
                    boolIsFilesDirty := main.IsEditorModified(ChangeFileExt(editorName, CPP_EXT));

            If boolIsFilesDirty Then
            Begin
                If main.IsFileOpenedInEditor(ChangeFileExt(editorName, H_EXT)) Then
          //This wont open a new editor window
                    main.SaveFileFromPlugin(ChangeFileExt(editorName, H_EXT), True);

                If main.IsFileOpenedInEditor(ChangeFileExt(editorName, CPP_EXT)) Then
          //This wont open a new editor window
                    main.SaveFileFromPlugin(ChangeFileExt(editorName, CPP_EXT), True);
            End;

      //TODO: Guru: add code to make sure the files are saved properly
            If SelectedComponent <> Nil Then
            Begin
                str := JvInspEvents.Selected.DisplayName;

                If SelectedComponent Is TfrmNewForm Then
                    str := TfrmNewForm(SelectedComponent).Wx_Name + Copy(str, 3, Length(str))
                Else
                    str := SelectedComponent.Name + Copy(str, 3, Length(str));
                JvInspEvents.OnDataValueChanged := Nil;
                Data.AsString := str;
                JvInspEvents.OnDataValueChanged := JvInspEventsDataValueChanged;
                str := Trim(str);

                componentInstance := SelectedComponent;
                propertyName := Data.Name;
                wxClassName := Trim((editors[editorName] As TWXEditor).getDesigner().Wx_Name);
                propDisplayName := JvInspEvents.Selected.DisplayName;
                If CreateFunctionInEditor(wxClassName, SelectedComponent, str, propDisplayName, ErrorString) Then
                Begin
                    SetPropertyValue(componentInstance, propertyName, str);

          // EAB: commented ugly ass problematic hack and replaced with corresponding code. Still ugly, but not as problematic :)

                    JvInspEvents.OnDataValueChanged := Nil;
                    Data.AsString := str;
                    JvInspEvents.OnDataValueChanged := JvInspEventsDataValueChanged;

          // Now trigger a Goto function to display the new C++ code
          // BEGIN Goto Function trigger
                    strGlobalCurrentFunction := str; // Pass the name of the new function
                    JvInspEvents.OnDataValueChanged := Nil;
                    Data.AsString := '<Goto Function>';
                    JvInspEvents.Root.DoneEdit(True);
                    JvInspEvents.OnDataValueChanged := JvInspEventsDataValueChanged;
                    JvInspEventsDataValueChanged(Nil, Data);

          // END Goto Function trigger
                End
                Else
                Begin
                    Data.AsString := '';
                    If ErrorString = '' Then
                        MessageDlg('Unable to add function', mtError, [mbOK], 0)
                    Else
                        MessageDlg(ErrorString, mtError, [mbOK], 0);
                End;
            End;
        End
        Else
        If strNewValue = '<Goto Function>' Then
        Begin
      //Reset the value, we won't need the <Goto> value anymore
            Data.AsString := strGlobalCurrentFunction;
            strGlobalCurrentFunction := '';

            If Not main.IsClassBrowserEnabled Then
            Begin
                MessageDlg('The Class Browser has been disabled; All event handling ' +
                    'automation code will not work.'#10#10'See Help for instructions on ' +
                    'enabling the Class Browser.', mtError, [mbOK], 0);
                Exit;
            End;

            If main.IsFileOpenedInEditor(ChangeFileExt(editorName, H_EXT)) Then
                main.SaveFileFromPlugin(ChangeFileExt(editorName, H_EXT), True);

            If main.IsFileOpenedInEditor(ChangeFileExt(editorName, CPP_EXT)) Then
                main.SaveFileFromPlugin(ChangeFileExt(editorName, CPP_EXT), True);

            If SelectedComponent <> Nil Then
            Begin
                str := trim(Data.AsString);
                strDisplayName := JvInspEvents.Selected.DisplayName;
                compSelectedOne := SelectedComponent;
                LocateFunctionInEditor(Data, Trim((editors[editorName] As TWXEditor).getDesigner().Wx_Name), compSelectedOne,
                    str, strDisplayName);

                switchEditor := True;

                If (strNewValue = '<Goto Function>') And ((editors[editorName] As TWXEditor).getDesigner().Floating) Then
                    main.SendToFront;
            End;
        End
        Else
        If strNewValue = '<Remove Function>' Then
            Data.AsString := '';

        JvInspEvents.Root.DoneEdit(True);
        UpdateDefaultFormContent;

        If switchEditor Then
        Begin
            cleanUpJvInspEvents := True;
            main.SetPageControlActivePageEditor(ChangeFileExt(editorName, CPP_EXT));
            JvInspProperties.Root.Visible := False;
            JvInspEvents.Root.Visible := False;

            pendingEditorSwitch := True;
            JvInspEvents.OnMouseMove := JvInspEventsMouseMove;
            JvInspEvents.OnMouseUp := JvInspEventsMouseUp;
            JvInspEvents.OnEditorKeyDown := JvInspEventsKeyDown;

        End;

    Except
        on E: Exception Do
            MessageBox(ownerForm.Handle, Pchar(E.Message), Pchar(Application.Title), MB_ICONERROR Or MB_OK Or MB_TASKMODAL);
    End;
End;

Procedure TWXDsgn.JvInspEventsMouseMove(Sender: TObject; Shift: TShiftState; X: Integer; Y: Integer);
Begin
    If pendingEditorSwitch Then
    Begin
        JvInspEvents.OnMouseMove := Nil;
        JvInspEvents.OnMouseUp := Nil;
        JvInspEvents.OnEditorKeyDown := Nil;
        pendingEditorSwitch := False;
        main.forceEditorFocus;
    End;
End;

Procedure TWXDsgn.JvInspEventsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
Begin
    If pendingEditorSwitch Then
    Begin
        JvInspEvents.OnMouseMove := Nil;
        JvInspEvents.OnMouseUp := Nil;
        JvInspEvents.OnEditorKeyDown := Nil;
        pendingEditorSwitch := False;
        main.forceEditorFocus;
    End;
End;

Procedure TWXDsgn.JvInspEventsKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
    If pendingEditorSwitch Then
    Begin
        JvInspEvents.OnMouseMove := Nil;
        JvInspEvents.OnMouseUp := Nil;
        JvInspEvents.OnEditorKeyDown := Nil;
        pendingEditorSwitch := False;
        main.forceEditorFocus;
        Key := 0;
    End;
End;

Procedure TWXDsgn.JvInspEventsItemValueChanged(Sender: TObject;
    Item: TJvCustomInspectorItem);
Begin
    If JvInspEvents.Selected = Nil Then
        Exit;

    If JvInspEvents.Selected.Visible = False Then
        Exit;
End;

Procedure TWXDsgn.OnStdWxIDListPopup(Item: TJvCustomInspectorItem; Value: TStrings);
Begin
    Value.Clear;
    Value.Assign(strStdwxIDList);
End;

Procedure TWXDsgn.OnEventPopup(Item: TJvCustomInspectorItem; Value: TStrings);
Var
    boolNoFunction: Boolean;
    strPrevvalue: String;
    strClassesLst: TStringList;
    idx: Integer;
Begin
    strGlobalCurrentFunction := '';
    If Not isCurrentPageDesigner Then
        Exit;

    strPrevvalue := Item.Data.AsString;
    If Trim(strPrevvalue) = '' Then
        boolNoFunction := True
    Else
        boolNoFunction := False;

    Value.Clear;
    If boolNoFunction Then
    Begin
        Value.Add('<Add New Function>');
        strClassesLst := TStringList.Create;
        Try
            strClassesLst.Sorted := True;
            If IsCurrentPageDesigner Then
                main.GetFunctionsFromSource(GetCurrentDesignerForm().Wx_Name, strClassesLst);
            Value.AddStrings(strClassesLst);
        Finally
            strClassesLst.Destroy;
        End;
    End;

    If Trim(strPrevvalue) <> '' Then
    Begin
    //Add other functions here...
        strClassesLst := TStringList.Create;
        Try
            strClassesLst.Sorted := True;
            If IsCurrentPageDesigner Then
                main.GetFunctionsFromSource(GetCurrentDesignerForm().Wx_Name, strClassesLst);
            Value.AddStrings(strClassesLst);
        Finally
            strClassesLst.Destroy;
        End;
    //if Function list is not available in CPPParser
        idx := Value.IndexOf(strPrevvalue);
        If idx = -1 Then
        Begin
            Value.Add(strPrevvalue);
            idx := Value.IndexOf(strPrevvalue);
        End;

        If idx <> -1 Then
        Begin
            Value.Insert(idx + 1, '<Goto Function>');
            strGlobalCurrentFunction := strPrevvalue;
        End;

        Value.Add('<Remove Function>');

        strPrevvalue := Item.Parent.ClassName;
        strPrevvalue := Item.Parent.ClassName;
    End;

End;

Procedure TWXDsgn.UpdateDesignerData(FileName: String);
Var
    STartTimeX: Longword;
    temp: String;

    Function GetElapsedTimeStr(StartTime: Longword): String;
    Begin
        Result := Format('%.3f seconds', [(GetTickCount - StartTime) / 1000]);
    End;
Begin
    If isForm(FileName) Then
    Begin
        StartTimeX := GetTickCount;
        main.EditorInsertDefaultText(FileName);
        temp := 'C++ Source Generation: ' + GetElapsedTimeStr(StartTimeX);
        main.UpdateEditor(ChangeFileExt(FileName, CPP_EXT), temp);
        StartTimeX := GetTickCount;
        main.UpdateEditor(ChangeFileExt(FileName, H_EXT), temp + ' / Header Declaration Generation = ' + GetElapsedTimeStr(StartTimeX));
    End;
    If ELDesigner1.GenerateXRC Then
        UpdateXRC(FileName);

End;

Function TWXDsgn.LocateFunctionInEditor(eventProperty: TJvCustomInspectorData; strClassName: String; SelComponent: TComponent; Var strFunctionName: String; strEventFullName: String): Boolean;
Var
    strOldFunctionName: String;
    strFname: String;
    intLineNum: Integer;
    stID: Integer;
    boolFound: Boolean;
    editorName: String;
    e_text: TSynEdit;
Begin
    Result := False;
    boolFound := False;
    intLineNum := 0;

    If Not main.IsEditorAssigned Then
        Exit;

    editorName := main.GetActiveEditorName;

    If Not isForm(editorName) Then
        Exit;

    StID := main.FindStatementID(strClassName, boolFound);

    If Not boolFound Then
        Exit;

    If main.isFunctionAvailableInEditor(StID, strOldFunctionName, intLineNum, strFname) Then
    Begin
        boolInspectorDataClear := False;
        editorName := strFname;
        main.OpenFile(editorName);
        If main.IsEditorAssigned(editorName) Then
        Begin
      //TODO: check for a valid line number
            e_text := main.GetEditorText(editorName);
            e_text.CaretX := 0;
            e_text.CaretY := intLineNum;
        End;
        boolInspectorDataClear := False;
    End;
End;

Function TWXDsgn.isCurrentFormFilesNeedToBeSaved: Boolean;
Var
    editorName: String;
Begin
    Result := False;

    editorName := main.GetActiveEditorName;
    If Not main.IsEditorAssigned(editorName) Then
        Exit;

    If Not isForm(editorName) Then
        Exit;

    If Not main.IsEditorAssigned(editorName) Then // <-- EAB: This shouldn't be executing...¿?
    Begin
        MessageDlg('Unable to Get the Designer Info.', mtError, [mbOK], 0);
        Exit;
    End;

    If Not main.IsEditorAssigned(ChangeFileExt(editorName, H_EXT)) Then
    Begin
        MessageDlg('Unable to Get Header File Editor Info.', mtError, [mbOK], 0);
        Exit;
    End;

    If Not main.IsEditorAssigned(ChangeFileExt(editorName, CPP_EXT)) Then
    Begin
        MessageDlg('Unable to Get Source File Editor Info.', mtError, [mbOK], 0);
        Exit;
    End;
    If ((main.IsEditorModified(editorName) = True) Or (main.IsEditorModified(ChangeFileExt(editorName, H_EXT)) = True) Or (main.IsEditorModified(ChangeFileExt(editorName, CPP_EXT)))) Then
        Result := True
    Else
        Result := False;

End;

Function TWXDsgn.saveCurrentFormFiles: Boolean;
Var
    editorName: String;
Begin
    Result := False;

    editorName := main.GetActiveEditorName;
    If Not main.IsEditorAssigned(editorName) Then
        Exit;

    If Not isForm(editorName) Then
        Exit;

    Result := True;
    main.SaveFileFromPlugin(editorName, True);

    If main.IsFileOpenedInEditor(ChangeFileExt(editorName, H_EXT)) Then
    Begin
        main.SaveFileFromPlugin(ChangeFileExt(editorName, H_EXT), True);
    End;

    If main.IsFileOpenedInEditor(ChangeFileExt(editorName, CPP_EXT)) Then
    Begin
        main.SaveFileFromPlugin(ChangeFileExt(editorName, CPP_EXT), True);
    End;
End;

Function TWXDsgn.CreateFunctionInEditor(Var strFunctionName: String; strReturnType, strParameter: String;
    Var ErrorString: String; strClassName: String): Boolean;
Var
    intFunctionCounter: Integer;
    strOldFunctionName: String;
    Line: Integer;
    AddScopeStr: Boolean;
    VarType: String;
    VarArguments: String;
    StID: Integer;
    boolFound: Boolean;
    editorName: String;
    CppEditor, Hppeditor: TSynEdit;
Begin
    Result := False;
    boolFound := False;
    AddScopeStr := False;
    editorName := main.GetActiveEditorName;
    If Not main.IsEditorAssigned(editorName) Or Not isForm(editorName) Then
        Exit;

  //Give us a class name if none is specified
    If strClassName = '' Then
        strClassName := trim((editors[editorName] As TWXEditor).GetDesigner.Wx_Name);

    StID := main.FindStatementID(strClassName, boolFound);

    If Not boolFound Then
        Exit;

  //Come up with an unused function name
    intFunctionCounter := 0;
    strOldFunctionName := strFunctionName;
    While main.isFunctionAvailable(StID, strFunctionName) Do
    Begin
        strFunctionName := strOldFunctionName + IntToStr(intFunctionCounter);
        Inc(intFunctionCounter);
    End;

  //Temp Settings Start
    VarType := strReturnType;
    VarArguments := strParameter;

    If trim(VarType) = '' Then
        VarType := 'void';

    If trim(VarArguments) = '' Then
        VarArguments := 'void';
  //Temp Settings End

    Line := main.GetSuggestedInsertionLine(StID, AddScopeStr);
    If Line = -1 Then
        Exit;

    Hppeditor := main.GetEditorText(ChangeFileExt(editorName, H_EXT));
    CppEditor := main.GetEditorText(ChangeFileExt(editorName, CPP_EXT));

    If Assigned(HppEditor) Then
    Begin
        If AnsiStartsText('////GUI Control Declaration End', Trim(Hppeditor.Lines[Line])) Then
            Line := Line + 1;

        Hppeditor.Lines.Insert(Line, Format(#9#9'%s %s(%s);', [VarType, strFunctionName, VarArguments]));
        If AddScopeStr Then
            Hppeditor.Lines.Insert(Line, #9'public:');
        main.TouchEditor(ChangeFileExt(editorName, H_EXT));
    End;

    If Assigned(CppEditor) Then
    Begin
    // insert the implementation
        If Trim(CppEditor.Lines[CppEditor.Lines.Count - 1]) <> '' Then
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
    End;
End;

Function TWXDsgn.CreateFunctionInEditor(strClassName: String; SelComponent: TComponent;
    Var strFunctionName: String; strEventFullName: String;
    Var ErrorString: String): Boolean;
Var
    VarType, VarArguments, strEName: String;
    intfObj: IWxComponentInterface;
Begin
  //Assemble the function prototype
    VarType := 'void';
    VarArguments := '';

  //Parse the event string to get the parts of the declaration
    If SelComponent.GetInterface(IID_IWxComponentInterface, intfObj) Then
    Begin
        strEName := Trim(GetEventNameFromDisplayName(strEventFullName, intfObj.GetEventList));
        VarType := intfObj.GetTypeFromEventName(strEName);
        VarArguments := intfObj.GetParameterFromEventName(strEName);
    End;

  //If we have no return type assume it to be void
    If trim(VarType) = '' Then
        VarType := 'void';

  //Then call the actual function
    Result := CreateFunctionInEditor(strFunctionName, VarType, VarArguments, ErrorString, strClassName);
End;

Procedure TWXDsgn.UpdateDefaultFormContent;
Var
    editorName: String;
Begin
    editorName := main.GetActiveEditorName;

    If Not main.IsEditorAssigned(editorName) Then
        Exit;

    If Not isForm(editorName) Then
        Exit;

    UpdateDesignerData(editorName);
End;

Procedure TWXDsgn.cbxControlsxChange(Sender: TObject);
Var
    strCompName: String;
    compControl: TComponent;
    intColPos: Integer;

    Function GetComponentFromName(strCompName: String): TComponent;
    Var
        I: Integer;
        frmNewFormX: TfrmNewForm;
        editorName: String;
    Begin
        Result := Nil;

        editorName := main.GetActiveEditorName;
        frmNewFormX := (editors[editorName] As TWXEditor).GetDesigner();

        If Assigned(frmNewFormX) = False Then
            Exit;

        For I := 0 To frmNewFormX.ComponentCount - 1 Do // Iterate
        Begin
            If AnsiSameText(trim(frmNewFormX.Components[i].Name), trim(strCompName)) Then
            Begin
                Result := frmNewFormX.Components[i];
                exit;
            End;
        End;
    End;

Begin
    If cbxControlsx.ItemIndex = -1 Then
        exit;

    If Not isCurrentPageDesigner Then
        Exit;

    strCompName := trim(cbxControlsx.Items[cbxControlsx.ItemIndex]);
    intColPos := Pos(':', strCompName);
    If intColPos <> 0 Then
    Begin
        strCompName := Trim(Copy(strCompName, 0, intColPos - 1));
    End;

    compControl := GetComponentFromName(strCompName);
    If compControl <> Nil Then
    Begin
        ELDesigner1.SelectedControls.Clear;
        ELDesigner1.SelectedControls.Add(TWinControl(compControl));
        BuildProperties(TControl(compControl));
    End
    Else
    Begin
        ELDesigner1.SelectedControls.Clear;
        BuildProperties(TControl(GetCurrentDesignerForm()));
    End;

End;

Procedure TWXDsgn.actDesignerCopyExecute(Sender: TObject);
Begin
    If ELDesigner1.CanCopy Then
        ELDesigner1.Copy;
End;

Procedure TWXDsgn.actDesignerCutExecute(Sender: TObject);
Begin
    If IsFromScrollBarShowing Then
    Begin
        MessageDlg('The Designer Form is scrolled. ' + #13 + #10 + '' + #13 + #10 + 'Please resize the form to hide the scrollbar before deleting controls.', mtError, [mbOK], 0);
        exit;
    End;

    BuildProperties(ELDesigner1.DesignControl, True);
    DisablePropertyBuilding := True;
{$IFNDEF PRIVATE_BUILD}
    Try
{$ENDIF}
        If ELDesigner1.CanCut Then
            ELDesigner1.Cut;
{$IFNDEF PRIVATE_BUILD}
    Except
    End;
{$ENDIF}
    DisablePropertyBuilding := False;

    ELDesigner1.SelectedControls.Clear;
    ELDesigner1.SelectedControls.Add(ELDesigner1.DesignControl);
    BuildProperties(ELDesigner1.DesignControl);
End;

Procedure TWXDsgn.actDesignerPasteExecute(Sender: TObject);
Begin
    If IsFromScrollBarShowing Then
    Begin
        MessageDlg('The Designer Form is scrolled. ' + #13 + #10 + '' + #13 + #10 + 'Please resize the form to hide the scrollbar before deleting controls.', mtError, [mbOK], 0);
        exit;
    End;

    BuildProperties(ELDesigner1.DesignControl, True);
    DisablePropertyBuilding := True;
{$IFNDEF PRIVATE_BUILD}
    Try
{$ENDIF}
        If ELDesigner1.CanPaste Then
            ELDesigner1.Paste;
{$IFNDEF PRIVATE_BUILD}
    Except
    End;
{$ENDIF}
    DisablePropertyBuilding := False;

    ELDesigner1.SelectedControls.Clear;
    ELDesigner1.SelectedControls.Add(ELDesigner1.DesignControl);
    BuildProperties(ELDesigner1.DesignControl);
End;

Function TWXDsgn.IsFromScrollBarShowing: Boolean;
Begin
    If ((TFrmNewForm(ELDesigner1.DesignControl).HorzScrollBar.IsScrollBarVisible = True) Or
        (TFrmNewForm(ELDesigner1.DesignControl).VertScrollBar.IsScrollBarVisible = True)) Then
        result := True
    Else
        result := False;
End;

Procedure TWXDsgn.actDesignerDeleteExecute(Sender: TObject);
Begin
    BuildProperties(ELDesigner1.DesignControl, True);
    DisablePropertyBuilding := True;
    ELDesigner1.DeleteSelectedControls;
    DisablePropertyBuilding := False;

    GetCurrentDesignerForm();
    ELDesigner1.SelectedControls.Clear;
    ELDesigner1.SelectedControls.Add(ELDesigner1.DesignControl);
    BuildProperties(ELDesigner1.SelectedControls[0]);

End;

Procedure TWXDsgn.JvInspPropertiesBeforeSelection(Sender: TObject;
    NewItem: TJvCustomInspectorItem; Var Allow: Boolean);
Begin
    Allow := True;
    If Not Assigned(NewItem) Then
        Exit;

    If Not Assigned(NewItem.Data) Then
        Exit;
    Try
        If AnsiSameText(NewItem.DisplayName, 'name') And
            AnsiSameText(NewItem.Data.Name, 'wx_Name') Then
            PreviousStringValue := NewItem.Data.AsString;
        If AnsiSameText(NewItem.DisplayName, 'name') Then
            PreviousComponentName := NewItem.Data.AsString
    Except
    End;

End;

Function TWXDsgn.ReplaceClassNameInEditor(strLst: TStringList; text: TSynEdit; FromClassName, ToClassName: String): Boolean;
Var
    I: Integer;
    lineNum: Integer;
    lineStr: String;

    Function IsNumeric(s: String): Boolean;
    Var
        i: Integer;
    Begin
        result := True;
        For i := 1 To length(s) Do
            If Not (s[i] In ['0'..'9']) Then
            Begin
                result := False;
                exit;
            End;
    End;
Begin
    Result := False;
    If strLst.Count < 1 Then
        exit;

    For I := 0 To strLst.Count - 1 Do // Iterate
    Begin
        If Not IsNumeric(strLst[i]) Then
            continue;
        lineNum := StrToInt(strLst[i]);
        If lineNum > text.Lines.Count Then
            continue;
        Try
            lineStr := text.Lines[lineNum];

            strSearchReplace(lineStr, FromClassName, ToClassName, [srWord, srCase, srAll]);
            text.Lines[lineNum] := lineStr;
        Except

        End;
    End; // for

  //TODO: Guru: Is there a better way of implementing the class search and replace?
    For I := 0 To text.Lines.Count - 1 Do // Iterate
    Begin
        Try
            lineStr := text.Lines[i];
            strSearchReplace(lineStr, FromClassName + '::' + FromClassName, ToClassName + '::' + ToClassName, [srWord, srCase, srAll]);
            strSearchReplace(lineStr, '~' + FromClassName, '~' + ToClassName, [srWord, srCase, srAll]);
            strSearchReplace(lineStr, ' ' + FromClassName + '(', ' ' + ToClassName + '(', [srWord, srCase, srAll]);
            text.Lines[i] := lineStr;

        Except
        End;
    End; // for

    Result := True;

End;

Procedure TWXDsgn.JvInspPropertiesItemValueChanged(Sender: TObject;
    Item: TJvCustomInspectorItem);
Begin
  //sendDebug('Yes it is changed!!!');
End;

Procedure TWXDsgn.DesignerOptionsClick(Sender: TObject);
Begin
    With TDesignerForm.Create(self) Do
        Try
            ShowModal;
        Finally
            Free;
        End;
End;

Procedure TWXDsgn.AlignToGridClick(Sender: TObject);
Begin
    ELDesigner1.SelectedControls.AlignToGrid;
End;

Procedure TWXDsgn.AlignToLeftClick(Sender: TObject);
Begin
    ELDesigner1.SelectedControls.Align(atLeftTop, atNoChanges);
End;

Procedure TWXDsgn.AlignToRightClick(Sender: TObject);
Begin
    ELDesigner1.SelectedControls.Align(atRightBottom, atNoChanges);
End;

Procedure TWXDsgn.AlignToMiddleHorizontalClick(Sender: TObject);
Begin
    ELDesigner1.SelectedControls.Align(atCenter, atNoChanges);
End;

Procedure TWXDsgn.AlignToMiddleVerticalClick(Sender: TObject);
Begin
    ELDesigner1.SelectedControls.Align(atNoChanges, atCenter);
End;

Procedure TWXDsgn.AlignToTopClick(Sender: TObject);
Begin
    ELDesigner1.SelectedControls.Align(atNoChanges, atLeftTop);
End;

Procedure TWXDsgn.AlignToBottomClick(Sender: TObject);
Begin
    ELDesigner1.SelectedControls.Align(atNoChanges, atRightBottom);
End;

Procedure TWXDsgn.ViewControlIDsClick(Sender: TObject);
Var
    vwCtrlIDsFormObj: TViewControlIDsForm;
Begin
    vwCtrlIDsFormObj := TViewControlIDsForm.Create(self);

    vwCtrlIDsFormObj.SetMainControl(TWinControl(ELDesigner1.DesignControl));
    vwCtrlIDsFormObj.PopulateControlList;
    vwCtrlIDsFormObj.ShowModal;
End;

Procedure TWXDsgn.ChangeCreationOrder1Click(Sender: TObject);
Var
    Control: TWinControl;
    editorName, hppEditor, cppEditor: String;
Begin
    If main.GetPageControlActivePageIndex = -1 Then
        exit;

    If ELDesigner1.SelectedControls.Count = 0 Then
        exit;
  //Attempt to get a control that has sub-controls
    Control := TWinControl(ELDesigner1.SelectedControls.Items[0]);
    While Control.Parent <> Nil Do
    Begin
        If Control.ControlCount > 1 Then
            Break;
        Control := Control.Parent;
    End;

  //We give up - there isn't one to use
    If Control.ControlCount = 0 Then
    Begin
    //MessageDlg('You cannot do anything with this control. '+#13+'Select its parent Dialog or Sizer.', mtError, [mbOK], 0);
        Exit;
    End;

    If MessageDlg('All Designer related Files will be saved before proceeding.' + #13 + #10 + '' + #13 + #10 + 'Do you want to continue ?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes Then
        exit;

    editorName := main.GetActiveEditorName;
    If Not main.IsEditorAssigned(editorName) Then
        Exit;

    hppEditor := ChangeFileExt(editorName, H_EXT);
    If main.IsFileOpenedInEditor(hppEditor) Then
    Begin
        If main.IsEditorAssigned(hppEditor) Then
        Begin
            main.SaveFileFromPlugin(hppEditor, True);
        End;
    End;

    cppEditor := ChangeFileExt(editorName, CPP_EXT);
    If main.IsFileOpenedInEditor(cppEditor) Then
    Begin
        If main.IsEditorAssigned(cppEditor) Then
        Begin
            main.SaveFileFromPlugin(cppEditor, True);
        End;
    End;

    main.SaveFileFromPlugin(editorName, True);

    With TCreationOrderForm.Create(Self) Do
        Try
            SetMainControl(Control);
            PopulateControlList;
            ShowModal;
        Finally
            Free
        End;

    ELDesigner1.Active := False;
    ELDesigner1.DesignControl := Nil;

  //This should copy the Form's content to the Text Editor
    main.EditorInsertDefaultText(editorName);

  //Save form file
    main.SetEditorModified(editorName, True);

    main.SaveFileFromPlugin(editorName, True);
    (editors[editorName] As TWXEditor).ReloadForm;
    UpdateDesignerData(editorName);

    If main.IsFileOpenedInEditor(hppEditor) Then
    Begin
        If main.IsEditorAssigned(hppEditor) Then
        Begin
            main.SaveFileFromPlugin(hppEditor, True);
        End;
    End;

    If main.IsFileOpenedInEditor(cppEditor) Then
    Begin
        If main.IsEditorAssigned(cppEditor) Then
        Begin
            main.SaveFileFromPlugin(cppEditor, True);
        End;
    End;

    main.SaveFileFromPlugin(editorName, True);

    ELDesigner1.DesignControl := (editors[editorName] As TWXEditor).GetDesigner;
    BuildComponentList((editors[editorName] As TWXEditor).GetDesigner);
    ELDesigner1.Active := True;

End;

Procedure TWXDsgn.SelectParentClick(Sender: TObject);
Var
    ActiveControl: TControl;
    SelectedItem: TMenuItem;
    SelectedLevel: Integer;
Begin
  //Get all the information we need
    SelectedItem := TMenuItem(Sender);
    SelectedLevel := SelectedItem.Parent.IndexOf(SelectedItem) + 1;
    ActiveControl := ELDesigner1.SelectedControls.Items[0];

  //Select the control we want
    While SelectedLevel > 0 Do
    Begin
        ActiveControl := ActiveControl.Parent;
        SelectedLevel := SelectedLevel - 1;
    End;

  //Set set the active control
    ELDesigner1.SelectedControls.Clear;
    ELDesigner1.SelectedControls.Add(ActiveControl);
End;

Procedure TWXDsgn.LockControlClick(Sender: TObject);
Var
    I: Integer;
Begin
  //Do we lock or unlock them?
    If Not DesignerMenuLocked.Checked Then
        For I := 0 To ELDesigner1.SelectedControls.Count - 1 Do
            ELDesigner1.LockControl(ELDesigner1.SelectedControls[I], [lmNoMove, lmNoResize, lmNoDelete, lmNoInsertIn])
    Else
        For I := 0 To ELDesigner1.SelectedControls.Count - 1 Do
            ELDesigner1.LockControl(ELDesigner1.SelectedControls[I], []);
End;

Procedure TWXDsgn.OnPropertyItemSelected(Sender: TObject);
Begin
    If assigned(SelectedComponent) Then
    Begin
        If SelectedComponent Is TFrmNewForm Then
            PreviousComponentName := TFrmNewForm(SelectedComponent).Wx_Name
        Else
            PreviousComponentName := SelectedComponent.Name;
    End;
End;

Procedure TWXDsgn.actNewWxFrameExecute(Sender: TObject);
Begin
    CreateNewDialogOrFrameCode(dtWxFrame, Nil, 2);
End;

Procedure TWXDsgn.actNewwxDialogExecute(Sender: TObject);
Begin
    CreateNewDialogOrFrameCode(dtWxDialog, Nil, 2);
End;

Procedure TWXDsgn.actWxPropertyInspectorCutExecute(Sender: TObject);
Begin
    SendMessage(GetFocus, WM_CUT, 0, 0);
End;

Procedure TWXDsgn.actWxPropertyInspectorCopyExecute(Sender: TObject);
Begin
    SendMessage(GetFocus, WM_COPY, 0, 0);
End;

Procedure TWXDsgn.actWxPropertyInspectorPasteExecute(Sender: TObject);
Begin
    SendMessage(GetFocus, WM_PASTE, 0, 0);
End;

Procedure TWXDsgn.actWxPropertyInspectorDeleteExecute(Sender: TObject);
Begin
    If (GetFocus <> 0) Then
        SendMessage(GetFocus, WM_CLEAR, 0, 0)
    Else
        MessageDlg('nothing selected', mtError, [mbOK], 0);

End;

Procedure TWXDsgn.GenerateSource(sourceFileName: String; text: TSynEdit);
Var
    editorName, ext: String;
Begin
    ext := ExtractFileExt(sourceFileName);
    editorName := ChangeFileExt(sourceFileName, WXFORM_EXT);
    If ext = CPP_EXT Then
        GenerateCpp((editors[editorName] As TWXEditor).GetDesigner, (editors[editorName] As TWXEditor).GetDesigner().Wx_Name, text)
    Else
    If ext = H_EXT Then
        GenerateHpp((editors[editorName] As TWXEditor).GetDesigner, (editors[editorName] As TWXEditor).GetDesigner().Wx_Name, text);
End;

Procedure TWXDsgn.ActivateDesigner(s: String);
Begin
    If isForm(s) Then
    Begin
        If Assigned((editors[s] As TWXEditor).GetDesigner()) Then
        Begin
            ELDesigner1.Active := False;
            Try
                ELDesigner1.DesignControl := (editors[s] As TWXEditor).GetDesigner();
                ELDesigner1.Active := True;
            Except
            End;
            BuildComponentList((editors[s] As TWXEditor).GetDesigner());
        End;
    End;
End;

Procedure TWXDsgn.UpdateXRC(editorName: String);
Var
    resourceName: String;
    text: TSynEdit;
Begin
    If IsForm(editorName) Then
    Begin

        If (ELDesigner1.GenerateXRC) Then
            resourceName := ChangeFileExt(editorName, XRC_EXT);
        If FileExists(resourceName) Then
        Begin
            main.OpenFile(resourceName, True);

            If main.IsEditorAssigned(resourceName) Then
            Begin
                text := main.GetEditorText(resourceName);
                text.BeginUpdate;
                Try
                    GenerateXRC((editors[editorName] As TWXEditor).GetDesigner(), (editors[editorName] As TWXEditor).GetDesigner().Wx_Name, text, editorName);
                    main.SetEditorModified(resourceName, True);
                Except
                End;
                main.TouchEditor(resourceName);
                text.EndUpdate;
            End;

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
        End;

    End;
End;

Procedure TWXDsgn.GenerateXPM(s: String; b: Boolean);
Begin
    If editors.Exists(s) Then
        Designerfrm.GenerateXPM((editors[s] As TWXEditor).GetDesigner, s, b);
End;

Procedure TWXDsgn.SetBoolInspectorDataClear(b: Boolean);
Begin
    boolInspectorDataClear := b;
End;

Function TWXDsgn.GetFilters: TStringList;
Var
    filters: TStringList;
Begin
    filters := TStringList.Create;
    filters.Add(FLT_WXFORMS);
    filters.Add(FLT_XRC);
    Result := filters;
End;

Function TWXDsgn.GetSrcFilters: TStringList;
Var
    filters: TStringList;
Begin
    filters := TStringList.Create;
    filters.Add(FLT_XRC);
    Result := filters;
End;

Procedure TWXDsgn.SetDisablePropertyBuilding(b: Boolean);
Begin
    DisablePropertyBuilding := b;
End;

Procedure TWXDsgn.Reload(FileName: String);
Begin
    (editors[FileName] As TWXEditor).ReloadForm;
End;

Function TWXDsgn.ReloadForm(FileName: String): Boolean;
Begin
    Result := False;
    If isForm(FileName) Then
    Begin
        (editors[FileName] As TWXEditor).ReloadFormFromFile(FileName);
        Result := True;
    End;
End;

Procedure TWXDsgn.ReloadFromFile(FileName: String; fileToReloadFrom: String);
Begin
    (editors[FileName] As TWXEditor).ReloadFormFromFile(fileToReloadFrom);
End;

Procedure TWXDsgn.TerminateEditor(FileName: String);
Begin
    If (editors.Exists(FileName)) Then
    Begin
        (editors[FileName] As TWXEditor).Terminate;
        editors.Delete(FileName);
    End;
End;

Procedure TWXDsgn.DestroyDLL;
Begin
    editors.Free;
    ComponentPalette.Free;
    JvInspProperties.Free;
    JvInspEvents.Free;
    JvInspectorDotNETPainter1.Free;
    JvInspectorDotNETPainter2.Free;
    ComputerInfo1.Free;
    main := Nil;
End;

Procedure TWXDsgn.OnDockableFormClosed(Sender: TObject; Var Action: TCloseAction);
Begin
    If TForm(Sender) = frmInspectorDock Then
    Begin
        ShowPropertyInspItem.Checked := False;
    End
    Else
    If TForm(Sender) = frmPaletteDock Then
    Begin
        ShowComponentPaletteItem.Checked := False;
    End;

End;

Function TWXDsgn.IsSource(FileName: String): Boolean;
Begin
    Result := Not isForm(FileName);
End;

Function TWXDsgn.GetDefaultText(FileName: String): String;
Begin
    Result := (editors[FileName] As TWXEditor).GetDefaultText;
End;

Function TWXDsgn.MainPageChanged(FileName: String): Boolean;
Begin
    Result := False;
    If IsForm(FileName) Then
    Begin
        pendingEditorSwitch := False;
    //Show a busy cursor
        Screen.Cursor := crHourglass;

        Application.ProcessMessages;

        If Not ELDesigner1.Active Or cleanUpJvInspEvents Then
            EnableDesignerControls;
        ActivateDesigner(FileName);
        Screen.Cursor := crDefault;
        Result := True;
        If (ELDesigner1.Floating) Then
            (editors[FileName] As TWxEditor).GetDesigner.Show;  // EAB proper focus when designer floating

        If (Trim(ComponentPalette.SelectedComponent) <> '') And (TControlClass(GetClass(ComponentPalette.SelectedComponent)) <> Nil) Then
            Screen.Cursor := crDrag;

    End
    Else
    Begin
        If ELDesigner1.Active Then
            DisableDesignerControls;
    End;
End;

Procedure TWXDsgn.OnToolbarEvent(WM_COMMAND: Word);
Begin

End;

Function TWXDsgn.Retrieve_LeftDock_Panels: TList;
Var
    items: TList;
Begin
    items := TList.Create;
    items.Add(frmInspectorDock);
    items.Add(frmPaletteDock);
    Result := items;
End;

Function TWXDsgn.Retrieve_RightDock_Panels: TList;
Begin
    Result := Nil;
End;

Function TWXDsgn.Retrieve_BottomDock_Panels: TList;
Begin
    Result := Nil;
End;

Function TWXDsgn.Retrieve_File_New_Menus: TList;
Var
    items: TList;
Begin
    items := TList.Create;
    items.Add(NewWxDialogItem);
    items.Add(NewWxFrameItem);
    Result := items;
End;

Function TWXDsgn.Retrieve_File_Import_Menus: TList;
Begin
    Result := Nil;
End;

Function TWXDsgn.Retrieve_File_Export_Menus: TList;
Begin
    Result := Nil;
End;

Function TWXDsgn.Retrieve_Edit_Menus: TList;
Begin
    Result := Nil;
End;

Function TWXDsgn.Retrieve_Search_Menus: TList;
Begin
    Result := Nil;
End;

Function TWXDsgn.Retrieve_View_Menus: TList;
Var
    items: TList;
Begin
    items := TList.Create;
    items.Add(ShowPropertyInspItem);
    items.Add(ShowComponentPaletteItem);
    Result := items;
End;

Function TWXDsgn.Retrieve_View_Toolbars_Menus: TList;
Begin
    Result := Nil;
End;

Function TWXDsgn.Retrieve_Project_Menus: TList;
Begin
    Result := Nil;
End;

Function TWXDsgn.Retrieve_Execute_Menus: TList;
Begin
    Result := Nil;
End;

Function TWXDsgn.Retrieve_Debug_Menus: TList;
Begin
    Result := Nil;
End;

Function TWXDsgn.Retrieve_Tools_Menus: TList;
Var
    items: TList;
Begin
    items := TList.Create;
    items.Add(ToolsMenuDesignerOptions);
    Result := items;
End;

Function TWXDsgn.Retrieve_Help_Menus: TList;
Begin
    Result := Nil;
End;

Function TWXDsgn.Retrieve_Toolbars: TToolBar;
Begin
    Result := Nil;
End;

Function TWXDsgn.Retrieve_Message_Tabs: TList;
Begin
    Result := Nil;
End;

Procedure TWXDsgn.SetEditorName(currentName: String; newName: String);
Var
    tempEditor: TWXEditor;
Begin
    If editors.Exists(currentName) Then
    Begin
        tempEditor := editors[currentName] As TWXEditor;
        editorNames[tempEditor.editorNumber] := newName;
        tempEditor.FileName := newName;
        editors.Rename(currentName, newName);
    End;
End;

Function TWXDsgn.GetPluginName: String;
Begin
    Result := plugin_name;
End;

Function TWXDsgn.GetChild: HWND;
Begin
    Result := 0;
End;

Function TWXDsgn.ShouldNotCloseEditor(FileName: String; curFilename: String): Boolean;
Begin
    Result := False;
    If (AnsiLowerCase(ChangeFileExt(FileName, WXFORM_EXT)) = curFilename) Or
        (AnsiLowerCase(ChangeFileExt(FileName, H_EXT)) = curFilename) Or
        (AnsiLowerCase(ChangeFileExt(FileName, CPP_EXT)) = curFilename) Or
        (AnsiLowerCase(ChangeFileExt(FileName, XRC_EXT)) = curFilename) Then
        Result := True;
End;

Procedure TWXDsgn.actShowPropertyInspItemExecute(Sender: TObject);
Begin
    TMenuItem(Sender).Checked := Not TMenuItem(Sender).Checked;
    main.ToggleDockForm(frmInspectorDock, TMenuItem(Sender).Checked);
End;

Procedure TWXDsgn.actShowComponentPaletteItemExecute(Sender: TObject);
Begin
    TMenuItem(Sender).Checked := Not TMenuItem(Sender).Checked;
    main.ToggleDockForm(frmPaletteDock, TMenuItem(Sender).Checked);
End;


Function TWXDsgn.GetXMLExtension: String;
Begin
    Result := XRC_EXT;
End;

Function TWXDsgn.ConvertLibsToCurrentVersion(strValue: String): String;
Begin
    Result := LocalConvertLibsToCurrentVersion(strValue);
End;

Procedure TWXDsgn.CreateNewXPMs(strFileName: String);
Begin
    (editors[strFileName] As TWXEditor).GetDesigner.CreateNewXPMs(strFileName);
End;

Function TWXDsgn.HasDesigner(editorName: String): Boolean;
Begin
    Result := Not (editors[editorName] As TWXEditor).IsDesignerNil;
End;

Function TWXDsgn.ManagesUnit: Boolean;
Begin
    Result := True;
End;

Function TWXDsgn.EditorDisplaysText(FileName: String): Boolean;
Begin
    Result := False;
End;

Function TWXDsgn.GetTextHighlighterType(FileName: String): String;
Begin
    Result := 'RES';
End;

Function TWXDsgn.GET_COMMON_CPP_INCLUDE_DIR: String;
Begin
    Result := COMMON_CPP_INCLUDE_DIR;
End;

Function TWXDsgn.GetCompilerMacros: String;
Var
    WxLibName: String;
Begin
    WxLibName := Format('wxmsw%d%d', [WxOptions.majorVersion, WxOptions.minorVersion]);

  //And then do the library features
    If WxOptions.unicodeSupport Then
        WxLibName := WxLibName + 'u';
    If WxOptions.debugLibrary Then
        WxLibName := WxLibName + 'd';

    Result := 'WXLIBNAME = ' + WxLibName;
End;

Function TWXDsgn.GetCompilerPreprocDefines: String;
Begin
  //Add the WXUSINGDLL if we are using a DLL build

    If Not WxOptions.staticLibrary Then
        Result := 'WXUSINGDLL'

    Else

        Result := '';

End;

Function TWXDsgn.Retrieve_CompilerOptionsPane: TTabSheet;
Begin
    Result := tabwxWidgets;
End;

Procedure TWXDsgn.LoadCompilerSettings(name: String; value: String);
Begin
  // Loading Compiler settings:
    If name = 'wxOpts.Major' Then
    Begin
        fwxOptions.majorVersion := StrToInt(value);
    End
    Else
    If name = 'wxOpts.Minor' Then
    Begin
        fwxOptions.minorVersion := StrToInt(value);
    End
    Else
    If name = 'wxOpts.Release' Then
    Begin
        fwxOptions.releaseVersion := StrToInt(value);
    End
    Else
    If name = 'wxOpts.Unicode' Then
    Begin
        fwxOptions.unicodeSupport := StrToBool(value);
    End
    Else
    If name = 'wxOpts.Monolithic' Then
    Begin
        fwxOptions.monolithicLibrary := StrToBool(value);
    End
    Else
    If name = 'wxOpts.Debug' Then
    Begin
        fwxOptions.debugLibrary := StrToBool(value);
    End
    Else
    If name = 'wxOpts.Static' Then
    Begin
        fwxOptions.staticLibrary := StrToBool(value);
    End;
End;

Procedure TWXDsgn.LoadCompilerOptions;
Begin
    With wxOptions Do
    Begin
        spwxMajor.Value := majorVersion;
        spwxMinor.Value := minorVersion;
        spwxRelease.Value := releaseVersion;

        chkwxUnicode.Checked := unicodeSupport;
        chkwxMonolithic.Checked := monolithicLibrary;
        chkwxDebug.Checked := debugLibrary;
        If staticLibrary Then
            staticLib.Checked := True
        Else
            dynamicLib.Checked := True;
    End;
End;

Procedure TWXDsgn.SaveCompilerOptions;
Begin
    With wxOptions Do
    Begin
        majorVersion := spwxMajor.Value;
        minorVersion := spwxMinor.Value;
        releaseVersion := spwxRelease.Value;

        unicodeSupport := chkwxUnicode.Checked;
        monolithicLibrary := chkwxMonolithic.Checked;
        debugLibrary := chkwxDebug.Checked;
        staticLibrary := staticLib.Checked;
    End;
End;

Function TWXDsgn.GetCompilerOptions: TSettings;
Var
    settings: TSettings;
    setting: TSetting;
Begin
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
End;

Procedure TWXDsgn.SetCompilerOptionstoDefaults;
Begin
  // wxWidgets options
    With wxOptions Do
    Begin
        majorVersion := 2;
        minorVersion := 9;
        releaseVersion := 3;

        unicodeSupport := True;
        monolithicLibrary := True;
        debugLibrary := False;
        staticLibrary := True;
    End;
End;

Procedure TWXDsgn.TestReport;
Begin
    ShowMessage('wxdsgn plugin has been loaded.');
End;

Procedure TWXDsgn.AfterStartupCheck;
Begin
    ShowPropertyInspItem.Checked := frmInspectorDock.Visible;
    ShowComponentPaletteItem.Checked := frmPaletteDock.Visible;
End;

Procedure TWXDsgn.FullScreenSwitch;
Var
    i: Integer;
Begin
    For i := 0 To editors.ItemCount - 1 Do
        (editors[editorNames[i]] As TWXEditor).RestorePosition;
End;

Function TWXDsgn.GetContextForHelp: String;
Begin
    Result := '';
End;

Initialization
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
Finalization
    Classes.UnRegisterClass(TWXDsgn);

End.
