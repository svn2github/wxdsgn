unit iplugin_bpl;

interface

uses
    Classes, Forms, StdCtrls, ComCtrls, SynEdit, iplugger, iplugin;
const
	IID_IPlug_In: TGUID = '{3A60CAD4-AB89-4AD0-BC78-0627BA4E0AB8}';
type

  IPlug_In_BPL = interface(IPlug_In) ['{3A60CAD4-AB89-4AD0-BC78-0627BA4E0AB8}']
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
    function Retrieve_Message_Tabs: TList;    
	function Retrieve_Tabbed_LeftDock_Panels: TList;
    function GetFilters: TStringList;
    function GetSrcFilters: TStringList;
    procedure GenerateSource(sourceFileName: String; text: TSynEdit);
    procedure AssignPlugger(plug: IPlug);
	procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function Retrieve_CompilerOptionsPane: TTabSheet;
  end;


implementation

end.

