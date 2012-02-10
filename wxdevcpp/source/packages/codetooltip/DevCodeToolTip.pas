{----------------------------------------------------------------------------------

  The contents of this file are subject to the GNU General Public License
  Version 1.1 or later (the "License"); you may not use this file except in
  compliance with the License. You may obtain a copy of the License at
  http://www.gnu.org/copyleft/gpl.html

  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
  the specific language governing rights and limitations under the License.

  The Initial Developer of the Original Code is Peter Schraut.
  http://www.console-dev.de

  
  Portions created by Peter Schraut are Copyright 
  (C) 2004 by Peter Schraut (http://www.console-dev.de) 
  All Rights Reserved.

  
  To obtain the latest version of this file, please visit 
  http://www.bloodshed.net
  
----------------------------------------------------------------------------------}

//
//  History:
//
//    25 March 2004
//      Initial release
//
//    28 march 2004
//      DeBeforeShow optimized
//

Unit DevCodeToolTip;

Interface
Uses
    SysUtils, Classes, CodeToolTip, CppParser;

Type
    TDevCodeToolTipError = Class(Exception);


    TDevCodeToolTip = Class(TBaseCodeToolTip)
    Private
        FList: TList;
        FParser: TCppParser;
    Protected
        Procedure DoBeforeShow(Const AToolTips: TStringList; Const APrototypeName: String); Override;
    Public
        Constructor Create(AOwner: TComponent); Override;
        Destructor Destroy; Override;
        Property Activated;
        Property SelIndex;
    Published
        Property ActivateKey;
        Property Color;
        Property Editor;
        Property EndWhenChr;
        Property Hints;
        Property MaxScanLength;
        Property Options;
        Property Parser: TCppParser Read FParser Write FParser;
        Property StartWhenChr;
    End;

Implementation

//----------------------------------------------------------------------------------------------------------------------

Constructor TDevCodeToolTip.Create(AOwner: TComponent);
Begin
    Inherited;

    FList := TList.Create;
End;

//----------------------------------------------------------------------------------------------------------------------

Destructor TDevCodeToolTip.Destroy;
Begin
    If Assigned(FList) Then
        FList.Free;
    Inherited;
End;

//----------------------------------------------------------------------------------------------------------------------

Procedure TDevCodeToolTip.DoBeforeShow(Const AToolTips: TStringList; Const APrototypeName: String);
Var
    I: Integer;
Begin
  // added on 28march 2004
  // we dont need to go further when the hint is already
  // active, BECAUSE we already got all neccessary prototimes!
    If Activated Then
        Exit;

    AToolTips.Clear;

    If Parser = Nil Then
        Raise TDevCodeToolTipError.Create('No parser available!');

    Parser.FillListOf(APrototypeName, False, FList);
    AToolTips.BeginUpdate;
    Try
        For I := 0 To FList.Count - 1 Do
        Begin
            AToolTips.Add(PStatement(FList.Items[I])^._FullText);
        End;
    Finally
    // add the default casting "functions"
        AToolTips.Add('dest_type reinterpret_cast<dest_type>(src_type src)');
        AToolTips.Add('dest_type dynamic_cast<dest_type>(src_type src)');
        AToolTips.Add('dest_type static_cast<dest_type>(src_type src)');
        AToolTips.Add('dest_type const_cast<(const)(volatile) type>(src_type src)');

    // and RTTI
        AToolTips.Add('type_info& typeid(type)');
        AToolTips.Add('type_info& typeid(object)');

        AToolTips.EndUpdate;
    End;
End;


End.
