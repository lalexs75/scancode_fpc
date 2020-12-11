{ interface library for FPC and Lazarus
  Copyright (C) 2019-2020 Lagunov Aleksey alexs75@yandex.ru

  Комплексный пример


  This library is free software; you can redistribute it and/or modify it
  under the terms of the GNU Library General Public License as published by
  the Free Software Foundation; either version 2 of the License, or (at your
  option) any later version with the following modification:

  As a special exception, the copyright holders of this library give you
  permission to link this library with independent modules to produce an
  executable, regardless of the license terms of these independent modules,and
  to copy and distribute the resulting executable under terms of your choice,
  provided that you also meet, for each linked independent module, the terms
  and conditions of the license of that module. An independent module is a
  module which is not derived from or based on this library. If you modify
  this library, you may extend this exception to your version of the library,
  but you are not obligated to do so. If you do not wish to do so, delete this
  exception statement from your version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
  for more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; if not, write to the Free Software Foundation,
  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
}

unit frmCharacteristicUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, ComCtrls, DB, rxmemds,
  rxdbgrid, RxIniPropStorage,
  AbstractSerializationObjects, GetData;

type

  { TfrmCharacteristicFrame }

  TfrmCharacteristicFrame = class(TFrame)
    Button1: TButton;
    dsPriceList: TDataSource;
    dsBarcode: TDataSource;
    dsGoods: TDataSource;
    dsMeasureList: TDataSource;
    dsSklad: TDataSource;
    dsrxNomenclatureTypes: TDataSource;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    Panel1: TPanel;
    rxBarcodeBARCODE: TStringField;
    rxBarcodeGOODS_ID: TStringField;
    RxDBGrid1: TRxDBGrid;
    RxDBGrid2: TRxDBGrid;
    RxDBGrid3: TRxDBGrid;
    RxDBGrid4: TRxDBGrid;
    RxDBGrid5: TRxDBGrid;
    RxDBGrid6: TRxDBGrid;
    rxGoodsGOODS_ATRTICLE: TStringField;
    rxGoodsGOODS_COUNTED: TFloatField;
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
    rxBarcode: TRxMemoryData;
    rxPriceList: TRxMemoryData;
    rxPriceListCHARACTERISTIC_ID: TStringField;
    rxPriceListCurrency_Name: TStringField;
    rxPriceListGOODS_ID: TStringField;
    rxPriceListPACK_ID: TStringField;
    rxPriceListPRICE: TCurrencyField;
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
    Splitter2: TSplitter;
    StringField1: TStringField;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure rxBarcodeFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure rxGoodsAfterScroll(DataSet: TDataSet);
    procedure rxGoodsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure rxNomenclatureTypesAfterScroll(DataSet: TDataSet);
    procedure rxPriceListFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private

  public
    procedure GenerateData;
    function CreateDictionarys(DI:TDocument):TDocument;
  end;

implementation
uses tsd_api_utils, scGlobal, ScancodeMT_utils;

{$R *.lfm}

{ TfrmCharacteristicFrame }

procedure TfrmCharacteristicFrame.Button1Click(Sender: TObject);
var
  DD: TDocument;
begin
  DD:=CreateDictionarys(nil);
  DD.SaveToFile(ExportFolder + 'Dictionary.xml');
  DD.Free;
end;

procedure TfrmCharacteristicFrame.rxBarcodeFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=rxGoodsGOODS_ID.AsString = rxBarcodeGOODS_ID.AsString;
end;

procedure TfrmCharacteristicFrame.rxGoodsAfterScroll(DataSet: TDataSet);
begin
  rxBarcode.First;
  rxPriceList.First;
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

procedure TfrmCharacteristicFrame.rxPriceListFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=rxGoodsGOODS_ID.AsString = rxPriceListGOODS_ID.AsString;
end;

procedure TfrmCharacteristicFrame.GenerateData;
begin
  rxSklad.Open;
  rxMeasureList.Open;
  rxNomenclatureTypes.Open;
  rxGoods.Open;
  rxPriceList.Open;
  rxBarcode.Open;

  rxGoods.AfterScroll:=nil;
  rxNomenclatureTypes.AfterScroll:=nil;

  rxSklad.AppendRecord([StockIDToGUID(1), 'Склад № 1', true, true]);
  rxSklad.AppendRecord([StockIDToGUID(2), 'Склад № 2', true, true]);
  rxSklad.AppendRecord([StockIDToGUID(3), 'Склад № 3', true, true]);
  rxSklad.AppendRecord([StockIDToGUID(4), 'Склад № 4 - Транзит', true, true]);

  rxMeasureList.AppendRecord([MeasureIDToGUID(1), 'шт']);
  rxMeasureList.AppendRecord([MeasureIDToGUID(2), 'кв.м.']);
  rxMeasureList.AppendRecord([MeasureIDToGUID(3), 'кг']);

  rxNomenclatureTypes.AppendRecord([NomenclatureIDToGUID(1), 'Бытовая химия', true, true, false, false]);
  rxNomenclatureTypes.AppendRecord([NomenclatureIDToGUID(2), 'Хозяйственные товары, Садово-Огородный инвентарь', true, true, false, false]);
  rxNomenclatureTypes.AppendRecord([NomenclatureIDToGUID(3), 'Строительно-дорожная, Коммунальная  техника', true, true, false, false]);
  rxNomenclatureTypes.AppendRecord([NomenclatureIDToGUID(4), 'Сантехнические изделия', true, true, false, false]);

  rxGoods.AppendRecord([GoodsIDToGUID(1), 'Пеногаситель (125мл)  Karcher 6.295-875.0 Керхер-Германия', MeasureIDToGUID(1), '008.651.050', false, NomenclatureIDToGUID(1), 44]);
  rxGoods.AppendRecord([GoodsIDToGUID(2), 'Шина легковая летняя R13''A\123-22"AAмм цв.Ж FIX, Блеклый, Красный, Синий, Чёрный', MeasureIDToGUID(2), '008.651.050', false, NomenclatureIDToGUID(1), 45.23]);
  rxGoods.AppendRecord([GoodsIDToGUID(3), 'Пеногаситель Karcher 6.295-875.0 Керхер-Германия', MeasureIDToGUID(1), '008.651.050', false, NomenclatureIDToGUID(1), 45.4]);

  rxGoods.AppendRecord([GoodsIDToGUID(4), 'Шина легковая летняя R13''A\123-22"AAмм цв.Ж FIX, Блеклый, Красный, Синий, Чёрный', MeasureIDToGUID(2), '001.651.050', false, NomenclatureIDToGUID(2), 23.11]);
  rxGoods.AppendRecord([GoodsIDToGUID(5), 'Шина легковая летняя R14', MeasureIDToGUID(2), '001.651.051', false, NomenclatureIDToGUID(2), 1]);
  rxGoods.AppendRecord([GoodsIDToGUID(6), 'Шина легковая летняя R16', MeasureIDToGUID(2), '001.651.052', false, NomenclatureIDToGUID(2), 2]);
  rxGoods.AppendRecord([GoodsIDToGUID(7), 'Шина легковая летняя R17', MeasureIDToGUID(2), '001.651.053', false, NomenclatureIDToGUID(2), 3]);

  rxGoods.AppendRecord([GoodsIDToGUID(8), 'Труба профильная 40x25x3,0 мм, L=6 м, Ст3пс, ГОСТ 8645-68', MeasureIDToGUID(3), '002.651.051', false, NomenclatureIDToGUID(3), 3]);
  rxGoods.AppendRecord([GoodsIDToGUID(9), 'Труба профильная 40x25', MeasureIDToGUID(3), '002.651.052', false, NomenclatureIDToGUID(3), 4]);
  rxGoods.AppendRecord([GoodsIDToGUID(10), 'Труба профильная 40x20', MeasureIDToGUID(3), '002.651.053', false, NomenclatureIDToGUID(3), 3.4]);
  rxGoods.AppendRecord([GoodsIDToGUID(11), 'Труба профильная 40x10', MeasureIDToGUID(3), '002.651.054', false, NomenclatureIDToGUID(3), 5]);


  rxBarcode.AppendRecord([GoodsIDToGUID(1), '20001001001']);
  rxBarcode.AppendRecord([GoodsIDToGUID(1), '20001001002']);
  rxBarcode.AppendRecord([GoodsIDToGUID(2), '20001001003']);
  rxBarcode.AppendRecord([GoodsIDToGUID(3), '20001001004']);
  rxBarcode.AppendRecord([GoodsIDToGUID(3), '20001001005']);
  rxBarcode.AppendRecord([GoodsIDToGUID(4), '20001001006']);
  rxBarcode.AppendRecord([GoodsIDToGUID(5), '20001001007']);
  rxBarcode.AppendRecord([GoodsIDToGUID(5), '20001001008']);
  rxBarcode.AppendRecord([GoodsIDToGUID(6), '20001001009']);
  rxBarcode.AppendRecord([GoodsIDToGUID(7), '20001001010']);
  rxBarcode.AppendRecord([GoodsIDToGUID(7), '20001001011']);

  rxPriceList.AppendRecord([GoodsIDToGUID(1), 121.4, 'руб.']);
  rxPriceList.AppendRecord([GoodsIDToGUID(2), 222, 'руб.']);
  rxPriceList.AppendRecord([GoodsIDToGUID(3), 323, 'руб.']);
  rxPriceList.AppendRecord([GoodsIDToGUID(4), 424, 'руб.']);
  rxPriceList.AppendRecord([GoodsIDToGUID(5), 525, 'руб.']);
  rxPriceList.AppendRecord([GoodsIDToGUID(6), 626, 'руб.']);
  rxPriceList.AppendRecord([GoodsIDToGUID(7), 727, 'руб.']);


  rxGoods.AfterScroll:=@rxGoodsAfterScroll;
  rxNomenclatureTypes.AfterScroll:=@rxNomenclatureTypesAfterScroll;

  rxNomenclatureTypes.First;
  rxSklad.First;
  rxMeasureList.First;

  rxGoods.Filtered:=true;
  rxGoods.First;

  rxBarcode.Filtered:=true;
  rxBarcode.First;

  rxPriceList.Filtered:=true;
  rxPriceList.First;
end;

function TfrmCharacteristicFrame.CreateDictionarys(DI: TDocument): TDocument;
var
(*  G:TDocument_table_record;
  BR:TDocument_barcodes_record;
  MS:TDocument_measures_record;
  PR:TDocument_prices_record;
  NT:TDocument_vidnomencls_record;
  Skld:TDocument_sclads_record; *)
  ID: Integer;
  S: String;
begin
  if Assigned(DI) then
    Result:=DI
  else
    Result:=TDocument.Create;
(*
  rxBarcode.Filtered:=false;
  rxGoods.Filtered:=false;
  rxGoods.AfterScroll:=nil;
  rxNomenclatureTypes.AfterScroll:=nil;
  rxPriceList.Filtered:=false;

  //Заполняем справочник товаров
  rxGoods.First;
  while not rxGoods.EOF do
  begin
    G:=Result.table.record1.AddItem;
    G.id_goods:=rxGoodsGOODS_ID.AsString;
    G.Name:=rxGoodsGOODS_NAME.AsString;
    G.id_measure:=rxGoodsMeasure_ID.AsString;
    G.Art:=rxGoodsGOODS_ATRTICLE.AsString;
    G.Alco:=Ord(rxGoodsGOODS_IsAlco.AsBoolean);
    G.id_vidnomencl:=rxGoodsIdNomenclatureType.AsString;
    //G.IdNaborPack:='';
    //G.Img:='';
    //G.Bitmap:='';

    ID:=GUIDToGoodsID(rxGoodsGOODS_ID.AsString);
    S:=ExtractFileDir(ParamStr(0))+PathDelim + 'goods_images' + PathDelim + IntToStr(id)+'.jpg';
    if FileExists(S) then
      G.LoadImage(S);
    G.marked:=0;
    rxGoods.Next;
  end;
(*
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
*)
  //Заполняем справочник штрихкодов
  rxBarcode.First;
  while not rxBarcode.EOF do
  begin
    BR:=Result.Barcodes.record1.AddItem;
    BR.id_goods:=rxBarcodeGOODS_ID.AsString;
    //BR.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
    //BR.IdPack:='';
    BR.Barcode:=rxBarcodeBARCODE.AsString;
    rxBarcode.Next;
  end;


  //Заполняем справочник единиц измерения
  rxMeasureList.First;
  while not rxMeasureList.EOF do
  begin
    MS:=Result.Measures.record1.AddItem;
    MS.id_measure:=rxMeasureListMeasure_ID.AsString;
    MS.Name:=rxMeasureListMeasure_NAME.AsString;

    rxMeasureList.Next;
  end;

  //Заполняем справочник цен
  rxPriceList.First;
  while not rxPriceList.EOF do
  begin
    PR:=Result.Prices.record1.AddItem;
    PR.id_goods:=rxPriceListGOODS_ID.AsString;
    PR.Price:=FloatToStr(rxPriceListPRICE.AsCurrency);
    PR.Currency:=rxPriceListCurrency_Name.AsString;
    //PR.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
    //PR.IdPack:='dff7f708-7a0b-11df-b33a-0011955cba6b';

    rxPriceList.Next;
  end;

  //Заполняем справочник видов номенклатуры
  rxNomenclatureTypes.First;
  while not rxNomenclatureTypes.EOF do
  begin
    NT:=Result.vidnomencls.record1.AddItem;
    NT.id_vidnomencl:=rxNomenclatureTypesIdNomenclatureType.AsString;
    NT.Name:=rxNomenclatureTypesName.AsString;
    NT.is_char:=Ord(rxNomenclatureTypesIsChar.AsBoolean);
    NT.is_serial:=Ord(rxNomenclatureTypesIsSerial.AsBoolean);
    NT.is_nomer_serial:=Ord(rxNomenclatureTypesIsNomerSerial.AsBoolean);
    NT.is_date_serial:=Ord(rxNomenclatureTypesIsDateSerial.AsBoolean);

    rxNomenclatureTypes.Next;
  end;

  //Заполняем справочник складов
  rxSklad.First;
  while not rxSklad.EOF do
  begin
    Skld:=Result.Sclads.record1.AddItem;
    Skld.id_sclad:=rxSkladSKLAD_ID.AsString;
    Skld.Name:=rxSkladSKLAD_NAME.AsString;
    Skld.is_adress:=Ord(rxSkladIsAdressExists.AsBoolean);
    Skld.is_order:=Ord(rxSkladIsOrder.AsBoolean);

    rxSklad.Next;
  end;

  rxSklad.First;
  rxMeasureList.First;
  rxNomenclatureTypes.First;
  rxBarcode.First;
  rxGoods.First;

  rxGoods.AfterScroll:=@rxGoodsAfterScroll;
  rxNomenclatureTypes.AfterScroll:=@rxNomenclatureTypesAfterScroll;

  rxPriceList.Filtered:=true;
  rxGoods.Filtered:=true;
  rxBarcode.Filtered:=true;
*)
end;

end.

