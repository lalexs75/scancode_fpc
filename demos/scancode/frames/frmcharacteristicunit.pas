unit frmCharacteristicUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, ComCtrls, DB, rxmemds,
  rxdbgrid, RxIniPropStorage, scancode_characteristics_api;

type

  { TfrmCharacteristicFrame }

  TfrmCharacteristicFrame = class(TFrame)
    Button1: TButton;
    dsGoods: TDataSource;
    dsMeasureList: TDataSource;
    dsSklad: TDataSource;
    dsrxNomenclatureTypes: TDataSource;
    PageControl1: TPageControl;
    Panel1: TPanel;
    RxDBGrid1: TRxDBGrid;
    RxDBGrid2: TRxDBGrid;
    RxDBGrid3: TRxDBGrid;
    RxDBGrid4: TRxDBGrid;
    rxGoodsGOODS_ATRTICLE: TStringField;
    rxGoodsGOODS_ID: TStringField;
    rxGoodsGOODS_IsAlco: TBooleanField;
    rxGoodsGOODS_NAME: TStringField;
    rxGoodsIdNomenclatureType: TStringField;
    rxGoodsIdPack: TStringField;
    rxGoodsMeasure_ID: TStringField;
    RxIniPropStorage1: TRxIniPropStorage;
    rxMeasureList: TRxMemoryData;
    rxMeasureListMeasure_ID: TStringField;
    rxMeasureListMeasure_NAME: TStringField;
    rxGoods: TRxMemoryData;
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
    Splitter1: TSplitter;
    StringField1: TStringField;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure rxGoodsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure rxNomenclatureTypesAfterScroll(DataSet: TDataSet);
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

procedure TfrmCharacteristicFrame.rxGoodsFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=rxGoodsIdNomenclatureType.AsString = rxNomenclatureTypesIdNomenclatureType.AsString;
end;

procedure TfrmCharacteristicFrame.rxNomenclatureTypesAfterScroll(
  DataSet: TDataSet);
begin
  rxGoods.First;
end;

procedure TfrmCharacteristicFrame.GenerateData;
begin
  rxSklad.Open;
  rxMeasureList.Open;
  rxNomenclatureTypes.Open;
  rxGoods.Open;

  rxSklad.AppendRecord(['5E5C46C3-44FF-443D-9503-646D342C2483', 'Склад № 1', true, true]);
  rxSklad.AppendRecord(['66570A44-5BF2-4DEA-9782-BFA176F7B7D5', 'Склад № 2', true, true]);
  rxSklad.AppendRecord(['8CFADDD2-C9F9-4658-8EDA-E7BF44B1597A', 'Склад № 3', true, true]);
  rxSklad.AppendRecord(['DFF040EB-ACFA-4C6A-9DB5-AB8867D7747C', 'Склад № 4 - Транзит', true, true]);

  rxMeasureList.AppendRecord(['C78F8CCC-1374-4B70-AEB6-CE27603527CA', 'шт']);
  rxMeasureList.AppendRecord(['468D6F31-DEFB-4BCF-835D-542B674A9973', 'кв.м.']);
  rxMeasureList.AppendRecord(['AB7DE341-7CCB-47BF-BAE1-FF358F3E7779', 'кг']);

  rxNomenclatureTypes.AppendRecord(['2E0369F2-1EC6-44B7-99EA-CCF3D3152B66', 'Бытовая химия', true, true, false, false]);
  rxNomenclatureTypes.AppendRecord(['DF5F28A5-5CD3-49D2-9979-FF206D6393F5', 'Хозяйственные товары, Садово-Огородный инвентарь', true, true, false, false]);
  rxNomenclatureTypes.AppendRecord(['94F0965D-E273-49A0-95CB-2A77F1A7D041', 'Строительно-дорожная, Коммунальная  техника', true, true, false, false]);
  rxNomenclatureTypes.AppendRecord(['4A53DD65-AE03-4BA3-92D0-85292E4C670A', 'Сантехнические изделия', true, true, false, false]);

  rxGoods.AppendRecord(['3C459E0E-2F3D-4285-90A6-0A1A2F776191', 'Пеногаситель (125мл)  Karcher 6.295-875.0 Керхер-Германия', 'C78F8CCC-1374-4B70-AEB6-CE27603527CA', '008.651.050', false, '2E0369F2-1EC6-44B7-99EA-CCF3D3152B66']);

  rxNomenclatureTypes.First;
  rxSklad.First;
  rxMeasureList.First;

  rxGoods.Filtered:=true;
  rxGoods.First;

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
  rxMeasureList.First;
  while not rxMeasureList.EOF do
  begin
    MS:=Result.Measures.MeasureList.CreateChild;
    MS.IdMeasure:=rxMeasureListMeasure_ID.AsString;
    MS.Name:=rxMeasureListMeasure_NAME.AsString;
    rxMeasureList.Next;
  end;

  //Заполняем справочник цен
  PR:=Result.Prices.PriceList.CreateChild;
  PR.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
  PR.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
  PR.IdPack:='dff7f708-7a0b-11df-b33a-0011955cba6b';
  PR.Price:='8166.4';
  PR.Currency:='руб';

  //Заполняем справочник видов номенклатуры
  rxNomenclatureTypes.First;
  while not rxNomenclatureTypes.EOF do
  begin
    NT:=Result.NomenclatureTypes.NomenclatureTypeList.CreateChild;
    NT.IdNomenclatureType:=rxNomenclatureTypesIdNomenclatureType.AsString;
    NT.Name:=rxNomenclatureTypesName.AsString;
    NT.IsChar:=BoolToStr(rxNomenclatureTypesIsChar.AsBoolean, '1', '0');
    NT.IsSerial:=BoolToStr(rxNomenclatureTypesIsSerial.AsBoolean, '1', '0');
    NT.IsNomerSerial:=BoolToStr(rxNomenclatureTypesIsNomerSerial.AsBoolean, '1', '0');
    NT.IsDateSerial:=BoolToStr(rxNomenclatureTypesIsDateSerial.AsBoolean, '1', '0');
    rxNomenclatureTypes.Next;
  end;

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

  rxSklad.First;
  rxMeasureList.First;
  rxNomenclatureTypes.First;
end;

end.

