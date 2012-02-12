{
    This file is part of Dev-C++
    Copyright (c) 2004 Bloodshed Software

    Dev-C++ is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Dev-C++ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Dev-C++; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

Unit ClassBrowser;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, Classes, SysUtils, Controls, ComCtrls, Forms, Graphics,
    CppParser;
{$ENDIF}
{$IFDEF LINUX}
  Classes, SysUtils, QControls, QComCtrls, QForms, QGraphics,
  CppParser;
{$ENDIF}

Const
    MAX_CUSTOM_FOLDERS = 250;

Type
    TMemberSelectEvent = Procedure(Sender: TObject; Filename: TFilename; Line: Integer) Of Object;

    PFolders = ^TFolders;
    TFolders = Record
        Index: Char;
        Name: String[32];
        Under: String[164];
        Node: TTreeNode;
    End;

    PFolderAssocs = ^TFolderAssocs;
    TFolderAssocs = Record
        FolderID: Integer;
        Folder: String[32];
        Command: String[164];
    End;

    TImagesRecord = Class(TPersistent)
    Private
        fGlobalsImg: Integer;
        fClassesImg: Integer;
        fVariablePrivateImg: Integer;
        fVariableProtectedImg: Integer;
        fVariablePublicImg: Integer;
        fVariablePublishedImg: Integer;
        fMethodPrivateImg: Integer;
        fMethodProtectedImg: Integer;
        fMethodPublicImg: Integer;
        fMethodPublishedImg: Integer;
        fInhMethodProtectedImg: Integer;
        fInhMethodPublicImg: Integer;
        fInhVariableProtectedImg: Integer;
        fInhVariablePublicImg: Integer;
    Published
        Property Globals: Integer Read fGlobalsImg Write fGlobalsImg;
        Property Classes: Integer Read fClassesImg Write fClassesImg;
        Property VariablePrivate: Integer Read fVariablePrivateImg Write fVariablePrivateImg;
        Property VariableProtected: Integer Read fVariableProtectedImg Write fVariableProtectedImg;
        Property VariablePublic: Integer Read fVariablePublicImg Write fVariablePublicImg;
        Property VariablePublished: Integer Read fVariablePublishedImg Write fVariablePublishedImg;
        Property MethodPrivate: Integer Read fMethodPrivateImg Write fMethodPrivateImg;
        Property MethodProtected: Integer Read fMethodProtectedImg Write fMethodProtectedImg;
        Property MethodPublic: Integer Read fMethodPublicImg Write fMethodPublicImg;
        Property MethodPublished: Integer Read fMethodPublishedImg Write fMethodPublishedImg;
        Property InheritedMethodProtected: Integer Read fInhMethodProtectedImg Write fInhMethodProtectedImg;
        Property InheritedMethodPublic: Integer Read fInhMethodPublicImg Write fInhMethodPublicImg;
        Property InheritedVariableProtected: Integer Read fInhVariableProtectedImg Write fInhVariableProtectedImg;
        Property InheritedVariablePublic: Integer Read fInhVariablePublicImg Write fInhVariablePublicImg;
    End;

    TShowFilter = (sfAll, sfProject, sfCurrent);

    TClassBrowser = Class(TCustomTreeView)
    Private
        fParser: TCppParser;
        fOnSelect: TMemberSelectEvent;
        fImagesRecord: TImagesRecord;
        fShowFilter: TShowFilter;
        fCurrentFile: String;
        fCurrentFileHeader: String;
        fCurrentFileImpl: String;
        fProjectDir: TFileName;
        fClassFoldersFile: TFileName;
        fFolders: Array Of TFolders;
        fFolderAssocs: Array Of TFolderAssocs;
        fLastSelection: String;
        fCnv: TControlCanvas;
        fUseColors: Boolean;
        fParserBusy: Boolean;
        fShowInheritedMembers: Boolean;
        fShowingSampleData: Boolean;
        Procedure CustomPaintMe(Var Msg: TMessage); Message WM_PAINT;
        Procedure SetParser(Value: TCppParser);
        Procedure AddMembers(Node: TTreeNode; ParentIndex, ParentID: Integer);
        Procedure OnNodeChange(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        Procedure OnNodeChanging(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        Procedure myDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; Var Accept: Boolean);
        Procedure myDragDrop(Sender, Source: TObject; X, Y: Integer);
        Procedure myMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
        Procedure OnParserUpdate(Sender: TObject);
        Procedure OnParserBusy(Sender: TObject);
        Procedure SetNodeImages(Node: TTreeNode; Statement: PStatement);
        Procedure Sort;
        Procedure SetCurrentFile(Value: String);
        Procedure SetShowFilter(Const Value: TShowFilter);
        Procedure ReadClassFolders; // read folders from disk
        Procedure WriteClassFolders; // write folders to disk
        Function HasSubFolder(Cmd: String): Boolean; // if Command has subfolders, returns true
        Procedure CreateFolders(Cmd: String; Node: TTreeNode); // creates folders under Command
        Function BelongsToFolder(Cmd: String): Integer; // returns the index to fFolders it belongs or -1 if does not
        Function GetNodeOfFolder(Index: Integer): TTreeNode; Overload;
        Function GetNodeOfFolder(Folder: String): TTreeNode; Overload;
        Procedure AddFolderAssociation(Fld, Cmd: String);
        Procedure RemoveFolderAssociation(Fld, Cmd: String);
        Function IndexOfFolder(Fld: String): Integer;
        Procedure ReSelect;
        Procedure SetUseColors(Const Value: Boolean);
        Procedure SetShowInheritedMembers(Const Value: Boolean);
    Public
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Procedure Loaded; Override;   //Added by Jason Jiang to solve the problem when dropped to a
                                 //design surface caused an error of "Control " has no parent window"
        Procedure UpdateView;
        Procedure ShowSampleData;
        Procedure Clear;
        Procedure AddFolder(S: String; Node: TTreeNode);
        Procedure RemoveFolder(S: String);
        Procedure RenameFolder(Old, New: String);
        Function IsNodeAFolder(FolderNode: TTreeNode): Boolean;
        Function FolderCount: Integer;
        Procedure SetUpdateOn;
        Procedure SetUpdateOff;
    Published
        Property Align;
        Property Font;
        Property Color;
        Property Images;
        Property ReadOnly;
        Property Indent;
        Property TabOrder;
        Property PopupMenu;
        Property ShowFilter: TShowFilter Read fShowFilter Write SetShowFilter;
        Property OnSelect: TMemberSelectEvent Read fOnSelect Write fOnSelect;
        Property Parser: TCppParser Read fParser Write SetParser;
        Property ItemImages: TImagesRecord Read fImagesRecord Write fImagesRecord;
        Property CurrentFile: String Read fCurrentFile Write SetCurrentFile;
        Property ProjectDir: TFileName Read fProjectDir Write fProjectDir;
        Property ClassFoldersFile: TFileName Read fClassFoldersFile Write fClassFoldersFile;
        Property UseColors: Boolean Read fUseColors Write SetUseColors;
        Property ShowInheritedMembers: Boolean Read fShowInheritedMembers Write SetShowInheritedMembers;
    End;

Const
    CLASS_FOLDERS_MAGIC = 'DEVCF_1_0';

Implementation

{ TClassBrowser }

Procedure TClassBrowser.SetNodeImages(Node: TTreeNode; Statement: PStatement);
Var
    bInherited: Boolean;
Begin
    bInherited := fShowInheritedMembers And Assigned(Node.Parent) And (PStatement(Node.Parent.Data)^._ID <> PStatement(Node.Data)^._ParentID);

    Case Statement^._Kind Of
        skClass:
        Begin
            Node.ImageIndex := fImagesRecord.Classes;
        End;
        skVariable, skEnum:
            Case Statement^._ClassScope Of
                scsPrivate:
                    Node.ImageIndex := fImagesRecord.VariablePrivate;
                scsProtected:
                    If Not bInherited Then
                        Node.ImageIndex := fImagesRecord.VariableProtected Else Node.ImageIndex := fImagesRecord.InheritedVariableProtected;
                scsPublic:
                    If Not bInherited Then
                        Node.ImageIndex := fImagesRecord.VariablePublic Else Node.ImageIndex := fImagesRecord.InheritedVariablePublic;
                scsPublished:
                    If Not bInherited Then
                        Node.ImageIndex := fImagesRecord.VariablePublished Else Node.ImageIndex := fImagesRecord.InheritedVariablePublic;
            Else
                Node.ImageIndex := fImagesRecord.VariablePublished;
            End;
        skFunction, skConstructor, skDestructor:
            Case Statement^._ClassScope Of
                scsPrivate:
                    Node.ImageIndex := fImagesRecord.MethodPrivate;
                scsProtected:
                    If Not bInherited Then
                        Node.ImageIndex := fImagesRecord.MethodProtected Else Node.ImageIndex := fImagesRecord.InheritedMethodProtected;
                scsPublic:
                    If Not bInherited Then
                        Node.ImageIndex := fImagesRecord.MethodPublic Else Node.ImageIndex := fImagesRecord.InheritedMethodPublic;
                scsPublished:
                    If Not bInherited Then
                        Node.ImageIndex := fImagesRecord.MethodPublished Else Node.ImageIndex := fImagesRecord.InheritedMethodPublic;
            Else
                Node.ImageIndex := fImagesRecord.MethodPublished;
            End;
    End;
    Node.SelectedIndex := Node.ImageIndex;
    Node.StateIndex := Node.ImageIndex;
End;

Procedure TClassBrowser.AddMembers(Node: TTreeNode; ParentIndex, ParentID: Integer);
Var
    I, iFrom, tmp, tmpI: Integer;
    ParNode, NewNode: TTreeNode;
    F: Integer;
    Sl: TStringList;
    tmpS: String;
    bInherited: Boolean;
Begin
    If (Not fShowInheritedMembers) And (ParentIndex >= 0) Then
        iFrom := ParentIndex // amazing speed-up
    Else
        iFrom := 0; // if showing inheritance, a big speed penalty

  // create folders that have this branch as parent
    If ParentIndex <> -1 Then
        With PStatement(fParser.Statements[ParentIndex])^ Do
        Begin
            If HasSubFolder(ExtractFileName(_Filename) + ':' + IntToStr(_Line) + ':' + _FullText) Then
                CreateFolders(ExtractFileName(_Filename) + ':' + IntToStr(_Line) + ':' + _FullText, Node);
        End
    Else
    Begin
        If HasSubFolder('') Then
            CreateFolders('', Node);
    End;

    sl := TStringList.Create;
    Try

    // allow inheritance propagation
        If fShowInheritedMembers And (ParentIndex <> -1) And (PStatement(fParser.Statements[ParentIndex])^._Kind = skClass) Then
        Begin
      // follow the inheritance tree all the way up.
      // this code does not work for C++ polymorphic classes
            tmp := ParentIndex;
            tmpI := tmp;
            tmpS := '';
            sl.Clear;
            While (tmp <> -1) Do
            Begin
                tmpS := PStatement(fParser.Statements[tmpI])^._InheritsFromIDs;
                tmp := StrToIntDef(tmpS, -1);
                tmpI := fParser.IndexOfStatement(tmp);
                If sl.IndexOf(tmpS) <> -1 Then
                    tmp := -1;
                If (tmp <> -1) Then
                    sl.CommaText := sl.CommaText + tmpS + ',';
            End;
        End
        Else
            sl.Clear;

        bInherited := False;
        For I := iFrom To fParser.Statements.Count - 1 Do
        Begin
            With PStatement(fParser.Statements[I])^ Do
            Begin
                If Not _Visible Then
                    Continue;
                If _ParentID <> ParentID Then
                Begin
                    bInherited := fShowInheritedMembers And (sl.IndexOf(IntToStr(_ParentID)) > -1);
                    If Not bInherited Then
                        Continue;
                End;

                If (fShowFilter = sfAll) Or
                    ((fShowFilter = sfProject) And (_InProject Or bInherited)) Or
                    ((fShowFilter = sfCurrent) And ((_Filename = fCurrentFileHeader) Or (_Filename = fCurrentFileImpl) Or bInherited)) Then
                Begin

          // check if belongs to folder
                    F := BelongsToFolder(ExtractFileName(_Filename) + ':' + IntToStr(_Line) + ':' + _FullText);
                    If F <> -1 Then
                        ParNode := GetNodeOfFolder(F)
                    Else
                        ParNode := Node;

                    If fUseColors Then
                        NewNode := Items.AddChildObject(ParNode, '  ' + _FullText + '  ', PStatement(fParser.Statements[I]))
                    Else
                        NewNode := Items.AddChildObject(ParNode, _Command, PStatement(fParser.Statements[I]));
                    SetNodeImages(NewNode, PStatement(fParser.Statements[I]));
                    If (PStatement(fParser.Statements[I])^._Kind = skClass) And (I <> ParentIndex) Then  // CL: fixed potential infinite loop bug
                        AddMembers(NewNode, I, _ID);
                End;
            End;
        End;
    Finally
        sl.Free;
    End;
End;
//Added by Jason Jiang
Procedure TClassBrowser.Loaded;
Begin
    DesktopFont := True;
End;

Constructor TClassBrowser.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);
  //DesktopFont := True;    //This line of code caused a design time error moved to Loaded procedure ---- Jason Jiang
    OnMouseUp := OnNodeChange;
    OnMouseDown := OnNodeChanging;
    DragMode := dmAutomatic;
    OnDragOver := myDragOver;
    OnDragDrop := myDragDrop;
    SetLength(fFolders, 0);
    SetLength(fFolderAssocs, 0);
    fImagesRecord := TImagesRecord.Create;
    fCurrentFile := '';
    fCurrentFileHeader := '';
    fCurrentFileImpl := '';
    fShowFilter := sfAll;
    fParserBusy := False;
    fProjectDir := '';
    fClassFoldersFile := '';
    ShowHint := True;
    HideSelection := False;
    RightClickSelect := True;
    fShowInheritedMembers := False;
    SetUseColors(True);
    fShowingSampleData := False;
End;

Destructor TClassBrowser.Destroy;
Begin
    SetLength(fFolderAssocs, 0);
    SetLength(fFolders, 0);
    If Assigned(fImagesRecord) Then
        FreeAndNil(fImagesRecord)
    Else fImagesRecord := Nil;

    If fUseColors Then
        SetUseColors(False);

    Inherited Destroy;
End;

Procedure TClassBrowser.UpdateView;
Begin
    If fParser = Nil Then
        Exit;

    fParserBusy := True;
    Items.BeginUpdate;
    Clear;
    ReadClassFolders;
    AddMembers(Nil, -1, -1);
    Sort;
    If fLastSelection <> '' Then
        ReSelect;
    WriteClassFolders;
    Items.EndUpdate;
    fParserBusy := False;
    Repaint;
End;

Procedure TClassBrowser.OnNodeChanging(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
    Node: TTreeNode;
Begin
    If htOnItem In GetHitTestInfoAt(X, Y) Then
        Node := GetNodeAt(X, Y)
    Else
        Node := Nil;
    Selected := Node;
End;

Procedure TClassBrowser.OnNodeChange(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
    Node: TTreeNode;
Begin
    Inherited;

    If htOnItem In GetHitTestInfoAt(X, Y) Then
        Node := GetNodeAt(X, Y)
    Else
        Node := Nil;

    If Not Assigned(Node) Then
    Begin
        fLastSelection := '';
        Exit;
    End
    Else
    If Not Assigned(Node.Data) Then
    Begin
        fLastSelection := '';
        Exit;
    End
    Else
    If Not fShowingSampleData And (fParser = Nil) Then
    Begin
        Node.Data := Nil;
        fLastSelection := '';
        Exit;
    End
    Else
    If Not fShowingSampleData And (fParser.Statements.IndexOf(Node.Data) = -1) Then
    Begin
        Node.Data := Nil;
        fLastSelection := '';
        Exit;
    End;

    If Node.ImageIndex = fImagesRecord.fGlobalsImg Then
    Begin
        fLastSelection := PFolders(Node.Data)^.Under;
        Exit;
    End;

    With PStatement(Node.Data)^ Do
    Begin
        fLastSelection := ExtractFileName(_Filename) + ':' + IntToStr(_Line) + ':' + _FullText;

        If Assigned(fOnSelect) Then
            If (Button = mbLeft) And Not (ssShift In Shift) Then // need implementation
                If _IsDeclaration Then
                    fOnSelect(Self, _DeclImplFileName, _DeclImplLine)
                Else
                    fOnSelect(Self, _FileName, _Line)
            Else
            If (Button = mbLeft) And (ssShift In Shift) Then // // need declaration
                If _IsDeclaration Then
                    fOnSelect(Self, _FileName, _Line)
                Else
                    fOnSelect(Self, _DeclImplFileName, _DeclImplLine);
    End;
End;

Procedure TClassBrowser.SetParser(Value: TCppParser);
Begin
    If Value <> fParser Then
    Begin
        fParser := Value;
        If Assigned(fParser) Then
        Begin
            fParser.OnUpdate := OnParserUpdate;
            fParser.OnBusy := OnParserBusy;
        End;
        UpdateView;
    End;
End;

Procedure TClassBrowser.SetUpdateOn;
Begin
    If Assigned(fParser) Then
        fParser.OnUpdate := OnParserUpdate;
End;

Procedure TClassBrowser.SetUpdateOff;
Begin
    If Assigned(fParser) Then
        fParser.OnUpdate := Nil;
End;

Procedure TClassBrowser.OnParserUpdate(Sender: TObject);
Begin
    fParserBusy := False;
    UpdateView;
End;

Procedure TClassBrowser.OnParserBusy(Sender: TObject);
Begin
    fParserBusy := True;
End;

Procedure TClassBrowser.ShowSampleData;
    Function CreateTempStatement(Full, Typ, Cmd, Args: String; K: TStatementKind; S: TStatementClassScope): PStatement;
    Begin
        Result := New(PStatement);
        With Result^ Do
        Begin
            _FullText := Full;
            _Type := Typ;
            _ScopelessCmd := Cmd;
            _Command := _ScopelessCmd;
            _Args := Args;
            _Visible := True;
            _Valid := True;
            _Kind := K;
            _ClassScope := S;
        End;
    End;
Var
    Node, SubNode: TTreeNode;
    Statement: PStatement;
Begin
    fShowingSampleData := True;
    Items.Clear;
    With Items Do
    Begin
        Statement := CreateTempStatement('class Class1', 'class', 'Class1', '', skClass, scsNone);
        Node := AddChildObject(Nil, '  ' + Statement^._Command + '  ', Statement);
        SetNodeImages(Node, Statement);

        Statement := CreateTempStatement('Class1()', '', 'Class1', '', skConstructor, scsPublic);
        SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
        SetNodeImages(SubNode, Statement);

        Statement := CreateTempStatement('~Class1()', '', '~Class1', '', skDestructor, scsPublic);
        SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
        SetNodeImages(SubNode, Statement);

        Statement := CreateTempStatement('int private_Var1', 'int', 'private_Var1', '', skVariable, scsPrivate);
        SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
        SetNodeImages(SubNode, Statement);

        Statement := CreateTempStatement('int private_Var2', 'int', 'private_Var2', '', skVariable, scsPrivate);
        SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
        SetNodeImages(SubNode, Statement);

        Statement := CreateTempStatement('void protected_Func1(int x, int y)', 'void', 'protected_Func1', '(int x, int y)', skFunction, scsProtected);
        SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
        SetNodeImages(SubNode, Statement);

        Statement := CreateTempStatement('double public_Var1', 'double', 'public_Var1', '', skVariable, scsPublic);
        SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
        SetNodeImages(SubNode, Statement);

        Statement := CreateTempStatement('bool published_Func1(char* temp)', 'bool', 'published_Func1', '(char* temp)', skFunction, scsPublished);
        SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
        SetNodeImages(SubNode, Statement);
        Expand(Node);

        Statement := CreateTempStatement('class Class2', 'class', 'Class2', '', skClass, scsNone);
        Node := AddChildObject(Nil, '  ' + Statement^._Command + '  ', Statement);
        SetNodeImages(Node, Statement);

        Statement := CreateTempStatement('Class2()', '', 'Class2', '', skConstructor, scsPublic);
        SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
        SetNodeImages(SubNode, Statement);

        Statement := CreateTempStatement('~Class2()', '', '~Class2', '', skDestructor, scsPublic);
        SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
        SetNodeImages(SubNode, Statement);

        Statement := CreateTempStatement('int private_Var1', 'int', 'private_Var1', '', skVariable, scsPrivate);
        SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
        SetNodeImages(SubNode, Statement);

        Statement := CreateTempStatement('int private_Var2', 'int', 'private_Var2', '', skVariable, scsPrivate);
        SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
        SetNodeImages(SubNode, Statement);

        Statement := CreateTempStatement('void protected_Func1(int x, int y)', 'void', 'protected_Func1', '(int x, int y)', skFunction, scsProtected);
        SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
        SetNodeImages(SubNode, Statement);

        Statement := CreateTempStatement('double public_Var1', 'double', 'public_Var1', '', skVariable, scsPublic);
        SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
        SetNodeImages(SubNode, Statement);

        Statement := CreateTempStatement('bool published_Func1(char* temp)', 'bool', 'published_Func1', '(char* temp)', skFunction, scsPublished);
        SubNode := AddChildObject(Node, '  ' + Statement^._Command + '  ', Statement);
        SetNodeImages(SubNode, Statement);
        Expand(Node);
    End;
End;

Function CustomSortProc(Node1, Node2: TTreeNode; Data: Integer): Integer; Stdcall;
Begin
    If (Node1.ImageIndex = 0) Or (Node2.ImageIndex = 0) Then
        Result := Node1.ImageIndex - Node2.ImageIndex
    Else
        Result := Ord(PStatement(Node1.Data)^._Kind) - Ord(PStatement(Node2.Data)^._Kind);
    If Result = 0 Then
        Result := AnsiStrIComp(Pchar(Node1.Text), Pchar(Node2.Text));
End;

Procedure TClassBrowser.Sort;
Begin
    CustomSort(@CustomSortProc, 0);
End;

Procedure TClassBrowser.SetCurrentFile(Value: String);
Begin
    If fShowFilter <> sfCurrent Then
        Exit;
    fCurrentFile := Value;
    fCurrentFileHeader := ChangeFileExt(fCurrentFile, '.h');
    If Not FileExists(fCurrentFileHeader) Then
        fCurrentFileHeader := ChangeFileExt(fCurrentFile, '.hpp');
    If Not FileExists(fCurrentFileHeader) Then
        fCurrentFileHeader := ChangeFileExt(fCurrentFile, '.hh');
    fCurrentFileImpl := ChangeFileExt(fCurrentFile, '.c');
    If Not FileExists(fCurrentFileImpl) Then
        fCurrentFileImpl := ChangeFileExt(fCurrentFile, '.cpp');
    If Not FileExists(fCurrentFileImpl) Then
        fCurrentFileImpl := ChangeFileExt(fCurrentFile, '.cc');
    fCurrentFileHeader := LowerCase(fCurrentFileHeader);
    fCurrentFileImpl := LowerCase(fCurrentFileImpl);
    UpdateView;
End;

Procedure TClassBrowser.Clear;
Begin
    Items.Clear;
    SetLength(fFolders, 0);
    SetLength(fFolderAssocs, 0);
End;

Procedure TClassBrowser.SetShowFilter(Const Value: TShowFilter);
Begin
    If fShowFilter <> Value Then
    Begin
        fShowFilter := Value;
        UpdateView;
    End;
End;

// returns the index to fFolders it belongs or -1 if does not

Function TClassBrowser.BelongsToFolder(Cmd: String): Integer;
Var
    I: Integer;
Begin
    Result := -1;
    For I := Low(fFolderAssocs) To High(fFolderAssocs) Do
        If AnsiCompareText(fFolderAssocs[I].Command, Cmd) = 0 Then
            Result := fFolderAssocs[I].FolderID;
End;

// creates folders under Command

Procedure TClassBrowser.CreateFolders(Cmd: String; Node: TTreeNode);
Var
    I: Integer;
Begin
    For I := Low(fFolders) To High(fFolders) Do
        If AnsiCompareText(fFolders[I].Under, Cmd) = 0 Then
        Begin
            fFolders[I].Node := Items.AddChildObjectFirst(Node, fFolders[I].Name, @fFolders[I]);
//      if AnsiCompareStr(fFolders[I].Under, #01#02+Char(I)) = 0 then
            CreateFolders(#01#02 + Char(I), fFolders[I].Node);
        End;
End;

Function TClassBrowser.HasSubFolder(Cmd: String): Boolean;
Var
    I: Integer;
Begin
    Result := False;
    For I := Low(fFolders) To High(fFolders) Do
        If AnsiCompareText(fFolders[I].Under, Cmd) = 0 Then
        Begin
            Result := True;
            Break;
        End;
End;

Procedure TClassBrowser.ReadClassFolders;
Var
    Magic: Array[0..8] Of Char;
    iNumEntries: Integer;
    hFile: Integer;
    I: Integer;
Begin
    If fProjectDir = '' Then
        Exit;

    hFile := FileOpen(fProjectDir + '\' + fClassFoldersFile, fmOpenRead);
    If hFile <= 0 Then
        Exit; // file not open

    FileRead(hFile, Magic, SizeOf(Magic));
    If Magic <> CLASS_FOLDERS_MAGIC Then
    Begin
        FileClose(hFile);
        Exit; // magic different
    End;

  // folders
    FileRead(hFile, iNumEntries, SizeOf(Integer));
    SetLength(fFolders, iNumEntries);
    For I := Low(fFolders) To High(fFolders) Do
    Begin
        fFolders[I].Index := Char(I);
        FileRead(hFile, fFolders[I].Name, SizeOf(fFolders[I].Name));
        FileRead(hFile, fFolders[I].Under, SizeOf(fFolders[I].Under));
    End;

  // associations
    FileRead(hFile, iNumEntries, SizeOf(Integer));
    SetLength(fFolderAssocs, iNumEntries);
    For I := Low(fFolderAssocs) To High(fFolderAssocs) Do
    Begin
        FileRead(hFile, fFolderAssocs[I].FolderID, SizeOf(fFolderAssocs[I].FolderID));
        fFolderAssocs[I].Folder := fFolders[fFolderAssocs[I].FolderID].Name;
        FileRead(hFile, fFolderAssocs[I].Command, SizeOf(fFolderAssocs[I].Command));
    End;

    FileClose(hFile);
End;

Procedure TClassBrowser.WriteClassFolders;
Var
    Magic: Array[0..8] Of Char;
    iNumEntries: Integer;
    hFile: Integer;
    I: Integer;
Begin
    If fProjectDir = '' Then
        Exit;

    If High(fFolders) = -1 Then
    Begin
        DeleteFile(fProjectDir + '\' + fClassFoldersFile);
        Exit;
    End;

    hFile := FileCreate(fProjectDir + '\' + fClassFoldersFile);
    If hFile <= 0 Then
        Exit; // file not open

    Magic := CLASS_FOLDERS_MAGIC;
    FileWrite(hFile, Magic, SizeOf(Magic));

  // folders
    iNumEntries := High(fFolders) + 1;
    FileWrite(hFile, iNumEntries, SizeOf(Integer));
    For I := Low(fFolders) To High(fFolders) Do
    Begin
        FileWrite(hFile, fFolders[I].Name, SizeOf(fFolders[I].Name));
        FileWrite(hFile, fFolders[I].Under, SizeOf(fFolders[I].Under));
    End;

  // associations
    iNumEntries := High(fFolderAssocs) + 1;
    FileWrite(hFile, iNumEntries, SizeOf(Integer));
    For I := Low(fFolderAssocs) To High(fFolderAssocs) Do
    Begin
        FileWrite(hFile, fFolderAssocs[I].FolderID, SizeOf(fFolderAssocs[I].FolderID));
        FileWrite(hFile, fFolderAssocs[I].Command, SizeOf(fFolderAssocs[I].Command));
    End;

    FileClose(hFile);
End;

Procedure TClassBrowser.AddFolder(S: String; Node: TTreeNode);
Begin
    If High(fFolders) >= MAX_CUSTOM_FOLDERS Then
        Exit;

    If S = '' Then
        Exit;

    If Length(S) > 32 Then
        S := Copy(S, 1, 32);

    SetLength(fFolders, High(fFolders) + 2);
    fFolders[High(fFolders)].Index := Char(High(fFolders));
    fFolders[High(fFolders)].Name := S;
    If Assigned(Node) And (Node.ImageIndex <> fImagesRecord.fGlobalsImg) And Not Node.HasChildren Then
        Node := Node.Parent;
    If Assigned(Node) Then
    Begin
        If Node.ImageIndex <> fImagesRecord.fGlobalsImg Then
            With PStatement(Node.Data)^ Do
                fFolders[High(fFolders)].Under := ExtractFileName(_Filename) + ':' + IntToStr(_Line) + ':' + _FullText
        Else
            fFolders[High(fFolders)].Under := #01#02 + Char(PFolders(Node.Data)^.Index);
    End;
    fFolders[High(fFolders)].Node := Items.AddChildObjectFirst(Node, fFolders[High(fFolders)].Name, @fFolders[High(fFolders)]);
    WriteClassFolders;
End;

Procedure TClassBrowser.RemoveFolder(S: String);
Var
    I: Integer;
    C: Integer;
Begin
    For I := Low(fFolders) To High(fFolders) Do
        If AnsiCompareText(fFolders[I].Name, S) = 0 Then
        Begin
            If Assigned(fFolders[I].Node) Then
            Begin
                While fFolders[I].Node.Count > 0 Do
                    fFolders[I].Node[0].MoveTo(fFolders[I].Node.Parent, naAddChild);
                fFolders[I].Node.Delete;
            End;
            RemoveFolderAssociation(fFolders[I].Name, '');
            For C := I + 1 To High(fFolders) Do
                fFolders[C - 1] := fFolders[C];
            SetLength(fFolders, High(fFolders));
            Break;
        End;
    Items.BeginUpdate;
    Sort;
    Items.EndUpdate;
    WriteClassFolders;
    Refresh;
End;

Procedure TClassBrowser.AddFolderAssociation(Fld, Cmd: String);
Var
    Index: Integer;
Begin
    If (Fld = '') Or (Cmd = '') Then
        Exit;

    If Length(Fld) > 32 Then
        Fld := Copy(Fld, 1, 32);
    If Length(Cmd) > 128 Then
        Cmd := Copy(Cmd, 1, 128);

    Index := IndexOfFolder(Fld);
    If Index <> -1 Then
    Begin
        SetLength(fFolderAssocs, High(fFolderAssocs) + 2);
        fFolderAssocs[High(fFolderAssocs)].FolderID := Index;
        fFolderAssocs[High(fFolderAssocs)].Folder := Fld;
        fFolderAssocs[High(fFolderAssocs)].Command := Cmd;
    End;
End;

Procedure TClassBrowser.RemoveFolderAssociation(Fld, Cmd: String);
Var
    I: Integer;
    C: Integer;
    Index: Integer;
Begin
    Index := IndexOfFolder(Fld);
    If (Index <> -1) Or (Fld = '') Then
    Begin
        I := Low(fFolderAssocs);
        While I <= High(fFolderAssocs) Do
            If ((Fld = '') Or (fFolderAssocs[I].FolderID = Index)) And
                ((Cmd = '') Or (AnsiCompareText(fFolderAssocs[I].Command, Cmd) = 0)) Then
            Begin
                For C := I + 1 To High(fFolderAssocs) Do
                    fFolderAssocs[C - 1] := fFolderAssocs[C];
                SetLength(fFolderAssocs, High(fFolderAssocs));
            End
            Else
                Inc(I);
    End;
End;

Function TClassBrowser.GetNodeOfFolder(Index: Integer): TTreeNode;
Begin
    Result := Nil;
    If Index <= High(fFolders) Then
        Result := fFolders[Index].Node;
End;

Function TClassBrowser.GetNodeOfFolder(Folder: String): TTreeNode;
Var
    I: Integer;
Begin
    Result := Nil;
    For I := Low(fFolders) To High(fFolders) Do
        If AnsiCompareText(fFolders[I].Name, Folder) = 0 Then
        Begin
            Result := fFolders[I].Node;
            Break;
        End;
End;

Function TClassBrowser.IsNodeAFolder(FolderNode: TTreeNode): Boolean;
Var
    I: Integer;
Begin
    Result := False;
    For I := Low(fFolders) To High(fFolders) Do
        If FolderNode = fFolders[I].Node Then
        Begin
            Result := True;
            break;
        End;
End;

Procedure TClassBrowser.myDragDrop(Sender, Source: TObject; X, Y: Integer);
Var
    Node: TTreeNode;
Begin
    If htOnItem In GetHitTestInfoAt(X, Y) Then
        Node := GetNodeAt(X, Y)
    Else
        Node := Nil;

  // if drag node is a folder
    If Selected.ImageIndex = fImagesRecord.fGlobalsImg Then
    Begin
        If Assigned(Selected.Data) Then
            If Assigned(Node) Then
            Begin
                If Selected.ImageIndex <> fImagesRecord.fGlobalsImg Then
                    With PStatement(Node.Data)^ Do
                        PFolders(Selected.Data)^.Under := ExtractFileName(_Filename) + ':' + IntToStr(_Line) + ':' + _FullText
                Else
                    PFolders(Selected.Data)^.Under := #01#02 + Char(PFolders(Node.Data)^.Index);
            End
            Else
                PFolders(Selected.Data)^.Under := '';
    End
  // drag node is statement
    Else With PStatement(Selected.Data)^ Do
        Begin // dragged node is Statement, so Node is folder
            RemoveFolderAssociation('', ExtractFileName(_Filename) + ':' + IntToStr(_Line) + ':' + _FullText);
            If Assigned(Node) Then
                AddFolderAssociation(Node.Text, ExtractFileName(_Filename) + ':' + IntToStr(_Line) + ':' + _FullText);
        End;

    If Assigned(Selected) Then
        Selected.MoveTo(Node, naAddChildFirst);

    Items.BeginUpdate;
    Sort;
    Items.EndUpdate;
    WriteClassFolders;
    Refresh;
End;

Procedure TClassBrowser.myDragOver(Sender, Source: TObject; X, Y: Integer;
    State: TDragState; Var Accept: Boolean);
Var
    Node: TTreeNode;
Begin
    If htOnItem In GetHitTestInfoAt(X, Y) Then
        Node := GetNodeAt(X, Y)
    Else
        Node := Nil;
    Accept := (Source Is TClassBrowser) And
        (
        (
    // drag node is folder, drop node is not and drop node has children
        Assigned(Node) And (Selected.ImageIndex = fImagesRecord.fGlobalsImg) {and (Node.ImageIndex <> fImagesRecord.fGlobalsImg)} And Node.HasChildren
        ) Or
        (
    // drag node is folder and drop node is folder
        Assigned(Node) And (Selected.ImageIndex = fImagesRecord.fGlobalsImg) And (Node.ImageIndex = fImagesRecord.fGlobalsImg)
        ) Or
        (
    // drag node is not folder, drop node is folder
        Assigned(Node) And (Selected.ImageIndex <> fImagesRecord.fGlobalsImg) And (Node.ImageIndex = fImagesRecord.fGlobalsImg)
        ) Or
    // not drop node
        Not Assigned(Node)
        ) And
        (Node <> Selected);
End;

Procedure TClassBrowser.myMouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
Var
    Node: TTreeNode;
Begin
    If fParserBusy Then
        Exit;
    Node := GetNodeAt(X, Y);
    If Assigned(Node) And Assigned(Node.Data) And (Node.ImageIndex <> fImagesRecord.fGlobalsImg) Then
    Begin
        Hint := PStatement(Node.Data)^._FullText;
        Application.ActivateHint(ClientToScreen(Point(X, Y)));
    End
    Else
        Application.HideHint;
End;

Procedure TClassBrowser.RenameFolder(Old, New: String);
Var
    I: Integer;
    Index: Integer;
Begin
    Index := IndexOfFolder(Old);

    If Index <> -1 Then
    Begin
        fFolders[Index].Name := New;

        For I := Low(fFolderAssocs) To High(fFolderAssocs) Do
            If fFolderAssocs[I].FolderID = Index Then
                fFolderAssocs[I].Folder := New;

        fFolders[Index].Node.Text := New;
        WriteClassFolders;
        Refresh;
    End;
End;

Function TClassBrowser.IndexOfFolder(Fld: String): Integer;
Var
    I: Integer;
Begin
    Result := -1;
    For I := Low(fFolders) To High(fFolders) Do
        If AnsiCompareText(Fld, fFolders[I].Name) = 0 Then
        Begin
            Result := I;
            Break;
        End;
End;

Procedure TClassBrowser.ReSelect;
    Function DoSelect(Node: TTreeNode): Boolean;
    Var
        I: Integer;
        OldSelection: String;
    Begin
        Result := False;
        For I := 0 To Node.Count - 1 Do
        Begin
            If Node[I].ImageIndex <> fImagesRecord.fGlobalsImg Then
                With PStatement(Node[I].Data)^ Do
                    OldSelection := ExtractFileName(_Filename) + ':' + IntToStr(_Line) + ':' + _FullText
            Else
                OldSelection := PFolders(Node[I].Data)^.Under;
            If AnsiCompareStr(OldSelection, fLastSelection) = 0 Then
            Begin
                Selected := Node[I];
                Result := True;
                Break;
            End
            Else
            If Node[I].HasChildren Then
            Begin
                Result := DoSelect(Node[I]);
                If Result Then
                    Break;
            End;
        End;
    End;
Var
    I: Integer;
    OldSelection: String;
Begin
    For I := 0 To Items.Count - 1 Do
    Begin
        If Items[I].ImageIndex <> fImagesRecord.fGlobalsImg Then
            With PStatement(Items[I].Data)^ Do
                OldSelection := ExtractFileName(_Filename) + ':' + IntToStr(_Line) + ':' + _FullText
        Else
            OldSelection := PFolders(Items[I].Data)^.Under;
        If AnsiCompareStr(OldSelection, fLastSelection) = 0 Then
        Begin
            Selected := Items[I];
            Break;
        End
        Else
        If Items[I].HasChildren Then
            If DoSelect(Items[I]) Then
                Break;
    End;
End;

Function TClassBrowser.FolderCount: Integer;
Begin
    Result := High(fFolders) + 1;
End;

Procedure TClassBrowser.CustomPaintMe(Var Msg: TMessage);
Var
    I: Integer;
    NodeRect, tmp: TRect;
    st: PStatement;
    bInherited: Boolean;
    currItem: TTreeNode;
Begin
    Inherited;

    If fParserBusy Then
        Exit;

    If Not Assigned(fCnv) Or Not fUseColors Then
        Exit;

    For I := 0 To Items.Count - 1 Do
    Begin
        currItem := Items[I];

        If currItem.IsVisible Then
        Begin
            NodeRect := currItem.DisplayRect(True);

            If currItem.ImageIndex <> fImagesRecord.fGlobalsImg Then
            Begin
                fCnv.Font.Color := Self.Font.Color;
                fCnv.Brush.Color := Color;
                fCnv.FillRect(NodeRect);
                st := currItem.Data;
                If Assigned(fParser) Or fShowingSampleData Then
                    If Assigned(st) Then
                        If fShowingSampleData
                            Or (fParser.Statements.IndexOf(st) <> -1) Then
                        Begin
                            fCnv.Font.Style := [fsBold];
                            If Selected = currItem Then
                            Begin
                                fCnv.Font.Color := clHighlightText;
                                fCnv.Brush.Color := clHighlight;
                                tmp := NodeRect;
                                tmp.Right := tmp.Left + fCnv.TextWidth(st^._ScopelessCmd) + 4;
                                fCnv.FillRect(tmp);
                            End;

                            bInherited := fShowInheritedMembers And
                                Assigned(currItem.Parent) And
                                (currItem.Parent.ImageIndex <> fImagesRecord.Globals) And
                                Assigned(currItem.Parent.Data) And
                                (fShowingSampleData Or
                                (fParser.Statements.IndexOf(currItem.Parent.Data) <> -1)) And
                                (PStatement(currItem.Parent.Data)^._ID <> st^._ParentID);

                            If bInherited Then
                                fCnv.Font.Color := clGray;

                            fCnv.TextOut(NodeRect.Left + 2, NodeRect.Top + 1, st^._ScopelessCmd);
                            If bInherited Then
                                fCnv.Font.Color := clGray
                            Else
                                fCnv.Font.Color := Self.Font.Color;
                            fCnv.Brush.Color := Color;

                            NodeRect.Left := NodeRect.Left + fCnv.TextWidth(st^._ScopelessCmd) + 2;
                            fCnv.Font.Style := [];
                            If bInherited Then
                                fCnv.Font.Color := clGray
                            Else
                                fCnv.Font.Color := clMaroon;
                            fCnv.TextOut(NodeRect.Left + 2, NodeRect.Top + 1, st^._Args);

                            If st^._Type <> '' Then
                            Begin
                                fCnv.Font.Color := clGray;
                                NodeRect.Left := NodeRect.Left + fCnv.TextWidth(st^._Args) + 2;
                                fCnv.TextOut(NodeRect.Left + 2, NodeRect.Top + 1, ': ' + st^._Type);
                            End
                            Else
                            Begin
                                If st^._Kind In [skConstructor, skDestructor] Then
                                Begin
                                    fCnv.Font.Color := clGray;
                                    NodeRect.Left := NodeRect.Left + fCnv.TextWidth(st^._Args) + 2;
                                    fCnv.TextOut(NodeRect.Left + 2, NodeRect.Top + 1, ': ' + fParser.StatementKindStr(st^._Kind));
                                End;
                            End;
                        End
                        Else
                            currItem.Data := Nil;
            End
            Else
            Begin
                fCnv.Font.Style := [fsBold];
                If Selected = currItem Then
                Begin
                    fCnv.Font.Color := clHighlightText;
                    fCnv.Brush.Color := clHighlight;
                    tmp := NodeRect;
                    tmp.Right := tmp.Left + fCnv.TextWidth(currItem.Text) + 4;
                    fCnv.FillRect(tmp);
                End
                Else
                Begin
                    fCnv.Font.Color := clNavy;
                    fCnv.Brush.Color := Color;
                End;
                fCnv.FillRect(NodeRect);
                fCnv.TextOut(NodeRect.Left + 2, NodeRect.Top + 1, currItem.Text);
            End;
        End;
    End;
End;

Procedure TClassBrowser.SetUseColors(Const Value: Boolean);
Begin
    fUseColors := Value;
    If Not fUseColors Then
    Begin
        OnMouseMove := myMouseMove;
        If Assigned(fCnv) Then
        Begin
            fCnv.Free;
            fCnv := Nil;
        End;
    End
    Else
    Begin
        OnMouseMove := Nil;
        If Not Assigned(fCnv) Then
        Begin
            fCnv := TControlCanvas.Create;
            fCnv.Control := Self;
            fCnv.Font.Assign(Self.Font);
            fCnv.Brush.Style := bsClear;
        End;
    End;
End;

Procedure TClassBrowser.SetShowInheritedMembers(Const Value: Boolean);
Begin
    If Value <> fShowInheritedMembers Then
    Begin
        fShowInheritedMembers := Value;
        If Not fParserBusy Then
            UpdateView;
    End;
End;

End.
