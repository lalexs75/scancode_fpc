unit frmCharacteristicUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, ComCtrls, DB, rxmemds,
  rxdbgrid, scancode_characteristics_api;

type

  { TfrmCharacteristicFrame }

  TfrmCharacteristicFrame = class(TFrame)
    Button1: TButton;
    dsSklad: TDataSource;
    dsrxNomenclatureTypes: TDataSource;
    PageControl1: TPageControl;
    RxDBGrid1: TRxDBGrid;
    RxDBGrid2: TRxDBGrid;
    rxSklad: TRxMemoryData;
    rxNomenclatureTypes: TRxMemoryData;
    rxNomenclatureTypesIdNomenclatureType: TStringField;
    rxNomenclatureTypesIsChar: TBooleanField;
    rxNomenclatureTypesIsDateSerial: TBooleanField;
    rxNomenclatureTypesIsNomerSerial: TBooleanField;
    rxNomenclatureTypesIsSerial: TBooleanField;
    rxNomenclatureTypesName: TStringField;
    rxSkladIsAdressExists: TBooleanField;
    rxSkladIsOrder: TBooleanField;
    rxSkladSKLAD_ID: TStringField;
    rxSkladSKLAD_NAME: TStringField;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure Button1Click(Sender: TObject);
  private

  public
    procedure GenerateData;
    function CreateDictionarys(DI:TDictionary):TDictionary;
  end;

implementation
uses scGlobal;

{$R *.lfm}

{ TfrmCharacteristicFrame }

procedure TfrmCharacteristicFrame.Button1Click(Sender: TObject);
var
  DD: TDictionary;
begin
  DD:=CreateDictionarys(nil);
  DD.SaveToFile(ExportFolder + 'Dictionary.xml');
  DD.Free;
end;

procedure TfrmCharacteristicFrame.GenerateData;
begin
  rxSklad.Open;
  rxSklad.AppendRecord(['5E5C46C3-44FF-443D-9503-646D342C2483', 'Склад № 1', true, true]);
  rxSklad.AppendRecord(['66570A44-5BF2-4DEA-9782-BFA176F7B7D5', 'Склад № 2', true, true]);
  rxSklad.AppendRecord(['8CFADDD2-C9F9-4658-8EDA-E7BF44B1597A', 'Склад № 3', true, true]);
  rxSklad.AppendRecord(['DFF040EB-ACFA-4C6A-9DB5-AB8867D7747C', 'Склад № 4 - Транзит', true, true]);

  rxSklad.First;
end;

function TfrmCharacteristicFrame.CreateDictionarys(DI: TDictionary
  ): TDictionary;
var
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
  if Assigned(DI) then
    Result:=DI
  else
    Result:=TDictionary.Create;

  //Заполняем справочник товаров
  G:=Result.SprGoods.SprGoodLists.CreateChild;
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
  Ch:=Result.Characteristics.CharacteristicList.CreateChild;
  Ch.IdOwner:='bd72d913-55bc-11d9-848a-00112f43529a';
  Ch.Relation:='видыноменклатуры';
  Ch.Name:='38, Бежевый, 6, натуральная кожа';
  Ch.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';

  //Заполняем справочник упаковок
  Pk:=Result.Packs.PackList.CreateChild;
  Pk.IdOwner:='bd72d913-55bc-11d9-848a-00112f43529a';
  Pk.Relation:='';
  Pk.Name:='пар';
  Pk.IdPack:='bd72d90f-55bc-11d9-848a-00112f43529a';
  Pk.Koeff:='1';

  //Заполняем серии объектов
  SR:=Result.Serials.SerialList.CreateChild;
  SR.IdOwner:='e8a71fbf-55bc-11d9-848a-00112f43529a';
  SR.Relation:='';
  SR.Name:='до 20.12.16';
  SR.IdSerial:='0ed9fc88-d9fe-11e4-92f1-0050568b35ac';
  SR.Num:='';
  SR.Date:='2016-12-20T00:00:00';

  //Заполняем справочник штрихкодов
  BR:=Result.Barcodes.BarcodeList.CreateChild;
  BR.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
  BR.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
  BR.IdPack:='';
  BR.Barcode:='2000000000480';

  BR:=Result.Barcodes.BarcodeList.CreateChild;
  BR.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
  BR.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
  BR.IdPack:='f0e40f7b-7390-11df-b338-0011955cba6b';
  BR.Barcode:='2000000000497';

  BR:=Result.Barcodes.BarcodeList.CreateChild;
  BR.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
  BR.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
  BR.IdPack:='f0e40f7d-7390-11df-b338-0011955cba6b';
  BR.Barcode:='2000000000503';

  BR:=Result.Barcodes.BarcodeList.CreateChild;
  BR.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
  BR.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
  BR.IdPack:='dff7f708-7a0b-11df-b33a-0011955cba6b';
  BR.Barcode:='2000000000510';

  //Заполняем справочник единиц измерения
  MS:=Result.Measures.MeasureList.CreateChild;
  MS.IdMeasure:='bd72d90f-55bc-11d9-848a-00112f43529a';
  MS.Name:='пар';

  //Заполняем справочник цен
  PR:=Result.Prices.PriceList.CreateChild;
  PR.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
  PR.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
  PR.IdPack:='dff7f708-7a0b-11df-b33a-0011955cba6b';
  PR.Price:='8166.4';
  PR.Currency:='руб';

  //Заполняем справочник видов номенклатуры
  NT:=Result.NomenclatureTypes.NomenclatureTypeList.CreateChild;
  NT.IdNomenclatureType:='9c556d55-720f-11df-b436-0015e92f2802';
  NT.Name:='Холодильники';
  NT.IsChar:='0';
  NT.IsSerial:='0';
  NT.IsNomerSerial:='0';
  NT.IsDateSerial:='0';

  NT:=Result.NomenclatureTypes.NomenclatureTypeList.CreateChild;
  NT.IdNomenclatureType:='9c556d52-720f-11df-b436-0015e92f2802';
  NT.Name:='Электротовары';
  NT.IsChar:='0';
  NT.IsSerial:='0';
  NT.IsNomerSerial:='0';
  NT.IsDateSerial:='0';

  //Заполняем справочник складов
  rxSklad.First;
  while not rxSklad.EOF do
  begin
    Skld:=Result.Sclads.ScladList.CreateChild;
    Skld.IdSclad:=rxSkladSKLAD_ID.AsString;
    Skld.Name:=rxSkladSKLAD_NAME.AsString;
    Skld.IsAdress:=BoolToStr(rxSkladIsAdressExists.AsBoolean, '0', '1');
    Skld.IsOrder:=BoolToStr(rxSkladIsOrder.AsBoolean, '0', '1');
    rxSklad.Next;
  end;
end;

end.

