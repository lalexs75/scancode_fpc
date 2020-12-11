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

unit mtMainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, EditBtn, DB, rxdbgrid, rxmemds, RxIniPropStorage, ScancodeMT,
  frmUsersAndRightUnit, frmStocksUnit, frmDocumentsUnit,
  frmCharacteristicUnit, frmTSDOrderUnit,  DividerBevel, GetData, GetDocum,
  GetProd_1_answer, GetProd_1, PutDocum, GetStock, GetUsers;

type

  { TmtMainForm }

  TmtMainForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CLabel: TLabel;
    DividerBevel1: TDividerBevel;
    DividerBevel2: TDividerBevel;
    FileNameEdit1: TFileNameEdit;
    Label2: TLabel;
    Memo1: TMemo;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    Panel1: TPanel;
    RxIniPropStorage1: TRxIniPropStorage;
    ScancodeMT1: TScancodeMT;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScancodeMT1DictionaryList(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord; const Dictionary: TDocument);
    procedure ScancodeMT1DocumentsList(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord; const Documents: TDocuments);
    procedure ScancodeMT1GetProd1(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord; const AQuery: GetProd_1.TTable;
      const AAnswer: GetProd_1_answer.TTable);
    procedure ScancodeMT1OrdersList(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord; const Orders: TOrders);
    procedure ScancodeMT1Status(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord);
    procedure ScancodeMT1StocksList(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord; const Stocks: TStocks);
    procedure ScancodeMT1UserList(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord; const UserInfo: TInformation);
  private
    FUsersAndRight: TfrmUsersAndRightFrame;
    FStocksFrame: TfrmStocksFrame;
    FCharacteristicFrame: TfrmCharacteristicFrame;
    FDocumentsFrame: TfrmDocumentsFrame;
    procedure UpdateBtnStates1;
  public

  end;

var
  mtMainForm: TmtMainForm;

procedure MDefaultWriteLog( ALogType:TEventType; const ALogMessage:string);
implementation
uses rxlogging, ScancodeMT_API, ScancodeMT_utils, frmProtocol1CUnit;

{$R *.lfm}

procedure MDefaultWriteLog( ALogType:TEventType; const ALogMessage:string);
begin
  if Assigned(mtMainForm) then
    mtMainForm.Memo1.Lines.Add(ALogMessage);
  RxDefaultWriteLog(ALogType, ALogMessage);
end;

{ TmtMainForm }

procedure TmtMainForm.FormCreate(Sender: TObject);
var
  F:TFrame;
begin
  FileNameEdit1.FileName:=mtlibScanCode_MobileTerminal_FileName;
  Memo1.Lines.Clear;

  FUsersAndRight:=TfrmUsersAndRightFrame.Create(Self);
  FUsersAndRight.Parent:=TabSheet3;
  FUsersAndRight.Align:=alClient;
  FUsersAndRight.GenerateData;

  FStocksFrame:=TfrmStocksFrame.Create(Self);
  FStocksFrame.Parent:=TabSheet4;
  FStocksFrame.Align:=alClient;
  FStocksFrame.GenerateData;

  FCharacteristicFrame:=TfrmCharacteristicFrame.Create(Self);
  FCharacteristicFrame.Parent:=TabSheet6;
  FCharacteristicFrame.Align:=alClient;
  FCharacteristicFrame.GenerateData;

  FDocumentsFrame:=TfrmDocumentsFrame.Create(Self);
  FDocumentsFrame.Parent:=TabSheet5;
  FDocumentsFrame.Align:=alClient;
  FDocumentsFrame.GenerateData;


  F:=TfrmTSDOrderFrame.Create(Self);
  F.Parent:=TabSheet7;
  F.Align:=alClient;
  TfrmTSDOrderFrame(F).GenerateData;


  F:=TfrmProtocol1CFrame.Create(Self);
  F.Parent:=TabSheet2;
  F.Align:=alClient;

  UpdateBtnStates1;
end;

procedure TmtMainForm.ScancodeMT1DictionaryList(Sender: TScancodeMT;
  const AMessage: TMTQueueRecord; const Dictionary: TDocument);
begin
//  FCharacteristicFrame.CreateDictionarys(Dictionary);
end;

procedure TmtMainForm.ScancodeMT1DocumentsList(Sender: TScancodeMT;
  const AMessage: TMTQueueRecord; const Documents: TDocuments);
var
  S: String;
begin
  S:=FUsersAndRight.GetUserName(NormalaizeGUID(AMessage.UserID));
  FDocumentsFrame.CreateDocsList(Documents, S, 1);
  AMessage.Confirm:='1';
end;

procedure TmtMainForm.ScancodeMT1GetProd1(Sender: TScancodeMT;
  const AMessage: TMTQueueRecord; const AQuery: GetProd_1.TTable;
  const AAnswer: GetProd_1_answer.TTable);
begin
(*  if AQuery.Record1.Count>0 then
  begin
    FCharacteristicFrame.rxGoods.Filtered:=false;
    AAnswer.GoodQuantity.IdGoods:=AQuery.GoodList[0].IdGoods;

    if FCharacteristicFrame.rxGoods.Locate('GOODS_ID', AQuery.GoodList[0].IdGoods, []) then
      AAnswer.GoodQuantity.Quantity:=FloatToStr(FCharacteristicFrame.rxGoodsGOODS_COUNTED.AsFloat)
    else
      AAnswer.GoodQuantity.Quantity:='0';
    FCharacteristicFrame.rxGoods.Filtered:=true;
  end; *)
end;

procedure TmtMainForm.ScancodeMT1OrdersList(Sender: TScancodeMT;
  const AMessage: TMTQueueRecord; const Orders: TOrders);
{var
  T: TTask;
  G: TTaskGood;}
begin
{  for T in Orders.Tasks do
  begin
    if FDocumentsFrame.rxTasks.Locate('IdDoc', T.IdDoc, []) then
    begin
      FDocumentsFrame.rxTasks.Edit;
      FDocumentsFrame.rxTasksCOMPLETED.AsBoolean:=True;
      FDocumentsFrame.rxTasks.Post;

      for G in T.Goods do
      begin
        if FDocumentsFrame.rxGoods.Locate('ID_GOODS', G.IdGoods, []) then
        begin
          FDocumentsFrame.rxGoods.Edit;
          FDocumentsFrame.rxGoodsCOMPLETED.AsBoolean:=true;
          FDocumentsFrame.rxGoodsBARCODE.AsString:=G.GoodMarking.DATAMATRIX + ';';
          FDocumentsFrame.rxGoods.Post;
        end;
      end;
    end;
  end;
  AMessage.Confirm:='1'; }
end;

procedure TmtMainForm.Button1Click(Sender: TObject);
begin
  ScancodeMT1.MTLibrary.LibraryName:=FileNameEdit1.FileName;
  ScancodeMT1.Active:=true;
  UpdateBtnStates1;
end;

procedure TmtMainForm.Button2Click(Sender: TObject);
begin
  ScancodeMT1.Active:=false;
  UpdateBtnStates1;
end;

procedure TmtMainForm.ScancodeMT1Status(Sender: TScancodeMT;
  const AMessage: TMTQueueRecord);
begin
  RxWriteLog(etDebug, #13'-------------------------------------------');
  RxWriteLog(etDebug, 'Process command : %s', [AMessage.Command]);
  RxWriteLog(etDebug, 'Confirm : %s; DocType : %s; FileName : %s; PackgeNumber : %s; Serial : %s; UserID : %s; UserIP : %s; Version : %s',
    [AMessage.Confirm, AMessage.DocType, AMessage.FileName, AMessage.PackgeNumber, AMessage.Serial, AMessage.UserID, AMessage.UserIP, AMessage.Version]);
end;

procedure TmtMainForm.ScancodeMT1StocksList(Sender: TScancodeMT;
  const AMessage: TMTQueueRecord; const Stocks: TStocks);
begin
  FStocksFrame.CreateStocksInfo(Stocks);
end;

procedure TmtMainForm.ScancodeMT1UserList(Sender: TScancodeMT;
  const AMessage: TMTQueueRecord; const UserInfo: TInformation);
begin
  FUsersAndRight.CreateUserInfo(UserInfo);
end;

procedure TmtMainForm.UpdateBtnStates1;
begin
  Button1.Enabled:=not ScancodeMT1.Active;
  Button2.Enabled:=ScancodeMT1.Active;
end;

end.

