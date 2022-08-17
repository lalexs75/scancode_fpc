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


unit PutDocum;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject, AbstractSerializationObjects;

type

  {  Forward declarations  }
  TOrders = class;
  TOrders_handbooks = class;
  TOrders_handbooks_nomencls = class;
  TOrders_handbooks_nomencls_record = class;
  TOrders_handbooks_characteristics = class;
  TOrders_handbooks_characteristics_record = class;
  TOrders_handbooks_barcodes = class;
  TOrders_handbooks_barcodes_record = class;
  TOrders_Task = class;
  TOrders_Task_record = class;
  TOrders_Task_record_property = class;
  TOrders_Task_record_property_serial = class;
  TOrders_Task_record_property_serial_cells = class;
  TOrders_Task_record_alco = class;
  TOrders_Task_record_marked_codes = class;
  TOrders_Task_record_marked_codes_token = class;

  {  Generic classes for collections  }
  TOrdersList = specialize GXMLSerializationObjectList<TOrders>;
  TOrders_handbooksList = specialize GXMLSerializationObjectList<TOrders_handbooks>;
  TOrders_handbooks_nomenclsList = specialize GXMLSerializationObjectList<TOrders_handbooks_nomencls>;
  TOrders_handbooks_nomencls_recordList = specialize GXMLSerializationObjectList<TOrders_handbooks_nomencls_record>;
  TOrders_handbooks_characteristicsList = specialize GXMLSerializationObjectList<TOrders_handbooks_characteristics>;
  TOrders_handbooks_characteristics_recordList = specialize GXMLSerializationObjectList<TOrders_handbooks_characteristics_record>;
  TOrders_handbooks_barcodesList = specialize GXMLSerializationObjectList<TOrders_handbooks_barcodes>;
  TOrders_handbooks_barcodes_recordList = specialize GXMLSerializationObjectList<TOrders_handbooks_barcodes_record>;
  TOrders_TaskList = specialize GXMLSerializationObjectList<TOrders_Task>;
  TOrders_Task_recordList = specialize GXMLSerializationObjectList<TOrders_Task_record>;
  TOrders_Task_record_propertyList = specialize GXMLSerializationObjectList<TOrders_Task_record_property>;
  TOrders_Task_record_property_serialList = specialize GXMLSerializationObjectList<TOrders_Task_record_property_serial>;
  TOrders_Task_record_property_serial_cellsList = specialize GXMLSerializationObjectList<TOrders_Task_record_property_serial_cells>;
  TOrders_Task_record_alcoList = specialize GXMLSerializationObjectList<TOrders_Task_record_alco>;
  TOrders_Task_record_marked_codesList = specialize GXMLSerializationObjectList<TOrders_Task_record_marked_codes>;
  TOrders_Task_record_marked_codes_tokenList = specialize GXMLSerializationObjectList<TOrders_Task_record_marked_codes_token>;

  {  TOrders  }
  TOrders = class(TXmlSerializationObject)
  private
    Fhandbooks:TOrders_handbooks;
    FTask:TOrders_TaskList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    //– справочник товаров и сопутствующих списков для новых (созданных пользователем и/или добавленных пользователем в ордер/документ)
    property handbooks:TOrders_handbooks read Fhandbooks;
    //реквизиты документа, на основании которого создан ордер
    property Task:TOrders_TaskList read FTask;
  end;

  {  TOrders_handbooks  }
  TOrders_handbooks = class(TXmlSerializationObject)
  private
    Fnomencls:TOrders_handbooks_nomencls;
    Fcharacteristics:TOrders_handbooks_characteristics;
    Fbarcodes:TOrders_handbooks_barcodes;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    //список товаров, созданных пользователем на ТСД или загруженных отдельно (по запросу) из ТУП.
    property nomencls:TOrders_handbooks_nomencls read Fnomencls;
    property characteristics:TOrders_handbooks_characteristics read Fcharacteristics;
    //список штрих кодов
    property barcodes:TOrders_handbooks_barcodes read Fbarcodes;
  end;

  {  TOrders_handbooks_nomencls  }
  TOrders_handbooks_nomencls = class(TXmlSerializationObject)
  private
    Frecord1:TOrders_handbooks_nomencls_recordList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property record1:TOrders_handbooks_nomencls_recordList read Frecord1;
  end;

  {  TOrders_handbooks_nomencls_record  }
  TOrders_handbooks_nomencls_record = class(TXmlSerializationObject)
  private
    Fid_goods:String;
    Fname:String;
    Fid_measure:String;
    Fid_vidnomencl:String;
    Fimg:String;
    Fbitmap:String;
    procedure Setid_goods( AValue:String);
    procedure Setname( AValue:String);
    procedure Setid_measure( AValue:String);
    procedure Setid_vidnomencl( AValue:String);
    procedure Setimg( AValue:String);
    procedure Setbitmap( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property id_goods:String read Fid_goods write Setid_goods;
    property name:String read Fname write Setname;
    property id_measure:String read Fid_measure write Setid_measure;
    property id_vidnomencl:String read Fid_vidnomencl write Setid_vidnomencl;
    property img:String read Fimg write Setimg;
    property bitmap:String read Fbitmap write Setbitmap;
  end;

  {  TOrders_handbooks_characteristics  }
  TOrders_handbooks_characteristics = class(TXmlSerializationObject)
  private
    Frecord1:TOrders_handbooks_characteristics_recordList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    //список характеристик
    property record1:TOrders_handbooks_characteristics_recordList read Frecord1;
  end;

  {  TOrders_handbooks_characteristics_record  }
  TOrders_handbooks_characteristics_record = class(TXmlSerializationObject)
  private
    Fid_goods:String;
    Fid_char:String;
    Fname:String;
    procedure Setid_goods( AValue:String);
    procedure Setid_char( AValue:String);
    procedure Setname( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property id_goods:String read Fid_goods write Setid_goods;
    property id_char:String read Fid_char write Setid_char;
    property name:String read Fname write Setname;
  end;

  {  TOrders_handbooks_barcodes  }
  TOrders_handbooks_barcodes = class(TXmlSerializationObject)
  private
    Frecord1:TOrders_handbooks_barcodes_recordList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property record1:TOrders_handbooks_barcodes_recordList read Frecord1;
  end;

  {  TOrders_handbooks_barcodes_record  }
  TOrders_handbooks_barcodes_record = class(TXmlSerializationObject)
  private
    Fid_goods:String;
    Fid_char:String;
    Fid_pack:String;
    Fbarcode:String;
    procedure Setid_goods( AValue:String);
    procedure Setid_char( AValue:String);
    procedure Setid_pack( AValue:String);
    procedure Setbarcode( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property id_goods:String read Fid_goods write Setid_goods;
    property id_char:String read Fid_char write Setid_char;
    property id_pack:String read Fid_pack write Setid_pack;
    property barcode:String read Fbarcode write Setbarcode;
  end;

  {  TOrders_Task  }
  TOrders_Task = class(TXmlSerializationObject)
  private
    Frecord1:TOrders_Task_recordList;
    Fid_doc:String;
    Fdate:String;
    Ftype1:String;
    Fdate_order:String;
    Ffc:String;
    Fid_sclad:String;
    Flast_order:Int64;
    Forders:String;
    procedure Setid_doc( AValue:String);
    procedure Setdate( AValue:String);
    procedure Settype1( AValue:String);
    procedure Setdate_order( AValue:String);
    procedure Setfc( AValue:String);
    procedure Setid_sclad( AValue:String);
    procedure Setlast_order( AValue:Int64);
    procedure Setorders( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    //товар
    property record1:TOrders_Task_recordList read Frecord1;
    //УИ документа
    property id_doc:String read Fid_doc write Setid_doc;
    //дата создания документа (во внешней учетной системе)
    property date:String read Fdate write Setdate;
    //тип группы документа
    property type1:String read Ftype1 write Settype1;
    //дата создания ордера
    property date_order:String read Fdate_order write Setdate_order;
    //признак «свободный набор» (значение: 1 или 0, по умолчанию 0)
    property fc:String read Ffc write Setfc;
    //УИ склада
    property id_sclad:String read Fid_sclad write Setid_sclad;
    //признак «завершающий ордер» (значение: 1 или 0, по умолчанию 0). Используется при типе документа «Инвентаризация», последним является ордер, которых завершает процесс инвентаризации на складе. При получении такого ордера ТУП, проводит документ «Инвентаризация» и более не принимает движений (ордеров) по нему.
    property last_order:Int64 read Flast_order write Setlast_order;
    //содержит номер(а) ордеров, которые выгружаются, значение этого атрибута записывается в коментарии к документу
    property orders:String read Forders write Setorders;
  end;

  {  TOrders_Task_record  }
  TOrders_Task_record = class(TXmlSerializationObject)
  private
    Fproperty1:TOrders_Task_record_property;
    Falco:TOrders_Task_record_alco;
    Fmarked_codes:TOrders_Task_record_marked_codes;
    Fid_goods:String;
    Fid_char:String;
    procedure Setid_goods( AValue:String);
    procedure Setid_char( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    //описание свойств
    property property1:TOrders_Task_record_property read Fproperty1;
    //коды акцизных марок (может отсутствовать)
    property alco:TOrders_Task_record_alco read Falco;
    //коды маркировок
    property marked_codes:TOrders_Task_record_marked_codes read Fmarked_codes;
    //УИ товара
    property id_goods:String read Fid_goods write Setid_goods;
    //УИ характеристик
    property id_char:String read Fid_char write Setid_char;
  end;

  {  TOrders_Task_record_property  }
  TOrders_Task_record_property = class(TXmlSerializationObject)
  private
    Fserial:TOrders_Task_record_property_serial;
    Fid_pack:String;
    procedure Setid_pack( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    //серии товаров
    property serial:TOrders_Task_record_property_serial read Fserial;
    //УИ упаковки
    property id_pack:String read Fid_pack write Setid_pack;
  end;

  {  TOrders_Task_record_property_serial  }
  TOrders_Task_record_property_serial = class(TXmlSerializationObject)
  private
    Fcells:TOrders_Task_record_property_serial_cellsList;
    Fquantity:String;
    Fid_serial:String;
    Fdate:String;
    Fvalue:String;
    procedure Setquantity( AValue:String);
    procedure Setid_serial( AValue:String);
    procedure Setdate( AValue:String);
    procedure Setvalue( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    //информация о ячейках товара (может отсутствовать, если не используется адресное хранение)
    property cells:TOrders_Task_record_property_serial_cellsList read Fcells;
    //количество собранного товара в единицах измерения упаковки (если упаковки нет, т. е. id_pack – пустое значение, то в базовых ед. измерения товара)
    property quantity:String read Fquantity write Setquantity;
    //УИ серии (если выбрана из списка загруженных из ТУП)
    property id_serial:String read Fid_serial write Setid_serial;
    //указанная пользователем дата срока годности (если требуется)
    property date:String read Fdate write Setdate;
    //серия (произвольное значение) введенное пользователем на ТСД (если требуется)
    property value:String read Fvalue write Setvalue;
  end;

  {  TOrders_Task_record_property_serial_cells  }
  TOrders_Task_record_property_serial_cells = class(TXmlSerializationObject)
  private
    Fid_cell:String;
    Fcelladdress:String;
    Fquantity:String;
    procedure Setid_cell( AValue:String);
    procedure Setcelladdress( AValue:String);
    procedure Setquantity( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    //УИ ячейки
    property id_cell:String read Fid_cell write Setid_cell;
    //наименование ячейки
    property celladdress:String read Fcelladdress write Setcelladdress;
    //количество собранного товара из данной ячейки
    property quantity:String read Fquantity write Setquantity;
  end;

  {  TOrders_Task_record_alco  }
  TOrders_Task_record_alco = class(TXmlSerializationObject)
  private
    FPDF417:String;
    FDATAMATRIX:String;
    procedure SetPDF417( AValue:String);
    procedure SetDATAMATRIX( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property PDF417:String read FPDF417 write SetPDF417;
    property DATAMATRIX:String read FDATAMATRIX write SetDATAMATRIX;
  end;

  {  TOrders_Task_record_marked_codes  }
  TOrders_Task_record_marked_codes = class(TXmlSerializationObject)
  private
    Ftoken:TOrders_Task_record_marked_codes_tokenList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    //код маркировки
    property token:TOrders_Task_record_marked_codes_tokenList read Ftoken;
  end;

  {  TOrders_Task_record_marked_codes_token  }
  TOrders_Task_record_marked_codes_token = class(TXmlSerializationObject)
  private
    FGS1_DATAMATRIX:String;
    procedure SetGS1_DATAMATRIX( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    //значение кода марки, считанный с этикетки сканером
    property GS1_DATAMATRIX:String read FGS1_DATAMATRIX write SetGS1_DATAMATRIX;
  end;

implementation

  {  TOrders  }
procedure TOrders.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('handbooks', 'handbooks', [], '', -1, -1);
  P:=RegisterProperty('Task', 'Task', [], '', -1, -1);
end;

procedure TOrders.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Fhandbooks:=TOrders_handbooks.Create;
  FTask:=TOrders_TaskList.Create;
end;

destructor TOrders.Destroy;
begin
  Fhandbooks.Free;
  FTask.Free;
  inherited Destroy;
end;

function TOrders.RootNodeName:string;
begin
  Result:='Orders';
end;

constructor TOrders.Create;
begin
  inherited Create;
end;

  {  TOrders_handbooks  }
procedure TOrders_handbooks.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('nomencls', 'nomencls', [], '', -1, -1);
  P:=RegisterProperty('characteristics', 'characteristics', [], '', -1, -1);
  P:=RegisterProperty('barcodes', 'barcodes', [], '', -1, -1);
end;

procedure TOrders_handbooks.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Fnomencls:=TOrders_handbooks_nomencls.Create;
  Fcharacteristics:=TOrders_handbooks_characteristics.Create;
  Fbarcodes:=TOrders_handbooks_barcodes.Create;
end;

destructor TOrders_handbooks.Destroy;
begin
  Fnomencls.Free;
  Fcharacteristics.Free;
  Fbarcodes.Free;
  inherited Destroy;
end;

constructor TOrders_handbooks.Create;
begin
  inherited Create;
end;

  {  TOrders_handbooks_nomencls  }
procedure TOrders_handbooks_nomencls.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('record1', 'record', [], '', -1, -1);
end;

procedure TOrders_handbooks_nomencls.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Frecord1:=TOrders_handbooks_nomencls_recordList.Create;
end;

destructor TOrders_handbooks_nomencls.Destroy;
begin
  Frecord1.Free;
  inherited Destroy;
end;

constructor TOrders_handbooks_nomencls.Create;
begin
  inherited Create;
end;

  {  TOrders_handbooks_nomencls_record  }
procedure TOrders_handbooks_nomencls_record.Setid_goods(AValue: String);
begin
  Fid_goods:=AValue;
  ModifiedProperty('id_goods');
end;

procedure TOrders_handbooks_nomencls_record.Setname(AValue: String);
begin
  Fname:=AValue;
  ModifiedProperty('name');
end;

procedure TOrders_handbooks_nomencls_record.Setid_measure(AValue: String);
begin
  Fid_measure:=AValue;
  ModifiedProperty('id_measure');
end;

procedure TOrders_handbooks_nomencls_record.Setid_vidnomencl(AValue: String);
begin
  Fid_vidnomencl:=AValue;
  ModifiedProperty('id_vidnomencl');
end;

procedure TOrders_handbooks_nomencls_record.Setimg(AValue: String);
begin
  Fimg:=AValue;
  ModifiedProperty('img');
end;

procedure TOrders_handbooks_nomencls_record.Setbitmap(AValue: String);
begin
  Fbitmap:=AValue;
  ModifiedProperty('bitmap');
end;

procedure TOrders_handbooks_nomencls_record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('id_goods', 'id_goods', [], '', -1, -1);
  P:=RegisterProperty('name', 'name', [], '', -1, -1);
  P:=RegisterProperty('id_measure', 'id_measure', [], '', -1, -1);
  P:=RegisterProperty('id_vidnomencl', 'id_vidnomencl', [], '', -1, -1);
  P:=RegisterProperty('img', 'img', [], '', -1, -1);
  P:=RegisterProperty('bitmap', 'bitmap', [], '', -1, -1);
end;

procedure TOrders_handbooks_nomencls_record.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TOrders_handbooks_nomencls_record.Destroy;
begin
  inherited Destroy;
end;

constructor TOrders_handbooks_nomencls_record.Create;
begin
  inherited Create;
end;

  {  TOrders_handbooks_characteristics  }
procedure TOrders_handbooks_characteristics.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('record1', 'record', [], '', -1, -1);
end;

procedure TOrders_handbooks_characteristics.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Frecord1:=TOrders_handbooks_characteristics_recordList.Create;
end;

destructor TOrders_handbooks_characteristics.Destroy;
begin
  Frecord1.Free;
  inherited Destroy;
end;

constructor TOrders_handbooks_characteristics.Create;
begin
  inherited Create;
end;

  {  TOrders_handbooks_characteristics_record  }
procedure TOrders_handbooks_characteristics_record.Setid_goods(AValue: String);
begin
  Fid_goods:=AValue;
  ModifiedProperty('id_goods');
end;

procedure TOrders_handbooks_characteristics_record.Setid_char(AValue: String);
begin
  Fid_char:=AValue;
  ModifiedProperty('id_char');
end;

procedure TOrders_handbooks_characteristics_record.Setname(AValue: String);
begin
  Fname:=AValue;
  ModifiedProperty('name');
end;

procedure TOrders_handbooks_characteristics_record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('id_goods', 'id_goods', [], '', -1, -1);
  P:=RegisterProperty('id_char', 'id_char', [], '', -1, -1);
  P:=RegisterProperty('name', 'name', [], '', -1, -1);
end;

procedure TOrders_handbooks_characteristics_record.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TOrders_handbooks_characteristics_record.Destroy;
begin
  inherited Destroy;
end;

constructor TOrders_handbooks_characteristics_record.Create;
begin
  inherited Create;
end;

  {  TOrders_handbooks_barcodes  }
procedure TOrders_handbooks_barcodes.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('record1', 'record', [], '', -1, -1);
end;

procedure TOrders_handbooks_barcodes.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Frecord1:=TOrders_handbooks_barcodes_recordList.Create;
end;

destructor TOrders_handbooks_barcodes.Destroy;
begin
  Frecord1.Free;
  inherited Destroy;
end;

constructor TOrders_handbooks_barcodes.Create;
begin
  inherited Create;
end;

  {  TOrders_handbooks_barcodes_record  }
procedure TOrders_handbooks_barcodes_record.Setid_goods(AValue: String);
begin
  Fid_goods:=AValue;
  ModifiedProperty('id_goods');
end;

procedure TOrders_handbooks_barcodes_record.Setid_char(AValue: String);
begin
  Fid_char:=AValue;
  ModifiedProperty('id_char');
end;

procedure TOrders_handbooks_barcodes_record.Setid_pack(AValue: String);
begin
  Fid_pack:=AValue;
  ModifiedProperty('id_pack');
end;

procedure TOrders_handbooks_barcodes_record.Setbarcode(AValue: String);
begin
  Fbarcode:=AValue;
  ModifiedProperty('barcode');
end;

procedure TOrders_handbooks_barcodes_record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('id_goods', 'id_goods', [], '', -1, -1);
  P:=RegisterProperty('id_char', 'id_char', [], '', -1, -1);
  P:=RegisterProperty('id_pack', 'id_pack', [], '', -1, -1);
  P:=RegisterProperty('barcode', 'barcode', [], '', -1, -1);
end;

procedure TOrders_handbooks_barcodes_record.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TOrders_handbooks_barcodes_record.Destroy;
begin
  inherited Destroy;
end;

constructor TOrders_handbooks_barcodes_record.Create;
begin
  inherited Create;
end;

  {  TOrders_Task  }
procedure TOrders_Task.Setid_doc(AValue: String);
begin
  Fid_doc:=AValue;
  ModifiedProperty('id_doc');
end;

procedure TOrders_Task.Setdate(AValue: String);
begin
  Fdate:=AValue;
  ModifiedProperty('date');
end;

procedure TOrders_Task.Settype1(AValue: String);
begin
  Ftype1:=AValue;
  ModifiedProperty('type1');
end;

procedure TOrders_Task.Setdate_order(AValue: String);
begin
  Fdate_order:=AValue;
  ModifiedProperty('date_order');
end;

procedure TOrders_Task.Setfc(AValue: String);
begin
  Ffc:=AValue;
  ModifiedProperty('fc');
end;

procedure TOrders_Task.Setid_sclad(AValue: String);
begin
  Fid_sclad:=AValue;
  ModifiedProperty('id_sclad');
end;

procedure TOrders_Task.Setlast_order(AValue: Int64);
begin
  Flast_order:=AValue;
  ModifiedProperty('last_order');
end;

procedure TOrders_Task.Setorders(AValue: String);
begin
  Forders:=AValue;
  ModifiedProperty('orders');
end;

procedure TOrders_Task.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('record1', 'record', [], '', -1, -1);
  P:=RegisterProperty('id_doc', 'id_doc', [], '', -1, -1);
  P:=RegisterProperty('date', 'date', [], '', -1, -1);
  P:=RegisterProperty('type1', 'type', [], '', -1, -1);
  P:=RegisterProperty('date_order', 'date_order', [], '', -1, -1);
  P:=RegisterProperty('fc', 'fc', [], '', -1, -1);
  P:=RegisterProperty('id_sclad', 'id_sclad', [], '', -1, -1);
  P:=RegisterProperty('last_order', 'last_order', [], '', -1, -1);
  P:=RegisterProperty('orders', 'orders', [], '', -1, -1);
end;

procedure TOrders_Task.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Frecord1:=TOrders_Task_recordList.Create;
end;

destructor TOrders_Task.Destroy;
begin
  Frecord1.Free;
  inherited Destroy;
end;

constructor TOrders_Task.Create;
begin
  inherited Create;
end;

  {  TOrders_Task_record  }
procedure TOrders_Task_record.Setid_goods(AValue: String);
begin
  Fid_goods:=AValue;
  ModifiedProperty('id_goods');
end;

procedure TOrders_Task_record.Setid_char(AValue: String);
begin
  Fid_char:=AValue;
  ModifiedProperty('id_char');
end;

procedure TOrders_Task_record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('property1', 'property', [], '', -1, -1);
  P:=RegisterProperty('alco', 'alco', [], '', -1, -1);
  P:=RegisterProperty('marked_codes', 'marked_codes', [], '', -1, -1);
  P:=RegisterProperty('id_goods', 'id_goods', [], '', -1, -1);
  P:=RegisterProperty('id_char', 'id_char', [], '', -1, -1);
end;

procedure TOrders_Task_record.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Fproperty1:=TOrders_Task_record_property.Create;
  Falco:=TOrders_Task_record_alco.Create;
  Fmarked_codes:=TOrders_Task_record_marked_codes.Create;
end;

destructor TOrders_Task_record.Destroy;
begin
  Fproperty1.Free;
  Falco.Free;
  Fmarked_codes.Free;
  inherited Destroy;
end;

constructor TOrders_Task_record.Create;
begin
  inherited Create;
end;

  {  TOrders_Task_record_property  }
procedure TOrders_Task_record_property.Setid_pack(AValue: String);
begin
  Fid_pack:=AValue;
  ModifiedProperty('id_pack');
end;

procedure TOrders_Task_record_property.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('serial', 'serial', [], '', -1, -1);
  P:=RegisterProperty('id_pack', 'id_pack', [], '', -1, -1);
end;

procedure TOrders_Task_record_property.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Fserial:=TOrders_Task_record_property_serial.Create;
end;

destructor TOrders_Task_record_property.Destroy;
begin
  Fserial.Free;
  inherited Destroy;
end;

constructor TOrders_Task_record_property.Create;
begin
  inherited Create;
end;

  {  TOrders_Task_record_property_serial  }
procedure TOrders_Task_record_property_serial.Setquantity(AValue: String);
begin
  Fquantity:=AValue;
  ModifiedProperty('quantity');
end;

procedure TOrders_Task_record_property_serial.Setid_serial(AValue: String);
begin
  Fid_serial:=AValue;
  ModifiedProperty('id_serial');
end;

procedure TOrders_Task_record_property_serial.Setdate(AValue: String);
begin
  Fdate:=AValue;
  ModifiedProperty('date');
end;

procedure TOrders_Task_record_property_serial.Setvalue(AValue: String);
begin
  Fvalue:=AValue;
  ModifiedProperty('value');
end;

procedure TOrders_Task_record_property_serial.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('cells', 'cells', [], '', -1, -1);
  P:=RegisterProperty('quantity', 'quantity', [], '', -1, -1);
  P:=RegisterProperty('id_serial', 'id_serial', [], '', -1, -1);
  P:=RegisterProperty('date', 'date', [], '', -1, -1);
  P:=RegisterProperty('value', 'value', [], '', -1, -1);
end;

procedure TOrders_Task_record_property_serial.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Fcells:=TOrders_Task_record_property_serial_cellsList.Create;
end;

destructor TOrders_Task_record_property_serial.Destroy;
begin
  Fcells.Free;
  inherited Destroy;
end;

constructor TOrders_Task_record_property_serial.Create;
begin
  inherited Create;
end;

  {  TOrders_Task_record_property_serial_cells  }
procedure TOrders_Task_record_property_serial_cells.Setid_cell(AValue: String);
begin
  Fid_cell:=AValue;
  ModifiedProperty('id_cell');
end;

procedure TOrders_Task_record_property_serial_cells.Setcelladdress(AValue: String);
begin
  Fcelladdress:=AValue;
  ModifiedProperty('celladdress');
end;

procedure TOrders_Task_record_property_serial_cells.Setquantity(AValue: String);
begin
  Fquantity:=AValue;
  ModifiedProperty('quantity');
end;

procedure TOrders_Task_record_property_serial_cells.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('id_cell', 'id_cell', [], '', -1, -1);
  P:=RegisterProperty('celladdress', 'celladdress', [], '', -1, -1);
  P:=RegisterProperty('quantity', 'quantity', [], '', -1, -1);
end;

procedure TOrders_Task_record_property_serial_cells.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TOrders_Task_record_property_serial_cells.Destroy;
begin
  inherited Destroy;
end;

constructor TOrders_Task_record_property_serial_cells.Create;
begin
  inherited Create;
end;

  {  TOrders_Task_record_alco  }
procedure TOrders_Task_record_alco.SetPDF417(AValue: String);
begin
  FPDF417:=AValue;
  ModifiedProperty('PDF417');
end;

procedure TOrders_Task_record_alco.SetDATAMATRIX(AValue: String);
begin
  FDATAMATRIX:=AValue;
  ModifiedProperty('DATAMATRIX');
end;

procedure TOrders_Task_record_alco.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('PDF417', 'PDF417', [], '', -1, -1);
  P:=RegisterProperty('DATAMATRIX', 'DATAMATRIX', [], '', -1, -1);
end;

procedure TOrders_Task_record_alco.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TOrders_Task_record_alco.Destroy;
begin
  inherited Destroy;
end;

constructor TOrders_Task_record_alco.Create;
begin
  inherited Create;
end;

  {  TOrders_Task_record_marked_codes  }
procedure TOrders_Task_record_marked_codes.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('token', 'token', [], '', -1, -1);
end;

procedure TOrders_Task_record_marked_codes.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Ftoken:=TOrders_Task_record_marked_codes_tokenList.Create;
end;

destructor TOrders_Task_record_marked_codes.Destroy;
begin
  Ftoken.Free;
  inherited Destroy;
end;

constructor TOrders_Task_record_marked_codes.Create;
begin
  inherited Create;
end;

  {  TOrders_Task_record_marked_codes_token  }
procedure TOrders_Task_record_marked_codes_token.SetGS1_DATAMATRIX(AValue: String);
begin
  FGS1_DATAMATRIX:=AValue;
  ModifiedProperty('GS1_DATAMATRIX');
end;

procedure TOrders_Task_record_marked_codes_token.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('GS1_DATAMATRIX', 'GS1_DATAMATRIX', [xsaRequared], '', -1, -1);
end;

procedure TOrders_Task_record_marked_codes_token.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TOrders_Task_record_marked_codes_token.Destroy;
begin
  inherited Destroy;
end;

constructor TOrders_Task_record_marked_codes_token.Create;
begin
  inherited Create;
end;

end.