Unit Hashes;

{** Hash Library

    Original Author:     Ciaran McCreesh <keesh@users.sf.net>
    Copyright:           Copyright (c) 2002 Ciaran McCreesh
    Date:                20020621
    Purpose:             A collection of hash components for Delphi. These are
                         similar to arrays, but the index is a string. A hashing
                         algorithm is used to provide extremely fast searching.

    Generic Moan:        This would be a lot easier if Delphi had template
                         classes. If anyone at Borland / Inprise / whatever
                         you're calling yourselves this week reads this, let me
                         know how much I have to bribe you.

    Changelog:
      v2.6 (20020621)
        * Framework for dynamic bucket sizes. No actual resizing yet.
        * Changed TStringHash, TIntegerHash and TObjectHash slightly, and fixed
          potential bugs in them.
        * General performance improvements
        * Changed how iterators work. In particular, multiple iterators are now
          possible. Thanks to Daniel Trinter for code and Emanuel for
          suggestions.
        + Previous method (goes with Next)
        + AllowCompact property

      v2.5 (20020606)
        * Empty hash keys explicitly forbidden. Thanks to Marco Vink for the
          notice.
        + Clear method

      v2.4 (20020603)
        * Fixed Compact bug. Thanks to Daniel Trinter for the notice. Basically
          I was assuming something about the size of one of the internal arrays
          which wasn't always true.

      v2.3 (20020601)
        + ItemCount property
        + Compact method
        * Hash auto-compacts itself if overly inefficient
        * ItemIndexes are now recycled
    
      v2.2 (20020529)
        * Fixed iterator bug. Not all items were called under some
          circumstances. Thanks to Tom Walker for the notice.

      v2.1 (20020528, internal release only)
        + TObjectHash

      v2.0 (20020526)
        * Complete rewrite
        + THash
        + TStringHash
        + TIntegerHash

    License:

      This library is Copyright (c) 2002 Ciaran McCreesh.

      Permission is granted to anyone to use this software for any purpose on
      any computer system, and to redistribute it freely, subject to the
      following restrictions:

      1. This software is distributed in the hope that it will be useful,
         but WITHOUT ANY WARRANTY; without even the implied warranty of
         MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

      2. The origin of this software must not be misrepresented.

      3. Altered versions must be plainly marked as such, and must not be
         misrepresented as being the original software.

    Documentation:
      Please see:
        * http://www.opensourcepan.co.uk/libraries/hashes/
        * http://www.undu.com/articles/020604.html

    Other notes:
      This unit provides three hashes, TIntegerHash, TStringHash and
      TObjectHash. If you want a more precise kind (eg TComponentHash), it's
      easiest to descend from THash and copy the TObjectHash code. Note that
      TObjectHash is slightly different from TIntegerHash and TStringHash
      because it has to free items -- it cannot just overwrite them.

    Internal data representation:
      Each hash object has an array (potentially dynamically sized, but this
      isn't used yet) of 'buckets' (dynamic arrays). Each bucket is mapped
      to a series of hash values (we take the high order bits of the value
      calculated), so that every possible hash value refers to exactly one
      bucket. This reduces the amount of searching that has to be done to
      find an item, so it's much faster than linear or B-Tree storage.

      Each bucket contains a series of integers. These are indexes into an
      items array, which for type reasons is maintained by the descendant
      classes. These are recycled when the hash detects that it is becoming
      inefficient.
}

Interface

Uses SysUtils;

Const
    {** This constant controls the initial size of the hash. }
    c_HashInitialItemShift = 7;

    {** How inefficient do we have to be before we automatically Compact? }
    c_HashCompactR = 2;   { This many spaces per item. }
    c_HashCompactM = 100; { Never for less than this number of spaces. }

Type
    {** General exception classes. }
    EHashError = Class(Exception);
    EHashErrorClass = Class Of EHashError;

    {** Exception for when an item is not found. }
    EHashFindError = Class(EHashError);

    {** Exception for invalid Next op. }
    EHashIterateError = Class(EHashError);

    {** Exception for invalid keys. }
    EHashInvalidKeyError = Class(EHashError);

    {** Record, should really be private but OP won't let us... }
    THashRecord = Record
        Hash: Cardinal;
        ItemIndex: Integer;
        Key: String;
    End;

    {** Iterator Record. This should also be private. This makes me almost like
        the way Java does things. Almost. Maybe. }
    THashIterator = Record
        ck, cx: Integer;
    End;

    {** Base Hash class. Don't use this directly. }
    THash = Class
    Protected
        {** The keys. }
        f_Keys: Array Of Array Of THashRecord;

        {** Current bucket shift. }
        f_CurrentItemShift: Integer;

        {** These are calculated from f_CurrentItemShift. }
        f_CurrentItemCount: Integer;
        f_CurrentItemMask: Integer;
        f_CurrentItemMaxIdx: Integer;

        {** Spare items. }
        f_SpareItems: Array Of Integer;

        {** Whether Next is allowed. }
        f_NextAllowed: Boolean;

        {** Current key. }
        f_CurrentKey: String;

        {** Can we compact? }
        f_AllowCompact: Boolean;

        {** Our current iterator. }
        f_CurrentIterator: THashIterator;

        {** Update the masks. }
        Procedure FUpdateMasks;

        {** Update the buckets. }
        Procedure FUpdateBuckets;

        {** Find a key's location. }
        Function FFindKey(Const Key: String; Var k, x: Integer): Boolean;

        {** Add a new key, or change an existing one. Don't call this directly. }
        Procedure FSetOrAddKey(Const Key: String; ItemIndex: Integer);

        {** Abstract method, delete value with a given index. Override this. }
        Procedure FDeleteIndex(i: Integer); Virtual; Abstract;

        {** Get the number of items. }
        Function FGetItemCount: Integer;

        {** Allocate an item index. }
        Function FAllocItemIndex: Integer;

        {** Abstract method, move an item with index OldIndex to NewIndex.
            Override this. }
        Procedure FMoveIndex(oldIndex, newIndex: Integer); Virtual; Abstract;

        {** Abstract method, trim the indexes down to count items. Override
            this. }
        Procedure FTrimIndexes(count: Integer); Virtual; Abstract;

        {** Abstract method, clear all items. Override this. }
        Procedure FClearItems; Virtual; Abstract;

        {** Tell us where to start our compact count from. Override this. }
        Function FIndexMax: Integer; Virtual; Abstract;

        {** Compact, but only if we're inefficient. }
        Procedure FAutoCompact;

    Public
        {** Our own constructor. }
        Constructor Create; Reintroduce; Virtual;

        {** Does a key exist? }
        Function Exists(Const Key: String): Boolean;

        {** Rename a key. }
        Procedure Rename(Const Key, NewName: String);

        {** Delete a key. }
        Procedure Delete(Const Key: String);

        {** Reset iterator. }
        Procedure Restart;

        {** Next key. }
        Function Next: Boolean;

        {** Previous key. }
        Function Previous: Boolean;

        {** Current key. }
        Function CurrentKey: String;

        {** The number of items. }
        Property ItemCount: Integer Read FGetItemCount;

        {** Compact the hash. }
        Procedure Compact;

        {** Clear the hash. }
        Procedure Clear;

        {** Allow compacting? }
        Property AllowCompact: Boolean Read f_AllowCompact Write f_AllowCompact;

        {** Current iterator. }
        Property CurrentIterator: THashIterator Read f_CurrentIterator Write
            f_CurrentIterator;

        {** Create a new iterator. }
        Function NewIterator: THashIterator;

    End;

    {** Hash of strings. }
    TStringHash = Class(THash)
    Protected
        {** The index items. }
        f_Items: Array Of String;

        {** Override FDeleteIndex abstract method. }
        Procedure FDeleteIndex(i: Integer); Override;

        {** Get an item or raise an exception. }
        Function FGetItem(Const Key: String): String;

        {** Set or add an item. }
        Procedure FSetItem(Const Key, Value: String);

        {** Move an index. }
        Procedure FMoveIndex(oldIndex, newIndex: Integer); Override;

        {** Trim. }
        Procedure FTrimIndexes(count: Integer); Override;

        {** Clear all items. }
        Procedure FClearItems; Override;

        {** Where to start our compact count from. }
        Function FIndexMax: Integer; Override;

    Public
        {** Items property. }
        Property Items[Const Key: String]: String Read FGetItem
            Write FSetItem; Default;
    End;

    {** Hash of integers. }
    TIntegerHash = Class(THash)
    Protected
        {** The index items. }
        f_Items: Array Of Integer;

        {** Override FDeleteIndex abstract method. }
        Procedure FDeleteIndex(i: Integer); Override;

        {** Get an item or raise an exception. }
        Function FGetItem(Const Key: String): Integer;

        {** Set or add an item. }
        Procedure FSetItem(Const Key: String; Value: Integer);

        {** Move an index. }
        Procedure FMoveIndex(oldIndex, newIndex: Integer); Override;

        {** Trim. }
        Procedure FTrimIndexes(count: Integer); Override;

        {** Clear all items. }
        Procedure FClearItems; Override;

        {** Where to start our compact count from. }
        Function FIndexMax: Integer; Override;

    Public
        {** Items property. }
        Property Items[Const Key: String]: Integer Read FGetItem
            Write FSetItem; Default;
    End;

    {** Hash of objects. }
    TObjectHash = Class(THash)
    Protected
        {** The index items. }
        f_Items: Array Of TObject;

        {** Override FDeleteIndex abstract method. }
        Procedure FDeleteIndex(i: Integer); Override;

        {** Get an item or raise an exception. }
        Function FGetItem(Const Key: String): TObject;

        {** Set or add an item. }
        Procedure FSetItem(Const Key: String; Value: TObject);

        {** Move an index. }
        Procedure FMoveIndex(oldIndex, newIndex: Integer); Override;

        {** Trim. }
        Procedure FTrimIndexes(count: Integer); Override;

        {** Clear all items. }
        Procedure FClearItems; Override;

        {** Where to start our compact count from. }
        Function FIndexMax: Integer; Override;

    Public
        {** Items property. }
        Property Items[Const Key: String]: TObject Read FGetItem
            Write FSetItem; Default;

        {** Destructor must destroy all items. }
        Destructor Destroy; Override;

    End;

Implementation

  {** A basic hash function. This is pretty fast, and fairly good general
      purpose, but you may want to swap in a specialised version. }
Function HashThis(Const s: String): Cardinal;
Var
    h, g, i: Cardinal;
Begin
    If (s = '') Then
        Raise EHashInvalidKeyError.Create('Key cannot be an empty string');
    h := $12345670;
    For i := 1 To Length(s) Do
    Begin
        h := (h Shl 4) + ord(s[i]);
        g := h And $f0000000;
        If (g > 0) Then
            h := h Or (g Shr 24) Or g;
    End;
    result := h;
End;

{ THash }

Constructor THash.Create;
Begin
    Inherited Create;
    self.f_CurrentIterator.ck := -1;
    self.f_CurrentIterator.cx := 0;
    self.f_CurrentItemShift := c_HashInitialItemShift;
    self.FUpdateMasks;
    self.FUpdateBuckets;
    self.f_AllowCompact := True;
End;

Procedure THash.Delete(Const Key: String);
Var
    k, x, i: Integer;
Begin
  { Hash has been modified, so disallow Next. }
    self.f_NextAllowed := False;
    If (self.FFindKey(Key, k, x)) Then
    Begin
    { Delete the Index entry. }
        i := self.f_Keys[k][x].ItemIndex;
        self.FDeleteIndex(i);
    { Add the index to the Spares list. }
        SetLength(self.f_SpareItems, Length(self.f_SpareItems) + 1);
        self.f_SpareItems[High(self.f_SpareItems)] := i;
    { Overwrite key with the last in the list. }
        self.f_Keys[k][x] := self.f_Keys[k][High(self.f_Keys[k])];
    { Delete the last in the list. }
        SetLength(self.f_Keys[k], Length(self.f_Keys[k]) - 1);
    End
    Else
        Raise EHashFindError.CreateFmt('Key "%s" not found', [Key]);

    self.FAutoCompact;
End;

Function THash.Exists(Const Key: String): Boolean;
Var
    dummy1, dummy2: Integer;
Begin
    result := FFindKey(Key, dummy1, dummy2);
End;

Procedure THash.FSetOrAddKey(Const Key: String; ItemIndex: Integer);
Var
    k, x, i: Integer;
Begin
  { Exists already? }
    If (self.FFindKey(Key, k, x)) Then
    Begin
    { Yep. Delete the old stuff and set the new value. }
        i := self.f_Keys[k][x].ItemIndex;
        self.FDeleteIndex(i);
        self.f_Keys[k][x].ItemIndex := ItemIndex;
    { Add the index to the spares list. }
        SetLength(self.f_SpareItems, Length(self.f_SpareItems) + 1);
        self.f_SpareItems[High(self.f_SpareItems)] := i;
    End
    Else
    Begin
    { No, create a new one. }
        SetLength(self.f_Keys[k], Length(self.f_Keys[k]) + 1);
        self.f_Keys[k][High(self.f_Keys[k])].Key := Key;
        self.f_Keys[k][High(self.f_Keys[k])].ItemIndex := ItemIndex;
        self.f_Keys[k][High(self.f_Keys[k])].Hash := HashThis(Key);
    End;
End;

Function THash.FFindKey(Const Key: String; Var k, x: Integer): Boolean;
Var
    i: Integer;
    h: Cardinal;
Begin
  { Which bucket? }
    h := HashThis(Key);
    k := h And f_CurrentItemMask;
    result := False;
  { Look for it. }
    For i := 0 To High(self.f_Keys[k]) Do
        If (self.f_Keys[k][i].Hash = h) Or True Then
            If (self.f_Keys[k][i].Key = Key) Then
            Begin
        { Found it! }
                result := True;
                x := i;
                break;
            End;
End;

Procedure THash.Rename(Const Key, NewName: String);
Var
    k, x, i: Integer;
Begin
  { Hash has been modified, so disallow Next. }
    self.f_NextAllowed := False;
    If (self.FFindKey(Key, k, x)) Then
    Begin
    { Remember the ItemIndex. }
        i := self.f_Keys[k][x].ItemIndex;
    { Overwrite key with the last in the list. }
        self.f_Keys[k][x] := self.f_Keys[k][High(self.f_Keys[k])];
    { Delete the last in the list. }
        SetLength(self.f_Keys[k], Length(self.f_Keys[k]) - 1);
    { Create the new item. }
        self.FSetOrAddKey(NewName, i);
    End
    Else
        Raise EHashFindError.CreateFmt('Key "%s" not found', [Key]);

    self.FAutoCompact;
End;

Function THash.CurrentKey: String;
Begin
    If (Not (self.f_NextAllowed)) Then
        Raise EHashIterateError.Create('Cannot find CurrentKey as the hash has '
            + 'been modified since Restart was called')
    Else
    If (self.f_CurrentKey = '') Then
        Raise EHashIterateError.Create('Cannot find CurrentKey as Next has not yet '
            + 'been called after Restart')
    Else
        result := self.f_CurrentKey;
End;

Function THash.Next: Boolean;
Begin
    If (Not (self.f_NextAllowed)) Then
        Raise EHashIterateError.Create('Cannot get Next as the hash has '
            + 'been modified since Restart was called');
    result := False;
    If (self.f_CurrentIterator.ck = -1) Then
    Begin
        self.f_CurrentIterator.ck := 0;
        self.f_CurrentIterator.cx := 0;
    End;
    While ((Not result) And (self.f_CurrentIterator.ck <= f_CurrentItemMaxIdx)) Do
    Begin
        If (self.f_CurrentIterator.cx < Length(self.f_Keys[self.f_CurrentIterator.ck])) Then
        Begin
            result := True;
            self.f_CurrentKey := self.f_Keys[self.f_CurrentIterator.ck][self.f_CurrentIterator.cx].Key;
            inc(self.f_CurrentIterator.cx);
        End
        Else
        Begin
            inc(self.f_CurrentIterator.ck);
            self.f_CurrentIterator.cx := 0;
        End;
    End;
End;

Procedure THash.Restart;
Begin
    self.f_CurrentIterator.ck := -1;
    self.f_CurrentIterator.cx := 0;
    self.f_NextAllowed := True;
End;

Function THash.FGetItemCount: Integer;
Var
    i: Integer;
Begin
  { Calculate our item count. }
    result := 0;
    For i := 0 To f_CurrentItemMaxIdx Do
        inc(result, Length(self.f_Keys[i]));
End;

Function THash.FAllocItemIndex: Integer;
Begin
    If (Length(self.f_SpareItems) > 0) Then
    Begin
    { Use the top SpareItem. }
        result := self.f_SpareItems[High(self.f_SpareItems)];
        SetLength(self.f_SpareItems, Length(self.f_SpareItems) - 1);
    End
    Else
    Begin
        result := self.FIndexMax + 1;
    End;
End;

Procedure THash.Compact;
Var
    aSpaces: Array Of Boolean;
    aMapping: Array Of Integer;
    i, j: Integer;
Begin
  { Find out where the gaps are. We could do this by sorting, but that's at
    least O(n log n), and sometimes O(n^2), so we'll go for the O(n) method,
    even though it involves multiple passes. Note that this is a lot faster
    than it looks. Disabling this saves about 3% in my benchmarks, but uses a
    lot more memory. }
    If (self.AllowCompact) Then
    Begin
        SetLength(aSpaces, self.FIndexMax + 1);
        SetLength(aMapping, self.FIndexMax + 1);
        For i := 0 To High(aSpaces) Do
            aSpaces[i] := False;
        For i := 0 To High(aMapping) Do
            aMapping[i] := i;
        For i := 0 To High(self.f_SpareItems) Do
            aSpaces[self.f_SpareItems[i]] := True;

    { Starting at the low indexes, fill empty ones from the high indexes. }
        i := 0;
        j := self.FIndexMax;
        While (i < j) Do
        Begin
            If (aSpaces[i]) Then
            Begin
                While ((i < j) And (aSpaces[j])) Do
                    dec(j);
                If (i < j) Then
                Begin
                    aSpaces[i] := False;
                    aSpaces[j] := True;
                    self.FMoveIndex(j, i);
                    aMapping[j] := i;
                End;
            End
            Else
                inc(i);
        End;

        j := self.FIndexMax;
        While (aSpaces[j]) Do
            dec(j);

    { Trim the items array down to size. }
        self.FTrimIndexes(j + 1);

    { Clear the spaces. }
        SetLength(self.f_SpareItems, 0);

    { Update our buckets. }
        For i := 0 To f_CurrentItemMaxIdx Do
            For j := 0 To High(self.f_Keys[i]) Do
                self.f_Keys[i][j].ItemIndex := aMapping[self.f_Keys[i][j].ItemIndex];
    End;
End;

Procedure THash.FAutoCompact;
Begin
    If (self.AllowCompact) Then
        If (Length(self.f_SpareItems) >= c_HashCompactM) Then
            If (self.FIndexMax * c_HashCompactR > Length(self.f_SpareItems)) Then
                self.Compact;
End;

Procedure THash.Clear;
Var
    i: Integer;
Begin
    self.FClearItems;
    SetLength(self.f_SpareItems, 0);
    For i := 0 To f_CurrentItemMaxIdx Do
        SetLength(self.f_Keys[i], 0);
End;

Procedure THash.FUpdateMasks;
Begin
    f_CurrentItemMask := (1 Shl f_CurrentItemShift) - 1;
    f_CurrentItemMaxIdx := (1 Shl f_CurrentItemShift) - 1;
    f_CurrentItemCount := (1 Shl f_CurrentItemShift);
End;

Procedure THash.FUpdateBuckets;
Begin
  { This is just a temporary thing. }
    SetLength(self.f_Keys, self.f_CurrentItemCount);
End;

Function THash.NewIterator: THashIterator;
Begin
    result.ck := -1;
    result.cx := 0;
End;

Function THash.Previous: Boolean;
Begin
    If (Not (self.f_NextAllowed)) Then
        Raise EHashIterateError.Create('Cannot get Next as the hash has '
            + 'been modified since Restart was called');
    result := False;
    If (self.f_CurrentIterator.ck >= 0) Then
    Begin
        While ((Not result) And (self.f_CurrentIterator.ck >= 0)) Do
        Begin
            dec(self.f_CurrentIterator.cx);
            If (self.f_CurrentIterator.cx >= 0) Then
            Begin
                result := True;
                self.f_CurrentKey := self.f_Keys[self.f_CurrentIterator.ck][self.f_CurrentIterator.cx].Key;
            End
            Else
            Begin
                dec(self.f_CurrentIterator.ck);
                If (self.f_CurrentIterator.ck >= 0) Then
                    self.f_CurrentIterator.cx := Length(self.f_Keys[self.f_CurrentIterator.ck]);
            End;
        End;
    End;
End;

{ TStringHash }

Procedure TStringHash.FDeleteIndex(i: Integer);
Begin
    self.f_Items[i] := '';
End;

Function TStringHash.FGetItem(Const Key: String): String;
Var
    k, x: Integer;
Begin
    If (self.FFindKey(Key, k, x)) Then
        result := self.f_Items[self.f_Keys[k][x].ItemIndex]
    Else
        Raise EHashFindError.CreateFmt('Key "%s" not found', [Key]);
End;

Procedure TStringHash.FMoveIndex(oldIndex, newIndex: Integer);
Begin
    self.f_Items[newIndex] := self.f_Items[oldIndex];
End;

Procedure TStringHash.FSetItem(Const Key, Value: String);
Var
    k, x, i: Integer;
Begin
    If (self.FFindKey(Key, k, x)) Then
        self.f_Items[self.f_Keys[k][x].ItemIndex] := Value
    Else
    Begin
    { New index entry, or recycle an old one. }
        i := self.FAllocItemIndex;
        If (i > High(self.f_Items)) Then
            SetLength(self.f_Items, i + 1);
        self.f_Items[i] := Value;
    { Add it to the hash. }
        SetLength(self.f_Keys[k], Length(self.f_Keys[k]) + 1);
        self.f_Keys[k][High(self.f_Keys[k])].Key := Key;
        self.f_Keys[k][High(self.f_Keys[k])].ItemIndex := i;
        self.f_Keys[k][High(self.f_Keys[k])].Hash := HashThis(Key);
    { Hash has been modified, so disallow Next. }
        self.f_NextAllowed := False;
    End;
End;

Function TStringHash.FIndexMax: Integer;
Begin
    result := High(self.f_Items);
End;

Procedure TStringHash.FTrimIndexes(count: Integer);
Begin
    SetLength(self.f_Items, count);
End;

Procedure TStringHash.FClearItems;
Begin
    SetLength(self.f_Items, 0);
End;

{ TIntegerHash }

Procedure TIntegerHash.FDeleteIndex(i: Integer);
Begin
    self.f_Items[i] := 0;
End;

Function TIntegerHash.FGetItem(Const Key: String): Integer;
Var
    k, x: Integer;
Begin
    If (self.FFindKey(Key, k, x)) Then
        result := self.f_Items[self.f_Keys[k][x].ItemIndex]
    Else
        Raise EHashFindError.CreateFmt('Key "%s" not found', [Key]);
End;

Procedure TIntegerHash.FMoveIndex(oldIndex, newIndex: Integer);
Begin
    self.f_Items[newIndex] := self.f_Items[oldIndex];
End;

Procedure TIntegerHash.FSetItem(Const Key: String; Value: Integer);
Var
    k, x, i: Integer;
Begin
    If (self.FFindKey(Key, k, x)) Then
        self.f_Items[self.f_Keys[k][x].ItemIndex] := Value
    Else
    Begin
    { New index entry, or recycle an old one. }
        i := self.FAllocItemIndex;
        If (i > High(self.f_Items)) Then
            SetLength(self.f_Items, i + 1);
        self.f_Items[i] := Value;
    { Add it to the hash. }
        SetLength(self.f_Keys[k], Length(self.f_Keys[k]) + 1);
        self.f_Keys[k][High(self.f_Keys[k])].Key := Key;
        self.f_Keys[k][High(self.f_Keys[k])].ItemIndex := i;
        self.f_Keys[k][High(self.f_Keys[k])].Hash := HashThis(Key);
    { Hash has been modified, so disallow Next. }
        self.f_NextAllowed := False;
    End;
End;

Function TIntegerHash.FIndexMax: Integer;
Begin
    result := High(self.f_Items);
End;

Procedure TIntegerHash.FTrimIndexes(count: Integer);
Begin
    SetLength(self.f_Items, count);
End;

Procedure TIntegerHash.FClearItems;
Begin
    SetLength(self.f_Items, 0);
End;

{ TObjectHash }

Procedure TObjectHash.FDeleteIndex(i: Integer);
Begin
    self.f_Items[i].Free;
    self.f_Items[i] := Nil;
End;

Function TObjectHash.FGetItem(Const Key: String): TObject;
Var
    k, x: Integer;
Begin
    If (self.FFindKey(Key, k, x)) Then
        result := self.f_Items[self.f_Keys[k][x].ItemIndex]
    Else
        Raise EHashFindError.CreateFmt('Key "%s" not found', [Key]);
End;

Procedure TObjectHash.FMoveIndex(oldIndex, newIndex: Integer);
Begin
    self.f_Items[newIndex] := self.f_Items[oldIndex];
End;

Procedure TObjectHash.FSetItem(Const Key: String; Value: TObject);
Var
    k, x, i: Integer;
Begin
    If (self.FFindKey(Key, k, x)) Then
    Begin
        self.f_Items[self.f_Keys[k][x].ItemIndex].Free;
        self.f_Items[self.f_Keys[k][x].ItemIndex] := Value;
    End
    Else
    Begin
    { New index entry, or recycle an old one. }
        i := self.FAllocItemIndex;
        If (i > High(self.f_Items)) Then
            SetLength(self.f_Items, i + 1);
        self.f_Items[i] := Value;
    { Add it to the hash. }
        SetLength(self.f_Keys[k], Length(self.f_Keys[k]) + 1);
        self.f_Keys[k][High(self.f_Keys[k])].Key := Key;
        self.f_Keys[k][High(self.f_Keys[k])].ItemIndex := i;
        self.f_Keys[k][High(self.f_Keys[k])].Hash := HashThis(Key);
    { Hash has been modified, so disallow Next. }
        self.f_NextAllowed := False;
    End;
End;

Function TObjectHash.FIndexMax: Integer;
Begin
    result := High(self.f_Items);
End;

Procedure TObjectHash.FTrimIndexes(count: Integer);
Begin
    SetLength(self.f_Items, count);
End;

Procedure TObjectHash.FClearItems;
Var
    i: Integer;
Begin
    For i := 0 To High(self.f_Items) Do
        If (Assigned(self.f_Items[i])) Then
            self.f_Items[i].Free;
    SetLength(self.f_Items, 0);
End;

Destructor TObjectHash.Destroy;
Var
    i: Integer;
Begin
    For i := 0 To High(self.f_Items) Do
        If (Assigned(self.f_Items[i])) Then
            self.f_Items[i].Free;
    Inherited;
End;

End.
