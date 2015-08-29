unit uDmPrincipal;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet,
   FireDAC.Comp.UI,
   FMX.Forms, FMX.Platform, FMX.VirtualKeyboard, FireDAC.FMXUI.Wait;

type
  TdmPrincipal = class(TDataModule)
    SQLiteConn: TFDConnection;
    qryNoticiasFeed: TFDQuery;
    qryAcoesNoticias: TFDQuery;
    qryNoticiasFeedID: TFDAutoIncField;
    qryNoticiasFeedCOD_NOTICIA: TIntegerField;
    qryNoticiasFeedAUTOR: TStringField;
    qryNoticiasFeedDESCRICAO: TStringField;
    qryNoticiasFeedDT_POSTAGEM: TDateTimeField;
    qryNoticiasFeedDT_CHEGADA: TDateTimeField;
    qryNoticiasFeedDT_SAIDA: TDateTimeField;
    qryNoticiasFeedEQUIPAMENTO: TStringField;
    qryNoticiasFeedOBSERVACAO: TWideStringField;
    qryAcoesNoticiasID: TFDAutoIncField;
    qryAcoesNoticiasCOD_NOTICIA: TIntegerField;
    qryAcoesNoticiasDESCRICAO: TStringField;
    qryNoticiasFeedCLIENTE: TStringField;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
   var
    CodUsuarioLogado : Integer;
    NomeUsuarioLogado : String;

 {$IFDEF ANDROID}
  const
   CAMINHO_ARQUIVOS_MYDEED = '/storage/sdcard0/MyDeed';
   CAMINHOBD = '/storage/sdcard0/MyDeed/MyDeedDB.db';
 {$ENDIF}
 {$IFDEF WIN32}
  const
   CAMINHO_ARQUIVOS_MYDEED = 'c:/MyDeed';
   CAMINHOBD = 'D:\Projetos\MyDeed\MyDeed\BD\MyDeedDB.db';
 {$ENDIF}
    { Public declarations }

  end;

var
  dmPrincipal: TdmPrincipal;

implementation



{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TdmPrincipal.DataModuleCreate(Sender: TObject);
begin

 ForceDirectories(CAMINHO_ARQUIVOS_MYDEED);
 SQLiteConn.Params.Clear;
 SQLiteConn.Params.Database := CAMINHOBD;
 SQLiteConn.Params.Add('Database=' + CAMINHOBD);
 SQLiteConn.Params.Add('DriverID=SQLite');
 SQLiteConn.Params.Add('FailIfMissing=False');
 SQLiteConn.Connected := True;

end;

end.
