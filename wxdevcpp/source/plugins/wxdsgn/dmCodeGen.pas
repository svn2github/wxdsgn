{
wxDialog Designer
}
{                                                                    }
{   Copyright © 2003-2007 by Guru Kathiresan                         }
{                                                                    }
{License :                                                           }
{=========                                                           }
{The wx-devC++ Components, Form Designer, Utils classes              }
{are exclusive properties of Guru Kathiresan.                        }
{The code is available in dual Licenses:                             }
{                               1)GPL Compatible  License            }
{                               2)Commercial License                 }
{                                                                    }
{1)GPL License :                                                     }
{ Code can be used in any project as long as the project's sourcecode}
{ is published under GPL license.                                    }
{                                                                    }
{2)Commercial License:                                               }
{Use of code in this file or the one that bear this license text     }
{can be used in Non-GPL projects as long as you get the permission   }
{from the Author - Guru Kathiresan.                                  }
{Use of the Code in any non-gpl projects without the permission of   }
{the author is illegal.                                              }
{Contact gururamnath@yahoo.com for details                           }
{ ****************************************************************** }


unit dmCodeGen;

interface

uses classes, Sysutils, xprocs, synEdit;

type
    TBlockType = (btManualCode, btDialogStyle, btHeaderIncludes, btForwardDec, btClassNameControlIdentifiers, btClassNameEnumControlIdentifiers, btXPMImages, btClassNameEventTableEntries, btClassNameGUIItemsCreation, btClassNameGUIItemsDeclaration, btLHSVariables, btRHSVariables);

function GetStartAndEndBlockStrings(ClassNameString: string; blockType: TBlockType; var StartString, EndString: string): boolean;

function GetBlockStartAndEndPos(synEdit: TSynEdit; wxClassName: string; blockType: TBlockType; var StartPos, EndPos: integer): boolean;

//function GetBlockCode(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType; StartPos, EndPos: Integer): string;overload;
function GetBlockCode(synEdit: TSynEdit; wxClassName: string; blockType: TBlockType; StartPos, EndPos: integer): TStringList;

function DeleteBlock(synEdit: TSynEdit; wxClassName: string; blockType: TBlockType): boolean;

function AddDialogStyleDeclaration(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; GUIItemString: string): boolean;
function DeleteAllDialogStyleDeclaration(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;

function AddClassNameGUIItemsDeclaration(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; GUIItemString: string): boolean;
function DeleteAllClassNameGUIItemsDeclaration(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;

function AddClassNameGUIItemsCreation(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; GUIItemString: string): boolean;
function DeleteAllClassNameGUIItemsCreation(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;

function AddClassNameControlIndentifiers(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; ControlIDString: string): boolean;
function DeleteAllClassNameControlIndentifiers(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;

function AddClassNameEnumControlIndentifiers(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; ControlIDString: string): boolean;
function DeleteAllClassNameEnumControlIndentifiers(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;

function AddClassNameIncludeHeader(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; ControlIDString: string): boolean;
function DeleteAllClassNameIncludeHeader(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;

function AddClassNameEventTableEntries(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; EvtString: string; useTabChar: boolean = TRUE): boolean;
function DeleteAllClassNameEventTableEntries(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;

function AddRHSVariableList(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; VarString: string; useTabChar: boolean = TRUE): boolean;
function DeleteAllRHSVariableList(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;

function AddLHSVariableList(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; VarString: string; useTabChar: boolean = TRUE): boolean;
function DeleteAllLHSVariableList(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;


implementation

function AddHeaderInclude(synEdit: TSynEdit; BlockStart, BlockEnd: integer; HeaderString: string): boolean;
begin
    Result := TRUE;
end;

function EditHeaderInclude(synEdit: TSynEdit; BlockStart, BlockEnd: integer; FromHeaderString, ToHeaderString: string): boolean;
begin
    Result := TRUE;
end;

function DeleteHeaderInclude(synEdit: TSynEdit; BlockStart, BlockEnd: integer; HeaderString: string): boolean;
begin
    Result := TRUE;
end;

function AddSourceInclude(synEdit: TSynEdit; BlockStart, BlockEnd: integer; HeaderString: string): boolean;
begin
    Result := TRUE;
end;

function EditSourceInclude(synEdit: TSynEdit; BlockStart, BlockEnd: integer; FromHeaderString, ToHeaderString: string): boolean;
begin
    Result := TRUE;
end;

function DeleteSourceInclude(synEdit: TSynEdit; BlockStart, BlockEnd: integer; HeaderString: string): boolean;
begin
    Result := TRUE;
end;

function AddClassNameControlIdentifier(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; IdString: string): boolean;
begin
    Result := TRUE;
end;

function EditClassNameControlIdentifier(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; FromIdString, ToIdString: string): boolean;
begin
    Result := TRUE;
end;

function DeleteClassNameControlIdentifier(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; IdString: string): boolean;
begin
    Result := TRUE;
end;

function AddXPMImage(synEdit: TSynEdit; BlockStart, BlockEnd: integer; XPMString: string): boolean;
begin
    Result := TRUE;
end;

function EditXPMImage(synEdit: TSynEdit; BlockStart, BlockEnd: integer; FromXPMString, ToXPMString: string): boolean;
begin
    Result := TRUE;
end;

function DeleteXPMImage(synEdit: TSynEdit; BlockStart, BlockEnd: integer; XPMString: string): boolean;
begin
    Result := TRUE;
end;

function AddClassNameEventTableEntries(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; EvtString: string; useTabChar: boolean = TRUE): boolean;
var
    i: integer;
    strlst: TStringList;
    strData: string;
begin
    Result := TRUE;
    if trim(EvtString) = '' then
        exit;
    strlst := TStringList.Create;
    strlst.Text := EvtString;
    //strlst.Delimiter:=#13;
    //DelimitedText:=EvtString;

    //strTokenToStrings(EvtString,#13,strlst);


    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
        strData := Trim(strlst[i]);
        if useTabChar then
            strData := #9 + strData;

        if strData <> '' then
	           synEdit.Lines.Insert(BlockStart + 1, strData);
    end;    // for
    //synEdit.Lines.Insert(BlockStart + 1,'');

    strlst.Destroy;
    //synEdit.Lines.Insert(BlockStart + 1, #9EvtString);
end;

function EditClassNameEventTableEntries(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; FromEvtString, ToEvtString: string): boolean;
begin
    Result := TRUE;
end;


function DeleteAllClassNameEventTableEntries(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;
begin
    Result := TRUE;
    DeleteBlock(synEdit, ClassNameString, btClassNameEventTableEntries);
end;

function AddRHSVariableList(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; VarString: string; useTabChar: boolean = TRUE): boolean;
var
    i: integer;
    strlst: TStringList;
    strData: string;
begin
    Result := TRUE;
    if trim(VarString) = '' then
        exit;
    strlst := TStringList.Create;
    strlst.Text := VarString;
    //strlst.Delimiter:=#13;
    //DelimitedText:=EvtString;

    //strTokenToStrings(EvtString,#13,strlst);


    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
        strData := Trim(strlst[i]);
        if useTabChar then
            strData := #9 + strData;

        if strData <> '' then
	           synEdit.Lines.Insert(BlockStart + 1, strData);
    end;    // for
    //synEdit.Lines.Insert(BlockStart + 1,'');

    strlst.Destroy;
    //synEdit.Lines.Insert(BlockStart + 1, #9EvtString);
end;

function DeleteAllRHSVariableList(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;
begin
    Result := TRUE;
    DeleteBlock(synEdit, ClassNameString, btRHSVariables);
end;

function AddLHSVariableList(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; VarString: string; useTabChar: boolean = TRUE): boolean;
var
    i: integer;
    strlst: TStringList;
    strData: string;
begin
    Result := TRUE;
    if trim(VarString) = '' then
        exit;
    strlst := TStringList.Create;
    strlst.Text := VarString;
    //strlst.Delimiter:=#13;
    //DelimitedText:=EvtString;

    //strTokenToStrings(EvtString,#13,strlst);


    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
        strData := Trim(strlst[i]);
        if useTabChar then
            strData := #9 + strData;

        if strData <> '' then
	           synEdit.Lines.Insert(BlockStart + 1, strData);
    end;    // for
    //synEdit.Lines.Insert(BlockStart + 1,'');

    strlst.Destroy;
    //synEdit.Lines.Insert(BlockStart + 1, #9EvtString);
end;

function DeleteAllLHSVariableList(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;
begin
    Result := TRUE;
    DeleteBlock(synEdit, ClassNameString, btLHSVariables);
end;

function AddDialogStyleDeclaration(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; GUIItemString: string): boolean;
var
    i: integer;
    strlst: TStringList;
begin
    Result := TRUE;
    if trim(GUIItemString) = '' then
        exit;

    strlst := TStringList.Create;

    strTokenToStrings(GUIItemString, #13, strlst);


    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
	       synEdit.Lines.Insert(BlockStart + 1, Trim(strlst[i]));
    end;    // for

    //synEdit.Lines.Insert(BlockStart + 1,'');

    strlst.Destroy;

end;


function DeleteAllDialogStyleDeclaration(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;
begin
    Result := TRUE;
    DeleteBlock(synEdit, ClassNameString, btDialogStyle);
end;

function AddClassNameGUIItemsDeclaration(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; GUIItemString: string): boolean;
var
    i: integer;
    strlst: TStringList;
begin
    Result := TRUE;
    if trim(GUIItemString) = '' then
        exit;
    strlst := TStringList.Create;

    strTokenToStrings(GUIItemString, #13, strlst);


    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
        synEdit.Lines.Insert(BlockStart + 1, #9#9 + Trim(strlst[i]));
    end;    // for
    //synEdit.Lines.Insert(BlockStart + 1,'');

    strlst.Destroy;
end;

function EditClassNameGUIItemsDeclaration(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; FromGUIItemString, ToGUIItemString: string): boolean;
begin
    Result := TRUE;
end;

function DeleteClassNameGUIItemsDeclaration(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; GUIItemString: string): boolean;
begin
    Result := TRUE;
end;

function DeleteAllClassNameGUIItemsDeclaration(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;
begin
    Result := TRUE;
    DeleteBlock(synEdit, ClassNameString, btClassNameGUIItemsDeclaration);
end;


function AddClassNameGUIItemsCreation(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; GUIItemString: string): boolean;
var
    i: integer;
    strlst: TStringList;
begin
    Result := TRUE;
    if trim(GUIItemString) = '' then
        exit;
    strlst := TStringList.Create;

    strTokenToStrings(GUIItemString, #13, strlst);


    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
	       synEdit.Lines.Insert(BlockStart + 1, #9 + Trim(strlst[i]));
    end;    // for
    synEdit.Lines.Insert(BlockStart + 1, '');

    strlst.Destroy;

end;

function EditClassNameGUIItemsCreation(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; FromGUIItemString, ToGUIItemString: string): boolean;
begin
    Result := TRUE;
end;

function DeleteClassNameGUIItemsCreation(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; GUIItemString: string): boolean;
begin
    Result := TRUE;
end;

function DeleteAllClassNameGUIItemsCreation(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;
begin
    Result := TRUE;
    DeleteBlock(synEdit, ClassNameString, btClassNameGUIItemsCreation);
end;


function AddClassNameControlIndentifiers(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; ControlIDString: string): boolean;
var
    i: integer;
    strlst: TStringList;
begin
    Result := TRUE;
    if trim(ControlIDString) = '' then
        exit;
    strlst := TStringList.Create;

    strTokenToStrings(ControlIDString, #13, strlst);


    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
	       synEdit.Lines.Insert(BlockStart + 1, Trim(strlst[i]));
    end;    // for

    strlst.Destroy;
end;

function EditClassNameControlIndentifiers(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; FromControlIDString, ToControlIDString: string): boolean;
begin
    Result := TRUE;
end;

function DeleteAllClassNameControlIndentifiers(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;
begin
    Result := TRUE;
    DeleteBlock(synEdit, ClassNameString, btClassNameControlIdentifiers);
end;

function AddClassNameEnumControlIndentifiers(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; ControlIDString: string): boolean;
var
    i: integer;
    strlst: TStringList;
begin
    Result := TRUE;
    if trim(ControlIDString) = '' then
        exit;
    strlst := TStringList.Create;

    strTokenToStrings(ControlIDString, #13, strlst);

    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
	       synEdit.Lines.Insert(BlockStart + 1, #9#9#9 + Trim(strlst[i]));
    end;    // for

    strlst.Destroy;
end;

function DeleteAllClassNameEnumControlIndentifiers(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;
begin
    Result := TRUE;
    DeleteBlock(synEdit, ClassNameString, btClassNameEnumControlIdentifiers);
end;

function AddClassNameIncludeHeader(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer; ControlIDString: string): boolean;
var
    i: integer;
    strlst: TStringList;
begin
    Result := TRUE;
    if trim(ControlIDString) = '' then
        exit;
    strlst := TStringList.Create;

    strTokenToStrings(ControlIDString, #13, strlst);


    for i := strlst.Count - 1 downto 0 do    // Iterate
    begin
	       synEdit.Lines.Insert(BlockStart + 1, Trim(strlst[i]));
    end;    // for

    strlst.Destroy;

end;

function DeleteAllClassNameIncludeHeader(synEdit: TSynEdit; ClassNameString: string; BlockStart, BlockEnd: integer): boolean;
begin
    Result := TRUE;
    DeleteBlock(synEdit, ClassNameString, btHeaderIncludes);
end;

function GetStartAndEndBlockStrings(ClassNameString: string; blockType: TBlockType; var StartString, EndString: string): boolean;
begin

    Result := TRUE;

    StartString := '';
    EndString := '';

    if blockType = btManualCode then
    begin
        StartString := '////Manual Code Start';
        EndString := '////Manual Code End';
        Exit;
    end;

    if blockType = btDialogStyle then
    begin
        StartString := '////Dialog Style Start';
        EndString := '////Dialog Style End';
        Exit;
    end;


    if blockType = btHeaderIncludes then
    begin
        StartString := '////Header Include Start';
        EndString := '////Header Include End';
        Exit;
    end;

    if blockType = btClassNameControlIdentifiers then
    begin
        StartString := '////GUI Control ID Start';
        EndString := '////GUI Control ID End';
        Exit;
    end;

    if blockType = btClassNameEnumControlIdentifiers then
    begin
        StartString := '////GUI Enum Control ID Start';
        EndString := '////GUI Enum Control ID End';
        Exit;
    end;

    if blockType = btXPMImages then
    begin
        StartString := '////@begin XPM images';
        EndString := '////@end XPM images';
        Exit;
    end;

    if blockType = btClassNameEventTableEntries then
    begin
        StartString := '////Event Table Start';
        EndString := '////Event Table End';
        Exit;
    end;


    if blockType = btClassNameGUIItemsCreation then
    begin
        StartString := '////GUI Items Creation Start';
        EndString := '////GUI Items Creation End';
        Exit;
    end;

    if blockType = btClassNameGUIItemsDeclaration then
    begin
        StartString := '////GUI Control Declaration Start';
        EndString := '////GUI Control Declaration End';
        Exit;
    end;

    if blockType = btRHSVariables then
    begin
        StartString := '////RHS Variables Start';
        EndString := '////RHS Variables End';
        Exit;
    end;

    if blockType = btLHSVariables then
    begin
        StartString := '////LHS Variables Start';
        EndString := '////LHS Variables End';
        Exit;
    end;

end;

function GetBlockStartString(ClassNameString: string; blockType: TBlockType): string;
var
    StartString, EndString: string;
begin
    GetStartAndEndBlockStrings(ClassNameString, blockType, StartString, EndString);
    Result := StartString;
end;

function GetBlockEndString(ClassNameString: string; blockType: TBlockType): string;
var
    StartString, EndString: string;
begin
    GetStartAndEndBlockStrings(ClassNameString, blockType, StartString, EndString);
    Result := EndString;
end;



function GetBlockStartAndEndPos(synEdit: TSynEdit; wxClassName: string; blockType: TBlockType; var StartPos, EndPos: integer): boolean;
var
    strStartBlock, strEndBlock: string;
    i, sCount: integer;
    strLine: string;
begin
    Result := TRUE;

    StartPos := 0;
    EndPos := 0;

    strStartBlock := trim(GetBlockStartString(wxClassName, blockType));
    strEndBlock := trim(GetBlockEndString(wxClassName, blockType));

    if (strStartBlock = '') or (strEndBlock = '') then
    begin
        Result := FALSE;
        exit;
    end;

    sCount := synEdit.Lines.Count;

    for i := 0 to sCount - 1 do
    begin

        strLine := synEdit.Lines[i];

        if UpperCase(trim(strLine)) = UpperCase(strStartBlock) then
        begin
            if StartPos <> 0 then
            begin
                Result := FALSE;
                exit;
            end;
            StartPos := i;
            continue;
        end;

        if UpperCase(trim(strLine)) = UpperCase(strEndBlock) then
        begin
            if EndPos <> 0 then
            begin
                Result := FALSE;
                exit;
            end;
            EndPos := i;
            continue;
        end;

    end;

    if (StartPos = 0) or (EndPos = 0) then
    begin
        Result := FALSE;
        Exit;
    end;

end;
//function GetBlockCode(synEdit:TSynEdit; wxClassName: string; blockType: TBlockType; StartPos, EndPos: Integer): string;
//var
//    strLst:TStringList;
//begin
//    strLst:=TStringList.Create;
//    for i := StartPos+1 to EndPos-1 do
//    begin
//        strLst.add(synEdit.Lines[i]);
//    end;
//    Result:=strLst.Text;
//    strLst.destroy;
//
//end;

function GetBlockCode(synEdit: TSynEdit; wxClassName: string; blockType: TBlockType; StartPos, EndPos: integer): TStringList;
var
    i: integer;
begin
    Result := TStringList.Create;

    try
        for i := StartPos + 1 to EndPos - 1 do
        begin
            Result.Add(synEdit.Lines[i]);
        end;
    except
        Result.Free;
        raise;
    end;

end;


function DeleteBlock(synEdit: TSynEdit; wxClassName: string; blockType: TBlockType): boolean;
var
    StartLinePos, EndLinePos: integer;
    i: integer;
begin
    Result := TRUE;
    StartLinePos := 0;
    EndLinePos := 0;

    if not GetBlockStartAndEndPos(synEdit, wxClassName, blockType, StartLinePos, EndLinePos) then
    begin
        Result := FALSE;
        exit;
    end;

    for i := EndLinePos - 1 downto StartLinePos + 1 do
    begin
        synEdit.Lines.Delete(i);
    end;

end;

function AddItemToBlock(synEdit: TSynEdit; wxClassName: string; blockType: TBlockType; LineString: string): boolean;
begin
    Result := TRUE;
end;

//function AddItemToBlock(SourceLines:TStringList;intBlockStart,intBlockEnd:Integer;StartblkString:String):Boolean;overload;
//begin
//
//End;

function LocateLineInBlock(synEdit: TSynEdit; wxClassName: string; blockType: TBlockType; LineString: string): boolean;
begin
    Result := TRUE;
end;

//function LocateLineInBlock(SourceLines:TStringList,intBlockStart,intBlockEnd:Integer;LineString:String):Boolean;
//Begin
////
//ENd;


function ChangeClassName(FromClassName, ToClassName: string): boolean;
begin
    Result := TRUE;
end;


end.
