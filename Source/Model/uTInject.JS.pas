﻿{####################################################################################################################
                              TINJECT - Componente de comunicação (Não Oficial)
                                           www.tinject.com.br
                                            Novembro de 2019
####################################################################################################################
    Owner.....: Mike W. Lustosa            - mikelustosa@gmail.com   - +55 81 9.9630-2385
    Developer.: Joathan Theiller           - jtheiller@hotmail.com   -
                Robson André de Morais     - robinhodemorais@gmail.com

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


unit uTInject.JS;
//    https://htmlformatter.com/

interface

uses
  Classes, MaskUtils, DB,
  ExtCtrls, IdHTTP,
  uTInject.Classes, uCSV.Import, uTInject.Diversos;

{$M+}{$TYPEINFO ON}
{$I ..\TInjectDiretiva.inc}

type
    TInjectJSDefine  = class
    private
      FVersion_JS: String;
      FVersion_TInjectMin: String;
      FVersion_CEF4Min: String;
    public
      property   Version_JS         : String   read FVersion_JS;
      property   Version_TInjectMin : String   read FVersion_TInjectMin;
      property   Version_CEF4Min    : String   read FVersion_CEF4Min;
    end;



  TInjectJS  = class(TPersistent)
  private
    FAutoUpdate     : Boolean;
    FJSScript       : TstringList;
    FJSURL          : String;
    FJSVersion      : String;
    FReady          : Boolean;
    FOnUpdateJS     : TNotifyEvent;
    FInjectJSDefine : TInjectJSDefine;
    FAutoUpdateTimeOut   : Integer;
    FOnErrorInternal     : TOnErroInternal;
    Owner: TComponent;

    Function   ReadCSV(Const PLineCab, PLineValues: String): Boolean;
    procedure  SetInjectScript(const Value: TstringList);
    function   PegarLocalJS_Designer: String;
    function   PegarLocalJS_Web: String;
    Function   AtualizarInternamente(PForma: TFormaUpdate):Boolean;
    Function   ValidaJs(Const TValor: Tstrings): Boolean;
  protected
//    procedure Loaded; override;
  public
    constructor Create(POwner: TComponent);
    property    InjectJSDefine  : TInjectJSDefine Read FInjectJSDefine;
    property    OnErrorInternal : TOnErroInternal Read FOnErrorInternal  Write FOnErrorInternal;
    destructor  Destroy; override;
    Function    UpdateNow:Boolean;
    Procedure   DelFileTemp;
 published
    property   AutoUpdate         : Boolean   read FAutoUpdate           write FAutoUpdate          default True;
    property   AutoUpdateTimeOut  : Integer   Read FAutoUpdateTimeOut    Write FAutoUpdateTimeOut   Default 4;
    property   OnUpdateJS    : TNotifyEvent   Read FOnUpdateJS           Write FOnUpdateJS;
    property   Ready         : Boolean        read FReady;
    property   JSURL         : String         read FJSURL;
    property   JSScript      : TstringList    read FJSScript             Write SetInjectScript;
  end;


implementation

uses SysUtils, Dialogs, Windows, Forms,
     IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
     uTInject.Constant, uTInject.ExePath, uTInject.ConfigCEF;


{ TInjectAutoUpdate }

function TInjectJS.AtualizarInternamente(PForma: TFormaUpdate): Boolean;
var
  Ltmp: String;
begin
  try
    case pforma  of
      Tup_Local:Begin
                  Ltmp := GlobalCEFApp.PathJs;
                End;

      Tup_Web:  Begin
                  if (csDesigning in Owner.ComponentState) then
                     Ltmp := PegarLocalJS_Designer  Else   //Em modo Desenvolvimento
                     Ltmp := PegarLocalJS_Web;             //Rodando.. Pega na WEB
                end;
    end;

    if Ltmp = '' then
       Exit;

    if FileExists(Ltmp) then
    Begin
      //Valida a versao
      FJSScript.LoadFromFile(Ltmp);
      if not ValidaJs(FJSScript) then
      Begin
        FJSScript.Clear;
      End else
      Begin
        FJSVersion   := FInjectJSDefine.
           {$IFNDEF FPC}
             FVersion_JS;
           {$ELSE}
             Version_JS;
           {$ENDIF}
        if FJSVersion = '' then
           FJSScript.Clear;
      End;
    End;
  finally
    Result        := (FJSScript.Count >= TInjectJS_JSLinhasMInimas);
    if Result then
    begin
      //Atualzia o arquivo interno
      GlobalCEFApp.UpdateDateIniFile;
      if UpperCase(GlobalCEFApp.PathJs) <> UpperCase(Ltmp) then
         {$IFNDEF FPC}
           FJSScript.SaveToFile(GlobalCEFApp.PathJs, TEncoding.UTF8);
         {$ELSE}
           FJSScript.SaveToFile(GlobalCEFApp.PathJs);
         {$ENDIF}
      if Assigned(FOnUpdateJS) Then
         FOnUpdateJS(Self);
    end else
    begin
      FJSScript.Clear;
      FJSVersion := '';
    end;
  end;
end;

constructor TInjectJS.Create(POwner: TComponent);
begin
  Owner                      := POwner;
  FAutoUpdateTimeOut         := 10;
  FJSScript                  := TStringList.create;
  FAutoUpdate                := True;
  FJSURL                     := TInjectJS_JSUrlPadrao;
  FInjectJSDefine            := TInjectJSDefine.Create;
  FReady                     := False;
  UpdateNow;
end;

procedure TInjectJS.DelFileTemp;
begin
  {$IFNDEF FPC}
    DeleteFile(PwideChar(IncludeTrailingPathDelimiter(
      GetEnvironmentVariable('Temp'))+'GetTInject.tmp'));
  {$ELSE}
    DeleteFile(PChar(IncludeTrailingPathDelimiter(
      PChar(GetEnvironmentVariable('Temp','',0)))+PChar('GetTInject.tmp')));
  {$ENDIF}

end;

destructor TInjectJS.Destroy;
begin
  DelFileTemp;
  FreeAndNil(FInjectJSDefine);
  FreeAndNil(FJSScript);
  inherited;
end;

procedure TInjectJS.SetInjectScript(const Value: TstringList);
begin
  if (csDesigning in Owner.ComponentState) then
  Begin
    if Value.text <> FJSScript.text then
       raise Exception.Create(MSG_ExceptAlterDesigner);
  End;
  FJSScript := Value;
end;


function TInjectJS.UpdateNow: Boolean;
begin
  if FAutoUpdate  Then
  Begin
    //Atualiza pela Web  O retorno e o SUCESSO do que esta programado para trabalhar!!
    //Se nao obter sucesso da WEB.. ele vai usar o arquivo local..
    //Se estiver tudo ok.. ele esta PRONTO
    if ( GlobalCEFApp.PathJsOverdue = False) and (FileExists(GlobalCEFApp.PathJs)) Then
    Begin
      Result      := AtualizarInternamente(Tup_Local);
    End else
    Begin
      Result      := AtualizarInternamente(Tup_Web);
      If not Result Then
         Result      := AtualizarInternamente(Tup_Local);  //Se nao consegui ele pega o arquivo Local
    end;
  End else
  Begin
    //Usando via ARQUIVO
    Result      := AtualizarInternamente(Tup_Local);
  end;
  FReady        := (FJSScript.Count >= TInjectJS_JSLinhasMInimas);
end;

function TInjectJS.ValidaJs(const TValor: Tstrings): Boolean;
var
  LVersaoCefFull:String;
begin
  Result := False;
  if Assigned(GlobalCEFApp) then
  Begin
    if GlobalCEFApp.ErrorInt Then
       Exit;
  end;
  if (TValor.Count < TInjectJS_JSLinhasMInimas) then    //nao tem linhas suficiente
     Exit;

  If Pos(AnsiUpperCase(';'),  AnsiUpperCase(TValor.Strings[0])) <= 0 then   //Nao tem a variavel
     Exit;

  If not ReadCSV(TValor.Strings[0], TValor.Strings[1]) Then
     Exit;

  If (Pos(AnsiUpperCase('!window.Store'),       AnsiUpperCase(TValor.text))     <= 0) or
     (Pos(AnsiUpperCase('window.WAPI'),         AnsiUpperCase(TValor.text))     <= 0) or
     (Pos(AnsiUpperCase('window.Store.Chat.'),  AnsiUpperCase(TValor.text))     <= 0)  then
  Begin
     Exit;
  End Else
  Begin
    if not VerificaCompatibilidadeVersao(InjectJSDefine.FVersion_TInjectMin, TInjectVersion) then
    Begin
      if Assigned(GlobalCEFApp) then
         GlobalCEFApp.SetError;
      if Assigned(FOnErrorInternal) then
         Application.MessageBox({$IFNDEF FPC}PwideChar{$ELSE} PChar{$ENDIF}(MSG_ExceptConfigVersaoCompInvalida), {$IFNDEF FPC}PwideChar{$ELSE} PChar{$ENDIF}(Application.Title), MB_ICONERROR + mb_ok);
      exit;
    End;

    LVersaoCefFull :=  IntToStr(VersaoMinima_CF4_Major) + '.' + IntToStr(VersaoMinima_CF4_Minor) + '.' + IntToStr(VersaoMinima_CF4_Release);
    if not VerificaCompatibilidadeVersao(InjectJSDefine.FVersion_CEF4Min, LVersaoCefFull) then
    Begin
      if Assigned(GlobalCEFApp) then
         GlobalCEFApp.SetError;

      if Assigned(FOnErrorInternal) then
         Application.MessageBox({$IFNDEF FPC}PwideChar{$ELSE} PChar{$ENDIF}(MSG_ConfigCEF_ExceptVersaoErrada), {$IFNDEF FPC}PwideChar{$ELSE} PChar{$ENDIF}(Application.Title), MB_ICONERROR + mb_ok);
      exit;
    End;

    LogAdd('Versao TInject: ' + TInjectVersion);
    LogAdd('Versao  JS.ABR: ' + InjectJSDefine.FVersion_JS);
    LogAdd('Versao     CEF: ' + LVersaoCefFull);
    LogAdd(' ');
    Result := true;
  End;
end;

function TInjectJS.PegarLocalJS_Designer: String;
var
  LDados: TDadosApp;
begin
  try
    LDados  := TDadosApp.Create(Owner);
    try
      Result  := LDados.LocalProject;
    finally
      FreeAndNil(LDados);
    end;
  Except
    Result  := '';
  end;
end;


function TInjectJS.PegarLocalJS_Web: String;
var
  LHttp        : TUrlIndy;
  LSalvamento  : String;
  LRet         : TStringList;
begin
  LSalvamento   := IncludeTrailingPathDelimiter(
  {$IFNDEF FPC}
      GetEnvironmentVariable('Temp')+'GetTInject.tmp');
  {$ELSE}
      PChar(GetEnvironmentVariable('Temp','',0)+PChar('GetTInject.tmp')));
  {$ENDIF}

  LRet          := TStringList.Create;
  LHttp         := TUrlIndy.Create;
  try
    DeleteFile({$IFNDEF FPC}PwideChar{$ELSE} PChar{$ENDIF}(LSalvamento));
    LHttp.HTTPOptions := LHttp.HTTPOptions + [hoForceEncodeParams] ;
    LHttp.Request.Accept          := 'text/html, */*';
    LHttp.Request.ContentEncoding := 'raw';

    LHttp.TimeOut     := AutoUpdateTimeOut;
    if LHttp.GetUrl(TInjectJS_JSUrlPadrao) = true Then
    Begin
      LRet.LoadFromStream(LHttp.ReturnUrl);
      if not ValidaJs(LRet) Then
         LRet.Clear;
    End;
  finally
    FreeAndNil(LHttp);
    if LRet.Count > 1 then
    Begin
      if not FileExists(LSalvamento) then
      Begin
        LRet.
        {$IFNDEF FPC}
          SaveToFile(LSalvamento, TEncoding.UTF8);
        {$ELSE}
          SaveToFile(LSalvamento);
        {$ENDIF}
        Result := LSalvamento;
      End;
    End;
    FreeAndNil(LRet);
  end;
end;

function TInjectJS.ReadCSV(const PLineCab, PLineValues: String): Boolean;
var
  lCab,
  LIte: String;
  LCsv : TCSVImport;
begin
  Result := False;
  LCsv   := TCSVImport.Create;
  try
    lCab := Copy(PLineCab,    3, 5000);
    LIte := Copy(PLineValues, 3, 5000);
    try
      LCsv.ImportarCSV_viaTexto(lCab + slinebreak + LIte);
      if LCsv.Registros.RecordCount > 0 Then
      begin
        InjectJSDefine.FVersion_JS         := LCsv.Registros.FieldByName('Version_JS').AsString;
        InjectJSDefine.FVersion_TInjectMin := LCsv.Registros.FieldByName('Version_TInjectMin').AsString;
        InjectJSDefine.FVersion_CEF4Min    := LCsv.Registros.FieldByName('Version_CEF4Min').AsString;
        Result := true;
      end;
    Except
    end;
  finally
    FreeAndNil(LCsv);
  end;
end;


end.

