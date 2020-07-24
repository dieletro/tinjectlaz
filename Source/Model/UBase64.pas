{** Douglas Colombo
  * Classe de conversão de arquivos em texto
  * e de Texto em Arquivos, BASE64
**}

unit UBase64;

{$MODE Delphi}

interface

uses Classes,
     {$IfNDef FPC}
       jpeg, Winapi.Windows, Vcl.Graphics,
       System.netEncoding, System.SysUtils, FMX.Graphics
     {$else}
       sysutils, graphics, Base64
     {$EndIf};



//Type
  // tBase64 = class

   //public
     procedure Base64ToFile(Arquivo, caminhoSalvar : String);
     function Base64ToStream(imagem : String) : TMemoryStream;
     //function Base64ToBitmap(imagem : String) : TBitmap;
     function BitmapToBase64(imagem : TBitmap) : String;
     function FileToBase64(Arquivo : String) : String;
     function StreamToBase64(STream : TMemoryStream) : String;
//end;

implementation


//{ tBase64 }
//function tBase64.Base64ToBitmap(imagem: String): TBitmap;
//Var sTream : TMemoryStream;
//begin
//  if (trim(imagem) <> '') then
//  begin
//     Try
//        sTream := Base64ToStream(imagem);
//        result := TBitmap.CreateFromStream(sTream);
//     Finally
//        sTream.DisposeOf;
//        sTream := nil;
//     End;
//  end else
//  exit;
//end;

procedure Base64ToFile(Arquivo, caminhoSalvar : String);
Var sTream : TMemoryStream;
begin
  Try
    sTream := Base64ToStream(Arquivo);
    sTream.SaveToFile(caminhoSalvar);
  Finally
    sTream.free;
    sTream:=nil;
  End;
end;

function Base64ToStream(imagem: String): TMemoryStream;
var
    {$IFNDEF FPC}
      Base64 : TBase64Encoding;
    {$ELSE}
      Base64 : TBase64DecodingStream;
      VSrcStream: TStringStream;
    {$ENDIF}
     bytes : tBytes;
begin
  {$IFDEF FPC}
    VSrcStream := TStringStream.Create(imagem);
  {$ENDIF}
  Try
    {$IFNDEF FPC}
      Base64 := TBase64Encoding.Create;
      bytes  := Base64.DecodeStringToBytes(imagem);
      result := TBytesStream.Create(bytes);
    {$ELSE}
      Base64:= TBase64DecodingStream.Create(VSrcStream,bdmMIME);
      result.CopyFrom(Base64, Base64.Size);
    {$ENDIF}
    result.Seek(0, 0);
  Finally
    Base64.Free;
    Base64:=nil;
    SetLength(bytes, 0);
  End;
end;

function BitmapToBase64(imagem: TBitmap): String;
Var
  sTream : TMemoryStream;
  vEmpty : Boolean;
begin
  result := '';
  {$ifndef fpc}
    vEmpty:= imagem.isEmpty;
  {$else}
    vEmpty:= imagem.Empty;
  {$endif}

  if not vEmpty then
  begin
     Try
        sTream := TMemoryStream.Create;
        imagem.SaveToStream(sTream);
        result := StreamToBase64(sTream);
        {$ifndef fpc}
          sTream.DisposeOf;
        {$else}
          sTream.Clear;
        {$endif}
        sTream := nil;
     Except End;
  end;
end;

function FileToBase64(Arquivo : String): String;
Var sTream : tMemoryStream;
begin
  sTream := TMemoryStream.Create;
  Try
    sTream.LoadFromFile(Arquivo);
    result := StreamToBase64(sTream);
  Finally
    Stream.Free;
    Stream:=nil;
  End;
end;

function StreamToBase64(STream: TMemoryStream): String;
Var
  {$IFNDEF FPC}
    Base64 : TBase64Encoding;
  {$else}
    Base64 : TBase64EncodingStream;
    VDestStream: TStringStream;
  {$endif}
begin
  {$IFDEF FPC}
    VDestStream := TStringStream.Create('');
  {$ENDIF}
  Try
    Stream.Seek(0, 0);
    {$IFNDEF FPC}
      Base64 := TBase64Encoding.Create;
      Result := Base64.EncodeBytesToString(sTream.Memory, sTream.Size);
    {$else}
      Base64 := TBase64EncodingStream.Create(VDestStream);
      Base64.CopyFrom(STream, STream.Size);
      Result := VDestStream.DataString;
    {$endif}
  Finally
    Base64.Free;
    Base64:=nil;
    {$IFDEF FPC}
      VDestStream.free;
      VDestStream:= nil;
    {$endif}
  End;
end;

end.
