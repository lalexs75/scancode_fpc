unit frmStocksUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ExtCtrls, StdCtrls, DB, rxdbgrid, rxmemds,
  scancode_stock_api, AbstractSerializationObjects;

type

  { TfrmStocksFrame }

  TfrmStocksFrame = class(TFrame)
    Button1: TButton;
    dsStocks: TDataSource;
    dsRoom: TDataSource;
    dsCell: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    rxCellbarcode: TStringField;
    rxCellid_cell: TStringField;
    rxCellid_room: TStringField;
    rxCellname: TStringField;
    RxDBGrid1: TRxDBGrid;
    RxDBGrid2: TRxDBGrid;
    RxDBGrid3: TRxDBGrid;
    rxRoombarcode: TStringField;
    rxRoomid_room: TStringField;
    rxRoomid_stock: TStringField;
    rxRoomname: TStringField;
    rxStocks: TRxMemoryData;
    rxRoom: TRxMemoryData;
    rxCell: TRxMemoryData;
    rxStocksbarcode: TStringField;
    rxStocksid_stock: TStringField;
    rxStocksname: TStringField;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure rxCellAfterInsert(DataSet: TDataSet);
    procedure rxCellFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure rxRoomAfterInsert(DataSet: TDataSet);
    procedure rxRoomAfterOpen(DataSet: TDataSet);
    procedure rxRoomAfterScroll(DataSet: TDataSet);
    procedure rxRoomFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure rxStocksAfterOpen(DataSet: TDataSet);
    procedure rxStocksAfterScroll(DataSet: TDataSet);
  private

  public
    procedure GenerateData;
    function CreateStocksInfo(SI:TStocks):scancode_stock_api.TStocks;
  end;

implementation
uses scGlobal, GetStock;

{$R *.lfm}

{ TfrmStocksFrame }

procedure TfrmStocksFrame.rxStocksAfterOpen(DataSet: TDataSet);
begin
  rxRoom.Active:=rxStocks.Active;
  if rxRoom.Active then
    rxRoom.Filtered:=true;
end;

procedure TfrmStocksFrame.rxStocksAfterScroll(DataSet: TDataSet);
begin
  rxRoom.First;
end;

procedure TfrmStocksFrame.rxRoomFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=rxStocks.Active and (rxStocks.RecordCount>0) and (rxStocksid_stock.AsString = rxRoomid_stock.AsString);
end;

procedure TfrmStocksFrame.rxRoomAfterInsert(DataSet: TDataSet);
begin
  rxRoomid_stock.AsString:=rxStocksid_stock.AsString;
end;

procedure TfrmStocksFrame.rxCellAfterInsert(DataSet: TDataSet);
begin
  rxCellid_room.AsString:=rxRoomid_room.AsString;
end;

procedure TfrmStocksFrame.Button1Click(Sender: TObject);
var
  FStocks: scancode_stock_api.TStocks;
begin
  FStocks:=CreateStocksInfo(nil);
  FStocks.SaveToFile(ExportFolder + 'Stocks.xml');
  FStocks.Free;
end;

procedure TfrmStocksFrame.rxCellFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=rxRoom.Active and (rxRoom.RecordCount>0) and (rxRoomid_room.AsString = rxCellid_room.AsString);
end;

procedure TfrmStocksFrame.rxRoomAfterOpen(DataSet: TDataSet);
begin
  rxCell.Active:=rxRoom.Active;
  if rxCell.Active then
    rxCell.Filtered:=true;
end;

procedure TfrmStocksFrame.rxRoomAfterScroll(DataSet: TDataSet);
begin
  rxCell.First;
end;

procedure TfrmStocksFrame.GenerateData;
begin
  rxStocks.CloseOpen;
  rxStocks.AppendRecord(['6f87e83f-722c-11df-b336-0011955cba6b', '148249928', 'Центральный склад']);
   rxRoom.AppendRecord(['670658B3-80D6-44D9-9741-35F04CC598CC', '148249948', 'Продукты']);
     rxCell.AppendRecord(['c5bcca8d-44ca-11e0-af0b-0015e9b8c48d', '262838176', 'П-А2-12']); //П-А2-12
     rxCell.AppendRecord(['4dd6daf4-44ca-11e0-af0b-0015e9b8c48d', '262838177', 'П-А3']); //П-А3
   rxRoom.AppendRecord(['81B4655B-AD50-4054-B44C-C931174189F0', '148249128', 'Молочка']);
     rxCell.AppendRecord(['4E8079AA-921E-47BE-9579-9BFB0C6B7160', '2612332213', 'Молоко']);
     rxCell.AppendRecord(['18DA8A1D-7DD3-4C89-8197-BF4E6A45B5FE', '2628323477', 'П-Кефир']);

  rxStocks.AppendRecord(['6AC0FF1C-832F-49D8-934B-4BA31AB41C9A', '148319978', 'Удалённый склад № 1']);
    rxRoom.AppendRecord(['6f87e842-722c-11df-b336-0011955cba6b', '148569978', 'Электрика']);
      rxCell.AppendRecord(['c5bcca8d-44ca-11e0-af0b-0015e9b8c48d', '2623438176', 'Включатель']);
      rxCell.AppendRecord(['4dd6daf4-44ca-11e0-af0b-0015e9b8c48d', '2628323577', 'Выключатель']);
    rxRoom.AppendRecord(['D2E92D7A-5264-4942-9011-1725F6D276C7', '148242578', 'Стройматериалы']);
      rxCell.AppendRecord(['4E8079AA-921E-47BE-9579-9BFB0C6B7160', '26123532213', 'Цемент']);
      rxCell.AppendRecord(['18DA8A1D-7DD3-4C89-8197-BF4E6A45B5FE', '262832763477', 'Кафель']);
      rxCell.AppendRecord(['18DA8A1D-7DD3-4C89-8197-BF4E6A45B5FE', '262832763477', 'Краска']);
  rxStocks.First;
end;

function TfrmStocksFrame.CreateStocksInfo(SI: scancode_stock_api.TStocks): scancode_stock_api.TStocks;
var
  S: TStock;
  R: scancode_stock_api.TRoom;
  C: scancode_stock_api.TCell;

  SS:GetStock.TStocks;
  S1: TStocks_Stock;
  R1: TStocks_Stock_Room;
  C1: TStocks_Stock_Room_Cell;
begin
  if Assigned(SI) then
    Result:=SI
  else
    Result:=scancode_stock_api.TStocks.Create;
  SS:=GetStock.TStocks.Create;
  rxStocks.First;
  while not rxStocks.EOF do
  begin
    S:=Result.Stocks.AddItem;
    S.IdStock:=rxStocksid_stock.AsString;
    S.Barcode:=rxStocksbarcode.AsString;
    S.Name:=rxStocksname.AsString;

    S1:=SS.Stock.AddItem;
    S1.id_sclad:=rxStocksid_stock.AsString;
    S1.barcode:=rxStocksbarcode.AsString;
    S1.name:=rxStocksname.AsString;

    rxRoom.First;
    while not rxRoom.EOF do
    begin
      R:=S.Rooms.AddItem;
      R.IdRoom:=rxRoomid_room.AsString;
      R.Barcode:=rxRoombarcode.AsString;
      R.Name:=rxRoomname.AsString;

      R1:=S1.Room.AddItem;
      R1.id_room:=rxRoomid_room.AsString;
      R1.barcode:=rxRoombarcode.AsString;
      R1.name:=rxRoomname.AsString;

      rxCell.First;
      while not rxCell.EOF do
      begin
        C:=R.Cells.AddItem;
        C.IdCell:=rxCellid_cell.AsString;
        C.Barcode:=rxCellbarcode.AsString;
        C.Name:=rxCellname.AsString;

        C1:=R1.Cell.AddItem;
        C1.id_cell:=rxCellid_cell.AsString;
        C1.barcode:=rxCellbarcode.AsString;
        C1.name:=rxCellname.AsString;
        rxCell.Next;
      end;

      rxRoom.Next;
    end;
    rxStocks.Next;
  end;
  rxStocks.First;

  SS.SaveToFile(ExportFolder + 'Stocks_1.xml');
  SS.Free;
end;

end.

