{####################################################################################################################
                              TINJECT - Componente de comunicação (Não Oficial)
                                           www.tinject.com.br
                                            Novembro de 2019
####################################################################################################################
    Owner.....: Mike W. Lustosa            - mikelustosa@gmail.com   - +55 81 9.9630-2385
    Developer.: Joathan Theiller           - jtheiller@hotmail.com   -
                Daniel Oliveira Rodrigues  - Dor_poa@hotmail.com     - +55 51 9.9155-9228
####################################################################################################################
  Obs:
     - Código aberto a comunidade Delphi, desde que mantenha os dados dos autores e mantendo sempre o nome do IDEALIZADOR
       Mike W. Lustosa;
     - Colocar na evolução as Modificação juntamente com as informaçoes do colaborador: Data, Nova Versao, Autor;
     - Mantenha sempre a versao mais atual acima das demais;
     - Todo Commit ao repositório deverá ser declarado as mudança na UNIT e ainda o Incremento da Versão de
       compilação (último digito);

####################################################################################################################
                                  Evolução do Código
####################################################################################################################
  Autor........:
  Email........:
  Data.........:
  Identificador:
  Modificação..:
####################################################################################################################
}

unit uTInject.Diversos;

interface

uses
  {$IFDEF FPC}
    Classes,
    UITypes,
    ExtCtrls
  {$ELSE}
    System.Classes,
    System.UITypes,
    Vcl.ExtCtrls
  {$ENDIF};


function PrettyJSON(JsonString: String):String;
function CaractersWeb(vText: string): string;
function Convert_StrToBase64(vFile: string): string;
function Convert_StrToBase64Stream(Var vMemo: TMemoryStream): string;

function AjustNameFile(texto : String) : String;
Function Convert_Base64ToFile(Const PInBase64, FileSaveName: string):Boolean;
Procedure WarningDesenv(Pvalor:String);
Function  TrazApenasNumeros(PValor:String):String;


implementation

uses
  {$IFDEF FPC}
    fpjson,              //System.JSON,  //REST.Json,
    jsonscanner,
    jsonparser,
    Graphics, //Vcl.Imaging.pngimage, //Vcl.Imaging.GIFImg,
    Dialogs,
    Base64,// System.NetEncoding,
    SysUtils,
  {$ELSE}
    System.JSON,
    REST.Json,
    Vcl.Imaging.GIFImg,
    Vcl.Graphics,
    Vcl.Imaging.pngimage,
    Vcl.Dialogs,
    System.NetEncoding,
    System.SysUtils,
  {$ENDIF}
  uTInject.Constant;

Procedure WarningDesenv(Pvalor:String);
begin
  MessageDlg(PwideChar(MSG_WarningDeveloper + Chr(13) + Pvalor), mtWarning, [mbOk], 0);
end;

function PrettyJSON(JsonString: String):String;
var
  AObj: TJSONObject;
begin
  {$ifndef fpc}
    AObj   := TJSONObject.ParseJSONValue(JsonString) as TJSONObject;
    try
      result := TJSON.Format(AObj);
    finally
      AObj.Free;
    end;
  {$else}
    with TJSONParser.Create(JsonString, [joUTF8]) do
    try
      AObj := Parse as TJSONObject;
      Result:= AObj.FormatJSON();
    finally
      Free;
      AObj.Free;
    end;
  {$endif}
end;

Function Convert_Base64ToFile(Const PInBase64, FileSaveName: string): Boolean;
var
  LInput : TMemoryStream;
  LOutput: TMemoryStream;
  stl    : TStringList;
  {$ifdef fpc}
    VDecoder: TBase64DecodingStream;
  {$endif}
begin
  LInput  := TMemoryStream.Create;
  LOutput := TMemoryStream.Create;
  stl     := TStringList.Create;
  Result  := False;
  try
    try
      stl.Add(PInBase64);
      stl.SaveToStream(LInput);

      LInput.Position  := 0;
      if LInput.Size < 1 then
        Exit;
      {$ifdef delphi}
        TNetEncoding.Base64.Decode( LInput, LOutput );
      {$else}
        VDecoder := TBase64DecodingStream.Create(LInput, bdmMIME);
        LOutput.CopyFrom(VDecoder, VDecoder.Size);
      {$endif}
      if LOutput.Size < 1 then
         Exit;

      if FileSaveName <> '' then
      Begin
        DeleteFile(FileSaveName);
        If FileExists(FileSaveName) Then
           Exit; //nao conseguiu papagar!

        LOutput.Position := 0;
        LOutput.SaveToFile(FileSaveName);
      End;
    Except
    end;
  finally
    FreeAndNil(stl);
    FreeAndNil(LInput);
    FreeAndNil(LOutput);
    if FileSaveName <> '' then
      Result := FileExists(FileSaveName);
    {$ifdef fpc}
      FreeAndNil(VDecoder);
    {$endif}
  end;
end;

function Convert_StrToBase64(vFile: string): string;
var
  {$ifdef delphi}
    vFilestream: TMemoryStream;
    vBase64File: TBase64Encoding;
  {$endif}
  {$ifdef fpc}
    vFilestream: TFileStream;
    VStream: TStringStream;
  {$endif}
begin
  {$ifdef delphi}
    vBase64File := TBase64Encoding.Create;
    vFilestream := TMemoryStream.Create;
  {$else}
    vFilestream := TFileStream.Create(vFile, fmOpenRead or fmShareDenyWrite);
    VStream := TStringStream.Create('');
  {$endif}
  try
    {$ifdef delphi}
      vFilestream.LoadFromFile(vFile);
      result :=  vBase64File.EncodeBytesToString(vFilestream.Memory, vFilestream.Size);
    {$else}
      VStream := TStringStream.Create('');
      try
        with TBase64EncodingStream.Create(VStream) do
          try
            CopyFrom(vFilestream, vFilestream.Size);
          finally
            Free;
          end;
        Result := VStream.DataString;
      finally
        VStream.Free;
      end;
    {$endif}
  finally
    {$ifdef delphi}
      FreeAndNil(vBase64File);
    {$endif}
    FreeAndNil(vFilestream);
  end;
end;

function Convert_StrToBase64Stream(Var vMemo: TMemoryStream): string;
var
  {$ifdef delphi}
    vBase64File: TBase64Encoding;
  {$else}
    VDestStream: TStringStream;
  {$endif}
begin
  Result := '';
  try
    if vMemo.size = 0 then
       Exit;

    vMemo.Position := 0;
    {$ifdef delphi}
      vBase64File := TBase64Encoding.Create;
      try
        result :=  vBase64File.EncodeBytesToString(vMemo.Memory, vMemo.Size);
      finally
        FreeAndNil(vBase64File);
      end;
    {$else}
      VDestStream := TStringStream.Create('');
      try
        with TBase64EncodingStream.Create(VDestStream) do
          try
            CopyFrom(vMemo, vMemo.Size);
          finally
            Free;
          end;
        Result := VDestStream.DataString;
      finally
        VDestStream.Free;
      end;
    {$endif}
  Except
  end;
end;


function AjustNameFile(texto : String) : String;
Begin
  While pos('-', Texto) <> 0 Do
    delete(Texto,pos('-', Texto),1);
  While pos('+', Texto) <> 0 Do
    delete(Texto,pos('+', Texto),1);

  While pos('/', Texto) <> 0 Do
    delete(Texto,pos('/', Texto),1);
  While pos(',', Texto) <> 0 Do
    delete(Texto,pos(',', Texto),1);
  Result := Texto;
end;

Function  TrazApenasNumeros(PValor:String):String;
var
  LClearNum: String;
  i: Integer;
Begin
  Result := '';
  for I := 1 to Length(PValor) do
  begin
    if  (CharInSet(PValor[I] ,['0'..'9'])) Then
        LClearNum := LClearNum + PValor[I];
  end;
  Result := LClearNum;
End;

function CaractersWeb(vText: string): string;
begin
  vText  := StringReplace(vText, sLineBreak,'\n' , [rfReplaceAll] );
  vText  := StringReplace(vText, #13       ,''   , [rfReplaceAll] );
  vText  := StringReplace(vText, '"'       ,'\"' , [rfReplaceAll] );
  vText  := StringReplace(vText, #$A       ,''   , [rfReplaceAll] );
  Result := vText;
end;




end.
