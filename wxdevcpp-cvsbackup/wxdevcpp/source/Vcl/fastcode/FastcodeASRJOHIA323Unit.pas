unit FastcodeASRJOHIA323Unit;

{Turn Off Range Checking and Overflow Checking within this Unit}
{$UNDEF RangeCheck}
{$IFOPT R+}
  {$R-}
  {$DEFINE RangeCheck}
{$ENDIF}
{$UNDEF OverflowCheck}
{$IFOPT Q+}
  {$Q-}
  {$DEFINE OverflowCheck}
{$ENDIF}

{$DEFINE AllowLengthShortcut} {Use String Header for String Length (2% Faster)}

interface

uses
  SysUtils;

{Equivalent of StringReplace for Non Multi Byte Character Sets}
function StringReplace_JOH_IA32_3(const S, OldPattern, NewPattern: AnsiString;
  Flags: TReplaceFlags): AnsiString;

implementation

var
  AnsiUpcase : packed array[Char] of Char;

{Non-Overlapping Move for Positive Counts}
procedure MoveEx(const Source; var Dest; Count: Integer);
const
  SMALLMOVESIZE = 36;
asm
  cmp     ecx, SMALLMOVESIZE
  ja      @Large
  lea     eax, [eax+ecx]
  lea     edx, [edx+ecx]
  jmp     dword ptr [@@FwdJumpTable+ecx*4]
@Large:
  push    ebx
  mov     ebx,edx
  fild    qword ptr [eax]
  add     eax,ecx {QWORD Align Writes}
  add     ecx,edx
  add     edx,7
  and     edx,-8
  sub     ecx,edx
  add     edx,ecx {Now QWORD Aligned}
  sub     ecx,16
  neg     ecx
@FwdLoop:
  fild    qword ptr [eax+ecx-16]
  fistp   qword ptr [edx+ecx-16]
  fild    qword ptr [eax+ecx-8]
  fistp   qword ptr [edx+ecx-8]
  add     ecx,16
  jle     @FwdLoop
  fistp   qword ptr [ebx]
  neg     ecx
  add     ecx,16
  pop     ebx
  jmp     dword ptr [@@FwdJumpTable+ecx*4]
  nop
  nop {Align Jump Table}
@@FwdJumpTable:
  dd      @@Done {Removes need to test for zero size Move}
  dd      @@Fwd01,@@Fwd02,@@Fwd03,@@Fwd04,@@Fwd05,@@Fwd06,@@Fwd07,@@Fwd08
  dd      @@Fwd09,@@Fwd10,@@Fwd11,@@Fwd12,@@Fwd13,@@Fwd14,@@Fwd15,@@Fwd16
  dd      @@Fwd17,@@Fwd18,@@Fwd19,@@Fwd20,@@Fwd21,@@Fwd22,@@Fwd23,@@Fwd24
  dd      @@Fwd25,@@Fwd26,@@Fwd27,@@Fwd28,@@Fwd29,@@Fwd30,@@Fwd31,@@Fwd32
  dd      @@Fwd33,@@Fwd34,@@Fwd35,@@Fwd36
@@Fwd36:
  mov     ecx,[eax-36]
  mov     [edx-36],ecx
@@Fwd32:
  mov     ecx,[eax-32]
  mov     [edx-32],ecx
@@Fwd28:
  mov     ecx,[eax-28]
  mov     [edx-28],ecx
@@Fwd24:
  mov     ecx,[eax-24]
  mov     [edx-24],ecx
@@Fwd20:
  mov     ecx,[eax-20]
  mov     [edx-20],ecx
@@Fwd16:
  mov     ecx,[eax-16]
  mov     [edx-16],ecx
@@Fwd12:
  mov     ecx,[eax-12]
  mov     [edx-12],ecx
@@Fwd08:
  mov     ecx,[eax-8]
  mov     [edx-8],ecx
@@Fwd04:
  mov     ecx,[eax-4]
  mov     [edx-4],ecx
  ret
@@Fwd35:
  mov     ecx,[eax-35]
  mov     [edx-35],ecx
@@Fwd31:
  mov     ecx,[eax-31]
  mov     [edx-31],ecx
@@Fwd27:
  mov     ecx,[eax-27]
  mov     [edx-27],ecx
@@Fwd23:
  mov     ecx,[eax-23]
  mov     [edx-23],ecx
@@Fwd19:
  mov     ecx,[eax-19]
  mov     [edx-19],ecx
@@Fwd15:
  mov     ecx,[eax-15]
  mov     [edx-15],ecx
@@Fwd11:
  mov     ecx,[eax-11]
  mov     [edx-11],ecx
@@Fwd07:
  mov     ecx,[eax-7]
  mov     [edx-7],ecx
  mov     ecx,[eax-4]
  mov     [edx-4],ecx
  ret
@@Fwd03:
  movzx   ecx, word ptr [eax-3]
  mov     [edx-3],cx
  movzx   ecx, byte ptr [eax-1]
  mov     [edx-1],cl
  ret
@@Fwd34:
  mov     ecx,[eax-34]
  mov     [edx-34],ecx
@@Fwd30:
  mov     ecx,[eax-30]
  mov     [edx-30],ecx
@@Fwd26:
  mov     ecx,[eax-26]
  mov     [edx-26],ecx
@@Fwd22:
  mov     ecx,[eax-22]
  mov     [edx-22],ecx
@@Fwd18:
  mov     ecx,[eax-18]
  mov     [edx-18],ecx
@@Fwd14:
  mov     ecx,[eax-14]
  mov     [edx-14],ecx
@@Fwd10:
  mov     ecx,[eax-10]
  mov     [edx-10],ecx
@@Fwd06:
  mov     ecx,[eax-6]
  mov     [edx-6],ecx
@@Fwd02:
  movzx   ecx, word ptr [eax-2]
  mov     [edx-2],cx
  ret
@@Fwd33:
  mov     ecx,[eax-33]
  mov     [edx-33],ecx
@@Fwd29:
  mov     ecx,[eax-29]
  mov     [edx-29],ecx
@@Fwd25:
  mov     ecx,[eax-25]
  mov     [edx-25],ecx
@@Fwd21:
  mov     ecx,[eax-21]
  mov     [edx-21],ecx
@@Fwd17:
  mov     ecx,[eax-17]
  mov     [edx-17],ecx
@@Fwd13:
  mov     ecx,[eax-13]
  mov     [edx-13],ecx
@@Fwd09:
  mov     ecx,[eax-9]
  mov     [edx-9],ecx
@@Fwd05:
  mov     ecx,[eax-5]
  mov     [edx-5],ecx
@@Fwd01:
  movzx   ecx, byte ptr [eax-1]
  mov     [edx-1],cl
@@Done:
end; {MoveEx}

{Fast Equivalent of Delphi 7 PosEx}
function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
asm
  push    ebx
  push    esi
  push    edx              {@Str}
  test    eax, eax
  jz      @@NotFound       {Exit if SubStr = ''}
  test    edx, edx
  jz      @@NotFound       {Exit if Str = ''}
  mov     esi, ecx
  mov     ecx, [edx-4]     {Length(Str)}
  mov     ebx, [eax-4]     {Length(SubStr)}
  add     ecx, edx
  sub     ecx, ebx         {Max Start Pos for Full Match}
  lea     edx, [edx+esi-1] {Set Start Position}
  cmp     edx, ecx
  jg      @@NotFound       {StartPos > Max Start Pos}
  cmp     ebx, 1           {Length(SubStr)}
  jle     @@SingleChar     {Length(SubStr) <= 1}
  push    edi
  push    ebp
  lea     edi, [ebx-2]     {Length(SubStr) - 2}
  mov     esi, eax
  movzx   ebx, [eax]       {Search Character}
@@Loop:                    {Compare 2 Characters per Loop}
  cmp     bl, [edx]
  jne     @@NotChar1
  mov     ebp, edi         {Remainder}
@@Char1Loop:
  movzx   eax, word ptr [esi+ebp]
  cmp     ax, [edx+ebp]
  jne     @@NotChar1
  sub     ebp, 2
  jnc     @@Char1Loop
  pop     ebp
  pop     edi
  jmp     @@SetResult
@@NotChar1:
  cmp     bl, [edx+1]
  jne     @@NotChar2
  mov     ebp, edi         {Remainder}
@@Char2Loop:
  movzx   eax, word ptr [esi+ebp]
  cmp     ax, [edx+ebp+1]
  jne     @@NotChar2
  sub     ebp, 2
  jnc     @@Char2Loop
  pop     ebp
  pop     edi
  jmp     @@CheckResult
@@NotChar2:
  add     edx, 2
  cmp     edx, ecx         {Next Start Position <= Max Start Position}
  jle     @@Loop
  pop     ebp
  pop     edi
  jmp     @@NotFound
@@SingleChar:
  jl      @@NotFound       {Needed for Zero-Length Non-NIL Strings}
  movzx   eax, [eax]       {Search Character}
@@CharLoop:
  cmp     al, [edx]
  je      @@SetResult
  cmp     al, [edx+1]
  je      @@CheckResult
  add     edx, 2
  cmp     edx, ecx
  jle     @@CharLoop
@@NotFound:
  xor     eax, eax
  pop     edx
  pop     esi
  pop     ebx
  ret
@@CheckResult:             {Check within String}
  cmp     edx, ecx
  jge     @@NotFound
  add     edx, 1
@@SetResult:
  pop     ecx              {@Str}
  pop     esi
  pop     ebx
  neg     ecx
  lea     eax, [edx+ecx+1]
end; {PosEx}

{Non Case Sensitive version of PosEx}
function PosExIgnoreCase(const SubStr, S: string; Offset: Cardinal = 1): Integer;
asm
  push    ebx
  push    esi
  push    edx              {@Str}
  test    eax, eax
  jz      @@NotFound       {Exit if SubStr = ''}
  test    edx, edx
  jz      @@NotFound       {Exit if Str = ''}
  mov     esi, ecx
  mov     ecx, [edx-4]     {Length(Str)}
  mov     ebx, [eax-4]     {Length(SubStr)}
  add     ecx, edx
  sub     ecx, ebx         {Max Start Pos for Full Match}
  lea     edx, [edx+esi-1] {Set Start Position}
  cmp     edx, ecx
  jg      @@NotFound       {StartPos > Max Start Pos}
  cmp     ebx, 1           {Length(SubStr)}
  jle     @@SingleChar     {Length(SubStr) <= 1}
  push    edi
  push    ebp
  lea     edi, [ebx-2]     {Length(SubStr) - 2}
  mov     esi, eax
  push    edi              {Save Remainder to Check = Length(SubStr) - 2}
  push    ecx              {Save Max Start Position}
  lea     edi, AnsiUpcase  {Uppercase Lookup Table}
  movzx   ebx, [eax]       {Search Character = 1st Char of SubStr}
  movzx   ebx, [edi+ebx]   {Convert to Uppercase}
@@Loop:                    {Loop Comparing 2 Characters per Loop}
  movzx   eax, [edx]       {Get Next Character}
  movzx   eax, [edi+eax]   {Convert to Uppercase}
  cmp     eax, ebx
  jne     @@NotChar1
  mov     ebp, [esp+4]     {Remainder to Check}
@@Char1Loop:
  movzx   eax, [esi+ebp]
  movzx   ecx, [edx+ebp]
  movzx   eax, [edi+eax]   {Convert to Uppercase}
  movzx   ecx, [edi+ecx]   {Convert to Uppercase}
  cmp     eax, ecx
  jne     @@NotChar1
  movzx   eax, [esi+ebp+1]
  movzx   ecx, [edx+ebp+1]
  movzx   eax, [edi+eax]   {Convert to Uppercase}
  movzx   ecx, [edi+ecx]   {Convert to Uppercase}
  cmp     eax, ecx
  jne     @@NotChar1
  sub     ebp, 2
  jnc     @@Char1Loop
  pop     ecx
  pop     edi
  pop     ebp
  pop     edi
  jmp     @@SetResult
@@NotChar1:
  movzx   eax, [edx+1]     {Get Next Character}
  movzx   eax, [edi+eax]   {Convert to Uppercase}
  cmp     bl, al
  jne     @@NotChar2
  mov     ebp, [esp+4]     {Remainder to Check}
@@Char2Loop:
  movzx   eax, [esi+ebp]
  movzx   ecx, [edx+ebp+1]
  movzx   eax, [edi+eax]   {Convert to Uppercase}
  movzx   ecx, [edi+ecx]   {Convert to Uppercase}
  cmp     eax, ecx
  jne     @@NotChar2
  movzx   eax, [esi+ebp+1]
  movzx   ecx, [edx+ebp+2]
  movzx   eax, [edi+eax]   {Convert to Uppercase}
  movzx   ecx, [edi+ecx]   {Convert to Uppercase}
  cmp     eax, ecx
  jne     @@NotChar2
  sub     ebp, 2
  jnc     @@Char2Loop
  pop     ecx
  pop     edi
  pop     ebp
  pop     edi
  jmp     @@CheckResult    {Check Match is within String Data}
@@NotChar2:
  add     edx, 2
  cmp     edx, [esp]       {Compate to Max Start Position}
  jle     @@Loop           {Loop until Start Position > Max Start Position}
  pop     ecx              {Dump Start Position}
  pop     edi              {Dump Remainder to Check}
  pop     ebp
  pop     edi
  jmp     @@NotFound
@@SingleChar:
  jl      @@NotFound       {Needed for Zero-Length Non-NIL Strings}
  lea     esi, AnsiUpcase
  movzx   ebx, [eax]       {Search Character = 1st Char of SubStr}
  movzx   ebx, [esi+ebx]   {Convert to Uppercase}
@@CharLoop:
  movzx   eax, [edx]
  movzx   eax, [esi+eax]   {Convert to Uppercase}
  cmp     eax, ebx
  je      @@SetResult
  movzx   eax, [edx+1]
  movzx   eax, [esi+eax]   {Convert to Uppercase}
  cmp     eax, ebx
  je      @@CheckResult
  add     edx, 2
  cmp     edx, ecx
  jle     @@CharLoop
@@NotFound:
  xor     eax, eax
  pop     edx
  pop     esi
  pop     ebx
  ret
@@CheckResult:             {Check Match is within String Data}
  cmp     edx, ecx
  jge     @@NotFound
  add     edx, 1           {OK - Adjust Result}
@@SetResult:               {Set Result Position}
  pop     ecx              {@Str}
  pop     esi
  pop     ebx
  neg     ecx
  lea     eax, [edx+ecx+1]
end; {PosExIgnoreCase}

{Replace all occurance of Old (Ignoring Case) with New in Non-Null String S}
procedure CharReplaceIC(var S: AnsiString; const Old, New: Char);
asm
  push  ebx
  push  edi
  push  esi
  mov   eax, [eax]         {@S}
  mov   ebx, ecx           {bl = New}
  lea   edi, AnsiUpcase
  and   edx, $FF           {edx = Old}
  mov   ecx, [eax-4]       {Length(S)}
  movzx edx, [edx+edi]     {edx = Uppercase(Old)}
  lea   esi, [eax+ecx]
  neg   ecx
@@Loop:
  movzx eax, [esi+ecx]     {Next Char}
  movzx eax, [eax+edi]     {Convert to Uppercase}
  cmp   eax, edx           {Compare Char}
  jne   @@Next
  mov   [esi+ecx], bl      {Replace Char}
@@Next:
  add   ecx, 1
  jnz   @@Loop
  pop   esi
  pop   edi
  pop   ebx
end;

{Replace all occurance of Old (Case Sensitive) with New in Non-Null String S}
procedure CharReplaceCS(var S: AnsiString; const Old, New: Char);
asm
  push  ebx
  mov   eax, [eax]    {@S}
  mov   ebx, ecx      {bl = New, dl = Old}
  mov   ecx, [eax-4]  {Length(S)}
  add   eax, ecx
  neg   ecx                                  
@@Loop:
  cmp   dl, [eax+ecx] {Compare Next Char}
  jne   @@Next
  mov   [eax+ecx], bl {Replace Char}
@@Next:
  add   ecx, 1
  jnz   @@Loop
  pop   ebx
end;

function StringReplace_JOH_IA32_3(const S, OldPattern, NewPattern: AnsiString;
  Flags: TReplaceFlags): AnsiString;
type
  TPosEx   = function(const SubStr, S: string; Offset: Cardinal = 1): Integer;
  TCharRep = procedure(var S : AnsiString; const Old, New : Char);
const
  InitialBufferSize = 16;
  PosExFunction : array[Boolean] of TPosEx   = (PosEx, PosExIgnoreCase);
  CharReplace   : array[Boolean] of TCharRep = (CharReplaceCS, CharReplaceIC);
var
  SrcLen, OldLen, NewLen, Found, Count, Start, Match, BufSize, BufMax : Integer;
  StaticBuffer : array[0..InitialBufferSize-1] of Integer;
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
          if (NewLen = 1) and (OldLen = 1) then
            begin
              SetLength(Result, SrcLen);
              MoveEx(Pointer(S)^, Pointer(Result)^, SrcLen);
              CharReplace[IgnoreCase](Result, OldPattern[1], NewPattern[1]);
              Exit;
            end;
          Found := PosExFunction[IgnoreCase](OldPattern, S, 1);
          if Found <> 0 then
            begin
              Buffer    := @StaticBuffer;
              BufMax    := InitialBufferSize;
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
              for Match := 0 to BufSize - 1 do
                begin
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
                end;
              Dec(SrcLen, Start);
              if SrcLen >= 0 then
                MoveEx(PSrc^, PRes^, SrcLen + 1);
              if BufMax <> InitialBufferSize then
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
    AnsiUpcase[Ch] := AnsiUpperCase(Ch)[1];
end.
