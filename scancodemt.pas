{ interface library for FPC and Lazarus
  Copyright (C) 2019 Lagunov Aleksey alexs75@yandex.ru

  Генерация xml файлов в формате обеман данными для СКАНКОД.Мобильный Терминал (SCANCODE.MobileTerminal)

  Структуры данных базируются на основании:

  /// \file MobileTerminalAPI.h
  /// \version 1.0.0
  /// \brief API для работы с ПП Сканкод.МобильныйТерминал


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

unit ScancodeMT;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, xmlobject,
  ScancodeMT_API, scancode_user_api, scancode_characteristics_api, scancode_document_api,
  scancode_stock_api, scancode_tsd_order_api
  {$if FPC_FULLVERSION<30006}
  , dynlibs
  {$endif}
  ;

type
  TScancodeMT = class;
  EScancodeMTLibrary = class(Exception);

  { TScancodeMTLibrary }

  TScancodeMTLibrary = class
  private
    FMTLib: TLibHandle;
    FLibraryName: string;

    FMT_GetVersion:TMT_GetVersion;
    FMT_GetProtocolVersion:TMT_GetProtocolVersion;
    FMT_GetLastError:TMT_GetLastError;
    FMT_SetUpdatePath:TMT_SetUpdatePath;
    FMT_SetRequestCallback:TMT_SetRequestCallback;
    FMT_StartServer:TMT_StartServer;
    FMT_StartServerDefault:TMT_StartServerDefault;
    FMT_StopServer:TMT_StopServer;
    FMT_SendAnswer:TMT_SendAnswer;
    function GetLoaded: boolean;
    function IsLibraryNameStored: Boolean;
    procedure InternalClearProcAdress;
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadMTLibrary;
    procedure Unload;
    property Loaded:boolean read GetLoaded;

    function GetProtocolVersion(Version:TMTLong):TMTLong;
    procedure GetVersion(out Major:TMTLong; out Minor:TMTLong; out Patch:TMTLong; out Build:TMTLong);
    function GetLastError(Description:PChar):TMTLong;
    procedure SetUpdatePath(const Path:PChar);
    procedure SetRequestCallback(CallbackFunc:TMT_RequestCallback);
    function StartServer(Port:LongInt):LongInt;
    function StartServerDefault:LongInt;
    function StopServer:LongInt;
    procedure SendAnswer(const Command:PChar; const Data:PChar);
  published
    property LibraryName:string read FLibraryName write FLibraryName stored IsLibraryNameStored;
  end;

  TMTQueueRecord = class
    Command:string;
    Confirm: String;
    DocType: String;
    FileName: String;
    PackgeNumber: String;
    Serial: String;
    UserID: String;
    UserIP: String;
    Version: String;
  end;

  TMTUserListEvent = procedure(Sender:TScancodeMT; const AMessage:TMTQueueRecord; const UserInfo:TUserInformation) of object;
  TMTDictionaryListEvent = procedure(Sender:TScancodeMT; const AMessage:TMTQueueRecord; const Dictionary:TDictionary) of object;
  TMTDocumentsListEvent = procedure(Sender:TScancodeMT; const AMessage:TMTQueueRecord; const Documents:TDocuments) of object;
  TMTStocksListEvent = procedure(Sender:TScancodeMT; const AMessage:TMTQueueRecord; const Stocks:TStocks) of object;
  TMTOrdersListEvent = procedure(Sender:TScancodeMT; const AMessage:TMTQueueRecord; const Orders:TOrders) of object;
  TMTStatusEvent = procedure(Sender:TScancodeMT; const AMessage:TMTQueueRecord) of object;
  //TMTGetProd0Event = procedure(Sender:TScancodeMT; const AQuery:TQueryGoods0; const AMessage:TMTQueueRecord) of object;
  TMTGetProd1Event = procedure(Sender:TScancodeMT; const AMessage:TMTQueueRecord; const AQuery:TQueryGoods1; const AAnswer:TGetProdAnswer) of object;

  TScancodeMT = class(TComponent)
  private
    FActive: boolean;
    FMTLibrary: TScancodeMTLibrary;
    FOnDictionaryList: TMTDictionaryListEvent;
    FOnDocumentsList: TMTDocumentsListEvent;
    FOnGetProd1: TMTGetProd1Event;
    FOnOrdersList: TMTOrdersListEvent;
    FOnStatus: TMTStatusEvent;
    FOnStocksList: TMTStocksListEvent;
    FOnUserList: TMTUserListEvent;
    FPort: Integer;
    FTimer:TTimer;
    FMTQueue:TFpList;
    FCriticalSection : TRTLCriticalSection;
    function IsSetPortStored: Boolean;
    procedure SetActive(AValue: boolean);
    procedure SetPort(AValue: Integer);
    procedure AddMTMessage(const ACommand, AInfo:PChar);
    procedure ClearMTQueue;
    procedure MTTimerQueueTick(Sender: TObject);
    procedure SendAnswer(const Command:string; const Rec: TMTQueueRecord; const Data:TXmlSerializationObject);
  protected
    procedure InternalSendUserInfo;
    procedure InternalProcessMessage(const Rec: TMTQueueRecord);

    procedure InternalSendUserInfo(const Rec: TMTQueueRecord);
    procedure InternalSendDocsList(const Rec: TMTQueueRecord);
    procedure InternalSendGetData(const Rec: TMTQueueRecord);
    procedure InternalSendGetStock(const Rec: TMTQueueRecord);
    procedure InternalSendPutDocum(const Rec: TMTQueueRecord);
    procedure InternalSendGetProd(const Rec: TMTQueueRecord);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartServer;
    procedure StopServer;

    property MTLibrary:TScancodeMTLibrary read FMTLibrary;
    property Active:boolean read FActive write SetActive;
  published
    property Port:Integer read FPort write SetPort stored IsSetPortStored;
    property OnUserList:TMTUserListEvent read FOnUserList write FOnUserList;
    property OnDictionaryList:TMTDictionaryListEvent read FOnDictionaryList write FOnDictionaryList;
    property OnDocumentsList:TMTDocumentsListEvent read FOnDocumentsList write FOnDocumentsList;
    property OnStocksList:TMTStocksListEvent read FOnStocksList write FOnStocksList;
    property OnOrdersList:TMTOrdersListEvent read FOnOrdersList write FOnOrdersList;
    //property OnGetProd0:TMTGetProd0Event read FOnGetProd0 write FOnGetProd0;
    property OnGetProd1:TMTGetProd1Event read FOnGetProd1 write FOnGetProd1;
    property OnStatus:TMTStatusEvent read FOnStatus write FOnStatus;
  end;

procedure Register;

resourcestring
  sCantLoadProc = 'Can''t load procedure "%s"';
  sOnlyOneInstanse = 'Only one instanse of TScancodeMT allowed';

implementation

{$R *.res}
procedure Register;
begin
  RegisterComponents('TradeEquipment',[TScancodeMT]);
end;

var
  FScancodeMT : TScancodeMT = nil;

function F_RequestCallback(const Param1:PChar; const Param2:PChar):TMTLong; cdecl;
begin
  Result:=0;
  if Assigned(FScancodeMT) then
    FScancodeMT.AddMTMessage(Param1, Param2);
end;

{ TScancodeMT }

procedure TScancodeMT.SetPort(AValue: Integer);
begin
  if FPort=AValue then Exit;
  FPort:=AValue;
end;

procedure TScancodeMT.AddMTMessage(const ACommand, AInfo: PChar);
var
  Rec: TMTQueueRecord;
  Ex: TExtendedInformation;
begin
  Rec:=TMTQueueRecord.Create;
  Rec.Command:=ACommand;

  Ex:=TExtendedInformation.Create;
  Ex.LoadFromStr(AInfo);

  Rec.Confirm:=Ex.Confirm;
  Rec.DocType:=Ex.DocType;
  Rec.FileName:=Ex.FileName;
  Rec.PackgeNumber:=Ex.PackgeNumber;
  Rec.Serial:=Ex.Serial;
  Rec.UserID:=Ex.UserID;
  Rec.UserIP:=Ex.UserIP;
  Rec.Version:=Ex.Version;

  Ex.Free;

  EnterCriticalSection(FCriticalSection);
  FMTQueue.Add(Rec);
  LeaveCriticalSection(FCriticalSection);
end;

procedure TScancodeMT.ClearMTQueue;
var
  i: Integer;
begin
  EnterCriticalSection(FCriticalSection);
  for i:=0 to FMTQueue.Count-1 do
    TMTQueueRecord(FMTQueue[i]).Free;
  FMTQueue.Clear;
  LeaveCriticalSection(FCriticalSection);
end;

procedure TScancodeMT.MTTimerQueueTick(Sender: TObject);
var
  Rec: TMTQueueRecord;
begin
  while (FMTQueue.Count>0) do
  begin
    EnterCriticalSection(FCriticalSection);
    Rec:=TMTQueueRecord(FMTQueue[0]);
    FMTQueue.Delete(0);
    LeaveCriticalSection(FCriticalSection);
    InternalProcessMessage(Rec);
    Rec.Free;
  end;
end;

procedure TScancodeMT.SendAnswer(const Command: string;
  const Rec: TMTQueueRecord; const Data: TXmlSerializationObject);
var
  FTmpFileName, S: String;
  Ex: TExtendedInformation;
begin
  if Assigned(Data) then
  begin
    FTmpFileName:=GetTempFileName;
    Data.SaveToFile(FTmpFileName);
  end
  else
    FTmpFileName:='';

  Ex:=TExtendedInformation.Create;

  Ex.Confirm:=Rec.Command;
  Ex.DocType:=Rec.DocType;
  Ex.FileName:=FTmpFileName;
  Ex.PackgeNumber:=Rec.PackgeNumber;
  Ex.Serial:=Rec.Serial;
  Ex.UserID:=Rec.UserID;
  Ex.UserIP:=Rec.UserIP;
  Ex.Version:=Rec.Version;
  S:=Ex.SaveToStr;
  Ex.Free;

  FMTLibrary.SendAnswer(PChar(Command), PChar(S));
end;

procedure TScancodeMT.InternalSendUserInfo;
var
  U: TUserInformation;
  S: String;
begin
  U:=TUserInformation.Create;
  if Assigned(FOnUserList) then;
  S:=U.SaveToStr;
  U.Free;
end;

procedure TScancodeMT.InternalProcessMessage(const Rec: TMTQueueRecord);
begin
  if Assigned(FOnStatus) then
    FOnStatus(Self, Rec);

  if Rec.Command = 'GetUsers' then //Получить список пользователей
    InternalSendUserInfo(Rec)
  else
  if Rec.Command = 'GetDocum' then // Получить документы
    InternalSendDocsList(Rec)
  else
  if Rec.Command = 'GetData' then // 3 - Получить список всех товаров
    InternalSendGetData(Rec)
  else
  if Rec.Command = 'PutDocum' then // Передача ордеров
    InternalSendPutDocum(Rec)
  else
  if Rec.Command = 'GetProd' then // 10 - Получить информацию о товаре
    InternalSendGetProd(Rec)
  else
  (*if FCurCommand = 'CreateProd' then
  begin
    // Создать товар
  end
  else *)
  if Rec.Command = 'GetStock' then
    InternalSendGetStock(Rec) // Получить информацию по складам
  else
    raise EScancodeMTLibrary.CreateFmt('Unknow command %s', [Rec.Command]);

end;

procedure TScancodeMT.InternalSendUserInfo(const Rec: TMTQueueRecord);
var
  U: TUserInformation;
begin
  U:=TUserInformation.Create;
  if Assigned(FOnUserList) then
    FOnUserList(Self, Rec, U);
  SendAnswer('GetUsers',  Rec, U);
  U.Free;
end;

procedure TScancodeMT.InternalSendDocsList(const Rec: TMTQueueRecord);
var
  Doc: TDocuments;
begin
  Doc:=TDocuments.Create;
  if Assigned(FOnDocumentsList) then
    FOnDocumentsList(Self, Rec, Doc);
  SendAnswer('GetDocum', Rec, Doc);
  Doc.Free;
end;

procedure TScancodeMT.InternalSendGetData(const Rec: TMTQueueRecord);
var
  Dic: TDictionary;
begin
  Dic:=TDictionary.Create;
  if Assigned(FOnDictionaryList) then
    FOnDictionaryList(Self, Rec, Dic);
  SendAnswer('GetData', Rec, Dic);
  Dic.Free;
end;

procedure TScancodeMT.InternalSendGetStock(const Rec: TMTQueueRecord);
var
  Stocks: TStocks;
begin
  Stocks:=TStocks.Create;
  if Assigned(FOnStocksList) then
    FOnStocksList(Self, Rec, Stocks);
  SendAnswer('GetStock', Rec, Stocks);
  Stocks.Free;
end;

procedure TScancodeMT.InternalSendPutDocum(const Rec: TMTQueueRecord);
var
  Orders: TOrders;
begin
  Orders:=TOrders.Create;
  if Assigned(FOnOrdersList) then
    FOnOrdersList(Self, Rec, Orders);
  SendAnswer('PutDocum', Rec, nil);
  Orders.Free;
end;

procedure TScancodeMT.InternalSendGetProd(const Rec: TMTQueueRecord);
var
  FQuery1: TQueryGoods1;
  FAnswer1: TGetProdAnswer;
begin

  if Rec.DocType = '0' then
  begin
(*  Orders:=TOrders.Create;
  if Assigned(FOnOrdersList) then
    FOnOrdersList(Self, Rec, Orders);
  SendAnswer('PutDocum', Rec, nil);
  Orders.Free;*)
  end
  else
  begin
    FQuery1:=TQueryGoods1.Create;
    FAnswer1:=TGetProdAnswer.Create;

    if Rec.FileName <> '' then;
      FQuery1.LoadFromFile(Rec.FileName);
    if Assigned(OnGetProd1) then
      OnGetProd1(Self, Rec, FQuery1, FAnswer1);
    SendAnswer('GetProd', Rec, FAnswer1);

    FQuery1.Free;
    FAnswer1.Free;
  end;
end;

function TScancodeMT.IsSetPortStored: Boolean;
begin
  Result:=FPort = mtDefaultPort;
end;

procedure TScancodeMT.SetActive(AValue: boolean);
begin
  if FActive=AValue then Exit;
  if AValue then
    StartServer
  else
    StopServer;
  FActive:=AValue;
end;

constructor TScancodeMT.Create(AOwner: TComponent);
begin
  if Assigned(FScancodeMT) then
    raise EScancodeMTLibrary.Create(sOnlyOneInstanse);
  inherited Create(AOwner);
  InitCriticalSection(FCriticalSection);
  FPort:=mtDefaultPort;
  FScancodeMT:=Self;
  FMTLibrary:=TScancodeMTLibrary.Create;
  FTimer:=TTimer.Create(nil);
  FTimer.Enabled:=false;
  FTimer.Interval:=300;
  FTimer.OnTimer:=@MTTimerQueueTick;
  FMTQueue:=TFpList.Create;
end;

destructor TScancodeMT.Destroy;
begin
  Active:=false;
  FTimer.Enabled:=false;
  ClearMTQueue;
  FreeAndNil(FTimer);
  FreeAndNil(FMTLibrary);
  FreeAndNil(FMTQueue);
  FScancodeMT:=nil;
  DoneCriticalSection(FCriticalSection);
  inherited Destroy;
end;

procedure TScancodeMT.StartServer;
var
  V: LongInt;
begin
  if not FMTLibrary.Loaded then
    FMTLibrary.LoadMTLibrary;


  FMTLibrary.SetRequestCallback(@F_RequestCallback);
  if FPort = mtDefaultPort then
    V:=FMTLibrary.StartServerDefault
  else
    V:=FMTLibrary.StartServer(FPort);
  //FServerStarted:= V = 1;
  if V = 1 then
    FTimer.Enabled:=true;
end;

procedure TScancodeMT.StopServer;
var
  V: LongInt;
begin
  FTimer.Enabled:=false;
  V:=FMTLibrary.StopServer;
  ClearMTQueue;
//  if FServerStarted and (V=1) then
//    FServerStarted:=false;
end;

{ TScancodeMTLibrary }

function TScancodeMTLibrary.GetLoaded: boolean;
begin
  Result := FMTLib <> NilHandle;
end;

function TScancodeMTLibrary.IsLibraryNameStored: Boolean;
begin
  Result:=FLibraryName = mtlibScanCode_MobileTerminal_FileName;
end;

procedure TScancodeMTLibrary.InternalClearProcAdress;
begin
  FMT_GetProtocolVersion:=nil;
  FMT_GetVersion:=nil;
  FMT_GetLastError:=nil;
  FMT_SetUpdatePath:=nil;
  FMT_SetRequestCallback:=nil;
  FMT_StartServer:=nil;
  FMT_StartServerDefault:=nil;
  FMT_StopServer:=nil;
  FMT_SendAnswer:=nil;
end;

constructor TScancodeMTLibrary.Create;
begin
  inherited Create;
  InternalClearProcAdress;
  FLibraryName:=mtlibScanCode_MobileTerminal_FileName
end;

destructor TScancodeMTLibrary.Destroy;
begin
  Unload;
  inherited Destroy;
end;

procedure TScancodeMTLibrary.LoadMTLibrary;
function DoGetProcAddress(Lib: TLibHandle; Name: string): Pointer;
begin
  Result := GetProcedureAddress(Lib, Name);
  if not Assigned(Result) then
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, [Name]);
end;
begin
  FMTLib := LoadLibrary(PChar(FLibraryName));

  if Loaded then
  begin
    FMT_GetProtocolVersion := TMT_GetProtocolVersion(DoGetProcAddress(FMTLib, 'MT_GetProtocolVersion'));
    FMT_GetVersion:=TMT_GetVersion(DoGetProcAddress(FMTLib, 'MT_GetVersion'));
    FMT_GetLastError:=TMT_GetLastError(DoGetProcAddress(FMTLib, 'MT_GetLastError'));
    FMT_SetUpdatePath:=TMT_SetUpdatePath(DoGetProcAddress(FMTLib, 'MT_SetUpdatePath'));
    FMT_SetRequestCallback:=TMT_SetRequestCallback(DoGetProcAddress(FMTLib, 'MT_SetRequestCallback'));
    FMT_StartServer:=TMT_StartServer(DoGetProcAddress(FMTLib, 'MT_StartServer'));
    FMT_StartServerDefault:=TMT_StartServerDefault(DoGetProcAddress(FMTLib, 'MT_StartServerDefault'));
    FMT_StopServer:=TMT_StopServer(DoGetProcAddress(FMTLib, 'MT_StopServer'));
    FMT_SendAnswer:=TMT_SendAnswer(DoGetProcAddress(FMTLib, 'MT_SendAnswer'));
  end;
end;

procedure TScancodeMTLibrary.Unload;
begin
  if Loaded then
  begin
    UnloadLibrary(FMTLib);
    FMTLib:=NilHandle;
  end;
  InternalClearProcAdress;
end;

function TScancodeMTLibrary.GetProtocolVersion(Version: TMTLong): TMTLong;
begin
  if Assigned(FMT_GetProtocolVersion) then
    Result:=FMT_GetProtocolVersion(Version)
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['MT_GetProtocolVersion']);
end;

procedure TScancodeMTLibrary.GetVersion(out Major: TMTLong; out Minor: TMTLong;
  out Patch: TMTLong; out Build: TMTLong);
begin
  if Assigned(FMT_GetVersion) then
  begin
    FMT_GetVersion(Major, Minor, Patch, Build)
  end
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['MT_GetVersion']);
end;

function TScancodeMTLibrary.GetLastError(Description: PChar): TMTLong;
begin
  if Assigned(FMT_GetLastError) then
    Result:=FMT_GetLastError(Description)
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['MT_GetLastError']);
end;

procedure TScancodeMTLibrary.SetUpdatePath(const Path: PChar);
begin
  if Assigned(FMT_SetUpdatePath) then
    FMT_SetUpdatePath(Path)
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['FMT_SetUpdatePath']);
end;

procedure TScancodeMTLibrary.SetRequestCallback(
  CallbackFunc: TMT_RequestCallback);
begin
  if Assigned(FMT_SetRequestCallback) then
    FMT_SetRequestCallback(CallbackFunc)
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['FMT_SetRequestCallback']);
end;

function TScancodeMTLibrary.StartServer(Port: LongInt): LongInt;
begin
  if Assigned(FMT_StartServer) then
    Result:=FMT_StartServer(Port)
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['FMT_StartServer']);
end;

function TScancodeMTLibrary.StartServerDefault: LongInt;
begin
  if Assigned(FMT_StartServerDefault) then
    Result:=FMT_StartServerDefault()
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['FMT_StartServerDefault']);
end;

function TScancodeMTLibrary.StopServer: LongInt;
begin
  if Assigned(FMT_StopServer) then
    Result:=FMT_StopServer()
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['FMT_StopServer']);
end;

procedure TScancodeMTLibrary.SendAnswer(const Command: PChar; const Data: PChar
  );
begin
  if Assigned(FMT_SendAnswer) then
    FMT_SendAnswer(Command, Data)
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['FMT_SendAnswer']);
end;

end.
