unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, DB, rxdbgrid, rxmemds, ScancodeMT;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CLabel: TLabel;
    Memo1: TMemo;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    Panel1: TPanel;
    ScancodeMT1: TScancodeMT;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation
uses frmUsersAndRightUnit, frmStocksUnit, frmDocumentsUnit,
  frmCharacteristicUnit, frmTSDOrderUnit;
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

  F:=TfrmTSDOrderFrame.Create(Self);
  F.Parent:=TabSheet7;
  F.Align:=alClient;
  TfrmTSDOrderFrame(F).GenerateData;
end;

end.

