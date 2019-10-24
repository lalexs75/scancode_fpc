{ interface library for FPC and Lazarus
  Copyright (C) 2019 Lagunov Aleksey alexs75@yandex.ru

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

unit scancode_user_api;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject;

type

  { TUserRight }

  TUserRight = class(TXmlSerializationObject)
  private
    FGroupID: string;
    FID: string;
    FName: string;
    procedure SetGroupID(AValue: string);
    procedure SetID(AValue: string);
    procedure SetName(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property Name:string read FName write SetName;
    property ID:string read FID write SetID;
    property GroupID:string read FGroupID write SetGroupID;
  end;

  { TUserRightsList }

  TUserRightsList = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TUserRight; inline;
  public
    constructor Create;
    function CreateChild:TUserRight;
    property Item[AIndex:Integer]:TUserRight read GetItem; default;
  end;

  TUserRights = class(TXmlSerializationObject)
  private
    FRecords: TUserRightsList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property Records:TUserRightsList read FRecords;
  end;

  { TUserLogin }

  TUserLogin = class(TXmlSerializationObject)
  private
    FAddProd: string;
    FCreateFreeCollect: string;
    FCreateProd: string;
    FId: string;
    FLogin: string;
    FPass: string;
    FRights: string;
    function GetPasswordDecoded: string;
    procedure SetAddProd(AValue: string);
    procedure SetCreateFreeCollect(AValue: string);
    procedure SetCreateProd(AValue: string);
    procedure SetId(AValue: string);
    procedure SetLogin(AValue: string);
    procedure SetPass(AValue: string);
    procedure SetPasswordDecoded(AValue: string);
    procedure SetRights(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
    property PasswordDecoded:string read GetPasswordDecoded write SetPasswordDecoded;
  published
    property Login:string read FLogin write SetLogin;
    property Id:string read FId write SetId;
    property Pass:string read FPass write SetPass;
    property Rights:string read FRights write SetRights;
    property CreateProd:string read FCreateProd write SetCreateProd;
    property AddProd:string read FAddProd write SetAddProd;
    property CreateFreeCollect:string read FCreateFreeCollect write SetCreateFreeCollect;
  end;

  { TUserLoginList }

  TUserLoginList = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TUserLogin; inline;
  public
    constructor Create;
    function CreateChild:TUserLogin;
    property Item[AIndex:Integer]:TUserLogin read GetItem; default;
  end;

  { TUserLogins }

  TUserLogins = class(TXmlSerializationObject)
  private
    FRecords: TUserLoginList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property Records:TUserLoginList read FRecords;
  end;

  { TUserInformation }

  TUserInformation = class(TXmlSerializationObject)
  private
    FLogins: TUserLogins;
    FRights: TUserRights;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    destructor Destroy; override;
  published
    property Rights:TUserRights read FRights;
    property Logins:TUserLogins read FLogins;
  end;

implementation
uses base64;

{ TUserRights }

procedure TUserRights.InternalRegisterPropertys;
begin
  RegisterProperty('Records', 'Record', 'О', 'Строки', -1, -1);
end;

procedure TUserRights.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FRecords:=TUserRightsList.Create;
end;

destructor TUserRights.Destroy;
begin
  FreeAndNil(FRecords);
  inherited Destroy;
end;

{ TUserLogins }

procedure TUserLogins.InternalRegisterPropertys;
begin
  RegisterProperty('Records', 'Record', 'О', 'Строки', -1, -1);
end;

procedure TUserLogins.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FRecords:=TUserLoginList.Create;
end;

destructor TUserLogins.Destroy;
begin
  FreeAndNil(FRecords);
  inherited Destroy;
end;

{ TUserLoginList }

function TUserLoginList.GetItem(AIndex: Integer): TUserLogin;
begin
  Result:=TUserLogin(InternalGetItem(AIndex));
end;

constructor TUserLoginList.Create;
begin
  inherited Create(TUserLogin)
end;

function TUserLoginList.CreateChild: TUserLogin;
begin
  Result:=InternalAddObject as TUserLogin;
end;

{ TUserLogin }

procedure TUserLogin.SetAddProd(AValue: string);
begin
  if FAddProd=AValue then Exit;
  FAddProd:=AValue;
  ModifiedProperty('AddProd');
end;

function TUserLogin.GetPasswordDecoded: string;
begin
  Result:=DecodeStringBase64(FPass);
end;

procedure TUserLogin.SetCreateFreeCollect(AValue: string);
begin
  if FCreateFreeCollect=AValue then Exit;
  FCreateFreeCollect:=AValue;
  ModifiedProperty('CreateFreeCollect');
end;

procedure TUserLogin.SetCreateProd(AValue: string);
begin
  if FCreateProd=AValue then Exit;
  FCreateProd:=AValue;
  ModifiedProperty('CreateProd');
end;

procedure TUserLogin.SetId(AValue: string);
begin
  if FId=AValue then Exit;
  FId:=AValue;
  ModifiedProperty('Id');
end;

procedure TUserLogin.SetLogin(AValue: string);
begin
  if FLogin=AValue then Exit;
  FLogin:=AValue;
  ModifiedProperty('Login');
end;

procedure TUserLogin.SetPass(AValue: string);
begin
  if FPass=AValue then Exit;
  FPass:=AValue;
  ModifiedProperty('Pass');
end;

procedure TUserLogin.SetPasswordDecoded(AValue: string);
begin
  Pass:=EncodeStringBase64(AValue);
end;

procedure TUserLogin.SetRights(AValue: string);
begin
  if FRights=AValue then Exit;
  FRights:=AValue;
  ModifiedProperty('Rights');
end;

procedure TUserLogin.InternalRegisterPropertys;
begin
  RegisterProperty('Login', 'Login', 'О', 'псевдоним типа документа', 1, 50);
  RegisterProperty('Id', 'Id', 'О', 'псевдоним типа документа', 1, 50);
  RegisterProperty('Pass', 'Pass', 'О', 'псевдоним типа документа', 1, 50);
  RegisterProperty('Rights', 'Rights', 'О', 'псевдоним типа документа', 1, 50);
  RegisterProperty('CreateProd', 'CreateProd', 'О', 'псевдоним типа документа', 1, 50);
  RegisterProperty('AddProd', 'AddProd', 'О', 'псевдоним типа документа', 1, 50);
  RegisterProperty('CreateFreeCollect', 'CreateFreeCollect', 'О', 'псевдоним типа документа', 1, 50);
end;

procedure TUserLogin.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TUserLogin.Destroy;
begin
  inherited Destroy;
end;

{ TUserRight }

procedure TUserRight.SetGroupID(AValue: string);
begin
  if FGroupID=AValue then Exit;
  FGroupID:=AValue;
  ModifiedProperty('GroupID');
end;

procedure TUserRight.SetID(AValue: string);
begin
  if FID=AValue then Exit;
  FID:=AValue;
  ModifiedProperty('ID');
end;

procedure TUserRight.SetName(AValue: string);
begin
  if FName=AValue then Exit;
  FName:=AValue;
  ModifiedProperty('Name');
end;

procedure TUserRight.InternalRegisterPropertys;
begin
  RegisterProperty('Name', 'Name', 'О', 'псевдоним типа документа', 1, 50);
  RegisterProperty('ID', 'ID', 'О', 'код типа документа внутри группы', 1, 50);
  RegisterProperty('GroupID', 'GroupID', 'О', 'код группы документов, с которыми пользователь может работать', 1, 150);
end;

procedure TUserRight.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TUserRight.Destroy;
begin
  inherited Destroy;
end;

{ TUserRightsList }

function TUserRightsList.GetItem(AIndex: Integer): TUserRight;
begin
  Result:=TUserRight(InternalGetItem(AIndex));
end;

constructor TUserRightsList.Create;
begin
  inherited Create(TUserRight)
end;

function TUserRightsList.CreateChild: TUserRight;
begin
  Result:=InternalAddObject as TUserRight;
end;

{ TUserInformation }

procedure TUserInformation.InternalRegisterPropertys;
begin
  RegisterProperty('Logins', 'Login', 'О', 'учетные данные пользователя', -1, -1);
  RegisterProperty('Rights', 'Right', 'О', 'описание набора доступных прав пользователя', -1, -1);
end;

procedure TUserInformation.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FRights:=TUserRights.Create;
  FLogins:=TUserLogins.Create;
end;

function TUserInformation.RootNodeName: string;
begin
  Result:='Information';
end;

destructor TUserInformation.Destroy;
begin
  FLogins.Free;
  FRights.Free;
  inherited Destroy;
end;

end.

