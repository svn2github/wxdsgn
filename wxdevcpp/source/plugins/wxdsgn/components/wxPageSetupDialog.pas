// $Id: wxPageSetupDialog.pas 936 2007-05-15 03:47:39Z gururamnath $
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


Unit wxPageSetupDialog;

Interface

Uses
    Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

Type
    TWxPageSetupDialog = Class(TWxNonVisibleBaseComponent, IWxComponentInterface)
    Private
    { Private declarations }
        FWx_Class: String;
        FWx_PropertyList: TStringList;
        FMarginTopLeftX: Integer;
        FMarginTopLeftY: Integer;

        FMarginBottomRightX: Integer;
        FMarginBottomRightY: Integer;

        FMinMarginTopLeftX: Integer;
        FMinMarginTopLeftY: Integer;

        FMinMarginBottomRightX: Integer;
        FMinMarginBottomRightY: Integer;

        FPaperId: TWxPaperSizeItem;


        Procedure AutoInitialize;
        Procedure AutoDestroy;

    Protected

    Public
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Function GenerateControlIDs: String;
        Function GenerateEnumControlIDs: String;
        Function GenerateEventTableEntries(CurrClassName: String): String;
        Function GenerateGUIControlCreation: String;
        Function GenerateXRCControlCreation(IndentString: String): TStringList;
        Function GenerateGUIControlDeclaration: String;
        Function GenerateHeaderInclude: String;
        Function GenerateImageInclude: String;
        Function GetEventList: TStringList;
        Function GetIDName: String;
        Function GetIDValue: Integer;
        Function GetParameterFromEventName(EventName: String): String;
        Function GetPropertyList: TStringList;
        Function GetTypeFromEventName(EventName: String): String;
        Function GetWxClassName: String;
        Procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
        Procedure SetIDName(IDName: String);
        Procedure SetIDValue(IDValue: Integer);
        Procedure SetWxClassName(wxClassName: String);
        Function GetFGColor: String;
        Procedure SetFGColor(strValue: String);
        Function GetBGColor: String;
        Procedure SetBGColor(strValue: String);

        Function GetGenericColor(strVariableName: String): String;
        Procedure SetGenericColor(strVariableName, strValue: String);

        Procedure SetProxyFGColorString(Value: String);
        Procedure SetProxyBGColorString(Value: String);

        Function GetBorderAlignment: TWxBorderAlignment;
        Procedure SetBorderAlignment(border: TWxBorderAlignment);
        Function GetBorderWidth: Integer;
        Procedure SetBorderWidth(width: Integer);
        Function GetStretchFactor: Integer;
        Procedure SetStretchFactor(intValue: Integer);

    Published
    { Published declarations }
        Property Wx_Class: String Read FWx_Class Write FWx_Class;

        Property Wx_MarginTopLeftX: Integer Read FMarginTopLeftX Write FMarginTopLeftX;
        Property Wx_MarginBottomRightX: Integer
            Read FMarginBottomRightX Write FMarginBottomRightX;
        Property Wx_MinMarginTopLeftX: Integer Read FMinMarginTopLeftX
            Write FMinMarginTopLeftX;
        Property Wx_MinMarginBottomRightX: Integer
            Read FMinMarginBottomRightX Write FMinMarginBottomRightX;

        Property Wx_MarginTopLeftY: Integer Read FMarginTopLeftY Write FMarginTopLeftY;
        Property Wx_MarginBottomRightY: Integer
            Read FMarginBottomRightY Write FMarginBottomRightY;
        Property Wx_MinMarginTopLeftY: Integer Read FMinMarginTopLeftY
            Write FMinMarginTopLeftY;
        Property Wx_MinMarginBottomRightY: Integer
            Read FMinMarginBottomRightY Write FMinMarginBottomRightY;


        Property Wx_PaperId: TWxPaperSizeItem Read FPaperId Write FPaperId;
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxPageSetupDialog]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxPageSetupDialog.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Class := 'wxPageSetupDialog';
    Glyph.Handle := LoadBitmap(hInstance, 'TWxPageSetupDialog');

End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxPageSetupDialog.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    Glyph.Assign(Nil);
End; { of AutoDestroy }

Constructor TWxPageSetupDialog.Create(AOwner: TComponent);
Begin
  { Call the Create method of the container's parent class       }
    Inherited Create(AOwner);

  { AutoInitialize method is generated by Component Create.      }
    AutoInitialize;

    FWx_PropertyList.add('Name:Name');
    FWx_PropertyList.add('Wx_Class:Base Class');

    FWx_PropertyList.add('Wx_MarginTopLeftX:MarginTopLeftX');
    FWx_PropertyList.add('Wx_MarginBottomRightX:MarginBottomRightX');
    FWx_PropertyList.add('Wx_MinMarginTopLeftX: MinMarginTopLeftX');
    FWx_PropertyList.add('Wx_MinMarginBottomRightX:MinMarginBottomRightX');

    FWx_PropertyList.add('Wx_MarginTopLeftY:MarginTopLeftY');
    FWx_PropertyList.add('Wx_MarginBottomRightY:MarginBottomRightY');
    FWx_PropertyList.add('Wx_MinMarginTopLeftY: MinMarginTopLeftY');
    FWx_PropertyList.add('Wx_MinMarginBottomRightY:MinMarginBottomRightY');

    FWx_PropertyList.add('Wx_PaperId:PaperId');
End;

Destructor TWxPageSetupDialog.Destroy;
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

Function TWxPageSetupDialog.GenerateControlIDs: String;
Begin
    Result := '';
End;

Function TWxPageSetupDialog.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxPageSetupDialog.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxPageSetupDialog.GenerateXRCControlCreation(IndentString: String):
TStringList;
Begin

    Result := TStringList.Create;

    Try
        Result.Add(IndentString + Format('<object class="%s" name="%s">',
            [self.Wx_Class, self.Name]));
        Result.Add(IndentString + '</object>');

    Except
        Result.Free;
        Raise;
    End;

End;

Function TWxPageSetupDialog.GenerateGUIControlCreation: String;
Begin
    Result := '';
    Result := self.Name + '_Data = new wxPageSetupDialogData();';
    Result := Result + #13 + self.Name + '_Data->SetMarginTopLeft(wxPoint(' +
        Format('%d,%d', [Wx_MarginTopLeftX, Wx_MarginTopLeftY]) + '));';
    Result := Result + #13 + self.Name + '_Data->SetMarginBottomRight(wxPoint(' +
        Format('%d,%d', [Wx_MarginBottomRightX, Wx_MarginBottomRightY]) + '));';
    Result := Result + #13 + self.Name + '_Data->SetMinMarginTopLeft(wxPoint(' +
        Format('%d,%d', [Wx_MinMarginTopLeftX, Wx_MinMarginTopLeftY]) + '));';
    Result := Result + #13 + self.Name + '_Data->SetMinMarginBottomRight(wxPoint(' +
        Format('%d,%d', [Wx_MinMarginBottomRightX, Wx_MinMarginBottomRightY]) + '));';
    Result := Result + #13 + self.Name + '_Data->SetPaperId(' +
        PaperIDToString(Wx_PaperId) + ');';
    Result := Result + #13 + Format('%s =  new %s(this, %s);',
        [self.Name, self.wx_Class, self.Name + '_Data']);

End;

Function TWxPageSetupDialog.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
    Result := Result + #13 + Format('wxPageSetupDialogData *%s_Data;', [trim(Self.Name)]);
End;

Function TWxPageSetupDialog.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/printdlg.h>';
    Result := Result + #13 + '#include <wx/cmndata.h>';
End;

Function TWxPageSetupDialog.GenerateImageInclude: String;
Begin

End;

Function TWxPageSetupDialog.GetEventList: TStringList;
Begin
    Result := Nil;
End;

Function TWxPageSetupDialog.GetIDName: String;
Begin

End;

Function TWxPageSetupDialog.GetIDValue: Integer;
Begin
    Result := 0;
End;

Function TWxPageSetupDialog.GetParameterFromEventName(EventName: String): String;
Begin

End;

Function TWxPageSetupDialog.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxPageSetupDialog.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxPageSetupDialog.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxPageSetupDialog.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxPageSetupDialog.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxPageSetupDialog.SetBorderWidth(width: Integer);
Begin
End;

Function TWxPageSetupDialog.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxPageSetupDialog.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxFindReplaceDialog';
    Result := wx_Class;
End;

Procedure TWxPageSetupDialog.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin

End;

Procedure TWxPageSetupDialog.SetIDName(IDName: String);
Begin

End;

Procedure TWxPageSetupDialog.SetIDValue(IDValue: Integer);
Begin

End;

Procedure TWxPageSetupDialog.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxPageSetupDialog.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxPageSetupDialog.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxPageSetupDialog.SetGenericColor(strVariableName, strValue: String);
Begin

End;


Function TWxPageSetupDialog.GetFGColor: String;
Begin

End;

Procedure TWxPageSetupDialog.SetFGColor(strValue: String);
Begin
End;

Function TWxPageSetupDialog.GetBGColor: String;
Begin
End;

Procedure TWxPageSetupDialog.SetBGColor(strValue: String);
Begin
End;

Procedure TWxPageSetupDialog.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxPageSetupDialog.SetProxyBGColorString(Value: String);
Begin
End;

End.
 