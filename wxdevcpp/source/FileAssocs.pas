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

unit FileAssocs;

interface

uses
{$IFDEF WIN32}
    Windows, SysUtils, Classes, Forms, Registry, ShlObj, uVista;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QForms;
{$ENDIF}

procedure CheckAssociations;
procedure Associate(Index: integer);
procedure UnAssociate(Index: integer);
function IsAssociated(Index: integer): boolean;
function CheckFiletype(const extension, filetype, description,
    verb, serverapp: string): boolean;

var
    DDETopic: string;

const
    // if you change anything here, update devcfg.pas, specifically devData...
    // and update MustAssociate(), Associate() and UnAssociate() below
    AssociationsCount = 7;
    // field 1 is the extension (no dot)
    // field 2 is the description
    // field 3 is the icon number
    // field 4 is "" (empty) if you want DDE services for this extension
    // (if not empty, launches a new instance - nice for .dev files ;)
    Associations: array[0..6, 0..3] of string = (
        ('c', 'C Source File', '4', ''),
        ('cpp', 'C++ Source File', '5', ''),
        ('h', 'C Header File', '6', ''),
        ('hpp', 'C++ Header File', '7', ''),
        ('dev', 'Dev-C++ Project File', '3', 'xxx'),
        ('rc', 'Resource Source File', '8', ''),
        ('template', 'Dev-C++ Template File', '1', ''));

implementation

uses
    devcfg;

var
    Associated: array[0..AssociationsCount - 1] of boolean;

// forward decls
procedure RegisterFiletype(
    const extension, filetype, description, verb, serverapp, IcoNum: string);
    forward;
procedure RegisterDDEServer(
    const filetype, verb, topic, servername, macro: string); forward;

procedure RefreshIcons;
begin
    SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, NIL, NIL);
end;

function IsAssociated(Index: integer): boolean;
begin
    Result := Associated[Index];
end;

function MustAssociate(Index: integer): boolean;
begin
    case Index of
        0:
            Result := devData.AssociateC;
        1:
            Result := devData.AssociateCpp;
        2:
            Result := devData.AssociateH;
        3:
            Result := devData.AssociateHpp;
        4:
            Result := devData.AssociateDev;
        5:
            Result := devData.AssociateRc;
        6:
            Result := devData.AssociateTemplate;
    else
        Result := FALSE;
    end;
end;

procedure UnAssociate(Index: integer);
var
    reg: TRegistry;
begin

// This code can't be done on Windows with UAC since
//   need admin privledges to write to the registry.
//  I've commented it out. GAR 11 FEB 2012

    if (isElevatedUAC) then
    begin
        reg := TRegistry.Create;
        try
            reg.Rootkey := HKEY_CLASSES_ROOT;
            if reg.KeyExists('devcpp.' + Associations[Index, 0]) then
            begin
                reg.DeleteKey('.' + Associations[Index, 0]);
                reg.DeleteKey('devcpp.' + Associations[Index, 0]);
            end;
        finally
            reg.free;
        end;
        Associated[Index] := FALSE;
        case Index of
            0:
                devData.AssociateC := FALSE;
            1:
                devData.AssociateCpp := FALSE;
            2:
                devData.AssociateH := FALSE;
            3:
                devData.AssociateHpp := FALSE;
            4:
                devData.AssociateDev := FALSE;
            5:
                devData.AssociateRc := FALSE;
            6:
                devData.AssociateTemplate := FALSE;
        end;
        RefreshIcons;
    end;
end;

procedure Associate(Index: integer);
begin
    RegisterFiletype(
        '.' + Associations[Index, 0],
        'devcpp.' + Associations[Index, 0],
        Associations[Index, 1],
        'open',
        Application.Exename + ' "%1"',
        Associations[Index, 2]);
    if Associations[Index, 3] = '' then
        RegisterDDEServer(
            'devcpp.' + Associations[Index, 0],
            'open',
            DDETopic,
            Uppercase(ChangeFileExt(ExtractFilename(Application.Exename), EmptyStr)),
            '[Open("%1")]');
    Associated[Index] := TRUE;
    case Index of
        0:
            devData.AssociateC := TRUE;
        1:
            devData.AssociateCpp := TRUE;
        2:
            devData.AssociateH := TRUE;
        3:
            devData.AssociateHpp := TRUE;
        4:
            devData.AssociateDev := TRUE;
        5:
            devData.AssociateRc := TRUE;
        6:
            devData.AssociateTemplate := TRUE;
    end;
    RefreshIcons;
end;

function CheckFiletype(const extension, filetype, description,
    verb, serverapp: string): boolean;
var
    reg: TRegistry;
    keystring: string;
    regdfile: string;
begin
    reg := TRegistry.Create(KEY_READ);
    try
        Result := FALSE;
        reg.Rootkey := HKEY_CLASSES_ROOT;
        if not reg.OpenKey(extension, FALSE) then
            Exit;
        reg.CloseKey;
        if not reg.OpenKey(filetype, FALSE) then
            Exit;
        reg.closekey;
        keystring := Format('%s\shell\%s\command', [filetype, verb]);
        if not reg.OpenKey(keystring, FALSE) then
            Exit;
        regdfile := reg.ReadString('');
        reg.CloseKey;
        if CompareText(regdfile, serverapp) <> 0 then
            Exit;
        Result := TRUE;
    finally
        reg.free;
    end;
end;

procedure RegisterFiletype(const extension, filetype, description,
    verb, serverapp, IcoNum: string);
var
    reg: TRegistry;
    keystring: string;
begin

// This code can't be done on Windows with UAC since
//   need admin privledges to write to the registry.
//  I've commented it out. GAR 11 FEB 2012

    if (isElevatedUAC) then
    begin

        reg := TRegistry.Create;
        try
            reg.Rootkey := HKEY_CLASSES_ROOT;
            if not reg.OpenKey(extension, TRUE) then
                Exit;
            reg.WriteString('', filetype);
            reg.CloseKey;
            if not reg.OpenKey(filetype, TRUE) then
                Exit;
            reg.WriteString('', description);
            reg.closekey;
            keystring := Format('%s\shell\%s\command', [filetype, verb]);
            if not reg.OpenKey(keystring, TRUE) then
                Exit;
            reg.WriteString('', serverapp);
            reg.CloseKey;
            if not reg.OpenKey(filetype + '\DefaultIcon', TRUE) then
                Exit;
            reg.WriteString('', Application.ExeName + ',' + IcoNum);
            reg.CloseKey;
            RefreshIcons;
        finally
            reg.free;
        end;

    end;

end;

function CheckDDEServer(const filetype, verb, topic, servername:
    string): boolean;
var
    reg: TRegistry;
    keystring: string;
begin
    reg := TRegistry.Create(KEY_READ);
    try
        Result := FALSE;
        reg.Rootkey := HKEY_CLASSES_ROOT;
        keystring := Format('%s\shell\%s\ddeexec', [filetype, verb]);
        if not reg.OpenKey(keystring, FALSE) then
            Exit;
        reg.CloseKey;
        if not reg.OpenKey(keystring + '\Application', FALSE) then
            Exit;
        reg.CloseKey;
        if not reg.OpenKey(keystring + '\topic', FALSE) then
            Exit;
        reg.CloseKey;
        Result := TRUE;
    finally
        reg.free;
    end;
end;

procedure RegisterDDEServer(const filetype, verb, topic, servername, macro:
    string);
var
    reg: TRegistry;
    keystring: string;
begin
// This code can't be done on Windows with UAC since
//   need admin privledges to write to the registry.
//  I've commented it out. GAR 11 FEB 2012

    if (isElevatedUAC) then
    begin
        reg := TRegistry.Create;
        try
            reg.Rootkey := HKEY_CLASSES_ROOT;
            keystring := Format('%s\shell\%s\ddeexec', [filetype, verb]);
            if not reg.OpenKey(keystring, TRUE) then
                Exit;
            reg.WriteString('', macro);
            reg.CloseKey;
            if not reg.OpenKey(keystring + '\Application', TRUE) then
                Exit;
            reg.WriteString('', servername);
            reg.CloseKey;
            if not reg.OpenKey(keystring + '\topic', TRUE) then
                Exit;
            reg.WriteString('', topic);
            reg.CloseKey;
        finally
            reg.free;
        end;

    end;

end;

procedure CheckAssociations;
var
    I: integer;
    DdeOK: array[0..AssociationsCount - 1] of boolean;
begin
    for I := 0 to AssociationsCount - 1 do
        Associated[I] := CheckFiletype('.' + Associations[I, 0],
            'devcpp.' + Associations[I, 0],
            Associations[I, 1],
            'open',
            Application.Exename + ' "%1"');

    for I := 0 to AssociationsCount - 1 do
        if (not Associated[I]) and MustAssociate(I) then
        begin
            Associate(I);
        end;

    for I := 0 to AssociationsCount - 1 do
        DdeOK[I] := (Associations[I, 3] <> '') or
            CheckDDEServer('devcpp.' + Associations[I, 0],
            'open',
            DDETopic,
            Uppercase(ChangeFileExt(ExtractFilename(Application.Exename),
            EmptyStr)));

    for I := 0 to AssociationsCount - 1 do
        if (not DdeOK[I]) and MustAssociate(I) then
            RegisterDDEServer(
                'devcpp.' + Associations[I, 0],
                'open',
                DDETopic,
                Uppercase(ChangeFileExt(ExtractFilename(Application.Exename),
                EmptyStr)),
                '[Open("%1")]');
end;

end.
