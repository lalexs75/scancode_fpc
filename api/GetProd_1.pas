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


unit GetProd_1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject, AbstractSerializationObjects;

type

  {  Forward declarations  }
  TTable = class;
  TTable_Record = class;

  {  Generic classes for collections  }
  TTableList = specialize GXMLSerializationObjectList<TTable>;
  TTable_RecordList = specialize GXMLSerializationObjectList<TTable_Record>;

  {  TTable  }
  TTable = class(TXmlSerializationObject)
  private
    FRecord1:TTable_RecordList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //запрос остатков товара по складу
    property Record1:TTable_RecordList read FRecord1;
  end;

  {  TTable_Record  }
  TTable_Record = class(TXmlSerializationObject)
  private
    Fid_goods:String;
    Fid_sklad:String;
    Fid_char:String;
    procedure Setid_goods( AValue:String);
    procedure Setid_sklad( AValue:String);
    procedure Setid_char( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //УИ товара
    property id_goods:String read Fid_goods write Setid_goods;
    //УИ склада (может быть пустым, тогда по всем складам)
    property id_sklad:String read Fid_sklad write Setid_sklad;
    //УИ характеристики товара (может быть пустым, если нет характеристики)
    property id_char:String read Fid_char write Setid_char;
  end;

implementation

  {  TTable  }
procedure TTable.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('Record1', 'Record', [], '', -1, -1);
end;

procedure TTable.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FRecord1:=TTable_RecordList.Create;
end;

destructor TTable.Destroy;
begin
  FRecord1.Free;
  inherited Destroy;
end;

function TTable.RootNodeName:string;
begin
  Result:='Table';
end;

constructor TTable.Create;
begin
  inherited Create;
end;

  {  TTable_Record  }
procedure TTable_Record.Setid_goods(AValue: String);
begin
  Fid_goods:=AValue;
  ModifiedProperty('id_goods');
end;

procedure TTable_Record.Setid_sklad(AValue: String);
begin
  Fid_sklad:=AValue;
  ModifiedProperty('id_sklad');
end;

procedure TTable_Record.Setid_char(AValue: String);
begin
  Fid_char:=AValue;
  ModifiedProperty('id_char');
end;

procedure TTable_Record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('id_goods', 'id_goods', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('id_sklad', 'id_sklad', [], '', -1, -1);
  P:=RegisterProperty('id_char', 'id_char', [], '', -1, -1);
end;

procedure TTable_Record.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TTable_Record.Destroy;
begin
  inherited Destroy;
end;

constructor TTable_Record.Create;
begin
  inherited Create;
end;

end.