unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ScancodeMT;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Memo1: TMemo;
    ScancodeMT1: TScancodeMT;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FLibrary: TScancodeMTLibrary;
    FLastErrorCode:Integer;
    FLastErrorStr:string;
    procedure UpdateErrorCode;
    procedure GetLibVersion;
    procedure GetProtoVersion;
    procedure StartServer;
    procedure StopServer;
    procedure SetCallback;

    procedure UpdateBtnStates;
  public

  end;

var
  Form1: TForm1;

implementation
uses rxlogging, ScancodeMT_API;

{$R *.lfm}

function F_RequestCallback(const Param1:PChar; const Param2:PChar):TMTLong; cdecl;
var
  I: Integer;
  S1, S2: String;
begin
  Result:=0;

  if Assigned(Form1) then
  begin
    S1:=StrPas(Param1);
    S2:=StrPas(Param2);
    Form1.Memo1.Lines.Add('S1='+S1 + '  S2='+S2);
  end;
end;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  FLibrary.LoadMTLibrary;
  if FLibrary.Loaded then
  begin
    Label1.Caption:='Loaded';

    GetLibVersion;
    GetProtoVersion;

    StartServer;

    SetCallback;

  end
  else
    Label1.Caption:='Error lib loaded';

  UpdateBtnStates;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if FLibrary.Loaded then
  begin

    StopServer;

    FLibrary.Unload;
    FLibrary.Free;
  end;

  UpdateBtnStates;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FLibrary:=TScancodeMTLibrary.Create;
  {$IFDEF WINDOWS}
  FLibrary.LibraryName:='C:\2\' + mtlibScanCode_MobileTerminal_FileName;
  {$ELSE}
  FLibrary.LibraryName:='/home/work/demos/Test_Trade/Demo_07_Scancode/' + mtlibScanCode_MobileTerminal_FileName;
  {$ENDIF}

  UpdateBtnStates;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Form1:=nil;
end;

procedure TForm1.UpdateErrorCode;
var
  Ar:array [1..2000] of Char;
begin
  FillChar(Ar, SizeOf(Ar), 0);
  FLastErrorCode:=FLibrary.GetLastError(@Ar[1]);
  FLastErrorStr:=StrPas(@Ar[1]);
  Memo1.Lines.Add(Format('GetLastError = %d (%s)', [FLastErrorCode, FLastErrorStr]));
  RxWriteLog(etDebug, 'GetLastError = %d (%s)', [FLastErrorCode, FLastErrorStr])
end;

procedure TForm1.GetLibVersion;
var
  V: LongInt;
begin
  V:=FLibrary.GetProtocolVersion(0);
  Memo1.Lines.Add('GetProtocolVersion = '+IntToStr(V));
  RxWriteLog(etDebug, 'GetProtocolVersion = %d', [V]);

  UpdateErrorCode;
end;

procedure TForm1.GetProtoVersion;
var
  Major, Minor, Patch, Build: TMTLong;
begin
  FLibrary.GetVersion(Major, Minor, Patch, Build);
  Memo1.Lines.Add(Format('GetVersion: Major=%d, Minor=%d, Patch=%d, Build=%d', [Major, Minor, Patch, Build]));
  RxWriteLog(etDebug, 'GetVersion: Major=%d, Minor=%d, Patch=%d, Build=%d', [Major, Minor, Patch, Build]);

  UpdateErrorCode;
end;

procedure TForm1.StartServer;
var
  V: LongInt;
begin
  V:=FLibrary.StartServer(1122);
  //V:=FLibrary.StartServerDefault;
  Memo1.Lines.Add('StartServerDefault: '+IntToStr(V));
  RxWriteLog(etDebug, 'StartServerDefault: '+IntToStr(V));

  UpdateErrorCode;
end;

procedure TForm1.StopServer;
var
  V: LongInt;
begin
  repeat
    V:=FLibrary.StopServer;
    Memo1.Lines.Add('StopServer: '+IntToStr(V));
    RxWriteLog(etDebug, 'StopServer: '+IntToStr(V));

    UpdateErrorCode;
  until V <> 0;
end;

procedure TForm1.SetCallback;
begin
  FLibrary.SetRequestCallback(@F_RequestCallback);
  Memo1.Lines.Add('SetRequestCallback');
  RxWriteLog(etDebug, 'SetRequestCallback');
  UpdateErrorCode;
end;

procedure TForm1.UpdateBtnStates;
begin
  Button2.Enabled:=FLibrary.Loaded;
  Button1.Enabled:=not FLibrary.Loaded;
end;

end.

