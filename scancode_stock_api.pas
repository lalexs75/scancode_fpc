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

unit scancode_stock_api;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject, AbstractSerializationObjects;

type

  { TCell }

  TCell = class(TXmlSerializationObject)
  private
    FBarcode: string;
    FIdCell: string;
    FName: string;
    procedure SetBarcode(AValue: string);
    procedure SetIdCell(AValue: string);
    procedure SetName(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property IdCell:string read FIdCell write SetIdCell;
    property Barcode:string read FBarcode write SetBarcode;
    property Name:string read FName write SetName;
  end;
  TCells = specialize GXMLSerializationObjectList<TCell>;

  { TRoom }

  TRoom = class(TXmlSerializationObject)
  private
    FBarcode: string;
    FCells: TCells;
    FIdRoom: string;
    FName: string;
    procedure SetBarcode(AValue: string);
    procedure SetIdRoom(AValue: string);
    procedure SetName(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property IdRoom:string read FIdRoom write SetIdRoom;
    property Barcode:string read FBarcode write SetBarcode;
    property Name:string read FName write SetName;
    property Cells:TCells read FCells;
  end;
  TRooms = specialize GXMLSerializationObjectList<TRoom>;

  { TStock }

  TStock = class(TXmlSerializationObject)
  private
    FBarcode: string;
    FIdStock: string;
    FName: string;
    FRooms: TRooms;
    procedure SetBarcode(AValue: string);
    procedure SetIdStock(AValue: string);
    procedure SetName(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property IdStock:string read FIdStock write SetIdStock;
    property Barcode:string read FBarcode write SetBarcode;
    property Name:string read FName write SetName;
    property Rooms:TRooms read FRooms;
  end;
  TStockList = specialize GXMLSerializationObjectList<TStock>;

  { TStocks }

  TStocks = class(TXmlSerializationObject)
  private
    FStocks: TStockList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    destructor Destroy; override;
  published
    property Stocks:TStockList read FStocks;
  end;

implementation

{ TCell }

procedure TCell.SetBarcode(AValue: string);
begin
  if FBarcode=AValue then Exit;
  FBarcode:=AValue;
  ModifiedProperty('Barcode');
end;

procedure TCell.SetIdCell(AValue: string);
begin
  if FIdCell=AValue then Exit;
  FIdCell:=AValue;
  ModifiedProperty('IdCell');
end;

procedure TCell.SetName(AValue: string);
begin
  if FName=AValue then Exit;
  FName:=AValue;
  ModifiedProperty('Name');
end;

procedure TCell.InternalRegisterPropertys;
begin
  RegisterProperty('IdCell', 'id_cell', [xsaRequared], 'guid идентификатор ячейки склада', 0, 250);
  RegisterProperty('Barcode', 'barcode', [xsaRequared], 'ШК ячейки', 0, 250);
  RegisterProperty('Name', 'name', [xsaRequared], 'наименование ячейки', 0, 250);
end;

procedure TCell.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TCell.Destroy;
begin
  inherited Destroy;
end;

{ TRoom }

procedure TRoom.SetBarcode(AValue: string);
begin
  if FBarcode=AValue then Exit;
  FBarcode:=AValue;
  ModifiedProperty('Barcode');
end;

procedure TRoom.SetIdRoom(AValue: string);
begin
  if FIdRoom=AValue then Exit;
  FIdRoom:=AValue;
  ModifiedProperty('IdRoom');
end;

procedure TRoom.SetName(AValue: string);
begin
  if FName=AValue then Exit;
  FName:=AValue;
  ModifiedProperty('Name');
end;

procedure TRoom.InternalRegisterPropertys;
begin
  RegisterProperty('IdRoom', 'id_room', [xsaRequared], 'guid идентификатор помещения склада', 0, 250);
  RegisterProperty('Barcode', 'barcode', [xsaRequared], 'ШК помещения', 0, 250);
  RegisterProperty('Name', 'name', [xsaRequared], 'наименование помещения', 0, 250);
  RegisterProperty('Cells', 'Сell', [xsaRequared], 'складская ячейка', -1, -1);
end;

procedure TRoom.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FCells:=TCells.Create;
end;

destructor TRoom.Destroy;
begin
  FreeAndNil(FCells);
  inherited Destroy;
end;

{ TStocks }

procedure TStocks.InternalRegisterPropertys;
begin
  RegisterProperty('Stocks', 'Stocks', [xsaRequared], 'группа складов (одна на весь файл)', -1, -1);
end;

procedure TStocks.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FStocks:=TStockList.Create;
end;

function TStocks.RootNodeName: string;
begin
  Result:='Stocks';
end;

destructor TStocks.Destroy;
begin
  FreeAndNil(FStocks);
  inherited Destroy;
end;

{ TStock }

procedure TStock.SetBarcode(AValue: string);
begin
  if FBarcode=AValue then Exit;
  FBarcode:=AValue;
  ModifiedProperty('Barcode');
end;

procedure TStock.SetIdStock(AValue: string);
begin
  if FIdStock=AValue then Exit;
  FIdStock:=AValue;
  ModifiedProperty('IdStock');
end;

procedure TStock.SetName(AValue: string);
begin
  if FName=AValue then Exit;
  FName:=AValue;
  ModifiedProperty('Name');
end;

procedure TStock.InternalRegisterPropertys;
begin
  RegisterProperty('IdStock', 'id_stock', [xsaRequared], 'guid идентификатор склада', 0, 255);
  RegisterProperty('Barcode', 'barcode', [xsaRequared], 'ШК склада', 0, 255);
  RegisterProperty('Name', 'name', [xsaRequared], 'наименование склада', 0, 255);
  RegisterProperty('Rooms', 'Room', [xsaRequared], 'помещение внутри склада (может быть несколько, а может и не быть вообще)', -1, -1);
end;

procedure TStock.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FRooms:=TRooms.Create;
end;

destructor TStock.Destroy;
begin
  FreeAndNil(FRooms);
  inherited Destroy;
end;

end.

