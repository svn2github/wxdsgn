// $Id: WxMenuBar.pas 936 2007-05-15 03:47:39Z gururamnath $
{                                                                    }
{   Copyright © 2003-2007 by Guru Kathiresan                         }
{                                                                    }
{License :                                                           }
{=========                                                           }
{The wx-devC++ Components, Form Designer, Utils classes              }
{are exclusive properties of Guru Kathiresan.                        }
{The code is available in dual Licenses:                             }
{                               1)GPL Compatible  License            }
{                               2)Commercial License                 }
{                                                                    }
{1)GPL License :                                                     }
{ Code can be used in any project as long as the project's sourcecode}
{ is published under GPL license.                                    }
{                                                                    }
{2)Commercial License:                                               }
{Use of code in this file or the one that bear this license text     }
{can be used in Non-GPL projects as long as you get the permission   }
{from the Author - Guru Kathiresan.                                  }
{Use of the Code in any non-gpl projects without the permission of   }
{the author is illegal.                                              }
{Contact gururamnath@yahoo.com for details                           }
{ ****************************************************************** }

unit WxMenuBar;

interface

uses
  Windows, Controls,Forms, Messages, SysUtils, Classes, WxNonVisibleBaseComponent,
  Wxutils, WxSizerPanel, Menus, WxCustomMenuItem, StrUtils, dialogs,
  Graphics;

type
  TWxMenuBar = class(TWxNonVisibleBaseComponent, IWxComponentInterface,
    IWxDialogNonInsertableInterface,IWxMenuBarInterface)
  private
    { Private declarations }
    FWx_Class: string;
    FWx_Caption: string;
    FWx_Comments: TStrings;
    FWx_PropertyList: TStringList;
    FWx_MenuItems: TWxCustomMenuItem;
    FWx_HasHistory: boolean;
    fBitmapCount:Integer;
    procedure AutoInitialize;
    procedure AutoDestroy;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure BuildMenus(Value: TWxCustomMenuItem);
    function GenerateControlIDs: string;
    function GenerateEnumControlIDs: string;
    function GenerateEventTableEntries(CurrClassName: string): string;
    function GenerateGUIControlCreation: string;
    function GenerateXRCControlCreation(IndentString: string): TStringList;
    function GenerateGUIControlDeclaration: string;
    function GetMenuItemCode: string;
    function GetCodeForOneMenuItem(parentName: string; item: TWxCustomMenuItem): string;
    function GenerateHeaderInclude: string;
    function GenerateImageInclude: string;
    function GenerateImageList(var strLst:TStringList; var imgLst:TList; var strNameLst:TStringList): boolean;
    function GetEventList: TStringList;
    function GetIDName: string;
    function GetIDValue: integer;
    function GetParameterFromEventName(EventName: string): string;
    function GetPropertyList: TStringList;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    function GetMaxID: integer;
    procedure SetIDValue(IDValue: integer);
    procedure SetWxClassName(wxClassName: string);
    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);
   
    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);

    function GetBitmapCount:Integer;
    function GetBitmap(Idx:Integer;var bmp:TBitmap; var PropertyName:string):boolean;
    function GetPropertyName(Idx:Integer):String;
    function GenerateXPM(strFileName:String):boolean;
    function GetGraphicFileName:String;
    function SetGraphicFileName(strFileName : string): boolean;

  published
    { Published declarations }
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_Caption: string Read FWx_Caption Write FWx_Caption;
    property Wx_MenuItems: TWxCustomMenuItem Read FWx_MenuItems Write FWx_MenuItems;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
    property Wx_HasHistory: boolean Read FWx_HasHistory Write FWx_HasHistory;

  end;

procedure Register;

implementation

uses
    wxdesigner;

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxMenuBar]);
end;

procedure TWxMenuBar.BuildMenus(Value: TWxCustomMenuItem);

  procedure CreateSubMenu(SubMenuItems: TWxCustomMenuItem);
  var
    I: integer;
    mnuItem: TMenuItem;
  begin
    for I := 0 to SubMenuItems.Count - 1 do    // Iterate
    begin
      mnuItem := TMenuItem.Create(self.parent);
      mnuItem.Caption := SubMenuItems.Items[i].Wx_Caption;
      //FMainMenu.Items.Add(mnuItem);
      if SubMenuItems.Items[i].Count > 0 then
        CreateSubMenu(SubMenuItems.Items[i]);
    end;    // for
  end;

var
  i: integer;
  mnuItem: TMenuItem;
begin
  //FMainMenu.Items.Clear;
  {
  if (FMainMenu.Owner <> self.parent) then
  begin
    FMainMenu.Destroy;
    FMainMenu := nil;
    FMainMenu := TMainMenu.Create(Self.Parent);
  end;
  }

  for I := 0 to Value.Count - 1 do    // Iterate
  begin
    mnuItem := TMenuItem.Create(self.parent);
    mnuItem.Caption := Value.Items[i].Wx_Caption;
    //FMainMenu.Items.Add(mnuItem);
    if Value.Items[i].Count > 0 then
      CreateSubMenu(Value.Items[i]);
  end;    // for
end;

procedure TWxMenuBar.AutoInitialize;
begin
  FWx_PropertyList := TStringList.Create;
  FWx_Class     := 'wxMenuBar';
  FWx_MenuItems := TWxCustomMenuItem.Create(self.Parent);
  Glyph.Handle  := LoadBitmap(hInstance, 'TWxMenuBar');
  //FMainMenu     := TMainMenu.Create(Self.Parent);
  FWx_Comments  := TStringList.Create;
  FWx_HasHistory := false;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxMenuBar.AutoDestroy;
begin
  Glyph.Assign(nil);
  FWx_PropertyList.Destroy;
  FWx_MenuItems.Destroy;

  {
  if FMainMenu <> nil then
  begin
    try
    FMainMenu.Destroy;
    except
    end;
  end;
  }
  FWx_Comments.Destroy;

end; { of AutoDestroy }

procedure TWxMenuBar.Loaded;
begin
  inherited Loaded;
  ///Do all stuff here
  self.BuildMenus(self.Wx_MenuItems);

end;


constructor TWxMenuBar.Create(AOwner: TComponent);
begin
  { Call the Create method of the container's parent class       }
  inherited Create(AOwner);
  { AutoInitialize method is generated by Component Create.      }
  AutoInitialize;
  { Code to perform other tasks when the component is created }
  FWx_PropertyList.add('wx_Class:Base Class');
  FWx_PropertyList.add('Wx_Caption :Caption');
  FWx_PropertyList.add('Name : Name');
  FWx_PropertyList.add('Wx_MenuItems: Menu Items');
  FWx_PropertyList.add('Wx_Comments:Comments');

end;

destructor TWxMenuBar.Destroy;
begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
  AutoDestroy;
  inherited Destroy;
end;

function TWxMenuBar.GenerateEnumControlIDs: string;
var
  I:      integer;
  strF:   string;
  strLst: TStringList;

  procedure GetEnumControlIDFromSubMenu(idstrList: TStringList;
    submnu: TWxCustomMenuItem);
  var
    J: integer;
    strData: string;
  begin
    for J := 0 to submnu.Count - 1 do    // Iterate
    begin
      if not AnsiStartsStr('wxID', submnu.Items[J].Wx_IDName) then
      begin
        strData := submnu.Items[J].Wx_IDName;

        //Do we want to specify an ID?
        if (UseIndividEnums) then
        if submnu.Items[J].wx_IDValue <> -1 then
          strData := strData + ' = ' + IntToStr(submnu.Items[J].wx_IDValue);

        //Add the result
        idstrList.add(strData + ',');
      end;

      //Iterate into sub-sub menus
      if submnu.items[J].Count > 0 then
        GetEnumControlIDFromSubMenu(idstrList, submnu.items[J]);
    end;
  end;

begin
  Result := '';
  strLst := TStringList.Create;

  for I := 0 to Wx_MenuItems.Count - 1 do    // Iterate
  begin
    if not AnsiStartsStr('wxID', Wx_MenuItems.Items[i].Wx_IDName) then
    begin
      strF := Wx_MenuItems.Items[i].Wx_IDName;

      //Do we want to specify an ID?
      if (UseIndividEnums) then
      if Wx_MenuItems.Items[i].wx_IDValue <> -1 then
        strF := strF + ' = ' + IntToStr(Wx_MenuItems.Items[i].wx_IDValue);

      //Then add the final entry
      if trim(strF) <> '' then
        strLst.add(strF + ',');
    end;

    if Wx_MenuItems.items[i].Count > 0 then
      GetEnumControlIDFromSubMenu(strLst, Wx_MenuItems.items[i])
  end;
  Result := strLst.Text;
  strLst.Destroy;
end;

function TWxMenuBar.GenerateControlIDs: string;
var
  I:      integer;
  strF:   string;
  strLst: TStringList;

  procedure GetControlIDFromSubMenu(idstrList: TStringList; submnu: TWxCustomMenuItem);
  var
    J: integer;
    strData: string;
  begin
    for J := 0 to submnu.Count - 1 do    // Iterate
    begin
      strData := '#define ' + submnu.Items[J].Wx_IDName + '  ' + IntToStr(
        submnu.Items[J].wx_IDValue) + ' ';
      idstrList.add(strData);

      if submnu.items[J].Count > 0 then
        GetControlIDFromSubMenu(idstrList, submnu.items[J]);
    end;    // for
  end;

begin

  Result := '';
  strLst := TStringList.Create;

  for I := 0 to Wx_MenuItems.Count - 1 do    // Iterate
  begin
    strF := '#define ' + Wx_MenuItems.Items[i].Wx_IDName + '  ' + IntToStr(
      Wx_MenuItems.Items[i].wx_IDValue) + ' ';
    if trim(strF) <> '' then
      strLst.add(strF);

    if Wx_MenuItems.items[i].Count > 0 then
      GetControlIDFromSubMenu(strLst, Wx_MenuItems.items[i])
  end;    // for
  Result := strLst.Text;
  strLst.Destroy;

end;


function TWxMenuBar.GenerateEventTableEntries(CurrClassName: string): string;
var
  I:      integer;
  strLst: TStringList;

  procedure GenerateEventTableEntriesFromSubMenu(idstrList: TStringList;
    submnu: TWxCustomMenuItem);
  var
    J: integer;
  begin
    for J := 0 to submnu.Count - 1 do    // Iterate
      if submnu.items[J].Count > 0 then
        GenerateEventTableEntriesFromSubMenu(idstrList, submnu.items[J])
      else begin
        if trim(submnu.Items[j].EVT_Menu) <> '' then
          if submnu.Items[j].Wx_MenuItemStyle = wxMnuItm_History  then
            strLst.add('EVT_MENU_RANGE(wxID_FILE1, wxID_FILE9'  +
            ', ' + CurrClassName + '::' + submnu.Items[j].EVT_Menu + ')')
          else
            strLst.add('EVT_MENU(' + submnu.Items[j].Wx_IDName +
            ', ' + CurrClassName + '::' + submnu.Items[j].EVT_Menu + ')');

        if trim(submnu.Items[j].EVT_UPDATE_UI) <> '' then
          strLst.add('EVT_UPDATE_UI(' + submnu.Items[j].Wx_IDName +
            ', ' + CurrClassName + '::' + submnu.Items[j].EVT_UPDATE_UI + ')');
      end;    // for
  end;

begin

  Result := '';
  strLst := TStringList.Create;

  for I := 0 to Wx_MenuItems.Count - 1 do    // Iterate
    if Wx_MenuItems.items[i].Count > 0 then
      GenerateEventTableEntriesFromSubMenu(strLst, Wx_MenuItems.items[i])
    else begin
      if trim(Wx_MenuItems.Items[i].EVT_Menu) <> '' then
        if Wx_MenuItems.Items[i].Wx_MenuItemStyle = wxMnuItm_History then
        strLst.add('EVT_MENU_RANGE(wxID_FILE1, wxID_FILE9' +
                  ', ' + CurrClassName + '::' + Wx_MenuItems.Items[i].EVT_Menu + ')')
        else
        strLst.add('EVT_MENU(' + Wx_MenuItems.Items[i].Wx_IDName +
          ', ' + CurrClassName + '::' + Wx_MenuItems.Items[i].EVT_Menu + ')');

      if trim(Wx_MenuItems.Items[i].EVT_UPDATE_UI) <> '' then
        strLst.add('EVT_UPDATE_UI(' + Wx_MenuItems.Items[i].Wx_IDName +
          ', ' + CurrClassName + '::' + Wx_MenuItems.Items[i].EVT_UPDATE_UI + ')');

    end;    // for
  Result := strLst.Text;
  strLst.Destroy;
end;

function TWxMenuBar.GenerateXRCControlCreation(IndentString: string): TStringList;
var
  i: integer;
  tempstring: TStringList;

  function GetXRCCodeFromSubMenu(IndentString: string;
    submnu: TWxCustomMenuItem): TStringList;
  var
    i: integer;
    tempstring: TStringList;

  begin

    Result := TStringList.Create;

    try

      for i := 0 to submnu.Count - 1 do    // Iterate
        if submnu.items[i].Count > 0 then
        begin

          Result.Add(IndentString + '  <object class ="wxMenuItem" name="menuitem">');
          Result.Add(IndentString + '    ' + Format('  <ID>%d</ID>',
            [submnu.Items[i].Wx_IDValue]));
          Result.Add(IndentString + '    ' + Format('  <IDident>%s</IDident>',
            [submnu.Items[i].Wx_IDName]));
          Result.Add(IndentString + '    ' + Format('  <label>%s</label>',
            [XML_Label(submnu.Items[i].Wx_Caption)]));
          Result.Add(IndentString + '    ' + Format('  <help>%s</help>',
            [XML_Label(submnu.Items[i].Wx_HelpText)]));

          tempstring := GetXRCCodeFromSubMenu(IndentString + '        ', submnu.Items[i]);
          try

            Result.AddStrings(tempstring);
          finally
            tempstring.Free;
          end;

          if (submnu.Items[i].Wx_Checked) then
            Result.Add(IndentString + '      <checked>1</checked>')
          else
            Result.Add(IndentString + '      <checked>0</checked>');

          if (submnu.Items[i].Wx_Enabled) then
            Result.Add(IndentString + '      <enable>1</enable>')
          else
            Result.Add(IndentString + '      <enable>0</enable>');


          Result.Add(IndentString + '  </object>');

        end
        else begin

          Result.Add(IndentString + '  <object class ="wxMenuItem" name="menuitem">');
          Result.Add(IndentString + '    ' + Format('  <ID>%d</ID>',
            [submnu.Items[i].Wx_IDValue]));
          Result.Add(IndentString + '    ' + Format('  <IDident>%s</IDident>',
            [submnu.Items[i].Wx_IDName]));
          Result.Add(IndentString + '    ' + Format('  <label>%s</label>',
            [XML_Label(submnu.Items[i].Wx_Caption)]));
          Result.Add(IndentString + '    ' + Format('  <help>%s</help>',
            [XML_Label(submnu.Items[i].Wx_HelpText)]));

          if (submnu.Items[i].Wx_Checked) then
            Result.Add(IndentString + '      <checked>1</checked>')
          else
            Result.Add(IndentString + '      <checked>0</checked>');

          if (submnu.Items[i].Wx_Enabled) then
            Result.Add(IndentString + '      <enable>1</enable>')
          else
            Result.Add(IndentString + '      <enable>0</enable>');

          Result.Add(IndentString + '  </object>');

        end;

    except

      Result.Free;
      raise;

    end;

  end;

begin

  Result := TStringList.Create;

  try

    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));

    for i := 0 to Wx_MenuItems.Count - 1 do    // Iterate
      if Wx_MenuItems.items[i].Count > 0 then
      begin

        Result.Add(IndentString + '  <object class ="wxMenu" name="menu">');
        Result.Add(IndentString + '    ' + Format('<ID>%d</ID>',
          [Wx_MenuItems.Items[i].Wx_IDValue]));
        Result.Add(IndentString + '    ' + Format('<IDident>%s</IDident>',
          [Wx_MenuItems.Items[i].Wx_IDName]));
        Result.Add(IndentString + '    ' + Format('<label>%s</label>',
          [XML_Label(Wx_MenuItems.Items[i].Wx_Caption)]));
        Result.Add(IndentString + '    ' + Format('<help>%s</help>',
          [XML_Label(Wx_MenuItems.Items[i].Wx_HelpText)]));

        if (Wx_MenuItems.Items[i].Wx_Checked) then
          Result.Add(IndentString + '    <checked>1</checked>')
        else
          Result.Add(IndentString + '    <checked>0</checked>');

        if (Wx_MenuItems.Items[i].Wx_Enabled) then
          Result.Add(IndentString + '    <enable>1</enable>')
        else
          Result.Add(IndentString + '    <enable>0</enable>');

        tempstring := GetXRCCodeFromSubMenu(IndentString + '      ',
          Wx_MenuItems.items[i]);
        try
          Result.AddStrings(tempstring)
        finally
          tempstring.Free;
        end;

        Result.Add(IndentString + '  </object>');

      end
      else begin

        Result.Add(IndentString + '  <object class ="wxMenu" name="menu">');
        Result.Add(IndentString + '    ' + Format('<ID>%d</ID>',
          [Wx_MenuItems.Items[i].Wx_IDValue]));
        Result.Add(IndentString + '    ' + Format('<IDident>%s</IDident>',
          [Wx_MenuItems.Items[i].Wx_IDName]));
        Result.Add(IndentString + '    ' + Format('<label>%s</label>',
          [XML_Label(Wx_MenuItems.Items[i].Wx_Caption)]));
        Result.Add(IndentString + '    ' + Format('<help>%s</help>',
          [XML_Label(Wx_MenuItems.Items[i].Wx_HelpText)]));

        if (Wx_MenuItems.Items[i].Wx_Checked) then
          Result.Add(IndentString + '    <checked>1</checked>')
        else
          Result.Add(IndentString + '    <checked>0</checked>');

        if (Wx_MenuItems.Items[i].Wx_Enabled) then
          Result.Add(IndentString + '    <enable>1</enable>')
        else
          Result.Add(IndentString + '    <enable>0</enable>');

        Result.Add(IndentString + '  </object>');

      end;

    Result.Add(IndentString + '</object>');

  except
    Result.Free;
    raise;
  end;
end;

function TWxMenuBar.GenerateGUIControlCreation: string;
var
  strStyle, parentName : string;
begin
  Result     := '';
  parentName := GetWxWidgetParent(self, False);
  if trim(strStyle) <> '' then
    strStyle := ',' + strStyle;
  
  if (XRCGEN) then
 begin//generate xrc loading code
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = wxXmlResource::Get()->LoadMenuBar(%s,%s("%s"));',
    [self.Name, parentName, StringFormat, self.Name]);
 end
 else
 begin
  Result := GetCommentString(self.FWx_Comments.Text) +
    Format('%s = new %s(%s);', [self.Name, self.Wx_Class, strStyle]);

  Result := Result + #13 + GetMenuItemCode + #13 + 'SetMenuBar(' + self.Name + ');';
  end;//Nuklear Zelph
end;

function TWxMenuBar.GetCodeForOneMenuItem(parentName: string;
  item: TWxCustomMenuItem): string;
begin
  Result := '';
  if item.Count < 1 then
    if item.Wx_MenuItemStyle = wxMnuItm_Separator then
      Result := parentName + '->AppendSeparator();'
    else if item.Wx_MenuItemStyle = wxMnuItm_History then
    begin
      Wx_HasHistory := true;
      Result := Result + #13 + 'm_fileHistory = new wxFileHistory(9,wxID_FILE1);';
      Result := Result + #13 + 'm_fileHistory->UseMenu( ' + parentName + ' );';
	  Result := Result + #13 + 'm_fileConfig = new wxConfig("' + ChangeFileExt(ExtractFileName(wx_designer.main.GetProjectFileName), '') + '");';
      Result := Result + #13 + 'wxConfigBase::Set( m_fileConfig );';
      Result := Result + #13 + 'm_fileConfig->SetPath(wxT("/RecentFiles"));';
      Result := Result + #13 + 'm_fileHistory->Load(*m_fileConfig); ' ;
      Result := Result + #13 + 'm_fileConfig->SetPath(wxT(".."));'
    end
    else begin
      if item.WX_BITMAP.Bitmap.Handle <> 0 then
      begin
        Result := 'wxMenuItem * ' + item.Wx_IDName +
          '_mnuItem_obj = new wxMenuItem (' + Format('%s, %s, %s, %s, %s',
          [parentName, item.Wx_IDName, GetCppString(item.Wx_Caption), GetCppString(
          item.Wx_HelpText), GetMenuKindAsText(item.Wx_MenuItemStyle)]) + ');';
        Result := Result + #13 + #10 + 'wxBitmap ' + item.Wx_IDName +
          '_mnuItem_obj_BMP(' +GetDesignerFormName(self)+'_'+item.Wx_IDName + '_XPM);';
        Result := Result + #13 + #10 + item.Wx_IDName + '_mnuItem_obj->SetBitmap(' +
          item.Wx_IDName + '_mnuItem_obj_BMP);';
        Result := Result + #13 + #10 + parentName + '->Append(' +
          item.Wx_IDName + '_mnuItem_obj);';
      end
      else
        Result := parentName + '->Append(' +
          Format('%s, %s, %s, %s', [item.Wx_IDName, GetCppString(item.Wx_Caption),
          GetCppString(item.Wx_HelpText),
          GetMenuKindAsText(item.Wx_MenuItemStyle)]) + ');';

     if ((item.Wx_MenuItemStyle = wxMnuItm_Radio) or (item.Wx_MenuItemStyle = wxMnuItm_Check)) then
     begin
       if item.Wx_Checked then
         Result := Result + #13 + #10 + parentName + '->Check(' + item.Wx_IDName + ',true);'
       else
         Result := Result + #13 + #10 + parentName + '->Check(' + item.Wx_IDName + ',false);';
     end;

     if not item.Wx_Enabled then
       Result := Result + #13 + #10 + parentName + '->Enable(' + item.Wx_IDName + ',false);';
   end;
end;

function TWxMenuBar.GetMenuItemCode: string;
var
  I:      integer;
  strF:   string;
  strLst: TStringList;

  procedure GetCodeFromSubMenu(submnustrlst: TStringList; submnu: TWxCustomMenuItem);
  var
    J: integer;
    parentItemName, strV: string;
  begin
    Result := '';
    parentItemName := submnu.wx_IDName + '_Mnu_Obj';

    for J := 0 to submnu.Count - 1 do    // Iterate
      if submnu.items[J].Count > 0 then
      begin
        strLst.add('');
        strV := Format('wxMenu *%s = new wxMenu(%s);',
          [submnu.items[J].wx_IDName + '_Mnu_Obj', '0']);
        strLst.add(strV);

        GetCodeFromSubMenu(submnustrlst, submnu.items[J]);
        strV := parentItemName + '->Append(' + format(
          '%s, %s, %s', [submnu.items[J].Wx_IDNAME,
          GetCppString(submnu.items[J].Wx_Caption),
          submnu.items[J].Wx_IDName + '_Mnu_Obj']) + ');';
        strLst.add(strV);
      end
      else begin
        strV := GetCodeForOneMenuItem(parentItemName, submnu.items[J]);
        if trim(strV) <> '' then
        begin
          strLst.add(strV);
        end;
      end;    // for
  end;

begin
  Result := '';
  strLst := TStringList.Create;
  for I := 0 to Wx_MenuItems.Count - 1 do    // Iterate
    if Wx_MenuItems.items[i].Count > 0 then
    begin
      strF := Format('wxMenu *%s = new wxMenu(%s);',
        [Wx_MenuItems.Items[i].Wx_IDName + '_Mnu_Obj', '0']);
      strLst.add(strF);
      GetCodeFromSubMenu(strLst, Wx_MenuItems.items[i]);

      strF := Format('%s->Append(%s, %s);',
        [self.Name, Wx_MenuItems.Items[i].Wx_IDName + '_Mnu_Obj', GetCppString(
        Wx_MenuItems.Items[i].Wx_Caption)]);
      strLst.add(strF);
      strLst.add('');
    end
    else begin
      strF := Format('wxMenu *%s = new wxMenu(%s);',
        [Wx_MenuItems.Items[i].Wx_IDName + '_Mnu_Obj', '0']);

      if trim(strF) <> '' then
      begin
        strLst.add(strF);
        strF := Format('%s->Append(%s, %s);',
          [self.Name, Wx_MenuItems.Items[i].Wx_IDName + '_Mnu_Obj', GetCppString(
          Wx_MenuItems.Items[i].Wx_Caption)]);
        strLst.add(strF);
      end;
    end;    // for

  //Send the result back
  Result := trim(strLst.Text);
  strLst.Destroy;

end;

function TWxMenuBar.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
  if Wx_HasHistory = true then
    Result := Result + #13 + 'wxFileHistory *m_fileHistory; // the most recently opened files' + #13 + 'wxConfig *m_fileConfig; // Used to save the file history (can be used for other data too) ';
end;

function TWxMenuBar.GenerateHeaderInclude: string;
begin
  Result := '#include <wx/menu.h>';
  if Wx_HasHistory = true then
    Result := Result + #13 + '#include <wx/config.h> // Needed For wxFileHistory' + #13 + '#include <wx/docview.h> // Needed For wxFileHistory';
end;

function TWxMenuBar.GenerateImageInclude: string;
var
  strLst,strNameList: TStringList;
  imgLst:TList;
  i:Integer;
begin
  Result:='';
  strLst:= TStringList.Create;
  strNameList:= TStringList.Create;
  imgLst:=TList.Create;
  GenerateImageList(strLst,imgLst,strNameList);

  for i:= 0 to strLst.Count - 1 do
    strLst[i] :=  '#include "'+ strLst[i] + '"';

  Result := strLst.Text;
  strLst.destroy;
  strNameList.destroy;
  imgLst.destroy;
end;

function TWxMenuBar.GenerateImageList(var strLst:TStringList;var imgLst:TList;var strNameLst:TStringList): boolean;
var
  I:      integer;
  strF:   string;

  procedure GenerateImageListFromSubMenu(var idstrList: TStringList;imgLstX:TList;strNameLstX:TStringList;
    submnu: TWxCustomMenuItem);
  var
    J: Integer;
  begin
    for J := 0 to submnu.Count - 1 do    // Iterate
    begin
      if submnu.Items[J].WX_BITMAP.Bitmap.Handle <> 0 then
      begin
        imgLstX.Add(submnu.Items[J].WX_BITMAP.Bitmap);
        idstrList.add('Images/' + GetDesignerFormName(self)+'_'+submnu.Items[J].Wx_IDName + '_XPM.xpm');
        strNameLstX.Add(submnu.Items[J].Wx_IDName);
      end;
      
      if submnu.items[J].Count > 0 then
        GenerateImageListFromSubMenu(idstrList, imgLstX,strNameLstX,submnu.items[J]);
    end;    // for
  end;

begin

  Result := true;

  for I := 0 to Wx_MenuItems.Count - 1 do    // Iterate
  begin
    if Wx_MenuItems.Items[i].wx_Bitmap.Bitmap.Handle <> 0 then
      strF := 'Images/' + GetDesignerFormName(self)+'_'+Wx_MenuItems.Items[i].Wx_IDName + '_XPM.xpm'
    else
      strF := '';
    if trim(strF) <> '' then
    begin
      imgLst.Add(Wx_MenuItems.Items[i].wx_Bitmap.Bitmap);
      strNameLst.Add(Wx_MenuItems.Items[i].Wx_IDName);
      strLst.add(strF);
    end;

    if Wx_MenuItems.items[i].Count > 0 then
      GenerateImageListFromSubMenu(strLst, imgLst,strNameLst,Wx_MenuItems.items[i])
  end;    // for

end;

function TWxMenuBar.GetEventList: TStringList;
begin
  Result := nil;
end;

function TWxMenuBar.GetIDName: string;
begin
  Result := '';
end;

function TWxMenuBar.GetIDValue: integer;
begin
  Result := GetMaxID;
end;

function TWxMenuBar.GetParameterFromEventName(EventName: string): string;
begin

end;

function TWxMenuBar.GetStretchFactor: integer;
begin
   Result := 1;
end;

function TWxMenuBar.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;


function TWxMenuBar.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := [];
end;

procedure TWxMenuBar.SetBorderAlignment(border: TWxBorderAlignment);
begin
end;

function TWxMenuBar.GetBorderWidth: integer;
begin
  Result := 0;
end;

procedure TWxMenuBar.SetBorderWidth(width: integer);
begin
end;

function TWxMenuBar.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxMenuBar.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxMenu';
  Result := wx_Class;
end;

procedure TWxMenuBar.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin

end;

function TWxMenuBar.GetMaxID: integer;
var
  I: integer;
  retValue: integer;

  function GetMaxIDFromSubMenu(submnu: TWxCustomMenuItem): integer;
  var
    myretValue: integer;
    J: integer;
  begin
    Result := submnu.Wx_IDValue;
    for J := 0 to submnu.Count - 1 do    // Iterate
    begin
      if submnu.items[J].Wx_IDValue > Result then
        Result := submnu.items[J].Wx_IDValue;
      if submnu.items[J].Count > 0 then
      begin
        myretValue := GetMaxIDFromSubMenu(submnu.items[J]);
        if myretValue > Result then
          Result := myretValue;
      end;
    end;    // for
  end;

begin
  Result := Wx_MenuItems.Wx_IDValue;
  for I := 0 to Wx_MenuItems.Count - 1 do    // Iterate
  begin
    if Wx_MenuItems.items[i].Wx_IDValue > Result then
      Result := Wx_MenuItems.items[i].Wx_IDValue;
    if Wx_MenuItems.items[i].Count > 0 then
    begin
      retValue := GetMaxIDFromSubMenu(Wx_MenuItems.items[i]);
      if retValue > Result then
        Result := retValue;
    end;
  end;    // for
end;


procedure TWxMenuBar.SetIDName(IDName: string);
begin

end;

procedure TWxMenuBar.SetIDValue(IDValue: integer);
begin

end;

procedure TWxMenuBar.SetStretchFactor(intValue: integer);
begin
end;

procedure TWxMenuBar.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxMenuBar.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxMenuBar.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxMenuBar.GetFGColor: string;
begin

end;

procedure TWxMenuBar.SetFGColor(strValue: string);
begin
end;

function TWxMenuBar.GetBGColor: string;
begin
end;

procedure TWxMenuBar.SetBGColor(strValue: string);
begin
end;

procedure TWxMenuBar.SetProxyFGColorString(Value: string);
begin
end;

procedure TWxMenuBar.SetProxyBGColorString(Value: string);
begin
end;

function TWxMenuBar.GetBitmapCount:Integer;
begin
  Result:=fBitmapCount;
end;

function TWxMenuBar.GetBitmap(Idx:Integer;var bmp:TBitmap; var PropertyName:string):boolean;
begin
  //bmp:= nil;
  PropertyName:=Name;
  Result:=true;
end;

function TWxMenuBar.GetPropertyName(Idx:Integer):String;
begin
  Result:=Name;
end;

function TWxMenuBar.GetGraphicFileName:String;
begin
  Result:= 'fix';
end;

function TWxMenuBar.SetGraphicFileName(strFileName:String): boolean;
begin

 // If no filename passed, then auto-generate XPM filename
 if (strFileName = '') then
     strFileName := 'Images\' + GetDesignerFormName(self)+'_'+ self.Name + '_XPM.xpm';

  Result:= true;
end;


function TWxMenuBar.GenerateXPM(strFileName:String):boolean;
var
  strLst,strNameList: TStringList;
  imgLst:TList;
  strXPMFileName,strFormName:String;
  bmpX:TBitmap;
  i:Integer;
begin
  Result      := False;
  strLst      := TStringList.Create;
  strNameList := TStringList.Create;
  imgLst      := TList.Create;

  GenerateImageList(strLst,imgLst,strNameList);
  strFormName:=GetDesignerFormName(self);

  for i := 0 to strLst.Count - 1 do
  begin
    strXPMFileName:=UnixPathToDosPath(IncludeTrailingPathDelimiter(ExtractFilePath(strFileName))+strLst[i]);
    if FileExists(strXPMFileName) then
      Continue;
    bmpX := imgLst[i];
    if bmpX.handle  <> 0 then
      GenerateXPMDirectly(bmpX,strNameList[i],strFormName,strFileName);
  end;

  imgLst.destroy;
  strLst.destroy;
  strNameList.destroy;
end;

end.
