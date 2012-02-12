{
    This file is part of Dev-C++
    Copyright (c) 2004 Bloodshed Software

    Dev-C++ is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Dev-C++ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Dev-C++; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

Unit CFGData;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, Classes, sysUtils, TypInfo, cfgreg, CFGINI, cfgtypes;
{$ENDIF}
{$IFDEF LINUX}
  Classes, sysUtils, TypInfo, cfgreg, CFGINI, cfgtypes;
{$ENDIF}

Type
    EConfigDataError = Class(Exception);

    TConfigData = Class(TComponent)
    Private
        finiFileName: String; // ini filename
        finiSection: String; // default section of ini file
        fRegKey: String; // root key for registry
        fRegRoot: HKEY; // registry main key

        // options
        fUseRegistry: Boolean; // Save settings to registry
        fboolAsWords: Boolean; // Save boolean values as TRUE/FALSE
        fIgnores: TStrings; // Ignored Properties
        GetReg: TCFGReg;
        GetINI: TCFGINI;

        Procedure SetIni(s: String);
    Public
        Constructor Create(aOwner: TComponent); Override;
        Destructor Destroy; Override;
        Procedure SettoDefaults; Virtual; Abstract;

        Procedure SaveConfigData; Virtual;
        Procedure ReadConfigData; Virtual;

        // load/save windowplacement structure
        Procedure SaveWindowPlacement(Const key: String; value: TWindowPlacement);

        Function LoadWindowPlacement(Const key: String;
            Var Value: TWindowPlacement): Boolean;

        // load/save individual setting
        Procedure SaveSetting(Const key: String;
            Const Entry: String; Const value: String);

        Function LoadSetting(Const key: String;
            Const entry: String): String;

        // load/save boolean setting
        Procedure SaveboolSetting(Const key: String;
            Const entry: String; Const value: Boolean);

        Function LoadboolSetting(Const key: String;
            Const entry: String): Boolean; Overload;
        Function LoadboolSetting(val: Boolean; Const key: String;
            Const entry: String): Boolean; Overload;
        // load/save TCFGOptions
        Procedure SaveObject(obj: TCFGOptions); Virtual;
        Procedure LoadObject(obj: TCFGOptions); Virtual;

        Property BaseRegKey: String Read fRegKey Write fRegKey;
        Property BoolAsWords: Boolean Read fboolAsWords Write fboolAsWords;
        Property INIFile: String Read fINIFileName Write SetIni;
        Property INISection: String Read finiSection Write finiSection;
        Property Root: HKEY Read fRegRoot Write fRegRoot;
        Property UseRegistry: Boolean Read fUseRegistry Write fUseRegistry;
        Property IgnoreProperties: TStrings Read fIgnores Write fIgnores;
    End;

Function ReadBoolString(Value: String): Boolean;
Function GetPropName(Instance: TPersistent; Index: Integer): String;
Function GetPropCount(Instance: TPersistent): Integer;

Const
    boolStr: Array[Boolean] Of String[5] = ('False', 'True');

Implementation

// returns boolean value of passed string

Function ReadBoolString(Value: String): Boolean;
Begin
    result := uppercase(Value) = 'TRUE';
End;

// returns empty TWindowPlacement Record

Function EmptyWinPlace: TWindowPlacement;
Begin
    FillChar(result, Sizeof(TWindowPlacement), #0);
    Result.Length := Sizeof(TWindowPlacement);
End;

//Returns the number of properties of a given object

Function GetPropCount(Instance: TPersistent): Integer;
Var Data: PTypeData;
Begin
    Data := GetTypeData(Instance.Classinfo);
    Result := Data^.PropCount;
End;

//Returns the property name of an instance at a certain index
Function GetPropName(Instance: TPersistent; Index: Integer): String;
Var PropList: PPropList;
    PropInfo: PPropInfo;
    Data: PTypeData;
Begin
    Result := '';
    Data := GetTypeData(Instance.Classinfo);
    GetMem(PropList, Data^.PropCount * Sizeof(PPropInfo));
    Try
        GetPropInfos(Instance.ClassInfo, PropList);
        PropInfo := PropList^[Index];
        Result := PropInfo^.Name;
    Finally
        FreeMem(PropList, Data^.PropCount * Sizeof(PPropInfo));
    End;
End;


{ TConfigData }

Constructor TConfigData.Create(aOwner: TComponent);
Begin
    Inherited Create(aOwner);
    GetINI := TCFGINI.Create(Self);
    GetREG := TCFGREG.Create(Self);
    fUseRegistry := True; // defaultly use the registry to save info
    fRegRoot := HKEY_CURRENT_USER; // default to current user registry
    fIgnores := TStringList.Create;
    With fIgnores Do
    Begin
        Add('Name');
        Add('Tag');
        // local props (might not need)
    End;
End;

Destructor TConfigData.Destroy;
Begin
    GetINI.Free;
    GetREG.Free;
    If Assigned(fIgnores) Then
        fIgnores.Free;
    Inherited Destroy;
End;

{function TConfigData.GetINI: TCFGINI;
begin
  try
   result:= TCFGINI.Create(Self);
  except
   result:= nil;
  end;
end;

function TConfigData.GetReg: TCFGReg;
begin
  try
   result:= TCFGReg.Create(Self);
  except
   result:= nil;
  end;
end;  }

Procedure TConfigData.SetIni(s: String);
Begin
    fIniFileName := s;
    GetINI.SetIniFile(s);
End;

Procedure TConfigData.ReadConfigData;
Begin
    If fUseRegistry Then
        Try
            GetReg.ReadConfig;
        Except End
    Else
        Try
            GetINI.ReadConfig;
        Except End;
End;

Procedure TConfigData.SaveConfigData;
Begin
    If fUseRegistry Then
        Try
            GetReg.SaveConfig;
        Except End
    Else
        Try
            GetINI.SaveConfig;
        Except End;
End;

Function TConfigData.LoadWindowPlacement(Const key: String;
    Var Value: TWindowPlacement): Boolean;

    // convert string to TWindowPlacement record
    Function StrtoWinPlace(s: String): TWindowPlacement;
    Var
        tmp: TSTringList;
    Begin
        If s = '' Then
            result := EmptyWinPlace
        Else
        Begin
            tmp := TStringList.Create;
            Try
                tmp.CommaText := s;
                If tmp.Count = 10 Then
                    With Result Do
                    Begin
                        Length := Sizeof(TWindowPlacement);
                        Flags := StrtoInt(tmp[0]);
                        ShowCmd := StrtoInt(tmp[1]);
                        ptMinPosition := point(StrtoInt(tmp[2]), StrtoInt(tmp[3]));
                        ptMaxPosition := point(StrtoInt(tmp[4]), StrtoInt(tmp[5]));
                        rcNormalPosition := rect(StrtoInt(tmp[6]), StrtoInt(tmp[7]),
                            StrtoInt(tmp[8]), StrtoInt(tmp[9]));
                    End
                Else
                    result := emptyWinPlace;
            Finally
                tmp.Free;
            End;
        End;
    End;

Var
    s: String;
Begin
    Try
        If fUseRegistry Then
            s := GetReg.LoadSetting(key, 'WinPlace')
        Else
            s := GetINI.LoadSetting(key, 'WinPlace');
        value := StrtoWinPlace(s);
        result := True;
    Except
        result := False;
    End;
End;

Procedure TConfigData.SaveWindowPlacement(Const key: String;
    value: TWindowPlacement);

    Function WinPlacetoStr(WinPlace: TWindowPlacement): String;
    Begin
        With WinPlace Do
            Result := format('%d, %d, %d, %d, %d, %d, %d, %d, %d, %d',
                [Flags, ShowCmd, ptMinPosition.X, ptMinPosition.Y,
                ptMaxPosition.X, ptMaxPosition.Y,
                rcNormalPosition.Left, rcNormalPosition.Top,
                rcNormalPosition.Right, rcNormalPosition.Bottom]);
    End;
Var
    s: String;
Begin
    Try
        s := WinPlacetoStr(Value);
        If fUseRegistry Then
            GetReg.SaveSetting(key, 'WinPlace', s)
        Else
            GetINI.SaveSetting(key, 'WinPlace', s);
    Except End;
End;

Procedure TConfigData.LoadObject(obj: TCFGOptions);
Begin
    Try
        If fUseRegistry Then
            GetReg.LoadObject(Obj)
        Else
            GetINI.LoadObject(Obj);
    Except End;
End;

Procedure TConfigData.SaveObject(obj: TCFGOptions);
Begin
    Try
        If fUseRegistry Then
            GetReg.SaveObject(Obj)
        Else
            GetINI.SaveObject(Obj);
    Except End;
End;

Function TConfigData.LoadboolSetting(Const key, entry: String): Boolean;
Var
    s: String;
Begin
    Try
        If fUseRegistry Then
            s := GetReg.LoadSetting(Key, Entry)
        Else
            s := GetINI.LoadSetting(key, Entry);

        If s = '' Then
            s := '0';
        If fboolAsWords Then
            result := ReadboolString(s)
        Else
            result := strtoint(s) = 1;
    Except
        result := False;
    End;
End;

Function TConfigData.LoadboolSetting(val: Boolean;
    Const key, entry: String): Boolean;
Var
    s: String;
Begin
    Try
        If fUseRegistry Then
            s := GetReg.LoadSetting(val, Key, Entry)
        Else
            s := GetINI.LoadSetting(val, key, Entry);

        If s = '' Then
            s := '0';
        If fboolAsWords Then
            result := ReadboolString(s)
        Else
            result := strtoint(s) = 1;
    Except
        result := False;
    End;
End;

Function TConfigData.LoadSetting(Const key, entry: String): String;
Begin
    Try
        If fUseRegistry Then
            result := GetReg.LoadSetting(key, Entry)
        Else
            result := GetINI.LoadSetting(key, Entry);
    Except End;
End;

Procedure TConfigData.SaveSetting(Const key: String; Const Entry: String;
    Const value: String);
Begin
    Try
        If fUseRegistry Then
            GetReg.SaveSetting(key, Entry, Value)
        Else
            GetINI.SaveSetting(key, Entry, Value);
    Except End;
End;

Procedure TConfigData.SaveboolSetting(Const key: String; Const entry: String;
    Const value: Boolean);
Var
    s: String;
Begin
    Try
        If fBoolAsWords Then
            s := boolStr[value]
        Else
            s := inttostr(ord(value));

        If fUseRegistry Then
            GetReg.SaveSetting(key, Entry, s)
        Else
            GetINI.SaveSetting(key, Entry, s);
    Except End;
End;

End.
