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


unit tsd_error_msg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject, AbstractSerializationObjects;

type

  {  Forward declarations  }
  Terror = class;

  {  Generic classes for collections  }
  TerrorList = specialize GXMLSerializationObjectList<Terror>;

  {  Terror  }
  Terror = class(TXmlSerializationObject)
  private
    Fevent:String;
    Ftype1:String;
    Fdescription:String;
    procedure Setevent( AValue:String);
    procedure Settype1( AValue:String);
    procedure Setdescription( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    //событие при, котором произошла проблема (не используется)
    property event:String read Fevent write Setevent;
    //тип ошибки (не используется)
    property type1:String read Ftype1 write Settype1;
    //текстовое описание ошибки
    property description:String read Fdescription write Setdescription;
  end;

implementation

  {  Terror  }
procedure Terror.Setevent(AValue: String);
begin
  Fevent:=AValue;
  ModifiedProperty('event');
end;

procedure Terror.Settype1(AValue: String);
begin
  Ftype1:=AValue;
  ModifiedProperty('type1');
end;

procedure Terror.Setdescription(AValue: String);
begin
  Fdescription:=AValue;
  ModifiedProperty('description');
end;

procedure Terror.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('event', 'event', [], '', -1, -1);
  P:=RegisterProperty('type1', 'type', [], '', -1, -1);
  P:=RegisterProperty('description', 'description', [], '', -1, -1);
end;

procedure Terror.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor Terror.Destroy;
begin
  inherited Destroy;
end;

function Terror.RootNodeName:string;
begin
  Result:='error';
end;

constructor Terror.Create;
begin
  inherited Create;
end;

end.