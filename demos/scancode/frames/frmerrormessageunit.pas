{ interface library for FPC and Lazarus
  Copyright (C) 2019-2021 Lagunov Aleksey alexs75@yandex.ru

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

unit frmErrorMessageUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls;

type

  { TfrmErrorMessageFrame }

  TfrmErrorMessageFrame = class(TFrame)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

implementation
uses tsd_error_msg, scGlobal;
{$R *.lfm}

{ TfrmErrorMessageFrame }

procedure TfrmErrorMessageFrame.Button1Click(Sender: TObject);
var
  E: Terror;
begin
  E:=Terror.Create;
  E.event:=Edit1.Text;
  E.type1:=Edit2.Text;
  E.description:=Memo1.Text;
  E.SaveToFile(ExportFolder + 'error_msg.xml');
  E.Free;
end;

procedure TfrmErrorMessageFrame.Button2Click(Sender: TObject);
var
  E: Terror;
begin
  E:=Terror.Create;
  E.LoadFromFile(ExportFolder + 'error_msg.xml');
  Edit1.Text := E.event;
  Edit2.Text := E.type1;
  Memo1.Text := E.description;
  E.Free;
end;

end.

