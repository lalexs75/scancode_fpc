{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit scancode_mt;

{$warn 5023 off : no warning about unused units}
interface

uses
  scancode_user_api, scancode_stock_api, scancode_document_api, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('scancode_mt', @Register);
end.
