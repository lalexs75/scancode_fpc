program mt_server_test;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  rxnew,
  rxlogging,
  mt_mainunit
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;

  //InitRxLogs;
  OnRxLoggerEvent:=@MDefaultWriteLog;

  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

