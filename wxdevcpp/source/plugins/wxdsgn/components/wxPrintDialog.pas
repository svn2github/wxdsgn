// $Id: wxPrintDialog.pas 936 2007-05-15 03:47:39Z gururamnath $
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


Unit wxPrintDialog;

Interface

Uses
    Windows, Messages, SysUtils, Classes, wxUtils, WxNonVisibleBaseComponent;

Type
    TWxPrintDialog = Class(TWxNonVisibleBaseComponent, IWxComponentInterface)
    Private
    { Private declarations }
        FWx_Class: String;
        FWx_PropertyList: TStringList;
        FWx_FromPage: Integer;
        FWx_MaxPage: Integer;
        FWx_MinPage: Integer;
        FWx_NumberOfCopies: Integer;
        FWx_PrintToFile: Boolean;
        FWx_Selection: Boolean;
        FWx_ToPage: Integer;
        FWx_Comments: TStrings;

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
        Property Wx_FromPage: Integer Read FWx_FromPage Write FWx_FromPage;
        Property Wx_MaxPage: Integer Read FWx_MaxPage Write FWx_MaxPage;
        Property Wx_MinPage: Integer Read FWx_MinPage Write FWx_MinPage;
        Property Wx_NumberOfCopies: Integer Read FWx_NumberOfCopies
            Write FWx_NumberOfCopies;
        Property Wx_PrintToFile: Boolean Read FWx_PrintToFile Write FWx_PrintToFile;
        Property Wx_Selection: Boolean Read FWx_Selection Write FWx_Selection;
        Property Wx_ToPage: Integer Read FWx_ToPage Write FWx_ToPage;
        Property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
    End;

Procedure Register;

Implementation

Procedure Register;
Begin
    RegisterComponents('wxWidgets', [TWxPrintDialog]);
End;

{ Method to set variable and property values and create objects }
Procedure TWxPrintDialog.AutoInitialize;
Begin
    FWx_PropertyList := TStringList.Create;
    FWx_Class := 'wxPrintDialog';
    FWx_Comments := TStringList.Create;
    Glyph.Handle := LoadBitmap(hInstance, 'TWxPrintDialog');
End; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
Procedure TWxPrintDialog.AutoDestroy;
Begin
    FWx_PropertyList.Destroy;
    FWx_Comments.Destroy;
    Glyph.Assign(Nil);
End; { of AutoDestroy }

Constructor TWxPrintDialog.Create(AOwner: TComponent);
Begin
  { Call the Create method of the container's parent class       }
    Inherited Create(AOwner);

  { AutoInitialize method is generated by Component Create.      }
    AutoInitialize;

  { Code to perform other tasks when the component is created }
  { Code to perform other tasks when the component is created }
    FWx_PropertyList.add('Name:Name');
    FWx_PropertyList.add('Wx_Class:Base Class');
    FWx_PropertyList.add('Wx_FromPage:From Page');
    FWx_PropertyList.add('Wx_MaxPage:Max Page');
    FWx_PropertyList.add('Wx_MinPage:Min Page');
    FWx_PropertyList.add('Wx_NumberOfCopies:NumberOfCopies');
    FWx_PropertyList.add('Wx_PrintToFile:PrintToFile');
    FWx_PropertyList.add('Wx_Selection:Selection');
    FWx_PropertyList.add('Wx_ToPage:To Page');
    FWx_PropertyList.add('Wx_Comments:Comments');
End;

Destructor TWxPrintDialog.Destroy;
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

Function TWxPrintDialog.GenerateControlIDs: String;
Begin
    Result := '';
End;

Function TWxPrintDialog.GenerateEnumControlIDs: String;
Begin
    Result := '';
End;

Function TWxPrintDialog.GenerateEventTableEntries(CurrClassName: String): String;
Begin
    Result := '';
End;

Function TWxPrintDialog.GenerateXRCControlCreation(IndentString: String): TStringList;
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

Function TWxPrintDialog.GenerateGUIControlCreation: String;
Begin

    Result := '';
    Result := GetCommentString(self.FWx_Comments.Text) +
        self.Name + '_Data = new wxPrintDialogData();';
    Result := Result + #13 + self.Name + '_Data->SetFromPage(' +
        IntToStr(Wx_FromPage) + ');';
    Result := Result + #13 + self.Name + '_Data->SetMaxPage(' +
        IntToStr(Wx_MaxPage) + ');';
    Result := Result + #13 + self.Name + '_Data->SetMinPage(' +
        IntToStr(Wx_MinPage) + ');';
    Result := Result + #13 + self.Name + '_Data->SetNoCopies(' +
        IntToStr(Wx_NumberOfCopies) + ');';
    Result := Result + #13 + self.Name + '_Data->SetToPage(' + IntToStr(Wx_ToPage) + ');';

    If Wx_PrintToFile Then
        Result := Result + #13 + self.Name + '_Data->SetPrintToFile(true);'
    Else
        Result := Result + #13 + self.Name + '_Data->SetPrintToFile(false);';

    If Wx_Selection Then
        Result := Result + #13 + self.Name + '_Data->SetSelection(true);'
    Else
        Result := Result + #13 + self.Name + '_Data->SetSelection(false);';

    Result := Result + #13 + Format('%s =  new %s(this, %s);',
        [self.Name, self.wx_Class, self.Name + '_Data']);

End;

Function TWxPrintDialog.GenerateGUIControlDeclaration: String;
Begin
    Result := '';
    Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
    Result := Result + #13 + Format('wxPrintDialogData *%s_Data;', [trim(Self.Name)]);
End;

Function TWxPrintDialog.GenerateHeaderInclude: String;
Begin
    Result := '';
    Result := '#include <wx/printdlg.h>';
    Result := Result + #13 + '#include <wx/cmndata.h>';
End;

Function TWxPrintDialog.GenerateImageInclude: String;
Begin

End;

Function TWxPrintDialog.GetEventList: TStringList;
Begin
    Result := Nil;
End;

Function TWxPrintDialog.GetIDName: String;
Begin

End;

Function TWxPrintDialog.GetIDValue: Integer;
Begin
    Result := 0;
End;

Function TWxPrintDialog.GetParameterFromEventName(EventName: String): String;
Begin

End;

Function TWxPrintDialog.GetStretchFactor: Integer;
Begin
    Result := 1;
End;

Function TWxPrintDialog.GetPropertyList: TStringList;
Begin
    Result := FWx_PropertyList;
End;

Function TWxPrintDialog.GetBorderAlignment: TWxBorderAlignment;
Begin
    Result := [];
End;

Procedure TWxPrintDialog.SetBorderAlignment(border: TWxBorderAlignment);
Begin
End;

Function TWxPrintDialog.GetBorderWidth: Integer;
Begin
    Result := 0;
End;

Procedure TWxPrintDialog.SetBorderWidth(width: Integer);
Begin
End;

Function TWxPrintDialog.GetTypeFromEventName(EventName: String): String;
Begin

End;

Function TWxPrintDialog.GetWxClassName: String;
Begin
    If trim(wx_Class) = '' Then
        wx_Class := 'wxPrintDialog';
    Result := wx_Class;
End;

Procedure TWxPrintDialog.SaveControlOrientation(
    ControlOrientation: TWxControlOrientation);
Begin

End;

Procedure TWxPrintDialog.SetIDName(IDName: String);
Begin

End;

Procedure TWxPrintDialog.SetIDValue(IDValue: Integer);
Begin

End;

Procedure TWxPrintDialog.SetStretchFactor(intValue: Integer);
Begin
End;

Procedure TWxPrintDialog.SetWxClassName(wxClassName: String);
Begin
    wx_Class := wxClassName;
End;

Function TWxPrintDialog.GetGenericColor(strVariableName: String): String;
Begin

End;
Procedure TWxPrintDialog.SetGenericColor(strVariableName, strValue: String);
Begin

End;


Function TWxPrintDialog.GetFGColor: String;
Begin

End;

Procedure TWxPrintDialog.SetFGColor(strValue: String);
Begin
End;

Function TWxPrintDialog.GetBGColor: String;
Begin
End;

Procedure TWxPrintDialog.SetBGColor(strValue: String);
Begin
End;

Procedure TWxPrintDialog.SetProxyFGColorString(Value: String);
Begin
End;

Procedure TWxPrintDialog.SetProxyBGColorString(Value: String);
Begin
End;

End.
 