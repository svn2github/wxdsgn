{***********************************************************************}
{ $Id$                                                                  }
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

unit wxCustomMenuItem;

interface

uses Forms, WinProcs, WinTypes, SysUtils, Menus, Classes, Messages, wxutils, Graphics;

type
  EMenuError = class(Exception);
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

  TWxCustomMenuItem = class(TPersistent)
  private
    FEVT_Menu: string;
    FEVT_UPDATE_UI: string;
    FWx_Class: string;
    FWx_Enabled: boolean;
    FWx_HelpText: string;
    FWx_Hidden: boolean;
    FWx_Name: string;
    FWx_IDName: string;
    FWx_IDValue: longint;
    FWx_ToolTip: string;
    FMenuItemStyle: TWxMenuItemStyleItem;
    FWx_Caption: string;
    FWx_Checked: boolean;
    FWX_BITMAP: TPicture;
    FWx_Comments: TStrings;
    FWx_FileHistory: boolean;
    FItems: TList;
    FAdded: boolean;
    //FParentHandle: HMENU;
    //FPosInParent: integer;
    //FBreak: TMenuBreak;
    FPopUp, FEnabled: boolean;
    //FCaption: string;
    //FHandle: HMENU;
    FOnClick: TNotifyEvent;
    //function AppendTo(Menu: HMENU; Position: Word): Boolean;
    //procedure RedrawItem;
    //procedure SetBreak(Value: TMenuBreak);
    //procedure SetCaption(Value: string);
    //procedure SetChecked(Value: Boolean);
    //procedure SetEnabled(Value: Boolean);
    procedure SetSubMenu(Value: boolean);
  protected
    //function HandleExists(Menu: HMENU): Boolean;
    //function GetHandle: HMENU; virtual;
    function ItemExists(AItem: TWxCustomMenuItem): boolean;
    function GetCount: integer;
    procedure Click(Sender: TObject); virtual;
    function GetItem(Index: integer): TWxCustomMenuItem;
    procedure SetItem(Index: integer; Item: TWxCustomMenuItem);
    //function GetItemFromHandle(Menu: HMenu): TWxCustomMenuItem;
  public
    //property Handle: HMenu read GetHandle;
    property Count: integer Read GetCount;
    constructor Create(owner: TComponent); virtual;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(AItem: TWxCustomMenuItem; Position: word);
    procedure Remove(AItem: TWxCustomMenuItem);
    property Items[Index: integer]: TWxCustomMenuItem Read GetItem Write SetItem;
      default;
    procedure DefineProperties(Filer: TFiler); override;
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);

  published
    //    property Break: TMenuBreak read FBreak write SetBreak default mbNone;
    //    property Caption: string read FCaption write SetCaption;
    //    property Checked: Boolean read FChecked write SetChecked default False;
    //    property Enabled: Boolean read FEnabled write SetEnabled default True;

    property IsSubMenu: boolean Read FPopUp Write SetSubMenu;
    property OnClick: TNotifyEvent Read FOnClick Write FOnClick;

    property EVT_Menu: string Read FEVT_Menu Write FEVT_Menu;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;

    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden;
    property Wx_Name: string Read FWx_Name Write FWx_Name;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;
    property Wx_MenuItemStyle: TWxMenuItemStyleItem
      Read FMenuItemStyle Write FMenuItemStyle;
    property Wx_Caption: string Read FWx_Caption Write FWx_Caption;
    property Wx_Checked: boolean Read FWx_Checked Write FWx_Checked;
    property WX_BITMAP: TPicture Read FWX_BITMAP Write FWX_BITMAP;
    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;

    property Wx_Items: TList Read FItems Write FItems;
    property Wx_FileHistory: boolean Read FWx_FileHistory Write FWx_FileHistory;

  end;

  TwxCustomMenuItemWrapper = class(TComponent)
  private
    FCarried: TWxCustomMenuItem;
  published
    property Carried: TWxCustomMenuItem Read FCarried Write FCarried;
  end;


implementation

{TWxCustomMenuItem}
constructor TWxCustomMenuItem.Create(owner: TComponent);
begin
  FEnabled    := True;
  FPopUp      := False;
  FAdded      := False;
  FWX_BITMAP  := TPicture.Create;
  FItems      := TList.Create;
  FWx_Enabled := True;
  FWx_FileHistory := false;
  inherited Create;
end;

destructor TWxCustomMenuItem.Destroy;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    TWxCustomMenuItem(FItems[I]).Destroy;
  FItems.Destroy;
  FWX_BITMAP.Destroy;
  inherited Destroy;
end;

procedure TWxCustomMenuItem.Click(Sender: TObject);
begin
  if Assigned(FOnClick) then
    FOnClick(Self);
end;

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

procedure TWxCustomMenuItem.Clear;
var
  i: integer;
begin
  // OList owns it's objects so we free them
  for i := 0 to pred(FItems.Count) do
    if FItems[i] <> nil then
      TWxCustomMenuItem(FItems[i]).Free;
  // then we clear the underlying list
  FItems.Clear;
end;

procedure TWxCustomMenuItem.Add(AItem: TWxCustomMenuItem; Position: word);
begin
  if ItemExists(AItem) then
  begin
    raise EMenuError.Create('Menu inserted twice');
    exit;
  end;

  //  if not AItem.AppendTo(Handle, Position) then
  //  begin
  //    raise EMenuError.Create('Unable insert menu item');
  //    exit;
  //  end;

  if FItems = nil then
    FItems := TList.Create;
  FItems.Insert(Position, AItem);
end;

procedure TWxCustomMenuItem.Remove(AItem: TWxCustomMenuItem);
begin
  FItems.Remove(AItem);
  if FItems.Count = 0 then
    IsSubMenu := False;
  AItem.Free;
end;

function TWxCustomMenuItem.GetItem(Index: integer): TWxCustomMenuItem;
begin
   Result := nil;
  if FItems = nil then
    exit;
  Result := FItems[Index];
end;

procedure TWxCustomMenuItem.SetItem(Index: integer; Item: TWxCustomMenuItem);
begin
  TWxCustomMenuItem(FItems[Index]).Free;
  FItems[Index] := Item;
end;

procedure TWxCustomMenuItem.DefineProperties(Filer: TFiler);

  function DoWrite: boolean;
  begin
    Result := Count > 0;
  end;

begin
  Filer.DefineBinaryProperty('WxCustomMenuItem', LoadFromStream, SaveToStream, DoWrite);
end;

// it's easier to understand SaveToStream first !!

procedure TWxCustomMenuItem.LoadFromStream(Stream: TStream);
var
  c: TwxCustomMenuItemWrapper;
  l: integer;
  S: string;
begin
  //Clear;
  while Stream.Position <> Stream.Size do
  begin
    // prepare a carrier component
    c := TwxCustomMenuItemWrapper.Create(nil);
    // read the class of the stored object
    //  first its length
    Stream.Read(l, SizeOf(l));
    //  then the string itself
    SetLength(S, l);
    Stream.Read(S[1], l);
    // look up the class and apply it
    c.Carried := TWxCustomMenuItem(TPersistentClass(FindClass(S)).Create);
    c.Carried.Create(nil);
    // let Delphi do its magic
    Stream.ReadComponent(c);
    // extract the object and store it in the list
    FItems.Add(c.Carried);
    // dispose of the carrier
    c.Free;
  end;
end;

procedure TWxCustomMenuItem.SaveToStream(Stream: TStream);
var
  i: integer;
  c: TwxCustomMenuItemWrapper;
  l: integer;
  S: string;
begin
  // we go backwards to preserve list order when we Load
  for i := 0 to pred(FItems.Count) do
  begin
    // prepare a carrier component
    c := TwxCustomMenuItemWrapper.Create(nil);
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
  end;
end;

function TWxCustomMenuItem.GetCount: integer;
begin
  if FItems = nil then
    Result := 0
  else
    Result := FItems.Count;
end;

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

procedure TWxCustomMenuItem.SetSubMenu(Value: boolean);
begin
  if FPopUp <> Value then
    FPopUp := Value//if FAdded then RedrawItem;
  ;
end;

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

function TWxCustomMenuItem.ItemExists(AItem: TWxCustomMenuItem): boolean;
var
  i: integer;
begin
  if FItems = nil then
  begin
    Result := False;
    exit;
  end
  else
    for i := 0 to FItems.Count - 1 do
      if AItem = FItems[i] then
      begin
        Result := True;
        Exit;
      end;
  Result := False;
end;

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

initialization

  RegisterClasses([TWxCustomMenuItem, TwxCustomMenuItemWrapper]);

finalization

  UnRegisterClasses([TWxCustomMenuItem, TwxCustomMenuItemWrapper]);

end.
