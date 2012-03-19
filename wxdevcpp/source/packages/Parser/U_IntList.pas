unit U_IntList;
{Copyright 2001, Gary Darby, Intellitech Systems Inc., www.DelphiForFun.org

 This program may be used or modified for non-commercial purposes
 so long as this original notice remains in place.
 All other rights are reserved
 }

interface

uses
    Classes, SysConst, SysUtils;

const
    maxlistsize = maxint div 32;
type
{ TIntList class }
    TIntList = class;

 // we don't work with int64, so make a typedef...
    int64 = integer;

    PIntItem = ^TIntItem;
    TIntItem = record
        FInt: int64;
        FObject: TObject;
    end;

    PIntItemList = ^TIntItemList;
    TIntItemList = array[0..MaxListSize] of TIntItem;
    TIntListSortCompare = function(List: TIntList; Index1, Index2: integer): integer;

    TIntList = class(TPersistent)
    private
        FUpDateCount: integer;
        FList: PIntItemList;
        FCount: integer;
        FCapacity: integer;
        FSorted: boolean;
        FDuplicates: TDuplicates;
        FOnChange: TNotifyEvent;
        FOnChanging: TNotifyEvent;
        procedure ExchangeItems(Index1, Index2: integer);
        procedure Grow;
        procedure QuickSort(L, R: integer; SCompare: TIntListSortCompare);
        procedure InsertItem(Index: integer; const S: int64);
        procedure SetSorted(Value: boolean);
    protected
        procedure Error(const Msg: string; Data: integer);
        procedure Changed; virtual;
        procedure Changing; virtual;
        function Get(Index: integer): int64;
        function GetCapacity: integer;
        function GetCount: integer;
        function GetObject(Index: integer): TObject;
        procedure Put(Index: integer; const S: int64);
        procedure PutObject(Index: integer; AObject: TObject);
        procedure SetCapacity(NewCapacity: integer);
        procedure SetUpdateState(Updating: boolean);
    public

        destructor Destroy; override;
        function Add(const S: int64): integer;
        function AddObject(const S: int64; AObject: TObject): integer; virtual;
        procedure Clear;
        procedure Delete(Index: integer);
        procedure Exchange(Index1, Index2: integer);
        function Find(const S: int64; var Index: integer): boolean; virtual;
        function IndexOf(const S: int64): integer;
        procedure Insert(Index: integer; const S: int64);
        procedure Sort; virtual;
        procedure CustomSort(Compare: TIntListSortCompare); virtual;

        procedure LoadFromFile(const FileName: string); virtual;
        procedure LoadFromStream(Stream: TStream); virtual;
        procedure SaveToFile(const FileName: string); virtual;
        procedure SaveToStream(Stream: TStream);

        property Duplicates: TDuplicates read FDuplicates write FDuplicates;
        property Sorted: boolean read FSorted write SetSorted;
        property OnChange: TNotifyEvent read FOnChange write FOnChange;
        property OnChanging: TNotifyEvent read FOnChanging write FOnChanging;
        property Integers[Index: integer]: int64 read Get write Put; default;
        property Count: integer read GetCount;
        property Objects[Index: integer]: TObject read GetObject write PutObject;
    end;

implementation


{ TIntList }

destructor TIntList.Destroy;
begin
    FOnChange := NIL;
    FOnChanging := NIL;
    inherited destroy;
    FCount := 0;
    SetCapacity(0);
end;



procedure TIntList.Error(const Msg: string; Data: integer);

    function ReturnAddr: Pointer;
    asm
        MOV     EAX,[EBP+4]
    end;

begin
    raise EStringListError.CreateFmt(Msg, [Data]) at ReturnAddr;
end;


const
    sDuplicateInt: string = 'Cannot add integer because if already exists';
    sListIndexError = 'List index Error';
    SSortedListError = 'Cannont insert to sorted list';

function TIntList.Add(const S: int64): integer;
begin
    if not Sorted then
        Result := FCount
    else
    if Find(S, Result) then
        case Duplicates of
            dupIgnore:
                Exit;
            dupError:
                Error(SDuplicateInt, 0);
        end;
    InsertItem(Result, S);
end;

function TIntList.AddObject(const S: int64; AObject: TObject): integer;
begin
    Result := Add(S);
    PutObject(Result, AObject);
end;

procedure TIntList.Changed;
begin
    if (FUpdateCount = 0) and Assigned(FOnChange) then
        FOnChange(Self);
end;

procedure TIntList.Changing;
begin
    if (FUpdateCount = 0) and Assigned(FOnChanging) then
        FOnChanging(Self);
end;

procedure TIntList.Clear;
begin
    if FCount <> 0 then
    begin
        Changing;
        FCount := 0;
        SetCapacity(0);
        Changed;
    end;
end;

procedure TIntList.Delete(Index: integer);
begin
    if (Index < 0) or (Index >= FCount) then
        Error(SListIndexError, Index);
    Changing;
    Dec(FCount);
    if Index < FCount then
        System.Move(FList^[Index + 1], FList^[Index],
            (FCount - Index) * SizeOf(TIntItem));
    Changed;
end;

procedure TIntList.Exchange(Index1, Index2: integer);
begin
    if (Index1 < 0) or (Index1 >= FCount) then
        Error(SListIndexError, Index1);
    if (Index2 < 0) or (Index2 >= FCount) then
        Error(SListIndexError, Index2);
    Changing;
    ExchangeItems(Index1, Index2);
    Changed;
end;

procedure TIntList.ExchangeItems(Index1, Index2: integer);
var
    Temp: int64;
    Item1, Item2: PIntItem;
begin
    Item1 := @FList^[Index1];
    Item2 := @FList^[Index2];
    Temp := integer(Item1^.FInt);
    Item1^.FInt := Item2^.FInt;
    Item2^.FInt := Temp;
    Temp := integer(Item1^.FObject);
    integer(Item1^.FObject) := integer(Item2^.FObject);
    integer(Item2^.FObject) := Temp;
end;

function TIntList.Find(const S: int64; var Index: integer): boolean;
var
    L, H, I: integer;
begin
    Result := FALSE;
    L := 0;
    H := FCount - 1;
    while L <= H do
    begin
        I := (L + H) shr 1;
        if Flist^[I].FInt < S then
            L := L + 1 else
        begin
            H := I - 1;
            if FList^[I].FInt = S then
            begin
                Result := TRUE;
                if Duplicates <> dupAccept then
                    L := I;
            end;
        end;
    end;
    Index := L;
end;

function TIntList.Get(Index: integer): int64;
begin
    if (Index < 0) or (Index >= FCount) then
        Error(SListIndexError, Index);
    Result := FList^[Index].FInt;
end;

function TIntList.GetCapacity: integer;
begin
    Result := FCapacity;
end;

function TIntList.GetCount: integer;
begin
    Result := FCount;
end;

function TIntList.GetObject(Index: integer): TObject;
begin
    if (Index < 0) or (Index >= FCount) then
        Error(SListIndexError, Index);
    Result := FList^[Index].FObject;
end;

procedure TIntList.Grow;
var
    Delta: integer;
begin
    if FCapacity > 64 then
        Delta := FCapacity div 4 else
    if FCapacity > 8 then
        Delta := 16 else
        Delta := 4;
    SetCapacity(FCapacity + Delta);
end;

function TIntList.IndexOf(const S: int64): integer;
begin
    if not Sorted then
    begin
        for Result := 0 to GetCount - 1 do
            if Get(Result) = s then
                Exit;
        Result := -1;
    end
    else
    if not Find(S, Result) then
        Result := -1;
end;

procedure TIntList.Insert(Index: integer; const S: int64);
begin
    if Sorted then
        Error(SSortedListError, 0);
    if (Index < 0) or (Index > FCount) then
        Error(SListIndexError, Index);
    InsertItem(Index, S);
end;

procedure TIntList.InsertItem(Index: integer; const S: int64);
begin
    Changing;
    if FCount = FCapacity then
        Grow;
    if Index < FCount then
        System.Move(FList^[Index], FList^[Index + 1],
            (FCount - Index) * SizeOf(TIntItem));
    with FList^[Index] do
    begin
        FObject := NIL;
        FInt := S;
    end;
    Inc(FCount);
    Changed;
end;

procedure TIntList.Put(Index: integer; const S: int64);
begin
    if Sorted then
        Error(SSortedListError, 0);
    if (Index < 0) or (Index >= FCount) then
        Error(SListIndexError, Index);
    Changing;
    FList^[Index].FInt := S;
    Changed;
end;

procedure TIntList.PutObject(Index: integer; AObject: TObject);
begin
    if (Index < 0) or (Index >= FCount) then
        Error(SListIndexError, Index);
    Changing;
    FList^[Index].FObject := AObject;
    Changed;
end;

procedure TIntList.QuickSort(L, R: integer; SCompare: TIntListSortCompare);
var
    I, J, P: integer;
begin
    repeat
        I := L;
        J := R;
        P := (L + R) shr 1;
        repeat
            while SCompare(Self, I, P) < 0 do
                Inc(I);
            while SCompare(Self, J, P) > 0 do
                Dec(J);
            if I <= J then
            begin
                ExchangeItems(I, J);
                if P = I then
                    P := J
                else
                if P = J then
                    P := I;
                Inc(I);
                Dec(J);
            end;
        until I > J;
        if L < J then
            QuickSort(L, J, SCompare);
        L := I;
    until I >= R;
end;

procedure TIntList.SetCapacity(NewCapacity: integer);
begin
    ReallocMem(FList, NewCapacity * SizeOf(TIntItem));
    FCapacity := NewCapacity;
end;

procedure TIntList.SetSorted(Value: boolean);
begin
    if FSorted <> Value then
    begin
        if Value then
            Sort;
        FSorted := Value;
    end;
end;

procedure TIntList.SetUpdateState(Updating: boolean);
begin
    if Updating then
        Changing else Changed;
end;


function IntListCompare(List: TIntList; Index1, Index2: integer): integer;
begin
    if List.FList^[Index1].FInt > List.FList^[Index2].FInt then
        result := +1
    else
    if List.FList^[Index1].FInt < List.FList^[Index2].FInt then
        result := -1
    else result := 0;
end;


procedure TIntList.Sort;
begin
    CustomSort(IntListCompare);
end;


procedure TIntList.SaveToFile(const FileName: string);
var
    Stream: TStream;
begin
    Stream := TFileStream.Create(FileName, fmCreate);
    try
        SaveToStream(Stream);
    finally
        Stream.Free;
    end;
end;

procedure TIntList.SaveToStream(Stream: TStream);
var
    i: integer;
    N: integer;
    Val: int64;
begin
    N := count;
    Stream.WriteBuffer(N, sizeof(N));
    for i := 0 to count - 1 do
    begin
        val := integers[i];
        stream.writebuffer(val, sizeof(val));
    end;
end;


procedure TIntList.LoadFromFile(const FileName: string);
var
    Stream: TStream;
begin
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
        LoadFromStream(Stream);
    finally
        Stream.Free;
    end;
end;

procedure TIntList.LoadFromStream(Stream: TStream);
var
    Size: integer;
    i: integer;
    N: int64;
begin
  {BeginUpdate;  }
    try
        clear;
        Stream.readbuffer(size, sizeof(size));
        for i := 0 to size - 1 do
        begin
            Stream.Read(N, sizeof(N));
            add(N);
        end;
    finally
    {EndUpdate;}
    end;
end;



procedure TIntList.CustomSort(Compare: TIntListSortCompare);
begin
    if not Sorted and (FCount > 1) then
    begin
        Changing;
        QuickSort(0, FCount - 1, Compare);
        Changed;
    end;
end;

end.
