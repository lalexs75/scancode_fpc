unit frmTSDOrderUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, DBCtrls, ComCtrls, ExtCtrls, DB,
  rxdbgrid, rxmemds;

type

  { TfrmTSDOrderFrame }

  TfrmTSDOrderFrame = class(TFrame)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CLabel: TLabel;
    dsTaskGoods: TDataSource;
    dsMarcCodes: TDataSource;
    dsOrders: TDataSource;
    DBImage1: TDBImage;
    dsGoods: TDataSource;
    PageControl1: TPageControl;
    Panel1: TPanel;
    RxDBGrid1: TRxDBGrid;
    RxDBGrid2: TRxDBGrid;
    RxDBGrid3: TRxDBGrid;
    RxDBGrid4: TRxDBGrid;
    rxGoods: TRxMemoryData;
    rxGoodsBmp: TBlobField;
    rxGoodsIdGoods: TStringField;
    rxGoodsIdMeasure: TStringField;
    rxGoodsIdVidnomencl: TStringField;
    rxGoodsImg: TStringField;
    rxGoodsName: TStringField;
    rxMarcCodesGS1_DATAMATRIX: TStringField;
    rxMarcCodesOinID: TLongintField;
    rxTaskGoods: TRxMemoryData;
    rxMarcCodes: TRxMemoryData;
    rxOrders: TRxMemoryData;
    rxOrdersDate: TDateTimeField;
    rxOrdersDateOrder: TDateTimeField;
    rxOrdersFC: TStringField;
    rxOrdersIdDoc: TStringField;
    rxOrdersIdSclad: TStringField;
    rxOrdersLastOrder: TStringField;
    rxOrdersTaskType: TStringField;
    rxTaskGoodsIdChar: TStringField;
    rxTaskGoodsIdDoc: TStringField;
    rxTaskGoodsIdGoods: TStringField;
    rxTaskGoodsintID: TAutoIncField;
    rxTaskGoodsQuantity: TStringField;
    Splitter1: TSplitter;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure rxMarcCodesFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure rxOrdersAfterOpen(DataSet: TDataSet);
    procedure rxTaskGoodsAfterClose(DataSet: TDataSet);
    procedure rxTaskGoodsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private

  public
    procedure GenerateData;
  end;

implementation
uses scancode_tsd_order_api, scGlobal, base64;

{$R *.lfm}

{ TfrmTSDOrderFrame }

procedure TfrmTSDOrderFrame.Button1Click(Sender: TObject);
var
  T: TTask;
  TG: TTaskGood;
  CL: TTaskGoodPropertySerialCell;
  NL: TNomenclature;
  TSDO: TOrders;
  //Handbooks: THandbooks;
  CH: TCharacteristic;
  BR: TTSDBarcode;
begin
  TSDO:=TOrders.Create;

  //Создадим документ обработки
  T:=TSDO.Tasks.AddItem;
  T.IdDoc:='70b9a737-c224-11e8-ba50-50465d72dd18';
  T.Date:='08.10.2018 0:00:00';
  T.TaskType:='202';
  T.DateOrder:='11.10.2018 17:18:48';
  T.FC:='0';
  T.IdSclad:='';

  TG:=T.Goods.AddItem;
  TG.IdChar:='b02e2816-720f-11df-b436-0015e92f2802';
  TG.IdGoods:='dee6e1d0-55bc-11d9-848a-00112f43529a';
  TG.GoodProperty.IdPack:=' ';
  TG.GoodProperty.Serial.Quantity:='1';
  TG.GoodProperty.Serial.IdSerial:=' ';
  TG.GoodProperty.Serial.Date:=' ';
  TG.GoodProperty.Serial.Value:=' ';
  CL:=TG.GoodProperty.Serial.Cells.AddItem;
  CL.IdCell:='322718363789694194929610170602799020651';
  CL.CellAddress:='БТ-СТ5-4';

  TG:=T.Goods.AddItem;
  TG.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
  TG.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
  TG.GoodProperty.IdPack:=' ';
  TG.GoodProperty.Serial.Quantity:='1';
  TG.GoodProperty.Serial.IdSerial:=' ';
  TG.GoodProperty.Serial.Date:=' ';
  TG.GoodProperty.Serial.Value:=' ';

  TG:=T.Goods.AddItem;
  TG.IdChar:='b02e280c-720f-11df-b436-0015e92f2802';
  TG.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
  TG.GoodProperty.IdPack:=' ';
  TG.GoodMarking.DATAMATRIX:=' ';
  TG.GoodMarking.PDF417:='123456789012345678901234567890';
  TG.GoodProperty.Serial.Quantity:='2';
  TG.GoodProperty.Serial.IdSerial:=' ';
  TG.GoodProperty.Serial.Date:=' ';
  TG.GoodProperty.Serial.Value:=' ';

//  Handbooks:=THandbooks.Create;
  NL:=TSDO.Handbooks.Nomenclatures.NomenclatureList.AddItem;
  NL.IdGoods:='1';
  NL.Name:='1';
  NL.IdMeasure:='1';
  NL.IdVidnomencl:='1';
  NL.Img:='1';
  NL.Bitmap:='1';

  CH:=TSDO.Handbooks.Characteristics.CharacteristicList.AddItem;
  CH.IdGoods:='1';
  CH.IdChar:='1';
  CH.Name:='1';

  BR:=TSDO.Handbooks.Barcodes.BarcodeList.AddItem;
  BR.IdGoods:='1';
  BR.IdChar:='1';
  BR.IdPack:='1';
  BR.Barcode:='1';

  TSDO.SaveToFile(ExportFolder + 'Order.xml');
  TSDO.Free;


//  Handbooks.SaveToFile(ExportFolder + 'Handbooks.xml');
//  Handbooks.Free;
end;

procedure TfrmTSDOrderFrame.Button2Click(Sender: TObject);
var
  O: TOrders;
  NM: TNomenclature;
  St1: TStringStream;
  Decoder: TBase64DecodingStream;
  St2: TMemoryStream;
  T:TTask;
  G:TTaskGood;
  M:TMarkedCode;
begin
  rxGoods.CloseOpen;
  rxOrders.CloseOpen;
  rxMarcCodes.CloseOpen;

  rxTaskGoods.Filtered:=false;
  rxMarcCodes.Filtered:=false;

  O:=TOrders.Create;
  O.LoadFromFile(DemoDataFolder + 'orders.xml');
  for NM in O.Handbooks.Nomenclatures.NomenclatureList do
  begin
    rxGoods.Append;
    rxGoodsIdGoods.AsString:=NM.IdGoods;
    rxGoodsName.AsString:=NM.Name;
    rxGoodsIdMeasure.AsString:=NM.IdMeasure;
    rxGoodsIdVidnomencl.AsString:=NM.IdVidnomencl;
    rxGoodsImg.AsString:=NM.Img;

    if NM.Bitmap<>'' then
    begin
      St1:=TStringStream.Create(NM.Bitmap);
      St2:=TMemoryStream.Create;
      Decoder:=TBase64DecodingStream.Create(St1,bdmMIME);

      St2.CopyFrom(Decoder, Decoder.Size);
      St2.Position:=0;
      rxGoodsBmp.LoadFromStream(St2);
      Decoder.Free;
      St1.Free;
      St2.Free;
    end;
    rxGoods.Post;
  end;

  for T in O.Tasks do
  begin
    rxOrders.Append;
    rxOrdersIdDoc.AsString:=T.IdDoc;
    rxOrdersDate.AsDateTime:=StrToDateTime(T.Date);
    rxOrdersTaskType.AsString:=T.TaskType;
    rxOrdersDateOrder.AsDateTime:=StrToDateTime(T.DateOrder);
    rxOrdersFC.AsString:=T.FC;
    rxOrdersIdSclad.AsString:=T.IdSclad;
    //rxOrdersIdDoc.AsString:=T.Goods:TTaskGoods read FGoods;
    rxOrdersLastOrder.AsString:=T.LastOrder;
    rxOrders.Post;

    for G in T.Goods do
    begin
      rxTaskGoods.Append;
      rxTaskGoodsIdDoc.AsString:=T.IdDoc;
      rxTaskGoodsIdChar.AsString:=G.IdChar;
      rxTaskGoodsIdGoods.AsString:=G.IdGoods;
      rxTaskGoodsQuantity.AsString:=G.GoodProperty.Serial.Quantity;
      rxTaskGoods.Post;

      for M in G.MarkedCodes.Tokens do
      begin
        rxMarcCodes.Append;
        rxMarcCodesOinID.AsInteger:=rxTaskGoodsintID.AsInteger;
        rxMarcCodesGS1_DATAMATRIX.AsString:=DecodeStringBase64(M.GS1_DATAMATRIX);
        rxMarcCodes.Post;
      end;
    end;
  end;
  O.Free;
  rxGoods.First;
  rxTaskGoods.Filtered:=true;
  rxMarcCodes.Filtered:=true;
  rxOrders.First;
end;

procedure TfrmTSDOrderFrame.rxMarcCodesFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=rxMarcCodesOinID.AsInteger =  rxTaskGoodsintID.AsInteger;
end;

procedure TfrmTSDOrderFrame.rxOrdersAfterOpen(DataSet: TDataSet);
begin
  rxTaskGoods.Active:=rxOrders.Active;
end;

procedure TfrmTSDOrderFrame.rxTaskGoodsAfterClose(DataSet: TDataSet);
begin
  rxMarcCodes.Active:=rxTaskGoods.Active;
end;

procedure TfrmTSDOrderFrame.rxTaskGoodsFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=rxTaskGoodsIdDoc.AsString = rxOrdersIdDoc.AsString;
end;

procedure TfrmTSDOrderFrame.GenerateData;
begin

end;

end.

