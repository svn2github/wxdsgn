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

Unit oysUtils;

Interface

Uses
    Classes;

Type
    ToysStringList = Class(TStringList)
    Private
        Function GetValues(index: Integer): String;
        Procedure SetValues(index: Integer; Value: String);
        Function GetName(index: Integer): String;
        Procedure SetName(index: Integer; Value: String);
        Function GetValue(Name: String): String;
        Procedure SetValue(Name: String; Value: String);
    Public
        Procedure Appendfmt(s: String; Const args: Array Of Const);
        Function IndexofValue(Value: String): Integer;
        Function Addfmt(s: String; Const args: Array Of Const): Integer;
        Property Values[index: Integer]: String Read GetValues Write SetValues;
        Property Value[Name: String]: String Read GetValue Write SetValue;
        Property Names[index: Integer]: String Read GetName Write SetName;
    End;

Function ReadBoolStr(Value: String): Boolean;

Const
    BoolStr: Array[Boolean] Of String = ('False', 'True');
Implementation

Uses
    SysUtils;

Function ReadBoolStr(Value: String): Boolean;
Begin
    result := uppercase(Value) = 'TRUE';
End;

{ ToysStringList }

//Indexof function for Values in TStringList
Function ToysStringList.IndexofValue(Value: String): Integer;
Var
    s: String;
    p: Integer;
Begin
    For Result := 0 To pred(Count) Do
    Begin
        s := Get(Result);
        p := ansipos('=', s);
        If (p <> 0) And
            (CompareStrings(Copy(s, p + 1, length(s)), Value) = 0) Then
            exit;
    End;
    result := -1;
End;

Procedure ToysStringList.SetValues(index: Integer; Value: String);
Var
    s: String;
    p: Integer;
Begin
    If (index >= 0) And (index < Count) Then
    Begin
        s := Get(index);
        p := ansipos('=', s);
        If (p <> 0) Then
            s := copy(s, 1, p + 1) + Value
        Else
            s := s + '=' + value;
        Put(index, s);
    End
    Else
        Raise EListError.Createfmt('Module List SetValue index out of range: %d',
            [index]);
End;

Function ToysStringList.GetValues(index: Integer): String;
Var
    s: String;
    p: Integer;
Begin
    If (index >= 0) And (index < Count) Then
    Begin
        s := Get(index);
        p := ansipos('=', s);
        If (p <> 0) Then
            result := Copy(s, p + 1, length(s))
        Else
            result := '';
    End
    Else
        Raise EListError.CreateFmt('Module List GetValue index out of range: %d',
            [index]);
End;

Function ToysStringList.GetValue(Name: String): String;
Var
    I: Integer;
Begin
    I := IndexOfName(Name);
    If I >= 0 Then
        Result := Copy(Get(I), Length(Name) + 2, MaxInt) Else
        Result := '';
End;

Procedure ToysStringList.SetValue(Name, Value: String);
Var
    I: Integer;
Begin
    I := IndexOfName(Name);
    If Value <> '' Then
    Begin
        If I < 0 Then
            I := Add('');
        Put(I, Name + '=' + Value);
    End
    Else
    Begin
        If I >= 0 Then
            Delete(I);
    End;
End;


Function ToysStringList.GetName(index: Integer): String;
Begin
    result := ExtractName(Get(index));
End;

Procedure ToysStringList.SetName(index: Integer; Value: String);
Var
    s: String;
    p: Integer;
Begin
    s := get(index);
    p := ansipos('=', s);
    If p > 0 Then
        s := copy(s, p + 1, length(s));
    s := Value + '=' + s;
    put(index, s);

End;

Function ToysStringList.Addfmt(s: String;
    Const args: Array Of Const): Integer;
Var
    astr: String;
Begin
    fmtstr(astr, s, args);
    result := Add(astr);
End;

Procedure ToysStringList.Appendfmt(s: String; Const args: Array Of Const);
Begin
    addfmt(s, args);
End;

End.
