{ interface library for FPC and Lazarus
  Copyright (C) 2019-2020 Lagunov Aleksey alexs75@yandex.ru

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

unit ScancodeMT_consts;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

resourcestring
  sCantLoadProc = 'Can''t load procedure "%s"';
  sOnlyOneInstanse = 'Only one instanse of TScancodeMT allowed';

  sIsNotUserGUID                        = '%s is not user GUID';
  sIsNotStockGUID                       = '%s is not stock GUID';
  sIsNotRoomGUID                        = '%s is not room GUID';
  sIsNotCellGUID                        = '%s is not cell GUID';
  sIsNotDocumentGUID                    = '%s is not document GUID';
  sIsNotDocumentInitialMarksGUID        = '%s is not document initial marks GUID';
  sIsNotDocumentIntMoveGUID             = '%s is not document internal move GUID';
  sIsNotGoodsGUID                       = '%s is not goods GUID';
  sIsNotmeasureGUID                     = '%s is not measure GUID';
  sIsNotNomenclatureGUID                = '%s is not nomenclature GUID';
  sIsNotPackGUID                        = '%s is not pack GUID';
  sIsNotSerialsGUID                     = '%s is not serials GUID';

implementation

end.

