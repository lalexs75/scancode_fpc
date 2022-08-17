{ interface library for FPC and Lazarus
  Copyright (C) 2019-2022 Lagunov Aleksey alexs75@yandex.ru

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


unit GetStock;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject, AbstractSerializationObjects;

type

  {  Forward declarations  }
  TStocks = class;
  TStocks_Stock = class;
  TStocks_Stock_Room = class;
  TStocks_Stock_Room_Cell = class;

  {  Generic classes for collections  }
  TStocksList = specialize GXMLSerializationObjectList<TStocks>;
  TStocks_StockList = specialize GXMLSerializationObjectList<TStocks_Stock>;
  TStocks_Stock_RoomList = specialize GXMLSerializationObjectList<TStocks_Stock_Room>;
  TStocks_Stock_Room_CellList = specialize GXMLSerializationObjectList<TStocks_Stock_Room_Cell>;

  {  TStocks  }
  TStocks = class(TXmlSerializationObject)
  private
    FStock:TStocks_StockList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    //склад
    property Stock:TStocks_StockList read FStock;
  end;

  {  TStocks_Stock  }
  TStocks_Stock = class(TXmlSerializationObject)
  private
    FRoom:TStocks_Stock_RoomList;
    Fid_sclad:String;
    Fname:String;
    Fbarcode:String;
    procedure Setid_sclad( AValue:String);
    procedure Setname( AValue:String);
    procedure Setbarcode( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    //Room – помещение внутри склада (может быть несколько, а может и не быть вообще)
    property Room:TStocks_Stock_RoomList read FRoom;
    //УИ идентификатор склада
    property id_sclad:String read Fid_sclad write Setid_sclad;
    //наименование склада
    property name:String read Fname write Setname;
    //ШК склада
    property barcode:String read Fbarcode write Setbarcode;
  end;

  {  TStocks_Stock_Room  }
  TStocks_Stock_Room = class(TXmlSerializationObject)
  private
    FCell:TStocks_Stock_Room_CellList;
    Fid_room:String;
    Fname:String;
    Fbarcode:String;
    procedure Setid_room( AValue:String);
    procedure Setname( AValue:String);
    procedure Setbarcode( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    //складская ячейка
    property Cell:TStocks_Stock_Room_CellList read FCell;
    //УИ помещения склада
    property id_room:String read Fid_room write Setid_room;
    //наименование помещения
    property name:String read Fname write Setname;
    //ШК помещения
    property barcode:String read Fbarcode write Setbarcode;
  end;

  {  TStocks_Stock_Room_Cell  }
  TStocks_Stock_Room_Cell = class(TXmlSerializationObject)
  private
    Fid_cell:String;
    Fname:String;
    Fbarcode:String;
    procedure Setid_cell( AValue:String);
    procedure Setname( AValue:String);
    procedure Setbarcode( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    //УИ ячейки склада
    property id_cell:String read Fid_cell write Setid_cell;
    //наименование ячейки
    property name:String read Fname write Setname;
    //ШК ячейки
    property barcode:String read Fbarcode write Setbarcode;
  end;

implementation

  {  TStocks  }
procedure TStocks.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('Stock', 'Stock', [], '', -1, -1);
end;

procedure TStocks.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FStock:=TStocks_StockList.Create;
end;

destructor TStocks.Destroy;
begin
  FStock.Free;
  inherited Destroy;
end;

function TStocks.RootNodeName:string;
begin
  Result:='Stocks';
end;

constructor TStocks.Create;
begin
  inherited Create;
end;

  {  TStocks_Stock  }
procedure TStocks_Stock.Setid_sclad(AValue: String);
begin
  Fid_sclad:=AValue;
  ModifiedProperty('id_sclad');
end;

procedure TStocks_Stock.Setname(AValue: String);
begin
  Fname:=AValue;
  ModifiedProperty('name');
end;

procedure TStocks_Stock.Setbarcode(AValue: String);
begin
  Fbarcode:=AValue;
  ModifiedProperty('barcode');
end;

procedure TStocks_Stock.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('Room', 'Room', [], '', -1, -1);
  P:=RegisterProperty('id_sclad', 'id_sclad', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('name', 'name', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('barcode', 'barcode', [], '', -1, -1);
end;

procedure TStocks_Stock.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FRoom:=TStocks_Stock_RoomList.Create;
end;

destructor TStocks_Stock.Destroy;
begin
  FRoom.Free;
  inherited Destroy;
end;

constructor TStocks_Stock.Create;
begin
  inherited Create;
end;

  {  TStocks_Stock_Room  }
procedure TStocks_Stock_Room.Setid_room(AValue: String);
begin
  Fid_room:=AValue;
  ModifiedProperty('id_room');
end;

procedure TStocks_Stock_Room.Setname(AValue: String);
begin
  Fname:=AValue;
  ModifiedProperty('name');
end;

procedure TStocks_Stock_Room.Setbarcode(AValue: String);
begin
  Fbarcode:=AValue;
  ModifiedProperty('barcode');
end;

procedure TStocks_Stock_Room.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('Cell', 'Cell', [], '', -1, -1);
  P:=RegisterProperty('id_room', 'id_room', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('name', 'name', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('barcode', 'barcode', [], '', -1, -1);
end;

procedure TStocks_Stock_Room.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FCell:=TStocks_Stock_Room_CellList.Create;
end;

destructor TStocks_Stock_Room.Destroy;
begin
  FCell.Free;
  inherited Destroy;
end;

constructor TStocks_Stock_Room.Create;
begin
  inherited Create;
end;

  {  TStocks_Stock_Room_Cell  }
procedure TStocks_Stock_Room_Cell.Setid_cell(AValue: String);
begin
  Fid_cell:=AValue;
  ModifiedProperty('id_cell');
end;

procedure TStocks_Stock_Room_Cell.Setname(AValue: String);
begin
  Fname:=AValue;
  ModifiedProperty('name');
end;

procedure TStocks_Stock_Room_Cell.Setbarcode(AValue: String);
begin
  Fbarcode:=AValue;
  ModifiedProperty('barcode');
end;

procedure TStocks_Stock_Room_Cell.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('id_cell', 'id_cell', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('name', 'name', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('barcode', 'barcode', [], '', -1, -1);
end;

procedure TStocks_Stock_Room_Cell.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TStocks_Stock_Room_Cell.Destroy;
begin
  inherited Destroy;
end;

constructor TStocks_Stock_Room_Cell.Create;
begin
  inherited Create;
end;

end.