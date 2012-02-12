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

Unit UStrings;

Interface

Uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, Buttons, ExtCtrls, XPMenu;

Type
    TStringsForm = Class(TForm)
        btnOK: TBitBtn;
        btnCancel: TBitBtn;
        btnHelp: TBitBtn;
        grpMemo: TGroupBox;
        Memo: TMemo;
        XPMenu: TXPMenu;

        Procedure MemoChange(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
    Private
    { Private declarations }
    Public
    { Public declarations }
        OnContentsChanged: TNotifyEvent;
    End;

Var
    StringsForm: TStringsForm;

Implementation
{uses
  devCfg;} // EAB TODO: Fix this

{$R *.DFM}

Procedure TStringsForm.MemoChange(Sender: TObject);
Var
    lbl: String;
Begin
    If Memo.Lines.Count = 1 Then
        lbl := ' Line'
    Else
        lbl := ' Lines';

    grpMemo.Caption := IntToStr(Memo.Lines.Count) + lbl;

    //Broadcast the event
    If Assigned(OnContentsChanged) Then
        OnContentsChanged(Sender);
End;

Procedure TStringsForm.FormCreate(Sender: TObject);
Begin
    DesktopFont := True;
    //XPMenu.Active := devData.XPTheme      EAB TODO: fix
End;

End.
