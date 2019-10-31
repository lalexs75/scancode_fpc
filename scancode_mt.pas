{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit scancode_mt;

{$warn 5023 off : no warning about unused units}
interface

uses
  scancode_user_api, scancode_stock_api, scancode_document_api, 
  scancode_characteristics_api, scancode_tsd_order_api, ScancodeMT, 
  ScancodeMT_API, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ScancodeMT', @ScancodeMT.Register);
end;

initialization
  RegisterPackage('scancode_mt', @Register);
end.
