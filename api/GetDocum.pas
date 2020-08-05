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


unit GetDocum;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject, AbstractSerializationObjects;

type

  {  Forward declarations  }
  TDocuments = class;
  TDocuments_Task = class;
  TDocuments_Task_record = class;
  TDocuments_Task_record_property = class;
  TDocuments_Task_record_property_serial = class;
  TDocuments_Task_record_property_serial_cells = class;
  TDocuments_Task_record_marked_codes = class;
  TDocuments_Task_record_marked_codes_token = class;

  {  Generic classes for collections  }
  TDocumentsList = specialize GXMLSerializationObjectList<TDocuments>;
  TDocuments_TaskList = specialize GXMLSerializationObjectList<TDocuments_Task>;
  TDocuments_Task_recordList = specialize GXMLSerializationObjectList<TDocuments_Task_record>;
  TDocuments_Task_record_propertyList = specialize GXMLSerializationObjectList<TDocuments_Task_record_property>;
  TDocuments_Task_record_property_serialList = specialize GXMLSerializationObjectList<TDocuments_Task_record_property_serial>;
  TDocuments_Task_record_property_serial_cellsList = specialize GXMLSerializationObjectList<TDocuments_Task_record_property_serial_cells>;
  TDocuments_Task_record_marked_codesList = specialize GXMLSerializationObjectList<TDocuments_Task_record_marked_codes>;
  TDocuments_Task_record_marked_codes_tokenList = specialize GXMLSerializationObjectList<TDocuments_Task_record_marked_codes_token>;

  {  TDocuments  }
  TDocuments = class(TXmlSerializationObject)
  private
    FTask:TDocuments_TaskList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //отдельный документ (задание) в списке (может быть несколько)
    property Task:TDocuments_TaskList read FTask;
  end;

  {  TDocuments_Task  }
  TDocuments_Task = class(TXmlSerializationObject)
  private
    Frecord1:TDocuments_Task_recordList;
    Fid_doc:String;
    Fid_zone:String;
    Fid_room:String;
    Fid_sclad:String;
    Fnomer:String;
    Ftype1:String;
    Fcontrol:Int64;
    Fas_:Int64;
    Fdate:TDateTime;
    Fbarcode:String;
    procedure Setid_doc( AValue:String);
    procedure Setid_zone( AValue:String);
    procedure Setid_room( AValue:String);
    procedure Setid_sclad( AValue:String);
    procedure Setnomer( AValue:String);
    procedure Settype1( AValue:String);
    procedure Setcontrol( AValue:Int64);
    procedure Setas_( AValue:Int64);
    procedure Setdate( AValue:TDateTime);
    procedure Setbarcode( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //список товаров документа (табличная часть документа)
    property record1:TDocuments_Task_recordList read Frecord1;
    //УИ идентификатор документа
    property id_doc:String read Fid_doc write Setid_doc;
    //УИ идентификатор зоны склада
    property id_zone:String read Fid_zone write Setid_zone;
    //УИ идентификатор помещения
    property id_room:String read Fid_room write Setid_room;
    //УИ идентификатор склад
    property id_sclad:String read Fid_sclad write Setid_sclad;
    //наименование документа
    property nomer:String read Fnomer write Setnomer;
    //код типа группы документов
    property type1:String read Ftype1 write Settype1;
    //признак строгого учета количества товаров (используется для инвентаризации, где можно не указывать требуемое кол-во).
    //Возможные значения:
    //* 1 — количество товара в документе превышать нельзя (меньше можно),при этом игнорируется настройка в программе на ТСД.
    //* 0 — количество товара в документе может быть превышено, если включена аналогичная настройка в программе на ТСД.
    property control:Int64 read Fcontrol write Setcontrol;
    //признак использования адресного хранения
    property as_:Int64 read Fas_ write Setas_;
    //дата создания документа
    property date:TDateTime read Fdate write Setdate;
    //ШК документа (может быть использован для быстрого поиска в списке документов на ТСД при помощи сканера штрих кодов).
    property barcode:String read Fbarcode write Setbarcode;
  end;

  {  TDocuments_Task_record  }
  TDocuments_Task_record = class(TXmlSerializationObject)
  private
    Fproperty1:TDocuments_Task_record_propertyList;
    Fmarked_codes:TDocuments_Task_record_marked_codes;
    Fid_char:String;
    Fid_goods:String;
    Fquantity:String;
    procedure Setid_char( AValue:String);
    procedure Setid_goods( AValue:String);
    procedure Setquantity( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //свойства товара (может быть один или несколько, описывает в каких упаковках может быть собран товар)
    property property1:TDocuments_Task_record_propertyList read Fproperty1;
    //список кодов маркировки
    property marked_codes:TDocuments_Task_record_marked_codes read Fmarked_codes;
    //УИ характеристики товара (может быть пустым или отсутствовать)
    property id_char:String read Fid_char write Setid_char;
    //УИ товара
    property id_goods:String read Fid_goods write Setid_goods;
    //требуемое количество (в единицах упаковки товара, как задано в документе)
    property quantity:String read Fquantity write Setquantity;
  end;

  {  TDocuments_Task_record_property  }
  TDocuments_Task_record_property = class(TXmlSerializationObject)
  private
    Fserial:TDocuments_Task_record_property_serial;
    Fid_pack:String;
    Fquantity:String;
    procedure Setid_pack( AValue:String);
    procedure Setquantity( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //информация о серии товара (может быть несколько, может быть пустым или отсутствовать, если не используется учет по сериям)
    property serial:TDocuments_Task_record_property_serial read Fserial;
    //УИ упаковки
    property id_pack:String read Fid_pack write Setid_pack;
    //требуемое количество (в единицах упаковки )
    property quantity:String read Fquantity write Setquantity;
  end;

  {  TDocuments_Task_record_property_serial  }
  TDocuments_Task_record_property_serial = class(TXmlSerializationObject)
  private
    Fcells:TDocuments_Task_record_property_serial_cellsList;
    Fid_serial:String;
    Fquantity:String;
    procedure Setid_serial( AValue:String);
    procedure Setquantity( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property cells:TDocuments_Task_record_property_serial_cellsList read Fcells;
    //УИ серии
    property id_serial:String read Fid_serial write Setid_serial;
    //требуемое количество (количество в разрезе серии, в теории тут передается справочная информация: какие серии товара с каким количеством находятся на складе по учету в ТУП. Т. е. Какое количество и какой серии можно брать, но на практике берут по факту).
    property quantity:String read Fquantity write Setquantity;
  end;

  {  TDocuments_Task_record_property_serial_cells  }
  TDocuments_Task_record_property_serial_cells = class(TXmlSerializationObject)
  private
    Fcell:String;
    Fcelladdress:String;
    procedure Setcell( AValue:String);
    procedure Setcelladdress( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property cell:String read Fcell write Setcell;
    property celladdress:String read Fcelladdress write Setcelladdress;
  end;

  {  TDocuments_Task_record_marked_codes  }
  TDocuments_Task_record_marked_codes = class(TXmlSerializationObject)
  private
    Ftoken:TDocuments_Task_record_marked_codes_tokenList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //уникальный код маркировки
    property token:TDocuments_Task_record_marked_codes_tokenList read Ftoken;
  end;

  {  TDocuments_Task_record_marked_codes_token  }
  TDocuments_Task_record_marked_codes_token = class(TXmlSerializationObject)
  private
    FGS1_DATAMATRIX:String;
    Fpack:String;
    procedure SetGS1_DATAMATRIX( AValue:String);
    procedure Setpack( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //значение кода маркировки отдельного товара
    property GS1_DATAMATRIX:String read FGS1_DATAMATRIX write SetGS1_DATAMATRIX;
    //код логистической упаковки (не обязательно), если коды были агрегированны
    property pack:String read Fpack write Setpack;
  end;

implementation

  {  TDocuments  }
procedure TDocuments.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('Task', 'Task', [], '', -1, -1);
end;

procedure TDocuments.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FTask:=TDocuments_TaskList.Create;
end;

destructor TDocuments.Destroy;
begin
  FTask.Free;
  inherited Destroy;
end;

function TDocuments.RootNodeName:string;
begin
  Result:='Documents';
end;

constructor TDocuments.Create;
begin
  inherited Create;
end;

  {  TDocuments_Task  }
procedure TDocuments_Task.Setid_doc(AValue: String);
begin
  Fid_doc:=AValue;
  ModifiedProperty('id_doc');
end;

procedure TDocuments_Task.Setid_zone(AValue: String);
begin
  Fid_zone:=AValue;
  ModifiedProperty('id_zone');
end;

procedure TDocuments_Task.Setid_room(AValue: String);
begin
  Fid_room:=AValue;
  ModifiedProperty('id_room');
end;

procedure TDocuments_Task.Setid_sclad(AValue: String);
begin
  Fid_sclad:=AValue;
  ModifiedProperty('id_sclad');
end;

procedure TDocuments_Task.Setnomer(AValue: String);
begin
  Fnomer:=AValue;
  ModifiedProperty('nomer');
end;

procedure TDocuments_Task.Settype1(AValue: String);
begin
  Ftype1:=AValue;
  ModifiedProperty('type1');
end;

procedure TDocuments_Task.Setcontrol(AValue: Int64);
begin
  Fcontrol:=AValue;
  ModifiedProperty('control');
end;

procedure TDocuments_Task.Setas_(AValue: Int64);
begin
  Fas_:=AValue;
  ModifiedProperty('as_');
end;

procedure TDocuments_Task.Setdate(AValue: TDateTime);
begin
  Fdate:=AValue;
  ModifiedProperty('date');
end;

procedure TDocuments_Task.Setbarcode(AValue: String);
begin
  Fbarcode:=AValue;
  ModifiedProperty('barcode');
end;

procedure TDocuments_Task.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('record1', 'record', [], '', -1, -1);
  P:=RegisterProperty('id_doc', 'id_doc', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('id_zone', 'id_zone', [], '', -1, -1);
  P:=RegisterProperty('id_room', 'id_room', [], '', -1, -1);
  P:=RegisterProperty('id_sclad', 'id_sclad', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('nomer', 'nomer', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('type1', 'type', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('control', 'control', [], '', -1, -1);
  P:=RegisterProperty('as_', 'as_', [], '', -1, -1);
  P:=RegisterProperty('date', 'date', [], '', -1, -1);
  P:=RegisterProperty('barcode', 'barcode', [], '', -1, -1);
end;

procedure TDocuments_Task.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Frecord1:=TDocuments_Task_recordList.Create;
end;

destructor TDocuments_Task.Destroy;
begin
  Frecord1.Free;
  inherited Destroy;
end;

constructor TDocuments_Task.Create;
begin
  inherited Create;
end;

  {  TDocuments_Task_record  }
procedure TDocuments_Task_record.Setid_char(AValue: String);
begin
  Fid_char:=AValue;
  ModifiedProperty('id_char');
end;

procedure TDocuments_Task_record.Setid_goods(AValue: String);
begin
  Fid_goods:=AValue;
  ModifiedProperty('id_goods');
end;

procedure TDocuments_Task_record.Setquantity(AValue: String);
begin
  Fquantity:=AValue;
  ModifiedProperty('quantity');
end;

procedure TDocuments_Task_record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('property1', 'property', [], '', -1, -1);
  P:=RegisterProperty('marked_codes', 'marked_codes', [], '', -1, -1);
  P:=RegisterProperty('id_char', 'id_char', [], '', -1, -1);
  P:=RegisterProperty('id_goods', 'id_goods', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('quantity', 'quantity', [xsaRequared], '', -1, -1);
end;

procedure TDocuments_Task_record.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Fproperty1:=TDocuments_Task_record_propertyList.Create;
  Fmarked_codes:=TDocuments_Task_record_marked_codes.Create;
end;

destructor TDocuments_Task_record.Destroy;
begin
  Fproperty1.Free;
  Fmarked_codes.Free;
  inherited Destroy;
end;

constructor TDocuments_Task_record.Create;
begin
  inherited Create;
end;

  {  TDocuments_Task_record_property  }
procedure TDocuments_Task_record_property.Setid_pack(AValue: String);
begin
  Fid_pack:=AValue;
  ModifiedProperty('id_pack');
end;

procedure TDocuments_Task_record_property.Setquantity(AValue: String);
begin
  Fquantity:=AValue;
  ModifiedProperty('quantity');
end;

procedure TDocuments_Task_record_property.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('serial', 'serial', [], '', -1, -1);
  P:=RegisterProperty('id_pack', 'id_pack', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('quantity', 'quantity', [xsaRequared], '', -1, -1);
end;

procedure TDocuments_Task_record_property.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Fserial:=TDocuments_Task_record_property_serial.Create;
end;

destructor TDocuments_Task_record_property.Destroy;
begin
  Fserial.Free;
  inherited Destroy;
end;

constructor TDocuments_Task_record_property.Create;
begin
  inherited Create;
end;

  {  TDocuments_Task_record_property_serial  }
procedure TDocuments_Task_record_property_serial.Setid_serial(AValue: String);
begin
  Fid_serial:=AValue;
  ModifiedProperty('id_serial');
end;

procedure TDocuments_Task_record_property_serial.Setquantity(AValue: String);
begin
  Fquantity:=AValue;
  ModifiedProperty('quantity');
end;

procedure TDocuments_Task_record_property_serial.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('cells', 'cells', [], '', -1, -1);
  P:=RegisterProperty('id_serial', 'id_serial', [], '', -1, -1);
  P:=RegisterProperty('quantity', 'quantity', [], '', -1, -1);
end;

procedure TDocuments_Task_record_property_serial.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Fcells:=TDocuments_Task_record_property_serial_cellsList.Create;
end;

destructor TDocuments_Task_record_property_serial.Destroy;
begin
  Fcells.Free;
  inherited Destroy;
end;

constructor TDocuments_Task_record_property_serial.Create;
begin
  inherited Create;
end;

  {  TDocuments_Task_record_property_serial_cells  }
procedure TDocuments_Task_record_property_serial_cells.Setcell(AValue: String);
begin
  Fcell:=AValue;
  ModifiedProperty('cell');
end;

procedure TDocuments_Task_record_property_serial_cells.Setcelladdress(AValue: String);
begin
  Fcelladdress:=AValue;
  ModifiedProperty('celladdress');
end;

procedure TDocuments_Task_record_property_serial_cells.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('cell', 'cell', [], '', -1, -1);
  P:=RegisterProperty('celladdress', 'celladdress', [], '', -1, -1);
end;

procedure TDocuments_Task_record_property_serial_cells.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TDocuments_Task_record_property_serial_cells.Destroy;
begin
  inherited Destroy;
end;

constructor TDocuments_Task_record_property_serial_cells.Create;
begin
  inherited Create;
end;

  {  TDocuments_Task_record_marked_codes  }
procedure TDocuments_Task_record_marked_codes.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('token', 'token', [], '', -1, -1);
end;

procedure TDocuments_Task_record_marked_codes.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Ftoken:=TDocuments_Task_record_marked_codes_tokenList.Create;
end;

destructor TDocuments_Task_record_marked_codes.Destroy;
begin
  Ftoken.Free;
  inherited Destroy;
end;

constructor TDocuments_Task_record_marked_codes.Create;
begin
  inherited Create;
end;

  {  TDocuments_Task_record_marked_codes_token  }
procedure TDocuments_Task_record_marked_codes_token.SetGS1_DATAMATRIX(AValue: String);
begin
  FGS1_DATAMATRIX:=AValue;
  ModifiedProperty('GS1_DATAMATRIX');
end;

procedure TDocuments_Task_record_marked_codes_token.Setpack(AValue: String);
begin
  Fpack:=AValue;
  ModifiedProperty('pack');
end;

procedure TDocuments_Task_record_marked_codes_token.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('GS1_DATAMATRIX', 'GS1_DATAMATRIX', [], '', -1, -1);
  P:=RegisterProperty('pack', 'pack', [], '', -1, -1);
end;

procedure TDocuments_Task_record_marked_codes_token.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TDocuments_Task_record_marked_codes_token.Destroy;
begin
  inherited Destroy;
end;

constructor TDocuments_Task_record_marked_codes_token.Create;
begin
  inherited Create;
end;

end.