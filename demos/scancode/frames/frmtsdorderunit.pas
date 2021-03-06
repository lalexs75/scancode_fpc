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

unit frmTSDOrderUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, DBCtrls, ComCtrls, ExtCtrls, DB,
  rxdbgrid, rxmemds, PutDocum;

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
    rxOrdersLastOrder: TLongintField;
    rxTaskGoods: TRxMemoryData;
    rxMarcCodes: TRxMemoryData;
    rxOrders: TRxMemoryData;
    rxOrdersDate: TDateTimeField;
    rxOrdersDateOrder: TDateTimeField;
    rxOrdersFC: TStringField;
    rxOrdersIdDoc: TStringField;
    rxOrdersIdSclad: TStringField;
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
uses scGlobal, base64;

{$R *.lfm}

{ TfrmTSDOrderFrame }

procedure TfrmTSDOrderFrame.Button1Click(Sender: TObject);
(*var
  T: TOrders_Task;
  TG: TOrders_Task_record;
  CL: TOrders_Task_record_property_serial_cells;
  NL: TOrders_handbooks_nomencls_record;
  TSDO: TOrders;
  //Handbooks: THandbooks;
  CH: TOrders_handbooks_characteristics_record;
  BR: TOrders_handbooks_barcodes_record;
*)
begin
(*  TSDO:=TOrders.Create;

  //Создадим документ обработки
  T:=TSDO.Task.AddItem;
  T.id_doc:='70b9a737-c224-11e8-ba50-50465d72dd18';
  T.Date:='08.10.2018 0:00:00';
  T.type1:='202';
  T.date_order:='11.10.2018 17:18:48';
  T.FC:='0';
  T.id_sclad:='';

  TG:=T.record1.AddItem;
  TG.id_char:='b02e2816-720f-11df-b436-0015e92f2802';
  TG.id_goods:='dee6e1d0-55bc-11d9-848a-00112f43529a';
  TG.property1.id_pack:=' ';
  TG.property1.Serial.Quantity:='1';
  TG.property1.Serial.id_serial:=' ';
  TG.property1.Serial.Date:=' ';
  TG.property1.Serial.Value:=' ';
  CL:=TG.property1.serial.cells.AddItem;
  CL.id_cell:='322718363789694194929610170602799020651';
  CL.CellAddress:='БТ-СТ5-4';

  TG:=T.record1.AddItem;
  TG.id_char:='b02e2809-720f-11df-b436-0015e92f2802';
  TG.id_goods:='bd72d913-55bc-11d9-848a-00112f43529a';
  TG.property1.id_pack:=' ';
  TG.property1.Serial.Quantity:='1';
  TG.property1.Serial.id_serial:=' ';
  TG.property1.Serial.Date:=' ';
  TG.property1.Serial.Value:=' ';

  TG:=T.record1.AddItem;
  TG.id_char:='b02e280c-720f-11df-b436-0015e92f2802';
  TG.id_goods:='bd72d913-55bc-11d9-848a-00112f43529a';
  TG.property1.id_pack:=' ';
//  TG.property1.DATAMATRIX:=' ';
//  TG.property1.PDF417:='123456789012345678901234567890';
  TG.property1.Serial.Quantity:='2';
  TG.property1.Serial.id_serial:=' ';
  TG.property1.Serial.Date:=' ';
  TG.property1.Serial.Value:=' ';

//  Handbooks:=THandbooks.Create;
  NL:=TSDO.Handbooks.nomencls.record1.AddItem;
  NL.id_goods:='1';
  NL.Name:='1';
  NL.id_measure:='1';
  NL.id_vidnomencl:='1';
  NL.Img:='1';
  NL.Bitmap:='1';

  CH:=TSDO.Handbooks.Characteristics.record1.AddItem;
  CH.id_goods:='1';
  CH.id_char:='1';
  CH.Name:='1';

  BR:=TSDO.Handbooks.Barcodes.record1.AddItem;
  BR.id_goods:='1';
  BR.id_char:='1';
  BR.id_pack:='1';
  BR.Barcode:='1';

  TSDO.SaveToFile(ExportFolder + 'Order.xml');
  TSDO.Free;


//  Handbooks.SaveToFile(ExportFolder + 'Handbooks.xml');
//  Handbooks.Free;
*)
end;

procedure TfrmTSDOrderFrame.Button2Click(Sender: TObject);
var
  O: TOrders;
  NM: TOrders_handbooks_nomencls_record;
  St1: TStringStream;
  Decoder: TBase64DecodingStream;
  St2: TMemoryStream;
  T:TOrders_Task;
  G:TOrders_Task_record;
  M:TOrders_Task_record_marked_codes_token;
begin
   rxGoods.CloseOpen;
  rxOrders.CloseOpen;
  rxMarcCodes.CloseOpen;

  rxTaskGoods.Filtered:=false;
  rxMarcCodes.Filtered:=false;

  O:=TOrders.Create;
  O.LoadFromFile(DemoDataFolder + 'orders.xml');
  for NM in O.handbooks.nomencls.record1 do
  begin
    rxGoods.Append;
    rxGoodsIdGoods.AsString:=NM.id_goods;
    rxGoodsName.AsString:=NM.name;
    rxGoodsIdMeasure.AsString:=NM.id_measure;
    rxGoodsIdVidnomencl.AsString:=NM.id_vidnomencl;
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

  for T in O.Task do
  begin
    rxOrders.Append;
    rxOrdersIdDoc.AsString:=T.id_doc;
    //rxOrdersDate.AsDateTime:=StrToDateTime(T.Date);
    rxOrdersTaskType.AsString:=T.type1;
    rxOrdersDateOrder.AsDateTime:=StrToDateTime(T.date_order);
    rxOrdersFC.AsString:=T.FC;
    rxOrdersIdSclad.AsString:=T.id_sclad;
    //rxOrdersIdDoc.AsString:=T.Goods:TTaskGoods read FGoods;
    rxOrdersLastOrder.AsInteger:=T.last_order;
    rxOrders.Post;

    for G in T.record1 do
    begin
      rxTaskGoods.Append;
      rxTaskGoodsIdDoc.AsString:=T.id_doc;
      rxTaskGoodsIdChar.AsString:=G.id_char;
      rxTaskGoodsIdGoods.AsString:=G.id_goods;
      rxTaskGoodsQuantity.AsString:=G.property1.serial.quantity;
      rxTaskGoods.Post;

      for M in G.marked_codes.token do
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

