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

unit scancode_document_api;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject;

type
  { TGoodCell }

  TGoodCell = class(TXmlSerializationObject)
  private
    FCell: string;
    FCellAddress: string;
    procedure SetCell(AValue: string);
    procedure SetCellAddress(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property Cell:string read FCell write SetCell;
    property CellAddress:string read FCellAddress write SetCellAddress;
  end;

  { TGoodCells }

  TGoodCells = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TGoodCell; inline;
  public
    constructor Create;
    function CreateChild:TGoodCell;
    property Item[AIndex:Integer]:TGoodCell read GetItem; default;
  end;

  { TGoodSerial }

  TGoodSerial = class(TXmlSerializationObject)
  private
    FGoodCells: TGoodCells;
    FIdSerial: string;
    FQuantity: string;
    procedure SetIdSerial(AValue: string);
    procedure SetQuantity(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property Quantity:string read FQuantity write SetQuantity;
    property IdSerial:string read FIdSerial write SetIdSerial;
    property GoodCells:TGoodCells read FGoodCells;
  end;

  { TGoodProperty }

  TGoodProperty = class(TXmlSerializationObject)
  private
    FGoodSerial: TGoodSerial;
    FIdPack: string;
    FQuantity: string;
    procedure SetIdPack(AValue: string);
    procedure SetQuantity(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property IdPack:string read FIdPack write SetIdPack;
    property Quantity:string read FQuantity write SetQuantity;
    property GoodSerial:TGoodSerial read FGoodSerial;
  end;

  { TGood }

  TGood = class(TXmlSerializationObject)
  private
    FGoodProperty: TGoodProperty;
    FIdChar: string;
    FIdGoods: string;
    FQuantity: string;
    procedure SetIdChar(AValue: string);
    procedure SetIdGoods(AValue: string);
    procedure SetQuantity(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property IdGoods:string read FIdGoods write SetIdGoods;
    property IdChar:string read FIdChar write SetIdChar;
    property Quantity:string read FQuantity write SetQuantity;
    property GoodProperty:TGoodProperty read FGoodProperty;
  end;

  { TGoods }

  TGoods = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TGood; inline;
  public
    constructor Create;
    function CreateChild:TGood;
    property Item[AIndex:Integer]:TGood read GetItem; default;
  end;

  { TTask }

  TTask = class(TXmlSerializationObject)
  private
    FBarcode: string;
    FControl: string;
    FDate: string;
    FGoods: TGoods;
    FIdDoc: string;
    FIdRoom: string;
    FIdSclad: string;
    FIdZone: string;
    FNomer: string;
    FTypeDoc: string;
    FUseAdress: string;
    procedure SetBarcode(AValue: string);
    procedure SetControl(AValue: string);
    procedure SetDate(AValue: string);
    procedure SetIdDoc(AValue: string);
    procedure SetIdRoom(AValue: string);
    procedure SetIdSclad(AValue: string);
    procedure SetIdZone(AValue: string);
    procedure SetNomer(AValue: string);
    procedure SetTypeDoc(AValue: string);
    procedure SetUseAdress(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property Nomer:string read FNomer write SetNomer;
    property IdDoc:string read FIdDoc write SetIdDoc;
    property TypeDoc:string read FTypeDoc write SetTypeDoc;
    property UseAdress:string read FUseAdress write SetUseAdress;
    property Date:string read FDate write SetDate;
    property Control:string read FControl write SetControl;
    property Barcode:string read FBarcode write SetBarcode;
    property IdZone:string read FIdZone write SetIdZone;
    property IdSclad:string read FIdSclad write SetIdSclad;
    property IdRoom:string read FIdRoom write SetIdRoom;
    property Goods:TGoods read FGoods;
  end;

  { TDocument }

  TDocument = class(TXmlSerializationObject)
  private
    FTask: TTask;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property Task:TTask read FTask;
  end;

  { TDocumentsList }

  TDocumentsList = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TDocument; inline;
  public
    constructor Create;
    function CreateChild:TDocument;
    property Item[AIndex:Integer]:TDocument read GetItem; default;
  end;

  { TDocuments }

  TDocuments = class(TXmlSerializationObject)
  private
    FDocuments: TDocumentsList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    destructor Destroy; override;
  published
    property Documents:TDocumentsList read FDocuments;
  end;

implementation

{ TGoodCell }

procedure TGoodCell.SetCell(AValue: string);
begin
  if FCell=AValue then Exit;
  FCell:=AValue;
  ModifiedProperty('Cell');
end;

procedure TGoodCell.SetCellAddress(AValue: string);
begin
  if FCellAddress=AValue then Exit;
  FCellAddress:=AValue;
  ModifiedProperty('CellAddress');
end;

procedure TGoodCell.InternalRegisterPropertys;
begin
  RegisterProperty('Cell', 'cell', 'О', '', 0, 250);
  RegisterProperty('CellAddress', 'celladdress', 'О', '', 0, 250);
end;

procedure TGoodCell.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TGoodCell.Destroy;
begin
  inherited Destroy;
end;

{ TGoodCells }

function TGoodCells.GetItem(AIndex: Integer): TGoodCell;
begin
  Result:=TGoodCell(InternalGetItem(AIndex));
end;

constructor TGoodCells.Create;
begin
  inherited Create(TGoodCell)
end;

function TGoodCells.CreateChild: TGoodCell;
begin
  Result:=InternalAddObject as TGoodCell;
end;

{ TGoodSerial }

procedure TGoodSerial.SetIdSerial(AValue: string);
begin
  if FIdSerial=AValue then Exit;
  FIdSerial:=AValue;
  ModifiedProperty('IdSerial');
end;

procedure TGoodSerial.SetQuantity(AValue: string);
begin
  if FQuantity=AValue then Exit;
  FQuantity:=AValue;
  ModifiedProperty('Quantity');
end;

procedure TGoodSerial.InternalRegisterPropertys;
begin
  RegisterProperty('Quantity', 'quantity', 'О', 'требуемое количество (в разрезе серии)', 0, 250);
  RegisterProperty('IdSerial', 'id_serial', 'О', 'guid идентификатор серии', 0, 250);
  RegisterProperty('GoodCells', 'cells', 'О', '', -1, -1);
end;

procedure TGoodSerial.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FGoodCells:=TGoodCells.Create;
end;

destructor TGoodSerial.Destroy;
begin
  FreeAndNil(FGoodCells);
  inherited Destroy;
end;

{ TGoodProperty }

procedure TGoodProperty.SetIdPack(AValue: string);
begin
  if FIdPack=AValue then Exit;
  FIdPack:=AValue;
  ModifiedProperty('IdPack');
end;

procedure TGoodProperty.SetQuantity(AValue: string);
begin
  if FQuantity=AValue then Exit;
  FQuantity:=AValue;
  ModifiedProperty('Quantity');
end;

procedure TGoodProperty.InternalRegisterPropertys;
begin
  RegisterProperty('IdPack', 'id_pack', 'О', 'guid идентификатор упаковки', 0, 250);
  RegisterProperty('Quantity', 'quantity', 'О', 'требуемое количество (в разрезе упаковки)', 0, 250);
  RegisterProperty('GoodSerial', 'serial', 'О', 'информация о серии товара', -1, -1);
end;

procedure TGoodProperty.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FGoodSerial:=TGoodSerial.Create;
end;

destructor TGoodProperty.Destroy;
begin
  FreeAndNil(FGoodSerial);
  inherited Destroy;
end;

{ TGood }

procedure TGood.SetIdChar(AValue: string);
begin
  if FIdChar=AValue then Exit;
  FIdChar:=AValue;
  ModifiedProperty('IdChar');
end;

procedure TGood.SetIdGoods(AValue: string);
begin
  if FIdGoods=AValue then Exit;
  FIdGoods:=AValue;
  ModifiedProperty('IdGoods');
end;

procedure TGood.SetQuantity(AValue: string);
begin
  if FQuantity=AValue then Exit;
  FQuantity:=AValue;
  ModifiedProperty('Quantity');
end;

procedure TGood.InternalRegisterPropertys;
begin
  RegisterProperty('IdGoods', 'id_goods', 'О', 'уникальный идентификатор товара', 0, 250);
  RegisterProperty('IdChar', 'id_char', 'О', 'уникальный идентификатор характеристики товара', 0, 250);
  RegisterProperty('Quantity', 'quantity', 'О', 'требуемое количество (общее)', 0, 250);
  RegisterProperty('GoodProperty', 'property', 'О', 'свойства товара', -1, -1);
end;

procedure TGood.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FGoodProperty:=TGoodProperty.Create;
end;

destructor TGood.Destroy;
begin
  FreeAndNil(FGoodProperty);
  inherited Destroy;
end;

{ TGoods }

function TGoods.GetItem(AIndex: Integer): TGood;
begin
  Result:=TGood(InternalGetItem(AIndex));
end;

constructor TGoods.Create;
begin
  inherited Create(TGood)
end;

function TGoods.CreateChild: TGood;
begin
  Result:=InternalAddObject as TGood;
end;

{ TTask }

procedure TTask.SetBarcode(AValue: string);
begin
  if FBarcode=AValue then Exit;
  FBarcode:=AValue;
  ModifiedProperty('Barcode');
end;

procedure TTask.SetControl(AValue: string);
begin
  if FControl=AValue then Exit;
  FControl:=AValue;
  ModifiedProperty('Control');
end;

procedure TTask.SetDate(AValue: string);
begin
  if FDate=AValue then Exit;
  FDate:=AValue;
  ModifiedProperty('Date');
end;

procedure TTask.SetIdDoc(AValue: string);
begin
  if FIdDoc=AValue then Exit;
  FIdDoc:=AValue;
  ModifiedProperty('IdDoc');
end;

procedure TTask.SetIdRoom(AValue: string);
begin
  if FIdRoom=AValue then Exit;
  FIdRoom:=AValue;
  ModifiedProperty('IdRoom');
end;

procedure TTask.SetIdSclad(AValue: string);
begin
  if FIdSclad=AValue then Exit;
  FIdSclad:=AValue;
  ModifiedProperty('IdSclad');
end;

procedure TTask.SetIdZone(AValue: string);
begin
  if FIdZone=AValue then Exit;
  FIdZone:=AValue;
  ModifiedProperty('IdZone');
end;

procedure TTask.SetNomer(AValue: string);
begin
  if FNomer=AValue then Exit;
  FNomer:=AValue;
  ModifiedProperty('Nomer');
end;

procedure TTask.SetTypeDoc(AValue: string);
begin
  if FTypeDoc=AValue then Exit;
  FTypeDoc:=AValue;
  ModifiedProperty('TypeDoc');
end;

procedure TTask.SetUseAdress(AValue: string);
begin
  if FUseAdress=AValue then Exit;
  FUseAdress:=AValue;
  ModifiedProperty('UseAdress');
end;

procedure TTask.InternalRegisterPropertys;
begin
  RegisterProperty('Nomer', 'nomer', 'О', 'наименование документа', 0, 250);
  RegisterProperty('IdDoc', 'id_doc', 'О', 'guid идентификатор документа', 0, 250);
  RegisterProperty('TypeDoc', 'type', 'О', 'код типа группы документов', 0, 150);
  RegisterProperty('UseAdress', 'as_', 'О', 'признак использования адресного хранения', 0, 150);
  RegisterProperty('Date', 'date', 'О', 'дата создания документа', 0, 150);
  RegisterProperty('Control', 'control', 'О', 'признак строгого учета кол-ва товаров', 0, 150);
  RegisterProperty('Barcode', 'barcode', 'О', 'ШК документа', 0, 150);
  RegisterProperty('IdZone', 'id_zone', 'О', 'guid идентификатор зоны склада', 0, 150);
  RegisterProperty('IdSclad', 'id_sclad', 'О', 'guid идентификатор склад', 0, 150);
  RegisterProperty('IdRoom', 'id_room', 'О', 'guid идентификатор помещения', 0, 150);
  RegisterProperty('Goods', 'record', 'О', 'товар', -1, -1);
end;

procedure TTask.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FGoods:=TGoods.Create;
end;

destructor TTask.Destroy;
begin
  FreeAndNil(FGoods);
  inherited Destroy;
end;

{ TDocument }

procedure TDocument.InternalRegisterPropertys;
begin
  RegisterProperty('Task', 'Task', 'О', 'реквизиты документа', -1, -1);
end;

procedure TDocument.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FTask:=TTask.Create;
end;

destructor TDocument.Destroy;
begin
  FreeAndNil(FTask);
  inherited Destroy;
end;

{ TDocumentsList }

function TDocumentsList.GetItem(AIndex: Integer): TDocument;
begin
  Result:=TDocument(InternalGetItem(AIndex));
end;

constructor TDocumentsList.Create;
begin
  inherited Create(TDocument)
end;

function TDocumentsList.CreateChild: TDocument;
begin
  Result:=InternalAddObject as TDocument;
end;

{ TDocuments }

procedure TDocuments.InternalRegisterPropertys;
begin
  RegisterProperty('Documents', 'Document', 'О', 'группа документов', -1, -1);
end;

procedure TDocuments.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FDocuments:=TDocumentsList.Create;
end;

function TDocuments.RootNodeName: string;
begin
  Result:='Documents';
end;

destructor TDocuments.Destroy;
begin
  FreeAndNil(FDocuments);
  inherited Destroy;
end;

end.

