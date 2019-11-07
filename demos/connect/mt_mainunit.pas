unit mt_mainunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn,
  Spin, ComCtrls, ExtCtrls, ScancodeMT, RxIniPropStorage;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    btnLoad: TButton;
    btnUnload: TButton;
    CheckBox1: TCheckBox;
    FileNameEdit1: TFileNameEdit;
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
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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
    procedure SendAnswer(const Command:string; const Data:String);

    procedure UpdateBtnStates;
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
    function DoSendUserList:string;
    procedure DoSendDocsList;
  public

  end;

var
  Form1: TForm1;

procedure MDefaultWriteLog( ALogType:TEventType; const ALogMessage:string);
implementation
uses rxlogging, ScancodeMT_API, scancode_user_api, scancode_document_api;

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
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Form1:=nil;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=false;
  if FCurCommand = 'GetUsers' then
  begin
    //- Получить список пользователей
    DoSendUserList;
  end
  else
  if FCurCommand = 'GetDocum' then
  begin
    // Получить документы
    DoSendDocsList;
  end
  else
  if FCurCommand = 'GetData' then
  begin
    // Получить список всех товаров
  end
  else
  if FCurCommand = 'PutDocum' then
  begin
    // Передача ордеров
  end
  else
  if FCurCommand = 'GetProd' then
  begin
    // Получить информацию о товаре
  end
  else
  if FCurCommand = 'CreateProd' then
  begin
    // Создать товар
  end
{  else
    raise EScancodeMTLibrary.CreateFmt('Unknow command %s', [S1]);}

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

procedure TForm1.SendAnswer(const Command: string; const Data: String);
var
  TT, S: String;
  TTF: TFileStream;
  Ex: TExtendedInformation;
begin
  TT:=GetTempFileName;
  TTF:=TFileStream.Create(TT, fmCreate);
  if Data<>'' then
    TTF.Write(Data[1], Length(Data));
  TTF.Free;

  Ex:=TExtendedInformation.Create;

  Ex.Confirm:=Confirm;
  Ex.DocType:=DocType;
  Ex.FileName:=TT;
  Ex.PackgeNumber:=PackgeNumber;
  Ex.Serial:=Serial;
  Ex.UserID:=UserID;
  Ex.UserIP:=UserIP;
  Ex.Version:=Version;
  S:=Ex.SaveToStr;
  Ex.Free;

  RxDefaultWriteLog(etDebug, Format('SendAnswer : %s '#13'%s'#13, [Command, S]));
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

  MDefaultWriteLog(etDebug, 'Confirm := '+Confirm);
  MDefaultWriteLog(etDebug, 'DocType := '+DocType);
  MDefaultWriteLog(etDebug, 'FileName := '+FileName);
  MDefaultWriteLog(etDebug, 'PackgeNumber := '+PackgeNumber);
  MDefaultWriteLog(etDebug, 'Serial := '+Serial);
  MDefaultWriteLog(etDebug, 'UserID := '+UserID);
  MDefaultWriteLog(etDebug, 'UserIP := '+UserIP);
  MDefaultWriteLog(etDebug, 'Version := '+Version);
end;

function TForm1.DoSendUserList: string;
var
  U: TUserInformation;
  L: TUserLogin;
  R: TUserRight;
begin
  U:=TUserInformation.Create;

  L:=U.Logins.Records.CreateChild;
    //L.Id:='USER_ID_0001';
    L.Id:='8368e8b098294ae292bd8d4ddd658d9a';
    L.Login:='Лагунов Алексей Анатольевич';
    L.PasswordDecoded:='';
    L.Rights:='1/2/3/4/5';
    L.CreateProd:='1/2/3/4';
    L.AddProd:='1/2/3/4';
    L.CreateFreeCollect:='1/2/3/4';

  L:=U.Logins.Records.CreateChild;
    L.Id:='USER_ID_0001';
    //L.Id:='8368e8b098294ae292bd8d4ddd658d9a';
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

  Result:=U.SaveToStr;

  SendAnswer('GetUsers', Result);

  U.Free;

end;

procedure TForm1.DoSendDocsList;
var
  DD: TDocuments;
  D: TDocument;
begin
  DD:=TDocuments.Create;
    D:=DD.Documents.CreateChild;
    D.Task.Barcode:='24088173807114864056976259793525333272'
    D.Task.Date:='18.09.2018 0:00:00';
    D.Task.UseAdress:='1';
    D.Task.Control:='0'
    D.Task.TypeDoc:='103';
    D.Task.Nomer:='00-00000001';
    D.Task.IdDoc:='121f36a9-837d-11e8-ba4d-50465d72dd18';
    D.Task.IdZone:='';
    D.Task.IdRoom:='148249978629133692556415878208956447339';
    D.Task.IdSclad="148249978153764717470829852647692745323">
  <table>
  <record id_char="b02e2809-720f-11df-b436-0015e92f2802" id_goods="bd72d913-55bc-11d9-848a-
  00112f43529a" quantity=”1”>
  <property id_pack="dff7f708-7a0b-11df-b33a-0011955cba6b" serial_var="0:001"
  quantity=”1”>
  <serial quantity="1" id_serial="">
  <cells cell="305982541796071806599496327226965408363"
  celladdress="ОСТ3-2-1"/>
  </serial>
  </property>
  </record>
  </table>
  </Task>
  </Document>
  </Documents>

  S:=DD.SaveToStr;
  SendAnswer('GetDocum', S);
  DD.Free;    *)
end;

end.

