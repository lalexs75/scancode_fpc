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

unit scancode_tsd_order_api;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject;

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

  { TTaskGoodPropertySerialCells }

  TTaskGoodPropertySerialCells = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TTaskGoodPropertySerialCell; inline;
  public
    constructor Create;
    function CreateChild:TTaskGoodPropertySerialCell;
    property Item[AIndex:Integer]:TTaskGoodPropertySerialCell read GetItem; default;
  end;

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

  { TTaskGood }

  TTaskGood = class(TXmlSerializationObject)
  private
    FGoodMarking: TTaskGoodMarking;
    FGoodProperty: TTaskGoodProperty;
    FIdChar: string;
    FIdGoods: string;
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
  end;

  { TTaskGoods }

  TTaskGoods = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TTaskGood; inline;
  public
    constructor Create;
    function CreateChild:TTaskGood;
    property Item[AIndex:Integer]:TTaskGood read GetItem; default;
  end;


  { TTask }

  TTask = class(TXmlSerializationObject)
  private
    FDate: string;
    FDateOrder: string;
    FFC: string;
    FGoods: TTaskGoods;
    FIdDoc: string;
    FIdSclad: string;
    FTaskType: string;
    procedure SetDate(AValue: string);
    procedure SetDateOrder(AValue: string);
    procedure SetFC(AValue: string);
    procedure SetIdDoc(AValue: string);
    procedure SetIdSclad(AValue: string);
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
  end;

  { TTasks }

  TTasks = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TTask; inline;
  public
    constructor Create;
    function CreateChild:TTask;
    property Item[AIndex:Integer]:TTask read GetItem; default;
  end;

  { TOrders }

  TOrders = class(TXmlSerializationObject)
  private
    FTasks: TTasks;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    destructor Destroy; override;
  published
    property Tasks:TTasks read FTasks;
  end;


  { THandbooks }

  THandbooks = class(TXmlSerializationObject)
  private
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    destructor Destroy; override;
  published
  end;


  { TTSDOrder }

  TTSDOrder = class
  private
    FHandbooks: THandbooks;
    FOrders: TOrders;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SaveToFile(AFileName:string);
    procedure LoadFromFile(AFileName:string);
  published
    property Handbooks:THandbooks read FHandbooks;
    property Orders:TOrders read FOrders;
  end;

implementation
uses DOM, XMLWrite;

type
  THackXmlSerializationObject = class(TXmlSerializationObject);

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
  RegisterProperty('IdCell', 'id_cell', 'О', 'идентификатор ячейки', 0, 250);
  RegisterProperty('CellAddress', 'celladdress', 'О', 'наименование ячейки', 0, 250);
end;

procedure TTaskGoodPropertySerialCell.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TTaskGoodPropertySerialCell.Destroy;
begin
  inherited Destroy;
end;

{ TTaskGoodPropertySerialCells }

function TTaskGoodPropertySerialCells.GetItem(AIndex: Integer
  ): TTaskGoodPropertySerialCell;
begin
  Result:=TTaskGoodPropertySerialCell(InternalGetItem(AIndex));
end;

constructor TTaskGoodPropertySerialCells.Create;
begin
  inherited Create(TTaskGoodPropertySerialCell)
end;

function TTaskGoodPropertySerialCells.CreateChild: TTaskGoodPropertySerialCell;
begin
  Result:=InternalAddObject as TTaskGoodPropertySerialCell;
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
  RegisterProperty('Quantity', 'quantity', 'О', 'оличество собранного товара в единицах измерения упаковки', 0, 250);
  RegisterProperty('IdSerial', 'id_serial', 'О', 'идентификатор серии', 0, 250);
  RegisterProperty('Value', 'value', 'О', 'серия (произвольное значение) введенное пользователем на ТСД', 0, 250);
  RegisterProperty('Date', 'date', 'О', 'указанная пользователем дата срока годности (если требуется)', 0, 250);
  RegisterProperty('Cells', 'Cells', 'О', 'информация о ячейках товара', -1, -1);
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
  RegisterProperty('PDF417', 'PDF417', 'О', '', 0, 250);
  RegisterProperty('DATAMATRIX', 'DATAMATRIX', 'О', '', 0, 250);
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
  RegisterProperty('IdPack', 'id_pack', 'О', 'идентификатор упаковки', 0, 250);
  RegisterProperty('Serial', 'serial', 'О', 'серии товаров', -1, -1);
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
  RegisterProperty('IdChar', 'id_char', 'О', 'идентификатор характеристик', 0, 250);
  RegisterProperty('IdGoods', 'id_goods', 'О', 'идентификатор товара', 0, 250);
  RegisterProperty('GoodProperty', 'property', 'О', 'описание свойств', -1, -1);
  RegisterProperty('GoodMarking', 'alco', 'О', 'коды акцизных марок', -1, -1);
end;

procedure TTaskGood.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FGoodProperty:=TTaskGoodProperty.Create;
  FGoodMarking:=TTaskGoodMarking.Create;
end;

destructor TTaskGood.Destroy;
begin
  FreeAndNil(FGoodProperty);
  FreeAndNil(FGoodMarking);
  inherited Destroy;
end;

{ TTaskGoods }

function TTaskGoods.GetItem(AIndex: Integer): TTaskGood;
begin
  Result:=TTaskGood(InternalGetItem(AIndex));
end;

constructor TTaskGoods.Create;
begin
  inherited Create(TTaskGood)
end;

function TTaskGoods.CreateChild: TTaskGood;
begin
  Result:=InternalAddObject as TTaskGood;
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

procedure TTask.SetTaskType(AValue: string);
begin
  if FTaskType=AValue then Exit;
  FTaskType:=AValue;
  ModifiedProperty('TaskType');
end;

procedure TTask.InternalRegisterPropertys;
begin
  RegisterProperty('IdDoc', 'id_doc', 'О', 'уникальный идентификатор документа', 0, 250);
  RegisterProperty('Date', 'date', 'О', 'дата создания документа (во внешней учетной системе)', 0, 250);
  RegisterProperty('TaskType', 'type', 'О', 'тип группы документа', 0, 250);
  RegisterProperty('DateOrder', 'date_order', 'О', 'дата создания ордера', 0, 250);
  RegisterProperty('FC', 'fc', 'О', 'признак «свободный набор» (значение: 1 или 0)', 0, 250);
  RegisterProperty('IdSclad', 'id_sclad', 'О', 'guid идентификатор склада', 0, 250);
  RegisterProperty('Goods', 'record', 'О', 'товар', -1, -1);
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

{ TTasks }

function TTasks.GetItem(AIndex: Integer): TTask;
begin
  Result:=TTask(InternalGetItem(AIndex));
end;

constructor TTasks.Create;
begin
  inherited Create(TTask)
end;

function TTasks.CreateChild: TTask;
begin
  Result:=InternalAddObject as TTask;
end;

{ TOrders }

procedure TOrders.InternalRegisterPropertys;
begin
  RegisterProperty('Tasks', 'Task', 'О', '', -1, -1);
end;

procedure TOrders.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FTasks:=TTasks.Create;
end;

function TOrders.RootNodeName: string;
begin
  Result:='Orders';
end;

destructor TOrders.Destroy;
begin
  FreeAndNil(FTasks);
  inherited Destroy;
end;

{ THandbooks }

procedure THandbooks.InternalRegisterPropertys;
begin

end;

procedure THandbooks.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

function THandbooks.RootNodeName: string;
begin
  Result:='handbooks'
end;

destructor THandbooks.Destroy;
begin
  inherited Destroy;
end;

{ TTSDOrder }

constructor TTSDOrder.Create;
begin
  inherited Create;
  FHandbooks:=THandbooks.Create;
  FOrders:=TOrders.Create;
end;

destructor TTSDOrder.Destroy;
begin
  FreeAndNil(FOrders);
  FreeAndNil(FHandbooks);
  inherited Destroy;
end;

procedure TTSDOrder.SaveToFile(AFileName: string);
var
  FXML: TXMLDocument;
begin
  FXML:=TXMLDocument.Create;
  if not THackXmlSerializationObject(FHandbooks).IsEmpty then
    FHandbooks.SaveToXML(FXML);

  if not THackXmlSerializationObject(FOrders).IsEmpty then
    FOrders.SaveToXML(FXML);

  WriteXML(FXML, AFileName);
  FXML.Free;
end;

procedure TTSDOrder.LoadFromFile(AFileName: string);
begin

end;

end.

