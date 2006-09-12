unit FastcodeAnsiStringReplaceUnit;

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
 * Eric Grange
 *
 * BV Version: 1.60
 * ***** END LICENSE BLOCK ***** *)

interface

{$I Fastcode.inc}

uses
  SysUtils, FastcodeASRJOHIA323Unit, FastcodeASRJOHIA324Unit,
  FastcodeASRJOHPAS4Unit, FastcodeASREGPasUnit;

type
  FastcodeAnsiStringReplaceFunction = function(
    const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;

{Functions shared between Targets}

{Functions not shared between Targets}

const
  Version = '0.5 beta 2';

  FastcodeAnsiStringReplaceP4R: FastcodeAnsiStringReplaceFunction = StringReplace_JOH_IA32_3;
  FastcodeAnsiStringReplaceP4N: FastcodeAnsiStringReplaceFunction = StringReplace_JOH_IA32_4;
  FastcodeAnsiStringReplacePMY: FastcodeAnsiStringReplaceFunction = StringReplace_JOH_IA32_4;
  FastcodeAnsiStringReplacePMD: FastcodeAnsiStringReplaceFunction = StringReplace_JOH_IA32_4;
  FastcodeAnsiStringReplaceAMD64: FastcodeAnsiStringReplaceFunction = StringReplace_JOH_IA32_4;
  FastcodeAnsiStringReplaceAMD64_SSE3: FastcodeAnsiStringReplaceFunction = StringReplace_JOH_IA32_4;
  FastCodeAnsiStringReplaceIA32SizePenalty: FastCodeAnsiStringReplaceFunction = StringReplace_JOH_PAS_4;
  FastcodeAnsiStringReplaceIA32: FastcodeAnsiStringReplaceFunction = StringReplace_JOH_IA32_4;
  FastcodeAnsiStringReplaceMMX: FastcodeAnsiStringReplaceFunction = StringReplace_JOH_IA32_4;
  FastCodeAnsiStringReplaceSSESizePenalty: FastCodeAnsiStringReplaceFunction = StringReplace_EG_MMX_1;
  FastcodeAnsiStringReplaceSSE: FastcodeAnsiStringReplaceFunction = StringReplace_JOH_IA32_4;
  FastcodeAnsiStringReplaceSSE2: FastcodeAnsiStringReplaceFunction = StringReplace_JOH_IA32_4;
  FastCodeAnsiStringReplacePascalSizePenalty: FastCodeAnsiStringReplaceFunction = StringReplace_JOH_PAS_4;
  FastCodeAnsiStringReplacePascal: FastCodeAnsiStringReplaceFunction = StringReplace_JOH_PAS_4;

procedure AnsiStringReplaceStub;

implementation

procedure AnsiStringReplaceStub;
asm
  call SysUtils.StringReplace;
end;

end.
