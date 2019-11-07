unit frmDocumentsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls;

type

  { TfrmDocumentsFrame }

  TfrmDocumentsFrame = class(TFrame)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

  public
    procedure GenerateData;
  end;

implementation
uses scancode_document_api, scGlobal;

{$R *.lfm}

{ TfrmDocumentsFrame }

procedure TfrmDocumentsFrame.Button1Click(Sender: TObject);
var
  Docs: TDocuments;
  D: TDocument;
  G: TGood;
  GC: TGoodCell;
begin
  Docs:=TDocuments.Create;

  D:=Docs.Documents.CreateChild;
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
  G.GoodProperty.Quantity:='1';
  G.GoodProperty.IdPack:='dff7f708-7a0b-11df-b33a-0011955cba6b';
  G.GoodProperty.GoodSerial.IdSerial:='934F6882-9D0A-4F05-82C2-2A131C452107';
  G.GoodProperty.GoodSerial.Quantity:='1';

  GC:=G.GoodProperty.GoodSerial.GoodCells.CreateChild;
  GC.Cell:='305982541796071806599496327226965408363';
  GC.CellAddress:='ОСТ3-2-1';

  Docs.SaveToFile(ExportFolder + 'Documents.xml');
  Docs.Free;
end;

procedure TfrmDocumentsFrame.GenerateData;
begin

end;

end.

