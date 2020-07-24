unit IOUtils;

{$mode objfpc}{$H+}

interface

uses
  SysUtils;

type
  TPath = class
  public
    class function Combine(const Path1, Path2: string): string; inline; static;
  end;

implementation

class function TPath.Combine(const Path1, Path2: string): string;
begin
  Result := ConcatPaths([Path1, Path2]);
end;

end.

