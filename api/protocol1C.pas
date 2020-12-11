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


unit protocol1C;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject, AbstractSerializationObjects;

type

  {  Forward declarations  }
  Tprotocol1C = class;
  Tprotocol1C_fileNameTSD = class;

  {  Generic classes for collections  }
  Tprotocol1CList = specialize GXMLSerializationObjectList<Tprotocol1C>;
  Tprotocol1C_fileNameTSDList = specialize GXMLSerializationObjectList<Tprotocol1C_fileNameTSD>;

  {  Tprotocol1C  }
  Tprotocol1C = class(TXmlSerializationObject)
  private
    FfileNameTSD:Tprotocol1C_fileNameTSDList;
    Fconfirm:String;
    FdocType:String;
    FfileName:String;
    FpackgeNumber:String;
    Fserial:String;
    FuserID:String;
    FuserIP:String;
    Fversion:String;
    procedure Setconfirm( AValue:String);
    procedure SetdocType( AValue:String);
    procedure SetfileName( AValue:String);
    procedure SetpackgeNumber( AValue:String);
    procedure Setserial( AValue:String);
    procedure SetuserID( AValue:String);
    procedure SetuserIP( AValue:String);
    procedure Setversion( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //Протокол обмена в формате 1С
    property fileNameTSD:Tprotocol1C_fileNameTSDList read FfileNameTSD;
    //Статус подтверждения ордера
    property confirm:String read Fconfirm write Setconfirm;
    //Тип документа
    property docType:String read FdocType write SetdocType;
    //Имя файла
    property fileName:String read FfileName write SetfileName;
    //Номер посылки
    property packgeNumber:String read FpackgeNumber write SetpackgeNumber;
    //Серийный номер ТСД
    property serial:String read Fserial write Setserial;
    //Идентификатор
    property userID:String read FuserID write SetuserID;
    //IP адрес терминала
    property userIP:String read FuserIP write SetuserIP;
    //Версия протокола
    property version:String read Fversion write Setversion;
  end;

  {  Tprotocol1C_fileNameTSD  }
  Tprotocol1C_fileNameTSD = class(TXmlSerializationObject)
  private
    FfileXML:String;
    FstringXML:String;
    procedure SetfileXML( AValue:String);
    procedure SetstringXML( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //Данные, отправляемые в ТСД
    property fileXML:String read FfileXML write SetfileXML;
    //Данные, отправляемые в ТСД
    property stringXML:String read FstringXML write SetstringXML;
  end;

implementation

  {  Tprotocol1C  }
procedure Tprotocol1C.Setconfirm(AValue: String);
begin
  Fconfirm:=AValue;
  ModifiedProperty('confirm');
end;

procedure Tprotocol1C.SetdocType(AValue: String);
begin
  FdocType:=AValue;
  ModifiedProperty('docType');
end;

procedure Tprotocol1C.SetfileName(AValue: String);
begin
  FfileName:=AValue;
  ModifiedProperty('fileName');
end;

procedure Tprotocol1C.SetpackgeNumber(AValue: String);
begin
  FpackgeNumber:=AValue;
  ModifiedProperty('packgeNumber');
end;

procedure Tprotocol1C.Setserial(AValue: String);
begin
  Fserial:=AValue;
  ModifiedProperty('serial');
end;

procedure Tprotocol1C.SetuserID(AValue: String);
begin
  FuserID:=AValue;
  ModifiedProperty('userID');
end;

procedure Tprotocol1C.SetuserIP(AValue: String);
begin
  FuserIP:=AValue;
  ModifiedProperty('userIP');
end;

procedure Tprotocol1C.Setversion(AValue: String);
begin
  Fversion:=AValue;
  ModifiedProperty('version');
end;

procedure Tprotocol1C.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('fileNameTSD', 'fileNameTSD', [], '', -1, -1);
  P:=RegisterProperty('confirm', 'confirm', [], '', -1, -1);
  P:=RegisterProperty('docType', 'docType', [], '', -1, -1);
  P:=RegisterProperty('fileName', 'fileName', [], '', -1, -1);
  P:=RegisterProperty('packgeNumber', 'packgeNumber', [], '', -1, -1);
  P:=RegisterProperty('serial', 'serial', [], '', -1, -1);
  P:=RegisterProperty('userID', 'userID', [], '', -1, -1);
  P:=RegisterProperty('userIP', 'userIP', [], '', -1, -1);
  P:=RegisterProperty('version', 'version', [], '', -1, -1);
end;

procedure Tprotocol1C.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FfileNameTSD:=Tprotocol1C_fileNameTSDList.Create;
end;

destructor Tprotocol1C.Destroy;
begin
  FfileNameTSD.Free;
  inherited Destroy;
end;

function Tprotocol1C.RootNodeName:string;
begin
  Result:='protocol1C';
end;

constructor Tprotocol1C.Create;
begin
  inherited Create;
end;

  {  Tprotocol1C_fileNameTSD  }
procedure Tprotocol1C_fileNameTSD.SetfileXML(AValue: String);
begin
  FfileXML:=AValue;
  ModifiedProperty('fileXML');
end;

procedure Tprotocol1C_fileNameTSD.SetstringXML(AValue: String);
begin
  FstringXML:=AValue;
  ModifiedProperty('stringXML');
end;

procedure Tprotocol1C_fileNameTSD.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('fileXML', 'fileXML', [], '', -1, -1);
  P:=RegisterProperty('stringXML', 'stringXML', [], '', -1, -1);
end;

procedure Tprotocol1C_fileNameTSD.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor Tprotocol1C_fileNameTSD.Destroy;
begin
  inherited Destroy;
end;

constructor Tprotocol1C_fileNameTSD.Create;
begin
  inherited Create;
end;

end.