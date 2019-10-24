unit frmCharacteristicUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls;

type

  { TfrmCharacteristicFrame }

  TfrmCharacteristicFrame = class(TFrame)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

  public
    procedure GenerateData;
  end;

implementation
uses scancode_characteristics_api, scGlobal;

{$R *.lfm}

{ TfrmCharacteristicFrame }

procedure TfrmCharacteristicFrame.Button1Click(Sender: TObject);
var
  DD: TDictionary;
  G: TSprGood;
  Ch: TCharacteristic;
  Pk: TPack;
  SR: TSerial;
  BR: TBarcode;
  MS: TMeasure;
  PR: TPrice;
  NT: TNomenclatureType;
  Skld: TSclad;
begin
  DD:=TDictionary.Create;
  //Заполняем справочник товаров
  G:=DD.SprGoods.SprGoodLists.CreateChild;
  G.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
  G.Name:='Наименование товара';
  G.IdMeasure:='bd72d90f-55bc-11d9-848a-00112f43529a';
  G.Art:='Б- 130005';
  G.Alco:='0';
  G.IdVidnomencl:='';
  G.IdNaborPack:='';
  G.Img:='';
  G.Bitmap:='';

  //Заполняем справочник характеристик
  Ch:=DD.Characteristics.CharacteristicList.CreateChild;
  Ch.IdOwner:='bd72d913-55bc-11d9-848a-00112f43529a';
  Ch.Relation:='видыноменклатуры';
  Ch.Name:='38, Бежевый, 6, натуральная кожа';
  Ch.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';

  //Заполняем справочник упаковок
  Pk:=DD.Packs.PackList.CreateChild;
  Pk.IdOwner:='bd72d913-55bc-11d9-848a-00112f43529a';
  Pk.Relation:='';
  Pk.Name:='пар';
  Pk.IdPack:='bd72d90f-55bc-11d9-848a-00112f43529a';
  Pk.Koeff:='1';

  //Заполняем серии объектов
  SR:=DD.Serials.SerialList.CreateChild;
  SR.IdOwner:='e8a71fbf-55bc-11d9-848a-00112f43529a';
  SR.Relation:='';
  SR.Name:='до 20.12.16';
  SR.IdSerial:='0ed9fc88-d9fe-11e4-92f1-0050568b35ac';
  SR.Num:='';
  SR.Date:='2016-12-20T00:00:00';

  //Заполняем справочник штрихкодов
  BR:=DD.Barcodes.BarcodeList.CreateChild;
  BR.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
  BR.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
  BR.IdPack:='';
  BR.Barcode:='2000000000480';

  BR:=DD.Barcodes.BarcodeList.CreateChild;
  BR.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
  BR.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
  BR.IdPack:='f0e40f7b-7390-11df-b338-0011955cba6b';
  BR.Barcode:='2000000000497';

  BR:=DD.Barcodes.BarcodeList.CreateChild;
  BR.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
  BR.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
  BR.IdPack:='f0e40f7d-7390-11df-b338-0011955cba6b';
  BR.Barcode:='2000000000503';

  BR:=DD.Barcodes.BarcodeList.CreateChild;
  BR.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
  BR.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
  BR.IdPack:='dff7f708-7a0b-11df-b33a-0011955cba6b';
  BR.Barcode:='2000000000510';

  //Заполняем справочник единиц измерения
  MS:=DD.Measures.MeasureList.CreateChild;
  MS.IdMeasure:='bd72d90f-55bc-11d9-848a-00112f43529a';
  MS.Name:='пар';

  //Заполняем справочник цен
  PR:=DD.Prices.PriceList.CreateChild;
  PR.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
  PR.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
  PR.IdPack:='dff7f708-7a0b-11df-b33a-0011955cba6b';
  PR.Price:='8166.4';
  PR.Currency:='руб';

  //Заполняем справочник видов номенклатуры
  NT:=DD.NomenclatureTypes.NomenclatureTypeList.CreateChild;
  NT.IdNomenclatureType:='9c556d55-720f-11df-b436-0015e92f2802';
  NT.Name:='Холодильники';
  NT.IsChar:='0';
  NT.IsSerial:='0';
  NT.IsNomerSerial:='0';
  NT.IsDateSerial:='0';

  NT:=DD.NomenclatureTypes.NomenclatureTypeList.CreateChild;
  NT.IdNomenclatureType:='9c556d52-720f-11df-b436-0015e92f2802';
  NT.Name:='Электротовары';
  NT.IsChar:='0';
  NT.IsSerial:='0';
  NT.IsNomerSerial:='0';
  NT.IsDateSerial:='0';

  //Заполняем справочник складов
  Skld:=DD.Sclads.ScladList.CreateChild;
  Skld.IdSclad:='abf5870d-f5c8-11e2-802f-0015e9b8c48d';
  Skld.Name:='Домодедовская таможня';
  Skld.IsAdress:='0';
  Skld.IsOrder:='0';
  Skld:=DD.Sclads.ScladList.CreateChild;
  Skld.IdSclad:='abf58710-f5c8-11e2-802f-0015e9b8c48d';
  Skld.Name:='Внуковская таможня';
  Skld.IsAdress:='0';
  Skld.IsOrder:='0';

  DD.SaveToFile(ExportFolder + 'Dictionary.xml');
  DD.Free;
end;

procedure TfrmCharacteristicFrame.GenerateData;
begin

end;

end.

