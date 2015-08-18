program HeaderFooterApplication;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  HeaderFooterTemplate in 'HeaderFooterTemplate.pas' {HeaderFooterForm},
  uFrmFormulario in 'uFrmFormulario.pas' {frmFormulario},
  uFrmServicos in 'uFrmServicos.pas' {frmServicos},
  uDmPrincipal in 'uDmPrincipal.pas' {dmPrincipal: TDataModule},
  UfrmLogin in 'UfrmLogin.pas' {frmLogin},
  uFrmRegister in 'uFrmRegister.pas' {frmRegister};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(THeaderFooterForm, HeaderFooterForm);
  Application.CreateForm(TfrmFormulario, frmFormulario);
  Application.CreateForm(TfrmServicos, frmServicos);
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmRegister, frmRegister);
  Application.Run;
end.
