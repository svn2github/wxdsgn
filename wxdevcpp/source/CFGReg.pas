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

Unit CFGReg;

Interface

Uses
{$IFDEF WIN32}
    Classes, Registry, Types, TypInfo, cfgTypes;
{$ENDIF}
{$IFDEF LINUX}
  Classes, Types, TypInfo, cfgTypes;
{$ENDIF}

Type
    TCFGReg = Class(TObject)
    Private
        fOwner: TComponent; // assumes a TConfigData
        fReg: TRegistry;
        Procedure ReadFromRegistry(Obj: TPersistent);
        Procedure ReadObject(Const Name: String; Obj: TPersistent);
        Function ReadSet(Const Name: String; TypeInfo: PTypeInfo): Integer;
        Procedure ReadStrings(Const Name: String; value: TStrings);
        Procedure WriteObject(Const Name: String; Obj: TPersistent);
        Procedure WriteSet(Const Name: String; value: Integer;
            TypeInfo: PTypeInfo);
        Procedure WriteStrings(Const Name: String; value: TStrings);
        Procedure WritetoRegistry(Obj: TPersistent); // Registry access object;
    Public
        Constructor Create(aOwner: TComponent);
        Destructor Destroy; Override;
        Procedure ReadConfig;
        Procedure SaveConfig;

        Procedure LoadObject(Var Obj: TCFGOptions);
        Procedure SaveObject(Var Obj: TCFGOptions);

        Function LoadSetting(Const key: String; Const Entry: String): String;
            Overload;
        Function LoadSetting(val: Boolean; Const key, Entry: String): String;
            Overload;
        Procedure SaveSetting(Const key: String; Const entry: String;
            Const value: String);
    End;

Implementation

Uses
{$IFDEF WIN32}
    CFGData, Graphics, SysUtils;
{$ENDIF}
{$IFDEF LINUX}
  CFGData, QGraphics, SysUtils;
{$ENDIF}

{ TCFGReg }

Constructor TCFGReg.Create(aOwner: TComponent);
Begin
    fOwner := aOwner;
    fReg := TRegistry.Create;
End;

Destructor TCFGReg.Destroy;
Begin
    If Assigned(fReg) Then
        fReg.Free;
    Inherited;
End;

Procedure TCFGReg.ReadConfig;
Var
    RegKey: String;
Begin
    RegKey := TConfigData(fOwner).BaseRegKey;
    If RegKey = '' Then
        Raise EConfigDataError.Create('ConfigData: Registry Key not set.');
    With fReg Do
        Try
            RootKey := TConfigData(fOwner).Root;
            If OpenKey(RegKey, False) Then
                ReadFromRegistry(fOwner);
        Finally
            CloseKey;
        End;
End;

Procedure TCFGReg.SaveConfig;
Var
    RegKey: String;
Begin
    RegKey := TConfigData(fOwner).BaseRegKey;
    If RegKey = '' Then
        Raise EConfigDataError.Create('ConfigData: Registry Key not set.');
    With fReg Do
        Try
            RootKey := TConfigData(fOwner).Root;
            If OpenKey(RegKey, False) Then
                WritetoRegistry(fOwner);
        Finally
            CloseKey;
        End;
End;

// Reading methods

Procedure TCFGReg.ReadFromRegistry(Obj: TPersistent);
Var
    idx,
    idx2,
    Count: Integer;
    PropName: String;
    CD: TConfigData;
Begin
    Count := GetPropCount(Obj);
    CD := TConfigData(fOwner);
    For idx := 0 To pred(Count) Do
    Begin
        PropName := GetPropName(Obj, idx);
        If Obj Is TFont Then
        Begin
            idx2 := CD.IgnoreProperties.Indexof('Name');
            If idx2 <> -1 Then
                CD.IgnoreProperties[idx2] := 'Height';
        End
        Else
        Begin
            idx2 := CD.IgnoreProperties.Indexof('Height');
            If idx2 <> -1 Then
                CD.IgnoreProperties[idx2] := 'Name';
        End;

        If (CD.IgnoreProperties.Indexof(PropName) > -1)
            Or (Not fReg.ValueExists(PropName)) Then
            continue;

        Case PropType(Obj, PropName) Of
            tkString,
            tkLString,
            tkWString:
                SetStrProp(Obj, PropName, fReg.ReadString(PropName));

            tkChar,
            tkEnumeration,
            tkInteger:
                SetOrdProp(Obj, PropName, fReg.ReadInteger(PropName));

            tkInt64:
                SetInt64Prop(Obj, PropName, StrtoInt(fReg.ReadString(PropName)));

            tkFloat:
                SetFloatProp(Obj, PropName, StrtoFloat(fReg.ReadString(PropName)));

            tkSet:
                SetOrdProp(Obj, PropName, ReadSet(PropName,
                    GetPropInfo(Obj, PropName, [tkSet])^.PropType^));

            tkClass:
            Begin
                If TPersistent(GetOrdProp(Obj, PropName)) Is TStrings Then
                    ReadStrings(PropName, TStrings(GetOrdProp(Obj, PropName)))
                Else
                    ReadObject(PropName, TPersistent(GetOrdProp(Obj, PropName)));
            End;
        End;
    End;
End;

Function TCFGReg.ReadSet(Const Name: String; TypeInfo: PTypeInfo): Integer;
Var
    OldKey: String;
    idx: Integer;
    value: Integer;
Begin
    TypeInfo := GetTypeData(TypeInfo).CompType^;
    OldKey := '\' + fReg.CurrentPath;
    value := 0;
    Try
        If Not freg.OpenKey(Name, False) Then
            Raise ERegistryException.Createfmt(
                'ConfigData(RegReadSet): Cannot read subkey %s', [Name]);

        With GetTypeData(TypeInfo)^ Do
            For idx := MinValue To MaxValue Do
                If ReadBoolString(fReg.ReadString(GetENumName(TypeInfo, idx))) Then
                    include(TIntegerSet(value), idx);
    Finally
        result := value;
        fReg.OpenKey(OldKey, False);
    End;
End;

Procedure TCFGREg.ReadStrings(Const Name: String; value: TStrings);
Var
    OldKey: String;
Begin
    value.BeginUpdate;
    OldKey := '\' + fReg.CurrentPath;
    Try
        value.Clear;
        If Not fReg.OpenKey(Name, False) Then
            Raise ERegistryException.Createfmt(
                'ConfigData(RegReadStrings): Cannot open subkey %s', [Name]);

        fReg.GetValueNames(value);
    Finally
        value.EndUpdate;
        fReg.OpenKey(OldKey, False);
    End;
End;

Procedure TCFGReg.ReadObject(Const Name: String; Obj: TPersistent);
Var
    OldKey: String;
Begin
    OldKey := '\' + fReg.CurrentPath;
    Try
        If fReg.OpenKey(Name, False) Then
            ReadFromRegistry(Obj);
    Finally
        fReg.OpenKey(Oldkey, False);
    End;
End;

// Writing Methods

Procedure TCFGReg.WritetoRegistry(Obj: TPersistent);
Var
    idx,
    idx2,
    Count: Integer;
    PropName: String;
    CD: TConfigData;
Begin
    Count := GetPropCount(Obj);
    CD := TConfigData(fOwner);

    For idx := 0 To pred(Count) Do
    Begin
        PropName := GetPropName(Obj, idx);
        If Obj Is TFont Then
        Begin
            idx2 := CD.IgnoreProperties.Indexof('Name');
            If idx2 <> -1 Then
                CD.IgnoreProperties[idx2] := 'Height';
        End
        Else
        Begin
            idx2 := CD.IgnoreProperties.Indexof('Height');
            If idx2 <> -1 Then
                CD.IgnoreProperties[idx2] := 'Name';
        End;

        If (CD.IgnoreProperties.Indexof(PropName) > -1) Then
            continue;
        Case PropType(Obj, PropName) Of
            tkString,
            tkLString,
            tkWString:
                fReg.WriteString(PropName, GetStrProp(Obj, PropName));

            tkChar,
            tkEnumeration,
            tkInteger:
                fReg.WriteInteger(PropName, GetOrdProp(Obj, PropName));

            tkInt64:
                fReg.WriteString(PropName, InttoStr(GetInt64Prop(Obj, PropName)));

            tkFloat:
                fReg.WriteString(PropName, FloattoStr(GetFloatProp(Obj, PropName)));

            tkSet:
                WriteSet(PropName, GetOrdProp(Obj, PropName),
                    GetPropInfo(Obj, PropName, [tkSet])^.PropType^);

            tkClass:
            Begin
                If TPersistent(GetOrdProp(Obj, PropName)) Is TStrings Then
                    WriteStrings(PropName, TStrings(GetOrdProp(Obj, PropName)))
                Else
                    WriteObject(PropName, TPersistent(GetOrdProp(Obj, PropName)));
            End;
        End;
    End;
End;

Procedure TCFGReg.WriteSet(Const Name: String; value: Integer;
    TypeInfo: PTypeInfo);
Var
    OldKey: String;
    idx: Integer;
Begin
    TypeInfo := GetTypeData(TypeInfo)^.CompType^;
    OldKey := '\' + fReg.CurrentPath;
    Try
        If Not fReg.OpenKey(Name, True) Then
            Raise ERegistryException.Createfmt(
                'ConfigData(RegSaveSet): Cannot create subkey %s', [name]);

        With GetTypeData(TypeInfo)^ Do
            For idx := MinValue To MaxValue Do
                fReg.WriteString(GetENumName(TypeInfo, idx),
                    boolStr[idx In TIntegerSet(value)]);
    Finally
        fReg.OpenKey(OldKey, False);
    End;
End;

Procedure TCFGReg.WriteStrings(Const Name: String; value: TStrings);
Var
    OldKey: String;
    idx: Integer;
Begin
    If value.Count <= 0 Then
        exit;
    OldKey := '\' + fReg.CurrentPath;
    Try
        If Not fReg.OpenKey(Name, True) Then
            Raise ERegistryException.Createfmt(
                'ConfigData(RegSaveStrings): Cannot create %s', [name]);

        For idx := 0 To pred(value.Count) Do
            fReg.WriteString(value[idx], '');
    Finally
        fReg.OpenKey(OldKey, False);
    End;
End;

Procedure TCFGReg.WriteObject(Const Name: String; Obj: TPersistent);

    Function WritetheObject(Obj: TPersistent): Boolean;
    Var
        idx, c, Count: Integer;
    Begin
        result := False;
        If Not assigned(Obj) Then
            exit;
        Count := GetPropCount(Obj);
        If Count <= 0 Then
            exit;
        c := Count;
        For idx := 0 To pred(Count) Do
            If TConfigData(fOwner).IgnoreProperties.Indexof(
                GetPropName(Obj, idx)) > -1 Then
                dec(c);

        result := c > 0;
    End;

Var
    OldKey: String;
Begin
    If Not WritetheObject(Obj) Then
        exit;
    OldKey := '\' + fReg.CurrentPath;
    Try
        If Not fReg.OpenKey(Name, True) Then
            Raise  ERegistryException.Createfmt(
                '(ConfigData(RegSaveObj): Cannot create %s', [name]);

        WritetoRegistry(Obj);
    Finally
        fReg.OpenKey(OldKey, False);
    End;
End;

// Public access methods

Function TCFGReg.LoadSetting(Const key, Entry: String): String;
Var
    OldKey: String;
Begin
    OldKey := '\' + fReg.CurrentPath;
    Try
        If fReg.OpenKey(Key, False) Then
            result := fReg.ReadString(Entry)
        Else
            result := '';
    Finally
        fReg.OpenKey(Oldkey, False);
    End;
End;

Function TCFGReg.LoadSetting(val: Boolean; Const key, Entry: String): String;
Var
    OldKey: String;
Begin
    OldKey := '\' + fReg.CurrentPath;
    Try
        If fReg.OpenKey(Key, False) Then
            result := fReg.ReadString(Entry)
        Else
        Begin
            If val Then
                result := '1'
            Else
                result := '';
        End
    Finally
        fReg.OpenKey(Oldkey, False);
    End;
End;

Procedure TCFGReg.LoadObject(Var Obj: TCFGOptions);
Var
    OldKey: String;
Begin
    Oldkey := '\' + fReg.CurrentPath;
    Try
        ReadObject(Obj.Name, Obj);
    Finally
        fReg.OpenKey(Oldkey, False);
    End;
End;

Procedure TCFGReg.SaveObject(Var Obj: TCFGOptions);
Var
    OldKey: String;
Begin
    If Not assigned(Obj) Then
        exit;
    Oldkey := '\' + fReg.CurrentPath;
    Try
        WriteObject(Obj.Name, Obj);
    Finally
        fReg.OpenKey(Oldkey, False);
    End;
End;

Procedure TCFGReg.SaveSetting(Const key, entry, value: String);
Var
    Oldkey: String;
Begin
    OldKey := '\' + fReg.CurrentPath;
    Try
        If fReg.OpenKey(Key, True) Then
            fReg.WriteString(Entry, Value);
    Finally
        fReg.OpenKey(OldKey, False);
    End;
End;

End.
