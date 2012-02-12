{***********************************************************************}
{ $Id: WxCustomMenuItem.pas 936 2007-05-15 03:47:39Z gururamnath $                                                                  }
 {                                                                       }
 {           HSoftware Components Collection                         }
 {                                                                       }
 {               Copyright (C) 1996 by Artem A. Berman                   }
 {               E-mail: art@aber.kherson.ua                             }
 {***********************************************************************}
 { This components can be freely used and distributed in commercial and  }
 { private environments, provied this notice is not modified in any way. }
 { ----------------------------------------------------------------------}
 { Version 1.01. Date last modified:  06/11/96                           }
 { ----------------------------------------------------------------------}

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

Unit wxCustomMenuItem;

Interface

Uses Forms, WinProcs, WinTypes, SysUtils, Menus, Classes, Messages, wxutils, Graphics;

Type
    EMenuError = Class(Exception);
  //  TMenuItem = class(Menus.TMenuItem)
  //  private
  //    FEVT_Menu:String;
  //    FEVT_UPDATE_UI:String;
  //    FWx_Class : String;
  //    FWx_Enabled : Boolean;
  //    FWx_HelpText : String;
  //    FWx_Hidden : Boolean;
  //    FWx_Name : String;
  //    FWx_IDName : String;
  //    FWx_IDValue : Longint;
  //    FWx_ToolTip : String;
  //    FMenuItemStyle:TWxMenuItemStyleItem;
  //    FWx_Caption : String;
  //    FWx_Checked : Boolean;
  //  published
  //    property EVT_Menu:String read FEVT_Menu write FEVT_Menu;
  //    property EVT_UPDATE_UI:String read FEVT_UPDATE_UI write FEVT_UPDATE_UI;
  //    property Wx_Class : String read FWx_Class write FWx_Class;
  //    property Wx_Enabled : Boolean read FWx_Enabled write FWx_Enabled;
  //    property Wx_HelpText : String read FWx_HelpText write FWx_HelpText;
  //    property Wx_Hidden : Boolean read FWx_Hidden write FWx_Hidden;
  //    property Wx_Name : String read FWx_Name write FWx_Name;
  //    property Wx_IDName : String read FWx_IDName write FWx_IDName;
  //    property Wx_IDValue : Longint read FWx_IDValue write FWx_IDValue ;
  //    property Wx_ToolTip : String read FWx_ToolTip write FWx_ToolTip;
  //    property MenuItemStyle:TWxMenuItemStyleItem read FMenuItemStyle write FMenuItemStyle;
  //    property Wx_Caption : String read FWx_Caption write FWx_Caption;
  //    property Wx_Checked : Boolean read FWx_Checked write FWx_Checked;
  //    //property WX_BITMAP:TPicture read FWX_BITMAP write FWX_BITMAP;
  //  end;

    TWxCustomMenuItem = Class(TPersistent)
    Private
        FEVT_Menu: String;
        FEVT_UPDATE_UI: String;
        FWx_Class: String;
        FWx_Enabled: Boolean;
        FWx_HelpText: String;
        FWx_Hidden: Boolean;
        FWx_Name: String;
        FWx_IDName: String;
        FWx_IDValue: Integer;
        FWx_ToolTip: String;
        FMenuItemStyle: TWxMenuItemStyleItem;
        FWx_Caption: String;
        FWx_Checked: Boolean;
        FWX_BITMAP: TPicture;
        FKeepFormat: Boolean;
        FWx_Comments: TStrings;
        FWx_FileHistory: Boolean;
        FItems: TList;
        FAdded: Boolean;
    //FParentHandle: HMENU;
    //FPosInParent: integer;
    //FBreak: TMenuBreak;
        FPopUp, FEnabled: Boolean;
    //FCaption: string;
    //FHandle: HMENU;
        FOnClick: TNotifyEvent;
    //function AppendTo(Menu: HMENU; Position: Word): Boolean;
    //procedure RedrawItem;
    //procedure SetBreak(Value: TMenuBreak);
    //procedure SetCaption(Value: string);
    //procedure SetChecked(Value: Boolean);
    //procedure SetEnabled(Value: Boolean);
        Procedure SetSubMenu(Value: Boolean);
    Protected
    //function HandleExists(Menu: HMENU): Boolean;
    //function GetHandle: HMENU; virtual;
        Function ItemExists(AItem: TWxCustomMenuItem): Boolean;
        Function GetCount: Integer;
        Procedure Click(Sender: TObject); Virtual;
        Function GetItem(Index: Integer): TWxCustomMenuItem;
        Procedure SetItem(Index: Integer; Item: TWxCustomMenuItem);
    //function GetItemFromHandle(Menu: HMenu): TWxCustomMenuItem;
    Public
    //property Handle: HMenu read GetHandle;
        Property Count: Integer Read GetCount;
        Constructor Create(owner: TComponent); Virtual;
        Destructor Destroy; Override;
        Procedure Clear;
        Procedure Add(AItem: TWxCustomMenuItem; Position: Word);
        Procedure Remove(AItem: TWxCustomMenuItem);
        Property Items[Index: Integer]: TWxCustomMenuItem Read GetItem Write SetItem;
            Default;
        Procedure DefineProperties(Filer: TFiler); Override;
        Procedure LoadFromStream(Stream: TStream);
        Procedure SaveToStream(Stream: TStream);

    Published
    //    property Break: TMenuBreak read FBreak write SetBreak default mbNone;
    //    property Caption: string read FCaption write SetCaption;
    //    property Checked: Boolean read FChecked write SetChecked default False;
    //    property Enabled: Boolean read FEnabled write SetEnabled default True;

        Property IsSubMenu: Boolean Read FPopUp Write SetSubMenu;
        Property OnClick: TNotifyEvent Read FOnClick Write FOnClick;

        Property EVT_Menu: String Read FEVT_Menu Write FEVT_Menu;
        Property EVT_UPDATE_UI: String Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;

        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_Enabled: Boolean Read FWx_Enabled Write FWx_Enabled;
        Property Wx_HelpText: String Read FWx_HelpText Write FWx_HelpText;
        Property Wx_Hidden: Boolean Read FWx_Hidden Write FWx_Hidden;
        Property Wx_Name: String Read FWx_Name Write FWx_Name;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue;
        Property Wx_ToolTip: String Read FWx_ToolTip Write FWx_ToolTip;
        Property Wx_MenuItemStyle: TWxMenuItemStyleItem
            Read FMenuItemStyle Write FMenuItemStyle;
        Property Wx_Caption: String Read FWx_Caption Write FWx_Caption;
        Property Wx_Checked: Boolean Read FWx_Checked Write FWx_Checked;
        Property WX_BITMAP: TPicture Read FWX_BITMAP Write FWX_BITMAP;
        Property KeepFormat: Boolean Read FKeepFormat Write FKeepFormat;
        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

        Property Wx_Items: TList Read FItems Write FItems;
        Property Wx_FileHistory: Boolean Read FWx_FileHistory Write FWx_FileHistory;

    End;

    TwxCustomMenuItemWrapper = Class(TComponent)
    Private
        FCarried: TWxCustomMenuItem;
    Published
        Property Carried: TWxCustomMenuItem Read FCarried Write FCarried;
    End;


Implementation

{TWxCustomMenuItem}
Constructor TWxCustomMenuItem.Create(owner: TComponent);
Begin
    FEnabled := True;
    FPopUp := False;
    FAdded := False;
    FWX_BITMAP := TPicture.Create;
    FItems := TList.Create;
    FWx_Enabled := True;
    FWx_FileHistory := False;
    Inherited Create;
End;

Destructor TWxCustomMenuItem.Destroy;
Var
    I: Integer;
Begin
    For I := 0 To FItems.Count - 1 Do
        TWxCustomMenuItem(FItems[I]).Destroy;
    FItems.Destroy;
    FWX_BITMAP.Destroy;
    Inherited Destroy;
End;

Procedure TWxCustomMenuItem.Click(Sender: TObject);
Begin
    If Assigned(FOnClick) Then
        FOnClick(Self);
End;

 //function TWxCustomMenuItem.GetHandle: HMenu;
 //begin
 //  if FHandle = 0 then FHandle := CreateMenu;
 //  Result := FHandle;
 //end;

 //function TWxCustomMenuItem.AppendTo(Menu: HMenu; Position: Word): Boolean;
 //const
 //  Breaks: array[TMenuBreak] of Longint = (0, MF_MENUBREAK, MF_MENUBARBREAK);
 //  Checks: array[Boolean] of LongInt = (MF_UNCHECKED, MF_CHECKED);
 //  Enables: array[Boolean] of LongInt = (MF_DISABLED or MF_GRAYED, MF_ENABLED);
 //  PopUps: array[Boolean] of LongInt = (0, MF_POPUP);
 //  Separators: array[Boolean] of LongInt = (MF_STRING, MF_SEPARATOR);
 //var
 //  NewFlags: Word;
 //  CCaption: array [0..255] of Char;
 //begin
 //  NewFlags := Breaks[FBreak] or Checks[FChecked] or Enables[FEnabled]
 //              or PopUps[FPopUp] or Separators[FCaption = '-'] or MF_BYPOSITION;
 //  StrPCopy(CCaption, FCaption);
 //  Result := InsertMenu(Menu, Position, NewFlags, GetHandle, CCaption);
 //  FPosInParent := Position;
 //  FParentHandle := Menu;
 //  FAdded := True;
 //end;

Procedure TWxCustomMenuItem.Clear;
Var
    i: Integer;
Begin
  // OList owns it's objects so we free them
    For i := 0 To pred(FItems.Count) Do
        If FItems[i] <> Nil Then
            TWxCustomMenuItem(FItems[i]).Free;
  // then we clear the underlying list
    FItems.Clear;
End;

Procedure TWxCustomMenuItem.Add(AItem: TWxCustomMenuItem; Position: Word);
Begin
    If ItemExists(AItem) Then
    Begin
        Raise EMenuError.Create('Menu inserted twice');
        exit;
    End;

  //  if not AItem.AppendTo(Handle, Position) then
  //  begin
  //    raise EMenuError.Create('Unable insert menu item');
  //    exit;
  //  end;

    If FItems = Nil Then
        FItems := TList.Create;
    FItems.Insert(Position, AItem);
End;

Procedure TWxCustomMenuItem.Remove(AItem: TWxCustomMenuItem);
Begin
    FItems.Remove(AItem);
    If FItems.Count = 0 Then
        IsSubMenu := False;
    AItem.Free;
End;

Function TWxCustomMenuItem.GetItem(Index: Integer): TWxCustomMenuItem;
Begin
    Result := Nil;
    If FItems = Nil Then
        exit;
    Result := FItems[Index];
End;

Procedure TWxCustomMenuItem.SetItem(Index: Integer; Item: TWxCustomMenuItem);
Begin
    TWxCustomMenuItem(FItems[Index]).Free;
    FItems[Index] := Item;
End;

Procedure TWxCustomMenuItem.DefineProperties(Filer: TFiler);

    Function DoWrite: Boolean;
    Begin
        Result := Count > 0;
    End;

Begin
    Filer.DefineBinaryProperty('WxCustomMenuItem', LoadFromStream, SaveToStream, DoWrite);
End;

// it's easier to understand SaveToStream first !!

Procedure TWxCustomMenuItem.LoadFromStream(Stream: TStream);
Var
    c: TwxCustomMenuItemWrapper;
    l: Integer;
    S: String;
Begin
  //Clear;
    While Stream.Position <> Stream.Size Do
    Begin
    // prepare a carrier component
        c := TwxCustomMenuItemWrapper.Create(Nil);
    // read the class of the stored object
    //  first its length
        Stream.Read(l, SizeOf(l));
    //  then the string itself
        SetLength(S, l);
        Stream.Read(S[1], l);
    // look up the class and apply it
        c.Carried := TWxCustomMenuItem(TPersistentClass(FindClass(S)).Create);
        c.Carried.Create(Nil);
    // let Delphi do its magic
        Stream.ReadComponent(c);
    // extract the object and store it in the list
        FItems.Add(c.Carried);
    // dispose of the carrier
        c.Free;
    End;
End;

Procedure TWxCustomMenuItem.SaveToStream(Stream: TStream);
Var
    i: Integer;
    c: TwxCustomMenuItemWrapper;
    l: Integer;
    S: String;
Begin
  // we go backwards to preserve list order when we Load
    For i := 0 To pred(FItems.Count) Do
    Begin
    // prepare a carrier component
        c := TwxCustomMenuItemWrapper.Create(Nil);
    // let it carry your object
        c.Carried := TWxCustomMenuItem(FItems[i]);
    // write the class of the object to be stored
        S := c.Carried.ClassName;
    //  first its Length
        l := Length(S);
        Stream.Write(l, SizeOf(l));
    //  then the string itself
        Stream.Write(S[1], l);
    // let Delphi do it's magic
        Stream.WriteComponent(c);
    // dispose of the carrier
        c.Free;
    End;
End;

Function TWxCustomMenuItem.GetCount: Integer;
Begin
    If FItems = Nil Then
        Result := 0
    Else
        Result := FItems.Count;
End;

 //procedure TWxCustomMenuItem.RedrawItem;
 //const
 //  Breaks: array[TMenuBreak] of Longint = (0, MF_MENUBREAK, MF_MENUBARBREAK);
 //  Checks: array[Boolean] of LongInt = (MF_UNCHECKED, MF_CHECKED);
 //  Enables: array[Boolean] of LongInt = (MF_DISABLED or MF_GRAYED, MF_ENABLED);
 //  PopUps: array[Boolean] of LongInt = (0, MF_POPUP);
 //  Separators: array[Boolean] of LongInt = (MF_STRING, MF_SEPARATOR);
 //var
 //  i, NewFlags: Word;
 //  Item: TWxCustomMenuItem;
 //  CCaption: array [0..255] of Char;

 //begin
 //  NewFlags := Breaks[FBreak] or Checks[FChecked] or Enables[FEnabled]
 //              or PopUps[FPopUp] or Separators[FCaption = '-'] or MF_BYPOSITION;
 //  StrPCopy(CCaption, FCaption);
 //  if not ModifyMenu(FParentHandle, FPosInParent, NewFlags, FHandle, CCaption)
 //  then raise EMenuError.Create('Error modifing menu');
 //end;

 //procedure TWxCustomMenuItem.SetBreak(Value: TMenuBreak);
 //begin
 //  if FBreak <> Value then
 //  begin
 //    FBreak := Value;
 //    if FAdded then RedrawItem;
 //  end;
 //end;

 //procedure TWxCustomMenuItem.SetCaption(Value: string);
 //begin
 //  if FCaption <> Value then
 //  begin
 //    FCaption := Value;
 //    if FAdded then RedrawItem;
 //  end;
 //end;

 // procedure TWxCustomMenuItem.SetChecked(Value: Boolean);
 // begin
 //   if FChecked <> Value then
 //   begin
 //     FChecked := Value;
 //     if FAdded then RedrawItem;
 //   end;
 // end;

 //procedure TWxCustomMenuItem.SetEnabled(Value: Boolean);
 //begin
 //  if FEnabled <> Value then
 //  begin
 //    FEnabled := Value;
 //    if FAdded then RedrawItem;
 //  end;
 //end;

Procedure TWxCustomMenuItem.SetSubMenu(Value: Boolean);
Begin
    If FPopUp <> Value Then
        FPopUp := Value//if FAdded then RedrawItem;
    ;
End;

 //function TWxCustomMenuItem.HandleExists(Menu: HMenu): Boolean;
 //var
 //  i: integer;
 //  AItem: TWxCustomMenuItem;
 //begin
 //  if FItems = nil then
 //  begin
 //    Result := False;
 //    exit;
 //  end else
 //  for i := 0 to FItems.Count - 1 do
 //  begin
 //    AItem := FItems[i];
 //    if (Menu = AItem.FHandle) then
 //    begin
 //      Result := True;
 //      Exit;
 //    end;
 //  end;
 //  Result := False;
 //end;

Function TWxCustomMenuItem.ItemExists(AItem: TWxCustomMenuItem): Boolean;
Var
    i: Integer;
Begin
    If FItems = Nil Then
    Begin
        Result := False;
        exit;
    End
    Else
        For i := 0 To FItems.Count - 1 Do
            If AItem = FItems[i] Then
            Begin
                Result := True;
                Exit;
            End;
    Result := False;
End;

 //function TWxCustomMenuItem.GetItemFromHandle(Menu: HMenu): TWxCustomMenuItem;
 //var
 //  i: integer;
 //  AItem: TWxCustomMenuItem;
 //begin
 //  if FItems = nil then
 //  begin
 //    Result := nil;
 //    exit;
 //  end else
 //  for i := 0 to FItems.Count - 1 do
 //  begin
 //    AItem := FItems[i];
 //    if Menu = AItem.FHandle then
 //    begin
 //      Result := AItem;
 //      exit;
 //    end;
 //  end;
 //  Result := nil;
 //end;

Initialization

    RegisterClasses([TWxCustomMenuItem, TwxCustomMenuItemWrapper]);

Finalization

    UnRegisterClasses([TWxCustomMenuItem, TwxCustomMenuItemWrapper]);

End.
