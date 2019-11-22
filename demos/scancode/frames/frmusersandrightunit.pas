unit frmUsersAndRightUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, DB, rxdbgrid, rxmemds, scancode_user_api;

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
    function CreateUserInfo(UI:TUserInformation):TUserInformation;
  end;

implementation
uses scGlobal;
{$R *.lfm}

{ TfrmUsersAndRightFrame }

procedure TfrmUsersAndRightFrame.Button1Click(Sender: TObject);
var
  U: TUserInformation;
  E: TExtendedInformation;
begin
  U:=CreateUserInfo(nil);

  U.SaveToFile(ExportFolder + 'sc_ui.xml');
  U.Free;

  E:=TExtendedInformation.Create;
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
  rxUsers.AppendRecord(['98FA15A4-E0C4-432B-A8BC-5564C82888F4', 'Иванов Иван Иванович', '123321123', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', true, true, true, true, true]);
  rxUsers.AppendRecord(['2ECFBCAE-A230-4BC4-9F2A-840E838391F5', 'Петров Пётр Перович', '123321123', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', true, true, true, true, true]);
  rxUsers.AppendRecord(['8F8FB2C3-A450-4FD6-B129-8590B62C7D9F', 'Сидоров Сидор Сидорович', '123321123', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', true, true, true, true, true]);
  rxUsers.AppendRecord(['F4B044DC-2906-45B3-9268-E74E82EDFA27', 'Орлов Александр Владимирович', '123321123', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', true, true, true, true, true]);
  rxUsers.AppendRecord(['6FD83876-CD80-491F-9785-EF564AE84149', 'Пушкин Александр Сергеевич', '123321123', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', '1/2/3/4/5', true, true, true, true, true]);
  rxUsers.First;

  rxRight.CloseOpen;
  rxRight.AppendRecord(['Заказ поставщику', '101', '1']);
  rxRight.AppendRecord(['Заказ клиента', '202', '2']);
  rxRight.AppendRecord(['Инвентаризация', '303', '3']);
  rxRight.First;
end;

function TfrmUsersAndRightFrame.CreateUserInfo(UI: TUserInformation
  ): TUserInformation;
var
  L: TUserLogin;
  S: String;
  i: Integer;
  R: TUserRight;
begin
  if Assigned(UI) then
    Result:=UI
  else
    Result:=TUserInformation.Create;

  rxUsers.First;
  while not rxUsers.EOF do
  begin
    L:=Result.Logins.Records.CreateChild;
    L.Id:=rxUsersID.AsString;
    L.Login:=rxUsersLogin.AsString;
    L.PasswordDecoded:=rxUsersPassword.AsString;
    //L.Pass:=rxUsersPassword.AsString;

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
    L.CreateFreeCollect:=rxUsersCreateFreeCollect.AsString;
    rxUsers.Next;
  end;
  rxUsers.First;


  rxRight.First;
  while not rxRight.EOF do
  begin
    R:=Result.Rights.Records.CreateChild;
    R.Name:=rxRightName.AsString;
    R.Id:=rxRightID.AsString;
    R.groupId:=rxRightGroupId.AsString;
    rxRight.Next;
  end;
  rxRight.First;
end;

end.

