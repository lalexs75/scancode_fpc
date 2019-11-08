unit frmTSDOrderUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, DBCtrls, DB, rxdbgrid, rxmemds;

type

  { TfrmTSDOrderFrame }

  TfrmTSDOrderFrame = class(TFrame)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CLabel: TLabel;
    DBImage1: TDBImage;
    dsGoods: TDataSource;
    RxDBGrid1: TRxDBGrid;
    rxGoods: TRxMemoryData;
    rxGoodsBmp: TBlobField;
    rxGoodsIdGoods: TStringField;
    rxGoodsIdMeasure: TStringField;
    rxGoodsIdVidnomencl: TStringField;
    rxGoodsImg: TStringField;
    rxGoodsName: TStringField;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public
    procedure GenerateData;
  end;

implementation
uses scancode_tsd_order_api, scGlobal, base64;

{$R *.lfm}

{ TfrmTSDOrderFrame }

procedure TfrmTSDOrderFrame.Button1Click(Sender: TObject);
var
  T: TTask;
  TG: TTaskGood;
  CL: TTaskGoodPropertySerialCell;
  NL: TNomenclature;
  TSDO: TOrders;
  //Handbooks: THandbooks;
  CH: TCharacteristic;
  BR: TTSDBarcode;
begin
  TSDO:=TOrders.Create;

  //Создадим документ обработки
  T:=TSDO.Tasks.CreateChild;
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

//  Handbooks:=THandbooks.Create;
  NL:=TSDO.Handbooks.Nomenclatures.NomenclatureList.CreateChild;
  NL.IdGoods:='1';
  NL.Name:='1';
  NL.IdMeasure:='1';
  NL.IdVidnomencl:='1';
  NL.Img:='1';
  NL.Bitmap:='1';

  CH:=TSDO.Handbooks.Characteristics.CharacteristicList.CreateChild;
  CH.IdGoods:='1';
  CH.IdChar:='1';
  CH.Name:='1';

  BR:=TSDO.Handbooks.Barcodes.BarcodeList.CreateChild;
  BR.IdGoods:='1';
  BR.IdChar:='1';
  BR.IdPack:='1';
  BR.Barcode:='1';

  TSDO.SaveToFile(ExportFolder + 'Order.xml');
  TSDO.Free;


//  Handbooks.SaveToFile(ExportFolder + 'Handbooks.xml');
//  Handbooks.Free;
end;

procedure TfrmTSDOrderFrame.Button2Click(Sender: TObject);
var
  O: TOrders;
  NM: TNomenclature;
  St1: TStringStream;
  Decoder: TBase64DecodingStream;
  St2: TMemoryStream;
begin
  rxGoods.CloseOpen;
  O:=TOrders.Create;
  O.LoadFromFile('/home/alexs/8/18500f45c81b8f43f42ecec.tmp');
  for NM in O.Handbooks.Nomenclatures.NomenclatureList do
  begin
    rxGoods.Append;
    rxGoodsIdGoods.AsString:=NM.IdGoods;
    rxGoodsName.AsString:=NM.Name;
    rxGoodsIdMeasure.AsString:=NM.IdMeasure;
    rxGoodsIdVidnomencl.AsString:=NM.IdVidnomencl;
    rxGoodsImg.AsString:=NM.Img;

    if NM.Bitmap<>'' then
    begin
      St1:=TStringStream.Create(NM.Bitmap);
      St2:=TMemoryStream.Create;
      Decoder:=TBase64DecodingStream.Create(St1,bdmMIME);

      St2.CopyFrom(Decoder, Decoder.Size);
      St2.Position:=0;
      rxGoodsBmp.LoadFromStream(St2);
      Decoder.Free;
      St1.Free;
      St2.Free;
    end;
    rxGoods.Post;
  end;
  O.Free;
  rxGoods.First;
end;

procedure TfrmTSDOrderFrame.GenerateData;
begin

end;

end.

