program MyDeed;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFrmFormulario in 'uFrmFormulario.pas' {frmFormulario},
  UfrmLogin in 'UfrmLogin.pas' {frmLogin},
  uFrmPrincipal in 'uFrmPrincipal.pas' {frmPrincipal},
  uFrmRegister in 'uFrmRegister.pas' {frmRegister},
  uFrmServicos in 'uFrmServicos.pas' {frmServicos},
  uDmPrincipal in 'uDmPrincipal.pas' {dmPrincipal: TDataModule},
  uFrmMensagens in 'uFrmMensagens.pas' {frmMensagens},
  uAcao in 'Class\uAcao.pas',
  uMensagem in 'Class\uMensagem.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
