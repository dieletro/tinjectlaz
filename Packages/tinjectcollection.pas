{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit TInjectCollection;

{$warn 5023 off : no warning about unused units}
interface

uses
  UBase64, uCSV.Import, uInjectDecryptFile, uTInject.AdjustNumber, 
  uTInject.Classes, uTInject.Config, uTInject.Constant, uTInject.Diversos, 
  uTInject.Emoticons, uTInject.ExePath, uTInject.JS, uTInject.ConfigCEF, 
  uTInject.languages, uTInject, uTInject.Console, uTInject.FrmConfigNetWork, 
  uTInject.FrmQRCode, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('uTInject', @uTInject.Register);
end;

initialization
  RegisterPackage('TInjectCollection', @Register);
end.
