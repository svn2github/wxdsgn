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


unit WxNonVisibleBaseComponent;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, Buttons;

type
  TWxNonVisibleBaseComponent = class(TBitBtn)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure WMPaint(var messageV: TWMPaint); message WM_PAINT;
  published
    property Glyph;
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('wxWidgets', [TWxNonVisibleBaseComponent]);
end;

procedure TWxNonVisibleBaseComponent.WMPaint(var messageV: TWMPaint);
begin
  self.Caption := '';
  self.Height  := 27;
  self.Width   := 28;
  self.BringToFront;
  SetWindowPos(self.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOACTIVATE or
    SWP_NOMOVE or SWP_NOSIZE);
  inherited;
end;


end.
