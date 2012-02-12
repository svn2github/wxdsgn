Unit uVista;

// *** Need to use XPTheme.
// In your project's .dpr file, add XPTheme to the top of the "uses" list.
// If you have TXPManifest, you can use that instead, since it does the
// same job.
//
// This is a compilation of code-fragments I have found on the net.
// Kevin Solway.
// http://www.theabsolute.net/sware/taskdialog/
// Last modified: 11th Feb, 2008


Interface

Uses Forms, Windows, Graphics, CommDlg, controls, dialogs, Classes;

Type
    pboolean = ^Boolean;
    TTASKDIALOG_BUTTON =
        Packed Record
        nButtonId: Integer;
        pszButtonText: PWideChar;
    End;
    TTASKDIALOG_BUTTONS = Array Of TTASKDIALOG_BUTTON;


Function isElevatedUAC: Boolean;
Function IsWindowsVista: Boolean;
Procedure SetVistaFonts(Const AForm: TCustomForm);
Procedure SetVistaContentFonts(Const AFont: TFont);
Procedure SetDesktopIconFonts(Const AFont: TFont);
Procedure ExtendGlass(Const AHandle: THandle; Const AMargins: TRect);
Function CompositingEnabled: Boolean;
Function TaskDialog(Const AHandle: THandle; Const ATitle, ADescription,
    AContent: String; Const Icon, Buttons: Integer): Integer;
Procedure TaskMessage(Const AHandle: THandle; AMessage: String);
Procedure SetVistaTreeView(Const AHandle: THandle);



Function OpenSaveFileDialog(Parent: TWinControl;
    Const DefExt,
    Filter,
    InitialDir,
    Title: String;
    Var FileName: String;
    Var Files: TStrings;
    FilterIndex: Integer;
    ReadOnly,
    OverwritePrompt,
    HideReadOnly,
    NoChangeDir,
    ShowHelp,
    NoValidate,
    AllowMultiSelect,
    ExtensionDifferent,
    PathMustExist,
    FileMustExist,
    CreatePrompt,
    ShareAware,
    NoReadOnlyReturn,
    NoTestFileCreate,
    NoNetworkButton,
    NoLongNames,
    OldStyleDialog,
    NoDereferenceLinks,
    EnableIncludeNotify,
    EnableSizing,
    DontAddToRecent,
    DoOpen: Boolean): Boolean;


Const
    VistaFont = 'Segoe UI';
    VistaContentFont = 'Calibri';
    XPContentFont = 'Verdana';
    XPFont = 'Tahoma';

    TD_ICON_BLANK = 0;
    TD_ICON_WARNING = 84;
    TD_ICON_QUESTION = 99;
    TD_ICON_ERROR = 98;
    TD_ICON_INFORMATION = 81;
    TD_ICON_SHIELD_QUESTION = 104;
    TD_ICON_SHIELD_ERROR = 105;
    TD_ICON_SHIELD_OK = 106;
    TD_ICON_SHIELD_WARNING = 107;

    TD_BUTTON_OK = 1;
    TD_BUTTON_YES = 2;
    TD_BUTTON_NO = 4;
    TD_BUTTON_CANCEL = 8;
    TD_BUTTON_RETRY = 16;
    TD_BUTTON_CLOSE = 32;

    TD_RESULT_OK = 1;
    TD_RESULT_CANCEL = 2;
    TD_RESULT_RETRY = 4;
    TD_RESULT_YES = 6;
    TD_RESULT_NO = 7;
    TD_RESULT_CLOSE = 8;

    TD_IDS_WINDOWTITLE = 10;
    TD_IDS_CONTENT = 11;
    TD_IDS_MAININSTRUCTION = 12;
    TD_IDS_VERIFICATIONTEXT = 13;
    TD_IDS_FOOTER = 15;
    TD_IDS_RB_GOOD = 16;
    TD_IDS_RB_OK = 17;
    TD_IDS_RB_BAD = 18;
    TD_IDS_CB_SAVE = 19;


Var
    CheckOSVerForFonts: Boolean = True;

Implementation

Uses SysUtils, UxTheme;

Function sametext(x, y: String): Boolean;
// not case sensitive
Begin
 //if SameText(x,y) then... with ...if CompareText(x,y)=0 then
    result := comparetext(x, y) = 0;
End;


Procedure SetVistaTreeView(Const AHandle: THandle);
// handle must be a handle of a treeview component eg, TreeView.Handle
Begin
    If IsWindowsVista Then
        SetWindowTheme(AHandle, 'explorer', Nil);
End;

Procedure SetVistaFonts(Const AForm: TCustomForm);
Begin
    If (IsWindowsVista Or Not CheckOSVerForFonts)
        And Not SameText(AForm.Font.Name, VistaFont)
        And (Screen.Fonts.IndexOf(VistaFont) >= 0) Then
    Begin
        AForm.Font.Size := AForm.Font.Size + 1;
        AForm.Font.Name := VistaFont;
    End;
End;

Procedure SetVistaContentFonts(Const AFont: TFont);
// parameter must be something like,  memo.font
// for memos, richedits, etc
Begin
    If (IsWindowsVista Or Not CheckOSVerForFonts)
        And Not SameText(AFont.Name, VistaContentFont)
        And (Screen.Fonts.IndexOf(VistaContentFont) >= 0) Then
    Begin
        AFont.Size := AFont.Size + 2;
        AFont.Name := VistaContentFont;
    End;
End;

Procedure SetDefaultFonts(Const AFont: TFont);
Begin
    AFont.Handle := GetStockObject(DEFAULT_GUI_FONT);
End;

Procedure SetDesktopIconFonts(Const AFont: TFont);
// set default font to be the same as the desktop icons font
// otherwise, uses default windows font
Var
    LogFont: TLogFont;
Begin
    If SystemParametersInfo(SPI_GETICONTITLELOGFONT, SizeOf(LogFont),
        @LogFont, 0) Then
        AFont.Handle := CreateFontIndirect(LogFont)
    Else
        SetDefaultFonts(AFont);
End;

Function IsWindowsVista: Boolean;
Var
    VerInfo: TOSVersioninfo;
Begin
    VerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
    GetVersionEx(VerInfo);
    Result := VerInfo.dwMajorVersion >= 6;
  //Result := false;
End;

Const
    dwmapi = 'dwmapi.dll';
    DwmIsCompositionEnabledSig = 'DwmIsCompositionEnabled';
    DwmExtendFrameIntoClientAreaSig = 'DwmExtendFrameIntoClientArea';
    TaskDialogSig = 'TaskDialog';

Function CompositingEnabled: Boolean;
Var
    DLLHandle: THandle;
    DwmIsCompositionEnabledProc: Function(pfEnabled: PBoolean): HRESULT; Stdcall;
    Enabled: Boolean;
Begin
    Result := False;
    If IsWindowsVista Then
    Begin
        DLLHandle := LoadLibrary(dwmapi);

        If DLLHandle <> 0 Then
        Begin
            @DwmIsCompositionEnabledProc := GetProcAddress(DLLHandle,
                DwmIsCompositionEnabledSig);

            If (@DwmIsCompositionEnabledProc <> Nil) Then
            Begin
                DwmIsCompositionEnabledProc(@Enabled);
                Result := Enabled;
            End;

            FreeLibrary(DLLHandle);
        End;
    End;
End;

//from http://www.delphipraxis.net/topic93221,next.html
Procedure ExtendGlass(Const AHandle: THandle; Const AMargins: TRect);
Type
    _MARGINS = Packed Record
        cxLeftWidth: Integer;
        cxRightWidth: Integer;
        cyTopHeight: Integer;
        cyBottomHeight: Integer;
    End;
    PMargins = ^_MARGINS;
    TMargins = _MARGINS;
Var
    DLLHandle: THandle;
    DwmExtendFrameIntoClientAreaProc: Function(destWnd: HWND; Const pMarInset:
        PMargins): HRESULT; Stdcall;
    Margins: TMargins;
Begin
    If IsWindowsVista And CompositingEnabled Then
    Begin
        DLLHandle := LoadLibrary(dwmapi);

        If DLLHandle <> 0 Then
        Begin
            @DwmExtendFrameIntoClientAreaProc := GetProcAddress(DLLHandle,
                DwmExtendFrameIntoClientAreaSig);

            If (@DwmExtendFrameIntoClientAreaProc <> Nil) Then
            Begin
                ZeroMemory(@Margins, SizeOf(Margins));
                Margins.cxLeftWidth := AMargins.Left;
                Margins.cxRightWidth := AMargins.Right;
                Margins.cyTopHeight := AMargins.Top;
                Margins.cyBottomHeight := AMargins.Bottom;

                DwmExtendFrameIntoClientAreaProc(AHandle, @Margins);
            End;

            FreeLibrary(DLLHandle);
        End;
    End;
End;


//from http://www.tmssoftware.com/atbdev5.htm
Function TaskDialog(Const AHandle: THandle; Const ATitle, ADescription,
    AContent: String; Const Icon, Buttons: Integer): Integer;
Label normal;
Var
    DLLHandle: THandle;
    res: Integer;
    assignprob: Boolean;
    S, Dmy: String;
    wTitle, wDescription, wContent: Array[0..1024] Of Widechar;
    Btns: TMsgDlgButtons;
    DlgType: TMsgDlgType;
    TaskDialogProc: Function(HWND: THandle; hInstance: THandle; cTitle,
        cDescription, cContent: pwidechar; Buttons: Integer; Icon: Integer;
        ResButton: pinteger): Integer; Cdecl Stdcall;
Begin
    Result := 0;
    assignprob := False;
    If IsWindowsVista Then
    Begin
        DLLHandle := LoadLibrary(comctl32);
        If DLLHandle >= 32 Then
        Begin
            @TaskDialogProc := GetProcAddress(DLLHandle, TaskDialogSig);

      // mbb(assigned(taskdialogproc));

            If Assigned(TaskDialogProc) Then
            Begin
                StringToWideChar(ATitle, wTitle, SizeOf(wTitle));
                StringToWideChar(ADescription, wDescription, SizeOf(wDescription));

        //Get rid of line breaks, may be here for backwards compat but not
        //needed with Task Dialogs
                S := StringReplace(AContent, #10, '', [rfReplaceAll]);
                S := StringReplace(S, #13, '', [rfReplaceAll]);
                StringToWideChar(S, wContent, SizeOf(wContent));

                TaskDialogProc(AHandle, 0, wTitle, wDescription, wContent, Buttons,
                    Icon, @res);

                Result := mrOK;

                Case res Of
                    TD_RESULT_CANCEL:
                        Result := mrCancel;
                    TD_RESULT_RETRY:
                        Result := mrRetry;
                    TD_RESULT_YES:
                        Result := mrYes;
                    TD_RESULT_NO:
                        Result := mrNo;
                    TD_RESULT_CLOSE:
                        Result := mrAbort;
                End;
            End
            Else assignprob := True;
            FreeLibrary(DLLHandle);
     // mySysError;
            If assignprob Then
                Goto normal;
        End;
    End
    Else
    Begin
        normal:
            Btns := [];
        If Buttons And TD_BUTTON_OK = TD_BUTTON_OK Then
            Btns := Btns + [MBOK];

        If Buttons And TD_BUTTON_YES = TD_BUTTON_YES Then
            Btns := Btns + [MBYES];

        If Buttons And TD_BUTTON_NO = TD_BUTTON_NO Then
            Btns := Btns + [MBNO];

        If Buttons And TD_BUTTON_CANCEL = TD_BUTTON_CANCEL Then
            Btns := Btns + [MBCANCEL];

        If Buttons And TD_BUTTON_RETRY = TD_BUTTON_RETRY Then
            Btns := Btns + [MBRETRY];

        If Buttons And TD_BUTTON_CLOSE = TD_BUTTON_CLOSE Then
            Btns := Btns + [MBABORT];

        DlgType := mtCustom;

        Case Icon Of
            TD_ICON_WARNING:
                DlgType := mtWarning;
            TD_ICON_QUESTION:
                DlgType := mtConfirmation;
            TD_ICON_ERROR:
                DlgType := mtError;
            TD_ICON_INFORMATION:
                DlgType := mtInformation;
        End;

        Dmy := ADescription;
        If AContent <> '' Then
        Begin
            If Dmy <> '' Then
                Dmy := Dmy + #$D#$A + #$D#$A;
            Dmy := Dmy + AContent;
        End;
        result := MessageDlg(Dmy, DlgType, Btns, 0);
    End;
End;


Procedure TaskMessage(Const AHandle: THandle; AMessage: String);
Begin
    TaskDialog(AHandle, '', '', AMessage, TD_BUTTON_OK, 0);
End;


Function ReplaceStr(Str, SearchStr, ReplaceStr: String): String;
Begin
    While Pos(SearchStr, Str) <> 0 Do
    Begin
        Insert(ReplaceStr, Str, Pos(SearchStr, Str));
        system.Delete(Str, Pos(SearchStr, Str), Length(SearchStr));
    End;
    Result := Str;
End;



Function OpenSaveFileDialog(Parent: TWinControl;   // EAB Improved to work better with TOpenDialog and TSaveDialog
    Const DefExt,
    Filter,
    InitialDir,
    Title: String;
    Var FileName: String;
    Var Files: TStrings;
    FilterIndex: Integer;
    ReadOnly,
    OverwritePrompt,
    HideReadOnly,
    NoChangeDir,
    ShowHelp,
    NoValidate,
    AllowMultiSelect,
    ExtensionDifferent,
    PathMustExist,
    FileMustExist,
    CreatePrompt,
    ShareAware,
    NoReadOnlyReturn,
    NoTestFileCreate,
    NoNetworkButton,
    NoLongNames,
    OldStyleDialog,
    NoDereferenceLinks,
    EnableIncludeNotify,
    EnableSizing,
    DontAddToRecent,
    DoOpen: Boolean): Boolean;
// uses commdlg
Var
    ofn: TOpenFileName;
    szFile: Array[0..MAX_PATH] Of Char;
    temp, dir: String;
    idx: Integer;
Begin
    Result := False;
    temp := '';
    idx := 0;
    Files.Clear;
    FillChar(ofn, SizeOf(TOpenFileName), 0);
    With ofn Do
    Begin
        lStructSize := SizeOf(TOpenFileName);
        hwndOwner := Parent.Handle;
        lpstrFile := szFile;
        nMaxFile := SizeOf(szFile);
        If (Title <> '') Then
            lpstrTitle := Pchar(Title);
        If (InitialDir <> '') Then
            lpstrInitialDir := Pchar(InitialDir);
        StrPCopy(lpstrFile, FileName);
        lpstrFilter := Pchar(ReplaceStr(Filter, '|', #0) + #0#0);
        If DefExt <> '' Then
            lpstrDefExt := Pchar(DefExt);
        nFilterIndex := FilterIndex;
    End;

    If ReadOnly Then
        ofn.Flags := ofn.Flags Or OFN_READONLY;
    If OverwritePrompt Then
        ofn.Flags := ofn.Flags Or OFN_OVERWRITEPROMPT;
    If HideReadOnly Then
        ofn.Flags := ofn.Flags Or OFN_HIDEREADONLY;
    If NoChangeDir Then
        ofn.Flags := ofn.Flags Or OFN_NOCHANGEDIR;
    If ShowHelp Then
        ofn.Flags := ofn.Flags Or OFN_SHOWHELP;
    If NoValidate Then
        ofn.Flags := ofn.Flags Or OFN_NOVALIDATE;
    If AllowMultiSelect Then
        ofn.Flags := ofn.Flags Or OFN_ALLOWMULTISELECT;
    If ExtensionDifferent Then
        ofn.Flags := ofn.Flags Or OFN_EXTENSIONDIFFERENT;
    If PathMustExist Then
        ofn.Flags := ofn.Flags Or OFN_PATHMUSTEXIST;
    If FileMustExist Then
        ofn.Flags := ofn.Flags Or OFN_FILEMUSTEXIST;
    If CreatePrompt Then
        ofn.Flags := ofn.Flags Or OFN_CREATEPROMPT;
    If ShareAware Then
        ofn.Flags := ofn.Flags Or OFN_SHAREAWARE;
    If NoReadOnlyReturn Then
        ofn.Flags := ofn.Flags Or OFN_NOREADONLYRETURN;
    If NoTestFileCreate Then
        ofn.Flags := ofn.Flags Or OFN_NOTESTFILECREATE;
    If NoNetworkButton Then
        ofn.Flags := ofn.Flags Or OFN_NONETWORKBUTTON;
    If NoLongNames Then
        ofn.Flags := ofn.Flags Or OFN_NOLONGNAMES;
  //if OldStyleDialog then ofn.Flags := ofn.Flags or OFN_OLDSTYLEDIALOG;
    If NoDereferenceLinks Then
        ofn.Flags := ofn.Flags Or OFN_NODEREFERENCELINKS;
    If EnableIncludeNotify Then
        ofn.Flags := ofn.Flags Or OFN_ENABLEINCLUDENOTIFY;
    If EnableSizing Then
        ofn.Flags := ofn.Flags Or OFN_ENABLESIZING;
    If DontAddToRecent Then
        ofn.Flags := ofn.Flags Or OFN_DONTADDTORECENT;
  //if ShowHidden then ofn.Flags := ofn.Flags or OFN_ShowHidden;

    If DoOpen Then
    Begin
        ofn.Flags := ofn.Flags Or OFN_ALLOWMULTISELECT;
        ofn.Flags := ofn.Flags Or OFN_EXPLORER;
        If GetOpenFileName(ofn) Then
        Begin
            Result := True;
            FileName := StrPas(szFile);

      // EAB Multi-file support
            While idx < MAX_PATH Do
            Begin
                While szFile[idx] <> #0 Do
                Begin
                    temp := temp + szFile[idx];
                    Inc(idx);
                End;
                If (Files.Count = 0) And (dir = '') Then
                    dir := temp
                Else
                    Files.Add(dir + '\' + temp);
                temp := '';
                Inc(idx);
                If szFile[idx] = #0 Then
                Begin
                    If (Files.Count = 0) And (dir <> '') Then
                        Files.Add(dir);
                    Exit;
                End;
            End;

        End;
    End
    Else
    Begin
        If GetSaveFileName(ofn) Then
        Begin
            Result := True;
            FileName := StrPas(szFile);
        End;
    End;
End; // function OpenSaveFileDialog



{
MsgDLgTypes:

mtWarning	A message box containing a yellow exclamation point symbol.
mtError	A message box containing a red stop sign.
mtInformation	A message box containing a blue "i".
mtConfirmation	A message box containing a green question mark.
mtCustom	A message box containing no bitmap. The caption of the message box is the name of the application's executable file.

MsgDlgBUttons:

mbYes	A button with 'Yes' on its face.
mbNo	A button the text 'No' on its face.
mbOK	A button the text 'OK' on its face.
mbCancel	A button with the text 'Cancel' on its face.
mbHelp	A button with the text 'Help' on its face
mbAbort	A button with the text 'Abort' on its face
mbRetry	A button with the text 'Retry' on its face
mbIgnore	A button with the text 'Ignore' on its face
mbAll	A button with the text 'All' on its face
}


// Detects whether we are running wxDev-C++ with elevated admin
//  permissions on UAC (Windows >= Vista)
Function isElevatedUAC: Boolean;
Const
    TokenElevationType = 18;
    TokenElevation = 20;
    TokenElevationTypeDefault = 1;
    TokenElevationTypeFull = 2;
    TokenElevationTypeLimited = 3;

Var token: Cardinal;
    ElevationType: Integer;
    Elevation: DWord;
    dwSize: Cardinal;
    elevateResult: Boolean;

Begin
    ElevateResult := True;

  //If we are on versions prior to Windows Vista, then no UAC
  //  to worry about.
    If Not (IsWindowsVista) Then
    Begin
        Result := True;
        Exit;
    End;

    If OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, token) Then
        Try
            If GetTokenInformation(token, TTokenInformationClass(TokenElevationType), @ElevationType, SizeOf(ElevationType), dwSize) Then
                Case ElevationType Of
                    TokenElevationTypeDefault:
                        ElevateResult := False;
        //  TokenElevationTypeFull:
                    TokenElevationTypeLimited:
                        ElevateResult := False;
        //else
         // ShowMessage('elevation type unknown');
                End
            Else
                ShowMessage(SysErrorMessage(GetLastError));
            If GetTokenInformation(token, TTokenInformationClass(TokenElevation), @Elevation, SizeOf(Elevation), dwSize) Then
            Begin
                If Elevation = 0 Then
                    ElevateResult := False;
       // else
       //   ShowMessage('token has elevate privs');
            End
            Else
                ShowMessage(SysErrorMessage(GetLastError));
        Finally
            CloseHandle(token);
        End
    Else
        ShowMessage(SysErrorMessage(GetLastError));

    Result := ElevateResult;

End;


End.
