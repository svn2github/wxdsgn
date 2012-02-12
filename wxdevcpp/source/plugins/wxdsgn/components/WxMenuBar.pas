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

Unit WxMenuBar;

Interface

Uses
    Windows, Controls, Forms, Messages, SysUtils, Classes, WxNonVisibleBaseComponent,
    Wxutils, WxSizerPanel, Menus, WxCustomMenuItem, StrUtils, dialogs,
    Graphics;

Type
    TWxMenuBar = Class(TWxNonVisibleBaseComponent, IWxComponentInterface,
        IWxDialogNonInsertableInterface, IWxMenuBarInterface)
    Private
    { Private declarations }
        FWx_Class: String;
        FWx_Caption: String;
        FWx_Comments: TStrings;
        FWx_PropertyList: TStringList;
        FWx_MenuItems: TWxCustomMenuItem;
        FWx_HasHistory: Boolean;
        fBitmapCount: Integer;
        Procedure AutoInitialize;
        Procedure AutoDestroy;
    Protected
    { Protected declarations }
    Public
    { Public declarations }
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Procedure Loaded; Override;
        Procedure BuildMenus(Value: TWxCustomMenuItem);
        Function GenerateControlIDs: String;
        Function GenerateEnumControlIDs: String;
        Function GenerateEventTableEntries(CurrClassName: String): String;
        Function GenerateGUIControlCreation: String;
        Function GenerateXRCControlCreation(IndentString: String): TStringList;
        Function GenerateGUIControlDeclaration: String;
        Function GetMenuItemCode: String;
        Function GetCodeForOneMenuItem(parentName: String; item: TWxCustomMenuItem): String;
        Function GenerateHeaderInclude: String;
        Function GenerateImageInclude: String;
        Function GenerateImageList(Var strLst: TStringList; Var imgLst: TList; Var strNameLst: TStringList): Boolean;
        Function GetEventList: TStringList;
        Function GetIDName: String;
        Function GetIDValue: Integer;
        Function GetParameterFromEventName(EventName: String): String;
        Function GetPropertyList: TStringList;
        Function GetTypeFromEventName(EventName: String): String;
        Function GetWxClassName: String;
        Procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
        Procedure SetIDName(IDName: String);
        Function GetMaxID: Integer;
        Procedure SetIDValue(IDValue: Integer);
        Procedure SetWxClassName(wxClassName: String);
        Function GetFGColor: String;
        Procedure SetFGColor(strValue: String);
        Function GetBGColor: String;
        Procedure SetBGColor(strValue: String);

        Function GetGenericColor(strVariableName: String): String;
        Procedure SetGenericColor(strVariableName, strValue: String);

        Procedure SetProxyFGColorString(Value: String);
        Procedure SetProxyBGColorString(Value: String);

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

        Function GetBitmapCount: Integer;
        Function GetBitmap(Idx: Integer; Var bmp: TBitmap; Var PropertyName: String): Boolean;
        Function GetPropertyName(Idx: Integer): String;
        Function GenerateXPM(strFileName: String): Boolean;
        Function GetGraphicFileName: String;
        Function SetGraphicFileName(strFileName: String): Boolean;

    Published
    { Published declarations }
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_Caption: String Read FWx_Caption Write FWx_Caption;
        Property Wx_MenuItems: TWxCustomMenuItem Read FWx_MenuItems Write FWx_MenuItems;
        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
        Property Wx_HasHistory: Boolean Read FWx_HasHistory Write FWx_HasHistory;

    End;

Procedure Register;

Implementation

Uses
    wxdesigner;

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxMenuBar]);
End;

Procedure TWxMenuBar.BuildMenus(Value: TWxCustomMenuItem);

    Procedure CreateSubMenu(SubMenuItems: TWxCustomMenuItem);
    Var
        I: Integer;
        mnuItem: TMenuItem;
    Begin
        For I := 0 To SubMenuItems.Count - 1 Do    // Iterate
        Begin
            mnuItem := TMenuItem.Create(self.parent);
            mnuItem.Caption := SubMenuItems.Items[i].Wx_Caption;
      //FMainMenu.Items.Add(mnuItem);
            If SubMenuItems.Items[i].Count > 0 Then
                CreateSubMenu(SubMenuItems.Items[i]);
        End;    // for
    End;

Var
    i: Integer;
    mnuItem: TMenuItem;
Begin
  //FMainMenu.Items.Clear;
  {
  if (FMainMenu.Owner <> self.parent) then
  begin
    FMainMenu.Destroy;
    FMainMenu := nil;
    FMainMenu := TMainMenu.Create(Self.Parent);
  end;
  }

    For I := 0 To Value.Count - 1 Do    // Iterate
    Begin
        mnuItem := TMenuItem.Create(self.parent);
        mnuItem.Caption := Value.Items[i].Wx_Caption;
    //FMainMenu.Items.Add(mnuItem);
        If Value.Items[i].Count > 0 Then
            CreateSubMenu(Value.Items[i]);
    End;    // for
End;

Procedure TWxMenuBar.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Class := 'wxMenuBar';
    FWx_MenuItems := TWxCustomMenuItem.Create(self.Parent);
    Glyph.Handle := LoadBitmap(hInstance, 'TWxMenuBar');
  //FMainMenu     := TMainMenu.Create(Self.Parent);
    FWx_Comments := TStringList.Create;
    FWx_HasHistory := False;

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxMenuBar.AutoDestroy;
Begin
    Glyph.Assign(Nil);
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

End; { of AutoDestroy }

Procedure TWxMenuBar.Loaded;
Begin
    Inherited Loaded;
  ///Do all stuff here
    self.BuildMenus(self.Wx_MenuItems);

End;


Constructor TWxMenuBar.Create(AOwner: TComponent);
Begin
  { Call the Create method of the container's parent class       }
    Inherited Create(AOwner);
  { AutoInitialize method is generated by Component Create.      }
    AutoInitialize;
  { Code to perform other tasks when the component is created }
    FWx_PropertyList.add('wx_Class:Base Class');
    FWx_PropertyList.add('Wx_Caption :Caption');
    FWx_PropertyList.add('Name : Name');
    FWx_PropertyList.add('Wx_MenuItems: Menu Items');
    FWx_PropertyList.add('Wx_Comments:Comments');

End;

Destructor TWxMenuBar.Destroy;
Begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
    AutoDestroy;
    Inherited Destroy;
End;

Function TWxMenuBar.GenerateEnumControlIDs: String;
Var
    I: Integer;
    strF: String;
    strLst: TStringList;

    Procedure GetEnumControlIDFromSubMenu(idstrList: TStringList;
        submnu: TWxCustomMenuItem);
    Var
        J: Integer;
        strData: String;
    Begin
        For J := 0 To submnu.Count - 1 Do    // Iterate
        Begin
            If Not AnsiStartsStr('wxID', submnu.Items[J].Wx_IDName) Then
            Begin
                strData := submnu.Items[J].Wx_IDName;

        //Do we want to specify an ID?
                If (UseIndividEnums) Then
                    If submnu.Items[J].wx_IDValue <> -1 Then
                        strData := strData + ' = ' + IntToStr(submnu.Items[J].wx_IDValue);

        //Add the result
                idstrList.add(strData + ',');
            End;

      //Iterate into sub-sub menus
            If submnu.items[J].Count > 0 Then
                GetEnumControlIDFromSubMenu(idstrList, submnu.items[J]);
        End;
    End;

Begin
    Result := '';
    strLst := TStringList.Create;

    For I := 0 To Wx_MenuItems.Count - 1 Do    // Iterate
    Begin
        If Not AnsiStartsStr('wxID', Wx_MenuItems.Items[i].Wx_IDName) Then
        Begin
            strF := Wx_MenuItems.Items[i].Wx_IDName;

      //Do we want to specify an ID?
            If (UseIndividEnums) Then
                If Wx_MenuItems.Items[i].wx_IDValue <> -1 Then
                    strF := strF + ' = ' + IntToStr(Wx_MenuItems.Items[i].wx_IDValue);

      //Then add the final entry
            If trim(strF) <> '' Then
                strLst.add(strF + ',');
        End;

        If Wx_MenuItems.items[i].Count > 0 Then
            GetEnumControlIDFromSubMenu(strLst, Wx_MenuItems.items[i]);
    End;
    Result := strLst.Text;
    strLst.Destroy;
End;

Function TWxMenuBar.GenerateControlIDs: String;
Var
    I: Integer;
    strF: String;
    strLst: TStringList;

    Procedure GetControlIDFromSubMenu(idstrList: TStringList; submnu: TWxCustomMenuItem);
    Var
        J: Integer;
        strData: String;
    Begin
        For J := 0 To submnu.Count - 1 Do    // Iterate
        Begin
            strData := '#define ' + submnu.Items[J].Wx_IDName + '  ' + IntToStr(
                submnu.Items[J].wx_IDValue) + ' ';
            idstrList.add(strData);

            If submnu.items[J].Count > 0 Then
                GetControlIDFromSubMenu(idstrList, submnu.items[J]);
        End;    // for
    End;

Begin

    Result := '';
    strLst := TStringList.Create;

    For I := 0 To Wx_MenuItems.Count - 1 Do    // Iterate
    Begin
        strF := '#define ' + Wx_MenuItems.Items[i].Wx_IDName + '  ' + IntToStr(
            Wx_MenuItems.Items[i].wx_IDValue) + ' ';
        If trim(strF) <> '' Then
            strLst.add(strF);

        If Wx_MenuItems.items[i].Count > 0 Then
            GetControlIDFromSubMenu(strLst, Wx_MenuItems.items[i]);
    End;    // for
    Result := strLst.Text;
    strLst.Destroy;

End;


Function TWxMenuBar.GenerateEventTableEntries(CurrClassName: String): String;
Var
    I: Integer;
    strLst: TStringList;

    Procedure GenerateEventTableEntriesFromSubMenu(idstrList: TStringList;
        submnu: TWxCustomMenuItem);
    Var
        J: Integer;
    Begin
        For J := 0 To submnu.Count - 1 Do    // Iterate
            If submnu.items[J].Count > 0 Then
                GenerateEventTableEntriesFromSubMenu(idstrList, submnu.items[J])
            Else
            Begin
                If trim(submnu.Items[j].EVT_Menu) <> '' Then
                    If submnu.Items[j].Wx_MenuItemStyle = wxMnuItm_History Then
                        strLst.add('EVT_MENU_RANGE(wxID_FILE1, wxID_FILE9' +
                            ', ' + CurrClassName + '::' + submnu.Items[j].EVT_Menu + ')')
                    Else
                        strLst.add('EVT_MENU(' + submnu.Items[j].Wx_IDName +
                            ', ' + CurrClassName + '::' + submnu.Items[j].EVT_Menu + ')');

                If trim(submnu.Items[j].EVT_UPDATE_UI) <> '' Then
                    strLst.add('EVT_UPDATE_UI(' + submnu.Items[j].Wx_IDName +
                        ', ' + CurrClassName + '::' + submnu.Items[j].EVT_UPDATE_UI + ')');
            End;    // for
    End;

Begin

    Result := '';
    strLst := TStringList.Create;

    For I := 0 To Wx_MenuItems.Count - 1 Do    // Iterate
        If Wx_MenuItems.items[i].Count > 0 Then
            GenerateEventTableEntriesFromSubMenu(strLst, Wx_MenuItems.items[i])
        Else
        Begin
            If trim(Wx_MenuItems.Items[i].EVT_Menu) <> '' Then
                If Wx_MenuItems.Items[i].Wx_MenuItemStyle = wxMnuItm_History Then
                    strLst.add('EVT_MENU_RANGE(wxID_FILE1, wxID_FILE9' +
                        ', ' + CurrClassName + '::' + Wx_MenuItems.Items[i].EVT_Menu + ')')
                Else
                    strLst.add('EVT_MENU(' + Wx_MenuItems.Items[i].Wx_IDName +
                        ', ' + CurrClassName + '::' + Wx_MenuItems.Items[i].EVT_Menu + ')');

            If trim(Wx_MenuItems.Items[i].EVT_UPDATE_UI) <> '' Then
                strLst.add('EVT_UPDATE_UI(' + Wx_MenuItems.Items[i].Wx_IDName +
                    ', ' + CurrClassName + '::' + Wx_MenuItems.Items[i].EVT_UPDATE_UI + ')');

        End;    // for
    Result := strLst.Text;
    strLst.Destroy;
End;

Function TWxMenuBar.GenerateXRCControlCreation(IndentString: String): TStringList;
Var
    i: Integer;
    tempstring: TStringList;

    Function GetXRCCodeFromSubMenu(IndentString: String;
        submnu: TWxCustomMenuItem): TStringList;
    Var
        i: Integer;
        tempstring: TStringList;

    Begin

        Result := TStringList.Create;

        Try

            For i := 0 To submnu.Count - 1 Do    // Iterate
                If submnu.items[i].Count > 0 Then
                Begin

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
                    Try

                        Result.AddStrings(tempstring);
                    Finally
                        tempstring.Free;
                    End;

                    If (submnu.Items[i].Wx_Checked) Then
                        Result.Add(IndentString + '      <checked>1</checked>')
                    Else
                        Result.Add(IndentString + '      <checked>0</checked>');

                    If (submnu.Items[i].Wx_Enabled) Then
                        Result.Add(IndentString + '      <enable>1</enable>')
                    Else
                        Result.Add(IndentString + '      <enable>0</enable>');


                    Result.Add(IndentString + '  </object>');

                End
                Else
                Begin

                    Result.Add(IndentString + '  <object class ="wxMenuItem" name="menuitem">');
                    Result.Add(IndentString + '    ' + Format('  <ID>%d</ID>',
                        [submnu.Items[i].Wx_IDValue]));
                    Result.Add(IndentString + '    ' + Format('  <IDident>%s</IDident>',
                        [submnu.Items[i].Wx_IDName]));
                    Result.Add(IndentString + '    ' + Format('  <label>%s</label>',
                        [XML_Label(submnu.Items[i].Wx_Caption)]));
                    Result.Add(IndentString + '    ' + Format('  <help>%s</help>',
                        [XML_Label(submnu.Items[i].Wx_HelpText)]));

                    If (submnu.Items[i].Wx_Checked) Then
                        Result.Add(IndentString + '      <checked>1</checked>')
                    Else
                        Result.Add(IndentString + '      <checked>0</checked>');

                    If (submnu.Items[i].Wx_Enabled) Then
                        Result.Add(IndentString + '      <enable>1</enable>')
                    Else
                        Result.Add(IndentString + '      <enable>0</enable>');

                    Result.Add(IndentString + '  </object>');

                End;

        Except

            Result.Free;
            Raise;

        End;

    End;

Begin

    Result := TStringList.Create;

    Try

        Result.Add(IndentString + Format('<object class="%s" name="%s">',
            [self.Wx_Class, self.Name]));

        For i := 0 To Wx_MenuItems.Count - 1 Do    // Iterate
            If Wx_MenuItems.items[i].Count > 0 Then
            Begin

                Result.Add(IndentString + '  <object class ="wxMenu" name="menu">');
                Result.Add(IndentString + '    ' + Format('<ID>%d</ID>',
                    [Wx_MenuItems.Items[i].Wx_IDValue]));
                Result.Add(IndentString + '    ' + Format('<IDident>%s</IDident>',
                    [Wx_MenuItems.Items[i].Wx_IDName]));
                Result.Add(IndentString + '    ' + Format('<label>%s</label>',
                    [XML_Label(Wx_MenuItems.Items[i].Wx_Caption)]));
                Result.Add(IndentString + '    ' + Format('<help>%s</help>',
                    [XML_Label(Wx_MenuItems.Items[i].Wx_HelpText)]));

                If (Wx_MenuItems.Items[i].Wx_Checked) Then
                    Result.Add(IndentString + '    <checked>1</checked>')
                Else
                    Result.Add(IndentString + '    <checked>0</checked>');

                If (Wx_MenuItems.Items[i].Wx_Enabled) Then
                    Result.Add(IndentString + '    <enable>1</enable>')
                Else
                    Result.Add(IndentString + '    <enable>0</enable>');

                tempstring := GetXRCCodeFromSubMenu(IndentString + '      ',
                    Wx_MenuItems.items[i]);
                Try
                    Result.AddStrings(tempstring)
                Finally
                    tempstring.Free;
                End;

                Result.Add(IndentString + '  </object>');

            End
            Else
            Begin

                Result.Add(IndentString + '  <object class ="wxMenu" name="menu">');
                Result.Add(IndentString + '    ' + Format('<ID>%d</ID>',
                    [Wx_MenuItems.Items[i].Wx_IDValue]));
                Result.Add(IndentString + '    ' + Format('<IDident>%s</IDident>',
                    [Wx_MenuItems.Items[i].Wx_IDName]));
                Result.Add(IndentString + '    ' + Format('<label>%s</label>',
                    [XML_Label(Wx_MenuItems.Items[i].Wx_Caption)]));
                Result.Add(IndentString + '    ' + Format('<help>%s</help>',
                    [XML_Label(Wx_MenuItems.Items[i].Wx_HelpText)]));

                If (Wx_MenuItems.Items[i].Wx_Checked) Then
                    Result.Add(IndentString + '    <checked>1</checked>')
                Else
                    Result.Add(IndentString + '    <checked>0</checked>');

                If (Wx_MenuItems.Items[i].Wx_Enabled) Then
                    Result.Add(IndentString + '    <enable>1</enable>')
                Else
                    Result.Add(IndentString + '    <enable>0</enable>');

                Result.Add(IndentString + '  </object>');

            End;

        Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;
End;

Function TWxMenuBar.GenerateGUIControlCreation: String;
Var
    strStyle, parentName: String;
Begin
    Result := '';
    parentName := GetWxWidgetParent(self, False);
    If trim(strStyle) <> '' Then
        strStyle := ',' + strStyle;

    If (XRCGEN) Then
    Begin//generate xrc loading code
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = wxXmlResource::Get()->LoadMenuBar(%s,%s("%s"));',
            [self.Name, parentName, StringFormat, self.Name]);
    End
    Else
    Begin
        Result := GetCommentString(self.FWx_Comments.Text) +
            Format('%s = new %s(%s);', [self.Name, self.Wx_Class, strStyle]);

        Result := Result + #13 + GetMenuItemCode + #13 + 'SetMenuBar(' + self.Name + ');';
    End;//Nuklear Zelph
End;

Function TWxMenuBar.GetCodeForOneMenuItem(parentName: String;
    item: TWxCustomMenuItem): String;
Begin
    Result := '';
    If item.Count < 1 Then
        If item.Wx_MenuItemStyle = wxMnuItm_Separator Then
            Result := parentName + '->AppendSeparator();'
        Else
        If item.Wx_MenuItemStyle = wxMnuItm_History Then
        Begin
            Wx_HasHistory := True;
            Result := Result + #13 + 'm_fileHistory = new wxFileHistory(9,wxID_FILE1);';
            Result := Result + #13 + 'm_fileHistory->UseMenu( ' + parentName + ' );';
	           Result := Result + #13 + 'm_fileConfig = new wxConfig("' + ChangeFileExt(ExtractFileName(wx_designer.main.GetProjectFileName), '') + '");';
            Result := Result + #13 + 'wxConfigBase::Set( m_fileConfig );';
            Result := Result + #13 + 'm_fileConfig->SetPath(wxT("/RecentFiles"));';
            Result := Result + #13 + 'm_fileHistory->Load(*m_fileConfig); ';
            Result := Result + #13 + 'm_fileConfig->SetPath(wxT(".."));';
        End
        Else
        Begin
            If item.WX_BITMAP.Bitmap.Handle <> 0 Then
            Begin
                Result := 'wxMenuItem * ' + item.Wx_IDName +
                    '_mnuItem_obj = new wxMenuItem (' + Format('%s, %s, %s, %s, %s',
                    [parentName, item.Wx_IDName, GetCppString(item.Wx_Caption), GetCppString(
                    item.Wx_HelpText), GetMenuKindAsText(item.Wx_MenuItemStyle)]) + ');';
                Result := Result + #13 + #10 + 'wxBitmap ' + item.Wx_IDName +
                    '_mnuItem_obj_BMP(' + GetDesignerFormName(self) + '_' + item.Wx_IDName + '_XPM);';
                Result := Result + #13 + #10 + item.Wx_IDName + '_mnuItem_obj->SetBitmap(' +
                    item.Wx_IDName + '_mnuItem_obj_BMP);';
                Result := Result + #13 + #10 + parentName + '->Append(' +
                    item.Wx_IDName + '_mnuItem_obj);';
            End
            Else
                Result := parentName + '->Append(' +
                    Format('%s, %s, %s, %s', [item.Wx_IDName, GetCppString(item.Wx_Caption),
                    GetCppString(item.Wx_HelpText),
                    GetMenuKindAsText(item.Wx_MenuItemStyle)]) + ');';

            If ((item.Wx_MenuItemStyle = wxMnuItm_Radio) Or (item.Wx_MenuItemStyle = wxMnuItm_Check)) Then
            Begin
                If item.Wx_Checked Then
                    Result := Result + #13 + #10 + parentName + '->Check(' + item.Wx_IDName + ',true);'
                Else
                    Result := Result + #13 + #10 + parentName + '->Check(' + item.Wx_IDName + ',false);';
            End;

            If Not item.Wx_Enabled Then
                Result := Result + #13 + #10 + parentName + '->Enable(' + item.Wx_IDName + ',false);';
        End;
End;

Function TWxMenuBar.GetMenuItemCode: String;
Var
    I: Integer;
    strF: String;
    strLst: TStringList;

    Procedure GetCodeFromSubMenu(submnustrlst: TStringList; submnu: TWxCustomMenuItem);
    Var
        J: Integer;
        parentItemName, strV: String;
    Begin
        Result := '';
        parentItemName := submnu.wx_IDName + '_Mnu_Obj';

        For J := 0 To submnu.Count - 1 Do    // Iterate
            If submnu.items[J].Count > 0 Then
            Begin
                strLst.add('');
                strV := Format('wxMenu *%s = new wxMenu();',
                    [submnu.items[J].wx_IDName + '_Mnu_Obj']);
                strLst.add(strV);

                GetCodeFromSubMenu(submnustrlst, submnu.items[J]);
                strV := parentItemName + '->Append(' + format(
                    '%s, %s, %s', [submnu.items[J].Wx_IDNAME,
                    GetCppString(submnu.items[J].Wx_Caption),
                    submnu.items[J].Wx_IDName + '_Mnu_Obj']) + ');';
                strLst.add(strV);
            End
            Else
            Begin
                strV := GetCodeForOneMenuItem(parentItemName, submnu.items[J]);
                If trim(strV) <> '' Then
                Begin
                    strLst.add(strV);
                End;
            End;    // for
    End;

Begin
    Result := '';
    strLst := TStringList.Create;
    For I := 0 To Wx_MenuItems.Count - 1 Do    // Iterate
        If Wx_MenuItems.items[i].Count > 0 Then
        Begin
            strF := Format('wxMenu *%s = new wxMenu();',
                [Wx_MenuItems.Items[i].Wx_IDName + '_Mnu_Obj']);
            strLst.add(strF);
            GetCodeFromSubMenu(strLst, Wx_MenuItems.items[i]);

            strF := Format('%s->Append(%s, %s);',
                [self.Name, Wx_MenuItems.Items[i].Wx_IDName + '_Mnu_Obj', GetCppString(
                Wx_MenuItems.Items[i].Wx_Caption)]);
            strLst.add(strF);
            strLst.add('');
        End
        Else
        Begin
            strF := Format('wxMenu *%s = new wxMenu();',
                [Wx_MenuItems.Items[i].Wx_IDName + '_Mnu_Obj']);

            If trim(strF) <> '' Then
            Begin
                strLst.add(strF);
                strF := Format('%s->Append(%s, %s);',
                    [self.Name, Wx_MenuItems.Items[i].Wx_IDName + '_Mnu_Obj', GetCppString(
                    Wx_MenuItems.Items[i].Wx_Caption)]);
                strLst.add(strF);
            End;
        End;    // for

  //Send the result back
    Result := trim(strLst.Text);
    strLst.Destroy;

End;

Function TWxMenuBar.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
    If Wx_HasHistory = True Then
        Result := Result + #13 + 'wxFileHistory *m_fileHistory; // the most recently opened files' + #13 + 'wxConfig *m_fileConfig; // Used to save the file history (can be used for other data too) ';
End;

Function TWxMenuBar.GenerateHeaderInclude: String;
Begin
    Result := '#include <wx/menu.h>';
    If Wx_HasHistory = True Then
        Result := Result + #13 + '#include <wx/config.h> // Needed For wxFileHistory' + #13 + '#include <wx/docview.h> // Needed For wxFileHistory';
End;

Function TWxMenuBar.GenerateImageInclude: String;
Var
    strLst, strNameList: TStringList;
    imgLst: TList;
    i: Integer;
Begin
    Result := '';
    strLst := TStringList.Create;
    strNameList := TStringList.Create;
    imgLst := TList.Create;
    GenerateImageList(strLst, imgLst, strNameList);

    For i := 0 To strLst.Count - 1 Do
        strLst[i] := '#include "' + strLst[i] + '"';

    Result := strLst.Text;
    strLst.destroy;
    strNameList.destroy;
    imgLst.destroy;
End;

Function TWxMenuBar.GenerateImageList(Var strLst: TStringList; Var imgLst: TList; Var strNameLst: TStringList): Boolean;
Var
    I: Integer;
    strF: String;

    Procedure GenerateImageListFromSubMenu(Var idstrList: TStringList; imgLstX: TList; strNameLstX: TStringList;
        submnu: TWxCustomMenuItem);
    Var
        J: Integer;
    Begin
        For J := 0 To submnu.Count - 1 Do    // Iterate
        Begin
            If submnu.Items[J].WX_BITMAP.Bitmap.Handle <> 0 Then
            Begin
                imgLstX.Add(submnu.Items[J].WX_BITMAP.Bitmap);
                idstrList.add('Images/' + GetDesignerFormName(self) + '_' + submnu.Items[J].Wx_IDName + '_XPM.xpm');
                strNameLstX.Add(submnu.Items[J].Wx_IDName);
            End;

            If submnu.items[J].Count > 0 Then
                GenerateImageListFromSubMenu(idstrList, imgLstX, strNameLstX, submnu.items[J]);
        End;    // for
    End;

Begin

    Result := True;

    For I := 0 To Wx_MenuItems.Count - 1 Do    // Iterate
    Begin
        If Wx_MenuItems.Items[i].wx_Bitmap.Bitmap.Handle <> 0 Then
            strF := 'Images/' + GetDesignerFormName(self) + '_' + Wx_MenuItems.Items[i].Wx_IDName + '_XPM.xpm'
        Else
            strF := '';
        If trim(strF) <> '' Then
        Begin
            imgLst.Add(Wx_MenuItems.Items[i].wx_Bitmap.Bitmap);
            strNameLst.Add(Wx_MenuItems.Items[i].Wx_IDName);
            strLst.add(strF);
        End;

        If Wx_MenuItems.items[i].Count > 0 Then
            GenerateImageListFromSubMenu(strLst, imgLst, strNameLst, Wx_MenuItems.items[i]);
    End;    // for

End;

Function TWxMenuBar.GetEventList: TStringList;
Begin
    Result := Nil;
End;

Function TWxMenuBar.GetIDName: String;
Begin
    Result := '';
End;

Function TWxMenuBar.GetIDValue: Integer;
Begin
    Result := GetMaxID;
End;

Function TWxMenuBar.GetParameterFromEventName(EventName: String): String;
Begin

End;

Function TWxMenuBar.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxMenuBar.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;


Function TWxMenuBar.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxMenuBar.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxMenuBar.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxMenuBar.SetBorderWidth(width: Integer);
Begin
End;

Function TWxMenuBar.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxMenuBar.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxMenu';
    Result := wx_Class;
End;

Procedure TWxMenuBar.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
Begin

End;

Function TWxMenuBar.GetMaxID: Integer;
Var
    I: Integer;
    retValue: Integer;

    Function GetMaxIDFromSubMenu(submnu: TWxCustomMenuItem): Integer;
    Var
        myretValue: Integer;
        J: Integer;
    Begin
        Result := submnu.Wx_IDValue;
        For J := 0 To submnu.Count - 1 Do    // Iterate
        Begin
            If submnu.items[J].Wx_IDValue > Result Then
                Result := submnu.items[J].Wx_IDValue;
            If submnu.items[J].Count > 0 Then
            Begin
                myretValue := GetMaxIDFromSubMenu(submnu.items[J]);
                If myretValue > Result Then
                    Result := myretValue;
            End;
        End;    // for
    End;

Begin
    Result := Wx_MenuItems.Wx_IDValue;
    For I := 0 To Wx_MenuItems.Count - 1 Do    // Iterate
    Begin
        If Wx_MenuItems.items[i].Wx_IDValue > Result Then
            Result := Wx_MenuItems.items[i].Wx_IDValue;
        If Wx_MenuItems.items[i].Count > 0 Then
        Begin
            retValue := GetMaxIDFromSubMenu(Wx_MenuItems.items[i]);
            If retValue > Result Then
                Result := retValue;
        End;
    End;    // for
End;


Procedure TWxMenuBar.SetIDName(IDName: String);
Begin

End;

Procedure TWxMenuBar.SetIDValue(IDValue: Integer);
Begin

End;

Procedure TWxMenuBar.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxMenuBar.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxMenuBar.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxMenuBar.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxMenuBar.GetFGColor: String;
Begin

End;

Procedure TWxMenuBar.SetFGColor(strValue: String);
Begin
End;

Function TWxMenuBar.GetBGColor: String;
Begin
End;

Procedure TWxMenuBar.SetBGColor(strValue: String);
Begin
End;

Procedure TWxMenuBar.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxMenuBar.SetProxyBGColorString(Value: String);
Begin
End;

Function TWxMenuBar.GetBitmapCount: Integer;
Begin
    Result := fBitmapCount;
End;

Function TWxMenuBar.GetBitmap(Idx: Integer; Var bmp: TBitmap; Var PropertyName: String): Boolean;
Begin
  //bmp:= nil;
    PropertyName := Name;
    Result := True;
End;

Function TWxMenuBar.GetPropertyName(Idx: Integer): String;
Begin
    Result := Name;
End;

Function TWxMenuBar.GetGraphicFileName: String;
Begin
    Result := 'fix';
End;

Function TWxMenuBar.SetGraphicFileName(strFileName: String): Boolean;
Begin

 // If no filename passed, then auto-generate XPM filename
    If (strFileName = '') Then
        strFileName := 'Images\' + GetDesignerFormName(self) + '_' + self.Name + '_XPM.xpm';

    Result := True;
End;


Function TWxMenuBar.GenerateXPM(strFileName: String): Boolean;
Var
    strLst, strNameList: TStringList;
    imgLst: TList;
    strXPMFileName, strFormName: String;
    bmpX: TBitmap;
    i: Integer;
Begin
    Result := False;
    strLst := TStringList.Create;
    strNameList := TStringList.Create;
    imgLst := TList.Create;

    GenerateImageList(strLst, imgLst, strNameList);
    strFormName := GetDesignerFormName(self);

    For i := 0 To strLst.Count - 1 Do
    Begin
        strXPMFileName := UnixPathToDosPath(IncludeTrailingPathDelimiter(ExtractFilePath(strFileName)) + strLst[i]);
        If FileExists(strXPMFileName) Then
            Continue;
        bmpX := imgLst[i];
        If bmpX.handle <> 0 Then
            GenerateXPMDirectly(bmpX, strNameList[i], strFormName, strFileName);
    End;

    imgLst.destroy;
    strLst.destroy;
    strNameList.destroy;
End;

End.
