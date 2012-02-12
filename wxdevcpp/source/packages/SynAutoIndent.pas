{-------------------------------------------------------------------------------

  The contents of this file are subject to the Mozilla Public License
  Version 1.1 (the "License"); you may not use this file except in compliance
  with the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/

  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
  the specific language governing rights and limitations under the License.

  The Original Code is: SynAutoIndent.pas, Peter Schraut, released 2003-12-14.
  The Original Code is based on SynEditPythonBehaviour.pas, part
  of the SynEdit component suite.
  
  Contributors to the SynEdit and mwEdit projects are listed in the
  Contributors.txt file.

  Alternatively, the contents of this file may be used under the terms of the
  GNU General Public License Version 2 or later (the "GPL"), in which case
  the provisions of the GPL are applicable instead of those above.
  If you wish to allow use of your version of this file only under the terms
  of the GPL and not to allow others to use your version of this file
  under the MPL, indicate your decision by deleting the provisions above and
  replace them with the notice and other provisions required by the GPL.
  If you do not delete the provisions above, a recipient may use your version
  of this file under either the MPL or the GPL.

  $Id:

  You may retrieve the latest version of this file at the SynEdit home page,
  located at http://SynEdit.SourceForge.net


  History:
      14th Dec 2003
        + Used and extended code from SynEditPythonBehaviour.pas to be able to
          specifiy a set of chars to indent and unindent automatically.

      22nd Jan 2004
        + Fixed a bug where the cursor went to the above row when x got s
          smaller than 0


  Known Issues:          
-------------------------------------------------------------------------------}

{$IFNDEF QSYNAUTOINDENT}
Unit SynAutoIndent;
{$ENDIF}

{$I SynEdit.inc}

Interface

Uses
  {$IFDEF SYN_CLX}
  Qt, QGraphics, QControls, QForms, QDialogs,
  QSynEdit,
  QSynEditKeyCmds,
  {$ELSE}
    Messages,
    SynEdit,
    SynEditKeyCmds,
  {$ENDIF}
    SysUtils,
    Classes;

Type
    TSynCustomAutoIndent = Class(TComponent)
    Private
        FEnabled: Boolean;
        FEditor: TSynEdit;
        FIndentChars: String;
        FUnIndentChars: String;
    Protected
        Procedure SetEditor(Value: TSynEdit); Virtual;
        Procedure doProcessUserCommand(Sender: TObject; AfterProcessing: Boolean;
            Var Handled: Boolean; Var Command: TSynEditorCommand;
            Var AChar: Char; Data: Pointer; HandlerData: pointer); Virtual;
    Public
        Constructor Create(AOwner: TComponent); Override;
        Property Editor: TSynEdit Read FEditor Write SetEditor;
        Property Enabled: Boolean Read FEnabled Write FEnabled;
        Property IndentChars: String Read FIndentChars Write FIndentChars;
        Property UnIndentChars: String Read FUnIndentChars Write FUnIndentChars;
    End;


    TSynAutoIndent = Class(TSynCustomAutoIndent)
    Published
        Property Editor;
        Property Enabled;
        Property IndentChars;
        Property UnIndentChars;
        Property Name;
        Property Tag;
    End;


Procedure Register;


Implementation

Uses
{$IFDEF SYN_CLX}
  QSynEditStrConst;
{$ELSE}
    SynEditStrConst;
{$ENDIF}

{$R SynAutoIndent.res}

Procedure Register;
Begin
    RegisterComponents('SynEdit', [TSynAutoIndent]);
End;


//--------------------------------------------------------------------------------------------------


Constructor TSynCustomAutoIndent.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);

    FEnabled := True;
    FEditor := Nil;
    FIndentChars := ':{';
    FUnIndentChars := '}';
End;


//--------------------------------------------------------------------------------------------------


Procedure TSynCustomAutoIndent.SetEditor(Value: TSynEdit);
Begin
    If FEditor <> Value Then
    Begin
        If (Editor <> Nil) And Not (csDesigning In ComponentState) Then
            Editor.UnregisterCommandHandler(doProcessUserCommand);
    // Set the new editor
        FEditor := Value;
        If (Editor <> Nil) And Not (csDesigning In ComponentState) Then
            Editor.RegisterCommandHandler(doProcessUserCommand, Nil);
    End;
End;


//--------------------------------------------------------------------------------------------------


Procedure TSynCustomAutoIndent.doProcessUserCommand(Sender: TObject; AfterProcessing: Boolean;
    Var Handled: Boolean; Var Command: TSynEditorCommand; Var AChar: Char; Data: Pointer; HandlerData: pointer);
Var
    iEditor: TCustomSynEdit;
    StrPrevLine: String;
    StrCurLine: String;
    i: Integer;
Begin
    If (Not FEnabled) Or Not (eoAutoIndent In (Sender As TCustomSynEdit).Options) Then
        Exit;

    If AfterProcessing Then
    Begin
        Case Command Of
            ecLineBreak:
            Begin
                iEditor := Sender As TCustomSynEdit;
          { CaretY should never be lesser than 2 right after ecLineBreak, so there's
          no need for a check }
                StrPrevLine := TrimRight(iEditor.Lines[iEditor.CaretY - 2]);
                If (StrPrevLine <> '') And (AnsiPos(StrPrevLine[Length(StrPrevLine)], FIndentChars) > 0) Then
                Begin
                    iEditor.UndoList.BeginBlock;
                    Try
                        i := iEditor.DisplayX + iEditor.TabWidth - 1;
                        iEditor.ExecuteCommand(ecSelLineStart, #0, Nil);
                        While iEditor.DisplayX <= i Do
                            iEditor.ExecuteCommand(ecTab, #0, Nil);
                    Finally
                        iEditor.UndoList.EndBlock;
                    End;
                End;
            End;
        End;
    End
    Else
    Begin
        Case Command Of
            ecChar:
            Begin
                iEditor := Sender As TCustomSynEdit;
                StrCurLine := Trim(iEditor.Lines[iEditor.CaretY - 1]);
                If (StrCurLine = '') And (AnsiPos(AChar, FUnIndentChars) > 0) Then
                Begin
                    iEditor.UndoList.BeginBlock;
                    Try
                        i := iEditor.DisplayX - 1 - FEditor.TabWidth;
                        iEditor.ExecuteCommand(ecSelLineStart, #0, Nil);
                        iEditor.ExecuteCommand(ecChar, AChar, Nil);
                        AChar := #0;
                        iEditor.ExecuteCommand(ecLeft, #0, Nil);
                        While iEditor.DisplayX <= i Do
                            iEditor.ExecuteCommand(ecTab, #0, Nil);
                        iEditor.ExecuteCommand(ecRight, #0, Nil);
                    Finally
                        iEditor.UndoList.EndBlock;
                    End;
                End;
            End;
        End;
    End;
End;



End.
