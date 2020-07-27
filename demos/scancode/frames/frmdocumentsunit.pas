unit frmDocumentsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, DB,
  scancode_document_api, AbstractSerializationObjects, rxmemds, rxdbgrid,
  Graphics;

type

  { TfrmDocumentsFrame }

  TfrmDocumentsFrame = class(TFrame)
    Button1: TButton;
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
    procedure RxDBGrid1GetCellProps(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor);
    procedure rxGoodsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure rxTasksAfterScroll(DataSet: TDataSet);
  private

  public
//    procedure DisableTaskScroll;
//    procedure DisableTaskScroll;
    procedure GenerateData;
    function CreateDocsList(Docs: scancode_document_api.TDocuments; AUserName:string; ACountDoc:Integer): scancode_document_api.TDocuments;
  end;

implementation
uses scGlobal, ScancodeMT_utils, GetDocum;

{$R *.lfm}

{ TfrmDocumentsFrame }

procedure TfrmDocumentsFrame.Button1Click(Sender: TObject);
var
  Docs: scancode_document_api.TDocuments;
begin
  Docs:=CreateDocsList(nil, '', 0);
  Docs.SaveToFile(ExportFolder + 'Documents.xml');
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

function TfrmDocumentsFrame.CreateDocsList(Docs: scancode_document_api.TDocuments; AUserName: string;
  ACountDoc: Integer): scancode_document_api.TDocuments;
var
  D: TDocument;
  G: TGood;
  GC: TGoodCell;

  DD:GetDocum.TDocuments;
  D1: TDocuments_Task;
  G1: TDocuments_Task_record;
begin
  if Assigned(Docs) then
    Result:=Docs
  else
    Result:=scancode_document_api.TDocuments.Create;

  DD:=GetDocum.TDocuments.Create;
  //Загрузим документы
  rxTasks.First;
  while not rxTasks.EOF do
  begin
    if not rxTasksCOMPLETED.AsBoolean then
    begin
      rxTasks.Edit;
      rxTasksUSER_NAME.AsString:=AUserName;
      rxTasks.Post;
      D:=Result.Documents.AddItem;
      D.Task.Barcode:=rxTasksBarcode.AsString;
      D.Task.Date:=rxTasksDate.AsString;
      D.Task.UseAdress:=BoolToStr(rxTasksUseAdress.AsBoolean, '1', '0');
      D.Task.Control:=BoolToStr(rxTasksControl.AsBoolean, '1','0');
      D.Task.TypeDoc:=rxTasksTypeDoc.AsString;
      D.Task.Nomer:=rxTasksNomer.AsString;
      D.Task.IdDoc:=rxTasksIdDoc.AsString;
      D.Task.IdZone:=rxTasksIdZone.AsString;
      D.Task.IdRoom:=rxTasksIdRoom.AsString;
      D.Task.IdStock:=rxTasksIdStock.AsString;

      D1:=DD.Task.AddItem;
      D1.barcode:=rxTasksBarcode.AsString;
      D1.Date:=rxTasksDate.AsString;
      D1.as_:=Ord(rxTasksUseAdress.AsBoolean);
      D1.Control:=Ord(rxTasksControl.AsBoolean);
      D1.type1:=rxTasksTypeDoc.AsString;
      D1.Nomer:=rxTasksNomer.AsString;
      D1.id_doc:=rxTasksIdDoc.AsString;
      D1.id_zone:=rxTasksIdZone.AsString;
      D1.id_room:=rxTasksIdRoom.AsString;
      D1.id_sclad:=rxTasksIdStock.AsString;

      rxGoods.First;
      while not rxGoods.EOF do
      begin
        G:=D.Task.Goods.AddItem;
        //G.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
        G.IdGoods:=rxGoodsID_GOODS.AsString;
        G.Quantity:=rxGoodsQuantity.AsString;

        G1:=D1.record1.AddItem;
        //G.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
        G1.id_goods:=rxGoodsID_GOODS.AsString;
        G1.quantity:=rxGoodsQuantity.AsString;

        //G.GoodProperty.Quantity:='1';
        //G.GoodProperty.IdPack:='dff7f708-7a0b-11df-b33a-0011955cba6b';
        //G.GoodProperty.GoodSerial.IdSerial:='934F6882-9D0A-4F05-82C2-2A131C452107';
        //G.GoodProperty.GoodSerial.Quantity:='1';

        //GC:=G.GoodProperty.GoodSerial.GoodCells.CreateChild;
        //GC.Cell:='305982541796071806599496327226965408363';
        //GC.CellAddress:='ОСТ3-2-1';
        rxGoods.Next;
      end;

      if ACountDoc > 0 then
        if Result.Documents.Count = ACountDoc then
          Break;
    end;
    rxTasks.Next;
  end;



  rxTasks.First;
  DD.SaveToFile(ExportFolder + 'Documents_1.xml');
  DD.Free;
end;

end.

