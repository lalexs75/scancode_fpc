{ interface library for FPC and Lazarus
  Copyright (C) 2019-2020 Lagunov Aleksey alexs75@yandex.ru

  Генерация xml файлов в формате обеман данными для СКАНКОД.Мобильный Терминал (SCANCODE.MobileTerminal)

  Структуры данных базируются на основании:

                   Описание структуры XML файлов
                        обмена для программы
                    СКАНКОД.Мобильный Терминал
                           версия 1.2.25
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


unit confirm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject, AbstractSerializationObjects;

type

  {  Forward declarations  }
  TConfirmation = class;
  TVerify = class;

  {  Generic classes for collections  }
  TConfirmationList = specialize GXMLSerializationObjectList<TConfirmation>;
  TVerifyList = specialize GXMLSerializationObjectList<TVerify>;

  {  TConfirmation  }
  TConfirmation = class(TXmlSerializationObject)
  private
    FVerify:TVerify;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Verify:TVerify read FVerify;
  end;

  {  TVerify  }
  TVerify = class(TXmlSerializationObject)
  private
    FBlock:Int64;
    procedure SetBlock( AValue:Int64);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Block:Int64 read FBlock write SetBlock;
  end;

implementation

  {  TConfirmation  }
procedure TConfirmation.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('Verify', 'Verify', [], '', -1, -1);
end;

procedure TConfirmation.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FVerify:=TVerify.Create;
end;

destructor TConfirmation.Destroy;
begin
  FVerify.Free;
  inherited Destroy;
end;

function TConfirmation.RootNodeName:string;
begin
  Result:='Confirmation';
end;

constructor TConfirmation.Create;
begin
  inherited Create;
end;

  {  TVerify  }
procedure TVerify.SetBlock(AValue: Int64);
begin
  FBlock:=AValue;
  ModifiedProperty('Block');
end;

procedure TVerify.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('Block', 'Block', [xsaRequared], '', -1, -1);
end;

procedure TVerify.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TVerify.Destroy;
begin
  inherited Destroy;
end;

function TVerify.RootNodeName:string;
begin
  Result:='Verify';
end;

constructor TVerify.Create;
begin
  inherited Create;
end;

end.