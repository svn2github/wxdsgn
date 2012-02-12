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

Unit FileAssocs;

Interface

Uses
{$IFDEF WIN32}
    Windows, SysUtils, Classes, Forms, Registry, ShlObj;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QForms;
{$ENDIF}

Procedure CheckAssociations;
Procedure Associate(Index: Integer);
Procedure UnAssociate(Index: Integer);
Function IsAssociated(Index: Integer): Boolean;
Function CheckFiletype(Const extension, filetype, description,
    verb, serverapp: String): Boolean;

Var
    DDETopic: String;

Const
    // if you change anything here, update devcfg.pas, specifically devData...
    // and update MustAssociate(), Associate() and UnAssociate() below
    AssociationsCount = 7;
    // field 1 is the extension (no dot)
    // field 2 is the description
    // field 3 is the icon number
    // field 4 is "" (empty) if you want DDE services for this extension
    // (if not empty, launches a new instance - nice for .dev files ;)
    Associations: Array[0..6, 0..3] Of String = (
        ('c', 'C Source File', '4', ''),
        ('cpp', 'C++ Source File', '5', ''),
        ('h', 'C Header File', '6', ''),
        ('hpp', 'C++ Header File', '7', ''),
        ('dev', 'Dev-C++ Project File', '3', 'xxx'),
        ('rc', 'Resource Source File', '8', ''),
        ('template', 'Dev-C++ Template File', '1', ''));

Implementation

Uses
    devcfg;

Var
    Associated: Array[0..AssociationsCount - 1] Of Boolean;

// forward decls
Procedure RegisterFiletype(
    Const extension, filetype, description, verb, serverapp, IcoNum: String);
    Forward;
Procedure RegisterDDEServer(
    Const filetype, verb, topic, servername, macro: String); Forward;

Procedure RefreshIcons;
Begin
    SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, Nil, Nil);
End;

Function IsAssociated(Index: Integer): Boolean;
Begin
    Result := Associated[Index];
End;

Function MustAssociate(Index: Integer): Boolean;
Begin
    Case Index Of
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
    Else
        Result := False;
    End;
End;

Procedure UnAssociate(Index: Integer);
Var
    reg: TRegistry;
Begin
    reg := TRegistry.Create;
    Try
        reg.Rootkey := HKEY_CLASSES_ROOT;
        If reg.KeyExists('wxdevcpp.' + Associations[Index, 0]) Then
        Begin
            reg.DeleteKey('.' + Associations[Index, 0]);
            reg.DeleteKey('wxdevcpp.' + Associations[Index, 0]);
        End;
    Finally
        reg.free;
    End;
    Associated[Index] := False;
    Case Index Of
        0:
            devData.AssociateC := False;
        1:
            devData.AssociateCpp := False;
        2:
            devData.AssociateH := False;
        3:
            devData.AssociateHpp := False;
        4:
            devData.AssociateDev := False;
        5:
            devData.AssociateRc := False;
        6:
            devData.AssociateTemplate := False;
    End;
    RefreshIcons;
End;

Procedure Associate(Index: Integer);
Begin
    RegisterFiletype(
        '.' + Associations[Index, 0],
        'wxdevcpp.' + Associations[Index, 0],
        Associations[Index, 1],
        'open',
        Application.Exename + ' "%1"',
        Associations[Index, 2]);
    If Associations[Index, 3] = '' Then
        RegisterDDEServer(
            'wxdevcpp.' + Associations[Index, 0],
            'open',
            DDETopic,
            Uppercase(ChangeFileExt(ExtractFilename(Application.Exename), EmptyStr)),
            '[Open("%1")]');
    Associated[Index] := True;
    Case Index Of
        0:
            devData.AssociateC := True;
        1:
            devData.AssociateCpp := True;
        2:
            devData.AssociateH := True;
        3:
            devData.AssociateHpp := True;
        4:
            devData.AssociateDev := True;
        5:
            devData.AssociateRc := True;
        6:
            devData.AssociateTemplate := True;
    End;
    RefreshIcons;
End;

Function CheckFiletype(Const extension, filetype, description,
    verb, serverapp: String): Boolean;
Var
    reg: TRegistry;
    keystring: String;
    regdfile: String;
Begin
    reg := TRegistry.Create;
    Try
        Result := False;
        reg.Rootkey := HKEY_CLASSES_ROOT;
        If Not reg.OpenKey(extension, False) Then
            Exit;
        reg.CloseKey;
        If Not reg.OpenKey(filetype, False) Then
            Exit;
        reg.closekey;
        keystring := Format('%s\shell\%s\command', [filetype, verb]);
        If Not reg.OpenKey(keystring, False) Then
            Exit;
        regdfile := reg.ReadString('');
        reg.CloseKey;
        If CompareText(regdfile, serverapp) <> 0 Then
            Exit;
        Result := True;
    Finally
        reg.free;
    End;
End;

Procedure RegisterFiletype(Const extension, filetype, description,
    verb, serverapp, IcoNum: String);
Var
    reg: TRegistry;
    keystring: String;
Begin
    reg := TRegistry.Create;
    Try
        reg.Rootkey := HKEY_CLASSES_ROOT;
        If Not reg.OpenKey(extension, True) Then
            Exit;
        reg.WriteString('', filetype);
        reg.CloseKey;
        If Not reg.OpenKey(filetype, True) Then
            Exit;
        reg.WriteString('', description);
        reg.closekey;
        keystring := Format('%s\shell\%s\command', [filetype, verb]);
        If Not reg.OpenKey(keystring, True) Then
            Exit;
        reg.WriteString('', serverapp);
        reg.CloseKey;
        If Not reg.OpenKey(filetype + '\DefaultIcon', True) Then
            Exit;
        reg.WriteString('', Application.ExeName + ',' + IcoNum);
        reg.CloseKey;
        RefreshIcons;
    Finally
        reg.free;
    End;
End;

Function CheckDDEServer(Const filetype, verb, topic, servername:
    String): Boolean;
Var
    reg: TRegistry;
    keystring: String;
Begin
    reg := TRegistry.Create;
    Try
        Result := False;
        reg.Rootkey := HKEY_CLASSES_ROOT;
        keystring := Format('%s\shell\%s\ddeexec', [filetype, verb]);
        If Not reg.OpenKey(keystring, False) Then
            Exit;
        reg.CloseKey;
        If Not reg.OpenKey(keystring + '\Application', False) Then
            Exit;
        reg.CloseKey;
        If Not reg.OpenKey(keystring + '\topic', False) Then
            Exit;
        reg.CloseKey;
        Result := True;
    Finally
        reg.free;
    End;
End;

Procedure RegisterDDEServer(Const filetype, verb, topic, servername, macro:
    String);
Var
    reg: TRegistry;
    keystring: String;
Begin
    reg := TRegistry.Create;
    Try
        reg.Rootkey := HKEY_CLASSES_ROOT;
        keystring := Format('%s\shell\%s\ddeexec', [filetype, verb]);
        If Not reg.OpenKey(keystring, True) Then
            Exit;
        reg.WriteString('', macro);
        reg.CloseKey;
        If Not reg.OpenKey(keystring + '\Application', True) Then
            Exit;
        reg.WriteString('', servername);
        reg.CloseKey;
        If Not reg.OpenKey(keystring + '\topic', True) Then
            Exit;
        reg.WriteString('', topic);
        reg.CloseKey;
    Finally
        reg.free;
    End;
End;

Procedure CheckAssociations;
Var
    I: Integer;
    DdeOK: Array[0..AssociationsCount - 1] Of Boolean;
Begin
    For I := 0 To AssociationsCount - 1 Do
        Associated[I] := CheckFiletype('.' + Associations[I, 0],
            'wxdevcpp.' + Associations[I, 0],
            Associations[I, 1],
            'open',
            Application.Exename + ' "%1"');

    For I := 0 To AssociationsCount - 1 Do
        If (Not Associated[I]) And MustAssociate(I) Then
        Begin
            Associate(I);
        End;

    For I := 0 To AssociationsCount - 1 Do
        DdeOK[I] := (Associations[I, 3] <> '') Or
            CheckDDEServer('wxdevcpp.' + Associations[I, 0],
            'open',
            DDETopic,
            Uppercase(ChangeFileExt(ExtractFilename(Application.Exename),
            EmptyStr)));

    For I := 0 To AssociationsCount - 1 Do
        If (Not DdeOK[I]) And MustAssociate(I) Then
            RegisterDDEServer(
                'wxdevcpp.' + Associations[I, 0],
                'open',
                DDETopic,
                Uppercase(ChangeFileExt(ExtractFilename(Application.Exename),
                EmptyStr)),
                '[Open("%1")]');
End;

End.
