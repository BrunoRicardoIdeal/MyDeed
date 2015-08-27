unit UfrmLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, FMX.Edit, uDmPrincipal;

type
  TfrmLogin = class(TForm)
    edtLogin: TEdit;
    edtSenha: TEdit;
    btnLogin: TButton;
    pnlSuperior: TPanel;
    pnlBotoes: TPanel;
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
 dmPrincipal.NomeUsuarioLogado := edtLogin.Text;
end;

end.
