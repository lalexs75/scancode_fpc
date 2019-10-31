unit ScancodeMT;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TScancodeMT = class(TComponent)
  private

  protected

  public

  published

  end;

procedure Register;

implementation

procedure Register;
begin
  {$I scancodemt_icon.lrs}
  RegisterComponents('TradeEquipment',[TScancodeMT]);
end;

end.
