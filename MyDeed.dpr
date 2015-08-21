program MyDeed;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFrmFormulario in 'uFrmFormulario.pas' {frmFormulario},
  UfrmLogin in 'UfrmLogin.pas' {frmLogin},
  uFrmPrincipal in 'uFrmPrincipal.pas' {frmPrincipal},
  uFrmRegister in 'uFrmRegister.pas' {frmRegister},
  uFrmServicos in 'uFrmServicos.pas' {frmServicos},
  uAcao in 'uAcao.pas',
  uDmPrincipal in 'uDmPrincipal.pas' {dmPrincipal: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);

  Application.Run;
end.
