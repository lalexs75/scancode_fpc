program mt_complex_demo;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  sysutils,
  rxlogging,

  Unit1,
  frmUsersAndRightUnit,
  scGlobal,
  frmStocksUnit;

{$R *.res}

procedure InitLocale;
begin
  //
  DefaultFormatSettings.LongDateFormat:='dd.mm.yyyy';
  DefaultFormatSettings.ShortDateFormat:=DefaultFormatSettings.LongDateFormat;
  DefaultFormatSettings.DateSeparator:='.';
  DefaultFormatSettings.TimeSeparator:=':';
  //ConvetToUTF8LocalConst;
  DefaultFormatSettings.ThousandSeparator:=' ';
  DefaultFormatSettings.CurrencyString:='р.';
end;

begin
  RequireDerivedFormResource:=True;

  OnRxLoggerEvent:=@MDefaultWriteLog;

  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

