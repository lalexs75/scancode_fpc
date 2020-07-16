{ interface library for FPC and Lazarus
  Copyright (C) 2019-2020 Lagunov Aleksey alexs75@yandex.ru

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

unit scancode_tsd_order_api;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject, AbstractSerializationObjects;

type
  { TTaskGoodMarking }

  TTaskGoodMarking = class(TXmlSerializationObject)
  private
    FDATAMATRIX: string;
    FPDF417: string;
    procedure SetDATAMATRIX(AValue: string);
    procedure SetPDF417(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property PDF417:string read FPDF417 write SetPDF417;
    property DATAMATRIX:string read FDATAMATRIX write SetDATAMATRIX;
  end;

  { TTaskGoodPropertySerialCell }

  TTaskGoodPropertySerialCell = class(TXmlSerializationObject)
  private
    FCellAddress: string;
    FIdCell: string;
    procedure SetCellAddress(AValue: string);
    procedure SetIdCell(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property IdCell:string read FIdCell write SetIdCell;
    property CellAddress:string read FCellAddress write SetCellAddress;
  end;
  TTaskGoodPropertySerialCells = specialize GXMLSerializationObjectList<TTaskGoodPropertySerialCell>;

  { TTaskGoodPropertySerial }

  TTaskGoodPropertySerial = class(TXmlSerializationObject)
  private
    FCells: TTaskGoodPropertySerialCells;
    FDate: string;
    FIdSerial: string;
    FQuantity: string;
    FValue: string;
    procedure SetDate(AValue: string);
    procedure SetIdSerial(AValue: string);
    procedure SetQuantity(AValue: string);
    procedure SetValue(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property Quantity:string read FQuantity write SetQuantity;
    property IdSerial:string read FIdSerial write SetIdSerial;
    property Value:string read FValue write SetValue;
    property Date:string read FDate write SetDate;
    property Cells:TTaskGoodPropertySerialCells read FCells;
  end;

  { TTaskGoodProperty }
  TTaskGoodProperty = class(TXmlSerializationObject)
  private
    FIdPack: string;
    FSerial: TTaskGoodPropertySerial;
    procedure SetIdPack(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property IdPack:string read FIdPack write SetIdPack;
    property Serial:TTaskGoodPropertySerial read FSerial;
  end;

  { TMarkedCode }

  TMarkedCode = class(TXmlSerializationObject)
  private
    FGS1_DATAMATRIX: string;
    procedure SetGS1_DATAMATRIX(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property GS1_DATAMATRIX:string read FGS1_DATAMATRIX write SetGS1_DATAMATRIX;
  end;
  TMarkedCodes = specialize GXMLSerializationObjectList<TMarkedCode>;

  { TMarkedCodeList }

  TMarkedCodeList = class(TXmlSerializationObject)
  private
    FTokens: TMarkedCodes;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property Tokens:TMarkedCodes read FTokens;
  end;

  { TTaskGood }

  TTaskGood = class(TXmlSerializationObject)
  private
    FGoodMarking: TTaskGoodMarking;
    FGoodProperty: TTaskGoodProperty;
    FIdChar: string;
    FIdGoods: string;
    FMarkedCodes: TMarkedCodeList;
    procedure SetIdChar(AValue: string);
    procedure SetIdGoods(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property IdChar:string read FIdChar write SetIdChar;
    property IdGoods:string read FIdGoods write SetIdGoods;
    property GoodProperty:TTaskGoodProperty read FGoodProperty;
    property GoodMarking:TTaskGoodMarking read FGoodMarking;
    property MarkedCodes:TMarkedCodeList read FMarkedCodes;
  end;
  TTaskGoods = specialize GXMLSerializationObjectList<TTaskGood>;

  { TTask }

  TTask = class(TXmlSerializationObject)
  private
    FDate: string;
    FDateOrder: string;
    FFC: string;
    FGoods: TTaskGoods;
    FIdDoc: string;
    FIdSclad: string;
    FLastOrder: string;
    FTaskType: string;
    procedure SetDate(AValue: string);
    procedure SetDateOrder(AValue: string);
    procedure SetFC(AValue: string);
    procedure SetIdDoc(AValue: string);
    procedure SetIdSclad(AValue: string);
    procedure SetLastOrder(AValue: string);
    procedure SetTaskType(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property IdDoc:string read FIdDoc write SetIdDoc;
    property Date:string read FDate write SetDate;
    property TaskType:string read FTaskType write SetTaskType;
    property DateOrder:string read FDateOrder write SetDateOrder;
    property FC:string read FFC write SetFC;
    property IdSclad:string read FIdSclad write SetIdSclad;
    property Goods:TTaskGoods read FGoods;
    property LastOrder:string read FLastOrder write SetLastOrder;
  end;
  TTasks = specialize GXMLSerializationObjectList<TTask>;

  { TCharacteristic }

  TCharacteristic = class(TXmlSerializationObject)
  private
    FIdChar: string;
    FIdGoods: string;
    FName: string;
    procedure SetIdChar(AValue: string);
    procedure SetIdGoods(AValue: string);
    procedure SetName(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property IdGoods:string read FIdGoods write SetIdGoods;
    property IdChar:string read FIdChar write SetIdChar;
    property Name:string read FName write SetName;
  end;
  TCharacteristicList = specialize GXMLSerializationObjectList<TCharacteristic>;

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

  { TNomenclature }

  TNomenclature = class(TXmlSerializationObject)
  private
    FBitmap: string;
    FIdGoods: string;
    FIdMeasure: string;
    FIdVidnomencl: string;
    FImg: string;
    FName: string;
    procedure SetBitmap(AValue: string);
    procedure SetIdGoods(AValue: string);
    procedure SetIdMeasure(AValue: string);
    procedure SetIdVidnomencl(AValue: string);
    procedure SetImg(AValue: string);
    procedure SetName(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
    procedure SaveImageToFile(AImageFileName:string);
  published
    property IdGoods:string read FIdGoods write SetIdGoods;
    property Name:string read FName write SetName;
    property IdMeasure:string read FIdMeasure write SetIdMeasure;
    property IdVidnomencl:string read FIdVidnomencl write SetIdVidnomencl;
    property Img:string read FImg write SetImg;
    property Bitmap:string read FBitmap write SetBitmap;
  end;
  TNomenclatureList = specialize GXMLSerializationObjectList<TNomenclature>;

  { TNomenclatures }

  TNomenclatures = class(TXmlSerializationObject)
  private
    FNomenclatureList: TNomenclatureList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property NomenclatureList:TNomenclatureList read FNomenclatureList;
  end;

  { TTSDBarcode }

  TTSDBarcode = class(TXmlSerializationObject)
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
    property IdGoods:string read FIdGoods write SetIdGoods;
    property IdChar:string read FIdChar write SetIdChar;
    property IdPack:string read FIdPack write SetIdPack;
    property Barcode:string read FBarcode write SetBarcode;
  end;
  TTSDBarcodeList = specialize GXMLSerializationObjectList<TTSDBarcode>;

  { TTSDBarcodes }

  TTSDBarcodes = class(TXmlSerializationObject)
  private
    FBarcodeList: TTSDBarcodeList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property BarcodeList:TTSDBarcodeList read FBarcodeList;
  end;

  { THandbooks }

  THandbooks = class(TXmlSerializationObject)
  private
    FBarcodes: TTSDBarcodes;
    FCharacteristics: TCharacteristics;
    FNomenclatures: TNomenclatures;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    destructor Destroy; override;
  published
    property Nomenclatures:TNomenclatures read FNomenclatures;
    property Characteristics:TCharacteristics read FCharacteristics;
    property Barcodes:TTSDBarcodes read FBarcodes;
  end;


  { TOrders }

  TOrders = class(TXmlSerializationObject)
  private
    FHandbooks: THandbooks;
    FTasks: TTasks;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    destructor Destroy; override;
  published
    property Handbooks:THandbooks read FHandbooks;
    property Tasks:TTasks read FTasks;
  end;

implementation
uses base64;

{ TMarkedCodeList }

procedure TMarkedCodeList.InternalRegisterPropertys;
begin
  inherited InternalRegisterPropertys;
  RegisterProperty('Tokens', 'token', [], '', -1, -1);
end;

procedure TMarkedCodeList.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FTokens:=TMarkedCodes.Create;
end;

destructor TMarkedCodeList.Destroy;
begin
  FreeAndNil(FTokens);
  inherited Destroy;
end;

{ TMarkedCode }

procedure TMarkedCode.SetGS1_DATAMATRIX(AValue: string);
begin
  if FGS1_DATAMATRIX=AValue then Exit;
  FGS1_DATAMATRIX:=AValue;
  ModifiedProperty('GS1_DATAMATRIX');
end;

procedure TMarkedCode.InternalRegisterPropertys;
begin
  inherited InternalRegisterPropertys;
  RegisterProperty('GS1_DATAMATRIX', 'GS1_DATAMATRIX', [], 'значение кода марки, считанный с этикетки сканером', -1, -1);
end;

procedure TMarkedCode.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TMarkedCode.Destroy;
begin
  inherited Destroy;
end;

{ TBarcode }

procedure TTSDBarcode.SetIdChar(AValue: string);
begin
  if FIdChar=AValue then Exit;
  FIdChar:=AValue;
  ModifiedProperty('IdChar');
end;

procedure TTSDBarcode.SetBarcode(AValue: string);
begin
  if FBarcode=AValue then Exit;
  FBarcode:=AValue;
  ModifiedProperty('Barcode');
end;

procedure TTSDBarcode.SetIdGoods(AValue: string);
begin
  if FIdGoods=AValue then Exit;
  FIdGoods:=AValue;
  ModifiedProperty('IdGoods');
end;

procedure TTSDBarcode.SetIdPack(AValue: string);
begin
  if FIdPack=AValue then Exit;
  FIdPack:=AValue;
  ModifiedProperty('IdPack');
end;

procedure TTSDBarcode.InternalRegisterPropertys;
begin
  RegisterProperty('IdGoods', 'id_goods', [xsaRequared], '', 0, 250);
  RegisterProperty('IdChar', 'id_char', [], '', 0, 250);
  RegisterProperty('IdPack', 'id_pack', [], '', 0, 250);
  RegisterProperty('Barcode', 'barcode', [xsaRequared], '', 0, 250);
end;

procedure TTSDBarcode.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TTSDBarcode.Destroy;
begin
  inherited Destroy;
end;

{ TTSDBarcodes }

procedure TTSDBarcodes.InternalRegisterPropertys;
begin
  RegisterProperty('BarcodeList', 'record', [xsaRequared], '', -1, -1);
end;

procedure TTSDBarcodes.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FBarcodeList:=TTSDBarcodeList.Create;
end;

destructor TTSDBarcodes.Destroy;
begin
  FreeAndNil(FBarcodeList);
  inherited Destroy;
end;

{ TCharacteristic }

procedure TCharacteristic.SetIdChar(AValue: string);
begin
  if FIdChar=AValue then Exit;
  FIdChar:=AValue;
  ModifiedProperty('IdChar');
end;

procedure TCharacteristic.SetIdGoods(AValue: string);
begin
  if FIdGoods=AValue then Exit;
  FIdGoods:=AValue;
  ModifiedProperty('IdGoods');
end;

procedure TCharacteristic.SetName(AValue: string);
begin
  if FName=AValue then Exit;
  FName:=AValue;
  ModifiedProperty('Name');
end;

procedure TCharacteristic.InternalRegisterPropertys;
begin
  RegisterProperty('IdGoods', 'id_goods', [], '', 0, 250);
  RegisterProperty('IdChar', 'id_char', [], '', 0, 250);
  RegisterProperty('Name', 'name', [], '', 0, 250);
end;

procedure TCharacteristic.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TCharacteristic.Destroy;
begin
  inherited Destroy;
end;

{ TCharacteristics }

procedure TCharacteristics.InternalRegisterPropertys;
begin
   RegisterProperty('CharacteristicList', 'record', [xsaRequared], '', -1, -1);
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

{ TNomenclatures }

procedure TNomenclatures.InternalRegisterPropertys;
begin
  RegisterProperty('NomenclatureList', 'record', [xsaRequared], '', -1, -1);
end;

procedure TNomenclatures.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FNomenclatureList:=TNomenclatureList.Create;
end;

destructor TNomenclatures.Destroy;
begin
  FreeAndNil(FNomenclatureList);
  inherited Destroy;
end;

{ TNomenclature }

procedure TNomenclature.SetBitmap(AValue: string);
begin
  if FBitmap=AValue then Exit;
  FBitmap:=AValue;
  ModifiedProperty('Bitmap');
end;

procedure TNomenclature.SetIdGoods(AValue: string);
begin
  if FIdGoods=AValue then Exit;
  FIdGoods:=AValue;
  ModifiedProperty('IdGoods');
end;

procedure TNomenclature.SetIdMeasure(AValue: string);
begin
  if FIdMeasure=AValue then Exit;
  FIdMeasure:=AValue;
  ModifiedProperty('IdMeasure');
end;

procedure TNomenclature.SetIdVidnomencl(AValue: string);
begin
  if FIdVidnomencl=AValue then Exit;
  FIdVidnomencl:=AValue;
  ModifiedProperty('IdVidnomencl');
end;

procedure TNomenclature.SetImg(AValue: string);
begin
  if FImg=AValue then Exit;
  FImg:=AValue;
  ModifiedProperty('Img');
end;

procedure TNomenclature.SetName(AValue: string);
begin
  if FName=AValue then Exit;
  FName:=AValue;
  ModifiedProperty('Name');
end;

procedure TNomenclature.InternalRegisterPropertys;
begin
  RegisterProperty('IdGoods', 'id_goods', [xsaRequared], '', 0, 250);
  RegisterProperty('Name', 'name', [xsaRequared], '', 0, 250);
  RegisterProperty('IdMeasure', 'id_measure', [], '', 0, 250);
  RegisterProperty('IdVidnomencl', 'id_vidnomencl', [], '', 0, 250);
  RegisterProperty('Img', 'img', [], '', 0, 250);
  RegisterProperty('Bitmap', 'bitmap', [], '', 0, -1);
end;

procedure TNomenclature.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TNomenclature.Destroy;
begin
  inherited Destroy;
end;

procedure TNomenclature.SaveImageToFile(AImageFileName: string);
var
  SD: String;
  Instream: TStringStream;
  Decoder: TBase64DecodingStream;
  Outstream: TFileStream;
begin
  if (FBitmap<>'') then
  begin
    SD:=FBitmap;
    while Length(Sd) mod 4 > 0 do SD := SD + '=';
    Instream:=TStringStream.Create(SD);
    try
      Outstream:=TFileStream.Create(AImageFileName, fmOpenWrite + fmCreate);
      try
(*        if strict then
          Decoder:=TBase64DecodingStream.Create(Instream,bdmStrict)
        else *)
          Decoder:=TBase64DecodingStream.Create(Instream,bdmMIME);
        try
          Outstream.CopyFrom(Decoder,Decoder.Size);
        finally
          Decoder.Free;
        end;
      finally
        Outstream.Free;
      end;
    finally
      Instream.Free;
    end;
  end;
end;

{ TTaskGoodPropertySerialCell }

procedure TTaskGoodPropertySerialCell.SetCellAddress(AValue: string);
begin
  if FCellAddress=AValue then Exit;
  FCellAddress:=AValue;
  ModifiedProperty('CellAddress');
end;

procedure TTaskGoodPropertySerialCell.SetIdCell(AValue: string);
begin
  if FIdCell=AValue then Exit;
  FIdCell:=AValue;
  ModifiedProperty('IdCell');
end;

procedure TTaskGoodPropertySerialCell.InternalRegisterPropertys;
begin
  RegisterProperty('IdCell', 'id_cell', [xsaRequared], 'идентификатор ячейки', 0, 250);
  RegisterProperty('CellAddress', 'celladdress', [], 'наименование ячейки', 0, 250);
end;

procedure TTaskGoodPropertySerialCell.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TTaskGoodPropertySerialCell.Destroy;
begin
  inherited Destroy;
end;

{ TTaskGoodPropertySerial }

procedure TTaskGoodPropertySerial.SetDate(AValue: string);
begin
  if FDate=AValue then Exit;
  FDate:=AValue;
  ModifiedProperty('Date');
end;

procedure TTaskGoodPropertySerial.SetIdSerial(AValue: string);
begin
  if FIdSerial=AValue then Exit;
  FIdSerial:=AValue;
  ModifiedProperty('IdSerial');
end;

procedure TTaskGoodPropertySerial.SetQuantity(AValue: string);
begin
  if FQuantity=AValue then Exit;
  FQuantity:=AValue;
  ModifiedProperty('Quantity');
end;

procedure TTaskGoodPropertySerial.SetValue(AValue: string);
begin
  if FValue=AValue then Exit;
  FValue:=AValue;
  ModifiedProperty('Value');
end;

procedure TTaskGoodPropertySerial.InternalRegisterPropertys;
begin
  RegisterProperty('Quantity', 'quantity', [xsaRequared], 'оличество собранного товара в единицах измерения упаковки', 0, 250);
  RegisterProperty('IdSerial', 'id_serial', [], 'идентификатор серии', 0, 250);
  RegisterProperty('Value', 'value', [], 'серия (произвольное значение) введенное пользователем на ТСД', 0, 250);
  RegisterProperty('Date', 'date', [], 'указанная пользователем дата срока годности (если требуется)', 0, 250);
  RegisterProperty('Cells', 'сells', [], 'информация о ячейках товара', -1, -1);
end;

procedure TTaskGoodPropertySerial.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FCells:=TTaskGoodPropertySerialCells.Create;
end;

destructor TTaskGoodPropertySerial.Destroy;
begin
  FreeAndNil(FCells);
  inherited Destroy;
end;

{ TTaskGoodMarking }

procedure TTaskGoodMarking.SetDATAMATRIX(AValue: string);
begin
  if FDATAMATRIX=AValue then Exit;
  FDATAMATRIX:=AValue;
  ModifiedProperty('DATAMATRIX');
end;

procedure TTaskGoodMarking.SetPDF417(AValue: string);
begin
  if FPDF417=AValue then Exit;
  FPDF417:=AValue;
  ModifiedProperty('PDF417');
end;

procedure TTaskGoodMarking.InternalRegisterPropertys;
begin
  RegisterProperty('PDF417', 'PDF417', [], '', 0, 250);
  RegisterProperty('DATAMATRIX', 'DATAMATRIX', [], '', 0, 250);
end;

procedure TTaskGoodMarking.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TTaskGoodMarking.Destroy;
begin
  inherited Destroy;
end;

{ TTaskGoodProperty }

procedure TTaskGoodProperty.SetIdPack(AValue: string);
begin
  if FIdPack=AValue then Exit;
  FIdPack:=AValue;
  ModifiedProperty('IdPack');
end;

procedure TTaskGoodProperty.InternalRegisterPropertys;
begin
  RegisterProperty('IdPack', 'id_pack', [], 'идентификатор упаковки', 0, 250);
  RegisterProperty('Serial', 'serial', [], 'серии товаров', -1, -1);
end;

procedure TTaskGoodProperty.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FSerial:=TTaskGoodPropertySerial.Create;
end;

destructor TTaskGoodProperty.Destroy;
begin
  FreeAndNil(FSerial);
  inherited Destroy;
end;

{ TTaskGood }

procedure TTaskGood.SetIdChar(AValue: string);
begin
  if FIdChar=AValue then Exit;
  FIdChar:=AValue;
  ModifiedProperty('IdChar');
end;

procedure TTaskGood.SetIdGoods(AValue: string);
begin
  if FIdGoods=AValue then Exit;
  FIdGoods:=AValue;
  ModifiedProperty('IdGoods');
end;

procedure TTaskGood.InternalRegisterPropertys;
begin
  RegisterProperty('IdChar', 'id_char', [], 'идентификатор характеристик', 0, 250);
  RegisterProperty('IdGoods', 'id_goods', [xsaRequared], 'идентификатор товара', 0, 250);
  RegisterProperty('GoodProperty', 'property', [], 'описание свойств', -1, -1);
  RegisterProperty('GoodMarking', 'alco', [], 'коды акцизных марок', -1, -1);
  RegisterProperty('MarkedCodes', 'marked_codes', [], 'коды маркировок', -1, -1);
end;

procedure TTaskGood.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FGoodProperty:=TTaskGoodProperty.Create;
  FGoodMarking:=TTaskGoodMarking.Create;
  FMarkedCodes:=TMarkedCodeList.Create;
end;

destructor TTaskGood.Destroy;
begin
  FreeAndNil(FGoodProperty);
  FreeAndNil(FGoodMarking);
  FreeAndNil(FMarkedCodes);
  inherited Destroy;
end;

{ TTask }

procedure TTask.SetDate(AValue: string);
begin
  if FDate=AValue then Exit;
  FDate:=AValue;
  ModifiedProperty('Date');
end;

procedure TTask.SetDateOrder(AValue: string);
begin
  if FDateOrder=AValue then Exit;
  FDateOrder:=AValue;
  ModifiedProperty('DateOrder');
end;

procedure TTask.SetFC(AValue: string);
begin
  if FFC=AValue then Exit;
  FFC:=AValue;
  ModifiedProperty('FC');
end;

procedure TTask.SetIdDoc(AValue: string);
begin
  if FIdDoc=AValue then Exit;
  FIdDoc:=AValue;
  ModifiedProperty('IdDoc');
end;

procedure TTask.SetIdSclad(AValue: string);
begin
  if FIdSclad=AValue then Exit;
  FIdSclad:=AValue;
  ModifiedProperty('IdSclad');
end;

procedure TTask.SetLastOrder(AValue: string);
begin
  if FLastOrder=AValue then Exit;
  FLastOrder:=AValue;
  ModifiedProperty('LastOrder');
end;

procedure TTask.SetTaskType(AValue: string);
begin
  if FTaskType=AValue then Exit;
  FTaskType:=AValue;
  ModifiedProperty('TaskType');
end;

procedure TTask.InternalRegisterPropertys;
begin
  RegisterProperty('IdDoc', 'id_doc', [xsaRequared], 'уникальный идентификатор документа', 0, 250);
  RegisterProperty('Date', 'date', [], 'дата создания документа (во внешней учетной системе)', 0, 250);
  RegisterProperty('TaskType', 'type', [xsaRequared], 'тип группы документа', 0, 250);
  RegisterProperty('DateOrder', 'date_order', [], 'дата создания ордера', 0, 250);
  RegisterProperty('FC', 'fc', [xsaRequared], 'признак «свободный набор» (значение: 1 или 0)', 1, 1);
  RegisterProperty('IdSclad', 'id_sclad', [], 'guid идентификатор склада', 0, 250);
  RegisterProperty('Goods', 'record', [xsaRequared], 'товар', -1, -1);
  RegisterProperty('LastOrder', 'last_order', [], '', 0, 1);
end;

procedure TTask.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FGoods:=TTaskGoods.Create;
end;

destructor TTask.Destroy;
begin
  FreeAndNil(FGoods);
  inherited Destroy;
end;

{ TOrders }

procedure TOrders.InternalRegisterPropertys;
begin
  RegisterProperty('Tasks', 'Task', [xsaRequared], '', -1, -1);
  RegisterProperty('Handbooks', 'handbooks', [xsaRequared], 'справочник товаров и сопутствующих списков для новых', -1, -1);
end;

procedure TOrders.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FTasks:=TTasks.Create;
  FHandbooks:=THandbooks.Create;
end;

function TOrders.RootNodeName: string;
begin
  Result:='Orders';
end;

destructor TOrders.Destroy;
begin
  FreeAndNil(FHandbooks);
  FreeAndNil(FTasks);
  inherited Destroy;
end;

{ THandbooks }

procedure THandbooks.InternalRegisterPropertys;
begin
  RegisterProperty('Nomenclatures', 'nomencls', [xsaRequared], 'список товаров, созданных пользователем на ТСД', -1, -1);
  RegisterProperty('Characteristics', 'characteristics', [xsaRequared], 'список характеристик', -1, -1);
  RegisterProperty('Barcodes', 'barcodes', [xsaRequared], 'список штрих кодов', -1, -1);
end;

procedure THandbooks.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FNomenclatures:=TNomenclatures.Create;
  FCharacteristics:=TCharacteristics.Create;
  FBarcodes:=TTSDBarcodes.Create;
end;

function THandbooks.RootNodeName: string;
begin
  Result:='handbooks'
end;

destructor THandbooks.Destroy;
begin
  FreeAndNil(FNomenclatures);
  FreeAndNil(FCharacteristics);
  FreeAndNil(FBarcodes);
  inherited Destroy;
end;

end.

