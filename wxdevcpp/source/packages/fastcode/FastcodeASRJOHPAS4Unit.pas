unit FastcodeASRJOHPAS4Unit;

{$DEFINE AllowLengthShortcut} {Use String Header for String Length (2% Faster)}

interface

uses
  Windows, SysUtils;

{Equivalent of StringReplace for Non Multi Byte Character Sets}
function StringReplace_JOH_PAS_4(const S, OldPattern, NewPattern: AnsiString;
                                Flags: TReplaceFlags): AnsiString;

implementation

var
  AnsiUpcase : packed array[Char] of Char;

{Non-Overlapping Move for Positive Counts}
procedure MoveEx(const Source; var Dest; Count: Integer);
var
  C, I : Cardinal;
  S, D : PIntegerArray;
begin
  if Count <= 4 then
    case Count of
      1 : PByte(@Dest)^ := PByte(@Source)^;
      2 : PWord(@Dest)^ := PWord(@Source)^;
      3 : begin
            PWord(@Dest)^ := PWord(@Source)^;
            PByte(Integer(@Dest)+2)^ := PByte(Integer(@Source)+2)^;
          end;
      4 : PInteger(@Dest)^ := PInteger(@Source)^
    end
  else
    begin
      C := Count - 4;
      PCardinal(Cardinal(@Dest) + C)^ := PCardinal(Cardinal(@Source) + C)^;
      C := (C + 3) shr 2;
      D := @Dest;
      S := @Source;
      I := 0;
      repeat
        D[I] := S[I];
        Inc(I);
      until I = C;
    end
end; {MoveEx}

function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
var
  StrLen, SubLen, Len : Integer;
  PStr, PSub, PMax    : PChar;
  FirstChar           : Char; {First Character of SubStr}
begin;
  Result := 0;
{$IFDEF AllowLengthShortcut}
  if S      = '' then Exit;
  if SubStr = '' then Exit;
  StrLen := PCardinal(Cardinal(S     ) - 4)^;
  SubLen := PCardinal(Cardinal(SubStr) - 4)^;
{$ELSE}
  SubLen := Length(SubStr);
  StrLen := Length(S);
{$ENDIF}
  if (SubLen = 0) then
    Exit;
  PSub   := Pointer(SubStr);
  PStr   := Pointer(S);
  PMax   := PStr + StrLen - SubLen; {Maximum Start Position}
{The following 3 Lines are the only Difference between Pos and PosEx}
  Inc(PStr, Offset - 1);
  if PStr > PMax then
    Exit;
  FirstChar := PSub^;
  if SubLen = 1 then
    repeat {Single Character Saarch}
      if PStr^ = FirstChar then
        begin
          Result := PStr + 1 - Pointer(S);
          Exit;
        end;
      if PStr[1] = FirstChar then
        begin
          if PStr < PMax then {Within Valid Range}
            Result := PStr + 2 - Pointer(S);
          Exit;
        end;
      Inc(PStr, 2);
    until PStr > PMax
  else
    begin {Multi-Character Search}
      Dec(SubLen, 2); {Characters to Check after Match}
      repeat
        if PStr^ = FirstChar then
          begin
            Len := SubLen;
            while True do
              begin
                if (PSub[Len  ] <> PStr[Len  ])
                or (PSub[Len+1] <> PStr[Len+1]) then
                  Break; {No Match}
                Dec(Len, 2);
                if Len < 0 then
                  begin {First Char already Checked}
                    Result := PStr + 1 - Pointer(S);
                    Exit;
                  end;
              end;
          end;
        if PStr[1] = FirstChar then
          begin
            Len := SubLen;
            while True do
              begin
                if (PSub[Len  ] <> PStr[Len+1])
                or (PSub[Len+1] <> PStr[Len+2]) then
                  Break; {No Match}
                Dec(Len, 2);
                if Len < 0 then
                  begin {First Char already Checked}
                    if PStr < PMax then {Within Valid Range}
                      Result := PStr + 2 - Pointer(S);
                    Exit;
                  end;
              end;
          end;
        Inc(PStr, 2);
      until PStr > PMax;
    end;
end; {PosEx}

{Non Case Sensitive version of PosEx}
function PosExIgnoreCase(const SubStr, S: string; Offset: Cardinal = 1): Integer;
var
  StrLen, SubLen, Len : Integer;
  PStr, PSub, PMax    : PChar;
  FirstChar           : Char; {First Character of SubStr}
begin;
  Result := 0;
{$IFDEF AllowLengthShortcut}
  if S      = '' then Exit;
  if SubStr = '' then Exit;
  StrLen := PCardinal(Cardinal(S     ) - 4)^;
  SubLen := PCardinal(Cardinal(SubStr) - 4)^;
{$ELSE}
  SubLen := Length(SubStr);
  StrLen := Length(S);
{$ENDIF}
  if (SubLen = 0) then
    Exit;
  PSub   := Pointer(SubStr);
  PStr   := Pointer(S);
  PMax   := PStr + StrLen - SubLen; {Maximum Start Position}
{The following 3 Lines are the only Difference between Pos and PosEx}
  Inc(PStr, Offset - 1);
  if PStr > PMax then
    Exit;
  FirstChar := AnsiUpcase[PSub^];
  if SubLen = 1 then
    repeat {Single Character Saarch}
      if AnsiUpcase[PStr^] = FirstChar then
        begin
          Result := PStr + 1 - Pointer(S);
          Exit;
        end;
      if AnsiUpcase[PStr[1]] = FirstChar then
        begin
          if PStr < PMax then {Within Valid Range}
            Result := PStr + 2 - Pointer(S);
          Exit;
        end;
      Inc(PStr, 2);
    until PStr > PMax
  else
    begin {Multi-Character Search}
      Dec(SubLen, 2); {Characters to Check after Match}
      repeat
        if AnsiUpcase[PStr^] = FirstChar then
          begin
            Len := SubLen;
            while True do
              begin
                if (AnsiUpcase[PSub[Len  ]] <> AnsiUpcase[PStr[Len  ]])
                or (AnsiUpcase[PSub[Len+1]] <> AnsiUpcase[PStr[Len+1]]) then
                  Break; {No Match}
                Dec(Len, 2);
                if Len < 0 then
                  begin {First Char already Checked}
                    Result := PStr + 1 - Pointer(S);
                    Exit;
                  end;
              end;
          end;
        if AnsiUpcase[PStr[1]] = FirstChar then
          begin
            Len := SubLen;
            while True do
              begin
                if (AnsiUpcase[PSub[Len  ]] <> AnsiUpcase[PStr[Len+1]])
                or (AnsiUpcase[PSub[Len+1]] <> AnsiUpcase[PStr[Len+2]]) then
                  Break; {No Match}
                Dec(Len, 2);
                if Len < 0 then
                  begin {First Char already Checked}
                    if PStr < PMax then {Within Valid Range}
                      Result := PStr + 2 - Pointer(S);
                    Exit;
                  end;
              end;
          end;
        Inc(PStr, 2);
      until PStr > PMax;
    end;
end; {PosExIgnoreCase}

{Replace all occurance of Old (Ignoring Case) with New in Non-Null String S}
procedure CharReplaceIC(var S: AnsiString; const Old, New: Char);
var
  I : Cardinal;
  P : PChar;
  C : Char;
begin
  C := AnsiUpcase[Old];
  P := Pointer(S);
{$IFDEF AllowLengthShortcut}
  for I := 0 to PCardinal(Cardinal(S)-4)^ - 1 do
{$ELSE}
  for I := 0 to Length(S) - 1 do
{$ENDIF}
    if AnsiUpcase[P[I]] = C then
      P[I] := New;
end;

{Replace all occurance of Old with New in Non-Null String S}
procedure CharReplaceCS(var S: AnsiString; const Old, New: Char);
var
  I : Cardinal;
  P : PChar;
begin
  P := Pointer(S);
{$IFDEF AllowLengthShortcut}
  for I := 0 to PCardinal(Cardinal(S)-4)^ - 1 do
{$ELSE}
  for I := 0 to Length(S) - 1 do
{$ENDIF}
    if P[I] = Old then
      P[I] := New;
end;

function StringReplace_JOH_PAS_4(const S, OldPattern, NewPattern: AnsiString;
                                    Flags: TReplaceFlags): AnsiString;
type
  TPosEx   = function(const SubStr, S: string; Offset: Cardinal = 1): Integer;
  TCharRep = procedure(var S : AnsiString; const Old, New : Char);
const
  StaticBufferSize = 16;
  PosExFunction : array[Boolean] of TPosEx   = (PosEx, PosExIgnoreCase);
  CharReplace   : array[Boolean] of TCharRep = (CharReplaceCS, CharReplaceIC);
var
  SrcLen, OldLen, NewLen, Found, Count, Start, Match, BufSize, BufMax : Integer;
  StaticBuffer : array[0..StaticBufferSize-1] of Integer;
  Buffer       : PIntegerArray;
  PSrc, PRes   : PChar;
  IgnoreCase   : Boolean;
begin
{$IFDEF AllowLengthShortcut}
  SrcLen := 0;
  if (S <> '') then
    SrcLen := PCardinal(Cardinal(S)-4)^;
  OldLen := 0;
  if (OldPattern <> '') then
    OldLen := PCardinal(Cardinal(OldPattern)-4)^;
  NewLen := 0;
  if (NewPattern <> '') then
    NewLen := PCardinal(Cardinal(NewPattern)-4)^;
{$ELSE}
  SrcLen := Length(S);
  OldLen := Length(OldPattern);
  NewLen := Length(NewPattern);
{$ENDIF}
  if (OldLen = 0) or (SrcLen < OldLen) then
    begin
      if SrcLen = 0 then
        Result := '' {Needed for Non-Nil Zero Length Strings}
      else
        Result := S
    end
  else
    begin
      IgnoreCase := rfIgnoreCase in Flags;
      if rfReplaceAll in Flags then
        begin
          if (OldLen = 1) and (NewLen = 1) then
            begin {Single Character Replacement}
              SetLength(Result, SrcLen);
              MoveEx(Pointer(S)^, Pointer(Result)^, SrcLen);
              CharReplace[IgnoreCase](Result, OldPattern[1], NewPattern[1]);
              Exit;
            end;
          Found := PosExFunction[IgnoreCase](OldPattern, S, 1);
          if Found <> 0 then
            begin
              Buffer    := @StaticBuffer;                                               
              BufMax    := StaticBufferSize;
              BufSize   := 1;
              Buffer[0] := Found;
              repeat
                Inc(Found, OldLen);
                Found := PosExFunction[IgnoreCase](OldPattern, S, Found);
                if Found > 0 then
                  begin
                    if BufSize = BufMax then
                      begin {Create or Expand Dynamic Buffer}
                        BufMax := BufMax + (BufMax shr 1); {Grow by 50%}
                        if Buffer = @StaticBuffer then
                          begin {Create Dynamic Buffer}
                            GetMem(Buffer, BufMax * SizeOf(Integer));
                            MoveEx(StaticBuffer, Buffer^, SizeOf(StaticBuffer));
                          end
                        else {Expand Dynamic Buffer}
                          ReallocMem(Buffer, BufMax * SizeOf(Integer));
                      end;
                    Buffer[BufSize] := Found;
                    Inc(BufSize);
                  end
              until Found = 0;
              SetLength(Result, SrcLen + (BufSize * (NewLen - OldLen)));
              PSrc := Pointer(S);
              PRes := Pointer(Result);
              Start := 1;
              Match := 0;
              repeat
                Found := Buffer[Match];
                Count := Found - Start;
                Start := Found + OldLen;
                if Count > 0 then
                  begin
                    MoveEx(PSrc^, PRes^, Count);
                    Inc(PRes, Count);
                  end;
                Inc(PSrc, Count + OldLen);
                MoveEx(Pointer(NewPattern)^, PRes^, NewLen);
                Inc(PRes, NewLen);
                Inc(Match);
              until Match = BufSize;
              Dec(SrcLen, Start);
              if SrcLen >= 0 then
                MoveEx(PSrc^, PRes^, SrcLen + 1);
              if BufMax <> StaticBufferSize then
                FreeMem(Buffer); {Free Dynamic Buffwe if Created}
            end
          else {No Matches Found}
            Result := S
        end
      else
        begin {Replace First Occurance Only}
          Found := PosExFunction[IgnoreCase](OldPattern, S, 1);
          if Found <> 0 then
            begin {Match Found}
              SetLength(Result, SrcLen - OldLen + NewLen);
              Dec(Found);
              PSrc := Pointer(S);
              PRes := Pointer(Result);
              if NewLen = OldLen then
                begin
                  MoveEx(PSrc^, PRes^, SrcLen);
                  Inc(PRes, Found);
                  MoveEx(Pointer(NewPattern)^, PRes^, NewLen);
                end
              else
                begin
                  MoveEx(PSrc^, PRes^, Found);
                  Inc(PRes, Found);
                  Inc(PSrc, Found + OldLen);
                  MoveEx(Pointer(NewPattern)^, PRes^, NewLen);
                  Inc(PRes, NewLen);
                  MoveEx(PSrc^, PRes^, SrcLen - Found - OldLen);
                end;
            end
          else {No Matches Found}
            Result := S
        end;
    end;
end;

var
  Ch : Char;
initialization
  for Ch := #0 to #255 do
    AnsiUpcase[Ch] := Ch;
  CharUpperBuff(@AnsiUpcase, 256);
end. //Size = 1663 Bytes + 256 Byte Table = 1919 Bytes
