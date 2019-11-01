program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  rxnew,
  rxlogging,
  MainUnit
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;

  InitRxLogs;

  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

