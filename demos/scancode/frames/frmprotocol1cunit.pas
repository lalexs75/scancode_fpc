{ interface library for FPC and Lazarus
  Copyright (C) 2019-2020 Lagunov Aleksey alexs75@yandex.ru

  Комплексный пример


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

