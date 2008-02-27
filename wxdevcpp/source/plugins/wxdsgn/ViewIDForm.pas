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

unit ViewIDForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls,wxUtils, ComCtrls, XPMenu;

type
  TViewControlIDsForm = class(TForm)
    btClose: TBitBtn;
    XPMenu: TXPMenu;
    cbHideZeroValueID: TCheckBox;
    ControlListBox: TListView;
    procedure FormCreate(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ControlListBoxAdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure cbHideZeroValueIDClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FMainControl:TWinControl;
  public
    { Public declarations }
    procedure SetMainControl(winCtrl:TWinControl);
    procedure PopulateControlList;
  end;

var
  ViewControlIDsForm: TViewControlIDsForm;

implementation

{$R *.DFM}

uses
  wxdesigner;

procedure TViewControlIDsForm.SetMainControl(winCtrl:TWinControl);
begin
    FMainControl:=winCtrl;
end;

procedure TViewControlIDsForm.FormCreate(Sender: TObject);
begin
    FMainControl:=nil;
end;

procedure TViewControlIDsForm.PopulateControlList;
var
  I,J: Integer;
  lstitem,lstitem2:TListItem ;
  wxcompInterface: IWxComponentInterface;
begin
    if FMainControl = nil then
        exit;

    ControlListBox.Items.Clear;
    for I := 0 to FMainControl.ComponentCount - 1 do    // Iterate
    begin
        if (FMainControl.Components[i].GetInterface(IID_IWxComponentInterface,wxcompInterface)) and (wxcompInterface.GetIDName <> '') then
        begin
            if (0 = wxcompInterface.GetIDValue) and (cbHideZeroValueID.Checked) then
              continue; 
            lstitem := ControlListBox.Items.Add;
            lstitem.Caption:=IntToStr(wxcompInterface.GetIDValue);
            lstitem.SubItems.Add(wxcompInterface.GetIDName);
            lstitem.SubItems.Add(FMainControl.Components[i].Name);
            lstitem.SubItems.Add('');
        end;
    end;    // for
    //Find Duplicates and change the Color
    for I := 0 to ControlListBox.Items.Count - 1 do    // Iterate
    begin
        lstitem := ControlListBox.Items[i];
        if ((lstitem.Caption = '') or (lstitem.Caption = '0')) then
          continue;
        for J := 0 to ControlListBox.Items.Count - 1 do    // Iterate
        begin
          if J = I then
            continue;
          lstitem2 := ControlListBox.Items[J];
          if ((lstitem2.Caption = '') or (lstitem2.Caption = '0')) then
            continue;
          if lstitem.Caption = lstitem2.Caption then
          begin
            lstitem2.SubItems[2]:='d';
            lstitem.SubItems[2]:='d';
          end;
        end;
    end;    // for

end;

procedure TViewControlIDsForm.btCloseClick(Sender: TObject);
begin
    close;
end;

procedure TViewControlIDsForm.btRefreshClick(Sender: TObject);
begin
    if FMainControl = nil then
        exit;
    FMainControl.repaint;
end;

procedure TViewControlIDsForm.FormShow(Sender: TObject);
begin
    DesktopFont := True;
    XPMenu.Active := wx_designer.XPTheme;
end;

procedure TViewControlIDsForm.ControlListBoxAdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
var
  strItemValue:String;
begin

    if item.subitems.count < 3 then
        exit;

    strItemValue:=item.subitems[2];
    if ((strItemValue = 'd') or (strItemValue = 'D')) then
        ControlListBox.Canvas.brush.color:=$00EAADEA // { $00EAADEA}$006963B6
//    else
//        if strItemValue = 'S' then
//          lstvwUrls.Canvas.brush.color:=$00EAEAAD; //{ $0099CD32;}$0093CAB1;
end;

procedure TViewControlIDsForm.cbHideZeroValueIDClick(Sender: TObject);
begin
  PopulateControlList;
end;

procedure TViewControlIDsForm.FormDestroy(Sender: TObject);
begin
  XPMenu.Active := false;
end;

end.
