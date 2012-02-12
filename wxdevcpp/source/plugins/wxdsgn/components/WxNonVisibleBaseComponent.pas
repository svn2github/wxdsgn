// $Id: WxNonVisibleBaseComponent.pas 936 2007-05-15 03:47:39Z gururamnath $
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


Unit WxNonVisibleBaseComponent;

Interface

Uses
    Windows, Messages, SysUtils, Classes, Controls, StdCtrls, Buttons;

Type
    TWxNonVisibleBaseComponent = Class(TBitBtn)
    Private
    { Private declarations }
    Protected
    { Protected declarations }
    Public
    { Public declarations }
        Procedure WMPaint(Var messageV: TWMPaint); Message WM_PAINT;
    Published
        Property Glyph;
    { Published declarations }
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxNonVisibleBaseComponent]);
End;

Procedure TWxNonVisibleBaseComponent.WMPaint(Var messageV: TWMPaint);
Begin
    self.Caption := '';
    self.Height := 27;
    self.Width := 28;
    self.BringToFront;
    SetWindowPos(self.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOACTIVATE Or
        SWP_NOMOVE Or SWP_NOSIZE);
    Inherited;
End;


End.
