// $Id$
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

Unit wxAuiPaneInfo;

Interface

Uses
    Windows, Messages, SysUtils, Classes, Forms, wxUtils, WxNonVisibleBaseComponent;

Type
    TWxAuiPaneInfo = Class(TWxNonVisibleBaseComponent, IWxComponentInterface, IWxAuiPaneInfoInterface,
        IWxToolBarInsertableInterface, IWxToolBarNonInsertableInterface)
    Private
    { Private declarations }
        FWx_Class: String;
        FWx_PropertyList: TStringList;
        FWx_Comments: TStrings;
        FWx_EventList: TStringList;
        FWx_Caption: String;
        FWx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem;
        FWx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet;
        FWx_Aui_Pane_Style: TwxAuiPaneStyleSet;
        FWx_Aui_Pane_Buttons: TwxAuiPaneButtonSet;
        FWx_BestSize_Height: Integer;
        FWx_BestSize_Width: Integer;
        FWx_MinSize_Height: Integer;
        FWx_MinSize_Width: Integer;
        FWx_MaxSize_Height: Integer;
        FWx_MaxSize_Width: Integer;
        FWx_Row: Integer;
        FWx_Position: Integer;

        Procedure AutoInitialize;
        Procedure AutoDestroy;

    Protected

    Public
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Function GenerateControlIDs: String;
        Function GenerateEnumControlIDs: String;
        Function GenerateEventTableEntries(CurrClassName: String): String;
        Function GenerateGUIControlCreation: String;
        Function GenerateXRCControlCreation(IndentString: String): TStringList;
        Function GenerateGUIControlDeclaration: String;
        Function GenerateHeaderInclude: String;
        Function GenerateImageInclude: String;
        Function GetEventList: TStringList;
        Function GetIDName: String;
        Function GetIDValue: Integer;
        Function GetParameterFromEventName(EventName: String): String;
        Function GetPropertyList: TStringList;
        Function GetTypeFromEventName(EventName: String): String;
        Function GetWxClassName: String;
        Procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
        Procedure SetIDName(IDName: String);
        Procedure SetIDValue(IDValue: Integer);
        Procedure SetWxClassName(wxClassName: String);
        Function GetFGColor: String;
        Procedure SetFGColor(strValue: String);
        Function GetBGColor: String;
        Procedure SetBGColor(strValue: String);
        Procedure SetProxyFGColorString(Value: String);
        Procedure SetProxyBGColorString(Value: String);

        Function GetGenericColor(strVariableName: String): String;
        Procedure SetGenericColor(strVariableName, strValue: String);

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

        Function GetAuiDockDirection(Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem): String;
        Function GetAuiDockableDirections(Wx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet): String;
        Function GetAui_Pane_Style(Wx_Aui_Pane_Style: TwxAuiPaneStyleSet): String;
        Function GetAui_Pane_Buttons(Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet): String;
        Function GetAuiRow(row: Integer): String;
        Function GetAuiPosition(position: Integer): String;
        Function GetAuiPaneBestSize: String;
        Function GetAuiPaneMinSize: String;
        Function GetAuiPaneMaxSize: String;
        Function GetAuiPaneCaption: String;
        Procedure SetAuiPaneCaption(Caption: String);
        Function GetAuiPaneName: String;

        Function GetWx_BestSize_Height: Integer;
        Procedure SetWx_BestSize_Height(height: Integer);
        Function GetWx_BestSize_Width: Integer;
        Procedure SetWx_BestSize_Width(width: Integer);

        Function GetWx_MinSize_Height: Integer;
        Procedure SetWx_MinSize_Height(height: Integer);
        Function GetWx_MinSize_Width: Integer;
        Procedure SetWx_MinSize_Width(width: Integer);

        Function GetWx_MaxSize_Height: Integer;
        Procedure SetWx_MaxSize_Height(height: Integer);
        Function GetWx_MaxSize_Width: Integer;
        Procedure SetWx_MaxSize_Width(width: Integer);

        Function GetWx_Row: Integer;
        Procedure SetWx_Row(row: Integer);

        Function GetWx_Position: Integer;
        Procedure SetWx_Position(position: Integer);

        Function HasToolbarPaneStyle(Wx_Aui_Pane_Style: TwxAuiPaneStyleSet): Boolean;
    Published
    { Published declarations }
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
        Property Wx_EventList: TStringList Read FWx_EventList Write FWx_EventList;
        Property Wx_Caption: String Read FWx_Caption Write FWx_Caption;
        Property Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem Read FWx_Aui_Dock_Direction Write FWx_Aui_Dock_Direction;
        Property Wx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet Read FWx_Aui_Dockable_Direction Write FWx_Aui_Dockable_Direction;
        Property Wx_Aui_Pane_Style: TwxAuiPaneStyleSet Read FWx_Aui_Pane_Style Write FWx_Aui_Pane_Style;
        Property Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet Read FWx_Aui_Pane_Buttons Write FWx_Aui_Pane_Buttons;
        Property Wx_BestSize_Height: Integer Read GetWx_BestSize_Height Write SetWx_BestSize_Height Default 0;
        Property Wx_BestSize_Width: Integer Read GetWx_BestSize_Width Write SetWx_BestSize_Width Default 0;
        Property Wx_MinSize_Height: Integer Read GetWx_MinSize_Height Write SetWx_MinSize_Height Default 0;
        Property Wx_MinSize_Width: Integer Read GetWx_MinSize_Width Write SetWx_MinSize_Width Default 0;
        Property Wx_MaxSize_Height: Integer Read GetWx_MaxSize_Height Write SetWx_MaxSize_Height Default 0;
        Property Wx_MaxSize_Width: Integer Read GetWx_MaxSize_Width Write SetWx_MaxSize_Width Default 0;
        Property Wx_Row: Integer Read GetWx_Row Write SetWx_Row Default 0;
        Property Wx_Position: Integer Read GetWx_Position Write SetWx_Position Default 0;
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxAuiPaneInfo]);
End;

{ Method to set variable and property values and create objects }

Procedure TWxAuiPaneInfo.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Class := 'wxAuiPaneInfo';
    FWx_Comments := TStringList.Create;
    FWx_EventList := TStringList.Create;
    Glyph.Handle := LoadBitmap(hInstance, 'TWxAuiPaneInfo');
    FWx_BestSize_Height := 0;
    FWx_BestSize_Width := 0;
    FWx_MinSize_Height := 0;
    FWx_MinSize_Width := 0;
    FWx_MaxSize_Height := 0;
    FWx_MaxSize_Width := 0;
    FWx_Row := 0;
    FWx_Position := 0;
    FWx_Aui_Pane_Buttons := [CloseButton];
  //  Wx_Caption := '';
End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }

Procedure TWxAuiPaneInfo.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_Comments.Destroy;
    FWx_EventList.Destroy;
    Glyph.Assign(Nil);
End; { of AutoDestroy }

Constructor TWxAuiPaneInfo.Create(AOwner: TComponent);
Begin
  { Call the Create method of the container's parent class       }
    Inherited Create(AOwner);

  { AutoInitialize method is generated by Component Create.      }
    AutoInitialize;

  { Code to perform other tasks when the component is created }
  { Code to perform other tasks when the component is created }
    FWx_PropertyList.add('Name:Name');
    FWx_PropertyList.add('Wx_Class:Base Class');
    FWx_PropertyList.add('Wx_Comments:Comments');
    FWx_PropertyList.add('Wx_Caption:Caption');
    FWx_PropertyList.add('Wx_Aui_Dock_Direction:Dock Direction');
    FWx_PropertyList.add('wxAUI_DOCK_NONE:wxAUI_DOCK_NONE');
    FWx_PropertyList.add('wxAUI_DOCK_TOP:wxAUI_DOCK_TOP');
    FWx_PropertyList.add('wxAUI_DOCK_RIGHT:wxAUI_DOCK_RIGHT');
    FWx_PropertyList.add('wxAUI_DOCK_BOTTOM:wxAUI_DOCK_BOTTOM');
    FWx_PropertyList.add('wxAUI_DOCK_LEFT:wxAUI_DOCK_LEFT');
    FWx_PropertyList.add('wxAUI_DOCK_CENTER:wxAUI_DOCK_CENTER');
    FWx_PropertyList.add('Wx_Aui_Dockable_Direction:Dockable Direction');
    FWx_PropertyList.add('Dockable:Dockable');
    FWx_PropertyList.add('TopDockable:TopDockable');
    FWx_PropertyList.add('RightDockable:RightDockable');
    FWx_PropertyList.add('BottomDockable:BottomDockable');
    FWx_PropertyList.add('LeftDockable:LeftDockable');
    FWx_PropertyList.add('Wx_Aui_Pane_Style:Pane Style');
    FWx_PropertyList.add('CaptionVisible:CaptionVisible');
    FWx_PropertyList.add('DestroyOnClose:DestroyOnClose');
    FWx_PropertyList.add('DockFixed:DockFixed');
    FWx_PropertyList.add('Floatable:Floatable');
    FWx_PropertyList.add('Gripper:Gripper');
    FWx_PropertyList.add('GripperTop:GripperTop');
    FWx_PropertyList.add('Movable:Movable');
    FWx_PropertyList.add('PaneBorder:PaneBorder');
    FWx_PropertyList.add('Resizable:Resizable');
    FWx_PropertyList.add('ToolbarPane:ToolbarPane');
    FWx_PropertyList.add('Wx_Aui_Pane_Buttons:Pane Buttons');
    FWx_PropertyList.add('CloseButton:CloseButton');
    FWx_PropertyList.add('MaximizeButton:MaximizeButton');
    FWx_PropertyList.add('RightDockable:RightDockable');
    FWx_PropertyList.add('MinimizeButton:MinimizeButton');
    FWx_PropertyList.add('PinButton:PinButton');
    FWx_PropertyList.add('Wx_BestSize_Height:Best Height');
    FWx_PropertyList.add('Wx_BestSize_Width:Best Width');
    FWx_PropertyList.add('Wx_MinSize_Height:Min Height');
    FWx_PropertyList.add('Wx_MinSize_Width:Min Width');
    FWx_PropertyList.add('Wx_MaxSize_Height:Max Height');
    FWx_PropertyList.add('Wx_MaxSize_Width:Max Width');
    FWx_PropertyList.add('Wx_Row:Row');
    FWx_PropertyList.add('Wx_Position:Position');

End;

Destructor TWxAuiPaneInfo.Destroy;
Begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
    AutoDestroy;

  { Here, free any other dynamic objects that the component methods  }
  { created but have not yet freed.  Also perform any other clean-up }
  { operations needed before the component is destroyed.             }

  { Last, free the component by calling the Destroy method of the    }
  { parent class.                                                    }
    Inherited Destroy;
End;

Function TWxAuiPaneInfo.GenerateControlIDs: String;
Begin
    Result := '';
End;

Function TWxAuiPaneInfo.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxAuiPaneInfo.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxAuiPaneInfo.GenerateXRCControlCreation(IndentString: String): TStringList;
Begin

    Result := TStringList.Create;

    Try
        Result.Add(IndentString + Format('<object class="%s" name="%s">',
            [self.Wx_Class, self.Name]));
        Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxAuiPaneInfo.GenerateGUIControlCreation: String;
Var
    parentName, strAlignment: String;
Begin
    parentName := GetWxWidgetParent(self);

    Result := '';
    Result := GetCommentString(self.FWx_Comments.Text);

    If Not HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) Then
    Begin
        If (self.Parent.ClassName = 'TWxPanel') Then
            If Not (self.Parent.Parent Is TForm) Then
                Result := Result + #13 + Format('%s->Reparent(this);', [parentName]);
    End;

    If HasToolbarPaneStyle(Self.Wx_Aui_Pane_Style) Then
    Begin
        Result := Result + #13 + Format('%s->Realize();', [parentName]);
    End;

    Result := Result + #13 + Format('WxAuiManager1->AddPane(%s, wxAuiPaneInfo()%s%s%s%s%s%s%s%s%s%s%s);',
        [parentName, GetAuiPaneName, GetAuiPaneCaption, GetAuiDockDirection(Self.Wx_Aui_Dock_Direction), GetAuiDockableDirections(self.Wx_Aui_Dockable_Direction),
        GetAui_Pane_Style(Self.Wx_Aui_Pane_Style), GetAui_Pane_Buttons(Self.Wx_Aui_Pane_Buttons), GetAuiRow(Self.Wx_Row), GetAuiPosition(Self.Wx_Position), GetAuiPaneBestSize, GetAuiPaneMinSize, GetAuiPaneMaxSize]);

End;

Function TWxAuiPaneInfo.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
End;

Function TWxAuiPaneInfo.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/aui/aui.h>';
End;

Function TWxAuiPaneInfo.GenerateImageInclude: String;
Begin

End;

Function TWxAuiPaneInfo.GetEventList: TStringList;
Begin
    Result := Wx_EventList;
End;

Function TWxAuiPaneInfo.GetIDName: String;
Begin

End;

Function TWxAuiPaneInfo.GetIDValue: Integer;
Begin
    Result := 0;
End;

Function TWxAuiPaneInfo.GetParameterFromEventName(EventName: String): String;
Begin
    Result := '';
End;

Function TWxAuiPaneInfo.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxAuiPaneInfo.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxAuiPaneInfo.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxAuiPaneInfo.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxAuiPaneInfo.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxAuiPaneInfo.SetBorderWidth(width: Integer);
Begin
End;

Function TWxAuiPaneInfo.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxAuiPaneInfo.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxAuiPaneInfo';
    Result := wx_Class;
End;

Procedure TWxAuiPaneInfo.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin

End;

Procedure TWxAuiPaneInfo.SetIDName(IDName: String);
Begin

End;

Procedure TWxAuiPaneInfo.SetIDValue(IDValue: Integer);
Begin

End;

Procedure TWxAuiPaneInfo.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxAuiPaneInfo.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxAuiPaneInfo.GetFGColor: String;
Begin

End;

Procedure TWxAuiPaneInfo.SetFGColor(strValue: String);
Begin
End;

Function TWxAuiPaneInfo.GetBGColor: String;
Begin
End;

Procedure TWxAuiPaneInfo.SetBGColor(strValue: String);
Begin
End;

Procedure TWxAuiPaneInfo.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxAuiPaneInfo.SetProxyBGColorString(Value: String);
Begin
End;

Function TWxAuiPaneInfo.GetGenericColor(strVariableName: String): String;
Begin
End;

Procedure TWxAuiPaneInfo.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxAuiPaneInfo.GetAuiDockDirection(Wx_Aui_Dock_Direction: TwxAuiPaneDockDirectionItem): String;
Begin
    Result := '';
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_NONE Then
    Begin
        Result := '';
        exit;
    End;
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_TOP Then
    Begin
        Result := '.Top()';
        exit;
    End;
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_RIGHT Then
    Begin
        Result := '.Right()';
        exit;
    End;
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_BOTTOM Then
    Begin
        Result := '.Bottom()';
        exit;
    End;
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_LEFT Then
    Begin
        Result := '.Left()';
        exit;
    End;
    If Wx_Aui_Dock_Direction = wxAUI_DOCK_CENTER Then
    Begin
        Result := '.Center()';
        exit;
    End;
End;

Function TWxAuiPaneInfo.GetAui_Pane_Style(Wx_Aui_Pane_Style: TwxAuiPaneStyleSet): String;
Begin
    Result := '';
    If CaptionVisible In Wx_Aui_Pane_Style Then
        Result := Result + '.CaptionVisible()';

    If DestroyOnClose In Wx_Aui_Pane_Style Then
        Result := Result + '.DestroyOnClose()';

    If DockFixed In Wx_Aui_Pane_Style Then
        Result := Result + '.DockFixed()';

    If Floatable In Wx_Aui_Pane_Style Then
        Result := Result + '.Floatable()';

    If Gripper In Wx_Aui_Pane_Style Then
        Result := Result + '.Gripper()';

    If GripperTop In Wx_Aui_Pane_Style Then
        Result := Result + '.GripperTop()';

    If Movable In Wx_Aui_Pane_Style Then
        Result := Result + '.Movable()';

    If PaneBorder In Wx_Aui_Pane_Style Then
        Result := Result + '.PaneBorder()';

    If Resizable In Wx_Aui_Pane_Style Then
        Result := Result + '.Resizable()';

    If ToolbarPane In Wx_Aui_Pane_Style Then
        Result := Result + '.ToolbarPane()';

End;

Function TWxAuiPaneInfo.GetAuiDockableDirections(Wx_Aui_Dockable_Direction: TwxAuiPaneDockableDirectionSet): String;
Begin
    Result := '';
    If Dockable In Wx_Aui_Dockable_Direction Then
    Begin
        Result := Result + '.Dockable()';
        Exit;
    End;

    If LeftDockable In Wx_Aui_Dockable_Direction Then
        Result := Result + '.LeftDockable()';

    If RightDockable In Wx_Aui_Dockable_Direction Then
        Result := Result + '.RightDockable()';

    If TopDockable In Wx_Aui_Dockable_Direction Then
        Result := Result + '.TopDockable()';

    If BottomDockable In Wx_Aui_Dockable_Direction Then
        Result := Result + '.BottomDockable()';
End;

Function TWxAuiPaneInfo.GetAui_Pane_Buttons(Wx_Aui_Pane_Buttons: TwxAuiPaneButtonSet): String;
Begin
    Result := '';

    If CloseButton In Wx_Aui_Pane_Buttons Then
        Result := Result + '.CloseButton()';

    If MaximizeButton In Wx_Aui_Pane_Buttons Then
        Result := Result + '.MaximizeButton()';

    If MinimizeButton In Wx_Aui_Pane_Buttons Then
        Result := Result + '.MinimizeButton()';

    If PinButton In Wx_Aui_Pane_Buttons Then
        Result := Result + '.PinButton()';
End;

Function TWxAuiPaneInfo.GetAuiRow(row: Integer): String;
Begin
    Result := '';

    If row > 0 Then
        Result := Format('.Row(%d)', [row]);
End;

Function TWxAuiPaneInfo.GetAuiPosition(position: Integer): String;
Begin
    Result := '';

    If position > 0 Then
        Result := Format('.Position(%d)', [position]);
End;

Function TWxAuiPaneInfo.GetAuiPaneBestSize: String;
Var
    height: Integer;
    width: Integer;
Begin
    Result := '';
    height := self.GetWx_BestSize_Height;
    width := Self.GetWx_BestSize_Width;
    If (height > 0) And (width > 0) Then
        Result := Format('.BestSize(wxSize(%d, %d))', [width, height]);
End;

Function TWxAuiPaneInfo.GetWx_BestSize_Height: Integer;
Begin
    Result := FWx_BestSize_Height;
End;

Procedure TWxAuiPaneInfo.SetWx_BestSize_Height(height: Integer);
Begin
    FWx_BestSize_Height := height;
End;

Function TWxAuiPaneInfo.GetWx_BestSize_Width: Integer;
Begin
    Result := FWx_BestSize_Width;
End;

Procedure TWxAuiPaneInfo.SetWx_BestSize_Width(width: Integer);
Begin
    FWx_BestSize_Width := width;
End;

Function TWxAuiPaneInfo.GetAuiPaneMinSize: String;
Var
    height: Integer;
    width: Integer;
Begin
    Result := '';
    height := self.GetWx_MinSize_Height;
    width := Self.GetWx_MinSize_Width;
    If (height > 0) And (width > 0) Then
        Result := Format('.MinSize(wxSize(%d, %d))', [width, height]);
End;

Function TWxAuiPaneInfo.GetWx_MinSize_Height: Integer;
Begin
    Result := FWx_MinSize_Height;
End;

Procedure TWxAuiPaneInfo.SetWx_MinSize_Height(height: Integer);
Begin
    FWx_MinSize_Height := height;
End;

Function TWxAuiPaneInfo.GetWx_MinSize_Width: Integer;
Begin
    Result := FWx_MinSize_Width;
End;

Procedure TWxAuiPaneInfo.SetWx_MinSize_Width(width: Integer);
Begin
    FWx_MinSize_Width := width;
End;

Function TWxAuiPaneInfo.GetAuiPaneMaxSize: String;
Var
    height: Integer;
    width: Integer;
Begin
    Result := '';
    height := self.GetWx_MaxSize_Height;
    width := Self.GetWx_MaxSize_Width;
    If (height > 0) And (width > 0) Then
        Result := Format('.MaxSize(wxSize(%d, %d))', [width, height]);
End;

Function TWxAuiPaneInfo.GetWx_MaxSize_Height: Integer;
Begin
    Result := FWx_MaxSize_Height;
End;

Procedure TWxAuiPaneInfo.SetWx_MaxSize_Height(height: Integer);
Begin
    FWx_MaxSize_Height := height;
End;

Function TWxAuiPaneInfo.GetWx_MaxSize_Width: Integer;
Begin
    Result := FWx_MaxSize_Width;
End;

Procedure TWxAuiPaneInfo.SetWx_MaxSize_Width(width: Integer);
Begin
    FWx_MaxSize_Width := width;
End;

Function TWxAuiPaneInfo.GetAuiPaneCaption: String;
Begin
    If trim(Wx_Caption) = '' Then
        Result := ''
    Else
        Result := Format('.Caption(%s)', [GetCppString(Self.FWx_Caption)]);
End;

Procedure TWxAuiPaneInfo.SetAuiPaneCaption(Caption: String);
Begin
    Wx_Caption := Caption;
End;

Function TWxAuiPaneInfo.GetAuiPaneName: String;
Begin
    Result := Format('.Name(%s)', [GetCppString(self.Name)]);
End;

Function TWxAuiPaneInfo.HasToolbarPaneStyle(Wx_Aui_Pane_Style: TwxAuiPaneStyleSet): Boolean;
Begin
    Result := ToolbarPane In Wx_Aui_Pane_Style;

End;

Function TWxAuiPaneInfo.GetWx_Row: Integer;
Begin
    Result := FWx_Row;
End;

Procedure TWxAuiPaneInfo.SetWx_Row(row: Integer);
Begin
    FWx_Row := row;
End;

Function TWxAuiPaneInfo.GetWx_Position: Integer;
Begin
    Result := FWx_Position;
End;

Procedure TWxAuiPaneInfo.SetWx_Position(position: Integer);
Begin
    FWx_Position := position;
End;

End.
