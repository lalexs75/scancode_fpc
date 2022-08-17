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


unit GetProd_0;

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
    constructor Create; override;
    destructor Destroy; override;
  published
    //Информация о штрихкоде
    property Record1:TTable_RecordList read FRecord1;
  end;

  {  TTable_Record  }
  TTable_Record = class(TXmlSerializationObject)
  private
    Fbarcode:String;
    procedure Setbarcode( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    //Штрихкод товара
    property barcode:String read Fbarcode write Setbarcode;
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
procedure TTable_Record.Setbarcode(AValue: String);
begin
  Fbarcode:=AValue;
  ModifiedProperty('barcode');
end;

procedure TTable_Record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('barcode', 'barcode', [], '', -1, -1);
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