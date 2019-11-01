unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ScancodeMT;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Memo1: TMemo;
    ScancodeMT1: TScancodeMT;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation
uses ScancodeMT_API;

{$R *.lfm}

function F_RequestCallback(const Param1:PChar; const Param2:PChar):LongInt; cdecl;
var
  I: Integer;
begin
  I:=0;
end;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  FLibrary: TScancodeMTLibrary;
  V, Major, Minor, Patch, Build: LongInt;
  Ar:array [1..2000] of Char;
//  P:PMT_RequestCallback;
//  PT:TMT_RequestCallback;
begin
  Memo1.Lines.Clear;
  FLibrary:=TScancodeMTLibrary.Create;
  FLibrary.LibraryName:='/home/work/demos/Test_Trade/Demo_07_Scancode/' + slibScanCode_MobileTerminal_FileName;
  FLibrary.LoadMTLibrary;
  if FLibrary.Loaded then
  begin
    Label1.Caption:='Loaded';
    V:=FLibrary.GetProtocolVersion(0);
    Memo1.Lines.Add('GetProtocolVersion = '+IntToStr(V));
    FLibrary.GetVersion(Major, Minor, Patch, Build);
    Memo1.Lines.Add(Format('Major=%d, Minor=%d, Patch=%d, Build=%d', [Major, Minor, Patch, Build]));
    FillChar(Ar, SizeOf(Ar), 0);
    V:=FLibrary.GetLastError(@Ar);
    Memo1.Lines.Add('GetLastError = '+IntToStr(V));

//    P:=@PT;
//    PT:=@F_RequestCallback;
//    FLibrary.SetRequestCallback(P);
    FLibrary.SetRequestCallback(@F_RequestCallback);
    FillChar(Ar, SizeOf(Ar), 0);
    V:=FLibrary.GetLastError(@Ar);
    Memo1.Lines.Add('GetLastError = '+IntToStr(V));

    //V:=FLibrary.StartServer(22);
    V:=FLibrary.StartServerDefault;
    Memo1.Lines.Add('StartServerDefault = '+IntToStr(V));
    FillChar(Ar, SizeOf(Ar), 0);
    V:=FLibrary.GetLastError(@Ar);
    Memo1.Lines.Add('GetLastError = '+IntToStr(V));

    V:=FLibrary.StopServer;
    Memo1.Lines.Add('StopServer = '+IntToStr(V));
    FillChar(Ar, SizeOf(Ar), 0);
    V:=FLibrary.GetLastError(@Ar);
    Memo1.Lines.Add('GetLastError = '+IntToStr(V));
  end;
  FLibrary.Free;
end;

end.

