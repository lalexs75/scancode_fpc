unit frmTSDOrderUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls;

type

  { TfrmTSDOrderFrame }

  TfrmTSDOrderFrame = class(TFrame)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

  public
    procedure GenerateData;
  end;

implementation
uses scancode_tsd_order_api, scGlobal;

{$R *.lfm}

{ TfrmTSDOrderFrame }

procedure TfrmTSDOrderFrame.Button1Click(Sender: TObject);
var
  TSDO: TTSDOrder;
  T: TTask;
  TG: TTaskGood;
  CL: TTaskGoodPropertySerialCell;
begin
  TSDO:=TTSDOrder.Create;

  //Создадим документ обработки
  T:=TSDO.Orders.Tasks.CreateChild;
  T.IdDoc:='70b9a737-c224-11e8-ba50-50465d72dd18';
  T.Date:='08.10.2018 0:00:00';
  T.TaskType:='202';
  T.DateOrder:='11.10.2018 17:18:48';
  T.FC:='0';
  T.IdSclad:='';

  TG:=T.Goods.CreateChild;
  TG.IdChar:='b02e2816-720f-11df-b436-0015e92f2802';
  TG.IdGoods:='dee6e1d0-55bc-11d9-848a-00112f43529a';
  TG.GoodProperty.IdPack:=' ';
  TG.GoodProperty.Serial.Quantity:='1';
  TG.GoodProperty.Serial.IdSerial:=' ';
  TG.GoodProperty.Serial.Date:=' ';
  TG.GoodProperty.Serial.Value:=' ';
  CL:=TG.GoodProperty.Serial.Cells.CreateChild;
  CL.IdCell:='322718363789694194929610170602799020651';
  CL.CellAddress:='БТ-СТ5-4';

  TG:=T.Goods.CreateChild;
  TG.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
  TG.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
  TG.GoodProperty.IdPack:=' ';
  TG.GoodProperty.Serial.Quantity:='1';
  TG.GoodProperty.Serial.IdSerial:=' ';
  TG.GoodProperty.Serial.Date:=' ';
  TG.GoodProperty.Serial.Value:=' ';

  TG:=T.Goods.CreateChild;
  TG.IdChar:='b02e280c-720f-11df-b436-0015e92f2802';
  TG.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
  TG.GoodProperty.IdPack:=' ';
  TG.GoodMarking.DATAMATRIX:=' ';
  TG.GoodMarking.PDF417:='123456789012345678901234567890';
  TG.GoodProperty.Serial.Quantity:='2';
  TG.GoodProperty.Serial.IdSerial:=' ';
  TG.GoodProperty.Serial.Date:=' ';
  TG.GoodProperty.Serial.Value:=' ';

  TSDO.SaveToFile(ExportFolder + 'TSDOrder.xml');
  TSDO.Free;
end;

procedure TfrmTSDOrderFrame.GenerateData;
begin

end;

end.

