// $Id$
//

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
    procedure WMPaint(var messageV:TWMPaint); message WM_PAINT;
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

procedure TWxNonVisibleBaseComponent.WMPaint(var messageV:TWMPaint);
begin
    self.Caption:='';
    self.Height:=27;
    self.Width:=28;
    self.BringToFront;
    SetWindowPos(self.Handle, HWND_TOPMOST, 0,0,0,0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
    inherited;
end;


end.
