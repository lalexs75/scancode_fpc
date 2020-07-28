{ interface library for FPC and Lazarus
  Copyright (C) 2019-2020 Lagunov Aleksey alexs75@yandex.ru

  Дополнительные утилиты и class helpers


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

unit tsd_api_utils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, GetData, PutDocum;

type

  TDocument_table_recordHelper = class helper for TDocument_table_record
    procedure LoadImage(AFileName:string);
  end;

  { TOrders_handbooks_nomencls_recordHelper }

  TOrders_handbooks_nomencls_recordHelper = class helper for TOrders_handbooks_nomencls_record
    procedure SaveImageToFile(AImageFileName: string);
  end;

implementation
uses base64;

{ TOrders_handbooks_nomencls_recordHelper }

procedure TOrders_handbooks_nomencls_recordHelper.SaveImageToFile(
  AImageFileName: string);
var
  SD: String;
  Instream: TStringStream;
  Decoder: TBase64DecodingStream;
  Outstream: TFileStream;
begin
  if (Bitmap<>'') then
  begin
    SD:=Bitmap;
    while Length(Sd) mod 4 > 0 do SD := SD + '=';
    Instream:=TStringStream.Create(SD);
    try
      Outstream:=TFileStream.Create(AImageFileName, fmOpenWrite + fmCreate);
      try
(*        if strict then
          Decoder:=TBase64DecodingStream.Create(Instream,bdmStrict)
        else *)
          Decoder:=TBase64DecodingStream.Create(Instream,bdmMIME);
        try
          Outstream.CopyFrom(Decoder,Decoder.Size);
        finally
          Decoder.Free;
        end;
      finally
        Outstream.Free;
      end;
    finally
      Instream.Free;
    end;
  end;
end;

{ TDocument_table_recordHelper }

procedure TDocument_table_recordHelper.LoadImage(AFileName: string);
var
  F: TFileStream;
  FS: TStringStream;
  Encoder: TBase64EncodingStream;
begin
  F:=TFileStream.Create(AFileName, fmOpenRead);
  FS:=TStringStream.Create;
  try
    Encoder:=TBase64EncodingStream.create(FS);
    try
      Encoder.CopyFrom(F, 0);
    finally
      Encoder.Free;
    end;
    Bitmap:=FS.DataString;
    Img:=ExtractFileName(AFileName);
  finally
    F.Free;
    FS.Free;
  end;
end;

end.

