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

Unit devReg;

Interface

Uses
{$IFDEF WIN32}
    Classes, Controls, devTabs, ColorPickerButton, devFileMonitor,
{$ENDIF}
{$IFDEF LINUX}
 Classes, QControls, devTabs, ColorPickerButton, devFileMonitor,
{$ENDIF}

{$IFDEF VER130}
 DsgnIntf
{$ELSE}
    DesignEditors,
    DesignIntf
{$ENDIF};

Type
    TdevPageEditor = Class(TComponentEditor)
        Function GetVerb(index: Integer): String; Override;
        Function GetVerbCount: Integer; Override;
        Procedure ExecuteVerb(index: Integer); Override;
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('dev-c++',
        [TdevTabs, TdevPages, TColorPickerButton, TdevFileMonitor]);
    RegisterClasses([TdevPage]);
    RegisterComponentEditor(TdevPages, TdevPageEditor);
    RegisterComponentEditor(TdevPage, TdevPageEditor);
End;


{ TdevPageEditor }

Procedure TdevPageEditor.ExecuteVerb(index: Integer);
Var
    Pages: TdevCustomPages;
Begin
    If Component Is TdevPages Then
        Pages := TdevPages(Component)
    Else
        Pages := TdevPage(Component).Pages;

    If index = 0 Then
    Begin
        Pages.ControlStyle := Pages.ControlStyle + [csAcceptsControls];
        Try
            Designer.CreateComponent(TdevPage, Pages, 0, 0, 0, 0);
        Finally
            Pages.ControlStyle := Pages.ControlStyle - [csAcceptsControls];
        End;
    End;
{$IFDEF VER130}
  else
   Designer.DeleteSelection;
{$ENDIF}
End;

Function TdevPageEditor.GetVerb(index: Integer): String;
Begin
    result := 'New Page';
    If index = 1 Then
        result := 'Delete Page';
End;

Function TdevPageEditor.GetVerbCount: Integer;
Begin
{$IFDEF VER130}
  result:= 1;
{$ELSE}
    result := 2;
{$ENDIF}
End;

End.
