unit mtMainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, EditBtn, DB, rxdbgrid, rxmemds, RxIniPropStorage, ScancodeMT,
  scancode_user_api, frmUsersAndRightUnit, frmStocksUnit, frmDocumentsUnit,
  frmCharacteristicUnit, frmTSDOrderUnit;

type

  { TmtMainForm }

  TmtMainForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CLabel: TLabel;
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
    procedure ScancodeMT1Status(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord);
    procedure ScancodeMT1UserList(Sender: TScancodeMT;
      const AMessage: TMTQueueRecord; const UserInfo: TUserInformation);
  private
    FUsersAndRight: TfrmUsersAndRightFrame;
    procedure UpdateBtnStates1;
  public

  end;

var
  mtMainForm: TmtMainForm;

procedure MDefaultWriteLog( ALogType:TEventType; const ALogMessage:string);
implementation
uses rxlogging, ScancodeMT_API;

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

  F:=TfrmStocksFrame.Create(Self);
  F.Parent:=TabSheet4;
  F.Align:=alClient;
  TfrmStocksFrame(F).GenerateData;

  F:=TfrmDocumentsFrame.Create(Self);
  F.Parent:=TabSheet5;
  F.Align:=alClient;
  TfrmDocumentsFrame(F).GenerateData;

  F:=TfrmCharacteristicFrame.Create(Self);
  F.Parent:=TabSheet6;
  F.Align:=alClient;
  TfrmCharacteristicFrame(F).GenerateData;

  F:=TfrmTSDOrderFrame.Create(Self);
  F.Parent:=TabSheet7;
  F.Align:=alClient;
  TfrmTSDOrderFrame(F).GenerateData;

  UpdateBtnStates1;
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

