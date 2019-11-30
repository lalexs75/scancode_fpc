unit mtMainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, EditBtn, DB, rxdbgrid, rxmemds, RxIniPropStorage, ScancodeMT,
  scancode_user_api, frmUsersAndRightUnit, frmStocksUnit, frmDocumentsUnit,
  frmCharacteristicUnit, frmTSDOrderUnit, scancode_stock_api,
  scancode_characteristics_api, scancode_document_api, scancode_tsd_order_api,
  DividerBevel;

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
      const AMessage: TMTQueueRecord; const Dictionary: TDictionary);
    procedure ScancodeMT1DocumentsList(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord; const Documents: TDocuments);
    procedure ScancodeMT1GetProd1(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord; const AQuery: TQueryGoods1;
      const AAnswer: TGetProdAnswer);
    procedure ScancodeMT1OrdersList(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord; const Orders: TOrders);
    procedure ScancodeMT1Status(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord);
    procedure ScancodeMT1StocksList(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord; const Stocks: TStocks);
    procedure ScancodeMT1UserList(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord; const UserInfo: TUserInformation);
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
uses rxlogging, ScancodeMT_API, ScancodeMT_utils;

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

  UpdateBtnStates1;
end;

procedure TmtMainForm.ScancodeMT1DictionaryList(Sender: TScancodeMT;
  const AMessage: TMTQueueRecord; const Dictionary: TDictionary);
begin
  FCharacteristicFrame.CreateDictionarys(Dictionary);
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
  const AMessage: TMTQueueRecord; const AQuery: TQueryGoods1;
  const AAnswer: TGetProdAnswer);
begin
  if AQuery.GoodList.Count>0 then
  begin
    FCharacteristicFrame.rxGoods.Filtered:=false;
    AAnswer.GoodQuantity.IdGoods:=AQuery.GoodList[0].IdGoods;

    if FCharacteristicFrame.rxGoods.Locate('GOODS_ID', AQuery.GoodList[0].IdGoods, []) then
      AAnswer.GoodQuantity.Quantity:=FloatToStr(FCharacteristicFrame.rxGoodsGOODS_COUNTED.AsFloat)
    else
      AAnswer.GoodQuantity.Quantity:='0';
    FCharacteristicFrame.rxGoods.Filtered:=true;
  end;
end;

procedure TmtMainForm.ScancodeMT1OrdersList(Sender: TScancodeMT;
  const AMessage: TMTQueueRecord; const Orders: TOrders);
var
  T: TTask;
  G: TTaskGood;
begin
  for T in Orders.Tasks do
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
  AMessage.Confirm:='1';
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
  const AMessage: TMTQueueRecord; const UserInfo: TUserInformation);
begin
  FUsersAndRight.CreateUserInfo(UserInfo);
end;

procedure TmtMainForm.UpdateBtnStates1;
begin
  Button1.Enabled:=not ScancodeMT1.Active;
  Button2.Enabled:=ScancodeMT1.Active;
end;

end.

