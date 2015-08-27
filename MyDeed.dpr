program MyDeed;

uses
  System.StartUpCopy,
  FMX.Forms,
  uDmPrincipal in 'uDmPrincipal.pas' {dmPrincipal: TDataModule},
  UfrmLogin in 'UfrmLogin.pas' {frmLogin},
  uFrmMensagens in 'uFrmMensagens.pas' {frmMensagens},
  uFrmRegister in 'uFrmRegister.pas' {frmRegister},
  uServico in 'Class\uServico.pas',
  uMensagem in 'Class\uMensagem.pas',
  uFrmNoticia in 'uFrmNoticia.pas' {frmNoticia},
  uFrmAcoes in 'uFrmAcoes.pas' {frmAcoes},
  uFrmFeed in 'uFrmFeed.pas' {frmFeed};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TfrmFeed, frmFeed);
  Application.Run;
end.
