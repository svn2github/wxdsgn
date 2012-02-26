{
Copyright © Norstedts Juridik AB
Made by Per-Erik Andersson, inspired by J Hamblin - Qtools Software.
Author grants unrestricted use of this software code.
All use is on your own risk.

J Hamblin has made a component TjhALTBugFix to solve a problem in Vista.
It can be downloaded from CodeGear Quality centre here:
http://qc.codegear.com/wc/qcmain.aspx?d=37403
Below is the text J Hamblin wrote that describes the problem:

** Quote **************
There seems to be a problem with THEMES support in Delphi, in which
TButton, TCheckBox, TRadioButton and TStaticText standard controls
vanish in VISTA when the ALT key is pressed. (only TStaticText vanishes in XP).
If the OS is set to default, pressing the ALT key in XP and Vista has the
behavior of displaying the underline under the accelerator keys.

The mentioned controls vanish the first time ALT is pressed. They can be
restored by repainting the control in code. Once restored, they are not
affected by subsequent ALT key presses -- unless a pagecontrol on the form
changes to a new tabsheet, then all affected controls, both on the tabsheet
and on the form, will vanish on next ALT press. Due to the pagecontrol issue
there is no way to set a flag to do the repaint op only once. In MDI applications,
an ALT key press has the same affect on all child forms at the same time.
** End quote **************

The TjhALTBugFix needs to be put on each form in the application which
is a problem in many large applications. Therefore I made this component
that can be dropped on the main form and then handles all delphi forms
that are created.

The component works like this: In Idle it goes through the list of existing
Delphi forms in TScreen. When a new form is found, its WindowProc is replaced
with a hook that listens for the event WM_UPDATEUISTATE which is the
message triggering the error.
When a form has got an WM_UPDATEUISTATE it gets a flag the says it needs to
be redrawn. The next time the application enters Idle a repaint is made,
depending on the property RepaintAll. If it is true all TWinControls on the
form gets a repaint. If its false only the component that probably needs a
repaint is repainted (that code mady by J Hamblin).
The "repaint all" is an precausion for third part components that might behave in
the same way. RepaintAll is default true.
Note that this component is only active in Vista. If you want it to
handle the TStaticText in XP you have to remove the VistaWithTheme check
in TVistaAltFix.Create.

Usage:
If you want to use this as an component you have to install it into the Delphi IDE.
If you don't want to do that just add this code in your main form OnCreate:

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TVistaAltFix.Create(Self);
end;

}

Unit VistaAltFixUnit;

Interface
Uses
    ExtCtrls, Classes, Contnrs, AppEvnts;

Type
    TVistaAltFix = Class(TComponent)
    Private
        FList: TObjectList;
        FApplicationEvents: TApplicationEvents;
        FRepaintAll: Boolean;
        Procedure ApplicationEventsIdle(Sender: TObject; Var Done: Boolean);
       // Function VistaWithTheme: Boolean;
    Public
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
    Published
        Property RepaintAll: Boolean Read FRepaintAll Write FRepaintAll Default True;
    End;

Procedure Register;

Implementation
Uses
    Forms, Windows, Messages, Buttons, ComCtrls, Controls, StdCtrls;//, Themes;

Type
    TFormObj = Class(TObject)
    Private
        Procedure WndProc(Var Message: TMessage);
    Public
        Form: TForm;
        OrgProc: TWndMethod;
        Used: Boolean;
        NeedRepaint: Boolean;
        RepaintAll: Boolean;
        Constructor Create(aForm: TForm; aRepaintAll: Boolean);
        Procedure DoRepaint;
    End;

Procedure Register;
Begin
    RegisterComponents('MEP', [TVistaAltFix]);
End;

{ TVistaAltFix }

Procedure TVistaAltFix.ApplicationEventsIdle(Sender: TObject;
    Var Done: Boolean);
Var
    I: Integer;
    J: Integer;
    TestForm: TForm;
Begin
  // Initialize
    For I := 0 To FList.Count - 1 Do
        TFormObj(FList[i]).Used := False;

  // Check for new forms
    For I := 0 To Screen.FormCount - 1 Do
    Begin
        TestForm := Screen.Forms[i];
        For J := 0 To FList.Count - 1 Do
        Begin
            If TFormObj(FList[J]).Form = TestForm Then
            Begin
                TFormObj(FList[J]).Used := True;
                TestForm := Nil;
                Break;
            End;
        End;
        If Assigned(TestForm) Then
            FList.Add(TFormObj.Create(TestForm, RepaintAll));
    End;

  // Remove destroyed forms, repaint others if needed.
    For I := FList.Count - 1 Downto 0 Do
    Begin
        If Not TFormObj(FList[i]).Used Then
            FList.Delete(i)
        Else
            TFormObj(FList[i]).DoRepaint;
    End;
End;

Constructor TVistaAltFix.Create(AOwner: TComponent);
Begin
    Inherited;
    FRepaintAll := True;
  //if VistaWithTheme and not (csDesigning in ComponentState) then
    If Not (csDesigning In ComponentState) Then
    Begin
        FList := TObjectList.Create;
        FApplicationEvents := TApplicationEvents.Create(Nil);
        FApplicationEvents.OnIdle := ApplicationEventsIdle;
    End;
End;

Destructor TVistaAltFix.Destroy;
Begin
    FApplicationEvents.Free;
    FList.Free;
    Inherited;
End;

//Function TVistaAltFix.VistaWithTheme: Boolean;
//Var
//    OSVersionInfo: TOSVersionInfo;
//Begin
//    OSVersionInfo.dwOSVersionInfoSize := SizeOf(OSVersionInfo);
  //if GetVersionEx(OSVersionInfo) and
//     (OSVersionInfo.dwMajorVersion >= 6) and
 //    ThemeServices.ThemesEnabled then
 //   Result := True
 // else
 //   Result := False;
//End;

{ TFormObj }

Constructor TFormObj.Create(aForm: TForm; aRepaintAll: Boolean);
Begin
    Inherited Create;
    Form := aForm;
    RepaintAll := aRepaintAll;
    Used := True;
    OrgProc := Form.WindowProc;
    Form.WindowProc := WndProc;
End;

Procedure TFormObj.DoRepaint;
    Procedure RepaintBtnControls(TheCtrl: TControl);
  // This method made by J Hamblin - Qtools Software.
    Var
        i: Integer;
    Begin
        If Not (TheCtrl Is TWinControl) Or (TheCtrl Is TBitBtn) Then
            exit;

    // repaint only controls of affected type
        If (TheCtrl Is TButtonControl) Or (TheCtrl Is TStaticText) Then
        Begin
            TWinControl(TheCtrl).Repaint;
            exit; // TButtonControls, TStaticText do not contain controls so skip rest
        End;

    //

        For i := 0 To TWinControl(TheCtrl).ControlCount - 1 Do
        Begin
      // only paint controls on active tabsheet of page control
            If (TheCtrl Is TTabSheet) And
                (TTabSheet(TheCtrl).PageIndex <> TTabSheet(TheCtrl).PageControl.ActivePageIndex) Then
                continue;
      // recurse
            RepaintBtnControls(TWinControl(TheCtrl).Controls[i]);
        End;
    End;

    Procedure DoRepaint(Ctrl: TControl);
    Var
        i: Integer;
    Begin
        If (Ctrl Is TWinControl) Then
        Begin
            TWinControl(Ctrl).Repaint;
            For i := 0 To TWinControl(Ctrl).ControlCount - 1 Do
                DoRepaint(TWinControl(Ctrl).Controls[i]);
        End;
    End;

Begin
    If NeedRepaint Then
    Begin
        NeedRepaint := False;
        If RepaintAll Then
            DoRepaint(Form)
        Else
            RepaintBtnControls(Form);
    End;
End;

Procedure TFormObj.WndProc(Var Message: TMessage);
Begin
    OrgProc(Message);
    If (Message.Msg = WM_UPDATEUISTATE) Then
        If (TFormObj <> Nil) Then
            NeedRepaint := True;
End;

End.
