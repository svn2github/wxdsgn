unit FastcodeStrCopyUnit;

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
 * Atle Smelvar
 *
 * BV Version: 3.61
 * ***** END LICENSE BLOCK ***** *)

interface

{$I Fastcode.inc}

type
  FastcodeStrCopyFunction = function(Dest: PChar; const Source: PChar): PChar;

{Functions shared between Targets}
function StrCopy_JOH_IA32_8(Dest: PChar; const Source: PChar): PChar;
function StrCopy_AS_IA32_5(Dest: PChar; const Source: PChar): PChar;

{Functions not shared between Targets}
function StrCopy_Sha_IA32_3(Dest: PChar; const Source: PChar): PChar;
function StrCopy_JOH_PAS_1(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Sha_Pas_1(Dest: PChar; const Source: PChar): PChar;

const
  Version = '0.5 beta 2';

  //temporary replaced StrCopy_JOH_IA32_5 with StrCopy_JOH_IA32_8

  FastcodeStrCopyP4R: FastcodeStrCopyFunction = StrCopy_Sha_IA32_3;
  FastcodeStrCopyP4N: FastcodeStrCopyFunction = StrCopy_JOH_IA32_8;
  FastcodeStrCopyPMY: FastcodeStrCopyFunction = StrCopy_JOH_IA32_8;
  FastcodeStrCopyPMD: FastcodeStrCopyFunction = StrCopy_JOH_IA32_8;
  FastcodeStrCopyAMD64: FastcodeStrCopyFunction = StrCopy_AS_IA32_5;
  FastcodeStrCopyAMD64_SSE3: FastcodeStrCopyFunction = StrCopy_AS_IA32_5;
  FastCodeStrCopyIA32SizePenalty: FastCodeStrCopyFunction = StrCopy_JOH_IA32_8;
  FastcodeStrCopyIA32: FastcodeStrCopyFunction = StrCopy_JOH_IA32_8;
  FastcodeStrCopyMMX: FastcodeStrCopyFunction = StrCopy_JOH_IA32_8;
  FastCodeStrCopySSESizePenalty: FastCodeStrCopyFunction = StrCopy_JOH_IA32_8;
  FastcodeStrCopySSE: FastcodeStrCopyFunction = StrCopy_JOH_IA32_8;
  FastcodeStrCopySSE2: FastcodeStrCopyFunction = StrCopy_JOH_IA32_8;
  FastCodeStrCopyPascalSizePenalty: FastCodeStrCopyFunction = StrCopy_JOH_PAS_1;
  FastCodeStrCopyPascal: FastCodeStrCopyFunction = StrCopy_Sha_Pas_1;

procedure StrCopyStub;

implementation

uses
  SysUtils;

function StrCopy_Sha_IA32_3(Dest: PChar; const Source: PChar): PChar;
asm
  sub edx,eax;
  test eax, 1;
  push eax;
  jz @loop;
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; mov [eax+00],cl; jz @ret;
  add eax, 1;
@loop:
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; jz @ret00;
  movzx ecx,word ptr[eax+edx+00]; cmp ecx,255; mov [eax+00],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+02]; test cl, cl; jz @ret02;
  movzx ecx,word ptr[eax+edx+02]; cmp ecx,255; mov [eax+02],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+04]; test cl, cl; jz @ret04;
  movzx ecx,word ptr[eax+edx+04]; cmp ecx,255; mov [eax+04],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+06]; test cl, cl; jz @ret06;
  movzx ecx,word ptr[eax+edx+06]; cmp ecx,255; mov [eax+06],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+08]; test cl, cl; jz @ret08;
  movzx ecx,word ptr[eax+edx+08]; cmp ecx,255; mov [eax+08],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+10]; test cl, cl; jz @ret10;
  movzx ecx,word ptr[eax+edx+10]; cmp ecx,255; mov [eax+10],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+12]; test cl, cl; jz @ret12;
  movzx ecx,word ptr[eax+edx+12]; cmp ecx,255; mov [eax+12],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+14]; test cl, cl; jz @ret14;
  movzx ecx,word ptr[eax+edx+14]; mov [eax+14],cx;
  add eax,16;
  cmp ecx,255; ja @loop;
@ret:
  pop eax; ret;
@ret00:
  mov [eax+00],cl; pop eax; ret;
@ret02:
  mov [eax+02],cl; pop eax; ret;
@ret04:
  mov [eax+04],cl; pop eax; ret;
@ret06:
  mov [eax+06],cl; pop eax; ret;
@ret08:
  mov [eax+08],cl; pop eax; ret;
@ret10:
  mov [eax+10],cl; pop eax; ret;
@ret12:
  mov [eax+12],cl; pop eax; ret;
@ret14:
  mov [eax+14],cl; pop eax; //ret;
end;

function StrCopy_JOH_IA32_8(Dest: PChar; const Source: PChar): PChar;
asm {Size = 144 Bytes}
  mov   ecx, edx
  sub   ecx, eax
  cmp   ecx, 4
  jb    @@Overlap            {Source/Dest Overlap}
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Exit
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Exit
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Exit
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Exit
  push  eax
  push  ebx
  push  edi
  mov   ecx, edx             {DWORD Align Reads}
  and   edx, -4
  sub   ecx, edx
  sub   eax, ecx
@@Loop:
  add   edx, 4               {4 Chars per Loop}
  add   eax, 4
  mov   ecx, [edx]
  mov   ebx, ecx
  lea   edi, [ecx-$01010101]
  not   ecx
  and   ecx, edi
  test  ecx, $80808080
  jnz   @@Remainder          {#0 Found}
  mov   [eax], ebx
  jmp   @@Loop               {Loop until any #0 Found}
@@Remainder:
  mov   [eax], bl            {Copy Remainder}
  test  bl, bl
  jz    @@Done
  mov   [eax+1], bh
  test  bh, bh
  jz    @@Done
  movzx ecx, word ptr [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  mov   [eax+3], ch
@@Done:
  pop   edi
  pop   ebx
  pop   eax
  ret
@@Overlap:
  push  eax
@@Next:
  movzx ecx, [edx]
  mov   [eax], cl
  add   eax, 1
  add   edx, 1
  test  cl, cl
  jnz   @@Next
  pop   eax
@@Exit:
end;

function StrCopy_AS_IA32_5(Dest: PChar; const Source: PChar): PChar;
asm

  push    eax
  sub     edx, eax

@Loopme:

  xor     ecx, ecx
  xor     cl, [eax+edx]
  jz     @Move1

  xor     ch, [eax+edx+1]
  mov     [eax], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+2]
  jz     @Move2

  xor     ch, [eax+edx+3]
  mov     [eax+2], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+4]
  jz     @Move3

  xor     ch, [eax+edx+5]
  mov     [eax+4], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+6]
  jz     @Move4

  xor     ch, [eax+edx+7]
  mov     [eax+6], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+8]
  jz     @Move5

  xor     ch, [eax+edx+9]
  mov     [eax+8], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+10]
  jz     @Move6

  xor     ch, [eax+edx+11]
  mov     [eax+10], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+12]
  jz     @Move7

  xor     ch, [eax+edx+13]
  mov     [eax+12], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+14]
  jz     @Move8

  xor     ch, [eax+edx+15]
  mov     [eax+14], cx
  jnz    @Block2

@Endit1:

  pop     eax
  ret

@Move1:

  mov     [eax], cl
  pop     eax
  ret

@Move2:

  mov     [eax+2], cl
  pop     eax
  ret

@Move3:

  mov     [eax+4], cl
  pop     eax
  ret

@Move4:

  mov     [eax+6], cl
  pop     eax
  ret

@Move5:

  mov     [eax+8], cl
  pop     eax
  ret

@Move6:

  mov     [eax+10], cl
  pop     eax
  ret

@Move7:

  mov     [eax+12], cl
  pop     eax
  ret

@Move8:

  mov     [eax+14], cl
  pop     eax
  ret

@block2:

  xor     ecx, ecx
  xor     cl, [eax+edx+16]
  jz      @Move9

  xor     ch, [eax+edx+17]
  mov     [eax+16], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+18]
  jz      @Move10

  xor     ch, [eax+edx+19]
  mov     [eax+18], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+20]
  jz      @Move11

  xor     ch, [eax+edx+21]
  mov     [eax+20], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+22]
  jz       @Move12

  xor     ch, [eax+edx+23]
  mov     [eax+22], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+24]
  jz      @Move13

  xor     ch, [eax+edx+25]
  mov     [eax+24], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+26]
  jz      @Move14

  xor     ch, [eax+edx+27]
  mov     [eax+26], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+28]
  jz      @Move15

  xor     ch, [eax+edx+29]
  mov     [eax+28], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+30]
  jz      @Move16

  xor     ch, [eax+edx+31]
  mov     [eax+30], cx
  jz      @EndIt2

  add    eax, 32

  jmp   @Loopme

  nop

@Endit2:

  pop    eax
  ret

@Move9:

  mov    [eax+16], cl
  pop    eax
  ret

@Move10:

  mov    [eax+18], cl
  pop    eax
  ret

@Move11:

  mov    [eax+20], cl
  pop    eax
  ret

@Move12:

  mov    [eax+22], cl
  pop    eax
  ret

@Move13:

  mov    [eax+24], cl
  pop    eax
  ret

@Move14:

  mov    [eax+26], cl
  pop    eax
  ret

@Move15:

  mov    [eax+28], cl
  pop    eax
  ret

@Move16:

  mov    [eax+30], cl
  pop    eax

end;

function StrCopy_JOH_PAS_1(Dest: PChar; const Source: PChar): PChar;
var
  Src, Dst : PByteArray;
  I : Integer;
begin
  Result := Dest;
  Src := PByteArray(Source);
  Dst := PByteArray(Dest);
  Dst[0] := Src[0];
  if Dst[0] = 0 then Exit;
  Dst[1] := Src[1];
  if Dst[1] = 0 then Exit;
  Dst[2] := Src[2];
  if Dst[2] = 0 then Exit;
  Dst[3] := Src[3];
  if Dst[3] = 0 then Exit;
  Dst[4] := Src[4];
  if Dst[4] = 0 then Exit;
  Dst[5] := Src[5];
  if Dst[5] = 0 then Exit;
  Dst[6] := Src[6];
  if Dst[6] = 0 then Exit;
  Dst[7] := Src[7];
  if Dst[7] = 0 then Exit;
  Inc(Integer(Src), 4);
  Inc(Integer(Dst), 4);
  repeat
    Inc(Integer(Src), 4);
    Inc(Integer(Dst), 4);
    if Src[0] = 0 then
      begin
        Dst[0] := Src[0];
        Exit;
      end;
    if Src[1] = 0 then
      begin
        PWord(Dst)^ := PWord(Src)^;
        Exit;
      end;
    if Src[2] = 0 then
      begin
        Dst[2] := Src[2];
        PWord(Dst)^ := PWord(Src)^;
        Exit;
      end;
    I := PInteger(Src)^;
    PInteger(Dst)^ := I;
    if I and $ff000000 = 0 then
      Exit;
    Inc(Integer(Src), 4);
    Inc(Integer(Dst), 4);
    if Src[0] = 0 then
      begin
        Dst[0] := Src[0];
        Exit;
      end;
    if Src[1] = 0 then
      begin
        PWord(Dst)^ := PWord(Src)^;
        Exit;
      end;
    if Src[2] = 0 then
      begin
        Dst[2] := Src[2];
        PWord(Dst)^ := PWord(Src)^;
        Exit;
      end;
    I := PInteger(Src)^;
    PInteger(Dst)^ := I;
    if I and $ff000000 = 0 then
      Exit;
  until False;
end;

function StrCopy_Sha_Pas_1(Dest: PChar; const Source: PChar): PChar;
var
  d: integer;
  ch: char;
begin
  d:=integer(Source);
  Result:=Dest;
  dec(d,integer(Dest));
  repeat
    ch:=Dest[d+00]; Dest[00]:=ch; if ch=#0 then break;
    ch:=Dest[d+01]; Dest[01]:=ch; if ch=#0 then break;
    ch:=Dest[d+02]; Dest[02]:=ch; if ch=#0 then break;
    ch:=Dest[d+03]; Dest[03]:=ch; if ch=#0 then break;
    ch:=Dest[d+04]; Dest[04]:=ch; if ch=#0 then break;
    ch:=Dest[d+05]; Dest[05]:=ch; if ch=#0 then break;
    ch:=Dest[d+06]; Dest[06]:=ch; if ch=#0 then break;
    ch:=Dest[d+07]; Dest[07]:=ch; if ch=#0 then break;
    ch:=Dest[d+08]; Dest[08]:=ch; if ch=#0 then break;
    ch:=Dest[d+09]; Dest[09]:=ch; if ch=#0 then break;
    ch:=Dest[d+10]; Dest[10]:=ch; if ch=#0 then break;
    ch:=Dest[d+11]; Dest[11]:=ch; if ch=#0 then break;
    ch:=Dest[d+12]; Dest[12]:=ch; if ch=#0 then break;
    ch:=Dest[d+13]; Dest[13]:=ch; if ch=#0 then break;
    ch:=Dest[d+14]; Dest[14]:=ch; if ch=#0 then break;
    ch:=Dest[d+15]; Dest[15]:=ch; if ch=#0 then break;
    ch:=Dest[d+16]; Dest[16]:=ch; if ch=#0 then break;
    ch:=Dest[d+17]; Dest[17]:=ch; if ch=#0 then break;
    ch:=Dest[d+18]; Dest[18]:=ch; if ch=#0 then break;
    ch:=Dest[d+19]; Dest[19]:=ch; if ch=#0 then break;
    ch:=Dest[d+20]; Dest[20]:=ch; if ch=#0 then break;
    ch:=Dest[d+21]; Dest[21]:=ch; if ch=#0 then break;
    ch:=Dest[d+22]; Dest[22]:=ch; if ch=#0 then break;
    ch:=Dest[d+23]; Dest[23]:=ch; if ch=#0 then break;
    ch:=Dest[d+24]; Dest[24]:=ch; if ch=#0 then break;
    ch:=Dest[d+25]; Dest[25]:=ch; if ch=#0 then break;
    ch:=Dest[d+26]; Dest[26]:=ch; if ch=#0 then break;
    ch:=Dest[d+27]; Dest[27]:=ch; if ch=#0 then break;
    ch:=Dest[d+28]; Dest[28]:=ch; if ch=#0 then break;
    ch:=Dest[d+29]; Dest[29]:=ch; if ch=#0 then break;
    ch:=Dest[d+30]; Dest[30]:=ch; if ch=#0 then break;
    ch:=Dest[d+31]; Dest[31]:=ch;
    inc(Dest,32);
  until ch=#0;
end;

procedure StrCopyStub;
asm
  call SysUtils.StrCopy;
end;

end.
