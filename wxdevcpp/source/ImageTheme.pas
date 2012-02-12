{----------------------------------------------------------------------------------

  The contents of this file are subject to the GNU General Public License
  Version 1.1 or later (the "License"); you may not use this file except in
  compliance with the License. You may obtain a copy of the License at
  http://www.gnu.org/copyleft/gpl.html

  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
  the specific language governing rights and limitations under the License.

  The Initial Developer of the Original Code is Peter Schraut.
  http://www.console-dev.de

  Portions created by Peter Schraut are Copyright
  (C) 2004 by Peter Schraut (http://www.console-dev.de)
  All Rights Reserved.


  History:
    11th April 2004 - Initial release


  Known bugs:

----------------------------------------------------------------------------------}

Unit ImageTheme;

Interface
Uses
{$IFDEF WIN32}
    Windows, SysUtils, Classes, Controls, Graphics, Contnrs;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QControls, QGraphics, Contnrs, QImgList;
{$ENDIF}

Type
    TCustomImageTheme = Class;
    TCustomDevImageTheme = Class;
    TImageThemeClass = Class Of TCustomImageTheme;


    TCustomImageTheme = Class(TPersistent)
    Private
        FBitmap: TBitmap;
        FFilename: String;
        FOnChange: TNotifyEvent;
        FTitle: String;
        Procedure SetBitmap(Const Bmp: TBitmap);
        Procedure OnChangeEvent(Sender: TObject);
    Protected
        Procedure Changed; Virtual;
        Property Bitmap: TBitmap Read FBitmap Write SetBitmap;
        Property Filename: String Read FFilename;
        Property Title: String Read FTitle;
        Property OnChange: TNotifyEvent Read FOnChange Write FOnChange;
    Public
        Constructor Create; Virtual;
        Destructor Destroy; Override;
        Procedure LoadFromFile(AFilename: String); Virtual;
        Procedure SaveToFile(AFilename: String); Virtual; Abstract;
    End;

    TImageTheme = Class(TCustomImageTheme)
    Public
        Property Filename;
        Property Title;
    End;

    TCustomDevImageTheme = Class(TImageTheme)
    Private
        FMenuImages,
        FHelpImages,
        FProjectImages,
        FSpecialImages,
        FBrowserImages: TImageList;
        Procedure SetMenuImages(Const Img: TImageList);
        Procedure SetHelpImages(Const Img: TImageList);
        Procedure SetProjectImages(Const Img: TImageList);
        Procedure SetSpecialImages(Const Img: TImageList);
        Procedure SetBrowserImages(Const Img: TImageList);
    Protected
        Property MenuImages: TImageList Read FMenuImages Write SetMenuImages;
        Property HelpImages: TImageList Read FHelpImages Write SetHelpImages;
        Property ProjectImages: TImageList
            Read FProjectImages Write SetProjectImages;
        Property SpecialImages: TImageList
            Read FSpecialImages Write SetSpecialImages;
        Property BrowserImages: TImageList
            Read FBrowserImages Write SetBrowserImages;
    Public
        Constructor Create; Override;
        Destructor Destroy; Override;
        Procedure LoadFromFile(AFilename: String); Override;
        Procedure SaveToFile(AFilename: String); Override;
    End;


    TDevImageTheme = Class(TCustomDevImageTheme)
    Public
        Property MenuImages;
        Property HelpImages;
        Property ProjectImages;
        Property SpecialImages;
        Property BrowserImages;
    End;


    TGnomeImageTheme = Class(TDevImageTheme)
    Public
        Constructor Create; Override;
    End;


    TNewLookImageTheme = Class(TDevImageTheme)
    Public
        Constructor Create; Override;
    End;


    TBlueImageTheme = Class(TDevImageTheme)
    Public
        Constructor Create; Override;
    End;

    TClassicImageTheme = Class(TDevImageTheme)
    Public
        Constructor Create; Override;
    End;

    TCustomImageThemeFactory = Class(TPersistent)
    Private
        FCurrentTheme: TCustomImageTheme;
        FThemes: TObjectList;
        Function GetTheme(Index: Integer): TCustomImageTheme;
        Function GetThemeFilename(Index: Integer): String;
        Function GetThemeTitle(Index: Integer): String;
        Procedure SetCurrentTheme(Const ATheme: TCustomImageTheme);
    Protected
        Procedure DoCreateThemeFromFile(AFilename: String); Virtual;
        Property CurrentTheme: TCustomImageTheme
            Read FCurrentTheme Write SetCurrentTheme;
        Property Themes[Index: Integer]: TCustomImageTheme Read GetTheme;
        Property ThemeFilename[Index: Integer]: String Read GetThemeFilename;
        Property ThemeTitle[Index: Integer]: String Read GetThemeTitle;
    Public
        Constructor Create; Virtual;
        Destructor Destroy; Override;
        Function ActivateTheme(ATheme: TCustomImageTheme): Boolean; Overload;
        Function ActivateTheme(AThemeTitle: String): Boolean; Overload;
        Procedure AddTheme(Const ATheme: TCustomImageTheme);
        Function Count: Integer;
        Function IndexOf(Const AThemeTitle: String): Integer;
        Procedure GetThemeTitles(ADest: TStrings);
        Procedure LoadFromDirectory(ADirectory: String);
        Procedure RegisterTheme(Const ThemeClass: TImageThemeClass);
    End;


    TDevImageThemeChanged = Procedure(Sender: TObject;
        Const OldTheme: TCustomDevImageTheme; Const NewTheme: TCustomDevImageTheme);

    TDevImageThemeFactory = Class(TCustomImageThemeFactory)
    Private
        FOnThemeChanged: TDevImageThemeChanged;
        Function GetTheme(Index: Integer): TDevImageTheme;
        Function GetCurrentTheme: TDevImageTheme;
        Procedure SetCurrentTheme(Const ATheme: TDevImageTheme);
    Protected
        Procedure DoCreateThemeFromFile(AFilename: String); Override;
    Public
        Constructor Create; Override;
        Property CurrentTheme: TDevImageTheme
            Read GetCurrentTheme Write SetCurrentTheme;
        Property Themes[Index: Integer]: TDevImageTheme Read GetTheme;
        Property ThemeFilename;
        Property ThemeTitle;
        Property OnThemeChanged: TDevImageThemeChanged
            Read FOnThemeChanged Write FOnThemeChanged;
    End;

Var
    devImageThemes: TDevImageThemeFactory;

Implementation
Uses
    DataMod;

// local helper only

Function DataModule: TdmMain;
Begin
    Assert(Assigned(DataMod.dmMain), 'DataMod.dmMain must not be nil');

    Result := DataMod.dmMain; // there are the imagelists for the default themes
End;

//----------------- TCustomImageTheme ----------------------------------------------------------------------------------

Constructor TCustomImageTheme.Create;
Begin
    Inherited;

    FBitmap := TBitmap.Create;
    FBitmap.OnChange := OnChangeEvent;
    FFilename := '';
    FTitle := '';
End;

//----------------------------------------------------------------------------------------------------------------------

Destructor TCustomImageTheme.Destroy;
Begin
    FBitmap.Free;

    Inherited;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomImageTheme.OnChangeEvent(Sender: TObject);
Begin
    Changed;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomImageTheme.Changed;
Begin
    If Assigned(FOnChange) Then
        FOnChange(Self);
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomImageTheme.LoadFromFile(AFilename: String);
Begin
    FFilename := AFilename;
    FBitmap.LoadFromFile(AFilename);
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomImageTheme.SetBitmap(Const Bmp: TBitmap);
Begin
    FBitmap.Assign(Bmp);
End;

//----------------- TCustomDevImageTheme -------------------------------------------------------------------------------

Constructor TCustomDevImageTheme.Create;
    Function _CreateImageList: TImageList;
    Begin
        Result := TImageList.Create(Nil);
        //Result.OnChange := OnChangeEvent;
        Result.Masked := True;
    End;
Begin
    Inherited;

    FMenuImages := _CreateImageList;
    FHelpImages := _CreateImageList;
    FProjectImages := _CreateImageList;
    FSpecialImages := _CreateImageList;
    FBrowserImages := _CreateImageList;
End;

//----------------------------------------------------------------------------------------------------------------------

Destructor TCustomDevImageTheme.Destroy;
Begin
    FMenuImages.Free;
    FHelpImages.Free;
    FProjectImages.Free;
    FSpecialImages.Free;
    FBrowserImages.Free;

    Inherited;
End;

//----------------------------------------------------------------------------------------------------------------------

Const
    cTileW = 16;
    cTileH = 16;

Procedure TCustomDevImageTheme.LoadFromFile(AFilename: String);
Var
    Bmp: TBitmap;

    Procedure LoadImageLine(ALine: Integer);
    Begin
        Bmp.FreeImage;
        Bmp.PixelFormat := pf24bit;
        Bmp.Width := Bitmap.Width;
        Bmp.Height := Bitmap.Height;

        If (ALine * cTileH + cTileH) <= Bitmap.Height Then
            Bmp.Canvas.CopyRect(Rect(0, 0, FBitmap.Width, cTileH),
                Bitmap.Canvas, Rect(0, ALine * cTileH, Bitmap.Width, ALine * cTileH + cTileH))
        Else
        Begin
            Bmp.Canvas.Brush.Color := clBtnFace;
            Bmp.Canvas.FillRect(Rect(0, 0, Bmp.Width, Bmp.Height));
        End;
    End;

    Procedure MakeImageList(List: TImageList; ALine: Integer);
    Begin
        LoadImageLine(ALine);
        List.AddMasked(Bmp, Bmp.Canvas.Pixels[0, cTileH - 1]);
    End;
Begin

    Inherited;

    Bmp := TBitmap.Create;
    Try
        MakeImageList(FMenuImages, 0);
        MakeImageList(FHelpImages, 1);
        MakeImageList(FProjectImages, 2);
        MakeImageList(FSpecialImages, 3);
        MakeImageList(FBrowserImages, 4);
    Finally
        Bmp.Free;
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomDevImageTheme.SaveToFile(AFilename: String);
Var
    I: Integer;
    X, Y: Integer;
    MaxW: Integer;
    ImgLists: Array[0..4] Of TImageList;
    Bmp: TBitmap;
    SingleBmp: TBitmap;
Begin

    ImgLists[0] := FMenuImages;
    ImgLists[1] := FHelpImages;
    ImgLists[2] := FProjectImages;
    ImgLists[3] := FSpecialImages;
    ImgLists[4] := FBrowserImages;

    MaxW := 0;
    For I := Low(ImgLists) To High(ImgLists) Do
        If (ImgLists[I].Count * cTileW) + cTileW > MaxW Then
            MaxW := ImgLists[I].Count * cTileW;

    Bmp := TBitmap.Create;
    SingleBmp := TBitmap.Create;
    Try
        SingleBmp.Transparent := True;
        SingleBmp.TransparentMode := tmAuto;

        Bmp.Height := cTileH * High(ImgLists) + cTileH;
        Bmp.Width := MaxW;
        Bmp.Canvas.Brush.Color := clFuchsia;
        Bmp.Canvas.FillRect(Rect(0, 0, Bmp.Width, Bmp.Height));

        For Y := Low(ImgLists) To High(ImgLists) Do
        Begin
            For X := 0 To ImgLists[Y].Count - 1 Do
            Begin
                If ImgLists[Y].GetBitmap(X, SingleBmp) Then
                Begin
                    //SingleBmp.TransparentColor := SingleBmp.Canvas.Pixels[0,cTileH-1];
                    Bmp.Canvas.Draw(X * cTileW, Y * cTileW, SingleBmp);
                End;
            End;
        End;

        Bmp.SaveToFile(AFilename);
    Finally
        Bmp.Free;
        SingleBmp.Free;
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomDevImageTheme.SetMenuImages(Const Img: TImageList);
Begin
    If Img <> FMenuImages Then
    Begin
        FMenuImages.Assign(Img);
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomDevImageTheme.SetHelpImages(Const Img: TImageList);
Begin
    If Img <> FHelpImages Then
    Begin
        FHelpImages.Assign(Img);
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomDevImageTheme.SetProjectImages(Const Img: TImageList);
Begin
    If Img <> FProjectImages Then
    Begin
        FProjectImages.Assign(Img);
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomDevImageTheme.SetSpecialImages(Const Img: TImageList);
Begin
    If Img <> FSpecialImages Then
    Begin
        FSpecialImages.Assign(Img);
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomDevImageTheme.SetBrowserImages(Const Img: TImageList);
Begin
    If Img <> FBrowserImages Then
    Begin
        FBrowserImages.Assign(Img);
    End;
End;

//----------------- TGnomeImageTheme -----------------------------------------------------------------------------------

Constructor TGnomeImageTheme.Create;
Begin
    Inherited;

    MenuImages := DataModule.MenuImages_Gnome;
    HelpImages := DataModule.HelpImages_Gnome;
    ProjectImages := DataModule.ProjectImage_Gnome;
    SpecialImages := DataModule.SpecialImages_Gnome;
    BrowserImages := DataModule.ClassImages;

    FTitle := 'Gnome';
End;

//----------------- TClassicImageTheme ---------------------------------------------------------------------------------

Constructor TClassicImageTheme.Create;
Begin
    Inherited;

    MenuImages := DataModule.MenuImages_Classic;
    HelpImages := DataModule.HelpImages_Classic;
    ProjectImages := DataModule.ProjectImage_Classic;
    SpecialImages := DataModule.SpecialImages_Classic;
    BrowserImages := DataModule.ClassImages;

    FTitle := 'Classic';
End;

//----------------- TNewLookImageTheme ---------------------------------------------------------------------------------

Constructor TNewLookImageTheme.Create;
Begin
    Inherited;

    MenuImages := DataModule.MenuImages_NewLook;
    HelpImages := DataModule.HelpImages_NewLook;
    ProjectImages := DataModule.ProjectImage_NewLook;
    SpecialImages := DataModule.SpecialImages_NewLook;
    BrowserImages := DataModule.ClassImages;

    FTitle := 'New Look';
End;

//----------------- TBlueImageTheme ------------------------------------------------------------------------------------

Constructor TBlueImageTheme.Create;
Begin
    Inherited;

    MenuImages := DataModule.MenuImages_Blue;
    HelpImages := DataModule.HelpImages_Blue;
    ProjectImages := DataModule.ProjectImage_Blue;
    SpecialImages := DataModule.SpecialImages_Blue;
    BrowserImages := DataModule.ClassImages;

    FTitle := 'Blue';
End;

//----------------- TCustomImageThemeFactory ---------------------------------------------------------------------------

Constructor TCustomImageThemeFactory.Create;
Begin
    Inherited;

    FThemes := TObjectList.Create;
End;

//----------------------------------------------------------------------------------------------------------------------

Destructor TCustomImageThemeFactory.Destroy;
Begin
    Inherited;
    FThemes.Free;
End;

//----------------------------------------------------------------------------------------------------------------------

Function TCustomImageThemeFactory.ActivateTheme(ATheme:
    TCustomImageTheme): Boolean;
Begin
    CurrentTheme := ATheme;
    Result := True;
End;

//----------------------------------------------------------------------------------------------------------------------

Function TCustomImageThemeFactory.ActivateTheme(AThemeTitle: String): Boolean;
Var
    I: Integer;
Begin
    Result := False;

    I := IndexOf(AThemeTitle);

    If I > -1 Then
        Result := ActivateTheme(Themes[I]);
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomImageThemeFactory.AddTheme(Const ATheme: TCustomImageTheme);
Begin
    FThemes.Add(ATheme);
End;

//----------------------------------------------------------------------------------------------------------------------

Function TCustomImageThemeFactory.Count: Integer;
Begin
    Result := FThemes.Count;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomImageThemeFactory.DoCreateThemeFromFile(AFilename: String);
Begin
End;

//----------------------------------------------------------------------------------------------------------------------

Function TCustomImageThemeFactory.GetTheme(Index: Integer): TCustomImageTheme;
Begin
    Result := FThemes[Index] As TCustomImageTheme;
End;

//----------------------------------------------------------------------------------------------------------------------

Function TCustomImageThemeFactory.GetThemeFilename(Index: Integer): String;
Begin
    Result := (FThemes[Index] As TCustomImageTheme).Filename;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomImageThemeFactory.GetThemeTitles(ADest: TStrings);
Var
    I: Integer;
Begin
    Assert(ADest <> Nil, 'ADest must not be nil');

    ADest.BeginUpdate;
    Try
        For I := 0 To Count - 1 Do
            ADest.Add(Themes[I].Title)
    Finally
        ADest.EndUpdate;
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Function TCustomImageThemeFactory.IndexOf(Const AThemeTitle: String): Integer;
Var
    I: Integer;
Begin
    Result := -1;

    For I := 0 To Count - 1 Do
        If SameText(AThemeTitle, Themes[I].Title) Then
        Begin
            Result := I;
            Break;
        End;
End;

//----------------------------------------------------------------------------------------------------------------------

Function TCustomImageThemeFactory.GetThemeTitle(Index: Integer): String;
Begin
    Result := (FThemes[Index] As TCustomImageTheme).Title;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomImageThemeFactory.LoadFromDirectory(ADirectory: String);
Var
    F: TSearchRec;
Begin
    If Not DirectoryExists(ADirectory) Then
        Exit;

    If ADirectory[Length(ADirectory)] <> '\' Then
        ADirectory := ADirectory + '\';

    If FindFirst(ADirectory + '*.bmp', faAnyFile, F) = 0 Then
        Repeat
            DoCreateThemeFromFile(ADirectory + F.Name);
        Until FindNext(F) <> 0;

    FindClose(F);
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomImageThemeFactory.RegisterTheme(
    Const ThemeClass: TImageThemeClass);
Var
    NewTheme: TCustomImageTheme;
Begin
    NewTheme := ThemeClass.Create;
    FThemes.Add(NewTheme);
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TCustomImageThemeFactory.SetCurrentTheme(
    Const ATheme: TCustomImageTheme);
Begin
    If FCurrentTheme <> ATheme Then
    Begin

        If Assigned(ATheme) And (FThemes.IndexOf(ATheme) < 0) Then
            FThemes.Add(ATheme);

        FCurrentTheme := ATheme;
    End;
End;

//----------------- TDevImageThemeFactory ------------------------------------------------------------------------------

Constructor TDevImageThemeFactory.Create;
Begin
    Inherited;

    FOnThemeChanged := Nil;
    RegisterTheme(TNewLookImageTheme);
    RegisterTheme(TGnomeImageTheme);
    RegisterTheme(TBlueImageTheme);
    RegisterTheme(TClassicImageTheme);

    FCurrentTheme := Themes[0];
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TDevImageThemeFactory.DoCreateThemeFromFile(AFilename: String);
Var
    NewTheme: TDevImageTheme;
Begin
    If FileExists(AFilename) Then
    Begin
        NewTheme := TDevImageTheme.Create;
        NewTheme.LoadFromFile(AFilename);
        NewTheme.FTitle := ChangeFileExt(ExtractFileName(AFilename), '');

        AddTheme(NewTheme);
    End;
End;

//----------------------------------------------------------------------------------------------------------------------

Function TDevImageThemeFactory.GetCurrentTheme: TDevImageTheme;
Begin
    Result := Inherited CurrentTheme As TDevImageTheme;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TDevImageThemeFactory.SetCurrentTheme(Const ATheme: TDevImageTheme);
Var
    OldTheme: TDevImageTheme;
Begin
    OldTheme := CurrentTheme;

    Inherited CurrentTheme := ATheme;

    If Assigned(FOnThemeChanged) Then
        FOnThemeChanged(Self, OldTheme, ATheme);
End;

//----------------------------------------------------------------------------------------------------------------------

Function TDevImageThemeFactory.GetTheme(Index: Integer): TDevImageTheme;
Begin
    Result := Inherited Themes[Index] As TDevImageTheme;
End;

End.
