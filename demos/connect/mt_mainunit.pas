unit mt_mainunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn,
  Spin, ComCtrls, ExtCtrls, ScancodeMT, xmlobject, RxIniPropStorage, scancode_user_api, scancode_characteristics_api, scancode_document_api, scancode_stock_api;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    btnLoad: TButton;
    btnUnload: TButton;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    FileNameEdit1: TFileNameEdit;
    Label1: TLabel;
    Label2: TLabel;
    CLabel: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    RxIniPropStorage1: TRxIniPropStorage;
    ScancodeMT1: TScancodeMT;
    SpinEdit1: TSpinEdit;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    procedure btnLoadClick(Sender: TObject);
    procedure btnUnloadClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ScancodeMT1DictionaryList(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord; const Dictionary: TDictionary);
    procedure ScancodeMT1DocumentsList(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord; const Documents: TDocuments);
    procedure ScancodeMT1StocksList(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord; const Stocks: TStocks);
    procedure ScancodeMT1UserList(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord; const UserInfo: TUserInformation);
    procedure Timer1Timer(Sender: TObject);
  private
    FLibrary: TScancodeMTLibrary;
    FLastErrorCode:Integer;
    FLastErrorStr:string;
    FServerStarted:boolean;
    procedure UpdateErrorCode;
    procedure GetLibVersion;
    procedure GetProtoVersion;
    procedure StartServer;
    procedure StopServer;
    procedure SetCallback;
    procedure SendAnswer(const Command:string; const Data:TXmlSerializationObject);

    procedure UpdateBtnStates;

    procedure UpdateBtnStates1;

  private
    FCurCommand:string;
    Confirm: String;
    DocType: String;
    FileName: String;
    PackgeNumber: String;
    Serial: String;
    UserID: String;
    UserIP: String;
    Version: String;

    procedure ParseExtendeInfo(AInfo:string);
    procedure DoSendUserList;
    procedure DoSendDocsList;
    procedure DoSendGetData;
    procedure DoSendGetProd;
    procedure DoSendGetStock;

    procedure DoGetPutDocum;
  private
    procedure FillUserList(const U: TUserInformation);
    procedure FillDictList(const Dic: TDictionary);
    procedure FillDocList(Doc:TDocuments);
    procedure FillStocksList(Stocks: TStocks);
  public

  end;

var
  Form1: TForm1;

procedure MDefaultWriteLog( ALogType:TEventType; const ALogMessage:string);
implementation
uses rxlogging, ScancodeMT_API, scancode_tsd_order_api;

{$R *.lfm}
procedure MDefaultWriteLog( ALogType:TEventType; const ALogMessage:string);
begin
  if Assigned(Form1) then
    Form1.Memo1.Lines.Add(ALogMessage);
  RxDefaultWriteLog(ALogType, ALogMessage);
end;

function F_RequestCallback(const Param1:PChar; const Param2:PChar):TMTLong; cdecl;
var
  I: Integer;
  S1, S2: String;
begin
  Result:=0;

  S1:=StrPas(Param1);
  S2:=StrPas(Param2);
  RxDefaultWriteLog(etDebug, Format('S1=%s || S2=%s', [S1, S2]));

  if not Assigned(Form1) then Exit;
  Form1.ParseExtendeInfo(S2);

  Form1.FCurCommand:=S1;
  Form1.Timer1.Enabled:=true;
  //Form1.Timer1Timer(nil);
end;

{ TForm1 }

procedure TForm1.btnStartClick(Sender: TObject);
begin
  FLibrary.LoadMTLibrary;
  if FLibrary.Loaded then
  begin

    GetLibVersion;
    GetProtoVersion;

    SetCallback;

    StartServer;


  end;

  UpdateBtnStates;
end;

procedure TForm1.btnUnloadClick(Sender: TObject);
begin
  if FLibrary.Loaded then
  begin
    RxWriteLog(etDebug, 'Try to unload library');
    FLibrary.Unload;
  end
  else
    RxWriteLog(etError, 'Library not loaded');
  UpdateBtnStates;
end;

procedure TForm1.btnLoadClick(Sender: TObject);
begin
  if FileExists(FileNameEdit1.Text) then
  begin
    FLibrary.LibraryName:=FileNameEdit1.Text;
    RxWriteLog(etDebug, 'Try to load file "%s"', [FileNameEdit1.Text]);
    FLibrary.LoadMTLibrary;
    if FLibrary.Loaded then
      RxWriteLog(etDebug, 'Success.')
    else
      RxWriteLog(etDebug, 'Error.');
  end
  else
    RxWriteLog(etError, 'File "%s" not found', [FileNameEdit1.Text]);
  UpdateBtnStates;
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  if FLibrary.Loaded then
    StopServer;
  UpdateBtnStates;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ScancodeMT1.MTLibrary.LibraryName:=FileNameEdit1.FileName;
  ScancodeMT1.Active:=true;
  UpdateBtnStates1;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ScancodeMT1.Active:=false;
  UpdateBtnStates1;
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  UpdateBtnStates;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SpinEdit1.Value:=mtDefaultPort;
  Memo1.Lines.Clear;
  FileNameEdit1.FileName:=mtlibScanCode_MobileTerminal_FileName;
  FLibrary:=TScancodeMTLibrary.Create;
  FServerStarted:=false;
  UpdateBtnStates;
  UpdateBtnStates1;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Form1:=nil;
end;

procedure TForm1.ScancodeMT1DictionaryList(Sender: TScancodeMT;
  const AMessage: TMTQueueRecord; const Dictionary: TDictionary);
begin
  FillDictList(Dictionary);
end;

procedure TForm1.ScancodeMT1DocumentsList(Sender: TScancodeMT;
  const AMessage: TMTQueueRecord; const Documents: TDocuments);
begin
  FillDocList(Documents);
end;

procedure TForm1.ScancodeMT1StocksList(Sender: TScancodeMT;
  const AMessage: TMTQueueRecord; const Stocks: TStocks);
begin
  FillStocksList(Stocks);
end;

procedure TForm1.ScancodeMT1UserList(Sender: TScancodeMT;
  const AMessage: TMTQueueRecord; const UserInfo: TUserInformation);
begin
  FillUserList(UserInfo);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=false;

  RxWriteLog(etDebug, #13'-------------------------------------------');
  RxWriteLog(etDebug, 'Process command : %s', [FCurCommand]);
  RxWriteLog(etDebug, 'Confirm := '+Confirm);
  RxWriteLog(etDebug, 'DocType := '+DocType);
  RxWriteLog(etDebug, 'FileName := '+FileName);
  RxWriteLog(etDebug, 'PackgeNumber := '+PackgeNumber);
  RxWriteLog(etDebug, 'Serial := '+Serial);
  RxWriteLog(etDebug, 'UserID := '+UserID);
  RxWriteLog(etDebug, 'UserIP := '+UserIP);
  RxWriteLog(etDebug, 'Version := '+Version);

  if FCurCommand = 'GetUsers' then //Получить список пользователей
    DoSendUserList
  else
  if FCurCommand = 'GetDocum' then // Получить документы
    DoSendDocsList
  else
  if FCurCommand = 'GetData' then // Получить список всех товаров
    DoSendGetData
  else
  if FCurCommand = 'PutDocum' then // Передача ордеров
    DoGetPutDocum
  else
  if FCurCommand = 'GetProd' then // Получить информацию о товаре
    DoSendGetProd
  else
(*  if FCurCommand = 'CreateProd' then
  begin
    // Создать товар
  end
  else*)
  if FCurCommand = 'GetStock' then
    DoSendGetStock // Получить информацию по складам
  else
    raise EScancodeMTLibrary.CreateFmt('Unknow command %s', [FCurCommand]);

end;

procedure TForm1.UpdateErrorCode;
var
  Ar:array [1..2000] of Char;
begin
  FillChar(Ar, SizeOf(Ar), 0);
  FLastErrorCode:=FLibrary.GetLastError(@Ar[1]);
  FLastErrorStr:=StrPas(@Ar[1]);
  RxWriteLog(etDebug, 'GetLastError = %d (%s)', [FLastErrorCode, FLastErrorStr])
end;

procedure TForm1.GetLibVersion;
var
  V: LongInt;
begin
  V:=FLibrary.GetProtocolVersion(0);
  RxWriteLog(etDebug, 'GetProtocolVersion = %d', [V]);

  UpdateErrorCode;
end;

procedure TForm1.GetProtoVersion;
var
  Major, Minor, Patch, Build: TMTLong;
begin
  FLibrary.GetVersion(Major, Minor, Patch, Build);
  RxWriteLog(etDebug, 'GetVersion: Major=%d, Minor=%d, Patch=%d, Build=%d', [Major, Minor, Patch, Build]);

  UpdateErrorCode;
end;

procedure TForm1.StartServer;
var
  V: LongInt;
  S: String;
begin
  if CheckBox1.Checked then
  begin
    RxWriteLog(etDebug, 'Try to start server on default port');
    S:='StartServerDefault';
    V:=FLibrary.StartServerDefault;
  end
  else
  begin
    RxWriteLog(etDebug, 'Try to start server on port %d', [SpinEdit1.Value]);
    S:='StartServer';
    V:=FLibrary.StartServer(SpinEdit1.Value);
  end;
  FServerStarted:= V = 1;
  RxWriteLog(etDebug, '%s : %d', [S, V]);
  UpdateErrorCode;
end;

procedure TForm1.StopServer;
var
  V: LongInt;
begin
  V:=FLibrary.StopServer;
  if FServerStarted and (V=1) then
    FServerStarted:=false;
  RxWriteLog(etDebug, 'StopServer : %d', [V]);
  UpdateErrorCode;
end;

procedure TForm1.SetCallback;
begin
  FLibrary.SetRequestCallback(@F_RequestCallback);
  RxWriteLog(etDebug, 'SetRequestCallback');
  UpdateErrorCode;
end;

procedure TForm1.SendAnswer(const Command: string;
  const Data: TXmlSerializationObject);
var
  Ex: TExtendedInformation;
  FTmpFileName, S: String;
begin
  if Assigned(Data) then
  begin
    FTmpFileName:=GetTempFileName;
    Data.SaveToFile(FTmpFileName);
  end
  else
    FTmpFileName:='';

  Ex:=TExtendedInformation.Create;

  Ex.Confirm:=Confirm;
  Ex.DocType:=DocType;
  Ex.FileName:=FTmpFileName;
  Ex.PackgeNumber:=PackgeNumber;
  Ex.Serial:=Serial;
  Ex.UserID:=UserID;
  Ex.UserIP:=UserIP;
  Ex.Version:=Version;
  S:=Ex.SaveToStr;
  Ex.Free;

  RxWriteLog(etDebug, Format('SendAnswer : %s '#13'%s'#13, [Command, S]));
  FLibrary.SendAnswer(PChar(Command), PChar(S));
  UpdateErrorCode;
end;

procedure TForm1.UpdateBtnStates;
begin
  btnLoad.Enabled:=not FLibrary.Loaded;
  btnUnload.Enabled:=FLibrary.Loaded;

  btnStop.Enabled:=FLibrary.Loaded and FServerStarted;
  btnStart.Enabled:=FLibrary.Loaded and not FServerStarted;

  Label3.Enabled:=(not CheckBox1.Checked) and not FServerStarted;
  SpinEdit1.Enabled:=(not CheckBox1.Checked) and not FServerStarted;

  if FLibrary.Loaded then
    StatusBar1.Panels[0].Text:='Loaded'
  else
    StatusBar1.Panels[0].Text:='Unloaded';

  if FServerStarted then
    StatusBar1.Panels[1].Text:='Server started'
  else
    StatusBar1.Panels[1].Text:='Server stoped';
end;

procedure TForm1.UpdateBtnStates1;
begin
  Button1.Enabled:=not ScancodeMT1.Active;
  Button2.Enabled:=ScancodeMT1.Active;
end;

procedure TForm1.ParseExtendeInfo(AInfo: string);
var
  Ex: TExtendedInformation;
begin
  Ex:=TExtendedInformation.Create;
  Ex.LoadFromStr(AInfo);

  Confirm:=Ex.Confirm;
  DocType:=Ex.DocType;
  FileName:=Ex.FileName;
  PackgeNumber:=Ex.PackgeNumber;
  Serial:=Ex.Serial;
  UserID:=Ex.UserID;
  UserIP:=Ex.UserIP;
  Version:=Ex.Version;

  Ex.Free;
end;

procedure TForm1.DoSendUserList;
var
  U: TUserInformation;
begin
  U:=TUserInformation.Create;
  FillUserList(U);

  SendAnswer('GetUsers', U);
  U.Free;
end;

procedure TForm1.DoSendDocsList;
var
  Doc: TDocuments;
begin
  Doc:=TDocuments.Create;
  FillDocList(Doc);
  SendAnswer('GetDocum', Doc);
  Doc.Free;
end;

procedure TForm1.DoSendGetData;
var
  Dic: TDictionary;
begin
  Dic:=TDictionary.Create;
  FillDictList(Dic);

  SendAnswer('GetData', Dic);
  Dic.Free;
end;

procedure TForm1.DoSendGetProd;
var
  Q: TQueryGoods;
begin
  if FileName <> '' then
  begin
    Q:=TQueryGoods.Create;
    Q.LoadFromFile(FileName);

    //SendAnswer('GetProd', Dic);
    Q.Free;
  end;
end;

procedure TForm1.DoSendGetStock;
var
  St: TStocks;
begin
  St:=TStocks.Create;
  FillStocksList(St);
  SendAnswer('GetStock', St);
  St.Free;
end;

procedure TForm1.DoGetPutDocum;
var
  O: TOrders;
begin
  if FileName <> '' then
  begin
    O:=TOrders.Create;
    O.LoadFromFile(FileName);
    O.Free;
    Confirm:='1';
    SendAnswer('PutDocum', nil);
  end;
end;

procedure TForm1.FillUserList(const U: TUserInformation);
var
  L: TUserLogin;
  R: TUserRight;
begin
  L:=U.Logins.Records.CreateChild;
    L.Id:='USER_ID_0001';
    L.Login:='Лагунов Алексей Анатольевич';
    L.PasswordDecoded:='';
    L.Rights:='1/2/3/4/5';
    L.CreateProd:='1/2/3/4';
    L.AddProd:='1/2/3/4';
    L.CreateFreeCollect:='1/2/3/4';

  L:=U.Logins.Records.CreateChild;
    L.Id:='USER_ID_0002';
    L.Login:='Харин Андрей';
    L.PasswordDecoded:='123';
    L.Rights:='1/2/3/4/5';
    L.CreateProd:='1/2/3/4';
    L.AddProd:='1/2/3/4';
    L.CreateFreeCollect:='1/2/3/4';

  R:=U.Rights.Records.CreateChild;
    R.Name:='Заказ поставщику';
    R.Id:='101';
    R.groupId:='1';
  R:=U.Rights.Records.CreateChild;
    R.Name:='Заказ клиента';
    R.Id:='202';
    R.groupId:='2';
  R:=U.Rights.Records.CreateChild;
    R.Name:='Инвентаризация';
    R.Id:='303';
    R.groupId:='3';
end;

procedure TForm1.FillDictList(const Dic: TDictionary);
var
  Pck: TPack;
  VN: TNomenclatureType;
  G: TSprGood;
  Br: TBarcode;
  Prc: TPrice;
  M: TMeasure;
begin
  Pck:=Dic.Packs.PackList.CreateChild;
    Pck.IdOwner:='';
    Pck.Relation:='';
    Pck.Name:='шт.';
    Pck.IdPack:='EDIZM-000001';
    Pck.Koeff:='1';

  VN:=Dic.NomenclatureTypes.NomenclatureTypeList.CreateChild;
    VN.IdNomenclatureType:='SPR1-000001';
    VN.Name:='Освещение и эектротовары';
    VN.IsChar:='0';
    VN.IsSerial:='0';

  G:=Dic.SprGoods.SprGoodLists.CreateChild;
    G.IdGoods:='SPR3-000001';
    G.Name:='Лампочка 1/23*ыв';
    G.Art:='130005';
    G.Alco:='0';
    G.IdVidnomencl:='SPR1-000001';
    G.IdNaborPack:='';
    G.Img:='';
    G.Bitmap:='';
    Br:=Dic.Barcodes.BarcodeList.CreateChild;
      Br.IdGoods:=G.IdGoods;
      Br.Barcode:='2000000010510';

  Prc:=Dic.Prices.PriceList.CreateChild;
    Prc.IdGoods:='SPR3-000001';
    Prc.Price:='166.00';
    Prc.Currency:='руб';

  G:=Dic.SprGoods.SprGoodLists.CreateChild;
    G.IdGoods:='SPR3-000002';
    G.Name:='Батарейка ЭРА АА 1ю3';
    G.Art:='130006';
    G.Alco:='0';
    G.IdVidnomencl:='SPR1-000001';
    G.IdNaborPack:='';
    G.Img:='';
    G.Bitmap:='';
    Br:=Dic.Barcodes.BarcodeList.CreateChild;
    Br.IdGoods:=G.IdGoods;
    Br.Barcode:='2000000010511';
  Prc:=Dic.Prices.PriceList.CreateChild;
    Prc.IdGoods:='SPR3-000002';
    Prc.Price:='200.4';
    Prc.Currency:='руб';


(*  Ch:=Dic.Characteristics.CharacteristicList.CreateChild;
    Ch.IdOwner:='bd72d913-55bc-11d9-848a-00112f43529a';
    Ch.Relation:='видыноменклатуры';
    Ch.Name:='38, Бежевый, 6, натуральная кожа';
    Ch.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';

  Pck:=Dic.Packs.PackList.CreateChild;
    Pck.IdOwner:='bd72d913-55bc-11d9-848a-00112f43529a';
    Pck.Relation:='';
    Pck.Name:='пар';
    Pck.IdPack:='bd72d90f-55bc-11d9-848a-00112f43529a';
    Pck.Koeff:='1';

  Sr:=Dic.Serials.SerialList.CreateChild;
    Sr.IdOwner:='e8a71fbf-55bc-11d9-848a-00112f43529a';
    Sr.Relation:='';
    Sr.Name:='до 20.12.16';
    Sr.IdSerial:='0ed9fc88-d9fe-11e4-92f1-0050568b35ac';
    Sr.Num:='';
    Sr.Date:='2016-12-20T00:00:00';

  Br:=Dic.Barcodes.BarcodeList.CreateChild;
    Br.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
    Br.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
    Br.IdPack:='';
    Br.Barcode:='2000000000480';
  Br:=Dic.Barcodes.BarcodeList.CreateChild;
    Br.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
    Br.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
    Br.IdPack:='f0e40f7b-7390-11df-b338-0011955cba6b';
    Br.Barcode:='2000000000497';
  Br:=Dic.Barcodes.BarcodeList.CreateChild;
    Br.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
    Br.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
    Br.IdPack:='f0e40f7d-7390-11df-b338-0011955cba6b';
    Br.Barcode:='2000000000503';
  Br:=Dic.Barcodes.BarcodeList.CreateChild;
    Br.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
    Br.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
    Br.IdPack:='dff7f708-7a0b-11df-b33a-0011955cba6b';
    Br.Barcode:='2000000000510';
*)

  M:=Dic.Measures.MeasureList.CreateChild;
    M.IdMeasure:='bd72d90f-55bc-11d9-848a-00112f43529a';
    M.Name:='пар';
(*
  Prc:=Dic.Prices.PriceList.CreateChild;
    Prc.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
    Prc.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
    Prc.IdPack:='dff7f708-7a0b-11df-b33a-0011955cba6b';
    Prc.Price:='8166.4';
    Prc.Currency:='руб';

  VN:=Dic.NomenclatureTypes.NomenclatureTypeList.CreateChild;
    VN.IdNomenclatureType:='9c556d55-720f-11df-b436-0015e92f2802';
    VN.Name:='Холодильники';
    VN.IsChar:='0';
    VN.IsSerial:='0';
  VN:=Dic.NomenclatureTypes.NomenclatureTypeList.CreateChild;
    VN.IdNomenclatureType:='9c556d52-720f-11df-b436-0015e92f2802';
    VN.Name:='Электротовары';
    VN.IsChar:='0';
    VN.IsSerial:='0';

  Skld:=Dic.Sclads.ScladList.CreateChild;
    Skld.IdSclad:='abf5870d-f5c8-11e2-802f-0015e9b8c48d';
    Skld.Name:='Домодедовская таможня';
    Skld.IsAdress:='0';
    Skld.IsOrder:='0';
  Skld:=Dic.Sclads.ScladList.CreateChild;
    Skld.IdSclad:='abf58710-f5c8-11e2-802f-0015e9b8c48d';
    Skld.Name:='Внуковская таможня';
    Skld.IsAdress:='0';
    Skld.IsOrder:='0';
*)
end;

procedure TForm1.FillDocList(Doc: TDocuments);
var
  D: TDocument;
  G: TGood;
  GC: TGoodCell;
begin
  (*    D:=DD.Documents.CreateChild;
      D.Task.Barcode:='24088173807114864056976259793525333272';
      D.Task.Date:='18.09.2018 0:00:00';
      D.Task.UseAdress:='1';
      D.Task.Control:='0';
      D.Task.TypeDoc:='103';
      D.Task.Nomer:='00-00000001';
      D.Task.IdDoc:='121f36a9-837d-11e8-ba4d-50465d72dd18';
      D.Task.IdZone:='';
      D.Task.IdRoom:='148249978629133692556415878208956447339';
      D.Task.IdStock:='148249978153764717470829852647692745323';
      G:=D.Task.Goods.CreateChild;
      G.IdChar:='b02e2809-720f-11df-b436-0015e92f2802';
      G.IdGoods:='bd72d913-55bc-11d9-848a-00112f43529a';
      G.Quantity:='1';
      G.GoodProperty.IdPack:='dff7f708-7a0b-11df-b33a-0011955cba6b';
      G.GoodProperty.SerialVar:='0:001';
      G.GoodProperty.Quantity:='1';
      G.GoodProperty.GoodSerial.Quantity:='1';
      G.GoodProperty.GoodSerial.IdSerial:='';
      GC:=G.GoodProperty.GoodSerial.GoodCells.CreateChild;
      GC.Cell:='305982541796071806599496327226965408363';
      GC.CellAddress:='ОСТ3-2-1';
  *)
    //Документ продаж
    D:=Doc.Documents.CreateChild;
      D.Task.Barcode:='S100010023';
      D.Task.Date:=FormatDateTime('dd.mm.yyyy', Now);
      D.Task.UseAdress:='1';
      D.Task.Control:='1';
      D.Task.TypeDoc:='201';
      D.Task.Nomer:='00000002';
      D.Task.IdDoc:='TBDOC-00101011';
      D.Task.IdZone:='';
      D.Task.IdRoom:='R01000001';
      D.Task.IdStock:='SKLD-000001';

      G:=D.Task.Goods.CreateChild;
      G.IdGoods:='SPR3-000001';
      G.Quantity:='1';
      G.GoodProperty.IdPack:='EDIZM-000001';
      G.GoodProperty.Quantity:='1';
      GC:=G.GoodProperty.GoodSerial.GoodCells.CreateChild;
      GC.Cell:='CELL-000001-000001-000001';
      GC.CellAddress:='Ул 1 Этаж 1 Яч 1';

      G:=D.Task.Goods.CreateChild;
      G.IdGoods:='SPR3-000002';
      G.Quantity:='10';
      G.GoodProperty.IdPack:='EDIZM-000001';
      G.GoodProperty.Quantity:='10';
      GC:=G.GoodProperty.GoodSerial.GoodCells.CreateChild;
      GC.Cell:='CELL-000001-000001-000001';
      GC.CellAddress:='Ул 1 Этаж 1 Яч 11`';

    //Документ инвентаризации
    D:=Doc.Documents.CreateChild;
      D.Task.Barcode:='S0010101000';
      D.Task.Date:=FormatDateTime('dd.mm.yyyy', Now);
      D.Task.UseAdress:='1';
      D.Task.Control:='0';
      D.Task.TypeDoc:='301';
      D.Task.Nomer:='00000002';
      D.Task.IdDoc:='TBDOC-00101010';
      D.Task.IdZone:='';
      D.Task.IdRoom:='R01000001';
      D.Task.IdStock:='SKLD-000001';
      G:=D.Task.Goods.CreateChild;
      G.IdGoods:='SPR3-000001';
      G.Quantity:='1';
      G.GoodProperty.IdPack:='EDIZM-000001';
      G.GoodProperty.Quantity:='1';
      GC:=G.GoodProperty.GoodSerial.GoodCells.CreateChild;
      GC.Cell:='CELL-000001-000001-000001';
      GC.CellAddress:='Ул 1 Этаж 1 Яч 1';
end;

procedure TForm1.FillStocksList(Stocks: TStocks);
var
  S: TStock;
  R: TRoom;
  C: TCell;
begin
  S:=Stocks.Stocks.CreateChild;
    S.Barcode:='148249978';
    S.IdStock:='6f87e83f-722c-11df-b336-0011955cba6b';
    S.Name:='Центральный склад';
  R:=S.Rooms.CreateChild;
    R.Barcode:='148249978';
    R.IdRoom:='6f87e842-722c-11df-b336-0011955cba6b';
    R.Name:='Продукты';
  C:=R.Cells.CreateChild;
    C.Barcode:='262838176';
    C.IdCell:='c5bcca8d-44ca-11e0-af0b-0015e9b8c48d';
    C.Name:='П-А2-12';
  C:=R.Cells.CreateChild;
    C.barcode:='262838177';
    C.IdCell:='4dd6daf4-44ca-11e0-af0b-0015e9b8c48d';
    C.Name:='П-А3';


  S:=Stocks.Stocks.CreateChild;
    S.Barcode:='S01000001';
    S.IdStock:='SKLD-000001';
    S.Name:='Склад №1';
  R:=S.Rooms.CreateChild;
    R.Barcode:='R01000001';
    R.IdRoom:='ROOM-000001-000001';
    R.Name:='Ангар № 1';
  C:=R.Cells.CreateChild;
    C.Barcode:='С0101000001';
    C.IdCell:='CELL-000001-000001-000001';
    C.Name:='Ул 1 Этаж 1 Яч 1';
  C:=R.Cells.CreateChild;
    C.barcode:='С0101000002';
    C.IdCell:='CELL-000001-000001-000002';
    C.Name:='Ул 1 Этаж 1 Яч 2';
end;

end.

