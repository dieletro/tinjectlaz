{####################################################################################################################
    Owner.....: Daniel Oliveira Rodrigues  - Dor_poa@hotmail.com     - +55 51 9.9155-9228
####################################################################################################################
  Obs:
     - Código aberto a comunidade Delphi, desde que mantenha os dados dos autores;
       DANIEL OLIVEIRA RODRIGUES
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



unit UCSV.Import;

interface

uses
  {$IFDEF FPC}
    Classes,
    ExtCtrls,
    SysUtils,
    BufDataset,
    db
  {$ELSE}
    System.Classes,
    Vcl.ExtCtrls,
    System.SysUtils,
    Data.DB,
    FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
    FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
    FireDAC.Comp.DataSet, FireDAC.Comp.Client
  {$ENDIF}
  ;

Const
  TamPdr = 100;

Type
  TCSVImport = Class
  Private
    FStringList: TStringList;
    FRegistros       : {$IFNDEF FPC}TFDMemTable{$ELSE} TBufDataset{TMemDataset}{TZTable}{$ENDIF};
    FSeparador : Char;
    Procedure ZerarTudo;
    Function  CriarCampos: Boolean;
    Function  CriarValor(PLinha:WideString): Boolean;
    Function  ProcessarCriacaoCSV:Boolean;
  Public
    constructor Create;
    destructor  Destroy; OverRide;

    Function  ImportarCSV_viaArquivo  (PArquivo:String):Boolean;
    Function  ImportarCSV_viaTexto    (PConteudo:WideString):Boolean;

    Property  Registros:  {$IFNDEF FPC}TFDMemTable{$ELSE} TBufDataset{TMemDataset}{TZTable}{$ENDIF} Read FRegistros;
    Property  Separador : Char        Read FSeparador               Write FSeparador;
  End;


implementation

uses
  {$IFNDEF FPC}Vcl.Dialogs{$ELSE} Dialogs{$ENDIF};

{ TCSVImport }

constructor TCSVImport.Create;
begin
  FSeparador := ';';
  ZerarTudo;
end;

function TCSVImport.CriarCampos: Boolean;
Var
  Lok    : Integer;
  Linha0 : {$IFNDEF FPC}PwideChar{$ELSE} PChar{$ENDIF};
  LCampo : String;
  LRetorno: TStringList;
  I: Integer;
begin
  Result := False;
  LRetorno := TStringList.Create;
  {$IFNDEF FPC}FRegistros.FieldOptions.AutoCreateMode := acCombineComputed;{$ENDIF}
  try
    Linha0 := {$IFNDEF FPC}PwideChar{$ELSE} PChar{$ENDIF}(FStringList.Strings[0]);
    Lok    := ExtractStrings([FSeparador],[' '], Linha0, LRetorno);
    try
      if Lok > 0 then
      Begin
        for I := 0 to LRetorno.Count -1 do
        Begin
          LCampo := LRetorno.Strings[i];
          {$IFNDEF FPC}
            FRegistros.FieldDefs.Add(LCampo,     ftString,      TamPdr, False);
          {$ELSE}
            FRegistros.FieldDefs.Add(LCampo,     ftString,      TamPdr, False);
          {$ENDIF}
        End;
        FRegistros.CreateDataSet;
        Result := True;
      End;
    Except
      Result := False;
    end;
  finally
    FreeAndNil(LRetorno);
  end;
end;

function TCSVImport.CriarValor(PLinha: WideString): Boolean;
Var
  Lok    : Integer;
  Linha  : {$IFNDEF FPC}PwideChar{$ELSE} PChar{$ENDIF};
  LConteudoCampo: WideString;
  LRetorno: TStringList;
  I: Integer;
begin
  Result := False;
  LRetorno := TStringList.Create;
  try
    while ( Pos((FSeparador + FSeparador), String(Plinha))> 0) do
    Begin
      PLinha  := StringReplace(PLinha, (FSeparador + FSeparador), (FSeparador + ' ' + FSeparador), [rfReplaceAll, rfIgnoreCase]);
    End;

    Linha   := {$IFNDEF FPC}PwideChar{$ELSE} PChar{$ENDIF}(PLinha);
    Lok     := ExtractStrings([FSeparador],[], Linha, LRetorno);
    try
      if Lok > 0 then
      Begin
        FRegistros.Append;
        for I := 0 to LRetorno.Count -1 do
        Begin
          LConteudoCampo:= Trim(LRetorno.Strings[i]);
          if i <= FRegistros.Fields.Count -1 then
             FRegistros.Fields[i].AsString := LConteudoCampo;
        End;
        FRegistros.post;
        Result := True;
      End;
    Except
     on E : Exception do
     Begin
       LConteudoCampo := e.Message;
       if FRegistros.State = dsInsert then
           FRegistros.Cancel;
        Result := False;
     End;
    end;
  finally
    FreeAndNil(LRetorno);
  end;

end;

destructor TCSVImport.Destroy;
begin
  FreeAndNil(FStringList);
  FreeAndNil(FRegistros);
  inherited;
end;

function TCSVImport.ImportarCSV_viaArquivo(PArquivo: String): Boolean;
begin
  ZerarTudo;
  Result := False;
  if not FileExists(PArquivo) then
    Exit;

  FStringList.LoadFromFile(PArquivo);
  Result := ProcessarCriacaoCSV;
end;

function TCSVImport.ImportarCSV_viaTexto(PConteudo: WideString): Boolean;
begin
  ZerarTudo;
  FStringList.Text := PConteudo;
  Result           := ProcessarCriacaoCSV;
end;

function TCSVImport.ProcessarCriacaoCSV: Boolean;
var
  I: Integer;
begin
  Result := False;
  if FStringList.Count < 1 then
     Exit;

  if not CriarCampos then
     Exit;

  for I := 1 to FStringList.Count - 1 do
  Begin
    if not CriarValor(FStringList.Strings[i]) then
    Begin
      ZerarTudo;
      Exit;
    End;
  End;
  Result := True;
end;

procedure TCSVImport.ZerarTudo;
begin
  FreeAndNil(FStringList);
  FreeAndNil(FRegistros);

  FStringList      := TStringList.Create;
  FRegistros       := {$IFNDEF FPC}TFDMemTable{$ELSE} TBufDataset{TMemDataset}{TZTable}{$ENDIF}.Create(nil);
end;

end.
