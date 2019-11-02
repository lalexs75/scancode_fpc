{ interface library for FPC and Lazarus
  Copyright (C) 2019 Lagunov Aleksey alexs75@yandex.ru

  Генерация xml файлов в формате обеман данными для СКАНКОД.Мобильный Терминал (SCANCODE.MobileTerminal)

  Структуры данных базируются на основании:

  /// \file MobileTerminalAPI.h
  /// \version 1.0.0
  /// \brief API для работы с ПП Сканкод.МобильныйТерминал


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

unit ScancodeMT;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ScancodeMT_API
  {$if FPC_FULLVERSION<30006}
  , dynlibs
  {$endif}
  ;

type
  EScancodeMTLibrary = class(Exception);

  { TScancodeMTLibrary }

  TScancodeMTLibrary = class
  private
    FMTLib: TLibHandle;
    FLibraryName: string;

    FMT_GetVersion:TMT_GetVersion;
    FMT_GetProtocolVersion:TMT_GetProtocolVersion;
    FMT_GetLastError:TMT_GetLastError;
    FMT_SetUpdatePath:TMT_SetUpdatePath;
    FMT_SetRequestCallback:TMT_SetRequestCallback;
    FMT_StartServer:TMT_StartServer;
    FMT_StartServerDefault:TMT_StartServerDefault;
    FMT_StopServer:TMT_StopServer;
    FMT_SendAnswer:TMT_SendAnswer;
    function GetLoaded: boolean;
    function IsLibraryNameStored: Boolean;
    procedure InternalClearProcAdress;
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadMTLibrary;
    procedure Unload;
    property Loaded:boolean read GetLoaded;

    function GetProtocolVersion(Version:TMTLong):TMTLong;
    procedure GetVersion(out Major:TMTLong; out Minor:TMTLong; out Patch:TMTLong; out Build:TMTLong);
    function GetLastError(Description:PChar):TMTLong;
    procedure SetUpdatePath(const Path:PChar);
    procedure SetRequestCallback(CallbackFunc:TMT_RequestCallback);
    function StartServer(Port:LongInt):LongInt;
    function StartServerDefault:LongInt;
    function StopServer:LongInt;
    procedure SendAnswer(const Command:PChar; const Data:PChar);
  published
    property LibraryName:string read FLibraryName write FLibraryName stored IsLibraryNameStored;
  end;

  TScancodeMT = class(TComponent)
  private
    FPort: Integer;
    function IsSetPortStored: Boolean;
    procedure SetPort(AValue: Integer);

  protected

  public
    constructor Create(AOwner: TComponent); override;
  published
    property Port:Integer read FPort write SetPort stored IsSetPortStored;
  end;

procedure Register;

resourcestring
  sCantLoadProc = 'Can''t load procedure "%s"';

implementation

{$R *.res}
procedure Register;
begin
  RegisterComponents('TradeEquipment',[TScancodeMT]);
end;

{ TScancodeMT }

procedure TScancodeMT.SetPort(AValue: Integer);
begin
  if FPort=AValue then Exit;
  FPort:=AValue;
end;

function TScancodeMT.IsSetPortStored: Boolean;
begin
  Result:=FPort = mtDefaultPort;
end;

constructor TScancodeMT.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPort:=mtDefaultPort;
end;

{ TScancodeMTLibrary }

function TScancodeMTLibrary.GetLoaded: boolean;
begin
  Result := FMTLib <> NilHandle;
end;

function TScancodeMTLibrary.IsLibraryNameStored: Boolean;
begin
  Result:=FLibraryName = mtlibScanCode_MobileTerminal_FileName;
end;

procedure TScancodeMTLibrary.InternalClearProcAdress;
begin
  FMT_GetProtocolVersion:=nil;
  FMT_GetVersion:=nil;
  FMT_GetLastError:=nil;
  FMT_SetUpdatePath:=nil;
  FMT_SetRequestCallback:=nil;
  FMT_StartServer:=nil;
  FMT_StartServerDefault:=nil;
  FMT_StopServer:=nil;
  FMT_SendAnswer:=nil;
end;

constructor TScancodeMTLibrary.Create;
begin
  inherited Create;
  InternalClearProcAdress;
  FLibraryName:=mtlibScanCode_MobileTerminal_FileName
end;

destructor TScancodeMTLibrary.Destroy;
begin
  Unload;
  inherited Destroy;
end;

procedure TScancodeMTLibrary.LoadMTLibrary;
function DoGetProcAddress(Lib: TLibHandle; Name: string): Pointer;
begin
  Result := GetProcedureAddress(Lib, Name);
  if not Assigned(Result) then
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, [Name]);
end;
begin
  FMTLib := LoadLibrary(PChar(FLibraryName));

  if Loaded then
  begin
    FMT_GetProtocolVersion := TMT_GetProtocolVersion(DoGetProcAddress(FMTLib, 'MT_GetProtocolVersion'));
    FMT_GetVersion:=TMT_GetVersion(DoGetProcAddress(FMTLib, 'MT_GetVersion'));
    FMT_GetLastError:=TMT_GetLastError(DoGetProcAddress(FMTLib, 'MT_GetLastError'));
    FMT_SetUpdatePath:=TMT_SetUpdatePath(DoGetProcAddress(FMTLib, 'MT_SetUpdatePath'));
    FMT_SetRequestCallback:=TMT_SetRequestCallback(DoGetProcAddress(FMTLib, 'MT_SetRequestCallback'));
    FMT_StartServer:=TMT_StartServer(DoGetProcAddress(FMTLib, 'MT_StartServer'));
    FMT_StartServerDefault:=TMT_StartServerDefault(DoGetProcAddress(FMTLib, 'MT_StartServerDefault'));
    FMT_StopServer:=TMT_StopServer(DoGetProcAddress(FMTLib, 'MT_StopServer'));
    FMT_SendAnswer:=TMT_SendAnswer(DoGetProcAddress(FMTLib, 'MT_SendAnswer'));
  end;
end;

procedure TScancodeMTLibrary.Unload;
begin
  if Loaded then
  begin
    UnloadLibrary(FMTLib);
    FMTLib:=NilHandle;
  end;
  InternalClearProcAdress;
end;

function TScancodeMTLibrary.GetProtocolVersion(Version: TMTLong): TMTLong;
begin
  if Assigned(FMT_GetProtocolVersion) then
    Result:=FMT_GetProtocolVersion(Version)
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['MT_GetProtocolVersion']);
end;

procedure TScancodeMTLibrary.GetVersion(out Major: TMTLong; out Minor: TMTLong;
  out Patch: TMTLong; out Build: TMTLong);
begin
  if Assigned(FMT_GetVersion) then
  begin
    FMT_GetVersion(Major, Minor, Patch, Build)
  end
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['MT_GetVersion']);
end;

function TScancodeMTLibrary.GetLastError(Description: PChar): TMTLong;
begin
  if Assigned(FMT_GetLastError) then
    Result:=FMT_GetLastError(Description)
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['MT_GetLastError']);
end;

procedure TScancodeMTLibrary.SetUpdatePath(const Path: PChar);
begin
  if Assigned(FMT_SetUpdatePath) then
    FMT_SetUpdatePath(Path)
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['FMT_SetUpdatePath']);
end;

procedure TScancodeMTLibrary.SetRequestCallback(
  CallbackFunc: TMT_RequestCallback);
begin
  if Assigned(FMT_SetRequestCallback) then
    FMT_SetRequestCallback(CallbackFunc)
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['FMT_SetRequestCallback']);
end;

function TScancodeMTLibrary.StartServer(Port: LongInt): LongInt;
begin
  if Assigned(FMT_StartServer) then
    Result:=FMT_StartServer(Port)
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['FMT_StartServer']);
end;

function TScancodeMTLibrary.StartServerDefault: LongInt;
begin
  if Assigned(FMT_StartServerDefault) then
    Result:=FMT_StartServerDefault()
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['FMT_StartServerDefault']);
end;

function TScancodeMTLibrary.StopServer: LongInt;
begin
  if Assigned(FMT_StopServer) then
    Result:=FMT_StopServer()
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['FMT_StopServer']);
end;

procedure TScancodeMTLibrary.SendAnswer(const Command: PChar; const Data: PChar
  );
begin
  if Assigned(FMT_SendAnswer) then
    FMT_SendAnswer(Command, Data)
  else
    raise EScancodeMTLibrary.CreateFmt(sCantLoadProc, ['FMT_SendAnswer']);
end;

end.
