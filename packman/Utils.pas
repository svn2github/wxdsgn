unit Utils;

interface

uses
  Classes, SysUtils, Windows;

procedure FilesFromWildcard(Directory, Mask: String; var Files : TStringList;
  Subdirs, ShowDirs: Boolean);
function GetDevcppMenu: String;
procedure CreateShortcut(FileName, Target: String; Icon: String = '');
function CalcMod(Count: Integer): Integer;
function GetEnvVarValue(const VarName: string): string;

implementation

uses
  ShlObj, ActiveX, ComObj;

procedure FilesFromWildcard(Directory, Mask: String; var Files : TStringList;
  Subdirs, ShowDirs: Boolean);
var
  SearchRec: TSearchRec;
  Attr, Error: Integer;
begin
  if (Directory[Length(Directory)] <> '\') then
     Directory := Directory + '\';

  { First, find the required file... }
  Attr := faAnyFile;
  if ShowDirs = False then
     Attr := Attr - faDirectory;
  Error := FindFirst(Directory + Mask, Attr, SearchRec);
  if (Error = 0) then
  begin
     while (Error = 0) do
     begin
     { Found one! }
        Files.Add(Directory + SearchRec.Name);
        Error := FindNext(SearchRec);
     end;
     SysUtils.FindClose(SearchRec);
  end;

  { Then walk through all subdirectories. }
  if Subdirs then
  begin
     Error := FindFirst(Directory + '*.*', faAnyFile, SearchRec);
     if (Error = 0) then
     begin
        while (Error = 0) do
        begin
           { Found one! }
           if (SearchRec.Name[1] <> '.') and (SearchRec.Attr and
             faDirectory <> 0) then
              { We do this recursively! }
              FilesFromWildcard(Directory + SearchRec.Name, Mask, Files,
                Subdirs, ShowDirs);
           Error := FindNext(SearchRec);
        end;
     SysUtils.FindClose(SearchRec);
     end;
  end;
end;

function GetDevcppMenu: String;
var
  PIDL       : PItemIDList;
  InFolder   : array[0..MAX_PATH] of Char;
begin
  SHGetSpecialFolderLocation(0, CSIDL_PROGRAMS, PIDL);
  SHGetPathFromIDList(PIDL, InFolder);
  Result := InFolder + '\Bloodshed Dev-C++';
end;

procedure CreateShortcut(FileName, Target: String; Icon: String);
var
  IObject    : IUnknown;
  ISLink     : IShellLink;
  IPFile     : IPersistFile;
  F: TextFile;
begin
  if CompareText(Copy(Target, 1, 7), 'http://') = 0 then
  begin
      try
         AssignFile(F, FileName);
         Rewrite(F);
         Writeln(F, '[InternetShortcut]');
         Writeln(F, 'URL=', Target);
         CloseFile(F);
      except
         { do nothing }
      end;
  end
  else
  begin
      IObject := CreateComObject(CLSID_ShellLink);
      ISLink  := IObject as IShellLink;
      IPFile  := IObject as IPersistFile;

      with ISLink do
      begin
          SetPath(PChar(Target));
          SetWorkingDirectory(PChar(ExtractFilePath(Target)));
          if Length(Icon) > 0 then
          SetIconLocation(PChar(Icon), 0);
      end;

      IPFile.Save(PWChar(WideString(FileName)), false);
  end;
end;

function CalcMod(Count: Integer): Integer;
begin
  if Count <= 100 then
      Result := 0
  else if Count <= 350 then
      Result := 2
  else if Count <= 700 then
      Result := 4
  else if Count <= 1000 then
      Result := 8
  else
      Result := 16;
end;

end.
