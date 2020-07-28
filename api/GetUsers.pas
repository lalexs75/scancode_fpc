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


unit GetUsers;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject, AbstractSerializationObjects;

type
  TString32 = String;
type

  {  Forward declarations  }
  TInformation = class;
  TInformation_Rights = class;
  TInformation_Rights_Record = class;
  TInformation_Login = class;
  TInformation_Login_Record = class;

  {  Generic classes for collections  }
  TInformationList = specialize GXMLSerializationObjectList<TInformation>;
  TInformation_RightsList = specialize GXMLSerializationObjectList<TInformation_Rights>;
  TInformation_Rights_RecordList = specialize GXMLSerializationObjectList<TInformation_Rights_Record>;
  TInformation_LoginList = specialize GXMLSerializationObjectList<TInformation_Login>;
  TInformation_Login_RecordList = specialize GXMLSerializationObjectList<TInformation_Login_Record>;

  {  TInformation  }
  TInformation = class(TXmlSerializationObject)
  private
    FRights:TInformation_Rights;
    FLogin:TInformation_Login;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //Описание набора доступных прав пользователя
    property Rights:TInformation_Rights read FRights;
    //Учетные данные пользователей (список)
    property Login:TInformation_Login read FLogin;
  end;

  {  TInformation_Rights  }
  TInformation_Rights = class(TXmlSerializationObject)
  private
    FRecord1:TInformation_Rights_RecordList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Record1:TInformation_Rights_RecordList read FRecord1;
  end;

  {  TInformation_Rights_Record  }
  TInformation_Rights_Record = class(TXmlSerializationObject)
  private
    FName:String;
    FId:Int64;
    FgroupId:Int64;
    procedure SetName( AValue:String);
    procedure SetId( AValue:Int64);
    procedure SetgroupId( AValue:Int64);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //Псевдоним типа документа
    property Name:String read FName write SetName;
    //Код типа документа внутри группы
    property Id:Int64 read FId write SetId;
    //Код группы документов, с которыми пользователь может работать. Обычно совпадает с первой цифрой (символом) значения атрибута Id.
    property groupId:Int64 read FgroupId write SetgroupId;
  end;

  {  TInformation_Login  }
  TInformation_Login = class(TXmlSerializationObject)
  private
    FRecord1:TInformation_Login_RecordList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Record1:TInformation_Login_RecordList read FRecord1;
  end;

  {  TInformation_Login_Record  }
  TInformation_Login_Record = class(TXmlSerializationObject)
  private
    FLogin:String;
    FId:TString32;
    FPass:String;
    FRights:String;
    Fcreateprod:String;
    Faddprod:String;
    Fcreate_free_collect:String;
    procedure SetLogin( AValue:String);
    procedure SetId( AValue:TString32);
    procedure SetPass( AValue:String);
    procedure SetRights( AValue:String);
    procedure Setcreateprod( AValue:String);
    procedure Setaddprod( AValue:String);
    procedure Setcreate_free_collect( AValue:String);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    //Строковой идентификатор пользователя (имя)
    property Login:String read FLogin write SetLogin;
    //УИ пользователя во внешней БД. используется в заголовке пакетов данных при обмене с ТУП (не более 32 символов).
    property Id:TString32 read FId write SetId;
    //пароль пользователя в кодировке Base64.
    //Cостоит из 2х частей, разделенных запятой:
    //* контрольная сумма SHA1 пароля, закодированная в Base64
    //* контрольная сумма SHA1 пароля В ВЕРХНЕМ РЕГИСТРЕ,
    //закодированная в Base64
    //ПРИМЕР:
    //"qUqP5cyxm6YcTAhz05Hph5gvu9M=,mEgW/TKWIoduFJB2NCZObzMun7M=
    property Pass:String read FPass write SetPass;
    //список кодов групп документов через разделитель, с которымиможет работать пользователь, т. е. документы только этих групп и их подгрупп пользователь увидит в ТСД.
    //При отсутствии пользователю будет недоступен интерфейс главного окна программы.
    property Rights:String read FRights write SetRights;
    //список кодов групп документов, в которых пользователь может создавать товар
    property createprod:String read Fcreateprod write Setcreateprod;
    //список кодов групп документов, в которые пользователь может добавлять товары из локальной или удаленной БД
    property addprod:String read Faddprod write Setaddprod;
    //список кодов групп документов, для которых пользователь может создавать документы «Свободный набор»
    property create_free_collect:String read Fcreate_free_collect write Setcreate_free_collect;
  end;

implementation

  {  TInformation  }
procedure TInformation.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('Rights', 'Rights', [], '', -1, -1);
  P:=RegisterProperty('Login', 'Login', [], '', -1, -1);
end;

procedure TInformation.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FRights:=TInformation_Rights.Create;
  FLogin:=TInformation_Login.Create;
end;

destructor TInformation.Destroy;
begin
  FRights.Free;
  FLogin.Free;
  inherited Destroy;
end;

function TInformation.RootNodeName:string;
begin
  Result:='Information';
end;

constructor TInformation.Create;
begin
  inherited Create;
end;

  {  TInformation_Rights  }
procedure TInformation_Rights.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('Record1', 'Record', [], '', -1, -1);
end;

procedure TInformation_Rights.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FRecord1:=TInformation_Rights_RecordList.Create;
end;

destructor TInformation_Rights.Destroy;
begin
  FRecord1.Free;
  inherited Destroy;
end;

constructor TInformation_Rights.Create;
begin
  inherited Create;
end;

  {  TInformation_Rights_Record  }
procedure TInformation_Rights_Record.SetName(AValue: String);
begin
  FName:=AValue;
  ModifiedProperty('Name');
end;

procedure TInformation_Rights_Record.SetId(AValue: Int64);
begin
  FId:=AValue;
  ModifiedProperty('Id');
end;

procedure TInformation_Rights_Record.SetgroupId(AValue: Int64);
begin
  FgroupId:=AValue;
  ModifiedProperty('groupId');
end;

procedure TInformation_Rights_Record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('Name', 'Name', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('Id', 'Id', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('groupId', 'groupId', [xsaRequared], '', -1, -1);
end;

procedure TInformation_Rights_Record.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TInformation_Rights_Record.Destroy;
begin
  inherited Destroy;
end;

constructor TInformation_Rights_Record.Create;
begin
  inherited Create;
end;

  {  TInformation_Login  }
procedure TInformation_Login.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('Record1', 'Record', [], '', -1, -1);
end;

procedure TInformation_Login.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FRecord1:=TInformation_Login_RecordList.Create;
end;

destructor TInformation_Login.Destroy;
begin
  FRecord1.Free;
  inherited Destroy;
end;

constructor TInformation_Login.Create;
begin
  inherited Create;
end;

  {  TInformation_Login_Record  }
procedure TInformation_Login_Record.SetLogin(AValue: String);
begin
  FLogin:=AValue;
  ModifiedProperty('Login');
end;

procedure TInformation_Login_Record.SetId(AValue: TString32);
begin
  CheckStrMinSize('Id', AValue);
  CheckStrMaxSize('Id', AValue);
  FId:=AValue;
  ModifiedProperty('Id');
end;

procedure TInformation_Login_Record.SetPass(AValue: String);
begin
  FPass:=AValue;
  ModifiedProperty('Pass');
end;

procedure TInformation_Login_Record.SetRights(AValue: String);
begin
  FRights:=AValue;
  ModifiedProperty('Rights');
end;

procedure TInformation_Login_Record.Setcreateprod(AValue: String);
begin
  Fcreateprod:=AValue;
  ModifiedProperty('createprod');
end;

procedure TInformation_Login_Record.Setaddprod(AValue: String);
begin
  Faddprod:=AValue;
  ModifiedProperty('addprod');
end;

procedure TInformation_Login_Record.Setcreate_free_collect(AValue: String);
begin
  Fcreate_free_collect:=AValue;
  ModifiedProperty('create_free_collect');
end;

procedure TInformation_Login_Record.InternalRegisterPropertys;
var
  P: TPropertyDef;
begin
  inherited InternalRegisterPropertys;
  P:=RegisterProperty('Login', 'Login', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('Id', 'Id', [xsaRequared], '', 1, 32);
  P:=RegisterProperty('Pass', 'Pass', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('Rights', 'Rights', [xsaRequared], '', -1, -1);
  P:=RegisterProperty('createprod', 'createprod', [], '', -1, -1);
  P:=RegisterProperty('addprod', 'addprod', [], '', -1, -1);
  P:=RegisterProperty('create_free_collect', 'create_free_collect', [], '', -1, -1);
end;

procedure TInformation_Login_Record.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TInformation_Login_Record.Destroy;
begin
  inherited Destroy;
end;

constructor TInformation_Login_Record.Create;
begin
  inherited Create;
end;

end.