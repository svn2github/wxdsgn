program Project1;

uses
  FastCode,
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  FastCodeStrCopyUnit in 'FastCodeStrCopyUnit.pas',
  FastcodeUpperCaseUnit in 'FastcodeUpperCaseUnit.pas',
  FastCodeCompareTextUnit in 'FastCodeCompareTextUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  FastcodeLowerCaseUnit in 'FastcodeLowerCaseUnit.pas',
  FastCodePatch in 'FastCodePatch.pas',
  FastCodePosUnit in 'FastCodePosUnit.pas',
  FastCodeStrCompUnit in 'FastCodeStrCompUnit.pas',
  FastCodeFillCharUnit in 'FastCodeFillCharUnit.pas',
  FastCodeCompareStrUnit in 'FastCodeCompareStrUnit.pas',
  FastCodeCompareMemUnit in 'FastCodeCompareMemUnit.pas',
  FastCodePosExUnit in 'FastCodePosExUnit.pas',
  FastCodeStrLenUnit in 'FastCodeStrLenUnit.pas',
  FastCodeAnsiStringReplaceUnit in 'FastCodeAnsiStringReplaceUnit.pas',
  FastCodeCharPos in 'Non.RTL\FastCodeCharPos.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
