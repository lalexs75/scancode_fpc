{ interface library for FPC and Lazarus
  Copyright (C) 2019-2020 Lagunov Aleksey alexs75@yandex.ru

  Комплексный пример


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

unit frmDocumentsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, DB,
  GetDocum, AbstractSerializationObjects, rxmemds, rxdbgrid,
  Graphics;

type

  { TfrmDocumentsFrame }

  TfrmDocumentsFrame = class(TFrame)
    Button1: TButton;
    Button2: TButton;
    dsGoods: TDataSource;
    dsTasks: TDataSource;
    Panel1: TPanel;
    RxDBGrid1: TRxDBGrid;
    RxDBGrid2: TRxDBGrid;
    rxGoods: TRxMemoryData;
    rxGoodsBARCODE: TStringField;
    rxGoodsCOMPLETED: TBooleanField;
    rxGoodsIdDoc: TStringField;
    rxGoodsID_GOODS: TStringField;
    rxGoodsQuantity: TStringField;
    rxTasks: TRxMemoryData;
    rxTasksBarcode: TStringField;
    rxTasksCOMPLETED: TBooleanField;
    rxTasksControl: TBooleanField;
    rxTasksDate: TDateField;
    rxTasksIdDoc: TStringField;
    rxTasksIdRoom: TStringField;
    rxTasksIdStock: TStringField;
    rxTasksIdZone: TStringField;
    rxTasksNomer: TStringField;
    rxTasksTypeDoc: TStringField;
    rxTasksUseAdress: TBooleanField;
    rxTasksUSER_NAME: TStringField;
    Splitter1: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RxDBGrid1GetCellProps(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor);
    procedure rxGoodsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure rxTasksAfterScroll(DataSet: TDataSet);
  private

  public
//    procedure DisableTaskScroll;
//    procedure DisableTaskScroll;
    procedure GenerateData;
    function CreateDocsList(Docs: TDocuments; AUserName:string; ACountDoc:Integer): TDocuments;
  end;

implementation
uses scGlobal, ScancodeMT_utils, rxlogging, base64;

{$R *.lfm}

{ TfrmDocumentsFrame }

procedure TfrmDocumentsFrame.Button1Click(Sender: TObject);
var
  Docs: TDocuments;
begin
  Docs:=CreateDocsList(nil, '', 0);
  Docs.SaveToFile(ExportFolder + 'Documents.xml');
  Docs.Free;
end;

procedure TfrmDocumentsFrame.Button2Click(Sender: TObject);
var
  Docs: TDocuments;

  T:TDocuments_Task;
  R:TDocuments_Task_record;
  M:TDocuments_Task_record_marked_codes_token;
  S: String;
begin
  Docs:=TDocuments.Create;
  Docs.LoadFromFile('/home/alexs/work/4/TDocuments.xml');

  for T in Docs.Task do
  begin
    for R in T.record1 do
    begin
      for M in R.marked_codes.token do
      begin
        S:=DecodeStringBase64(M.GS1_DATAMATRIX);
        RxWriteLog(etDebug, '%s :: %s', [M.GS1_DATAMATRIX, S]);
      end;

    end;
  end;
  Docs.Free;
end;

procedure TfrmDocumentsFrame.RxDBGrid1GetCellProps(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor);
begin
  if (not rxTasksCOMPLETED.AsBoolean) and (rxTasksUSER_NAME.AsString <> '') then
    Background:=clSkyBlue
  else
  if rxTasksCOMPLETED.AsBoolean then
    Background:=clSilver;
end;

procedure TfrmDocumentsFrame.rxGoodsFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=rxGoodsIdDoc.AsString = rxTasksIdDoc.AsString;
end;

procedure TfrmDocumentsFrame.rxTasksAfterScroll(DataSet: TDataSet);
begin
  rxGoods.First;
end;

procedure TfrmDocumentsFrame.GenerateData;
begin
  rxTasks.Open;
  rxGoods.Open;

  rxTasks.AppendRecord(['20011011011', Date, true, true, '103', 'A0000123', DocIDToGUID(1233222), StockIDToGUID(1), false]);
  rxTasks.AppendRecord(['20011011012', Date, true, true, '101', 'B0000003', DocIDToGUID(1233211), StockIDToGUID(1), false]);
  rxTasks.AppendRecord(['20011011013', Date, true, true, '101', 'C0000023', DocIDToGUID(1233123), StockIDToGUID(2), false]);
  rxTasks.AppendRecord(['20011011014', Date, true, true, '101', 'D0000155', DocIDToGUID(1233124), StockIDToGUID(2), false]);

  //rxGoods.AppendRecord([GoodsIDToGUID(1), 2, DocIDToGUID(1233222)]);
  rxGoods.AppendRecord([GoodsIDToGUID(2), 1, DocIDToGUID(1233222)]);
  rxGoods.AppendRecord([GoodsIDToGUID(3), 1, DocIDToGUID(1233222)]);

  rxGoods.AppendRecord([GoodsIDToGUID(1), 1, DocIDToGUID(1233211)]);
  rxGoods.AppendRecord([GoodsIDToGUID(2), 1, DocIDToGUID(1233211)]);
  //rxGoods.AppendRecord([GoodsIDToGUID(3), 1, DocIDToGUID(1233211)]);

  //rxGoods.AppendRecord([GoodsIDToGUID(1), 2, DocIDToGUID(1233123)]);
  rxGoods.AppendRecord([GoodsIDToGUID(2), 1, DocIDToGUID(1233123)]);
  rxGoods.AppendRecord([GoodsIDToGUID(3), 1, DocIDToGUID(1233123)]);

  //rxGoods.AppendRecord([GoodsIDToGUID(1), 3, DocIDToGUID(1233124)]);
  rxGoods.AppendRecord([GoodsIDToGUID(2), 1, DocIDToGUID(1233124)]);
  rxGoods.AppendRecord([GoodsIDToGUID(3), 1, DocIDToGUID(1233124)]);

  rxTasks.First;
  rxGoods.Filtered:=true;
  rxGoods.First;
end;

function TfrmDocumentsFrame.CreateDocsList(Docs: TDocuments; AUserName: string;
  ACountDoc: Integer): TDocuments;
var
  D: TDocuments_Task;
  G: TDocuments_Task_record;
(*var
  D: TTask;
  G:Trecord;*)
begin
  if Assigned(Docs) then
    Result:=Docs
  else
    Result:=TDocuments.Create;

  //Загрузим документы
  rxTasks.First;
  while not rxTasks.EOF do
  begin
    if not rxTasksCOMPLETED.AsBoolean then
    begin
      rxTasks.Edit;
      rxTasksUSER_NAME.AsString:=AUserName;
      rxTasks.Post;
      D:=Result.Task.AddItem;
      D.barcode:=rxTasksBarcode.AsString;
//      D.Date:=rxTasksDate.AsString;
      D.as_:=Ord(rxTasksUseAdress.AsBoolean);
      D.Control:=Ord(rxTasksControl.AsBoolean);
      D.type1:=rxTasksTypeDoc.AsString;
      D.Nomer:=rxTasksNomer.AsString;
      D.id_doc:=rxTasksIdDoc.AsString;
      D.id_zone:=rxTasksIdZone.AsString;
      D.id_room:=rxTasksIdRoom.AsString;
      D.id_sclad:=rxTasksIdStock.AsString;


      rxGoods.First;
      while not rxGoods.EOF do
      begin
        G:=D.record1.AddItem;
        //G.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
        G.id_goods:=rxGoodsID_GOODS.AsString;
        G.Quantity:=rxGoodsQuantity.AsString;


        //G.GoodProperty.Quantity:='1';
        //G.GoodProperty.IdPack:='dff7f708-7a0b-11df-b33a-0011955cba6b';
        //G.GoodProperty.GoodSerial.IdSerial:='934F6882-9D0A-4F05-82C2-2A131C452107';
        //G.GoodProperty.GoodSerial.Quantity:='1';

        //GC:=G.GoodProperty.GoodSerial.GoodCells.CreateChild;
        //GC.Cell:='305982541796071806599496327226965408363';
        //GC.CellAddress:='ОСТ3-2-1';
        rxGoods.Next;
      end;

    end;
    rxTasks.Next;
  end;


(*


  //Загрузим документы
  rxTasks.First;
  while not rxTasks.EOF do
  begin
    if not rxTasksCOMPLETED.AsBoolean then
    begin
      rxTasks.Edit;
      rxTasksUSER_NAME.AsString:=AUserName;
      rxTasks.Post;
      D:=Result.Document.Task;
      D.barcode:=rxTasksBarcode.AsString;
      D.Date:=rxTasksDate.AsString;
      D.as_:=Ord(rxTasksUseAdress.AsBoolean);
      D.Control:=Ord(rxTasksControl.AsBoolean);
      D.type1:=1; //rxTasksTypeDoc.AsString;
      D.nomer:=123; // rxTasksNomer.AsString;
      D.id_doc:=rxTasksIdDoc.AsString;
      //D.id_zone:=rxTasksIdZone.AsString;
      //D.id_room:=rxTasksIdRoom.AsString;
      D.id_stock:=rxTasksIdStock.AsString;


      rxGoods.First;
      while not rxGoods.EOF do
      begin
        G:=D.record1.AddItem;
        //G.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
        G.id_goods:=rxGoodsID_GOODS.AsString;
        G.Quantity:=123; //rxGoodsQuantity.AsString;


        //G.GoodProperty.Quantity:='1';
        //G.GoodProperty.IdPack:='dff7f708-7a0b-11df-b33a-0011955cba6b';
        //G.GoodProperty.GoodSerial.IdSerial:='934F6882-9D0A-4F05-82C2-2A131C452107';
        //G.GoodProperty.GoodSerial.Quantity:='1';

        //GC:=G.GoodProperty.GoodSerial.GoodCells.CreateChild;
        //GC.Cell:='305982541796071806599496327226965408363';
        //GC.CellAddress:='ОСТ3-2-1';
        rxGoods.Next;
      end;

    end;
    rxTasks.Next;
  end;
*)
  rxTasks.First;
end;

end.

