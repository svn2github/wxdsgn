Unit wxeditor;

Interface

Uses
    Windows, Controls, Forms, ComCtrls, Graphics, SysUtils, Menus,
    Designerfrm, CompFileIo, Dialogs,
    wxutils, SynEdit, wxversion, MigrateFrm, StdCtrls;

Type

    TWXEditor = Class
        fDesigner: TfrmNewForm;
        fScrollDesign: TScrollBox;

    //Guru's Code
    Private
        fDesignerClassName, fDesignerTitle: String;
        fDesignerStyle: TWxDlgStyleSet;
        fDesignerDefaultData: Boolean;
        Procedure Close; // New fnc for wx
        Procedure OnbtnFloatingDesigner_Click(Sender: TObject);
    Public
        FileName: String;
        editorNumber: Integer;
        btnFloatingDesigner: TButton;
        Function GetDesigner: TfrmNewForm;
        Procedure InitDesignerData(strFName, strCName, strFTitle: String; dlgSStyle: TWxDlgStyleSet);
        Function GetDesignerHPPFileName: String;
        Function GetDesignerCPPFileName: String;
        Procedure ReloadForm;
        Procedure ReloadFormFromFile(strFilename: String);
        Procedure Init(fTabSheet: TTabSheet; Var fText: TSynEdit; DesignerPopup: TPopUpMenu; DoOpen: Boolean; fName: String);
    //procedure Reload;
        Procedure Terminate;
        Function GetDefaultText: String;
        Function IsDesignerNil: Boolean;
        Property ScrollDesign: TScrollBox Read fScrollDesign Write fScrollDesign;
        Procedure RestorePosition;

    End;

Implementation

Uses
    wxdesigner;

Procedure TWXEditor.Init(fTabSheet: TTabSheet; Var fText: TSynEdit; DesignerPopup: TPopUpMenu; DoOpen: Boolean; fName: String);
Begin

	    //Dont allow anyone to edit the text content
    FileName := fName;
    fScrollDesign := TScrollBox.Create(fTabSheet);
    fScrollDesign.Parent := fTabSheet;
    fScrollDesign.Align := alClient;
    fScrollDesign.Visible := True;
    fScrollDesign.Color := clWhite;

    fDesigner := TfrmNewForm.Create(fScrollDesign);
	    //fDesigner.Parent:=fScrollDesign;

    fDesigner.synEdit := fText;
    fDesigner.Visible := False;
    fDesigner.fileName := FileName;

    btnFloatingDesigner := TButton.Create(fScrollDesign);
    With btnFloatingDesigner Do
    Begin
        Left := 2;
        Top := 2;
        Width := fScrollDesign.Width - 2;
        Height := fScrollDesign.Height - 2;
        Anchors := [akLeft, akTop, akRight, akBottom];
        Caption := 'Click here to bring designer to front...';
        Parent := fScrollDesign;
        Visible := False;
        OnClick := OnbtnFloatingDesigner_Click;
    End;

    If Not wx_designer.ELDesigner1.Floating Then
    Begin
        SetWindowLong(fDesigner.Handle, GWL_STYLE, WS_CHILD Or GetWindowLong(fDesigner.Handle, GWL_STYLE));
        Windows.SetParent(fDesigner.Handle, fScrollDesign.Handle);
    End
    Else
        btnFloatingDesigner.Visible := True;

    fScrollDesign.ScrollInView(fDesigner);

    If (DoOpen) Then
        Try
            ReloadForm();
        Except
            Raise;
        End;
    fDesigner.Visible := True;

    If Not wx_designer.ELDesigner1.Floating Then
    Begin
        fDesigner.Left := 8;
        fDesigner.Top := 8;
    End;

    If fDesignerDefaultData Then
    Begin
        If Trim(fDesignerClassName) <> '' Then
            fDesigner.Wx_Name := Trim(fDesignerClassName);

        If Trim(fDesigner.Wx_Name) <> '' Then
            fDesigner.Wx_IDName := UpperCase('ID_' + fDesigner.Wx_Name);

        If fDesigner.Wx_IDValue = 0 Then
            fDesigner.Wx_IDValue := 1000;

        If fDesignerStyle <> [] Then
            fDesigner.Wx_DialogStyle := fDesignerStyle;

        If Trim(fDesignerTitle) <> '' Then
            fDesigner.Caption := Self.fDesignerTitle;
    End;

    fDesigner.PopupMenu := DesignerPopup;
End;

Procedure TWXEditor.Terminate;
Begin
    wx_designer.DisableDesignerControls;
End;

Procedure TWXEditor.Close;
Begin
    wx_designer.DisableDesignerControls;
End;

Function TWXEditor.GetDefaultText: String;
Begin
    Result := CompFileIo.ComponentToString(fDesigner);
End;

Function TWXEditor.GetDesigner: TfrmNewForm;
Begin
    Result := fDesigner;
End;

Procedure TWXEditor.InitDesignerData(strFName, strCName, strFTitle: String;
    dlgSStyle: TWxDlgStyleSet);
Begin
    fDesignerClassName := strCName;
    fDesignerTitle := strFTitle;
    fDesignerStyle := dlgSStyle;
    fDesignerDefaultData := True;
End;

Function TWXEditor.GetDesignerHPPFileName: String;
Begin

    If FileExists(ChangeFileExt(FileName, H_EXT)) Then
        Result := ChangeFileExt(FileName, H_EXT);
End;

Function TWXEditor.GetDesignerCPPFileName: String;
Begin
    If FileExists(ChangeFileExt(FileName, CPP_EXT)) Then
        Result := ChangeFileExt(FileName, CPP_EXT);
End;

Procedure TWXEditor.ReloadForm;
Begin
    ReloadFormFromFile(self.FileName);
End;

Procedure TWXEditor.ReloadFormFromFile(strFilename: String);
Var
    I: Integer;
Begin
    Try
     //Delete all the Components and
        For I := self.fDesigner.ComponentCount - 1 Downto 0 Do    // Iterate
        Begin
            self.fDesigner.Components[i].Destroy;
        End;    // for
        ReadComponentFromFile(self.fDesigner, strFilename);
    Except
        on e: Exception Do
            With TMigrateFrm.Create(Application.MainForm) Do
            Begin
                Source.Text := strFileName;
                If ShowModal = mrOK Then
                Begin
          //ReloadFormFromFile(strFileName);
                    Try
             //Delete all the Components and
                        For I := self.fDesigner.ComponentCount - 1 Downto 0 Do    // Iterate
                        Begin
                            self.fDesigner.Components[i].Destroy;
                        End;    // for
                        ReadComponentFromFile(self.fDesigner, strFilename);
                    Except
                        on e: Exception Do
                        Begin
                            MessageDlg(Format('%s: "%s"', [wx_designer.GetLangString(ID_ERR_UPDATE_WXFORM), e.Message]), mtError, [mbOk], Handle);
                        End;
                    End;
                End;

                Destroy;
            End;
    End;
End;

Function TWXEditor.IsDesignerNil: Boolean;
Begin
    If fDesigner <> Nil Then
        Result := False
    Else
        Result := True;
End;

Procedure TWXEditor.OnbtnFloatingDesigner_Click(Sender: TObject);
Begin
    fDesigner.Show;
End;

Procedure TWXEditor.RestorePosition;
Begin

End;

End.
