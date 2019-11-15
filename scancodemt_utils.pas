{ interface library for FPC and Lazarus
  Copyright (C) 2019 Lagunov Aleksey alexs75@yandex.ru

  Вспомогательные функции


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

unit ScancodeMT_utils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

function UserIDToGUID(AId:Integer):string;
function GUIDToUserID(AGUID:string):Integer;

function StockIDToGUID(AId:Integer):string;
function GUIDToStockID(AGUID:string):Integer;

function RoomIDToGUID(AId:Integer):string;
function GUIDToRoomID(AGUID:string):Integer;

function CellIDToGUID(AId:Integer):string;
function GUIDToCellID(AGUID:string):Integer;

function DocIDToGUID(AId:Integer):string;
function GUIDToDocID(AGUID:string):Integer;

function GoodsIDToGUID(AId:Integer):string;
function GUIDToGoodsID(AGUID:string):Integer;

function MeasureIDToGUID(AId:Integer):string;
function GUIDToMeasureID(AGUID:string):Integer;

function NomenclatureIDToGUID(AId:Integer):string;
function GUIDToNomenclatureID(AGUID:string):Integer;

function PackIDToGUID(AId:Integer):string;
function GUIDToPackID(AGUID:string):Integer;


implementation

const
  sUserGUIDBase          = 'FFFFFFFF-FFFF-FFFF-FFFF-';
  sStockGUIDBase         = 'FFFFFFFF-FFFF-FFFF-FFFE-';
  sRoomGUIDBase          = 'FFFFFFFF-FFFF-FFFF-FFFD-';
  sCellGUIDBase          = 'FFFFFFFF-FFFF-FFFF-FFFC-';
  sDocGUIDBase           = 'FFFFFFFF-FFFF-FFFF-FFFB-';
  sGoodsGUIDBase         = 'FFFFFFFF-FFFF-FFFF-FFFA-';
  sMeasureGUIDBase       = 'FFFFFFFF-FFFF-FFFF-FFF9-';
  sNomenclatureGUIDBase  = 'FFFFFFFF-FFFF-FFFF-FFF8-';
  sPackGUIDBase          = 'FFFFFFFF-FFFF-FFFF-FFF7-';

function UserIDToGUID(AId:Integer):string;
begin
  Result:=Format('%s%012.12d', [sUserGUIDBase, AId]);
end;

function GUIDToUserID(AGUID: string): Integer;
begin
  if Copy(AGUID, 1, Length(sUserGUIDBase)) = sUserGUIDBase then
    Result:=StrToInt(Copy(AGUID, Length(sUserGUIDBase)+1, Length(AGUID)))
  else
    raise Exception.CreateFmt('%s is not user GUID', [AGUID]);
end;

function StockIDToGUID(AId: Integer): string;
begin
  Result:=Format('%s%012.12d', [sStockGUIDBase, AId]);
end;

function GUIDToStockID(AGUID: string): Integer;
begin
  if Copy(AGUID, 1, Length(sStockGUIDBase)) = sStockGUIDBase then
    Result:=StrToInt(Copy(AGUID, Length(sStockGUIDBase)+1, Length(AGUID)))
  else
    raise Exception.CreateFmt('%s is not stock GUID', [AGUID]);
end;

function RoomIDToGUID(AId: Integer): string;
begin
  Result:=Format('%s%012.12d', [sRoomGUIDBase, AId]);
end;

function GUIDToRoomID(AGUID: string): Integer;
begin
  if Copy(AGUID, 1, Length(sRoomGUIDBase)) = sRoomGUIDBase then
    Result:=StrToInt(Copy(AGUID, Length(sRoomGUIDBase)+1, Length(AGUID)))
  else
    raise Exception.CreateFmt('%s is not room GUID', [AGUID]);
end;

function CellIDToGUID(AId: Integer): string;
begin
  Result:=Format('%s%012.12d', [sCellGUIDBase, AId]);
end;

function GUIDToCellID(AGUID: string): Integer;
begin
  if Copy(AGUID, 1, Length(sCellGUIDBase)) = sCellGUIDBase then
    Result:=StrToInt(Copy(AGUID, Length(sCellGUIDBase)+1, Length(AGUID)))
  else
    raise Exception.CreateFmt('%s is not cell GUID', [AGUID]);
end;

function DocIDToGUID(AId: Integer): string;
begin
  Result:=Format('%s%012.12d', [sDocGUIDBase, AId]);
end;

function GUIDToDocID(AGUID: string): Integer;
begin
  if Copy(AGUID, 1, Length(sDocGUIDBase)) = sDocGUIDBase then
    Result:=StrToInt(Copy(AGUID, Length(sDocGUIDBase)+1, Length(AGUID)))
  else
    raise Exception.CreateFmt('%s is not document GUID', [AGUID]);
end;

function GoodsIDToGUID(AId: Integer): string;
begin
  Result:=Format('%s%012.12d', [sGoodsGUIDBase, AId]);
end;

function GUIDToGoodsID(AGUID: string): Integer;
begin
  if Copy(AGUID, 1, Length(sGoodsGUIDBase)) = sGoodsGUIDBase then
    Result:=StrToInt(Copy(AGUID, Length(sGoodsGUIDBase)+1, Length(AGUID)))
  else
    raise Exception.CreateFmt('%s is not goods GUID', [AGUID]);
end;

function MeasureIDToGUID(AId: Integer): string;
begin
  Result:=Format('%s%012.12d', [sMeasureGUIDBase, AId]);
end;

function GUIDToMeasureID(AGUID: string): Integer;
begin
  if Copy(AGUID, 1, Length(sMeasureGUIDBase)) = sMeasureGUIDBase then
    Result:=StrToInt(Copy(AGUID, Length(sMeasureGUIDBase)+1, Length(AGUID)))
  else
    raise Exception.CreateFmt('%s is not measure GUID', [AGUID]);
end;

function NomenclatureIDToGUID(AId: Integer): string;
begin
  Result:=Format('%s%012.12d', [sNomenclatureGUIDBase, AId]);
end;

function GUIDToNomenclatureID(AGUID: string): Integer;
begin
  if Copy(AGUID, 1, Length(sNomenclatureGUIDBase)) = sNomenclatureGUIDBase then
    Result:=StrToInt(Copy(AGUID, Length(sNomenclatureGUIDBase)+1, Length(AGUID)))
  else
    raise Exception.CreateFmt('%s is not nomenclature GUID', [AGUID]);
end;

function PackIDToGUID(AId: Integer): string;
begin
  Result:=Format('%s%012.12d', [sPackGUIDBase, AId]);
end;

function GUIDToPackID(AGUID: string): Integer;
begin
  if Copy(AGUID, 1, Length(sPackGUIDBase)) = sPackGUIDBase then
    Result:=StrToInt(Copy(AGUID, Length(sPackGUIDBase)+1, Length(AGUID)))
  else
    raise Exception.CreateFmt('%s is not nomenclature GUID', [AGUID]);
end;

end.

