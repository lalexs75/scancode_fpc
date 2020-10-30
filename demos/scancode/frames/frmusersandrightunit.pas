unit frmUsersAndRightUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, DB, rxdbgrid, rxmemds,
  AbstractSerializationObjects,
  GetUsers;

type

  { TfrmUsersAndRightFrame }

  TfrmUsersAndRightFrame = class(TFrame)
    Button1: TButton;
    dsUsers: TDataSource;
    dsRight: TDataSource;
    Panel1: TPanel;
    RxDBGrid1: TRxDBGrid;
    RxDBGrid2: TRxDBGrid;
    rxRightGroupId: TStringField;
    rxRightID: TStringField;
    rxRightName: TStringField;
    rxUsers: TRxMemoryData;
    rxRight: TRxMemoryData;
    rxUsersAddProd: TStringField;
    rxUsersCreateFreeCollect: TStringField;
    rxUsersCreateProd: TStringField;
    rxUsersID: TStringField;
    rxUsersLogin: TStringField;
    rxUsersPassword: TStringField;
    rxUsersR1: TBooleanField;
    rxUsersR2: TBooleanField;
    rxUsersR3: TBooleanField;
    rxUsersR4: TBooleanField;
    rxUsersR5: TBooleanField;
    rxUsersR6: TBooleanField;
    rxUsersR7: TBooleanField;
    rxUsersRights: TStringField;
    Splitter1: TSplitter;
    procedure Button1Click(Sender: TObject);
  private

  public
    procedure GenerateData;
    function CreateUserInfo(UI:TInformation):TInformation;
    function GetUserName(AUserGUID:string):string;
  end;

implementation
uses scGlobal, ScancodeMT_utils, protocol1C;

{$R *.lfm}

{ TfrmUsersAndRightFrame }

procedure TfrmUsersAndRightFrame.Button1Click(Sender: TObject);
var
  U: TInformation;
  E: Tprotocol1C;
begin
  U:=CreateUserInfo(nil);

  U.SaveToFile(ExportFolder + 'sc_ui.xml');
  U.Free;

  E:=Tprotocol1C.Create;
  E.Confirm:='confimed';
  E.DocType:='order';
  E.fileName:='tst.txt';
  E.PackgeNumber:='1234';
  E.Serial:='SN-123-321';
  E.UserID:='D2043489-6386-4D9A-8CC1-A91B2FDF7680';
  E.UserIP:='127.0.0.1';
  E.Version:='1.2.3.4';
  E.SaveToFile(ExportFolder + 'ext.xml');
  E.Free;
end;

procedure TfrmUsersAndRightFrame.GenerateData;
begin
  rxUsers.CloseOpen;
  rxUsers.AppendRecord([UserIDToGUID(1), 'Иванов Иван Иванович', '123', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', true, true, true, true, true]);
  rxUsers.AppendRecord([UserIDToGUID(2), 'Петров Пётр Перович', '123321123', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', true, true, true, true, true]);
  rxUsers.AppendRecord([UserIDToGUID(3), 'Сидоров Сидор Сидорович', '123321123', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', true, true, true, true, true]);
  rxUsers.AppendRecord([UserIDToGUID(4), 'Орлов Александр Владимирович', '123321123', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', true, true, true, true, true]);
  rxUsers.AppendRecord([UserIDToGUID(5), 'Пушкин Александр Сергеевич', '123321123', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', true, true, true, true, true]);
  rxUsers.First;

  rxRight.CloseOpen;
  rxRight.AppendRecord(['Заказ поставщику', '101', '1']);
  rxRight.AppendRecord(['Заказ клиента', '202', '2']);
  rxRight.AppendRecord(['Инвентаризация', '303', '3']);
  rxRight.First;
end;

function TfrmUsersAndRightFrame.CreateUserInfo(UI: TInformation): TInformation;
(*var
  L: TInformation_Login_Record;
  S: String;
  i: Integer;
  R: TInformation_Rights_Record;
  LUI: TInformation;
  L1: TInformation_Login_Record;*)
begin
  if Assigned(UI) then
    Result:=UI
  else
    Result:=TInformation.Create;
(*
  LUI:=TInformation.Create;
  rxUsers.First;
  while not rxUsers.EOF do
  begin
    L:=Result.Login.Record1.AddItem;
    L1:=LUI.Login.Record1.AddItem;

    L.Id:=rxUsersID.AsString;
    L.Login:=rxUsersLogin.AsString;
    L.Pass:=EncodePassword(rxUsersPassword.AsString);

    L1.Id:=rxUsersID.AsString;
    L1.Login:=rxUsersLogin.AsString;
    L1.Pass:=L.Pass;

    S:='';
    for i:=1 to 7 do
      if rxUsers.FieldByName('R'+IntToStr(i)).AsBoolean then
      begin
        if S<>'' then S:=S + '/';
        S:=S + IntToStr(i);
      end;

    L.Rights:=S; //rxUsersRights.AsString;
    L.CreateProd:=rxUsersCreateProd.AsString;
    L.AddProd:=rxUsersAddProd.AsString;
    L.create_free_collect:=rxUsersCreateFreeCollect.AsString;

    L1.Rights:=S;
    L1.createprod:=rxUsersCreateProd.AsString;
    L1.addprod:=rxUsersAddProd.AsString;
    L1.create_free_collect:=rxUsersCreateFreeCollect.AsString;
    rxUsers.Next;
  end;
  rxUsers.First;


  rxRight.First;
  while not rxRight.EOF do
  begin
    R:=Result.Rights.Record1.AddItem;
    R.Name:=rxRightName.AsString;
    R.Id:=rxRightID.AsInteger;
    R.groupId:=rxRightGroupId.AsInteger;
    rxRight.Next;
  end;
  rxRight.First;

  LUI.SaveToFile(ExportFolder + 'sc_ui_11.xml');
  LUI.Free;
  *)
end;

function TfrmUsersAndRightFrame.GetUserName(AUserGUID: string): string;
begin
  if rxUsers.Locate('ID', AUserGUID, []) then
    Result:=rxUsersLogin.AsString
  else
    Result:='';
end;

end.

