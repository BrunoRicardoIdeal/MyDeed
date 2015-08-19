unit UfrmLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, FMX.Edit;

type
  TfrmLogin = class(TForm)
    edtLogin: TEdit;
    edtSenha: TEdit;
    btnLogin: TButton;
    btnRegister: TButton;
    lblEsqueciMinhaSenha: TLabel;
    lblMyDeed: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

procedure TfrmLogin.FormShow(Sender: TObject);
begin
 ShowMessage('SHOW');
end;

end.
