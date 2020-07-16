unit scGlobal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

var
  ExportFolder : string = '';
  DemoDataFolder : string = '';

procedure InitDemoFolders;
implementation
uses Forms, LazFileUtils;

procedure InitDemoFolders;
begin
  ExportFolder := AppendPathDelim(GetTempDir);
  DemoDataFolder := AppendPathDelim(ExtractFileDir(Application.ExeName)) + 'data' + PathDelim;
end;

end.

