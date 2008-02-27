unit wxeditor;

interface

uses
    Windows, Controls, Forms, ComCtrls, Graphics, SysUtils, Menus,
    Designerfrm, CompFileIo,
    wxutils, DbugIntf, SynEdit, wxversion, MigrateFrm;

type

  TWXEditor = class
    fDesigner: TfrmNewForm;
    fScrollDesign: TScrollBox;

    //Guru's Code
  private
    fDesignerClassName, fDesignerTitle: string;
    fDesignerStyle: TWxDlgStyleSet;
    fDesignerDefaultData: Boolean;
    procedure Close; // New fnc for wx
  public
    FileName: String;
    function GetDesigner: TfrmNewForm;
    procedure InitDesignerData(strFName, strCName, strFTitle: string; dlgSStyle:TWxDlgStyleSet);
    function GetDesignerHPPFileName: string;
    function GetDesignerCPPFileName: string;
    procedure ReloadForm;
    procedure ReloadFormFromFile(strFilename:String);
    procedure Init(fTabSheet: TTabSheet; var fText: TSynEdit; DesignerPopup: TPopUpMenu; DoOpen: boolean; fName: String);
    //procedure Reload;
    procedure Terminate;
    function GetDefaultText: String;
    function IsDesignerNil: Boolean;
    //function GetType(fFileName: String);  <-- EAB: not needed .. ?

    
    end;

implementation

uses
    wxdesigner;

   {function TWXEditor.GetType(fFileName: String)  <-- EAB Maybe not needed
   begin }
      {if iswxForm(fFileName) then
        fEditorType := etForm
      else
        fEditorType := etSource;  }
   //end;

   procedure TWXEditor.Init(fTabSheet: TTabSheet; var fText: TSynEdit; DesignerPopup: TPopUpMenu; DoOpen: boolean; fName: String);
   begin
	  //if fEditorType = etForm then
	  //begin
	    //Dont allow anyone to edit the text content
        FileName := fName;
	    //fText.ReadOnly := true;
	    fScrollDesign := TScrollBox.Create(fTabSheet);
	    fScrollDesign.Parent := fTabSheet;
	    fScrollDesign.Align := alClient;
	    fScrollDesign.Visible := True;
	    fScrollDesign.Color := clWhite;

	    fDesigner := TfrmNewForm.Create(fScrollDesign);
	    //fDesigner.Parent:=fScrollDesign;
	    fDesigner.synEdit := fText;
	    fDesigner.Visible := False;

	    SetWindowLong(fDesigner.Handle, GWL_STYLE, WS_CHILD or
	      (GetWindowLong(fDesigner.Handle, GWL_STYLE)));
	    Windows.SetParent(fDesigner.Handle, fScrollDesign.Handle);
        //wx_designer.ELDesigner1.DesignControl := fDesigner;
        //fDesigner.Visible := True;  // <-- EAB TODO: Check if this should be done
	    ShowWindow(fDesigner.Handle, Sw_ShowNormal);

	    fScrollDesign.ScrollInView(fDesigner);

	    fScrollDesign.HorzScrollBar.Visible:=true;
	    fScrollDesign.VertScrollBar.Visible:=true;
	    fScrollDesign.AutoScroll:=true;
	    fScrollDesign.VertScrollBar.Position := fScrollDesign.VertScrollBar.Range;

  if (DoOpen) then
  try
      ReloadForm();
  except
    raise;
  end;

       //fText.Visible := false;
       
       fDesigner.Visible := True;

       fDesigner.Left := 8;
       fDesigner.Top := 8;

       if fDesignerDefaultData then
       begin
         if Trim(fDesignerClassName) <> '' then
           fDesigner.Wx_Name := Trim(fDesignerClassName);

         if Trim(fDesigner.Wx_Name) <> '' then
           fDesigner.Wx_IDName := UpperCase('ID_' + fDesigner.Wx_Name);

         if fDesigner.Wx_IDValue = 0 then
           fDesigner.Wx_IDValue := 1000;

         if fDesignerStyle <> [] then
         fDesigner.Wx_DialogStyle := fDesignerStyle;

         if Trim(fDesignerTitle) <> '' then
           fDesigner.Caption := Self.fDesignerTitle;
       end;

         //fText.Highlighter := wx_designer.main.GetDmMainRes;
         fDesigner.PopupMenu := DesignerPopup;
   end;
   
 procedure TWXEditor.Terminate;
 begin
  //wx_designer.SelectedComponent := nil;
  wx_designer.DisableDesignerControls;
  //wx_designer.ELDesigner1.DesignControl := nil;
  {if Assigned(fDesigner) then
  begin    }
  //fDesigner.Release;
  //FreeAndNil(fDesigner);
  //FreeAndNil(fScrollDesign);
  //end;
 end;
 
 procedure TWXEditor.Close;
 begin
    wx_designer.DisableDesignerControls;
 end;
 
 function TWXEditor.GetDefaultText: String;
 begin
    Result := CompFileIo.ComponentToString(fDesigner);
 end;
 
 function TWXEditor.GetDesigner: TfrmNewForm;
 begin
     Result := fDesigner
 end;

 procedure TWXEditor.InitDesignerData(strFName, strCName, strFTitle: string;
   dlgSStyle: TWxDlgStyleSet);
 begin
   fDesignerClassName := strCName;
   fDesignerTitle := strFTitle;
   fDesignerStyle := dlgSStyle;
   fDesignerDefaultData := True;
 end;

 function TWXEditor.GetDesignerHPPFileName: string;
 begin
 
   if FileExists(ChangeFileExt(FileName, H_EXT)) then
     Result := ChangeFileExt(FileName, H_EXT);
 end;

 function TWXEditor.GetDesignerCPPFileName: string;
 begin
   if FileExists(ChangeFileExt(FileName, CPP_EXT)) then
     Result := ChangeFileExt(FileName, CPP_EXT);
 end;

 procedure TWXEditor.ReloadForm;
 begin
    ReloadFormFromFile(self.FileName);
 end;

procedure TWXEditor.ReloadFormFromFile(strFilename:String);
var
     I:Integer;
begin
   try
     //Delete all the Components and
     for I := self.fDesigner.ComponentCount -1  downto 0 do    // Iterate
     begin
         self.fDesigner.Components[i].Destroy;
     end;    // for
     ReadComponentFromFile(self.fDesigner, strFilename);
  except	// EAB TODO: Check for problems with the except block - 2007
    on e: Exception do
      with TMigrateFrm.Create(Application.MainForm) do
      begin
        Source.Text := strFileName;
        if ShowModal = mrOK then
          ReloadFormFromFile(strFileName);
        
        Destroy;
      end;
  end;	 
end;

function TWXEditor.IsDesignerNil: Boolean;
begin
    if fDesigner <> nil then
      Result := false
    else
      Result := true;
end;

end.
