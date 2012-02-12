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

Unit DevThemes;

Interface

Uses
{$IFDEF WIN32}
    Classes, Controls, oysUtils;
{$ENDIF}
{$IFDEF LINUX}
  Classes, QControls, oysUtils, QImgList;
{$ENDIF}

Type
    TdevTheme = Class(TObject)
    Private
        fThemes: ToysStringList;
        fFile: String;
        fName: String;
        fMenus: TImageList;
        fHelp: TImageList;
        fProjects: TImageList;
        fSpecials: TImageList;
        fBrowser: TImageList;
        fImgfiles: TOysStringList;
        Procedure ClearLists;
        Function GetImage(Const Index: Integer; Var imglst: TImageList): Boolean;
        Function GetPreview: String;
    Public
        Constructor Create;
        Destructor Destroy; Override;

        Procedure ScanThemes;
        Function ThemeList: TStrings;
        Function SetTheme(Const theme: String): Boolean;
        Function LoadTheme(Const FileName: String): Boolean;

        Property Name: String Read fName;
        Property Menus: TImageList Read fMenus;
        Property Help: TImageList Read fHelp;
        Property Projects: TImageList Read fProjects;
        Property Specials: TImageList Read fSpecials;
        Property Browser: TImageList Read fBrowser;
        Property Preview: String Read GetPreview;
    End;

Var
    devTheme: TdevTheme = Nil;

Implementation

Uses
{$IFDEF WIN32}
    SysUtils, Forms, Graphics, devcfg, utils, datamod, version;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, QForms, QGraphics, devcfg, utils, datamod, version;
{$ENDIF}


{ TdevTheme }

Constructor TdevTheme.Create;
Begin
    fThemes := ToysStringList.Create;
    fMenus := TImageList.Create(Nil);
    fHelp := TImageList.Create(Nil);
    fProjects := TImageList.Create(Nil);
    fSpecials := TImageList.Create(Nil);
    fBrowser := TImageList.Create(Nil);
    fMenus.Masked := True;
    fHelp.Masked := True;
    fProjects.Masked := True;
    fSpecials.Masked := True;
    fBrowser.Masked := True;

    ScanThemes;
End;

Destructor TdevTheme.Destroy;
Begin
    fMenus.Clear;
    fHelp.Clear;
    fProjects.Clear;
    fSpecials.Clear;
    fBrowser.Clear;

    fThemes.Free;
    fMenus.Free;
    fHelp.Free;
    fProjects.Free;
    fSpecials.Free;
    fBrowser.Free;
    Inherited;
End;

Procedure TdevTheme.ClearLists;
Begin
    fMenus.Clear;
    fHelp.Clear;
    fProjects.Clear;
    fSpecials.Clear;
    fBrowser.Clear;
End;

Function GetPreview: String;
Begin

End;

Function TdevTheme.GetImage(Const Index: Integer;
    Var imglst: TImageList): Boolean;
Var
    idx: Integer;
    aFile: String;
    img: TBitmap;
    clr: TColor;
Begin
    Try
        idx := fimgfiles.IndexofName(IntToStr(index));
        If idx <> -1 Then
            aFile := ExpandFileto(fimgFiles.Values[idx], ExtractFilePath(fFile))
        Else
            aFile := '';

        img := TBitmap.Create;
        Try
            If (aFile <> '') And (FileExists(aFile)) Then
                img.LoadFromFile(aFile)
            Else
                img.LoadFromResourceName(HInstance, 'NOIMG');

            clr := img.Canvas.Pixels[0, 15];
            imglst.AddMasked(img, clr);
        Finally
            img.Free;
        End;
        Result := True;
    Except
        Result := False;
    End;
End;

Function TdevTheme.SetTheme(Const theme: String): Boolean;
Var
    idx: Integer;
Begin
    Result := False;
    If theme = fName Then
        Exit;

    If (theme = DEV_GNOME_THEME) Or
        (theme = DEV_NEWLOOK_THEME) Or
        (theme = DEV_BLUE_THEME) Then
    Begin
        If theme = DEV_NEWLOOK_THEME Then
        Begin
            fMenus.Clear;
            fHelp.Clear;
            fProjects.Clear;
            fSpecials.Clear;
            fBrowser.Clear;
            fMenus.AddImages(dmMain.MenuImages_NewLook);
            fHelp.AddImages(dmMain.HelpImages_NewLook);
            fProjects.AddImages(dmMain.ProjectImage_NewLook);
            fSpecials.AddImages(dmMain.SpecialImages_NewLook);
            fBrowser.AddImages(dmMain.ClassImages);
            result := True;
            fFile := DEV_INTERNAL_THEME;
        End
        Else
        If theme = DEV_GNOME_THEME Then
        Begin
            fMenus.Clear;
            fHelp.Clear;
            fProjects.Clear;
            fSpecials.Clear;
            fBrowser.Clear;
            fMenus.AddImages(dmMain.MenuImages_Gnome);
            fHelp.AddImages(dmMain.HelpImages_Gnome);
            fProjects.AddImages(dmMain.ProjectImage_Gnome);
            fSpecials.AddImages(dmMain.SpecialImages_Gnome);
            fBrowser.AddImages(dmMain.ClassImages);
            result := True;
            fFile := DEV_INTERNAL_THEME;
        End
        Else
        If theme = DEV_BLUE_THEME Then
        Begin
            fMenus.Clear;
            fHelp.Clear;
            fProjects.Clear;
            fSpecials.Clear;
            fBrowser.Clear;
            fMenus.AddImages(dmMain.MenuImages_Blue);
            fHelp.AddImages(dmMain.HelpImages_Blue);
            fProjects.AddImages(dmMain.ProjectImage_Blue);
            fSpecials.AddImages(dmMain.SpecialImages_Blue);
            fBrowser.AddImages(dmMain.ClassImages);
            result := True;
            fFile := DEV_INTERNAL_THEME;
        End
	       Else
        If theme = DEV_CLASSIC_THEME Then
        Begin
            fMenus.Clear;
            fHelp.Clear;
            fProjects.Clear;
            fSpecials.Clear;
            fBrowser.Clear;
            fMenus.AddImages(dmMain.MenuImages_Classic);
            fHelp.AddImages(dmMain.HelpImages_Classic);
            fProjects.AddImages(dmMain.ProjectImage_Classic);
            fSpecials.AddImages(dmMain.SpecialImages_Classic);
            fBrowser.AddImages(dmMain.ClassImages);
            result := True;
            fFile := DEV_INTERNAL_THEME;
        End;
    End
    Else
    Begin // load theme from file
        idx := fThemes.IndexofValue(Theme);
        If idx <> -1 Then
            Result := LoadTheme(fThemes.Names[idx])
        Else
            Result := False;
    End;
End;

Function TdevTheme.LoadTheme(Const FileName: String): Boolean;
Const
    MNU_CNT = 47;
    MNU_OFF = 1000;
    HLP_CNT = 7;
    HLP_OFF = 1100;
    PRJ_CNT = 4;
    PRJ_OFF = 1200;
    SPL_CNT = 4;
    SPL_OFF = 1300;
    BRW_CNT = 8;
    BRW_OFF = 1400;
Var
    idx: Integer;
    fName: String;
Begin
    //  Open file and load images into lists
    //  if image isn't found load "NOIMG" bitmap from resources
    Result := False;
    fName := ValidateFile(FileName, devDirs.Themes);
    If fName = '' Then
    Begin
        //     MessageDlg('Could not open Theme File ', +FileName, mtErrorm [mbOk], 0);
        Exit;
    End;

    fFile := fName;
    ClearLists;
    fimgFiles := ToysStringList.Create;
    With fimgfiles Do
        Try
            LoadFromFile(FName);

            fName := Value['Name'];
            // fill menu
            For idx := 0 To pred(MNU_CNT) Do
                GetImage(idx + MNU_OFF, fMenus);

            Application.ProcessMessages;
            // fill Help
            For idx := 0 To pred(HLP_CNT) Do
                GetImage(idx + HLP_OFF, fHelp);

            Application.ProcessMessages;
            // fill Projects
            For idx := 0 To pred(PRJ_CNT) Do
                GetImage(idx + PRJ_OFF, fProjects);

            Application.ProcessMessages;
            // fill Specials
            For idx := 0 To pred(SPL_CNT) Do
                GetImage(idx + SPL_OFF, fSpecials);

            Application.ProcessMessages;
            // fill Browser
            For idx := 0 To pred(BRW_CNT) Do
                GetImage(idx + BRW_OFF, fBrowser);
        Finally
            Free;
        End;
    Result := True;
End;

Function TdevTheme.ThemeList: TStrings;
Var
    idx: Integer;
Begin
    Result := TStringList.Create;
    For idx := 0 To pred(fthemes.Count) Do
        Result.Add(fThemes.Values[idx]);
End;

Procedure TdevTheme.ScanThemes;
Var
    tmp: TStringList;
    idx: Integer;
Begin
    fThemes.Clear;
    fThemes.Append(DEV_NEWLOOK_THEME + '=' + DEV_NEWLOOK_THEME);
    fThemes.Append(DEV_GNOME_THEME + '=' + DEV_GNOME_THEME);
    fThemes.Append(DEV_BLUE_THEME + '=' + DEV_BLUE_THEME);
    fThemes.Append(DEV_CLASSIC_THEME + '=' + DEV_CLASSIC_THEME);

    If devDirs.Themes = '' Then
        Exit;

    FilesFromWildCard(devDirs.Themes, '*.thm',
        TStringList(fThemes), True, False, True);

    If fThemes.Count > 2 Then
    Begin
        tmp := TStringList.Create;
        Try
            For idx := 4 To pred(fThemes.Count) Do
                // start from 3 because we have three standard themes
            Begin
                tmp.Clear;
                tmp.LoadFromfile(fThemes[idx]);
                If tmp.Values['Name'] = '' Then
                    fThemes[idx] := Format('%s=%s', [fThemes[idx],
                        ChangefileExt(ExtractFileName(fThemes[idx]), '')])
                Else
                    fThemes[idx] := Format('%s=%s', [fThemes[idx], tmp.Values['Name']]);
            End;
        Finally
            tmp.Free;
        End;
    End;
End;

Function TdevTheme.GetPreview: String;
Begin
    //
End;

Initialization

Finalization
    devTheme.Free;

End.
