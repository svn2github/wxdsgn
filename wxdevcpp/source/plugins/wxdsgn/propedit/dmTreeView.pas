Unit dmTreeView;

Interface

Uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ComCtrls, XPMenu;

Type
    TTreeEditor = Class(TForm)
        GroupBox1: TGroupBox;
        teNewItem: TButton;
        teNewSubItem: TButton;
        teDelete: TButton;
        TreeView1: TTreeView;
        GroupBox2: TGroupBox;
        teItemText: TEdit;
        teImageIndex: TEdit;
        Label1: TLabel;
        Label2: TLabel;
        teOK: TButton;
        teCancel: TButton;
        XPMenu1: TXPMenu;
        Procedure teNewItemClick(Sender: TObject);
        Procedure teNewSubItemClick(Sender: TObject);
        Procedure teDeleteClick(Sender: TObject);
        Procedure teOnClickEvent(Sender: TObject);
        Procedure teOnKeyPressEvent(Sender: TObject; Var Key: Char);
        Procedure teOnCreate(Sender: TObject);
    Private
    { Private declarations }
    Public
    { Public declarations }
    End;

Var
    TreeEditor: TTreeEditor;

Implementation

Uses
    wxdesigner;

{$R *.dfm}

Procedure TTreeEditor.teNewItemClick(Sender: TObject);
Begin

    If (TreeView1.Selected = Nil) Then
        TreeView1.Items.Add(TreeView1.Items.GetFirstNode, teItemText.Text)
    Else
        TreeView1.Items.Add(TreeView1.Selected, teItemText.Text);

End;

Procedure TTreeEditor.teNewSubItemClick(Sender: TObject);
Begin
    If (TreeView1.Selected = Nil) Then
        TreeView1.Items.AddChild(TreeView1.Items.GetFirstNode, teItemText.Text)
    Else
        TreeView1.Items.AddChild(TreeView1.Selected, teItemText.Text);

End;

Procedure TTreeEditor.teDeleteClick(Sender: TObject);
Begin
    If (TreeView1.Selected <> Nil) Then
        TreeView1.Items.Delete(TreeView1.Selected);
End;

Procedure TTreeEditor.teOnClickEvent(Sender: TObject);
Begin
    If (TreeView1.Selected <> Nil) Then
        teItemText.Text := TreeView1.Selected.Text;
End;

Procedure TTreeEditor.teOnKeyPressEvent(Sender: TObject; Var Key: Char);
Begin
    If (TreeView1.Selected <> Nil) Then
        teItemText.Text := TreeView1.Selected.Text;
End;

Procedure TTreeEditor.teOnCreate(Sender: TObject);
Begin
    DesktopFont := True;
    XPMenu1.Active := wx_designer.XPTheme;
End;

End.
