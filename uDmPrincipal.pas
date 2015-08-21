unit uDmPrincipal;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls;

type
  TdmPrincipal = class(TDataModule)
    StyleBookRise: TStyleBook;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
  const
   CAMINHO_ARQUIVOS_MYDEED = '/storage/sdcard0/MyDeed';
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
end;

end.
