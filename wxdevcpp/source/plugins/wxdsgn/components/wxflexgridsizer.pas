 { ****************************************************************** }
 {                                                                    }
{ $Id: wxflexgridsizer.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
{                                                                    }
{   Copyright © 2003-2007 by Guru Kathiresan                         }
{                                                                    }
{License :                                                           }
{=========                                                           }
{The wx-devC++ Components, Form Designer, Utils classes              }
{are exclusive properties of Guru Kathiresan.                        }
{The code is available in dual Licenses:                             }
{                               1)GPL Compatible  License            }
{                               2)Commercial License                 }
{                                                                    }
{1)GPL License :                                                     }
{ Code can be used in any project as long as the project's sourcecode}
{ is published under GPL license.                                    }
{                                                                    }
{2)Commercial License:                                               }
{Use of code in this file or the one that bear this license text     }
{can be used in Non-GPL projects as long as you get the permission   }
{from the Author - Guru Kathiresan.                                  }
{Use of the Code in any non-gpl projects without the permission of   }
{the author is illegal.                                              }
{Contact gururamnath@yahoo.com for details                           }
{ ****************************************************************** }

Unit WxFlexGridSizer;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, ExtCtrls, WxUtils, WxSizerPanel, wxAuiManager;

Type
    TWxFlexGridSizer = Class(TWxSizerPanel, IWxComponentInterface,
        IWxContainerAndSizerInterface)
    Private
    { Private fields of TWxFlexGridSizer }
    { Storage for property ColumnSpacing }
        FColumnSpacing: Integer;
    { Storage for property Columns }
        FColumns: Integer;
    { Storage for property RowSpacing }
        FRowSpacing: Integer;
    { Storage for property Rows }
        FRows: Integer;
    { Storage for property FWx_Border }
        FWx_Border: Integer;
    { Storage for property Wx_Class }
        FWx_Class: String;
    { Storage for property Wx_ControlOrientation }
        FWx_ControlOrientation: TWxControlOrientation;
    { Storage for property Wx_EventList }
        FWx_EventList: TStringList;
    { Storage for property Wx_IDName }
        FWx_IDName: String;
    { Storage for property Wx_IDValue }
        FWx_IDValue: Integer;
    { Storage for property Wx_StretchFactor }
        FWx_StretchFactor: Integer;
        FWx_PropertyList: TStringList;
        FInvisibleBGColorString: String;
        FInvisibleFGColorString: String;
        FWx_Alignment: TWxSizerAlignmentSet;
        FWx_BorderAlignment: TWxBorderAlignment;

    { Private methods of TWxFlexGridSizer }
    { Method to set variable and property values and create objects }
        Procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
        Procedure AutoDestroy;
    { Write method for property Wx_EventList }
        Procedure SetWx_EventList(Value: TStringList);

    Protected
    { Protected fields of TWxFlexGridSizer }

    { Protected methods of TWxFlexGridSizer }

    Public
    { Public fields and properties of TWxFlexGridSizer }

    { Public methods of TWxFlexGridSizer }
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Function GenerateControlIDs: String;
        Function GenerateEnumControlIDs: String;
        Function GenerateEventTableEntries(CurrClassName: String): String;
        Function GenerateGUIControlCreation: String;
        Function GenerateXRCControlCreation(IndentString: String): TStringList;
        Function GenerateGUIControlDeclaration: String;
        Function GenerateHeaderInclude: String;
        Function GenerateImageInclude: String;
        Function GetEventList: TStringList;
        Function GetIDName: String;
        Function GetIDValue: Integer;
        Function GetParameterFromEventName(EventName: String): String;
        Function GetPropertyList: TStringList;
        Function GetTypeFromEventName(EventName: String): String;
        Function GetWxClassName: String;
        Procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
        Procedure SetIDName(IDName: String);
        Procedure SetIDValue(IDValue: Integer);
        Procedure SetWxClassName(wxClassName: String);
        Function GetFGColor: String;
        Procedure SetFGColor(strValue: String);
        Function GetBGColor: String;
        Procedure SetBGColor(strValue: String);

        Function GetGenericColor(strVariableName: String): String;
        Procedure SetGenericColor(strVariableName, strValue: String);

        Procedure WMPaint(Var Message: TWMPaint); Message WM_PAINT;
        Function maxHeightOfRow(rowIndex: Integer): Integer;
        Function maxWidthOfColumn(colIndex: Integer): Integer;
        Function GenerateLastCreationCode: String;

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

    Published
    { Published properties of TWxFlexGridSizer }
        Property OnClick;
        Property OnDblClick;
        Property OnDragDrop;
        Property OnEnter;
        Property OnExit;
        Property OnKeyDown;
        Property OnKeyPress;
        Property OnKeyUp;
        Property OnMouseDown;
        Property OnMouseMove;
        Property OnMouseUp;
        Property OnResize;
        Property ColumnSpacing: Integer Read FColumnSpacing Write FColumnSpacing Default 0;
        Property Columns: Integer Read FColumns Write FColumns Default 2;
        Property RowSpacing: Integer Read FRowSpacing Write FRowSpacing Default 0;
        Property Rows: Integer Read FRows Write FRows Default 2;
        Property Wx_Class: String Read FWx_Class Write FWx_Class;
        Property Wx_ControlOrientation: TWxControlOrientation
            Read FWx_ControlOrientation Write FWx_ControlOrientation;
        Property Wx_EventList: TStringList Read FWx_EventList Write SetWx_EventList;
        Property Wx_IDName: String Read FWx_IDName Write FWx_IDName;
        Property Wx_IDValue: Integer Read FWx_IDValue Write FWx_IDValue Default -1;

        Property InvisibleBGColorString: String Read FInvisibleBGColorString Write FInvisibleBGColorString;
        Property InvisibleFGColorString: String Read FInvisibleFGColorString Write FInvisibleFGColorString;

        Property Wx_Border: Integer Read GetBorderWidth Write SetBorderWidth Default 5;
        Property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment Default [wxALL];
        Property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment Default [wxALIGN_CENTER];
        Property Wx_StretchFactor: Integer Read GetStretchFactor Write SetStretchFactor Default 0;
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
     { Register TWxFlexGridSizer with Standard as its
       default page on the Delphi component palette }
    RegisterComponents('Standard', [TWxFlexGridSizer]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxFlexGridSizer.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FColumnSpacing := 0;
    FColumns := 2;
    FRowSpacing := 0;
    FRows := 2;
    Wx_Border := 5;
    FWx_Class := 'wxFlexGridSizer';
    FWx_EventList := TStringList.Create;
    FWx_BorderAlignment := [wxAll];
    FWx_Alignment := [wxALIGN_CENTER];
    FWx_IDValue := -1;
    FWx_StretchFactor := 0;
End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxFlexGridSizer.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_EventList.Destroy;
End; { of AutoDestroy }

{ Write method for property Wx_EventList }
Procedure TWxFlexGridSizer.SetWx_EventList(Value: TStringList);
Begin
  //Use Assign method because TStringList is an object type and FWx_EventList
  //has been created.
    FWx_EventList.Assign(Value);
End;

Constructor TWxFlexGridSizer.Create(AOwner: TComponent);
Begin
  { Call the Create method of the container's parent class       }
    Inherited Create(AOwner);

  { AutoInitialize sets the initial values of variables          }
  { (including subcomponent variables) and properties;           }
  { also, it creates objects for properties of standard          }
  { Delphi object types (e.g., TFont, TTimer, TPicture)          }
  { and for any variables marked as objects.                     }
  { AutoInitialize method is generated by Component Create.      }
    AutoInitialize;

  { Code to perform other tasks when the container is created    }
    FWx_PropertyList.add('Wx_Class:Base Class');
    FWx_PropertyList.add('Wx_IDName:ID Name');
    FWx_PropertyList.add('Wx_IDValue:ID Value');

    FWx_PropertyList.add('Wx_StretchFactor:Stretch Factor');
    FWx_PropertyList.add('Wx_Alignment:Alignment');
    FWx_PropertyList.Add('wxALIGN_LEFT:wxALIGN_LEFT');
    FWx_PropertyList.Add('wxALIGN_RIGHT:wxALIGN_RIGHT');
    FWx_PropertyList.Add('wxALIGN_TOP:wxALIGN_TOP');
    FWx_PropertyList.Add('wxALIGN_BOTTOM:wxALIGN_BOTTOM');
    FWx_PropertyList.Add('wxALIGN_CENTER:wxALIGN_CENTER');
    FWx_PropertyList.Add('wxALIGN_CENTER_HORIZONTAL:wxALIGN_CENTER_HORIZONTAL');
    FWx_PropertyList.Add('wxALIGN_CENTER_VERTICAL:wxALIGN_CENTER_VERTICAL');
    FWx_PropertyList.Add('wxEXPAND:wxEXPAND');
    FWx_PropertyList.add('Wx_Border:Border');
    FWx_PropertyList.add('Wx_BorderAlignment:Borders');
    FWx_PropertyList.add('wxALL:wxALL');
    FWx_PropertyList.add('wxTOP:wxTOP');
    FWx_PropertyList.add('wxLEFT:wxLEFT');
    FWx_PropertyList.add('wxRIGHT:wxRIGHT');
    FWx_PropertyList.add('wxBOTTOM:wxBOTTOM');

    FWx_PropertyList.add('Name:Name');
    FWx_PropertyList.add('Columns:Columns');
    FWx_PropertyList.add('ColumnSpacing:Column Spacing');
    FWx_PropertyList.add('Rows:Rows');
    FWx_PropertyList.add('RowSpacing:Row Spacing');



End;

Destructor TWxFlexGridSizer.Destroy;
Begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
    AutoDestroy;

  { Here, free any other dynamic objects that the component methods  }
  { created but have not yet freed.  Also perform any other clean-up }
  { operations needed before the component is destroyed.             }

  { Last, free the component by calling the Destroy method of the    }
  { parent class.                                                    }
    Inherited Destroy;
End;


Function TWxFlexGridSizer.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxFlexGridSizer.GenerateControlIDs: String;
Begin
    Result := '';
End;

Function TWxFlexGridSizer.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxFlexGridSizer.GenerateXRCControlCreation(IndentString: String): TStringList;
Var
    i: Integer;
    wxcompInterface: IWxComponentInterface;
    tempstring: TStringList;
Begin

    Result := TStringList.Create;

    Try
        If Not (self.Parent Is TForm) Then //NUKLEAR ZELPH
        Begin
            Result.Add(IndentString + Format('<object class="%s" name="%s">',
                [self.Wx_Class, self.Name]));
            Result.Add(IndentString + Format('  <rows>%d</rows>', [self.rows]));
            Result.Add(IndentString + Format('  <cols>%d</cols>', [self.columns]));
            Result.Add(IndentString + Format('  <vgap>%d</vgap>', [self.rowSpacing]));
            Result.Add(IndentString + Format('  <hgap>%d</hgap>', [self.columnSpacing]));
        End;//NUKLEAR ZELPH

        For i := 0 To self.ControlCount - 1 Do // Iterate
            If self.Controls[i].GetInterface(IID_IWxComponentInterface, wxcompInterface) Then
        // Only add the XRC control if it is a child of the top-most parent (the form)
        //  If it is a child of a sizer, panel, or other object, then it's XRC code
        //  is created in GenerateXRCControlCreation of that control.
                If (self.Controls[i].GetParentComponent.Name = self.Name) Then
                Begin
	                   tempstring := TStringList.Create;
	                   If (self.Parent Is TForm) Then
                    Begin
	                       tempstring.Add('    ' + IndentString + '<!--sizeritem-->');
	                       tempstring.Add('      ' + IndentString + '<!--option>' + IntToStr(wxcompInterface.GetStretchFactor) + '</option-->');
	                       tempstring.Add('      ' + IndentString + '<!--border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border-->');
	                       tempstring.Add('      ' + IndentString + '<!--flag>' + BorderAlignmentToStr(wxcompInterface.GetBorderAlignment) + '</flag-->');
	                   End
	                   Else
	                   Begin
	                       tempstring.Add('    ' + IndentString + '<sizeritem>');
	                       tempstring.Add('      ' + IndentString + '<option>' + IntToStr(wxcompInterface.GetStretchFactor) + '</option>');
	                       tempstring.Add('      ' + IndentString + '<border>' + IntToStr(wxcompInterface.GetBorderWidth) + '</border>');
	                       tempstring.Add('      ' + IndentString + '<flag>' + BorderAlignmentToStr(wxcompInterface.GetBorderAlignment) + '</flag>');
	                   End;
	                   tempstring.AddStrings(wxcompInterface.GenerateXRCControlCreation('        ' + IndentString));
	                   If (self.Parent Is TForm) Then
	                       tempstring.Add('    ' + IndentString + '<!--/sizeritem-->')
	                   Else
	                       tempstring.Add('    ' + IndentString + '</sizeritem>');

                    Try
                        Result.AddStrings(tempstring);
                    Finally
                        tempstring.Free
                    End;
                End; // for

        If (self.Parent Is TForm) Then //NUKLEAR ZELPH
            Result.Add(IndentString + '<!--/object-->')
        Else
            Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxFlexGridSizer.GenerateGUIControlCreation: String;

    Function HasAuiManagedForm: Boolean;
    Var
        I: Integer;
        isAuimanagerAvailable: Boolean;
        wxAuimanagerInterface: IWxAuiManagerInterface;
    Begin
        isAuimanagerAvailable := False;
        If self.Parent.Parent Is TForm Then
        Begin
      //MN detect whether there is a wxAuiManager component
            For I := self.Parent.Parent.ComponentCount - 1 Downto 0 Do // Iterate
            Begin
                If self.Parent.Parent.Components[i].ClassName = 'TWxAuiManager' Then
        //if self.Parent.Parent.Components[i].GetInterface(IID_IWxAuiManagerInterface, wxAuimanagerInterface) then
                    isAuimanagerAvailable := True;
                break;
            End; // for
        End;
        Result := isAuimanagerAvailable;
    End;

Var
    strAlignment: String;
    parentName: String;
Begin
    If Not (XRCGEN) Or ((XRCGEN) And (self.Parent Is TForm)) Then //NUKLEAR ZELPH
    Begin
        Result := Format('%s = new wxFlexGridSizer(%d, %d, %d, %d);',
            [self.Name, 0, self.columns, self.rowSpacing, self.columnSpacing]);
        If ((self.Parent Is TForm) Or (IsControlWxContainer(self.Parent))) Then
        Begin
            If (self.Parent Is TForm) Then
                parentName := 'this'
            Else
            If (self.Parent.ClassName = 'TWxPanel') Then
                If self.Parent.Parent Is TForm And Not HasAuiManagedForm Then
	                   parentName := self.Parent.Name  //'this'
                Else
                If (self.Parent.Parent.ClassName <> 'TWxNotebook') Then
	                   parentName := self.Parent.Name
                Else
	                   parentName := self.Parent.Parent.Name
            Else
                parentName := self.Parent.Name;

            If parentName = '' Then
                parentName := self.Parent.Name;


            Result := Result + #13 + Format('%s->SetSizer(%s);', [parentName, self.Name]);
            Result := Result + #13 + Format('%s->SetAutoLayout(true);', [parentName]);
        End
        Else
        Begin
            strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
            Result := Result + #13 + Format('%s->Add(%s, %d, %s, %d);',
                [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
                self.Wx_Border]);
        End;
    End;//NUKLEAR ZELPH
End;

Function TWxFlexGridSizer.GenerateGUIControlDeclaration: String;
Begin
    If Not (XRCGEN) Or ((XRCGEN) And (self.Parent Is TForm)) Then //NUKLEAR ZELPH
        Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
End;

Function TWxFlexGridSizer.GenerateHeaderInclude: String;
Begin
    Result := '#include <wx/sizer.h>';
End;

Function TWxFlexGridSizer.GenerateImageInclude: String;
Begin

End;

Function TWxFlexGridSizer.GetEventList: TStringList;
Begin
    Result := Wx_EventList;
End;

Function TWxFlexGridSizer.GetIDName: String;
Begin
    Result := wx_IDName;
End;

Function TWxFlexGridSizer.GetIDValue: Integer;
Begin
    Result := wx_IDValue;
End;

Function TWxFlexGridSizer.GetParameterFromEventName(EventName: String): String;
Begin
    If EventName = 'EVT_BUTTON' Then
    Begin
        Result := 'wxCommandEvent& event';
        exit;
    End;
    If EventName = 'EVT_UPDATE_UI' Then
    Begin
        Result := 'wxUpdateUIEvent& event';
        exit;
    End;

End;

Function TWxFlexGridSizer.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxFlexGridSizer.GetStretchFactor: Integer;
Begin
    Result := FWx_StretchFactor;
End;

Function TWxFlexGridSizer.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxFlexGridSizer.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := FWx_BorderAlignment;
End;

Procedure TWxFlexGridSizer.SetBorderAlignment(border: TWxBorderAlignment);
Begin
    FWx_BorderAlignment := border;
End;

Function TWxFlexGridSizer.GetBorderWidth: Integer;
Begin
    Result := FWx_Border;
End;

Procedure TWxFlexGridSizer.SetBorderWidth(width: Integer);
Begin
    FWx_Border := width;
End;

Function TWxFlexGridSizer.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxFlexGridSizer';
    Result := wx_Class;
End;

Procedure TWxFlexGridSizer.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin
    wx_ControlOrientation := ControlOrientation;
End;

Procedure TWxFlexGridSizer.SetIDName(IDName: String);
Begin
    wx_IDName := IDName;
End;

Procedure TWxFlexGridSizer.SetIDValue(IDValue: Integer);
Begin
    Wx_IDValue := IDVAlue;
End;

Procedure TWxFlexGridSizer.SetStretchFactor(intValue: Integer);
Begin
    FWx_StretchFactor := intValue;
End;

Procedure TWxFlexGridSizer.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Procedure TWxFlexGridSizer.WMPaint(Var Message: TWMPaint);
Var
    i, j: Integer;
    oriRows: Integer;
    rowCount, colCount: Integer;
    coordTop, coordLeft: Integer;
    tmpHtofRow, tmpWtofCol: Integer;
    totalmaxWidth, totalmaxHt: Integer;
    controlWidth, controlHeight: Integer;

    cntIntf: IWxContainerInterface;
    wxCompInterface: IWxComponentInterface;
    splitIntf: IWxSplitterInterface;
Begin
    self.Caption := '';

  //Calculate the number of rows ths control has
    oriRows := self.ControlCount Div self.Columns;
    If oriRows * self.Columns < self.ControlCount Then
        oriRows := oriRows + 1;

  //Determine the maximum height
    totalmaxHt := 0;
    For i := 0 To oriRows - 1 Do
    Begin
        tmpHtofRow := maxHeightOfRow(i);
        totalmaxHt := totalmaxHt + tmpHtofRow + RowSpacing;
    End;

  //And the maximum width
    totalmaxWidth := 0;
    For i := 0 To columns - 1 Do
    Begin
        tmpWtofCol := maxWidthOfColumn(i);
        totalmaxWidth := totalmaxWidth + tmpWtofCol + ColumnSpacing;
    End;

  //Remove the column spacing from the last column and row
    If columns <> 0 Then
        totalmaxWidth := totalmaxWidth - ColumnSpacing;
    If oriRows <> 0 Then
        totalmaxHt := totalmaxHt - RowSpacing;

    If self.Parent Is TForm Then
    Begin
        self.Align := alClient;
    End
    Else
    Begin
        If self.parent.GetInterface(IDD_IWxContainerInterface, cntIntf) Then
        Begin
            If self.parent.GetInterface(IID_IWxSplitterInterface, splitIntf) Then
            Begin
                self.Align := alNone;
            End
            Else
                self.Align := alClient;
        End
        Else
            self.Align := alNone;

        If totalmaxWidth = 0 Then
            self.Width := 20
        Else
            self.Width := totalmaxWidth;

        If totalmaxht = 0 Then
            self.Height := 20
        Else
            self.Height := totalmaxHt;
    End;

    colCount := 0;
    rowCount := 0;

    For i := 0 To self.ControlCount - 1 Do
    Begin
    //Skip nonvisible controls
        If IsControlWxNonVisible(Controls[i]) Then
            continue;

    //Calculate the base position of the control
        coordTop := 0;
        coordLeft := 0;
        For j := 0 To rowCount - 1 Do
            coordTop := coordTop + maxHeightOfRow(j) + RowSpacing;
        For j := 0 To colCount - 1 Do
            coordLeft := coordLeft + maxWidthOfColumn(j) + ColumnSpacing;

    //Calculate the base dimensions of the control
        controlWidth := Controls[i].Width;
        controlHeight := Controls[i].Height;

    //Add the control's borders
        If Controls[i].GetInterface(IID_IWxComponentInterface, wxCompInterface) Then
        Begin
            If (wxTOP In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment) Then
            Begin
                coordTop := coordTop + wxCompInterface.GetBorderWidth;
                controlHeight := controlHeight + wxCompInterface.GetBorderWidth;
            End;
            If (wxBOTTOM In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment) Then
                controlHeight := controlHeight + wxCompInterface.GetBorderWidth;
            If (wxLEFT In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment) Then
            Begin
                coordLeft := coordLeft + wxCompInterface.GetBorderWidth;
                controlWidth := controlWidth + wxCompInterface.GetBorderWidth;
            End;
            If (wxRIGHT In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment) Then
                controlWidth := controlWidth + wxCompInterface.GetBorderWidth;
        End;

    //Then centre the control
        coordTop := coordTop + (maxHeightOfRow(rowCount) - controlHeight) Div 2;
        coordLeft := coordLeft + (maxWidthOfColumn(colCount) - controlWidth) Div 2;

    //Move the control to the given position
        self.Controls[i].Top := coordTop;
        self.Controls[i].left := coordLeft;

    //Increment the column that we want to fill
        Inc(colCount);

    //Increment the row if we are done with the current row
        If colCount >= Columns Then
        Begin
            colCount := 0;
            Inc(rowCount);
        End;
    End;

    Inherited;

End;

Function TWxFlexGridSizer.maxHeightOfRow(rowIndex: Integer): Integer;
Var
    controlHeight: Integer;
    startItem, endItem, i: Integer;
    wxCompInterface: IWxComponentInterface;
Begin
    startItem := rowIndex * columns;
    endItem := rowIndex * columns + columns - 1;
    Result := 0;

  //Do we have controls in the first place?
    If startItem > ControlCount Then
        Exit;

  //Make sure the end item is lesser than the number of controls
    If endItem >= self.ControlCount Then
        endItem := self.ControlCount - 1;
    For i := startItem To endItem Do
    Begin
        If IsControlWxNonVisible(Controls[i]) Then
            continue;

    //Calculate the height of this control
        controlHeight := self.Controls[i].Height;

    //Add the child's borders
        If Controls[i].GetInterface(IID_IWxComponentInterface, wxCompInterface) Then
        Begin
            If (wxTOP In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment) Then
            Begin
                controlHeight := controlHeight + wxCompInterface.GetBorderWidth;
            End;
            If (wxBOTTOM In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment) Then
            Begin
                controlHeight := controlHeight + wxCompInterface.GetBorderWidth;
            End;
        End;

    //And see if the height is greatere than the original
        If Result < controlHeight Then
            Result := controlHeight;
    End;
End;

Function TWxFlexGridSizer.maxWidthOfColumn(colIndex: Integer): Integer;
Var
    i: Integer;
    controlWidth: Integer;
    wxCompInterface: IWxComponentInterface;
Begin
    Result := 0;
    i := colIndex;

    While i < self.ControlCount Do
    Begin
        If IsControlWxNonVisible(Controls[i]) Then
            continue;

    //Calculate the width of this control
        controlWidth := self.Controls[i].Width;

    //Add the borders
        If Controls[i].GetInterface(IID_IWxComponentInterface, wxCompInterface) Then
        Begin
            If (wxLEFT In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment) Then
            Begin
                controlWidth := controlWidth + wxCompInterface.GetBorderWidth;
            End;
            If (wxRIGHT In wxCompInterface.GetBorderAlignment) Or (wxALL In wxCompInterface.GetBorderAlignment) Then
            Begin
                controlWidth := controlWidth + wxCompInterface.GetBorderWidth;
            End;
        End;

    //Update the result
        If Result < controlWidth Then
            Result := controlWidth;

    //Increment the current control
        i := i + self.Columns;
    End;
End;

Function TWxFlexGridSizer.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxFlexGridSizer.SetGenericColor(strVariableName, strValue: String);
Begin

End;

Function TWxFlexGridSizer.GetFGColor: String;
Begin
End;

Procedure TWxFlexGridSizer.SetFGColor(strValue: String);
Begin
End;

Function TWxFlexGridSizer.GetBGColor: String;
Begin
End;

Procedure TWxFlexGridSizer.SetBGColor(strValue: String);
Begin
End;

Function TWxFlexGridSizer.GenerateLastCreationCode: String;
Begin
    Result := '';
End;

End.
