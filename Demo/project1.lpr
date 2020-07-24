program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, u_principal, uTInject.ConfigCEF
  { you can add units after this };

{$R *.res}

begin
  {##########################################################################################
  Colocar arquivos CEFLib junto a pasta binária da aplicação (Nao definir ou passar vazio)
  Caso deseja informar.. segue exemplo abaixo
  ##########################################################################################}

//  GlobalCEFApp.PathLogFile          := '';
//  GlobalCEFApp.PathFrameworkDirPath := 'C:\Componentes\WhatsApp\Comp\BIN';
//  GlobalCEFApp.PathResourcesDirPath := 'C:\Componentes\WhatsApp\Comp\BIN';
//  GlobalCEFApp.PathLocalesDirPath   := 'C:\Componentes\WhatsApp\Comp\BIN\locales';
//  GlobalCEFApp.Pathcache            := 'C:\Componentes\WhatsApp\Comp\BIN\Cache';
//  GlobalCEFApp.PathUserDataPath     := 'C:\Componentes\WhatsApp\Comp\BIN\User Data';

  //Forma 1 GlobalCEFApp.Pathxx       := '';                      //Irá procura procurar o Arquivo PADRAO no mesmo local do EXE
  //Forma 2 GlobalCEFApp.Pathxx       := 'C:\Componentes\demo\bin'; //<-  NOME do ARQUIVO INFORMADO
  //Forma 3 GlobalCEFApp.Pathxx       := 'BIN';                     //<-  NOME do ARQUIVO INFORMADO
  //Forma 4 GlobalCEFApp.Pathx         := '..\Source\;              //<-  NOME do ARQUIVO INFORMADO
  //Exemplo se aplica para todos os PATH

  If not GlobalCEFApp.StartMainProcess then
     Exit;

  RequireDerivedFormResource:=True;
  Application.Title:='TInject';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.

