{
    $Id: datamod.pas 744 2006-12-19 11:15:08Z lowjoel $

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

Unit datamod;

Interface

Uses
{$IFDEF PLUGIN_BUILD}
    SynHighlighterXML,
{$ENDIF}
{$IFDEF WIN32}
    SysUtils, Classes, Menus, Dialogs, ImgList, Controls,
    SynEditExport, SynExportHTML, SynExportRTF,
    SynEditHighlighter, SynHighlighterCpp, SynEditPrint,
    oysUtils, CodeIns, SynHighlighterRC, SynCompletionProposal,
    SynEditMiscClasses, SynEditSearch, SynHighlighterAsm,
    SynHighlighterMulti, OpenSaveDialogs;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QMenus, QDialogs, QImgList, QControls,
  QSynEditExport, QSynExportHTML, QSynExportRTF,
  QSynEditHighlighter, QSynHighlighterCpp, QSynEditPrint,
  oysUtils, CodeIns, QSynHighlighterRC, QSynCompletionProposal,
  QSynEditMiscClasses, QSynEditSearch;
{$ENDIF}

Type
    TdmMain = Class(TDataModule)
        Cpp: TSynCppSyn;
        Res: TSynRCSyn;
        XML: TSynXMLSyn;
        SynExporterRTF: TSynExporterRTF;
        SynExporterHTML: TSynExporterHTML;
        PrinterSetupDialog: TPrinterSetupDialog;
        SynEditPrint: TSynEditPrint;
        ProjectImage_Gnome: TImageList;
        MenuImages_Gnome: TImageList;
        HelpImages_Gnome: TImageList;
        MenuImages_NewLook: TImageList;
        ProjectImage_NewLook: TImageList;
        HelpImages_NewLook: TImageList;
        SpecialImages_Gnome: TImageList;
        SpecialImages_NewLook: TImageList;
        GutterImages: TImageList;
        MenuImages_Blue: TImageList;
        HelpImages_Blue: TImageList;
        ProjectImage_Blue: TImageList;
        Specialimages_Blue: TImageList;
        ResourceDialog: TOpenDialog;
        SynHint: TSynCompletionProposal;
        ClassImages: TImageList;
        Assembly: TSynAsmSyn;
        CppMultiSyn: TSynMultiSyn;
        MenuImages_Classic: TImageList;
        ProjectImage_Classic: TImageList;
        HelpImages_Classic: TImageList;
        SpecialImages_Classic: TImageList;
        Procedure DataModuleCreate(Sender: TObject);
        Procedure DataModuleDestroy(Sender: TObject);
    Private
        fUnitCount: Integer;
        { Code Inserts }
    Private
        fCodeList: TCodeInsList;
        fCodeMenu: TMenuItem;
        fCodePop: TMenuItem;
        fCodeEvent: TNotifyEvent;
        fCodeOffset: Byte;
        Procedure LoadCodeIns;
    Public
        Function InsertList: TStrings;
        Property CodeMenu: TMenuItem Read fCodeMenu Write fCodeMenu;
        Property CodePop: TMenuItem Read fCodePop Write fCodePop;
        Property CodeClick: TNotifyEvent Read fCodeEvent Write fCodeEvent;
        Property CodeInserts: TCodeInsList Read fCodeList Write fCodeList;
        Property CodeOffset: Byte Read fCodeOffset Write fCodeOffset;

        { MRU List }
    Private
        fMRU: ToysStringList;
        fMRUMenu: TMenuItem;
        fMRUMax: Byte;
        fMRUOffset: Integer;
        fMRUClick: TNotifyEvent;
        Procedure LoadHistory;
        Procedure SaveHistory;
        Procedure RebuildMRU;
        Function GetMRU(index: Integer): String;
    Public
        fProjectCount: Integer;
        SaveDialog: TSaveDialogEx;
        OpenDialog: TOpenDialogEx;
        Procedure AddtoHistory(s: String);
        Procedure RemoveFromHistory(s: String);
        Procedure ClearHistory;
        Property MRU[index: Integer]: String Read GetMRU;
        Property MRUMenu: TMenuItem Read fMRUMenu Write fMRUMenu;
        Property MRUOffset: Integer Read fMRUOffset Write fMRUOffset;
        Property MRUMax: Byte Read fMRUMax Write fMRUMax;
        Property MRUClick: TNotifyEvent Read fMRUClick Write fMRUClick;

    Public
        Procedure LoadDataMod;
        Function GetNumber: Integer;
        Function GetNum: Integer;
        Procedure InitHighlighterFirstTime;
        Procedure UpdateHighlighter;
        Function GetHighlighter(Const FileName: String): TSynCustomHighlighter;

        Procedure ExportToHtml(FileLines: TStrings; ExportFilename: String);
        Procedure ExportToRtf(FileLines: TStrings; ExportFilename: String);
    End;

Var
    dmMain: TdmMain;

Implementation

Uses
    devcfg, IniFiles, utils, version, main, MultiLangSupport,
    windows, ShellAPI, ShlOBJ;

{$R *.dfm}

{ TdmMain }

Procedure TdmMain.DataModuleCreate(Sender: TObject);
Begin
    fMRU := ToysStringList.Create;
    fCodeList := TCodeInsList.Create;

    //Set up the syntax highlighter stuff
    // #32 = space          #9=tab

    CppMultiSyn.Schemes[0].StartExpr := '(asm|_asm|__asm)(['#32#9']*)\{';
    CppMultiSyn.Schemes[0].EndExpr := '\}';
    CppMultiSyn.Schemes[1].StartExpr := '^\s+(asm|_asm|__asm)(['#32#9']*)';
    CppMultiSyn.Schemes[1].EndExpr := '(;*)$';

    SaveDialog := TSaveDialogEx.Create(MainForm);
    SaveDialog.DefaultExt := 'cpp';
    SaveDialog.Filter := 'Dev-C++ project file (*.dev)|*.dev';
    SaveDialog.Options := [ofHideReadOnly, ofNoChangeDir,
        ofPathMustExist, ofCreatePrompt, ofNoReadOnlyReturn, ofEnableSizing,
        ofDontAddToRecent];
    SaveDialog.Title := 'Create new project';

    OpenDialog := TOpenDialogEx.Create(MainForm);
    OpenDialog.Filter :=
        'Dev-C++ project files|*.dev|C and C++ files|*.c;*.cpp|C++ files|' +
        '*.cpp|C files|*.c|Header files|*.h|C++ Header files|*.hpp|Resour' +
        'ce header|*.rh|Resource files|*.rc|Dev-C++ Project, C/C++ and re' +
        'source files|*.c;*.cpp;*.dev;*.rc|All files (*.*)|*.*';
    OpenDialog.FilterIndex := 9;
    OpenDialog.Options := [ofHideReadOnly, ofNoChangeDir,
        ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofEnableSizing];
    OpenDialog.Title := 'Open file';
End;

Procedure TdmMain.DataModuleDestroy(Sender: TObject);
Begin
    SaveHistory;
    fMRU.Free;
    fCodeList.Free;
End;

Procedure TdmMain.InitHighlighterFirstTime;
    Procedure AddSpecial(AttrName: String; Offset: Integer);
    Var
        a: Integer;
    Begin
        a := devEditor.Syntax.IndexofName(AttrName);
        If a = -1 Then
            devEditor.Syntax.Append(format('%s=%s', [AttrName, LoadStr(offset)]))
        Else
            devEditor.Syntax.Values[AttrName] := LoadStr(offset);
    End;
Var
    i, a, offset: Integer;
    Attr: TSynHighlighterAttributes;
Begin
    offset := 0 * 1000; // default to style-set '0'
    For i := 0 To pred(cpp.AttrCount) Do
    Begin
        attr := TSynHighlighterAttributes.Create(cpp.Attribute[i].Name);
        Try
            StrtoAttr(Attr, LoadStr(i + offset + 1));
            cpp.Attribute[i].Assign(Attr);
            a := devEditor.Syntax.IndexOfName(cpp.Attribute[i].Name);
            If a = -1 Then
                devEditor.Syntax.Append(format('%s=%s',
                    [cpp.Attribute[i].Name, AttrtoStr(Attr)]))
            Else
                devEditor.Syntax.Values[cpp.Attribute[i].Name] := AttrtoStr(Attr);
        Finally
            Attr.Free;
        End;
    End;
    AddSpecial(cBP, offset + 17); // breakpoint
    AddSpecial(cErr, offset + 18); // error line
    AddSpecial(cABP, offset + 19); // active breakpoint
    AddSpecial(cGut, offset + 20); // gutter
    AddSpecial(cSel, offset + 21); // selected text
End;

Procedure TdmMain.UpdateHighlighter;
Var
    Attr: TSynHighlighterAttributes;
    aName: String;
    a,
    idx: Integer;
Begin
    For idx := 0 To pred(cpp.AttrCount) Do
    Begin
        aName := cpp.Attribute[idx].Name;
        a := devEditor.Syntax.IndexOfName(aName);
        If a <> -1 Then
        Begin
            Attr := TSynHighlighterAttributes.Create(aName);
            Try
                StrtoAttr(Attr, devEditor.Syntax.Values[aname]);
                cpp.Attribute[idx].Assign(attr);
            Finally
                Attr.Free;
            End;
        End;
    End;
    // update res highlighter
    With Res Do
    Begin
        CommentAttri.Assign(cpp.CommentAttri);
        DirecAttri.Assign(cpp.DirecAttri);
        IdentifierAttri.Assign(cpp.IdentifierAttri);
        KeyAttri.Assign(cpp.KeyAttri);
        NumberAttri.Assign(cpp.NumberAttri);
        SpaceAttri.Assign(cpp.SpaceAttri);
        StringAttri.Assign(cpp.StringAttri);
        SymbolAttri.Assign(cpp.SymbolAttri);
    End;
    With Assembly Do
    Begin
        CommentAttri.Assign(cpp.CommentAttri);
        IdentifierAttri.Assign(cpp.IdentifierAttri);
        KeyAttri.Assign(cpp.KeyAttri);
        NumberAttri.Assign(cpp.NumberAttri);
        SpaceAttri.Assign(cpp.SpaceAttri);
        StringAttri.Assign(cpp.StringAttri);
        SymbolAttri.Assign(cpp.SymbolAttri);
    End;
End;

Function TdmMain.GetHighlighter(Const FileName: String): TSynCustomHighlighter;
Var
    ext: String;
    idx: Integer;
    tmp: TStrings;
{$IFDEF PLUGIN_BUILD}
    plugin_xml_ext: String;
    i: Integer;
    resultAssigned: Boolean;
{$ENDIF}
Begin

    {$IFDEF PLUGIN_BUILD}
       ResultAssigned := False;
    {$ENDIF}

    UpdateHighlighter;
    result := Nil;
    If devEditor.UseSyntax Then
    Begin
        If (FileName = '') Or (AnsiPos(Lang[ID_UNTITLED], FileName) = 1) Then
            result := CppMultiSyn
        Else
        Begin
            ext := ExtractFileExt(FileName);
            If AnsiCompareText(ext, RC_EXT) = 0 Then
                result := Res
            Else
            If (AnsiCompareText(ext, '.s') = 0) Or (AnsiCompareText(ext, '.asm') = 0) Then
                result := Assembly
{$IFDEF PLUGIN_BUILD}
            Else
            Begin
                resultAssigned := False;
                For i := 0 To MainForm.pluginsCount - 1 Do
                Begin
                    plugin_xml_ext := MainForm.plugins[i].GetXMLExtension();
                    // EAB TODO: Not elegant. Fix it.
                    If (AnsiCompareText(ext, plugin_xml_ext) = 0) Then
                    Begin
                        result := Xml;
                        resultAssigned := True;
                    End;
                End;
            End;
            If Not resultAssigned Then
{$ENDIF}
            Begin
                tmp := TStringList.Create;
                Try
                    delete(ext, 1, 1);
                    tmp.Delimiter := ';';
                    tmp.DelimitedText := devEditor.SyntaxExt;
                    If tmp.Count > 0 Then
                        For idx := 0 To pred(tmp.Count) Do
                            If AnsiCompareText(Ext, tmp[idx]) = 0 Then
                            Begin
                                result := CppMultiSyn;
                                Exit;
                            End;
                Finally
                    tmp.Free;
                End;
            End;
        End;
    End;
End;

Function TdmMain.GetNum: Integer;
Begin
    inc(fUnitCount);
    result := fUnitCount;
End;

Function TdmMain.GetNumber: Integer;
Begin
    inc(fProjectCount);
    result := fProjectCount;
End;

Procedure TdmMain.LoadDataMod;
Begin
    LoadHistory;
    LoadCodeIns;
    UpdateHighlighter;
End;


{ ---------- MRU ---------- }

Procedure TdmMain.AddtoHistory(s: String);
Var
    idx: Integer;
Begin
    If (s = '') Then
        exit;
    idx := fMRU.IndexofValue(s);
    If idx = -1 Then
    Begin
        // insert always first
        fMRU.Insert(0, Format('%d=%s', [fMRU.Count, s]));
        SHAddToRecentDocs(SHARD_PATH, Pchar(s));
        // EAB: Win7 MRU jumplist support.
    End;
    RebuildMRU;
End;

Procedure TdmMain.RemoveFromHistory(s: String);
Var
    idx: Integer;
Begin
    idx := fMRU.IndexofValue(s);
    If idx > -1 Then
        fMRU.Delete(idx);
    RebuildMRU;
End;

Procedure TdmMain.ClearHistory;
Begin
    fMRU.Clear;
    RebuildMRU;
End;

Function TdmMain.GetMRU(index: Integer): String;
Begin
    result := fMRU.Values[index];
End;

Procedure TdmMain.LoadHistory;
Var
    ini: TINIFile;
    idx: Integer;
Begin
    ClearHistory;
    ini := TiniFile.Create(devData.iniFile);
    With ini Do
        Try
            If Not SectionExists('History') Then
                exit;
            ReadSectionValues('History', fMRU);
            If fMRU.Count = 0 Then
                exit;
            For idx := pred(fMRU.Count) Downto 0 Do
                If Not FileExists(fMRU.Values[idx]) Then
                    fMRU.Delete(idx);
        Finally
            Free;
        End;
    RebuildMRU;
End;

Procedure TdmMain.SaveHistory;
Var
    ini: TINIFile;
    idx: Integer;
Begin
    If Not assigned(fMRU) Then
        exit;

    ini := TINIFile.Create(devData.INIFile);
    With ini Do
        Try
            EraseSection('History');
            If fMRU.Count = 0 Then
                exit;
            For idx := 0 To pred(fMRU.Count) Do
                WriteString('History', inttostr(idx), fMRU.Values[idx]);
        Finally
            Free;
        End;
End;

Procedure TdmMain.RebuildMRU;
// this function sorts the MRU by bringing the .dev files to the top of the list.
// It doesn't alter the order in other ways... The return value is the Index of
// the first non .dev file
    Function SortMRU: Integer;
    Var
        I, C: Integer;
        swp: String;
        Done: Boolean;
    Begin
        C := 0;
        Repeat
            Done := True;
            For I := 0 To fMRU.Count - 2 Do
                If (LowerCase(ExtractFileExt(fMRU[I])) <> '.dev') And
                    (LowerCase(ExtractFileExt(fMRU[I + 1])) = '.dev') Then
                Begin
                    swp := fMRU[I];
                    fMRU[I] := fMRU[I + 1];
                    fMRU[I + 1] := swp;
                    Done := False;
                End;
        Until Done;
        For I := 0 To fMRU.Count - 1 Do
            If LowerCase(ExtractFileExt(fMRU[I])) <> '.dev' Then
            Begin
                C := I;
                Break;
            End;
        Result := C;
    End;
Var
    Item: TMenuItem;
    NonDev: Integer;
    UpdMRU: ToysStringList;
    Stop, Counter, idx: Integer;
Begin
    If Not assigned(fMRUMenu) Then
        exit;
    For idx := pred(fMRUMenu.Count) Downto fMRUOffset Do
        fMRUMenu[idx].Free;

    // Initialize a new MRU... We'll be adding in this *only* the entries that are
    // going to fMRUMenu. After that, we 'll replace the fMRU with UpdMRU. That
    // way the MRU is always up to date and does not contain excess elements.
    UpdMRU := ToysStringList.Create;
    Counter := 0;

    // Build the .dev recent files entries (*.dev)
    // TODO: Make the number of project files configurable?
    NonDev := SortMRU;
    If NonDev > 4 Then
        Stop := 4
    Else
        Stop := NonDev;

    For idx := 0 To pred(Stop) Do
    Begin
        UpdMRU.Add(Format('%d=%s', [UpdMRU.Count, fMRU.Values[idx]]));
        Item := TMenuItem.Create(fMRUMenu);
        Item.Caption := format('&%1x %s', [Counter, fMRU.Values[idx]]);
        Item.OnClick := fMRUClick;
        Item.Tag := UpdMRU.Count - 1;
        fMRUMenu.Add(Item);
        Inc(Counter);
    End;

    If (fMRUMenu.Count - fMRUOffset) > 0 Then
        fMRUMenu.InsertNewLineAfter(fMRUMenu.Items[fMRUMenu.Count - 1]);

    // Now build the other recent files entries (*.cpp, *.h, etc)
    If (fMRU.Count - NonDev) > fMRUMax Then
        Stop := NonDev + fMRUMax
    Else
        Stop := fMRU.Count;

    For idx := NonDev To pred(Stop) Do
    Begin
        UpdMRU.Add(Format('%d=%s', [UpdMRU.Count, fMRU.Values[idx]]));
        Item := TMenuItem.Create(fMRUMenu);
        Item.Caption := format('&%1x %s', [Counter, fMRU.Values[idx]]);
        Item.OnClick := fMRUClick;
        Item.Tag := UpdMRU.Count - 1;
        fMRUMenu.Add(Item);
        Inc(Counter);
    End;
    fMRUMenu.Enabled := (fMRUMenu.Count - fMRUOffset) > 0;

    // update MRU
    fMRU.Assign(UpdMRU);
    UpdMRU.Free;

    // redraw the menu
    If Assigned(fMRUMenu) Then
        MainForm.XPMenu.InitComponent(fMRUMenu);
End;

{ ---------- Code Insert Methods ---------- }

Function TdmMain.InsertList: TStrings;
Var
    idx: Integer;
    list1: TStringList;
Begin
    list1 := TStringList.Create;
    Try
        For idx := 0 To pred(fCodeList.Count) Do
            list1.Append(fCodeList[idx].Caption);

        Result := list1;
    Finally
        list1.Free;
    End;
End;

// Loads code inserts, when sep value changes a separator is
// insert only if sep is a higher value then previous sep value.
Procedure TdmMain.LoadCodeIns;
Var
    cdx,
    idx: Integer;
    Item: TMenuItem;
Begin
    If Not assigned(fCodeMenu) Then
        exit;
    fCodeList.LoadCode;

    For idx := pred(fCodeMenu.Count) Downto fCodeOffset Do
        fCodeMenu[idx].Free;

    If assigned(fCodePop) Then
        fCodePop.Clear;

    cdx := 0;
    For idx := 0 To pred(fCodeList.Count) Do
    Begin
        Item := TMenuItem.Create(fCodeMenu);
        Item.Caption := fCodeList[idx]^.Caption;
        Item.OnClick := fCodeEvent;
        Item.Tag := idx;
        If fCodeList[idx]^.Sep <= cdx Then
            fCodeMenu.Add(Item)
        Else
        Begin
            cdx := fCodeList[idx]^.Sep;
            fCodeMenu.NewBottomLine;
            fCodeMenu.Add(Item);
        End;
    End;
    fCodeMenu.Visible := fCodeMenu.Count > 0;
    If assigned(fCodePop) Then
    Begin
        CloneMenu(fCodeMenu, fCodePop);
        MainForm.XPMenu.InitComponent(fCodePop);
    End;
End;

Procedure TdmMain.ExportToHtml(FileLines: TStrings; ExportFilename: String);
Begin
    If (Not Assigned(FileLines)) Or (FileLines.Count = 0) Or
        (ExportFilename = '') Then
        Exit;
    SynExporterHTML.Title := ExtractFileName(ExportFileName);
    SynExporterHTML.CreateHTMLFragment := False;
    SynExporterHTML.ExportAsText := True;
    SynExporterHTML.Color := Cpp.SpaceAttri.Background;
    SynExporterHTML.ExportAll(FileLines);
    SynExporterHTML.SavetoFile(ExportFileName);
End;

Procedure TdmMain.ExportToRtf(FileLines: TStrings; ExportFilename: String);
Begin
    If (Not Assigned(FileLines)) Or (FileLines.Count = 0) Or
        (ExportFilename = '') Then
        Exit;

    SynExporterRTF.ExportAll(FileLines);
    SynExporterRTF.SavetoFile(ExportFileName);
End;

End.
