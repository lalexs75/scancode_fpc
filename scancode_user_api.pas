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

unit scancode_user_api;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject, AbstractSerializationObjects;

type
  TUserRightDoc = (urdAcceptance = 1, urdShipment = 2, urdInventory = 3, urdMoving = 4);
  TUserRightDocs = set of TUserRightDoc;

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
  TUserRightsList = specialize GXMLSerializationObjectList<TUserRight>;

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
    procedure SetAddProd(AValue: string);
    procedure SetCreateFreeCollect(AValue: string);
    procedure SetCreateProd(AValue: string);
    procedure SetId(AValue: string);
    procedure SetLogin(AValue: string);
    procedure SetPass(AValue: string);
    procedure SetRights(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
    procedure SetPassword(APassword:string);
    procedure SetUserRight(ARight:TUserRightDocs);
    procedure SetUserRightCreate(ARight:TUserRightDocs);
    procedure SetUserRightAdd(ARight:TUserRightDocs);
    procedure SetUserRightFree(ARight:TUserRightDocs);
  published
    property Login:string read FLogin write SetLogin;
    property Id:string read FId write SetId;
    property Pass:string read FPass write SetPass;
    property Rights:string read FRights write SetRights;
    property CreateProd:string read FCreateProd write SetCreateProd;
    property AddProd:string read FAddProd write SetAddProd;
    property CreateFreeCollect:string read FCreateFreeCollect write SetCreateFreeCollect;
  end;
  TUserLoginList = specialize GXMLSerializationObjectList<TUserLogin>;

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

  { TExtendedInformation }

  TExtendedInformation = class(TXmlSerializationObject)
  private
    FConfirm: string;
    FDocType: string;
    FfileName: string;
    FPackgeNumber: string;
    FSerial: string;
    FUserID: string;
    FUserIP: string;
    FVersion: string;
    procedure SetConfirm(AValue: string);
    procedure SetDocType(AValue: string);
    procedure SetfileName(AValue: string);
    procedure SetPackgeNumber(AValue: string);
    procedure SetSerial(AValue: string);
    procedure SetUserID(AValue: string);
    procedure SetUserIP(AValue: string);
    procedure SetVersion(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    destructor Destroy; override;
  published
    property Confirm:string read FConfirm write SetConfirm;
    property DocType:string read FDocType write SetDocType;
    property fileName:string read FfileName write SetfileName;
    property PackgeNumber:string read FPackgeNumber write SetPackgeNumber;
    property Serial:string read FSerial write SetSerial;
    property UserID:string read FUserID write SetUserID;
    property UserIP:string read FUserIP write SetUserIP;
    property Version:string read FVersion write SetVersion;
  end;

implementation
uses sha1, base64;

{ TExtendedInformation }

procedure TExtendedInformation.SetConfirm(AValue: string);
begin
  if FConfirm=AValue then Exit;
  FConfirm:=AValue;
  ModifiedProperty('Confirm');
end;

procedure TExtendedInformation.SetDocType(AValue: string);
begin
  if FDocType=AValue then Exit;
  FDocType:=AValue;
  ModifiedProperty('DocType');
end;

procedure TExtendedInformation.SetfileName(AValue: string);
begin
  if FfileName=AValue then Exit;
  FfileName:=AValue;
  ModifiedProperty('fileName');
end;

procedure TExtendedInformation.SetPackgeNumber(AValue: string);
begin
  if FPackgeNumber=AValue then Exit;
  FPackgeNumber:=AValue;
  ModifiedProperty('PackgeNumber');
end;

procedure TExtendedInformation.SetSerial(AValue: string);
begin
  if FSerial=AValue then Exit;
  FSerial:=AValue;
  ModifiedProperty('Serial');
end;

procedure TExtendedInformation.SetUserID(AValue: string);
begin
  //if FUserID=AValue then Exit;
  FUserID:=AValue;
  ModifiedProperty('UserID');
end;

procedure TExtendedInformation.SetUserIP(AValue: string);
begin
  if FUserIP=AValue then Exit;
  FUserIP:=AValue;
  ModifiedProperty('UserIP');
end;

procedure TExtendedInformation.SetVersion(AValue: string);
begin
  if FVersion=AValue then Exit;
  FVersion:=AValue;
  ModifiedProperty('Version');
end;

procedure TExtendedInformation.InternalRegisterPropertys;
begin
  RegisterProperty('Confirm', 'confirm', [], 'Статус подтверждения ордера', 1, 255);
  RegisterProperty('DocType', 'docType', [], 'Тип документа', 1, 255);
  RegisterProperty('fileName', 'fileName', [], 'Имя файла', 1, 255);
  RegisterProperty('PackgeNumber', 'packgeNumber', [], 'Номер посылки', 1, 255);
  RegisterProperty('Serial', 'serial', [], 'Серийный номер ТСД', 1, 255);
  RegisterProperty('UserID', 'userID', [], 'Идентификатор', 1, 255);
  RegisterProperty('UserIP', 'userIP', [], 'IP адрес терминала', 1, 255);
  RegisterProperty('Version', 'version', [], 'Версия протокола', 1, 255);
end;

procedure TExtendedInformation.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

function TExtendedInformation.RootNodeName: string;
begin
  Result:='protocol1C';
end;

destructor TExtendedInformation.Destroy;
begin
  inherited Destroy;
end;

{ TUserRights }

procedure TUserRights.InternalRegisterPropertys;
begin
  RegisterProperty('Records', 'Record', [], 'Строки', -1, -1);
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
  RegisterProperty('Records', 'Record', [xsaRequared], 'Строки', -1, -1);
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

{ TUserLogin }

procedure TUserLogin.SetAddProd(AValue: string);
begin
  if FAddProd=AValue then Exit;
  FAddProd:=AValue;
  ModifiedProperty('AddProd');
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

procedure TUserLogin.SetRights(AValue: string);
begin
  if FRights=AValue then Exit;
  FRights:=AValue;
  ModifiedProperty('Rights');
end;

procedure TUserLogin.InternalRegisterPropertys;
begin
  RegisterProperty('Login', 'Login', [xsaRequared], 'псевдоним типа документа', 1, 50);
  RegisterProperty('Id', 'Id', [xsaRequared], 'псевдоним типа документа', 1, 50);
  RegisterProperty('Pass', 'Pass', [], 'псевдоним типа документа', 1, 250);
  RegisterProperty('Rights', 'Rights', [xsaRequared], 'псевдоним типа документа', 1, 50);
  RegisterProperty('CreateProd', 'CreateProd', [], 'псевдоним типа документа', 1, 50);
  RegisterProperty('AddProd', 'AddProd', [], 'псевдоним типа документа', 1, 50);
  RegisterProperty('CreateFreeCollect', 'CreateFreeCollect', [], 'псевдоним типа документа', 1, 50);
end;

procedure TUserLogin.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TUserLogin.Destroy;
begin
  inherited Destroy;
end;

procedure TUserLogin.SetPassword(APassword: string);
var
  FSha1: TSHA1Digest;
  S1, S2:string;
begin
  FSha1:=SHA1String(APassword);
  SetLength(S1, SizeOf(FSha1));
  Move(FSha1, S1[1], SizeOf(FSha1));

  FSha1:=SHA1String(UpperCase(APassword));
  SetLength(S2, SizeOf(FSha1));
  Move(FSha1, S2[1], SizeOf(FSha1));

  Pass:=EncodeStringBase64(S1)+','+EncodeStringBase64(S2);
end;

procedure TUserLogin.SetUserRight(ARight: TUserRightDocs);
var
  S: String;
  R: TUserRightDoc;
begin
  S:='';
  for R in ARight do
    S:=S + IntToStr(Ord(R)) + '/';
  Rights:=Copy(S, 1, Length(S)-1);
end;

procedure TUserLogin.SetUserRightCreate(ARight: TUserRightDocs);
var
  S: String;
  R: TUserRightDoc;
begin
  S:='';
  for R in ARight do
    S:=S + IntToStr(Ord(R)) + '/';
  CreateProd:=Copy(S, 1, Length(S)-1);
end;

procedure TUserLogin.SetUserRightAdd(ARight: TUserRightDocs);
var
  S: String;
  R: TUserRightDoc;
begin
  S:='';
  for R in ARight do
    S:=S + IntToStr(Ord(R)) + '/';
  AddProd:=Copy(S, 1, Length(S)-1);
end;

procedure TUserLogin.SetUserRightFree(ARight: TUserRightDocs);
var
  S: String;
  R: TUserRightDoc;
begin
  S:='';
  for R in ARight do
    S:=S + IntToStr(Ord(R)) + '/';
  CreateFreeCollect:=Copy(S, 1, Length(S)-1);
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
  RegisterProperty('Name', 'Name', [], 'псевдоним типа документа', 1, 50);
  RegisterProperty('ID', 'ID', [], 'код типа документа внутри группы', 1, 50);
  RegisterProperty('GroupID', 'GroupID', [], 'код группы документов, с которыми пользователь может работать', 1, 150);
end;

procedure TUserRight.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TUserRight.Destroy;
begin
  inherited Destroy;
end;

{ TUserInformation }

procedure TUserInformation.InternalRegisterPropertys;
begin
  RegisterProperty('Logins', 'Login', [], 'учетные данные пользователя', -1, -1);
  RegisterProperty('Rights', 'Right', [], 'описание набора доступных прав пользователя', -1, -1);
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

