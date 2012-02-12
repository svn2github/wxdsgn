Unit U_IntList;
{Copyright 2001, Gary Darby, Intellitech Systems Inc., www.DelphiForFun.org

 This program may be used or modified for non-commercial purposes
 so long as this original notice remains in place.
 All other rights are reserved
 }

Interface

Uses
    Classes, SysConst, SysUtils;

Const
    maxlistsize = maxint Div 32;
Type
{ TIntList class }
    TIntList = Class;

 // we don't work with int64, so make a typedef...
    Int64 = Integer;

    PIntItem = ^TIntItem;
    TIntItem = Record
        FInt: Int64;
        FObject: TObject;
    End;

    PIntItemList = ^TIntItemList;
    TIntItemList = Array[0..MaxListSize] Of TIntItem;
    TIntListSortCompare = Function(List: TIntList; Index1, Index2: Integer): Integer;

    TIntList = Class(TPersistent)
    Private
        FUpDateCount: Integer;
        FList: PIntItemList;
        FCount: Integer;
        FCapacity: Integer;
        FSorted: Boolean;
        FDuplicates: TDuplicates;
        FOnChange: TNotifyEvent;
        FOnChanging: TNotifyEvent;
        Procedure ExchangeItems(Index1, Index2: Integer);
        Procedure Grow;
        Procedure QuickSort(L, R: Integer; SCompare: TIntListSortCompare);
        Procedure InsertItem(Index: Integer; Const S: Int64);
        Procedure SetSorted(Value: Boolean);
    Protected
        Procedure Error(Const Msg: String; Data: Integer);
        Procedure Changed; Virtual;
        Procedure Changing; Virtual;
        Function Get(Index: Integer): Int64;
        Function GetCapacity: Integer;
        Function GetCount: Integer;
        Function GetObject(Index: Integer): TObject;
        Procedure Put(Index: Integer; Const S: Int64);
        Procedure PutObject(Index: Integer; AObject: TObject);
        Procedure SetCapacity(NewCapacity: Integer);
        Procedure SetUpdateState(Updating: Boolean);
    Public

        Destructor Destroy; Override;
        Function Add(Const S: Int64): Integer;
        Function AddObject(Const S: Int64; AObject: TObject): Integer; Virtual;
        Procedure Clear;
        Procedure Delete(Index: Integer);
        Procedure Exchange(Index1, Index2: Integer);
        Function Find(Const S: Int64; Var Index: Integer): Boolean; Virtual;
        Function IndexOf(Const S: Int64): Integer;
        Procedure Insert(Index: Integer; Const S: Int64);
        Procedure Sort; Virtual;
        Procedure CustomSort(Compare: TIntListSortCompare); Virtual;

        Procedure LoadFromFile(Const FileName: String); Virtual;
        Procedure LoadFromStream(Stream: TStream); Virtual;
        Procedure SaveToFile(Const FileName: String); Virtual;
        Procedure SaveToStream(Stream: TStream);

        Property Duplicates: TDuplicates Read FDuplicates Write FDuplicates;
        Property Sorted: Boolean Read FSorted Write SetSorted;
        Property OnChange: TNotifyEvent Read FOnChange Write FOnChange;
        Property OnChanging: TNotifyEvent Read FOnChanging Write FOnChanging;
        Property Integers[Index: Integer]: Int64 Read Get Write Put; Default;
        Property Count: Integer Read GetCount;
        Property Objects[Index: Integer]: TObject Read GetObject Write PutObject;
    End;

Implementation


{ TIntList }

Destructor TIntList.Destroy;
Begin
    FOnChange := Nil;
    FOnChanging := Nil;
    Inherited destroy;
    FCount := 0;
    SetCapacity(0);
End;



Procedure TIntList.Error(Const Msg: String; Data: Integer);

    Function ReturnAddr: Pointer;
    Asm
        MOV     EAX,[EBP+4]
    End;

Begin
    Raise EStringListError.CreateFmt(Msg, [Data]) at ReturnAddr;
End;


Const
    sDuplicateInt: String = 'Cannot add integer because if already exists';
    sListIndexError = 'List index Error';
    SSortedListError = 'Cannont insert to sorted list';

Function TIntList.Add(Const S: Int64): Integer;
Begin
    If Not Sorted Then
        Result := FCount
    Else
    If Find(S, Result) Then
        Case Duplicates Of
            dupIgnore:
                Exit;
            dupError:
                Error(SDuplicateInt, 0);
        End;
    InsertItem(Result, S);
End;

Function TIntList.AddObject(Const S: Int64; AObject: TObject): Integer;
Begin
    Result := Add(S);
    PutObject(Result, AObject);
End;

Procedure TIntList.Changed;
Begin
    If (FUpdateCount = 0) And Assigned(FOnChange) Then
        FOnChange(Self);
End;

Procedure TIntList.Changing;
Begin
    If (FUpdateCount = 0) And Assigned(FOnChanging) Then
        FOnChanging(Self);
End;

Procedure TIntList.Clear;
Begin
    If FCount <> 0 Then
    Begin
        Changing;
        FCount := 0;
        SetCapacity(0);
        Changed;
    End;
End;

Procedure TIntList.Delete(Index: Integer);
Begin
    If (Index < 0) Or (Index >= FCount) Then
        Error(SListIndexError, Index);
    Changing;
    Dec(FCount);
    If Index < FCount Then
        System.Move(FList^[Index + 1], FList^[Index],
            (FCount - Index) * SizeOf(TIntItem));
    Changed;
End;

Procedure TIntList.Exchange(Index1, Index2: Integer);
Begin
    If (Index1 < 0) Or (Index1 >= FCount) Then
        Error(SListIndexError, Index1);
    If (Index2 < 0) Or (Index2 >= FCount) Then
        Error(SListIndexError, Index2);
    Changing;
    ExchangeItems(Index1, Index2);
    Changed;
End;

Procedure TIntList.ExchangeItems(Index1, Index2: Integer);
Var
    Temp: Int64;
    Item1, Item2: PIntItem;
Begin
    Item1 := @FList^[Index1];
    Item2 := @FList^[Index2];
    Temp := Integer(Item1^.FInt);
    Item1^.FInt := Item2^.FInt;
    Item2^.FInt := Temp;
    Temp := Integer(Item1^.FObject);
    Integer(Item1^.FObject) := Integer(Item2^.FObject);
    Integer(Item2^.FObject) := Temp;
End;

Function TIntList.Find(Const S: Int64; Var Index: Integer): Boolean;
Var
    L, H, I: Integer;
Begin
    Result := False;
    L := 0;
    H := FCount - 1;
    While L <= H Do
    Begin
        I := (L + H) Shr 1;
        If Flist^[I].FInt < S Then
            L := L + 1 Else
        Begin
            H := I - 1;
            If FList^[I].FInt = S Then
            Begin
                Result := True;
                If Duplicates <> dupAccept Then
                    L := I;
            End;
        End;
    End;
    Index := L;
End;

Function TIntList.Get(Index: Integer): Int64;
Begin
    If (Index < 0) Or (Index >= FCount) Then
        Error(SListIndexError, Index);
    Result := FList^[Index].FInt;
End;

Function TIntList.GetCapacity: Integer;
Begin
    Result := FCapacity;
End;

Function TIntList.GetCount: Integer;
Begin
    Result := FCount;
End;

Function TIntList.GetObject(Index: Integer): TObject;
Begin
    If (Index < 0) Or (Index >= FCount) Then
        Error(SListIndexError, Index);
    Result := FList^[Index].FObject;
End;

Procedure TIntList.Grow;
Var
    Delta: Integer;
Begin
    If FCapacity > 64 Then
        Delta := FCapacity Div 4 Else
    If FCapacity > 8 Then
        Delta := 16 Else
        Delta := 4;
    SetCapacity(FCapacity + Delta);
End;

Function TIntList.IndexOf(Const S: Int64): Integer;
Begin
    If Not Sorted Then
    Begin
        For Result := 0 To GetCount - 1 Do
            If Get(Result) = s Then
                Exit;
        Result := -1;
    End
    Else
    If Not Find(S, Result) Then
        Result := -1;
End;

Procedure TIntList.Insert(Index: Integer; Const S: Int64);
Begin
    If Sorted Then
        Error(SSortedListError, 0);
    If (Index < 0) Or (Index > FCount) Then
        Error(SListIndexError, Index);
    InsertItem(Index, S);
End;

Procedure TIntList.InsertItem(Index: Integer; Const S: Int64);
Begin
    Changing;
    If FCount = FCapacity Then
        Grow;
    If Index < FCount Then
        System.Move(FList^[Index], FList^[Index + 1],
            (FCount - Index) * SizeOf(TIntItem));
    With FList^[Index] Do
    Begin
        FObject := Nil;
        FInt := S;
    End;
    Inc(FCount);
    Changed;
End;

Procedure TIntList.Put(Index: Integer; Const S: Int64);
Begin
    If Sorted Then
        Error(SSortedListError, 0);
    If (Index < 0) Or (Index >= FCount) Then
        Error(SListIndexError, Index);
    Changing;
    FList^[Index].FInt := S;
    Changed;
End;

Procedure TIntList.PutObject(Index: Integer; AObject: TObject);
Begin
    If (Index < 0) Or (Index >= FCount) Then
        Error(SListIndexError, Index);
    Changing;
    FList^[Index].FObject := AObject;
    Changed;
End;

Procedure TIntList.QuickSort(L, R: Integer; SCompare: TIntListSortCompare);
Var
    I, J, P: Integer;
Begin
    Repeat
        I := L;
        J := R;
        P := (L + R) Shr 1;
        Repeat
            While SCompare(Self, I, P) < 0 Do
                Inc(I);
            While SCompare(Self, J, P) > 0 Do
                Dec(J);
            If I <= J Then
            Begin
                ExchangeItems(I, J);
                If P = I Then
                    P := J
                Else
                If P = J Then
                    P := I;
                Inc(I);
                Dec(J);
            End;
        Until I > J;
        If L < J Then
            QuickSort(L, J, SCompare);
        L := I;
    Until I >= R;
End;

Procedure TIntList.SetCapacity(NewCapacity: Integer);
Begin
    ReallocMem(FList, NewCapacity * SizeOf(TIntItem));
    FCapacity := NewCapacity;
End;

Procedure TIntList.SetSorted(Value: Boolean);
Begin
    If FSorted <> Value Then
    Begin
        If Value Then
            Sort;
        FSorted := Value;
    End;
End;

Procedure TIntList.SetUpdateState(Updating: Boolean);
Begin
    If Updating Then
        Changing Else Changed;
End;


Function IntListCompare(List: TIntList; Index1, Index2: Integer): Integer;
Begin
    If List.FList^[Index1].FInt > List.FList^[Index2].FInt Then
        result := +1
    Else
    If List.FList^[Index1].FInt < List.FList^[Index2].FInt Then
        result := -1
    Else result := 0;
End;


Procedure TIntList.Sort;
Begin
    CustomSort(IntListCompare);
End;


Procedure TIntList.SaveToFile(Const FileName: String);
Var
    Stream: TStream;
Begin
    Stream := TFileStream.Create(FileName, fmCreate);
    Try
        SaveToStream(Stream);
    Finally
        Stream.Free;
    End;
End;

Procedure TIntList.SaveToStream(Stream: TStream);
Var
    i: Integer;
    N: Integer;
    Val: Int64;
Begin
    N := count;
    Stream.WriteBuffer(N, sizeof(N));
    For i := 0 To count - 1 Do
    Begin
        val := integers[i];
        stream.writebuffer(val, sizeof(val));
    End;
End;


Procedure TIntList.LoadFromFile(Const FileName: String);
Var
    Stream: TStream;
Begin
    Stream := TFileStream.Create(FileName, fmOpenRead Or fmShareDenyWrite);
    Try
        LoadFromStream(Stream);
    Finally
        Stream.Free;
    End;
End;

Procedure TIntList.LoadFromStream(Stream: TStream);
Var
    Size: Integer;
    i: Integer;
    N: Int64;
Begin
  {BeginUpdate;  }
    Try
        clear;
        Stream.readbuffer(size, sizeof(size));
        For i := 0 To size - 1 Do
        Begin
            Stream.Read(N, sizeof(N));
            add(N);
        End;
    Finally
    {EndUpdate;}
    End;
End;



Procedure TIntList.CustomSort(Compare: TIntListSortCompare);
Begin
    If Not Sorted And (FCount > 1) Then
    Begin
        Changing;
        QuickSort(0, FCount - 1, Compare);
        Changed;
    End;
End;

End.
