unit cfgTypes;

interface

uses
 windows, Classes;
 
//  abstract class for additional windows
//  i.e. a sub form
type
 TCFGOptions = class(TPersistent)
  private
   fName: string;
   fWinPlace: TWindowPlacement;
  public
   procedure SettoDefaults; virtual; abstract;
   procedure SaveSettings; virtual; abstract;
   procedure LoadSettings; virtual; abstract;
   property Name: string read fName write fName;
   property WindowPlacement: TWindowPlacement read fWinPlace write fWinPlace;
 end;


implementation

end.
 
