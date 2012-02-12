 { ****************************************************************** }
 {                                                                    }
{ $Id: Wxcontrolpanel.pas 936 2007-05-15 03:47:39Z gururamnath $                                                               }
 {                                                                    }
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


Unit WxControlPanel;

Interface

Uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
    Forms, Graphics, ExtCtrls, wxUtils;

Type
    TWxControlPanel = Class(TPanel, IWxControlPanelInterface)
    Private
    { Private fields of TWxControlPanel }

    { Private methods of TWxControlPanel }
    { Method to set variable and property values and create objects }
        Procedure AutoInitialize;
    { Method to free any objects created by AutoInitialize }
        Procedure AutoDestroy;

    Protected
    { Protected fields of TWxControlPanel }

    { Protected methods of TWxControlPanel }
        Procedure Click; Override;
        Procedure KeyPress(Var Key: Char); Override;
        Procedure Loaded; Override;
        Procedure Paint; Override;

    Public
    { Public fields and properties of TWxControlPanel }

    { Public methods of TWxControlPanel }
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;

    Published
    { Published properties of TWxControlPanel }
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
     { Register TWxControlPanel with Standard as its
       default page on the Delphi component palette }
    RegisterComponents('Standard', [TWxControlPanel]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxControlPanel.AutoInitialize;
Begin

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxControlPanel.AutoDestroy;
Begin
  { No objects from AutoInitialize to free }
End; { of AutoDestroy }

{ Override OnClick handler from TPanel }
Procedure TWxControlPanel.Click;
Begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
    Inherited Click;

     { Code to execute after click behavior
       of parent }

End;

{ Override OnKeyPress handler from TPanel }
Procedure TWxControlPanel.KeyPress(Var Key: Char);
Const
    TabKey = Char(VK_TAB);
    EnterKey = Char(VK_RETURN);
Begin
     { Key contains the character produced by the keypress.
       It can be tested or assigned a new value before the
       call to the inherited KeyPress method.  Setting Key 
       to #0 before call to the inherited KeyPress method 
       terminates any further processing of the character. }

  { Activate KeyPress behavior of parent }
    Inherited KeyPress(Key);

  { Code to execute after KeyPress behavior of parent }

End;

Constructor TWxControlPanel.Create(AOwner: TComponent);
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
    self.Caption := '';

End;

Destructor TWxControlPanel.Destroy;
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

Procedure TWxControlPanel.Loaded;
Begin
    Inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

End;

Procedure TWxControlPanel.Paint;
Begin
     { Make this component look like its parent component by calling
       its parent's Paint method. }
    Inherited Paint;

     { To change the appearance of the component, use the methods 
       supplied by the component's Canvas property (which is of 
       type TCanvas).  For example, }

  { Canvas.Rectangle(0, 0, Width, Height); }
End;


End.
