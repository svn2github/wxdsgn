unit FastcodePosUnit;

(* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Fastcode
 *
 * The Initial Developer of the Original Code is Fastcode
 *
 * Portions created by the Initial Developer are Copyright (C) 2002-2005
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 * Charalabos Michael <chmichael@creationpower.com>
 * John O'Harrow <john@elmcrest.demon.co.uk>
 * Aleksandr Sharahov
 *
 * BV Version: 5.50
 * ***** END LICENSE BLOCK ***** *)

interface

{$I Fastcode.inc}

type
  FastcodePosFunction = function(const SubStr: AnsiString; const Str: AnsiString): Integer;

{Functions shared between Targets}
function Pos_JOH_IA32_6(const SubStr : AnsiString; const Str : AnsiString) : Integer;
function Pos_JOH_SSE2_3(const SubStr : AnsiString; const Str : AnsiString) : Integer;
function Pos_Sha_Pas_2(const SubStr: AnsiString; const Str: AnsiString): Integer;

{Functions not shared between Targets}
function Pos_JOH_IA32_5(const SubStr : AnsiString; const Str : AnsiString) : Integer;

const
  Version = '0.5 beta 2';

  FastcodePosP4R: FastcodePosFunction = Pos_JOH_IA32_5;
  FastcodePosP4N: FastcodePosFunction = Pos_JOH_IA32_6;
  FastcodePosPMY: FastcodePosFunction = Pos_JOH_SSE2_3;
  FastcodePosPMD: FastcodePosFunction = Pos_JOH_SSE2_3;
  FastcodePosAMD64: FastcodePosFunction = Pos_JOH_IA32_6;
  FastcodePosAMD64_SSE3: FastcodePosFunction = Pos_JOH_IA32_6;
  FastCodePosIA32SizePenalty: FastCodePosFunction = Pos_JOH_IA32_6;
  FastcodePosIA32: FastcodePosFunction = Pos_JOH_IA32_6;
  FastcodePosMMX: FastcodePosFunction = Pos_JOH_IA32_6;
  FastCodePosSSESizePenalty: FastCodePosFunction = Pos_JOH_IA32_6;
  FastcodePosSSE: FastcodePosFunction = Pos_JOH_IA32_6;
  FastcodePosSSE2: FastcodePosFunction = Pos_JOH_IA32_6;
  FastCodePosPascalSizePenalty: FastCodePosFunction = Pos_Sha_Pas_2;
  FastCodePosPascal: FastCodePosFunction = Pos_Sha_Pas_2;

function PosStub(const substr: AnsiString; const s: AnsiString): Integer;

implementation

function Pos_JOH_IA32_5(const SubStr : AnsiString; const Str : AnsiString) : Integer;
asm
  cmp     eax, 1
  sbb     ecx, ecx         {-1 if SubStr = '' else 0}
  cmp     edx, 1
  sbb     ecx, 0           {Negative if Str = '' or SubStr = ''}
  jl      @@InvalidInput
  sub     esp, 20
  mov     [esp], ebx       {Save Registers}
  mov     [esp+4], edi
  mov     [esp+8], esi
  mov     [esp+12], ebp
  mov     [esp+16], edx    {Save Start Position}
  mov     esi, [edx-4]     {Length(Str)}
  mov     edi, [eax-4]     {Length(SubStr)}
  sub     esi, 1           {Length(Str) - 1}
  sbb     ecx, ecx         {Negative if Length(Str) = 0}
  sub     edi, 1           {Length(SubStr) - 1}
  sbb     ecx, 0           {Negative if Length(Str) = 0 or Length(SubStr) = 0}
  jl      @@NotFound       {Exit if Length(Str) = 0 or Length(SubStr) = 0}
  add     esi, edx         {Last Character Position in Str}
  lea     ebx, [eax+edi]   {Last Character Position in SubStr}
  add     edx, edi         {Search Start Position within Str for Last Char}
  not     edi              {- Length(SubStr)}
  movzx   eax, [ebx]       {Last Character of SubStr}
  mov     ah, al
  mov     ecx, eax
  shl     eax, 16
  or      ecx, eax         {All 4 Bytes = Last Character of SubStr}
@@MainLoop:
  lea     eax, [edx+4]
  cmp     eax, esi
  jae     @@Remainder      {1 to 4 Positions Remaining}
  mov     eax, [edx]       {Check Next 4 Bytes of Str}
  add     edx, 4           {Ready for Next Loop}
  xor     eax, ecx         {Zero Byte at each Matching Position}
  lea     ebp, [eax-$01010101]
  not     eax
  and     eax, ebp
  and     eax, $80808080   {Set Byte to $80 at each Matching Position else $00}
  jz      @@MainLoop       {Loop Until any Match on Last Character Found}
  bsf     eax, eax         {Find First Match Bit}
  shr     eax, 3           {Byte Offset of First Match (0..3)}
  lea     edx, [eax+edx-3] {Address of First Match on Last Character + 1}
@@Check:
  cmp     edi, -1
  je      @@SetResult      {Exit on Match if Lenght(SubStr) = 1}
  movzx   eax, word ptr [edi+ebx+1] {Compare First 2 Characters}
  cmp     ax, [edi+edx]
  jne     @@MainLoop       {No Match on First 2 Characters}
  cmp     edi, -4
  jle     @@Long           {Length(SubStr) >= 4}
@@SetResult:               {Full Match om 2 or 3 Character String}
  lea     eax, [edx+edi+1] {Calculate and Return Result}
  sub     eax, [esp+16]    {Subtract Start Position}
  jmp     @@Finished
@@InvalidInput:
  xor     eax, eax
  ret
@@Long:                    {Length(SubStr) >= 4}
  mov     eax, [ebx-3]     {Compare Last 4 Characters of Str and SubStr}
  cmp     eax, [edx-4]
  jne     @@MainLoop       {No Match on Last 4 Characters}
  lea     ebp, [edi+6-3]   {First 2 and Last 4 Characters already Matched}
@@MainCompare:             {Compare Remaining Characters}
  add     ebp, 4           {Compare 4 Characters per Loop}
  jg      @@SetResult      {All Characters Matched}
  mov     eax, [ebp+ebx-4]
  cmp     eax, [ebp+edx-5]
  je      @@MainCompare    {Match on Next 4 Characters}
  jmp     @@MainLoop       {No Match}
@@Remainder:
  add     edx, 1
  cmp     cl, [edx-1]
  je      @@Check          {Match on Last Character - Check Remainder}
  cmp     edx, esi
  jbe     @@Remainder      {More Positions Available}
@@NotFound:
  xor     eax, eax         {No Match Found - Return 0}
@@Finished:
  mov     ebx, [esp]       {Restore Registers}
  mov     edi, [esp+4]
  mov     esi, [esp+8]
  mov     ebp, [esp+12]
  add     esp, 20
end; {Pos}

function Pos_JOH_IA32_6(const SubStr : AnsiString; const Str : AnsiString) : Integer;
asm {Slightly Cut-Down version of PosEx_JOH_6}
  push    ebx
  cmp     eax, 1
  sbb     ebx, ebx         {-1 if SubStr = '' else 0}
  sub     edx, 1           {-1 if S = ''}
  sbb     ebx, 0           {Negative if S = '' or SubStr = '' else 0}
  jl      @@InvalidInput
  push    edi
  push    esi
  push    ebp
  push    edx
  mov     edi, [eax-4]     {Length(SubStr)}
  mov     esi, [edx-3]     {Length(S)}
  cmp     edi, esi
  jg      @@NotFound       {Offset to High for a Match}
  test    edi, edi
  jz      @@NotFound       {Length(SubStr = 0)}
  lea     ebp, [eax+edi]   {Last Character Position in SubStr + 1}
  add     esi, edx         {Last Character Position in S}
  movzx   eax, [ebp-1]     {Last Character of SubStr}
  add     edx, edi         {Search Start Position in S for Last Character}
  mov     ah, al
  neg     edi              {-Length(SubStr)}
  mov     ecx, eax
  shl     eax, 16
  or      ecx, eax         {All 4 Bytes = Last Character of SubStr}
@@MainLoop:
  add     edx, 4
  cmp     edx, esi
  ja      @@Remainder      {1 to 4 Positions Remaining}
  mov     eax, [edx-4]     {Check Next 4 Bytes of S}
  xor     eax, ecx         {Zero Byte at each Matching Position}
  lea     ebx, [eax-$01010101]
  not     eax
  and     eax, ebx
  and     eax, $80808080   {Set Byte to $80 at each Match Position else $00}
  jz      @@MainLoop       {Loop Until any Match on Last Character Found}
  bsf     eax, eax         {Find First Match Bit}
  shr     eax, 3           {Byte Offset of First Match (0..3)}
  lea     edx, [eax+edx-3] {Address of First Match on Last Character + 1}
@@Compare:
  cmp     edi, -4
  jle     @@Large          {Lenght(SubStr) >= 4}
  cmp     edi, -1
  je      @@SetResult      {Exit with Match if Lenght(SubStr) = 1}
  movzx   eax, word ptr [ebp+edi] {Last Char Matches - Compare First 2 Chars}
  cmp     ax, [edx+edi]
  jne     @@MainLoop       {No Match on First 2 Characters}
@@SetResult:               {Full Match}
  lea     eax, [edx+edi]   {Calculate and Return Result}
  pop     edx
  pop     ebp
  pop     esi
  pop     edi
  pop     ebx
  sub     eax, edx         {Subtract Start Position}
  ret
@@NotFound:
  pop     edx              {Dump Start Position}
  pop     ebp
  pop     esi
  pop     edi
@@InvalidInput:
  pop     ebx
  xor     eax, eax         {No Match Found - Return 0}
  ret
@@Remainder:               {Check Last 1 to 4 Characters}
  mov     eax, [esi-3]     {Last 4 Characters of S - May include Length Bytes}
  xor     eax, ecx         {Zero Byte at each Matching Position}
  lea     ebx, [eax-$01010101]
  not     eax
  and     eax, ebx
  and     eax, $80808080   {Set Byte to $80 at each Match Position else $00}
  jz      @@NotFound       {No Match Possible}
  lea     eax, [edx-4]     {Check Valid Match Positions}
  cmp     cl, [eax]
  lea     edx, [eax+1]
  je      @@Compare
  cmp     edx, esi
  ja      @@NotFound
  lea     edx, [eax+2]
  cmp     cl, [eax+1]
  je      @@Compare
  cmp     edx, esi
  ja      @@NotFound
  lea     edx, [eax+3]
  cmp     cl, [eax+2]
  je      @@Compare
  cmp     edx, esi
  ja      @@NotFound
  lea     edx, [eax+4]
  jmp     @@Compare
@@Large:
  mov     eax, [ebp-4]     {Compare Last 4 Characters of S and SubStr}
  cmp     eax, [edx-4]
  jne     @@MainLoop       {No Match on Last 4 Characters}
  mov     ebx, edi
@@CompareLoop:             {Compare Remaining Characters}
  add     ebx, 4           {Compare 4 Characters per Loop}
  jge     @@SetResult      {All Characters Matched}
  mov     eax, [ebp+ebx-4]
  cmp     eax, [edx+ebx-4]
  je      @@CompareLoop    {Match on Next 4 Characters}
  jmp     @@MainLoop       {No Match}
end;

function Pos_JOH_SSE2_3(const SubStr : AnsiString; const Str : AnsiString) : Integer;
asm
  test      eax, eax
  jz        @NotFoundExit    {Exit if SurStr = ''}
  test      edx, edx
  jz        @NotFound        {Exit if Str = ''}
  mov       ecx, [edx-4]     {Length(Str)}
  cmp       [eax-4], 1       {Length SubStr = 1?}
  je        @SingleChar      {Yes - Exit via CharPos}
  jl        @NotFound        {Exit if Length(SubStr) < 1}
  sub       ecx, [eax-4]     {Subtract Length(SubStr)}
  jl        @NotFound        {Exit if Length(SubStr) > Length(Str)}
  push      esi              {Save Registers}
  push      edi
  push      ebx
  push      ebp
  mov       esi, eax         {Start Address of SubStr}
  lea       edi, [ecx+1]     {Initial Remainder Count}
  mov       eax, [eax]       {AL = 1st Char of SubStr}
  mov       ebp, edx         {Start Address of Str}
  mov       ebx, eax         {Maintain 1st Search Char in BL}
@StrLoop:
  mov       eax, ebx         {AL  = 1st char of SubStr}
  mov       ecx, edi         {Remaining Length}
  push      edx              {Save Start Position}
  call      @CharPos         {Search for 1st Character}
  pop       edx              {Restore Start Position}
  test      eax, eax         {Result = 0?}
  jz        @StrExit         {Exit if 1st Character Not Found}
  mov       ecx, [esi-4]     {Length SubStr}
  add       edx, eax         {Update Start Position for Next Loop}
  sub       edi, eax         {Update Remaining Length for Next Loop}
  sub       ecx, 1           {Remaining Characters to Compare}
@StrCheck:
  mov       ax, [edx+ecx-2]  {Compare Next Char of SubStr and Str}
  cmp       ax, [esi+ecx-1]
  jne       @StrLoop         {Different - Return to First Character Search}
  sub       ecx, 2
  jg        @StrCheck        {Check each Remaining Character}
  mov       eax, edx         {All Characters Matched - Calculate Result}
  sub       eax, ebp
@StrExit:
  pop       ebp              {Restore Registers}
  pop       ebx
  pop       edi
  pop       esi
  ret
@NotFound:
  xor       eax, eax         {Return 0}
@NotFoundExit:
  ret
@SingleChar:
  mov       al, [eax]        {Search Character}
@CharPos:
  PUSH      EBX
  MOV       EBX, EAX
  CMP       ECX, 16
  JL        @@Small
@@NotSmall:
  MOV       AH, AL           {Fill each Byte of XMM1 with AL}
  MOVD      XMM1, EAX
  PSHUFLW   XMM1, XMM1, 0
  PSHUFD    XMM1, XMM1, 0
@@First16:
  MOVUPS    XMM0, [EDX]      {Unaligned}
  PCMPEQB   XMM0, XMM1       {Compare First 16 Characters}
  PMOVMSKB  EAX, XMM0
  TEST      EAX, EAX
  JNZ       @@FoundStart     {Exit on any Match}
  CMP       ECX, 32
  JL        @@Medium         {If Length(Str) < 32, Check Remainder}
@@Align:
  SUB       ECX, 16          {Align Block Reads}
  PUSH      ECX
  MOV       EAX, EDX
  NEG       EAX
  AND       EAX, 15
  ADD       EDX, ECX
  NEG       ECX
  ADD       ECX, EAX
@@Loop:
  MOVAPS    XMM0, [EDX+ECX]  {Aligned}
  PCMPEQB   XMM0, XMM1       {Compare Next 16 Characters}
  PMOVMSKB  EAX, XMM0
  TEST      EAX, EAX
  JNZ       @@Found          {Exit on any Match}
  ADD       ECX, 16
  JLE       @@Loop
@Remainder:
  POP       EAX              {Check Remaining Characters}
  ADD       EDX, 16
  ADD       EAX, ECX         {Count from Last Loop End Position}
  JMP       DWORD PTR [@@JumpTable2-ECX*4]

@@NullString:
  XOR       EAX, EAX         {Result = 0}
  RET

@@FoundStart:
  BSF       EAX, EAX         {Get Set Bit}
  POP       EBX
  ADD       EAX, 1           {Set Result}
  RET

@@Found:
  POP       EDX
  BSF       EAX, EAX         {Get Set Bit}
  ADD       EDX, ECX
  POP       EBX
  LEA       EAX, [EAX+EDX+1] {Set Result}
  RET

@@Medium:
  ADD       EDX, ECX         {End of String}
  MOV       EAX, 16          {Count from 16}
  JMP       DWORD PTR [@@JumpTable1-64-ECX*4]

@@Small:
  ADD       EDX, ECX         {End of String}
  XOR       EAX, EAX         {Count from 0}
  JMP       DWORD PTR [@@JumpTable1-ECX*4]

  nop; nop                   {Aligb Jump Tables}

@@JumpTable1:
  DD        @@NotFound, @@01, @@02, @@03, @@04, @@05, @@06, @@07
  DD        @@08, @@09, @@10, @@11, @@12, @@13, @@14, @@15, @@16

@@JumpTable2:
  DD        @@16, @@15, @@14, @@13, @@12, @@11, @@10, @@09, @@08
  DD        @@07, @@06, @@05, @@04, @@03, @@02, @@01, @@NotFound

@@16:
  ADD       EAX, 1
  CMP       BL, [EDX-16]
  JE        @@Done
@@15:
  ADD       EAX, 1
  CMP       BL, [EDX-15]
  JE        @@Done
@@14:
  ADD       EAX, 1
  CMP       BL, [EDX-14]
  JE        @@Done
@@13:
  ADD       EAX, 1
  CMP       BL, [EDX-13]
  JE        @@Done
@@12:
  ADD       EAX, 1
  CMP       BL, [EDX-12]
  JE        @@Done
@@11:
  ADD       EAX, 1
  CMP       BL, [EDX-11]
  JE        @@Done
@@10:
  ADD       EAX, 1
  CMP       BL, [EDX-10]
  JE        @@Done
@@09:
  ADD       EAX, 1
  CMP       BL, [EDX-9]
  JE        @@Done
@@08:
  ADD       EAX, 1
  CMP       BL, [EDX-8]
  JE        @@Done
@@07:
  ADD       EAX, 1
  CMP       BL, [EDX-7]
  JE        @@Done
@@06:
  ADD       EAX, 1
  CMP       BL, [EDX-6]
  JE        @@Done
@@05:
  ADD       EAX, 1
  CMP       BL, [EDX-5]
  JE        @@Done
@@04:
  ADD       EAX, 1
  CMP       BL, [EDX-4]
  JE        @@Done
@@03:
  ADD       EAX, 1
  CMP       BL, [EDX-3]
  JE        @@Done
@@02:
  ADD       EAX, 1
  CMP       BL, [EDX-2]
  JE        @@Done
@@01:
  ADD       EAX, 1
  CMP       BL, [EDX-1]
  JE        @@Done
@@NotFound:
  XOR       EAX, EAX
@@Done:
  POP       EBX
end;

function Pos_Sha_Pas_2(const SubStr: AnsiString; const Str: AnsiString): Integer;
var
  len, lenSub: integer;
  ch: char;
  p, pSub, pStart, pStop: pchar;
label
  Ret, Ret0, Ret1, Next0, Next1;
begin;
  p:=pointer(Str);
  pSub:=pointer(SubStr);

  if (p=nil) or (pSub=nil) then begin;
    Result:=0;
    exit;
    end;

  len:=pinteger(p-4)^;
  lenSub:=pinteger(pSub-4)^;
  if (len<lenSub) or (lenSub<=0) then begin;
    Result:=0;
    exit;
    end;

  lenSub:=lenSub-1;
  pStop:=p+len;
  p:=p+lenSub;
  pSub:=pSub+lenSub;
  pStart:=p;

  ch:=pSub[0];

  if lenSub=0 then begin;
    repeat;
      if ch=p[0] then goto Ret0;
      if ch=p[1] then goto Ret1;
      p:=p+2;
      until p>=pStop;
    Result:=0;
    exit;
    end;

  lenSub:=-lenSub;
  repeat;
    if ch=p[0] then begin;
      len:=lenSub;
      repeat;
        if psub[len]<>p[len] then goto Next0;
        if psub[len+1]<>p[len+1] then goto Next0;
        len:=len+2;
        until len>=0;
      goto Ret0;
Next0:end;

    if ch=p[1] then begin;
      len:=lenSub;
      repeat;
        if psub[len]<>p[len+1] then goto Next1;
        if psub[len+1]<>p[len+2] then goto Next1;
        len:=len+2;
        until len>=0;
      goto Ret1;
Next1:end;

    p:=p+2;
    until p>=pStop;
  Result:=0;
  exit;

Ret1:
  p:=p+2;
  if p<=pStop then goto Ret;
  Result:=0;
  exit;
Ret0:
  inc(p);
Ret:
  Result:=p-pStart;
end;

function PosStub(const substr: AnsiString; const s: AnsiString): Integer;
asm
{$IFDEF DELPHI9}
  call System.Pos;
{$ELSE}
  call System.@LStrPos;
{$ENDIF}
end;

end.
