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


unit GetData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject, AbstractSerializationObjects;

type

  {  Forward declarations  }
  TDocument = class;
  TDocument_table = class;
  TDocument_table_record = class;
  TDocument_characteristics = class;
  TDocument_characteristics_record = class;
  TDocument_packs = class;
  TDocument_packs_record = class;
  TDocument_serials = class;
  TDocument_serials_record = class;
  TDocument_barcodes = class;
  TDocument_barcodes_record = class;
  TDocument_measures = class;
  TDocument_measures_record = class;
  TDocument_prices = class;
  TDocument_prices_record = class;
  TDocument_vidnomencls = class;
  TDocument_vidnomencls_record = class;
  TDocument_sclads = class;
  TDocument_sclads_record = class;

  {  Generic classes for collections  }
  TDocumentList = specialize GXMLSerializationObjectList<TDocument>;
  TDocument_tableList = specialize GXMLSerializationObjectList<TDocument_table>;
  TDocument_table_recordList = specialize GXMLSerializationObjectList<TDocument_table_record>;
  TDocument_characteristicsList = specialize GXMLSerializationObjectList<TDocument_characteristics>;
  TDocument_characteristics_recordList = specialize GXMLSerializationObjectList<TDocument_characteristics_record>;
  TDocument_packsList = specialize GXMLSerializationObjectList<TDocument_packs>;
  TDocument_packs_recordList = specialize GXMLSerializationObjectList<TDocument_packs_record>;
  TDocument_serialsList = specialize GXMLSerializationObjectList<TDocument_serials>;
  TDocument_serials_recordList = specialize GXMLSerializationObjectList<TDocument_serials_record>;
  TDocument_barcodesList = specialize GXMLSerializationObjectList<TDocument_barcodes>;
  TDocument_barcodes_recordList = specialize GXMLSerializationObjectList<TDocument_barcodes_record>;
  TDocument_measuresList = specialize GXMLSerializationObjectList<TDocument_measures>;
  TDocument_measures_recordList = specialize GXMLSerializationObjectList<TDocument_measures_record>;
  TDocument_pricesList = specialize GXMLSerializationObjectList<TDocument_prices>;
  TDocument_prices_recordList = specialize GXMLSerializationObjectList<TDocument_prices_record>;
  TDocument_vidnomenclsList = specialize GXMLSerializationObjectList<TDocument_vidnomencls>;
  TDocument_vidnomencls_recordList = specialize GXMLSerializationObjectList<TDocument_vidnomencls_record>;
  TDocument_scladsList = specialize GXMLSerializationObjectList<TDocument_sclads>;
  TDocument_sclads_recordList = specialize GXMLSerializationObjectList<TDocument_sclads_record>;

  {  TDocument  }
  TDocument = class(TXmlSerializationObject)
  private
    Ftable:TDocument_table;
    Fcharacteristics:TDocument_characteristics;
    Fpacks:TDocument_packs;
    Fserials:TDocument_serials;
    Fbarcodes:TDocument_barcodes;
    Fmeasures:TDocument_measures;
    Fprices:TDocument_prices;
    Fvidnomencls:TDocument_vidnomencls;
    Fsclads:TDocument_sclads;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //список товаров (номенклатуры)
    property table:TDocument_table read Ftable;
    //справочник характеристик (может быть пустым или отсутствовать, если нет характеристик)
    property characteristics:TDocument_characteristics read Fcharacteristics;
    //справочник упаковок (может быть пустым или отсутствовать, если нет упаковок)
    property packs:TDocument_packs read Fpacks;
    //справочник серий (может быть пустым или отсутствовать, если нет серий)
    property serials:TDocument_serials read Fserials;
    //справочник штрих кодов (может и отсутствовать, в программе предусмотрен режим работы без штрих кодов, но это бессмысленно на ТСД)
    property barcodes:TDocument_barcodes read Fbarcodes;
    //справочник цен (может отсутствовать или быть пустым )
    property measures:TDocument_measures read Fmeasures;
    //справочник цен (может отсутствовать или быть пустым )
    property prices:TDocument_prices read Fprices;
    //виды номенклатуры
    property vidnomencls:TDocument_vidnomencls read Fvidnomencls;
    //склады (если используется адресное хранения, то обязательно должен присутсвовать)
    property sclads:TDocument_sclads read Fsclads;
  end;

  {  TDocument_table  }
  TDocument_table = class(TXmlSerializationObject)
  private
    Frecord1:TDocument_table_recordList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //запись в справочнике
    property record1:TDocument_table_recordList read Frecord1;
  end;

  {  TDocument_table_record  }
  TDocument_table_record = class(TXmlSerializationObject)
  private
    Fid_goods:String;
    Fname:String;
    Fid_measure:String;
    Fart:String;
    Falco:Int64;
    Fid_vidnomencl:String;
    Fid_nabor_pack:String;
    Fimg:String;
    Fbitmap:String;
    procedure Setid_goods( AValue:String);
    procedure Setname( AValue:String);
    procedure Setid_measure( AValue:String);
    procedure Setart( AValue:String);
    procedure Setalco( AValue:Int64);
    procedure Setid_vidnomencl( AValue:String);
    procedure Setid_nabor_pack( AValue:String);
    procedure Setimg( AValue:String);
    procedure Setbitmap( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //УИ товара
    property id_goods:String read Fid_goods write Setid_goods;
    //наименование товара
    property name:String read Fname write Setname;
    //УИ базовой ед. измерения
    property id_measure:String read Fid_measure write Setid_measure;
    //артикул
    property art:String read Fart write Setart;
    //признак алкогольной продукции (значение: 1 или 0)
    property alco:Int64 read Falco write Setalco;
    //УИ вида номенклатуры, ссылка на поле id_owner других справочников с relation=”видыноменклатуры” (т. е. реализуется отношение: один-ко-многим)
    property id_vidnomencl:String read Fid_vidnomencl write Setid_vidnomencl;
    //УИ наборов упаковок, ссылка на поле id_owner блока packs (см. ниже) с relation= “наборупаковок”
    property id_nabor_pack:String read Fid_nabor_pack write Setid_nabor_pack;
    //наименование файла изображения товара
    property img:String read Fimg write Setimg;
    //бинарный блок данных — файл изображения товара в кодировке Base64
    property bitmap:String read Fbitmap write Setbitmap;
  end;

  {  TDocument_characteristics  }
  TDocument_characteristics = class(TXmlSerializationObject)
  private
    Frecord1:TDocument_characteristics_recordList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //запись в справочнике
    property record1:TDocument_characteristics_recordList read Frecord1;
  end;

  {  TDocument_characteristics_record  }
  TDocument_characteristics_record = class(TXmlSerializationObject)
  private
    Fid_owner:String;
    Frelation:String;
    Fname:String;
    Fid_char:String;
    procedure Setid_owner( AValue:String);
    procedure Setrelation( AValue:String);
    procedure Setname( AValue:String);
    procedure Setid_char( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //УИ владельца
    property id_owner:String read Fid_owner write Setid_owner;
    //указывает на объект владельца
    property relation:String read Frelation write Setrelation;
    //характеристика товара
    property name:String read Fname write Setname;
    //УИ характеристики
    property id_char:String read Fid_char write Setid_char;
  end;

  {  TDocument_packs  }
  TDocument_packs = class(TXmlSerializationObject)
  private
    Frecord1:TDocument_packs_recordList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //запись в справочнике
    property record1:TDocument_packs_recordList read Frecord1;
  end;

  {  TDocument_packs_record  }
  TDocument_packs_record = class(TXmlSerializationObject)
  private
    Fid_owner:String;
    Frelation:String;
    Fname:String;
    Fid_pack:String;
    Fkoeff:String;
    procedure Setid_owner( AValue:String);
    procedure Setrelation( AValue:String);
    procedure Setname( AValue:String);
    procedure Setid_pack( AValue:String);
    procedure Setkoeff( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //УИ владельца
    property id_owner:String read Fid_owner write Setid_owner;
    //указывает на объект владельца
    property relation:String read Frelation write Setrelation;
    //наименование упаковки
    property name:String read Fname write Setname;
    //УИ упаковки
    property id_pack:String read Fid_pack write Setid_pack;
    //коэффициент пересчета в базовые единицы измерения
    property koeff:String read Fkoeff write Setkoeff;
  end;

  {  TDocument_serials  }
  TDocument_serials = class(TXmlSerializationObject)
  private
    Frecord1:TDocument_serials_recordList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //запись в справочнике
    property record1:TDocument_serials_recordList read Frecord1;
  end;

  {  TDocument_serials_record  }
  TDocument_serials_record = class(TXmlSerializationObject)
  private
    Fid_owner:String;
    Frelation:String;
    Fname:String;
    Fid_serial:String;
    Fnum:String;
    Fdate:TDateTime;
    procedure Setid_owner( AValue:String);
    procedure Setrelation( AValue:String);
    procedure Setname( AValue:String);
    procedure Setid_serial( AValue:String);
    procedure Setnum( AValue:String);
    procedure Setdate( AValue:TDateTime);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property id_owner:String read Fid_owner write Setid_owner;
    property relation:String read Frelation write Setrelation;
    //наименование серии
    property name:String read Fname write Setname;
    //УИ серии
    property id_serial:String read Fid_serial write Setid_serial;
    //номер серии (последовательность символов, теоретически может быть 255 и более)
    property num:String read Fnum write Setnum;
    //дата окончания срока годности товара (в формате: «dd:mm:yyy»)
    property date:TDateTime read Fdate write Setdate;
  end;

  {  TDocument_barcodes  }
  TDocument_barcodes = class(TXmlSerializationObject)
  private
    Frecord1:TDocument_barcodes_recordList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //запись в справочнике
    property record1:TDocument_barcodes_recordList read Frecord1;
  end;

  {  TDocument_barcodes_record  }
  TDocument_barcodes_record = class(TXmlSerializationObject)
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
    constructor Create;
    destructor Destroy; override;
  published
    //УИ товара
    property id_goods:String read Fid_goods write Setid_goods;
    //УИ характеристики (может отсутствовать или быть пустым )
    property id_char:String read Fid_char write Setid_char;
    //УИ упаковки (может отсутствовать или быть пустым, тогда этот штрих код для базовой ед. товара)
    property id_pack:String read Fid_pack write Setid_pack;
    //строковое значение штрих кода
    property barcode:String read Fbarcode write Setbarcode;
  end;

  {  TDocument_measures  }
  TDocument_measures = class(TXmlSerializationObject)
  private
    Frecord1:TDocument_measures_recordList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //запись в справочнике
    property record1:TDocument_measures_recordList read Frecord1;
  end;

  {  TDocument_measures_record  }
  TDocument_measures_record = class(TXmlSerializationObject)
  private
    Fid_measure:String;
    Fname:String;
    procedure Setid_measure( AValue:String);
    procedure Setname( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //УИ ед. измерения
    property id_measure:String read Fid_measure write Setid_measure;
    //наименование ед. измерения
    property name:String read Fname write Setname;
  end;

  {  TDocument_prices  }
  TDocument_prices = class(TXmlSerializationObject)
  private
    Frecord1:TDocument_prices_recordList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //запись в справочнике
    property record1:TDocument_prices_recordList read Frecord1;
  end;

  {  TDocument_prices_record  }
  TDocument_prices_record = class(TXmlSerializationObject)
  private
    Fid_goods:String;
    Fid_char:String;
    Fid_pack:String;
    Fprice:String;
    Fcurrency:String;
    procedure Setid_goods( AValue:String);
    procedure Setid_char( AValue:String);
    procedure Setid_pack( AValue:String);
    procedure Setprice( AValue:String);
    procedure Setcurrency( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //УИ товара
    property id_goods:String read Fid_goods write Setid_goods;
    //УИ характеристики
    property id_char:String read Fid_char write Setid_char;
    //УИ упаковки
    property id_pack:String read Fid_pack write Setid_pack;
    //числовое представление цены
    property price:String read Fprice write Setprice;
    //валюта
    property currency:String read Fcurrency write Setcurrency;
  end;

  {  TDocument_vidnomencls  }
  TDocument_vidnomencls = class(TXmlSerializationObject)
  private
    Frecord1:TDocument_vidnomencls_recordList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //запись в справочнике
    property record1:TDocument_vidnomencls_recordList read Frecord1;
  end;

  {  TDocument_vidnomencls_record  }
  TDocument_vidnomencls_record = class(TXmlSerializationObject)
  private
    Fid_vidnomencl:String;
    Fname:String;
    Fis_char:Int64;
    Fis_serial:Int64;
    Fis_nomer_serial:Int64;
    Fis_date_serial:Int64;
    procedure Setid_vidnomencl( AValue:String);
    procedure Setname( AValue:String);
    procedure Setis_char( AValue:Int64);
    procedure Setis_serial( AValue:Int64);
    procedure Setis_nomer_serial( AValue:Int64);
    procedure Setis_date_serial( AValue:Int64);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //УИ вида номенклатуры
    property id_vidnomencl:String read Fid_vidnomencl write Setid_vidnomencl;
    //наименование вида номенклатуры
    property name:String read Fname write Setname;
    //есть характеристика (1 — да, 0 — нет, по умолчанию 0)
    property is_char:Int64 read Fis_char write Setis_char;
    //есть серия (1 — да, 0 - нет, по умолчанию 0)
    property is_serial:Int64 read Fis_serial write Setis_serial;
    //серии в виде номера (последовательности символов) (1 — да, 0 - нет, по умолчанию 0)
    property is_nomer_serial:Int64 read Fis_nomer_serial write Setis_nomer_serial;
    //серии в виде срока годности (1 — да, 0 - нет, по умолчанию 0)
    property is_date_serial:Int64 read Fis_date_serial write Setis_date_serial;
  end;

  {  TDocument_sclads  }
  TDocument_sclads = class(TXmlSerializationObject)
  private
    Frecord1:TDocument_sclads_recordList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //запись в справочнике
    property record1:TDocument_sclads_recordList read Frecord1;
  end;

  {  TDocument_sclads_record  }
  TDocument_sclads_record = class(TXmlSerializationObject)
  private
    Fid_sclad:String;
    Fname:String;
    Fis_adress:Int64;
    Fis_order:Int64;
    procedure Setid_sclad( AValue:String);
    procedure Setname( AValue:String);
    procedure Setis_adress( AValue:Int64);
    procedure Setis_order( AValue:Int64);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //УИ склада
    property id_sclad:String read Fid_sclad write Setid_sclad;
    //наименование склада
    property name:String read Fname write Setname;
    //признак использования адресного хранения (1- да, 0 - нет, по умолчанию 0)
    property is_adress:Int64 read Fis_adress write Setis_adress;
    //признак использования ордерной схемы (1- да, 0 — нет, по умолчанию 0)
    property is_order:Int64 read Fis_order write Setis_order;
  end;

implementation

  {  TDocument  }
procedure TDocument.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('table', 'table', [], '', -1, -1);
  P:=RegisterProperty('characteristics', 'characteristics', [], '', -1, -1);
  P:=RegisterProperty('packs', 'packs', [], '', -1, -1);
  P:=RegisterProperty('serials', 'serials', [], '', -1, -1);
  P:=RegisterProperty('barcodes', 'barcodes', [], '', -1, -1);
  P:=RegisterProperty('measures', 'measures', [], '', -1, -1);
  P:=RegisterProperty('prices', 'prices', [], '', -1, -1);
  P:=RegisterProperty('vidnomencls', 'vidnomencls', [], '', -1, -1);
  P:=RegisterProperty('sclads', 'sclads', [], '', -1, -1);
end;

procedure TDocument.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Ftable:=TDocument_table.Create;
  Fcharacteristics:=TDocument_characteristics.Create;
  Fpacks:=TDocument_packs.Create;
  Fserials:=TDocument_serials.Create;
  Fbarcodes:=TDocument_barcodes.Create;
  Fmeasures:=TDocument_measures.Create;
  Fprices:=TDocument_prices.Create;
  Fvidnomencls:=TDocument_vidnomencls.Create;
  Fsclads:=TDocument_sclads.Create;
end;

destructor TDocument.Destroy;
begin
  Ftable.Free;
  Fcharacteristics.Free;
  Fpacks.Free;
  Fserials.Free;
  Fbarcodes.Free;
  Fmeasures.Free;
  Fprices.Free;
  Fvidnomencls.Free;
  Fsclads.Free;
  inherited Destroy;
end;

function TDocument.RootNodeName:string;
begin
  Result:='Document';
end;

constructor TDocument.Create;
begin
  inherited Create;
end;

  {  TDocument_table  }
procedure TDocument_table.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('record1', 'record', [], '', -1, -1);
end;

procedure TDocument_table.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Frecord1:=TDocument_table_recordList.Create;
end;

destructor TDocument_table.Destroy;
begin
  Frecord1.Free;
  inherited Destroy;
end;

constructor TDocument_table.Create;
begin
  inherited Create;
end;

  {  TDocument_table_record  }
procedure TDocument_table_record.Setid_goods(AValue: String);
begin
  Fid_goods:=AValue;
  ModifiedProperty('id_goods');
end;

procedure TDocument_table_record.Setname(AValue: String);
begin
  Fname:=AValue;
  ModifiedProperty('name');
end;

procedure TDocument_table_record.Setid_measure(AValue: String);
begin
  Fid_measure:=AValue;
  ModifiedProperty('id_measure');
end;

procedure TDocument_table_record.Setart(AValue: String);
begin
  Fart:=AValue;
  ModifiedProperty('art');
end;

procedure TDocument_table_record.Setalco(AValue: Int64);
begin
  Falco:=AValue;
  ModifiedProperty('alco');
end;

procedure TDocument_table_record.Setid_vidnomencl(AValue: String);
begin
  Fid_vidnomencl:=AValue;
  ModifiedProperty('id_vidnomencl');
end;

procedure TDocument_table_record.Setid_nabor_pack(AValue: String);
begin
  Fid_nabor_pack:=AValue;
  ModifiedProperty('id_nabor_pack');
end;

procedure TDocument_table_record.Setimg(AValue: String);
begin
  Fimg:=AValue;
  ModifiedProperty('img');
end;

procedure TDocument_table_record.Setbitmap(AValue: String);
begin
  Fbitmap:=AValue;
  ModifiedProperty('bitmap');
end;

procedure TDocument_table_record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('id_goods', 'id_goods', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('name', 'name', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('id_measure', 'id_measure', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('art', 'art', [], '', -1, -1);
  P:=RegisterProperty('alco', 'alco', [], '', -1, -1);
  P:=RegisterProperty('id_vidnomencl', 'id_vidnomencl', [], '', -1, -1);
  P:=RegisterProperty('id_nabor_pack', 'id_nabor_pack', [], '', -1, -1);
  P:=RegisterProperty('img', 'img', [], '', -1, -1);
  P:=RegisterProperty('bitmap', 'bitmap', [], '', -1, -1);
end;

procedure TDocument_table_record.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TDocument_table_record.Destroy;
begin
  inherited Destroy;
end;

constructor TDocument_table_record.Create;
begin
  inherited Create;
end;

  {  TDocument_characteristics  }
procedure TDocument_characteristics.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('record1', 'record', [], '', -1, -1);
end;

procedure TDocument_characteristics.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Frecord1:=TDocument_characteristics_recordList.Create;
end;

destructor TDocument_characteristics.Destroy;
begin
  Frecord1.Free;
  inherited Destroy;
end;

constructor TDocument_characteristics.Create;
begin
  inherited Create;
end;

  {  TDocument_characteristics_record  }
procedure TDocument_characteristics_record.Setid_owner(AValue: String);
begin
  Fid_owner:=AValue;
  ModifiedProperty('id_owner');
end;

procedure TDocument_characteristics_record.Setrelation(AValue: String);
begin
  Frelation:=AValue;
  ModifiedProperty('relation');
end;

procedure TDocument_characteristics_record.Setname(AValue: String);
begin
  Fname:=AValue;
  ModifiedProperty('name');
end;

procedure TDocument_characteristics_record.Setid_char(AValue: String);
begin
  Fid_char:=AValue;
  ModifiedProperty('id_char');
end;

procedure TDocument_characteristics_record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('id_owner', 'id_owner', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('relation', 'relation', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('name', 'name', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('id_char', 'id_char', [xsaRequared], '', -1, -1);
end;

procedure TDocument_characteristics_record.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TDocument_characteristics_record.Destroy;
begin
  inherited Destroy;
end;

constructor TDocument_characteristics_record.Create;
begin
  inherited Create;
end;

  {  TDocument_packs  }
procedure TDocument_packs.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('record1', 'record', [], '', -1, -1);
end;

procedure TDocument_packs.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Frecord1:=TDocument_packs_recordList.Create;
end;

destructor TDocument_packs.Destroy;
begin
  Frecord1.Free;
  inherited Destroy;
end;

constructor TDocument_packs.Create;
begin
  inherited Create;
end;

  {  TDocument_packs_record  }
procedure TDocument_packs_record.Setid_owner(AValue: String);
begin
  Fid_owner:=AValue;
  ModifiedProperty('id_owner');
end;

procedure TDocument_packs_record.Setrelation(AValue: String);
begin
  Frelation:=AValue;
  ModifiedProperty('relation');
end;

procedure TDocument_packs_record.Setname(AValue: String);
begin
  Fname:=AValue;
  ModifiedProperty('name');
end;

procedure TDocument_packs_record.Setid_pack(AValue: String);
begin
  Fid_pack:=AValue;
  ModifiedProperty('id_pack');
end;

procedure TDocument_packs_record.Setkoeff(AValue: String);
begin
  Fkoeff:=AValue;
  ModifiedProperty('koeff');
end;

procedure TDocument_packs_record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('id_owner', 'id_owner', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('relation', 'relation', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('name', 'name', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('id_pack', 'id_pack', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('koeff', 'koeff', [xsaRequared], '', -1, -1);
end;

procedure TDocument_packs_record.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TDocument_packs_record.Destroy;
begin
  inherited Destroy;
end;

constructor TDocument_packs_record.Create;
begin
  inherited Create;
end;

  {  TDocument_serials  }
procedure TDocument_serials.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('record1', 'record', [], '', -1, -1);
end;

procedure TDocument_serials.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Frecord1:=TDocument_serials_recordList.Create;
end;

destructor TDocument_serials.Destroy;
begin
  Frecord1.Free;
  inherited Destroy;
end;

constructor TDocument_serials.Create;
begin
  inherited Create;
end;

  {  TDocument_serials_record  }
procedure TDocument_serials_record.Setid_owner(AValue: String);
begin
  Fid_owner:=AValue;
  ModifiedProperty('id_owner');
end;

procedure TDocument_serials_record.Setrelation(AValue: String);
begin
  Frelation:=AValue;
  ModifiedProperty('relation');
end;

procedure TDocument_serials_record.Setname(AValue: String);
begin
  Fname:=AValue;
  ModifiedProperty('name');
end;

procedure TDocument_serials_record.Setid_serial(AValue: String);
begin
  Fid_serial:=AValue;
  ModifiedProperty('id_serial');
end;

procedure TDocument_serials_record.Setnum(AValue: String);
begin
  Fnum:=AValue;
  ModifiedProperty('num');
end;

procedure TDocument_serials_record.Setdate(AValue: TDateTime);
begin
  Fdate:=AValue;
  ModifiedProperty('date');
end;

procedure TDocument_serials_record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('id_owner', 'id_owner', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('relation', 'relation', [], '', -1, -1);
  P:=RegisterProperty('name', 'name', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('id_serial', 'id_serial', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('num', 'num', [], '', -1, -1);
  P:=RegisterProperty('date', 'date', [], '', -1, -1);
end;

procedure TDocument_serials_record.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TDocument_serials_record.Destroy;
begin
  inherited Destroy;
end;

constructor TDocument_serials_record.Create;
begin
  inherited Create;
end;

  {  TDocument_barcodes  }
procedure TDocument_barcodes.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('record1', 'record', [], '', -1, -1);
end;

procedure TDocument_barcodes.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Frecord1:=TDocument_barcodes_recordList.Create;
end;

destructor TDocument_barcodes.Destroy;
begin
  Frecord1.Free;
  inherited Destroy;
end;

constructor TDocument_barcodes.Create;
begin
  inherited Create;
end;

  {  TDocument_barcodes_record  }
procedure TDocument_barcodes_record.Setid_goods(AValue: String);
begin
  Fid_goods:=AValue;
  ModifiedProperty('id_goods');
end;

procedure TDocument_barcodes_record.Setid_char(AValue: String);
begin
  Fid_char:=AValue;
  ModifiedProperty('id_char');
end;

procedure TDocument_barcodes_record.Setid_pack(AValue: String);
begin
  Fid_pack:=AValue;
  ModifiedProperty('id_pack');
end;

procedure TDocument_barcodes_record.Setbarcode(AValue: String);
begin
  Fbarcode:=AValue;
  ModifiedProperty('barcode');
end;

procedure TDocument_barcodes_record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('id_goods', 'id_goods', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('id_char', 'id_char', [], '', -1, -1);
  P:=RegisterProperty('id_pack', 'id_pack', [], '', -1, -1);
  P:=RegisterProperty('barcode', 'barcode', [xsaRequared], '', -1, -1);
end;

procedure TDocument_barcodes_record.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TDocument_barcodes_record.Destroy;
begin
  inherited Destroy;
end;

constructor TDocument_barcodes_record.Create;
begin
  inherited Create;
end;

  {  TDocument_measures  }
procedure TDocument_measures.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('record1', 'record', [], '', -1, -1);
end;

procedure TDocument_measures.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Frecord1:=TDocument_measures_recordList.Create;
end;

destructor TDocument_measures.Destroy;
begin
  Frecord1.Free;
  inherited Destroy;
end;

constructor TDocument_measures.Create;
begin
  inherited Create;
end;

  {  TDocument_measures_record  }
procedure TDocument_measures_record.Setid_measure(AValue: String);
begin
  Fid_measure:=AValue;
  ModifiedProperty('id_measure');
end;

procedure TDocument_measures_record.Setname(AValue: String);
begin
  Fname:=AValue;
  ModifiedProperty('name');
end;

procedure TDocument_measures_record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('id_measure', 'id_measure', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('name', 'name', [xsaRequared], '', -1, -1);
end;

procedure TDocument_measures_record.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TDocument_measures_record.Destroy;
begin
  inherited Destroy;
end;

constructor TDocument_measures_record.Create;
begin
  inherited Create;
end;

  {  TDocument_prices  }
procedure TDocument_prices.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('record1', 'record', [], '', -1, -1);
end;

procedure TDocument_prices.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Frecord1:=TDocument_prices_recordList.Create;
end;

destructor TDocument_prices.Destroy;
begin
  Frecord1.Free;
  inherited Destroy;
end;

constructor TDocument_prices.Create;
begin
  inherited Create;
end;

  {  TDocument_prices_record  }
procedure TDocument_prices_record.Setid_goods(AValue: String);
begin
  Fid_goods:=AValue;
  ModifiedProperty('id_goods');
end;

procedure TDocument_prices_record.Setid_char(AValue: String);
begin
  Fid_char:=AValue;
  ModifiedProperty('id_char');
end;

procedure TDocument_prices_record.Setid_pack(AValue: String);
begin
  Fid_pack:=AValue;
  ModifiedProperty('id_pack');
end;

procedure TDocument_prices_record.Setprice(AValue: String);
begin
  Fprice:=AValue;
  ModifiedProperty('price');
end;

procedure TDocument_prices_record.Setcurrency(AValue: String);
begin
  Fcurrency:=AValue;
  ModifiedProperty('currency');
end;

procedure TDocument_prices_record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('id_goods', 'id_goods', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('id_char', 'id_char', [], '', -1, -1);
  P:=RegisterProperty('id_pack', 'id_pack', [], '', -1, -1);
  P:=RegisterProperty('price', 'price', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('currency', 'currency', [xsaRequared], '', -1, -1);
end;

procedure TDocument_prices_record.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TDocument_prices_record.Destroy;
begin
  inherited Destroy;
end;

constructor TDocument_prices_record.Create;
begin
  inherited Create;
end;

  {  TDocument_vidnomencls  }
procedure TDocument_vidnomencls.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('record1', 'record', [], '', -1, -1);
end;

procedure TDocument_vidnomencls.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Frecord1:=TDocument_vidnomencls_recordList.Create;
end;

destructor TDocument_vidnomencls.Destroy;
begin
  Frecord1.Free;
  inherited Destroy;
end;

constructor TDocument_vidnomencls.Create;
begin
  inherited Create;
end;

  {  TDocument_vidnomencls_record  }
procedure TDocument_vidnomencls_record.Setid_vidnomencl(AValue: String);
begin
  Fid_vidnomencl:=AValue;
  ModifiedProperty('id_vidnomencl');
end;

procedure TDocument_vidnomencls_record.Setname(AValue: String);
begin
  Fname:=AValue;
  ModifiedProperty('name');
end;

procedure TDocument_vidnomencls_record.Setis_char(AValue: Int64);
begin
  Fis_char:=AValue;
  ModifiedProperty('is_char');
end;

procedure TDocument_vidnomencls_record.Setis_serial(AValue: Int64);
begin
  Fis_serial:=AValue;
  ModifiedProperty('is_serial');
end;

procedure TDocument_vidnomencls_record.Setis_nomer_serial(AValue: Int64);
begin
  Fis_nomer_serial:=AValue;
  ModifiedProperty('is_nomer_serial');
end;

procedure TDocument_vidnomencls_record.Setis_date_serial(AValue: Int64);
begin
  Fis_date_serial:=AValue;
  ModifiedProperty('is_date_serial');
end;

procedure TDocument_vidnomencls_record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('id_vidnomencl', 'id_vidnomencl', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('name', 'name', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('is_char', 'is_char', [], '', -1, -1);
  P:=RegisterProperty('is_serial', 'is_serial', [], '', -1, -1);
  P:=RegisterProperty('is_nomer_serial', 'is_nomer_serial', [], '', -1, -1);
  P:=RegisterProperty('is_date_serial', 'is_date_serial', [], '', -1, -1);
end;

procedure TDocument_vidnomencls_record.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TDocument_vidnomencls_record.Destroy;
begin
  inherited Destroy;
end;

constructor TDocument_vidnomencls_record.Create;
begin
  inherited Create;
end;

  {  TDocument_sclads  }
procedure TDocument_sclads.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('record1', 'record', [], '', -1, -1);
end;

procedure TDocument_sclads.InternalInitChilds;
begin
  inherited InternalInitChilds;
  Frecord1:=TDocument_sclads_recordList.Create;
end;

destructor TDocument_sclads.Destroy;
begin
  Frecord1.Free;
  inherited Destroy;
end;

constructor TDocument_sclads.Create;
begin
  inherited Create;
end;

  {  TDocument_sclads_record  }
procedure TDocument_sclads_record.Setid_sclad(AValue: String);
begin
  Fid_sclad:=AValue;
  ModifiedProperty('id_sclad');
end;

procedure TDocument_sclads_record.Setname(AValue: String);
begin
  Fname:=AValue;
  ModifiedProperty('name');
end;

procedure TDocument_sclads_record.Setis_adress(AValue: Int64);
begin
  Fis_adress:=AValue;
  ModifiedProperty('is_adress');
end;

procedure TDocument_sclads_record.Setis_order(AValue: Int64);
begin
  Fis_order:=AValue;
  ModifiedProperty('is_order');
end;

procedure TDocument_sclads_record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('id_sclad', 'id_sclad', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('name', 'name', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('is_adress', 'is_adress', [], '', -1, -1);
  P:=RegisterProperty('is_order', 'is_order', [], '', -1, -1);
end;

procedure TDocument_sclads_record.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TDocument_sclads_record.Destroy;
begin
  inherited Destroy;
end;

constructor TDocument_sclads_record.Create;
begin
  inherited Create;
end;

end.