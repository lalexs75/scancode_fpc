unit frmProtocol1CUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, SynEdit,
  SynHighlighterXML;

type

  { TfrmProtocol1CFrame }

  TfrmProtocol1CFrame = class(TFrame)
    Button1: TButton;
    Panel1: TPanel;
    SynEdit1: TSynEdit;
    SynXMLSyn1: TSynXMLSyn;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

implementation
uses protocol1C, scGlobal;
{$R *.lfm}

{ TfrmProtocol1CFrame }

procedure TfrmProtocol1CFrame.Button1Click(Sender: TObject);
var
  P: Tprotocol1C;
begin
  P:=Tprotocol1C.Create;
  P.LoadFromFile(DemoDataFolder + 'protocolc1.xml');
  SynEdit1.Text:=P.fileNameTSD[0].stringXML;
  P.Free;
end;

end.

