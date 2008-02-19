 { ****************************************************************** }
 {                                                                    }
 {   $Id$    }
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

unit WxSizerPanel;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
  Forms, Graphics, ExtCtrls;

type
  TWxSizerPanel = class(TPanel)
  private
    { Private fields of TWxSizerPanel }

    { Private methods of TWxSizerPanel }

  protected
    { Protected fields of TWxSizerPanel }

    { Protected methods of TWxSizerPanel }
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;
    procedure Paint; override;

  public
    { Public fields and properties of TWxSizerPanel }

    { Public methods of TWxSizerPanel }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    { Published properties of TWxSizerPanel }
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;

  end;

procedure Register;

implementation

procedure Register;
begin
     { Register TWxSizerPanel with Standard as its
       default page on the Delphi component palette }
  RegisterComponents('Standard', [TWxSizerPanel]);
end;

{ Override OnClick handler from TPanel }
procedure TWxSizerPanel.Click;
begin
  inherited Click;
end;

{ Override OnKeyPress handler from TPanel }
procedure TWxSizerPanel.KeyPress(var Key: char);
begin
  inherited KeyPress(Key);
end;

constructor TWxSizerPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWxSizerPanel.Destroy;
begin
  inherited Destroy;
end;

procedure TWxSizerPanel.Loaded;
begin
  inherited Loaded;
end;

procedure TWxSizerPanel.Paint;
begin
  inherited Paint;
end;


end.
