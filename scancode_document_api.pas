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

unit scancode_document_api;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, xmlobject;

type

  { TGood }

  TGood = class(TXmlSerializationObject)
  private
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
  end;

  { TGoods }

  TGoods = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TGood; inline;
  public
    constructor Create;
    function CreateChild:TGood;
    property Item[AIndex:Integer]:TGood read GetItem; default;
  end;

  { TTask }

  TTask = class(TXmlSerializationObject)
  private
    FBarcode: string;
    FControl: string;
    FDate: string;
    FGoods: TGoods;
    FIdDoc: string;
    FIdRoom: string;
    FIdSclad: string;
    FIdZone: string;
    FNomer: string;
    FTypeDoc: string;
    FUseAdress: string;
    procedure SetBarcode(AValue: string);
    procedure SetControl(AValue: string);
    procedure SetDate(AValue: string);
    procedure SetIdDoc(AValue: string);
    procedure SetIdRoom(AValue: string);
    procedure SetIdSclad(AValue: string);
    procedure SetIdZone(AValue: string);
    procedure SetNomer(AValue: string);
    procedure SetTypeDoc(AValue: string);
    procedure SetUseAdress(AValue: string);
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property Nomer:string read FNomer write SetNomer;
    property IdDoc:string read FIdDoc write SetIdDoc;
    property TypeDoc:string read FTypeDoc write SetTypeDoc;
    property UseAdress:string read FUseAdress write SetUseAdress;
    property Date:string read FDate write SetDate;
    property Control:string read FControl write SetControl;
    property Barcode:string read FBarcode write SetBarcode;
    property IdZone:string read FIdZone write SetIdZone;
    property IdSclad:string read FIdSclad write SetIdSclad;
    property IdRoom:string read FIdRoom write SetIdRoom;
    property Goods:TGoods read FGoods;
  end;

  { TDocument }

  TDocument = class(TXmlSerializationObject)
  private
    FTask: TTask;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
  public
    destructor Destroy; override;
  published
    property Task:TTask read FTask;
  end;

  { TDocumentsList }

  TDocumentsList = class(TXmlSerializationObjectList)
  private
    function GetItem(AIndex: Integer): TDocument; inline;
  public
    constructor Create;
    function CreateChild:TDocument;
    property Item[AIndex:Integer]:TDocument read GetItem; default;
  end;

  { TDocuments }

  TDocuments = class(TXmlSerializationObject)
  private
    FDocuments: TDocumentsList;
  protected
    procedure InternalRegisterPropertys; override;
    procedure InternalInitChilds; override;
    function RootNodeName:string; override;
  public
    destructor Destroy; override;
  published
    property Documents:TDocumentsList read FDocuments;
  end;

implementation

{ TGood }

procedure TGood.InternalRegisterPropertys;
begin

end;

procedure TGood.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TGood.Destroy;
begin
  inherited Destroy;
end;

{ TGoods }

function TGoods.GetItem(AIndex: Integer): TGood;
begin

end;

constructor TGoods.Create;
begin

end;

function TGoods.CreateChild: TGood;
begin

end;

{ TTask }

procedure TTask.SetBarcode(AValue: string);
begin
  if FBarcode=AValue then Exit;
  FBarcode:=AValue;
  ModifiedProperty('Barcode');
end;

procedure TTask.SetControl(AValue: string);
begin
  if FControl=AValue then Exit;
  FControl:=AValue;
  ModifiedProperty('Control');
end;

procedure TTask.SetDate(AValue: string);
begin
  if FDate=AValue then Exit;
  FDate:=AValue;
  ModifiedProperty('Date');
end;

procedure TTask.SetIdDoc(AValue: string);
begin
  if FIdDoc=AValue then Exit;
  FIdDoc:=AValue;
  ModifiedProperty('IdDoc');
end;

procedure TTask.SetIdRoom(AValue: string);
begin
  if FIdRoom=AValue then Exit;
  FIdRoom:=AValue;
  ModifiedProperty('IdRoom');
end;

procedure TTask.SetIdSclad(AValue: string);
begin
  if FIdSclad=AValue then Exit;
  FIdSclad:=AValue;
  ModifiedProperty('IdSclad');
end;

procedure TTask.SetIdZone(AValue: string);
begin
  if FIdZone=AValue then Exit;
  FIdZone:=AValue;
  ModifiedProperty('IdZone');
end;

procedure TTask.SetNomer(AValue: string);
begin
  if FNomer=AValue then Exit;
  FNomer:=AValue;
  ModifiedProperty('Nomer');
end;

procedure TTask.SetTypeDoc(AValue: string);
begin
  if FTypeDoc=AValue then Exit;
  FTypeDoc:=AValue;
  ModifiedProperty('TypeDoc');
end;

procedure TTask.SetUseAdress(AValue: string);
begin
  if FUseAdress=AValue then Exit;
  FUseAdress:=AValue;
  ModifiedProperty('UseAdress');
end;

procedure TTask.InternalRegisterPropertys;
begin

end;

procedure TTask.InternalInitChilds;
begin
  inherited InternalInitChilds;
end;

destructor TTask.Destroy;
begin
  inherited Destroy;
end;

{ TDocument }

procedure TDocument.InternalRegisterPropertys;
begin
  RegisterProperty('Task', 'Task', 'О', 'реквизиты документа', -1, -1);
end;

procedure TDocument.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FTask:=TTask.Create;
end;

destructor TDocument.Destroy;
begin
  FreeAndNil(FTask);
  inherited Destroy;
end;

{ TDocumentsList }

function TDocumentsList.GetItem(AIndex: Integer): TDocument;
begin
  Result:=TDocument(InternalGetItem(AIndex));
end;

constructor TDocumentsList.Create;
begin
  inherited Create(TDocument)
end;

function TDocumentsList.CreateChild: TDocument;
begin
  Result:=InternalAddObject as TDocument;
end;

{ TDocuments }

procedure TDocuments.InternalRegisterPropertys;
begin
  RegisterProperty('Documents', 'Document', 'О', 'группа документов', -1, -1);
end;

procedure TDocuments.InternalInitChilds;
begin
  inherited InternalInitChilds;
  FDocuments:=TDocumentsList.Create;
end;

function TDocuments.RootNodeName: string;
begin
  Result:='Documents';
end;

destructor TDocuments.Destroy;
begin
  FreeAndNil(FDocuments);
  inherited Destroy;
end;

end.

