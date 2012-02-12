{
    $Id: ComponentPalette.pas 893 2007-02-20 00:36:21Z gururamnath $

    This file is part of wxDev-C++
    Copyright (c) 2006 wxDev-C++ Developers

    wxDev-C++ is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    wxDev-C++ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with wxDev-C++; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

Unit ComponentPalette;

Interface

Uses
    WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, Forms, Graphics,
    ExtCtrls, StdCtrls, ComCtrls, Dialogs;

Type
    TComponentPalette = Class(TPanel)
    Private
    //Component population
        Procedure PopulateComponents;
        Function GetAlternateName(Name: String): Pchar;
        Function GetSelectedComponent: String;

    //Control custom draw etc
        Procedure OnStartSearching(Sender: TObject);
        Procedure OnSearching(Sender: TObject);
        Procedure OnSearched(Sender: TObject);

        Procedure tvCollapsed(Sender: TObject; Node: TTreeNode);
        Procedure tvExpanded(Sender: TObject; Node: TTreeNode);
        Procedure SelectionChanged(Sender: TObject);
    Protected
    //Contorl handles
        SearchBox: TEdit;
        ComponentList: TTreeView;
        ComponentImages: TImageList;

    //Special variables
        SearchNode: TTreeNode;
        SearchImage: Integer;
        FolderImage: Integer;
    Public
        Constructor Create(Panel: TComponent); Override;
        Destructor Destroy; Override;
    Published
        Property SelectedComponent: String Read GetSelectedComponent;

        Procedure UnselectComponents;
    End;

Implementation
Uses
    ImgList, wxStdDialogButtonSizer, WxBoxSizer, WxStaticBoxSizer, WxGridSizer,
    WxButton, WxBitmapButton, WxCheckBox, WxChoice, WxComboBox, WxBitmapComboBox,
    WxEdit, WxGauge, WxListBox, WxListCtrl, WxMemo, WxRadioButton, WxScrollBar,
    WxGrid, WxSlider, WxSpinButton, WxStaticBitmap, WxStaticBox, WxStaticLine,
    WxStaticText, WxControlPanel, WxTreeCtrl, WxFlexGridSizer, WxPanel,
    wxChoicebook, wxListbook, wxnotebook, wxtreebook, wxtoolbook,
    WxStatusBar, WxToolbar, WxNoteBookPage, WxCheckListBox, WxSpinCtrl,
    WxScrolledWindow, WxHtmlWindow, WxToolButton, WxSeparator, WxPopupMenu, WxMenuBar,
    WxOpenFileDialog, WxSaveFileDialog, WxFontDialog, WxMessageDialog,
    WxProgressDialog, WxPrintDialog, WxFindReplaceDialog, WxDirDialog, WxColourDialog,
    WxPageSetupDialog, WxTimer, WxNonVisibleBaseComponent, WxSplitterWindow,
    WxDatePickerCtrl, WxToggleButton, WxRadioBox, WxOwnerDrawnComboBox, WxSTC,
    WxRichTextCtrl, WxTreeListCtrl, WxCalendarCtrl, WxTextEntryDialog,
    WxPasswordEntryDialog, WxSingleChoiceDialog, WxMultiChoiceDialog, WxCustomButton,
    WxHyperLinkCtrl, WxDialUpManager, WxHtmlEasyPrinting, WxMediaCtrl, wxAnimationCtrl, wxAuiNotebook,
    WxAuiManager, wxAuiBar, wxAuiToolBar, wxAuiNoteBookPage,
    wxRichTextStyleComboCtrl, wxRichTextStyleListCtrl, wxRichTextStyleListBox,
    wxColourPickerCtrl, wxDirPickerCtrl, wxFilePickerCtrl, wxFontPickerCtrl;

Const
    SearchPrompt = '(search component)';

Constructor TComponentPalette.Create(Panel: TComponent);
Begin
  //Create the base class
    Inherited Create(Panel);
    Parent := Panel As TWinControl;
    Name := 'ComponentPalette';

  //Set up the size and alignment
    Align := alClient;
    Top := 0;
    Left := 0;

  //Then create our controls
    SearchBox := TEdit.Create(Self);
    With SearchBox Do
    Begin
        Align := alTop;
        Parent := Self;
        Width := Self.Width;
        Text := SearchPrompt;

        OnChange := OnSearching;
        OnEnter := OnStartSearching;
        OnExit := OnSearched;
    End;

  //Create our bitmaps for the components
    ComponentImages := TImageList.Create(ComponentList);
    With ComponentImages Do
    Begin
        Width := 16;
        Height := 16;
    End;

  //And the tree-view browser
    ComponentList := TTreeView.Create(Self);
    With ComponentList Do
    Begin
    //Alignment and size
        Align := alClient;
        Parent := Self;
        Width := Self.Width;
        ReadOnly := True;

    //Tree-view styles
        RowSelect := True;
        ShowLines := False;
        ShowButtons := False;
        HideSelection := False;
        Images := ComponentImages;

    //Events
        OnCollapsed := tvCollapsed;
        OnExpanded := tvExpanded;
    End;

  //Populate the tree-view
    PopulateComponents;
    ComponentList.OnClick := SelectionChanged;
End;

Destructor TComponentPalette.Destroy;
Begin
    Inherited;
    ComponentImages.Free;
End;

Function TComponentPalette.GetAlternateName(Name: String): Pchar;
Begin
    Name := UpperCase(Name);
    If (Name = 'TWXBOXSIZER') Or (Name = 'TWXFLEXGRIDSIZER') Or (Name = 'TWXGRIDSIZER') Or
        (Name = 'TWXSTATICBOXSIZER') Or (Name = 'TWXSTDDIALOGBUTTONSIZER') Then
        Result := 'TWXSIZER'
    Else
    If (Name = 'TWXBITMAPCOMBOBOX') Or (Name = 'TWXRICHTEXTSTYLECOMBOCTRL') Then
        Result := 'TWXCOMBOBOX'
    Else
    If Name = 'TWXTREELISTCTRL' Then
        Result := 'TWXTREECTRL'
    Else
    If Name = 'TWXPASSWORDENTRYDIALOG' Then
        Result := 'TWXTEXTENTRYDIALOG'
    Else
    If Name = 'TWXMULTICHOICEDIALOG' Then
        Result := 'TWXSINGLECHOICEDIALOG'
    Else
    If (Name = 'TWXOWNERDRAWNCOMBOBOX') Or (Name = 'TWXCHOICE') Then
        Result := 'TWXCOMBOBOX'
    Else
    If Name = 'TWXSTYLEDTEXTCTRL' Then
        Result := 'TWXRICHTEXTCTRL'
    Else
    If Name = 'TWXAUINOTEBOOK' Then
        Result := 'TWXNOTEBOOK'
    Else
    If Name = 'TWXAUINOTEBOOKPAGE' Then
        Result := 'TWXNOTEBOOKPAGE'
    Else
    If Name = 'TWXRICHTEXTSTYLELISTCTRL' Then
        Result := 'TWXLISTCTRL'
    Else
    If Name = 'TWXRICHTEXTSTYLELISTBOX' Then
        Result := 'TWXLISTBOX'
    Else
        Result := '';
End;

Procedure TComponentPalette.PopulateComponents;
Var
    ComponentsList, CurrentGroup: TStringList;
    BitmapIndex: Integer;
    CurrentComponent: String;
    ComponentBitmap: TBitmap;
    ParentNode: TTreeNode;
    I, J: Integer;
Begin
    SearchNode := Nil;
    ComponentBitmap := TBitmap.Create;
    ComponentsList := TStringList.Create;
    Try
    //Begin by adding the almighty cursor
        With ComponentList.Items.AddChild(Nil, 'Pointer') Do
        Begin
      //Create the icon
            ComponentBitmap.Transparent := True;
            ComponentBitmap.Handle := LoadBitmap(hInstance, Pchar('CURSOR'));

      //Insert the icon into the image list and use it
            BitmapIndex := ComponentImages.AddMasked(ComponentBitmap, clDefault);
            SelectedIndex := BitmapIndex;
            ImageIndex := BitmapIndex;
        End;

    //Then deal with the search icon
        ComponentBitmap.Handle := LoadBitmap(hInstance, Pchar('SEARCH'));
        SearchImage := ComponentImages.AddMasked(ComponentBitmap, clFuchsia);

    //Then load the folder icon
        ComponentBitmap.Handle := LoadBitmap(hInstance, Pchar('FOLDER'));
        FolderImage := ComponentImages.AddMasked(ComponentBitmap, clDefault);
        ComponentBitmap.Handle := LoadBitmap(hInstance, Pchar('SELFOLDER'));
        ComponentImages.AddMasked(ComponentBitmap, clDefault);

    //Sizers
        ComponentsList.Add('Sizers;TwxBoxSizer;TwxStaticBoxSizer;TwxGridSizer;TwxFlexGridSizer;' +
            'TwxStdDialogButtonSizer');
    //Controls
        ComponentsList.Add('"Common Controls";TwxAnimationCtrl;TwxStaticText;TwxButton;TwxBitmapButton;' +
            'TwxToggleButton;TwxEdit;TwxMemo;TwxCheckBox;TwxChoice;' +
            'TwxRadioButton;TwxComboBox;TwxListBox;TwxListCtrl;TwxTreeCtrl;' +
            'TwxGauge;TwxScrollBar;TwxSpinButton;TwxStaticBox;TwxRadioBox;' +
            'TwxSlider;TwxStaticLine;TwxStaticBitmap;' +
            'TwxStatusBar;TwxCheckListBox;TwxSpinCtrl;TwxRichTextCtrl;' +
            'TwxCalendarCtrl;TwxOwnerDrawnComboBox;TwxHyperLinkCtrl;' +
            'TwxRichTextStyleComboCtrl;TwxRichTextStyleListCtrl;TwxRichTextStyleListBox;' +
            'TwxDialUpManager;TwxMediaCtrl;TwxBitmapComboBox;' +
            'TwxColourPickerCtrl;TwxDatePickerCtrl;TwxDirPickerCtrl;TwxFilePickerCtrl;TwxFontPickerCtrl');
    //Container controls
        ComponentsList.Add('Containers;TwxPanel;TwxChoicebook;TwxListbook;TwxNotebook;TwxTreebook;' +
            'TwxToolbook;TwxNotebookPage;TwxGrid;TwxScrolledWindow;TwxHtmlWindow;' +
            'TwxSplitterWindow;TwxAuiNotebook;TwxAuiNotebookPage');
    //Toolbar controls
        ComponentsList.Add('Toolbars;TwxToolBar;TwxToolButton;TwxSeparator;' +
            'TwxEdit;TwxCheckBox;TwxRadioButton;TwxComboBox;TwxSpinCtrl');
    //Menubar controls
        ComponentsList.Add('Menubars;TwxMenuBar;TwxPopupMenu');
    //Dialogs
        ComponentsList.Add('Dialogs;TwxOpenFileDialog;TwxSaveFileDialog;TwxProgressDialog;' +
            'TwxColourDialog;TwxDirDialog;TwxFindReplaceDialog;TwxFontDialog;' +
            'TwxPageSetupDialog;TwxPrintDialog;TwxMessageDialog;TwxTextEntryDialog;' +
            'TwxPasswordEntryDialog;TwxSingleChoiceDialog;TwxMultiChoiceDialog');
    //Non-visual components
        ComponentsList.Add('Components;TwxTimer;TwxHtmlEasyPrinting');
    //Unofficial components
        ComponentsList.Add('"Unofficial Controls";TwxTreeListCtrl;TwxStyledTextCtrl;TwxCustomButton');
    //wxAui components
        ComponentsList.Add('wxAui Components;TwxAuiManager;TwxAuiBar;TwxAuiToolBar;');

        RegisterClasses([TWxStdDialogButtonSizer, TWxBoxSizer, TWxStaticBoxSizer, TWxGridSizer,
            TWxFlexGridSizer, TWxStaticText, TWxEdit, TWxButton, TWxBitmapButton,
            TWxToggleButton, TWxCheckBox, TWxRadioButton, TWxChoice, TWxComboBox,
            TWxGauge, TWxGrid, TWxListBox, TWXListCtrl, TWxMemo, TWxScrollBar,
            TWxSpinButton, TWxTreeCtrl, TWxRadioBox, TWxStaticBitmap,
            TWxstaticbox, TWxslider, TWxStaticLine, TWxDatePickerCtrl,
            TWxPanel, TWxChoicebook, TwxListbook, TWxNotebook, TWxTreebook, TWxToolbook,
            TWxStatusBar, TWxToolBar, TWxNoteBookPage, TWxAnimationCtrl,
            TWxchecklistbox, TWxSplitterWindow, TWxSpinCtrl, TWxScrolledWindow,
            TWxHtmlWindow, TWxToolButton, TWxSeparator, TWxPopupMenu, TWxMenuBar,
            TWxOpenFileDialog, TWxSaveFileDialog, TWxFontDialog, TwxMessageDialog,
            TWxProgressDialog, TWxPrintDialog, TWxFindReplaceDialog, TWxCustomButton,
            TWxDirDialog, TWxColourDialog, TWxPageSetupDialog, TwxTimer,
            TwxTreeListCtrl, TWxRichTextCtrl, TWxStyledTextCtrl, TWxCalendarCtrl,
            TWxOwnerDrawnComboBox, TWxTextEntryDialog, TWxPasswordEntryDialog,
            TWxSingleChoiceDialog, TWxMultiChoiceDialog, TwxHyperLinkCtrl,
            TwxDialUpManager, TwxHtmlEasyPrinting, TWxMediaCtrl, TwxBitmapComboBox,
            TwxAuiManager, TwxAuiBar, TwxAuiToolBar, TwxAuiNotebook,
            TwxAuiNotebookPage, TwxRichTextStyleComboCtrl, TwxRichTextStyleListBox, TwxRichTextStyleListCtrl,
            TWxColourPickerCtrl, TWxDatePickerCtrl, TwxDirPickerCtrl, TwxFilePickerCtrl, TwxFontPickerCtrl]);

    //Now that the components have been put into it's respective string lists,
    //iterate over all the items, parsing them and putting them into the tree-view
        CurrentGroup := TStringList.Create;
        CurrentGroup.Delimiter := ';';
        Try
            For I := 0 To ComponentsList.Count - 1 Do
            Begin
        //Clear the list
                CurrentGroup.Clear;

        //Then parse the list of strings. The first index is the title of the parent
                CurrentGroup.DelimitedText := ComponentsList[I];

        //Add the parent node                      
                ParentNode := ComponentList.Items.AddChild(Nil, CurrentGroup[0]);
                ParentNode.SelectedIndex := FolderImage;
                ParentNode.ImageIndex := FolderImage;

        //And then add the child nodes
                For J := 1 To CurrentGroup.Count - 1 Do
                Begin
          //First load the bitmap from our application's resource section and add
          //it to our image list
                    CurrentComponent := CurrentGroup[J];
                    ComponentBitmap.Handle := LoadBitmap(hInstance, Pchar(UpperCase(CurrentComponent)));
                    ComponentBitmap.Transparent := True;

          //Make sure the component bitmap is valid
                    If ComponentBitmap.Width = 0 Then
                    Begin
            //See if we can find alternate names
                        ComponentBitmap.Handle := LoadBitmap(hInstance, GetAlternateName(CurrentComponent));

                        If ComponentBitmap.Width = 0 Then
                        Begin
              //Still zero!
             // SendDebug(UpperCase(CurrentComponent));
                            Continue;
                        End;
                    End;
                    BitmapIndex := ComponentImages.AddMasked(ComponentBitmap, clFuchsia);

          //Then add the parent node, after which tell the tree-view that we do
          //not want images for the parent
                    With ComponentList.Items.AddChild(ParentNode, Copy(CurrentComponent, 2, Length(CurrentComponent))) Do
                    Begin
                        SelectedIndex := BitmapIndex;
                        ImageIndex := BitmapIndex;
                    End;
                End;
            End;
        Finally
            CurrentGroup.Destroy;
        End;
    Finally
        ComponentBitmap.Destroy;
        ComponentsList.Destroy;
    End;

  //Then sort the entries
    For I := 0 To ComponentList.Items.Count - 1 Do
        ComponentList.Items[I].AlphaSort;
End;

Function TComponentPalette.GetSelectedComponent: String;
Begin
    If ComponentList.Selected = Nil Then
        Result := ''
    Else
    If ComponentList.Selected.Parent = Nil Then
        Result := '' //Top-level node
    Else
        Result := 'T' + ComponentList.Selected.Text;
End;

Procedure TComponentPalette.UnselectComponents;
Begin
    ComponentList.Selected := ComponentList.Items.GetFirstNode;
End;

Procedure TComponentPalette.OnStartSearching(Sender: TObject);
Begin
    If SearchBox.Text = SearchPrompt Then
        SearchBox.Text := '';
End;

Procedure TComponentPalette.OnSearching(Sender: TObject);
    Procedure AddSearchResult(Node: TTreeNode);
    Begin
    //Add the result
        With ComponentList.Items.AddChild(SearchNode, Node.Text) Do
        Begin
            ImageIndex := Node.ImageIndex;
            SelectedIndex := Node.SelectedIndex;
        End;
    End;

    Procedure CheckNode(Node: TTreeNode);
    Var
        Child: TTreeNode;
    Begin
        Child := Node.GetFirstChild;
        If Child = Nil Then
            Exit;

    //Traverse all the entries of the child
        Repeat
            If Pos(LowerCase(SearchBox.Text), LowerCase(Child.Text)) > 0 Then
                AddSearchResult(Child);
            Child := Child.GetNextSibling;
        Until Child = Nil;
    End;
Var
    Expanded: Boolean;
    CurrentNode: TTreeNode;
Begin
  //Don't bother if the searchbox is empty
    If SearchBox.Text = '' Then
        Exit;

  //If we have a current search node, clear it. If we don't create it
    ComponentList.Items.BeginUpdate;
    If SearchNode <> Nil Then
    Begin
        Expanded := SearchNode.Expanded;
        SearchNode.DeleteChildren;
    End
    Else
    Begin
        Expanded := True;
        SearchNode := ComponentList.Items.AddChild(Nil, 'Search Results');
        SearchNode.ImageIndex := SearchImage;
        SearchNode.SelectedIndex := SearchImage;
    End;

  //Check the root onwards. Start from the sizers
    CurrentNode := ComponentList.Items.GetFirstNode;
    While (CurrentNode.GetNextSibling <> Nil) And (CurrentNode.GetNextSibling <> SearchNode) Do
    Begin
        CurrentNode := CurrentNode.GetNextSibling;
        CheckNode(CurrentNode);
    End;

  //Do we have any results?
    If SearchNode.GetFirstChild = Nil Then
        With ComponentList.Items.AddChild(SearchNode, '(no matches)') Do
        Begin
            ImageIndex := -1;
            SelectedIndex := -1;
        End;

  //Expand or collapse the search results
    SearchNode.Expanded := Expanded;
    ComponentList.Items.EndUpdate;
End;

Procedure TComponentPalette.OnSearched(Sender: TObject);
Begin
    If SearchBox.Text = '' Then
    Begin
        SearchBox.Text := SearchPrompt;
        If SearchNode <> Nil Then
        Begin
            SearchNode.Delete;
            SearchNode := Nil;
        End;
    End;
End;

Procedure TComponentPalette.tvCollapsed(Sender: TObject; Node: TTreeNode);
Begin
    If Node.ImageIndex = FolderImage + 1 Then
    Begin
        Node.ImageIndex := FolderImage;
        Node.SelectedIndex := FolderImage;
    End;
End;

Procedure TComponentPalette.tvExpanded(Sender: TObject; Node: TTreeNode);
Begin
    If Node.ImageIndex = FolderImage Then
    Begin
        Node.ImageIndex := FolderImage + 1;
        Node.SelectedIndex := FolderImage + 1;
    End;
End;

Procedure TComponentPalette.SelectionChanged(Sender: TObject);
Var
    AControlClass: TControlClass;
Begin
    Inherited;

    If Trim(SelectedComponent) = '' Then
        Exit;

  //Make sure that the type of control is valid
    AControlClass := TControlClass(GetClass(SelectedComponent));
    If AControlClass = Nil Then
        Exit;

    Screen.Cursor := crDrag;
End;

End.
