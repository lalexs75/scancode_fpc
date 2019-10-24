unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls, DB,
  rxdbgrid, rxmemds;

type

  { TForm1 }

  TForm1 = class(TForm)
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation
uses frmUsersAndRightUnit, frmStocksUnit, frmDocumentsUnit,
  frmCharacteristicUnit;
{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  F:TFrame;
begin
  F:=TfrmUsersAndRightFrame.Create(Self);
  F.Parent:=TabSheet3;
  F.Align:=alClient;
  TfrmUsersAndRightFrame(F).GenerateData;

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
end;

end.

