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

unit ComponentPalette;

interface

uses
  WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, Forms, Graphics,
  ExtCtrls, StdCtrls, ComCtrls, Dialogs, DbugIntf;

type
  TComponentPalette = class(TPanel)
  private
    //Component population
    procedure PopulateComponents;
    function GetAlternateName(Name: string): PChar;
    function GetSelectedComponent: string;

    //Control custom draw etc
    procedure OnStartSearching(Sender: TObject);
    procedure OnSearching(Sender: TObject);
    procedure OnSearched(Sender: TObject);

    procedure tvCollapsed(Sender: TObject; Node: TTreeNode);
    procedure tvExpanded(Sender: TObject; Node: TTreeNode);
  protected
    //Contorl handles
    SearchBox: TEdit;
    ComponentList: TTreeView;
    ComponentImages: TImageList;

    //Special variables
    SearchNode: TTreeNode;
    SearchImage: Integer;
    FolderImage: Integer;
  public
    constructor Create(Panel: TComponent); override;
    destructor Destroy; override;
  published
    property SelectedComponent: string read GetSelectedComponent;
    
    procedure UnselectComponents;
  end;

implementation
uses
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
  WxHyperLinkCtrl, WxDialUpManager, WxHtmlEasyPrinting, WxMediaCtrl, wxAnimationCtrl;

const
  SearchPrompt = '(search component)';

constructor TComponentPalette.Create(Panel: TComponent);
begin
  //Create the base class
  inherited Create(Panel);
  Parent := Panel as TWinControl;
  Name := 'ComponentPalette';

  //Set up the size and alignment
  Align := alClient;
  Top := 0;
  Left := 0;

  //Then create our controls
  SearchBox := TEdit.Create(Self);
  with SearchBox do
  begin
    Align := alTop;
    Parent := Self;
    Width := Self.Width;
    Text := SearchPrompt;

    OnChange := OnSearching;
    OnEnter := OnStartSearching;
    OnExit := OnSearched;
  end;

  //Create our bitmaps for the components
  ComponentImages := TImageList.Create(ComponentList);
  with ComponentImages do
  begin
    Width := 16;
    Height := 16;
  end;

  //And the tree-view browser
  ComponentList := TTreeView.Create(Self);
  with ComponentList do
  begin
    //Alignment and size
    Align := alClient;
    Parent := Self;
    Width := Self.Width;
    ReadOnly := true;

    //Tree-view styles
    RowSelect := True;
    ShowLines := False;
    ShowButtons := False;
    HideSelection := False;
    Images := ComponentImages;

    //Events
    OnCollapsed := tvCollapsed;
    OnExpanded := tvExpanded;
  end;

  //Populate the tree-view
  PopulateComponents;
end;

destructor TComponentPalette.Destroy;
begin
  inherited;
  ComponentImages.Free;
end;

function TComponentPalette.GetAlternateName(Name: string): PChar;
begin
  Name := UpperCase(Name);
  if (Name = 'TWXBOXSIZER') or (Name = 'TWXFLEXGRIDSIZER') or (Name = 'TWXGRIDSIZER') or
     (Name = 'TWXSTATICBOXSIZER') or (Name = 'TWXSTDDIALOGBUTTONSIZER') then
    Result := 'TWXSIZER'
  else if Name = 'TWXBITMAPCOMBOBOX' then
    Result := 'TWXCOMBOBOX'
  else if Name = 'TWXTREELISTCTRL' then
    Result := 'TWXTREECTRL'
  else if Name = 'TWXPASSWORDENTRYDIALOG' then
    Result := 'TWXTEXTENTRYDIALOG'
  else if Name = 'TWXMULTICHOICEDIALOG' then
    Result := 'TWXSINGLECHOICEDIALOG'
  else if (Name = 'TWXOWNERDRAWNCOMBOBOX') or (Name = 'TWXCHOICE') then
    Result := 'TWXCOMBOBOX'
  else if Name = 'TWXSTYLEDTEXTCTRL' then
    Result := 'TWXRICHTEXTCTRL'
  else
    Result := '';
end;

procedure TComponentPalette.PopulateComponents;
var
  ComponentsList, CurrentGroup: TStringList;
  BitmapIndex: Integer;
  CurrentComponent: String;
  ComponentBitmap: TBitmap;
  ParentNode: TTreeNode;
  I, J: Integer;
begin
  SearchNode := nil;
  ComponentBitmap := TBitmap.Create;
  ComponentsList := TStringList.Create;
  try
    //Begin by adding the almighty cursor
    with ComponentList.Items.AddChild(nil, 'Pointer') do
    begin
      //Create the icon
      ComponentBitmap.Transparent := True;
      ComponentBitmap.Handle := LoadBitmap(hInstance, PChar('CURSOR'));

      //Insert the icon into the image list and use it
      BitmapIndex := ComponentImages.AddMasked(ComponentBitmap, clDefault);
      SelectedIndex := BitmapIndex;
      ImageIndex := BitmapIndex;
    end;

    //Then deal with the search icon
    ComponentBitmap.Handle := LoadBitmap(hInstance, PChar('SEARCH'));
    SearchImage := ComponentImages.AddMasked(ComponentBitmap, clFuchsia);

    //Then load the folder icon
    ComponentBitmap.Handle := LoadBitmap(hInstance, PChar('FOLDER'));
    FolderImage := ComponentImages.AddMasked(ComponentBitmap, clDefault);
    ComponentBitmap.Handle := LoadBitmap(hInstance, PChar('SELFOLDER'));
    ComponentImages.AddMasked(ComponentBitmap, clDefault);

    //Sizers
    ComponentsList.Add('Sizers;TwxBoxSizer;TwxStaticBoxSizer;TwxGridSizer;TwxFlexGridSizer;' +
                       'TwxStdDialogButtonSizer');
    //Controls
    ComponentsList.Add('"Common Controls";TwxAnimationCtrl;TwxStaticText;TwxButton;TwxBitmapButton;' +
                       'TwxToggleButton;TwxEdit;TwxMemo;TwxCheckBox;TwxChoice;' +
                       'TwxRadioButton;TwxComboBox;TwxListBox;TwxListCtrl;TwxTreeCtrl;' +
                       'TwxGauge;TwxScrollBar;TwxSpinButton;TwxStaticBox;TwxRadioBox;' +
                       'TwxDatePickerCtrl;TwxSlider;TwxStaticLine;TwxStaticBitmap;' +
                       'TwxStatusBar;TwxCheckListBox;TwxSpinCtrl;TwxRichTextCtrl;' +
                       'TwxCalendarCtrl;TwxOwnerDrawnComboBox;TwxHyperLinkCtrl;' +
                       'TwxDialUpManager;TwxMediaCtrl;TwxBitmapComboBox');
    //Container controls
    ComponentsList.Add('Containers;TwxPanel;TwxChoicebook;TwxListbook;TwxNotebook;TwxTreebook;' +
                        'TwxToolbook;TwxNotebookPage;TwxGrid;TwxScrolledWindow;TwxHtmlWindow;TwxSplitterWindow');
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
                     TwxDialUpManager, TwxHtmlEasyPrinting, TWxMediaCtrl, TwxBitmapComboBox]);

    //Now that the components have been put into it's respective string lists,
    //iterate over all the items, parsing them and putting them into the tree-view
    CurrentGroup := TStringList.Create;
    CurrentGroup.Delimiter := ';';
    try
      for I := 0 to ComponentsList.Count - 1 do
      begin
        //Clear the list
        CurrentGroup.Clear;

        //Then parse the list of strings. The first index is the title of the parent
        CurrentGroup.DelimitedText := ComponentsList[I];

        //Add the parent node                      
        ParentNode := ComponentList.Items.AddChild(nil, CurrentGroup[0]);
        ParentNode.SelectedIndex := FolderImage;
        ParentNode.ImageIndex := FolderImage;

        //And then add the child nodes
        for J := 1 to CurrentGroup.Count - 1 do
        begin
          //First load the bitmap from our application's resource section and add
          //it to our image list
          CurrentComponent := CurrentGroup[J];
          ComponentBitmap.Handle := LoadBitmap(hInstance, PChar(UpperCase(CurrentComponent)));
          ComponentBitmap.Transparent := True;

          //Make sure the component bitmap is valid
          if ComponentBitmap.Width = 0 then
          begin
            //See if we can find alternate names
            ComponentBitmap.Handle := LoadBitmap(hInstance, GetAlternateName(CurrentComponent));
            
            if ComponentBitmap.Width = 0 then
            begin
              //Still zero!
              SendDebug(UpperCase(CurrentComponent));
              Continue;
            end;
          end;
          BitmapIndex := ComponentImages.AddMasked(ComponentBitmap, clFuchsia);

          //Then add the parent node, after which tell the tree-view that we do
          //not want images for the parent
          with ComponentList.Items.AddChild(ParentNode, Copy(CurrentComponent, 2, Length(CurrentComponent))) do
          begin
            SelectedIndex := BitmapIndex;
            ImageIndex := BitmapIndex;
          end;
        end
      end;
    finally
      CurrentGroup.Destroy;
    end;
  finally
    ComponentBitmap.Destroy;
    ComponentsList.Destroy;
  end;

  //Then sort the entries
  for I := 0 to ComponentList.Items.Count - 1 do
    ComponentList.Items[I].AlphaSort;
end;

function TComponentPalette.GetSelectedComponent: string;
begin
  if ComponentList.Selected = nil then
    Result := ''
  else if ComponentList.Selected.Parent = nil then
    Result := '' //Top-level node
  else
    Result := 'T' + ComponentList.Selected.Text;
end;

procedure TComponentPalette.UnselectComponents;
begin
  ComponentList.Selected := ComponentList.Items.GetFirstNode;
end;

procedure TComponentPalette.OnStartSearching(Sender: TObject);
begin
  if SearchBox.Text = SearchPrompt then
    SearchBox.Text := '';
end;

procedure TComponentPalette.OnSearching(Sender: TObject);
  procedure AddSearchResult(Node: TTreeNode);
  begin
    //Add the result
    with ComponentList.Items.AddChild(SearchNode, Node.Text) do
    begin
      ImageIndex := Node.ImageIndex;
      SelectedIndex := Node.SelectedIndex;
    end;
  end;

  procedure CheckNode(Node: TTreeNode);
  var
    Child: TTreeNode;
  begin
    Child := Node.GetFirstChild;
    if Child = nil then
      Exit;

    //Traverse all the entries of the child
    repeat
      if Pos(LowerCase(SearchBox.Text), LowerCase(Child.Text)) > 0 then
        AddSearchResult(Child);
      Child := Child.GetNextSibling;
    until Child = nil;
  end;
var
  Expanded: Boolean;
  CurrentNode: TTreeNode;
begin
  //Don't bother if the searchbox is empty
  if SearchBox.Text = '' then
    Exit;

  //If we have a current search node, clear it. If we don't create it
  ComponentList.Items.BeginUpdate;
  if SearchNode <> nil then
  begin
    Expanded := SearchNode.Expanded;
    SearchNode.DeleteChildren;
  end
  else
  begin
    Expanded := True;
    SearchNode := ComponentList.Items.AddChild(nil, 'Search Results');
    SearchNode.ImageIndex := SearchImage;
    SearchNode.SelectedIndex := SearchImage;
  end;

  //Check the root onwards. Start from the sizers
  CurrentNode := ComponentList.Items.GetFirstNode;
  while (CurrentNode.GetNextSibling <> nil) and (CurrentNode.GetNextSibling <> SearchNode) do
  begin
    CurrentNode := CurrentNode.GetNextSibling;
    CheckNode(CurrentNode);
  end;

  //Do we have any results?
  if SearchNode.GetFirstChild = nil then
    with ComponentList.Items.AddChild(SearchNode, '(no matches)') do
    begin
      ImageIndex := -1;
      SelectedIndex := -1;
    end;

  //Expand or collapse the search results
  SearchNode.Expanded := Expanded;
  ComponentList.Items.EndUpdate;
end;

procedure TComponentPalette.OnSearched(Sender: TObject);
begin
  if SearchBox.Text = '' then
  begin
    SearchBox.Text := SearchPrompt;
    if SearchNode <> nil then
    begin
      SearchNode.Delete;
      SearchNode := nil;
    end;
  end;
end;

procedure TComponentPalette.tvCollapsed(Sender: TObject; Node: TTreeNode);
begin
  if Node.ImageIndex = FolderImage + 1 then
  begin
    Node.ImageIndex := FolderImage;
    Node.SelectedIndex := FolderImage;
  end;
end;

procedure TComponentPalette.tvExpanded(Sender: TObject; Node: TTreeNode);
begin
  if Node.ImageIndex = FolderImage then
  begin
    Node.ImageIndex := FolderImage + 1;
    Node.SelectedIndex := FolderImage + 1;
  end;
end;

end.
