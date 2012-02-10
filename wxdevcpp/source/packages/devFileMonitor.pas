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

Unit devFileMonitor;

Interface

Uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Forms, Controls,
    devMonitorThread, devMonitorTypes;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QForms, QControls,
  devMonitorThread, devMonitorTypes;
{$ENDIF}

Type
    TdevFileMonitor = Class(TWinControl)
    Private
    { Private declarations }
        fFiles: TStrings;
        fMonitor: TdevMonitorThread;
        fNotifyChange: TdevMonitorChange;
        Function GetActive: Boolean;
        Procedure SetActive(Const Value: Boolean);
        Procedure SetFiles(Const Value: TStrings);
    Public
    { Public declarations }
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Procedure Activate;
        Procedure Deactivate;
        Procedure Refresh(ActivateIfNot: Boolean);
        Procedure SubClassWndProc(Var Message: TMessage);
    Published
    { Published declarations }
        Property Active: Boolean Read GetActive Write SetActive;
        Property Files: TStrings Read fFiles Write SetFiles;
        Property OnNotifyChange: TdevMonitorChange Read fNotifyChange Write fNotifyChange;
    End;

Implementation

Procedure TdevFileMonitor.SubClassWndProc(Var Message: TMessage);
Begin
    If Message.Msg = APPMSG_NOTIFYFILECHANGED Then
    Begin
        If Assigned(fNotifyChange) Then
        Begin
            fNotifyChange(Self, TDevMonitorChangeType(Message.WParam), Pchar(Message.LParam));
            StrDispose(Pchar(Message.LParam));
        End;
    End
    Else
        WndProc(Message);
End;

Constructor TdevFileMonitor.Create(AOwner: TComponent);
Begin
    Inherited;
    fFiles := TStringList.Create;
    fMonitor := Nil;
    WindowProc := SubClassWndProc;
End;

Destructor TdevFileMonitor.Destroy;
Begin
    Deactivate;
    If Assigned(fFiles) Then
        fFiles.Free;
    Inherited;
End;

Procedure TdevFileMonitor.Activate;
Begin
    If Not Active Then
    Begin
        fMonitor := TdevMonitorThread.Create(Self, fFiles);
        fMonitor.Resume;
    End;
End;

Procedure TdevFileMonitor.Deactivate;
Begin
    If Active Then
    Begin
        fMonitor.TellToQuit;
        fMonitor.WaitFor;
        fMonitor.Free;
        fMonitor := Nil;
    End;
End;

Function TdevFileMonitor.GetActive: Boolean;
Begin
    Result := Assigned(fMonitor);
End;

Procedure TdevFileMonitor.Refresh(ActivateIfNot: Boolean);
Begin
    If (Not Active) And ActivateIfNot Then
        Activate
    Else
    If Active Then
        fMonitor.ReloadList(fFiles);
End;

Procedure TdevFileMonitor.SetActive(Const Value: Boolean);
Begin
    If Value And Not Active Then
        Activate
    Else
    If Not Value And Active Then
        Deactivate;
End;

Procedure TdevFileMonitor.SetFiles(Const Value: TStrings);
Begin
    fFiles.Assign(Value);
End;

End.
