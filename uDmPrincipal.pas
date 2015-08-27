unit uDmPrincipal;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls;

type
  TdmPrincipal = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
   var
    CodUsuarioLogado : Integer;
    NomeUsuarioLogado : String;
    CAMINHO_ARQUIVOS_MYDEED : String;
    { Public declarations }
  end;

var
  dmPrincipal: TdmPrincipal;

implementation

uses
  FMX.Forms;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TdmPrincipal.DataModuleCreate(Sender: TObject);
begin
 {$IFDEF ANDROID}
  CAMINHO_ARQUIVOS_MYDEED := '/storage/sdcard0/MyDeed';
 {$ENDIF}
 {$IFDEF WIN32}
  CAMINHO_ARQUIVOS_MYDEED := 'c:/MyDeed';
 {$ENDIF}
 ForceDirectories(CAMINHO_ARQUIVOS_MYDEED);
end;

end.
