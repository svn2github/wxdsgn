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

unit UStrings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, XPMenu;

type
  TStringsForm = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnHelp: TBitBtn;
    grpMemo: TGroupBox;
    Memo: TMemo;
    XPMenu: TXPMenu;

    procedure MemoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OnContentsChanged: TNotifyEvent;
  end;

var
  StringsForm: TStringsForm;

implementation
uses
  devCfg;

{$R *.DFM}

procedure TStringsForm.MemoChange(Sender: TObject);
var
  lbl: string;
begin
    if Memo.Lines.Count = 1 then
        lbl := ' Line'
    else
        lbl := ' Lines';
    
    grpMemo.Caption := IntToStr(Memo.Lines.Count) + lbl;

    //Broadcast the event
    if Assigned(OnContentsChanged) then
        OnContentsChanged(Sender);
end;

procedure TStringsForm.FormCreate(Sender: TObject);
begin
    DesktopFont := True;
    XPMenu.Active := devData.XPTheme
end;

end.
