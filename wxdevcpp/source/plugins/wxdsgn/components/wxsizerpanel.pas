 { ****************************************************************** }
 {                                                                    }
 {   $Id: wxsizerpanel.pas 936 2007-05-15 03:47:39Z gururamnath $    }
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

Unit WxSizerPanel;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, ExtCtrls;

Type
    TWxSizerPanel = Class(TPanel)
    Private
    { Private fields of TWxSizerPanel }

    { Private methods of TWxSizerPanel }

    Protected
    { Protected fields of TWxSizerPanel }

    { Protected methods of TWxSizerPanel }
        Procedure Click; Override;
        Procedure KeyPress(Var Key: Char); Override;
        Procedure Loaded; Override;
        Procedure Paint; Override;

    Public
    { Public fields and properties of TWxSizerPanel }

    { Public methods of TWxSizerPanel }
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;

    Published
    { Published properties of TWxSizerPanel }
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

    End;

Procedure Register;

Implementation

Procedure Register;
Begin
     { Register TWxSizerPanel with Standard as its
       default page on the Delphi component palette }
    RegisterComponents('Standard', [TWxSizerPanel]);
End;

{ Override OnClick handler from TPanel }
Procedure TWxSizerPanel.Click;
Begin
    Inherited Click;
End;

{ Override OnKeyPress handler from TPanel }
Procedure TWxSizerPanel.KeyPress(Var Key: Char);
Begin
    Inherited KeyPress(Key);
End;

Constructor TWxSizerPanel.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);
End;

Destructor TWxSizerPanel.Destroy;
Begin
    Inherited Destroy;
End;

Procedure TWxSizerPanel.Loaded;
Begin
    Inherited Loaded;
End;

Procedure TWxSizerPanel.Paint;
Begin
    Inherited Paint;
End;


End.
