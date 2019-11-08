{ interface library for FPC and Lazarus
  Copyright (C) 2019 Lagunov Aleksey alexs75@yandex.ru

  Генерация xml файлов в формате обеман данными для СКАНКОД.Мобильный Терминал (SCANCODE.MobileTerminal)

  Структуры данных базируются на основании:

                   Описание структуры XML файлов
                        обмена для программы
                    СКАНКОД.Мобильный Терминал
                           версия 1.2.9
               протокол обмена данными с 1С версия 3


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

unit scancode_characteristics_api;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject;

type

  { TSclad }

  TSclad = class(TXmlSerializationObject)
  private
    FIdSclad: string;
    FIsAdress: string;
    FIsOrder: string;
    FName: string;
    procedure SetIdSclad(AValue: string);
    procedure SetIsAdress(AValue: string);
    procedure SetIsOrder(AValue: string);
    procedure SetName(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property IdSclad:string read FIdSclad write SetIdSclad;
    property Name:string read FName write SetName;
    property IsAdress:string read FIsAdress write SetIsAdress;
    property IsOrder:string read FIsOrder write SetIsOrder;
  end;

  { TScladList }

  TScladList = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TSclad; inline;
  public
    constructor Create;
    function CreateChild:TSclad;
    property Item[AIndex:Integer]:TSclad read GetItem; default;
  end;

  { TSclads }

  TSclads = class(TXmlSerializationObject)
  private
    FScladList: TScladList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property ScladList:TScladList read FScladList;
  end;

  { TNomenclatureType }

  TNomenclatureType = class(TXmlSerializationObject)
  private
    FIdNomenclatureType: string;
    FIsChar: string;
    FIsDateSerial: string;
    FIsNomerSerial: string;
    FIsSerial: string;
    FName: string;
    procedure SetIdNomenclatureType(AValue: string);
    procedure SetIsChar(AValue: string);
    procedure SetIsDateSerial(AValue: string);
    procedure SetIsNomerSerial(AValue: string);
    procedure SetIsSerial(AValue: string);
    procedure SetName(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property IdNomenclatureType:string read FIdNomenclatureType write SetIdNomenclatureType;
    property Name:string read FName write SetName;
    property IsChar:string read FIsChar write SetIsChar;
    property IsSerial:string read FIsSerial write SetIsSerial;
    property IsNomerSerial:string read FIsNomerSerial write SetIsNomerSerial;
    property IsDateSerial:string read FIsDateSerial write SetIsDateSerial;
  end;

  { TNomenclatureTypeList }

  TNomenclatureTypeList = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TNomenclatureType; inline;
  public
    constructor Create;
    function CreateChild:TNomenclatureType;
    property Item[AIndex:Integer]:TNomenclatureType read GetItem; default;
  end;

  { TNomenclatureTypes }

  TNomenclatureTypes = class(TXmlSerializationObject)
  private
    FNomenclatureTypeList: TNomenclatureTypeList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property NomenclatureTypeList:TNomenclatureTypeList read FNomenclatureTypeList;
  end;

  { TPrice }

  TPrice = class(TXmlSerializationObject)
  private
    FCurrency: string;
    FIdChar: string;
    FIdGoods: string;
    FIdPack: string;
    FPrice: string;
    procedure SetCurrency(AValue: string);
    procedure SetIdChar(AValue: string);
    procedure SetIdGoods(AValue: string);
    procedure SetIdPack(AValue: string);
    procedure SetPrice(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property Price:string read FPrice write SetPrice;
    property Currency:string read FCurrency write SetCurrency;
    property IdGoods:string read FIdGoods write SetIdGoods;
    property IdChar:string read FIdChar write SetIdChar;
    property IdPack:string read FIdPack write SetIdPack;
  end;

  { TPriceList }

  TPriceList = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TPrice; inline;
  public
    constructor Create;
    function CreateChild:TPrice;
    property Item[AIndex:Integer]:TPrice read GetItem; default;
  end;

  { TPrices }

  TPrices = class(TXmlSerializationObject)
  private
    FPriceList: TPriceList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property PriceList:TPriceList read FPriceList;
  end;


  { TMeasure }

  TMeasure = class(TXmlSerializationObject)
  private
    FIdMeasure: string;
    FName: string;
    procedure SetIdMeasure(AValue: string);
    procedure SetName(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property IdMeasure:string read FIdMeasure write SetIdMeasure;
    property Name:string read FName write SetName;
  end;

  { TMeasureList }

  TMeasureList = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TMeasure; inline;
  public
    constructor Create;
    function CreateChild:TMeasure;
    property Item[AIndex:Integer]:TMeasure read GetItem; default;
  end;

  { TMeasures }

  TMeasures = class(TXmlSerializationObject)
  private
    FMeasureList: TMeasureList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property MeasureList:TMeasureList read FMeasureList;
  end;

  { TBarcode }

  TBarcode = class(TXmlSerializationObject)
  private
    FBarcode: string;
    FIdChar: string;
    FIdGoods: string;
    FIdPack: string;
    procedure SetBarcode(AValue: string);
    procedure SetIdChar(AValue: string);
    procedure SetIdGoods(AValue: string);
    procedure SetIdPack(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property Barcode:string read FBarcode write SetBarcode;
    property IdGoods:string read FIdGoods write SetIdGoods;
    property IdChar:string read FIdChar write SetIdChar;
    property IdPack:string read FIdPack write SetIdPack;
  end;

  { TBarcodeList }

  TBarcodeList = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TBarcode; inline;
  public
    constructor Create;
    function CreateChild:TBarcode;
    property Item[AIndex:Integer]:TBarcode read GetItem; default;
  end;

  { TBarcodes }

  TBarcodes = class(TXmlSerializationObject)
  private
    FBarcodeList: TBarcodeList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property BarcodeList:TBarcodeList read FBarcodeList;
  end;

  { TSerial }

  TSerial = class(TXmlSerializationObject)
  private
    FDate: string;
    FIdOwner: string;
    FIdSerial: string;
    FName: string;
    FNum: string;
    FRelation: string;
    procedure SetDate(AValue: string);
    procedure SetIdOwner(AValue: string);
    procedure SetIdSerial(AValue: string);
    procedure SetName(AValue: string);
    procedure SetNum(AValue: string);
    procedure SetRelation(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property Name:string read FName write SetName;
    property IdSerial:string read FIdSerial write SetIdSerial;
    property Num:string read FNum write SetNum;
    property Date:string read FDate write SetDate;
    property IdOwner:string read FIdOwner write SetIdOwner;
    property Relation:string read FRelation write SetRelation;
  end;

  { TSerialList }

  TSerialList = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TSerial; inline;
  public
    constructor Create;
    function CreateChild:TSerial;
    property Item[AIndex:Integer]:TSerial read GetItem; default;
  end;

  { TSerials }

  TSerials = class(TXmlSerializationObject)
  private
    FSerialList: TSerialList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property SerialList:TSerialList read FSerialList;
  end;

  { TPack }

  TPack = class(TXmlSerializationObject)
  private
    FIdOwner: string;
    FIdPack: string;
    FKoeff: string;
    FName: string;
    FRelation: string;
    procedure SetIdOwner(AValue: string);
    procedure SetIdPack(AValue: string);
    procedure SetKoeff(AValue: string);
    procedure SetName(AValue: string);
    procedure SetRelation(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property Name:string read FName write SetName;
    property IdPack:string read FIdPack write SetIdPack;
    property Koeff:string read FKoeff write SetKoeff;
    property IdOwner:string read FIdOwner write SetIdOwner;
    property Relation:string read FRelation write SetRelation;
  end;

  { TPackList }

  TPackList = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TPack; inline;
  public
    constructor Create;
    function CreateChild:TPack;
    property Item[AIndex:Integer]:TPack read GetItem; default;
  end;

  { TPacks }

  TPacks = class(TXmlSerializationObject)
  private
    FPackList: TPackList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property PackList:TPackList read FPackList;
  end;
  { TCharacteristic }

  TCharacteristic = class(TXmlSerializationObject)
  private
    FIdChar: string;
    FIdOwner: string;
    FName: string;
    FRelation: string;
    procedure SetIdChar(AValue: string);
    procedure SetIdOwner(AValue: string);
    procedure SetName(AValue: string);
    procedure SetRelation(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property Name:string read FName write SetName;
    property IdChar:string read FIdChar write SetIdChar;
    property IdOwner:string read FIdOwner write SetIdOwner;
    property Relation:string read FRelation write SetRelation;
  end;

  { TCharacteristicList }

  TCharacteristicList = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TCharacteristic; inline;
  public
    constructor Create;
    function CreateChild:TCharacteristic;
    property Item[AIndex:Integer]:TCharacteristic read GetItem; default;
  end;

  { TCharacteristics }

  TCharacteristics = class(TXmlSerializationObject)
  private
    FCharacteristicList: TCharacteristicList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property CharacteristicList:TCharacteristicList read FCharacteristicList;
  end;

  { TSprGood }

  TSprGood = class(TXmlSerializationObject)
  private
    FAlco: string;
    FArt: string;
    FBitmap: string;
    FIdGoods: string;
    FIdMeasure: string;
    FIdNaborPack: string;
    FIdVidnomencl: string;
    FImg: string;
    FName: string;
    procedure SetAlco(AValue: string);
    procedure SetArt(AValue: string);
    procedure SetBitmap(AValue: string);
    procedure SetIdGoods(AValue: string);
    procedure SetIdMeasure(AValue: string);
    procedure SetIdNaborPack(AValue: string);
    procedure SetIdVidnomencl(AValue: string);
    procedure SetImg(AValue: string);
    procedure SetName(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property IdGoods:string read FIdGoods write SetIdGoods;
    property Name:string read FName write SetName;
    property IdMeasure:string read FIdMeasure write SetIdMeasure;
    property Art:string read FArt write SetArt;
    property Alco:string read FAlco write SetAlco;
    property IdVidnomencl:string read FIdVidnomencl write SetIdVidnomencl;
    property IdNaborPack:string read FIdNaborPack write SetIdNaborPack;
    property Img:string read FImg write SetImg;
    property Bitmap:string read FBitmap write SetBitmap;
  end;

  { TSprGoodLists }

  TSprGoodLists = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TSprGood; inline;
  public
    constructor Create;
    function CreateChild:TSprGood;
    property Item[AIndex:Integer]:TSprGood read GetItem; default;
  end;

  { TSprGoods }

  TSprGoods = class(TXmlSerializationObject)
  private
    FSprGoodLists: TSprGoodLists;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property SprGoodLists:TSprGoodLists read FSprGoodLists;
  end;


  { TDictionary }

  TDictionary = class(TXmlSerializationObject)
  private
    FBarcodes: TBarcodes;
    FCharacteristics: TCharacteristics;
    FMeasures: TMeasures;
    FNomenclatureTypes: TNomenclatureTypes;
    FPacks: TPacks;
    FPrices: TPrices;
    FSclads: TSclads;
    FSerials: TSerials;
    FSprGoods: TSprGoods;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    destructor Destroy; override;
  published
    property SprGoods:TSprGoods read FSprGoods;
    property Characteristics:TCharacteristics read FCharacteristics;
    property Packs:TPacks read FPacks;
    property Serials:TSerials read FSerials;
    property Barcodes:TBarcodes read  FBarcodes;
    property Measures:TMeasures read FMeasures;
    property Prices:TPrices read FPrices;
    property NomenclatureTypes:TNomenclatureTypes read FNomenclatureTypes;
    property Sclads:TSclads read FSclads;
  end;

  { TQueryGood }

  TQueryGood = class(TXmlSerializationObject)
  private
    FIdChar: string;
    FIdGoods: string;
    FIdSklad: string;
    procedure SetIdChar(AValue: string);
    procedure SetIdGoods(AValue: string);
    procedure SetIdSklad(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property IdGoods:string read FIdGoods write SetIdGoods;
    property IdSklad:string read FIdSklad write SetIdSklad;
    property IdChar:string read FIdChar write SetIdChar;
  end;

  { TQueryGoodList }

  TQueryGoodList = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TQueryGood; inline;
  public
    constructor Create;
    function CreateChild:TQueryGood;
    property Item[AIndex:Integer]:TQueryGood read GetItem; default;
  end;

  { TQueryGoods }
  TQueryGoods = class(TXmlSerializationObject)
  private
    FGoodList: TQueryGoodList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    destructor Destroy; override;
  published
    property GoodList:TQueryGoodList read FGoodList;
  end;

implementation

{ TQueryGoodList }

function TQueryGoodList.GetItem(AIndex: Integer): TQueryGood;
begin
  Result:=TQueryGood(InternalGetItem(AIndex));
end;

constructor TQueryGoodList.Create;
begin
  inherited Create(TQueryGood)
end;

function TQueryGoodList.CreateChild: TQueryGood;
begin
  Result:=InternalAddObject as TQueryGood;
end;

{ TQueryGood }

procedure TQueryGood.SetIdChar(AValue: string);
begin
  if FIdChar=AValue then Exit;
  FIdChar:=AValue;
  ModifiedProperty('IdChar');
end;

procedure TQueryGood.SetIdGoods(AValue: string);
begin
  if FIdGoods=AValue then Exit;
  FIdGoods:=AValue;
  ModifiedProperty('IdGoods');
end;

procedure TQueryGood.SetIdSklad(AValue: string);
begin
  if FIdSklad=AValue then Exit;
  FIdSklad:=AValue;
  ModifiedProperty('IdSklad');
end;

procedure TQueryGood.InternalRegisterPropertys;
begin
  RegisterProperty('IdGoods', 'id_goods', 'О', '', 1, 255);
  RegisterProperty('IdSklad', 'id_sklad', 'О', '', 1, 255);
  RegisterProperty('IdChar', 'id_char', 'О', '', 1, 255);
end;

procedure TQueryGood.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TQueryGood.Destroy;
begin
  inherited Destroy;
end;

{ TQueryGoods }

procedure TQueryGoods.InternalRegisterPropertys;
begin
  RegisterProperty('GoodList', 'Record', 'О', 'Список товаров', -1, -1);
end;

procedure TQueryGoods.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FGoodList:=TQueryGoodList.Create;
end;

function TQueryGoods.RootNodeName: string;
begin
  Result:='Table';
end;

destructor TQueryGoods.Destroy;
begin
  FreeAndNil(FGoodList);
  inherited Destroy;
end;

{ TSclad }

procedure TSclad.SetIdSclad(AValue: string);
begin
  if FIdSclad=AValue then Exit;
  FIdSclad:=AValue;
  ModifiedProperty('IdSclad');
end;

procedure TSclad.SetIsAdress(AValue: string);
begin
  if FIsAdress=AValue then Exit;
  FIsAdress:=AValue;
  ModifiedProperty('IsAdress');
end;

procedure TSclad.SetIsOrder(AValue: string);
begin
  if FIsOrder=AValue then Exit;
  FIsOrder:=AValue;
  ModifiedProperty('IsOrder');
end;

procedure TSclad.SetName(AValue: string);
begin
  if FName=AValue then Exit;
  FName:=AValue;
  ModifiedProperty('Name');
end;

procedure TSclad.InternalRegisterPropertys;
begin
  RegisterProperty('IdSclad', 'id_sclad', 'О', 'guid склада', 0, 250);
  RegisterProperty('Name', 'name', 'О', 'наименование склада', 0, 250);
  RegisterProperty('IsAdress', 'is_adress', 'О', 'признак использования адресного хранения', 0, 250);
  RegisterProperty('IsOrder', 'is_order', 'О', 'признак использования ордерной схемы', 0, 250);
end;

procedure TSclad.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TSclad.Destroy;
begin
  inherited Destroy;
end;

{ TScladList }

function TScladList.GetItem(AIndex: Integer): TSclad;
begin
  Result:=TSclad(InternalGetItem(AIndex));
end;

constructor TScladList.Create;
begin
  inherited Create(TSclad)
end;

function TScladList.CreateChild: TSclad;
begin
  Result:=InternalAddObject as TSclad;
end;

{ TSclads }

procedure TSclads.InternalRegisterPropertys;
begin
  RegisterProperty('ScladList', 'record', 'О', '', -1, -1);
end;

procedure TSclads.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FScladList:=TScladList.Create;
end;

destructor TSclads.Destroy;
begin
  FreeAndNil(FScladList);
  inherited Destroy;
end;

{ TNomenclatureType }

procedure TNomenclatureType.SetIdNomenclatureType(AValue: string);
begin
  if FIdNomenclatureType=AValue then Exit;
  FIdNomenclatureType:=AValue;
  ModifiedProperty('IdNomenclatureType');
end;

procedure TNomenclatureType.SetIsChar(AValue: string);
begin
  if FIsChar=AValue then Exit;
  FIsChar:=AValue;
  ModifiedProperty('IsChar');
end;

procedure TNomenclatureType.SetIsDateSerial(AValue: string);
begin
  if FIsDateSerial=AValue then Exit;
  FIsDateSerial:=AValue;
  ModifiedProperty('IsDateSerial');
end;

procedure TNomenclatureType.SetIsNomerSerial(AValue: string);
begin
  if FIsNomerSerial=AValue then Exit;
  FIsNomerSerial:=AValue;
  ModifiedProperty('IsNomerSerial');
end;

procedure TNomenclatureType.SetIsSerial(AValue: string);
begin
  if FIsSerial=AValue then Exit;
  FIsSerial:=AValue;
  ModifiedProperty('IsSerial');
end;

procedure TNomenclatureType.SetName(AValue: string);
begin
  if FName=AValue then Exit;
  FName:=AValue;
  ModifiedProperty('Name');
end;

procedure TNomenclatureType.InternalRegisterPropertys;
begin
  RegisterProperty('IdNomenclatureType', 'id_vidnomencl', 'О', 'guid вида номенклатуры', 0, 250);
  RegisterProperty('Name', 'name', 'О', 'наименование вида номенклатуры', 0, 250);
  RegisterProperty('IsChar', 'is_char', 'О', 'признак если ли характеристика', 0, 250);
  RegisterProperty('IsSerial', 'is_serial', 'О', 'признак есть ли серии', 0, 250);
  RegisterProperty('IsNomerSerial', 'is_nomer_serial', 'О', 'серии в виде номера (последовательности символов)', 0, 250);
  RegisterProperty('IsDateSerial', 'is_date_serial', 'О', 'серии в виде срока годности', 0, 250);
end;

procedure TNomenclatureType.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TNomenclatureType.Destroy;
begin
  inherited Destroy;
end;

{ TNomenclatureTypeList }

function TNomenclatureTypeList.GetItem(AIndex: Integer): TNomenclatureType;
begin
  Result:=TNomenclatureType(InternalGetItem(AIndex));
end;

constructor TNomenclatureTypeList.Create;
begin
  inherited Create(TNomenclatureType)
end;

function TNomenclatureTypeList.CreateChild: TNomenclatureType;
begin
  Result:=InternalAddObject as TNomenclatureType;
end;

{ TNomenclatureTypes }

procedure TNomenclatureTypes.InternalRegisterPropertys;
begin
  RegisterProperty('NomenclatureTypeList', 'record', 'О', '', -1, -1);
end;

procedure TNomenclatureTypes.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FNomenclatureTypeList:=TNomenclatureTypeList.Create;
end;

destructor TNomenclatureTypes.Destroy;
begin
  FreeAndNil(FNomenclatureTypeList);
  inherited Destroy;
end;

{ TPrice }

procedure TPrice.SetCurrency(AValue: string);
begin
  if FCurrency=AValue then Exit;
  FCurrency:=AValue;
  ModifiedProperty('Currency');
end;

procedure TPrice.SetIdChar(AValue: string);
begin
  if FIdChar=AValue then Exit;
  FIdChar:=AValue;
  ModifiedProperty('IdChar');
end;

procedure TPrice.SetIdGoods(AValue: string);
begin
  if FIdGoods=AValue then Exit;
  FIdGoods:=AValue;
  ModifiedProperty('IdGoods');
end;

procedure TPrice.SetIdPack(AValue: string);
begin
  if FIdPack=AValue then Exit;
  FIdPack:=AValue;
  ModifiedProperty('IdPack');
end;

procedure TPrice.SetPrice(AValue: string);
begin
  if FPrice=AValue then Exit;
  FPrice:=AValue;
  ModifiedProperty('Price');
end;

procedure TPrice.InternalRegisterPropertys;
begin
  RegisterProperty('Price', 'price', 'О', 'числовое представление цены', 0, 250);
  RegisterProperty('Currency', 'currency', 'О', 'валюта', 0, 250);
  RegisterProperty('IdGoods', 'id_goods', 'О', 'guid идентификатор товара', 0, 250);
  RegisterProperty('IdChar', 'id_char', 'О', 'guid идентификатор характеристики', 0, 250);
  RegisterProperty('IdPack', 'id_pack', 'О', 'guid идентификатор упаковки', 0, 250);
end;

procedure TPrice.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TPrice.Destroy;
begin
  inherited Destroy;
end;

{ TPriceList }

function TPriceList.GetItem(AIndex: Integer): TPrice;
begin
  Result:=TPrice(InternalGetItem(AIndex));
end;

constructor TPriceList.Create;
begin
  inherited Create(TPrice)
end;

function TPriceList.CreateChild: TPrice;
begin
  Result:=InternalAddObject as TPrice;
end;

{ TPrices }

procedure TPrices.InternalRegisterPropertys;
begin
  RegisterProperty('PriceList', 'record', 'О', '', -1, -1);
end;

procedure TPrices.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FPriceList:=TPriceList.Create;
end;

destructor TPrices.Destroy;
begin
  FreeAndNil(FPriceList);
  inherited Destroy;
end;

{ TMeasure }

procedure TMeasure.SetIdMeasure(AValue: string);
begin
  if FIdMeasure=AValue then Exit;
  FIdMeasure:=AValue;
  ModifiedProperty('IdMeasure');
end;

procedure TMeasure.SetName(AValue: string);
begin
  if FName=AValue then Exit;
  FName:=AValue;
  ModifiedProperty('Name');
end;

procedure TMeasure.InternalRegisterPropertys;
begin
  RegisterProperty('IdMeasure', 'id_measure', 'О', 'идентификатор ед. измерения', 0, 250);
  RegisterProperty('Name', 'name', 'О', 'наименование ед. измерения', 0, 250);
end;

procedure TMeasure.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TMeasure.Destroy;
begin
  inherited Destroy;
end;

{ TMeasureList }

function TMeasureList.GetItem(AIndex: Integer): TMeasure;
begin
  Result:=TMeasure(InternalGetItem(AIndex));
end;

constructor TMeasureList.Create;
begin
  inherited Create(TMeasure)
end;

function TMeasureList.CreateChild: TMeasure;
begin
  Result:=InternalAddObject as TMeasure;
end;

{ TMeasures }

procedure TMeasures.InternalRegisterPropertys;
begin
  RegisterProperty('MeasureList', 'record', 'О', '', -1, -1);
end;

procedure TMeasures.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FMeasureList:=TMeasureList.Create;
end;

destructor TMeasures.Destroy;
begin
  FreeAndNil(FMeasureList);
  inherited Destroy;
end;

{ TBarcode }

procedure TBarcode.SetBarcode(AValue: string);
begin
  if FBarcode=AValue then Exit;
  FBarcode:=AValue;
  ModifiedProperty('Barcode');
end;

procedure TBarcode.SetIdChar(AValue: string);
begin
  if FIdChar=AValue then Exit;
  FIdChar:=AValue;
  ModifiedProperty('IdChar');
end;

procedure TBarcode.SetIdGoods(AValue: string);
begin
  if FIdGoods=AValue then Exit;
  FIdGoods:=AValue;
  ModifiedProperty('IdGoods');
end;

procedure TBarcode.SetIdPack(AValue: string);
begin
  if FIdPack=AValue then Exit;
  FIdPack:=AValue;
  ModifiedProperty('IdPack');
end;

procedure TBarcode.InternalRegisterPropertys;
begin
  RegisterProperty('Barcode', 'barcode', 'О', 'строковое значение штрихкода', 0, 250);
  RegisterProperty('IdGoods', 'id_goods', 'О', 'guid идентификатор товара', 0, 250);
  RegisterProperty('IdChar', 'id_char', 'О', 'guid идентификатор характеристики', 0, 250);
  RegisterProperty('IdPack', 'id_pack', 'О', 'guid идентификатор упаковки', 0, 250);
end;

procedure TBarcode.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TBarcode.Destroy;
begin
  inherited Destroy;
end;

{ TBarcodeList }

function TBarcodeList.GetItem(AIndex: Integer): TBarcode;
begin
  Result:=TBarcode(InternalGetItem(AIndex));
end;

constructor TBarcodeList.Create;
begin
  inherited Create(TBarcode)
end;

function TBarcodeList.CreateChild: TBarcode;
begin
  Result:=InternalAddObject as TBarcode;
end;

{ TBarcodes }

procedure TBarcodes.InternalRegisterPropertys;
begin
  RegisterProperty('BarcodeList', 'record', 'О', '', -1, -1);
end;

procedure TBarcodes.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FBarcodeList:=TBarcodeList.Create;
end;

destructor TBarcodes.Destroy;
begin
  FreeAndNil(FBarcodeList);
  inherited Destroy;
end;

{ TSerial }

procedure TSerial.SetDate(AValue: string);
begin
  if FDate=AValue then Exit;
  FDate:=AValue;
  ModifiedProperty('Date');
end;

procedure TSerial.SetIdOwner(AValue: string);
begin
  if FIdOwner=AValue then Exit;
  FIdOwner:=AValue;
  ModifiedProperty('IdOwner');
end;

procedure TSerial.SetIdSerial(AValue: string);
begin
  if FIdSerial=AValue then Exit;
  FIdSerial:=AValue;
  ModifiedProperty('IdSerial');
end;

procedure TSerial.SetName(AValue: string);
begin
  if FName=AValue then Exit;
  FName:=AValue;
  ModifiedProperty('Name');
end;

procedure TSerial.SetNum(AValue: string);
begin
  if FNum=AValue then Exit;
  FNum:=AValue;
  ModifiedProperty('Num');
end;

procedure TSerial.SetRelation(AValue: string);
begin
  if FRelation=AValue then Exit;
  FRelation:=AValue;
  ModifiedProperty('Relation');
end;

procedure TSerial.InternalRegisterPropertys;
begin
  RegisterProperty('Name', 'name', 'О', 'наименование серии', 0, 250);
  RegisterProperty('IdSerial', 'id_serial', 'О', 'идентификатор серии', 0, 250);
  RegisterProperty('Num', 'num', 'О', 'номер серии', 0, 250);
  RegisterProperty('Date', 'date', 'О', 'дата окончания срока годности товара', 0, 250);
  RegisterProperty('IdOwner', 'id_owner', 'О', 'guid идентификатор владельца', 0, 250);
  RegisterProperty('Relation', 'relation', 'О', 'указывает на объект владельца ', 0, 250);
end;

procedure TSerial.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TSerial.Destroy;
begin
  inherited Destroy;
end;

{ TSerialList }

function TSerialList.GetItem(AIndex: Integer): TSerial;
begin
  Result:=TSerial(InternalGetItem(AIndex));
end;

constructor TSerialList.Create;
begin
  inherited Create(TSerial)
end;

function TSerialList.CreateChild: TSerial;
begin
  Result:=InternalAddObject as TSerial;
end;

{ TSerials }

procedure TSerials.InternalRegisterPropertys;
begin
  RegisterProperty('SerialList', 'record', 'О', '', -1, -1);
end;

procedure TSerials.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FSerialList:=TSerialList.Create;
end;

destructor TSerials.Destroy;
begin
  FreeAndNil(FSerialList);
  inherited Destroy;
end;

{ TPack }

procedure TPack.SetIdOwner(AValue: string);
begin
  if FIdOwner=AValue then Exit;
  FIdOwner:=AValue;
  ModifiedProperty('IdOwner');
end;

procedure TPack.SetIdPack(AValue: string);
begin
  if FIdPack=AValue then Exit;
  FIdPack:=AValue;
  ModifiedProperty('IdPack');
end;

procedure TPack.SetKoeff(AValue: string);
begin
  if FKoeff=AValue then Exit;
  FKoeff:=AValue;
  ModifiedProperty('Koeff');
end;

procedure TPack.SetName(AValue: string);
begin
  if FName=AValue then Exit;
  FName:=AValue;
  ModifiedProperty('Name');
end;

procedure TPack.SetRelation(AValue: string);
begin
  if FRelation=AValue then Exit;
  FRelation:=AValue;
  ModifiedProperty('Relation');
end;

procedure TPack.InternalRegisterPropertys;
begin
  RegisterProperty('Name', 'name', 'О', 'наименование упаковки', 0, 250);
  RegisterProperty('IdPack', 'id_pack', 'О', 'guid идентификатор упаковки', 0, 250);
  RegisterProperty('Koeff', 'koeff', 'О', 'коэффициент пересчета в базовые единицы измерения', 0, 250);
  RegisterProperty('IdOwner', 'id_owner', 'О', 'guid идентификатор владельца', 0, 250);
  RegisterProperty('Relation', 'relation', 'О', 'указывает на объект владельца', 0, 250);
end;

procedure TPack.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TPack.Destroy;
begin
  inherited Destroy;
end;

{ TPackList }

function TPackList.GetItem(AIndex: Integer): TPack;
begin
  Result:=TPack(InternalGetItem(AIndex));
end;

constructor TPackList.Create;
begin
  inherited Create(TPack)
end;

function TPackList.CreateChild: TPack;
begin
  Result:=InternalAddObject as TPack;
end;

{ TPacks }

procedure TPacks.InternalRegisterPropertys;
begin
  RegisterProperty('PackList', 'record', 'О', '', -1, -1);
end;

procedure TPacks.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FPackList:=TPackList.Create;
end;

destructor TPacks.Destroy;
begin
  FreeAndNil(FPackList);
  inherited Destroy;
end;

{ TCharacteristic }

procedure TCharacteristic.SetIdChar(AValue: string);
begin
  if FIdChar=AValue then Exit;
  FIdChar:=AValue;
  ModifiedProperty('IdChar');
end;

procedure TCharacteristic.SetIdOwner(AValue: string);
begin
  if FIdOwner=AValue then Exit;
  FIdOwner:=AValue;
  ModifiedProperty('IdOwner');
end;

procedure TCharacteristic.SetName(AValue: string);
begin
  if FName=AValue then Exit;
  FName:=AValue;
  ModifiedProperty('Name');
end;

procedure TCharacteristic.SetRelation(AValue: string);
begin
  if FRelation=AValue then Exit;
  FRelation:=AValue;
  ModifiedProperty('Relation');
end;

procedure TCharacteristic.InternalRegisterPropertys;
begin
  RegisterProperty('Name', 'name', 'О', 'характеристика товара', 0, 255);
  RegisterProperty('IdChar', 'id_char', 'О', 'guid идентификатор характеристики', 0, 255);
  RegisterProperty('IdOwner', 'id_owner', 'О', 'guid идентификатор владельца', 0, 255);
  RegisterProperty('Relation', 'relation', 'О', 'указывает на объект владельца', 0, 255);
end;

procedure TCharacteristic.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TCharacteristic.Destroy;
begin
  inherited Destroy;
end;

{ TCharacteristicList }

function TCharacteristicList.GetItem(AIndex: Integer): TCharacteristic;
begin
  Result:=TCharacteristic(InternalGetItem(AIndex));
end;

constructor TCharacteristicList.Create;
begin
  inherited Create(TCharacteristic)
end;

function TCharacteristicList.CreateChild: TCharacteristic;
begin
  Result:=InternalAddObject as TCharacteristic;
end;

{ TCharacteristics }

procedure TCharacteristics.InternalRegisterPropertys;
begin
  RegisterProperty('CharacteristicList', 'record', 'О', '', -1, -1);
end;

procedure TCharacteristics.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FCharacteristicList:=TCharacteristicList.Create;
end;

destructor TCharacteristics.Destroy;
begin
  FreeAndNil(FCharacteristicList);
  inherited Destroy;
end;

{ TSprGood }

procedure TSprGood.SetAlco(AValue: string);
begin
  if FAlco=AValue then Exit;
  FAlco:=AValue;
  ModifiedProperty('Alco');
end;

procedure TSprGood.SetArt(AValue: string);
begin
  if FArt=AValue then Exit;
  FArt:=AValue;
  ModifiedProperty('Art');
end;

procedure TSprGood.SetBitmap(AValue: string);
begin
  if FBitmap=AValue then Exit;
  FBitmap:=AValue;
  ModifiedProperty('Bitmap');
end;

procedure TSprGood.SetIdGoods(AValue: string);
begin
  if FIdGoods=AValue then Exit;
  FIdGoods:=AValue;
  ModifiedProperty('IdGoods');
end;

procedure TSprGood.SetIdMeasure(AValue: string);
begin
  if FIdMeasure=AValue then Exit;
  FIdMeasure:=AValue;
  ModifiedProperty('IdMeasure');
end;

procedure TSprGood.SetIdNaborPack(AValue: string);
begin
  if FIdNaborPack=AValue then Exit;
  FIdNaborPack:=AValue;
  ModifiedProperty('IdNaborPack');
end;

procedure TSprGood.SetIdVidnomencl(AValue: string);
begin
  if FIdVidnomencl=AValue then Exit;
  FIdVidnomencl:=AValue;
  ModifiedProperty('IdVidnomencl');
end;

procedure TSprGood.SetImg(AValue: string);
begin
  if FImg=AValue then Exit;
  FImg:=AValue;
  ModifiedProperty('Img');
end;

procedure TSprGood.SetName(AValue: string);
begin
  if FName=AValue then Exit;
  FName:=AValue;
  ModifiedProperty('Name');
end;

procedure TSprGood.InternalRegisterPropertys;
begin
  RegisterProperty('IdGoods', 'id_goods', 'О', 'идентификатор товара', 0, 250);
  RegisterProperty('Name', 'name', 'О', 'наименование товара', 0, 250);
  RegisterProperty('IdMeasure', 'id_measure', 'О', 'идентификатор базовой ед. измерения', 0, 250);
  RegisterProperty('Art', 'art', 'О', 'артикул', 0, 250);
  RegisterProperty('Alco', 'alco', 'О', 'признак алкогольной продукции (значение: 1 или 0)', 1, 1);
  RegisterProperty('IdVidnomencl', 'id_vidnomencl', 'О', 'наименование файла изображения товара', 0, 250);
  RegisterProperty('IdNaborPack', 'id_nabor_pack', 'О', 'наименование файла изображения товара', 0, 250);
  RegisterProperty('Img', 'img', 'О', 'наименование файла изображения товара', 0, 250);
  RegisterProperty('Bitmap', 'bitmap', 'О', 'бинарный блок данных — изображение товара в кодировке Base64', 0, -1);
end;

procedure TSprGood.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TSprGood.Destroy;
begin
  inherited Destroy;
end;

{ TSprGoodLists }

function TSprGoodLists.GetItem(AIndex: Integer): TSprGood;
begin
  Result:=TSprGood(InternalGetItem(AIndex));
end;

constructor TSprGoodLists.Create;
begin
  inherited Create(TSprGood)
end;

function TSprGoodLists.CreateChild: TSprGood;
begin
  Result:=InternalAddObject as TSprGood;
end;

{ TSprGoods }

procedure TSprGoods.InternalRegisterPropertys;
begin
  RegisterProperty('SprGoodLists', 'record', 'О', '', -1, -1);
end;

procedure TSprGoods.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FSprGoodLists:=TSprGoodLists.Create;
end;

destructor TSprGoods.Destroy;
begin
  FreeAndNil(FSprGoodLists);
  inherited Destroy;
end;

{ TDictionary }

procedure TDictionary.InternalRegisterPropertys;
begin
  RegisterProperty('SprGoods', 'table', 'О', '', -1, -1);
  RegisterProperty('Characteristics', 'characteristics', 'О', 'справочник характеристик', -1, -1);
  RegisterProperty('Packs', 'packs', 'О', 'справочник упаковок', -1, -1);
  RegisterProperty('Serials', 'serials', 'О', 'справочник серий', -1, -1);
  RegisterProperty('Barcodes', 'barcodes', 'О', 'справочник штрихкодов', -1, -1);
  RegisterProperty('Measures', 'measures', 'О', 'справочник единиц измерения', -1, -1);
  RegisterProperty('Prices', 'prices', 'О', 'справочник ценн', -1, -1);
  RegisterProperty('NomenclatureTypes', 'vidnomencls', 'О', 'виды номенклатуры', -1, -1);
  RegisterProperty('Sclads', 'sclads', 'О', 'склады', -1, -1);
end;

procedure TDictionary.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FSprGoods:=TSprGoods.Create;
  FCharacteristics:=TCharacteristics.Create;
  FPacks:=TPacks.Create;
  FSerials:=TSerials.Create;
  FBarcodes:=TBarcodes.Create;
  FMeasures:=TMeasures.Create;
  FPrices:=TPrices.Create;
  FNomenclatureTypes:=TNomenclatureTypes.Create;
  FSclads:=TSclads.Create;
end;

function TDictionary.RootNodeName: string;
begin
  Result:='Document';
end;

destructor TDictionary.Destroy;
begin
  FreeAndNil(FSclads);
  FreeAndNil(FNomenclatureTypes);
  FreeAndNil(FPrices);
  FreeAndNil(FMeasures);
  FreeAndNil(FBarcodes);
  FreeAndNil(FSerials);
  FreeAndNil(FSprGoods);
  FreeAndNil(FCharacteristics);
  FreeAndNil(FPacks);
  inherited Destroy;
end;

end.

