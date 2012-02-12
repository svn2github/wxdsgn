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

Unit CFGINI;

Interface

Uses
    Classes, IniFiles, cfgTypes, TypInfo;

Type
    TCFGINI = Class(TObject)
    Private
        fOwner: TComponent; // assumes a TConfigData
        fini: Tinifile;
        Procedure ReadFrominifile(Obj: TPersistent; Const Section: String);
        Procedure ReadObject(Const Name: String; Obj: TPersistent);
        Function ReadSet(Const Name: String; TypeInfo: PTypeInfo): Integer;
        Procedure ReadStrings(Const Name: String; value: TStrings);
        Procedure WriteObject(Const Name: String; Obj: TPersistent);
        Procedure WriteSet(Const Name: String; value: Integer;
            TypeInfo: PTypeInfo);
        Procedure WriteStrings(Const Name: String; value: TStrings);
        Procedure Writetoinifile(Const Section: String; Obj: TPersistent);
        Procedure ClearSection(Const Name: String);
    Public
        Constructor Create(aOwner: TComponent);
        Destructor Destroy; Override;

        Procedure SetIniFile(s: String);
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
    CFGData, SysUtils, Graphics;
{$ENDIF}
{$IFDEF LINUX}
  CFGData, SysUtils, QGraphics;
{$ENDIF}

{ TCFGINI }

Constructor TCFGINI.Create(aOwner: TComponent);
Begin
    fOwner := aOwner;
    fIni := Nil;
End;

Destructor TCFGINI.Destroy;
Begin
    If (assigned(fIni)) Then
        fini.free;
    Inherited;
End;

Procedure TCFGIni.SetIniFile(s: String);
Begin
    If (assigned(fIni)) Then
        fini.free;
    fini := TIniFile.Create(s);
End;

Procedure TCFGINI.ReadConfig;
Var
    section: String;
Begin
    If Not assigned(fIni) Then
        exit;
    section := TConfigData(fOwner).INISection;
    If section = '' Then
        Raise EConfigDataError.Create('(ConfigData(INIReadCFG): Section not set');
    Try
        ReadFromINIFile(fOwner, Section);
    Except End;
End;

Procedure TCFGINI.SaveConfig;
Var
    section: String;
Begin
    If Not assigned(fIni) Then
        exit;
    section := TConfigData(fOwner).INISection;
    If section = '' Then
        Raise EConfigDataError.Create('(ConfigData(INISaveCFG): Section not set');
    With fINI Do
        Try
            WritetoINIfile(Section, fOwner);
        Except End;
End;

// Reading methods

Function TCFGINI.ReadSet(Const Name: String; TypeInfo: PTypeInfo): Integer;
Var
    idx: Integer;
    value: Integer;
Begin
    result := 0;
    If Not assigned(fIni) Then
        exit;
    TypeInfo := GetTypeData(TypeInfo).CompType^;
    value := 0;
    If fINI.SectionExists(Name) Then
        With GetTypeData(TypeInfo)^ Do
            For idx := MinValue To MaxValue Do
                If ReadBoolString(fini.ReadString(Name, GetENumName(TypeInfo, idx),
                    'FALSE')) Then
                    include(TIntegerSet(value), idx);
    result := value;
End;

Procedure TCFGINI.ReadStrings(Const Name: String; value: TStrings);
Begin
    Value.BeginUpdate;
    Try
        Value.Clear;
        If fini.SectionExists(Name) Then
            fini.ReadSectionValues(Name, value);
    Finally
        Value.EndUpdate;
    End;
End;

Procedure TCFGINI.ReadObject(Const Name: String; Obj: TPersistent);
Begin
    If fini.SectionExists(Name) Then
        ReadFromINIFile(Obj, Name);
End;

Procedure TCFGINI.ReadFrominifile(Obj: TPersistent; Const Section: String);
Var
    idx, idx2: Integer;
    PropName: String;
    Cd: TConfigData;
Begin
    CD := TConfigData(fOwner);
    For idx := 0 To pred(GetPropCount(Obj)) Do
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
        If (CD.IgnoreProperties.Indexof(PropName) > -1) Or
            ((Not fINI.ValueExists(Section, PropName)) And
            (Not fINI.SectionExists(Section + '.' + PropName))) Then
            continue;

        Case PropType(Obj, PropName) Of
            tkString,
            tkLString,
            tkWString:
                SetStrProp(Obj, PropName, fINI.ReadString(Section, PropName, ''));

            tkChar,
            tkEnumeration,
            tkInteger:
                SetOrdProp(Obj, PropName, fINI.ReadInteger(Section, PropName, 1));

            tkInt64:
                SetInt64Prop(Obj, PropName, StrtoInt(fINI.ReadString(Section, PropName, '0')));

            tkFloat:
                SetFloatProp(Obj, PropName,
                    StrtoFloat(fINI.ReadString(Section, PropName, '0.0')));

            tkSet:
                SetOrdProp(Obj, PropName, ReadSet(Section + '.' + PropName,
                    GetPropInfo(Obj, PropName, [tkSet])^.PropType^));

            tkClass:
            Begin
                If TPersistent(GetOrdProp(Obj, PropName)) Is TStrings Then
                    ReadStrings(Section + '.' + PropName,
                        TStrings(GetOrdProp(Obj, PropName)))
                Else
                    ReadObject(Section + '.' + PropName,
                        TPersistent(GetOrdProp(Obj, PropName)));
            End;
        End;
    End;
End;

// Writing Methods

Procedure TCFGINI.WriteSet(Const Name: String; value: Integer;
    TypeInfo: PTypeInfo);
Var
    idx: Integer;
    s: String;
Begin
    TypeInfo := GetTypeData(TypeInfo).CompType^;
    ClearSection(Name);
    With GetTypeData(TypeInfo)^ Do
        For idx := MinValue To MaxValue Do
        Begin
            s := GetENumName(TypeInfo, idx);
            If fINI.ValueExists(Name, s) Then
                fini.DeleteKey(Name, s);
            fINI.WriteString(Name, s, boolStr[idx In TIntegerSet(value)]);
        End;
End;

Procedure TCFGINI.WriteStrings(Const Name: String; value: TStrings);
Var
    idx: Integer;
Begin
    ClearSection(Name);
    If value.count <= 0 Then
        exit;
    For idx := 0 To Pred(value.Count) Do
        If AnsiPos('=', value[idx]) <> 0 Then
            fini.WriteString(Name, Value.Names[idx], value.Values[Value.Names[idx]])
        Else
            fini.WriteString(Name, Value[idx], '');
End;

Procedure TCFGINI.WriteObject(Const Name: String; Obj: TPersistent);

    Function WritetheObject(Obj: TPersistent): Boolean;
    Var
        idx, c, Count: Integer;
    Begin
        result := False;
        Count := GetPropCount(Obj);
        If Count <= 0 Then
            exit;
        c := Count;
        For idx := 0 To pred(Count) Do
        Begin
            If TConfigData(fOwner).IgnoreProperties.Indexof(
                getPropName(Obj, idx)) <> -1 Then
                dec(c);
        End;
        result := c > 0;
    End;
Begin
    If Not WritetheObject(Obj) Then
        exit;
    ClearSection(Name);
    WritetoINIFile(Name, Obj);
End;

Procedure TCFGINI.Writetoinifile(Const Section: String; Obj: TPersistent);
Var
    idx,
    idx2: Integer;
    PropName: String;
    CD: TConfigData;
Begin
    CD := TConfigData(fOwner);
    For idx := 0 To pred(GetPropCount(Obj)) Do
    Begin
        PropName := GetPropName(Obj, idx);
        If Obj Is TFont Then
        Begin
            idx2 := CD.IgnoreProperties.Indexof('Name');
            If idx2 > -1 Then
                CD.IgnoreProperties[idx2] := 'Height';
        End
        Else
        Begin
            idx2 := CD.IgnoreProperties.Indexof('Height');
            If idx2 > -1 Then
                CD.IgnoreProperties[idx2] := 'Name';
        End;
        If CD.IgnoreProperties.Indexof(PropName) >= 0 Then
            continue;
        Case PropType(Obj, PropName) Of
            tkString,
            tkLString,
            tkWString:
                fINI.WriteString(Section, PropName, '"' + GetStrProp(Obj, PropName) + '"');
            // 11 Jul 2002: mandrav: added double quotes around strings.
            // fixes a bug with stringlists comma-text saved as string...

            tkChar,
            tkEnumeration,
            tkInteger:
                fINI.WriteInteger(Section, PropName, GetOrdProp(Obj, PropName));

            tkInt64:
                fINI.WriteString(Section, PropName, InttoStr(GetInt64Prop(Obj, PropName)));

            tkFloat:
                fINI.WriteString(Section, PropName, FloattoStr(GetFloatProp(Obj, PropName)));

            tkSet:
                WriteSet(Section + '.' + PropName, GetOrdProp(Obj, PropName),
                    GetPropInfo(Obj, PropName, [tkSet])^.PropType^);
            tkClass:
            Begin
                If TPersistent(GetOrdProp(Obj, PropName)) Is TStrings Then
                    WriteStrings(Section + '.' + PropName,
                        TStrings(GetOrdProp(Obj, PropName)))
                Else
                    WritetoINIFile(Section + '.' + PropName,
                        TPersistent(GetOrdProp(Obj, PropName)));
            End;
        End;
    End;
End;

Procedure TCFGINI.LoadObject(Var Obj: TCFGOptions);
Begin
    If Not assigned(Obj) Then
        exit;
    Try
        ReadObject(Obj.Name, Obj);
    Except End;
End;

Function TCFGINI.LoadSetting(Const key, Entry: String): String;
Begin
    If Entry = '' Then
        exit;
    result := fini.ReadString(Key, Entry, '');
End;

Function TCFGINI.LoadSetting(val: Boolean; Const key, Entry: String): String;
Begin
    If Entry = '' Then
        exit;
    result := fini.ReadString(Key, Entry, '');
    If result = '' Then
    Begin
        If val Then
            result := '1'
        Else
            result := '0';
    End;
End;

Procedure TCFGINI.SaveObject(Var Obj: TCFGOptions);
Begin
    If Not assigned(Obj) Then
        exit;
    WriteObject(Obj.Name, Obj);
End;

Procedure TCFGINI.SaveSetting(Const key, entry, value: String);
Begin
    If Entry = '' Then
        exit;
    fini.WriteString(Key, Entry, Value);
End;

Procedure TCFGINI.ClearSection(Const Name: String);
//var
// tmp: TStrings;
// idx: integer;
Begin
    // This way it's much easier...
    If fini.SectionExists(Name) Then
        fini.EraseSection(Name);
    //  tmp:= TStringList.Create;
    //  try
    //   fini.ReadSectionValues(Name, tmp);
    //   if tmp.Count> 0 then
    //    for idx:= 0 to pred(tmp.Count) do
    //     fini.DeleteKey(Name, tmp[idx]);
    //  finally
    //   tmp.Free;
    //  end;
End;

End.
